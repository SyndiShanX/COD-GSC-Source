/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\infect.gsc
************************************************/

main() {
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registertimelimitdvar(level.gametype, 10);
    maps\mp\_utility::setoverridewatchdvar("scorelimit", 0);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_numinitialinfected = 1;
    level.matchrules_damagemultiplier = 0;
  }

  setspecialloadouts();
  setdvarifuninitialized("spv_tesla_mp_active", 0);
  maps\mp\_utility::_id_873B(1);
  level.doprematch = 1;
  level.disableforfeit = 1;
  level.nobuddyspawns = 1;
  level.onstartgametype = ::onstartgametype;
  level.onspawnplayer = ::onspawnplayer;
  level._id_6B7B = ::_id_6B7B;
  level.ondeadevent = ::ondeadevent;
  level.ontimelimit = ::ontimelimit;
  level.autoassign = ::_id_5117;
  level._id_1DEA = ::_id_511A;
  level.gametypemovespeedscalefunc = ::infectedmovespeedscale;
  level._id_2FAB = 1;
  level.disabledivisionstats = 1;
  level._id_2F8B = 1;
  level.disableallplayerstats = 1;
  level.disableweaponchallenges = 1;
  level.disabledivisionchallenges = 1;
  level.disablewinlossstats = 1;
  level.mgnestsdisabled = 1;

  if(level.matchrules_damagemultiplier) {
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "inf_intro";

  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["inf_finalone"] = "inf_finalone";
  game["dialog"]["inf_infected"] = "inf_infected";
  game["dialog"]["inf_timeadded"] = "inf_timeadded";
  level._effect["mp_infected_zombie_vision_01"] = loadfx("vfx/unique/mp_infected_zombie_vision_01");
  level._effect["mp_infected_zombie_vision_spltscrn_01"] = loadfx("vfx/unique/mp_infected_zombie_vision_spltscrn_01");
  level._effect["infected_turn_lightning_01"] = loadfx("vfx/unique/infected_turn_lightning_01");
  level._effect["tesla_gun_glow"] = loadfx("vfx/unique/mp_loot_ray_01");
}

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
  level.matchrules_numinitialinfected = _getmatchrulesdata("infectData", "numInitialInfected");
  _setdynamicdvar("scr_" + level.gametype + "_numLives", 0);
  maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
  maps\mp\_utility::setoverridewatchdvar("scorelimit", 0);
  _setdynamicdvar("scr_infect_roundswitch", 0);
  maps\mp\_utility::registerroundswitchdvar("infect", 0, 0, 9);
  _setdynamicdvar("scr_infect_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("infect", 1);
  _setdynamicdvar("scr_infect_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("infect", 1);
  _setdynamicdvar("scr_infect_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("infect", 0);
  _setdynamicdvar("scr_infect_playerrespawndelay", 0);
  _setdynamicdvar("scr_infect_waverespawndelay", 0);
  _setdynamicdvar("scr_player_forcerespawn", 1);
  _setdynamicdvar("scr_team_fftype", 0);
  _setdynamicdvar("scr_game_hardpoints", 0);
  setDvar("3193", 1);
}

onstartgametype() {
  _setclientnamemode("auto_change");
  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_INFECT");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_INFECT");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_INFECT");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_INFECT");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_INFECT_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_INFECT_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_INFECT_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_INFECT_HINT");
  _id_050D::_id_10E4();
  var_0[0] = level.gametype;
  _id_04D1::main(var_0);
  level.quickmessagetoall = 1;
  level.blockweapondrops = 1;
  level.infect_allowsuicide = 0;
  level.infect_chosefirstinfected = 0;
  level.infect_choosingfirstinfected = 0;
  level.infect_countdowninprogress = 0;
  level.infect_teamscores["axis"] = 0;
  level.infect_teamscores["allies"] = 0;
  level.infect_players = [];
  level.mgnestsdisabled = 1;
  level thread maps\mp\gametypes\_raid_tripwire::runtripwirelogic();
  level thread onplayerconnect();
  level thread gametimer();
}

gametimer() {
  level endon("game_ended");
  _setdynamicdvar("scr_infect_timelimit", 0);
  var_0 = 0;
  var_1 = undefined;
  var_2 = 2;
  var_3 = 1;

  for(;;) {
    level waittill("update_game_time", var_4, var_5);
    var_1 = undefined;

    if(isDefined(var_5) && var_5) {
      var_1 = maps\mp\_utility::gettimepassed() / 60000 + var_2;
    } else if(isDefined(var_4) && var_4 == 1) {
      var_6 = var_3 * 0.166667 + var_2;
    } else {
      var_3++;
      var_1 = var_3 * 0.166667 + var_2;
    }

    _setdynamicdvar("scr_infect_timelimit", var_1);
    level thread watchhostmigration(var_1);

    if(var_0) {
      level thread maps\mp\_utility::leaderdialogbothteams("inf_timeadded", "axis", "inf_timeadded", "allies", "status");
    }

    var_0 = 1;
  }
}

watchhostmigration(var_0) {
  level notify("watchHostMigration");
  level endon("watchHostMigration");
  level endon("game_ended");
  level waittill("host_migration_begin");
  _setdynamicdvar("scr_infect_timelimit", 0);
  waittillframeend;
  _setdynamicdvar("scr_infect_timelimit", 0);
  level waittill("host_migration_end");
  level notify("update_game_time", var_0);
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.infectedrejoined = 0;
    var_0.killsasinfected = 0;

    if(!_isai(var_0) && !istestclient(var_0)) {
      var_0 thread monitorinfectedafk();
    }

    if(maps\mp\_utility::gameflag("prematch_done")) {
      if(isDefined(level.infect_chosefirstinfected) && level.infect_chosefirstinfected) {
        var_0.survivalstarttime = gettime();
      }
    }

    if(isDefined(level.infect_players[var_0.name])) {
      var_0.infectedrejoined = 1;
    }

    var_0 thread monitorsurvivaltime();
    var_0 thread _id_0513::initteslagun();
  }
}

monitorinfectedafk() {
  level endon("game_ended");
  self endon("disconnect");
  self notifyonplayercommand("buttonPressed", "+usereload");
  self notifyonplayercommand("buttonPressed", "+stance");
  self notifyonplayercommand("buttonPressed", "+weapnext");
  self notifyonplayercommand("buttonPressed", "+sprint");
  self notifyonplayercommand("buttonPressed", "+attack");
  self notifyonplayercommand("buttonPressed", "+activate");
  self notifyonplayercommand("buttonPressed", "+gostand");
  self notifyonplayercommand("buttonPressed", "+melee_zoom");
  self notifyonplayercommand("buttonPressed", "+breath_sprint");
  self notifyonplayercommand("buttonPressed", "+speed_throw");
  self notifyonplayercommand("buttonPressed", "+frag");
  self notifyonplayercommand("buttonPressed", "+smoke");
  thread disconnectifnobuttonPressed();
  self waittill("buttonPressed");
  self notifyonplayercommandremove("buttonPressed", "+usereload");
  self notifyonplayercommandremove("buttonPressed", "+stance");
  self notifyonplayercommandremove("buttonPressed", "+weapnext");
  self notifyonplayercommandremove("buttonPressed", "+sprint");
  self notifyonplayercommandremove("buttonPressed", "+attack");
  self notifyonplayercommandremove("buttonPressed", "+activate");
  self notifyonplayercommandremove("buttonPressed", "+gostand");
  self notifyonplayercommandremove("buttonPressed", "+melee_zoom");
  self notifyonplayercommandremove("buttonPressed", "+breath_sprint");
  self notifyonplayercommandremove("buttonPressed", "+speed_throw");
  self notifyonplayercommandremove("buttonPressed", "+frag");
  self notifyonplayercommandremove("buttonPressed", "+smoke");
}

disconnectifnobuttonPressed() {
  self endon("buttonPressed");
  self endon("disconnect");
  level endon("game_ended");
  wait 75;
  self notifyonplayercommandremove("buttonPressed", "+usereload");
  self notifyonplayercommandremove("buttonPressed", "+stance");
  self notifyonplayercommandremove("buttonPressed", "+weapnext");
  self notifyonplayercommandremove("buttonPressed", "+sprint");
  self notifyonplayercommandremove("buttonPressed", "+attack");
  self notifyonplayercommandremove("buttonPressed", "+activate");
  self notifyonplayercommandremove("buttonPressed", "+gostand");
  self notifyonplayercommandremove("buttonPressed", "+melee_zoom");
  self notifyonplayercommandremove("buttonPressed", "+breath_sprint");
  self notifyonplayercommandremove("buttonPressed", "+speed_throw");
  self notifyonplayercommandremove("buttonPressed", "+frag");
  self notifyonplayercommandremove("buttonPressed", "+smoke");

  if(!self ishost()) {
    _kick(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
    level thread maps\mp\gametypes\_gamelogic::updategameevents();
  }
}

infectedmovespeedscale() {
  if(self.pers["team"] == "axis") {
    if(isDefined(self.infectedboost) && self.infectedboost) {
      return 1.35;
    } else {
      return 1.1;
    }
  } else
    return 1;
}

_id_5117() {
  var_0 = "allies";

  if(self.infectedrejoined) {
    var_0 = "axis";
  }

  thread _id_04E8::setteam(var_0);
}

_id_511A() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.pers["gamemodeLoadout"] = level.infect_loadouts[self.pers["team"]];
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  preloadweapons();
}

preloadweapons() {
  var_0 = [];

  foreach(var_2 in level.infect_loadouts) {
    if(isDefined(var_2["loadoutPrimaryWeaponStruct"]) && isDefined(var_2["loadoutPrimaryWeaponStruct.GUID"]) && var_2["loadoutPrimaryWeaponStruct.GUID"] != 17273856 && var_2["loadoutPrimaryWeaponStruct.GUID"] != 0) {
      var_0[var_0.size] = maps\mp\_utility::_id_4737(var_2["loadoutPrimaryWeaponStruct"]);
    }

    if(isDefined(var_2["loadoutSecondaryWeaponStruct"]) && isDefined(var_2["loadoutSecondaryWeaponStruct.GUID"]) && var_2["loadoutSecondaryWeaponStruct.GUID"] != 17273856 && var_2["loadoutSecondaryWeaponStruct.GUID"] != 0) {
      var_0[var_0.size] = maps\mp\_utility::_id_4737(var_2["loadoutSecondaryWeaponStruct"]);
    }
  }

  if(var_0.size > 0) {
    self loadweapons(var_0);
  }
}

onspawnplayer() {
  if(isDefined(self.teamchangedthisframe)) {
    self.pers["gamemodeLoadout"] = level.infect_loadouts[self.pers["team"]];
    maps\mp\gametypes\_class::giveloadout(self.team, self.class);
    thread monitordisconnect();
  }

  self.teamchangedthisframe = undefined;
  preloadweapons();
  updateteamscores();

  if(!level.infect_choosingfirstinfected) {
    level.infect_choosingfirstinfected = 1;
    level thread choosefirstinfected();
  }

  if(self.infectedrejoined) {
    if(!level.infect_allowsuicide) {
      level notify("infect_stopCountdown");
      level.infect_chosefirstinfected = 1;
      level.infect_allowsuicide = 1;

      foreach(var_1 in level.players) {
        if(isDefined(var_1.infect_isbeingchosen)) {
          var_1.infect_isbeingchosen = undefined;
        }
      }
    }

    foreach(var_1 in level.players) {
      if(isDefined(var_1.isinitialinfected)) {
        var_1 thread setinitialtonormalinfected();
      }
    }

    if(level.infect_teamscores["axis"] == 1) {
      self.isinitialinfected = 1;
    }

    clearsurvivaltime();
  }

  if(isDefined(self.isinitialinfected)) {
    self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
    maps\mp\gametypes\_class::giveloadout(self.team, self.class);
  }

  thread onspawnfinished();
  level notify("spawned_player");
}

onspawnfinished() {
  self endon("death");
  self endon("disconnect");
  self waittill("applyLoadout");
  updateloadouts();
}

updateloadouts() {
  if(self.pers["team"] == "allies") {
    self clientaddsoundsubmix("mute_non_infected_vo");
  }

  if(self.pers["team"] == "axis") {
    _id_051E::clearkillstreaks();
    thread setinfectedmsg();
    thread _id_86AE();
    maps\mp\_utility::giveperk("specialty_lightweight");
    maps\mp\_utility::giveperk("specialty_fastclimb");
    maps\mp\_utility::giveperk("specialty_fastmantle");
    maps\mp\_utility::giveperk("specialty_falldamage");
    _id_0513::updatemovespeedscale();

    if(!_isai(self) && !istestclient(self)) {
      var_0 = undefined;

      if(self issplitscreenplayer()) {
        var_0 = common_scripts\utility::getfx("mp_infected_zombie_vision_spltscrn_01");
      } else {
        var_0 = common_scripts\utility::getfx("mp_infected_zombie_vision_01");
      }

      _playfxontagforclients(var_0, self, "j_head", self);
    }

    if(isDefined(self.infectedboost) && self.infectedboost) {
      self.maxhealth = 200;
      self.health = 200;
    }

    self disableweaponpickup();
    thread playzombienoises();
  }
}

playzombienoises() {
  self endon("death");
  level endon("game_ended");
  self clientaddsoundsubmix("mute_non_infected_vo");
  self playSound("zvox_gen_spawn");

  for(;;) {
    switch (randomint(7)) {
      case 0:
        self playSound("zvox_gen_snarl");
        break;
      case 1:
        self playSound("zvox_gen_growl_lev1");
        break;
      case 3:
        self playSound("zvox_gen_pain_lrg");
        break;
      case 5:
        self playSound("zvox_gen_sneakattack_success");
        break;
      case 6:
        self playSound("zvox_gen_taunt");
        break;
      default:
        self playSound("zvox_gen_snarl");
        break;
    }

    wait(_randomfloatrange(1.5, 6));
  }
}

_id_86AE() {
  self set_grenadeammo([492, 492, 0, 0, 0], "axis", 1, 0);
}

setinfectedmsg() {
  if(!isDefined(self.showninfected) || !self.showninfected) {
    thread _id_047A::gotinfectedevent();
    self playsoundtoplayer("mp_inf_got_infected", self);
    thread maps\mp\_utility::leaderdialogonplayer("inf_infected", "status");
    self.showninfected = 1;
  }
}

choosefirstinfected() {
  level endon("game_ended");
  level endon("infect_stopCountdown");
  level.infect_allowsuicide = 0;
  maps\mp\_utility::gameflagwait("prematch_done");
  level.infect_countdowninprogress = 1;
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  var_0 = 15;
  _setomnvar("ui_match_countdown_title", 7);
  _setomnvar("ui_match_countdown_toggle", 1);

  while(var_0 > 0 && !level.gameended) {
    var_0--;
    _setomnvar("ui_match_countdown", var_0 + 1);
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  }

  _setomnvar("ui_match_countdown", 0);
  _setomnvar("ui_match_countdown_title", 0);
  _setomnvar("ui_match_countdown_toggle", 0);
  level.infect_countdowninprogress = 0;
  var_1 = [];
  var_2 = undefined;

  foreach(var_4 in level.players) {
    if(maps\mp\_utility::matchmakinggame() && level.players.size > 1 && var_4 ishost()) {
      var_2 = var_4;
      continue;
    }

    if(var_4.team == "spectator") {
      continue;
    }
    if(!var_4.hasspawned) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  if(!var_1.size && isDefined(var_2)) {
    var_1[var_1.size] = var_2;
  }

  var_6 = var_1[randomint(var_1.size)];
  var_6 setfirstinfected(1);
  _id_0380::_id_6844("mp_zmb_infect_turn_init", undefined, var_6);

  foreach(var_4 in level.players) {
    if(var_4 == var_6) {
      continue;
    }
    var_4.survivalstarttime = gettime();
  }

  level thread randomcarepackagespawner();
}

randomcarepackagespawner() {
  level endon("game_ended");

  for(;;) {
    wait 30;

    if(_getteamplayersalive("allies") > 0) {
      var_0 = getrandomnodenearsurvivor();

      if(isDefined(var_0)) {
        level thread callinrandomcarepackage(var_0);
      }
    }
  }
}

getrandomnodenearsurvivor() {
  var_0 = undefined;

  foreach(var_2 in common_scripts\utility::array_randomize(level.teamlist["allies"])) {
    var_0 = _getnodesinradius(var_2.origin, 800, 0, 1000, "Path");

    if(isDefined(var_0) && var_0.size > 0) {
      foreach(var_4 in common_scripts\utility::array_randomize(var_0)) {
        if(isDefined(var_4) && _nodeexposedtosky(var_4)) {
          return var_4;
        }
      }
    }
  }

  var_0 = _getnodesinradius((0, 0, 0), 10000, 0, 10000, "Path");
  var_7 = undefined;

  foreach(var_4 in common_scripts\utility::array_randomize(var_0)) {
    if(isDefined(var_4) && _nodeexposedtosky(var_4)) {
      return var_4;
    }
  }

  return common_scripts\utility::random(var_0);
}

callinrandomcarepackage(var_0) {
  var_1 = undefined;
  var_2 = common_scripts\utility::array_randomize(level.players);

  foreach(var_4 in var_2) {
    if(var_4.team != "allies") {
      continue;
    }
    var_1 = var_4;
    break;
  }

  if(!isDefined(var_1)) {
    return;
  }
  var_6 = common_scripts\utility::random(["tripwire", "tripwire", "flamethrower", "flamethrower", "v2_rocket"]);
  var_7 = _id_0527::_id_4570();
  var_1 thread _id_0527::_id_9302(var_1._id_5CC6, [var_0.origin], [var_7], "carepackage", undefined, "allies", var_6);
}

prepareforclasschange() {
  while(!maps\mp\_utility::isreallyalive(self) || maps\mp\_utility::isusingremote()) {
    waitframe();
  }

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismeleeing()) {
    waitframe();
  }

  while(self ismantling()) {
    waitframe();
  }

  while(!self isonground() && !self isonladder()) {
    waitframe();
  }

  waitframe();

  while(!maps\mp\_utility::isreallyalive(self)) {
    waitframe();
  }
}

setfirstinfected(var_0) {
  self endon("disconnect");
  prepareforclasschange();

  if(var_0) {
    self.infect_isbeingchosen = 1;
    _id_04E8::_id_09FC("axis", undefined, 1);
    thread monitordisconnect();
    level.infect_chosefirstinfected = 1;
    self.infect_isbeingchosen = undefined;
    self.infectedboost = 0;
    thread watchforfirstinfectedkill();
    level notify("update_game_time", 0, 1);
    updateteamscores();
    level.infect_allowsuicide = 1;
    level.infect_players[self.name] = 1;

    if(!_isai(self) && !istestclient(self)) {
      var_1 = undefined;

      if(self issplitscreenplayer()) {
        var_1 = common_scripts\utility::getfx("mp_infected_zombie_vision_spltscrn_01");
      } else {
        var_1 = common_scripts\utility::getfx("mp_infected_zombie_vision_01");
      }

      _playfxontagforclients(var_1, self, "j_head", self);
    }

    var_2 = common_scripts\utility::getfx("infected_turn_lightning_01");
    _playFXOnTag(var_2, self, "tag_origin");
  }

  self.isinitialinfected = 1;
  self.showninfected = 1;
  self notify("faux_spawn");
  self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
  maps\mp\gametypes\_class::giveandapplyloadout(self.team, "gamemode");
  updateloadouts();
  thread _id_047A::firstinfectedevent();
  self playsoundtoplayer("mp_inf_got_infected", self);
  thread maps\mp\_utility::leaderdialogonplayer("inf_infected", "status");
  clearsurvivaltime();
}

setinitialtonormalinfected() {
  level endon("game_ended");
  self.isinitialinfected = undefined;
  prepareforclasschange();
  self notify("gotFirstInfectedKill");

  if(isDefined(self.infectedboost) && self.infectedboost) {
    self.maxhealth = 100;
    self.infectedboost = 0;
  }

  self notify("faux_spawn");
  self.pers["gamemodeLoadout"] = level.infect_loadouts["axis"];
  thread onspawnfinished();
  maps\mp\gametypes\_class::giveandapplyloadout(self.team, "gamemode");
}

watchforfirstinfectedkill() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gotFirstInfectedKill");
  wait 60;
  self.infectedboost = 1;

  if(getdvarint("spv_infect_throwing_knives_enabled", 0) == 1) {
    level.infect_loadouts["axis_initial"]["loadoutEquipmentStruct"] = maps\mp\_utility::_id_473C(16818176, 0);

    if(maps\mp\_utility::isreallyalive(self)) {
      self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
      maps\mp\gametypes\_class::giveandapplyloadout(self.team, "gamemode");
      updateloadouts();

      if(isDefined(self.setspawnpoint)) {
        _id_052C::deleteti(self.setspawnpoint);
      }
    }
  }

  if(maps\mp\_utility::isreallyalive(self)) {
    self.maxhealth = 200;
    self.health = 200;
    _id_0513::updatemovespeedscale();
  }
}

_id_6B7B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_1)) {
    return;
  }
  if(self.team == "axis" && isPlayer(var_1) && var_1.team == "allies" && maps\mp\_utility::ismeleemod(var_3)) {
    var_1 maps\mp\gametypes\_missions::processchallenge("ch_infect_tooclose");
  }

  if(self.team == "axis") {
    if(getdvarint("spv_tesla_mp_active", 0) == 1) {
      level thread _id_0513::potentiallyspawnteslagun(self.origin, 10);
    }

    var_1 _id_0468::ae_sendzombiekillevent(var_4, var_3);
    return;
  }

  var_10 = var_1 == self || !isPlayer(var_1);

  if(var_10 && !level.infect_allowsuicide) {
    return;
  }
  level notify("update_game_time");

  foreach(var_12 in level.players) {
    var_12 thread maps\mp\gametypes\_hud_message::splashnotify("infect_time_added");
  }

  self notify("delete_explosive_drones");
  self.teamchangedthisframe = 1;
  _id_04E8::_id_09FC("axis");
  setsurvivaltime(1);
  _id_511A();
  updateteamscores();
  maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured", "allies");
  maps\mp\_utility::playsoundonplayers("mp_war_objective_taken", "axis");
  level.infect_players[self.name] = 1;
  level thread maps\mp\_utility::teamplayercardsplash("callout_got_infected", self, "allies");
  _id_0380::_id_6845("mp_zmb_infect_turn_3d", level.players, self, self);
  _id_0380::_id_6840("mp_zmb_infect_turn_plr", self);

  if(!var_10) {
    var_1 maps\mp\_utility::delaythread(0.05, _id_047A::infectedsurvivorevent);
    var_1 playsoundtoplayer("mp_inf_infection_kill", var_1);
    var_1.killsasinfected++;
    var_1 maps\mp\_utility::setextrascore1(var_1.killsasinfected);

    if(var_1.killsasinfected % 3 == 0) {
      var_1 maps\mp\_utility::delaythread(0.05, _id_047A::plagueevent);
    }
  }

  if(level.infect_teamscores["axis"] == 2) {
    foreach(var_12 in level.players) {
      if(isDefined(var_12.isinitialinfected)) {
        var_12 thread setinitialtonormalinfected();
      }
    }
  }

  if(level.infect_teamscores["allies"] == 0) {
    onsurvivorseliminated();
    return;
  }

  if(level.infect_teamscores["allies"] == 1) {
    onfinalsurvivor();
    return;
  }
}

onfinalsurvivor() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1.team != "allies") {
      continue;
    }
    if(isDefined(var_1.awardedfinalsurvivor)) {
      continue;
    }
    var_1.awardedfinalsurvivor = 1;
    var_1 thread _id_047A::finalsurvivorevent();
    var_1 thread maps\mp\_utility::leaderdialogonplayer("inf_finalone");
    level thread maps\mp\_utility::leaderdialog("inf_finalone", "axis");
    level thread finalsurvivoruav(var_1);
    break;
  }
}

finalsurvivoruav(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("eliminated");
  level endon("infect_lateJoiner");
  level thread enduavonlatejoiner(var_0);
  var_1 = 0;
  level._id_014C["axis"] = "normal_radar";

  foreach(var_3 in level.players) {
    if(var_3.team == "axis") {
      var_3._id_014C = "normal_radar";
    }
  }

  _setteamradarstrength("axis", 1);

  for(;;) {
    var_5 = var_0.origin;
    wait 4;

    if(var_1) {
      _setteamradar("axis", 0);
      var_1 = 0;
    }

    wait 6;

    if(distance(var_5, var_0.origin) < 200) {
      _setteamradar("axis", 1);
      var_1 = 1;

      foreach(var_3 in level.players) {
        var_3 playlocalsound("recondrone_tag");
      }
    }
  }
}

enduavonlatejoiner(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("eliminated");

  for(;;) {
    if(level.infect_teamscores["allies"] > 1) {
      level notify("infect_lateJoiner");
      waitframe();
      _setteamradar("axis", 0);
      break;
    }

    waitframe();
  }
}

monitordisconnect() {
  level endon("game_ended");
  self endon("eliminated");
  self notify("infect_monitor_disconnect");
  self endon("infect_monitor_disconnect");
  var_0 = self.team;

  if(!isDefined(var_0) && isDefined(self.bot_team)) {
    var_0 = self.bot_team;
  }

  self waittill("disconnect");
  updateteamscores();

  if(isDefined(self.infect_isbeingchosen) || level.infect_chosefirstinfected) {
    if(level.infect_teamscores["axis"] && level.infect_teamscores["allies"]) {
      if(var_0 == "allies" && level.infect_teamscores["allies"] == 1) {
        onfinalsurvivor();
      } else if(var_0 == "axis" && level.infect_teamscores["axis"] == 1) {
        foreach(var_2 in level.players) {
          if(var_2 != self && var_2.team == "axis") {
            var_2 setfirstinfected(0);
          }
        }
      }
    } else if(level.infect_teamscores["allies"] == 0)
      onsurvivorseliminated();
    else if(level.infect_teamscores["axis"] == 0) {
      if(level.infect_teamscores["allies"] == 1) {
        level.finalkillcam_winner = "allies";
        level thread maps\mp\gametypes\_gamelogic::endgame("allies", game["end_reason"]["infected_eliminated"]);
      } else if(level.infect_teamscores["allies"] > 1) {
        level.infect_chosefirstinfected = 0;
        level thread choosefirstinfected();
      }
    }
  } else if(level.infect_countdowninprogress && level.infect_teamscores["allies"] == 0 && level.infect_teamscores["axis"] == 0) {
    level notify("infect_stopCountdown");
    level.infect_choosingfirstinfected = 0;
    _setomnvar("ui_match_start_countdown", 0);
  }

  self.isinitialinfected = undefined;
}

ondeadevent(var_0) {
  return;
}

ontimelimit() {
  level.finalkillcam_winner = "allies";

  foreach(var_1 in level.players) {
    if(isDefined(var_1.team) && var_1.team == "axis") {
      if(!_isai(var_1) && !istestclient(var_1)) {
        var_2 = undefined;

        if(var_1 issplitscreenplayer()) {
          var_2 = common_scripts\utility::getfx("mp_infected_zombie_vision_spltscrn_01");
        } else {
          var_2 = common_scripts\utility::getfx("mp_infected_zombie_vision_01");
        }

        _killfxontagforclient(var_2, var_1, "j_head", var_1);
      }
    }
  }

  level thread maps\mp\gametypes\_gamelogic::endgame("allies", game["end_reason"]["time_limit_reached"]);
}

onsurvivorseliminated() {
  level.finalkillcam_winner = "axis";

  foreach(var_1 in level.players) {
    if(isDefined(var_1.team) && var_1.team == "axis") {
      if(!_isai(var_1) && !istestclient(var_1)) {
        var_2 = undefined;

        if(var_1 issplitscreenplayer()) {
          var_2 = common_scripts\utility::getfx("mp_infected_zombie_vision_spltscrn_01");
        } else {
          var_2 = common_scripts\utility::getfx("mp_infected_zombie_vision_01");
        }

        _killfxontagforclient(var_2, var_1, "j_head", var_1);
      }
    }
  }

  level thread maps\mp\gametypes\_gamelogic::endgame("axis", game["end_reason"]["survivors_eliminated"]);
}

getteamsize(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(var_3.sessionstate == "spectator" && !var_3._id_0188) {
      continue;
    }
    if(var_3.team == var_0) {
      var_1++;
    }
  }

  return var_1;
}

updateteamscores() {
  level.infect_teamscores["allies"] = getteamsize("allies");
  game["teamScores"]["allies"] = level.infect_teamscores["allies"];
  _setteamscore("allies", level.infect_teamscores["allies"]);
  level.infect_teamscores["axis"] = getteamsize("axis");
  game["teamScores"]["axis"] = level.infect_teamscores["axis"];
  _setteamscore("axis", level.infect_teamscores["axis"]);
}

setspecialloadouts() {
  if(_isusingmatchrulesdata() && _getmatchrulesdata("defaultClasses", "allies", "defaultClass", 0, "class", "inUse")) {
    level.infect_loadouts["allies"] = maps\mp\_utility::getmatchrulesspecialclass("allies", 0);
  } else if(level.rankedmatch) {
    level.infect_loadouts["allies"] = maps\mp\gametypes\_class::getemptyloadout();
    level.infect_loadouts["allies"]["loadoutDivision"] = 0;
    level.infect_loadouts["allies"]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(16953344, 0);
    level.infect_loadouts["allies"]["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::_id_473C(16871424, 0);
    level.infect_loadouts["allies"]["loadoutEquipmentStruct"] = maps\mp\_utility::_id_473C(16990208, 0);
    level.infect_loadouts["allies"]["loadoutEquipmentNumExtra"] = 1;
    level.infect_loadouts["allies"]["loadoutOffhandStruct"] = maps\mp\_utility::_id_473C(17027072, 0);
    level.infect_loadouts["allies"]["loadoutPerksGUID"][0] = maps\mp\_utility::_id_452A("specialty_bulletresupply");
    level.infect_loadouts["allies"]["loadoutPerksGUID"][1] = maps\mp\_utility::_id_452A("specialty_scavenger");
    level.infect_loadouts["allies"]["ignoreMeleeSlotWeapon"] = 1;
  } else {
    level.infect_loadouts["allies"] = maps\mp\gametypes\_class::getemptyloadout();
    level.infect_loadouts["allies"]["loadoutDivision"] = 0;
    level.infect_loadouts["allies"]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(16953344, 0);
    level.infect_loadouts["allies"]["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::_id_473C(16871424, 0);
    level.infect_loadouts["allies"]["loadoutEquipmentStruct"] = maps\mp\_utility::_id_473C(16990208, 0);
    level.infect_loadouts["allies"]["loadoutEquipmentNumExtra"] = 1;
    level.infect_loadouts["allies"]["loadoutOffhandStruct"] = maps\mp\_utility::_id_473C(17027072, 0);
    level.infect_loadouts["allies"]["loadoutPerksGUID"][0] = maps\mp\_utility::_id_452A("specialty_bulletresupply");
    level.infect_loadouts["allies"]["loadoutPerksGUID"][1] = maps\mp\_utility::_id_452A("specialty_scavenger");
    level.infect_loadouts["allies"]["ignoreMeleeSlotWeapon"] = 1;
  }

  if(_isusingmatchrulesdata() && _getmatchrulesdata("defaultClasses", "axis", "defaultClass", 1, "class", "inUse")) {
    level.infect_loadouts["axis_initial"] = maps\mp\_utility::getmatchrulesspecialclass("axis", 1);
  } else {
    level.infect_loadouts["axis_initial"] = maps\mp\gametypes\_class::getemptyloadout();
    level.infect_loadouts["axis_initial"]["loadoutDivision"] = 1;
    level.infect_loadouts["axis_initial"]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(17273856, 0);
    var_0 = maps\mp\_utility::_id_452A("s2_tactical_insertion_device_mp");
    level.infect_loadouts["axis_initial"]["loadoutOffhandStruct"] = maps\mp\_utility::_id_473C(var_0, 0);
  }

  if(_isusingmatchrulesdata() && _getmatchrulesdata("defaultClasses", "axis", "defaultClass", 0, "class", "inUse")) {
    level.infect_loadouts["axis"] = maps\mp\_utility::getmatchrulesspecialclass("axis", 0);
  } else {
    level.infect_loadouts["axis"] = maps\mp\gametypes\_class::getemptyloadout();
    level.infect_loadouts["axis"]["loadoutDivision"] = 1;
    level.infect_loadouts["axis"]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(17273856, 0);
    level.infect_loadouts["axis"]["loadoutOffhandStruct"] = maps\mp\_utility::_id_473C(maps\mp\_utility::_id_452A("s2_tactical_insertion_device_mp"), 0);
  }
}

monitorsurvivaltime() {
  self endon("death");
  self endon("disconnect");
  self endon("infected");
  level endon("game_ended");
  var_0 = 0;

  for(;;) {
    if(!level.infect_chosefirstinfected || !isDefined(self.survivalstarttime) || !isalive(self)) {
      waitframe();
      continue;
    }

    setsurvivaltime(0);
    var_0++;
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1.0);

    if(var_0 == 30) {
      thread _id_047A::survivorevent();
      var_0 = 0;
    }
  }
}

clearsurvivaltime() {
  maps\mp\_utility::setextrascore0(0);
  self notify("infected");
}

setsurvivaltime(var_0) {
  if(!isDefined(self.survivalstarttime)) {
    self.survivalstarttime = level._id_5CC7[self._id_5CC6];
  }

  var_1 = int((gettime() - self.survivalstarttime) / 1000);

  if(var_1 > 999) {
    var_1 = 999;
  }

  maps\mp\_utility::setextrascore0(var_1);

  if(isDefined(var_0) && var_0) {
    self notify("infected");
  }
}