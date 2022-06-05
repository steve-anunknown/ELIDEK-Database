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
				<a class="navbar-brand" id="nav-bar-text">Databases PHP Demo - Update Funding Program Page</a>
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
						$query = "SELECT s.title, s.budget, s.elidek_address FROM funding_program as s WHERE program_id = $id";
						$res1 = mysqli_query($conn, $query);
						$row = mysqli_fetch_row($res1);
						echo '<div class="form-group col-sm-3 mb-3">';
							echo '<label class = "form-label">Change information for funding program: <br><b>' . $row[0] . ' ' . $row[1] . ' '.$row[2]. '</b></label>';
						echo '<hr></div>';	
					?>
					<form class="form-horizontal" name="student-form" method="POST">
						<div class="form-group col-sm-3 mb-3">
							<label class = "form-label">New Title</label>
							<input class = "form-control", name="title", placeholder="Title">
						</div>
						<div class="form-group col-sm-3 mb-3">
							<label class = "form-label">New Budget</label>
							<input class = "form-control", name="budget", placeholder="Budget">
						</div>
						<div class="form-group col-sm-3 mb-3">
							<label class = "form-label">New Elidek Address</label>
							<input class = "form-control", name="el_address", placeholder="Elidek Address">
						</div>
						<button class = "btn btn-primary btn-submit-custom" type = "submit" name="submit_upd">Submit</button>
						<button class = "btn btn-primary btn-submit-custom" formaction="./funding_programs.php">Back</button>
					</form>
				</div>
				<div class="form-group col-sm-3 mb-3">
					<?php
						if(isset($_POST['submit_upd'])){		
							$title = $_POST['title'];
							$budget = $_POST['budget'];
							$el_address = $_POST['el_address'];
							$query = "UPDATE funding_program 
									SET title = '$title', budget = '$budget', elidek_address = '$el_address'
									WHERE program_id = $id";
							if (mysqli_query($conn, $query)) {
								//echo "Record updated successfully";
								header("Location: ./funding_programs.php");
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