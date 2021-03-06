package ORM;
// Generated Apr 6, 2018 6:20:29 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Members generated by hbm2java
 */
public class Members  implements java.io.Serializable {


     private Integer idMembers;
     private Center center;
     private String memberNo;
     private String groupId;
     private String nameWithInitials;
     private String fullName;
     private String nic;
     private String dob;
     private String address1;
     private String address2;
     private String city;
     private String contactNo;
     private String husbandName;
     private String husbandNic;
     private String husbandjob;
     private String husbandDob;
     private String isActive;
     private String createdBy;
     private String aproved;
     private Set legalactions = new HashSet(0);
     private Set loans = new HashSet(0);

    public Members() {
    }

	
    public Members(Center center) {
        this.center = center;
    }
    public Members(Center center, String memberNo, String groupId, String nameWithInitials, String fullName, String nic, String dob, String address1, String address2, String city, String contactNo, String husbandName, String husbandNic, String husbandjob, String husbandDob, String isActive, String createdBy, String aproved, Set legalactions, Set loans) {
       this.center = center;
       this.memberNo = memberNo;
       this.groupId = groupId;
       this.nameWithInitials = nameWithInitials;
       this.fullName = fullName;
       this.nic = nic;
       this.dob = dob;
       this.address1 = address1;
       this.address2 = address2;
       this.city = city;
       this.contactNo = contactNo;
       this.husbandName = husbandName;
       this.husbandNic = husbandNic;
       this.husbandjob = husbandjob;
       this.husbandDob = husbandDob;
       this.isActive = isActive;
       this.createdBy = createdBy;
       this.aproved = aproved;
       this.legalactions = legalactions;
       this.loans = loans;
    }
   
    public Integer getIdMembers() {
        return this.idMembers;
    }
    
    public void setIdMembers(Integer idMembers) {
        this.idMembers = idMembers;
    }
    public Center getCenter() {
        return this.center;
    }
    
    public void setCenter(Center center) {
        this.center = center;
    }
    public String getMemberNo() {
        return this.memberNo;
    }
    
    public void setMemberNo(String memberNo) {
        this.memberNo = memberNo;
    }
    public String getGroupId() {
        return this.groupId;
    }
    
    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }
    public String getNameWithInitials() {
        return this.nameWithInitials;
    }
    
    public void setNameWithInitials(String nameWithInitials) {
        this.nameWithInitials = nameWithInitials;
    }
    public String getFullName() {
        return this.fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    public String getNic() {
        return this.nic;
    }
    
    public void setNic(String nic) {
        this.nic = nic;
    }
    public String getDob() {
        return this.dob;
    }
    
    public void setDob(String dob) {
        this.dob = dob;
    }
    public String getAddress1() {
        return this.address1;
    }
    
    public void setAddress1(String address1) {
        this.address1 = address1;
    }
    public String getAddress2() {
        return this.address2;
    }
    
    public void setAddress2(String address2) {
        this.address2 = address2;
    }
    public String getCity() {
        return this.city;
    }
    
    public void setCity(String city) {
        this.city = city;
    }
    public String getContactNo() {
        return this.contactNo;
    }
    
    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }
    public String getHusbandName() {
        return this.husbandName;
    }
    
    public void setHusbandName(String husbandName) {
        this.husbandName = husbandName;
    }
    public String getHusbandNic() {
        return this.husbandNic;
    }
    
    public void setHusbandNic(String husbandNic) {
        this.husbandNic = husbandNic;
    }
    public String getHusbandjob() {
        return this.husbandjob;
    }
    
    public void setHusbandjob(String husbandjob) {
        this.husbandjob = husbandjob;
    }
    public String getHusbandDob() {
        return this.husbandDob;
    }
    
    public void setHusbandDob(String husbandDob) {
        this.husbandDob = husbandDob;
    }
    public String getIsActive() {
        return this.isActive;
    }
    
    public void setIsActive(String isActive) {
        this.isActive = isActive;
    }
    public String getCreatedBy() {
        return this.createdBy;
    }
    
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }
    public String getAproved() {
        return this.aproved;
    }
    
    public void setAproved(String aproved) {
        this.aproved = aproved;
    }
    public Set getLegalactions() {
        return this.legalactions;
    }
    
    public void setLegalactions(Set legalactions) {
        this.legalactions = legalactions;
    }
    public Set getLoans() {
        return this.loans;
    }
    
    public void setLoans(Set loans) {
        this.loans = loans;
    }




}


