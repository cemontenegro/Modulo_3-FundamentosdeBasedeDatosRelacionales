CREATE DATABASE IF NOT EXISTS `alke_wallet`;
USE `alke_wallet`;

-- -----------------------------------------------------
-- Table `alke_wallet`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(45) NOT NULL,
  `user_email` VARCHAR(45) NOT NULL,
  `user_password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_email_UNIQUE` (`user_email`)
);

-- -----------------------------------------------------
-- Table `alke_wallet`.`currencies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `currencies` (
  `currency_id` INT NOT NULL AUTO_INCREMENT,
  `currency_name` VARCHAR(45) NOT NULL,
  `currency_symbol` VARCHAR(45) NOT NULL,
  `currency_value` DECIMAL(10,2) NULL,
  PRIMARY KEY (`currency_id`),
  UNIQUE INDEX `currency_name_UNIQUE` (`currency_name`),
  UNIQUE INDEX `currency_symbol_UNIQUE` (`currency_symbol`)
);

-- -----------------------------------------------------
-- Table `alke_wallet`.`banks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `banks` (
  `bank_id` INT NOT NULL AUTO_INCREMENT,
  `bank_name` VARCHAR(45) NULL,
  PRIMARY KEY (`bank_id`)
);

-- -----------------------------------------------------
-- Table `alke_wallet`.`accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `accounts` (
  `account_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `account_balance` DECIMAL(10,2) NOT NULL,
  `currency_id` INT NOT NULL,
  `account_type` VARCHAR(45) NOT NULL,
  `bank_id` INT NULL,
  PRIMARY KEY (`account_id`),
  INDEX `fk_user_id` (`user_id`),
  INDEX `fk_currency_id` (`currency_id`),
  INDEX `fk_bank_id` (`bank_id`),
  CONSTRAINT `fk_user_id_accounts`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`user_id`),
  CONSTRAINT `fk_currency_id_accounts`
    FOREIGN KEY (`currency_id`)
    REFERENCES `currencies` (`currency_id`),
  CONSTRAINT `fk_bank_id_accounts`
    FOREIGN KEY (`bank_id`)
    REFERENCES `banks` (`bank_id`)
);
-- -----------------------------------------------------
-- Table `alke_wallet`.`transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transactions` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `sender_account_id` INT NOT NULL,
  `receiver_account_id` INT NOT NULL,
  `transaction_import` DECIMAL(10,2) NOT NULL,
  `transaction_date` DATE NULL,
  `transaction_type` VARCHAR(45) NULL,
  PRIMARY KEY (`transaction_id`),
  CONSTRAINT `fk_sender_account_id`
    FOREIGN KEY (`sender_account_id`)
    REFERENCES `accounts` (`account_id`),
  CONSTRAINT `fk_receiver_account_id`
    FOREIGN KEY (`receiver_account_id`)
    REFERENCES `accounts` (`account_id`)
);
-- -----------------------------------------------------
-- Table `alke_wallet`.`contacts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `contacts` (
  `contact_id` INT NOT NULL AUTO_INCREMENT,
  `contact_name` VARCHAR(45) NULL,
  `contact_rut` VARCHAR(12) NOT NULL,
  `contact_account_number` INT NULL,
  `user_id` INT NULL,
  PRIMARY KEY (`contact_id`),
  INDEX `fk_user_id` (`user_id`),
  CONSTRAINT `fk_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`user_id`)
);



-- -----------------------------------------------------
-- Datos para la tabla `users`
-- -----------------------------------------------------
INSERT INTO `users` (`user_name`, `user_email`, `user_password`) VALUES
('John Doe', 'john@example.com', 'password123'),
('Alice Smith', 'alice@example.com', 'qwerty456'),
('Bob Johnson', 'bob@example.com', 'pass1234'),
('Emma Davis', 'emma@example.com', 'abcdef789'),
('Michael Brown', 'michael@example.com', 'password567'),
('Sophia Wilson', 'sophia@example.com', 'qwerty789'),
('James Martinez', 'james@example.com', 'pass456'),
('Olivia Taylor', 'olivia@example.com', 'abcdef123'),
('William Anderson', 'william@example.com', 'password890'),
('Emily Thomas', 'emily@example.com', 'qwerty890');

-- -----------------------------------------------------
-- Datos para la tabla `currencies`
-- -----------------------------------------------------

INSERT INTO `currencies` (`currency_name`, `currency_symbol`, `currency_value`) VALUES
('Dollar', '$', 1.00),
('Euro', '€', 0.85),
('Chilean Peso', 'CLP', 797.32);

-- -----------------------------------------------------
-- Datos para la tabla `banks`
-- -----------------------------------------------------

INSERT INTO `banks` (`bank_name`) VALUES 
('Banco de Chile'),
('Banco Santander Chile'),
('BancoEstado'),
('Banco Bci'),
('Scotiabank Chile'),
('Banco Itaú Chile'),
('Banco Security'),
('Banco Falabella'),
('Banco Ripley'),
('Banco Consorcio');

-- -----------------------------------------------------
-- Datos para la tabla `accounts`
-- -----------------------------------------------------

INSERT INTO `accounts` (`user_id`, `account_balance`, `currency_id`, `account_type`, `bank_id`) VALUES
(1, 5000.00, 1, 'debit', 1),
(2, 3000.00, 2, 'credit', 1),
(3, 1500.00, 3, 'credit', 1),
(4, 7000.00, 1, 'credit', 1),
(5, 2500.00, 2, 'debit', 1),
(6, 4000.00, 3, 'debit', 1),
(7, 6000.00, 1, 'credit', 1),
(8, 3500.00, 2, 'credit', 1),
(9, 4500.00, 3, 'credit', 1),
(10, 2000.00, 1, 'debit', 1);

-- -----------------------------------------------------
-- Datos para la tabla `transactions`
-- -----------------------------------------------------

INSERT INTO `transactions` (`sender_account_id`, `receiver_account_id`, `transaction_import`, `transaction_date`, `transaction_type`) VALUES
((SELECT account_id FROM accounts WHERE user_id = 1), (SELECT account_id FROM accounts WHERE user_id = 2), 500.00, '2024-03-21', 'send'),
((SELECT account_id FROM accounts WHERE user_id = 3), (SELECT account_id FROM accounts WHERE user_id = 4), 200.00, '2024-03-21', 'receive'),
((SELECT account_id FROM accounts WHERE user_id = 5), (SELECT account_id FROM accounts WHERE user_id = 6), 300.00, '2024-03-21', 'receive'),
((SELECT account_id FROM accounts WHERE user_id = 7), (SELECT account_id FROM accounts WHERE user_id = 8), 400.00, '2024-03-21', 'send'),
((SELECT account_id FROM accounts WHERE user_id =9), (SELECT account_id FROM accounts WHERE user_id = 10), 150.00, '2024-03-21', 'send');

-- -----------------------------------------------------
-- Datos para la tabla `contacts`
-- -----------------------------------------------------

INSERT INTO `contacts` (`contact_name`, `contact_rut`, `contact_account_number`, `user_id`) VALUES
('Sarah Johnson', '12345678-9', 12345678, 1),
('David Williams', '23456789-0', 23456789, 2),
('Jessica Brown', '14567890-1', 34567890, 3),
('Christopher Davis', '15678901-2', 45678901, 4),
('Jennifer Miller', '16789012-3', 56789012, 5),
('Daniel Wilson', '17890123-4', 67890123, 6),
('Margaret Moore', '18901234-5', 78901234, 7),
('Joseph Taylor', '19012345-6', 89012345, 8),
('Elizabeth Anderson', '10123456-7', 90123456, 9),
('Anthony Thomas', '01234567-8', 12345678, 10);

-- -----------------------------------------------------
-- Consulta para obtener el nombre de la moneda elegida por un usuario especifico.
-- -----------------------------------------------------

SELECT u.user_name, c.currency_name
FROM users u
INNER JOIN accounts a ON u.user_id = a.user_id
INNER JOIN currencies c ON a.currency_id = c.currency_id
WHERE u.user_name = 'John Doe';

-- -----------------------------------------------------
-- Consulta para obtener todas las transacciones resgistradas
-- -----------------------------------------------------

SELECT *
FROM transactions;

-- -----------------------------------------------------
-- Consulta para obtener todas las transacciones realizadas por un usuario especifico
-- -----------------------------------------------------

SELECT t.*
FROM transactions t
JOIN accounts sender ON t.sender_account_id = sender.account_id
JOIN accounts receiver ON t.receiver_account_id = receiver.account_id
JOIN users u_sender ON sender.user_id = u_sender.user_id
JOIN users u_receiver ON receiver.user_id = u_receiver.user_id
WHERE u_sender.user_name = 'John Doe' OR u_receiver.user_name = 'John Doe';

-- -----------------------------------------------------
-- Sentencia DML para modicar el campo correo electrónico de un usuario especifico.
-- -----------------------------------------------------

SET SQL_SAFE_UPDATES = 0;

UPDATE users
SET user_email = 'new_email@example.com'
WHERE user_name = 'John Doe';

-- -----------------------------------------------------
-- Sentencia para eliminar los datos de una transacción (eliminado de la fila completa)
-- -----------------------------------------------------

DELETE FROM transactions
WHERE transaction_id = 2;