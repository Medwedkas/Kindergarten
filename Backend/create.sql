CREATE TABLE `children` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`user_id` INT NOT NULL,
	`parent_id` INT NOT NULL,
	PRIMARY KEY (`id`)
) DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;
 
CREATE TABLE `allergies` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar(255) NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
) DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

CREATE TABLE `parents` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`user_id` INT NOT NULL,
	`document_number` varchar(255) NOT NULL UNIQUE,
	`contacts` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
) DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

CREATE TABLE `suppliers` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`company_name` varchar(255) NOT NULL UNIQUE,
	`contract_number` varchar(255) NOT NULL UNIQUE,
	`contacts` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
) DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

CREATE TABLE `storage_items` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`item_id` INT NOT NULL UNIQUE,
	`delivery_date` DATETIME NOT NULL,
	`supplier_id` INT NOT NULL,
	PRIMARY KEY (`id`)
) DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

CREATE TABLE `items` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar(255) NOT NULL UNIQUE,
	`expiration_date` DATETIME NOT NULL,
	`count` INT NOT NULL,
	PRIMARY KEY (`id`)
) DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

CREATE TABLE `workers` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`user_id` INT NOT NULL,
	`post_id` INT NOT NULL,
	`salary` FLOAT NOT NULL,
	PRIMARY KEY (`id`)
) DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

CREATE TABLE `users` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`first_name` varchar(255) NOT NULL,
	`last_name` varchar(255) NOT NULL,
	`age` INT,
	`username` varchar(255),
	`password` varchar(255),
	PRIMARY KEY (`id`)
) DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

CREATE TABLE `posts` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar(255) NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
) DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

CREATE TABLE `allergies_rel` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`child_id` INT NOT NULL,
	`alergy_id` INT NOT NULL,
	PRIMARY KEY (`id`)
) DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

ALTER TABLE `children` ADD CONSTRAINT `children_fk0` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE;

ALTER TABLE `children` ADD CONSTRAINT `children_fk1` FOREIGN KEY (`parent_id`) REFERENCES `parents`(`id`) ON DELETE CASCADE;

ALTER TABLE `parents` ADD CONSTRAINT `parents_fk0` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE;

ALTER TABLE `storage_items` ADD CONSTRAINT `storage_items_fk0` FOREIGN KEY (`item_id`) REFERENCES `items`(`id`) ON DELETE CASCADE;

ALTER TABLE `storage_items` ADD CONSTRAINT `storage_items_fk1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers`(`id`) ON DELETE CASCADE;

ALTER TABLE `workers` ADD CONSTRAINT `workers_fk0` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE;

ALTER TABLE `workers` ADD CONSTRAINT `workers_fk1` FOREIGN KEY (`post_id`) REFERENCES `posts`(`id`) ON DELETE CASCADE;

ALTER TABLE `allergies_rel` ADD CONSTRAINT `allergies_rel_fk0` FOREIGN KEY (`child_id`) REFERENCES `children`(`id`) ON DELETE CASCADE;

ALTER TABLE `allergies_rel` ADD CONSTRAINT `allergies_rel_fk1` FOREIGN KEY (`alergy_id`) REFERENCES `allergies`(`id`) ON DELETE CASCADE;