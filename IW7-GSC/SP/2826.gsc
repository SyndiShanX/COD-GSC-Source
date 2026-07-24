/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2826.gsc
**************************************/

main() {
  if(!isDefined(level._id_ABE6))
    level._id_ABE6 = 0;

  level._id_4BC4 = "default";
  level._id_11A9 = 0;
  _id_5843();
  _id_11715();
  level._id_1094B = [];
  level._id_32F7 = [];
  setsaveddvar("r_umbraMinObjectContribution", 8);
  setsaveddvar("r_umbraShadowcasters", 1);
  setsaveddvar("r_usePrebuiltSunShadow", 3);
  setsaveddvar("r_mbEnable", 1);
  setsaveddvar("r_mbVelocityScale", 0);
  setsaveddvar("r_mbVelocityScaleViewModel", 0.2);

  if(!isDefined(level._id_11220))
    level._id_11220 = [];

  if(!isDefined(level.script))
    level.script = tolower(getDvar("mapname"));
}

_id_5849(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level._id_5832[var_0][var_1]["nearStart"] = var_2;
  level._id_5832[var_0][var_1]["nearEnd"] = var_3;
  level._id_5832[var_0][var_1]["nearBlur"] = var_4;
  level._id_5832[var_0][var_1]["farStart"] = var_5;
  level._id_5832[var_0][var_1]["farEnd"] = var_6;
  level._id_5832[var_0][var_1]["farBlur"] = var_7;
  level._id_5832[var_0][var_1]["weight"] = var_8;
}

_id_5838(var_0) {
  if(level._id_5832[var_0]["timeRemaining"] <= 0.0) {
    return;
  }
  var_1 = min(1.0, 0.05 / level._id_5832[var_0]["timeRemaining"]);
  level._id_5832[var_0]["timeRemaining"] = level._id_5832[var_0]["timeRemaining"] - 0.05;

  if(level._id_5832[var_0]["timeRemaining"] <= 0.0) {
    level._id_5832[var_0]["timeRemaining"] = 0.0;
    level._id_5832[var_0]["current"]["nearStart"] = level._id_5832[var_0]["goal"]["nearStart"];
    level._id_5832[var_0]["current"]["nearEnd"] = level._id_5832[var_0]["goal"]["nearEnd"];
    level._id_5832[var_0]["current"]["nearBlur"] = level._id_5832[var_0]["goal"]["nearBlur"];
    level._id_5832[var_0]["current"]["farStart"] = level._id_5832[var_0]["goal"]["farStart"];
    level._id_5832[var_0]["current"]["farEnd"] = level._id_5832[var_0]["goal"]["farEnd"];
    level._id_5832[var_0]["current"]["farBlur"] = level._id_5832[var_0]["goal"]["farBlur"];
    level._id_5832[var_0]["current"]["weight"] = level._id_5832[var_0]["goal"]["weight"];
    return;
  }

  level._id_5832[var_0]["current"]["nearStart"] = level._id_5832[var_0]["current"]["nearStart"] + var_1 * (level._id_5832[var_0]["goal"]["nearStart"] - level._id_5832[var_0]["current"]["nearStart"]);
  level._id_5832[var_0]["current"]["nearEnd"] = level._id_5832[var_0]["current"]["nearEnd"] + var_1 * (level._id_5832[var_0]["goal"]["nearEnd"] - level._id_5832[var_0]["current"]["nearEnd"]);
  level._id_5832[var_0]["current"]["nearBlur"] = level._id_5832[var_0]["current"]["nearBlur"] + var_1 * (level._id_5832[var_0]["goal"]["nearBlur"] - level._id_5832[var_0]["current"]["nearBlur"]);
  level._id_5832[var_0]["current"]["farStart"] = level._id_5832[var_0]["current"]["farStart"] + var_1 * (level._id_5832[var_0]["goal"]["farStart"] - level._id_5832[var_0]["current"]["farStart"]);
  level._id_5832[var_0]["current"]["farEnd"] = level._id_5832[var_0]["current"]["farEnd"] + var_1 * (level._id_5832[var_0]["goal"]["farEnd"] - level._id_5832[var_0]["current"]["farEnd"]);
  level._id_5832[var_0]["current"]["farBlur"] = level._id_5832[var_0]["current"]["farBlur"] + var_1 * (level._id_5832[var_0]["goal"]["farBlur"] - level._id_5832[var_0]["current"]["farBlur"]);
  level._id_5832[var_0]["current"]["weight"] = level._id_5832[var_0]["current"]["weight"] + var_1 * (level._id_5832[var_0]["goal"]["weight"] - level._id_5832[var_0]["current"]["weight"]);
}

_id_583A(var_0, var_1) {
  var_2 = 1;
  var_3 = 1;
  var_4 = 4.5;
  var_5 = 500;
  var_6 = 500;
  var_7 = 0.05;
  _id_5849(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 1.0);
}

_id_5843() {
  if(getDvar("scr_dof_enable") == "")
    setsaveddvar("scr_dof_enable", "1");

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
  level._id_5832 = [];
  level._id_5832["base"] = [];
  level._id_5832["base"]["current"] = [];
  level._id_5832["base"]["goal"] = [];
  level._id_5832["base"]["timeRemaining"] = 0.0;
  _id_583A("base", "current");
  _id_5849("base", "goal", 0, 0, 0, 0, 0, 0, 0.0);
  level._id_5832["script"] = [];
  level._id_5832["script"]["current"] = [];
  level._id_5832["script"]["goal"] = [];
  level._id_5832["script"]["timeRemaining"] = 0.0;
  _id_5849("script", "current", 0, 0, 0, 0, 0, 0, 0.0);
  _id_5849("script", "goal", 0, 0, 0, 0, 0, 0, 0.0);
  level._id_5832["ads"] = [];
  level._id_5832["ads"]["current"] = [];
  level._id_5832["ads"]["goal"] = [];
  _id_5849("ads", "current", 0, 0, 0, 0, 0, 0, 0.0);
  _id_5849("ads", "goal", 0, 0, 0, 0, 0, 0, 0.0);
  level._id_5832["results"] = [];
  level._id_5832["results"]["current"] = [];
  _id_583A("results", "current");

  foreach(var_1 in level.players)
  var_1 thread _id_584E();
}

_id_5848(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_5849("base", "goal", var_0, var_1, var_2, var_3, var_4, var_5, 1.0);
  level._id_5832["base"]["timeRemaining"] = var_6;

  if(var_6 <= 0.0)
    _id_5849("base", "current", var_0, var_1, var_2, var_3, var_4, var_5, 1.0);
}

_id_583F(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_5849("script", "goal", var_0, var_1, var_2, var_3, var_4, var_5, 1.0);
  level._id_5832["script"]["timeRemaining"] = var_6;

  if(var_6 <= 0.0)
    _id_5849("script", "current", var_0, var_1, var_2, var_3, var_4, var_5, 1.0);
  else if(level._id_5832["script"]["current"]["weight"] <= 0.0)
    _id_5849("script", "current", var_0, var_1, var_2, var_3, var_4, var_5, 0.0);
}

_id_583D(var_0) {
  level._id_5832["script"]["goal"]["weight"] = 0.0;
  level._id_5832["script"]["timeRemaining"] = var_0;

  if(var_0 <= 0.0)
    level._id_5832["script"]["current"]["weight"] = 0.0;
}

is_dof_script_enabled() {
  return level._id_5832["script"]["current"]["weight"] > 0;
}

_id_583E(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_5849("ads", "goal", var_0, var_1, var_2, var_3, var_4, var_5, var_6);

  if(level._id_5832["ads"]["current"]["weight"] <= 0.0)
    _id_5849("ads", "current", var_0, var_1, var_2, var_3, var_4, var_5, 0.0);
}

_id_5836(var_0, var_1, var_2, var_3) {
  if(var_0 > var_1) {
    var_4 = (var_0 - var_1) * var_3;

    if(var_4 > var_2)
      var_4 = var_2;
    else if(var_4 < 1)
      var_4 = 1;

    if(var_0 - var_4 <= var_1)
      return var_1;
    else
      return var_0 - var_4;
  } else if(var_0 < var_1) {
    var_4 = (var_1 - var_0) * var_3;

    if(var_4 > var_2)
      var_4 = var_2;
    else if(var_4 < 1)
      var_4 = 1;

    if(var_0 + var_4 >= var_1)
      return var_1;
    else
      return var_0 + var_4;
  }

  return var_0;
}

_id_5835() {
  var_0 = level._id_5832["ads"]["goal"]["weight"];

  if(var_0 < 1.0) {
    if(self adsButtonPressed() && self playerads() > 0.0)
      var_0 = min(1, var_0 + 0.7);
    else
      var_0 = 0;

    level._id_5832["ads"]["current"]["nearStart"] = level._id_5832["ads"]["goal"]["nearStart"];
    level._id_5832["ads"]["current"]["nearEnd"] = level._id_5832["ads"]["goal"]["nearEnd"];
    level._id_5832["ads"]["current"]["nearBlur"] = level._id_5832["ads"]["goal"]["nearBlur"];
    level._id_5832["ads"]["current"]["farStart"] = level._id_5832["ads"]["goal"]["farStart"];
    level._id_5832["ads"]["current"]["farEnd"] = level._id_5832["ads"]["goal"]["farEnd"];
    level._id_5832["ads"]["current"]["farBlur"] = level._id_5832["ads"]["goal"]["farBlur"];
    level._id_5832["ads"]["current"]["weight"] = var_0;
    return;
  }

  if(isDefined(level._id_5837))
    var_1 = level._id_5837;
  else
    var_1 = 0.1;

  var_2 = 10;
  var_3 = max(var_2, abs(level._id_5832["ads"]["current"]["nearStart"] - level._id_5832["ads"]["goal"]["nearStart"]) * var_1);
  var_4 = max(var_2, abs(level._id_5832["ads"]["current"]["nearEnd"] - level._id_5832["ads"]["goal"]["nearEnd"]) * var_1);
  var_5 = max(var_2, abs(level._id_5832["ads"]["current"]["farStart"] - level._id_5832["ads"]["goal"]["farStart"]) * var_1);
  var_6 = max(var_2, abs(level._id_5832["ads"]["current"]["farEnd"] - level._id_5832["ads"]["goal"]["farEnd"]) * var_1);
  var_7 = 0.1;
  level._id_5832["ads"]["current"]["nearStart"] = _id_5836(level._id_5832["ads"]["current"]["nearStart"], level._id_5832["ads"]["goal"]["nearStart"], var_3, 0.33);
  level._id_5832["ads"]["current"]["nearEnd"] = _id_5836(level._id_5832["ads"]["current"]["nearEnd"], level._id_5832["ads"]["goal"]["nearEnd"], var_4, 0.33);
  level._id_5832["ads"]["current"]["nearBlur"] = _id_5836(level._id_5832["ads"]["current"]["nearBlur"], level._id_5832["ads"]["goal"]["nearBlur"], var_7, 0.33);
  level._id_5832["ads"]["current"]["farStart"] = _id_5836(level._id_5832["ads"]["current"]["farStart"], level._id_5832["ads"]["goal"]["farStart"], var_5, 0.33);
  level._id_5832["ads"]["current"]["farEnd"] = _id_5836(level._id_5832["ads"]["current"]["farEnd"], level._id_5832["ads"]["goal"]["farEnd"], var_6, 0.33);
  level._id_5832["ads"]["current"]["farBlur"] = _id_5836(level._id_5832["ads"]["current"]["farBlur"], level._id_5832["ads"]["goal"]["farBlur"], var_7, 0.33);
  level._id_5832["ads"]["current"]["weight"] = 1.0;
}

_id_583C() {
  level._id_5832["ads"]["goal"]["weight"] = 0.0;
  level._id_5832["ads"]["current"]["weight"] = 0.0;
}

_id_5833(var_0) {
  var_1 = level._id_5832[var_0]["current"]["weight"];
  var_2 = 1.0 - var_1;
  level._id_5832["results"]["current"]["nearStart"] = level._id_5832["results"]["current"]["nearStart"] * var_2 + level._id_5832[var_0]["current"]["nearStart"] * var_1;
  level._id_5832["results"]["current"]["nearEnd"] = level._id_5832["results"]["current"]["nearEnd"] * var_2 + level._id_5832[var_0]["current"]["nearEnd"] * var_1;
  level._id_5832["results"]["current"]["nearBlur"] = level._id_5832["results"]["current"]["nearBlur"] * var_2 + level._id_5832[var_0]["current"]["nearBlur"] * var_1;
  level._id_5832["results"]["current"]["farStart"] = level._id_5832["results"]["current"]["farStart"] * var_2 + level._id_5832[var_0]["current"]["farStart"] * var_1;
  level._id_5832["results"]["current"]["farEnd"] = level._id_5832["results"]["current"]["farEnd"] * var_2 + level._id_5832[var_0]["current"]["farEnd"] * var_1;
  level._id_5832["results"]["current"]["farBlur"] = level._id_5832["results"]["current"]["farBlur"] * var_2 + level._id_5832[var_0]["current"]["farBlur"] * var_1;
}

_id_5839() {
  _id_5838("base");
  _id_5838("script");
  _id_5835();
  _id_5833("base");
  _id_5833("script");
  _id_5833("ads");
  var_0 = level._id_5832["results"]["current"]["nearStart"];
  var_1 = level._id_5832["results"]["current"]["nearEnd"];
  var_2 = level._id_5832["results"]["current"]["nearBlur"];
  var_3 = level._id_5832["results"]["current"]["farStart"];
  var_4 = level._id_5832["results"]["current"]["farEnd"];
  var_5 = level._id_5832["results"]["current"]["farBlur"];
  var_0 = max(0, var_0);
  var_1 = max(0, var_1);
  var_3 = max(0, var_3);
  var_4 = max(0, var_4);
  var_2 = max(4, var_2);
  var_2 = min(10, var_2);
  var_5 = max(0, var_5);
  var_5 = min(var_2, var_5);

  if(var_5 > 0.0)
    var_3 = max(var_1, var_3);

  level._id_5832["results"]["current"]["nearStart"] = var_0;
  level._id_5832["results"]["current"]["nearEnd"] = var_1;
  level._id_5832["results"]["current"]["nearBlur"] = var_2;
  level._id_5832["results"]["current"]["farStart"] = var_3;
  level._id_5832["results"]["current"]["farEnd"] = var_4;
  level._id_5832["results"]["current"]["farBlur"] = var_5;
}

_id_5845() {
  var_0 = self playerads();

  if(var_0 <= 0.0) {
    _id_583C();
    return;
  }

  if(isDefined(level._id_4C4C)) {
    [[level._id_4C4C]]();
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

  if(isDefined(self._id_5847))
    var_12 = combineangles(self._id_5847.angles, var_11);
  else
    var_12 = var_11;

  var_13 = vectorNormalize(anglesToForward(var_12));
  var_14 = bulletTrace(var_10, var_10 + var_13 * var_1, 1, self, 1, 0, 0, 0, 0);
  var_15 = getaiarray("axis");
  var_16 = self getcurrentweapon();

  if(isDefined(level._id_1094B[var_16])) {
    [[level._id_1094B[var_16]]](var_14, var_15, var_10, var_13, var_0);
    return;
  }

  if(var_14["fraction"] == 1) {
    var_1 = 8192;
    var_17 = 1024;
    var_18 = var_1 * var_6 * 2;
  } else {
    var_1 = distance(var_10, var_14["position"]);
    var_17 = var_1 * var_4;
    var_18 = var_1 * var_6;
  }

  foreach(var_20 in var_15) {
    var_21 = var_20 _meth_819D();
    var_22 = var_20 _meth_817E(var_3);

    if(!var_21 && !var_22) {
      continue;
    }
    var_23 = vectorNormalize(var_20.origin - var_10);
    var_24 = vectordot(var_13, var_23);

    if(var_24 < 0.923) {
      continue;
    }
    var_25 = distance(var_10, var_20.origin);

    if(var_25 - 30 < var_17)
      var_17 = var_25 - 30;

    var_26 = min(var_25, var_2);

    if(var_26 + 30 > var_18)
      var_18 = var_26 + 30;
  }

  if(var_17 > var_18)
    var_17 = var_18 - 256;

  if(var_17 > var_1)
    var_17 = var_1 - 30;

  if(var_17 < 1)
    var_17 = 1;

  if(var_18 < var_1)
    var_18 = var_1;

  var_28 = var_17 * var_4;
  var_29 = var_18 * var_7;
  _id_583E(var_28, var_17, var_8, var_18, var_29, var_9, var_0);
}

_id_A43D(var_0, var_1, var_2, var_3, var_4) {
  if(var_4 < 0.88) {
    _id_583C();
    return;
  }

  var_5 = 10000;
  var_6 = -1;
  var_5 = 2400;
  var_7 = 2400;

  for(var_8 = 0; var_8 < var_1.size; var_8++) {
    var_9 = vectorNormalize(var_1[var_8].origin - var_2);
    var_10 = vectordot(var_3, var_9);

    if(var_10 < 0.923) {
      continue;
    }
    var_11 = distance(var_2, var_1[var_8].origin);

    if(var_11 < 2500)
      var_11 = 2500;

    if(var_11 - 30 < var_5)
      var_5 = var_11 - 30;

    if(var_11 + 30 > var_6)
      var_6 = var_11 + 30;
  }

  if(var_5 > var_6) {
    var_5 = 2400;
    var_6 = 3000;
  } else {
    if(var_5 < 50)
      var_5 = 50;

    if(var_6 > 2500)
      var_6 = 2500;
    else if(var_6 < 1000)
      var_6 = 1000;
  }

  var_12 = distance(var_2, var_0["position"]);

  if(var_12 < 2500)
    var_12 = 2500;

  if(var_5 > var_12)
    var_5 = var_12 - 30;

  if(var_5 < 1)
    var_5 = 1;

  if(var_6 < var_12)
    var_6 = var_12;

  if(var_7 >= var_5)
    var_7 = var_5 - 1;

  var_13 = var_6 * 4;
  var_14 = 4;
  var_15 = 1.8;
  _id_583E(var_7, var_5, var_14, var_6, var_13, var_15, var_4);
}

_id_584E() {
  for(;;) {
    scripts\engine\utility::waitframe();

    if(level._id_ABE6) {
      continue;
    }
    if(!getdvarint("scr_dof_enable")) {
      continue;
    }
    _id_5845();
    _id_5839();

    if(isDefined(self _meth_8473()))
      _id_583A("results", "current");

    var_0 = level._id_5832["results"]["current"]["nearStart"];
    var_1 = level._id_5832["results"]["current"]["nearEnd"];
    var_2 = level._id_5832["results"]["current"]["farStart"];
    var_3 = level._id_5832["results"]["current"]["farEnd"];
    var_4 = level._id_5832["results"]["current"]["nearBlur"];
    var_5 = level._id_5832["results"]["current"]["farBlur"];
    self setdepthoffield(var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

_id_11715() {
  var_0 = getDvar("r_tessellation");

  if(var_0 == "") {
    return;
  }
  level._id_11714 = spawnStruct();
  level._id_11714._id_4CA5 = getdvarfloat("r_tessellationCutoffDistanceBase", 960.0);
  level._id_11714._id_4CA6 = level._id_11714._id_4CA5;
  level._id_11714._id_4CA7 = getdvarfloat("r_tessellationCutoffFalloffBase", 320.0);
  level._id_11714._id_4CA8 = level._id_11714._id_4CA7;
  level._id_11714.time_remaining = 0.0;
  setsaveddvar("r_tessellationCutoffDistance", level._id_11714._id_4CA5);
  setsaveddvar("r_tessellationCutoffFalloff", level._id_11714._id_4CA7);

  foreach(var_2 in level.players)
  var_2 thread _id_11717();
}

_id_11716(var_0, var_1, var_2) {
  level._id_11714._id_4CA6 = var_0;
  level._id_11714._id_4CA8 = var_1;
  level._id_11714.time_remaining = var_2;
}

_id_11717() {
  for(;;) {
    var_0 = level._id_11714._id_4CA5;
    var_1 = level._id_11714._id_4CA7;
    scripts\engine\utility::waitframe();

    if(level._id_11714.time_remaining > 0.0) {
      var_2 = level._id_11714.time_remaining * 20;
      var_3 = (level._id_11714._id_4CA6 - level._id_11714._id_4CA5) / var_2;
      var_4 = (level._id_11714._id_4CA8 - level._id_11714._id_4CA7) / var_2;
      level._id_11714._id_4CA5 = level._id_11714._id_4CA5 + var_3;
      level._id_11714._id_4CA7 = level._id_11714._id_4CA7 + var_4;
      level._id_11714.time_remaining = level._id_11714.time_remaining - 0.05;
    } else {
      level._id_11714._id_4CA5 = level._id_11714._id_4CA6;
      level._id_11714._id_4CA7 = level._id_11714._id_4CA8;
    }

    if(var_0 != level._id_11714._id_4CA5)
      setsaveddvar("r_tessellationCutoffDistance", level._id_11714._id_4CA5);

    if(var_1 != level._id_11714._id_4CA7)
      setsaveddvar("r_tessellationCutoffFalloff", level._id_11714._id_4CA7);
  }
}

_id_1121E(var_0, var_1) {
  if(!isDefined(level._id_11220[var_0])) {
    return;
  }
  self notify("sunflare_start_adjust");
  self endon("sunflare_start_adjust");
  var_2 = gettime();
  var_3 = var_1 * 1000;
  var_4 = getdvarvector("r_sunflare_position", (0, 0, 0));
  var_5 = gettime() - var_2;
  var_6 = level._id_11220[var_0].position;

  for(level._id_4BC4 = var_0; var_5 < var_3; var_5 = gettime() - var_2) {
    var_6 = level._id_11220[var_0].position;
    var_7 = min(float(var_5 / var_3), 1);
    var_8 = var_4 + (var_6 - var_4) * var_7;
    setDvar("r_sunflare_position", var_8);
    setsunflareposition(var_8);
    wait 0.05;
  }

  setDvar("r_sunflare_position", level._id_11220[var_0].position);
  setsunflareposition(var_6);
}

_id_F5FD(var_0) {
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