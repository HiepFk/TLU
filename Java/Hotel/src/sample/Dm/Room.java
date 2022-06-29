package sample.Dm;

public class Room {
    private String Id_Room;
    private String type;
    private String status;
    private String Id_User;

    public Room() {
    }

    public Room(String id_Room, String type, String status) {
        Id_Room = id_Room;
        this.type = type;
        this.status = status;
    }

    public Room(String id_Room, String type, String status, String id_User) {
        Id_Room = id_Room;
        this.type = type;
        this.status = status;
        Id_User = id_User;
    }


    public Room(String id_Room, String type) {
        Id_Room = id_Room;
        this.type = type;
    }

    public String getId_Room() {
        return Id_Room;
    }

    public void setId_Room(String id_Room) {
        Id_Room = id_Room;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getId_User() {
        return Id_User;
    }

    public void setId_User(String id_User) {
        Id_User = id_User;
    }
}
