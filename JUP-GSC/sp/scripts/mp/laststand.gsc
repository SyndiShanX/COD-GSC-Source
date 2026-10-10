/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\mp\laststand.gsc
***********************************************/

#using script_21c19cfc7139d773;
#using script_40e63dd222434655;
#using script_448ef4d9e70ce5e;
#using scripts\common\ae_utility;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\killstreaks\recon_drone;
#using scripts\cp_mp\laststand;
#using scripts\cp_mp\playerhealth;
#using scripts\cp_mp\quickprompt;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\anim;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\cranked;
#using scripts\mp\damage;
#using scripts\mp\equipment\battlerage;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\grind;
#using scripts\mp\gametypes\obj_dogtag;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\laststand;
#using scripts\mp\perks\perkfunctions;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\supers;
#using scripts\mp\supers\super_stimpistol;
#using scripts\mp\team_assimilation;
#using scripts\mp\teamrevive;
#using scripts\mp\tweakables;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\weapons;
#namespace laststand;

function init() {
  function_150b60d7cbd3ba2();
  level._effect["vfx_br_interr_in"] = loadfx("vfx/iw9_br/vfx_br_interr_in");
  level._effect["vfx_br_interr_mid"] = loadfx("vfx/iw9_br/vfx_br_interr_mid");
  level._effect["vfx_br_interr_out"] = loadfx("vfx/iw9_br/vfx_br_interr_out");
  setdvarifuninitialized(@ "hash_ddbf6f11fc2231f2", 3);
  setdvarifuninitialized(@ "hash_6acfbd4650e8691f", 300);
  setdvarifuninitialized(@ "hash_a8e0e2bf5a22916c", 5);
  setdvarifuninitialized(@ "hash_3c56d9ef17112cdd", 3);
  setdvarifuninitialized(@ "hash_c1469be98181753d", 15);
  setdvarifuninitialized(@ "hash_de39bef0e704c70b", 2);
  setdvarifuninitialized(@ "hash_cc42e9e3eb814f82", 1);
  setdvarifuninitialized(@ "hash_6cc46c78f1221930", 100);
  setdvarifuninitialized(@ "hash_dcdd2aa64529509e", 185);
  setdvarifuninitialized(@ "hash_46685b5a7ab844eb", 0.2);
  setdvarifuninitialized(@ "hash_a77cf11d23a937f4", 1);
  setdvarifuninitialized(@ "hash_2e92604af6208d28", 1);
  setdvarifuninitialized(@ "hash_97e42d15f6dd7208", 0.2);
  setdvarifuninitialized(@ "hash_d856d9dc9669c4f2", 100);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&interrogation_onplayerdisconnect);

  if(scripts\mp\team_assimilation::function_6934349b7823d888()) {
    scripts\mp\team_assimilation::registerteamassimilatecallback(&scripts\mp\teamrevive::function_df4a3cff3137d441);
  }

  setdevdvarifuninitialized(@ "hash_f1bef8e461ed63f", 0);
  level thread function_d9b9b021d2e292a7();

  if(getgametype() == "xfire") {
    level.var_a04b495bbccdf0bf = 0;
    level.var_eb919e162d131112 = 0;
    level.var_62973ff88470b851 = 0;
    setomnvar("ui_cutthroat_num_reviving_team_1", 0);
    setomnvar("ui_cutthroat_num_reviving_team_2", 0);
    setomnvar("ui_cutthroat_num_reviving_team_3", 0);
    level.var_2d9a769507f8c794 = 0;
    level.var_419bc98b5f722331 = 0;
    level.var_9663d50652fde8c2 = 0;
    setomnvar("ui_cutthroat_num_downed_team_1", 0);
    setomnvar("ui_cutthroat_num_downed_team_2", 0);
    setomnvar("ui_cutthroat_num_downed_team_3", 0);
  }

  level.interrogationcount = 0;
}

function laststandthink() {
  level endon("game_ended");
  onenter();
  result = function_efe4706df8361219("last_stand_heal_success", "last_stand_revived", "last_stand_bleedout", "death", "disconnect", "last_stand_self_revive", "enter_live_ragdoll");

  if(false) {
    resstring = ter_op(isDefined(result), result, "<dev string:x1c>");
    println("<dev string:x26>" + resstring);
  }

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
    case #"hash_e8bc3da4af287c2d":
      if(!((isteamreviveenabled() || scripts\cp_mp\utility\game_utility::isbrstylegametype()) && scripts\mp\flags::gameflag("prematch_done"))) {
        ondeath();
      } else {
        onexitcommon();

        if(isDefined(self)) {
          dropcarryobject();
        }
      }

      break;
    case #"hash_8a3297e83141974b":
      ondeath();
      break;
  }

  if(isDefined(self)) {
    self setclientomnvar("ui_is_laststand", 0);
  }
}

function onenter() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("last_stand_finished");
  self notify("last_stand_start");
  self setclientomnvar("ui_is_laststand", 1);

  if(getgametype() == "xfire") {
    function_e6ccdf90ba898cdc(self.team, 1);
    self setclientomnvar("ui_cutthroat_player_state", 1);
  }

  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, #"bc_status_player_last_stand", undefined, 0.25);
  self.var_b24e609023ce8208 = scripts\mp\supers\super_stimpistol::function_a35fff2ff233592a() && !istrue(self.hasselfrevivetoken);

  if(_hasperk("specialty_shroud")) {
    self launchgrenade("jup_smoke_grenade_mp", self.origin + (0, 0, 20), (0, 0, 0), 0.5);
  }

  if(_hasperk("specialty_survivor")) {
    self.var_4945d0d82dd3964b = 1;
  }

  if(_hasperk("specialty_survivor") && isDefined(self.var_d3bfe8baae5df8e0)) {
    thread namespace_88bfae359020fdd3::function_8fdd864a86afe560(self.laststandattacker);
  }

  healthvalue = level.laststandhealth;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    thread last_stand_sfx();
  }

  if(!isusingmatchrulesdata()) {
    healthvalue = getwatcheddvar("<dev string:x45>");

    if(!isDefined(healthvalue)) {
      healthvalue = getdvarint(@ "scr_player_laststandhealth", 50);
    }

    if(healthvalue > scripts\mp\tweakables::gettweakablevalue("<dev string:x55>", "<dev string:x5c>")) {
      healthvalue = scripts\mp\tweakables::gettweakablevalue("<dev string:x55>", "<dev string:x5c>");
    }
  }

  if(function_311066dfee085643(self)) {
    healthvalue = level.var_409e54f81172d6d8.laststandhealth;
  }

  self.health = healthvalue;
  scripts\cp_mp\utility\killstreak_utility::function_3f55c1fb553a4775(self);
  thread makelaststandinvuln();
  giveperk("specialty_block_health_regen");
  giveperk("specialty_blindeye");
  self.var_2fb534abd9eb93ca = 0;
  self.inlaststand = 1;
  self.playergoingintols = undefined;
  self.hasshownlaststandicon = 0;
  self.laststandstarttime = gettime();
  self.ignoreafkcheck = 1;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && !istrue(self.hasselfrevivetoken) && !istrue(self.var_b24e609023ce8208)) {
    if(isDefined(level.checkforlaststandfinish)) {
      [[level.checkforlaststandfinish]]();
    }
  }

  if(_hasperk("specialty_survivor") && !scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    self.timeuntilbleedout = level.laststandtimer;
    setlowermessageomnvar("survivor_revive", int(gettime() + self.timeuntilbleedout * 1000));
  }

  if(isDefined(self.var_4d52ef6a17e52924)) {
    weapon::updatemovespeedscale();
  }

  self.laststandoldweaponobj = getlastweapon();

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(!istrue(self.gulag)) {
      scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onLastStandEnter");

      if(!istrue(level.var_7a37960f05887b39)) {
        foreach(teammate in level.teamdata[self.team]["alivePlayers"]) {
          if(!isDefined(teammate)) {
            continue;
          }

          if(teammate != self) {
            teammate thread scripts\mp\hud_message::showsplash("br_teammate_down", undefined, self);
            teammate thread namespace_88bfae359020fdd3::function_4e19e6bf429dda56(self);
          }
        }
      }
    }
  }

  if(getdvarint(@ "hash_7bb41608649743f4", 0) != 0) {
    self function_187fb04ebd01baea();
  } else if(getdvarint(@ "hash_112f10fcbe78647", 0) != 0) {
    self releaseoffhand();
  }

  laststandweapon = level.laststandweapon;

  if(!isusingmatchrulesdata()) {
    laststandweapon = getwatcheddvar("<dev string:x66>");

    if(!isDefined(laststandweapon)) {
      laststandweapon = getDvar(@ "hash_ab99ad42c8f9d6fd", "<dev string:x76>");
    }
  }

  if(function_311066dfee085643(self)) {
    laststandweapon = self[[level.var_409e54f81172d6d8.laststandweaponcallback]]();
  } else if(isDefined(level.laststandweaponcallback) && getdvarint(@ "hash_ddd02929770fcc8c", 0)) {
    laststandweapon = self[[level.laststandweaponcallback]]();
  }

  if(!isweapon(laststandweapon)) {
    laststandweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845(laststandweapon);
  }

  if(!istrue(self.usingascender)) {
    self stopanimscriptsceneevent();
  }

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
  thread handlelaststandweapongivepipeline(laststandweapon);

  if(isDefined(level.addlaststandoverheadiconcallback)) {
    self[[level.addlaststandoverheadiconcallback]]();
  } else {
    addoverheadicon();
  }

  var_276b87b88716c2a5 = level.laststandsuicidetimer;

  if(!isusingmatchrulesdata()) {
    var_276b87b88716c2a5 = getwatcheddvar("<dev string:x89>");

    if(!isDefined(var_276b87b88716c2a5)) {
      var_276b87b88716c2a5 = getdvarfloat(@ "hash_a4353f59ee601382", 5);
    }
  }

  _shellshock("last_stand_mp", "damage", var_276b87b88716c2a5, 0);
  thread revivesetup(self);

  if(function_2a3c9a91bf1d3911()) {
    thread interrogationsetup(self);
  }

  self.fastcrouchspeedmod = getdvarfloat(@ "hash_1a0de898609317b4", 0);
  scripts\cp_mp\challenges::stopchallengetimer("alive_not_downed");

  if(isDefined(self.laststandattacker) && self.laststandattacker _hasperk("specialty_reduce_regen_delay_on_kill")) {
    self.laststandattacker scripts\mp\perks\perkfunctions::regendelayreduce_onkill();
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    childthread stucktime(var_276b87b88716c2a5);
  } else {
    if(isDefined(self.sessionuimemberindex) && (!isDefined(level.laststandoutlineenabled) || level.laststandoutlineenabled)) {
      outlinename = "outline_nodepth_brplayer" + self.sessionuimemberindex + 1;
      self.laststandoutlineid = scripts\mp\utility\outline::outlineenableforteam(self, self.team, outlinename, "laststand");
    }

    childthread dodamagewhiledown();
  }

  scripts\cp_mp\challenges::function_fb2db8647d693699(self);
  callback::callback("player_laststand");
}

function last_stand_sfx() {
  if(!istrue(self.deathsdoorsfx) && !istrue(self.var_a9982aba7477cc90)) {
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

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && (self.currentweapon.basename == "iw9_armor_plate_deploy_mp" || self.currentweapon.basename == "teammate_revive_stim_mp")) {
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
      laststandweapondelay = getwatcheddvar("<dev string:x9f>");

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
    basehealth = getwatcheddvar("<dev string:x45>");

    if(!isDefined(basehealth)) {
      basehealth = getdvarint(@ "scr_player_laststandhealth", 50);
    }

    if(basehealth > scripts\mp\tweakables::gettweakablevalue("<dev string:x55>", "<dev string:x5c>")) {
      basehealth = scripts\mp\tweakables::gettweakablevalue("<dev string:x55>", "<dev string:x5c>");
    }

    bleedouttime = getwatcheddvar("<dev string:xb4>");

    if(!isDefined(bleedouttime)) {
      bleedouttime = getdvarfloat(@ "hash_546d8a10bb4e83de", 10);
    }
  }

  if(function_311066dfee085643(self)) {
    bleedouttime = level.var_409e54f81172d6d8.var_1694969c43add70d;
  }

  if(bleedouttime <= 0) {
    onbleedout();
    return;
  }

  var_76e563db5d11a0ea = float(basehealth) / float(bleedouttime);
  var_76e563db5d11a0ea /= max(getmatchrulesdata("commonOption", "lastStandDamageTakenScalar"), 0.01);
  wait 1;
  laststanddamageweapon = makeweapon("iw9_me_fists_mp_ls");

  if(!istrue(level.var_28a06842b082bea1)) {
    thread suicidesetup();
  }

  damagedealt = 0;

  while(self.health > 0) {
    if(getdvarint(@ "hash_312c93a94bab8ee", 0) != 0) {
      wait 1;
      continue;
    }

    if(self isinexecutionvictim()) {
      wait 1;
      continue;
    }

    if(!istrue(getbeingrevivedinternal())) {
      var_703f141d7d6fea1e = int(damagedealt + var_76e563db5d11a0ea) - int(damagedealt);
      damagedealt += var_76e563db5d11a0ea;
      self.islaststandbleedoutdmg = 1;
      self dodamage(var_703f141d7d6fea1e, self.origin, self, undefined, "MOD_TRIGGER_HURT", laststanddamageweapon, "none");
      self playlocalsound("mvmt_heartbeat_plr_laststand");
      self.islaststandbleedoutdmg = undefined;
    }

    if(self.health <= 0 || istrue(self.liveragdoll)) {
      onbleedout();
      break;
    }

    wait 1;
  }
}

function stucktime(var_276b87b88716c2a5) {
  self.stuckinlaststand = 1;
  wait var_276b87b88716c2a5;
  self.stuckinlaststand = 0;
  timeleft = level.laststandtimer;

  if(getdvarint(@ "hash_312c93a94bab8ee", 0) != 0 || getdvarfloat(@ "hash_546d8a10bb4e83de", 10) == -1) {
    return;
  }

  if(!isusingmatchrulesdata()) {
    timeleft = getwatcheddvar("<dev string:xb4>");

    if(!isDefined(timeleft)) {
      timeleft = getdvarfloat(@ "hash_546d8a10bb4e83de", 10);
    }
  }

  if(function_311066dfee085643(self)) {
    timeleft = level.var_409e54f81172d6d8.var_1694969c43add70d;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    assertex(timeleft > 0, "Last Stand: Bleedout time must be greater than 0");
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
  if(isbot(downedplayer) && istrue(downedplayer.var_f932828585d0926c)) {
    return 1;
  }

  if(getdvarint(@ "hash_51d681fbc88502b9", 0) == 1) {
    return 1;
  }

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
  usetime = getwatcheddvar("lastStandReviveTimer") * 1000;

  if(downedplayer _hasperk("specialty_survivor") && isDefined(level.var_d69a2eb29ce33499)) {
    usetime = level.var_d69a2eb29ce33499;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && (downedplayer _hasperk("specialty_br_faster_revive") || istrue(downedplayer.var_d3bfe8baae5df8e0))) {
    usetime *= 0.75;
  }

  triggerent.usetime = usetime;

  if(!isDefined(self.curprogress)) {
    self.curprogress = 0;
  }

  while(true) {
    if(selfrevivebuttonPressed(downedplayer) && !istrue(downedplayer.isselfreviving) && !istrue(downedplayer.beingrevived) && (downedplayer isonground() || downedplayer isswimming())) {
      triggerent notify("self_revive_start");
      downedplayer setlaststandselfreviving(1, istrue(downedplayer.var_b24e609023ce8208));

      if(istrue(downedplayer.var_dd016b4325035d0)) {
        downedplayer thread scripts\mp\equipment\battlerage::function_521fd860d61eb949();
      }

      if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
        downedplayer scripts\mp\gametypes\br_public::setplayerselfrevivingextrainfo(1);
      }

      triggerent thread selfrevivemonitorrevivebuttonPressed();
    }

    waitframe();
  }
}

function function_8afb9538db673551() {
  if(!function_14430db14b833985()) {
    self attach("offhand_1h_wm_stim_v0", "tag_accessory_left");
    self.var_f46a64206952c575 = "offhand_1h_wm_stim_v0";
  }
}

function function_a904cc021551fd6b() {
  if(!function_14430db14b833985()) {
    self attach("misc_wm_stim_pistol_v0", "tag_accessory_left");
    self.var_f46a64206952c575 = "misc_wm_stim_pistol_v0";
  }
}

function function_9e41f17f1bd6e77e() {
  if(function_14430db14b833985()) {
    self detach(self.var_f46a64206952c575, "tag_accessory_left");
    self.var_f46a64206952c575 = undefined;
  }
}

function function_14430db14b833985() {
  return isDefined(self.var_f46a64206952c575);
}

function selfrevivemonitorrevivebuttonPressed() {
  downedplayer = self.owner;
  triggerent = self;
  level endon("game_ended");
  downedplayer endon("death_or_disconnect");
  downedplayer endon("last_stand_finished");
  triggerent.waitingforteammaterevive = 0;
  triggerent thread selfrevivebuttonpresscleanup();

  while(isreallyalive(downedplayer) && (selfrevivebuttonPressed(downedplayer) || downedplayer function_77799f0211be1728()) && triggerent.curprogress < triggerent.usetime) {
    while(!(downedplayer isonground() || downedplayer isswimming()) && selfrevivebuttonPressed(downedplayer) && !istrue(downedplayer.isselfreviving)) {
      waitframe();
    }

    if(!selfrevivebuttonPressed(downedplayer) && !downedplayer function_77799f0211be1728()) {
      break;
    }

    if(downedplayer isinexecutionvictim()) {
      break;
    }

    if(istrue(downedplayer.ishaywire)) {
      break;
    }

    if(istrue(downedplayer.var_fa3003648b3c8eac)) {
      downedplayer setbeingrevivedinternal(0);
      downedplayer function_51feaa413342a5a1();
      downedplayer scripts\mp\gameobjects::updateuiprogress(triggerent, 1);
      break;
    }

    if(istrue(downedplayer.beingrevived)) {
      downedplayer scripts\mp\gameobjects::updateuiprogress(triggerent, 1);
      break;
    }

    if(!istrue(downedplayer.isselfreviving)) {
      downedplayer val::group_reset("laststand");
      downedplayer val::set("_group_laststand", "weapon_pickup", 0);
      teststring = downedplayer val::get("gesture");
      downedplayer.isselfreviving = 1;
      downedplayer allowmovement(0);
    }

    if(istrue(downedplayer.var_b24e609023ce8208) && !downedplayer hasweapon("iw8_ges_plyr_self_revive_stim_pistol")) {
      downedplayer function_a904cc021551fd6b();
      downedplayer thread scripts\mp\gametypes\br_public::playerplaygestureweaponanim("iw8_ges_plyr_self_revive_stim_pistol", 10);
      downedplayer.var_c6a5ba98f5f43e0d = 1;
      triggerent.inuse = 1;
    } else if(!downedplayer hasweapon("iw8_ges_plyr_self_revive")) {
      downedplayer function_8afb9538db673551();
      downedplayer thread scripts\mp\gametypes\br_public::playerplaygestureweaponanim("iw8_ges_plyr_self_revive", 10);
    }

    if(!(downedplayer isonground() || downedplayer isswimming())) {
      break;
    }

    if(!isDefined(triggerent.userate)) {
      triggerent.userate = 0;
    }

    triggerent.curprogress += level.frameduration * triggerent.userate;
    triggerent.userate = 1;
    downedplayer scripts\mp\gameobjects::updateuiprogress(triggerent, 1);

    if(triggerent.curprogress >= triggerent.usetime) {
      downedplayer stopgestureviewmodel("ges_equip_stim_self_revive");
      downedplayer stopgestureviewmodel("iw9_vm_ges_stimpistol_self_revive");

      if(istrue(downedplayer.var_dd016b4325035d0)) {
        downedplayer thread scripts\mp\equipment\battlerage::function_905b7bada6fd91cb(1);
      }

      wait 0.5;

      if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
        scripts\mp\gametypes\br_analytics::branalytics_selfrevive(downedplayer);
      }

      downedplayer finishreviveplayer("self_revive_success", downedplayer);

      if(istrue(downedplayer.var_b24e609023ce8208)) {
        downedplayer thread scripts\mp\supers\super_stimpistol::function_31afe9d7b373900f();
        return;
      }

      if(isDefined(level.removeselfrevivetoken)) {
        downedplayer[[level.removeselfrevivetoken]]();
        downedplayer scripts\mp\gametypes\br_pickups::function_b76f69ce63757cea("brloot_self_revive");
      }

      return;
    }

    waitframe();
  }

  if(!istrue(downedplayer getbeingrevivedinternal())) {
    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
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

  if(isDefined(downedplayer)) {
    if(!istrue(downedplayer.beingrevived)) {
      downedplayer scripts\mp\gameobjects::updateuiprogress(triggerent, 0);
      downedplayer allowmovement(1);
    }

    downedplayer function_9e41f17f1bd6e77e();
    downedplayer stopgestureviewmodel("ges_equip_stim_self_revive");
    downedplayer setlaststandselfreviving(0);

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      downedplayer scripts\mp\gametypes\br_public::setplayerselfrevivingextrainfo(0);
    }

    downedplayer.isselfreviving = 0;
  }
}

function onexitcommon(revived) {
  if(!isDefined(self)) {
    return;
  }

  self endon("disconnect");
  level endon("game_ended");
  self.laststandactionset = undefined;
  self.var_c6a5ba98f5f43e0d = undefined;
  scripts\cp_mp\utility\killstreak_utility::function_17576a4cdcd447a7(self);
  thread clearlaststandinvuln();
  self allowmovement(1);
  self.fastcrouchspeedmod = 0;
  scripts\mp\weapons::updatemovespeedscale();

  if(_hasperk("specialty_block_health_regen")) {
    removeperk("specialty_block_health_regen");
  }

  if(_hasperk("specialty_blindeye")) {
    removeperk("specialty_blindeye");
  }

  if(istrue(revived)) {
    scripts\cp_mp\playerhealth::function_19b9bb9cef6a2d3();
  }

  laststandweapon = level.laststandweapon;

  if(!isusingmatchrulesdata()) {
    laststandweapon = getwatcheddvar("<dev string:x66>");
  }

  laststandweapon = makeweapon(laststandweapon);

  if(self getcurrentprimaryweapon() != laststandweapon) {
    self notify("end_switchToFists");
    abortmonitoredweaponswitch(laststandweapon);
  } else {
    _takeweapon(laststandweapon);
  }

  self notify("last_stand_finished");
  self.laststandoldweapon = undefined;

  if(istrue(getbeingrevivedinternal())) {
    setbeingrevivedinternal(0);
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    scripts\mp\gametypes\br::updatesquadmemberlaststandreviveprogress(self, self, 0, 1);
    scripts\mp\gametypes\br_public::setplayerbeingrevivedextrainfo(0);
    self.brdownedbyairstriketime = undefined;
  }

  self setclientomnvar("ui_is_laststand", 0);
  self setclientomnvar("ui_securing", 0);

  if(getgametype() == "xfire") {
    var_6e672788835fc16b = self getclientomnvar("ui_cutthroat_player_state");

    if(var_6e672788835fc16b == 1) {
      function_e6ccdf90ba898cdc(self.team, -1);
    }

    if(var_6e672788835fc16b == 2) {
      function_5911caad56f963ea(self.team, -1);
    }

    if(istrue(revived)) {
      self setclientomnvar("ui_cutthroat_player_state", 0);
    } else {
      self setclientomnvar("ui_cutthroat_player_state", 3);
    }
  }

  setlowermessageomnvar("clear_lower_msg");

  if(isDefined(level.modeonexitlaststandfunc)) {
    self[[level.modeonexitlaststandfunc]](revived);
  }

  scripts\mp\supers\super_stimpistol::function_807b3b0a3b4128f9();

  if(function_2a3c9a91bf1d3911()) {
    if(isDefined(self.laststandreviveent)) {
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.laststandreviveent.headiconon);
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.laststandreviveent.headiconoff);
      self.laststandreviveent.headiconon = undefined;
      self.laststandreviveent.headiconoff = undefined;
    }

    self setclientomnvar("ui_br_has_been_interrogated", 0);
  }

  waittillframeend();
  self.inlaststand = 0;
  self.ignoreafkcheck = 0;
  self notify("afk_tracking_resume");
}

function onrevive(var_4920bf02df960be9, var_d07b7dcc79b24490) {
  oldweaponobj = self.laststandoldweaponobj;
  val::reset_all("laststand");

  if(getDvar(@ "hash_7611a2790a0bf7fe", "") == "plunder" || getDvar(@ "hash_7611a2790a0bf7fe", "") == "risk") {
    scripts\mp\gametypes\br_plunder::plunder_allowallrepositoryuseforplayer(self, 1, 1);
  }

  val::group_reset(default_to(self.laststandactionset, "laststand"));
  onexitcommon(1);
  self laststandrevive();
  self playsoundtoteam("npc_breath_revive", self.team, self, self);
  self playlocalsound("plr_breath_revive");
  self stoplocalsound("mvmt_heartbeat_plr_laststand");
  self notify("laststand_revived");
  laststandweapon = level.laststandweapon;

  if(!isusingmatchrulesdata()) {
    laststandweapon = getwatcheddvar("<dev string:x66>");

    if(!isDefined(laststandweapon)) {
      laststandweapon = getDvar(@ "hash_ab99ad42c8f9d6fd", "<dev string:x76>");
    }
  }

  if(laststandweapon != "none") {
    thread domonitoredweaponswitch(oldweaponobj, 1);
  }

  if(function_311066dfee085643(self)) {
    self.health = level.var_409e54f81172d6d8.laststandrevivehealth;
  } else if(!istrue(var_d07b7dcc79b24490)) {
    healthvalue = level.laststandrevivehealth;

    if(!isusingmatchrulesdata()) {
      healthvalue = getwatcheddvar("<dev string:xc3>");

      if(!isDefined(healthvalue)) {
        healthvalue = getdvarint(@ "scr_player_laststandhealth", 50);
      }

      if(healthvalue > scripts\mp\tweakables::gettweakablevalue("<dev string:x55>", "<dev string:x5c>")) {
        healthvalue = scripts\mp\tweakables::gettweakablevalue("<dev string:x55>", "<dev string:x5c>");
      }
    }

    if(!getdvarint(@ "scr_player_laststandreviveretainhealth") || self.health < level.laststandrevivehealth) {
      self.health = level.laststandrevivehealth;
      self notify("force_regeneration");
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
    if(!istrue(level.var_7a37960f05887b39)) {
      foreach(teammate in level.teamdata[self.team]["alivePlayers"]) {
        if(!isDefined(teammate)) {
          continue;
        }

        if(teammate != self) {
          teammate thread scripts\mp\hud_message::showsplash("br_teammate_revived", undefined, self);
        }
      }
    }
  }

  _stopshellshock();

  if(istrue(var_4920bf02df960be9) && istrue(level.allowselfrevive)) {
    allowselfrevive(0);
  }

  scripts\cp_mp\challenges::function_b050ed1983293d8(self, function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"hit"), "specialty_survivor", undefined);
  params = spawnStruct();
  params.reviver = self.var_63b104851a574f2a;
  callback::callback("player_revived", params);
  self.var_63b104851a574f2a = undefined;
  self.laststandattacker = undefined;
  self.laststandmeansofdeath = undefined;
  self.laststandweaponobj = undefined;
  self.laststanddowneddata = undefined;
  self.laststandattackermodifiers = undefined;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(isDefined(self.var_a188fba649ffd953)) {
      scripts\mp\gametypes\br_pickups::forcegivesuper(self.var_a188fba649ffd953);
      self.var_a188fba649ffd953 = undefined;
    }

    scripts\mp\gametypes\br_public::setplayerdownedextrainfo(0);
  }

  if(istrue(var_4920bf02df960be9)) {
    scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "self_revive");
  }
}

function onbleedout() {
  if(!isDefined(self)) {
    return;
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
      self notify("deaths_door_exit");
      self playlocalsound("deaths_door_death");
      self stoplocalsound("mvmt_heartbeat_plr_laststand");
      self enableplayerbreathsystem(1);
    }
  }

  callback::callback("player_bleedout");
  inflictor = undefined;

  if(isDefined(self.laststandattacker)) {
    inflictor = self.laststandattacker;
  } else if(isDefined(self.laststanddowneddata) && isDefined(self.laststanddowneddata.attacker)) {
    inflictor = self.laststanddowneddata.attacker;
  } else {
    inflictor = self;
  }

  self.bleedout = 1;
  self dodamage(self.health + 1000, self.origin, self, inflictor, "MOD_TRIGGER_HURT", makeweapon("iw9_me_fists_mp_ls"), "none");
  self.bleedout = undefined;
  survivorondeath(self.laststandattacker);
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
      self notify("deaths_door_exit");
      scripts\common\damage_effects::function_a2b4e6088394bade();
      self playlocalsound("deaths_door_death");
      self stoplocalsound("mvmt_heartbeat_plr_laststand");
      self enableplayerbreathsystem(1);
    }
  }

  if(isDefined(level.checkforlaststandwipe)) {
    [[level.checkforlaststandwipe]](self, 1);
  }

  thread onexitcommon();
  dropcarryobject();
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
  owner.var_65a2b57b2b474c00 = reviveent;

  if(!isDefined(level.laststandreviveents)) {
    level.laststandreviveents = [];
  }

  level.laststandreviveents[level.laststandreviveents.size] = reviveent;

  team = owner.team;
  reviveent linkTo(owner, "tag_origin", (0, 0, 20), (0, 0, 0));
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
  level.laststandreviveents[reviveent getentitynumber()] = reviveent;
  reviveent thread removereviveentfromlevelarrayondeath();
  owner thread function_788452276786dcc7();

  if(owner scripts\mp\gametypes\br_public::hasselfrevivetoken() || istrue(owner.var_b24e609023ce8208) || istrue(owner _hasperk("specialty_survivor")) && !isDefined(self.var_d3bfe8baae5df8e0)) {
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
  interrogationent linkTo(owner, "tag_origin", (0, 0, 12), (0, 0, 0));
  interrogationent.number = level.interrogationcount;
  level.interrogationcount++;
  interrogationent.owner = owner;
  interrogationent.inuse = 0;
  interrogationent.id = "laststand_interrogator";
  interrogationent.count = getdvarint(@ "hash_1ad2bfeffad0c8", 1);
  interrogationent.trigger = spawnStruct();
  interrogationent.trigger.owner = owner;
  interrogationent.trigger.id = "laststand_interrogation";
  interrogationent.trigger.targetname = "interrogation_trigger";
  interrogationent makeusable();
  interrogationent setuserange(getdvarfloat(@ "hash_6cc46c78f1221930", 100));
  function_2aa6e4d20914e40a(interrogationent);
  owner setclientomnvar("ui_br_has_been_interrogated", 0);
  owner.var_f159f1c13aa75721 = interrogationent;
  interrogationent thread function_dc8861a5e3b418d5(team);
  interrogationent thread function_56e47961499ca06c(team);
  interrogationent thread endreviveonownerdeathordisconnect();
}

function function_2aa6e4d20914e40a(interrogationent) {
  assert(isDefined(interrogationent));

  if(isDefined(interrogationent.owner) && interrogationent.owner usingtouch()) {
    interrogationent setCursorHint("HINT_BUTTON");
    interrogationent sethinticon("ui_mp_br_player_status_interrogation");
    interrogationent sethintdisplayrange(96);
    interrogationent setuserange(96);
  } else {
    interrogationent setCursorHint("HINT_NOBUTTON");
  }

  interrogationent setusehideprogressbar(1);
  interrogationent setuseholdduration("duration_none");
  interrogationent setHintString(&"MP/LASTSTAND_INTERROGATE_USE");
  interrogationent setusepriority(-1 - 1);
  interrogationent sethintdisplayfov(90);
  interrogationent setusefov(90);
}

function function_d393166ea9eab059(deathdata) {
  victim = deathdata.victim;

  if(istrue(level.gamemodebundle.var_198508771f0592a9) && isDefined(victim.attackers)) {
    foreach(attacker in victim.attackers) {
      if(istrue(attacker.inlaststand)) {
        attacker thread scripts\mp\laststand::onlaststandkillenemy(deathdata);
      }
    }

    return;
  }

  if(isDefined(deathdata.attacker) && istrue(deathdata.attacker.inlaststand)) {
    deathdata.attacker thread scripts\mp\laststand::onlaststandkillenemy(deathdata);
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
  self delete();
}

function removereviveentfromlevelarrayondeath() {
  level endon("game_ended");
  entnum = self getentitynumber();
  self waittill("death");
  level.laststandreviveents[entnum] = undefined;
}

function updateusablebyteam(team) {
  self disableplayeruseforallplayers();
  function_4c452a6c72371f17();

  foreach(player in level.players) {
    if(team == player.team && player != self.owner) {
      self enableplayeruse(player);
    }
  }
}

function function_38f5ade989b3848f(team) {
  assert(function_2a3c9a91bf1d3911());
  self enableplayeruseforallplayers();

  foreach(player in level.players) {
    if(team == player.team) {
      self disableplayeruse(player);
    }
  }
}

function function_4a3b25b6b877fe73(team) {
  self endon("death");
  self.owner endon("last_stand_finished");

  while(true) {
    updateusablebyteam(self.owner.team);
    self.owner waittill_any_2("joined_team", "refresh_revives");
  }
}

function function_dc8861a5e3b418d5(team) {
  self endon("death");
  self.owner endon("last_stand_finished");

  while(true) {
    function_38f5ade989b3848f(self.owner.team);
    self.owner waittill("joined_team");
  }
}

function function_7627883ac8601401() {
  if(!self isonground() && !self isswimming()) {
    return false;
  }

  if(self isdiving()) {
    return false;
  }

  return true;
}

function function_f111048fabf84e37(revivee) {
  if(!isDefined(revivee)) {
    return false;
  }

  if(!isDefined(self)) {
    return false;
  }

  return self useButtonPressed() || istrue(self.var_7f59448717b5aa63) || revivee scripts\mp\supers\super_stimpistol::function_f0d1c9c39359efff();
}

function revivetriggerthink(team) {
  self.owner endon("last_stand_finished");
  self.owner endon("last_stand_heal_active");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", reviver);

    reviver notify("<dev string:xd9>");

    if(istrue(self.owner.var_c6a5ba98f5f43e0d)) {
      continue;
    }

    if(reviver.team != self.owner.team && !istrue(self.skipteamchecks)) {
      continue;
    }

    if(istrue(self.owner.var_895c1aaac16f7256) || istrue(reviver.var_93018d510a589832)) {
      continue;
    }

    revivermover = reviver getmovingplatformparent();
    reviveemover = self.owner getmovingplatformparent();
    onmover = isDefined(revivermover) || isDefined(reviveemover);

    if(onmover && !scripts\engine\trace::ray_trace_detail_passed(reviver getEye(), self.origin + (0, 0, 20), [reviver, self.owner], scripts\engine\trace::create_contents(1, 0, 0, 0, 0, 1))) {
      reviver scripts\mp\hud_message::showerrormessage("MP/REVIVE_BLOCKED");
      continue;
    }

    while(reviver function_f111048fabf84e37(self.owner) && !reviver function_7627883ac8601401()) {
      waitframe();
    }

    if(istrue(reviver.insertingarmorplate) && !self.owner scripts\mp\supers\super_stimpistol::function_f0d1c9c39359efff()) {
      reviver notify("try_armor_cancel", "last_stand_reviver_start");

      while(istrue(reviver.insertingarmorplate) && reviver function_f111048fabf84e37(self.owner)) {
        waitframe();
      }
    }

    if(!reviver function_f111048fabf84e37(self.owner)) {
      continue;
    }

    if(getgametype() == "xfire") {
      var_6e672788835fc16b = self.owner getclientomnvar("ui_cutthroat_player_state");

      if(var_6e672788835fc16b != 2 && getgametype() == "xfire") {
        self.owner setclientomnvar("ui_cutthroat_player_state", 2);
        function_5911caad56f963ea(team, 1);
        function_e6ccdf90ba898cdc(team, -1);
      }
    }

    self.owner setbeingrevivedinternal(1);

    if(!self.owner scripts\mp\supers\super_stimpistol::function_f0d1c9c39359efff()) {
      reviver thread scripts\mp\teamrevive::function_c86cf00d5859ce10(self.owner.origin);
    }

    revived = 0;
    self.owner notify("handle_revive_message");
    self makeunusable();

    if(reviver usingtouch()) {
      reviver function_fc1c1e51058904a3(&"MP/LASTSTAND_REVIVE_USE");
    }

    self.owner allowmovement(0);

    if(!self.owner scripts\mp\supers\super_stimpistol::function_f0d1c9c39359efff()) {
      reviver setlaststandreviving(1, 0);
    } else {
      reviver setlaststandreviving(1, 1);
    }

    reviver scripts\cp_mp\laststand::function_d9bd056c79a6077b(self.owner);
    thread useholdthink(reviver);

    if(!self.owner scripts\mp\supers\super_stimpistol::function_f0d1c9c39359efff()) {
      reviver thread switchtoteammatereviveweapon(self.owner);
    }

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
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
    updateusablebyteam(self.owner.team);
    waittillframeend();
  }
}

function function_56e47961499ca06c(team) {
  self.owner endon("disconnect");
  level endon("game_ended");
  var_5bebd2013b0f01ec = self.owner;

  for(;;) {
    self waittill("trigger", interrogator);

    if(interrogator.team == self.owner.team) {
      continue;
    }

    if(interrogator ismeleeing() || interrogator isinexecutionattack()) {
      continue;
    }

    if(istrue(var_5bebd2013b0f01ec getbeingrevivedinternal())) {
      if(istrue(var_5bebd2013b0f01ec.isselfreviving)) {
        var_5bebd2013b0f01ec.var_fa3003648b3c8eac = 1;
        var_5bebd2013b0f01ec setbeingrevivedinternal(0);
        waitframe();
        var_5bebd2013b0f01ec.var_fa3003648b3c8eac = 0;
      } else {
        continue;
      }
    }

    while(!interrogator function_7627883ac8601401() && interrogator function_f111048fabf84e37(var_5bebd2013b0f01ec)) {
      waitframe();
    }

    if(interrogator getstance() != "stand") {
      var_ccbc8f28cb6a19e7 = interrogator setstance("stand", 0, 1);

      if(var_ccbc8f28cb6a19e7) {
        wait 0.4;
      } else {
        interrogator scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/INTERROGATE_BLOCKED_STANCE");
        wait 0.1;
        continue;
      }
    }

    if(istrue(interrogator.insertingarmorplate)) {
      interrogator notify("try_armor_cancel", "interrogation_interrogator_start");

      while(istrue(interrogator.insertingarmorplate) && interrogator function_f111048fabf84e37(var_5bebd2013b0f01ec)) {
        waitframe();
      }
    }

    if(!isreallyalive(interrogator) || !isreallyalive(var_5bebd2013b0f01ec)) {
      continue;
    }

    if(!interrogator function_f111048fabf84e37(interrogator)) {
      continue;
    }

    checkresult = function_f671d7efef879a1(interrogator, var_5bebd2013b0f01ec);

    switch (checkresult) {
      case 4:
        interrogator scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/INTERROGATE_BLOCKED_SWIMMING");
        wait 0.1;
        continue;
      case 0:
      case 1:
      case 2:
        break;
      case 5:
        break;
      default:
        interrogator scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/INTERROGATE_BLOCKED");
        wait 0.1;
        continue;
    }

    interrogator setclientomnvar("ui_tablet_usb", 10);
    interrogator function_4ba85e5091eee483(#"ping_enemy_interrogate", 4);

    if(getdvarint(@ "hash_60a0581926005683", 1) != 0) {
      thread function_b3f5eede669e7182(interrogator, var_5bebd2013b0f01ec);
    }

    var_5bebd2013b0f01ec setbeingrevivedinternal(1);
    var_5bebd2013b0f01ec scripts\mp\gametypes\br_public::function_cc20f0c1304019d9(1);
    interrogator scripts\mp\gametypes\br_public::function_eb28f4724f0f14b(1);
    revived = 0;
    self makeunusable();

    if(interrogator usingtouch()) {
      interrogator function_fc1c1e51058904a3(&"MP/LASTSTAND_INTERROGATE_USE");
    }

    var_5bebd2013b0f01ec.var_21fc661949481ced = scripts\mp\utility\outline::outlineenableforteam(var_5bebd2013b0f01ec, var_5bebd2013b0f01ec.team, "outline_nodepth_orange", "level_script");
    var_5bebd2013b0f01ec allowmovement(0);
    interrogator.var_93018d510a589832 = 1;
    var_5bebd2013b0f01ec.var_895c1aaac16f7256 = 1;
    thread useholdthink(interrogator, undefined, 1);

    if(checkresult == 5) {
      thread function_1d6e0919bcc01c46(interrogator, var_5bebd2013b0f01ec, self.usetime);
      interrogator.var_a3fb93a908cc7f32 = 1;
    } else {
      eyetarget = rotatevector((4.167, -0.186, 39.969), self.owner.angles);
      interrogator thread function_96f2172e98188560(self.owner.origin + eyetarget);
    }

    interrogator thread switchtoteammatereviveweapon(var_5bebd2013b0f01ec, 1);
    thread function_bef121e9cc93f796(interrogator, var_5bebd2013b0f01ec);
    self.owner.laststandreviveent.var_f1da02a134648443 = 4;
    self.owner.laststandreviveent function_4c452a6c72371f17();
    notif = waittill_any_return_no_endon_death_3("use_hold_interrogate_success", "use_hold_interrogate_fail", "death_or_disconnect");

    if(interrogator usingtouch()) {
      interrogator forceusehintoff();
    }

    if(notif == "use_hold_interrogate_success") {
      interrogated = 1;
    } else {
      self.owner.laststandreviveent.var_f1da02a134648443 = 1;
      self.owner.laststandreviveent function_4c452a6c72371f17();
    }

    interrogator notify("finish_victim_interrogation");

    if(notif == "use_hold_interrogate_success" || notif == "use_hold_interrogate_fail") {
      var_5bebd2013b0f01ec notify(notif);
    }

    var_5bebd2013b0f01ec setbeingrevivedinternal(0);
    var_5bebd2013b0f01ec scripts\mp\gametypes\br_public::function_cc20f0c1304019d9(0);
    interrogator scripts\mp\gametypes\br_public::function_eb28f4724f0f14b(0);
    interrogator setclientomnvar("ui_tablet_usb", 0);
    interrogated = var_5bebd2013b0f01ec function_70f1dbc7125939b8(notif, interrogator, self.owner.team);

    if(notif == "use_hold_interrogate_fail") {
      wait 0.25;
    }

    if(!isDefined(self)) {
      return;
    }

    if(istrue(interrogated) && isbot(interrogator)) {
      self makeusable();
    }

    if(istrue(interrogated)) {
      self.count--;

      if(self.count <= 0) {
        if(isDefined(self.owner) && isDefined(self.owner.laststandreviveent)) {
          self.owner.laststandreviveent.var_f1da02a134648443 = 2;
          self.owner.laststandreviveent.var_9d797a762d9195eb = 1;
          self.owner setclientomnvar("ui_br_has_been_interrogated", 1);
          self.owner.laststandreviveent function_4c452a6c72371f17();
        }

        return;
      }
    }

    thread function_1f761672c3708743();
    self makeusable();
    self setuserange(getdvarfloat(@ "hash_6cc46c78f1221930", 100));
    function_2aa6e4d20914e40a(self);
    function_38f5ade989b3848f(self.owner.team);
  }
}

function function_bef121e9cc93f796(interrogator, var_5bebd2013b0f01ec) {
  var_d33a0baa5624a4a = interrogator.team;
  var_ca6fac37f3e2227d = var_5bebd2013b0f01ec.team;
  function_dab2d0f370a19a17(var_d33a0baa5624a4a, var_ca6fac37f3e2227d);
  function_6ffc1d64d4e5832d(interrogator, var_5bebd2013b0f01ec);
  function_a73848ef9a4e7932(var_d33a0baa5624a4a, var_ca6fac37f3e2227d);
}

function function_6ffc1d64d4e5832d(interrogator, var_5bebd2013b0f01ec) {
  level endon("game_ended");
  self endon("use_hold_interrogate_fail");
  self endon("death_or_disconnect");
  var_5bebd2013b0f01ec endon("last_stand_finished");
  var_5bebd2013b0f01ec endon("check_for_plea");
  var_5bebd2013b0f01ec endon("disconnect");
  interrogator waittill("interrogation_signal_lost");
}

function function_dab2d0f370a19a17(var_d33a0baa5624a4a, var_ca6fac37f3e2227d) {
  if(!issharedfuncdefined("teamAssim", "disablePlayer")) {
    return;
  }

  foreach(player in level.teamdata[var_d33a0baa5624a4a]["players"]) {
    [[getsharedfunc("teamAssim", "disablePlayer")]](player, "interrogation_" + self.number);
  }

  foreach(player in level.teamdata[var_ca6fac37f3e2227d]["players"]) {
    [[getsharedfunc("teamAssim", "disablePlayer")]](player, "interrogation_" + self.number);
  }
}

function function_a73848ef9a4e7932(var_d33a0baa5624a4a, var_ca6fac37f3e2227d) {
  if(!issharedfuncdefined("teamAssim", "enablePlayer")) {
    return;
  }

  foreach(player in level.teamdata[var_d33a0baa5624a4a]["players"]) {
    [[getsharedfunc("teamAssim", "enablePlayer")]](player, "interrogation_" + self.number);
  }

  foreach(player in level.teamdata[var_ca6fac37f3e2227d]["players"]) {
    [[getsharedfunc("teamAssim", "enablePlayer")]](player, "interrogation_" + self.number);
  }
}

function switchtoteammatereviveweapon(revivee, interrogation) {
  reviver = self;
  reviver endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(interrogation)) {
    interrogation = 0;
  }

  if(istrue(interrogation)) {
    weaponobj = makeweapon("interrogation_tools_mp");
  } else {
    weaponobj = makeweapon("teammate_revive_stim_mp");
  }

  if(!istrue(reviver.var_a3fb93a908cc7f32)) {
    reviver _giveweapon(weaponobj, 0, 0, 0);
    reviver thread function_4a81a13950a6021d(weaponobj);
  }

  reviver thread watchfordeathwhilereviving();
  reviver thread watchforteammatedeathwhilereviving(revivee);
  reviver thread watchforteammaterevivedwhilereviving(revivee);

  if(!istrue(reviver.var_a3fb93a908cc7f32)) {
    switchresult = domonitoredweaponswitch(weaponobj, isbot(reviver));

    if(!istrue(switchresult)) {
      return;
    }

    reviver val::set("last_stand_weapon_switch", "weapon_switch", 0);
  }

  if(isDefined(reviver.var_a3fb93a908cc7f32)) {
    reviver.var_a3fb93a908cc7f32 = undefined;
  }
}

function private function_4a81a13950a6021d(weaponobj) {
  reviver = self;
  level endon("game_ended");
  reviver teammatereviveweaponwaitputaway();

  if(isDefined(reviver)) {
    restorelastweapon = 1;

    if(!reviver scripts\cp_mp\utility\player_utility::_isalive() || isinlaststand(reviver)) {
      restorelastweapon = 0;
    }

    reviver thread function_1d21f6e823b18aa8(weaponobj, restorelastweapon);
  }
}

function private function_1d21f6e823b18aa8(weaponobj, restorelastweapon) {
  reviver = self;
  reviver endon("disconnect");
  level endon("game_ended");
  reviver val::reset_all("last_stand_weapon_switch");
  reviver notify("revive_stim_finished");

  if(reviver isswitchingtoweaponwithmonitoring(weaponobj)) {
    reviver abortmonitoredweaponswitch(weaponobj);
  } else {
    reviver _takeweapon(weaponobj);
  }

  if(istrue(restorelastweapon)) {
    switchresult = reviver domonitoredweaponswitch(reviver.lastdroppableweaponobj, isbot(reviver));
    currentweapon = reviver getcurrentweapon();

    if(currentweapon.basename == "none") {
      reviver forcevalidweapon();
    }
  }
}

function teammatereviveweaponwaitputaway(streakinfo) {
  reviver = self;
  level endon("game_ended");

  if(!istrue(reviver.revivingteammate) && !istrue(reviver.var_93018d510a589832)) {
    if(false) {
      breviving = ter_op(istrue(reviver.revivingteammate), 1, 0);
      var_6c0402dbf33cc28a = ter_op(istrue(reviver.var_93018d510a589832), 1, 0);
      println("<dev string:xf4>" + breviving + "<dev string:x142>" + var_6c0402dbf33cc28a);
    }

    return;
  }

  if(false) {
    println("<dev string:x161>" + gettime());
  }

  var_fa7c7b71dc2c9cb0 = ["death_or_disconnect", "finish_buddy_reviving", "last_stand_start", "finish_victim_interrogation"];
  reviver waittill_any_in_array_return_no_endon_death(var_fa7c7b71dc2c9cb0);

  if(false) {
    println("<dev string:x199>" + gettime());
  }
}

function watchfordeathwhilereviving() {
  if(false) {
    println("<dev string:x1cf>" + gettime());
  }

  reviver = self;
  reviver endon("finish_buddy_reviving");
  reviver endon("finish_victim_interrogation");
  reviver endon("disconnect");
  level endon("game_ended");
  reviver waittill("death");
  reviver notify("finish_buddy_reviving");
}

function watchforteammatedeathwhilereviving(revivee) {
  if(false) {
    println("<dev string:x1fe>" + gettime());
  }

  reviver = self;
  reviver endon("finish_buddy_reviving");
  reviver endon("finish_victim_interrogation");
  reviver endon("death_or_disconnect");
  level endon("game_ended");
  revivee waittill_any_2("death_or_disconnect", "enter_live_ragdoll");
  reviver notify("finish_buddy_reviving");
}

function watchforteammaterevivedwhilereviving(revivee) {
  if(false) {
    println("<dev string:x235>" + gettime());
  }

  reviver = self;
  reviver endon("finish_buddy_reviving");
  reviver endon("finish_victim_interrogation");
  reviver endon("death_or_disconnect");
  level endon("game_ended");
  revivee waittill("last_stand_revived");
  reviver notify("finish_buddy_reviving");
}

function function_788452276786dcc7() {
  revivee = self;

  if(!isPlayer(revivee)) {
    return;
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  var_98422a847a5a36b3 = getdvarint(@ "hash_fa3a2702c11c396c", 0) == 1;

  if(!var_98422a847a5a36b3) {
    return;
  }

  revivee endon("death_or_disconnect");
  revivee endon("last_stand_revived");

  if(!isai(revivee)) {
    revivee notifyonplayercommand("stanceChangePressed", "+stancedown");
    revivee notifyonplayercommand("stanceChangePressed", "+movedown");
    revivee notifyonplayercommand("stanceChangePressed", "+prone");
    revivee notifyonplayercommand("stanceChangePressed", "+stance");
    revivee notifyonplayercommand("stanceChangePressed", "+togglecrouch");
    revivee notifyonplayercommand("stanceChangeReleased", "-stancedown");
    revivee notifyonplayercommand("stanceChangeReleased", "-movedown");
    revivee notifyonplayercommand("stanceChangeReleased", "-prone");
    revivee notifyonplayercommand("stanceChangeReleased", "-stance");
    revivee notifyonplayercommand("stanceChangeReleased", "-togglecrouch");
  }

  for(;;) {
    revivee waittill("stanceChangePressed");
    timestarted = gettime();
    revivee waittill("stanceChangeReleased");
    durationheld = gettime() - timestarted;
    tap_threshold = 350;

    if(durationheld < tap_threshold) {
      function_fc2445a76915f9e7(revivee);
    }
  }
}

function function_fc2445a76915f9e7(revivee) {
  revivee.var_84649776f0d63667 = !istrue(revivee.var_84649776f0d63667);
  willprone = istrue(revivee.var_84649776f0d63667);
  stancetext = ter_op(willprone, "MP_BR_INGAME/WILL_REVIVE_INTO_PRONE", "MP_BR_INGAME/WILL_REVIVE_INTO_CROUCH");
  revivee scripts\mp\hud_message::showerrormessage(stancetext);
}

function finishreviveplayer(notifymsg, reviver) {
  revivee = self;
  revived = 0;

  if(!isDefined(revivee) || !isalive(revivee)) {
    return 0;
  }

  if(notifymsg == "use_hold_revive_success" || notifymsg == "self_revive_on_kill_success" || notifymsg == "self_revive_success") {
    revived = 1;
  }

  if(getgametype() == "xfire") {
    var_6e672788835fc16b = self getclientomnvar("ui_cutthroat_player_state");

    if(var_6e672788835fc16b == 2) {
      function_5911caad56f963ea(revivee.team, -1);

      if(notifymsg == "use_hold_revive_fail") {
        self setclientomnvar("ui_cutthroat_player_state", 1);
        function_e6ccdf90ba898cdc(revivee.team, 1);
      } else if(istrue(revived)) {
        self setclientomnvar("ui_cutthroat_player_state", 0);
      } else {
        self setclientomnvar("ui_cutthroat_player_state", 3);
      }
    }
  }

  revivee.isselfreviving = 0;
  revivee setbeingrevivedinternal(0);

  if(notifymsg == "self_revive_success") {
    revivee selfrevivingdoneanimevent();
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    revivee scripts\mp\gametypes\br_public::setplayerbeingrevivedextrainfo(0);
    revivee scripts\mp\gametypes\br_public::setplayerselfrevivingextrainfo(0);
  }

  revivee allowmovement(1);

  if(revived) {
    revivee setlowermessageomnvar("clear_lower_msg");
    revivee notify("last_stand_revived");
    self.fastcrouchspeedmod = 0;
    scripts\mp\weapons::updatemovespeedscale();

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      if(!istrue(level.gameended)) {
        revivee scripts\mp\gametypes\br_public::setplayerdownedextrainfo(0);
        scripts\mp\events::revivedplayer(reviver, revivee);
        scripts\cp_mp\challenges::onlaststandrevive(reviver, revivee);
        revivee scripts\cp_mp\challenges::startchallengetimer("alive_not_downed");

        if(reviver != revivee) {
          reviver scripts\mp\utility\stats::incpersstat("rescues", 1);
          reviver scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(17, 1);
          revivee scripts\mp\utility\stats::incpersstat("rescued", 1);
        }

        revivee.deathsdoorsfx = 0;
        revivee scripts\common\damage_effects::onexitdeathsdoor(1);
      }

      if(!scripts\mp\gametypes\br_public::istutorial()) {
        setting = getdvarint(@ "hash_60fa486ada22dba2", 0);

        switch (setting) {
          case 1:
            revivee playsoundtoteam("br_player_revived", revivee.team, undefined, self);
            break;
          case 2:
            playsoundatpos(revivee.origin, "br_player_revived");
            break;
          case 0:
          default:
            break;
        }
      }

      if(isDefined(self.laststandoutlineid)) {
        scripts\mp\utility\outline::outlinedisable(self.laststandoutlineid, self);
        self.laststandoutlineid = undefined;
      }
    }

    if(reviver != revivee) {
      reviver playlocalsound("jup_revive_teammate_sucess");

      if(revivee.team == reviver.team) {
        if(function_7ba31cb6b21c346f()) {
          revivee thread function_36edf91561322753(2);
        } else {
          level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, #"bc_status_player_revived");
        }
      } else {
        level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, #"bc_status_player_revived_hostile");
      }
    } else {
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, #"bc_status_player_selfrevived");
    }

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      var_e95cd93fdb0f51a8 = "crouch";

      if(istrue(self.var_84649776f0d63667)) {
        var_e95cd93fdb0f51a8 = "prone";
      }

      self.var_84649776f0d63667 = undefined;
      var_ccbc8f28cb6a19e7 = revivee setstance(var_e95cd93fdb0f51a8);

      if(!var_ccbc8f28cb6a19e7) {
        var_82ee04dfa5b600e1 = var_e95cd93fdb0f51a8 == "crouch";
        var_ccbc8f28cb6a19e7 = revivee setstance(ter_op(var_82ee04dfa5b600e1, "prone", "crouch"));
      }
    }

    revivee.var_63b104851a574f2a = reviver;

    if(reviver != revivee) {
      thread scripts\cp_mp\talking_gun::function_bd70b31dd13292bc(reviver);
      thread scripts\cp_mp\talking_gun::function_bd70a21dd1326d59(revivee);
    }
  }

  revivee takelaststandtransitionweapon();
  revivee thread function_78d588e2e4cbda39();

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    revivee thread function_a3a340a5d9222a17();
  }

  return revived;
}

function function_78d588e2e4cbda39() {
  self endon("death_or_disconnect");

  if(level.gametype != "br") {
    return;
  }

  val::set("laststand", "offhand_secondary_weapons", 0);

  while(self isthrowingbackgrenade()) {
    self.var_47f9a068df7c5418 = 1;
    self giveandfireoffhand("rock_mp");
    wait 1;
  }

  val::set("laststand", "offhand_secondary_weapons", 1);
}

function function_a3a340a5d9222a17() {
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
  var_5bebd2013b0f01ec = self;
  interrogated = 0;

  if(!isDefined(var_5bebd2013b0f01ec) || !isalive(var_5bebd2013b0f01ec)) {
    return 0;
  }

  self.fastcrouchspeedmod = 0;
  scripts\mp\weapons::updatemovespeedscale();

  if(notifymsg == "use_hold_interrogate_success") {
    interrogated = 1;
  }

  var_5bebd2013b0f01ec.var_895c1aaac16f7256 = 0;
  scripts\mp\utility\outline::outlinedisable(var_5bebd2013b0f01ec.var_21fc661949481ced, var_5bebd2013b0f01ec);
  var_5bebd2013b0f01ec allowmovement(1);

  if(interrogated) {
    var_5bebd2013b0f01ec setlowermessageomnvar("clear_lower_msg");
    var_5bebd2013b0f01ec notify("last_stand_interrogated");

    if(isDefined(self.laststandoutlineid)) {
      scripts\mp\utility\outline::outlinedisable(self.laststandoutlineid, self);
      self.laststandoutlineid = undefined;
    }

    interrogator scripts\mp\utility\stats::incpersstat("interrogations", 1);
    interrogator thread function_1b56d7c4fe15b79c(interrogator, var_5bebd2013b0f01ec);
    objweapon = makeweapon("interrogation_tools_mp");
    obituary(var_5bebd2013b0f01ec, interrogator, objweapon, "MOD_INTERROGATE", level.teamdata[interrogator.team]["alivePlayers"]);
    obituary(var_5bebd2013b0f01ec, interrogator, objweapon, "MOD_INTERROGATE", level.teamdata[var_5bebd2013b0f01ec.team]["alivePlayers"]);

    foreach(teammate in level.teamdata[interrogator.team]["alivePlayers"]) {
      if(!isDefined(teammate)) {
        continue;
      }

      var_9b042f0ef4a15a40 = interrogator getentitynumber();
      teammate thread scripts\mp\hud_message::showsplash("br_enemy_interrogated_center", var_9b042f0ef4a15a40, interrogator);
    }

    foreach(teammate in level.teamdata[var_5bebd2013b0f01ec.team]["alivePlayers"]) {
      if(!isDefined(teammate)) {
        continue;
      }

      var_fbc3739d54c0a83f = var_5bebd2013b0f01ec getentitynumber();
      teammate thread scripts\mp\hud_message::showsplash("br_teammate_interrogated_center", var_fbc3739d54c0a83f, var_5bebd2013b0f01ec);
    }

    var_5bebd2013b0f01ec playSound("br_player_interrogated_enemy");
    function_b37595afabefa038(interrogator, var_5bebd2013b0f01ec);
  }

  return interrogated;
}

function function_b37595afabefa038(interrogator, var_5bebd2013b0f01ec) {
  var_e6df16e26edacea = getdvarint(@ "hash_2e92604af6208d28", 0);

  if(var_e6df16e26edacea != 0) {
    var_257077ad57a19a9b = 0;

    if(var_e6df16e26edacea == 1 || var_e6df16e26edacea == 3) {
      var_257077ad57a19a9b += getdvarint(@ "hash_d856d9dc9669c4f2", 100);
    }

    if(var_e6df16e26edacea == 2 || var_e6df16e26edacea == 3) {
      if(isDefined(var_5bebd2013b0f01ec.plundercount) && var_5bebd2013b0f01ec.plundercount > 0) {
        var_fb2196e070a5d84e = var_5bebd2013b0f01ec.plundercount;
        rewardpercent = getdvarfloat(@ "hash_97e42d15f6dd7208", 0.2);
        var_257077ad57a19a9b += int(var_fb2196e070a5d84e * rewardpercent);
        var_a356a7a2d1d5b890 = int(var_fb2196e070a5d84e - var_fb2196e070a5d84e * rewardpercent);
        var_5bebd2013b0f01ec scripts\mp\gametypes\br_plunder::playersetplundercount(var_a356a7a2d1d5b890);
      }
    }

    lootid = level.br_pickups.var_7b2bff2d04ee1017["brloot_plunder_cash_uncommon_1"];

    if(isDefined(lootid)) {
      view_origin = interrogator getvieworigin();
      interrogator scripts\mp\gametypes\br_pickups::function_37be6e543436f3b3(lootid, view_origin, 1, var_257077ad57a19a9b);
    }

    interrogator scripts\mp\gametypes\br_plunder::playerplunderpickup(var_257077ad57a19a9b);
    interrogator scripts\mp\gametypes\br_plunder::function_5a2284274d70f7d(0, var_257077ad57a19a9b);
    var_3466c10973e9c476 = scripts\mp\gametypes\br_plunder::getplundernamebyamount(var_257077ad57a19a9b);
    pickup_sfx = scripts\mp\gametypes\br_pickups::getcashsoundaliasforplayer(interrogator, var_3466c10973e9c476);
    playsoundatpos(var_5bebd2013b0f01ec.origin, pickup_sfx);
    return;
  }

  if(level.var_a9978096255cd8ed == 1) {
    if(isDefined(var_5bebd2013b0f01ec.plundercount) && var_5bebd2013b0f01ec.plundercount > 0) {
      var_fb2196e070a5d84e = var_5bebd2013b0f01ec.plundercount;
      rewardpercent = level.var_201395ee05e5c10d;
      plundertaken = int(var_fb2196e070a5d84e * rewardpercent);
      var_a356a7a2d1d5b890 = var_fb2196e070a5d84e - plundertaken;
      var_257077ad57a19a9b = interrogator.plundercount + plundertaken;
      interrogator scripts\mp\gametypes\br_plunder::playersetplundercount(var_257077ad57a19a9b);
      var_5bebd2013b0f01ec scripts\mp\gametypes\br_plunder::playersetplundercount(var_a356a7a2d1d5b890);
    }
  }
}

function decayreviveprogress() {
  self.owner endon("last_stand_finished");
  self.owner endon("last_stand_heal_active");
  self.owner endon("disconnect");
  self endon("use_hold_revive_start");
  self endon("use_hold_interrogate_start");
  self endon("self_revive_start");
  self endon("death");
  level endon("game_ended");
  decayscale = level.laststandrevivedecayscale;

  if(!isusingmatchrulesdata()) {
    decayscale = getwatcheddvar("<dev string:x26e>");

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

function function_1f761672c3708743() {
  if(getdvarint(@ "hash_b12dfd71b2d623af", 0)) {
    decayreviveprogress();
    return;
  }

  self.curprogress = 0;
}

function function_1b56d7c4fe15b79c(interrogator, victim) {
  level endon("game_ended");
  var_864c4c4116d403ea = interrogator.matchdatalifeindex;
  var_68fa2b6918f6e714 = victim.matchdatalifeindex;
  interrogationrange = getdvarfloat(@ "hash_6acfbd4650e8691f", 300);
  pingduration = getdvarfloat(@ "hash_a8e0e2bf5a22916c", 5);
  var_74aab602082bb02b = int(pingduration * 1000);
  lastpingtime = 0;
  var_4f8e6f961392009f = gettime();
  finalstatus = 99;
  var_6562c7c3c91a0c6a = 0;
  victimteam = victim.team;
  var_d33a0baa5624a4a = interrogator.team;
  var_26568fed2b866c11 = level.teamdata[victimteam]["players"];
  victimid = victim getuniqueid();
  var_4ec493e39340a7ce = interrogator getuniqueid();

  if(!isDefined(victimid)) {
    victimid = victim.clientid;
  }

  if(!isDefined(var_4ec493e39340a7ce)) {
    var_4ec493e39340a7ce = interrogator.clientid;
  }

  rewardtype = getdvarint(@ "hash_3c56d9ef17112cdd", 3);

  if(rewardtype == 2) {
    victim.interrogationrevivetime = undefined;
  }

  wait 2;
  thread function_38526ff55909d928(interrogator, victim);

  foreach(player in var_26568fed2b866c11) {
    if(isDefined(player.plantedlethalequip)) {
      var_6562c7c3c91a0c6a += player.plantedlethalequip.size;
    }
  }

  function_7fac7bee548fbdd8(var_d33a0baa5624a4a, victimteam, victimid);
  breakloop = 0;

  while(breakloop == 0) {
    var_c3b838deb5a442d4 = 2;

    if(isDefined(interrogator) && isDefined(victim)) {
      var_c3b838deb5a442d4 = distance2d(interrogator.origin, victim.origin) / interrogationrange;
    }

    switch (rewardtype) {
      case 1:
        breakloop = function_8924785604554899(interrogator, victim);
        break;
      case 3:
        breakloop = function_b4c6cb65b8221e77(interrogator, victim, var_4f8e6f961392009f + 2000);
        break;
      case 2:
        if(!isDefined(victim.laststanddowneddata) && !isDefined(victim.interrogationrevivetime)) {
          victim.interrogationrevivetime = gettime();
        }

        breakloop = function_59db0668402ef9d0(interrogator, victim);
        break;
      case 4:
        breakloop = function_2916fc520c1ada8d(interrogator, victim, var_4f8e6f961392009f + 2000);
        break;
      case 0:
      default:
        breakloop = function_d5bce40589690efb(interrogator, victim, var_c3b838deb5a442d4);
        break;
    }

    if(breakloop) {
      interrogator notify("interrogation_signal_lost");
      function_8f5cf57cb69d0df5(var_d33a0baa5624a4a, victimteam, victimid);

      if(isDefined(victim) && isDefined(victim.laststandreviveent)) {
        victim.laststandreviveent.var_f1da02a134648443 = 3;
        victim.laststandreviveent function_4c452a6c72371f17();
      }

      break;
    }

    if(getdvarint(@ "hash_2ae289b7c1cdeffe", 0)) {
      color = (0, 1, 0);

      if(var_c3b838deb5a442d4 > 0.7) {
        color = (1, 0, 0);
      } else if(var_c3b838deb5a442d4 > 0.4) {
        color = (1, 1, 0);
      }

      draw_circle(victim.origin, interrogationrange, color, 1, 1, 1);
    }

    if(lastpingtime + var_74aab602082bb02b < gettime()) {
      var_26568fed2b866c11 = array_removeundefined(var_26568fed2b866c11);

      foreach(player in var_26568fed2b866c11) {
        if(!isalive(player)) {
          continue;
        }

        if(!player scripts\mp\utility\perk::_hasperk("specialty_snapshot_immunity")) {
          player thread function_da121b53657256c7(interrogator, pingduration);

          if(getdvarint(@ "hash_a77cf11d23a937f4", 0) == 1) {
            player thread function_f8b195391ced24fc(interrogator, pingduration);
          } else {
            player thread function_980d4a9e760f8e0e(interrogator, pingduration);
          }

          player function_8b6cb3c86797ead5(interrogator, pingduration);
          continue;
        }

        interrogator scripts\cp_mp\damagefeedback::updatedamagefeedback("hittacresist");
      }

      lastpingtime = gettime();
    }

    waitframe();
  }

  var_126c5ba5e88a23b7 = int(gettime() - var_4f8e6f961392009f);
  scripts\mp\analyticslog::function_b4e1d087442647ef(var_864c4c4116d403ea, var_68fa2b6918f6e714, var_26568fed2b866c11.size, int(var_6562c7c3c91a0c6a), var_126c5ba5e88a23b7, breakloop);

  if(isDefined(interrogator)) {
    scripts\mp\gametypes\br_analytics::function_3461c9a3dbbccecf(interrogator, var_126c5ba5e88a23b7, string(var_6562c7c3c91a0c6a));
  }

  if(isDefined(victim)) {
    scripts\mp\gametypes\br_analytics::function_82b50d847253078f(victim, var_26568fed2b866c11.size);
  }
}

function function_38526ff55909d928(attacker, victim) {
  level endon("game_ended");

  if(!isDefined(victim) || !isDefined(attacker)) {
    return;
  }

  var_122194ceec0993a8 = level._effect["vfx_br_interr_in"];
  playfxontagforclients(var_122194ceec0993a8, victim, "tag_origin", attacker);
  playfxontagforclients(var_122194ceec0993a8, victim, "tag_origin", victim);
  waittill_any_ents(attacker, "interrogation_signal_lost", attacker, "death_or_disconnect", victim, "death_or_disconnect", victim, "last_stand_finished", victim, "enter_live_ragdoll");
  killfxontag(var_122194ceec0993a8, victim, "tag_origin");
}

function function_7fac7bee548fbdd8(var_d33a0baa5624a4a, victimteam, victimuid) {
  var_26568fed2b866c11 = level.teamdata[victimteam]["players"];
  var_ccba29fa2a3a27ff = level.teamdata[var_d33a0baa5624a4a]["players"];

  foreach(player in var_26568fed2b866c11) {
    if(!isDefined(player.var_50a75a4bfa03a8e2)) {
      player.var_50a75a4bfa03a8e2 = [];
    }

    player.var_50a75a4bfa03a8e2 = function_6d6af8144a5131f1(player.var_50a75a4bfa03a8e2, victimuid);
    player setclientomnvar("ui_br_interrogate_team_is_being_tracked", 1);
  }

  foreach(player in var_ccba29fa2a3a27ff) {
    if(!isDefined(player.var_8d021ab39b012f9d)) {
      player.var_8d021ab39b012f9d = [];
    }

    player.var_8d021ab39b012f9d = function_6d6af8144a5131f1(player.var_8d021ab39b012f9d, victimuid);
    player setclientomnvar("ui_br_interrogate_tracking_other_team", 1);
  }
}

function function_8f5cf57cb69d0df5(var_d33a0baa5624a4a, victimteam, victimuid) {
  var_26568fed2b866c11 = level.teamdata[victimteam]["players"];
  var_ccba29fa2a3a27ff = level.teamdata[var_d33a0baa5624a4a]["players"];

  foreach(player in var_26568fed2b866c11) {
    if(!isDefined(player.var_50a75a4bfa03a8e2)) {
      player.var_50a75a4bfa03a8e2 = [];
    }

    player.var_50a75a4bfa03a8e2 = array_remove(player.var_50a75a4bfa03a8e2, victimuid);

    if(player.var_50a75a4bfa03a8e2.size > 0) {
      player setclientomnvar("ui_br_interrogate_team_is_being_tracked", 1);
      continue;
    }

    player setclientomnvar("ui_br_interrogate_team_is_being_tracked", 0);
  }

  foreach(player in var_ccba29fa2a3a27ff) {
    if(!isDefined(player.var_8d021ab39b012f9d)) {
      player.var_8d021ab39b012f9d = [];
    }

    player.var_8d021ab39b012f9d = array_remove(player.var_8d021ab39b012f9d, victimuid);

    if(player.var_8d021ab39b012f9d.size > 0) {
      player setclientomnvar("ui_br_interrogate_tracking_other_team", 1);
      continue;
    }

    player setclientomnvar("ui_br_interrogate_tracking_other_team", 0);
  }
}

function function_d5bce40589690efb(interrogator, victim, var_c3b838deb5a442d4) {
  if(!isDefined(victim) || !isreallyalive(victim)) {
    return 1;
  }

  if(!isinlaststand(victim)) {
    return 2;
  }

  if(!isDefined(interrogator) || !isreallyalive(interrogator)) {
    return 3;
  }

  if(var_c3b838deb5a442d4 > 1) {
    return 4;
  }

  return 0;
}

function function_8924785604554899(interrogator, victim) {
  if(!isDefined(interrogator) || !isreallyalive(interrogator)) {
    return 3;
  }

  if(!isinlaststand(victim)) {
    return 2;
  }

  if(!isDefined(victim) || !isreallyalive(victim)) {
    return 1;
  }

  return 0;
}

function function_59db0668402ef9d0(interrogator, victim) {
  if(!isDefined(interrogator) || !isreallyalive(interrogator)) {
    return 3;
  }

  graceperiodover = 0;

  if(isDefined(victim.interrogationrevivetime)) {
    duration = int(getdvarint(@ "hash_c1469be98181753d", 15) * 1000);
    graceperiodover = gettime() > victim.interrogationrevivetime + duration;
  }

  if(!isinlaststand(victim) && graceperiodover) {
    return 2;
  }

  if((!isDefined(victim) || !isreallyalive(victim)) && graceperiodover) {
    return 1;
  }

  return 0;
}

function function_b4c6cb65b8221e77(interrogator, victim, starttime) {
  if(!isDefined(interrogator) || !isreallyalive(interrogator)) {
    return 3;
  }

  duration = int(getdvarint(@ "hash_c1469be98181753d", 15) * 1000);
  graceperiodover = gettime() > starttime + duration;

  if(!isinlaststand(victim) && graceperiodover) {
    return 2;
  }

  if((!isDefined(victim) || !isreallyalive(victim)) && graceperiodover) {
    return 1;
  }

  return 0;
}

function function_2916fc520c1ada8d(interrogator, victim, starttime) {
  if(!isDefined(interrogator) || !isreallyalive(interrogator)) {
    return 3;
  }

  duration = int(getdvarint(@ "hash_c1469be98181753d", 15) * 1000);

  if(gettime() > starttime + duration) {
    return 4;
  }

  return 0;
}

function function_f671d7efef879a1(attacker, victim) {
  if(getdvarint(@ "hash_53c1b57d852a5efc", 0)) {
    return 5;
  }

  if(getdvarint(@ "hash_985260dbcc2b00f8", 0)) {
    return 0;
  }

  if(attacker isswimming() || victim isswimming()) {
    return 4;
  }

  var_f22d5402740e9b35 = attacker getmovingplatformparent();
  platformvictim = victim getmovingplatformparent();

  if(isDefined(var_f22d5402740e9b35) || isDefined(platformvictim)) {
    return 2;
  }

  if(abs(attacker.origin[2] - victim.origin[2]) > 30) {
    return 1;
  }

  dir = function_16f1ed28a559f91f(attacker, victim);
  [var_691d365a2045e893, var_67d8ddf901f65b1d, offsetorigindefender, var_439ae466e036ac7d] = function_341c7024a3e54638(dir, victim, attacker);
  attackerpos = victim.origin + var_691d365a2045e893;
  var_67d8ddf901f65b1d = (0, var_67d8ddf901f65b1d[1], 0);
  ignoreents = [attacker, victim];

  if(!attacker scripts\engine\trace::player_trace_passed(attacker.origin + (0, 0, 10), attackerpos + (0, 0, 10), var_67d8ddf901f65b1d, ignoreents)) {
    return 0;
  }

  return 5;
}

function function_a5c6dc149afb51c9(interrogator, outlinetime) {
  self endon("disconnect");
  level endon("game_ended");
  victim = self;

  if(isPlayer(victim)) {
    if(isDefined(victim.painted) && victim.painted == 1) {
      return;
    }

    var_5283d6ed761e8022 = 2000;

    if(istrue(victim.var_89e94d8f0846d342)) {
      var_5283d6ed761e8022 = 500;
    }

    if(!isDefined(outlinetime)) {
      outlinetime = 5;
    }

    victim.painted = 1;
    paintpulse = 0;

    while(paintpulse < level.var_3908273e5522e91d) {
      if(!level.teambased) {
        id = scripts\mp\utility\outline::outlineenableforplayer(victim, interrogator, "outlinefill_nodepth_red", "equipment");
      } else if(scripts\cp_mp\utility\squad_utility::shouldmodesetsquads()) {
        id = scripts\mp\utility\outline::outlineenableforsquad(victim, interrogator.team, interrogator.sessionsquadid, "outlinefill_nodepth_red", "equipment");
      } else {
        id = scripts\mp\utility\outline::outlineenableforteam(victim, interrogator.team, "outlinefill_nodepth_red", "equipment");
      }

      triggerportableradarpingteam(victim.origin, interrogator.team, level.var_575cb25b5d41b53, int(var_5283d6ed761e8022));
      victim iprintlnbold("You are compromised!");
      result = victim waittill_any_timeout_1(outlinetime, "death");

      if(result == "death") {
        scripts\mp\utility\outline::outlinedisable(id, victim);
        victim.painted = 0;
        return;
      }

      scripts\mp\utility\outline::outlinedisable(id, victim);
      paintpulse++;
      wait 1;
    }

    victim.painted = 0;
  }
}

function function_da121b53657256c7(interrogator, pingtime) {
  victim = self;

  if(isPlayer(victim)) {
    if(isDefined(victim.painted) && victim.painted == 1) {
      return;
    }

    var_5283d6ed761e8022 = pingtime * 1000;
    radartype = getdvarint(@ "hash_de39bef0e704c70b", 1);

    if(radartype == 0) {
      return;
    }

    switch (radartype) {
      case 3:
        break;
      case 2:
        var_5283d6ed761e8022 = int(var_5283d6ed761e8022 * 0.75);
        break;
      case 1:
      default:
        var_5283d6ed761e8022 = int(var_5283d6ed761e8022 * 0.25);
        break;
    }

    triggerportableradarpingteam(victim.origin, interrogator.team, level.var_575cb25b5d41b53, int(var_5283d6ed761e8022));
  }
}

function function_f8b195391ced24fc(interrogator, waittime) {
  victim = self;

  if(!isDefined(victim)) {
    return;
  }

  if(isPlayer(victim)) {
    if(isDefined(victim.interrogationmarked) && victim.interrogationmarked == 1) {
      return;
    }

    victim.marked = 1;
    wallstype = getdvarint(@ "hash_cc42e9e3eb814f82", 1);

    if(wallstype == 0) {
      return;
    }

    if(!isDefined(waittime)) {
      waittime = 2.5;
    }

    switch (wallstype) {
      case 3:
        break;
      case 2:
        waittime *= 0.75;
        break;
      case 1:
      default:
        waittime *= 0.25;
        break;
    }

    icon = victim thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(interrogator.team, "hud_icon_new_marked", 8, 1, 5000, 500, undefined, 1, 1);
    victim scripts\cp_mp\killstreaks\recon_drone::function_fa08d1d78cf5cb01();
    victim thread function_80dc9867bc1b31f8(icon, waittime);
  }
}

function function_80dc9867bc1b31f8(icon, waittime) {
  level endon("game_ended");
  self endon("disconnect");
  waittill_notify_or_timeout("death", waittime);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);
  self.interrogationmarked = 0;
}

function function_980d4a9e760f8e0e(interrogator, outlinetime) {
  victim = self;

  if(!isDefined(victim)) {
    return;
  }

  if(isPlayer(victim)) {
    if(isDefined(victim.painted) && victim.painted == 1) {
      return;
    }

    wallstype = getdvarint(@ "hash_cc42e9e3eb814f82", 1);

    if(wallstype == 0) {
      return;
    }

    if(!isDefined(outlinetime)) {
      outlinetime = 2.5;
    }

    switch (wallstype) {
      case 3:
        break;
      case 2:
        outlinetime *= 0.75;
        break;
      case 1:
      default:
        outlinetime *= 0.25;
        break;
    }

    victim.painted = 1;

    if(!level.teambased) {
      id = scripts\mp\utility\outline::outlineenableforplayer(victim, interrogator, "outlinefill_nodepth_orange", "equipment");
    } else if(scripts\cp_mp\utility\squad_utility::shouldmodesetsquads()) {
      id = scripts\mp\utility\outline::outlineenableforsquad(victim, interrogator.team, interrogator.sessionsquadid, "outlinefill_nodepth_orange", "equipment");
    } else {
      id = scripts\mp\utility\outline::outlineenableforteam(victim, interrogator.team, "outlinefill_nodepth_orange", "equipment");
    }

    victim scripts\mp\utility\outline::_hudoutlineviewmodelenable("outlinefill_nodepth_orange", 0);
    victim scripts\cp_mp\killstreaks\recon_drone::function_fa08d1d78cf5cb01();
    victim thread watchpainted(id, outlinetime);
    victim thread watchpaintedagain(id);
  }
}

function function_8b6cb3c86797ead5(interrogator, outlinetime) {
  victim = self;

  if(isPlayer(victim)) {
    if(!isDefined(outlinetime)) {
      outlinetime = 5;
    }

    if(!isDefined(victim.plantedlethalequip) || victim.plantedlethalequip.size == 0) {
      return;
    }

    foreach(equipment in array_removeundefined(victim.plantedlethalequip)) {
      if(!level.teambased) {
        equipmentid = scripts\mp\utility\outline::outlineenableforplayer(equipment, interrogator, "outlinefill_nodepth_orange", "equipment");
      } else if(scripts\cp_mp\utility\squad_utility::shouldmodesetsquads()) {
        equipmentid = scripts\mp\utility\outline::outlineenableforsquad(equipment, interrogator.team, interrogator.sessionsquadid, "outlinefill_nodepth_orange", "equipment");
      } else {
        equipmentid = scripts\mp\utility\outline::outlineenableforteam(equipment, interrogator.team, "outlinefill_nodepth_orange", "equipment");
      }

      equipment thread watchpainted(equipmentid, outlinetime);
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
  scripts\mp\utility\outline::outlinedisable(id, self);

  if(isDefined(self) && isPlayer(self)) {
    self.painted = 0;
    scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
  }

  if(isDefined(self)) {
    self notify("painted_end");
  }
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

  self.lastvaliduser = reviver;
  revivee = self.owner;
  var_6a1154c8bc126a40 = getdvarint(@ "hash_c959af6f995bf79a");
  revivespot = spawn("script_origin", self.origin);
  revivespot hide();

  if(!var_6a1154c8bc126a40 && !self.owner scripts\mp\supers\super_stimpistol::function_f0d1c9c39359efff()) {
    reviver val::group_set("laststand_revive", 0);
  }

  if(istrue(interrogation)) {
    self notify("use_hold_interrogate_start");
  } else {
    self notify("use_hold_revive_start");
  }

  if(!self.owner scripts\mp\supers\super_stimpistol::function_f0d1c9c39359efff() && !interrogation) {
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
  }

  if(!interrogation) {
    if(reviver _hasperk("specialty_medic")) {
      self.usetime = getwatcheddvar("lastStandReviveTimer") * 1000 * getdvarfloat(@ "hash_6f08a22fd52e004c");
    } else {
      self.usetime = getwatcheddvar("lastStandReviveTimer") * 1000;
    }

    if(revivee _hasperk("specialty_survivor") && isDefined(level.survivorrevivetime)) {
      self.usetime = level.survivorrevivetime;
    }

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && reviver _hasperk("specialty_br_faster_revive")) {
      self.usetime *= 0.75;
    }
  } else {
    self.usetime = getdvarfloat(@ "hash_ddbf6f11fc2231f2", 3) * 1000;
  }

  if(!interrogation) {
    if(revivee.team == reviver.team) {
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(reviver, #"bc_status_action_reviving");
    } else {
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(reviver, #"bc_status_action_reviving_hostile");
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

  if(getdvarint(@ "hash_8961da4992114762", 0) != 0 && interrogation && notif == "<dev string:x288>") {
    notif = "<dev string:x29f>";
  }

  vehicleplatform = reviver scripts\cp_mp\vehicles\vehicle_occupancy::function_2e8745a2d6ec9fd1();

  if(isDefined(vehicleplatform)) {
    level thread scripts\cp_mp\vehicles\vehicle::vehicle_preventplayercollisiondamagefortimeafterexit(vehicleplatform, reviver);
  }

  self.inuse = 0;
  revivespot delete();

  if(isDefined(reviver)) {
    reviver scripts\mp\teamrevive::function_a3ffe1d08888c2();
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

    reviver notify("sfx_revive_done");
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

  if(notif == "use_hold_think_success") {
    if(istrue(interrogation)) {
      reviver thread doscoreevent(#"interrogation");
    } else if(reviver.team == self.owner.team) {
      reviver thread doscoreevent(#"reviver");
    }

    if(istrue(level.allowselfrevive)) {
      reviver allowselfrevive(1);
    }

    if(!scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
      if(!istrue(interrogation)) {
        if(revivee.team == reviver.team) {
          revivee thread scripts\mp\rank::scoreeventpopup(#"revived");
        }
      }
    }

    if(istrue(interrogation)) {
      self.var_d50d5a16df84df44 = 1;
      self notify("use_hold_interrogate_success");
      return;
    }

    if(isDefined(revivee)) {
      revivee thread scripts\mp\hud_message::showsplash("revived", undefined, reviver);
      revivee.inlaststand = 0;
    }

    self notify("use_hold_revive_success");
    return;
  } else if(notif == "use_hold_think_fail") {
    if(isDefined(revivee)) {
      revivee notify("handle_revive_message");
    }
  }

  if(istrue(interrogation)) {
    self notify("use_hold_interrogate_fail");
  } else {
    self notify("use_hold_revive_fail");
  }

  if(isDefined(reviver)) {
    reviver.var_a23f35f8460d8857 = undefined;
  }

  if(isDefined(revivee)) {
    revivee.var_a23f35f8460d8857 = undefined;
  }
}

function sfx_revive_lp() {
  soundorg = spawn("script_origin", self.origin);
  soundorg linkTo(self);
  soundorg playLoopSound("br_reviver_use_lp");
  waittill_any_2("sfx_revive_done", "disconnect");

  if(isDefined(self.origin)) {
    playsoundatpos(self.origin, "br_reviver_use_end");
  }

  soundorg delete();
}

function useholdthinkloop(reviver) {
  revivee = self.owner;
  level endon("game_ended");
  revivee endon("death_or_disconnect");
  revivee endon("last_stand_finished");
  shouldstay = getdvarint(@ "hash_a23e8f787d85f762", 0);
  mintime = getdvarint(@ "hash_15e9b25b07a2bbb6", 0.5) * 1000 + gettime();
  debugkillcounter = 0;

  while(useholdthinkisValid(reviver, revivee, mintime, shouldstay)) {
    reviver notify("<dev string:x2b3>");

    if(istrue(reviver.tacopsmedicrole)) {
      return isreallyalive(reviver);
    }

    self.curprogress += level.frameduration * self.userate;
    self.userate = 1;
    reviver scripts\mp\gameobjects::updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      revivee notify("use_hold_think_success");
      return;
    }

    debugkillcounter += level.framedurationseconds;
    var_22260ab682bcc081 = getdvarint(@ "hash_f1bef8e461ed63f", 0);

    if(var_22260ab682bcc081 > 0) {
      if(debugkillcounter >= var_22260ab682bcc081) {
        revivee dodamage(revivee.maxhealth, revivee.origin, reviver, reviver, "<dev string:x2c9>", makeweapon("<dev string:x2da>"), "<dev string:x2eb>");
      }
    }

    waitframe();
  }

  revivee notify("use_hold_think_fail");
}

function useholdthinkisValid(reviver, revivee, mintime, shouldstay) {
  if(!isreallyalive(reviver)) {
    return false;
  }

  if(self.curprogress >= self.usetime) {
    return false;
  }

  if(istrue(reviver.inlaststand)) {
    return false;
  }

  if(istrue(reviver.extracted) || istrue(revivee.extracted)) {
    return false;
  }

  if(!reviver function_f111048fabf84e37(revivee) && !istrue(shouldstay) && !(gettime() < mintime)) {
    return false;
  }

  if(distancesquared(reviver.origin, self.origin) > 65536 && !revivee scripts\mp\supers\super_stimpistol::function_f0d1c9c39359efff()) {
    return false;
  }

  if(istrue(reviver.ishaywire)) {
    return false;
  }

  if(istrue(reviver isinexecutionvictim())) {
    return false;
  }

  if(istrue(reviver.var_a23f35f8460d8857) || istrue(revivee.var_a23f35f8460d8857)) {
    return false;
  }

  return true;
}

function suicidesetup() {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  level endon("game_ended");
  thread showsuicidehintstring();
  var_7831c27971ffde60 = getdvarint(@ "hash_45dbdc45bdf8f5ff", 0);
  var_3cbcaf4eda0f3704 = getdvarfloat(@ "hash_f36ad71f9fadec59", 300);

  level.var_ccf76d87061de768 = getdvarfloat(@ "hash_9f647aa84d08a764", 3);

  if(!isbot(self)) {
    thread suicidemonitorcrouchbuttonpress();
  }

  holdtime = 0;
  var_58d906af2cac1064 = level.var_21bc3423c7e17c34;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    var_58d906af2cac1064 = level.var_84f71f417b53242e;

    if(function_2a3c9a91bf1d3911()) {
      var_58d906af2cac1064 = level.var_ccf76d87061de768;
    }
  }

  while(true) {
    waitframe();

    if(self stancebuttonPressed() && self isinexecutionvictim() == 0 && !self getbeingrevived() && !selfrevivebuttonPressed(self) && !function_77799f0211be1728()) {
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

function giveupprogressbar(var_4ce97d438a53f1d5) {
  self endon("death_or_disconnect");
  self endon("stance_pressed_up");
  self endon("endGivUpProgressBar");
  level endon("game_ended");
  self setclientomnvar("ui_securing", 20);
  progress = 0;

  while(true) {
    if(progress >= var_4ce97d438a53f1d5) {
      break;
    }

    progress_ratio = progress / var_4ce97d438a53f1d5;
    self setclientomnvar("ui_securing_progress", progress_ratio);
    progress += level.frameduration;
    waitframe();
  }

  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_securing_progress", 0);
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
        thread giveupprogressbar(var_4ce97d438a53f1d5);
        break;
      case #"hash_f0a7edb65e311d04":
        starttimer = 0;
      case #"hash_d4dde12b38318c68":
        if(starttimer && gettime() - holdtime >= var_4ce97d438a53f1d5) {
          self notify("endGiveUpProgressBar");
          giveup = 1;
        }

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
        } else if(_hasperk("specialty_survivor")) {
          setlowermessageomnvar("survivor_revive", int(gettime() + self.timeuntilbleedout * 1000));
        } else {
          setlowermessageomnvar("revive_or_respawn", int(gettime() + self.timeuntilbleedout * 1000));
        }
      } else if(_hasperk("specialty_survivor")) {
        setlowermessageomnvar("survivor_revive", int(gettime() + self.timeuntilbleedout * 1000));
      } else {
        setlowermessageomnvar("ffa_down_give_up", int(gettime() + self.timeuntilbleedout * 1000));
      }
    } else if(var_649e600e12376e07) {
      setlowermessageomnvar("self_revive");
    } else if(self.pers["lives"] == 0 && isteamreviveenabled()) {
      setlowermessageomnvar("spawn_revive_wait");
    } else if(_hasperk("specialty_survivor")) {
      setlowermessageomnvar("survivor_revive", int(gettime() + self.timeuntilbleedout * 1000));
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
        break;
      }

      self.timeuntilbleedout = timeleft;
    }
  }
}

function addoverheadicon() {
  showto = self.team;
  image = "hud_realism_head_revive";
  offset = 25;
  drawthroughgeo = 1;
  var_c5409ca7522182b3 = 1280;
  naturaldist = 250;
  delaytime = undefined;
  var_fa4cf28a58192889 = undefined;
  var_b3ea37733a1577e5 = 0;
  overrideorigin = undefined;
  showonminimap = 0;
  image = scripts\cp_mp\entityheadicons::setheadicon_singleimage(showto, image, offset, drawthroughgeo, var_c5409ca7522182b3, naturaldist, delaytime, var_fa4cf28a58192889, var_b3ea37733a1577e5, overrideorigin, showonminimap);
  thread cleanupoverheadicon(image);
}

function cleanupoverheadicon(image) {
  waittill_any_2("death_or_disconnect", "last_stand_finished");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(image);
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
}

function laststandmonitor() {
  level endon("game_ended");

  if(istrue(level.laststandkillteamifdowndisable)) {
    return;
  }

  while(true) {
    waitframe();

    if(getgametypenumlives() == 0 && !istrue(level.disablespawning)) {
      continue;
    }

    level thread laststandkillteamifdown();
  }
}

function laststandkillteamifdown() {
  foreach(entry in level.teamnamelist) {
    playersonteam = getfriendlyplayers(entry, 1);
    playersinlaststand = [];

    foreach(player in playersonteam) {
      if(istrue(player.inlaststand) && !istrue(function_311066dfee085643(player)) && !istrue(player _hasperk("specialty_survivor"))) {
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
    laststandinvulntimer = getwatcheddvar("<dev string:x2f7>");

    if(!isDefined(laststandinvulntimer)) {
      dvarstring = scripts\mp\utility\dvars::function_3514ae5d09f47ed2("<dev string:x30b>");
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

function function_643969f67556243f(player, reason) {
  if(isDefined(player) && getdvarint(@ "hash_6d80c8821451e612", scripts\cp_mp\utility\game_utility::isbrstylegametype())) {
    logstring("[lastStandFailureReason] player: " + default_to(player.name, "") + ", reason: " + reason);
  }
}

function function_27d0ea02ed3cc35f(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  forcelaststand = scripts\mp\damage::isforcedlaststand(self, einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc);

  if(!istrue(forcelaststand)) {
    if(istrue(self.inlaststand) || istrue(self.playergoingintols)) {
      function_643969f67556243f(self, "in_last_stand");
      return false;
    }

    if(namespace_bed52b18307bf1e0::function_afb40a34c99dc4e4(objweapon)) {
      function_643969f67556243f(self, "drown_weapon");
      return false;
    }

    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() && !istrue(level.var_d88255cd662eb5c) && !istrue(self.killstreaklaststand) && smeansofdeath == "MOD_MELEE" && objweapon.basename != "iw9_me_fists_mp" && objweapon.basename != "iw9_me_fists_mp_ls") {
      if(!function_311066dfee085643(self, "melee")) {
        function_643969f67556243f(self, "melee");
        return false;
      }
    }

    if(smeansofdeath == "MOD_EXECUTION") {
      function_643969f67556243f(self, "execution");
      return false;
    }

    if(smeansofdeath == "MOD_MEATSHIELD") {
      function_643969f67556243f(self, "meat_shield");
      return false;
    }

    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() && isheadshot(shitloc, smeansofdeath, attacker) && !_hasperk("specialty_survivor") && !istrue(level.var_d88255cd662eb5c)) {
      if(!function_5bfdc69fe21c4118() && !function_311066dfee085643(self, "headshot")) {
        function_643969f67556243f(self, "headshot");
        return false;
      }
    }

    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() && isexplosivedamagemod(smeansofdeath) && !istrue(level.var_d88255cd662eb5c)) {
      if(!function_311066dfee085643(self, "explosive") && !(getgametype() == "xfire")) {
        function_643969f67556243f(self, "explosive");
        return false;
      }
    }

    if(istrue(self.gulagarena)) {
      if(getdvarint(@ "hash_8d6a8990465b92fc", 0)) {
        if(isDefined(self.name)) {
          playername = self.name;
        } else {
          playername = "";
        }

        if(isDefined(self.gulagarena)) {
          var_54b9737d53438793 = self.gulagarena;
        } else {
          var_54b9737d53438793 = "";
        }

        if(isDefined(self.gulag)) {
          playergulag = self.gulag;
        } else {
          playergulag = "";
        }

        stringtoprint = "[gulag_getPlayerStateWait] Player " + playername + " has .gulagArena : " + var_54b9737d53438793 + " and .gulag : " + playergulag;
        logstring(stringtoprint);
      }

      function_643969f67556243f(self, "gulag");
      return false;
    }

    if(isDefined(attacker) && isDefined(attacker.classname) && (attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn")) {
      if(!function_311066dfee085643(self, "world") && !istrue(level.var_2d3f190c222f8218)) {
        function_643969f67556243f(self, "world");
        return false;
      }
    }

    if(is_equal(attacker, self) && !scripts\cp_mp\utility\game_utility::isbrstylegametype() && !istrue(level.var_d88255cd662eb5c)) {
      function_643969f67556243f(self, "suicide");
      return false;
    }

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && scripts\mp\utility\killstreak::isjuggernaut()) {
      function_643969f67556243f(self, "juggernaut");
      return false;
    }

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && !scripts\mp\flags::gameflag("prematch_done")) {
      function_643969f67556243f(self, "br_prematch");
      return false;
    }

    if(isDefined(objweapon) && getweaponbasename(objweapon) == "nuke_mp") {
      function_643969f67556243f(self, "nuke");
      return false;
    }

    if(isDefined(level.modelaststandallowed) && !self[[level.modelaststandallowed]](einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration)) {
      function_643969f67556243f(self, "mode_allow");
      return false;
    }

    var_b9acab71a2b1fd8a = (_hasperk("specialty_survivor") || _hasperk("specialty_pistoldeath")) && !istrue(self.var_4945d0d82dd3964b) || scripts\mp\utility\game::islaststandenabled();

    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() && !istrue(level.var_d88255cd662eb5c) && !var_b9acab71a2b1fd8a) {
      function_643969f67556243f(self, "available");
      return false;
    }

    if(level.laststand == 2 && !var_b9acab71a2b1fd8a) {
      function_643969f67556243f(self, "laststand_2_available");
      return false;
    }

    if(istrue(self.var_add7dba6d7dab7d9)) {
      function_643969f67556243f(self, "<dev string:x320>");
      return false;
    }
  }

  return true;
}

function function_5bfdc69fe21c4118() {
  switch (getgametype()) {
    case #"hash_25397d96e5bc8403":
      return 1;
    default:
      return 0;
  }
}

function survivorondeath(attacker) {
  if(!isDefined(attacker)) {
    return;
  }

  if(getgametype() == "grind" && scripts\mp\flags::gameflag("prematch_done")) {
    level thread scripts\mp\gametypes\obj_dogtag::spawndogtags(self, attacker, "new_tag_spawned", undefined);
    level thread scripts\mp\gametypes\grind::droptags(self, attacker);
  } else if(level.dogtagsenabled && scripts\mp\flags::gameflag("prematch_done")) {
    level thread scripts\mp\gametypes\obj_dogtag::spawndogtags(self, attacker, "new_tag_spawned", undefined);
  }

  score = level.scoremod["kill"];

  if(score != 0) {
    if(level.teambased) {
      level scripts\mp\gamescore::giveteamscoreforobjective(attacker.pers["team"], score, 0);
    } else {
      attacker scripts\mp\gamescore::giveplayerscore(#"kill", score, self);
    }
  }

  if(scripts\mp\utility\game::function_f698bfd3efa33302() || scripts\mp\utility\game::function_e9f3a160bbefe208(attacker) || scripts\mp\utility\game::function_e9f3a160bbefe208(self)) {
    scripts\mp\cranked::oncranked(self, attacker);
  }
}

function function_3b4a396318897a49(weapon) {
  if(isstring(weapon)) {
    weaponname = weapon;
  } else {
    weaponname = weapon.basename;
  }

  if(!isDefined(weaponname)) {
    return 0;
  }

  currentweapon = 0;

  switch (weaponname) {
    case #"hash_6f9360f4d23e4f4c":
    case #"hash_7e9d38063954e4b6":
      currentweapon = 1;
      break;
  }

  return currentweapon;
}

function function_2a3c9a91bf1d3911() {
  if(getdvarint(@ "hash_1e86798724d1115d", 0) != 0) {
    return true;
  }

  return istrue(level.interrogationenabled);
}

function function_a2dd7d8143656503(player) {
  if(player getclientomnvar("ui_br_has_been_interrogated") == 1 || player getclientomnvar("ui_br_interrogate_team_is_being_tracked") == 1 || player getclientomnvar("ui_br_interrogate_tracking_other_team") == 1 || istrue(player.var_895c1aaac16f7256)) {
    return true;
  }

  return false;
}

function function_4c452a6c72371f17() {
  if(!isDefined(self.var_f1da02a134648443)) {
    self.var_f1da02a134648443 = 1;
  }

  foreach(player in level.players) {
    if(!isDefined(player)) {
      return;
    }

    function_42994e73b40cc1a4(player);
  }
}

function function_42994e73b40cc1a4(player) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(player)) {
    return;
  }

  var_4d9b9e1c6d61a950 = self.headiconon;

  if(!isDefined(var_4d9b9e1c6d61a950)) {
    return;
  }

  var_142b0f57d2ac79d9 = self.headiconoff;

  if(!isDefined(var_142b0f57d2ac79d9)) {
    return;
  }

  isteammate = scripts\mp\utility\player::isfriendly(self.owner.team, player);
  var_d36495a3a4245392 = getdvarint(@ "hash_d0cbc658324b1dae", 0) != 0;

  if(isDefined(self.owner.laststandattacker) && !var_d36495a3a4245392) {
    var_d36495a3a4245392 = scripts\mp\utility\player::isfriendly(self.owner.laststandattacker.team, player);
  } else {
    var_d36495a3a4245392 = 1;
  }

  if(isteammate || !var_d36495a3a4245392) {
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(var_4d9b9e1c6d61a950, player);
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(var_142b0f57d2ac79d9, player);
    return;
  }

  if(!isDefined(self.var_f1da02a134648443)) {
    return;
  }

  switch (self.var_f1da02a134648443) {
    case 1:
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(var_4d9b9e1c6d61a950, player);
      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(var_142b0f57d2ac79d9, player);
      setheadicondrawthroughgeo(var_4d9b9e1c6d61a950, 0);
      break;
    case 2:
      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(var_4d9b9e1c6d61a950, player);
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(var_142b0f57d2ac79d9, player);
      setheadicondrawthroughgeo(var_4d9b9e1c6d61a950, 0);
      break;
    case 4:
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(var_4d9b9e1c6d61a950, player);
      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(var_142b0f57d2ac79d9, player);
      setheadicondrawthroughgeo(var_4d9b9e1c6d61a950, 1);
      break;
    case 3:
    default:
      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(var_4d9b9e1c6d61a950, player);
      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(var_142b0f57d2ac79d9, player);
      break;
  }
}

#using_animtree("script_model");

function function_150b60d7cbd3ba2() {
  function_e1841af234a09407(%iw9_wz_interrogate_frontleft_attacker_start, "interrogate_frontleft_attacker_start");
  function_e1841af234a09407(%iw9_wz_interrogate_frontleft_attacker_loop, "interrogate_frontleft_attacker_loop");
  function_e1841af234a09407(%iw9_wz_interrogate_frontleft_attacker_end, "interrogate_frontleft_attacker_end");
  function_e1841af234a09407(%iw9_wz_interrogate_frontleft_defender_start, "interrogate_frontleft_defender_start");
  function_e1841af234a09407(%iw9_wz_interrogate_frontleft_defender_loop, "interrogate_frontleft_defender_loop");
  function_e1841af234a09407(%iw9_wz_interrogate_frontleft_defender_end, "interrogate_frontleft_defender_end");
  function_e1841af234a09407(%iw9_wz_interrogate_frontright_attacker_start, "interrogate_frontright_attacker_start");
  function_e1841af234a09407(%iw9_wz_interrogate_frontright_attacker_loop, "interrogate_frontright_attacker_loop");
  function_e1841af234a09407(%iw9_wz_interrogate_frontright_attacker_end, "interrogate_frontright_attacker_end");
  function_e1841af234a09407(%iw9_wz_interrogate_frontright_defender_start, "interrogate_frontright_defender_start");
  function_e1841af234a09407(%iw9_wz_interrogate_frontright_defender_loop, "interrogate_frontright_defender_loop");
  function_e1841af234a09407(%iw9_wz_interrogate_frontright_defender_end, "interrogate_frontright_defender_end");
  function_e1841af234a09407(%iw9_wz_interrogate_backleft_attacker_start, "interrogate_backleft_attacker_start");
  function_e1841af234a09407(%iw9_wz_interrogate_backleft_attacker_loop, "interrogate_backleft_attacker_loop");
  function_e1841af234a09407(%iw9_wz_interrogate_backleft_attacker_end, "interrogate_backleft_attacker_end");
  function_e1841af234a09407(%iw9_wz_interrogate_backleft_defender_start, "interrogate_backleft_defender_start");
  function_e1841af234a09407(%iw9_wz_interrogate_backleft_defender_loop, "interrogate_backleft_defender_loop");
  function_e1841af234a09407(%iw9_wz_interrogate_backleft_defender_end, "interrogate_backleft_defender_end");
  function_e1841af234a09407(%iw9_wz_interrogate_backright_attacker_start, "interrogate_backright_attacker_start");
  function_e1841af234a09407(%iw9_wz_interrogate_backright_attacker_loop, "interrogate_backright_attacker_loop");
  function_e1841af234a09407(%iw9_wz_interrogate_backright_attacker_end, "interrogate_backright_attacker_end");
  function_e1841af234a09407(%iw9_wz_interrogate_backright_defender_start, "interrogate_backright_defender_start");
  function_e1841af234a09407(%iw9_wz_interrogate_backright_defender_loop, "interrogate_backright_defender_loop");
  function_e1841af234a09407(%iw9_wz_interrogate_backright_defender_end, "interrogate_backright_defender_end");
  function_e1841af234a09407(%iw9_wz_interrogate_frontleft_attacker3pcam_start, "interrogate_frontleft_attacker3pcam_start");
  function_e1841af234a09407(%iw9_wz_interrogate_frontleft_attacker3pcam_loop, "interrogate_frontleft_attacker3pcam_loop");
  function_e1841af234a09407(%iw9_wz_interrogate_frontleft_attacker3pcam_end, "interrogate_frontleft_attacker3pcam_end");
  function_e1841af234a09407(%iw9_wz_interrogate_frontleft_defender3pcam_start, "interrogate_frontleft_defender3pcam_start");
  function_e1841af234a09407(%iw9_wz_interrogate_frontleft_defender3pcam_loop, "interrogate_frontleft_defender3pcam_loop");
  function_e1841af234a09407(%iw9_wz_interrogate_frontleft_defender3pcam_end, "interrogate_frontleft_defender3pcam_end");
  function_e1841af234a09407(%iw9_wz_interrogate_frontright_attacker3pcam_start, "interrogate_frontright_attacker3pcam_start");
  function_e1841af234a09407(%iw9_wz_interrogate_frontright_attacker3pcam_loop, "interrogate_frontright_attacker3pcam_loop");
  function_e1841af234a09407(%iw9_wz_interrogate_frontright_attacker3pcam_end, "interrogate_frontright_attacker3pcam_end");
  function_e1841af234a09407(%iw9_wz_interrogate_frontright_defender3pcam_start, "interrogate_frontright_defender3pcam_start");
  function_e1841af234a09407(%iw9_wz_interrogate_frontright_defender3pcam_loop, "interrogate_frontright_defender3pcam_loop");
  function_e1841af234a09407(%iw9_wz_interrogate_frontright_defender3pcam_end, "interrogate_frontright_defender3pcam_end");
  function_e1841af234a09407(%iw9_wz_interrogate_backleft_attacker3pcam_start, "interrogate_backleft_attacker3pcam_start");
  function_e1841af234a09407(%iw9_wz_interrogate_backleft_attacker3pcam_loop, "interrogate_backleft_attacker3pcam_loop");
  function_e1841af234a09407(%iw9_wz_interrogate_backleft_attacker3pcam_end, "interrogate_backleft_attacker3pcam_end");
  function_e1841af234a09407(%iw9_wz_interrogate_backleft_defender3pcam_start, "interrogate_backleft_defender3pcam_start");
  function_e1841af234a09407(%iw9_wz_interrogate_backleft_defender3pcam_loop, "interrogate_backleft_defender3pcam_loop");
  function_e1841af234a09407(%iw9_wz_interrogate_backleft_defender3pcam_end, "interrogate_backleft_defender3pcam_end");
  function_e1841af234a09407(%iw9_wz_interrogate_backright_attacker3pcam_start, "interrogate_backright_attacker3pcam_start");
  function_e1841af234a09407(%iw9_wz_interrogate_backright_attacker3pcam_loop, "interrogate_backright_attacker3pcam_loop");
  function_e1841af234a09407(%iw9_wz_interrogate_backright_attacker3pcam_end, "interrogate_backright_attacker3pcam_end");
  function_e1841af234a09407(%iw9_wz_interrogate_backright_defender3pcam_start, "interrogate_backright_defender3pcam_start");
  function_e1841af234a09407(%iw9_wz_interrogate_backright_defender3pcam_loop, "interrogate_backright_defender3pcam_loop");
  function_e1841af234a09407(%iw9_wz_interrogate_backright_defender3pcam_end, "interrogate_backright_defender3pcam_end");
  level.scr_animtree["device"] = #animtree;
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_backleft_knife_start, "interrogate_backleft_knife_start");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_backleft_knife_loop, "interrogate_backleft_knife_loop");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_backleft_knife_end, "interrogate_backleft_knife_end");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_backright_knife_start, "interrogate_backright_knife_start");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_backright_knife_loop, "interrogate_backright_knife_loop");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_backright_knife_end, "interrogate_backright_knife_end");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_frontleft_knife_start, "interrogate_frontleft_knife_start");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_frontleft_knife_loop, "interrogate_frontleft_knife_loop");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_frontleft_knife_end, "interrogate_frontleft_knife_end");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_frontright_knife_start, "interrogate_frontright_knife_start");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_frontright_knife_loop, "interrogate_frontright_knife_loop");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_frontright_knife_end, "interrogate_frontright_knife_end");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_backleft_pda_start, "interrogate_backleft_pda_start");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_backleft_pda_loop, "interrogate_backleft_pda_loop");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_backleft_pda_end, "interrogate_backleft_pda_end");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_backright_pda_start, "interrogate_backright_pda_start");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_backright_pda_loop, "interrogate_backright_pda_loop");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_backright_pda_end, "interrogate_backright_pda_end");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_frontleft_pda_start, "interrogate_frontleft_pda_start");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_frontleft_pda_loop, "interrogate_frontleft_pda_loop");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_frontleft_pda_end, "interrogate_frontleft_pda_end");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_frontright_pda_start, "interrogate_frontright_pda_start");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_frontright_pda_loop, "interrogate_frontright_pda_loop");
  function_4a6b9ecae4b71ae5(%iw9_wz_interrogate_frontright_pda_end, "interrogate_frontright_pda_end");
}

function function_1d6e0919bcc01c46(attacker, defender, playtime) {
  level endon("game_ended");
  dir = function_16f1ed28a559f91f(attacker, defender);
  self notify("interrogation_anim_setup_start");
  function_4aa5cc0d5aaf5e13(dir, attacker, defender);
  self notify("interrogation_anim_setup_done");
  thread function_7aa8b6e88b420bdb(dir, attacker, defender, playtime);
}

function function_7aa8b6e88b420bdb(dir, attacker, defender, playtime) {
  self endon("use_hold_interrogate_fail");
  attacker endon("death_or_disconnect");
  defender endon("death_or_disconnect");
  self notify("interrogation_anim_start");
  childthread function_85b5f0cafa43fc83(dir, attacker, defender);

  if(!istrue(self.var_d50d5a16df84df44)) {
    remainingtime = function_a8d9949bcfbf31c6(dir, attacker, defender, playtime);

    if(isDefined(remainingtime)) {
      function_25bb5b0a542a335c(dir, attacker, defender, remainingtime);
    }
  }

  self waittill("interrogation_anim_end_done");
  self notify("interrogation_anim_complete");
}

function function_a8d9949bcfbf31c6(dir, attacker, defender, totalplaytime) {
  self endon("use_hold_interrogate_fail");
  self endon("use_hold_interrogate_success");
  attacker endon("death_or_disconnect");
  defender endon("death_or_disconnect");
  remainingtimems = gettime();
  function_2bc915da80c90aa0(dir, attacker, defender, "start", 1, 1);
  remainingtimems = totalplaytime - gettime() - remainingtimems;
  remainingtimems = max(remainingtimems, 0);
  return remainingtimems / 1000;
}

function function_25bb5b0a542a335c(dir, attacker, defender, playtime) {
  self endon("use_hold_interrogate_fail");
  self endon("use_hold_interrogate_success");
  attacker endon("death_or_disconnect");
  defender endon("death_or_disconnect");

  if(!isDefined(playtime)) {
    return false;
  }

  animlength = function_fa005dea3b675dd4(dir, "loop");
  timeleft = playtime;

  while(timeleft > 0) {
    if(!isDefined(self)) {
      break;
    }

    function_2bc915da80c90aa0(dir, attacker, defender, "loop", 0);
    waittime = min(animlength, timeleft);
    wait waittime;
    timeleft -= waittime;
  }

  self notify("interrogation_anim_loop_done");
  return true;
}

function function_85b5f0cafa43fc83(dir, attacker, defender) {
  self notify("interrogation_anim_end");
  self endon("interrogation_anim_end");

  if(!istrue(self.var_d50d5a16df84df44)) {
    waittill_any_2("interrogation_anim_loop_done", "use_hold_interrogate_success");
  }

  function_2bc915da80c90aa0(dir, attacker, defender, "end", 1);
  self notify("interrogation_anim_end_done");
}

function function_4aa5cc0d5aaf5e13(dir, attacker, defender) {
  self endon("use_hold_interrogate_fail");
  attacker endon("death_or_disconnect");
  defender endon("death_or_disconnect");
  self.angles = (0, defender.angles[1], 0);
  [var_691d365a2045e893, var_67d8ddf901f65b1d, offsetorigindefender, var_439ae466e036ac7d] = function_341c7024a3e54638(dir, defender, attacker);
  attacker thread function_52a9113423ff7ce1(defender.origin + var_691d365a2045e893, var_67d8ddf901f65b1d);
  defender thread function_52a9113423ff7ce1(defender.origin + offsetorigindefender, var_439ae466e036ac7d);
  self.var_61859dd33e04afac = function_64c48800869451a1(attacker, defender.origin + offsetorigindefender, var_439ae466e036ac7d);
  self.scenedefender = function_64c48800869451a1(defender, defender.origin + offsetorigindefender, var_439ae466e036ac7d);
  self.scenedefender childthread function_eef4880f266f99e6(attacker);
  thread function_8ae5403c4d1733d6(dir, attacker, defender);
  thread function_d0010fdbcdaeaf0a(attacker);
  swaptimestamp = gettime();
  attacker scripts\cp_mp\utility\inventory_utility::function_f1e9d0c09f38006b(0);
  var_f4ec18f455b87d6f = getdvarfloat(@ "hash_46685b5a7ab844eb", 0.2);
  var_19c8c749987d4fea = swaptimestamp + var_f4ec18f455b87d6f * 1000;
  var_a4994b77554c30de = gettime();

  if(var_a4994b77554c30de < var_19c8c749987d4fea) {
    wait(var_19c8c749987d4fea - var_a4994b77554c30de) / 1000;
  }

  attacker.player_rig linkTo(self.var_61859dd33e04afac, "tag_origin", (0, 0, 0), (0, 0, 0));
  defender.player_rig linkTo(self.scenedefender, "tag_origin", (0, 0, 0), (0, 0, 0));

  if(!attacker getcamerathirdperson()) {
    attacker.player_rig showonlytoplayer(attacker);
  }

  if(!defender getcamerathirdperson()) {
    defender.player_rig showonlytoplayer(defender);
  }
}

function function_eef4880f266f99e6(attacker) {
  self endon("entitydeleted");
  self notify("vehicleWatchLogic");
  self endon("vehicleWatchLogic");
  cancelrange = getdvarint(@ "hash_dcdd2aa64529509e", 185);
  self.trigger = spawn("trigger_radius", self.origin, 0, cancelrange, cancelrange);

  while(true) {
    self.trigger waittill("trigger", var_2087e4030aa793b);

    if(isDefined(var_2087e4030aa793b.classname) && var_2087e4030aa793b.classname == "script_vehicle") {
      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupantsandreserving(var_2087e4030aa793b);

      if(isDefined(occupants) && occupants.size > 0) {
        attacker.var_a23f35f8460d8857 = 1;
      }
    }
  }
}

function function_8ae5403c4d1733d6(dir, attacker, defender) {
  level endon("game_ended");
  self notify("interrogation_anim_cleanup");
  self endon("interrogation_anim_cleanup");
  notif = waittill_any_return_3("interrogation_anim_complete", "use_hold_interrogate_fail", "last_stand_finished");

  if(isalive(attacker) && isDefined(self.var_61859dd33e04afac)) {
    attacker stopanimscriptsceneevent();
  }

  if(isalive(defender) && isDefined(self.scenedefender)) {
    defender stopanimscriptsceneevent();
  }

  if(isDefined(self.var_61859dd33e04afac)) {
    self.var_61859dd33e04afac function_dbc6c6adf9cf2998();
  }

  if(isDefined(self.scenedefender)) {
    self.scenedefender function_dbc6c6adf9cf2998();
  }

  waitframe();
  gunless = makeweapon(function_3d5c51904fd25773());

  if(!isDefined(attacker.gunnlessweapon)) {
    curweapon = attacker getcurrentweapon();

    if(curweapon == gunless) {
      attacker.gunnlessweapon = curweapon;
    }
  }

  if(attacker isswitchingtoweaponwithmonitoring(gunless)) {
    attacker abortmonitoredweaponswitch(gunless);
  }

  attacker thread scripts\cp_mp\utility\inventory_utility::function_9897d143c3feee05();
  attacker notify("remove_rig");
  defender notify("remove_rig");
}

function function_dbc6c6adf9cf2998() {
  if(isalive(self.player) && isDefined(self.player.player_rig) && self.player.player_rig islinked()) {
    self.player.player_rig unlink();
  }

  if(self islinked()) {
    self unlink();
  }

  self delete();
}

function function_b5963c08352be7e9(dir, attacker, defender) {
  level endon("game_ended");
  self endon("interrogation_anim_setup_start");
  defender endon("death_or_disconnect");
  self.var_61859dd33e04afac function_dbc6c6adf9cf2998();
  self.scenedefender function_dbc6c6adf9cf2998();
  waitframe();

  if(isalive(attacker)) {
    gunless = makeweapon(function_3d5c51904fd25773());

    if(attacker isswitchingtoweaponwithmonitoring(gunless)) {
      attacker abortmonitoredweaponswitch(gunless);
    }

    attacker thread scripts\cp_mp\utility\inventory_utility::function_9897d143c3feee05();
    attacker notify("remove_rig");
  }

  if(isalive(defender) && isDefined(self.scenedefender)) {
    defender stopanimscriptsceneevent();
  }

  if(isalive(defender)) {
    defender notify("remove_rig");
  }
}

function function_d0010fdbcdaeaf0a(attacker) {
  var_74c33a61490f2af7 = function_acc5ea9379317664(attacker, "offhand1h_vm_smartphone_inter", "tag_origin", 1);
  var_213abe1dbc252aca = function_acc5ea9379317664(attacker, "offhand1h_wm_smartphone_v0", "tag_accessory_left", 0);
  var_63254b5552422209 = function_acc5ea9379317664(attacker, "att_vm_p33_me_tac_knife01_inter", "tag_origin", 1);
  var_8973c46d8ffcc3dc = function_acc5ea9379317664(attacker, "att_vm_p33_me_tac_knife01_v0", "j_gun", 0);
  attacker.var_74c33a61490f2af7 = var_74c33a61490f2af7;
  attacker.var_213abe1dbc252aca = var_213abe1dbc252aca;
  attacker.var_63254b5552422209 = var_63254b5552422209;
  attacker.var_8973c46d8ffcc3dc = var_8973c46d8ffcc3dc;
  attacker setclientomnvar("ui_tablet_usb", 10);

  if(isDefined(self.var_61859dd33e04afac)) {
    attacker.var_74c33a61490f2af7 linkTo(self.var_61859dd33e04afac, "tag_origin");
    attacker.var_63254b5552422209 linkTo(self.var_61859dd33e04afac, "tag_origin");
    attacker.var_74c33a61490f2af7.animname = "device";
    attacker.var_74c33a61490f2af7 scripts\common\anim::setanimtree();
    attacker.var_63254b5552422209.animname = "device";
    attacker.var_63254b5552422209 scripts\common\anim::setanimtree();
  }

  thread function_7005f2911baffe7f(attacker);
}

function function_7005f2911baffe7f(attacker) {
  level endon("game_ended");
  var_74c33a61490f2af7 = attacker.var_74c33a61490f2af7;
  var_213abe1dbc252aca = attacker.var_213abe1dbc252aca;
  var_63254b5552422209 = attacker.var_63254b5552422209;
  var_8973c46d8ffcc3dc = attacker.var_8973c46d8ffcc3dc;
  timeoutvalue = getwatcheddvar("lastStandReviveTimer") + 5;
  waittill_any_timeout_3(timeoutvalue, "interrogation_anim_complete", "use_hold_interrogate_fail", "last_stand_finished");

  if(isDefined(attacker)) {
    attacker setclientomnvar("ui_tablet_usb", 0);
  }

  function_a0b08dae03df9dae(var_74c33a61490f2af7);
  function_a0b08dae03df9dae(var_213abe1dbc252aca);
  function_a0b08dae03df9dae(var_63254b5552422209);
  function_a0b08dae03df9dae(var_8973c46d8ffcc3dc);
}

function function_2bc915da80c90aa0(dir, attacker, defender, animtype, shouldblock, isfirstframe) {
  self endon("last_stand_finished");
  self notify("interrogation_anim_play_handle");
  self endon("interrogation_anim_play_handle");
  var_b6ca10cadf0a2d = 0;
  var_baa7bf816c823379 = 0;

  if(isDefined(attacker)) {
    var_b6ca10cadf0a2d = attacker getcamerathirdperson();
  }

  if(isDefined(defender)) {
    var_baa7bf816c823379 = defender getcamerathirdperson();
  }

  var_fd346d58d905a11b = function_27e4565cfcbf5e25(dir, animtype, "attacker", var_b6ca10cadf0a2d);
  var_c125143a1b692a67 = function_27e4565cfcbf5e25(dir, animtype, "defender", var_baa7bf816c823379);
  var_4f0410bbd831664f = function_27e4565cfcbf5e25(dir, animtype, "knife");
  var_77a57e091496b231 = function_27e4565cfcbf5e25(dir, animtype, "pda");

  if(isDefined(self.var_61859dd33e04afac) && isDefined(attacker) && isDefined(attacker.player_rig) && isDefined(var_fd346d58d905a11b)) {
    attacker endon("death_or_disconnect");

    if(istrue(isfirstframe)) {
      self.var_61859dd33e04afac scripts\common\anim::anim_first_frame_solo(attacker.player_rig, var_fd346d58d905a11b);
    }

    self.var_61859dd33e04afac childthread scripts\mp\anim::anim_player_solo(attacker, attacker.player_rig, var_fd346d58d905a11b);

    if(isDefined(attacker.var_63254b5552422209)) {
      self.var_61859dd33e04afac childthread scripts\common\anim::anim_single_solo(attacker.var_63254b5552422209, var_4f0410bbd831664f);
    }

    if(isDefined(attacker.var_74c33a61490f2af7)) {
      self.var_61859dd33e04afac childthread scripts\common\anim::anim_single_solo(attacker.var_74c33a61490f2af7, var_77a57e091496b231);
    }
  }

  if(isDefined(self.scenedefender) && isDefined(defender) && isDefined(defender.player_rig) && isDefined(var_c125143a1b692a67)) {
    defender endon("death_or_disconnect");

    if(istrue(isfirstframe)) {
      self.scenedefender scripts\common\anim::anim_first_frame_solo(defender.player_rig, var_c125143a1b692a67);
    }

    self.scenedefender childthread scripts\mp\anim::anim_player_solo(defender, defender.player_rig, var_c125143a1b692a67);
  }

  if(istrue(shouldblock)) {
    animwaittime = function_fa005dea3b675dd4(dir, animtype);
    wait animwaittime;
  }
}

function function_27e4565cfcbf5e25(dir, animtype, subjectname, var_24b6f4bd2e81097d) {
  if(istrue(var_24b6f4bd2e81097d)) {
    subjectname += "3pcam";
  }

  return "interrogate_" + dir + "_" + subjectname + "_" + animtype;
}

function function_16f1ed28a559f91f(attacker, defender) {
  var_1a91c43c0366371a = getdvarint(@ "hash_84ba96c2974a8135", 0);

  if(istrue(var_1a91c43c0366371a)) {
    return function_a30d65a6f3331dc1(attacker, defender);
  }

  return function_bf625405d3e068af(attacker, defender);
}

function function_a30d65a6f3331dc1(attacker, defender) {
  var_ac727774017accae = 22.5;
  var_bbf4a6fb1025338a = 67.5;
  var_10f21406a3625090 = 112.5;
  var_7244d6d492287f0e = 157.5;
  var_3e0d351e6e3a5cc2 = angleclamp(defender.angles);
  var_9ef779c4d770e613 = math::anglebetweenvectorssigned(attacker.origin - defender.origin, anglesToForward(var_3e0d351e6e3a5cc2), (0, 0, 1));
  isleft = 0;

  if(var_9ef779c4d770e613 < 0) {
    isleft = 1;
  }

  if(abs(var_9ef779c4d770e613) < var_ac727774017accae) {
    dir = "front";
  } else if(abs(var_9ef779c4d770e613) < var_bbf4a6fb1025338a) {
    if(isleft) {
      dir = "frontleft";
    } else {
      dir = "frontright";
    }
  } else if(abs(var_9ef779c4d770e613) < var_10f21406a3625090) {
    if(isleft) {
      dir = "left";
    } else {
      dir = "right";
    }
  } else if(abs(var_9ef779c4d770e613) < var_7244d6d492287f0e) {
    if(isleft) {
      dir = "backleft";
    } else {
      dir = "backright";
    }
  } else {
    dir = "back";
  }

  return dir;
}

function function_bf625405d3e068af(attacker, defender) {
  var_3e0d351e6e3a5cc2 = angleclamp(defender.angles);
  var_9ef779c4d770e613 = math::anglebetweenvectorssigned(attacker.origin - defender.origin, anglesToForward(var_3e0d351e6e3a5cc2), (0, 0, 1));

  if(var_9ef779c4d770e613 > 0) {
    if(var_9ef779c4d770e613 > 90) {
      dir = "backright";
    } else {
      dir = "frontright";
    }
  } else if(var_9ef779c4d770e613 < -90) {
    dir = "backleft";
  } else {
    dir = "frontleft";
  }

  return dir;
}

function function_acc5ea9379317664(player, animmodel, animtag, isviewmodel, originoffset, anglesoffset) {
  if(!isDefined(originoffset)) {
    originoffset = (0, 0, 0);
  }

  if(!isDefined(anglesoffset)) {
    anglesoffset = (0, 0, 0);
  }

  newmodel = spawn("script_model", (0, 0, 0));
  newmodel setModel(animmodel);
  newmodel show();

  if(istrue(isviewmodel)) {
    if(player getcamerathirdperson()) {
      newmodel hide();
    } else {
      newmodel showonlytoplayer(player);
    }
  } else {
    if(!player getcamerathirdperson()) {
      newmodel hidefromplayer(player);
    }

    newmodel linkTo(player, animtag, originoffset, anglesoffset);
  }

  return newmodel;
}

function function_64c48800869451a1(player, sceneorigin, sceneangles) {
  newscene = spawn("script_model", sceneorigin);
  newscene.angles = sceneangles;
  newscene setModel("tag_origin");
  newscene hide();
  newscene.player = player;
  return newscene;
}

function function_e1841af234a09407(var_b1e6fbabce1a26ba, var_41503cd028efb569) {
  if(!isDefined(var_41503cd028efb569)) {
    return;
  }

  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"][var_41503cd028efb569] = var_b1e6fbabce1a26ba;
  level.scr_eventanim["player"][var_41503cd028efb569] = var_41503cd028efb569;
}

function function_4a6b9ecae4b71ae5(var_b1e6fbabce1a26ba, var_41503cd028efb569) {
  if(!isDefined(var_41503cd028efb569)) {
    return;
  }

  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"][var_41503cd028efb569] = var_b1e6fbabce1a26ba;
  level.scr_eventanim["device"][var_41503cd028efb569] = var_41503cd028efb569;
}

function function_52a9113423ff7ce1(spawnpos, spawnang) {
  maxmovetime = getdvarfloat(@ "hash_46685b5a7ab844eb", 0.2) - 0.05;
  assert(maxmovetime > 0);
  self.animname = "player";

  if(!isDefined(spawnpos)) {
    spawnpos = (0, 0, 0);
  }

  if(!isDefined(spawnang)) {
    spawnang = (0, 0, 0);
  }

  var_7521c682c7617240 = self getcamerathirdperson();
  self function_b88c89bb7cd1ab8e(spawnpos);
  eyepos = (0, 0, self getplayerviewheight(self getstance()));
  var_7b71e4920d76c2c1 = rotatevector(eyepos, self getplayerangles());
  var_7b71e4920d76c2c1 = eyepos - var_7b71e4920d76c2c1;
  player_rig = spawn("script_arms", self.origin + var_7b71e4920d76c2c1, 0, 0, self);
  player_rig.angles = self getplayerangles();
  player_rig.player = self;
  self.player_rig = player_rig;
  self.player_rig hide(1);
  self.player_rig.animname = "player";
  self.player_rig useanimtree(#animtree);
  self.player_rig.updatedversion = 1;

  if(istrue(var_7521c682c7617240)) {
    self playerlinktodelta(self.player_rig, "tag_origin", 1, 0, 0, 0, 0, 0, 1, 1);
  } else if(!isinlaststand(self)) {
    self playerlinktodelta(self.player_rig, "tag_origin", 1, 10, 10, 10, 10, 0, 1, 1);
  } else {
    self playerlinktodelta(self.player_rig, "tag_origin", 1, 4, 4, 8, 8, 0, 1, 1);
  }

  self.player_rig moveTo(spawnpos, maxmovetime, 0.05, maxmovetime * 0.25);
  self.player_rig rotateTo(spawnang, maxmovetime, 0.05, maxmovetime * 0.25);
  self notify("rig_created");
  waittill_any_2("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(self)) {
    self unlink();
    gunless = makeweapon(function_3d5c51904fd25773());

    if(isswitchingtoweaponwithmonitoring(gunless)) {
      abortmonitoredweaponswitch(gunless);
    }

    thread scripts\cp_mp\utility\inventory_utility::function_9897d143c3feee05();
  }

  if(isDefined(player_rig)) {
    player_rig delete();
  }
}

function function_fa005dea3b675dd4(dir, animtype) {
  if(!isDefined(dir) || !isDefined(animtype)) {
    return 0;
  }

  animname = function_27e4565cfcbf5e25(dir, animtype, "attacker");
  animlength = getanimlength(level.scr_anim["player"][animname]);

  if(isDefined(animlength)) {
    return animlength;
  }

  animname = function_27e4565cfcbf5e25(dir, animtype, "defender");
  animlength = getanimlength(level.scr_anim["player"][animname]);

  if(isDefined(animlength)) {
    return animlength;
  }

  return 0;
}

function function_341c7024a3e54638(dir, defender, attacker) {
  var_da04238f117f371e = (62.707, 46.051, 6);
  var_af1341bec25ffc13 = (74.806, -48.163, 19);
  var_4a1c12f2f92b81c4 = (-26.042, 72.986, 19);
  var_72d69e3f71a14b91 = (-41.891, -85.123, 16);
  var_c9de492ad170fa99 = (33.226, -140.939, 0);
  var_4945066f80fb403a = (47, 144.501, 0);
  var_c8da9727e974891d = (47.171, -66.087, 0);
  var_fcb771762f1ba156 = (42.768, 53.39, 0);
  attackeroffset = (0, 0, 0);
  attackerangles = (0, 0, 0);
  defenderoffset = (0, 0, 0);
  var_3e0d351e6e3a5cc2 = (0, 0, 0);
  var_18ba7ff327954c = var_fcb771762f1ba156;
  offsetvalue = (0, 0, 0);

  switch (dir) {
    case #"hash_b7ac0cd88b535f49":
      var_18ba7ff327954c = var_c9de492ad170fa99;
      offsetvalue = var_da04238f117f371e;
      break;
    case #"hash_1a6710a30ea5fea":
      var_18ba7ff327954c = var_4945066f80fb403a;
      offsetvalue = var_af1341bec25ffc13;
      break;
    case #"hash_29a0586a7056ac8f":
      var_18ba7ff327954c = var_c8da9727e974891d;
      offsetvalue = var_4a1c12f2f92b81c4;
      break;
    case #"hash_4337df7547428000":
      var_18ba7ff327954c = var_fcb771762f1ba156;
      offsetvalue = var_72d69e3f71a14b91;
      break;
  }

  var_f462fa4a0e9af84 = vectorNormalize(attacker.origin - defender.origin);
  defenderforward = anglesToForward(defender.angles);
  defaultforward = (1, 0, 0);
  currentangle = math::anglebetweenvectorssigned(defenderforward, var_f462fa4a0e9af84, (0, 0, 1));
  rotatevalue = math::anglebetweenvectorssigned(defaultforward, offsetvalue, (0, 0, 1));
  rotatedif = currentangle - rotatevalue;
  var_28eb2de6a2e2e9df = rotatepointaroundvector((0, 0, 1), defenderforward, rotatedif);
  var_3e0d351e6e3a5cc2 = scripts\mp\utility\script::vectortoanglessafe(var_28eb2de6a2e2e9df, (0, 0, 1));

  if(getdvarint(@ "hash_bbd8136229f7e702", 0)) {
    var_28eb2de6a2e2e9df = defenderforward;
    var_3e0d351e6e3a5cc2 = defender.angles;
  }

  var_5019e02fc30e335 = math::anglebetweenvectorssigned(defaultforward, var_28eb2de6a2e2e9df, (0, 0, 1));
  attackeroffset = rotatepointaroundvector((0, 0, 1), offsetvalue, var_5019e02fc30e335);
  var_181640917809e880 = anglesToForward(var_18ba7ff327954c);
  var_4d034c998a162518 = rotatepointaroundvector((0, 0, 1), var_181640917809e880, var_5019e02fc30e335);
  attackerangles = scripts\mp\utility\script::vectortoanglessafe(vectorNormalize(var_4d034c998a162518), (0, 0, 1));
  return [attackeroffset, attackerangles, defenderoffset, var_3e0d351e6e3a5cc2];
}

function function_a0b08dae03df9dae(animmodel) {
  if(isDefined(animmodel)) {
    if(animmodel islinked()) {
      animmodel unlink();
    }

    animmodel delete();
  }
}

function function_96f2172e98188560(target) {
  if(!isDefined(self) || !isPlayer(self) || !isDefined(target)) {
    return;
  }

  if(getdvarint(@ "hash_72771711644c3f78", 1) == 0) {
    return;
  }

  if(self isswimming()) {
    return;
  }

  if(isDefined(self.var_88f59c89f67e4385)) {
    self.var_88f59c89f67e4385 delete();
  }

  startangles = self getplayerangles();
  newangles = vectortoangles(vectorNormalize(target - self getEye()));
  var_88f59c89f67e4385 = spawn("script_model", self.origin);
  var_88f59c89f67e4385.angles = startangles;
  var_88f59c89f67e4385 setModel("tag_origin");
  var_88f59c89f67e4385 rotateTo(newangles, 0.4, 0.05);
  var_88f59c89f67e4385 thread scripts\mp\teamrevive::function_7f0aebb7ad935939(self);
  self.var_88f59c89f67e4385 = var_88f59c89f67e4385;
  mover = self getmovingplatformparent();

  if(isDefined(mover)) {
    scripts\cp_mp\vehicles\vehicle_occupancy::function_3dfe65e73a7d0c86(self, mover);
    var_88f59c89f67e4385 linkTo(mover);
  } else {
    thread scripts\mp\teamrevive::function_d75bbd43c2e29f0c();
  }

  self playerlinktodelta(var_88f59c89f67e4385, "", 1, 10, 10, 0, 0, 0, 0, 0, 1, 0, 0.3, 0.3);
}

function interrogation_onplayerdisconnect(player) {
  if(!isDefined(player) || !function_2a3c9a91bf1d3911()) {
    return;
  }

  if(isDefined(player.laststandreviveent)) {
    if(isDefined(player.laststandreviveent.headiconon)) {
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(player.laststandreviveent.headiconon);
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(player.laststandreviveent.headiconoff);
      player.laststandreviveent.headiconon = undefined;
      player.laststandreviveent.headiconoff = undefined;
    }

    player setclientomnvar("ui_br_has_been_interrogated", 0);
  }

  if(istrue(player.var_895c1aaac16f7256) && isDefined(player.var_f159f1c13aa75721) && isDefined(player.var_f159f1c13aa75721.lastvaliduser) && isPlayer(player.var_f159f1c13aa75721.lastvaliduser)) {
    interrogator = player.var_f159f1c13aa75721.lastvaliduser;
    var_5bebd2013b0f01ec = player;
    interrogator thread function_1b56d7c4fe15b79c(interrogator, var_5bebd2013b0f01ec);
    function_b37595afabefa038(interrogator, var_5bebd2013b0f01ec);
  }
}

function function_5911caad56f963ea(team, changeval) {
  if(team == "axis") {
    level.var_a04b495bbccdf0bf += changeval;
    setomnvar("ui_cutthroat_num_reviving_team_1", level.var_a04b495bbccdf0bf);
    return;
  }

  if(team == "allies") {
    level.var_eb919e162d131112 += changeval;
    setomnvar("ui_cutthroat_num_reviving_team_2", level.var_eb919e162d131112);
    return;
  }

  if(team == "team_three") {
    level.var_62973ff88470b851 += changeval;
    setomnvar("ui_cutthroat_num_reviving_team_3", level.var_62973ff88470b851);
    return;
  }

  scripts\mp\hud_message::showerrormessage("setCutthroatRevivingOmnvar : invalid team" + self.team + " passed through");
}

function function_e6ccdf90ba898cdc(team, changeval) {
  if(team == "axis") {
    level.var_2d9a769507f8c794 += changeval;
    setomnvar("ui_cutthroat_num_downed_team_1", level.var_2d9a769507f8c794);
    return;
  }

  if(team == "allies") {
    level.var_419bc98b5f722331 += changeval;
    setomnvar("ui_cutthroat_num_downed_team_2", level.var_419bc98b5f722331);
    return;
  }

  if(team == "team_three") {
    level.var_9663d50652fde8c2 += changeval;
    setomnvar("ui_cutthroat_num_downed_team_3", level.var_9663d50652fde8c2);
    return;
  }

  scripts\mp\hud_message::showerrormessage("setCutthroatDownOmnvar: invalid team" + self.team + " passed through");
}

function function_9168ee31efcf3393() {
  level endon("<dev string:x329>");
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
  if(!_hasperk("<dev string:x334>")) {
    giveperk("<dev string:x334>");
  }

  self dodamage(self.maxhealth * 2, self.origin, self, undefined, "<dev string:x34a>");
}

function function_e7884f1619dc53be() {
  level endon("<dev string:x329>");
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
          iprintlnbold("<dev string:x35b>");
          break;
        }

        pistolobj = eplayer scripts\mp\gametypes\br_public::playergetlaststandpistol();

        if(!isDefined(pistolobj)) {
          iprintlnbold("<dev string:x368>");
          break;
        }

        eplayer dodamage(eplayer.health + 200, var_4cd9f1ecf86a97bb.origin, var_4cd9f1ecf86a97bb, var_4cd9f1ecf86a97bb, "<dev string:x2c9>", var_4cd9f1ecf86a97bb.primaryweaponobj, "<dev string:x2eb>");
        var_4cd9f1ecf86a97bb hudoutlineenable("<dev string:x37f>");
        iprintlnbold("<dev string:x393>");
        break;
      case 2:
        if(!isDefined(var_4cd9f1ecf86a97bb) || !isDefined(var_de75a3b89e8300f5)) {
          iprintlnbold("<dev string:x39d>");
          break;
        }

        pistolobj = eplayer scripts\mp\gametypes\br_public::playergetlaststandpistol();

        if(!isDefined(pistolobj)) {
          iprintlnbold("<dev string:x368>");
          break;
        }

        eplayer dodamage(eplayer.health + 200, var_4cd9f1ecf86a97bb.origin, var_4cd9f1ecf86a97bb, var_4cd9f1ecf86a97bb, "<dev string:x2c9>", var_4cd9f1ecf86a97bb.primaryweaponobj, "<dev string:x2eb>");
        wait 1;
        var_4cd9f1ecf86a97bb dodamage(var_4cd9f1ecf86a97bb.health + 200, var_de75a3b89e8300f5.origin, var_de75a3b89e8300f5, var_de75a3b89e8300f5, "<dev string:x2c9>", var_de75a3b89e8300f5.primaryweaponobj, "<dev string:x2eb>");
        var_4cd9f1ecf86a97bb hudoutlineenable("<dev string:x37f>");
        iprintlnbold("<dev string:x393>");
        break;
      case 3:
        if(!isDefined(var_4cd9f1ecf86a97bb) || !isDefined(var_de75a3b89e8300f5)) {
          iprintlnbold("<dev string:x39d>");
          break;
        }

        var_4cd9f1ecf86a97bb dodamage(var_4cd9f1ecf86a97bb.health + 200, eplayer.origin, eplayer, eplayer, "<dev string:x2c9>", eplayer.primaryweaponobj, "<dev string:x2eb>");
        wait 1;
        eplayer dodamage(eplayer.health + 200, var_de75a3b89e8300f5.origin, var_de75a3b89e8300f5, var_de75a3b89e8300f5, "<dev string:x2c9>", var_de75a3b89e8300f5.primaryweaponobj, "<dev string:x2eb>");
        iprintlnbold("<dev string:x3b4>");
        break;
      case 4:
        if(!isDefined(var_4cd9f1ecf86a97bb) || !isDefined(var_de75a3b89e8300f5)) {
          iprintlnbold("<dev string:x39d>");
          break;
        }

        pistolobj = eplayer scripts\mp\gametypes\br_public::playergetlaststandpistol();

        if(!isDefined(pistolobj)) {
          iprintlnbold("<dev string:x368>");
          break;
        }

        eplayer dodamage(eplayer.health + 200, var_4cd9f1ecf86a97bb.origin, var_4cd9f1ecf86a97bb, var_4cd9f1ecf86a97bb, "<dev string:x2c9>", var_4cd9f1ecf86a97bb.primaryweaponobj, "<dev string:x2eb>");
        var_4cd9f1ecf86a97bb hudoutlineenable("<dev string:x37f>");
        iprintlnbold("<dev string:x393>");
        var_4cd9f1ecf86a97bb waittill("<dev string:x3d1>");
        wait 1;
        var_4cd9f1ecf86a97bb dodamage(var_4cd9f1ecf86a97bb.health + 200, var_de75a3b89e8300f5.origin, var_de75a3b89e8300f5, var_de75a3b89e8300f5, "<dev string:x2c9>", var_de75a3b89e8300f5.primaryweaponobj, "<dev string:x2eb>");
        break;
      case 5:
        if(!isDefined(var_4cd9f1ecf86a97bb) || !isDefined(var_de75a3b89e8300f5)) {
          iprintlnbold("<dev string:x39d>");
          break;
        }

        var_de75a3b89e8300f5 dodamage(var_de75a3b89e8300f5.health + 200, var_4cd9f1ecf86a97bb.origin, var_4cd9f1ecf86a97bb, var_4cd9f1ecf86a97bb, "<dev string:x2c9>", var_4cd9f1ecf86a97bb.primaryweaponobj, "<dev string:x2eb>");
        var_4cd9f1ecf86a97bb hudoutlineenable("<dev string:x37f>");
        iprintlnbold("<dev string:x393>");
        var_4cd9f1ecf86a97bb waittill("<dev string:x3d1>");
        var_4cd9f1ecf86a97bb hudoutlinedisable();
        wait 1;
        var_de75a3b89e8300f5 notify("<dev string:x3e2>");
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
          host.reviver botpressbutton("<dev string:x3f6>", presstime);
          wait presstime + 0.5;

          if(isinlaststand(host) || istrue(host.liveragdoll)) {
            host.reviver botpressbutton("<dev string:x3f6>", presstime);
          }
        }
      } else {
        iprintlnbold("<dev string:x3fa>");
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
          iprintlnbold("<dev string:x466>");
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
          victim.reviver botpressbutton("<dev string:x3f6>", presstime);
          wait presstime + 0.5;

          if(isinlaststand(victim)) {
            victim.reviver botpressbutton("<dev string:x3f6>", presstime);
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
        host function_d87e1768229d0e3e();

        if(isDefined(host.var_6627db08bfd4f903)) {
          host.var_6627db08bfd4f903 setdevtext("<dev string:x498>");
          host.var_6627db08bfd4f903.color = (1, 1, 1);
        } else {
          host iprintlnbold("<dev string:x498>");
        }
      }

      setdevdvar(@ "hash_d475fd19488b5a6d", 0);
    }

    wait 1;
  }
}

function function_b3f5eede669e7182(attacker, victim) {
  level endon("game_ended");
  victim endon("death_or_disconnect");
  victim endon("last_stand_finished");
  victim endon("use_hold_interrogate_success");
  victim endon("use_hold_interrogate_fail");

  while(true) {
    if(!isDefined(victim) || !isDefined(attacker)) {
      break;
    }

    if(victim useButtonPressed() || istrue(victim.var_7f59448717b5aa63)) {
      victim function_4ba85e5091eee483(#"ping_help_interrogate", 4);
      victim thread namespace_88bfae359020fdd3::function_8fdd864a86afe560(attacker);
      wait 1.5;
    }

    waitframe();
  }
}

function function_4ba85e5091eee483(vo_string, debounce) {
  if(!isDefined(self.var_b91fc73cfedfc41)) {
    self.var_b91fc73cfedfc41 = 0;
  }

  if(!isDefined(debounce)) {
    debounce = 0;
  }

  if(self.var_b91fc73cfedfc41 == 0) {
    self.var_b91fc73cfedfc41 = 1;
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, vo_string);
    thread function_6945da38c80ec9cf(debounce);
  }
}

function function_6945da38c80ec9cf(debounce) {
  level endon("game_ended");
  self endon("disconnect");
  wait debounce;
  self.var_b91fc73cfedfc41 = 0;
}

function function_d9b9b021d2e292a7() {
  level endon("<dev string:x329>");

  while(true) {
    if(getdvarint(@ "hash_eb12fbdb604176fb", 0) != 0) {
      setDvar(@ "hash_eb12fbdb604176fb", 0);
      localplayer = level.players[0];

      foreach(bot in level.players) {
        if(bot != localplayer && isbot(bot) && localplayer.team == bot.team) {
          function_78e1a6bd9380a160(bot, localplayer);
          break;
        }
      }
    }

    if(getdvarint(@ "hash_12b095ece3375ee2", 0) != 0) {
      setDvar(@ "hash_12b095ece3375ee2", 0);
      localplayer = level.players[0];

      if(!isinlaststand(localplayer)) {
        foreach(bot in level.players) {
          if(isinlaststand(bot)) {
            localplayer = bot;
            break;
          }
        }
      }

      foreach(bot in level.players) {
        if(bot != localplayer && isbot(bot) && localplayer.team != bot.team) {
          function_78e1a6bd9380a160(bot, localplayer);
          break;
        }
      }
    }

    if(getdvarint(@ "hash_b81bebd8a028bd0a", 0) != 0) {
      setDvar(@ "hash_b81bebd8a028bd0a", 0);
      localplayer = level.players[0];

      foreach(bot in level.players) {
        if(bot != localplayer && isbot(bot) && isaliveandnotinlaststand(bot) && bot.team == localplayer.team) {
          if(!istrue(bot.hasselfrevivetoken)) {
            bot scripts\mp\gametypes\br_pickups::addselfrevivetoken();
          }

          bot forcelaststand();
          wait 1;
          bot.var_f932828585d0926c = 1;
          bot waittill_any_timeout_1(10, "<dev string:x4bc>");
          bot.var_f932828585d0926c = undefined;
          break;
        }
      }
    }

    wait 1;
  }
}

function function_78e1a6bd9380a160(bot, downedplayer, directionvector) {
  assert(isDefined(bot));
  assert(isDefined(downedplayer));

  if(!isinlaststand(downedplayer)) {
    return;
  }

  if(!isDefined(directionvector)) {
    directionvector = (1, 0, 0);
  }

  var_558a3833630c48 = downedplayer.origin + vectornormalize2(directionvector) * 50;
  bot setOrigin(var_558a3833630c48, 1);
  bot function_8b201bccc0aa3695(downedplayer.origin, 0.5);
  wait 0.5;
  bot botpressbutton("<dev string:x3f6>", 8);
}

# /