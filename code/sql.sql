
create table user
(
   userid int auto_increment,
   username varchar(20) not null,
   password varchar(20) not null,
   email varchar(30) null,
   realname varchar(20) null,
   phonenum varchar(20) null,
   community varchar(30) not null,
   constraint user_pk
      primary key (userid)
);
create table administrator
(
	adminid int auto_increment,
	adminname varchar(20) not null,
	password varchar(20) not null,
	type varchar(20) not null,
	constraint administrator_pk
		primary key (adminid)
);
create table message
(
	type varchar(20) not null,
	title varchar(20) not null,
	detail varchar(200) not null,
	time date not null,
	messageid int auto_increment,
	constraint message_pk
		primary key (messageid)
);

create table friend
(
	userid1 int not null,
	userid2 int not null
);
create table express
(
	phonenum varchar(20) not null,
	tim date not null,
	packageid int auto_increment,
    constraint service_pk
		primary key (packageid),
	company varchar(20) not null
);

create table service
(
	type varchar(20) not null,
	phonenum varchar(20) not null,
	serviceid int auto_increment,
	constraint service_pk
		primary key (serviceid)
);

create table desired
(
	time date not null,
	goods varchar(20) not null,
	desiredid int auto_increment,
	constraint desired_pk
		primary key (desiredid)
);

create table desireduser
(
	desiredid int not null,
	userid int not null
);
create table post
(
	postid int auto_increment,
	posttime date not null,
	poster varchar(20) not null,
	title varchar(20) not null,
	article varchar(200) not null,
	constraint post_pk
		primary key (postid)
);

create table comments
(
	userid int not null,
	postid int not null,
	message varchar(50) not null,
	time DATE not null
);

create table paid
(
	userid int not null,
	type varchar(20) not null,
	price int not null,
	time date not null,
	paidid int auto_increment,
	constraint paid_pk
		primary key (paidid)
);


