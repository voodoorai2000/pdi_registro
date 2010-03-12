Dado /^que estamos a dia de hoy$/ do
end

Dado /^que estamos un dia en el pasado$/ do
  Delorean.time_travel_to "1 day ago"
end

Dado /^que estamos una semana en el pasado$/ do
  Delorean.time_travel_to "1 week ago"
end

Dado /^volvemos al presente$/ do
  Delorean.back_to_the_present
end