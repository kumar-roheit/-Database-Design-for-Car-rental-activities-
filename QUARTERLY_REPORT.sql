create or replace PROCEDURE generate_quarter_report (this_quarter_date IN DATE DEFAULT
SYSDATE) AS

    this_quarter_start_date DATE := trunc(this_quarter_date,'Q');
    this_quarter_end_date DATE := add_months(trunc(this_quarter_date,'Q'),3) - 1;
    this_zip_code branch.zip_code%TYPE;
    this_total_revenue NUMBER(15,2);
    this_total_booking_count NUMBER(10);

CURSOR quarterly_report_cur IS
SELECT br.zip_code, COUNT(bk.booking_id), SUM(bl.total_amount)
FROM branch br, car c, booking bk, booking_car bk_c, booking_billing bk_bl, billing bl
WHERE br.branch_id = c.owning_branch_id
  AND bk_c.registration_number = c.registration_numberAND bk_c.registered_state = c.registered_state
  AND bk_bl.bill_id = bl.bill_id
  AND bk_bl.booking_id = bk.booking_id
  AND bk_c.booking_id = bk.booking_id
  AND bk.status = 'Completed'
  AND bk.booking_date >= this_quarter_start_date
  AND bk.booking_date <= this_quarter_end_date
GROUP BY br.zip_code;
BEGIN
  dbms_output.put_line(RPAD('Zip Code', 10) || RPAD('Booking Count', 15) || RPAD('Revenue', 17));
  OPEN quarterly_report_cur;
  LOOP
    FETCH quarterly_report_cur INTO this_zip_code,this_total_booking_count,this_total_revenue;
    EXIT WHEN quarterly_report_cur%notfound;
    dbms_output.put_line(RPAD(this_zip_code, 10) || RPAD(this_total_booking_count, 15) ||
  RPAD(this_total_revenue, 17));
  END LOOP;
CLOSE quarterly_report_cur;
END;
