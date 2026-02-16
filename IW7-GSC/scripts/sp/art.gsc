/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\art.gsc
*********************************************/

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
    level.script = tolower(getDvar("mapname"));
  }
}

func_5849(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level.var_5832[var_0][var_1]["nearStart"] = var_2;
  level.var_5832[var_0][var_1]["nearEnd"] = var_3;
  level.var_5832[var_0][var_1]["nearBlur"] = var_4;
  level.var_5832[var_0][var_1]["farStart"] = var_5;
  level.var_5832[var_0][var_1]["farEnd"] = var_6;
  level.var_5832[var_0][var_1]["farBlur"] = var_7;
  level.var_5832[var_0][var_1]["weight"] = var_8;
}

func_5838(var_0) {
  if(level.var_5832[var_0]["timeRemaining"] <= 0) {
    return;
  }

  var_1 = min(1, 0.05 / level.var_5832[var_0]["timeRemaining"]);
  level.var_5832[var_0]["timeRemaining"] = level.var_5832[var_0]["timeRemaining"] - 0.05;
  if(level.var_5832[var_0]["timeRemaining"] <= 0) {
    level.var_5832[var_0]["timeRemaining"] = 0;
    level.var_5832[var_0]["current"]["nearStart"] = level.var_5832[var_0]["goal"]["nearStart"];
    level.var_5832[var_0]["current"]["nearEnd"] = level.var_5832[var_0]["goal"]["nearEnd"];
    level.var_5832[var_0]["current"]["nearBlur"] = level.var_5832[var_0]["goal"]["nearBlur"];
    level.var_5832[var_0]["current"]["farStart"] = level.var_5832[var_0]["goal"]["farStart"];
    level.var_5832[var_0]["current"]["farEnd"] = level.var_5832[var_0]["goal"]["farEnd"];
    level.var_5832[var_0]["current"]["farBlur"] = level.var_5832[var_0]["goal"]["farBlur"];
    level.var_5832[var_0]["current"]["weight"] = level.var_5832[var_0]["goal"]["weight"];
    return;
  }

  level.var_5832[var_0]["current"]["nearStart"] = level.var_5832[var_0]["current"]["nearStart"] + var_1 * level.var_5832[var_0]["goal"]["nearStart"] - level.var_5832[var_0]["current"]["nearStart"];
  level.var_5832[var_0]["current"]["nearEnd"] = level.var_5832[var_0]["current"]["nearEnd"] + var_1 * level.var_5832[var_0]["goal"]["nearEnd"] - level.var_5832[var_0]["current"]["nearEnd"];
  level.var_5832[var_0]["current"]["nearBlur"] = level.var_5832[var_0]["current"]["nearBlur"] + var_1 * level.var_5832[var_0]["goal"]["nearBlur"] - level.var_5832[var_0]["current"]["nearBlur"];
  level.var_5832[var_0]["current"]["farStart"] = level.var_5832[var_0]["current"]["farStart"] + var_1 * level.var_5832[var_0]["goal"]["farStart"] - level.var_5832[var_0]["current"]["farStart"];
  level.var_5832[var_0]["current"]["farEnd"] = level.var_5832[var_0]["current"]["farEnd"] + var_1 * level.var_5832[var_0]["goal"]["farEnd"] - level.var_5832[var_0]["current"]["farEnd"];
  level.var_5832[var_0]["current"]["farBlur"] = level.var_5832[var_0]["current"]["farBlur"] + var_1 * level.var_5832[var_0]["goal"]["farBlur"] - level.var_5832[var_0]["current"]["farBlur"];
  level.var_5832[var_0]["current"]["weight"] = level.var_5832[var_0]["current"]["weight"] + var_1 * level.var_5832[var_0]["goal"]["weight"] - level.var_5832[var_0]["current"]["weight"];
}

func_583A(var_0, var_1) {
  var_2 = 1;
  var_3 = 1;
  var_4 = 4.5;
  var_5 = 500;
  var_6 = 500;
  var_7 = 0.05;
  func_5849(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 1);
}

func_5843() {
  if(getDvar("scr_dof_enable") == "") {
    setsaveddvar("scr_dof_enable", "1");
  }

  setDvar("ads_dof_tracedist", 8192);
  setDvar("ads_dof_maxEnemyDist", 10000);
  setDvar("ads_dof_playerForgetEnemyTime", 5000);
  setDvar("ads_dof_nearStartScale", 0.25);
  setDvar("ads_dof_nearEndScale", 0.85);
  setDvar("ads_dof_farStartScale", 1.15);
  setDvar("ads_dof_farEndScale", 3);
  setDvar("ads_dof_nearBlur", 4);
  setDvar("ads_dof_farBlur", 1.5);
  setDvar("ads_dof_debug", 0);
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
  foreach(var_1 in level.players) {
    var_1 thread func_584E();
  }
}

func_5848(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  func_5849("base", "goal", var_0, var_1, var_2, var_3, var_4, var_5, 1);
  level.var_5832["base"]["timeRemaining"] = var_6;
  if(var_6 <= 0) {
    func_5849("base", "current", var_0, var_1, var_2, var_3, var_4, var_5, 1);
  }
}

func_583F(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  func_5849("script", "goal", var_0, var_1, var_2, var_3, var_4, var_5, 1);
  level.var_5832["script"]["timeRemaining"] = var_6;
  if(var_6 <= 0) {
    func_5849("script", "current", var_0, var_1, var_2, var_3, var_4, var_5, 1);
    return;
  }

  if(level.var_5832["script"]["current"]["weight"] <= 0) {
    func_5849("script", "current", var_0, var_1, var_2, var_3, var_4, var_5, 0);
  }
}

func_583D(var_0) {
  level.var_5832["script"]["goal"]["weight"] = 0;
  level.var_5832["script"]["timeRemaining"] = var_0;
  if(var_0 <= 0) {
    level.var_5832["script"]["current"]["weight"] = 0;
  }
}

is_dof_script_enabled() {
  return level.var_5832["script"]["current"]["weight"] > 0;
}

func_583E(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  func_5849("ads", "goal", var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  if(level.var_5832["ads"]["current"]["weight"] <= 0) {
    func_5849("ads", "current", var_0, var_1, var_2, var_3, var_4, var_5, 0);
  }
}

func_5836(var_0, var_1, var_2, var_3) {
  if(var_0 > var_1) {
    var_4 = var_0 - var_1 * var_3;
    if(var_4 > var_2) {
      var_4 = var_2;
    } else if(var_4 < 1) {
      var_4 = 1;
    }

    if(var_0 - var_4 <= var_1) {
      return var_1;
    } else {
      return var_0 - var_4;
    }
  } else if(var_0 < var_1) {
    var_4 = var_1 - var_0 * var_3;
    if(var_4 > var_2) {
      var_4 = var_2;
    } else if(var_4 < 1) {
      var_4 = 1;
    }

    if(var_0 + var_4 >= var_1) {
      return var_1;
    } else {
      return var_0 + var_4;
    }
  }

  return var_0;
}

func_5835() {
  var_0 = level.var_5832["ads"]["goal"]["weight"];
  if(var_0 < 1) {
    if(self adsButtonPressed() && self playerads() > 0) {
      var_0 = min(1, var_0 + 0.7);
    } else {
      var_0 = 0;
    }

    level.var_5832["ads"]["current"]["nearStart"] = level.var_5832["ads"]["goal"]["nearStart"];
    level.var_5832["ads"]["current"]["nearEnd"] = level.var_5832["ads"]["goal"]["nearEnd"];
    level.var_5832["ads"]["current"]["nearBlur"] = level.var_5832["ads"]["goal"]["nearBlur"];
    level.var_5832["ads"]["current"]["farStart"] = level.var_5832["ads"]["goal"]["farStart"];
    level.var_5832["ads"]["current"]["farEnd"] = level.var_5832["ads"]["goal"]["farEnd"];
    level.var_5832["ads"]["current"]["farBlur"] = level.var_5832["ads"]["goal"]["farBlur"];
    level.var_5832["ads"]["current"]["weight"] = var_0;
    return;
  }

  if(isDefined(level.var_5837)) {
    var_1 = level.var_5837;
  } else {
    var_1 = 0.1;
  }

  var_2 = 10;
  var_3 = max(var_2, abs(level.var_5832["ads"]["current"]["nearStart"] - level.var_5832["ads"]["goal"]["nearStart"]) * var_1);
  var_4 = max(var_2, abs(level.var_5832["ads"]["current"]["nearEnd"] - level.var_5832["ads"]["goal"]["nearEnd"]) * var_1);
  var_5 = max(var_2, abs(level.var_5832["ads"]["current"]["farStart"] - level.var_5832["ads"]["goal"]["farStart"]) * var_1);
  var_6 = max(var_2, abs(level.var_5832["ads"]["current"]["farEnd"] - level.var_5832["ads"]["goal"]["farEnd"]) * var_1);
  var_7 = 0.1;
  level.var_5832["ads"]["current"]["nearStart"] = func_5836(level.var_5832["ads"]["current"]["nearStart"], level.var_5832["ads"]["goal"]["nearStart"], var_3, 0.33);
  level.var_5832["ads"]["current"]["nearEnd"] = func_5836(level.var_5832["ads"]["current"]["nearEnd"], level.var_5832["ads"]["goal"]["nearEnd"], var_4, 0.33);
  level.var_5832["ads"]["current"]["nearBlur"] = func_5836(level.var_5832["ads"]["current"]["nearBlur"], level.var_5832["ads"]["goal"]["nearBlur"], var_7, 0.33);
  level.var_5832["ads"]["current"]["farStart"] = func_5836(level.var_5832["ads"]["current"]["farStart"], level.var_5832["ads"]["goal"]["farStart"], var_5, 0.33);
  level.var_5832["ads"]["current"]["farEnd"] = func_5836(level.var_5832["ads"]["current"]["farEnd"], level.var_5832["ads"]["goal"]["farEnd"], var_6, 0.33);
  level.var_5832["ads"]["current"]["farBlur"] = func_5836(level.var_5832["ads"]["current"]["farBlur"], level.var_5832["ads"]["goal"]["farBlur"], var_7, 0.33);
  level.var_5832["ads"]["current"]["weight"] = 1;
}

func_583C() {
  level.var_5832["ads"]["goal"]["weight"] = 0;
  level.var_5832["ads"]["current"]["weight"] = 0;
}

func_5833(var_0) {
  var_1 = level.var_5832[var_0]["current"]["weight"];
  var_2 = 1 - var_1;
  level.var_5832["results"]["current"]["nearStart"] = level.var_5832["results"]["current"]["nearStart"] * var_2 + level.var_5832[var_0]["current"]["nearStart"] * var_1;
  level.var_5832["results"]["current"]["nearEnd"] = level.var_5832["results"]["current"]["nearEnd"] * var_2 + level.var_5832[var_0]["current"]["nearEnd"] * var_1;
  level.var_5832["results"]["current"]["nearBlur"] = level.var_5832["results"]["current"]["nearBlur"] * var_2 + level.var_5832[var_0]["current"]["nearBlur"] * var_1;
  level.var_5832["results"]["current"]["farStart"] = level.var_5832["results"]["current"]["farStart"] * var_2 + level.var_5832[var_0]["current"]["farStart"] * var_1;
  level.var_5832["results"]["current"]["farEnd"] = level.var_5832["results"]["current"]["farEnd"] * var_2 + level.var_5832[var_0]["current"]["farEnd"] * var_1;
  level.var_5832["results"]["current"]["farBlur"] = level.var_5832["results"]["current"]["farBlur"] * var_2 + level.var_5832[var_0]["current"]["farBlur"] * var_1;
}

func_5839() {
  func_5838("base");
  func_5838("script");
  func_5835();
  func_5833("base");
  func_5833("script");
  func_5833("ads");
  var_0 = level.var_5832["results"]["current"]["nearStart"];
  var_1 = level.var_5832["results"]["current"]["nearEnd"];
  var_2 = level.var_5832["results"]["current"]["nearBlur"];
  var_3 = level.var_5832["results"]["current"]["farStart"];
  var_4 = level.var_5832["results"]["current"]["farEnd"];
  var_5 = level.var_5832["results"]["current"]["farBlur"];
  var_0 = max(0, var_0);
  var_1 = max(0, var_1);
  var_3 = max(0, var_3);
  var_4 = max(0, var_4);
  var_2 = max(4, var_2);
  var_2 = min(10, var_2);
  var_5 = max(0, var_5);
  var_5 = min(var_2, var_5);
  if(var_5 > 0) {
    var_3 = max(var_1, var_3);
  }

  level.var_5832["results"]["current"]["nearStart"] = var_0;
  level.var_5832["results"]["current"]["nearEnd"] = var_1;
  level.var_5832["results"]["current"]["nearBlur"] = var_2;
  level.var_5832["results"]["current"]["farStart"] = var_3;
  level.var_5832["results"]["current"]["farEnd"] = var_4;
  level.var_5832["results"]["current"]["farBlur"] = var_5;
}

func_5845() {
  var_0 = self playerads();
  if(var_0 <= 0) {
    func_583C();
    return;
  }

  if(isDefined(level.var_4C4C)) {
    [[level.var_4C4C]]();
    return;
  }

  var_1 = getdvarfloat("ads_dof_tracedist", 4096);
  var_2 = getdvarfloat("ads_dof_maxEnemyDist", 0);
  var_3 = getdvarint("ads_dof_playerForgetEnemyTime", 5000);
  var_4 = getdvarfloat("ads_dof_nearStartScale", 0.25);
  var_5 = getdvarfloat("ads_dof_nearEndScale", 0.85);
  var_6 = getdvarfloat("ads_dof_farStartScale", 1.15);
  var_7 = getdvarfloat("ads_dof_farEndScale", 3);
  var_8 = getdvarfloat("ads_dof_nearBlur", 4);
  var_9 = getdvarfloat("ads_dof_farBlur", 2.5);
  var_10 = self getEye();
  var_11 = self getplayerangles();
  if(isDefined(self.var_5847)) {
    var_12 = combineangles(self.var_5847.angles, var_11);
  } else {
    var_12 = var_12;
  }

  var_13 = vectornormalize(anglesToForward(var_12));
  var_14 = bulletTrace(var_10, var_10 + var_13 * var_1, 1, self, 1, 0, 0, 0, 0);
  var_15 = getaiarray("axis");
  var_10 = self getcurrentweapon();
  if(isDefined(level.var_1094B[var_10])) {
    [[level.var_1094B[var_10]]](var_14, var_15, var_10, var_13, var_0);
    return;
  }

  if(var_14["fraction"] == 1) {
    var_1 = 8192;
    var_11 = 1024;
    var_12 = var_1 * var_6 * 2;
  } else {
    var_3 = distance(var_12, var_10["position"]);
    var_11 = var_3 * var_6;
    var_12 = var_2 * var_7;
  }

  foreach(var_14 in var_15) {
    var_15 = var_14 func_819D();
    var_16 = var_14 getstruct(var_3);
    if(!var_15 && !var_16) {
      continue;
    }

    var_17 = vectornormalize(var_14.origin - var_10);
    var_18 = vectordot(var_13, var_17);
    if(var_18 < 0.923) {
      continue;
    }

    var_19 = distance(var_10, var_14.origin);
    if(var_19 - 30 < var_11) {
      var_11 = var_19 - 30;
    }

    var_1A = min(var_19, var_2);
    if(var_1A + 30 > var_12) {
      var_12 = var_1A + 30;
    }
  }

  if(var_11 > var_12) {
    var_11 = var_12 - 256;
  }

  if(var_11 > var_1) {
    var_11 = var_1 - 30;
  }

  if(var_11 < 1) {
    var_11 = 1;
  }

  if(var_12 < var_1) {
    var_12 = var_1;
  }

  var_1C = var_11 * var_4;
  var_1D = var_12 * var_7;
  func_583E(var_1C, var_11, var_8, var_12, var_1D, var_9, var_0);
}

func_A43D(var_0, var_1, var_2, var_3, var_4) {
  if(var_4 < 0.88) {
    func_583C();
    return;
  }

  var_5 = 10000;
  var_6 = -1;
  var_5 = 2400;
  var_7 = 2400;
  for(var_8 = 0; var_8 < var_1.size; var_8++) {
    var_9 = vectornormalize(var_1[var_8].origin - var_2);
    var_10 = vectordot(var_3, var_9);
    if(var_10 < 0.923) {
      continue;
    }

    var_11 = distance(var_2, var_1[var_8].origin);
    if(var_11 < 2500) {
      var_11 = 2500;
    }

    if(var_11 - 30 < var_5) {
      var_5 = var_11 - 30;
    }

    if(var_11 + 30 > var_6) {
      var_6 = var_11 + 30;
    }
  }

  if(var_5 > var_6) {
    var_5 = 2400;
    var_6 = 3000;
  } else {
    if(var_5 < 50) {
      var_5 = 50;
    }

    if(var_6 > 2500) {
      var_6 = 2500;
    } else if(var_6 < 1000) {
      var_6 = 1000;
    }
  }

  var_12 = distance(var_2, var_0["position"]);
  if(var_12 < 2500) {
    var_12 = 2500;
  }

  if(var_5 > var_12) {
    var_5 = var_12 - 30;
  }

  if(var_5 < 1) {
    var_5 = 1;
  }

  if(var_6 < var_12) {
    var_6 = var_12;
  }

  if(var_7 >= var_5) {
    var_7 = var_5 - 1;
  }

  var_13 = var_6 * 4;
  var_14 = 4;
  var_15 = 1.8;
  func_583E(var_7, var_5, var_14, var_6, var_13, var_15, var_4);
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
    if(isDefined(self func_8473())) {
      func_583A("results", "current");
    }

    var_0 = level.var_5832["results"]["current"]["nearStart"];
    var_1 = level.var_5832["results"]["current"]["nearEnd"];
    var_2 = level.var_5832["results"]["current"]["farStart"];
    var_3 = level.var_5832["results"]["current"]["farEnd"];
    var_4 = level.var_5832["results"]["current"]["nearBlur"];
    var_5 = level.var_5832["results"]["current"]["farBlur"];
    self setdepthoffield(var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

func_11715() {
  var_0 = getDvar("r_tessellation");
  if(var_0 == "") {
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
  foreach(var_2 in level.players) {
    var_2 thread func_11717();
  }
}

func_11716(var_0, var_1, var_2) {
  level.var_11714.var_4CA6 = var_0;
  level.var_11714.var_4CA8 = var_1;
  level.var_11714.time_remaining = var_2;
}

func_11717() {
  for(;;) {
    var_0 = level.var_11714.var_4CA5;
    var_1 = level.var_11714.var_4CA7;
    scripts\engine\utility::waitframe();
    if(level.var_11714.time_remaining > 0) {
      var_2 = level.var_11714.time_remaining * 20;
      var_3 = level.var_11714.var_4CA6 - level.var_11714.var_4CA5 / var_2;
      var_4 = level.var_11714.var_4CA8 - level.var_11714.var_4CA7 / var_2;
      level.var_11714.var_4CA5 = level.var_11714.var_4CA5 + var_3;
      level.var_11714.var_4CA7 = level.var_11714.var_4CA7 + var_4;
      level.var_11714.time_remaining = level.var_11714.time_remaining - 0.05;
    } else {
      level.var_11714.var_4CA5 = level.var_11714.var_4CA6;
      level.var_11714.var_4CA7 = level.var_11714.var_4CA8;
    }

    if(var_0 != level.var_11714.var_4CA5) {
      setsaveddvar("r_tessellationCutoffDistance", level.var_11714.var_4CA5);
    }

    if(var_1 != level.var_11714.var_4CA7) {
      setsaveddvar("r_tessellationCutoffFalloff", level.var_11714.var_4CA7);
    }
  }
}

func_1121E(var_0, var_1) {
  if(!isDefined(level.var_11220[var_0])) {
    return;
  }

  self notify("sunflare_start_adjust");
  self endon("sunflare_start_adjust");
  var_2 = gettime();
  var_3 = var_1 * 1000;
  var_4 = getdvarvector("r_sunflare_position", (0, 0, 0));
  var_5 = gettime() - var_2;
  var_6 = level.var_11220[var_0].weaponisauto;
  level.var_4BC4 = var_0;
  while(var_5 < var_3) {
    var_6 = level.var_11220[var_0].weaponisauto;
    var_7 = min(float(var_5 / var_3), 1);
    var_8 = var_4 + var_6 - var_4 * var_7;
    setDvar("r_sunflare_position", var_8);
    setsunflareposition(var_8);
    wait(0.05);
    var_5 = gettime() - var_2;
  }

  setDvar("r_sunflare_position", level.var_11220[var_0].weaponisauto);
  setsunflareposition(var_6);
}

func_F5FD(var_0) {
  switch (var_0) {
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