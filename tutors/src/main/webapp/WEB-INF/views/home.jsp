<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
<style type="text/css">
body{
	background-color: rgba(230, 238, 249);
}
.slider img{margin:0 auto; background-color: rgba(230, 238, 249);}
#slider {
	border-radius: 10px;
	padding: 10px;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
   $('.slider').bxSlider({
   mode: 'horizontal',
   touchEnabled : (navigator.maxTouchPoints > 0),
   minSlides: 2,
   maxSlides: 3,
   auto: true,
   speed: 1000,
   moveSlides: 1,
   autoHover: true,
   slideWidth: 620,
   slideMargin: 20
   });
 });

</script>
<html>
<head>

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
</head>
<body>
  <div><img src="images/mainn.png" width="70%"></div>
  <br><br>
  <div><p style="font-size: 2rem; font-weight: bold;">진행중인 과외</p></div>
  <div class="slider">
    <div style="position:absolute;"><h3>국어</h3>
      <a href="list.match?subject=국어"><img src="images/korean.png" id="slider" title="국어"></a>
    </div>
    <div style="position:absolute;"><h3>수학</h3>
      <a href='list.match?subject=수학'><img src="images/math.jpg" id="slider" title="수학"></a>
    </div>
    <div style="position:absolute;"><h3>영어</h3>
      <a href='list.match?subject=영어'><img src="images/english.jpg" id="slider" title="영어"></a>
    
    </div>
    <div style="position:absolute;"><h3>사회</h3>
      <a href='list.match?subject=사회'><img src="images/society.jpg" id="slider" title="사회"></a>
    
    </div>
    <div style="position:absolute;"><h3>과학</h3>
      <a href='list.match?subject=과학'><img src="images/science.jpg" id="slider" title="과학"></a>
    </div>
  </div>

</body>
</html>
