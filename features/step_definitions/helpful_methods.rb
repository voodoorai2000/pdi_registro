def split_and_strip(text, separator=",")
  text ? text.gsub(" y ", separator).split(separator).map(&:strip) : []
end
