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
		$sql = "SELECT inst_type FROM `institute` WHERE inst_id = ".$id." ;";
		$result = mysqli_query($conn,$sql);
		$row = mysqli_fetch_row($result);
		if($row[0]=="university")
		{
			$query = "SELECT * FROM `university` where uni_id = ".$id.";";
			$result = mysqli_query($conn,$query);
			if ($result->num_rows > 0)
			{
				echo '<div class="table-responsive">';
					echo '<table class="table">';
						echo '<thead>';
							echo '<tr>';
								echo '<th>University ID</th>';
								echo '<th>Minsitry Budget</th>';
							echo '</tr>';
						echo '</thead>';
						echo '<tbody>';
						while($row = mysqli_fetch_row($result))
						{
							echo '<tr>';
								echo '<td>' . $row[0] . '</td>';
								echo '<td>' . $row[1] ."€". '</td>';
							echo '</tr>';
						}
						echo '</tbody>';
					echo '</table>';
				echo '</div>';
			}
		}
		else if($row[0]=="corporation")
		{
			$query = "SELECT * FROM `corporation` where corp_id = ".$id.";";
			$result = mysqli_query($conn,$query);
			if ($result->num_rows > 0)
			{
				echo '<div class="table-responsive">';
					echo '<table class="table">';
						echo '<thead>';
							echo '<tr>';
								echo '<th>Corporation ID</th>';
								echo '<th>Private Budget</th>';
							echo '</tr>';
						echo '</thead>';
						echo '<tbody>';
						while($row = mysqli_fetch_row($result))
						{
							echo '<tr>';
								echo '<td>' . $row[0] . '</td>';
								echo '<td>' . $row[1] ."€". '</td>';
							echo '</tr>';
						}
						echo '</tbody>';
					echo '</table>';
				echo '</div>';
			}
		}
		else
		{
			$query = "SELECT * FROM `research_center` where center_id = ".$id.";";
			$result = mysqli_query($conn,$query);
			if ($result->num_rows > 0)
			{
				echo '<div class="table-responsive">';
					echo '<table class="table">';
						echo '<thead>';
							echo '<tr>';
								echo '<th>Research Center ID</th>';
								echo '<th>Ministry Budget</th>';
								echo '<th>Private Budget</th>';
								echo '<th>Total Budget</th>';
							echo '</tr>';
						echo '</thead>';
						echo '<tbody>';
						while($row = mysqli_fetch_row($result))
						{
							echo '<tr>';
								echo '<td>' . $row[0] . '</td>';
								echo '<td>' . $row[1] ."€". '</td>';
								echo '<td>' . $row[2] ."€". '</td>';
								echo '<td>' . $row[3] ."€". '</td>';
							echo '</tr>';
						}
						echo '</tbody>';
					echo '</table>';
				echo '</div>';
			}
		}
	?>
</body>