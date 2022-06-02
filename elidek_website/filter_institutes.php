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

	<div class="container">
    <div class="row" id="row">
        <div class="col-md-12">
			<h2>Filter by:</h2>
			<h5>(every field is optional)</h5>
            <form class="form-horizontal" name="student-form" method="POST">
                <div class="form-group col-sm-3 mb-3">
                    <label class = "form-label">Type</label>
                    <input class = "form-control", placeholder="Enter type", name="type">
                </div>
				<div class="form-group col-sm-3 mb-3">
                    <label class = "form-label">Town</label>
                    <input class = "form-control", placeholder="Enter end date", name="town">
                </div>
                <div class="form-group col-sm-3 mb-3">
                    <label class = "form-label">Number of </label>
                    <input class = "form-control", placeholder="Enter duration (months)", name="duration">
                <button class = "btn btn-primary btn-submit-custom" type="submit" name="submit_creds">Submit</button>
                <button class = "btn btn-primary btn-submit-custom" formaction="research_projects.php">Back</button>
            </form>
        </div>
        <div class="form-group col-sm-3 mb-3">
		<?php
			include 'myelidek.php';
			$conn = OpenCon();
			$query = "SELECT res.research_id, res.title, res.start_date, res.end_date, res.duration, res.summary
								FROM `research` as res;";
			if(isset($_POST['submit_creds'])){
				$start_date = $_POST['start_date'];
				$end_date = $_POST['end_date'];
				$duration = $_POST['duration'];
				$manager_id = $_POST['manager_id'];
				if ($start_date==null) $start_date = "NULL";
				if ($end_date==null) $end_date = "NULL";
				if ($duration==null) $duration = "NULL";
				if ($manager_id==null) $manager_id = "NULL";
				$query = "SELECT res.research_id, res.title, res.start_date, res.end_date, res.duration, res.summary
						FROM research as res WHERE (($start_date IS NULL OR start_date = '$start_date')
						AND ($end_date IS NULL OR end_date = '$end_date')
						AND ($duration IS NULL OR duration = '$duration')
						AND ($manager_id IS NULL OR manager_id = '$manager_id' ));";
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
			}
		?>
</body>