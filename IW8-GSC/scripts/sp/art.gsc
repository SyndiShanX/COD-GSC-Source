/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\art.gsc
***********************************************/

function main() {
  if(!isDefined(level.level_specific_dof)) {
    level.level_specific_dof = 0;
  }

  level.current_sunflare_setting = "default";
  level._clearalltextafterhudelem = 0;
  dof_init();
  tess_init();
  mb_init();
  level.special_weapon_dof_funcs = [];
  level.buttons = [];
  setsaveddvar("PKKMTTRQO", 8);
  setsaveddvar("LSSLKOQPMQ", 1);
  setsaveddvar("OMKTSMSOS", 3);

  if(!isDefined(level.sunflare_settings)) {
    level.sunflare_settings = [];
  }

  if(!isDefined(level.script)) {
    level.script = tolower(getDvar("mapname"));
    return;
  }
}

function dof_set_generic(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  level.dof[var0][var1]["nearStart"] = var2;
  level.dof[var0][var1]["nearEnd"] = var3;
  level.dof[var0][var1]["nearBlur"] = var4;
  level.dof[var0][var1]["farStart"] = var5;
  level.dof[var0][var1]["farEnd"] = var6;
  level.dof[var0][var1]["farBlur"] = var7;
  level.dof[var0][var1]["weight"] = var8;
}

function dof_blend_interior_generic(var0) {
  if(level.dof[var0]["timeRemaining"] <= 0) {
    return;
  }

  var1 = min(1, 0.05 / level.dof[var0]["timeRemaining"]);
  level.dof[var0]["timeRemaining"] = level.dof[var0]["timeRemaining"] - 0.05;

  if(level.dof[var0]["timeRemaining"] <= 0) {
    level.dof[var0]["timeRemaining"] = 0;
    level.dof[var0]["current"]["nearStart"] = level.dof[var0]["goal"]["nearStart"];
    level.dof[var0]["current"]["nearEnd"] = level.dof[var0]["goal"]["nearEnd"];
    level.dof[var0]["current"]["nearBlur"] = level.dof[var0]["goal"]["nearBlur"];
    level.dof[var0]["current"]["farStart"] = level.dof[var0]["goal"]["farStart"];
    level.dof[var0]["current"]["farEnd"] = level.dof[var0]["goal"]["farEnd"];
    level.dof[var0]["current"]["farBlur"] = level.dof[var0]["goal"]["farBlur"];
    level.dof[var0]["current"]["weight"] = level.dof[var0]["goal"]["weight"];
    return;
  }

  level.dof[var0]["current"]["nearStart"] = level.dof[var0]["current"]["nearStart"] + var1 * (level.dof[var0]["goal"]["nearStart"] - level.dof[var0]["current"]["nearStart"]);
  level.dof[var0]["current"]["nearEnd"] = level.dof[var0]["current"]["nearEnd"] + var1 * (level.dof[var0]["goal"]["nearEnd"] - level.dof[var0]["current"]["nearEnd"]);
  level.dof[var0]["current"]["nearBlur"] = level.dof[var0]["current"]["nearBlur"] + var1 * (level.dof[var0]["goal"]["nearBlur"] - level.dof[var0]["current"]["nearBlur"]);
  level.dof[var0]["current"]["farStart"] = level.dof[var0]["current"]["farStart"] + var1 * (level.dof[var0]["goal"]["farStart"] - level.dof[var0]["current"]["farStart"]);
  level.dof[var0]["current"]["farEnd"] = level.dof[var0]["current"]["farEnd"] + var1 * (level.dof[var0]["goal"]["farEnd"] - level.dof[var0]["current"]["farEnd"]);
  level.dof[var0]["current"]["farBlur"] = level.dof[var0]["current"]["farBlur"] + var1 * (level.dof[var0]["goal"]["farBlur"] - level.dof[var0]["current"]["farBlur"]);
  level.dof[var0]["current"]["weight"] = level.dof[var0]["current"]["weight"] + var1 * (level.dof[var0]["goal"]["weight"] - level.dof[var0]["current"]["weight"]);
}

function mb_init() {
  setsaveddvar("LPSPNKLRPO", 1);
  scripts\engine\sp\utility::create_motion_blur_defaults(1, 1);
  scripts\engine\sp\utility::motion_blur_enable();
}

function dof_default(var0, var1) {
  var2 = 1;
  var3 = 1;
  var4 = 4.5;
  var5 = 500;
  var6 = 500;
  var7 = 0.05;
  dof_set_generic(var0, var1, var2, var3, var4, var5, var6, var7, 1);
}

function dof_init() {
  if(getDvar("scr_dof_enable") == "") {
    setsaveddvar("scr_dof_enable", "1");
  }

  setDvar("ads_dof_tracedist", 4096);
  setDvar("ads_dof_maxEnemyDist", 10000);
  setDvar("ads_dof_playerForgetEnemyTime", 5000);
  setDvar("ads_dof_nearStartScale", 0.25);
  setDvar("ads_dof_nearEndScale", 0.85);
  setDvar("ads_dof_farStartScale", 1.15);
  setDvar("ads_dof_farEndScale", 3);
  setDvar("ads_dof_nearBlur", 4);
  setDvar("ads_dof_farBlur", 4);
  setDvar("ads_dof_debug", 0);
  level.dof = [];
  level.dof["base"] = [];
  level.dof["base"]["current"] = [];
  level.dof["base"]["goal"] = [];
  level.dof["base"]["timeRemaining"] = 0;
  dof_default("base", "current");
  dof_set_generic("base", "goal", 0, 0, 0, 0, 0, 0, 0);
  level.dof["script"] = [];
  level.dof["script"]["current"] = [];
  level.dof["script"]["goal"] = [];
  level.dof["script"]["timeRemaining"] = 0;
  dof_set_generic("script", "current", 0, 0, 0, 0, 0, 0, 0);
  dof_set_generic("script", "goal", 0, 0, 0, 0, 0, 0, 0);
  level.dof["ads"] = [];
  level.dof["ads"]["current"] = [];
  level.dof["ads"]["goal"] = [];
  dof_set_generic("ads", "current", 0, 0, 0, 0, 0, 0, 0);
  dof_set_generic("ads", "goal", 0, 0, 0, 0, 0, 0, 0);
  level.dof["results"] = [];
  level.dof["results"]["current"] = [];
  dof_default("results", "current");

  foreach(var1 in level.players) {
    thread dof_update();
  }
}

function dof_set_base(var0, var1, var2, var3, var4, var5, var6) {
  dof_set_generic("base", "goal", var0, var1, var2, var3, var4, var5, 1);
  level.dof["base"]["timeRemaining"] = var6;

  if(var6 <= 0) {
    dof_set_generic("base", "current", var0, var1, var2, var3, var4, var5, 1);
    return;
  }
}

function dof_enable_script(var0, var1, var2, var3, var4, var5, var6) {
  dof_set_generic("script", "goal", var0, var1, var2, var3, var4, var5, 1);
  level.dof["script"]["timeRemaining"] = var6;

  if(var6 <= 0) {
    dof_set_generic("script", "current", var0, var1, var2, var3, var4, var5, 1);
    return;
  }

  if(level.dof["script"]["current"]["weight"] <= 0) {
    dof_set_generic("script", "current", var0, var1, var2, var3, var4, var5, 0);
    return;
  }
}

function dof_disable_script(var0) {
  level.dof["script"]["goal"]["weight"] = 0;
  level.dof["script"]["timeRemaining"] = var0;

  if(var0 <= 0) {
    level.dof["script"]["current"]["weight"] = 0;
    return;
  }
}

function is_dof_script_enabled() {
  return level.dof["script"]["current"]["weight"] > 0;
}

function dof_enable_ads(var0, var1, var2, var3, var4, var5, var6) {
  dof_set_generic("ads", "goal", var0, var1, var2, var3, var4, var5, var6);

  if(level.dof["ads"]["current"]["weight"] <= 0) {
    dof_set_generic("ads", "current", var0, var1, var2, var3, var4, var5, 0);
    return;
  }
}

function dof_blend_interior_ads_element(var0, var1, var2, var3) {
  if(var0 > var1) {
    var4 = (var0 - var1) * var3;

    if(var4 > var2) {
      var4 = var2;
    } else if(var4 < 1) {
      var4 = 1;
    }

    if(var0 - var4 <= var1) {
      return var1;
    } else {
      return (var0 - var4);
    }
  } else if(var0 < var1) {
    var4 = (var1 - var0) * var3;

    if(var4 > var2) {
      var4 = var2;
    } else if(var4 < 1) {
      var4 = 1;
    }

    if(var0 + var4 >= var1) {
      return var1;
    } else {
      return (var0 + var4);
    }
  }

  return var0;
}

function dof_blend_interior_ads() {
  var0 = level.dof["ads"]["goal"]["weight"];

  if(var0 < 1) {
    if(self adsButtonPressed() && self playerads() > 0) {
      var0 = min(1, var0 + 0.7);
    } else {
      var0 = 0;
    }

    level.dof["ads"]["current"]["nearStart"] = level.dof["ads"]["goal"]["nearStart"];
    level.dof["ads"]["current"]["nearEnd"] = level.dof["ads"]["goal"]["nearEnd"];
    level.dof["ads"]["current"]["nearBlur"] = level.dof["ads"]["goal"]["nearBlur"];
    level.dof["ads"]["current"]["farStart"] = level.dof["ads"]["goal"]["farStart"];
    level.dof["ads"]["current"]["farEnd"] = level.dof["ads"]["goal"]["farEnd"];
    level.dof["ads"]["current"]["farBlur"] = level.dof["ads"]["goal"]["farBlur"];
    level.dof["ads"]["current"]["weight"] = var0;
    return;
  }

  if(isDefined(level.dof_blend_interior_ads_scalar)) {
    var1 = level.dof_blend_interior_ads_scalar;
  } else {
    var1 = 0.1;
  }

  var2 = 10;
  var3 = max(var2, abs(level.dof["ads"]["current"]["nearStart"] - level.dof["ads"]["goal"]["nearStart"]) * var1);
  var4 = max(var2, abs(level.dof["ads"]["current"]["nearEnd"] - level.dof["ads"]["goal"]["nearEnd"]) * var1);
  var5 = max(var2, abs(level.dof["ads"]["current"]["farStart"] - level.dof["ads"]["goal"]["farStart"]) * var1);
  var6 = max(var2, abs(level.dof["ads"]["current"]["farEnd"] - level.dof["ads"]["goal"]["farEnd"]) * var1);
  var7 = 0.1;
  level.dof["ads"]["current"]["nearStart"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["nearStart"], level.dof["ads"]["goal"]["nearStart"], var3, 0.33);
  level.dof["ads"]["current"]["nearEnd"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["nearEnd"], level.dof["ads"]["goal"]["nearEnd"], var4, 0.33);
  level.dof["ads"]["current"]["nearBlur"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["nearBlur"], level.dof["ads"]["goal"]["nearBlur"], var7, 0.33);
  level.dof["ads"]["current"]["farStart"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["farStart"], level.dof["ads"]["goal"]["farStart"], var5, 0.33);
  level.dof["ads"]["current"]["farEnd"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["farEnd"], level.dof["ads"]["goal"]["farEnd"], var6, 0.33);
  level.dof["ads"]["current"]["farBlur"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["farBlur"], level.dof["ads"]["goal"]["farBlur"], var7, 0.33);
  level.dof["ads"]["current"]["weight"] = 1;
}

function dof_disable_ads() {
  level.dof["ads"]["goal"]["weight"] = 0;
  level.dof["ads"]["current"]["weight"] = 0;
}

function dof_apply_to_results(var0) {
  var1 = level.dof[var0]["current"]["weight"];
  var2 = 1 - var1;
  level.dof["results"]["current"]["nearStart"] = level.dof["results"]["current"]["nearStart"] * var2 + level.dof[var0]["current"]["nearStart"] * var1;
  level.dof["results"]["current"]["nearEnd"] = level.dof["results"]["current"]["nearEnd"] * var2 + level.dof[var0]["current"]["nearEnd"] * var1;
  level.dof["results"]["current"]["nearBlur"] = level.dof["results"]["current"]["nearBlur"] * var2 + level.dof[var0]["current"]["nearBlur"] * var1;
  level.dof["results"]["current"]["farStart"] = level.dof["results"]["current"]["farStart"] * var2 + level.dof[var0]["current"]["farStart"] * var1;
  level.dof["results"]["current"]["farEnd"] = level.dof["results"]["current"]["farEnd"] * var2 + level.dof[var0]["current"]["farEnd"] * var1;
  level.dof["results"]["current"]["farBlur"] = level.dof["results"]["current"]["farBlur"] * var2 + level.dof[var0]["current"]["farBlur"] * var1;
}

function dof_calc_results() {
  dof_blend_interior_generic("base");
  dof_blend_interior_generic("script");
  dof_blend_interior_ads();
  dof_apply_to_results("base");
  dof_apply_to_results("script");
  dof_apply_to_results("ads");
  var0 = level.dof["results"]["current"]["nearStart"];
  var1 = level.dof["results"]["current"]["nearEnd"];
  var2 = level.dof["results"]["current"]["nearBlur"];
  var3 = level.dof["results"]["current"]["farStart"];
  var4 = level.dof["results"]["current"]["farEnd"];
  var5 = level.dof["results"]["current"]["farBlur"];
  var0 = max(0, var0);
  var1 = max(0, var1);
  var3 = max(0, var3);
  var4 = max(0, var4);
  var2 = max(4, var2);
  var2 = min(10, var2);
  var5 = max(0, var5);
  var5 = min(var2, var5);

  if(var5 > 0) {
    var3 = max(var1, var3);
  }

  level.dof["results"]["current"]["nearStart"] = var0;
  level.dof["results"]["current"]["nearEnd"] = var1;
  level.dof["results"]["current"]["nearBlur"] = var2;
  level.dof["results"]["current"]["farStart"] = var3;
  level.dof["results"]["current"]["farEnd"] = var4;
  level.dof["results"]["current"]["farBlur"] = var5;
}

function dof_process_ads() {
  var0 = self playerads();

  if(var0 <= 0) {
    dof_disable_ads();
    return;
  }

  if(isDefined(level.custom_dof_trace)) {
    [[level.custom_dof_trace]]();
    return;
  }

  var1 = getdvarfloat("ads_dof_tracedist", 4096);
  var2 = getdvarfloat("ads_dof_maxEnemyDist", 0);
  var3 = getdvarint("ads_dof_playerForgetEnemyTime", 5000);
  var4 = getdvarfloat("ads_dof_nearStartScale", 0.25);
  var5 = getdvarfloat("ads_dof_nearEndScale", 0.85);
  var6 = getdvarfloat("ads_dof_farStartScale", 1.15);
  var7 = getdvarfloat("ads_dof_farEndScale", 3);
  var8 = getdvarfloat("ads_dof_nearBlur", 4);
  var9 = getdvarfloat("ads_dof_farBlur", 8);
  var10 = self getEye();
  var11 = self getplayerangles();

  if(isDefined(self.dof_ref_ent)) {
    var12 = combineangles(self.dof_ref_ent.angles, var11);
  } else {
    var12 = var12;
  }

  var13 = vectorNormalize(anglesToForward(var12));
  var14 = scripts\engine\trace::_bullet_trace(var11, var11 + var13 * var2, 1, self, 1, 0, 0, 0, 0);
  var15 = getaiarray("axis");
  var16 = self getcurrentweapon();
  var17 = createheadicon(var16);

  if(isDefined(level.special_weapon_dof_funcs[var17])) {
    [[level.special_weapon_dof_funcs[var17]]](var14, var15, var11, var13, var1);
    return;
  }

  if(var14["fraction"] == 1) {
    var2 = 4096;
    var18 = 1024;
    var19 = var2 * var7 * 2;
  } else {
    var4 = distance(var12, var16["position"]);
    var18 = var4 * var7;
    var19 = var4 * var9;
  }

  foreach(var21 in var17) {
    var22 = var21 isenemyaware();
    var23 = var21 hasenemybeenseen(var6);

    if(!var22 && !var23) {
      continue;
    }

    var24 = vectorNormalize(var21.origin - var12);
    var25 = vectordot(var15, var24);

    if(var25 < 0.923) {
      continue;
    }

    var26 = distance(var12, var21.origin);

    if(var26 - 30 < var18) {
      var18 = var26 - 30;
    }

    var27 = min(var26, var5);

    if(var27 + 30 > var19) {
      var19 = var27 + 30;
    }
  }

  if(var18 > var19) {
    var18 = var19 - 256;
  }

  if(var18 > var4) {
    var18 = var4 - 30;
  }

  if(var18 < 1) {
    var18 = 1;
  }

  if(var19 < var4) {
    var19 = var4;
  }

  var29 = var18 * var7;
  var30 = var19 * var10;
  dof_enable_ads(var29, var18, var11, var19, var30, var12, var3);
}

function setdoftracerange(var0) {
  if(!isDefined(var0)) {
    var0 = 4096;
  }

  setDvar("ads_dof_tracedist", var0);
}

function dof_process_physical_ads(var0) {
  if(isDefined(level.custom_dof_trace)) {
    return [[level.custom_dof_trace]]();
  }

  var1 = getdvarfloat("ads_dof_tracedist", 4096);
  var2 = getdvarfloat("ads_dof_maxEnemyDist", 0);
  var3 = getdvarint("ads_dof_playerForgetEnemyTime", 5000);
  var4 = self playermount();
  var5 = self getEye();
  var6 = self getplayerangles();

  if(var4 > 0) {
    switch (level.player playermounttype()) {
      case "mount_left":
        var5 += anglestoright(var6) * -3;
        break;
      case "mount_right":
        var5 += anglestoright(var6) * 3;
        break;
      case "mount_top":
        var5 += anglestoup(var6) * 3;
        break;
    }
  }

  if(isDefined(self.dof_ref_ent)) {
    var7 = combineangles(self.dof_ref_ent.angles, var6);
  } else {
    var7 = var7;
  }

  var8 = vectorNormalize(anglesToForward(var7));
  var9 = scripts\engine\trace::_bullet_trace(var6, var6 + var8 * var2, 1, self, 0, 1, 0, 0, 0);
  var10 = getaiarray("axis");
  var11 = self getcurrentweapon();
  GscBinSkip1(0x45, "start", distance(var6, var9["position"]));
}

function javelin_dof(var0, var1, var2, var3, var4) {
  if(var4 < 0.88) {
    dof_disable_ads();
    return;
  }

  var5 = 10000;
  var6 = -1;
  var5 = 2400;
  var7 = 2400;

  for(var8 = 0; var8 < var1.size; var8++) {
    var9 = vectorNormalize(var1[var8].origin - var2);
    var10 = vectordot(var3, var9);

    if(var10 < 0.923) {
      continue;
    }

    var11 = distance(var2, var1[var8].origin);

    if(var11 < 2500) {
      var11 = 2500;
    }

    if(var11 - 30 < var5) {
      var5 = var11 - 30;
    }

    if(var11 + 30 > var6) {
      var6 = var11 + 30;
    }
  }

  if(var5 > var6) {
    var5 = 2400;
    var6 = 3000;
  } else {
    if(var5 < 50) {
      var5 = 50;
    }

    if(var6 > 2500) {
      var6 = 2500;
    } else if(var6 < 1000) {
      var6 = 1000;
    }
  }

  var12 = distance(var2, var0["position"]);

  if(var12 < 2500) {
    var12 = 2500;
  }

  if(var5 > var12) {
    var5 = var12 - 30;
  }

  if(var5 < 1) {
    var5 = 1;
  }

  if(var6 < var12) {
    var6 = var12;
  }

  if(var7 >= var5) {
    var7 = var5 - 1;
  }

  var13 = var6 * 4;
  var14 = 4;
  var15 = 1.8;
  dof_enable_ads(var7, var5, var14, var6, var13, var15, var4);
}

function dof_update() {
  for(;;) {
    waitframe();

    if(level.level_specific_dof) {
      continue;
    }

    if(!getdvarint("scr_dof_enable")) {
      continue;
    }

    if(getdvarint("MRSTKSMMP")) {
      var0 = self playerads();

      if(var0 > 0) {
        var1 = dof_process_physical_ads(var0);
        self setadsphysicaldepthoffield(var1["start"], var1["end"]);
      }

      continue;
    }

    dof_process_ads();
    dof_calc_results();
    var2 = level.dof["results"]["current"]["nearStart"];
    var3 = level.dof["results"]["current"]["nearEnd"];
    var4 = level.dof["results"]["current"]["farStart"];
    var5 = level.dof["results"]["current"]["farEnd"];
    var6 = level.dof["results"]["current"]["nearBlur"];
    var7 = level.dof["results"]["current"]["farBlur"];
    self setdepthoffield(var2, var3, var4, var5, var6, var7);
  }
}

function tess_init() {
  var0 = getDvar("MMNMQTSOSP");

  if(var0 == "") {
    return;
  }

  level.tess = spawnStruct();
  level.tess.cutoff_distance_current = 635;
  level.tess.cutoff_distance_goal = level.tess.cutoff_distance_current;
  level.tess.cutoff_falloff_current = 587;
  level.tess.cutoff_falloff_goal = level.tess.cutoff_falloff_current;
  level.tess.time_remaining = 0;
  setsaveddvar("LMNOQSTMKN", level.tess.cutoff_distance_current);
  setsaveddvar("TSPOQPTMS", level.tess.cutoff_falloff_current);

  foreach(var2 in level.players) {
    thread tess_update();
  }
}

function tess_set_goal(var0, var1, var2) {
  level.tess.cutoff_distance_goal = var0;
  level.tess.cutoff_falloff_goal = var1;
  level.tess.time_remaining = var2;
}

function tess_update() {
  for(;;) {
    var0 = level.tess.cutoff_distance_current;
    var1 = level.tess.cutoff_falloff_current;
    waitframe();

    if(level.tess.time_remaining > 0) {
      var2 = level.tess.time_remaining * 20;
      var3 = (level.tess.cutoff_distance_goal - level.tess.cutoff_distance_current) / var2;
      var4 = (level.tess.cutoff_falloff_goal - level.tess.cutoff_falloff_current) / var2;
      level.tess.cutoff_distance_current += var3;
      level.tess.cutoff_falloff_current += var4;
      level.tess.time_remaining -= 0.05;
    } else {
      level.tess.cutoff_distance_current = level.tess.cutoff_distance_goal;
      level.tess.cutoff_falloff_current = level.tess.cutoff_falloff_goal;
    }

    if(var0 != level.tess.cutoff_distance_current) {
      setsaveddvar("LMNOQSTMKN", level.tess.cutoff_distance_current);
    }

    if(var1 != level.tess.cutoff_falloff_current) {
      setsaveddvar("TSPOQPTMS", level.tess.cutoff_falloff_current);
    }
  }
}

function sunflare_changes(var0, var1) {
  if(!isDefined(level.sunflare_settings[var0])) {
    return;
  }

  self notify("sunflare_start_adjust");
  self endon("sunflare_start_adjust");
  var2 = gettime();
  var3 = var1 * 1000;
  var4 = getdvarvector("r_sunflare_position", (0, 0, 0));
  var5 = gettime() - var2;
  var6 = level.sunflare_settings[var0].position;
  level.current_sunflare_setting = var0;

  while(var5 < var3) {
    var6 = level.sunflare_settings[var0].position;
    var7 = min(float(var5 / var3), 1);
    var8 = var4 + (var6 - var4) * var7;
    setDvar("r_sunflare_position", var8);
    setsunflareposition(var8);
    wait 0.05;
    var5 = gettime() - var2;
  }

  setDvar("r_sunflare_position", level.sunflare_settings[var0].position);
  setsunflareposition(var6);
}

function set_veil_weights(var0) {
  switch (var0) {
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