/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\art.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace art;

function main() {
  setdevdvarifuninitialized(@ "scr_art_tweak", 0);
  setsaveddvar(@ "hash_4296464306ab31a8", 0);

  if(!isDefined(level.level_specific_dof)) {
    level.level_specific_dof = 0;
  }

  level._clearalltextafterhudelem = 0;
  dof_init();
  tess_init();
  mb_init();
  level.special_weapon_dof_funcs = [];
  level.buttons = [];
  setsaveddvar(@ "hash_7686fcb92ccc5edb", 8);
  setsaveddvar(@ "hash_9e7bc885a6c0ab17", 1);

  thread tweakart();

  if(!isDefined(level.script)) {
    level.script = tolower(getDvar(@ "g_mapname"));
  }
}

function tweakart() {
  if(!isDefined(level.tweakfile)) {
    level.tweakfile = 0;
  }

  setDvar(@ "scr_fog_fraction", "<dev string:x1c>");
  setDvar(@ "scr_art_dump", "<dev string:x20>");
  setDvar(@ "scr_dof_nearstart", level.dof["<dev string:x22>"]["<dev string:x27>"]["<dev string:x2f>"]);
  setDvar(@ "scr_dof_nearend", level.dof["<dev string:x22>"]["<dev string:x27>"]["<dev string:x39>"]);
  setDvar(@ "scr_dof_farstart", level.dof["<dev string:x22>"]["<dev string:x27>"]["<dev string:x41>"]);
  setDvar(@ "scr_dof_farend", level.dof["<dev string:x22>"]["<dev string:x27>"]["<dev string:x4a>"]);
  setDvar(@ "scr_dof_nearblur", level.dof["<dev string:x22>"]["<dev string:x27>"]["<dev string:x51>"]);
  setDvar(@ "scr_dof_farblur", level.dof["<dev string:x22>"]["<dev string:x27>"]["<dev string:x5a>"]);
  level.fogfraction = 1;
  file = undefined;
  dofvarupdate();
  printed = 0;

  for(;;) {
    while(getdvarint(@ "scr_art_tweak") == 0) {
      wait 0.05;
    }

    setsaveddvar(@ "hash_4296464306ab31a8", 1);

    if(!printed) {
      printed = 1;
      setDvar(@ "loc_warnings", 0);
      iprintlnbold("<dev string:x62>");
      hud_init();
    }

    dofvarupdate();
    function_934935ccb50fdc01();
    dump = dumpsettings();
    wait 0.05;
  }
}

function dofvarupdate() {
  nearstart = getdvarint(@ "scr_dof_nearstart");
  nearend = getdvarint(@ "scr_dof_nearend");
  nearblur = getdvarfloat(@ "scr_dof_nearblur");
  farstart = getdvarint(@ "scr_dof_farstart");
  farend = getdvarint(@ "scr_dof_farend");
  farblur = getdvarfloat(@ "scr_dof_farblur");

  foreach(player in level.players) {
    player setdepthoffield(nearstart, nearend, farstart, farend, nearblur, farblur);
  }
}

function button_down(btn, btn2) {
  pressed = level.player buttonPressed(btn);

  if(!pressed) {
    pressed = level.player buttonPressed(btn2);
  }

  if(!isDefined(level.buttons[btn])) {
    level.buttons[btn] = 0;
  }

  if(gettime() < level.buttons[btn]) {
    return 0;
  }

  level.buttons[btn] = gettime() + 400;
  return pressed;
}

function function_934935ccb50fdc01() {
  nearstart = getdvarint(@ "scr_dof_nearstart");
  nearend = getdvarint(@ "scr_dof_nearend");
  nearblur = getdvarfloat(@ "scr_dof_nearblur");
  farstart = getdvarint(@ "scr_dof_farstart");
  farend = getdvarint(@ "scr_dof_farend");
  farblur = getdvarfloat(@ "scr_dof_farblur");

  if(nearstart >= nearend) {
    nearstart = nearend - 1;
    setDvar(@ "scr_dof_nearstart", nearstart);
  }

  if(nearend <= nearstart) {
    nearend = nearstart + 1;
    setDvar(@ "scr_dof_nearend", nearend);
  }

  if(farstart >= farend) {
    farstart = farend - 1;
    setDvar(@ "scr_dof_farstart", farstart);
  }

  if(farend <= farstart) {
    farend = farstart + 1;
    setDvar(@ "scr_dof_farend", farend);
  }

  if(farblur >= nearblur) {
    farblur = nearblur - 0.1;
    setDvar(@ "scr_dof_farblur", farblur);
  }

  if(farstart <= nearend) {
    farstart = nearend + 1;
    setDvar(@ "scr_dof_farstart", farstart);
  }
}

function dumpsettings() {
  if(getDvar(@ "scr_art_dump") == "<dev string:x20>") {
    return;
  }

  dump_art = getDvar(@ "scr_art_dump") != "<dev string:x20>";
  setDvar(@ "scr_art_dump", "<dev string:x20>");
  fileprint_launcher_start_file();
  fileprint_launcher( "<dev string:x74>" );
  fileprint_launcher( "<dev string:xc6>" );
  fileprint_launcher( "<dev string:xcd>" );
  fileprint_launcher( "<dev string:xcf>" );
  fileprint_launcher( "<dev string:xd0>" );
  fileprint_launcher( "<dev string:xe9>" );
  fileprint_launcher( "<dev string:xcf>" );
  fileprint_launcher( "<dev string:x123>" );

  if(! fileprint_launcher_end_file( "<dev string:x125>" + level.script + "<dev string:x141>" + level.script + "<dev string:x147>", 1 ) )
    {
      return;
    }

    iprintlnbold("<dev string:x150>"); println("<dev string:x161>"); addstring = "<dev string:x17e>" + level.script + "<dev string:x194>"; assertex(level.tweakfile, "<dev string:x1a2>" + level.script + "<dev string:x1bd>" + addstring + "<dev string:x1dc>" + level.script + "<dev string:x1f4>" + level.script + "<dev string:x204>");
  }

  function dof_set_generic(layername, subsetname, nearstart, nearend, nearblur, farstart, farend, farblur, weight) {
    level.dof[layername][subsetname]["nearStart"] = nearstart;
    level.dof[layername][subsetname]["nearEnd"] = nearend;
    level.dof[layername][subsetname]["nearBlur"] = nearblur;
    level.dof[layername][subsetname]["farStart"] = farstart;
    level.dof[layername][subsetname]["farEnd"] = farend;
    level.dof[layername][subsetname]["farBlur"] = farblur;
    level.dof[layername][subsetname]["weight"] = weight;
  }

  function dof_blend_interior_generic(layername) {
    if(level.dof[layername]["timeRemaining"] <= 0) {
      return;
    }

    lerpfrac = min(1, 0.05 / level.dof[layername]["timeRemaining"]);
    level.dof[layername]["timeRemaining"] = level.dof[layername]["timeRemaining"] - 0.05;

    if(level.dof[layername]["timeRemaining"] <= 0) {
      level.dof[layername]["timeRemaining"] = 0;
      level.dof[layername]["current"]["nearStart"] = level.dof[layername]["goal"]["nearStart"];
      level.dof[layername]["current"]["nearEnd"] = level.dof[layername]["goal"]["nearEnd"];
      level.dof[layername]["current"]["nearBlur"] = level.dof[layername]["goal"]["nearBlur"];
      level.dof[layername]["current"]["farStart"] = level.dof[layername]["goal"]["farStart"];
      level.dof[layername]["current"]["farEnd"] = level.dof[layername]["goal"]["farEnd"];
      level.dof[layername]["current"]["farBlur"] = level.dof[layername]["goal"]["farBlur"];
      level.dof[layername]["current"]["weight"] = level.dof[layername]["goal"]["weight"];
      return;
    }

    level.dof[layername]["current"]["nearStart"] = level.dof[layername]["current"]["nearStart"] + lerpfrac * (level.dof[layername]["goal"]["nearStart"] - level.dof[layername]["current"]["nearStart"]);
    level.dof[layername]["current"]["nearEnd"] = level.dof[layername]["current"]["nearEnd"] + lerpfrac * (level.dof[layername]["goal"]["nearEnd"] - level.dof[layername]["current"]["nearEnd"]);
    level.dof[layername]["current"]["nearBlur"] = level.dof[layername]["current"]["nearBlur"] + lerpfrac * (level.dof[layername]["goal"]["nearBlur"] - level.dof[layername]["current"]["nearBlur"]);
    level.dof[layername]["current"]["farStart"] = level.dof[layername]["current"]["farStart"] + lerpfrac * (level.dof[layername]["goal"]["farStart"] - level.dof[layername]["current"]["farStart"]);
    level.dof[layername]["current"]["farEnd"] = level.dof[layername]["current"]["farEnd"] + lerpfrac * (level.dof[layername]["goal"]["farEnd"] - level.dof[layername]["current"]["farEnd"]);
    level.dof[layername]["current"]["farBlur"] = level.dof[layername]["current"]["farBlur"] + lerpfrac * (level.dof[layername]["goal"]["farBlur"] - level.dof[layername]["current"]["farBlur"]);
    level.dof[layername]["current"]["weight"] = level.dof[layername]["current"]["weight"] + lerpfrac * (level.dof[layername]["goal"]["weight"] - level.dof[layername]["current"]["weight"]);
  }

  function mb_init() {
    if(!isplatformmobile()) {
      setsaveddvar(@ "hash_8fef9b7e4f880571", 1);
      create_motion_blur_defaults(1, 1);
      motion_blur_enable();
    }
  }

  function dof_default(layername, subsetname) {
    nearstart = 1;
    nearend = 1;
    nearblur = 4.5;
    farstart = 500;
    farend = 500;
    farblur = 0.05;
    dof_set_generic(layername, subsetname, nearstart, nearend, nearblur, farstart, farend, farblur, 1);
  }

  function dof_init() {
    if(getDvar(@ "hash_1b022342555479ae") == "") {
      setsaveddvar(@ "hash_1b022342555479ae", "1");
    }

    setDvar(@ "hash_16d3b68a571cd9cc", 4096);
    setDvar(@ "hash_f920da78c320d7c9", 10000);
    setDvar(@ "hash_46a24e55882202b4", 5000);
    setDvar(@ "hash_70ad5c8b5390da5b", 0.25);
    setDvar(@ "hash_cb3ccd57ba94fab4", 0.85);
    setDvar(@ "hash_8260157d7099d0a", 1.15);
    setDvar(@ "hash_3eedd8d68a0e7cad", 3);
    setDvar(@ "hash_46ecedfd7e9e40a4", 4);
    setDvar(@ "hash_ad993fc2da2f7edd", 4);
    setDvar(@ "hash_a3478a0be5d0bcae", 0);
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

    foreach(player in level.players) {
      player thread dof_update();
    }
  }

  function dof_set_base(nearstart, nearend, nearblur, farstart, farend, farblur, blend_time) {
    dof_set_generic("base", "goal", nearstart, nearend, nearblur, farstart, farend, farblur, 1);
    level.dof["base"]["timeRemaining"] = blend_time;

    if(blend_time <= 0) {
      dof_set_generic("base", "current", nearstart, nearend, nearblur, farstart, farend, farblur, 1);
    }
  }

  function dof_enable_script(nearstart, nearend, nearblur, farstart, farend, farblur, blend_time) {
    dof_set_generic("script", "goal", nearstart, nearend, nearblur, farstart, farend, farblur, 1);
    level.dof["script"]["timeRemaining"] = blend_time;

    if(blend_time <= 0) {
      dof_set_generic("script", "current", nearstart, nearend, nearblur, farstart, farend, farblur, 1);
      return;
    }

    if(level.dof["script"]["current"]["weight"] <= 0) {
      dof_set_generic("script", "current", nearstart, nearend, nearblur, farstart, farend, farblur, 0);
    }
  }

  function dof_disable_script(blend_time) {
    level.dof["script"]["goal"]["weight"] = 0;
    level.dof["script"]["timeRemaining"] = blend_time;

    if(blend_time <= 0) {
      level.dof["script"]["current"]["weight"] = 0;
    }
  }

  function is_dof_script_enabled() {
    return level.dof["script"]["current"]["weight"] > 0;
  }

  function dof_enable_ads(nearstart, nearend, nearblur, farstart, farend, farblur, adsfrac) {
    dof_set_generic("ads", "goal", nearstart, nearend, nearblur, farstart, farend, farblur, adsfrac);

    if(level.dof["ads"]["current"]["weight"] <= 0) {
      dof_set_generic("ads", "current", nearstart, nearend, nearblur, farstart, farend, farblur, 0);
    }
  }

  function dof_blend_interior_ads_element(currentvalue, targetvalue, maxchange, changerate) {
    if(currentvalue > targetvalue) {
      changeval = (currentvalue - targetvalue) * changerate;

      if(changeval > maxchange) {
        changeval = maxchange;
      } else if(changeval < 1) {
        changeval = 1;
      }

      if(currentvalue - changeval <= targetvalue) {
        return targetvalue;
      } else {
        return (currentvalue - changeval);
      }
    } else if(currentvalue < targetvalue) {
      changeval = (targetvalue - currentvalue) * changerate;

      if(changeval > maxchange) {
        changeval = maxchange;
      } else if(changeval < 1) {
        changeval = 1;
      }

      if(currentvalue + changeval >= targetvalue) {
        return targetvalue;
      } else {
        return (currentvalue + changeval);
      }
    }

    return currentvalue;
  }

  function dof_blend_interior_ads() {
    assert(isPlayer(self));
    adsfrac = level.dof["ads"]["goal"]["weight"];

    if(adsfrac < 1) {
      if(self adsButtonPressed() && self playerads() > 0) {
        adsfrac = min(1, adsfrac + 0.7);
      } else {
        adsfrac = 0;
      }

      level.dof["ads"]["current"]["nearStart"] = level.dof["ads"]["goal"]["nearStart"];
      level.dof["ads"]["current"]["nearEnd"] = level.dof["ads"]["goal"]["nearEnd"];
      level.dof["ads"]["current"]["nearBlur"] = level.dof["ads"]["goal"]["nearBlur"];
      level.dof["ads"]["current"]["farStart"] = level.dof["ads"]["goal"]["farStart"];
      level.dof["ads"]["current"]["farEnd"] = level.dof["ads"]["goal"]["farEnd"];
      level.dof["ads"]["current"]["farBlur"] = level.dof["ads"]["goal"]["farBlur"];
      level.dof["ads"]["current"]["weight"] = adsfrac;
      return;
    }

    if(isDefined(level.dof_blend_interior_ads_scalar)) {
      var_b3beab783cd9bd5c = level.dof_blend_interior_ads_scalar;
    } else {
      var_b3beab783cd9bd5c = 0.1;
    }

    var_9f836feedd16035c = 10;
    nearstartmaxchange = max(var_9f836feedd16035c, abs(level.dof["ads"]["current"]["nearStart"] - level.dof["ads"]["goal"]["nearStart"]) * var_b3beab783cd9bd5c);
    nearendmaxchange = max(var_9f836feedd16035c, abs(level.dof["ads"]["current"]["nearEnd"] - level.dof["ads"]["goal"]["nearEnd"]) * var_b3beab783cd9bd5c);
    farstartmaxchange = max(var_9f836feedd16035c, abs(level.dof["ads"]["current"]["farStart"] - level.dof["ads"]["goal"]["farStart"]) * var_b3beab783cd9bd5c);
    farendmaxchange = max(var_9f836feedd16035c, abs(level.dof["ads"]["current"]["farEnd"] - level.dof["ads"]["goal"]["farEnd"]) * var_b3beab783cd9bd5c);
    blurmaxchange = 0.1;
    level.dof["ads"]["current"]["nearStart"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["nearStart"], level.dof["ads"]["goal"]["nearStart"], nearstartmaxchange, 0.33);
    level.dof["ads"]["current"]["nearEnd"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["nearEnd"], level.dof["ads"]["goal"]["nearEnd"], nearendmaxchange, 0.33);
    level.dof["ads"]["current"]["nearBlur"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["nearBlur"], level.dof["ads"]["goal"]["nearBlur"], blurmaxchange, 0.33);
    level.dof["ads"]["current"]["farStart"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["farStart"], level.dof["ads"]["goal"]["farStart"], farstartmaxchange, 0.33);
    level.dof["ads"]["current"]["farEnd"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["farEnd"], level.dof["ads"]["goal"]["farEnd"], farendmaxchange, 0.33);
    level.dof["ads"]["current"]["farBlur"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["farBlur"], level.dof["ads"]["goal"]["farBlur"], blurmaxchange, 0.33);
    level.dof["ads"]["current"]["weight"] = 1;
  }

  function dof_disable_ads() {
    level.dof["ads"]["goal"]["weight"] = 0;
    level.dof["ads"]["current"]["weight"] = 0;
  }

  function dof_apply_to_results(layername) {
    layer_weight = level.dof[layername]["current"]["weight"];
    inverse_weight = 1 - layer_weight;
    level.dof["results"]["current"]["nearStart"] = level.dof["results"]["current"]["nearStart"] * inverse_weight + level.dof[layername]["current"]["nearStart"] * layer_weight;
    level.dof["results"]["current"]["nearEnd"] = level.dof["results"]["current"]["nearEnd"] * inverse_weight + level.dof[layername]["current"]["nearEnd"] * layer_weight;
    level.dof["results"]["current"]["nearBlur"] = level.dof["results"]["current"]["nearBlur"] * inverse_weight + level.dof[layername]["current"]["nearBlur"] * layer_weight;
    level.dof["results"]["current"]["farStart"] = level.dof["results"]["current"]["farStart"] * inverse_weight + level.dof[layername]["current"]["farStart"] * layer_weight;
    level.dof["results"]["current"]["farEnd"] = level.dof["results"]["current"]["farEnd"] * inverse_weight + level.dof[layername]["current"]["farEnd"] * layer_weight;
    level.dof["results"]["current"]["farBlur"] = level.dof["results"]["current"]["farBlur"] * inverse_weight + level.dof[layername]["current"]["farBlur"] * layer_weight;
  }

  function dof_calc_results() {
    assert(isPlayer(self));
    dof_blend_interior_generic("base");
    dof_blend_interior_generic("script");
    dof_blend_interior_ads();
    dof_apply_to_results("base");
    dof_apply_to_results("script");
    dof_apply_to_results("ads");
    nearstart = level.dof["results"]["current"]["nearStart"];
    nearend = level.dof["results"]["current"]["nearEnd"];
    nearblur = level.dof["results"]["current"]["nearBlur"];
    farstart = level.dof["results"]["current"]["farStart"];
    farend = level.dof["results"]["current"]["farEnd"];
    farblur = level.dof["results"]["current"]["farBlur"];
    nearstart = max(0, nearstart);
    nearend = max(0, nearend);
    farstart = max(0, farstart);
    farend = max(0, farend);
    nearblur = max(4, nearblur);
    nearblur = min(10, nearblur);
    farblur = max(0, farblur);
    farblur = min(nearblur, farblur);

    if(farblur > 0) {
      farstart = max(nearend, farstart);
    }

    level.dof["results"]["current"]["nearStart"] = nearstart;
    level.dof["results"]["current"]["nearEnd"] = nearend;
    level.dof["results"]["current"]["nearBlur"] = nearblur;
    level.dof["results"]["current"]["farStart"] = farstart;
    level.dof["results"]["current"]["farEnd"] = farend;
    level.dof["results"]["current"]["farBlur"] = farblur;
  }

  function dof_process_ads() {
    assert(isPlayer(self));
    adsfrac = self playerads();

    if(getdvarint(@ "hash_a3478a0be5d0bcae", 0)) {
      adsfrac = 1;
    }

    if(adsfrac <= 0) {
      dof_disable_ads();
      return;
    }

    if(isDefined(level.custom_dof_trace)) {
      [[level.custom_dof_trace]]();
      return;
    }

    tracedist = getdvarfloat(@ "hash_16d3b68a571cd9cc", 4096);
    maxenemydist = getdvarfloat(@ "hash_f920da78c320d7c9", 0);
    playerforgetenemytime = getdvarint(@ "hash_46a24e55882202b4", 5000);
    nearstartscale = getdvarfloat(@ "hash_70ad5c8b5390da5b", 0.25);
    nearendscale = getdvarfloat(@ "hash_cb3ccd57ba94fab4", 0.85);
    farstartscale = getdvarfloat(@ "hash_8260157d7099d0a", 1.15);
    farendscale = getdvarfloat(@ "hash_3eedd8d68a0e7cad", 3);
    nearblur = getdvarfloat(@ "hash_46ecedfd7e9e40a4", 4);
    farblur = getdvarfloat(@ "hash_ad993fc2da2f7edd", 8);
    playereye = self getEye();
    playeranglesrel = self getplayerangles();

    if(isDefined(self.dof_ref_ent)) {
      playerangles = combineangles(self.dof_ref_ent.angles, playeranglesrel);
    } else {
      playerangles = playeranglesrel;
    }

    playerforward = vectorNormalize(anglesToForward(playerangles));
    trace = scripts\engine\trace::_bullet_trace(playereye, playereye + playerforward * tracedist, 1, self, 1, 0, 0, 0, 0);
    enemies = getaiarray("axis");
    weapon = self getcurrentweapon();
    weaponname = getcompleteweaponname(weapon);

    if(isDefined(level.special_weapon_dof_funcs[weaponname])) {
      [[level.special_weapon_dof_funcs[weaponname]]](trace, enemies, playereye, playerforward, adsfrac);
      return;
    }

    if(trace["fraction"] == 1) {
      tracedist = 4096;
      nearend = 1024;
      farstart = tracedist * farstartscale * 2;
    } else {
      tracedist = distance(playereye, trace["position"]);
      nearend = tracedist * nearstartscale;
      farstart = tracedist * farstartscale;
    }

    foreach(enemy in enemies) {
      enemyaware = enemy isenemyaware();
      enemyseen = enemy hasenemybeenseen(playerforgetenemytime);

      if(!enemyaware && !enemyseen) {
        continue;
      }

      enemydir = vectorNormalize(enemy.origin - playereye);
      dot = vectordot(playerforward, enemydir);

      if(dot < 0.923) {
        continue;
      }

      distfrom = distance(playereye, enemy.origin);

      if(distfrom - 30 < nearend) {
        nearend = distfrom - 30;
      }

      distfromfar = min(distfrom, maxenemydist);

      if(distfromfar + 30 > farstart) {
        farstart = distfromfar + 30;
      }
    }

    if(nearend > farstart) {
      nearend = farstart - 256;
    }

    if(nearend > tracedist) {
      nearend = tracedist - 30;
    }

    if(nearend < 1) {
      nearend = 1;
    }

    if(farstart < tracedist) {
      farstart = tracedist;
    }

    nearstart = nearend * nearstartscale;
    farend = farstart * farendscale;
    dof_enable_ads(nearstart, nearend, nearblur, farstart, farend, farblur, adsfrac);
  }

  function setdoftracerange(range) {
    if(!isDefined(range)) {
      range = 4096;
    }

    setDvar(@ "hash_16d3b68a571cd9cc", range);
  }

  function dof_process_physical_ads(adsfrac) {
    if(isDefined(level.custom_dof_trace)) {
      return [[level.custom_dof_trace]]();
    }

    tracedist = getdvarfloat(@ "hash_16d3b68a571cd9cc", 4096);
    maxenemydist = getdvarfloat(@ "hash_f920da78c320d7c9", 0);
    playerforgetenemytime = getdvarint(@ "hash_46a24e55882202b4", 5000);
    mountfrac = self playermount();
    playereye = self getEye();
    playeranglesrel = self getplayerangles();

    if(mountfrac > 0) {
      switch (level.player playermounttype()) {
        case #"hash_b882c19d3b9f4eb6":
          playereye += anglestoright(playeranglesrel) * -3;
          break;
        case #"hash_c00b1399e3e96eeb":
          playereye += anglestoright(playeranglesrel) * 3;
          break;
        case #"hash_d45b94ed344be47e":
          playereye += anglestoup(playeranglesrel) * 3;
          break;
      }
    }

    if(isDefined(self.dof_ref_ent)) {
      playerangles = combineangles(self.dof_ref_ent.angles, playeranglesrel);
    } else {
      playerangles = playeranglesrel;
    }

    playerforward = vectorNormalize(anglesToForward(playerangles));
    trace = scripts\engine\trace::_bullet_trace(playereye, playereye + playerforward * tracedist, 1, self, 0, 1, 0, 0, 0);
    enemies = getaiarray("axis");
    weapon = self getcurrentweapon();
    results["start"] = distance(playereye, trace["position"]);
    results["end"] = results["start"];

    foreach(enemy in enemies) {
      enemyaware = enemy isenemyaware();
      enemyseen = enemy hasenemybeenseen(playerforgetenemytime);

      if(!enemyaware && !enemyseen) {
        continue;
      }

      enemydir = vectorNormalize(enemy.origin - playereye);
      dot = vectordot(playerforward, enemydir);

      if(dot < 0.923) {
        continue;
      }

      distfrom = distance(playereye, enemy.origin);

      if(distfrom < results["start"]) {
        results["start"] = distfrom;
      }

      distfromfar = min(distfrom, maxenemydist);

      if(distfromfar > results["end"]) {
        results["end"] = distfromfar;
      }
    }

    return results;
  }

  function javelin_dof(trace, enemies, playereye, playerforward, adsfrac) {
    if(adsfrac < 0.88) {
      dof_disable_ads();
      return;
    }

    nearend = 10000;
    farstart = -1;
    nearend = 2400;
    nearstart = 2400;

    for(index = 0; index < enemies.size; index++) {
      enemydir = vectorNormalize(enemies[index].origin - playereye);
      dot = vectordot(playerforward, enemydir);

      if(dot < 0.923) {
        continue;
      }

      distfrom = distance(playereye, enemies[index].origin);

      if(distfrom < 2500) {
        distfrom = 2500;
      }

      if(distfrom - 30 < nearend) {
        nearend = distfrom - 30;
      }

      if(distfrom + 30 > farstart) {
        farstart = distfrom + 30;
      }
    }

    if(nearend > farstart) {
      nearend = 2400;
      farstart = 3000;
    } else {
      if(nearend < 50) {
        nearend = 50;
      }

      if(farstart > 2500) {
        farstart = 2500;
      } else if(farstart < 1000) {
        farstart = 1000;
      }
    }

    tracedist = distance(playereye, trace["position"]);

    if(tracedist < 2500) {
      tracedist = 2500;
    }

    if(nearend > tracedist) {
      nearend = tracedist - 30;
    }

    if(nearend < 1) {
      nearend = 1;
    }

    if(farstart < tracedist) {
      farstart = tracedist;
    }

    if(nearstart >= nearend) {
      nearstart = nearend - 1;
    }

    farend = farstart * 4;
    nearblur = 4;
    farblur = 1.8;
    dof_enable_ads(nearstart, nearend, nearblur, farstart, farend, farblur, adsfrac);
  }

  function dof_update() {
    assert(isPlayer(self));

    thread dof_debug();

    while(true) {
      waitframe();

      if(level.level_specific_dof) {
        continue;
      }

      if(getdvarint(@ "scr_art_tweak")) {
        continue;
      }

      if(!getdvarint(@ "hash_1b022342555479ae")) {
        continue;
      }

      if(getdvarint(@ "hash_62c917f9692eb820")) {
        adsfrac = self playerads();

        if(adsfrac > 0) {
          results = dof_process_physical_ads(adsfrac);
          self setadsphysicaldepthoffield(results["start"], results["end"]);
        }

        continue;
      }

      dof_process_ads();
      dof_calc_results();
      nearstart = level.dof["results"]["current"]["nearStart"];
      nearend = level.dof["results"]["current"]["nearEnd"];
      farstart = level.dof["results"]["current"]["farStart"];
      farend = level.dof["results"]["current"]["farEnd"];
      nearblur = level.dof["results"]["current"]["nearBlur"];
      farblur = level.dof["results"]["current"]["farBlur"];
      self setdepthoffield(nearstart, nearend, farstart, farend, nearblur, farblur);
    }
  }

  function dof_debug() {
    assert(isPlayer(self));
    setdvarifuninitialized(@ "hash_3c32490464e4a898", "<dev string:x20>");

    while(true) {
      while(true) {
        if(getDvar(@ "hash_3c32490464e4a898") != "<dev string:x20>") {
          break;
        }

        wait 0.5;
      }

      thread dof_debug_start();

      while(true) {
        if(getDvar(@ "hash_3c32490464e4a898") == "<dev string:x20>") {
          break;
        }

        wait 0.5;
      }

      thread dof_debug_stop();
    }
  }

  function function_765fd4b0dd3eb439(layername, xval, yval) {
    textelem = newhudelem();
    textelem.x = xval;
    textelem.y = yval;
    textelem.alignx = "<dev string:x209>";
    textelem.aligny = "<dev string:x20e>";
    textelem.horzalign = "<dev string:x212>";
    textelem.vertalign = "<dev string:x212>";
    textelem.font = "<dev string:x21d>";
    textelem.fontscale = 0.5;
    textelem settext(layername);
    barelem = newhudelem();
    barelem.x = xval + 240;
    barelem.y = yval;
    barelem.alignx = "<dev string:x209>";
    barelem.aligny = "<dev string:x20e>";
    barelem.horzalign = "<dev string:x212>";
    barelem.vertalign = "<dev string:x212>";
    barelem setshader("<dev string:x228>", 1, 8);
    textelem.bar = barelem;
    level.var_335b99f5e3345111[layername] = textelem;
  }

  function function_5fec5d34ce09afd(layername) {
    elem = level.var_335b99f5e3345111[layername];

    if(layername == "<dev string:x22e>") {
      layername = "<dev string:xcf>";
      nearstart = "<dev string:x236>";
      nearend = "<dev string:x239>";
      nearblur = "<dev string:x23c>";
      farstart = "<dev string:x23f>";
      farend = "<dev string:x242>";
      farblur = "<dev string:x245>";
      weight = "<dev string:x248>";
      actual_weight = 0;
    } else {
      nearstart = math::round_float(level.dof[layername]["<dev string:x27>"]["<dev string:x2f>"], 2);
      nearend = math::round_float(level.dof[layername]["<dev string:x27>"]["<dev string:x39>"], 2);
      nearblur = math::round_float(level.dof[layername]["<dev string:x27>"]["<dev string:x51>"], 2);
      farstart = math::round_float(level.dof[layername]["<dev string:x27>"]["<dev string:x41>"], 2);
      farend = math::round_float(level.dof[layername]["<dev string:x27>"]["<dev string:x4a>"], 2);
      farblur = math::round_float(level.dof[layername]["<dev string:x27>"]["<dev string:x5a>"], 2);
      weight = math::round_float(level.dof[layername]["<dev string:x27>"]["<dev string:x24a>"], 2);
      actual_weight = level.dof[layername]["<dev string:x27>"]["<dev string:x24a>"];
    }

    layer_width = 10;
    value_width = 8;
    text = layername;

    for(i = 0; i < layer_width - layername.size; i++) {
      text += "<dev string:x251>";
    }

    text += nearstart;

    for(i = 0; i < value_width - string(nearstart).size; i++) {
      text += "<dev string:x251>";
    }

    text += nearend;

    for(i = 0; i < value_width - string(nearend).size; i++) {
      text += "<dev string:x251>";
    }

    text += nearblur;

    for(i = 0; i < value_width - string(nearblur).size; i++) {
      text += "<dev string:x251>";
    }

    text += farstart;

    for(i = 0; i < value_width - string(farstart).size; i++) {
      text += "<dev string:x251>";
    }

    text += farend;

    for(i = 0; i < value_width - string(farend).size; i++) {
      text += "<dev string:x251>";
    }

    text += farblur;

    for(i = 0; i < value_width - string(farblur).size; i++) {
      text += "<dev string:x251>";
    }

    text += weight;
    elem settext(text);
    bar_width = 100;
    bar = elem.bar;
    bar setshader("<dev string:x228>", int(bar_width * actual_weight), 8);
  }

  function dof_debug_start() {
    level notify("<dev string:x253>");
    level endon("<dev string:x253>");
    x = 40;
    y = 40;
    yspacing = 10;
    level.var_335b99f5e3345111 = [];
    function_765fd4b0dd3eb439("<dev string:x22e>", x, y);
    y += yspacing;
    function_765fd4b0dd3eb439("<dev string:x22>", x, y);
    y += yspacing;
    function_765fd4b0dd3eb439("<dev string:x262>", x, y);
    y += yspacing;
    function_765fd4b0dd3eb439("<dev string:x269>", x, y);
    y += yspacing;
    function_765fd4b0dd3eb439("<dev string:x26d>", x, y);
    function_5fec5d34ce09afd("<dev string:x22e>");

    while(true) {
      waitframe();
      function_5fec5d34ce09afd("<dev string:x22>");
      function_5fec5d34ce09afd("<dev string:x262>");
      function_5fec5d34ce09afd("<dev string:x269>");
      function_5fec5d34ce09afd("<dev string:x26d>");
    }
  }

  function dof_debug_stop() {
    level notify("<dev string:x253>");
    level.var_335b99f5e3345111["<dev string:x22e>"].bar destroy();
    level.var_335b99f5e3345111["<dev string:x22>"].bar destroy();
    level.var_335b99f5e3345111["<dev string:x262>"].bar destroy();
    level.var_335b99f5e3345111["<dev string:x269>"].bar destroy();
    level.var_335b99f5e3345111["<dev string:x26d>"].bar destroy();
    level.var_335b99f5e3345111["<dev string:x22e>"] destroy();
    level.var_335b99f5e3345111["<dev string:x22>"] destroy();
    level.var_335b99f5e3345111["<dev string:x262>"] destroy();
    level.var_335b99f5e3345111["<dev string:x269>"] destroy();
    level.var_335b99f5e3345111["<dev string:x26d>"] destroy();
    level.var_335b99f5e3345111 = undefined;
  }

  function tess_init() {
    using_tessellation = getDvar(@ "hash_3914a6109ddfa630");

    if(using_tessellation == "") {
      return;
    }

    level.tess = spawnStruct();
    level.tess.cutoff_distance_current = 635;
    level.tess.cutoff_distance_goal = level.tess.cutoff_distance_current;
    level.tess.cutoff_falloff_current = 587;
    level.tess.cutoff_falloff_goal = level.tess.cutoff_falloff_current;
    level.tess.time_remaining = 0;
    setsaveddvar(@ "hash_24a1cc28fae4c8e2", level.tess.cutoff_distance_current);
    setsaveddvar(@ "hash_d786b6ac5e30f145", level.tess.cutoff_falloff_current);

    foreach(player in level.players) {
      player thread tess_update();
    }
  }

  function tess_set_goal(cutoff_distance, cutoff_falloff, blend_time) {
    level.tess.cutoff_distance_goal = cutoff_distance;
    level.tess.cutoff_falloff_goal = cutoff_falloff;
    level.tess.time_remaining = blend_time;
  }

  function tess_update() {
    assert(isPlayer(self));

    while(true) {
      var_8e82e2ee78f6c824 = level.tess.cutoff_distance_current;
      var_7d417327139f9f5f = level.tess.cutoff_falloff_current;
      waitframe();

      if(level.tess.time_remaining > 0) {
        frames = level.tess.time_remaining * 20;
        distance_increment = (level.tess.cutoff_distance_goal - level.tess.cutoff_distance_current) / frames;
        falloff_increment = (level.tess.cutoff_falloff_goal - level.tess.cutoff_falloff_current) / frames;
        level.tess.cutoff_distance_current += distance_increment;
        level.tess.cutoff_falloff_current += falloff_increment;
        level.tess.time_remaining -= 0.05;
      } else {
        level.tess.cutoff_distance_current = level.tess.cutoff_distance_goal;
        level.tess.cutoff_falloff_current = level.tess.cutoff_falloff_goal;
      }

      if(var_8e82e2ee78f6c824 != level.tess.cutoff_distance_current) {
        setsaveddvar(@ "hash_24a1cc28fae4c8e2", level.tess.cutoff_distance_current);
      }

      if(var_7d417327139f9f5f != level.tess.cutoff_falloff_current) {
        setsaveddvar(@ "hash_d786b6ac5e30f145", level.tess.cutoff_falloff_current);
      }
    }
  }

  function hud_init() {
    listsize = 7;
    hudelems = [];
    spacer = 15;
    div = int(listsize / 2);
    org = 240 - div * spacer;
    alphainc = 0.5 / div;
    alpha = alphainc;

    for(i = 0; i < listsize; i++) {
      hudelems[i] = _newhudelem();
      hudelems[i].location = 0;
      hudelems[i].alignx = "<dev string:x209>";
      hudelems[i].aligny = "<dev string:x275>";
      hudelems[i].foreground = 1;
      hudelems[i].fontscale = 2;
      hudelems[i].sort = 20;

      if(i == div) {
        hudelems[i].alpha = 1;
      } else {
        hudelems[i].alpha = alpha;
      }

      hudelems[i].x = 20;
      hudelems[i].y = org;
      hudelems[i] _settext("<dev string:x27c>");

      if(i == div) {
        alphainc *= -1;
      }

      alpha += alphainc;
      org += spacer;
    }

    level.spam_group_hudelems = hudelems;
    crosshair = _newhudelem();
    crosshair.location = 0;
    crosshair.alignx = "<dev string:x27e>";
    crosshair.aligny = "<dev string:x285>";
    crosshair.foreground = 1;
    crosshair.fontscale = 2;
    crosshair.sort = 20;
    crosshair.alpha = 1;
    crosshair.x = 320;
    crosshair.y = 244;
    crosshair _settext("<dev string:x27c>");
    level.crosshair = crosshair;
    crosshair = _newhudelem();
    crosshair.location = 0;
    crosshair.alignx = "<dev string:x27e>";
    crosshair.aligny = "<dev string:x285>";
    crosshair.foreground = 1;
    crosshair.fontscale = 2;
    crosshair.sort = 20;
    crosshair.alpha = 0;
    crosshair.x = 320;
    crosshair.y = 244;
    crosshair setvalue(0);
    level.crosshair_value = crosshair;
  }

  function _newhudelem() {
    if(!isDefined(level.scripted_elems)) {
      level.scripted_elems = [];
    }

    elem = newhudelem();
    level.scripted_elems[level.scripted_elems.size] = elem;
    return elem;
  }

  function _settext(text) {
    self.realtext = text;
    self setdevtext("<dev string:x28c>");
    thread _clearalltextafterhudelem();
    var_bff8d89bfd98e29f = 0;

    foreach(elem in level.scripted_elems) {
      if(isDefined(elem.realtext)) {
        var_bff8d89bfd98e29f += elem.realtext.size;
        elem setdevtext(elem.realtext);
      }
    }

    println("<dev string:x28e>" + var_bff8d89bfd98e29f);
  }

  function _clearalltextafterhudelem() {
    if(level._clearalltextafterhudelem) {
      return;
    }

    level._clearalltextafterhudelem = 1;
    self clearalltextafterhudelem();
    wait 0.05;
    level._clearalltextafterhudelem = 0;
  }

  function reset_cmds() {
    setdevdvar(@ "hash_de86d29dde73df", 0);
    setdevdvar(@ "hash_cc21f65bade3fb07", 0);
  }

  function set_veil_weights(val) {
    switch (val) {
      case 1:
        setsaveddvar(@ "hash_c783a19d256907f8", "1 0.95 0.75");
        setsaveddvar(@ "hash_c783a49d25690e91", "0.25 0.875 0.02");
        break;
      case 2:
        setsaveddvar(@ "hash_c783a19d256907f8", "1 0.9 0.6");
        setsaveddvar(@ "hash_c783a49d25690e91", "0.3 0.05 0.02");
        break;
      case 3:
        setsaveddvar(@ "hash_c783a19d256907f8", "1 0.6875 0.375");
        setsaveddvar(@ "hash_c783a49d25690e91", "0.1875 0.1013 0.02");
        break;
      case 4:
        setsaveddvar(@ "hash_c783a19d256907f8", "1 0.98 0.7");
        setsaveddvar(@ "hash_c783a49d25690e91", "0.2 0.05 0.0");
        break;
      case 5:
        setsaveddvar(@ "hash_c783a19d256907f8", "1 0.4 0.15");
        setsaveddvar(@ "hash_c783a49d25690e91", "0.1 0.0750 0.15");
        break;
      default:
        setsaveddvar(@ "hash_c783a19d256907f8", "0.25 0.75 1.5");
        setsaveddvar(@ "hash_c783a49d25690e91", "2 2.5 3");
        break;
    }
  }