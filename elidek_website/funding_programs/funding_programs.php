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
            <a class="navbar-brand" id="nav-bar-text">Databases PHP Elidek - Funding Programs page</a>
            <a id="navbar-items" href="/elidek_website/">
                <i class="fa fa-home "></i> Landing
            </a>
        </div>
    </nav>
	<div class="container">
		<div class="row" id="row">
			<div class="col-md-12">
				<form class="form-horizontal" name="student-form" method="POST">
					<h3> Enter new funding program </h3>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Funding Program Title</label>
						<input class = "form-control", placeholder="Enter the program's title", name="title">
					</div>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Budget</label>
						<input class = "form-control", placeholder="Enter budget (optional)", name="budget">
					</div>
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Elidek address</label>
						<input class = "form-control", placeholder="Enter elidek address (optional)", name="el_addr">
					</div>
					<button class = "btn btn-primary btn-submit-custom" type="submit" name="submit_creds">Submit</button>
					<button class = "btn btn-primary btn-submit-custom" formaction="../index.php">Back</button>
				</form>
			</div>
			<div class="form-group col-sm-3 mb-3">
				<?php
						include '../myelidek.php';
						$conn = OpenCon();
						if(isset($_POST['submit_creds'])){
						$title = $_POST['title'];
						$budget = $_POST['budget'];
						$el_addr = $_POST['el_addr'];
						$query = "INSERT INTO `funding_program` (title, budget, elidek_address)
								VALUES ('$title', '$budget', '$el_addr')";
						if (mysqli_query($conn, $query)) {
							//echo "New record created successfully";
							header("Location: ./funding_programs.php");
							exit();
						}
						else{
							echo "Error while creating record: <br>" . mysqli_error($conn) . "<br>";
						}
					}
					
				?>
			</div>
		</div>
    </div>
	<?php

		$sql = "SELECT * FROM `funding_program`;";
		$result = mysqli_query($conn,$sql);
		if ($result->num_rows > 0)
		{
		// output data of each row
		//echo "<table>";
		echo '<div class="table-responsive">';
            echo '<table class="table">';
				echo '<thead>';
                    echo '<tr>';
                        echo '<th>Program ID</th>';
                        echo '<th>Title</th>';
                        echo '<th>Budget</th>';
                        echo '<th>ELIDEK ADDRESS</th>';
                        echo '<th></th>';
						echo '<th></th>';
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
						echo '<td>' . $row[2] ."€". '</td>';
						echo '<td>' . $row[3] . '</td>';
						echo '<td>';
							echo '<a type="button" href="./update_funding_program.php?id=' . $row[0]. '">';
								echo '<i class="fa fa-edit"></i>';
							echo '</a>';
						echo '</td>';
						echo '<td>';
							echo '<a type="button" href="./delete_funding_program.php?id=' . $row[0]. '">';
								echo '<i class = "fa fa-trash"></i>';
							echo '</a>';
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