# -Database-Design-for-Car-rental-activities-
Designed a database for car rental system. Identified various functional dependencies and normalized the ones violating 3NF rules. Created Procedure wherever required to improve performance.

Requirements

a) The car rental company has multiple branches. 
b) Each branch owns multiples cars for renting.
c) Each car belongs to a make, such as Sedan, vans, SUVs (sports utility vehicles) or trucks. 
d) Customer rents cars from a specific branch.
e) Customers can choose to sign up for the membership, and in such cases, certain personal information will be collected.
f) The car rental company may offer promotion. The promotional content will be made available (description of the promotion, starting date, ending date).
g) All types of customers (members and guests) can make reservations online.
h) For every transaction, one could add extra drivers into the contract. Those drivers must have legal documents and meet all other rental restrictions, such as being 21 years of age or older.
i) For every rented car, the car rental company provides two types of insurance options, regular and premium.
j) The bills are generated once the car is returned.
k) For the payment, cash, credit cards, or debit cards are accepted. Personal checks or money orders are not allowed.
l) A late fee may occur and be added to the final cost if the customer returns the car after the due date. 
m) A customer can choose to return the car before the due date. However, the cost will be still based on the previously agreed length of the car rental transaction.
n) A default sales tax of 8.25% will be applied to the final billing.
o) Car rental price will be calculated based on the selected make and model.
