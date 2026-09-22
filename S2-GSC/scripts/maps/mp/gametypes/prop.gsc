/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\prop.gsc
**********************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
    level._id_5300 = ::_id_5300;
    [[level._id_5300]]();
    level thread maps\mp\_utility::_id_7C13();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 1, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 4);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 0);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 4);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 3);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 1);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level.phsettings = spawnStruct();
    level.phsettings.prophidetime = 30;
    level.phsettings.propwhistletime = 30;
    level.phsettings.propchangecount = 2;
    level.phsettings.propnumflashes = 1;
    level.phsettings.propnumclones = 3;
    level.phsettings.propspeedscale = 1.4;
    level.phsettings.allowloadouts = 0;
    _setdynamicdvar("scr_player_healthregentime", 0);
    level._id_6031 = 0;
    level._id_6035 = 0;
  }

  level.isprophunt = 1;
  level.objectivebased = 1;
  level.blockteamchange = 0;
  level._id_0C25 = 1;
  level.startcheck = 0;
  level._id_5A74 = 1;
  level._id_5A6F = 0;
  maps\mp\_utility::_id_873B(1);
  level._id_6BAF = ::_id_6BAF;
  level._id_6B5C = ::_id_6B5C;
  level._id_6BB2 = ::_id_6BB2;
  level._id_6BA7 = ::_id_6BA7;
  level._id_6B5E = ::_id_6B5E;
  level._id_6BB6 = ::_id_6BB6;
  level._id_6B7B = ::_id_6B7B;
  level._id_6AE2 = ::_id_6AE2;
  level.checkforovertime = ::ph_checkforovertime;
  level._id_297F = ::playdamagesoundph;
  level._id_2980 = ::playdeathsoundph;
  level._id_62AD = ::_id_3FC8;
  level._id_1DEA = ::phclass;
  level._id_3FDD = ::applyprophuntperks;
  level.getgamewinnerfunc = ::getgamewinnerprop;
  level.gametyperoundendscoresetomnvar = ::gametyperoundendscoresetomnvar;
  level.checkunscoredspawnpoint = ::checkunscoredspawnpoint;
  level.gametypemovespeedscalefunc = ::propmovespeedscale;
  level._id_2FA0 = ::disablespawningforplayer;
  level._id_2FAB = 1;
  level.disabledivisionstats = 1;
  level._id_2F8B = 1;
  level.disableallplayerstats = 1;
  level.disableweaponchallenges = 1;
  level.disabledivisionchallenges = 1;
  level.disablewinlossstats = 1;
  level thread removeairbornedivisionsuppressorability();

  if(level._id_6031 || level._id_6035) {
    level._id_62AD = maps\mp\gametypes\_damage::_id_3FC8;
  }

  level.proplist = [];
  level.propindex = [];
  level.spawnproplist = [];
  level.perks = ["FLASH", "CLONE"];
  populateproplist();

  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";
  level._id_483A = int(level.phsettings.prophidetime + 0.5);
  level thread onplayerconnect();
  level thread overridecountdownmusic();
}

overridecountdownmusic() {
  while(!isDefined(game["music"]) || !isDefined(game["music"]["match_ending_soon"])) {
    waitframe();
  }

  game["music"]["match_ending_soon"] = "prop_countdown";
}

removeairbornedivisionsuppressorability() {
  for(;;) {
    var_0 = _id_04CA::_id_44A1(1, "airborne") != "skill_level0";
    var_1 = _id_04CA::_id_44A1(1, "airborne") != "skill_level0";
    var_2 = _id_04CA::_id_44A1(1, "airborne") != "skill_level0";

    if(var_0 && var_1 && var_2) {
      break;
    }

    waitframe();
  }

  _id_04CA::removedivisionprogressionskillunlock(1, "airborne");
  _id_04CA::removedivisionprogressionskillunlock(1, "airborne");
  _id_04CA::removedivisionprogressionskillunlock(1, "airborne");
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread attackerswaittime();
    var_0 thread playerwatchspectate();

    if(!isDefined(var_0.pers["propSeconds"])) {
      var_0.pers["propSeconds"] = 0;
    }

    var_0 maps\mp\_utility::_id_867B(var_0.pers["propSeconds"]);
  }
}

_id_1786() {}

propmovespeedscale() {
  if(self.team == game["defenders"]) {
    return level.phsettings.propspeedscale;
  } else {
    return 1;
  }
}

_id_5300() {
  maps\mp\_utility::_id_8653();
  _setdynamicdvar("scr_prop_roundswitch", 1);
  maps\mp\_utility::registerroundswitchdvar("prop", 1, 0, 9);
  var_0 = _getmatchrulesdata("commonOption", "scoreLimit");
  _setdynamicdvar("scr_prop_roundlimit", var_0);
  maps\mp\_utility::registerroundlimitdvar("prop", var_0);
  var_1 = int(var_0 / 2 + 1);

  if(var_0 == 0) {
    var_1 = 0;
  }

  _setdynamicdvar("scr_prop_winlimit", var_1);
  maps\mp\_utility::registerwinlimitdvar("prop", var_1);
  _setdynamicdvar("scr_prop_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("prop", 0);
  _setdynamicdvar("scr_prop_scorelimit", 0);
  maps\mp\_utility::registerscorelimitdvar("scorelimit", 0);
  level.phsettings = spawnStruct();
  level.phsettings.prophidetime = _getmatchrulesdata("propData", "propHideTime");
  level.phsettings.propwhistletime = _getmatchrulesdata("propData", "propWhistleTime");
  level.phsettings.propchangecount = _getmatchrulesdata("propData", "numChanges");
  level.phsettings.propnumflashes = _getmatchrulesdata("propData", "numFlashes");
  level.phsettings.propnumclones = _getmatchrulesdata("propData", "numClones");
  level.phsettings.propspeedscale = _getmatchrulesdata("propData", "propSpeedScale");
  level.phsettings.allowloadouts = _getmatchrulesdata("propData", "allowLoadouts") > 0;
}

_id_6BAF() {
  if([[level.checkforovertime]]()) {
    game["status"] = "overtime";
    setDvar("ui_overtime", 1);
    setDvar("overtimeTimeLimit", 3.5);
  }

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  } else
    level._id_7691 = 30;

  _id_872E();
  _setclientnamemode("manual_change");
  maps\mp\_utility::setobjectivetext(game["attackers"], &"OBJECTIVES_PH_ATTACKER");
  maps\mp\_utility::setobjectivetext(game["defenders"], &"OBJECTIVES_PH_DEFENDER");
  maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_PH_ATTACKER_SCORE");
  maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_PH_DEFENDER_SCORE");
  maps\mp\_utility::setobjectivehinttext(game["attackers"], &"OBJECTIVES_PH_ATTACKER_HINT");
  maps\mp\_utility::setobjectivehinttext(game["defenders"], &"OBJECTIVES_PH_DEFENDER_HINT");
  var_2 = game["roundsPlayed"] % 4 == 2 || game["roundsPlayed"] % 4 == 3;

  if(var_2) {
    game["switchedsides"] = !game["switchedsides"];
    _id_050D::_id_10E4();
    game["switchedsides"] = !game["switchedsides"];
  } else
    _id_050D::_id_10E4();

  var_3[0] = level.gametype;
  _id_04D1::main(var_3);
  level._effect["propFlash"] = loadfx("vfx/explosion/stun");
  level._effect["propDeathFX"] = loadfx("vfx/explosion/prop_explosion");

  if(!isDefined(game["propScore"])) {
    game["propScore"] = [];
    game["propScore"]["allies"] = 0;
    game["propScore"]["axis"] = 0;
  }

  if(!isDefined(game["propSurvivalTime"])) {
    game["propSurvivalTime"] = [];
    game["propSurvivalTime"]["allies"] = 0;
    game["propSurvivalTime"]["axis"] = 0;
  }

  if(!isDefined(game["hunterKillTime"])) {
    game["hunterKillTime"] = [];
    game["hunterKillTime"]["allies"] = 0;
    game["hunterKillTime"]["axis"] = 0;
  }

  maps\mp\_utility::gameflaginit("props_hide_over", 0);
  level thread setuproundstarthud();

  if(level.phsettings.propwhistletime > 0) {
    level thread propwhistle();
  }

  level thread propspectating();
  level thread maps\mp\gametypes\_prop_controls::hidehudintermission();
  level thread monitortimers();
  level thread deleteallglass();
  level thread setphteamscores();
  level thread stillalivexp();
  level thread tracktimealive();
}

_id_6B5C(var_0, var_1, var_2) {
  propgiveteamscore(var_1.pers["team"]);

  if(game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level._id_6C63[var_1.team]]) {
    var_1._id_3B4B = 1;
  }
}

_id_6BB2(var_0) {
  if(var_0 maps\mp\gametypes\_playerlogic::mayspawn()) {
    return;
  }
  var_1 = maps\mp\_utility::getotherteam(var_0.pers["team"]);
  propgiveteamscore(var_1);
}

propgiveteamscore(var_0) {
  if(var_0 != game["attackers"]) {
    return;
  }
  level _id_04D2::_id_47BD(var_0, 1, 1);
  game["propScore"][var_0] = game["propScore"][var_0] + 1;
}

getgamewinnerprop(var_0, var_1) {
  if(!_isstring(var_0)) {
    return var_0;
  }

  var_2 = var_0;

  if(level.gameended) {
    var_3 = "roundsWon";

    if(isDefined(level._id_AA24) && level._id_AA24) {
      var_3 = "teamScores";
    }

    level.proptiebreaker = "none";

    if(game[var_3]["allies"] == game[var_3]["axis"]) {
      level.proptiebreaker = "kills";

      if(game["propScore"]["axis"] == game["propScore"]["allies"]) {
        level.proptiebreaker = "time";

        if(game["hunterKillTime"]["axis"] == game["hunterKillTime"]["allies"]) {
          level.proptiebreaker = "tie";
          var_2 = "tie";
        } else if(game["hunterKillTime"]["axis"] < game["hunterKillTime"]["allies"])
          var_2 = "axis";
        else {
          var_2 = "allies";
        }
      } else if(game["propScore"]["axis"] > game["propScore"]["allies"])
        var_2 = "axis";
      else {
        var_2 = "allies";
      }

      if(var_2 != "tie") {
        level thread givephteamscore(var_2);
      }
    } else if(game[var_3]["axis"] > game[var_3]["allies"])
      var_2 = "axis";
    else {
      var_2 = "allies";
    }
  }

  if(var_1 && (var_2 == "allies" || var_2 == "axis")) {
    ph_setfinalkillcamwinner(var_2);
  }

  return var_2;
}

_id_872E() {
  var_0 = game["defenders"];
  level.ph_loadouts[var_0] = maps\mp\gametypes\_class::_id_44B4();
  level.ph_loadouts[var_0]["loadoutDivision"] = 1;
  level.ph_loadouts[var_0]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(17125376, 0);
  level.ph_loadouts[var_0]["ignoreMeleeSlotWeapon"] = 1;
  var_1 = game["attackers"];
  level.ph_loadouts[var_1] = maps\mp\gametypes\_class::_id_44B4();
  level.ph_loadouts[var_1]["loadoutDivision"] = 1;
  level.ph_loadouts[var_1]["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::_id_473C(16859136, 0);
  level.ph_loadouts[var_1]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(16953344, 0);
  level.ph_loadouts[var_1]["loadoutPrimaryAttachmentsGUID"][0] = 50331888;
  level.ph_loadouts[var_1]["loadoutPrimaryAttachmentsGUID"][1] = 50332528;
  level.ph_loadouts[var_1]["loadoutOffhandStruct"] = maps\mp\_utility::_id_473C(16785408, 0);
  level.ph_loadouts[var_1]["ignoreMeleeSlotWeapon"] = 1;
}

phclass() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.pers["gamemodeLoadout"] = level.ph_loadouts[self.pers["team"]];
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
}

applyprophuntperks() {
  if(self.team == game["attackers"]) {
    maps\mp\_utility::giveperk("specialty_extratactical");
    maps\mp\_utility::giveperk("specialty_lightweight");
    maps\mp\_utility::giveperk("specialty_fastclimb");
    maps\mp\_utility::giveperk("specialty_fastmantle");
    maps\mp\_utility::giveperk("specialty_longersprint");
  } else if(self.team == game["defenders"]) {
    maps\mp\_utility::giveperk("specialty_quieter");
    maps\mp\_utility::giveperk("specialty_fastclimb");
    maps\mp\_utility::giveperk("specialty_fastmantle");
  }
}

propspectating() {
  level endon("game_ended");
  _id_050F::_id_A16A();
}

addupperrighthudelem(var_0, var_1, var_2, var_3) {
  var_4 = maps\mp\gametypes\_hud_util::createfontstring("default", 0.9);
  var_4.x = -15;
  var_4.y = self.currenthudy;
  var_4.alignx = "right";
  var_4.aligny = "top";
  var_4._id_00C6 = "right_adjustable";
  var_4._id_01CA = "top_adjustable";
  var_4.archived = 1;
  var_4.fontscale = 1;
  var_4.alpha = 1;
  var_4.glowalpha = 0;
  var_4.hidewheninmenu = 0;

  if(isDefined(var_0) && isDefined(var_3)) {
    if(common_scripts\utility::_id_55E0()) {
      var_4.label = var_0;
    } else {
      var_4.label = var_3;
    }
  } else if(isDefined(var_0))
    var_4.label = var_0;
  else if(isDefined(var_2)) {
    var_4 settext(var_2);
  }

  if(isDefined(var_1)) {
    var_4 setvalue(0);
  }

  self.currenthudy = self.currenthudy + 18;
  return var_4;
}

whistlestarttimer(var_0) {
  level notify("whistle_start_timer_beginning");
  var_1 = int(var_0);

  if(var_1 >= 0) {
    thread whistlestarttimer_internal(var_1);
  }
}

whistlestarttimer_internal(var_0) {
  level endon("whistle_start_timer_beginning");
  waittillframeend;

  while(var_0 > 0 && !level.gameended) {
    _setomnvar("ui_ph_whistle_countdown", var_0);
    var_0--;
    wait 1;
  }

  _setomnvar("ui_ph_whistle_countdown", var_0);
}

useprophudserver() {
  return 0;
}

setuproundstarthud() {
  _luinotifyevent(&"ui_init_round", 0);
  level.phcountdowntimer = maps\mp\gametypes\_hud_util::_id_282B("default", 1.4);
  level.phcountdowntimer maps\mp\gametypes\_hud_util::setpoint("CENTER", undefined, 0, 50);
  level.phcountdowntimer.label = &"MP_PH_STARTS_IN";
  level.phcountdowntimer.alpha = 0;
  level.phcountdowntimer.archived = 0;
  level.phcountdowntimer.hidewheninmenu = 1;
  level.phcountdowntimer.sort = 1;

  if(useprophudserver()) {
    level.phwhistletimer = maps\mp\gametypes\_hud_util::_id_282B("default", 0.9);
    level.phwhistletimer.x = -6;
    level.phwhistletimer.y = 2;
    level.phwhistletimer.alignx = "right";
    level.phwhistletimer.aligny = "top";
    level.phwhistletimer._id_00C6 = "right_adjustable";
    level.phwhistletimer._id_01CA = "top_adjustable";
    level.phwhistletimer.label = &"MP_PH_WHISTLE_IN";
    level.phwhistletimer.alpha = 0;
    level.phwhistletimer.archived = 0;
    level.phwhistletimer.hidewheninmenu = 1;
    level.phwhistletimer settimer(120);
  }

  whistlestarttimer(120);

  if(useprophudserver()) {
    level.whistling = maps\mp\gametypes\_hud_util::_id_2829("default", 1);
    level.whistling.label = &"MP_PH_WHISTLING";
    level.whistling.x = -5;
    level.whistling.y = 2;
    level.whistling.alignx = "right";
    level.whistling.aligny = "top";
    level.whistling._id_00C6 = "right_adjustable";
    level.whistling._id_01CA = "top_adjustable";
    level.whistling.archived = 1;
    level.whistling.alpha = 0;
    level.whistling.glowalpha = 0.2;
    level.whistling.hidewheninmenu = 0;
  }

  if(useprophudserver()) {
    if(!isDefined(level.elim_hud)) {
      level.elim_hud = [];
    }

    level.elim_hud = maps\mp\gametypes\_hud_util::_id_2829("default", 0.9);
    level.elim_hud.label = &"MP_PH_ALIVE";
    level.elim_hud setvalue(0);
    level.elim_hud.x = -5;
    level.elim_hud.y = 14;
    level.elim_hud.alignx = "right";
    level.elim_hud.aligny = "top";
    level.elim_hud._id_00C6 = "right_adjustable";
    level.elim_hud._id_01CA = "top_adjustable";
    level.elim_hud.archived = 1;
    level.elim_hud.fontscale = 1.0;
    level.elim_hud.alpha = 1;
    level.elim_hud.glowalpha = 0;
    level.elim_hud.hidewheninmenu = 0;
    level thread eliminatedhudmonitor();
  }
}

eliminatedhudmonitor() {
  level endon("game_ended");

  for(;;) {
    var_0 = get_alive_nonspecating_players(game["defenders"]);
    level.elim_hud setvalue(var_0.size);
    level common_scripts\utility::_id_A70A("player_spawned", "player_killed", "player_eliminated", "playerCountChanged", "propCountChanged");
  }
}

get_alive_nonspecating_players(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isalive(var_3) && (!isDefined(var_3.sessionstate) || var_3.sessionstate == "playing")) {
      if(!isDefined(var_0) || var_3.team == var_0) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

kickplayer(var_0, var_1) {
  if(isbot(var_0)) {
    return;
  }
  _kick(var_0 getentitynumber(), var_1);
}

weaponusagecheck() {
  var_0 = common_scripts\utility::waittill_any_return("weapon_fired", "sprint_begin", "specialGrenade", "end_weapon_check_usage");

  if(var_0 == "end_weapon_check_usage") {
    if(common_scripts\utility::_id_562E(self.hashitplayer)) {
      return 1;
    }

    kickplayer(self, "EXE_PLAYERKICKED_INACTIVE");
    return 0;
  }

  return 1;
}

positioncheck(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = 45;
  }

  if(!isDefined(var_1)) {
    var_1 = 300;
  }

  var_2 = self.origin;
  var_3 = _squared(var_1);
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0; var_5++) {
    if(!var_4) {
      var_6 = distancesquared(var_2, self.origin);

      if(var_6 >= var_3) {
        var_4 = 1;
      }
    }

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
  }

  if(var_4) {
    return 1;
  }

  return 0;
}

startcheck() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self.doingcheck = 1;
  maps\mp\_utility::gameflagwait("prematch_done");

  while(!level.startcheck) {
    wait 1;
  }

  childthread weaponusagecheck();

  if(!positioncheck(45, 300)) {
    if(common_scripts\utility::_id_562E(self.hashitplayer)) {
      return;
    }
    kickplayer(self, "EXE_PLAYERKICKED_INACTIVE");
    return;
  }

  if(!positioncheck(75, 150)) {
    if(common_scripts\utility::_id_562E(self.hashitplayer)) {
      return;
    }
    kickplayer(self, "EXE_PLAYERKICKED_INACTIVE");
    return;
  }

  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(30);
  self notify("end_weapon_check_usage");
}

_id_6BA7() {
  self._id_1BC1 = 0;
  self.abilityleft = 0;
  self.clonesleft = 0;
  _setomnvar("ui_war_attacker_team", maps\mp\_utility::_id_46D4(game["attackers"]));
  self _meth_85EF(&"ui_player_spawned", 0);
  self setclientomnvar("ui_disable_team_change", 1);

  if(self.team == game["defenders"]) {
    if(!isDefined(self.pers["ability"])) {
      self.pers["ability"] = 0;
    }

    self.currentability = level.perks[self.pers["ability"]];

    if(useprophudserver()) {
      thread maps\mp\gametypes\_prop_controls::propcontrolshud();
    }

    self.isangleoffset = 0;
    maps\mp\gametypes\_prop_controls::propsetchangesleft(int(level.phsettings.propchangecount));
    maps\mp\gametypes\_prop_controls::setnewabilitycount(self.currentability);
    maps\mp\gametypes\_prop_controls::setnewabilitycount("CLONE");
    thread maps\mp\gametypes\_prop_controls::cleanuppropcontrolshudondeath();
    thread handleprop();
  } else {
    if(!isDefined(self.thrownspecialcount)) {
      self.thrownspecialcount = 0;
    }

    thread givecustomloadout();
    var_0 = 1;

    if(var_0 && !isDefined(self.doingcheck)) {
      thread startcheck();
    }
  }
}

monitortimers() {
  level endon("game_ended");
  maps\mp\_utility::gameflagwait("prematch_done");
  level.blockteamchange = 1;
  level thread pausephtimerformigration();

  if(level.phsettings.prophidetime > 0) {
    level.phcountdowntimer settimer(level.phsettings.prophidetime);
    level.phcountdowntimer.alpha = 1;
  }

  if(useprophudserver()) {
    level.phwhistletimer settimer(level.phsettings.propwhistletime + level.phsettings.prophidetime);
    level.phwhistletimer.alpha = 1;
  }

  if(level.phsettings.prophidetime > 0 || level.phsettings.propwhistletime > 0) {
    whistlestarttimer(level.phsettings.propwhistletime + level.phsettings.prophidetime);
  }

  if(level.phsettings.prophidetime > 0) {
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(level.phsettings.prophidetime);
  }

  maps\mp\_utility::gameflagset("props_hide_over");

  if(useprophudserver()) {
    level.phwhistletimer.alpha = 1;
  }

  level.phcountdowntimer.alpha = 0;

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_hide_hud", 0);
  }
}

pausephtimerformigration() {
  level endon("game_ended");
  level endon("props_hide_over");
  var_0 = int(level.phsettings.prophidetime + gettime() / 1000);
  var_1 = 0;

  for(;;) {
    level waittill("host_migration_begin");
    level.phcountdowntimer.alpha = 0;

    if(useprophudserver()) {
      level.phwhistletimer.alpha = 0;
    }

    var_2 = int(maps\mp\gametypes\_hostmigration::_id_A782() / 1000);
    var_1 = var_1 + var_2;
    var_2 = var_1;
    var_3 = var_0 + var_2 - int(gettime() / 1000);
    level.phcountdowntimer settimer(var_3);

    if(useprophudserver()) {
      level.phwhistletimer settimer(level.phsettings.propwhistletime + var_3);
    }

    whistlestarttimer(level.phsettings.propwhistletime + var_3);
    level.phcountdowntimer.alpha = 1;

    if(useprophudserver()) {
      level.phwhistletimer.alpha = 1;
    }
  }
}

handleprop() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self waittill("applyLoadout");
  self allowprone(0);
  self allowsprint(0);
  _id_0513::_id_A13B();
  self _meth_86BB();
  self disableweaponpickup();
  self takeallweapons();
  self allowspectateteam(game["attackers"], 1);
  self playerhide();
  thread setupprop();
  thread maps\mp\gametypes\_prop_controls::setupkeybindings();
  thread setupdamage();
  thread maps\mp\gametypes\_prop_controls::propinputwatch();
  thread propwatchdeath();
  thread propwatchdeletedisconnect();
  thread propwatchdeleteclonesondisconnect();
  thread propwatchdeleteroundend();
  thread propwatchprematchsettings();
  self._id_777D thread highlighttoteam(game["defenders"], 2, self);
}

getthirdpersonrangeforpropinfo(var_0) {
  switch (var_0.propsize) {
    case 50:
      return 120;
    case 100:
      return 150;
    case 250:
      return 180;
    case 450:
      return 260;
    case 550:
      return 320;
    default:
      break;
  }

  return 120;
}

getthirdpersonheightoffsetforpropinfo(var_0) {
  switch (var_0.propsize) {
    case 50:
      return -30;
    case 100:
      return -20;
    case 250:
      return 0;
    case 450:
      return 20;
    case 550:
      return 40;
    default:
      break;
  }

  return 0;
}

applyxyzoffset() {
  if(!isDefined(self._id_777D.xyzoffset)) {
    return;
  }
  self._id_777D.angles = self.angles;
  var_0 = anglesToForward(self._id_777D.angles) * self._id_777D.xyzoffset[0];
  var_1 = anglestoright(self._id_777D.angles) * self._id_777D.xyzoffset[1];
  var_2 = anglestoup(self._id_777D.angles) * self._id_777D.xyzoffset[2];
  self._id_777D.origin = self._id_777D.origin + var_0;
  self._id_777D.origin = self._id_777D.origin + var_1;
  self._id_777D.origin = self._id_777D.origin + var_2;
}

applyanglesoffset() {
  if(!isDefined(self._id_777D.anglesoffset)) {
    return;
  }
  self._id_777D.angles = self.angles;
  self._id_777D.angles = self._id_777D.angles + self._id_777D.anglesoffset;
  self.isangleoffset = 1;
}

propwhistle() {
  level endon("game_ended");
  maps\mp\_utility::gameflagwait("prematch_done");
  var_0 = gettime();
  var_1 = level.phsettings.propwhistletime * 1000;
  var_2 = 20000;
  var_3 = var_2;
  var_4 = 500;
  var_5 = 5000;
  var_6 = 0;
  var_7 = getEntArray("minimap_corner", "targetname")[0].origin;
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(level.phsettings.prophidetime + level.phsettings.propwhistletime);
  _setomnvar("ui_war_active_sector", 0);

  for(;;) {
    if(var_0 + var_1 - var_4 < gettime()) {
      var_6++;
      var_8 = _sortbydistance(level.players, var_7);

      foreach(var_10 in var_8) {
        if(!isDefined(var_10)) {
          continue;
        }
        if(useprophudserver()) {
          level.phwhistletimer.alpha = 0;
          level.whistling.alpha = 0.6;
        }

        if(var_10.team == game["defenders"] && isalive(var_10)) {
          if(useprophudserver()) {
            level.whistling.alpha = 1;
            level.whistling fadeovertime(0.75);
            level.whistling.alpha = 0.6;
          }

          playsoundatpos(var_10.origin + (0, 0, 60), "prop_whistle");
          maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1.5);
        }
      }

      _setomnvar("ui_war_active_sector", 2);
      var_0 = gettime();

      if(var_6 % 2 == 0) {
        var_1 = max(var_1 - 5000, var_2);
      }

      if(var_3 >= maps\mp\gametypes\_gamelogic::_id_46E5() - var_5) {
        if(useprophudserver()) {
          level.whistling.alpha = 0;
        }

        return;
      } else {
        if(var_3 * 2 + _getteamplayersalive(game["defenders"]) * 2500 >= maps\mp\gametypes\_gamelogic::_id_46E5() - var_5) {
          if(useprophudserver()) {
            level.phwhistletimer.label = &"MP_PH_FINAL_WHISTLE";
          }

          _setomnvar("ui_war_active_sector", 1);
          var_3 = var_3 + _getteamplayersalive(game["defenders"]) * 2500;
        }

        if(useprophudserver()) {
          level.phwhistletimer settimer(int(var_1 / 1000));
        }

        whistlestarttimer(int(var_1 / 1000));

        if(useprophudserver()) {
          level.whistling.alpha = 0;
          level.phwhistletimer.alpha = 1;
        }
      }
    }

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  }
}

getlivingplayersonteam(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_6E97) {
    if(!isDefined(var_3.team)) {
      continue;
    }
    if(maps\mp\_utility::isreallyalive(var_3) && maps\mp\_utility::_id_5800(var_3) && var_3.team == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

createpropspeclist() {
  self.spectatableprops = getlivingplayersonteam(game["defenders"]);
}

setupdamage() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  self._id_777D.damagecallback = ::damagewatch;
}

damagewatch(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(self._id_0117)) {
    return;
  }
  if(isPlayer(var_1)) {
    if(var_1.pers["team"] == self._id_0117.pers["team"]) {
      return;
    }
    var_1 thread _id_04C7::_id_A102("standard", self);
  }

  self._id_0117 dodamage(var_2, var_6, var_1, var_0, var_4, var_5, var_8);
}

propcleanup() {
  thread propcleanupdelayed([self._id_777D, self.propanchor, self.propent]);
}

propcleanupdelayed(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 unlink();
    }
  }

  waitframe();

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

propwatchdeath() {
  level endon("game_ended");
  self endon("disconnect");
  self.deathnoise = "prop_death";
  self.propdeathfx = "propDeathFX";
  self waittill("death");
  var_0 = self._id_18A8;
  playsoundatpos(self._id_777D.origin + (0, 0, 4), self.deathnoise);
  playFX(common_scripts\utility::_id_44F5(self.propdeathfx), self._id_777D.origin + (0, 0, 4));

  if(isDefined(var_0)) {
    var_0 delete();
  }

  propcleanup();
  self _meth_86BD(0, 0);
}

propwatchdeletedisconnect() {
  self endon("death");
  level endon("round_end_finished");
  self waittill("disconnect");

  foreach(var_1 in level.players) {
    if(common_scripts\utility::_id_562E(var_1.propspectating) && isDefined(var_1.spectatingthisplayer) && self == var_1.spectatingthisplayer) {
      var_1 notify("endPropSpectate");
    }
  }

  propcleanup();
}

propwatchdeleteclonesondisconnect() {
  level endon("round_end_finished");
  self waittill("disconnect");

  if(isDefined(self.propclones)) {
    foreach(var_1 in self.propclones) {
      var_1 delete();
    }
  }
}

propwatchdeleteroundend() {
  self endon("death");
  self endon("disconnect");
  level waittill("round_end_finished");
  propcleanup();
}

propwatchprematchsettings() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  maps\mp\_utility::gameflagwait("prematch_done");
  self allowprone(0);
  self allowsprint(0);
}

deleteallglass() {
  level endon("game_ended");
  level waittill("prematch_over");
  var_0 = _func_32F();

  for(var_1 = 0; var_1 < var_0; var_1++) {
    _deleteglass(var_1);
  }
}

organizeproplist(var_0) {
  return common_scripts\utility::array_randomize(var_0);
}

randgetpropsizetoallocate() {
  var_0 = 10 * isDefined(level.proplist[50]);
  var_1 = 30 * isDefined(level.proplist[100]);
  var_2 = 40 * isDefined(level.proplist[250]);
  var_3 = 20 * isDefined(level.proplist[450]);
  var_4 = 10 * isDefined(level.proplist[550]);
  var_5 = var_0 + var_1 + var_2 + var_3 + var_4;
  var_6 = randomint(var_5);

  if(var_6 < var_0) {
    return 50;
  }

  var_6 = var_6 - var_0;

  if(var_6 < var_1) {
    return 100;
  }

  var_6 = var_6 - var_1;

  if(var_6 < var_2) {
    return 250;
  }

  var_6 = var_6 - var_2;

  if(var_6 < var_3) {
    return 450;
  }

  var_6 = var_6 - var_3;
  return 550;
}

getnextprop(var_0) {
  var_1 = randgetpropsizetoallocate();
  var_2 = getarraykeys(level.proplist);
  var_2 = common_scripts\utility::array_randomize(var_2);
  var_3 = [var_1];

  foreach(var_5 in var_2) {
    if(var_5 != var_1) {
      var_3[var_3.size] = var_5;
    }
  }

  var_7 = undefined;

  for(var_8 = 0; var_8 < var_3.size; var_8++) {
    var_5 = var_3[var_8];

    if(!isDefined(level.proplist[var_5]) || !level.proplist[var_5].size) {
      continue;
    }
    var_9 = common_scripts\utility::array_randomize(level.proplist[var_5]);

    for(var_10 = 0; var_10 < var_9.size; var_10++) {
      var_7 = var_9[var_10];
      var_11 = 0;

      if(isDefined(var_0.usedprops) && var_0.usedprops.size) {
        for(var_12 = 0; var_12 < var_0.usedprops.size; var_12++) {
          if(var_7.modelname == var_0.usedprops[var_12].modelname) {
            var_11 = 1;
            break;
          }
        }
      }

      if(!var_11) {
        return var_7;
      }
    }
  }

  return var_7;
}

populateproplist() {
  var_0 = maps\mp\_utility::_id_4571();
  var_1 = "mp/ph_props_" + var_0 + ".csv";
  var_2 = _tablegetrowcount(var_1);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = _tablelookupbyrow(var_1, var_3, 0);
    var_5 = _tablelookupbyrow(var_1, var_3, 1);
    var_6 = int(_tablelookupbyrow(var_1, var_3, 2));
    var_7 = int(_tablelookupbyrow(var_1, var_3, 3));
    var_8 = int(_tablelookupbyrow(var_1, var_3, 4));
    var_9 = int(_tablelookupbyrow(var_1, var_3, 5));
    var_10 = int(_tablelookupbyrow(var_1, var_3, 6));
    var_11 = int(_tablelookupbyrow(var_1, var_3, 7));
    var_12 = undefined;

    if(isDefined(var_6) && isDefined(var_7) && isDefined(var_8)) {
      var_12 = (var_6, var_7, var_8);
    }

    var_13 = undefined;

    if(isDefined(var_9) && isDefined(var_10) && isDefined(var_11)) {
      var_13 = (var_9, var_10, var_11);
    }

    var_14 = getpropsize(var_5);
    addproptolist(var_4, var_14, var_12, var_13, var_5);
  }

  if(var_2 == 0) {
    addproptolist("tag_origin", 250, (0, 0, 0), (0, 0, 0), "medium");
  }

  level.proplist = organizeproplist(level.proplist);
}

setupprop() {
  var_0 = getnextprop(self);
  self.propanchor = spawn("script_model", self.origin);
  self.propanchor.targetname = "propAnchor";
  self.propanchor linktosynchronizedparent(self);
  self.propanchor _meth_86BA();
  self.propanchor setcontents(0);
  self.propent = spawn("script_model", self.origin);
  self.propent setModel("s2_generic_prop_raven_x3");
  self.propent.targetname = "propEnt";
  self.propent linktosynchronizedparent(self.propanchor);
  self.propent _meth_86BA();
  self.propent setcontents(0);
  self._id_777D = spawn("script_model", self.propent.origin);
  self._id_777D.targetname = "prop";
  self._id_777D setModel(var_0.modelname);
  self._id_777D setCanDamage(1);
  self._id_777D.xyzoffset = var_0.xyzoffset;
  self._id_777D.anglesoffset = var_0.anglesoffset;
  self._id_777D.angles = self.angles;
  applyxyzoffset();
  applyanglesoffset();
  self._id_777D linktosynchronizedparent(self.propent, "J_prop_1");
  self._id_777D _meth_86BA();
  self._id_777D._id_0117 = self;
  self._id_777D.health = 10000;
  self._id_777D setdamagecallbackon(1);
  self._id_777D setclientowner(self);
  self.propent scriptmodelplayanim("prop_hunt_prop_spin", "propSpinAnim", undefined, 1.5);
  self.propent setshadowrendering(1);
  self.thirdpersonrange = getthirdpersonrangeforpropinfo(var_0);
  self.thirdpersonheightoffset = getthirdpersonheightoffsetforpropinfo(var_0);
  self _meth_86BD(1, self.thirdpersonrange, self.thirdpersonheightoffset);
  self._id_777D._id_5135 = var_0;
  self.usedprops = [];
  self.health = getprophealth(var_0);
  self.maxhealth = self.health;
}

getprophealth(var_0) {
  var_1 = _id_0511::_id_46F7("player", "maxhealth");
  var_2 = var_1 / 100;
  return int(var_0.propsize * var_2);
}

getpropsize(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "xsmall":
      var_1 = 50;
      break;
    case "small":
      var_1 = 100;
      break;
    case "medium":
      var_1 = 250;
      break;
    case "large":
      var_1 = 450;
      break;
    case "xlarge":
      var_1 = 550;
      break;
    default:
      var_2 = maps\mp\_utility::_id_4571();
      var_3 = "mp/ph_props_" + var_2 + ".csv";
      var_1 = 100;
      break;
  }

  return var_1;
}

addproptolist(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.proplist)) {
    level.proplist = [];
  }

  if(!isDefined(level.propindex)) {
    level.propindex = [];
  }

  if(!isDefined(level.proplist[var_1])) {
    level.proplist[var_1] = [];
  }

  var_5 = spawnStruct();
  var_5.modelname = var_0;
  var_5.propsize = int(var_1);
  var_5.propsizetext = var_4;

  if(isDefined(var_2)) {
    var_5.xyzoffset = var_2;
  }

  if(isDefined(var_3)) {
    var_5.anglesoffset = var_3;
  }

  level.propindex[level.propindex.size] = [var_1, level.proplist[var_1].size];
  level.proplist[var_1][level.proplist[var_1].size] = var_5;
}

ph_endgame(var_0, var_1) {
  if(common_scripts\utility::_id_562E(level.endingph)) {
    return;
  }
  level.endingph = 1;
  ph_setfinalkillcamwinner(var_0);
  thread maps\mp\gametypes\_gamelogic::_id_36B9(var_0, var_1);
  level thread givephteamscore(var_0);

  if(var_0 == game["defenders"]) {
    thread sendachievementengineinfo(var_0);
  }
}

ph_setfinalkillcamwinner(var_0) {
  level._id_3B5C = var_0;

  if(level._id_3B5C == game["defenders"]) {
    level.skipfinalkillcamfx = 1;
  }
}

givephteamscore(var_0) {
  level endon("game_ended");
  var_1 = game["roundsWon"][var_0] + 1;
  _setteamscore(var_0, var_1);
}

sendachievementengineinfo(var_0) {
  var_1 = getlivingplayersonteam(var_0);

  foreach(var_3 in var_1) {
    var_3 _id_0468::_id_0A22("propRoundSurvivor");

    if(isDefined(var_3.changesleft) && var_3.changesleft == int(level.phsettings.propchangecount)) {
      var_3 _id_0468::_id_0A22("propChangelessSurvivor");
    }
  }
}

setphteamscores() {
  level endon("game_ended");
  var_0 = game["roundsWon"][game["defenders"]];
  var_1 = game["roundsWon"][game["attackers"]];
  _setteamscore(game["defenders"], var_0);
  _setteamscore(game["attackers"], var_1);
}

_id_6B5E(var_0) {
  if(common_scripts\utility::_id_562E(level.gameended)) {
    return;
  }
  if(var_0 == game["attackers"]) {
    return;
  }
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isDefined(var_0) && var_3.team != var_0) {
      continue;
    }
    if(!maps\mp\_utility::isreallyalive(var_3) && !var_3 maps\mp\gametypes\_playerlogic::mayspawn()) {
      continue;
    }
    if(isDefined(var_1)) {
      return;
    }
    var_1 = var_3;
  }

  if(!isDefined(var_1)) {
    return;
  }
  var_1 thread _id_478F();
}

_id_478F() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  maps\mp\_utility::waittillrecoveredhealth(3);
  var_0 = maps\mp\_utility::getotherteam(self.pers["team"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive", self, var_0);

  if(self.team == game["defenders"]) {
    level notify("noPropsToSpectate");
    level.nopropsspectate = 1;
  }

  level notify("last_alive", self);
}

_id_6BB6() {
  if(!common_scripts\utility::_id_562E(level.gameending)) {
    var_0 = maps\mp\_utility::gettimepassed();
    game["propSurvivalTime"][game["defenders"]] = game["propSurvivalTime"][game["defenders"]] + var_0;
    game["hunterKillTime"][game["attackers"]] = game["hunterKillTime"][game["attackers"]] + var_0;
    choosefinalkillcam();
    ph_endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);
  }
}

choosefinalkillcam() {
  var_0 = getlivingplayersonteam(game["defenders"]);

  if(var_0.size < 1) {
    return;
  }
  var_1 = getlivingplayersonteam(game["attackers"]);

  if(var_1.size < 1) {
    return;
  }
  var_2 = choosebestpropforkillcam(var_0, var_1);

  if(maps\mp\_utility::_id_56FF(var_2)) {
    var_3 = var_2 getentitynumber();
  } else {
    var_3 = -1;
  }

  var_4 = var_1[0];
  var_4._id_2AB8 = gettime() - 1000;
  _id_04CE::_id_7B32(5.0, var_4, var_2, var_3, -1, 0, "none", 0, 0, "none", "normal", 0);
}

choosebestpropforkillcam(var_0, var_1) {
  var_2 = undefined;
  var_3 = 1073741824;

  foreach(var_5 in var_0) {
    var_6 = undefined;
    var_7 = 1073741824;

    foreach(var_9 in var_1) {
      var_10 = _getpathdist(var_5.origin, var_9.origin, 999999);

      if(var_10 < var_7) {
        var_7 = var_10;
        var_6 = var_9;
      }
    }

    if(var_7 < var_3) {
      var_3 = var_7;
      var_2 = var_5;
    }
  }

  if(!isDefined(var_2)) {
    var_2 = common_scripts\utility::random(var_0);
  }

  return var_2;
}

ph_checkforovertime() {
  if(game["roundsWon"]["allies"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1 && game["roundsWon"]["axis"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1) {
    return 1;
  }

  return 0;
}

givecustomloadout() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self waittill("applyLoadout");
  self.thirdpersonrange = undefined;
  self _meth_86BD(0, 0);
  self allowprone(1);
  self allowsprint(1);
  _id_0513::_id_A13B();
  self _meth_86BC();
  self enableweaponpickup();
  self playershow();
  self.concussionimmune = 1;
  attackerinitammo();
  thread attackerregenammo();
}

stillalivexp() {
  level endon("game_ended");
  level.scoreinfo["kill"]["value"] = 300;
  level waittill("props_hide_over");

  for(;;) {
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(10);

    foreach(var_1 in level.players) {
      if(!isDefined(var_1.team)) {
        continue;
      }
      if(var_1.team == game["attackers"]) {
        continue;
      }
      if(!maps\mp\_utility::isreallyalive(var_1)) {
        continue;
      }
      level thread maps\mp\gametypes\_rank::_id_1457("still_alive", var_1);

      switch (var_1._id_777D._id_5135.propsize) {
        case 250:
          level thread maps\mp\gametypes\_rank::_id_1457("still_alive_medium_bonus", var_1);
          break;
        case 450:
          level thread maps\mp\gametypes\_rank::_id_1457("still_alive_large_bonus", var_1);
          break;
        case 550:
          level thread maps\mp\gametypes\_rank::_id_1457("still_alive_extra_large_bonus", var_1);
          break;
        default:
          break;
      }
    }
  }
}

tracktimealive() {
  level endon("game_ended");
  maps\mp\_utility::gameflagwait("prematch_done");

  for(;;) {
    foreach(var_1 in level.players) {
      if(!isDefined(var_1.team)) {
        continue;
      }
      if(var_1.team == game["attackers"]) {
        continue;
      }
      if(!maps\mp\_utility::isreallyalive(var_1)) {
        continue;
      }
      var_1.pers["propSeconds"]++;
      var_1 maps\mp\_utility::_id_867B(var_1.pers["propSeconds"]);
    }

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
  }
}

_id_3FC8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(common_scripts\utility::_id_562E(self.propspectating)) {
    self notify("endPropSpectate");

    if(var_4 == "MOD_TRIGGER_HURT") {
      return 0;
    }
  }

  if(isDefined(var_0.team)) {
    if(var_0.team == game["attackers"]) {
      var_3 = modifydamagetohunter(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    } else if(var_0.team == game["defenders"]) {
      var_3 = modifydamagetoprop(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }

    if(var_3 == 0) {
      return 0;
    }
  }

  if(isDefined(var_2) && isPlayer(var_2) && isalive(var_2)) {
    if(!isDefined(var_2.hashitplayer)) {
      var_2.hashitplayer = 1;
    }

    if(level._id_6031) {
      var_3 = var_3 * level._id_6031;
    }

    if(level._id_6035) {
      var_2.health = int(_min(_float(var_2.maxhealth), _float(var_2.health + 20)));
    }
  }

  return var_3;
}

modifydamagetoprop(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_4) && var_4 == "MOD_FALLING") {
    return 0;
  }

  return var_3;
}

modifydamagetohunter(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_4) && var_4 == "MOD_FALLING") {
    return 0;
  }

  if(var_5 == "stun_grenade_mp") {
    return 0;
  }

  if(issubstr(var_5, "destructible")) {
    return 0;
  }

  return var_3;
}

attackerswaittime() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");

  if(self.team == game["defenders"]) {
    return;
  }
  maps\mp\_utility::gameflagwait("prematch_done");

  while(!isDefined(level.starttime)) {
    waitframe();
  }

  while(isDefined(self.controlsfrozen) && self.controlsfrozen) {
    waitframe();
  }

  var_0 = (gettime() - level.starttime) / 1000.0;
  var_1 = level.phsettings.prophidetime - var_0;

  if(var_1 > 0) {
    maps\mp\_utility::freezecontrolswrapper(1);
    self.phfrozen = 1;

    if(int(var_0) > 0) {
      var_2 = 0.0;
    } else {
      var_2 = 1.0;
    }

    var_3 = 1.0;

    if(var_2 + var_3 > var_1) {
      var_2 = 0.0;
      var_3 = 0.0;
    }

    thread maps\mp\gametypes\_prop_controls::fadetoblackforxsec(var_1, var_2, var_3);

    if(getdvarint("scr_prop_minigame", 0)) {
      thread propwaitminigameinit();
    }

    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_1);
  }

  self.phfrozen = undefined;
  level.startcheck = 1;
  maps\mp\_utility::freezecontrolswrapper(0);
}

propminigamesetting(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.color = var_0;
  var_4.label = var_1;
  var_4.winfontscale = var_3;
  var_4.winyoffset = var_2;
  return var_4;
}

propwaitminigameinit() {
  if(!isDefined(level.minigameinfo)) {
    level.minigamefinishcount = 0;
    level.minigamewinnersettings = [];
    level.minigamewinnersettings[0] = propminigamesetting((1, 0.843, 0), &"MP_PH_MINIGAME_FIRST", -80, 2.0);
    level.minigamewinnersettings[1] = propminigamesetting((0.3, 0.3, 0.3), &"MP_PH_MINIGAME_SECOND", -50, 1.75);
    level.minigamewinnersettings[2] = propminigamesetting((0.804, 0.498, 0.196), &"MP_PH_MINIGAME_THIRD", -20, 1.5);
    level.minigamelosersettings = propminigamesetting((1, 1, 1), &"MP_PH_EMPTY");
    level.minigameinfo = [];
    level thread propminigameupdates();
  }

  var_0 = spawnStruct();
  var_0.player = self;
  var_0.guid = self.guid;
  var_0.finish = 0;
  var_0._id_1DC7 = "+weapnext";
  var_0.buttonnotify = "miniGameButtonPress";
  level thread propwaitminigamecleanuponplayernotify("disconnect", var_0);
  level propwaitminigamerun(var_0);
}

propwaitminigamecleanuponplayernotify(var_0, var_1) {
  level endon("game_ended");
  level endon("props_hide_over");
  level endon("mini_game_end");
  var_1.player waittill(var_0);
  propwaitminigamecleanup(var_1);
}

propwaitminigamecleanup(var_0) {
  if(isDefined(var_0._id_4F52)) {
    var_0._id_4F52 destroy();
  }

  if(isDefined(var_0.player) && !isbot(var_0.player)) {
    var_0.player notifyonplayercommandremove(var_0.buttonnotify, var_0._id_1DC7);
  }

  level.minigameinfo[var_0.guid] = undefined;
}

propwaitminigamerun(var_0) {
  level endon("game_ended");
  level endon("props_hide_over");
  level endon("mini_game_end");
  var_0.player endon("disconnect");

  if(!isbot(var_0.player)) {
    var_0.player notifyonplayercommand(var_0.buttonnotify, var_0._id_1DC7);
  }

  if(isbot(var_0.player)) {
    while(!level.minigameinfo.size) {
      waitframe();
    }

    wait(_randomfloatrange(0.0, 1.0));
  } else
    var_0.player waittill(var_0.buttonnotify);

  var_0.player setclientomnvar("ui_hide_hud", 1);
  level.minigameinfo[var_0.guid] = var_0;
  propwaitminigamehudinit(var_0);
  propwaitminigamehudsetpoint(var_0);
  childthread propwaitminigamebuttonwatch(var_0);
  childthread propwaitminigamefalltimer(var_0);
}

propwaitminigamebuttonwatch(var_0) {
  var_0 endon("finished");
  var_1 = _randomfloatrange(0.2, 0.4);

  for(;;) {
    if(isbot(var_0.player)) {
      wait(_randomfloatrange(0.05, var_1));
    } else {
      var_0.player waittill(var_0.buttonnotify);
    }

    var_0.hud_y_offset = var_0.hud_y_offset - 4.0;
  }
}

propwaitminigamefalltimer(var_0) {
  var_0 endon("finished");

  for(;;) {
    var_0.hud_y_offset = var_0.hud_y_offset + 0.5;

    if(var_0.hud_y_offset > -18) {
      var_0.hud_y_offset = -18;
    }

    waitframe();
  }
}

propwaitminigamehudsetpoint(var_0) {
  var_0._id_4F52 maps\mp\gametypes\_hud_util::setpoint("BOTTOM", "BOTTOM", var_0.hud_x_offset, var_0.hud_y_offset);
}

propwaitminigamehudinit(var_0) {
  var_1 = maps\mp\gametypes\_hud_util::_id_2829("default", 1.5, var_0.player.team);
  var_1 setplayernamestring(var_0.player);
  var_1.sort = 1;
  var_0.hud_x_offset = 0;
  var_0.hud_y_offset = -18;
  var_0._id_4F52 = var_1;
}

propminigamescore_compare(var_0, var_1) {
  var_2 = level.minigameinfo[var_0];
  var_3 = level.minigameinfo[var_1];

  if(var_2.finish && var_3.finish) {
    return var_2.finish <= var_3.finish;
  }

  if(var_2.finish) {
    return 1;
  }

  if(var_3.finish) {
    return 0;
  }

  return var_2.hud_y_offset <= var_3.hud_y_offset;
}

propminigameupdates() {
  propminigameupdateui();
  wait 0.2;
  minigameapplyplayernamesettings(1);

  if(!level.minigameinfo.size) {
    return;
  }
  var_0 = common_scripts\utility::_id_7897(getarraykeys(level.minigameinfo), ::propminigamescore_compare);

  foreach(var_7, var_2 in level.minigameinfo) {
    var_3 = 0;

    if(var_2.hud_y_offset < -18 && var_2.finish) {
      foreach(var_6, var_5 in level.minigamewinnersettings) {
        if(isDefined(var_0[var_6]) && var_7 == var_0[var_6]) {
          var_3 = 1;
          level thread propminigameupdateshowwinner(var_2, var_5);
          break;
        }
      }
    }

    if(!var_3) {
      level thread propminigameupdateshowloser(var_2);
    }
  }
}

propminigameupdateshowloser(var_0) {
  var_0._id_4F52 endon("death");
  var_1 = _abs(var_0.hud_y_offset);
  var_2 = clamp(var_1 / 500, 0.05, 1.0);
  var_0._id_4F52 maps\mp\gametypes\_hud_util::setpoint("BOTTOM", "BOTTOM", var_0.hud_x_offset, 0, var_2);
  var_0._id_4F52 fadeovertime(var_2);
  var_0.alpha = 0;
  wait(var_2);
  propwaitminigamecleanup(var_0);
}

propminigameupdateshowwinner(var_0, var_1) {
  var_0._id_4F52 endon("death");
  var_2 = 0.5;
  var_3 = 2.5;
  var_4 = 0.5;
  var_0._id_4F52 maps\mp\gametypes\_hud_util::setpoint("BOTTOM", "CENTER", 0, var_1.winyoffset, var_2);
  var_0._id_4F52 changefontscaleovertime(var_2);
  var_0._id_4F52.fontscale = var_1.winfontscale;
  var_0._id_4F52.label = &"MP_PH_EMPTY";
  wait(var_2 + var_3);
  var_0._id_4F52.alpha = 0;
  var_0._id_4F52 fadeovertime(var_4);
  propwaitminigamecleanup(var_0);
}

propminigamefinish(var_0) {
  if(var_0.finish > 0) {
    return;
  }
  if(level.minigamefinishcount >= level.minigamewinnersettings.size) {
    return;
  }
  var_0 notify("finished");
  level.minigamefinishcount++;
  var_0.finish = level.minigamefinishcount;
  var_0.hud_y_offset = -258;
  propwaitminigamehudsetpoint(var_0);
}

propminigameupdateui() {
  level endon("props_hide_over");
  level endon("mini_game_end");
  var_0 = 480;
  var_1 = -1 * var_0;
  var_2 = var_0 - var_1;

  for(;;) {
    waittillframeend;
    var_3 = level.minigameinfo.size;
    var_4 = var_2 / (var_3 + 1);
    var_5 = 0;

    foreach(var_8, var_7 in level.minigameinfo) {
      var_5++;
      var_7.hud_x_offset = var_4 * var_5 + var_1;
      propwaitminigamehudsetpoint(var_7);
    }

    foreach(var_8, var_7 in level.minigameinfo) {
      if(var_7.hud_y_offset <= -258) {
        thread propminigamefinish(var_7);
      }
    }

    minigameapplyplayernamesettings(0);

    if(level.minigamefinishcount >= level.minigamewinnersettings.size) {
      level notify("mini_game_end");
    }

    waitframe();
  }
}

minigameapplyplayernamesettings(var_0) {
  if(!level.minigameinfo.size) {
    return;
  }
  var_1 = common_scripts\utility::_id_7897(getarraykeys(level.minigameinfo), ::propminigamescore_compare);

  foreach(var_9, var_3 in level.minigameinfo) {
    var_4 = level.minigamelosersettings.color;
    var_5 = level.minigamelosersettings.label;

    if(var_3.hud_y_offset < -18) {
      foreach(var_8, var_7 in level.minigamewinnersettings) {
        if(var_0 && !var_3.finish) {
          continue;
        }
        if(isDefined(var_1[var_8]) && var_9 == var_1[var_8]) {
          var_4 = var_7.color;

          if(var_3.finish != 0) {
            var_5 = var_7.label;
          }

          break;
        }
      }
    }

    var_3._id_4F52.color = var_4;
    var_3._id_4F52.label = var_5;
  }
}

attackerinitammo() {
  var_0 = self getweaponlistprimaries();

  foreach(var_2 in var_0) {
    self givemaxammo(var_2);
  }

  var_4 = self getweaponammostock("stun_grenade_mp");
  var_4 = var_4 - self.thrownspecialcount;
  var_4 = int(max(var_4, 0));
  self setweaponammostock("stun_grenade_mp", var_4);

  if(var_4 > 0) {
    thread maps\mp\gametypes\_prop_controls::watchspecialgrenadethrow();
  }
}

attackerregenammo() {
  self endon("death");
  self endon("disconnect");
  self notify("attackerRegenAmmo");
  self endon("attackerRegenAmmo");
  level endon("game_ended");

  for(;;) {
    self waittill("reload");
    var_0 = self getcurrentprimaryweapon();
    var_1 = _weaponmaxammo(var_0);

    if(self getweaponammostock(var_0) < var_1) {
      self setweaponammostock(var_0, var_1);
    }
  }
}

checkkillrespawn() {
  self endon("disconnect");
  level endon("game_ended");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.1);

  if(self.pers["lives"] == 1) {
    self.pers["lives"]--;
    level._id_5DDB[self.team]--;
    maps\mp\gametypes\_gamelogic::_id_A11E();
    level notify("propCountChanged");
    return;
  }
}

_id_6B7B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = self;
  var_11 = 0;
  level notify("playerCountChanged");

  if(var_10.team == game["attackers"]) {
    thread respawnattacker();
  } else {
    thread _id_04C8::_id_09AA(var_10._id_18A8, var_10, var_10.team, 5.0, var_1);
  }

  if(isDefined(var_1) && isPlayer(var_1) && var_1 != var_10 && var_10.team != var_1.team) {
    var_11 = 1;
  }

  if(var_11) {
    var_1 thread maps\mp\gametypes\_hud_message::_id_9102("prop_finalblow");

    foreach(var_13 in var_10._id_1193) {
      if(var_13 == var_1) {
        var_13 playsoundtoplayer("mp_hit_kill_headshot", var_13);
        continue;
      }

      var_13 playsoundtoplayer("repulsor_fire", var_13);
    }
  }

  _luinotifyevent(&"update_sector_stats");

  foreach(var_16 in level.players) {
    if(common_scripts\utility::_id_562E(var_16.propspectating) && isDefined(var_16.spectatingthisplayer) && var_10 == var_16.spectatingthisplayer) {
      var_16 notify("endPropSpectate");
    }

    if(var_16 != var_1 && var_16.team == game["defenders"] && isalive(var_16) && var_10.team == game["defenders"]) {
      var_16 thread maps\mp\gametypes\_hud_message::_id_9102("prop_survived");
    }
  }
}

respawnattacker() {
  maps\mp\gametypes\_playerlogic::_id_50F8(self.team);
  self._id_0CA4 = 1;
  thread _id_A6E1();
}

_id_A6E1() {
  self endon("started_spawnPlayer");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    waitframe();

    if(isDefined(self) && (self.sessionstate == "spectator" || !maps\mp\_utility::isreallyalive(self))) {
      self.pers["lives"] = 1;
      maps\mp\gametypes\_playerlogic::_id_9035();
      continue;
    }

    return;
  }
}

_id_6AE2(var_0) {
  if(var_0 == game["defenders"]) {
    level thread propkilledend();
  }
}

propkilledend() {
  if(common_scripts\utility::_id_562E(level.hunterswonending)) {
    return;
  }
  if(common_scripts\utility::_id_562E(level.gameending)) {
    return;
  }
  level.hunterswonending = 1;
  var_0 = maps\mp\_utility::gettimepassed();
  game["propSurvivalTime"][game["defenders"]] = game["propSurvivalTime"][game["defenders"]] + var_0;
  game["hunterKillTime"][game["attackers"]] = game["hunterKillTime"][game["attackers"]] + var_0;
  level.gameending = 1;
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(3);
  thread ph_endgame(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
}

playdamagesoundph(var_0) {
  if(self.team == game["defenders"]) {
    return;
  }
  if(isDefined(self._id_29AB) && self._id_29AB + 5000 > var_0) {
    return;
  }
  self._id_29AB = var_0;
  var_1 = _randomintrange(1, 8);

  if(self.team == "axis") {
    if(self hasfemalecustomizationmodel()) {
      self playSound("generic_pain_enemy_fm_" + var_1);
    } else {
      self playSound("generic_pain_enemy_" + var_1);
    }
  } else if(self hasfemalecustomizationmodel())
    self playSound("generic_pain_friendly_fm_" + var_1);
  else {
    self playSound("generic_pain_friendly_" + var_1);
  }
}

playdeathsoundph() {
  var_0 = _randomintrange(1, 8);

  if(self.team == game["attackers"] && isDefined(self._id_18A8)) {
    if(self.team == "axis") {
      if(self hasfemalecustomizationmodel()) {
        var_0 = _randomintrange(1, 4);
        var_1 = _id_0380::_id_6842("generic_death_enemy_fm_" + var_0, undefined, self._id_18A8.origin);
      } else {
        var_0 = _randomintrange(1, 7);
        var_1 = _id_0380::_id_6842("generic_death_enemy_" + var_0, undefined, self._id_18A8.origin);
      }
    } else if(self hasfemalecustomizationmodel()) {
      var_0 = _randomintrange(1, 4);
      var_1 = _id_0380::_id_6842("generic_death_friendly_fm_" + var_0, undefined, self._id_18A8.origin);
    } else {
      var_0 = _randomintrange(1, 7);
      var_1 = _id_0380::_id_6842("generic_death_friendly_" + var_0, undefined, self._id_18A8.origin);
    }
  }
}

gametyperoundendscoresetomnvar(var_0, var_1, var_2, var_3, var_4) {
  if(common_scripts\utility::_id_562E(var_3) && isDefined(level.proptiebreaker)) {
    if(level.proptiebreaker == "kills") {
      self setclientomnvar("ui_round_end_reason", game["end_reason"]["prop_tiebreaker_kills"]);
      self setclientomnvar("ui_round_end_friendly_score", game["propScore"][var_4]);
      self setclientomnvar("ui_round_end_enemy_score", game["propScore"][level._id_6C63[var_4]]);
    } else if(level.proptiebreaker == "time") {
      var_5 = game["hunterKillTime"][var_4] / 1000;
      var_6 = game["hunterKillTime"][level._id_6C63[var_4]] / 1000;
      var_7 = int(_round(var_5));
      var_8 = int(_round(var_6));

      if(var_7 == var_8) {
        if(var_5 > var_6) {
          var_7++;
        } else {
          var_8++;
        }
      }

      self setclientomnvar("ui_round_end_reason", game["end_reason"]["prop_tiebreaker_time"]);
      self setclientomnvar("ui_round_end_friendly_score", var_7);
      self setclientomnvar("ui_round_end_enemy_score", var_8);
    }

    return 1;
  }

  return 0;
}

playerwatchspectate() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return("joined_spectators", "spectating_cycle", "death");

    if(var_0 == "death") {
      continue;
    }
    if(var_0 == "joined_spectators" && maps\mp\_utility::matchmakinggame()) {
      thread maps\mp\gametypes\_playerlogic::_id_8753(0);
    }

    waittillframeend;
    var_1 = self getspectatingplayer();

    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1.team == game["attackers"]) {
      self disableforcethirdpersonwhenfollowing();
      continue;
    }

    if(var_1.team == game["defenders"]) {
      self forcethirdpersonwhenfollowing();
    }
  }
}

highlighttoteamonce(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  self hudoutlinedisable();

  foreach(var_5 in level.players) {
    if(isDefined(var_2) && var_2 == var_5) {
      continue;
    }
    var_6 = var_5.sessionstate == "spectator";

    if(var_5.team == var_0 && !var_6) {
      self hudoutlineenableforclient(var_5, var_1, 1);
    }

    if(var_3 && (var_5.team == "spectator" || var_6)) {
      self hudoutlineenableforclient(var_5, var_1, 1);
    }
  }
}

highlighttoteam(var_0, var_1, var_2, var_3) {
  self notify("showToTeam");
  self endon("showToTeam");
  self endon("clear");
  self endon("death");
  self endon("maxDelete");

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  highlighttoteamonce(var_0, var_1, var_2, var_3);

  for(;;) {
    level common_scripts\utility::_id_A70A("joined_team", "joined_spectators", "spawn_after_spectator", "class_select_cancel_spectator");
    highlighttoteamonce(var_0, var_1, var_2, var_3);
  }
}

checkunscoredspawnpoint(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2.team) && var_2.team == game["defenders"]) {
      if(isDefined(var_2._id_9070) && isDefined(var_2._id_9070._id_9087) && var_2._id_9070._id_9087 == var_0) {
        return 0;
      }
    }
  }

  return 1;
}

disablespawningforplayer(var_0) {
  if(!maps\mp\_utility::gamehasstarted()) {
    return 0;
  }

  if(var_0.team == game["attackers"]) {
    return 0;
  } else if(var_0.team == game["defenders"]) {
    return !level.ingraceperiod;
  }

  return 0;
}