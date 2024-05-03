-- Create database and tables for GSalud
CREATE DATABASE IF NOT EXISTS gsalud DEFAULT CHARACTER SET utf8;

-- Use gsalud database
USE gsalud;

-- Create patient table
CREATE TABLE patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Create activity table
CREATE TABLE activity (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Create payment_method table
CREATE TABLE payment_method (
    payment_method_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Create appointment table
CREATE TABLE appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    patient_id INT,
    value INT NOT NULL,
    payment_method_id INT,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (payment_method_id) REFERENCES payment_method(payment_method_id)
);

-- Create activities_of_appointment table
CREATE TABLE activities_of_appointment (
    activities_of_appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT,
    activity_id INT,
    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id),
    FOREIGN KEY (activity_id) REFERENCES activity(activity_id)
);
