package kr.co.pegsystem;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;

import pegsystem.util.StringUtil;

public class Test01 {

	
	public static void main(String[] args) {
		
		LocalDate date = LocalDate.now();
		DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyyMMdd");
		date = date.minusYears(1);
		date = date.withDayOfMonth(1);
		String before = format.format(date);
		date = LocalDate.now();
		date = date.plusYears(1);
		date = date.withDayOfMonth(date.getMonth().length(false));
		String after = format.format(date);
		
		
	}
	
}