/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1276.gsc
*********************************************/

func_3213(param_00) {
  lib_04FF::func_6934(param_00);
  lib_04FF::func_6965("objectiveScoreGoal", 24);
  lib_04FF::func_6965("secondsBetweenPoints", 5);
  lib_04FF::func_6965("pointsPerSiteOwned", 1);
  lib_04FF::func_6963("captureTime", 3, [1, 2, 3, 5, 7.5, 10]);
  self.var_321D = [];
  var_01 = common_scripts\utility::func_46B7(self.var_1A2, "targetname");
  var_02 = getEntArray(self.var_1A2, "targetname");
  self.var_321D = common_scripts\utility::func_F73(var_01, var_02);
  foreach(var_04 in self.var_321D) {
    var_04 thread func_3215(self);
  }

  thread func_3214();
}

func_3214() {
  self endon("end_think");
  lib_04FF::func_6983(self.var_695A);
  foreach(var_01 in self.var_321D) {
    var_01 notify("objStart");
  }

  var_03 = lib_04FF::func_6939();
  var_03.var_E5 = &"RAIDS_RESUPPLY_BAR_FUEL_A";
  var_04 = lib_04FF::func_6938();
  lib_04FF::func_A177(var_03, 0);
  var_05 = 0;
  for(;;) {
    var_06 = 0;
    foreach(var_01 in self.var_321D) {
      if(isDefined(var_01.var_695D) && var_01.var_695D.var_6DB2 == game["attackers"]) {
        var_06 = var_06 + lib_04FF::func_45D0("pointsPerSiteOwned");
      }
    }

    var_05 = var_05 + var_06;
    var_09 = clamp(var_05 / lib_04FF::func_45D0("objectiveScoreGoal"), 0, 1);
    lib_04FF::func_A177(var_03, var_09);
    lib_04FF::func_A0E4(var_04, var_09);
    if(var_05 >= lib_04FF::func_45D0("objectiveScoreGoal")) {
      lib_04FF::func_6935(self.var_695A);
      wait(1);
      var_03 maps\mp\gametypes\_hud_util::func_2DCC();
      var_04 maps\mp\gametypes\_hud_util::func_2DCC();
      return;
    }

    wait(lib_04FF::func_45D0("secondsBetweenPoints"));
  }
}

func_3215(param_00) {
  self.var_2459 = param_00;
  lib_04FF::func_6983(self.var_2459.var_695A);
  var_01 = lib_04FF::func_45CE(self);
  var_02 = maps\mp\gametypes\_gameobjects::func_2837(game["defenders"], self, [], var_01, 0, 1);
  var_02 maps\mp\gametypes\_gameobjects::func_C30("enemy");
  var_02 maps\mp\gametypes\_gameobjects::func_8A5A(self.var_2459 lib_04FF::func_45D0("captureTime"));
  var_02 maps\mp\gametypes\_gameobjects::func_8A59(&"MP_SECURING_POSITION");
  var_03 = var_02 maps\mp\gametypes\_gameobjects::func_454C();
  var_02.var_E5 = var_03;
  var_02.var_230F = game["defenders"];
  var_02 maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_defend");
  var_02 maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_defend");
  var_02 maps\mp\gametypes\_gameobjects::func_860A("enemy", "waypoint_captureneutral");
  var_02 maps\mp\gametypes\_gameobjects::func_860E("enemy", "waypoint_captureneutral");
  var_02 maps\mp\gametypes\_gameobjects::func_8A60("any");
  var_02.var_6BBF = ::func_6BBF;
  var_02.var_6ABC = ::func_6ABC;
  var_02.var_6BCB = ::func_6BCB;
  var_02.var_6AFA = ::func_6AFA;
  var_02.var_681A = 0;
  var_02.var_502A = "domFlag";
  var_02.var_4B25 = 0;
  var_02.var_3C66 = 1;
  self.var_695D = var_02;
  lib_04FF::func_6982(self.var_2459.var_695A);
  self notify("end_think");
  self notify("end_hud");
  var_02 maps\mp\gametypes\_gameobjects::func_2F93();
  var_02 maps\mp\gametypes\_gameobjects::deleteuseobjectobjectives();
  waittillframeend;
  var_02 maps\mp\gametypes\_gameobjects::func_2D58();
}

func_6BBF(param_00) {
  var_01 = gettime();
  var_02 = param_00.var_1A7;
  var_03 = maps\mp\gametypes\_gameobjects::func_45F7();
  self.var_1FC1 = gettime();
  self.var_4B25 = 1;
  if(isDefined(self.var_6DA8)) {
    self.var_6DA9 = 0;
  } else {
    self.var_6DA9 = 1;
  }

  maps\mp\gametypes\_gameobjects::func_86EC(var_02);
  maps\mp\gametypes\_gameobjects::func_860A("enemy", "waypoint_capture" + self.var_E5);
  maps\mp\gametypes\_gameobjects::func_860E("enemy", "waypoint_capture" + self.var_E5);
  maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_defend" + self.var_E5);
  maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_defend" + self.var_E5);
}

func_6ABC(param_00) {
  var_01 = maps\mp\gametypes\_gameobjects::func_45F7();
  self.var_2EE9 = 0;
  self.var_2950 = 0;
}

func_6BCB(param_00, param_01, param_02) {
  var_03 = maps\mp\gametypes\_gameobjects::func_45F7();
  if(isDefined(self.var_915C)) {
    if(self.var_2950 != self.var_915C) {
      self.var_2950 = self.var_915C;
      if(var_03 == "neutral") {
        func_1FB9();
      } else {
        func_1FC0();
      }
    }
  }

  if(param_01 > 0.05 && param_02 && !self.var_2EE9) {
    if(var_03 == "neutral") {
      if(param_00 == "allies") {} else {}

      func_1FB9();
    } else {
      if(var_03 == "allies") {} else {}

      func_1FC0();
    }

    self.var_2EE9 = 1;
  }
}

func_6AFA(param_00, param_01, param_02) {
  if(isPlayer(param_01)) {
    param_01 setclientomnvar("ui_capture_icon", 0);
    param_01 setclientomnvar("ui_capture_status_index", 0);
  }

  var_03 = maps\mp\gametypes\_gameobjects::func_45F7();
  if(var_03 != "neutral") {
    maps\mp\gametypes\_gameobjects::func_860A("enemy", "waypoint_capture" + self.var_E5);
    maps\mp\gametypes\_gameobjects::func_860E("enemy", "waypoint_capture" + self.var_E5);
    maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_defend" + self.var_E5);
    maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_defend" + self.var_E5);
    return;
  }

  maps\mp\gametypes\_gameobjects::func_860A("enemy", "waypoint_capture" + self.var_E5);
  maps\mp\gametypes\_gameobjects::func_860E("enemy", "waypoint_capture" + self.var_E5);
  maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_capture" + self.var_E5);
  maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_capture" + self.var_E5);
}

func_1FB9() {
  if(isDefined(self.var_915C) && self.var_915C) {
    maps\mp\gametypes\_gameobjects::func_860A("enemy", "waypoint_contested" + self.var_E5);
    maps\mp\gametypes\_gameobjects::func_860E("enemy", "waypoint_contested" + self.var_E5);
    maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_contested" + self.var_E5);
    maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_contested" + self.var_E5);
    return;
  }

  maps\mp\gametypes\_gameobjects::func_860A("enemy", "waypoint_taking" + self.var_E5);
  maps\mp\gametypes\_gameobjects::func_860E("enemy", "waypoint_taking" + self.var_E5);
  maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_losing" + self.var_E5);
  maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_losing" + self.var_E5);
}

func_1FC0() {
  if(isDefined(self.var_915C) && self.var_915C) {
    maps\mp\gametypes\_gameobjects::func_860A("enemy", "waypoint_contested" + self.var_E5);
    maps\mp\gametypes\_gameobjects::func_860E("enemy", "waypoint_contested" + self.var_E5);
    maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_contested" + self.var_E5);
    maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_contested" + self.var_E5);
    return;
  }

  maps\mp\gametypes\_gameobjects::func_860A("enemy", "waypoint_taking" + self.var_E5);
  maps\mp\gametypes\_gameobjects::func_860E("enemy", "waypoint_taking" + self.var_E5);
  maps\mp\gametypes\_gameobjects::func_860A("friendly", "waypoint_losing" + self.var_E5);
  maps\mp\gametypes\_gameobjects::func_860E("friendly", "waypoint_losing" + self.var_E5);
}

func_933E(param_00, param_01, param_02) {
  var_03 = gettime();
  if(gettime() < level.var_5BFF[param_01] + 5000 && !isDefined(param_02) || !param_02) {
    return;
  }

  thread func_2CDB(param_00, param_01);
  level.var_5BFF[param_01] = gettime();
}

func_2CDB(param_00, param_01) {
  level endon("game_ended");
  wait(0.1);
  maps\mp\_utility::func_A790();
  maps\mp\_utility::func_5C39(param_00, param_01);
}