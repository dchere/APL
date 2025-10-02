⍝ dyalog -script october25.apl

⍝ ← + - × ÷ * ⍟ ⌹ ○ ! ? | ⌈ ⌊ ⊥ ⊤ ⊣ ⊢ = ≠ ≤ < > ≥ ≡ ≢ ∨ ∧ ⍲ ⍱ ↑ ↓ ⊂ ⊃ ⊆ ⌷ ⍋ ⍒ 
⍝ ⍳ ⍸ ∊ ⍷ ∪ ∩ ~ / \ ⌿ ⍀ , ⍪ ⍴ ⌽ ⊖ ⍉ ¨ ⍨ ⍣ . ∘ ⍛ ⍤ ⍥ @ ⍞ ⎕ ⍠ ⌸ ⌺ ⌶ ⍎ ⍕ ⋄ → ⍵ ⍺ ∇
⍝ & ¯ ⍬ ∆ ⍙

Assert←{⍺≡⍵:0 ⋄ ⎕←⍺ (⍴⍺) ⋄ ⎕←⍵ (⍴⍵) ⋄ ⎕SIGNAL 11} ⍝ Custom assert function for testing

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
