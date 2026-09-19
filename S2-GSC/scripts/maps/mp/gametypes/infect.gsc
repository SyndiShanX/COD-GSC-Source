/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\infect.gsc
************************************************/

main() {
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
    level._id_5300 = ::_id_5300;
    [[level._id_5300]]();
    level thread maps\mp\_utility::_id_7C13();
  } else {
    maps\mp\_utility::registertimelimitdvar(level.gametype, 10);
    maps\mp\_utility::_id_86EA("scorelimit", 0);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level._id_6032 = 1;
    level._id_6031 = 0;
  }

  _id_872E();
  setdvarifuninitialized("spv_tesla_mp_active", 0);
  maps\mp\_utility::_id_873B(1);
  level._id_329D = 1;
  level.disableforfeit = 1;
  level._id_6702 = 1;
  level._id_6BAF = ::_id_6BAF;
  level._id_6BA7 = ::_id_6BA7;
  level._id_6B7B = ::_id_6B7B;
  level._id_6AE2 = ::_id_6AE2;
  level._id_6BB6 = ::_id_6BB6;
  level._id_1385 = ::_id_5117;
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

  if(level._id_6031)
    level._id_62AD = maps\mp\gametypes\_damage::_id_3FC8;

  game["dialog"]["gametype"] = "inf_intro";

  if(getdvarint("2043"))
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];

  game["dialog"]["inf_finalone"] = "inf_finalone";
  game["dialog"]["inf_infected"] = "inf_infected";
  game["dialog"]["inf_timeadded"] = "inf_timeadded";
  level._effect["mp_infected_zombie_vision_01"] = loadfx("vfx/unique/mp_infected_zombie_vision_01");
  level._effect["mp_infected_zombie_vision_spltscrn_01"] = loadfx("vfx/unique/mp_infected_zombie_vision_spltscrn_01");
  level._effect["infected_turn_lightning_01"] = loadfx("vfx/unique/infected_turn_lightning_01");
  level._effect["tesla_gun_glow"] = loadfx("vfx/unique/mp_loot_ray_01");
}

_id_5300() {
  maps\mp\_utility::_id_8653();
  level._id_6032 = _getmatchrulesdata("infectData", "numInitialInfected");
  _setdynamicdvar("scr_" + level.gametype + "_numLives", 0);
  maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
  maps\mp\_utility::_id_86EA("scorelimit", 0);
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

_id_6BAF() {
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
  level._id_7895 = 1;
  level._id_17EF = 1;
  level._id_510F = 0;
  level._id_5111 = 0;
  level._id_5110 = 0;
  level._id_5112 = 0;
  level._id_5116["axis"] = 0;
  level._id_5116["allies"] = 0;
  level._id_5115 = [];
  level.mgnestsdisabled = 1;
  level thread maps\mp\gametypes\_raid_tripwire::runtripwirelogic();
  level thread onplayerconnect();
  level thread _id_3FD8();
}

_id_3FD8() {
  level endon("game_ended");
  _setdynamicdvar("scr_infect_timelimit", 0);
  var_0 = 0;
  var_1 = undefined;
  var_2 = 2;
  var_3 = 1;

  for(;;) {
    level waittill("update_game_time", var_4, var_5);
    var_1 = undefined;

    if(isDefined(var_5) && var_5)
      var_1 = maps\mp\_utility::gettimepassed() / 60000 + var_2;
    else if(isDefined(var_4) && var_4 == 1)
      var_6 = var_3 * 0.166667 + var_2;
    else {
      var_3++;
      var_1 = var_3 * 0.166667 + var_2;
    }

    _setdynamicdvar("scr_infect_timelimit", var_1);
    level thread _id_A91E(var_1);

    if(var_0)
      level thread maps\mp\_utility::leaderdialogbothteams("inf_timeadded", "axis", "inf_timeadded", "allies", "status");

    var_0 = 1;
  }
}

_id_A91E(var_0) {
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
    var_0._id_511C = 0;
    var_0._id_5A51 = 0;

    if(!_isai(var_0) && !istestclient(var_0))
      var_0 thread monitorinfectedafk();

    if(maps\mp\_utility::gameflag("prematch_done")) {
      if(isDefined(level._id_5111) && level._id_5111)
        var_0._id_9521 = gettime();
    }

    if(isDefined(level._id_5115[var_0.name]))
      var_0._id_511C = 1;

    var_0 thread _id_63E8();
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
    level thread maps\mp\gametypes\_gamelogic::_id_A11E();
  }
}

infectedmovespeedscale() {
  if(self.pers["team"] == "axis") {
    if(isDefined(self.infectedboost) && self.infectedboost)
      return 1.35;
    else
      return 1.1;
  } else
    return 1;
}

_id_5117() {
  var_0 = "allies";

  if(self._id_511C)
    var_0 = "axis";

  thread _id_04E8::_id_873A(var_0);
}

_id_511A() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.pers["gamemodeLoadout"] = level._id_5114[self.pers["team"]];
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  _id_7685();
}

_id_7685() {
  var_0 = [];

  foreach(var_2 in level._id_5114) {
    if(isDefined(var_2["loadoutPrimaryWeaponStruct"]) && isDefined(var_2["loadoutPrimaryWeaponStruct.GUID"]) && var_2["loadoutPrimaryWeaponStruct.GUID"] != 17273856 && var_2["loadoutPrimaryWeaponStruct.GUID"] != 0)
      var_0[var_0.size] = maps\mp\_utility::_id_4737(var_2["loadoutPrimaryWeaponStruct"]);

    if(isDefined(var_2["loadoutSecondaryWeaponStruct"]) && isDefined(var_2["loadoutSecondaryWeaponStruct.GUID"]) && var_2["loadoutSecondaryWeaponStruct.GUID"] != 17273856 && var_2["loadoutSecondaryWeaponStruct.GUID"] != 0)
      var_0[var_0.size] = maps\mp\_utility::_id_4737(var_2["loadoutSecondaryWeaponStruct"]);
  }

  if(var_0.size > 0)
    self loadweapons(var_0);
}

_id_6BA7() {
  if(isDefined(self._id_984E)) {
    self.pers["gamemodeLoadout"] = level._id_5114[self.pers["team"]];
    maps\mp\gametypes\_class::_id_4790(self.team, self.class);
    thread _id_637D();
  }

  self._id_984E = undefined;
  _id_7685();
  _id_A175();

  if(!level._id_5110) {
    level._id_5110 = 1;
    level thread _id_220B();
  }

  if(self._id_511C) {
    if(!level._id_510F) {
      level notify("infect_stopCountdown");
      level._id_5111 = 1;
      level._id_510F = 1;

      foreach(var_1 in level.players) {
        if(isDefined(var_1._id_5113))
          var_1._id_5113 = undefined;
      }
    }

    foreach(var_1 in level.players) {
      if(isDefined(var_1._id_5726))
        var_1 thread _id_86B1();
    }

    if(level._id_5116["axis"] == 1)
      self._id_5726 = 1;

    _id_240F();
  }

  if(isDefined(self._id_5726)) {
    self.pers["gamemodeLoadout"] = level._id_5114["axis_initial"];
    maps\mp\gametypes\_class::_id_4790(self.team, self.class);
  }

  thread _id_6BA4();
  level notify("spawned_player");
}

_id_6BA4() {
  self endon("death");
  self endon("disconnect");
  self waittill("applyLoadout");
  _id_A12F();
}

_id_A12F() {
  if(self.pers["team"] == "allies")
    self clientaddsoundsubmix("mute_non_infected_vo");

  if(self.pers["team"] == "axis") {
    _id_051E::_id_2400();
    thread _id_86AF();
    thread _id_86AE();
    maps\mp\_utility::giveperk("specialty_lightweight");
    maps\mp\_utility::giveperk("specialty_fastclimb");
    maps\mp\_utility::giveperk("specialty_fastmantle");
    maps\mp\_utility::giveperk("specialty_falldamage");
    _id_0513::_id_A13B();

    if(!_isai(self) && !istestclient(self)) {
      var_0 = undefined;

      if(self issplitscreenplayer())
        var_0 = common_scripts\utility::_id_44F5("mp_infected_zombie_vision_spltscrn_01");
      else
        var_0 = common_scripts\utility::_id_44F5("mp_infected_zombie_vision_01");

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
  self _meth_84C7([492, 492, 0, 0, 0], "axis", 1, 0);
}

_id_86AF() {
  if(!isDefined(self._id_8C0E) || !self._id_8C0E) {
    thread _id_047A::_id_4817();
    self playsoundtoplayer("mp_inf_got_infected", self);
    thread maps\mp\_utility::leaderdialogonplayer("inf_infected", "status");
    self._id_8C0E = 1;
  }
}

_id_220B() {
  level endon("game_ended");
  level endon("infect_stopCountdown");
  level._id_510F = 0;
  maps\mp\_utility::gameflagwait("prematch_done");
  level._id_5112 = 1;
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
  level._id_5112 = 0;
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

  if(!var_1.size && isDefined(var_2))
    var_1[var_1.size] = var_2;

  var_6 = var_1[randomint(var_1.size)];
  var_6 _id_8682(1);
  _id_0380::_id_6844("mp_zmb_infect_turn_init", undefined, var_6);

  foreach(var_4 in level.players) {
    if(var_4 == var_6) {
      continue;
    }
    var_4._id_9521 = gettime();
  }

  level thread randomcarepackagespawner();
}

randomcarepackagespawner() {
  level endon("game_ended");

  for(;;) {
    wait 30;

    if(_getteamplayersalive("allies") > 0) {
      var_0 = getrandomnodenearsurvivor();

      if(isDefined(var_0))
        level thread callinrandomcarepackage(var_0);
    }
  }
}

getrandomnodenearsurvivor() {
  var_0 = undefined;

  foreach(var_2 in common_scripts\utility::array_randomize(level._id_9859["allies"])) {
    var_0 = _getnodesinradius(var_2.origin, 800, 0, 1000, "Path");

    if(isDefined(var_0) && var_0.size > 0) {
      foreach(var_4 in common_scripts\utility::array_randomize(var_0)) {
        if(isDefined(var_4) && _nodeexposedtosky(var_4))
          return var_4;
      }
    }
  }

  var_0 = _getnodesinradius((0, 0, 0), 10000, 0, 10000, "Path");
  var_7 = undefined;

  foreach(var_4 in common_scripts\utility::array_randomize(var_0)) {
    if(isDefined(var_4) && _nodeexposedtosky(var_4))
      return var_4;
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

_id_76A2() {
  while(!maps\mp\_utility::isreallyalive(self) || maps\mp\_utility::isusingremote())
    waitframe();

  if(isDefined(self._id_56A3) && self._id_56A3 == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismeleeing())
    waitframe();

  while(self ismantling())
    waitframe();

  while(!self isonground() && !self isonladder())
    waitframe();

  waitframe();

  while(!maps\mp\_utility::isreallyalive(self))
    waitframe();
}

_id_8682(var_0) {
  self endon("disconnect");
  _id_76A2();

  if(var_0) {
    self._id_5113 = 1;
    _id_04E8::_id_09FC("axis", undefined, 1);
    thread _id_637D();
    level._id_5111 = 1;
    self._id_5113 = undefined;
    self.infectedboost = 0;
    thread watchforfirstinfectedkill();
    level notify("update_game_time", 0, 1);
    _id_A175();
    level._id_510F = 1;
    level._id_5115[self.name] = 1;

    if(!_isai(self) && !istestclient(self)) {
      var_1 = undefined;

      if(self issplitscreenplayer())
        var_1 = common_scripts\utility::_id_44F5("mp_infected_zombie_vision_spltscrn_01");
      else
        var_1 = common_scripts\utility::_id_44F5("mp_infected_zombie_vision_01");

      _playfxontagforclients(var_1, self, "j_head", self);
    }

    var_2 = common_scripts\utility::_id_44F5("infected_turn_lightning_01");
    _playfxontag(var_2, self, "tag_origin");
  }

  self._id_5726 = 1;
  self._id_8C0E = 1;
  self notify("faux_spawn");
  self.pers["gamemodeLoadout"] = level._id_5114["axis_initial"];
  maps\mp\gametypes\_class::_id_4773(self.team, "gamemode");
  _id_A12F();
  thread _id_047A::_id_3C69();
  self playsoundtoplayer("mp_inf_got_infected", self);
  thread maps\mp\_utility::leaderdialogonplayer("inf_infected", "status");
  _id_240F();
}

_id_86B1() {
  level endon("game_ended");
  self._id_5726 = undefined;
  _id_76A2();
  self notify("gotFirstInfectedKill");

  if(isDefined(self.infectedboost) && self.infectedboost) {
    self.maxhealth = 100;
    self.infectedboost = 0;
  }

  self notify("faux_spawn");
  self.pers["gamemodeLoadout"] = level._id_5114["axis"];
  thread _id_6BA4();
  maps\mp\gametypes\_class::_id_4773(self.team, "gamemode");
}

watchforfirstinfectedkill() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gotFirstInfectedKill");
  wait 60;
  self.infectedboost = 1;

  if(getdvarint("spv_infect_throwing_knives_enabled", 0) == 1) {
    level._id_5114["axis_initial"]["loadoutEquipmentStruct"] = maps\mp\_utility::_id_473C(16818176, 0);

    if(maps\mp\_utility::isreallyalive(self)) {
      self.pers["gamemodeLoadout"] = level._id_5114["axis_initial"];
      maps\mp\gametypes\_class::_id_4773(self.team, "gamemode");
      _id_A12F();

      if(isDefined(self._id_872A))
        _id_052C::_id_2D54(self._id_872A);
    }
  }

  if(maps\mp\_utility::isreallyalive(self)) {
    self.maxhealth = 200;
    self.health = 200;
    _id_0513::_id_A13B();
  }
}

_id_6B7B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_1)) {
    return;
  }
  if(self.team == "axis" && isPlayer(var_1) && var_1.team == "allies" && maps\mp\_utility::_id_5755(var_3))
    var_1 maps\mp\gametypes\_missions::processchallenge("ch_infect_tooclose");

  if(self.team == "axis") {
    if(getdvarint("spv_tesla_mp_active", 0) == 1)
      level thread _id_0513::potentiallyspawnteslagun(self.origin, 10);

    var_1 _id_0468::ae_sendzombiekillevent(var_4, var_3);
    return;
  }

  var_10 = var_1 == self || !isPlayer(var_1);

  if(var_10 && !level._id_510F) {
    return;
  }
  level notify("update_game_time");

  foreach(var_12 in level.players)
  var_12 thread maps\mp\gametypes\_hud_message::_id_9102("infect_time_added");

  self notify("delete_explosive_drones");
  self._id_984E = 1;
  _id_04E8::_id_09FC("axis");
  _id_8738(1);
  _id_511A();
  _id_A175();
  maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured", "allies");
  maps\mp\_utility::playsoundonplayers("mp_war_objective_taken", "axis");
  level._id_5115[self.name] = 1;
  level thread maps\mp\_utility::teamplayercardsplash("callout_got_infected", self, "allies");
  _id_0380::_id_6845("mp_zmb_infect_turn_3d", level.players, self, self);
  _id_0380::_id_6840("mp_zmb_infect_turn_plr", self);

  if(!var_10) {
    var_1 maps\mp\_utility::_id_2CED(0.05, _id_047A::_id_511D);
    var_1 playsoundtoplayer("mp_inf_infection_kill", var_1);
    var_1._id_5A51++;
    var_1 maps\mp\_utility::_id_867C(var_1._id_5A51);

    if(var_1._id_5A51 % 3 == 0)
      var_1 maps\mp\_utility::_id_2CED(0.05, _id_047A::_id_700A);
  }

  if(level._id_5116["axis"] == 2) {
    foreach(var_12 in level.players) {
      if(isDefined(var_12._id_5726))
        var_12 thread _id_86B1();
    }
  }

  if(level._id_5116["allies"] == 0) {
    _id_6BB3();
    return;
  }

  if(level._id_5116["allies"] == 1) {
    _id_6B37();
    return;
  }
}

_id_6B37() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1.team != "allies") {
      continue;
    }
    if(isDefined(var_1._id_1456)) {
      continue;
    }
    var_1._id_1456 = 1;
    var_1 thread _id_047A::_id_3B5F();
    var_1 thread maps\mp\_utility::leaderdialogonplayer("inf_finalone");
    level thread maps\mp\_utility::leaderdialog("inf_finalone", "axis");
    level thread _id_3B60(var_1);
    break;
  }
}

_id_3B60(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("eliminated");
  level endon("infect_lateJoiner");
  level thread _id_36EE(var_0);
  var_1 = 0;
  level._id_014C["axis"] = "normal_radar";

  foreach(var_3 in level.players) {
    if(var_3.team == "axis")
      var_3._id_014C = "normal_radar";
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

      foreach(var_3 in level.players)
      var_3 playlocalsound("recondrone_tag");
    }
  }
}

_id_36EE(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("eliminated");

  for(;;) {
    if(level._id_5116["allies"] > 1) {
      level notify("infect_lateJoiner");
      waitframe();
      _setteamradar("axis", 0);
      break;
    }

    waitframe();
  }
}

_id_637D() {
  level endon("game_ended");
  self endon("eliminated");
  self notify("infect_monitor_disconnect");
  self endon("infect_monitor_disconnect");
  var_0 = self.team;

  if(!isDefined(var_0) && isDefined(self._id_1AFA))
    var_0 = self._id_1AFA;

  self waittill("disconnect");
  _id_A175();

  if(isDefined(self._id_5113) || level._id_5111) {
    if(level._id_5116["axis"] && level._id_5116["allies"]) {
      if(var_0 == "allies" && level._id_5116["allies"] == 1)
        _id_6B37();
      else if(var_0 == "axis" && level._id_5116["axis"] == 1) {
        foreach(var_2 in level.players) {
          if(var_2 != self && var_2.team == "axis")
            var_2 _id_8682(0);
        }
      }
    } else if(level._id_5116["allies"] == 0)
      _id_6BB3();
    else if(level._id_5116["axis"] == 0) {
      if(level._id_5116["allies"] == 1) {
        level._id_3B5C = "allies";
        level thread maps\mp\gametypes\_gamelogic::_id_36B9("allies", game["end_reason"]["infected_eliminated"]);
      } else if(level._id_5116["allies"] > 1) {
        level._id_5111 = 0;
        level thread _id_220B();
      }
    }
  } else if(level._id_5112 && level._id_5116["allies"] == 0 && level._id_5116["axis"] == 0) {
    level notify("infect_stopCountdown");
    level._id_5110 = 0;
    _setomnvar("ui_match_start_countdown", 0);
  }

  self._id_5726 = undefined;
}

_id_6AE2(var_0) {
  return;
}

_id_6BB6() {
  level._id_3B5C = "allies";

  foreach(var_1 in level.players) {
    if(isDefined(var_1.team) && var_1.team == "axis") {
      if(!_isai(var_1) && !istestclient(var_1)) {
        var_2 = undefined;

        if(var_1 issplitscreenplayer())
          var_2 = common_scripts\utility::_id_44F5("mp_infected_zombie_vision_spltscrn_01");
        else
          var_2 = common_scripts\utility::_id_44F5("mp_infected_zombie_vision_01");

        _killfxontagforclient(var_2, var_1, "j_head", var_1);
      }
    }
  }

  level thread maps\mp\gametypes\_gamelogic::_id_36B9("allies", game["end_reason"]["time_limit_reached"]);
}

_id_6BB3() {
  level._id_3B5C = "axis";

  foreach(var_1 in level.players) {
    if(isDefined(var_1.team) && var_1.team == "axis") {
      if(!_isai(var_1) && !istestclient(var_1)) {
        var_2 = undefined;

        if(var_1 issplitscreenplayer())
          var_2 = common_scripts\utility::_id_44F5("mp_infected_zombie_vision_spltscrn_01");
        else
          var_2 = common_scripts\utility::_id_44F5("mp_infected_zombie_vision_01");

        _killfxontagforclient(var_2, var_1, "j_head", var_1);
      }
    }
  }

  level thread maps\mp\gametypes\_gamelogic::_id_36B9("axis", game["end_reason"]["survivors_eliminated"]);
}

_id_46D7(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(var_3.sessionstate == "spectator" && !var_3._id_0188) {
      continue;
    }
    if(var_3.team == var_0)
      var_1++;
  }

  return var_1;
}

_id_A175() {
  level._id_5116["allies"] = _id_46D7("allies");
  game["teamScores"]["allies"] = level._id_5116["allies"];
  _setteamscore("allies", level._id_5116["allies"]);
  level._id_5116["axis"] = _id_46D7("axis");
  game["teamScores"]["axis"] = level._id_5116["axis"];
  _setteamscore("axis", level._id_5116["axis"]);
}

_id_872E() {
  if(_isusingmatchrulesdata() && _getmatchrulesdata("defaultClasses", "allies", "defaultClass", 0, "class", "inUse"))
    level._id_5114["allies"] = maps\mp\_utility::_id_4573("allies", 0);
  else if(level.rankedmatch) {
    level._id_5114["allies"] = maps\mp\gametypes\_class::_id_44B4();
    level._id_5114["allies"]["loadoutDivision"] = 0;
    level._id_5114["allies"]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(16953344, 0);
    level._id_5114["allies"]["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::_id_473C(16871424, 0);
    level._id_5114["allies"]["loadoutEquipmentStruct"] = maps\mp\_utility::_id_473C(16990208, 0);
    level._id_5114["allies"]["loadoutEquipmentNumExtra"] = 1;
    level._id_5114["allies"]["loadoutOffhandStruct"] = maps\mp\_utility::_id_473C(17027072, 0);
    level._id_5114["allies"]["loadoutPerksGUID"][0] = maps\mp\_utility::_id_452A("specialty_bulletresupply");
    level._id_5114["allies"]["loadoutPerksGUID"][1] = maps\mp\_utility::_id_452A("specialty_scavenger");
    level._id_5114["allies"]["ignoreMeleeSlotWeapon"] = 1;
  } else {
    level._id_5114["allies"] = maps\mp\gametypes\_class::_id_44B4();
    level._id_5114["allies"]["loadoutDivision"] = 0;
    level._id_5114["allies"]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(16953344, 0);
    level._id_5114["allies"]["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::_id_473C(16871424, 0);
    level._id_5114["allies"]["loadoutEquipmentStruct"] = maps\mp\_utility::_id_473C(16990208, 0);
    level._id_5114["allies"]["loadoutEquipmentNumExtra"] = 1;
    level._id_5114["allies"]["loadoutOffhandStruct"] = maps\mp\_utility::_id_473C(17027072, 0);
    level._id_5114["allies"]["loadoutPerksGUID"][0] = maps\mp\_utility::_id_452A("specialty_bulletresupply");
    level._id_5114["allies"]["loadoutPerksGUID"][1] = maps\mp\_utility::_id_452A("specialty_scavenger");
    level._id_5114["allies"]["ignoreMeleeSlotWeapon"] = 1;
  }

  if(_isusingmatchrulesdata() && _getmatchrulesdata("defaultClasses", "axis", "defaultClass", 1, "class", "inUse"))
    level._id_5114["axis_initial"] = maps\mp\_utility::_id_4573("axis", 1);
  else {
    level._id_5114["axis_initial"] = maps\mp\gametypes\_class::_id_44B4();
    level._id_5114["axis_initial"]["loadoutDivision"] = 1;
    level._id_5114["axis_initial"]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(17273856, 0);
    var_0 = maps\mp\_utility::_id_452A("s2_tactical_insertion_device_mp");
    level._id_5114["axis_initial"]["loadoutOffhandStruct"] = maps\mp\_utility::_id_473C(var_0, 0);
  }

  if(_isusingmatchrulesdata() && _getmatchrulesdata("defaultClasses", "axis", "defaultClass", 0, "class", "inUse"))
    level._id_5114["axis"] = maps\mp\_utility::_id_4573("axis", 0);
  else {
    level._id_5114["axis"] = maps\mp\gametypes\_class::_id_44B4();
    level._id_5114["axis"]["loadoutDivision"] = 1;
    level._id_5114["axis"]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(17273856, 0);
    level._id_5114["axis"]["loadoutOffhandStruct"] = maps\mp\_utility::_id_473C(maps\mp\_utility::_id_452A("s2_tactical_insertion_device_mp"), 0);
  }
}

_id_63E8() {
  self endon("death");
  self endon("disconnect");
  self endon("infected");
  level endon("game_ended");
  var_0 = 0;

  for(;;) {
    if(!level._id_5111 || !isDefined(self._id_9521) || !isalive(self)) {
      waitframe();
      continue;
    }

    _id_8738(0);
    var_0++;
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1.0);

    if(var_0 == 30) {
      thread _id_047A::_id_9522();
      var_0 = 0;
    }
  }
}

_id_240F() {
  maps\mp\_utility::_id_867B(0);
  self notify("infected");
}

_id_8738(var_0) {
  if(!isDefined(self._id_9521))
    self._id_9521 = level._id_5CC7[self._id_5CC6];

  var_1 = int((gettime() - self._id_9521) / 1000);

  if(var_1 > 999)
    var_1 = 999;

  maps\mp\_utility::_id_867B(var_1);

  if(isDefined(var_0) && var_0)
    self notify("infected");
}