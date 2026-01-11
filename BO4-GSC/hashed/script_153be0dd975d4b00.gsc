/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_153be0dd975d4b00.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_audio;
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
  scene::add_scene_func("p8_fxanim_zm_towers_trap_switch_bundle", &function_8edd4db5, "init");
  level thread function_1b8272d7();
}

function_8edd4db5(a_ents) {
  if(!isDefined(self.script_int)) {
    a_ents[# "prop 1"] clientfield::set("trap_switch_green", 1);
  }
}

function_ec7d377b(str_id) {
  foreach(s_trap_button in level.a_s_trap_buttons) {
    if(s_trap_button.script_string === str_id) {
      s_trap_button thread function_11934821();
    }
  }
}

function_e050b6cf(str_id) {
  foreach(s_trap_button in level.a_s_trap_buttons) {
    if(s_trap_button.script_string === str_id) {
      s_trap_button thread function_dfbbff0d();
    }
  }
}

function_711324ec(str_id) {
  foreach(s_trap_button in level.a_s_trap_buttons) {
    if(s_trap_button.script_string === str_id) {
      s_trap_button thread function_cf0175fb();
    }
  }
}

function_1b8272d7() {
  level endon(#"game_ended");
  while(true) {
    s_notify = level waittill(#"traps_activated", # "traps_available", # "traps_cooldown");
    if(isDefined(s_notify.var_f6bb8854)) {
      switch (s_notify._notify) {
        case # "traps_activated":
          function_ec7d377b(s_notify.var_f6bb8854);
          break;
        case # "traps_available":
          function_e050b6cf(s_notify.var_f6bb8854);
          break;
        case # "traps_cooldown":
          function_711324ec(s_notify.var_f6bb8854);
          break;
      }
    }
  }
}

function_11934821() {
  self thread scene::play("Shot 1");
  self.scene_ents[# "prop 1"] clientfield::set("trap_switch_green", 0);
  self.scene_ents[# "prop 1"] clientfield::set("trap_switch_red", 1);
}

function_dfbbff0d() {
  self thread scene::play("Shot 2");
  self.scene_ents[# "prop 1"] clientfield::set("trap_switch_smoke", 0);
  self.scene_ents[# "prop 1"] clientfield::set("trap_switch_green", 1);
}

function_cf0175fb() {
  self.scene_ents[# "prop 1"] clientfield::set("trap_switch_red", 0);
  self.scene_ents[# "prop 1"] clientfield::set("trap_switch_smoke", 1);
}