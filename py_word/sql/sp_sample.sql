USE [YCY_COMMISSION]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_emd_commission_test]    Script Date: 5/11/2022 3:59:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
how to clear all of emd_commission_record for rerun
eg: Commission: Nov

DELETE FROM emd_monthly_comm where commission = '202111';
DELETE FROM emd_monthly_rowsales where createtime >= '2021-12-01';
DELETE FROM emd_monthly_supp_comm where commission_month = '202111';
DELETE FROM main_monthly_supp_comm where commission_month = '202111';
*/

-- exec sp_insert_emd_commission_test '202103'
-- exec sp_insert_emd_commission_test '202103'
-- exec sp_insert_emd_commission_test '202105'
-- exec sp_insert_emd_commission_test '202106'
-- exec sp_insert_emd_commission_test '202108'
-- exec sp_insert_emd_commission_test '202110'
-- exec sp_insert_emd_commission_test '202111'
-- exec sp_insert_emd_commission_test '202112'
-- exec sp_insert_emd_commission_test '202201'
ALTER PROCEDURE [dbo].[sp_insert_emd_commission_test] @commision varchar(6) 


WITH EXEC AS CALLER
AS
DECLARE @targetmonth as varchar(6)
SET  @targetmonth = '202004'
DECLARE @commision_year as varchar(4)
SET @commision_year = LEFT(@commision, 4) -- eg: 202101 -> 2021
DECLARE @commision_month as varchar(2)
SET @commision_month = RIGHT(@commision, 2) -- eg: 202101 -> 01

DECLARE @commision_last_day as datetime
DECLARE @commision_last_day_str as char(10)
SET @commision_last_day_str = EOMONTH(@commision_year+'-'+@commision_month+'-01', 0)-- eg: 202101 -> 2021-01-01 -> 2021-01-31
select  @commision_last_day = cast(convert(char(10), @commision_last_day_str, 112) + ' 23:59:59.99' as datetime)

DECLARE @MyTableType as table
(
	[masterinvcode] [varchar](20) NULL,
	[invcode] [varchar](20) NULL,
	[invdate] [datetime] NULL,
	[shopcode] [varchar](10) NULL,
	[refinvcode] [varchar](100) NULL,
	[clientcode] [varchar](10) NULL,
	[clientname] [varchar](MAX) NULL,
	[salesman] [varchar](100) NULL,
	[deliverdate] [datetime] NULL,
	[deliverstatus] [varchar](100) NULL,
	[paymentdate] [datetime] NULL,
	[paymentstatus] [varchar](100) NULL,
	[sales_amt] [decimal](15, 2) NULL,
	[profit_amt] [decimal](15, 2) NULL,
	[gp_ratio] [decimal](15, 2) NULL,
	[salescom] [decimal](15, 3) NULL,
	[wholesalecom] [decimal](15, 3) NULL,
	[approvedpayamount] [decimal](15, 2) NULL,
	[nonapprovedpayamount] [decimal](15, 2) NULL,
	[closingmonth] [varchar](100) NULL,
	[commision] [varchar](100) NULL,
	[actualbankcharge] [decimal](15, 3) NULL,
	[actualdelivercharge] [decimal](15, 3) NULL,
	[projectcode] [varchar](20) NULL,
	[main_refinv] [varchar](20) NULL,
	[project_completion] [varchar](20) NULL
)  

DECLARE @tmp_emd_monthly_comm as table
(
	[masterinvcode] [varchar](20) NULL,
	[invcode] [varchar](20) NULL,
	[invdate] [datetime] NULL,
	[shopcode] [varchar](10) NULL,
	[refinvcode] [varchar](100) NULL,
	[clientcode] [varchar](10) NULL,
	[clientname] [varchar](MAX) NULL,
	[salesman] [varchar](100) NULL,
	[deliverdate] [datetime] NULL,
	[deliverstatus] [varchar](100) NULL,
	[paymentdate] [datetime] NULL,
	[paymentstatus] [varchar](100) NULL,
	[sales_amt] [decimal](15, 2) NULL,
	[profit_amt] [decimal](15, 2) NULL,
	[gp_ratio] [decimal](15, 2) NULL,
	[salescom] [decimal](15, 3) NULL,
	[wholesalecom] [decimal](15, 3) NULL,
	[approvedpayamount] [decimal](15, 2) NULL,
	[nonapprovedpayamount] [decimal](15, 2) NULL,
	[closingmonth] [varchar](100) NULL,
	[commision] [varchar](100) NULL,
	[actualbankcharge] [decimal](15, 3) NULL,
	[actualdelivercharge] [decimal](15, 3) NULL,
	[projectcode] [varchar](20) NULL,
	[main_refinv] [varchar](20) NULL,
	[project_completion] [varchar](20) NULL,
	[commission_fee] [decimal](15, 2) NULL,
	[sd_commission_fee] [decimal](15, 3) NULL,
	[sd_staffcode] [varchar](10) NULL,
	[commissionrate] [decimal](15, 3) NULL,
	[sd_commissionrate] [decimal](15, 3) NULL,
	[salesamountrate] [decimal](15, 3) NULL,
	[master_paymentstatus] [varchar](100) NULL
)  
BEGIN TRAN

INSERT @MyTableType
EXEC sp_select_emd_sales

UPDATE @MyTableType SET commision = NULL where commision = @commision; --test only SET commission is NULL where commission is target commission

INSERT INTO @tmp_emd_monthly_comm  ([masterinvcode]
           ,[invcode]
           ,[invdate]
           ,[shopcode]
           ,[refinvcode]
           ,[clientcode]
           ,[clientname]
           ,[salesman]
           ,[deliverdate]
           ,[deliverstatus]
           ,[paymentdate]
           ,[paymentstatus]
           ,[sales_amt]
           ,[profit_amt]
           ,[gp_ratio]
           ,[salescom]
           ,[wholesalecom]
           ,[approvedpayamount]
           ,[nonapprovedpayamount]
           ,[closingmonth]
           ,[commision]
           ,[actualbankcharge]
           ,[actualdelivercharge]
           ,[projectcode]
           ,[main_refinv]
           ,[project_completion]
           ,[commission_fee]
           ,[sd_commission_fee]
           ,[sd_staffcode]
           ,[commissionrate]
           ,[sd_commissionrate]) SELECT [masterinvcode]
			  ,[invcode]
			  ,[invdate]
			  ,[shopcode]
			  ,[refinvcode]
			  ,[clientcode]
			  , convert(varchar(MAX), convert(varbinary(MAX), [clientname], 2))
			  ,[salesman]
			  ,[deliverdate]
			  ,CASE WHEN [deliverstatus] = 'Delivered' THEN '已送貨'
					WHEN [deliverstatus] = 'Non Delivery' THEN '未送貨'
					WHEN [deliverstatus] = 'Received' THEN '已收貨'
					WHEN [deliverstatus] = 'Non Receive' THEN '未收貨'
					WHEN [deliverstatus] = 'Canceled' THEN '已全退'
					WHEN [deliverstatus] = 'Part Of Delivered' THEN '部份已送貨'
					 ELSE [deliverstatus] END AS [deliverstatus]
			  ,[paymentdate]
			  ,CASE WHEN [paymentstatus] = 'Paid' THEN '已付'
					WHEN [paymentstatus] = 'UnPaid' THEN '未付'
					 ELSE [paymentstatus] END AS [paymentstatus]
			  ,[sales_amt]
			  ,[profit_amt]
			  ,[gp_ratio]
			  ,[salescom]
			  ,[wholesalecom]
			  ,[approvedpayamount]
			  ,[nonapprovedpayamount]
			  ,[closingmonth]
			  ,[commision]
			  ,[actualbankcharge]
			  ,[actualdelivercharge]
			  ,[projectcode]
			  ,[main_refinv]
			  ,[project_completion]
			  ,NULL
			  ,NULL
			  ,NULL
			  ,NULL
			  ,NULL
		  FROM @MyTableType


DECLARE @each_salesman varchar(255)
--DECLARE @each_sales_amt varchar(255)


DECLARE the_cursor CURSOR FOR 
SELECT DISTINCT salesman FROM @MyTableType; --DISTINCT salesman from pos emd result
OPEN the_cursor
FETCH NEXT FROM the_cursor INTO @each_salesman
WHILE @@FETCH_STATUS = 0
BEGIN
	DECLARE @sd_staffcode varchar(10)
	DECLARE @commissionrate decimal(15,2)
	DECLARE @sd_commissionrate decimal(15,2)
	
	--emd part start

	SET @commissionrate = 0
	SET @sd_commissionrate = 0
	SELECT
		@sd_staffcode = smr.sd_staffcode,
		@commissionrate  = smr.commissionrate,
		@sd_commissionrate = omr.commissionrate
	FROM
		emd_sales_manager_rate AS smr
	LEFT JOIN emd_operation_manager_rate AS omr ON smr.sd_staffcode = omr.staffcode AND omr.startcommission <= @commision AND omr.endcommission >= @commision
	WHERE
		smr.startcommission <= @commision
	AND smr.endcommission >= @commision
	AND smr.staffcode = @each_salesman

	IF @commissionrate IS NULL 
		SET @commissionrate = 0

	IF @sd_commissionrate IS NULL 
		SET @sd_commissionrate = 0

	UPDATE @tmp_emd_monthly_comm SET commission_fee = profit_amt * @commissionrate, 
							sd_commission_fee = profit_amt * @sd_commissionrate, 
							sd_staffcode = @sd_staffcode, 
							commissionrate = @commissionrate, 
							sd_commissionrate = @sd_commissionrate
						WHERE salesman = @each_salesman AND shopcode = 'EMD'; --EMD
	--emd part end

	--main part start
	DECLARE @salesamountrate decimal(15,2)
	SET @commissionrate = 0
	SET @salesamountrate = 0
	SELECT
		@sd_staffcode = NULL,
		@commissionrate  = smr.commissionrate,
		@salesamountrate  = smr.salesamountrate,
		@sd_commissionrate = 0
	FROM
		main_sales_manager_rate AS smr
	WHERE
		smr.startcommission <= @commision
	AND smr.endcommission >= @commision
	AND smr.staffcode = @each_salesman

	IF @commissionrate IS NULL 
		SET @commissionrate = 0

	IF @sd_commissionrate IS NULL 
		SET @sd_commissionrate = 0

	UPDATE @tmp_emd_monthly_comm SET commission_fee = sales_amt * @commissionrate * @salesamountrate,  
							commissionrate = @commissionrate,
							salesamountrate = @salesamountrate  
						WHERE salesman = @each_salesman AND shopcode = 'MAIN'; --EMD

	--main part end

	FETCH NEXT FROM the_cursor INTO @each_salesman
END
CLOSE the_cursor
DEALLOCATE the_cursor

--INSERT W Invoice With custom commission
INSERT INTO emd_monthly_comm (
masterinvcode,
invcode,
invdate,
shopcode,
refinvcode,
clientcode,
clientname,
salesman,
deliverdate,
deliverstatus,
paymentdate,
paymentstatus,
actualsalesamount,
actualprofit,
gp_ratio,
salescomm,
wholesalecom,
approvedpayamount,
nonapprovedpayamount,
closingmonth,
commission,
actualbankcharge,
actualdelivercharge,
projectcode,
main_refinv,
project_completion,
commission_fee,
sd_commission_fee,
sd_staffcode,
commissionrate,
salesamountrate,
sd_commissionrate,
master_paymentstatus
) SELECT masterinvcode,
invcode,
invdate,
shopcode,
refinvcode,
clientcode,
clientname,
salesman,
deliverdate,
deliverstatus,
paymentdate,
paymentstatus,
sales_amt,
profit_amt,
gp_ratio,
salescom,
wholesalecom,
approvedpayamount,
nonapprovedpayamount,
closingmonth,
@commision,
actualbankcharge,
actualdelivercharge,
projectcode,
main_refinv,
project_completion,
commission_fee,
sd_commission_fee,
sd_staffcode,
commissionrate,
salesamountrate,
sd_commissionrate,
master_paymentstatus
FROM @tmp_emd_monthly_comm 
where deliverstatus IN ('已送貨','已收貨','已全退') AND 
	  deliverdate <= @commision_last_day AND 
	  paymentdate <= @commision_last_day  AND 
	  paymentstatus = '已付' AND 
	  project_completion = 'c' AND 
	  salesman <> 'INTERNAL' AND
	  (LEFT(invcode,1) = 'W' OR
	  DATALENGTH(projectcode) = 0 
	  )AND
	  commision IS NULL;  

--CHECK X invoice with projectcode
DECLARE @each_masterinvcode varchar(255)
DECLARE x_invoice_cursor CURSOR FOR 
SELECT masterinvcode FROM @tmp_emd_monthly_comm WHERE DATALENGTH(projectcode) > 10 AND LEFT(invcode,1) = 'X';
OPEN x_invoice_cursor
FETCH NEXT FROM x_invoice_cursor INTO @each_masterinvcode
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE @tmp_emd_monthly_comm  
	SET master_paymentstatus = (SELECT paymentstatus FROM @tmp_emd_monthly_comm WHERE invcode = @each_masterinvcode) WHERE masterinvcode = @each_masterinvcode
	FETCH NEXT FROM x_invoice_cursor INTO @each_masterinvcode
END
CLOSE x_invoice_cursor
DEALLOCATE x_invoice_cursor


--INSERT X Invoice
INSERT INTO emd_monthly_comm (
masterinvcode,
invcode,
invdate,
shopcode,
refinvcode,
clientcode,
clientname,
salesman,
deliverdate,
deliverstatus,
paymentdate,
paymentstatus,
actualsalesamount,
actualprofit,
gp_ratio,
salescomm,
wholesalecom,
approvedpayamount,
nonapprovedpayamount,
closingmonth,
commission,
actualbankcharge,
actualdelivercharge,
projectcode,
main_refinv,
project_completion,
commission_fee,
sd_commission_fee,
sd_staffcode,
commissionrate,
sd_commissionrate,
master_paymentstatus
) SELECT masterinvcode,
invcode,
invdate,
shopcode,
refinvcode,
clientcode,
clientname,
salesman,
deliverdate,
deliverstatus,
paymentdate,
paymentstatus,
sales_amt,
profit_amt,
gp_ratio,
salescom,
wholesalecom,
approvedpayamount,
nonapprovedpayamount,
closingmonth,
@commision,
actualbankcharge,
actualdelivercharge,
projectcode,
main_refinv,
project_completion,
commission_fee,
sd_commission_fee,
sd_staffcode,
commissionrate,
sd_commissionrate,
master_paymentstatus
FROM @tmp_emd_monthly_comm 
where deliverstatus IN ('已送貨','已收貨','已全退') AND 
	  deliverdate <= @commision_last_day AND 
	  paymentdate <= @commision_last_day  AND 
	  master_paymentstatus = '已付' AND 
	  project_completion = 'c' AND 
	  salesman <> 'INTERNAL' AND
	   DATALENGTH(projectcode) > 10 AND
	  LEFT(invcode,1) = 'X' AND
	  commision IS NULL;

--INSERT X Invoice of MAIN (paymentdate IS NULL OF master_paymentstatus IS NULL)
INSERT INTO emd_monthly_comm (
masterinvcode,
invcode,
invdate,
shopcode,
refinvcode,
clientcode,
clientname,
salesman,
deliverdate,
deliverstatus,
paymentdate,
paymentstatus,
actualsalesamount,
actualprofit,
gp_ratio,
salescomm,
wholesalecom,
approvedpayamount,
nonapprovedpayamount,
closingmonth,
commission,
actualbankcharge,
actualdelivercharge,
projectcode,
main_refinv,
project_completion,
commission_fee,
sd_commission_fee,
sd_staffcode,
commissionrate,
sd_commissionrate,
master_paymentstatus
) SELECT masterinvcode,
invcode,
invdate,
shopcode,
refinvcode,
clientcode,
clientname,
salesman,
deliverdate,
deliverstatus,
paymentdate,
paymentstatus,
sales_amt,
profit_amt,
gp_ratio,
salescom,
wholesalecom,
approvedpayamount,
nonapprovedpayamount,
closingmonth,
@commision,
actualbankcharge,
actualdelivercharge,
projectcode,
main_refinv,
project_completion,
commission_fee,
sd_commission_fee,
sd_staffcode,
commissionrate,
sd_commissionrate,
master_paymentstatus
FROM @tmp_emd_monthly_comm 
where deliverstatus IN ('已送貨','已收貨','已全退') AND 
	  deliverdate <= @commision_last_day AND 
	  project_completion = 'c' AND 
	  paymentstatus = '已付' AND
	  salesman <> 'INTERNAL' AND
	   DATALENGTH(projectcode) > 10 AND
	  LEFT(invcode,1) = 'X' AND
	  commision IS NULL AND
	  (master_paymentstatus IS NULL OR 
	  paymentdate  IS NULL);

--INSERT rowsales
INSERT INTO emd_monthly_rowsales (
masterinvcode,
invcode,
invdate,
shopcode,
refinvcode,
clientcode,
clientname,
salesman,
deliverdate,
deliverstatus,
paymentdate,
paymentstatus,
actualsalesamount,
actualprofit,
gp_ratio,
salescomm,
wholesalecom,
approvedpayamount,
nonapprovedpayamount,
closingmonth,
commission,
actualbankcharge,
actualdelivercharge,
projectcode,
main_refinv,
project_completion,
master_paymentstatus,
createtime
) SELECT masterinvcode,
invcode,
invdate,
shopcode,
refinvcode,
clientcode,
clientname,
salesman,
deliverdate,
deliverstatus,
paymentdate,
paymentstatus,
sales_amt,
profit_amt,
gp_ratio,
salescom,
wholesalecom,
approvedpayamount,
nonapprovedpayamount,
closingmonth,
commision, --update from @commission to commision
actualbankcharge,
actualdelivercharge,
projectcode,
main_refinv,
project_completion,
master_paymentstatus,
getDate()
FROM @tmp_emd_monthly_comm 
/*where deliverstatus IN ('已送貨','已收貨','已全退') AND 
	  deliverdate <= @commision_last_day AND 
	  paymentdate <= @commision_last_day  AND 
	  project_completion = 'c' AND 
	  salesman <> 'INTERNAL' AND
	   DATALENGTH(projectcode) > 10 AND
	  commision IS NULL AND
	  master_paymentstatus <> '已付' OR 
	  paymentstatus <> '已付';*/


DECLARE @total_emd_profit_amt decimal(15,3)
SELECT @total_emd_profit_amt  = SUM(actualprofit) FROM emd_monthly_comm WHERE commission = @commision AND shopcode = 'EMD';


DECLARE @each_commissionrate decimal(15,4)
DECLARE @each_staffcode varchar(255)
DECLARE the_supp_cursor CURSOR FOR 
SELECT
	commissionrate,staffcode
FROM
	emd_division_bonus_rate
WHERE
	startcommission <= @commision
AND endcommission >= @commision
AND status = 1
OPEN the_supp_cursor
FETCH NEXT FROM the_supp_cursor INTO @each_commissionrate,@each_staffcode
WHILE @@FETCH_STATUS = 0
BEGIN  
	INSERT INTO emd_monthly_supp_comm(commission_month, user_group, commission_rate, commissionfee)
		VALUES (@commision, @each_staffcode, @each_commissionrate, @total_emd_profit_amt * @each_commissionrate)
	FETCH NEXT FROM the_supp_cursor INTO @each_commissionrate,@each_staffcode
--SELECT * FROM @MyTableType AS mt LEFT JOIN operation_manger_rate as omr ON mt.salesman = omr.staffcode
END
CLOSE the_supp_cursor
DEALLOCATE the_supp_cursor 

DECLARE @total_main_profit_amt decimal(15,3)
SELECT @total_main_profit_amt  = SUM(actualsalesamount * salesamountrate) FROM emd_monthly_comm WHERE commission = @commision AND shopcode = 'MAIN';

SET @each_commissionrate = 0;
SET @each_staffcode = '';
DECLARE the_main_supp_cursor CURSOR FOR 
SELECT
	commissionrate,staffcode
FROM
	main_division_bonus_rate
WHERE
	startcommission <= @commision
AND endcommission >= @commision
AND status = 1

OPEN the_main_supp_cursor
FETCH NEXT FROM the_main_supp_cursor INTO @each_commissionrate,@each_staffcode
WHILE @@FETCH_STATUS = 0
BEGIN  
	print @total_main_profit_amt
	print @each_commissionrate
	print @total_main_profit_amt * @each_commissionrate
	INSERT INTO main_monthly_supp_comm(commission_month, user_group, commission_rate, commissionfee)
		VALUES (@commision, @each_staffcode, @each_commissionrate, @total_main_profit_amt * @each_commissionrate)
	FETCH NEXT FROM the_main_supp_cursor INTO @each_commissionrate,@each_staffcode
--SELECT * FROM @MyTableType AS mt LEFT JOIN operation_manger_rate as omr ON mt.salesman = omr.staffcode
END

SELECT * from @MyTableType
SELECT * from @tmp_emd_monthly_comm
SELECT * from emd_monthly_comm
CLOSE the_main_supp_cursor
DEALLOCATE the_main_supp_cursor 
SELECT * FROM main_monthly_supp_comm
COMMIT