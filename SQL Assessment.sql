DROP TABLE POLICY
DROP TABLE Benefit

CREATE TABLE Policy(
PolicyNumber	VARCHAR(8),	
ContractStatus	VARCHAR(1),--	A for active, S for suspended, T for terminated
Type	VARCHAR(1),--	P for Permanent Life, T for Term
Premium	DECIMAL(18,2),	
DeathBenefit	DECIMAL(18,2)	) 

 
INSERT INTO POLICY Values('00000001','T','P',10000.00,500000.00)
INSERT INTO POLICY Values('00000002','S','T',100.00,100000.00)
INSERT INTO POLICY Values('00000003','A','T',200.00,300000.00)
INSERT INTO POLICY Values('00000004','A','P',15000.00,2000000.00)
INSERT INTO POLICY Values('00000005','A','T',500.00,700000.00)

		
CREATE Table Benefit		( 
PolicyNumber	VARCHAR(8),	
BenefitNum	INT,	
BenefitType	VARCHAR(1),--	B for base benefit, F for other funds
CashValue	DECIMAL(18,2) --	Cash value of the benefit
)
 
insert into Benefit values ('00000001',1,'B',1000000.00)
insert into Benefit values ('00000001',2,'F',200000.00)
insert into Benefit values ('00000001',3,'F',5000.00)
insert into Benefit values ('00000004',1,'B',2000000.00)
insert into Benefit values ('00000004',2,'F',500000.00)
insert into Benefit values ('00000004',3,'F',100.00)

 


 
 SELECT
TRANS.POLICY_NUM AS PolicyNumber,POL.ContractStatus,POL.Type,POL.Premium,
CASE WHEN POL.CONTRACTSTATUS='T' THEN 0 ELSE DEATHBENEFIT END AS DeathBenefit,
CASE WHEN POL.ContractStatus='T' THEN TRANS.AMOUNT ELSE TRANS. AMOUNT+POL.DeathBenefit END AS PolicyValue
 FROM
(
SELECT POL.POLICYNUMBER POLICY_NUM,SUM(ISNULL(BEN.CASHVALUE,0)) AMOUNT
FROM POLICY AS POL
LEFT JOIN BENEFIT AS BEN ON POL.POLICYNUMBER = BEN.POLICYNUMBER
GROUP BY POL.POLICYNUMBER
) AS TRANS
 LEFT JOIN POLICY AS POL
ON POL.PolicyNumber=POLICY_NUM
 ORDER BY POLICY_NUM
 

  