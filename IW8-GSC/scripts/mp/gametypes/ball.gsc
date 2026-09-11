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
  var0 = scripts\mp\utility\game::inovertime();
  var1 = game["overtimeRoundsPlayed"] == 0;
  var2 = scripts\mp\utility\game::istimetobeatvalid();

  if(var0) {
    if(var1) {
      setomnvar("ui_round_hint_override_attackers", 1);
      setomnvar("ui_round_hint_override_defenders", 1);
    } else if(var2) {
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
    var3 = game["attackers"];
    var4 = game["defenders"];
    game["attackers"] = var4;
    game["defenders"] = var3;
  }

  foreach(var6 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var6, &"OBJECTIVES/BALL");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var6, &"OBJECTIVES/BALL");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var6, &"OBJECTIVES/BALL_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var6, &"OBJECTIVES/BALL_HINT");
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
  foreach(var1 in level.ball_goals) {
    var1.trigger = spawn("trigger_radius", var1.origin - (0, 0, var1.radius), 0, var1.radius, var1.radius * 2);
    var1.useobject = scripts\mp\gameobjects::createuseobject(var2, var1.trigger, [], (0, 0, var1.radius * 2.1));
    var1.useobject.goal = var1;
    var1.useobject scripts\mp\gameobjects::setobjectivestatusicons("waypoint_blitz_defend", "waypoint_blitz_goal");
    var1.useobject scripts\mp\gameobjects::setvisibleteam("any");
    var1.useobject scripts\mp\gameobjects::allowuse("enemy");
    var1.useobject scripts\mp\gameobjects::setkeyobject(level.balls);
    var1.useobject scripts\mp\gameobjects::setusetime(0);
    var1.useobject scripts\mp\gameobjects::cancontestclaim(1);
    var1.useobject.onuse = &ball_carrier_touched_goal;
    var1.useobject.canuseobject = &ball_goal_can_use;
    var1.useobject.oncontested = &ball_goal_contested;
    var1.useobject.onuncontested = &ball_goal_uncontested;
    var1.killcament = spawn("script_model", var1.origin + (0, 0, 20));
    var1.killcament setscriptmoverkillcam("explosive");
  }
}

function ball_get_path_dist(var0, var1) {
  if(scripts\mp\spawnlogic::ispathdataavailable()) {
    var2 = getpathdist(var0, var1, 999999);

    if(isDefined(var2) && var2 >= 0) {
      return var2;
    }
  }

  return distance(var0, var1);
}

function ball_goal_fx() {
  foreach(var1 in level.ball_goals) {
    var1.score_fx["friendly"] = spawnfx(scripts\engine\utility::getfx("ball_goal_activated_friendly"), var1.origin, (1, 0, 0));
    var1.score_fx["enemy"] = spawnfx(scripts\engine\utility::getfx("ball_goal_activated_enemy"), var1.origin, (1, 0, 0));
  }

  thread ball_play_fx_joined_team();

  foreach(var4 in level.players) {
    ball_goal_fx_for_player(var4);
  }

  thread goal_watch_game_ended();
}

function onplayerconnect(var0) {
  level endon("game_ended");
  thread onplayerspawned(var0);

  if(istrue(level.practicemode) && var0 ishost()) {
    var0 thread scripts\mp\gametypes\obj_ball::practicenotify();
    var0 thread scripts\mp\gametypes\obj_ball::moveballtoplayer();
    return;
  }
}

function onplayerspawned(var0) {
  var0 waittill("spawned");
  var0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var0.pers["touchdowns"])) {
    var0 scripts\mp\utility\stats::setextrascore0(var0.pers["touchdowns"]);
  }

  var0 scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(var0.pers["fieldgoals"])) {
    var0 scripts\mp\utility\stats::setextrascore1(var0.pers["fieldgoals"]);
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
  var0 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  var1 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype + "_secondary");
  var2 = assignteamspawns(var0);
  var3 = assignteamspawns(var1);
  scripts\mp\spawnlogic::registerspawnpoints("allies", var2["allies"]);
  scripts\mp\spawnlogic::registerspawnpoints("allies", var3["allies"], 1);
  scripts\mp\spawnlogic::registerspawnpoints("axis", var2["axis"]);
  scripts\mp\spawnlogic::registerspawnpoints("axis", var3["axis"], 1);
}

function assignteamspawns(var0) {
  var1 = [];
  GscBinSkip0(0x2e, "allies", []);
}

function getspawnpointdist(var0, var1) {
  var2 = getpathdist(var0.origin, var1, 16000);

  if(var2 < 0) {
    var2 = distance(var0.origin, var1);
  }

  return var2;
}

function getspawnpoint() {
  var0 = self.pers["team"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(game["switchedsides"]) {
      var0 = scripts\mp\utility\game::getotherteam(var0)[0];
    }

    var1 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype + "_" + var0 + "_start");
    var2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var1);
  } else {
    var1 = scripts\mp\spawnlogic::getteamspawnpoints(var2);
    var3 = scripts\mp\spawnlogic::getteamfallbackspawnpoints(var2);
    var4 = [];
    GscBinSkip1(0x45, "homeBaseTeam", var2);
  }

  return var4;
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

  for(var0 = 0; var0 < level.satellitecount; var0++) {
    scripts\mp\gametypes\obj_ball::ball_spawn(var0);
  }

  ball_goal_useobject();
  ball_goal_fx();
  initspawns();
  thread removeuplinkgoal();
  thread placeuplinkgoal();
  level.ball = level.balls[0];
}

function ball_find_ground(var0) {
  var1 = self.origin + (0, 0, 32);
  var2 = self.origin + (0, 0, -1000);
  var3 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var4 = [];
  var5 = scripts\engine\trace::ray_trace(var1, var2, var4, var3);
  self.ground_origin = var5["position"];
  return var5["fraction"] != 0 && var5["fraction"] != 1;
}

function ball_create_team_goal(var0) {
  var1 = var0;

  if(game["switchedsides"]) {
    var1 = scripts\mp\utility\game::getotherteam(var1)[0];
  }

  var2 = scripts\engine\utility::getStruct("ball_goal_" + var1, "targetname");

  if(isDefined(var2)) {
    var2 = checkpostshipgoalplacement(var2, var0);
    ball_find_ground(var2);
  } else {
    var2 = spawnStruct();

    switch (level.script) {
      default:
        break;
    }

    if(!isDefined(var2.origin)) {
      var2.origin = level.default_goal_origins[var0];
    }

    ball_find_ground(var2);
  }

  if(istrue(scripts\cp_mp\utility\game_utility::isrealismenabled())) {
    var2.origin = var2.ground_origin + (0, 0, 130);
  } else {
    var2.origin = var2.ground_origin + (0, 0, 130);
  }

  var2.radius = 60;
  var2.team = var0;
  var2.ball_in_goal = 0;
  var2.highestspawndistratio = 0;
  level.ball_goals[var0] = var2;
}

function checkpostshipgoalplacement(var0, var1) {
  if(level.mapname == "mp_metropolis") {
    if(!game["switchedsides"] && var1 == "axis") {
      var0.origin = (-2039, -1464, 123);
    } else if(game["switchedsides"] && var1 == "allies") {
      var0.origin = (-2039, -1464, 123);
    }
  }

  if(level.mapname == "mp_fallen") {
    if(!game["switchedsides"] && var1 == "axis") {
      var0.origin = (2752, 1429, 988);
    } else if(game["switchedsides"] && var1 == "allies") {
      var0.origin = (2752, 1429, 988);
    }

    if(!game["switchedsides"] && var1 == "allies") {
      var0.origin = (-1866, 1698, 988);
    } else if(game["switchedsides"] && var1 == "axis") {
      var0.origin = (-1866, 1698, 988);
    }
  }

  return var0;
}

function ball_connect_watch() {
  for(;;) {
    level waittill("connected", var0);
    var0 thread scripts\mp\gametypes\obj_ball::ball_player_on_connect();
  }
}

function ball_physics_touch_goal() {
  var0 = self.visuals[0];
  self endon("pass_end");
  self endon("pickup_object");
  self endon("physics_finished");

  if(scripts\mp\utility\game::getgametype() != "tdef") {
    ball_touch_goal_watch(var0);
    return;
  }
}

function ball_pass_touch_goal() {
  var0 = self.visuals[0];
  self endon("pass_end");

  if(scripts\mp\utility\game::getgametype() != "tdef") {
    ball_touch_goal_watch(var0);
    return;
  }
}

function ball_touch_goal_watch(var0) {
  self endon("pass_end");
  self endon("pickup_object");
  self endon("physics_finished");

  for(;;) {
    foreach(var2 in level.ball_goals) {
      if(self.lastcarrierteam == var5) {
        continue;
      }

      if(!ball_goal_can_use(var2.useobject)) {
        continue;
      }

      var3 = distance(var0.origin, var2.origin);

      if(var3 <= var2.radius) {
        thread ball_touched_goal(var2);
        var0 notify("pass_end");
        return;
      }

      if(isDefined(var0.origin_prev)) {
        var4 = line_interect_sphere(var0.origin_prev, var0.origin, var2.origin, var2.radius);

        if(var4) {
          thread ball_touched_goal(var2);
          var0 notify("pass_end");
          return;
        }
      }
    }

    waitframe();
  }
}

function ball_goal_can_use(var0) {
  var1 = self.goal;

  if(var1.ball_in_goal) {
    return false;
  }

  return true;
}

function ball_goal_contested() {
  ball_waypoint_contest();
}

function ball_goal_uncontested(var0) {
  goal_waypoint();
}

function ball_carrier_touched_goal(var0) {
  if(!isDefined(var0) || !isDefined(var0.carryobject)) {
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

  var0 notify("goal_scored");
  var1 = level.scorecarry;
  var0 thread scripts\mp\awards::givemidmatchaward("mode_uplink_dunk");
  ball_check_assist(var0, 1);
  var0 scripts\mp\utility\stats::incpersstat("touchdowns", 1);
  var0 scripts\mp\persistence::statsetchild("round", "touchdowns", var0.pers["touchdowns"]);

  if(isPlayer(var0)) {
    var0 scripts\mp\utility\stats::setextrascore0(var0.pers["touchdowns"]);
    var0 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "dunk", var0.origin);
  }

  var2 = self.goal.team;
  var3 = scripts\mp\utility\game::getotherteam(var2)[0];
  scripts\mp\utility\dialog::statusdialog("enemy_carry_score", var2, 1);
  scripts\mp\utility\dialog::statusdialog("ally_carry_score", var3, 1);
  ball_play_score_fx(self.goal);
  ball_score_sound(var3, 1);
  var4 = var0.carryobject;
  var4.lastcarrierscored = 1;
  var4 scripts\mp\gametypes\obj_ball::ball_set_dropped(1, self.trigger.origin, 1);
  thread ball_score_event(var4);
  ball_give_score(var3, var1);
}

function should_record_final_score_cam(var0, var1) {
  var2 = scripts\mp\gamescore::_getteamscore(var0);
  var3 = scripts\mp\gamescore::_getteamscore(scripts\mp\utility\game::getotherteam(var0)[0]);
  return var2 + var1 >= var3;
}

function line_interect_sphere(var0, var1, var2, var3) {
  var4 = vectorNormalize(var1 - var0);
  var5 = vectordot(var4, var0 - var2);
  var5 *= var5;
  var6 = var0 - var2;
  var6 *= var6;
  var7 = var3 * var3;
  return var5 - var6 + var7 >= 0;
}

function ball_touched_goal(var0) {
  if(isDefined(level.scorefrozenuntil) && level.scorefrozenuntil > gettime()) {
    return;
  }

  if(istimeup()) {
    return;
  }

  if(level.gameended) {
    return;
  }

  ball_play_score_fx(var0);
  var1 = level.scorethrow;
  var2 = var0.team;
  var3 = scripts\mp\utility\game::getotherteam(var2)[0];
  scripts\mp\utility\dialog::statusdialog("enemy_throw_score", var2, 1);
  scripts\mp\utility\dialog::statusdialog("ally_throw_score", var3, 1);

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

  ball_score_sound(var3, 0);
  thread ball_score_event(var0);
  ball_give_score(var3, var1);
}

function istimeup() {
  var0 = scripts\mp\utility\dvars::getwatcheddvar("timelimit");

  if(var0 != 0) {
    var1 = scripts\mp\gamelogic::gettimeremaining();

    if(var1 <= 0) {
      return true;
    }
  }

  return false;
}

function ball_give_score(var0, var1) {
  level scripts\mp\gamescore::giveteamscoreforobjective(var0, var1, 0);
}

function ball_score_event(var0) {
  thread scorefrozentimer();
  self notify("score_event");

  if(istrue(level.practicemode)) {
    foreach(var2 in level.players) {
      if(var2 ishost()) {
        var2 thread scripts\mp\gametypes\obj_ball::moveballtoplayer();
        break;
      }
    }
  }

  self.in_goal = 1;
  var0.ball_in_goal = 1;
  var4 = self.visuals[0];

  if(isDefined(self.projectile)) {
    self.projectile delete();
  }

  var4 physicslaunchserver(var4.origin, (0, 0, 0));
  var4 physicsstopserver();
  scripts\mp\gameobjects::allowcarry("none");
  scripts\mp\gametypes\obj_ball::ball_waypoint_upload();
  var5 = 0.4;
  var6 = 1.2;
  var7 = 1;
  var8 = var5 + var7;
  var9 = var8 + var6;
  var4 moveTo(var0.origin, var5, 0, var5);
  var4 rotatevelocity((1080, 1080, 0), var9, var9, 0);
  wait var8;
  var4 movez(4000, var6, var6 * 0.1, 0);
  wait var6;
  var0.ball_in_goal = 0;
  scripts\mp\gametypes\obj_ball::ball_return_home(0, 0);
}

function ball_check_assist(var0, var1) {
  if(!isDefined(var0.passtime) || !isDefined(var0.passplayer)) {
    return;
  }

  if(var0.passtime + 3000 < gettime()) {
    return;
  }

  if(var1) {
    var0.passplayer thread scripts\mp\awards::givemidmatchaward("mode_uplink_allyoop");
    return;
  }
}

function ball_play_score_fx(var0) {
  var0.score_fx["friendly"] hide();
  var0.score_fx["enemy"] hide();

  foreach(var2 in level.players) {
    var3 = ball_get_view_team(var2);

    if(var3 == var0.team) {
      var0.score_fx["friendly"] showtoplayer(var2);
      continue;
    }

    var0.score_fx["enemy"] showtoplayer(var2);
  }

  triggerfx(var0.score_fx["friendly"]);
  triggerfx(var0.score_fx["enemy"]);
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

function ball_score_sound(var0, var1) {
  if(var1) {
    scripts\mp\gametypes\obj_ball::ball_play_local_team_sound(var0, "mp_uplink_goal_carried_friendly", "mp_uplink_goal_carried_enemy");
    return;
  }

  scripts\mp\gametypes\obj_ball::ball_play_local_team_sound(var0, "mp_uplink_goal_friendly", "mp_uplink_goal_enemy");
}

function scorefrozentimer() {
  level endon("game_ended");
  level.scorefrozenuntil = gettime() + 10000;

  foreach(var1 in level.ball_goals) {
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
    level waittill("connected", var0);
    var0.ball_goal_fx = [];
    thread player_on_disconnect();
  }
}

function player_on_disconnect() {
  self waittill("disconnect");
  player_delete_ball_goal_fx();
}

function ball_goal_fx_for_player(var0) {
  var1 = ball_get_view_team(var0);
  player_delete_ball_goal_fx(var0);

  foreach(var3 in level.ball_goals) {
    var4 = scripts\engine\utility::ter_op(var6 == var1, "ball_goal_friendly", "ball_goal_enemy");
    var5 = spawnfxforclient(scripts\engine\utility::getfx(var4), var3.origin, var0, (1, 0, 0));
    var5 setfxkilldefondelete();
    var0.ball_goal_fx[var4] = var5;
    triggerfx(var5);
  }
}

function ball_get_view_team(var0) {
  var1 = var0.team;

  if(var1 != "allies" && var1 != "axis") {
    if(var0 ismlgspectator()) {
      var1 = var0 getmlgspectatorteam();
    } else {
      var1 = "allies";
    }
  }

  return var1;
}

function player_delete_ball_goal_fx() {
  if(isDefined(self.ball_goal_fx)) {
    foreach(var1 in self.ball_goal_fx) {
      if(isDefined(var1)) {
        var1 delete();
      }
    }

    return;
  }
}

function goal_watch_game_ended() {
  level waittill("game_ended");

  foreach(var1 in level.players) {
    player_delete_ball_goal_fx(var1);
  }
}

function ball_play_fx_joined_team() {}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = self;
  var11 = 0;

  if(!isDefined(var1) || !isDefined(var1.team) || !isDefined(var10) || !isDefined(var10.team)) {
    return;
  }

  if(var1 == var10) {
    return;
  }

  if(var1.team == var10.team) {
    return;
  }

  var12 = var1.origin;
  var13 = 0;

  if(isDefined(var0)) {
    var12 = var0.origin;
    var13 = var0 == var1;
  }

  if(isDefined(var1) && isPlayer(var1) && var1.pers["team"] != var10.pers["team"]) {
    if(isDefined(var1.ball_carried) && var13) {
      var11 = 1;
    }

    if(isDefined(var10.ball_carried)) {
      var1 scripts\mp\utility\stats::incpersstat("defends", 1);
      var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
      thread scripts\common\utility::ref_13e0a(level.ref_11b30, var9, "carrying");
      scripts\mp\gametypes\obj_ball::updatetimers("neutral", 1, 0);
      var11 = 1;
    }
  }

  if(!var11) {
    var14 = 0;

    foreach(var16 in level.balls) {
      var14 = distsquaredcheck(var12, var10.origin, var16.curorigin);

      if(var14 && var1.team != var10.team) {
        if(var16.ownerteam == var10.team) {
          var1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        } else if(var16.ownerteam == var1.team) {
          var1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        }

        break;
      }
    }

    if(!var14) {
      foreach(var19 in level.ball_goals) {
        var20 = distsquaredcheck(var12, var10.origin, var19.trigger.origin);

        if(var20) {
          if(var21 == var10.team) {
            var1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
            continue;
          }

          var1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        }
      }

      return;
    }

    return;
  }
}

function distsquaredcheck(var0, var1, var2) {
  var3 = distancesquared(var2, var0);
  var4 = distancesquared(var2, var1);

  if(var3 < 90000 || var4 < 90000) {
    return 1;
  }

  return 0;
}

function onspawnplayer() {
  self.teleporting = 0;
}

function hidehudelementongameend(var0) {
  level waittill("game_ended");

  if(isDefined(var0)) {
    var0.alpha = 0;
    return;
  }
}

function removeuplinkgoal() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("scr_devRemoveDomFlag", "") != "") {
      var0 = getDvar("scr_devRemoveDomFlag", "");

      if(var0 == "_a") {
        var1 = "allies";
      } else {
        var1 = "axis";
      }

      level.ball_goals[var1].useobject scripts\mp\gameobjects::allowuse("none");
      level.ball_goals[var1].useobject.trigger = undefined;
      level.ball_goals[var1].useobject notify("deleted");

      foreach(var3 in level.players) {
        player_delete_ball_goal_fx(var3);
      }

      level.ball_goals[var1].useobject.visibleteam = "none";
      level.ball_goals[var1].useobject scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
      setdynamicdvar("scr_devRemoveDomFlag", "");
    }

    wait 1;
  }
}

function placeuplinkgoal() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("scr_devPlaceDomFlag", "") != "") {
      var0 = getDvar("scr_devPlaceDomFlag", "");

      if(var0 == "_a") {
        var1 = "allies";
      } else {
        var1 = "axis";
      }

      var2 = spawnStruct();
      var2.origin = level.players[0].origin;
      var2.origin += (0, 0, 190);
      var2.radius = 50;
      var2.team = var1;
      var2.ball_in_goal = 0;
      var2.highestspawndistratio = 0;
      level.ball_goals[var1] = var2;
      var2.trigger = spawn("trigger_radius", var2.origin - (0, 0, var2.radius), 0, var2.radius, var2.radius * 2);
      var2.useobject = scripts\mp\gameobjects::createuseobject(var1, var2.trigger, [], (0, 0, var2.radius * 2.1));
      var2.useobject.goal = var2;
      var2.useobject scripts\mp\gameobjects::setobjectivestatusicons("waypoint_blitz_defend", "waypoint_blitz_goal");
      var2.useobject scripts\mp\gameobjects::setvisibleteam("any");
      var2.useobject scripts\mp\gameobjects::allowuse("enemy");
      var2.useobject scripts\mp\gameobjects::setkeyobject(level.balls);
      var2.useobject scripts\mp\gameobjects::setusetime(0);
      var2.useobject scripts\mp\gameobjects::cancontestclaim(1);
      var2.useobject.onuse = &ball_carrier_touched_goal;
      var2.useobject.canuseobject = &ball_goal_can_use;
      var2.useobject.oncontested = &ball_goal_contested;
      var2.useobject.onuncontested = &ball_goal_uncontested;
      var2.killcament = spawn("script_model", var2.origin + (0, 0, 20));
      var2.killcament setscriptmoverkillcam("explosive");
      ball_goal_fx();
      setdynamicdvar("scr_devPlaceDomFlag", "");
    }

    wait 1;
  }
}