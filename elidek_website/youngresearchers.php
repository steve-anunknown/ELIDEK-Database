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
            <a class="navbar-brand" id="nav-bar-text">Databases PHP Elidek - Most active young scientists page</a>
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
					$sql = "SELECT 
								Active_researches, researcher.*
							FROM
								researcher
									INNER JOIN
								(SELECT 
									research_worker.worker_id,
										COUNT(research_worker.research_id) AS Active_researches
								FROM
									research_worker
								INNER JOIN active_research ON research_worker.research_id = active_research.research_id
								GROUP BY research_worker.worker_id) AS researcher_projects ON researcher_projects.worker_id = researcher.researcher_id
							WHERE
								researcher.age < 40
							ORDER BY Active_researches DESC , researcher_id; ";
					$result = mysqli_query($conn,$sql);
					if ($result->num_rows > 0)
					{
						echo '<div class="table-responsive">';
							echo '<table class="table">';
								echo '<thead>';
									echo '<tr>';
										echo '<th>Active Researches</th>';
										echo '<th>Researcher ID</th>';
										echo '<th>First Name</th>';
										echo '<th>Last Name</th>';
										echo '<th>Gender</th>';
										echo '<th>Birthday</th>';
										echo '<th>Age</th>';
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