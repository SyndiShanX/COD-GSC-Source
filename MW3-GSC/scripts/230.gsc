/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\230.gsc
**************************************/

main() {
  if(getDvar("scr_cmd_plr_sun") == "") {}

  if(getDvar("scr_dof_enable") == "") {
    setsaveddvar("scr_dof_enable", "1");
  }
  if(getDvar("scr_cinematic_autofocus") == "") {
    setDvar("scr_cinematic_autofocus", "1");
  }
  setdvarifuninitialized("scr_glowTweakEnable", 1);
  setdvarifuninitialized("scr_glowTweakRadius0", 7);
  setdvarifuninitialized("scr_glowTweakBloomCutoff", 0.99);
  setdvarifuninitialized("scr_glowTweakBloomDesaturation", 0.65);
  setdvarifuninitialized("scr_glowTweakBloomIntensity0", 0.36);
  setdvarifuninitialized("scr_filmTweakEnable", 1);
  setdvarifuninitialized("scr_filmTweakContrast", 1.45);
  setdvarifuninitialized("scr_filmTweakBrightness", 0.15);
  setdvarifuninitialized("scr_filmTweakDesaturation", 0.4);
  setdvarifuninitialized("scr_filmTweakDesaturationDark", 0.4);
  setdvarifuninitialized("scr_filmTweakInvert", 0);
  setdvarifuninitialized("scr_filmTweakLightTint", "1.14 1.07 0.877");
  setdvarifuninitialized("scr_filmTweakMediumTint", "1.16 .74 .69");
  setdvarifuninitialized("scr_filmTweakDarkTint", "0.7 0.76 0.86");
  setdvarifuninitialized("scr_primaryLightUseTweaks", 1);
  setdvarifuninitialized("scr_primaryLightTweakDiffuseStrength", 1);
  setdvarifuninitialized("scr_primaryLightTweakSpecularStrength", 1);
  level._id_1ADE = 0;
  level._id_1436["nearStart"] = 1;
  level._id_1436["nearEnd"] = 1;
  level._id_1436["farStart"] = 500;
  level._id_1436["farEnd"] = 500;
  level._id_1436["nearBlur"] = 4.5;
  level._id_1436["farBlur"] = 0.05;
  precachemenu("dev_vision_noloc");
  precachemenu("dev_vision_exec");
  var_0 = getdvarint("scr_dof_enable");
  level._id_1ADF = [];
  level._id_1AE0 = [];

  if(!isDefined(level._id_1AE1)) {
    level._id_1AE1 = [];
  }
  if(!isDefined(level._id_1AE2)) {
    level._id_1AE2 = spawnStruct();
    level._id_1AE2._id_1AE3 = "";
    level._id_1AE2.time = 0;
  }

  if(!isDefined(level._id_1AE4)) {
    level._id_1AE4 = [];
    _id_1B11(level.script);
    common_scripts\_artcommon::setfogsliders();
  }

  foreach(var_3, var_2 in level._id_1AE4) {}
  _id_1AE8(var_3);

  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    var_5 = level.players[var_4];
    var_5._id_1AE5 = (level._id_1436["farStart"] - level._id_1436["nearEnd"]) / 2;

    if(var_0) {
      var_5 thread _id_1B20();
    }
  }

  thread tweakart();

  if(!isDefined(level.script)) {
    level.script = tolower(getDvar("mapname"));
  }
}

tweakart() {}

_id_1AE7(var_0, var_1) {
  var_2 = level.player buttonPressed(var_0);

  if(!var_2) {
    var_2 = level.player buttonPressed(var_1);
  }
  if(!isDefined(level._id_1AE0[var_0])) {
    level._id_1AE0[var_0] = 0;
  }
  if(gettime() < level._id_1AE0[var_0]) {
    return 0;
  }
  level._id_1AE0[var_0] = gettime() + 400;
  return var_2;
}

_id_1AE8(var_0) {
  if(!isDefined(level._id_1AE1)) {
    level._id_1AE1 = [];
  }
  var_1 = spawnStruct();
  var_1.name = var_0;
  level._id_1AE1[var_0] = var_1;
  return var_1;
}

_id_1AE9() {
  if(!isDefined(level._id_1AE4)) {}

  var_0 = level._id_1AE4[level._id_1AE2._id_1AE3];

  if(isDefined(var_0.name)) {
    var_0.startdist = level.fognearplane;
    var_0.halfwaydist = level.fogexphalfplane;
    var_0.red = level.fogcolor[0];
    var_0.green = level.fogcolor[1];
    var_0.blue = level.fogcolor[2];
    var_0.maxopacity = level.fogmaxopacity;
    var_0.sunfogenabled = 0;

    if(level.sunfogenabled) {
      var_0.sunfogenabled = 1;
      var_0._id_1AF0 = level.sunfogcolor[0];
      var_0._id_1AF1 = level.sunfogcolor[1];
      var_0._id_1AF2 = level.sunfogcolor[2];
      var_0._id_1AF3 = level.sunfogdir;
      var_0._id_1AF4 = level.sunfogbeginfadeangle;
      var_0._id_1AF5 = level.sunfogendfadeangle;
      var_0._id_1AF6 = level.sunfogscale;
    }

    if(getdvarint("scr_fog_disable")) {
      var_0.startdist = 1215752192;
      var_0.halfwaydist = 1215752193;
      var_0.red = 0;
      var_0.green = 0;
      var_0.blue = 0;
      var_0.maxopacity = 0;
    }

    maps\_utility::_id_1AF7(var_0, 0);
  }
}

_id_1AF8() {
  if(!isDefined(level._id_1AE1)) {
    return;
  }
  if(!isDefined(level._id_1AE2)) {
    return;
  }
  if(!isDefined(level._id_1AE2._id_1AE3)) {
    return;
  }
  if(!isDefined(level._id_1AE1[level._id_1AE2._id_1AE3])) {
    return;
  }
  var_0 = level._id_1AE1[level._id_1AE2._id_1AE3];

  if(!isDefined(var_0._id_1AF9)) {
    return;
  }
  var_0._id_1AFA = getDvar("r_glowTweakEnable");
  var_0._id_1AFB = getDvar("r_glowTweakRadius0");
  var_0._id_1AFC = getDvar("r_glowTweakBloomCutoff");
  var_0._id_1AFD = getDvar("r_glowTweakBloomDesaturation");
  var_0._id_1AFE = getDvar("r_glowTweakBloomIntensity0");
  var_0._id_1AFF = getDvar("r_filmTweakEnable");
  var_0._id_1B00 = getDvar("r_filmTweakContrast");
  var_0._id_1B01 = getDvar("r_filmTweakBrightness");
  var_0._id_1B02 = getDvar("r_filmTweakDesaturation");
  var_0._id_1B03 = getDvar("r_filmTweakDesaturationDark");
  var_0._id_1B04 = getDvar("r_filmTweakInvert");
  var_0._id_1B05 = getDvar("r_filmTweakLightTint");
  var_0._id_1B06 = getDvar("r_filmTweakMediumTint");
  var_0._id_1B07 = getDvar("r_filmTweakDarkTint");
  var_0._id_1B08 = getDvar("r_primaryLightUseTweaks");
  var_0._id_1B09 = getDvar("r_primaryLightTweakDiffuseStrength");
  var_0._id_1B0A = getDvar("r_primaryLightTweakSpecularStrength");
}

fovslidercheck() {
  if(level._id_1436["nearStart"] >= level._id_1436["nearEnd"]) {
    level._id_1436["nearStart"] = level._id_1436["nearEnd"] - 1;
    setDvar("scr_dof_nearStart", level._id_1436["nearStart"]);
  }

  if(level._id_1436["nearEnd"] <= level._id_1436["nearStart"]) {
    level._id_1436["nearEnd"] = level._id_1436["nearStart"] + 1;
    setDvar("scr_dof_nearEnd", level._id_1436["nearEnd"]);
  }

  if(level._id_1436["farStart"] >= level._id_1436["farEnd"]) {
    level._id_1436["farStart"] = level._id_1436["farEnd"] - 1;
    setDvar("scr_dof_farStart", level._id_1436["farStart"]);
  }

  if(level._id_1436["farEnd"] <= level._id_1436["farStart"]) {
    level._id_1436["farEnd"] = level._id_1436["farStart"] + 1;
    setDvar("scr_dof_farEnd", level._id_1436["farEnd"]);
  }

  if(level._id_1436["farBlur"] >= level._id_1436["nearBlur"]) {
    level._id_1436["farBlur"] = level._id_1436["nearBlur"] - 0.1;
    setDvar("scr_dof_farBlur", level._id_1436["farBlur"]);
  }

  if(level._id_1436["farStart"] <= level._id_1436["nearEnd"]) {
    level._id_1436["farStart"] = level._id_1436["nearEnd"] + 1;
    setDvar("scr_dof_farStart", level._id_1436["farStart"]);
  }
}

_id_1B0C() {
  if(level.sunfogbeginfadeangle >= level.sunfogendfadeangle) {
    level.sunfogbeginfadeangle = level.sunfogendfadeangle - 1;
    setDvar("scr_sunFogBeginFadeAngle", level.sunfogbeginfadeangle);
  }

  if(level.sunfogendfadeangle <= level.sunfogbeginfadeangle) {
    level.sunfogendfadeangle = level.sunfogbeginfadeangle + 1;
    setDvar("scr_sunFogEndFadeAngle", level.sunfogendfadeangle);
  }
}

_id_1B0D() {
  if(!isDefined(level._id_1AE4)) {
    level._id_1AE4 = [];
  }
  var_0 = getEntArray("trigger_multiple_visionset", "classname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_visionset)) {
      _id_1B10(var_2.script_visionset);
    }
    if(isDefined(var_2._id_1B0E)) {
      _id_1B10(var_2._id_1B0E);
    }
    if(isDefined(var_2._id_1B0F)) {
      _id_1B10(var_2._id_1B0F);
    }
  }
}

_id_1B10(var_0) {
  if(isDefined(level._id_1AE4[var_0])) {
    return;
  }
  _id_1B11(var_0);
  _id_1AE8(var_0);
  iprintlnbold("new vision: " + var_0);
}

_id_1B11(var_0) {
  var_1 = maps\_utility::create_vision_set_fog(var_0);
  var_1.startdist = 3764.17;
  var_1.halfwaydist = 19391;
  var_1.red = 0.661137;
  var_1.green = 0.554261;
  var_1.blue = 0.454014;
  var_1.maxopacity = 0.7;
  var_1.transitiontime = 0;
}

dumpsettings() {}

_id_1B15() {
  var_0 = level._id_1AE1[level._id_1AE2._id_1AE3];

  if(!isDefined(var_0.name)) {
    return;
  }
  common_scripts\utility:: fileprint_launcher_start_file();
    common_scripts\utility:: fileprint_launcher("r_glow\"" + getDvar("r_glowTweakEnable") + "\"");
    common_scripts\utility:: fileprint_launcher("r_glowRadius0 \"" + getDvar("r_glowTweakRadius0") + "\"");
    common_scripts\utility:: fileprint_launcher("r_glowBloomCutoff \"" + getDvar("r_glowTweakBloomCutoff") + "\"");
    common_scripts\utility:: fileprint_launcher("r_glowBloomDesaturation \"" + getDvar("r_glowTweakBloomDesaturation") + "\"");
    common_scripts\utility:: fileprint_launcher("r_glowBloomIntensity0 \"" + getDvar("r_glowTweakBloomIntensity0") + "\"");
    common_scripts\utility:: fileprint_launcher(" ");
    common_scripts\utility:: fileprint_launcher("r_filmEnable\"" + getDvar("r_filmTweakEnable") + "\"");
    common_scripts\utility:: fileprint_launcher("r_filmContrast\"" + getDvar("r_filmTweakContrast") + "\"");
    common_scripts\utility:: fileprint_launcher("r_filmBrightness\"" + getDvar("r_filmTweakBrightness") + "\"");
    common_scripts\utility:: fileprint_launcher("r_filmDesaturation\"" + getDvar("r_filmTweakDesaturation") + "\"");
    common_scripts\utility:: fileprint_launcher("r_filmDesaturationDark\"" + getDvar("r_filmTweakDesaturationDark") + "\"");
    common_scripts\utility:: fileprint_launcher("r_filmInvert\"" + getDvar("r_filmTweakInvert") + "\"");
    common_scripts\utility:: fileprint_launcher("r_filmLightTint \"" + getDvar("r_filmTweakLightTint") + "\"");
    common_scripts\utility:: fileprint_launcher("r_filmMediumTint\"" + getDvar("r_filmTweakMediumTint") + "\"");
    common_scripts\utility:: fileprint_launcher("r_filmDarkTint\"" + getDvar("r_filmTweakDarkTint") + "\"");
    common_scripts\utility:: fileprint_launcher(" ");
    common_scripts\utility:: fileprint_launcher("r_primaryLightUseTweaks\"" + getDvar("r_primaryLightUseTweaks") + "\"");
    common_scripts\utility:: fileprint_launcher("r_primaryLightTweakDiffuseStrength \"" + getDvar("r_primaryLightTweakDiffuseStrength") + "\"");
    common_scripts\utility:: fileprint_launcher("r_primaryLightTweakSpecularStrength\"" + getDvar("r_primaryLightTweakSpecularStrength") + "\"");
    common_scripts\utility:: fileprint_launcher_end_file("\\share\\raw\\vision\\" + var_0.name + ".vision", 1);
}

_id_1B16() {
  foreach(var_1 in level._id_1AE4) {
    if(!isDefined(var_1.name)) {
      continue;
    }
    common_scripts\utility:: fileprint_launcher("\tent = maps\\_utility::create_vision_set_fog( \"" + var_1.name + "\" );");

      if(isDefined(var_1.startdist)) {
        common_scripts\utility:: fileprint_launcher("\tent.startDist = " + var_1.startdist + ";");
      }
    if(isDefined(var_1.halfwaydist)) {
      common_scripts\utility:: fileprint_launcher("\tent.halfwayDist = " + var_1.halfwaydist + ";");
    }
    if(isDefined(var_1.red)) {
      common_scripts\utility:: fileprint_launcher("\tent.red = " + var_1.red + ";");
    }
    if(isDefined(var_1.green)) {
      common_scripts\utility:: fileprint_launcher("\tent.green = " + var_1.green + ";");
    }
    if(isDefined(var_1.blue)) {
      common_scripts\utility:: fileprint_launcher("\tent.blue = " + var_1.blue + ";");
    }
    if(isDefined(var_1.maxopacity)) {
      common_scripts\utility:: fileprint_launcher("\tent.maxOpacity = " + var_1.maxopacity + ";");
    }
    if(isDefined(var_1.transitiontime)) {
      common_scripts\utility:: fileprint_launcher("\tent.transitionTime = " + var_1.transitiontime + ";");
    }
    if(isDefined(var_1.sunfogenabled)) {
      common_scripts\utility:: fileprint_launcher("\tent.sunFogEnabled = " + var_1.sunfogenabled + ";");
    }
    if(isDefined(var_1._id_1AF0)) {
      common_scripts\utility:: fileprint_launcher("\tent.sunRed = " + var_1._id_1AF0 + ";");
    }
    if(isDefined(var_1._id_1AF1)) {
      common_scripts\utility:: fileprint_launcher("\tent.sunGreen = " + var_1._id_1AF1 + ";");
    }
    if(isDefined(var_1._id_1AF2)) {
      common_scripts\utility:: fileprint_launcher("\tent.sunBlue = " + var_1._id_1AF2 + ";");
    }
    if(isDefined(var_1._id_1AF3)) {
      common_scripts\utility:: fileprint_launcher("\tent.sunDir = " + var_1._id_1AF3 + ";");
    }
    if(isDefined(var_1._id_1AF4)) {
      common_scripts\utility:: fileprint_launcher("\tent.sunBeginFadeAngle = " + var_1._id_1AF4 + ";");
    }
    if(isDefined(var_1._id_1AF5)) {
      common_scripts\utility:: fileprint_launcher("\tent.sunEndFadeAngle = " + var_1._id_1AF5 + ";");
    }
    if(isDefined(var_1._id_1AF6)) {
      common_scripts\utility:: fileprint_launcher("\tent.normalFogScale = " + var_1._id_1AF6 + ";");
    }
    common_scripts\utility:: fileprint_launcher(" ");
  }
}

_id_1B17() {
  foreach(var_1 in level._id_1AE4) {
    if(!isDefined(var_1.name)) {
      continue;
    }
    common_scripts\utility:: fileprint_launcher("rawfile,vision/" + var_1.name + ".vision");
  }
}

_id_1B18(var_0, var_1, var_2, var_3) {
  level._id_1B19 = var_0;
  level._id_1B1A = var_1;
  level._id_1B1B = var_2;
  level._id_1B1C = var_3;
  setDvar("r_lighttweaksunlight", level._id_1B1A);
  setDvar("r_lighttweakdiffusefraction", level._id_1B1C);
  var_4 = "up";

  for(;;) {
    var_5 = getdvarfloat("r_lighttweaksunlight");
    var_6 = scale(1 + randomint(21));
    var_7 = randomint(2);

    if(var_7) {
      var_6 = var_6 * -1;
    }
    if(var_4 == "up") {
      var_8 = var_5 + scale(30) + var_6;
    } else {
      var_8 = var_5 - scale(30) + var_6;
    }
    if(var_8 >= level._id_1B19) {
      var_8 = level._id_1B19;
      var_4 = "down";
    }

    if(var_8 <= level._id_1B1A) {
      var_8 = level._id_1B1A;
      var_4 = "up";
    }

    if(var_8 > var_5) {
      _id_1B1D(var_8, 3 + randomint(3), 0.05);
      continue;
    }

    _id_1B1E(var_8, 3 + randomint(3), 0.05);
  }
}

_id_1B1D(var_0, var_1, var_2) {
  var_3 = getdvarfloat("r_lighttweaksunlight");
  var_4 = var_0 - var_3;
  var_5 = var_4 / (var_1 / var_2);

  while(var_1 > 0) {
    var_1 = var_1 - var_2;
    var_3 = var_3 + var_5;
    setDvar("r_lighttweaksunlight", var_3);
    var_6 = (var_3 - level._id_1B1A) / (level._id_1B19 - level._id_1B1A);
    var_7 = level._id_1B1B + (level._id_1B1C - level._id_1B1B) * var_6;
    setDvar("r_lighttweakdiffusefraction", var_7);
    wait(var_2);
  }
}

_id_1B1E(var_0, var_1, var_2) {
  var_3 = getdvarfloat("r_lighttweaksunlight");
  var_4 = var_3 - var_0;
  var_5 = var_4 / (var_1 / var_2);

  while(var_1 > 0) {
    var_1 = var_1 - var_2;
    var_3 = var_3 - var_5;
    setDvar("r_lighttweaksunlight", var_3);
    var_6 = (var_3 - level._id_1B1A) / (level._id_1B19 - level._id_1B1A);
    var_7 = level._id_1B1B + (level._id_1B1C - level._id_1B1B) * var_6;
    setDvar("r_lighttweakdiffusefraction", var_7);
    wait(var_2);
  }
}

scale(var_0) {
  var_1 = var_0 / 100;
  return level._id_1B1A + var_1 * (level._id_1B19 - level._id_1B1A) - level._id_1B1A;
}

_id_1B20() {
  self._id_1B21 = level._id_1436;
  var_0 = 0;

  for(;;) {
    wait 0.05;

    if(level._id_1B22) {
      continue;
    }
    if(getdvarint("scr_cinematic")) {
      _id_1B23();
      continue;
    }

    if(getdvarint("scr_dof_enable") && !var_0) {
      _id_1B24();
      continue;
    }

    _id_1B2A();
  }
}

_id_1B23() {
  var_0 = self playerads();

  if(var_0 == 1 && getdvarint("scr_cinematic_autofocus")) {
    var_1 = vectornormalize(anglesToForward(self getplayerangles()));
    var_2 = bulletTrace(self getEye(), self getEye() + var_1 * 100000, 1, self);
    var_3 = getaiarray();
    var_4 = 10000;
    var_5 = -1;
    var_6 = self getEye();
    var_7 = self getplayerangles();
    var_8 = 0;
    var_9 = undefined;

    for(var_10 = 0; var_10 < var_3.size; var_10++) {
      var_11 = var_3[var_10].origin;
      var_12 = vectornormalize(var_11 - var_6);
      var_13 = anglesToForward(var_7);
      var_14 = vectordot(var_13, var_12);

      if(var_14 > var_8) {
        var_8 = var_14;
        var_9 = var_3[var_10].origin;
      }
    }

    if(var_8 < 0.923) {
      var_15 = distance(var_6, var_2["position"]);
    } else {
      var_15 = distance(var_6, var_9);
    }
    _id_1B27("nearStart", 1, 200);
    _id_1B27("nearEnd", var_15, 200);
    _id_1B27("farStart", var_15 + 196, 200);
    _id_1B27("farEnd", (var_15 + 196) * 2, 200);
    _id_1B27("nearBlur", 6, 0.1);
    _id_1B27("farBlur", 3.6, 0.1);
  } else {
    var_15 = getdvarint("scr_cinematic_doffocus") * 39;

    if(self._id_1AE5 != var_15) {
      _id_1B27("nearStart", 1, 100);
      _id_1B27("nearEnd", var_15, 100);
      _id_1B27("farStart", var_15 + 196, 100);
      _id_1B27("farEnd", (var_15 + 196) * 2, 100);
      _id_1B27("nearBlur", 6, 0.1);
      _id_1B27("farBlur", 3.6, 0.1);
    }
  }

  self._id_1AE5 = (self._id_1B21["farStart"] - self._id_1B21["nearEnd"]) / 2;
  self setdepthoffield(self._id_1B21["nearStart"], self._id_1B21["nearEnd"], self._id_1B21["farStart"], self._id_1B21["farEnd"], self._id_1B21["nearBlur"], self._id_1B21["farBlur"]);
}

_id_1B24() {
  var_0 = self playerads();

  if(var_0 == 0.0) {
    _id_1B2A();
    return;
  }

  var_1 = self getEye();
  var_2 = self getplayerangles();
  var_3 = vectornormalize(anglesToForward(var_2));
  var_4 = bulletTrace(var_1, var_1 + var_3 * 8192, 1, self, 1);
  var_5 = getaiarray("axis");
  var_6 = self getcurrentweapon();

  if(isDefined(level._id_1ADF[var_6])) {
    [[level._id_1ADF[var_6]]](var_4, var_5, var_1, var_3, var_0);
    return;
  }

  var_7 = 10000;
  var_8 = -1;

  for(var_9 = 0; var_9 < var_5.size; var_9++) {
    var_10 = vectornormalize(var_5[var_9].origin - var_1);
    var_11 = vectordot(var_3, var_10);

    if(var_11 < 0.923) {
      continue;
    }
    var_12 = distance(var_1, var_5[var_9].origin);

    if(var_12 - 30 < var_7) {
      var_7 = var_12 - 30;
    }
    if(var_12 + 30 > var_8) {
      var_8 = var_12 + 30;
    }
  }

  if(var_7 > var_8) {
    var_7 = 256;
    var_8 = 2500;
  } else {
    if(var_7 < 50) {
      var_7 = 50;
    } else if(var_7 > 512) {
      var_7 = 512;
    }
    if(var_8 > 2500) {
      var_8 = 2500;
    } else if(var_8 < 1000) {
      var_8 = 1000;
    }
  }

  var_13 = distance(var_1, var_4["position"]);

  if(var_7 > var_13) {
    var_7 = var_13 - 30;
  }
  if(var_7 < 1) {
    var_7 = 1;
  }
  if(var_8 < var_13) {
    var_8 = var_13;
  }
  _id_1B26(var_0, 1, var_7, var_8, var_8 * 4, 6, 1.8);
}

_id_1B25(var_0, var_1, var_2, var_3, var_4) {
  if(var_4 < 0.88) {
    _id_1B2A();
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
  _id_1B26(var_4, var_7, var_5, var_6, var_6 * 4, 4, 1.8);
}

_id_1B26(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_0 == 1) {
    _id_1B27("nearStart", var_1, 50);
    _id_1B27("nearEnd", var_2, 50);
    _id_1B27("farStart", var_3, 400);
    _id_1B27("farEnd", var_4, 400);
    _id_1B27("nearBlur", var_5, 0.1);
    _id_1B27("farBlur", var_6, 0.1);
  } else {
    _id_1B28("nearStart", var_1, var_0);
    _id_1B28("nearEnd", var_2, var_0);
    _id_1B28("farStart", var_3, var_0);
    _id_1B28("farEnd", var_4, var_0);
    _id_1B28("nearBlur", var_5, var_0);
    _id_1B28("farBlur", var_6, var_0);
  }

  self setdepthoffield(self._id_1B21["nearStart"], self._id_1B21["nearEnd"], self._id_1B21["farStart"], self._id_1B21["farEnd"], self._id_1B21["nearBlur"], self._id_1B21["farBlur"]);
}

_id_1B27(var_0, var_1, var_2) {
  if(self._id_1B21[var_0] > var_1) {
    var_3 = (self._id_1B21[var_0] - var_1) * 0.5;

    if(var_3 > var_2) {
      var_3 = var_2;
    } else if(var_3 < 1) {
      var_3 = 1;
    }
    if(self._id_1B21[var_0] - var_3 < var_1) {
      self._id_1B21[var_0] = var_1;
      return;
    }

    self._id_1B21[var_0] = self._id_1B21[var_0] - var_3;
    return;
  } else if(self._id_1B21[var_0] < var_1) {
    var_3 = (var_1 - self._id_1B21[var_0]) * 0.5;

    if(var_3 > var_2) {
      var_3 = var_2;
    } else if(var_3 < 1) {
      var_3 = 1;
    }
    if(self._id_1B21[var_0] + var_3 > var_1) {
      self._id_1B21[var_0] = var_1;
    } else {
      self._id_1B21[var_0] = self._id_1B21[var_0] + var_3;
    }
  }
}

_id_1B28(var_0, var_1, var_2) {
  self._id_1B21[var_0] = level._id_1436[var_0] + (var_1 - level._id_1436[var_0]) * var_2;
}

_id_1B29() {
  level._id_1436["nearStart"] = getdvarint("scr_dof_nearStart");
  level._id_1436["nearEnd"] = getdvarint("scr_dof_nearEnd");
  level._id_1436["farStart"] = getdvarint("scr_dof_farStart");
  level._id_1436["farEnd"] = getdvarint("scr_dof_farEnd");
  level._id_1436["nearBlur"] = getdvarfloat("scr_dof_nearBlur");
  level._id_1436["farBlur"] = getdvarfloat("scr_dof_farBlur");
}

_id_1B2A() {
  if(isDefined(self._id_1436)) {
    self setdepthoffield(self._id_1436["nearStart"], self._id_1436["nearEnd"], self._id_1436["farStart"], self._id_1436["farEnd"], self._id_1436["nearBlur"], self._id_1436["farBlur"]);
  } else {
    self setdepthoffield(level._id_1436["nearStart"], level._id_1436["nearEnd"], level._id_1436["farStart"], level._id_1436["farEnd"], level._id_1436["nearBlur"], level._id_1436["farBlur"]);
  }
}

_id_1B2B() {
  if(level._id_1436["nearStart"] != getdvarint("scr_dof_nearStart")) {
    return 0;
  }
  if(level._id_1436["nearEnd"] != getdvarint("scr_dof_nearEnd")) {
    return 0;
  }
  if(level._id_1436["farStart"] != getdvarint("scr_dof_farStart")) {
    return 0;
  }
  if(level._id_1436["farEnd"] != getdvarint("scr_dof_farEnd")) {
    return 0;
  }
  if(level._id_1436["nearBlur"] != getdvarint("scr_dof_nearBlur")) {
    return 0;
  }
  if(level._id_1436["farBlur"] != getdvarint("scr_dof_farBlur")) {
    return 0;
  }
  return 1;
}

_id_1B2C() {
  var_0 = 7;
  var_1 = [];
  var_2 = 15;
  var_3 = int(var_0 / 2);
  var_4 = 240 + var_3 * var_2;
  var_5 = 0.5 / var_3;
  var_6 = var_5;

  for(var_7 = 0; var_7 < var_0; var_7++) {
    var_1[var_7] = _id_1B34();
    var_1[var_7].location = 0;
    var_1[var_7].alignx = "left";
    var_1[var_7].aligny = "middle";
    var_1[var_7].foreground = 1;
    var_1[var_7].fontscale = 2;
    var_1[var_7].sort = 20;

    if(var_7 == var_3) {
      var_1[var_7].alpha = 1;
    } else {
      var_1[var_7].alpha = var_6;
    }
    var_1[var_7].x = 20;
    var_1[var_7].y = var_4;
    var_1[var_7] _id_1B36(".");

    if(var_7 == var_3) {
      var_5 = var_5 * -1;
    }
    var_6 = var_6 + var_5;
    var_4 = var_4 - var_2;
  }

  level._id_1B2D = var_1;
  var_8 = _id_1B34();
  var_8.location = 0;
  var_8.alignx = "center";
  var_8.aligny = "bottom";
  var_8.foreground = 1;
  var_8.fontscale = 2;
  var_8.sort = 20;
  var_8.alpha = 1;
  var_8.x = 320;
  var_8.y = 244;
  var_8 _id_1B36(".");
  level._id_1B2E = var_8;
  var_8 = _id_1B34();
  var_8.location = 0;
  var_8.alignx = "center";
  var_8.aligny = "bottom";
  var_8.foreground = 1;
  var_8.fontscale = 2;
  var_8.sort = 20;
  var_8.alpha = 0;
  var_8.x = 320;
  var_8.y = 244;
  var_8 setvalue(0);
  level._id_1B2F = var_8;
}

_id_1B30(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 520;
  var_6 = 120;
  var_7 = 18;
  var_8 = 0.8;
  var_9 = 20;
  var_10 = 1.4;

  if(!isDefined(var_2)) {
    var_2 = "";
  }
  if(!isDefined(level._id_1B31) || !isDefined(level._id_1B31[var_0])) {
    level._id_1B31[var_0] = _id_1B34();
    var_11 = _id_1B34();
  } else {
    var_11 = level._id_1B31[var_0]._id_1B32;
  }
  level._id_1B31[var_0].location = 0;
  level._id_1B31[var_0].alignx = "right";
  level._id_1B31[var_0].aligny = "middle";
  level._id_1B31[var_0].foreground = 1;
  level._id_1B31[var_0].fontscale = 1.5;
  level._id_1B31[var_0].sort = 20;
  level._id_1B31[var_0].alpha = var_8;
  level._id_1B31[var_0].x = var_5 + var_9;
  level._id_1B31[var_0].y = var_6 + var_1 * var_7;
  level._id_1B31[var_0] _id_1B36(var_2);
  level._id_1B31[var_0]._id_1B33 = var_2;
  var_11.location = 0;
  var_11.alignx = "left";
  var_11.aligny = "middle";
  var_11.foreground = 1;
  var_11.fontscale = var_10;
  var_11.sort = 20;
  var_11.alpha = var_8;
  var_11.x = var_5 + var_9;
  var_11.y = var_6 + var_1 * var_7;

  if(isDefined(var_4)) {
    var_11 setvalue(var_4);
  }
  if(isDefined(var_3)) {
    var_11 _id_1B36(var_3);
  }
  level._id_1B31[var_0]._id_1B32 = var_11;
}

_id_1B34() {
  if(!isDefined(level._id_1B35)) {
    level._id_1B35 = [];
  }
  var_0 = newhudelem();
  level._id_1B35[level._id_1B35.size] = var_0;
  return var_0;
}

_id_1B36(var_0) {
  self._id_1B37 = var_0;
  self settext("_");
  thread _id_1ADE();
  var_1 = 0;

  foreach(var_3 in level._id_1B35) {
    if(isDefined(var_3._id_1B37)) {
      var_1 = var_1 + var_3._id_1B37.size;
      var_3 settext(var_3._id_1B37);
    }
  }
}

_id_1ADE() {
  if(level._id_1ADE) {
    return;
  }
  level._id_1ADE = 1;
  self clearalltextafterhudelem();
  wait 0.05;
  level._id_1ADE = 0;
}

_id_1B38() {
  _id_1B3A();
  var_0 = undefined;
  var_1 = getarraykeys(level._id_1AE1);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == level._id_1AE2._id_1AE3) {
      var_0 = var_2 + 1;
      break;
    }
  }

  if(var_0 == var_1.size) {
    return;
  }
  _id_1B3B(var_1[var_0]);
}

_id_1B39() {
  _id_1B3A();
  var_0 = undefined;
  var_1 = getarraykeys(level._id_1AE1);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == level._id_1AE2._id_1AE3) {
      var_0 = var_2 - 1;
      break;
    }
  }

  if(var_0 < 0) {
    return;
  }
  _id_1B3B(var_1[var_0]);
}

_id_1B3A() {}

_id_1B3B(var_0) {
  level._id_1B3C = var_0;
  var_1 = getarraykeys(level._id_1AE1);
  var_2 = 0;
  var_3 = int(level._id_1B2D.size / 2);

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_1[var_4] == var_0) {
      var_2 = var_4;
      break;
    }
  }

  level._id_1B2D[var_3] _id_1B36(var_1[var_2]);

  for(var_4 = 1; var_4 < level._id_1B2D.size - var_3; var_4++) {
    if(var_2 - var_4 < 0) {
      level._id_1B2D[var_3 + var_4] _id_1B36(".");
      continue;
    }

    level._id_1B2D[var_3 + var_4] _id_1B36(var_1[var_2 - var_4]);
  }

  for(var_4 = 1; var_4 < level._id_1B2D.size - var_3; var_4++) {
    if(var_2 + var_4 > var_1.size - 1) {
      level._id_1B2D[var_3 - var_4] _id_1B36(".");
      continue;
    }

    level._id_1B2D[var_3 - var_4] _id_1B36(var_1[var_2 + var_4]);
  }

  maps\_utility::vision_set_fog_changes(var_1[var_2], 0);
}

_id_1B3E() {
  if(!isDefined(level._id_1B3F)) {
    level._id_1B3F = spawnStruct();
    level._id_1B3F._id_1B40 = "";
    level._id_1B3F.time = 0;
  }
}

_id_1B41() {
  var_0 = level._id_1AE2._id_1AE3;
  level._id_1AE2._id_1AE3 = "";
  level._id_1AE2.time = "";
  _id_1B3E();
  level._id_1B3F._id_1B40 = "";
  level._id_1B3F.time = "";
  _id_1B3B(var_0);
}