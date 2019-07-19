CREATE TABLE car (
registered_state VARCHAR(15) NOT NULL,
registration_number VARCHAR(25) NOT NULL,
vin NUMBER(25) NOT NULL,
model VARCHAR(25) NOT NULL,
make VARCHAR(25) NOT NULL,
color VARCHAR(25) NOT NULL,
year NUMBER(4) NOT NULL,
mileage NUMBER(6) NOT NULL,
owning_branch_id NUMBER(6) NOT NULL,
availability_flag CHAR(1) DEFAULT 'Y' NOT NULL,
passenger_capacity NUMBER(2) NOT NULL,
cost_per_day NUMBER(7,2) NOT NULL CHECK (cost_per_day > 0),
late_fee_per_day NUMBER(7,2) NOT NULL,
CONSTRAINT car_pk PRIMARY KEY ( registered_state, registration_number )
);

CREATE TABLE customer (
driver_license_number VARCHAR(25) NOT NULL,
primary_phone_number NUMBER(10) NOT NULL,
secondary_phone_number NUMBER(10),
fname VARCHAR(25) NOT NULL,
minit CHAR(1),
lname VARCHAR(25) NOT NULL,
email_id VARCHAR(25) NOT NULL,
date_of_birth DATE NOT NULL,
street VARCHAR(25) NOT NULL,
city VARCHAR(25) NOT NULL,
state VARCHAR(25) NOT NULL,
zip_code NUMBER(5) NOT NULL,
CONSTRAINT customer_pk PRIMARY KEY ( driver_license_number )
);

CREATE TABLE booking (
booking_id NUMBER(10) NOT NULL,
start_mileage NUMBER(6),
end_mileage NUMBER(6),
booking_date DATE DEFAULT SYSDATE NOT NULL,
status VARCHAR(25) DEFAULT 'Booked' NOT NULL,
booking_amount NUMBER(7,2),
drop_off_branch_id NUMBER(6) NOT NULL,
driver_license_number VARCHAR(25) NOT NULL,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
actual_end_date DATE,
CONSTRAINT booking_pk PRIMARY KEY ( booking_id )
);

CREATE TABLE promotion (
promotion_code VARCHAR(25) NOT NULL,
discount_value NUMBER(7,2) NOT NULL,
discount_type VARCHAR(10) NOT NULL,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
CONSTRAINT promotion_pk PRIMARY KEY ( promotion_code )
);

CREATE TABLE rental_insurance (
insurance_code VARCHAR(25) NOT NULL,
bodily_injury_coverage NUMBER(7,2) NOT NULL,
property_damage_coverage NUMBER(7,2) NOT NULL,
rate_per_day NUMBER(7,2) NOT NULL,
CONSTRAINT rental_insurance_pk PRIMARY KEY ( insurance_code )
);

CREATE TABLE card_information (
driver_license_number VARCHAR(25) NOT NULL,
card_number NUMBER(10) NOT NULL,
card_type VARCHAR(10) NOT NULL,
fname VARCHAR(25) NOT NULL,
minit CHAR(1),
lname VARCHAR(25) NOT NULL,
cvv NUMBER(3) NOT NULL,
expiration_date DATE NOT NULL,
street VARCHAR(25) NOT NULL,
city VARCHAR(25) NOT NULL,
state VARCHAR(25) NOT NULL,
zip_code NUMBER(5) NOT NULL,
CONSTRAINT card_information_pk PRIMARY KEY ( driver_license_number, card_number )
);

CREATE TABLE billing (
bill_id NUMBER(10) NOT NULL,
driver_license_number VARCHAR(25),
card_number NUMBER(10),
payment_mode VARCHAR(25),
status VARCHAR(25) DEFAULT 'Pending' NOT NULL,
total_amount NUMBER(7,2) NOT NULL,
bill_date DATE DEFAULT SYSDATE,
CONSTRAINT billing_pk PRIMARY KEY ( bill_id )
);

CREATE TABLE branch (
branch_id NUMBER(6) NOT NULL,
manager_id NUMBER(10) NOT NULL,
email_id VARCHAR(25) NOT NULL,
phone NUMBER(10) NOT NULL,
street VARCHAR(25) NOT NULL,
city CHAR(25) NOT NULL,
state CHAR(25) NOT NULL,
zip_code NUMBER(5) NOT NULL,
CONSTRAINT branch_pk PRIMARY KEY ( branch_id )
);

CREATE TABLE booking_car (
registered_state VARCHAR(15) NOT NULL,
registration_number VARCHAR(25) NOT NULL,
booking_id NUMBER(10) NOT NULL,
CONSTRAINT booking_car_pk PRIMARY KEY ( registered_state, registration_number, booking_id )
);
CREATE TABLE booking_promotion (
promotion_code VARCHAR(25) NOT NULL,
booking_id NUMBER(10) NOT NULL,
CONSTRAINT booking_promotion_pk PRIMARY KEY ( booking_id, promotion_code )
);
CREATE TABLE booking_rental_insurance (
insurance_code VARCHAR(25) NOT NULL,
booking_id NUMBER(10) NOT NULL,
CONSTRAINT booking_rental_insurance_pk PRIMARY KEY ( booking_id, insurance_code )
);
CREATE TABLE sedan (
registered_state VARCHAR(15) NOT NULL,
registration_number VARCHAR(25) NOT NULL,
exotic_flag CHAR(1) DEFAULT 'N' NOT NULL,
CONSTRAINT sedan_pk PRIMARY KEY ( registered_state, registration_number )
);

CREATE TABLE van (
registered_state VARCHAR(15) NOT NULL,
registration_number VARCHAR(25) NOT NULL,
cargo_flag CHAR(1) DEFAULT 'N' NOT NULL,
CONSTRAINT van_pk PRIMARY KEY ( registered_state,registration_number )
);

CREATE TABLE suv (
registered_state VARCHAR(15) NOT NULL,
registration_number VARCHAR(25) NOT NULL,
all_wheel_drive_flag CHAR(1) DEFAULT 'N' NOT NULL,
CONSTRAINT suv_pk PRIMARY KEY ( registered_state,
registration_number )
);

CREATE TABLE truck (
registered_state VARCHAR(15) NOT NULL,
registration_number VARCHAR(25) NOT NULL,
loading_capacity INTEGER NOT NULL,
CONSTRAINT truck_pk PRIMARY KEY ( registered_state,
registration_number )
);

CREATE TABLE regular_rental_insurance (
insurance_code VARCHAR(25) NOT NULL,
CONSTRAINT regular_rental_insurance_pk PRIMARY KEY ( insurance_code )
);

CREATE TABLE premium_rental_insurance (
insurance_code VARCHAR(25) NOT NULL,
towing_coverage NUMBER(7,2) NOT NULL,
roadside_assistance_coverage NUMBER(7,2) NOT NULL,
CONSTRAINT premium_rental_insurance_pk PRIMARY KEY ( insurance_code )
);

CREATE TABLE membership_billing (
member_driver_license_number VARCHAR(25) NOT NULL,
bill_id NUMBER(10) NOT NULL,
CONSTRAINT membership_billing_pk PRIMARY KEY ( bill_id )
);

CREATE TABLE member (
driver_license_number VARCHAR(25) NOT NULL,
login_id VARCHAR(15) NOT NULL,
password VARCHAR(25) NOT NULL,
membership_validity DATE NOT NULL,
CONSTRAINT member_pk PRIMARY KEY ( driver_license_number )
);

CREATE TABLE guest (
driver_license_number VARCHAR(25) NOT NULL,
CONSTRAINT guest_pk PRIMARY KEY ( driver_license_number )
);

CREATE TABLE additional_driver (
addl_driver_license_number VARCHAR(25) NOT NULL,
booking_id NUMBER(10) NOT NULL,
fname VARCHAR(25) NOT NULL,
minit CHAR(1),
lname VARCHAR(25) NOT NULL,
date_of_birth DATE NOT NULL,
CONSTRAINT additional_driver_pk PRIMARY KEY ( booking_id, addl_driver_license_number )
);

CREATE TABLE booking_billing (
bill_id NUMBER(10) NOT NULL,
late_fee NUMBER NOT NULL,
booking_id NUMBER(10) NOT NULL,
CONSTRAINT booking_billing_pk PRIMARY KEY ( bill_id )
);

ALTER TABLE car ADD CONSTRAINT car_fk1 FOREIGN KEY ( owning_branch_id) REFERENCES branch
(branch_id) ON DELETE CASCADE;
ALTER TABLE booking ADD CONSTRAINT booking_fk1 FOREIGN KEY (drop_off_branch_id) REFERENCES
branch (branch_id) ON DELETE CASCADE;
ALTER TABLE booking ADD CONSTRAINT booking_fk2 FOREIGN KEY (driver_license_number)
REFERENCES customer (driver_license_number) ON DELETE CASCADE;
ALTER TABLE card_information ADD CONSTRAINT card_information_fk1 FOREIGN KEY
(driver_license_number) REFERENCES Customer (driver_license_number) ON DELETE CASCADE;
ALTER TABLE billing ADD CONSTRAINT billing_fk1 FOREIGN KEY (driver_license_number, card_number)
REFERENCES CARD_INFORMATION (driver_license_number,card_number) ON DELETE CASCADE;
ALTER TABLE booking_car ADD CONSTRAINT booking_car_fk1 FOREIGN KEY (registered_state,
registration_number) REFERENCES car (registered_state, registration_number) ON DELETE CASCADE;
ALTER TABLE booking_car ADD CONSTRAINT booking_car_fk2 FOREIGN KEY (booking_id) REFERENCES
Booking (booking_id) ON DELETE CASCADE;
ALTER TABLE booking_promotion ADD CONSTRAINT booking_promotion_fk1 FOREIGN KEY
(promotion_code) REFERENCES promotion (promotion_code) ON DELETE CASCADE;
ALTER TABLE booking_promotion ADD CONSTRAINT booking_promotion_fk2 FOREIGN KEY (booking_id)
REFERENCES booking (booking_id) ON DELETE CASCADE;
ALTER TABLE booking_rental_insurance ADD CONSTRAINT booking_rental_insurance_fk1 FOREIGN KEY
(insurance_code) REFERENCES rental_insurance (insurance_code) ON DELETE CASCADE;
ALTER TABLE booking_rental_insurance ADD CONSTRAINT booking_rental_insurance_fk2 FOREIGN KEY
(booking_id) REFERENCES booking (booking_id) ON DELETE CASCADE;

ALTER TABLE sedan ADD CONSTRAINT sedan_fk1 FOREIGN KEY (registered_state, registration_number)
REFERENCES car (registered_state, registration_number) ON DELETE CASCADE;
ALTER TABLE van ADD CONSTRAINT van_fk1 FOREIGN KEY (registered_state, registration_number)
REFERENCES car (registered_state, registration_number) ON DELETE CASCADE;
ALTER TABLE suv ADD CONSTRAINT suv_fk1 FOREIGN KEY (registered_state, registration_number)
REFERENCES car (registered_state, registration_number) ON DELETE CASCADE;
ALTER TABLE truck ADD CONSTRAINT truck_fk1 FOREIGN KEY (registered_state, registration_number)
REFERENCES car (registered_state, registration_number) ON DELETE CASCADE;
ALTER TABLE regular_rental_insurance ADD CONSTRAINT regular_rental_insurance_fk1 FOREIGN KEY
(insurance_code) REFERENCES rental_insurance (insurance_code) ON DELETE CASCADE;
ALTER TABLE premium_rental_insurance ADD CONSTRAINT premium_rental_insurance_fk1 FOREIGN
KEY (insurance_code) REFERENCES rental_insurance (insurance_code) ON DELETE CASCADE;
ALTER TABLE membership_billing ADD CONSTRAINT membership_billing_fk1 FOREIGN KEY
(member_driver_license_number) REFERENCES Member (driver_license_number) ON DELETE CASCADE;
ALTER TABLE member ADD CONSTRAINT member_fk1 FOREIGN KEY (driver_license_number )
REFERENCES customer(driver_license_number) ON DELETE CASCADE;
ALTER TABLE guest ADD CONSTRAINT guest_fk1 FOREIGN KEY (driver_license_number ) REFERENCES
customer(driver_license_number) ON DELETE CASCADE;
ALTER TABLE additional_driver ADD CONSTRAINT additional_driver_fk1 FOREIGN KEY (booking_id)
REFERENCES booking(booking_id) ON DELETE CASCADE;
ALTER TABLE booking_billing ADD CONSTRAINT booking_billing_fk1 FOREIGN KEY (booking_id)
REFERENCES booking(booking_id) ON DELETE CASCADE;
