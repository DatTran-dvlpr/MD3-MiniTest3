create database quanlyvattu;
use quanlyvattu;
create table vattu
(
    id        int auto_increment primary key,
    mavattu   nvarchar(20) not null unique,
    tenvattu  nvarchar(50) not null,
    donvitinh nvarchar(20),
    giatien   int
);
select *
from vattu;
create table tonkho
(
    id              int auto_increment primary key,
    id_vattu        int,
    soluongdau      int,
    tongsoluongnhap int,
    tongsoluongxuat int,
    foreign key (id_vattu) references vattu (id)
);
select *
from tonkho;

create table nhacungcap
(
    id           int auto_increment primary key,
    manhacungcap nvarchar(20) not null,
    ten          nvarchar(50) not null,
    diachi       nvarchar(100),
    sdt          int
);
select *
from nhacungcap;
create table donhang
(
    id            int auto_increment primary key,
    madon         nvarchar(20) not null,
    ngaydathang   date         not null,
    id_nhacungcap int,
    foreign key (id_nhacungcap) references nhacungcap(id)
);
select * from donhang;

create table phieunhap(
                          id int auto_increment primary key ,
                          maphieu nvarchar(20) not null ,
                          ngaynhap date,
                          id_donhang int,
                          foreign key (id_donhang) references donhang(id)
);
select * from phieunhap;

create table phieuxuat (
                           id int auto_increment primary key ,
                           maphieu nvarchar(20) not null ,
                           ngayxuat date,
                           tenkhachhang nvarchar(50)
);
select * from phieuxuat;

create table chitietdonhang(
                               id int auto_increment primary key ,
                               id_donhang int,
                               id_vattu int,
                               soluongdat int,
                               foreign key (id_donhang) references donhang(id),
                               foreign key (id_vattu) references vattu(id)
);
select * from chitietdonhang;

create table chitietphieunhap(
                                 id int auto_increment primary key ,
                                 id_phieunhap int,
                                 id_vattu int,
                                 soluongnhap int,
                                 dongianhap int,
                                 ghichu text,
                                 foreign key (id_vattu) references vattu(id),
                                 foreign key (id_phieunhap) references phieunhap(id)
);
select *
from chitietphieunhap;

create table chitietphieuxuat(
                                 id  int auto_increment primary key ,
                                 id_phieuxuat int,
                                 id_vattu int,
                                 soluongxuat int,
                                 dongiaxuat int,
                                 ghichu text,
                                 foreign key (id_vattu) references vattu(id),
                                 foreign key (id_phieuxuat) references phieuxuat(id)
);
select * from chitietphieuxuat;

create view vw_CTPNHAP as
select p.maphieu,v.mavattu,c.soluongnhap,c.dongianhap, c.soluongnhap*c.dongianhap as 'thanhtien'
from phieunhap p join chitietphieunhap c on p.id = c.id_phieunhap
                 join vattu v on c.id_vattu = v.id
;
select * from vw_CTPNHAP;
create view vw_CTPNHAP_VT as
select p.maphieu,v.mavattu,v.tenvattu,c.soluongnhap,c.dongianhap, c.soluongnhap*c.dongianhap as 'thanhtien'
from phieunhap p join chitietphieunhap c on p.id = c.id_phieunhap
                 join vattu v on c.id_vattu = v.id
;
select * from vw_CTPNHAP_VT;
create view vw_CTPNHAP_VT_PN as
select p.maphieu,p.ngaynhap,d.madon,v.mavattu,v.tenvattu,c.soluongnhap,c.dongianhap, c.soluongnhap*c.dongianhap as 'thanhtien'
from phieunhap p join chitietphieunhap c on p.id = c.id_phieunhap
                 join vattu v on c.id_vattu = v.id
                 join donhang d on p.id_donhang = d.id
;
select * from vw_CTPNHAP_VT_PN;
create view vw_CTPNHAP_VT_PN_DH as
select p.maphieu,p.ngaynhap,d.madon,n.manhacungcap,v.mavattu,v.tenvattu,c.soluongnhap,c.dongianhap, c.soluongnhap*c.dongianhap as 'thanhtien'
from phieunhap p join chitietphieunhap c on p.id = c.id_phieunhap
                 join vattu v on c.id_vattu = v.id
                 join donhang d on p.id_donhang = d.id
                 join nhacungcap n on d.id_nhacungcap = n.id
;
select * from vw_CTPNHAP_VT_PN_DH;

create view vw_CTPNHAP_loc as
select p.maphieu,v.mavattu,c.soluongnhap,c.dongianhap, c.soluongnhap*c.dongianhap as 'thanhtien'
from phieunhap p join chitietphieunhap c on p.id = c.id_phieunhap
                 join vattu v on c.id_vattu = v.id where c.soluongnhap > 5
;
select * from vw_CTPNHAP_loc;

create view vw_CTPNHAP_VT_loc as
select p.maphieu,v.mavattu,v.tenvattu,c.soluongnhap,c.dongianhap, c.soluongnhap*c.dongianhap as 'thanhtien'
from phieunhap p join chitietphieunhap c on p.id = c.id_phieunhap
                 join vattu v on c.id_vattu = v.id where v.donvitinh = 'nai'
;
select * from vw_CTPNHAP_VT_loc;
# C??u 7. T???o view c?? t??n vw_CTPXUAT bao g???m c??c th??ng tin sau:
# s??? phi???u xu???t h??ng, m?? v???t t??, s??? l?????ng xu???t, ????n gi?? xu???t, th??nh ti???n xu???t.
#
create view vw_CTPXUAT as
select p.maphieu,v.mavattu,c.soluongxuat,c.dongiaxuat, c.soluongxuat*c.dongiaxuat as 'thanhtien'
from phieuxuat p join chitietphieuxuat c on p.id = c.id_phieuxuat
                 join vattu v on c.id_vattu = v.id
;
select * from vw_CTPXUAT;

# C??u 8. T???o view c?? t??n vw_CTPXUAT_VT bao g???m c??c th??ng tin sau:
# s??? phi???u xu???t h??ng, m?? v???t t??, t??n v???t t??, s??? l?????ng xu???t, ????n gi?? xu???t.
create view vw_CTPXUAT_VT as
select p.maphieu,v.mavattu,v.tenvattu,c.soluongxuat,c.dongiaxuat, c.soluongxuat*c.dongiaxuat as 'thanhtien'
from phieuxuat p join chitietphieuxuat c on p.id = c.id_phieuxuat
                 join vattu v on c.id_vattu = v.id
;
select * from vw_CTPXUAT_VT;
# C??u 9. T???o view c?? t??n vw_CTPXUAT_VT_PX bao g???m c??c th??ng tin sau:
# s??? phi???u xu???t h??ng, t??n kh??ch h??ng, m?? v???t t??, t??n v???t t??, s??? l?????ng xu???t, ????n gi?? xu???t.
create view vw_CTPXUAT_VT_PX as
select p.maphieu,p.tenkhachhang,v.mavattu,v.tenvattu,c.soluongxuat,c.dongiaxuat, c.soluongxuat*c.dongiaxuat as 'thanhtien'
from phieuxuat p join chitietphieuxuat c on p.id = c.id_phieuxuat
                 join vattu v on c.id_vattu = v.id
;
select * from vw_CTPXUAT_VT_PX;
# T???o c??c stored procedure sau
# C??u 1. T???o Stored procedure (SP) cho bi???t t???ng s??? l?????ng cu???i c???a v???t t??
# v???i m?? v???t t?? l?? tham s??? v??o.
delimiter //
create procedure checkvattutonkho(in mavattu int)
begin
    select soluongdau+tonkho.tongsoluongnhap-tonkho.tongsoluongxuat as 'tongsoluongcuoi'
    from tonkho where id_vattu = mavattu;
end //
delimiter;
call checkvattutonkho(4);
# C??u 2. T???o SP cho bi???t t???ng ti???n xu???t c???a v???t t?? v???i m?? v???t t?? l?? tham s??? v??o.
delimiter //
create procedure checkthanhtienxuat(in mavattu nvarchar(20))
begin
    select sum(v.thanhtien)
    from vw_CTPXUAT v  group by v.mavattu having v.mavattu = mavattu;
end //
delimiter;
call checkthanhtienxuat('a1');
# C??u 3. T???o SP cho bi???t t???ng s??? l?????ng ?????t theo s??? ????n h??ng v???i s??? ????n h??ng l?? tham s??? v??o.
delimiter //
create procedure checksoluongdattheodonhang(in madonhang nvarchar(20))
begin
    select d.madon,sum(c.soluongdat) from chitietdonhang c join donhang d on d.id = c.id_donhang
    group by madon
    having d.madon = madonhang;
end //
delimiter;
call checksoluongdattheodonhang('s1');
# C??u 4. T???o SP d??ng ????? th??m m???t ????n ?????t h??ng.
delimiter //
create procedure themdonhang(in madon1 nvarchar(20),in ngaydathang1 date,in id_nhacungcap1 int)
begin
    insert into donhang(madon, ngaydathang, id_nhacungcap) values (madon1,ngaydathang1,id_nhacungcap1);
end //
delimiter;
call themdonhang('s4','2020-03-20',2);
select * from donhang;
# C??u 5. T???o SP d??ng ????? th??m m???t chi ti???t ????n ?????t h??ng.
delimiter //
create procedure themchitietdonhang(in iddonhang int,in idvattu int, in soluongdat1 int)
begin
    insert into chitietdonhang(id_donhang, id_vattu, soluongdat) values(iddonhang,idvattu,soluongdat1);
end //
delimiter;
call themchitietdonhang(3,4,3);
select * from chitietdonhang;




