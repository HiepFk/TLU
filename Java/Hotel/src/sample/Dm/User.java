package sample.Dm;

public class User {
    private  String Id_User;
    private  String Name_User;
    private  String pass;

    public User() {
    }

    public User(String id_User, String name_User, String pass) {
        Id_User = id_User;
        Name_User = name_User;
        this.pass = pass;
    }

    public String getId_User() {
        return Id_User;
    }

    public void setId_User(String id_User) {
        Id_User = id_User;
    }

    public String getName_User() {
        return Name_User;
    }

    public void setName_User(String name_User) {
        Name_User = name_User;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }
}
