/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_749072e646d90120.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\oob;
#using scripts\core_common\perks;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\armor;
#using scripts\mp_common\bb;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_defaults;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\hud_message;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\overtime;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#namespace ball;

autoexec __init__system__() {
  system::register(#"ball", & __init__, undefined, undefined);
}

__init__() {
  clientfield::register("allplayers", "ballcarrier", 1, 1, "int");
  clientfield::register("allplayers", "passoption", 1, 1, "int");
  clientfield::register("world", "ball_away", 1, 1, "int");
  clientfield::register("world", "ball_score_allies", 1, 1, "int");
  clientfield::register("world", "ball_score_axis", 1, 1, "int");
  globallogic_spawn::addsupportedspawnpointtype("uplink");
}

event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  util::registertimelimit(0, 1440);
  util::registerroundlimit(0, 10);
  util::registerroundwinlimit(0, 10);
  util::registerroundswitch(0, 9);
  util::registernumlives(0, 100);
  util::registerroundscorelimit(0, 5000);
  util::registerscorelimit(0, 5000);
  level.scoreroundwinbased = getgametypesetting(#"cumulativeroundscores") == 0;
  level.teamkillpenaltymultiplier = getgametypesetting(#"teamkillpenalty");
  level.teamkillscoremultiplier = getgametypesetting(#"teamkillscore");
  level.var_aa5bcaa3 = getgametypesetting(#"objectivepingtime");
  if(level.roundscorelimit) {
    level.carryscore = math::clamp(getgametypesetting(#"carryscore"), 0, level.roundscorelimit);
    level.throwscore = math::clamp(getgametypesetting(#"throwscore"), 0, level.roundscorelimit);
  } else {
    level.carryscore = getgametypesetting(#"carryscore");
    level.throwscore = getgametypesetting(#"throwscore");
  }
  level.var_ef3abf3b = getgametypesetting(#"carrierarmor");
  level.ballcount = getgametypesetting(#"ballcount");
  level.enemycarriervisible = getgametypesetting(#"enemycarriervisible");
  level.idleflagreturntime = getgametypesetting(#"idleflagresettime");
  globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
  level.overrideteamscore = 1;
  level.clampscorelimit = 0;
  level.doubleovertime = 1;
  level.onprecachegametype = & onprecachegametype;
  level.onstartgametype = & onstartgametype;
  level.onspawnplayer = & onspawnplayer;
  level.onroundscorelimit = & onroundscorelimit;
  level.onendround = & onendround;
  level.onendgame = & onendgame;
  level.getteamkillpenalty = & function_54dd76af;
  level.getteamkillscore = & function_eb6c9496;
  level.shouldplayovertimeround = & shouldplayovertimeround;
  level.ontimelimit = & function_25dd17ea;
  level.var_c9d3723c = & function_4fdb87a6;
  player::function_b0320e78( & onplayerkilled);
  globallogic_audio::set_leader_gametype_dialog("startUplink", "hcStartUplink", "uplOrders", "uplOrders");
}

onprecachegametype() {
  game.strings[# "score_limit_reached"] = # "hash_5218d2db23ab36aa";
}

function_4fdb87a6() {
  spawning::place_spawn_points("mp_ctf_spawn_allies_start");
  spawning::place_spawn_points("mp_ctf_spawn_axis_start");
  spawning::add_spawn_points("sidea", "mp_ctf_spawn_allies");
  spawning::add_spawn_points("sideb", "mp_ctf_spawn_axis");
  spawning::add_fallback_spawnpoints("sidea", "mp_tdm_spawn");
  spawning::add_fallback_spawnpoints("sideb", "mp_tdm_spawn");
  foreach(team, _ in level.teams) {
    spawning::add_start_spawn_points(team, "mp_ctf_spawn_" + team + "_start");
  }
  spawning::updateallspawnpoints();
  spawning::update_fallback_spawnpoints();
  level.spawn_axis = spawning::get_spawnpoint_array("mp_ctf_spawn_axis");
  level.spawn_allies = spawning::get_spawnpoint_array("mp_ctf_spawn_allies");
}

onstartgametype() {
  level.var_d566bdba = getweapon("ball_world");
  level.var_aff3334d = getweapon("ball_world_pass");
  if(overtime::is_overtime_round()) {
    if(!isDefined(game.var_dda157bc)) {
      game.var_dda157bc = [];
      game.var_dda157bc[# "allies"] = [
        [level._getteamscore]
      ](#"allies");
      game.var_dda157bc[# "axis"] = [
        [level._getteamscore]
      ](#"axis");
    }
    [[level._setteamscore]](#"allies", 0);
    [[level._setteamscore]](#"axis", 0);
    if(isDefined(game.var_f3b50e28)) {
      util::registerscorelimit(game.var_f3b50e28, game.var_f3b50e28);
    } else {
      util::registerscorelimit(1, 1);
    }
    if(isDefined(game.var_68805c9b)) {
      util::registertimelimit(game.var_68805c9b / 60000, game.var_68805c9b / 60000);
    } else {
      util::registertimelimit(0, 1440);
    }
    if(game.overtime_round == 1) {} else if(isDefined(game.overtime_first_winner)) {
      level.ontimelimit = & function_972a6af9;
      game.teamsuddendeath[game.overtime_first_winner] = 1;
    } else {
      level.ontimelimit = & function_972a6af9;
    }
  } else if(isDefined(game.round_time_to_beat)) {
    util::registertimelimit(game.round_time_to_beat / 60000, game.round_time_to_beat / 60000);
  }
  level setup_objectives();
  globallogic_utils::print_map_errors();
}

function_481ef46f() {
  foreach(ball in level.balls) {
    if(isDefined(ball.carrier)) {
      continue;
    }
    if(isDefined(ball.projectile)) {
      if(!ball.projectile isonground()) {
        return ball;
      }
    }
  }
}

function_4dbb4a6a() {
  self endon(#"reset");
  self endon(#"pickup_object");
  if(isDefined(self.projectile)) {
    if(self.projectile isonground()) {
      return;
    }
    self.projectile endon(#"death");
    self.projectile endon(#"stationary");
    self.projectile endon(#"grenade_bounce");
    while(true) {
      wait 1;
    }
  }
}

function_6dd12da4() {
  self endon(#"disconnect");
  self player::freeze_player_for_round_end();
  self thread globallogic::roundenddof();
  self waittill(#"spawned");
  if(self.sessionstate == "playing") {
    self player::freeze_player_for_round_end();
    self thread globallogic::roundenddof();
  }
}

function_83143ec0() {
  ball = function_481ef46f();
  if(isDefined(ball)) {
    level.ontimelimit = & function_e1d7d235;
    ball function_4dbb4a6a();
  }
}

function_25dd17ea() {
  function_83143ec0();
  globallogic_defaults::default_ontimelimit();
}

function_e1d7d235() {
}

function_954bf69b() {
  if(level.teambased) {
    foreach(team, _ in level.teams) {
      if(game.teamsuddendeath[team]) {
        round::set_winner(team);
        return true;
      }
    }
  }
  return false;
}

function_972a6af9() {
  function_83143ec0();
  if(!function_954bf69b()) {
    round::function_76a0135d();
  }
  thread globallogic::end_round(2);
}

onspawnplayer(predictedspawn) {
  self.var_1821be2 = 0;
  self.var_bbc60d50 = undefined;
  self clientfield::set("ctf_flag_carrier", 0);
  self thread function_67cb1206();
  spawning::onspawnplayer(predictedspawn);
}

function_67cb1206() {
  self endon(#"death");
  self endon(#"delete");
  player = self;
  ball = getweapon("ball");
  while(true) {
    if(isDefined(ball) && player hasweapon(ball)) {
      curweapon = player getcurrentweapon();
      if(isDefined(curweapon) && curweapon != ball && !player isswitchingweapons()) {
        if(curweapon.isheavyweapon) {
          slot = self gadgetgetslot(curweapon);
          if(!self util::gadget_is_in_use(slot)) {
            waitframe(1);
            continue;
          }
        }
        println("<dev string:x30>");
        player switchtoweapon(ball);
        player disableweaponcycling();
        player disableoffhandweapons();
      }
    }
    waitframe(1);
  }
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isDefined(self.carryobject)) {
    otherteam = util::getotherteam(self.team);
    self recordgameevent("return");
    if(isDefined(attacker) && isplayer(attacker) && attacker != self) {
      attacker recordgameevent("kill_carrier");
      if(attacker.team != self.team) {
        scoreevents::processscoreevent(#"hash_3a5eaaf8d03d8f10", attacker, self, weapon);
        attacker stats::function_b48aa4e(#"kill_carrier", 1);
      }
      globallogic_audio::leader_dialog("uplWeDrop", self.team, undefined, "uplink_ball");
      globallogic_audio::leader_dialog("uplTheyDrop", otherteam, undefined, "uplink_ball");
      globallogic_audio::play_2d_on_team("mpl_balldrop_sting_friend", self.team);
      globallogic_audio::play_2d_on_team("mpl_balldrop_sting_enemy", otherteam);
      level thread popups::displayteammessagetoteam(#"hash_2a9e3ce6905b87b9", self, self.team, undefined, undefined);
      level thread popups::displayteammessagetoteam(#"hash_2a9e3ce6905b87b9", self, otherteam, undefined, undefined);
    }
  } else if(isDefined(attacker.carryobject) && attacker.team != self.team) {
    scoreevents::processscoreevent(#"hash_26d28bf9e79156e0", attacker, self, weapon);
  }
  foreach(ball in level.balls) {
    ballcarrier = ball.carrier;
    if(isDefined(ballcarrier)) {
      var_bf7df05c = ball.carrier.origin;
      iscarried = 1;
    } else {
      var_bf7df05c = ball.curorigin;
      iscarried = 0;
    }
    if(iscarried && isDefined(attacker) && isDefined(attacker.team) && attacker != self && ballcarrier != attacker) {
      if(attacker.team == ball.carrier.team) {
        dist = distance2dsquared(self.origin, var_bf7df05c);
        if(dist < level.defaultoffenseradiussq) {
          attacker stats::function_b48aa4e(#"defend_carrier", 1);
          break;
        }
      }
    }
  }
  victim = self;
  foreach(var_3c3dd1e8 in level.ball_goals) {
    if(isDefined(attacker) && isDefined(attacker.team) && attacker != victim && isDefined(victim.team) && isplayer(attacker)) {
      var_3d921577 = distance2dsquared(attacker.origin, var_3c3dd1e8.origin);
      var_8d501176 = distance2dsquared(victim.origin, var_3c3dd1e8.origin);
      if(var_3d921577 < level.defaultoffenseradiussq || var_8d501176 < level.defaultoffenseradiussq) {
        if(victim.team == var_3c3dd1e8.team) {
          attacker thread challenges::killedbasedefender(var_3c3dd1e8.trigger);
          continue;
        }
        attacker thread challenges::killedbaseoffender(var_3c3dd1e8.trigger, weapon);
      }
    }
  }
}

onroundscorelimit() {
  if(!overtime::is_overtime_round()) {
    timelimit = getgametypesetting(#"timelimit") * 60000;
    var_88effb35 = globallogic_utils::gettimepassed();
    if(timelimit > 0 && var_88effb35 < timelimit) {
      game.round_time_to_beat = var_88effb35;
    }
  }
  return globallogic_defaults::default_onroundscorelimit();
}

onendround(var_c3d87d03) {
  winningteam = round::get_winning_team();
  if(!isDefined(winningteam) || round::get_flag("tie")) {
    return;
  }
  if(round::get_flag("overtime")) {
    game.overtime_first_winner = winningteam;
    game.var_f3b50e28 = getteamscore(winningteam);
    game.overtime_time_to_beat[# "ball"] = globallogic_utils::gettimepassed();
    game.var_68805c9b = globallogic_utils::gettimepassed();
    return;
  }
  game.overtime_second_winner[# "ball"] = winningteam;
  game.var_7c5098a[# "ball"] = getteamscore(winningteam);
  game.overtime_best_time[# "ball"] = globallogic_utils::gettimepassed();
  game.var_68805c9b = globallogic_utils::gettimepassed();
}

onendgame(var_c3d87d03) {
  winningteam = round::get_winning_team();
  if(match::get_flag("overtime")) {
    if(level.scoreroundwinbased) {
      globallogic_score::updateteamscorebyroundswon();
    }
    if(isDefined(game.overtime_first_winner)) {
      var_aed1a51e = 0;
      if(match::get_flag("tie")) {
        winningteam = game.overtime_first_winner;
      }
      if(game.overtime_first_winner == winningteam) {
        level.endvictoryreasontext = # "hash_30307c24e2b87002";
        level.enddefeatreasontext = # "hash_6f446f2ca3839f9d";
      } else {
        level.endvictoryreasontext = # "hash_30307c24e2b87002";
        level.enddefeatreasontext = # "hash_4331740e0976c937";
      }
    }
    if(level.scoreroundwinbased) {
      if(isDefined(winningteam)) {
        [
          [level._setteamscore]
        ](winningteam, game.stat[# "roundswon"][winningteam] + 1);
      }
    } else {
      if(isDefined(game.var_f3b50e28) && (!isDefined(game.var_ec37b672) || game.var_f3b50e28 > game.var_ec37b672)) {
        var_9dfe2c62 = game.var_f3b50e28;
      } else {
        var_9dfe2c62 = game.var_ec37b672;
      }
      foreach(team, _ in level.teams) {
        score = game.var_dda157bc[team];
        if(team === winningteam) {
          score += var_9dfe2c62;
        }
        [
          [level._setteamscore]
        ](team, score);
      }
    }
    return winningteam;
  }
  globallogic_defaults::onendgame();
}

shouldplayovertimeround() {
  if(overtime::is_overtime_round()) {
    if(game.overtime_round == 1 || !level.gameended) {
      return true;
    }
    return false;
  }
  if(!level.scoreroundwinbased) {
    if(game.stat[# "teamscores"][# "allies"] == game.stat[# "teamscores"][# "axis"] && (util::hitroundlimit() || game.stat[# "teamscores"][# "allies"] == level.scorelimit - 1)) {
      return true;
    }
  } else {
    alliesroundswon = util::getroundswon(#"allies");
    axisroundswon = util::getroundswon(#"axis");
    if(level.roundwinlimit > 0 && axisroundswon == level.roundwinlimit - 1 && alliesroundswon == level.roundwinlimit - 1) {
      return true;
    }
    if(util::hitroundlimit() && alliesroundswon == axisroundswon) {
      return true;
    }
  }
  return false;
}

function_54dd76af(einflictor, attacker, smeansofdeath, weapon) {
  teamkill_penalty = globallogic_defaults::default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon);
  if(isDefined(self.var_1821be2) && self.var_1821be2) {
    teamkill_penalty *= level.teamkillpenaltymultiplier;
  }
  return teamkill_penalty;
}

function_eb6c9496(einflictor, attacker, smeansofdeath, weapon) {
  teamkill_score = attacker rank::getscoreinfovalue("kill");
  if(isDefined(self.var_1821be2) && self.var_1821be2) {
    teamkill_score *= level.teamkillscoremultiplier;
  }
  return int(teamkill_score);
}

function_6be95ac8(startpos, startangles, index, count, defaultdistance, rotation) {
  currentangle = startangles[1] + 360 / count * 0.5 + 360 / count * index;
  coscurrent = cos(currentangle + rotation);
  sincurrent = sin(currentangle + rotation);
  new_position = startpos + (defaultdistance * coscurrent, defaultdistance * sincurrent, 0);
  clip_mask = 1 | 8;
  trace = physicstrace(startpos, new_position, (-5, -5, -5), (5, 5, 5), self, clip_mask);
  return trace[# "position"];
}

function_18bf10c7(team) {
  var_837a6c85 = util::function_82f4ab63(team);
  var_29d2b927 = undefined;
  switch (var_837a6c85) {
    case # "axis":
      var_29d2b927 = "ball_goal_axis";
      break;
    case # "allies":
      var_29d2b927 = "ball_goal_allies";
      break;
  }
  return var_29d2b927;
}

setup_objectives() {
  level.ball_goals = [];
  level.ball_starts = [];
  level.balls = [];
  level.ball_starts = getEntArray("ball_start", "targetname");
  if(level.ball_starts.size == 0) {
    globallogic_utils::add_map_error("Could not find ball_start in the map.");
    return;
  }
  foreach(ball_start in level.ball_starts) {
    level.balls[level.balls.size] = function_dbf94d16(ball_start);
  }
  if(level.ballcount > level.ball_starts.size) {
    width = 48;
    height = 48;
    count = level.ballcount - level.ball_starts.size;
    for(index = 0; index < count; index++) {
      position = function_6be95ac8(level.ball_starts[0].origin, level.ball_starts[0].angles, index, count, width, 0);
      trigger = spawn("trigger_radius", position, 0, width, height);
      level.ball_starts[level.ball_starts.size] = trigger;
      level.balls[level.balls.size] = function_dbf94d16(trigger);
    }
  }
  foreach(team, _ in level.teams) {
    var_f3e319ca = function_18bf10c7(team);
    trigger = getent(var_f3e319ca, "targetname");
    if(isDefined(trigger)) {
      level.ball_goals[team] = function_b22de10a(trigger, team);
      continue;
    }
    level.ball_goals[team] = undefined;
    globallogic_utils::add_map_error("Could not find ball goal trigger " + var_f3e319ca);
  }
}

function_b22de10a(trigger, team) {
  useobj = gameobjects::create_use_object(team, trigger, [], (0, 0, trigger.height * 0.5), function_18bf10c7(team));
  useobj gameobjects::set_visible_team(#"any");
  useobj gameobjects::set_model_visibility(1);
  useobj gameobjects::allow_use(#"enemy");
  useobj gameobjects::set_use_time(0);
  foreach(ball in level.balls) {
    useobj gameobjects::set_key_object(ball);
  }
  useobj.var_cd77875d = & function_ce3bd9c9;
  useobj.onuse = & function_3d1ee3cc;
  useobj.ball_in_goal = 0;
  useobj.radiussq = trigger.radius * trigger.radius;
  useobj.center = trigger.origin + (0, 0, trigger.height * 0.5);
  return useobj;
}

function_ce3bd9c9(player) {
  return !self.ball_in_goal;
}

function_3d1ee3cc(player) {
  if(!isDefined(player) || !isDefined(player.carryobject)) {
    return;
  }
  if(isDefined(player.carryobject.scorefrozenuntil) && player.carryobject.scorefrozenuntil > gettime()) {
    return;
  }
  self function_85e74fc9();
  player.carryobject.scorefrozenuntil = gettime() + 10000;
  ball_check_assist(player, 1);
  team = self.team;
  otherteam = util::getotherteam(team);
  globallogic_audio::flush_objective_dialog("uplink_ball");
  globallogic_audio::leader_dialog("uplWeUplink", otherteam);
  globallogic_audio::leader_dialog("uplTheyUplink", team);
  globallogic_audio::play_2d_on_team("mpl_ballcapture_sting_friend", otherteam);
  globallogic_audio::play_2d_on_team("mpl_ballcapture_sting_enemy", team);
  level thread popups::displayteammessagetoteam(#"hash_39ff97d8d8a9a4cd", player, team, undefined, undefined);
  level thread popups::displayteammessagetoteam(#"hash_39ff97d8d8a9a4cd", player, otherteam, undefined, undefined);
  if(should_record_final_score_cam(otherteam, level.carryscore)) {}
  if(isDefined(player.var_6221f6f)) {
    player.var_6221f6f.inuse = 0;
  }
  ball = player.carryobject;
  ball.lastcarrierscored = 1;
  player gameobjects::take_carry_weapon(ball.carryweapon);
  ball ball_set_dropped(1);
  ball thread function_db6a152e(self);
  if(isDefined(player.pers[# "carries"])) {
    player.pers[# "carries"]++;
    player.carries = player.pers[# "carries"];
  }
  bb::function_9cca214a("ball_capture", undefined, team, player.origin);
  player recordgameevent("capture");
  player challenges::capturedobjective(gettime(), self.trigger);
  player stats::function_2dabbec7(#"carries", 1);
  player stats::function_2dabbec7(#"captures", 1);
  scoreevents::processscoreevent(#"hash_4d69456db152f5a5", player, undefined, undefined);
  ball_give_score(otherteam, level.carryscore);
}

function_dbf94d16(trigger) {
  visuals = [];
  visuals[0] = spawn("script_model", trigger.origin);
  visuals[0] setModel("wpn_t7_uplink_ball_world");
  visuals[0] notsolid();
  trigger enablelinkto();
  trigger linkto(visuals[0]);
  trigger.no_moving_platfrom_unlink = 1;
  var_afffeadd = gameobjects::create_carry_object(#"neutral", trigger, visuals, (0, 0, 0), # "ball_ball", "mpl_hit_alert_ballholder");
  var_afffeadd gameobjects::allow_carry(#"any");
  var_afffeadd gameobjects::set_visible_team(#"any");
  var_afffeadd gameobjects::set_drop_offset(8);
  var_afffeadd.usetime = 0;
  var_afffeadd.objectiveonvisuals = 1;
  var_afffeadd.allowweapons = 0;
  var_afffeadd.carryweapon = getweapon("ball");
  var_afffeadd.keepcarryweapon = 1;
  var_afffeadd.waterbadtrigger = 0;
  var_afffeadd.disallowremotecontrol = 1;
  var_afffeadd.disallowplaceablepickup = 1;
  var_afffeadd.var_9c48a02d = 0;
  var_afffeadd gameobjects::update_objective();
  var_afffeadd.canuseobject = & function_b861e1df;
  var_afffeadd.onpickup = & function_6ce143ff;
  var_afffeadd.setdropped = & ball_set_dropped;
  var_afffeadd.onreset = & function_df2611a2;
  var_afffeadd.pickuptimeoutoverride = & ball_physics_timeout;
  var_afffeadd.carryweaponthink = & function_804453f1;
  var_afffeadd.in_goal = 0;
  var_afffeadd.lastcarrierscored = 0;
  var_afffeadd.lastcarrierteam = # "neutral";
  if(level.enemycarriervisible == 2) {
    var_afffeadd.objidpingfriendly = 1;
  }
  if(level.idleflagreturntime > 0) {
    var_afffeadd.autoresettime = level.idleflagreturntime;
  } else {
    var_afffeadd.autoresettime = undefined;
  }
  playFXOnTag("ui/fx_uplink_ball_trail", var_afffeadd.visuals[0], "tag_origin");
  return var_afffeadd;
}

function_b861e1df(player) {
  if(!isDefined(player)) {
    return false;
  }
  if(isDefined(self.droptime) && self.droptime >= gettime()) {
    return false;
  }
  if(isDefined(player.resurrect_weapon) && player getcurrentweapon() == player.resurrect_weapon) {
    return false;
  }
  if(player iscarryingturret()) {
    return false;
  }
  currentweapon = player getcurrentweapon();
  if(isDefined(currentweapon)) {
    if(!valid_ball_pickup_weapon(currentweapon)) {
      return false;
    }
  }
  nextweapon = player.changingweapon;
  if(isDefined(nextweapon) && player isswitchingweapons()) {
    if(!valid_ball_pickup_weapon(nextweapon)) {
      return false;
    }
  }
  if(player player_no_pickup_time()) {
    return false;
  }
  ball = self.visuals[0];
  thresh = 15;
  dist2 = distance2dsquared(ball.origin, player.origin);
  if(dist2 < thresh * thresh) {
    return true;
  }
  start = player getEye();
  end = (self.curorigin[0], self.curorigin[1], self.curorigin[2] + 5);
  if(isDefined(ball)) {
    end = (ball.origin[0], ball.origin[1], ball.origin[2] + 5);
  }
  if(isDefined(self.carrier) && isplayer(self.carrier)) {
    end = self.carrier getEye();
  }
  first_skip_ent = ball;
  second_skip_ent = ball;
  if(isDefined(self.projectile)) {
    first_skip_ent = self.projectile;
  }
  if(isDefined(self.lastprojectile)) {
    second_skip_ent = self.lastprojectile;
  }
  if(!bullettracepassed(end, start, 0, first_skip_ent, second_skip_ent, 0, 0)) {
    player_origin = (player.origin[0], player.origin[1], player.origin[2] + 10);
    if(!bullettracepassed(end, player_origin, 0, first_skip_ent, second_skip_ent, 0, 0)) {
      return false;
    }
  }
  return true;
}

function_9e348528() {
  self.isresetting = 1;
  self notify(#"reset");
  origin = self.curorigin;
  if(isDefined(self.projectile)) {
    origin = self.projectile.origin;
  }
  foreach(visual in self.visuals) {
    visual.origin = origin;
    visual.angles = visual.baseangles;
    visual dontinterpolate();
    visual show();
  }
  if(isDefined(self.projectile)) {
    self.projectile delete();
    self.lastprojectile = undefined;
  }
  self gameobjects::clear_carrier();
  gameobjects::update_objective();
  self.isresetting = 0;
}

function_6ce143ff(player) {
  self gameobjects::set_flags(0);
  if(!isalive(player)) {
    self function_9e348528();
    return;
  }
  player disableusability();
  player disableoffhandweapons();
  level.usestartspawns = 0;
  level clientfield::set("ball_away", 1);
  linkedparent = self.visuals[0] getlinkedent();
  if(isDefined(linkedparent)) {
    self.visuals[0] unlink();
  }
  pass = 0;
  ball_velocity = 0;
  if(isDefined(self.projectile)) {
    pass = 1;
    ball_velocity = self.projectile getvelocity();
    self.projectile delete();
    self.lastprojectile = undefined;
  }
  if(pass) {
    if(self.lastcarrierteam == player.team) {
      if(self.lastcarrier != player) {
        player.passtime = gettime();
        player.passplayer = self.lastcarrier;
        globallogic_audio::leader_dialog("uplTransferred", player.team, undefined, "uplink_ball");
      }
    } else if(length(ball_velocity) > 0.1) {
      scoreevents::processscoreevent(#"hash_7fc37e28bad8da01", player, undefined, undefined);
    }
  }
  otherteam = util::getotherteam(player.team);
  if(self.lastcarrierteam != player.team) {
    globallogic_audio::leader_dialog("uplWeTake", player.team, undefined, "uplink_ball");
    globallogic_audio::leader_dialog("uplTheyTake", otherteam, undefined, "uplink_ball");
  }
  globallogic_audio::play_2d_on_team("mpl_ballget_sting_friend", player.team);
  globallogic_audio::play_2d_on_team("mpl_ballget_sting_enemy", otherteam);
  level thread popups::displayteammessagetoteam(#"hash_4b9c97939caa2b83", player, player.team, undefined, undefined);
  level thread popups::displayteammessagetoteam(#"hash_4b9c97939caa2b83", player, otherteam, undefined, undefined);
  self.lastcarrierscored = 0;
  self.lastcarrier = player;
  self.lastcarrierteam = player.team;
  self gameobjects::set_owner_team(player.team);
  player.balldropdelay = getdvarint(#"hash_104043b1855e0edb", 10);
  player.objective = 1;
  player.hasperksprintfire = player hasperk(#"specialty_sprintfire");
  player perks::perk_setperk("specialty_sprintfire");
  player clientfield::set("ballcarrier", 1);
  if(level.var_ef3abf3b > 0) {
    player thread armor::setlightarmor(level.var_ef3abf3b);
  } else {
    player thread armor::unsetlightarmor();
  }
  player thread player_update_pass_target(self);
  player recordgameevent("pickup");
}

ball_carrier_cleanup() {
  self gameobjects::set_owner_team(#"neutral");
  if(isDefined(self.carrier)) {
    self.carrier clientfield::set("ballcarrier", 0);
    self.carrier.balldropdelay = undefined;
    self.carrier.nopickuptime = gettime() + 500;
    self.carrier player_clear_pass_target();
    self.carrier notify(#"hash_50baa48224190ab1");
    self.carrier thread armor::unsetlightarmor();
    if(!self.carrier.hasperksprintfire) {
      self.carrier perks::perk_unsetperk("specialty_sprintfire");
    }
    self.carrier enableusability();
    self.carrier enableoffhandweapons();
    self.carrier setballpassallowed(0);
    self.carrier.objective = 0;
  }
}

ball_set_dropped(skip_physics = 0) {
  self.isresetting = 1;
  self.droptime = gettime();
  self notify(#"dropped");
  dropangles = (0, 0, 0);
  carrier = self.carrier;
  if(isDefined(carrier) && carrier.team != # "spectator") {
    droporigin = carrier.origin;
    dropangles = carrier.angles;
  } else {
    droporigin = self.origin;
  }
  if(!isDefined(droporigin)) {
    droporigin = self.safeorigin;
  }
  droporigin += (0, 0, 40);
  if(isDefined(self.projectile)) {
    self.projectile delete();
  }
  self.trigger triggerenable(1);
  self ball_carrier_cleanup();
  self gameobjects::clear_carrier();
  self gameobjects::set_position(droporigin, dropangles);
  self gameobjects::update_objective();
  self thread gameobjects::pickup_timeout(droporigin[2], droporigin[2] - 40);
  self.isresetting = 0;
  if(!skip_physics) {
    angles = (0, dropangles[1], 0);
    forward = anglesToForward(angles);
    velocity = forward * 200 + (0, 0, 80);
    ball_physics_launch(velocity);
  }
  return true;
}

function_df2611a2(prev_origin) {
  if(isDefined(level.gameended) && level.gameended) {
    return;
  }
  visual = self.visuals[0];
  linkedparent = visual getlinkedent();
  if(isDefined(linkedparent)) {
    visual unlink();
  }
  if(isDefined(self.projectile)) {
    self.projectile delete();
  }
  if(!self gameobjects::get_flags(1)) {
    playFX("ui/fx_uplink_ball_vanish", prev_origin);
    self function_6dc166ee();
  }
  self.lastcarrierteam = # "none";
  self thread function_7cd85c83();
  if(isDefined(self.killcament) && isentity(self.killcament)) {
    self.killcament recordgameeventnonplayer("ball_reset");
  }
}

function_98827162() {
  self thread gameobjects::return_home();
}

function_db6a152e(goal) {
  self notify(#"score_event");
  self.in_goal = 1;
  goal.ball_in_goal = 1;
  if(isDefined(self.projectile)) {
    self.projectile delete();
  }
  self gameobjects::allow_carry("none");
  var_c3f5985e = 0.4;
  var_55f7566e = 1.2;
  rotate_time = 1;
  var_85678934 = var_c3f5985e + rotate_time;
  total_time = var_85678934 + var_55f7566e;
  self gameobjects::set_flags(1);
  visual = self.visuals[0];
  visual moveto(goal.center, var_c3f5985e, 0, var_c3f5985e);
  visual rotatevelocity((1080, 1080, 0), total_time, total_time, 0);
  wait var_85678934;
  goal.ball_in_goal = 0;
  self.visibleteam = # "neutral";
  self gameobjects::update_objective();
  visual movez(4000, var_55f7566e, var_55f7566e * 0.1, 0);
  wait var_55f7566e;
  self thread gameobjects::return_home();
}

function_7cd85c83() {
  self endon(#"pickup_object");
  self gameobjects::allow_carry(#"any");
  self gameobjects::set_owner_team(#"neutral");
  self gameobjects::set_flags(2);
  self.trigger triggerenable(1);
  visual = self.visuals[0];
  visual.origin = visual.baseorigin + (0, 0, 4000);
  visual dontinterpolate();
  fall_time = 3;
  visual moveto(visual.baseorigin, fall_time, 0, fall_time);
  visual rotatevelocity((0, 720, 0), fall_time, 0, fall_time);
  self.visibleteam = # "any";
  self gameobjects::update_objective();
  wait fall_time;
  self gameobjects::set_flags(0);
  level clientfield::set("ball_away", 0);
  playFXOnTag("ui/fx_uplink_ball_trail", visual, "tag_origin");
  self thread ball_download_fx(visual, fall_time);
  self.in_goal = 0;
}

function_804453f1() {
  self endon(#"disconnect");
  self thread ball_pass_watch();
  self thread ball_shoot_watch();
  self thread ball_weapon_change_watch();
}

ball_pass_watch() {
  level endon(#"game_ended");
  self endon(#"disconnect");
  self endon(#"death");
  self endon(#"drop_object");
  while(true) {
    self waittill(#"ball_pass");
    if(!isDefined(self.pass_target)) {
      playerangles = self getplayerangles();
      playerangles = (math::clamp(playerangles[0], -85, 85), playerangles[1], playerangles[2]);
      dir = anglesToForward(playerangles);
      force = 90;
      self.carryobject thread ball_physics_launch_drop(dir * force, self);
      return;
    }
    break;
  }
  if(isDefined(self.carryobject)) {
    self thread ball_pass_or_throw_active();
    pass_target = self.pass_target;
    var_bd2ced7c = self.pass_target.origin;
    wait 0.15;
    if(isDefined(self.pass_target)) {
      pass_target = self.pass_target;
      self.carryobject thread ball_pass_projectile(self, pass_target, var_bd2ced7c);
      return;
    }
    playerangles = self getplayerangles();
    playerangles = (math::clamp(playerangles[0], -85, 85), playerangles[1], playerangles[2]);
    dir = anglesToForward(playerangles);
    force = 90;
    self.carryobject thread ball_physics_launch_drop(dir * force, self);
  }
}

ball_shoot_watch() {
  level endon(#"game_ended");
  self endon(#"disconnect");
  self endon(#"death");
  self endon(#"drop_object");
  extra_pitch = getdvarfloat(#"hash_32f162df04597db1", 0);
  force = getdvarfloat(#"hash_3bf51c45d887aa81", 900);
  while(true) {
    waitresult = self waittill(#"weapon_fired");
    if(waitresult.weapon != getweapon("ball")) {
      continue;
    }
    break;
  }
  if(isDefined(self.carryobject)) {
    playerangles = self getplayerangles();
    playerangles += (extra_pitch, 0, 0);
    playerangles = (math::clamp(playerangles[0], -85, 85), playerangles[1], playerangles[2]);
    dir = anglesToForward(playerangles);
    self thread ball_pass_or_throw_active();
    self thread ball_check_pass_kill_pickup(self.carryobject);
    self.carryobject ball_create_killcam_ent();
    self.carryobject thread ball_physics_launch_drop(dir * force, self, 1);
  }
}

ball_weapon_change_watch() {
  level endon(#"game_ended");
  self endon(#"disconnect");
  self endon(#"death");
  self endon(#"drop_object");
  ballweapon = getweapon("ball");
  while(true) {
    if(ballweapon == self getcurrentweapon()) {
      break;
    }
    self waittill(#"weapon_change");
  }
  while(true) {
    waitresult = self waittill(#"weapon_change");
    weapon = waitresult.weapon;
    lastweapon = waitresult.last_weapon;
    if(isDefined(weapon) && weapon.gadget_type == 11) {
      break;
    }
    if(weapon === level.weaponnone && lastweapon === ballweapon) {
      break;
    }
  }
  playerangles = self getplayerangles();
  playerangles = (math::clamp(playerangles[0], -85, 85), absangleclamp360(playerangles[1] + 20), playerangles[2]);
  dir = anglesToForward(playerangles);
  force = 90;
  self.carryobject thread ball_physics_launch_drop(dir * force, self);
}

valid_ball_pickup_weapon(weapon) {
  if(weapon == level.weaponnone) {
    return false;
  }
  if(weapon == getweapon("ball")) {
    return false;
  }
  if(killstreaks::is_killstreak_weapon(weapon)) {
    return false;
  }
  return true;
}

player_no_pickup_time() {
  return isDefined(self.nopickuptime) && self.nopickuptime > gettime();
}

function_40dff2cd(trigger) {
  self endon(#"death");
  self endon(#"disconnect");
  while(true) {
    if(self isplayerunderwater()) {
      foreach(ball in level.balls) {
        if(isDefined(ball.carrier) && ball.carrier == self) {
          ball gameobjects::set_dropped();
          return;
        }
      }
    }
    self.balldropdelay = undefined;
    waitframe(1);
  }
}

ball_physics_launch_drop(force, droppingplayer, switchweapon) {
  ball_set_dropped(1);
  ball_physics_launch(force, droppingplayer);
  if(isDefined(switchweapon) && switchweapon) {
    droppingplayer killstreaks::switch_to_last_non_killstreak_weapon(undefined, 1);
  }
}

ball_check_pass_kill_pickup(carryobj) {
  self endon(#"death");
  self endon(#"disconnect");
  carryobj endon(#"reset");
  timer = spawnStruct();
  timer endon(#"hash_2bdac9abebda1a73");
  timer thread timer_run(1.5);
  carryobj waittill(#"pickup_object");
  timer timer_cancel();
  if(!isDefined(carryobj.carrier) || carryobj.carrier.team == self.team) {
    return;
  }
  carryobj.carrier endon(#"disconnect");
  timer thread timer_run(5);
  waitresult = carryobj.carrier waittill(#"death");
  timer timer_cancel();
  if(!isDefined(waitresult.attacker) || waitresult.attacker != self) {
    return;
  }
  timer thread timer_run(2);
  carryobj waittill(#"pickup_object");
  timer timer_cancel();
}

timer_run(time) {
  self endon(#"hash_21bc609dcf55d28d");
  wait time;
  self notify(#"hash_2bdac9abebda1a73");
}

timer_cancel() {
  self notify(#"hash_21bc609dcf55d28d");
}

adjust_for_stance(ball) {
  target = self;
  target endon(#"hash_26d293fe725f742a");
  var_5fe7ebc7 = 0;
  while(isDefined(target) && isDefined(ball)) {
    var_e13766c7 = 50;
    switch (target getstance()) {
      case # "crouch":
        var_e13766c7 = 30;
        break;
      case # "prone":
        var_e13766c7 = 15;
        break;
    }
    if(var_e13766c7 != var_5fe7ebc7) {
      ball ballsettarget(target, (0, 0, var_e13766c7));
      var_e13766c7 = var_5fe7ebc7;
    }
    waitframe(1);
  }
}

ball_pass_projectile(var_c7e075bf, target, var_bd2ced7c) {
  ball_set_dropped(1);
  if(isDefined(target)) {
    var_bd2ced7c = target.origin;
  }
  offset = (0, 0, 60);
  if(target getstance() == "prone") {
    offset = (0, 0, 15);
  } else if(target getstance() == "crouch") {
    offset = (0, 0, 30);
  }
  playerangles = var_c7e075bf getplayerangles();
  playerangles = (0, playerangles[1], 0);
  dir = anglesToForward(playerangles);
  delta = dir * 50;
  origin = self.visuals[0].origin + delta;
  size = 5;
  trace = physicstrace(self.visuals[0].origin, origin, (size * -1, size * -1, size * -1), (size, size, size), var_c7e075bf, 1);
  if(trace[# "fraction"] < 1) {
    t = 0.7 * trace[# "fraction"];
    self gameobjects::set_position(self.visuals[0].origin + delta * t, self.visuals[0].angles);
  } else {
    self gameobjects::set_position(trace[# "position"], self.visuals[0].angles);
  }
  var_c23fae42 = vectornormalize(var_bd2ced7c + offset - self.visuals[0].origin);
  var_59ae0bde = var_c23fae42 * 850;
  self.lastprojectile = self.projectile;
  self.projectile = var_c7e075bf magicmissile(level.var_aff3334d, self.visuals[0].origin, var_59ae0bde);
  target thread adjust_for_stance(self.projectile);
  self.visuals[0] linkto(self.projectile);
  self gameobjects::ghost_visuals();
  self ball_create_killcam_ent();
  self ball_clear_contents();
  self thread ball_on_projectile_hit_client(var_c7e075bf);
  self thread ball_on_projectile_death();
  self thread function_859e9fab();
  var_c7e075bf killstreaks::switch_to_last_non_killstreak_weapon(undefined, 1);
}

ball_on_projectile_death() {
  self.projectile waittill(#"death");
  ball = self.visuals[0];
  if(!isDefined(self.carrier) && !self.in_goal) {
    if(ball.origin != ball.baseorigin + (0, 0, 4000)) {
      self ball_physics_launch((0, 0, 10));
    }
  }
  self ball_restore_contents();
  ball notify(#"hash_26d293fe725f742a");
}

ball_restore_contents() {
  if(isDefined(self.visuals[0].var_f8f65741)) {
    self.visuals[0] setcontents(self.visuals[0].var_f8f65741);
    self.visuals[0].var_f8f65741 = undefined;
  }
}

ball_on_projectile_hit_client(var_c7e075bf) {
  self endon(#"hash_26d293fe725f742a");
  waitresult = self.projectile waittill(#"projectile_impact_player");
  self.trigger notify(#"trigger", {
    #activator: waitresult.player
  });
  self.projectile notify(#"hash_75f1178d8e4da23c");
  if(isDefined(var_c7e075bf)) {
    var_c7e075bf recordgameevent("pass");
  }
}

ball_clear_contents() {
  self.visuals[0].var_f8f65741 = self.visuals[0] setcontents(0);
}

ball_create_killcam_ent() {
  if(isDefined(self.killcament)) {
    self.killcament delete();
  }
  self.killcament = spawn("script_model", self.visuals[0].origin);
  self.killcament linkto(self.visuals[0]);
  self.killcament setcontents(0);
}

ball_pass_or_throw_active() {
  self endon(#"death");
  self endon(#"disconnect");
  self.pass_or_throw_active = 1;
  self allowmelee(0);
  while(getweapon("ball") == self getcurrentweapon()) {
    waitframe(1);
  }
  self allowmelee(1);
  self.pass_or_throw_active = 0;
}

ball_download_fx(var_7ee2b1c, waittime) {
  self.scorefrozenuntil = 0;
}

function_2635f289() {
  var_8f2a0684 = undefined;
  var_c9003254 = array::randomize(level.ball_starts);
  foreach(start in var_c9003254) {
    if(start.in_use) {
      continue;
    }
    var_8f2a0684 = start;
    break;
  }
  if(!isDefined(var_8f2a0684)) {
    return;
  }
  ball_assign_start(var_8f2a0684);
}

ball_assign_start(start) {
  foreach(vis in self.visuals) {
    vis.baseorigin = start.origin;
  }
  self.trigger.baseorigin = start.origin;
  self.current_start = start;
  start.in_use = 1;
}

ball_physics_launch(force, droppingplayer) {
  visuals = self.visuals[0];
  visuals.origin_prev = undefined;
  origin = visuals.origin;
  owner = visuals;
  if(isDefined(droppingplayer)) {
    owner = droppingplayer;
    origin = droppingplayer getweaponmuzzlepoint();
    right = anglestoright(force);
    origin += (right[0], right[1], 0) * 7;
    startpos = origin;
    delta = vectornormalize(force) * 80;
    size = 5;
    trace = physicstrace(startpos, startpos + delta, (size * -1, size * -1, size * -1), (size, size, size), droppingplayer, 1);
    if(trace[# "fraction"] < 1) {
      t = 0.7 * trace[# "fraction"];
      self gameobjects::set_position(startpos + delta * t, visuals.angles);
    } else {
      self gameobjects::set_position(trace[# "position"], visuals.angles);
    }
  }
  grenade = owner magicmissile(level.var_d566bdba, visuals.origin, force);
  visuals linkto(grenade);
  self gameobjects::ghost_visuals();
  self.lastprojectile = self.projectile;
  self.projectile = grenade;
  visuals dontinterpolate();
  self thread ball_physics_out_of_level();
  self thread function_859e9fab();
  self thread ball_physics_touch_cant_pickup_player(droppingplayer);
  self thread function_96acd1aa();
}

function_96acd1aa() {
  self endon(#"reset");
  self endon(#"pickup_object");
  visual = self.visuals[0];
  while(true) {
    var_4fca0920 = isDefined(self.in_goal) && self.in_goal || isDefined(self.isresetting) && self.isresetting;
    if(!var_4fca0920) {
      if(visual oob::istouchinganyoobtrigger() || visual function_b2a406b0() || self gameobjects::should_be_reset(visual.origin[2], visual.origin[2] + 10)) {
        self function_98827162();
        return;
      }
    }
    waitframe(1);
  }
}

ball_physics_touch_cant_pickup_player(droppingplayer) {
  self endon(#"reset");
  self endon(#"pickup_object");
  ball = self.visuals[0];
  trigger = self.trigger;
  while(true) {
    waitresult = trigger waittill(#"trigger");
    player = waitresult.activator;
    if(isDefined(droppingplayer) && droppingplayer == player && player player_no_pickup_time()) {
      continue;
    }
    if(self.droptime >= gettime()) {
      continue;
    }
    if(ball.origin == ball.baseorigin + (0, 0, 4000)) {
      continue;
    }
  }
}

ball_physics_fake_bounce() {
  ball = self.visuals[0];
  vel = ball getvelocity();
  bounceforce = length(vel) / 10;
  var_553a55d2 = -1 * vectornormalize(vel);
}

function_859e9fab() {
  self endon(#"reset");
  self endon(#"pickup_object");
  var_a75918ba = level.ball_goals[util::getotherteam(self.lastcarrierteam)];
  while(true) {
    if(!var_a75918ba function_ce3bd9c9()) {
      waitframe(1);
      continue;
    }
    var_c64dfe9a = self.visuals[0];
    distsq = distancesquared(var_c64dfe9a.origin, var_a75918ba.center);
    if(distsq <= var_a75918ba.radiussq) {
      self thread ball_touched_goal(var_a75918ba);
      return;
    }
    if(isDefined(var_c64dfe9a.origin_prev)) {
      result = function_12bbc0ef(var_c64dfe9a.origin_prev, var_c64dfe9a.origin, var_a75918ba.center, var_a75918ba.trigger.radius);
      if(result) {
        self thread ball_touched_goal(var_a75918ba);
        return;
      }
    }
    waitframe(1);
  }
}

function_12bbc0ef(line_start, line_end, var_494a9d56, sphere_radius) {
  dir = vectornormalize(line_end - line_start);
  a = vectordot(dir, line_start - var_494a9d56);
  a *= a;
  b = line_start - var_494a9d56;
  b *= b;
  c = sphere_radius * sphere_radius;
  return a - b + c >= 0;
}

ball_touched_goal(goal) {
  if(isDefined(self.claimplayer)) {
    return;
  }
  if(isDefined(self.scorefrozenuntil) && self.scorefrozenuntil > gettime()) {
    return;
  }
  self gameobjects::allow_carry("none");
  goal function_85e74fc9();
  self.scorefrozenuntil = gettime() + 10000;
  team = goal.team;
  otherteam = util::getotherteam(team);
  globallogic_audio::flush_objective_dialog("uplink_ball");
  globallogic_audio::leader_dialog("uplWeUplinkRemote", otherteam);
  globallogic_audio::leader_dialog("uplTheyUplinkRemote", team);
  globallogic_audio::play_2d_on_team("mpl_ballcapture_sting_friend", otherteam);
  globallogic_audio::play_2d_on_team("mpl_ballcapture_sting_enemy", team);
  if(isDefined(self.lastcarrier)) {
    level thread popups::displayteammessagetoteam(#"hash_39ff97d8d8a9a4cd", self.lastcarrier, team, undefined, undefined);
    level thread popups::displayteammessagetoteam(#"hash_39ff97d8d8a9a4cd", self.lastcarrier, otherteam, undefined, undefined);
    if(isDefined(self.lastcarrier.pers[# "throws"])) {
      self.lastcarrier.pers[# "throws"]++;
      self.lastcarrier.throws = self.lastcarrier.pers[# "throws"];
    }
    bb::function_9cca214a("ball_throw", undefined, team, self.lastcarrier.origin);
    self.lastcarrier recordgameevent("throw");
    self.lastcarrier stats::function_2dabbec7(#"throws", 1);
    scoreevents::processscoreevent(#"hash_68634aca4e3c1ae6", self.lastcarrier, undefined, undefined);
    self.lastcarrierscored = 1;
    ball_check_assist(self.lastcarrier, 0);
    if(isDefined(self.killcament) && should_record_final_score_cam(otherteam, level.throwscore)) {}
    self.lastcarrier challenges::capturedobjective(gettime(), self.trigger);
    self.lastcarrier stats::function_2dabbec7(#"captures", 1);
  }
  if(isDefined(self.killcament)) {
    self.killcament unlink();
  }
  self thread function_db6a152e(goal);
  ball_give_score(otherteam, level.throwscore);
}

ball_give_score(team, score) {
  level globallogic_score::giveteamscoreforobjective(team, score);
  if(overtime::is_overtime_round()) {
    if(game.overtime_round == 1) {
      return;
    }
    if(game.overtime_first_winner === team) {
      round::set_winner(team);
      thread globallogic::end_round(2);
    }
    team_score = [[level._getteamscore]](team);
    var_c97a682c = [[level._getteamscore]](util::getotherteam(team));
  }
}

should_record_final_score_cam(team, var_6db4572f) {
  team_score = [[level._getteamscore]](team);
  var_c97a682c = [[level._getteamscore]](util::getotherteam(team));
  return team_score + var_6db4572f >= var_c97a682c;
}

ball_check_assist(player, var_84a3cadc) {
  if(!isDefined(player.passtime) || !isDefined(player.passplayer)) {
    return;
  }
  if(player.passtime + 3000 < gettime()) {
    return;
  }
  scoreevents::processscoreevent(#"hash_7ad353dbba2f7dd9", player.passplayer, undefined, undefined);
}

ball_physics_timeout() {
  self endon(#"reset");
  self endon(#"pickup_object");
  self endon(#"score_event");
  if(isDefined(self.autoresettime) && self.autoresettime > 15) {
    var_394347f7 = self.autoresettime;
  } else {
    var_394347f7 = 15;
  }
  if(isDefined(self.projectile)) {
    var_2615ab42 = self.projectile waittilltimeout(var_394347f7, # "stationary");
    if(!isDefined(var_2615ab42)) {
      return;
    }
    if(var_2615ab42._notify == "stationary") {
      if(isDefined(self.autoresettime)) {
        wait self.autoresettime;
      }
    }
  }
  self function_98827162();
}

ball_physics_out_of_level() {
  self endon(#"reset");
  self endon(#"pickup_object");
  ball = self.visuals[0];
  self waittill(#"hash_5829091f4e894fdd");
  self function_98827162();
}

player_update_pass_target(var_afffeadd) {
  self notify(#"hash_24f54127bdf7334");
  self endon(#"hash_24f54127bdf7334");
  self endon(#"disconnect");
  self endon(#"hash_50baa48224190ab1");
  test_dot = 0.8;
  while(true) {
    new_target = undefined;
    if(!self isonladder()) {
      playerdir = anglesToForward(self getplayerangles());
      playereye = self getEye();
      var_9ee2cc0f = [];
      foreach(target in level.players) {
        if(self == target) {
          continue;
        }
        if(target.team != self.team) {
          continue;
        }
        if(!isalive(target)) {
          continue;
        }
        if(!var_afffeadd gameobjects::can_interact_with(target)) {
          continue;
        }
        targeteye = target getEye();
        distsq = distancesquared(targeteye, playereye);
        if(distsq > 1000000) {
          continue;
        }
        dirtotarget = vectornormalize(targeteye - playereye);
        dot = vectordot(playerdir, dirtotarget);
        if(dot > test_dot) {
          target.pass_dot = dot;
          target.var_4e7a846b = targeteye;
          var_9ee2cc0f[var_9ee2cc0f.size] = target;
        }
      }
      var_9ee2cc0f = array::quick_sort(var_9ee2cc0f, & compare_player_pass_dot);
      foreach(target in var_9ee2cc0f) {
        if(sighttracepassed(playereye, target.var_4e7a846b, 0, target)) {
          new_target = target;
          break;
        }
      }
    }
    self player_set_pass_target(new_target);
    waitframe(1);
  }
}

function_6dc166ee() {
  foreach(team, _ in level.teams) {
    globallogic_audio::play_2d_on_team("mpl_ballreturn_sting", team);
    globallogic_audio::leader_dialog("uplReset", team, undefined, "uplink_ball");
  }
}

compare_player_pass_dot(left, right) {
  return left.pass_dot >= right.pass_dot;
}

player_set_pass_target(new_target) {
  if(isDefined(self.pass_target) && isDefined(new_target) && self.pass_target == new_target) {
    return;
  }
  if(!isDefined(self.pass_target) && !isDefined(new_target)) {
    return;
  }
  self player_clear_pass_target();
  if(isDefined(new_target)) {
    offset = (0, 0, 80);
    new_target clientfield::set("passoption", 1);
    self.pass_target = new_target;
    team_players = [];
    foreach(player in level.players) {
      if(player.team == self.team && player != self && player != new_target) {
        team_players[team_players.size] = player;
      }
    }
    self setballpassallowed(1);
  }
}

player_clear_pass_target() {
  team_players = [];
  foreach(player in level.players) {
    if(player.team == self.team && player != self) {
      team_players[team_players.size] = player;
    }
  }
  if(isDefined(self.pass_target)) {
    self.pass_target clientfield::set("passoption", 0);
  }
  self.pass_target = undefined;
  self setballpassallowed(0);
}

function_5fa54274(var_c713c3d7) {
  ball_starts = getEntArray("ball_start", "targetname");
  ball_starts = array::randomize(ball_starts);
  foreach(var_8f2a0684 in ball_starts) {
    function_d6b63e51(var_8f2a0684.origin);
  }
  var_4e6825b2 = 30;
  if(ball_starts.size == 0) {
    origin = level.default_ball_origin;
    if(!isDefined(origin)) {
      origin = (0, 0, 0);
    }
    function_d6b63e51(origin);
  }
  var_7adceb37 = var_c713c3d7 - level.ball_starts.size;
  if(var_7adceb37 <= 0) {
    return;
  }
  default_start = level.ball_starts[0].origin;
  var_69e0d43d = getnodesinradius(default_start, 200, 20, 50);
  var_69e0d43d = array::randomize(var_69e0d43d);
  for(i = 0; i < var_7adceb37 && i < var_69e0d43d.size; i++) {
    function_d6b63e51(var_69e0d43d[i].origin);
  }
}

function_d6b63e51(origin) {
  var_46cb7098 = 30;
  var_8f2a0684 = spawnStruct();
  var_8f2a0684.origin = origin;
  var_8f2a0684 function_22c4dbca();
  var_8f2a0684.origin = var_8f2a0684.ground_origin + (0, 0, var_46cb7098);
  var_8f2a0684.in_use = 0;
  level.ball_starts[level.ball_starts.size] = var_8f2a0684;
}

function_22c4dbca(z_offset) {
  tracestart = self.origin + (0, 0, 32);
  traceend = self.origin + (0, 0, -1000);
  trace = bulletTrace(tracestart, traceend, 0, undefined);
  self.ground_origin = trace[# "position"];
  return trace[# "fraction"] != 0 && trace[# "fraction"] != 1;
}

function_edcdea6d(team) {
  switch (team) {
    case # "allies":
      return "ball_score_allies";
    case # "axis":
      return "ball_score_axis";
  }
  return undefined;
}

function_85e74fc9() {
  key = function_edcdea6d(self.team);
  level clientfield::set(key, !level clientfield::get(key));
}

function_b2a406b0() {
  if(!isDefined(level.var_665382a2)) {
    return 0;
  }
  var_41383ff5 = [];
  result = 0;
  foreach(trigger in level.var_665382a2) {
    if(!isDefined(trigger)) {
      if(!isDefined(var_41383ff5)) {
        var_41383ff5 = [];
      } else if(!isarray(var_41383ff5)) {
        var_41383ff5 = array(var_41383ff5);
      }
      var_41383ff5[var_41383ff5.size] = trigger;
      continue;
    }
    if(!trigger istriggerenabled()) {
      continue;
    }
    if(self istouching(trigger)) {
      result = 1;
      break;
    }
  }
  foreach(trigger in var_41383ff5) {
    arrayremovevalue(level.var_665382a2, trigger);
  }
  var_41383ff5 = [];
  var_41383ff5 = undefined;
  return result;
}