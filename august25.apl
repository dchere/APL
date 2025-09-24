⍝ dyalog -script august.apl

⍝ ← + - × ÷ * ⍟ ⌹ ○ ! ? | ⌈ ⌊ ⊥ ⊤ ⊣ ⊢ = ≠ ≤ < > ≥ ≡ ≢ ∨ ∧ ⍲ ⍱ ↑ ↓ ⊂ ⊃ ⊆ ⌷ ⍋ ⍒ 
⍝ ⍳ ⍸ ∊ ⍷ ∪ ∩ ~ / \ ⌿ ⍀ , ⍪ ⍴ ⌽ ⊖ ⍉ ¨ ⍨ ⍣ . ∘ ⍛ ⍤ ⍥ @ ⍞ ⎕ ⍠ ⌸ ⌺ ⌶ ⍎ ⍕ ⋄ → ⍵ ⍺ ∇
⍝ & ¯ ⍬ ∆ ⍙

Assert←{⍺≡⍵:0 ⋄ ⎕SIGNAL 11}  ⍝ Custom assert function for testing

⍝ ------------------------------------------------------------------------------
⎕←'Vowel Balance'
⍝ Given a string, determine whether the number of vowels in the first half of
⍝ the string is equal to the number of vowels in the second half.
⍝ The string can contain any characters.
⍝ The letters a, e, i, o, and u, in either uppercase or lowercase, are
⍝ considered vowels.
⍝ If there's an odd number of characters in the string, ignore the center
⍝ character
is_balanced←{
    vowels←'aeiouAEIOU'
    n←⌊.5×⍴⍵
    (+/(n↑⍵)∊vowels)=+/((-n)↑⍵)∊vowels
}
1 Assert is_balanced 'racecar'
1 Assert is_balanced 'Lorem Ipsum'
0 Assert is_balanced 'Kitty Ipsum'
0 Assert is_balanced 'string'
1 Assert is_balanced ' '
0 Assert is_balanced 'abcdefghijklmnopqrstuvwxyz'
1 Assert is_balanced '123A#b!E&*456-o.U'
⍝ ------------------------------------------------------------------------------
⎕←'Base Check'
⍝ Given a string representing a number, and an integer base from 2 to 36,
⍝ determine whether the number is valid in that base.
⍝ The string may contain integers, and uppercase or lowercase characters.
⍝ The check should be case-insensitive.
⍝ The base can be any number 2-36.
⍝ A number is valid if every character is a valid digit in the given base.
⍝ Example of valid digits for bases:
⍝ Base 2: 0-1
⍝ Base 8: 0-7
⍝ Base 10: 0-9
⍝ Base 16: 0-9 and A-F
⍝ Base 36: 0-9 and A-Z
is_valid_number←{
    n base←⍵
    ⍝ convert to uppercase
    lower←'abcdefghijklmnopqrstuvwxyz'
    upper←'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    lx←n∊lower
    (lx/n)←upper[lower⍳(lx/n)]
    ⍝ all possible digits in the given base
    digits←('0123456789',upper)[⍳base]
    ⍝ all characters of n are in digits
    ∧/n∊digits
}
1 Assert is_valid_number '10101' 2
0 Assert is_valid_number '10201' 2
1 Assert is_valid_number '76543210' 8
0 Assert is_valid_number '9876543210' 8
1 Assert is_valid_number '9876543210' 10
0 Assert is_valid_number 'ABC' 10
1 Assert is_valid_number 'ABC' 16
1 Assert is_valid_number 'Z' 36
1 Assert is_valid_number 'ABC' 20
1 Assert is_valid_number '4B4BA9' 16
0 Assert is_valid_number '5G3F8F' 16
1 Assert is_valid_number '5G3F8F' 17
0 Assert is_valid_number 'abc' 10
1 Assert is_valid_number 'abc' 16
1 Assert is_valid_number 'AbC' 16
1 Assert is_valid_number 'z' 36
⍝ ------------------------------------------------------------------------------
⎕←'Fibonacci Sequence'
⍝ The Fibonacci sequence is a series of numbers where each number is the sum of
⍝ the two preceding ones. When starting with 0 and 1, the first 10 numbers in
⍝ the sequence are 0, 1, 1, 2, 3, 5, 8, 13, 21, 34.
⍝ Given an array containing the first two numbers of a Fibonacci sequence, and
⍝ an integer representing the length of the sequence, return an array containing
⍝ the sequence of the given length.
⍝ Your function should handle sequences of any length greater than or equal to zero.
⍝ If the length is zero, return an empty array.
⍝ Note that the starting numbers are part of the sequence.
fibonacci_sequence←{
    fibs len←⍵
    len ⍴({⍵,+/¯2↑⍵} ⍣ (0⌈len - 2)) fibs
}
0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 Assert fibonacci_sequence (0 1) 20
(,21) Assert fibonacci_sequence (21 32) 1
(0⍴0) Assert fibonacci_sequence (0 1) 0
10 20 Assert fibonacci_sequence (10 20) 2
123456789 987654321 1111111110 2098765431 3209876541 Assert fibonacci_sequence (123456789 987654321) 5
⍝ ------------------------------------------------------------------------------
⎕←'S P A C E J A M'
⍝ Given a string, remove all spaces from the string, insert two spaces between
⍝ every character, convert all alphabetical letters to uppercase, and return the
⍝ result.
⍝ Non-alphabetical characters should remain unchanged (except for spaces).
space_jam←{
    s←(~' '=⍵)/⍵
    upper←'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    lower←'abcdefghijklmnopqrstuvwxyz'
    lx←s∊lower
    (lx/s)←upper[lower⍳lx/s] ⍝ convert to uppercase
    s←((⍴s)⍴3)\s
    s←(¯2+⍴s)⍴s
    ((~(⍴s)⍴1 0 0)/s)←' '  ⍝ insert spaces between characters
    s
}
'F  R  E  E  C  O  D  E  C  A  M  P' Assert space_jam 'freeCodeCamp'
'F  R  E  E  C  O  D  E  C  A  M  P' Assert space_jam '   free   Code   Camp   '
'H  E  L  L  O  W  O  R  L  D  ?  !' Assert space_jam 'Hello World?!'
'C  @  T  $  &  D  0  G  $' Assert space_jam 'C@t$ & D0g$'
'A  L  L  Y  O  U  R  B  A  S  E' Assert space_jam 'allyourbase'
⍝ ------------------------------------------------------------------------------
