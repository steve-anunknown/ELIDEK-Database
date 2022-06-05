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
            <a class="navbar-brand" id="nav-bar-text">Institutions with more than 10 projects in 2 consecutive years page</a>
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
								institute_1.inst_id, 
								institute_1.inst_name, 
								institute_1.acronym, 
								institute_1.researches_per_year, 
								institute_1.year AS year_1, 
								institute_2.year AS year_2 
							FROM 
								institute_help AS institute_1, 
								institute_help AS institute_2 
							WHERE 
								institute_1.inst_id = institute_2.inst_id 
									AND institute_1.researches_per_year = institute_2.researches_per_year 
									AND institute_1.year = institute_2.year - 1 
									AND institute_1.researches_per_year >= 1
							ORDER BY institute_1.researches_per_year , institute_1.inst_id , institute_1.year; "; # researcher_per_year should be 10 not 1
					$result = mysqli_query($conn,$sql);
					if ($result->num_rows > 0)
					{
						echo '<div class="table-responsive">';
							echo '<table class="table">';
								echo '<thead>';
									echo '<tr>';
										echo '<th>Institude ID</th>';
										echo '<th>Institute Name</th>';
										# echo '<th>Acronym</th>'; 
										echo '<th>Researches per year</th>';
										echo '<th>Year 1</th>';
										echo '<th>Year 2</th>';
										echo '<th></th>';
									echo '</tr>';
								echo '</thead>';
								echo '<tbody>';
								while($row = mysqli_fetch_row($result))
								{
									echo '<tr>';
										echo '<td>' . $row[0] . '</td>';
										echo '<td>' . $row[1] . '</td>';
										#echo '<td>' . $row[2] . '</td>';
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