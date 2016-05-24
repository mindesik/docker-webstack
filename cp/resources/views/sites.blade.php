<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Sites Manager</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="/css/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/flat-ui.min.css" rel="stylesheet">
    
    <link rel="shortcut icon" href="img/favicon.ico">
    
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
    <!--[if lt IE 9]>
    <script src="js/vendor/html5shiv.js"></script>
    <script src="js/vendor/respond.min.js"></script>
    <![endif]-->
</head>

<body>
    <div class="container">
        <h3>Sites Manager</h3>
        <div class="row">
            <div class="col-sm-4">
                <h4>Add site</h4>
                <p id="error" class="text-danger small"></p>
                <form id="add" action="/" method="POST">
                    <div class="form-group">
                        <input name="domain" type="text" value="domain.dev" placeholder="domain.dev" class="form-control input-sm">
                    </div>
                    <div class="form-group">
                        <input name="path" type="text" placeholder="/var/www/" value="/var/www/" class="form-control input-sm">
                    </div>
                    <input class="btn btn-wide btn-success btn-sm" type="submit" value="Add" />
                </form>
            </div>
            <div class="col-sm-8">
                <h4>Sites list</h4>
                <ul id="sites">
                    @foreach ($sites as $site)
                        @if (basename($site) != 'default')
                            <li>{{ basename($site) }} — <button class="btn btn-xs btn-danger" data-domain="{{ basename($site) }}">Delete</button></li>
                        @endif
                    @endforeach
                </ul>
            </div>
        </div>
    </div>
    <!-- /.container -->
    
    
    <script src="/js/vendor/jquery.min.js"></script>
    <script src="/js/flat-ui.min.js"></script>
    <script src="/js/app.js"></script>
</body>

</html>