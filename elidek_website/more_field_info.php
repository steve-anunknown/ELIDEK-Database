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
		include 'myelidek.php';
        $conn = OpenCon();
		$id = $_GET['id'];
		$field_title = mysqli_query($conn,"SELECT s.title from science_field as s where s.field_id=".$id.";");
		$field_title = mysqli_fetch_row($field_title);
		$field_title = $field_title[0];
		$sql = "SELECT res.research_id, res.title, res.budget
				FROM `research` as res, is_about as i
				WHERE i.science_field_id = ".$id." 
				AND res.research_id = i.research_id
				AND ((res.start_date<=CURRENT_DATE() AND CURRENT_DATE()<=res.end_date) OR TIMESTAMPDIFF(MONTH,CURRENT_DATE(),res.end_date)<=12 );";
		$result = mysqli_query($conn,$sql);
		if ($result->num_rows > 0)
		{
		echo '<h3>Researches regarding '.$field_title.' from last year until today.</h3>';
		echo '<div class="table-responsive">';
            echo '<table class="table">';
				echo '<thead>';
                    echo '<tr>';
                        echo '<th>Research ID</th>';
						echo '<th>Title</th>';
                        echo '<th>Budget</th>';
					echo '</tr>';
				echo '</thead>';
				echo '<tbody>';
				while($row = mysqli_fetch_row($result))
				{
					echo '<tr>';
						echo '<td>' . $row[0] . '</td>';
						echo '<td>' . $row[1] . '</td>';
						echo '<td>' . $row[2] ."€". '</td>';
						echo '<td>';
						echo '</td>';
					echo '</tr>';
				}
				echo '</tbody>';
			echo '</table>';
		echo '</div>';
		}
		else { echo "No researches regarding " .$field_title. " took place from last year until today.\n";}
		$sql = "SELECT rer.first_name, rer.last_name, res.research_id 
				FROM `researcher` AS rer , `research` AS res, is_about AS i
				WHERE i.science_field_id = ".$id." AND res.research_id = i.research_id
				AND ((res.start_date<=CURRENT_DATE() AND CURRENT_DATE()<=res.end_date) OR TIMESTAMPDIFF(MONTH,CURRENT_DATE(),res.end_date)<=12 )
				AND rer.researcher_id = res.senior_scientist_id";
		$result = mysqli_query($conn,$sql);
		if ($result->num_rows > 0)
		{
		echo '<div class="table-responsive">';
            echo '<table class="table">';
				echo '<thead>';
                    echo '<tr>';
						echo '<th>Senior Scientist</th>';
                        echo '<th>First Name</th>';
                        echo '<th>Last Name</th>';
                        echo '<th>Research ID</th>';
					echo '</tr>';
				echo '</thead>';
				echo '<tbody>';
				while($row = mysqli_fetch_row($result))
				{
					echo '<tr>';
						echo '<td>'; echo '</td>';
						echo '<td>' . $row[0] . '</td>';
						echo '<td>' . $row[1] . '</td>';
						echo '<td>' . $row[2] . '</td>';
					echo '</tr>';
				}
				echo '</tbody>';
			echo '</table>';
		echo '</div>';
		}
		$sql = "SELECT rer.first_name, rer.last_name, res.research_id 
				FROM `researcher` AS rer , `research` AS res, `research_worker` AS w, `is_about` AS i
				WHERE i.science_field_id = ".$id." AND res.research_id = i.research_id
				AND ((res.start_date<=CURRENT_DATE() AND CURRENT_DATE()<=res.end_date) OR TIMESTAMPDIFF(MONTH,CURRENT_DATE(),res.end_date)<=12 )
				AND w.research_id = i.research_id AND w.worker_id = rer.researcher_id;";
		$result = mysqli_query($conn,$sql);
		if ($result->num_rows > 0)
		{
		echo '<div class="table-responsive">';
            echo '<table class="table">';
				echo '<thead>';
                    echo '<tr>';
						echo '<th>Researchers</th>';
                        echo '<th>First Name</th>';
                        echo '<th>Last Name</th>';
						echo '<th>Research ID</th>';
					echo '</tr>';
				echo '</thead>';
				echo '<tbody>';
				while($row = mysqli_fetch_row($result))
				{
					echo '<tr>';
						echo '<td>';
						echo '<td>' . $row[0] . '</td>';
						echo '<td>' . $row[1] . '</td>';
						echo '<td>' . $row[2] . '</td>';
						echo '</td>';
					echo '</tr>';
				}
				echo '</tbody>';
			echo '</table>';
		echo '</div>';
		}
		else {echo "No researchers working on " .$field_title. " from last year until today.";}
	?>
</body>