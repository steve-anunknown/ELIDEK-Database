<!DOCTYPE html>
<html lang = "en">

	<head>
		<meta charset = "utf-8">
		<meta name = "viewport" content = "width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>
			Databases PHP Demo
		</title>
		<link rel = "stylesheet" href = "css/styles.css">
		<link rel = "stylesheet" href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
		<link rel = "stylesheet" href = "bootstrap/css/bootstrap.min.css">
	</head>
	<body>
		<nav class="navbar navbar-light navbar-expand-md" id="nav-bar">
			<div id="navbar-div" class="container-fluid">
				<a class="navbar-brand" id="nav-bar-text">Databases PHP Demo - Update Research Project Page</a>
				<a id="navbar-items" href="/elidek/">
					<i class="fa fa-home "></i> Landing
				</a>
			</div>
		</nav>
		<div class="container">
			<div class="row" id="row">
				<div class="col-md-12">
					<?php
						include '../myelidek.php';
						$conn = OpenCon();
						$id = $_GET['id'];
						$query = "SELECT s.research_id, s.title, s.start_date, s.end_date, s.duration FROM research as s WHERE research_id = $id";
						$res1 = mysqli_query($conn, $query);
						$row = mysqli_fetch_row($res1);
						echo '<div class="form-group col-sm-3 mb-3">';
							echo '<label class = "form-label">Change information for research project: <br><b>' . $row[0] . ' ' . $row[1] . ' '.$row[2]. ' '.$row[3]. ' '.$row[4]. '</b></label>';
						echo '<hr></div>';	
					?>
					<form class="form-horizontal" name="student-form" method="POST">
						<h3> Enter new research project </h3>
						<div class="form-group col-sm-3 mb-3">
							<label class = "form-label">Research Project Title</label>
							<input class = "form-control", placeholder="Enter project's title", name="title">
						</div>
						<div class="form-group col-sm-3 mb-3">
							<label class = "form-label">Project Summary</label>
							<input class = "form-control", placeholder="Enter project's summary", name="summary">
						</div>
						<div class="form-group col-sm-3 mb-3">
							<label class = "form-label">Start Date</label>
							<input class = "form-control", placeholder="Enter start date (Y-M-D)", name="start_date">
						</div>
						<div class="form-group col-sm-3 mb-3">
							<label class = "form-label">End Date</label>
							<input class = "form-control", placeholder="Enter end date (Y-M-D)", name="end_date">
						</div>
						<div class="form-group col-sm-3 mb-3">
							<label class = "form-label">Budget</label>
							<input class = "form-control", placeholder="Enter budget (euro)", name="budget">
						</div>
						<div class="form-group col-sm-3 mb-3">
							<label class = "form-label">Institute ID</label>
							<input class = "form-control", placeholder="Enter institute ID", name="inst_id">
						</div>
						<div class="form-group col-sm-3 mb-3">
							<label class = "form-label">Senior Scientist ID</label>
							<input class = "form-control", placeholder="Enter senior scientist ID", name="senior_scientist_id">
						</div>	
						<div class="form-group col-sm-3 mb-3">
							<label class = "form-label">Manager ID</label>
							<input class = "form-control", placeholder="Enter elidek manager ID", name="manager_id">
						</div>
						<div class="form-group col-sm-3 mb-3">
							<label class = "form-label">Program Id</label>
							<input class = "form-control", placeholder="Enter program ID", name="program_id">
						</div>
							<div class="form-group col-sm-3 mb-3">
							<label class = "form-label">Science Field ID</label>
							<input class = "form-control", placeholder="Enter field ID", name="field_id">
						</div>
						<button class = "btn btn-primary btn-submit-custom" type="submit" name="submit_creds">Submit</button>
						<button class = "btn btn-primary btn-submit-custom" formaction="research_projects.php">Back</button>
					</form>
				</div>
				<div class="form-group col-sm-3 mb-3">
					<?php
						if(isset($_POST['submit_creds'])){		
							$title = isset($_POST['title'])? ($_POST['title']) : "NULL" ;
							$summary = isset($_POST['summary'])? ($_POST['summary']): " ";
							$start_date = isset($_POST['start_date'])? ($_POST['start_date']): date("Y-m-d");
							$end_date = isset($_POST['end_date'])? ($_POST['end_date']): strtotime($start_date.'+ 1 years');
							$budget = isset($_POST['budget'])? ($_POST['budget']): "NULL";
							$inst_id = isset($_POST['inst_id'])? ($_POST['inst_id']): "NULL";
							$senior_scientist_id = isset($_POST['senior_scientist_id'])? ($_POST['senior_scientist_id']): "NULL";
							$manager_id = isset($_POST['manager_id'])? ($_POST['manager_id']): "NULL";
							$program_id = isset($_POST['program_id'])? ($_POST['program_id']): "NULL";
							$field_id = isset($_POST['field_id'])? ($_POST['field_id']): "NULL";
							$query = "UPDATE research 
									SET title = '$title', summary = '$summary', start_date = '$start_date', end_date = '$end_date',
									budget = '$budget', inst_id = '$inst_id', senior_scientist_id = '$senior_scientist_id',
									manager_id ='$manager_id', program_id = '$program_id'
									WHERE research_id = $id";
							$flag = true;
							if ($field_id != "NULL" and $program_id=="NULL")
								echo "Error while creating record: When entering science field ID you also have to specify the program ID <br>";
							else if ($field_id != "NULL")
							{
								$query2 = "UPDATE `is_about` SET research_id = '$id',science_field_id = '$field_id' WHERE research_id = '$id' ;";
								mysqli_query($conn,$query2);
							}
							try {mysqli_query($conn,$query);}
							catch(Exception $e) {$flag = false;}
							if ($flag) {
								//echo "Record updated successfully";
								header("Location: ./research_projects.php");
								exit();
							}
							else{
								echo "Error while updating record: <br>" . mysqli_error($conn) . "<br>";
							}	
						}
					?>
				</div>
			</div>
		</div>
	</body>
</html>