<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%= PageTitleSet.getTitle().setPAGE_TITLE("Dashbord") %>--%>
<%--<jsp:include page="header.jsp"/>--%>

<!---------------------------Save Done--------------------------------------->
<!-- The Modal Save Done-->
<div class="modal fade" id="SaveDone">
    <div class="modal-dialog ">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Success</h4>

            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <strong>Success!</strong> Data has been saved successfully.

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>
<!---------------------------Request--------------------------------------->
<!-- The Modal Save Done-->
<div class="modal fade" id="requestDone">
    <div class="modal-dialog ">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Success</h4>

            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <strong>Success!</strong> Your Request is send to Manager.

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>
<!---------------------------Check current month slary--------------------------------------->
<!-- Check current month slary-->
<div class="modal fade" id="salarycheck">
    <div class="modal-dialog ">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">already exists</h4>

            </div>

            <!-- Modal body -->
            <div class="modal-body">
                You have Already paid for current month

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>
<!---------------------------Search Error--------------------------------------->
<!-- The Modal Save Done-->
<div class="modal fade" id="searchError">
    <div class="modal-dialog ">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Error</h4>

            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <strong>Error!</strong> No any record found.

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>
<!-- The Modal Advance Search-->
<div class="modal fade" id="adSearch">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">No result found</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">

                <div class="container">

                    <div class="row">

                        <div class="col-md-12">
                            <form action="" id="advForm">
                                <div class="form-group">

                                    <label for="formGroupExampleInput">Search With</label><br>

                                    <div class="form-check form-check-inline">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="radio" name="optradio" id="inlineRadio1" value="nic"> NIC
                                        </label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="radio" name="optradio" id="inlineRadio2" value="memberNo"> Member ID
                                        </label>
                                    </div>

                                </div>

                                <div class="input-group">
                                    <input type="text" class="form-control" id="search" name="search" placeholder="Search for..." aria-label="Search for...">
                                    <span class="input-group-btn" id="span">
                                        <button class="btn btn-primary btnSerach" type="button" id="advButton" >Search</button>
                                    </span>
                                </div>
                            </form>
                        </div>

                    </div>


                </div>


            </div>

            <!-- Modal footer -->
            <div class="modal-footer">

            </div>

        </div>
    </div>
</div>

<!---------------------------Modal Somwthing Went Wrong--------------------------------------->
<div class="modal fade" id="wentWrong">
    <div class="modal-dialog ">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Try again</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <strong>Something went wrong!. Try agin.</strong> 

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>


<!------------------------NO ANY LOANS---------------------------------------------->
<div class="modal fade" id="noAny">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">No Active Loans</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <strong>This member has no any active loans.</strong> 

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

<!------------------------Payment Error---------------------------------------->
<div class="modal fade" id="repayError">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Payment Error</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <strong>Repayment must not greater than balance amount.</strong> 

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

<!-------------------------------------REPAYMENT SAVE DONE---------------------------------------->
<div class="modal fade" id="saveDone">
    <div class="modal-dialog ">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Success</h4>

            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <strong>Success!</strong> Data has been saved successfully.
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <a href="../BackToRepayment" class="btn btn-danger btn-sm">Back</a>
            </div>

        </div>
    </div>
</div>
<!-------------------------------------REPAYMENT SAVE DONE Mobile---------------------------------------->
<div class="modal fade" id="saveDoneMob">
    <div class="modal-dialog ">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Success</h4>

            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <strong>Success!</strong> Data has been saved successfully.
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <a href="home.jsp" class="btn btn-danger btn-sm">Back</a>
            </div>

        </div>
    </div>
</div>

<!--------------------------------View Loan Record Modal----------------------------------------->
<div class="modal fade" id="viewLoanRec" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">View Loan Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">



                <div class="row">


                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="formGroupExampleInput">Contract NO</label>
                            <input type="text" class="form-control" id="ContractNO" placeholder="Enter NIC" name="NIC">
                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput">loan Index</label>

                            <input class="form-control" type="text" value="" id="loanIndex" name="namein" placeholder="Name with Initials">


                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput"> loan Amount</label>
                            <input type="text" class="form-control" id="loanAmount" placeholder="Enter Fullname" name="fullname">
                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput">loan Interest</label>
                            <input type="text" class="form-control" id="loanInterset" placeholder="dob" name="dob">
                        </div>

                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="formGroupExampleInput">loan Period</label>
                            <input class="form-control" type="text" value="" id="loanPeriod" name="contact" placeholder="Enter Contact no">


                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput">loan Installment</label>
                            <input class="form-control" type="tel" value="" id="loanInstallment" 
                                   placeholder="Enter Address 1" name="address1">
                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput">loan Issue Date</label>
                            <input class="form-control" type="tel" value="" id="loanIssueDate" placeholder="Enter Address 1" name="address2">
                        </div>

                        <div class="form-group">
                            <label for="formGroupExampleInput">loan Repayment Day</label>
                            <input class="form-control" type="tel" value="" name="loanRepaymentDay" id="loanRepaymentDay" placeholder="Enter City">
                        </div>

                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="formGroupExampleInput">gur1</label>
                            <input class="form-control" type="text" value="" id="gur1" name="gNIC" placeholder="Gardian NIC">
                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput">gur2</label>
                            <input class="form-control" type="text"  id="gur2" name="gname" placeholder="Enter Guardian Name">
                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput">Status</label>
                            <input type="text" class="form-control" id="Status" placeholder="Enter Guardian DOB" name="gdob">
                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput">Create By</label>
                            <input type="text" class="form-control" id="CreateBy" name="gocc" placeholder="Enter Guardian Occupation">
                        </div>

                    </div>

                </div>

            </div>
            <div class="modal-footer">

            </div>

        </div>
    </div>
</div>


<!----------------------------------Request Loan Cancel ------------------------------------------------>

<div class="modal fade" id="requestCancel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Request Cancellation</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">



                <div class="row">


                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="formGroupExampleInput">Contract NO</label>
                            <input type="text" class="form-control" id="conno" name="NIC">
                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput">Member Name</label>
                            <input type="text" class="form-control" id="mname" name="NIC">
                        </div>

                        <div class="form-group" hidden="">

                            <input type="text" class="form-control" id="idlo" name="fullname">
                        </div>


                    </div>
                    <div class="col-md-8">
                        <div class="form-group">
                            <label for="exampleFormControlTextarea1">Request Reason</label>
                            <textarea class="form-control" id="exampleFormControlTextarea1re" rows="3"></textarea>
                        </div>

                    </div>


                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary btn-sm" id="requestbtn">Request</button>
            </div>

        </div>
    </div>
</div>
<!----------------------------------Request Loan Repayment ------------------------------------------------>

<div class="modal fade" id="requestCancelPayment" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Request Cancellation</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">



                <div class="row">


                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="formGroupExampleInput">Contract NO</label>
                            <input type="text" class="form-control" id="connore" name="NIC">
                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput">Member Name</label>
                            <input type="text" class="form-control" id="mnamere" name="NIC">
                        </div>

                        <div class="form-group" >

                            <input type="text" class="form-control" id="idlore" name="fullname" hidden>
                        </div>


                    </div>
                    <div class="col-md-8">
                        <div class="form-group">
                            <label for="exampleFormControlTextarea1">Request Reason</label>
                            <textarea class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
                        </div>

                    </div>


                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary btn-sm" id="requestbtnre">Request</button>
            </div>

        </div>
    </div>
</div>

<!--------------------------------------Repayment Sheet Modal---------------------------------------------------------->
<div class="modal fade" id="repaymentSheetModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Repayment Sheet</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">
                <div class="row">

                    <div class="col-md-12">

                        <div class="form-group">
                            <label for="formGroupExampleInput">Select Centre</label>
                            <select name="center" id="centerselect" class="form-control yourExcludeClass">
                                <option value="0">Select</option>

                            </select>
                        </div>                        
                    </div>

                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary btn-sm" id="requestsheet">Request</button>
            </div>

        </div>
    </div>
</div>


<!--------------------------------------Disbursement Modal---------------------------------------------------------->
<div class="modal fade" id="DisbursementModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Disbursement Sheet</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">
                <div class="row">

                    <div class="col-md-12">

                        <div class="form-group">
                            <label for="formGroupExampleInput">Select Executive</label>
                            <select name="center" id="exeselect" class="form-control yourExcludeClass">
                                <option value="0">Select</option>

                            </select>
                        </div>                        
                    </div>
                    <div class="col-md-12">

                        <div class="form-group">
                            <label for="exampleSelect1">Filter By Date</label>
                            <!--<div style="height: 6px"></div>-->
                            <input type="date" class="form-control" id="daysdis">
                        </div>                        
                    </div>

                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary btn-sm" id="Disbursementsheet">Request</button>
            </div>

        </div>
    </div>
</div>