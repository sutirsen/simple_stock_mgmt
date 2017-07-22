class DatePrecedenceValidator < ActiveModel::Validator
  def validate(record)
    startDate = record.send(options[:fields][0].to_s)
    endDate = record.send(options[:fields][1].to_s)
    if startDate.class.to_s != 'Date'
      startDate = Date.strptime(startDate, '%Y-%m-%d')
    end

    if endDate.class.to_s != 'Date'
      endDate = Date.strptime(endDate, '%Y-%m-%d')
    end

    record.errors[options[:fields][0]] << " can not be before end date" unless startDate <= endDate
  end
end
