⍝ dyalog -script september25.apl

⍝ ← + - × ÷ * ⍟ ⌹ ○ ! ? | ⌈ ⌊ ⊥ ⊤ ⊣ ⊢ = ≠ ≤ < > ≥ ≡ ≢ ∨ ∧ ⍲ ⍱ ↑ ↓ ⊂ ⊃ ⊆ ⌷ ⍋ ⍒ 
⍝ ⍳ ⍸ ∊ ⍷ ∪ ∩ ~ / \ ⌿ ⍀ , ⍪ ⍴ ⌽ ⊖ ⍉ ¨ ⍨ ⍣ . ∘ ⍛ ⍤ ⍥ @ ⍞ ⎕ ⍠ ⌸ ⌺ ⌶ ⍎ ⍕ ⋄ → ⍵ ⍺ ∇
⍝ & ¯ ⍬ ∆ ⍙

Assert←{⍺≡⍵:0 ⋄ ⎕←(⍺) (≡⍺) ⋄ ⎕←(⍵) (≡⍵) ⋄ ⎕SIGNAL 13}  ⍝ Custom assert function for testing

⍝ ------------------------------------------------------------------------------
⎕←'Pangram'
⍝ Given a word or sentence and a string of lowercase letters, determine if the
⍝ word or sentence uses all the letters from the given set at least once and no
⍝ other letters.
⍝ Ignore non-alphabetical characters in the word or sentence.
⍝ Ignore letter casing in the word or sentence.
is_pangram←{
    a b←⍵
    lower←'abcdefghijklmnopqrstuvwxyz'
    upper←'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    a←(a∊lower,upper)/a
    ((a∊upper)/a)←lower[upper⍳(a∊upper)/a]
    ((b∊upper)/b)←lower[upper⍳(b∊upper)/b]
    (∧/a∊b)∧(∧/b∊a)
}
1 Assert is_pangram 'hello' 'helo'
0 Assert is_pangram 'hello' 'hel'
0 Assert is_pangram 'hello' 'helow'
1 Assert is_pangram 'hello world' 'helowrd'
1 Assert is_pangram 'Hello World!' 'helowrd'
0 Assert is_pangram 'Hello World!' 'heliowrd'
0 Assert is_pangram 'freeCodeCamp' 'frcdmp'
1 Assert is_pangram 'The quick brown fox jumps over the lazy dog.' 'abcdefghijklmnopqrstuvwxyz'
⍝ ------------------------------------------------------------------------------
⎕←'RGB to Hex'
⍝ Given a CSS rgb(r, g, b) color string, return its hexadecimal equivalent.
⍝ Here are some example outputs for a given input:
⍝ Input	Output
⍝ "rgb(255, 255, 255)"	"#ffffff"
⍝ "rgb(1, 2, 3)"	"#010203"
⍝ Make any letters lowercase.
⍝ Return a # followed by six characters. Don't use any shorthand values.
rgb_to_hex←{
    rgb←¯1↓1↓(∨\⍵='(')/⍵ ⍝ remove everything except the numbers and commas
    rgb←⍎¨{(~∧\' '=⍵)/⍵}¨1↓¨(','(,⊂⍨⊣=,)⊢)rgb
    '#',⊃,/{'0123456789abcdef'[1 + (⌊⍵ ÷ 16) (16|⍵)]}¨rgb
}
'#ffffff' Assert rgb_to_hex 'rgb(255, 255, 255)'
'#010b6f' Assert rgb_to_hex 'rgb(1, 11, 111)'
'#add8e6' Assert rgb_to_hex 'rgb(173, 216, 230)'
'#4f7bc9' Assert rgb_to_hex 'rgb(79, 123, 201)'
⍝ ------------------------------------------------------------------------------
⎕←'Tribonacci Sequence'
⍝ The Tribonacci sequence is a series of numbers where each number is the sum of
⍝ the three preceding ones. When starting with 0, 0 and 1, the first 10 numbers
⍝ in the sequence are 0, 0, 1, 1, 2, 4, 7, 13, 24, 44.
⍝ Given an array containing the first three numbers of a Tribonacci sequence,
⍝ and an integer representing the length of the sequence, return an array
⍝ containing the sequence of the given length.
⍝ Your function should handle sequences of any length greater than or equal to zero.
⍝ If the length is zero, return an empty array.
⍝ Note that the starting numbers are part of the sequence.
tribonacci_sequence←{
    fibs len←⍵
    len ⍴({⍵,+/¯3↑⍵} ⍣ (0⌈len - 3)) fibs
}
0 0 1 1 2 4 7 13 24 44 81 149 274 504 927 1705 3136 5768 10609 19513 Assert tribonacci_sequence(0 0 1) 20
(,21) Assert tribonacci_sequence (21 32 43) 1
(0⍴0) Assert tribonacci_sequence (0 0 1) 0
10 20 Assert tribonacci_sequence (10 20 30) 2
10 20 30 Assert tribonacci_sequence (10 20 30) 3
123 456 789 1368 2613 4770 8751 16134 Assert tribonacci_sequence (123 456 789) 8
⍝ ------------------------------------------------------------------------------
⎕←'Phone Number Formatter'
⍝ Given a string of ten digits, return the string as a phone number in this
⍝ format: "+D (DDD) DDD-DDDD".
format_number←{'+',⍵[1],' (',⍵[1+⍳3],') ',⍵[4+⍳3],'-',⍵[7+⍳4]}
'+0 (555) 234-0182' Assert format_number '05552340182'
'+1 (555) 435-4792' Assert format_number '15554354792'
⍝ ------------------------------------------------------------------------------
⎕←'Longest Word'
⍝ Given a sentence, return the longest word in the sentence.

⍝ Ignore periods (.) when determining word length.
⍝ If multiple words are ties for the longest, return the first one that occurs.
get_longest_word←{
    s←⍵ 
    s←(~s∊'.,')/s ⍝ remove periods and commas
    words←{(' '≠⍵)/⍵}¨(' '(,⊂⍨⊣=,)⊢)s
    lengths←{⊃⍴⍵}¨words
    ⊃words[lengths⍳⌈/lengths]
}
'coding' Assert get_longest_word 'coding is fun'
'educational' Assert get_longest_word 'Coding challenges are fun and educational.'
'sentence' Assert get_longest_word 'This sentence has multiple long words.'
⍝ ------------------------------------------------------------------------------
⎕←'CSV Header Parser'
⍝ Given the first line of a comma-separated values (CSV) file, return an array
⍝ containing the headings.
⍝ The first line of a CSV file contains headings separated by commas.
⍝ Remove any leading or trailing whitespace from each heading.
get_headings←{
    {(⌽~∧\' '=⌽⍵)/⍵}¨{(~∧\' '=⍵)/⍵}¨1↓¨(','(,⊂⍨⊣=,)⊢)⍵
    }
'name' 'age' 'city' Assert get_headings 'name,age,city'
'first name' 'last name' 'phone' Assert get_headings 'first name,last name,phone'
'username' 'email' 'signup date' Assert get_headings 'username , email , signup date '
⍝ ------------------------------------------------------------------------------
⎕←'Slug Generator'
⍝ Given a string, return a URL-friendly version of the string using the following
⍝ constraints:
⍝ All letters should be lowercase.
⍝ All characters that are not letters, numbers, or spaces should be removed.
⍝ All spaces should be replaced with the URL-encoded space code %20.
⍝ Consecutive spaces should be replaced with a single %20.
⍝ The returned string should not have leading or trailing %20.
generate_slug←{
    lower←'abcdefghijklmnopqrstuvwxyz'
    upper←'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    numbers←'0123456789'
    mask←∨\~' '=⍵ ⍝ boolean mask to remove leading spaces
    mask∧←⌽∨\~' '=⌽⍵ ⍝ and boolean mask to remove trailing spaces
    s←mask/⍵
    s←(s∊lower,upper,numbers,' ')/s ⍝ remove unwanted characters
    s←(~2=(+/¨' '=¨2,/s),0)/s ⍝ remove consecutive spaces
    ⍝ convert to lowercase
    mask←s∊upper
    (mask/s)←lower[upper⍳(mask/s)]
    ⍝ replace spaces with %20
    s←(1+2×(' '=s))/s
    mask←s=' '
    (mask/s)←(+/mask)⍴'%20'
    ⍝ return the result
    s
}
'helloworld' Assert generate_slug 'helloWorld'
'hello%20world' Assert generate_slug 'hello world!'
'helloworld' Assert generate_slug ' hello-world '
'hello%20world' Assert generate_slug 'hello  world'
'h3110%20w0r1d' Assert generate_slug '  ?H^3-1*1]0! W[0%R#1]D  '
⍝ ------------------------------------------------------------------------------
⎕←'Fill The Tank'
⍝ Given the size of a fuel tank, the current fuel level, and the price per
⍝ gallon, return the cost to fill the tank all the way.
⍝ tankSize is the total capacity of the tank in gallons.
⍝ fuelLevel is the current amount of fuel in the tank in gallons.
⍝ pricePerGallon is the cost of one gallon of fuel.
⍝ The returned value should be rounded to two decimal places in the format: "$d.dd".
cost_to_fill←{'$',(('F5.2' ⎕FMT ⍵[3]×⍵[1]-⍵[2])[1;]~' ')}
'$80.00' Assert cost_to_fill 20 0 4.00
'$17.50' Assert cost_to_fill 15 10 3.50
'$29.25' Assert cost_to_fill 18 9 3.25
'$0.00' Assert cost_to_fill 12 12 4.99
'$21.89' Assert cost_to_fill 15 9.5 3.98
⍝ ------------------------------------------------------------------------------
⎕←'Photo Storage'
⍝ Given a photo size in megabytes MB, and hard drive capacity in gigabytes GB,
⍝ return the number of photos the hard drive can store using the following
⍝ onstraints:
⍝ 1 gigabyte equals 1000 megabytes.
⍝ Return the number of whole photos the drive can store.
number_of_photos←{⌊⍵[2]×1000÷⍵[1]}
1000 Assert number_of_photos 1 1
500 Assert number_of_photos 2 1
64000 Assert number_of_photos 4 256
214285 Assert number_of_photos 3.5 750
1571 Assert number_of_photos 3.5 5.5
⍝ ------------------------------------------------------------------------------
⎕←'File Storage'
⍝ Given a file size, a unit for the file size, and hard drive capacity in
⍝ gigabytes (GB), return the number of files the hard drive can store using the
⍝ following constraints:
⍝ The unit for the file size can be bytes "B", kilobytes "KB", or megabytes "MB"
⍝ Return the number of whole files the drive can fit.
⍝ Use the following conversions:
⍝ Unit	Equivalent
⍝ 1 B	1 B
⍝ 1 KB	1000 B
⍝ 1 MB	1000 KB
⍝ 1 GB	1000 MB
number_of_files←{
    filesize unit drivesizegb←⍵
    factors←10*3×¯1+⍳4
    ⌊drivesizegb×factors[4]÷filesize×factors[('B' 'KB' 'MB')⍳⊂unit]
}
2000 Assert number_of_files 500 'KB' 1
20000 Assert number_of_files 50000 'B' 1
200 Assert number_of_files 5 'MB' 1
366210 Assert number_of_files 4096 'B' 1.5
453514 Assert number_of_files 220.5 'KB' 100
⍝ ------------------------------------------------------------------------------
⎕←'Digits vs Letters'
⍝ Given a string, return "digits" if the string has more digits than letters,
⍝ "letters" if it has more letters than digits, and "tie" if it has the same
⍝ amount of digits and letters.
⍝ Digits consist of 0-9.
⍝ Letters consist of a-z in upper or lower case.
⍝ Ignore any other characters.
digits_or_letters←{
    ndigits←+/⍵∊'0123456789'
    nletters←+/⍵∊'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    ⊃(ndigits nletters 1>nletters ndigits 0)/'digits' 'letters' 'tie'
}
'tie' Assert digits_or_letters 'abc123'
'letters' Assert digits_or_letters 'a1b2c3d'
'digits' Assert digits_or_letters '1a2b3c4'
'letters' Assert digits_or_letters 'abc123!@#DEF'
'digits' Assert digits_or_letters 'H3110 W0R1D'
'tie' Assert digits_or_letters 'P455W0RD'
⍝ ------------------------------------------------------------------------------
⎕←'String Mirror'
⍝ Given two strings, determine if the second string is a mirror of the first.
⍝ A string is considered a mirror if it contains the same letters in reverse order.
⍝ Treat uppercase and lowercase letters as distinct.
⍝ Ignore all non-alphabetical characters.
is_mirror←{
    s1 s2←⍵
    letters←'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    (⌽(s1∊letters)/s1)≡(s2∊letters)/s2
}
0 Assert is_mirror 'helloworld' 'helloworld'
1 Assert is_mirror 'Hello World' 'dlroW olleH'
1 Assert is_mirror 'RaceCar' 'raCecaR'
0 Assert is_mirror 'RaceCar' 'RaceCar'
0 Assert is_mirror 'Mirror' 'rorrim'
1 Assert is_mirror 'Hello World' 'dlroW-olleH'
1 Assert is_mirror 'Hello World' '!dlroW !olleH'
⍝ ------------------------------------------------------------------------------
⎕←'Perfect Square'
⍝ Given an integer, determine if it is a perfect square.
⍝ A number is a perfect square if you can multiply an integer by itself to
⍝ achieve the number. For example, 9 is a perfect square because you can
⍝ multiply 3 by itself to get it.
is_perfect_square←{
    (⍵≥0)∧⍵≡(⌊⍵*0.5)*2
}
1 Assert is_perfect_square 9
1 Assert is_perfect_square 49
1 Assert is_perfect_square 1
0 Assert is_perfect_square 2
0 Assert is_perfect_square 99
0 Assert is_perfect_square -9
1 Assert is_perfect_square 0
1 Assert is_perfect_square 25281
⍝ ------------------------------------------------------------------------------
⎕←'2nd Largest'
⍝ Given an array, return the second largest distinct number.
second_largest←{
    u←∪⍵
    2⊃u[⍒u]
}
3 Assert second_largest 1 2 3 4
94 Assert second_largest 20 139 94 67 31
4 Assert second_largest 2 3 4 6 6
55.5 Assert second_largest 10 ¯17 55.5 44 91 0
0 Assert second_largest 1 0 ¯1 0 1 0 ¯1 1 0
⍝ ------------------------------------------------------------------------------
⎕←'Caught Speeding'
⍝ Given an array of numbers representing the speed at which vehicles were
⍝ observed traveling, and a number representing the speed limit, return an array
⍝ with two items, the number of vehicles that were speeding, followed by the
⍝ average amount beyond the speed limit of those vehicles.
⍝ If there were no vehicles speeding, return 0 0.
speeding←{
    speeds limit←⍵
    speeds←0⌈speeds - limit
    res←+/0<speeds
    res, (1 + res>0)⊃0 ((+/speeds)÷res)
}
0 0 Assert speeding (50 60 55) 60
2 4 Assert speeding (58 50 60 55) 55
4 8.5 Assert speeding (61 81 74 88 65 71 68) 70
2 3.5 Assert speeding (100 105 95 102) 100
1 57 Assert speeding (40 45 44 50 112 39) 55
⍝ ------------------------------------------------------------------------------
⎕←'Spam Detector'
⍝ Given a phone number in the format "+A (BBB) CCC-DDDD", where each letter
⍝ represents a digit as follows:
⍝ "A" represents the country code and can be any number of digits.
⍝ "BBB" represents the area code and will always be three digits.
⍝ "CCC" and "DDDD" represent the local number and will always be three and four
⍝ digits long, respectively.
⍝ Determine if it's a spam number based on the following criteria:
⍝ The country code is greater than 2 digits long or doesn't begin with a zero 0.
⍝ The area code is greater than 900 or less than 200.
⍝ The sum of first three digits of the local number appears within last four
⍝ digits of the local number.
⍝ The number has the same digit four or more times in a row (ignoring the
⍝ formatting characters).
is_spam←{
    num←⍵
    ⍝ country code
    lx←^\~' '=⍵
    cc←1↓lx/⍵
    ⍝ area code
    s←2↓(~lx)/⍵
    lx←^\~s=')'
    area←lx/s
    ⍝ local number parts
    s←2↓(~lx)/s
    l1←3↑s
    l2←¯4↑s
⍝ The country code is less than 3 digits long and begins with 0
    res←(cc[1]='0')^3>⊃⍴cc  
⍝ The area code is in the range 200-900
    res^←(900>⍎area)^200≤⍎area
⍝ The sum of first three digits of the local number is not a digit
⍝ or does not appear within last four digits
    sum←+/¯1+'0123456789'⍳l1
    sum←(1 + 10>sum)⊃('a') (⍕sum)
    res^←~⊃sum∊l2
⍝ The number does not have the same digit four or more times in a row
    res^←~∨/{1=⊃⍴∪⍵}¨4,/cc,area,l1,l2
⍝ And if all checks passed, it's not spam
    ~res
}
0 Assert is_spam '+0 (200) 234-0182'
1 Assert is_spam '+091 (555) 309-1922'
1 Assert is_spam '+1 (555) 435-4792'
1 Assert is_spam '+0 (955) 234-4364'
1 Assert is_spam '+0 (155) 131-6943'
1 Assert is_spam '+0 (555) 135-0192'
1 Assert is_spam '+0 (555) 564-1987'
0 Assert is_spam '+00 (555) 234-0182'
⍝ ------------------------------------------------------------------------------