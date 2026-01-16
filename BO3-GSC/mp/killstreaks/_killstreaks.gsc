/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_killstreaks.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_teamops;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_battlechatter;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_score;
#using scripts\mp\gametypes\_globallogic_utils;
#using scripts\mp\gametypes\_hostmigration;
#using scripts\mp\gametypes\_hud_message;
#using scripts\mp\gametypes\_loadout;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\killstreaks\_ai_tank;
#using scripts\mp\killstreaks\_airsupport;
#using scripts\mp\killstreaks\_combat_robot;
#using scripts\mp\killstreaks\_counteruav;
#using scripts\mp\killstreaks\_dart;
#using scripts\mp\killstreaks\_dogs;
#using scripts\mp\killstreaks\_drone_strike;
#using scripts\mp\killstreaks\_emp;
#using scripts\mp\killstreaks\_flak_drone;
#using scripts\mp\killstreaks\_helicopter;
#using scripts\mp\killstreaks\_helicopter_gunner;
#using scripts\mp\killstreaks\_killstreak_bundles;
#using scripts\mp\killstreaks\_killstreak_detect;
#using scripts\mp\killstreaks\_killstreak_hacking;
#using scripts\mp\killstreaks\_killstreakrules;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\killstreaks\_microwave_turret;
#using scripts\mp\killstreaks\_planemortar;
#using scripts\mp\killstreaks\_qrdrone;
#using scripts\mp\killstreaks\_raps;
#using scripts\mp\killstreaks\_rcbomb;
#using scripts\mp\killstreaks\_remote_weapons;
#using scripts\mp\killstreaks\_remotemissile;
#using scripts\mp\killstreaks\_satellite;
#using scripts\mp\killstreaks\_sentinel;
#using scripts\mp\killstreaks\_supplydrop;
#using scripts\mp\killstreaks\_turret;
#using scripts\mp\killstreaks\_uav;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\hostmigration_shared;
#using scripts\shared\hud_message_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\popups_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weaponobjects;
#using scripts\shared\weapons\_weapons;
#using scripts\shared\weapons_shared;
#namespace killstreaks;

function autoexec __init__sytem__() {
  system::register("killstreaks", & __init__, undefined, undefined);
}

function __init__() {
  level.killstreaks = [];
  level.killstreakweapons = [];
  level.droplocations = [];
  level.zoffsetcounter = 0;
  clientfield::register("vehicle", "timeout_beep", 1, 2, "int");
  callback::on_start_gametype( & init);
}

function init() {
  level.killstreak_init_start_time = getmillisecondsraw();
  thread debug_ricochet_protection();
  if(getdvarstring("scr_allow_killstreak_building") == "") {
    setdvar("scr_allow_killstreak_building", "0");
  }
  level.menureferenceforkillstreak = [];
  level.numkillstreakreservedobjectives = 0;
  level.killstreakcounter = 0;
  level.play_killstreak_firewall_being_hacked_dialog = & play_killstreak_firewall_being_hacked_dialog;
  level.play_killstreak_firewall_hacked_dialog = & play_killstreak_firewall_hacked_dialog;
  level.play_killstreak_being_hacked_dialog = & play_killstreak_being_hacked_dialog;
  level.play_killstreak_hacked_dialog = & play_killstreak_hacked_dialog;
  if(!isdefined(level.roundstartkillstreakdelay)) {
    level.roundstartkillstreakdelay = 0;
  }
  level.iskillstreakweapon = & is_killstreak_weapon;
  level.killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");
  remote_weapons::init();
  ai_tank::init();
  airsupport::init();
  combat_robot::init();
  counteruav::init();
  dart::init();
  drone_strike::init();
  emp::init();
  flak_drone::init();
  helicopter::init();
  helicopter_gunner::init();
  killstreakrules::init();
  microwave_turret::init();
  planemortar::init();
  qrdrone::init();
  raps_mp::init();
  rcbomb::init();
  remotemissile::init();
  satellite::init();
  sentinel::init();
  turret::init();
  uav::init();
  supplydrop::init();
  level.killstreak_init_end_time = getmillisecondsraw();
  elapsed_time = level.killstreak_init_end_time - level.killstreak_init_start_time;
  println(("" + elapsed_time) + "");
  callback::on_spawned( & on_player_spawned);
  callback::on_joined_team( & on_joined_team);
  level thread killstreak_debug_think();
  if(getdvarint("teamOpsEnabled") == 1) {
    level teamops::main();
  }
}

function register(killstreaktype, killstreakweaponname, killstreakmenuname, killstreakusagekey, killstreakusefunction, killstreakdelaystreak, weaponholdallowed = 0, killstreakstatsname = undefined, registerdvars = 1, registerinventory = 1) {
  assert(isdefined(killstreaktype), "");
  assert(!isdefined(level.killstreaks[killstreaktype]), ("" + killstreaktype) + "");
  assert(isdefined(killstreakusefunction), "" + killstreaktype);
  level.killstreaks[killstreaktype] = spawnstruct();
  statstablename = util::getstatstablename();
  level.killstreaks[killstreaktype].killstreaklevel = int(tablelookup(statstablename, 4, killstreakmenuname, 5));
  level.killstreaks[killstreaktype].momentumcost = int(tablelookup(statstablename, 4, killstreakmenuname, 16));
  level.killstreaks[killstreaktype].iconmaterial = tablelookup(statstablename, 4, killstreakmenuname, 6);
  level.killstreaks[killstreaktype].quantity = int(tablelookup(statstablename, 4, killstreakmenuname, 5));
  level.killstreaks[killstreaktype].usagekey = killstreakusagekey;
  level.killstreaks[killstreaktype].usefunction = killstreakusefunction;
  level.killstreaks[killstreaktype].menuname = killstreakmenuname;
  level.killstreaks[killstreaktype].delaystreak = killstreakdelaystreak;
  level.killstreaks[killstreaktype].allowassists = 0;
  level.killstreaks[killstreaktype].overrideentitycameraindemo = 0;
  level.killstreaks[killstreaktype].teamkillpenaltyscale = 1;
  level.killstreaks[killstreaktype].uiname = tablelookup(statstablename, 4, killstreakmenuname, 3);
  if(level.killstreaks[killstreaktype].uiname == "") {
    level.killstreaks[killstreaktype].uiname = killstreakmenuname;
  }
  if(isdefined(killstreakweaponname)) {
    killstreakweapon = getweapon(killstreakweaponname);
    assert(killstreakweapon != level.weaponnone);
    assert(!isdefined(level.killstreakweapons[killstreakweapon]), "");
    level.killstreaks[killstreaktype].weapon = killstreakweapon;
    level.killstreakweapons[killstreakweapon] = killstreaktype;
  }
  if(isdefined(killstreakstatsname)) {
    level.killstreaks[killstreaktype].killstreakstatsname = killstreakstatsname;
  }
  level.killstreaks[killstreaktype].weaponholdallowed = weaponholdallowed;
  if(isdefined(registerinventory) && registerinventory) {
    level.menureferenceforkillstreak[killstreakmenuname] = killstreaktype;
    killstreak_bundles::register_killstreak_bundle(killstreaktype);
  }
  if(isdefined(registerinventory) && registerinventory) {
    if(isdefined(registerdvars) && registerdvars) {
      register_dev_dvars(killstreaktype);
    }
    register("inventory_" + killstreaktype, "inventory_" + killstreakweaponname, killstreakmenuname, killstreakusagekey, killstreakusefunction, killstreakdelaystreak, weaponholdallowed, killstreakstatsname, registerdvars, 0);
  }
}

function is_registered(killstreaktype) {
  return isdefined(level.killstreaks[killstreaktype]);
}

function register_strings(killstreaktype, receivedtext, notusabletext, inboundtext, inboundnearplayertext, hackedtext, utilizesairspace = 1, isinventory = 0) {
  assert(isdefined(killstreaktype), "");
  assert(isdefined(level.killstreaks[killstreaktype]), "");
  level.killstreaks[killstreaktype].receivedtext = receivedtext;
  level.killstreaks[killstreaktype].notavailabletext = notusabletext;
  level.killstreaks[killstreaktype].inboundtext = inboundtext;
  level.killstreaks[killstreaktype].inboundnearplayertext = inboundnearplayertext;
  level.killstreaks[killstreaktype].hackedtext = hackedtext;
  level.killstreaks[killstreaktype].utilizesairspace = utilizesairspace;
  if(!(isdefined(isinventory) && isinventory)) {
    register_strings("inventory_" + killstreaktype, receivedtext, notusabletext, inboundtext, inboundnearplayertext, hackedtext, utilizesairspace, 1);
  }
}

function register_dialog(killstreaktype, informdialog, taacomdialogbundlekey, pilotdialogarraykey, startdialogkey, enemystartdialogkey, enemystartmultipledialogkey, hackeddialogkey, hackedstartdialogkey, requestdialogkey, threatdialogkey, isinventory) {
  assert(isdefined(killstreaktype), "");
  assert(isdefined(level.killstreaks[killstreaktype]), "");
  level.killstreaks[killstreaktype].informdialog = informdialog;
  level.killstreaks[killstreaktype].taacomdialogbundlekey = taacomdialogbundlekey;
  level.killstreaks[killstreaktype].startdialogkey = startdialogkey;
  level.killstreaks[killstreaktype].enemystartdialogkey = enemystartdialogkey;
  level.killstreaks[killstreaktype].enemystartmultipledialogkey = enemystartmultipledialogkey;
  level.killstreaks[killstreaktype].hackeddialogkey = hackeddialogkey;
  level.killstreaks[killstreaktype].hackedstartdialogkey = hackedstartdialogkey;
  level.killstreaks[killstreaktype].requestdialogkey = requestdialogkey;
  level.killstreaks[killstreaktype].threatdialogkey = threatdialogkey;
  if(isdefined(pilotdialogarraykey)) {
    taacombundles = struct::get_script_bundles("mpdialog_taacom");
    foreach(bundle in taacombundles) {
      if(!isdefined(bundle.pilotbundles)) {
        bundle.pilotbundles = [];
      }
      bundle.pilotbundles[killstreaktype] = [];
      i = 0;
      field = pilotdialogarraykey + i;
      fieldvalue = getstructfield(bundle, field);
      while (isdefined(fieldvalue)) {
        bundle.pilotbundles[killstreaktype][i] = fieldvalue;
        i++;
        field = pilotdialogarraykey + i;
        fieldvalue = getstructfield(bundle, field);
      }
    }
  }
  if(!(isdefined(isinventory) && isinventory)) {
    register_dialog("inventory_" + killstreaktype, informdialog, taacomdialogbundlekey, pilotdialogarraykey, startdialogkey, enemystartdialogkey, enemystartmultipledialogkey, hackeddialogkey, hackedstartdialogkey, requestdialogkey, threatdialogkey, 1);
  }
}

function register_alt_weapon(killstreaktype, weaponname, isinventory) {
  assert(isdefined(killstreaktype), "");
  assert(isdefined(level.killstreaks[killstreaktype]), "");
  weapon = getweapon(weaponname);
  if(weapon == level.weaponnone) {
    return;
  }
  if(level.killstreaks[killstreaktype].weapon == weapon) {
    return;
  }
  if(!isdefined(level.killstreaks[killstreaktype].altweapons)) {
    level.killstreaks[killstreaktype].altweapons = [];
  }
  if(!isdefined(level.killstreakweapons[weapon])) {
    level.killstreakweapons[weapon] = killstreaktype;
  }
  level.killstreaks[killstreaktype].altweapons[level.killstreaks[killstreaktype].altweapons.size] = weapon;
  if(!(isdefined(isinventory) && isinventory)) {
    register_alt_weapon("inventory_" + killstreaktype, weaponname, 1);
  }
}

function register_remote_override_weapon(killstreaktype, weaponname, isinventory) {
  assert(isdefined(killstreaktype), "");
  assert(isdefined(level.killstreaks[killstreaktype]), "");
  weapon = getweapon(weaponname);
  if(level.killstreaks[killstreaktype].weapon == weapon) {
    return;
  }
  if(!isdefined(level.killstreaks[killstreaktype].remoteoverrideweapons)) {
    level.killstreaks[killstreaktype].remoteoverrideweapons = [];
  }
  if(!isdefined(level.killstreakweapons[weapon])) {
    level.killstreakweapons[weapon] = killstreaktype;
  }
  level.killstreaks[killstreaktype].remoteoverrideweapons[level.killstreaks[killstreaktype].remoteoverrideweapons.size] = weapon;
  if(!(isdefined(isinventory) && isinventory)) {
    register_remote_override_weapon("inventory_" + killstreaktype, weaponname, 1);
  }
}

function is_remote_override_weapon(killstreaktype, weapon) {
  if(isdefined(level.killstreaks[killstreaktype].remoteoverrideweapons)) {
    for (i = 0; i < level.killstreaks[killstreaktype].remoteoverrideweapons.size; i++) {
      if(level.killstreaks[killstreaktype].remoteoverrideweapons[i] == weapon) {
        return true;
      }
    }
  }
  return false;
}

function register_dev_dvars(killstreaktype) {
  /# /
  #
  assert(isdefined(killstreaktype), "");
  assert(isdefined(level.killstreaks[killstreaktype]), "");
  level.killstreaks[killstreaktype].devdvar = ("" + killstreaktype) + "";
  level.killstreaks[killstreaktype].devenemydvar = ("" + killstreaktype) + "";
  level.killstreaks[killstreaktype].devtimeoutdvar = ("" + killstreaktype) + "";
  setdvar(level.killstreaks[killstreaktype].devtimeoutdvar, 0);
  level thread register_devgui(killstreaktype);
}

function register_dev_debug_dvar(killstreaktype) {
  /# /
  #
  assert(isdefined(killstreaktype), "");
  assert(isdefined(level.killstreaks[killstreaktype]), "");
  level.killstreaks[killstreaktype].devdebugdvar = ("" + killstreaktype) + "";
  devgui_scorestreak_command_debugdvar(killstreaktype, level.killstreaks[killstreaktype].devdebugdvar);
}

function register_devgui(killstreaktype) {
  level endon("game_ended");
  wait(randomintrange(2, 20) * 0.05);
  give_type_all = "";
  give_type_enemy = "";
  if(isdefined(level.killstreaks[killstreaktype].devdvar)) {
    devgui_scorestreak_command_givedvar(killstreaktype, give_type_all, level.killstreaks[killstreaktype].devdvar);
  }
  if(isdefined(level.killstreaks[killstreaktype].devenemydvar)) {
    devgui_scorestreak_command_givedvar(killstreaktype, give_type_enemy, level.killstreaks[killstreaktype].devenemydvar);
  }
  if(isdefined(level.killstreaks[killstreaktype].devtimeoutdvar)) {
    devgui_scorestreak_command_timeoutdvar(killstreaktype, level.killstreaks[killstreaktype].devtimeoutdvar);
  }
}

function devgui_scorestreak_command_givedvar(killstreaktype, give_type, dvar) {
  devgui_scorestreak_command(killstreaktype, give_type, ("" + dvar) + "");
}

function devgui_scorestreak_command_timeoutdvar(killstreaktype, dvar) {
  devgui_scorestreak_dvar_toggle(killstreaktype, "", dvar);
}

function devgui_scorestreak_command_debugdvar(killstreaktype, dvar) {
  devgui_scorestreak_dvar_toggle(killstreaktype, "", dvar);
}

function devgui_scorestreak_dvar_toggle(killstreaktype, title, dvar) {
  setdvar(dvar, 0);
  devgui_scorestreak_command(killstreaktype, "Toggle " + title, ("toggle " + dvar) + " 1 0");
}

function devgui_scorestreak_command(killstreaktype, title, command) {
  /# /
  #
  assert(isdefined(killstreaktype), "");
  assert(isdefined(level.killstreaks[killstreaktype]), "");
  root = "";
  user_name = makelocalizedstring(level.killstreaks[killstreaktype].uiname);
  adddebugcommand((((((((root + user_name) + "") + killstreaktype) + "") + title) + "") + command) + "");
}

function should_draw_debug(killstreak) {
  /# /
  #
  assert(isdefined(killstreak), "");
  if(isdefined(level.killstreaks[killstreak]) && isdefined(level.killstreaks[killstreak].devdebugdvar)) {
    return getdvarint(level.killstreaks[killstreak].devdebugdvar);
  }
  return 0;
}

function register_tos_dvar(dvar) {
  level.teamops_dvar = dvar;
}

function allow_assists(killstreaktype, allow) {
  level.killstreaks[killstreaktype].allowassists = allow;
}

function set_team_kill_penalty_scale(killstreaktype, scale, isinventory) {
  level.killstreaks[killstreaktype].teamkillpenaltyscale = scale;
  if(!(isdefined(isinventory) && isinventory)) {
    set_team_kill_penalty_scale("inventory_" + killstreaktype, scale, 1);
  }
}

function override_entity_camera_in_demo(killstreaktype, value, isinventory) {
  level.killstreaks[killstreaktype].overrideentitycameraindemo = value;
  if(!(isdefined(isinventory) && isinventory)) {
    override_entity_camera_in_demo("inventory_" + killstreaktype, value, 1);
  }
}

function is_available(killstreak) {
  if(isdefined(level.menureferenceforkillstreak[killstreak])) {
    return true;
  }
  return false;
}

function get_by_menu_name(killstreak) {
  return level.menureferenceforkillstreak[killstreak];
}

function get_menu_name(killstreaktype) {
  assert(isdefined(level.killstreaks[killstreaktype]));
  return level.killstreaks[killstreaktype].menuname;
}

function get_level(index, killstreak) {
  killstreaklevel = level.killstreaks[get_by_menu_name(killstreak)].killstreaklevel;
  if(getdvarint("custom_killstreak_mode") == 2) {
    if(isdefined(self.killstreak[index]) && killstreak == self.killstreak[index]) {
      killsrequired = getdvarint((("custom_killstreak_" + index) + 1) + "_kills");
      if(killsrequired) {
        killstreaklevel = getdvarint((("custom_killstreak_" + index) + 1) + "_kills");
      }
    }
  }
  return killstreaklevel;
}

function give_if_streak_count_matches(index, killstreak, streakcount) {
  pixbeginevent("giveKillstreakIfStreakCountMatches");
  if(!isdefined(killstreak)) {
    println("");
  }
  if(isdefined(killstreak)) {
    println(("" + killstreak) + "");
  }
  if(!is_available(killstreak)) {
    println("");
  }
  if(self.pers["killstreaksEarnedThisKillstreak"] > index && util::isroundbased()) {
    hasalreadyearnedkillstreak = 1;
  } else {
    hasalreadyearnedkillstreak = 0;
  }
  if(isdefined(killstreak) && is_available(killstreak) && !hasalreadyearnedkillstreak) {
    killstreaklevel = get_level(index, killstreak);
    if(self hasperk("specialty_killstreak")) {
      reduction = getdvarint("perk_killstreakReduction");
      killstreaklevel = killstreaklevel - reduction;
      if(killstreaklevel <= 0) {
        killstreaklevel = 1;
      }
    }
    if(killstreaklevel == streakcount) {
      self give(get_by_menu_name(killstreak), streakcount);
      self.pers["killstreaksEarnedThisKillstreak"] = index + 1;
      pixendevent();
      return true;
    }
  }
  pixendevent();
  return false;
}

function give_for_streak() {
  if(!util::iskillstreaksenabled()) {
    return;
  }
  if(!isdefined(self.pers["totalKillstreakCount"])) {
    self.pers["totalKillstreakCount"] = 0;
  }
  given = 0;
  for (i = 0; i < self.killstreak.size; i++) {
    given = given | give_if_streak_count_matches(i, self.killstreak[i], self.pers["cur_kill_streak"]);
  }
}

function is_an_a_killstreak() {
  onkillstreak = 0;
  if(!isdefined(self.pers["kill_streak_before_death"])) {
    self.pers["kill_streak_before_death"] = 0;
  }
  streakplusone = self.pers["kill_streak_before_death"] + 1;
  if(self.pers["kill_streak_before_death"] >= 5) {
    onkillstreak = 1;
  }
  return onkillstreak;
}

function give(killstreaktype, streak, suppressnotification, noxp, tobottom) {
  pixbeginevent("giveKillstreak");
  self endon("disconnect");
  level endon("game_ended");
  had_to_delay = 0;
  killstreakgiven = 0;
  if(isdefined(noxp)) {
    if(self give_internal(killstreaktype, undefined, noxp, tobottom)) {
      killstreakgiven = 1;
      if(self.just_given_new_inventory_killstreak === 1) {
        self add_to_notification_queue(level.killstreaks[killstreaktype].menuname, streak, killstreaktype, noxp);
      }
    }
  } else if(self give_internal(killstreaktype, noxp)) {
    killstreakgiven = 1;
    if(self.just_given_new_inventory_killstreak === 1) {
      self add_to_notification_queue(level.killstreaks[killstreaktype].menuname, streak, killstreaktype, noxp);
    }
  }
  pixendevent();
}

function take(killstreak) {
  self endon("disconnect");
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
  if(isdefined(self.pers["killstreaks"][0])) {
    currentweapon = self getcurrentweapon();
    if(currentweapon == get_killstreak_weapon(self.pers["killstreaks"][0])) {
      primaries = self getweaponslistprimaries();
      if(primaries.size > 0) {
        self switchtoweapon(primaries[0]);
      }
    }
    self notify("oldest_killstreak_removed", self.pers["killstreaks"][0], self.pers["killstreak_unique_id"][0]);
    self remove_used_killstreak(self.pers["killstreaks"][0], self.pers["killstreak_unique_id"][0], 0);
  }
}

function give_internal(killstreaktype, do_not_update_death_count, noxp, tobottom) {
  self.just_given_new_inventory_killstreak = undefined;
  if(level.gameended) {
    return false;
  }
  if(!util::iskillstreaksenabled()) {
    return false;
  }
  if(!isdefined(level.killstreaks[killstreaktype])) {
    return false;
  }
  if(!isdefined(self.pers["killstreaks"])) {
    self.pers["killstreaks"] = [];
  }
  if(!isdefined(self.pers["killstreak_has_been_used"])) {
    self.pers["killstreak_has_been_used"] = [];
  }
  if(!isdefined(self.pers["killstreak_unique_id"])) {
    self.pers["killstreak_unique_id"] = [];
  }
  if(!isdefined(self.pers["killstreak_ammo_count"])) {
    self.pers["killstreak_ammo_count"] = [];
  }
  just_max_stack_removed_inventory_killstreak = undefined;
  if(isdefined(tobottom) && tobottom) {
    size = self.pers["killstreaks"].size;
    if(self.pers["killstreaks"].size >= level.maxinventoryscorestreaks) {
      self remove_oldest();
      just_max_stack_removed_inventory_killstreak = self.just_removed_used_killstreak;
    }
    for (i = size; i > 0; i--) {
      self.pers["killstreaks"][i] = self.pers["killstreaks"][i - 1];
      self.pers["killstreak_has_been_used"][i] = self.pers["killstreak_has_been_used"][i - 1];
      self.pers["killstreak_unique_id"][i] = self.pers["killstreak_unique_id"][i - 1];
      self.pers["killstreak_ammo_count"][i] = self.pers["killstreak_ammo_count"][i - 1];
    }
    self.pers["killstreaks"][0] = killstreaktype;
    self.pers["killstreak_unique_id"][0] = level.killstreakcounter;
    level.killstreakcounter++;
    if(isdefined(noxp)) {
      self.pers["killstreak_has_been_used"][0] = noxp;
    } else {
      self.pers["killstreak_has_been_used"][0] = 0;
    }
    if(size == 0) {
      weapon = get_killstreak_weapon(killstreaktype);
      ammocount = give_weapon(weapon, 1);
    }
    self.pers["killstreak_ammo_count"][0] = 0;
  } else {
    self.pers["killstreaks"][self.pers["killstreaks"].size] = killstreaktype;
    self.pers["killstreak_unique_id"][self.pers["killstreak_unique_id"].size] = level.killstreakcounter;
    level.killstreakcounter++;
    if(self.pers["killstreaks"].size > level.maxinventoryscorestreaks) {
      self remove_oldest();
      just_max_stack_removed_inventory_killstreak = self.just_removed_used_killstreak;
    }
    if(isdefined(noxp)) {
      self.pers["killstreak_has_been_used"][self.pers["killstreak_has_been_used"].size] = noxp;
    } else {
      self.pers["killstreak_has_been_used"][self.pers["killstreak_has_been_used"].size] = 0;
    }
    weapon = get_killstreak_weapon(killstreaktype);
    ammocount = give_weapon(weapon, 1);
    self.pers["killstreak_ammo_count"][self.pers["killstreak_ammo_count"].size] = ammocount;
  }
  self.just_given_new_inventory_killstreak = killstreaktype !== just_max_stack_removed_inventory_killstreak;
  return true;
}

function add_to_notification_queue(menuname, streakcount, hardpointtype, nonotify) {
  killstreaktablenumber = level.killstreakindices[menuname];
  if(!isdefined(killstreaktablenumber)) {
    return;
  }
  if(isdefined(nonotify) && nonotify) {
    return;
  }
  informdialog = get_killstreak_inform_dialog(hardpointtype);
  if(getdvarint("teamOpsEnabled") == 0) {
    self thread play_killstreak_ready_dialog(hardpointtype, 2.4);
    self thread play_killstreak_ready_sfx(hardpointtype);
    self luinotifyevent(&"killstreak_received", 2, killstreaktablenumber, istring(informdialog));
    self luinotifyeventtospectators(&"killstreak_received", 2, killstreaktablenumber, istring(informdialog));
  }
}

function has_equipped() {
  currentweapon = self getcurrentweapon();
  keys = getarraykeys(level.killstreaks);
  for (i = 0; i < keys.size; i++) {
    if(level.killstreaks[keys[i]].weapon == currentweapon) {
      return true;
    }
  }
  return false;
}

function _get_from_weapon(weapon) {
  keys = getarraykeys(level.killstreaks);
  foreach(key in keys) {
    killstreak = level.killstreaks[key];
    if(killstreak.weapon == weapon) {
      return key;
    }
    if(isdefined(killstreak.altweapons)) {
      foreach(altweapon in killstreak.altweapons) {
        if(altweapon == weapon) {
          return key;
        }
      }
    }
    if(isdefined(killstreak.remoteoverrideweapons)) {
      foreach(remoteoverrideweapon in killstreak.remoteoverrideweapons) {
        if(remoteoverrideweapon == weapon) {
          return key;
        }
      }
    }
  }
  return undefined;
}

function get_from_weapon(weapon) {
  if(weapon == level.weaponnone) {
    return undefined;
  }
  res = _get_from_weapon(weapon);
  if(!isdefined(res)) {
    return _get_from_weapon(weapon.rootweapon);
  }
  return res;
}

function give_weapon(weapon, isinventory, usestoredammo) {
  currentweapon = self getcurrentweapon();
  if(currentweapon != level.weaponnone && (!(isdefined(level.usingmomentum) && level.usingmomentum))) {
    weaponslist = self getweaponslist();
    for (idx = 0; idx < weaponslist.size; idx++) {
      carriedweapon = weaponslist[idx];
      if(currentweapon == carriedweapon) {
        continue;
      }
      switch (carriedweapon.name) {
        case "m32":
        case "minigun": {
          continue;
        }
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
  if(isdefined(level.usingmomentum) && level.usingmomentum) {
    self setinventoryweapon(weapon);
    if(weapon.iscarriedkillstreak) {
      if(!isdefined(self.pers["held_killstreak_ammo_count"][weapon])) {
        self.pers["held_killstreak_ammo_count"][weapon] = 0;
      }
      if(!isdefined(self.pers["held_killstreak_clip_count"][weapon])) {
        self.pers["held_killstreak_clip_count"][weapon] = weapon.clipsize;
      }
      if(!isdefined(self.pers["killstreak_quantity"][weapon])) {
        self.pers["killstreak_quantity"][weapon] = 0;
      }
      if(currentweapon == weapon && !isheldinventorykillstreakweapon(weapon)) {
        return weapon.maxammo;
      }
      if(isdefined(usestoredammo) && usestoredammo && (self.pers["killstreak_ammo_count"][self.pers["killstreak_ammo_count"].size - 1]) > 0) {
        switch (weapon.name) {
          case "inventory_minigun": {
            if(isdefined(self.minigunactive) && self.minigunactive) {
              return self.pers["held_killstreak_ammo_count"][weapon];
            }
            break;
          }
          case "inventory_m32": {
            if(isdefined(self.m32active) && self.m32active) {
              return self.pers["held_killstreak_ammo_count"][weapon];
            }
            break;
          }
          default: {
            break;
          }
        }
        self.pers["held_killstreak_ammo_count"][weapon] = self.pers["killstreak_ammo_count"][self.pers["killstreak_ammo_count"].size - 1];
        self loadout::setweaponammooverall(weapon, self.pers["killstreak_ammo_count"][self.pers["killstreak_ammo_count"].size - 1]);
      } else {
        self.pers["held_killstreak_ammo_count"][weapon] = weapon.maxammo;
        self.pers["held_killstreak_clip_count"][weapon] = weapon.clipsize;
        self loadout::setweaponammooverall(weapon, self.pers["held_killstreak_ammo_count"][weapon]);
      }
      return self.pers["held_killstreak_ammo_count"][weapon];
    }
    switch (weapon.name) {
      case "ai_tank_marker":
      case "combat_robot_marker":
      case "dart":
      case "inventory_ai_tank_marker":
      case "inventory_combat_robot_marker":
      case "inventory_dart":
      case "inventory_m32_drop":
      case "inventory_minigun_drop":
      case "inventory_missile_drone":
      case "inventory_supplydrop_marker":
      case "supplydrop_marker": {
        delta = 1;
        break;
      }
      default: {
        delta = 0;
        break;
      }
    }
    return change_killstreak_quantity(weapon, delta);
  }
  self setactionslot(4, "weapon", weapon);
  return 1;
}

function activate_next(do_not_update_death_count) {
  if(level.gameended) {
    return false;
  }
  if(isdefined(level.usingmomentum) && level.usingmomentum) {
    self setinventoryweapon(level.weaponnone);
  } else {
    self setactionslot(4, "");
  }
  if(!isdefined(self.pers["killstreaks"]) || self.pers["killstreaks"].size == 0) {
    return false;
  }
  killstreaktype = self.pers["killstreaks"][self.pers["killstreaks"].size - 1];
  if(!isdefined(level.killstreaks[killstreaktype])) {
    return false;
  }
  weapon = level.killstreaks[killstreaktype].weapon;
  wait(0.05);
  ammocount = give_weapon(weapon, 0, 1);
  if(weapon.iscarriedkillstreak) {
    self setweaponammoclip(weapon, self.pers["held_killstreak_clip_count"][weapon]);
    self setweaponammostock(weapon, ammocount - self.pers["held_killstreak_clip_count"][weapon]);
  }
  if(!isdefined(do_not_update_death_count) || do_not_update_death_count != 0) {
    self.pers["killstreakItemDeathCount" + killstreaktype] = self.deathcount;
  }
  return true;
}

function give_owned() {
  if(isdefined(self.pers["killstreaks"]) && self.pers["killstreaks"].size > 0) {
    self activate_next(0);
  }
}

function get_killstreak_quantity(killstreakweapon) {
  return true;
}

function change_killstreak_quantity(killstreakweapon, delta) {
  quantity = get_killstreak_quantity(killstreakweapon);
  previousquantity = quantity;
  quantity = quantity + delta;
  if(quantity > level.scorestreaksmaxstacking) {
    quantity = level.scorestreaksmaxstacking;
  }
  if(self hasweapon(killstreakweapon) == 0) {
    self takeweapon(killstreakweapon);
    self giveweapon(killstreakweapon);
    self seteverhadweaponall(1);
  }
  self.pers["killstreak_quantity"][killstreakweapon] = quantity;
  self setweaponammoclip(killstreakweapon, quantity);
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
  if(!isdefined(killstreak) || !isdefined(player.pers["killstreaks"])) {
    return false;
  }
  for (i = 0; i < self.pers["killstreaks"].size; i++) {
    if(player.pers["killstreaks"][i] == killstreak) {
      return true;
    }
  }
  return false;
}

function recordkillstreakbegindirect(recordstreakindex) {
  player = self;
  if(!isplayer(player) || !isdefined(recordstreakindex)) {
    return;
  }
  if(!isdefined(self.killstreakevents)) {
    player.killstreakevents = associativearray();
  }
  if(isdefined(self.killstreakevents[recordstreakindex])) {
    kills = player.killstreakevents[recordstreakindex];
    eventindex = player recordkillstreakevent(recordstreakindex);
    player killstreakrules::recordkillstreakenddirect(eventindex, recordstreakindex, kills);
    player.killstreakevents[recordstreakindex] = undefined;
  } else {
    eventindex = player recordkillstreakevent(recordstreakindex);
    player.killstreakevents[recordstreakindex] = eventindex;
  }
}

function remove_when_done(killstreak, haskillstreakbeenused, isfrominventory) {
  self endon("disconnect");
  continue_wait = 1;
  while (continue_wait) {
    self waittill("killstreak_done", successful, killstreaktype);
    if(killstreaktype == killstreak) {
      continue_wait = 0;
    }
  }
  if(successful) {
    print("" + get_menu_name(killstreak));
    killstreak_weapon = get_killstreak_weapon(killstreak);
    recordstreakindex = undefined;
    if(isdefined(level.killstreaks[killstreak].menuname)) {
      recordstreakindex = level.killstreakindices[level.killstreaks[killstreak].menuname];
      self recordkillstreakbegindirect(recordstreakindex);
    }
    if(isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
      if(isdefined(isfrominventory) && isfrominventory) {
        remove_used_killstreak(killstreak);
        if(self getinventoryweapon() == killstreak_weapon) {
          self setinventoryweapon(level.weaponnone);
        }
      } else {
        self change_killstreak_quantity(killstreak_weapon, -1);
      }
    } else {
      if(isdefined(level.usingmomentum) && level.usingmomentum) {
        if(isdefined(isfrominventory) && isfrominventory && self getinventoryweapon() == killstreak_weapon) {
          remove_used_killstreak(killstreak);
          self setinventoryweapon(level.weaponnone);
        } else {
          globallogic_score::_setplayermomentum(self, self.momentum - level.killstreaks[killstreaktype].momentumcost);
        }
      } else {
        remove_used_killstreak(killstreak);
      }
    }
    if(!(isdefined(level.usingmomentum) && level.usingmomentum)) {
      self setactionslot(4, "");
    }
    success = 1;
  }
  waittillframeend();
  self unhide_compass();
  currentweapon = self getcurrentweapon();
  killstreak_weapon = get_killstreak_weapon(killstreaktype);
  if(currentweapon == killstreak_weapon && killstreak_weapon.iscarriedkillstreak) {
    return;
  }
  if(successful && (!self has_killstreak_in_class(get_menu_name(killstreak)) || (isdefined(isfrominventory) && isfrominventory))) {
    switch_to_last_non_killstreak_weapon();
  } else {
    killstreakforcurrentweapon = get_from_weapon(currentweapon);
    if(currentweapon.isgameplayweapon) {
      if(isdefined(self.isplanting) && self.isplanting || (isdefined(self.isdefusing) && self.isdefusing)) {
        return;
      }
    }
    if(!isdefined(killstreakforcurrentweapon) && currentweapon.isheroweapon) {
      return;
    }
    if(successful || !isdefined(killstreakforcurrentweapon) || killstreakforcurrentweapon == killstreak) {
      switch_to_last_non_killstreak_weapon();
    }
  }
  if(!(isdefined(level.usingmomentum) && level.usingmomentum) || (isdefined(isfrominventory) && isfrominventory)) {
    if(successful) {
      activate_next();
    }
  }
}

function usekillstreak(killstreak, isfrominventory) {
  haskillstreakbeenused = get_if_top_killstreak_has_been_used();
  if(isdefined(self.selectinglocation)) {
    return;
  }
  self thread remove_when_done(killstreak, haskillstreakbeenused, isfrominventory);
  self thread trigger_killstreak(killstreak, isfrominventory);
}

function remove_used_killstreak(killstreak, killstreakid, take_weapon_after_use = 1) {
  self.just_removed_used_killstreak = undefined;
  if(!isdefined(self.pers["killstreaks"])) {
    return;
  }
  killstreakindex = undefined;
  for (i = self.pers["killstreaks"].size - 1; i >= 0; i--) {
    if(self.pers["killstreaks"][i] == killstreak) {
      if(isdefined(killstreakid) && self.pers["killstreak_unique_id"][i] != killstreakid) {
        continue;
      }
      killstreakindex = i;
      break;
    }
  }
  if(!isdefined(killstreakindex)) {
    return false;
  }
  self.just_removed_used_killstreak = killstreak;
  if(take_weapon_after_use && !self has_killstreak_in_class(get_menu_name(killstreak))) {
    self thread take_weapon_after_use(get_killstreak_weapon(killstreak));
  }
  arraysize = self.pers["killstreaks"].size;
  for (i = killstreakindex; i < (arraysize - 1); i++) {
    self.pers["killstreaks"][i] = self.pers["killstreaks"][i + 1];
    self.pers["killstreak_has_been_used"][i] = self.pers["killstreak_has_been_used"][i + 1];
    self.pers["killstreak_unique_id"][i] = self.pers["killstreak_unique_id"][i + 1];
    self.pers["killstreak_ammo_count"][i] = self.pers["killstreak_ammo_count"][i + 1];
  }
  self.pers["killstreaks"][arraysize - 1] = undefined;
  self.pers["killstreak_has_been_used"][arraysize - 1] = undefined;
  self.pers["killstreak_unique_id"][arraysize - 1] = undefined;
  self.pers["killstreak_ammo_count"][arraysize - 1] = undefined;
  return true;
}

function take_weapon_after_use(killstreakweapon) {
  self endon("disconnect");
  self endon("death");
  self endon("joined_team");
  self endon("joined_spectators");
  self waittill("weapon_change");
  inventoryweapon = self getinventoryweapon();
  if(inventoryweapon != killstreakweapon) {
    self takeweapon(killstreakweapon);
  }
}

function get_top_killstreak() {
  if(self.pers["killstreaks"].size == 0) {
    return undefined;
  }
  return self.pers["killstreaks"][self.pers["killstreaks"].size - 1];
}

function get_if_top_killstreak_has_been_used() {
  if(!(isdefined(level.usingmomentum) && level.usingmomentum)) {
    if(self.pers["killstreak_has_been_used"].size == 0) {
      return undefined;
    }
    return self.pers["killstreak_has_been_used"][self.pers["killstreak_has_been_used"].size - 1];
  }
}

function get_top_killstreak_unique_id() {
  if(self.pers["killstreak_unique_id"].size == 0) {
    return undefined;
  }
  return self.pers["killstreak_unique_id"][self.pers["killstreak_unique_id"].size - 1];
}

function get_killstreak_index_by_id(killstreakid) {
  for (index = self.pers["killstreak_unique_id"].size - 1; index >= 0; index--) {
    if(self.pers["killstreak_unique_id"][index] == killstreakid) {
      return index;
    }
  }
  return undefined;
}

function get_killstreak_momentum_cost(killstreak) {
  if(!(isdefined(level.usingmomentum) && level.usingmomentum)) {
    return 0;
  }
  if(!isdefined(killstreak)) {
    return 0;
  }
  assert(isdefined(level.killstreaks[killstreak]));
  return level.killstreaks[killstreak].momentumcost;
}

function get_killstreak_for_weapon(weapon) {
  if(isdefined(level.killstreakweapons[weapon])) {
    return level.killstreakweapons[weapon];
  }
  return level.killstreakweapons[weapon.rootweapon];
}

function get_killstreak_for_weapon_for_stats(weapon) {
  prefix = "inventory_";
  killstreak = get_killstreak_for_weapon(weapon);
  if(isdefined(killstreak)) {
    if(strstartswith(killstreak, prefix)) {
      killstreak = getsubstr(killstreak, prefix.size);
    }
  }
  return killstreak;
}

function is_killstreak_weapon_assist_allowed(weapon) {
  killstreak = get_killstreak_for_weapon(weapon);
  if(!isdefined(killstreak)) {
    return false;
  }
  if(level.killstreaks[killstreak].allowassists) {
    return true;
  }
  return false;
}

function get_killstreak_team_kill_penalty_scale(weapon) {
  killstreak = get_killstreak_for_weapon(weapon);
  if(!isdefined(killstreak)) {
    return 1;
  }
  return level.killstreaks[killstreak].teamkillpenaltyscale;
}

function should_override_entity_camera_in_demo(player, weapon) {
  killstreak = get_killstreak_for_weapon(weapon);
  if(!isdefined(killstreak)) {
    return false;
  }
  if(level.killstreaks[killstreak].overrideentitycameraindemo) {
    return true;
  }
  if(isdefined(player.remoteweapon) && (isdefined(player.remoteweapon.controlled) && player.remoteweapon.controlled)) {
    return true;
  }
  return false;
}

function wait_till_hero_weapon_is_fully_on(weapon) {
  self endon("death");
  self endon("disconnect");
  self endon("weapon_change");
  slot = self gadgetgetslot(weapon);
  while (true) {
    if(self ability_player::gadget_is_in_use(slot)) {
      self.lastnonkillstreakweapon = weapon;
      return;
    }
    wait(0.05);
  }
}

function track_weapon_usage() {
  self endon("death");
  self endon("disconnect");
  self.lastnonkillstreakweapon = self getcurrentweapon();
  lastvalidpimary = self getcurrentweapon();
  if(self.lastnonkillstreakweapon == level.weaponnone) {
    weapons = self getweaponslistprimaries();
    if(weapons.size > 0) {
      self.lastnonkillstreakweapon = weapons[0];
    } else {
      self.lastnonkillstreakweapon = level.weaponbasemelee;
    }
  }
  assert(self.lastnonkillstreakweapon != level.weaponnone);
  for (;;) {
    currentweapon = self getcurrentweapon();
    self waittill("weapon_change", weapon);
    if(weapons::is_primary_weapon(weapon)) {
      lastvalidpimary = weapon;
    }
    if(weapon == self.lastnonkillstreakweapon || weapon == level.weaponnone || weapon == level.weaponbasemelee) {
      continue;
    }
    if(weapon.isgameplayweapon) {
      continue;
    }
    if(isdefined(self.resurrect_weapon) && weapon == self.resurrect_weapon) {
      continue;
    }
    name = get_killstreak_for_weapon(weapon);
    if(isdefined(name) && !weapon.iscarriedkillstreak) {
      killstreak = level.killstreaks[name];
      continue;
    }
    if(currentweapon.isequipment) {
      if(self.lastnonkillstreakweapon.iscarriedkillstreak) {
        self.lastnonkillstreakweapon = lastvalidpimary;
      }
      continue;
    }
    if(weapon.isheroweapon) {
      if(weapon.gadget_heroversion_2_0) {
        if(weapon.isgadget && self getammocount(weapon) > 0) {
          self thread wait_till_hero_weapon_is_fully_on(weapon);
          continue;
        }
      }
    }
    self.lastnonkillstreakweapon = weapon;
  }
}

function killstreak_waiter() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self thread track_weapon_usage();
  self give_owned();
  for (;;) {
    self waittill("weapon_change", weapon);
    if(!is_killstreak_weapon(weapon)) {
      continue;
    }
    killstreak = get_killstreak_for_weapon(weapon);
    if(!(isdefined(level.usingmomentum) && level.usingmomentum)) {
      killstreak = get_top_killstreak();
      if(weapon != get_killstreak_weapon(killstreak)) {
        continue;
      }
    }
    if(is_remote_override_weapon(killstreak, weapon)) {
      continue;
    }
    inventorybuttonpressed = self inventorybuttonpressed() || isdefined(self.pers["isBot"]);
    waittillframeend();
    if(isdefined(self.usingkillstreakheldweapon) && self.usingkillstreakheldweapon && weapon.iscarriedkillstreak) {
      continue;
    }
    isfrominventory = undefined;
    if(isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
      if(weapon == self getinventoryweapon()) {
        isfrominventory = 1;
      } else if(self getammocount(weapon) <= 0 && weapon.name != "killstreak_ai_tank") {
        self switch_to_last_non_killstreak_weapon();
        continue;
      }
    } else if(isdefined(level.usingmomentum) && level.usingmomentum) {
      if(weapon == self getinventoryweapon() && inventorybuttonpressed) {
        isfrominventory = 1;
      } else if(self.momentum < level.killstreaks[killstreak].momentumcost) {
        self switch_to_last_non_killstreak_weapon();
        continue;
      }
    }
    if(!isdefined(level.starttime) && level.roundstartkillstreakdelay > 0) {
      display_unavailable_time();
      continue;
    }
    thread usekillstreak(killstreak, isfrominventory);
  }
}

function should_delay_killstreak(killstreaktype) {
  if(!isdefined(level.starttime)) {
    return false;
  }
  if(level.roundstartkillstreakdelay < (((gettime() - level.starttime) - level.discardtime) / 1000)) {
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
  if(isdefined(level.killstreaks[killstreaktype]) && (isdefined(level.killstreaks[killstreaktype].delaystreak) && level.killstreaks[killstreaktype].delaystreak)) {
    return true;
  }
  return false;
}

function get_xp_amount_for_killstreak(killstreaktype) {
  xpamount = 0;
  switch (level.killstreaks[killstreaktype].killstreaklevel) {
    case 1:
    case 2:
    case 3:
    case 4: {
      xpamount = 100;
      break;
    }
    case 5: {
      xpamount = 150;
      break;
    }
    case 6:
    case 7: {
      xpamount = 200;
      break;
    }
    case 8: {
      xpamount = 250;
      break;
    }
    case 9: {
      xpamount = 300;
      break;
    }
    case 10:
    case 11: {
      xpamount = 350;
      break;
    }
    case 12:
    case 13:
    case 14:
    case 15: {
      xpamount = 500;
      break;
    }
  }
  return xpamount;
}

function display_unavailable_time() {
  timeleft = int(level.roundstartkillstreakdelay - (globallogic_utils::gettimepassed() / 1000));
  if(timeleft <= 0) {
    timeleft = 1;
  }
  self iprintlnbold(&"MP_UNAVAILABLE_FOR_N", (" " + timeleft) + " ", & "EXE_SECONDS");
}

function trigger_killstreak(killstreaktype, isfrominventory) {
  assert(isdefined(level.killstreaks[killstreaktype].usefunction), "" + killstreaktype);
  self.usingkillstreakfrominventory = isfrominventory;
  if(level.infinalkillcam) {
    return false;
  }
  if(should_delay_killstreak(killstreaktype)) {
    display_unavailable_time();
  } else if([
      [level.killstreaks[killstreaktype].usefunction]
    ](killstreaktype)) {
    if(isdefined(self)) {
      if(!isdefined(self.pers[level.killstreaks[killstreaktype].usagekey])) {
        self.pers[level.killstreaks[killstreaktype].usagekey] = 0;
      }
      self.pers[level.killstreaks[killstreaktype].usagekey]++;
      self notify("killstreak_used", killstreaktype);
      self notify("killstreak_done", 1, killstreaktype);
    }
    self.usingkillstreakfrominventory = undefined;
    return true;
  }
  self.usingkillstreakfrominventory = undefined;
  if(isdefined(self)) {
    self notify("killstreak_done", 0, killstreaktype);
  }
  return false;
}

function add_to_killstreak_count(weapon) {
  if(!isdefined(self.pers["totalKillstreakCount"])) {
    self.pers["totalKillstreakCount"] = 0;
  }
  self.pers["totalKillstreakCount"]++;
}

function get_first_valid_killstreak_alt_weapon(killstreaktype) {
  assert(isdefined(level.killstreaks[killstreaktype]), "");
  if(isdefined(level.killstreaks[killstreaktype].altweapons)) {
    for (i = 0; i < level.killstreaks[killstreaktype].altweapons.size; i++) {
      if(isdefined(level.killstreaks[killstreaktype].altweapons[i])) {
        return level.killstreaks[killstreaktype].altweapons[i];
      }
    }
  }
  return level.weaponnone;
}

function should_give_killstreak(weapon) {
  if(getdvarint("teamOpsEnabled") == 1) {
    return false;
  }
  killstreakbuilding = getdvarint("scr_allow_killstreak_building");
  if(killstreakbuilding == 0) {
    if(is_weapon_associated_with_killstreak(weapon)) {
      return false;
    }
  }
  return true;
}

function point_is_in_danger_area(point, targetpos, radius) {
  return distance2d(point, targetpos) <= (radius * 1.25);
}

function print_killstreak_start_text(killstreaktype, owner, team, targetpos, dangerradius) {
  if(!isdefined(level.killstreaks[killstreaktype])) {
    return;
  }
  if(level.teambased) {
    players = level.players;
    if(!level.hardcoremode && isdefined(level.killstreaks[killstreaktype].inboundnearplayertext)) {
      for (i = 0; i < players.size; i++) {
        if(isalive(players[i]) && isdefined(players[i].pers["team"]) && players[i].pers["team"] == team) {
          if(point_is_in_danger_area(players[i].origin, targetpos, dangerradius)) {
            players[i] iprintlnbold(level.killstreaks[killstreaktype].inboundnearplayertext);
          }
        }
      }
    }
    if(isdefined(level.killstreaks[killstreaktype])) {
      for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        playerteam = player.pers["team"];
        if(isdefined(playerteam)) {
          if(playerteam == team) {
            player iprintln(level.killstreaks[killstreaktype].inboundtext, owner);
          }
        }
      }
    }
  } else if(!level.hardcoremode && isdefined(level.killstreaks[killstreaktype].inboundnearplayertext)) {
    if(point_is_in_danger_area(owner.origin, targetpos, dangerradius)) {
      owner iprintlnbold(level.killstreaks[killstreaktype].inboundnearplayertext);
    }
  }
}

function play_killstreak_firewall_being_hacked_dialog(killstreaktype, killstreakid) {
  if(self globallogic_audio::killstreak_dialog_queued("firewallBeingHacked", killstreaktype, killstreakid)) {
    return;
  }
  self globallogic_audio::play_taacom_dialog("firewallBeingHacked", killstreaktype, killstreakid);
}

function play_killstreak_firewall_hacked_dialog(killstreaktype, killstreakid) {
  if(self globallogic_audio::killstreak_dialog_queued("firewallHacked", killstreaktype, killstreakid)) {
    return;
  }
  self globallogic_audio::play_taacom_dialog("firewallHacked", killstreaktype, killstreakid);
}

function play_killstreak_being_hacked_dialog(killstreaktype, killstreakid) {
  if(self globallogic_audio::killstreak_dialog_queued("beingHacked", killstreaktype, killstreakid)) {
    return;
  }
  self globallogic_audio::play_taacom_dialog("beingHacked", killstreaktype, killstreakid);
}

function play_killstreak_hacked_dialog(killstreaktype, killstreakid, hacker) {
  self globallogic_audio::flush_killstreak_dialog_on_player(killstreakid);
  self globallogic_audio::play_taacom_dialog("hacked", killstreaktype);
  excludeself = [];
  excludeself[0] = self;
  if(level.teambased) {
    globallogic_audio::leader_dialog(level.killstreaks[killstreaktype].hackeddialogkey, self.team, excludeself);
    globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].hackedstartdialogkey, self.team, undefined, killstreakid);
  } else {
    self globallogic_audio::leader_dialog_on_player(level.killstreaks[killstreaktype].hackeddialogkey);
    hacker globallogic_audio::leader_dialog_on_player(level.killstreaks[killstreaktype].hackedstartdialogkey);
  }
}

function play_killstreak_start_dialog(killstreaktype, team, killstreakid) {
  if(!isdefined(killstreaktype) || !isdefined(killstreakid)) {
    return;
  }
  self notify("killstreak_start_" + killstreaktype);
  self notify("killstreak_start_inventory_" + killstreaktype);
  dialogkey = level.killstreaks[killstreaktype].requestdialogkey;
  if(!isdefined(self.currentkillstreakdialog) && isdefined(dialogkey) && isdefined(level.heroplaydialog)) {
    self thread[[level.heroplaydialog]](dialogkey);
  }
  excludeself = [];
  excludeself[0] = self;
  if(level.teambased) {
    globallogic_audio::leader_dialog(level.killstreaks[killstreaktype].startdialogkey, team, excludeself, undefined, killstreakid);
    globallogic_audio::leader_dialog_for_other_teams(level.killstreaks[killstreaktype].enemystartdialogkey, team, undefined, killstreakid);
  } else {
    globallogic_audio::leader_dialog(level.killstreaks[killstreaktype].enemystartdialogkey, undefined, excludeself, undefined, killstreakid);
  }
}

function play_killstreak_ready_sfx(killstreaktype) {
  if(!isdefined(level.gameended) || !level.gameended) {
    ready_sfx_alias = "mpl_killstreak_" + killstreaktype;
    if(isdefined(ready_sfx_alias)) {
      self playsoundtoplayer(ready_sfx_alias, self);
    }
  }
}

function play_killstreak_ready_dialog(killstreaktype, taacomwaittime) {
  self notify("killstreak_ready_" + killstreaktype);
  self endon("death");
  self endon("killstreak_start_" + killstreaktype);
  self endon("killstreak_ready_" + killstreaktype);
  level endon("game_ended");
  if(isdefined(level.gameended) && level.gameended) {
    return;
  }
  if(globallogic_audio::killstreak_dialog_queued("ready", killstreaktype)) {
    return;
  }
  if(isdefined(taacomwaittime)) {
    wait(taacomwaittime);
  }
  self globallogic_audio::play_taacom_dialog("ready", killstreaktype);
}

function play_destroyed_dialog_on_owner(killstreaktype, killstreakid) {
  if(!isdefined(self.owner) || !isdefined(self.team) || self.team != self.owner.team) {
    return;
  }
  self.owner globallogic_audio::flush_killstreak_dialog_on_player(killstreakid);
  self.owner globallogic_audio::play_taacom_dialog("destroyed", killstreaktype);
}

function play_taacom_dialog_on_owner(dialogkey, killstreaktype, killstreakid) {
  if(!isdefined(self.owner) || !isdefined(self.team) || self.team != self.owner.team) {
    return;
  }
  self.owner globallogic_audio::play_taacom_dialog(dialogkey, killstreaktype, killstreakid);
}

function play_pilot_dialog_on_owner(dialogkey, killstreaktype, killstreakid) {
  if(!isdefined(self.owner) || !isdefined(self.owner.team) || !isdefined(self.team) || self.team != self.owner.team) {
    return;
  }
  self.owner play_pilot_dialog(dialogkey, killstreaktype, killstreakid, self.pilotindex);
}

function play_pilot_dialog(dialogkey, killstreaktype, killstreakid, pilotindex) {
  if(!isdefined(killstreaktype) || !isdefined(pilotindex)) {
    return;
  }
  self globallogic_audio::killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid, pilotindex);
}

function play_taacom_dialog_response_on_owner(dialogkey, killstreaktype, killstreakid) {
  assert(isdefined(dialogkey));
  assert(isdefined(killstreaktype));
  if(!isdefined(self.owner) || !isdefined(self.team) || self.team != self.owner.team) {
    return;
  }
  self.owner play_taacom_dialog_response(dialogkey, killstreaktype, killstreakid, self.pilotindex);
}

function play_taacom_dialog_response(dialogkey, killstreaktype, killstreakid, pilotindex) {
  assert(isdefined(dialogkey));
  assert(isdefined(killstreaktype));
  if(!isdefined(pilotindex)) {
    return;
  }
  self globallogic_audio::play_taacom_dialog(dialogkey + pilotindex, killstreaktype, killstreakid);
}

function get_random_pilot_index(killstreaktype) {
  if(!isdefined(killstreaktype)) {
    return undefined;
  }
  taacombundle = struct::get_script_bundle("mpdialog_taacom", self.pers["mptaacom"]);
  if(!isdefined(taacombundle.pilotbundles[killstreaktype])) {
    return undefined;
  }
  numpilots = taacombundle.pilotbundles[killstreaktype].size;
  if(numpilots <= 0) {
    return undefined;
  }
  return randomint(numpilots);
}

function player_killstreak_threat_tracking(killstreaktype) {
  assert(isdefined(killstreaktype));
  self endon("death");
  self endon("delete");
  self endon("leaving");
  level endon("game_ended");
  while (true) {
    if(!isdefined(self.owner)) {
      return;
    }
    players = self.owner battlechatter::get_enemy_players();
    players = array::randomize(players);
    foreach(player in players) {
      if(!player battlechatter::can_play_dialog(1)) {
        continue;
      }
      lookangles = player getplayerangles();
      if(lookangles[0] < 270 || lookangles[0] > 330) {
        continue;
      }
      lookdir = anglestoforward(lookangles);
      eyepoint = player geteye();
      streakdir = vectornormalize(self.origin - eyepoint);
      dot = vectordot(streakdir, lookdir);
      if(dot < 0.94) {
        continue;
      }
      traceresult = bullettrace(eyepoint, self.origin, 1, player);
      if(traceresult["fraction"] >= 1 || traceresult["entity"] === self) {
        if(battlechatter::dialog_chance("killstreakSpotChance")) {
          player battlechatter::play_killstreak_threat(killstreaktype);
        }
        wait(battlechatter::mpdialog_value("killstreakSpotDelay", 0));
        break;
      }
    }
    wait(battlechatter::mpdialog_value("killstreakSpotInterval", 0.05));
  }
}

function get_killstreak_inform_dialog(killstreaktype) {
  if(isdefined(level.killstreaks[killstreaktype].informdialog)) {
    return level.killstreaks[killstreaktype].informdialog;
  }
  return "";
}

function get_killstreak_usage_by_killstreak(killstreaktype) {
  assert(isdefined(level.killstreaks[killstreaktype]), "");
  return get_killstreak_usage(level.killstreaks[killstreaktype].usagekey);
}

function get_killstreak_usage(usagekey) {
  if(!isdefined(self.pers[usagekey])) {
    return 0;
  }
  return self.pers[usagekey];
}

function on_player_spawned() {
  self endon("disconnect");
  pixbeginevent("_killstreaks.gsc/onPlayerSpawned");
  give_owned();
  if(!isdefined(self.pers["killstreaks"])) {
    self.pers["killstreaks"] = [];
  }
  if(!isdefined(self.pers["killstreak_has_been_used"])) {
    self.pers["killstreak_has_been_used"] = [];
  }
  if(!isdefined(self.pers["killstreak_unique_id"])) {
    self.pers["killstreak_unique_id"] = [];
  }
  if(!isdefined(self.pers["killstreak_ammo_count"])) {
    self.pers["killstreak_ammo_count"] = [];
  }
  size = self.pers["killstreaks"].size;
  if(size > 0) {
    self thread play_killstreak_ready_dialog(self.pers["killstreaks"][size - 1]);
  }
  self.killcamkilledbyent = undefined;
  pixendevent();
}

function on_joined_team() {
  self endon("disconnect");
  self setinventoryweapon(level.weaponnone);
  self.pers["cur_kill_streak"] = 0;
  self.pers["cur_total_kill_streak"] = 0;
  self setplayercurrentstreak(0);
  self.pers["totalKillstreakCount"] = 0;
  self.pers["killstreaks"] = [];
  self.pers["killstreak_has_been_used"] = [];
  self.pers["killstreak_unique_id"] = [];
  self.pers["killstreak_ammo_count"] = [];
  if(isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
    self.pers["killstreak_quantity"] = [];
    self.pers["held_killstreak_ammo_count"] = [];
    self.pers["held_killstreak_clip_count"] = [];
  }
}

function init_ride_killstreak(streak, always_allow = 0) {
  self disableusability();
  result = self init_ride_killstreak_internal(streak, always_allow);
  if(isdefined(self)) {
    self enableusability();
  }
  return result;
}

function watch_for_remove_remote_weapon() {
  self endon("endwatchforremoveremoteweapon");
  for (;;) {
    self waittill("remove_remote_weapon");
    self switch_to_last_non_killstreak_weapon();
    self enableusability();
  }
}

function init_ride_killstreak_internal(streak, always_allow) {
  if(isdefined(streak) && (streak == "qrdrone" || streak == "dart" || streak == "killstreak_remote_turret" || streak == "killstreak_ai_tank" || streak == "qrdrone" || streak == "sentinel")) {
    laptopwait = "timeout";
  } else {
    laptopwait = self util::waittill_any_timeout(0.6, "disconnect", "death", "weapon_switch_started");
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
    if(self.team == "spectator") {
      return "fail";
    }
    return "success";
  }
  if(self isempjammed() && (!(isdefined(self.ignoreempjammed) && self.ignoreempjammed))) {
    return "fail";
  }
  if(self is_interacting_with_object()) {
    return "fail";
  }
  self thread hud::fade_to_black_for_x_sec(0, 0.2, 0.4, 0.25);
  self thread watch_for_remove_remote_weapon();
  blackoutwait = self util::waittill_any_timeout(0.6, "disconnect", "death");
  self notify("endwatchforremoveremoteweapon");
  hostmigration::waittillhostmigrationdone();
  if(blackoutwait != "disconnect") {
    self thread clear_ride_intro(1);
    if(self.team == "spectator") {
      return "fail";
    }
  }
  if(always_allow) {
    if(blackoutwait == "disconnect") {
      return "disconnect";
    }
    return "success";
  }
  if(self isonladder()) {
    return "fail";
  }
  if(!isalive(self)) {
    return "fail";
  }
  if(self isempjammed() && (!(isdefined(self.ignoreempjammed) && self.ignoreempjammed))) {
    return "fail";
  }
  if(isdefined(self.laststand) && self.laststand) {
    return "fail";
  }
  if(self is_interacting_with_object()) {
    return "fail";
  }
  if(blackoutwait == "disconnect") {
    return "disconnect";
  }
  return "success";
}

function clear_ride_intro(delay) {
  self endon("disconnect");
  if(isdefined(delay)) {
    wait(delay);
  }
  self thread hud::screen_fade_in(0);
}

function killstreak_debug_think() {
  setdvar("", "");
  for (;;) {
    cmd = getdvarstring("");
    switch (cmd) {
      case "": {
        killstreak_data_dump();
        break;
      }
    }
    if(cmd != "") {
      setdvar("", "");
    }
    wait(0.5);
  }
}

function killstreak_data_dump() {
  iprintln("");
  println("");
  println("");
  keys = getarraykeys(level.killstreaks);
  for (i = 0; i < keys.size; i++) {
    data = level.killstreaks[keys[i]];
    type_data = level.killstreaktype[keys[i]];
    print(keys[i] + "");
    print(data.killstreaklevel + "");
    print(data.weapon.name + "");
    alt = 0;
    if(isdefined(data.altweapons)) {
      assert(data.altweapons.size <= 4);
      for (alt = 0; alt < data.altweapons.size; alt++) {
        print(data.altweapons[alt].name + "");
      }
    }
    while (alt < 4) {
      print("");
      alt++;
    }
    type = 0;
    if(isdefined(type_data)) {
      assert(type_data.size < 4);
      type_keys = getarraykeys(type_data);
      while (type < type_keys.size) {
        if(type_data[type_keys[type]] == 1) {
          print(type_keys[type] + "");
        }
        type++;
      }
    }
    while (type < 4) {
      print("");
      type++;
    }
    println("");
  }
  println("");
}

function is_interacting_with_object() {
  if(self iscarryingturret()) {
    return true;
  }
  if(isdefined(self.isplanting) && self.isplanting) {
    return true;
  }
  if(isdefined(self.isdefusing) && self.isdefusing) {
    return true;
  }
  return false;
}

function clear_using_remote(immediate, skipnotify) {
  if(!isdefined(self)) {
    return;
  }
  self.dofutz = 0;
  self.no_fade2black = 0;
  self clientfield::set_to_player("static_postfx", 0);
  if(isdefined(self.carryicon)) {
    self.carryicon.alpha = 1;
  }
  self.usingremote = undefined;
  self reset_killstreak_delay_killcam();
  self enableoffhandweapons();
  self enableweaponcycling();
  curweapon = self getcurrentweapon();
  if(isalive(self)) {
    self switch_to_last_non_killstreak_weapon(immediate);
  }
  if(!level.gameended) {
    self util::freeze_player_controls(0);
  }
  if(!(isdefined(skipnotify) && skipnotify)) {
    self notify("stopped_using_remote");
  }
  thread hide_tablet();
}

function hide_tablet() {
  self endon("disconnect");
  wait(0.2);
  self clientfield::set_player_uimodel("hudItems.remoteKillstreakActivated", 0);
}

function set_killstreak_delay_killcam(killstreak_name) {
  self.killstreak_delay_killcam = killstreak_name;
}

function reset_killstreak_delay_killcam() {
  self.killstreak_delay_killcam = undefined;
}

function hide_compass() {
  self clientfield::set("killstreak_hides_compass", 1);
}

function unhide_compass() {
  self clientfield::set("killstreak_hides_compass", 0);
}

function setup_health(killstreak_ref, max_health, low_health) {
  self.maxhealth = max_health;
  self.lowhealth = low_health;
  self.hackedhealthupdatecallback = & defaulthackedhealthupdatecallback;
  tablemaxhealth = killstreak_bundles::get_max_health(killstreak_ref);
  if(isdefined(tablemaxhealth)) {
    self.maxhealth = tablemaxhealth;
  }
  tablelowhealth = killstreak_bundles::get_low_health(killstreak_ref);
  if(isdefined(tablelowhealth)) {
    self.lowhealth = tablelowhealth;
  }
  tablehackedhealth = killstreak_bundles::get_hacked_health(killstreak_ref);
  if(isdefined(tablehackedhealth)) {
    self.hackedhealth = tablehackedhealth;
  } else {
    self.hackedhealth = self.maxhealth;
  }
}

function monitordamage(killstreak_ref, max_health, destroyed_callback, low_health, low_health_callback, emp_damage, emp_callback, allow_bullet_damage) {
  self endon("death");
  self endon("delete");
  self.health = 9999999;
  self.damagetaken = 0;
  self setup_health(killstreak_ref, max_health, low_health);
  assert(!isvehicle(self) || !issentient(self), "");
  while (true) {
    weapon_damage = undefined;
    self waittill("damage", damage, attacker, direction, point, type, tagname, modelname, partname, weapon, flags, inflictor, chargelevel);
    if(isdefined(self.invulnerable) && self.invulnerable) {
      continue;
    }
    if(!isdefined(attacker) || !isplayer(attacker)) {
      continue;
    }
    friendlyfire = weaponobjects::friendlyfirecheck(self.owner, attacker);
    if(!friendlyfire) {
      continue;
    }
    if(isdefined(self.owner) && attacker == self.owner) {
      continue;
    }
    isvalidattacker = 1;
    if(level.teambased) {
      isvalidattacker = isdefined(attacker.team) && attacker.team != self.team;
    }
    if(!isvalidattacker) {
      continue;
    }
    if(isdefined(self.killstreakdamagemodifier)) {
      damage = [
        [self.killstreakdamagemodifier]
      ](damage, attacker, direction, point, type, tagname, modelname, partname, weapon, flags, inflictor, chargelevel);
      if(damage <= 0) {
        continue;
      }
    }
    if(weapon.isemp && type == "MOD_GRENADE_SPLASH") {
      emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage(killstreak_ref, self.maxhealth);
      if(!isdefined(emp_damage_to_apply)) {
        emp_damage_to_apply = (isdefined(emp_damage) ? emp_damage : 1);
      }
      if(isdefined(emp_callback) && emp_damage_to_apply > 0) {
        self[[emp_callback]](attacker);
      }
      weapon_damage = emp_damage_to_apply;
    }
    if(isdefined(self.selfdestruct) && self.selfdestruct) {
      weapon_damage = self.maxhealth + 1;
    }
    if(!isdefined(weapon_damage)) {
      weapon_damage = killstreak_bundles::get_weapon_damage(killstreak_ref, self.maxhealth, attacker, weapon, type, damage, flags, chargelevel);
      if(!isdefined(weapon_damage)) {
        weapon_damage = get_old_damage(attacker, weapon, type, damage, allow_bullet_damage);
      }
    }
    if(weapon_damage > 0) {
      if(damagefeedback::dodamagefeedback(weapon, attacker)) {
        attacker thread damagefeedback::update(type);
      }
      self challenges::trackassists(attacker, weapon_damage, 0);
    }
    self.damagetaken = self.damagetaken + weapon_damage;
    if(!issentient(self) && weapon_damage > 0) {
      self.attacker = attacker;
    }
    if(self.damagetaken > self.maxhealth) {
      weaponstatname = "destroyed";
      switch (weapon.name) {
        case "auto_tow":
        case "tow_turret":
        case "tow_turret_drop": {
          weaponstatname = "kills";
          break;
        }
      }
      level.globalkillstreaksdestroyed++;
      attacker addweaponstat(getweapon(killstreak_ref), "destroyed", 1);
      if(isdefined(destroyed_callback)) {
        self thread[[destroyed_callback]](attacker, weapon);
      }
      return;
    }
    remaining_health = max_health - self.damagetaken;
    if(remaining_health < low_health && weapon_damage > 0) {
      if(isdefined(low_health_callback) && (!isdefined(self.currentstate) || self.currentstate != "damaged")) {
        self[[low_health_callback]](attacker, weapon);
      }
      self.currentstate = "damaged";
    }
    if(isdefined(self.extra_low_health) && remaining_health < self.extra_low_health && weapon_damage > 0) {
      if(isdefined(self.extra_low_health_callback) && !isdefined(self.extra_low_damage_notified)) {
        self[[self.extra_low_health_callback]](attacker, weapon);
        self.extra_low_damage_notified = 1;
      }
    }
  }
}

function defaulthackedhealthupdatecallback(hacker) {
  killstreak = self;
  assert(isdefined(self.maxhealth));
  assert(isdefined(self.hackedhealth));
  assert(isdefined(self.damagetaken));
  damageafterhacking = self.maxhealth - self.hackedhealth;
  if(self.damagetaken < damageafterhacking) {
    self.damagetaken = damageafterhacking;
  }
}

function ondamageperweapon(killstreak_ref, attacker, damage, flags, type, weapon, max_health, destroyed_callback, low_health, low_health_callback, emp_damage, emp_callback, allow_bullet_damage, chargelevel) {
  self.maxhealth = max_health;
  self.lowhealth = low_health;
  tablehealth = killstreak_bundles::get_max_health(killstreak_ref);
  if(isdefined(tablehealth)) {
    self.maxhealth = tablehealth;
  }
  tablehealth = killstreak_bundles::get_low_health(killstreak_ref);
  if(isdefined(tablehealth)) {
    self.lowhealth = tablehealth;
  }
  if(isdefined(self.invulnerable) && self.invulnerable) {
    return 0;
  }
  if(!isdefined(attacker) || !isplayer(attacker)) {
    return get_old_damage(attacker, weapon, type, damage, allow_bullet_damage);
  }
  friendlyfire = weaponobjects::friendlyfirecheck(self.owner, attacker);
  if(!friendlyfire) {
    return 0;
  }
  isvalidattacker = 1;
  if(level.teambased) {
    isvalidattacker = isdefined(attacker.team) && attacker.team != self.team;
  }
  if(!isvalidattacker) {
    return 0;
  }
  if(weapon.isemp && type == "MOD_GRENADE_SPLASH") {
    emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage(killstreak_ref, self.maxhealth);
    if(!isdefined(emp_damage_to_apply)) {
      emp_damage_to_apply = (isdefined(emp_damage) ? emp_damage : 1);
    }
    if(isdefined(emp_callback) && emp_damage_to_apply > 0) {
      self[[emp_callback]](attacker, weapon);
    }
    return emp_damage_to_apply;
  }
  weapon_damage = killstreak_bundles::get_weapon_damage(killstreak_ref, self.maxhealth, attacker, weapon, type, damage, flags, chargelevel);
  if(!isdefined(weapon_damage)) {
    weapon_damage = get_old_damage(attacker, weapon, type, damage, allow_bullet_damage);
  }
  if(weapon_damage <= 0) {
    return 0;
  }
  idamage = int(weapon_damage);
  if(idamage > self.health) {
    if(isdefined(destroyed_callback)) {
      self thread[[destroyed_callback]](attacker, weapon);
    }
  }
  return idamage;
}

function get_old_damage(attacker, weapon, type, damage, allow_bullet_damage) {
  switch (type) {
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET": {
      if(!allow_bullet_damage) {
        damage = 0;
        break;
      }
      if(isdefined(attacker) && isplayer(attacker)) {
        hasfmj = attacker hasperk("specialty_armorpiercing");
      }
      if(isdefined(hasfmj) && hasfmj) {
        damage = int(damage * level.cac_armorpiercing_data);
      }
      break;
    }
    case "MOD_EXPLOSIVE":
    case "MOD_PROJECTILE":
    case "MOD_PROJECTILE_SPLASH": {
      if(weapon.statindex == level.weaponpistolenergy.statindex || weapon.statindex != level.weaponshotgunenergy.statindex || weapon.statindex == level.weaponspecialcrossbow.statindex) {
        break;
      }
      if(isdefined(self.remotemissiledamage) && isdefined(weapon) && weapon.name == "remote_missile_missile") {
        damage = self.remotemissiledamage;
      } else if(isdefined(self.rocketdamage)) {
        damage = self.rocketdamage;
      }
      break;
    }
    default: {
      break;
    }
  }
  return damage;
}

function configure_team(killstreaktype, killstreakid, owner, influencertype, configureteamprefunction, configureteampostfunction, ishacked = 0) {
  killstreak = self;
  killstreak.killstreaktype = killstreaktype;
  killstreak.killstreakid = killstreakid;
  killstreak _setup_configure_team_callbacks(influencertype, configureteamprefunction, configureteampostfunction);
  killstreak configure_team_internal(owner, ishacked);
  owner thread trackactivekillstreak(killstreak);
}

function trackactivekillstreak(killstreak) {
  self endon("disconnect");
  killstreakindex = killstreak.killstreakid;
  if(isdefined(killstreakindex)) {
    self.pers["activeKillstreaks"][killstreakindex] = killstreak;
    killstreak util::waittill_any("killstreak_hacked", "death");
    self.pers["activeKillstreaks"][killstreakindex] = undefined;
  }
}

function getactivekillstreaks() {
  return self.pers["activeKillstreaks"];
}

function configure_team_internal(owner, ishacked) {
  killstreak = self;
  if(ishacked == 0) {
    killstreak.originalowner = owner;
    killstreak.originalteam = owner.team;
    killstreak thread killstreak_hacking::killstreak_switch_team(owner);
  } else {
    assert(killstreak.killstreakteamconfigured, "");
  }
  if(isdefined(killstreak.killstreakconfigureteamprefunction)) {
    killstreak thread[[killstreak.killstreakconfigureteamprefunction]](owner, ishacked);
  }
  if(isdefined(killstreak.killstreakinfluencertype)) {
    killstreak spawning::remove_influencers();
  }
  killstreak setteam(owner.team);
  killstreak.team = owner.team;
  if(!isai(killstreak)) {
    killstreak setowner(owner);
  }
  killstreak.owner = owner;
  killstreak.ownerentnum = owner.entnum;
  killstreak.pilotindex = killstreak.owner get_random_pilot_index(killstreak.killstreaktype);
  if(isdefined(killstreak.killstreakinfluencertype)) {
    killstreak spawning::create_entity_enemy_influencer(killstreak.killstreakinfluencertype, owner.team);
  }
  if(isdefined(killstreak.killstreakconfigureteampostfunction)) {
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

function watchteamchange(teamchangenotify) {
  self notify(teamchangenotify + "_Singleton");
  self endon(teamchangenotify + "_Singleton");
  killstreak = self;
  killstreak endon("death");
  killstreak endon(teamchangenotify);
  killstreak.owner util::waittill_any("joined_team", "disconnect", "joined_spectators", "emp_jammed");
  killstreak notify(teamchangenotify);
}

function should_not_timeout(killstreak) {
  /# /
  #
  assert(isdefined(killstreak), "");
  assert(isdefined(level.killstreaks[killstreak]), "");
  if(isdefined(level.killstreaks[killstreak].devtimeoutdvar)) {
    return getdvarint(level.killstreaks[killstreak].devtimeoutdvar);
  }
  return 0;
}

function waitfortimeout(killstreak, duration, callback, endcondition1, endcondition2, endcondition3) {
  if(should_not_timeout(killstreak)) {
    return;
  }
  self endon("killstreak_hacked");
  if(isdefined(endcondition1)) {
    self endon(endcondition1);
  }
  if(isdefined(endcondition2)) {
    self endon(endcondition2);
  }
  if(isdefined(endcondition3)) {
    self endon(endcondition3);
  }
  self thread waitfortimeouthacked(killstreak, callback, endcondition1, endcondition2, endcondition3);
  killstreakbundle = level.killstreakbundle[self.killstreaktype];
  self.killstreakendtime = gettime() + duration;
  if(isdefined(killstreakbundle) && isdefined(killstreakbundle.kstimeoutbeepduration)) {
    self waitfortimeoutbeep(killstreakbundle, duration);
  } else {
    hostmigration::migrationawarewait(duration);
  }
  self notify("kill_waitfortimeouthacked_thread");
  self.killstreaktimedout = 1;
  self.killstreakendtime = 0;
  self notify("timed_out");
  self[[callback]]();
}

function waitfortimeoutbeep(killstreakbundle, duration) {
  self endon("death");
  beepduration = killstreakbundle.kstimeoutbeepduration * 1000;
  hostmigration::migrationawarewait(max(duration - beepduration, 0));
  if(isvehicle(self)) {
    self clientfield::set("timeout_beep", 1);
  }
  if(isdefined(killstreakbundle.kstimeoutfastbeepduration)) {
    fastbeepduration = killstreakbundle.kstimeoutfastbeepduration * 1000;
    hostmigration::migrationawarewait(max(beepduration - fastbeepduration, 0));
    if(isvehicle(self)) {
      self clientfield::set("timeout_beep", 2);
    }
    hostmigration::migrationawarewait(fastbeepduration);
  }
  if(isvehicle(self)) {
    self clientfield::set("timeout_beep", 0);
  }
}

function waitfortimeouthacked(killstreak, callback, endcondition1, endcondition2, endcondition3) {
  self endon("kill_waitfortimeouthacked_thread");
  if(isdefined(endcondition1)) {
    self endon(endcondition1);
  }
  if(isdefined(endcondition2)) {
    self endon(endcondition2);
  }
  if(isdefined(endcondition3)) {
    self endon(endcondition3);
  }
  self waittill("killstreak_hacked");
  hackedduration = self killstreak_hacking::get_hacked_timeout_duration_ms();
  self.killstreakendtime = gettime() + hackedduration;
  hostmigration::migrationawarewait(hackedduration);
  self.killstreakendtime = 0;
  self notify("timed_out");
  self[[callback]]();
}

function update_player_threat(player) {
  heli = self;
  player.threatlevel = 0;
  dist = distance(player.origin, heli.origin);
  player.threatlevel = player.threatlevel + (((level.heli_visual_range - dist) / level.heli_visual_range) * 100);
  if(isdefined(heli.attacker) && player == heli.attacker) {
    player.threatlevel = player.threatlevel + 100;
  }
  if(isdefined(player.carryobject)) {
    player.threatlevel = player.threatlevel + 200;
  }
  if(isdefined(player.score)) {
    player.threatlevel = player.threatlevel + (player.score * 2);
  }
  if(player weapons::has_launcher()) {
    if(player weapons::has_lockon(heli)) {
      player.threatlevel = player.threatlevel + 1000;
    } else {
      player.threatlevel = player.threatlevel + 500;
    }
  }
  if(player weapons::has_hero_weapon()) {
    player.threatlevel = player.threatlevel + 300;
  }
  if(player weapons::has_lmg()) {
    player.threatlevel = player.threatlevel + 200;
  }
  if(isdefined(player.antithreat)) {
    player.threatlevel = player.threatlevel - player.antithreat;
  }
  if(player.threatlevel <= 0) {
    player.threatlevel = 1;
  }
}

function update_non_player_threat(non_player) {
  heli = self;
  non_player.threatlevel = 0;
  dist = distance(non_player.origin, heli.origin);
  non_player.threatlevel = non_player.threatlevel + (((level.heli_visual_range - dist) / level.heli_visual_range) * 100);
  if(non_player.threatlevel <= 0) {
    non_player.threatlevel = 1;
  }
}

function update_actor_threat(actor) {
  heli = self;
  actor.threatlevel = 0;
  dist = distance(actor.origin, heli.origin);
  actor.threatlevel = actor.threatlevel + (((level.heli_visual_range - dist) / level.heli_visual_range) * 100);
  if(isdefined(actor.owner)) {
    if(isdefined(heli.attacker) && actor.owner == heli.attacker) {
      actor.threatlevel = actor.threatlevel + 100;
    }
    if(isdefined(actor.owner.carryobject)) {
      actor.threatlevel = actor.threatlevel + 200;
    }
    if(isdefined(actor.owner.score)) {
      actor.threatlevel = actor.threatlevel + (actor.owner.score * 4);
    }
    if(isdefined(actor.owner.antithreat)) {
      actor.threatlevel = actor.threatlevel - actor.owner.antithreat;
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
  dog.threatlevel = dog.threatlevel + (((level.heli_visual_range - dist) / level.heli_visual_range) * 100);
}

function missile_valid_target_check(missiletarget) {
  heli2target_normal = vectornormalize(missiletarget.origin - self.origin);
  heli2forward = anglestoforward(self.angles);
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
  player.missilethreatlevel = player.missilethreatlevel + (((level.heli_missile_range - dist) / level.heli_missile_range) * 100);
  if(self missile_valid_target_check(player) == 0) {
    player.missilethreatlevel = 1;
    return;
  }
  if(isdefined(self.attacker) && player == self.attacker) {
    player.missilethreatlevel = player.missilethreatlevel + 100;
  }
  player.missilethreatlevel = player.missilethreatlevel + (player.score * 4);
  if(isdefined(player.antithreat)) {
    player.missilethreatlevel = player.missilethreatlevel - player.antithreat;
  }
  if(player.missilethreatlevel <= 0) {
    player.missilethreatlevel = 1;
  }
}

function update_missile_dog_threat(dog) {
  dog.missilethreatlevel = 1;
}

function killstreak_assist(victim, assister, killstreak) {
  victim recordkillstreakassist(victim, assister, killstreak);
}

function add_ricochet_protection(killstreak_id, owner, origin, ricochet_distance) {
  testing = 0;
  testing = getdvarint("", 0) == 2;
  if(!level.hardcoremode && !testing) {
    return;
  }
  if(!isdefined(ricochet_distance) || ricochet_distance == 0) {
    return;
  }
  if(!isdefined(owner.ricochet_protection)) {
    owner.ricochet_protection = [];
  }
  owner.ricochet_protection[killstreak_id] = spawnstruct();
  owner.ricochet_protection[killstreak_id].origin = origin;
  owner.ricochet_protection[killstreak_id].distancesq = ricochet_distance * ricochet_distance;
}

function set_ricochet_protection_endtime(killstreak_id, owner, endtime) {
  if(!isdefined(owner) || !isdefined(owner.ricochet_protection) || !isdefined(killstreak_id)) {
    return;
  }
  if(!isdefined(owner.ricochet_protection[killstreak_id])) {
    return;
  }
  owner.ricochet_protection[killstreak_id].endtime = endtime;
}

function remove_ricochet_protection(killstreak_id, owner) {
  if(!isdefined(owner) || !isdefined(owner.ricochet_protection) || !isdefined(killstreak_id)) {
    return;
  }
  owner.ricochet_protection[killstreak_id] = undefined;
}

function is_ricochet_protected(player) {
  if(!isdefined(player) || !isdefined(player.ricochet_protection)) {
    return false;
  }
  foreach(protection in player.ricochet_protection) {
    if(!isdefined(protection)) {
      continue;
    }
    if(isdefined(protection.endtime) && protection.endtime < gettime()) {
      continue;
    }
    if(distancesquared(protection.origin, player.origin) < protection.distancesq) {
      return true;
    }
  }
  return false;
}

function is_killstreak_start_blocked() {
  return isdefined(self.dart_thrown_time) && (gettime() - self.dart_thrown_time) < 1500;
}

function debug_ricochet_protection() {
  debug_wait = 0.5;
  debug_frames = (int(debug_wait / 0.05)) + 1;
  while (true) {
    if(getdvarint("", 0) == 0) {
      wait(2);
      continue;
    }
    wait(debug_wait);
    foreach(player in level.players) {
      if(!isdefined(player)) {
        continue;
      }
      if(!isdefined(player.ricochet_protection)) {
        continue;
      }
      foreach(protection in player.ricochet_protection) {
        if(!isdefined(protection)) {
          continue;
        }
        if(isdefined(protection.endtime) && protection.endtime < gettime()) {
          continue;
        }
        radius = sqrt(protection.distancesq);
        sphere(protection.origin, radius, (1, 1, 0), 0.25, 0, 36, debug_frames);
        circle(protection.origin, radius, (1, 0.5, 0), 0, 1, debug_frames);
        circle(protection.origin + vectorscale((0, 0, 1), 2), radius, (1, 0.5, 0), 0, 1, debug_frames);
      }
    }
  }
}