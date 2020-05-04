# Project-DB

This is done as a part of academic project on database to partially meet credit requirements for cs6360.

## Database design of a car rental service
Designed a database for car rental system. Identified various functional dependencies and normalized the ones violating 3NF rules. Created Procedure wherever required to improve performance.

## Requirements

1. The car rental company has multiple branches. 
2. Each branch owns multiples cars for renting.
3. Each car belongs to a make, such as Sedan, vans, SUVs (sports utility vehicles) or trucks. 
4. Customer rents cars from a specific branch.
5. Customers can choose to sign up for the membership, and in such cases, certain personal information will be collected.
6. The car rental company may offer promotion. The promotional content will be made available (description of the promotion, starting date, ending date).
7. All types of customers (members and guests) can make reservations online.
8. For every transaction, one could add extra drivers into the contract. Those drivers must have legal documents and meet all other rental restrictions, such as being 21 years of age or older.
9. For every rented car, the car rental company provides two types of insurance options, regular and premium.
10. The bills are generated once the car is returned.
11. For the payment, cash, credit cards, or debit cards are accepted. Personal checks or money orders are not allowed.
12. A late fee may occur and be added to the final cost if the customer returns the car after the due date. 
13. A customer can choose to return the car before the due date. However, the cost will be still based on the previously agreed length of the car rental transaction.
14. A default sales tax of 8.25% will be applied to the final billing.
15. Car rental price will be calculated based on the selected make and model.
