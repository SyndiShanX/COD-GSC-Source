/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_ball.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_weapons;
#namespace ball;

function autoexec __init__sytem__() {
  system::register("ball", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("allplayers", "ballcarrier", 15000, 1, "int", &player_ballcarrier_changed, 0, 1);
  clientfield::register("allplayers", "passoption", 15000, 1, "int", &player_passoption_changed, 0, 0);
  clientfield::register("world", "ball_away", 15000, 1, "int", &world_ball_away_changed, 0, 1);
  clientfield::register("world", "ball_score_allies", 15000, 1, "int", &world_ball_score_allies, 0, 1);
  clientfield::register("world", "ball_score_axis", 15000, 1, "int", &world_ball_score_axis, 0, 1);
  clientfield::register("scriptmover", "ball_on_ground_fx", 15000, 1, "int", &ball_on_ground_fx, 0, 0);
  callback::on_localclient_connect(&on_localclient_connect);
  callback::on_spawned(&on_player_spawned);
  level.effect_scriptbundles = [];
  level.effect_scriptbundles["goal"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_uplink_goal");
  level.effect_scriptbundles["goal_score"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_uplink_goal_score");
  level._effect["ball_on_ground"] = "dlc1/skyjacked/fx_light_blue_flashing_md_02";
  level._effect["balllight_fx"] = "dlc4/genesis/fx_summoningkey_light_loop";
  level._effect["lght_marker"] = "zombie/fx_weapon_box_marker_zmb";
}

function on_localclient_connect(localclientnum) {
  objective_ids = [];
  while(!isDefined(objective_ids["allies"])) {
    objective_ids["allies"] = serverobjective_getobjective(localclientnum, "ball_goal_allies");
    objective_ids["axis"] = serverobjective_getobjective(localclientnum, "ball_goal_axis");
    wait(0.05);
  }
  foreach(key, objective in objective_ids) {
    level.goals[key] = spawnStruct();
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
  if(isDefined(goal_entity)) {
    goal.origin = goal_entity.origin;
  }
  goal.team = serverobjective_getobjectiveteam(localclientnum, goal.objectiveid);
}

function setup_goal_fx(localclientnum, goal, effects) {
  if(isDefined(goal.base_fx)) {
    stopfx(localclientnum, goal.base_fx);
  }
  goal.base_fx = playFX(localclientnum, effects[goal.team], goal.origin);
  setfxteam(localclientnum, goal.base_fx, goal.team);
}

function setup_fx(localclientnum) {
  effects = [];
  effects["allies"] = "ui/fx_uplink_goal_marker";
  effects["axis"] = "ui/fx_uplink_goal_marker";
  foreach(goal in level.goals) {}
  thread watch_for_team_change(localclientnum);
}

function play_score_fx(localclientnum, goal) {
  effects = [];
  effects["allies"] = "ui/fx_uplink_goal_marker_flash";
  effects["axis"] = "ui/fx_uplink_goal_marker_flash";
  fx_handle = playFX(localclientnum, effects[goal.team], goal.origin);
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
  if(isDefined(level.ball_carrier) && level.ball_carrier != self) {
    return;
  }
  level notify("watch_for_death");
  if(newval == 1) {
    self thread watch_for_death(localclientnum);
  }
}

function set_hud(localclientnum) {
  level.ball_carrier = self;
  friendly = self isfriendly(localclientnum);
  if(isDefined(self.name)) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), self.name);
  } else {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), "");
  }
  if(isDefined(friendly)) {
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
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), &"MPUI_BALL_AWAY");
}

function watch_for_death(localclientnum) {
  level endon("watch_for_death");
  self waittill("entityshutdown");
}

function player_passoption_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  localplayer = getlocalplayer(localclientnum);
  if(localplayer != self && self isfriendly(localclientnum)) {
    if(isDefined(localplayer._hasball) && localplayer._hasball) {
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
  for(;;) {
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

function ball_on_ground_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(!isDefined(self.var_ff242ed4)) {
      self.var_ff242ed4 = playFX(localclientnum, level._effect["ball_on_ground"], self.origin + vectorscale((0, 0, 1), 72), (0, 0, 1), (1, 0, 0));
    }
    if(!isDefined(self.var_cd030ed9)) {
      self.var_cd030ed9 = playFX(localclientnum, level._effect["balllight_fx"], self.origin + vectorscale((0, 0, 1), 72), (0, 0, 1), (1, 0, 0));
    }
    if(!isDefined(self.var_2e7f5bfb)) {
      self.var_2e7f5bfb = playFX(localclientnum, level._effect["lght_marker"], self.origin + vectorscale((0, 0, 1), 72), (0, 0, 1), (1, 0, 0));
    }
  } else {
    if(isDefined(self.var_ff242ed4)) {
      stopfx(localclientnum, self.var_ff242ed4);
      self.var_ff242ed4 = undefined;
    }
    if(isDefined(self.var_cd030ed9)) {
      stopfx(localclientnum, self.var_cd030ed9);
      self.var_cd030ed9 = undefined;
    }
    if(isDefined(self.var_2e7f5bfb)) {
      stopfx(localclientnum, self.var_2e7f5bfb);
      self.var_2e7f5bfb = undefined;
    }
  }
}