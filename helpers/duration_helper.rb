# helper module for duration calculations
module DurationHelper
  def pretty(duration)
    dur_array = duration.round.divmod(60)
    minutes = dur_array.first
    seconds = dur_array.last < 10 ? "0#{dur_array.last}" : dur_array.last
    "0:#{minutes}:#{seconds}"
  end
end
