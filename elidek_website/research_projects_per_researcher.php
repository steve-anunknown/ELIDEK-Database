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
		$sql = "SELECT * FROM `researches_per_worker`;";
		$result = mysqli_query($conn,$sql);
		if ($result->num_rows > 0)
		{
		// output data of each row
		//echo "<table>";
		echo '<div class="table-responsive">';
            echo '<table class="table">';
				echo '<thead>';
                    echo '<tr>';
                        echo '<th>Researcher ID</th>';
                        echo '<th>First Name</th>';
                        echo '<th>Last Name</th>';
                        echo '<th>Research ID</th>';
                        echo '<th>Research Title</th>';
					echo '</tr>';
				echo '</thead>';
				echo '<tbody>';
				while($row = mysqli_fetch_row($result))
				{
					echo '<tr>';
					//echo "<tr><td>". htmlspecialchars($row['product_id']) . "</td><td>" . htmlspecialchars($row['title']) . htmlspecialchars($row['budget']) .htmlspecialchars($row['elidek_address']) . "</td></tr>";
					//echo "program ID: " . $row["program_id"]. " - Title: " . $row["title"]. " - Budget: " . $row["budget"]. "€" ." - Elidek Address: " .$row["elidek_address"]. "<br>";
						echo '<td>' . $row[0] . '</td>';
						echo '<td>' . $row[1] . '</td>';
						echo '<td>' . $row[2] . '</td>';
						echo '<td>' . $row[3] . '</td>';
						echo '<td>' . $row[4] . '</td>';
						echo '<td><a href="more_research_info.php?id='.$row[3].'">more info</a></td>';
						echo '<td>';
						echo '</td>';
					echo '</tr>';
				}
				echo '</tbody>';
			echo '</table>';
		echo '</div>';
		}
		//else { echo '<h1 style="margin-top: 5rem;">No Programs found!</h1>' }
		//echo "</table>";
	?>
</body>