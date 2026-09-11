/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\ball.gsc
***********************************************/

function main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_ball_scoreCarry", getmatchrulesdata("ballData", "scoreCarry"));
  setdynamicdvar("scr_ball_scoreThrow", getmatchrulesdata("ballData", "scoreThrow"));
  setdynamicdvar("scr_ball_satelliteCount", getmatchrulesdata("ballData", "satelliteCount"));
  setdynamicdvar("scr_ball_practiceMode", getmatchrulesdata("ballData", "practiceMode"));
  setdynamicdvar("scr_ball_possessionResetCondition", getmatchrulesdata("ballCommonData", "possessionResetCondition"));
  setdynamicdvar("scr_ball_possessionResetTime", getmatchrulesdata("ballCommonData", "possessionResetTime"));
  setdynamicdvar("scr_ball_showEnemyCarrier", getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar("scr_ball_idleResetTime", getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar("scr_ball_promode", 0);
}

function onprecachegametype() {}

function onstartgametype() {
  var_0 = scripts\mp\utility\game::inovertime();
  var_1 = game["overtimeRoundsPlayed"] == 0;
  var_2 = scripts\mp\utility\game::istimetobeatvalid();

  if(var_0) {
    if(var_1) {
      setomnvar("ui_round_hint_override_attackers", 1);
      setomnvar("ui_round_hint_override_defenders", 1);
    } else if(var_2) {
      setomnvar("ui_round_hint_override_attackers", scripts\engine\utility::ter_op(game["timeToBeatTeam"] == game["attackers"], 2, 3));
      setomnvar("ui_round_hint_override_defenders", scripts\engine\utility::ter_op(game["timeToBeatTeam"] == game["defenders"], 2, 3));
    } else {
      setomnvar("ui_round_hint_override_attackers", 4);
      setomnvar("ui_round_hint_override_defenders", 4);
    }
  }

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_3 = game["attackers"];
    var_4 = game["defenders"];
    game["attackers"] = var_4;
    game["defenders"] = var_3;
  }

  foreach(var_6 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_6, &"OBJECTIVES/BALL");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_6, &"OBJECTIVES/BALL");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_6, &"OBJECTIVES/BALL_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_6, &"OBJECTIVES/BALL_HINT");
  }

  setclientnamemode("auto_change");
  scripts\mp\gametypes\obj_ball::ball_default_origins();
  thread run_ball();

  if(level.possessionresetcondition != 0) {
    scripts\mp\gametypes\obj_ball::initballtimer();
    return;
  }
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.scorecarry = scripts\mp\utility\dvars::dvarintvalue("scoreCarry", 2, 1, 9);
  level.scorethrow = scripts\mp\utility\dvars::dvarintvalue("scoreThrow", 1, 1, 9);
  level.satellitecount = scripts\mp\utility\dvars::dvarintvalue("satelliteCount", 1, 1, 5);
  level.practicemode = scripts\mp\utility\dvars::dvarintvalue("practiceMode", 0, 0, 1);
  level.possessionresetcondition = scripts\mp\utility\dvars::dvarintvalue("possessionResetCondition", 0, 0, 2);
  level.possessionresettime = scripts\mp\utility\dvars::dvarfloatvalue("possessionResetTime", 0, 0, 150);
  level.idleresettime = scripts\mp\utility\dvars::dvarfloatvalue("idleResetTime", 15, 0, 60);
  level.showenemycarrier = scripts\mp\utility\dvars::dvarintvalue("showEnemyCarrier", 5, 0, 6);
}

function ball_goal_useobject() {
  foreach(var_1 in level.ball_goals) {
    var_1.trigger = spawn("trigger_radius", var_1.origin - (0, 0, var_1.radius), 0, var_1.radius, var_1.radius * 2);
    var_1.useobject = scripts\mp\gameobjects::createuseobject(var_2, var_1.trigger, [], (0, 0, var_1.radius * 2.1));
    var_1.useobject.goal = var_1;
    var_1.useobject scripts\mp\gameobjects::setobjectivestatusicons("waypoint_blitz_defend", "waypoint_blitz_goal");
    var_1.useobject scripts\mp\gameobjects::setvisibleteam("any");
    var_1.useobject scripts\mp\gameobjects::allowuse("enemy");
    var_1.useobject scripts\mp\gameobjects::setkeyobject(level.balls);
    var_1.useobject scripts\mp\gameobjects::setusetime(0);
    var_1.useobject scripts\mp\gameobjects::cancontestclaim(1);
    var_1.useobject.onuse = &ball_carrier_touched_goal;
    var_1.useobject.canuseobject = &ball_goal_can_use;
    var_1.useobject.oncontested = &ball_goal_contested;
    var_1.useobject.onuncontested = &ball_goal_uncontested;
    var_1.killcament = spawn("script_model", var_1.origin + (0, 0, 20));
    var_1.killcament setscriptmoverkillcam("explosive");
  }
}

function ball_get_path_dist(var_0, var_1) {
  if(scripts\mp\spawnlogic::ispathdataavailable()) {
    var_2 = getpathdist(var_0, var_1, 999999);

    if(isDefined(var_2) && var_2 >= 0) {
      return var_2;
    }
  }

  return distance(var_0, var_1);
}

function ball_goal_fx() {
  foreach(var_1 in level.ball_goals) {
    var_1.score_fx["friendly"] = spawnfx(scripts\engine\utility::getfx("ball_goal_activated_friendly"), var_1.origin, (1, 0, 0));
    var_1.score_fx["enemy"] = spawnfx(scripts\engine\utility::getfx("ball_goal_activated_enemy"), var_1.origin, (1, 0, 0));
  }

  thread ball_play_fx_joined_team();

  foreach(var_4 in level.players) {
    ball_goal_fx_for_player(var_4);
  }

  thread goal_watch_game_ended();
}

function onplayerconnect(var_0) {
  level endon("game_ended");
  thread onplayerspawned(var_0);

  if(istrue(level.practicemode) && var_0 ishost()) {
    var_0 thread scripts\mp\gametypes\obj_ball::practicenotify();
    var_0 thread scripts\mp\gametypes\obj_ball::moveballtoplayer();
    return;
  }
}

function onplayerspawned(var_0) {
  var_0 waittill("spawned");
  var_0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var_0.pers["touchdowns"])) {
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["touchdowns"]);
  }

  var_0 scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(var_0.pers["fieldgoals"])) {
    var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["fieldgoals"]);
    return;
  }
}

function initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("Uplink", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_ball_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_ball_spawn_axis_start");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  var_0 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  var_1 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype + "_secondary");
  var_2 = assignteamspawns(var_0);
  var_3 = assignteamspawns(var_1);
  scripts\mp\spawnlogic::registerspawnpoints("allies", var_2["allies"]);
  scripts\mp\spawnlogic::registerspawnpoints("allies", var_3["allies"], 1);
  scripts\mp\spawnlogic::registerspawnpoints("axis", var_2["axis"]);
  scripts\mp\spawnlogic::registerspawnpoints("axis", var_3["axis"], 1);
}

function assignteamspawns(var_0) {
  var_1 = [];
  GscBinSkip0(0x2e, "allies", []);
}

function getspawnpointdist(var_0, var_1) {
  var_2 = getpathdist(var_0.origin, var_1, 16000);

  if(var_2 < 0) {
    var_2 = distance(var_0.origin, var_1);
  }

  return var_2;
}

function getspawnpoint() {
  var_0 = self.pers["team"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(game["switchedsides"]) {
      var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];
    }

    var_1 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype + "_" + var_0 + "_start");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else {
    var_1 = scripts\mp\spawnlogic::getteamspawnpoints(var_2);
    var_3 = scripts\mp\spawnlogic::getteamfallbackspawnpoints(var_2);
    var_4 = [];
    GscBinSkip1(0x45, "homeBaseTeam", var_2);
  }

  return var_4;
}

function run_ball() {
  level.ball_starts = [];
  level.balls = [];
  level.ballbases = [];
  ball_create_team_goal("allies");
  ball_create_team_goal("axis");
  thread ball_connect_watch();
  scripts\mp\gametypes\obj_ball::ball_init_map_min_max();
  scripts\mp\gametypes\obj_ball::ball_create_ball_starts();

  for(var_0 = 0; var_0 < level.satellitecount; var_0++) {
    scripts\mp\gametypes\obj_ball::ball_spawn(var_0);
  }

  ball_goal_useobject();
  ball_goal_fx();
  initspawns();
  thread removeuplinkgoal();
  thread placeuplinkgoal();
  level.ball = level.balls[0];
}

function ball_find_ground(var_0) {
  var_1 = self.origin + (0, 0, 32);
  var_2 = self.origin + (0, 0, -1000);
  var_3 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_4 = [];
  var_5 = scripts\engine\trace::ray_trace(var_1, var_2, var_4, var_3);
  self.ground_origin = var_5["position"];
  return var_5["fraction"] != 0 && var_5["fraction"] != 1;
}

function ball_create_team_goal(var_0) {
  var_1 = var_0;

  if(game["switchedsides"]) {
    var_1 = scripts\mp\utility\game::getotherteam(var_1)[0];
  }

  var_2 = scripts\engine\utility::getStruct("ball_goal_" + var_1, "targetname");

  if(isDefined(var_2)) {
    var_2 = checkpostshipgoalplacement(var_2, var_0);
    ball_find_ground(var_2);
  } else {
    var_2 = spawnStruct();

    switch (level.script) {
      default:
        break;
    }

    if(!isDefined(var_2.origin)) {
      var_2.origin = level.default_goal_origins[var_0];
    }

    ball_find_ground(var_2);
  }

  if(istrue(scripts\cp_mp\utility\game_utility::isrealismenabled())) {
    var_2.origin = var_2.ground_origin + (0, 0, 130);
  } else {
    var_2.origin = var_2.ground_origin + (0, 0, 130);
  }

  var_2.radius = 60;
  var_2.team = var_0;
  var_2.ball_in_goal = 0;
  var_2.highestspawndistratio = 0;
  level.ball_goals[var_0] = var_2;
}

function checkpostshipgoalplacement(var_0, var_1) {
  if(level.mapname == "mp_metropolis") {
    if(!game["switchedsides"] && var_1 == "axis") {
      var_0.origin = (-2039, -1464, 123);
    } else if(game["switchedsides"] && var_1 == "allies") {
      var_0.origin = (-2039, -1464, 123);
    }
  }

  if(level.mapname == "mp_fallen") {
    if(!game["switchedsides"] && var_1 == "axis") {
      var_0.origin = (2752, 1429, 988);
    } else if(game["switchedsides"] && var_1 == "allies") {
      var_0.origin = (2752, 1429, 988);
    }

    if(!game["switchedsides"] && var_1 == "allies") {
      var_0.origin = (-1866, 1698, 988);
    } else if(game["switchedsides"] && var_1 == "axis") {
      var_0.origin = (-1866, 1698, 988);
    }
  }

  return var_0;
}

function ball_connect_watch() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread scripts\mp\gametypes\obj_ball::ball_player_on_connect();
  }
}

function ball_physics_touch_goal() {
  var_0 = self.visuals[0];
  self endon("pass_end");
  self endon("pickup_object");
  self endon("physics_finished");

  if(scripts\mp\utility\game::getgametype() != "tdef") {
    ball_touch_goal_watch(var_0);
    return;
  }
}

function ball_pass_touch_goal() {
  var_0 = self.visuals[0];
  self endon("pass_end");

  if(scripts\mp\utility\game::getgametype() != "tdef") {
    ball_touch_goal_watch(var_0);
    return;
  }
}

function ball_touch_goal_watch(var_0) {
  self endon("pass_end");
  self endon("pickup_object");
  self endon("physics_finished");

  for(;;) {
    foreach(var_2 in level.ball_goals) {
      if(self.lastcarrierteam == var_5) {
        continue;
      }

      if(!ball_goal_can_use(var_2.useobject)) {
        continue;
      }

      var_3 = distance(var_0.origin, var_2.origin);

      if(var_3 <= var_2.radius) {
        thread ball_touched_goal(var_2);
        var_0 notify("pass_end");
        return;
      }

      if(isDefined(var_0.origin_prev)) {
        var_4 = line_interect_sphere(var_0.origin_prev, var_0.origin, var_2.origin, var_2.radius);

        if(var_4) {
          thread ball_touched_goal(var_2);
          var_0 notify("pass_end");
          return;
        }
      }
    }

    waitframe();
  }
}

function ball_goal_can_use(var_0) {
  var_1 = self.goal;

  if(var_1.ball_in_goal) {
    return false;
  }

  return true;
}

function ball_goal_contested() {
  ball_waypoint_contest();
}

function ball_goal_uncontested(var_0) {
  goal_waypoint();
}

function ball_carrier_touched_goal(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.carryobject)) {
    return;
  }

  if(isDefined(level.scorefrozenuntil) && level.scorefrozenuntil > gettime()) {
    return;
  }

  if(istimeup()) {
    return;
  }

  if(level.gameended) {
    return;
  }

  var_0 notify("goal_scored");
  var_1 = level.scorecarry;
  var_0 thread scripts\mp\awards::givemidmatchaward("mode_uplink_dunk");
  ball_check_assist(var_0, 1);
  var_0 scripts\mp\utility\stats::incpersstat("touchdowns", 1);
  var_0 scripts\mp\persistence::statsetchild("round", "touchdowns", var_0.pers["touchdowns"]);

  if(isPlayer(var_0)) {
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["touchdowns"]);
    var_0 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "dunk", var_0.origin);
  }

  var_2 = self.goal.team;
  var_3 = scripts\mp\utility\game::getotherteam(var_2)[0];
  scripts\mp\utility\dialog::statusdialog("enemy_carry_score", var_2, 1);
  scripts\mp\utility\dialog::statusdialog("ally_carry_score", var_3, 1);
  ball_play_score_fx(self.goal);
  ball_score_sound(var_3, 1);
  var_4 = var_0.carryobject;
  var_4.lastcarrierscored = 1;
  var_4 scripts\mp\gametypes\obj_ball::ball_set_dropped(1, self.trigger.origin, 1);
  thread ball_score_event(var_4);
  ball_give_score(var_3, var_1);
}

function should_record_final_score_cam(var_0, var_1) {
  var_2 = scripts\mp\gamescore::_getteamscore(var_0);
  var_3 = scripts\mp\gamescore::_getteamscore(scripts\mp\utility\game::getotherteam(var_0)[0]);
  return var_2 + var_1 >= var_3;
}

function line_interect_sphere(var_0, var_1, var_2, var_3) {
  var_4 = vectorNormalize(var_1 - var_0);
  var_5 = vectordot(var_4, var_0 - var_2);
  var_5 *= var_5;
  var_6 = var_0 - var_2;
  var_6 *= var_6;
  var_7 = var_3 * var_3;
  return var_5 - var_6 + var_7 >= 0;
}

function ball_touched_goal(var_0) {
  if(isDefined(level.scorefrozenuntil) && level.scorefrozenuntil > gettime()) {
    return;
  }

  if(istimeup()) {
    return;
  }

  if(level.gameended) {
    return;
  }

  ball_play_score_fx(var_0);
  var_1 = level.scorethrow;
  var_2 = var_0.team;
  var_3 = scripts\mp\utility\game::getotherteam(var_2)[0];
  scripts\mp\utility\dialog::statusdialog("enemy_throw_score", var_2, 1);
  scripts\mp\utility\dialog::statusdialog("ally_throw_score", var_3, 1);

  if(isDefined(self.lastcarrier)) {
    self.lastcarrierscored = 1;
    self.lastcarrier thread scripts\mp\awards::givemidmatchaward("mode_uplink_fieldgoal");
    ball_check_assist(self.lastcarrier, 0);
    self.lastcarrier scripts\mp\utility\stats::incpersstat("fieldgoals", 1);
    self.lastcarrier scripts\mp\persistence::statsetchild("round", "fieldgoals", self.lastcarrier.pers["fieldgoals"]);

    if(isPlayer(self.lastcarrier)) {
      self.lastcarrier scripts\mp\utility\stats::setextrascore1(self.lastcarrier.pers["fieldgoals"]);
      self.lastcarrier thread scripts\common\utility::ref_13e0a(level.ref_11b29, "fieldgoal", self.lastcarrier.origin);
    }
  }

  if(isDefined(self.killcament)) {
    self.killcament unlink();
  }

  ball_score_sound(var_3, 0);
  thread ball_score_event(var_0);
  ball_give_score(var_3, var_1);
}

function istimeup() {
  var_0 = scripts\mp\utility\dvars::getwatcheddvar("timelimit");

  if(var_0 != 0) {
    var_1 = scripts\mp\gamelogic::gettimeremaining();

    if(var_1 <= 0) {
      return true;
    }
  }

  return false;
}

function ball_give_score(var_0, var_1) {
  level scripts\mp\gamescore::giveteamscoreforobjective(var_0, var_1, 0);
}

function ball_score_event(var_0) {
  thread scorefrozentimer();
  self notify("score_event");

  if(istrue(level.practicemode)) {
    foreach(var_2 in level.players) {
      if(var_2 ishost()) {
        var_2 thread scripts\mp\gametypes\obj_ball::moveballtoplayer();
        break;
      }
    }
  }

  self.in_goal = 1;
  var_0.ball_in_goal = 1;
  var_4 = self.visuals[0];

  if(isDefined(self.projectile)) {
    self.projectile delete();
  }

  var_4 physicslaunchserver(var_4.origin, (0, 0, 0));
  var_4 physicsstopserver();
  scripts\mp\gameobjects::allowcarry("none");
  scripts\mp\gametypes\obj_ball::ball_waypoint_upload();
  var_5 = 0.4;
  var_6 = 1.2;
  var_7 = 1;
  var_8 = var_5 + var_7;
  var_9 = var_8 + var_6;
  var_4 moveTo(var_0.origin, var_5, 0, var_5);
  var_4 rotatevelocity((1080, 1080, 0), var_9, var_9, 0);
  wait var_8;
  var_4 movez(4000, var_6, var_6 * 0.1, 0);
  wait var_6;
  var_0.ball_in_goal = 0;
  scripts\mp\gametypes\obj_ball::ball_return_home(0, 0);
}

function ball_check_assist(var_0, var_1) {
  if(!isDefined(var_0.passtime) || !isDefined(var_0.passplayer)) {
    return;
  }

  if(var_0.passtime + 3000 < gettime()) {
    return;
  }

  if(var_1) {
    var_0.passplayer thread scripts\mp\awards::givemidmatchaward("mode_uplink_allyoop");
    return;
  }
}

function ball_play_score_fx(var_0) {
  var_0.score_fx["friendly"] hide();
  var_0.score_fx["enemy"] hide();

  foreach(var_2 in level.players) {
    var_3 = ball_get_view_team(var_2);

    if(var_3 == var_0.team) {
      var_0.score_fx["friendly"] showtoplayer(var_2);
      continue;
    }

    var_0.score_fx["enemy"] showtoplayer(var_2);
  }

  triggerfx(var_0.score_fx["friendly"]);
  triggerfx(var_0.score_fx["enemy"]);
}

function ball_waypoint_reset() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_reset_marker", "waypoint_reset_marker");
}

function ball_waypoint_contest() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_uplink_contested", "waypoint_uplink_contested");
}

function goal_waypoint() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_blitz_defend", "waypoint_blitz_goal");
}

function ball_score_sound(var_0, var_1) {
  if(var_1) {
    scripts\mp\gametypes\obj_ball::ball_play_local_team_sound(var_0, "mp_uplink_goal_carried_friendly", "mp_uplink_goal_carried_enemy");
    return;
  }

  scripts\mp\gametypes\obj_ball::ball_play_local_team_sound(var_0, "mp_uplink_goal_friendly", "mp_uplink_goal_enemy");
}

function scorefrozentimer() {
  level endon("game_ended");
  level.scorefrozenuntil = gettime() + 10000;

  foreach(var_1 in level.ball_goals) {
    thread dogoalreset();
  }
}

function dogoalreset() {
  ball_waypoint_reset(self.useobject);
  level scripts\engine\utility::ref_143b9(10, "goal_ready");
  goal_waypoint(self.useobject);
}

function ball_on_connect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.ball_goal_fx = [];
    thread player_on_disconnect();
  }
}

function player_on_disconnect() {
  self waittill("disconnect");
  player_delete_ball_goal_fx();
}

function ball_goal_fx_for_player(var_0) {
  var_1 = ball_get_view_team(var_0);
  player_delete_ball_goal_fx(var_0);

  foreach(var_3 in level.ball_goals) {
    var_4 = scripts\engine\utility::ter_op(var_6 == var_1, "ball_goal_friendly", "ball_goal_enemy");
    var_5 = spawnfxforclient(scripts\engine\utility::getfx(var_4), var_3.origin, var_0, (1, 0, 0));
    var_5 setfxkilldefondelete();
    var_0.ball_goal_fx[var_4] = var_5;
    triggerfx(var_5);
  }
}

function ball_get_view_team(var_0) {
  var_1 = var_0.team;

  if(var_1 != "allies" && var_1 != "axis") {
    if(var_0 ismlgspectator()) {
      var_1 = var_0 getmlgspectatorteam();
    } else {
      var_1 = "allies";
    }
  }

  return var_1;
}

function player_delete_ball_goal_fx() {
  if(isDefined(self.ball_goal_fx)) {
    foreach(var_1 in self.ball_goal_fx) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }

    return;
  }
}

function goal_watch_game_ended() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    player_delete_ball_goal_fx(var_1);
  }
}

function ball_play_fx_joined_team() {}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = self;
  var_11 = 0;

  if(!isDefined(var_1) || !isDefined(var_1.team) || !isDefined(var_10) || !isDefined(var_10.team)) {
    return;
  }

  if(var_1 == var_10) {
    return;
  }

  if(var_1.team == var_10.team) {
    return;
  }

  var_12 = var_1.origin;
  var_13 = 0;

  if(isDefined(var_0)) {
    var_12 = var_0.origin;
    var_13 = var_0 == var_1;
  }

  if(isDefined(var_1) && isPlayer(var_1) && var_1.pers["team"] != var_10.pers["team"]) {
    if(isDefined(var_1.ball_carried) && var_13) {
      var_11 = 1;
    }

    if(isDefined(var_10.ball_carried)) {
      var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
      var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
      thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_9, "carrying");
      scripts\mp\gametypes\obj_ball::updatetimers("neutral", 1, 0);
      var_11 = 1;
    }
  }

  if(!var_11) {
    var_14 = 0;

    foreach(var_16 in level.balls) {
      var_14 = distsquaredcheck(var_12, var_10.origin, var_16.curorigin);

      if(var_14 && var_1.team != var_10.team) {
        if(var_16.ownerteam == var_10.team) {
          var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        } else if(var_16.ownerteam == var_1.team) {
          var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        }

        break;
      }
    }

    if(!var_14) {
      foreach(var_19 in level.ball_goals) {
        var_20 = distsquaredcheck(var_12, var_10.origin, var_19.trigger.origin);

        if(var_20) {
          if(var_21 == var_10.team) {
            var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
            continue;
          }

          var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        }
      }

      return;
    }

    return;
  }
}

function distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_2, var_0);
  var_4 = distancesquared(var_2, var_1);

  if(var_3 < 90000 || var_4 < 90000) {
    return 1;
  }

  return 0;
}

function onspawnplayer() {
  self.teleporting = 0;
}

function hidehudelementongameend(var_0) {
  level waittill("game_ended");

  if(isDefined(var_0)) {
    var_0.alpha = 0;
    return;
  }
}

function removeuplinkgoal() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("scr_devRemoveDomFlag", "") != "") {
      var_0 = getDvar("scr_devRemoveDomFlag", "");

      if(var_0 == "_a") {
        var_1 = "allies";
      } else {
        var_1 = "axis";
      }

      level.ball_goals[var_1].useobject scripts\mp\gameobjects::allowuse("none");
      level.ball_goals[var_1].useobject.trigger = undefined;
      level.ball_goals[var_1].useobject notify("deleted");

      foreach(var_3 in level.players) {
        player_delete_ball_goal_fx(var_3);
      }

      level.ball_goals[var_1].useobject.visibleteam = "none";
      level.ball_goals[var_1].useobject scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
      setdynamicdvar("scr_devRemoveDomFlag", "");
    }

    wait 1;
  }
}

function placeuplinkgoal() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("scr_devPlaceDomFlag", "") != "") {
      var_0 = getDvar("scr_devPlaceDomFlag", "");

      if(var_0 == "_a") {
        var_1 = "allies";
      } else {
        var_1 = "axis";
      }

      var_2 = spawnStruct();
      var_2.origin = level.players[0].origin;
      var_2.origin += (0, 0, 190);
      var_2.radius = 50;
      var_2.team = var_1;
      var_2.ball_in_goal = 0;
      var_2.highestspawndistratio = 0;
      level.ball_goals[var_1] = var_2;
      var_2.trigger = spawn("trigger_radius", var_2.origin - (0, 0, var_2.radius), 0, var_2.radius, var_2.radius * 2);
      var_2.useobject = scripts\mp\gameobjects::createuseobject(var_1, var_2.trigger, [], (0, 0, var_2.radius * 2.1));
      var_2.useobject.goal = var_2;
      var_2.useobject scripts\mp\gameobjects::setobjectivestatusicons("waypoint_blitz_defend", "waypoint_blitz_goal");
      var_2.useobject scripts\mp\gameobjects::setvisibleteam("any");
      var_2.useobject scripts\mp\gameobjects::allowuse("enemy");
      var_2.useobject scripts\mp\gameobjects::setkeyobject(level.balls);
      var_2.useobject scripts\mp\gameobjects::setusetime(0);
      var_2.useobject scripts\mp\gameobjects::cancontestclaim(1);
      var_2.useobject.onuse = &ball_carrier_touched_goal;
      var_2.useobject.canuseobject = &ball_goal_can_use;
      var_2.useobject.oncontested = &ball_goal_contested;
      var_2.useobject.onuncontested = &ball_goal_uncontested;
      var_2.killcament = spawn("script_model", var_2.origin + (0, 0, 20));
      var_2.killcament setscriptmoverkillcam("explosive");
      ball_goal_fx();
      setdynamicdvar("scr_devPlaceDomFlag", "");
    }

    wait 1;
  }
}