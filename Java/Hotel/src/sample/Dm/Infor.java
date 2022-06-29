package sample.Dm;

public class Infor {
    private String Id_User;
    private String Id_Room;

    public Infor() {
    }

    public Infor(String id_User, String id_Room) {
        Id_User = id_User;
        Id_Room = id_Room;
    }

    public String getId_User() {
        return Id_User;
    }

    public void setId_User(String id_User) {
        Id_User = id_User;
    }

    public String getId_Room() {
        return Id_Room;
    }

    public void setId_Room(String id_Room) {
        Id_Room = id_Room;
    }
}
