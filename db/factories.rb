Factory.define :user do |f|
  f.sequence(:name) { |n| "name#{n}" }
  f.sequence(:login) { |n| "foo#{n}" }
  f.password "secret"
  f.password_confirmation { |u| u.password }
  f.sequence(:email) { |n| "foo#{n}@example.com" }
end

Factory.define :region do |f|
  f.sequence(:name) { |n| "name#{n}" }
end