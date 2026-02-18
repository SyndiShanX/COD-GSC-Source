/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\killstreaks_shared.gsc
***********************************************/

#using script_396f7d71538c9677;
#using scripts\abilities\ability_util;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\damage;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\placeables;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreak_dialog;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\weaponobjects;
#namespace killstreaks;

function init_shared() {
  level.killstreaks = [];
  level.killstreakweapons = [];
  level.var_b1dfdc3b = [];
  level.var_8997324c = [];
  level.droplocations = [];
  level.zoffsetcounter = 0;
  level.var_46c23c0f = 0;
  clientfield::register_clientuimodel("locSel.commandMode", 1, 1, "int");
  clientfield::register_clientuimodel("locSel.snapTo", 1, 1, "int");
  clientfield::register("vehicle", "timeout_beep", 1, 2, "int");
  clientfield::register("toplayer", "thermal_glow", 1, 1, "int");
  clientfield::register("toplayer", "thermal_glow_enemies_only", 12000, 1, "int");
  clientfield::register("vehicle", "standardTagFxSet", 1, 1, "int");
  clientfield::register("scriptmover", "standardTagFxSet", 1, 1, "int");
  clientfield::register("scriptmover", "lowHealthTagFxSet", 1, 1, "int");
  clientfield::register("scriptmover", "deathTagFxSet", 1, 1, "int");
  clientfield::register("toplayer", "" + # "hash_524d30f5676b2070", 1, 1, "int");
  clientfield::register("vehicle", "scorestreakActive", 1, 1, "int");
  clientfield::register("scriptmover", "scorestreakActive", 1, 1, "int");
  killstreak_dialog::function_196f2c38();
  level.var_19a15e42 = undefined;
  level.killstreakmaxhealthfunction = &killstreak_bundles::get_max_health;
  level.var_239dc073 = getweapon(#"killstreak_remote");

  if(!isDefined(level.var_6cfbe5a)) {
    level.var_6cfbe5a = new throttle();
    [[level.var_6cfbe5a]] - > initialize(1, 0.1);
  }

  level.var_98769415 = &get_from_weapon;
  level.iskillstreakweapon = &is_killstreak_weapon;
  level.get_killstreak_for_weapon_for_stats = &get_killstreak_for_weapon_for_stats;
}

function function_447e6858() {
  level.killstreakcorebundle = getscriptbundle("killstreak_core");

  if(!isDefined(level.roundstartkillstreakdelay)) {
    level.roundstartkillstreakdelay = 0;
  }

  level.numkillstreakreservedobjectives = 0;
  level.killstreakcounter = 0;
  callback::on_spawned(&on_player_spawned);
  callback::on_joined_team(&on_joined_team);
}

function function_b5b6ef3e(func, obj) {
  callback::add_callback(#"hash_45f35669076bc317", func, obj);
}

function private register_ui(killstreak_type, killstreak_menu) {
  assert(isDefined(level.killstreaks[killstreak_type]), "<dev string:x38>");
  item_index = getitemindexfromref(killstreak_menu);
  killstreak_info = getunlockableiteminfofromindex(item_index, 0);
  killstreak_cost = 0;

  if(isDefined(killstreak_info)) {
    killstreak_cost = killstreak_info.momentum;
  }

  level.killstreaks[killstreak_type].itemindex = item_index;
  level.killstreaks[killstreak_type].momentumcost = killstreak_cost;
  level.killstreaks[killstreak_type].menuname = killstreak_menu;
  level.killstreaks[killstreak_type].uiname = "";

  if(isDefined(killstreak_info)) {
    level.killstreaks[killstreak_type].uiname = killstreak_info.displayname;
  }

  if(level.killstreaks[killstreak_type].uiname == "<dev string:x75>") {
    level.killstreaks[killstreak_type].uiname = killstreak_menu;
  }
}

function private killstreak_init(killstreak_type) {
  assert(isDefined(killstreak_type), "<dev string:x79>");
  assert(!isDefined(level.killstreaks[killstreak_type]), "<dev string:xb5>" + killstreak_type + "<dev string:xc4>");
  level.killstreaks[killstreak_type] = spawnStruct();
  level.killstreaks[killstreak_type].killstreaklevel = 0;
  level.killstreaks[killstreak_type].quantity = 0;
  level.killstreaks[killstreak_type].overrideentitycameraindemo = 0;
  level.killstreaks[killstreak_type].teamkillpenaltyscale = 1;
  level.killstreaks[killstreak_type].var_b6c17aab = 0;
}

function private register_weapon(killstreak_type, bundle, weapon) {
  if(weapon.name == # "none") {
    return;
  }

  assert(isDefined(killstreak_type), "<dev string:x79>");
  assert(weapon.name != # "none");
  assert(!isDefined(level.killstreakweapons[weapon]), "<dev string:xdb>");
  level.killstreaks[killstreak_type].weapon = weapon;
  level.killstreakweapons[weapon] = killstreak_type;

  if(is_true(bundle.var_7f7b9887)) {
    level.var_b1dfdc3b[weapon] = killstreak_type;
  }
}

function private register_vehicle(killstreak_type, vehicle) {
  assert(isDefined(killstreak_type), "<dev string:x79>");
  assert(!isDefined(level.var_8997324c[vehicle]), "<dev string:xdb>");
  level.killstreaks[killstreak_type].vehicle = vehicle;
  level.var_8997324c[vehicle] = killstreak_type;
}

function private function_e48aca4d(type, bundle, weapon, vehicle, killstreak_use_function, isinventoryweapon) {
  killstreak_init(type);
  menukey = bundle.var_a99ef6da;

  if(!isDefined(menukey)) {
    menukey = type;
  } else if(is_true(isinventoryweapon)) {
    menukey = "inventory_" + menukey;
  }

  register_ui(type, menukey);
  level.killstreaks[type].usagekey = type;
  level.killstreaks[type].delaystreak = bundle.var_daf6b7af;
  level.killstreaks[type].usefunction = killstreak_use_function;
  register_weapon(type, bundle, weapon);
  level.menureferenceforkillstreak[menukey] = type;

  if(isDefined(bundle.altweapons)) {
    foreach(alt_weapon in bundle.altweapons) {
      function_181f96a6(type, bundle, alt_weapon.ksaltweapon);
    }
  }

  if(isDefined(vehicle)) {
    register_vehicle(type, vehicle);
  }

  level.killstreaks[type].notavailabletext = bundle.var_502a0e23;
  level.killstreaks[type].script_bundle = bundle;
  killstreak_dialog::function_1110a5de(type);

  if(is_true(bundle.var_1bc9830d) && is_true(isinventoryweapon)) {
    register_dev_dvars(type);
  }

  switch (bundle.var_c36eb69b) {
    case # "none":
      level.killstreaks[type].teamkillpenaltyscale = 0;
      break;
    case # "reduced":
      level.killstreaks[type].teamkillpenaltyscale = level.teamkillreducedpenalty;
      break;
    case # "default":
    default:
      level.killstreaks[type].teamkillpenaltyscale = 1;
      break;
  }
}

function register_bundle(bundle, killstreak_use_function) {
  function_e48aca4d(bundle.kstype, bundle, bundle.ksweapon, bundle.ksvehicle, killstreak_use_function, 0);

  if(isDefined(bundle.ksinventoryweapon) && bundle.ksinventoryweapon.name != # "none") {
    function_e48aca4d("inventory_" + bundle.kstype, bundle, bundle.ksinventoryweapon, undefined, killstreak_use_function, 1);

    if(bundle.ksinventoryweapon.iscarriedkillstreak && bundle.ksweapon.iscarriedkillstreak) {
      if(!isDefined(level.var_6110cb51)) {
        level.var_6110cb51 = [];
      }

      level.var_6110cb51[bundle.ksweapon] = bundle.ksinventoryweapon;
    }
  }
}

function register_killstreak(bundlename, use_function) {
  bundle = getscriptbundle(bundlename);
  register_bundle(bundle, use_function);
}

function function_94c74046(killstreaktype) {
  assert(isDefined(killstreaktype), "<dev string:x11a>");

  if(!isDefined(level.var_33c629ad)) {
    level.var_33c629ad = [];
  }

  level.var_33c629ad[killstreaktype] = 1;
}

function function_6bde02cc(killstreaktype) {
  return isDefined(level.var_33c629ad[killstreaktype]);
}

function private function_181f96a6(killstreaktype, bundle, weapon) {
  assert(isDefined(killstreaktype), "<dev string:x79>");
  assert(isDefined(level.killstreaks[killstreaktype]), "<dev string:x16a>");

  if(weapon == level.weaponnone) {
    return;
  }

  if(level.killstreaks[killstreaktype].weapon === weapon) {
    return;
  }

  if(!isDefined(level.killstreakweapons[weapon])) {
    level.killstreakweapons[weapon] = killstreaktype;
  }

  if(is_true(bundle.var_7f7b9887)) {
    if(!isDefined(level.var_b1dfdc3b[weapon])) {
      level.var_b1dfdc3b[weapon] = killstreaktype;
    }
  }
}

function private register_alt_weapon(killstreaktype, weapon) {
  function_181f96a6(killstreaktype, weapon);
  function_181f96a6("inventory_" + killstreaktype, weapon);
}

function function_b013c2d3(killstreaktype, weapon) {
  if(!isDefined(level.var_3ff1b984)) {
    level.var_3ff1b984 = [];
  }

  level.var_3ff1b984[weapon] = killstreaktype;
}

function function_d8c32ca4(killstreaktype, var_ae755d2f) {
  if(!isDefined(level.var_a385666)) {
    level.var_a385666 = [];
  }

  level.var_a385666[killstreaktype] = var_ae755d2f;
}

function register_dev_dvars(killstreaktype) {
  assert(isDefined(killstreaktype), "<dev string:x79>");
  assert(isDefined(level.killstreaks[killstreaktype]), "<dev string:x1b3>");
  level.killstreaks[killstreaktype].devdvar = "<dev string:x1fa>" + killstreaktype + "<dev string:x202>";
  level.killstreaks[killstreaktype].devenemydvar = "<dev string:x1fa>" + killstreaktype + "<dev string:x20b>";
  level.killstreaks[killstreaktype].devtimeoutdvar = "<dev string:x1fa>" + killstreaktype + "<dev string:x219>";
  setDvar(level.killstreaks[killstreaktype].devtimeoutdvar, 0);
  level thread register_devgui(killstreaktype);
}

function register_dev_debug_dvar(killstreaktype) {
  assert(isDefined(killstreaktype), "<dev string:x79>");
  assert(isDefined(level.killstreaks[killstreaktype]), "<dev string:x1b3>");
  level.killstreaks[killstreaktype].devdebugdvar = "<dev string:x1fa>" + killstreaktype + "<dev string:x227>";
  devgui_scorestreak_command_debugdvar(killstreaktype, level.killstreaks[killstreaktype].devdebugdvar);
}

function register_devgui(killstreaktype) {
  level endon(#"game_ended");
  wait randomintrange(2, 20) * float(function_60d95f53()) / 1000;
  give_type_all = "<dev string:x231>";
  give_type_enemy = "<dev string:x239>";

  if(isDefined(level.killstreaks[killstreaktype].devdvar)) {
    devgui_scorestreak_command_givedvar(killstreaktype, give_type_all, level.killstreaks[killstreaktype].devdvar);
  }

  if(isDefined(level.killstreaks[killstreaktype].devenemydvar)) {
    devgui_scorestreak_command_givedvar(killstreaktype, give_type_enemy, level.killstreaks[killstreaktype].devenemydvar);
  }

  if(isDefined(level.killstreaks[killstreaktype].devtimeoutdvar)) {}
}

function devgui_scorestreak_command_givedvar(killstreaktype, give_type, dvar) {
  devgui_scorestreak_command(killstreaktype, give_type, "<dev string:x247>" + dvar + "<dev string:x24f>");
}

function devgui_scorestreak_command_timeoutdvar(killstreaktype, dvar) {
  devgui_scorestreak_dvar_toggle(killstreaktype, "<dev string:x255>", dvar);
}

function devgui_scorestreak_command_debugdvar(killstreaktype, dvar) {
  devgui_scorestreak_dvar_toggle(killstreaktype, "<dev string:x261>", dvar);
}

function devgui_scorestreak_dvar_toggle(killstreaktype, title, dvar) {
  setDvar(dvar, 0);
  devgui_scorestreak_command(killstreaktype, "Toggle " + title, "toggle " + dvar + " 1 0");
}

function devgui_scorestreak_command(killstreaktype, title, command) {
  assert(isDefined(killstreaktype), "<dev string:x79>");
  assert(isDefined(level.killstreaks[killstreaktype]), "<dev string:x1b3>");
  root = "<dev string:x26a>";
  display_name = level.killstreaks[killstreaktype].menuname;
  killstreak_weapon = get_killstreak_weapon(killstreaktype);

  if(isDefined(killstreak_weapon) && killstreak_weapon != level.weaponnone) {
    if(killstreak_weapon.displayname == # "") {
      display_name += "<dev string:x28a>";
    } else {
      display_name = makelocalizedstring(killstreak_weapon.displayname);
    }

    if(strstartswith(display_name, "<dev string:x29e>")) {
      display_name = getsubstr(display_name, 10);
    }
  } else if(strstartswith(display_name, "<dev string:x29e>")) {
    display_name = getsubstr(display_name, 10);
  }

  if(strstartswith(killstreaktype, "<dev string:x29e>")) {
    killstreaktype = getsubstr(killstreaktype, 10);
  }

  util::add_queued_debug_command(root + display_name + "<dev string:x2ac>" + killstreaktype + "<dev string:x2b2>" + title + "<dev string:x2b8>" + command + "<dev string:x2bf>");
}

function should_draw_debug(killstreak) {
  assert(isDefined(killstreak), "<dev string:x79>");
  function_2459bd2f();

  if(isDefined(level.killstreaks[killstreak]) && isDefined(level.killstreaks[killstreak].devdebugdvar)) {
    return getdvarint(level.killstreaks[killstreak].devdebugdvar, 0);
  }

  return 0;
}

function function_2459bd2f() {
  assert(isDefined(level.killstreaks), "<dev string:x2c6>");
}

function is_available(killstreak) {
  if(isDefined(level.menureferenceforkillstreak[killstreak])) {
    return 1;
  }

  return 0;
}

function get_by_menu_name(killstreak) {
  return level.menureferenceforkillstreak[killstreak];
}

function get_menu_name(killstreaktype) {
  assert(isDefined(level.killstreaks[killstreaktype]));
  return level.killstreaks[killstreaktype].menuname;
}

function get_level(index, killstreak) {
  killstreaklevel = level.killstreaks[get_by_menu_name(killstreak)].killstreaklevel;

  if(getdvarint(#"custom_killstreak_mode", 0) == 2) {
    if(isDefined(self.killstreak[index]) && killstreak == self.killstreak[index]) {
      killsrequired = getdvarint("custom_killstreak_" + index + 1 + "_kills", 0);

      if(killsrequired) {
        killstreaklevel = getdvarint("custom_killstreak_" + index + 1 + "_kills", 0);
      }
    }
  }

  return killstreaklevel;
}

function give_if_streak_count_matches(index, killstreak, streakcount) {
  pixbeginevent(#"");

  if(!isDefined(killstreak)) {
    println("<dev string:x336>");
  }

  if(isDefined(killstreak)) {
    println("<dev string:x350>" + killstreak + "<dev string:x369>");
  }

  if(!is_available(killstreak)) {
    println("<dev string:x36e>");
  }

  if(self.pers[# "killstreaksearnedthiskillstreak"] > index && util::isroundbased()) {
    hasalreadyearnedkillstreak = 1;
  } else {
    hasalreadyearnedkillstreak = 0;
  }

  if(isDefined(killstreak) && is_available(killstreak) && !hasalreadyearnedkillstreak) {
    killstreaklevel = get_level(index, killstreak);

    if(self hasperk(#"specialty_killstreak")) {
      reduction = getdvarint(#"perk_killstreakreduction", 0);
      killstreaklevel -= reduction;

      if(killstreaklevel <= 0) {
        killstreaklevel = 1;
      }
    }

    if(killstreaklevel == streakcount) {
      self give(get_by_menu_name(killstreak), streakcount);
      self.pers[# "killstreaksearnedthiskillstreak"] = index + 1;
      pixendevent();
      return true;
    }
  }

  pixendevent();
  return false;
}

function give_for_streak() {
  if(!util::is_killstreaks_enabled()) {
    return;
  }

  if(!isDefined(self.pers[# "totalkillstreakcount"])) {
    self.pers[# "totalkillstreakcount"] = 0;
  }

  given = 0;

  for(i = 0; i < self.killstreak.size; i++) {
    given |= give_if_streak_count_matches(i, self.killstreak[i], self.pers[# "cur_kill_streak"]);
  }
}

function give(killstreaktype, streak, suppressnotification, noxp, tobottom) {
  pixbeginevent(#"");
  self endon(#"disconnect");
  level endon(#"game_ended");
  killstreakgiven = 0;

  if(isDefined(noxp)) {
    if(self give_internal(streak, undefined, noxp, tobottom)) {
      killstreakgiven = 1;

      if(self.just_given_new_inventory_killstreak === 1) {
        self add_to_notification_queue(level.killstreaks[streak].menuname, suppressnotification, streak, noxp, 1);
      }
    }
  } else if(self give_internal(streak)) {
    killstreakgiven = 1;

    if(self.just_given_new_inventory_killstreak === 1) {
      self add_to_notification_queue(level.killstreaks[streak].menuname, suppressnotification, streak, noxp, 1);
    }
  }

  pixendevent();

  if(isDefined(level.var_706f827)) {
    self[[level.var_706f827]]({
      #killstreaktype: streak
    });
  }

  return killstreakgiven;
}

function take(killstreak) {
  self endon(#"disconnect");
  killstreak_weapon = get_killstreak_weapon(killstreak);
  remove_used_killstreak(killstreak);

  if(self getinventoryweapon() == killstreak_weapon) {
    self setinventoryweapon(level.weaponnone);
  }

  waittillframeend();
  currentweapon = self getcurrentweapon();

  if(currentweapon != killstreak_weapon || killstreak_weapon.iscarriedkillstreak) {
    return;
  }

  switch_to_last_non_killstreak_weapon();
  activate_next();
}

function remove_oldest() {
  if(isDefined(self.pers[# "killstreaks"][0])) {
    currentweapon = self getcurrentweapon();

    if(currentweapon == get_killstreak_weapon(self.pers[# "killstreaks"][0])) {
      primaries = self getweaponslistprimaries();

      if(primaries.size > 0) {
        self switchtoweapon(primaries[0]);
      }
    }

    self notify(#"oldest_killstreak_removed", {
      #type: self.pers[# "killstreaks"][0], #id: self.pers[# "killstreak_unique_id"][0]
    });
    self remove_used_killstreak(self.pers[# "killstreaks"][0], self.pers[# "killstreak_unique_id"][0], 0);
  }
}

function give_internal(killstreaktype, do_not_update_death_count, noxp, tobottom) {
  self.just_given_new_inventory_killstreak = undefined;

  if(level.gameended) {
    return false;
  }

  if(!util::is_killstreaks_enabled()) {
    return false;
  }

  if(!isDefined(level.killstreaks[do_not_update_death_count])) {
    return false;
  }

  if(!isDefined(self.pers[# "killstreaks"])) {
    self.pers[# "killstreaks"] = [];
  }

  if(!isDefined(self.pers[# "killstreak_has_been_used"])) {
    self.pers[# "killstreak_has_been_used"] = [];
  }

  if(!isDefined(self.pers[# "killstreak_unique_id"])) {
    self.pers[# "killstreak_unique_id"] = [];
  }

  if(!isDefined(self.pers[# "killstreak_ammo_count"])) {
    self.pers[# "killstreak_ammo_count"] = [];
  }

  just_max_stack_removed_inventory_killstreak = undefined;

  if(isDefined(tobottom) && tobottom) {
    size = self.pers[# "killstreaks"].size;

    if(self.pers[# "killstreaks"].size >= level.maxinventoryscorestreaks) {
      self remove_oldest();
      just_max_stack_removed_inventory_killstreak = self.just_removed_used_killstreak;
    }

    for(i = size; i > 0; i--) {
      self.pers[# "killstreaks"][i] = self.pers[# "killstreaks"][i - 1];
      self.pers[# "killstreak_has_been_used"][i] = self.pers[# "killstreak_has_been_used"][i - 1];
      self.pers[# "killstreak_unique_id"][i] = self.pers[# "killstreak_unique_id"][i - 1];
      self.pers[# "killstreak_ammo_count"][i] = self.pers[# "killstreak_ammo_count"][i - 1];
    }

    self.pers[# "killstreaks"][0] = do_not_update_death_count;
    self.pers[# "killstreak_unique_id"][0] = level.killstreakcounter;
    level.killstreakcounter++;

    if(isDefined(noxp)) {
      self.pers[# "killstreak_has_been_used"][0] = noxp;
    } else {
      self.pers[# "killstreak_has_been_used"][0] = 0;
    }

    if(size == 0) {
      ammocount = give_weapon(do_not_update_death_count);
    }

    self.pers[# "killstreak_ammo_count"][0] = 0;
  } else {
    var_7b935486 = 0;

    if(self.pers[# "killstreaks"].size && self.currentweapon === get_killstreak_weapon(self.pers[# "killstreaks"][self.pers[# "killstreaks"].size - 1])) {
      var_7b935486 = 1;
    }

    self.pers[# "killstreaks"][self.pers[# "killstreaks"].size] = do_not_update_death_count;
    self.pers[# "killstreak_unique_id"][self.pers[# "killstreak_unique_id"].size] = level.killstreakcounter;
    level.killstreakcounter++;

    if(self.pers[# "killstreaks"].size > level.maxinventoryscorestreaks) {
      self remove_oldest();
      just_max_stack_removed_inventory_killstreak = self.just_removed_used_killstreak;
    }

    if(!isDefined(noxp)) {
      noxp = 0;
    }

    self.pers[# "killstreak_has_been_used"][self.pers[# "killstreak_has_been_used"].size] = noxp;
    ammocount = give_weapon(do_not_update_death_count);
    self.pers[# "killstreak_ammo_count"][self.pers[# "killstreak_ammo_count"].size] = ammocount;

    if(var_7b935486) {
      var_3522232f = self.pers[# "killstreaks"].size - 2;
      var_a1312679 = self.pers[# "killstreaks"].size - 1;
      var_3197d2aa = self.pers[# "killstreaks"][var_3522232f];
      var_c72e250a = self.pers[# "killstreak_unique_id"][var_3522232f];
      var_948e9ad0 = self.pers[# "killstreak_has_been_used"][var_3522232f];
      var_80931fe9 = self.pers[# "killstreak_ammo_count"][var_3522232f];
      self.pers[# "killstreaks"][var_3522232f] = self.pers[# "killstreaks"][var_a1312679];
      self.pers[# "killstreak_unique_id"][var_3522232f] = self.pers[# "killstreak_unique_id"][var_a1312679];
      self.pers[# "killstreak_has_been_used"][var_3522232f] = self.pers[# "killstreak_has_been_used"][var_a1312679];
      self.pers[# "killstreak_ammo_count"][var_3522232f] = self.pers[# "killstreak_ammo_count"][var_a1312679];
      self.pers[# "killstreaks"][var_a1312679] = var_3197d2aa;
      self.pers[# "killstreak_unique_id"][var_a1312679] = var_c72e250a;
      self.pers[# "killstreak_has_been_used"][var_a1312679] = var_948e9ad0;
      self.pers[# "killstreak_ammo_count"][var_a1312679] = var_80931fe9;
      self setinventoryweapon(get_killstreak_weapon(var_3197d2aa));
    }
  }

  self notify(#"killstreak_give", {
    #killstreak: do_not_update_death_count
  });
  self.just_given_new_inventory_killstreak = do_not_update_death_count !== just_max_stack_removed_inventory_killstreak && !is_true(var_7b935486);

  if(!isDefined(self.var_58d669ff)) {
    self.var_58d669ff = [];
  }

  if(!isDefined(self.var_58d669ff[do_not_update_death_count])) {
    self.var_58d669ff[do_not_update_death_count] = [];
  }

  array::push(self.var_58d669ff[do_not_update_death_count], gettime(), self.var_58d669ff[do_not_update_death_count].size);
  return true;
}

function add_to_notification_queue(menuname, streakcount, hardpointtype, nonotify, var_af825242) {
  killstreaktablenumber = level.killstreakindices[streakcount];

  if(!isDefined(killstreaktablenumber)) {
    if(sessionmodeiszombiesgame() && !is_true(nonotify)) {
      self thread killstreak_dialog::play_killstreak_ready_dialog(hardpointtype, 1);
      self thread play_killstreak_ready_sfx(hardpointtype);
    }

    return;
  }

  if(is_true(nonotify)) {
    return;
  }

  informdialog = killstreak_dialog::get_killstreak_inform_dialog(hardpointtype);
  killstreakslot = function_a2c375bb(hardpointtype);
  self thread killstreak_dialog::play_killstreak_ready_dialog(hardpointtype, 2.4);
  self thread play_killstreak_ready_sfx(hardpointtype);
  self luinotifyevent(#"killstreak_received", 3, killstreaktablenumber, informdialog, var_af825242);
  self function_8ba40d2f(#"killstreak_received", 3, killstreaktablenumber, informdialog, var_af825242);

  if(isDefined(killstreakslot)) {
    self function_6bf621ea(#"hash_6a9cb800ad0ef395", 2, self getentitynumber(), killstreakslot);
  }
}

function has_equipped() {
  currentweapon = self getcurrentweapon();

  foreach(killstreak in level.killstreaks) {
    if(killstreak.weapon == currentweapon) {
      return true;
    }
  }

  return false;
}

function _get_from_weapon(weapon) {
  return get_killstreak_for_weapon(weapon);
}

function get_from_weapon(weapon) {
  if(weapon == level.weaponnone) {
    return undefined;
  }

  res = _get_from_weapon(weapon);

  if(!isDefined(res)) {
    return _get_from_weapon(weapon.rootweapon);
  }

  return res;
}

function private function_ed34685(currentweapon) {
  if(currentweapon != level.weaponnone && !is_true(level.usingmomentum)) {
    weaponslist = self getweaponslist();

    foreach(carriedweapon in weaponslist) {
      if(currentweapon == carriedweapon) {
        continue;
      }

      var_6ddecf7f = get_killstreak_for_weapon(carriedweapon);

      if(isDefined(var_6ddecf7f)) {
        if(level.killstreaks[var_6ddecf7f].script_bundle.var_301403ee) {
          continue;
        }
      }

      if(is_killstreak_weapon(carriedweapon)) {
        self takeweapon(carriedweapon);
      }
    }
  }
}

function give_weapon(killstreaktype, usestoredammo) {
  currentweapon = self getcurrentweapon();
  function_ed34685(currentweapon);
  weapon = get_killstreak_weapon(killstreaktype);

  if(currentweapon != weapon && self hasweapon(weapon) == 0) {
    self takeweapon(weapon);
    self giveweapon(weapon);
  }

  if(is_true(level.usingmomentum)) {
    self setinventoryweapon(weapon);

    if(weapon.iscarriedkillstreak) {
      if(!isDefined(self.pers[# "held_killstreak_ammo_count"][weapon])) {
        self.pers[# "held_killstreak_ammo_count"][weapon] = 0;
      }

      if(!isDefined(self.pers[# "held_killstreak_clip_count"][weapon])) {
        self.pers[# "held_killstreak_clip_count"][weapon] = weapon.clipsize;
      }

      if(!isDefined(self.pers[# "killstreak_quantity"][weapon])) {
        self.pers[# "killstreak_quantity"][weapon] = 0;
      }

      var_e93a65da = self.pers[# "killstreak_ammo_count"][self.pers[# "killstreak_ammo_count"].size - 1];

      if(currentweapon == weapon && !isheldinventorykillstreakweapon(weapon)) {
        return weapon.maxammo;
      } else if(is_true(usestoredammo) && (isDefined(var_e93a65da) ? var_e93a65da : 0) > 0) {
        if((isDefined(self.pers[# "held_killstreak_ammo_count"][weapon]) ? self.pers[# "held_killstreak_ammo_count"][weapon] : 0) > 0) {
          return self.pers[# "held_killstreak_ammo_count"][weapon];
        }

        self.pers[# "held_killstreak_ammo_count"][weapon] = var_e93a65da;
        self loadout::function_3ba6ee5d(weapon, var_e93a65da);
      } else {
        self.pers[# "held_killstreak_ammo_count"][weapon] = weapon.maxammo;
        self.pers[# "held_killstreak_clip_count"][weapon] = weapon.clipsize;
        self loadout::function_3ba6ee5d(weapon, self.pers[# "held_killstreak_ammo_count"][weapon]);
      }

      return self.pers[# "held_killstreak_ammo_count"][weapon];
    } else {
      switch (level.killstreaks[killstreaktype].script_bundle.var_514a90ee) {
        case # "clip":
          delta = weapon.clipsize;
          break;
        case # "one":
          delta = 1;
          break;
        default:
          delta = 0;
          break;
      }

      return change_killstreak_quantity(weapon, delta);
    }

    return;
  }

  self setactionslot(4, "weapon", weapon);
  return 1;
}

function activate_next(do_not_update_death_count) {
  if(level.gameended) {
    return false;
  }

  if(is_true(level.usingmomentum)) {
    self setinventoryweapon(level.weaponnone);
  } else {
    self setactionslot(4, "");
  }

  if(!isDefined(self.pers[# "killstreaks"]) || self.pers[# "killstreaks"].size == 0) {
    return false;
  }

  killstreaktype = self.pers[# "killstreaks"][self.pers[# "killstreaks"].size - 1];

  if(!isDefined(level.killstreaks[killstreaktype])) {
    return false;
  }

  weapon = level.killstreaks[killstreaktype].weapon;
  waitframe(1);

  if(self isremotecontrolling() && self.usingremote === weapon.statname) {
    while(self isremotecontrolling()) {
      waitframe(1);
    }
  }

  ammocount = give_weapon(killstreaktype, 1);

  if(weapon.iscarriedkillstreak) {
    if(!is_true(level.var_174c7c61) || !sessionmodeiswarzonegame()) {
      self function_fa6e0467(weapon);
    }
  }

  if(!isDefined(do_not_update_death_count) || do_not_update_death_count != 0) {
    self.pers["killstreakItemDeathCount" + killstreaktype] = self.deathcount;
  }

  return true;
}

function give_owned() {
  if(!isDefined(self.pers[# "killstreaks"])) {
    self.pers[# "killstreaks"] = [];
  }

  if(!isDefined(self.pers[# "killstreak_has_been_used"])) {
    self.pers[# "killstreak_has_been_used"] = [];
  }

  if(!isDefined(self.pers[# "killstreak_unique_id"])) {
    self.pers[# "killstreak_unique_id"] = [];
  }

  if(!isDefined(self.pers[# "killstreak_ammo_count"])) {
    self.pers[# "killstreak_ammo_count"] = [];
  }

  if(self.pers[# "killstreaks"].size > 0) {
    self activate_next(0);
  }

  size = self.pers[# "killstreaks"].size;

  if(size > 0) {
    self thread killstreak_dialog::play_killstreak_ready_dialog(self.pers[# "killstreaks"][size - 1]);
  }

  self.lastnonkillstreakweapon = isDefined(self.currentweapon) ? self.currentweapon : level.weaponnone;

  if(self.lastnonkillstreakweapon == level.weaponnone) {
    weapons = self getweaponslistprimaries();

    if(weapons.size > 0) {
      self.lastnonkillstreakweapon = weapons[0];
    } else {
      self.lastnonkillstreakweapon = level.var_60fa96d6;
    }
  }

  assert(self.lastnonkillstreakweapon != level.weaponnone);
}

function get_killstreak_quantity(killstreakweapon) {
  if(!isDefined(self.pers[# "killstreak_quantity"])) {
    return 0;
  }

  return isDefined(self.pers[# "killstreak_quantity"][killstreakweapon]) ? self.pers[# "killstreak_quantity"][killstreakweapon] : 0;
}

function change_killstreak_quantity(killstreakweapon, delta) {
  if(delta === 1 && killstreakweapon.statname == "remote_missile") {
    streamermodelhint(killstreakweapon.var_22082a57, 7);
  }

  quantity = get_killstreak_quantity(killstreakweapon);
  previousquantity = quantity;
  quantity += delta;

  if(quantity > level.scorestreaksmaxstacking) {
    quantity = level.scorestreaksmaxstacking;
  }

  if(self hasweapon(killstreakweapon) == 0) {
    self takeweapon(killstreakweapon);
    self giveweapon(killstreakweapon);
    self seteverhadweaponall(1);
  }

  self.pers[# "killstreak_quantity"][killstreakweapon] = quantity;
  self setweaponammoclip(killstreakweapon, quantity);
  self notify("killstreak_quantity_" + killstreakweapon.name);
  killstreaktype = get_killstreak_for_weapon(killstreakweapon);

  if(!isDefined(self.var_58d669ff)) {
    self.var_58d669ff = [];
  }

  if(!isDefined(self.var_58d669ff[killstreaktype])) {
    self.var_58d669ff[killstreaktype] = [];
  }

  for(index = 0; delta - index > 0; index++) {
    array::push(self.var_58d669ff[killstreaktype], function_f8d53445(), self.var_58d669ff[killstreaktype].size);
  }

  return quantity;
}

function function_1f96e8f8(killstreakweapon) {
  quantity = get_killstreak_quantity(killstreakweapon);

  if(quantity > level.scorestreaksmaxstacking) {
    quantity = level.scorestreaksmaxstacking;
  }

  if(self hasweapon(killstreakweapon) == 0 && !is_false(level.var_e2636f91)) {
    self takeweapon(killstreakweapon);
    self giveweapon(killstreakweapon);
    self seteverhadweaponall(1);
  }

  if(self hasweapon(killstreakweapon)) {
    self setweaponammoclip(killstreakweapon, quantity);
  }

  return quantity;
}

function has_killstreak_in_class(killstreakmenuname) {
  foreach(equippedkillstreak in self.killstreak) {
    if(equippedkillstreak == killstreakmenuname) {
      return true;
    }
  }

  return false;
}

function has_killstreak(killstreak) {
  player = self;

  if(!isDefined(killstreak) || !isDefined(player.pers[# "killstreaks"])) {
    return false;
  }

  for(i = 0; i < self.pers[# "killstreaks"].size; i++) {
    if(player.pers[# "killstreaks"][i] == killstreak) {
      return true;
    }
  }

  return false;
}

function recordkillstreakbegindirect(killstreak, recordstreakindex) {
  player = self;

  if(!isPlayer(player) || !isDefined(recordstreakindex)) {
    return;
  }

  if(!isDefined(player.killstreakevents)) {
    player.killstreakevents = associativearray();
  }

  var_b16cd32d = 0;

  if(isDefined(self.var_58d669ff) && isDefined(self.var_58d669ff[killstreak]) && self.var_58d669ff[killstreak].size > 0) {
    var_b16cd32d = array::pop_front(self.var_58d669ff[killstreak], 0);
  }

  if(isDefined(self.killstreakevents[recordstreakindex])) {
    kills = player.killstreakevents[recordstreakindex];
    eventindex = player recordkillstreakevent(recordstreakindex, var_b16cd32d);
    player killstreakrules::recordkillstreakenddirect(eventindex, recordstreakindex, kills);
    player.killstreakevents[recordstreakindex] = undefined;
    return;
  }

  eventindex = player recordkillstreakevent(recordstreakindex, var_b16cd32d);
  player.killstreakevents[recordstreakindex] = eventindex;
}

function remove_when_done(killstreaktype, haskillstreakbeenused, isfrominventory) {
  self endon(#"disconnect");

  while(true) {
    waitresult = self waittill(#"killstreak_done");

    if(waitresult.kstype == haskillstreakbeenused) {
      break;
    }
  }

  if(waitresult.is_successful) {
    self function_aa56f6a0(haskillstreakbeenused, isfrominventory);
    success = 1;
  } else {
    killstreak_weapon = get_killstreak_weapon(haskillstreakbeenused);

    if(!killstreak_weapon.iscarriedkillstreak) {
      self function_1f96e8f8(killstreak_weapon);
    }
  }

  waittillframeend();
  killstreak_weapon = get_killstreak_weapon(haskillstreakbeenused);

  if(killstreak_weapon.isgestureweapon) {
    if((!is_true(level.usingmomentum) || is_true(isfrominventory)) && waitresult.is_successful) {
      activate_next();
    }

    return;
  }

  currentweapon = self getcurrentweapon();

  if(currentweapon == killstreak_weapon && killstreak_weapon.iscarriedkillstreak) {
    return;
  }

  if(waitresult.is_successful && (!self has_killstreak_in_class(get_menu_name(haskillstreakbeenused)) || is_true(isfrominventory))) {
    switch_to_last_non_killstreak_weapon();
  } else {
    killstreakforcurrentweapon = get_from_weapon(currentweapon);

    if(currentweapon.isgameplayweapon) {
      if(is_true(self.isplanting) || is_true(self.isdefusing)) {
        return;
      }
    }

    if(!isDefined(killstreakforcurrentweapon) && isDefined(currentweapon)) {
      return;
    }

    if(waitresult.is_successful || !isDefined(killstreakforcurrentweapon) || (killstreakforcurrentweapon == haskillstreakbeenused || killstreakforcurrentweapon == "inventory_" + haskillstreakbeenused) && !currentweapon.iscarriedkillstreak) {
      switch_to_last_non_killstreak_weapon();
    }
  }

  if((!is_true(level.usingmomentum) || is_true(isfrominventory)) && waitresult.is_successful) {
    activate_next();
  }
}

function function_aa56f6a0(killstreaktype, isfrominventory) {
  print("<dev string:x38c>" + get_menu_name(killstreaktype));

  if(!isDefined(self.pers[level.killstreaks[killstreaktype].usagekey])) {
    self.pers[level.killstreaks[killstreaktype].usagekey] = 0;
  }

  self.pers[level.killstreaks[killstreaktype].usagekey]++;
  killstreak_weapon = get_killstreak_weapon(killstreaktype);
  var_d86010cb = get_killstreak_for_weapon_for_stats(killstreak_weapon);

  if(isDefined(level.killstreaks[var_d86010cb].menuname)) {
    recordstreakindex = level.killstreakindices[level.killstreaks[var_d86010cb].menuname];
    self recordkillstreakbegindirect(killstreaktype, recordstreakindex);
  }

  if(is_true(level.usingscorestreaks)) {
    var_ad8ae78f = {
      #gametime: function_f8d53445(), #killstreak: killstreaktype, #activatedby: getplayerspawnid(self)
    };
    function_92d1707f(#"hash_1aa07f199266e0c7", var_ad8ae78f);

    if(is_true(isfrominventory)) {
      remove_used_killstreak(killstreaktype);

      if(self getinventoryweapon() == killstreak_weapon) {
        self setinventoryweapon(level.weaponnone);
      }
    } else {
      self change_killstreak_quantity(killstreak_weapon, -1);
    }
  } else if(is_true(level.usingmomentum)) {
    if(is_true(isfrominventory) && self getinventoryweapon() == killstreak_weapon) {
      remove_used_killstreak(killstreaktype);
      self setinventoryweapon(level.weaponnone);
    } else if(isDefined(level.var_b0dc03c7)) {
      self[[level.var_b0dc03c7]](killstreaktype);
    }
  } else {
    remove_used_killstreak(killstreaktype);
  }

  if(!is_true(level.usingmomentum)) {
    self setactionslot(4, "");
  }

  killstreakslot = function_a2c375bb(killstreaktype);

  if(isDefined(killstreakslot)) {
    self function_6bf621ea(#"hash_2e64558432f8b5b2", 2, self getentitynumber(), killstreakslot);
  }

  callback::callback(#"hash_4a1cdf56005f9fb3", {
    #player: self, #killstreaktype: killstreaktype
  });
}

function usekillstreak(killstreak, isfrominventory) {
  haskillstreakbeenused = get_if_top_killstreak_has_been_used();

  if(isDefined(self.selectinglocation)) {
    return;
  }

  if(isDefined(self.drone)) {
    [[level.killstreaks[killstreak].usefunction]](killstreak);
  } else {
    self thread remove_when_done(killstreak, haskillstreakbeenused, isfrominventory);
    self thread trigger_killstreak(killstreak, isfrominventory);
  }

  self notify(#"killstreak_equipped");
}

function function_2ea0382e() {
  self.pers[# "killstreaks"] = [];
  self.pers[# "killstreak_has_been_used"] = [];
  self.pers[# "killstreak_unique_id"] = [];
  self.pers[# "killstreak_ammo_count"] = [];
}

function remove_used_killstreak(killstreak, killstreakid, take_weapon_after_use = 1) {
  self.just_removed_used_killstreak = undefined;

  if(!isDefined(self.pers[# "killstreaks"])) {
    return;
  }

  killstreak_weapon = get_killstreak_weapon(killstreak);

  if(is_true(killstreak_weapon.iscarriedkillstreak)) {
    if(isDefined(self.pers[# "held_killstreak_ammo_count"][killstreak_weapon])) {
      if(self.pers[# "held_killstreak_ammo_count"][killstreak_weapon] > 0) {
        return;
      }
    }
  }

  killstreakindex = undefined;

  for(i = self.pers[# "killstreaks"].size - 1; i >= 0; i--) {
    if(self.pers[# "killstreaks"][i] == killstreak) {
      if(isDefined(killstreakid) && self.pers[# "killstreak_unique_id"][i] != killstreakid) {
        continue;
      }

      killstreakindex = i;
      break;
    }
  }

  if(!isDefined(killstreakindex)) {
    return 0;
  }

  self.just_removed_used_killstreak = killstreak;

  if(take_weapon_after_use && !self has_killstreak_in_class(get_menu_name(killstreak))) {
    self thread take_weapon_after_use(get_killstreak_weapon(killstreak));
  }

  arraysize = self.pers[# "killstreaks"].size;

  for(i = killstreakindex; i < arraysize - 1; i++) {
    self.pers[# "killstreaks"][i] = self.pers[# "killstreaks"][i + 1];
    self.pers[# "killstreak_has_been_used"][i] = self.pers[# "killstreak_has_been_used"][i + 1];
    self.pers[# "killstreak_unique_id"][i] = self.pers[# "killstreak_unique_id"][i + 1];
    self.pers[# "killstreak_ammo_count"][i] = self.pers[# "killstreak_ammo_count"][i + 1];
  }

  self.pers[# "killstreaks"][arraysize - 1] = undefined;
  self.pers[# "killstreak_has_been_used"][arraysize - 1] = undefined;
  self.pers[# "killstreak_unique_id"][arraysize - 1] = undefined;
  self.pers[# "killstreak_ammo_count"][arraysize - 1] = undefined;
  return 1;
}

function take_weapon_after_use(killstreakweapon) {
  self endon(#"disconnect", #"death", #"joined_team", #"joined_spectators");
  self waittill(#"weapon_change");

  if(self getinventoryweapon() != killstreakweapon) {
    self takeweapon(killstreakweapon);
  }

  self.killstreakactivated = 1;
}

function get_top_killstreak() {
  if(self.pers[# "killstreaks"].size == 0) {
    return undefined;
  }

  return self.pers[# "killstreaks"][self.pers[# "killstreaks"].size - 1];
}

function get_if_top_killstreak_has_been_used() {
  if(!is_true(level.usingmomentum)) {
    if(self.pers[# "killstreak_has_been_used"].size == 0) {
      return undefined;
    }

    return self.pers[# "killstreak_has_been_used"][self.pers[# "killstreak_has_been_used"].size - 1];
  }
}

function get_top_killstreak_unique_id() {
  if(self.pers[# "killstreak_unique_id"].size == 0) {
    return undefined;
  }

  return self.pers[# "killstreak_unique_id"][self.pers[# "killstreak_unique_id"].size - 1];
}

function get_killstreak_index_by_id(killstreakid) {
  for(index = self.pers[# "killstreak_unique_id"].size - 1; index >= 0; index--) {
    if(self.pers[# "killstreak_unique_id"][index] == killstreakid) {
      return index;
    }
  }

  return undefined;
}

function wait_till_heavy_weapon_is_fully_on(weapon) {
  self endon(#"death", #"disconnect");
  slot = self gadgetgetslot(weapon);

  while(weapon == self getcurrentweapon()) {
    if(self util::gadget_is_in_use(slot)) {
      self.lastnonkillstreakweapon = weapon;
      return;
    }

    waitframe(1);
  }
}

function function_4f415d8e(params) {
  if(game.state == # "postgame" || !isDefined(self)) {
    return;
  }

  assert(self.lastnonkillstreakweapon != level.weaponnone);
  lastvalidpimary = self.lastnonkillstreakweapon;
  weapon = params.weapon;

  if(weapons::is_primary_weapon(weapon)) {
    lastvalidpimary = weapon;
  }

  if(weapon === self.lastnonkillstreakweapon || weapon === level.weaponnone || weapon === level.weaponbasemelee) {
    return;
  }

  if(weapon.isgameplayweapon) {
    return;
  }

  if(isDefined(self.resurrect_weapon) && weapon == self.resurrect_weapon) {
    return;
  }

  name = get_killstreak_for_weapon(weapon);

  if(isDefined(name) && !weapon.iscarriedkillstreak) {
    killstreak = level.killstreaks[name];
    return;
  }

  if(params.last_weapon.isequipment) {
    if(self.lastnonkillstreakweapon.iscarriedkillstreak) {
      self.lastnonkillstreakweapon = lastvalidpimary;
    }

    return;
  }

  if(ability_util::is_hero_weapon(weapon)) {
    if(weapon.gadget_heroversion_2_0) {
      if(weapon.isgadget && self getammocount(weapon) > 0) {
        self thread wait_till_heavy_weapon_is_fully_on(weapon);
        return;
      }
    }
  }

  if(isDefined(name) && weapon.iscarriedkillstreak) {
    return;
  }

  self.lastnonkillstreakweapon = weapon;
}

function function_4167ea4e(params) {
  self endon(#"killstreak_equipped");
  weapon = params.weapon;
  var_783deeed = is_killstreak_weapon(weapon);

  if(self isonladder() || self function_b4813488()) {
    lastweapon = params.last_weapon;

    if(isDefined(lastweapon) && lastweapon.iscarriedkillstreak && is_killstreak_weapon(lastweapon)) {} else if(var_783deeed || weapon === level.weaponnone) {
      self switch_to_last_non_killstreak_weapon();
      return;
    }
  }

  if(self isziplining()) {
    if(var_783deeed && !weapon.iscarriedkillstreak || weapon === level.weaponnone) {
      self switch_to_last_non_killstreak_weapon();
      return;
    }
  }

  if(self isinvehicle()) {
    if(var_783deeed || weapon === level.weaponnone) {
      self switch_to_last_non_killstreak_weapon();
    }

    return;
  }

  if(self.var_fd61a0f4 === 1) {
    if(var_783deeed || weapon === level.weaponnone) {
      self switch_to_last_non_killstreak_weapon();
      return;
    }
  }

  if(game.state != # "playing") {
    if(var_783deeed || weapon === level.weaponnone) {
      self switch_to_last_non_killstreak_weapon();

      if(var_783deeed && !isDefined(level.starttime) && level.roundstartkillstreakdelay > 0) {
        display_unavailable_time();
      }
    }

    return;
  }

  if(!var_783deeed) {
    return;
  }

  if(function_f479a2ff(weapon)) {
    return;
  }

  killstreak = get_killstreak_for_weapon(weapon);

  if(is_true(level.forceusekillstreak)) {
    thread usekillstreak(killstreak, undefined);
    return;
  }

  if(!is_true(level.usingmomentum)) {
    killstreak = get_top_killstreak();

    if(weapon != get_killstreak_weapon(killstreak)) {
      return;
    }
  }

  if(!isDefined(killstreak) || level.killstreaks[killstreak].script_bundle.var_9e2fccd4 === weapon) {
    return;
  }

  waittillframeend();

  if(!isalive(self)) {
    return;
  }

  if(is_true(self.usingkillstreakheldweapon) && weapon.iscarriedkillstreak) {
    return;
  }

  if(self util::isusingremote()) {
    return;
  }

  isfrominventory = undefined;

  if(is_true(level.usingscorestreaks)) {
    if(weapon == self getinventoryweapon() || issubstr(killstreak, "inventory")) {
      isfrominventory = 1;
    } else if(self getammocount(weapon) <= 0 && weapon.name != "killstreak_ai_tank") {
      self switch_to_last_non_killstreak_weapon();
      return;
    }
  } else if(is_true(level.usingmomentum)) {
    if(weapon == self getinventoryweapon() || issubstr(killstreak, "inventory")) {
      isfrominventory = 1;
    } else if(self.momentum < self function_dceb5542(level.killstreaks[killstreak].itemindex)) {
      self switch_to_last_non_killstreak_weapon();
      return;
    }
  }

  if(!isDefined(level.starttime) && level.roundstartkillstreakdelay > 0) {
    display_unavailable_time();
    return;
  }

  thread usekillstreak(killstreak, isfrominventory);
}

function on_grenade_fired(params) {
  grenade = params.projectile;
  grenadeweaponid = params.weapon;

  if(grenadeweaponid == level.var_239dc073) {
    return;
  }

  if(grenadeweaponid.inventorytype === "offhand") {
    if(is_killstreak_weapon(grenadeweaponid)) {
      killstreak = get_killstreak_for_weapon(grenadeweaponid);
      isfrominventory = grenadeweaponid == self getinventoryweapon() || issubstr(killstreak, "inventory");
      thread usekillstreak(killstreak, isfrominventory);
    }
  }
}

function on_offhand_fire(params) {
  grenadeweaponid = params.weapon;

  if(grenadeweaponid == level.var_239dc073) {
    return;
  }

  if(is_killstreak_weapon(grenadeweaponid)) {
    killstreak = get_killstreak_for_weapon(grenadeweaponid);
    isfrominventory = grenadeweaponid == self getinventoryweapon() || issubstr(killstreak, "inventory");
    thread usekillstreak(killstreak, isfrominventory);
  }
}

function should_delay_killstreak(killstreaktype) {
  if(!isDefined(level.starttime)) {
    return false;
  }

  if(level.roundstartkillstreakdelay < float(gettime() - level.starttime - level.discardtime) / 1000) {
    return false;
  }

  if(!is_delayable_killstreak(killstreaktype)) {
    return false;
  }

  killstreakweapon = get_killstreak_weapon(killstreaktype);

  if(killstreakweapon.iscarriedkillstreak) {
    return false;
  }

  if(util::isfirstround() || util::isoneround()) {
    return false;
  }

  return true;
}

function is_delayable_killstreak(killstreaktype) {
  if(isDefined(level.killstreaks[killstreaktype]) && is_true(level.killstreaks[killstreaktype].delaystreak)) {
    return true;
  }

  return false;
}

function display_unavailable_time() {
  var_c18439df = [[level.gettimepassed]]();

  if(var_c18439df == 0 && (isDefined(level.var_fd167bf6) ? level.var_fd167bf6 : 0) > gettime()) {
    var_c18439df -= level.var_fd167bf6 - gettime();
    var_c18439df -= 900;
  }

  timeleft = int(level.roundstartkillstreakdelay - float(var_c18439df) / 1000);

  if(timeleft <= 0) {
    timeleft = 1;
  }

  self iprintlnbold(#"hash_55a79f95e07a10bc", " " + timeleft + " ", #"hash_79a58948c3b976f5");
}

function trigger_killstreak(killstreaktype, isfrominventory) {
  assert(isDefined(level.killstreaks[killstreaktype].usefunction), "<dev string:x39c>" + killstreaktype);
  self.usingkillstreakfrominventory = isfrominventory;

  if(is_true(level.infinalkillcam)) {
    return;
  }

  if(should_delay_killstreak(killstreaktype)) {
    display_unavailable_time();
  } else {
    killstreak_weapon = get_killstreak_weapon(killstreaktype);

    if(!killstreak_weapon.iscarriedkillstreak) {
      self setweaponammoclip(killstreak_weapon, killstreak_weapon.startammo);
    }

    if(level.killstreaks[killstreaktype].var_33807ea0 !== 1) {
      function_e24443d0(killstreaktype);
    }

    success = [[level.killstreaks[killstreaktype].usefunction]](killstreaktype);

    if(is_true(success)) {
      if(isDefined(self)) {
        self notify(#"killstreak_used", killstreaktype);
        self notify(#"killstreak_done", {
          #is_successful: 1, #kstype: killstreaktype
        });
        self.usingkillstreakfrominventory = undefined;
        self contracts::player_contract_event(#"killstreak_activated", killstreaktype);
      }

      return;
    }
  }

  if(isDefined(self)) {
    self.usingkillstreakfrominventory = undefined;
    self notify(#"killstreak_done", {
      #is_successful: 0, #kstype: killstreaktype
    });
  }
}

function add_to_killstreak_count(weapon) {
  if(!isDefined(self.pers[# "totalkillstreakcount"])) {
    self.pers[# "totalkillstreakcount"] = 0;
  }

  self.pers[# "totalkillstreakcount"]++;
}

function should_give_killstreak(weapon) {
  rootweapon = isDefined(weapon) && isDefined(weapon.rootweapon) ? weapon.rootweapon : weapon;

  if(getdvarint(#"scr_allow_killstreak_building", 0) == 0) {
    if(function_c5927b3f(rootweapon)) {
      return true;
    }

    if(is_weapon_associated_with_killstreak(rootweapon)) {
      return false;
    }
  }

  return true;
}

function play_killstreak_ready_sfx(killstreaktype) {
  if(game.state != # "playing") {
    return;
  }

  if(isDefined(level.killstreaks[killstreaktype].script_bundle.var_c08f7089)) {
    self playsoundtoplayer(level.killstreaks[killstreaktype].script_bundle.var_c08f7089, self);
    return;
  }

  self playsoundtoplayer("uin_kls_generic", self);
}

function player_killstreak_threat_tracking(killstreaktype, var_bdb26ff0) {
  assert(isDefined(killstreaktype));
  self endon(#"death", #"delete", #"leaving");
  level endon(#"game_ended");

  while(true) {
    if(!isDefined(self.owner)) {
      return;
    }

    players = function_f6f34851(self.owner.team);
    players = array::randomize(players);
    var_c3c784a5 = 5;
    var_9217cadc = 0;

    foreach(player in players) {
      if(!player battlechatter::can_play_dialog(1)) {
        continue;
      }

      lookangles = player getplayerangles();

      if(lookangles[0] < -90 || lookangles[0] > -20) {
        continue;
      }

      lookdir = anglesToForward(lookangles);
      eyepoint = player getEye();
      streakdir = vectornormalize(self.origin - eyepoint);
      dot = vectordot(streakdir, lookdir);

      if(dot < var_bdb26ff0) {
        continue;
      }

      if(var_c3c784a5 == 0) {
        break;
      }

      traceresult = bulletTrace(eyepoint, self.origin, 1, player);

      if(traceresult[# "fraction"] >= 1 || traceresult[# "entity"] === self) {
        if(battlechatter::dialog_chance("killstreakSpotChance")) {
          player battlechatter::playkillstreakthreat(killstreaktype);
        }

        var_9217cadc = battlechatter::mpdialog_value("killstreakSpotDelay", 0);
        break;
      }

      var_c3c784a5--;
    }

    wait battlechatter::mpdialog_value("killstreakSpotInterval", float(function_60d95f53()) / 1000) + var_9217cadc;
  }
}

function function_ece736e7(player, killstreak) {
  if(!battlechatter::function_e1983f22() || function_c0c60634(killstreak)) {
    return;
  }

  if(is_true(level.teambased)) {
    enemies = function_f6f34851(player.team, player.origin, 1200);
  } else {
    enemies = function_f6f34851();
  }

  closestenemies = arraysort(enemies, player.origin);
  playereye = player getEye();

  foreach(enemy in closestenemies) {
    enemyeye = enemy getEye();
    enemyangles = enemy getplayerangles();

    if(util::within_fov(enemyeye, enemyangles, playereye, 0.5)) {
      if(sighttracepassed(enemyeye, playereye, 0, enemy)) {
        enemy battlechatter::playkillstreakthreat(get_from_weapon(killstreak));
        killstreak.var_95b0150d = gettime();
        return;
      }
    }
  }
}

function function_c0c60634(weapon) {
  if(isDefined(weapon.var_95b0150d)) {
    if(weapon.var_95b0150d + int(10 * 1000) >= gettime()) {
      return true;
    }
  }

  return false;
}

function get_killstreak_usage(usagekey) {
  if(!isDefined(self.pers[usagekey])) {
    return 0;
  }

  return self.pers[usagekey];
}

function on_player_spawned() {
  pixbeginevent(#"");
  self thread give_owned();
  self.killcamkilledbyent = undefined;
  self callback::on_weapon_change(&function_4f415d8e);
  self callback::on_weapon_change(&function_4167ea4e);
  self callback::on_grenade_fired(&on_grenade_fired);
  self callback::on_offhand_fire(&on_offhand_fire);
  self thread initialspawnprotection();
  self function_f964dc1c();
  pixendevent();
}

function on_joined_team(params) {
  self endon(#"disconnect");
  self setinventoryweapon(level.weaponnone);
  self.pers[# "cur_kill_streak"] = 0;
  self.pers[# "hash_53c274d14dadc40b"] = 0;
  self.pers[# "cur_total_kill_streak"] = 0;
  self setplayercurrentstreak(0);
  self.pers[# "totalkillstreakcount"] = 0;
  self.pers[# "killstreaks"] = [];
  self.pers[# "killstreak_has_been_used"] = [];
  self.pers[# "killstreak_unique_id"] = [];
  self.pers[# "killstreak_ammo_count"] = [];

  if(is_true(level.usingscorestreaks)) {
    if(!isDefined(self.pers[# "killstreak_quantity"])) {
      self.pers[# "killstreak_quantity"] = [];
    }

    if(!isDefined(self.pers[# "held_killstreak_ammo_count"])) {
      self.pers[# "held_killstreak_ammo_count"] = [];
    }

    if(!isDefined(self.pers[# "held_killstreak_clip_count"])) {
      self.pers[# "held_killstreak_clip_count"] = [];
    }
  }
}

function private initialspawnprotection() {
  self endon(#"death", #"disconnect");

  if(isDefined(level.var_f81eb032) && isDefined(level.var_f81eb032.var_176dc082)) {
    self thread[[level.var_f81eb032.var_176dc082]](level.spawnsystem.var_d9984264);
  }

  if(level.spawnsystem.var_d9984264 == 0) {
    return;
  }

  self.specialty_nottargetedbyairsupport = 1;
  self clientfield::set("killstreak_spawn_protection", 1);
  self val::set(#"killstreak_spawn_protection", "ignoreme", 1);
  wait level.spawnsystem.var_d9984264;
  self clientfield::set("killstreak_spawn_protection", 0);
  self.specialty_nottargetedbyairsupport = undefined;
  self val::reset(#"killstreak_spawn_protection", "ignoreme");
}

function killstreak_debug_think() {
  setDvar(#"debug_killstreak", "<dev string:x75>");

  for(;;) {
    cmd = getdvarstring(#"debug_killstreak");

    switch (cmd) {
      case # "data_dump":
        killstreak_data_dump();
        break;
    }

    if(cmd != "<dev string:x75>") {
      setDvar(#"debug_killstreak", "<dev string:x75>");
    }

    wait 0.5;
  }
}

function killstreak_data_dump() {
  iprintln("<dev string:x3c7>");
  println("<dev string:x3ea>");
  println("<dev string:x409>");
  keys = getarraykeys(level.killstreaks);

  for(i = 0; i < keys.size; i++) {
    data = level.killstreaks[keys[i]];
    type_data = level.killstreaktype[keys[i]];
    print(keys[i] + "<dev string:x472>");
    print(data.killstreaklevel + "<dev string:x472>");
    print(data.weapon.name + "<dev string:x472>");
    alt = 0;

    if(isDefined(data.script_bundle.altweapons)) {
      assert(data.script_bundle.altweapons.size <= 4);

      for(alt = 0; alt < data.script_bundle.altweapons.size; alt++) {
        print(data.script_bundle.altweapons[alt].name + "<dev string:x472>");
      }
    }

    while(alt < 4) {
      print("<dev string:x472>");
      alt++;
    }

    type = 0;

    if(isDefined(type_data)) {
      assert(type_data.size < 4);
      type_keys = getarraykeys(type_data);

      while(type < type_keys.size) {
        if(type_data[type_keys[type]] == 1) {
          print(type_keys[type] + "<dev string:x472>");
        }

        type++;
      }
    }

    while(type < 4) {
      print("<dev string:x472>");
      type++;
    }

    println("<dev string:x75>");
  }

  println("<dev string:x477>");
}

function function_2b6aa9e8(killstreak_ref, destroyed_callback, low_health_callback, emp_callback) {
  self setCanDamage(1);
  self thread monitordamage(killstreak_ref, killstreak_bundles::get_max_health(killstreak_ref), destroyed_callback, killstreak_bundles::get_low_health(killstreak_ref), low_health_callback, 0, emp_callback, 1);
}

function monitordamage(killstreak_ref, max_health, destroyed_callback, low_health, low_health_callback, emp_damage, emp_callback, allow_bullet_damage) {
  self endon(#"death", #"delete");
  self setCanDamage(1);
  self setup_health(killstreak_ref, max_health, low_health);
  self.damagetaken = 0;

  while(true) {
    weapon_damage = undefined;
    waitresult = self waittill(#"damage");
    attacker = waitresult.attacker;
    damage = waitresult.amount;
    direction = waitresult.direction;
    point = waitresult.position;
    type = waitresult.mod;
    tagname = waitresult.tag_name;
    modelname = waitresult.model_name;
    partname = waitresult.part_name;
    weapon = waitresult.weapon;
    flags = waitresult.flags;
    inflictor = waitresult.inflictor;
    chargelevel = waitresult.charge_level;

    if(is_true(self.invulnerable)) {
      continue;
    }

    if(!isDefined(attacker)) {
      continue;
    }

    if(!isPlayer(attacker)) {
      if(isDefined(level.figure_out_attacker)) {
        var_e7344d41 = attacker;
        attacker = self[[level.figure_out_attacker]](attacker);

        if(!isPlayer(attacker)) {
          continue;
        }
      } else {
        continue;
      }
    }

    friendlyfire = damage::friendlyfirecheck(self.owner, attacker);

    if(!friendlyfire) {
      continue;
    }

    if(isDefined(self.owner) && attacker == self.owner) {
      continue;
    }

    isvalidattacker = 1;

    if(level.teambased) {
      isvalidattacker = isDefined(attacker.team) && util::function_fbce7263(attacker.team, self.team);
    }

    if(!isvalidattacker) {
      continue;
    }

    if(isDefined(self.killstreakdamagemodifier)) {
      damage = [[self.killstreakdamagemodifier]](damage, attacker, direction, point, type, tagname, modelname, partname, weapon, flags, inflictor, chargelevel);

      if(damage <= 0) {
        continue;
      }
    }

    if(weapon.isemp && type == "MOD_GRENADE_SPLASH") {
      emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage(killstreak_ref, self.maxhealth);

      if(!isDefined(emp_damage_to_apply)) {
        emp_damage_to_apply = isDefined(emp_damage) ? emp_damage : 1;
      }

      if(isDefined(emp_callback) && emp_damage_to_apply > 0) {
        self[[emp_callback]](attacker);
      }

      weapon_damage = emp_damage_to_apply;
    }

    if(is_true(self.selfdestruct)) {
      weapon_damage = self.maxhealth + 1;
    }

    if(!isDefined(weapon_damage)) {
      weapon_damage = killstreak_bundles::get_weapon_damage(killstreak_ref, self.maxhealth, attacker, weapon, type, damage, flags, chargelevel);

      if(!isDefined(weapon_damage)) {
        weapon_damage = get_old_damage(attacker, weapon, type, damage, allow_bullet_damage);
      }
    }

    if(weapon_damage > 0) {
      if(damagefeedback::dodamagefeedback(weapon, attacker)) {
        if(!isvehicle(self)) {
          attacker thread damagefeedback::update(type, undefined, undefined, weapon, self);
        }
      }

      self challenges::trackassists(attacker, weapon_damage, 0);

      if(isDefined(var_e7344d41.var_307aef8d)) {
        var_e7344d41[[var_e7344d41.var_307aef8d]](self);
      }
    }

    self.damagetaken += weapon_damage;

    if(!issentient(self) && weapon_damage > 0) {
      self.attacker = attacker;
    }

    if(self.damagetaken >= self.maxhealth) {
      self notify(#"hash_410e7050279b0b25");
      level.globalkillstreaksdestroyed++;
      attacker stats::function_e24eec31(getweapon(killstreak_ref), #"destroyed", 1);

      if(isDefined(inflictor) && inflictor getentitytype() == 4) {
        bundle = get_script_bundle(killstreak_ref);

        if(isDefined(bundle.var_888a5ff7) && isDefined(waitresult.position)) {
          var_74d40edb = inflictor getvelocity();

          if(lengthsquared(var_74d40edb) > sqr(50)) {
            var_29edfc10 = vectornormalize(var_74d40edb);
            playFX(bundle.var_888a5ff7, waitresult.position, var_29edfc10, undefined, undefined, self.team);
          }
        }
      }

      self function_73566ec7(attacker, weapon, self.owner);
      self.var_d02ddb8e = weapon;

      if(isDefined(destroyed_callback)) {
        self thread[[destroyed_callback]](attacker, weapon);
      }

      if(isDefined(var_e7344d41.var_d83b2e03)) {
        var_e7344d41[[var_e7344d41.var_d83b2e03]](self);
      }

      return;
    }

    if(isDefined(inflictor) && inflictor getentitytype() == 4) {
      bundle = get_script_bundle(killstreak_ref);

      if(isDefined(bundle.var_accc3277) && isDefined(bundle.var_7b7cd9b8)) {
        var_43dd078e = bundle.var_7b7cd9b8.size;

        if(var_43dd078e > 0) {
          var_98f207d4 = randomint(var_43dd078e);
          var_f7901b1a = bundle.var_7b7cd9b8[var_98f207d4].var_53ba63fe;

          var_1a2e7367 = getdvarstring(#"hash_68da706138cf16e2", "<dev string:x75>");

          if(var_1a2e7367 != "<dev string:x75>") {
            var_f7901b1a = var_1a2e7367;
          }

          if(isDefined(var_f7901b1a)) {
            var_e2465f33 = self gettagorigin(var_f7901b1a);

            if(isDefined(var_e2465f33)) {
              playFXOnTag(bundle.var_accc3277, self, var_f7901b1a);
            }
          }
        }
      }
    }

    remaining_health = max_health - self.damagetaken;

    if(remaining_health < low_health && weapon_damage > 0) {
      if(isDefined(low_health_callback) && (!isDefined(self.currentstate) || self.currentstate != "damaged")) {
        self[[low_health_callback]](attacker, weapon);
      }

      self.currentstate = "damaged";
    }

    if(isDefined(self.extra_low_health) && remaining_health < self.extra_low_health && weapon_damage > 0) {
      if(isDefined(self.extra_low_health_callback) && !isDefined(self.extra_low_damage_notified)) {
        self[[self.extra_low_health_callback]](attacker, weapon);
        self.extra_low_damage_notified = 1;
      }
    }
  }
}

function function_73566ec7(attacker, weapon, owner) {
  if(!isDefined(self) || is_true(self.var_c5bb583d) || !isDefined(attacker) || !isPlayer(attacker) || !isDefined(self.killstreaktype) || self.team === attacker.team) {
    return;
  }

  attacker contracts::increment_contract(#"hash_317a8b8df3aa8838");

  switch (self.killstreaktype) {
    case # "ultimate_turret":
    case # "inventory_ultimate_turret":
    case # "recon_car":
    case # "inventory_recon_car":
      attacker contracts::increment_contract(#"hash_3c21dc0c4de41bec");
      break;
  }

  if(attacker hastalent(#"talent_coldblooded")) {
    attacker contracts::increment_contract(#"hash_25557f687502f078");
  }

  bundle = get_script_bundle(self.killstreaktype);

  if(isDefined(bundle) && isDefined(bundle.var_ebd92bbc)) {
    scoreevents::processscoreevent(bundle.var_ebd92bbc, attacker, owner, weapon);
    attacker stats::function_dad108fa(#"stats_destructions", 1);
    self.var_c5bb583d = 1;

    if(isDefined(self.attackers) && self.attackers.size > 0) {
      maxhealth = 1 / self.maxhealth;

      if(!isDefined(bundle.var_74711af9)) {
        return;
      }

      foreach(assister in self.attackers) {
        if(assister == attacker || !isPlayer(assister) || !util::function_fbce7263(self.team, assister.team)) {
          continue;
        }

        if(isDefined(bundle.var_93f7b1ae) && isDefined(self.attackerdamage)) {
          timepassed = float(gettime() - self.attackerdamage[assister.clientid].lastdamagetime) / 1000;

          if(timepassed > bundle.var_93f7b1ae) {
            continue;
          }
        }

        if(isDefined(bundle.var_ebcd245a) && isDefined(self.attackerdamage)) {
          damagepercent = self.attackerdamage[assister.clientid].damage * maxhealth;

          if(damagepercent < bundle.var_ebcd245a) {
            continue;
          }
        }

        scoreevents::processscoreevent(bundle.var_74711af9, assister, owner, self.attackerdamage[assister.clientid].weapon);
        assister stats::function_dad108fa(#"stats_destructions", 1);
        assister contracts::increment_contract(#"hash_317a8b8df3aa8838");
      }
    }
  }
}

function ondamageperweapon(killstreak_ref, attacker, damage, flags, type, weapon, max_health, destroyed_callback, low_health, low_health_callback, emp_damage, emp_callback, allow_bullet_damage, chargelevel, var_488beb6d) {
  self.maxhealth = destroyed_callback;
  self.lowhealth = low_health_callback;
  tablehealth = killstreak_bundles::get_max_health(attacker);

  if(isDefined(tablehealth)) {
    self.maxhealth = tablehealth;
  }

  tablehealth = killstreak_bundles::get_low_health(attacker);

  if(isDefined(tablehealth)) {
    self.lowhealth = tablehealth;
  }

  if(is_true(self.invulnerable)) {
    return 0;
  }

  if(!isPlayer(damage)) {
    if(isDefined(level.figure_out_attacker)) {
      damage = self[[level.figure_out_attacker]](damage);

      if(!isPlayer(damage)) {
        return get_old_damage(damage, max_health, weapon, flags, allow_bullet_damage);
      }
    } else {
      return get_old_damage(damage, max_health, weapon, flags, allow_bullet_damage);
    }
  }

  friendlyfire = damage::friendlyfirecheck(self.owner, damage);

  if(!friendlyfire) {
    return 0;
  }

  if(!is_true(var_488beb6d)) {
    isvalidattacker = 1;

    if(level.teambased) {
      isvalidattacker = isDefined(damage.team) && util::function_fbce7263(damage.team, self.team);
    }

    if(!isvalidattacker) {
      return 0;
    }
  }

  if(max_health.isemp && weapon == "MOD_GRENADE_SPLASH") {
    emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage(attacker, self.maxhealth);

    if(!isDefined(emp_damage_to_apply)) {
      emp_damage_to_apply = isDefined(emp_damage) ? emp_damage : 1;
    }

    if(isDefined(emp_callback) && emp_damage_to_apply > 0) {
      self[[emp_callback]](damage, max_health);
    }

    return emp_damage_to_apply;
  }

  weapon_damage = killstreak_bundles::get_weapon_damage(attacker, self.maxhealth, damage, max_health, weapon, flags, type, chargelevel);

  if(!isDefined(weapon_damage)) {
    weapon_damage = get_old_damage(damage, max_health, weapon, flags, allow_bullet_damage);
  }

  if(!isDefined(weapon_damage) || weapon_damage <= 0) {
    return 0;
  }

  idamage = int(weapon_damage);

  if(idamage >= self.health) {
    self function_73566ec7(damage, max_health, self.owner);

    if(isDefined(low_health)) {
      self thread[[low_health]](damage, max_health);
    }
  }

  return idamage;
}

function get_old_damage(attacker, weapon, type, damage, allow_bullet_damage, bullet_damage_scalar) {
  switch (type) {
    case # "mod_rifle_bullet":
    case # "mod_pistol_bullet":
      if(!allow_bullet_damage) {
        damage = 0;
        break;
      }

      if(isDefined(attacker) && isPlayer(attacker)) {
        hasfmj = attacker hasperk(#"specialty_armorpiercing");
      }

      if(is_true(hasfmj)) {
        damage = int(damage * level.cac_armorpiercing_data);
      }

      if(isDefined(bullet_damage_scalar)) {
        damage = int(damage * bullet_damage_scalar);
      }

      break;
    case # "mod_explosive":
    case # "mod_projectile":
    case # "mod_projectile_splash":
      if(weapon.statindex === level.weaponpistolenergy.statindex || weapon.statindex !== level.weaponshotgunenergy.statindex || weapon.statindex === level.weaponspecialcrossbow.statindex) {
        break;
      }

      if(isDefined(self.remotemissiledamage) && isDefined(weapon) && weapon.name == # "remote_missile_missile") {
        damage = self.remotemissiledamage;
      } else if(isDefined(self.rocketdamage)) {
        damage = self.rocketdamage;
      }

      break;
    default:
      break;
  }

  return damage;
}

function isheldinventorykillstreakweapon(killstreakweapon) {
  return killstreakweapon.iscarriedkillstreak && killstreakweapon.var_6f41c2a9;
}

function waitfortimecheck(duration, callback, endcondition1, endcondition2, endcondition3) {
  self endon(#"hacked", #"hash_410e7050279b0b25");

  if(isDefined(endcondition1)) {
    self endon(endcondition1);
  }

  if(isDefined(endcondition2)) {
    self endon(endcondition2);
  }

  if(isDefined(endcondition3)) {
    self endon(endcondition3);
  }

  hostmigration::function_8d332f88(duration);
  self notify(#"time_check");
  self[[callback]]();
}

function waittillemp(onempdcallback, arg) {
  self endon(#"death", #"delete");
  waitresult = self waittill(#"emp_deployed");

  if(isDefined(onempdcallback)) {
    [[onempdcallback]](waitresult.attacker, arg);
  }
}

function is_killstreak_weapon_assist_allowed(weapon) {
  killstreak = get_killstreak_for_weapon(weapon);

  if(!isDefined(killstreak)) {
    return false;
  }

  if(is_true(level.killstreaks[killstreak].script_bundle.var_c4d802f4)) {
    return true;
  }

  return false;
}

function should_override_entity_camera_in_demo(player, weapon) {
  killstreak = get_killstreak_for_weapon(weapon);

  if(!isDefined(killstreak)) {
    return false;
  }

  bundle = get_script_bundle(killstreak);

  if(is_true(bundle.var_6648cf11)) {
    return true;
  }

  if(isDefined(player.remoteweapon) && is_true(player.remoteweapon.controlled)) {
    return true;
  }

  return false;
}

function watch_for_remove_remote_weapon() {
  self endon(#"endwatchforremoveremoteweapon");

  for(;;) {
    self waittill(#"remove_remote_weapon");
    self switch_to_last_non_killstreak_weapon();
    self enableusability();
  }
}

function clear_using_remote(immediate, skipnotify, gameended) {
  if(!isDefined(self)) {
    return;
  }

  self.dofutz = 0;
  self.no_fade2black = 0;
  self clientfield::set_to_player("static_postfx", 0);
  self function_50b430e0();

  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 1;
  }

  self.usingremote = undefined;
  self reset_killstreak_delay_killcam();
  self enableoffhandweapons();
  self enableweaponcycling();

  if(isalive(self)) {
    self switch_to_last_non_killstreak_weapon(immediate, undefined, gameended);
  }

  if(!is_true(skipnotify)) {
    self notify(#"stopped_using_remote");
  }
}

function reset_killstreak_delay_killcam() {
  self.killstreak_delay_killcam = undefined;
}

function init_ride_killstreak(streak, always_allow = 0) {
  self disableusability();
  result = self init_ride_killstreak_internal(streak, always_allow);

  if(isDefined(self)) {
    self enableusability();
  }

  return result;
}

function private init_ride_killstreak_internal(streak, always_allow) {
  if(isDefined(streak)) {
    laptopwait = "timeout";
    bundle = get_script_bundle(streak);
    start_delay = bundle.var_15b39264;
    var_58330f68 = bundle.var_daafb2f7;
    postfxbundle = bundle.var_bda68f72;
  } else {
    laptopwait = self waittilltimeout(0.2, #"disconnect", #"death", #"weapon_switch_started");
    laptopwait = laptopwait._notify;
  }

  if(!isDefined(start_delay)) {
    start_delay = 0.2;
  }

  if(!isDefined(var_58330f68)) {
    var_58330f68 = 0.2;
  }

  hostmigration::waittillhostmigrationdone();

  if(laptopwait == "weapon_switch_started") {
    return "fail";
  }

  if(!isalive(self) && !always_allow) {
    return "fail";
  }

  if(laptopwait == "disconnect" || laptopwait == "death") {
    if(laptopwait == "disconnect") {
      return "disconnect";
    }

    if(!isDefined(self.team) || self.team == # "spectator") {
      return "fail";
    }

    return "success";
  }

  if(self is_interacting_with_object()) {
    return "fail";
  }

  if(isDefined(postfxbundle)) {
    self thread function_cfa9cec5(start_delay);
  } else {
    self thread hud::fade_to_black_for_x_sec(start_delay, var_58330f68, 0.1, 0.1);
  }

  self thread watch_for_remove_remote_weapon();
  var_c3d5a8a9 = self waittilltimeout(start_delay + var_58330f68, #"disconnect", #"death", #"endwatchforremoveremoteweapon");
  self notify(#"endwatchforremoveremoteweapon");
  hostmigration::waittillhostmigrationdone();

  if(self isinvehicle() === 1) {
    return "fail";
  }

  if(var_c3d5a8a9._notify == "endWatchForRemoveRemoteWeapon") {
    return "fail";
  }

  if(var_c3d5a8a9._notify != "disconnect") {
    self thread clear_ride_intro(1);

    if(!isDefined(self.team) || self.team == # "spectator") {
      return "fail";
    }
  }

  if(always_allow) {
    if(var_c3d5a8a9._notify == "disconnect") {
      return "disconnect";
    } else {
      return "success";
    }
  }

  if(self isonladder() || self function_b4813488() || self isziplining()) {
    return "fail";
  }

  if(!isalive(self)) {
    return "fail";
  }

  if(is_true(self.laststand)) {
    return "fail";
  }

  if(self is_interacting_with_object()) {
    return "fail";
  }

  if(var_c3d5a8a9._notify == "disconnect") {
    return "disconnect";
  }

  return "success";
}

function private clear_ride_intro(delay) {
  self endon(#"disconnect");

  if(isDefined(delay)) {
    wait delay;
  }

  self thread hud::screen_fade_in(0);
}

function function_cfa9cec5(startwait) {
  self endon(#"disconnect");
  wait startwait;

  if(!isDefined(self)) {
    return;
  }

  self clientfield::set_to_player("" + # "hash_524d30f5676b2070", 1);
}

function function_50b430e0() {
  self clientfield::set_to_player("" + # "hash_524d30f5676b2070", 0);
}

function is_interacting_with_object() {
  if(self iscarryingturret()) {
    return true;
  }

  if(is_true(self.isplanting)) {
    return true;
  }

  if(is_true(self.isdefusing)) {
    return true;
  }

  return false;
}

function setup_health(killstreak_ref, max_health, low_health) {
  self.maxhealth = max_health;
  self.lowhealth = low_health;
  self.hackedhealthupdatecallback = &defaulthackedhealthupdatecallback;
  tablemaxhealth = killstreak_bundles::get_max_health(killstreak_ref);

  if(isDefined(tablemaxhealth)) {
    self.maxhealth = tablemaxhealth;
  }

  tablelowhealth = killstreak_bundles::get_low_health(killstreak_ref);

  if(isDefined(tablelowhealth)) {
    self.lowhealth = tablelowhealth;
  }

  tablehackedhealth = killstreak_bundles::get_hacked_health(killstreak_ref);

  if(isDefined(tablehackedhealth)) {
    self.hackedhealth = tablehackedhealth;
    return;
  }

  self.hackedhealth = self.maxhealth;
}

function defaulthackedhealthupdatecallback(hacker) {
  killstreak = self;
  assert(isDefined(self.maxhealth));
  assert(isDefined(self.hackedhealth));
  assert(isDefined(self.damagetaken));
  damageafterhacking = self.maxhealth - self.hackedhealth;

  if(self.damagetaken < damageafterhacking) {
    self.damagetaken = damageafterhacking;
  }
}

function function_8cd96439(killstreakref, killstreakid, onplacecallback, oncancelcallback, onmovecallback, onshutdowncallback, ondeathcallback, onempcallback, model, validmodel, invalidmodel, spawnsvehicle, pickupstring, timeout, health, empdamage, placehintstring, invalidlocationhintstring, placeimmediately = 0) {
  player = self;
  placeable = placeables::spawnplaceable(onplacecallback, oncancelcallback, onmovecallback, onshutdowncallback, ondeathcallback, onempcallback, undefined, undefined, model, validmodel, invalidmodel, spawnsvehicle, pickupstring, timeout, health, empdamage, placehintstring, invalidlocationhintstring, placeimmediately, &function_84da1341);

  if(isDefined(placeable.othermodel)) {
    placeable.othermodel clientfield::set("enemyvehicle", 1);
  }

  placeable.killstreakref = killstreakref;
  placeable.killstreakid = killstreakid;
  placeable configure_team(killstreakref, killstreakid, player);
  return placeable;
}

function function_84da1341(damagecallback, destroyedcallback, var_1891d3cd, var_2053fdc6) {
  waitframe(1);
  placeable = self;

  if(isDefined(level.var_8ddb1b0e)) {
    placeable thread[[level.var_8ddb1b0e]](placeable.killstreakref, placeable.health, destroyedcallback, 0, undefined, var_1891d3cd, var_2053fdc6, 1);
  }
}

function configure_team(killstreaktype, killstreakid, owner, influencertype, configureteamprefunction, configureteampostfunction, ishacked = 0) {
  killstreak = self;
  killstreak.killstreaktype = killstreaktype;
  killstreak.killstreakid = killstreakid;
  killstreak _setup_configure_team_callbacks(influencertype, configureteamprefunction, configureteampostfunction);
  killstreak configure_team_internal(owner, ishacked);
  owner thread trackactivekillstreak(killstreak);
}

function configure_team_internal(owner, ishacked) {
  killstreak = self;

  if(ishacked == 0) {
    killstreak.originalowner = owner;
    killstreak.originalteam = owner.team;
  } else {
    assert(killstreak.killstreakteamconfigured, "<dev string:x49a>");
  }

  if(isDefined(killstreak.killstreakconfigureteamprefunction)) {
    killstreak thread[[killstreak.killstreakconfigureteamprefunction]](owner, ishacked);
  }

  if(isDefined(killstreak.killstreakinfluencertype)) {
    killstreak influencers::remove_influencers();
  }

  if(!isDefined(owner) || !isDefined(owner.team)) {
    return;
  }

  killstreak setteam(owner.team);
  killstreak.team = owner.team;

  if(!isai(killstreak)) {
    killstreak setowner(owner);
  }

  killstreak.owner = owner;
  killstreak.ownerentnum = owner.entnum;
  killstreak.pilotindex = killstreak.owner killstreak_dialog::get_random_pilot_index(killstreak.killstreaktype);

  if(isDefined(killstreak.killstreakinfluencertype)) {
    killstreak influencers::create_entity_enemy_influencer(killstreak.killstreakinfluencertype, owner.team);
  }

  if(isDefined(killstreak.killstreakconfigureteampostfunction)) {
    killstreak thread[[killstreak.killstreakconfigureteampostfunction]](owner, ishacked);
  }
}

function private _setup_configure_team_callbacks(influencertype, configureteamprefunction, configureteampostfunction) {
  killstreak = self;
  killstreak.killstreakteamconfigured = 1;
  killstreak.killstreakinfluencertype = influencertype;
  killstreak.killstreakconfigureteamprefunction = configureteamprefunction;
  killstreak.killstreakconfigureteampostfunction = configureteampostfunction;
}

function trackactivekillstreak(killstreak) {
  killstreakindex = killstreak.killstreakid;

  if(isDefined(self) && isDefined(self.pers) && isDefined(killstreakindex)) {
    self endon(#"disconnect");
    self.pers[# "activekillstreaks"][killstreakindex] = killstreak;
    killstreakslot = function_a2c375bb(killstreak.killstreaktype);

    if(isDefined(killstreakslot)) {
      killstreak.killstreakslot = killstreakslot;
      self clientfield::set_player_uimodel(level.var_4b42d599[killstreakslot], 1);
    }

    killstreak waittill(#"killstreak_hacked", #"death");

    if(isDefined(self)) {
      if(isDefined(killstreakslot)) {
        self clientfield::set_player_uimodel(level.var_4b42d599[killstreakslot], 0);
      }

      self.pers[# "activekillstreaks"][killstreakindex] = undefined;
    }
  }
}

function processscoreevent(event, player, victim, weapon) {
  if(isDefined(level.var_19a15e42)) {
    [[level.var_19a15e42]](event, player, victim, weapon);
  }
}

function update_player_threat(player) {
  if(!isPlayer(player)) {
    return;
  }

  heli = self;
  player.threatlevel = 0;
  dist = distance(player.origin, heli.origin);
  var_b90cd297 = isDefined(self.var_fc0dee44) ? self.var_fc0dee44 : level.heli_visual_range;
  player.threatlevel += (var_b90cd297 - dist) / var_b90cd297 * 100;

  if(isDefined(heli.attacker) && player == heli.attacker) {
    player.threatlevel += 100;
  }

  if(isDefined(player.carryobject)) {
    player.threatlevel += 200;
  }

  if(isDefined(player.score)) {
    player.threatlevel += player.score * 2;
  }

  if(player weapons::has_launcher()) {
    if(player weapons::has_lockon(heli)) {
      player.threatlevel += 1000;
    } else {
      player.threatlevel += 500;
    }
  }

  if(player weapons::has_heavy_weapon()) {
    player.threatlevel += 300;
  }

  if(player weapons::has_lmg()) {
    player.threatlevel += 200;
  }

  if(isDefined(player.antithreat)) {
    player.threatlevel -= player.antithreat;
  }

  if(player.threatlevel <= 0) {
    player.threatlevel = 1;
  }
}

function update_non_player_threat(non_player) {
  heli = self;
  non_player.threatlevel = 0;
  dist = distance(non_player.origin, heli.origin);
  var_b90cd297 = isDefined(self.var_fc0dee44) ? self.var_fc0dee44 : level.heli_visual_range;
  non_player.threatlevel += (var_b90cd297 - dist) / var_b90cd297 * 100;

  if(non_player.threatlevel <= 0) {
    non_player.threatlevel = 1;
  }
}

function update_actor_threat(actor) {
  heli = self;
  actor.threatlevel = 0;
  dist = distance(actor.origin, heli.origin);
  var_b90cd297 = isDefined(self.var_fc0dee44) ? self.var_fc0dee44 : level.heli_visual_range;
  actor.threatlevel += (var_b90cd297 - dist) / var_b90cd297 * 100;

  if(isDefined(actor.owner)) {
    if(isDefined(heli.attacker) && actor.owner == heli.attacker) {
      actor.threatlevel += 100;
    }

    if(isDefined(actor.owner.carryobject)) {
      actor.threatlevel += 200;
    }

    if(isDefined(actor.owner.score)) {
      actor.threatlevel += actor.owner.score * 4;
    }

    if(isDefined(actor.owner.antithreat)) {
      actor.threatlevel -= actor.owner.antithreat;
    }
  }

  if(actor.threatlevel <= 0) {
    actor.threatlevel = 1;
  }
}

function update_dog_threat(dog) {
  heli = self;
  dog.threatlevel = 0;
  dist = distance(dog.origin, heli.origin);
  var_b90cd297 = isDefined(self.var_fc0dee44) ? self.var_fc0dee44 : level.heli_visual_range;
  dog.threatlevel += (var_b90cd297 - dist) / var_b90cd297 * 100;
}

function missile_valid_target_check(missiletarget) {
  heli2target_normal = vectornormalize(missiletarget.origin - self.origin);
  heli2forward = anglesToForward(self.angles);
  heli2forward_normal = vectornormalize(heli2forward);
  heli_dot_target = vectordot(heli2target_normal, heli2forward_normal);

  if(heli_dot_target >= level.heli_valid_target_cone) {
    return true;
  }

  return false;
}

function update_missile_player_threat(player) {
  player.missilethreatlevel = 0;
  dist = distance(player.origin, self.origin);
  player.missilethreatlevel += (level.heli_missile_range - dist) / level.heli_missile_range * 100;

  if(self missile_valid_target_check(player) == 0) {
    player.missilethreatlevel = 1;
    return;
  }

  if(isDefined(self.attacker) && player == self.attacker) {
    player.missilethreatlevel += 100;
  }

  if(isDefined(player.score)) {
    player.missilethreatlevel += player.score * 4;
  }

  if(isDefined(player.antithreat)) {
    player.missilethreatlevel -= player.antithreat;
  }

  if(player.missilethreatlevel <= 0) {
    player.missilethreatlevel = 1;
  }
}

function update_missile_dog_threat(dog) {
  dog.missilethreatlevel = 1;
}

function function_6d23c51c(dog) {
  dog.missilethreatlevel = 2;
}

function function_fff56140(owner, var_4a025683) {
  self notify(#"hash_4363bc1bae999ad3");
  self endon(#"hash_4363bc1bae999ad3", #"death");
  res = owner waittill(#"joined_team", #"disconnect", #"joined_spectators", #"changed_specialist");
  [[var_4a025683]]();
}

function should_not_timeout(killstreak) {
  assert(isDefined(killstreak), "<dev string:x79>");
  assert(isDefined(level.killstreaks[killstreak]), "<dev string:x1b3>");

  if(getdvarint(#"hash_e8bb2ce168acce0", 0)) {
    return 1;
  }

  if(isDefined(level.killstreaks[killstreak].devtimeoutdvar)) {
    return getdvarint(level.killstreaks[killstreak].devtimeoutdvar, 0);
  }

  return 0;
}

function waitfortimeout(killstreak, duration, callback, endcondition1, endcondition2, endcondition3) {
  function_b86397ae(killstreak, duration, undefined, callback, endcondition1, endcondition2, endcondition3);
}

function function_b86397ae(killstreak, duration, starttimeoverride, callback, endcondition1, endcondition2, endcondition3) {
  if(should_not_timeout(killstreak)) {
    return;
  }

  self endon(#"killstreak_hacked", #"cancel_timeout", #"hash_410e7050279b0b25");

  if(isDefined(endcondition1)) {
    self endon(endcondition1);
  }

  if(isDefined(endcondition2)) {
    self endon(endcondition2);
  }

  if(isDefined(endcondition3)) {
    self endon(endcondition3);
  }

  self thread waitfortimeouthacked(killstreak, callback, endcondition1, endcondition2, endcondition3);
  killstreakbundle = get_script_bundle(killstreak);

  if(isDefined(starttimeoverride)) {
    self.killstreakendtime = starttimeoverride + duration;
    waittime = self.killstreakendtime - gettime();
  } else {
    self.killstreakendtime = gettime() + duration;
    waittime = duration;
  }

  waittime = max(waittime, 0);

  if(util::function_7f7a77ab()) {
    self thread function_47492133();
  }

  if(isDefined(self.owner) && isPlayer(self.owner) && isDefined(self.killstreakslot) && self.var_ec8ef668 !== 1) {
    self.owner function_a831f92c(self.killstreakslot, int(ceil(float(duration) / 1000)), 0);
    self.owner function_b3185041(self.killstreakslot, self.killstreakendtime);
  }

  if(isDefined(killstreakbundle) && isDefined(killstreakbundle.kstimeoutbeepduration)) {
    self function_b00e94e0(killstreakbundle, waittime);
  } else {
    hostmigration::function_8d332f88(waittime);
  }

  self notify(#"kill_waitfortimeouthacked_thread");

  if(isDefined(self)) {
    self.killstreaktimedout = 1;
    self.killstreakendtime = 0;
  }

  if(isDefined(self.owner) && isPlayer(self.owner) && isDefined(self.killstreakslot)) {
    self.owner function_b3185041(self.killstreakslot, 0);
  }

  self notify(#"timed_out");

  if(isDefined(self)) {
    self[[callback]]();
  }
}

function function_b00e94e0(killstreakbundle, duration) {
  self waitfortimeoutbeep(killstreakbundle.kstimeoutbeepduration, killstreakbundle.kstimeoutfastbeepduration, duration);
}

function waitfortimeoutbeep(kstimeoutbeepduration, kstimeoutfastbeepduration, duration) {
  self endon(#"death");
  beepduration = int(kstimeoutbeepduration * 1000);
  hostmigration::function_8d332f88(max(duration - beepduration, 0));

  if(isvehicle(self)) {
    self clientfield::set("timeout_beep", 1);
  }

  if(isDefined(kstimeoutfastbeepduration)) {
    fastbeepduration = int(kstimeoutfastbeepduration * 1000);
    hostmigration::function_8d332f88(max(beepduration - fastbeepduration, 0));

    if(isvehicle(self)) {
      self clientfield::set("timeout_beep", 2);
    }

    hostmigration::function_8d332f88(fastbeepduration);
  }

  self function_67bc25ec();
}

function function_67bc25ec() {
  if(isDefined(self) && isvehicle(self)) {
    self clientfield::set("timeout_beep", 0);
  }
}

function waitfortimeouthacked(killstreak, callback, endcondition1, endcondition2, endcondition3) {
  self endon(#"kill_waitfortimeouthacked_thread");

  if(isDefined(endcondition1)) {
    self endon(endcondition1);
  }

  if(isDefined(endcondition2)) {
    self endon(endcondition2);
  }

  if(isDefined(endcondition3)) {
    self endon(endcondition3);
  }

  self waittill(#"killstreak_hacked");
  hackedduration = self killstreak_hacking::get_hacked_timeout_duration_ms();
  self.killstreakendtime = gettime() + hackedduration;
  hostmigration::function_8d332f88(hackedduration);
  self.killstreakendtime = 0;
  self notify(#"timed_out");
  self[[callback]]();
}

function function_975d45c3() {
  startheight = 200;

  switch (self getstance()) {
    case # "crouch":
      startheight = 30;
      break;
    case # "prone":
      startheight = 15;
      break;
  }

  return startheight;
}

function set_killstreak_delay_killcam(killstreak_name) {
  self.killstreak_delay_killcam = killstreak_name;
}

function getactivekillstreaks() {
  return self.pers[# "activekillstreaks"];
}

function function_55e3fed6(killstreaktype) {
  var_98037a32 = self.var_8b9b1bba[killstreaktype];

  if(!isDefined(var_98037a32)) {
    return false;
  }

  if(var_98037a32 > gettime()) {
    return true;
  }

  return false;
}

function watchteamchange(teamchangenotify) {
  self notify("79838062cf1bbaa9");
  self endon("79838062cf1bbaa9");
  killstreak = self;
  killstreak endon(#"death", teamchangenotify);
  killstreak.owner waittill(#"joined_team", #"disconnect", #"joined_spectators", #"emp_jammed");
  killstreak notify(teamchangenotify);
}

function killstreak_assist(victim, assister, killstreak) {
  victim recordkillstreakassist(victim, assister, killstreak);
}

function add_ricochet_protection(killstreak_id, owner, origin, ricochet_distance) {
  testing = 0;

  testing = getdvarint(#"scr_ricochet_protection_debug", 0) == 2;

  if(!level.hardcoremode && !testing) {
    return;
  }

  if(!isDefined(ricochet_distance) || ricochet_distance == 0) {
    return;
  }

  if(!isDefined(owner.ricochet_protection)) {
    owner.ricochet_protection = [];
  }

  owner.ricochet_protection[killstreak_id] = spawnStruct();
  owner.ricochet_protection[killstreak_id].origin = origin;
  owner.ricochet_protection[killstreak_id].distancesq = sqr(ricochet_distance);
}

function set_ricochet_protection_endtime(killstreak_id, owner, endtime) {
  if(!isDefined(owner) || !isDefined(owner.ricochet_protection) || !isDefined(killstreak_id)) {
    return;
  }

  if(!isDefined(owner.ricochet_protection[killstreak_id])) {
    return;
  }

  owner.ricochet_protection[killstreak_id].endtime = endtime;
}

function remove_ricochet_protection(killstreak_id, owner) {
  if(!isDefined(owner) || !isDefined(owner.ricochet_protection) || !isDefined(killstreak_id)) {
    return;
  }

  owner.ricochet_protection[killstreak_id] = undefined;
}

function thermal_glow(enable) {
  clientfield::set_to_player("thermal_glow", enable);
}

function thermal_glow_enemies_only(enable) {
  clientfield::set_to_player("thermal_glow_enemies_only", enable);
}

function is_ricochet_protected(player) {
  if(!isDefined(player) || !isDefined(player.ricochet_protection)) {
    return false;
  }

  foreach(protection in player.ricochet_protection) {
    if(!isDefined(protection)) {
      continue;
    }

    if(isDefined(protection.endtime) && protection.endtime < gettime()) {
      continue;
    }

    if(distancesquared(protection.origin, player.origin) < protection.distancesq) {
      return true;
    }
  }

  return false;
}

function get_script_bundle(type) {
  if(!isDefined(level.killstreaks[type])) {
    return undefined;
  }

  return level.killstreaks[type].script_bundle;
}

function function_e2c3bda3(killstreaktype, var_dee4d012) {
  bundle_name = level.var_8c83a621[killstreaktype];

  if(!isDefined(bundle_name)) {
    bundle_name = var_dee4d012;
  }

  return bundle_name;
}

function function_8c83a621(killstreaktype, bundle_name) {
  if(!isDefined(level.var_8c83a621)) {
    level.var_8c83a621 = [];
  }

  level.var_8c83a621[killstreaktype] = bundle_name;
}

function function_257a5f13(killstreaktype, var_ba5a6782) {
  if(!isDefined(level.var_257a5f13)) {
    level.var_257a5f13 = [];
  }

  level.var_257a5f13[killstreaktype] = var_ba5a6782;
}

function function_b182645e(player, hardpointtype) {
  if(isDefined(level.var_257a5f13[hardpointtype])) {
    killstreakslot = 3;
    var_1abcfdda = getarraykeys(player.killstreak);

    foreach(key in var_1abcfdda) {
      if(!isDefined(player.killstreak[key])) {
        continue;
      }

      if(player.killstreak[key] == hardpointtype) {
        killstreakslot = key;
        break;
      }
    }

    duration = level.var_257a5f13[hardpointtype];
    player function_a831f92c(killstreakslot, duration, 0);
    self.killstreakendtime = gettime() + int(duration * 1000);
    player function_b3185041(killstreakslot, self.killstreakendtime);
  }
}

function function_f964dc1c() {
  for(slot = 0; slot < 4; slot++) {
    duration = isDefined(self.pers[# "hash_6ae564fce4d70aff"][slot]) ? self.pers[# "hash_6ae564fce4d70aff"][slot] : 0;
    var_f63114ce = isDefined(self.pers[# "hash_7b0ebc5ef8a8b896"][slot]) ? self.pers[# "hash_7b0ebc5ef8a8b896"][slot] : 0;
    self function_5249e8b8(slot, duration);
    self function_d5d8e662(slot, var_f63114ce);
    endtime = isDefined(self.pers[# "hash_754e08b82fb3a121"][slot]) ? self.pers[# "hash_754e08b82fb3a121"][slot] : 0;
    self function_4051d1c6(slot, endtime);
  }
}

function function_a831f92c(killstreakslot, duration, var_f63114ce) {
  if(!isDefined(self.pers[# "hash_6ae564fce4d70aff"])) {
    self.pers[# "hash_6ae564fce4d70aff"] = [];
  }

  if(!isDefined(self.pers[# "hash_7b0ebc5ef8a8b896"])) {
    self.pers[# "hash_7b0ebc5ef8a8b896"] = [];
  }

  self.pers[# "hash_6ae564fce4d70aff"][killstreakslot] = duration;
  self function_5249e8b8(killstreakslot, duration);
  self.pers[# "hash_7b0ebc5ef8a8b896"][killstreakslot] = var_f63114ce;
  self function_d5d8e662(killstreakslot, var_f63114ce);
}

function function_b3185041(killstreakslot, endtime) {
  if(!isDefined(self.pers[# "hash_754e08b82fb3a121"])) {
    self.pers[# "hash_754e08b82fb3a121"] = [];
  }

  self.pers[# "hash_754e08b82fb3a121"][killstreakslot] = endtime;
  self function_4051d1c6(killstreakslot, endtime);
}

function function_a781e8d2() {
  self clientfield::set("standardTagFxSet", 1);
}

function function_90e951f2() {
  self clientfield::set("standardTagFxSet", 0);
}

function function_8b4513ca() {
  self clientfield::set("lowHealthTagFxSet", 1);
}

function function_7d265bd3() {
  self clientfield::set("deathTagFxSet", 1);
}

function function_ea21be29(killstreaktype, killstreak_weapon, player_died) {
  player = self;
  assert(isDefined(player));

  if(player_died) {
    var_38665394 = player getteam();
    var_27dca80 = player waittill(#"loadout_given", #"disconnect");

    if(var_27dca80._notify !== "loadout_given") {
      return false;
    }

    if(isDefined(player) && var_38665394 !== player getteam()) {
      return false;
    }
  }

  if(isDefined(player)) {
    if(!isDefined(killstreak_weapon)) {
      return false;
    }

    if(player getammocount(killstreak_weapon) > 0) {
      return false;
    }

    var_f66fab06 = player killstreakrules::function_d9f8f32b(killstreaktype);
    player thread killstreakrules::function_9f635a5(var_f66fab06, killstreaktype);
    return true;
  }

  return false;
}

function private function_119fdfcd(killstreaktype) {
  player = self;

  if(!isPlayer(player)) {
    assert(isPlayer(player));
    return;
  }

  if(!isDefined(player.var_d01e44d1)) {
    player.var_d01e44d1 = [];
  }

  var_4dd65320 = player.var_d01e44d1[killstreaktype];

  if(!isDefined(var_4dd65320) || var_4dd65320 + int(20 * 1000) < gettime()) {
    level thread popups::displaykillstreakteammessagetoall(killstreaktype, self);
    self battlechatter::function_576ff6fe(killstreaktype);
    player.var_d01e44d1[killstreaktype] = gettime();
  }
}

function function_fc82c544(killstreaktype) {
  player = self;
  assert(isPlayer(player));
  function_119fdfcd(killstreaktype);
  player disableoffhandweapons();
  result = player waittill(#"weapon_change_complete", #"death", #"disconnect", #"joined_team", #"emp_jammed", #"emp_grenaded");

  if(isDefined(player)) {
    player enableoffhandweapons();
  }

  var_36f4a15 = 0;
  var_64df9ac6 = gettime();

  if(!sessionmodeiscampaigngame()) {
    if(!sessionmodeiszombiesgame()) {
      stats::function_8fb23f94(function_73b4659(killstreaktype), #"uses", 1);
    }

    player function_eb52ba7(killstreaktype, player getteam(), -1);
  }

  if(result._notify == "weapon_change_complete") {
    if(isDefined(result.weapon)) {
      function_ece736e7(player, result.weapon);
    }

    var_36f4a15 = 1;
    var_66970d93 = 1;
    killstreak_weapon = result.weapon;

    if(isDefined(level.var_fc6cd245)) {
      player[[level.var_fc6cd245]](killstreak_weapon);
    }

    while(var_66970d93) {
      result = player waittill(#"weapon_change", #"death", #"disconnect", #"joined_team", #"emp_jammed", #"emp_grenaded", #"hash_44f09afc8f27cf23");
      var_66970d93 = result._notify != "death" && isDefined(result.weapon) && result.weapon == killstreak_weapon;
    }
  }

  if(isDefined(player.var_8e94d71c[killstreak_weapon])) {
    player.var_8e94d71c[killstreak_weapon] = undefined;
  }

  if(result._notify === # "death") {
    if(isDefined(level.var_1d971504)) {
      [[level.var_1d971504]](result.attacker, player, killstreak_weapon);
    }
  }

  if((isDefined(result.last_weapon) || result._notify === # "death") && isDefined(player)) {
    var_37b0037 = player function_ea21be29(killstreaktype, killstreak_weapon, result._notify === "death");

    if(!var_37b0037) {
      return 0;
    }

    if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame() || sessionmodeiszombiesgame()) {
      mpkillstreakuses = {
        #starttime: var_64df9ac6, #endtime: gettime(), #spawnid: -1, #name: killstreaktype, #team: player getteam()
      };
      var_8756d70f = function_cb0594d5();
      function_92d1707f(var_8756d70f, mpkillstreakuses);

      if(result._notify === # "death") {
        var_e72137e8 = # "player_died";

        if(isDefined(result.weapon)) {
          player function_4aad9803(killstreaktype, -1, result.weapon);
        }
      }

      player function_fda235cf(killstreaktype, -1, var_e72137e8);

      if(isDefined(level.var_f9922f0b)) {
        player[[level.var_f9922f0b]](killstreak_weapon);
      }
    }
  }

  return var_36f4a15;
}

function function_47492133() {
  self endon(#"death", #"timed_out", #"cancel_timeout");
  level endon(#"disconnect");
  assert(isDefined(self.killstreakendtime));
  assert(isDefined(self.owner));

  while(true) {
    var_2226e3f0 = self.killstreakendtime;

    if(!is_true(level.var_e80a117f)) {
      level waittill(#"esports_game_paused");
    }

    var_569a1ad5 = gettime();

    while(is_true(level.var_e80a117f)) {
      self.killstreakendtime = var_2226e3f0 + gettime() - var_569a1ad5;

      if(isDefined(self.owner)) {
        self.owner setvehicledrivableendtime(self.killstreakendtime);
      }

      waitframe(1);
    }
  }
}

function function_edde22a8() {
  if(!isDefined(level.killstreaks[# "nuke"]) || isitemrestricted("nuke")) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  killstreakname = "inventory_nuke";
  give(killstreakname);
  self thread killstreak_dialog::play_killstreak_ready_dialog(killstreakname, 1.6);
  self thread play_killstreak_ready_sfx(killstreakname);
  killstreaktablenumber = level.killstreakindices[# "nuke"];

  if(isDefined(killstreaktablenumber)) {
    informdialog = killstreak_dialog::get_killstreak_inform_dialog(killstreakname);
    self luinotifyevent(#"killstreak_received", 3, killstreaktablenumber, informdialog, 1);
    self function_8ba40d2f(#"killstreak_received", 3, killstreaktablenumber, informdialog, 1);
  }

  killstreakslot = 3;

  if(isDefined(killstreakslot)) {
    self function_6bf621ea(#"hash_6a9cb800ad0ef395", 2, self getentitynumber(), killstreakslot);
  }

  self playSound("mpl_d_hard_nuke_obtain");
}

function debug_ricochet_protection() {
  debug_wait = 0.5;
  debug_frames = int(debug_wait / float(function_60d95f53()) / 1000) + 1;

  while(true) {
    if(getdvarint(#"scr_ricochet_protection_debug", 0) == 0) {
      wait 2;
      continue;
    }

    wait debug_wait;

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(!isDefined(player.ricochet_protection)) {
        continue;
      }

      foreach(protection in player.ricochet_protection) {
        if(!isDefined(protection)) {
          continue;
        }

        if(isDefined(protection.endtime) && protection.endtime < gettime()) {
          continue;
        }

        radius = sqrt(protection.distancesq);
        sphere(protection.origin, radius, (1, 1, 0), 0.25, 0, 36, debug_frames);
        circle(protection.origin, radius, (1, 0.5, 0), 0, 1, debug_frames);
        circle(protection.origin + (0, 0, 2), radius, (1, 0.5, 0), 0, 1, debug_frames);
      }
    }
  }
}

function function_e24443d0(killstreaktype) {
  killstreakslot = function_a2c375bb(killstreaktype);

  if(isDefined(killstreakslot)) {
    self function_6bf621ea(#"hash_1d8e470838fb6dd3", 2, self getentitynumber(), killstreakslot);
  }
}