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
            <a class="navbar-brand" id="nav-bar-text">Databases PHP Elidek - ELIDEK managers that have granted the most money to one corporation page</a>
            <a id="navbar-items" href="/elidek_website/">
                <i class="fa fa-home "></i> Landing
            </a>
        </div>
    </nav>
	<div class="container">
		<div class="row" id="row">
			<div class="form-group col-sm-3 mb-3">
				<?php
					include 'myelidek.php';
					$conn = OpenCon();
					$sql = "SELECT elidek_manager.manager_id , elidek_manager.first_name , elidek_manager.last_name , researches_held_by_corporations_info.inst_id , researches_held_by_corporations_info.inst_name , researches_held_by_corporations_info.Total_budget 
							FROM ( 
							  SELECT Corporation_per_Manager.* , institute.inst_name 
							  FROM Corporation_per_Manager 
							  INNER JOIN institute 
							  ON Corporation_per_Manager.inst_id = institute.inst_id) AS researches_held_by_corporations_info 
							INNER JOIN elidek_manager 
							ON researches_held_by_corporations_info.manager_id = elidek_manager.manager_id 
							ORDER BY researches_held_by_corporations_info.Total_budget , manager_id 
							LIMIT 5; ";
					$result = mysqli_query($conn,$sql);
					if ($result->num_rows > 0)
					{
						echo '<div class="table-responsive">';
							echo '<table class="table">';
								echo '<thead>';
									echo '<tr>';
										echo '<th>Manager ID</th>';
										echo '<th>First Name</th>';
										echo '<th>Last Name</th>';
										echo '<th>Total Budget</th>';
										echo '<th>Institute Name</th>';
										echo '<th>Institute ID</th>';
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
									echo '</tr>';
								}
								echo '</tbody>';
							echo '</table>';
						echo '</div>';
					}
					else
						echo "No data ...";
				?>
			</div>
		</div>
	</div>
</body>