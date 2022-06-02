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
			<a class="navbar-brand" id="nav-bar-text">Databases ELIDEK - Landing Page</a>
			<a id="navbar-items" href="/elidek_website/">
				<i class="fa fa-home "></i> Landing
			</a>
		</div>
	</nav>
	<div class="container" id="row-container">
        <div class="row" id="row">
			<div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">Funding Programs</h4>
                        <p class="card-text" id="paragraph">View all available funding programs<br></p>
                        <a class="btn btn-primary" id="show-btn" href="/elidek_website/funding_programs.php">Show</a>
                    </div>
                </div>
            </div>
			<div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">Research Projects</h4>
                        <p class="card-text" id="paragraph">View all available research projects<br></p>
                        <a class="btn btn-primary" id="show-btn" href="/elidek_website/research_projects.php">Show</a>
                    </div>
                </div>
            </div>
			<div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">Scientific Fields</h4>
                        <p class="card-text" id="paragraph">View all available scientific fields and related projects and researchers<br></p>
                        <a class="btn btn-primary" id="show-btn" href="/elidek_website/scientific_fields.php">Show</a>
                    </div>
                </div>
            </div>
			<div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">Institutions</h4>
                        <p class="card-text" id="paragraph">View all available institutions</p>
                        <a class="btn btn-primary" id="show-btn" href="/elidek_website/institutions.php">Show</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">Projects per Researcher</h4>
                        <p class="card-text" id="paragraph">View all researchers and the projects in which they participate</p>
                        <a class="btn btn-primary" id="show-btn" href="/elidek_website/research_projects_per_researcher.php">Show</a>
                    </div>
                </div>
            </div>
            
        </div>
</body>


</html>
