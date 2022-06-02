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
	<a href="filter_researches.php">Filter researches</a>
	<nav class="navbar navbar-light navbar-expand-md" id="nav-bar">
        <div id="navbar-div" class="container-fluid">
            <a class="navbar-brand" id="nav-bar-text">Databases PHP Elidek - Research Projects page</a>
            <a id="navbar-items" href="/elidek_website/">
                <i class="fa fa-home "></i> Landing
            </a>
        </div>
    </nav>
	<div class="container">
		<div class="row" id="row">
			<div class="col-md-12">
				<form class="form-horizontal" name="student-form" method="POST">
					<h3> Enter new Research Project </h3>
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
					<button class = "btn btn-primary btn-submit-custom" formaction="index.php">Back</button>
				</form>
			</div>
			<div class="form-group col-sm-3 mb-3">
				<?php
					include 'myelidek.php';
					$conn = OpenCon();
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
						$query = "INSERT INTO `research` (title, summary, start_date,end_date,budget,inst_id,senior_scientist_id,manager_id,program_id)
								VALUES ('$title', '$summary','$start_date','$end_date','$budget', '$inst_id', '$senior_scientist_id', '$manager_id','$program_id')";
						$flag = true;
						$field_id = isset($_POST['field_id'])? ($_POST['field_id']): "NULL";
						if ($field_id != "NULL")
						{
							$query2 = "INSERT INTO `is_about` values ((SELECT MAX(research_id) FROM research),'$field_id');";
							mysqli_query($conn,$query2);
						}
						try{mysqli_query($conn,$query);}
						catch(Exception $e){ $flag = false;}
						if ($flag) {
							//echo "New record created successfully";
							header("Location: ./research_projects.php");
							exit();
						}
						else{
							echo "Error while creating record: <br>" . mysqli_error($conn) . "<br>";
						}
					}
				?>
			</div>
		</div>
    </div>
	<?php
			$query = "SELECT res.research_id, res.title, res.start_date, res.end_date, res.duration, res.summary
							FROM `research` as res;";
			$result = mysqli_query($conn,$query);
			if ($result->num_rows > 0)
			{
				echo '<div class="table-responsive">';
					echo '<table class="table">';
						echo '<thead>';
							echo '<tr>';
								echo '<th>Research ID</th>';
								echo '<th>Title</th>';
								echo '<th>Start date</th>';
								echo '<th>End date</th>';
								echo '<th>Duration</th>';
								echo '<th></th>';
								echo '<th></th>';
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
								echo '<td>' . $row[4] ." Months". '</td>';
								echo '<td><a href="more_research_info.php?id='.$row[0].'">more info</a></td>';
								echo '<td>';
									echo '<a type="button" href="./update_research.php?id=' . $row[0]. '">';
										echo '<i class="fa fa-edit"></i>';
									echo '</a>';
								echo '</td>';
								echo '<td>';
									echo '<a type="button" href="./delete_research.php?id=' . $row[0]. '">';
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
			{
				echo "No data ...";
			}
	?>
</body>