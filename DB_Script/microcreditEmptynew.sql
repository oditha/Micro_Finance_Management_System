/*
Navicat MySQL Data Transfer

Source Server         : new
Source Server Version : 100130
Source Host           : localhost:3306
Source Database       : microcredit

Target Server Type    : MYSQL
Target Server Version : 100130
File Encoding         : 65001

Date: 2018-04-07 09:47:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for AccruedIncomeAccount
-- ----------------------------
DROP TABLE IF EXISTS `AccruedIncomeAccount`;
CREATE TABLE `AccruedIncomeAccount` (
  `idAcInAcc` int(11) NOT NULL AUTO_INCREMENT,
  `AccDate` varchar(45) DEFAULT NULL,
  `Description` varchar(45) DEFAULT NULL,
  `Credit` double DEFAULT NULL,
  `Debit` double DEFAULT NULL,
  `IsActive` varchar(45) DEFAULT NULL,
  `CreateBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idAcInAcc`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for allowance
-- ----------------------------
DROP TABLE IF EXISTS `allowance`;
CREATE TABLE `allowance` (
  `idAllowance` int(11) NOT NULL AUTO_INCREMENT,
  `AllowancName` varchar(45) DEFAULT NULL,
  `Isdelete` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `IsAprove` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idAllowance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for branch
-- ----------------------------
DROP TABLE IF EXISTS `branch`;
CREATE TABLE `branch` (
  `idBranch` int(11) NOT NULL AUTO_INCREMENT,
  `BranchNo` varchar(45) DEFAULT NULL,
  `BranchName` varchar(45) DEFAULT NULL,
  `Address1` varchar(45) DEFAULT NULL,
  `Address2` varchar(45) DEFAULT NULL,
  `City` varchar(45) DEFAULT NULL,
  `Contact1` varchar(45) DEFAULT NULL,
  `Contact2` varchar(45) DEFAULT NULL,
  `IsActive` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idBranch`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for CashInHandAcc
-- ----------------------------
DROP TABLE IF EXISTS `CashInHandAcc`;
CREATE TABLE `CashInHandAcc` (
  `idCashIn` int(11) NOT NULL AUTO_INCREMENT,
  `AccDate` varchar(45) DEFAULT NULL,
  `Description` varchar(45) DEFAULT NULL,
  `Credit` double DEFAULT NULL,
  `Debit` double DEFAULT NULL,
  `IsActive` varchar(45) DEFAULT NULL,
  `CreateBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idCashIn`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for center
-- ----------------------------
DROP TABLE IF EXISTS `center`;
CREATE TABLE `center` (
  `idCenter` int(11) NOT NULL AUTO_INCREMENT,
  `idBranch` int(11) NOT NULL,
  `CenterName` varchar(45) DEFAULT NULL,
  `CenterDay` varchar(45) DEFAULT NULL,
  `Centertime` varchar(45) DEFAULT NULL,
  `IsApprove` varchar(45) DEFAULT NULL,
  `IsActive` varchar(10) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `CenterNO` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`idCenter`),
  KEY `fk_Center_Branch_idx` (`idBranch`),
  CONSTRAINT `fk_Center_Branch` FOREIGN KEY (`idBranch`) REFERENCES `branch` (`idBranch`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for center_has_staff
-- ----------------------------
DROP TABLE IF EXISTS `center_has_staff`;
CREATE TABLE `center_has_staff` (
  `IDCenter_has_Staff` int(11) NOT NULL AUTO_INCREMENT,
  `idCenter` int(11) NOT NULL,
  `idStaff` int(11) NOT NULL,
  PRIMARY KEY (`IDCenter_has_Staff`),
  KEY `fk_Center_has_Staff_Staff1_idx` (`idStaff`),
  KEY `fk_Center_has_Staff_Center1_idx` (`idCenter`),
  CONSTRAINT `fk_Center_has_Staff_Center1` FOREIGN KEY (`idCenter`) REFERENCES `center` (`idCenter`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Center_has_Staff_Staff1` FOREIGN KEY (`idStaff`) REFERENCES `staff` (`idStaff`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for DayEnd
-- ----------------------------
DROP TABLE IF EXISTS `DayEnd`;
CREATE TABLE `DayEnd` (
  `idDayEnd` int(11) NOT NULL AUTO_INCREMENT,
  `DayEndDate` varchar(45) DEFAULT NULL,
  `DayEndTime` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idDayEnd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for deductions
-- ----------------------------
DROP TABLE IF EXISTS `deductions`;
CREATE TABLE `deductions` (
  `idDeductions` int(11) NOT NULL AUTO_INCREMENT,
  `DeductionType` varchar(45) DEFAULT NULL,
  `IsDelete` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idDeductions`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for denimation
-- ----------------------------
DROP TABLE IF EXISTS `denimation`;
CREATE TABLE `denimation` (
  `idDenimation` int(11) NOT NULL AUTO_INCREMENT,
  `Date` varchar(45) DEFAULT NULL,
  `ExchangeCash` double DEFAULT NULL,
  `CenterCollection` double DEFAULT NULL,
  `NPCollection` double DEFAULT NULL,
  `MemberFee` double DEFAULT NULL,
  `IncomeAmount` double DEFAULT NULL,
  `TotalLoanAmount` double DEFAULT NULL,
  `Expences` double DEFAULT NULL,
  `TotalBalance` double DEFAULT NULL,
  `Short` double DEFAULT NULL,
  `Extras` double DEFAULT NULL,
  `ShortAndExtraBalance` double DEFAULT NULL,
  `idStaff` int(11) DEFAULT NULL,
  PRIMARY KEY (`idDenimation`),
  KEY `fk_Denimation_Staff1` (`idStaff`),
  CONSTRAINT `fk_Denimation_Staff1` FOREIGN KEY (`idStaff`) REFERENCES `staff` (`idStaff`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for denimationcah
-- ----------------------------
DROP TABLE IF EXISTS `denimationcah`;
CREATE TABLE `denimationcah` (
  `idDenimationCah` int(11) NOT NULL AUTO_INCREMENT,
  `idDenimation` int(11) NOT NULL,
  `N5000` int(11) DEFAULT NULL,
  `N2000` int(11) DEFAULT NULL,
  `N1000` int(11) DEFAULT NULL,
  `N500` int(11) DEFAULT NULL,
  `N100` int(11) DEFAULT NULL,
  `N50` int(11) DEFAULT NULL,
  `N20` int(11) DEFAULT NULL,
  `N10` int(11) DEFAULT NULL,
  `Coins` double DEFAULT NULL,
  `Total` double DEFAULT NULL,
  `SlipNo` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`idDenimationCah`),
  KEY `fk_DenimationCah_Denimation1_idx` (`idDenimation`),
  CONSTRAINT `fk_DenimationCah_Denimation1` FOREIGN KEY (`idDenimation`) REFERENCES `denimation` (`idDenimation`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for InterestAccount
-- ----------------------------
DROP TABLE IF EXISTS `InterestAccount`;
CREATE TABLE `InterestAccount` (
  `idIntAcc` int(11) NOT NULL AUTO_INCREMENT,
  `AccDate` varchar(45) DEFAULT NULL,
  `Description` varchar(45) DEFAULT NULL,
  `Credit` double DEFAULT NULL,
  `Debit` double DEFAULT NULL,
  `IsActive` varchar(45) DEFAULT NULL,
  `CreateBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idIntAcc`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for legalaction
-- ----------------------------
DROP TABLE IF EXISTS `legalaction`;
CREATE TABLE `legalaction` (
  `idLegalAction` int(11) NOT NULL AUTO_INCREMENT,
  `Date` varchar(45) DEFAULT NULL,
  `Reason` varchar(45) DEFAULT NULL,
  `Description` varchar(45) DEFAULT NULL,
  `idMembers` int(11) NOT NULL,
  `idLoan` int(11) NOT NULL,
  `IsActive` varchar(45) DEFAULT NULL,
  `IsAproved` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idLegalAction`),
  KEY `fk_LegalAction_Members1_idx` (`idMembers`),
  KEY `fk_LegalAction_Loan1_idx` (`idLoan`),
  CONSTRAINT `fk_LegalAction_Loan1` FOREIGN KEY (`idLoan`) REFERENCES `loan` (`idLoan`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_LegalAction_Members1` FOREIGN KEY (`idMembers`) REFERENCES `members` (`idMembers`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for loan
-- ----------------------------
DROP TABLE IF EXISTS `loan`;
CREATE TABLE `loan` (
  `idLoan` int(11) NOT NULL AUTO_INCREMENT,
  `ContractNo` varchar(45) DEFAULT NULL,
  `LoanAmount` double DEFAULT NULL,
  `LoanInterest` double DEFAULT NULL,
  `LoanPeriod` int(11) DEFAULT NULL,
  `LoanInstallment` double DEFAULT NULL,
  `Memberfee` varchar(45) DEFAULT NULL,
  `LoanIndex` varchar(45) DEFAULT NULL,
  `RepaymentDay` varchar(45) DEFAULT NULL,
  `LoanDate` varchar(45) DEFAULT NULL,
  `Status` varchar(45) DEFAULT NULL,
  `garanter1` varchar(200) DEFAULT NULL,
  `garanter2` varchar(200) DEFAULT NULL,
  `IsAprove` varchar(45) DEFAULT NULL,
  `IsActive` varchar(45) DEFAULT NULL,
  `CreateBy` varchar(45) DEFAULT NULL,
  `idMembers` int(11) NOT NULL,
  `RenewAmount` double DEFAULT NULL,
  `issueDate` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idLoan`),
  KEY `fk_Loan_Members1_idx` (`idMembers`),
  CONSTRAINT `fk_Loan_Members1` FOREIGN KEY (`idMembers`) REFERENCES `members` (`idMembers`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for LoanAccount
-- ----------------------------
DROP TABLE IF EXISTS `LoanAccount`;
CREATE TABLE `LoanAccount` (
  `idLoanAcc` int(11) NOT NULL AUTO_INCREMENT,
  `AccDate` varchar(45) DEFAULT NULL,
  `Description` varchar(45) DEFAULT NULL,
  `Credit` double DEFAULT NULL,
  `Debit` double DEFAULT NULL,
  `IsActive` varchar(45) DEFAULT NULL,
  `CreateBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idLoanAcc`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for loancancellation
-- ----------------------------
DROP TABLE IF EXISTS `loancancellation`;
CREATE TABLE `loancancellation` (
  `idLoanCancellation` int(11) NOT NULL AUTO_INCREMENT,
  `Date` varchar(45) DEFAULT NULL,
  `Reason` varchar(45) DEFAULT NULL,
  `IsAproved` varchar(45) DEFAULT NULL,
  `IsActive` varchar(45) DEFAULT NULL,
  `CreaedBy` varchar(45) DEFAULT NULL,
  `idLoan` int(11) NOT NULL,
  PRIMARY KEY (`idLoanCancellation`),
  KEY `fk_LoanCancellation_Loan1_idx` (`idLoan`),
  CONSTRAINT `fk_LoanCancellation_Loan1` FOREIGN KEY (`idLoan`) REFERENCES `loan` (`idLoan`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for login
-- ----------------------------
DROP TABLE IF EXISTS `login`;
CREATE TABLE `login` (
  `idLogin` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(45) DEFAULT NULL,
  `Password` varchar(45) DEFAULT NULL,
  `Type` varchar(45) DEFAULT NULL,
  `SetDate` varchar(45) DEFAULT NULL,
  `idStaff` int(11) NOT NULL,
  `loginBlock` varchar(45) DEFAULT NULL,
  `IsActive` varchar(45) DEFAULT NULL,
  `IsAprove` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idLogin`),
  KEY `fk_Login_Staff1_idx` (`idStaff`),
  CONSTRAINT `fk_Login_Staff1` FOREIGN KEY (`idStaff`) REFERENCES `staff` (`idStaff`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for members
-- ----------------------------
DROP TABLE IF EXISTS `members`;
CREATE TABLE `members` (
  `idMembers` int(11) NOT NULL AUTO_INCREMENT,
  `MemberNo` varchar(45) DEFAULT NULL,
  `GroupId` varchar(45) DEFAULT NULL,
  `NameWithInitials` varchar(45) DEFAULT NULL,
  `FullName` varchar(100) DEFAULT NULL,
  `Nic` varchar(45) DEFAULT NULL,
  `DOB` varchar(45) DEFAULT NULL,
  `Address1` varchar(45) DEFAULT NULL,
  `Address2` varchar(45) DEFAULT NULL,
  `City` varchar(45) DEFAULT NULL,
  `ContactNo` varchar(45) DEFAULT NULL,
  `HusbandName` varchar(45) DEFAULT NULL,
  `HusbandNic` varchar(45) DEFAULT NULL,
  `Husbandjob` varchar(45) DEFAULT NULL,
  `HusbandDOB` varchar(45) DEFAULT NULL,
  `IsActive` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `Aproved` varchar(45) DEFAULT NULL,
  `idCenter` int(11) NOT NULL,
  PRIMARY KEY (`idMembers`),
  KEY `fk_Members_Center1_idx` (`idCenter`),
  CONSTRAINT `fk_Members_Center1` FOREIGN KEY (`idCenter`) REFERENCES `center` (`idCenter`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=915 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for OtherIncomeAcc
-- ----------------------------
DROP TABLE IF EXISTS `OtherIncomeAcc`;
CREATE TABLE `OtherIncomeAcc` (
  `idOtherIncome` int(11) NOT NULL AUTO_INCREMENT,
  `AccDate` varchar(45) DEFAULT NULL,
  `Description` varchar(45) DEFAULT NULL,
  `Credit` double DEFAULT NULL,
  `Debit` double DEFAULT NULL,
  `IsActive` varchar(45) DEFAULT NULL,
  `CreateBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idOtherIncome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for printvoucher
-- ----------------------------
DROP TABLE IF EXISTS `printvoucher`;
CREATE TABLE `printvoucher` (
  `idPrintVoucher` int(11) NOT NULL,
  `Date` varchar(45) DEFAULT NULL,
  `Amount` varchar(45) DEFAULT NULL,
  `Isactive` varchar(45) DEFAULT NULL,
  `IsAprove` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idPrintVoucher`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for repayment
-- ----------------------------
DROP TABLE IF EXISTS `repayment`;
CREATE TABLE `repayment` (
  `idRePayment` int(11) NOT NULL AUTO_INCREMENT,
  `RepaymentAmount` double DEFAULT NULL,
  `PaidAmount` double DEFAULT NULL,
  `Date` varchar(45) DEFAULT NULL,
  `ActualDay` varchar(45) DEFAULT NULL,
  `CurrentDay` varchar(45) DEFAULT NULL,
  `idLoan` int(11) NOT NULL,
  `IsActive` varchar(45) DEFAULT NULL,
  `IsAproved` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `RecieptNo` varchar(45) DEFAULT NULL,
  `Arreas` varchar(255) DEFAULT '0',
  PRIMARY KEY (`idRePayment`),
  KEY `fk_RePayment_Loan1_idx` (`idLoan`),
  CONSTRAINT `fk_RePayment_Loan1` FOREIGN KEY (`idLoan`) REFERENCES `loan` (`idLoan`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for repaymentcancellation
-- ----------------------------
DROP TABLE IF EXISTS `repaymentcancellation`;
CREATE TABLE `repaymentcancellation` (
  `idRepaymentCancellation` int(11) NOT NULL AUTO_INCREMENT,
  `Date` varchar(45) DEFAULT NULL,
  `Reason` varchar(45) DEFAULT NULL,
  `IsAproved` varchar(45) DEFAULT NULL,
  `IsActive` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `idRePayment` int(11) NOT NULL,
  PRIMARY KEY (`idRepaymentCancellation`),
  KEY `fk_RepaymentCancellation_RePayment1_idx` (`idRePayment`),
  CONSTRAINT `fk_RepaymentCancellation_RePayment1` FOREIGN KEY (`idRePayment`) REFERENCES `repayment` (`idRePayment`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for resignation
-- ----------------------------
DROP TABLE IF EXISTS `resignation`;
CREATE TABLE `resignation` (
  `idResignation` int(11) NOT NULL AUTO_INCREMENT,
  `Request Date` varchar(45) DEFAULT NULL,
  `Resihnation Date` varchar(45) DEFAULT NULL,
  `Reason` varchar(45) DEFAULT NULL,
  `IsActive` varchar(45) DEFAULT NULL,
  `IsAproved` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `idStaff` int(11) NOT NULL,
  PRIMARY KEY (`idResignation`),
  KEY `fk_Resignation_Staff1_idx` (`idStaff`),
  CONSTRAINT `fk_Resignation_Staff1` FOREIGN KEY (`idStaff`) REFERENCES `staff` (`idStaff`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `idStaff` int(11) NOT NULL AUTO_INCREMENT,
  `Nic` varchar(45) DEFAULT NULL,
  `LicenceNo` varchar(45) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `Address1` varchar(45) DEFAULT NULL,
  `Address2` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `Contact1` varchar(45) DEFAULT NULL,
  `contact2` varchar(45) DEFAULT NULL,
  `Basic Salary` varchar(45) DEFAULT NULL,
  `EtfNo` varchar(45) DEFAULT NULL,
  `EpfNo` varchar(45) DEFAULT NULL,
  `DOB` varchar(45) DEFAULT NULL,
  `joiningDate` varchar(45) DEFAULT NULL,
  `Position` varchar(45) DEFAULT NULL,
  `IsActive` varchar(45) DEFAULT NULL,
  `Createdby` varchar(45) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Gender` varchar(45) DEFAULT NULL,
  `Photo` varchar(45) DEFAULT NULL,
  `NameWithinitials` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idStaff`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for staff_has_allowance
-- ----------------------------
DROP TABLE IF EXISTS `staff_has_allowance`;
CREATE TABLE `staff_has_allowance` (
  `idStaff` int(11) NOT NULL,
  `idAllowance` int(11) NOT NULL,
  `Date` varchar(45) DEFAULT NULL,
  `Amount` varchar(45) DEFAULT NULL,
  `idStaff_has_Allowance` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idStaff_has_Allowance`),
  KEY `fk_Staff_has_Allowance_Allowance1_idx` (`idAllowance`),
  KEY `fk_Staff_has_Allowance_Staff1_idx` (`idStaff`),
  CONSTRAINT `fk_Staff_has_Allowance_Allowance1` FOREIGN KEY (`idAllowance`) REFERENCES `allowance` (`idAllowance`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Staff_has_Allowance_Staff1` FOREIGN KEY (`idStaff`) REFERENCES `staff` (`idStaff`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for staff_has_deductions
-- ----------------------------
DROP TABLE IF EXISTS `staff_has_deductions`;
CREATE TABLE `staff_has_deductions` (
  `idStaff` int(11) NOT NULL,
  `idDeductions` int(11) NOT NULL,
  `Date` varchar(45) DEFAULT NULL,
  `Amount` varchar(45) DEFAULT NULL,
  `idStaff_has_Deductions` int(11) NOT NULL AUTO_INCREMENT,
  `IsActive` varchar(45) DEFAULT NULL,
  `Isaprove` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idStaff_has_Deductions`),
  KEY `fk_Staff_has_Deductions_Deductions1_idx` (`idDeductions`),
  KEY `fk_Staff_has_Deductions_Staff1_idx` (`idStaff`),
  CONSTRAINT `fk_Staff_has_Deductions_Deductions1` FOREIGN KEY (`idDeductions`) REFERENCES `deductions` (`idDeductions`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Staff_has_Deductions_Staff1` FOREIGN KEY (`idStaff`) REFERENCES `staff` (`idStaff`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for staffattedence
-- ----------------------------
DROP TABLE IF EXISTS `staffattedence`;
CREATE TABLE `staffattedence` (
  `idStaffAttedence` int(11) NOT NULL AUTO_INCREMENT,
  `Date` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `Intime` varchar(45) DEFAULT NULL,
  `Outtime` varchar(45) DEFAULT NULL,
  `Specialnote` varchar(45) DEFAULT NULL,
  `isDelete` varchar(45) DEFAULT NULL,
  `idStaff` int(11) NOT NULL,
  `IsActive` varchar(45) DEFAULT NULL,
  `IsAprove` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idStaffAttedence`),
  KEY `fk_StaffAttedence_Staff1_idx` (`idStaff`),
  CONSTRAINT `fk_StaffAttedence_Staff1` FOREIGN KEY (`idStaff`) REFERENCES `staff` (`idStaff`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for staffleave
-- ----------------------------
DROP TABLE IF EXISTS `staffleave`;
CREATE TABLE `staffleave` (
  `idstaffLeave` int(11) NOT NULL AUTO_INCREMENT,
  `StartDate` varchar(45) DEFAULT NULL,
  `EndDate` varchar(45) DEFAULT NULL,
  `LeaveType` varchar(45) DEFAULT NULL,
  `isDelete` varchar(45) DEFAULT NULL,
  `idStaff` int(11) NOT NULL,
  `RequestedDate` varchar(45) DEFAULT NULL,
  `IsAprove` varchar(45) DEFAULT NULL,
  `IsActive` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  `Reason` varchar(45) DEFAULT NULL,
  `TotalDays` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idstaffLeave`),
  KEY `fk_staffLeave_Staff1_idx` (`idStaff`),
  CONSTRAINT `fk_staffLeave_Staff1` FOREIGN KEY (`idStaff`) REFERENCES `staff` (`idStaff`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for staffsalary
-- ----------------------------
DROP TABLE IF EXISTS `staffsalary`;
CREATE TABLE `staffsalary` (
  `idStaffSalary` int(11) NOT NULL AUTO_INCREMENT,
  `date` varchar(45) DEFAULT NULL,
  `BasicSalary` varchar(45) DEFAULT NULL,
  `TotalSalary` varchar(45) DEFAULT NULL,
  `TotalAllowance` varchar(45) DEFAULT NULL,
  `totalDeductions` varchar(45) DEFAULT NULL,
  `Etf` varchar(45) DEFAULT NULL,
  `Epf` varchar(45) DEFAULT NULL,
  `NetSalary` varchar(45) DEFAULT NULL,
  `isDelete` varchar(45) DEFAULT NULL,
  `TotalPayments` varchar(45) DEFAULT NULL,
  `idStaff` int(11) NOT NULL,
  `IsActive` varchar(45) DEFAULT NULL,
  `IsAprove` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idStaffSalary`),
  KEY `fk_StaffSalary_Staff1_idx` (`idStaff`),
  CONSTRAINT `fk_StaffSalary_Staff1` FOREIGN KEY (`idStaff`) REFERENCES `staff` (`idStaff`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
