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
					<h3> Enter new Research Worker </h3>
					<h4> Make sure that the research project is managed by the same institute where the researcher is employed.</h4>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Researcher ID</label>
						<input class = "form-control", placeholder="Enter researcher ID", name="worker_id">
					</div>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Research ID</label>
						<input class = "form-control", placeholder="Enter research ID", name="research_id">
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
				$worker_id = isset($_POST['worker_id'])? ($_POST['worker_id']) : "NULL";
				$research_id = isset($_POST['research_id'])? ($_POST['research_id']) : "NULL";
				if ($worker_id == "NULL" or $research_id == "NULL")
				{
					echo "Researcher ID or Research ID should not be empty!";
				}
				else
				{
					$query = "INSERT INTO `research_worker`
							VALUES ('$worker_id', '$research_id');";
					$flag = true;
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
						header("Location: ./research_projects_per_researcher.php");
						exit();
					}
					else
					{
						echo "Error while creating record: <br>" . mysqli_error($conn) . "<br>";
					}
				}
			}
			$sql = "SELECT * FROM `researches_per_worker`;";
			$result = mysqli_query($conn,$sql);
			if ($result->num_rows > 0)
			{
				echo '<div class="table-responsive">';
					echo '<table class="table">';
						echo '<thead>';
							echo '<tr>';
								echo '<th>Researcher ID</th>';
								echo '<th>First Name</th>';
								echo '<th>Last Name</th>';
								echo '<th>Research ID</th>';
								echo '<th>Research Title</th>';
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
								echo '<td><a href="more_research_info.php?id='.$row[3].'">more info</a></td>';
							echo '</tr>';
						}
						echo '</tbody>';
					echo '</table>';
				echo '</div>';
			}
		?>
</body>