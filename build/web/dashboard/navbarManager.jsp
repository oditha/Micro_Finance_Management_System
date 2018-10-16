
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="admin-menu">
    <li><a href="/CMC/index.jsp"> <i class="icon-home"></i>Home </a></li>
    <ul id="side-admin-menu" class="side-menu list-unstyled"> 
        <li><a href="#Approvals" aria-expanded="false" data-toggle="collapse"> <i class="icon-rss-feed"></i>Approvals</a>
            <ul id="Approvals" class="collapse list-unstyled ">
                <li><a href="/CMC/Approvals/LoanAprovel.jsp">Approve Loans</a></li>
                <li><a href="/CMC/Approvals/ApproveCenter.jsp">Approve Centers</a></li>
                <li><a href="/CMC/Approvals/LoanCancellationAprovel.jsp">Loan Cancellation</a></li>
                <li><a href="/CMC/Approvals/LoanRepaymentCancellationAprovel.jsp">Repayment Cancellation</a></li>
                <hr style="color: whitesmoke">
                <li><a href="/CMC/Approvals/ApproveLeave.jsp">Leave Approval</a></li>
                <li><a href="/CMC/Approvals/ResignationAproval.jsp">Resignation Approval</a></li>
                


            </ul>
        </li>
    </ul>
</div>
<div class="main-menu">
    <ul id="side-main-menu" class="side-menu list-unstyled">                  
        <h5 class="sidenav-heading">Micro Finance</h5>
        <li><a href="#exampledropdownDropdown" aria-expanded="false" data-toggle="collapse"> <i class="icon-page"></i>Center Management </a>
            <ul id="exampledropdownDropdown" class="collapse list-unstyled ">
                <li><a href="/CMC/MicroFinance/addBranch.jsp">Create Branches</a></li>
                <li><a href="/CMC/MicroFinance/addCenter.jsp">Create Centers</a></li>
                <li><a href="/CMC/MicroFinance/addMember.jsp">Create Members</a></li>


            </ul>
        </li>
        <li><a href="#loanmanagemnet" aria-expanded="false" data-toggle="collapse"> <i class="icon-form"></i>Loan Management </a>
            <ul id="loanmanagemnet" class="collapse list-unstyled ">
                <li><a href="/CMC/MicroFinance/addLoan.jsp">Create Loan</a></li>
                <li><a href="/CMC/MicroFinance/viewLoan.jsp">View Loans</a></li>
                
            </ul>
        </li>
        <li><a href="#paymentmanagemnet" aria-expanded="false" data-toggle="collapse"> <i class="icon-check"></i>Payments</a>
            <ul id="paymentmanagemnet" class="collapse list-unstyled ">
                <li><a href="/CMC/MicroFinance/addRepayment.jsp">Add Payment</a></li>
                <li><a href="/CMC/MicroFinance/viewRepayments.jsp">View Payment</a></li>

            </ul>
        </li>
        <li><a href="#reports" aria-expanded="false" data-toggle="collapse"> <i class="icon-paper-airplane"></i>Reports</a>
            <ul id="reports" class="collapse list-unstyled ">
                <li><a href="/CMC/MicroFinance/viewLederReport.jsp">Ledger Report</a></li>
                <li><a href="/CMC/MicroFinance/viewCollectionSummery.jsp">Collection Report</a></li>
                <li><a href="/CMC/MicroFinance/viewCollectionSummeryBranch.jsp">Collection Summery</a></li>
                <li><a href="/CMC/MicroFinance/OfficePayments.jsp">View Office Payments</a></li>
                <li><a href="/CMC/MicroFinance/Paidmembers.jsp">Payment Summery</a></li>
                <li><a href="/CMC/MicroFinance/viewGeneralSummery.jsp">General Report</a></li>
                <li><a href="/CMC/MicroFinance/viewPortfolio.jsp">Portfolio</a></li>
                <li><a href="/CMC/MicroFinance/viewLoanIndex.jsp">Loan Index Report</a></li>
                <li><a href="/CMC/MicroFinance/NotPaidReport.jsp">Not Paid Report</a></li>
                <li><a href="/CMC/MicroFinance/ArriesReport.jsp">Arrears Report</a></li>

            </ul>
        </li>
        <li><a href="#adminstrative" aria-expanded="false" data-toggle="collapse"> <i class="icon-bill"></i>Denomination</a>
            <ul id="adminstrative" class="collapse list-unstyled ">
                <li><a href="/CMC/MicroFinance/addcashDenimation.jsp">Add Denomination</a></li>
                <li><a href="/CMC/MicroFinance/ViewcashDenimation.jsp">View Denomination</a></li>
            </ul>
        </li>
        <li><a href="#printmanager" aria-expanded="false" data-toggle="collapse"> <i class="icon-padnote"></i>Printout</a>
            <ul id="printmanager" class="collapse list-unstyled ">
                <li><a href="#" class="repayment">Repayment Sheet</a></li>
                <li><a href="#" class="Disbursement">Loan Disbursement</a></li>


            </ul>
        </li>
    </ul>
</div>
<div class="admin-menu">
    <h5 class="sidenav-heading">Human Resources</h5>
    <ul id="side-admin-menu" class="side-menu list-unstyled"> 
        <li><a href="#staffmanage" aria-expanded="false" data-toggle="collapse"> <i class="icon-user"></i>Management</a>
            <ul id="staffmanage" class="collapse list-unstyled ">
                <li><a href="/CMC/HR/AddregStaff.jsp">Staff Management</a></li>
                <li><a href="/CMC/HR/AddUser.jsp">User Management</a></li>
            </ul>
        </li>
        <li><a href="#administrative" aria-expanded="false" data-toggle="collapse"> <i class="icon-list-1"></i>Administrative</a>
            <ul id="administrative" class="collapse list-unstyled ">
                <li><a href="/CMC/HR/AddLeaveManagement.jsp">Leave Management</a></li>
                <li><a href="/CMC/HR/ViewLeaveManagementReport.jsp">Leave Report</a></li>
                <li><a href="/CMC/HR/ViewAttendenceReport.jsp">Attendance Report</a></li>
                <li><a href="/CMC/HR/AddResignation.jsp">Resignation Management</a></li>
                <li><a href="/CMC/HR/ViewResignationReport.jsp">Resignation Report</a></li>
            </ul>
        </li>
        <li><a href="#salary" aria-expanded="false" data-toggle="collapse"> <i class="icon-line-chart"></i>Salary management</a>
            <ul id="salary" class="collapse list-unstyled ">
                <li><a href="/CMC/HR/AddSalaryCreation.jsp">Salary Creation</a></li>
                <li><a href="/CMC/HR/ViewSalaryReport.jsp">Salary Report</a></li>
            </ul>
        </li>
    </ul>
</div>
<div class="admin-menu">
    <h5 class="sidenav-heading">Accounting</h5>
    <ul id="side-admin-menu2" class="side-menu list-unstyled"> 
        <li><a href="#loanacc" aria-expanded="false" data-toggle="collapse"> <i class="icon-user"></i>View Accounts</a>
            <ul id="loanacc" class="collapse list-unstyled ">
                <li><a href="/CMC/Accounts/viewLoanAccount.jsp">Loan Accounts</a></li>
                
            </ul>
        </li>
        
    </ul>
</div>