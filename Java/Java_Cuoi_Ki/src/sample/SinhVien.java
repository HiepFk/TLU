package sample;

public class SinhVien {
    public String MaSV;
    public String TenSV;

    public SinhVien() {
    }

    public SinhVien(String maSV, String tenSV) {
        MaSV = maSV;
        TenSV = tenSV;
    }

    public String getMaSV() {
        return MaSV;
    }

    public void setMaSV(String maSV) {
        MaSV = maSV;
    }

    public String getTenSV() {
        return TenSV;
    }

    public void setTenSV(String tenSV) {
        TenSV = tenSV;
    }
}
