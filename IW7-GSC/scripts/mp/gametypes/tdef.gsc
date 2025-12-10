/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\tdef.gsc
*****************************************/

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
    level.modifyplayerdamage = ::scripts\mp\damage::gamemodemodifyplayerdamage;
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
    var_00 = game["attackers"];
    var_01 = game["defenders"];
    game["attackers"] = var_01;
    game["defenders"] = var_00;
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
  var_02[0] = level.gametype;
  var_02[1] = "tdm";
  var_02[2] = "ball";
  scripts\mp\gameobjects::main(var_02);
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
  foreach(var_01 in level.spawnpoints) {
    calculatespawndisttoballstart(var_01);
  }
}

calculatespawndisttoballstart(param_00) {
  param_00.distsqtoballstart = undefined;
  var_01 = getpathdist(param_00.origin, level.ball_starts[0].ground_origin, 1000);
  if(var_01 < 0) {
    var_01 = scripts\engine\utility::distance_2d_squared(param_00.origin, level.ball_starts[0].ground_origin);
  } else {
    var_01 = var_01 * var_01;
  }

  param_00.distsqtoballstart = var_01;
}

getspawnpoint() {
  var_00 = self.pers["team"];
  if(game["switchedsides"]) {
    var_00 = scripts\mp\utility::getotherteam(var_00);
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_01 = scripts\mp\spawnlogic::getspawnpointarray("mp_ball_spawn_" + var_00 + "_start");
    var_02 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_01);
  } else {
    var_01 = level.spawnpoints;
    var_03 = var_02;
    var_04 = [];
    var_04["ballPosition"] = level.balls[0].visuals[0].origin;
    if(isDefined(level.balls[0].carrier)) {
      var_04["activeCarrierPosition"] = level.balls[0].carrier.origin;
    } else {
      var_04["activeCarrierPosition"] = var_04["ballPosition"];
    }

    var_04["avoidBallDeadZoneDistSq"] = 1000000;
    var_02 = scripts\mp\spawnscoring::getspawnpoint(var_01, var_03, var_04);
  }

  return var_02;
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

onplayerkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = self;
  var_0B = param_01.origin;
  var_0C = 0;
  if(isDefined(param_00)) {
    var_0B = param_00.origin;
    var_0C = param_00 == param_01;
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
    if(isDefined(param_01) && isplayer(param_01) && param_01.pers["team"] != var_0A.pers["team"]) {
      if(isDefined(param_01.ball_carried) && var_0C) {
        param_01 thread scripts\mp\awards::givemidmatchaward("mode_uplink_kill_with_ball");
      } else if(isDefined(var_0A.ball_carried)) {
        param_01 thread scripts\mp\awards::givemidmatchaward("mode_uplink_kill_carrier");
        thread scripts\mp\matchdata::loginitialstats(param_09, "carrying");
        scripts\mp\gametypes\obj_ball::updatetimers("neutral", 1, 0);
      }

      if(param_01.pers["team"] == level.ball.ownerteam && param_01 != level.ball.carrier) {
        var_0D = distancesquared(level.ball.carrier.origin, var_0B);
        if(var_0D < 90000) {
          param_01 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
          param_01 scripts\mp\utility::incperstat("defends", 1);
          param_01 scripts\mp\persistence::statsetchild("round", "defends", param_01.pers["defends"]);
          param_01 scripts\mp\utility::setextrascore1(param_01.pers["defends"]);
          thread scripts\mp\matchdata::loginitialstats(param_09, "defending");
          return;
        }

        return;
      }
    }
  }
}

awardcapturepoints(param_00) {
  level endon("game_ended");
  level.ball endon("dropped");
  level.ball endon("reset");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  if(level.carrierbonusscore > 0) {
    level.ball.carrier thread carriergivescore();
  }

  var_01 = level.scoringtime;
  var_02 = level.scorepertick;
  while(!level.gameended) {
    wait(var_01);
    scripts\mp\hostmigration::waittillhostmigrationdone();
    if(!level.gameended) {
      scripts\mp\gamescore::giveteamscoreforobjective(param_00, var_02, 0);
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
      var_00 = int(gettime() - self.tdef_flagtime);
      if(var_00 / 100 / 60 < 1) {
        var_01 = 0;
      } else {
        var_01 = int(var_01 / 100 / 60);
      }

      scripts\mp\utility::incperstat("destructions", var_01);
      scripts\mp\persistence::statsetchild("round", "destructions", self.pers["destructions"]);
    }
  }
}

getrespawndelay() {
  var_00 = level.ball scripts\mp\gameobjects::getownerteam();
  if(isDefined(var_00)) {
    if(self.pers["team"] == var_00) {
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
    level waittill("connected", var_00);
    var_00._baseeffect = [];
    thread onplayerspawned(var_00);
  }
}

onplayerspawned(param_00) {
  for(;;) {
    param_00 waittill("spawned");
    level.ballbases[0] scripts\mp\gametypes\obj_ball::showballbaseeffecttoplayer(param_00);
    if(level.possessionresetcondition != 0) {
      param_00 setclientomnvar("ui_uplink_timer_hud", 0);
    }

    param_00 scripts\mp\utility::setextrascore0(0);
    if(isDefined(param_00.pers["objTime"])) {
      param_00 scripts\mp\utility::setextrascore0(param_00.pers["objTime"]);
    }

    param_00 scripts\mp\utility::setextrascore1(0);
    if(isDefined(param_00.pers["defends"])) {
      param_00 scripts\mp\utility::setextrascore1(param_00.pers["defends"]);
    }
  }
}

getsettdefsuit() {
  if(scripts\mp\utility::istrue(self.tdefsuit)) {
    if(scripts\mp\utility::_hasperk("specialty_afterburner")) {
      self goalflag(0, scripts\engine\utility::ter_op(scripts\mp\utility::isanymlgmatch(), 600, 2000));
      self goal_type(0, scripts\engine\utility::ter_op(scripts\mp\utility::isanymlgmatch(), 750, 650));
    } else {
      self goalflag(0, 400);
      self goal_type(0, 900);
    }

    self.tdefsuit = 0;
    return;
  }

  if(scripts\mp\utility::_hasperk("specialty_afterburner")) {
    self goalflag(0, 250);
    self goal_type(0, 1350);
  } else {
    self goalflag(0, 200);
    self goal_type(0, 1800);
  }

  self.tdefsuit = 1;
}

baseeffectwatchgameended() {
  level waittill("bro_shot_start");
  foreach(var_01 in level.players) {
    if(isDefined(var_01._baseeffect) && isDefined(var_01._baseeffect[0])) {
      var_01._baseeffect[0] delete();
    }
  }
}