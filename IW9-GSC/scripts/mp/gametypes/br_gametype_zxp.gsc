/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_zxp.gsc
****************************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "zxp") {
    return;
  }
  init();
}

init() {
  _id_362C58E8BB39BCDA::disablefeature("gulag");
  _id_362C58E8BB39BCDA::disablefeature("randomizeCircleCenter");
  _id_362C58E8BB39BCDA::disablefeature("planeSnapToOOB");
  _id_362C58E8BB39BCDA::disablefeature("match_start_VO");

  if(getdvarint("dvar_C7F6B4289DEC1B29", 1) != 0)
    _id_362C58E8BB39BCDA::disablefeature("littleBirdSpawns");

  _id_362C58E8BB39BCDA::enablefeature("planeUseCircleRadius");
  _id_362C58E8BB39BCDA::enablefeature("circleEarlyStart");
  level._id_1FA2A6B50267656A = ::_id_46B4BD6590584475;
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerShouldRespawn", ::playershouldrespawn);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("createC130PathStruct", ::createc130pathstruct);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("addToC130Infil", ::addtoc130infil);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerSkipLootPickup", ::playerskiplootpickup);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerSkipKioskUse", ::playerskipkioskuse);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerKilled", ::onplayerkilled);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("vipRespawnPlayer", ::_id_8E4317F4E78B9488);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("circleTimerNext", ::circletimernext);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("markPlayerAsEliminatedOnKilled", ::markplayeraseliminatedonkilled);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerKilledSpawn", ::playerkilledspawn);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("addToTeamLives", ::addtoteamlives);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("removeFromTeamLives", ::removefromteamlives);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerWelcomeSplashes", ::playerwelcomesplashes);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("allowMeleeVehicleDamage", ::allowmeleevehicledamage);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerNakedDropLoadout", ::playernakeddroploadout);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("dropOnPlayerDeath", ::droponplayerdeath);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("shouldLastStandDamageScale", ::_id_64342424F3CF7F93);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("exfilStart", ::_id_9C0B1751FEFA2B39);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("gulagWinnerRespawn", ::gulagwinnerrespawn);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerConnect", ::onplayerconnect);
  scripts\cp_mp\utility\script_utility::registersharedfunc("zxp", "packClientMatchData", ::packclientmatchdata);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("remainingPlayersAliveOnTeam", _id_0F820C96419FE887::_id_561F3BEAF33B80C0);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("spawnHandled", _id_0F820C96419FE887::spawnhandled);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("mayConsiderPlayerDead", _id_0F820C96419FE887::mayconsiderplayerdead);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("modifyPlayerDamage", _id_0F820C96419FE887::modifyplayerdamage);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("modifyVehicleDamage", _id_0F820C96419FE887::modifyvehicledamage);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("ignoreVehicleExplosiveDamage", _id_0F820C96419FE887::ignorevehicleexplosivedamage);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("regenHealthAdd", _id_0F820C96419FE887::playerregenhealthadd);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("regenDelaySpeed", _id_0F820C96419FE887::playerregendelayspeed);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("postUpdateGameEvents", _id_0F820C96419FE887::postupdategameevents);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("lastStandAllowed", _id_0F820C96419FE887::laststandallowed);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("kioskRevivePlayer", _id_0F820C96419FE887::kioskreviveplayer);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerDamaged", _id_0F820C96419FE887::onplayerdamaged);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("endGame", _id_0F820C96419FE887::_id_0330F2255DA6B470);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("isValidSpectateTarget", _id_0F820C96419FE887::isvalidspectatetarget);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("canTakePickupLoot", _id_0F820C96419FE887::_id_BE23DE35D5DB5CF0);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("filterDamage", _id_0F820C96419FE887::filterdamage);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("compareTeamHigherScore", _id_0F820C96419FE887::sortbylastzombietime);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onDeadEvent", _id_0F820C96419FE887::ondeadevent);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onEliminatedTeamsRespawn", _id_0F820C96419FE887::_id_734542E73EEACD3A);
  _id_2695A20D4011076D::_id_ECA79FA0F341EE08(17, ::dangercircletick, ::_id_1A1709943670772A);
  level.brgametype._id_AA2243B8E5933BF0 = getdvarint("dvar_0F86D972E7588520", 0);
  level.brgametype.zombiekilledlootcachecount = 0;
  level.brgametype._id_067D3B7CEFCB15CD = getdvarint("dvar_4673D84307B77B28", 1);
  level.brgametype.humanpowersenabled = getdvarint("dvar_64F5B71A90F71B0B", 0);
  level.brgametype._id_FE5B4C3DEF3B21D9 = getdvarint("dvar_9F0C717FE5771D0E", 1);
  level.brgametype._id_8A2701DB21DED0BC = getdvarint("dvar_A61C509770F58D52", 2);
  level.brgametype._id_5FC0811CB9626EF0 = getdvarint("dvar_823BC5FEBFCF5512", 1);
  level.brgametype.respawnitems = [];
  level.brgametype._id_664897C80FF2A610 = getdvarint("dvar_7995A3C1DCA19725", 20);
  level.brgametype._id_593867CBADF91278 = getdvarint("dvar_2FCA391C375BCEA1", 10);
  level.respawnheightoverride = getdvarint("dvar_0DACA869F129DFF7", 7500);
  level.brgametype._id_219163D4522E75C9 = getdvarint("dvar_6D5AA7EE61B5EDC0", 0);
  level.brgametype._id_DCF9974C44EEE730 = getdvarint("dvar_E61C38B111680647", 0);
  level.brgametype._id_F55BE0289E3EF5AA = getdvarint("dvar_455DAC717F56A2F8", 0);
  level._effect["stim_pickup"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_stim_pickup");
  thread initdialog();
  _id_0F820C96419FE887::init();
  thread _id_D4B27081237958B4();
  thread initpostmain();
}

initdialog() {
  level endon("game_ended");
  waitframe();
  level.brgametype._id_C435BC516C8091CA = 1;
  level.brgametype._id_B09B7AFE082A9239 = "dx_br_bds6_";
  game["dialog"]["deploy_squad_leader"] = "";
  game["dialog"]["match_start"] = "zxp1_wzan_name";
  game["dialog"]["zmb_infil_tutorial_01"] = "zxp1_wzan_boos";
  game["dialog"]["zmb_infil_tutorial_02"] = "zxp1_wzan_gszm";
  game["dialog"]["zmb_back_human"] = "zxp1_wzan_plcr";
  game["dialog"]["zmb_teammate_back_human"] = "zxp1_wzan_tmcr";
  game["dialog"]["zmb_player_into_zombie"] = "zxp1_wzan_plzm";
  game["dialog"]["zmb_teammate_into_zombie"] = "zxp1_wzan_tmzm";
  game["dialog"]["last_human_alive"] = "zxp1_wzan_lsts";
  game["dialog"]["loot_syringe_01"] = "zxp1_wzan_ntfn";
  game["dialog"]["loot_syringe_02"] = "zxp1_wzan_ntnx";
  game["dialog"]["loot_syringe_03"] = "zxp1_wzan_ntom";
  game["dialog"]["dead_reminder"] = "zxp1_wzan_ddrm";
  game["dialog"]["infil_ac130_5_seconds"] = "zxp1_ldms_zmdr";
  _id_362C58E8BB39BCDA::registerbrgametypefunc("zombieDialog_tryLastHumanAlive", ::_id_B7BA0E456D366CE0);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("zombieDialog_respawnAsZombie", ::_id_17FAA3B3FA0FE88D);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("zombieDialog_lootSyringe", ::_id_441A6C6FFAA18DDE);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("allowImpactVehicleDamage", ::_id_441A6C6FFAA18DDE);
}

initpostmain() {
  waittillframeend;

  if(level.brgametype._id_AA2243B8E5933BF0)
    thread circlesetup();

  thread setupzombierespawnglobaltimer();
  thread setuphumanpowers();
  thread setdropbagdelay();
  thread _id_0F820C96419FE887::_id_E4CFFB22A28408E2();
  _id_7E52B56769FA7774::registerpickupcreatedcallback("brloot_zmb_stim", ::_id_D22FF024B17335F9);
  _id_7E52B56769FA7774::_id_C3E1679F348A5E40(::_id_231DE05CF1CBADB9);
  thread _id_A78DBF22A6DED3AC();
}

playerwelcomesplashes() {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;

  if(!istrue(level.br_infils_disabled))
    self waittill("joining_Infil");
  else
    level waittill("prematch_done");

  _id_2CEDCC356F1B9FC8::brleaderdialog("match_start", 0, undefined, 0, 0, undefined, level.brgametype._id_B09B7AFE082A9239);
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_zxp_mode_intro", undefined, undefined, undefined, undefined, "splash_list_iw9_br_zxp");
  wait 1;
  _id_2CEDCC356F1B9FC8::brleaderdialog("zmb_infil_tutorial_01", 0, undefined, 0, 0, undefined, level.brgametype._id_B09B7AFE082A9239);
  _id_715028F54BAD19A1::branalytics_landing(self);

  if(isalive(self) && !_id_2CEDCC356F1B9FC8::playeriszombie())
    thread playerhumanpowers();

  self waittill("br_jump");
  wait 1;
  _id_2CEDCC356F1B9FC8::brleaderdialogplayer("zmb_infil_tutorial_02", self, 0, 0, 0, undefined, level.brgametype._id_B09B7AFE082A9239);
}

onplayerconnect(player) {
  level endon("game_ended");
  player endon("disconnect");
  scripts\mp\flags::gameflagwait("br_ready_to_jump");
  player._id_BA760CEC09A741C8 = gettime();
  player._id_9035B3B19E0298BC = 0;
  player._id_72052C14FF62F1D0 = 0;
}

packclientmatchdata() {
  _id_9320300321C77F03 = [];
  _id_9320300321C77F03[0] = int(min(self._id_72052C14FF62F1D0, 1023));
  _id_9320300321C77F03[1] = int(min(self._id_9035B3B19E0298BC, 4095));
  return _id_9320300321C77F03;
}

setdropbagdelay() {
  _id_21BE5F4D451EFD18 = -15;
  firsttime = _id_2695A20D4011076D::getcircleclosetime(1);
  _id_5FD1D7EEEBE96215 = max(0, firsttime + _id_21BE5F4D451EFD18);
  _id_23F3A96159A40D18 = getdvarfloat("scr_br_dropbag_delay", _id_5FD1D7EEEBE96215);
  _id_362C58E8BB39BCDA::registerbrgametypedata("dropBagDelay", _id_23F3A96159A40D18);
}

markplayeraseliminatedonkilled() {
  return _id_0F820C96419FE887::markplayeraseliminatedonkilled();
}

playerkilledspawn(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7) {
  return _id_0F820C96419FE887::playerkilledspawn(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7);
}

playershouldrespawn(data) {
  if(!istrue(level.br_prematchstarted))
    return 1;

  return _id_2CEDCC356F1B9FC8::playeriszombie();
}

playerskiplootpickup(instance, _id_A5B2C541413AA895) {
  if(istrue(level.brgametype._id_9DD997CED889B541) && isDefined(instance)) {
    if(isDefined(instance.type) && instance.type == "brloot_zmb_stim")
      return !_id_2CEDCC356F1B9FC8::playeriszombie();
    else
      return _id_2CEDCC356F1B9FC8::playeriszombie() && !instance scriptableislootcache();
  } else
    return _id_2CEDCC356F1B9FC8::playeriszombie();
}

playerskipkioskuse(instance) {
  return _id_2CEDCC356F1B9FC8::playeriszombie();
}

_id_64342424F3CF7F93(data) {
  _id_7BFCAD6985F865AC = isPlayer(data.attacker) && data.attacker _id_2CEDCC356F1B9FC8::playeriszombie();
  _id_8D6DEEB9C425CE1B = isPlayer(data.victim) && data.victim _id_2CEDCC356F1B9FC8::playeriszombie();

  if(_id_7BFCAD6985F865AC && !_id_8D6DEEB9C425CE1B && data.meansofdeath == "MOD_MELEE")
    return 0;

  return 1;
}

allowmeleevehicledamage(data) {
  _id_7BFCAD6985F865AC = isPlayer(data.attacker) && data.attacker _id_2CEDCC356F1B9FC8::playeriszombie();
  return _id_7BFCAD6985F865AC;
}

_id_CD17FD9DF37E3DEF() {
  endtime = gettime() + 3000;

  while(self isgestureplaying() && endtime > gettime()) {
    self stopgestureviewmodel();
    waitframe();
  }

  while(endtime > gettime() && (self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isPlayerADS")]]()))
    waitframe();

  self enableoffhandweapons();
  self giveandfireoffhand("stim_zmb_mp");
  wait 0.5;
}

_id_172CA8A9C3A0981D(value) {
  self allowfire(value);
  self allowmovement(value);
  self allowmelee(value);

  if(value) {
    self playershow();
    self enableoffhandweapons();
  } else {
    self playerhide();
    self disableoffhandweapons();
  }
}

playerzombiebacktohuman(_id_F8048727716242B0) {
  level endon("game_ended");

  if(!istrue(_id_F8048727716242B0) && !_id_2CEDCC356F1B9FC8::playeriszombie()) {
    return;
  }
  _id_11F3B4465C8B637B = self.origin;
  spawnorigin = self.origin;
  spawnangles = self getplayerangles();
  _id_F750412DF131D69A = 0;

  if(level.brgametype.humanspawninair)
    [spawnorigin, spawnangles, _id_11F3B4465C8B637B] = _id_1D81091658F53612();
  else {
    [spawnorigin, spawnangles, _id_F750412DF131D69A] = _id_1A67DB35424BF909();
    _id_11F3B4465C8B637B = spawnorigin;
  }

  self setscriptablepartstate("zombie", "off");
  self setscriptablepartstate("compassicon", "defaulticon");
  self setscriptablepartstate("skydiveVfx", "default", 0);
  playFX(scripts\engine\utility::getfx("zombie_trans"), self.origin);
  self notify("endSuperJumpFov");
  _id_172CA8A9C3A0981D(0);

  if(!istrue(_id_F8048727716242B0))
    _id_CD17FD9DF37E3DEF();

  self lerpfovbypreset("default_2seconds");

  if(level.brgametype._id_63D9BE743A6BA8CD)
    thread scripts\mp\supers\super_deadsilence::superdeadsilence_endhudsequence();

  if(level.brgametype._id_437EAAAE9F85F287) {
    _id_0F820C96419FE887::_id_234906F719267CD4();

    if(!level.brgametype._id_63D9BE743A6BA8CD)
      self setscriptablepartstate("headVFX", "neutral");

    self._id_054E863EBAD3E233 = undefined;
    scripts\mp\utility\player::restorebasevisionset(2);
  }

  if(!istrue(_id_F8048727716242B0))
    wait 1.5;

  _id_EEA48E381591A294 = _id_2CEDCC356F1B9FC8::playeriszombie() || istrue(self._id_B106546C4418E645);
  _id_0F820C96419FE887::playersetiszombie(0);
  _id_0F820C96419FE887::playerzombiestatechange(0);

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female")
    self _meth_555E2D32E2756625("female");
  else
    self _meth_555E2D32E2756625("");

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.clothtype) && self.operatorcustomization.clothtype != "")
    self setclothtype(self.operatorcustomization.clothtype);
  else
    self setclothtype("vestlight");

  self.operatorcustomization = undefined;
  scripts\cp_mp\execution::_clearexecution();
  self.respawningbr = 1;
  self.plotarmor = 1;

  if(isDefined(self.team))
    _id_3ACF1C0EBAF602F2::displaysquadmessagetoteam(self.team, self, 14, 1);

  if(!_id_F750412DF131D69A) {
    _id_5BAB271917698DC4::_id_334A8FE67E88BBE7();
    wait 1;
  } else
    waitframe();

  _id_0A34750D17473C49::unmarkplayeraseliminated(self, "zombieRevived");
  _id_0F820C96419FE887::_id_C53D906A08ED3E87();
  scripts\mp\class::loadout_emptycacheofloadout("gamemode");
  self.pers["gamemodeLoadout"] = level.br_loadouts["default"];
  self.pers["class"] = "gamemode";
  self.class = "gamemode";
  self.forcespawnangles = spawnangles;
  self.forcespawnorigin = _id_11F3B4465C8B637B;
  scripts\mp\utility\player::_setsuit("iw9_defaultsuit_mp");
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  thread _id_1E4A61DB11011446::br_displayperkinfo();
  _id_172CA8A9C3A0981D(1);
  self enableexecutionvictim();
  self _meth_ 9 DD858480D66BBC(0);

  if(level.brgametype.humanspawninair) {
    self.plotarmor = undefined;
    _id_0F820C96419FE887::playerstreamwaittillcomplete(spawnorigin, spawnangles, _id_11F3B4465C8B637B);
  } else {
    if(!_id_F750412DF131D69A) {
      _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
      _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();
      playFX(scripts\engine\utility::getfx("zombie_trans"), self.origin);
    }

    if(!_id_F750412DF131D69A)
      _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();

    thread _id_5855E4B39BAE3587();
  }

  if(istrue(level.brgametype._id_5FC0811CB9626EF0) && _id_0F820C96419FE887::_id_6ECE6988ECAF0EA7())
    _id_7FBB2E52F100474E();
  else {
    loadoutindex = _id_1E4A61DB11011446::brgetloadoutoptionstandardloadoutindex();
    _id_1E4A61DB11011446::givestandardtableloadout(loadoutindex, 0);
  }

  _id_968BD61837A9C038 = getdvarint("dvar_3C87CCC2C15B53A4", 100);
  _id_381776CAE951DA48 = getdvarint("dvar_8B8E8245086EFDD1", 0);
  _id_07C40FA80892A721::givestartingarmor(_id_968BD61837A9C038, undefined, _id_381776CAE951DA48);
  thread _id_1E4A61DB11011446::br_displayperkinfo();
  _id_0F820C96419FE887::_id_FD7BDFFE7CEA51ED(0);

  if(istrue(level._id_3FF7C73209FCF59D))
    _id_002E0206D4774172::_id_FA674FB6E8372620();

  _id_4B87F2871B6B025C::_id_EF73345010F390F4();

  if(_id_EEA48E381591A294) {
    scripts\mp\hud_message::showsplash("br_gametype_zxp_change_human", undefined, undefined, undefined, undefined, "splash_list_iw9_br_zxp");
    _id_2CEDCC356F1B9FC8::brleaderdialogplayer("zmb_back_human", self, 0, 0, 0, undefined, level.brgametype._id_B09B7AFE082A9239);
  }

  self.plotarmor = undefined;
  thread playerhumanhitground();
  self.respawningbr = undefined;
  self._id_BA760CEC09A741C8 = gettime();

  if(_id_EEA48E381591A294) {
    foreach(_id_F0EA4030349A33D5 in level.teamdata[self.team]["players"]) {
      if(self != _id_F0EA4030349A33D5)
        _id_2CEDCC356F1B9FC8::brleaderdialogplayer("zmb_teammate_back_human", _id_F0EA4030349A33D5, 0, 0, 0, undefined, level.brgametype._id_B09B7AFE082A9239);
    }
  }
}

_id_1D81091658F53612() {
  streamtimeout = _id_2CEDCC356F1B9FC8::getdefaultstreamhinttimeoutms() / 1000;
  spawnpoint = _id_5BAB271917698DC4::_id_952548D8AED47102(0, streamtimeout);
  _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
  return [spawnpoint.origin, spawnpoint.angles, _id_11F3B4465C8B637B];
}

_id_1A67DB35424BF909() {
  [spawnorigin, spawnangles, _id_F750412DF131D69A] = _id_AFBD524FEC2F5EC0();

  if(!_id_F750412DF131D69A)
    _id_2CEDCC356F1B9FC8::playerstreamhintlocation(spawnorigin);

  return [spawnorigin, spawnangles, _id_F750412DF131D69A];
}

_id_AFBD524FEC2F5EC0() {
  _id_72541F27D0911A16 = 500;
  _id_DDB70F36E908D6D9 = 10000;
  _id_145D3D7AF68D22FF = 5;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent))
    return [self.origin, self getplayerangles(), 1];

  _id_B2739C0F5213D0E8 = _id_2695A20D4011076D::getdangercircleradius();
  _id_EF8F7E66DC0FEB2C = _id_2695A20D4011076D::getdangercircleorigin();
  _id_02DB625E063F40B4 = distance2dsquared(self.origin, _id_EF8F7E66DC0FEB2C);

  if(_id_02DB625E063F40B4 <= _id_B2739C0F5213D0E8 * _id_B2739C0F5213D0E8)
    return [self.origin, self getplayerangles(), 1];

  startorigin = undefined;
  spawnangles = undefined;
  _id_AC2E1EFDF095AF8C = (self.origin[0], self.origin[1], 0);
  _id_B55FC573AAA3D8D4 = vectorNormalize(_id_AC2E1EFDF095AF8C - _id_EF8F7E66DC0FEB2C);

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= _id_145D3D7AF68D22FF; _id_AC0E594AC96AA3A8++) {
    _id_BB2F1C8715395934 = _id_B2739C0F5213D0E8 - _id_72541F27D0911A16 * _id_AC0E594AC96AA3A8;

    if(_id_BB2F1C8715395934 < 0) {
      break;
    }

    [startorigin, spawnangles] = _id_FB6925F5E828580D(_id_EF8F7E66DC0FEB2C, _id_B55FC573AAA3D8D4, _id_BB2F1C8715395934);

    if(isDefined(startorigin)) {
      break;
    }
  }

  if(!isDefined(startorigin)) {
    startorigin = _id_EF8F7E66DC0FEB2C;
    spawnangles = self getplayerangles();
  }

  spawnorigin = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(startorigin, _id_DDB70F36E908D6D9);
  return [spawnorigin, spawnangles, 0];
}

_id_FB6925F5E828580D(origin, dir, dist) {
  startorigin = origin + dir * dist;
  streamtimeout = _id_2CEDCC356F1B9FC8::getdefaultstreamhinttimeoutms() / 1000;

  if(_id_5BAB271917698DC4::_id_61B5424AA3FE974E(startorigin, streamtimeout)) {
    spawnangles = vectortoangles(dir * -1);
    return [startorigin, spawnangles];
  } else
    return [undefined, undefined];
}

playerhumanhitground() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_set");

  while(!self isonground())
    waitframe();

  thread playerhumanpowers();
}

_id_7FBB2E52F100474E() {
  self takeallweapons(0, 1);
  _id_724736FCF0FB6604::br_ammo_player_clear();
  self.equipment["primary"] = undefined;
  self.equipment["secondary"] = undefined;
  self.equipment["health"] = undefined;
  self.equipment["super"] = undefined;
  _id_2B1D0E57C66A43D0 = makeweapon("iw8_fists_mp");

  if(self._id_45F93A3BA26BD0B7._id_BC002676438672C9.size < 2)
    self giveweapon(_id_2B1D0E57C66A43D0);

  _id_CF6837E74D470965 = 0;

  foreach(weaponobj in self._id_45F93A3BA26BD0B7._id_BC002676438672C9) {
    weaponname = getcompleteweaponname(weaponobj);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(weaponobj);

    if(!_id_CF6837E74D470965) {
      self assignweaponprimaryslot(weaponname);
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(weaponobj);
      _id_CF6837E74D470965 = 1;
    }

    scripts\mp\weapons::fixupplayerweapons(self, weaponname);
  }

  foreach(_id_32D16745C91DBE50 in self._id_45F93A3BA26BD0B7.offhands) {
    _id_1189BD7FBE2861F8 = scripts\mp\equipment::getequipmentreffromweapon(_id_32D16745C91DBE50);

    if(!isDefined(_id_1189BD7FBE2861F8)) {
      continue;
    }
    slot = self._id_45F93A3BA26BD0B7._id_00ACA871F9745FC8[_id_1189BD7FBE2861F8];

    if(!isDefined(slot)) {
      continue;
    }
    scripts\mp\equipment::giveequipment(_id_1189BD7FBE2861F8, slot);
  }

  foreach(weaponname, ammo in self._id_45F93A3BA26BD0B7._id_D1AD88BF84DAA67F) {
    self setweaponammostock(weaponname, ammo);
    weaponobj = makeweapon(getweaponbasename(weaponname));
    _id_811ABFDB6C33F17F = _id_724736FCF0FB6604::br_ammo_type_for_weapon(weaponobj);

    if(isDefined(_id_811ABFDB6C33F17F)) {
      self.br_ammo[_id_811ABFDB6C33F17F] = ammo;
      _id_724736FCF0FB6604::br_ammo_player_hud_update_ammotype(_id_811ABFDB6C33F17F);
    }
  }

  foreach(weaponname, ammo in self._id_45F93A3BA26BD0B7._id_AC9CAEBED426E625)
  self setweaponammoclip(weaponname, ammo);

  foreach(weaponname, ammo in self._id_45F93A3BA26BD0B7._id_734357A0B88E3A30)
  self setweaponammoclip(weaponname, ammo, "left");

  waitframe();
  _id_B8F86333B805D701 = _id_2B1D0E57C66A43D0;

  if(isDefined(self._id_45F93A3BA26BD0B7.current) && self._id_45F93A3BA26BD0B7.current != makeweapon("none"))
    _id_B8F86333B805D701 = self._id_45F93A3BA26BD0B7.current;

  self switchtoweaponimmediate(_id_B8F86333B805D701);

  if(isDefined(self._id_45F93A3BA26BD0B7.super)) {
    _id_EBEC497FF8B18A45 = level.br_pickups.br_superreference[level.br_pickups.br_equipnametoscriptable[self._id_45F93A3BA26BD0B7.super]];
    _id_7E52B56769FA7774::forcegivesuper(_id_EBEC497FF8B18A45, 0);
  }

  thread scripts\cp_mp\gestures::tryreenablescriptablevfx();
  self._id_45F93A3BA26BD0B7 = undefined;
}

addtoteamlives(player, team) {
  player _id_0F820C96419FE887::addtoteamlives(player, team);
}

removefromteamlives(player, team) {
  player _id_0F820C96419FE887::removefromteamlives(player, team);
}

gulagwinnerrespawn(player) {
  if(level.brgametype._id_5FC0811CB9626EF0 && _id_0F820C96419FE887::_id_6ECE6988ECAF0EA7())
    _id_7FBB2E52F100474E();
}

_id_536210A44B407BF4() {
  self.itemsdropped = 0;
  index = level.brgametype.zombiekilledlootcachecount % 10;
  level.brgametype.zombiekilledlootcachecount++;
  _id_060EEA229F65480A = scripts\engine\utility::ter_op(isPlayer(self), "zombie_death", "zombie_agent_death");
  items = getscriptcachecontents(_id_060EEA229F65480A, index);

  if(isDefined(items)) {
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    _id_E05413A53B5D9167 = _id_552B8E4EA5FF7DF1::lootspawnitemlist(dropstruct, items, 0);
  }
}

playernakeddroploadout() {
  if(_id_2CEDCC356F1B9FC8::playeriszombie())
    return;
  else
    _id_1E4A61DB11011446::nakeddrophandleloadout();
}

droponplayerdeath(attacker) {
  if(_id_2CEDCC356F1B9FC8::playeriszombie())
    return 1;

  if(level.brgametype._id_5FC0811CB9626EF0)
    _id_0F820C96419FE887::_id_10FFA1071B1C2681();

  return 0;
}

onplayerkilled(_id_642470E1ABC1BBF9) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }
  if(level.gameended) {
    return;
  }
  victim = _id_642470E1ABC1BBF9.victim;
  attacker = _id_642470E1ABC1BBF9.attacker;

  if(!isDefined(attacker) || !isPlayer(attacker) || !isDefined(victim)) {
    return;
  }
  if(victim _id_5B11D4C1DCFB5C70(attacker, _id_642470E1ABC1BBF9.meansofdeath))
    victim thread _id_87AA367A0FC501CD(victim, attacker);

  if(istrue(level.brgametype._id_FE5B4C3DEF3B21D9) && victim _id_3406E94DB80D3DF1(attacker))
    victim thread _id_D4881E5A408D9C4A(victim, attacker);

  if(victim shouldspawnloot(attacker))
    victim thread _id_536210A44B407BF4();

  _id_36BC58BB63DBFFBE = istrue(attacker._id_750C82BA41F3E2B1);
  _id_3CB1BD50D2032642 = 0;
  _id_7BFCAD6985F865AC = attacker _id_2CEDCC356F1B9FC8::playeriszombie();
  _id_8D6DEEB9C425CE1B = victim _id_2CEDCC356F1B9FC8::playeriszombie() && isPlayer(victim);

  if(!istrue(_id_8D6DEEB9C425CE1B))
    victim.disable_killcam = 1;

  if(attacker _id_17D34B7536EE4DA5(_id_642470E1ABC1BBF9)) {
    attacker thread scripts\cp_mp\challenges::oncollectitem("zxp_execution");
    attacker thread playerzombiebacktohuman(1);
    _id_3CB1BD50D2032642 = 1;
  }

  hitloc = _id_642470E1ABC1BBF9.hitloc;

  if(isDefined(hitloc) && victim _id_2CEDCC356F1B9FC8::playeriszombie() && (hitloc == "head" || hitloc == "helmet")) {
    _id_06F0108F13E558E0 = 0;
    attacker thread _id_5762AC2F22202BA2::updatedamagefeedback("hitzombieheadshot", _id_06F0108F13E558E0, 1);
  }

  if(_id_294DDA4A4B00FFE3::_id_4AD287E0971672A6()) {
    if(victim _id_2CEDCC356F1B9FC8::playeriszombie() && isPlayer(victim)) {
      _id_294DDA4A4B00FFE3::_id_D24F2DD28D26377E(level.brgametype._id_DCF9974C44EEE730);

      if(!_id_294DDA4A4B00FFE3::_id_989D407AD1798EB0())
        thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("dead_reminder", victim, 0, 1, 1, undefined, level.brgametype._id_B09B7AFE082A9239);
    } else if(!victim _id_2CEDCC356F1B9FC8::playeriszombie() && (attacker _id_2CEDCC356F1B9FC8::playeriszombie() || isagent(attacker) && isDefined(attacker._id_521FAC03E5F3A11B)))
      _id_294DDA4A4B00FFE3::_id_D24F2DD28D26377E(-1 * level.brgametype._id_219163D4522E75C9);
  }

  if(victim _id_2CEDCC356F1B9FC8::playeriszombie() && isPlayer(victim)) {
    attacker._id_72052C14FF62F1D0++;
    attacker _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("zombieKills", attacker._id_72052C14FF62F1D0);
  }

  victim _id_85AC199ED33991D6();
  victim setscriptablepartstate("skydiveVfx", "default", 0);
  dlog_recordevent("dlog_event_zxp_zombie_player_kill", ["attacker_has_shout_buff", _id_36BC58BB63DBFFBE, "attacker_is_zombie", _id_7BFCAD6985F865AC, "is_attacker_execute_auto_respawn", _id_3CB1BD50D2032642, "victim_is_zombie", _id_8D6DEEB9C425CE1B]);
}

_id_85AC199ED33991D6() {
  if(!_id_2CEDCC356F1B9FC8::playeriszombie()) {
    _id_445C62598598598C = int((gettime() - self._id_BA760CEC09A741C8) * 0.001);

    if(_id_445C62598598598C > self._id_9035B3B19E0298BC) {
      self._id_9035B3B19E0298BC = _id_445C62598598598C;
      _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("longestLife", self._id_9035B3B19E0298BC);
    }
  }
}

_id_17D34B7536EE4DA5(_id_642470E1ABC1BBF9) {
  if(!level.brgametype._id_888A368FC494C603)
    return 0;

  if(_id_642470E1ABC1BBF9.meansofdeath != "MOD_EXECUTION")
    return 0;

  if(_id_642470E1ABC1BBF9.victim _id_2CEDCC356F1B9FC8::playeriszombie())
    return 0;

  if(!level.brgametype._id_B8456BBDF46925A3 && istrue(_id_642470E1ABC1BBF9.victim.inlaststand))
    return 0;

  if(!_id_642470E1ABC1BBF9.attacker _id_2CEDCC356F1B9FC8::playeriszombie())
    return 0;

  return 1;
}

shouldspawndropscommon(attacker, _id_7159F30EA8781C0B) {
  if(isDefined(attacker) && attacker == self)
    return istrue(_id_7159F30EA8781C0B);

  if(level.teambased && isDefined(attacker) && isDefined(attacker.team) && attacker.team == self.team)
    return 0;

  if(isDefined(attacker) && !isDefined(attacker.team) && (attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn"))
    return 0;

  if(isagent(self) || isagent(attacker))
    return 0;

  return 1;
}

shouldspawnloot(attacker) {
  if(!shouldspawndropscommon(attacker))
    return 0;

  if(!_id_2CEDCC356F1B9FC8::playeriszombie())
    return 0;

  return 1;
}

_id_5B11D4C1DCFB5C70(attacker, meansofdeath) {
  if(!shouldspawndropscommon(attacker, 1))
    return 0;

  if(_id_2CEDCC356F1B9FC8::playeriszombie())
    return 0;

  if(meansofdeath == "MOD_EXECUTION" && attacker _id_2CEDCC356F1B9FC8::playeriszombie()) {
    if(!level.brgametype._id_B8456BBDF46925A3 && !istrue(self.inlaststand))
      return 0;
  }

  return 1;
}

_id_7FA9A8FB1F8CB5A7(origin, angles, ent, count) {
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++) {
    _id_279A4854B51C5AF2 = (0, randomfloatrange(0, 360), 0);
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, origin, angles + _id_279A4854B51C5AF2, ent, undefined, 35);
    _id_7E52B56769FA7774::spawnpickup("brloot_zmb_stim", _id_CB4FAD49263E20C4, 1, 1, undefined, level.brgametype._id_067D3B7CEFCB15CD);
  }
}

_id_D22FF024B17335F9() {
  thread _id_179B77928EA64469();
}

_id_179B77928EA64469() {
  self._id_9E72179BF85188D2 = "s" + self.index;
  self._id_BBC200BC77C5DB2B = 1;
  self.ownerteam = "neutral";

  for(state = self getscriptablepartstate("brloot_zmb_stim"); state != "visible" && state != "delayauto" && state != "noauto"; state = self getscriptablepartstate("brloot_zmb_stim")) {
    waitframe();

    if(!isDefined(self))
      return;
  }

  _id_01230EA36A300368 = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(self.origin, 30);
  level.brgametype.respawnitems[self._id_9E72179BF85188D2] = self;
  playsoundatpos(self.origin, "mp_killconfirm_tags_drop");
}

_id_231DE05CF1CBADB9() {
  if(isDefined(self.type) && self.type == "brloot_zmb_stim")
    _id_3BBC840FB244D188(self);
}

_id_87AA367A0FC501CD(victim, attacker) {
  _id_FD2FEE325481DC7F = level.brgametype._id_8A2701DB21DED0BC;
  _id_7FA9A8FB1F8CB5A7(victim.origin, victim.angles, victim, _id_FD2FEE325481DC7F);
}

_id_3406E94DB80D3DF1(attacker) {
  if(!shouldspawndropscommon(attacker, 1))
    return 0;

  if(_id_2CEDCC356F1B9FC8::playeriszombie() && self.numconsumed > 0)
    return 1;

  return 0;
}

_id_D4881E5A408D9C4A(victim, attacker) {
  _id_7FA9A8FB1F8CB5A7(victim.origin, victim.angles, victim, self.numconsumed);
}

_id_3BBC840FB244D188(_id_BAB6040272518362, _id_426EC555FFF751BE, player) {
  level.brgametype.respawnitems[_id_BAB6040272518362._id_9E72179BF85188D2] = undefined;
  playFX(level._effect["stim_pickup"], _id_BAB6040272518362.origin);

  if(isDefined(player)) {
    player playsoundtoplayer("zmb_pickup_syringe", player);
    player thread scripts\mp\utility\points::giveunifiedpoints("br_syringe_looted");
  }

  if(istrue(_id_426EC555FFF751BE))
    _id_BAB6040272518362 _id_7E52B56769FA7774::deletescriptableinstance(1);
}

onuse(player) {
  _id_0F820C96419FE887::onuse(player);
}

circletimernext(circleindex) {
  if(istrue(level.brgametype.zombierespawning)) {
    if(getdvarint("dvar_26476F821DF5D01F", 0) == 0) {
      return;
    }
    _id_837F5B5677ADC8FE = _id_67708F418B1FAC79::getgulagclosedcircleindex();

    if(circleindex >= _id_837F5B5677ADC8FE)
      level.brgametype.zombierespawning = 0;
  }
}

setupzombierespawnglobaltimer() {
  if(istrue(level.br_circle_disabled)) {
    return;
  }
  if(getdvarint("dvar_26476F821DF5D01F", 0) == 0) {
    return;
  }
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  _id_D3926F6303934FF8 = "hudsmall";
  _id_3C99DE187802DF31 = 0.8;
  _id_9F83FCC7A160F4E6 = -100;
  _id_ECF4E1D902A24C73 = -290;
  _id_1461CE6F6B22E869 = 90;
  _id_2948CA54731DE34F = _id_67708F418B1FAC79::gettimetogulagclosed();
  _id_AD40392184F37BAC = createhudelem(_id_D3926F6303934FF8, _id_3C99DE187802DF31);
  _id_AD40392184F37BAC scripts\mp\hud_util::setpoint("RIGHT", "CENTER", _id_ECF4E1D902A24C73, _id_9F83FCC7A160F4E6);
  _id_AD40392184F37BAC.label = &"MP_ZXP/RESPAWN_ALLOWED";
  _id_32E699637BC9C0BB = scripts\mp\hud_util::createservertimer(_id_D3926F6303934FF8, _id_3C99DE187802DF31);
  _id_32E699637BC9C0BB scripts\mp\hud_util::setpoint("LEFT", "CENTER", _id_ECF4E1D902A24C73, _id_9F83FCC7A160F4E6);
  _id_32E699637BC9C0BB settenthstimer(_id_2948CA54731DE34F);
  _id_FC133E1A9D8063A1 = getdvarint("dvar_BF9AAA13E23F04AE", _id_1461CE6F6B22E869);
  _id_6113FC02B7117903 = _id_2948CA54731DE34F - _id_FC133E1A9D8063A1;

  if(_id_6113FC02B7117903 > 0) {
    wait(_id_6113FC02B7117903);
    _id_32E699637BC9C0BB.color = (1, 0, 0);
    _id_32E699637BC9C0BB thread _id_0F820C96419FE887::huddopulse();
    wait(_id_FC133E1A9D8063A1);
  } else
    wait(_id_2948CA54731DE34F);

  wait 2;
  _id_32E699637BC9C0BB destroy();
  _id_AD40392184F37BAC destroy();
}

_id_8E4317F4E78B9488(_id_4AC881E2A39322A5, _id_DF2FBB13C226BE75) {
  if(!isalive(self) || _id_2CEDCC356F1B9FC8::playeriszombie())
    _id_0F820C96419FE887::kioskreviveplayer(_id_4AC881E2A39322A5);
}

createhudelem(font, fontscale, team) {
  if(isDefined(team))
    _id_372B658AEA9D2487 = newteamhudelem(team);
  else
    _id_372B658AEA9D2487 = newhudelem();

  _id_372B658AEA9D2487.elemtype = "font";
  _id_372B658AEA9D2487.font = font;
  _id_372B658AEA9D2487.fontscale = fontscale;
  _id_372B658AEA9D2487.basefontscale = fontscale;
  _id_372B658AEA9D2487.x = 0;
  _id_372B658AEA9D2487.y = 0;
  _id_372B658AEA9D2487.width = 0;
  _id_372B658AEA9D2487.height = int(level.fontheight * fontscale);
  _id_372B658AEA9D2487.xoffset = 0;
  _id_372B658AEA9D2487.yoffset = 0;
  _id_372B658AEA9D2487.children = [];
  _id_372B658AEA9D2487 scripts\mp\hud_util::setparent(level.uiparent);
  _id_372B658AEA9D2487.hidden = 0;
  _id_372B658AEA9D2487.alpha = 1;
  return _id_372B658AEA9D2487;
}

circlesetup() {
  level.br_level.br_circledelaytimes[1] = level.br_level.br_circledelaytimes[0];
  level.br_level.br_circledelaytimes[0] = 1;
  level.br_level.br_circleclosetimes[0] = 1;
  level.br_level.br_circleshowdelaydanger[0] = 1;
}

createc130pathstruct() {
  if(level.brgametype._id_AA2243B8E5933BF0) {
    _id_F9CBFF5134DA960B = (level.br_level.br_circlecenters[1][0], level.br_level.br_circlecenters[1][1], 0);
    _id_E5BD279D3767139F = level.br_level.br_circleradii[1];
    c130pathstruct = _id_45B2B4A889E633FA::createtestc130path(_id_F9CBFF5134DA960B, _id_E5BD279D3767139F);
  } else
    c130pathstruct = _id_45B2B4A889E633FA::createtestc130path();

  return c130pathstruct;
}

addtoc130infil() {
  thread kickplayersatcircleedge();
}

kickplayersatcircleedge() {
  level endon("game_ended");
  self endon("death");
  _id_432421C6EC2BFCD9 = distance(self.pathstruct.startpt, self.pathstruct.endptui);
  _id_42F65B4B53C1F5D4 = _id_432421C6EC2BFCD9 / _id_45B2B4A889E633FA::getc130speed() - 5;
  wait(_id_42F65B4B53C1F5D4);

  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.br_infil_type) && player.br_infil_type == "c130" && !isDefined(player.jumptype)) {
      player.jumptype = "outOfBounds";
      player notify("halo_kick_c130");
    }
  }
}

_id_9C0B1751FEFA2B39(winners) {
  foreach(player in level.players) {
    player hudoutlinedisable();

    if(player _id_2CEDCC356F1B9FC8::playeriszombie()) {
      player setscriptablepartstate("compassicon", "defaulticon");
      player unsetperk("specialty_radarblip", 1);

      if(level.brgametype._id_437EAAAE9F85F287) {
        if(!level.brgametype._id_63D9BE743A6BA8CD)
          player setscriptablepartstate("headVFX", "neutral");

        player visionsetnakedforplayer("", 0);
      }

      if(!isDefined(scripts\engine\utility::array_find(winners, player))) {
        player playerhide();
        player setscriptablepartstate("zombie", "off");
        continue;
      }

      player setscriptablepartstate("zombie", "off");
    }
  }

  if(isDefined(level._id_C01235187BC88F5A._id_698AB4F1074B4F37)) {
    foreach(zombie in level._id_C01235187BC88F5A._id_698AB4F1074B4F37) {
      if(isDefined(zombie))
        zombie despawnagent();
    }

    level._id_C01235187BC88F5A._id_698AB4F1074B4F37 = [];
  }
}

setuphumanpowers() {
  if(!istrue(level.brgametype.humanpowersenabled)) {
    return;
  }
  level.brgametype.human = spawnStruct();
  level.brgametype.human.powers = [];
  _id_0F820C96419FE887::addpowerbutton(level.brgametype.human, "push", ["+stance", "+movedown"], ::playerhumanconcusspush, 1, undefined, ::playerhumanconcusspushcleanup, undefined, &"MP_ZXP/PUSH", undefined, 60);
}

playerhumanpowers() {
  if(!istrue(level.brgametype.humanpowersenabled)) {
    return;
  }
  thread _id_0F820C96419FE887::playerstartpowers(level.brgametype.human);
}

playerhumanconcusspush(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_set");
  _id_86BCAC53E1A0E492 = 750;

  if(istrue(self.concusspushstart)) {
    _id_3A0A5A93E61D5DD5 = getdvarint("dvar_53C7F9AFD0C26FF0", _id_86BCAC53E1A0E492);
    _id_5659806E75F89695 = gettime() - self.concusspushstart;

    if(_id_5659806E75F89695 <= _id_3A0A5A93E61D5DD5) {
      _id_5855E4B39BAE3587();
      thread _id_0F820C96419FE887::_id_120695737ABD78F4(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
      self.concusspushstart = undefined;
      return;
    }
  }

  self.concusspushstart = gettime();
}

_id_5855E4B39BAE3587() {
  if(!getdvarint("dvar_2FCCF88068C3C939", 0)) {
    return;
  }
  _id_95F31FD5810A9C2C = 650;
  _id_5991EF3EA72A6543 = getdvarint("dvar_C631CB451D62F9EA", _id_95F31FD5810A9C2C);
  _id_0A427DED21077317 = sortbydistancecullbyradius(level.players, self.origin, _id_5991EF3EA72A6543);

  foreach(player in _id_0A427DED21077317) {
    if(player _id_2CEDCC356F1B9FC8::playeriszombie() && player.team != self.team && isalive(player))
      _id_0F820C96419FE887::playerhumanconcusspushplayer(player, _id_5991EF3EA72A6543);
  }

  forward = anglesToForward(self.angles);
  playFX(level.brgametype.impulsefx, self.origin, forward);
  playsoundatpos(self.origin, "sentry_explode_smoke");
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.5, 1.5, self.origin, _id_5991EF3EA72A6543);
}

playerhumanconcusspushcleanup(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  self.concusspushstart = undefined;
}

_id_66653A9A40E32D36(_id_642470E1ABC1BBF9, meansofdeath) {
  if(!isDefined(meansofdeath))
    meansofdeath = _id_642470E1ABC1BBF9.meansofdeath;

  victim = _id_642470E1ABC1BBF9.victim;
  hitloc = _id_642470E1ABC1BBF9.hitloc;

  if(isPlayer(victim) && victim _id_2CEDCC356F1B9FC8::playeriszombie() && (hitloc == "head" || hitloc == "helmet"))
    meansofdeath = "MOD_HEAD_SHOT_ZOMBIE";

  return meansofdeath;
}

dangercircletick(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A) {
  _id_1EA889BEFE508442 = 0;

  if(level.brgametype._id_593867CBADF91278 >= 0) {
    _id_5D954F1724092F5A = 0;
    _id_1EA889BEFE508442 = level.brgametype._id_593867CBADF91278;
  }

  _id_52D59C928EB97C81 = _id_E86632D645C137D0 + _id_5D954F1724092F5A;
  _id_C434624FF361BBA2 = _id_52D59C928EB97C81 * _id_52D59C928EB97C81;

  foreach(item in level.brgametype.respawnitems) {
    if(!isDefined(item) || istrue(item._id_D25A9F9B70723670)) {
      continue;
    }
    if(distance2dsquared(item.origin, _id_819EDACDACB810E4) > _id_C434624FF361BBA2)
      thread _id_547BE82353222CB4(item, _id_1EA889BEFE508442);
  }
}

_id_1A1709943670772A() {
  _id_1EA889BEFE508442 = 0;
  _id_5D954F1724092F5A = level._id_53C0FA66001CFF52;

  if(level.brgametype._id_593867CBADF91278 >= 0) {
    _id_5D954F1724092F5A = 0;
    _id_1EA889BEFE508442 = level.brgametype._id_593867CBADF91278;
  }

  foreach(item in level.brgametype.respawnitems) {
    if(!isDefined(item) || istrue(item._id_D25A9F9B70723670)) {
      continue;
    }
    _id_E4E4AE4481958D2E = !_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(item.origin, _id_5D954F1724092F5A);

    if(_id_E4E4AE4481958D2E)
      thread _id_547BE82353222CB4(item, _id_1EA889BEFE508442);
  }
}

_id_547BE82353222CB4(item, delay) {
  level endon("game_ended");
  item._id_D25A9F9B70723670 = 1;
  wait(delay);

  if(isDefined(item))
    _id_3BBC840FB244D188(item, 1);
}

_id_B7BA0E456D366CE0(_id_86B7E6514F63521E) {
  _id_99E8FCB28E160694 = [];

  foreach(_id_F0EA4030349A33D5 in level.teamdata[_id_86B7E6514F63521E.team]["players"]) {
    if(_id_86B7E6514F63521E == _id_F0EA4030349A33D5) {
      continue;
    }
    if(scripts\mp\utility\player::isreallyalive(_id_F0EA4030349A33D5) && !_id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::playeriszombie())
      _id_99E8FCB28E160694[_id_99E8FCB28E160694.size] = _id_F0EA4030349A33D5;
  }

  if(_id_99E8FCB28E160694.size == 1)
    _id_2CEDCC356F1B9FC8::brleaderdialog("last_human_alive", 0, _id_99E8FCB28E160694, 0, 0, undefined, level.brgametype._id_B09B7AFE082A9239);
}

_id_17FAA3B3FA0FE88D(_id_7C66490610B6F676) {
  foreach(_id_F0EA4030349A33D5 in level.teamdata[_id_7C66490610B6F676.team]["players"]) {
    if(_id_7C66490610B6F676 == _id_F0EA4030349A33D5) {
      _id_2CEDCC356F1B9FC8::brleaderdialogplayer("zmb_player_into_zombie", _id_F0EA4030349A33D5, 0, 0, 0, undefined, level.brgametype._id_B09B7AFE082A9239);
      continue;
    }

    _id_2CEDCC356F1B9FC8::brleaderdialogplayer("zmb_teammate_into_zombie", _id_F0EA4030349A33D5, 0, 0, 0, undefined, level.brgametype._id_B09B7AFE082A9239);
  }
}

_id_441A6C6FFAA18DDE(_id_1543F2CBB2CDF3D2) {
  _id_1543F2CBB2CDF3D2 notify("loot_syringe_dialog");
  level endon("game_ended");
  _id_1543F2CBB2CDF3D2 endon("death_or_disconnect");
  _id_1543F2CBB2CDF3D2 endon("zombie_unset");
  _id_1543F2CBB2CDF3D2 endon("loot_syringe_dialog");
  wait 1.5;

  if(!isDefined(_id_1543F2CBB2CDF3D2.numconsumed) || _id_1543F2CBB2CDF3D2.numconsumed <= 0 || _id_1543F2CBB2CDF3D2.numconsumed > 3) {
    return;
  }
  dialog = "loot_syringe_0" + _id_1543F2CBB2CDF3D2.numconsumed;
  _id_2CEDCC356F1B9FC8::brleaderdialogplayer(dialog, _id_1543F2CBB2CDF3D2, 0, 0, 0, undefined, level.brgametype._id_B09B7AFE082A9239);
}

_id_D4B27081237958B4() {
  if(getdvarint("dvar_FFD3CBBD2A5600F0", 1) <= 0) {
    return;
  }
  _id_4DDC095EC77D4BEC::_id_3406446981D65075();
  _id_633854BDBF5472F4::_id_FA8DDEAA2A6BB272();
  level._id_428703950599C9E9 = ::_id_FF7ABDA78E137510;
  level._id_CD41441B70AF845E = ::_id_9486695A83828A6B;
  level._id_C7F73EF4CB5F312E = ::_id_C37A0B3355A0200D;
  scripts\cp_mp\utility\script_utility::registersharedfunc("threat_bias", "customFriendlyCheck", ::_id_528397B2B79B6E9C);
  waitframe();
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  waitframe();
  _id_B283548972EE46D2();
}

_id_FF7ABDA78E137510() {
  _id_48814951E916AF89::_id_B1D1E7E3B23E0DFE(["bosses", "bossMinions", "zombies"]);
}

_id_B283548972EE46D2() {
  if(level.mapname == "mp_delta_pm") {
    _id_DAB1E28DDBBC63CA((7822, 2314, 188), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((7713, 2462, 188), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((7547, 2342, 190), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((7638, 2177, 188), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((6539, 2730, 380), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((6475, 2874, 380), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((6785, 2896, 380), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((6740, 2761, 380), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((6719, 1056, 380), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((6891, 984, 380), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((7005, 1132, 380), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((7105, 1287, 380), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((5742, 1604, 188), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((5921, 1557, 188), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((6089, 1447, 188), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((5761, 1432, 188), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((1198, -7100, 448), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-199, -7690, 448), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((41, -7567, 192), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((2190, -7094, 192), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-6218, 2221, -94), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-6472, 2206, -97), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-6606, 2571, -100), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-6306, 2552, -95), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-6224, 2767, 167), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-6558, 2824, 167), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-6800, 2709, 167), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-10409, 9092, 304), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-10619, 9927, 304), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-10222, 10609, 496), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-9942, 11100, 496), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-9117, 11593, 540), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-8372, 11404, 412), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-9379, 11242, 168), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-10016, 10622, 165), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-9285, 8577, 176), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-9966, 8952, 576), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-10676, 9290, 584), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-10289, 9886, 576), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-10108, 9329, 576), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-235, 9066, 330), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((154, 8463, 330), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((262, 7668, 314), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-373, 8286, 378), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-918, 8497, 514), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((41, 8724, 514), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((392, 8051, 514), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((69, 8087, 690), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-174, 7805, 690), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-578, 8857, 690), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-823, 9898, 690), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-1704, 10016, 514), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-1417, 10751, 330), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-581, 10938, 378), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-704, 9834, 514), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((391, 9809, 514), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((7280, 7440, 323), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((7816, 7809, 324), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((8183, 7986, 324), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((8880, 6716, 324), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((7701, 6032, 324), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((8356, 6921, 188), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((8401, 7933, 188), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((7566, 7819, 188), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((7473, 7118, 243), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((8456, 7033, 324), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((7720, 6829, 324), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((12764, 5757, 191), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((13179, 5281, 191), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((13374, 5402, 327), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((12736, 4656, 191), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((13144, 4103, 191), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((12234, 4210, 327), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((12170, 2992, 391), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((12915, 2033, 327), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((13246, 2444, 191), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((13924, 3242, 55), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((13695, 4184, 327), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((14109, 1646, 191), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((13815, 684, 191), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((13146, 1436, 327), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((14479, 341, 327), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((12557, -73, 327), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((12551, -264, 831), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((12466, 1876, 1007), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((4547, -2699, 364), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((4201, -2685, 188), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((5035, -3131, 188), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((3804, -2671, 364), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((4247, -2840, 935), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((8024, -5405, 271), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((8307, -5875, 439), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((8915, -5286, 191), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((9757, -5730, 106), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((9522, -4261, 191), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((9355, -5309, 439), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((10118, -5058, 663), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((9374, -4549, 663), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((10129, -5618, 439), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((14736, -5434, 326), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((14619, -5338, 182), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((14161, -5545, 182), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((14079, -6189, 182), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((13675, -6687, 182), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((13628, -6239, 326), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((13891, -5634, 326), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((14364, -5101, 870), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((14925, -5196, 870), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-6791, -10472, 330), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-6865, -10376, 106), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-6714, 9727, 122), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-7052, -9330, 122), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-6327, -9972, 330), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-5849, -10375, 330), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-7158, -9477, 518), (0, randomintrange(0, 360), 0));
  } else if(level.mapname == "mp_saba_pm") {
    _id_DAB1E28DDBBC63CA((19755, -53032, 1082), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((18198, -56072, 1082), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((15702, -53591, 1146), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((17711, -54096, 1210), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((22696, -55257, 770), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((18999, -55091, 1338), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((15798, -54613, 1210), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((11045, -52162, 770), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((29430, -41278, 410), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((30764, -41380, 266), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((29340, -41524, 410), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((30020, -41833, 1898), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((30020, -41833, 1898), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((30486, -32650, 418), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((29584, -33097, 270), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((27837, -33288, 226), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((28095, -33977, 418), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((27109, -32406, 418), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((28930, -32283, 418), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((29914, -30093, 418), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((31595, -31294, 418), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((31359, -33418, 420), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-18337, -37223, 511), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-19268, -38582, 536), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-19850, -41065, 550), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-22313, -39523, 564), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-21205, -37416, 578), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-22122, -35365, 488), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-20617, -36008, 578), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-20451, -38132, 579), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-44528, -18621, 322), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-42533, -17014, 322), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-41820, -19679, 498), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-45544, -20173, 314), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-46178, -17162, 326), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-46082, -16203, 327), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-45176, -15879, 326), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-42515, -18105, 322), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-44066, -17184, 322), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-44042, -13878, 322), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-48363, -14164, 362), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-50476, -14807, 322), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-46015, -13133, 322), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-45344, -11912, 322), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-51300, 14421, 1148), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-50218, 15334, 1148), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-50584, 17071, 1154), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-49595, 17950, 1545), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-45724, 14668, 1148), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-49156, 13229, 802), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-48490, 12707, 666), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-49358, 13070, 666), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-50340, 14115, 866), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-49239, 11146, 866), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-47629, 11057, 1154), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-50178, 9959, 1018), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-28445, 27757, -221), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-28098, 27884, -61), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-24974, 27316, -157), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-24613, 27873, 5), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-23685, 28190, -373), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-23016, 26709, -421), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-21946, 26811, -427), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-21074, 25888, -429), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-21963, 23907, -281), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-21660, 27903, -28), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-21313, 30081, -173), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-23001, 32225, -220), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-25249, 28998, -227), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-19954, 30339, 7), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-19961, 22221, -245), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-20532, 17125, -129), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-20234, 15933, -413), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-21689, 15727, -273), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-14641, 11791, 754), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-12528, 14008, 754), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-13102, 11318, 698), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-12697, 14198, 754), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-10677, 13030, 530), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-7531, 14273, 611), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-9362, 7951, 362), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-6452, 7523, 573), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-4795, 6721, 690), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-6170, 5693, 474), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-6922, 4681, 746), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-7786, 5608, 426), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-11823, 9361, 538), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-10066, 12037, 522), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((6693, 34625, 329), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((5471, 32749, 504), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((5534, 29622, 739), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((6362, 27668, 930), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((4964, 25856, 329), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((2685, 26008, 444), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((2483, 28429, 321), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((4012, 23787, 328), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((3958, 24164, 536), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((5093, 23453, 535), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((5961, 24056, 536), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((6220, 22126, 521), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((10071, 21721, 322), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((13561, 37926, 329), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((15521, 37651, 465), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((16289, 35720, 330), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((16928, 33203, 522), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((21575, 28715, 460), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((19427, 20587, -63), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((20544, 22038, -61), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((18747, 20249, 321), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((15387, 17604, 329), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((16851, 12594, 459), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((16603, 10634, 496), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((13584, 33690, 327), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((13845, 33825, 1975), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((13140, 33832, 1975), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((14970, 29461, 353), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((15099, 28924, 497), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((16460, 29539, 361), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((16720, 30514, 529), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((16860, 30500, 361), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((15082, 26035, 337), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((15249, 24661, 473), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((15271, 21812, 473), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((16087, 20513, 337), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((14431, 20823, 337), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((15666, 21216, 697), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((15276, 21105, 1633), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((15590, 23171, 1448), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((14198, 26001, 1632), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((15574, 25707, 2465), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((15037, 26059, 1057), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((30432, 17634, 610), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((30475, 19611, 610), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((30366, 19377, 322), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((30426, 17397, 322), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((30388, 18547, 466), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((22134, -16334, 3894), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((21638, -15155, 4038), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((22465, -14974, 3773), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((19706, -16523, 3531), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((17167, -16263, 3028), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((17209, -14057, 3099), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((16029, -13080, 3017), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((15042, -14247, 2776), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((19032, -12795, 2940), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((18480, -10701, 3176), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((20959, -9300, 2725), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((21441, -12985, 3093), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((29026, -18550, 804), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((31025, -16543, 641), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((32750, -14769, 786), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((32464, -17552, 842), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((32554, -19265, 744), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((33512, -21402, 654), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((29467, -21229, 570), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((3918, -10946, 4754), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((3628, -11835, 4802), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((1795, -11784, 4862), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((97, -13516, 4922), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-898, -13387, 4922), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-1434, -15634, 4802), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-3058, -20853, 4494), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-3435, -23863, 4254), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-3738, -22682, 4462), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-5384, -17294, 4546), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-2492, -11251, 4770), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((523, -10986, 4730), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((2138, -9644, 5050), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-865, -11331, 4474), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-3520, -12710, 3130), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-3988, -12284, 3130), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((8420, -28742, 1276), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((5663, -26837, 1396), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((4163, -25993, 1420), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((3214, -28137, 1404), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((6760, -25542, 1668), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((9461, -24447, 1312), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((11406, -24717, 1352), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((12539, -25109, 1200), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((11237, -26475, 1184), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((10240, -25763, 1360), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((12358, -26852, 1200), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((14349, -25863, 1464), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((14751, -26510, 1328), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((16605, -24555, 1130), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((14837, -23128, 1283), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((16986, -23646, 1123), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((18606, -22869, 1134), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((19358, -26126, 1122), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((22426, -26427, 626), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((25013, -25538, 818), (0, randomintrange(0, 360), 0));
  } else if(level.mapname == "mp_escape4") {
    _id_DAB1E28DDBBC63CA((530, -7486, 100), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((502, -7420, 100), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((448, -7455, 100), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((461, -7368, 100), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((407, -7495, 100), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((398, -7374, 100), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((361, -7427, 100), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((317, -7462, 100), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((329, -7370, 100), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((578, -7409, 100), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((2450, -2915, 50), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((2501, -2864, 50), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((2448, -2827, 50), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((2534, -2806, 50), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((2396, -2804, 50), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((2505, -2750, 50), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((2442, -2736, 50), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((2483, -2685, 50), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((2393, -2708, 50), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((2540, -2930, 50), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-3375, 4404, -17), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-3420, 4459, -17), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-3478, 4375, -17), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-3485, 4432, -17), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-3474, 4498, -17), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-3543, 4399, -17), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-3532, 4496, -17), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-3584, 4454, -17), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-3586, 4368, -17), (0, randomintrange(0, 360), 0));
    _id_DAB1E28DDBBC63CA((-3350, 4491, -17), (0, randomintrange(0, 360), 0));
  }
}

_id_DAB1E28DDBBC63CA(origin, angles, _id_8AE63B0D643D4E2A, _id_8216C9148D9CF617, forcespawn) {
  if(!istrue(forcespawn)) {
    circleorigin = _id_2695A20D4011076D::getsafecircleorigin();
    circleradius = _id_2695A20D4011076D::getsafecircleradius();

    if(!scripts\engine\utility::ispointinsidecircle(origin, circleorigin, circleradius) && level.br_circle.circleindex == 0)
      return;
  }

  zombie = undefined;
  zombie = _id_4DDC095EC77D4BEC::_id_BC39F450BA654089(origin, angles, "enemy_lw_zombie_default", level._id_8E966244F7680884, undefined, _id_8AE63B0D643D4E2A, _id_8216C9148D9CF617);

  if(isDefined(zombie)) {
    zombie.entered_playspace = 1;
    zombie._id_94919E2028DBC9D0 = ::_id_7998A7DE21FC202E;
  }

  return zombie;
}

_id_9486695A83828A6B(_id_AF4CBAC5D9F8D2DD) {
  if(_id_AF4CBAC5D9F8D2DD _id_2CEDCC356F1B9FC8::playeriszombie())
    return 1;

  return 0;
}

_id_C37A0B3355A0200D(_id_1E0B2C127D2BE63E) {
  if(_id_1E0B2C127D2BE63E _id_2CEDCC356F1B9FC8::playeriszombie())
    return 0;

  return undefined;
}

_id_7998A7DE21FC202E(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration) {
  if(!isDefined(level.brgametype._id_664897C80FF2A610)) {
    return;
  }
  if(randomint(100) <= level.brgametype._id_664897C80FF2A610)
    _id_536210A44B407BF4();

  if(isDefined(eattacker) && isPlayer(eattacker) && !eattacker _id_2CEDCC356F1B9FC8::playeriszombie())
    _id_294DDA4A4B00FFE3::_id_D24F2DD28D26377E(level.brgametype._id_F55BE0289E3EF5AA);
}

_id_A78DBF22A6DED3AC() {
  level endon("game_ended");

  if(!_id_294DDA4A4B00FFE3::_id_4AD287E0971672A6()) {
    return;
  }
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  _id_ACA4779F20EC97B3 = level._id_ADAAED38371FA15B.state == 1;

  for(;;) {
    if(!istrue(_id_ACA4779F20EC97B3))
      level waittill("br_pe_meter_active");

    _id_ACA4779F20EC97B3 = 0;
    level.brgametype._id_E7CDD3FB24F93391 = 3;
    _id_C8693EECDD0B3E54 = _id_294DDA4A4B00FFE3::_id_C6B950C21813B5CD();
    _id_82819A1606FDDCC0 = level._id_ADAAED38371FA15B._id_0D4622DBFFCAD86C._id_82819A1606FDDCC0[_id_C8693EECDD0B3E54];
    _id_0D2222D7D7C83A9E = 0;

    foreach(eventtype in _id_82819A1606FDDCC0) {
      if(eventtype == 20)
        _id_0D2222D7D7C83A9E = 1;
    }

    if(istrue(_id_0D2222D7D7C83A9E)) {
      while(gettime() < level._id_ADAAED38371FA15B.timer.endtime) {
        _id_1C7F9D74D59B2416::_id_EB754127266D1DEC();
        _id_1C7F9D74D59B2416::_id_C8B0148638FB3F0A();
        wait 1;
      }
    }
  }
}

_id_528397B2B79B6E9C(agent, attacker, inflictor, meansofdeath) {
  _id_F8F9822D9DF61C5F = 0;

  if(isDefined(attacker) && isPlayer(attacker) && attacker _id_2CEDCC356F1B9FC8::playeriszombie() && isDefined(agent) && istrue(agent.zombie))
    _id_F8F9822D9DF61C5F = 1;

  return _id_F8F9822D9DF61C5F;
}

_id_46B4BD6590584475(data) {
  attacker = scripts\engine\utility::ter_op(isDefined(data.attacker), data.attacker, data.inflictor);

  if(isDefined(attacker))
    return istrue(attacker.zombie);

  return 0;
}

_id_C271E4000367648F(_id_0FCF7E6E6D8C4861, _id_0FCF7B6E6D8C41C8) {
  return distance2dsquared(_id_0FCF7E6E6D8C4861.origin, self.origin) < distance2dsquared(_id_0FCF7B6E6D8C41C8.origin, self.origin);
}