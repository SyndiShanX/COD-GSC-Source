/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\ball.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_shoutcaster;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\util_shared;
#namespace ball;

function main() {
  clientfield::register("allplayers", "ballcarrier", 1, 1, "int", & player_ballcarrier_changed, 0, 1);
  clientfield::register("allplayers", "passoption", 1, 1, "int", & player_passoption_changed, 0, 0);
  clientfield::register("world", "ball_away", 1, 1, "int", & world_ball_away_changed, 0, 1);
  clientfield::register("world", "ball_score_allies", 1, 1, "int", & world_ball_score_allies, 0, 1);
  clientfield::register("world", "ball_score_axis", 1, 1, "int", & world_ball_score_axis, 0, 1);
  callback::on_localclient_connect( & on_localclient_connect);
  callback::on_spawned( & on_player_spawned);
  if(!getdvarint("tu11_programaticallyColoredGameFX")) {
    level.effect_scriptbundles = [];
    level.effect_scriptbundles["goal"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_uplink_goal");
    level.effect_scriptbundles["goal_score"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_uplink_goal_score");
  }
}

function on_localclient_connect(localclientnum) {
  objective_ids = [];
  while (!isdefined(objective_ids["allies"])) {
    objective_ids["allies"] = serverobjective_getobjective(localclientnum, "ball_goal_allies");
    objective_ids["axis"] = serverobjective_getobjective(localclientnum, "ball_goal_axis");
    wait(0.05);
  }
  foreach(key, objective in objective_ids) {
    level.goals[key] = spawnstruct();
    level.goals[key].objectiveid = objective;
    setup_goal(localclientnum, level.goals[key]);
  }
  setup_fx(localclientnum);
}

function on_player_spawned(localclientnum) {
  players = getplayers(localclientnum);
  foreach(player in players) {
    if(player util::isenemyplayer(self)) {
      player duplicate_render::update_dr_flag(localclientnum, "ballcarrier", 0);
    }
  }
}

function setup_goal(localclientnum, goal) {
  goal.origin = serverobjective_getobjectiveorigin(localclientnum, goal.objectiveid);
  goal_entity = serverobjective_getobjectiveentity(localclientnum, goal.objectiveid);
  if(isdefined(goal_entity)) {
    goal.origin = goal_entity.origin;
  }
  goal.team = serverobjective_getobjectiveteam(localclientnum, goal.objectiveid);
}

function setup_goal_fx(localclientnum, goal, effects) {
  if(isdefined(goal.base_fx)) {
    stopfx(localclientnum, goal.base_fx);
  }
  goal.base_fx = playfx(localclientnum, effects[goal.team], goal.origin);
  setfxteam(localclientnum, goal.base_fx, goal.team);
}

function setup_fx(localclientnum) {
  effects = [];
  if(shoutcaster::is_shoutcaster_using_team_identity(localclientnum)) {
    if(getdvarint("tu11_programaticallyColoredGameFX")) {
      effects["allies"] = "ui/fx_uplink_goal_marker_white";
      effects["axis"] = "ui/fx_uplink_goal_marker_white";
    } else {
      effects = shoutcaster::get_color_fx(localclientnum, level.effect_scriptbundles["goal"]);
    }
  } else {
    effects["allies"] = "ui/fx_uplink_goal_marker";
    effects["axis"] = "ui/fx_uplink_goal_marker";
  }
  foreach(goal in level.goals) {
    thread setup_goal_fx(localclientnum, goal, effects);
    thread resetondemojump(localclientnum, goal, effects);
  }
  thread watch_for_team_change(localclientnum);
}

function play_score_fx(localclientnum, goal) {
  effects = [];
  if(shoutcaster::is_shoutcaster_using_team_identity(localclientnum)) {
    if(getdvarint("tu11_programaticallyColoredGameFX")) {
      effects["allies"] = "ui/fx_uplink_goal_marker_white_flash";
      effects["axis"] = "ui/fx_uplink_goal_marker_white_flash";
    } else {
      effects = shoutcaster::get_color_fx(localclientnum, level.effect_scriptbundles["goal_score"]);
    }
  } else {
    effects["allies"] = "ui/fx_uplink_goal_marker_flash";
    effects["axis"] = "ui/fx_uplink_goal_marker_flash";
  }
  fx_handle = playfx(localclientnum, effects[goal.team], goal.origin);
  setfxteam(localclientnum, fx_handle, goal.team);
}

function play_goal_score_fx(localclientnum, team, oldval, newval, binitialsnap, bwastimejump) {
  if(newval != oldval && !binitialsnap && !bwastimejump) {
    play_score_fx(localclientnum, level.goals[team]);
  }
}

function world_ball_score_allies(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  play_goal_score_fx(localclientnum, "allies", oldval, newval, binitialsnap, bwastimejump);
}

function world_ball_score_axis(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  play_goal_score_fx(localclientnum, "axis", oldval, newval, binitialsnap, bwastimejump);
}

function player_ballcarrier_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  localplayer = getlocalplayer(localclientnum);
  if(localplayer == self) {
    if(newval) {
      self._hasball = 1;
    } else {
      self._hasball = 0;
      setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.passOption"), 0);
    }
  }
  if(localplayer != self && self isfriendly(localclientnum)) {
    self set_player_ball_carrier_dr(localclientnum, newval);
  } else {
    self set_player_ball_carrier_dr(localclientnum, 0);
  }
  if(isdefined(level.ball_carrier) && level.ball_carrier != self) {
    return;
  }
  level notify("watch_for_death");
  if(newval == 1) {
    self thread watch_for_death(localclientnum);
  }
}

function set_hud(localclientnum) {
  level.ball_carrier = self;
  if(shoutcaster::is_shoutcaster(localclientnum)) {
    friendly = self shoutcaster::is_friendly(localclientnum);
  } else {
    friendly = self isfriendly(localclientnum);
  }
  if(isdefined(self.name)) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), self.name);
  } else {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), "");
  }
  if(isdefined(friendly)) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByFriendly"), friendly);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByEnemy"), !friendly);
  } else {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByFriendly"), 0);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByEnemy"), 0);
  }
}

function clear_hud(localclientnum) {
  level.ball_carrier = undefined;
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByEnemy"), 0);
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByFriendly"), 0);
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), & "MPUI_BALL_AWAY");
}

function watch_for_death(localclientnum) {
  level endon("watch_for_death");
  self waittill("entityshutdown");
}

function player_passoption_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  localplayer = getlocalplayer(localclientnum);
  if(localplayer != self && self isfriendly(localclientnum)) {
    if(isdefined(localplayer._hasball) && localplayer._hasball) {
      setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.passOption"), newval);
    }
  }
}

function world_ball_away_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballAway"), newval);
}

function set_player_ball_carrier_dr(localclientnum, on_off) {
  self duplicate_render::update_dr_flag(localclientnum, "ballcarrier", on_off);
}

function set_player_pass_option_dr(localclientnum, on_off) {
  self duplicate_render::update_dr_flag(localclientnum, "passoption", on_off);
}

function resetondemojump(localclientnum, goal, effects) {
  for (;;) {
    level waittill("demo_jump" + localclientnum);
    setup_goal_fx(localclientnum, goal, effects);
  }
}

function watch_for_team_change(localclientnum) {
  level notify("end_team_change_watch");
  level endon("end_team_change_watch");
  level waittill("team_changed");
  thread setup_fx(localclientnum);
}