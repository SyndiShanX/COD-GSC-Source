/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\supplydrop.gsc
***********************************************/

#using script_52d2de9b438adc78;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\entityheadicons_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\emp_shared;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreak_dialog;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\mp\killstreak_weapons;
#using scripts\weapons\heatseekingmissile;
#using scripts\weapons\smokegrenade;
#using scripts\weapons\weaponobjects;
#using scripts\weapons\weapons;
#namespace supplydrop;

function private autoexec __init__system__() {
  system::register(#"supplydrop", &preinit, undefined, &function_1c601b99, #"killstreaks");
}

function private preinit() {
  bundle = getscriptbundle("killstreak_supply_drop");
  setDvar(#"hash_763d6ee8f054423f", 1);
  level.cratemodelfriendly = bundle.var_e7faf6c2;
  level.cratemodelenemy = bundle.var_65ed53d3;
  level.cratemodeltank = # "wpn_t7_drop_box";
  level.cratemodelboobytrapped = bundle.var_b25fc1fc;

  if(getdvarint(#"hash_3f663d1e38d10d99", 0) == 1) {
    level.cratemodelfriendly = # "hash_12e47c6c01f2ff59";
    level.cratemodelenemy = # "hash_5c54841918c40b74";
    level.cratemodelboobytrapped = # "hash_2d42a64e786470ce";
  }

  level.vtoldrophelicoptervehicleinfo = "vehicle_t9_mil_helicopter_care_package";
  ir_strobe::init_shared();
  level.crateownerusetime = 500;
  level.cratenonownerusetime = int(getgametypesetting(#"cratecapturetime") * 1000);
  level.supplydropdisarmcrate = # "hash_20071ab3686e8d58";
  level.var_f90e0e29 = &cratedelete;
  clientfield::register("vehicle", "supplydrop_care_package_state", 1, 1, "int");
  clientfield::register("vehicle", "supplydrop_ai_tank_state", 1, 1, "int");
  clientfield::register("vehicle", "" + # "hash_e4eb5c0853abab8", 6000, 1, "int");
  clientfield::register("scriptmover", "crate_landed", 1, 1, "int");

  if(sessionmodeismultiplayergame() && is_false(getgametypesetting(#"useitemspawns"))) {
    clientfield::register("scriptmover", "supply_drop_parachute_rob", 1, 1, "int");
  }

  killstreaks::register_killstreak("killstreak_supply_drop", &usekillstreaksupplydrop);
  level.cratetypes = [];
  level.categorytypeweight = [];
  level.cratecategoryweights = [];
  level.cratecategorytypeweights = [];
  ir_strobe::function_8806675d(#"supplydrop_marker", &function_200081db);
  ir_strobe::function_8806675d(#"inventory_supplydrop_marker", &function_200081db);

  level thread supply_drop_dev_gui();

  callback::on_game_playing(&on_game_playing);
  scene::add_scene_func(#"p9_fxanim_wz_parachute_supplydrop_01_harness_bundle", &function_4bf116ab, "init");
  scene::add_scene_func(#"p9_fxanim_wz_parachute_supplydrop_01_harness_bundle", &function_2842c984, "done");
  scene::add_scene_func(#"p9_fxanim_wz_parachute_supplydrop_01_bundle", &function_76b49bd8, "open");
}

function on_game_playing() {
  if(getgametypesetting(#"hash_d025af36cec2b4d")) {
    var_b27d6a17 = getgametypesetting(#"hash_7f805c4bd0bbd3d");

    if(isDefined(var_b27d6a17) && var_b27d6a17 > 0) {
      level thread function_7422bd1e(var_b27d6a17);
    }
  }
}

function function_7422bd1e(var_b27d6a17) {
  level endon(#"game_ended");
  var_8cf55682 = function_25ac512();

  if(!isDefined(var_8cf55682)) {
    return;
  }

  weapon = getweapon(#"supplydrop_marker");

  while(true) {
    wait var_b27d6a17;
    context = {
      #var_9fc6cfe9: 1, #dist_from_boundary: 50, #var_8741accb: # "airdrop_supplydrop", #droptag: "tag_cargo_attach", #perform_physics_trace: 1, #max_dist_from_location: 16, #radius: 30, #tracemask: 5
    };

    for(origin = function_2dcf7a5f(var_8cf55682, context); !isDefined(origin); origin = function_2dcf7a5f(var_8cf55682, context)) {
      waitframe(1);
    }

    var_ee4ed8b9 = {
      #markerposition: origin
    };
    var_ee4ed8b9 thread helidelivercrate(origin, weapon, undefined, undefined, undefined, undefined, context);
  }
}

function function_25ac512() {
  var_8cf55682 = {
    #absmins: [], #absmaxs: [], #var_136d64b6: 0
  };
  absmins = var_8cf55682.absmins;
  absmaxs = var_8cf55682.absmaxs;

  if(isstruct(level.territory) && isarray(level.territory.bounds)) {
    var_8cf55682.bounds = level.territory.bounds;

    foreach(bound in level.territory.bounds) {
      var_f3ba0cb3 = bound.origin + bound.mins;
      var_cd8bd6d = bound.origin + bound.maxs;

      for(i = 0; i < 3; i++) {
        if(!isDefined(absmins[i])) {
          absmins[i] = var_f3ba0cb3[i];
        }

        if(!isDefined(absmaxs[i])) {
          absmaxs[i] = var_cd8bd6d[i];
        }

        absmins[i] = min(absmins[i], var_f3ba0cb3[i]);
        absmaxs[i] = max(absmaxs[i], var_cd8bd6d[i]);
      }
    }
  } else {
    corners = getEntArray("minimap_corner", "targetname");

    if(corners.size != 2) {
      return undefined;
    }

    var_8cf55682.var_136d64b6 = 1;

    for(i = 0; i < 2; i++) {
      absmins[i] = min(corners[0].origin[i], corners[1].origin[i]);
      absmaxs[i] = max(corners[0].origin[i], corners[1].origin[i]);
    }
  }

  var_8cf55682.hurttriggers = getEntArray("trigger_hurt", "classname");
  return var_8cf55682;
}

function function_2dcf7a5f(var_8cf55682, context) {
  point = function_9bea1c04(var_8cf55682);

  if(!isDefined(point)) {
    return undefined;
  }

  trace = groundtrace(point + (0, 0, 20000), point + (0, 0, -10000), 0, undefined);

  if(trace[# "fraction"] >= 1) {
    return undefined;
  }

  point = trace[# "position"];

  foreach(trigger in var_8cf55682.hurttriggers) {
    if(istouching(point, trigger)) {
      return undefined;
    }
  }

  if(!islocationgood(point, context)) {
    return undefined;
  }

  return point;
}

function function_9bea1c04(var_8cf55682) {
  x = randomfloatrange(var_8cf55682.absmins[0], var_8cf55682.absmaxs[0]);
  y = randomfloatrange(var_8cf55682.absmins[1], var_8cf55682.absmaxs[1]);

  if(var_8cf55682.var_136d64b6 && isarray(level.oob_triggers)) {
    foreach(trigger in level.oob_triggers) {
      point = (x, y, trigger.origin[2]);

      if(istouching(point, trigger)) {
        return undefined;
      }
    }
  }

  if(!isarray(var_8cf55682.bounds) || var_8cf55682.bounds.size <= 0) {
    return (x, y, 0);
  }

  foreach(bound in var_8cf55682.bounds) {
    point = (x, y, bound.origin[2]);

    if(istouching(point, bound)) {
      return point;
    }
  }

  return undefined;
}

function function_d57719b8() {
  if(sessionmodeiswarzonegame()) {
    function_d51de8cf("uav", 18, 18);
    function_d51de8cf("recon_car", 18, 18);
    function_d51de8cf("counteruav", 13, 13);
    function_d51de8cf("hero_pineapplegun", 12, 12);
    function_d51de8cf("ultimate_turret", 12, 12);
    function_d51de8cf("sig_bow_flame", 12, 12);
    return;
  }

  function_d51de8cf("sig_bow_flame", 9, 9);
  function_d51de8cf("recon_car", 9, 9);
  function_d51de8cf("weapon_armor", 9, 9);
  function_d51de8cf("uav", 9, 9);
  function_d51de8cf("counteruav", 9, 9);
  function_d51de8cf("remote_missile", 9, 9);
  function_d51de8cf("planemortar", 8, 8);
  function_d51de8cf("napalm_strike", 8, 8);
  function_d51de8cf("ultimate_turret", 8, 8);
  function_d51de8cf("jetfighter", 0, 0);
  function_d51de8cf("hero_pineapplegun", 3, 3);
  function_d51de8cf("sig_lmg", 5, 5);
  function_d51de8cf("helicopter_comlink", 4, 4);
  function_d51de8cf("straferun", 2, 2);
  function_d51de8cf("chopper_gunner", 2, 2);
  function_d51de8cf("recon_plane", 3, 3);
  function_d51de8cf("hoverjet", 2, 2);
  function_d51de8cf("ac130", 1, 1);
}

function function_1c601b99() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](getweapon(#"supplydrop"), &function_bff5c062);
  }

  function_d57719b8();

  foreach(categorykey, category in level.cratetypes) {
    finalizecratecategory(categorykey);
  }
}

function function_bff5c062(supplydrop, attackingplayer) {
  supplydrop.owner = attackingplayer;
  supplydrop setowner(attackingplayer);
  supplydrop.team = attackingplayer.team;
  supplydrop setteam(attackingplayer.team);
  supplydrop killstreaks::configure_team_internal(attackingplayer, 1);
  supplydrop notify(#"hacked");
  supplydrop thread deleteonownerleave();

  if(isDefined(level.var_f1edf93f)) {
    supplydrop notify(#"cancel_timeout");
    var_eb79e7c3 = int([[level.var_f1edf93f]]() * 1000);
    supplydrop thread killstreaks::waitfortimeout("inventory_supply_drop", var_eb79e7c3, &cratedelete, "death");
  }
}

function finalizecratecategory(category) {
  level.cratecategoryweights[category] = 0;
  cratetypekeys = getarraykeys(level.cratetypes[category]);

  for(cratetype = 0; cratetype < cratetypekeys.size; cratetype++) {
    typekey = cratetypekeys[cratetype];
    level.cratetypes[category][typekey].previousweight = level.cratecategoryweights[category];
    level.cratecategoryweights[category] += level.cratetypes[category][typekey].weight;
    level.cratetypes[category][typekey].weight = level.cratecategoryweights[category];
  }
}

function setcategorytypeweight(category, type, weight) {
  if(!isDefined(level.categorytypeweight[category])) {
    level.categorytypeweight[category] = [];
  }

  level.categorytypeweight[category][type] = spawnStruct();
  level.categorytypeweight[category][type].weight = weight;
  count = 0;
  totalweight = 0;
  startindex = undefined;
  finalindex = undefined;
  cratenamekeys = getarraykeys(level.cratetypes[category]);

  for(cratename = 0; cratename < cratenamekeys.size; cratename++) {
    namekey = cratenamekeys[cratename];

    if(level.cratetypes[category][namekey].type == type) {
      count++;
      totalweight += level.cratetypes[category][namekey].weight;

      if(!isDefined(startindex)) {
        startindex = cratename;
      }

      if(isDefined(finalindex) && finalindex + 1 != cratename) {
        util::error("<dev string:x38>");

        callback::abort_level();
        return;
      }

      finalindex = cratename;
    }
  }

  level.categorytypeweight[category][type].totalcrateweight = totalweight;
  level.categorytypeweight[category][type].cratecount = count;
  level.categorytypeweight[category][type].startindex = startindex;
  level.categorytypeweight[category][type].finalindex = finalindex;
}

function function_d51de8cf(name, weight, var_16a49f, hint, hint_gambler) {
  function_e611181f("supplydrop", "killstreak", name, weight, hint, hint_gambler, &givecratekillstreak);
  function_e611181f("inventory_supplydrop", "killstreak", name, weight, hint, hint_gambler, &givecratekillstreak);
  function_e611181f("gambler", "killstreak", name, var_16a49f, hint, hint_gambler, &givecratekillstreak);
}

function function_e611181f(category, type, name, weight, hint, hint_gambler, givefunction, landfunctionoverride) {
  if(!isDefined(level.cratetypes[category])) {
    level.cratetypes[category] = [];
  }

  if(isitemrestricted(name)) {
    return;
  }

  if(!isDefined(level.killstreaks[name])) {
    return;
  }

  bundle = killstreaks::get_script_bundle(name);
  hint = bundle.var_1d2a2ca4;
  hint_gambler = bundle.var_8c4d7906;
  cratetype = spawnStruct();
  cratetype.type = type;
  cratetype.name = name;
  cratetype.weight = weight;
  cratetype.hint = hint;
  cratetype.hint_gambler = hint_gambler;
  cratetype.givefunction = givefunction;

  if(isDefined(landfunctionoverride)) {
    cratetype.landfunctionoverride = landfunctionoverride;
  }

  level.cratetypes[category][name] = cratetype;
  game.strings[name + "_hint"] = hint;
}

function getrandomcratetype(category, gambler_crate_name) {
  if(!isDefined(level.cratetypes) || !isDefined(level.cratetypes[category])) {
    return;
  }

  assert(isDefined(level.cratetypes));
  assert(isDefined(level.cratetypes[category]));
  assert(isDefined(level.cratecategoryweights[category]));
  typekey = undefined;
  cratetypestart = 0;

  if(level.cratecategoryweights[category] < 1) {
    randomweightend = 1;
  } else if(isDefined(self.var_f10af921)) {
    randomweightend = randomintrange(1, self.var_f10af921);
  } else {
    randomweightend = randomintrange(1, level.cratecategoryweights[category] + 1);
  }

  find_another = 0;
  cratenamekeys = getarraykeys(level.cratetypes[category]);

  if(isDefined(level.categorytypeweight[category]) && !isDefined(self.var_55a52a3b)) {
    randomweightend = randomint(level.cratecategorytypeweights[category]) + 1;
    cratetypekeys = getarraykeys(level.categorytypeweight[category]);

    for(cratetype = 0; cratetype < cratetypekeys.size; cratetype++) {
      typekey = cratetypekeys[cratetype];

      if(level.categorytypeweight[category][typekey].weight < randomweightend) {
        continue;
      }

      cratetypestart = level.categorytypeweight[category][typekey].startindex;
      randomweightend = randomint(level.categorytypeweight[category][typekey].totalcrateweight) + 1;
      randomweightend += level.cratetypes[category][cratenamekeys[cratetypestart]].previousweight;
      break;
    }
  }

  for(cratetype = cratetypestart; cratetype < cratenamekeys.size; cratetype++) {
    typekey = cratenamekeys[cratetype];

    if(level.cratetypes[category][typekey].weight < randomweightend) {
      continue;
    }

    if(isDefined(gambler_crate_name) && level.cratetypes[category][typekey].name == gambler_crate_name) {
      find_another = 1;
    }

    if(find_another) {
      if(cratetype < cratenamekeys.size - 1) {
        cratetype++;
      } else if(cratetype > 0) {
        cratetype--;
      }

      typekey = cratenamekeys[cratetype];
    }

    break;
  }

  if(isDefined(level.dev_gui_supply_drop) && level.dev_gui_supply_drop != "<dev string:x65>" && level.dev_gui_supply_drop != "<dev string:x6f>") {
    typekey = level.dev_gui_supply_drop;
  }

  return level.cratetypes[category][typekey];
}

function givecrateitem(crate) {
  if(!isalive(self) || !isDefined(crate.cratetype)) {
    return;
  }

  assert(isDefined(crate.cratetype.givefunction), "<dev string:x73>" + crate.cratetype.name);
  return [[crate.cratetype.givefunction]]("inventory_" + crate.cratetype.name);
}

function givecratekillstreakwaiter(event, removecrate, extraendon) {
  self endon(#"give_crate_killstreak_done");

  if(isDefined(extraendon)) {
    self endon(extraendon);
  }

  self waittill(event);
  self notify(#"give_crate_killstreak_done", {
    #is_remove: removecrate
  });
}

function givecratekillstreak(killstreak) {
  self killstreaks::give(killstreak);
}

function givespecializedcrateweapon(weapon) {
  switch (weapon.name) {
    case # "minigun":
      level thread popups::displayteammessagetoall(#"hash_3b566d06e5a482e1", self);
      level weapons::add_limited_weapon(weapon, self, 3);
      break;
    case # "m32":
      level thread popups::displayteammessagetoall(#"hash_25ae9096a4ce050c", self);
      level weapons::add_limited_weapon(weapon, self, 3);
      break;
    case # "m220_tow":
      level thread popups::displayteammessagetoall(#"hash_51751eb890739762", self);
      level weapons::add_limited_weapon(weapon, self, 3);
      break;
    case # "mp40_blinged":
      level thread popups::displayteammessagetoall(#"killstreak_mp40_inbound", self);
      level weapons::add_limited_weapon(weapon, self, 3);
      break;
    default:
      break;
  }
}

function givecrateweapon(weapon_name) {
  weapon = getweapon(weapon_name);

  if(weapon == level.weaponnone) {
    return;
  }

  currentweapon = self getcurrentweapon();

  if(currentweapon == weapon || self hasweapon(weapon)) {
    self givemaxammo(weapon);
    return 1;
  }

  if(currentweapon.issupplydropweapon || isDefined(level.grenade_array[currentweapon]) || isDefined(level.inventory_array[currentweapon])) {
    self takeweapon(self.lastdroppableweapon);
    self giveweapon(weapon);
    self switchtoweapon(weapon);
    return 1;
  }

  self stats::function_e24eec31(weapon, #"used", 1);
  givespecializedcrateweapon(weapon);
  self giveweapon(weapon);
  self switchtoweapon(weapon);
  self waittill(#"weapon_change");
  self killstreak_weapons::usekillstreakweaponfromcrate(weapon);
  return 1;
}

function usesupplydropmarker(package_contents_id, context) {
  player = self;
  self endon(#"disconnect", #"spawned_player");
  supplydropweapon = level.weaponnone;
  currentweapon = self getcurrentweapon();
  prevweapon = currentweapon;

  if(currentweapon.issupplydropweapon) {
    supplydropweapon = currentweapon;
  }

  if(supplydropweapon.isgrenadeweapon) {
    trigger_event = "grenade_fire";
  } else {
    trigger_event = "weapon_fired";
  }

  trigger_event = "none";
  self thread supplydropwatcher(package_contents_id, trigger_event, supplydropweapon, context);
  self.supplygrenadedeathdrop = 0;

  while(true) {
    player allowmelee(0);
    notifystring = self waittill(#"weapon_change", trigger_event, #"disconnect", #"spawned_player");
    player allowmelee(1);

    if(trigger_event != "none") {
      if(notifystring._notify != trigger_event) {
        cleanup(context, player);
        return false;
      }
    }

    if(isDefined(player.markerposition)) {
      break;
    }
  }

  self notify(#"trigger_weapon_shutdown");

  if(supplydropweapon == level.weaponnone) {
    cleanup(context, player);
    return false;
  }

  return true;
}

function issupplydropgrenadeallowed(killstreak) {
  if(!self killstreakrules::iskillstreakallowed(killstreak, self.team, 1)) {
    self killstreaks::switch_to_last_non_killstreak_weapon();
    return false;
  }

  return true;
}

function adddroplocation(killstreak_id, location) {
  level.droplocations[killstreak_id] = location;
}

function deldroplocation(killstreak_id) {
  level.droplocations[killstreak_id] = undefined;
}

function function_4c0ed253(location, context) {
  foreach(droplocation in level.droplocations) {
    if(distance2dsquared(droplocation, location) < 3600) {
      return false;
    }
  }

  if(context.perform_physics_trace === 1) {
    mask = 1;

    if(isDefined(context.tracemask)) {
      mask = context.tracemask;
    }

    radius = context.radius;
    trace = physicstrace(location + (0, 0, 5000), location + (0, 0, 30), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask, 16);

    if(getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
      sphere(location, 8, (1, 1, 0), 1, 1, 10, 1);
    }

    if(trace[# "fraction"] < 1) {
      if(!is_true(level.var_66da9c3c)) {
        if(getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
          util::drawcylinder(trace[# "position"], context.radius, 8000, 0.0166667, undefined, (1, 0, 0), 0.7);
        }

        return false;
      }
    }
  }

  if(getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
    util::drawcylinder(trace[# "position"], context.radius, 8000, 0.0166667, undefined, (0, 1, 0), 0.7);
  }

  return true;
}

function islocationgood(location, context) {
  if(getdvarint(#"hash_458cd0a10d30cedb", 1)) {
    return function_4c0ed253(location, context);
  }

  foreach(droplocation in level.droplocations) {
    if(distance2dsquared(droplocation, location) < 3600) {
      return 0;
    }
  }

  if(context.perform_physics_trace === 1) {
    mask = 1;

    if(isDefined(context.tracemask)) {
      mask = context.tracemask;
    }

    radius = context.radius;
    trace = physicstrace(location + (0, 0, 5000), location + (0, 0, 10), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);

    if(trace[# "fraction"] < 1) {
      if(getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
        sphere(location, radius, (1, 0, 0), 1, 1, 10, 1);
      }

      return 0;
    } else {
      if(getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
        sphere(location, radius, (0, 0, 1), 1, 1, 10, 1);
      }
    }
  }

  closestpoint = getclosestpointonnavmesh(location, max(context.max_dist_from_location, 24), context.dist_from_boundary);
  isvalidpoint = isDefined(closestpoint);

  if(isvalidpoint && context.check_same_floor === 1 && abs(location[2] - closestpoint[2]) > 96) {
    isvalidpoint = 0;
  }

  if(isvalidpoint && distance2dsquared(location, closestpoint) > sqr(context.max_dist_from_location)) {
    isvalidpoint = 0;
  }

  if(getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
    if(!isvalidpoint) {
      otherclosestpoint = getclosestpointonnavmesh(location, getdvarfloat(#"scr_supply_drop_valid_location_radius_debug", 96), context.dist_from_boundary);

      if(isDefined(otherclosestpoint)) {
        sphere(otherclosestpoint, context.max_dist_from_location, (1, 0, 0), 0.8, 0, 20, 1);
      }
    } else {
      sphere(closestpoint, context.max_dist_from_location, (0, 1, 0), 0.8, 0, 20, 1);
      util::drawcylinder(closestpoint, context.radius, 8000, 0.0166667, undefined, (0, 0.9, 0), 0.7);
    }
  }

  return isvalidpoint;
}

function usekillstreaksupplydrop(killstreak) {
  player = self;

  if(!player issupplydropgrenadeallowed(killstreak)) {
    return false;
  }

  context = spawnStruct();
  context.radius = level.killstreakcorebundle.ksairdropaitankradius;
  context.dist_from_boundary = 50;
  context.max_dist_from_location = 16;
  context.perform_physics_trace = 1;
  context.islocationgood = &islocationgood;
  context.killstreakref = killstreak;
  context.validlocationsound = level.killstreakcorebundle.ksvalidcarepackagelocationsound;
  context.tracemask = 1 | 4;
  context.droptag = "tag_cargo_attach";
  context.var_9fc6cfe9 = 1;
  context.killstreaktype = killstreak;
  context.var_14174f4e = &issupplydropgrenadeallowed;
  return self ir_strobe::function_f625256f(undefined, context);
}

function spawn_supplydrop(owner, context, origin) {
  location = spawnStruct();
  location.origin = origin;
  context clientfield::set_player_uimodel("hudItems.tankState", 1);
  context airsupport::function_83904681(location, &supplydropwatcher);
}

function use_killstreak_death_machine(killstreak) {
  if(!self killstreakrules::iskillstreakallowed(killstreak, self.team, 1)) {
    return false;
  }

  weapon = getweapon(#"minigun");
  currentweapon = self getcurrentweapon();

  if(currentweapon.issupplydropweapon || isDefined(level.grenade_array[currentweapon]) || isDefined(level.inventory_array[currentweapon])) {
    self takeweapon(self.lastdroppableweapon);
    self giveweapon(weapon);
    self switchtoweapon(weapon);
    self setblockweaponpickup(weapon, 1);
    return true;
  }

  level thread popups::displayteammessagetoall(#"hash_3b566d06e5a482e1", self);
  level weapons::add_limited_weapon(weapon, self, 3);
  self takeweapon(currentweapon);
  self giveweapon(weapon);
  self switchtoweapon(weapon);
  self setblockweaponpickup(weapon, 1);
  return true;
}

function use_killstreak_grim_reaper(killstreak) {
  if(!self killstreakrules::iskillstreakallowed(killstreak, self.team, 1)) {
    return false;
  }

  weapon = getweapon(#"m202_flash");
  currentweapon = self getcurrentweapon();

  if(currentweapon.issupplydropweapon || isDefined(level.grenade_array[currentweapon]) || isDefined(level.inventory_array[currentweapon])) {
    self takeweapon(self.lastdroppableweapon);
    self giveweapon(weapon);
    self switchtoweapon(weapon);
    self setblockweaponpickup(weapon, 1);
    return true;
  }

  level weapons::add_limited_weapon(weapon, self, 3);
  self takeweapon(currentweapon);
  self giveweapon(weapon);
  self switchtoweapon(weapon);
  self setblockweaponpickup(weapon, 1);
  return true;
}

function cleanupwatcherondeath(team, killstreak_id) {
  player = self;
  self endon(#"disconnect", #"supplydropwatcher", #"trigger_weapon_shutdown", #"spawned_player", #"weapon_change");
  self waittill(#"death", #"joined_team", #"joined_spectators");
  killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
  self notify(#"cleanup_marker");
}

function cleanup(context, player) {
  if(isDefined(context) && isDefined(context.marker)) {
    context.marker delete();
    context.marker = undefined;

    if(isDefined(context.markerfxhandle)) {
      context.markerfxhandle delete();
      context.markerfxhandle = undefined;
    }

    if(isDefined(player)) {
      player clientfield::set_to_player("marker_state", 0);
    }
  }

  if(isDefined(context) && isDefined(context.var_cebe759b)) {
    objective_delete(context.var_cebe759b);
    gameobjects::release_obj_id(context.var_cebe759b);
    context.var_cebe759b = undefined;
  }

  if(isDefined(context.killstreak_id)) {
    deldroplocation(context.killstreak_id);
  }
}

function markerupdatethread(context) {
  player = self;
  player endon(#"supplydropwatcher", #"spawned_player", #"disconnect", #"weapon_change", #"death");
  markermodel = spawn("script_model", (0, 0, 0));
  context.marker = markermodel;
  player thread markercleanupthread(context);

  while(true) {
    if(player flag::get(#"marking_done")) {
      break;
    }

    minrange = level.killstreakcorebundle.ksminairdroptargetrange;
    maxrange = level.killstreakcorebundle.ksmaxairdroptargetrange;
    forwardvector = vectorscale(anglesToForward(player getplayerangles()), maxrange);
    mask = 1;

    if(isDefined(context.tracemask)) {
      mask = context.tracemask;
    }

    radius = 2;
    results = physicstrace(player getEye(), player getEye() + forwardvector, (radius * -1, radius * -1, 0), (radius, radius, 0), player, mask);
    markermodel.origin = results[# "position"];
    tooclose = distancesquared(markermodel.origin, player.origin) < minrange * minrange;

    if(results[# "normal"][2] > 0.7 && !tooclose && isDefined(context.islocationgood) && [[context.islocationgood]](markermodel.origin, context)) {
      player.markerposition = markermodel.origin;
      player clientfield::set_to_player("marker_state", 1);
    } else {
      player.markerposition = undefined;
      player clientfield::set_to_player("marker_state", 2);
    }

    waitframe(1);
  }
}

function function_200081db(owner, context, location) {
  team = self.team;
  killstreak_id = self killstreakrules::killstreakstart("supply_drop", team, 0, 0);

  if(killstreak_id == -1) {
    return 0;
  }

  self stats::function_8fb23f94(#"supplydrop_marker", #"uses", 1);
  bundle = getscriptbundle("killstreak_supply_drop");
  killstreakweapon = killstreaks::get_killstreak_weapon(context.killstreaktype);
  context.selectedlocation = location;
  context.killstreak_id = killstreak_id;
  self thread helidelivercrate(context.selectedlocation, killstreakweapon, self, team, killstreak_id, killstreak_id, context);
  self addweaponstat(bundle.ksweapon, #"used", 1);
}

function function_36573ef(killstreak_id, context, team) {
  result = self usesupplydropmarker(killstreak_id, context);
  self notify(#"supply_drop_marker_done");

  if(!is_true(result)) {
    return false;
  }

  self killstreak_dialog::play_killstreak_start_dialog("supply_drop", team, killstreak_id);
  return true;
}

function supplydropwatcher(package_contents_id, trigger_event, supplydropweapon, context) {
  player = self;
  self notify(#"supplydropwatcher");
  self endon(#"supplydropwatcher", #"spawned_player", #"disconnect", #"weapon_change");
  team = self.team;

  if(isDefined(context.killstreak_id)) {
    killstreak_id = context.killstreak_id;
  } else {
    killstreak_id = killstreakrules::killstreakstart("supply_drop", team, 0, 0);

    if(killstreak_id == -1) {
      return;
    }

    context.killstreak_id = killstreak_id;
  }

  player flag::clear(#"marking_done");
  self thread checkforemp();

  if(trigger_event != "none") {
    if(!supplydropweapon.isgrenadeweapon) {
      self thread markerupdatethread(context);
    }

    self thread checkweaponchange(team, killstreak_id);
  }

  self thread cleanupwatcherondeath(team, killstreak_id);

  while(true) {
    if(trigger_event == "none") {
      weapon = supplydropweapon;
      weapon_instance = weapon;
    } else {
      waitresult = self waittill(trigger_event);
      weapon = waitresult.weapon;
      weapon_instance = waitresult.projectile;
    }

    issupplydropweapon = 1;

    if(trigger_event == "grenade_fire") {
      issupplydropweapon = weapon.issupplydropweapon;
    }

    if(isDefined(self) && issupplydropweapon) {
      if(isDefined(context)) {
        if(!isDefined(player.markerposition) || !(isDefined(context.islocationgood) && [[context.islocationgood]](player.markerposition, context))) {
          if(isDefined(level.killstreakcorebundle.ksinvalidlocationsound)) {
            player playsoundtoplayer(level.killstreakcorebundle.ksinvalidlocationsound, player);
          }

          if(isDefined(level.killstreakcorebundle.ksinvalidlocationstring)) {
            player iprintlnbold(level.killstreakcorebundle.ksinvalidlocationstring);
          }

          continue;
        }

        if(isDefined(context.validlocationsound)) {
          player playsoundtoplayer(context.validlocationsound, player);
        }

        self thread helidelivercrate(context.selectedlocation, weapon, self, team, killstreak_id, package_contents_id, context);
      } else {
        self thread dosupplydrop(weapon_instance, weapon, self, killstreak_id, package_contents_id);
        weapon_instance thread do_supply_drop_detonation(weapon, self);
        weapon_instance thread supplydropgrenadetimeout(team, killstreak_id, weapon);
      }

      self killstreaks::switch_to_last_non_killstreak_weapon();
    } else {
      killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
      self notify(#"cleanup_marker");
    }

    break;
  }

  player flag::set(#"marking_done");
  player clientfield::set_to_player("marker_state", 0);
}

function checkforemp() {
  self endon(#"supplydropwatcher", #"spawned_player", #"hash_5fa67b447400c1a5", #"weapon_change", #"death", #"trigger_weapon_shutdown");
  self waittill(#"emp_jammed");
  self killstreaks::switch_to_last_non_killstreak_weapon();
}

function supplydropgrenadetimeout(team, killstreak_id, weapon) {
  self endon(#"death", #"stationary");
  grenade_lifetime = 10;
  wait grenade_lifetime;

  if(!isDefined(self)) {
    return;
  }

  self notify(#"grenade_timeout");
  killstreakrules::killstreakstop("supply_drop", team, killstreak_id);

  if(weapon.name == # "tank_robot") {
    killstreakrules::killstreakstop("tank_robot", team, killstreak_id);
    self notify(#"cleanup_marker");
  } else if(weapon.name == # "inventory_tank_robot") {
    killstreakrules::killstreakstop("inventory_tank_robot", team, killstreak_id);
    self notify(#"cleanup_marker");
  } else if(weapon.name == # "combat_robot_drop") {
    killstreakrules::killstreakstop("combat_robot_drop", team, killstreak_id);
    self notify(#"cleanup_marker");
  } else if(weapon.name == # "inventory_combat_robot_drop") {
    killstreakrules::killstreakstop("inventory_combat_robot_drop", team, killstreak_id);
    self notify(#"cleanup_marker");
  }

  self delete();
}

function checkweaponchange(team, killstreak_id) {
  self endon(#"supplydropwatcher", #"spawned_player", #"disconnect", #"trigger_weapon_shutdown", #"death");
  self waittill(#"weapon_change");
  killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
  self notify(#"cleanup_marker");
}

function geticonforcrate() {
  if(isDefined(self.cratetype.objective)) {
    return self.cratetype.objective;
  }

  if(self.cratetype.type == "killstreak") {
    assert(isDefined(self.cratetype.name));
    crateweapon = killstreaks::get_killstreak_weapon(self.cratetype.name);

    if(isDefined(crateweapon)) {
      self.cratetype.objective = getcrateheadobjective(crateweapon);
      return self.cratetype.objective;
    }
  }

  return undefined;
}

function crateactivate(hacker) {
  self makeusable();
  self setcursorhint("HINT_NOICON");

  if(!isDefined(self.cratetype)) {
    return;
  }

  if(!isDefined(self.cratetype.hint)) {
    self.cratetype.hint = "Hint string missing";
  }

  self sethintstring(self.cratetype.hint);

  if(isDefined(self.cratetype.hint_gambler)) {
    self sethintstringforperk(#"specialty_showenemyequipment", self.cratetype.hint_gambler);
  }

  icon = self geticonforcrate();

  if(isDefined(hacker)) {}

  if(self.visibletoall) {
    if(isDefined(icon)) {
      self entityheadicons::setentityheadicon(self.team, self, icon);
    }
  }

  if(!self.visibletoall && isDefined(icon)) {
    self entityheadicons::setentityheadicon(self.team, self, icon);

    if(self.entityheadobjectives.size > 0) {
      objectiveid = self.entityheadobjectives[self.entityheadobjectives.size - 1];

      if(isDefined(objectiveid)) {
        foreach(player in getplayers()) {
          if(player !== self.owner) {
            objective_setinvisibletoplayer(objectiveid, player);
          }
        }
      }
    }
  }

  if(isDefined(self.owner) && isPlayer(self.owner) && isbot(self.owner)) {
    self.owner notify(#"bot_crate_landed", {
      #crate: self
    });
  }

  if(isDefined(self.owner)) {
    self.owner notify(#"crate_landed", {
      #crate: self
    });
    setricochetprotectionendtime("supply_drop", self.killstreak_id, self.owner);
  }
}

function setricochetprotectionendtime(killstreak, killstreak_id, owner) {
  ksbundle = killstreaks::get_script_bundle(killstreak);

  if(isDefined(ksbundle) && isDefined(ksbundle.ksricochetpostlandduration) && ksbundle.ksricochetpostlandduration > 0) {
    endtime = gettime() + int(ksbundle.ksricochetpostlandduration * 1000);
    killstreaks::set_ricochet_protection_endtime(killstreak_id, owner, endtime);
  }
}

function cratedeactivate() {
  self makeunusable();
}

function dropalltoground(origin, radius, stickyobjectradius) {
  physicsexplosionsphere(origin, radius, radius, 0);
  waitframe(1);
  weapons::drop_all_to_ground(origin, radius);
  dropcratestoground(origin, radius);
  level notify(#"drop_objects_to_ground", {
    #position: origin, #radius: stickyobjectradius
  });
}

function dropeverythingtouchingcrate(origin) {
  dropalltoground(origin, 70, 70);
}

function dropalltogroundaftercratedelete(crate, crate_origin) {
  crate waittill(#"death");
  wait 0.1;
  crate dropeverythingtouchingcrate(crate_origin);
}

function dropcratestoground(origin, radius) {
  crate_ents = getEntArray("care_package", "script_noteworthy");
  radius_sq = radius * radius;

  for(i = 0; i < crate_ents.size; i++) {
    if(distancesquared(origin, crate_ents[i].origin) < radius_sq) {
      crate_ents[i] thread dropcratetoground();
    }
  }
}

function dropcratetoground() {
  self endon(#"death");

  if(isDefined(self.droppingtoground)) {
    return;
  }

  self.droppingtoground = 1;
  dropeverythingtouchingcrate(self.origin);
  self cratedeactivate();
  self thread cratedroptogroundkill();
  self crateredophysics();
  self crateactivate();
  self.droppingtoground = undefined;
}

function cratespawn(killstreak, killstreakid, owner, team, drop_origin, drop_angle, _crate, context) {
  if(isDefined(_crate)) {
    crate = _crate;
  } else {
    crate = spawn("script_model", drop_origin, 1);
  }

  if(isDefined(owner)) {
    crate killstreaks::configure_team(killstreak, killstreakid, owner);

    if(!isDefined(context) || !isDefined(context.vehicle)) {
      crate clientfield::set("enemyequip", 1);
    }
  } else {
    crate.team = team;
  }

  function_d79fe484(crate, getdvarint(#"g_useholdtime", 0) / 1000);
  function_708a32ec(crate);
  crate.angles = drop_angle;
  crate.visibletoall = team == # "neutral";
  crate.script_noteworthy = "care_package";
  crate.weapon = getweapon(#"supplydrop");
  crate setweapon(crate.weapon);
  crate function_619a5c20();

  if(!isDefined(_crate)) {
    if(killstreak === "tank_robot" || killstreak === "inventory_tank_robot") {
      crate setModel(level.cratemodeltank);
      crate setenemymodel(level.cratemodeltank);
    } else if(getdvarint(#"hash_3f663d1e38d10d99", 0) == 2 && randomintrangeinclusive(1, 100) <= 20) {
      crate setModel(#"hash_12e47c6c01f2ff59");
      crate setenemymodel(#"hash_5c54841918c40b74");
      crate.var_e8a59c52 = 1;

      if(isDefined(level.cratetypes[# "supplydrop"][# "remote_missile"].weight)) {
        crate.var_f10af921 = level.cratetypes[# "supplydrop"][# "remote_missile"].weight + 1;
      }
    } else {
      crate setModel(level.cratemodelfriendly);
      crate setenemymodel(level.cratemodelenemy);
    }
  }

  switch (killstreak) {
    case # "turret_drop":
      crate.cratetype = level.cratetypes[killstreak][# "autoturret"];
      break;
    case # "tow_turret_drop":
      crate.cratetype = level.cratetypes[killstreak][# "auto_tow"];
      break;
    case # "m220_tow_drop":
      crate.cratetype = level.cratetypes[killstreak][# "m220_tow"];
      break;
    case # "tank_robot":
    case # "inventory_tank_robot":
      crate.cratetype = level.cratetypes[killstreak][# "tank_robot"];
      break;
    case # "inventory_minigun_drop":
    case # "minigun_drop":
      crate.cratetype = level.cratetypes[killstreak][# "minigun"];
      break;
    case # "m32_drop":
    case # "inventory_m32_drop":
      crate.cratetype = level.cratetypes[killstreak][# "m32"];
      break;
    default:
      crate.cratetype = crate getrandomcratetype("supplydrop");
      break;
  }

  return crate;
}

function cratedelete(drop_all_to_ground) {
  if(!isDefined(self)) {
    return;
  }

  killstreaks::remove_ricochet_protection(self.killstreak_id, self.originalowner);

  if(!isDefined(drop_all_to_ground)) {
    drop_all_to_ground = 1;
  }

  if(drop_all_to_ground) {
    level thread dropalltogroundaftercratedelete(self, self.origin);
  }

  if(isDefined(self.killcament)) {
    self.killcament thread util::deleteaftertime(5);
  }

  if(isDefined(self.parachute)) {
    self.parachute delete();
  }

  self function_9813d292();
  self notify(#"stop_crate_use_think");
  self deletedelay();
}

function stationarycrateoverride() {
  self endon(#"death", #"stationary");
  wait 4;
  self.angles = self.angles;
  self.origin = self.origin;
  self notify(#"stationary");
}

function timeoutcratewaiter() {
  self endon(#"death", #"stationary");
  wait 20;
  self cratedelete(1);
}

function cratephysics() {
  self endon(#"death");
  self physicslaunch(self.origin, (0, 0, -100));
  self thread timeoutcratewaiter();
  self waittill(#"stationary");
  self function_d2d0a813();
}

function function_d2d0a813() {
  var_3b0688ef = "supply_drop_badplace" + self getentitynumber();
  origin = self.origin + self getboundsmidpoint();
  halfsize = self getboundshalfsize();
  var_921c5821 = max(halfsize[0], halfsize[1]) + 4;
  halfsize = (var_921c5821, var_921c5821, halfsize[2] + 4);
  badplace_box(var_3b0688ef, 0, origin, halfsize, "all");
}

function private function_9813d292() {
  if(isDefined(self)) {
    badplace_delete("supply_drop_badplace" + self getentitynumber());
  }
}

function function_1f686c3b(v_target_location) {
  endtime = gettime() + 7000;

  while(endtime > gettime()) {
    if(self.origin[2] - 20 < v_target_location[2]) {
      break;
    }

    waitframe(1);
  }

  self notify(#"stationary");
}

function cratecontrolleddrop(killstreak, v_target_location, var_72886e11) {
  crate = self;
  crate endon(#"death");
  supplydrop = 1;

  if(killstreak == "tank_robot") {
    supplydrop = 0;
  }

  if(supplydrop) {
    params = killstreaks::get_script_bundle("supply_drop");
  } else {
    params = killstreaks::get_script_bundle("tank_robot");
  }

  crate thread watchforcratekill(v_target_location[2] + (isDefined(params.ksstartcratekillheightfromground) ? params.ksstartcratekillheightfromground : 200));
  crate thread update_crate_velocity();

  if(isDefined(level.var_947cc86b)) {
    var_ae4c0bf9 = level.var_947cc86b;
  } else {
    var_ae4c0bf9 = isDefined(params.ksthrustersoffheight) ? params.ksthrustersoffheight : 0;
  }

  target = (v_target_location[0], v_target_location[1], v_target_location[2] + var_ae4c0bf9);
  var_c65d6e50 = 1;

  if(isDefined(var_72886e11) && var_72886e11 >= target[2]) {
    var_c65d6e50 = 0;
  }

  if(!is_true(level.var_2e93cff2) && var_c65d6e50) {
    if(!isDefined(params.kstotaldroptime)) {
      params.kstotaldroptime = 4;
    }

    var_cc6645da = isDefined(params.ksacceltimepercentage) ? params.ksacceltimepercentage : 0.65;
    acceltime = params.kstotaldroptime * var_cc6645da;
    deceltime = is_true(params.var_f03a1094) ? params.kstotaldroptime - acceltime : 0;
    hostmigration::waittillhostmigrationdone();
    crate moveto(target, params.kstotaldroptime, acceltime, deceltime);
    crate thread function_2defd397();
    wait acceltime;

    if(!is_true(crate.pop_parachute)) {
      crate waittill(#"movedone", #"pop_parachute");
    }

    hostmigration::waittillhostmigrationdone();
  }

  crate thread cratephysics();
  failsafetime = gettime() + 3000;

  while(distancesquared(crate.origin, v_target_location) > 100) {
    waitframe(1);

    if(gettime() >= failsafetime) {
      break;
    }
  }

  crate clientfield::set("crate_landed", 1);

  if(isDefined(params.var_827e3209)) {
    trace = groundtrace(crate.origin + (0, 0, 70), crate.origin + (0, 0, -100), 0, crate);
    var_2122d2eb = crate getfxfromsurfacetable(params.var_827e3209, trace[# "surfacetype"]);

    if(isDefined(var_2122d2eb)) {
      fxforward = trace[# "normal"];

      if(fxforward == (0, 0, 0)) {
        fxforward = (0, 0, 1);
      }

      playFX(var_2122d2eb, trace[# "position"], fxforward);
      self playSound(#"phy_impact_supply");
    }
  }
}

function play_impact_sound() {
  self playSound(#"phy_impact_supply");
}

function update_crate_velocity() {
  self endon(#"death", #"stationary");
  self.velocity = (0, 0, 0);
  self.old_origin = self.origin;

  while(isDefined(self)) {
    self.velocity = self.origin - self.old_origin;
    self.old_origin = self.origin;
    waitframe(1);
  }
}

function crateredophysics() {
  forcepoint = self.origin;
  initialvelocity = (0, 0, 0);
  self physicslaunch(forcepoint, initialvelocity);
  self thread timeoutcratewaiter();
  self thread stationarycrateoverride();
  self waittill(#"stationary");
}

function do_supply_drop_detonation(weapon, owner) {
  self notify(#"supplydropwatcher");
  self endon(#"supplydropwatcher", #"spawned_player", #"disconnect", #"death", #"grenade_timeout");
  self util::waittillnotmoving();
  self.angles = (0, self.angles[1], 90);
  fuse_time = float(weapon.fusetime) / 1000;
  wait fuse_time;

  if(!isDefined(owner) || !owner emp::enemyempactive()) {
    thread smokegrenade::playsmokesound(self.origin, 6, level.sound_smoke_start, level.sound_smoke_stop, level.sound_smoke_loop);
    playFXOnTag(level.var_5efaff3e, self, "tag_fx");
    proj_explosion_sound = weapon.projexplosionsound;
    sound::play_in_space(proj_explosion_sound, self.origin);
  }

  wait 3;
  self delete();
}

function dosupplydrop(weapon_instance, weapon, owner, killstreak_id, package_contents_id, context) {
  weapon endon(#"explode", #"grenade_timeout");
  self endon(#"disconnect");
  team = owner.team;
  weapon_instance thread watchexplode(weapon, owner, killstreak_id, package_contents_id);
  weapon_instance util::waittillnotmoving();
  weapon_instance notify(#"stoppedmoving");
  self thread helidelivercrate(weapon_instance.origin, weapon, owner, team, killstreak_id, package_contents_id, context);
}

function watchexplode(weapon, owner, killstreak_id, package_contents_id) {
  self endon(#"stoppedmoving");
  team = owner.team;
  waitresult = self waittill(#"explode");
  owner thread helidelivercrate(waitresult.position, weapon, owner, team, killstreak_id, package_contents_id);
}

function cratetimeoutthreader() {
  crate = self;
  cratetimeout(90);

  if(isDefined(crate.owner)) {
    crate thread deleteonownerleave();
  }
}

function cratetimeout(time) {
  crate = self;
  self.var_ec8ef668 = 1;
  self thread killstreaks::waitfortimeout("inventory_supply_drop", int(90 * 1000), &cratedelete, "death");
}

function deleteonownerleave() {
  crate = self;
  crate endon(#"death", #"hacked");
  crate.owner waittill(#"joined_team", #"joined_spectators", #"disconnect");
  crate cratedelete(1);
}

function waitanddelete(time) {
  self endon(#"death");
  wait time;
  self delete();
}

function function_703ed715(trace) {
  if(isDefined(trace[# "entity"]) && isvehicle(trace[# "entity"]) && trace[# "entity"].vehicleclass === "helicopter") {
    mask = 1;
    radius = 30;
    origin = trace[# "position"];
    trace = physicstrace(origin + (0, 0, -100), origin + (0, 0, -10000), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);
    return trace;
  }

  return trace;
}

function dropcrate(origin, angle, killstreak, owner, team, killcament, killstreak_id, package_contents_id, crate, context, var_83f3c388) {
  angles = (angle[0] * 0.5, angle[1] * 0.5, angle[2] * 0.5);

  if(is_true(context.vehicledrop)) {
    context.vehicle = spawnvehicle(#"archetype_mini_quadtank_mp", origin, angles, "talon", 1, self);
  }

  crate unlink();
  killcament unlink();
  killcament linkto(crate);
  crate.killcament = killcament;
  crate.killstreak_id = killstreak_id;
  crate.package_contents_id = package_contents_id;
  killcament thread util::deleteaftertime(15);
  killcament thread unlinkonrotation(crate);

  if(killstreak == "tank_robot" && isDefined(level.var_14151f16)) {
    [[level.var_14151f16]](crate, 0);
  }

  crate endon(#"death");

  if(!is_true(context.vehicledrop)) {
    crate cratetimeoutthreader();
  }

  mask = 1 | 4;
  radius = 30;
  trace = physicstrace(crate.origin + (0, 0, -100), crate.origin + (0, 0, -10000), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);
  trace = function_703ed715(trace);
  v_target_location = trace[# "position"];

  if(getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
    util::drawcylinder(v_target_location, context.radius, 8000, 99999999, "<dev string:x94>", (0, 0, 0.9), 0.8);
  }

  if(isDefined(context.vehicle)) {
    crate function_1f686c3b(v_target_location);
  } else if((is_true(crate.var_da439787) || !getdvarint(#"hash_763d6ee8f054423f", 0)) && isDefined(v_target_location)) {
    crate cratecontrolleddrop(killstreak, (v_target_location[0], v_target_location[1], v_target_location[2] + 10));
  } else if(isDefined(var_83f3c388)) {
    crate cratecontrolleddrop(killstreak, (var_83f3c388[0], var_83f3c388[1], var_83f3c388[2] + 10), v_target_location[2]);
  } else if(isDefined(owner.markerposition)) {
    crate cratecontrolleddrop(killstreak, (owner.markerposition[0], owner.markerposition[1], owner.markerposition[2] + 10));
  } else {
    crate cratecontrolleddrop(killstreak, v_target_location);
  }

  if(isDefined(level.registerwithhackertool)) {
    crate thread[[level.registerwithhackertool]](level.carepackagehackertoolradius, level.carepackagehackertooltimems);
  }

  cleanup(context, owner);

  if(isDefined(crate.cratetype) && isDefined(crate.cratetype.landfunctionoverride)) {
    [[crate.cratetype.landfunctionoverride]](crate, killstreak, owner, team, context);
    return;
  }

  crate crateactivate();
  crate thread crateusethink();
  crate thread crateusethinkowner();

  if(isDefined(crate.cratetype) && isDefined(crate.cratetype.hint_gambler)) {
    crate thread crategamblerthink();
  }

  default_land_function(crate, killstreak, owner, team);
}

function unlinkonrotation(crate) {
  self endon(#"delete");
  crate endon(#"death", #"stationary");
  waitbeforerotationcheck = getdvarfloat(#"scr_supplydrop_killcam_rot_wait", 0.5);
  wait waitbeforerotationcheck;
  mincos = getdvarfloat(#"scr_supplydrop_killcam_max_rot", 0.999);
  cosine = 1;
  currentdirection = vectornormalize(anglesToForward(crate.angles));

  while(cosine > mincos) {
    olddirection = currentdirection;
    waitframe(1);
    currentdirection = vectornormalize(anglesToForward(crate.angles));
    cosine = vectordot(olddirection, currentdirection);
  }

  if(isDefined(self)) {
    self unlink();
  }
}

function default_land_function(crate, category, owner, team) {
  while(true) {
    waitresult = crate waittill(#"captured");
    player = waitresult.player;
    remote_hack = waitresult.is_remote_hack;

    if(isDefined(crate.owner)) {
      if(owner != crate.owner) {
        owner = crate.owner;
      }

      if(team != owner.team) {
        team = owner.team;
      }
    }

    if(isDefined(owner)) {
      player challenges::capturedcrate(owner);

      if(owner != player && (level.teambased && util::function_fbce7263(team, player.team) || !level.teambased)) {
        player stats::function_8fb23f94(#"supplydrop_marker", #"hash_35d993e984abfcd8", 1);
        player stats::function_b04e7184(#"supplydrop_marker", #"hash_475b7b7447960e6f");
      }
    }

    deletecrate = player givecrateitem(crate);

    if(isDefined(deletecrate) && !deletecrate) {
      continue;
    }

    playerhasengineerperk = player hasperk(#"hash_2373f1c307651b95");
    crate makeunusable();
    killcament = spawn("script_model", crate.origin + (0, 0, 60));
    killcament setweapon(getweapon(#"supplydrop"));

    if(crate.team != # "neutral" && (playerhasengineerperk || remote_hack == 1) && owner != player && (level.teambased && util::function_fbce7263(team, player.team) || !level.teambased)) {
      spawn_explosive_crate(crate.origin, crate.angles, category, owner, team, player, playerhasengineerperk, killcament);
      util::wait_network_frame();
      crate cratedelete(0);
      return;
    }

    crate function_960ea519(player, killcament);
    return;
  }
}

function spawn_explosive_crate(origin, angle, killstreak, owner, team, hacker, playerhasengineerperk, killcament) {
  crate = cratespawn(killstreak, undefined, owner, team, origin, angle);
  crate setowner(owner);
  crate setteam(team);
  crate function_d2d0a813();
  crate.killcament = killcament;

  if(level.teambased) {
    crate setenemymodel(level.cratemodelboobytrapped);
    crate makeusable(team);
  } else {
    crate setenemymodel(level.cratemodelenemy);
  }

  crate.hacker = hacker;
  crate.visibletoall = 0;
  crate crateactivate(hacker);
  crate sethintstringforperk("specialty_showenemyequipment", level.supplydropdisarmcrate);
  crate thread crateusethink();
  crate thread crateusethinkowner();
  crate thread watch_explosive_crate(killcament);
  crate cratetimeoutthreader();
  crate.playerhasengineerperk = playerhasengineerperk;
}

function watch_explosive_crate(killcament) {
  waitresult = self waittill(#"captured", #"death");
  remote_hack = waitresult.is_remote_hack;
  player = waitresult.player;

  if(waitresult._notify == # "captured") {
    if(isDefined(self)) {
      if(!player hasperk(#"specialty_showenemyequipment") && !remote_hack) {
        self thread scene::play(#"p9_fxanim_mp_care_package_bundle", self);

        if(getdvarint(#"hash_3f663d1e38d10d99", 0) == 1 || is_true(self.var_e8a59c52)) {
          playsoundatposition(#"hash_2dec6d8e4271a0e0", self.origin);
        }

        self thread entityheadicons::setentityheadicon(player.team, player, "headicon_dead");
        self function_71c8970c(0.15);

        if(isDefined(self)) {
          if(!isDefined(self.hacker)) {
            self.hacker = self;
          }

          self function_345ada65(self.hacker);
        }
      } else {
        playsoundatposition(#"mpl_turret_alert", self.origin);
        scoreevents::processscoreevent(#"disarm_hacked_care_package", player, undefined, undefined);
        player challenges::disarmedhackedcarepackage();
      }
    }
  }

  wait 0.1;

  if(isDefined(self)) {
    self cratedelete();
  }

  killcament thread util::deleteaftertime(5);
}

function function_960ea519(opener, killcament) {
  self notify(#"stop_crate_use_think");
  self.killcament = killcament;
  self thread scene::play(#"p9_fxanim_mp_care_package_bundle", self);

  if(getdvarint(#"hash_3f663d1e38d10d99", 0) == 1 || is_true(self.var_e8a59c52)) {
    if(isPlayer(opener)) {
      opener stats::function_bcf9602(#"hash_513bca963a91d668", 1, #"hash_735ace6b22542a65");
    }

    if(isDefined(level.var_ccf67f32)) {
      self thread[[level.var_ccf67f32]](opener);
    }

    playsoundatposition(#"hash_2dec6d8e4271a0e0", self.origin);
  }

  bundle = getscriptbundle("killstreak_supply_drop");
  detonationdelay = bundle.var_18d14afd;
  self entityheadicons::destroyentityheadicons();
  self thread function_71c8970c(0.84);
  wait detonationdelay;
  self function_345ada65(opener);

  if(isDefined(self)) {
    self cratedelete(1);
  }

  killcament thread util::deleteaftertime(5);
}

function function_345ada65(attacker) {
  bundle = getscriptbundle("killstreak_supply_drop");

  if(isDefined(bundle.var_b768b86b)) {
    trace = groundtrace(self.origin + (0, 0, 10), self.origin + (0, 0, -10), 0, self);
    explosionfx = self getfxfromsurfacetable(bundle.var_b768b86b, trace[# "surfacetype"]);

    if(isDefined(explosionfx)) {
      playFX(explosionfx, self.origin, anglestoup(self.angles), anglestoright(self.angles));
    }
  }

  if(getdvarint(#"hash_3f663d1e38d10d99", 0) == 1 || is_true(self.var_e8a59c52)) {
    playFX(#"hash_6b51d18944db0abc", self.origin, anglestoup(self.angles), anglestoright(self.angles));
    playsoundatposition(#"hash_16d2b0215d38013d", self.origin);
  }

  if(isDefined(bundle.var_3f41a92c)) {
    playrumbleonposition(bundle.var_3f41a92c, self.origin);
  }

  playsoundatposition(#"wpn_frag_explode", self.origin);
  self radiusdamage(self.origin, 256, 500, 300, attacker, "MOD_EXPLOSIVE", getweapon(#"supplydrop"));
}

function function_71c8970c(interval) {
  self endon(#"death");
  var_2b95a314 = 0;

  if(getdvarint(#"hash_3f663d1e38d10d99", 0) == 1 || is_true(self.var_e8a59c52)) {
    var_2b95a314 = 1;
    playsoundatposition(#"hash_3ffad77eb2b2e6c9", self.origin);
  }

  while(true) {
    if(!var_2b95a314) {
      playsoundatposition("wpn_semtex_alert", self.origin);
    }

    playFXOnTag(#"hash_73dda66347b73ddd", self, "tag_fx_01");
    playFXOnTag(#"hash_73dda66347b73ddd", self, "tag_fx_02");
    playFXOnTag(#"hash_73dda66347b73ddd", self, "tag_fx_03");
    playFXOnTag(#"hash_73dda66347b73ddd", self, "tag_fx_04");
    playFXOnTag(#"hash_3e6e2a2df9fd889", self, "tag_body");
    wait interval;
    interval /= 1.2;

    if(interval < 0.08) {
      break;
    }
  }
}

function watchforcratekill(start_kill_watch_z_threshold) {
  crate = self;
  crate endon(#"death", #"stationary");

  while(crate.origin[2] > start_kill_watch_z_threshold) {
    waitframe(1);
  }

  stationarythreshold = 1;
  killthreshold = 0.2;
  maxframestillstationary = 10;
  numframesstationary = 0;

  while(true) {
    vel = 0;

    if(isDefined(self.velocity)) {
      vel = abs(self.velocity[2]);
    }

    if(vel > killthreshold) {
      crate is_touching_crate();
      crate is_clone_touching_crate();
    }

    if(vel < stationarythreshold) {
      numframesstationary++;
    } else {
      numframesstationary = 0;
    }

    if(numframesstationary >= maxframestillstationary) {
      break;
    }

    waitframe(1);
  }
}

function cratekill() {
  self endon(#"death");
  stationarythreshold = 2;
  killthreshold = 15;
  maxframestillstationary = 20;
  numframesstationary = 0;

  while(true) {
    vel = 0;

    if(isDefined(self.velocity)) {
      vel = abs(self.velocity[2]);
    }

    if(vel > killthreshold) {
      self is_touching_crate();
      self is_clone_touching_crate();
    }

    if(vel < stationarythreshold) {
      numframesstationary++;
    } else {
      numframesstationary = 0;
    }

    if(numframesstationary >= maxframestillstationary) {
      break;
    }

    wait 0.01;
  }
}

function cratedroptogroundkill() {
  self endon(#"death", #"stationary");

  for(;;) {
    players = getplayers();
    dotrace = 0;

    for(i = 0; i < players.size; i++) {
      if(players[i].sessionstate != "playing") {
        continue;
      }

      if(players[i].team == # "spectator") {
        continue;
      }

      if(!isalive(players[i])) {
        continue;
      }

      flattenedselforigin = (self.origin[0], self.origin[1], 0);
      flattenedplayerorigin = (players[i].origin[0], players[i].origin[1], 0);

      if(distancesquared(flattenedselforigin, flattenedplayerorigin) > 4096) {
        continue;
      }

      dotrace = 1;
      break;
    }

    self is_equipment_touching_crate();

    if(dotrace) {
      start = self.origin;
      cratedroptogroundtrace(start);
      start = self getpointinbounds(1, 0, 0);
      cratedroptogroundtrace(start);
      start = self getpointinbounds(-1, 0, 0);
      cratedroptogroundtrace(start);
      start = self getpointinbounds(0, -1, 0);
      cratedroptogroundtrace(start);
      start = self getpointinbounds(0, 1, 0);
      cratedroptogroundtrace(start);
      start = self getpointinbounds(1, 1, 0);
      cratedroptogroundtrace(start);
      start = self getpointinbounds(-1, 1, 0);
      cratedroptogroundtrace(start);
      start = self getpointinbounds(1, -1, 0);
      cratedroptogroundtrace(start);
      start = self getpointinbounds(-1, -1, 0);
      cratedroptogroundtrace(start);
      wait 0.2;
      continue;
    }

    wait 0.5;
  }
}

function cratedroptogroundtrace(start) {
  end = start + (0, 0, -8000);
  trace = bulletTrace(start, end, 1, self, 0, 1);

  if(isDefined(trace[# "entity"]) && isPlayer(trace[# "entity"]) && isalive(trace[# "entity"])) {
    player = trace[# "entity"];

    if(player.sessionstate != "playing") {
      return;
    }

    if(player.team == # "spectator") {
      return;
    }

    if(distancesquared(start, trace[# "position"]) < 144 || self istouching(player)) {
      player dodamage(player.health + 1, player.origin, self.owner, self, "none", "MOD_HIT_BY_OBJECT", 0, getweapon(#"supplydrop"));
      player playSound(#"mpl_supply_crush");
      player playSound(#"phy_impact_supply");
    }
  }
}

function is_touching_crate() {
  if(!isDefined(self)) {
    return;
  }

  crate = self;
  players = getplayers();
  crate_bottom_point = self.origin;

  foreach(player in level.players) {
    if(!isentity(player)) {
      continue;
    }

    if(isDefined(player) && isalive(player)) {
      stance = player getstance();
      stance_z_offset = stance == "crouch" ? 55 : stance == "stand" ? 75 : 15;
      player_test_point = player.origin + (0, 0, stance_z_offset);
      var_f6f95bb5 = distance2dsquared(player_test_point, self.origin);
      zvel = self.velocity[2];

      if(var_f6f95bb5 < 2500 && player_test_point[2] > crate_bottom_point[2]) {
        attacker = isDefined(self.owner) ? self.owner : self;
        player dodamage(player.health + 1, player.origin, attacker, self, "none", "MOD_HIT_BY_OBJECT", 0, getweapon(#"supplydrop"));
        player playSound(#"mpl_supply_crush");
        player playSound(#"phy_impact_supply");
      }
    }
  }

  self is_equipment_touching_crate();
  vehicles = getEntArray("script_vehicle", "classname");

  foreach(vehicle in vehicles) {
    if(isvehicle(vehicle)) {
      if(isDefined(vehicle.archetype) && vehicle.archetype == "wasp") {
        if(crate istouching(vehicle, (2, 2, 2))) {
          vehicle notify(#"sentinel_shutdown");
        }
      }
    }
  }
}

function is_clone_touching_crate() {
  if(!isDefined(self)) {
    return;
  }

  extraboundary = (10, 10, 10);
  actors = getactorarray();

  for(i = 0; i < actors.size; i++) {
    if(isDefined(actors[i]) && isDefined(actors[i].isaiclone) && isalive(actors[i]) && actors[i].origin[2] < self.origin[2] && self istouching(actors[i], extraboundary)) {
      attacker = isDefined(self.owner) ? self.owner : self;
      actors[i] dodamage(actors[i].health + 1, actors[i].origin, attacker, self, "none", "MOD_HIT_BY_OBJECT", 0, getweapon(#"supplydrop"));
      actors[i] playSound(#"mpl_supply_crush");
      actors[i] playSound(#"phy_impact_supply");
    }
  }
}

function is_equipment_touching_crate() {
  entities = getdamageableentarray(self.origin, 100);

  foreach(entity in entities) {
    if(!isentity(entity)) {
      continue;
    }

    if(isPlayer(entity)) {
      continue;
    }

    if(!isalive(entity)) {
      continue;
    }

    if(!entity istouching(self, (10, 10, 10))) {
      continue;
    }

    if(isDefined(entity.detonated)) {
      damage = 100;
    } else {
      damage = entity.health * 2;
    }

    entity dodamage(damage, self.origin, self.owner, self, 0, "MOD_UNKNOWN", 0, getweapon(#"supplydrop"));
  }
}

function spawnuseent(player) {
  useent = spawn("script_origin", self.origin);
  useent.curprogress = 0;
  useent.inuse = 0;
  useent.userate = 0;
  useent.usetime = 0;
  useent.owner = self;
  useent.capturingplayer = player;
  useent thread useentownerdeathwaiter(self);
  return useent;
}

function useentownerdeathwaiter(owner) {
  self endon(#"death");
  owner waittill(#"death");
  self delete();
}

function crateusethink() {
  while(isDefined(self)) {
    waitresult = self waittill(#"trigger", #"death", #"stop_crate_use_think");

    if(waitresult._notify === "stop_crate_use_think" || waitresult._notify === "death") {
      break;
    }

    player = waitresult.activator;

    if(!isDefined(self)) {
      break;
    }

    if(self.team == # "neutral") {
      continue;
    }

    if(!isalive(player)) {
      continue;
    }

    if(!player isonground()) {
      continue;
    }

    if(is_true(player.var_5e6eba64)) {
      continue;
    }

    if(isDefined(self.owner) && self.owner == player) {
      continue;
    }

    useent = self spawnuseent(player);
    result = 0;

    if(isDefined(self.hacker)) {
      useent.hacker = self.hacker;
    }

    self.useent = useent;
    result = useent useholdthink(player, level.cratenonownerusetime);

    if(isDefined(useent)) {
      useent deletedelay();
    } else {
      break;
    }

    if(result) {
      scoreevents::givecratecapturemedal(self, player);
      self notify(#"captured", {
        #player: player, #is_remote_hack: 0
      });
    }
  }
}

function crateusethinkowner() {
  while(isDefined(self)) {
    waitresult = self waittill(#"trigger", #"death");

    if(waitresult._notify == "death") {
      return;
    }

    player = waitresult.activator;

    if(!isalive(player)) {
      continue;
    }

    if(is_true(player.var_5e6eba64)) {
      continue;
    }

    if(self.team != # "neutral") {
      if(!isDefined(self.owner)) {
        continue;
      }

      if(self.owner != player) {
        continue;
      }
    }

    result = self useholdthink(player, level.crateownerusetime);

    if(!isDefined(self)) {
      break;
    }

    if(result && isDefined(player)) {
      self notify(#"captured", {
        #player: player, #is_remote_hack: 0
      });
    }
  }
}

function useholdthink(player, usetime) {
  player notify(#"use_hold");
  player val::set(#"supplydrop", "freezecontrols");
  player val::set(#"supplydrop", "disable_weapons");
  player val::set(#"supplydrop", "disable_offhand_weapons");
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;
  self.usetime = usetime;
  player thread personalusebar(self);
  result = useholdthinkloop(player);

  if(isDefined(player)) {
    player notify(#"done_using");
    player val::reset(#"supplydrop", "freezecontrols");
    player val::reset(#"supplydrop", "disable_weapons");
    player val::reset(#"supplydrop", "disable_offhand_weapons");
  }

  if(isDefined(self)) {
    self.inuse = 0;
  }

  if(isDefined(result) && result) {
    return true;
  }

  return false;
}

function continueholdthinkloop(player) {
  if(!isDefined(self)) {
    return false;
  }

  if(self.curprogress >= self.usetime) {
    return false;
  }

  if(!isalive(player)) {
    return false;
  }

  if(player.throwinggrenade) {
    return false;
  }

  if(!player killstreaks::function_59e2c378()) {
    return false;
  }

  if(!player useButtonPressed()) {
    return false;
  }

  if(player meleeButtonPressed()) {
    return false;
  }

  if(player isinvehicle()) {
    return false;
  }

  if(player isweaponviewonlylinked()) {
    return false;
  }

  if(player isremotecontrolling()) {
    return false;
  }

  return true;
}

function useholdthinkloop(player) {
  level endon(#"game_ended");
  self endon(#"disabled");

  if(isDefined(self.owner)) {
    self.owner endon(#"crate_use_interrupt");
  }

  timedout = 0;

  while(self continueholdthinkloop(player)) {
    timedout += 0.05;
    self.curprogress += level.var_9fee970c * self.userate;
    self.userate = 1;

    if(self.curprogress >= self.usetime) {
      self.inuse = 0;
      waitframe(1);
      return isalive(player);
    }

    waitframe(1);
    hostmigration::waittillhostmigrationdone();
  }

  return 0;
}

function crategamblerthink() {
  self endon(#"death");

  for(;;) {
    waitresult = self waittill(#"trigger_use_doubletap");
    player = waitresult.player;

    if(!player hasperk(#"specialty_showenemyequipment")) {
      continue;
    }

    if(isDefined(self.useent) && self.useent.inuse) {
      if(isDefined(self.owner) && self.owner != player && isDefined(self.useent.capturingplayer) && self.useent.capturingplayer != player) {
        continue;
      }
    }

    player playlocalsound(#"uin_gamble_perk");
    self.cratetype = self getrandomcratetype("gambler", self.cratetype.name);
    self cratereactivate();
    self sethintstringforperk("specialty_showenemyequipment", self.cratetype.hint);
    self notify(#"crate_use_interrupt");
    level notify(#"use_interrupt", {
      #target: self
    });
    return;
  }
}

function cratereactivate() {
  self sethintstring(self.cratetype.hint);
  icon = self geticonforcrate();
  self thread entityheadicons::setentityheadicon(self.team, self, icon);
}

function personalusebar(object) {
  self endon(#"disconnect");
  capturecratestate = 0;

  if(object.team != # "neutral" && self hasperk(#"hash_2373f1c307651b95") && object.owner != self && !isDefined(object.hacker) && (level.teambased && util::function_fbce7263(object.owner.team, self.team) || !level.teambased)) {
    capturecratestate = 2;
    self playlocalsound(#"evt_hacker_hacking");
  } else if(object.team != # "neutral" && self hasperk(#"hash_2373f1c307651b95") && isDefined(object.hacker) && (object.owner == self || level.teambased && object.owner.team == self.team)) {
    capturecratestate = 3;
    self playlocalsound(#"evt_hacker_hacking");
  } else {
    capturecratestate = 1;
    self.is_capturing_own_supply_drop = object.team != # "neutral" && object.owner === self && (!isDefined(object.originalowner) || object.originalowner == self);
  }

  lastrate = -1;

  while(isalive(self) && isDefined(object) && object.inuse && !level.gameended) {
    if(lastrate != object.userate) {
      if(object.curprogress > object.usetime) {
        object.curprogress = object.usetime;
      }

      if(!object.userate) {
        self clientfield::set_player_uimodel("hudItems.captureCrateTotalTime", 0);
        self clientfield::set_player_uimodel("hudItems.captureCrateState", 0);
      } else {
        barfrac = object.curprogress / object.usetime;
        rateofchange = object.userate / object.usetime;
        capturecratetotaltime = 0;

        if(rateofchange > 0) {
          capturecratetotaltime = (1 - barfrac) / rateofchange;
        }

        self clientfield::set_player_uimodel("hudItems.captureCrateTotalTime", int(capturecratetotaltime));
        self clientfield::set_player_uimodel("hudItems.captureCrateState", capturecratestate);
      }
    }

    lastrate = object.userate;
    waitframe(1);
  }

  self.is_capturing_own_supply_drop = 0;
  self clientfield::set_player_uimodel("hudItems.captureCrateTotalTime", 0);
  self clientfield::set_player_uimodel("hudItems.captureCrateState", 0);
}

function spawn_helicopter(owner, team, origin, angles, vehicledef, targetname, killstreak_id, context) {
  chopper = spawnvehicle(vehicledef, origin, angles, targetname);

  if(!isDefined(chopper)) {
    if(isPlayer(owner)) {
      killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
      self iprintlnbold(#"hash_7a1ca44da026f58c");
      self notify(#"cleanup_marker");
    }

    return undefined;
  }

  chopper vehicle::toggle_sounds(1);
  chopper.destroyfunc = &destroyhelicopter;
  chopper.script_nocorpse = 1;
  chopper.damagetaken = 0;
  chopper.targetname = "chopper";
  chopper.var_c31213a5 = 1;
  hardpointtypefordamage = "supply_drop";

  if(isDefined(context)) {
    if(context.killstreakref === "inventory_tank_robot" || context.killstreakref === "tank_robot") {
      hardpointtypefordamage = "supply_drop_ai_tank";
    } else if(context.killstreakref === "inventory_combat_robot" || context.killstreakref === "combat_robot") {
      hardpointtypefordamage = "supply_drop_combat_robot";
    }
  }

  bundle = killstreaks::get_script_bundle(hardpointtypefordamage);
  chopper.overridevehicledamage = &function_f4712512;
  chopper.hardpointtype = hardpointtypefordamage;
  chopper.maxhealth = isDefined(killstreak_bundles::get_max_health(hardpointtypefordamage)) ? killstreak_bundles::get_max_health(hardpointtypefordamage) : level.heli_maxhealth;
  chopper.health = chopper.maxhealth;
  chopper thread helicopter::function_76f530c7(bundle);
  chopper thread helicopter::heli_damage_monitor(hardpointtypefordamage);
  chopper thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile(bundle, "crashing", "death");
  chopper.spawntime = gettime();

  chopper util::debug_slow_heli_speed();

  chopper setdrawinfrared(1);
  chopper setneargoalnotifydist(200);
  target_set(chopper, (0, 0, -25));

  if(isDefined(owner)) {
    chopper setowner(owner);
    chopper killstreaks::configure_team("supply_drop", killstreak_id, owner);
    chopper clientfield::set("enemyvehicle", 1);

    if(isDefined(level.var_14151f16)) {
      [[level.var_14151f16]](chopper, 0);
    }

    if(isPlayer(owner)) {
      chopper thread refcountdecchopper(team, killstreak_id, context.killstreaktype, 1);
    }
  }

  chopper setrotorspeed(1);
  return chopper;
}

function function_f4712512(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  weapon_damage = killstreak_bundles::get_weapon_damage(self.hardpointtype, self.maxhealth, psoffsettime, vsurfacenormal, partname, damagefromunderneath, modelindex);

  if(!isDefined(weapon_damage)) {
    weapon_damage = killstreaks::get_old_damage(psoffsettime, vsurfacenormal, partname, damagefromunderneath, 1);
  }

  return weapon_damage;
}

function destroyhelicopter(var_fec7078b) {
  team = self.originalteam;

  if(target_istarget(self)) {
    target_remove(self);
  }

  self influencers::remove_influencers();

  if(isDefined(self.interior_model)) {
    self.interior_model delete();
    self.interior_model = undefined;
  }

  if(isDefined(self.minigun_snd_ent)) {
    self.minigun_snd_ent stoploopsound();
    self.minigun_snd_ent delete();
    self.minigun_snd_ent = undefined;
  }

  if(isDefined(self.alarm_snd_ent)) {
    self.alarm_snd_ent delete();
    self.alarm_snd_ent = undefined;
  }

  if(isDefined(self.flare_ent)) {
    self.flare_ent delete();
    self.flare_ent = undefined;
  }

  if(isDefined(self.owner)) {
    self.owner notify(#"payload_fail");
  }

  self scene::stop(1);
  self notify(#"hash_525537be2de4c159", {
    #position: self.origin, #direction: self.angles, #owner: self.owner
  });
  lbexplode();
}

function getdropheight(origin) {
  return killstreaks::function_43f4782d();
}

function getdropdirection() {
  return (0, randomint(360), 0);
}

function getnextdropdirection(drop_direction, degrees) {
  drop_direction = (0, drop_direction[1] + degrees, 0);

  if(drop_direction[1] >= 360) {
    drop_direction = (0, drop_direction[1] - 360, 0);
  }

  return drop_direction;
}

function gethelistart(drop_origin, drop_direction) {
  dist = -1 * getdvarint(#"scr_supplydropincomingdistance", 15000);
  pathrandomness = 100;
  direction = drop_direction + (0, randomintrange(-2, 3), 0);
  start_origin = drop_origin + anglesToForward(direction) * dist;
  start_origin += ((randomfloat(2) - 1) * pathrandomness, (randomfloat(2) - 1) * pathrandomness, 0);

  if(getdvarint(#"scr_noflyzones_debug", 0)) {
    if(level.noflyzones.size) {
      index = randomintrange(0, level.noflyzones.size);
      delta = drop_origin - level.noflyzones[index].origin;
      delta = (delta[0] + randomint(10), delta[1] + randomint(10), 0);
      delta = vectornormalize(delta);
      start_origin = drop_origin + delta * dist;
    }
  }

  return start_origin;
}

function getheliend(drop_origin, drop_direction) {
  pathrandomness = 150;
  dist = -1 * getdvarint(#"scr_supplydropoutgoingdistance", 15000);

  if(randomintrange(0, 2) == 0) {
    turn = randomintrange(60, 121);
  } else {
    turn = -1 * randomintrange(60, 121);
  }

  direction = drop_direction + (0, turn, 0);
  end_origin = drop_origin + anglesToForward(direction) * dist;
  end_origin += ((randomfloat(2) - 1) * pathrandomness, (randomfloat(2) - 1) * pathrandomness, 0);
  return end_origin;
}

function addoffsetontopoint(point, direction, offset) {
  angles = vectortoangles((direction[0], direction[1], 0));
  offset_world = rotatepoint(offset, angles);
  return point + offset_world;
}

function supplydrophelistartpath_v2_setup(goal, goal_offset, var_aea79ccc) {
  goalpath = spawnStruct();
  goalpath.start = helicopter::getvalidrandomstartnode(goal_offset, var_aea79ccc).origin;
  return goalpath;
}

function supplydrophelistartpath_v2_part2_local(goal, goalpath, goal_local_offset) {
  direction = goal - goalpath.start;
  goalpath.path = [];
  goalpath.path[0] = addoffsetontopoint(goal, direction, goal_local_offset);
}

function supplydrophelistartpath_v2_part2(goal, goalpath, goal_world_offset) {
  goalpath.path = [];
  goalpath.path[0] = goal + goal_world_offset;
}

function supplydrophelistartpath(goal, goal_offset) {
  total_tries = 12;
  tries = 0;
  goalpath = spawnStruct();
  drop_direction = getdropdirection();

  while(tries < total_tries) {
    goalpath.start = gethelistart(goal, drop_direction);
    goalpath.path = airsupport::gethelipath(goalpath.start, goal);
    startnoflyzones = airsupport::insidenoflyzones(goalpath.start, 0);

    if(isDefined(goalpath.path) && startnoflyzones.size == 0) {
      if(goalpath.path.size > 1) {
        direction = goalpath.path[goalpath.path.size - 1] - goalpath.path[goalpath.path.size - 2];
      } else {
        direction = goalpath.path[goalpath.path.size - 1] - goalpath.start;
      }

      goalpath.path[goalpath.path.size - 1] = addoffsetontopoint(goalpath.path[goalpath.path.size - 1], direction, goal_offset);

      sphere(goalpath.path[goalpath.path.size - 1], 10, (0, 0, 1), 1, 1, 10, 1000);

      return goalpath;
    }

    drop_direction = getnextdropdirection(drop_direction, 30);
    tries++;
  }

  drop_direction = getdropdirection();
  goalpath.start = gethelistart(goal, drop_direction);
  direction = goal - goalpath.start;
  goalpath.path = [];
  goalpath.path[0] = addoffsetontopoint(goal, direction, goal_offset);
  return goalpath;
}

function supplydropheliendpath_v2(start, var_aea79ccc) {
  goalpath = spawnStruct();
  goalpath.start = start;
  goal = helicopter::getvalidrandomleavenode(start, var_aea79ccc).origin;
  goalpath.path = [];
  goalpath.path[0] = goal;
  return goalpath;
}

function supplydropheliendpath(origin, drop_direction) {
  total_tries = 5;
  tries = 0;
  goalpath = spawnStruct();

  while(tries < total_tries) {
    goal = getheliend(origin, drop_direction);
    goalpath.path = airsupport::gethelipath(origin, goal);

    if(isDefined(goalpath.path)) {
      return goalpath;
    }

    tries++;
  }

  leave_nodes = getEntArray("heli_leave", "targetname");

  foreach(node in leave_nodes) {
    goalpath.path = airsupport::gethelipath(origin, node.origin);

    if(isDefined(goalpath.path)) {
      return goalpath;
    }
  }

  goalpath.path = [];
  goalpath.path[0] = getheliend(origin, drop_direction);
  return goalpath;
}

function inccratekillstreakusagestat(weapon, killstreak_id) {
  if(weapon == level.weaponnone) {
    return;
  }

  switch (weapon.name) {
    case # "turret_drop":
      self killstreak_dialog::play_killstreak_start_dialog("turret_drop", self.pers[# "team"], killstreak_id);
      break;
    case # "tow_turret_drop":
      self killstreak_dialog::play_killstreak_start_dialog("tow_turret_drop", self.pers[# "team"], killstreak_id);
      break;
    case # "supplydrop_marker":
    case # "inventory_supplydrop_marker":
      self killstreak_dialog::play_killstreak_start_dialog("supply_drop", self.pers[# "team"], killstreak_id);
      level thread popups::displaykillstreakteammessagetoall("supply_drop", self);
      self challenges::calledincarepackage();
      self stats::function_e24eec31(getweapon(#"supplydrop"), #"used", 1);
      break;
    case # "tank_robot":
    case # "inventory_tank_robot":
      self killstreak_dialog::play_killstreak_start_dialog("tank_robot", self.pers[# "team"], killstreak_id);
      level thread popups::displaykillstreakteammessagetoall("tank_robot", self);
      self stats::function_e24eec31(getweapon(#"tank_robot"), #"used", 1);
      break;
    case # "inventory_minigun_drop":
    case # "minigun_drop":
      self killstreak_dialog::play_killstreak_start_dialog("minigun", self.pers[# "team"], killstreak_id);
      break;
    case # "m32_drop":
    case # "inventory_m32_drop":
      self killstreak_dialog::play_killstreak_start_dialog("m32", self.pers[# "team"], killstreak_id);
      break;
    case # "combat_robot_drop":
      level thread popups::displaykillstreakteammessagetoall("combat_robot", self);
      break;
  }
}

function markercleanupthread(context) {
  player = self;
  player waittill(#"death", #"disconnect", #"joined_team", #"joined_spectators", #"cleanup_marker");
  cleanup(context, player);
}

function getchopperdroppoint(context) {
  chopper = self;
  return isDefined(context.droptag) ? chopper gettagorigin(context.droptag) + rotatepoint(isDefined(context.droptagoffset) ? context.droptagoffset : (0, 0, 0), chopper.angles) : chopper.origin;
}

function private function_7d90f954(drop_origin, context) {
  if(ispointonnavmesh(drop_origin, context.dist_from_boundary)) {
    recordsphere(drop_origin + (0, 0, 10), 2, (0, 1, 0), "<dev string:xc6>");

    return true;
  }

  recordsphere(drop_origin + (0, 0, 10), 2, (1, 0, 0), "<dev string:xc6>");

  return false;
}

function private function_75277c27(tacpoint, context) {
  if(isDefined(context.ceilingheight) && context.ceilingheight >= 4000) {
    recordsphere(context.origin, 2, (0, 1, 0), "<dev string:xc6>");

    return true;
  }

  recordsphere(context.origin, 2, (1, 0, 0), "<dev string:xc6>");

  return false;
}

function private function_9153c267(drop_origin, context, drop_height) {
  if(is_true(level.var_e071ed64)) {
    heli_drop_goal = (context[0], context[1], context[2] + drop_height);
    var_baa92af9 = ispointinnavvolume(heli_drop_goal, "navvolume_big");

    if(var_baa92af9) {
      recordsphere(context + (0, 0, 20), 2, (0, 1, 0), "<dev string:xc6>");

      return true;
    }

    recordsphere(context + (0, 0, 20), 2, (1, 0, 0), "<dev string:xc6>");

    return false;
  }

  return true;
}

function private function_accec5c5(drop_origin, context, drop_height) {
  mask = 1;
  radius = 30;
  heli_drop_goal = (context[0], context[1], context[2] + drop_height);
  trace = physicstrace(heli_drop_goal, context + (0, 0, 10), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);

  if(trace[# "fraction"] < 1) {
    recordsphere(context + (0, 0, 20), 2, (1, 0, 0), "<dev string:xc6>");

    return false;
  }

  recordsphere(context + (0, 0, 20), 2, (0, 1, 0), "<dev string:xc6>");

  return true;
}

function private function_fc826e6(tacpoints, context, drop_height) {
  assert(isDefined(tacpoints) && tacpoints.size);
  filteredpoints = [];

  foreach(tacpoint in tacpoints) {
    if(function_75277c27(tacpoint, context) && function_7d90f954(tacpoint.origin, context) && function_9153c267(tacpoint.origin, context, drop_height)) {
      filteredpoints[filteredpoints.size] = tacpoint.origin;
    }
  }

  return filteredpoints;
}

function function_6dc6bc6b(origins, context, drop_height) {
  assert(isDefined(origins) && origins.size);
  filteredpoints = [];

  foreach(origin in origins) {
    if(function_accec5c5(origin, context, drop_height)) {
      filteredpoints[filteredpoints.size] = origin;
      break;
    }

    waitframe(1);
  }

  return filteredpoints;
}

function function_263d3e9e(drop_origin, drop_height, context) {
  if(getdvarint(#"hash_458cd0a10d30cedb", 1)) {
    if(function_7d90f954(drop_origin, context) && function_9153c267(drop_origin, context, drop_height)) {
      if(function_accec5c5(drop_origin, context, drop_height)) {
        return drop_origin;
      }
    }

    cylinder = ai::t_cylinder(drop_origin, 1000, 30);
    var_629f4ae1 = tacticalquery("supply_drop_deploy", drop_origin, cylinder);
    waitframe(1);
    cylinder = ai::t_cylinder(drop_origin, 2000, 30);
    var_3b8d7cbe = tacticalquery("supply_drop_deploy", drop_origin, cylinder);

    if(isDefined(var_3b8d7cbe) && var_3b8d7cbe.size) {
      tacpoints = arraycombine(var_629f4ae1, var_3b8d7cbe, 0, 0);
    }

    if(isDefined(tacpoints) && tacpoints.size) {
      tacpoints = function_fc826e6(tacpoints, context, drop_height);
      waitframe(1);

      if(tacpoints.size) {
        tacpoints = arraysortclosest(tacpoints, drop_origin);
        filteredpoints = function_6dc6bc6b(tacpoints, context, drop_height);

        if(isDefined(filteredpoints[0])) {
          recordsphere(filteredpoints[0] + (0, 0, 70), 4, (1, 0.5, 0), "<dev string:xc6>");

          return filteredpoints[0];
        } else {
          var_c71b63fa = arraygetclosest(drop_origin, tacpoints);

          recordsphere(var_c71b63fa + (0, 0, 70), 4, (0, 1, 1), "<dev string:xc6>");

          return var_c71b63fa;
        }
      }
    }
  }

  return drop_origin;
}

function function_fe13a227(chopper, heli_drop_goal, drop_height, original_drop_origin) {
  chopper endon(#"death", #"drop_goal");

  if(getdvarint(#"hash_458cd0a10d30cedb", 1)) {
    drop_origin = (heli_drop_goal[0], heli_drop_goal[1], heli_drop_goal[2] - drop_height);

    while(true) {
      recordsphere(original_drop_origin, 4, (1, 0, 0), "<dev string:xc6>");
      recordsphere(drop_origin, 4, (1, 0.5, 0), "<dev string:xc6>");
      recordsphere(heli_drop_goal, 4, (0, 0, 1), "<dev string:xc6>");
      recordline(drop_origin, heli_drop_goal, (0, 0, 1), "<dev string:xc6>");

      waitframe(1);
    }
  }
}

function helidelivercrate(origin, weapon, owner, team, killstreak_id, package_contents_id, context) {
  if(isDefined(owner) && owner emp::enemyempactive() && !owner hasperk(#"specialty_immuneemp")) {
    killstreakrules::killstreakstop(context.killstreakref, team, killstreak_id);
    self notify(#"cleanup_marker");
    return;
  }

  if(isDefined(owner) && isDefined(context.killstreaktype)) {
    owner killstreakrules::function_d9f8f32b(context.killstreaktype);
  }

  if(getdvarint(#"scr_supply_drop_valid_location_debug", 0) && isDefined(context) && isDefined(context.radius)) {
    level notify(#"stop_heli_drop_valid_location_marked_cylinder");
    level notify(#"stop_heli_drop_valid_location_arrived_at_goal_cylinder");
    level notify(#"stop_heli_drop_valid_location_dropped_cylinder");
    util::drawcylinder(origin, context.radius, 8000, 99999999, "<dev string:xd0>", (0.4, 0, 0.4), 0.8);
  }

  origin = self.markerposition;

  if(isDefined(context.marker)) {
    origin = context.marker.origin;
  }

  if(!isDefined(context.var_9fc6cfe9) || !context.var_9fc6cfe9) {
    context.markerfxhandle = spawnfx(level.killstreakcorebundle.fxmarkedlocation, origin + (0, 0, 5), (0, 0, 1), (1, 0, 0));
    context.markerfxhandle.team = owner.team;
    triggerfx(context.markerfxhandle);
  }

  bundle = getscriptbundle("killstreak_supply_drop");

  if(isDefined(owner)) {
    ricochetdistance = isDefined(bundle) ? bundle.ksricochetdistance : undefined;
    killstreaks::add_ricochet_protection(killstreak_id, owner, origin, ricochetdistance);
  }

  if(isDefined(context.marker)) {
    context.marker.team = owner.team;
    context.marker entityheadicons::destroyentityheadicons();
    context.marker entityheadicons::setentityheadicon(owner.pers[# "team"], owner, context.objective);
  }

  if(isPlayer(self) && isDefined(weapon)) {
    inccratekillstreakusagestat(weapon, killstreak_id);
  }

  rear_hatch_offset_local = getdvarint(#"scr_supplydropoffset", 0);
  drop_origin = origin;

  if(getdvarint(#"hash_458cd0a10d30cedb", 1)) {
    drop_height = 1600;
  } else {
    drop_height = getdropheight(drop_origin);
  }

  if(isDefined(level.var_eb8d406)) {
    drop_height = level.var_eb8d406;
  }

  drop_height += level.zoffsetcounter * 350;
  level.zoffsetcounter++;

  if(level.zoffsetcounter >= 5) {
    level.zoffsetcounter = 0;
  }

  original_drop_origin = drop_origin;

  if(!getdvarint(#"hash_7ccc40e85206e0a5", 1)) {
    drop_origin = function_263d3e9e(drop_origin, drop_height, context);
  } else if(!function_9153c267(drop_origin, context, drop_height)) {
    drop_origin = function_263d3e9e(drop_origin, drop_height, context);
  }

  if(isDefined(context.var_8741accb)) {
    context.var_cebe759b = gameobjects::get_next_obj_id();
    objective_add(context.var_cebe759b, "active", isDefined(drop_origin) ? drop_origin : original_drop_origin, context.var_8741accb);
  }

  if(isDefined(killstreak_id)) {
    adddroplocation(killstreak_id, drop_origin);
  }

  if(getdvarint(#"hash_458cd0a10d30cedb", 1)) {
    if(!isvec(drop_origin)) {
      drop_origin = original_drop_origin;
    }

    heli_drop_goal = (drop_origin[0], drop_origin[1], drop_origin[2] + drop_height);
  } else {
    heli_drop_goal = (drop_origin[0], drop_origin[1], drop_height);
  }

  goalpath = undefined;

  if(is_true(level.var_e071ed64)) {
    if(isDefined(context.dropoffset)) {
      goalpath = supplydrophelistartpath_v2_setup(heli_drop_goal, context.dropoffset, 0);
      supplydrophelistartpath_v2_part2_local(heli_drop_goal, goalpath, context.dropoffset);
    } else {
      goalpath = supplydrophelistartpath_v2_setup(heli_drop_goal, (rear_hatch_offset_local, 0, 0), 0);
      goal_path_setup_needs_finishing = 1;
    }
  } else if(isDefined(context.dropoffset)) {
    goalpath = supplydrophelistartpath_v2_setup(heli_drop_goal, context.dropoffset, 1);
    supplydrophelistartpath_v2_part2_local(heli_drop_goal, goalpath, context.dropoffset);
  } else {
    goalpath = supplydrophelistartpath_v2_setup(heli_drop_goal, (rear_hatch_offset_local, 0, 0), 1);
    goal_path_setup_needs_finishing = 1;
  }

  spawn_angles = vectortoangles((heli_drop_goal[0], heli_drop_goal[1], 0) - (goalpath.start[0], goalpath.start[1], 0));

  if(isDefined(context.vehiclename)) {
    helicoptervehicleinfo = context.vehiclename;
  } else {
    helicoptervehicleinfo = level.vtoldrophelicoptervehicleinfo;
  }

  assert(isDefined(bundle));
  chopper = spawn_helicopter(owner, team, goalpath.start, spawn_angles, helicoptervehicleinfo, "", killstreak_id, context);
  chopper killstreak_bundles::spawned(bundle);
  chopper thread function_fe13a227(chopper, heli_drop_goal, drop_height, original_drop_origin);

  if(isDefined(level.var_14151f16)) {
    [[level.var_14151f16]](chopper, 0);
  }

  if(level.var_e071ed64) {
    chopper makesentient();
    chopper makepathfinder();
    chopper.ignoreme = 1;
    chopper.ignoreall = 1;
    chopper setneargoalnotifydist(40);
    chopper.goalradius = 40;

    if(goal_path_setup_needs_finishing === 1) {
      goal_world_offset = chopper.origin - chopper getchopperdroppoint(context);
      supplydrophelistartpath_v2_part2(heli_drop_goal, goalpath, goal_world_offset);
      goal_path_setup_needs_finishing = 0;
    }
  } else if(goal_path_setup_needs_finishing === 1) {
    goal_world_offset = chopper.origin - chopper getchopperdroppoint(context);
    supplydrophelistartpath_v2_part2(heli_drop_goal, goalpath, goal_world_offset);
    goal_path_setup_needs_finishing = 0;
  }

  waitforonlyonedroplocation = 0;

  while(level.droplocations.size > 1 && waitforonlyonedroplocation) {
    arrayremovevalue(level.droplocations, undefined);
    wait_for_drop = 0;

    foreach(id, droplocation in level.droplocations) {
      if(id < killstreak_id) {
        wait_for_drop = 1;
        break;
      }
    }

    if(wait_for_drop) {
      wait 0.5;
      continue;
    }

    break;
  }

  chopper.killstreakweaponname = weapon.name;

  if(isDefined(context) && isDefined(context.hasflares)) {
    chopper.numflares = 3;
    chopper.flareoffset = (0, 0, 0);
    chopper thread helicopter::create_flare_ent((0, 0, -50));
  } else {
    chopper.numflares = 0;
  }

  killcament = spawn("script_model", chopper.origin + (0, 0, 800));
  killcament.angles = (100, chopper.angles[1], chopper.angles[2]);
  killcament.starttime = gettime();
  killcament linkto(chopper);

  if(!isDefined(chopper)) {
    return;
  }

  if(isDefined(context) && isDefined(context.prolog)) {
    chopper[[context.prolog]](context);
  } else if(isDefined(level.killstreakweapons[weapon])) {
    if(getdvarint(#"hash_458cd0a10d30cedb", 1)) {
      chopper thread helidropcrate(level.killstreakweapons[weapon], owner, rear_hatch_offset_local, killcament, killstreak_id, package_contents_id, context, drop_origin);
    } else {
      chopper thread helidropcrate(level.killstreakweapons[weapon], owner, rear_hatch_offset_local, killcament, killstreak_id, package_contents_id, context);
    }
  }

  chopper endon(#"death");

  if(level.var_e071ed64) {
    chopper.var_f766e12d = 15;
    chopper thread airsupport::function_f1b7b432(goalpath.path, "drop_goal", 1, 1, 1);
  } else {
    chopper thread airsupport::followpath(goalpath.path, "drop_goal", 1);
  }

  target_set(chopper, (0, 0, 50));
  chopper waittill(#"drop_goal");
  chopper.var_f766e12d = undefined;
  chopper thread function_e16ff9df(15);

  if(isDefined(owner)) {
    owner notify(#"payload_delivered");
  }

  if(isDefined(context) && isDefined(context.epilog)) {
    chopper[[context.epilog]](context);
  }

  println("<dev string:x101>" + gettime() - chopper.spawntime);

  if(getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
    if(isDefined(context.dropoffset)) {
      chopper_drop_point = chopper.origin - rotatepoint(context.dropoffset, chopper.angles);
    } else {
      chopper_drop_point = chopper getchopperdroppoint(context);
    }

    trace = groundtrace(chopper_drop_point + (0, 0, -100), chopper_drop_point + (0, 0, -10000), 0, undefined, 0);
    debug_drop_location = trace[# "position"];
    util::drawcylinder(debug_drop_location, context.radius, 8000, 99999999, "<dev string:x11c>", (1, 0.6, 0), 0.9);
    iprintln("<dev string:x156>" + distance2d(chopper_drop_point, heli_drop_goal));
  }

  on_target = 0;
  last_distance_from_goal_squared = sqr(1e+07);
  continue_waiting = 1;

  for(remaining_tries = 30; continue_waiting && remaining_tries > 0; remaining_tries--) {
    if(isDefined(context.dropoffset)) {
      chopper_drop_point = chopper.origin - rotatepoint(context.dropoffset, chopper.angles);
    } else {
      chopper_drop_point = chopper getchopperdroppoint(context);
    }

    current_distance_from_goal_squared = distance2dsquared(chopper_drop_point, heli_drop_goal);
    continue_waiting = current_distance_from_goal_squared < last_distance_from_goal_squared && current_distance_from_goal_squared > sqr(3.7);
    last_distance_from_goal_squared = current_distance_from_goal_squared;

    if(getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
      sphere(chopper_drop_point, 8, (1, 0, 0), 0.9, 0, 20, 1);
    }

    if(continue_waiting) {
      if(getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
        iprintln("<dev string:x178>" + distance2d(chopper_drop_point, heli_drop_goal));
      }

      waitframe(1);
    }
  }

  if(getdvarint(#"scr_supply_drop_valid_location_debug", 0)) {
    iprintln("<dev string:x18d>" + distance2d(chopper_drop_point, heli_drop_goal));
  }

  chopper scene::play(#"p9_fxanim_wz_parachute_supplydrop_01_harness_bundle", "arrive");
  chopper thread scene::play(#"p9_fxanim_wz_parachute_supplydrop_01_harness_bundle", "retract");
  chopper notify(#"drop_crate", {
    #position: chopper.origin, #direction: chopper.angles, #owner: chopper.owner
  });
  chopper.droptime = gettime();
  chopper playSound(#"veh_supply_drop");
  wait 0.7;

  if(isDefined(level.killstreakweapons[weapon])) {
    chopper killstreak_dialog::play_pilot_dialog_on_owner("waveStartFinal", level.killstreakweapons[weapon], chopper.killstreak_id);
  }

  chopper util::debug_slow_heli_speed();

  if(level.var_e071ed64) {
    chopper util::make_sentient();

    if(!ispathfinder(chopper)) {
      chopper makepathfinder();
    }

    chopper.ignoreme = 1;
    chopper.ignoreall = 1;
    goalpath = supplydropheliendpath_v2(chopper.origin, 0);
    chopper airsupport::function_f1b7b432(goalpath.path, undefined, 1, 1);
  } else {
    goalpath = supplydropheliendpath_v2(chopper.origin, 1);
    chopper airsupport::followpath(goalpath.path, undefined, 0);
  }

  println("<dev string:x1af>" + gettime() - chopper.droptime);
  chopper notify(#"leaving");
  chopper deletedelay();
}

function function_e16ff9df(delay) {
  wait delay;

  if(!isDefined(self)) {
    return;
  }

  if(target_istarget(self)) {
    target_remove(self);
  }
}

function helidropcrate(killstreak, originalowner, offset, killcament, killstreak_id, package_contents_id, context, var_83f3c388) {
  helicopter = self;

  if(isDefined(originalowner)) {
    originalowner endon(#"disconnect");
  }

  crate = cratespawn(killstreak, killstreak_id, originalowner, self.team, self.origin, self.angles, undefined, context);
  self.crate = crate;

  if(getdvarint(#"hash_3f663d1e38d10d99", 0) == 1 || is_true(crate.var_e8a59c52)) {
    self.var_11031e00 = 1;
    self clientfield::set("" + # "hash_e4eb5c0853abab8", 1);
    self playSound(#"hash_2548935de6c0af");
  }

  if(killstreak == "inventory_supply_drop" || killstreak == "supply_drop") {
    self thread scene::play(#"p9_fxanim_wz_parachute_supplydrop_01_harness_bundle", "fly_in");
    helicopter clientfield::set("supplydrop_care_package_state", 1);
  } else if(killstreak == "inventory_tank_robot" || killstreak == "tank_robot" || killstreak == "ai_tank_marker") {
    crate linkto(helicopter, isDefined(context.droptag) ? context.droptag : "tag_origin", isDefined(context.droptagoffset) ? context.droptagoffset : (0, 0, 0));
    helicopter clientfield::set("supplydrop_ai_tank_state", 1);

    if(isDefined(level.var_14151f16)) {
      [[level.var_14151f16]](crate, 0);
    }
  }

  team = self.team;
  waitresult = helicopter waittill(#"drop_crate", #"hash_525537be2de4c159");
  chopperowner = waitresult.owner;
  origin = waitresult.position;
  angles = waitresult.direction;

  if(waitresult._notify == # "hash_525537be2de4c159") {
    self.crate.var_da439787 = 1;
    self.crate.angles = (0, self.crate.angles[1], 0);
  }

  if(isDefined(chopperowner)) {
    owner = chopperowner;

    if(owner != originalowner) {
      crate killstreaks::configure_team(killstreak, owner);
      killstreaks::remove_ricochet_protection(killstreak_id, owner);
    }
  } else {
    owner = originalowner;
  }

  if(isDefined(self)) {
    team = self.team;

    if(killstreak == "inventory_supply_drop" || killstreak == "supply_drop") {
      helicopter clientfield::set("supplydrop_care_package_state", 0);
    } else if(killstreak == "inventory_tank_robot" || killstreak == "tank_robot") {
      helicopter clientfield::set("supplydrop_ai_tank_state", 0);
    }
  }

  if(!isDefined(owner) || team == owner.team) {
    rear_hatch_offset_height = getdvarint(#"scr_supplydropoffsetheight", 200);
    rear_hatch_offset_world = rotatepoint((offset, 0, 0), angles);
    drop_origin = origin - (0, 0, rear_hatch_offset_height) - rear_hatch_offset_world;
    self thread dropcrate(drop_origin, angles, killstreak, owner, team, killcament, killstreak_id, package_contents_id, crate, context, var_83f3c388);
    self.crate = undefined;
  }
}

function lbexplode() {
  forward = self.origin + (0, 0, 1) - self.origin;
  fxpos = self gettagorigin("tag_body");

  if(!isDefined(fxpos)) {
    fxpos = self.origin;
  }

  if(isDefined(self.explosionfx)) {
    playFX(self.explosionfx, fxpos, anglesToForward(self.angles), anglestoup(self.angles));
  }

  if(self.var_11031e00 === 1) {
    self clientfield::set("" + # "hash_e4eb5c0853abab8", 0);
  }

  self playSound(level.heli_sound[# "crash"]);
  self notify(#"explode");

  if(isDefined(self.delete_after_destruction_wait_time)) {
    self hide();
    self waitanddelete(self.delete_after_destruction_wait_time);
    return;
  }

  self delete();
}

function lbspin(speed) {
  self endon(#"explode");
  playFXOnTag(self.var_78d69212, self, "tail_rotor_jnt");
  self setyawspeed(speed, speed, speed);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + speed * 0.9);
    wait 1;
  }
}

function refcountdecchopper(team, killstreak_id, killstreaktype, var_9e10e827) {
  self waittill(#"death");
  self.var_9e10e827 = var_9e10e827;
  self killstreakrules::killstreakstop(killstreaktype, team, killstreak_id);
  self notify(#"cleanup_marker");
}

function function_4bf116ab(ents) {
  self.crate linkto(ents[# "harness"], "tag_care_package", (0, 0, 0), (0, 0, 0));
}

function function_2842c984(ents) {
  if(isDefined(self.crate)) {
    self.crate delete();
  }
}

function function_76b49bd8(ents) {
  ents[# "parachute"] clientfield::set("supply_drop_parachute_rob", 1);
  self.parachute = ents[# "parachute"];
}

function function_2defd397() {
  self endon(#"death");
  self scene::play(#"p9_fxanim_wz_parachute_supplydrop_01_bundle", "open");
  self thread scene::play(#"p9_fxanim_wz_parachute_supplydrop_01_bundle", "idle");
  self waittill(#"movedone");
  self scene::stop(#"p9_fxanim_wz_parachute_supplydrop_01_bundle");
  self.parachute thread scene::play(#"p9_fxanim_wz_parachute_supplydrop_01_bundle", "detach", self.parachute);
  wait 1;

  if(isDefined(self.parachute)) {
    self.parachute clientfield::set("supply_drop_parachute_rob", 0);
  }
}

function supply_drop_dev_gui() {
  setDvar(#"scr_supply_drop_gui", "<dev string:x6f>");

  while(true) {
    wait 0.5;
    devgui_string = getdvarstring(#"scr_supply_drop_gui");
    level.dev_gui_supply_drop = devgui_string;
  }
}