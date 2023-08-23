CREATE TABLE `market_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `itemimage` varchar(50) NOT NULL,
  `price` decimal(11,2) NOT NULL DEFAULT 0.00,
  `price_min` decimal(11,2) NOT NULL DEFAULT 0.00,
  `price_max` decimal(11,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `market_data` (`item`, `name`, `itemimage`, `price`, `price_min`, `price_max`) VALUES
('corn', 'Corn', 'corn.png', '0.01', '0.01', '5.00'),
('sugar', 'Sugar', 'sugar.png', '0.01', '0.01', '5.00'),
('tobacco', 'Tobacco', 'tobacco.png', '0.01', '0.01', '5.00'),
('carrot', 'Carrot', 'carrot.png', '0.01', '0.01', '5.00'),
('tomato', 'Tomato', 'tomato.png', '0.01', '0.01', '5.00'),
('broccoli', 'Broccoli', 'broccoli.png', '0.01', '0.01', '5.00'),
('potato', 'Potato', 'potato.png', '0.01', '0.01', '5.00');