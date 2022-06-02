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
		$sql = "SELECT res.summary, res.program_id, res.budget FROM `research` as res where res.research_id = ".$id." ;";
		$result = mysqli_query($conn,$sql);
		if ($result->num_rows > 0)
		{
		echo '<div class="table-responsive">';
            echo '<table class="table">';
				echo '<thead>';
                    echo '<tr>';
                        echo '<th>Project Summary</th>';
                        echo '<th>Program ID</th>';
                        echo '<th>Budget</th>';
						echo '<th></th>';
					echo '</tr>';
				echo '</thead>';
				echo '<tbody>';
				while($row = mysqli_fetch_row($result))
				{
					echo '<tr>';
						echo '<td>' . $row[0] . '</td>';
						echo '<td>' . $row[1] . '</td>';
						echo '<td>' . $row[2] ."€". '</td>';
					echo '</tr>';
				}
				echo '</tbody>';
			echo '</table>';
		echo '</div>';
		}
		$sql = "SELECT * FROM institute as inst, research as res where res.research_id = ".$id." and inst.inst_id = res.inst_id;";
		$result = mysqli_query($conn,$sql);
		if ($result->num_rows > 0)
		{
		echo '<div class="table-responsive">';
            echo '<table class="table">';
				echo '<thead>';
                    echo '<tr>';
                        echo '<th>Institution ID</th>';
                        echo '<th>Name</th>';
						echo '<th>Acronym</th>';
                        echo '<th>Type</th>';
						echo '<th>Street Name</th>';
						echo '<th>Street Number</th>';
						echo '<th>Town</th>';
						echo '<th>Postal Code</th>';
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
						echo '<td>' . $row[4] . '</td>';
						echo '<td>' . $row[5] . '</td>';
						echo '<td>' . $row[6] . '</td>';
						echo '<td>' . $row[7] . '</td>';
						echo '<td>';
						echo '</td>';
					echo '</tr>';
				}
				echo '</tbody>';
			echo '</table>';
		echo '</div>';
		}
		$sql = "SELECT rer.first_name, rer.last_name FROM `researcher` as rer , `research` as res where res.research_id = ".$id." and rer.researcher_id = res.senior_scientist_id";
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
                        echo '<th></th>';
						echo '<th></th>';
					echo '</tr>';
				echo '</thead>';
				echo '<tbody>';
				while($row = mysqli_fetch_row($result))
				{
					echo '<tr>';
						echo '<td>';
						echo '<td>' . $row[0] . '</td>';
						echo '<td>' . $row[1] . '</td>';
						
						echo '</td>';
					echo '</tr>';
				}
				echo '</tbody>';
			echo '</table>';
		echo '</div>';
		}
		$sql = "SELECT rer.first_name, rer.last_name FROM `researcher` as rer , `research` as res, `research_worker` as w where res.research_id = ".$id." and w.research_id = ".$id." and w.worker_id = rer.researcher_id;";
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
                        echo '<th></th>';
						echo '<th></th>';
					echo '</tr>';
				echo '</thead>';
				echo '<tbody>';
				while($row = mysqli_fetch_row($result))
				{
					echo '<tr>';
						echo '<td>';
						echo '<td>' . $row[0] . '</td>';
						echo '<td>' . $row[1] . '</td>';
						
						echo '</td>';
					echo '</tr>';
				}
				echo '</tbody>';
			echo '</table>';
		echo '</div>';
		$sql = "SELECT em.manager_id, first_name, last_name, elidek_address FROM elidek_manager as em, `research` as res where res.research_id = ".$id." and em.manager_id = res.manager_id";
		$result = mysqli_query($conn,$sql);
		if ($result->num_rows > 0)
		{
			echo '<div class="table-responsive">';
				echo '<table class="table">';
					echo '<thead>';
						echo '<tr>';
							echo '<th>ELIDEK Manager</th>';
							echo '<th>First Name</th>';
							echo '<th>Last Name</th>';
							echo '<th>ELIDEK Address</th>';
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
							echo '</td>';
						echo '</tr>';
					}
					echo '</tbody>';
				echo '</table>';
			echo '</div>';
		}
		}
	?>
</body>