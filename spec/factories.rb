#factory for user model
Factory.define :user do |user|
	user.email									"test@example.com"
	user.password								"foobar"
	user.password_confirmation	"foobar"
end