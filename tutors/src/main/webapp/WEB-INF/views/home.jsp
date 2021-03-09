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
	

.slider img{margin:0 auto;}
</style>
<script type="text/javascript">
$(document).ready(function(){
   $('.slider').bxSlider({
   mode: 'horizontal',
   touchEnabled : (navigator.maxTouchPoints > 0),
   minSlides: 2,
   maxSlides: 3,
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
  <div><p>진행중인 <span>과외</span></p></div>
  <div class="slider">
    <div style="position:absolute;"><p>국어</p>
      <a href='login'><img src="images/korean.png" id="slider" title="국어"></a>
    </div>
    <div style="position:absolute;"><p>수학</p>
      <a href='login'><img src="images/math.jpg" id="slider" title="수학"></a>
    </div>
    <div style="position:absolute;"><p>영어</p>
      <a href='login'><img src="images/english.jpg" id="slider" title="영어"></a>
    
    </div>
    <div style="position:absolute;"><p>사회</p>
      <a href='login'><img src="images/society.jpg" id="slider" title="사회"></a>
    
    </div>
    <div style="position:absolute;"><p>과학</p>
      <a href='login'><img src="images/science.jpg" id="slider" title="과학"></a>
    </div>
  </div>

</body>
</html>
