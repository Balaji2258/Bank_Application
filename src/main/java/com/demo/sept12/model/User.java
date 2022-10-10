package com.demo.sept12.model;

public class User {
	
	String fullName;
	String userName;
	String password;
	String rePassword;
	int accNo;
	String accType;
	double amount;
	String address;
	long phone;
	String email;
	
	public User() {
		super();
	}
	
	public User(int accNo, String fullName, String userName, String password, String rePassword, String accType,
			double amount, String address, long phone, String email) {
		super();
		this.fullName = fullName;
		this.userName = userName;
		this.password = password;
		this.rePassword = rePassword;
		this.accNo = accNo;
		this.accType = accType;
		this.amount = amount;
		this.address = address;
		this.phone = phone;
		this.email = email;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getRePassword() {
		return rePassword;
	}
	public void setRePassword(String rePassword) {
		this.rePassword = rePassword;
	}
	
	public int getAccNo() {
		return accNo;
	}
	public void setAccNo(int accNo) {
		this.accNo = accNo;
	}
	
	public String getAccType() {
		return accType;
	}
	public void setAccType(String accType) {
		this.accType = accType;
	}
	
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public long getPhone() {
		return phone;
	}
	public void setPhone(long phone) {
		this.phone = phone;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

}