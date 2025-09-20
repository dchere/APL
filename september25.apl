⍝ dyalog -script Entry_Level.apl

⍝ APL unique keyboard:
⍝ × ÷ |⌈ ⌊ ¯ ⊂ ⊃ ≠ ≤ ≥ ∧ ∨ ~ ⍴ ⍪ ⍳ ⍸ ⍷ ⍒ ⍋ ⍉ / ⌿ \ ⍀ ∘. ⍤ ⎕ ⍞ ⍝ ⍠ ⍫ ⍬ ⍣ ⍢ ⍤ ⍥ ⍨
⍝ ⍤ ⍣ ⍠ ⍤ ⍥ ⍨ ⍣ ⍠ ⍤ ⍥ ⍨ ⍣ ⍠ ← → ⇐ ⇒ ∇ ⍺ ⍵
Assert←{⍺≡⍵:0 ⋄ ⎕SIGNAL 11}  ⍝ Custom assert function for testing
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

