create table user(
	_id int primary key,
	username varchar(255) not null,
	password varchar(255) not null,
	is_admin tinyint(1) default 0,
	api_token varchar(255) default null,
	last_login_time datetime default null,
	organization_id int default null,
	efirms int default null,
	efirm_access int default null,
	access int default null,
	roles varchar(255) default null,
	privileges varchar(255) default null

);

