-- limpeza do banco 
drop table if exists fines cascade;
drop table if exists loan_items cascade;
drop table if exists reservations cascade;
drop table if exists loans cascade;
drop table if exists author_book cascade;
drop table if exists book_copies cascade;
drop table if exists books cascade;
drop table if exists employees cascade;
drop table if exists users cascade;
drop table if exists authors cascade;
drop table if exists categories cascade;
drop table if exists publishers cascade;
drop table if exists user_types cascade;

create table publishers (
    id      int not null,
    name    varchar(150) not null,
    phone   varchar(30),
    email   varchar(150),
    website varchar(200),
    constraint pk_id_publisher primary key (id),
    constraint uq_publisher_email unique (email)
);

create table categories (
    id          int not null,
    name        varchar(100) not null,
    description varchar(255),
    is_active   boolean default true,
    constraint pk_id_category primary key (id),
    constraint uq_category_name unique (name)
);

create table user_types (
    id           int not null,
    name         varchar(50) not null,
    max_loans    int not null,
    loan_days    int not null,
    fine_per_day decimal(10,2) not null,
    is_active    boolean default true,
    constraint pk_id_user_type primary key (id),
    constraint uq_user_type_name unique (name)
);

create table authors (
    id          int not null,
    name        varchar(100) not null,
    birth_date  date,
    nationality varchar(80),
    constraint pk_id_author primary key (id)
);

create table users (
    id              int not null,
    full_name       varchar(150) not null,
    document_number char(11) not null,
    email           varchar(150) not null,
    phone           varchar(30),
    address         varchar(255),
    user_type_id    int not null,
    is_active       boolean default true,
    constraint pk_id_user primary key (id),
    constraint uq_user_cpf unique (document_number),
    constraint uq_user_email unique (email),
    constraint fk_user_type foreign key (user_type_id) references user_types(id)
);

create table employees (
    id              int not null,
    full_name       varchar(150) not null,
    document_number char(11) not null,
    email           varchar(150) not null,
    phone           varchar(30),
    role            varchar(80) not null,
    is_active       boolean default true,
    hired_at        date,
    constraint pk_id_employee primary key (id),
    constraint uq_employee_cpf unique (document_number),
    constraint uq_employee_email unique (email)
);

create table books (
    id               int not null,
    title            varchar(200) not null,
    isbn             varchar(20),
    edition          varchar(30),
    publication_year int,
    language         varchar(50) default 'Português',
    pages            int,
    summary          text,
    publisher_id     int,
    constraint pk_id_book primary key (id),
    constraint uq_book_isbn unique (isbn),
    constraint fk_book_publisher foreign key (publisher_id) references publishers(id)
);

create table book_copies (
    id               int not null,
    book_id          int not null,
    barcode          varchar(50) not null,
    acquisition_date date,
    status           varchar(30) not null default 'disponivel',
    location         varchar(100),
    notes            varchar(255),
    constraint pk_id_book_copy primary key (id),
    constraint uq_copy_barcode unique (barcode),
    constraint fk_copy_book foreign key (book_id) references books(id) on delete cascade
);

create table author_book (
    author_id int not null,
    book_id   int not null,
    constraint pk_author_book primary key (author_id, book_id),
    constraint fk_ab_author foreign key (author_id) references authors(id) on delete cascade,
    constraint fk_ab_book   foreign key (book_id)   references books(id)   on delete cascade
);

create table loans (
    id          int not null,
    user_id     int not null,
    employee_id int,
    loan_date   date not null,
    due_date    date not null,
    return_date date,
    status      varchar(30) not null default 'ativo',
    notes       varchar(255),
    constraint pk_id_loan primary key (id),
    constraint fk_loan_user     foreign key (user_id)     references users(id)     on delete restrict,
    constraint fk_loan_employee foreign key (employee_id) references employees(id) on delete set null
);

create table loan_items (
    id           int not null,
    loan_id      int not null,
    book_copy_id int not null,
    item_status  varchar(30) not null default 'emprestado',
    constraint pk_id_loan_item primary key (id),
    constraint fk_li_loan foreign key (loan_id)      references loans(id)       on delete cascade,
    constraint fk_li_copy foreign key (book_copy_id) references book_copies(id) on delete restrict
);

create table reservations (
    id               int not null,
    user_id          int not null,
    book_id          int not null,
    reservation_date date not null,
    expiration_date  date,
    status           varchar(30) not null default 'pendente',
    constraint pk_id_reservation primary key (id),
    constraint fk_res_user foreign key (user_id) references users(id) on delete restrict,
    constraint fk_res_book foreign key (book_id) references books(id) on delete restrict
);

create table fines (
    id          int not null,
    user_id     int not null,
    loan_id     int,
    amount      decimal(10,2) not null,
    reason      varchar(120) not null,
    issued_date date not null,
    is_paid     boolean default false,
    paid_date   date,
    constraint pk_id_fine primary key (id),
    constraint fk_fine_user foreign key (user_id) references users(id) on delete restrict,
    constraint fk_fine_loan foreign key (loan_id) references loans(id) on delete set null
);
