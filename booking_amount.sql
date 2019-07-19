
create or replace PROCEDURE calculate_booking_amount (
this_booking_id IN booking.booking_id%TYPE,
this_booking_amount OUT booking.booking_amount%TYPE
) AS
this_start_date booking.start_date%TYPE;
this_end_date booking.end_date%TYPE;
this_car_cost_per_day car.cost_per_day%TYPE;
this_discount_type promotion.discount_type%TYPE;
this_discount_value promotion.discount_value%TYPE;
this_insurance_rate_per_day rental_insurance.rate_per_day%TYPE;
this_booking_rent booking.booking_amount%TYPE;
this_discounted_booking_rent booking.booking_amount%TYPE;
this_booking_insurance_cost booking.booking_amount%TYPE;
this_booking_total_cost booking.booking_amount%TYPE;
this_total_insurance_rate_per_day RENTAL_INSURANCE.Rate_Per_Day%TYPE;
this_total_insurance_rate_per_day:=0.0;
CURSOR This_Insurance IS
SELECT RENTAL_INSURANCE.Rate_Per_Day
FROM RENTAL_INSURANCE, BOOKING_RENTAL_INSURANCE, BOOKING
WHERE
BOOKING_RENTAL_INSURANCE.Insurance_Code=RENTAL_INSURANCE.Insurance_Code
AND
BOOKING.Booking_ID=BOOKING_RENTAL_INSURANCE.Booking_ID
AND
BOOKING.Booking_ID=This_Booking_ID;
BEGIN
SELECT bk.start_date, bk.end_date
INTO this_start_date, this_end_date
FROM booking bk
WHERE bk.booking_id = this_booking_id;
SELECT c.cost_per_day
INTO this_car_cost_per_day
FROM booking bk, booking_car bk_c, car c
WHERE bk.booking_id = this_booking_id
AND bk.booking_id = bk_c.booking_id
AND bk_c.registered_state = c.registered_state
AND bk_c.registration_number = c.registration_number;
BEGIN
SELECT pr.discount_type, pr.discount_value
INTO this_discount_type, this_discount_value
FROM booking bk, booking_promotion bk_pr, promotion pr
WHERE bk.booking_id = this_booking_id
AND bk.booking_id = bk_pr.booking_id
AND bk_pr.promotion_code = pr.promotion_code;
EXCEPTION
WHEN no_data_found THEN
this_discount_type := 'Value';
this_discount_value := 0;
END;
OPEN This_Insurance;
LOOP
FETCH This_Insurance INTO this_insurance_rate_per_day;
EXIT WHEN This_Insurance%NOTFOUND;
this_total_insurance_rate_per_day=
this_total_insurance_rate_per_day+tThis_insurance_rate_per_day;
END LOOP;
CLOSE This_Insurance;
this_booking_rent := ( TO_DATE(TO_CHAR(this_end_date) ) -
TO_DATE(TO_CHAR(this_start_date) ) ) * this_car_cost_per_day;
IF this_discount_type = 'Percentage'
THEN this_discounted_booking_rent := this_booking_rent - (this_booking_rent *
( this_discount_value / 100 ));
ELSIF this_discount_type = 'Value'
THEN this_discounted_booking_rent := this_booking_rent - this_discount_value;
END IF;
this_booking_insurance_cost := ( TO_DATE(TO_CHAR(this_end_date) ) -
TO_DATE(TO_CHAR(this_start_date) ) ) * this_total_insurance_rate_per_day;
this_booking_total_cost := this_discounted_booking_rent + this_booking_insurance_cost;
this_booking_amount := this_booking_total_cost * ( 1 + 0.0825 );
dbms_output.put_line('Rent: ' || this_booking_rent);
dbms_output.put_line('Rent after discount: ' || this_discounted_booking_rent);
dbms_output.put_line('Insurance: ' ||this_booking_insurance_cost);
dbms_output.put_line('Booking Cost: ' || this_booking_total_cost);
dbms_output.put_line('Booking Cost with tax: ' || this_booking_amount);
END;
