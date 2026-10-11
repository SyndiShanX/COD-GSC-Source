/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\laststand.gsc
***********************************************/

#using script_4a6760982b403bad;
#using scripts\common\anim;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\agent_drops;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_gamescore;
#using scripts\cp\cp_gameskill;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_merits;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_outofbounds;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\cp_relics;
#using scripts\cp\damage;
#using scripts\cp\equipment;
#using scripts\cp\equipment\nvg;
#using scripts\cp\events;
#using scripts\cp\gameobjects;
#using scripts\cp\globallogic;
#using scripts\cp\killcam;
#using scripts\cp\laststand;
#using scripts\cp\perks;
#using scripts\cp\persistence;
#using scripts\cp\pickups;
#using scripts\cp\points;
#using scripts\cp\powers\coop_molotov;
#using scripts\cp\rank;
#using scripts\cp\utility;
#using scripts\cp\utility\connect_event_aggregator;
#using scripts\cp\utility\player;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\pet_watch;
#using scripts\cp_mp\playerhealth;
#using scripts\cp_mp\quickprompt;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\team_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\tweakables;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\lower_message;
#namespace laststand;

function laststand_init() {
  if(getDvar(@ "hash_e6afce2cf5cf7515") == "1" || level.createfx_enabled) {
    return;
  }

  scripts\cp\utility\connect_event_aggregator::registeronconnectcallback(&laststand_onplayerconnect);
  setdvarifuninitialized(@ "hash_e5275954295ca7d4", 0);
  setdvarifuninitialized(@ "hash_e17def891365b5e8", 1);
  setdvarifuninitialized(@ "hash_d4a1513190c52ad0", 0);
  setdvarifuninitialized(@ "hash_7b387d839855fd02", 60);

  setdvarifuninitialized(@ "hash_c88f515e7c55af60", 0);
  setdvarifuninitialized(@ "hash_4d0a8a446d22b1e1", 0);

  if(getdvarint(@ "hash_c88f515e7c55af60")) {
    level.enable_manual_revive = 1;
  }

  val::group_register("laststand", ["offhand_primary_weapons", "offhand_secondary_weapons", "offhand_weapons"]);
  val::group_register("laststand_persistent", ["weapon_pickup", "weapon_switch", "gesture", "killstreaks", "supers", "usability", "melee"]);
  val::group_register("laststand_killstreak", ["usability", "weapon_switch", "gesture", "killstreaks", "supers", "fire", "melee", "offhand_primary_weapons", "offhand_secondary_weapons"]);
  val::group_register("laststand_revive", ["allow_movement", "usability", "reload", "fire", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "gesture", "allow_jump", "sprint", "melee"]);
  val::group_register("reviveShoot", ["weapon_switch", "offhand_weapons", "gesture", "killstreaks", "supers", "ads", "reload", "autoreload"]);
  val::group_register("gameEndFreeze", ["usability", "ads", "fire", "weapon_switch", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "allow_jump", "sprint", "crouch", "prone", "melee"]);
  level.laststandreviveents = [];
  level.revive_icon_entities = [];
  level.players_being_revived = [];
  level.var_a42b25ffada980 = 1;
  level.modeonexitlaststandfunc = &function_4fe89278a6b193b2;

  if(!isDefined(level.var_28bcdd92f005721)) {
    level.var_28bcdd92f005721 = 1;
  }

  function_37db281eb241645d(1);
  level.var_d5ab05b7947de15a = [makeweaponfromstring("iw8_gunless_last_stand_enter"), makeweaponfromstring("iw9_gunless_mp"), makeweaponfromstring("iw9_me_diveknife_mp"), makeweaponfromstring("ks_remote_device_mp")];
  scripts\engine\utility::registersharedfunc("shellshock", "lastStandInterruptDelayFunc", &getshellshockinterruptdelayms);
  level.modeplayerkilledspawn = &playerkilledspawn;
  registerwatchdvar("lastStandWeapon", "iw9_gunless_mp");
  registerwatchdvarint("lastStandHealth", 100);
  registerwatchdvarint("lastStandReviveHealth", 30);
  registerwatchdvarfloat("lastStandTimer", 30);
  registerwatchdvarfloat("lastStandInvulnTimer", 5.5);
  registerwatchdvarfloat("lastStandSuicideTimer", 0);
  registerwatchdvarfloat("lastStandReviveTimer", 1.5);
  registerwatchdvarfloat("lastStandReviveDecayScale", 0.5);
  registerwatchdvarfloat("lastStandWeaponDelay", 0);
  registerwatchdvarfloat("lastStandInvulnAfterRevive", 3);
  function_c72ff775cd61b11(@ "hash_7a5f532fb0761c4e", 0, 3);
  gametype = scripts\cp\utility::getgametype();
  level.laststandhealth = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", gametype, "_lastStandHealth"), @ "scr_player_laststandhealth");
  level.laststandrevivehealth = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", gametype, "_lastStandReviveHealth"), @ "hash_555967257cd98a4a");

  if(level.laststandhealth > scripts\mp\tweakables::gettweakablevalue("player", "maxhealth")) {
    level.laststandhealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");
  }

  if(level.laststandrevivehealth > scripts\mp\tweakables::gettweakablevalue("player", "maxhealth")) {
    level.laststandrevivehealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");
  }

  level.laststandweapon = getoverridedvarexceptmatchrulesvalues(hashcat(@ "scr_", gametype, "_lastStandWeapon"), @ "hash_ab99ad42c8f9d6fd");
  level.laststandinvulntime = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", gametype, "_lastStandInvulnTime"), @ "scr_player_laststandinvulntime");
  level.laststandrevivedecayscale = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", gametype, "_lastStandReviveDecayScale"), @ "hash_e0f04861824e8440");
  level.laststandrevivetimer = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", gametype, "_lastStandReviveTimer"), @ "hash_e89b9c15abbfb1ad");
  level.laststandsuicidetimer = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", gametype, "_lastStandSuicideTimer"), @ "hash_812e42c73d4bd8d0");
  level.laststandtimer = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", gametype, "_lastStandTimer"), @ "hash_546d8a10bb4e83de");
  level.laststandweapondelay = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", gametype, "_lastStandWeaponDelay"), @ "hash_c47411f597dae120");
  level.laststandinvulnafterrevive = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", gametype, "_lastStandInvulnAfterRevive"), @ "hash_cdc84574d1513280");
  setdvarifuninitialized(@ "hash_c959af6f995bf79a", 0);
  setdvarifuninitialized(@ "hash_ccfb1fe297ce6f9b", 0.3);
  level thread laststandmonitor();

  level thread function_9168ee31efcf3393();
  level thread function_e7884f1619dc53be();
  level thread function_cb1f25df9191cd3c();

  cmd = "devgui_cmd \"CP Debug / Last Stand / Enter Last Stand\" \"set scr_start_debug laststand_enter\" \n";
  scripts\cp\utility::addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug / Last Stand / Enable Revive Icon\" \"set scr_start_debug enableReviveIcon\" \n";
  scripts\cp\utility::addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug / Last Stand / Disable Revive Icon\" \"set scr_start_debug disableReviveIcon\" \n";
  scripts\cp\utility::addentrytodevgui(cmd);
  cmd = "devgui_cmd \"CP Debug / Last Stand / Allow Manual Revive From Spectatate\" \"set scr_allowManualReviveFromSpectate 1\" \n";
  scripts\cp\utility::addentrytodevgui(cmd);
}

function laststand_onplayerconnect() {
  foreach(player in level.players) {
    player function_9b04c8abb560ba40();
  }
}

function function_9b04c8abb560ba40() {
  scripts\cp\globallogic::broadcast_status(self, 0);
  entity_num = self getentitynumber();
  self setclientomnvar("ui_client_num", entity_num);
  scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "ui_client_num", entity_num);
  scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "laststand_time_ms", 0);
  scripts\cp\utility::function_1dbc717085326045(0, 0, -1);
  self setplayerdata("cp", "EoGPlayer", entity_num, "ui_revivee_entity_num", -1);
  scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "ui_dog_tags_entity_num", -1);
}

function function_a44f7e2d76d0108() {
  entity_num = self getentitynumber();
  timeleft = level.laststandtimer;
  dvar_value = 0;

  switch (dvar_value) {
    case 0:
      scripts\cp\globallogic::broadcast_status(self, 1);
    case 1:
      scripts\cp\persistence::eog_player_update_stat("downs", 1);
    case 2:
    case 3:
      self setclientomnvar("ui_is_laststand", 1);
    case 4:
      self setclientomnvar("ui_client_num", entity_num);
    case 5:
      scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "ui_client_num", entity_num);
    case 6:
      scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "laststand_time_ms", int(timeleft * 1000));
      break;
  }
}

function function_3d86b15e0372a8c1() {
  function_9b04c8abb560ba40();
}

function function_d9adf40567afe0ec(dvar, value) {}

function playerkilledspawn(deathdata) {
  if(istrue(level.var_307ad42b8f2cce95)) {
    return false;
  }

  return true;
}

function laststandthink(damage_data, dokillcam) {
  level endon("game_ended");
  onenter(damage_data, dokillcam);
  result = "";

  if(istrue(self.shouldskiplaststand)) {
    if(istrue(level.var_2dce4d6dcb6c3fb9)) {
      scripts\cp\utility::store_weapons_status(level.var_d5ab05b7947de15a, 1);
      scripts\cp\equipment::store_equipment();
    }

    result = "last_stand_bleedout";
    wait 0.5;
  } else {
    result = waittill_any_return_no_endon_death_5("last_stand_heal_success", "last_stand_revived", "last_stand_bleedout", "death_or_disconnect", "last_stand_self_revive");
  }

  if(getdvarint(@ "hash_4d0a8a446d22b1e1")) {
    iprintlnbold(result);
  }

  switch (result) {
    case #"hash_d95fe2980633f282":
      onrevive();
      break;
    case #"hash_a7951892dd77e7b":
      onrevive(1);
      break;
    case #"hash_7720db6a74f74d2b":
      onbleedout(undefined, undefined, undefined, damage_data);
      break;
    case #"hash_3ea67ab430b19bc5":
      onrevive(0, 1);
      break;
    case #"hash_cbbbbafae54d0dd6":
      if(!gameflag("prematch_done")) {
        ondeath();
      }

      break;
  }
}

function onenter(damage_data, dokillcam) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  self notify("last_stand_start");

  if(!istrue(level.gameended)) {
    level.laststandentered = 1;
  }

  self setclientomnvar("ui_stop_armor_hint", 1);
  scripts\cp\globallogic::broadcast_status(self, 1);
  scripts\cp\persistence::eog_player_update_stat("downs", 1);
  scripts\cp\cp_analytics::logevent_downed(self, damage_data.attacker);

  if(isDefined(level.var_51c1068f1991312e) && dokillcam) {
    scripts\cp\damage::playerkilled_deathscene(level.var_51c1068f1991312e);
  }

  gameshouldend = function_5de995015a65e87d(self, 1);

  if(gameshouldend && isDefined(level.endgame) && isDefined(level.end_game_string_index)) {
    player_vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(player_vehicle)) {
      seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(player_vehicle, self);
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(player_vehicle, seatid, self, undefined, 1);
    }

    if(function_3a7452328b016d0c()) {
      damage_data.weaponfullstring = getcompleteweaponname(damage_data.objweapon);
      namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_player_death", damage_data);
    }

    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
  }

  if(getdvarint(@ "hash_d4a1513190c52ad0", 0) && scripts\cp\utility::touchingbadtrigger()) {
    self.shouldskiplaststand = 1;
  }

  if(!istrue(level.var_a42b25ffada980) || istrue(self.shouldskiplaststand)) {
    return 0;
  }

  scripts\cp\utility::disable_backpack_inventory(1);
  self setclientomnvar("ui_is_laststand", 1);
  setplayerselfrevivingextrainfo(0);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, #"bc_status_player_last_stand");
  healthvalue = level.laststandhealth;
  thread last_stand_sfx();
  self showlegsandshadow();

  if(!function_3ebb302e8386186()) {
    healthvalue = getwatcheddvar("<dev string:x1c>");

    if(!isDefined(healthvalue)) {
      healthvalue = getdvarint(@ "scr_player_laststandhealth", 100);
    }

    if(healthvalue > scripts\mp\tweakables::gettweakablevalue("<dev string:x2c>", "<dev string:x33>")) {
      healthvalue = scripts\mp\tweakables::gettweakablevalue("<dev string:x2c>", "<dev string:x33>");
    }
  }

  if(!gameshouldend) {
    self.health = healthvalue;
  }

  thread makelaststandinvuln();
  scripts\cp\utility::giveperk("specialty_block_health_regen");
  self.inlaststand = 1;
  self.playergoingintols = undefined;
  self.hasshownlaststandicon = 0;
  self.laststandoldweaponobj = scripts\cp\utility::getweapontoswitchbackto();

  if(getdvarint(@ "hash_7bb41608649743f4", 0) != 0) {
    self canceloffhands();
  } else if(getdvarint(@ "hash_112f10fcbe78647", 0) != 0) {
    self releaseoffhand();
  }

  self.navmodifier = createnavobstaclebyent(self);
  thread function_dcdb0ac73a967450();
  laststandweapon = level.laststandweapon;

  if(!function_3ebb302e8386186()) {
    laststandweapon = getwatcheddvar("<dev string:x3d>");

    if(!isDefined(laststandweapon)) {
      laststandweapon = getDvar(@ "hash_ab99ad42c8f9d6fd", "<dev string:x4d>");
    }
  }

  if(isDefined(level.laststandweaponcallback) && getdvarint(@ "hash_ddd02929770fcc8c", 0)) {
    laststandweapon = self[[level.laststandweaponcallback]]();
  }

  if(!isweapon(laststandweapon)) {
    laststandweapon = makeweapon(laststandweapon);
  }

  self stopanimscriptsceneevent();

  if(self isviewmodelanimplaying()) {
    self stopviewmodelanim();
  }

  if(istrue(self.killstreaklaststand) && isDefined(level.killstreak_laststand_func)) {
    self[[level.killstreak_laststand_func]]();
    return;
  }

  if(isDefined(level.modeonlaststandfunc)) {
    self[[level.modeonlaststandfunc]]();
  }

  if(isDefined(level.levelonlaststandfunc)) {
    self thread[[level.levelonlaststandfunc]]();
  }

  if(isDefined(level.customlaststandactionset)) {
    self.laststandactionset = level.customlaststandactionset;
  } else {
    self.laststandactionset = "laststand";
  }

  if(isDefined(self.vehicle)) {
    self waittill("vehicle_exit");
  }

  val::group_set(self.laststandactionset, 0);
  val::group_set("laststand_persistent", 0);
  thread handlelaststandweapongivepipeline(laststandweapon);

  if(isDefined(level.addlaststandoverheadiconcallback)) {
    self[[level.addlaststandoverheadiconcallback]]();
  } else {
    addoverheadicon();
  }

  var_276b87b88716c2a5 = level.laststandsuicidetimer;

  if(!function_3ebb302e8386186()) {
    var_276b87b88716c2a5 = getwatcheddvar("<dev string:x5c>");

    if(!isDefined(var_276b87b88716c2a5)) {
      var_276b87b88716c2a5 = getdvarfloat(@ "hash_a4353f59ee601382", 0);
    }
  }

  _shellshock("last_stand_mp", "damage", var_276b87b88716c2a5, 0);
  thread revivesetup(self);
  self.fastcrouchspeedmod = getdvarfloat(@ "hash_1a0de898609317b4", 0);
  scripts\cp_mp\challenges::stopchallengetimer("alive_not_downed");
  childthread stucktime(var_276b87b88716c2a5, damage_data);

  if(getdvarint(@ "hash_e5275954295ca7d4", 0)) {
    thread suicidesetup();
  }

  if(getdvarint(@ "hash_e17def891365b5e8")) {
    thread dodamagewhiledown();
  }
}

function function_dcdb0ac73a967450() {
  self endon("death_or_disconnect");
  self endon("laststand_revived");
  level endon("game_ended");

  while(true) {
    self.navmodifier = function_d37eb02511329ad6(self);
    wait 0.1;
  }
}

function last_stand_sfx() {
  if(!istrue(self.deathsdoorsfx)) {
    self.deathsdoorsfx = 1;
    self stoplocalsound("deaths_door_out");
    self playlocalsound("deaths_door_in");
    thread scripts\common\damage_effects::function_501be800abf11f33(0.2, 1);
    self enableplayerbreathsystem(0);
    thread scripts\common\damage_effects::playerbreathingpainsound();
  }
}

function handlelaststandweapongivepipeline(laststandweapon) {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  level endon("game_ended");

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == "iw9_armor_plate_deploy_mp") {
    waitframe();
  }

  waitframe();
  var_dec5f8278c01ccc3 = makeweapon("iw8_gunless_last_stand_enter");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_dec5f8278c01ccc3, undefined, undefined, 0);
  thread _switchtoweapon(var_dec5f8278c01ccc3);
  wait 1.7;
  self notify("last_stand_transition_done");
  _takeweapon(var_dec5f8278c01ccc3);

  if(!isweapon(laststandweapon) && (laststandweapon == "none" || laststandweapon == "iw9_gunless_mp")) {
    givedefaultlaststandweapon();
    return;
  }

  laststandweapondelay = level.laststandweapondelay;

  if(!function_3ebb302e8386186()) {
    laststandweapondelay = getwatcheddvar("<dev string:x72>");

    if(!isDefined(laststandweapondelay)) {
      laststandweapondelay = getdvarint(@ "hash_c47411f597dae120", 0);
    }
  }

  if(laststandweapondelay > 0) {
    thread handlelaststandweapongivedelay(laststandweapondelay, laststandweapon);
    return;
  }

  givelaststandweapon(laststandweapon);
}

function takelaststandtransitionweapon() {
  player = self;
  var_dec5f8278c01ccc3 = makeweapon("iw8_gunless_last_stand_enter");

  if(player hasweapon(var_dec5f8278c01ccc3)) {
    player _takeweapon(var_dec5f8278c01ccc3);
  }
}

function handlelaststandweapongivedelay(laststandweapondelay, laststandweapon) {
  self endon("death");
  self endon("last_stand_revived");
  level endon("game_ended");
  defaultlaststandweapon = givedefaultlaststandweapon();

  if(issameweapon(defaultlaststandweapon, laststandweapon)) {
    return;
  }

  wait laststandweapondelay;
  self notify("end_switchToFists");
  _takeweapon(defaultlaststandweapon);
  givelaststandweapon(laststandweapon);
}

function givedefaultlaststandweapon() {
  var_ae0da1578aece301 = getwatcheddvar("lastStandWeapon");

  if(!isDefined(var_ae0da1578aece301)) {
    var_ae0da1578aece301 = "iw9_gunless_mp";
  }

  defaultlaststandweapon = makeweapon(var_ae0da1578aece301);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(defaultlaststandweapon, undefined, undefined, 1);
  thread _switchtoweapon(defaultlaststandweapon);
  return defaultlaststandweapon;
}

function givelaststandweapon(laststandweapon) {
  if(!isweapon(laststandweapon)) {
    laststandweapon = scripts\cp_mp\weapon::buildweapon(laststandweapon);
  }

  fullname = getcompleteweaponname(laststandweapon);

  if(!self hasweapon(fullname)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(laststandweapon, undefined, undefined, 1);
  }

  thread _switchtoweapon(fullname);
}

function disableweaponsovertime(t) {
  level endon("game_ended");
  val::set("disableWeaponsOverTime", "weapon", 0);
  waittill_any_timeout_1(t, "death_or_disconnect");
  val::set("disableWeaponsOverTime", "weapon", 1);
}

function switchtofists(laststandweapon) {
  self endon("death_or_disconnect");
  self endon("end_switchToFists");

  while(domonitoredweaponswitch(laststandweapon, 1) == 0) {
    waitframe();
  }
}

function dodamagewhiledown() {
  level endon("game_ended");
  self endon("death");
  self endon("laststand_revived");
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  self endon("entered_spectate");
  basehealth = level.laststandhealth;
  bleedouttime = level.laststandtimer;

  if(!function_3ebb302e8386186()) {
    basehealth = getwatcheddvar("<dev string:x1c>");

    if(!isDefined(basehealth)) {
      basehealth = getdvarint(@ "scr_player_laststandhealth", 100);
    }

    if(basehealth > scripts\mp\tweakables::gettweakablevalue("<dev string:x2c>", "<dev string:x33>")) {
      basehealth = scripts\mp\tweakables::gettweakablevalue("<dev string:x2c>", "<dev string:x33>");
    }

    bleedouttime = getwatcheddvar("<dev string:x87>");

    if(!isDefined(bleedouttime)) {
      bleedouttime = getdvarfloat(@ "hash_546d8a10bb4e83de", 30);
    }
  }

  if(bleedouttime <= 0) {
    onbleedout();
    return;
  }

  var_76e563db5d11a0ea = float(basehealth) / float(bleedouttime);
  var_76e563db5d11a0ea /= max(getmatchrulesdata("commonOption", "lastStandDamageTakenScalar"), 0.01);
  wait 1;
  laststanddamageweapon = makeweapon("iw8_gunless");

  if(getdvarint(@ "hash_e5275954295ca7d4", 0)) {
    thread suicidesetup();
  }

  damagedealt = 0;

  while(self.health > 0) {
    if(self isinexecutionvictim()) {
      wait 1;
      continue;
    }

    if(isalive(self) && !istrue(istrue(self.beingrevived) || istrue(self.isselfreviving))) {
      var_703f141d7d6fea1e = int(damagedealt + var_76e563db5d11a0ea) - int(damagedealt);
      damagedealt += var_76e563db5d11a0ea;
      self.islaststandbleedoutdmg = 1;
      self dodamage(var_703f141d7d6fea1e, self.origin, self, undefined, "MOD_DOWN", laststanddamageweapon, "none");
      self.islaststandbleedoutdmg = undefined;
    }

    if(self.health <= 0) {
      onbleedout();
    }

    wait 1;
  }
}

function stucktime(var_276b87b88716c2a5, damage_data) {
  self.stuckinlaststand = 1;

  if(isDefined(var_276b87b88716c2a5) && var_276b87b88716c2a5 > 0) {
    wait var_276b87b88716c2a5;
  }

  self.stuckinlaststand = 0;
  timeleft = level.laststandtimer;

  if(!function_3ebb302e8386186()) {
    timeleft = getwatcheddvar("<dev string:x87>");

    if(!isDefined(timeleft)) {
      timeleft = getdvarfloat(@ "hash_546d8a10bb4e83de", 30);
    }
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    assertex(timeleft > 0, "Last Stand: Bleedout time must be greater than 0");
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() && timeleft != 0) {
    timeleft = max(timeleft - level.laststandsuicidetimer, 1);
  } else {
    timeleft = 0;
  }

  entity_num = self getentitynumber();
  self setclientomnvar("ui_client_num", entity_num);
  scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "ui_client_num", entity_num);
  scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "laststand_time_ms", int(timeleft * 1000));
  self.timeuntilbleedout = timeleft;
  thread bleedoutthink(damage_data);

  if(getdvarint(@ "hash_e5275954295ca7d4", 0)) {
    thread suicidesetup();
  }
}

function selfrevivebuttonPressed(downedplayer) {
  if(downedplayer usinggamepad()) {
    return downedplayer weaponswitchbuttonPressed();
  }

  return downedplayer activatekeypressed();
}

function selfrevivethink() {
  triggerent = self;
  downedplayer = triggerent.owner;
  level endon("game_ended");
  triggerent endon("death");
  downedplayer endon("death_or_disconnect");
  downedplayer endon("last_stand_revived");
  downedplayer thread scripts\cp\utility::function_b94df25aa73f60a0();
  usetime = getwatcheddvar("lastStandReviveTimer") * 1000;

  if(downedplayer scripts\cp\utility::_hasperk("specialty_survivor") && isDefined(level.var_d69a2eb29ce33499)) {
    usetime = level.var_d69a2eb29ce33499;
  }

  if(downedplayer scripts\cp\utility::_hasperk("specialty_br_faster_revive")) {
    usetime *= 0.75;
  }

  triggerent.usetime = usetime;

  if(!isDefined(self.curprogress)) {
    self.curprogress = 0;
  }

  downedplayer.var_80617a8667d0e71f = gettime() + 750;

  while(true) {
    if(selfrevivebuttonPressed(downedplayer) && !istrue(downedplayer.isselfreviving)) {
      triggerent notify("self_revive_start");
      downedplayer val::group_set(downedplayer.laststandactionset, 1);
      downedplayer setlaststandselfreviving(1);
      triggerent thread selfrevivebuttonpresscleanup();
      downedplayer setplayerselfrevivingextrainfo(1);
      triggerent selfrevivemonitorrevivebuttonPressed();
    }

    waitframe();
  }
}

function function_ee33bc0a05a740a4() {
  if(istrue(self.var_b24e609023ce8208)) {
    thread scripts\cp\pickups::playerplaygestureweaponanim("iw8_ges_plyr_self_revive_stim_pistol", 10);
    return;
  }

  weapobj = makeweapon("iw8_ges_plyr_self_revive");
  self giveandfireoffhand(weapobj);
}

function function_da8cabbbff5c4ab2() {
  if(istrue(self.var_b24e609023ce8208)) {
    self stopgestureviewmodel("iw9_vm_ges_stimpistol_self_revive", 0.125);
  } else {
    self stopgestureviewmodel("ges_equip_stim_self_revive", 0.125);
  }

  wait 0.125;

  if(istrue(self.stimmodelattached)) {
    weapobj = makeweapon("iw8_ges_plyr_self_revive");

    if(self hasweapon(weapobj)) {
      self takeweapon(weapobj);
    }
  }
}

function selfrevivemonitorrevivebuttonPressed() {
  downedplayer = self.owner;
  triggerent = self;
  level endon("game_ended");
  downedplayer endon("death_or_disconnect");
  downedplayer endon("last_stand_finished");
  triggerent.waitingforteammaterevive = 0;

  while(scripts\cp_mp\utility\player_utility::isreallyalive(downedplayer) && selfrevivebuttonPressed(downedplayer) && triggerent.curprogress < triggerent.usetime) {
    while(!(downedplayer isonground() || downedplayer isswimming()) && selfrevivebuttonPressed(downedplayer)) {
      waitframe();
    }

    if(!selfrevivebuttonPressed(downedplayer)) {
      break;
    }

    if(downedplayer isinexecutionvictim()) {
      break;
    }

    if(!istrue(downedplayer.isselfreviving)) {
      downedplayer.isselfreviving = 1;
      downedplayer allowmovement(0);

      if(isDefined(downedplayer.var_80617a8667d0e71f)) {
        while(gettime() < downedplayer.var_80617a8667d0e71f) {
          waitframe();
        }
      }

      teststring = downedplayer val::get("gesture");
      downedplayer function_ee33bc0a05a740a4();
    }

    if(!isDefined(triggerent.userate)) {
      triggerent.userate = 0;
    }

    if(istrue(downedplayer.beingrevived)) {
      if(isDefined(triggerent.old_id)) {
        triggerent.id = triggerent.old_id;
        triggerent.old_id = undefined;
      }

      downedplayer scripts\cp\utility::function_1dbc717085326045(6);
      break;
    }

    triggerent.curprogress += level.frameduration * triggerent.userate;
    triggerent.userate = 1;

    if(triggerent.id != "self_revive") {
      triggerent.old_id = triggerent.id;
    }

    triggerent.id = "self_revive";
    downedplayer scripts\cp\utility::updateuiprogress(triggerent, 1);

    if(triggerent.curprogress >= triggerent.usetime) {
      downedplayer thread function_da8cabbbff5c4ab2();
      wait 0.125;
      downedplayer val::group_reset("laststand");
      downedplayer val::group_reset("laststand_persistent");
      downedplayer finishreviveplayer("self_revive_success", downedplayer);
      downedplayer setplayerselfrevivingextrainfo(0);

      if(istrue(downedplayer.var_b24e609023ce8208)) {
        downedplayer.var_b24e609023ce8208 = undefined;
        return;
      }

      if(isDefined(level.removeselfrevivetoken)) {
        downedplayer[[level.removeselfrevivetoken]]();
      }

      scripts\cp\globallogic::broadcast_status(downedplayer, 0);
      downedplayer scripts\cp\pickups::removeselfrevivetoken();
      downedplayer thread function_1b7ebc11cd2bc4a8();
      level.var_1143dc125c696f7a = 1;
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(downedplayer, #"bc_status_player_selfrevived");
      downedplayer notify("last_stand_self_revive");
      downedplayer notify("last_stand_finished");
      return;
    }

    waitframe();
  }

  if(!istrue(downedplayer.beingrevived)) {
    updatesquadmemberlaststandreviveprogress(downedplayer, downedplayer, triggerent.curprogress, 1);
    triggerent thread decayreviveprogress();
  }

  downedplayer notify("stopped_self_revive");
}

function updatesquadmemberlaststandreviveprogress(revivee, reviver, progress, var_979d1594b4f7f7be) {
  assert(isDefined(revivee) && isDefined(reviver));

  if(isDefined(revivee.sessionuimemberindex)) {
    if(!isDefined(level.br_squadrevivestatus)) {
      level.br_squadrevivestatus = [];
    }

    var_70401238acb839bc = get_int_or_0(level.br_squadrevivestatus[revivee.team]);

    if(!isalive(revivee)) {
      var_979d1594b4f7f7be = 1;
      progress = 0;
    }

    var_53b0b2667f5ceb2 = revivee == reviver;
    squadindex = revivee.sessionuimemberindex;
    var_98c2f6161f41a683 = int(ceil(clamp(progress, 0, 1) * 128));
    progresspayload = var_98c2f6161f41a683;

    if(istrue(var_979d1594b4f7f7be)) {
      revivee setplayerselfrevivingextrainfo(0);
    } else if(var_53b0b2667f5ceb2) {
      revivee setplayerselfrevivingextrainfo(1);
    }

    bitoffset = squadindex * 8;
    var_b27d0eff739466e0 = (progresspayload & 255) << bitoffset;
    invertedmask = ~(255 << bitoffset);
    cleanedbase = var_70401238acb839bc &invertedmask;
    statuspayload = cleanedbase + var_b27d0eff739466e0;
    level.br_squadrevivestatus[revivee.team] = statuspayload;

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && scripts\engine\utility::issharedfuncdefined("game", "getTeamData")) {
      teammates = [[scripts\engine\utility::getsharedfunc("game", "getTeamData")]](revivee.team, "players");

      if(isDefined(teammates) && teammates.size > 0) {
        foreach(teammate in teammates) {
          if(!istestclient(teammate) && isDefined(teammate getclientomnvar("ui_br_squad_revive_status"))) {
            teammate setclientomnvar("ui_br_squad_revive_status", statuspayload);
          }
        }
      }
    }
  }
}

function setplayerselfrevivingextrainfo(value) {
  if(istrue(value)) {
    self.game_extrainfo |= 8192;
    return;
  }

  self.game_extrainfo &= ~8192;
}

function selfrevivebuttonpresscleanup() {
  downedplayer = self.owner;
  triggerent = self;
  level endon("game_ended");
  downedplayer notify("self_revive_cleanup_start");
  downedplayer endon("self_revive_cleanup_start");
  downedplayer waittill_any_return_no_endon_death_3("last_stand_finished", "stopped_self_revive", "death_or_disconnect");

  if(isDefined(self.laststandactionset)) {
    downedplayer val::group_set(downedplayer.laststandactionset, 0);
  }

  if(isDefined(triggerent.old_id)) {
    triggerent.id = triggerent.old_id;
    triggerent.old_id = undefined;
  }

  if(!istrue(downedplayer.beingrevived)) {
    downedplayer scripts\cp\utility::updateuiprogress(triggerent, 0);
  }

  downedplayer allowmovement(1);
  downedplayer thread function_da8cabbbff5c4ab2();
  downedplayer setlaststandselfreviving(0);
  downedplayer.isselfreviving = 0;
  downedplayer.var_80617a8667d0e71f = gettime() + 500;
}

function onexitcommon(revived) {
  self endon("disconnect");
  level endon("game_ended");

  if(istrue(revived)) {
    scripts\cp\globallogic::broadcast_status(self, 0);
  }

  scripts\cp_mp\playerhealth::function_19b9bb9cef6a2d3();
  self setclientomnvar("ui_stop_armor_hint", 0);
  clear_last_stand_timer(self);
  self.laststandactionset = undefined;
  thread clearlaststandinvuln();
  function_711ad696f0f0a30b();
  self.fastcrouchspeedmod = 0;

  if(isDefined(level.move_speed_scale)) {
    self[[level.move_speed_scale]]();
  }

  if(scripts\cp\utility::_hasperk("specialty_block_health_regen")) {
    scripts\cp\perks::removeperk("specialty_block_health_regen");
  }

  laststandweapon = level.laststandweapon;

  if(!function_3ebb302e8386186()) {
    laststandweapon = getwatcheddvar("<dev string:x3d>");
  }

  laststandweapon = makeweapon(laststandweapon);

  if(self getcurrentprimaryweapon() != laststandweapon) {
    self notify("end_switchToFists");
    abortmonitoredweaponswitch(laststandweapon);
  } else {
    _takeweapon(laststandweapon);
  }

  self.laststandoldweapon = undefined;

  if(istrue(getbeingrevivedinternal())) {
    setbeingrevivedinternal(0);
  }

  self notify("last_stand_finished");
  scripts\cp\utility::function_1dbc717085326045(0, 0, -1);
  self hidelegsandshadow();
  self setclientomnvar("ui_is_laststand", 0);
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_securing_progress", 0);
  self setclientomnvar("ui_reviver_id", -1);
  scripts\cp\utility::disable_backpack_inventory(0);
  setlowermessageomnvar("clear_lower_msg");

  if(isDefined(level.modeonexitlaststandfunc)) {
    self[[level.modeonexitlaststandfunc]](revived);
  }

  self.inlaststand = 0;
}

function function_804b8b356fff78b2(deathdata) {
  if(isDefined(deathdata) && isDefined(deathdata.attacker) && deathdata.attacker getentitynumber() != worldentnumber()) {
    scripts\cp\damage::playerkilled_killcamsetup(deathdata);
    deathdata.laststandkill = 1;
    deathdata.dokillcam = scripts\cp\utility::function_240f7f4e57340e8f() && !(deathdata.meansofdeath == "MOD_BLEEDOUT" || hasselfrevivetoken(1));
    deathdata.attackerentnum = deathdata.attacker getentitynumber();
    time = gettime() - 10000;
    deathdata.attacker.lastspawntime = ter_op(time > deathdata.attacker.birthtime, time, deathdata.attacker.birthtime);
  } else {
    if(isDefined(deathdata)) {
      deathdata.dokillcam = 0;
    }

    self setclientomnvar("ui_killcam_killedby_id", self getentitynumber());
  }

  level.var_51c1068f1991312e = deathdata;
  return scripts\cp\killcam::function_3f8b7ecacb8eb472(deathdata);
}

function onrevive(var_4920bf02df960be9, var_d07b7dcc79b24490) {
  oldweaponobj = self.laststandoldweaponobj;
  val::set("on_revive_disables", "vehicle_use", 1);
  val::set("on_revive_disables", "crate_use", 1);
  val::set("on_revive_disables", "ascender_use", 1);

  if(isDefined(self.laststandactionset)) {
    val::group_set(self.laststandactionset, 1);
  }

  if(scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
    function_5ad98c689425d831();
  }

  onexitcommon(1);
  self laststandrevive();
  self playsoundtoteam("npc_breath_revive", self.team, self, self);
  self playlocalsound("plr_breath_revive");
  self notify("laststand_revived");

  if(isDefined(self.navmodifier)) {
    destroynavobstacle(self.navmodifier);
  }

  laststandweapon = level.laststandweapon;

  if(!function_3ebb302e8386186()) {
    laststandweapon = getwatcheddvar("<dev string:x3d>");

    if(!isDefined(laststandweapon)) {
      laststandweapon = getDvar(@ "hash_ab99ad42c8f9d6fd", "<dev string:x4d>");
    }
  }

  if(laststandweapon != "none") {
    thread domonitoredweaponswitch(oldweaponobj, 1);
  }

  if(!istrue(var_d07b7dcc79b24490)) {
    healthvalue = level.laststandrevivehealth;

    if(!function_3ebb302e8386186()) {
      healthvalue = getwatcheddvar("<dev string:x96>");

      if(!isDefined(healthvalue)) {
        healthvalue = getdvarint(@ "scr_player_laststandhealth", 100);
      }

      if(healthvalue > scripts\mp\tweakables::gettweakablevalue("<dev string:x2c>", "<dev string:x33>")) {
        healthvalue = scripts\mp\tweakables::gettweakablevalue("<dev string:x2c>", "<dev string:x33>");
      }
    }

    if(!getdvarint(@ "scr_player_laststandreviveretainhealth") || self.health < level.laststandrevivehealth) {
      self.health = level.laststandrevivehealth;
    }
  } else {
    self.health = self.maxhealth;
  }

  if(game["state"] == "postgame") {
    assert(!level.intermission);
    freezeplayerforroundend();
  }

  setbeingrevivedinternal(0);

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && !istrue(self.gulag)) {
    val::set("onRevive", "weapon_switch_clip", 1);

    foreach(teammate in level.teamdata[self.team]["alivePlayers"]) {
      if(!isDefined(teammate)) {
        continue;
      }

      if(teammate != self) {
        teammate thread scripts\cp\cp_hud_message::showsplash("br_teammate_revived", undefined, self);
      }
    }
  }

  _stopshellshock();

  if(istrue(var_4920bf02df960be9) && istrue(level.allowselfrevive)) {
    allowselfrevive(0);
  }

  self.laststandattacker = undefined;
  self.laststandmeansofdeath = undefined;
  self.laststandweaponobj = undefined;
  self.laststanddowneddata = undefined;
  self.laststandattackermodifiers = undefined;
}

function setbeingrevivedinternal(isbeingrevived) {
  self.beingrevived = isbeingrevived;
  self setbeingrevived(isbeingrevived);
}

function getbeingrevivedinternal(var_b6e6f398efe5430c) {
  return istrue(self.beingrevived) || !istrue(var_b6e6f398efe5430c) && istrue(self.isselfreviving);
}

function freezeplayerforroundend(delay) {
  self endon("disconnect");
  setlowermessageomnvar("clear_lower_msg");
  clearlowermessages();

  if(!isDefined(delay)) {
    delay = level.framedurationseconds;
  }

  wait delay;
  val::group_set("gameEndFreeze", 0);

  if(self isonground() || self isonladder()) {
    self allowmovement(0);
    return;
  }

  thread gameendfreezemovement();
}

function gameendfreezemovement() {
  timecheck = 0;

  while(timecheck < 1) {
    if(!self isonground()) {
      timecheck += level.framedurationseconds;
    } else {
      self allowmovement(0);
      break;
    }

    wait level.framedurationseconds;
  }

  self allowmovement(0);
}

function onbleedout(attacker, lifeid, smeansofdeath, damage_data) {
  if(!isDefined(self)) {
    return;
  }

  self.respawn_forcespawnorigin = self.origin;
  self.respawn_forcespawnangles = self getplayerangles(1);
  gameshouldend = function_5de995015a65e87d(self);

  if(gameshouldend && isDefined(level.endgame) && isDefined(level.end_game_string_index)) {
    player_vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(player_vehicle)) {
      seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(player_vehicle, self);
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(player_vehicle, seatid, self, undefined, 1);
    }

    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);

    if(scripts\cp\killcam::function_3f8b7ecacb8eb472(level.var_51c1068f1991312e)) {
      level waittill("player_killcam_over");
    }
  }

  if(isDefined(self.navmodifier)) {
    destroynavobstacle(self.navmodifier);
  }

  if(self isswimunderwater()) {
    self.var_d88f609db87e5503 = 1;
  }

  waitframe();
  wait_in_spectator(undefined, gameshouldend);

  if(isDefined(self.laststandattacker)) {
    self.laststandattacker thread scripts\cp\rank::scoreeventpopup(#"kill_confirmed");
  }

  if(!istrue(level.gameended)) {
    self.deathsdoorsfx = 0;
    scripts\common\damage_effects::function_a2b4e6088394bade();
    self playlocalsound("deaths_door_death");
    self enableplayerbreathsystem(1);
  }
}

function enter_spectate(downedplayer, spawnloc, reviveent) {
  downedplayer notify("enter_spectate");
  downedplayer endon("enter_spectate");
  downedplayer endon("disconnect");
  level endon("game_ended");
  level thread function_153f83a298faf9c6(downedplayer.origin);

  if(isDefined(downedplayer.carryicon)) {
    downedplayer.carryicon destroy();
  }

  downedplayer.has_building_upgrade = 0;

  if(isDefined(self.instant_revive_buffer)) {
    self.instant_revive_buffer = undefined;
  }

  var_7b56cada70b59153 = 0;

  if(getdvarint(@ "hash_c88f515e7c55af60")) {
    var_7b56cada70b59153 = 1;
  }

  if(istrue(level.enable_manual_revive) || var_7b56cada70b59153) {
    downedplayer thread manualreviveinspec();
  }

  enter_camera_zoomout(downedplayer);

  if(istrue(downedplayer.fauxdead) || istrue(downedplayer.binc130)) {
    downedplayer.fauxdead = undefined;
    downedplayer enter_bleed_out(downedplayer);
    downedplayer playslamzoomflash();
  } else {
    camera_zoomout(downedplayer, spawnloc, reviveent);
  }

  exit_camera_zoomout();
}

function manualreviveinspec() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("revive");
  self notify("manualReviveInSpec");
  self endon("manualReviveInSpec");
  var_d8e99039ab6c1f7b = 1;
  wait var_d8e99039ab6c1f7b;
  self notifyonplayercommand("manual_revive", "+usereload");
  thread scripts\cp\utility::hint_prompt("manual_revive", 1);
  self waittill("manual_revive");
  thread scripts\cp\utility::hint_prompt("manual_revive", 0);

  if(isDefined(self.dogtag)) {
    self.dogtag delete();
  }

  self.reviveent notify("revive_success");
}

function teleport_to_location() {
  level.manual_revive_location = level.vehicle_travel_array[0].origin + (0, 0, 200);

  if(!isDefined(level.manual_revive_location)) {
    return;
  }

  level endon("game_ended");
  waittill_any_timeout_1(3, "revive");
  self setOrigin(level.manual_revive_location);
}

function function_6380168026b7b3ca(player) {
  if(isDefined(player.body)) {
    player.body delete();
    player.body = undefined;
  }

  if(isPlayer(player)) {
    body = player cloneplayer(0);
    body startragdoll();
    player.body = body;
  }
}

function ondeath(deathdata) {
  if(!isDefined(self)) {
    return;
  }

  self endon("disconnect");
  onexitcommon();

  if(getdvarint(@ "hash_67a2c37b183baa49", 0) && hasselfrevivetoken()) {
    disable_self_revive();
  }

  gameshouldend = function_5de995015a65e87d(self);

  if(gameshouldend && isDefined(level.endgame) && isDefined(level.end_game_string_index)) {
    player_vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(player_vehicle)) {
      seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(player_vehicle, self);
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(player_vehicle, seatid, self, undefined, 1);
    }

    function_804b8b356fff78b2(deathdata);

    if(scripts\cp\killcam::function_3f8b7ecacb8eb472(deathdata)) {
      scripts\cp\damage::playerkilled_deathscene(level.var_51c1068f1991312e);
    }

    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);

    if(scripts\cp\killcam::function_3f8b7ecacb8eb472(deathdata)) {
      level waittill("player_killcam_over");
    }
  }

  telemetrydata = spawnStruct();
  telemetrydata.victim = self;
  telemetrydata.attacker = undefined;
  telemetrydata.meansofdeath = self.laststandmeansofdeath;
  telemetrydata.weaponfullstring = deathdata.weaponfullstring;

  if(isDefined(self.laststandattacker)) {
    telemetrydata.attacker = self.laststandattacker;
  }

  if(isDefined(self.laststandweaponobj)) {
    telemetrydata.weaponfullstring = getcompleteweaponname(self.laststandweaponobj);
  }

  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_player_death", telemetrydata);

  if(isDefined(deathdata) && isDefined(self.laststandattacker) && istrue(self.laststandattacker.inlaststand)) {
    self.laststandattacker thread onlaststandkillenemy(deathdata, self.laststandmeansofdeath, self.laststandweaponobj);
  }

  self.respawn_forcespawnorigin = self.origin;
  self.respawn_forcespawnangles = self getplayerangles(1);

  if(self isswimunderwater()) {
    self.var_d88f609db87e5503 = 1;
  }

  wait_in_spectator();

  if(istrue(self.isselfreviving)) {
    self notify("stopped_self_revive");
  }

  if(!istrue(level.gameended)) {
    self.deathsdoorsfx = 0;
    scripts\common\damage_effects::function_a2b4e6088394bade();
    self playlocalsound("deaths_door_death");
    self enableplayerbreathsystem(1);
  }
}

function onlaststandkillenemy(deathdata, laststandmeansofdeath, laststandweaponobj) {
  evictim = deathdata.victim;
  einflictor = deathdata.inflictor;
  objweapon = deathdata.objweapon;
  meansofdeath = deathdata.meansofdeath;
  weaponname = deathdata.weaponfullstring;
  attackermismatch = deathdata.attacker != self;
  bsuicide = istrue(deathdata.assistedsuicide);
  laststandweaponname = undefined;

  if(isDefined(laststandweaponobj)) {
    laststandweaponname = getcompleteweaponname(laststandweaponobj);
  }

  self notify("killed_enemy_in_last_stand", evictim, einflictor, objweapon, meansofdeath, weaponname, laststandmeansofdeath, laststandweaponname, attackermismatch, bsuicide);
}

function dropcarryobject() {
  if(isDefined(self.carryobject)) {}
}

function revivesetup(owner) {
  owner endon("death_or_disconnect");
  level endon("game_ended");

  if(istrue(level.gameended) || function_9d24182b90507aa9()) {
    return;
  }

  owner waittill("last_stand_transition_done");
  reviveent = spawn("script_model", owner.origin);
  reviveent setModel("tag_origin");
  reviveent makeusable();
  reviveent function_dfb78b3e724ad620(1);
  reviveent setHintString(&"MP/LASTSTAND_REVIVE_USE");
  reviveent setCursorHint("HINT_NOICON");
  reviveent setusehideprogressbar(1);
  reviveent setuseholdduration("duration_none");
  reviveent setusepriority(-1 - 1 - 1);
  reviveent linkTo(owner, "tag_origin", (0, 0, 6), (0, 0, 0));
  team = owner.team;
  reviveent.owner = owner;
  reviveent.inuse = 0;
  reviveent.id = "laststand_reviver";
  reviveent.trigger = spawnStruct();
  reviveent.trigger.owner = owner;
  reviveent.trigger.id = "laststand_reviver";
  reviveent.trigger.targetname = "revive_trigger";
  level.reviveent = reviveent;
  owner.reviveent = reviveent;
  reviveent thread trackteamchanges(team);
  reviveent thread revivetriggerthink(team);
  reviveent thread endreviveonownerdeathordisconnect();

  if(getdvarint(@ "hash_7a493092f8a1c04c", 0) && getdvarint(@ "hash_ddd02929770fcc8c", 0)) {
    owner thread secondwindthink();
  }

  owner.laststandreviveent = reviveent;
  level.laststandreviveents[reviveent getentitynumber()] = reviveent;
  reviveent thread removereviveentfromlevelarrayondeath();

  if(scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
    reviveent thread function_af3bd2e64377cd03();
  }

  if(owner hasselfrevivetoken()) {
    owner.laststandreviveent selfrevivethink();
  }
}

function secondwindthink() {
  downedplayer = self;
  downedplayer endon("death_or_disconnect");
  downedplayer endon("last_stand_finished");
  level endon("game_ended");
  starttimems = gettime();
  downedplayer waittill("killed_enemy_in_last_stand", evictim, einflictor, objweapon, meansofdeath, weaponname, laststandmeansofdeath, laststandweaponname, attackermismatch, bsuicide);

  while(true) {
    if(attackermismatch) {
      downedplayer waittill("killed_enemy_in_last_stand", evictim, einflictor, objweapon, meansofdeath, weaponname, laststandmeansofdeath, laststandweaponname, attackermismatch, bsuicide);
      continue;
    }

    break;
  }

  assert(istrue(downedplayer.inlaststand));
  var_36cd2fa9e32592d7 = evictim.laststandattacker;

  if(!isDefined(var_36cd2fa9e32592d7)) {
    var_36cd2fa9e32592d7 = evictim;
  }

  var_1450075a920a7dd5 = isDefined(var_36cd2fa9e32592d7) && var_36cd2fa9e32592d7 != downedplayer;
  var_c9d5089e35e3ff9e = attackermismatch;
  bbledout = bsuicide || isDefined(einflictor) && einflictor getentitynumber() == worldentnumber();
  var_5ba6882801957605 = gettime() - starttimems;
  var_6b0df23a41285117 = float(var_5ba6882801957605 / 1000);
  downedplayer finishreviveplayer("self_revive_on_kill_success", downedplayer);
  downedplayer thread scripts\cp\cp_hud_message::showsplash("br_second_wind");

  if(scripts\engine\utility::issharedfuncdefined("game", "getTeamData")) {
    playersonteam = [[scripts\engine\utility::getsharedfunc("game", "getTeamData")]](downedplayer.team, "players");

    foreach(player in playersonteam) {
      if(player != downedplayer && isalive(player)) {
        player thread scripts\cp\cp_hud_message::showsplash("br_teammate_second_wind", undefined, downedplayer);
      }
    }
  }

  downedplayer notify("last_stand_revived");
  downedplayer notify("last_stand_finished");
}

function endreviveonownerdeathordisconnect() {
  self endon("death");
  results = self.owner waittill_any_return_4("death_or_disconnect", "last_stand_finished", "last_stand_heal_active", "entered_spectate");

  if(isDefined(self.owner)) {
    entity_num = self.owner getentitynumber();
    scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "ui_dog_tags_entity_num", -1);
  }

  self delete();
}

function function_af3bd2e64377cd03() {
  level endon("game_ended");
  self.owner endon("last_stand_finished");
  self endon("death");

  while(true) {
    if(function_9d24182b90507aa9()) {
      self function_dfb78b3e724ad620(0);
      return;
    }

    wait 0.25;
  }
}

function removereviveentfromlevelarrayondeath() {
  level endon("game_ended");
  entnum = self getentitynumber();
  self waittill("death");
  level.laststandreviveents[entnum] = undefined;
}

function updateusablebyteam(team) {
  foreach(player in level.players) {
    if(team == player.team && player != self.owner && !istrue(player scripts\cp\utility::_hasperk("specialty_revive_use_weapon"))) {
      self enableplayeruse(player);
    } else {
      self disableplayeruse(player);
    }

    if(istrue(player scripts\cp\utility::_hasperk("specialty_revive_use_weapon"))) {
      player.hiddenreviveents[self getentitynumber()] = self;
    }
  }
}

function trackteamchanges(team) {
  self endon("death");
  self.owner endon("last_stand_finished");

  while(true) {
    updateusablebyteam(team);
    level waittill("joined_team");
  }
}

function revivetriggerthink(team) {
  self endon("death");
  self.owner endon("last_stand_finished");
  self.owner endon("last_stand_heal_active");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", reviver);

    if(istrue(self.owner getbeingrevivedinternal(1))) {
      continue;
    }

    if(istrue(reviver.insertingarmorplate)) {
      reviver notify("try_armor_cancel", "last_stand_reviver_start");

      while(istrue(reviver.insertingarmorplate) && reviver useButtonPressed()) {
        waitframe();
      }
    }

    if(!reviver useButtonPressed()) {
      continue;
    }

    self.owner setbeingrevivedinternal(1);
    revived = 0;
    self.owner notify("handle_revive_message");
    self function_dfb78b3e724ad620(0);
    self.owner allowmovement(0);
    reviver setlaststandreviving(1);
    reviver.revivingteammate = 1;
    thread useholdthink(reviver);
    reviver thread switchtoteammatereviveweapon(self.owner);
    var_1cc9ccea4aa0f847 = reviver getentitynumber();
    var_2155979c4665d382 = self.owner getentitynumber();
    reviver setplayerdata("cp", "EoGPlayer", var_1cc9ccea4aa0f847, "ui_revivee_entity_num", var_2155979c4665d382);
    notif = waittill_any_return_no_endon_death_3("use_hold_revive_success", "use_hold_revive_fail", "death_or_disconnect");

    if(notif == "use_hold_revive_success") {
      revived = 1;
    }

    if(isDefined(reviver)) {
      reviver setplayerdata("cp", "EoGPlayer", var_1cc9ccea4aa0f847, "ui_revivee_entity_num", -1);
      reviver notify("finish_buddy_reviving");
    }

    self.owner setbeingrevivedinternal(0);

    if(revived) {
      if(istrue(self.owner.spectating)) {
        self.owner.var_86b400f3bc4f6255 = 1;
      }

      if(function_7ba31cb6b21c346f()) {
        self.owner thread function_36edf91561322753(2);
      } else {
        thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self.owner, #"ping_social_thanks");
      }

      self.owner thread function_1b7ebc11cd2bc4a8();
      revived = self.owner finishreviveplayer(notif, reviver);
      self.owner notify("last_stand_revived");
      self.owner notify("last_stand_finished");
      return;
    }

    thread decayreviveprogress();
    self function_dfb78b3e724ad620(1);
    updateusablebyteam(team);
    revived = self.owner finishreviveplayer(notif, reviver);
  }
}

function function_7956d96af822a9a3(player) {
  level endon("game_ended");
  reviveent = player.reviveent;

  if(!isDefined(reviveent)) {
    return;
  }

  player setbeingrevivedinternal(0);

  if(istrue(player.spectating)) {
    player.var_86b400f3bc4f6255 = 1;
  }

  player thread function_1b7ebc11cd2bc4a8();
  revived = player finishreviveplayer("use_hold_revive_success", undefined);
  player notify("last_stand_revived");
  player notify("last_stand_finished");
}

function function_656840b28eb4c279(team, ignore_usebutton, var_db3f492b756b2ce7) {
  level endon("game_ended");

  if(isDefined(self.owner)) {
    var_b8b0a5e88fae74db = self.owner;
  } else {
    var_b8b0a5e88fae74db = self;
  }

  if(!isinlaststand(var_b8b0a5e88fae74db) && !istrue(var_b8b0a5e88fae74db.spectating)) {
    return;
  }

  var_b8b0a5e88fae74db endon("last_stand_finished");
  var_b8b0a5e88fae74db endon("last_stand_heal_active");
  reviver = var_db3f492b756b2ce7;
  var_b8b0a5e88fae74db setbeingrevivedinternal(1);
  revived = 1;
  var_b8b0a5e88fae74db notify("handle_revive_message");

  if(revived) {
    if(istrue(var_b8b0a5e88fae74db.spectating)) {
      var_b8b0a5e88fae74db.var_86b400f3bc4f6255 = 1;
    }

    if(function_7ba31cb6b21c346f()) {
      var_b8b0a5e88fae74db thread function_36edf91561322753(2);
    } else {
      thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_b8b0a5e88fae74db, #"ping_social_thanks");
    }

    var_b8b0a5e88fae74db thread function_1b7ebc11cd2bc4a8();
    revived = var_b8b0a5e88fae74db finishreviveplayer("use_hold_revive_success", reviver);
    var_b8b0a5e88fae74db thread scripts\cp\utility::hint_prompt("revived_by_stim_pistol", 1, 3);
    var_b8b0a5e88fae74db notify("last_stand_revived");
    var_b8b0a5e88fae74db notify("last_stand_finished");
    return;
  }
}

function switchtoteammatereviveweapon(revivee) {
  reviver = self;
  reviver endon("death_or_disconnect");
  level endon("game_ended");

  if(istrue(reviver.waitingtoplayreviveanimation)) {
    return;
  }

  weaponobj = makeweapon("teammate_revive_stim_mp");
  streakinfo = reviver scripts\cp_mp\utility\killstreak_utility::createstreakinfo("", reviver);
  streakinfo.reviveweapon = weaponobj;
  switchresult = 0;

  while(!switchresult || istrue(reviver.blockreviveanimation)) {
    switchresult = reviver scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(weaponobj, streakinfo, &teammatereviveweaponwaitputaway, undefined, &onteammatereviveweaponswitchcomplete, undefined, &onteammatereviveweapontaken, 0);
    waitframe();
    reviver.waitingtoplayreviveanimation = 1;
  }

  reviver.blockreviveanimation = 1;
  reviver.waitingtoplayreviveanimation = 0;
  reviver thread watchfordeathwhilereviving();
  reviver thread watchforteammatedeathwhilereviving(revivee);
  reviver thread watchforteammaterevivedwhilereviving(revivee);
}

function onteammatereviveweaponswitchcomplete(streakinfo, switchresult) {
  reviver = self;
  reviver disableweaponswitch();
}

function onteammatereviveweapontaken(streakinfo, switchresult) {
  reviver = self;
  reviver enableweaponswitch();
  reviver notify("revive_stim_finished");

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == "teammate_revive_stim_mp") {
    waitframe();
  }

  waitframe();
  reviver.blockreviveanimation = 0;
}

function teammatereviveweaponwaitputaway(streakinfo) {
  reviver = self;
  level endon("game_ended");

  if(!istrue(reviver.revivingteammate)) {
    return;
  }

  reviver waittill_any_return_no_endon_death_2("death_or_disconnect", "finish_buddy_reviving");
}

function watchfordeathwhilereviving() {
  reviver = self;
  reviver endon("finish_buddy_reviving");
  reviver endon("disconnect");
  level endon("game_ended");
  reviver waittill("death");
  reviver enableweaponswitch();
}

function watchforteammatedeathwhilereviving(revivee) {
  reviver = self;
  reviver endon("finish_buddy_reviving");
  reviver endon("death_or_disconnect");
  level endon("game_ended");
  revivee waittill("death_or_disconnect");
  reviver notify("finish_buddy_reviving");
}

function watchforteammaterevivedwhilereviving(revivee) {
  reviver = self;
  reviver endon("finish_buddy_reviving");
  reviver endon("death_or_disconnect");
  level endon("game_ended");
  revivee waittill("last_stand_revived");
  reviver notify("finish_buddy_reviving");
}

function finishreviveplayer(notifymsg, reviver) {
  revivee = self;
  revived = 0;

  if(!isDefined(revivee)) {
    return 0;
  }

  self.fastcrouchspeedmod = 0;

  if(isDefined(level.move_speed_scale)) {
    self[[level.move_speed_scale]]();
  }

  if(notifymsg == "use_hold_revive_success" || notifymsg == "self_revive_on_kill_success" || notifymsg == "self_revive_success") {
    revived = 1;
  }

  revivee.beingrevived = 0;
  revivee.isselfreviving = 0;

  if(notifymsg == "self_revive_success") {
    revivee selfrevivingdoneanimevent();
  }

  revivee allowmovement(1);

  if(istrue(revived) && isDefined(reviver)) {
    scripts\cp\cp_analytics::logevent_spawnviaplayer(revivee, reviver);
    revivee setlowermessageomnvar("clear_lower_msg");
    var_ccbc8f28cb6a19e7 = revivee setstance("crouch");

    if(!var_ccbc8f28cb6a19e7) {
      var_ccbc8f28cb6a19e7 = revivee setstance("prone");
    }
  }

  foreach(weapon in revivee getweaponslistprimaries()) {
    if(weapon.clipsize != 0 && !weapon.ismelee) {
      clipsize = weaponclipsize(weapon);
      currentclipammo = revivee getweaponammoclip(weapon);
      currentstock = revivee getweaponammostock(weapon);
      var_a29ff2ee96b284c1 = clipsize - currentclipammo;
      var_1949291e417ccc24 = int(clamp(var_a29ff2ee96b284c1, 0, currentstock));
      revivee setweaponammoclip(weapon, currentclipammo + var_1949291e417ccc24);
      revivee scripts\cp\pickups::function_4906c10c3ffdd4ca(weapon, currentstock - var_1949291e417ccc24, 1);
    }
  }

  revivee takelaststandtransitionweapon();
  revivee thread function_6ae06d3353229425();

  if(isDefined(reviver) && reviver != revivee) {
    thread scripts\cp_mp\talking_gun::function_bd70b31dd13292bc(reviver);
    thread scripts\cp_mp\talking_gun::function_bd70a21dd1326d59(revivee);
  }

  return revived;
}

function function_6ae06d3353229425() {
  wait 1;

  if(!isDefined(self.var_f13b2c408fe7ba46)) {
    return;
  }

  wait 1;

  if(isDefined(self.var_f13b2c408fe7ba46)) {
    slot = "health";

    if(!isDefined(self.equipment[slot]) || scripts\cp_mp\equipment::getequipmentslotammo(slot) == 0) {
      scripts\cp_mp\equipment::giveequipment("equip_armorplate", slot);
    }

    scripts\cp_mp\armor::function_9c6e9a6643b6c9a6(self.var_f13b2c408fe7ba46);
    self.var_f13b2c408fe7ba46 = undefined;
  }
}

function decayreviveprogress() {
  self.owner endon("last_stand_finished");
  self.owner endon("last_stand_heal_active");
  self endon("use_hold_revive_start");
  self endon("use_hold_interrogate_start");
  self endon("self_revive_start");
  level endon("game_ended");
  decayscale = level.laststandrevivedecayscale;

  if(!function_3ebb302e8386186()) {
    decayscale = getwatcheddvar("<dev string:xac>");

    if(!isDefined(decayscale)) {
      decayscale = getdvarfloat(@ "hash_e0f04861824e8440", 0.5);
    }
  }

  if(decayscale <= 0) {
    return;
  }

  while(true) {
    self.curprogress -= level.frameduration * decayscale;

    if(self.curprogress <= 0) {
      self.curprogress = 0;
      return;
    }

    waitframe();
  }
}

function useholdthink(reviver, usetime) {
  self.owner endon("last_stand_finished");
  reviver endon("death");
  level endon("game_ended");
  revivee = self.owner;
  var_6a1154c8bc126a40 = getdvarint(@ "hash_c959af6f995bf79a");
  revivespot = spawn("script_origin", self.origin);
  revivespot hide();

  if(!var_6a1154c8bc126a40) {
    reviver val::group_set("laststand_revive", 0);
  }

  self notify("use_hold_revive_start");
  reviver thread sfx_revive_lp();

  if(var_6a1154c8bc126a40) {
    dragallyprototype(reviver, revivee);
  }

  if(!isDefined(self.curprogress)) {
    self.curprogress = 0;
  }

  self.inuse = 1;
  self.userate = 0;
  baserevivetime = 0;

  if(isDefined(usetime)) {
    self.usetime = usetime;
  } else if(reviver scripts\cp\utility::_hasperk("specialty_quick_revive")) {
    self.usetime = getwatcheddvar("lastStandReviveTimer") * 1000 * 0.5;
  } else if(reviver scripts\cp\utility::_hasperk("specialty_medic")) {
    self.usetime = getwatcheddvar("lastStandReviveTimer") * 1000 * getdvarfloat(@ "hash_6f08a22fd52e004c");
  } else {
    self.usetime = getwatcheddvar("lastStandReviveTimer") * 1000;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && reviver scripts\cp\utility::_hasperk("specialty_br_faster_revive")) {
    self.usetime *= 0.75;
  }

  if(isDefined(level.var_9023acdd4f7e61f4)) {
    level thread[[level.var_9023acdd4f7e61f4]](reviver);
  } else {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(reviver, #"bc_status_action_reviving");
  }

  thread useholdthinkcleanup(reviver, revivespot);
  thread useholdthinkloop(reviver);
}

function dragallyprototype(reviver, revivee) {
  revivetrigger = self;
  revivee playerlinkTo(reviver);
  revivee playerlinkedoffsetenable();
  revivee allowmovement(0);
  reviver setmovespeedscale(getdvarfloat(@ "hash_ccfb1fe297ce6f9b"));
}

function cleanupdragallyprototype(reviver, revivee) {
  revivee unlink();
  revivee allowmovement(1);
  reviver setmovespeedscale(1);
}

function useholdthinkcleanup(reviver, revivespot) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_6a1154c8bc126a40 = getdvarint(@ "hash_c959af6f995bf79a");
  revivee = self.owner;
  notif = revivee waittill_any_return_no_endon_death_4("death_or_disconnect", "use_hold_think_success", "use_hold_think_fail", "last_stand_finished");
  self.inuse = 0;
  revivespot delete();
  reviver buddyrevivingdoneanimevent();
  reviver setlaststandreviving(0);
  reviver.revivingteammate = 0;

  if(isDefined(reviver)) {
    reviver scripts\cp\utility::updateuiprogress(self, 0);
  }

  if(isDefined(revivee)) {
    revivee scripts\cp\utility::updateuiprogress(self, 0);
  }

  if(scripts\cp_mp\utility\player_utility::isreallyalive(reviver)) {
    if(var_6a1154c8bc126a40) {
      cleanupdragallyprototype(reviver, revivee);
    } else {
      reviver val::group_set("laststand_revive", 1);
    }
  }

  reviver notify("sfx_revive_done");

  if(notif == "use_hold_think_success") {
    if(isPlayer(reviver)) {
      if(!istrue(reviver.can_give_revive_xp)) {
        reviver thread scripts\cp\points::doscoreevent(#"reviver", undefined, undefined, -1);
      } else {
        reviver thread scripts\cp\points::doscoreevent(#"reviver");
        reviver.can_give_revive_xp = 0;
      }
    }

    if(istrue(level.allowselfrevive)) {
      reviver allowselfrevive(1);
    }

    revivee thread scripts\cp\rank::scoreeventpopup(#"revived");
    revivee thread scripts\cp\cp_hud_message::showsplash("revived", undefined, reviver);
    revivee.inlaststand = 0;
    reviver scripts\cp\persistence::eog_player_update_stat("revives", 1);
    self notify("use_hold_revive_success");
    return;
  } else if(notif == "use_hold_think_fail") {
    revivee notify("handle_revive_message");
  }

  self notify("use_hold_revive_fail");
}

function sfx_revive_lp() {
  soundorg = spawn("script_origin", self.origin);
  soundorg linkTo(self);
  soundorg playLoopSound("br_reviver_use_lp");
  self waittill("sfx_revive_done");
  playsoundatpos(self.origin, "br_reviver_use_end");
  soundorg delete();
}

function useholdthinkloop(reviver) {
  revivee = self.owner;
  level endon("game_ended");
  revivee endon("death_or_disconnect");
  revivee endon("last_stand_finished");
  shouldstay = getdvarint(@ "hash_a23e8f787d85f762", 0);
  mintime = getdvarint(@ "hash_15e9b25b07a2bbb6", 0.5) * 1000 + gettime();

  while(scripts\cp_mp\utility\player_utility::isreallyalive(reviver) && self.curprogress < self.usetime && (!isDefined(reviver.inlaststand) || !reviver.inlaststand) && (reviver useButtonPressed() || istrue(shouldstay) || gettime() < mintime) && distancesquared(reviver.origin, self.origin) <= 65536) {
    if(istrue(reviver.tacopsmedicrole)) {
      return scripts\cp_mp\utility\player_utility::isreallyalive(reviver);
    }

    self.curprogress += level.frameduration * self.userate;
    self.userate = 1;
    reviver scripts\cp\utility::updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      revivee notify("use_hold_think_success");
      return;
    }

    waitframe();
  }

  revivee notify("use_hold_think_fail");
}

function suicidesetup() {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  level endon("game_ended");
  thread showsuicidehintstring();

  if(!isbot(self)) {
    thread suicidemonitorcrouchbuttonpress();
  }

  for(holdtime = 0; true; holdtime = 0) {
    waitframe();

    if(self stancebuttonPressed() && self isinexecutionvictim() == 0) {
      holdtime += level.framedurationseconds;

      if(holdtime >= 0.5) {
        break;
      }

      continue;
    }
  }

  suicideonend();
}

function suicidemonitorcrouchbuttonpress() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notifyonplayercommand("stance_pressed_down", "+movedown");
  self notifyonplayercommand("stance_pressed_up", "-movedown");
  self notifyonplayercommand("stance_pressed_down", "+stancedown");
  self notifyonplayercommand("stance_pressed_up", "-stancedown");
  holdtime = gettime();
  giveup = 0;
  starttimer = 0;
  var_4ce97d438a53f1d5 = 500;
  endloop = 0;

  while(!endloop && !giveup) {
    giveup = 0;

    if(!starttimer) {
      holdtime = gettime();
    }

    ret = waittill_any_timeout_5(0.5, "stance_pressed_down", "stance_pressed_up", "last_stand_finished", "last_stand_self_revive", "last_stand_bleedout");

    switch (ret) {
      case #"hash_9b3673b33c822e31":
        holdtime = gettime();
        starttimer = 1;
        break;
      case #"hash_d4dde12b38318c68":
      case #"hash_f0a7edb65e311d04":
        if(starttimer && gettime() - holdtime >= var_4ce97d438a53f1d5) {
          giveup = 1;
        }

        starttimer = 0;
        break;
      default:
        endloop = 1;
        break;
    }

    waitframe();
  }

  if(giveup) {
    suicideonend();
  }

  self notifyonplayercommandremove("stance_pressed_down", "+movedown");
  self notifyonplayercommandremove("stance_pressed_up", "-movedown");
  self notifyonplayercommandremove("stance_pressed_down", "+stancedown");
  self notifyonplayercommandremove("stance_pressed_up", "-stancedown");
}

function suicideonend() {
  if(istrue(self.allowselfrevive)) {
    self notify("last_stand_self_revive");
    return;
  }

  self notify("last_stand_bleedout");
}

function showsuicidehintstring() {
  if(istrue(self.allowselfrevive)) {
    self forceusehinton(&"MP/HEROES_RETURN");
  } else if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    thread handlerevivemessage();
  }

  waittill_any_ents(self, "death_or_disconnect", self, "last_stand_finished", level, "game_ended");

  if(!isDefined(self)) {
    return;
  }

  setlowermessageomnvar("clear_lower_msg");
  self forceusehintoff();
}

function handlerevivemessage() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("last_stand_finished");

  while(true) {
    setlowermessageomnvar("clear_lower_msg");
    var_649e600e12376e07 = 0;

    if(istrue(getbeingrevivedinternal())) {
      setlowermessageomnvar("being_revived");
    } else if(istrue(self.laststandhealisactive)) {
      setlowermessageomnvar("reviving_self");
    } else if(isDefined(self.timeuntilbleedout)) {
      if(var_649e600e12376e07) {
        setlowermessageomnvar("self_revive", int(gettime() + self.timeuntilbleedout * 1000));
      } else if(scripts\cp\utility::getgametype() != "dm") {
        setlowermessageomnvar("revive_or_respawn", int(gettime() + self.timeuntilbleedout * 1000));
      } else {
        setlowermessageomnvar("ffa_down_give_up", int(gettime() + self.timeuntilbleedout * 1000));
      }
    } else if(var_649e600e12376e07) {
      setlowermessageomnvar("self_revive");
    } else {
      setlowermessageomnvar("revive_or_respawn");
    }

    while(true) {
      notif = waittill_any_return_no_endon_death_2("super_ready", "handle_revive_message");
    }
  }
}

function bleedoutthink(damage_data) {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  self endon("last_stand_heal_active");
  level endon("game_ended");
  timeleft = self.timeuntilbleedout;
  self setclientomnvar("zm_ui_laststand_end_milliseconds", int(timeleft * 1000));
  entity_num = self getentitynumber();
  scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "laststand_time_ms", int(timeleft * 1000));

  if(timeleft != 0) {
    while(true) {
      waitframe();

      if(self isinexecutionvictim()) {
        continue;
      }

      if(!istrue(getbeingrevivedinternal())) {
        timeleft -= level.framedurationseconds;
      }

      if(timeleft <= level.framedurationseconds) {
        self notify("last_stand_bleedout");
        self.shouldskipdeathsshield = 1;
        self dodamage(self.maxhealth + self.maxarmorhealth, self.origin, undefined, undefined, "MOD_BLEEDOUT");
        break;
      }

      function_cb3d82b3072efb83(timeleft);
      self.timeuntilbleedout = timeleft;
      self setclientomnvar("zm_ui_laststand_end_milliseconds", int(timeleft * 1000));
      scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "laststand_time_ms", int(timeleft * 1000));
    }
  }
}

function function_cb3d82b3072efb83(time) {
  if(level.players.size == 1) {
    return;
  }

  if(isDefined(self.var_65e752c434236081)) {
    return;
  }

  if(level.laststandtimer > 20 && int(time) == 15) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, #"bc_status_player_last_stand");
    thread function_345dbe24850a1f6c();
    return;
  }

  if(level.laststandtimer > 15 && int(time) == 10) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, #"bc_status_player_last_stand");
    thread function_345dbe24850a1f6c();
    return;
  }

  if(level.laststandtimer > 10 && int(time) == 5) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, #"bc_status_player_last_stand");
    thread function_345dbe24850a1f6c();
    return;
  }
}

function function_345dbe24850a1f6c() {
  level endon("game_ended");
  self endon("disconnect");
  self.var_65e752c434236081 = gettime();
  wait 3;
  self.var_65e752c434236081 = undefined;
}

function addoverheadicon() {
  if(getdvarint(@ "hash_155dcc14c52dacf8", 1)) {
    return;
  }

  iconorg = self.origin;
  icon = newteamhudelem(self.team);
  icon.x = iconorg[0];
  icon.y = iconorg[1];
  icon.z = iconorg[2] + 32;
  icon.alpha = 1;
  icon.archived = 0;

  if(level.splitscreen) {
    icon setshader("hud_realism_head_revive", 10, 10);
  } else {
    icon setshader("hud_realism_head_revive", 5, 5);
  }

  icon setwaypoint(1, 1);
  icon settargetEnt(self);
  thread cleanupoverheadicon(icon);
}

function cleanupoverheadicon(icon) {
  waittill_any_3("disconnect", "last_stand_finished", "spawned");
  icon destroy();
}

function showwaverespawnmessage() {
  wavebased = getdvarint(hashcat(@ "scr_", scripts\cp\utility::getgametype(), "_waverespawndelay")) > 0;

  if(!wavebased) {
    return;
  }

  self endon("last_stand_finished");

  while(true) {
    self.respawntimerstarttime = gettime();
    wavebased = getdvarint(hashcat(@ "scr_", scripts\cp\utility::getgametype(), "_waverespawndelay")) > 0;

    if(wavebased) {}

    wait 2;
  }
}

function allowselfrevive(allow) {
  self.allowselfrevive = allow;
  self setclientomnvar("ui_self_revive", allow);
}

function laststandmonitor() {
  level endon("game_ended");

  if(istrue(level.laststandkillteamifdowndisable)) {
    return;
  }

  while(true) {
    waitframe();
    level thread laststandkillteamifdown();
  }
}

function laststandkillteamifdown() {
  foreach(entry in level.teamnamelist) {
    playersonteam = scripts\cp_mp\utility\team_utility::getfriendlyplayers(entry, 1);
    playersinlaststand = [];

    foreach(player in playersonteam) {
      if(istrue(player.inlaststand)) {
        playersinlaststand[playersinlaststand.size] = player;
      }
    }

    if(playersinlaststand.size > 0 && playersonteam.size <= playersinlaststand.size) {
      level.laststandrequiresmelee = 0;

      foreach(player in playersinlaststand) {
        if(!isDefined(player)) {
          continue;
        }

        player notify("last_stand_bleedout");
      }
    }
  }
}

function getclassiclaststandpistol() {
  weaponlist = self getweaponslistprimaries();

  foreach(weapon in weaponlist) {
    class = weaponclass(weapon);

    if(weaponclass(weapon) == "pistol") {
      return weapon;
    }
  }

  weapon = scripts\cp_mp\weapon::buildweapon(scripts\cp_mp\weapon::getweaponrootname("iw8_pi_golf21_mp"), [], "none", "none", -1);
  return weapon;
}

function makelaststandinvuln() {
  laststandinvulntimer = level.laststandinvulntime;

  if(!function_3ebb302e8386186()) {
    laststandinvulntimer = getwatcheddvar("<dev string:xc6>");

    if(!isDefined(laststandinvulntimer)) {
      dvarstring = function_3514ae5d09f47ed2("<dev string:xda>");
      laststandinvulntimer = getdvarfloat(dvarstring, 5.5);
    }
  }

  function_711ad696f0f0a30b();
  thread function_a7b189c953259ebd();
  clearlaststandinvuln();
  self endon("disconnect");
  self endon("clear_last_stand_invuln");
  scripts\cp_mp\utility\damage_utility::adddamagemodifier("last_stand_invuln", 0, 0, &laststandinvulnignorefunc);
  wait_endtime = gettime() + 1000;

  while(!self isonground() || gettime() > wait_endtime) {
    waitframe();
  }

  scripts\engine\utility::waittill_notify_or_timeout("death", laststandinvulntimer);
  thread clearlaststandinvuln();
}

function clearlaststandinvuln() {
  self notify("clear_last_stand_invuln");
  scripts\cp_mp\utility\damage_utility::removedamagemodifier("last_stand_invuln", 0);
}

function function_1b7ebc11cd2bc4a8() {
  laststandinvulnafterrevive = level.laststandinvulnafterrevive;

  if(!function_3ebb302e8386186()) {
    laststandinvulnafterrevive = getwatcheddvar("<dev string:xef>");

    if(!isDefined(laststandinvulnafterrevive)) {
      dvarstring = function_3514ae5d09f47ed2("<dev string:xef>");
      laststandinvulnafterrevive = getdvarfloat(dvarstring, 3);
    }
  }

  function_5a1b682666c7b2a5();
  self endon("disconnect");
  self endon("clear_last_stand_revived_invuln");
  scripts\cp_mp\utility\damage_utility::adddamagemodifier("last_stand_revived_invuln", 0, 0, &laststandinvulnignorefunc);
  scripts\engine\utility::waittill_notify_or_timeout("death", laststandinvulnafterrevive);
  thread function_5a1b682666c7b2a5();
}

function function_5a1b682666c7b2a5() {
  self notify("clear_last_stand_revived_invuln");
  scripts\cp_mp\utility\damage_utility::removedamagemodifier("last_stand_revived_invuln", 0);
}

function function_a7b189c953259ebd() {
  self notify("clear_last_stand_bad_trigger_invuln");
  self endon("disconnect");
  self endon("clear_last_stand_bad_trigger_invuln");
  scripts\cp_mp\utility\damage_utility::adddamagemodifier("last_stand_bad_trigger_invuln", 0, 0, &function_7dc713e8096fd946);
  scripts\cp_mp\utility\damage_utility::adddamagemodifier("last_stand_bad_trigger_reduction", 0, 0, &function_14640db51ea8d943);
  self waittill("death");
  function_711ad696f0f0a30b();
}

function function_711ad696f0f0a30b() {
  self notify("clear_last_stand_bad_trigger_invuln");
  scripts\cp_mp\utility\damage_utility::removedamagemodifier("last_stand_bad_trigger_invuln", 0);
  scripts\cp_mp\utility\damage_utility::removedamagemodifier("last_stand_bad_trigger_reduction", 0);
}

function laststandinvulnignorefunc(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  var_35eb7a9e0d4d1fab = ["MOD_DOWN", "MOD_BLEEDOUT", "MOD_TRIGGER_HURT"];

  if(isDefined(meansofdeath) && array_contains(var_35eb7a9e0d4d1fab, meansofdeath)) {
    return true;
  }

  return false;
}

function function_7dc713e8096fd946(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(scripts\cp\utility::function_b1686c9759c1048(inflictor)) {
    return !getbeingrevivedinternal(0);
  }

  return true;
}

function function_14640db51ea8d943(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(scripts\cp\utility::function_b1686c9759c1048(inflictor)) {
    victim.var_9c81a68d1a3ef708 = default_to(victim.var_9c81a68d1a3ef708, int(0));

    if(gettime() >= victim.var_9c81a68d1a3ef708) {
      victim.var_9c81a68d1a3ef708 = gettime() + getdvarint(@ "hash_7b387d839855fd02", 0);
      return true;
    } else {
      return false;
    }
  }

  return true;
}

function getdefaultlaststandtimervalue() {
  return 30;
}

function getdefaultlaststandrevivetimervalue() {
  return 1.5;
}

function getshellshockinterruptdelayms(duration) {
  return duration * 1000;
}

function player_in_laststand(player) {
  return istrue(player.inlaststand);
}

function isinlaststand(player) {
  return istrue(player.inlaststand);
}

function function_3ebb302e8386186() {
  if(getdvarint(@ "hash_820d173460041962", 1)) {
    return 0;
  }

  return isusingmatchrulesdata();
}

function function_9168ee31efcf3393() {
  level endon("<dev string:x10a>");
  setdevdvarifuninitialized(@ "hash_9564fda23c9d6dbd", 0);

  while(true) {
    autolaststand = getdvarint(@ "hash_9564fda23c9d6dbd", 0);

    if(!autolaststand || istrue(self.inlaststand)) {
      waitframe();
      continue;
    }

    foreach(player in level.players) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(istrue(player.inlaststand)) {
        continue;
      }

      if(isbot(player) || isai(player) || istestclient(player)) {
        continue;
      }

      player forcelaststand();
    }

    setDvar(@ "hash_9564fda23c9d6dbd", 0);
  }
}

function forcelaststand() {
  if(!scripts\cp\utility::_hasperk("<dev string:x115>")) {
    scripts\cp\utility::giveperk("<dev string:x115>");
  }

  self dodamage(self.maxhealth, self.origin, self, undefined, "<dev string:x12b>");
}

function function_e7884f1619dc53be() {
  level endon("<dev string:x10a>");
  setdvarifuninitialized(@ "hash_a9e6f66d5c357e7e", 0);

  while(true) {
    testval = getdvarint(@ "hash_a9e6f66d5c357e7e", 0);

    if(!testval) {
      wait 0.5;
      continue;
    }

    setDvar(@ "hash_a9e6f66d5c357e7e", 0);
    eplayer = level.players[0];
    var_4cd9f1ecf86a97bb = level.players[1];
    var_de75a3b89e8300f5 = level.players[2];
    assert(isDefined(eplayer) && isPlayer(eplayer));

    switch (testval) {
      case 1:
        if(!isDefined(var_4cd9f1ecf86a97bb)) {
          iprintlnbold("<dev string:x134>");
          break;
        }

        pistolobj = eplayer playergetlaststandpistol();

        if(!isDefined(pistolobj)) {
          iprintlnbold("<dev string:x141>");
          break;
        }

        eplayer dodamage(eplayer.health + 200, var_4cd9f1ecf86a97bb.origin, var_4cd9f1ecf86a97bb, var_4cd9f1ecf86a97bb, "<dev string:x158>", var_4cd9f1ecf86a97bb.primaryweaponobj, "<dev string:x169>");
        var_4cd9f1ecf86a97bb hudoutlineenable("<dev string:x175>");
        iprintlnbold("<dev string:x189>");
        break;
      case 2:
        if(!isDefined(var_4cd9f1ecf86a97bb) || !isDefined(var_de75a3b89e8300f5)) {
          iprintlnbold("<dev string:x193>");
          break;
        }

        pistolobj = eplayer playergetlaststandpistol();

        if(!isDefined(pistolobj)) {
          iprintlnbold("<dev string:x141>");
          break;
        }

        eplayer dodamage(eplayer.health + 200, var_4cd9f1ecf86a97bb.origin, var_4cd9f1ecf86a97bb, var_4cd9f1ecf86a97bb, "<dev string:x158>", var_4cd9f1ecf86a97bb.primaryweaponobj, "<dev string:x169>");
        wait 1;
        var_4cd9f1ecf86a97bb dodamage(var_4cd9f1ecf86a97bb.health + 200, var_de75a3b89e8300f5.origin, var_de75a3b89e8300f5, var_de75a3b89e8300f5, "<dev string:x158>", var_de75a3b89e8300f5.primaryweaponobj, "<dev string:x169>");
        var_4cd9f1ecf86a97bb hudoutlineenable("<dev string:x175>");
        iprintlnbold("<dev string:x189>");
        break;
      case 3:
        if(!isDefined(var_4cd9f1ecf86a97bb) || !isDefined(var_de75a3b89e8300f5)) {
          iprintlnbold("<dev string:x193>");
          break;
        }

        var_4cd9f1ecf86a97bb dodamage(var_4cd9f1ecf86a97bb.health + 200, eplayer.origin, eplayer, eplayer, "<dev string:x158>", eplayer.primaryweaponobj, "<dev string:x169>");
        wait 1;
        eplayer dodamage(eplayer.health + 200, var_de75a3b89e8300f5.origin, var_de75a3b89e8300f5, var_de75a3b89e8300f5, "<dev string:x158>", var_de75a3b89e8300f5.primaryweaponobj, "<dev string:x169>");
        iprintlnbold("<dev string:x1aa>");
        break;
      case 4:
        if(!isDefined(var_4cd9f1ecf86a97bb) || !isDefined(var_de75a3b89e8300f5)) {
          iprintlnbold("<dev string:x193>");
          break;
        }

        pistolobj = eplayer playergetlaststandpistol();

        if(!isDefined(pistolobj)) {
          iprintlnbold("<dev string:x141>");
          break;
        }

        eplayer dodamage(eplayer.health + 200, var_4cd9f1ecf86a97bb.origin, var_4cd9f1ecf86a97bb, var_4cd9f1ecf86a97bb, "<dev string:x158>", var_4cd9f1ecf86a97bb.primaryweaponobj, "<dev string:x169>");
        var_4cd9f1ecf86a97bb hudoutlineenable("<dev string:x175>");
        iprintlnbold("<dev string:x189>");
        var_4cd9f1ecf86a97bb waittill("<dev string:x1c7>");
        wait 1;
        var_4cd9f1ecf86a97bb dodamage(var_4cd9f1ecf86a97bb.health + 200, var_de75a3b89e8300f5.origin, var_de75a3b89e8300f5, var_de75a3b89e8300f5, "<dev string:x158>", var_de75a3b89e8300f5.primaryweaponobj, "<dev string:x169>");
        break;
      case 5:
        if(!isDefined(var_4cd9f1ecf86a97bb) || !isDefined(var_de75a3b89e8300f5)) {
          iprintlnbold("<dev string:x193>");
          break;
        }

        var_de75a3b89e8300f5 dodamage(var_de75a3b89e8300f5.health + 200, var_4cd9f1ecf86a97bb.origin, var_4cd9f1ecf86a97bb, var_4cd9f1ecf86a97bb, "<dev string:x158>", var_4cd9f1ecf86a97bb.primaryweaponobj, "<dev string:x169>");
        var_4cd9f1ecf86a97bb hudoutlineenable("<dev string:x175>");
        iprintlnbold("<dev string:x189>");
        var_4cd9f1ecf86a97bb waittill("<dev string:x1c7>");
        var_4cd9f1ecf86a97bb hudoutlinedisable();
        wait 1;
        var_de75a3b89e8300f5 notify("<dev string:x1d8>");
        break;
    }
  }
}

function playergetlaststandpistol() {
  if(isDefined(self.last_stand_pistol)) {
    return self.last_stand_pistol;
  }

  default_starting_pistol = self.default_starting_pistol;
  var_422fdc4774ca0d63 = self getweaponslistprimaries()[0];

  if(scripts\cp\utility::getbaseweaponname(default_starting_pistol) == scripts\cp\utility::getbaseweaponname(var_422fdc4774ca0d63)) {
    return var_422fdc4774ca0d63;
  }

  return default_starting_pistol;
}

function function_cb1f25df9191cd3c() {
  while(true) {
    host = undefined;

    if(getdvarint(@ "hash_d475fd19488b5a6d", 0) == 1) {
      wait 1;

      foreach(player in level.players) {
        if(player ishost()) {
          host = player;
          break;
        }
      }

      if(istrue(host.inlaststand)) {
        foreach(player in level.players) {
          if(player.team == host.team && isbot(player) && isalive(player)) {
            player setOrigin(host.origin + (0, 0, 18));
            host.reviver = player;
            wait 0.5;
            break;
          }
        }

        if(isDefined(host.reviver)) {
          presstime = level.laststandrevivetimer + 1;
          host.reviver botpressbutton("<dev string:x1ec>", presstime);
          wait presstime + 0.5;

          if(istrue(host.inlaststand)) {
            host.reviver botpressbutton("<dev string:x1ec>", presstime);
          }
        }
      } else {
        iprintlnbold("<dev string:x1f0>");
      }

      setdevdvar(@ "hash_d475fd19488b5a6d", 0);
    } else if(getdvarint(@ "hash_b5de345e9da778b5", 0) == 1) {
      wait 1;

      while(true) {
        victim = undefined;

        foreach(player in level.players) {
          if(istrue(player.inlaststand)) {
            victim = player;
            break;
          }
        }

        if(!isDefined(victim)) {
          iprintlnbold("<dev string:x25c>");
          break;
        }

        foreach(player in level.players) {
          if(isbot(player) && isalive(player) && player.team == victim.team) {
            player setOrigin(victim.origin + (0, 0, 18));
            victim.reviver = player;
            wait 0.5;
            break;
          }
        }

        if(isDefined(victim.reviver)) {
          presstime = level.laststandrevivetimer + 1;
          victim.reviver botpressbutton("<dev string:x1ec>", presstime);
          wait presstime + 0.5;

          if(istrue(victim.inlaststand)) {
            victim.reviver botpressbutton("<dev string:x1ec>", presstime);
          }

          break;
        }

        setdevdvar(@ "hash_b5de345e9da778b5", 0);
      }
    } else if(getdvarint(@ "hash_d475fd19488b5a6d", 0) == 2) {
      foreach(player in level.players) {
        if(player ishost() && istrue(player.inlaststand)) {
          player onrevive(1);
          break;
        }
      }

      setdevdvar(@ "hash_d475fd19488b5a6d", 0);
    } else if(getdvarint(@ "hash_d475fd19488b5a6d", 0) == 3) {
      wait 1;

      foreach(player in level.players) {
        if(player ishost()) {
          host = player;
          break;
        }
      }

      foreach(player in level.players) {
        if(player.team == host.team && isbot(player) && isalive(player)) {
          player setOrigin(host.origin + (0, 0, 18));
          host.reviver = player;
          wait 0.5;
          break;
        }
      }

      if(isDefined(host.reviver)) {
        host function_e4ccd01fb7ec7a6f(0);
        host stopliveragdoll();

        if(isDefined(host.var_6627db08bfd4f903)) {
          host.var_6627db08bfd4f903 setdevtext("<dev string:x28e>");
          host.var_6627db08bfd4f903.color = (1, 1, 1);
        } else {
          host iprintlnbold("<dev string:x28e>");
        }
      }

      setdevdvar(@ "hash_d475fd19488b5a6d", 0);
    }

    wait 1;
  }
}

function callback_playerlaststand(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  damage_data = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, self, idamage, objweapon, smeansofdeath, einflictor, self.origin, vdir, undefined, undefined, undefined, undefined, undefined);
  forcelaststand = isforcedlaststand(self, einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc);
  dokillcam = 0;
  self notify("stop_player_combat_state_thread");

  if(!istrue(forcelaststand)) {
    if(isDefined(level.modelaststandallowed) && !self[[level.modelaststandallowed]](einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration)) {
      return 0;
    }

    if(isDefined(level.var_7b098327e305f16d) && ![[level.var_7b098327e305f16d]](self)) {
      return 0;
    }

    if(!istrue(level.var_a42b25ffada980)) {
      return 0;
    }
  }

  if(isDefined(level.parachuteprelaststandfunc)) {
    self[[level.parachuteprelaststandfunc]]();
  }

  if(self isskydiving()) {
    self skydive_interrupt();
  }

  lifeid = self.matchdatalifeindex;

  if(!isDefined(lifeid)) {
    lifeid = level.maxlives - 1;
  }

  result = 1;

  if(isDefined(attacker)) {
    if(!isPlayer(attacker)) {
      if(isDefined(attacker.owner) && isPlayer(attacker.owner)) {
        attacker = attacker.owner;
      } else if(isDefined(einflictor) && isDefined(einflictor.owner) && isPlayer(einflictor.owner)) {
        attacker = einflictor.owner;
      }
    }

    deathdata = playerkilled_initdeathdata(einflictor, attacker, self, idamage, 0, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, 0);
    playerkilled_parameterfixup(deathdata);
    playerkilled_precalc(deathdata);
    deathdata.laststandkill = 1;
    dokillcam = function_804b8b356fff78b2(deathdata);

    if(!hasselfrevivetoken(1)) {
      result = 0;
      function_229647d24707ecea(deathdata);
      function_937633eb0e6aff1f(deathdata);
    } else if(scripts\cp\cp_outofbounds::isoob(self, 0)) {
      result = 0;
      function_229647d24707ecea(deathdata);
      function_937633eb0e6aff1f(deathdata);
    }

    if(attacker.classname != "worldspawn") {
      self.playergoingintols = 1;

      if(isPlayer(attacker) && attacker != self) {
        self.laststandattacker = attacker;
        self.laststandmeansofdeath = deathdata.meansofdeath;
        self.laststandweaponobj = objweapon;
        self.laststandattackermodifiers = attacker.modifiers;
      }
    }

    deathdata.isfriendlyfire = scripts\cp\damage::isfriendlyfire(self, attacker);

    if(getdvarint(@ "hash_98f5c716d594181b", 1)) {
      self.laststanddowneddata = deathdata;
    }

    val::set("on_revive_disables", "vehicle_use", 0);
    val::set("on_revive_disables", "crate_use", 0);
    val::set("on_revive_disables", "ascender_use", 0);

    if(isDefined(level.checkforlaststandwipe)) {
      if([[level.checkforlaststandwipe]](self)) {
        return 0;
      }
    }

    if(isDefined(self.carryobject)) {
      self notify("drop_called");
      self.carryobject thread scripts\cp\gameobjects::setdropped();
    }
  }

  if(isPlayer(self)) {
    scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "player_knocked_down");
  }

  if(isPlayer(attacker) && attacker != self) {
    scripts\cp_mp\talking_gun::function_55b08d6d71b41402(attacker, "knocked_down_enemy");
  }

  thread laststandthink(damage_data, dokillcam);
  return result;
}

function isforcedlaststand(victim, einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc) {
  forcelaststand = 0;

  var_61468d0f2f1e6cb7 = getdvarint(@ "hash_9564fda23c9d6dbd", 0);

  if(var_61468d0f2f1e6cb7) {
    return 1;
  }

  if(istrue(self.killstreaklaststand) && isDefined(level.killstreak_laststand_func)) {
    forcelaststand = 1;
  }

  return forcelaststand;
}

function playerkilled_initdeathdata(inflictor, attacker, victim, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, isfauxdeath) {
  deathdata = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, victim, damage, objweapon, meansofdeath, inflictor, undefined, direction_vec, undefined, undefined, undefined, damageflags);
  deathdata.hitloc = hitloc;
  deathdata.psoffsettime = psoffsettime;
  deathdata.deathanimduration = deathanimduration;
  deathdata.isfauxdeath = isfauxdeath;
  deathdata.victim.sessionteam = victim.sessionteam;

  if(isDefined(meansofdeath) && meansofdeath == "MOD_EXECUTION") {
    deathdata.executionref = scripts\cp_mp\execution::execution_getrefbyplayer(attacker);
  }

  deathdata.dokillcam = 0;
  deathdata.dofinalkillcam = 1;
  deathdata.killcamentity = undefined;
  deathdata.killcamentityindex = -1;
  deathdata.killcamentitystarttime = 0;
  deathdata.inflictoragentinfo = undefined;
  deathdata.killcamentstickstovictim = undefined;
  deathdata.isfriendlyfire = undefined;
  deathdata.primaryweapon = undefined;
  deathdata.lifeid = undefined;
  deathdata.attackerentnum = undefined;
  deathdata.iskillstreakweapon = undefined;
  deathdata.weaponfullstring = undefined;
  deathdata.isnukekill = 0;
  deathdata.deathscenetimesec = getdvarfloat(@ "hash_ac849f1ec300d19c", 1.75);
  deathdata.deathscenetimems = int(deathdata.deathscenetimesec * 1000);
  deathdata.deathtime = gettime();
  deathdata.brvictiminlaststand = undefined;
  return deathdata;
}

function playerkilled_parameterfixup(deathdata) {
  assert(deathdata.victim.sessionteam != "spectator");

  if(isDefined(deathdata.inflictor) && istrue(deathdata.inflictor.var_26fb072855fd4772)) {
    deathdata.meansofdeath = "MOD_CRUSH";
    deathdata.attacker = deathdata.inflictor;
    deathdata.attacker.team = scripts\cp\utility::getotherteam(deathdata.victim.team)[0];
  }

  if(deathdata.victim == deathdata.attacker && deathdata.meansofdeath == "MOD_CRUSH") {
    deathdata.meansofdeath = "MOD_SUICIDE";
  }

  if(deathdata.objweapon.basename == "none") {
    if(isDefined(deathdata.inflictor) && isDefined(deathdata.inflictor.baseweapon)) {
      deathdata.objweapon.basename = deathdata.inflictor.baseweapon;
    }
  }

  deathdata.victim playerkilled_fixupattacker(deathdata);

  if(scripts\cp\utility::isheadshot(deathdata.hitloc, deathdata.meansofdeath, deathdata.attacker)) {
    deathdata.meansofdeath = "MOD_HEAD_SHOT";
  }

  if(deathdata.isfauxdeath) {
    deathdata.dokillcam = 0;
    deathdata.deathanimduration = deathdata.victim playerforcedeathanim(deathdata.inflictor, deathdata.meansofdeath, deathdata.objweapon, deathdata.hitloc, deathdata.direction_vec);
  }

  function_af3ebb9d1ecd18e7(deathdata);
  function_18c42af5777dcd9f(deathdata);
}

function playerkilled_precalc(deathdata) {
  attacker = deathdata.attacker;
  victim = deathdata.victim;
  inflictor = deathdata.inflictor;
  objweapon = deathdata.objweapon;
  victim.perkoutlined = 0;
  victim.deathspectatepos = undefined;
  victim.deathtime = deathdata.deathtime;
  victim.attacker = attacker;
  victim.lastdeathpos = victim.origin;
  victim.lastdeathangles = victim getplayerangles();

  if(!isPlayer(inflictor) && isDefined(inflictor.primaryweapon)) {
    deathdata.primaryweapon = inflictor.primaryweapon;
  } else if(isDefined(attacker) && isPlayer(attacker) && !isnullweapon(attacker getcurrentprimaryweapon())) {
    deathdata.primaryweapon = getcompleteweaponname(attacker getcurrentprimaryweapon());
  } else if(objweapon.isalternate) {
    deathdata.primaryweapon = objweapon.basename;
  } else {
    deathdata.primaryweapon = undefined;
  }

  deathdata.lifeid = victim.matchdatalifeindex;

  if(!isDefined(deathdata.lifeid)) {
    deathdata.lifeid = level.maxlives - 1;
  }

  if(scripts\cp_mp\utility\game_utility::isgameparticipant(attacker)) {
    deathdata.attackerentnum = attacker getentitynumber();
  } else {
    deathdata.attackerentnum = -1;
  }

  deathdata.iskillstreakweapon = scripts\cp_mp\weapon::iskillstreakweapon(objweapon.basename);
  deathdata.weaponfullstring = getcompleteweaponname(objweapon);
  deathdata.isfriendlyfire = scripts\cp\damage::isfriendlyfire(victim, attacker);
  deathdata.isnukekill = objweapon.basename == "nuke_mp";

  if(isDefined(level.var_c121aa6dc74cce91)) {
    deathdata = [[level.var_c121aa6dc74cce91]](deathdata);
  }

  deathdata.brvictiminlaststand = isinlaststand(victim);

  function_f9249bb06eb48092(deathdata);

  function_af3ebb9d1ecd18e7(deathdata);
}

function function_229647d24707ecea(deathdata) {
  attacker = deathdata.attacker;
  victim = deathdata.victim;
  inflictor = deathdata.inflictor;
  objweapon = deathdata.objweapon;
  damage = deathdata.damage;
  meansofdeath = deathdata.meansofdeath;
  isfauxdeath = deathdata.isfauxdeath;
  hitloc = deathdata.hitloc;
  direction_vec = deathdata.direction_vec;
  victim notify("killed_player", attacker, meansofdeath, objweapon, inflictor);
  victim showuidamageflash();
  victim setblurforplayer(0, 0);
  scripts\cp\cp_outofbounds::clearoob(victim, 1);
  victim scripts\cp\powers\coop_molotov::molotov_clear_fx();
  printgameaction("death", victim);
  victim launchshield(damage, meansofdeath);

  if(isDefined(attacker.petwatch) && attacker != victim) {
    attacker scripts\cp_mp\pet_watch::addkillcharge();

    if(meansofdeath == "MOD_EXECUTION") {
      attacker scripts\cp_mp\pet_watch::addexecutioncharge();
    } else if(victim playerkilled_washitbyvehicle(meansofdeath, inflictor)) {
      attacker scripts\cp_mp\pet_watch::addvehicularmanslaughtercharge();
    }
  }

  if(meansofdeath == "MOD_EXECUTION") {
    attacker scripts\cp\events::incpersstat("executionKills", 1);
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(attacker, "flavor_execution", undefined, 1);
  }

  if(istrue(level.var_2dce4d6dcb6c3fb9)) {
    victim scripts\cp\utility::store_weapons_status(level.var_d5ab05b7947de15a, 1);
    victim scripts\cp\equipment::store_equipment();
  }

  victim scripts\cp\equipment\nvg::savenvgstate();

  if(!isfauxdeath) {
    if(isDefined(victim.endgame)) {
      victim scripts\cp\utility\player::restorebasevisionset(2);
    } else {
      victim scripts\cp\utility\player::restorebasevisionset(0);
      victim thermalvisionoff();
    }
  } else {
    victim.fauxdead = 1;
    victim sethidenameplate(1);
    victim notify("death");
    victim notify("death_or_disconnect");
  }

  if(meansofdeath != "MOD_HEAD_SHOT" && !deathdata.isnukekill) {
    if(isDefined(level.custom_death_sound)) {
      [[level.custom_death_sound]](victim, meansofdeath, inflictor);
    } else if(meansofdeath != "MOD_MELEE") {
      victim scripts\cp\utility::playdeathsound();
    }
  }

  if(isDefined(level.custom_death_effect)) {
    [[level.custom_death_effect]](victim, meansofdeath, inflictor);
  }

  if(scripts\cp\utility::gameflag("prematch_done") && !istrue(victim.hvtnorevive) && istrue(victim.inlaststand)) {
    thread scripts\cp\laststand::ondeath(deathdata);
  }

  if(scripts\cp\utility::gameflag("prematch_done")) {
    var_85a40249b07be68e = istrue(self.isjuggernaut) && isDefined(self.juggcontext);

    if(var_85a40249b07be68e) {
      respawnitems = self.juggcontext;
    }
  }

  if(!isfauxdeath && !function_240f7f4e57340e8f()) {
    victim updatesessionstate("dead");
  }

  obitmeansofdeath = meansofdeath;

  if(isDefined(deathdata.idflags) && deathdata.idflags & 8 && !(deathdata.idflags & 16384)) {
    if(isDefined(attacker.bulletkillsinaframecount) && attacker.bulletkillsinaframecount == 0) {
      obitmeansofdeath = "MOD_PENETRATION";
    }
  } else if(objweapon.basename == "semtex_xmike109_mp" && deathdata.hitloc == "head" || deathdata.hitloc == "helmet") {
    obitmeansofdeath = "MOD_HEAD_SHOT";
  }

  if(isDefined(deathdata.inflictor) && istrue(deathdata.inflictor.iswztrain)) {
    obitmeansofdeath = "MOD_CRUSH";
  }

  victim scripts\cp\cp_player_battlechatter::onplayerkilled(inflictor, attacker, damage, meansofdeath, objweapon, deathdata.direction_vec, deathdata.hitloc, deathdata.psoffsettime, deathdata.deathanimduration, deathdata.lifeid);
}

function function_937633eb0e6aff1f(deathdata) {
  playerkilled_handlecorpse(deathdata);
  setdeathtimerlength(deathdata);
  attacker = deathdata.attacker;

  if(isDefined(attacker.owner)) {
    attacker = attacker.owner;
  }

  thread scripts\cp_mp\challenges::ondeath(deathdata.inflictor, deathdata.attacker, deathdata.damage, deathdata.damageflags, deathdata.meansofdeath, deathdata.objweapon, deathdata.hitloc, deathdata.attacker.modifiers);

  scripts\cp\laststand::function_f9249bb06eb48092(deathdata);

  scripts\cp\laststand::function_af3ebb9d1ecd18e7(deathdata);
}

function playerkilled_fixupattacker(deathdata) {
  deathdata.attacker = _validateattacker(deathdata.attacker);

  if(isDefined(deathdata.inflictor) && istrue(deathdata.inflictor.var_26fb072855fd4772)) {
    if(isDefined(level.var_b6e3760a75368efc)) {
      deathdata.attacker = [[level.var_b6e3760a75368efc]](deathdata.inflictor, deathdata.victim);
    }
  }

  assistedsuicide = 0;

  if(!isDefined(deathdata.attacker)) {
    assistedsuicide = 1;
  } else if(isDefined(deathdata.attacker.classname) && (deathdata.attacker.classname == "trigger_hurt" || deathdata.attacker.classname == "worldspawn")) {
    assistedsuicide = 1;
  } else if(deathdata.attacker == deathdata.victim) {
    assistedsuicide = 1;
  }

  if(assistedsuicide) {
    bestplayer = undefined;

    if(isDefined(bestplayer)) {
      deathdata.attacker = bestplayer;
      deathdata.attacker.assistedsuicide = 1;
      deathdata.objweapon = deathdata.victim.attackerdata[bestplayer.guid].objweapon;
      deathdata.direction_vec = deathdata.victim.attackerdata[bestplayer.guid].vdir;
      deathdata.hitloc = deathdata.victim.attackerdata[bestplayer.guid].shitloc;
      deathdata.psoffsettime = deathdata.victim.attackerdata[bestplayer.guid].psoffsettime;
      deathdata.meansofdeath = deathdata.victim.attackerdata[bestplayer.guid].smeansofdeath;
      deathdata.damage = deathdata.victim.attackerdata[bestplayer.guid].damage;
      deathdata.primaryweapon = deathdata.victim.attackerdata[bestplayer.guid].sprimaryweapon;

      if(istrue(deathdata.victim.squadwiped) && isDefined(deathdata.victim.attackerdata[bestplayer.guid].inflictor)) {
        deathdata.inflictor = deathdata.victim.attackerdata[bestplayer.guid].inflictor;
      }

      deathdata.assistedsuicide = 1;
    }
  }

  if(isDefined(deathdata.attacker)) {
    if(deathdata.attacker.code_classname == "script_vehicle" && isDefined(deathdata.attacker.owner)) {
      deathdata.attacker = deathdata.attacker.owner;
    }

    if(deathdata.attacker.code_classname == "misc_turret" && isDefined(deathdata.attacker.owner)) {
      if(isDefined(deathdata.attacker.vehicle)) {
        deathdata.attacker.vehicle notify("killedPlayer", deathdata.victim);
      }

      deathdata.attacker = deathdata.attacker.owner;
    }

    if(isagent(deathdata.attacker)) {
      if(isDefined(deathdata.attacker.owner)) {
        deathdata.attacker = deathdata.attacker.owner;
      }
    }

    if(deathdata.attacker.code_classname == "script_model" && isDefined(deathdata.attacker.owner)) {
      deathdata.attacker = deathdata.attacker.owner;

      if(!scripts\cp\damage::isfriendlyfire(deathdata.victim, deathdata.attacker) && deathdata.attacker != deathdata.victim) {
        deathdata.attacker notify("crushed_enemy");
      }
    }
  }

  if(isDefined(deathdata.inflictor) && !isPlayer(deathdata.inflictor)) {
    if(!isDefined(deathdata.attacker)) {
      if(isDefined(deathdata.inflictor.owner)) {
        deathdata.attacker = deathdata.inflictor.owner;
      }
    } else if(!isPlayer(deathdata.attacker)) {
      if(isDefined(deathdata.inflictor.owner) && (!isDefined(deathdata.inflictor.equipmentref) || deathdata.inflictor.equipmentref != "equip_claymore")) {
        deathdata.attacker = deathdata.inflictor.owner;
      }
    }
  }

  if(isDefined(deathdata.attacker) && deathdata.attacker != deathdata.victim) {
    if(isDefined(deathdata.inflictor) && deathdata.inflictor == deathdata.victim) {
      deathdata.inflictor = deathdata.attacker;
    }
  }

  deathdata.attacker.assistedsuicide = 0;
}

function _validateattacker(eattacker) {
  if(isagent(eattacker) && (!isDefined(eattacker.isactive) || !eattacker.isactive)) {
    return undefined;
  }

  if(isagent(eattacker) && !isDefined(eattacker.classname)) {
    return undefined;
  }

  return eattacker;
}

function function_18c42af5777dcd9f(deathdata) {
  deathdata.var_28cd1e201ecd8281 = [];
  deathdata.var_28cd1e201ecd8281["attacker"] = deathdata.attacker;
  deathdata.var_28cd1e201ecd8281["victim"] = deathdata.victim;
  deathdata.var_28cd1e201ecd8281["damage"] = deathdata.damage;
  deathdata.var_28cd1e201ecd8281["objWeapon"] = deathdata.objweapon;
  deathdata.var_28cd1e201ecd8281["meansOfDeath"] = deathdata.meansofdeath;
  deathdata.var_28cd1e201ecd8281["inflictor"] = deathdata.inflictor;
  deathdata.var_28cd1e201ecd8281["direction_vec"] = deathdata.direction_vec;
  deathdata.var_28cd1e201ecd8281["damageFlags"] = deathdata.damageflags;
  deathdata.var_28cd1e201ecd8281["hitLoc"] = deathdata.hitloc;
  deathdata.var_28cd1e201ecd8281["psOffsetTime"] = deathdata.psoffsettime;
  deathdata.var_28cd1e201ecd8281["deathAnimDuration"] = deathdata.deathanimduration;
  deathdata.var_28cd1e201ecd8281["isFauxDeath"] = deathdata.isfauxdeath;
}

function function_f9249bb06eb48092(deathdata) {
  assertex(deathdata.var_28cd1e201ecd8281["attacker"] == deathdata.attacker, "\"attacker\" death param changed after the Modify Params step. Alert a scripter.");
  assertex(deathdata.var_28cd1e201ecd8281["victim"] == deathdata.victim, "\"victim\" death param changed after the Modify Params step. Alert a scripter.");
  assertex(deathdata.var_28cd1e201ecd8281["damage"] == deathdata.damage, "\"damage\" death param changed after the Modify Params step. Alert a scripter.");
  assertex(deathdata.var_28cd1e201ecd8281["objWeapon"] == deathdata.objweapon, "\"objWeapon\" death param changed after the Modify Params step. Alert a scripter.");
  assertex(deathdata.var_28cd1e201ecd8281["meansOfDeath"] == deathdata.meansofdeath, "\"meansOfDeath\" death param changed after the Modify Params step. Alert a scripter.");
  assertex(deathdata.var_28cd1e201ecd8281["inflictor"] == deathdata.inflictor, "\"inflictor\" death param changed after the Modify Params step. Alert a scripter.");
  assertex(deathdata.var_28cd1e201ecd8281["direction_vec"] == deathdata.direction_vec, "\"direction_vec\" death param changed after the Modify Params step. Alert a scripter.");
  assertex(deathdata.var_28cd1e201ecd8281["damageFlags"] == deathdata.damageflags, "\"damageFlags\" death param changed after the Modify Params step. Alert a scripter.");
  assertex(deathdata.var_28cd1e201ecd8281["hitLoc"] == deathdata.hitloc, "\"hitLoc\" death param changed after the Modify Params step. Alert a scripter.");
  assertex(deathdata.var_28cd1e201ecd8281["psOffsetTime"] == deathdata.psoffsettime, "\"psOffsetTime\" death param changed after the Modify Params step. Alert a scripter.");
  assertex(deathdata.var_28cd1e201ecd8281["deathAnimDuration"] == deathdata.deathanimduration, "\"deathAnimDuration\" death param changed after the Modify Params step. Alert a scripter.");
  assertex(deathdata.var_28cd1e201ecd8281["isFauxDeath"] == deathdata.isfauxdeath, "\"isFauxDeath\" death param changed after the Modify Params step. Alert a scripter.");
}

function function_af3ebb9d1ecd18e7(deathdata) {
  assertex(deathdata.deathtime == gettime(), "Illegal 'wait' command in somewhere in PlayerKilled logic!");
}

function function_c11e262e2e29094f(bool) {
  if(!isDefined(bool)) {
    bool = 1;
  }

  level.var_a42b25ffada980 = bool;
}

function function_37db281eb241645d(bool) {
  level.var_2dce4d6dcb6c3fb9 = bool;
}

function function_2f75743c7fe59cfc(deathdata) {
  player = deathdata.victim;
  spawn_loc = level.player_respawn[player.respawn_index];
  player.forcespawnorigin = drop_to_ground(spawn_loc.origin, 32, -100);
  player.forcespawnangles = (0, spawn_loc.angles[1], 0);
  return deathdata;
}

function hide_all_revive_icons(player) {
  foreach(revive_icon in player.revive_icons) {
    revive_icon.alpha = 0;
  }
}

function instant_revive(player) {
  if(true) {
    return;
  }
}

function gethealthcap() {
  if(isDefined(level.get_player_health_after_revived_func)) {
    return [[level.get_player_health_after_revived_func]](self);
  }

  return int(self.maxhealth);
}

function clear_last_stand_timer(player) {
  if(isDefined(player)) {
    entity_num = player getentitynumber();
    player setclientomnvar("zm_ui_laststand_end_milliseconds", 0);
    player setclientomnvar("zm_hint_index", 0);
    player setclientomnvar("zm_hint_progress", 0);
    scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "laststand_time_ms", 0);
  }
}

function get_normal_revive_time() {
  if(isDefined(level.normal_revive_time)) {
    return level.normal_revive_time;
  }

  return 5000;
}

function give_fists_if_no_real_weapon(player) {
  if(has_no_real_weapon(player)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon("iw9_me_fists_mp");
    self switchtoweaponimmediate("iw9_me_fists_mp");
    self setspawnweapon("iw9_me_fists_mp", 1);
  }
}

function has_no_real_weapon(player) {
  all_weapons = player getweaponslistall();

  foreach(weapon in all_weapons) {
    baseweaponname = weapon.basename;

    if(baseweaponname == "none") {
      continue;
    }

    if(baseweaponname == "iw9_ziptie_mp") {
      continue;
    }

    if(baseweaponname == "iw9_me_climbfists_mp") {
      continue;
    }

    if(baseweaponname == "super_default_zm") {
      continue;
    }

    if(issubstr(baseweaponname, "knife")) {
      continue;
    }

    if(baseweaponname == "iw9_me_fists_mp") {
      continue;
    }

    return false;
  }

  return true;
}

function default_player_init_laststand() {
  init_revive_icon_list();
}

function init_revive_icon_list() {
  self.revive_icons = [];
}

function function_abb98974074387b1(player) {
  gameshouldend = function_5de995015a65e87d();

  if(gameshouldend && isDefined(level.endgame) && isDefined(level.end_game_string_index)) {
    player_vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(player_vehicle)) {
      seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(player_vehicle, self);
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(player_vehicle, seatid, self, undefined, 1);
    }

    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
  }
}

function function_5de995015a65e87d(var_47e569777f8bb300, var_dc713579246e29d6) {
  if(scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
    if(function_10a17aa507f07bd8()) {
      if(function_9d24182b90507aa9()) {
        if(everyone_else_all_in_laststand(var_47e569777f8bb300)) {
          return 1;
        }
      }
    }
  }

  if(istrue(level.enable_manual_revive) || getdvarint(@ "hash_c88f515e7c55af60")) {
    return 0;
  }

  if(isDefined(var_47e569777f8bb300) && var_47e569777f8bb300 hasselfrevivetoken(var_dc713579246e29d6)) {
    return 0;
  }

  if(function_3a7452328b016d0c() && isDefined(var_47e569777f8bb300) && var_47e569777f8bb300 scripts\cp\utility::has_auto_revive()) {
    return 0;
  }

  if(function_3a7452328b016d0c()) {
    if(isDefined(var_47e569777f8bb300)) {
      return function_cfb83a27a2b50413(var_47e569777f8bb300);
    } else {
      return 1;
    }

    return;
  }

  return function_22ef061075ea04d(var_47e569777f8bb300);
}

function function_3a7452328b016d0c() {
  if(getdvarint(@ "hash_a315dde34dfae829", 0) > 0) {
    return false;
  }

  return istrue(scripts\cp\utility::isplayingsolo()) || istrue(level.only_one_player);
}

function function_cfb83a27a2b50413(var_47e569777f8bb300) {
  if(istrue(var_47e569777f8bb300.var_4b75c525af796f66)) {
    return 0;
  }

  if(isDefined(level.var_313f285051fa8329)) {
    return [[level.var_313f285051fa8329]](var_47e569777f8bb300);
  }

  if(player_in_laststand(var_47e569777f8bb300)) {
    return 0;
  }

  return var_47e569777f8bb300 get_last_stand_count() == 0;
}

function get_last_stand_count() {
  return self getplayerdata("cp", "alienSession", "last_stand_count");
}

function function_22ef061075ea04d(var_47e569777f8bb300) {
  if(isDefined(level.coop_gameshouldendfunc)) {
    return [[level.coop_gameshouldendfunc]](var_47e569777f8bb300);
  }

  return everyone_else_all_in_laststand(var_47e569777f8bb300);
}

function function_5eccc8d9829e62a(var_47e569777f8bb300) {
  valid_players = 0;
  var_a2ee5e571404bb61 = 0;

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(istrue(player.var_6f037e24e1d55a69)) {
      continue;
    }

    valid_players++;

    if(function_aece408c4e393b72(player)) {
      var_a2ee5e571404bb61++;
    }
  }

  return var_a2ee5e571404bb61 >= valid_players;
}

function function_aece408c4e393b72(player) {
  if(player isspectatingplayer()) {
    return true;
  }

  if(!isalive(player)) {
    return true;
  }

  if(isinlaststand(player) && !player hasselfrevivetoken()) {
    return true;
  }

  return false;
}

function function_ef09962096aa8771() {
  self.var_6f037e24e1d55a69 = 1;
}

function everyone_else_all_in_laststand(var_47e569777f8bb300) {
  foreach(player in level.players) {
    if(isDefined(var_47e569777f8bb300) && player == var_47e569777f8bb300) {
      continue;
    }

    if(player isspectatingplayer()) {
      continue;
    }

    if(istrue(player.var_6f037e24e1d55a69)) {
      continue;
    }

    if(istrue(player.isselfreviving)) {
      return false;
    }

    if(player hasselfrevivetoken()) {
      return false;
    }

    if(isalive(player) && !player_in_laststand(player)) {
      return false;
    }

    if(istrue(player.gettingupfromlaststand)) {
      return false;
    }
  }

  return true;
}

function function_6d977e4da51c55f3(waittime) {
  if(isDefined(waittime)) {
    wait waittime;
  }

  if(isDefined(level.var_e4a74151cfc1435b)) {
    objindex = scripts\cp\cp_objectives::requestworldid("respawn_buy_loc");
    objective_state(objindex, "current");
    objective_setshowoncompass(objindex, 1);
    objective_setlabel(objindex, "");
    objective_position(objindex, level.var_e4a74151cfc1435b);
    objective_setshowdistance(objindex, 1);
    objective_setshowprogress(objindex, 0);
    objective_setbackground(objindex, 1);
    objective_setplayintro(objindex, 0);
    level.var_50ac7f8d5b660a9c = objindex;
    level.var_b51adb1c7ab7788c = 1;
  }
}

function function_d6ebed99dc9008c2() {
  if(isDefined(level.var_50ac7f8d5b660a9c)) {
    objective_state(level.var_50ac7f8d5b660a9c, "done");
    objective_delete(level.var_50ac7f8d5b660a9c);
    level.var_50ac7f8d5b660a9c = undefined;
    level.var_b51adb1c7ab7788c = undefined;
    scripts\cp\cp_objectives::freeworldid("respawn_buy_loc");
  }
}

function record_revive_success(reviver, downedplayer) {
  if(isPlayer(reviver)) {
    reviver scripts\cp\cp_merits::processmerit("mt_reviver");
    reviver scripts\cp\persistence::increment_player_career_revives(reviver);
    reviver scripts\cp\cp_merits::processmerit("mt_revives");
    reviver scripts\cp\persistence::eog_player_update_stat("revives", 1);
    downedplayer thread scripts\cp\cp_hud_message::showsplash("cp_revived", undefined, reviver);

    if(isDefined(level.revive_success_analytics_func)) {
      [[level.revive_success_analytics_func]](reviver);
    }
  }
}

function set_revive_icon_color(revive_icon_ent, color, var_56f0b746f85293f) {
  if(istrue(revive_icon_ent.owner.gettingupfromlaststand)) {
    return;
  }

  revive_icon_ent.current_revive_icon_color = color;

  if(isDefined(revive_icon_ent.revive_icons)) {
    revive_icon_ent.revive_icons = array_removeundefined(revive_icon_ent.revive_icons);
  }

  if(istrue(var_56f0b746f85293f) || isDefined(revive_icon_ent.owner.reviver) && !istrue(revive_icon_ent.owner.reviver.isreviving) || !isDefined(revive_icon_ent.owner.reviver)) {
    if(isDefined(revive_icon_ent.revive_icons)) {
      foreach(revive_icon in revive_icon_ent.revive_icons) {
        revive_icon.color = color;
      }
    }
  }
}

function enter_camera_zoomout(downedplayer) {
  downedplayer function_a593971d75d82113();
  downedplayer freezecontrols(1);
}

function exit_camera_zoomout() {
  self cameraunlink();
  self freezecontrols(0);
}

function playslamzoomflash() {
  overlay = newclienthudelem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = 0;
  overlay.foreground = 1;
  overlay setshader("white", 640, 480);
  overlay fadeovertime(0.05);
  overlay.alpha = 1;
  wait 0.05;
  overlay destroy();
}

function enter_bleed_out(downedplayer) {
  if(isDefined(level.player_bleed_out_func)) {
    downedplayer[[level.player_bleed_out_func]](downedplayer);
    return;
  }

  if(isDefined(level.enterspectatorfunc)) {
    downedplayer[[level.enterspectatorfunc]]();
  }
}

function camera_zoomout(downedplayer, spawnloc, reviveent) {
  if(isDefined(reviveent)) {
    reviveent endon("revive_success");
  }

  if(isDefined(level.var_95b8b02e43bca8db)) {
    [[level.var_95b8b02e43bca8db]](downedplayer, spawnloc, reviveent);
    downedplayer enter_bleed_out(downedplayer);
    return;
  }

  var_1f2faf8b25e8824d = (0, 0, 30);
  var_f6b7b6d8aa0fe05a = (0, 0, -30);
  var_db34fc022fa1ef30 = (0, 0, 100);
  var_cb3021ef49388df9 = (0, 0, 400);
  var_f40e87a5da630c21 = 2;
  var_4e35da98ccb4be51 = 0.6;
  var_90421be5304f4c34 = 0.6;
  startpos = spawnloc + var_1f2faf8b25e8824d;
  trace = scripts\engine\trace::_bullet_trace(startpos, startpos + var_db34fc022fa1ef30, 0, downedplayer);
  var_349336c6178cebee = trace["position"];
  trace = scripts\engine\trace::_bullet_trace(var_349336c6178cebee, var_349336c6178cebee + var_cb3021ef49388df9, 0, downedplayer);
  var_e2ee67418550390b = trace["position"] + var_f6b7b6d8aa0fe05a;
  mover = spawn("script_model", var_349336c6178cebee);
  mover setModel("tag_origin");
  mover.angles = vectortoangles((0, 0, -1));
  mover thread cleanuplaststandent(downedplayer);
  downedplayer cameralinkTo(mover, "tag_origin");

  if(!istrue(level.var_cf829458f676a8ef)) {
    mover moveTo(var_e2ee67418550390b, var_f40e87a5da630c21, var_4e35da98ccb4be51, var_90421be5304f4c34);
    mover waittill("movedone");
    mover delete();
  } else {
    wait var_f40e87a5da630c21;
    mover delete();
  }

  downedplayer enter_bleed_out(downedplayer);
}

function cleanuplaststandent(owner, var_a000db758ec878af) {
  self endon("death");

  if(istrue(var_a000db758ec878af)) {
    owner waittill_any_3("disconnect", "last_stand_revived", "spawned");
  } else {
    owner waittill_any_3("death_or_disconnect", "last_stand_revived", "spawned");
  }

  self delete();
}

function function_73707f2512aa6814() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self.var_80f9d0aeaa47cc0c = spawnStruct();
  self.var_80f9d0aeaa47cc0c.origin = self.origin;
  self.var_80f9d0aeaa47cc0c.angles = self.angles;

  while(true) {
    wait 1;

    if(scripts\cp\cp_outofbounds::isoob(self, 0) || istrue(self isjumping()) || !istrue(self isonground())) {
      continue;
    }

    self.var_80f9d0aeaa47cc0c.origin = self.origin;
    self.var_80f9d0aeaa47cc0c.angles = self.angles;
  }
}

function enable_self_revive() {
  player = self;
  player setclientomnvar("ui_self_revive", 1);

  if(!isDefined(player.self_revive)) {
    player.self_revive = 0;
  }

  player.hasselfrevivetoken = 1;
  player.self_revive++;
}

function disable_self_revive() {
  player = self;
  assertex(isDefined(player.self_revive), "<dev string:x2b2>");
  assertex(player.self_revive > 0, "<dev string:x2d3>");

  if(isDefined(player.var_9f4e140e6dcbc55d)) {
    for(i = 0; i < player.var_9f4e140e6dcbc55d.size; i++) {
      slot = player.var_9f4e140e6dcbc55d[i].slot;
      scripts\cp\utility::remove_carry_item(player, slot);
    }
  }

  player.self_revive--;

  if(player.self_revive <= 0) {
    player.has_auto_revive = undefined;
    player.hasselfrevivetoken = 0;
    player setclientomnvar("ui_self_revive", 0);
  }
}

function hasselfrevivetoken(var_fa774e92ec600c15) {
  if(istrue(var_fa774e92ec600c15)) {
    return istrue(self.hasselfrevivetoken);
  }

  return isalive(self) && istrue(self.hasselfrevivetoken);
}

#using_animtree("script_model");

function init_laststand_anims() {
  if(istrue(level.ls_anims_init)) {
    return;
  }

  level.ls_anims_init = 1;
  level.scr_animtree["ls_revive_helper"] = #animtree;
  level.scr_animtree["ls_revive_wounded"] = #animtree;
  level.scr_anim["ls_revive_helper"]["in_stand_1"] = % sdr_mp_laststand_stand_revive_in_helper_1;
  level.scr_eventanim["ls_revive_helper"]["in_stand_1"] = % "hash_26acf920b422f61f";
  level.scr_anim["ls_revive_helper"]["in_stand_2"] = % sdr_mp_laststand_stand_revive_in_helper_2;
  level.scr_eventanim["ls_revive_helper"]["in_stand_2"] = % "hash_26acfa20b422f7d2";
  level.scr_anim["ls_revive_helper"]["in_stand_3"] = % sdr_mp_laststand_stand_revive_in_helper_3;
  level.scr_eventanim["ls_revive_helper"]["in_stand_3"] = % "hash_26acfb20b422f985";
  level.scr_anim["ls_revive_helper"]["in_stand_4"] = % sdr_mp_laststand_stand_revive_in_helper_4;
  level.scr_eventanim["ls_revive_helper"]["in_stand_4"] = % "hash_26acf420b422eda0";
  level.scr_anim["ls_revive_helper"]["in_stand_6"] = % sdr_mp_laststand_stand_revive_in_helper_6;
  level.scr_eventanim["ls_revive_helper"]["in_stand_6"] = % "hash_26acf620b422f106";
  level.scr_anim["ls_revive_helper"]["in_stand_7"] = % sdr_mp_laststand_stand_revive_in_helper_7;
  level.scr_eventanim["ls_revive_helper"]["in_stand_7"] = % "hash_26acf720b422f2b9";
  level.scr_anim["ls_revive_helper"]["in_stand_8"] = % sdr_mp_laststand_stand_revive_in_helper_8;
  level.scr_eventanim["ls_revive_helper"]["in_stand_8"] = % "hash_26ad0020b4230204";
  level.scr_anim["ls_revive_helper"]["in_stand_9"] = % sdr_mp_laststand_stand_revive_in_helper_9;
  level.scr_eventanim["ls_revive_helper"]["in_stand_9"] = % "hash_26ad0120b42303b7";
  level.scr_anim["ls_revive_helper"]["idle_stand_1"] = % sdr_mp_laststand_stand_revive_loop_helper_1;
  level.scr_eventanim["ls_revive_helper"]["idle_stand_1"] = % "hash_5e39e8f65c89ca84";
  level.scr_anim["ls_revive_helper"]["idle_stand_2"] = % sdr_mp_laststand_stand_revive_loop_helper_2;
  level.scr_eventanim["ls_revive_helper"]["idle_stand_2"] = % "hash_5e39ebf65c89cf9d";
  level.scr_anim["ls_revive_helper"]["idle_stand_3"] = % sdr_mp_laststand_stand_revive_loop_helper_3;
  level.scr_eventanim["ls_revive_helper"]["idle_stand_3"] = % "hash_5e39eaf65c89cdea";
  level.scr_anim["ls_revive_helper"]["idle_stand_4"] = % sdr_mp_laststand_stand_revive_loop_helper_4;
  level.scr_eventanim["ls_revive_helper"]["idle_stand_4"] = % "hash_5e39e5f65c89c56b";
  level.scr_anim["ls_revive_helper"]["idle_stand_6"] = % sdr_mp_laststand_stand_revive_loop_helper_6;
  level.scr_eventanim["ls_revive_helper"]["idle_stand_6"] = % "hash_5e39e7f65c89c8d1";
  level.scr_anim["ls_revive_helper"]["idle_stand_7"] = % sdr_mp_laststand_stand_revive_loop_helper_7;
  level.scr_eventanim["ls_revive_helper"]["idle_stand_7"] = % "hash_5e39e6f65c89c71e";
  level.scr_anim["ls_revive_helper"]["idle_stand_8"] = % sdr_mp_laststand_stand_revive_loop_helper_8;
  level.scr_eventanim["ls_revive_helper"]["idle_stand_8"] = % "hash_5e39e1f65c89be9f";
  level.scr_anim["ls_revive_helper"]["idle_stand_9"] = % sdr_mp_laststand_stand_revive_loop_helper_9;
  level.scr_eventanim["ls_revive_helper"]["idle_stand_9"] = % "hash_5e39e0f65c89bcec";
  level.scr_anim["ls_revive_helper"]["out_stand_1"] = % sdr_mp_laststand_stand_revive_out_helper_1;
  level.scr_eventanim["ls_revive_helper"]["out_stand_1"] = % "hash_5bf2192f07db8c84";
  level.scr_anim["ls_revive_helper"]["out_stand_2"] = % sdr_mp_laststand_stand_revive_out_helper_2;
  level.scr_eventanim["ls_revive_helper"]["out_stand_2"] = % "hash_5bf21c2f07db919d";
  level.scr_anim["ls_revive_helper"]["out_stand_3"] = % sdr_mp_laststand_stand_revive_out_helper_3;
  level.scr_eventanim["ls_revive_helper"]["out_stand_3"] = % "hash_5bf21b2f07db8fea";
  level.scr_anim["ls_revive_helper"]["out_stand_4"] = % sdr_mp_laststand_stand_revive_out_helper_4;
  level.scr_eventanim["ls_revive_helper"]["out_stand_4"] = % "hash_5bf2162f07db876b";
  level.scr_anim["ls_revive_helper"]["out_stand_6"] = % sdr_mp_laststand_stand_revive_out_helper_6;
  level.scr_eventanim["ls_revive_helper"]["out_stand_6"] = % "hash_5bf2182f07db8ad1";
  level.scr_anim["ls_revive_helper"]["out_stand_7"] = % sdr_mp_laststand_stand_revive_out_helper_7;
  level.scr_eventanim["ls_revive_helper"]["out_stand_7"] = % "hash_5bf2172f07db891e";
  level.scr_anim["ls_revive_helper"]["out_stand_8"] = % sdr_mp_laststand_stand_revive_out_helper_8;
  level.scr_eventanim["ls_revive_helper"]["out_stand_8"] = % "hash_5bf2122f07db809f";
  level.scr_anim["ls_revive_helper"]["out_stand_9"] = % sdr_mp_laststand_stand_revive_out_helper_9;
  level.scr_eventanim["ls_revive_helper"]["out_stand_9"] = % "hash_5bf2112f07db7eec";
  level.scr_anim["ls_revive_wounded"]["in_stand_1"] = % sdr_mp_laststand_stand_revive_in_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["in_stand_1"] = % "hash_640f389eda33fe09";
  level.scr_anim["ls_revive_wounded"]["in_stand_2"] = % sdr_mp_laststand_stand_revive_in_wounded_2;
  level.scr_eventanim["ls_revive_wounded"]["in_stand_2"] = % "hash_58b5428c10b17251";
  level.scr_anim["ls_revive_wounded"]["in_stand_3"] = % sdr_mp_laststand_stand_revive_in_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["in_stand_3"] = % "hash_76198c9ee49fa573";
  level.scr_anim["ls_revive_wounded"]["in_stand_4"] = % sdr_mp_laststand_stand_revive_in_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["in_stand_4"] = % "hash_640f389eda33fe09";
  level.scr_anim["ls_revive_wounded"]["in_stand_6"] = % sdr_mp_laststand_stand_revive_in_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["in_stand_6"] = % "hash_76198c9ee49fa573";
  level.scr_anim["ls_revive_wounded"]["in_stand_7"] = % sdr_mp_laststand_stand_revive_in_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["in_stand_7"] = % "hash_640f389eda33fe09";
  level.scr_anim["ls_revive_wounded"]["in_stand_8"] = % sdr_mp_laststand_stand_revive_in_wounded_8;
  level.scr_eventanim["ls_revive_wounded"]["in_stand_8"] = % "hash_58b5388c10b16153";
  level.scr_anim["ls_revive_wounded"]["in_stand_9"] = % sdr_mp_laststand_stand_revive_in_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["in_stand_9"] = % "hash_76198c9ee49fa573";
  level.scr_anim["ls_revive_wounded"]["idle_stand_1"] = % sdr_mp_laststand_stand_revive_loop_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_1"] = % "hash_365a974db6229312";
  level.scr_anim["ls_revive_wounded"]["idle_stand_2"] = % sdr_mp_laststand_stand_revive_loop_wounded_2;
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_2"] = % "hash_37ffbc737a907d52";
  level.scr_anim["ls_revive_wounded"]["idle_stand_3"] = % sdr_mp_laststand_stand_revive_loop_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_3"] = % "hash_4820eb4dc0546db0";
  level.scr_anim["ls_revive_wounded"]["idle_stand_4"] = % sdr_mp_laststand_stand_revive_loop_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_4"] = % "hash_365a974db6229312";
  level.scr_anim["ls_revive_wounded"]["idle_stand_6"] = % sdr_mp_laststand_stand_revive_loop_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_6"] = % "hash_4820eb4dc0546db0";
  level.scr_anim["ls_revive_wounded"]["idle_stand_7"] = % sdr_mp_laststand_stand_revive_loop_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_7"] = % "hash_365a974db6229312";
  level.scr_anim["ls_revive_wounded"]["idle_stand_8"] = % sdr_mp_laststand_stand_revive_loop_wounded_8;
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_8"] = % "hash_37ffc2737a908784";
  level.scr_anim["ls_revive_wounded"]["idle_stand_9"] = % sdr_mp_laststand_stand_revive_loop_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["idle_stand_9"] = % "hash_4820eb4dc0546db0";
  level.scr_anim["ls_revive_wounded"]["out_stand_1"] = % sdr_mp_laststand_stand_revive_out_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["out_stand_1"] = % "hash_6507ea1746995550";
  level.scr_anim["ls_revive_wounded"]["out_stand_2"] = % sdr_mp_laststand_stand_revive_out_wounded_2;
  level.scr_eventanim["ls_revive_wounded"]["out_stand_2"] = % "hash_68187a0bc392f10";
  level.scr_anim["ls_revive_wounded"]["out_stand_3"] = % sdr_mp_laststand_stand_revive_out_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["out_stand_3"] = % "hash_5487a6173d7c5882";
  level.scr_anim["ls_revive_wounded"]["out_stand_4"] = % sdr_mp_laststand_stand_revive_out_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["out_stand_4"] = % "hash_6507ea1746995550";
  level.scr_anim["ls_revive_wounded"]["out_stand_6"] = % sdr_mp_laststand_stand_revive_out_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["out_stand_6"] = % "hash_5487a6173d7c5882";
  level.scr_anim["ls_revive_wounded"]["out_stand_7"] = % sdr_mp_laststand_stand_revive_out_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["out_stand_7"] = % "hash_6507ea1746995550";
  level.scr_anim["ls_revive_wounded"]["out_stand_8"] = % sdr_mp_laststand_stand_revive_out_wounded_8;
  level.scr_eventanim["ls_revive_wounded"]["out_stand_8"] = % "hash_68191a0bc39400e";
  level.scr_anim["ls_revive_wounded"]["out_stand_9"] = % sdr_mp_laststand_stand_revive_out_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["out_stand_9"] = % "hash_5487a6173d7c5882";
  level.scr_anim["ls_revive_helper"]["in_crouch_1"] = % sdr_mp_laststand_crouch_revive_in_helper_1;
  level.scr_eventanim["ls_revive_helper"]["in_crouch_1"] = % "hash_687ac3c82a844511";
  level.scr_anim["ls_revive_helper"]["in_crouch_2"] = % sdr_mp_laststand_crouch_revive_in_helper_2;
  level.scr_eventanim["ls_revive_helper"]["in_crouch_2"] = % "hash_687ac0c82a843ff8";
  level.scr_anim["ls_revive_helper"]["in_crouch_3"] = % sdr_mp_laststand_crouch_revive_in_helper_3;
  level.scr_eventanim["ls_revive_helper"]["in_crouch_3"] = % "hash_687ac1c82a8441ab";
  level.scr_anim["ls_revive_helper"]["in_crouch_4"] = % sdr_mp_laststand_crouch_revive_in_helper_4;
  level.scr_eventanim["ls_revive_helper"]["in_crouch_4"] = % "hash_687ac6c82a844a2a";
  level.scr_anim["ls_revive_helper"]["in_crouch_6"] = % sdr_mp_laststand_crouch_revive_in_helper_6;
  level.scr_eventanim["ls_revive_helper"]["in_crouch_6"] = % "hash_687ac4c82a8446c4";
  level.scr_anim["ls_revive_helper"]["in_crouch_7"] = % sdr_mp_laststand_crouch_revive_in_helper_7;
  level.scr_eventanim["ls_revive_helper"]["in_crouch_7"] = % "hash_687ac5c82a844877";
  level.scr_anim["ls_revive_helper"]["in_crouch_8"] = % sdr_mp_laststand_crouch_revive_in_helper_8;
  level.scr_eventanim["ls_revive_helper"]["in_crouch_8"] = % "hash_687abac82a8435c6";
  level.scr_anim["ls_revive_helper"]["in_crouch_9"] = % sdr_mp_laststand_crouch_revive_in_helper_9;
  level.scr_eventanim["ls_revive_helper"]["in_crouch_9"] = % "hash_687abbc82a843779";
  level.scr_anim["ls_revive_helper"]["idle_crouch_1"] = % sdr_mp_laststand_crouch_revive_loop_helper_1;
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_1"] = % "hash_7de079e0db38372";
  level.scr_anim["ls_revive_helper"]["idle_crouch_2"] = % sdr_mp_laststand_crouch_revive_loop_helper_2;
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_2"] = % "hash_7de069e0db381bf";
  level.scr_anim["ls_revive_helper"]["idle_crouch_3"] = % sdr_mp_laststand_crouch_revive_loop_helper_3;
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_3"] = % "hash_7de059e0db3800c";
  level.scr_anim["ls_revive_helper"]["idle_crouch_4"] = % sdr_mp_laststand_crouch_revive_loop_helper_4;
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_4"] = % "hash_7de049e0db37e59";
  level.scr_anim["ls_revive_helper"]["idle_crouch_6"] = % sdr_mp_laststand_crouch_revive_loop_helper_6;
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_6"] = % "hash_7de029e0db37af3";
  level.scr_anim["ls_revive_helper"]["idle_crouch_7"] = % sdr_mp_laststand_crouch_revive_loop_helper_7;
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_7"] = % "hash_7de019e0db37940";
  level.scr_anim["ls_revive_helper"]["idle_crouch_8"] = % sdr_mp_laststand_crouch_revive_loop_helper_8;
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_8"] = % "hash_7de109e0db392bd";
  level.scr_anim["ls_revive_helper"]["idle_crouch_9"] = % sdr_mp_laststand_crouch_revive_loop_helper_9;
  level.scr_eventanim["ls_revive_helper"]["idle_crouch_9"] = % "hash_7de0f9e0db3910a";
  level.scr_anim["ls_revive_helper"]["out_crouch_1"] = % sdr_mp_laststand_crouch_revive_out_helper_1;
  level.scr_eventanim["ls_revive_helper"]["out_crouch_1"] = % "hash_2761e1a3aebc7042";
  level.scr_anim["ls_revive_helper"]["out_crouch_2"] = % sdr_mp_laststand_crouch_revive_out_helper_2;
  level.scr_eventanim["ls_revive_helper"]["out_crouch_2"] = % "hash_2761e0a3aebc6e8f";
  level.scr_anim["ls_revive_helper"]["out_crouch_3"] = % sdr_mp_laststand_crouch_revive_out_helper_3;
  level.scr_eventanim["ls_revive_helper"]["out_crouch_3"] = % "hash_2761dfa3aebc6cdc";
  level.scr_anim["ls_revive_helper"]["out_crouch_4"] = % sdr_mp_laststand_crouch_revive_out_helper_4;
  level.scr_eventanim["ls_revive_helper"]["out_crouch_4"] = % "hash_2761dea3aebc6b29";
  level.scr_anim["ls_revive_helper"]["out_crouch_6"] = % sdr_mp_laststand_crouch_revive_out_helper_6;
  level.scr_eventanim["ls_revive_helper"]["out_crouch_6"] = % "hash_2761dca3aebc67c3";
  level.scr_anim["ls_revive_helper"]["out_crouch_7"] = % sdr_mp_laststand_crouch_revive_out_helper_7;
  level.scr_eventanim["ls_revive_helper"]["out_crouch_7"] = % "hash_2761dba3aebc6610";
  level.scr_anim["ls_revive_helper"]["out_crouch_8"] = % sdr_mp_laststand_crouch_revive_out_helper_8;
  level.scr_eventanim["ls_revive_helper"]["out_crouch_8"] = % "hash_2761eaa3aebc7f8d";
  level.scr_anim["ls_revive_helper"]["out_crouch_9"] = % sdr_mp_laststand_crouch_revive_out_helper_9;
  level.scr_eventanim["ls_revive_helper"]["out_crouch_9"] = % "hash_2761e9a3aebc7dda";
  level.scr_anim["ls_revive_wounded"]["in_crouch_1"] = % sdr_mp_laststand_crouch_revive_in_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_1"] = % "hash_721d0d889e703c13";
  level.scr_anim["ls_revive_wounded"]["in_crouch_2"] = % sdr_mp_laststand_crouch_revive_in_wounded_2;
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_2"] = % "hash_18e05b4339c53af3";
  level.scr_anim["ls_revive_wounded"]["in_crouch_3"] = % sdr_mp_laststand_crouch_revive_in_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_3"] = % "hash_61c5c188957636c1";
  level.scr_anim["ls_revive_wounded"]["in_crouch_4"] = % sdr_mp_laststand_crouch_revive_in_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_4"] = % "hash_721d0d889e703c13";
  level.scr_anim["ls_revive_wounded"]["in_crouch_6"] = % sdr_mp_laststand_crouch_revive_in_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_6"] = % "hash_61c5c188957636c1";
  level.scr_anim["ls_revive_wounded"]["in_crouch_7"] = % sdr_mp_laststand_crouch_revive_in_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_7"] = % "hash_721d0d889e703c13";
  level.scr_anim["ls_revive_wounded"]["in_crouch_8"] = % sdr_mp_laststand_crouch_revive_in_wounded_8;
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_8"] = % "hash_18e0654339c54bf1";
  level.scr_anim["ls_revive_wounded"]["in_crouch_9"] = % sdr_mp_laststand_crouch_revive_in_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["in_crouch_9"] = % "hash_61c5c188957636c1";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_1"] = % sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_1"] = % "hash_55b2fa746fb6da78";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_2"] = % sdr_mp_laststand_crouch_revive_loop_wounded_2;
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_2"] = % "hash_f854126b96b4738";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_3"] = % sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_3"] = % "hash_43eca6746584ffda";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_4"] = % sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_4"] = % "hash_55b2fa746fb6da78";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_6"] = % sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_6"] = % "hash_43eca6746584ffda";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_7"] = % sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_7"] = % "hash_55b2fa746fb6da78";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_8"] = % sdr_mp_laststand_crouch_revive_loop_wounded_8;
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_8"] = % "hash_f853b26b96b3d06";
  level.scr_anim["ls_revive_wounded"]["idle_crouch_9"] = % sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["idle_crouch_9"] = % "hash_43eca6746584ffda";
  level.scr_anim["ls_revive_wounded"]["out_crouch_1"] = % sdr_mp_laststand_crouch_revive_out_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_1"] = % "hash_6f7b987c82460b66";
  level.scr_anim["ls_revive_wounded"]["out_crouch_2"] = % sdr_mp_laststand_crouch_revive_out_wounded_2;
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_2"] = % "hash_24b7c214402bbbf6";
  level.scr_anim["ls_revive_wounded"]["out_crouch_3"] = % sdr_mp_laststand_crouch_revive_out_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_3"] = % "hash_7ffbf47c8b6330fc";
  level.scr_anim["ls_revive_wounded"]["out_crouch_4"] = % sdr_mp_laststand_crouch_revive_out_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_4"] = % "hash_6f7b987c82460b66";
  level.scr_anim["ls_revive_wounded"]["out_crouch_6"] = % sdr_mp_laststand_crouch_revive_out_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_6"] = % "hash_7ffbf47c8b6330fc";
  level.scr_anim["ls_revive_wounded"]["out_crouch_7"] = % sdr_mp_laststand_crouch_revive_out_wounded_1_4_7;
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_7"] = % "hash_6f7b987c82460b66";
  level.scr_anim["ls_revive_wounded"]["out_crouch_8"] = % sdr_mp_laststand_crouch_revive_out_wounded_8;
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_8"] = % "hash_24b7c814402bc628";
  level.scr_anim["ls_revive_wounded"]["out_crouch_9"] = % sdr_mp_laststand_crouch_revive_out_wounded_3_6_9;
  level.scr_eventanim["ls_revive_wounded"]["out_crouch_9"] = % "hash_7ffbf47c8b6330fc";
  level.scr_anim["ls_revive_wounded"]["in_prone_1"] = % sdr_mp_laststand_prone_revive_in_wounded_1;
  level.scr_eventanim["ls_revive_wounded"]["in_prone_1"] = % "hash_198ac60bff94a18e";
  level.scr_anim["ls_revive_wounded"]["in_prone_2"] = % sdr_mp_laststand_prone_revive_in_wounded_2;
  level.scr_eventanim["ls_revive_wounded"]["in_prone_2"] = % "hash_198ac50bff949fdb";
  level.scr_anim["ls_revive_wounded"]["in_prone_3"] = % sdr_mp_laststand_prone_revive_in_wounded_3;
  level.scr_eventanim["ls_revive_wounded"]["in_prone_3"] = % "hash_198ac40bff949e28";
  level.scr_anim["ls_revive_wounded"]["in_prone_4"] = % sdr_mp_laststand_prone_revive_in_wounded_4;
  level.scr_eventanim["ls_revive_wounded"]["in_prone_4"] = % "hash_198acb0bff94aa0d";
  level.scr_anim["ls_revive_wounded"]["in_prone_6"] = % sdr_mp_laststand_prone_revive_in_wounded_6;
  level.scr_eventanim["ls_revive_wounded"]["in_prone_6"] = % "hash_198ac90bff94a6a7";
  level.scr_anim["ls_revive_wounded"]["in_prone_7"] = % sdr_mp_laststand_prone_revive_in_wounded_7;
  level.scr_eventanim["ls_revive_wounded"]["in_prone_7"] = % "hash_198ac80bff94a4f4";
  level.scr_anim["ls_revive_wounded"]["in_prone_8"] = % sdr_mp_laststand_prone_revive_in_wounded_8;
  level.scr_eventanim["ls_revive_wounded"]["in_prone_8"] = % "hash_198abf0bff9495a9";
  level.scr_anim["ls_revive_wounded"]["in_prone_9"] = % sdr_mp_laststand_prone_revive_in_wounded_9;
  level.scr_eventanim["ls_revive_wounded"]["in_prone_9"] = % "hash_198abe0bff9493f6";
  level.scr_anim["ls_revive_wounded"]["idle_prone_1"] = % sdr_mp_laststand_prone_revive_loop_wounded_1;
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_1"] = % "hash_19765df37b5c5d89";
  level.scr_anim["ls_revive_wounded"]["idle_prone_2"] = % sdr_mp_laststand_prone_revive_loop_wounded_2;
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_2"] = % "hash_19765af37b5c5870";
  level.scr_anim["ls_revive_wounded"]["idle_prone_3"] = % sdr_mp_laststand_prone_revive_loop_wounded_3;
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_3"] = % "hash_19765bf37b5c5a23";
  level.scr_anim["ls_revive_wounded"]["idle_prone_4"] = % sdr_mp_laststand_prone_revive_loop_wounded_4;
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_4"] = % "hash_197660f37b5c62a2";
  level.scr_anim["ls_revive_wounded"]["idle_prone_6"] = % sdr_mp_laststand_prone_revive_loop_wounded_6;
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_6"] = % "hash_19765ef37b5c5f3c";
  level.scr_anim["ls_revive_wounded"]["idle_prone_7"] = % sdr_mp_laststand_prone_revive_loop_wounded_7;
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_7"] = % "hash_19765ff37b5c60ef";
  level.scr_anim["ls_revive_wounded"]["idle_prone_8"] = % sdr_mp_laststand_prone_revive_loop_wounded_8;
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_8"] = % "hash_197664f37b5c696e";
  level.scr_anim["ls_revive_wounded"]["idle_prone_9"] = % sdr_mp_laststand_prone_revive_loop_wounded_9;
  level.scr_eventanim["ls_revive_wounded"]["idle_prone_9"] = % "hash_197665f37b5c6b21";
  level.scr_anim["ls_revive_wounded"]["out_prone_1"] = % sdr_mp_laststand_prone_revive_out_wounded_1;
  level.scr_eventanim["ls_revive_wounded"]["out_prone_1"] = % "hash_3011400355d5f32b";
  level.scr_anim["ls_revive_wounded"]["out_prone_2"] = % sdr_mp_laststand_prone_revive_out_wounded_2;
  level.scr_eventanim["ls_revive_wounded"]["out_prone_2"] = % "hash_3011410355d5f4de";
  level.scr_anim["ls_revive_wounded"]["out_prone_3"] = % sdr_mp_laststand_prone_revive_out_wounded_3;
  level.scr_eventanim["ls_revive_wounded"]["out_prone_3"] = % "hash_3011420355d5f691";
  level.scr_anim["ls_revive_wounded"]["out_prone_4"] = % sdr_mp_laststand_prone_revive_out_wounded_4;
  level.scr_eventanim["ls_revive_wounded"]["out_prone_4"] = % "hash_3011430355d5f844";
  level.scr_anim["ls_revive_wounded"]["out_prone_6"] = % sdr_mp_laststand_prone_revive_out_wounded_6;
  level.scr_eventanim["ls_revive_wounded"]["out_prone_6"] = % "hash_3011450355d5fbaa";
  level.scr_anim["ls_revive_wounded"]["out_prone_7"] = % sdr_mp_laststand_prone_revive_out_wounded_7;
  level.scr_eventanim["ls_revive_wounded"]["out_prone_7"] = % "hash_3011460355d5fd5d";
  level.scr_anim["ls_revive_wounded"]["out_prone_8"] = % sdr_mp_laststand_prone_revive_out_wounded_8;
  level.scr_eventanim["ls_revive_wounded"]["out_prone_8"] = % "hash_3011370355d5e3e0";
  level.scr_anim["ls_revive_wounded"]["out_prone_9"] = % sdr_mp_laststand_prone_revive_out_wounded_9;
  level.scr_eventanim["ls_revive_wounded"]["out_prone_9"] = % "hash_3011380355d5e593";
  level.scr_anim["ls_revive_helper"]["in_prone_1"] = % sdr_mp_laststand_prone_revive_in_helper_1;
  level.scr_eventanim["ls_revive_helper"]["in_prone_1"] = % "hash_5cae9f8a9e36c7c9";
  level.scr_anim["ls_revive_helper"]["in_prone_2"] = % sdr_mp_laststand_prone_revive_in_helper_2;
  level.scr_eventanim["ls_revive_helper"]["in_prone_2"] = % "hash_5cae9c8a9e36c2b0";
  level.scr_anim["ls_revive_helper"]["in_prone_3"] = % sdr_mp_laststand_prone_revive_in_helper_3;
  level.scr_eventanim["ls_revive_helper"]["in_prone_3"] = % "hash_5cae9d8a9e36c463";
  level.scr_anim["ls_revive_helper"]["in_prone_4"] = % sdr_mp_laststand_prone_revive_in_helper_4;
  level.scr_eventanim["ls_revive_helper"]["in_prone_4"] = % "hash_5caea28a9e36cce2";
  level.scr_anim["ls_revive_helper"]["in_prone_6"] = % sdr_mp_laststand_prone_revive_in_helper_6;
  level.scr_eventanim["ls_revive_helper"]["in_prone_6"] = % "hash_5caea08a9e36c97c";
  level.scr_anim["ls_revive_helper"]["in_prone_7"] = % sdr_mp_laststand_prone_revive_in_helper_7;
  level.scr_eventanim["ls_revive_helper"]["in_prone_7"] = % "hash_5caea18a9e36cb2f";
  level.scr_anim["ls_revive_helper"]["in_prone_8"] = % sdr_mp_laststand_prone_revive_in_helper_8;
  level.scr_eventanim["ls_revive_helper"]["in_prone_8"] = % "hash_5caea68a9e36d3ae";
  level.scr_anim["ls_revive_helper"]["in_prone_9"] = % sdr_mp_laststand_prone_revive_in_helper_9;
  level.scr_eventanim["ls_revive_helper"]["in_prone_9"] = % "hash_5caea78a9e36d561";
  level.scr_anim["ls_revive_helper"]["idle_prone_1"] = % sdr_mp_laststand_prone_revive_loop_helper_1;
  level.scr_eventanim["ls_revive_helper"]["idle_prone_1"] = % "hash_8c99360d1b4573a";
  level.scr_anim["ls_revive_helper"]["idle_prone_2"] = % sdr_mp_laststand_prone_revive_loop_helper_2;
  level.scr_eventanim["ls_revive_helper"]["idle_prone_2"] = % "hash_8c99260d1b45587";
  level.scr_anim["ls_revive_helper"]["idle_prone_3"] = % sdr_mp_laststand_prone_revive_loop_helper_3;
  level.scr_eventanim["ls_revive_helper"]["idle_prone_3"] = % "hash_8c99160d1b453d4";
  level.scr_anim["ls_revive_helper"]["idle_prone_4"] = % sdr_mp_laststand_prone_revive_loop_helper_4;
  level.scr_eventanim["ls_revive_helper"]["idle_prone_4"] = % "hash_8c99060d1b45221";
  level.scr_anim["ls_revive_helper"]["idle_prone_6"] = % sdr_mp_laststand_prone_revive_loop_helper_6;
  level.scr_eventanim["ls_revive_helper"]["idle_prone_6"] = % "hash_8c98e60d1b44ebb";
  level.scr_anim["ls_revive_helper"]["idle_prone_7"] = % sdr_mp_laststand_prone_revive_loop_helper_7;
  level.scr_eventanim["ls_revive_helper"]["idle_prone_7"] = % "hash_8c98d60d1b44d08";
  level.scr_anim["ls_revive_helper"]["idle_prone_8"] = % sdr_mp_laststand_prone_revive_loop_helper_8;
  level.scr_eventanim["ls_revive_helper"]["idle_prone_8"] = % "hash_8c98c60d1b44b55";
  level.scr_anim["ls_revive_helper"]["idle_prone_9"] = % sdr_mp_laststand_prone_revive_loop_helper_9;
  level.scr_eventanim["ls_revive_helper"]["idle_prone_9"] = % "hash_8c98b60d1b449a2";
  level.scr_anim["ls_revive_helper"]["out_prone_1"] = % sdr_mp_laststand_prone_revive_out_helper_1;
  level.scr_eventanim["ls_revive_helper"]["out_prone_1"] = % "hash_419975935aa90b5a";
  level.scr_anim["ls_revive_helper"]["out_prone_2"] = % sdr_mp_laststand_prone_revive_out_helper_2;
  level.scr_eventanim["ls_revive_helper"]["out_prone_2"] = % "hash_419974935aa909a7";
  level.scr_anim["ls_revive_helper"]["out_prone_3"] = % sdr_mp_laststand_prone_revive_out_helper_3;
  level.scr_eventanim["ls_revive_helper"]["out_prone_3"] = % "hash_419973935aa907f4";
  level.scr_anim["ls_revive_helper"]["out_prone_4"] = % sdr_mp_laststand_prone_revive_out_helper_4;
  level.scr_eventanim["ls_revive_helper"]["out_prone_4"] = % "hash_419972935aa90641";
  level.scr_anim["ls_revive_helper"]["out_prone_6"] = % sdr_mp_laststand_prone_revive_out_helper_6;
  level.scr_eventanim["ls_revive_helper"]["out_prone_6"] = % "hash_419970935aa902db";
  level.scr_anim["ls_revive_helper"]["out_prone_7"] = % sdr_mp_laststand_prone_revive_out_helper_7;
  level.scr_eventanim["ls_revive_helper"]["out_prone_7"] = % "hash_41996f935aa90128";
  level.scr_anim["ls_revive_helper"]["out_prone_8"] = % sdr_mp_laststand_prone_revive_out_helper_8;
  level.scr_eventanim["ls_revive_helper"]["out_prone_8"] = % "hash_41996e935aa8ff75";
  level.scr_anim["ls_revive_helper"]["out_prone_9"] = % sdr_mp_laststand_prone_revive_out_helper_9;
  level.scr_eventanim["ls_revive_helper"]["out_prone_9"] = % "hash_41996d935aa8fdc2";
  scripts\common\anim::addnotetrack_customfunction("ls_revive_wounded", "cp_foley_revive_wounded_down", &revive_wounded_in_handler);
  scripts\common\anim::addnotetrack_customfunction("ls_revive_wounded", "cp_last_stand_revive_out_wounded", &revive_wounded_out_handler);
  scripts\common\anim::addnotetrack_customfunction("ls_revive_wounded", "cp_foley_revive_wounded_recover_standing", &revive_wounded_out_handlerr);
  scripts\common\anim::addnotetrack_customfunction("ls_revive_helper", "stim_attach", &syringe_out);
  scripts\common\anim::addnotetrack_customfunction("ls_revive_helper", "syringe_inject", &syringe_inject);
  scripts\common\anim::addnotetrack_customfunction("ls_revive_helper", "syringe_finish", &syringe_finish);
  scripts\common\anim::addnotetrack_customfunction("ls_revive_helper", "syringe_finish_crouching", &syringe_finish_crouch);
  scripts\common\anim::addnotetrack_customfunction("ls_revive_helper", "syringe_finish_standing", &syringe_finish_stand);
}

function syringe_out(guy) {
  guy.entity notify("spawn_stim");
  guy playsoundonmovingent("cp_foley_revive_helper_syringe_out");
}

function syringe_inject(guy) {
  guy playsoundonmovingent("cp_foley_revive_helper_syringe_inject");
}

function syringe_finish(guy) {
  guy playsoundonmovingent("cp_foley_revive_helper_syringe_finish");
  guy.entity notify("remove_stim");
}

function syringe_finish_crouch(guy) {
  guy playsoundonmovingent("cp_foley_revive_helper_recover_crouching");
  guy.entity notify("remove_stim");
}

function syringe_finish_stand(guy) {
  guy playsoundonmovingent("cp_last_stand_revive_out_helper");
  guy.entity notify("remove_stim");
}

function revive_wounded_in_handler(guy) {
  guy playsoundonmovingent("cp_foley_revive_wounded_down");
}

function revive_wounded_out_handler(guy) {
  guy playsoundonmovingent("cp_last_stand_revive_out_wounded");
}

function revive_wounded_out_handlerr(guy) {
  guy playsoundonmovingent("cp_foley_revive_wounded_recover_standing");
}

function set_revive_time(normal_revive_time, spectator_revive_time, fast_revive_time) {
  if(isDefined(normal_revive_time)) {
    level.normal_revive_time = normal_revive_time;
  }

  if(isDefined(spectator_revive_time)) {
    level.spectator_revive_time = spectator_revive_time;
  }

  level.fast_revive_time = fast_revive_time;
}

function set_cam(camera) {
  if(istrue(self.relic_third_person) || istrue(self.var_911b640702fec71a)) {
    self setcamerathirdperson(1);
    self function_5762cf97c6f1a2c1("first_person");
    return;
  }

  if(!isDefined(camera)) {
    self cameradefault();
    self setcamerathirdperson(0);
    return;
  }

  self cameraset(camera);
}

function any_player_in_laststand() {
  for(i = 0; i < level.players.size; i++) {
    if(istrue(level.players[i].inlaststand)) {
      return true;
    }
  }

  return false;
}

function function_9d6ac1baf6c44970() {
  if(function_f1f7670d27b96e26()) {
    drop_info = scripts\cp\pickups::getitemdroporiginandangles(scripts\cp\agent_drops::function_b1c55038843de38b(), self.origin, self.angles);

    if(isDefined(self.plundercount) && self.plundercount > 0) {
      scripts\cp\pickups::drop_cash(self.plundercount, scripts\cp\agent_drops::function_b1c55038843de38b());
      drop_info = scripts\cp\pickups::getitemdroporiginandangles(scripts\cp\agent_drops::function_b1c55038843de38b(), self.origin, self.angles);
      scripts\cp\persistence::set_player_currency(0);
    }

    if(isDefined(self.copy_fullweaponlist)) {
      for(i = 0; i < self.copy_fullweaponlist.size; i++) {
        if(scripts\cp\pickups::function_b3b99f9f9371c997(self.copy_fullweaponlist[i])) {
          scripts\cp\pickups::weaponspawn(self.copy_fullweaponlist[i], drop_info, 0, 1);
          drop_info = scripts\cp\pickups::getitemdroporiginandangles(scripts\cp\agent_drops::function_b1c55038843de38b(), self.origin, self.angles);
        }
      }
    } else if(isDefined(self.primaryweapons)) {
      for(i = 0; i < self.primaryweapons.size; i++) {
        if(scripts\cp\pickups::function_b3b99f9f9371c997(self.primaryweapons[i])) {
          scripts\cp\pickups::weaponspawn(self.primaryweapons[i], drop_info, 0, 1);
          drop_info = scripts\cp\pickups::getitemdroporiginandangles(scripts\cp\agent_drops::function_b1c55038843de38b(), self.origin, self.angles);
          scripts\cp_mp\utility\inventory_utility::_takeweapon(self.primaryweapons[i]);
        }
      }
    }

    if(isDefined(self.armorqueued) && self.armorqueued >= 1) {
      dropinfo = scripts\cp\pickups::getitemdroporiginandangles(scripts\cp\agent_drops::function_b1c55038843de38b(), self.origin, self.angles, self);
      item = scripts\cp\pickups::spawnpickup("brloot_armor_plate", dropinfo, self.armorqueued, 1, undefined, 1);
    }

    if(isDefined(self.pre_laststand_powers)) {
      powers = getarraykeys(self.pre_laststand_powers);

      for(i = 0; i < powers.size; i++) {
        drop_name = scripts\cp\pickups::function_63699875d9aca328(powers[i]);
        dropinfo = scripts\cp\pickups::getitemdroporiginandangles(scripts\cp\agent_drops::function_b1c55038843de38b(), self.origin, self.angles, self);
        count = self.pre_laststand_powers[powers[i]].charges;
        item = scripts\cp\pickups::spawnpickup(drop_name, dropinfo, count, 1, undefined, 0);
      }
    } else if(isDefined(self.powers)) {
      powers = getarraykeys(self.powers);

      for(i = 0; i < powers.size; i++) {
        drop_name = scripts\cp\pickups::function_63699875d9aca328(powers[i]);

        if(isDefined(drop_name)) {
          dropinfo = scripts\cp\pickups::getitemdroporiginandangles(scripts\cp\agent_drops::function_b1c55038843de38b(), self.origin, self.angles, self);
          count = self.powers[powers[i]].charges;
          item = scripts\cp\pickups::spawnpickup(drop_name, dropinfo, count, 1, undefined, 0);
        }
      }
    }

    scripts\cp\pickups::function_5cff081d620d2ef3();
  }
}

function function_f1f7670d27b96e26() {
  if(getdvarint(@ "hash_1bd4d94e5c712d0f")) {
    return false;
  }

  return true;
}

function wait_in_spectator(var_318ade4970c8f647, gameshouldend) {
  self notify("wait_in_spectator");
  self endon("wait_in_spectator");
  self endon("disconnect");
  level endon("game_ended");
  setbeingrevivedinternal(0);
  assertex(!isalive(self), "<dev string:x30c>");

  if(!isDefined(gameshouldend)) {
    gameshouldend = function_5de995015a65e87d(self);
  }

  if(!level.var_28bcdd92f005721) {
    self.var_a4f1d87b225a8d61 = 1;
  }

  self.begin_spectate = 1;
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
  waitframe();
  scripts\cp\globallogic::broadcast_status(self, 2);
  record_bleedout(var_318ade4970c8f647);

  if(isDefined(self.bleedoutspawnentityoverride)) {
    self.bleedoutspawnentityoverride = undefined;
  }

  if(is_killed_by_kill_trigger(var_318ade4970c8f647)) {
    drop_loc = self;

    if(isDefined(self.var_80f9d0aeaa47cc0c) && scripts\cp\cp_outofbounds::isoob(self, 0)) {
      drop_loc = self.var_80f9d0aeaa47cc0c;
    } else if(isDefined(var_318ade4970c8f647)) {
      drop_loc = var_318ade4970c8f647;
    }

    spawnloc = drop_to_ground(drop_loc.origin, 32, -64) + (0, 0, 5);
    spawnangle = drop_loc.angles;
  } else {
    spawnloc = self.origin;
    spawnangle = self.angles;
  }

  clear_last_stand_timer(self);
  self.spectating = 1;

  if(function_41352b6db86ef848()) {
    function_408ef6a51dacaca4(spawnloc, spawnangle);
  } else {
    self notify("entered_spectate");

    if(!istrue(level.var_93b4908cf59eea60) && isDefined(level.enter_spectator_func)) {
      level thread[[level.enter_spectator_func]](self);
    }

    if(istrue(level.var_93b4908cf59eea60)) {
      thread enter_spectate(self, spawnloc, undefined);
      self.last_stand_state = "bleed_out";

      if(scripts\cp\utility::function_ddafef2154fd19bb()) {
        for(i = 0; i < level.players.size; i++) {
          if(level.players[i] != self) {
            level.players[i] thread scripts\cp\cp_hud_message::showsplash("cp_respawn_buy_ready");
          }
        }

        thread function_6d977e4da51c55f3(3);
      }

      waittill_any_ents(self, "revive_success");
    } else {
      if(!gameshouldend) {
        result = wait_to_be_revived(self, spawnloc, undefined, undefined, 0, get_spectator_revive_time(), (1, 0, 0), undefined, 1, gameshouldend, 1);
      } else {
        result = wait_to_be_revived(self, spawnloc, undefined, undefined, 0, get_spectator_revive_time(), (1, 0, 0), undefined, 0, gameshouldend, 1);
      }

      if(scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
        function_5ad98c689425d831();
      }
    }

    show_all_revive_icons();
    scripts\cp\globallogic::broadcast_status(self, 0);
    self.spectating = undefined;
    self.begin_spectate = undefined;
    scripts\cp\utility::updatesessionstate("playing");

    if(!isDefined(self.forcespawnorigin) && !isDefined(self.forcespawnangles)) {
      self.forcespawnorigin = spawnloc;
      self.forcespawnangles = spawnangle;
    }

    if(isDefined(level.prespawnfromspectatorfunc)) {
      [[level.prespawnfromspectatorfunc]](self);
    }

    var_b42ca26b52bd9762 = istrue(self.var_a4f1d87b225a8d61);
    self.var_a4f1d87b225a8d61 = undefined;
    [[level.spawnplayerfunc]](undefined, undefined, var_b42ca26b52bd9762);

    if(!istrue(level.all_players_skip_last_stand)) {
      self.shouldskiplaststand = 0;
    }

    scripts\cp\utility::freezecontrolswrapper(0);

    if(scripts\cp\cp_relics::function_7915e88a08f28705()) {
      function_b2820f8c0083d223(self);
    }
  }

  if(isDefined(level.var_595da6922b3e48dc)) {
    self[[level.var_595da6922b3e48dc]]();
  }

  thread onexitcommon(gameshouldend);
  dropcarryobject();
}

function function_b2820f8c0083d223(player) {
  scripts\cp\cp_relics::init_relic_vars(player);
  player thread scripts\cp\cp_relics::relics_monitor_on_player();
}

function function_41352b6db86ef848() {
  return isDefined(level.respawn_func) && !istrue(level.dogtag_revive);
}

function function_408ef6a51dacaca4(spawnloc, spawnangle) {
  self.last_stand_state = "bleed_out";

  if(isDefined(level.automated_respawn_func)) {
    while(!istrue(level.automated_respawn_available)) {
      self iprintln("<dev string:x332>");

      wait 1;
    }

    if(!istrue(level.automated_respawn_delay_skip)) {
      level thread[[level.automated_respawn_func]]();
    }
  }

  if(self[[level.respawn_func]](self, spawnloc)) {
    self.bspawningviaac130 = 1;
    show_all_revive_icons();
    scripts\cp\globallogic::broadcast_status(self, 0);
    self.spectating = undefined;
    scripts\cp\utility::updatesessionstate("playing");

    if(!isDefined(self.forcespawnorigin) && !isDefined(self.forcespawnangles)) {
      self.forcespawnorigin = spawnloc;
      self.forcespawnangles = spawnangle;
    }

    if(isDefined(level.prespawnfromspectatorfunc)) {
      [[level.prespawnfromspectatorfunc]](self);
    }

    if(istrue(self.forced_revive)) {
      self.forced_revive = undefined;
      [[level.spawnplayerfunc]]();
    } else {
      [[level.spawnplayerfunc]](1);
    }

    self.shouldskiplaststand = 0;
    return;
  }

  assertmsg(" ThIs ShOuLdNt HaPpEn ");
}

function record_bleedout(var_318ade4970c8f647) {
  scripts\cp\persistence::eog_player_update_stat("deaths", 1);

  if(!is_killed_by_kill_trigger(var_318ade4970c8f647)) {
    scripts\cp\cp_gamescore::update_team_encounter_performance(scripts\cp\cp_gamescore::get_team_score_component_name(), "num_players_bleed_out");
    scripts\cp\cp_analytics::inc_bleedout_counts();
  }
}

function is_killed_by_kill_trigger(var_318ade4970c8f647) {
  return isDefined(var_318ade4970c8f647) || istrue(self.oob) || istrue(self.shouldskiplaststand) || istrue(self isswimming());
}

function wait_to_be_revived(downedplayer, spawnloc, var_ae4fae9ba66e6aa3, var_da0143862335cb2a, var_960565c8383e5c83, revivetime, iconcolor, timelimit, var_3bc814fcff1670fd, gameshouldend, var_abd29c5af2a4d78a, var_ba651aff199a8cd4) {
  if(isDefined(downedplayer.dogtag)) {
    reviveent = downedplayer.dogtag;
  } else if(istrue(downedplayer.var_a14c34f117daf30a)) {
    reviveent = downedplayer spawn_tag_origin();
  } else {
    reviveent = makereviveentity(downedplayer, spawnloc, var_ae4fae9ba66e6aa3, var_da0143862335cb2a, var_960565c8383e5c83);
  }

  if(var_3bc814fcff1670fd) {
    thread enter_spectate(downedplayer, spawnloc, reviveent);
    downedplayer.last_stand_state = "bleed_out";
  } else {
    level notify("waiting_to_be_revived_from_laststand", downedplayer);
  }

  if(function_9d24182b90507aa9()) {
    reviveent function_dfb78b3e724ad620(0);
  }

  if(gameshouldend) {
    level waittill("forever");
    return 0;
  }

  reviveiconent = reviveent;

  if(!istrue(downedplayer.var_a14c34f117daf30a)) {
    if(var_3bc814fcff1670fd) {}

    if(var_abd29c5af2a4d78a) {}
  } else {
    reviveent setModel("tag_origin");
  }

  downedplayer.reviveent = reviveent;
  downedplayer.reviveiconent = reviveiconent;

  if(isDefined(level.give_up_func) && (!downedplayer isspectatingplayer() || !istrue(var_3bc814fcff1670fd))) {
    downedplayer thread[[level.give_up_func]](downedplayer, spawnloc, var_ae4fae9ba66e6aa3, var_da0143862335cb2a, var_960565c8383e5c83, revivetime, iconcolor, timelimit, var_3bc814fcff1670fd, gameshouldend, var_abd29c5af2a4d78a, var_ba651aff199a8cd4);
  }

  if(!isDefined(reviveent)) {
    level waittill("forever");
    return 0;
  }

  if(istrue(1)) {
    reviveent thread laststandmoveawayfromvehicles(downedplayer, revivetime);
  }

  if(isDefined(timelimit)) {
    result = reviveent waittill_any_ents_or_timeout_return(timelimit, reviveent, "revive_success", downedplayer, "force_bleed_out", downedplayer, "revive_success", downedplayer, "challenge_complete_revive");
  } else {
    result = reviveent waittill_any_ents_return(reviveent, "revive_success", downedplayer, "challenge_complete_revive", downedplayer, "force_bleed_out", downedplayer, "last_stand_finished");
  }

  if(isDefined(result)) {
    if(result == "timeout" && is_being_revived(downedplayer)) {
      result = reviveent waittill_any_return_2("revive_success", "revive_fail");
    }

    if(result == "timeout" && player_is_trying_self_revive(downedplayer)) {
      result = reviveent waittill_any_return_2("revive_success", "revive_fail");
    }
  }

  if(isDefined(downedplayer.reviveent)) {
    downedplayer.reviveent delete();
  }

  if(isDefined(downedplayer.reviveiconent)) {
    downedplayer.reviveiconent delete();
  }

  downedplayer notify("give_up_done");

  if(!isDefined(result)) {
    return 1;
  }

  if(result == "revive_success" || result == "challenge_complete_revive") {
    return 1;
  }

  return 0;
}

function get_spectator_revive_time() {
  if(isDefined(level.spectator_revive_time)) {
    return level.spectator_revive_time;
  }

  return 6000;
}

function show_all_revive_icons() {
  if(isDefined(self.revive_icons)) {
    foreach(revive_icon in self.revive_icons) {
      revive_icon.alpha = 1;
    }
  }
}

function makereviveentity(downedplayer, spawnloc, var_ae4fae9ba66e6aa3, var_da0143862335cb2a, var_960565c8383e5c83) {
  if(istrue(level.gameended)) {
    return;
  }

  var_ad42b1ddb060fa39 = (0, 0, 20);
  var_eeee6f55bba7a8ee = anglesToForward(downedplayer.angles) * 30;
  spawnloc = drop_to_ground(spawnloc + var_ad42b1ddb060fa39 + var_eeee6f55bba7a8ee, 32, -64);
  reviveent = spawn("script_model", downedplayer.origin);
  reviveent makeusable();
  reviveent function_dfb78b3e724ad620(1);
  reviveent setHintString(&"COOP_GAME_PLAY/REVIVE_USE");
  reviveent setCursorHint("HINT_NOICON");
  reviveent setusehideprogressbar(1);
  reviveent setuseholdduration("duration_none");
  reviveent setusepriority(-1 - 1 - 1);
  reviveent.trigger = spawnStruct();
  reviveent.trigger.owner = downedplayer;
  reviveent.trigger.id = "laststand_reviver";
  reviveent.trigger.targetname = "revive_trigger";
  reviveent.owner = downedplayer;
  reviveent.inuse = 0;
  reviveent.targetname = "revive_trigger";
  downedplayer.reviveent = reviveent;

  if(isDefined(var_ae4fae9ba66e6aa3)) {
    reviveent setModel(var_ae4fae9ba66e6aa3);
  }

  if(isDefined(var_da0143862335cb2a)) {
    reviveent scriptmodelplayanim(var_da0143862335cb2a);
  }

  if(var_960565c8383e5c83) {
    reviveent linkTo(downedplayer, "tag_origin", var_ad42b1ddb060fa39, (0, 0, 0));
  }

  reviveent disableplayeruse(downedplayer);
  reviveent thread cleanuplaststandent(downedplayer);
  return reviveent;
}

function makereviveiconentity(downedplayer, reviveent) {
  if(istrue(level.gameended)) {
    return;
  }

  reviveiconent = spawn("script_model", reviveent.origin + (0, 0, 30));
  downedplayer.reviveiconent = reviveiconent;
  reviveiconent.owner = downedplayer;
  reviveiconent thread cleanuplaststandent(downedplayer, 1);
  return reviveiconent;
}

function makereviveicon(reviveiconent, owner, color, bleedouttime) {
  setup_revive_icon_ent(reviveiconent);
  reviveiconent.current_revive_icon_color = color;
  reviveiconent.revive_icon_color_keep = color;
  reviveiconent thread reviveiconentcleanup(reviveiconent);
  reviveicon = undefined;

  foreach(player in level.players) {
    if(player == owner) {}

    if(isDefined(level.should_show_revive_icon_to_player_func) && ![[level.should_show_revive_icon_to_player_func]](player, owner)) {
      continue;
    }

    reviveicon = show_revive_icon_to_player(reviveiconent, player);
    add_to_revive_icon_ent_icon_list(reviveiconent, reviveicon);
  }

  if(isDefined(bleedouttime)) {
    reviveiconent thread revive_icon_color_management(bleedouttime, owner);
  }

  return reviveicon;
}

function setup_revive_icon_ent(revive_icon_ent) {
  revive_icon_ent.revive_icons = [];
  add_to_revive_icon_entity_list(revive_icon_ent);
}

function add_to_revive_icon_ent_icon_list(revive_icon_ent, revive_icon) {
  assertex(!array_contains(revive_icon_ent.revive_icons, revive_icon), "<dev string:x34c>");
  revive_icon_ent.revive_icons[revive_icon_ent.revive_icons.size] = revive_icon;
}

function reviveiconentcleanup(reviveiconent) {
  reviveiconent waittill("death");
  remove_from_revive_icon_entity_list(reviveiconent);
}

function remove_from_revive_icon_entity_list(var_17eb95d4b724d96) {
  level.revive_icon_entities = array_remove(level.revive_icon_entities, var_17eb95d4b724d96);
  level.revive_icon_entities = array_removeundefined(level.revive_icon_entities);
}

function show_revive_icon_to_player(reviveiconent, owner) {
  reviveicon = newclienthudelem(owner);

  if(level.splitscreen) {
    reviveicon setshader("hud_realism_head_revive", 10, 10);
  } else {
    reviveicon setshader("hud_realism_head_revive", 5, 5);
  }

  reviveicon setwaypoint(1, 1);
  reviveicon settargetEnt(reviveiconent);
  reviveicon.alpha = get_revive_icon_initial_alpha(owner);
  reviveicon.color = reviveiconent.current_revive_icon_color;
  add_to_player_revive_icon_list(owner, reviveicon);
  reviveicon thread reviveiconcleanup(reviveiconent, owner);
  return reviveicon;
}

function get_revive_icon_initial_alpha(player) {
  return true;
}

function add_to_player_revive_icon_list(player, revive_icon) {
  assertex(!array_contains(player.revive_icons, revive_icon), "<dev string:x380>");
  player.revive_icons[player.revive_icons.size] = revive_icon;
}

function reviveiconcleanup(reviveiconent, owner) {
  waittill_any_ents_return(reviveiconent, "death", owner, "disconnect");
  remove_from_owner_revive_icon_list(self, owner);

  if(isDefined(self)) {
    self destroy();
  }
}

function remove_from_owner_revive_icon_list(revive_icon, owner) {
  if(!isDefined(owner)) {
    return;
  }

  assertex(array_contains(owner.revive_icons, revive_icon), "<dev string:x3b7>");
  owner.revive_icons = array_remove(owner.revive_icons, revive_icon);
}

function revive_icon_color_management(bleedouttime, downed_player) {
  level endon("game_ended");
  self endon("death");
  self endon("end_revive_icon_color_management");
  thread function_395d864602540630();
  wait bleedouttime / 3;
  set_revive_icon_color(self, (1, 0.941, 0));
  self.revive_icon_color_keep = (1, 0.941, 0);
  wait bleedouttime / 3;
  set_revive_icon_color(self, (0.929, 0.231, 0.141));
  self.revive_icon_color_keep = (0.929, 0.231, 0.141);
}

function function_395d864602540630() {
  self.owner endon("disconnect");
  self endon("death");
  self.owner waittill("entered_spectate");
  self notify("end_revive_icon_color_management");
  set_revive_icon_color(self, (0.929, 0.231, 0.141));
  self.revive_icon_color_keep = (0.929, 0.231, 0.141);
}

function laststandwaittillrevivebyteammate(downedplayer, revivetime) {
  level endon("game_ended");
  self endon("death");

  if(isDefined(level.revive_ent_usability_func)) {
    self thread[[level.revive_ent_usability_func]](downedplayer, self);
  }

  while(true) {
    self function_dfb78b3e724ad620(1);
    self setuseprioritymax();
    self waittill("trigger", reviver);
    self function_dfb78b3e724ad620(0);

    if(istrue(downedplayer getbeingrevivedinternal(1))) {
      continue;
    }

    if(istrue(downedplayer.instant_revived)) {
      continue;
    }

    if(istrue(downedplayer.isgivingup)) {
      continue;
    }

    if(reviver ismeleeing()) {
      continue;
    }

    if(istrue(reviver.land_usability_disabled)) {
      continue;
    }

    if(!isPlayer(reviver) && !istrue(reviver.can_revive)) {
      continue;
    }

    if(istrue(downedplayer.adrenalinepoweractive)) {
      continue;
    }

    if(istrue(reviver.usingascender)) {
      continue;
    }

    if(istrue(reviver.is_riding_hel)) {
      continue;
    }

    if(!isDefined(reviver.revive_vo_time)) {
      reviver.revive_vo_time = 0;
    }

    if(gettime() > reviver.revive_vo_time) {
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(reviver, #"bc_status_action_reviving");
      reviver.revive_vo_time = gettime() + 10000;
    }

    reviver notify("started_revive");
    disable_bleedout_ent_usability(downedplayer);
    reviver val::set("lastStandWaittillReviveByTeammate", "weapon", 0);
    level thread revivent_watchfordeath_safety(self, reviver);
    revive_success = get_revive_result(downedplayer, reviver, self.origin, int(revivetime));
    enable_bleedout_ent_usability(downedplayer);

    if(revive_success) {
      downedplayer thread function_1b7ebc11cd2bc4a8();
      reviver val::set("lastStandWaittillReviveByTeammate", "weapon", 1);

      if(isDefined(reviver.vo_prefix)) {
        if(isDefined(level.revive_success_vo_func)) {
          level thread[[level.revive_success_vo_func]](reviver, downedplayer);
        }
      } else if(function_7ba31cb6b21c346f()) {
        downedplayer thread function_36edf91561322753(2);
      } else {
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(downedplayer, #"bc_status_player_revived");
      }

      record_revive_success(reviver, downedplayer);
      reviver notify("revive_teammate", downedplayer);
      scripts\cp\cp_analytics::logevent_spawnviaplayer(downedplayer, reviver);
      kill_count = 1;
      downedplayer.last_stand_state = undefined;

      if(isPlayer(reviver)) {
        if(!istrue(reviver.can_give_revive_xp)) {
          reviver thread scripts\cp\points::doscoreevent(#"reviver", undefined, undefined, -1);
        } else {
          reviver thread scripts\cp\points::doscoreevent(#"reviver");
          reviver.can_give_revive_xp = 0;
        }
      }

      if(istrue(reviver.relic_third_person) || istrue(reviver.var_911b640702fec71a)) {
        reviver setcamerathirdperson(1);
        reviver function_5762cf97c6f1a2c1("first_person");
      }

      break;
    }

    reviver notify("revive_done");
    downedplayer notify("revive_done");
    reviver val::set("lastStandWaittillReviveByTeammate", "weapon", 1);
    set_revive_icon_color(downedplayer.reviveent, downedplayer.reviveent.revive_icon_color_keep, 1);

    if(!reviver scripts\cp_mp\utility\player_utility::_isalive() || reviver.inlaststand) {
      downedplayer.reviveent disableplayeruse(reviver);
      reviver thread downed_reviver_watch_for_return_to_usability(downedplayer.reviveent, reviver);
    }

    reviver delaythread(1.5, &scripts\cp\utility::force_usability_enabled);

    if(isDefined(reviver.revive_stim)) {
      reviver.revive_stim delete();
      reviver.revive_stim = undefined;
    }

    if(isDefined(reviver.revive_origin)) {
      reviver setOrigin(reviver.revive_origin);
      reviver.revive_origin = undefined;
    }

    self notify("revive_fail");

    if(istrue(reviver.relic_third_person) || istrue(reviver.var_911b640702fec71a)) {
      reviver setcamerathirdperson(1);
      reviver function_5762cf97c6f1a2c1("first_person");
    }

    continue;
  }

  clear_last_stand_timer(downedplayer);
  self notify("revive_success");
}

function function_15276c5b8c5146e8(downedplayer) {
  if(!downedplayer isonground()) {
    if(isDefined(level.custom_putongroundfunc) && isfunction(level.custom_putongroundfunc)) {
      [[level.custom_putongroundfunc]](downedplayer);
      return;
    }

    pos = drop_to_ground(downedplayer.origin, 5, -1500);
    pos = getclosestpointonnavmesh(pos);
    downedplayer setOrigin(pos);
  }
}

function disable_bleedout_ent_usability(downedplayer) {
  if(isDefined(downedplayer.executeent)) {
    if(isDefined(level.disable_bleedout_ent_usability_func)) {
      level thread[[level.disable_bleedout_ent_usability_func]](downedplayer);
    }
  }
}

function enable_bleedout_ent_usability(downedplayer) {
  if(isDefined(downedplayer.executeent)) {
    if(isDefined(level.enable_bleedout_ent_usability_func)) {
      level thread[[level.enable_bleedout_ent_usability_func]](downedplayer);
    }
  }
}

function revivent_watchfordeath_safety(reviveent, reviver) {
  reviveent endon("revive_fail");
  reviveent endon("revive_success");
  reviver endon("death_or_disconnect");
  reviveent waittill("death");
  reviver delaythread(1.5, &scripts\cp\utility::force_usability_enabled);
}

function get_revive_result(downed_player, reviver, pos, use_time) {
  use_ent = scripts\cp\utility::createuseent(pos);
  use_ent thread cleanuplaststandent(downed_player);
  result = revive_use_hold_think(downed_player, reviver, use_ent, use_time - 1500);
  return result;
}

function revive_use_hold_think(downed_player, reviver, use_ent, use_time) {
  if(isDefined(reviver.vo_prefix)) {
    if(isDefined(level.revive_use_hold_vo_func)) {
      level thread[[level.revive_use_hold_vo_func]](reviver, downed_player);
    }
  }

  reviver scripts\cp\utility::function_1dbc717085326045(undefined, 0, undefined);
  downed_player scripts\cp\utility::function_1dbc717085326045(undefined, 0, undefined);
  enter_revive_use_hold_think(downed_player, reviver, use_ent, use_time);
  set_revive_icon_color(downed_player.reviveent, (0.0117, 0.9882, 0.9882), 1);
  play_revive_gesture(reviver, downed_player);
  reviver.validtakeweapon = reviver scripts\cp\utility::getvalidtakeweapon();
  thread wait_for_exit_revive_use_hold_think(downed_player, reviver, use_ent, reviver.validtakeweapon);
  downed_player.reviver = reviver;
  current_progress = 0;
  result = 0;
  enable_on_world_progress_bar_for_other_players(downed_player, reviver);

  if(isPlayer(reviver)) {
    downed_player notify("reviving");
  }

  while(should_revive_continue(reviver)) {
    if(current_progress >= use_time) {
      result = 1;
      break;
    }

    progress_ratio = current_progress / use_time;
    update_players_revive_progress_bar(downed_player, reviver, progress_ratio);
    current_progress += 50;
    waitframe();
  }

  disable_on_world_progress_bar_for_other_players(downed_player, reviver);
  reviver delaythread(1, &force_remove_stim);

  if(istrue(result)) {
    use_ent notify("use_hold_think_success");
  } else {
    use_ent notify("use_hold_think_fail");
  }

  use_ent waittill("exit_use_hold_think_complete");
  return result;
}

function enter_revive_use_hold_think(downed_player, reviver, use_ent, use_time) {
  reviver scripts\cp\utility::function_1dbc717085326045(5, 0);
  downed_player scripts\cp\utility::function_1dbc717085326045(6, 0, reviver getentitynumber());
  lock_player_stance(reviver);
  downed_player.being_revived = 1;

  if(isPlayer(reviver)) {
    reviver val::set("reviver_disables", "equipment_primary", 0);
    reviver val::set("reviver_disables", "equipment_secondary", 0);
  }

  reviver.isreviving = 1;
}

function play_revive_gesture(reviver, downed_player) {
  if(isDefined(level.nuclear_core_carrier)) {
    if(level.nuclear_core_carrier == reviver) {
      return;
    }
  }

  reviver allowmelee(0);
  reviver disableweaponswitch();
  reviver notify("offhand_end");
}

function wait_for_exit_revive_use_hold_think(downed_player, reviver, use_ent, var_4c26c9e7f53f3037) {
  result = waittill_any_ents_return(use_ent, "use_hold_think_success", use_ent, "use_hold_think_fail", downed_player, "disconnect", downed_player, "revive_success", downed_player, "force_bleed_out", reviver, "challenge_complete", downed_player, "death");

  if(downed_player scripts\cp_mp\utility\player_utility::_isalive()) {
    downed_player.being_revived = 0;
    downed_player unlink();
    downed_player delaythread(1, &set_cam);
    downed_player scripts\cp\utility::function_1dbc717085326045(0, 0, -1);
  }

  reviver.isreviving = 0;

  if(isPlayer(reviver)) {
    reviver stop_revive_gesture(reviver, reviver.validtakeweapon);
    reviver unlink();
    reviver set_cam();
    reviver scripts\cp\utility::function_1dbc717085326045(0, 0, -1);
    reviver allowstand(1);
    reviver allowcrouch(1);
    reviver allowprone(1);
    reviver.anim_scene_stance_override = undefined;
    reviver val::set("reviver_disables", "equipment_primary", 1);
    reviver val::set("reviver_disables", "equipment_secondary", 1);
    reviver unlink();
    reviver notify("stop_revive");
  }

  use_ent notify("exit_use_hold_think_complete");
}

function enable_on_world_progress_bar_for_other_players(downed_player, reviver) {
  index = add_to_players_being_revived(downed_player);
  omnvar = "zm_revive_bar_" + index + "_target";

  foreach(player in level.players) {
    if(player == downed_player || player == reviver) {
      continue;
    }

    player setclientomnvar(omnvar, downed_player);
  }
}

function should_revive_continue(reviver) {
  canrevive = !level.gameended && reviver scripts\cp_mp\utility\player_utility::_isalive() && reviver useButtonPressed() && !player_in_laststand(reviver);

  if(isDefined(reviver.can_revive) && reviver.can_revive == 0) {
    return 0;
  }

  return canrevive;
}

function update_players_revive_progress_bar(downed_player, reviver, progress_ratio) {
  foreach(player in level.players) {
    if(player == downed_player || player == reviver) {
      player scripts\cp\utility::function_1dbc717085326045(undefined, progress_ratio, undefined);
      continue;
    }

    player setclientomnvar("zm_revive_bar_" + downed_player.revive_progress_bar_id + "_progress", progress_ratio);
  }
}

function disable_on_world_progress_bar_for_other_players(downed_player, reviver) {
  omnvar = "zm_revive_bar_" + downed_player.revive_progress_bar_id + "_target";
  remove_from_players_being_revived(downed_player);

  foreach(player in level.players) {
    if(player == downed_player || player == reviver) {
      continue;
    }

    player setclientomnvar(omnvar, undefined);
  }
}

function add_to_players_being_revived(downed_player) {
  for(i = 0; i < 2; i++) {
    if(!isDefined(level.players_being_revived[i])) {
      level.players_being_revived[i] = downed_player;
      index = i + 1;
      downed_player.revive_progress_bar_id = index;
      return index;
    }
  }

  assertmsg("<dev string:x3ea>");
}

function remove_from_players_being_revived(downed_player) {
  for(i = 0; i < 2; i++) {
    if(isDefined(level.players_being_revived[i]) && level.players_being_revived[i] == downed_player) {
      level.players_being_revived[i] = undefined;
      downed_player.revive_progress_bar_id = undefined;
      return;
    }
  }

  assertmsg("<dev string:x424>");
}

function force_remove_stim() {
  if(isDefined(self.revive_stim)) {
    self.revive_stim delete();
    self notify("remove_stim");
  }

  self cameradefault();

  if(istrue(self.relic_third_person)) {
    self setcamerathirdperson(1);
    return;
  }

  self setcamerathirdperson(0);
}

function lock_player_stance(player) {
  current_stance = player getstance();

  switch (current_stance) {
    case #"hash_c6775c88e38f7803":
      player allowstand(1);
      player allowcrouch(0);
      player allowprone(0);
      return;
    case #"hash_3fed0cbd303639eb":
      player allowstand(0);
      player allowcrouch(1);
      player allowprone(0);
      return;
    case #"hash_d91940431ed7c605":
      player allowstand(0);
      player allowcrouch(0);
      player allowprone(1);
      return;
  }
}

function downed_reviver_watch_for_return_to_usability(reviveent, reviver) {
  level endon("game_ended");
  reviver endon("disconnect");
  waittill_any_ents(reviver, "revive", reviveent, "death");

  if(isDefined(reviveent) && isalive(reviver)) {
    reviveent enableplayeruse(reviver);
  }
}

function laststandmoveawayfromvehicles(downedplayer, revivetime) {
  self endon("death");
  level endon("game_ended");
  var_340c9ed716c44138 = 600;
  var_3b266f496ea9e0e9 = var_340c9ed716c44138 * var_340c9ed716c44138;
  curtime = 0;
  var_abab6bc73fccef65 = -3;
  oldpos = downedplayer.origin;

  while(curtime < revivetime) {
    if(curtime >= var_abab6bc73fccef65 + 3) {
      mapvehicles = vehicle_getarray();

      foreach(vehicle in mapvehicles) {
        if(distancesquared(downedplayer.origin, vehicle.origin) < var_3b266f496ea9e0e9) {
          var_b9e9097150d1298c = length2d(downedplayer.origin - oldpos);

          if(var_b9e9097150d1298c > 500 && var_b9e9097150d1298c < 5000) {
            downedplayer scripts\cp\utility::moveplayerperpendicularly(1200);
            var_abab6bc73fccef65 = curtime;
          }
        }
      }
    }

    curtime += 2;
    wait 2;
  }
}

function is_being_revived(player) {
  return istrue(player.being_revived);
}

function player_is_trying_self_revive(player) {
  return istrue(player.using_self_revive);
}

function add_to_revive_icon_entity_list(var_17eb95d4b724d96) {
  assertex(!array_contains(level.revive_icon_entities, var_17eb95d4b724d96), "<dev string:x47d>");
  level.revive_icon_entities[level.revive_icon_entities.size] = var_17eb95d4b724d96;
}

function stop_revive_gesture(reviver, var_4c26c9e7f53f3037) {
  if(isDefined(level.nuclear_core_carrier)) {
    if(level.nuclear_core_carrier == reviver) {
      return;
    }
  }

  reviver enableweaponswitch();
  reviver allowmelee(1);
}

function enable_dogtag_revive(downedplayer) {
  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(downedplayer.dogtag)) {
    return;
  }

  var_bbdcc7365dd1c6ba = downedplayer.origin;

  if(istrue(level.var_920cba4b7b32d2a9)) {
    var_bbdcc7365dd1c6ba = drop_to_ground(var_bbdcc7365dd1c6ba, 64);
  }

  if(istrue(level.var_57640b5729015657)) {
    var_bbdcc7365dd1c6ba = getclosestpointonnavmesh(var_bbdcc7365dd1c6ba);
  }

  if(scripts\cp\cp_outofbounds::isoob(downedplayer, 0)) {
    assertex(isDefined(downedplayer.var_80f9d0aeaa47cc0c));
    var_bbdcc7365dd1c6ba = downedplayer.var_80f9d0aeaa47cc0c.origin;
    thread scripts\cp\cp_outofbounds::clearoob(downedplayer, 1);
  }

  if(isDefined(level.var_b6cd3626c14c131e)) {
    foreach(struct in level.var_b6cd3626c14c131e) {
      if(downedplayer scripts\cp\utility::function_496139dd736902cc(struct)) {
        var_bbdcc7365dd1c6ba = getStruct(struct.target, "targetname").origin;
        break;
      }
    }
  }

  if(downedplayer isswimming()) {
    dogtag = spawn("script_model", var_bbdcc7365dd1c6ba);
  } else {
    dogtag = spawn("script_model", var_bbdcc7365dd1c6ba + (0, 0, 40));
  }

  dogtag function_c919afebf9fe06c4(downedplayer);
  downedplayer.respawn_forcespawnorigin = var_bbdcc7365dd1c6ba + (0, 0, 5);
  downedplayer.respawn_forcespawnangles = (0, 0, 0);
  downedplayer.dogtag = dogtag;
  downedplayer.dogtag.owner = downedplayer;
  dogtag.owner = downedplayer;
  downedplayer.var_f13b2c408fe7ba46 = downedplayer scripts\cp_mp\equipment::getequipmentslotammo("health");
  entity_num = downedplayer getentitynumber();
  dog_tags_entity_num = dogtag getentitynumber();
  scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "ui_dog_tags_entity_num", dog_tags_entity_num);

  if(!istrue(downedplayer.var_a14c34f117daf30a)) {
    function_449348b412e6b21(downedplayer, dogtag, (0.929, 0.231, 0.141));
  }

  if(scripts\cp\utility::function_a3577e8e6c88a56b() || scripts\cp\utility::is_raid_gamemode()) {
    dogtag hudoutlineenable("outline_nodepth_white");
  }

  dogtag thread revivetriggerthink(downedplayer.team);
  dogtag thread endreviveonownerdeathordisconnect();
  dogtag thread function_5c02bca10d532c9b(downedplayer);

  if(scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
    dogtag thread function_af3bd2e64377cd03();
  }

  level notify("laststand_dogtag_spawned", dogtag);
}

function function_449348b412e6b21(player, target_ent, starting_color, bleedouttime) {
  if(getdvarint(@ "hash_155dcc14c52dacf8", 1)) {
    return;
  }

  if(!isDefined(starting_color)) {
    starting_color = (0.929, 0.231, 0.141);
  }

  reviveiconent = makereviveiconentity(player, target_ent);
  makereviveicon(reviveiconent, player, starting_color, bleedouttime);
  return reviveiconent;
}

function function_5c02bca10d532c9b(downedplayer) {
  minimapid = undefined;
  minimapid = scripts\cp\cp_objectives::requestworldid("dogtag_mimimap", 10);
  objective_state(minimapid, "active");
  objective_icon(minimapid, "hud_icon_minimap_misc_dog_tag");
  objective_setminimapiconsize(minimapid, "icon_small");
  objective_setshowdistance(minimapid, 1);
  objective_setplayintro(minimapid, 0);
  objective_onentity(minimapid, self);
  objective_setownerteam(minimapid, "allies");
  self waittill("death");
  objective_delete(minimapid);
  scripts\cp\cp_objectives::freeworldidbyobjid(minimapid);
}

function function_153f83a298faf9c6(player_origin) {
  level endon("game_ended");
  possible_lines = ["dx_bc_aqsc_firm_aqs1_gotone", "dx_bc_aqsc_firm_aqs2_gotone", "dx_bc_aqsc_firm_aqs3_gotone", "dx_bc_aqsc_firm_aqs4_gotone", "dx_bc_aqsc_firm_aqs5_gotone", "dx_bc_aqsc_firm_aqs1_ikilledone", "dx_bc_aqsc_firm_aqs2_ikilledone", "dx_bc_aqsc_firm_aqs3_ikilledone", "dx_bc_aqsc_firm_aqs4_ikilledone", "dx_bc_aqsc_firm_aqs5_ikilledone", "dx_bc_aqsc_firm_aqs1_ishotone", "dx_bc_aqsc_firm_aqs2_ishotone", "dx_bc_aqsc_firm_aqs3_ishotone", "dx_bc_aqsc_firm_aqs4_ishotone", "dx_bc_aqsc_firm_aqs5_ishotone", "dx_bc_aqsc_firm_aqs1_theyredead", "dx_bc_aqsc_firm_aqs2_theyredead", "dx_bc_aqsc_firm_aqs3_theyredead", "dx_bc_aqsc_firm_aqs4_theyredead", "dx_bc_aqsc_firm_aqs5_theyredead", "dx_bc_aqsc_firm_aqs1_ikilledthemthatpig", "dx_bc_aqsc_firm_aqs2_ikilledthemthatpig", "dx_bc_aqsc_firm_aqs3_ikilledthemthatpig", "dx_bc_aqsc_firm_aqs4_ikilledthemthatpig", "dx_bc_aqsc_firm_aqs5_ikilledthemthatpig", "dx_bc_aqsc_firm_aqs1_ishotthatone", "dx_bc_aqsc_firm_aqs2_ishotthatone", "dx_bc_aqsc_firm_aqs3_ishotthatone", "dx_bc_aqsc_firm_aqs4_ishotthatone", "dx_bc_aqsc_firm_aqs5_ishotthatone"];
  var_d067afd6db440176 = 512;
  closest_ai = getclosest(player_origin, getaiarray(), var_d067afd6db440176);

  if(isDefined(closest_ai) && function_6eeef4a78f8955e7(closest_ai)) {
    closest_ai playSound(random(possible_lines));
  }
}

function function_6eeef4a78f8955e7(ai) {
  if(!isDefined(ai) || !isDefined(ai.aitype)) {
    return 0;
  }

  var_947cac6df8a8c6b2 = strtok(ai.aitype, "_");
  return array_contains(var_947cac6df8a8c6b2, "aq");
}

function function_c919afebf9fe06c4(downedplayer) {
  self setModel("military_dogtags_iw9_blue");
  self makeusable();
  self function_dfb78b3e724ad620(1);
  self setHintString(&"MP/LASTSTAND_REVIVE_USE");
  self setCursorHint("HINT_NOICON");
  self setusehideprogressbar(1);
  self setuseholdduration("duration_none");
  self setusepriority(-1 - 1 - 1);
  self scriptmodelplayanim("mp_dogtag_spin");
  self.trigger = spawnStruct();
  self.trigger.owner = downedplayer;
  self.id = "laststand_reviver";
  self.trigger.id = "laststand_reviver";
  self.trigger.targetname = "revive_trigger";
  self endon("death");
}

function function_459987fa892efb71() {
  return istrue(level.var_df73b19d71e8bc58);
}

function function_7bf7ba0ec7ff7057() {
  flag_set("revive_tokens_disabled");
}

function function_51e2f809587f38ac() {
  flag_clear("revive_tokens_disabled");
}

function function_2767aaacd3dfc97a() {
  level endon("game_ended");

  if(flag_exist("hardmode_revive_tokens_setup_complete")) {
    flag_init("hardmode_revive_tokens_setup_complete");
  }

  if(!function_10a17aa507f07bd8()) {
    return;
  }

  function_51e2f809587f38ac();
  level.var_f63478bca59e2670 = getdvarint(@ "hash_aae8e9a472853241", 3);

  if(!isDefined(level.var_a80e6d45222f9a47)) {
    level.var_a80e6d45222f9a47 = level.var_f63478bca59e2670;
  }

  flag_wait("objectives_registered");

  while(level.activequests.size == 0) {
    wait 0.05;
  }

  wait 0.05;
  scripts\cp\cp_gameskill::function_3898e5f82c5c37df(0);
  flag_set("hardmode_revive_tokens_setup_complete");
}

function function_79ddac0ef09b8d0f(var_ee13026b48e61129, var_440fa28f4fe729dd) {
  level endon("game_ended");
  level.var_f63478bca59e2670 = getdvarint(@ "hash_aae8e9a472853241", 3);
  level.var_a80e6d45222f9a47 = level.var_f63478bca59e2670;

  if(isDefined(var_ee13026b48e61129)) {
    assertex(var_ee13026b48e61129.size >= 3, "called reset_revive_tokens with new_spawn_points size of less than 3");

    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];

      if(!isDefined(player.respawn_index)) {
        function_1c22cbc2d69134c3();
      }

      level.player_respawn[i] = var_ee13026b48e61129[i];
    }
  }

  wait_for_notify = undefined;

  foreach(player in level.players) {
    if(!isalive(player) || player isspectatingplayer() || istrue(player.inlaststand)) {
      if(player scripts\cp\laststand::getbeingrevivedinternal()) {
        wait_for_notify = "player_revived_while_resetting_revives_done";
        thread function_2c44cc8cedd35d79(player);
        continue;
      }

      thread function_3be088a84d31a495(player);
    }
  }

  if(isDefined(wait_for_notify)) {
    level waittill(wait_for_notify);
  } else {
    waitframe();
  }

  level.var_f63478bca59e2670 = getdvarint(@ "hash_aae8e9a472853241", 3);
  level.var_a80e6d45222f9a47 = level.var_f63478bca59e2670;
  scripts\cp\cp_gameskill::function_3898e5f82c5c37df(istrue(var_440fa28f4fe729dd));
}

function function_2c44cc8cedd35d79(player) {
  level endon("game_ended");
  result = player waittill_any_return_2("revive_success", "last_stand_bleedout");

  if(result == "revive_success") {
    level.var_f63478bca59e2670 = getdvarint(@ "hash_aae8e9a472853241", 3);
    level.var_a80e6d45222f9a47 = level.var_f63478bca59e2670;
  }

  level notify("player_revived_while_resetting_revives_done");
}

function function_3be088a84d31a495(player) {
  level endon("game_ended");
  player endon("disconnect");
  function_7956d96af822a9a3(player);

  while(!isalive(player) || player isspectatingplayer() || istrue(player.inlaststand)) {
    waitframe();
  }

  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0);
  wait 1;
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 1.1);
  player setOrigin(level.player_respawn[player.respawn_index].origin, 1, 1);
  player setplayerangles(level.player_respawn[player.respawn_index].angles);
}

function function_1c22cbc2d69134c3() {
  for(i = 0; i < level.players.size; i++) {
    level.players[i].respawn_index = i;
  }
}

function function_10a17aa507f07bd8() {
  if(flag("revive_tokens_disabled")) {
    return false;
  }

  return true;
}

function function_5ad98c689425d831() {
  if(!scripts\cp\cp_gameskill::function_f8448fd91abb54c8() || scripts\cp\cp_gameskill::function_e22f3955ab0d2e8d()) {
    return;
  }

  level.var_a80e6d45222f9a47 = int(level.var_a80e6d45222f9a47);
  scripts\cp\laststand::function_9597c3281050a3d8();
}

function function_9d24182b90507aa9() {
  if(!scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
    return false;
  }

  if(!isDefined(level.var_a80e6d45222f9a47)) {
    return true;
  }

  if(level.var_a80e6d45222f9a47 <= 0) {
    return true;
  }

  return false;
}

function function_bafdb6475a34d95b(timeout) {
  self endon("disconnect");
  wait timeout;
  self clearhudtutorialmessage();
}

function function_b18e576ebe57115e() {
  if(!scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
    return;
  }

  if(!function_10a17aa507f07bd8()) {
    return;
  }

  if(istrue(self.var_d308e15ba4e0c84)) {
    return;
  }

  self.var_d308e15ba4e0c84 = 1;
  thread function_cf26e1b56ae7980b();
}

function function_cf26e1b56ae7980b() {
  self endon("disconnect");
  wait 2;
  self setclientomnvar("ui_limited_revives_active", 2);

  if(level.var_f63478bca59e2670 > 0) {
    var_2f614fb812a9fe19 = (level.var_a80e6d45222f9a47 + 1) / level.var_f63478bca59e2670;
  } else {
    var_2f614fb812a9fe19 = 0;
  }

  self setclientomnvar("ui_revives_left", var_2f614fb812a9fe19);
}

function function_9597c3281050a3d8(var_c7cac0d22b84daee) {
  if(!scripts\cp\cp_gameskill::function_f8448fd91abb54c8()) {
    return;
  }

  if(!function_10a17aa507f07bd8()) {
    return;
  }

  if(!isDefined(var_c7cac0d22b84daee)) {
    var_c7cac0d22b84daee = 1;
  }

  var_ef1efb2663d51f22 = level.var_a80e6d45222f9a47 / level.var_f63478bca59e2670;
  level.var_a80e6d45222f9a47 -= var_c7cac0d22b84daee;
  level.var_a80e6d45222f9a47 = max(0, level.var_a80e6d45222f9a47);
  var_2f614fb812a9fe19 = level.var_a80e6d45222f9a47 / level.var_f63478bca59e2670;
  scripts\cp\cp_gameskill::function_3898e5f82c5c37df(0);
}

function function_719a703850a98e7a() {
  objstruct = spawnStruct();
  objstruct.var_24852c22989ccfc5 = &"COOP_GAME_PLAY/HARDMODE_REVIVES_LEFT";
  objstruct.var_b00949364009d589 = &"COOP_GAME_PLAY/HARDMODE_OXYMASK_LEFT";
  return objstruct;
}

function function_a245aa068aad0c25(slotindex) {
  if(!isDefined(slotindex)) {
    slotindex = 3;
  }

  if(slotindex < 1 || slotindex > 4) {
    return;
  }

  foreach(player in level.players) {
    player setclientdvar(hashcat(@ "cp_objective_sub_", slotindex, "_desc"), "");
  }
}

function function_4fe89278a6b193b2(revived) {
  if(istrue(revived)) {
    if(!function_240f7f4e57340e8f() && scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4()) {
      if(!self isnightvisionon()) {
        self nightvisionviewon(1);
      }
    }
  }
}

function checkpoint_revive() {
  level endon("game_ended");

  for(checkpoint = 1; true; checkpoint++) {
    level waittill("checkpoint_revive");
    respawn_points = getStructArray("player_checkpoint_" + checkpoint, "targetname");

    foreach(i, player in level.players) {
      if(player_in_laststand(player)) {
        player.respawn_forcespawnorigin = respawn_points[i].origin;
        player.respawn_forcespawnangles = respawn_points[i].angles;
        player instant_revive(player);

        if(isDefined(player.dogtag)) {
          player.dogtag delete();
        }
      }
    }
  }
}