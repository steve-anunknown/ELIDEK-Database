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
            <a class="navbar-brand" id="nav-bar-text">Databases PHP Elidek - Researchers page</a>
            <a id="navbar-items" href="/elidek_website/">
                <i class="fa fa-home "></i> Landing
            </a>
        </div>
    </nav>
	<div class="container">
		<div class="row" id="row">
			<div class="col-md-12">
				<form class="form-horizontal" name="student-form" method="POST">
					<h3> Enter new Researcher </h3>
					<h4> First name, Last name or gender cannot be empty</h4>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">First Name</label>
						<input class = "form-control", placeholder="Enter first name", name="first_name">
					</div>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Last Name</label>
						<input class = "form-control", placeholder="Enter last name", name="last_name">
					</div>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Gender</label>
						<input class = "form-control", placeholder="Enter gender", name="gender">
					</div>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Birthday (Y-MM-DD)</label>
						<input class = "form-control", placeholder="Enter birthday", name="birthday">
					</div>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Institute ID</label>
						<input class = "form-control", placeholder="Enter institute ID", name="inst_id">
					</div>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Date of employment (Y-MM-DD)</label>
						<input class = "form-control", placeholder="Enter date of employment", name="start_date">
					</div>
					<button class = "btn btn-primary btn-submit-custom" type="submit" name="submit_creds">Submit</button>
					<button class = "btn btn-primary btn-submit-custom" formaction="../index.php">Back</button>
				</form>
			</div>
			<div class="form-group col-sm-3 mb-3">
				<?php
					include '../myelidek.php';
					$conn = OpenCon();
					if(isset($_POST['submit_creds']))
					{
						$first_name = isset($_POST['first_name'])? ($_POST['first_name']) : "NULL" ;
						$last_name = isset($_POST['last_name'])? ($_POST['last_name']): "NULL";
						$gender = isset($_POST['gender'])? ($_POST['gender']): "NULL";
						$birthday = isset($_POST['birthday'])? ($_POST['birthday']): "NULL";
						$inst_id = isset($_POST['inst_id'])? ($_POST['inst_id']): "NULL";
						$start_date = isset($_POST['start_date'])? ($_POST['start_date']): "NULL";
						$query = "INSERT INTO `researcher` (first_name, last_name, gender, birthday)
								VALUES ('$first_name', '$last_name','$gender','$birthday');";
						$flag = true;
						if ($first_name == "NULL" or $last_name == "NULL" or $gender == "NULL")
						{	
							echo "Error while creating record: First name, Last name or gender cannot be empty <br>";
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
								if ($inst_id!="NULL")
								{
									$query = "UPDATE `institute_worker` SET inst_id = '$inst_id', start_date = '$start_date'
											WHERE worker_id = (SELECT MAX(researcher_id) FROM `researcher`);";
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
										header("Location: ./researchers.php");
										exit();
									}
									else
										echo "Error while creating record: <br>" . mysqli_error($conn) . "<br>";
								}
							}
						}
					}
				?>
			</div>
		</div>
	</div>
	<?php
		$query = "SELECT * FROM `researcher`;";
		$result = mysqli_query($conn,$query);
		if ($result->num_rows > 0)
		{
			echo '<div class="table-responsive">';
				echo '<table class="table">';
					echo '<thead>';
						echo '<tr>';
							echo '<th>Researcher ID</th>';
							echo '<th>First Name</th>';
							echo '<th>Last Name</th>';
							echo '<th>Gender</th>';
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
							echo '<td><a href="more_researcher_info.php?id='.$row[0].'">more info</a></td>';
							echo '<td>';
								echo '<a type="button" href="./update_researcher.php?id=' . $row[0]. '">';
									echo '<i class="fa fa-edit"></i>';
								echo '</a>';
							echo '</td>';
							echo '<td>';
								echo '<a type="button" href="./delete_researcher.php?id=' . $row[0]. '">';
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