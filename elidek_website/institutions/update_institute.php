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
				<a class="navbar-brand" id="nav-bar-text">Databases PHP Demo - Update Institution Page</a>
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
					$query = "SELECT * FROM institute WHERE inst_id = $id";
					$res1 = mysqli_query($conn, $query);
					$row = mysqli_fetch_row($res1);
					echo '<div class="form-group col-sm-3 mb-3">';
						echo '<label class = "form-label">Change information for institute: <br><b>' . $row[0] . ' ' . $row[1] . ' '.$row[2]. ' '.$row[3]. '</b></label>';
					echo '<hr></div>';	
				?>
				<form class="form-horizontal" name="student-form" method="POST">
					<h3> Enter new Institution </h3>
					<h4> Name or Type cannot be empty </h4>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Institution Name</label>
						<input class = "form-control", placeholder="Enter name", name="name">
					</div>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Institution Acronym</label>
						<input class = "form-control", placeholder="Enter acronym", name="acronym">
					</div>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Institution Type ('university', 'research center' or 'corporation')</label>
						<input class = "form-control", placeholder="Enter type", name="type">
					</div>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Address Street Name</label>
						<input class = "form-control", placeholder="Enter street name of institution's address", name="street_name">
					</div>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Address Street Number</label>
						<input class = "form-control", placeholder="Enter street number of institution's address", name="street_number">
					</div>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Town</label>
						<input class = "form-control", placeholder="Enter institution's town", name="town">
					</div>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Postal Code</label>
						<input class = "form-control", placeholder="Enter postal code", name="postal_code">
					</div>
					<h4> If institution type is 'university' then fill out the ministry budget form </h4>
					<h4> If institution type is 'research center' then fill out the ministry budget and the private budget form </h4>
					<h4> If institution type is 'corporation' then fill out the private budget form </h4>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Ministry Budget</label>
						<input class = "form-control", placeholder="Enter ministry budget (euro)", name="ministry_budget">
					</div>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Private Budget</label>
						<input class = "form-control", placeholder="Enter private budget (euro)", name="private_budget">
					</div>
					<button class = "btn btn-primary btn-submit-custom" type="submit" name="submit_creds">Submit</button>
					<button class = "btn btn-primary btn-submit-custom" formaction="./institutions.php">Back</button>
				</form>
			</div>
				<div class="form-group col-sm-3 mb-3">
					<?php
						if(isset($_POST['submit_creds'])){		
							$name = isset($_POST['name'])? ($_POST['name']) : "NULL" ;
							$acronym = isset($_POST['acronym'])? ($_POST['acronym']): "NULL";
							$type = isset($_POST['type'])? ($_POST['type']): "NULL";
							$street_name = isset($_POST['street_name'])? ($_POST['street_name']): "NULL";
							$street_number = isset($_POST['street_number'])? ($_POST['street_number']): "NULL";
							$town = isset($_POST['town'])? ($_POST['town']): "NULL";
							$postal_code = isset($_POST['postal_code'])? ($_POST['postal_code']): "NULL";
							$query = "UPDATE research 
									SET inst_name = '$name', acronym = '$acronym', inst_type = '$type',
									street_name = '$street_name' , street_number='$street_number', town='$town', postal_code='$postal_code'
									WHERE inst_id = $id";
							$flag = true;
							if ($name == "NULL" or $type=="NULL")
								echo "Error while updating record: Name or Type cannot be empty <br>";
							else
							{
								try{mysqli_query($conn,$query);}
								catch(Exception $e){ $flag = false;}
								if ($flag)
								{
									if ($type=="university")
									{
										$query = "UPDATE `university` SET ministry_budget = '$ministry_budget', WHERE uni_id = SELECT MAX(inst_id) FROM `institute`";
										mysqli_query($conn,$query);
										header("Location: ./institutions.php");
										exit();
									}
									else if ($type=="research center")
									{
										$query = "UPDATE `research_center` SET private_budget = '$private_budget', ministry_budget = '$ministry_budget'
													WHERE center_id = SELECT MAX(inst_id) FROM `institute`";
										mysqli_query($conn,$query);
										header("Location: ./institutions.php");
										exit();
										
									}
									else if ($type=="corporation")
									{
										$query = "UPDATE `corporation` SET capital = '$private_budget', WHERE corp_id = SELECT MAX(inst_id) FROM `institute`";
										mysqli_query($conn,$query);
										header("Location: ./institutions.php");
										exit();
									}
									else
										echo "Error while updating record: Type must be either 'university', 'research center' or 'corporation' <br>";
								}
							}	
						}
					?>
				</div>
			</div>
		</div>
	</body>
</html>