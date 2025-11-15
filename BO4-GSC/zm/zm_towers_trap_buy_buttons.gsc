/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_towers_trap_buy_buttons.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_audio;

#namespace zm_trap_buy_buttons;

autoexec __init__system__() {
  system::register(#"zm_trap_buy_buttons", &__init__, &__main__, undefined);
}

__init__() {
  callback::on_finalize_initialization(&init);
}

__main__() {}

init() {
  level.a_s_trap_buttons = struct::get_array("s_trap_button", "targetname");
  scene::add_scene_func("p8_fxanim_zm_towers_trap_switch_bundle", &function_cb307051, "init");
  level thread function_eac89317();
  var_7febdbb2 = getEntArray("trig_buy_bladepillars_to_upper_south", "targetname");
  array::thread_all(var_7febdbb2, &function_ea998c9, 0, 1);

  foreach(t_crafting in level.var_4fe2f84d[#"zblueprint_trap_hellpools"]) {
    if(t_crafting.script_noteworthy === "danu" || t_crafting.script_noteworthy === "ra") {
      t_crafting thread function_ea998c9(1, 0);
    }
  }
}

function_cb307051(a_ents) {
  if(!isDefined(self.script_int)) {
    a_ents[#"prop 1"] clientfield::set("trap_switch_green", 1);
  }
}

function_81badccf(str_id) {
  foreach(s_trap_button in level.a_s_trap_buttons) {
    if(s_trap_button.script_string === str_id) {
      s_trap_button thread function_8cfecd54();
    }
  }
}

function_6087ebc2(str_id) {
  foreach(s_trap_button in level.a_s_trap_buttons) {
    if(s_trap_button.script_string === str_id) {
      s_trap_button thread function_707cb9a9();
    }
  }
}

function_1b229077(str_id) {
  foreach(s_trap_button in level.a_s_trap_buttons) {
    if(s_trap_button.script_string === str_id) {
      s_trap_button thread function_baf2d8eb();
    }
  }
}

function_eac89317() {
  level endon(#"game_ended");

  while(true) {
    s_notify = level waittill(#"traps_activated", #"traps_available", #"traps_cooldown");

    if(isDefined(s_notify.var_be3f58a)) {
      switch (s_notify._notify) {
        case #"traps_activated":
          function_81badccf(s_notify.var_be3f58a);
          break;
        case #"traps_available":
          function_6087ebc2(s_notify.var_be3f58a);
          break;
        case #"traps_cooldown":
          function_1b229077(s_notify.var_be3f58a);
          break;
      }
    }
  }
}

function_8cfecd54() {
  self thread scene::play("Shot 1");
  self.scene_ents[#"prop 1"] clientfield::set("trap_switch_green", 0);
  self.scene_ents[#"prop 1"] clientfield::set("trap_switch_red", 1);
}

function_707cb9a9() {
  self thread scene::play("Shot 2");
  self.scene_ents[#"prop 1"] clientfield::set("trap_switch_smoke", 0);
  self.scene_ents[#"prop 1"] clientfield::set("trap_switch_green", 1);
}

function_baf2d8eb() {
  self.scene_ents[#"prop 1"] clientfield::set("trap_switch_red", 0);
  self.scene_ents[#"prop 1"] clientfield::set("trap_switch_smoke", 1);
}

function_ea998c9(var_458e12fe = 0, var_1798e06d = 0) {
  self endon(#"death");

  if(var_458e12fe) {
    if(self.script_noteworthy === "danu") {
      self.script_flag = "connect_starting_area_to_danu_hallway";
    } else {
      self.script_flag = "connect_starting_area_to_ra_hallway";
    }

    while(!isDefined(self.prompt_and_visibility_func)) {
      waitframe(1);
    }

    visibility_func = self.prompt_and_visibility_func;
    self.prompt_and_visibility_func = &function_504d501c;
  } else {
    self triggerenable(0);
  }

  level flag::wait_till("all_players_spawned");
  level flag::wait_till(self.script_flag);

  if(var_1798e06d) {
    a_s_switches = struct::get_array(#"s_trap_button");
    s_switch = arraygetclosest(self.origin, a_s_switches);
    s_switch.scene_ents[#"prop 1"] clientfield::set("trap_switch_green", 1);
  }

  if(var_458e12fe) {
    self.prompt_and_visibility_func = visibility_func;
    return;
  }

  self triggerenable(1);
}

function_504d501c(e_player) {
  return false;
}