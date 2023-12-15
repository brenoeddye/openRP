CREATE TABLE `users`(
    `ID` int AUTO_INCREMENT PRIMARY KEY,
    `Name` varchar(24),
    `Password` varchar(24),
    `Admin` int(6) DEFAULT 0,
    `Money` int(12) DEFAULT 500,
    `Level` int(6) DEFAULT 0,
    `Exp` int (12) DEFAULT 0,
    `Skin` int(4) DEFAULT 60,
    `PosX` float DEFAULT -2240.9197,
    `PosY` float DEFAULT 252.0263,
    `PosZ` float DEFAULT 35.3203,
    `PosA` float DEFAULT 91.2125
);

CREATE TABLE `houses` (
    `ID` INT AUTO_INCREMENT PRIMARY KEY,
    `Type` INT,
    `OwnerID` INT,
    `Price` INT,
    `InteriorID` INT,
    `PosX` FLOAT,
    `PosY` FLOAT,
    `PosZ` FLOAT,

    FOREIGN KEY (`OwnerID`) REFERENCES `users`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE
);