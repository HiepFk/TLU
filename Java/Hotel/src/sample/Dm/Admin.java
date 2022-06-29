package sample.Dm;

public class Admin {
    private  String Id;
    private  String Name;
    private  String Pass;

    public Admin() {
    }

    public Admin(String id, String name, String pass) {
        Id = id;
        Name = name;
        Pass = pass;
    }

    public String getId() {
        return Id;
    }

    public void setId(String id) {
        Id = id;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getPass() {
        return Pass;
    }

    public void setPass(String pass) {
        Pass = pass;
    }
}
