package com.demo.sept12.exceptions;

import java.sql.SQLException;

import com.demo.sept12.dao.UserDao;

public class RegisterValidator {
	
	public static void checkUserName(String userName) throws UserNameNotNullException, ExistingNameException, SQLException {
		if(userName == "" || userName == null) {
			throw new UserNameNotNullException("Username cannot be empty!");
		}
		if(UserDao.checkUserExists(userName)) {
			throw new ExistingNameException("Username taken! Use a different username!");
		}
	}
	
	public static void checkPassword(String password) throws PasswordNotNullException {
		if(password == "" || password == null) {
			throw new PasswordNotNullException("Password cannot be empty!");
		}
	}
	
	public static void checkConfirmPassword(String confPass) throws PasswordNotNullException {
		if(confPass == "" || confPass == null) {
			throw new PasswordNotNullException("Confirm password cannot be empty!");
		}
	}
	
	public static void checkPasswordMatch(String pass, String confPass) throws PasswordsDoNotMatchException {
		if(!pass.equals(confPass)) {
			throw new PasswordsDoNotMatchException("Passwords do not match!");
		}
	}
	
	public static void checkAccType(String accType) throws AccTypeNotNullException {
		if(accType == "" || accType == "#" || accType == null) {
			throw new AccTypeNotNullException("Account Type not selected!");
		}
	}
	
	public static void checkBalance(String bal) throws BalanceNotNullException {
		if(bal == "" || bal == null) {
			throw new BalanceNotNullException("Initial deposit cannot be empty!");
		}
	}
	
	public static void checkInsufficientBalance(String accType, double bal) throws InsufficientBalanceException {
		if(accType.equalsIgnoreCase("savings") && bal < 1000.0) {
			throw new InsufficientBalanceException("Minimum deposit for a savings account is ₹1000.0");
		}
		if(accType.equalsIgnoreCase("current") && bal < 2500.0) {
			throw new InsufficientBalanceException("Minimum deposit for a savings account is ₹2500.0");
		}
	}
	
	public static void checkPhone(String phone) throws PhoneNotNullException, InvalidPhoneException, ExistingPhoneException, NumberFormatException, SQLException {
		if(phone == "" || phone == null) {
			throw new PhoneNotNullException("Phone number cannot be empty");
		}
		if(!phone.matches("^\\d{10}$")) {
			throw new InvalidPhoneException("Phone number must contain only digits!");
		}
		if(UserDao.checkPhoneExists(Long.parseLong(phone))) {
			throw new ExistingPhoneException("Phone number already in use for a different account!");
		}
	}
	
	public static void checkEmail(String email) throws EmailNotNullException, InvalidEmailException, ExistingEmailException, SQLException {
		if(email == "" || email == null) {
			throw new EmailNotNullException("Email cannot be empty!");
		}
		if(!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
			throw new InvalidEmailException("Email ID is invalid!");
		}
		if(UserDao.checkEmailExists(email)) {
			throw new ExistingEmailException("Email ID already in use for a different account!");
		}
	}
}
