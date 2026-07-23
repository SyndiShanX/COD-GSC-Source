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
  level._clearalltextafterhudelem = 0;
  level.dofdefault["nearStart"] = 1;
  level.dofdefault["nearEnd"] = 1;
  level.dofdefault["farStart"] = 500;
  level.dofdefault["farEnd"] = 500;
  level.dofdefault["nearBlur"] = 4.5;
  level.dofdefault["farBlur"] = 0.05;
  precachemenu("dev_vision_noloc");
  precachemenu("dev_vision_exec");
  var_0 = getdvarint("scr_dof_enable");
  level.special_weapon_dof_funcs = [];
  level.buttons = [];

  if(!isDefined(level.vision_set_vision)) {
    level.vision_set_vision = [];
  }
  if(!isDefined(level.vision_set_transition_ent)) {
    level.vision_set_transition_ent = spawnStruct();
    level.vision_set_transition_ent.vision_set = "";
    level.vision_set_transition_ent.time = 0;
  }

  if(!isDefined(level.vision_set_fog)) {
    level.vision_set_fog = [];
    create_default_vision_set_fog(level.script);
    common_scripts\_artcommon::setfogsliders();
  }

  foreach(var_3, var_2 in level.vision_set_fog) {}
  create_vision_set_vision(var_3);

  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    var_5 = level.players[var_4];
    var_5.curdof = (level.dofdefault["farStart"] - level.dofdefault["nearEnd"]) / 2;

    if(var_0) {
      var_5 thread adsdof();
    }
  }

  thread tweakart();

  if(!isDefined(level.script)) {
    level.script = tolower(getDvar("mapname"));
  }
}

tweakart() {}

button_down(var_0, var_1) {
  var_2 = level.player buttonPressed(var_0);

  if(!var_2) {
    var_2 = level.player buttonPressed(var_1);
  }
  if(!isDefined(level.buttons[var_0])) {
    level.buttons[var_0] = 0;
  }
  if(gettime() < level.buttons[var_0]) {
    return 0;
  }
  level.buttons[var_0] = gettime() + 400;
  return var_2;
}

create_vision_set_vision(var_0) {
  if(!isDefined(level.vision_set_vision)) {
    level.vision_set_vision = [];
  }
  var_1 = spawnStruct();
  var_1.name = var_0;
  level.vision_set_vision[var_0] = var_1;
  return var_1;
}

updatefogentfromscript() {
  if(!isDefined(level.vision_set_fog)) {}

  var_0 = level.vision_set_fog[level.vision_set_transition_ent.vision_set];

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
      var_0.sunred = level.sunfogcolor[0];
      var_0.sungreen = level.sunfogcolor[1];
      var_0.sunblue = level.sunfogcolor[2];
      var_0.sundir = level.sunfogdir;
      var_0.sunbeginfadeangle = level.sunfogbeginfadeangle;
      var_0.sunendfadeangle = level.sunfogendfadeangle;
      var_0.normalfogscale = level.sunfogscale;
    }

    if(getdvarint("scr_fog_disable")) {
      var_0.startdist = 1215752192;
      var_0.halfwaydist = 1215752193;
      var_0.red = 0;
      var_0.green = 0;
      var_0.blue = 0;
      var_0.maxopacity = 0;
    }

    maps\_utility::set_fog_to_ent_values(var_0, 0);
  }
}

updatevisionset() {
  if(!isDefined(level.vision_set_vision)) {
    return;
  }
  if(!isDefined(level.vision_set_transition_ent)) {
    return;
  }
  if(!isDefined(level.vision_set_transition_ent.vision_set)) {
    return;
  }
  if(!isDefined(level.vision_set_vision[level.vision_set_transition_ent.vision_set])) {
    return;
  }
  var_0 = level.vision_set_vision[level.vision_set_transition_ent.vision_set];

  if(!isDefined(var_0.selected)) {
    return;
  }
  var_0.r_glow = getDvar("r_glowTweakEnable");
  var_0.r_glowradius0 = getDvar("r_glowTweakRadius0");
  var_0.r_glowbloomcutoff = getDvar("r_glowTweakBloomCutoff");
  var_0.r_glowbloomdesaturation = getDvar("r_glowTweakBloomDesaturation");
  var_0.r_glowbloomintensity0 = getDvar("r_glowTweakBloomIntensity0");
  var_0.r_filmenable = getDvar("r_filmTweakEnable");
  var_0.r_filmcontrast = getDvar("r_filmTweakContrast");
  var_0.r_filmbrightness = getDvar("r_filmTweakBrightness");
  var_0.r_filmdesaturation = getDvar("r_filmTweakDesaturation");
  var_0.r_filmdesaturationdark = getDvar("r_filmTweakDesaturationDark");
  var_0.r_filminvert = getDvar("r_filmTweakInvert");
  var_0.r_filmlighttint = getDvar("r_filmTweakLightTint");
  var_0.r_filmmediumtint = getDvar("r_filmTweakMediumTint");
  var_0.r_filmdarktint = getDvar("r_filmTweakDarkTint");
  var_0.r_primarylightusetweaks = getDvar("r_primaryLightUseTweaks");
  var_0.r_primarylighttweakdiffusestrength = getDvar("r_primaryLightTweakDiffuseStrength");
  var_0.r_primarylighttweakspecularstrength = getDvar("r_primaryLightTweakSpecularStrength");
}

fovslidercheck() {
  if(level.dofdefault["nearStart"] >= level.dofdefault["nearEnd"]) {
    level.dofdefault["nearStart"] = level.dofdefault["nearEnd"] - 1;
    setDvar("scr_dof_nearStart", level.dofdefault["nearStart"]);
  }

  if(level.dofdefault["nearEnd"] <= level.dofdefault["nearStart"]) {
    level.dofdefault["nearEnd"] = level.dofdefault["nearStart"] + 1;
    setDvar("scr_dof_nearEnd", level.dofdefault["nearEnd"]);
  }

  if(level.dofdefault["farStart"] >= level.dofdefault["farEnd"]) {
    level.dofdefault["farStart"] = level.dofdefault["farEnd"] - 1;
    setDvar("scr_dof_farStart", level.dofdefault["farStart"]);
  }

  if(level.dofdefault["farEnd"] <= level.dofdefault["farStart"]) {
    level.dofdefault["farEnd"] = level.dofdefault["farStart"] + 1;
    setDvar("scr_dof_farEnd", level.dofdefault["farEnd"]);
  }

  if(level.dofdefault["farBlur"] >= level.dofdefault["nearBlur"]) {
    level.dofdefault["farBlur"] = level.dofdefault["nearBlur"] - 0.1;
    setDvar("scr_dof_farBlur", level.dofdefault["farBlur"]);
  }

  if(level.dofdefault["farStart"] <= level.dofdefault["nearEnd"]) {
    level.dofdefault["farStart"] = level.dofdefault["nearEnd"] + 1;
    setDvar("scr_dof_farStart", level.dofdefault["farStart"]);
  }
}

fogslidercheck() {
  if(level.sunfogbeginfadeangle >= level.sunfogendfadeangle) {
    level.sunfogbeginfadeangle = level.sunfogendfadeangle - 1;
    setDvar("scr_sunFogBeginFadeAngle", level.sunfogbeginfadeangle);
  }

  if(level.sunfogendfadeangle <= level.sunfogbeginfadeangle) {
    level.sunfogendfadeangle = level.sunfogbeginfadeangle + 1;
    setDvar("scr_sunFogEndFadeAngle", level.sunfogendfadeangle);
  }
}

construct_vision_ents() {
  if(!isDefined(level.vision_set_fog)) {
    level.vision_set_fog = [];
  }
  var_0 = getEntArray("trigger_multiple_visionset", "classname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_visionset)) {
      construct_vision_set(var_2.script_visionset);
    }
    if(isDefined(var_2.script_visionset_start)) {
      construct_vision_set(var_2.script_visionset_start);
    }
    if(isDefined(var_2.script_visionset_end)) {
      construct_vision_set(var_2.script_visionset_end);
    }
  }
}

construct_vision_set(var_0) {
  if(isDefined(level.vision_set_fog[var_0])) {
    return;
  }
  create_default_vision_set_fog(var_0);
  create_vision_set_vision(var_0);
  iprintlnbold("new vision: " + var_0);
}

create_default_vision_set_fog(var_0) {
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

print_current_vision() {
  var_0 = level.vision_set_vision[level.vision_set_transition_ent.vision_set];

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

print_fog_ents() {
  foreach(var_1 in level.vision_set_fog) {
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
    if(isDefined(var_1.sunred)) {
      common_scripts\utility:: fileprint_launcher("\tent.sunRed = " + var_1.sunred + ";");
    }
    if(isDefined(var_1.sungreen)) {
      common_scripts\utility:: fileprint_launcher("\tent.sunGreen = " + var_1.sungreen + ";");
    }
    if(isDefined(var_1.sunblue)) {
      common_scripts\utility:: fileprint_launcher("\tent.sunBlue = " + var_1.sunblue + ";");
    }
    if(isDefined(var_1.sundir)) {
      common_scripts\utility:: fileprint_launcher("\tent.sunDir = " + var_1.sundir + ";");
    }
    if(isDefined(var_1.sunbeginfadeangle)) {
      common_scripts\utility:: fileprint_launcher("\tent.sunBeginFadeAngle = " + var_1.sunbeginfadeangle + ";");
    }
    if(isDefined(var_1.sunendfadeangle)) {
      common_scripts\utility:: fileprint_launcher("\tent.sunEndFadeAngle = " + var_1.sunendfadeangle + ";");
    }
    if(isDefined(var_1.normalfogscale)) {
      common_scripts\utility:: fileprint_launcher("\tent.normalFogScale = " + var_1.normalfogscale + ";");
    }
    common_scripts\utility:: fileprint_launcher(" ");
  }
}

print_fog_ents_csv() {
  foreach(var_1 in level.vision_set_fog) {
    if(!isDefined(var_1.name)) {
      continue;
    }
    common_scripts\utility:: fileprint_launcher("rawfile,vision/" + var_1.name + ".vision");
  }
}

cloudlight(var_0, var_1, var_2, var_3) {
  level.sunlight_bright = var_0;
  level.sunlight_dark = var_1;
  level.diffuse_high = var_2;
  level.diffuse_low = var_3;
  setDvar("r_lighttweaksunlight", level.sunlight_dark);
  setDvar("r_lighttweakdiffusefraction", level.diffuse_low);
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
    if(var_8 >= level.sunlight_bright) {
      var_8 = level.sunlight_bright;
      var_4 = "down";
    }

    if(var_8 <= level.sunlight_dark) {
      var_8 = level.sunlight_dark;
      var_4 = "up";
    }

    if(var_8 > var_5) {
      brighten(var_8, 3 + randomint(3), 0.05);
      continue;
    }

    darken(var_8, 3 + randomint(3), 0.05);
  }
}

brighten(var_0, var_1, var_2) {
  var_3 = getdvarfloat("r_lighttweaksunlight");
  var_4 = var_0 - var_3;
  var_5 = var_4 / (var_1 / var_2);

  while(var_1 > 0) {
    var_1 = var_1 - var_2;
    var_3 = var_3 + var_5;
    setDvar("r_lighttweaksunlight", var_3);
    var_6 = (var_3 - level.sunlight_dark) / (level.sunlight_bright - level.sunlight_dark);
    var_7 = level.diffuse_high + (level.diffuse_low - level.diffuse_high) * var_6;
    setDvar("r_lighttweakdiffusefraction", var_7);
    wait(var_2);
  }
}

darken(var_0, var_1, var_2) {
  var_3 = getdvarfloat("r_lighttweaksunlight");
  var_4 = var_3 - var_0;
  var_5 = var_4 / (var_1 / var_2);

  while(var_1 > 0) {
    var_1 = var_1 - var_2;
    var_3 = var_3 - var_5;
    setDvar("r_lighttweaksunlight", var_3);
    var_6 = (var_3 - level.sunlight_dark) / (level.sunlight_bright - level.sunlight_dark);
    var_7 = level.diffuse_high + (level.diffuse_low - level.diffuse_high) * var_6;
    setDvar("r_lighttweakdiffusefraction", var_7);
    wait(var_2);
  }
}

scale(var_0) {
  var_1 = var_0 / 100;
  return level.sunlight_dark + var_1 * (level.sunlight_bright - level.sunlight_dark) - level.sunlight_dark;
}

adsdof() {
  self.dof = level.dofdefault;
  var_0 = 0;

  for(;;) {
    wait 0.05;

    if(level.level_specific_dof) {
      continue;
    }
    if(getdvarint("scr_cinematic")) {
      updatecinematicdof();
      continue;
    }

    if(getdvarint("scr_dof_enable") && !var_0) {
      updatedof();
      continue;
    }

    setdefaultdepthoffield();
  }
}

updatecinematicdof() {
  var_0 = self playerads();

  if(var_0 == 1 && getdvarint("scr_cinematic_autofocus")) {
    var_1 = vectorNormalize(anglesToForward(self getplayerangles()));
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
      var_12 = vectorNormalize(var_11 - var_6);
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
    changedofvalue("nearStart", 1, 200);
    changedofvalue("nearEnd", var_15, 200);
    changedofvalue("farStart", var_15 + 196, 200);
    changedofvalue("farEnd", (var_15 + 196) * 2, 200);
    changedofvalue("nearBlur", 6, 0.1);
    changedofvalue("farBlur", 3.6, 0.1);
  } else {
    var_15 = getdvarint("scr_cinematic_doffocus") * 39;

    if(self.curdof != var_15) {
      changedofvalue("nearStart", 1, 100);
      changedofvalue("nearEnd", var_15, 100);
      changedofvalue("farStart", var_15 + 196, 100);
      changedofvalue("farEnd", (var_15 + 196) * 2, 100);
      changedofvalue("nearBlur", 6, 0.1);
      changedofvalue("farBlur", 3.6, 0.1);
    }
  }

  self.curdof = (self.dof["farStart"] - self.dof["nearEnd"]) / 2;
  self setdepthoffield(self.dof["nearStart"], self.dof["nearEnd"], self.dof["farStart"], self.dof["farEnd"], self.dof["nearBlur"], self.dof["farBlur"]);
}

updatedof() {
  var_0 = self playerads();

  if(var_0 == 0.0) {
    setdefaultdepthoffield();
    return;
  }

  var_1 = self getEye();
  var_2 = self getplayerangles();
  var_3 = vectorNormalize(anglesToForward(var_2));
  var_4 = bulletTrace(var_1, var_1 + var_3 * 8192, 1, self, 1);
  var_5 = getaiarray("axis");
  var_6 = self getcurrentweapon();

  if(isDefined(level.special_weapon_dof_funcs[var_6])) {
    [[level.special_weapon_dof_funcs[var_6]]](var_4, var_5, var_1, var_3, var_0);
    return;
  }

  var_7 = 10000;
  var_8 = -1;

  for(var_9 = 0; var_9 < var_5.size; var_9++) {
    var_10 = vectorNormalize(var_5[var_9].origin - var_1);
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
  setdoftarget(var_0, 1, var_7, var_8, var_8 * 4, 6, 1.8);
}

javelin_dof(var_0, var_1, var_2, var_3, var_4) {
  if(var_4 < 0.88) {
    setdefaultdepthoffield();
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
  setdoftarget(var_4, var_7, var_5, var_6, var_6 * 4, 4, 1.8);
}

setdoftarget(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_0 == 1) {
    changedofvalue("nearStart", var_1, 50);
    changedofvalue("nearEnd", var_2, 50);
    changedofvalue("farStart", var_3, 400);
    changedofvalue("farEnd", var_4, 400);
    changedofvalue("nearBlur", var_5, 0.1);
    changedofvalue("farBlur", var_6, 0.1);
  } else {
    lerpdofvalue("nearStart", var_1, var_0);
    lerpdofvalue("nearEnd", var_2, var_0);
    lerpdofvalue("farStart", var_3, var_0);
    lerpdofvalue("farEnd", var_4, var_0);
    lerpdofvalue("nearBlur", var_5, var_0);
    lerpdofvalue("farBlur", var_6, var_0);
  }

  self setdepthoffield(self.dof["nearStart"], self.dof["nearEnd"], self.dof["farStart"], self.dof["farEnd"], self.dof["nearBlur"], self.dof["farBlur"]);
}

changedofvalue(var_0, var_1, var_2) {
  if(self.dof[var_0] > var_1) {
    var_3 = (self.dof[var_0] - var_1) * 0.5;

    if(var_3 > var_2) {
      var_3 = var_2;
    } else if(var_3 < 1) {
      var_3 = 1;
    }
    if(self.dof[var_0] - var_3 < var_1) {
      self.dof[var_0] = var_1;
      return;
    }

    self.dof[var_0] = self.dof[var_0] - var_3;
    return;
  } else if(self.dof[var_0] < var_1) {
    var_3 = (var_1 - self.dof[var_0]) * 0.5;

    if(var_3 > var_2) {
      var_3 = var_2;
    } else if(var_3 < 1) {
      var_3 = 1;
    }
    if(self.dof[var_0] + var_3 > var_1) {
      self.dof[var_0] = var_1;
    } else {
      self.dof[var_0] = self.dof[var_0] + var_3;
    }
  }
}

lerpdofvalue(var_0, var_1, var_2) {
  self.dof[var_0] = level.dofdefault[var_0] + (var_1 - level.dofdefault[var_0]) * var_2;
}

dofvarupdate() {
  level.dofdefault["nearStart"] = getdvarint("scr_dof_nearStart");
  level.dofdefault["nearEnd"] = getdvarint("scr_dof_nearEnd");
  level.dofdefault["farStart"] = getdvarint("scr_dof_farStart");
  level.dofdefault["farEnd"] = getdvarint("scr_dof_farEnd");
  level.dofdefault["nearBlur"] = getdvarfloat("scr_dof_nearBlur");
  level.dofdefault["farBlur"] = getdvarfloat("scr_dof_farBlur");
}

setdefaultdepthoffield() {
  if(isDefined(self.dofdefault)) {
    self setdepthoffield(self.dofdefault["nearStart"], self.dofdefault["nearEnd"], self.dofdefault["farStart"], self.dofdefault["farEnd"], self.dofdefault["nearBlur"], self.dofdefault["farBlur"]);
  } else {
    self setdepthoffield(level.dofdefault["nearStart"], level.dofdefault["nearEnd"], level.dofdefault["farStart"], level.dofdefault["farEnd"], level.dofdefault["nearBlur"], level.dofdefault["farBlur"]);
  }
}

isdofdefault() {
  if(level.dofdefault["nearStart"] != getdvarint("scr_dof_nearStart")) {
    return 0;
  }
  if(level.dofdefault["nearEnd"] != getdvarint("scr_dof_nearEnd")) {
    return 0;
  }
  if(level.dofdefault["farStart"] != getdvarint("scr_dof_farStart")) {
    return 0;
  }
  if(level.dofdefault["farEnd"] != getdvarint("scr_dof_farEnd")) {
    return 0;
  }
  if(level.dofdefault["nearBlur"] != getdvarint("scr_dof_nearBlur")) {
    return 0;
  }
  if(level.dofdefault["farBlur"] != getdvarint("scr_dof_farBlur")) {
    return 0;
  }
  return 1;
}

hud_init() {
  var_0 = 7;
  var_1 = [];
  var_2 = 15;
  var_3 = int(var_0 / 2);
  var_4 = 240 + var_3 * var_2;
  var_5 = 0.5 / var_3;
  var_6 = var_5;

  for(var_7 = 0; var_7 < var_0; var_7++) {
    var_1[var_7] = _newhudelem();
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
    var_1[var_7] _settext(".");

    if(var_7 == var_3) {
      var_5 = var_5 * -1;
    }
    var_6 = var_6 + var_5;
    var_4 = var_4 - var_2;
  }

  level.spam_group_hudelems = var_1;
  var_8 = _newhudelem();
  var_8.location = 0;
  var_8.alignx = "center";
  var_8.aligny = "bottom";
  var_8.foreground = 1;
  var_8.fontscale = 2;
  var_8.sort = 20;
  var_8.alpha = 1;
  var_8.x = 320;
  var_8.y = 244;
  var_8 _settext(".");
  level.crosshair = var_8;
  var_8 = _newhudelem();
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
  level.crosshair_value = var_8;
}

controler_hud_add(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 520;
  var_6 = 120;
  var_7 = 18;
  var_8 = 0.8;
  var_9 = 20;
  var_10 = 1.4;

  if(!isDefined(var_2)) {
    var_2 = "";
  }
  if(!isDefined(level.hud_controler) || !isDefined(level.hud_controler[var_0])) {
    level.hud_controler[var_0] = _newhudelem();
    var_11 = _newhudelem();
  } else {
    var_11 = level.hud_controler[var_0].description;
  }
  level.hud_controler[var_0].location = 0;
  level.hud_controler[var_0].alignx = "right";
  level.hud_controler[var_0].aligny = "middle";
  level.hud_controler[var_0].foreground = 1;
  level.hud_controler[var_0].fontscale = 1.5;
  level.hud_controler[var_0].sort = 20;
  level.hud_controler[var_0].alpha = var_8;
  level.hud_controler[var_0].x = var_5 + var_9;
  level.hud_controler[var_0].y = var_6 + var_1 * var_7;
  level.hud_controler[var_0] _settext(var_2);
  level.hud_controler[var_0].base_button_text = var_2;
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
    var_11 _settext(var_3);
  }
  level.hud_controler[var_0].description = var_11;
}

_newhudelem() {
  if(!isDefined(level.scripted_elems)) {
    level.scripted_elems = [];
  }
  var_0 = newhudelem();
  level.scripted_elems[level.scripted_elems.size] = var_0;
  return var_0;
}

_settext(var_0) {
  self.realtext = var_0;
  self settext("_");
  thread _clearalltextafterhudelem();
  var_1 = 0;

  foreach(var_3 in level.scripted_elems) {
    if(isDefined(var_3.realtext)) {
      var_1 = var_1 + var_3.realtext.size;
      var_3 settext(var_3.realtext);
    }
  }
}

_clearalltextafterhudelem() {
  if(level._clearalltextafterhudelem) {
    return;
  }
  level._clearalltextafterhudelem = 1;
  self clearalltextafterhudelem();
  wait 0.05;
  level._clearalltextafterhudelem = 0;
}

setgroup_up() {
  reset_cmds();
  var_0 = undefined;
  var_1 = getarraykeys(level.vision_set_vision);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == level.vision_set_transition_ent.vision_set) {
      var_0 = var_2 + 1;
      break;
    }
  }

  if(var_0 == var_1.size) {
    return;
  }
  setcurrentgroup(var_1[var_0]);
}

setgroup_down() {
  reset_cmds();
  var_0 = undefined;
  var_1 = getarraykeys(level.vision_set_vision);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == level.vision_set_transition_ent.vision_set) {
      var_0 = var_2 - 1;
      break;
    }
  }

  if(var_0 < 0) {
    return;
  }
  setcurrentgroup(var_1[var_0]);
}

reset_cmds() {}

setcurrentgroup(var_0) {
  level.spam_model_current_group = var_0;
  var_1 = getarraykeys(level.vision_set_vision);
  var_2 = 0;
  var_3 = int(level.spam_group_hudelems.size / 2);

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_1[var_4] == var_0) {
      var_2 = var_4;
      break;
    }
  }

  level.spam_group_hudelems[var_3] _settext(var_1[var_2]);

  for(var_4 = 1; var_4 < level.spam_group_hudelems.size - var_3; var_4++) {
    if(var_2 - var_4 < 0) {
      level.spam_group_hudelems[var_3 + var_4] _settext(".");
      continue;
    }

    level.spam_group_hudelems[var_3 + var_4] _settext(var_1[var_2 - var_4]);
  }

  for(var_4 = 1; var_4 < level.spam_group_hudelems.size - var_3; var_4++) {
    if(var_2 + var_4 > var_1.size - 1) {
      level.spam_group_hudelems[var_3 - var_4] _settext(".");
      continue;
    }

    level.spam_group_hudelems[var_3 - var_4] _settext(var_1[var_2 + var_4]);
  }

  maps\_utility::vision_set_fog_changes(var_1[var_2], 0);
}

init_fog_transition() {
  if(!isDefined(level.fog_transition_ent)) {
    level.fog_transition_ent = spawnStruct();
    level.fog_transition_ent.fogset = "";
    level.fog_transition_ent.time = 0;
  }
}

playerinit() {
  var_0 = level.vision_set_transition_ent.vision_set;
  level.vision_set_transition_ent.vision_set = "";
  level.vision_set_transition_ent.time = "";
  init_fog_transition();
  level.fog_transition_ent.fogset = "";
  level.fog_transition_ent.time = "";
  setcurrentgroup(var_0);
}