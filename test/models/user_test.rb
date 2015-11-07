require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", 
                    password_confirmation: "foobar")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
#-----------------------------------
#-------------name tests------------
#-----------------------------------  
  
  test "name should be present" do
    @user.name = "         "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
#-----------------------------------
#------------email tests------------
#-----------------------------------

  test "email should be present" do
    @user.email = "        "
    assert_not @user.valid?
  end  
  
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do 
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid? "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup # creates a duplicate user with the same attributes
    duplicate_user.email = @user.email.upcase # tests this with case_sensitive option in uniqueness validation
    @user.save # since it's saved, it should be an e-mail that already exists in database
    assert_not duplicate_user.valid?
  end
  
#-----------------------------------
#-----------password tests----------
#-----------------------------------  
  
  test "password should be present (nonblank)" do
    password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  
  test "passwould should have a minimum length of 6" do
    password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
end
