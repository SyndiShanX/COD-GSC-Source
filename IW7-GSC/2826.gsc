/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2826.gsc
***************************************/

main() {
  if(!isDefined(level.func_ABE6)) {
    level.func_ABE6 = 0;
  }

  level.func_4BC4 = "default";
  level.func_11A9 = 0;
  func_5843();
  func_11715();
  level.func_1094B = [];
  level.func_32F7 = [];
  _setsaveddvar("r_umbraMinObjectContribution", 8);
  _setsaveddvar("r_umbraShadowcasters", 1);
  _setsaveddvar("r_usePrebuiltSunShadow", 3);
  _setsaveddvar("r_mbEnable", 1);
  _setsaveddvar("r_mbVelocityScale", 0);
  _setsaveddvar("r_mbVelocityScaleViewModel", 0.2);

  if(!isDefined(level.func_11220)) {
    level.func_11220 = [];
  }

  if(!isDefined(level.script)) {
    level.script = tolower(getdvar("mapname"));
  }
}

func_5849(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  level.func_5832[var_00][var_01]["nearStart"] = var_02;
  level.func_5832[var_00][var_01]["nearEnd"] = var_03;
  level.func_5832[var_00][var_01]["nearBlur"] = var_04;
  level.func_5832[var_00][var_01]["farStart"] = var_05;
  level.func_5832[var_00][var_01]["farEnd"] = var_06;
  level.func_5832[var_00][var_01]["farBlur"] = var_07;
  level.func_5832[var_00][var_01]["weight"] = var_08;
}

func_5838(var_00) {
  if(level.func_5832[var_00]["timeRemaining"] <= 0.0) {
    return;
  }
  var_01 = min(1.0, 0.05 / level.func_5832[var_00]["timeRemaining"]);
  level.func_5832[var_00]["timeRemaining"] = level.func_5832[var_00]["timeRemaining"] - 0.05;

  if(level.func_5832[var_00]["timeRemaining"] <= 0.0) {
    level.func_5832[var_00]["timeRemaining"] = 0.0;
    level.func_5832[var_00]["current"]["nearStart"] = level.func_5832[var_00]["goal"]["nearStart"];
    level.func_5832[var_00]["current"]["nearEnd"] = level.func_5832[var_00]["goal"]["nearEnd"];
    level.func_5832[var_00]["current"]["nearBlur"] = level.func_5832[var_00]["goal"]["nearBlur"];
    level.func_5832[var_00]["current"]["farStart"] = level.func_5832[var_00]["goal"]["farStart"];
    level.func_5832[var_00]["current"]["farEnd"] = level.func_5832[var_00]["goal"]["farEnd"];
    level.func_5832[var_00]["current"]["farBlur"] = level.func_5832[var_00]["goal"]["farBlur"];
    level.func_5832[var_00]["current"]["weight"] = level.func_5832[var_00]["goal"]["weight"];
    return;
  }

  level.func_5832[var_00]["current"]["nearStart"] = level.func_5832[var_00]["current"]["nearStart"] + var_01 * (level.func_5832[var_00]["goal"]["nearStart"] - level.func_5832[var_00]["current"]["nearStart"]);
  level.func_5832[var_00]["current"]["nearEnd"] = level.func_5832[var_00]["current"]["nearEnd"] + var_01 * (level.func_5832[var_00]["goal"]["nearEnd"] - level.func_5832[var_00]["current"]["nearEnd"]);
  level.func_5832[var_00]["current"]["nearBlur"] = level.func_5832[var_00]["current"]["nearBlur"] + var_01 * (level.func_5832[var_00]["goal"]["nearBlur"] - level.func_5832[var_00]["current"]["nearBlur"]);
  level.func_5832[var_00]["current"]["farStart"] = level.func_5832[var_00]["current"]["farStart"] + var_01 * (level.func_5832[var_00]["goal"]["farStart"] - level.func_5832[var_00]["current"]["farStart"]);
  level.func_5832[var_00]["current"]["farEnd"] = level.func_5832[var_00]["current"]["farEnd"] + var_01 * (level.func_5832[var_00]["goal"]["farEnd"] - level.func_5832[var_00]["current"]["farEnd"]);
  level.func_5832[var_00]["current"]["farBlur"] = level.func_5832[var_00]["current"]["farBlur"] + var_01 * (level.func_5832[var_00]["goal"]["farBlur"] - level.func_5832[var_00]["current"]["farBlur"]);
  level.func_5832[var_00]["current"]["weight"] = level.func_5832[var_00]["current"]["weight"] + var_01 * (level.func_5832[var_00]["goal"]["weight"] - level.func_5832[var_00]["current"]["weight"]);
}

func_583A(var_00, var_01) {
  var_02 = 1;
  var_03 = 1;
  var_04 = 4.5;
  var_05 = 500;
  var_06 = 500;
  var_07 = 0.05;
  func_5849(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, 1.0);
}

func_5843() {
  if(getdvar("scr_dof_enable") == "") {
    _setsaveddvar("scr_dof_enable", "1");
  }

  setdvar("ads_dof_tracedist", 8192);
  setdvar("ads_dof_maxEnemyDist", 10000);
  setdvar("ads_dof_playerForgetEnemyTime", 5000);
  setdvar("ads_dof_nearStartScale", 0.25);
  setdvar("ads_dof_nearEndScale", 0.85);
  setdvar("ads_dof_farStartScale", 1.15);
  setdvar("ads_dof_farEndScale", 3);
  setdvar("ads_dof_nearBlur", 4);
  setdvar("ads_dof_farBlur", 1.5);
  setdvar("ads_dof_debug", 0);
  level.func_5832 = [];
  level.func_5832["base"] = [];
  level.func_5832["base"]["current"] = [];
  level.func_5832["base"]["goal"] = [];
  level.func_5832["base"]["timeRemaining"] = 0.0;
  func_583A("base", "current");
  func_5849("base", "goal", 0, 0, 0, 0, 0, 0, 0.0);
  level.func_5832["script"] = [];
  level.func_5832["script"]["current"] = [];
  level.func_5832["script"]["goal"] = [];
  level.func_5832["script"]["timeRemaining"] = 0.0;
  func_5849("script", "current", 0, 0, 0, 0, 0, 0, 0.0);
  func_5849("script", "goal", 0, 0, 0, 0, 0, 0, 0.0);
  level.func_5832["ads"] = [];
  level.func_5832["ads"]["current"] = [];
  level.func_5832["ads"]["goal"] = [];
  func_5849("ads", "current", 0, 0, 0, 0, 0, 0, 0.0);
  func_5849("ads", "goal", 0, 0, 0, 0, 0, 0, 0.0);
  level.func_5832["results"] = [];
  level.func_5832["results"]["current"] = [];
  func_583A("results", "current");

  foreach(var_01 in level.players) {
    var_01 thread func_584E();
  }
}

func_5848(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  func_5849("base", "goal", var_00, var_01, var_02, var_03, var_04, var_05, 1.0);
  level.func_5832["base"]["timeRemaining"] = var_06;

  if(var_06 <= 0.0) {
    func_5849("base", "current", var_00, var_01, var_02, var_03, var_04, var_05, 1.0);
  }
}

func_583F(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  func_5849("script", "goal", var_00, var_01, var_02, var_03, var_04, var_05, 1.0);
  level.func_5832["script"]["timeRemaining"] = var_06;

  if(var_06 <= 0.0) {
    func_5849("script", "current", var_00, var_01, var_02, var_03, var_04, var_05, 1.0);
  } else if(level.func_5832["script"]["current"]["weight"] <= 0.0) {
    func_5849("script", "current", var_00, var_01, var_02, var_03, var_04, var_05, 0.0);
  }
}

func_583D(var_00) {
  level.func_5832["script"]["goal"]["weight"] = 0.0;
  level.func_5832["script"]["timeRemaining"] = var_00;

  if(var_00 <= 0.0) {
    level.func_5832["script"]["current"]["weight"] = 0.0;
  }
}

is_dof_script_enabled() {
  return level.func_5832["script"]["current"]["weight"] > 0;
}

func_583E(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  func_5849("ads", "goal", var_00, var_01, var_02, var_03, var_04, var_05, var_06);

  if(level.func_5832["ads"]["current"]["weight"] <= 0.0) {
    func_5849("ads", "current", var_00, var_01, var_02, var_03, var_04, var_05, 0.0);
  }
}

func_5836(var_00, var_01, var_02, var_03) {
  if(var_00 > var_01) {
    var_04 = (var_00 - var_01) * var_03;

    if(var_04 > var_02) {
      var_04 = var_02;
    } else if(var_04 < 1) {
      var_04 = 1;
    }

    if(var_00 - var_04 <= var_01) {
      return var_01;
    } else {
      return var_00 - var_04;
    }
  } else if(var_00 < var_01) {
    var_04 = (var_01 - var_00) * var_03;

    if(var_04 > var_02) {
      var_04 = var_02;
    } else if(var_04 < 1) {
      var_04 = 1;
    }

    if(var_00 + var_04 >= var_01) {
      return var_01;
    } else {
      return var_00 + var_04;
    }
  }

  return var_00;
}

func_5835() {
  var_00 = level.func_5832["ads"]["goal"]["weight"];

  if(var_00 < 1.0) {
    if(self adsbuttonpressed() && self playerads() > 0.0) {
      var_00 = min(1, var_00 + 0.7);
    } else {
      var_00 = 0;
    }

    level.func_5832["ads"]["current"]["nearStart"] = level.func_5832["ads"]["goal"]["nearStart"];
    level.func_5832["ads"]["current"]["nearEnd"] = level.func_5832["ads"]["goal"]["nearEnd"];
    level.func_5832["ads"]["current"]["nearBlur"] = level.func_5832["ads"]["goal"]["nearBlur"];
    level.func_5832["ads"]["current"]["farStart"] = level.func_5832["ads"]["goal"]["farStart"];
    level.func_5832["ads"]["current"]["farEnd"] = level.func_5832["ads"]["goal"]["farEnd"];
    level.func_5832["ads"]["current"]["farBlur"] = level.func_5832["ads"]["goal"]["farBlur"];
    level.func_5832["ads"]["current"]["weight"] = var_00;
    return;
  }

  if(isDefined(level.func_5837)) {
    var_01 = level.func_5837;
  } else {
    var_01 = 0.1;
  }

  var_02 = 10;
  var_03 = max(var_02, abs(level.func_5832["ads"]["current"]["nearStart"] - level.func_5832["ads"]["goal"]["nearStart"]) * var_01);
  var_04 = max(var_02, abs(level.func_5832["ads"]["current"]["nearEnd"] - level.func_5832["ads"]["goal"]["nearEnd"]) * var_01);
  var_05 = max(var_02, abs(level.func_5832["ads"]["current"]["farStart"] - level.func_5832["ads"]["goal"]["farStart"]) * var_01);
  var_06 = max(var_02, abs(level.func_5832["ads"]["current"]["farEnd"] - level.func_5832["ads"]["goal"]["farEnd"]) * var_01);
  var_07 = 0.1;
  level.func_5832["ads"]["current"]["nearStart"] = func_5836(level.func_5832["ads"]["current"]["nearStart"], level.func_5832["ads"]["goal"]["nearStart"], var_03, 0.33);
  level.func_5832["ads"]["current"]["nearEnd"] = func_5836(level.func_5832["ads"]["current"]["nearEnd"], level.func_5832["ads"]["goal"]["nearEnd"], var_04, 0.33);
  level.func_5832["ads"]["current"]["nearBlur"] = func_5836(level.func_5832["ads"]["current"]["nearBlur"], level.func_5832["ads"]["goal"]["nearBlur"], var_07, 0.33);
  level.func_5832["ads"]["current"]["farStart"] = func_5836(level.func_5832["ads"]["current"]["farStart"], level.func_5832["ads"]["goal"]["farStart"], var_05, 0.33);
  level.func_5832["ads"]["current"]["farEnd"] = func_5836(level.func_5832["ads"]["current"]["farEnd"], level.func_5832["ads"]["goal"]["farEnd"], var_06, 0.33);
  level.func_5832["ads"]["current"]["farBlur"] = func_5836(level.func_5832["ads"]["current"]["farBlur"], level.func_5832["ads"]["goal"]["farBlur"], var_07, 0.33);
  level.func_5832["ads"]["current"]["weight"] = 1.0;
}

func_583C() {
  level.func_5832["ads"]["goal"]["weight"] = 0.0;
  level.func_5832["ads"]["current"]["weight"] = 0.0;
}

func_5833(var_00) {
  var_01 = level.func_5832[var_00]["current"]["weight"];
  var_02 = 1.0 - var_01;
  level.func_5832["results"]["current"]["nearStart"] = level.func_5832["results"]["current"]["nearStart"] * var_02 + level.func_5832[var_00]["current"]["nearStart"] * var_01;
  level.func_5832["results"]["current"]["nearEnd"] = level.func_5832["results"]["current"]["nearEnd"] * var_02 + level.func_5832[var_00]["current"]["nearEnd"] * var_01;
  level.func_5832["results"]["current"]["nearBlur"] = level.func_5832["results"]["current"]["nearBlur"] * var_02 + level.func_5832[var_00]["current"]["nearBlur"] * var_01;
  level.func_5832["results"]["current"]["farStart"] = level.func_5832["results"]["current"]["farStart"] * var_02 + level.func_5832[var_00]["current"]["farStart"] * var_01;
  level.func_5832["results"]["current"]["farEnd"] = level.func_5832["results"]["current"]["farEnd"] * var_02 + level.func_5832[var_00]["current"]["farEnd"] * var_01;
  level.func_5832["results"]["current"]["farBlur"] = level.func_5832["results"]["current"]["farBlur"] * var_02 + level.func_5832[var_00]["current"]["farBlur"] * var_01;
}

func_5839() {
  func_5838("base");
  func_5838("script");
  func_5835();
  func_5833("base");
  func_5833("script");
  func_5833("ads");
  var_00 = level.func_5832["results"]["current"]["nearStart"];
  var_01 = level.func_5832["results"]["current"]["nearEnd"];
  var_02 = level.func_5832["results"]["current"]["nearBlur"];
  var_03 = level.func_5832["results"]["current"]["farStart"];
  var_04 = level.func_5832["results"]["current"]["farEnd"];
  var_05 = level.func_5832["results"]["current"]["farBlur"];
  var_00 = max(0, var_00);
  var_01 = max(0, var_01);
  var_03 = max(0, var_03);
  var_04 = max(0, var_04);
  var_02 = max(4, var_02);
  var_02 = min(10, var_02);
  var_05 = max(0, var_05);
  var_05 = min(var_02, var_05);

  if(var_05 > 0.0) {
    var_03 = max(var_01, var_03);
  }

  level.func_5832["results"]["current"]["nearStart"] = var_00;
  level.func_5832["results"]["current"]["nearEnd"] = var_01;
  level.func_5832["results"]["current"]["nearBlur"] = var_02;
  level.func_5832["results"]["current"]["farStart"] = var_03;
  level.func_5832["results"]["current"]["farEnd"] = var_04;
  level.func_5832["results"]["current"]["farBlur"] = var_05;
}

func_5845() {
  var_00 = self playerads();

  if(var_00 <= 0.0) {
    func_583C();
    return;
  }

  if(isDefined(level.func_4C4C)) {
    [[level.func_4C4C]]();
    return;
  }

  var_01 = getdvarfloat("ads_dof_tracedist", 4096);
  var_02 = getdvarfloat("ads_dof_maxEnemyDist", 0);
  var_03 = getdvarint("ads_dof_playerForgetEnemyTime", 5000);
  var_04 = getdvarfloat("ads_dof_nearStartScale", 0.25);
  var_05 = getdvarfloat("ads_dof_nearEndScale", 0.85);
  var_06 = getdvarfloat("ads_dof_farStartScale", 1.15);
  var_07 = getdvarfloat("ads_dof_farEndScale", 3);
  var_08 = getdvarfloat("ads_dof_nearBlur", 4);
  var_09 = getdvarfloat("ads_dof_farBlur", 2.5);
  var_10 = self getEye();
  var_11 = self getplayerangles();

  if(isDefined(self.func_5847)) {
    var_12 = _combineangles(self.func_5847.angles, var_11);
  } else {
    var_12 = var_11;
  }

  var_13 = vectornormalize(anglesToForward(var_12));
  var_14 = bulletTrace(var_10, var_10 + var_13 * var_01, 1, self, 1, 0, 0, 0, 0);
  var_15 = _getaiarray("axis");
  var_16 = self getcurrentweapon();

  if(isDefined(level.func_1094B[var_16])) {
    [[level.func_1094B[var_16]]](var_14, var_15, var_10, var_13, var_00);
    return;
  }

  if(var_14["fraction"] == 1) {
    var_01 = 8192;
    var_17 = 1024;
    var_18 = var_01 * var_06 * 2;
  } else {
    var_01 = distance(var_10, var_14["position"]);
    var_17 = var_01 * var_04;
    var_18 = var_01 * var_06;
  }

  foreach(var_20 in var_15) {
    var_21 = var_20 _meth_819D();
    var_22 = var_20 getstruct(var_03);

    if(!var_21 && !var_22) {
      continue;
    }
    var_23 = vectornormalize(var_20.origin - var_10);
    var_24 = vectordot(var_13, var_23);

    if(var_24 < 0.923) {
      continue;
    }
    var_25 = distance(var_10, var_20.origin);

    if(var_25 - 30 < var_17) {
      var_17 = var_25 - 30;
    }

    var_26 = min(var_25, var_02);

    if(var_26 + 30 > var_18) {
      var_18 = var_26 + 30;
    }
  }

  if(var_17 > var_18) {
    var_17 = var_18 - 256;
  }

  if(var_17 > var_01) {
    var_17 = var_01 - 30;
  }

  if(var_17 < 1) {
    var_17 = 1;
  }

  if(var_18 < var_01) {
    var_18 = var_01;
  }

  var_28 = var_17 * var_04;
  var_29 = var_18 * var_07;
  func_583E(var_28, var_17, var_08, var_18, var_29, var_09, var_00);
}

func_A43D(var_00, var_01, var_02, var_03, var_04) {
  if(var_04 < 0.88) {
    func_583C();
    return;
  }

  var_05 = 10000;
  var_06 = -1;
  var_05 = 2400;
  var_07 = 2400;

  for(var_08 = 0; var_08 < var_1.size; var_8++) {
    var_09 = vectornormalize(var_1[var_08].origin - var_02);
    var_10 = vectordot(var_03, var_09);

    if(var_10 < 0.923) {
      continue;
    }
    var_11 = distance(var_02, var_1[var_08].origin);

    if(var_11 < 2500) {
      var_11 = 2500;
    }

    if(var_11 - 30 < var_05) {
      var_05 = var_11 - 30;
    }

    if(var_11 + 30 > var_06) {
      var_06 = var_11 + 30;
    }
  }

  if(var_05 > var_06) {
    var_05 = 2400;
    var_06 = 3000;
  } else {
    if(var_05 < 50) {
      var_05 = 50;
    }

    if(var_06 > 2500) {
      var_06 = 2500;
    } else if(var_06 < 1000) {
      var_06 = 1000;
    }
  }

  var_12 = distance(var_02, var_0["position"]);

  if(var_12 < 2500) {
    var_12 = 2500;
  }

  if(var_05 > var_12) {
    var_05 = var_12 - 30;
  }

  if(var_05 < 1) {
    var_05 = 1;
  }

  if(var_06 < var_12) {
    var_06 = var_12;
  }

  if(var_07 >= var_05) {
    var_07 = var_05 - 1;
  }

  var_13 = var_06 * 4;
  var_14 = 4;
  var_15 = 1.8;
  func_583E(var_07, var_05, var_14, var_06, var_13, var_15, var_04);
}

func_584E() {
  for(;;) {
    scripts\engine\utility::waitframe();

    if(level.func_ABE6) {
      continue;
    }
    if(!getdvarint("scr_dof_enable")) {
      continue;
    }
    func_5845();
    func_5839();

    if(isDefined(self _meth_8473())) {
      func_583A("results", "current");
    }

    var_00 = level.func_5832["results"]["current"]["nearStart"];
    var_01 = level.func_5832["results"]["current"]["nearEnd"];
    var_02 = level.func_5832["results"]["current"]["farStart"];
    var_03 = level.func_5832["results"]["current"]["farEnd"];
    var_04 = level.func_5832["results"]["current"]["nearBlur"];
    var_05 = level.func_5832["results"]["current"]["farBlur"];
    self setdepthoffield(var_00, var_01, var_02, var_03, var_04, var_05);
  }
}

func_11715() {
  var_00 = getdvar("r_tessellation");

  if(var_00 == "") {
    return;
  }
  level.func_11714 = spawnStruct();
  level.func_11714.func_4CA5 = getdvarfloat("r_tessellationCutoffDistanceBase", 960.0);
  level.func_11714.func_4CA6 = level.func_11714.func_4CA5;
  level.func_11714.func_4CA7 = getdvarfloat("r_tessellationCutoffFalloffBase", 320.0);
  level.func_11714.func_4CA8 = level.func_11714.func_4CA7;
  level.func_11714.time_remaining = 0.0;
  _setsaveddvar("r_tessellationCutoffDistance", level.func_11714.func_4CA5);
  _setsaveddvar("r_tessellationCutoffFalloff", level.func_11714.func_4CA7);

  foreach(var_02 in level.players) {
    var_02 thread func_11717();
  }
}

func_11716(var_00, var_01, var_02) {
  level.func_11714.func_4CA6 = var_00;
  level.func_11714.func_4CA8 = var_01;
  level.func_11714.time_remaining = var_02;
}

func_11717() {
  for(;;) {
    var_00 = level.func_11714.func_4CA5;
    var_01 = level.func_11714.func_4CA7;
    scripts\engine\utility::waitframe();

    if(level.func_11714.time_remaining > 0.0) {
      var_02 = level.func_11714.time_remaining * 20;
      var_03 = (level.func_11714.func_4CA6 - level.func_11714.func_4CA5) / var_02;
      var_04 = (level.func_11714.func_4CA8 - level.func_11714.func_4CA7) / var_02;
      level.func_11714.func_4CA5 = level.func_11714.func_4CA5 + var_03;
      level.func_11714.func_4CA7 = level.func_11714.func_4CA7 + var_04;
      level.func_11714.time_remaining = level.func_11714.time_remaining - 0.05;
    } else {
      level.func_11714.func_4CA5 = level.func_11714.func_4CA6;
      level.func_11714.func_4CA7 = level.func_11714.func_4CA8;
    }

    if(var_00 != level.func_11714.func_4CA5) {
      _setsaveddvar("r_tessellationCutoffDistance", level.func_11714.func_4CA5);
    }

    if(var_01 != level.func_11714.func_4CA7) {
      _setsaveddvar("r_tessellationCutoffFalloff", level.func_11714.func_4CA7);
    }
  }
}

func_1121E(var_00, var_01) {
  if(!isDefined(level.func_11220[var_00])) {
    return;
  }
  self notify("sunflare_start_adjust");
  self endon("sunflare_start_adjust");
  var_02 = gettime();
  var_03 = var_01 * 1000;
  var_04 = _getdvarvector("r_sunflare_position", (0, 0, 0));
  var_05 = gettime() - var_02;
  var_06 = level.func_11220[var_00].position;

  for(level.func_4BC4 = var_00; var_05 < var_03; var_05 = gettime() - var_02) {
    var_06 = level.func_11220[var_00].position;
    var_07 = min(float(var_05 / var_03), 1);
    var_08 = var_04 + (var_06 - var_04) * var_07;
    setdvar("r_sunflare_position", var_08);
    _setsunflareposition(var_08);
    wait 0.05;
  }

  setdvar("r_sunflare_position", level.func_11220[var_00].position);
  _setsunflareposition(var_06);
}

func_F5FD(var_00) {
  switch (var_00) {
    case 1:
      _setsaveddvar("r_veilFalloffWeight1", "1 0.95 0.75");
      _setsaveddvar("r_veilFalloffWeight2", "0.25 0.875 0.02");
      break;
    case 2:
      _setsaveddvar("r_veilFalloffWeight1", "1 0.9 0.6");
      _setsaveddvar("r_veilFalloffWeight2", "0.3 0.05 0.02");
      break;
    case 3:
      _setsaveddvar("r_veilFalloffWeight1", "1 0.6875 0.375");
      _setsaveddvar("r_veilFalloffWeight2", "0.1875 0.1013 0.02");
      break;
    case 4:
      _setsaveddvar("r_veilFalloffWeight1", "1 0.98 0.7");
      _setsaveddvar("r_veilFalloffWeight2", "0.2 0.05 0.0");
      break;
    case 5:
      _setsaveddvar("r_veilFalloffWeight1", "1 0.4 0.15");
      _setsaveddvar("r_veilFalloffWeight2", "0.1 0.0750 0.15");
      break;
    default:
      _setsaveddvar("r_veilFalloffWeight1", "0.25 0.75 1.5");
      _setsaveddvar("r_veilFalloffWeight2", "2 2.5 3");
      break;
  }
}