:Namespace Invest

⍝ Background story:
⍝ Imagine, One person is going to invest X $. There are two options:
⍝
⍝ - put money on the deposit at any well-known bank and have r % annual return
⍝   which equals to the interest rate in that country.
⍝
⍝ - lend money to a new growing business and have R % annual return (R>r).
⍝
⍝ Second option brings higher return but involves taking some risk in case of
⍝ business bankruptcy.
⍝
⍝ After investigating information about the start-up business and its founders,
⍝ the person has figured out that default of that growing company is very
⍝ unlikely, so it's really a good opportunity to make such investment to have
⍝ extra return comparing to the market interest rate.
⍝
⍝ So, the second option has been chosen.
⍝
⍝ Investment details:
⍝
⍝ 1. Interest rate is R % per year.
⍝
⍝ 2. A borrower should return his debt as fixed payment each month. Monthly
⍝ payment doesn't change each month and represents the sum of two components:
⍝ part of initial principal and interest amount.
⍝
⍝ 3. Interest amount is calculated on the outstanding principal amount.
⍝
⍝ 4. Investment duration is N years (it means last refund payment should be done
⍝ in N years after making the investment)
⍝
⍝ The task:
⍝
⍝ Write a module (i.e. several functions with same prefix) that takes: Agreement
⍝ date, Calculation date, X, R and N as input data and calculates Sum of all
⍝ future interest payments.

⍝ year, payment step (monthly)
Step ← 1÷12

⍝ year, duration of a day
Day ← 1÷365

⍝ (string) Agreement date in format 'MM/DD/YEAR'
      a_date ← '12/31/2008'

⍝ (string) Calculation date in format 'MM/DD/YEAR';
      c_date ← '01/01/2015'

⍝ Round to a some value
      ∇ round ← to Round value
        round ← to × ⌊ 0.5 + value ÷ to
      ∇

⍝ Function calculates duration of the period in years.
⍝ Input:
⍝ (string) Agreement date in format 'MM/DD/YEAR';
⍝ (string) Calculation date in format 'MM/DD/YEAR';
⍝ Output:
⍝ (number) Number of years between two dates.
      ∇ duration ← DateAgreement Duration DateCalculation
        from ← ⊃(//) '/' ⎕VFI DateAgreement
        to ← ⊃(//) '/' ⎕VFI DateCalculation
        duration ← Day Round (to[3] - from[3]) + (to[1] - from[1])÷12 + (to[2] - from[2])÷365
      ∇

⍝ Function calculates duration in years between the agreement date and the
⍝ calculation date.
⍝ Output:
⍝ (number) Duration of the period.
      ∇ duration ← CalculateDuration
        duration ← a_date Duration c_date
      ∇

⍝ years, investment duration
      N ← a_date Duration c_date

⍝ Function sets the agreement date.
⍝ Input:
⍝ (string) Agreement date in format 'MM/DD/YEAR';
⍝ Output:
⍝ (string) Agreement date in format 'MM/DD/YEAR'.
      ∇ set_a_date ← setAgreementDate DateAgreement
        a_date ← DateAgreement
        N ← CalculateDuration
        set_a_date ← a_date
      ∇

⍝ Function sets the calculation date.
⍝ Input:
⍝ (string) Calculation date in format 'MM/DD/YEAR';
⍝ Output:
⍝ (string) Calculation date in format 'MM/DD/YEAR'.
      ∇ set_c_date ← setCalculationDate DateCalculation
        c_date ← DateCalculation
        N ← CalculateDuration
        set_c_date ← c_date
      ∇

⍝ Function sets the calculation date.
⍝ Input:
⍝ (string) Calculation date in format 'MM/DD/YEAR';
⍝ Output:
⍝ (string) Calculation date in format 'MM/DD/YEAR'.
      ∇ set_duration ← setDuration n
        N ← Day Round n
        set_duration ← N
      ∇

⍝ A setting of all three parameters (agreement date, calculation date and invest
⍝ period) looks redundant. Probably agreement date and calculation date should
⍝ be a day of the month, instead of the date. But they are, usually,
⍝ interconnected. So it was implemented as an option.

⍝ $, initial (principal) investment
X ← 1000

⍝ Function sets the amount of the principal.
⍝ Input:
⍝ (number) new principal;
⍝ Output:
⍝ (number) principal in use.
      ∇ set_X ← setPrincipal x
        X ← 0.01 Round x
        set_X ← X
      ∇

⍝ %, Interest rate (per year)
R ← 18.5

⍝ Function sets the interest rate.
⍝ Input:
⍝ (number) new interest rate in %;
⍝ Output:
⍝ (number) interest rate in use.
      ∇ set_R ← setInterestRate r
        R ← r
        set_R ← R
      ∇

⍝ Calculates the sum of all future interests.
⍝ Output:
⍝ (number) Sum of all future interest payments.
      ∇ total ← TotalInterest
        ⍝ To avoid changing in the user data
        left ← X
        r ← 0.01 × R × Step
        Nmonth ← 1 Round N ÷ Step
        principal ← 0.01 Round left ÷ Nmonth
        total ← 0
        :For month :In ⍳Nmonth
            interest ← 0.01 Round left × r
            total ← total + interest
            left ← left - principal
        :EndFor
        total ← total
      ∇

⍝ There is a place for a misunderstanding in the next condition:
⍝ "A borrower should return his debt as fixed payment each month. Monthly
⍝ payment doesn't change each month and represents the sum of two components:
⍝ part of initial principal and interest amount. Interest amount is calculated
⍝ on the outstanding principal amount.". A calculation base on outstanding
⍝ principal amount means that monthly payments decline as the outstanding
⍝ principal declines. So monthly payment should change from month to month.
⍝ Probably means that each monthly payment always consists of two parts: equal
⍝ monthly amount and the interest.

:EndNamespace
