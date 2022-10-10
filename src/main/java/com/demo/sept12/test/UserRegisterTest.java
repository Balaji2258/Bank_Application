package com.demo.sept12.test;

import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.assertThrows;


import org.junit.jupiter.api.Test;

import com.demo.sept12.exceptions.EmailNotNullException;
import com.demo.sept12.exceptions.ExistingEmailException;
import com.demo.sept12.exceptions.ExistingNameException;
import com.demo.sept12.exceptions.ExistingPhoneException;
import com.demo.sept12.exceptions.InsufficientBalanceException;
import com.demo.sept12.exceptions.InvalidEmailException;
import com.demo.sept12.exceptions.InvalidPhoneException;
import com.demo.sept12.exceptions.PasswordNotNullException;
import com.demo.sept12.exceptions.PasswordsDoNotMatchException;
import com.demo.sept12.exceptions.PhoneNotNullException;
import com.demo.sept12.exceptions.RegisterValidator;
import com.demo.sept12.exceptions.UserNameNotNullException;

public class UserRegisterTest {
	
//	User user;
//	
//	@BeforeEach
//	public void setUp() {
//		user = new User();
//	}
//	
//	user.setFullName("Balaji B S");
//	user.setUserName("Balaji1");
//	user.setPassword("balaji.bs@123");
//	user.setRePassword("balaji.bs@123");
//	user.setAccType("savings");
//	user.setAmount(1500);
//	user.setAddress("Andaman");
//	user.setPhone(9632587416L);
//	user.setEmail("balaji.bs@gmail.com");
//	user.setAccNo(123456789);

	@Test
	public void userNameNullTest() {
		Exception e = assertThrows(UserNameNotNullException.class, () ->
			RegisterValidator.checkUserName("")
		);
		
		String expectedMessage = "Username cannot be empty!";
		String actualMessage = e.getMessage();
		assertTrue(expectedMessage.contains(actualMessage));
	}
	
	@Test
	public void userNameTakenTest() {
		Exception e = assertThrows(ExistingNameException.class, () ->
			RegisterValidator.checkUserName("Balaji1")
		);
		
		String expectedMessage = "Username taken! Use a different username!";
		String actualMessage = e.getMessage();
		assertTrue(expectedMessage.contains(actualMessage));
	}
	
	@Test
	public void passwordNullTest() {
		Exception e = assertThrows(PasswordNotNullException.class, () ->
			RegisterValidator.checkPassword("")
		);
		
		String expectedMessage = "Password cannot be empty!";
		String actualMessage = e.getMessage();
		assertTrue(expectedMessage.contains(actualMessage));
	}
	
	@Test
	public void rePasswordNullTest() {
		Exception e = assertThrows(PasswordNotNullException.class, () ->
			RegisterValidator.checkConfirmPassword("")
		);
		
		String expectedMessage = "Confirm password cannot be empty!";
		String actualMessage = e.getMessage();
		assertTrue(expectedMessage.contains(actualMessage));
	}
	
	@Test
	public void passwordsMatchTest() {
		Exception e = assertThrows(PasswordsDoNotMatchException.class, () ->
			RegisterValidator.checkPasswordMatch("balaji@123", "balaji1@123")
		);
		
		String expectedMessage = "Passwords do not match!";
		String actualMessage = e.getMessage();
		assertTrue(expectedMessage.contains(actualMessage));
	}
	
	@Test
	public void minimumDepositTest() {
		Exception e = assertThrows(InsufficientBalanceException.class, () ->
			RegisterValidator.checkInsufficientBalance("savings", 800)
		);
		
		String expectedMessage = "Minimum deposit for a savings account is ₹1000.0";
		String actualMessage = e.getMessage();
		assertTrue(expectedMessage.contains(actualMessage));
	}
	
	@Test
	public void phoneNullTest() {
		Exception e = assertThrows(PhoneNotNullException.class, () ->
			RegisterValidator.checkPhone("")
		);
		
		String expectedMessage = "Phone number cannot be empty";
		String actualMessage = e.getMessage();
		assertTrue(expectedMessage.contains(actualMessage));
	}
	
	@Test
	public void validPhoneTest() {
		Exception e = assertThrows(InvalidPhoneException.class, () ->
			RegisterValidator.checkPhone("920623ks53")
		);
		
		String expectedMessage = "Phone number must contain only digits!";
		String actualMessage = e.getMessage();
		assertTrue(expectedMessage.contains(actualMessage));
	}
	
	@Test
	public void phoneTakenTest() {
		Exception e = assertThrows(ExistingPhoneException.class, () ->
			RegisterValidator.checkPhone("9880682403")
		);
		
		String expectedMessage = "Phone number already in use for a different account!";
		String actualMessage = e.getMessage();
		assertTrue(expectedMessage.contains(actualMessage));
	}
	
	@Test
	public void emailNullTest() {
		Exception e = assertThrows(EmailNotNullException.class, () ->
			RegisterValidator.checkEmail("")
		);
		
		String expectedMessage = "Email cannot be empty!";
		String actualMessage = e.getMessage();
		assertTrue(expectedMessage.contains(actualMessage));
	}
	
	@Test
	public void validEmailTest() {
		Exception e = assertThrows(InvalidEmailException.class, () ->
			RegisterValidator.checkEmail("sheshasaibalaji@.com")
		);
		
		String expectedMessage = "Email ID is invalid!";
		String actualMessage = e.getMessage();
		assertTrue(expectedMessage.contains(actualMessage));
	}
	
	@Test
	public void emailTakenTest() {
		Exception e = assertThrows(ExistingEmailException.class, () ->
			RegisterValidator.checkEmail("sheshasaibalaji@gmail.com")
		);
		
		String expectedMessage = "Email ID already in use for a different account!";
		String actualMessage = e.getMessage();
		assertTrue(expectedMessage.contains(actualMessage));
	}
	
}
