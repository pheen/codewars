class Hash
  def flattened_keys(parent_key = nil, result = {})
    self.each do |key, value|
      if value.is_a?(Hash)
        inherited_key = strymbol(parent_key, key)
        value.flattened_keys(inherited_key, result)
      else
        result[strymbol(parent_key, key)] = value
      end
    end

    result
  end

private

  def strymbol(*arr)
    key = arr.compact.join('_')

    if arr.map { |v| v.is_a?(String) }.include?(true)
      key
    else
      key.to_sym
    end
  end
end
