create or replace TRIGGER update_car_availabilty AFTER
  UPDATE OF status ON booking
  FOR EACH ROW

DECLARE
  this_registered_state car.registered_state%TYPE;
  this_registration_number car.registration_number%TYPE;
  this_owning_branch_id car.owning_branch_id%TYPE;

BEGIN
  SELECT registered_state, registration_number
  INTO this_registered_state,this_registration_number
  FROM booking_car bk_c
  WHERE bk_c.booking_id =:new.booking_id;
    SELECT owning_branch_id
    INTO this_owning_branch_id
    FROM car
    WHERE registered_state = this_registered_state
    AND registration_number = this_registration_number;
    
    IF :new.status = 'Completed' THEN
      IF :new.drop_off_branch_id = this_owning_branch_id THEN
        UPDATE car
        SET availability_flag = 'A', mileage =:new.end_mileage
        WHERE registered_state = this_registered_state
        AND registration_number = this_registration_number;
      ELSE
        UPDATE car
        SET availability_flag = 'N', mileage =:new.end_mileage
        WHERE registered_state = this_registered_state
        AND registration_number = this_registration_number;
      END IF;
    ELSIF :new.status = 'Active' THEN
      UPDATE car
      SET availability_flag = 'N'
      WHERE registered_state = this_registered_state
      AND registration_number = this_registration_number;
    END IF;
END;
