import lop.SinhVien;

import java.io.*;
import java.net.Socket;
import java.util.GregorianCalendar;
import java.util.TreeSet;

public class ThreadSocket extends Thread {
    private Socket socket = null;
    private DataOutputStream dos = null;
    private DataInputStream dis = null;
    private TreeSet<SinhVien> listSV;

    public ThreadSocket(Socket socket) throws IOException {
        System.out.println("Gọi ThreadSocket!!!");
        System.out.println("Đã kết nối Socket: " + socket.isConnected());
        System.out.println("Socket address: " + socket.getInetAddress().getHostAddress());
        System.out.println("Socket port: " + socket.getPort());
        // Tai du lieu len bo nho
        listSV = DocFile();
        this.socket = socket;
    }

    @Override
    public void run() {
        try {
            String st = "";
            String[] arr = null;
            dis = new DataInputStream(socket.getInputStream());
            dos = new DataOutputStream(socket.getOutputStream());
            while (!st.equalsIgnoreCase("Stop")) {
                //Gui danh sach sv den client
                System.out.print("Gửi data: ");
                dos.writeUTF(xemData());
                dos.flush();

                //Nhan thong diep tư client
                st = dis.readUTF();
                System.out.print("Client: ");
                System.out.println(st);

                //Xu li thong diep
                arr = st.split(",");
                if (arr[0].equalsIgnoreCase("Them")) {
                    SinhVien sv = new SinhVien(arr[1], arr[2], arr[3], (arr[4]), arr[5], arr[6], arr[7], Double.parseDouble(arr[8]));
                    listSV.add(sv);
                    System.out.println("Thêm thành công!");
                } else if (arr[0].equalsIgnoreCase("Sua")) {
                    SinhVien sv = new SinhVien(arr[1], arr[2], arr[3], (arr[4]), arr[5], arr[6], arr[7], Double.parseDouble(arr[8]));
                    suaData(sv);
                } else if (arr[0].equalsIgnoreCase("Xoa")) {
                    xoaData(arr[1]);
                }
                st = arr[0];
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        } finally {
            try {
                dis.close();
                dos.close();
                socket.close();

                //Luu du lieu xuong file
                GhiFile(listSV);
                System.out.println("Thoát chương trình");
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    public void xoaData(String maSV) {
        for (SinhVien sv : listSV) {
            if (sv.getMaSV().equalsIgnoreCase(maSV)) {
                listSV.remove(sv);
                System.out.println("Xóa thành công!");
                break;
            }
        }
    }

    public void suaData(SinhVien sv) {
        for (SinhVien s : listSV) {
            if (s.getMaSV().equalsIgnoreCase(sv.getMaSV())) {
                s.setMaSV(sv.getMaSV());
                s.setTen(sv.getTen());
                s.setNgaySinh(sv.getNgaySinh());
                s.setLop(sv.getLop());
                s.setSdt(sv.getSdt());
                s.setEmail(sv.getEmail());
                s.setDiemTB(sv.getDiemTB());
                System.out.println("Sửa thành công!");
                break;
            }
        }
    }

    public GregorianCalendar toDate(String str) {
        String[] arr = str.split("/");
        int year = Integer.parseInt(arr[2]);
        int month = Integer.parseInt(arr[1]);
        int day = Integer.parseInt(arr[0]);
        GregorianCalendar d = new GregorianCalendar(year, month - 1, day);
        return d;
    }


    public String xemData() {
        String str = "";

        for (SinhVien sv : listSV) {
            str = str + sv + ";";
        }
        System.out.println(str);
        if (str.equals("")) str = "Hiện dữ liệu trống!";
        return str;
    }

    public void GhiFile(TreeSet<SinhVien> listSV) throws IOException {
        FileOutputStream f = null;
        BufferedOutputStream bStream = null;
        ObjectOutputStream oStream = null;
        try {
            f = new FileOutputStream("data.txt");
            bStream = new BufferedOutputStream(f);
            oStream = new ObjectOutputStream(bStream);

            for (SinhVien sv : listSV) {
                oStream.writeObject(sv);
            }

        } catch (IOException ex) {
            System.out.println("Error IO file");
        } finally {
            oStream.close();
            bStream.close();
            f.close();
        }
    }

    public TreeSet<SinhVien> DocFile() throws IOException {
        TreeSet<SinhVien> listSV = new TreeSet<>();
        FileInputStream g = null;
        BufferedInputStream bin = null;
        ObjectInputStream inStream = null;
        try {
            g = new FileInputStream("data.txt");
            bin = new BufferedInputStream(g);
            inStream = new ObjectInputStream(bin);

            while (true) {
                SinhVien sv = (SinhVien) inStream.readObject();
                listSV.add(sv);
                //System.out.println(sv);
            }
        } catch (ClassNotFoundException e) {
            System.out.println("Class not found");
        } catch (IOException e) {
            //System.out.println("Error IO file");
        } finally {
            inStream.close();
            bin.close();
            g.close();
        }
        System.out.println("Tải dữ liệu thành công!");
        return listSV;
    }
}
