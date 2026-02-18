/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\objectives_ui.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\objectives;
#namespace objectives_ui;

function private autoexec __init__system__() {
  system::register(#"objectives_ui", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  temp = # "hash_147e5fa1e7f7cd06";
  temp = # "hash_850d28553336ed0";
  temp = # "hash_3537e7d6b8dc612b";
  temp = # "hash_147fefcf7bb5023c";
  clientfield::register("toplayer", "show_objectives", 1, 2, "int");
}

function show_objectives(var_e9791619 = 1) {
  self notify("5651785c71962c50");
  self endon("5651785c71962c50");

  if(var_e9791619) {
    clientfield::set_to_player("show_objectives", 2);
  } else {
    waittillframeend();
    clientfield::set_to_player("show_objectives", 1);
  }

  waitframe(1);
  clientfield::set_to_player("show_objectives", 0);
}

function function_49ebaad2() {
  player = getplayers()[0];

  if(isDefined(player)) {
    timeout = 5;
    notify_str = "show_objectives";
    player thread function_d18e2e61(timeout, notify_str);
    player thread hint_tutorial::function_4c2d4fc4(#"hash_30ae598288c72637", undefined, undefined, undefined, 2, timeout, notify_str, 0);
  }
}

function private function_d18e2e61(timeout, notify_str) {
  self endon(#"death");
  self notifyonplayercommand(notify_str, "+scores");
  self waittilltimeout(timeout, notify_str);
  self notifyonplayercommandremove(notify_str, "+scores");
}

function function_1c6b4aeb() {
  globallogic_ui::function_9ed5232e("hudItems.cpObjectiveUiData.splash", 1, 1, 1, 0, 0, 1);
  waitframe(1);
  globallogic_ui::function_9ed5232e("hudItems.cpObjectiveUiData.splash", 0, 1, 1, 0, 0, 1);
}

function function_79ed6d2(var_8eaad3c1) {
  globallogic_ui::function_9ed5232e("hudItems.cpObjectiveUiData.showHideHint", var_8eaad3c1, 1, 1, 0, 0, 1);
}

function function_b6d41b41(message, state = 0) {
  globallogic_ui::function_9ed5232e("hudItems.cpObjectiveUiData.compassMessage", message, 1);
  globallogic_ui::function_9ed5232e("hudItems.cpObjectiveUiData.compassState", state, 1);
}

function function_be5b472b() {
  globallogic_ui::function_9ed5232e("hudItems.cpObjectiveUiData.compassMessage", #"", 1);
  globallogic_ui::function_9ed5232e("hudItems.cpObjectiveUiData.compassState", 0, 1);
}

function function_49dec5b(str_objective, target, text) {
  obj_id = objectives::function_285e460(str_objective, target);

  if(isDefined(obj_id)) {
    globallogic_ui::function_9ed5232e("objectives_info." + obj_id + ".waypointText", text);
    globallogic_ui::function_9ed5232e("objectives_info." + obj_id + ".forceUpdate", 1, 0, 1, 0, 0, 1);
  }
}

function function_fdeb5e85(str_objective, target, icon) {
  obj_id = objectives::function_285e460(str_objective, target);

  if(isDefined(obj_id)) {
    globallogic_ui::function_9ed5232e("objectives_info." + obj_id + ".waypointIcon", icon);
    globallogic_ui::function_9ed5232e("objectives_info." + obj_id + ".forceUpdate", 1, 0, 1, 0, 0, 1);
  }
}

function function_278c15e6(str_objective, target, hidden) {
  obj_id = objectives::function_285e460(str_objective, target, 1);

  if(isDefined(obj_id)) {
    globallogic_ui::function_9ed5232e("objectives_info." + obj_id + ".hideWaypoint", hidden);
    globallogic_ui::function_9ed5232e("objectives_info." + obj_id + ".forceUpdate", 1, 0, 1, 0, 0, 1);
  }
}

function function_f4a32e0b(str_objective, target, state) {
  obj_id = objectives::function_285e460(str_objective, target);

  if(isDefined(obj_id)) {
    globallogic_ui::function_9ed5232e("objectives_info." + obj_id + ".state", state);
    util::wait_network_frame(1);
    globallogic_ui::function_9ed5232e("ForceObjectiveRefresh", 1, 0, 1, 0, 0, 1);
  }
}

function function_6b177efc(str_objective, target, delay_network_frames = 2) {
  if(isDefined(target)) {
    target endon(#"death");
  }

  level notify("update_waypoint_" + str_objective);
  level endon("update_waypoint_" + str_objective);

  if(delay_network_frames > 0) {
    util::wait_network_frame(delay_network_frames);
  }

  obj_id = objectives::function_285e460(str_objective, target);

  if(isDefined(obj_id)) {
    model_name = "objectives_info." + obj_id + ".waypointUpdate";
    globallogic_ui::function_9ed5232e(model_name, 1, 0, 1);
  }
}

function function_bfdab223(obj_id, desc) {
  globallogic_ui::function_8954fa13("_DataSources.cp_objectives_list", obj_id, "description", desc);
}

function get_state(obj_id) {
  return globallogic_ui::function_596db691("_DataSources.cp_objectives_list", obj_id, "state");
}

function set_state(obj_id, state) {
  globallogic_ui::function_8954fa13("_DataSources.cp_objectives_list", obj_id, "state", state);
}

function function_6a5ca7ac(obj_id, parent_id, var_834e72f6 = 1) {
  if(function_1fe5876a(obj_id) && function_1fe5876a(parent_id)) {
    globallogic_ui::function_8954fa13("_DataSources.cp_objectives_list", obj_id, "parent", parent_id);

    if(var_834e72f6) {
      thread function_8d9f9a22(parent_id);
      thread function_1c6b4aeb();
    }
  }
}

function function_6a43edf3(obj_id, var_e68e38b0 = 1) {
  if(isDefined(obj_id)) {
    globallogic_ui::function_8954fa13("_DataSources.cp_objectives_list", obj_id, "isEndObjective", var_e68e38b0);
    model_name = "objectives_info." + obj_id + ".isEndObjective";
    globallogic_ui::function_9ed5232e(model_name, var_e68e38b0);
  }
}

function function_572778b9(obj_id, is_optional = 1) {
  if(isDefined(obj_id)) {
    globallogic_ui::function_8954fa13("_DataSources.cp_objectives_list", obj_id, "isOptional", is_optional);
    model_name = "objectives_info." + obj_id + ".isOptional";
    globallogic_ui::function_9ed5232e(model_name, is_optional);
  }
}

function function_8d9f9a22(obj_id) {
  notify_string = "objective_splash" + obj_id;
  level notify(notify_string);
  level endon(notify_string);
  globallogic_ui::function_8954fa13("_DataSources.cp_objectives_list", obj_id, "newObjective", 1);
  level waittill(#"objectives_shown");
  globallogic_ui::function_8954fa13("_DataSources.cp_objectives_list", obj_id, "newObjective", 0);
}

function function_f3ac479c(obj_id) {
  model = "objectives_info." + obj_id + ".newObjective";
  level notify(model);
  level endon(model);
  globallogic_ui::function_9ed5232e(model, 1);
  level waittill(#"objectives_shown");
  globallogic_ui::function_9ed5232e(model, 0);
}

function set_progress(obj_id, progress) {
  globallogic_ui::function_8954fa13("_DataSources.cp_objectives_list", obj_id, "progress", progress);
}

function function_97d05398(obj_id, count) {
  globallogic_ui::function_8954fa13("_DataSources.cp_objectives_list", obj_id, "currentCount", count);
}

function function_302128de(obj_id, count) {
  globallogic_ui::function_8954fa13("_DataSources.cp_objectives_list", obj_id, "targetCount", count);
}

function function_bacd9b1f(obj_id, show) {
  globallogic_ui::function_8954fa13("_DataSources.cp_objectives_list", obj_id, "showCounts", show);
}

function function_1fe5876a(obj_id) {
  return isDefined(globallogic_ui::function_a8d716c5("_DataSources.cp_objectives_list", obj_id, "description"));
}

function remove_objective(obj_id) {
  globallogic_ui::function_6db5e620("_DataSources.cp_objectives_list", obj_id);
  globallogic_ui::function_9ed5232e("hudItems.cpObjectiveUiData.updateList", 1, 1, 1, 0, 0, 1);
  function_bb708c99(obj_id);
}

function remove_all() {
  for(i = 0; i < 64; i++) {
    globallogic_ui::function_6db5e620("_DataSources.cp_objectives_list", i, undefined, 1);
    objective_delete(i);
  }

  globallogic_ui::function_9ed5232e("hudItems.cpObjectiveUiData.updateList", 1, 1, 1, 0, 0, 1, 1);
  function_bb708c99(-1, 1);
}

function private function_bb708c99(obj_id, var_cb887047) {
  globallogic_ui::function_9ed5232e("objectives_info." + "removedObjective", obj_id, 0, 1, undefined, undefined, undefined, var_cb887047);
}