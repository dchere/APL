⍝ dyalog -script october25.apl

⍝ ← + - × ÷ * ⍟ ⌹ ○ ! ? | ⌈ ⌊ ⊥ ⊤ ⊣ ⊢ = ≠ ≤ < > ≥ ≡ ≢ ∨ ∧ ⍲ ⍱ ↑ ↓ ⊂ ⊃ ⊆ ⌷ ⍋ ⍒ 
⍝ ⍳ ⍸ ∊ ⍷ ∪ ∩ ~ / \ ⌿ ⍀ , ⍪ ⍴ ⌽ ⊖ ⍉ ¨ ⍨ ⍣ . ∘ ⍛ ⍤ ⍥ @ ⍞ ⎕ ⍠ ⌸ ⌺ ⌶ ⍎ ⍕ ⋄ → ⍵ ⍺ ∇
⍝ & ¯ ⍬ ∆ ⍙

Assert←{⍺≡⍵:0 ⋄ ⎕←⍺ (≡⍺) (⍴¨⍺) ⋄ ⎕←⍵ (≡⍵) (⍴¨⍵) ⋄ ⎕SIGNAL 11} ⍝ Custom assert function for testing

⍝ ------------------------------------------------------------------------------
⎕←'Duration Formatter'
⍝ Given an integer number of seconds, return a string representing the same
⍝ duration in the format "H:MM:SS", where "H" is the number of hours, "MM" is
⍝ the number of minutes, and "SS" is the number of seconds. Return the time
⍝ using the following rules:
⍝ Seconds: Should always be two digits.
⍝ Minutes: Should omit leading zeros when they aren't needed. Use "0" if the
⍝ duration is less than one minute.
⍝ Hours: Should be included only if they're greater than zero.
format←{
    ss←⍵
    hh←⌊ss÷3600
    ss-←3600×hh
    mm←⌊ss÷60
    ss-←60×mm
    ss←¯2↑'0',⍕ss
    (0=hh+mm):'0:',ss
    ((0=hh)^mm<10):(⍕mm),':',ss
    mm←¯2↑'0',⍕mm
    (0=hh):mm,':',ss
    (⍕hh),':',mm,':',ss
}
'8:20' Assert format 500
'1:06:40' Assert format 4000
'0:01' Assert format 1
'1:32:35' Assert format 5555
'27:46:39' Assert format 99999
⍝ ------------------------------------------------------------------------------
⎕←'Complementary DNA'
⍝ Given a string representing a DNA sequence, return its complementary strand
⍝ using the following rules:
⍝ DNA consists of the letters "A", "C", "G", and "T".
⍝ The letters "A" and "T" complement each other.
⍝ The letters "C" and "G" complement each other.
⍝ For example, given "ACGT", return "TGCA".
complementary_dna←{
    'TAGC'['ATCG'⍳⍵]
}
'TGCA' Assert complementary_dna 'ACGT'
'TACGCATGCAATCG' Assert complementary_dna 'ATGCGTACGTTAGC'
'CCGAATGCTAGCTTC' Assert complementary_dna 'GGCTTACGATCGAAG'
'CTAGATCGATCCGATCGATC' Assert complementary_dna 'GATCTAGCTAGGCTAGCTAG'
⍝ ------------------------------------------------------------------------------
⎕←'Hidden Treasure'
⍝ Given a 2D array representing a map of the ocean floor that includes a hidden
⍝ treasure, and an array with the coordinates ([row, column]) for the next dive
⍝ of your treasure search, return "Empty", "Found", or "Recovered" using the
⍝ following rules:
⍝ The given 2D array will contain exactly one unrecovered treasure, which will
⍝ occupy multiple cells.
⍝ Each cell in the 2D array will contain one of the following values:
⍝ "-": No treasure.
⍝ "O": A part of the treasure that has not been found.
⍝ "X": A part of the treasure that has already been found.
⍝ If the dive location has no treasure, return "Empty".
⍝ If the dive location finds treasure, but at least one other part of the
⍝ treasure remains unfound, return "Found".
⍝ If the dive location finds the last unfound part of the treasure, return
⍝ "Recovered".
⍝ For example, given:
⍝ [
⍝   [ "-", "X"],
⍝   [ "-", "X"],
⍝   [ "-", "O"]
⍝ ]
⍝ And [2, 1] for the coordinates of the dive location, return "Recovered"
⍝ because the dive found the last unfound part of the treasure.
dive←{
    map coords←⍵
    r c←1 + coords
    ('-'=c⊃r⊃map): 'Empty'
    (c⊃r⊃map)←'X' ⍝ mark found
    (∨/{∨/'O'=⍵}¨map): 'Found'
    'Recovered'
    
    'Empty' ⍝ already found part
}
'Recovered' Assert dive (('-' 'X') ('-' 'X') ('-' 'O')) (2 1)
'Empty' Assert dive (('-' 'X') ('-' 'X') ('-' 'O')) (2 0)
'Found' Assert dive (('-' 'X') ('-' 'O') ('-' 'O')) (1 1)
'Found' Assert dive (('-' '-' '-') ('X' 'O' 'X') ('-' '-' '-')) (1 2)
'Recovered' Assert dive (('-' '-' '-') ('-' '-' '-') ('O' 'X' 'X')) (2 0)
'Empty' Assert dive (('-' '-' '-') ('-' '-' '-') ('O' 'X' 'X')) (1 2)
⍝ ------------------------------------------------------------------------------
⎕←'Favorite Songs'
⍝ Remember iPods? The first model came out 24 years ago today, on Oct. 23, 2001.
⍝ Given an array of song objects representing your iPod playlist, return an
⍝ array with the titles of the two most played songs, with the most played song
⍝ first.
⍝ Each object will have a "title" property (string), and a "plays" property
⍝ (integer).
favorite_songs←{
    titles←2⊃¨⊃¨⍵
    plays←2⊃¨2⊃¨⍵
    2↑titles[⍒plays] ⍝ 2 first titles of songs sorted by plays descending
}
'Sync or Swim' 'Earbud Blues' Assert favorite_songs (('title' 'Sync or Swim') ('plays' 3)) (('title' 'Byte Me') ('plays' 1)) (('title' 'Earbud Blues') ('plays' 2))
'Clickwheel Love' '99 Downloads' Assert favorite_songs (('title' 'Skip Track') ('plays' 98)) (('title' '99 Downloads') ('plays' 99)) (('title' 'Clickwheel Love') ('plays' 100))
'Song B' 'Song C' Assert favorite_songs (('title' 'Song A') ('plays' 42)) (('title' 'Song B') ('plays' 99)) (('title' 'Song C') ('plays' 75))
⍝ ------------------------------------------------------------------------------
⎕←'Speak Wisely, You Must'
⍝ Given a sentence, return a version of it that sounds like advice from a wise
⍝ teacher using the following rules:
⍝ Words are separated by a single space.
⍝ Find the first occurrence of one of the following words in the sentence:
⍝ "have", "must", "are", "will", "can".
⍝ Move all words before and including that word to the end of the sentence and:
⍝ Preserve the order of the words when you move them.
⍝ Make them all lowercase.
⍝ And add a comma and space before them.
⍝ Capitalize the first letter of the new first word of the sentence.
⍝ All given sentences will end with a single punctuation mark. Keep the original
⍝ punctuation of the sentence and move it to the end of the new sentence.
⍝ Return the new sentence, make sure there's a single space between each word
⍝ and no spaces at the beginning or end of the sentence.
⍝ For example, given "You must speak wisely." return "Speak wisely, you must."
wise_speak←{
    punctuation←¯1↑⍵
    s←(¯1↓⍵)
    words←'have' 'must' 'are' 'will' 'can'
    ix←{(¯1+⍴⍵)+((⊂⍵)≡¨(⊃⍴⍵) ,/s)/⍳(⍴s)-(⍴⍵)-1}¨words
    ix←⊃(0<⊃¨⍴¨ix)/ix
    lower←'abcdefghijklmnopqrstuvwxyz'
    upper←'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    (1↑s)←lower[upper⍳1↑s]
    w←s[(⍳⍴s)~⍳1+ix],', ',s[⍳ix],punctuation
    (1↑w)←upper[lower⍳1↑w]
    w
}
'Speak wisely, you must.' Assert wise_speak 'You must speak wisely.'
'Do it, you can!' Assert wise_speak 'You can do it!'
'Complete this, do you think you will?' Assert wise_speak 'Do you think you will complete this?'
'Belong to us, all your base are.' Assert wise_speak 'All your base are belong to us.'
'Much to learn, you have.' Assert wise_speak 'You have much to learn.'
⍝ ------------------------------------------------------------------------------
⎕←'Thermostat Adjuster 2'
⍝ Given the current temperature of a room in Fahrenheit and a target temperature
⍝ in Celsius, return a string indicating how to adjust the room temperature
⍝ based on these constraints:
⍝ Return "Heat: X degrees Fahrenheit" if the current temperature is below the
⍝ target. With X being the number of degrees in Fahrenheit to heat the room to
⍝ reach the target, rounded to 1 decimal place.
⍝ Return "Cool: X degrees Fahrenheit" if the current temperature is above the
⍝ target. With X being the number of degrees in Fahrenheit to cool the room to
⍝ reach the target, rounded to 1 decimal place.
⍝ Return "Hold" if the current temperature is equal to the target.
⍝ To convert Celsius to Fahrenheit, multiply the Celsius temperature by 1.8 and
⍝ add 32 to the result (F = (C * 1.8) + 32).
adjust_thermostat←{
    current target←⍵
    targetF←32 + 1.8×target
    diff←0.1×⌊.5 + 10×(targetF - current)
    sgn←×diff
    diff←{(⍵≠' ')/⍵} ,'F6.1' ⎕FMT sgn×diff
    (0=sgn):'Hold'
    (sgn>0):'Heat: ',diff,' degrees Fahrenheit'
    'Cool: ',diff,' degrees Fahrenheit'
}
'Hold' Assert adjust_thermostat 32 0
'Heat: 7.0 degrees Fahrenheit' Assert adjust_thermostat 70 25
'Cool: 7.6 degrees Fahrenheit' Assert adjust_thermostat 72 18
'Hold' Assert adjust_thermostat 212 100
'Heat: 12.6 degrees Fahrenheit' Assert adjust_thermostat 59 22
⍝ ------------------------------------------------------------------------------
⎕←'Tip Calculator'
⍝ Given the price of your meal and a custom tip percent, return an array with
⍝ three tip values; 15%, 20%, and the custom amount.
⍝ Prices will be given in the format: "$N.NN".
⍝ Custom tip percents will be given in this format: "25%".
⍝ Return amounts in the same "$N.NN" format, rounded to two decimal places.
⍝ For example, given a "$10.00" meal price, and a "25%" custom tip value,
⍝ return ["$1.50", "$2.00", "$2.50"].
calculate_tips←{
    price tip←⍵
    digits←'0123456789'
    ds←0 1 2 3 4 5 6 7 8 9
    str_to_num←{+/(ds[digits⍳⍵])×⌽10*¯1+⍳⍴⍵} ⍝ convert string to number
    price←0.01×str_to_num (price∊digits)/price ⍝ extract numeric part of price
    tip←0.01×str_to_num ¯1↓tip
    {'$',(⍵≠' ')/⍵}¨↓'F6.2' ⎕FMT 0.01×⌊.5 + 100 × 0.15 0.2 tip × price
}
'$1.50' '$2.00' '$2.50' Assert calculate_tips '$10.00' '25%'
'$13.45' '$17.93' '$23.31' Assert calculate_tips '$89.67' '26%'
'$2.98' '$3.97' '$1.79' Assert calculate_tips '$19.85' '9%'
⍝ ------------------------------------------------------------------------------
⎕←'HTML Attribute Extractor'
⍝ Given a string of a valid HTML element, return the attributes of the element
⍝ using the following criteria:
⍝ You will only be given one element.
⍝ Attributes will be in the format: attribute="value".
⍝ Return an array of strings with each attribute property and value, separated
⍝ by a comma, in this format: ["attribute1, value1", "attribute2, value2"].
⍝ Return attributes in the order they are given.
⍝ If no attributes are found, return an empty array.
extract_attributes←{
    (0=⊃⍴⍵):0⍴⊂''
    (0=⊃⍴i←({'="'≡⍵}¨2 ,/⍵)/⍳¯1+⍴⍵):0⍴⊂'' ⍝ no attributes
    i←⊃i
    attr←⍵[⍳¯1+i]
    attr←(-¯1+⊃(' '=⌽attr)/⍳⍴attr)↑attr
    value←⍵[(⍳⍴⍵)~⍳1+i]
    value←(~∨\value='"')/value
    ,(⊂attr,', ',value),extract_attributes ⍵[(⍳⍴⍵)~⍳i+2+⍴value]
}
(1⍴⊂'class, red') Assert extract_attributes '<span class="red"></span>'
(1⍴⊂'charset, UTF-8') Assert extract_attributes '<meta charset="UTF-8" />'
(0⍴⊂'') Assert extract_attributes '<p>Lorem ipsum dolor sit amet</p>'
'name, email' 'type, email' 'required, true' Assert extract_attributes '<input name="email" type="email" required="true" />'
'id, submit' 'class, btn btn-primary' Assert extract_attributes '<button id="submit" class="btn btn-primary">Submit</button>'
⍝ ------------------------------------------------------------------------------
⎕←'Missing Socks'
⍝ Given an integer representing the number of pairs of socks you started with,
⍝ and another integer representing how many wash cycles you have gone through,
⍝ return the number of complete pairs of socks you currently have using the
⍝ following constraints:
⍝ Every 2 wash cycles, you lose a single sock.
⍝ Every 3 wash cycles, you find a single missing sock.
⍝ Every 5 wash cycles, a single sock is worn out and must be thrown away.
⍝ Every 10 wash cycles, you buy a pair of socks.
⍝ You can never have less than zero total socks.
⍝ Rules can overlap. For example, on wash cycle 10, you will lose a single sock,
⍝ throw away a single sock, and buy a new pair of socks.
⍝ Return the number of complete pairs of socks.
sock_pairs←{
    socks cycles←⍵
    socks←socks×2 ⍝ convert to individual socks
    socks+←+/¯1 1 ¯1 2×⌊cycles÷2 3 5 10 ⍝ apply rules
    socks←0⌈⌊socks÷2 ⍝ ensure non-negative and convert back to pairs
    socks
}
1 Assert sock_pairs 2 5
0 Assert sock_pairs 1 2
4 Assert sock_pairs 5 11
3 Assert sock_pairs 6 25
0 Assert sock_pairs 1 8
⍝ ------------------------------------------------------------------------------
⎕←'Credit Card Masker'
⍝ Given a string of credit card numbers, return a masked version of it using the
⍝ following constraints:
⍝ The string will contain four sets of four digits (0-9), with all sets being
⍝ separated by a single space, or a single hyphen (-).
⍝ Replace all numbers, except the last four, with an asterisk (*).
⍝ Leave the remaining characters unchanged.
⍝ For example, given "4012-8888-8888-1881" return "****-****-****-1881".
mask←{
    ix←¯4↓(⍵∊'0123456789')/⍳⍴w←⍵
    (w[ix])←'*'
    w
}
'****-****-****-1881' Assert mask '4012-8888-8888-1881'
'**** **** **** 5100' Assert mask '5105 1051 0510 5100'
'**** **** **** 1117' Assert mask '6011 1111 1111 1117'
'****-****-****-0010' Assert mask '2223-0000-4845-0010'
⍝ ------------------------------------------------------------------------------
⎕←'Email Validator'
⍝ Given a string, determine if it is a valid email address using the following
⍝ constraints:
⍝ It must contain exactly one @ symbol.
⍝ The local part (before the @):
⍝ Can only contain letters (a-z, A-Z), digits (0-9), dots (.), underscores (_),
⍝ or hyphens (-).
⍝ Cannot start or end with a dot.
⍝ The domain part (after the @):
⍝ Must contain at least one dot.
⍝ Must end with a dot followed by at least two letters.
⍝ Neither the local or domain part can have two dots in a row.
validate←{
    (~res←1=+/lx←⍵='@'):res ⍝ must contain exactly one @
    local←(∧\~lx)/⍵
    (~res∧←0<⊃⍴local):res ⍝ local part cannot be empty
    (~res∧←∧/local∊'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789._-'):res
    (~res∧←∧/'.'≠(1↑local),¯1↑local):res
    domain←1↓(∨\lx)/⍵
    (~res∧←3<⊃⍴domain):res ⍝ domain should be at least letter + dot + 2 letters
    (~res∧←0<+/lx←domain='.'):res ⍝ must contain at least one dot
    lx←((∧\~⌽lx)/⌽domain)∊'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    (~res∧←2≤⊃⍴lx):res ⍝ must end with a dot followed at least two
    (~res∧←^/lx):res ⍝ letters
    res∧←~(⊂'..')∊2,/local,domain
    res
}
1 Assert validate 'a@b.cd'
1 Assert validate 'hell.-w.rld@example.com'
0 Assert validate '.b@sh.rc'
0 Assert validate 'example@test.c0'
0 Assert validate 'freecodecamp.org'
1 Assert validate 'develop.ment_user@c0D!NG.R.CKS'
0 Assert validate 'hello.@wo.rld'
0 Assert validate 'hello@world..com'
0 Assert validate 'git@commit@push.io'
⍝ ------------------------------------------------------------------------------
⎕←'HTML Tag Stripper'
⍝ Given a string of HTML code, remove the tags and return the plain text content.
⍝ The input string will contain only valid HTML.
⍝ HTML tags may be nested.
⍝ Remove the tags and any attributes.
⍝ For example, '<a href="#">Click here</a>' should return "Click here".
strip_tags←{
    (~'<'∊⍵):⍵
    ix←((∨\⍵='<')^~∨\⍵='>')/⍳⍴⍵
    ix,←1+¯1↑ix
    strip_tags ⍵[(⍳⍴⍵)~ix] ⍝ recursive call until no more tags
}
'Click here' Assert strip_tags '<a href="#">Click here</a>'
'Hello World!' Assert strip_tags '<p class="center">Hello <b>World</b>!</p>'
(0⍴'  ') Assert strip_tags '<img src="cat.jpg" alt="Cat">'
'sectionsection' Assert strip_tags '<main id="main"><section class="section">section</section><section class="section">section</section></main>'
⍝ ------------------------------------------------------------------------------
⎕←'String Count'
⍝ Given two strings, determine how many times the second string appears in the
⍝ first.
⍝ The pattern string can overlap in the first string. For example, "aaa"
⍝ contains "aa" twice. The first two a's and the second two.
count←{
    s sub←⍵
    +/{sub≡⍵}¨(⊃⍴sub) ,/s
}
1 Assert count 'abcdefg' 'def'
0 Assert count 'hello' 'world'
2 Assert count 'mississippi' 'iss'
3 Assert count 'she sells seashells by the seashore' 'sh'
10 Assert count '101010101010101010101' '101'
⍝ ------------------------------------------------------------------------------
⎕←'24 to 12'
⍝ Given a string representing a time of the day in the 24-hour format of "HHMM",
⍝ return the time in its equivalent 12-hour format of "H:MM AM" or "H:MM PM".

⍝ The given input will always be a four-digit string in 24-hour time format,
⍝ from "0000" to "2359".
to_12←{
    hh←+/10 1×(0 1 2 3 4 5 6 7 8 9)['0123456789'⍳⍵[1 2]]
    post←⊃(' PM' ' AM')[1+hh<12]
    hh←⊃('12' '1' '2' '3' '4' '5' '6' '7' '8' '9' '10' '11')[1+12|hh]
    hh,':',⍵[3 4],post
}
'11:24 AM' Assert to_12 '1124'
'9:00 AM' Assert to_12 '0900'
'2:55 PM' Assert to_12 '1455'
'11:46 PM' Assert to_12 '2346'
'12:30 AM' Assert to_12 '0030'
⍝ ------------------------------------------------------------------------------
⎕←'Battle of Words'
⍝ Given two sentences representing your team and an opposing team, where each
⍝ word from your team battles the corresponding word from the opposing team,
⍝ determine which team wins using the following rules:
⍝ The given sentences will always contain the same number of words.
⍝ Words are separated by a single space and will only contain letters.
⍝ The value of each word is the sum of its letters.
⍝ Letters a to z correspond to the values 1 through 26.
⍝ A capital letter doubles the value of the letter. For example, A is 2.
⍝ Words battle in order: the first word of your team battles the first word of
⍝ the opposing team, and so on.
⍝ A word wins if its value is greater than the opposing word's value.
⍝ The team with more winning words is the winner.
⍝ Return "We win" if your team is the winner,
⍝ "We lose" if your team loses,
⍝ and "Draw" if both teams have the same number of wins.
battle←{
    lower←'abcdefghijklmnopqrstuvwxyz'
    upper←'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    split←{{(' '≠⍵)/⍵}¨(' '(,⊂⍨⊣=,)⊢)⍵}
    calcWord←{+/((⍳26)[lower⍳(⍵∊lower)/⍵]),2×((⍳26)[upper⍳(⍵∊upper)/⍵])}
    a←calcWord¨split ⊃⍵
    b←calcWord¨split 2⊃⍵
    a b←(+/a>b) (+/b>a)
    (a>b):'We win'
    (a<b):'We lose'
    'Draw'
}
'We win' Assert battle 'hello world' 'hello word'
'We win' Assert battle 'Hello world' 'hello world'
'We lose' Assert battle 'lorem ipsum' 'kitty ipsum'
'Draw' Assert battle 'hello world' 'world hello'
'We win' Assert battle 'git checkout' 'git switch'
'We lose' Assert battle 'Cheeseburger with fries' 'Cheeseburger with Fries'
'Draw' Assert battle 'We must never surrender' 'Our team must win'
⍝ ------------------------------------------------------------------------------
⎕←'Hex to Decimal'
⍝ Given a string representing a hexadecimal number (base 16), return its decimal
⍝ (base 10) value as an integer.
⍝ Hexadecimal is a number system that uses 16 digits:
⍝ 0-9 represent values 0 through 9.
⍝ A-F represent values 10 through 15.
⍝ The string will only contain characters 0–9 and A–F.
hex_to_decimal←{
    +/((0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)['0123456789ABCDEF'⍳⌽⍵])×16*¯1+⍳⍴⍵
}
10 Assert hex_to_decimal 1⍴'A'
21 Assert hex_to_decimal '15'
46 Assert hex_to_decimal '2E'
255 Assert hex_to_decimal 'FF'
2623 Assert hex_to_decimal 'A3F'
⍝ ------------------------------------------------------------------------------
⎕←'Launch Fuel'
⍝ You will be given the mass in kilograms (kg) of a payload you want to send to
⍝ orbit. Determine the amount of fuel needed to send your payload to orbit using
⍝ the following rules:
⍝ Rockets require 1 kg of fuel per 5 kg of mass they must lift.
⍝ Fuel itself has mass. So when you add fuel, the mass to lift goes up, which
⍝ requires more fuel, which increases the mass, and so on.
⍝ To calculate the total fuel needed: start with the payload mass, calculate the
⍝ fuel needed for that, add that fuel to the total mass, and calculate again.
⍝ Repeat this process until the additional fuel required is less than 1 kg,
⍝ then stop.
⍝ Ignore the mass of the rocket itself. Only compute fuel needed to lift the
⍝ payload and its own fuel.
⍝ For example, given a payload mass of 50 kg, you would need 10 kg of fuel to
⍝ lift it (payload / 5), which increases the total mass to 60 kg, which needs
⍝ 12 kg to lift (2 additional kg), which increases the total mass to 62 kg,
⍝ which needs 12.4 kg to lift - 0.4 additional kg - which is less 1 additional
⍝ kg, so we stop here. The total mass to lift is 62.4 kg, 50 of which is the
⍝ initial payload and 12.4 of fuel.
⍝ Return the amount of fuel needed rounded to one decimal place.
launch_fuel←{
    ⍝ ⎕←0.1×⌊.5 + 10×⍵÷4
    fuel←{
        kg←0.1×⌊.5 + 10×⍵÷5
        (kg-⍺)<1:kg
        kg fuel ⍵ + kg - ⍺ 
    }
    0 fuel ⍵ 
}
12.4 Assert launch_fuel 50
124.8 Assert launch_fuel 500
60.7 Assert launch_fuel 243
2749.8 Assert launch_fuel 11000
1553.4 Assert launch_fuel 6214
⍝ ------------------------------------------------------------------------------
⎕←'Moon Phase'
⍝ You will be given a date in the format "YYYY-MM-DD" and need to determine the
⍝ phase of the moon for that day using the following rules:
⍝ Use a simplified lunar cycle of 28 days, divided into four equal phases:
⍝ "New": days 1 - 7
⍝ "Waxing": days 8 - 14
⍝ "Full": days 15 - 21
⍝ "Waning": days 22 - 28
⍝ After day 28, the cycle repeats with day 1, a new moon.
⍝ Use "2000-01-06" as a reference new moon (day 1 of the cycle) to determine the
⍝ phase of the given day. You will not be given any dates before the reference date.
⍝ Return the correct phase as a string.
moon_phase←{
    strtonum←{+/(0 1 2 3 4 5 6 7 8 9)['0123456789'⍳⍵]×⌽10*¯1+⍳⍴⍵} ⍝ convert date string to numbers
    years←¯2000 + strtonum ⍵[⍳4]
    months←¯1 + strtonum ⍵[6 7]
    days←¯6 +strtonum ⍵[9 10]
    days+←+/(31 28 29 31 30 31 30 31 31 30 31 30 31)[⍳months]
    days+←+/(years×365) (⌊years÷4) (years > 0) ⍝ add leap years
    ⊃('New' 'Waxing' 'Full' 'Waning')[1+⌊(28|days)÷7]
}
'New' Assert moon_phase '2000-01-12'
'Waxing' Assert moon_phase '2000-01-13'
'Full' Assert moon_phase '2014-10-15'
'Waning' Assert moon_phase '2012-10-21'
'New' Assert moon_phase '2022-12-14'
⍝ ------------------------------------------------------------------------------
⎕←'Goldilocks Zone'
⍝ You will calculate the "Goldilocks zone" of a star - the region around a star
⍝ where conditions are "just right" for liquid water to exist.
⍝ Given the mass of a star, return an array with the start and end distances of
⍝ its Goldilocks Zone in Astronomical Units.
⍝ To calculate the Goldilocks Zone:
⍝ Find the luminosity of the star by raising its mass to the power of 3.5.
⍝ The start of the zone is 0.95 times the square root of its luminosity.
⍝ The end of the zone is 1.37 times the square root of its luminosity.
⍝ Return the distances rounded to two decimal places.
⍝ For example, given 1 as a mass, return [0.95, 1.37].
goldilocks_zone←{
    0.01×⌊.5+100 × 0.95 1.37 × ⍵*1.75 ⍝ 1.75 is 0.5*3.5
}
0.95 1.37 Assert goldilocks_zone 1
0.28 0.41 Assert goldilocks_zone 0.5
21.85 31.51 Assert goldilocks_zone 6
9.38 13.52 Assert goldilocks_zone 3.7
179.69 259.13 Assert goldilocks_zone 20
⍝ ------------------------------------------------------------------------------
⎕←'Landing Spot'
⍝ You are given a matrix of numbers (an array of arrays), representing potential
⍝ landing spots for your rover. Find the safest landing spot based on the
⍝ following rules:
⍝ Each spot in the matrix will contain a number from 0-9, inclusive.
⍝ Any 0 represents a potential landing spot.
⍝ Any number other than 0 is too dangerous to land. The higher the number, the
⍝ more dangerous.
⍝ The safest spot is defined as the 0 cell whose surrounding cells (up to 4
⍝ neighbors, ignore diagonals) have the lowest total danger.
⍝ Ignore out-of-bounds neighbors (corners and edges just have fewer neighbors).
⍝ Return the indices of the safest landing spot. There will always only be one
⍝ safest spot.
⍝ For instance, given:
⍝ [
⍝  [1, 0],
⍝  [2, 0]
⍝]
⍝ Return [0, 1], the indices for the 0 in the first array.
find_landing_spot←{
    n←⊃⍴⍵
    ⍝ we sum app the neighbors and add 0 columns/rows to avoid boundary issues
    w←⍵+(0,⍵)[;⍳n]+(⍵,0)[;1+⍳n]+(0⍪⍵)[⍳n;]+(⍵⍪0)[1+⍳n;]
    ⍝ add a big number to non-zero cells to avoid landing there
    w+←(⍵≠0)×⌈/,w
    ipg←¯1+(,w)⍳⌊/⌊/w ⍝ index in the flattened array
    (⌊ipg÷n) (n|ipg) ⍝ convert to 2D indices
}
0 1 Assert find_landing_spot 2 2 ⍴ 1 0 2 0
1 1 Assert find_landing_spot 3 3 ⍴ 9 0 3 7 0 4 8 0 5
2 2 Assert find_landing_spot 3 3 ⍴ 1 2 1 0 0 2 3 0 0
2 1 Assert find_landing_spot 4 4 ⍴ 9 6 0 8 7 1 1 0 3 0 3 9 8 6 0 9
⍝ ------------------------------------------------------------------------------
⎕←'Phone Home'
⍝ You are given an array of numbers representing distances (in kilometers)
⍝ between yourself, satellites, and your home planet in a communication route.
⍝ Determine how long it will take a message sent through the route to reach its
⍝ destination planet using the following constraints:
⍝ The first value in the array is the distance from your location to the first
⍝ satellite. Each subsequent value, except for the last, is the distance to the
⍝ next satellite.
⍝ The last value in the array is the distance from the previous satellite to
⍝ your home planet.
⍝ The message travels at 300,000 km/s.
⍝ Each satellite the message passes through adds a 0.5 second transmission delay.
⍝ Return a number rounded to 4 decimal places, with trailing zeros removed.
send_message←{
    0.0001×⌊.5 + +/(((¯1+⍴⍵)⍴5000),0) + ⍵÷30  
}
2.5 Assert send_message 300000 300000
3.0627 Assert send_message 384400 384400
364.5 Assert send_message 54600000 54600000
1674.3333 Assert send_message 1000000 500000000 1000000 
2.4086 Assert send_message 10000 21339 50000 31243 10000
21.1597 Assert send_message 802101 725994 112808 3625770 481239
⍝ ------------------------------------------------------------------------------
⎕←'Exoplanet Search'
⍝ You are given a string where each character represents the luminosity reading
⍝ of a star. Determine if the readings have detected an exoplanet using the
⍝ transit method. The transit method is when a planet passes in front of a star,
⍝ reducing its observed luminosity.
⍝ Luminosity readings only comprise of characters 0-9 and A-Z where each reading
⍝ corresponds to the following numerical values:
⍝ Characters 0-9 correspond to luminosity levels 0-9.
⍝ Characters A-Z correspond to luminosity levels 10-35.
⍝ A star is considered to have an exoplanet if any single reading is less than
⍝ or equal to 80% of the average of all readings. For example, if the average
⍝ luminosity of a star is 10, it would be considered to have a exoplanet if any
⍝ single reading is 8 or less.
has_exoplanet←{
    luminosity←(¯1+⍳36)['0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'⍳⍵]
    pass←0.8×(+/luminosity)÷⊃⍴luminosity
    ∨/pass≥luminosity
}
0 Assert has_exoplanet '665544554'
1 Assert has_exoplanet 'FGFFCFFGG'
0 Assert has_exoplanet 'MONOPLONOMONPLNOMPNOMP'
1 Assert has_exoplanet 'FREECODECAMP'
0 Assert has_exoplanet '9AB98AB9BC98A'
1 Assert has_exoplanet 'ZXXWYZXYWYXZEGZXWYZXYGEE'
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
