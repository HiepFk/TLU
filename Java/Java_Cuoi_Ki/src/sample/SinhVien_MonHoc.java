package sample;

public class SinhVien_MonHoc {
    public String MaSinhVien;
    public String MaMonHoc;
    public float Diem;

    public SinhVien_MonHoc() {
    }

    public SinhVien_MonHoc(String maSinhVien, String maMonHoc) {
        MaSinhVien = maSinhVien;
        MaMonHoc = maMonHoc;
    }

    public SinhVien_MonHoc(String maSinhVien, String maMonHoc, float diem) {
        MaSinhVien = maSinhVien;
        MaMonHoc = maMonHoc;
        Diem = diem;
    }

    public String getMaSinhVien() {
        return MaSinhVien;
    }

    public void setMaSinhVien(String maSinhVien) {
        MaSinhVien = maSinhVien;
    }

    public String getMaMonHoc() {
        return MaMonHoc;
    }

    public void setMaMonHoc(String maMonHoc) {
        MaMonHoc = maMonHoc;
    }

    public float getDiem() {
        return Diem;
    }

    public void setDiem(float diem) {
        Diem = diem;
    }
}
