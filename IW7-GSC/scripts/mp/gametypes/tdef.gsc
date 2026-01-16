/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\tdef.gsc
*********************************************/

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    scripts\mp\utility::registertimelimitdvar(level.gametype, 10);
    scripts\mp\utility::registerscorelimitdvar(level.gametype, 7500);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 1);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 1);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
    setdynamicdvar("scr_tdef_possessionResetCondition", 1);
    setdynamicdvar("scr_tdef_possessionResetTime", 60);
    level.matchrules_enemyflagradar = 1;
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  level.carrierarmor = 100;
  level.satellitecount = 1;
  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.onrespawndelay = ::getrespawndelay;
  level.ballreset = 1;
  level.ball_starts = [];
  level.balls = [];
  level.ballbases = [];
  level.scorefrozenuntil = 0;
  level.ballpickupscorefrozen = 0;
  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "team_defender";
  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";
  game["dialog"]["drone_reset"] = "defender_obj_respawned";
  game["dialog"]["ally_own_drone"] = "tdef_ally_own_drone";
  game["dialog"]["enemy_own_drone"] = "tdef_enemy_own_drone";
  game["dialog"]["ally_throw_score"] = "ally_throw_score";
  game["dialog"]["ally_carry_score"] = "ally_carry_score";
  game["dialog"]["enemy_throw_score"] = "enemy_throw_score";
  game["dialog"]["enemy_carry_score"] = "enemy_carry_score";
  game["dialog"]["pass_complete"] = "friendly_pass";
  game["dialog"]["pass_intercepted"] = "tdef_pass_intercepted";
  game["dialog"]["ally_drop_drone"] = "tdef_ally_drop_drone";
  game["dialog"]["enemy_drop_drone"] = "tdef_enemy_drop_drone";
  game["dialog"]["drone_reset_soon"] = "team_defender_reset";
  game["bomb_dropped_sound"] = "mp_uplink_ball_pickedup_enemy";
  game["bomb_recovered_sound"] = "mp_uplink_ball_pickedup_friendly";
  game["dialog"]["offense_obj"] = "capture_obj";
  game["dialog"]["defense_obj"] = "capture_obj";
  thread onplayerconnect();
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  setdynamicdvar("scr_tdef_scoringTime", getmatchrulesdata("tdefData", "scoringTime"));
  setdynamicdvar("scr_tdef_scorePerTick", getmatchrulesdata("tdefData", "scorePerTick"));
  setdynamicdvar("scr_tdef_carrierBonusTime", getmatchrulesdata("tdefData", "carrierBonusTime"));
  setdynamicdvar("scr_tdef_carrierBonusScore", getmatchrulesdata("tdefData", "carrierBonusScore"));
  setdynamicdvar("scr_tdef_delayplayer", getmatchrulesdata("tdefData", "delayPlayer"));
  setdynamicdvar("scr_tdef_spawndelay", getmatchrulesdata("tdefData", "spawnDelay"));
  setdynamicdvar("scr_tdef_ballActivationDelay", getmatchrulesdata("tdefData", "ballActivationDelay"));
  setdynamicdvar("scr_tdef_possessionResetCondition", getmatchrulesdata("ballCommonData", "possessionResetCondition"));
  setdynamicdvar("scr_tdef_possessionResetTime", getmatchrulesdata("ballCommonData", "possessionResetTime"));
  setdynamicdvar("scr_tdef_idleResetTime", getmatchrulesdata("ballCommonData", "idleResetTime"));
  setdynamicdvar("scr_tdef_explodeOnExpire", getmatchrulesdata("ballCommonData", "explodeOnExpire"));
  setdynamicdvar("scr_tdef_armorMod", getmatchrulesdata("ballCommonData", "armorMod"));
  setdynamicdvar("scr_tdef_showEnemyCarrier", getmatchrulesdata("ballCommonData", "showEnemyCarrier"));
  setdynamicdvar("scr_tdef_halftime", 0);
  scripts\mp\utility::registerhalftimedvar("tdef", 0);
  setdynamicdvar("scr_tdef_promode", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  scripts\mp\utility::setobjectivetext("allies", &"OBJECTIVES_TDEF");
  scripts\mp\utility::setobjectivetext("axis", &"OBJECTIVES_TDEF");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_TDEF");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_TDEF");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_TDEF_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_TDEF_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", &"OBJECTIVES_TDEF_ATTACKER_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", &"OBJECTIVES_TDEF_ATTACKER_HINT");
  createfx();
  scripts\mp\gametypes\obj_ball::ball_default_origins();
  scripts\mp\gametypes\obj_ball::ball_init_map_min_max();
  scripts\mp\gametypes\obj_ball::ball_create_ball_starts();
  scripts\mp\gametypes\obj_ball::ball_spawn(0);
  thread scripts\mp\gametypes\obj_ball::hideballsongameended();
  thread baseeffectwatchgameended();
  initspawns();
  var_2[0] = level.gametype;
  var_2[1] = "tdm";
  var_2[2] = "ball";
  scripts\mp\gameobjects::main(var_2);
  tdef();
  if(level.possessionresetcondition != 0) {
    scripts\mp\gametypes\obj_ball::initballtimer();
  }
}

updategametypedvars() {
  scripts\mp\gametypes\common::updategametypedvars();
  level.scoringtime = scripts\mp\utility::dvarfloatvalue("scoringTime", 1, 1, 10);
  level.scorepertick = scripts\mp\utility::dvarintvalue("scorePerTick", 1, 1, 25);
  level.carrierbonustime = scripts\mp\utility::dvarfloatvalue("carrierBonusTime", 4, 0, 10);
  level.carrierbonusscore = scripts\mp\utility::dvarintvalue("carrierBonusScore", 25, 0, 250);
  level.delayplayer = scripts\mp\utility::dvarintvalue("delayPlayer", 1, 0, 1);
  level.spawndelay = scripts\mp\utility::dvarfloatvalue("spawnDelay", 2.5, 0, 30);
  level.ballactivationdelay = scripts\mp\utility::dvarfloatvalue("ballActivationDelay", 10, 0, 30);
  level.possessionresetcondition = scripts\mp\utility::dvarintvalue("possessionResetCondition", 0, 0, 2);
  level.possessionresettime = scripts\mp\utility::dvarfloatvalue("possessionResetTime", 0, 0, 150);
  level.explodeonexpire = scripts\mp\utility::dvarintvalue("explodeOnExpire", 0, 0, 1);
  level.idleresettime = scripts\mp\utility::dvarfloatvalue("idleResetTime", 15, 0, 60);
  level.armormod = scripts\mp\utility::dvarfloatvalue("armorMod", 1, 0, 2);
  level.showenemycarrier = scripts\mp\utility::dvarintvalue("showEnemyCarrier", 5, 0, 6);
  level.carrierarmor = int(level.carrierarmor * level.armormod);
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("TDef");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_ball_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_ball_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  foreach(var_1 in level.spawnpoints) {
    calculatespawndisttoballstart(var_1);
  }
}

calculatespawndisttoballstart(var_0) {
  var_0.distsqtoballstart = undefined;
  var_1 = getpathdist(var_0.origin, level.ball_starts[0].ground_origin, 1000);
  if(var_1 < 0) {
    var_1 = scripts\engine\utility::distance_2d_squared(var_0.origin, level.ball_starts[0].ground_origin);
  } else {
    var_1 = var_1 * var_1;
  }

  var_0.distsqtoballstart = var_1;
}

getspawnpoint() {
  var_0 = self.pers["team"];
  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility::getotherteam(var_0);
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_ball_spawn_" + var_0 + "_start");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else {
    var_1 = level.spawnpoints;
    var_3 = var_2;
    var_4 = [];
    var_4["ballPosition"] = level.balls[0].visuals[0].origin;
    if(isDefined(level.balls[0].carrier)) {
      var_4["activeCarrierPosition"] = level.balls[0].carrier.origin;
    } else {
      var_4["activeCarrierPosition"] = var_4["ballPosition"];
    }

    var_4["avoidBallDeadZoneDistSq"] = 1000000;
    var_2 = scripts\mp\spawnscoring::getspawnpoint(var_1, var_3, var_4);
  }

  return var_2;
}

createfx() {
  level._effect["ball_trail"] = loadfx("vfx\core\mp\core\vfx_uplink_ball_trail.vfx");
  level._effect["ball_idle"] = loadfx("vfx\core\mp\core\vfx_uplink_ball_idle_tdef.vfx");
  level._effect["ball_download"] = loadfx("vfx\core\mp\core\vfx_uplink_ball_download.vfx");
  level._effect["ball_download_end"] = loadfx("vfx\core\mp\core\vfx_uplink_ball_download_end_tdef.vfx");
  level._effect["ball_teleport"] = loadfx("vfx\core\mp\core\vfx_uplink_ball_teleport.vfx");
  level._effect["ball_base_glow"] = loadfx("vfx\core\mp\core\vfx_uplink_base_glow.vfx");
}

tdef() {
  level.iconescort3d = "waypoint_blitz_defend_round";
  level.iconescort2d = "waypoint_blitz_defend_round";
  level.iconkill3d = "waypoint_capture_kill_round";
  level.iconkill2d = "waypoint_capture_kill_round";
  level.iconcaptureflag3d = "waypoint_capture_take";
  level.iconcaptureflag2d = "waypoint_capture_take";
  scripts\mp\utility::func_98D3();
  level.ball = level.balls[0];
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = self;
  var_11 = var_1.origin;
  var_12 = 0;
  if(isDefined(var_0)) {
    var_11 = var_0.origin;
    var_12 = var_0 == var_1;
  }

  if(isDefined(self.carryobject) && isDefined(self.carryobject.passtargetoutlineid) && isDefined(self.carryobject.passtargetent)) {
    scripts\mp\utility::outlinedisable(self.carryobject.passtargetoutlineid, self.carryobject.passtargetent);
    self.carryobject.passtargetoutlineid = undefined;
    self.carryobject.passtargetent = undefined;
  }

  if(isDefined(self.carryobject) && isDefined(self.carryobject.playeroutlineid) && isDefined(self.carryobject.playeroutlined)) {
    scripts\mp\utility::outlinedisable(self.carryobject.playeroutlineid, self.carryobject.playeroutlined);
    self.carryobject.playeroutlineid = undefined;
    self.carryobject.playeroutlined = undefined;
  }

  if(isDefined(level.ball.carrier)) {
    if(isDefined(var_1) && isplayer(var_1) && var_1.pers["team"] != var_10.pers["team"]) {
      if(isDefined(var_1.ball_carried) && var_12) {
        var_1 thread scripts\mp\awards::givemidmatchaward("mode_uplink_kill_with_ball");
      } else if(isDefined(var_10.ball_carried)) {
        var_1 thread scripts\mp\awards::givemidmatchaward("mode_uplink_kill_carrier");
        thread scripts\mp\matchdata::loginitialstats(var_9, "carrying");
        scripts\mp\gametypes\obj_ball::updatetimers("neutral", 1, 0);
      }

      if(var_1.pers["team"] == level.ball.ownerteam && var_1 != level.ball.carrier) {
        var_13 = distancesquared(level.ball.carrier.origin, var_11);
        if(var_13 < 90000) {
          var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
          var_1 scripts\mp\utility::incperstat("defends", 1);
          var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
          var_1 scripts\mp\utility::setextrascore1(var_1.pers["defends"]);
          thread scripts\mp\matchdata::loginitialstats(var_9, "defending");
          return;
        }

        return;
      }
    }
  }
}

awardcapturepoints(var_0) {
  level endon("game_ended");
  level.ball endon("dropped");
  level.ball endon("reset");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  if(level.carrierbonusscore > 0) {
    level.ball.carrier thread carriergivescore();
  }

  var_1 = level.scoringtime;
  var_2 = level.scorepertick;
  while(!level.gameended) {
    wait(var_1);
    scripts\mp\hostmigration::waittillhostmigrationdone();
    if(!level.gameended) {
      scripts\mp\gamescore::giveteamscoreforobjective(var_0, var_2, 0);
      level.ball.carrier scripts\mp\utility::incperstat("objTime", 1);
      level.ball.carrier scripts\mp\persistence::statsetchild("round", "objTime", level.ball.carrier.pers["objTime"]);
      level.ball.carrier scripts\mp\utility::setextrascore0(level.ball.carrier.pers["objTime"]);
      level.ball.carrier scripts\mp\gamescore::giveplayerscore("tdef_hold_obj", 10);
    }
  }
}

carriergivescore() {
  level endon("game_ended");
  self endon("death");
  level.ball endon("dropped");
  level.ball endon("reset");
  for(;;) {
    wait(level.carrierbonustime);
    thread scripts\mp\utility::giveunifiedpoints("ball_carry", undefined, level.carrierbonusscore);
  }
}

watchforendgame() {
  self endon("dropped_flag");
  self endon("disconnect");
  level waittill("game_ended");
  if(isDefined(self)) {
    if(isDefined(self.tdef_flagtime)) {
      var_0 = int(gettime() - self.tdef_flagtime);
      if(var_0 / 100 / 60 < 1) {
        var_1 = 0;
      } else {
        var_1 = int(var_1 / 100 / 60);
      }

      scripts\mp\utility::incperstat("destructions", var_1);
      scripts\mp\persistence::statsetchild("round", "destructions", self.pers["destructions"]);
    }
  }
}

getrespawndelay() {
  var_0 = level.ball scripts\mp\gameobjects::getownerteam();
  if(isDefined(var_0)) {
    if(self.pers["team"] == var_0) {
      if(!level.spawndelay) {
        return undefined;
      }

      if(level.delayplayer) {
        return level.spawndelay;
      }
    }
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._baseeffect = [];
    thread onplayerspawned(var_0);
  }
}

onplayerspawned(var_0) {
  for(;;) {
    var_0 waittill("spawned");
    level.ballbases[0] scripts\mp\gametypes\obj_ball::showballbaseeffecttoplayer(var_0);
    if(level.possessionresetcondition != 0) {
      var_0 setclientomnvar("ui_uplink_timer_hud", 0);
    }

    var_0 scripts\mp\utility::setextrascore0(0);
    if(isDefined(var_0.pers["objTime"])) {
      var_0 scripts\mp\utility::setextrascore0(var_0.pers["objTime"]);
    }

    var_0 scripts\mp\utility::setextrascore1(0);
    if(isDefined(var_0.pers["defends"])) {
      var_0 scripts\mp\utility::setextrascore1(var_0.pers["defends"]);
    }
  }
}

getsettdefsuit() {
  if(scripts\mp\utility::istrue(self.tdefsuit)) {
    if(scripts\mp\utility::_hasperk("specialty_afterburner")) {
      self energy_setrestorerate(0, scripts\engine\utility::ter_op(scripts\mp\utility::isanymlgmatch(), 600, 2000));
      self energy_setresttimems(0, scripts\engine\utility::ter_op(scripts\mp\utility::isanymlgmatch(), 750, 650));
    } else {
      self energy_setrestorerate(0, 400);
      self energy_setresttimems(0, 900);
    }

    self.tdefsuit = 0;
    return;
  }

  if(scripts\mp\utility::_hasperk("specialty_afterburner")) {
    self energy_setrestorerate(0, 250);
    self energy_setresttimems(0, 1350);
  } else {
    self energy_setrestorerate(0, 200);
    self energy_setresttimems(0, 1800);
  }

  self.tdefsuit = 1;
}

baseeffectwatchgameended() {
  level waittill("bro_shot_start");
  foreach(var_1 in level.players) {
    if(isDefined(var_1._baseeffect) && isDefined(var_1._baseeffect[0])) {
      var_1._baseeffect[0] delete();
    }
  }
}