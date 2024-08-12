<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>동화엔텍</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>  
  <style>
    .header {
      background: #123478;
      width: 100%; 
      height: 50px;
      position: relative;
    }

    .hamburger-icon {
      width: 33px;
      height: 27.19px;
      position: absolute;
      left: 13px;
      top: 10px;
      cursor: pointer; 
      z-index: 3;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }

    .hamburger-icon div {
      width: 100%;
      height: 4px;
      background-color: white;
      border-radius: 2px;
    }

    .menu {
      width: 230px;
      height: 100%;
      background: #123478;
      position: fixed;
      left: -350px;
      transition: left 0.3s ease;
      padding: 20px; 
      color: white;
      z-index: 1;
    }
  
    .menu.active {
      left: 0;
    }

    .submenu {
      max-height: 0;
      overflow: hidden;
      transition: max-height 0.3s ease;
      padding-left: 20px;
    }
  
    .submenu.active {
      max-height: 100px;
    }

    .menu > ul {
      list-style-type: none;
      padding: 0;
      margin: 0;
    }

    .menu > ul > li {
      margin-top: 30px;
      cursor: pointer;
      padding: 5px 0;
      font-size: 16px;
    }

    .submenu.active {
      max-height: 200px;
    }
  
    .submenu li {
      padding: 5px 0;
      white-space: nowrap;
    }
  </style>
</head>
<body>
  <div class="header">
    <div class="hamburger-icon">
      <div></div>
      <div></div>
      <div></div>
    </div>
  </div>

  <div class="menu" id="hamburgerMenu">
    <ul>
      <li>
        Furnace
        <ul class="submenu">
          <li>Overview</li>
          <li>Manual Operation</li>
          <li>Operation Press</li>
          <li>Automatic program</li>
          <li onclick="menuClick('/donghwa/furnace/recipe');">Recipe</li>
        </ul>
      </li>
      <li>
        Process values
        <ul class="submenu">
          <li>Temperature</li>
          <li>Pressure</li>
          <li>Pressure switches</li>
          <li>Heater</li>
          <li>Press</li>
          <li>Power Consumption</li>
        </ul>
      </li>
      <li>
        Analysis
        <ul class="submenu">
          <li onclick="menuClick('/donghwa/analysis/historyTrend');">Historytrends</li>
          <li>Batchreport</li>
          <li>Alarmhistory</li>
        </ul>
      </li>
      <li>
        Parameter
        <ul class="submenu">
          <li>Limit switches</li>
          <li>Fastcooling</li>
          <li>Timer</li>
          <li>Calibrate TC measuring syst</li>
        </ul>
      </li>
      <li>
        Documentation
        <ul class="submenu">
          <li>Functions</li>
          <li>Commissioning</li>
          <li>General operation</li>
          <li>Faults</li>
          <li>Circuit Diagram</li>
          <li>Reference list history trends</li>
        </ul>
      </li>
    </ul>
  </div>

  <script>
    const hamburgerIcon = document.querySelector('.hamburger-icon');
    const menu = document.getElementById('hamburgerMenu');

    hamburgerIcon.addEventListener('click', () => {
      menu.classList.toggle('active');
    });

    const menuItems = document.querySelectorAll('.menu > ul > li');

    menuItems.forEach(item => {
      item.addEventListener('click', (event) => {
        menuItems.forEach(otherItem => {
          if (otherItem !== item) {
            const submenu = otherItem.querySelector('.submenu');
            if (submenu) {
              submenu.classList.remove('active');
              submenu.style.maxHeight = null;
            }
          }
        });

        const submenu = item.querySelector('.submenu');
        if (submenu) {
          submenu.classList.toggle('active');
          if (submenu.classList.contains('active')) {
            submenu.style.maxHeight = submenu.scrollHeight + "px";
          } else {
            submenu.style.maxHeight = null;
          }
        }

        event.stopPropagation();
      });
    });

    const historyTrendsItem = document.getElementById('historytrends');
    if (historyTrendsItem) {
      historyTrendsItem.addEventListener('click', () => {
        window.location.href = 'RecipeTrend';
      });
    }
    
    //함수
    function menuClick(url){
    	location.href = url;
    }
    
  </script>
</body>
</html>