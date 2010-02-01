def split_and_strip(text, separator=",")
  text ? text.gsub(" y a ", ",").gsub(" y ",",").gsub(" e ", ",").split(separator).map(&:strip) : []
end
