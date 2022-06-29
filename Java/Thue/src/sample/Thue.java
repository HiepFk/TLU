package sample;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;
public class Thue {
//    đọc file

    public static void docFile() throws FileNotFoundException {
        String url = "D:\\test.txt";
        FileInputStream fileInputStream = new FileInputStream(url);
        Scanner scanner = new Scanner(fileInputStream);
        try {
            while (scanner.hasNextLine()) {
                System.out.println(scanner.nextLine());
//                    p.add(scanner.nextLine());

            }
        } finally {
            try {
                scanner.close();
                fileInputStream.close();
            } catch (IOException ex) {
               System.out.println("Địa chỉ sai");
            }
        }
    }
//    public static void luuuFile(){
//    }
    public static void main(String[] args) {
        try {
            docFile();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        Scanner scanner = new Scanner(System.in);
        double tien=scanner.nextDouble();
        double nguoi=scanner.nextDouble();
        int dem=0;
        double Tong=0;
        long[]S = {0, 5000000, 10000000, 18000000, 32000000, 52000000, 80000000};
        double[] P = {0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35};
        long tienChiuThue = (long) (tien - nguoi * 4400000 - 11000000);
        if (tienChiuThue <= 0) {
            Tong=0;
        } else {
            System.out.println("Giảm trừ bản thân : 11000000 đồng");
            System.out.println("Giảm trừ người phụ thuộc : " + nguoi+   " * 4400000  " +  "  =  " + nguoi * 4400000 + " đồng");
            System.out.println("Tiền chịu thuế : " + tien +" - "+  " 11000000  -  "+ nguoi +" *  4400000  = " + tienChiuThue + " đồng");
            System.out.println("Tiền thuế từng bậc : ");
            while (tienChiuThue > S[dem]) {
                if (tienChiuThue < S[dem + 1]) { break; }
                double l = S[dem + 1] - S[dem];
                Tong = (long) (P[dem] * l + Tong);
                System.out.println("Bậc " + (dem + 1) + ":  (" + S[dem + 1] + " - " + S[dem] + " ) * " + P[dem] + " = " + l * P[dem] + " đồng");
                dem++;
                if (dem == 6) {
                    break;
                }
            }
            Tong = (long) ((tienChiuThue - S[dem]) * P[dem] + Tong);
            System.out.println("Bậc " + (dem + 1) + ":  (" + tienChiuThue + " - " + S[dem] + " )* " + P[dem] + " = " + (tienChiuThue - S[dem]) * P[dem] + " đồng");

        }
        System.out.println("Tiền phải nộp : " + Tong +" đồng" );
    }
}
