
package com.csc3003s.sqlautomark;

import java.security.SecureRandom;
import java.util.Random;

/**
 * Generates secure password for user
 * @author MLTZAC001
 */
public class GeneratePassword
{

    private static final Random RANDOM = new SecureRandom();
    private static final String ALPHABET = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz%&!@$#";
    private String password;

    /**
     * Constructor method
     */
    public GeneratePassword()
    {
        // Define desired password length
        int passwordLength = 10;

        // Generate Secure Password
        password = generatePassword(passwordLength);
        

    }

    /**
     * Generates password
     * @param length length of password
     * @return String password
     */
    public static String generatePassword(int length)
    {
        StringBuilder returnValue = new StringBuilder(length);
        for (int i = 0; i < length; i++)
        {
            returnValue.append(ALPHABET.charAt(RANDOM.nextInt(ALPHABET.length())));
        }
        return new String(returnValue);
    }
    
    /**
     * Fetches the generated password
     * @return String password
     */
    public String getPassword()
    {
        return password;
    }
}
