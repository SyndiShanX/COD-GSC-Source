/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\killstreaks_shared.gsc
***********************************************/

#include scripts\abilities\ability_util;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\contracts_shared;
#include scripts\core_common\damage;
#include scripts\core_common\damagefeedback_shared;
#include scripts\core_common\dialog_shared;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\hostmigration_shared;
#include scripts\core_common\hud_shared;
#include scripts\core_common\influencers_shared;
#include scripts\core_common\loadout_shared;
#include scripts\core_common\placeables;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\struct;
#include scripts\core_common\throttle_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\weapons_shared;
#include scripts\killstreaks\airsupport;
#include scripts\killstreaks\killstreak_bundles;
#include scripts\killstreaks\killstreak_hacking;
#include scripts\killstreaks\killstreakrules_shared;
#include scripts\killstreaks\killstreaks_util;
#include scripts\weapons\deployable;
#include scripts\weapons\tacticalinsertion;
#include scripts\weapons\weaponobjects;

#namespace killstreaks;

init_shared() {
  level.killstreaks = [];
  level.killstreakweapons = [];
  level.var_8997324c = [];
  level.droplocations = [];
  level.zoffsetcounter = 0;
  level.var_46c23c0f = 0;
  clientfield::register("clientuimodel", "locSel.commandMode", 1, 1, "int");
  clientfield::register("clientuimodel", "locSel.snapTo", 1, 1, "int");
  clientfield::register("vehicle", "timeout_beep", 1, 2, "int");
  clientfield::register("toplayer", "thermal_glow", 1, 1, "int");
  clientfield::register("toplayer", "thermal_glow_enemies_only", 12000, 1, "int");
  level.play_killstreak_firewall_being_hacked_dialog = undefined;
  level.play_killstreak_firewall_hacked_dialog = undefined;
  level.play_killstreak_being_hacked_dialog = undefined;
  level.play_killstreak_hacked_dialog = undefined;
  level.play_pilot_dialog_on_owner = undefined;
  level.play_pilot_dialog = undefined;
  level.play_taacom_dialog_response_on_owner = undefined;
  level.play_taacom_dialog = undefined;
  level.var_514f9d20 = undefined;
  level.var_9f8e080d = undefined;
  level.var_19a15e42 = undefined;
  level.var_239dc073 = getweapon(#"killstreak_remote");

  if(!isDefined(level.var_6cfbe5a)) {
    level.var_6cfbe5a = new throttle();
    [[level.var_6cfbe5a]] - > initialize(1, 0.1);
  }
}

function_447e6858() {
  level.numkillstreakreservedobjectives = 0;
  level.killstreakcounter = 0;

  if(!isDefined(level.roundstartkillstreakdelay)) {
    level.roundstartkillstreakdelay = 0;
  }

  level.iskillstreakweapon = &is_killstreak_weapon;
  level.killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");
  callback::on_spawned(&on_player_spawned);
  callback::on_joined_team(&on_joined_team);
  level.var_d80e834 = &function_da600615;
}

function_da600615(bot) {
  weapons = bot getweaponslist();

  foreach(weapon in weapons) {
    if(is_killstreak_weapon(weapon)) {
      killstreak = get_killstreak_for_weapon(weapon);
      bot thread usekillstreak(killstreak, 0);
    }
  }
}

function_b5b6ef3e(func, obj) {
  callback::add_callback(#"hash_45f35669076bc317", func, obj);
}

register_ui(killstreak_type, killstreak_menu) {
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

  if(level.killstreaks[killstreak_type].uiname == "<dev string:x74>") {
    level.killstreaks[killstreak_type].uiname = killstreak_menu;
  }

}

killstreak_init(killstreak_type) {
  assert(isDefined(killstreak_type), "<dev string:x77>");
  assert(!isDefined(level.killstreaks[killstreak_type]), "<dev string:xb2>" + killstreak_type + "<dev string:xc0>");
  level.killstreaks[killstreak_type] = spawnStruct();
  level.killstreaks[killstreak_type].killstreaklevel = 0;
  level.killstreaks[killstreak_type].quantity = 0;
  level.killstreaks[killstreak_type].allowassists = 0;
  level.killstreaks[killstreak_type].overrideentitycameraindemo = 0;
  level.killstreaks[killstreak_type].teamkillpenaltyscale = 1;
  level.killstreaks[killstreak_type].var_b6c17aab = 0;
}

register_weapon(killstreak_type, weapon) {
  if(weapon.name == #"none") {
    return;
  }

  assert(isDefined(killstreak_type), "<dev string:x77>");
  assert(weapon.name != #"none");
  assert(!isDefined(level.killstreakweapons[weapon]), "<dev string:xd6>");
  level.killstreaks[killstreak_type].weapon = weapon;
  level.killstreakweapons[weapon] = killstreak_type;
}

register_vehicle(killstreak_type, vehicle) {
  assert(isDefined(killstreak_type), "<dev string:x77>");
  assert(!isDefined(level.var_8997324c[vehicle]), "<dev string:xd6>");
  level.killstreaks[killstreak_type].vehicle = vehicle;
  level.var_8997324c[vehicle] = killstreak_type;
}

register(killstreaktype, killstreakweaponname, killstreakmenuname, killstreakusagekey, killstreakusefunction, killstreakdelaystreak, weaponholdallowed = 0, killstreakstatsname = undefined, registerdvars = 1, registerinventory = 1) {
  assert(isDefined(killstreakusefunction), "<dev string:x114>" + killstreaktype);
  killstreak_init(killstreaktype);
  register_ui(killstreaktype, killstreakmenuname);
  level.killstreaks[killstreaktype].usagekey = killstreakusagekey;
  level.killstreaks[killstreaktype].usefunction = killstreakusefunction;
  level.killstreaks[killstreaktype].delaystreak = killstreakdelaystreak;

  if(isDefined(killstreakweaponname)) {
    killstreakweapon = getweapon(killstreakweaponname);
    register_weapon(killstreaktype, killstreakweapon);
  }

  if(isDefined(killstreakstatsname)) {
    level.killstreaks[killstreaktype].killstreakstatsname = killstreakstatsname;
  }

  level.killstreaks[killstreaktype].weaponholdallowed = weaponholdallowed;

  if(isDefined(registerinventory) && registerinventory) {
    level.menureferenceforkillstreak[killstreakmenuname] = killstreaktype;
    bundlename = function_656f23d5(killstreaktype);
    killstreak_bundles::register_killstreak_bundle(bundlename);
    var_28f0acc5 = undefined;

    if(isDefined(killstreakweaponname)) {
      var_28f0acc5 = "inventory_" + killstreakweaponname;
    }

    register("inventory_" + killstreaktype, var_28f0acc5, killstreakmenuname, killstreakusagekey, killstreakusefunction, killstreakdelaystreak, weaponholdallowed, killstreakstatsname, 0, 0);
  }
}

private function_656f23d5(killstreaktype) {
  if(killstreaktype === "drone_squadron") {
    if(sessionmodeiscampaigngame()) {
      return ("drone_squadron" + "_cp");
    }
  }

  return killstreaktype;
}

private function_e48aca4d(type, bundle, weapon, vehicle, killstreak_use_function, isinventoryweapon) {
  killstreak_init(type);
  menukey = bundle.var_a99ef6da;

  if(!isDefined(menukey)) {
    menukey = type;
  } else if(isDefined(isinventoryweapon) && isinventoryweapon) {
    menukey = "inventory_" + menukey;
  }

  register_ui(type, menukey);
  level.killstreaks[type].usagekey = type;
  level.killstreaks[type].delaystreak = bundle.var_daf6b7af;
  level.killstreaks[type].usefunction = killstreak_use_function;
  level.killstreaks[type].weaponholdallowed = 0;
  register_weapon(type, weapon);
  level.menureferenceforkillstreak[menukey] = type;

  if(isDefined(bundle.altweapons)) {
    foreach(alt_weapon in bundle.altweapons) {
      function_181f96a6(type, alt_weapon.ksaltweapon);
    }
  }

  if(isDefined(vehicle)) {
    register_vehicle(type, vehicle);
  }

  function_7e46eaea(type, bundle.var_b45be9e6, bundle.var_502a0e23, bundle.var_667c638e, bundle.var_a56710c6, bundle.var_bc2f6af9, bundle.var_6417048f, isDefined(bundle.var_65d707d0) ? bundle.var_65d707d0 : 0, isDefined(bundle.var_a9b0c301) ? bundle.var_a9b0c301 : 0);
  level.killstreaks[type].var_4a5906fd = bundle.var_3211a185;

  if(isDefined(level.cratetypes)) {
    if(isDefined(isinventoryweapon) && isinventoryweapon) {
      if(isDefined(level.cratetypes[#"inventory_supplydrop"]) && isDefined(level.cratetypes[#"inventory_supplydrop"][type])) {
        level.cratetypes[#"inventory_supplydrop"][type].hint = bundle.var_1d2a2ca4;
        level.cratetypes[#"inventory_supplydrop"][type].hint_gambler = bundle.var_8c4d7906;
      }
    } else {
      if(isDefined(level.cratetypes[#"supplydrop"]) && isDefined(level.cratetypes[#"supplydrop"][type])) {
        level.cratetypes[#"supplydrop"][type].hint = bundle.var_1d2a2ca4;
        level.cratetypes[#"supplydrop"][type].hint_gambler = bundle.var_8c4d7906;
        game.strings[type + "_hint"] = bundle.var_1d2a2ca4;
      }

      if(isDefined(level.cratetypes[#"gambler"]) && isDefined(level.cratetypes[#"gambler"][type])) {
        level.cratetypes[#"gambler"][type].hint = bundle.var_1d2a2ca4;
        level.cratetypes[#"gambler"][type].hint_gambler = bundle.var_8c4d7906;
      }
    }
  }

  function_1110a5de(type, bundle.var_5fbfc70d, bundle.var_e7b30a9a, bundle.var_b7bd2ff9, bundle.var_f6042a3, bundle.var_2451b1f2, bundle.var_7742570a, bundle.var_335def6c, bundle.var_7a502c34, bundle.var_e773a429, bundle.var_799a81a7, bundle.var_f5871fe4, bundle.var_bd7786a4);
  level.killstreaks[type].script_bundle = bundle;
  killstreak_bundles::register_bundle(type, bundle);

  if(isDefined(bundle.var_1bc9830d) && bundle.var_1bc9830d && !(isDefined(isinventoryweapon) && isinventoryweapon)) {
    register_dev_dvars(type);
  }
}

register_bundle(bundle, killstreak_use_function) {
  function_e48aca4d(bundle.kstype, bundle, bundle.ksweapon, bundle.ksvehicle, killstreak_use_function, 0);

  if(isDefined(bundle.ksinventoryweapon) && bundle.ksinventoryweapon.name != #"none") {
    function_e48aca4d("inventory_" + bundle.kstype, bundle, bundle.ksinventoryweapon, undefined, killstreak_use_function, 1);
  }
}

register_killstreak(bundlename, use_function) {
  bundle = struct::get_script_bundle("killstreak", bundlename);
  register_bundle(bundle, use_function);
}

is_registered(killstreaktype) {
  return isDefined(level.killstreaks[killstreaktype]);
}

function_7e46eaea(killstreaktype, receivedtext, notusabletext, inboundtext, inboundnearplayertext, var_43279ec9, hackedtext, utilizesairspace, var_a4a7d3e7) {
  assert(isDefined(killstreaktype), "<dev string:x13e>");
  assert(isDefined(level.killstreaks[killstreaktype]), "<dev string:x174>");
  level.killstreaks[killstreaktype].receivedtext = receivedtext;
  level.killstreaks[killstreaktype].notavailabletext = notusabletext;
  level.killstreaks[killstreaktype].inboundtext = inboundtext;
  level.killstreaks[killstreaktype].var_43279ec9 = var_43279ec9;
  level.killstreaks[killstreaktype].inboundnearplayertext = inboundnearplayertext;
  level.killstreaks[killstreaktype].hackedtext = hackedtext;
  level.killstreaks[killstreaktype].utilizesairspace = utilizesairspace;
  level.killstreaks[killstreaktype].var_a4a7d3e7 = var_a4a7d3e7;
}

function_1110a5de(killstreaktype, informdialog, taacomdialogbundlekey, pilotdialogarraykey, startdialogkey, enemystartdialogkey, enemystartmultipledialogkey, hackeddialogkey, hackedstartdialogkey, requestdialogkey, threatdialogkey, var_3b69c05b, var_2729ed45) {
  assert(isDefined(killstreaktype), "<dev string:x77>");
  assert(isDefined(level.killstreaks[killstreaktype]), "<dev string:x1b9>");
  level.killstreaks[killstreaktype].informdialog = informdialog;
  level.killstreaks[killstreaktype].taacomdialogbundlekey = taacomdialogbundlekey;
  level.killstreaks[killstreaktype].startdialogkey = startdialogkey;
  level.killstreaks[killstreaktype].enemystartdialogkey = enemystartdialogkey;
  level.killstreaks[killstreaktype].enemystartmultipledialogkey = enemystartmultipledialogkey;
  level.killstreaks[killstreaktype].hackeddialogkey = hackeddialogkey;
  level.killstreaks[killstreaktype].hackedstartdialogkey = hackedstartdialogkey;
  level.killstreaks[killstreaktype].var_2729ed45 = var_2729ed45;
  level.killstreaks[killstreaktype].requestdialogkey = requestdialogkey;
  level.killstreaks[killstreaktype].var_3b69c05b = var_3b69c05b;
  level.killstreaks[killstreaktype].threatdialogkey = threatdialogkey;

  if(isDefined(pilotdialogarraykey)) {
    taacombundles = struct::get_script_bundles("mpdialog_taacom");

    foreach(bundle in taacombundles) {
      if(!isDefined(bundle.pilotbundles)) {
        bundle.pilotbundles = [];
      }

      bundle.pilotbundles[killstreaktype] = [];
      i = 0;
      field = pilotdialogarraykey + i;

      for(fieldvalue = bundle.(field); isDefined(fieldvalue); fieldvalue = bundle.(field)) {
        bundle.pilotbundles[killstreaktype][i] = fieldvalue;
        i++;
        field = pilotdialogarraykey + i;
      }
    }

    level.tacombundles = taacombundles;
  }
}

function_181f96a6(killstreaktype, weapon) {
  assert(isDefined(killstreaktype), "<dev string:x77>");
  assert(isDefined(level.killstreaks[killstreaktype]), "<dev string:x1fd>");

  if(weapon.name == #"none") {
    return;
  }

  if(level.killstreaks[killstreaktype].weapon === weapon) {
    return;
  }

  if(!isDefined(level.killstreaks[killstreaktype].altweapons)) {
    level.killstreaks[killstreaktype].altweapons = [];
  }

  if(!isDefined(level.killstreakweapons[weapon])) {
    level.killstreakweapons[weapon] = killstreaktype;
  }

  level.killstreaks[killstreaktype].altweapons[level.killstreaks[killstreaktype].altweapons.size] = weapon;
}

register_alt_weapon(killstreaktype, weapon) {
  function_181f96a6(killstreaktype, weapon);
  function_181f96a6("inventory_" + killstreaktype, weapon);
}

function_e37b061(killstreaktype, weapon) {
  function_181f96a6(killstreaktype, weapon);
}

function_b013c2d3(killstreaktype, weapon) {
  if(!isDefined(level.var_3ff1b984)) {
    level.var_3ff1b984 = [];
  }

  level.var_3ff1b984[weapon] = killstreaktype;
}

register_remote_override_weapon(killstreaktype, weaponname, isinventory) {
  assert(isDefined(killstreaktype), "<dev string:x77>");
  assert(isDefined(level.killstreaks[killstreaktype]), "<dev string:x245>");
  weapon = getweapon(weaponname);

  if(level.killstreaks[killstreaktype].weapon === weapon) {
    return;
  }

  if(!isDefined(level.killstreaks[killstreaktype].remoteoverrideweapons)) {
    level.killstreaks[killstreaktype].remoteoverrideweapons = [];
  }

  if(!isDefined(level.killstreakweapons[weapon])) {
    level.killstreakweapons[weapon] = killstreaktype;
  }

  level.killstreaks[killstreaktype].remoteoverrideweapons[level.killstreaks[killstreaktype].remoteoverrideweapons.size] = weapon;
}

is_remote_override_weapon(killstreaktype, weapon) {
  if(isDefined(level.killstreaks[killstreaktype].remoteoverrideweapons)) {
    for(i = 0; i < level.killstreaks[killstreaktype].remoteoverrideweapons.size; i++) {
      if(level.killstreaks[killstreaktype].remoteoverrideweapons[i] == weapon) {
        return true;
      }
    }
  }

  return false;
}

register_dev_dvars(killstreaktype) {

  assert(isDefined(killstreaktype), "<dev string:x77>");
  assert(isDefined(level.killstreaks[killstreaktype]), "<dev string:x299>");
  level.killstreaks[killstreaktype].devdvar = "<dev string:x2df>" + killstreaktype + "<dev string:x2e6>";
  level.killstreaks[killstreaktype].devenemydvar = "<dev string:x2df>" + killstreaktype + "<dev string:x2ee>";
  level.killstreaks[killstreaktype].devtimeoutdvar = "<dev string:x2df>" + killstreaktype + "<dev string:x2fb>";
  setdvar(level.killstreaks[killstreaktype].devtimeoutdvar, 0);
  level thread register_devgui(killstreaktype);

}

register_dev_debug_dvar(killstreaktype) {
  assert(isDefined(killstreaktype), "<dev string:x77>");
  assert(isDefined(level.killstreaks[killstreaktype]), "<dev string:x299>");
  level.killstreaks[killstreaktype].devdebugdvar = "<dev string:x2df>" + killstreaktype + "<dev string:x308>";
  devgui_scorestreak_command_debugdvar(killstreaktype, level.killstreaks[killstreaktype].devdebugdvar);
}

register_devgui(killstreaktype) {
  level endon(#"game_ended");
  wait randomintrange(2, 20) * float(function_60d95f53()) / 1000;
  give_type_all = "<dev string:x311>";
  give_type_enemy = "<dev string:x318>";

  if(isDefined(level.killstreaks[killstreaktype].devdvar)) {
    devgui_scorestreak_command_givedvar(killstreaktype, give_type_all, level.killstreaks[killstreaktype].devdvar);
  }

  if(isDefined(level.killstreaks[killstreaktype].devenemydvar)) {
    devgui_scorestreak_command_givedvar(killstreaktype, give_type_enemy, level.killstreaks[killstreaktype].devenemydvar);
  }

  if(isDefined(level.killstreaks[killstreaktype].devtimeoutdvar)) {}
}

devgui_scorestreak_command_givedvar(killstreaktype, give_type, dvar) {
  devgui_scorestreak_command(killstreaktype, give_type, "<dev string:x325>" + dvar + "<dev string:x32c>");
}

devgui_scorestreak_command_timeoutdvar(killstreaktype, dvar) {
  devgui_scorestreak_dvar_toggle(killstreaktype, "<dev string:x331>", dvar);
}

devgui_scorestreak_command_debugdvar(killstreaktype, dvar) {
  devgui_scorestreak_dvar_toggle(killstreaktype, "<dev string:x33c>", dvar);
}

  function devgui_scorestreak_dvar_toggle(killstreaktype, title, dvar) {
    setdvar(dvar, 0);
    devgui_scorestreak_command(killstreaktype, "Toggle " + title, "toggle " + dvar + " 1 0");
  }

devgui_scorestreak_command(killstreaktype, title, command) {

  assert(isDefined(killstreaktype), "<dev string:x77>");
  assert(isDefined(level.killstreaks[killstreaktype]), "<dev string:x299>");
  root = "<dev string:x344>";
  user_name = level.killstreaks[killstreaktype].menuname;
  util::add_queued_debug_command(root + user_name + "<dev string:x363>" + killstreaktype + "<dev string:x368>" + title + "<dev string:x36d>" + command + "<dev string:x373>");

}

should_draw_debug(killstreak) {

  assert(isDefined(killstreak), "<dev string:x77>");
  function_2459bd2f();

  if(isDefined(level.killstreaks[killstreak]) && isDefined(level.killstreaks[killstreak].devdebugdvar)) {
    return getdvarint(level.killstreaks[killstreak].devdebugdvar, 0);
  }

    return 0;
}

function_2459bd2f() {
  assert(isDefined(level.killstreaks), "<dev string:x379>");
}

  function is_available(killstreak) {
    if(isDefined(level.menureferenceforkillstreak[killstreak])) {
      return 1;
    }

    return 0;
  }

get_by_menu_name(killstreak) {
  return level.menureferenceforkillstreak[killstreak];
}

get_menu_name(killstreaktype) {
  assert(isDefined(level.killstreaks[killstreaktype]));
  return level.killstreaks[killstreaktype].menuname;
}

get_level(index, killstreak) {
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

give_if_streak_count_matches(index, killstreak, streakcount) {
  pixbeginevent(#"givekillstreakifstreakcountmatches");

  if(!isDefined(killstreak)) {
    println("<dev string:x3e8>");
  }

  if(isDefined(killstreak)) {
    println("<dev string:x401>" + killstreak + "<dev string:x419>");
  }

  if(!is_available(killstreak)) {
    println("<dev string:x41d>");
  }

    if(self.pers[#"killstreaksearnedthiskillstreak"] > index && util::isroundbased()) {
      hasalreadyearnedkillstreak = 1;
    }
  else {
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
      self.pers[#"killstreaksearnedthiskillstreak"] = index + 1;
      pixendevent();
      return true;
    }
  }

  pixendevent();
  return false;
}

give_for_streak() {
  if(!util::is_killstreaks_enabled()) {
    return;
  }

  if(!isDefined(self.pers[#"totalkillstreakcount"])) {
    self.pers[#"totalkillstreakcount"] = 0;
  }

  given = 0;

  for(i = 0; i < self.killstreak.size; i++) {
    given |= give_if_streak_count_matches(i, self.killstreak[i], self.pers[#"cur_kill_streak"]);
  }
}

is_an_a_killstreak() {
  onkillstreak = 0;

  if(!isDefined(self.pers[#"kill_streak_before_death"])) {
    self.pers[#"kill_streak_before_death"] = 0;
  }

  streakplusone = self.pers[#"kill_streak_before_death"] + 1;

  if(self.pers[#"kill_streak_before_death"] >= 5) {
    onkillstreak = 1;
  }

  return onkillstreak;
}

give(killstreaktype, streak, suppressnotification, noxp, tobottom) {
  pixbeginevent(#"givekillstreak");
  self endon(#"disconnect");
  level endon(#"game_ended");
  had_to_delay = 0;
  killstreakgiven = 0;

  if(isDefined(noxp)) {
    if(self give_internal(killstreaktype, undefined, noxp, tobottom)) {
      killstreakgiven = 1;

      if(self.just_given_new_inventory_killstreak === 1) {
        self add_to_notification_queue(level.killstreaks[killstreaktype].menuname, streak, killstreaktype, noxp, 1);
      }
    }
  } else if(self give_internal(killstreaktype, noxp)) {
    killstreakgiven = 1;

    if(self.just_given_new_inventory_killstreak === 1) {
      self add_to_notification_queue(level.killstreaks[killstreaktype].menuname, streak, killstreaktype, noxp, 1);
    }
  }

  pixendevent();
}

take(killstreak) {
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

remove_oldest() {
  if(isDefined(self.pers[#"killstreaks"][0])) {
    currentweapon = self getcurrentweapon();

    if(currentweapon == get_killstreak_weapon(self.pers[#"killstreaks"][0])) {
      primaries = self getweaponslistprimaries();

      if(primaries.size > 0) {
        self switchtoweapon(primaries[0]);
      }
    }

    self notify(#"oldest_killstreak_removed", {
      #type: self.pers[#"killstreaks"][0], 
      #id: self.pers[#"killstreak_unique_id"][0]
    });
    self remove_used_killstreak(self.pers[#"killstreaks"][0], self.pers[#"killstreak_unique_id"][0], 0);
  }
}

give_internal(killstreaktype, do_not_update_death_count, noxp, tobottom) {
  self.just_given_new_inventory_killstreak = undefined;

  if(level.gameended) {
    return false;
  }

  if(!util::is_killstreaks_enabled()) {
    return false;
  }

  if(!isDefined(level.killstreaks[killstreaktype])) {
    return false;
  }

  if(!isDefined(self.pers[#"killstreaks"])) {
    self.pers[#"killstreaks"] = [];
  }

  if(!isDefined(self.pers[#"killstreak_has_been_used"])) {
    self.pers[#"killstreak_has_been_used"] = [];
  }

  if(!isDefined(self.pers[#"killstreak_unique_id"])) {
    self.pers[#"killstreak_unique_id"] = [];
  }

  if(!isDefined(self.pers[#"killstreak_ammo_count"])) {
    self.pers[#"killstreak_ammo_count"] = [];
  }

  just_max_stack_removed_inventory_killstreak = undefined;

  if(isDefined(tobottom) && tobottom) {
    size = self.pers[#"killstreaks"].size;

    if(self.pers[#"killstreaks"].size >= level.maxinventoryscorestreaks) {
      self remove_oldest();
      just_max_stack_removed_inventory_killstreak = self.just_removed_used_killstreak;
    }

    for(i = size; i > 0; i--) {
      self.pers[#"killstreaks"][i] = self.pers[#"killstreaks"][i - 1];
      self.pers[#"killstreak_has_been_used"][i] = self.pers[#"killstreak_has_been_used"][i - 1];
      self.pers[#"killstreak_unique_id"][i] = self.pers[#"killstreak_unique_id"][i - 1];
      self.pers[#"killstreak_ammo_count"][i] = self.pers[#"killstreak_ammo_count"][i - 1];
    }

    self.pers[#"killstreaks"][0] = killstreaktype;
    self.pers[#"killstreak_unique_id"][0] = level.killstreakcounter;
    level.killstreakcounter++;

    if(isDefined(noxp)) {
      self.pers[#"killstreak_has_been_used"][0] = noxp;
    } else {
      self.pers[#"killstreak_has_been_used"][0] = 0;
    }

    if(size == 0) {
      weapon = get_killstreak_weapon(killstreaktype);
      ammocount = give_weapon(weapon, 1);
    }

    self.pers[#"killstreak_ammo_count"][0] = 0;
  } else {
    var_7b935486 = 0;

    if(self.pers[#"killstreaks"].size && self.currentweapon === get_killstreak_weapon(self.pers[#"killstreaks"][self.pers[#"killstreaks"].size - 1])) {
      var_7b935486 = 1;
    }

    self.pers[#"killstreaks"][self.pers[#"killstreaks"].size] = killstreaktype;
    self.pers[#"killstreak_unique_id"][self.pers[#"killstreak_unique_id"].size] = level.killstreakcounter;
    level.killstreakcounter++;

    if(self.pers[#"killstreaks"].size > level.maxinventoryscorestreaks) {
      self remove_oldest();
      just_max_stack_removed_inventory_killstreak = self.just_removed_used_killstreak;
    }

    if(!isDefined(noxp)) {
      noxp = 0;
    }

    self.pers[#"killstreak_has_been_used"][self.pers[#"killstreak_has_been_used"].size] = noxp;
    weapon = get_killstreak_weapon(killstreaktype);
    ammocount = give_weapon(weapon, 1);
    self.pers[#"killstreak_ammo_count"][self.pers[#"killstreak_ammo_count"].size] = ammocount;

    if(var_7b935486) {
      var_3522232f = self.pers[#"killstreaks"].size - 2;
      var_a1312679 = self.pers[#"killstreaks"].size - 1;
      var_3197d2aa = self.pers[#"killstreaks"][var_3522232f];
      var_c72e250a = self.pers[#"killstreak_unique_id"][var_3522232f];
      var_948e9ad0 = self.pers[#"killstreak_has_been_used"][var_3522232f];
      var_80931fe9 = self.pers[#"killstreak_ammo_count"][var_3522232f];
      self.pers[#"killstreaks"][var_3522232f] = self.pers[#"killstreaks"][var_a1312679];
      self.pers[#"killstreak_unique_id"][var_3522232f] = self.pers[#"killstreak_unique_id"][var_a1312679];
      self.pers[#"killstreak_has_been_used"][var_3522232f] = self.pers[#"killstreak_has_been_used"][var_a1312679];
      self.pers[#"killstreak_ammo_count"][var_3522232f] = self.pers[#"killstreak_ammo_count"][var_a1312679];
      self.pers[#"killstreaks"][var_a1312679] = var_3197d2aa;
      self.pers[#"killstreak_unique_id"][var_a1312679] = var_c72e250a;
      self.pers[#"killstreak_has_been_used"][var_a1312679] = var_948e9ad0;
      self.pers[#"killstreak_ammo_count"][var_a1312679] = var_80931fe9;
      self setinventoryweapon(get_killstreak_weapon(var_3197d2aa));
    }
  }

  self.just_given_new_inventory_killstreak = killstreaktype !== just_max_stack_removed_inventory_killstreak && !(isDefined(var_7b935486) && var_7b935486);

  if(!isDefined(self.var_58d669ff)) {
    self.var_58d669ff = [];
  }

  if(!isDefined(self.var_58d669ff[killstreaktype])) {
    self.var_58d669ff[killstreaktype] = [];
  }

  array::push(self.var_58d669ff[killstreaktype], gettime(), self.var_58d669ff[killstreaktype].size);
  return true;
}

add_to_notification_queue(menuname, streakcount, hardpointtype, nonotify, var_af825242) {
  killstreaktablenumber = level.killstreakindices[menuname];

  if(!isDefined(killstreaktablenumber)) {
    return;
  }

  if(isDefined(nonotify) && nonotify) {
    return;
  }

  informdialog = get_killstreak_inform_dialog(hardpointtype);
  self thread play_killstreak_ready_dialog(hardpointtype, 2.4);
  self thread play_killstreak_ready_sfx(hardpointtype);
  self luinotifyevent(#"killstreak_received", 3, killstreaktablenumber, informdialog, var_af825242);
  self function_b552ffa9(#"killstreak_received", 3, killstreaktablenumber, informdialog, var_af825242);
}

has_equipped() {
  currentweapon = self getcurrentweapon();
  keys = getarraykeys(level.killstreaks);

  for(i = 0; i < keys.size; i++) {
    if(level.killstreaks[keys[i]].weapon == currentweapon) {
      return true;
    }
  }

  return false;
}

_get_from_weapon(weapon) {
  return get_killstreak_for_weapon(weapon);
}

get_from_weapon(weapon) {
  if(weapon == level.weaponnone) {
    return undefined;
  }

  res = _get_from_weapon(weapon);

  if(!isDefined(res)) {
    return _get_from_weapon(weapon.rootweapon);
  }

  return res;
}

give_weapon(weapon, isinventory, usestoredammo) {
  currentweapon = self getcurrentweapon();

  if(currentweapon != level.weaponnone && !(isDefined(level.usingmomentum) && level.usingmomentum)) {
    weaponslist = self getweaponslist();

    for(idx = 0; idx < weaponslist.size; idx++) {
      carriedweapon = weaponslist[idx];

      if(currentweapon == carriedweapon) {
        continue;
      }

      switch (carriedweapon.name) {
        case #"m32":
        case #"minigun":
          continue;
      }

      if(is_killstreak_weapon(carriedweapon)) {
        self takeweapon(carriedweapon);
      }
    }
  }

  if(currentweapon != weapon && self hasweapon(weapon) == 0) {
    self takeweapon(weapon);
    self giveweapon(weapon);
  }

  if(isDefined(level.usingmomentum) && level.usingmomentum) {
    self setinventoryweapon(weapon);

    if(weapon.iscarriedkillstreak) {
      if(!isDefined(self.pers[#"held_killstreak_ammo_count"][weapon])) {
        self.pers[#"held_killstreak_ammo_count"][weapon] = 0;
      }

      if(!isDefined(self.pers[#"held_killstreak_clip_count"][weapon])) {
        self.pers[#"held_killstreak_clip_count"][weapon] = weapon.clipsize;
      }

      if(!isDefined(self.pers[#"killstreak_quantity"][weapon])) {
        self.pers[#"killstreak_quantity"][weapon] = 0;
      }

      if(currentweapon == weapon && !isheldinventorykillstreakweapon(weapon)) {
        return weapon.maxammo;
      } else if(isDefined(usestoredammo) && usestoredammo && self.pers[#"killstreak_ammo_count"][self.pers[#"killstreak_ammo_count"].size - 1] > 0) {
        switch (weapon.name) {
          case #"inventory_minigun":
            if(isDefined(self.minigunactive) && self.minigunactive) {
              return self.pers[#"held_killstreak_ammo_count"][weapon];
            }

            break;
          case #"inventory_m32":
            if(isDefined(self.m32active) && self.m32active) {
              return self.pers[#"held_killstreak_ammo_count"][weapon];
            }

            break;
          default:
            break;
        }

        self.pers[#"held_killstreak_ammo_count"][weapon] = self.pers[#"killstreak_ammo_count"][self.pers[#"killstreak_ammo_count"].size - 1];
        self loadout::function_3ba6ee5d(weapon, self.pers[#"killstreak_ammo_count"][self.pers[#"killstreak_ammo_count"].size - 1]);
      } else {
        self.pers[#"held_killstreak_ammo_count"][weapon] = weapon.maxammo;
        self.pers[#"held_killstreak_clip_count"][weapon] = weapon.clipsize;
        self loadout::function_3ba6ee5d(weapon, self.pers[#"held_killstreak_ammo_count"][weapon]);
      }

      return self.pers[#"held_killstreak_ammo_count"][weapon];
    } else {
      switch (weapon.statname) {
        case #"dart":
        case #"ultimate_turret":
        case #"counteruav":
        case #"combat_robot_marker":
        case #"remote_missile":
        case #"swat_team":
        case #"supplydrop_marker":
        case #"m32_drop":
        case #"drone_squadron":
        case #"overwatch_helicopter":
        case #"straferun":
        case #"recon_car":
        case #"uav":
        case #"ac130":
        case #"helicopter_comlink":
        case #"swat_helicopter":
        case #"ai_tank_marker":
        case #"planemortar":
        case #"minigun_drop":
        case #"missile_drone":
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

activate_next(do_not_update_death_count) {
  if(level.gameended) {
    return false;
  }

  if(isDefined(level.usingmomentum) && level.usingmomentum) {
    self setinventoryweapon(level.weaponnone);
  } else {
    self setactionslot(4, "");
  }

  if(!isDefined(self.pers[#"killstreaks"]) || self.pers[#"killstreaks"].size == 0) {
    return false;
  }

  killstreaktype = self.pers[#"killstreaks"][self.pers[#"killstreaks"].size - 1];

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

  ammocount = give_weapon(weapon, 0, 1);

  if(weapon.iscarriedkillstreak) {
    self setweaponammoclip(weapon, self.pers[#"held_killstreak_clip_count"][weapon]);
    self setweaponammostock(weapon, ammocount - self.pers[#"held_killstreak_clip_count"][weapon]);
  }

  if(!isDefined(do_not_update_death_count) || do_not_update_death_count != 0) {
    self.pers["killstreakItemDeathCount" + killstreaktype] = self.deathcount;
  }

  return true;
}

give_owned() {
  if(!isDefined(self.pers[#"killstreaks"])) {
    self.pers[#"killstreaks"] = [];
  }

  if(!isDefined(self.pers[#"killstreak_has_been_used"])) {
    self.pers[#"killstreak_has_been_used"] = [];
  }

  if(!isDefined(self.pers[#"killstreak_unique_id"])) {
    self.pers[#"killstreak_unique_id"] = [];
  }

  if(!isDefined(self.pers[#"killstreak_ammo_count"])) {
    self.pers[#"killstreak_ammo_count"] = [];
  }

  if(self.pers[#"killstreaks"].size > 0) {
    self activate_next(0);
  }

  size = self.pers[#"killstreaks"].size;

  if(size > 0) {
    self thread play_killstreak_ready_dialog(self.pers[#"killstreaks"][size - 1]);
  }

  self.lastnonkillstreakweapon = isDefined(self.currentweapon) ? self.currentweapon : level.weaponnone;

  if(self.lastnonkillstreakweapon == level.weaponnone) {
    weapons = self getweaponslistprimaries();

    if(weapons.size > 0) {
      self.lastnonkillstreakweapon = weapons[0];
      return;
    }

    self.lastnonkillstreakweapon = level.weaponbasemelee;
  }
}

get_killstreak_quantity(killstreakweapon) {
  if(!isDefined(self.pers[#"killstreak_quantity"])) {
    return 0;
  }

  return isDefined(self.pers[#"killstreak_quantity"][killstreakweapon]) ? self.pers[#"killstreak_quantity"][killstreakweapon] : 0;
}

change_killstreak_quantity(killstreakweapon, delta) {
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

  self.pers[#"killstreak_quantity"][killstreakweapon] = quantity;
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

function_1f96e8f8(killstreakweapon) {
  quantity = get_killstreak_quantity(killstreakweapon);

  if(quantity > level.scorestreaksmaxstacking) {
    quantity = level.scorestreaksmaxstacking;
  }

  if(self hasweapon(killstreakweapon) == 0) {
    self takeweapon(killstreakweapon);
    self giveweapon(killstreakweapon);
    self seteverhadweaponall(1);
  }

  self setweaponammoclip(killstreakweapon, quantity);
  return quantity;
}

has_killstreak_in_class(killstreakmenuname) {
  foreach(equippedkillstreak in self.killstreak) {
    if(equippedkillstreak == killstreakmenuname) {
      return true;
    }
  }

  return false;
}

has_killstreak(killstreak) {
  player = self;

  if(!isDefined(killstreak) || !isDefined(player.pers[#"killstreaks"])) {
    return false;
  }

  for(i = 0; i < self.pers[#"killstreaks"].size; i++) {
    if(player.pers[#"killstreaks"][i] == killstreak) {
      return true;
    }
  }

  return false;
}

recordkillstreakbegindirect(killstreak, recordstreakindex) {
  player = self;

  if(!isplayer(player) || !isDefined(recordstreakindex)) {
    return;
  }

  if(!isDefined(self.killstreakevents)) {
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

remove_when_done(killstreak, haskillstreakbeenused, isfrominventory) {
  self endon(#"disconnect");
  waitresult = self waittill(#"killstreak_done");
  killstreaktype = waitresult.kstype;

  if(waitresult.is_successful) {

    print("<dev string:x43a>" + get_menu_name(killstreak));

      killstreak_weapon = get_killstreak_weapon(killstreak);
    recordstreakindex = undefined;
    var_d86010cb = get_killstreak_for_weapon_for_stats(killstreak_weapon);

    if(isDefined(level.killstreaks[var_d86010cb].menuname)) {
      recordstreakindex = level.killstreakindices[level.killstreaks[var_d86010cb].menuname];
      self recordkillstreakbegindirect(killstreak, recordstreakindex);
    }

    if(isDefined(level.usingscorestreaks) && level.usingscorestreaks) {
      var_ad8ae78f = {
        #gametime: function_f8d53445(), 
        #killstreak: killstreak, 
        #activatedby: getplayerspawnid(self)
      };
      function_92d1707f(#"hash_1aa07f199266e0c7", var_ad8ae78f);

      if(isDefined(isfrominventory) && isfrominventory) {
        remove_used_killstreak(killstreak);

        if(self getinventoryweapon() == killstreak_weapon) {
          self setinventoryweapon(level.weaponnone);
        }
      } else {
        self change_killstreak_quantity(killstreak_weapon, -1);
      }
    } else if(isDefined(level.usingmomentum) && level.usingmomentum) {
      if(isDefined(isfrominventory) && isfrominventory && self getinventoryweapon() == killstreak_weapon) {
        remove_used_killstreak(killstreak);
        self setinventoryweapon(level.weaponnone);
      } else if(isDefined(level.var_b0dc03c7)) {
        self[[level.var_b0dc03c7]](killstreaktype);
      }
    } else {
      remove_used_killstreak(killstreak);
    }

    if(!(isDefined(level.usingmomentum) && level.usingmomentum)) {
      self setactionslot(4, "");
    }

    success = 1;
  } else {
    killstreak_weapon = get_killstreak_weapon(killstreak);
    self function_1f96e8f8(killstreak_weapon);
  }

  waittillframeend();
  self unhide_compass();
  killstreak_weapon = get_killstreak_weapon(killstreaktype);

  if(killstreak_weapon.isgestureweapon) {
    if((!(isDefined(level.usingmomentum) && level.usingmomentum) || isDefined(isfrominventory) && isfrominventory) && waitresult.is_successful) {
      activate_next();
    }

    return;
  }

  currentweapon = self getcurrentweapon();

  if(currentweapon == killstreak_weapon && killstreak_weapon.iscarriedkillstreak) {
    return;
  }

  if(waitresult.is_successful && (!self has_killstreak_in_class(get_menu_name(killstreak)) || isDefined(isfrominventory) && isfrominventory)) {
    switch_to_last_non_killstreak_weapon();
  } else {
    killstreakforcurrentweapon = get_from_weapon(currentweapon);

    if(currentweapon.isgameplayweapon) {
      if(isDefined(self.isplanting) && self.isplanting || isDefined(self.isdefusing) && self.isdefusing) {
        return;
      }
    }

    if(!isDefined(killstreakforcurrentweapon) && isDefined(currentweapon)) {
      return;
    }

    if(waitresult.is_successful || !isDefined(killstreakforcurrentweapon) || killstreakforcurrentweapon == killstreak || killstreakforcurrentweapon == "inventory_" + killstreak) {
      switch_to_last_non_killstreak_weapon();
    }
  }

  if((!(isDefined(level.usingmomentum) && level.usingmomentum) || isDefined(isfrominventory) && isfrominventory) && waitresult.is_successful) {
    activate_next();
  }
}

usekillstreak(killstreak, isfrominventory) {
  haskillstreakbeenused = get_if_top_killstreak_has_been_used();

  if(isDefined(self.selectinglocation)) {
    return;
  }

  if(isDefined(self.drone)) {
    [[level.killstreaks[killstreak].usefunction]](killstreak);
    return;
  }

  self thread remove_when_done(killstreak, haskillstreakbeenused, isfrominventory);
  self thread trigger_killstreak(killstreak, isfrominventory);
}

function_2ea0382e() {
  self.pers[#"killstreaks"] = [];
  self.pers[#"killstreak_has_been_used"] = [];
  self.pers[#"killstreak_unique_id"] = [];
  self.pers[#"killstreak_ammo_count"] = [];
}

remove_used_killstreak(killstreak, killstreakid, take_weapon_after_use = 1) {
  self.just_removed_used_killstreak = undefined;

  if(!isDefined(self.pers[#"killstreaks"])) {
    return;
  }

  killstreakindex = undefined;

  for(i = self.pers[#"killstreaks"].size - 1; i >= 0; i--) {
    if(self.pers[#"killstreaks"][i] == killstreak) {
      if(isDefined(killstreakid) && self.pers[#"killstreak_unique_id"][i] != killstreakid) {
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

  arraysize = self.pers[#"killstreaks"].size;

  for(i = killstreakindex; i < arraysize - 1; i++) {
    self.pers[#"killstreaks"][i] = self.pers[#"killstreaks"][i + 1];
    self.pers[#"killstreak_has_been_used"][i] = self.pers[#"killstreak_has_been_used"][i + 1];
    self.pers[#"killstreak_unique_id"][i] = self.pers[#"killstreak_unique_id"][i + 1];
    self.pers[#"killstreak_ammo_count"][i] = self.pers[#"killstreak_ammo_count"][i + 1];
  }

  self.pers[#"killstreaks"][arraysize - 1] = undefined;
  self.pers[#"killstreak_has_been_used"][arraysize - 1] = undefined;
  self.pers[#"killstreak_unique_id"][arraysize - 1] = undefined;
  self.pers[#"killstreak_ammo_count"][arraysize - 1] = undefined;
  return 1;
}

take_weapon_after_use(killstreakweapon) {
  self endon(#"disconnect", #"death", #"joined_team", #"joined_spectators");
  self waittill(#"weapon_change");
  inventoryweapon = self getinventoryweapon();

  if(inventoryweapon != killstreakweapon) {
    self takeweapon(killstreakweapon);
  }

  self.killstreakactivated = 1;
}

get_top_killstreak() {
  if(self.pers[#"killstreaks"].size == 0) {
    return undefined;
  }

  return self.pers[#"killstreaks"][self.pers[#"killstreaks"].size - 1];
}

get_if_top_killstreak_has_been_used() {
  if(!(isDefined(level.usingmomentum) && level.usingmomentum)) {
    if(self.pers[#"killstreak_has_been_used"].size == 0) {
      return undefined;
    }

    return self.pers[#"killstreak_has_been_used"][self.pers[#"killstreak_has_been_used"].size - 1];
  }
}

get_top_killstreak_unique_id() {
  if(self.pers[#"killstreak_unique_id"].size == 0) {
    return undefined;
  }

  return self.pers[#"killstreak_unique_id"][self.pers[#"killstreak_unique_id"].size - 1];
}

get_killstreak_index_by_id(killstreakid) {
  for(index = self.pers[#"killstreak_unique_id"].size - 1; index >= 0; index--) {
    if(self.pers[#"killstreak_unique_id"][index] == killstreakid) {
      return index;
    }
  }

  return undefined;
}

get_killstreak_momentum_cost(player, killstreak) {
  if(!(isDefined(level.usingmomentum) && level.usingmomentum)) {
    return 0;
  }

  if(!isDefined(killstreak) || !isDefined(player) || !isplayer(player)) {
    return 0;
  }

  assert(isDefined(level.killstreaks[killstreak]));
  return player function_dceb5542(level.killstreaks[killstreak].itemindex);
}

get_killstreak_for_weapon_for_stats(weapon) {
  prefix = "inventory_";
  killstreak = get_killstreak_for_weapon(weapon);

  if(isDefined(killstreak)) {
    if(strstartswith(killstreak, prefix)) {
      killstreak = getsubstr(killstreak, prefix.size);
    }
  }

  return killstreak;
}

get_killstreak_team_kill_penalty_scale(weapon) {
  killstreak = get_killstreak_for_weapon(weapon);

  if(!isDefined(killstreak)) {
    return 1;
  }

  return isDefined(level.killstreaks[killstreak].teamkillpenaltyscale) ? level.killstreaks[killstreak].teamkillpenaltyscale : 1;
}

wait_till_heavy_weapon_is_fully_on(weapon) {
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

function_4f415d8e(params) {
  if(game.state == "postgame" || !isDefined(self)) {
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

  self.lastnonkillstreakweapon = weapon;
}

function_1e9a761c(timeout, timeoutcallback, endcondition1, endcondition2, endcondition3) {
  waitframe(1);
  placeable = self;
  placeable thread waitfortimeout(placeable.killstreakref, timeout, timeoutcallback, endcondition1, endcondition2);
}

function_4167ea4e(params) {
  weapon = params.weapon;

  if(!is_killstreak_weapon(weapon)) {
    return;
  }

  if(function_f479a2ff(weapon)) {
    return;
  }

  killstreak = get_killstreak_for_weapon(weapon);

  if(isDefined(level.forceusekillstreak) && level.forceusekillstreak) {
    thread usekillstreak(killstreak, undefined);
    return;
  }

  if(!(isDefined(level.usingmomentum) && level.usingmomentum)) {
    killstreak = get_top_killstreak();

    if(weapon != get_killstreak_weapon(killstreak)) {
      return;
    }
  }

  if(is_remote_override_weapon(killstreak, weapon)) {
    return;
  }

  waittillframeend();

  if(isDefined(self.usingkillstreakheldweapon) && self.usingkillstreakheldweapon && weapon.iscarriedkillstreak) {
    return;
  }

  isfrominventory = undefined;

  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks) {
    if(weapon == self getinventoryweapon()) {
      isfrominventory = 1;
    } else if(self getammocount(weapon) <= 0 && weapon.name != "killstreak_ai_tank") {
      self switch_to_last_non_killstreak_weapon();
      return;
    }
  } else if(isDefined(level.usingmomentum) && level.usingmomentum) {
    if(weapon == self getinventoryweapon()) {
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

on_grenade_fired(params) {
  grenade = params.projectile;
  grenadeweaponid = params.weapon;

  if(grenadeweaponid == level.var_239dc073) {
    return;
  }

  if(grenadeweaponid.inventorytype === "offhand") {
    if(is_killstreak_weapon(grenadeweaponid)) {
      killstreak = get_killstreak_for_weapon(grenadeweaponid);
      isfrominventory = grenadeweaponid == self getinventoryweapon();
      thread usekillstreak(killstreak, isfrominventory);
    }
  }
}

on_offhand_fire(params) {
  grenadeweaponid = params.weapon;

  if(grenadeweaponid == level.var_239dc073) {
    return;
  }

  if(is_killstreak_weapon(grenadeweaponid)) {
    killstreak = get_killstreak_for_weapon(grenadeweaponid);
    isfrominventory = grenadeweaponid == self getinventoryweapon();
    thread usekillstreak(killstreak, isfrominventory);
  }
}

should_delay_killstreak(killstreaktype) {
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

is_delayable_killstreak(killstreaktype) {
  if(isDefined(level.killstreaks[killstreaktype]) && isDefined(level.killstreaks[killstreaktype].delaystreak) && level.killstreaks[killstreaktype].delaystreak) {
    return true;
  }

  return false;
}

get_xp_amount_for_killstreak(killstreaktype) {
  xpamount = 0;

  switch (level.killstreaks[killstreaktype].killstreaklevel) {
    case 1:
    case 2:
    case 3:
    case 4:
      xpamount = 100;
      break;
    case 5:
      xpamount = 150;
      break;
    case 6:
    case 7:
      xpamount = 200;
      break;
    case 8:
      xpamount = 250;
      break;
    case 9:
      xpamount = 300;
      break;
    case 10:
    case 11:
      xpamount = 350;
      break;
    case 12:
    case 13:
    case 14:
    case 15:
      xpamount = 500;
      break;
  }

  return xpamount;
}

display_unavailable_time() {
  timepassed = float([[level.gettimepassed]]()) / 1000;
  timeleft = int(level.roundstartkillstreakdelay - timepassed);

  if(timeleft <= 0) {
    timeleft = 1;
  }

  self iprintlnbold(#"hash_55a79f95e07a10bc", " " + timeleft + " ", #"hash_79a58948c3b976f5");
}

trigger_killstreak(killstreaktype, isfrominventory) {
  assert(isDefined(level.killstreaks[killstreaktype].usefunction), "<dev string:x114>" + killstreaktype);
  self.usingkillstreakfrominventory = isfrominventory;

  if(isDefined(level.infinalkillcam) && level.infinalkillcam) {
    return false;
  }

  if(should_delay_killstreak(killstreaktype)) {
    display_unavailable_time();
  } else {
    success = [[level.killstreaks[killstreaktype].usefunction]](killstreaktype);

    if(isDefined(success) && success) {
      if(isDefined(self)) {
        if(sessionmodeismultiplayergame()) {}

        if(!isDefined(self.pers[level.killstreaks[killstreaktype].usagekey])) {
          self.pers[level.killstreaks[killstreaktype].usagekey] = 0;
        }

        self.pers[level.killstreaks[killstreaktype].usagekey]++;
        self notify(#"killstreak_used", killstreaktype);
        self notify(#"killstreak_done", {
          #is_successful: 1, 
          #kstype: killstreaktype
        });
        self.usingkillstreakfrominventory = undefined;
      }

      return true;
    }
  }

  if(isDefined(self)) {
    self.usingkillstreakfrominventory = undefined;
    self notify(#"killstreak_done", {
      #is_successful: 0, 
      #kstype: killstreaktype
    });
  }

  return false;
}

add_to_killstreak_count(weapon) {
  if(!isDefined(self.pers[#"totalkillstreakcount"])) {
    self.pers[#"totalkillstreakcount"] = 0;
  }

  self.pers[#"totalkillstreakcount"]++;
}

get_first_valid_killstreak_alt_weapon(killstreaktype) {
  assert(isDefined(level.killstreaks[killstreaktype]), "<dev string:x449>");

  if(isDefined(level.killstreaks[killstreaktype].altweapons)) {
    for(i = 0; i < level.killstreaks[killstreaktype].altweapons.size; i++) {
      if(isDefined(level.killstreaks[killstreaktype].altweapons[i])) {
        return level.killstreaks[killstreaktype].altweapons[i];
      }
    }
  }

  return level.weaponnone;
}

should_give_killstreak(weapon) {
  killstreakbuilding = getdvarint(#"scr_allow_killstreak_building", 0);
  rootweapon = isDefined(weapon) && isDefined(weapon.rootweapon) ? weapon.rootweapon : weapon;

  if(killstreakbuilding == 0) {
    if(is_weapon_associated_with_killstreak(rootweapon)) {
      return false;
    }
  }

  return true;
}

point_is_in_danger_area(point, targetpos, radius) {
  return distance2d(point, targetpos) <= radius * 1.25;
}

print_killstreak_start_text(killstreaktype, owner, team, targetpos, dangerradius) {
  if(!isDefined(level.killstreaks[killstreaktype])) {
    return;
  }

  if(level.teambased) {
    players = level.players;

    if(!level.hardcoremode && isDefined(level.killstreaks[killstreaktype].inboundnearplayertext)) {
      for(i = 0; i < players.size; i++) {
        if(isalive(players[i]) && isDefined(players[i].pers[#"team"]) && players[i].pers[#"team"] == team) {
          if(point_is_in_danger_area(players[i].origin, targetpos, dangerradius)) {
            players[i] iprintlnbold(level.killstreaks[killstreaktype].inboundnearplayertext);
          }
        }
      }
    }

    if(isDefined(level.killstreaks[killstreaktype])) {
      for(i = 0; i < level.players.size; i++) {
        player = level.players[i];
        playerteam = player.pers[#"team"];

        if(isDefined(playerteam)) {
          if(playerteam == team) {
            player iprintln(level.killstreaks[killstreaktype].inboundtext, owner);
          }
        }
      }
    }

    return;
  }

  if(!level.hardcoremode && isDefined(level.killstreaks[killstreaktype].inboundnearplayertext)) {
    if(point_is_in_danger_area(owner.origin, targetpos, dangerradius)) {
      owner iprintlnbold(level.killstreaks[killstreaktype].inboundnearplayertext);
    }
  }
}

play_killstreak_ready_sfx(killstreaktype) {
  if(!isDefined(level.gameended) || !level.gameended) {
    switch (killstreaktype) {
      case #"uav":
        var_426d4c5d = "uin_kls_uav";
        break;
      case #"counteruav":
        var_426d4c5d = "uin_kls_counteruav";
        break;
      case #"remote_missile":
        var_426d4c5d = "uin_kls_remote_missile";
        break;
      case #"ultimate_turret":
        var_426d4c5d = "uin_kls_ultimate_turret";
        break;
      case #"helicopter_comlink":
        var_426d4c5d = "uin_kls_helicopter_comlink";
        break;
      case #"tank_robot":
        var_426d4c5d = "uin_kls_tank_robot";
        break;
      case #"swat_team":
        var_426d4c5d = "uin_kls_swat_team";
        break;
      case #"ac130":
        var_426d4c5d = "uin_kls_ac130";
        break;
      case #"recon_car":
        var_426d4c5d = "uin_kls_rcbomb";
        break;
      case #"supply_drop":
        var_426d4c5d = "uin_kls_supply_drop";
        break;
      case #"planemortar":
        var_426d4c5d = "uin_kls_airstrike";
        break;
      case #"straferun":
        var_426d4c5d = "uin_kls_straferun";
        break;
    }

    if(isDefined(var_426d4c5d)) {
      self playsoundtoplayer(var_426d4c5d, self);
      return;
    }

    self playsoundtoplayer("uin_kls_generic", self);
  }
}

killstreak_dialog_queued(dialogkey, killstreaktype, killstreakid) {
  if(!isDefined(dialogkey) || !isDefined(killstreaktype)) {
    return;
  }

  if(isDefined(self.currentkillstreakdialog)) {
    if(dialogkey === self.currentkillstreakdialog.dialogkey && killstreaktype === self.currentkillstreakdialog.killstreaktype && killstreakid === self.currentkillstreakdialog.killstreakid) {
      return 1;
    }
  }

  for(i = 0; i < self.killstreakdialogqueue.size; i++) {
    if(dialogkey === self.killstreakdialogqueue[i].dialogkey && killstreaktype === self.killstreakdialogqueue[i].killstreaktype && killstreaktype === self.killstreakdialogqueue[i].killstreaktype) {
      return 1;
    }
  }

  return 0;
}

play_killstreak_ready_dialog(killstreaktype, taacomwaittime) {
  self notify("killstreak_ready_" + killstreaktype);
  self endon(#"death", "killstreak_start_" + killstreaktype, "killstreak_ready_" + killstreaktype);
  level endon(#"game_ended");

  if(isDefined(level.gameended) && level.gameended) {
    return;
  }

  if(killstreak_dialog_queued("ready", killstreaktype)) {
    return;
  }

  if(isDefined(taacomwaittime)) {
    wait taacomwaittime;
  }

  self play_taacom_dialog("ready", killstreaktype);
}

play_taacom_dialog_on_owner(dialogkey, killstreaktype, killstreakid) {
  if(!isDefined(self.owner) || !isDefined(self.team) || self.team != self.owner.team) {
    return;
  }

  self.owner play_taacom_dialog(dialogkey, killstreaktype, killstreakid);
}

play_taacom_dialog_response(dialogkey, killstreaktype, killstreakid, pilotindex) {
  assert(isDefined(dialogkey));
  assert(isDefined(killstreaktype));

  if(!isDefined(pilotindex)) {
    return;
  }

  self play_taacom_dialog(dialogkey + pilotindex, killstreaktype, killstreakid);
}

player_killstreak_threat_tracking(killstreaktype) {
  assert(isDefined(killstreaktype));
  self endon(#"death", #"delete", #"leaving");
  level endon(#"game_ended");

  while(true) {
    if(!isDefined(self.owner)) {
      return;
    }

    players = self.owner dialog_shared::get_enemy_players();
    players = array::randomize(players);

    foreach(player in players) {
      if(!player dialog_shared::can_play_dialog(1)) {
        continue;
      }

      lookangles = player getplayerangles();

      if(lookangles[0] < 270 || lookangles[0] > 330) {
        continue;
      }

      lookdir = anglesToForward(lookangles);
      eyepoint = player getEye();
      streakdir = vectornormalize(self.origin - eyepoint);
      dot = vectordot(streakdir, lookdir);

      if(dot < 0.94) {
        continue;
      }

      traceresult = bulletTrace(eyepoint, self.origin, 1, player);

      if(traceresult[#"fraction"] >= 1 || traceresult[#"entity"] === self) {
        if(dialog_shared::dialog_chance("killstreakSpotChance")) {
          player dialog_shared::play_killstreak_threat(killstreaktype);
        }

        wait dialog_shared::mpdialog_value("killstreakSpotDelay", 0);
        break;
      }
    }

    wait dialog_shared::mpdialog_value("killstreakSpotInterval", float(function_60d95f53()) / 1000);
  }
}

get_killstreak_inform_dialog(killstreaktype) {
  if(isDefined(level.killstreaks[killstreaktype].informdialog)) {
    return level.killstreaks[killstreaktype].informdialog;
  }

  return "";
}

get_killstreak_usage_by_killstreak(killstreaktype) {
  assert(isDefined(level.killstreaks[killstreaktype]), "<dev string:x466>");
  return get_killstreak_usage(level.killstreaks[killstreaktype].usagekey);
}

get_killstreak_usage(usagekey) {
  if(!isDefined(self.pers[usagekey])) {
    return 0;
  }

  return self.pers[usagekey];
}

on_player_spawned() {
  profilestart();
  pixbeginevent(#"hash_1d81325f0403ec55");
  self thread give_owned();
  self.killcamkilledbyent = undefined;
  self callback::on_weapon_change(&function_4f415d8e);
  self callback::on_weapon_change(&function_4167ea4e);
  self callback::on_grenade_fired(&on_grenade_fired);
  self callback::on_offhand_fire(&on_offhand_fire);
  self thread initialspawnprotection();
  pixendevent();
  profilestop();
}

on_joined_team(params) {
  self endon(#"disconnect");
  self setinventoryweapon(level.weaponnone);
  self.pers[#"cur_kill_streak"] = 0;
  self.pers[#"cur_total_kill_streak"] = 0;
  self setplayercurrentstreak(0);
  self.pers[#"totalkillstreakcount"] = 0;
  self.pers[#"killstreaks"] = [];
  self.pers[#"killstreak_has_been_used"] = [];
  self.pers[#"killstreak_unique_id"] = [];
  self.pers[#"killstreak_ammo_count"] = [];

  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks) {
    self.pers[#"killstreak_quantity"] = [];
    self.pers[#"held_killstreak_ammo_count"] = [];
    self.pers[#"held_killstreak_clip_count"] = [];
  }
}

private initialspawnprotection() {
  self endon(#"death", #"disconnect");
  self thread airsupport::monitorspeed(level.spawnprotectiontime);

  if(!isDefined(level.spawnprotectiontime) || level.spawnprotectiontime == 0) {
    return;
  }

  self.specialty_nottargetedbyairsupport = 1;
  self clientfield::set("killstreak_spawn_protection", 1);
  self val::set(#"killstreak_spawn_protection", "ignoreme", 1);
  wait level.spawnprotectiontime;
  self clientfield::set("killstreak_spawn_protection", 0);
  self.specialty_nottargetedbyairsupport = undefined;
  self val::reset(#"killstreak_spawn_protection", "ignoreme");
}

killstreak_debug_think() {
  setdvar(#"debug_killstreak", "<dev string:x74>");

  for(;;) {
    cmd = getdvarstring(#"debug_killstreak");

    switch (cmd) {
      case #"data_dump":
        killstreak_data_dump();
        break;
    }

    if(cmd != "<dev string:x74>") {
      setdvar(#"debug_killstreak", "<dev string:x74>");
    }

    wait 0.5;
  }
}

killstreak_data_dump() {
  iprintln("<dev string:x4af>");
  println("<dev string:x4d1>");
  println("<dev string:x4ef>");
  keys = getarraykeys(level.killstreaks);

  for(i = 0; i < keys.size; i++) {
    data = level.killstreaks[keys[i]];
    type_data = level.killstreaktype[keys[i]];
    print(keys[i] + "<dev string:x557>");
    print(data.killstreaklevel + "<dev string:x557>");
    print(data.weapon.name + "<dev string:x557>");
    alt = 0;

    if(isDefined(data.altweapons)) {
      assert(data.altweapons.size <= 4);

      for(alt = 0; alt < data.altweapons.size; alt++) {
        print(data.altweapons[alt].name + "<dev string:x557>");
      }
    }

    while(alt < 4) {
      print("<dev string:x557>");
      alt++;
    }

    type = 0;

    if(isDefined(type_data)) {
      assert(type_data.size < 4);
      type_keys = getarraykeys(type_data);

      while(type < type_keys.size) {
        if(type_data[type_keys[type]] == 1) {
          print(type_keys[type] + "<dev string:x557>");
        }

        type++;
      }
    }

    while(type < 4) {
      print("<dev string:x557>");
      type++;
    }

    println("<dev string:x74>");
  }

  println("<dev string:x55b>");
}

  function function_2b6aa9e8(killstreak_ref, destroyed_callback, low_health_callback, emp_callback) {
    self setCanDamage(1);
    self thread monitordamage(killstreak_ref, killstreak_bundles::get_max_health(killstreak_ref), destroyed_callback, killstreak_bundles::get_low_health(killstreak_ref), low_health_callback, 0, emp_callback, 1);
  }

monitordamage(killstreak_ref, max_health, destroyed_callback, low_health, low_health_callback, emp_damage, emp_callback, allow_bullet_damage) {
  self endon(#"death", #"delete");
  self setCanDamage(1);
  self setup_health(killstreak_ref, max_health, low_health);
  self.health = self.maxhealth;
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

    if(isDefined(self.invulnerable) && self.invulnerable) {
      continue;
    }

    if(!isDefined(attacker) || !isplayer(attacker)) {
      continue;
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
      damage = [
        [self.killstreakdamagemodifier]
      ](damage, attacker, direction, point, type, tagname, modelname, partname, weapon, flags, inflictor, chargelevel);

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

    if(isDefined(self.selfdestruct) && self.selfdestruct) {
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
    }

    self.damagetaken += weapon_damage;

    if(!issentient(self) && weapon_damage > 0) {
      self.attacker = attacker;
    }

    if(self.damagetaken > self.maxhealth) {
      level.globalkillstreaksdestroyed++;
      attacker stats::function_e24eec31(getweapon(killstreak_ref), #"destroyed", 1);
      self function_73566ec7(attacker, weapon, self.owner);

      if(isDefined(destroyed_callback)) {
        self thread[[destroyed_callback]](attacker, weapon);
      }

      return;
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

function_73566ec7(attacker, weapon, owner) {
  if(!isDefined(self) || isDefined(self.var_c5bb583d) && self.var_c5bb583d || !isDefined(attacker) || !isplayer(attacker) || !isDefined(self.killstreaktype) || self.team === attacker.team) {
    return;
  }

  bundle = level.killstreakbundle[self.killstreaktype];

  if(isDefined(bundle) && isDefined(bundle.var_ebd92bbc)) {
    scoreevents::processscoreevent(bundle.var_ebd92bbc, attacker, owner, weapon);
    attacker stats::function_dad108fa(#"stats_destructions", 1);
    attacker contracts::increment_contract(#"hash_317a8b8df3aa8838");
    self.var_c5bb583d = 1;

    if(isDefined(self.attackers) && self.attackers.size > 0) {
      maxhealth = 1 / self.maxhealth;

      if(!isDefined(bundle.var_74711af9)) {
        return;
      }

      foreach(assister in self.attackers) {
        if(assister == attacker || !isplayer(assister) || !util::function_fbce7263(self.team, assister.team)) {
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

ondamageperweapon(killstreak_ref, attacker, damage, flags, type, weapon, max_health, destroyed_callback, low_health, low_health_callback, emp_damage, emp_callback, allow_bullet_damage, chargelevel, var_488beb6d) {
  self.maxhealth = max_health;
  self.lowhealth = low_health;
  tablehealth = killstreak_bundles::get_max_health(killstreak_ref);

  if(isDefined(tablehealth)) {
    self.maxhealth = tablehealth;
  }

  tablehealth = killstreak_bundles::get_low_health(killstreak_ref);

  if(isDefined(tablehealth)) {
    self.lowhealth = tablehealth;
  }

  if(isDefined(self.invulnerable) && self.invulnerable) {
    return 0;
  }

  if(!isDefined(attacker) || !isplayer(attacker)) {
    return get_old_damage(attacker, weapon, type, damage, allow_bullet_damage);
  }

  friendlyfire = damage::friendlyfirecheck(self.owner, attacker);

  if(!friendlyfire) {
    return 0;
  }

  if(!(isDefined(var_488beb6d) && var_488beb6d)) {
    isvalidattacker = 1;

    if(level.teambased) {
      isvalidattacker = isDefined(attacker.team) && util::function_fbce7263(attacker.team, self.team);
    }

    if(!isvalidattacker) {
      return 0;
    }
  }

  if(weapon.isemp && type == "MOD_GRENADE_SPLASH") {
    emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage(killstreak_ref, self.maxhealth);

    if(!isDefined(emp_damage_to_apply)) {
      emp_damage_to_apply = isDefined(emp_damage) ? emp_damage : 1;
    }

    if(isDefined(emp_callback) && emp_damage_to_apply > 0) {
      self[[emp_callback]](attacker, weapon);
    }

    return emp_damage_to_apply;
  }

  weapon_damage = killstreak_bundles::get_weapon_damage(killstreak_ref, self.maxhealth, attacker, weapon, type, damage, flags, chargelevel);

  if(!isDefined(weapon_damage)) {
    weapon_damage = get_old_damage(attacker, weapon, type, damage, allow_bullet_damage);
  }

  if(!isDefined(weapon_damage) || weapon_damage <= 0) {
    return 0;
  }

  idamage = int(weapon_damage);

  if(idamage > self.health) {
    self function_73566ec7(attacker, weapon, self.owner);

    if(isDefined(destroyed_callback)) {
      self thread[[destroyed_callback]](attacker, weapon);
    }
  }

  return idamage;
}

get_old_damage(attacker, weapon, type, damage, allow_bullet_damage, bullet_damage_scalar) {
  switch (type) {
    case #"mod_rifle_bullet":
    case #"mod_pistol_bullet":
      if(!allow_bullet_damage) {
        damage = 0;
        break;
      }

      if(isDefined(attacker) && isplayer(attacker)) {
        hasfmj = attacker hasperk(#"specialty_armorpiercing");
      }

      if(isDefined(hasfmj) && hasfmj) {
        damage = int(damage * level.cac_armorpiercing_data);
      }

      if(isDefined(bullet_damage_scalar)) {
        damage = int(damage * bullet_damage_scalar);
      }

      break;
    case #"mod_explosive":
    case #"mod_projectile":
    case #"mod_projectile_splash":
      if(weapon.statindex == level.weaponpistolenergy.statindex || weapon.statindex != level.weaponshotgunenergy.statindex || weapon.statindex == level.weaponspecialcrossbow.statindex) {
        break;
      }

      if(isDefined(self.remotemissiledamage) && isDefined(weapon) && weapon.name == #"remote_missile_missile") {
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

isheldinventorykillstreakweapon(killstreakweapon) {
  switch (killstreakweapon.name) {
    case #"inventory_m32":
    case #"inventory_minigun":
      return true;
  }

  return false;
}

waitfortimecheck(duration, callback, endcondition1, endcondition2, endcondition3) {
  self endon(#"hacked");

  if(isDefined(endcondition1)) {
    self endon(endcondition1);
  }

  if(isDefined(endcondition2)) {
    self endon(endcondition2);
  }

  if(isDefined(endcondition3)) {
    self endon(endcondition3);
  }

  hostmigration::migrationawarewait(duration);
  self notify(#"time_check");
  self[[callback]]();
}

emp_isempd() {
  if(isDefined(level.emp_shared.enemyempactivefunc)) {
    return self[[level.emp_shared.enemyempactivefunc]]();
  }

  return 0;
}

waittillemp(onempdcallback, arg) {
  self endon(#"death", #"delete");
  waitresult = self waittill(#"emp_deployed");

  if(isDefined(onempdcallback)) {
    [[onempdcallback]](waitresult.attacker, arg);
  }
}

destroyotherteamsequipment(attacker, weapon, radius) {
  foreach(team, _ in level.teams) {
    if(!util::function_fbce7263(team, attacker.team)) {
      continue;
    }

    destroyequipment(attacker, team, weapon, radius);
    destroytacticalinsertions(attacker, team, radius);
  }

  destroyequipment(attacker, "free", weapon, radius);
  destroytacticalinsertions(attacker, "free", radius);
}

destroyequipment(attacker, team, weapon, radius) {
  radiussq = radius * radius;

  for(i = 0; i < level.missileentities.size; i++) {
    item = level.missileentities[i];

    if(!isDefined(item)) {
      continue;
    }

    if(distancesquared(item.origin, attacker.origin) > radiussq) {
      continue;
    }

    if(!isDefined(item.weapon)) {
      continue;
    }

    if(!isDefined(item.owner)) {
      continue;
    }

    if(isDefined(team) && util::function_fbce7263(item.owner.team, team)) {
      continue;
    } else if(item.owner == attacker) {
      continue;
    }

    if(!item.weapon.isequipment && !(isDefined(item.destroyedbyemp) && item.destroyedbyemp)) {
      continue;
    }

    watcher = item.owner weaponobjects::getwatcherforweapon(item.weapon);

    if(!isDefined(watcher)) {
      continue;
    }

    watcher thread weaponobjects::waitanddetonate(item, 0, attacker, weapon);
  }
}

destroytacticalinsertions(attacker, victimteam, radius) {
  radiussq = radius * radius;

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(!isDefined(player.tacticalinsertion)) {
      continue;
    }

    if(level.teambased && util::function_fbce7263(player.team, victimteam)) {
      continue;
    }

    if(attacker == player) {
      continue;
    }

    if(distancesquared(player.origin, attacker.origin) < radiussq) {
      player.tacticalinsertion thread tacticalinsertion::fizzle();
    }
  }
}

destroyotherteamsactivevehicles(attacker, weapon, radius) {
  foreach(team, _ in level.teams) {
    if(!util::function_fbce7263(team, attacker.team)) {
      continue;
    }

    destroyactivevehicles(attacker, team, weapon, radius);
  }
}

destroyactivevehicles(attacker, team, weapon, radius) {
  radiussq = radius * radius;
  targets = target_getarray();
  destroyentities(targets, attacker, team, weapon, radius);
  ai_tanks = getEntArray("talon", "targetname");
  destroyentities(ai_tanks, attacker, team, weapon, radius);
  remotemissiles = getEntArray("remote_missile", "targetname");
  destroyentities(remotemissiles, attacker, team, weapon, radius);
  remotedrone = getEntArray("remote_drone", "targetname");
  destroyentities(remotedrone, attacker, team, weapon, radius);
  script_vehicles = getEntArray("script_vehicle", "classname");

  foreach(vehicle in script_vehicles) {
    if(distancesquared(vehicle.origin, attacker.origin) > radiussq) {
      continue;
    }

    if(isDefined(team) && !util::function_fbce7263(vehicle.team, team) && isvehicle(vehicle)) {
      if(isDefined(vehicle.detonateviaemp) && isDefined(weapon.isempkillstreak) && weapon.isempkillstreak) {
        vehicle[[vehicle.detonateviaemp]](attacker, weapon);
      }

      if(isDefined(vehicle.archetype)) {
        if(vehicle.archetype == "turret" || vehicle.archetype == "rcbomb" || vehicle.archetype == "wasp") {
          vehicle dodamage(vehicle.health + 1, vehicle.origin, attacker, attacker, "", "MOD_EXPLOSIVE", 0, weapon);
        }
      }
    }
  }

  planemortars = getEntArray("plane_mortar", "targetname");

  foreach(planemortar in planemortars) {
    if(distance2d(planemortar.origin, attacker.origin) > radius) {
      continue;
    }

    if(isDefined(team) && isDefined(planemortar.team)) {
      if(util::function_fbce7263(planemortar.team, team)) {
        continue;
      }
    } else if(planemortar.owner == attacker) {
      continue;
    }

    planemortar notify(#"emp_deployed", {
      #attacker: attacker
    });
  }

  dronestrikes = getEntArray("drone_strike", "targetname");

  foreach(dronestrike in dronestrikes) {
    if(distance2d(dronestrike.origin, attacker.origin) > radius) {
      continue;
    }

    if(isDefined(team) && isDefined(dronestrike.team)) {
      if(util::function_fbce7263(dronestrike.team, team)) {
        continue;
      }
    } else if(dronestrike.owner == attacker) {
      continue;
    }

    dronestrike notify(#"emp_deployed", {
      #attacker: attacker
    });
  }

  var_eca5110 = getEntArray("guided_artillery_shell", "targetname");

  foreach(shell in var_eca5110) {
    if(distance2d(shell.origin, attacker.origin) > radius) {
      continue;
    }

    if(isDefined(team) && isDefined(shell.team)) {
      if(util::function_fbce7263(shell.team, team)) {
        continue;
      }
    } else if(shell.owner == attacker) {
      continue;
    }

    shell notify(#"emp_deployed", {
      #attacker: attacker
    });
  }

  counteruavs = getEntArray("counteruav", "targetname");

  foreach(counteruav in counteruavs) {
    if(distance2d(counteruav.origin, attacker.origin) > radius) {
      continue;
    }

    if(isDefined(team) && isDefined(counteruav.team)) {
      if(util::function_fbce7263(counteruav.team, team)) {
        continue;
      }
    } else if(counteruav.owner == attacker) {
      continue;
    }

    counteruav notify(#"emp_deployed", {
      #attacker: attacker
    });
  }

  satellites = getEntArray("satellite", "targetname");

  foreach(satellite in satellites) {
    if(distance2d(satellite.origin, attacker.origin) > radius) {
      continue;
    }

    if(isDefined(team) && isDefined(satellite.team)) {
      if(util::function_fbce7263(satellite.team, team)) {
        continue;
      }
    } else if(satellite.owner == attacker) {
      continue;
    }

    satellite notify(#"emp_deployed", {
      #attacker: attacker
    });
  }

  robots = getaiarchetypearray("robot");

  foreach(robot in robots) {
    if(distancesquared(robot.origin, attacker.origin) > radiussq) {
      continue;
    }

    if(robot.allowdeath !== 0 && robot.magic_bullet_shield !== 1 && isDefined(team) && !util::function_fbce7263(robot.team, team)) {
      if(isDefined(attacker) && (!isDefined(robot.owner) || robot.owner util::isenemyplayer(attacker))) {
        scoreevents::processscoreevent(#"destroyed_combat_robot", attacker, robot.owner, weapon);
        luinotifyevent(#"player_callout", 2, #"hash_3b274c8c3c961f3", attacker.entnum);
      }

      robot kill();
    }
  }

  if(isDefined(level.missile_swarm_owner)) {
    if(level.missile_swarm_owner util::isenemyplayer(attacker)) {
      if(distancesquared(level.missile_swarm_owner.origin, attacker.origin) < radiussq) {
        level.missile_swarm_owner notify(#"emp_destroyed_missile_swarm", {
          #attacker: attacker
        });
      }
    }
  }
}

destroyentities(entities, attacker, team, weapon, radius) {
  meansofdeath = "MOD_EXPLOSIVE";
  damage = 5000;
  direction_vec = (0, 0, 0);
  point = (0, 0, 0);
  modelname = "";
  tagname = "";
  partname = "";
  radiussq = radius * radius;

  foreach(entity in entities) {
    if(isDefined(team) && isDefined(entity.team)) {
      if(util::function_fbce7263(entity.team, team)) {
        continue;
      }
    } else if(isDefined(entity.owner) && entity.owner == attacker) {
      continue;
    }

    if(distancesquared(entity.origin, attacker.origin) < radiussq) {
      entity notify(#"damage", {
        #amount: damage, 
        #attacker: attacker, 
        #direction: direction_vec, 
        #position: point, 
        #mod: meansofdeath, 
        #tag_name: tagname, 
        #model_name: modelname, 
        #part_name: partname, 
        #weapon: weapon
      });
    }
  }
}

get_killstreak_for_weapon(weapon) {
  if(!isDefined(level.killstreakweapons)) {
    return undefined;
  }

  if(isDefined(level.killstreakweapons[weapon])) {
    return level.killstreakweapons[weapon];
  }

  return level.killstreakweapons[weapon.rootweapon];
}

is_killstreak_weapon_assist_allowed(weapon) {
  killstreak = get_killstreak_for_weapon(weapon);

  if(!isDefined(killstreak)) {
    return false;
  }

  if(level.killstreaks[killstreak].allowassists) {
    return true;
  }

  return false;
}

should_override_entity_camera_in_demo(player, weapon) {
  killstreak = get_killstreak_for_weapon(weapon);

  if(!isDefined(killstreak)) {
    return false;
  }

  if(level.killstreaks[killstreak].overrideentitycameraindemo) {
    return true;
  }

  if(isDefined(player.remoteweapon) && isDefined(player.remoteweapon.controlled) && player.remoteweapon.controlled) {
    return true;
  }

  return false;
}

watch_for_remove_remote_weapon() {
  self endon(#"endwatchforremoveremoteweapon");

  for(;;) {
    self waittill(#"remove_remote_weapon");
    self switch_to_last_non_killstreak_weapon();
    self enableusability();
  }
}

clear_using_remote(immediate, skipnotify, gameended) {
  if(!isDefined(self)) {
    return;
  }

  self.dofutz = 0;
  self.no_fade2black = 0;
  self clientfield::set_to_player("static_postfx", 0);

  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 1;
  }

  self.usingremote = undefined;
  self reset_killstreak_delay_killcam();
  self enableoffhandweapons();
  self enableweaponcycling();
  curweapon = self getcurrentweapon();

  if(isalive(self)) {
    self switch_to_last_non_killstreak_weapon(immediate, undefined, gameended);
  }

  if(!(isDefined(skipnotify) && skipnotify)) {
    self notify(#"stopped_using_remote");
  }

  thread hide_tablet();
}

hide_tablet() {
  self endon(#"disconnect");
  wait 0.2;
}

reset_killstreak_delay_killcam() {
  self.killstreak_delay_killcam = undefined;
}

init_ride_killstreak(streak, always_allow = 0) {
  self disableusability();
  result = self init_ride_killstreak_internal(streak, always_allow);

  if(isDefined(self)) {
    self enableusability();
  }

  return result;
}

init_ride_killstreak_internal(streak, always_allow) {
  var_5df1cb97 = 0;

  if(isDefined(streak) && (streak == "dart" || streak == "killstreak_remote_turret" || streak == "killstreak_ai_tank" || streak == "qrdrone" || streak == "sentinel" || streak == "recon_car")) {
    laptopwait = "timeout";
  } else if(isDefined(streak) && streak == "remote_missile") {
    laptopwait = "timeout";
    var_5df1cb97 = getdvarfloat(#"hash_409036e81396b597", 0.075);
  } else {
    laptopwait = self waittilltimeout(0.2, #"disconnect", #"death", #"weapon_switch_started");
    laptopwait = laptopwait._notify;
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

    if(!isDefined(self.team) || self.team == #"spectator") {
      return "fail";
    }

    return "success";
  }

  if(self isempjammed() && !(isDefined(self.ignoreempjammed) && self.ignoreempjammed)) {
    return "fail";
  }

  if(self is_interacting_with_object()) {
    return "fail";
  }

  self thread hud::fade_to_black_for_x_sec(0, 0.2 + var_5df1cb97, 0.1, 0.1);
  self thread watch_for_remove_remote_weapon();
  blackoutwait = self waittilltimeout(0.2, #"disconnect", #"death");
  self notify(#"endwatchforremoveremoteweapon");
  hostmigration::waittillhostmigrationdone();

  if(blackoutwait._notify != "disconnect") {
    self thread clear_ride_intro(1);

    if(!isDefined(self.team) || self.team == #"spectator") {
      return "fail";
    }
  }

  if(always_allow) {
    if(blackoutwait._notify == "disconnect") {
      return "disconnect";
    } else {
      return "success";
    }
  }

  if(self isonladder()) {
    return "fail";
  }

  if(!isalive(self)) {
    return "fail";
  }

  if(self isempjammed() && !(isDefined(self.ignoreempjammed) && self.ignoreempjammed)) {
    return "fail";
  }

  if(isDefined(self.laststand) && self.laststand) {
    return "fail";
  }

  if(self is_interacting_with_object()) {
    return "fail";
  }

  if(blackoutwait._notify == "disconnect") {
    return "disconnect";
  }

  return "success";
}

clear_ride_intro(delay) {
  self endon(#"disconnect");

  if(isDefined(delay)) {
    wait delay;
  }

  self thread hud::screen_fade_in(0);
}

is_interacting_with_object() {
  if(self iscarryingturret()) {
    return true;
  }

  if(isDefined(self.isplanting) && self.isplanting) {
    return true;
  }

  if(isDefined(self.isdefusing) && self.isdefusing) {
    return true;
  }

  return false;
}

get_random_pilot_index(killstreaktype) {
  if(!isDefined(killstreaktype)) {
    return undefined;
  }

  if(!isDefined(self.pers[#"mptaacom"])) {
    return undefined;
  }

  taacombundle = get_mpdialog_tacom_bundle(self.pers[#"mptaacom"]);

  if(!isDefined(taacombundle) || !isDefined(taacombundle.pilotbundles)) {
    return undefined;
  }

  if(!isDefined(taacombundle.pilotbundles[killstreaktype])) {
    return undefined;
  }

  numpilots = taacombundle.pilotbundles[killstreaktype].size;

  if(numpilots <= 0) {
    return undefined;
  }

  return randomint(numpilots);
}

get_mpdialog_tacom_bundle(name) {
  if(!isDefined(level.tacombundles)) {
    return undefined;
  }

  return level.tacombundles[name];
}

hide_compass() {
  self clientfield::set("killstreak_hides_compass", 1);
}

unhide_compass() {
  self clientfield::set("killstreak_hides_compass", 0);
}

setup_health(killstreak_ref, max_health, low_health) {
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

defaulthackedhealthupdatecallback(hacker) {
  killstreak = self;
  assert(isDefined(self.maxhealth));
  assert(isDefined(self.hackedhealth));
  assert(isDefined(self.damagetaken));
  damageafterhacking = self.maxhealth - self.hackedhealth;

  if(self.damagetaken < damageafterhacking) {
    self.damagetaken = damageafterhacking;
  }
}

function_8cd96439(killstreakref, killstreakid, onplacecallback, oncancelcallback, onmovecallback, onshutdowncallback, ondeathcallback, onempcallback, model, validmodel, invalidmodel, spawnsvehicle, pickupstring, timeout, health, empdamage, placehintstring, invalidlocationhintstring, placeimmediately = 0) {
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

function_84da1341(damagecallback, destroyedcallback, var_1891d3cd, var_2053fdc6) {
  waitframe(1);
  placeable = self;

  if(isDefined(level.var_8ddb1b0e)) {
    placeable thread[[level.var_8ddb1b0e]](placeable.killstreakref, placeable.health, destroyedcallback, 0, undefined, var_1891d3cd, var_2053fdc6, 1);
  }
}

configure_team(killstreaktype, killstreakid, owner, influencertype, configureteamprefunction, configureteampostfunction, ishacked = 0) {
  killstreak = self;
  killstreak.killstreaktype = killstreaktype;
  killstreak.killstreakid = killstreakid;
  killstreak _setup_configure_team_callbacks(influencertype, configureteamprefunction, configureteampostfunction);
  killstreak configure_team_internal(owner, ishacked);
  owner thread trackactivekillstreak(killstreak);
}

configure_team_internal(owner, ishacked) {
  killstreak = self;

  if(ishacked == 0) {
    killstreak.originalowner = owner;
    killstreak.originalteam = owner.team;

  } else {
    assert(killstreak.killstreakteamconfigured, "<dev string:x57d>");
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
  killstreak.pilotindex = killstreak.owner get_random_pilot_index(killstreak.killstreaktype);

  if(isDefined(killstreak.killstreakinfluencertype)) {
    killstreak influencers::create_entity_enemy_influencer(killstreak.killstreakinfluencertype, owner.team);
  }

  if(isDefined(killstreak.killstreakconfigureteampostfunction)) {
    killstreak thread[[killstreak.killstreakconfigureteampostfunction]](owner, ishacked);
  }
}

private _setup_configure_team_callbacks(influencertype, configureteamprefunction, configureteampostfunction) {
  killstreak = self;
  killstreak.killstreakteamconfigured = 1;
  killstreak.killstreakinfluencertype = influencertype;
  killstreak.killstreakconfigureteamprefunction = configureteamprefunction;
  killstreak.killstreakconfigureteampostfunction = configureteampostfunction;
}

trackactivekillstreak(killstreak) {
  killstreakindex = killstreak.killstreakid;

  if(isDefined(self) && isDefined(self.pers) && isDefined(killstreakindex)) {
    self endon(#"disconnect");
    self.pers[#"activekillstreaks"][killstreakindex] = killstreak;
    killstreak waittill(#"killstreak_hacked", #"death");
    self.pers[#"activekillstreaks"][killstreakindex] = undefined;
  }
}

play_killstreak_firewall_being_hacked_dialog(killstreaktype, killstreakid) {
  if(isDefined(level.play_killstreak_firewall_being_hacked_dialog)) {
    self[[level.play_killstreak_firewall_being_hacked_dialog]](killstreaktype, killstreakid);
  }
}

play_killstreak_firewall_hacked_dialog(killstreaktype, killstreakid) {
  if(isDefined(level.play_killstreak_firewall_hacked_dialog)) {
    self[[level.play_killstreak_firewall_hacked_dialog]](killstreaktype, killstreakid);
  }
}

play_killstreak_being_hacked_dialog(killstreaktype, killstreakid) {
  if(isDefined(level.play_killstreak_being_hacked_dialog)) {
    self[[level.play_killstreak_being_hacked_dialog]](killstreaktype, killstreakid);
  }
}

play_killstreak_hacked_dialog(killstreaktype, killstreakid, hacker) {
  if(isDefined(level.play_killstreak_hacked_dialog)) {
    self[[level.play_killstreak_hacked_dialog]](killstreaktype, killstreakid, hacker);
  }
}

play_killstreak_start_dialog(hardpointtype, team, killstreak_id) {
  if(isDefined(level.play_killstreak_start_dialog)) {
    self[[level.play_killstreak_start_dialog]](hardpointtype, team, killstreak_id);
  }
}

play_pilot_dialog(dialogkey, killstreaktype, killstreakid, pilotindex) {
  if(isDefined(level.play_pilot_dialog)) {
    self[[level.play_pilot_dialog]](dialogkey, killstreaktype, killstreakid, pilotindex);
  }
}

play_pilot_dialog_on_owner(dialogkey, killstreaktype, killstreakid) {
  if(isDefined(level.play_pilot_dialog_on_owner)) {
    self[[level.play_pilot_dialog_on_owner]](dialogkey, killstreaktype, killstreakid);
  }
}

play_destroyed_dialog_on_owner(killstreaktype, killstreakid) {
  if(isDefined(level.play_destroyed_dialog_on_owner)) {
    self[[level.play_destroyed_dialog_on_owner]](killstreaktype, killstreakid);
  }
}

play_taacom_dialog(dialogkey, killstreaktype, killstreakid, soundevent, var_8a6b001a, weapon, priority) {
  if(isDefined(level.play_taacom_dialog)) {
    self[[level.play_taacom_dialog]](dialogkey, killstreaktype, killstreakid, soundevent, var_8a6b001a, weapon, priority);
  }
}

play_taacom_dialog_response_on_owner(dialogkey, killstreaktype, killstreakid) {
  if(isDefined(level.play_taacom_dialog_response_on_owner)) {
    self[[level.play_taacom_dialog_response_on_owner]](dialogkey, killstreaktype, killstreakid);
  }
}

leader_dialog_for_other_teams(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey) {
  if(isDefined(level.var_9f8e080d)) {
    [[level.var_9f8e080d]](dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey);
  }
}

leader_dialog(dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey) {
  if(isDefined(level.var_514f9d20)) {
    [[level.var_514f9d20]](dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey);
  }
}

processscoreevent(event, player, victim, weapon) {
  if(isDefined(level.var_19a15e42)) {
    [[level.var_19a15e42]](event, player, victim, weapon);
  }
}

allow_assists(killstreaktype, allow) {
  level.killstreaks[killstreaktype].allowassists = allow;
}

set_team_kill_penalty_scale(killstreaktype, scale, isinventory) {
  level.killstreaks[killstreaktype].teamkillpenaltyscale = scale;
}

override_entity_camera_in_demo(killstreaktype, value, isinventory) {
  level.killstreaks[killstreaktype].overrideentitycameraindemo = value;
}

update_player_threat(player) {
  if(!isplayer(player)) {
    return;
  }

  heli = self;
  player.threatlevel = 0;
  dist = distance(player.origin, heli.origin);
  player.threatlevel += (level.heli_visual_range - dist) / level.heli_visual_range * 100;

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

update_non_player_threat(non_player) {
  heli = self;
  non_player.threatlevel = 0;
  dist = distance(non_player.origin, heli.origin);
  non_player.threatlevel += (level.heli_visual_range - dist) / level.heli_visual_range * 100;

  if(non_player.threatlevel <= 0) {
    non_player.threatlevel = 1;
  }
}

update_actor_threat(actor) {
  heli = self;
  actor.threatlevel = 0;
  dist = distance(actor.origin, heli.origin);
  actor.threatlevel += (level.heli_visual_range - dist) / level.heli_visual_range * 100;

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

update_dog_threat(dog) {
  heli = self;
  dog.threatlevel = 0;
  dist = distance(dog.origin, heli.origin);
  dog.threatlevel += (level.heli_visual_range - dist) / level.heli_visual_range * 100;
}

missile_valid_target_check(missiletarget) {
  heli2target_normal = vectornormalize(missiletarget.origin - self.origin);
  heli2forward = anglesToForward(self.angles);
  heli2forward_normal = vectornormalize(heli2forward);
  heli_dot_target = vectordot(heli2target_normal, heli2forward_normal);

  if(heli_dot_target >= level.heli_valid_target_cone) {
    return true;
  }

  return false;
}

update_missile_player_threat(player) {
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

  player.missilethreatlevel += player.score * 4;

  if(isDefined(player.antithreat)) {
    player.missilethreatlevel -= player.antithreat;
  }

  if(player.missilethreatlevel <= 0) {
    player.missilethreatlevel = 1;
  }
}

update_missile_dog_threat(dog) {
  dog.missilethreatlevel = 1;
}

function_fff56140(owner, var_4a025683) {
  self notify(#"hash_4363bc1bae999ad3");
  self endon(#"hash_4363bc1bae999ad3", #"death");
  res = owner waittill(#"joined_team", #"disconnect", #"joined_spectators", #"changed_specialist");
  [[var_4a025683]]();
}

should_not_timeout(killstreak) {

  assert(isDefined(killstreak), "<dev string:x77>");
  assert(isDefined(level.killstreaks[killstreak]), "<dev string:x299>");

  if(getdvarint(#"hash_e8bb2ce168acce0", 0)) {
    return 1;
  }

  if(isDefined(level.killstreaks[killstreak].devtimeoutdvar)) {
    return getdvarint(level.killstreaks[killstreak].devtimeoutdvar, 0);
  }

    return 0;
}

waitfortimeout(killstreak, duration, callback, endcondition1, endcondition2, endcondition3) {

  if(should_not_timeout(killstreak)) {
    return;
  }

    self endon(#"killstreak_hacked", #"cancel_timeout");

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
  killstreakbundle = level.killstreakbundle[killstreak];
  self.killstreakendtime = gettime() + duration;

  if(isDefined(killstreakbundle) && isDefined(killstreakbundle.kstimeoutbeepduration)) {
    self function_b00e94e0(killstreakbundle, duration);
  } else {
    hostmigration::migrationawarewait(duration);
  }

  self notify(#"kill_waitfortimeouthacked_thread");
  self.killstreaktimedout = 1;
  self.killstreakendtime = 0;
  self notify(#"timed_out");
  self[[callback]]();
}

function_b00e94e0(killstreakbundle, duration) {
  self waitfortimeoutbeep(killstreakbundle.kstimeoutbeepduration, killstreakbundle.kstimeoutfastbeepduration, duration);
}

waitfortimeoutbeep(kstimeoutbeepduration, kstimeoutfastbeepduration, duration) {
  self endon(#"death");
  beepduration = int(kstimeoutbeepduration * 1000);
  hostmigration::migrationawarewait(max(duration - beepduration, 0));

  if(isvehicle(self)) {
    self clientfield::set("timeout_beep", 1);
  }

  if(isDefined(kstimeoutfastbeepduration)) {
    fastbeepduration = int(kstimeoutfastbeepduration * 1000);
    hostmigration::migrationawarewait(max(beepduration - fastbeepduration, 0));

    if(isvehicle(self)) {
      self clientfield::set("timeout_beep", 2);
    }

    hostmigration::migrationawarewait(fastbeepduration);
  }

  self function_67bc25ec();
}

function_67bc25ec() {
  if(isDefined(self) && isvehicle(self)) {
    self clientfield::set("timeout_beep", 0);
  }
}

waitfortimeouthacked(killstreak, callback, endcondition1, endcondition2, endcondition3) {
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
  hostmigration::migrationawarewait(hackedduration);
  self.killstreakendtime = 0;
  self notify(#"timed_out");
  self[[callback]]();
}

function_975d45c3() {
  startheight = 200;

  switch (self getstance()) {
    case #"crouch":
      startheight = 30;
      break;
    case #"prone":
      startheight = 15;
      break;
  }

  return startheight;
}

set_killstreak_delay_killcam(killstreak_name) {
  self.killstreak_delay_killcam = killstreak_name;
}

getactivekillstreaks() {
  return self.pers[#"activekillstreaks"];
}

watchteamchange(teamchangenotify) {
  self notify(teamchangenotify + "_Singleton");
  self endon(teamchangenotify + "_Singleton");
  killstreak = self;
  killstreak endon(#"death", teamchangenotify);
  killstreak.owner waittill(#"joined_team", #"disconnect", #"joined_spectators", #"emp_jammed");
  killstreak notify(teamchangenotify);
}

killstreak_assist(victim, assister, killstreak) {
  victim recordkillstreakassist(victim, assister, killstreak);
}

add_ricochet_protection(killstreak_id, owner, origin, ricochet_distance) {
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
  owner.ricochet_protection[killstreak_id].distancesq = ricochet_distance * ricochet_distance;
}

set_ricochet_protection_endtime(killstreak_id, owner, endtime) {
  if(!isDefined(owner) || !isDefined(owner.ricochet_protection) || !isDefined(killstreak_id)) {
    return;
  }

  if(!isDefined(owner.ricochet_protection[killstreak_id])) {
    return;
  }

  owner.ricochet_protection[killstreak_id].endtime = endtime;
}

remove_ricochet_protection(killstreak_id, owner) {
  if(!isDefined(owner) || !isDefined(owner.ricochet_protection) || !isDefined(killstreak_id)) {
    return;
  }

  owner.ricochet_protection[killstreak_id] = undefined;
}

thermal_glow(enable) {
  clientfield::set_to_player("thermal_glow", enable);
}

thermal_glow_enemies_only(enable) {
  clientfield::set_to_player("thermal_glow_enemies_only", enable);
}

is_ricochet_protected(player) {
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

debug_ricochet_protection() {
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

