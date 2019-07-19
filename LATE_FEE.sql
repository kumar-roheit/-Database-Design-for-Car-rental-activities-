create or replace PROCEDURE calculate_late_fee (
this_booking_id IN booking.booking_id%TYPE,
this_late_fee OUT booking_billing.late_fee%TYPE
) AS
this_end_date booking.end_date%TYPE;
this_actual_end_date booking.actual_end_date%TYPE;
this_car_late_fee_per_day car.late_fee_per_day%TYPE;
this_late_fee_before_tax booking_billing.late_fee%TYPE;
BEGIN
SELECT bk.end_date, bk.actual_end_date
INTO this_end_date, this_actual_end_date
FROM booking bk
WHERE bk.booking_id = this_booking_id;
SELECT c.late_fee_per_day
INTO this_car_late_fee_per_day
FROM booking bk, booking_car bk_c, car c
WHERE bk.booking_id = this_booking_id
AND bk.booking_id = bk_c.booking_id
AND bk_c.registered_state = c.registered_state
AND bk_c.registration_number = c.registration_number;
IF ( this_actual_end_date > this_end_date )THEN
this_late_fee_before_tax := ( TO_DATE(TO_CHAR(this_actual_end_date) ) -
TO_DATE(TO_CHAR(this_end_date) ) ) * this_car_late_fee_per_day;
ELSE
this_late_fee_before_tax := 0;
END IF;
this_late_fee := this_late_fee_before_tax * ( 1 + 0.0825 );
dbms_output.put_line('Late Fee: ' || this_late_fee_before_tax);
dbms_output.put_line('Late Fee with tax: ' || this_late_fee);
END;
