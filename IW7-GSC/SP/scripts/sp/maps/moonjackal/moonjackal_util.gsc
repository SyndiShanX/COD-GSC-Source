/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\moonjackal\moonjackal_util.gsc
**********************************************************/

_id_48BF(var_0) {
  if(!isDefined(level.allies))
    level.allies = [];

  if(!isDefined(var_0))
    var_0 = ["salter", "eth3n"];

  foreach(var_2 in var_0) {
    if(isDefined(level.allies[var_2]) && isalive(level.allies[var_2])) {
      continue;
    }
    level.allies[var_2] = scripts\sp\utility::_id_107EA(var_2, 1);
    level.allies[var_2] scripts\sp\utility::_id_B14F();
    level.allies[var_2] scripts\sp\utility::_id_5564();
    level.allies[var_2] _meth_8250(0);
    level.allies[var_2]._id_1FBB = var_2;

    if(var_2 == "salter") {
      level.allies["salter"].name = "Lt. Salter";
      continue;
    }

    if(var_2 == "eth3n")
      level.allies["eth3n"].name = "Eth.3n";
  }
}

_id_13248() {
  self endon("death");

  if(!isDefined(level._id_118DC))
    level._id_118DC = gettime() / 1000;

  for(var_0 = self._id_4BF7; isDefined(self) && isDefined(self._id_4BF7); var_7 = abs(var_2 - _id_13247())) {
    if(!isDefined(var_0.target)) {
      return;
    }
    if(isDefined(var_0.script_parameters) && var_0.script_parameters == "end_vehicle_time_sync") {
      self vehicle_setspeedimmediate(0, 50, 50);
      return;
    }

    var_1 = getvehiclenode(var_0.target, "targetname");

    if(!isDefined(var_1)) {
      return;
    }
    var_2 = var_1._id_EEBF;

    if(!isDefined(var_2)) {
      return;
    }
    var_3 = _id_13247();
    var_4 = var_2 - var_3;
    var_5 = distance(self.origin, var_1.origin);
    var_6 = var_5 / var_4 / 17.6;

    if(var_6 < 0)
      var_6 = 10;

    self vehicle_setspeed(var_6, var_6 / 4, var_6 / 4);

    while(self._id_4BF7 == var_0)
      wait 0.05;

    var_5 = distance(self.origin, self._id_4BF7.origin);
    var_0 = self._id_4BF7;
  }
}

_id_13247() {
  return gettime() / 1000 - level._id_118DC;
}

_id_13249(var_0) {
  while(_id_13247() < var_0)
    wait 0.05;
}

_id_16BD(var_0, var_1, var_2) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level._id_4EC3))
    level._id_4EC3 = [];

  var_3 = "^3";

  if(isDefined(var_2)) {
    switch (var_2) {
      case "red":
      case "r":
        var_3 = "^1";
        break;
      case "green":
      case "g":
        var_3 = "^2";
        break;
      case "yellow":
      case "y":
        var_3 = "^3";
        break;
      case "blue":
      case "b":
        var_3 = "^4";
        break;
      case "cyan":
      case "c":
        var_3 = "^5";
        break;
      case "purple":
      case "p":
        var_3 = "^6";
        break;
      case "white":
      case "w":
        var_3 = "^7";
        break;
      case "bl":
      case "black":
        var_3 = "^8";
        break;
    }
  }

  var_4 = scripts\sp\hud_util::createfontstring("default", 1.5);
  var_4.location = 0;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.foreground = 1;
  var_4.sort = 20;
  var_4.alpha = 0;
  var_4 fadeovertime(0.5);
  var_4.alpha = 1;
  var_4.x = 40;
  var_4.y = 325;
  var_4.label = " " + var_3 + "< " + var_0 + " > ^7" + var_1;
  var_4.color = (1, 1, 1);
  level._id_4EC3 = scripts\engine\utility::array_insert(level._id_4EC3, var_4, 0);

  foreach(var_7, var_6 in level._id_4EC3) {
    if(var_7 == 0) {
      continue;
    }
    if(isDefined(var_6))
      var_6.y = 325 - var_7 * 18;
  }

  wait 2;
  var_8 = 40;
  var_4 fadeovertime(3);
  var_4.alpha = 0;

  for(var_7 = 0; var_7 < var_8; var_7++) {
    var_4.color = (1, 1, 0 / (var_8 - var_7));
    wait 0.05;
  }

  wait 4;
  var_4 destroy();
  scripts\engine\utility::array_removeundefined(level._id_4EC3);
}

_id_EF4B(var_0) {
  if(isDefined(anim._id_EF75) && isDefined(anim._id_EF74)) {
    if(anim._id_EF75 + anim._id_EF74 > gettime())
      return 0;
  }

  for(var_1 = 0; var_1 < 40; var_1++) {
    if(anim.isteamspeaking["allies"]) {
      scripts\engine\utility::waitframe();
      continue;
    }

    scripts\sp\utility::_id_10350(var_0);
    return 1;
  }

  return 0;
}

_id_3C44(var_0, var_1) {
  level notify("new_map_sunangles");
  level endon("new_map_sunangles");

  if(var_1 <= 0.05) {
    _id_3C45(var_0);
    return;
  }

  var_2 = level._id_111D0._id_1120D;
  var_3 = anglesToForward(level._id_111D0._id_1120D);
  var_4 = anglestoright(level._id_111D0._id_1120D);
  var_5 = anglestoup(level._id_111D0._id_1120D);
  var_6 = anglesToForward(var_0);
  var_7 = anglestoright(var_0);
  var_8 = anglestoup(var_0);
  var_9 = var_6 - var_3;
  var_10 = var_7 - var_4;
  var_11 = var_8 - var_5;
  var_12 = var_9 * (1 / (var_1 + 0.05) * 0.05);
  var_13 = var_10 * (1 / (var_1 + 0.05) * 0.05);
  var_14 = var_11 * (1 / (var_1 + 0.05) * 0.05);

  while(var_1 > 0) {
    var_1 = var_1 - 0.05;
    var_3 = var_3 + var_12;
    var_4 = var_4 + var_13;
    var_5 = var_5 + var_14;
    var_2 = axistoangles(vectorNormalize(var_3), vectorNormalize(var_4), vectorNormalize(var_5));
    _id_3C45(var_2);
    wait 0.05;
  }

  _id_3C45(var_0);
}

_id_3C47(var_0, var_1) {
  level notify("new_map_sunfx_offset");
  level endon("new_map_sunfx_offset");

  if(var_1 <= 0.05) {
    level._id_111D0._id_75AC = var_0;
    return;
  }

  var_2 = level._id_111D0._id_75AC;
  var_3 = anglesToForward(level._id_111D0._id_75AC);
  var_4 = anglestoright(level._id_111D0._id_75AC);
  var_5 = anglestoup(level._id_111D0._id_75AC);
  var_6 = anglesToForward(var_0);
  var_7 = anglestoright(var_0);
  var_8 = anglestoup(var_0);
  var_9 = var_6 - var_3;
  var_10 = var_7 - var_4;
  var_11 = var_8 - var_5;
  var_12 = var_9 * (1 / (var_1 + 0.05) * 0.05);
  var_13 = var_10 * (1 / (var_1 + 0.05) * 0.05);
  var_14 = var_11 * (1 / (var_1 + 0.05) * 0.05);

  while(var_1 > 0) {
    var_1 = var_1 - 0.05;
    var_3 = var_3 + var_12;
    var_4 = var_4 + var_13;
    var_5 = var_5 + var_14;
    var_2 = axistoangles(vectorNormalize(var_3), vectorNormalize(var_4), vectorNormalize(var_5));
    level._id_111D0._id_75AC = var_2;
    wait 0.05;
  }

  level._id_111D0._id_75AC = var_0;
}

_id_3C45(var_0) {
  lerpsunangles(level._id_111D0._id_1120D, var_0, 0.05);
  level._id_111D0._id_1120D = var_0;
}

_id_AB9F(var_0, var_1) {
  var_2 = int(var_0 * 20);

  if(isDefined(level._id_111D0) && isDefined(level._id_111D0._id_99E5))
    var_3 = level._id_111D0._id_99E5;
  else {
    var_3 = getmapsuncolorandintensity();
    var_3 = var_3[3];
  }

  if(var_2 > 0) {
    var_4 = (var_1 - var_3) / var_2;

    for(var_5 = 0; var_5 < var_2; var_5++) {
      var_1 = var_3 + var_5 * var_4;
      setsuncolorandintensity(var_1);

      if(isDefined(level._id_111D0) && isDefined(level._id_111D0._id_99E5))
        level._id_111D0._id_99E5 = var_1;

      wait 0.05;
    }
  }

  if(isDefined(level._id_111D0) && isDefined(level._id_111D0._id_99E5))
    level._id_111D0._id_99E5 = var_1;

  setsuncolorandintensity(var_1);
}

sunsettings_dogfight(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  thread scripts\sp\utility::_id_AB9A("sm_sunSampleSizeNear", 9.82, var_0);
  setsaveddvar("sm_suncascadeSizeMultiplier1", 3);
  thread _id_AB9F(var_0, level._id_111D0.final_intensity);
}

capitalship_dontcastshadows_moonjackal() {
  self dontcastshadows();

  if(isDefined(self._id_EF3C)) {
    foreach(var_1 in self._id_EF3C)
    var_1 dontcastshadows();
  }

  foreach(var_4 in self._id_8B4F) {
    foreach(var_6 in var_4) {
      if(isDefined(var_6) && !isstruct(var_6))
        var_6 dontcastshadows();
    }
  }

  foreach(var_10 in self.turrets) {
    foreach(var_12 in var_10) {
      if(isDefined(var_12) && !isent(var_12))
        var_12 dontcastshadows();
    }
  }
}