/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\laststand.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using script_448ef4d9e70ce5e;
#using scripts\anim\utility;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\laststand;
#using scripts\cp_mp\quickprompt;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\juggernaut;
#using scripts\mp\laststand;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\perks\perkfunctions;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\supers;
#using scripts\mp\supers\super_stimpistol;
#using scripts\mp\teamrevive;
#using scripts\mp\tweakables;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\weapons;
#namespace laststand;

function init() {
  val::group_register("laststand", ["usability", "vehicle_use", "crate_use", "ascender_use", "weapon_switch", "supers", "gesture", "killstreaks", "offhand_primary_weapons", "offhand_secondary_weapons", "melee", "show_operator_pet"]);
  val::group_register("laststand_killstreak", ["usability", "weapon_switch", "gesture", "killstreaks", "supers", "fire", "melee", "offhand_primary_weapons", "offhand_secondary_weapons"]);
  val::group_register("laststand_revive", ["allow_movement", "usability", "reload", "fire", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "gesture", "allow_jump", "sprint", "melee"]);
  level.laststandreviveents = [];

  if(isusingmatchrulesdata()) {} else {
    registerlaststandhealthdvar(50);
    registerlaststandrevivehealthdvar(30);
    registerlaststandtimerdvar(10);
    registerlaststandinvulntimerdvar(1);
    registerlaststandsuicidetimerdvar(5);
    registerlaststandrevivetimerdvar(5);
    registerlaststandweapondvar("iw9_me_fists_mp_ls");
    registerlaststandrevivedecayscaledvar(0.5);
    registerlaststandweapondelaydvar(0);
  }

  level.laststandhealth = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_lastStandHealth"), @ "scr_player_laststandhealth");
  level.laststandrevivehealth = getoverridedvarintexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_lastStandReviveHealth"), @ "hash_555967257cd98a4a");

  if(level.laststandhealth > scripts\mp\tweakables::gettweakablevalue("player", "maxhealth")) {
    level.laststandhealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");
  }

  if(level.laststandrevivehealth > scripts\mp\tweakables::gettweakablevalue("player", "maxhealth")) {
    level.laststandrevivehealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");
  }

  level.laststandinvulntime = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_lastStandInvulnTime"), @ "scr_player_laststandinvulntime");
  level.laststandrevivedecayscale = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_lastStandReviveDecayScale"), @ "hash_e0f04861824e8440");
  level.laststandrevivetimer = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_lastStandReviveTimer"), @ "hash_e89b9c15abbfb1ad");
  level.laststandsuicidetimer = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_lastStandSuicideTimer"), @ "hash_812e42c73d4bd8d0");
  level.laststandtimer = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_lastStandTimer"), @ "hash_546d8a10bb4e83de");
  level.laststandweapon = getoverridedvarexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_lastStandWeapon"), @ "hash_ab99ad42c8f9d6fd");
  level.laststandweapondelay = getoverridedvarfloatexceptmatchrulesvalues(hashcat(@ "scr_", getgametype(), "_lastStandWeaponDelay"), @ "hash_c47411f597dae120");
  level.var_d69a2eb29ce33499 = getdvarfloat(@ "hash_65df50b82f004ca0", 5) * 1000;
  level.survivorrevivetime = getdvarfloat(@ "hash_46315da2e5f5a9c2", 3) * 1000;
  level.var_d88255cd662eb5c = getdvarint(@ "hash_f477e59410bec785", 0);
  setdvarifuninitialized(@ "hash_c959af6f995bf79a", 0);
  setdvarifuninitialized(@ "hash_ccfb1fe297ce6f9b", 0.3);
  level thread laststandmonitor();
  callback::add("player_spawned", &on_player_spawned);
  game["dialog"]["interrogation_start"] = "ntrr_grav_dtnc";
  game["dialog"]["interrogation_success"] = "ntrr_grav_dtcm";
  game["dialog"]["interrogatted_start"] = "ntrr_grav_slnw";
  game["dialog"]["interrogatted_success"] = "ntrr_grav_tmcm";

  level thread function_9168ee31efcf3393();
  level thread function_e7884f1619dc53be();
  level thread function_cb1f25df9191cd3c();
  level thread function_5b2d5cabc8a36244();

  level.interrogationenabled = getdvarint(@ "hash_1e86798724d1115d", 0);
  level.var_ccf76d87061de768 = getdvarfloat(@ "hash_9f647aa84d08a764", 3);
  level.var_84f71f417b53242e = getdvarfloat(@ "hash_19d24c665a9c49e", 3);
  level.var_21bc3423c7e17c34 = getdvarfloat(@ "hash_5ba57f036e2705b3", 0.5);
  level.var_9baf4b1b4d19e7f8 = getdvarfloat(@ "hash_476d39e42e96c7a9", 3);
  level.var_44245002f5ec8e6f = getdvarfloat(@ "hash_855542c7206bd0f4", 10);
  level.var_3908273e5522e91d = getdvarint(@ "hash_e1c418951c15bb84", 7);
  level.var_575cb25b5d41b53 = getdvarint(@ "hash_d2e2ca228dde9024", 276);
  level.var_a9978096255cd8ed = getdvarint(@ "hash_5eaf1d7bc20c4f36", 1);
  level.var_201395ee05e5c10d = getdvarfloat(@ "hash_4d703affbbcd1603", 0.1);
}

function on_player_spawned(params) {
  if(istrue(level.laststand)) {
    self endon("death");

    var_6e61bd34ad8a9b50 = 16;

    if(istrue(level.laststand) && !istrue(self.var_feed9d52c801b05d)) {
      level.var_e7a744d072517368 = default_to(level.var_e7a744d072517368, 0);

      if(level.var_e7a744d072517368 < var_6e61bd34ad8a9b50) {
        self.var_feed9d52c801b05d = 1;
        var_3352bf952cfc182a = self.name;
        function_6e7290c8ee4f558b("<dev string:x1c>");
        function_b23a59dfb4ca49a1(var_3352bf952cfc182a, "<dev string:x35>" + var_3352bf952cfc182a + "<dev string:x45>" + self getentitynumber(), &function_c7fdbd03f0cc2398);
        function_fe953f000498048f();
        function_6e7290c8ee4f558b("<dev string:x4a>");
        function_b23a59dfb4ca49a1(var_3352bf952cfc182a, "<dev string:x65>" + var_3352bf952cfc182a + "<dev string:x45>" + self getentitynumber(), &function_6acfa89023b79437);
        function_fe953f000498048f();
        function_6e7290c8ee4f558b("<dev string:x77>");
        function_b23a59dfb4ca49a1(var_3352bf952cfc182a, "<dev string:x97>" + var_3352bf952cfc182a + "<dev string:x45>" + self getentitynumber(), &function_2fd31e84d4bfc226);
        function_fe953f000498048f();
        function_6e7290c8ee4f558b("<dev string:xae>");
        function_b23a59dfb4ca49a1(var_3352bf952cfc182a, "<dev string:xd3>" + var_3352bf952cfc182a + "<dev string:x45>" + self getentitynumber(), &function_3ade7c3fe243f058);
        function_fe953f000498048f();
        level.var_e7a744d072517368++;
      }
    }

  }
}

function laststandthink() {
  level endon("game_ended");
  onenter();
  result = waittill_any_return_no_endon_death_6("last_stand_heal_success", "last_stand_revived", "last_stand_bleedout", "death_or_disconnect", "last_stand_self_revive", "enter_live_ragdoll");

  switch (result) {
    case #"hash_d95fe2980633f282":
      onrevive();
      break;
    case #"hash_a7951892dd77e7b":
      onrevive(1);
      break;
    case #"hash_7720db6a74f74d2b":
      onbleedout();
      break;
    case #"hash_3ea67ab430b19bc5":
      onrevive(0, 1);
      break;
    case #"hash_acbcd2ee2d01c7c4":
      break;
    case #"hash_cbbbbafae54d0dd6":
      if(!(isteamreviveenabled() && scripts\mp\flags::gameflag("prematch_done"))) {
        ondeath();
      }

      break;
  }

  if(isDefined(self)) {
    self setclientomnvar("ui_is_laststand", 0);
  }
}

function onenter() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  self notify("last_stand_start");
  self setclientomnvar("ui_is_laststand", 1);

  if(issharedfuncdefined("sound", "trySayLocalSound")) {
    level thread[[getsharedfunc("sound", "trySayLocalSound")]](self, #"bc_status_player_last_stand", undefined, 0.25);
  }

  healthvalue = level.laststandhealth;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    thread last_stand_sfx();
  }

  if(!isusingmatchrulesdata()) {
    healthvalue = getwatcheddvar("<dev string:xef>");

    if(!isDefined(healthvalue)) {
      healthvalue = getdvarint(@ "scr_player_laststandhealth", 50);
    }

    if(healthvalue > scripts\mp\tweakables::gettweakablevalue("<dev string:x102>", "<dev string:x10c>")) {
      healthvalue = scripts\mp\tweakables::gettweakablevalue("<dev string:x102>", "<dev string:x10c>");
    }
  }

  if(function_311066dfee085643(self)) {
    healthvalue = level.var_409e54f81172d6d8.laststandhealth;
  }

  self.health = healthvalue;
  thread makelaststandinvuln();
  giveperk("specialty_block_health_regen");
  self.var_2fb534abd9eb93ca = 0;
  self.inlaststand = 1;
  self.playergoingintols = undefined;
  self.hasshownlaststandicon = 0;
  self.laststandstarttime = gettime();
  self.laststandoldweaponobj = getlastweapon();

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    val::set("last_stand", "weapon_switch_clip", 0);

    if(!istrue(self.gulag)) {
      foreach(teammate in level.teamdata[self.team]["alivePlayers"]) {
        if(!isDefined(teammate)) {
          continue;
        }

        if(teammate != self) {
          teammate thread scripts\mp\hud_message::showsplash("br_teammate_down", undefined, self);
        }
      }
    }
  }

  if(getdvarint(@ "hash_7bb41608649743f4", 0) != 0) {
    self canceloffhands();
  } else if(getdvarint(@ "hash_112f10fcbe78647", 0) != 0) {
    self releaseoffhand();
  }

  laststandweapon = level.laststandweapon;

  if(!isusingmatchrulesdata()) {
    laststandweapon = getwatcheddvar("<dev string:x119>");

    if(!isDefined(laststandweapon)) {
      laststandweapon = getDvar(@ "hash_ab99ad42c8f9d6fd", "<dev string:x12c>");
    }
  }

  if(function_311066dfee085643(self)) {
    laststandweapon = self[[level.var_409e54f81172d6d8.laststandweaponcallback]]();
  } else if(isDefined(level.var_8b2457623e1802dc)) {
    laststandweapon = self[[level.var_8b2457623e1802dc]]();
  }

  if(!isweapon(laststandweapon)) {
    laststandweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845(laststandweapon);
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
    utility::waittill_any_timeout_2(3, "vehicle_exit", "vehicle_seat_exit");
  }

  val::group_set(self.laststandactionset, 0);
  thread handlelaststandweapongivepipeline(laststandweapon);

  if(isDefined(level.addlaststandoverheadiconcallback)) {
    self[[level.addlaststandoverheadiconcallback]]();
  } else {
    addoverheadicon();
  }

  var_276b87b88716c2a5 = level.laststandsuicidetimer;

  if(!isusingmatchrulesdata()) {
    var_276b87b88716c2a5 = getwatcheddvar("<dev string:x142>");

    if(!isDefined(var_276b87b88716c2a5)) {
      var_276b87b88716c2a5 = getdvarfloat(@ "hash_a4353f59ee601382", 5);
    }
  }

  _shellshock("last_stand_mp", "damage", var_276b87b88716c2a5, 0);
  thread revivesetup(self);

  if(isDefined(level.var_172cc7874c623df2)) {
    [[level.var_172cc7874c623df2]](self);
  } else if(function_2a3c9a91bf1d3911()) {
    thread interrogationsetup(self);
  }

  if(istrue(self.isjuggernaut)) {
    scripts\mp\juggernaut::jugg_removejuggernaut();
  }

  self.fastcrouchspeedmod = getdvarfloat(@ "hash_1a0de898609317b4", 0);
  scripts\cp_mp\challenges::stopchallengetimer("alive_not_downed");

  if(isDefined(self.laststandattacker) && self.laststandattacker _hasperk("specialty_reduce_regen_delay_on_kill")) {
    self.laststandattacker scripts\mp\perks\perkfunctions::regendelayreduce_onkill();
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(isDefined(self.sessionuimemberindex) && (!isDefined(level.laststandoutlineenabled) || level.laststandoutlineenabled)) {
      outlinename = "outline_nodepth_brplayer" + self.sessionuimemberindex + 1;
      self.laststandoutlineid = scripts\mp\utility\outline::outlineenableforteam(self, self.team, outlinename, "laststand");
    }

    childthread dodamagewhiledown();
  } else {
    childthread stucktime(var_276b87b88716c2a5);
  }

  callback::callback("player_laststand");
}

function last_stand_sfx() {
  if(!istrue(self.deathsdoorsfx)) {
    self.deathsdoorsfx = 1;
    self stoplocalsound("deaths_door_out");
    self playlocalsound("deaths_door_in");
    scripts\common\damage_effects::function_501be800abf11f33(0.2, 1);
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
  _giveweapon(var_dec5f8278c01ccc3, undefined, undefined, 0);
  thread _switchtoweaponimmediate(var_dec5f8278c01ccc3);
  var_426ffb976d0a19db = 1.7;

  if(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.var_9fba02f6bbe6e6bd)) {
    var_426ffb976d0a19db = level.gamemodebundle.var_9fba02f6bbe6e6bd;
  }

  wait var_426ffb976d0a19db;
  self notify("last_stand_transition_done");
  _takeweapon(var_dec5f8278c01ccc3);
  laststandweapondelay = 0;

  if(!isweapon(laststandweapon) && (laststandweapon == "none" || laststandweapon == "iw9_me_fists_mp_ls")) {
    givedefaultlaststandweapon();
  } else {
    laststandweapondelay = level.laststandweapondelay;

    if(!isusingmatchrulesdata()) {
      laststandweapondelay = getwatcheddvar("<dev string:x15b>");

      if(!isDefined(laststandweapondelay)) {
        laststandweapondelay = getdvarint(@ "hash_c47411f597dae120", 0);
      }
    }

    if(laststandweapondelay > 0) {
      thread handlelaststandweapongivedelay(laststandweapondelay, laststandweapon);
    } else {
      givelaststandweapon(laststandweapon);
    }
  }

  wait laststandweapondelay;
  self.var_2fb534abd9eb93ca = 1;
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
    var_ae0da1578aece301 = "iw9_me_fists_mp_ls";
  }

  defaultlaststandweapon = makeweapon(var_ae0da1578aece301);
  _giveweapon(defaultlaststandweapon, undefined, undefined, 1);
  thread _switchtoweaponimmediate(defaultlaststandweapon);
  return defaultlaststandweapon;
}

function givelaststandweapon(laststandweapon) {
  if(!isweapon(laststandweapon)) {
    laststandweapon = scripts\cp_mp\weapon::buildweapon(laststandweapon);
  }

  fullname = getcompleteweaponname(laststandweapon);

  if(!self hasweapon(fullname)) {
    _giveweapon(laststandweapon, undefined, undefined, 1);
    self.laststandweaponobj = laststandweapon;
  }

  thread _switchtoweaponimmediate(fullname);
}

function disableweaponsovertime(t) {
  level endon("game_ended");
  val::set("disable_weapons_for_time", "weapon", 0);
  waittill_any_timeout_1(t, "death_or_disconnect");
  val::reset_all("disable_weapons_for_time");
}

function switchtofists(laststandweapon) {
  self endon("death_or_disconnect");
  self endon("end_switchToFists");

  while(domonitoredweaponswitch(laststandweapon, 1) == 0) {
    waitframe();
  }
}

function dodamagewhiledown() {
  self endon("laststand_revived");
  self endon("disconnect");
  self endon("squad_wipe_death");
  basehealth = level.laststandhealth;
  bleedouttime = level.laststandtimer;

  if(!isusingmatchrulesdata()) {
    basehealth = getwatcheddvar("<dev string:xef>");

    if(!isDefined(basehealth)) {
      basehealth = getdvarint(@ "scr_player_laststandhealth", 50);
    }

    if(basehealth > scripts\mp\tweakables::gettweakablevalue("<dev string:x102>", "<dev string:x10c>")) {
      basehealth = scripts\mp\tweakables::gettweakablevalue("<dev string:x102>", "<dev string:x10c>");
    }

    bleedouttime = getwatcheddvar("<dev string:x173>");

    if(!isDefined(bleedouttime)) {
      bleedouttime = getdvarfloat(@ "hash_546d8a10bb4e83de", 10);
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
  thread suicidesetup();
  damagedealt = 0;

  while(self.health > 0) {
    if(self isinexecutionvictim()) {
      wait 1;
      continue;
    }

    if(!istrue(getbeingrevivedinternal())) {
      var_703f141d7d6fea1e = int(damagedealt + var_76e563db5d11a0ea) - int(damagedealt);
      damagedealt += var_76e563db5d11a0ea;
      self.islaststandbleedoutdmg = 1;
      self dodamage(var_703f141d7d6fea1e, self.origin, self, undefined, "MOD_TRIGGER_HURT", laststanddamageweapon, "none");
      self.islaststandbleedoutdmg = undefined;
    }

    if(self.health <= 0) {
      onbleedout();
    }

    wait 1;
  }
}

function stucktime(var_276b87b88716c2a5) {
  self.stuckinlaststand = 1;
  wait var_276b87b88716c2a5;
  self.stuckinlaststand = 0;
  timeleft = level.laststandtimer;

  if(!isusingmatchrulesdata()) {
    timeleft = getwatcheddvar("<dev string:x173>");

    if(!isDefined(timeleft)) {
      timeleft = getdvarfloat(@ "hash_546d8a10bb4e83de", 10);
    }
  }

  if(function_311066dfee085643(self)) {
    timeleft = level.var_409e54f81172d6d8.var_1694969c43add70d;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    assertex(timeleft > 0, "<dev string:x185>");
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() && timeleft != 0) {
    timeleft = max(timeleft - level.laststandsuicidetimer, 1);
  } else {
    timeleft = 0;
  }

  self.timeuntilbleedout = timeleft;

  if(isDefined(level.var_b57e01a4f8558a6b)) {
    self thread[[level.var_b57e01a4f8558a6b]]();
    return;
  }

  thread bleedoutthink();
  thread suicidesetup();
}

function selfrevivebuttonPressed(downedplayer) {
  if(istrue(downedplayer.var_82300c21f62a6edb)) {
    return 1;
  }

  if(downedplayer usinggamepad()) {
    if(istrue(level.var_6b88c76ed51df733)) {
      return downedplayer useButtonPressed();
    } else {
      return downedplayer weaponswitchbuttonPressed();
    }

    return;
  }

  return downedplayer activatekeypressed();
}

function function_188085b8b8d431f2(self_revive_count) {
  self_revive_count = int(max(self_revive_count, 0));
  self.var_f6b9660bedb94681 = self_revive_count;
  self setclientomnvar("ui_self_revive_count", self.var_f6b9660bedb94681);

  if(self.var_f6b9660bedb94681 > 0) {
    allowselfrevive(1);
    return;
  }

  allowselfrevive(0);
}

function function_546201bb34cf36ce() {
  return default_to(self.var_f6b9660bedb94681, 0);
}

function function_7eba90a4d2ef6d6f(n_count, var_dedcc81d0707427d) {
  n_count = default_to(n_count, 1);
  var_dedcc81d0707427d = default_to(var_dedcc81d0707427d, 1);

  if(var_dedcc81d0707427d) {
    self.var_dddc97480e104865 += n_count;
    self.var_60a26e89bc2c7157 += n_count;
  }

  function_188085b8b8d431f2(function_546201bb34cf36ce() + n_count);
}

function function_d7827c7865b2089b(n_count, b_revived) {
  n_count = default_to(n_count, 1);
  b_revived = default_to(b_revived, 0);

  if(b_revived) {
    self.var_18445effcf1ebc1b = default_to(self.var_18445effcf1ebc1b, 0);
    self.var_18445effcf1ebc1b++;
  }

  function_188085b8b8d431f2(function_546201bb34cf36ce() - n_count);
}

function function_85bcfa7d00b8bb6b() {
  if(function_546201bb34cf36ce() < level.gametypebundle.var_4f29dbd56f01de57) {
    return true;
  }

  return false;
}

function selfrevivethink() {
  triggerent = self;
  downedplayer = triggerent.owner;
  level endon("game_ended");
  triggerent endon("death");
  downedplayer endon("death_or_disconnect");
  downedplayer endon("last_stand_revived");
  usetime = getwatcheddvar("lastStandReviveTimer") * 1000;

  if(downedplayer _hasperk("specialty_survivor") && isDefined(level.var_d69a2eb29ce33499)) {
    usetime = level.var_d69a2eb29ce33499;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && downedplayer _hasperk("specialty_br_faster_revive")) {
    usetime *= 0.75;
  }

  if(isDefined(level.var_cfbe6af2219da1dc)) {
    usetime = downedplayer[[level.var_cfbe6af2219da1dc]]();
  }

  triggerent.usetime = usetime;

  if(!isDefined(self.curprogress)) {
    self.curprogress = 0;
  }

  while(true) {
    if(selfrevivebuttonPressed(downedplayer) && !istrue(downedplayer.isselfreviving) && (downedplayer isonground() || downedplayer isswimming())) {
      triggerent notify("self_revive_start");
      downedplayer setlaststandselfreviving(1);

      if(scripts\cp_mp\utility\game_utility::isbrstylegametype() || istrue(level.var_6d63cbd43e47315e)) {
        downedplayer scripts\mp\gametypes\br_public::setplayerselfrevivingextrainfo(1);
      }

      triggerent thread selfrevivemonitorrevivebuttonPressed();
    }

    waitframe();
  }
}

function selfrevivemonitorrevivebuttonPressed() {
  downedplayer = self.owner;
  triggerent = self;
  level endon("game_ended");
  downedplayer endon("death_or_disconnect");
  downedplayer endon("last_stand_finished");
  triggerent.waitingforteammaterevive = 0;
  triggerent thread selfrevivebuttonpresscleanup();

  while(isreallyalive(downedplayer) && selfrevivebuttonPressed(downedplayer) && triggerent.curprogress < triggerent.usetime) {
    while(!downedplayer isonground() && !downedplayer isswimming() && selfrevivebuttonPressed(downedplayer)) {
      waitframe();
    }

    if(!selfrevivebuttonPressed(downedplayer)) {
      break;
    }

    if(downedplayer isinexecutionvictim()) {
      break;
    }

    if(function_2a3c9a91bf1d3911() && istrue(downedplayer.var_63aae9824b331052)) {
      downedplayer setbeingrevivedinternal(0);
      downedplayer function_51feaa413342a5a1();
      downedplayer scripts\mp\gameobjects::updateuiprogress(triggerent, 1);
      break;
    }

    if(istrue(downedplayer.beingrevived)) {
      break;
    }

    if(!istrue(downedplayer.isselfreviving)) {
      if(istrue(level.var_6b88c76ed51df733) && downedplayer usinggamepad()) {
        w_current = downedplayer getcurrentweapon();
        var_865364ec5b259eae = downedplayer getweaponammoclip(w_current) < w_current.clipsize && downedplayer getweaponammostock(w_current) > 0;

        if(var_865364ec5b259eae && downedplayer.timeuntilbleedout > self.usetime * 2 / 1000) {
          break;
        }
      }

      if(downedplayer isgestureplaying("ges_equip_stim_self_revive")) {
        downedplayer stopgestureviewmodel("ges_equip_stim_self_revive", 0);
      }

      if(istrue(downedplayer.var_b24e609023ce8208)) {
        downedplayer.var_98d31d9ce04b2b81 = gettime();
        downedplayer thread scripts\anim\utility::function_b5216a6d7bd17210("iw8_ges_plyr_self_revive");

        if(!istrue(downedplayer.stimmodelattached)) {
          downedplayer attach("offhand_wm_stim", "tag_accessory_left");
          downedplayer.stimmodelattached = 1;
        }
      } else {
        downedplayer thread scripts\anim\utility::function_b5216a6d7bd17210("iw8_ges_plyr_self_revive");

        if(!istrue(downedplayer.stimmodelattached)) {
          downedplayer attach("offhand_wm_stim", "tag_accessory_left");
          downedplayer.stimmodelattached = 1;
        }
      }

      downedplayer.isselfreviving = 1;
      downedplayer val::set("laststand", "fire", 0);
      downedplayer val::set("laststand", "allow_movement", 0);
    }

    if(!isDefined(triggerent.userate)) {
      triggerent.userate = 0;
    }

    if(istrue(downedplayer.beingrevived)) {
      downedplayer scripts\mp\gameobjects::updateuiprogress(triggerent, 1);
      break;
    }

    if(!downedplayer isonground() && !downedplayer isswimming()) {
      break;
    }

    triggerent.curprogress += level.frameduration * triggerent.userate;
    triggerent.userate = 1;
    downedplayer scripts\mp\gameobjects::updateuiprogress(triggerent, 1);

    if(triggerent.curprogress >= triggerent.usetime) {
      downedplayer stopgestureviewmodel("ges_equip_stim_self_revive");
      waitframe();

      if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
        scripts\mp\gametypes\br_analytics::branalytics_selfrevive(downedplayer);
      }

      downedplayer finishreviveplayer("self_revive_success", downedplayer);

      if(istrue(downedplayer.var_b24e609023ce8208)) {
        downedplayer.var_b24e609023ce8208 = undefined;
        return;
      }

      if(isDefined(level.removeselfrevivetoken)) {
        downedplayer[[level.removeselfrevivetoken]](1, 1);
      }

      return;
    }

    waitframe();
  }

  if(!istrue(downedplayer.beingrevived)) {
    if(scripts\cp_mp\utility\game_utility::isbrstylegametype() || istrue(level.var_6d63cbd43e47315e)) {
      scripts\mp\gametypes\br::updatesquadmemberlaststandreviveprogress(downedplayer, downedplayer, triggerent.curprogress, 1);
    }

    triggerent thread decayreviveprogress();
  }

  downedplayer notify("stopped_self_revive");
}

function function_77799f0211be1728() {
  return istrue(self.var_c6a5ba98f5f43e0d);
}

function function_51feaa413342a5a1() {
  self.var_c6a5ba98f5f43e0d = 0;
  self stopgestureviewmodel("iw9_vm_ges_stimpistol_self_revive");
}

function selfrevivebuttonpresscleanup() {
  downedplayer = self.owner;
  triggerent = self;
  level endon("game_ended");
  downedplayer notify("self_revive_cleanup_start");
  downedplayer endon("self_revive_cleanup_start");
  downedplayer waittill_any_return_no_endon_death_3("last_stand_finished", "stopped_self_revive", "death_or_disconnect");

  if(!istrue(downedplayer.beingrevived)) {
    downedplayer scripts\mp\gameobjects::updateuiprogress(triggerent, 0);
  }

  if(istrue(downedplayer.stimmodelattached)) {
    downedplayer detach("offhand_wm_stim", "tag_accessory_left");
    downedplayer.stimmodelattached = 0;
  }

  downedplayer stopgestureviewmodel("ges_equip_stim_self_revive");
  downedplayer setlaststandselfreviving(0);

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() || istrue(level.var_6d63cbd43e47315e)) {
    downedplayer scripts\mp\gametypes\br_public::setplayerselfrevivingextrainfo(0);
  }

  downedplayer.isselfreviving = 0;
  downedplayer val::reset("laststand", "fire");
  downedplayer val::reset("laststand", "allow_movement");
}

function onexitcommon(revived) {
  self endon("disconnect");
  level endon("game_ended");
  self.laststandactionset = undefined;
  self.var_c6a5ba98f5f43e0d = undefined;
  thread clearlaststandinvuln();
  self.fastcrouchspeedmod = 0;
  scripts\mp\weapons::updatemovespeedscale();

  if(_hasperk("specialty_block_health_regen")) {
    removeperk("specialty_block_health_regen");
  }

  laststandweapon = level.laststandweapon;

  if(!isusingmatchrulesdata()) {
    laststandweapon = getwatcheddvar("<dev string:x119>");
  }

  laststandweapon = makeweapon(laststandweapon);

  if(!istrue(self.var_3c26ce251ed564ca)) {
    if(self getcurrentprimaryweapon() != laststandweapon) {
      self notify("end_switchToFists");
      abortmonitoredweaponswitch(laststandweapon);
    } else if(!isnullweapon(laststandweapon)) {
      _takeweapon(laststandweapon);
    }
  }

  self.var_3c26ce251ed564ca = undefined;
  self notify("last_stand_finished");
  self.laststandoldweapon = undefined;

  if(istrue(getbeingrevivedinternal())) {
    setbeingrevivedinternal(0);
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() || istrue(level.var_6d63cbd43e47315e)) {
    scripts\mp\gametypes\br::updatesquadmemberlaststandreviveprogress(self, self, 0, 1);
    scripts\mp\gametypes\br_public::setplayerbeingrevivedextrainfo(0);
    self.brdownedbyairstriketime = undefined;
  }

  setlowermessageomnvar("clear_lower_msg");

  if(isDefined(level.modeonexitlaststandfunc)) {
    self[[level.modeonexitlaststandfunc]](revived);
  }

  scripts\mp\laststand::cleaninterrogationonexit();
  waittillframeend();
  self.inlaststand = 0;

  if(isalive(self)) {
    scripts\common\damage_effects::onexitdeathsdoor(1);
  }
}

function onrevive(var_4920bf02df960be9, var_d07b7dcc79b24490) {
  oldweaponobj = self.laststandoldweaponobj;
  val::reset_all("laststand");
  val::group_reset(default_to(self.laststandactionset, "laststand"));
  onexitcommon(1);
  self laststandrevive();
  self playsoundtoteam("npc_breath_revive", self.team, self, self);
  self playlocalsound("plr_breath_revive");
  self notify("laststand_revived");
  laststandweapon = level.laststandweapon;

  if(!isusingmatchrulesdata()) {
    laststandweapon = getwatcheddvar("<dev string:x119>");

    if(!isDefined(laststandweapon)) {
      laststandweapon = getDvar(@ "hash_ab99ad42c8f9d6fd", "<dev string:x12c>");
    }
  }

  if(laststandweapon != "none") {
    thread domonitoredweaponswitch(oldweaponobj, 1);
  }

  if(isDefined(self.laststandweaponobj)) {
    _takeweapon(self.laststandweaponobj);
  }

  if(function_311066dfee085643(self)) {
    self.health = level.var_409e54f81172d6d8.laststandrevivehealth;
  } else if(!istrue(var_d07b7dcc79b24490)) {
    healthvalue = level.laststandrevivehealth;

    if(!isusingmatchrulesdata()) {
      healthvalue = getwatcheddvar("<dev string:x1b9>");

      if(!isDefined(healthvalue)) {
        healthvalue = getdvarint(@ "scr_player_laststandhealth", 50);
      }

      if(healthvalue > scripts\mp\tweakables::gettweakablevalue("<dev string:x102>", "<dev string:x10c>")) {
        healthvalue = scripts\mp\tweakables::gettweakablevalue("<dev string:x102>", "<dev string:x10c>");
      }
    }

    if(!getdvarint(@ "scr_player_laststandreviveretainhealth", 0) || self.health < level.laststandrevivehealth) {
      self.health = level.laststandrevivehealth;
    }
  } else {
    self.health = self.maxhealth;
  }

  if(game["state"] == "postgame") {
    assert(!level.intermission);
    scripts\mp\gamelogic::freezeplayerforroundend();
  }

  setbeingrevivedinternal(0);

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && !istrue(self.gulag)) {
    foreach(teammate in level.teamdata[self.team]["alivePlayers"]) {
      if(!isDefined(teammate)) {
        continue;
      }

      if(teammate != self) {
        teammate thread scripts\mp\hud_message::showsplash("br_teammate_revived", undefined, self);
      }
    }
  }

  _stopshellshock();

  if(istrue(var_4920bf02df960be9) && istrue(level.allowselfrevive)) {
    allowselfrevive(0);
  }

  if(function_7ba31cb6b21c346f() && !istrue(var_4920bf02df960be9) && !istrue(var_d07b7dcc79b24490)) {
    thread function_36edf91561322753(2);
  }

  params = spawnStruct();
  params.reviver = self.var_63b104851a574f2a;
  callback::callback("player_revived", params);
  self.var_63b104851a574f2a = undefined;
  self.laststandattacker = undefined;
  self.laststandmeansofdeath = undefined;
  self.laststandweaponobj = undefined;
  self.laststanddowneddata = undefined;
  self.laststandattackermodifiers = undefined;
}

function onbleedout() {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.laststandattacker) && _hasperk("specialty_survivor")) {
    survivorondeath(self.laststandattacker);
  }

  thread onexitcommon();
  dropcarryobject();

  if(isDefined(self.laststandattacker)) {
    self.laststandattacker thread scripts\mp\rank::scoreeventpopup(#"kill_confirmed");
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(!istrue(level.gameended)) {
      self.deathsdoorsfx = 0;
      scripts\common\damage_effects::function_a2b4e6088394bade();
      self playlocalsound("deaths_door_death");
      self enableplayerbreathsystem(1);
    }
  }

  callback::callback("player_bleedout");
  _suicide();
}

function ondeath(deathdata) {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.laststandattacker) && _hasperk("specialty_survivor")) {
    survivorondeath(self.laststandattacker);
  }

  if(istrue(self.isselfreviving)) {
    self notify("stopped_self_revive");
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(!istrue(level.gameended)) {
      self.deathsdoorsfx = 0;
      scripts\common\damage_effects::function_a2b4e6088394bade();
      self playlocalsound("deaths_door_death");
      self enableplayerbreathsystem(1);
    }
  }

  thread onexitcommon();
  dropcarryobject();

  if(isDefined(level.var_e41f5f1692ca213e)) {
    level thread[[level.var_e41f5f1692ca213e]]();
  }
}

function dropcarryobject() {
  if(isDefined(self.carryobject)) {
    self.carryobject thread scripts\mp\gameobjects::setdropped();
  }
}

function revivesetup(owner) {
  owner endon("death_or_disconnect");
  level endon("game_ended");
  owner waittill("last_stand_transition_done");
  reviveent = spawn("script_model", owner.origin);
  reviveent setModel("tag_origin");
  team = owner.team;
  reviveent linkTo(owner, "tag_origin", (0, 0, 6), (0, 0, 0));
  reviveent.owner = owner;
  reviveent.inuse = 0;
  reviveent.id = "laststand_reviver";
  reviveent.trigger = spawnStruct();
  reviveent.trigger.owner = owner;
  reviveent.trigger.id = "laststand_reviver";
  reviveent.trigger.targetname = "revive_trigger";
  reviveent makeusable();
  function_6b9549a69dc6a346(reviveent);
  reviveent thread function_4a3b25b6b877fe73(team);
  reviveent thread revivetriggerthink(team);
  reviveent thread endreviveonownerdeathordisconnect();

  if(getdvarint(@ "hash_7a493092f8a1c04c", 0) && getdvarint(@ "hash_ddd02929770fcc8c", 0) || function_311066dfee085643(self)) {
    owner thread secondwindthink();
  }

  owner.laststandreviveent = reviveent;
  owner.laststandreviveent.var_9d797a762d9195eb = 0;
  level.laststandreviveents[reviveent getentitynumber()] = reviveent;
  reviveent thread removereviveentfromlevelarrayondeath();
  owner.var_b24e609023ce8208 = scripts\mp\supers\super_stimpistol::function_a35fff2ff233592a();

  if(owner function_546201bb34cf36ce() > 0 || owner namespace_53fc9ddbb516e6e1::hasselfrevivetokensharedfunc() || istrue(owner.var_b24e609023ce8208) || owner _hasperk("specialty_survivor")) {
    owner.laststandreviveent selfrevivethink();
  }
}

function function_6b9549a69dc6a346(reviveent) {
  assert(isDefined(reviveent));

  if(isDefined(reviveent.owner) && getdvarint(@ "mgl", 0)) {
    reviveent setCursorHint("HINT_BUTTON");
    reviveent sethinticon("hud_icon_cyber_revive");
    reviveent sethintdisplayrange(96);
    reviveent setuserange(96);
  } else {
    reviveent setCursorHint("HINT_NOICON");
  }

  reviveent setusehideprogressbar(1);
  reviveent setuseholdduration("duration_none");
  reviveent setHintString(&"MP/LASTSTAND_REVIVE_USE");
  reviveent setusepriority(-1 - 1 - 1);
  reviveent sethintdisplayfov(90);
  reviveent setusefov(90);

  if(function_2a3c9a91bf1d3911() && !isDefined(reviveent.headiconon) && !isDefined(reviveent.headiconoff)) {
    reviveent.headiconon = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], "hud_icon_interrogation", 16, 0, 800, 100, undefined, 1, 1);
    reviveent.headiconoff = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], "hud_icon_interrogation_active", 16, 0, 800, 100, undefined, 1, 1);
    setheadiconteam(reviveent.headiconon, reviveent.trigger.owner.team);
  }
}

function interrogationsetup(owner) {
  owner endon("death_or_disconnect");
  level endon("game_ended");
  owner waittill("last_stand_transition_done");
  interrogationent = spawn("script_model", owner.origin);
  interrogationent setModel("tag_origin");
  team = owner.team;
  interrogationent linkTo(owner, "tag_origin", (0, 0, 6), (0, 0, 0));
  interrogationent.owner = owner;
  interrogationent.inuse = 0;
  interrogationent.id = "laststand_interrogator";
  interrogationent.trigger = spawnStruct();
  interrogationent.trigger.owner = owner;
  interrogationent.trigger.id = "laststand_interrogation";
  interrogationent.trigger.targetname = "interrogation_trigger";
  interrogationent makeusable();

  if(getdvarint(@ "mgl", 0)) {
    interrogationent setCursorHint("HINT_BUTTON");
    interrogationent sethinticon("hud_icon_cyber_revive");
    interrogationent sethintdisplayrange(192);
    interrogationent setuserange(192);
  } else {
    interrogationent setCursorHint("HINT_NOICON");
  }

  interrogationent setusehideprogressbar(1);
  interrogationent setuseholdduration("duration_none");
  interrogationent setHintString(&"MP/LASTSTAND_INTERROGATE_USE");
  interrogationent setusepriority(-1 - 1);
  interrogationent thread function_dc8861a5e3b418d5(team);
  interrogationent thread function_56e47961499ca06c(team);
  interrogationent thread endreviveonownerdeathordisconnect();
}

function secondwindthink() {
  downedplayer = self;
  downedplayer endon("death_or_disconnect");
  downedplayer endon("last_stand_finished");
  level endon("game_ended");
  starttimems = gettime();
  downedplayer waittill("killed_enemy_in_last_stand", evictim, einflictor, objweapon, meansofdeath, weaponname, laststandmeansofdeath, laststandweaponname, attackermismatch, bsuicide);

  while(true) {
    if(attackermismatch && !function_311066dfee085643(downedplayer)) {
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

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    scripts\mp\gametypes\br_analytics::branalytics_secondwind(downedplayer, var_36cd2fa9e32592d7, evictim, meansofdeath, weaponname, laststandmeansofdeath, laststandweaponname, var_1450075a920a7dd5, var_c9d5089e35e3ff9e, bbledout, var_6b0df23a41285117);
    downedplayer thread scripts\mp\hud_message::showsplash("br_second_wind");
  }

  downedplayer finishreviveplayer("self_revive_on_kill_success", downedplayer);
  playersonteam = scripts\mp\utility\teams::getteamdata(downedplayer.team, "players");

  foreach(player in playersonteam) {
    if(player != downedplayer && isalive(player)) {
      player thread scripts\mp\hud_message::showsplash("br_teammate_second_wind", undefined, downedplayer);
    }
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

function endreviveonownerdeathordisconnect() {
  self endon("death");
  self.owner waittill_any_4("death_or_disconnect", "last_stand_finished", "last_stand_heal_active", "interrogation_finished");

  if(isDefined(self.objidnum)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objidnum);
    self.objidnum = undefined;
  }

  self delete();
}

function removereviveentfromlevelarrayondeath() {
  level endon("game_ended");
  entnum = self getentitynumber();
  self waittill("death");
  level.laststandreviveents[entnum] = undefined;
}

function updateusablebyteam(team) {
  if(isDefined(level.var_6007f92acc049c02)) {
    [[level.var_6007f92acc049c02]](team);
  }

  foreach(player in level.players) {
    if(istrue(level.var_a32cddb0c46cead7) && scripts\cp_mp\utility\squad_utility::issquadmode()) {
      if(squad_utility::function_9b1d18c04d310cfc(self.owner, player) && player != self.owner) {
        self enableplayeruse(player);
      } else {
        self disableplayeruse(player);
      }

      continue;
    }

    if((istrue(level.var_d9a236c9a5ac921e) || team == player.team) && player != self.owner) {
      self enableplayeruse(player);
      continue;
    }

    self disableplayeruse(player);
  }
}

function function_38f5ade989b3848f(team) {
  assert(function_2a3c9a91bf1d3911());
  closeplayers = getplayersinradius(self.origin, level.var_575cb25b5d41b53);

  foreach(player in closeplayers) {
    if(team != player.team && player != self.owner) {
      self enableplayeruse(player);
      continue;
    }

    self disableplayeruse(player);
  }
}

function function_4a3b25b6b877fe73(team) {
  self endon("death");
  self.owner endon("last_stand_finished");

  while(true) {
    updateusablebyteam(team);
    level waittill("joined_team");
  }
}

function function_dc8861a5e3b418d5(team) {
  self endon("death");
  self.owner endon("last_stand_finished");

  while(true) {
    function_38f5ade989b3848f(team);
    level waittill("joined_team");
  }
}

function revivetriggerthink(team) {
  self.owner endon("last_stand_finished");
  self.owner endon("last_stand_heal_active");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", reviver);

    if(!istrue(level.var_d9a236c9a5ac921e) && reviver.team != team) {
      continue;
    }

    if(function_2a3c9a91bf1d3911()) {
      if(istrue(self.owner.var_895c1aaac16f7256) || istrue(reviver.var_93018d510a589832)) {
        continue;
      }
    }

    while(!reviver isonground() && !reviver isswimming() && reviver useButtonPressed()) {
      waitframe();
    }

    if(istrue(reviver.insertingarmorplate)) {
      reviver notify("try_armor_cancel", "last_stand_reviver_start");

      while(istrue(reviver.insertingarmorplate) && reviver useButtonPressed()) {
        waitframe();
      }
    }

    if(!reviver useButtonPressed() && !istrue(reviver.var_82300c21f62a6edb)) {
      continue;
    }

    self.owner setbeingrevivedinternal(1);
    revived = 0;
    self.owner notify("handle_revive_message");
    self makeunusable();

    if(reviver usingtouch()) {
      reviver function_fc1c1e51058904a3(&"MP/LASTSTAND_REVIVE_USE");
    }

    self.owner allowmovement(0);
    reviver setlaststandreviving(1);
    reviver scripts\cp_mp\laststand::function_d9bd056c79a6077b(self.owner);
    thread useholdthink(reviver);
    reviver thread switchtoteammatereviveweapon(self.owner);

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype() || istrue(level.var_6d63cbd43e47315e)) {
      self.owner scripts\mp\gametypes\br_public::setplayerbeingrevivedextrainfo(1);
    }

    notif = waittill_any_return_no_endon_death_3("use_hold_revive_success", "use_hold_revive_fail", "death_or_disconnect");

    if(reviver usingtouch()) {
      reviver forceusehintoff();
    }

    if(notif == "use_hold_revive_success") {
      revived = 1;
    }

    reviver notify("finish_buddy_reviving");
    self.owner setbeingrevivedinternal(0);
    revived = self.owner finishreviveplayer(notif, reviver);

    if(revived) {
      return;
    }

    thread decayreviveprogress();
    self makeusable();
    function_6b9549a69dc6a346(self);
    updateusablebyteam(team);
  }
}

function function_56e47961499ca06c(team) {
  self.owner endon("last_stand_finished");
  self.owner endon("disconnect");
  level endon("game_ended");
  interrogatee = self.owner;

  for(;;) {
    self waittill("trigger", interrogator);

    if(interrogator.team == team) {
      continue;
    }

    interrogator iprintlnbold("Interrogating...");
    interrogatee iprintlnbold("You are being interrogated...");
    scripts\mp\gametypes\br_public::brleaderdialogteam("interrogation_start", interrogator.team);
    scripts\mp\gametypes\br_public::brleaderdialogteam("interrogatted_start", interrogatee.team);

    while(!interrogator isonground() && !interrogator isswimming() && interrogator useButtonPressed()) {
      waitframe();
    }

    if(istrue(interrogator.insertingarmorplate)) {
      interrogator notify("try_armor_cancel", "interrogation_interrogator_start");

      while(istrue(interrogator.insertingarmorplate) && interrogator useButtonPressed()) {
        waitframe();
      }
    }

    if(!interrogator useButtonPressed()) {
      continue;
    }

    revived = 0;
    self makeunusable();

    if(interrogator usingtouch()) {
      interrogator function_fc1c1e51058904a3(&"MP/LASTSTAND_INTERROGATE_USE");
    }

    interrogatee allowmovement(0);
    interrogator.var_93018d510a589832 = 1;
    thread useholdthink(interrogator, undefined, 1);
    interrogator thread switchtoteammatereviveweapon(interrogatee, 1);
    notif = waittill_any_return_no_endon_death_3("use_hold_interrogate_success", "use_hold_interrogate_fail", "death_or_disconnect");

    if(interrogator usingtouch()) {
      interrogator forceusehintoff();
    }

    if(notif == "use_hold_interrogate_success") {
      interrogated = 1;
    }

    interrogator notify("finish_victim_interrogation");
    interrogatee setbeingrevivedinternal(0);
    interrogated = interrogatee function_70f1dbc7125939b8(notif, interrogator, team);

    if(istrue(interrogated)) {
      return;
    }

    thread decayreviveprogress();
    self makeusable();

    if(getdvarint(@ "mgl", 0)) {
      self setCursorHint("HINT_BUTTON");
      self sethinticon("hud_icon_cyber_revive");
      self sethintdisplayrange(192);
      self sethintdisplayfov(120);
      self setuserange(192);
      self setusefov(360);
    } else {
      self setCursorHint("HINT_NOICON");
    }

    function_38f5ade989b3848f(team);
  }
}

function switchtoteammatereviveweapon(revivee, interrogation) {
  reviver = self;
  reviver endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(interrogation)) {
    interrogation = 0;
  }

  if(!istrue(reviver isswimming())) {
    if(istrue(reviver.waitingtoplayreviveanimation)) {
      return;
    }

    if(istrue(interrogation)) {
      weaponobj = makeweapon("interrogation_tools_mp");
    } else {
      weaponobj = makeweapon("teammate_revive_stim_mp");
    }

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
  }

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

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && (self.currentweapon.basename == "teammate_revive_stim_mp" || self.currentweapon.basename == "interrogation_tools_mp")) {
    waitframe();
  }

  waitframe();
  reviver.blockreviveanimation = 0;
}

function teammatereviveweaponwaitputaway(streakinfo) {
  reviver = self;
  level endon("game_ended");

  if(!istrue(reviver.revivingteammate) && !istrue(reviver.var_93018d510a589832)) {
    return;
  }

  reviver waittill_any_return_no_endon_death_3("death_or_disconnect", "finish_buddy_reviving", "finish_victim_interrogation");
}

function watchfordeathwhilereviving() {
  reviver = self;
  reviver endon("finish_buddy_reviving");
  reviver endon("finish_victim_interrogation");
  reviver endon("disconnect");
  level endon("game_ended");
  reviver waittill("death");
  reviver enableweaponswitch();
}

function watchforteammatedeathwhilereviving(revivee) {
  reviver = self;
  reviver endon("finish_buddy_reviving");
  reviver endon("finish_victim_interrogation");
  reviver endon("death_or_disconnect");
  level endon("game_ended");
  revivee waittill("death_or_disconnect");
  reviver notify("finish_buddy_reviving");
}

function watchforteammaterevivedwhilereviving(revivee) {
  reviver = self;
  reviver endon("finish_buddy_reviving");
  reviver endon("finish_victim_interrogation");
  reviver endon("death_or_disconnect");
  level endon("game_ended");
  revivee waittill("last_stand_revived");
  reviver notify("finish_buddy_reviving");
}

function finishreviveplayer(notifymsg, reviver) {
  revivee = self;
  revived = 0;

  if(!isDefined(revivee) || !isalive(revivee)) {
    return 0;
  }

  self.fastcrouchspeedmod = 0;
  scripts\mp\weapons::updatemovespeedscale();

  if(notifymsg == "use_hold_revive_success" || notifymsg == "self_revive_on_kill_success" || notifymsg == "self_revive_success") {
    revived = 1;
  }

  revivee.beingrevived = 0;
  revivee.isselfreviving = 0;

  if(notifymsg == "self_revive_success") {
    revivee selfrevivingdoneanimevent();
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() || istrue(level.var_6d63cbd43e47315e)) {
    revivee scripts\mp\gametypes\br_public::setplayerbeingrevivedextrainfo(0);
  }

  revivee allowmovement(1);

  if(revived) {
    revivee setlowermessageomnvar("clear_lower_msg");

    if(notifymsg == "self_revive_success") {
      revivee notify("last_stand_self_revive");
    } else {
      revivee notify("last_stand_revived");
    }

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype() || istrue(level.ob_pvpve)) {
      if(!istrue(level.gameended)) {
        revivee scripts\mp\gametypes\br_public::setplayerdownedextrainfo(0);
        scripts\mp\events::revivedplayer(reviver, revivee);
        onlaststandrevive(reviver, revivee);
        revivee startchallengetimer("alive_not_downed");

        if(reviver != revivee) {
          reviver scripts\mp\utility\stats::incpersstat("rescues", 1);
        }

        revivee.deathsdoorsfx = 0;
        revivee stoplocalsound("deaths_door_in");
        revivee playlocalsound("deaths_door_out");
        revivee scripts\common\damage_effects::function_a2b4e6088394bade();
        revivee playlocalsound(ter_op(isfemale(), "Fem_breathing_better", "breathing_better"));
        revivee enableplayerbreathsystem(1);

        if(istrue(revivee.var_b24e609023ce8208)) {
          revivee thread scripts\mp\supers\super_stimpistol::function_31afe9d7b373900f();
        }
      }

      if(!scripts\mp\gametypes\br_public::istutorial() && getdvarint(@ "hash_60fa486ada22dba2", 0) == 1) {
        revivee playsoundtoteam("br_player_revived", revivee.team, undefined, self);
      }

      if(reviver != revivee) {
        reviver playlocalsound("jup_revive_teammate_success");
      }

      if(isDefined(self.laststandoutlineid)) {
        scripts\mp\utility\outline::outlinedisable(self.laststandoutlineid, self);
        self.laststandoutlineid = undefined;
      }
    }

    revivee thread function_a3a340a5d9222a17();
    revivee.var_63b104851a574f2a = reviver;
  }

  revivee takelaststandtransitionweapon();
  return revived;
}

function private function_a3a340a5d9222a17() {
  self endon("death_or_disconnect");
  waitframe();
  var_9dd68ebdd6e786a9 = isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.var_9132b898f78c9d19) && istrue(level.gamemodebundle.var_9132b898f78c9d19 != "NONE");

  if(!var_9dd68ebdd6e786a9) {
    var_ccbc8f28cb6a19e7 = self setstance("crouch");

    if(!var_ccbc8f28cb6a19e7) {
      self setstance("prone");
    }

    return;
  }

  switch (level.gamemodebundle.var_9132b898f78c9d19) {
    case #"hash_b5d4f2ac1b263b63":
      self setstance("stand");
      break;
    case #"hash_a8f9e4a698fa0eeb":
      self setstance("crouch");
      break;
    case #"hash_e85597ec7477d565":
      self setstance("prone");
      break;
    default:
      break;
  }
}

function function_70f1dbc7125939b8(notifymsg, interrogator, team) {
  interrogatee = self;
  interrogated = 0;

  if(!isDefined(interrogatee) || !isalive(interrogatee)) {
    return 0;
  }

  self.fastcrouchspeedmod = 0;
  scripts\mp\weapons::updatemovespeedscale();

  if(notifymsg == "use_hold_interrogate_success") {
    interrogated = 1;
  }

  interrogatee.var_895c1aaac16f7256 = 0;
  interrogatee allowmovement(1);

  if(interrogated) {
    interrogatee setlowermessageomnvar("clear_lower_msg");
    interrogatee notify("last_stand_interrogated");

    if(isDefined(self.laststandoutlineid)) {
      scripts\mp\utility\outline::outlinedisable(self.laststandoutlineid, self);
      self.laststandoutlineid = undefined;
    }

    interrogator interrogationreward(interrogatee);
  }

  return interrogated;
}

function decayreviveprogress() {
  self.owner endon("last_stand_finished");
  self.owner endon("last_stand_heal_active");
  self endon("use_hold_revive_start");
  self endon("use_hold_interrogate_start");
  self endon("self_revive_start");
  level endon("game_ended");
  decayscale = level.laststandrevivedecayscale;

  if(!isusingmatchrulesdata()) {
    decayscale = getwatcheddvar("<dev string:x1d2>");

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

function interrogationreward(victim) {
  interrogator = self;
  var_26568fed2b866c11 = level.teamdata[victim.team]["players"];

  foreach(player in var_26568fed2b866c11) {
    if(player scripts\mp\utility\perk::_hasperk("specialty_snapshot_immunity")) {
      interrogator scripts\cp_mp\damagefeedback::updatedamagefeedback("hittacresist");
      return;
    }

    player function_ab6a75b53de148ab(interrogator, level.var_762fc98bdfe1cb1d);
    triggerportableradarpingteam(player.origin, interrogator.team, level.var_575cb25b5d41b53, 500);
  }

  scripts\mp\gametypes\br_public::brleaderdialogteam("interrogation_success", interrogator.team);
  scripts\mp\gametypes\br_public::brleaderdialogteam("interrogatted_finish", victim.team);
}

function function_ab6a75b53de148ab(interrogator, outlinetime) {
  victim = self;

  if(isPlayer(victim)) {
    if(isDefined(outlinetime)) {
      outlinetime = outlinetime;
    } else {
      outlinetime = 2.5;
    }

    victim.painted = 1;

    if(!level.teambased) {
      id = scripts\mp\utility\outline::outlineenableforplayer(victim, interrogator, "outlinefill_nodepth_orange", "equipment");
    } else if(scripts\cp_mp\utility\squad_utility::shouldmodesetsquads()) {
      id = scripts\mp\utility\outline::outlineenableforsquad(victim, interrogator.team, interrogator.sessionsquadid, "outlinefill_nodepth_orange", "equipment");
    } else {
      id = scripts\mp\utility\outline::outlineenableforteam(victim, interrogator.team, "outlinefill_nodepth_orange", "equipment");
    }

    victim thread watchpainted(id, outlinetime);
    victim thread watchpaintedagain(id);

    foreach(equipment in array_removeundefined(victim.plantedlethalequip)) {
      if(!level.teambased) {
        equipmentid = scripts\mp\utility\outline::outlineenableforplayer(equipment, interrogator, "outlinefill_nodepth_orange", "equipment");
      } else if(scripts\cp_mp\utility\squad_utility::shouldmodesetsquads()) {
        equipmentid = scripts\mp\utility\outline::outlineenableforsquad(equipment, interrogator.team, interrogator.sessionsquadid, "outlinefill_nodepth_orange", "equipment");
      } else {
        equipmentid = scripts\mp\utility\outline::outlineenableforteam(equipment, interrogator.team, "outlinefill_nodepth_orange", "equipment");
      }

      equipment thread watchpainted(equipmentid, outlinetime + 5);
      equipment thread watchpaintedagain(equipmentid);
    }
  }
}

function watchpainted(id, timeout) {
  self notify("painted_again");
  self endon("painted_again");
  self endon("disconnect");
  level endon("game_ended");
  waittill_any_timeout_1(timeout, "death");
  self.painted = 0;
  scripts\mp\utility\outline::outlinedisable(id, self);
  self notify("painted_end");
}

function watchpaintedagain(id) {
  self endon("disconnect");
  level endon("game_ended");
  waittill_any_2("painted_again", "painted_end");
  scripts\mp\utility\outline::outlinedisable(id, self);
}

function useholdthink(reviver, usetime, interrogation) {
  self.owner endon("last_stand_finished");
  reviver endon("death");
  level endon("game_ended");

  if(!isDefined(interrogation)) {
    interrogation = 0;
  }

  revivee = self.owner;
  var_6a1154c8bc126a40 = getdvarint(@ "hash_c959af6f995bf79a");
  revivespot = spawn("script_origin", self.origin);
  revivespot hide();

  if(!var_6a1154c8bc126a40) {
    reviver val::group_set("laststand_revive", 0);
  }

  if(istrue(interrogation)) {
    self notify("use_hold_interrogate_start");
  } else {
    self notify("use_hold_revive_start");
  }

  if(!istrue(interrogation)) {
    reviver thread sfx_revive_lp();
  }

  if(var_6a1154c8bc126a40) {
    dragallyprototype(reviver, revivee);
  }

  if(!isDefined(self.curprogress) || isDefined(self.var_d50d5a16df84df44)) {
    self.curprogress = 0;
  }

  self.var_d50d5a16df84df44 = undefined;
  self.inuse = 1;
  self.userate = 0;
  baserevivetime = 0;

  if(isDefined(usetime)) {
    self.usetime = usetime;
  } else if(reviver _hasperk("specialty_medic")) {
    self.usetime = getwatcheddvar("lastStandReviveTimer") * 1000 * getdvarfloat(@ "hash_6f08a22fd52e004c");
  } else if(istrue(interrogation)) {
    self.usetime = getdvarfloat(@ "hash_ddbf6f11fc2231f2", 3) * 1000;
  } else {
    self.usetime = getwatcheddvar("lastStandReviveTimer") * 1000;
  }

  if(revivee _hasperk("specialty_survivor") && isDefined(level.survivorrevivetime)) {
    self.usetime = level.survivorrevivetime;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && reviver _hasperk("specialty_br_faster_revive")) {
    self.usetime *= 0.75;
  }

  if(!istrue(interrogation)) {
    if(issharedfuncdefined("sound", "trySayLocalSound")) {
      level thread[[getsharedfunc("sound", "trySayLocalSound")]](reviver, #"bc_status_action_reviving");
    }
  }

  thread useholdthinkcleanup(reviver, revivespot, interrogation);
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

function useholdthinkcleanup(reviver, revivespot, interrogation) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(interrogation)) {
    interrogation = 0;
  }

  var_6a1154c8bc126a40 = getdvarint(@ "hash_c959af6f995bf79a");
  revivee = self.owner;
  notif = revivee waittill_any_return_no_endon_death_4("death_or_disconnect", "use_hold_think_success", "use_hold_think_fail", "last_stand_finished");
  self.inuse = 0;
  revivespot delete();

  if(isDefined(reviver)) {
    reviver buddyrevivingdoneanimevent();
    reviver setlaststandreviving(0);

    if(istrue(interrogation)) {
      reviver.var_93018d510a589832 = 0;

      if(isDefined(revivee)) {
        revivee.var_895c1aaac16f7256 = 0;
      }
    } else {
      reviver scripts\cp_mp\laststand::function_42d99e200aa9762a(revivee);
    }

    reviver scripts\mp\gameobjects::updateuiprogress(self, 0);

    if(reviver usingtouch()) {
      reviver forceusehintoff();
    }
  }

  if(isDefined(revivee)) {
    revivee scripts\mp\gameobjects::updateuiprogress(self, 0);
  }

  if(isreallyalive(reviver)) {
    if(var_6a1154c8bc126a40) {
      cleanupdragallyprototype(reviver, revivee);
    } else {
      reviver val::group_reset("laststand_revive");
    }
  }

  reviver notify("sfx_revive_done");

  if(notif == "use_hold_think_success") {
    if(istrue(interrogation)) {
      reviver thread doscoreeventsharedfunc("interrogation");
    } else {
      reviver thread doscoreeventsharedfunc("reviver");

      if(istrue(level.var_e2758489154dafea)) {
        revivee thread scripts\mp\rank::scoreeventpopup(#"reviver");
      }
    }

    if(istrue(level.allowselfrevive)) {
      reviver allowselfrevive(1);
    }

    var_ee08b1f41e7c2444 = scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73();

    if(!var_ee08b1f41e7c2444) {
      if(!istrue(interrogation)) {
        revivee thread scripts\mp\rank::scoreeventpopup(#"revived");
      }
    }

    if(!istrue(level.var_290b75900d1fff6)) {
      if(istrue(interrogation)) {
        revivee thread scripts\mp\hud_message::showsplash("execution", undefined, reviver);
      } else {
        revivee thread scripts\mp\hud_message::showsplash("revived", undefined, reviver);
      }
    }

    revivee.inlaststand = 0;

    if(istrue(interrogation)) {
      self.var_d50d5a16df84df44 = 1;
      self notify("use_hold_interrogate_success");
      return;
    }

    self notify("use_hold_revive_success");
    return;
  } else if(notif == "use_hold_think_fail") {
    revivee notify("handle_revive_message");
  }

  if(istrue(interrogation)) {
    self notify("use_hold_interrogate_fail");
    return;
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

  while(isreallyalive(reviver) && !reviver isviewmodelanimplaying() && (reviver useButtonPressed() || istrue(reviver.var_82300c21f62a6edb)) && self.curprogress < self.usetime && (!isDefined(reviver.inlaststand) || !reviver.inlaststand) && (istrue(reviver.var_82300c21f62a6edb) || distancesquared(reviver.origin, self.origin) <= 65536)) {
    if(istrue(reviver.tacopsmedicrole)) {
      return isreallyalive(reviver);
    }

    self.curprogress += level.frameduration * self.userate;
    self.userate = 1;
    var_5eaefb910dd56f31 = self.curprogress / self.usetime;

    if(istrue(level.var_520545ce455767b6)) {
      revivee.health = int(clamp(revivee.maxhealth * var_5eaefb910dd56f31, 2, revivee.maxhealth));
    }

    reviver scripts\mp\gameobjects::updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      revivee notify("use_hold_think_success");
      return;
    }

    waitframe();
  }

  if(isDefined(self.objidnum)) {
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  }

  revivee notify("use_hold_think_fail");
}

function suicidesetup() {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  level endon("game_ended");

  if(!isDefined(level.var_b57e01a4f8558a6b)) {
    thread showsuicidehintstring();
  }

  var_7831c27971ffde60 = getdvarint(@ "hash_45dbdc45bdf8f5ff", 0);
  var_3cbcaf4eda0f3704 = getdvarfloat(@ "hash_f36ad71f9fadec59", 300);

  level.var_ccf76d87061de768 = getdvarfloat(@ "hash_9f647aa84d08a764", 3);

  if(!isbot(self)) {
    thread suicidemonitorcrouchbuttonpress();
  }

  holdtime = 0;

  if(function_2a3c9a91bf1d3911()) {
    var_58d906af2cac1064 = level.var_ccf76d87061de768;
  } else {
    var_58d906af2cac1064 = level.var_21bc3423c7e17c34;
  }

  while(true) {
    waitframe();

    if(self stancebuttonPressed() && self isinexecutionvictim() == 0 && !scripts\mp\utility\player::getbeingrevivedinternal()) {
      if(function_2a3c9a91bf1d3911()) {
        if(isDefined(self.laststandreviveent)) {
          if(istrue(self.laststandreviveent.var_9d797a762d9195eb)) {
            holdtime = 0;
            self setclientomnvar("ui_securing", 0);
            self setclientomnvar("ui_securing_progress", 0);
            scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/INTERROGATION_IN_PROGRESS");
            wait 0.5;
            continue;
          }
        }

        if(var_7831c27971ffde60) {
          players = getplayersinradius(self.origin, var_3cbcaf4eda0f3704);

          foreach(player in players) {
            if(player.team != self.team) {
              self iprintlnbold("There are enemies near by...");
              holdtime = 0;

              if(!selfrevivebuttonPressed(self) && !function_77799f0211be1728()) {
                self setclientomnvar("ui_securing", 0);
                self setclientomnvar("ui_securing_progress", 0);
              }

              wait 0.5;
              break;
            }
          }
        }
      }

      self setclientomnvar("ui_securing", 20);

      if(holdtime >= var_58d906af2cac1064) {
        self setclientomnvar("ui_securing", 0);
        self setclientomnvar("ui_securing_progress", 0);
        break;
      }

      progress_ratio = holdtime / var_58d906af2cac1064;
      self setclientomnvar("ui_securing_progress", progress_ratio);
      holdtime += level.framedurationseconds;
      continue;
    }

    holdtime = 0;

    if(!selfrevivebuttonPressed(self) && !istrue(self.beingrevived) && !function_77799f0211be1728()) {
      self setclientomnvar("ui_securing", 0);
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

  if(function_2a3c9a91bf1d3911()) {
    var_58d906af2cac1064 = level.var_ccf76d87061de768;
  } else {
    var_58d906af2cac1064 = level.var_21bc3423c7e17c34;
  }

  var_4ce97d438a53f1d5 = var_58d906af2cac1064 * 1000;
  endloop = 0;

  while(!endloop && !giveup) {
    giveup = 0;

    if(!starttimer) {
      holdtime = gettime();
    }

    ret = waittill_any_timeout_5(var_58d906af2cac1064, "stance_pressed_down", "stance_pressed_up", "last_stand_finished", "last_stand_self_revive", "last_stand_bleedout");

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
  if(istrue(self.allowselfrevive) && !istrue(level.var_8ef6408ea14287af)) {
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
    supername = scripts\mp\supers::getcurrentsuperref();

    if(isDefined(supername) && supername == "super_laststand_heal" && scripts\mp\supers::issuperready()) {
      var_649e600e12376e07 = 1;
    }

    if(istrue(getbeingrevivedinternal())) {
      setlowermessageomnvar("being_revived");
    } else if(istrue(self.laststandhealisactive)) {
      setlowermessageomnvar("reviving_self");
    } else if(isDefined(self.timeuntilbleedout)) {
      if(var_649e600e12376e07) {
        setlowermessageomnvar("self_revive", int(gettime() + self.timeuntilbleedout * 1000));
      } else if(getgametype() != "dm") {
        if(self.pers["lives"] == 0 && isteamreviveenabled()) {
          setlowermessageomnvar("spawn_revive_wait", int(gettime() + self.timeuntilbleedout * 1000));
        } else {
          setlowermessageomnvar("revive_or_respawn", int(gettime() + self.timeuntilbleedout * 1000));
        }
      } else {
        setlowermessageomnvar("ffa_down_give_up", int(gettime() + self.timeuntilbleedout * 1000));
      }
    } else if(var_649e600e12376e07) {
      setlowermessageomnvar("self_revive");
    } else if(self.pers["lives"] == 0 && isteamreviveenabled()) {
      setlowermessageomnvar("spawn_revive_wait");
    } else {
      setlowermessageomnvar("revive_or_respawn");
    }

    while(true) {
      notif = waittill_any_return_no_endon_death_2("super_ready", "handle_revive_message");

      if(notif == "super_ready" && scripts\mp\supers::getcurrentsuperref() != "super_laststand_heal") {
        continue;
      }

      break;
    }
  }
}

function bleedoutthink() {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  self endon("last_stand_heal_active");
  level endon("game_ended");
  timeleft = self.timeuntilbleedout;
  var_37470c2c6bf2dc4f = self.timeuntilbleedout;
  var_15a606bb932c1595 = 0;

  if(timeleft != 0) {
    while(true) {
      waitframe();

      if(self isinexecutionvictim()) {
        continue;
      }

      if(!getbeingrevivedinternal()) {
        if(var_15a606bb932c1595 > 0) {
          timeleft -= var_15a606bb932c1595;
          var_15a606bb932c1595 = 0;
        } else {
          timeleft -= level.framedurationseconds;
        }
      } else {
        var_15a606bb932c1595 += level.framedurationseconds;
      }

      params = spawnStruct();
      params.progress = timeleft / var_37470c2c6bf2dc4f;
      callback::callback("bleedout_tick", params);

      if(istrue(self.var_8192ba8fe8d68cf0) || timeleft <= level.framedurationseconds) {
        self.var_8192ba8fe8d68cf0 = undefined;
        self notify("last_stand_bleedout");
        break;
      }

      self.timeuntilbleedout = timeleft;
    }
  }
}

function addoverheadicon() {
  iconorg = self.origin;
  icon = newteamhudelem(self.team);
  icon.x = iconorg[0];
  icon.y = iconorg[1];
  icon.z = iconorg[2] + 32;
  icon.alpha = 1;
  icon.archived = 0;
  icon.showinkillcam = 0;

  if(level.splitscreen) {
    icon setshader("hud_realism_head_revive", 10, 10);
  } else {
    icon setshader("hud_realism_head_revive", 5, 5);
  }

  icon setwaypoint(0);
  icon settargetEnt(self);
  thread cleanupoverheadicon(icon);
}

function cleanupoverheadicon(icon) {
  self waittill("last_stand_finished");
  icon destroy();
}

function showwaverespawnmessage() {
  wavebased = getdvarint(hashcat(@ "scr_", getgametype(), "_waverespawndelay")) > 0;

  if(!wavebased) {
    return;
  }

  self endon("last_stand_finished");

  while(true) {
    self.respawntimerstarttime = gettime();
    wavebased = getdvarint(hashcat(@ "scr_", getgametype(), "_waverespawndelay")) > 0;

    if(wavebased) {
      timeuntilspawn = scripts\mp\playerlogic::timeuntilwavespawn(0);
      setlowermessageomnvar("next_team_spawn", int(gettime() + timeuntilspawn * 1000));
      wait timeuntilspawn;
      setlowermessageomnvar("clear_lower_msg");
    }

    wait 2;
  }
}

function allowselfrevive(allow) {
  self.allowselfrevive = allow;
  self setclientomnvar("ui_self_revive", allow);
  scripts\mp\gametypes\br_public::sethasselfrevivetokenextrainfo(allow);
}

function laststandmonitor() {
  level endon("game_ended");

  if(istrue(level.laststandkillteamifdowndisable)) {
    return;
  }

  while(true) {
    level waittill("last_stand_enter_finished");

    if(getgametypenumlives() == 0 && !istrue(level.disablespawning)) {
      continue;
    }

    wait 0.6;
    level thread laststandkillteamifdown();
  }
}

function laststandkillteamifdown() {
  foreach(entry in level.teamnamelist) {
    livesremaining = scripts\mp\utility\teams::getteamdata(entry, "livesCount");

    if(livesremaining != 0) {
      continue;
    }

    playersonteam = getfriendlyplayers(entry, 1);
    playersinlaststand = [];

    foreach(player in playersonteam) {
      if(istrue(player.inlaststand) && !istrue(function_311066dfee085643(player) && !istrue(player _hasperk("specialty_survivor")))) {
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

  if(!isusingmatchrulesdata()) {
    laststandinvulntimer = getwatcheddvar("<dev string:x1ef>");

    if(!isDefined(laststandinvulntimer)) {
      dvarstring = scripts\mp\utility\dvars::function_3514ae5d09f47ed2("<dev string:x206>");
      laststandinvulntimer = getdvarfloat(dvarstring, 1);
    }
  }

  clearlaststandinvuln();
  self endon("disconnect");
  self endon("clear_last_stand_invuln");
  scripts\cp_mp\utility\damage_utility::adddamagemodifier("last_stand_invuln", 0, 0, &laststandinvulnignorefunc);
  scripts\engine\utility::waittill_notify_or_timeout("death", laststandinvulntimer);
  thread clearlaststandinvuln();
}

function clearlaststandinvuln() {
  self notify("clear_last_stand_invuln");
  scripts\cp_mp\utility\damage_utility::removedamagemodifier("last_stand_invuln", 0);
}

function laststandinvulnignorefunc(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(meansofdeath == "MOD_TRIGGER_HURT") {
    return true;
  }

  return false;
}

function getdefaultlaststandtimervalue() {
  return 10;
}

function getdefaultlaststandrevivetimervalue() {
  return 5;
}

function getshellshockinterruptdelayms(duration) {
  return duration * 1000;
}

function function_27d0ea02ed3cc35f(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  forcelaststand = scripts\mp\damage::isforcedlaststand(self, einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc);

  if(!istrue(forcelaststand)) {
    if(istrue(self.inlaststand) || istrue(self.playergoingintols)) {
      return false;
    }

    if(namespace_bed52b18307bf1e0::function_afb40a34c99dc4e4(objweapon)) {
      return false;
    }

    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() && !istrue(self.killstreaklaststand) && smeansofdeath == "MOD_MELEE" && objweapon.basename != "iw9_me_fists_mp" && objweapon.basename != "iw9_me_fists_mp_ls") {
      if(!function_311066dfee085643(self, "melee")) {
        return false;
      }
    }

    if(smeansofdeath == "MOD_EXECUTION" || smeansofdeath == "MOD_MELEE_TAKEDOWN") {
      return false;
    }

    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() && isheadshot(shitloc, smeansofdeath, attacker)) {
      if(!function_311066dfee085643(self, "headshot")) {
        return false;
      }
    }

    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() && isexplosivedamagemod(smeansofdeath)) {
      if(!function_311066dfee085643(self, "explosive")) {
        return false;
      }
    }

    if(istrue(self.gulagarena)) {
      return false;
    }

    if(isDefined(attacker) && (isDefined(attacker.classname) && attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn")) {
      if(!function_311066dfee085643(self, "world")) {
        return false;
      }
    }

    if(is_equal(attacker, self) && !scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      return false;
    }

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && scripts\mp\utility\killstreak::isjuggernaut()) {
      return false;
    }

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && !scripts\mp\flags::gameflag("prematch_done")) {
      return false;
    }

    if(isDefined(level.modelaststandallowed) && !self[[level.modelaststandallowed]](einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration)) {
      return false;
    }
  }

  return true;
}

function survivorondeath(attacker) {
  score = level.scoremod["kill"];

  if(score != 0) {
    if(level.teambased) {
      level scripts\mp\gamescore::giveteamscoreforobjective(attacker.pers["team"], score, 0);
      return;
    }

    attacker scripts\mp\gamescore::giveplayerscore(#"kill", score, self);
  }
}

function function_2a3c9a91bf1d3911() {
  if(getdvarint(@ "hash_1e86798724d1115d", 0) != 0) {
    return true;
  }

  return istrue(level.interrogationenabled);
}

function function_d9bd056c79a6077b(revivee) {
  self.var_3c3de22bd4680edb = function_6d6af8144a5131f1(self.var_3c3de22bd4680edb, revivee);

  if(self.var_3c3de22bd4680edb.size > 0) {
    revivee.reviver = self;
    self.revivingteammate = 1;
  }
}

function function_42d99e200aa9762a(revivee) {
  self.var_3c3de22bd4680edb = array_remove(self.var_3c3de22bd4680edb, revivee);

  if(self.var_3c3de22bd4680edb.size <= 0) {
    self.revivingteammate = 0;
    revivee.reviver = undefined;
  }
}

function function_538e8d0f5b4d6383() {
  if(!isDefined(self.var_3c3de22bd4680edb)) {
    return undefined;
  }

  return array_get_first_item(self.var_3c3de22bd4680edb);
}

function function_9168ee31efcf3393() {
  level endon("<dev string:x21e>");
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

      if(isagent(player)) {
        continue;
      }

      if(isbot(player)) {
        continue;
      }

      player forcelaststand();
    }

    setDvar(@ "hash_9564fda23c9d6dbd", 0);
  }
}

function forcelaststand() {
  if(!_hasperk("<dev string:x22c>")) {
    giveperk("<dev string:x22c>");
  }

  self dodamage(self.maxhealth, self.origin, self, undefined, "<dev string:x245>");
}

function function_e7884f1619dc53be() {
  level endon("<dev string:x21e>");
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
          iprintlnbold("<dev string:x254>");
          break;
        }

        pistolobj = eplayer scripts\mp\gametypes\br_public::playergetlaststandpistol();

        if(!isDefined(pistolobj)) {
          iprintlnbold("<dev string:x264>");
          break;
        }

        eplayer dodamage(eplayer.health + 200, var_4cd9f1ecf86a97bb.origin, var_4cd9f1ecf86a97bb, var_4cd9f1ecf86a97bb, "<dev string:x27e>", var_4cd9f1ecf86a97bb.primaryweaponobj, "<dev string:x292>");
        var_4cd9f1ecf86a97bb hudoutlineenable("<dev string:x2a1>");
        iprintlnbold("<dev string:x2b8>");
        break;
      case 2:
        if(!isDefined(var_4cd9f1ecf86a97bb) || !isDefined(var_de75a3b89e8300f5)) {
          iprintlnbold("<dev string:x2c5>");
          break;
        }

        pistolobj = eplayer scripts\mp\gametypes\br_public::playergetlaststandpistol();

        if(!isDefined(pistolobj)) {
          iprintlnbold("<dev string:x264>");
          break;
        }

        eplayer dodamage(eplayer.health + 200, var_4cd9f1ecf86a97bb.origin, var_4cd9f1ecf86a97bb, var_4cd9f1ecf86a97bb, "<dev string:x27e>", var_4cd9f1ecf86a97bb.primaryweaponobj, "<dev string:x292>");
        wait 1;
        var_4cd9f1ecf86a97bb dodamage(var_4cd9f1ecf86a97bb.health + 200, var_de75a3b89e8300f5.origin, var_de75a3b89e8300f5, var_de75a3b89e8300f5, "<dev string:x27e>", var_de75a3b89e8300f5.primaryweaponobj, "<dev string:x292>");
        var_4cd9f1ecf86a97bb hudoutlineenable("<dev string:x2a1>");
        iprintlnbold("<dev string:x2b8>");
        break;
      case 3:
        if(!isDefined(var_4cd9f1ecf86a97bb) || !isDefined(var_de75a3b89e8300f5)) {
          iprintlnbold("<dev string:x2c5>");
          break;
        }

        var_4cd9f1ecf86a97bb dodamage(var_4cd9f1ecf86a97bb.health + 200, eplayer.origin, eplayer, eplayer, "<dev string:x27e>", eplayer.primaryweaponobj, "<dev string:x292>");
        wait 1;
        eplayer dodamage(eplayer.health + 200, var_de75a3b89e8300f5.origin, var_de75a3b89e8300f5, var_de75a3b89e8300f5, "<dev string:x27e>", var_de75a3b89e8300f5.primaryweaponobj, "<dev string:x292>");
        iprintlnbold("<dev string:x2df>");
        break;
      case 4:
        if(!isDefined(var_4cd9f1ecf86a97bb) || !isDefined(var_de75a3b89e8300f5)) {
          iprintlnbold("<dev string:x2c5>");
          break;
        }

        pistolobj = eplayer scripts\mp\gametypes\br_public::playergetlaststandpistol();

        if(!isDefined(pistolobj)) {
          iprintlnbold("<dev string:x264>");
          break;
        }

        eplayer dodamage(eplayer.health + 200, var_4cd9f1ecf86a97bb.origin, var_4cd9f1ecf86a97bb, var_4cd9f1ecf86a97bb, "<dev string:x27e>", var_4cd9f1ecf86a97bb.primaryweaponobj, "<dev string:x292>");
        var_4cd9f1ecf86a97bb hudoutlineenable("<dev string:x2a1>");
        iprintlnbold("<dev string:x2b8>");
        var_4cd9f1ecf86a97bb waittill("<dev string:x2ff>");
        wait 1;
        var_4cd9f1ecf86a97bb dodamage(var_4cd9f1ecf86a97bb.health + 200, var_de75a3b89e8300f5.origin, var_de75a3b89e8300f5, var_de75a3b89e8300f5, "<dev string:x27e>", var_de75a3b89e8300f5.primaryweaponobj, "<dev string:x292>");
        break;
      case 5:
        if(!isDefined(var_4cd9f1ecf86a97bb) || !isDefined(var_de75a3b89e8300f5)) {
          iprintlnbold("<dev string:x2c5>");
          break;
        }

        var_de75a3b89e8300f5 dodamage(var_de75a3b89e8300f5.health + 200, var_4cd9f1ecf86a97bb.origin, var_4cd9f1ecf86a97bb, var_4cd9f1ecf86a97bb, "<dev string:x27e>", var_4cd9f1ecf86a97bb.primaryweaponobj, "<dev string:x292>");
        var_4cd9f1ecf86a97bb hudoutlineenable("<dev string:x2a1>");
        iprintlnbold("<dev string:x2b8>");
        var_4cd9f1ecf86a97bb waittill("<dev string:x2ff>");
        var_4cd9f1ecf86a97bb hudoutlinedisable();
        wait 1;
        var_de75a3b89e8300f5 notify("<dev string:x313>");
        break;
    }
  }
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

      if(isinlaststand(host) || istrue(host.liveragdoll)) {
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
          host.reviver botpressbutton("<dev string:x32a>", presstime);
          wait presstime + 0.5;

          if(isinlaststand(host) || istrue(host.liveragdoll)) {
            host.reviver botpressbutton("<dev string:x32a>", presstime);
          }
        }
      } else {
        iprintlnbold("<dev string:x331>");
      }

      setdevdvar(@ "hash_d475fd19488b5a6d", 0);
    } else if(getdvarint(@ "hash_b5de345e9da778b5", 0) == 1) {
      wait 1;

      while(true) {
        victim = undefined;

        foreach(player in level.players) {
          if(isinlaststand(player)) {
            victim = player;
            break;
          }
        }

        if(!isDefined(victim)) {
          iprintlnbold("<dev string:x3a0>");
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
          victim.reviver botpressbutton("<dev string:x32a>", presstime);
          wait presstime + 0.5;

          if(isinlaststand(victim)) {
            victim.reviver botpressbutton("<dev string:x32a>", presstime);
          }

          break;
        }

        setdevdvar(@ "hash_b5de345e9da778b5", 0);
      }
    } else if(getdvarint(@ "hash_d475fd19488b5a6d", 0) == 2) {
      foreach(player in level.players) {
        if(player ishost() && isinlaststand(player)) {
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
          host.var_6627db08bfd4f903 setdevtext("<dev string:x3d5>");
          host.var_6627db08bfd4f903.color = (1, 1, 1);
        } else {
          host iprintlnbold("<dev string:x3d5>");
        }
      }

      setdevdvar(@ "hash_d475fd19488b5a6d", 0);
    }

    wait 1;
  }
}

function function_5b2d5cabc8a36244() {
  if(istrue(level.laststand)) {
    wait 0.5;
    function_6e7290c8ee4f558b("<dev string:x3fc>");
    function_b23a59dfb4ca49a1("<dev string:x410>", "<dev string:x429>", &debug_laststand, 1);
    function_fe953f000498048f();
  }
}

function debug_laststand(params) {
  var_b1d8ddc347cf4b0d = 5;

  while(true) {
    foreach(player in level.players) {
      if(isDefined(player.laststandreviveent)) {
        print3d(player.laststandreviveent.origin, "<dev string:x442>", (1, 1, 1), 1, 0.25);
        print3d(player.laststandreviveent.origin - (0, 0, var_b1d8ddc347cf4b0d), "<dev string:x455>" + default_to(player.laststandreviveent.curprogress, 0) / 1000 + "<dev string:x463>" + default_to(player.laststandreviveent.usetime, 0) / 1000 + "<dev string:x468>", (1, 1, 1), 1, 0.25);
        print3d(player.laststandreviveent.origin - (0, 0, var_b1d8ddc347cf4b0d * 2), "<dev string:x474>" + default_to(player.timeuntilbleedout, level.laststandtimer), (1, 1, 1), 1, 0.25);
      }
    }

    waitframe();
  }
}

function function_c7fdbd03f0cc2398(params) {
  var_3352bf952cfc182a = params[0];
  n_ent_num = int(params[1]);

  foreach(player in level.players) {
    if(isDefined(var_3352bf952cfc182a) && player.name == var_3352bf952cfc182a || player getentitynumber() == n_ent_num) {
      if(isinlaststand(player)) {
        player.var_8192ba8fe8d68cf0 = 1;
      } else {
        player dodamage(player.health + 666, player.origin, player);
      }

      break;
    }
  }
}

function function_2fd31e84d4bfc226(params) {
  var_3352bf952cfc182a = params[0];
  n_ent_num = int(params[1]);

  foreach(player in level.players) {
    if(isDefined(var_3352bf952cfc182a) && player.name == var_3352bf952cfc182a || player getentitynumber() == n_ent_num) {
      if(scripts\mp\utility\player::isinlaststand(player) && isDefined(player.laststandreviveent)) {
        player.laststandreviveent thread selfrevivethink();
        player.var_82300c21f62a6edb = 1;
      }
    }
  }
}

function function_6acfa89023b79437(params) {
  var_3352bf952cfc182a = params[0];
  n_ent_num = int(params[1]);

  foreach(player in level.players) {
    if(isDefined(var_3352bf952cfc182a) && player.name == var_3352bf952cfc182a || player getentitynumber() == n_ent_num) {
      reviver = undefined;

      foreach(other_player in level.players) {
        if(isalive(other_player) && player != other_player) {
          reviver = other_player;
          break;
        }
      }

      reviver = default_to(reviver, player);

      if(scripts\mp\utility\player::isinlaststand(player)) {
        if(isDefined(player.laststandreviveent)) {
          reviver.var_82300c21f62a6edb = 1;

          if(reviver != player) {
            player.laststandreviveent notify("<dev string:x48d>", reviver);
          }

          player waittill_any_return_no_endon_death_4("<dev string:x498>", "<dev string:x4af>", "<dev string:x4c9>", "<dev string:x4e0>");
          reviver.var_82300c21f62a6edb = undefined;
        }
      } else if(isDefined(player.var_9bfbbff8982fc132)) {
        player.var_9bfbbff8982fc132 notify("<dev string:x48d>", player);
      } else if(isDefined(level.revivetriggers) && isDefined(level.revivetriggers[player.guid])) {
        icon = level.revivetriggers[player.guid];
        icon.reviver = reviver;
        reviver.var_82300c21f62a6edb = 1;
        level scripts\mp\teamrevive::function_301c4ec489f9bd39(icon, "<dev string:x4f7>", "<dev string:x50c>", reviver, 1, "<dev string:x4f7>");
        icon waittill("<dev string:x516>");
        reviver.var_82300c21f62a6edb = undefined;
      }

      break;
    }
  }
}

function function_3ade7c3fe243f058(params) {
  var_3352bf952cfc182a = params[0];
  n_ent_num = int(params[1]);

  foreach(player in level.players) {
    if(isDefined(var_3352bf952cfc182a) && player.name == var_3352bf952cfc182a || player getentitynumber() == n_ent_num) {
      player function_7eba90a4d2ef6d6f();
      break;
    }
  }
}

# /