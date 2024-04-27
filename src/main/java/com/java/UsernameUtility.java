package com.java;

public class UsernameUtility {
    private static String username;

    public static void setUsername(String username) {
        UsernameUtility.username = username;
    }

    public static String getUsername() {
        return username;
    }
}
