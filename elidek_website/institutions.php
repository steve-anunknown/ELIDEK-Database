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
            <a class="navbar-brand" id="nav-bar-text">Databases PHP Elidek - Institutions page</a>
            <a id="navbar-items" href="/elidek_website/">
                <i class="fa fa-home "></i> Landing
            </a>
        </div>
    </nav>
	<div class="container">
		<div class="row" id="row">
			<div class="col-md-12">
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
					<h4> If institution type is 'research center' then fill out the ministry budget and the private budget form </h4>
					<h4> If institution type is 'corporation' then fill out the private budget form </h4>
					<h4> If institution type is 'university' then fill out the ministry budget form </h4>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Ministry Budget</label>
						<input class = "form-control", placeholder="Enter ministry budget (euro)", name="ministry_budget">
					</div>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Private Budget</label>
						<input class = "form-control", placeholder="Enter private budget (euro)", name="private_budget">
					</div>
					<button class = "btn btn-primary btn-submit-custom" type="submit" name="submit_creds">Submit</button>
					<button class = "btn btn-primary btn-submit-custom" formaction="index.php">Back</button>
				</form>
			</div>
			<div class="form-group col-sm-3 mb-3">
				<?php
					include 'myelidek.php';
					$conn = OpenCon();
					if(isset($_POST['submit_creds']))
					{
						$name = isset($_POST['name'])? ($_POST['name']) : "NULL" ;
						$acronym = isset($_POST['acronym'])? ($_POST['acronym']): "NULL";
						$type = isset($_POST['type'])? ($_POST['type']): "NULL";
						$street_name = isset($_POST['street_name'])? ($_POST['street_name']): "NULL";
						$street_number = isset($_POST['street_number'])? ($_POST['street_number']): "NULL";
						$town = isset($_POST['town'])? ($_POST['town']): "NULL";
						$postal_code = isset($_POST['postal_code'])? ($_POST['postal_code']): "NULL";
						$ministry_budget= isset($_POST['ministry_budget'])? ($_POST['ministry_budget']): "NULL";
						$private_budget= isset($_POST['private_budget'])? ($_POST['private_budget']): "NULL";
						$query = "INSERT INTO `institute` (inst_name, acronym, inst_type, street_name, street_number, town, postal_code)
								VALUES ('$name', '$acronym','$type','$street_name','$street_number', '$town', '$postal_code');";
						$flag = true;
						if ($name == "NULL" or $type=="NULL")
						{	
							echo "Error while creating record: Name or Type cannot be empty <br>";
							#header("Location: ./institutions.php");
						}
						else
						{
							try
							{
								mysqli_query($conn,$query);
							}
							catch(Exception $e)
							{
								$flag = false;
							}
							if ($flag)
							{
								if ($type=="university")
								{
									$query = "UPDATE `university` SET ministry_budget = '$ministry_budget' WHERE uni_id = (SELECT MAX(uni_id) FROM `university`);";
								}
								else if ($type=="research center")
								{
									$query = "UPDATE `research_center` SET private_budget = '$private_budget', ministry_budget = '$ministry_budget'
												WHERE center_id = (SELECT MAX(center_id) FROM `research_center`);";
								}
								else if ($type=="corporation")
								{
									$query = "UPDATE `corporation` SET capital = '$private_budget' WHERE corp_id = (SELECT MAX(corp_id) FROM `corporation`);";
								}
								else
									echo "Error while creating record: Type must be either 'university', 'research center' or 'corporation' <br>";
								try
								{
									mysqli_query($conn,$query);
								}
								catch(Exception $e)
								{
									$flag=false;
								}
								if ($flag)
								{	
									header("Location: ./institutions.php");
									exit();
								}
								else
									echo "Error while creating record: <br>" . mysqli_error($conn) . "<br>";
							}
						}
					}
				?>
			</div>
		</div>
	</div>
	<?php
		$query = "SELECT * FROM `institute`;";
		$result = mysqli_query($conn,$query);
		if ($result->num_rows > 0)
		{
			echo '<div class="table-responsive">';
				echo '<table class="table">';
					echo '<thead>';
						echo '<tr>';
							echo '<th>Insitute ID</th>';
							echo '<th>Name</th>';
							echo '<th>Acronym</th>';
							echo '<th>Type</th>';
							echo '<th>Address Street Name</th>';
							echo '<th>Address Street Number</th>';
							echo '<th>Town</th>';
							echo '<th>Postal Code</th>';
						echo '</tr>';
					echo '</thead>';
					echo '<tbody>';
					while($row = mysqli_fetch_row($result))
					{
						echo '<tr>';
							echo '<td>' . $row[0] . '</td>';
							echo '<td>' . $row[1] . '</td>';
							echo '<td>' . $row[2] . '</td>';
							echo '<td>' . $row[3] . '</td>';
							echo '<td>' . $row[4] . '</td>';
							echo '<td>' . $row[5] . '</td>';
							echo '<td>' . $row[6] . '</td>';
							echo '<td>' . $row[7] . '</td>';
							echo '<td><a href="budget_info.php?id='.$row[0].'">budget info</a></td>';
							echo '<td>';
								echo '<a type="button" href="./update_institute.php?id=' . $row[0]. '">';
									echo '<i class="fa fa-edit"></i>';
								echo '</a>';
							echo '</td>';
							echo '<td>';
								echo '<a type="button" href="./delete_institute.php?id=' . $row[0]. '">';
									echo '<i class = "fa fa-trash"></i>';
								echo '</a>';
							echo '</td>';
						echo '</tr>';
					}
					echo '</tbody>';
				echo '</table>';
			echo '</div>';
		}
		else
			echo "No data ...";
	?>
</body>