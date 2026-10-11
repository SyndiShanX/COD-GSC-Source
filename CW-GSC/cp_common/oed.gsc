/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\oed.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\cp_common\gametypes\save;
#namespace oed;

function private autoexec __init__system__() {
  system::register(#"oed", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  clientfield::register("toplayer", "sitrep_toggle", 1, 1, "int");
  clientfield::register("toplayer", "active_dni_fx", 1, 1, "counter");
  clientfield::register("toplayer", "hack_dni_fx", 1, 1, "counter");
  clientfield::register("actor", "sitrep_material", 1, 1, "int");
  clientfield::register("vehicle", "sitrep_material", 1, 1, "int");
  clientfield::register("scriptmover", "sitrep_material", 1, 1, "int");
  clientfield::register("item", "sitrep_material", 1, 1, "int");
  clientfield::register("vehicle", "turret_keyline_render", 1, 1, "int");
  clientfield::register("vehicle", "vehicle_keyline_toggle", 1, 1, "int");
  callback::on_spawned(&on_player_spawned);
  spawner::add_global_spawn_function(#"axis", &enable_thermal_on_spawned);
  spawner::add_global_spawn_function(#"allies", &enable_thermal_on_spawned);
  level.b_enhanced_vision_enabled = 1;
  level.b_player_scene_active = 0;
  level.enable_thermal = &enable_thermal;
  level.disable_thermal = &disable_thermal;
}

function private postinit() {}

function on_player_spawned() {
  self.b_enhanced_vision_enabled = level.b_enhanced_vision_enabled;
  self.ev_state = 0;
  self ev_activate_on_player(self.ev_state);
  b_playsound = 0;
  self clientfield::set_to_player("sitrep_toggle", 1);
}

function event_handler[button_bit_actionslot_1_pressed] function_84d84898() {
  if(is_true(level.b_enhanced_vision_enabled) && is_true(self.b_enhanced_vision_enabled)) {
    if(!scene::is_igc_active()) {
      self.ev_state = !is_true(self.ev_state);
      self ev_activate_on_player(self.ev_state);
    }
  }
}

function enable_thermal_on_spawned() {
  if(self.team == #"axis") {
    self enable_thermal();
    return;
  }

  if(self.team == #"allies") {
    self enable_thermal();
  }
}

function enable_thermal(str_disable) {
  self endon(#"death");
  self thread disable_thermal_on_death();

  if(isDefined(str_disable)) {
    level waittill(str_disable);
    self disable_thermal();
  }
}

function disable_thermal_on_death() {
  self endon(#"disable_thermal");
  self waittill(#"death");

  if(isDefined(self)) {
    self disable_thermal();
  }
}

function disable_thermal() {
  self notify(#"disable_thermal");
}

function toggle_thermal_mode_for_players(b_enabled = 1) {
  level.b_enhanced_vision_enabled = b_enabled;

  foreach(e_player in level.players) {
    e_player.b_enhanced_vision_enabled = b_enabled;
  }
}

function enable_ev(b_enabled = 1) {
  self.b_enhanced_vision_enabled = b_enabled;

  if(!b_enabled) {
    self ev_activate_on_player(b_enabled);
  }
}

function ev_activate_on_player(b_enabled = 1) {
  self.ev_state = b_enabled;

  if(self.ev_state) {
    self notify(#"enhanced_vision_activated");
    return;
  }

  self notify(#"enhanced_vision_deactivated");
}

function enable_keyline(b_interact, str_disable) {
  self endon(#"death");
  self clientfield::set("sitrep_material", 1);
  self thread disable_on_death();

  if(isDefined(str_disable)) {
    level waittill(str_disable);
    self disable_keyline();
  }
}

function disable_on_death() {
  self waittill(#"death");

  if(isDefined(self)) {
    self disable_keyline();
  }
}

function disable_keyline() {
  self clientfield::set("sitrep_material", 0);
}

function toggle_sitrep_for_players(b_active) {
  foreach(player in level.players) {
    player.sitrep_active = !is_true(player.sitrep_active);
    player clientfield::set_to_player("sitrep_toggle", player.sitrep_active);
  }
}

function init_sitrep_model() {
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  s_sitrep_bundle = level.scriptbundles[#"sitrep"][self.scriptbundlename];
  e_sitrep = util::spawn_model(s_sitrep_bundle.model, self.origin, self.angles);

  if(isDefined(s_sitrep_bundle.sitrep_interact)) {
    e_sitrep.script_sitrep_id = s_sitrep_bundle.sitrep_interact;
  } else {
    e_sitrep.script_sitrep_id = 0;
  }

  return e_sitrep;
}