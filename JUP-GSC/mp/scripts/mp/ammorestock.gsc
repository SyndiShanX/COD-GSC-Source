/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\ammorestock.gsc
***********************************************/

#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\structspawnconfig;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\hud_message;
#using scripts\mp\poi;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace ammorestock;

function init() {
  level.var_644bc8d2faa9b475 = [];

  if(!isDefined(level.ammorestocklocs)) {
    level.ammorestocklocs = [];
  }

  var_ae19c7aac20a601e = getdvarint(@ "scr_ssc_use_ammorestock", 0) && getdvarint(@ "scr_ssc_enabled", 0);

  if(var_ae19c7aac20a601e) {
    scripts\mp\flags::function_1240434f4201ac9d("ssc_initialized");
    scripts\cp_mp\structspawnconfig::function_4f7660cfd85cd517("ammorestock", &function_894dae288a77a345);
    scripts\cp_mp\structspawnconfig::function_412f527ef0863f0e("ammorestock", &function_36ce14880a825268);
    scripts\cp_mp\structspawnconfig::function_f0492c3bdbb3fd52("ammorestock", &function_e826dc20352b1553);
    scripts\cp_mp\structspawnconfig::function_eded5b87f8f7bdfd("ammorestock", &function_63ad07bb8a0640b8);
  } else {
    wait 10;
    ammorestocklocs = getEntArray("ammo_restock_location", "targetname");

    if(isDefined(level.var_34fbfd58680be323)) {
      var_2b1b64456ebbec3a = [[level.var_34fbfd58680be323]](ammorestocklocs);
    }

    function_d5027fd97b7c561d();
    println("<dev string:x1c>" + ter_op(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()), scripts\cp_mp\utility\game_utility::getlocaleid(), "<dev string:x3f>") + "<dev string:x47>" + ammorestocklocs.size);

    foreach(loc in ammorestocklocs) {
      var_c3e7e5ca1b13e5e7 = isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(loc.script_noteworthy) && loc.script_noteworthy != level.localeid;
      isduplicate = duplicatecheck(loc);
      isglobal = isDefined(loc.script_gameobjectname) && loc.script_gameobjectname == "br";
      allowglobal = scripts\cp_mp\utility\game_utility::isbrstylegametype() || function_7923460ce1ee31c5(loc) || istrue(level.var_c08515cf7167fb94);

      if(!istrue(level.useammorestocklocs) || var_c3e7e5ca1b13e5e7 && !function_6c420d3454dae534(loc) || isduplicate || isglobal && !allowglobal) {
        removelocation(loc);
        continue;
      }

      if(scripts\mp\poi::function_47d356083884f913() && !scripts\mp\poi::function_9c93e67f90980177(loc.origin)) {
        removelocation(loc);
        continue;
      }

      if(isDefined(loc.script_string) && isglobal) {
        brsubgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();
        tokens = strtok(loc.script_string, " ");

        if(tokens.size > 0 && array_contains(tokens, brsubgametype)) {
          removelocation(loc);
          continue;
        }
      }

      println("<dev string:x5f>" + loc.origin + "<dev string:x8c>" + ter_op(isDefined(loc.script_noteworthy), loc.script_noteworthy, "<dev string:x3f>") + "<dev string:xa6>" + ter_op(isDefined(loc.script_string), loc.script_string, "<dev string:x3f>"));
      addlocation(loc);
    }

    if(isDefined(level.localeid) && level.localeid == "locale_6") {
      ammorestock_customlocale6cleanup();
    }

    function_a960b3792f77c29();
  }

  scripts\engine\scriptable::scriptable_addusedcallbackbypart("military_ammo_restock", &ammorestock_used);

  if(issharedfuncdefined("ammorestock", "ammorestockGametypeInit")) {
    [[getsharedfunc("ammorestock", "ammorestockGametypeInit")]]();
  }
}

function removelocation(loc) {
  println("<dev string:xbc>" + loc.origin + "<dev string:x8c>" + ter_op(isDefined(loc.script_noteworthy), loc.script_noteworthy, "<dev string:x3f>") + "<dev string:xa6>" + ter_op(isDefined(loc.script_string), loc.script_string, "<dev string:x3f>"));

  if(isDefined(loc.target)) {
    targetents = getEntArray(loc.target, "targetname");

    if(targetents.size > 0) {
      foreach(ent in targetents) {
        ent delete();
      }
    }

    targetents = getentitylessscriptablearray(loc.target, "targetname");

    if(targetents.size > 0) {
      foreach(scriptable in targetents) {
        scriptable setscriptablepartstate("military_ammo_restock", "hidden");
      }
    }
  }

  if(getdvarint(@ "hash_d684f98557413539", 0) == 1) {
    print3d(loc.origin + (0, 0, 100), "<dev string:xeb>" + loc.origin[0] + "<dev string:xf1>" + loc.origin[1] + "<dev string:xf1>" + loc.origin[2] + "<dev string:xf7>", (1, 1, 1), 1, 1, 9999, 1);
    thread scripts\cp_mp\utility\debug_utility::drawline(loc.origin, loc.origin + (0, 0, 5000), 600, (1, 0, 0));
  }

  loc delete();
}

function spawnlocation(struct) {
  spawnmodel(struct);
  spawncollision(struct);
  return struct;
}

function addlocation(loc) {
  if(!isDefined(level.ammorestocklocs)) {
    level.ammorestocklocs = [];
  }

  if(function_9b45d31903431d9b(loc)) {
    return;
  }

  function_54f6e59d9cc6d3e2(loc);

  if(getdvarint(@ "hash_d684f98557413539", 0) == 1) {
    print3d(loc.origin + (0, 0, 200), "<dev string:xeb>" + loc.origin[0] + "<dev string:xf1>" + loc.origin[1] + "<dev string:xf1>" + loc.origin[2] + "<dev string:xf7>", (1, 1, 1), 1, 1, 9999, 1);
    thread scripts\cp_mp\utility\debug_utility::drawline(loc.origin, loc.origin + (0, 0, 2000), 600, (0, 1, 0));
    thread scripts\cp_mp\utility\debug_utility::drawsphere(loc.origin, 128, 600, (0, 1, 0));
  }

  loc.timeplayerused = [];
  level.ammorestocklocs[level.ammorestocklocs.size] = loc;
}

function function_9cabc01b47357528(loc) {
  loc.disabled = 1;

  if(isDefined(loc.target)) {
    targetents = getEntArray(loc.target, "targetname");
    var_907afab39ec51cb2 = getentitylessscriptablearray(loc.target, "targetname");
    var_8cf6cefd9a30362c = array_combine(targetents, var_907afab39ec51cb2);

    if(var_8cf6cefd9a30362c.size > 0) {
      foreach(ent in var_8cf6cefd9a30362c) {
        ent setscriptablepartstate("military_ammo_restock", "disabled");
      }
    }
  }
}

function function_bae375f2dcee0889(loc) {
  loc.disabled = undefined;

  if(isDefined(loc.target)) {
    targetents = getEntArray(loc.target, "targetname");
    var_907afab39ec51cb2 = getentitylessscriptablearray(loc.target, "targetname");
    toenable = array_combine(targetents, var_907afab39ec51cb2);

    if(toenable.size > 0) {
      var_6d661c09a2ee037b = ter_op(scripts\cp_mp\utility\game_utility::isbrstylegametype(), @ "hash_9946861f4644413f", @ "hash_c95a149e3fb09e8c");
      var_2e6129bc01d788fe = getDvar(var_6d661c09a2ee037b, "ON");
      state = undefined;

      if(var_2e6129bc01d788fe == "ON") {
        state = "useable_on";
      } else if(var_2e6129bc01d788fe == "OFF") {
        state = "useable_on_no_icon";
      }

      if(!isDefined(state)) {
        return;
      }

      foreach(ammocache in toenable) {
        ammocache setscriptablepartstate("military_ammo_restock", state);
      }
    }
  }
}

function function_64716349b6b346ee() {
  level.var_1d5700ca4212f585 = 1;

  foreach(loc in level.ammorestocklocs) {
    function_9cabc01b47357528(loc);
  }
}

function function_6c420d3454dae534(loc) {
  switch (level.mapname) {
    case #"hash_c8b70146f0c8a9cd":
    case #"hash_decd2e8ff1f996d7":
      return true;
    case #"hash_5586b38644ed9b26":
      if(loc.script_noteworthy == "locale_28" || loc.script_noteworthy == "locale_34") {
        return true;
      }

      break;
    case #"hash_a11e6e81ea219453":
      if(loc.script_noteworthy == "locale_50" || loc.script_noteworthy == "locale_51") {
        return true;
      }

      break;
    case #"hash_3e552e81b4a21fff":
      if(loc.script_noteworthy == "locale_26" || loc.script_noteworthy == "locale_27") {
        return true;
      }

      break;
    case #"hash_ec2ebc1298ef7373":
      if(loc.script_noteworthy == "locale_22" || loc.script_noteworthy == "locale_88") {
        return true;
      }

      break;
    case #"hash_d707e2cfc340c376":
      if(loc.script_noteworthy == "locale_24" || loc.script_noteworthy == "locale_25") {
        return true;
      }

      break;
  }

  return false;
}

function function_7923460ce1ee31c5(loc) {
  switch (level.mapname) {
    case #"hash_a11e6e81ea219453":
      if(distance2dsquared(loc.origin, (-34993, -21635.7, 308)) < 65536) {
        return true;
      }

      break;
    case #"hash_5586b38644ed9b26":
      if(distance2dsquared(loc.origin, (2248.88, -38875.6, 216)) < 65536) {
        return true;
      }

      break;
    case #"hash_c8b70146f0c8a9cd":
      if(distance2dsquared(loc.origin, (22721.7, 23480.7, 1668.93)) < 65536) {
        return true;
      }

      break;
  }

  return false;
}

function private function_894dae288a77a345(structname) {
  return getEntArray("ammo_restock_location", "targetname");
}

function private function_36ce14880a825268(structname, loc) {
  addlocation(loc);
  return loc;
}

function private function_e826dc20352b1553(structname, loc) {
  removelocation(loc);
}

function private function_63ad07bb8a0640b8(structname) {
  function_d5027fd97b7c561d();
  function_a960b3792f77c29();
}

function private function_a960b3792f77c29() {
  var_6d661c09a2ee037b = ter_op(scripts\cp_mp\utility\game_utility::isbrstylegametype(), @ "hash_9946861f4644413f", @ "hash_c95a149e3fb09e8c");
  var_2e6129bc01d788fe = getDvar(var_6d661c09a2ee037b, "ON");

  foreach(ammocache in level.ammorestocklocs) {
    if(!isDefined(ammocache.target)) {
      continue;
    }

    foreach(ammoent in getEntArray(ammocache.target, "targetname")) {
      if(!ammoent isscriptable()) {
        continue;
      }

      if(var_2e6129bc01d788fe == "ON") {
        ammoent setscriptablepartstate("military_ammo_restock", "useable_on");
      } else if(var_2e6129bc01d788fe == "OFF") {
        ammoent setscriptablepartstate("military_ammo_restock", "useable_on_no_icon");
      }

      break;
    }
  }
}

function private function_d5027fd97b7c561d() {
  level.ammorestockclip = undefined;

  foreach(loc in level.ammorestocklocs) {
    if(isDefined(loc.target)) {
      foreach(ent in getEntArray(loc.target, "targetname")) {
        if(ent.classname == "script_brushmodel") {
          collisionarr = getEntArray("tactical_cover_col", "targetname");
          origin = collisionarr[0].origin;
          angles = collisionarr[0].angles;
          model = spawn("script_model", origin);
          model.angles = angles;
          model clonebrushmodeltoscriptmodel(ent);
          level.ammorestockclip = model;
          break;
        }
      }
    }

    if(isDefined(level.ammorestockclip)) {
      break;
    }
  }
}

function function_54f6e59d9cc6d3e2(loc) {
  switch (level.mapname) {
    case #"hash_5586b38644ed9b26":
      break;
    case #"hash_c8b70146f0c8a9cd":
      if(distance2dsquared(loc.origin, (26214, 33992, 1650)) < 65536) {
        origin = (26215, 33993.5, 1624);
        angles = loc.angles + (0, 180, 0);
        model = spawn("script_model", origin);
        model.angles = angles;
        model setModel("military_ammo_restock_location");
      }

      if(distance2dsquared(loc.origin, (25609.8, 31617.3, 1669.66)) < 65536) {
        origin = (25642, 31626, 1625);
        angles = loc.angles + (0, 180, 0);
        model = spawn("script_model", origin);
        model.angles = angles;
        model setModel("military_ammo_restock_location");
      }

      if(distance2dsquared(loc.origin, (27155.5, 27512.2, 1777.76)) < 65536) {
        if(isDefined(level.ammorestockclip)) {
          origin = (27186.1, 27524.5, 1760);
          angles = loc.angles + (0, 315, 0);
          model = spawn("script_model", origin);
          model.angles = angles;
          model clonebrushmodeltoscriptmodel(level.ammorestockclip);
        }
      }

      if(distance2dsquared(loc.origin, (28623.1, 31207.5, 1681.75)) < 65536) {
        spawnmodel(loc);
      }

      break;
    case #"hash_3e552e81b4a21fff":
      if(distance2dsquared(loc.origin, (-7699.69, 50690.9, 284.391)) < 65536) {
        spawnmodel(loc);
      }

      if(distance2dsquared(loc.origin, (-5924.76, 44588.8, 284.861)) < 65536) {
        spawncollision(loc);
      }

      if(distance2dsquared(loc.origin, (-7280.71, 48236.9, 443.596)) < 65536) {
        model = spawnmodel(loc);
        col = spawncollision(loc);
      }

      if(distance2dsquared(loc.origin, (-9064.73, 41041, 300.758)) < 65536) {
        model = spawnmodel(loc);
        col = spawncollision(loc);
      }

      if(distance2dsquared(loc.origin, (-10185.3, 35049.8, 547.523)) < 65536) {
        model = spawnmodel(loc);
        col = spawncollision(loc);
      }

      if(distance2dsquared(loc.origin, (-7660.12, 35053.6, 332.271)) < 65536) {
        model = spawnmodel(loc);
        model.origin += anglestoright(model.angles) * 64;
      }

      break;
  }
}

function spawnmodel(loc) {
  origin = loc.origin + (-9.04004, -31.8008, -44);
  angles = loc.angles + (0, 180, 0);
  model = spawn("script_model", origin);
  model.angles = angles;
  model setModel("military_ammo_restock_location");
  return model;
}

function spawncollision(loc) {
  if(!isDefined(level.ammorestockclip)) {
    return;
  }

  origin = loc.origin + (-9.04004, -31.8008, -19.861);
  angles = loc.angles + (0, 90.901, 0);
  col = spawn("script_model", origin);
  col.angles = angles;
  col clonebrushmodeltoscriptmodel(level.ammorestockclip);
  return col;
}

function duplicatecheck(loc) {
  foreach(ammocache in level.ammorestocklocs) {
    if(distance2dsquared(loc.origin, ammocache.origin) < 65536) {
      return true;
    }
  }

  return false;
}

function function_9b45d31903431d9b(loc) {
  switch (level.mapname) {
    case #"hash_decd2e8ff1f996d7":
      if(distance2dsquared(loc.origin, (27585, -29335, 3209)) < 65536 || distance2dsquared(loc.origin, (32187.5, -34962.8, 3139.13)) < 65536 || distance2dsquared(loc.origin, (22908.5, -31250.1, 3192)) < 65536) {
        removelocation(loc);
        return true;
      }

      break;
    case #"hash_c8b70146f0c8a9cd":
      if(distance2dsquared(loc.origin, (34922, 16940, 1550)) < 65536 || distance2dsquared(loc.origin, (29681, 33095.8, 1674)) < 65536 || distance2dsquared(loc.origin, (30032.3, 29652.4, 1669.66)) < 65536 || distance2dsquared(loc.origin, (28574.3, 28187.4, 1674)) < 65536 || distance2dsquared(loc.origin, (31164.6, 32598.1, 1666)) < 65536 || distance2dsquared(loc.origin, (24806.9, 29899.7, 1680)) < 65536 || distance2dsquared(loc.origin, (25007.2, 26987.8, 1293)) < 65536 || distance2dsquared(loc.origin, (27094.5, 29440, 1674)) < 65536 || distance2dsquared(loc.origin, (26380.5, 25555.4, 1677.27)) < 65536 || distance2dsquared(loc.origin, (28506.1, 22508.5, 1914.25)) < 65536 || distance2dsquared(loc.origin, (30202.3, 23396.5, 1332.92)) < 65536 || distance2dsquared(loc.origin, (21877, 27019, 1668)) < 65536 || distance2dsquared(loc.origin, (29313.7, 25313, 1258.43)) < 65536) {
        removelocation(loc);
        return true;
      }

      break;
    case #"hash_3e552e81b4a21fff":
    case #"hash_ec2ebc1298ef7373":
      if(distance2dsquared(loc.origin, (-24068.8, -5005.74, 2080)) < 65536 || distance2dsquared(loc.origin, (-6611.97, 50858, 288.512)) < 65536 || distance2dsquared(loc.origin, (-7647.53, 49632.1, 329.7)) < 65536 || distance2dsquared(loc.origin, (-10818.5, 47390.5, 274.765)) < 65536 || distance2dsquared(loc.origin, (-9077.3, 47987.4, 360.799)) < 65536 || distance2dsquared(loc.origin, (-8043.09, 46428.5, 403.384)) < 65536 || distance2dsquared(loc.origin, (-8052.51, 44386.2, 306.807)) < 65536 || distance2dsquared(loc.origin, (-9094.11, 44151.5, 297.895)) < 65536 || distance2dsquared(loc.origin, (-8235.79, 43038.2, 306.207)) < 65536 || distance2dsquared(loc.origin, (-6724.8, 42424.4, 259.02)) < 65536 || distance2dsquared(loc.origin, (-7015.17, 40804.3, 218.733)) < 65536 || distance2dsquared(loc.origin, (-10678.2, 42638.1, 271.852)) < 65536 || distance2dsquared(loc.origin, (-9775.65, 40978.9, 132.481)) < 65536 || distance2dsquared(loc.origin, (-8632.71, 39498, 263.335)) < 65536 || distance2dsquared(loc.origin, (-8842.61, 41604.6, 305.341)) < 65536 || distance2dsquared(loc.origin, (-10148.6, 39588, 294.909)) < 65536 || distance2dsquared(loc.origin, (-7032.02, 36217.1, 552.224)) < 65536 || distance2dsquared(loc.origin, (-7850.63, 37874.3, 422.542)) < 65536 || distance2dsquared(loc.origin, (-7595.55, 34161, 310.81)) < 65536 || distance2dsquared(loc.origin, (-23719.8, -3455.37, 2102.24)) < 65536) {
        removelocation(loc);
        return true;
      }
    case #"hash_5586b38644ed9b26":
      if(distance2dsquared(loc.origin, (6003.04, -38388.4, 256.987)) < 65536 || distance2dsquared(loc.origin, (4172.42, -36837.8, 333.041)) < 65536 || distance2dsquared(loc.origin, (1273.09, -41459.6, 257)) < 65536 || distance2dsquared(loc.origin, (1311.22, -39883.5, 252.392)) < 65536 || distance2dsquared(loc.origin, (644.51, -41408, 257)) < 65536 || distance2dsquared(loc.origin, (1594.75, -37749.8, 252)) < 65536 || distance2dsquared(loc.origin, (3059.22, -38664.9, 257.905)) < 65536 || distance2dsquared(loc.origin, (-2121.11, -42953.5, 257.5)) < 65536 || distance2dsquared(loc.origin, (-2971.54, -42092.5, 244)) < 65536 || distance2dsquared(loc.origin, (-4386.93, -43629.1, 242.893)) < 65536 || distance2dsquared(loc.origin, (-2508.26, -40082.4, 428.444)) < 65536 || distance2dsquared(loc.origin, (-4990.83, -45574.4, 247.751)) < 65536 || distance2dsquared(loc.origin, (3173.23, -41330.2, 300)) < 65536) {
        removelocation(loc);
        return true;
      }
    case #"hash_a11e6e81ea219453":
      if(distance2dsquared(loc.origin, (-22231.6, -21681.7, 612)) < 65536 || distance2dsquared(loc.origin, (42365, -4481, 786)) < 65536 || distance2dsquared(loc.origin, (-36878, -23688, 264)) < 65536 || distance2dsquared(loc.origin, (-36012, -22546, 260)) < 65536 || distance2dsquared(loc.origin, (-35208, -24096, 264)) < 65536 || distance2dsquared(loc.origin, (-34808, -22240, 264)) < 65536 || distance2dsquared(loc.origin, (-31860, -22846, 264)) < 65536 || distance2dsquared(loc.origin, (-32038, -20154, 272)) < 65536 || distance2dsquared(loc.origin, (-33783, -23470, 264)) < 65536 || distance2dsquared(loc.origin, (-33930, -21932, 264)) < 65536) {
        removelocation(loc);
        return true;
      }

      break;
  }

  return false;
}

function ammorestock_used(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  assert(part == "<dev string:xfc>");

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    result = function_42f888e2e819cc64(player, instance);

    if(result == 1) {
      brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

      if(scripts\mp\flags::gameflag("prematch_done") && brgametype != "risk" && brgametype != "rumble_mgl") {
        thread ammorestock_disableusefortime(instance, player, 0.1);
        thread function_9f58210b67259ac8(player, instance, getdvarint(@ "hash_c9f983ed98245328", 60));
      } else {
        thread ammorestock_disableusefortime(instance, player, 0.1);
        thread function_9f58210b67259ac8(player, instance, getdvarint(@ "hash_c9f983ed98245328", 5));
      }
    } else if(result == 0) {
      thread ammorestock_disableusefortime(instance, player, 0.1);
    } else {
      thread ammorestock_disableusefortime(instance, player, 0.1);
    }

    return;
  }

  result = ammorestock_playeruse(player, instance);

  if(result == 1) {
    thread ammorestock_disableusefortime(instance, player, 0.1);
    thread function_9f58210b67259ac8(player, instance, getdvarint(@ "hash_c9f983ed98245328", 60));
    return;
  }

  if(result == 0) {
    thread ammorestock_disableusefortime(instance, player, 0.1);
    return;
  }

  thread ammorestock_disableusefortime(instance, player, 0.1);
}

function function_afab07cf819c5ed4(guid) {
  level.var_644bc8d2faa9b475[guid] = undefined;
}

function function_9039bc1e302709d0(guid, instance) {
  level.var_644bc8d2faa9b475[guid][instance.index] = undefined;
}

function function_9f58210b67259ac8(player, instance, time) {
  guid = player getuniqueid();
  level.var_644bc8d2faa9b475[guid][instance.index] = gettime() + time * 1000;
  player waittill_notify_or_timeout("death", time);

  if(!isDefined(player) || !isreallyalive(player)) {
    function_afab07cf819c5ed4(guid);
    return;
  }

  function_9039bc1e302709d0(guid, instance);
}

function ammorestock_disableusefortime(scriptable, player, time) {
  player endon("disconnect");
  scriptable disablescriptableplayeruse(player);
  wait time;
  scriptable enablescriptableplayeruse(player);
}

function function_f4204f5a6ca70972(equipment_name) {
  if(isDefined(equipment_name)) {
    switch (equipment_name) {
      case #"hash_2fd6e4e58e79a638":
      case #"hash_7a24b50365517bba":
      case #"hash_d520713a70b60a2e":
        return false;
      default:
        return true;
    }
  }

  return true;
}

function ammorestock_playeruse(player, instance) {
  player endon("death_or_disconnect");
  guid = player getuniqueid();
  var_d7c2deeaf4ae5481 = 0;
  var_4b6c905e414ac105 = 0;
  var_eb2ee014bd8dd8c8 = 0;
  var_802fc98a6dd8e452 = 0;
  var_9b4d75c81b035943 = 0;
  var_23c42b51b990e86e = 0;
  var_29699fcc443f88f6 = "";

  if(isusingmatchrulesdata()) {
    var_d7c2deeaf4ae5481 = getdvarint(@ "ammoRestockClipNum", getmatchrulesdata("commonOption", "ammoRestockClipNum"));
    var_4b6c905e414ac105 = getdvarint(@ "ammoRestockLauncherClipNum", getmatchrulesdata("commonOption", "ammoRestockLauncherClipNum"));
    var_eb2ee014bd8dd8c8 = getdvarint(@ "ammoRestockSniperClipNum", getmatchrulesdata("commonOption", "ammoRestockSniperClipNum"));
    var_802fc98a6dd8e452 = getdvarint(@ "ammoRestockAllowSuperWeapons", getmatchrulesdata("commonOption", "ammoRestockAllowSuperWeapons"));
    var_9b4d75c81b035943 = getdvarint(@ "ammoRestockForceClipSize", getmatchrulesdata("commonOption", "ammoRestockForceClipSize"));
    var_23c42b51b990e86e = getdvarint(@ "ammoRestockMaxEquipment", getmatchrulesdata("commonOption", "ammoRestockMaxEquipment"));
    var_29699fcc443f88f6 = getmatchrulesdata("commonOption", "ammoRestockAmmoIcon");
  }

  if(!isDefined(level.var_644bc8d2faa9b475[guid])) {
    level.var_644bc8d2faa9b475[guid] = [];
  }

  if(isDefined(level.var_644bc8d2faa9b475[guid][instance.index])) {
    player scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_ON_COOLDOWN", int((level.var_644bc8d2faa9b475[guid][instance.index] - gettime()) / 1000));
    player playlocalsound("br_pickup_deny");
    return 2;
  }

  var_12a372e8caa042bb = player.primaryweapons;
  temparray = [];

  foreach(item in var_12a372e8caa042bb) {
    if(!scripts\mp\utility\weapon::ismeleeonly(item) && (var_802fc98a6dd8e452 || !scripts\mp\utility\weapon::issuperweapon(item)) && !scripts\cp_mp\weapon::iskillstreakweapon(item) && !scripts\mp\utility\weapon::isgamemodeweapon(item)) {
      temparray[temparray.size] = item;
    }
  }

  var_12a372e8caa042bb = temparray;
  var_df04395b59031a4d = 0;

  foreach(weaponobj in var_12a372e8caa042bb) {
    var_55efab49565e8545 = 0;

    if(isaxeweapon(weaponobj)) {
      if(player getweaponammoclip(weaponobj) < weaponclipsize(weaponobj)) {
        continue;
      }
    }

    if(weaponobj.hasalternate) {
      var_6890a4ce965bba99 = weaponobj getaltweapon();

      if(player getweaponammostock(var_6890a4ce965bba99) < weaponmaxammo(var_6890a4ce965bba99)) {
        var_55efab49565e8545 = 1;
      }
    }

    if(weaponmaxammo(weaponobj) <= player getweaponammostock(weaponobj) && !var_55efab49565e8545) {
      var_df04395b59031a4d++;
    }
  }

  var_2a0d5da772612a32 = 0;

  foreach(equipobj in player.equipment) {
    tableinfo = player scripts\mp\equipment::getequipmenttableinfo(equipobj);

    if(isDefined(tableinfo)) {
      var_8c1092aa0a87661 = player scripts\mp\equipment::getequipmentmaxammo(equipobj);
      var_b64209459da65860 = player scripts\mp\equipment::getequipmentammo(equipobj);

      if(var_8c1092aa0a87661 == var_b64209459da65860) {
        var_2a0d5da772612a32++;
      }
    }
  }

  var_a0115a87500b34b = [];
  var_7f227a6adf820843 = 0;

  if(getdvarint(@ "hash_d2b88b5ac40363ee", 0) && isDefined(player.gasmaskhealth) && isDefined(player.gasmaskmaxhealth) && player.gasmaskhealth >= 0 && player.gasmaskhealth < player.gasmaskmaxhealth) {
    player.gasmaskhealth = player.gasmaskmaxhealth;
    player setclientomnvar("ui_gasmask_damage", 1);
    var_7f227a6adf820843 = 1;
  }

  if(var_df04395b59031a4d == var_12a372e8caa042bb.size && var_2a0d5da772612a32 == player.equipment.size && !var_7f227a6adf820843) {
    player scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL");
    player playlocalsound("br_pickup_deny");
    return 0;
  } else {
    foreach(weaponobj in var_12a372e8caa042bb) {
      forceclipsize = var_9b4d75c81b035943;

      if(scripts\engine\utility::issharedfuncdefined("zombie", "get_pap_level")) {
        packlv = player[[scripts\engine\utility::getsharedfunc("zombie", "get_pap_level")]](weaponobj);

        if(packlv > 0) {
          forceclipsize = 1;
        }
      }

      weapongroup = scripts\mp\utility\weapon::getweapongroup(weaponobj);
      clipnum = undefined;

      if(scripts\mp\utility\weapon::issinglehitweapon(weaponobj)) {
        clipnum = var_4b6c905e414ac105 > 0 ? var_4b6c905e414ac105 : 1;
      } else if(weapongroup == "weapon_sniper") {
        clipnum = var_eb2ee014bd8dd8c8 > 0 ? var_eb2ee014bd8dd8c8 : 3;
      } else {
        clipnum = var_d7c2deeaf4ae5481 > 0 ? var_d7c2deeaf4ae5481 : 3;
      }

      if(istrue(weaponobj.hasalternate) && !isaxeweapon(weaponobj)) {
        var_6890a4ce965bba99 = weaponobj getaltweapon();
        var_91093ef03654702c = weaponclass(var_6890a4ce965bba99);

        if(var_91093ef03654702c == "grenade") {
          addammo = scripts\mp\weapons::getammooverride(var_6890a4ce965bba99);
          stockammo = player getweaponammostock(var_6890a4ce965bba99);
          newammo = int(stockammo + addammo);
          player setweaponammostock(var_6890a4ce965bba99, newammo);
        } else if(var_6890a4ce965bba99.type == "bullet") {
          if(getdvarint(@ "hash_9ff8020dd5f23959", 0) && isDefined(var_6890a4ce965bba99.underbarrel) && var_6890a4ce965bba99.underbarrel == "jup_ub_flame_01") {
            player setweaponammoclip(var_6890a4ce965bba99, var_6890a4ce965bba99.clipsize);
          } else if(var_91093ef03654702c == "spread") {
            addammo = scripts\mp\weapons::getammooverride(var_6890a4ce965bba99, forceclipsize);
            stockammo = player getweaponammostock(var_6890a4ce965bba99);
            newammo = int(stockammo + addammo);
            player setweaponammostock(var_6890a4ce965bba99, newammo);
          }
        } else {
          addammo = scripts\mp\weapons::getammooverride(var_6890a4ce965bba99, forceclipsize);
          stockammo = player getweaponammostock(var_6890a4ce965bba99);
          newammo = int(stockammo + addammo);
          player setweaponammostock(var_6890a4ce965bba99, newammo);
        }
      }

      addammo = scripts\mp\weapons::getammooverride(weaponobj, forceclipsize) * clipnum;
      stockammo = player getweaponammostock(weaponobj);
      newammo = int(stockammo + addammo);
      singleclipammo = scripts\mp\weapons::getammooverride(weaponobj, forceclipsize);
      clipammo = player getweaponammoclip(weaponobj);

      if(isaxeweapon(weaponobj)) {
        wasempty = player getweaponammoclip(weaponobj) == 0;
        player setweaponammoclip(weaponobj, weaponclipsize(weaponobj));
      } else if(istrue(level.var_93d3de5b393a5e89)) {
        max_clip_ammo = weaponclipsize(weaponobj);
        var_d7732d0238eae9ff = weaponmaxammo(weaponobj);

        if(scripts\mp\utility\weapon::isakimbo(weaponobj)) {
          player setweaponammoclip(weaponobj, max_clip_ammo, "left");
          player setweaponammoclip(weaponobj, max_clip_ammo, "right");
        } else {
          player setweaponammoclip(weaponobj, max_clip_ammo);
        }

        player setweaponammostock(weaponobj, var_d7732d0238eae9ff);
        addammo = var_d7732d0238eae9ff;
      } else if(weaponobj.basename == "iw8_lm_dblmg_mp") {
        player setweaponammoclip(weaponobj, clipammo + singleclipammo);
      } else {
        player setweaponammostock(weaponobj, newammo);
      }

      fakepickup = spawnStruct();
      fakepickup.count = addammo;
      fakepickup.ref = var_29699fcc443f88f6;
      var_a0115a87500b34b[var_a0115a87500b34b.size] = fakepickup;
    }
  }

  primary = player scripts\mp\equipment::getcurrentequipment("primary");

  if(isDefined(primary) && function_f4204f5a6ca70972(primary)) {
    var_9c161cdc55bf9640 = player scripts\mp\equipment::getequipmentammo(primary);
    var_93622e40b0ae3bdd = player scripts\mp\equipment::getequipmentmaxammo(primary, player.class);

    if(var_9c161cdc55bf9640 < var_93622e40b0ae3bdd) {
      if(var_23c42b51b990e86e) {
        player scripts\mp\equipment::setequipmentslotammo("primary", var_93622e40b0ae3bdd);
      } else {
        player scripts\mp\equipment::incrementequipmentammo(primary);
      }

      addammo = player scripts\mp\equipment::getequipmentammo(primary) - var_9c161cdc55bf9640;

      if(addammo > 0) {
        fakepickup = spawnStruct();
        fakepickup.count = addammo;
        fakepickup.ref = primary;
        var_a0115a87500b34b[var_a0115a87500b34b.size] = fakepickup;
      }
    }
  }

  secondary = player scripts\mp\equipment::getcurrentequipment("secondary");

  if(isDefined(secondary) && function_f4204f5a6ca70972(secondary)) {
    var_9c161cdc55bf9640 = player scripts\mp\equipment::getequipmentammo(secondary);
    var_93622e40b0ae3bdd = player scripts\mp\equipment::getequipmentmaxammo(secondary, player.class);

    if(var_9c161cdc55bf9640 < var_93622e40b0ae3bdd) {
      if(var_23c42b51b990e86e) {
        player scripts\mp\equipment::setequipmentslotammo("secondary", scripts\mp\equipment::getequipmentmaxammo(secondary, player.class));
      } else {
        player scripts\mp\equipment::incrementequipmentammo(secondary);
      }

      addammo = player scripts\mp\equipment::getequipmentammo(secondary) - var_9c161cdc55bf9640;

      if(addammo > 0) {
        fakepickup = spawnStruct();
        fakepickup.count = addammo;
        fakepickup.ref = secondary;
        var_a0115a87500b34b[var_a0115a87500b34b.size] = fakepickup;
      }
    }
  }

  player hudicontype("br_ammo");

  if(var_a0115a87500b34b.size == 0 && !var_7f227a6adf820843) {
    player scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL");
    player playlocalsound("br_pickup_deny");
    return 0;
  }

  if(issharedfuncdefined("game", "showStockLootFeed")) {
    level thread[[getsharedfunc("game", "showStockLootFeed")]](player, var_a0115a87500b34b);
  }

  player playlocalsound("iw9_support_box_use");
  return 1;
}

function function_42f888e2e819cc64(player, instance) {
  player endon("death_or_disconnect");
  guid = player getuniqueid();

  if(!isDefined(level.var_644bc8d2faa9b475[guid])) {
    level.var_644bc8d2faa9b475[guid] = [];
  }

  if(isDefined(level.var_644bc8d2faa9b475[guid][instance.index])) {
    player scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_ON_COOLDOWN", int((level.var_644bc8d2faa9b475[guid][instance.index] - gettime()) / 1000));
    player playlocalsound("br_pickup_deny");
    return 2;
  }

  gaveammo = 0;
  var_509d86412c9d7426 = player getweaponslistprimaries();
  var_12a372e8caa042bb = [];

  foreach(item in var_509d86412c9d7426) {
    if(!scripts\mp\utility\weapon::ismeleeonly(item) && !scripts\mp\utility\weapon::issuperweapon(item) && !scripts\cp_mp\weapon::iskillstreakweapon(item) && !scripts\mp\utility\weapon::isgamemodeweapon(item)) {
      var_12a372e8caa042bb = array_add(var_12a372e8caa042bb, item);
    }
  }

  if(player scripts\mp\utility\killstreak::isjuggernaut()) {
    if(!isDefined(var_509d86412c9d7426) || var_509d86412c9d7426.size == 0) {
      minigun = player getcurrentweapon();
      var_d0bae9fa43b9e424 = player getcurrentweaponclipammo();
      var_e21a1fe75ea20307 = weaponclipsize(minigun);

      if(var_d0bae9fa43b9e424 < var_e21a1fe75ea20307) {
        player setweaponammoclip(minigun, var_e21a1fe75ea20307);
        player hudicontype("br_ammo");
        player playlocalsound("iw9_support_box_use");
        return 1;
      }
    }
  }

  var_fad892a207d23d14 = 1;

  foreach(weaponobj in var_12a372e8caa042bb) {
    if(isaxeweapon(weaponobj)) {
      if(player getweaponammoclip(weaponobj) < weaponclipsize(weaponobj)) {
        var_fad892a207d23d14 = 0;
        break;
      }
    }

    currenttype = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(weaponobj);

    if(isDefined(currenttype)) {
      if(level.var_e6ea72fc5e3fcd00[currenttype] > player getweaponammostock(weaponobj)) {
        var_fad892a207d23d14 = 0;
        break;
      }
    }
  }

  primaryequipment = player scripts\mp\equipment::getcurrentequipment("primary");
  secondaryequipment = player scripts\mp\equipment::getcurrentequipment("secondary");
  var_c7a61b8cf2433e2a = array_removeundefined([primaryequipment, secondaryequipment]);

  if(isDefined(level.var_4a441348252f9629)) {
    foreach(var_521c19050b335c96 in level.var_4a441348252f9629) {
      if(arraycontains(var_c7a61b8cf2433e2a, var_521c19050b335c96)) {
        var_c7a61b8cf2433e2a = arrayremove(var_c7a61b8cf2433e2a, var_521c19050b335c96);
      }
    }
  }

  var_5f947642c6e09e85 = 1;

  foreach(equipment in var_c7a61b8cf2433e2a) {
    var_6088850c9e835589 = player scripts\mp\equipment::getequipmentammo(equipment);
    var_93622e40b0ae3bdd = player scripts\mp\equipment::getequipmentmaxammo(equipment);

    if(var_6088850c9e835589 < var_93622e40b0ae3bdd) {
      var_5f947642c6e09e85 = 0;
      break;
    }
  }

  if(istrue(var_fad892a207d23d14) && istrue(var_5f947642c6e09e85)) {
    player scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL");
    player playlocalsound("br_pickup_deny");
    return 0;
  }

  var_a0115a87500b34b = [];

  foreach(weap in var_12a372e8caa042bb) {
    currenttype = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(weap);
    currentstock = player getweaponammostock(weap);

    if(isDefined(currenttype)) {
      if(level.var_e6ea72fc5e3fcd00[currenttype] <= currentstock) {
        continue;
      }
    }

    if(isaxeweapon(weap) || weap.isalternate && scripts\cp_mp\weapon::function_de04e13ab01e1a10(weap.underbarrel)) {
      clipammo = weaponclipsize(weap);
      newammo = int(clipammo);
      player setweaponammoclip(weap, newammo);
      continue;
    } else if(scripts\cp_mp\weapon::isminigunweapon(weap)) {
      player setweaponammoclip(weap, weap.clipsize);
      continue;
    } else if(!isDefined(currenttype)) {
      continue;
    }

    if(!isDefined(var_a0115a87500b34b[currenttype])) {
      ammogiven = int(min(level.var_e6ea72fc5e3fcd00[currenttype] - currentstock, weaponclipsize(weap) * 2));
      fakepickup = spawnStruct();
      fakepickup.count = ammogiven;
      fakepickup.scriptablename = currenttype;
      fakepickup.stackable = fakepickup.count;
      var_a0115a87500b34b[fakepickup.scriptablename] = fakepickup;
    }

    player scripts\mp\gametypes\br_weapons::br_give_weapon_clip(weap, 2);
  }

  foreach(equipment in var_c7a61b8cf2433e2a) {
    var_93622e40b0ae3bdd = player scripts\mp\equipment::getequipmentmaxammo(equipment);

    if(isDefined(level.br_pickups.br_equipnametoscriptable[equipment]) && !isDefined(var_a0115a87500b34b[level.br_pickups.br_equipnametoscriptable[equipment]])) {
      currentammo = player scripts\mp\equipment::getequipmentammo(equipment);
      ammogiven = var_93622e40b0ae3bdd - currentammo;
      fakepickup = spawnStruct();
      fakepickup.count = ammogiven;
      fakepickup.scriptablename = level.br_pickups.br_equipnametoscriptable[equipment];
      fakepickup.stackable = fakepickup.count;
      var_a0115a87500b34b[fakepickup.scriptablename] = fakepickup;
    }

    player scripts\mp\equipment::incrementequipmentammo(equipment, var_93622e40b0ae3bdd);
  }

  player hudicontype("br_ammo");
  level thread function_ce0d11003cb7ba99(player, var_a0115a87500b34b);
  player playlocalsound("iw9_support_box_use");
  return 1;
}

function function_ce0d11003cb7ba99(player, var_a0115a87500b34b) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  count = 0;

  foreach(item in var_a0115a87500b34b) {
    count++;
    waittime = 0.1;

    if(count % 3 == 0) {
      waittime = 1.5;
    }

    if(!isDefined(item.count) || item.count <= 0) {
      continue;
    }

    if(!isDefined(item.scriptablename)) {
      continue;
    }

    player scripts\mp\gametypes\br_pickups::updatelootsplash(item);
    wait waittime;
  }
}

function ammorestock_customlocale6cleanup() {
  var_79d6f370510c1f94 = [];
  var_79d6f370510c1f94[0] = (15946, -71, -469);
  var_79d6f370510c1f94[1] = (16829, -8996, -333);
  var_79d6f370510c1f94[2] = (16531, -13847, -154);
  var_79d6f370510c1f94[3] = (24472, -14782, -134);
  var_79d6f370510c1f94[4] = (22373, -19948, -36);
  var_79d6f370510c1f94[5] = (18250, -2057, -439);
  var_79d6f370510c1f94[6] = (17549, -4262, -432);
  var_79d6f370510c1f94[7] = (19147, -11546, -257);
  var_79d6f370510c1f94[8] = (19845, -21990, -98);
  var_79d6f370510c1f94[9] = (19838, -18100, -23);
  var_79d6f370510c1f94[10] = (21978, -11276, -58);

  foreach(loc in level.ammorestocklocs) {
    var_e24c6c7277a83762 = 0;

    foreach(var_41bacc270e368c94 in var_79d6f370510c1f94) {
      if(var_e24c6c7277a83762) {
        break;
      }

      if(distance2dsquared(loc.origin, var_41bacc270e368c94) < 10000) {
        var_e24c6c7277a83762 = 1;
      }
    }

    if(var_e24c6c7277a83762) {
      targetents = getEntArray(loc.target, "targetname");

      foreach(ent in targetents) {
        if(ent.classname == "script_model") {
          ent delete();
          continue;
        }

        ent delete();
      }

      loc delete();
    }
  }
}