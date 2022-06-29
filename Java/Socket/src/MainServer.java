import java.io.*;
import java.net.ServerSocket;

public class MainServer {
    public static void main(String args[]) throws IOException {
        ServerSocket ss = new ServerSocket(1234);
        try {
            while (true) {
                System.out.println("Server được tạo");
                new ThreadSocket(ss.accept()).start();
            }
        } catch (IOException ex) {
            System.out.println("Exception: " + ex.getMessage());
        }
    }
}
