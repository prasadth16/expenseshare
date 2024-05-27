create table tbl_user_registration(
	user_id character varying(20),
	user_email character varying(50) not null,
	user_name character varying (100) not null,
	user_phone character (10),
	rec_lgcl_del_ind boolean,
	rec_creation_time timestamp,
	rec_updated_time timestamp,
	updated_by character varying(20),
	created_by character varying(20),
	primary key(user_id)
);
create unique index user_rgstr_email on tbl_user_registration(user_email);
--drop table tbl_user_registration

create table tbl_user_invitation(
	inviter_id character varying(20) references tbl_user_registration(user_id),
	user_email character varying(50) not null,
	registration_link text,
	rec_creation_time timestamp,
	rec_updated_time timestamp,
	updated_by character varying(20),
	created_by character varying(20),
	rec_lgcl_del_ind boolean
);
--drop table tbl_user_invitation;

create table tbl_user_settings(
	user_id character varying(20) references tbl_user_registration(user_id),
	user_password varchar(20),
	rec_creation_time timestamp,
	rec_updated_time timestamp,
	updated_by character varying(20),
	created_by character varying(20),
	rec_lgcl_del_ind boolean
);
--drop table tbl_user_settings;

create table tbl_expense_details(
	expense_id uuid primary key,
	owner_id varchar(20) references tbl_user_registration(user_id),
	expense_name varchar(50),
	expense_description text,
	group_size smallint,
	expense_status char(2),
	rec_creation_time timestamp,
	rec_updated_time timestamp,
	updated_by character varying(20),
	created_by character varying(20),
	rec_lgcl_del_ind boolean	
);
--drop table tbl_expense_details;

create table tbl_expense_transactions(
	expense_id uuid references tbl_expense_details(expense_id),
	transaction_id smallint,
	transaction_type char(1),
	trans_name varchar(50),
	trans_description text,
	payer_id references tbl_user_registration(user_id),
	rec_creation_time timestamp,
	rec_updated_time timestamp,
	updated_by character varying(20),
	created_by character varying(20),
	rec_lgcl_del_ind boolean,
	primary key(transaction_id, expense_id)
);
--drop table tbl_expense_transactions;

create table tbl_semi_dstrb_transactions(
	expense_id uuid references tbl_expense_details(expense_id),
	transaction_id smallint references tbl_expense_transactions(transaction_id),
	owe_by character varying(20) references tbl_user_registration(user_id),
	rec_creation_time timestamp,
	rec_updated_time timestamp,
	updated_by character varying(20),
	created_by character varying(20),
	rec_lgcl_del_ind boolean
);
--drop table tbl_semi_dstrb_transactions;

create table tbl_fnl_expnc_reconsilation(
	owe_by character varying(20) references tbl_user_registration(user_id),
	owe_to character varying(20) references tbl_user_registration(user_id),
	amount varchar(10),
	rec_creation_time timestamp,
	rec_updated_time timestamp,
	updated_by character varying(20),
	created_by character varying(20),
	rec_lgcl_del_ind boolean
);
--drop table tbl_fnl_expnc_reconsilation;

create table tbl_fnl_expnc_reconsilation_json(
	expense_id uuid references tbl_expense_details(expense_id),
	recon_json jsonb,
	rec_creation_time timestamp,
	rec_updated_time timestamp,
	updated_by character varying(20),
	created_by character varying(20),
	rec_lgcl_del_ind boolean
);
--drop table tbl_fnl_expnc_reconsilation_json;








