INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_vigneron', 'Vigneron', 1);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_vigneron', 'Vigneron', 1);

INSERT INTO `jobs` (`name`, `label`) VALUES
('vigneron', 'Vigneron');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('vigneron', 0, 'recrue', 'Recrue', 25, '', ''),
('vigneron', 1, 'novice', 'Novice', 55, '', ''),
('vigneron', 2, 'expe', 'Expérimenté', 65, '', ''),
('vigneron', 3, 'chfp', 'Chef de projet', 85, '', ''),
('vigneron', 4, 'chfe', 'Chef équipe', 100, '', ''),
('vigneron', 5, 'cop', 'Co Patron', 150, '', ''),
('vigneron', 5, 'boss', 'Patron', 200, '', '');


INSERT INTO `items` (name, label, `limit`) VALUES

('raisin_rouge', 'Raisin Rouge', 50),

('raisin_blanc', 'Raisin Blanc', 50),

('raisinr_trait', 'Raisin Rouge Traité', 35),

('raisinb_trait', 'Raisin Blanc Traité', 35),

('vin_rouge', 'Vin Rouge', 12),

('vin_blanc', 'Vin Blanc', 12);