package ORM;
// Generated Apr 6, 2018 6:20:29 PM by Hibernate Tools 4.3.1



/**
 * CenterHasStaff generated by hbm2java
 */
public class CenterHasStaff  implements java.io.Serializable {


     private Integer idcenterHasStaff;
     private Center center;
     private Staff staff;

    public CenterHasStaff() {
    }

    public CenterHasStaff(Center center, Staff staff) {
       this.center = center;
       this.staff = staff;
    }
   
    public Integer getIdcenterHasStaff() {
        return this.idcenterHasStaff;
    }
    
    public void setIdcenterHasStaff(Integer idcenterHasStaff) {
        this.idcenterHasStaff = idcenterHasStaff;
    }
    public Center getCenter() {
        return this.center;
    }
    
    public void setCenter(Center center) {
        this.center = center;
    }
    public Staff getStaff() {
        return this.staff;
    }
    
    public void setStaff(Staff staff) {
        this.staff = staff;
    }




}

