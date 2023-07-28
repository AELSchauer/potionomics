module TableHelper
  def sort_string_to_hash(sort_str)
    (sort_str || "").split(",").inject({}) do |hash, str|
      key, val = str.split(" ")
      hash[key] = val
      hash
    end
  end

  def sort_hash_to_string(sort_hash)
    sort_hash
      .map { |key, val| "#{key} #{val}" }
      .join(",")
  end

  def sort_direction(direction)
    direction == "asc" ? "desc" : "asc"
  end

  def filter_include?(attr_name, val)
    return true if session.dig("filter", attr_name).nil?
    session.dig("filter", attr_name, val.to_s).present?
  end

  def heatmap_value(arr, val, inverse = false)
    if inverse
      hex1 = [173, 209, 158]
      hex2 = [255, 225, 142]
      hex3 = [231, 142, 142]
    else
      hex1 = [231, 142, 142]
      hex2 = [255, 225, 142]
      hex3 = [173, 209, 158]
    end
      
    max = arr.max
    min = [arr.min, 0].max
    adj = (val - min) / (max - min).to_f

    if adj.nan?
      "#fff"
    elsif val < 0
      "#ea3423"
    elsif adj == 0.5
      sprintf("#%02X%02X%02X" % hex2)
    else
      if adj < 0.5
        min_hex = hex1
        max_hex = hex2
        adj = adj / 0.5
      elsif adj > 0.5
        adj = (adj - 0.5) / 0.5
        min_hex = hex2
        max_hex = hex3
      end

      new_hex = []
      3.times do |i|
        new_hex << ((max_hex[i] - min_hex[i]) * adj) + min_hex[i]
      end

      sprintf("#%02X%02X%02X" % new_hex)
    end
  end
end
