package com.java;

public class FacultyNameUtility {
    private static String facultyName;

    public static void setFacultyName(String facultyName) {
        FacultyNameUtility.facultyName = facultyName;
    }

    public static String getFacultyName() {
        return facultyName;
    }
}
