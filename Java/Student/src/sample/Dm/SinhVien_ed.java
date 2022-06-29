package sample.Dm;

public class SinhVien_ed {
    private String Id_Sv_ed;
    private String Name_Sv_ed;
    private float diem;
    private String TC_ed;
    private String Id_Mh_ed;
    private String Name_Mh_ed;

    public SinhVien_ed() {
    }

    public SinhVien_ed(String id_Sv_ed, String name_Sv_ed, String TC_ed) {
        Id_Sv_ed = id_Sv_ed;
        Name_Sv_ed = name_Sv_ed;
        this.TC_ed = TC_ed;
    }

    public String getId_Sv_ed() {
        return Id_Sv_ed;
    }

    public void setId_Sv_ed(String id_Sv_ed) {
        Id_Sv_ed = id_Sv_ed;
    }

    public String getName_Sv_ed() {
        return Name_Sv_ed;
    }

    public void setName_Sv_ed(String name_Sv_ed) {
        Name_Sv_ed = name_Sv_ed;
    }

    public float getDiem() {
        return diem;
    }

    public void setDiem(float diem) {
        this.diem = diem;
    }

    public String getTC_ed() {
        return TC_ed;
    }

    public void setTC_ed(String TC_ed) {
        this.TC_ed = TC_ed;
    }

    public String getId_Mh_ed() {
        return Id_Mh_ed;
    }

    public void setId_Mh_ed(String id_Mh_ed) {
        Id_Mh_ed = id_Mh_ed;
    }

    public String getName_Mh_ed() {
        return Name_Mh_ed;
    }

    public void setName_Mh_ed(String name_Mh_ed) {
        Name_Mh_ed = name_Mh_ed;
    }
}