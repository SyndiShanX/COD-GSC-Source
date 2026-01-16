/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_mansion_trap_buy_buttons.gsc
***********************************************/

#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace zm_trap_buy_buttons;

autoexec __init__system__() {
  system::register(#"zm_trap_buy_buttons", &__init__, &__main__, undefined);
}

__init__() {
  callback::on_finalize_initialization(&init);
}

__main__() {}

init() {
  level.a_mdl_trap_buttons = getEntArray("mdl_trap_button", "targetname");

  foreach(mdl_trap_button in level.a_mdl_trap_buttons) {
    mdl_trap_button thread function_63be76e0();
  }

  level thread function_eac89317();
}

function_bb013f42(str_id) {
  foreach(mdl_trap_button in level.a_mdl_trap_buttons) {
    if(mdl_trap_button.script_string === str_id) {
      mdl_trap_button thread function_8724b9c4();
    }
  }
}

function_75046566(str_id) {
  foreach(mdl_trap_button in level.a_mdl_trap_buttons) {
    if(mdl_trap_button.script_string === str_id) {
      mdl_trap_button thread function_a82eb7c1();
    }
  }
}

function_eac89317() {
  level endon(#"game_ended");

  while(true) {
    s_notify = level waittill(#"traps_activated", #"traps_available");

    if(isDefined(s_notify.var_be3f58a)) {
      if(s_notify._notify === "traps_activated") {
        function_bb013f42(s_notify.var_be3f58a);
        continue;
      }

      if(s_notify._notify === "traps_available") {
        function_75046566(s_notify.var_be3f58a);
      }
    }
  }
}

function_63be76e0() {
  self.v_up = self.origin;
  s_down = struct::get(self.target, "targetname");
  self.v_down = s_down.origin;
}

function_8724b9c4() {
  self moveto(self.v_down, 0.5);
}

function_a82eb7c1() {
  self moveto(self.v_up, 0.5);
}