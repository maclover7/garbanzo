module Garbanzo
  class Router
    class Compiler
      def compile_path(path)
        keys = []

        # Split the path into pieces in between forward slashes.
        segments = path.split('/', -1).map! do |segment|
          ignore = []

          # Special character handling.
          special_character_regex = /[^\?\%\\\/\:\*\w]|:(?!\w)/

          pattern = segment.to_str.gsub(special_character_regex) do |c|
            ignore << escaped(c).join if c.match(/[\.@]/)
            patt = encoded(c)
            patt.gsub(/%[\da-fA-F]{2}/) do |match|
              match.split(//).map! { |char| char =~ /[A-Z]/ ? "[#{char}#{char.tr('A-Z', 'a-z')}]" : char }.join
            end
          end

          ignore = ignore.uniq.join

          # Key handling.
          pattern.gsub(/((:\w+)|\*)/) do |match|
            if match == '*'
              keys << 'splat'
              '(.*?)'
            else
              # keys << $2[1..-1]
              keys << Regexp.last_match[1][1..-1]
              ignore_pattern = safe_ignore(ignore)

              ignore_pattern
            end
          end
        end

        [/\A#{segments.join('/')}\z/, keys]
      end

      def safe_ignore(ignore)
        unsafe_ignore = []
        ignore = ignore.gsub(/%[\da-fA-F]{2}/) do |hex|
          unsafe_ignore << hex[1..2]
          ''
        end
        unsafe_patterns = unsafe_ignore.map! do |unsafe|
          chars = unsafe.split(//).map! do |char|
            char <<= char.tr('A-Z', 'a-z') if char =~ /[A-Z]/
            char
          end

          "|(?:%[^#{chars[0]}].|%[#{chars[0]}][^#{chars[1]}])"
        end
        if unsafe_patterns.length > 0
          "((?:[^#{ignore}/?#%]#{unsafe_patterns.join})+)"
        else
          "([^#{ignore}/?#]+)"
        end
      end
    end
  end
end
