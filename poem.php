<html>
 <head>
  <title>A simple poem</title>
<link rel="stylesheet" type="text/css" href="twinkle-twinkle.css" />
 </head>
 <body>
<div id="poem">
<?php 

$command = escapeshellcmd('ruby ./poem.rb normal');
$output = shell_exec($command);
echo $output;

?>
</div>
 </body>
</html>
