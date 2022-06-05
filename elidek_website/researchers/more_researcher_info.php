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
	<?php
		include '../myelidek.php';
        $conn = OpenCon();
		$id = $_GET['id'];
		$full_name = mysqli_query($conn,"SELECT first_name, last_name from researcher where researcher_id='$id';");
		$full_name = mysqli_fetch_row($full_name);
		$first_name = $full_name[0];
		$last_name = $full_name[1];
		$sql = "SELECT res.research_id, res.title, res.start_date, res.end_date, res.budget
				FROM `research` as res, research_worker as rw
				WHERE rw.worker_id = '$id'
				AND res.research_id = rw.research_id;";
		$result = mysqli_query($conn,$sql);
		if ($result->num_rows > 0)
		{
		echo '<h3>Researches where researcher '.$first_name.' '.$last_name.' has worked on or is currently working on.</h3>';
		echo '<div class="table-responsive">';
            echo '<table class="table">';
				echo '<thead>';
                    echo '<tr>';
                        echo '<th>Research ID</th>';
						echo '<th>Title</th>';
						echo '<th>Start Date</th>';
						echo '<th>End Date</th>';
                        echo '<th>Budget</th>';
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
						echo '<td>' . $row[4] ."€". '</td>';
					echo '</tr>';
				}
				echo '</tbody>';
			echo '</table>';
		echo '</div>';
		}
		else { echo '<h3>No researches where '.$first_name.' '.$last_name.' has worked on or is currently working on were found.</h3>';}
		$sql = "SELECT res.research_id, res.title, res.start_date, res.end_date, res.budget
				FROM research as res, researcher as rer
				WHERE rer.researcher_id = '$id' and rer.researcher_id = res.senior_scientist_id;";
		$result = mysqli_query($conn,$sql);
		if ($result->num_rows > 0)
		{
		echo '<h3>Researches where researcher '.$first_name.' '.$last_name.' has worked on as senior scientist.</h3>';
		echo '<div class="table-responsive">';
            echo '<table class="table">';
				echo '<thead>';
                    echo '<tr>';
						echo '<th>Research ID</th>';
						echo '<th>Title</th>';
						echo '<th>Start Date</th>';
						echo '<th>End Date</th>';
                        echo '<th>Budget</th>';
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
						echo '<td>' . $row[4] ."€". '</td>';
					echo '</tr>';
				}
				echo '</tbody>';
			echo '</table>';
		echo '</div>';
		}
		else
			echo '<h3>No researches where researcher '.$first_name.' '.$last_name.' has worked on as senior scientist.</h3>';
		$sql = "SELECT inst.inst_name, inst.acronym, inst.inst_type 
				FROM `institute` AS inst , `institute_worker` AS iw
				WHERE '$id'= iw.worker_id and iw.inst_id = inst.inst_id;";
		$result = mysqli_query($conn,$sql);
		if ($result->num_rows > 0)
		{
		echo '<h3>Institution where '.$first_name.' '.$last_name.' is employed.</h3>';
		echo '<div class="table-responsive">';
            echo '<table class="table">';
				echo '<thead>';
                    echo '<tr>';
						echo '<th>Institution Name</th>';
                        echo '<th>Acronym</th>';
						echo '<th>Type</th>';
					echo '</tr>';
				echo '</thead>';
				echo '<tbody>';
				while($row = mysqli_fetch_row($result))
				{
					echo '<tr>';
						echo '<td>' . $row[0] . '</td>';
						echo '<td>' . $row[1] . '</td>';
						echo '<td>' . $row[2] . '</td>';
					echo '</tr>';
				}
				echo '</tbody>';
			echo '</table>';
		echo '</div>';
		}
		else
			echo '<h3>No institution of employmend for '.$first_name.' '.$last_name.' was found.</h3>';
	?>
</body>