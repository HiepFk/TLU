package sample.Dm;

public class SinhVien {
    private String Id_Sv;
    private String Name_Sv;
    private String Mk;
    private String Lop;
    private String Gpa;
    public SinhVien() {
    }

    public SinhVien(String id_Sv, String name_Sv) {
        Id_Sv = id_Sv;
        Name_Sv = name_Sv;
    }

    public SinhVien(String id_Sv, String name_Sv, String mk) {
        Id_Sv = id_Sv;
        Name_Sv = name_Sv;
        Mk = mk;
    }

    public SinhVien(String id_Sv, String name_Sv, String mk, String lop) {
        Id_Sv = id_Sv;
        Name_Sv = name_Sv;
        Mk = mk;
        this.Lop = lop;
    }

    public String getId_Sv() {
        return Id_Sv;
    }

    public void setId_Sv(String id_Sv) {
        Id_Sv = id_Sv;
    }

    public String getName_Sv() {
        return Name_Sv;
    }

    public void setName_Sv(String name_Sv) {
        Name_Sv = name_Sv;
    }

    public String getMk() {
        return Mk;
    }

    public void setMk(String mk) {
        Mk = mk;
    }

    public String getLop() { return Lop; }

    public void setLop(String lop) { Lop = lop; }

    public String getGpa() {
        return Gpa;
    }

    public void setGpa(String gpa) {
        Gpa = gpa;
    }

}
