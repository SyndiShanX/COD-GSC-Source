/******************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\art.gsc
******************************/

main() {
  if(!isDefined(level.var_ABE6)) {
    level.var_ABE6 = 0;
  }

  level.var_4BC4 = "default";
  level.var_11A9 = 0;
  func_5843();
  func_11715();
  level.var_1094B = [];
  level.var_32F7 = [];
  setsaveddvar("r_umbraMinObjectContribution", 8);
  setsaveddvar("r_umbraShadowcasters", 1);
  setsaveddvar("r_usePrebuiltSunShadow", 3);
  setsaveddvar("r_mbEnable", 1);
  setsaveddvar("r_mbVelocityScale", 0);
  setsaveddvar("r_mbVelocityScaleViewModel", 0.2);
  if(!isDefined(level.var_11220)) {
    level.var_11220 = [];
  }

  if(!isDefined(level.script)) {
    level.script = tolower(getdvar("mapname"));
  }
}

func_5849(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  level.var_5832[param_00][param_01]["nearStart"] = param_02;
  level.var_5832[param_00][param_01]["nearEnd"] = param_03;
  level.var_5832[param_00][param_01]["nearBlur"] = param_04;
  level.var_5832[param_00][param_01]["farStart"] = param_05;
  level.var_5832[param_00][param_01]["farEnd"] = param_06;
  level.var_5832[param_00][param_01]["farBlur"] = param_07;
  level.var_5832[param_00][param_01]["weight"] = param_08;
}

func_5838(param_00) {
  if(level.var_5832[param_00]["timeRemaining"] <= 0) {
    return;
  }

  var_01 = min(1, 0.05 / level.var_5832[param_00]["timeRemaining"]);
  level.var_5832[param_00]["timeRemaining"] = level.var_5832[param_00]["timeRemaining"] - 0.05;
  if(level.var_5832[param_00]["timeRemaining"] <= 0) {
    level.var_5832[param_00]["timeRemaining"] = 0;
    level.var_5832[param_00]["current"]["nearStart"] = level.var_5832[param_00]["goal"]["nearStart"];
    level.var_5832[param_00]["current"]["nearEnd"] = level.var_5832[param_00]["goal"]["nearEnd"];
    level.var_5832[param_00]["current"]["nearBlur"] = level.var_5832[param_00]["goal"]["nearBlur"];
    level.var_5832[param_00]["current"]["farStart"] = level.var_5832[param_00]["goal"]["farStart"];
    level.var_5832[param_00]["current"]["farEnd"] = level.var_5832[param_00]["goal"]["farEnd"];
    level.var_5832[param_00]["current"]["farBlur"] = level.var_5832[param_00]["goal"]["farBlur"];
    level.var_5832[param_00]["current"]["weight"] = level.var_5832[param_00]["goal"]["weight"];
    return;
  }

  level.var_5832[param_00]["current"]["nearStart"] = level.var_5832[param_00]["current"]["nearStart"] + var_01 * level.var_5832[param_00]["goal"]["nearStart"] - level.var_5832[param_00]["current"]["nearStart"];
  level.var_5832[param_00]["current"]["nearEnd"] = level.var_5832[param_00]["current"]["nearEnd"] + var_01 * level.var_5832[param_00]["goal"]["nearEnd"] - level.var_5832[param_00]["current"]["nearEnd"];
  level.var_5832[param_00]["current"]["nearBlur"] = level.var_5832[param_00]["current"]["nearBlur"] + var_01 * level.var_5832[param_00]["goal"]["nearBlur"] - level.var_5832[param_00]["current"]["nearBlur"];
  level.var_5832[param_00]["current"]["farStart"] = level.var_5832[param_00]["current"]["farStart"] + var_01 * level.var_5832[param_00]["goal"]["farStart"] - level.var_5832[param_00]["current"]["farStart"];
  level.var_5832[param_00]["current"]["farEnd"] = level.var_5832[param_00]["current"]["farEnd"] + var_01 * level.var_5832[param_00]["goal"]["farEnd"] - level.var_5832[param_00]["current"]["farEnd"];
  level.var_5832[param_00]["current"]["farBlur"] = level.var_5832[param_00]["current"]["farBlur"] + var_01 * level.var_5832[param_00]["goal"]["farBlur"] - level.var_5832[param_00]["current"]["farBlur"];
  level.var_5832[param_00]["current"]["weight"] = level.var_5832[param_00]["current"]["weight"] + var_01 * level.var_5832[param_00]["goal"]["weight"] - level.var_5832[param_00]["current"]["weight"];
}

func_583A(param_00, param_01) {
  var_02 = 1;
  var_03 = 1;
  var_04 = 4.5;
  var_05 = 500;
  var_06 = 500;
  var_07 = 0.05;
  func_5849(param_00, param_01, var_02, var_03, var_04, var_05, var_06, var_07, 1);
}

func_5843() {
  if(getdvar("scr_dof_enable") == "") {
    setsaveddvar("scr_dof_enable", "1");
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
  level.var_5832 = [];
  level.var_5832["base"] = [];
  level.var_5832["base"]["current"] = [];
  level.var_5832["base"]["goal"] = [];
  level.var_5832["base"]["timeRemaining"] = 0;
  func_583A("base", "current");
  func_5849("base", "goal", 0, 0, 0, 0, 0, 0, 0);
  level.var_5832["script"] = [];
  level.var_5832["script"]["current"] = [];
  level.var_5832["script"]["goal"] = [];
  level.var_5832["script"]["timeRemaining"] = 0;
  func_5849("script", "current", 0, 0, 0, 0, 0, 0, 0);
  func_5849("script", "goal", 0, 0, 0, 0, 0, 0, 0);
  level.var_5832["ads"] = [];
  level.var_5832["ads"]["current"] = [];
  level.var_5832["ads"]["goal"] = [];
  func_5849("ads", "current", 0, 0, 0, 0, 0, 0, 0);
  func_5849("ads", "goal", 0, 0, 0, 0, 0, 0, 0);
  level.var_5832["results"] = [];
  level.var_5832["results"]["current"] = [];
  func_583A("results", "current");
  foreach(var_01 in level.players) {
    var_01 thread func_584E();
  }
}

func_5848(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  func_5849("base", "goal", param_00, param_01, param_02, param_03, param_04, param_05, 1);
  level.var_5832["base"]["timeRemaining"] = param_06;
  if(param_06 <= 0) {
    func_5849("base", "current", param_00, param_01, param_02, param_03, param_04, param_05, 1);
  }
}

func_583F(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  func_5849("script", "goal", param_00, param_01, param_02, param_03, param_04, param_05, 1);
  level.var_5832["script"]["timeRemaining"] = param_06;
  if(param_06 <= 0) {
    func_5849("script", "current", param_00, param_01, param_02, param_03, param_04, param_05, 1);
    return;
  }

  if(level.var_5832["script"]["current"]["weight"] <= 0) {
    func_5849("script", "current", param_00, param_01, param_02, param_03, param_04, param_05, 0);
  }
}

func_583D(param_00) {
  level.var_5832["script"]["goal"]["weight"] = 0;
  level.var_5832["script"]["timeRemaining"] = param_00;
  if(param_00 <= 0) {
    level.var_5832["script"]["current"]["weight"] = 0;
  }
}

is_dof_script_enabled() {
  return level.var_5832["script"]["current"]["weight"] > 0;
}

func_583E(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  func_5849("ads", "goal", param_00, param_01, param_02, param_03, param_04, param_05, param_06);
  if(level.var_5832["ads"]["current"]["weight"] <= 0) {
    func_5849("ads", "current", param_00, param_01, param_02, param_03, param_04, param_05, 0);
  }
}

func_5836(param_00, param_01, param_02, param_03) {
  if(param_00 > param_01) {
    var_04 = param_00 - param_01 * param_03;
    if(var_04 > param_02) {
      var_04 = param_02;
    } else if(var_04 < 1) {
      var_04 = 1;
    }

    if(param_00 - var_04 <= param_01) {
      return param_01;
    } else {
      return param_00 - var_04;
    }
  } else if(param_00 < param_01) {
    var_04 = param_01 - param_00 * param_03;
    if(var_04 > param_02) {
      var_04 = param_02;
    } else if(var_04 < 1) {
      var_04 = 1;
    }

    if(param_00 + var_04 >= param_01) {
      return param_01;
    } else {
      return param_00 + var_04;
    }
  }

  return param_00;
}

func_5835() {
  var_00 = level.var_5832["ads"]["goal"]["weight"];
  if(var_00 < 1) {
    if(self adsbuttonpressed() && self getweaponrankinfominxp() > 0) {
      var_00 = min(1, var_00 + 0.7);
    } else {
      var_00 = 0;
    }

    level.var_5832["ads"]["current"]["nearStart"] = level.var_5832["ads"]["goal"]["nearStart"];
    level.var_5832["ads"]["current"]["nearEnd"] = level.var_5832["ads"]["goal"]["nearEnd"];
    level.var_5832["ads"]["current"]["nearBlur"] = level.var_5832["ads"]["goal"]["nearBlur"];
    level.var_5832["ads"]["current"]["farStart"] = level.var_5832["ads"]["goal"]["farStart"];
    level.var_5832["ads"]["current"]["farEnd"] = level.var_5832["ads"]["goal"]["farEnd"];
    level.var_5832["ads"]["current"]["farBlur"] = level.var_5832["ads"]["goal"]["farBlur"];
    level.var_5832["ads"]["current"]["weight"] = var_00;
    return;
  }

  if(isDefined(level.var_5837)) {
    var_01 = level.var_5837;
  } else {
    var_01 = 0.1;
  }

  var_02 = 10;
  var_03 = max(var_02, abs(level.var_5832["ads"]["current"]["nearStart"] - level.var_5832["ads"]["goal"]["nearStart"]) * var_01);
  var_04 = max(var_02, abs(level.var_5832["ads"]["current"]["nearEnd"] - level.var_5832["ads"]["goal"]["nearEnd"]) * var_01);
  var_05 = max(var_02, abs(level.var_5832["ads"]["current"]["farStart"] - level.var_5832["ads"]["goal"]["farStart"]) * var_01);
  var_06 = max(var_02, abs(level.var_5832["ads"]["current"]["farEnd"] - level.var_5832["ads"]["goal"]["farEnd"]) * var_01);
  var_07 = 0.1;
  level.var_5832["ads"]["current"]["nearStart"] = func_5836(level.var_5832["ads"]["current"]["nearStart"], level.var_5832["ads"]["goal"]["nearStart"], var_03, 0.33);
  level.var_5832["ads"]["current"]["nearEnd"] = func_5836(level.var_5832["ads"]["current"]["nearEnd"], level.var_5832["ads"]["goal"]["nearEnd"], var_04, 0.33);
  level.var_5832["ads"]["current"]["nearBlur"] = func_5836(level.var_5832["ads"]["current"]["nearBlur"], level.var_5832["ads"]["goal"]["nearBlur"], var_07, 0.33);
  level.var_5832["ads"]["current"]["farStart"] = func_5836(level.var_5832["ads"]["current"]["farStart"], level.var_5832["ads"]["goal"]["farStart"], var_05, 0.33);
  level.var_5832["ads"]["current"]["farEnd"] = func_5836(level.var_5832["ads"]["current"]["farEnd"], level.var_5832["ads"]["goal"]["farEnd"], var_06, 0.33);
  level.var_5832["ads"]["current"]["farBlur"] = func_5836(level.var_5832["ads"]["current"]["farBlur"], level.var_5832["ads"]["goal"]["farBlur"], var_07, 0.33);
  level.var_5832["ads"]["current"]["weight"] = 1;
}

func_583C() {
  level.var_5832["ads"]["goal"]["weight"] = 0;
  level.var_5832["ads"]["current"]["weight"] = 0;
}

func_5833(param_00) {
  var_01 = level.var_5832[param_00]["current"]["weight"];
  var_02 = 1 - var_01;
  level.var_5832["results"]["current"]["nearStart"] = level.var_5832["results"]["current"]["nearStart"] * var_02 + level.var_5832[param_00]["current"]["nearStart"] * var_01;
  level.var_5832["results"]["current"]["nearEnd"] = level.var_5832["results"]["current"]["nearEnd"] * var_02 + level.var_5832[param_00]["current"]["nearEnd"] * var_01;
  level.var_5832["results"]["current"]["nearBlur"] = level.var_5832["results"]["current"]["nearBlur"] * var_02 + level.var_5832[param_00]["current"]["nearBlur"] * var_01;
  level.var_5832["results"]["current"]["farStart"] = level.var_5832["results"]["current"]["farStart"] * var_02 + level.var_5832[param_00]["current"]["farStart"] * var_01;
  level.var_5832["results"]["current"]["farEnd"] = level.var_5832["results"]["current"]["farEnd"] * var_02 + level.var_5832[param_00]["current"]["farEnd"] * var_01;
  level.var_5832["results"]["current"]["farBlur"] = level.var_5832["results"]["current"]["farBlur"] * var_02 + level.var_5832[param_00]["current"]["farBlur"] * var_01;
}

func_5839() {
  func_5838("base");
  func_5838("script");
  func_5835();
  func_5833("base");
  func_5833("script");
  func_5833("ads");
  var_00 = level.var_5832["results"]["current"]["nearStart"];
  var_01 = level.var_5832["results"]["current"]["nearEnd"];
  var_02 = level.var_5832["results"]["current"]["nearBlur"];
  var_03 = level.var_5832["results"]["current"]["farStart"];
  var_04 = level.var_5832["results"]["current"]["farEnd"];
  var_05 = level.var_5832["results"]["current"]["farBlur"];
  var_00 = max(0, var_00);
  var_01 = max(0, var_01);
  var_03 = max(0, var_03);
  var_04 = max(0, var_04);
  var_02 = max(4, var_02);
  var_02 = min(10, var_02);
  var_05 = max(0, var_05);
  var_05 = min(var_02, var_05);
  if(var_05 > 0) {
    var_03 = max(var_01, var_03);
  }

  level.var_5832["results"]["current"]["nearStart"] = var_00;
  level.var_5832["results"]["current"]["nearEnd"] = var_01;
  level.var_5832["results"]["current"]["nearBlur"] = var_02;
  level.var_5832["results"]["current"]["farStart"] = var_03;
  level.var_5832["results"]["current"]["farEnd"] = var_04;
  level.var_5832["results"]["current"]["farBlur"] = var_05;
}

func_5845() {
  var_00 = self getweaponrankinfominxp();
  if(var_00 <= 0) {
    func_583C();
    return;
  }

  if(isDefined(level.var_4C4C)) {
    [[level.var_4C4C]]();
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
  var_0A = self getEye();
  var_0B = self getplayerangles();
  if(isDefined(self.var_5847)) {
    var_0C = combineangles(self.var_5847.angles, var_0B);
  } else {
    var_0C = var_0C;
  }

  var_0D = vectornormalize(anglesToForward(var_0C));
  var_0E = bulletTrace(var_0A, var_0A + var_0D * var_01, 1, self, 1, 0, 0, 0, 0);
  var_0F = getaiarray("axis");
  var_10 = self getcurrentweapon();
  if(isDefined(level.var_1094B[var_10])) {
    [[level.var_1094B[var_10]]](var_0E, var_0F, var_0A, var_0D, var_00);
    return;
  }

  if(var_0E["fraction"] == 1) {
    var_01 = 8192;
    var_11 = 1024;
    var_12 = var_01 * var_06 * 2;
  } else {
    var_03 = distance(var_0C, var_10["position"]);
    var_11 = var_03 * var_06;
    var_12 = var_02 * var_07;
  }

  foreach(var_14 in var_0F) {
    var_15 = var_14 _meth_819D();
    var_16 = var_14 getstruct(var_03);
    if(!var_15 && !var_16) {
      continue;
    }

    var_17 = vectornormalize(var_14.origin - var_0A);
    var_18 = vectordot(var_0D, var_17);
    if(var_18 < 0.923) {
      continue;
    }

    var_19 = distance(var_0A, var_14.origin);
    if(var_19 - 30 < var_11) {
      var_11 = var_19 - 30;
    }

    var_1A = min(var_19, var_02);
    if(var_1A + 30 > var_12) {
      var_12 = var_1A + 30;
    }
  }

  if(var_11 > var_12) {
    var_11 = var_12 - 256;
  }

  if(var_11 > var_01) {
    var_11 = var_01 - 30;
  }

  if(var_11 < 1) {
    var_11 = 1;
  }

  if(var_12 < var_01) {
    var_12 = var_01;
  }

  var_1C = var_11 * var_04;
  var_1D = var_12 * var_07;
  func_583E(var_1C, var_11, var_08, var_12, var_1D, var_09, var_00);
}

func_A43D(param_00, param_01, param_02, param_03, param_04) {
  if(param_04 < 0.88) {
    func_583C();
    return;
  }

  var_05 = 10000;
  var_06 = -1;
  var_05 = 2400;
  var_07 = 2400;
  for(var_08 = 0; var_08 < param_01.size; var_08++) {
    var_09 = vectornormalize(param_01[var_08].origin - param_02);
    var_0A = vectordot(param_03, var_09);
    if(var_0A < 0.923) {
      continue;
    }

    var_0B = distance(param_02, param_01[var_08].origin);
    if(var_0B < 2500) {
      var_0B = 2500;
    }

    if(var_0B - 30 < var_05) {
      var_05 = var_0B - 30;
    }

    if(var_0B + 30 > var_06) {
      var_06 = var_0B + 30;
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

  var_0C = distance(param_02, param_00["position"]);
  if(var_0C < 2500) {
    var_0C = 2500;
  }

  if(var_05 > var_0C) {
    var_05 = var_0C - 30;
  }

  if(var_05 < 1) {
    var_05 = 1;
  }

  if(var_06 < var_0C) {
    var_06 = var_0C;
  }

  if(var_07 >= var_05) {
    var_07 = var_05 - 1;
  }

  var_0D = var_06 * 4;
  var_0E = 4;
  var_0F = 1.8;
  func_583E(var_07, var_05, var_0E, var_06, var_0D, var_0F, param_04);
}

func_584E() {
  for(;;) {
    scripts\engine\utility::waitframe();
    if(level.var_ABE6) {
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

    var_00 = level.var_5832["results"]["current"]["nearStart"];
    var_01 = level.var_5832["results"]["current"]["nearEnd"];
    var_02 = level.var_5832["results"]["current"]["farStart"];
    var_03 = level.var_5832["results"]["current"]["farEnd"];
    var_04 = level.var_5832["results"]["current"]["nearBlur"];
    var_05 = level.var_5832["results"]["current"]["farBlur"];
    self setdepthoffield(var_00, var_01, var_02, var_03, var_04, var_05);
  }
}

func_11715() {
  var_00 = getdvar("r_tessellation");
  if(var_00 == "") {
    return;
  }

  level.var_11714 = spawnStruct();
  level.var_11714.var_4CA5 = getdvarfloat("r_tessellationCutoffDistanceBase", 960);
  level.var_11714.var_4CA6 = level.var_11714.var_4CA5;
  level.var_11714.var_4CA7 = getdvarfloat("r_tessellationCutoffFalloffBase", 320);
  level.var_11714.var_4CA8 = level.var_11714.var_4CA7;
  level.var_11714.time_remaining = 0;
  setsaveddvar("r_tessellationCutoffDistance", level.var_11714.var_4CA5);
  setsaveddvar("r_tessellationCutoffFalloff", level.var_11714.var_4CA7);
  foreach(var_02 in level.players) {
    var_02 thread func_11717();
  }
}

func_11716(param_00, param_01, param_02) {
  level.var_11714.var_4CA6 = param_00;
  level.var_11714.var_4CA8 = param_01;
  level.var_11714.time_remaining = param_02;
}

func_11717() {
  for(;;) {
    var_00 = level.var_11714.var_4CA5;
    var_01 = level.var_11714.var_4CA7;
    scripts\engine\utility::waitframe();
    if(level.var_11714.time_remaining > 0) {
      var_02 = level.var_11714.time_remaining * 20;
      var_03 = level.var_11714.var_4CA6 - level.var_11714.var_4CA5 / var_02;
      var_04 = level.var_11714.var_4CA8 - level.var_11714.var_4CA7 / var_02;
      level.var_11714.var_4CA5 = level.var_11714.var_4CA5 + var_03;
      level.var_11714.var_4CA7 = level.var_11714.var_4CA7 + var_04;
      level.var_11714.time_remaining = level.var_11714.time_remaining - 0.05;
    } else {
      level.var_11714.var_4CA5 = level.var_11714.var_4CA6;
      level.var_11714.var_4CA7 = level.var_11714.var_4CA8;
    }

    if(var_00 != level.var_11714.var_4CA5) {
      setsaveddvar("r_tessellationCutoffDistance", level.var_11714.var_4CA5);
    }

    if(var_01 != level.var_11714.var_4CA7) {
      setsaveddvar("r_tessellationCutoffFalloff", level.var_11714.var_4CA7);
    }
  }
}

func_1121E(param_00, param_01) {
  if(!isDefined(level.var_11220[param_00])) {
    return;
  }

  self notify("sunflare_start_adjust");
  self endon("sunflare_start_adjust");
  var_02 = gettime();
  var_03 = param_01 * 1000;
  var_04 = getdvarvector("r_sunflare_position", (0, 0, 0));
  var_05 = gettime() - var_02;
  var_06 = level.var_11220[param_00].weaponisauto;
  level.var_4BC4 = param_00;
  while(var_05 < var_03) {
    var_06 = level.var_11220[param_00].weaponisauto;
    var_07 = min(float(var_05 / var_03), 1);
    var_08 = var_04 + var_06 - var_04 * var_07;
    setdvar("r_sunflare_position", var_08);
    setsunflareposition(var_08);
    wait(0.05);
    var_05 = gettime() - var_02;
  }

  setdvar("r_sunflare_position", level.var_11220[param_00].weaponisauto);
  setsunflareposition(var_06);
}

func_F5FD(param_00) {
  switch (param_00) {
    case 1:
      setsaveddvar("r_veilFalloffWeight1", "1 0.95 0.75");
      setsaveddvar("r_veilFalloffWeight2", "0.25 0.875 0.02");
      break;

    case 2:
      setsaveddvar("r_veilFalloffWeight1", "1 0.9 0.6");
      setsaveddvar("r_veilFalloffWeight2", "0.3 0.05 0.02");
      break;

    case 3:
      setsaveddvar("r_veilFalloffWeight1", "1 0.6875 0.375");
      setsaveddvar("r_veilFalloffWeight2", "0.1875 0.1013 0.02");
      break;

    case 4:
      setsaveddvar("r_veilFalloffWeight1", "1 0.98 0.7");
      setsaveddvar("r_veilFalloffWeight2", "0.2 0.05 0.0");
      break;

    case 5:
      setsaveddvar("r_veilFalloffWeight1", "1 0.4 0.15");
      setsaveddvar("r_veilFalloffWeight2", "0.1 0.0750 0.15");
      break;

    default:
      setsaveddvar("r_veilFalloffWeight1", "0.25 0.75 1.5");
      setsaveddvar("r_veilFalloffWeight2", "2 2.5 3");
      break;
  }
}