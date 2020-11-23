<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MarksSheetCalculator.aspx.cs" Inherits="UBIT.IPT.SERVER.MarksSheetCalculator" %>

<html>

<head>
    <title>Markssheet</title>
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        .customButton {
            border: 1px solid gray;
            padding: 2px 6px 2px 6px;
            cursor: pointer;
        }

        .customButton:hover {
            border: 1px solid black;
            box-shadow: gray 2px 2px 5px;
        }
    </style>
</head>

<body>
    <div class="jumbotron text-center bg-dark text-white">
      <h1>Marks Sheet Calculator</h1>
      <p>Enter Subject Marks along with Subject Names to Calculate!</p> 
     </div>
    <div class="container-fluid ">
        <p class="h1">Marksheet</p>
        <table>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>
                                <span>Enter the name of student :</span>
                            </td>
                            <td>
                                <input type="text" id="nameOfStudent" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>Enter the number of subjects : </span>
                            </td>
                            <td>
                                <input type="number" id="noOfSubjects" min="1" onchange="UIPopulate()"
                                    onkeyup="UIPopulate()" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <span onclick="Calculate()" class="customButton">Calculate</span>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <span>Min Marks Subject: </span>
                            </td>
                            <td>
                                <input type="text" id="minMarksSubject" readonly="readonly" />
                            </td>
                            <td>
                                <span>Min Marks: </span>
                            </td>
                            <td>
                                <input type="text" id="minMarks" readonly="readonly" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>Max Marks Subject: </span>
                            </td>
                            <td>
                                <input type="text" id="maxMarksSubject" readonly="readonly" />
                            </td>
                            <td>
                                <span>Max Marks: </span>
                            </td>
                            <td>
                                <input type="text" id="maxMarks" readonly="readonly" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>Percentage : </span>
                            </td>
                            <td>
                                <input type="text" id="percentage" readonly="readonly" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <hr />
    <div>
        <table id="inputTable">
        </table>
    </div>
</body>
<script>

    function Calculate() {
        //YOUR CODE GOES HERE
        var noOfSubjects = $('#noOfSubjects').val();
        var marksList = [];
        for (i = 0; i < noOfSubjects; i++) {
            var subjectName = $('#subjectName' + i).val();
            var subjectMarksObtained = $('#subjectMarksObtained' + i).val();

            var marks = new Object();
            marks.subjectName = subjectName;
            marks.subjectMarksObtained = subjectMarksObtained;
            marksList.push(marks);
            console.log(marksList);
        }

        var marksListStr = JSON.stringify(marksList);
        console.log(marksListStr);

        $.ajax({

            type: "GET",
            url: "MarksSheetCalculator.aspx/GetMarksSheet",
            contentType: "application/JSON",
            data: { "request": marksListStr, },
            success: function (result) {
                console.log(result);

                PopulateResult(result.d);
            }

        });

    }

    function PopulateResult(resultStr) {
        var result = JSON.parse(resultStr);
        console.log(result);

        $('#minMarksSubject').val(result.minMarksSubject);
        $('#minMarks').val(result.minMarks);
        $('#maxMarksSubject').val(result.maxMarksSubject);
        $('#maxMarks').val(result.maxMarks);
        $('#percentage').val(result.average);
    }

    function UIPopulate() {
        var noOfSubjects = $('#noOfSubjects').val();

        var h = '';
        for (i = 0; i < noOfSubjects; i++) {
            h += '<tr>';

            h += '<td>';
            h += '<span>Subject ' + (i + 1) + ' -> </span>';
            h += '</td>';

            h += '<td>';
            h += '<span>Name :</span>';
            h += '</td>';

            h += '<td>';
            h += '<input type="text" id="subjectName' + i + '"/>';
            h += '</td>';

            h += '<td>';
            h += '<span>Marks Obtained :</span>';
            h += '</td>';

            h += '<td>';
            h += '<input type="number" min="0" max="100" id="subjectMarksObtained' + i + '"/>';
            h += '</td>';

            h += '</tr>';
        }

        $('#inputTable').html(h);
    }
</script>
</html>