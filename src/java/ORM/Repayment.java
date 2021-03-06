package ORM;
// Generated Apr 6, 2018 6:20:29 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Repayment generated by hbm2java
 */
public class Repayment  implements java.io.Serializable {


     private Integer idRePayment;
     private Loan loan;
     private Double repaymentAmount;
     private Double paidAmount;
     private String date;
     private String actualDay;
     private String currentDay;
     private String isActive;
     private String isAproved;
     private String createdBy;
     private String recieptNo;
     private String arreas;
     private Set repaymentcancellations = new HashSet(0);

    public Repayment() {
    }

	
    public Repayment(Loan loan) {
        this.loan = loan;
    }
    public Repayment(Loan loan, Double repaymentAmount, Double paidAmount, String date, String actualDay, String currentDay, String isActive, String isAproved, String createdBy, String recieptNo, String arreas, Set repaymentcancellations) {
       this.loan = loan;
       this.repaymentAmount = repaymentAmount;
       this.paidAmount = paidAmount;
       this.date = date;
       this.actualDay = actualDay;
       this.currentDay = currentDay;
       this.isActive = isActive;
       this.isAproved = isAproved;
       this.createdBy = createdBy;
       this.recieptNo = recieptNo;
       this.arreas = arreas;
       this.repaymentcancellations = repaymentcancellations;
    }
   
    public Integer getIdRePayment() {
        return this.idRePayment;
    }
    
    public void setIdRePayment(Integer idRePayment) {
        this.idRePayment = idRePayment;
    }
    public Loan getLoan() {
        return this.loan;
    }
    
    public void setLoan(Loan loan) {
        this.loan = loan;
    }
    public Double getRepaymentAmount() {
        return this.repaymentAmount;
    }
    
    public void setRepaymentAmount(Double repaymentAmount) {
        this.repaymentAmount = repaymentAmount;
    }
    public Double getPaidAmount() {
        return this.paidAmount;
    }
    
    public void setPaidAmount(Double paidAmount) {
        this.paidAmount = paidAmount;
    }
    public String getDate() {
        return this.date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    public String getActualDay() {
        return this.actualDay;
    }
    
    public void setActualDay(String actualDay) {
        this.actualDay = actualDay;
    }
    public String getCurrentDay() {
        return this.currentDay;
    }
    
    public void setCurrentDay(String currentDay) {
        this.currentDay = currentDay;
    }
    public String getIsActive() {
        return this.isActive;
    }
    
    public void setIsActive(String isActive) {
        this.isActive = isActive;
    }
    public String getIsAproved() {
        return this.isAproved;
    }
    
    public void setIsAproved(String isAproved) {
        this.isAproved = isAproved;
    }
    public String getCreatedBy() {
        return this.createdBy;
    }
    
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }
    public String getRecieptNo() {
        return this.recieptNo;
    }
    
    public void setRecieptNo(String recieptNo) {
        this.recieptNo = recieptNo;
    }
    public String getArreas() {
        return this.arreas;
    }
    
    public void setArreas(String arreas) {
        this.arreas = arreas;
    }
    public Set getRepaymentcancellations() {
        return this.repaymentcancellations;
    }
    
    public void setRepaymentcancellations(Set repaymentcancellations) {
        this.repaymentcancellations = repaymentcancellations;
    }




}


