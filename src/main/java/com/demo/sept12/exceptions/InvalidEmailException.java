package com.demo.sept12.exceptions;

public class InvalidEmailException extends Exception{
	
	public InvalidEmailException(String exp) {
		super(exp);
	}

}