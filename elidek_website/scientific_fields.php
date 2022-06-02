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
            <a class="navbar-brand" id="nav-bar-text">Databases PHP Demo - Science Field Page</a>
            <a id="navbar-items" href="/elidek/">
                <i class="fa fa-home "></i> Landing
            </a>
        </div>
    </nav>
	<div class="container">
		<div class="row" id="row">
			<div class="col-md-12">
				<h3>Add new Scientific Field</h3>
				<form class="form-horizontal" name="student-form" method="POST">
					<div class="form-group col-sm-3 mb-3">
						<label class = "form-label">Title</label>
						<input class = "form-control", placeholder="Enter title", name="title">
					</div>
					<button class = "btn btn-primary btn-submit-custom" type="submit" name="submit_creds">Submit</button>
					<button class = "btn btn-primary btn-submit-custom" formaction="index.php">Back</button>
				</form>
			</div>
			<div class="form-group col-sm-3 mb-3">
				<?php
					include 'myelidek.php';
					$conn = OpenCon();
					if(isset($_POST['submit_creds'])){
						$title = $_POST['title'];
						$query = "INSERT INTO science_field (title)
								VALUES ('$title')";
						$flag = true;
						try{ mysqli_query($conn, $query);}
						catch(Exception $e){
							$flag = false;
							echo "Error while creating record: <br>" . mysqli_error($conn) . "<br>";
						}
						if($flag){
							//echo "New record created successfully";
							header("Location: ./scientific_fields.php");
							exit();
						}
					}
				?>
			</div>
		</div>
	</div>
	<?php
		$query = "SELECT * FROM `science_field`;";
		$result = mysqli_query($conn,$query);
		if ($result->num_rows > 0)
		{
			echo '<div class="table-responsive">';
				echo '<table class="table">';
					echo '<thead>';
						echo '<tr>';
							echo '<th>Field ID</th>';
							echo '<th>Title</th>';
						echo '</tr>';
					echo '</thead>';
					echo '<tbody>';
					while($row = mysqli_fetch_row($result))
					{
						echo '<tr>';
							echo '<td>' . $row[0] . '</td>';
							echo '<td>' . $row[1] . '</td>';
							echo '<td><a href="more_field_info.php?id='.$row[0].'">project and researcher info</a></td>';
							echo '<td>';
							echo '<a type="button" href="./update_science_field.php?id=' . $row[0]. '">';
								echo '<i class="fa fa-edit"></i>';
							echo '</a>';
							echo '</td>';
							echo '<td>';
								echo '<a type="button" href="./delete_science_field.php?id=' . $row[0]. '">';
									echo '<i class = "fa fa-trash"></i>';
								echo '</a>';
							echo '</td>';
							echo '</tr>';
						echo '</tr>';
					}
					echo '</tbody>';
				echo '</table>';
			echo '</div>';
		}
		else
		{
			echo "No data ...";
		}
	?>
</body>