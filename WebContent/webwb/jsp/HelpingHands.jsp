<%@page import="com.yourdistrict.BloodGroups"%>
<%@page import="com.yourdistrict.BloodNeeds"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="com.yourdistrict.DataManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telangana</title>
<style type="text/css">
#DonateBloodTable {
	border: 1px solid;
}

#helpingHandsMenu {
	float: top;
	font-family: Arial;
	font-size: 14px;
	margin-top: 3px;
	color: black;
	border: solid 1px black;
	overflow: hidden;
}

.HelpingHandsButton {
	border: 1px solid; /* Gray border */
	border-radius: 4px; /* Rounded border */
}
</style>
</head>
<body>
	<%
		String districtName = (String) request.getAttribute("DistrictName");
	%>
	<input type="hidden" id="hiddenText" value="<%= districtName %>" />
	
	<div id="HelpingHandsInfo">
		<div id="#helpingHandsMenu">
			<button class="HelpingHandsButton"
				onClick="getHelpingHandDiv(this.value);hideSiblings(this.value);" value="DonateBlood">Register
				as Blood Donor</button>
			<button class="HelpingHandsButton"
				onClick="getHelpingHandDiv(this.value);hideSiblings(this.value);" value="SearchDonor">Search for a Blood
				Donor</button>
			<button class="HelpingHandsButton"
				onClick="getHelpingHandDiv(this.value);hideSiblings(this.value);" value="NeedBlood">Post a Need for
				Blood</button>
			<button class="HelpingHandsButton"
				onClick="getHelpingHandDiv(this.value); getPostedNeeds(<%= districtName %>); hideSiblings(this.value);" value="ViewNeeds">View
				Needs</button>
		</div>
		<br />
		<div id="HelpingHandsCenterContent">
			<div id="GenericHelpingHands"><p>We welcome enrollment from medically fit BLOOD DONORS between
					the age of 18-55 years, and not less than 45 kgs in weight. We are
					very glad that you are signing up as donor. To register as a blood
					donor is a responsibility.</p>
				<p align="center">
					<font color="red"><b>Blood Donation will cost you
							nothing but it will save a life!</b></font>
				</p></div>
			<div id="DonateBlood" style="display: none;">
				<div>
					<form id="RegisterForm" name="RegisterFormName">
						<table>
							<tr>
								<td><h3>Fill Your Information!</h3></td>
							</tr>
							<tr>
								<td><label>Name:</label></td>
								<td><input id="DonorName" placeholder="Your Name"
									type="text"></td>
							</tr>

							<tr>
								<td><label>Age:</label></td>
								<td><input id="age" onkeypress="return isNumberKey(event)" 
    maxlength="3" placeholder="Your Age" type="text"></td>
							</tr>
							<tr>
								<td><label>Contact No:</label></td>
								<td><input id="phone" onkeypress="return isNumberKey(event)" 
    maxlength="10" placeholder="Your Mobile No."
									type="text"></td>
							</tr>
							<tr>
								<td><label>Gender:</label></td>
								<td><input name="sex" type="radio" value="male">Male
									<input name="sex" type="radio" value="female">Female</td>
							</tr>
							<tr>
								<td><label>Blood Group:</label></td>
								<td><% String html1 = BloodGroups.getBloodGroupsDropDownHTML("DonateBloodDDDivId"); %>
							<%= html1 %></td>
							</tr>
							<tr>
								<td><label>Location:</label></td>
								<td><input id="place" placeholder="Your Location"
									type="text"></td>
							</tr>
							<tr>
								<td><input id="submitRegistration" type="button"
									value="Submit"></td>
							</tr>
						</table>
					</form>
				</div>
			</div>
			<div id="SearchDonor" style="display: none;">
				<form id="SearchDonorForm">
					<table>
						<tr>
							<td><label>Blood Group : </label></td>
							<td><% String html2 = BloodGroups.getBloodGroupsDropDownHTML("SearchDonorDDvidId"); %>
							<%= html2 %></td>
							<td><input type="submit" id="submitSearch" value="Go"></input></td>
						</tr>
					</table>
					
				</form>
				<br/>
				<div id="SearchDonorList"> </div>
			</div>
			
			<div id="NeedBlood" style="display: none;">
				<form id="PostNeedForm" name="PostNeedFormName">
						<table>
							<tr>
								<td><h3>Request Blood!</h3></td>
							</tr>
							<tr>
								<td><label>Contact Name:</label></td>
								<td><input id="neededfor" placeholder="Blood needed for"
									type="text"></td>
							</tr>

							<tr>
								<td><label>Contact No:</label></td>
								<td><input id="needyphone" onkeypress="return isNumberKey(event)" 
    maxlength="10" placeholder="Mobile No."
									type="text"></td>
							</tr>
							<tr>
								<td><label>Blood Group:</label></td>
								<td><% String html3 = BloodGroups.getBloodGroupsDropDownHTML("NeedBloodDDvidId"); %>
							<%= html3 %></td>
							</tr>
							<tr>
								<td><label>Location:</label></td>
								<td><input id="needylocation" placeholder="Location"
									type="text"></td>
							</tr>
							<tr>
								<td><label>Date when blood required:</label></td>
								<td><input id="datewhenrequired" placeholder="Date in format dd/MM/yyyy" type="date"></td>
							</tr>
							<tr>
								<td><label>Purpose:</label></td>
								<td><textarea rows="5" cols="22" id="purpose"></textarea></td>
							</tr>
							
							<tr>
								<td><input id="submitBloodNeed" type="button"
									value="Submit"></td>
							</tr>
						</table>
					</form>
			
			</div>
			<div id="ViewNeeds" style="display: none;" >
			</div>

		</div>
	</div>
</body>

<script type="text/javascript">

	function getPostedNeeds(districtName) {
		debugger;
		var url = "./StateInfo?instance=PostedNeeds.jsp&districtName="+$("#hiddenText").attr('value');
		$.get(url, null, function(data) {
			$('#ViewNeeds').html(data);
			$('#ViewNeeds').show();
		});
	}
	
	function getHelpingHandDiv(divID) {
		debugger;
		$('#GenericHelpingHands').siblings().hide();
		$('#GenericHelpingHands').show();
	}
	
	function hideSiblings(divID) {
		debugger;
		$('#' + divID).show();
		$('#' + divID).siblings().hide();
	}

	$(document).ready(function() {
						$("#submitRegistration").click(
										function() {
											debugger;
											var name = $("#DonorName").val();
											var phone = $("#phone").val();
											var age = $("#age").val();
											var bloodgroup = $('#DonateBloodDDDivId option:selected').val();
											var place = $("#place").val();
											var gender = $(
													"input[type=radio]:checked")
													.val();
											if (name == '' || age == ''
													|| bloodgroup == ''
													|| gender == '') {
												alert("Insertion Failed Some Fields are Blank....!!");
											} else {
												// Returns successful data submission message when the entered information is stored in database.
												$
														.post(
																"./StateInfo?insertData=true&tablename=donors&DonorName="
																		+ name
																		+ "&age="
																		+ age
																		+ "&place="
																		+ place
																		+ "&phone="
																		+ phone
																		+ "&bloodgroup="
																		+ bloodgroup
																		+ "&sex="
																		+ gender
																		+"&DistrictName="
																		+$("#hiddenText").attr('value'),
																function(data) {
																	$('#RegisterForm')[0]
																			.reset(); // To reset form fields
																});
											}
										});
						
						$("#submitSearch")
						.click(function() {
								debugger;
								var bloodgroup = $("#SearchDonorDDvidId option:selected").val();
								if (bloodgroup == ''){
									alert("Please select some Blood Group....!!");
								} else {
									$.post("./StateInfo?instance=SearchDonorResponse.jsp&bloodgroup="+bloodgroup+"&DistrictName="+$("#hiddenText").attr('value'),
										function(data) {
										//	$('#SearchDonorForm')[0].reset();
											$('#SearchDonorList').html(data);
										});
								}
							});
						
						
						$("#submitBloodNeed")
						.click(
								function() {
									debugger;
									var name = $("#neededfor").val();
									var phone = $("#needyphone").val();
									var purpose = $("#purpose").val();
									var bloodgroup = $("#NeedBloodDDvidId option:selected").val();
									var place = $("#needylocation").val();
									var dateWhenRequired = $("#datewhenrequired").val();
									if (name == '' || phone == ''
											|| bloodgroup == ''
											|| dateWhenRequired == '') {
										alert("Insertion Failed Some Fields are Blank....!!");
									} else {
										$.post("./StateInfo?insertData=true&tablename=bloodneeds&neededfor="
																+ name
																+ "&needyphone="
																+ phone
																+ "&purpose="
																+ purpose
																+ "&needybloodgroup="
																+ bloodgroup
																+ "&needylocation="
																+ place 
																+ "&datewhenrequired="
																+ dateWhenRequired
																+"&DistrictName="
																+$("#hiddenText").attr('value'),
														function(data) {
															$('#PostNeedForm')[0]
																	.reset(); // To reset form fields
														});
									}
								});
					});
</script>

</html>