⍝ dyalog -script october25.apl

⍝ ← + - × ÷ * ⍟ ⌹ ○ ! ? | ⌈ ⌊ ⊥ ⊤ ⊣ ⊢ = ≠ ≤ < > ≥ ≡ ≢ ∨ ∧ ⍲ ⍱ ↑ ↓ ⊂ ⊃ ⊆ ⌷ ⍋ ⍒ 
⍝ ⍳ ⍸ ∊ ⍷ ∪ ∩ ~ / \ ⌿ ⍀ , ⍪ ⍴ ⌽ ⊖ ⍉ ¨ ⍨ ⍣ . ∘ ⍛ ⍤ ⍥ @ ⍞ ⎕ ⍠ ⌸ ⌺ ⌶ ⍎ ⍕ ⋄ → ⍵ ⍺ ∇
⍝ & ¯ ⍬ ∆ ⍙

Assert←{⍺≡⍵:0 ⋄ ⎕←⍺ (⍴⍺) ⋄ ⎕←⍵ (⍴⍵) ⋄ ⎕SIGNAL 11} ⍝ Custom assert function for testing

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
