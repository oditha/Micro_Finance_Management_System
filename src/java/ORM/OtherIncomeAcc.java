package ORM;
// Generated Apr 6, 2018 6:20:29 PM by Hibernate Tools 4.3.1



/**
 * OtherIncomeAcc generated by hbm2java
 */
public class OtherIncomeAcc  implements java.io.Serializable {


     private Integer idOtherIncome;
     private String accDate;
     private String description;
     private Double credit;
     private Double debit;
     private String isActive;
     private String createBy;

    public OtherIncomeAcc() {
    }

    public OtherIncomeAcc(String accDate, String description, Double credit, Double debit, String isActive, String createBy) {
       this.accDate = accDate;
       this.description = description;
       this.credit = credit;
       this.debit = debit;
       this.isActive = isActive;
       this.createBy = createBy;
    }
   
    public Integer getIdOtherIncome() {
        return this.idOtherIncome;
    }
    
    public void setIdOtherIncome(Integer idOtherIncome) {
        this.idOtherIncome = idOtherIncome;
    }
    public String getAccDate() {
        return this.accDate;
    }
    
    public void setAccDate(String accDate) {
        this.accDate = accDate;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public Double getCredit() {
        return this.credit;
    }
    
    public void setCredit(Double credit) {
        this.credit = credit;
    }
    public Double getDebit() {
        return this.debit;
    }
    
    public void setDebit(Double debit) {
        this.debit = debit;
    }
    public String getIsActive() {
        return this.isActive;
    }
    
    public void setIsActive(String isActive) {
        this.isActive = isActive;
    }
    public String getCreateBy() {
        return this.createBy;
    }
    
    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }




}

