create database Assignment5Db

use Assignment5Db

create schema bank
create table bank.Customers(
CId int Primary key identity(1000,1),
Cname nvarchar(50) not null,
CEmail nvarchar(50) not null unique,
Contact nvarchar(10) not null unique,
CPwd as right(CName, 2) + convert(nvarchar(10), CId) +''+left(Contact, 2) persisted 
)
drop table bank.Customers
create table bank.MailInfo
(MailTo nvarchar(50),
MailDate date,
MailMessage nvarchar(100))

create trigger trgMail
ON bank.Customers
after insert
AS
begin
declare @cid int
declare @cname nvarchar(50)
declare @cmail nvarchar(50)
declare @contact nvarchar(10)
declare @cpwd nvarchar(50)
declare @message nvarchar(100)
select @cid=CId,@cname=Cname,@cmail=CEmail,@contact=Contact,
@cpwd=(right(Cname,2)+cast(CId as nvarchar(10))+left(Contact,2)) from inserted
select @message='Your net banking password is: '+@cpwd+' It is valid upto 2days only. Update it.' 

insert into bank.MailInfo values(@cmail,GETDATE(),@message)

if(@@ROWCOUNT>=1)
begin
print 'Inserted succesfully'
end
end

insert into bank.Customers(Cname,CEmail,Contact) values ('Ram','Ram@gmail.com','9111111111')

select * from bank.Customers
select * from bank.MailInfo