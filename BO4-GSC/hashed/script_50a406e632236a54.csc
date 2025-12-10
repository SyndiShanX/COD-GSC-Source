/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_50a406e632236a54.csc
***********************************************/

#using script_354f0cf6dd1c85c4;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\duplicaterender_mgr;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace ball;

event_handler[gametype_init] main(eventstruct) {
  clientfield::register("allplayers", "ballcarrier", 1, 1, "int", &function_5354f213, 0, 1);
  clientfield::register("allplayers", "passoption", 1, 1, "int", &function_8dc589c8, 0, 0);
  clientfield::register("world", "ball_away", 1, 1, "int", &function_c27acbbf, 0, 1);
  clientfield::register("world", "ball_score_allies", 1, 1, "int", &function_fe891abf, 0, 1);
  clientfield::register("world", "ball_score_axis", 1, 1, "int", &function_7d1a6e7e, 0, 1);
  callback::on_localclient_connect(&on_localclient_connect);
  callback::on_spawned(&on_player_spawned);
  if(!getdvarint(#"tu11_programaticallycoloredgamefx", 0)) {
    level.effect_scriptbundles = [];
    level.effect_scriptbundles[# "goal"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_uplink_goal");
    level.effect_scriptbundles[# "hash_141412a5485af87"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_uplink_goal_score");
  }
}

on_localclient_connect(localclientnum) {
  var_1d2359d9 = [];
  while(!isDefined(var_1d2359d9[# "allies"])) {
    var_1d2359d9[# "allies"] = serverobjective_getobjective(localclientnum, "ball_goal_allies");
    var_1d2359d9[# "axis"] = serverobjective_getobjective(localclientnum, "ball_goal_axis");
    waitframe(1);
  }
  foreach(key, objective in var_1d2359d9) {
    level.goals[key] = spawnStruct();
    level.goals[key].objectiveid = objective;
    function_b22de10a(localclientnum, level.goals[key]);
  }
  function_45876c81(localclientnum);
}

on_player_spawned(localclientnum) {
  players = getplayers(localclientnum);
  foreach(player in players) {
    if(player util::isenemyplayer(self)) {
      player duplicate_render::update_dr_flag(localclientnum, "ballcarrier", 0);
    }
  }
}

function_b22de10a(localclientnum, goal) {
  goal.origin = serverobjective_getobjectiveorigin(localclientnum, goal.objectiveid);
  var_ecb500c6 = serverobjective_getobjectiveentity(localclientnum, goal.objectiveid);
  if(isDefined(var_ecb500c6)) {
    goal.origin = var_ecb500c6.origin;
  }
  goal.team = serverobjective_getobjectiveteam(localclientnum, goal.objectiveid);
}

function_2182aedf(localclientnum, goal, effects) {
  if(isDefined(goal.base_fx)) {
    stopfx(localclientnum, goal.base_fx);
  }
  goal.base_fx = playFX(localclientnum, effects[goal.team], goal.origin);
  setfxteam(localclientnum, goal.base_fx, goal.team);
}

function_45876c81(localclientnum) {
  effects = [];
  if(shoutcaster::is_shoutcaster_using_team_identity(localclientnum)) {
    if(getdvarint(#"tu11_programaticallycoloredgamefx", 0)) {
      effects[# "allies"] = "ui/fx_uplink_goal_marker";
      effects[# "axis"] = "ui/fx_uplink_goal_marker";
    } else {
      effects = shoutcaster::get_color_fx(localclientnum, level.effect_scriptbundles[# "goal"]);
    }
  } else {
    effects[# "allies"] = "ui/fx_uplink_goal_marker";
    effects[# "axis"] = "ui/fx_uplink_goal_marker";
  }
  foreach(goal in level.goals) {
    thread function_2182aedf(localclientnum, goal, effects);
    thread resetondemojump(localclientnum, goal, effects);
  }
  thread watch_for_team_change(localclientnum);
}

function_ea2fff95(localclientnum, goal) {
  effects = [];
  if(shoutcaster::is_shoutcaster_using_team_identity(localclientnum)) {
    if(getdvarint(#"tu11_programaticallycoloredgamefx", 0)) {
      effects[# "allies"] = "ui/fx_uplink_goal_marker_flash";
      effects[# "axis"] = "ui/fx_uplink_goal_marker_flash";
    } else {
      effects = shoutcaster::get_color_fx(localclientnum, level.effect_scriptbundles[# "hash_141412a5485af87"]);
    }
  } else {
    effects[# "allies"] = "ui/fx_uplink_goal_marker_flash";
    effects[# "axis"] = "ui/fx_uplink_goal_marker_flash";
  }
  fx_handle = playFX(localclientnum, effects[goal.team], goal.origin);
  setfxteam(localclientnum, fx_handle, goal.team);
}

function_85e74fc9(localclientnum, team, oldval, newval, binitialsnap, bwastimejump) {
  if(newval != oldval && !binitialsnap && !bwastimejump) {
    function_ea2fff95(localclientnum, level.goals[team]);
  }
}

function_fe891abf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_85e74fc9(localclientnum, # "allies", oldval, newval, binitialsnap, bwastimejump);
}

function_7d1a6e7e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_85e74fc9(localclientnum, # "axis", oldval, newval, binitialsnap, bwastimejump);
}

function_5354f213(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self function_60dbc438()) {
    if(newval) {
      self.var_25281d17 = 1;
    } else {
      self.var_25281d17 = 0;
      setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.passOption"), 0);
    }
  } else if(self function_55a8b32b()) {
    self function_235fe967(localclientnum, newval);
  } else {
    self function_235fe967(localclientnum, 0);
  }
  if(isDefined(level.var_300a2507) && level.var_300a2507 != self) {
    return;
  }
  level notify(#"watch_for_death");
  if(newval == 1) {
    self thread watch_for_death(localclientnum);
  }
}

function_b95d5759(localclientnum) {
  level.var_300a2507 = self;
  if(shoutcaster::is_shoutcaster(localclientnum)) {
    friendly = self shoutcaster::is_friendly(localclientnum);
  } else {
    friendly = self function_55a8b32b();
  }
  if(isDefined(self.name)) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), self.name);
  } else {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), "");
  }
  if(isDefined(friendly)) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByFriendly"), friendly);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByEnemy"), !friendly);
    return;
  }
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByFriendly"), 0);
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByEnemy"), 0);
}

clear_hud(localclientnum) {
  level.var_300a2507 = undefined;
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByEnemy"), 0);
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByFriendly"), 0);
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), # "hash_5c376bae65a55609");
}

watch_for_death(localclientnum) {
  level endon(#"watch_for_death");
  self waittill(#"death");
}

function_8dc589c8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self function_60dbc438() && self function_55a8b32b()) {
    localplayer = function_f97e7787(localclientnum);
    if(isDefined(localplayer.var_25281d17) && localplayer.var_25281d17) {
      setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.passOption"), newval);
    }
  }
}

function_c27acbbf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballAway"), newval);
}

function_235fe967(localclientnum, on_off) {
  self duplicate_render::update_dr_flag(localclientnum, "ballcarrier", on_off);
}

function_115bb67e(localclientnum, on_off) {
  self duplicate_render::update_dr_flag(localclientnum, "passoption", on_off);
}

resetondemojump(localclientnum, goal, effects) {
  for(;;) {
    level waittill("demo_jump" + localclientnum);
    function_2182aedf(localclientnum, goal, effects);
  }
}

watch_for_team_change(localclientnum) {
  level notify(#"end_team_change_watch");
  level endon(#"end_team_change_watch");
  level waittill(#"team_changed");
  thread function_45876c81(localclientnum);
}