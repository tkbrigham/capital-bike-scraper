class ApiStationElement
  def initialize(element)
    @element = element
  end

  def attributes_for(model)
    attributes = {}
    model.attribute_names.each do |attr|
      val = @element.css(FieldConverter.native_field(attr)).text
      if datetime_fields.include?(attr)
        attributes[attr.to_sym] = datetime_format(val)
      else
        attributes[attr.to_sym] = val
      end
    end

    attributes.merge!(scrape_timestamp: Time.now) if model == StationStat
    attributes.except(:id, :created_at, :updated_at)
  end

  def datetime_format(unix_timestamp)
    return nil if unix_timestamp.blank? || unix_timestamp.to_i.zero?
    Time.at(unix_timestamp.to_s[0..9].to_i)
  end

  def datetime_fields
    ['last_comm_with_server', 'install_date', 'removal_date','cb_latest_update_time']
  end

  def update_data
    station = Station.find_or_initialize_by(cb_id: attributes_for(Station)[:cb_id])
    station.update!(attributes_for(Station))
    station_stat = StationStat.new(attributes_for(StationStat))
    station_stat.save
  end
end
