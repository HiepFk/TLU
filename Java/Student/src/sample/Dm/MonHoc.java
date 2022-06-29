package sample.Dm;

public class MonHoc {
    private String Id_Mh;
    private String Name_Mh;
    private String TinChi;

    public MonHoc() {
    }

    public MonHoc(String id_Mh, String name_Mh) {
        Id_Mh = id_Mh;
        Name_Mh = name_Mh;
    }

    public MonHoc(String id_Mh, String name_Mh, String tinChi) {
        Id_Mh = id_Mh;
        Name_Mh = name_Mh;
        TinChi = tinChi;
    }

    public String getId_Mh() {
        return Id_Mh;
    }

    public void setId_Mh(String id_Mh) {
        Id_Mh = id_Mh;
    }

    public String getName_Mh() {
        return Name_Mh;
    }

    public void setName_Mh(String name_Mh) {
        Name_Mh = name_Mh;
    }

    public String getTinChi() {
        return TinChi;
    }

    public void setTinChi(String tinChi) {
        TinChi = tinChi;
    }
}
