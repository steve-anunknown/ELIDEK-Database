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
            <a class="navbar-brand" id="nav-bar-text">Databases ELIDEK Demo - Delete Science Field Page</a>
            <a id="navbar-items" href="/elidek_website/">
                <i class="fa fa-home "></i> Landing
            </a>
        </div>
    </nav>

    <div class="container">
    <div class="row" id="row">
        <div class="col-md-12">
            <form class="form-horizontal" name="student-form" method="POST">
                <div class="form-group col-sm-3 mb-3">
                <?php
                    include 'myelidek.php';
                    $conn = OpenCon();
                    $id = $_GET['id'];
                    $query = "SELECT * FROM science_field WHERE field_id = $id";
                    $res1 = mysqli_query($conn, $query);
                    $row = mysqli_fetch_row($res1);
                    echo '<div class="form-group col-sm-3 mb-3">';
                        echo '<label class = "form-label" style="width: 300px;">Are you sure you want to delete field <br><b>' . $row[0] . ' ' . $row[1] .'?</b></label>';
						echo '<label class = "form-label" style="width: 300px;">(Note: This action will also delete projects associated with this field)</label>';
					echo '</div>';
                    if(isset($_POST['submit_del'])){
                        $query = "DELETE FROM science_field
                                WHERE field_id = $id";
                        if (mysqli_query($conn, $query)) {
                            //echo "Record updated successfully";
                            header("Location: ./scientific_fields.php");
                            exit();
                        }
                        else{
                            echo "Error while deleting record: <br>" . mysqli_error($conn) . "<br>";
                        }
                    }
                ?>
                </div>
                <button class = "btn btn-primary btn-submit-custom" type = "submit" name="submit_del">Delete</button>
                <button class = "btn btn-primary btn-submit-custom" formaction="scientific_fields.php">Back</button>
			</form>
		</div>
    </div>
</div>

</body>
