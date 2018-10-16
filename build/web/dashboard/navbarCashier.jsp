
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="admin-menu">
    <li><a href="/CMC/index.jsp"> <i class="icon-home"></i>Home </a></li>

</div>
<div class="main-menu">
    <ul id="side-main-menu" class="side-menu list-unstyled">                  
        <h5 class="sidenav-heading">Micro Finance</h5>
        <li><a href="#exampledropdownDropdown" aria-expanded="false" data-toggle="collapse"> <i class="icon-page"></i>Center Management </a>
            <ul id="exampledropdownDropdown" class="collapse list-unstyled ">

                <li><a href="/CMC/Cashier/addCenter.jsp">Create Centers</a></li>
                <li><a href="/CMC/Cashier/addMember.jsp">Create Members</a></li>

            </ul>
        </li>
        <li><a href="#loanmanagemnet" aria-expanded="false" data-toggle="collapse"> <i class="icon-form"></i>Loan Management </a>
            <ul id="loanmanagemnet" class="collapse list-unstyled ">

                <li><a href="/CMC/Cashier/addLoan.jsp">Create Loan</a></li>
                <li><a href="/CMC/Cashier/viewLoan.jsp">View Loans</a></li>

            </ul>
        </li>
        <li><a href="#paymentmanagemnet" aria-expanded="false" data-toggle="collapse"> <i class="icon-check"></i>Payments</a>
            <ul id="paymentmanagemnet" class="collapse list-unstyled ">
                <li><a href="/CMC/Cashier/addRepayment.jsp">Add Payment</a></li>
                <li><a href="/CMC/Cashier/viewRepayments.jsp">View Payment</a></li>

            </ul>
        </li>
        <li><a href="#reports" aria-expanded="false" data-toggle="collapse"> <i class="icon-paper-airplane"></i>Reports</a>
            <ul id="reports" class="collapse list-unstyled ">
                <li><a href="/CMC/Cashier/viewLederReport.jsp">Ledger Report</a></li>
                <li><a href="/CMC/Cashier/OfficePayments.jsp">View Office Payments</a></li>
                
            </ul>
        </li>
        <li><a href="#adminstrative" aria-expanded="false" data-toggle="collapse"> <i class="icon-bill"></i>Denomination</a>
            <ul id="adminstrative" class="collapse list-unstyled ">
                <li><a href="/CMC/Cashier/addcashDenimation.jsp">Add Denomination</a></li>
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
                <li><a href="/CMC/Cashier/AddLeaveManagementExecutive.jsp">Leave Management</a></li>
                <li><a href="/CMC/Cashier/AddResignationExecutive.jsp">Resignation Management</a></li>
            </ul>
        </li>

    </ul>
</div>
