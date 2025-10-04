⍝ dyalog -script october25.apl

⍝ ← + - × ÷ * ⍟ ⌹ ○ ! ? | ⌈ ⌊ ⊥ ⊤ ⊣ ⊢ = ≠ ≤ < > ≥ ≡ ≢ ∨ ∧ ⍲ ⍱ ↑ ↓ ⊂ ⊃ ⊆ ⌷ ⍋ ⍒ 
⍝ ⍳ ⍸ ∊ ⍷ ∪ ∩ ~ / \ ⌿ ⍀ , ⍪ ⍴ ⌽ ⊖ ⍉ ¨ ⍨ ⍣ . ∘ ⍛ ⍤ ⍥ @ ⍞ ⎕ ⍠ ⌸ ⌺ ⌶ ⍎ ⍕ ⋄ → ⍵ ⍺ ∇
⍝ & ¯ ⍬ ∆ ⍙

Assert←{⍺≡⍵:0 ⋄ ⎕←⍺ (⍴⍺) ⋄ ⎕←⍵ (⍴⍵) ⋄ ⎕SIGNAL 11} ⍝ Custom assert function for testing

⍝ ------------------------------------------------------------------------------
⎕←'Stellar Classification'
⍝ You are given the surface temperature of a star in Kelvin (K) and need to
⍝ determine its stellar classification based on the following ranges:
⍝ "O": 30,000 K or higher
⍝ "B": 10,000 K - 29,999 K
⍝ "A": 7,500 K - 9,999 K
⍝ "F": 6,000 K - 7,499 K
⍝ "G": 5,200 K - 5,999 K
⍝ "K": 3,700 K - 5,199 K
⍝ "M": 0 K - 3,699 K
⍝ Return the classification of the given star.
classification←{
    'MKGFABO'[+/29999 9999 7499 5999 5199 3699 0<⍵]
}
'G' Assert classification 5778
'M' Assert classification 2400
'A' Assert classification 9999
'K' Assert classification 3700
'M' Assert classification 3699
'O' Assert classification 210000
'F' Assert classification 6000
'B' Assert classification 11432
⍝ ------------------------------------------------------------------------------
⎕←'P@ssw0rd Str3ngth!'
⍝ Given a password string, return "weak", "medium", or "strong" based on the
⍝ strength of the password.
⍝ A password is evaluated according to the following rules:
⍝ It is at least 8 characters long.
⍝ It contains both uppercase and lowercase letters.
⍝ It contains at least one number.
⍝ It contains at least one special character from this set: !, @, #, $, %, ^, &, or *.
⍝ Return "weak" if the password meets fewer than two of the rules.
⍝ Return "medium" if the password meets 2 or 3 of the rules.
⍝ Return "strong" if the password meets all 4 rules.
check_strength←{
    rate←8≤≢⍵
    rate+←(0<+/⍵∊'ABCDEFGHIJKLMNOPQRSTUVWXYZ')∧0<+/⍵∊'abcdefghijklmnopqrstuvwxyz'
    rate+←0<+/⍵∊'0123456789'
    rate+←0<+/⍵∊special←'!@#$%^&*'
    res←'medium'
    res←⊃(res 'weak')[1 + rate<2]
    res←⊃(res 'strong')[1 + rate=4]
    res
}
'weak' Assert check_strength '123456'
'weak' Assert check_strength 'pass!!!'
'weak' Assert check_strength 'Qwerty'
'weak' Assert check_strength 'PASSWORD'
'medium' Assert check_strength 'PASSWORD!'
'medium' Assert check_strength 'PassWord%^!'
'medium' Assert check_strength 'qwerty12345'
'medium' Assert check_strength 'PASSWORD!'
'strong' Assert check_strength 'S3cur3P@ssw0rd'
'strong' Assert check_strength 'C0d3&Fun!'
⍝ ------------------------------------------------------------------------------
⎕←'Decimal to Binary'
⍝ Given a non-negative integer, return its binary representation as a string.
⍝ A binary number uses only the digits 0 and 1 to represent any number. To
⍝ convert a decimal number to binary, repeatedly divide the number by 2 and
⍝ record the remainder. Repeat until the number is zero. Read the remainders
⍝ last recorded to first. For example, to convert 12 to binary:
⍝ 12 ÷ 2 = 6 remainder 0
⍝ 6 ÷ 2 = 3 remainder 0
⍝ 3 ÷ 2 = 1 remainder 1
⍝ 1 ÷ 2 = 0 remainder 1
⍝ 12 in binary is 1100.
to_binary←{
    bite←{⍵<1:0 ⋄ (2|⍵),bite ⌊⍵ ÷ 2}
    ⌽¯1↓'01'[1+bite ⍵]
    }
'101' Assert to_binary 5
'1100' Assert to_binary 12
'110010' Assert to_binary 50
'1100011' Assert to_binary 99
⍝ ------------------------------------------------------------------------------
⎕←'Binary to Decimal'
⍝ Given a string representing a binary number, return its decimal equivalent as
⍝ a number. A binary number uses only the digits 0 and 1 to represent any number.
⍝ To convert binary to decimal, multiply each digit by a power of 2 and add them
⍝ together. Start by multiplying the rightmost digit by 2^0, the next digit to
⍝ the left by 2^1, and so on. Once all digits have been multiplied by a power of
⍝ 2, add the result together.
⍝ For example, the binary number 101 equals 5 in decimal because:
⍝ 1 * 2^2 + 0 * 2^1 + 1 * 2^0 = 4 + 0 + 1 = 5
to_decimal←{
    +/((0 1)['01'⍳⌽⍵])×2*¯1+⍳⍴⍵
    }
5 Assert to_decimal '101'
10 Assert to_decimal '1010'
18 Assert to_decimal '10010'
85 Assert to_decimal '1010101'
⍝ ------------------------------------------------------------------------------
