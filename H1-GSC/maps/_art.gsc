/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_art.gsc
********************************/

main() {
  maps\_utility::set_console_status();
  level.dofdefault["nearStart"] = 1;
  level.dofdefault["nearEnd"] = 1;
  level.dofdefault["farStart"] = 500;
  level.dofdefault["farEnd"] = 500;
  level.dofdefault["nearBlur"] = 4.5;
  level.dofdefault["farBlur"] = 0.05;
  level.current_sunflare_setting = "default";
  level._clearalltextafterhudelem = 0;
  dof_init();
  tess_init();
  precachemenu("dev_vision_noloc");
  precachemenu("dev_vision_exec");
  level.special_weapon_dof_funcs = [];
  level.buttons = [];

  if(!isdefined(level.vision_set_transition_ent)) {
    level.vision_set_transition_ent = spawnstruct();
    level.vision_set_transition_ent.vision_set = "";
    level.vision_set_transition_ent.time = 0;
  }

  if(!isdefined(level.sunflare_settings))
    level.sunflare_settings = [];

  if(!isdefined(level.vision_set_fog)) {
    level.vision_set_fog = [];
    create_default_vision_set_fog(level.script);
    common_scripts\_artcommon::setfogsliders();
  }

  if(!isdefined(level.script))
    level.script = tolower(getdvar("mapname"));
}

setdefaultdepthoffield() {
  self setdepthoffield(level.dofdefault["nearStart"], level.dofdefault["nearEnd"], level.dofdefault["farStart"], level.dofdefault["farEnd"], level.dofdefault["nearBlur"], level.dofdefault["farBlur"]);
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
  var_1.skyfogintensity = 0;
  var_1.skyfogminangle = 0;
  var_1.skyfogmaxangle = 0;
  var_1.heightfogenabled = 0;
  var_1.heightfogbaseheight = 0;
  var_1.heightfoghalfplanedistance = 1000;
}

get_fog_filename() {
  if(isusinghdr())
    return "\\share\\raw\\maps\\createart\\" + common_scripts\utility::get_template_level() + "_fog_hdr.gsc";
  else
    return "\\share\\raw\\maps\\createart\\" + common_scripts\utility::get_template_level() + "_fog.gsc";
}

dof_set_generic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  level.dof[var_0][var_1]["nearStart"] = var_2;
  level.dof[var_0][var_1]["nearEnd"] = var_3;
  level.dof[var_0][var_1]["nearBlur"] = var_4;
  level.dof[var_0][var_1]["farStart"] = var_5;
  level.dof[var_0][var_1]["farEnd"] = var_6;
  level.dof[var_0][var_1]["farBlur"] = var_7;
  level.dof[var_0][var_1]["weight"] = var_8;

  if(isdefined(var_9))
    level.dof[var_0][var_1]["bias"] = var_9;
}

dof_blend_interior_generic(var_0) {
  if(level.dof[var_0]["timeRemaining"] <= 0.0) {
    return;
  }
  var_1 = min(1.0, 0.05 / level.dof[var_0]["timeRemaining"]);
  level.dof[var_0]["timeRemaining"] = level.dof[var_0]["timeRemaining"] - 0.05;

  if(level.dof[var_0]["timeRemaining"] <= 0.0) {
    level.dof[var_0]["timeRemaining"] = 0.0;
    level.dof[var_0]["current"]["nearStart"] = level.dof[var_0]["goal"]["nearStart"];
    level.dof[var_0]["current"]["nearEnd"] = level.dof[var_0]["goal"]["nearEnd"];
    level.dof[var_0]["current"]["nearBlur"] = level.dof[var_0]["goal"]["nearBlur"];
    level.dof[var_0]["current"]["farStart"] = level.dof[var_0]["goal"]["farStart"];
    level.dof[var_0]["current"]["farEnd"] = level.dof[var_0]["goal"]["farEnd"];
    level.dof[var_0]["current"]["farBlur"] = level.dof[var_0]["goal"]["farBlur"];
    level.dof[var_0]["current"]["weight"] = level.dof[var_0]["goal"]["weight"];
    return;
  }

  level.dof[var_0]["current"]["nearStart"] = level.dof[var_0]["current"]["nearStart"] + var_1 * (level.dof[var_0]["goal"]["nearStart"] - level.dof[var_0]["current"]["nearStart"]);
  level.dof[var_0]["current"]["nearEnd"] = level.dof[var_0]["current"]["nearEnd"] + var_1 * (level.dof[var_0]["goal"]["nearEnd"] - level.dof[var_0]["current"]["nearEnd"]);
  level.dof[var_0]["current"]["nearBlur"] = level.dof[var_0]["current"]["nearBlur"] + var_1 * (level.dof[var_0]["goal"]["nearBlur"] - level.dof[var_0]["current"]["nearBlur"]);
  level.dof[var_0]["current"]["farStart"] = level.dof[var_0]["current"]["farStart"] + var_1 * (level.dof[var_0]["goal"]["farStart"] - level.dof[var_0]["current"]["farStart"]);
  level.dof[var_0]["current"]["farEnd"] = level.dof[var_0]["current"]["farEnd"] + var_1 * (level.dof[var_0]["goal"]["farEnd"] - level.dof[var_0]["current"]["farEnd"]);
  level.dof[var_0]["current"]["farBlur"] = level.dof[var_0]["current"]["farBlur"] + var_1 * (level.dof[var_0]["goal"]["farBlur"] - level.dof[var_0]["current"]["farBlur"]);
  level.dof[var_0]["current"]["weight"] = level.dof[var_0]["current"]["weight"] + var_1 * (level.dof[var_0]["goal"]["weight"] - level.dof[var_0]["current"]["weight"]);
}

dof_init() {
  if(getdvar("scr_dof_enable") == "")
    setsaveddvar("scr_dof_enable", "1");

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
  var_0 = 1;
  var_1 = 1;
  var_2 = 4.5;
  var_3 = 500;
  var_4 = 500;
  var_5 = 0.05;
  level.dof = [];
  level.dof["base"] = [];
  level.dof["base"]["current"] = [];
  level.dof["base"]["goal"] = [];
  level.dof["base"]["timeRemaining"] = 0.0;
  dof_set_generic("base", "current", var_0, var_1, var_2, var_3, var_4, var_5, 1.0, 0.5);
  dof_set_generic("base", "goal", 0, 0, 0, 0, 0, 0, 0.0, 0.5);
  level.dof["script"] = [];
  level.dof["script"]["current"] = [];
  level.dof["script"]["goal"] = [];
  level.dof["script"]["timeRemaining"] = 0.0;
  dof_set_generic("script", "current", 0, 0, 0, 0, 0, 0, 0.0, 0.5);
  dof_set_generic("script", "goal", 0, 0, 0, 0, 0, 0, 0.0, 0.5);
  level.dof["ads"] = [];
  level.dof["ads"]["current"] = [];
  level.dof["ads"]["goal"] = [];
  dof_set_generic("ads", "current", 0, 0, 0, 0, 0, 0, 0.0, 0.5);
  dof_set_generic("ads", "goal", 0, 0, 0, 0, 0, 0, 0.0, 0.5);
  level.dof["results"] = [];
  level.dof["results"]["current"] = [];
  dof_set_generic("results", "current", var_0, var_1, var_2, var_3, var_4, var_5, 1.0, 0.5);

  foreach(var_7 in level.players)
  var_7 thread dof_update();

  level.player maps\_utility::delaythread(1, ::dof_monitor_prone);
}

dof_set_base(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  dof_set_generic("base", "goal", var_0, var_1, var_2, var_3, var_4, var_5, 1.0, var_7);
  level.dof["base"]["timeRemaining"] = var_6;

  if(var_6 <= 0.0)
    dof_set_generic("base", "current", var_0, var_1, var_2, var_3, var_4, var_5, 1.0, var_7);
}

dof_enable_script(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  dof_set_generic("script", "goal", var_0, var_1, var_2, var_3, var_4, var_5, 1.0, var_7);
  level.dof["script"]["timeRemaining"] = var_6;

  if(var_6 <= 0.0)
    dof_set_generic("script", "current", var_0, var_1, var_2, var_3, var_4, var_5, 1.0, var_7);
  else if(level.dof["script"]["current"]["weight"] <= 0.0)
    dof_set_generic("script", "current", var_0, var_1, var_2, var_3, var_4, var_5, 0.0, var_7);
}

dof_disable_script(var_0) {
  level.dof["script"]["goal"]["weight"] = 0.0;
  level.dof["script"]["timeRemaining"] = var_0;

  if(var_0 <= 0.0)
    level.dof["script"]["current"]["weight"] = 0.0;
}

dof_enable_ads(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  dof_set_generic("ads", "goal", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

  if(level.dof["ads"]["current"]["weight"] <= 0.0)
    dof_set_generic("ads", "current", var_0, var_1, var_2, var_3, var_4, var_5, 0.0, var_7);
}

dof_blend_interior_ads_element(var_0, var_1, var_2, var_3) {
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

dof_blend_interior_ads() {
  var_0 = level.dof["ads"]["goal"]["weight"];

  if(var_0 < 1.0) {
    if(self adsbuttonpressed() && self playerads() > 0.0)
      var_0 = min(1, var_0 + 0.7);
    else
      var_0 = 0;

    level.dof["ads"]["current"]["nearStart"] = level.dof["ads"]["goal"]["nearStart"];
    level.dof["ads"]["current"]["nearEnd"] = level.dof["ads"]["goal"]["nearEnd"];
    level.dof["ads"]["current"]["nearBlur"] = level.dof["ads"]["goal"]["nearBlur"];
    level.dof["ads"]["current"]["farStart"] = level.dof["ads"]["goal"]["farStart"];
    level.dof["ads"]["current"]["farEnd"] = level.dof["ads"]["goal"]["farEnd"];
    level.dof["ads"]["current"]["farBlur"] = level.dof["ads"]["goal"]["farBlur"];
    level.dof["ads"]["current"]["weight"] = var_0;
    level.dof["ads"]["current"]["bias"] = level.dof["ads"]["goal"]["bias"];
    return;
  }

  if(isdefined(level.dof_blend_interior_ads_scalar))
    var_1 = level.dof_blend_interior_ads_scalar;
  else
    var_1 = 0.1;

  var_2 = 10;
  var_3 = max(var_2, abs(level.dof["ads"]["current"]["nearStart"] - level.dof["ads"]["goal"]["nearStart"]) * var_1);
  var_4 = max(var_2, abs(level.dof["ads"]["current"]["nearEnd"] - level.dof["ads"]["goal"]["nearEnd"]) * var_1);
  var_5 = max(var_2, abs(level.dof["ads"]["current"]["farStart"] - level.dof["ads"]["goal"]["farStart"]) * var_1);
  var_6 = max(var_2, abs(level.dof["ads"]["current"]["farEnd"] - level.dof["ads"]["goal"]["farEnd"]) * var_1);
  var_7 = 0.1;
  var_8 = 0.1;
  level.dof["ads"]["current"]["nearStart"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["nearStart"], level.dof["ads"]["goal"]["nearStart"], var_3, 0.33);
  level.dof["ads"]["current"]["nearEnd"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["nearEnd"], level.dof["ads"]["goal"]["nearEnd"], var_4, 0.33);
  level.dof["ads"]["current"]["nearBlur"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["nearBlur"], level.dof["ads"]["goal"]["nearBlur"], var_7, 0.33);
  level.dof["ads"]["current"]["farStart"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["farStart"], level.dof["ads"]["goal"]["farStart"], var_5, 0.33);
  level.dof["ads"]["current"]["farEnd"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["farEnd"], level.dof["ads"]["goal"]["farEnd"], var_6, 0.33);
  level.dof["ads"]["current"]["farBlur"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["farBlur"], level.dof["ads"]["goal"]["farBlur"], var_7, 0.33);
  level.dof["ads"]["current"]["weight"] = 1.0;
  level.dof["ads"]["current"]["bias"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["bias"], level.dof["ads"]["goal"]["bias"], var_8, 0.33);
}

dof_disable_ads() {
  level.dof["ads"]["goal"]["weight"] = 0.0;
  level.dof["ads"]["current"]["weight"] = 0.0;
}

dof_apply_to_results(var_0) {
  var_1 = level.dof[var_0]["current"]["weight"];
  var_2 = 1.0 - var_1;
  level.dof["results"]["current"]["nearStart"] = level.dof["results"]["current"]["nearStart"] * var_2 + level.dof[var_0]["current"]["nearStart"] * var_1;
  level.dof["results"]["current"]["nearEnd"] = level.dof["results"]["current"]["nearEnd"] * var_2 + level.dof[var_0]["current"]["nearEnd"] * var_1;
  level.dof["results"]["current"]["nearBlur"] = level.dof["results"]["current"]["nearBlur"] * var_2 + level.dof[var_0]["current"]["nearBlur"] * var_1;
  level.dof["results"]["current"]["farStart"] = level.dof["results"]["current"]["farStart"] * var_2 + level.dof[var_0]["current"]["farStart"] * var_1;
  level.dof["results"]["current"]["farEnd"] = level.dof["results"]["current"]["farEnd"] * var_2 + level.dof[var_0]["current"]["farEnd"] * var_1;
  level.dof["results"]["current"]["farBlur"] = level.dof["results"]["current"]["farBlur"] * var_2 + level.dof[var_0]["current"]["farBlur"] * var_1;
  level.dof["results"]["current"]["bias"] = level.dof["results"]["current"]["bias"] * var_2 + level.dof[var_0]["current"]["bias"] * var_1;
}

dof_calc_results() {
  dof_blend_interior_generic("base");
  dof_blend_interior_generic("script");
  dof_blend_interior_ads();
  dof_apply_to_results("base");
  dof_apply_to_results("script");
  dof_apply_to_results("ads");
  var_0 = level.dof["results"]["current"]["nearStart"];
  var_1 = level.dof["results"]["current"]["nearEnd"];
  var_2 = level.dof["results"]["current"]["nearBlur"];
  var_3 = level.dof["results"]["current"]["farStart"];
  var_4 = level.dof["results"]["current"]["farEnd"];
  var_5 = level.dof["results"]["current"]["farBlur"];
  var_6 = level.dof["results"]["current"]["bias"];
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

  var_6 = max(0, var_6);
  level.dof["results"]["current"]["nearStart"] = var_0;
  level.dof["results"]["current"]["nearEnd"] = var_1;
  level.dof["results"]["current"]["nearBlur"] = var_2;
  level.dof["results"]["current"]["farStart"] = var_3;
  level.dof["results"]["current"]["farEnd"] = var_4;
  level.dof["results"]["current"]["farBlur"] = var_5;
  level.dof["results"]["current"]["bias"] = var_6;
}

dof_process_ads() {
  var_0 = self playerads();

  if(var_0 <= 0.0) {
    dof_disable_ads();
    return;
  }

  if(isdefined(level.custom_dof_trace)) {
    [
      [level.custom_dof_trace]
    ]();
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
  var_10 = self geteye();
  var_11 = self getplayerangles();

  if(isdefined(self.dof_ref_ent))
    var_12 = combineangles(self.dof_ref_ent.angles, var_11);
  else
    var_12 = var_11;

  var_13 = vectornormalize(anglestoforward(var_12));
  var_14 = bullettrace(var_10, var_10 + var_13 * var_1, 1, self, 0, 0, 0, 0, 0);
  var_15 = getaiarray("axis");
  var_16 = self getcurrentweapon();

  if(isdefined(level.special_weapon_dof_funcs[var_16])) {
    [
      [level.special_weapon_dof_funcs[var_16]]
    ](var_14, var_15, var_10, var_13, var_0);
    return;
  }

  if(var_14["fraction"] == 1) {
    var_1 = 2048;
    var_17 = 256;
    var_18 = var_1 * var_6 * 2;
  } else {
    var_1 = distance(var_10, var_14["position"]);
    var_17 = var_1 * var_4;
    var_18 = var_1 * var_6;
  }

  foreach(var_20 in var_15) {
    var_21 = var_20 isenemyaware();
    var_22 = var_20 hasenemybeenseen(var_3);

    if(!var_21 && !var_22) {
      continue;
    }
    var_23 = vectornormalize(var_20.origin - var_10);
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
  dof_enable_ads(var_28, var_17, var_8, var_18, var_29, var_9, var_0);
}

dof_process_physical_ads(var_0) {
  if(isdefined(level.custom_dof_trace))
    return [
      [level.custom_dof_trace]
    ]();

  var_1 = getdvarfloat("ads_dof_tracedist", 4096);
  var_2 = getdvarfloat("ads_dof_maxEnemyDist", 0);
  var_3 = getdvarint("ads_dof_playerForgetEnemyTime", 5000);
  var_4 = self geteye();
  var_5 = self getplayerangles();

  if(isdefined(self.dof_ref_ent))
    var_6 = combineangles(self.dof_ref_ent.angles, var_5);
  else
    var_6 = var_5;

  var_7 = vectornormalize(anglestoforward(var_6));
  var_8 = bullettrace(var_4, var_4 + var_7 * var_1, 1, self, 0, 1, 0, 0, 0);
  var_9 = getaiarray("axis");
  var_10 = self getcurrentweapon();

  if(isdefined(level.special_weapon_dof_funcs[var_10]))
    return [
      [level.special_weapon_dof_funcs[var_10]]
    ](var_8, var_9, var_4, var_7, var_0);

  var_11["start"] = distance(var_4, var_8["position"]);
  var_11["end"] = var_11["start"];

  foreach(var_13 in var_9) {
    var_14 = var_13 isenemyaware();
    var_15 = var_13 hasenemybeenseen(var_3);

    if(!var_14 && !var_15) {
      continue;
    }
    var_16 = vectornormalize(var_13.origin - var_4);
    var_17 = vectordot(var_7, var_16);

    if(var_17 < 0.923) {
      continue;
    }
    var_18 = distance(var_4, var_13.origin);

    if(var_18 < var_11["start"])
      var_11["start"] = var_18;

    var_19 = min(var_18, var_2);

    if(var_19 > var_11["end"])
      var_11["end"] = var_19;
  }

  return var_11;
}

dof_monitor_prone() {
  if(!isdefined(level.dof_while_prone_enabled) || !level.dof_while_prone_enabled) {
    return;
  }
  for (;;) {
    dof_set_standing();

    while (self getstance() != "prone")
      wait 0.05;

    dof_set_prone();

    while (self getstance() == "prone")
      wait 0.05;
  }
}

dof_set_standing() {
  level.player disablephysicaldepthoffieldscripting();
}

dof_set_prone() {
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(3.0, 800.0, 20, 20);
  level.player setphysicalviewmodeldepthoffield(12.0, 900.0);
}

javelin_dof(var_0, var_1, var_2, var_3, var_4) {
  if(var_4 < 0.88) {
    dof_disable_ads();
    return;
  }

  var_5 = 10000;
  var_6 = -1;
  var_5 = 2400;
  var_7 = 2400;

  for (var_8 = 0; var_8 < var_1.size; var_8++) {
    var_9 = vectornormalize(var_1[var_8].origin - var_2);
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
  dof_enable_ads(var_7, var_5, var_14, var_6, var_13, var_15, var_4);
}

dof_update() {
  for (;;) {
    waitframe();

    if(level.level_specific_dof) {
      continue;
    }
    if(!getdvarint("scr_dof_enable")) {
      continue;
    }
    if(getdvarint("r_dof_physical_enable")) {
      var_0 = self playerads();

      if(var_0 > 0.0) {
        var_1 = dof_process_physical_ads(var_0);
        self setadsphysicaldepthoffield(var_1["start"], var_1["end"]);
      }

      continue;
    }

    dof_process_ads();
    dof_calc_results();
    var_2 = level.dof["results"]["current"]["nearStart"];
    var_3 = level.dof["results"]["current"]["nearEnd"];
    var_4 = level.dof["results"]["current"]["farStart"];
    var_5 = level.dof["results"]["current"]["farEnd"];
    var_6 = level.dof["results"]["current"]["nearBlur"];
    var_7 = level.dof["results"]["current"]["farBlur"];
    self setdepthoffield(var_2, var_3, var_4, var_5, var_6, var_7);
  }
}

tess_init() {
  var_0 = getdvar("r_tessellation");

  if(var_0 == "") {
    return;
  }
  level.tess = spawnstruct();
  level.tess.cutoff_distance_current = getdvarfloat("r_tessellationCutoffDistance", 960.0);
  level.tess.cutoff_distance_goal = level.tess.cutoff_distance_current;
  level.tess.cutoff_falloff_current = getdvarfloat("r_tessellationCutoffFalloff", 320.0);
  level.tess.cutoff_falloff_goal = level.tess.cutoff_falloff_current;
  level.tess.time_remaining = 0.0;

  foreach(var_2 in level.players)
  var_2 thread tess_update();
}

tess_set_goal(var_0, var_1, var_2) {
  level.tess.cutoff_distance_goal = var_0;
  level.tess.cutoff_falloff_goal = var_1;
  level.tess.time_remaining = var_2;
}

tess_update() {
  for (;;) {
    var_0 = level.tess.cutoff_distance_current;
    var_1 = level.tess.cutoff_falloff_current;
    waitframe();

    if(level.tess.time_remaining > 0.0) {
      var_2 = level.tess.time_remaining * 20;
      var_3 = (level.tess.cutoff_distance_goal - level.tess.cutoff_distance_current) / var_2;
      var_4 = (level.tess.cutoff_falloff_goal - level.tess.cutoff_falloff_current) / var_2;
      level.tess.cutoff_distance_current = level.tess.cutoff_distance_current + var_3;
      level.tess.cutoff_falloff_current = level.tess.cutoff_falloff_current + var_4;
      level.tess.time_remaining = level.tess.time_remaining - 0.05;
    } else {
      level.tess.cutoff_distance_current = level.tess.cutoff_distance_goal;
      level.tess.cutoff_falloff_current = level.tess.cutoff_falloff_goal;
    }

    if(var_0 != level.tess.cutoff_distance_current)
      setsaveddvar("r_tessellationCutoffDistance", level.tess.cutoff_distance_current);

    if(var_1 != level.tess.cutoff_falloff_current)
      setsaveddvar("r_tessellationCutoffFalloff", level.tess.cutoff_falloff_current);
  }
}

sunflare_changes(var_0, var_1) {
  if(!isdefined(level.sunflare_settings[var_0])) {
    return;
  }
  self notify("sunflare_start_adjust");
  self endon("sunflare_start_adjust");
  var_2 = gettime();
  var_3 = var_1 * 1000;
  var_4 = getdvarvector("r_sunflare_position", (0, 0, 0));
  var_5 = gettime() - var_2;
  var_6 = level.sunflare_settings[var_0].position;

  for (level.current_sunflare_setting = var_0; var_5 < var_3; var_5 = gettime() - var_2) {
    var_6 = level.sunflare_settings[var_0].position;
    var_7 = min(float(var_5 / var_3), 1);
    var_8 = var_4 + (var_6 - var_4) * var_7;
    setdvar("r_sunflare_position", var_8);
    setsunflareposition(var_8);
    wait 0.05;
  }

  setdvar("r_sunflare_position", level.sunflare_settings[var_0].position);
  setsunflareposition(var_6);
}

init_fog_transition() {
  if(!isdefined(level.fog_transition_ent)) {
    level.fog_transition_ent = spawnstruct();
    level.fog_transition_ent.fogset = "";
    level.fog_transition_ent.time = 0;
  }
}

set_fog_progress(var_0) {
  if(isdefined(self.start_hdrcolorintensity)) {
    set_fog_progress_preh1(var_0);
    return;
  }

  var_1 = 1 - var_0;
  var_2 = self.start_neardist * var_1 + self.end_neardist * var_0;
  var_3 = self.start_fardist * var_1 + self.end_fardist * var_0;
  var_4 = self.start_color * var_1 + self.end_color * var_0;
  setexpfog(var_2, var_3, var_4[0], var_4[1], var_4[2], 1, 0.4);
}

set_fog_progress_preh1(var_0) {
  var_1 = 1 - var_0;
  var_2 = self.start_neardist * var_1 + self.end_neardist * var_0;
  var_3 = self.start_fardist * var_1 + self.end_fardist * var_0;
  var_4 = self.start_color * var_1 + self.end_color * var_0;
  var_5 = self.start_hdrcolorintensity * var_1 + self.end_hdrcolorintensity * var_0;
  var_6 = self.start_opacity;
  var_7 = self.end_opacity;
  var_8 = self.start_skyfogintensity;
  var_9 = self.start_skyfogminangle;
  var_10 = self.start_skyfogmaxangle;
  var_8 = self.start_skyfogintensity * var_1 + self.end_skyfogintensity * var_0;
  var_9 = self.start_skyfogminangle * var_1 + self.end_skyfogminangle * var_0;
  var_10 = self.start_skyfogmaxangle * var_1 + self.end_skyfogmaxangle * var_0;

  if(!isdefined(var_6))
    var_6 = 1;

  if(!isdefined(var_7))
    var_7 = 1;

  var_11 = var_6 * var_1 + var_7 * var_0;

  if(self.sunfog_enabled) {
    var_12 = self.start_suncolor * var_1 + self.end_suncolor * var_0;
    var_13 = self.start_hdrsuncolorintensity * var_1 + self.end_hdrsuncolorintensity * var_0;
    var_14 = self.start_sundir * var_1 + self.end_sundir * var_0;
    var_15 = self.start_sunbeginfadeangle * var_1 + self.end_sunbeginfadeangle * var_0;
    var_16 = self.start_sunendfadeangle * var_1 + self.end_sunendfadeangle * var_0;
    var_17 = self.start_sunfogscale * var_1 + self.end_sunfogscale * var_0;
    setexpfog(var_2, var_3, var_4[0], var_4[1], var_4[2], var_5, var_11, 0.4, var_12[0], var_12[1], var_12[2], var_13, var_14, var_15, var_16, var_17, var_8, var_9, var_10);
  } else
    setexpfog(var_2, var_3, var_4[0], var_4[1], var_4[2], var_5, var_11, 0.4, var_8, var_9, var_10);
}

ssao_set_target_over_time_internal(var_0, var_1) {
  level notify("ssao_set_target_over_time_internal");
  level endon("ssao_set_target_over_time_internal");
  maps\_utility::set_console_status();

  if(!maps\_utility::is_gen4()) {
    return;
  }
  var_2 = getdvarfloat("r_ssaoScriptScale", 1.0);

  for (var_3 = var_1; var_3 > 0.0; var_3 = var_3 - 0.05) {
    var_4 = min(1.0, 0.05 / var_3);
    var_5 = var_2;
    var_2 = var_2 + var_4 * (var_0 - var_2);

    if(var_5 != var_2)
      setsaveddvar("r_ssaoScriptScale", var_2);

    waitframe();
  }

  setsaveddvar("r_ssaoScriptScale", var_0);
}

disable_ssao_over_time(var_0) {
  level thread ssao_set_target_over_time_internal(0.0, var_0);
}

enable_ssao_over_time(var_0) {
  level thread ssao_set_target_over_time_internal(1.0, var_0);
}