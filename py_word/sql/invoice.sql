select * from invoice where invoicenumber = 'MA00006818SWAP'

select * from invoicedetail where invoiceid = 1500000

select * from analysiscode where code = 'T555'

select * from InvoiceAnalysiscode where invoiceid = 1500000

begin tran
--insert InvoiceAnalysiscode values (1500000, 2839503, 2, 184, getdate(), 1)
update InvoiceAnalysiscode set analysiscodeid = 184 where invoicedetailid = 2839503 and analysisgroupid = 2
update invoicedetail set teamcodeid = 184 where id = 2839503
select * from invoice where invoicenumber = 'MA00006818SWAP'

select * from invoicedetail where invoiceid = 1500000

select * from analysiscode where code = 'T555'

select * from InvoiceAnalysiscode where invoiceid = 1500000
rollback
