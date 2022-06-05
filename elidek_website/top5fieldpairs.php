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
            <a class="navbar-brand" id="nav-bar-text">Databases PHP Elidek - Top 5 science field pairs that have shared the biggest funds page</a>
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
								COUNT(research_id) AS Total_Researches,
								field_1_title AS Field_1,
								field_2_title AS Field_2
							FROM
								(SELECT 
									field_1.research_id,
										field_1.field_id AS field_1_id,
										field_2.field_id AS field_2_id,
										field_1.title AS field_1_title,
										field_2.title AS field_2_title
								FROM
									field_data AS field_1, field_data AS field_2
								WHERE
									field_1.research_id = field_2.research_id
										AND field_1.field_id < field_2.field_id) AS pair_of_fields
							GROUP BY field_1_title , field_2_title
							ORDER BY COUNT(research_id) DESC , field_1_title , field_2_title
							LIMIT 3;";
					$result = mysqli_query($conn,$sql);
					if ($result->num_rows > 0)
					{
						echo '<div class="table-responsive">';
							echo '<table class="table">';
								echo '<thead>';
									echo '<tr>';
										echo '<th>Number of Researches</th>';
										echo '<th>Field 1</th>';
										echo '<th>Field 2</th>';
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
						echo "No data ...";
				?>
			</div>
		</div>
	</div>
</body>