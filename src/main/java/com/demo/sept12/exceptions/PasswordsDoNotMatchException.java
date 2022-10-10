package com.demo.sept12.exceptions;

public class PasswordsDoNotMatchException extends Exception {
	
	public PasswordsDoNotMatchException(String exp) {
		super(exp);
	}

}
