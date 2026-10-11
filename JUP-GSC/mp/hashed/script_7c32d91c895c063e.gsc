/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7c32d91c895c063e.gsc
*************************************************/

#using script_57614a088fb41089;
#using scripts\cp_mp\utility\game_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\objidpoolmanager;
#namespace namespace_af11c3f4276ff1a1;

function function_2e61a0f1c846a9c2(player) {
  player setclientomnvar("ui_securing", 0);
  player setclientomnvar("ui_securing_progress", 0);
}

function starthacking(player) {
  player setclientomnvar("ui_securing", 26);
  player setclientomnvar("ui_securing_progress", 0);
}

function function_efd118cc84912439(player, progress) {
  player setclientomnvar("ui_securing_progress", progress);
}

function stophacking(player) {
  player setclientomnvar("ui_securing", 0);
}

function function_e92d8183093a8f29() {
  setomnvar("ui_bomb_owner_team", -1);
  setomnvar("ui_bomb_timer_endtime", 0);
  setomnvar("ui_objective_timer_stopped", 0);
}

function startcapture(team, endtimems, paused) {
  setomnvar("ui_bomb_timer_endtime", endtimems);

  if(istrue(paused)) {
    setomnvar("ui_objective_timer_stopped", 1);
  } else {
    setomnvar("ui_objective_timer_stopped", 0);
  }

  if(team == "allies") {
    setomnvar("ui_bomb_owner_team", 2);
    return;
  }

  setomnvar("ui_bomb_owner_team", 1);
}

function function_f83e9201f5f2aa6a() {
  setomnvar("ui_objective_timer_stopped", 1);
}

function function_4477eaad8e734453() {
  setomnvar("ui_objective_timer_stopped", 0);
}

function function_2d908d3021b52c73(player) {
  uid = "SECURE_REACH_UID";
  ui_key = "SECURE_REACH";
  player start_objective(uid, ui_key);
}

function function_7ea96c9156efe322(player) {
  uid = "SECURE_REACH_UID";
  player complete_objective(uid);
}

function function_45ab5558796cc564(player) {
  uid = "SECURE_FIND_UID";
  ui_key = "SECURE_FIND";
  player start_objective(uid, ui_key);
}

function function_845f78cca213ea21(player) {
  uid = "SECURE_FIND_UID";
  player complete_objective(uid);
}

function function_6b56d2c2eae0b9af(player) {
  uid_reach = "SECURE_REACH_UID";
  player clear_objective(uid_reach);
  uid_find = "SECURE_FIND_UID";
  player clear_objective(uid_find);
}

function detectplayerinsidequestcircle(player) {
  player notify("detectPlayerInsideQuestCircle");
  player endon("detectPlayerInsideQuestCircle");
  player endon("disconnect");

  while(!isDefined(level.var_80bce1fe9a035033)) {
    waitframe();
  }

  var_616ad701092fa9c1 = level.var_80bce1fe9a035033 scripts\cp_mp\utility\game_utility::function_d9583306c5a171e4();

  while(true) {
    if(distance2d(var_616ad701092fa9c1, player.origin) < 512) {
      player setclientomnvar("ui_quest_circle_opacity_change", 1);
      function_3d58ef9f07a4e2e9(player);
      function_7ea96c9156efe322(player);
      function_45ab5558796cc564(player);
    } else {
      function_e99ea42a85a85757(player);
      player setclientomnvar("ui_quest_circle_opacity_change", 0);
    }

    waitframe();
  }
}

function function_353ca278babb871e(player) {
  namespace_c98199706c89bf3::player_init(player, "ObjectiveTracker", "scripted_widget_objective_tracker_jup_robj", 47, 383);
}

function start_objective(uid, ui_key) {
  completed = 0;
  var_185416cb8a76fb63 = isDefined(self.objective_tracker) && isDefined(self.objective_tracker.objectives[uid]);

  if(isDefined(self.objective_tracker)) {
    if(!istrue(var_185416cb8a76fb63)) {
      self.objective_tracker.next_uid = uid;
      namespace_c98199706c89bf3::add_objective(uid, undefined, undefined, ui_key, completed);
    }
  }
}

function complete_objective(uid) {
  var_185416cb8a76fb63 = isDefined(self.objective_tracker) && isDefined(self.objective_tracker.objectives[uid]);

  if(istrue(var_185416cb8a76fb63) && !istrue(self.objective_tracker.objectives[uid].is_completed)) {
    namespace_c98199706c89bf3::function_c0257db3a941f1b6(uid, 1);
  }
}

function clear_objective(uid) {
  var_8f5353255e77c5bf = isDefined(self.objective_tracker) && isDefined(self.objective_tracker.objectives[uid]);

  if(istrue(var_8f5353255e77c5bf)) {
    namespace_c98199706c89bf3::remove_objective(uid);
  }
}

function function_d4a8824fbf63451d() {
  current_obj = undefined;

  if(isDefined(self.objective_tracker) && isDefined(self.objective_tracker.next_uid)) {
    next_uid = self.objective_tracker.next_uid;
  }

  if(isDefined(next_uid) && isDefined(self.objective_tracker.objectives[next_uid])) {
    current_obj = self.objective_tracker.objectives[next_uid];
  }

  return current_obj;
}

function function_23fff3da64882320() {
  visibility = 0;

  foreach(objective in level.current_objectives) {
    scriptablename = "";

    if(isDefined(objective.scriptable) && isDefined(objective.scriptable.type)) {
      scriptablename = objective.scriptable.type;
    }

    if(isDefined(scriptablename) && (scriptablename == "mp_secure_outdoor_objective_01" || scriptablename == "mp_secure_indoor_objective_01")) {
      visibility = 1;
      break;
    }
  }

  self setclientomnvar("ui_secure_overlay_active", visibility);
}

function function_2ea2aacc5d66ae03() {
  if(!isDefined(self) || !isDefined(self.objective_tracker) || !isDefined(self.objective_tracker.objectives)) {
    return;
  }

  self.objective_tracker.var_1710c224de197b0a = level.framedurationseconds;
  current_obj = function_d4a8824fbf63451d();

  if(isDefined(current_obj)) {
    if(!isDefined(self.objective_tracker.active_uid)) {
      namespace_c98199706c89bf3::function_3b4b24bbf0814ee6(current_obj.uid, current_obj.ui_key, current_obj.is_completed, current_obj.is_successful);
    } else if(self.objective_tracker.active_uid != current_obj.uid) {
      namespace_c98199706c89bf3::function_4c43cb3c8fcb9b87();
    } else if(!isDefined(self.objective_tracker.active_completed) || self.objective_tracker.active_completed != current_obj.is_completed) {
      if(istrue(current_obj.is_completed)) {
        namespace_c98199706c89bf3::function_d463ec55daebbd66(current_obj.is_successful);
      }
    }
  } else if(isDefined(self.objective_tracker.active_uid)) {
    namespace_c98199706c89bf3::function_4c43cb3c8fcb9b87();
  }

  function_23fff3da64882320();
}

function function_c0ee40f76dcd495c(origin, type) {
  marker_type = function_13176caa696f06e2(type);
  marker = scripts\mp\gameobjects::createobjidobject(get_offset_origin(origin), "neutral", (0, 0, 0), undefined, "all", 0);
  marker.iconname = "";
  scripts\mp\objidpoolmanager::update_objective_setbackground(marker.objidnum, 0);

  if(!isDefined(level.var_2725983b6b1f32a1)) {
    level.var_2725983b6b1f32a1 = [];
  }

  level.var_2725983b6b1f32a1[marker_type] = marker;
}

function function_ef9c5d31f2fbc04f(origin, type) {
  marker = function_1d7859d68b494958(type);
  scripts\mp\objidpoolmanager::update_objective_position(marker.objidnum, get_offset_origin(origin));
}

function function_6a2c1dff398cfc38(type, optionalobjective) {
  marker = function_1d7859d68b494958(type);
  objective = level.current_objectives[0];

  if(isDefined(optionalobjective)) {
    objective = optionalobjective;
  }

  scripts\mp\objidpoolmanager::update_objective_position(marker.objidnum, get_offset_origin(objective.curorigin));
}

function function_3d58ef9f07a4e2e9(player) {
  player.var_f78073300fa773d1 = 1;
  function_e5d530bc9d8420e8(player, "obscured");
  function_8223aee4da506330(player, "on_point");

  if(level.current_objectives.size > 1) {
    function_8223aee4da506330(player, "on_point_2");
  }
}

function function_e99ea42a85a85757(player) {
  if(istrue(player.var_f78073300fa773d1)) {
    return;
  }

  function_8223aee4da506330(player, "obscured");
  function_e5d530bc9d8420e8(player, "on_point");

  if(level.current_objectives.size > 1) {
    function_e5d530bc9d8420e8(player, "on_point_2");
  }
}

function function_7aa88aa68f7d7b1a() {
  if(!isDefined(level.var_2725983b6b1f32a1)) {
    return;
  }

  foreach(player in level.players) {
    player notify("detectPlayerInsideQuestCircle");
    player.var_f78073300fa773d1 = 0;
    player setclientomnvar("ui_secure_overlay_active", 0);
  }

  function_e5d530bc9d8420e8(level.players, "obscured");
  function_e5d530bc9d8420e8(level.players, "on_point");

  if(level.current_objectives.size > 1) {
    function_e5d530bc9d8420e8(level.players, "on_point_2");
  }
}

function function_8223aee4da506330(players, type) {
  marker = function_1d7859d68b494958(type);

  if(!isarray(players)) {
    players = [players];
  }

  foreach(player in players) {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(marker.objidnum, player);
  }
}

function function_e5d530bc9d8420e8(players, type) {
  marker = function_1d7859d68b494958(type);

  if(!isarray(players)) {
    players = [players];
  }

  foreach(player in players) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(marker.objidnum, player);
  }
}

function function_e59213769db9f8b5(type) {
  marker = function_1d7859d68b494958(type);
  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, "icon_waypoint_locked");
  scripts\mp\objidpoolmanager::update_objective_setbackground(marker.objidnum, 0);
}

function function_ecfc813d02e731c5(type) {
  marker = function_1d7859d68b494958(type);
  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, "jup_ui_map_icon_obj_bg");
  scripts\mp\objidpoolmanager::update_objective_setbackground(marker.objidnum, 0);
}

function function_defe4cadf275a0bf(type, time) {
  marker = function_1d7859d68b494958(type);

  if(time == 0) {
    scripts\mp\objidpoolmanager::objective_show_progress(marker.objidnum, 0);
    return;
  }

  marker thread scripts\mp\gameobjects::function_d36dcacac1708708(time);
}

function function_4b90183cabcea8c3(type, dointro, dooutro) {
  marker = function_1d7859d68b494958(type);
  scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objidnum, dointro);
  scripts\mp\objidpoolmanager::objective_set_play_outro(marker.objidnum, dooutro);
}

function function_9a750347647b35c4(type, bgtype) {
  marker = function_1d7859d68b494958(type);
  scripts\mp\objidpoolmanager::update_objective_setbackground(marker.objidnum, bgtype);
}

function get_offset_origin(origin) {
  return origin + (0, 0, 80);
}

function function_1d7859d68b494958(type) {
  marker_type = function_13176caa696f06e2(type);
  return level.var_2725983b6b1f32a1[marker_type];
}

function function_13176caa696f06e2(marker_type) {
  if(!isDefined(marker_type)) {
    return "obscured";
  }

  return marker_type;
}