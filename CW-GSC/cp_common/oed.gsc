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
  spawner::add_global_spawn_function(#"axis", &function_9eccf6c1);
  spawner::add_global_spawn_function(#"allies", &function_9eccf6c1);
  level.var_3cebd57f = 1;
  level.var_7813404f = 0;
  level.enable_thermal = &enable_thermal;
  level.disable_thermal = &disable_thermal;
}

function private postinit() {}

function on_player_spawned() {
  self.var_3cebd57f = level.var_3cebd57f;
  self.var_a12ca713 = 0;
  self function_4b06932(self.var_a12ca713);
  var_92ea5533 = 0;
  self clientfield::set_to_player("sitrep_toggle", 1);
}

function event_handler[button_bit_actionslot_1_pressed] function_84d84898() {
  if(is_true(level.var_3cebd57f) && is_true(self.var_3cebd57f)) {
    if(!scene::is_igc_active()) {
      self.var_a12ca713 = !is_true(self.var_a12ca713);
      self function_4b06932(self.var_a12ca713);
    }
  }
}

function function_9eccf6c1() {
  if(self.team == # "axis") {
    self enable_thermal();
    return;
  }

  if(self.team == # "allies") {
    self enable_thermal();
  }
}

function enable_thermal(var_5bf5152f) {
  self endon(#"death");
  self thread function_5feac491();

  if(isDefined(var_5bf5152f)) {
    level waittill(var_5bf5152f);
    self disable_thermal();
  }
}

function function_5feac491() {
  self endon(#"disable_thermal");
  self waittill(#"death");

  if(isDefined(self)) {
    self disable_thermal();
  }
}

function disable_thermal() {
  self notify(#"disable_thermal");
}

function function_9ce86e2d(b_enabled = 1) {
  level.var_3cebd57f = b_enabled;

  foreach(e_player in level.players) {
    e_player.var_3cebd57f = b_enabled;
  }
}

function enable_ev(b_enabled = 1) {
  self.var_3cebd57f = b_enabled;

  if(!b_enabled) {
    self function_4b06932(b_enabled);
  }
}

function function_4b06932(b_enabled = 1) {
  self.var_a12ca713 = b_enabled;

  if(self.var_a12ca713) {
    self notify(#"hash_4bf84da81ef07fa4");
    return;
  }

  self notify(#"hash_2e8449934db3fd9d");
}

function function_f2a6c166(var_af4a3f3e, var_5bf5152f) {
  self endon(#"death");
  self clientfield::set("sitrep_material", 1);
  self thread function_99b61739();

  if(isDefined(var_5bf5152f)) {
    level waittill(var_5bf5152f);
    self function_b925bd3c();
  }
}

function function_99b61739() {
  self waittill(#"death");

  if(isDefined(self)) {
    self function_b925bd3c();
  }
}

function function_b925bd3c() {
  self clientfield::set("sitrep_material", 0);
}

function function_19b0de13(b_active) {
  foreach(player in level.players) {
    player.var_bef05351 = !is_true(player.var_bef05351);
    player clientfield::set_to_player("sitrep_toggle", player.var_bef05351);
  }
}

function function_8c3be026() {
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  var_57f4c959 = level.scriptbundles[#"sitrep"][self.scriptbundlename];
  var_7343683f = util::spawn_model(var_57f4c959.model, self.origin, self.angles);

  if(isDefined(var_57f4c959.var_2e0f906a)) {
    var_7343683f.var_280ea1f = var_57f4c959.var_2e0f906a;
  } else {
    var_7343683f.var_280ea1f = 0;
  }

  return var_7343683f;
}