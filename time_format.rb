class TimeFormat
  
  TIME_FORMATS = {
                    year:   '%Y',
                    month:  '%m',
                    day:    '%d',
                    hour:   '%H',
                    minute: '%M',
                    second: '%S'
                 }.freeze

  attr_reader :wrong_format
  
  def initialize(params)
    @params = params['format'].split(',')
    @wrong_format = @params - TIME_FORMATS.keys.map(&:to_s)
  end
  
  def check_format
    good_format = []
    @params.each { |format| good_format << TIME_FORMATS[format.to_sym] }
    good_format.join('-')
  end

  def good_format?
    @wrong_format.empty?
  end

  def result
    Time.now.strftime(check_format)
  end
end
