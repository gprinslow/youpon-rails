#factory for user model
Factory.define :user do |user|
	user.name                   "Autotest 02"
	user.email									"autotest02@example.com"
	user.password								"foobar"
	user.password_confirmation	"foobar"
end

Factory.sequence :name do |n|
  "Autotest Person-#{n}"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :offer do |offer|
  offer.title   "auto"
  offer.byline  "auto"
  offer.category  "testing"
  offer.discount  "auto"
  offer.description "auto"
  offer.terms "auto"
  offer.start Time.now
  offer.end Time.now
  offer.number_offered 10
  offer.validation_required false
end

Factory.sequence :title do |n|
  "autooffer-#{n}"
end

Factory.sequence :category do |n|
  "testing-#{n}"
end