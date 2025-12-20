-- char(5)-- ayan-- Fixed Storage
-- varchar(5)== Ayan (4) 1(1)--

CREATE TABLE personal_info (
    student_name VARCHAR(255),
    mobile_no INT PRIMARY KEY IDENTITY,
    activity_date DATE NOT NULL
);



CREATE Schema procurement;
CREATE TABLE procurement.vendor_groups (
    group_id INT IDENTITY PRIMARY KEY,
    group_name VARCHAR (100) NOT NULL
);

CREATE TABLE procurement.vendors (
        vendor_id INT IDENTITY PRIMARY KEY,
        vendor_name VARCHAR(100) NOT NULL,
        group_id INT NOT NULL,
);

DROP TABLE procurement.vendors;

CREATE TABLE procurement.vendors (
        vendor_id INT IDENTITY PRIMARY KEY,
        vendor_name VARCHAR(100) NOT NULL,
        group_id INT NOT NULL,
        CONSTRAINT fk_group FOREIGN KEY (group_id) 
        REFERENCES procurement.vendor_groups(group_id)
);



INSERT INTO procurement.vendor_groups(group_name)
VALUES('Third-Party Vendors'),
      ('Interco Vendors'),
      ('One-time Vendors');


INSERT INTO procurement.vendors(vendor_name, group_id)
VALUES('ABC Corp',1);


DELETE FROM procurement.vendor_groups WHERE group_id = 1;














