````
JavaScript
内部使用：
<script type="text/javascript"></script>
外部导入：
<script src="test.js" type="text/javascript"></script>
<body>
<div id="wrap"></div>
<script type="text/javascript">
(function(){
// document.write("Abcdldjieuds");
var box = document.getElementById("wrap");
var temp = document.createElement("p");
temp.innerHTML = "nihoa";
box.appendChild(temp);
})();
</script>
````

