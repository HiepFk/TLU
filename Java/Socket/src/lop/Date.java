package lop;

import java.io.Serializable;
import java.util.Calendar;
import java.util.GregorianCalendar;

public class Date implements Serializable {
    private GregorianCalendar date;

    public Date() {
        this((GregorianCalendar) GregorianCalendar.getInstance());
    }

    public Date(GregorianCalendar date) {
        this.date = date;
    }

    public Date(int year, int month, int day) {
        GregorianCalendar date = new GregorianCalendar(year, month, day);
        this.date = date;
    }


    public GregorianCalendar getDate() {
        return date;
    }

    public void setDate(GregorianCalendar date) {
        this.date = date;
    }

    public void setDate(Date date) {
        this.date = new GregorianCalendar(date.getYear(), date.getMonth(), getDay());
    }

    public int getYear() {
        return date.get(Calendar.YEAR);
    }

    public void setYear(int year) {
        this.date.set(year, date.get(Calendar.MONTH), date.get(Calendar.DAY_OF_MONTH));
    }

    public int getMonth() {
        return date.get(Calendar.MONTH);
    }

    public void setMonth(int month) {
        this.date.set(date.get(Calendar.YEAR), month - 1, date.get(Calendar.DAY_OF_MONTH));
    }

    public int getDay() {
        return date.get(Calendar.DAY_OF_MONTH);
    }

    public void setDay(int day) {
        this.date.set(date.get(Calendar.YEAR), date.get(Calendar.MONTH), day);
    }

    @Override
    public String toString() {
        return date.get(Calendar.DAY_OF_MONTH) + "/" + (date.get(Calendar.MONTH) + 1) + "/" + date.get(Calendar.YEAR);
    }
}
