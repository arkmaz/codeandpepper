# Credit

Welcome to our code exercise. You're in a small group of chosen ones that we continue our job interview with! Please take a look at this coding exercise and feel free to do anything you want to achieve the goal.

## Goal

Please implement credit card validator with given specification:

### What is credit card

A credit (or debit) card, of course, is a plastic card with which you can pay for goods and services. Printed on that card is a number that’s also stored in a database somewhere, so that when your card is used to buy something, the creditor knows whom to bill. There are a lot of people with credit cards in this world, so those numbers are pretty long: American Express uses 15-digit numbers, MasterCard uses 16-digit numbers, and Visa uses 13- and 16-digit numbers. And those are decimal numbers (0 through 9), not binary, which means, for instance, that American Express could print as many as 10^15 = 1,000,000,000,000,000 unique cards! (That’s, um, a quadrillion.)

### MasterCard, Visa and American Express

Actually, that’s a bit of an exaggeration, because credit card numbers actually have some structure to them. All American Express numbers start with 34 or 37; most MasterCard numbers start with 51, 52, 53, 54, or 55 (they also have some other potential starting numbers which we won’t concern ourselves with for this problem); and all Visa numbers start with 4. But credit card numbers also have a “checksum” built into them, a mathematical relationship between at least one number and others. That checksum enables computers (or humans who like math) to detect typos (e.g., transpositions), if not fraudulent numbers, without having to query a database, which can be slow. Of course, a dishonest mathematician could certainly craft a fake number that nonetheless respects the mathematical constraint, so a database lookup is still necessary for more rigorous checks.

### Luhn’s Algorithm

So what’s the secret formula? Well, most cards use an algorithm invented by Hans Peter Luhn of IBM. According to Luhn’s algorithm, you can determine if a credit card number is (syntactically) valid as follows:

Multiply every other digit by 2, starting with the number’s second-to-last digit, and then add those products’ digits together.
Add the sum to the sum of the digits that weren’t multiplied by 2.
If the total’s last digit is 0 (or, put more formally, if the total modulo 10 is congruent to 0), the number is valid!

That’s kind of confusing, so let’s try an example of Visa: `4003600000000014`.
- For the sake of discussion, let’s first bold every other digit, starting with the number’s second-to-last digit:
`**4**0**0**3**6**0**0**0**0**0**0**0**0**0**1**4`
- Okay, let’s multiply each of the bold digits by `2`:
`1•2 + 0•2 + 0•2 + 0•2 + 0•2 + 6•2 + 0•2 + 4•2`
- That gives us:
`2 + 0 + 0 + 0 + 0 + 12 + 0 + 8`
- Now let’s add those products’ digits (i.e., not the products themselves) together:
`2 + 0 + 0 + 0 + 0 + 1 + 2 + 0 + 8 = 13`
- Now let’s add that sum (`13`) to the sum of the digits that weren’t multiplied by `2` (starting from the end):
`13 + 4 + 0 + 0 + 0 + 0 + 0 + 3 + 0 = 20`
- Yup, the last digit in that sum (`20`) is a `0`, so that visa card is legit!

So, validating credit card numbers isn’t hard, but it does get a bit tedious by hand. Let’s write a program.

### Implementation Details

In the `lib/credit/` directory there's a base program which should be used to validate credit card numbers using the described algorithm.
Feel free to use our first tests and `Card` class but you can implement it in any way you want.
Return `[VISA|AMEX|MASTERCARD]` if card number is correct or `INVALID` for... invalid number.

Please remember first to check whether the user’s input is indeed a sequence of digits of the correct length, you can get rid of hyphens if in the string.
Then check the card number.

Here are some other card numbers you can use:

- `378282246310005` AMEX
- `371449635398431` AMEX
- `5555555555554444` MASTERCARD
- `5105105105105100` MASTERCARD
- `4111111111111111` VISA
- `4012888888881881` VISA
- `1234567890` INVALID

Good luck and have fun!
