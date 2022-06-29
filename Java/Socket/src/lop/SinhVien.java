package lop;

import java.io.Serializable;
import java.util.Calendar;
import java.util.GregorianCalendar;

public class SinhVien implements Serializable, Comparable<SinhVien> {
    private String maSV;
    private String ten;
    private String gioiTinh;
    private String ngaySinh;
    private String lop;
    private String sdt;
    private String email;
    private double diemTB;

    public SinhVien() {
        this("", "", "", "", "", "", "", 0);
    }

    public SinhVien(String maSV, String ten, String gioiTinh, String ngaySinh, String lop, String sdt, String email, double diemTB) {
        this.maSV = maSV;
        this.ten = ten;
        this.gioiTinh = gioiTinh;
        this.ngaySinh = ngaySinh;
        this.lop = lop;
        this.sdt = sdt;
        this.email = email;
        this.diemTB = diemTB;
    }

    public String getMaSV() {
        return maSV;
    }

    public void setMaSV(String maSV) {
        this.maSV = maSV;
    }

    public String getTen() {
        return ten;
    }

    public void setTen(String ten) {
        this.ten = ten;
    }

    public String getGioiTinh() {
        return gioiTinh;
    }

    public void setGioiTinh(String gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    public void setNgaySinh(String ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    public String getNgaySinh() {
        return ngaySinh;
    }
    //    public GregorianCalendar getNgaySinh() { return ngaySinh.getDate(); }
//    public void setNgaySinh(GregorianCalendar ngaySinh) { this.ngaySinh.setDate(ngaySinh); }

    public String getLop() {
        return lop;
    }

    public void setLop(String lop) {
        this.lop = lop;
    }

    public String getSdt() {
        return sdt;
    }

    public void setSdt(String sdt) {
        this.sdt = sdt;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public double getDiemTB() {
        return diemTB;
    }

    public void setDiemTB(double diemTB) {
        this.diemTB = diemTB;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof SinhVien) {
            SinhVien another = (SinhVien) obj;
            if (this.maSV.equals(another.maSV)) {
                //if(this.diemTN == another.diemTN){
                return true;
            }
        }
        return false;
    }

    @Override
    public int hashCode() {
        int result;
        result = maSV.hashCode();
        //result = maSV.hashCode() + hoTen.hashCode() + Double.valueOf(diemTN).hashCode();
        return result;
    }

    @Override
    public int compareTo(SinhVien obj) {
        return this.maSV.compareTo(obj.maSV);
    }

    @Override
    public String toString() {
        return maSV + "," + ten + "," + gioiTinh + "," + ngaySinh + "," + lop + "," + sdt + "," + email + "," + diemTB;
    }

}
