begin;

DROP TABLE IF EXISTS sis_import_terms;

create table sis_import_terms (
    id serial,
    term_id text,
    name text,
    status text,
    start_date text,
    end_date text
);

insert into sis_import_terms(term_id, name, status, start_date, end_date) values(
    'T001',
    'YR',
    'active',
    '2017-08-14 00:00:00',
    '2018-05-23 23:59:59'
);

insert into sis_import_terms(term_id, name, status, start_date, end_date) values(
    'T002',
    'S1',
    'active',
    '2017-08-14 00:00:00',
    '2018-12-15 23:59:59'
);

insert into sis_import_terms(term_id, name, status, start_date, end_date) values(
    'T003',
    'S2',
    'active',
    '2018-01-03 00:00:00',
    '2018-05-23 23:59:59'
);

insert into sis_import_terms(term_id, name, status, start_date, end_date) values(
    'T004',
    'Q1',
    'active',
    '2017-08-14 00:00:00',
    '2017-10-11 23:59:59'
);

insert into sis_import_terms(term_id, name, status, start_date, end_date) values(
    'T005',
    'Q2',
    'active',
    '2017-10-11 00:00:00',
    '2017-12-15 23:59:59'
);

insert into sis_import_terms(term_id, name, status, start_date, end_date) values(
    'T006',
    'Q3',
    'active',
    '2018-01-03 00:00:00',
    '2018-03-09 23:59:59'
);

insert into sis_import_terms(term_id, name, status, start_date, end_date) values(
    'T007',
    'Q4',
    'active',
    '2018-03-10 00:00:00',
    '2018-05-23 23:59:59'
);

insert into sis_import_terms(term_id, name, status, start_date, end_date) values(
    'T008',
    'EYR',
    'active',
    '2017-07-24 00:00:00',
    '2018-05-23 23:59:59'
);

commit;
