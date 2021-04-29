create table t3(i integer);
insert into t3 values (1);
insert into t3 values (2);
insert into t3 values (3);
insert into t3 values (4);
insert into t3 values (5);
commit;
select * from t3;
