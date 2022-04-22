# Delphi-ISecureString
A secure string datatype for delphi with built in hashing features

## About
I created this datatype for a school project. I needed to read and write sensitive user data (passwords, emails, ect.) from/to a database. I was a bit paranoid that the strings could be compromise so I searched for a way to safeguard said strings (encrypting wouldn't work as the strings would still be found in plaintext in memory before encryption). My search lead me to code provided by Stefan van As [https://medium.com/@svanas/creating-a-securestring-type-for-delphi-part-1-e7e78ed1807c], and I expanded on it.

## Features
+ Alternative to the string datatype.
+ Secure storage of plain text strings.
+ Built in hashing features.

## Please Note
+ ISecureString was tested on Delphi 2010 edition, I have yet to test it on newer incarnations of Delpi
+ ISecureString is not an alternative to encrypting data, but rather should be used alongside it as it secures the decrypted plaintext.
