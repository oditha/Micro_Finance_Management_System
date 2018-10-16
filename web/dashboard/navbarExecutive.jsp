
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="admin-menu">
    <li><a href="/CMC/index.jsp"> <i class="icon-home"></i>Home </a></li>

</div>
<div class="main-menu">
    <ul id="side-main-menu" class="side-menu list-unstyled">                  
        <h5 class="sidenav-heading">Micro Finance</h5>
        <li><a href="#exampledropdownDropdown" aria-expanded="false" data-toggle="collapse"> <i class="icon-page"></i>Center Management </a>
            <ul id="exampledropdownDropdown" class="collapse list-unstyled ">

                <li><a href="/CMC/Executive/addCenter.jsp">Create Centers</a></li>
                <li><a href="/CMC/Executive/addMember.jsp">Create Members</a></li>

            </ul>
        </li>
        <li><a href="#loanmanagemnet" aria-expanded="false" data-toggle="collapse"> <i class="icon-form"></i>Loan Management </a>
            <ul id="loanmanagemnet" class="collapse list-unstyled ">
                <li><a href="/CMC/Executive/addLoan.jsp">Create Loan</a></li>
                <li><a href="/CMC/Executive/viewLoan.jsp">View Loans</a></li>
                <!--<li><a href="/CMC/Executive/viewDisbursement.jsp">Loan Disbursement</a></li>-->


            </ul>
        </li>
        <li><a href="#paymentmanagemnet" aria-expanded="false" data-toggle="collapse"> <i class="icon-check"></i>Payments</a>
            <ul id="paymentmanagemnet" class="collapse list-unstyled ">
                <li><a href="/CMC/Executive/addRepayment.jsp">Add Payment</a></li>
                <li><a href="/CMC/Executive/viewRepayments.jsp">View Payment</a></li>
                <!--<li><a href="/CMC/Executive/viewRepaymentSheet.jsp">Repayment Sheet</a></li>-->


            </ul>
        </li>
        <li><a href="#reports" aria-expanded="false" data-toggle="collapse"> <i class="icon-paper-airplane"></i>Reports</a>
            <ul id="reports" class="collapse list-unstyled ">
                <li><a href="/CMC/Executive/viewCollectionSummery.jsp">Collection Report</a></li>
                <li><a href="/CMC/Executive/Paidmembers.jsp">Payments Summery</a></li>
                <li><a href="/CMC/Executive/viewGeneralSummery.jsp">General Report</a></li>
                <li><a href="/CMC/Executive/viewLederReportEXE.jsp">Ledger Report</a></li>
                <li><a href="/CMC/Executive/NotPaidReport.jsp">Not Paid Report</a></li>
                <li><a href="/CMC/Executive/ArriesReport.jsp">Arrears Report</a></li>

            </ul>
        </li>
        <li><a href="#adminstrative" aria-expanded="false" data-toggle="collapse"> <i class="icon-bill"></i>Denomination</a>
            <ul id="adminstrative" class="collapse list-unstyled ">
                <li><a href="/CMC/Executive/addcashDenimation.jsp">Add Denomination</a></li>
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
        <li><a href="#administrative" aria-expanded="false" data-toggle="collapse"> <i class="icon-list-1"></i>Administrative</a>
            <ul id="administrative" class="collapse list-unstyled ">
                <li><a href="/CMC/Executive/AddLeaveManagementExecutive.jsp">Leave Management</a></li>
                <li><a href="/CMC/Executive/AddResignationExecutive.jsp">Resignation Management</a></li>
            </ul>
        </li>

    </ul>
</div>
