package ORM;
// Generated Apr 6, 2018 6:20:29 PM by Hibernate Tools 4.3.1



/**
 * Staffsalary generated by hbm2java
 */
public class Staffsalary  implements java.io.Serializable {


     private Integer idStaffSalary;
     private Staff staff;
     private String date;
     private String basicSalary;
     private String totalSalary;
     private String totalAllowance;
     private String totalDeductions;
     private String etf;
     private String epf;
     private String netSalary;
     private String isDelete;
     private String totalPayments;
     private String isActive;
     private String isAprove;
     private String createdBy;

    public Staffsalary() {
    }

	
    public Staffsalary(Staff staff) {
        this.staff = staff;
    }
    public Staffsalary(Staff staff, String date, String basicSalary, String totalSalary, String totalAllowance, String totalDeductions, String etf, String epf, String netSalary, String isDelete, String totalPayments, String isActive, String isAprove, String createdBy) {
       this.staff = staff;
       this.date = date;
       this.basicSalary = basicSalary;
       this.totalSalary = totalSalary;
       this.totalAllowance = totalAllowance;
       this.totalDeductions = totalDeductions;
       this.etf = etf;
       this.epf = epf;
       this.netSalary = netSalary;
       this.isDelete = isDelete;
       this.totalPayments = totalPayments;
       this.isActive = isActive;
       this.isAprove = isAprove;
       this.createdBy = createdBy;
    }
   
    public Integer getIdStaffSalary() {
        return this.idStaffSalary;
    }
    
    public void setIdStaffSalary(Integer idStaffSalary) {
        this.idStaffSalary = idStaffSalary;
    }
    public Staff getStaff() {
        return this.staff;
    }
    
    public void setStaff(Staff staff) {
        this.staff = staff;
    }
    public String getDate() {
        return this.date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    public String getBasicSalary() {
        return this.basicSalary;
    }
    
    public void setBasicSalary(String basicSalary) {
        this.basicSalary = basicSalary;
    }
    public String getTotalSalary() {
        return this.totalSalary;
    }
    
    public void setTotalSalary(String totalSalary) {
        this.totalSalary = totalSalary;
    }
    public String getTotalAllowance() {
        return this.totalAllowance;
    }
    
    public void setTotalAllowance(String totalAllowance) {
        this.totalAllowance = totalAllowance;
    }
    public String getTotalDeductions() {
        return this.totalDeductions;
    }
    
    public void setTotalDeductions(String totalDeductions) {
        this.totalDeductions = totalDeductions;
    }
    public String getEtf() {
        return this.etf;
    }
    
    public void setEtf(String etf) {
        this.etf = etf;
    }
    public String getEpf() {
        return this.epf;
    }
    
    public void setEpf(String epf) {
        this.epf = epf;
    }
    public String getNetSalary() {
        return this.netSalary;
    }
    
    public void setNetSalary(String netSalary) {
        this.netSalary = netSalary;
    }
    public String getIsDelete() {
        return this.isDelete;
    }
    
    public void setIsDelete(String isDelete) {
        this.isDelete = isDelete;
    }
    public String getTotalPayments() {
        return this.totalPayments;
    }
    
    public void setTotalPayments(String totalPayments) {
        this.totalPayments = totalPayments;
    }
    public String getIsActive() {
        return this.isActive;
    }
    
    public void setIsActive(String isActive) {
        this.isActive = isActive;
    }
    public String getIsAprove() {
        return this.isAprove;
    }
    
    public void setIsAprove(String isAprove) {
        this.isAprove = isAprove;
    }
    public String getCreatedBy() {
        return this.createdBy;
    }
    
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }




}


