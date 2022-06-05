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
                        <a class="btn btn-primary" id="show-btn" href="/elidek_website/funding_programs/funding_programs.php">Show</a>
                    </div>
                </div>
            </div>
			<div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">Research Projects</h4>
                        <p class="card-text" id="paragraph">View all available research projects<br></p>
                        <a class="btn btn-primary" id="show-btn" href="/elidek_website/research_projects/research_projects.php">Show</a>
                    </div>
                </div>
            </div>
			<div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">Scientific Fields</h4>
                        <p class="card-text" id="paragraph">View all available scientific fields and related projects and researchers<br></p>
                        <a class="btn btn-primary" id="show-btn" href="/elidek_website/scientific_fields/scientific_fields.php">Show</a>
                    </div>
                </div>
            </div>
			<div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">Institutions</h4>
                        <p class="card-text" id="paragraph">View all available institutions</p>
                        <a class="btn btn-primary" id="show-btn" href="/elidek_website/institutions/institutions.php">Show</a>
                    </div>
                </div>
            </div>
			<div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">Researchers</h4>
                        <p class="card-text" id="paragraph">View all available researchers</p>
                        <a class="btn btn-primary" id="show-btn" href="/elidek_website/researchers/researchers.php">Show</a>
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
			<div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">Institutions with more than 10 projects in 2 consecutive years</h4>
                        <p class="card-text" id="paragraph">View</p>
                        <a class="btn btn-primary" id="show-btn" href="/elidek_website/institutionsconsyears.php">Show</a>
                    </div>
                </div>
            </div>
			<div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">Top 5 science field pairs that have shared the biggest funds</h4>
                        <p class="card-text" id="paragraph">View the top 5 science field pairs</p>
                        <a class="btn btn-primary" id="show-btn" href="/elidek_website/top5fieldpairs.php">Show</a>
                    </div>
                </div>
            </div>
			<div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">Young researchers below 40 that work on the most projects and amount of projects</h4>
                        <p class="card-text" id="paragraph">View the most active young researchers</p>
                        <a class="btn btn-primary" id="show-btn" href="/elidek_website/youngresearchers.php">Show</a>
                    </div>
                </div>
            </div>
			<div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">ELIDEK managers that have granted the most money to one corporation</h4>
                        <p class="card-text" id="paragraph">View</p>
                        <a class="btn btn-primary" id="show-btn" href="/elidek_website/elidekmanagersquery.php">Show</a>
                    </div>
                </div>
            </div>
			<div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">Researchers that work on more than 5 projects that have no reports</h4>
                        <p class="card-text" id="paragraph">View</p>
                        <a class="btn btn-primary" id="show-btn" href="/elidek_website/noreportsresearchers.php">Show</a>
                    </div>
                </div>
            </div>
        </div>
</body>


</html>
