def format_duration(seconds)
  SecondsFormatter.print(seconds.to_i)
end

class SecondsFormatter
  METHODS = {
    year:   31536000,
    day:    86400,
    hour:   3600,
    minute: 60,
    second: 1
  }

  class << self
    def print(seconds)
      return 'now' if seconds.zero?

      seconds_left = seconds
      strings = METHODS.keys.map do |name|
        format(name, seconds_left) do |seconds_used|
          seconds_left -= seconds_used
        end
      end.compact

      if strings.count > 1
        [
          strings[0..-2].join(', '),
          strings[-1]
        ].join(' and ')
      else
        strings[0]
      end
    end

    def format(name, seconds)
      unit_in_seconds = METHODS[name]
      amount = seconds / unit_in_seconds
      label = pluralize(name, amount)

      if amount > 0
        if block_given?
          yield amount * unit_in_seconds
        end

        "#{amount} #{label}"
      end
    end

    def pluralize(label, n)
      n > 1 ? "#{label}s" : label
    end
  end
end

Test.assert_equals(format_duration(1), "1 second")
Test.assert_equals(format_duration(62), "1 minute and 2 seconds")
Test.assert_equals(format_duration(120), "2 minutes")
Test.assert_equals(format_duration(3600), "1 hour")
Test.assert_equals(format_duration(3662), "1 hour, 1 minute and 2 seconds")
