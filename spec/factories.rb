#factory for user model
Factory.define :user do |user|
	user.name                   "Autotest 02"
	user.email									"autotest02@example.com"
	user.password								"foobar"
	user.password_confirmation	"foobar"
end