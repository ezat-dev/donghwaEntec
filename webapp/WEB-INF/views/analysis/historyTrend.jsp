<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>History Trend</title>

<link rel="shortcut icon" href="resources/image/KPF.jpg" type="image/x-icon" />
<%@ include file="../include/mainHeader.jsp" %>

<!-- Font Awesome 포함 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<!-- 하이차트 라이브러리 포함 -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<style>
/* HTML과 body의 높이를 100%로 설정 */
html, body {
    height: 100%;
    margin: 0; /* 기본 마진 제거 */
    font-family: Arial, sans-serif;
}

/* Flexbox 레이아웃 설정 */
.container {
    display: flex;
    height: 100%; /* 부모 요소의 높이를 100%로 설정 */
    padding: 30px; /* 좌우 여백 추가 */
}

/* 왼쪽 4칸 영역 */
.left {
    flex: 3;
    background-color: #f8f9fa; /* 밝은 회색 배경색 */
    border-right: 1px solid #ddd; /* 오른쪽 경계선 추가 */
    box-sizing: border-box;
    display: flex;
    flex-direction: column; /* 자식 요소를 수직으로 배치 */
    align-items: flex-start; /* 왼쪽 정렬 */
}

/* 제목 스타일 */
.left h2 {
    margin-top: 0;
    margin-bottom: 20px;
    color: #333;
    font-size: 18px;
}

/* Pen Group 제어 스타일 */
.pen-group-controls {
    display: flex; /* Flexbox를 사용하여 요소를 한 줄에 배치 */
    align-items: center; /* 세로 정렬을 중앙에 맞춤 */
    margin-bottom: 20px; /* 제목과의 간격 */
    
}

/* 드롭다운과 버튼들 스타일 */
.pen-group-controls select {
    margin-right: 10px; /* 드롭다운과 버튼 사이 간격 */
    padding: 8px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: #fff;

}

.pen-group-controls button {
    margin-right: 10px; /* 버튼 간격 */
    height: 40px; /* 버튼 높이 */
    background-color: white;
    color: black;
    border: 1px solid black;
    border-radius: 4px; /* 둥근 모서리 */
    cursor: pointer;
    transition: background-color 0.3s;
    font-size: 14px; /* 버튼 글씨 크기 */
}

.pen-group-controls button:hover {
    background-color: #f0f0f0;
}

.pen-group-controls button i {
    margin-right: 5px; /* 아이콘과 텍스트 사이 간격 */
}

/* 팬 설정 스타일 */
.pen-settings {
    display: flex;
    flex-direction: column;
    width: 100%;
}

.pen-settings label {
    margin-bottom: 5px;
    font-weight: bold;
    color: #555;
}

.pen-settings input[type="text"],
.pen-settings select,
.pen-settings input[type="color"],
.pen-settings button {
    margin-bottom: 15px;
    padding: 8px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}
#pen-group{
	width: 150px;
}

.pen-settings select {
    height: 380px;
}

.pen-settings input[type="color"],
.pen-settings button {
    width: 530px; 
    height: 40px; 
}

.pen-settings button {
    background-color: white;
    color: black;
    border: 1px solid black;
    cursor: pointer;
    transition: background-color 0.3s;
}

.pen-settings button:hover {
    background-color: #f0f0f0;
}

/* 오른쪽 6칸 영역 */
.right {
    flex: 7;
    background-color: lightblue; /* 배경색은 예시입니다. 필요에 따라 제거 또는 변경하세요 */
    padding: 10px;
    position: relative;
    display: flex;
    align-items: center; /* 수직 가운데 정렬 */
}

/* 차트 컨테이너를 오른쪽 정가운데에 배치 */
#container {
    width: 90%; /* 차트의 너비를 90%로 설정하여 줄였습니다 */
    height: 50%;
    margin: 0 auto; /* 차트를 중앙에 배치 */
}
</style>

</head>
<body>
<div class="container">
    <div class="left">
        <div class="pen-group-controls">
            <label for="pen-group">Pen Group:</label>
            <select id="pen-group">
                <!-- 드롭다운 리스트 옵션들 -->
            </select>
            <button type="button" id="load-button">
                <i class="fas fa-save"></i> Load Pen Group
            </button>
            <button type="button" id="delete-button">
                <i class="fas fa-trash"></i> Delete Pen Group
            </button>
        </div>
        
        <div class="pen-settings">
            <h2>Pen Groups Settings</h2>
            
            <label for="pen-search">Search Pen:</label>
            <input type="text" id="pen-search" placeholder="Search Pen...">

            <label for="pen-list">Pen List:</label>
            <select id="pen-list" multiple>
                <!-- AJAX를 통해 팬 목록을 동적으로 추가할 것입니다. -->
            </select>

            <label for="pen-color">Color:</label>
            <input type="color" id="pen-color" value="#ff0000">

            <button type="button" id="add-button">Add</button>
        </div>
    </div>
    <div class="right">
        <div id="container"></div>
    </div>
</div>
</body>


<script>
$(document).ready(function() {
    var chart; // 차트를 전역 변수로 선언
    var penData = []; // 팬 데이터 저장용 배열
    var penGroupData = []; // 펜 그룹 데이터 저장용 배열

    // 팬 목록을 가져오는 AJAX 요청
    $.ajax({
        url: '/donghwa/analysis/historyTrend/getPenList', // URL을 현재 코드에 맞게 조정
        method: 'GET',
        dataType: 'json',
        success: function(data) {
            console.log('Pen Data received:', data);
            var penList = $('#pen-list');
            penList.empty();

            if (Array.isArray(data)) {
                penData = data; // 전역 변수에 데이터 저장

                $.each(data, function(index, record) {
                    // 펜의 ID와 penName을 드롭다운 항목에 표시
                    penList.append(
                        $('<option></option>')
                            .val(record.id)
                            .text('NO: ' + record.id + ', PenName: ' + (record.penName || 'Unknown'))
                    );
                });

                // 팬 목록에서 팬을 선택하면 차트 데이터 업데이트
                penList.change(function() {
                    var selectedPenId = $(this).val();
                    var selectedPen = penData.find(pen => pen.id == selectedPenId);

                    if (selectedPen) {
                        // 차트 데이터 업데이트
                        updateChart(selectedPen);
                    } else {
                        console.error('Selected pen not found in penData:', selectedPenId);
                    }
                });
            } else {
                console.error('Data is not an array:', data);
            }
        },
        error: function(xhr, status, error) {
            console.error('Error fetching pen list:', status, error);
        }
    });

  

    // 차트를 초기화하는 함수
    function initializeChart() {
        chart = Highcharts.chart('container', {
            chart: {
                type: 'line'
            },
            title: {
                text: 'Monthly Data'
            },
            subtitle: {
                text: 'Source: DataSource'
            },
            xAxis: {
                categories: Array.from({ length: 30 }, (_, i) => `Item ${i + 1}`) // 1부터 30까지의 항목 생성
            },
            yAxis: {
                title: {
                    text: 'Value'
                }
            },
            tooltip: {
                enabled: true,
                shared: true,
                crosshairs: true
            },
            legend: {
                layout: 'horizontal',
                align: 'center',
                verticalAlign: 'bottom'
            },
            plotOptions: {
                line: {
                    dataLabels: {
                        enabled: true
                    },
                    enableMouseTracking: true
                }
            },
            series: [{
                name: 'Data Series',
                data: [] // 초기 데이터는 비어 있음
            }],
            responsive: {
                rules: [{
                    condition: {
                        maxWidth: 500
                    },
                    chartOptions: {
                        legend: {
                            layout: 'horizontal',
                            align: 'center',
                            verticalAlign: 'bottom'
                        }
                    }
                }]
            },
            exporting: {
                enabled: true
            }
        });
    }

    // 차트 데이터를 업데이트하는 함수
    function updateChart(pen) {
        // 팬 데이터 변환 및 차트 데이터 업데이트
        var data = [
            parseFloat(pen.c1 || 0), parseFloat(pen.c2 || 0), parseFloat(pen.c3 || 0), parseFloat(pen.c4 || 0), parseFloat(pen.c5 || 0),
            parseFloat(pen.c6 || 0), parseFloat(pen.c7 || 0), parseFloat(pen.c8 || 0), parseFloat(pen.c9 || 0), parseFloat(pen.c10 || 0),
            parseFloat(pen.c11 || 0), parseFloat(pen.c12 || 0), parseFloat(pen.c13 || 0), parseFloat(pen.c14 || 0), parseFloat(pen.c15 || 0),
            parseFloat(pen.c16 || 0), parseFloat(pen.c17 || 0), parseFloat(pen.c18 || 0), parseFloat(pen.c19 || 0), parseFloat(pen.c20 || 0),
            parseFloat(pen.c21 || 0), parseFloat(pen.c22 || 0), parseFloat(pen.c23 || 0), parseFloat(pen.c24 || 0), parseFloat(pen.c25 || 0),
            parseFloat(pen.c26 || 0), parseFloat(pen.c27 || 0), parseFloat(pen.c28 || 0), parseFloat(pen.c29 || 0), parseFloat(pen.c30 || 0)
        ]; // 팬의 데이터 (30개 항목)

        // 차트 데이터 업데이트
        if (chart) {
            chart.series[0].setData(data, true); // 기존 데이터에 새로운 데이터를 설정
        }
    }

    // 페이지가 로드될 때 차트 초기화
    initializeChart();
});

</script>



</html>
