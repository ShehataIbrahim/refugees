<%@page pageEncoding="UTF-8" contentType="text/html" isELIgnored="false"%>
<%@ page import="net.hitachifbbot.filter.CSRFFilter" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no, viewport-fit=cover">
<meta name="format-detection" content="telephone=no">
<meta name="robots" content="noindex, nofollow">
<title>Immigration and Refugee Support Portal</title>
<link href="/css/html5-doctor-reset-stylesheet.min.css" rel="stylesheet">
<link href="/css/mobile-style-basic.css" rel="stylesheet">
<script>
var datas = <%= request.getAttribute("answers") %>;

var controlVal = {
  name : datas["1"],
  gender : datas["2"],
  tel : datas["4"],
  from : datas["5"],
  job : datas["6"],
  country : datas["7"],
  address : datas["8"],
  supporter : datas["9"],
  family_count : datas["10"],
  zairyu_card_num : datas["11"],
  zairyu_sikaku : datas["13"],
}

addYMD("birthday", datas["3"]);
addYMD("zairyu_card_limit", datas["12"]);
addYMD("zairyu_manryobi", datas["14"]);

function addYMD(key, val){
  controlVal[key + "1"] = val.substr(0,4);
  controlVal[key + "2"] = val.substr(4,2);
  controlVal[key + "3"] = val.substr(6,2);
}

function setup(){
    var qs = (function(c) { return document.querySelector(c); });

    for (control_id in controlVal){
        var control = qs("#" + control_id);
        if(control){
			control.value = controlVal[control_id];
		}else{
			var chkbox = qs("#" + control_id + "_check" + controlVal[control_id]);
			if(chkbox){ chkbox.checked = true; }
		}
    }
}

window.onload = setup;

</script>
</head>
<body>
<div id="wrapper">
	<div class="header" id="header-bg-basic-info">
		<p>Personal</p>
		<p><a href="javascript:alert('ইলেকট্রনিক মেডিকেল রেকর্ড প্রদর্শিত হবে।')">ইলেক্ট্রনিক মেডিকেল রেকর্ড</a></p>
	</div>

	<div id="basic-informations">
		<form action="" method="post" id="">
			<p class="input-vertical"><label>পুরো নাম</label><input type="text" id="name"></p>
			<div class="input-radio">
				<p>লিঙ্গ</p>
				<ul class="regulation-switch flex-between">
					<li><input type="radio" name="regulation-01" value="" id="gender_check1" checked><label for="man">পুরুষ</label></li>
					<li><input type="radio" name="regulation-01" value="" id="gender_check2"><label for="woman">নারী</label></li>
				</ul>
			</div>
			<div class="input-horizon">
				<p>জন্ম তারিখ</p>
				<ul>
					<li><input type="number" pattern="\d*" id="birthday1"></li>
					<li> / </li>
					<li><input type="number" pattern="\d*" id="birthday2"></li>
					<li> / </li>
					<li><input type="number" pattern="\d*" id="birthday3"></li>
				</ul>
			</div>
			<p class="input-vertical">
				<label>ফোন নম্বর</label><input type="number" pattern="\d*" id="tel"></textarea>
			</p>
			<p class="input-vertical">
				<label>জন্ম</label><textarea rows="1" cols="" id="from"></textarea>
			</p>
			<p class="input-vertical">
				<label>বৃত্তি</label><textarea rows="1" cols="" id="job"></textarea>
			</p>
			<p class="input-vertical">
				<label>জাতীয়তা</label><textarea rows="1" cols="" id="country"></textarea>
			</p>
			<p class="input-vertical">
				<label>বাসস্থানের স্থান</label><textarea rows="1" cols="" id="address"></textarea>
			</p>
			<p class="input-vertical">
            				<label>জামিন</label><textarea rows="1" cols="" id="supporter"></textarea>
            </p>
			<p class="input-vertical"><label>পারিবারিক আকার (ব্যক্তি)</label><input type="number" pattern="\d*" id="family_count"></p>
			<p class="input-vertical"><label>রেসিডেন্স কার্ড · বিশেষ স্থায়ী বসবাসকারী শংসাপত্রের সংখ্যা</label><input type="number" pattern="\d*" id="zairyu_card_num"></p>
			<div class="input-horizon">
				<p>মেয়াদ শেষের তারিখ</p>
				<ul>
					<li><input type="number" pattern="\d*" id="zairyu_card_limit1"></li>
					<li> / </li>
					<li><input type="number" pattern="\d*" id="zairyu_card_limit2"></li>
					<li> / </li>
					<li><input type="number" pattern="\d*" id="zairyu_card_limit3"></li>
				</ul>
			</div>
            <p class="input-vertical">
                <label>বাসস্থান স্থিতি</label><textarea rows="1" cols="" id="zairyu_sikaku"></textarea>
            </p>
			<div class="input-horizon">
				<p>মেয়াদ শেষের তারিখ</p>
				<ul>
					<li><input type="number" pattern="\d*" id="zairyu_manryobi1"></li>
					<li> / </li>
					<li><input type="number" pattern="\d*" id="zairyu_manryobi2"></li>
					<li> / </li>
					<li><input type="number" pattern="\d*" id="zairyu_manryobi3"></li>
				</ul>
			</div>
			<p class="btn-large" style="margin-top:52px"><a href="javascript:void(0)" onclick="alert('ফিক্সড মৌলিক তথ্য।');">সংশোধন</a></p>
		</form>
	</div>
</div>
<!-- SCRIPT -->
<script src="/js/jquery-3.3.1.min.js"></script>
<script src="/js/portal-mobile.ui.js"></script>
</body>
</html>