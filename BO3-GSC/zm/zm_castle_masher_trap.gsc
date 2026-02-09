/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_masher_trap.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_traps;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#namespace zm_castle_masher_trap;

function main() {
  register_clientfields();
  level waittill("start_zombie_round_logic");
  level flag::init("masher_on");
  level flag::init("masher_unlocked");
  level flag::init("masher_cooldown");
  scene::add_scene_func("p7_fxanim_zm_castle_gate_smash_lift_bundle", &function_ef9ad3c0, "init");
  level thread function_6a74bee8();
  level thread function_a61df505();
  level.var_6ac4e9cb = getent("masher_gate", "script_noteworthy");
  level.var_6ac4e9cb thread function_faccc214();
  level thread scene::init("p7_fxanim_zm_castle_gate_smash_lift_bundle");
  level thread function_9087381a();
}

function register_clientfields() {}

function function_a61df505() {
  var_fb9e67a8 = getent("masher_buy_door", "script_noteworthy");
  if(isDefined(var_fb9e67a8)) {
    var_fb9e67a8 waittill("door_opened");
  }
  level flag::set("masher_unlocked");
}

function function_6a74bee8() {
  var_4aa9fb47 = struct::get_array("s_masher_button", "targetname");
  array::thread_all(var_4aa9fb47, &function_a5062ebd);
}

function function_a5062ebd() {
  s_unitrigger_stub = spawnStruct();
  s_unitrigger_stub.origin = self.origin;
  s_unitrigger_stub.angles = self.angles;
  s_unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
  s_unitrigger_stub.cursor_hint = "HINT_NOICON";
  s_unitrigger_stub.hint_parm1 = 1500;
  s_unitrigger_stub.radius = 64;
  s_unitrigger_stub.require_look_at = 0;
  s_unitrigger_stub.var_42d723eb = self;
  s_unitrigger_stub.prompt_and_visibility_func = &function_d7e7dcf9;
  thread zm_unitrigger::register_static_unitrigger(s_unitrigger_stub, &function_b776b443);
  s_unitrigger_stub._trap_lights = [];
  s_unitrigger_stub._trap_switches = [];
  var_a22f946c = getEntArray(self.target, "targetname");
  for(i = 0; i < var_a22f946c.size; i++) {
    if(isDefined(var_a22f946c[i].script_noteworthy)) {
      switch (var_a22f946c[i].script_noteworthy) {
        case "switch": {
          s_unitrigger_stub._trap_switches[s_unitrigger_stub._trap_switches.size] = var_a22f946c[i];
          s_unitrigger_stub thread function_aaf7f74d();
          break;
        }
        case "light": {
          s_unitrigger_stub._trap_lights[s_unitrigger_stub._trap_lights.size] = var_a22f946c[i];
          s_unitrigger_stub function_81b05f08();
          break;
        }
      }
    }
  }
  var_8fcfe322 = getEntArray("zombie_trap", "targetname");
  array::thread_all(var_8fcfe322, &function_5054a970);
  foreach(var_60532813 in var_8fcfe322) {
    if(var_60532813.target === "trap_b") {
      var_60532813 thread function_aaf2ece7();
    }
  }
}

function function_ef9ad3c0(a_ents) {
  level.var_995bb84e = a_ents["castle_gate_door_smash_lift"];
  if(isDefined(level.var_995bb84e)) {
    level.var_995bb84e.var_beb932f1 = getEntArray("masher_gate_trig_1", "targetname");
    array::thread_all(level.var_995bb84e.var_beb932f1, &function_1a554e00, level.var_995bb84e, "gate_jnt");
  }
}

function function_df78b782() {
  self thread function_994bb49e();
  while(level flag::get("masher_on")) {
    level scene::play("p7_fxanim_zm_castle_gate_smash_lift_bundle");
    level function_1ff56fb0("p7_fxanim_zm_castle_gate_smash_lift_bundle");
  }
}

function function_994bb49e() {
  while(level flag::get("masher_on")) {
    level waittill("hash_d1d080bc");
    array::run_all(self.var_beb932f1, &setvisibletoall);
    level waittill("hash_e30b0e08");
    array::run_all(self.var_beb932f1, &setinvisibletoall);
  }
}

function function_1ff56fb0(str_scene) {
  s_scene = struct::get(str_scene, "scriptbundlename");
  s_scene.scene_played = 0;
}

function function_aaf2ece7() {
  while(true) {
    self waittill("trap_activate");
    if(isDefined(self.activated_by_player)) {
      self.activated_by_player playrumbleonentity("zm_castle_interact_rumble");
    }
    exploder::exploder("fxexp_116");
    self waittill("trap_done");
    exploder::stop_exploder("fxexp_116");
  }
}

function function_81b05f08() {
  self._trap_light_model_off = "p7_zm_der_light_bulb_small_off";
  self._trap_light_model_green = "p7_zm_der_light_bulb_small_emissive";
  self._trap_light_model_red = "p7_zm_der_light_bulb_small";
}

function function_5054a970() {
  level waittill("power_on");
  for(i = 0; i < self._trap_lights.size; i++) {
    self function_81b05f08();
  }
}

function function_d7e7dcf9(player) {
  if(player.is_drinking > 0) {
    self sethintstring("");
    return false;
  }
  if(!level flag::get("power_on")) {
    self sethintstring(&"ZM_CASTLE_MASHER_POWER");
    return false;
  }
  if(!level flag::get("masher_unlocked")) {
    self sethintstring(&"ZM_CASTLE_MASHER_UNAVAILABLE");
    return false;
  }
  if(level flag::get("masher_on")) {
    self sethintstring("");
    return false;
  }
  if(level flag::get("masher_cooldown")) {
    self sethintstring(&"ZM_CASTLE_MASHER_COOLDOWN");
    return false;
  }
  self sethintstring(&"ZM_CASTLE_MASHER_TRAP", self.stub.hint_parm1);
  return true;
}

function function_b776b443() {
  while(true) {
    if(level flag::get("masher_cooldown")) {
      level flag::wait_till_clear("masher_cooldown");
    }
    self waittill("trigger", e_who);
    if(!level flag::get("masher_on") && !level flag::get("masher_cooldown")) {
      if(!e_who zm_score::can_player_purchase(1500)) {
        e_who zm_audio::create_and_play_dialog("general", "transport_deny");
      } else {
        e_who zm_score::minus_to_player_score(1500);
        self.stub.var_42d723eb thread function_d12a18d7(e_who);
        e_who zm_audio::create_and_play_dialog("trap", "start");
        e_who playrumbleonentity("zm_castle_interact_rumble");
      }
    }
  }
}

function function_aaf7f74d() {
  self function_13fd863b(self._trap_light_model_red);
  exploder::stop_exploder("masher_trap_green");
  exploder::exploder("masher_trap_red");
  for(i = 0; i < self._trap_switches.size; i++) {
    self._trap_switches[i] rotatepitch(180, 0.5);
    self._trap_switches[i] playSound("evt_switch_flip_trap");
  }
  level flag::wait_till_all(array("power_on", "masher_unlocked"));
  while(true) {
    level flag::wait_till_clear("masher_cooldown");
    for(i = 0; i < self._trap_switches.size; i++) {
      self._trap_switches[i] rotatepitch(-180, 0.5);
    }
    self._trap_switches[0] waittill("rotatedone");
    self function_13fd863b(self._trap_light_model_green);
    exploder::stop_exploder("masher_trap_red");
    exploder::exploder("masher_trap_green");
    level flag::wait_till("masher_on");
    self function_13fd863b(self._trap_light_model_red);
    exploder::stop_exploder("masher_trap_green");
    exploder::exploder("masher_trap_red");
    for(i = 0; i < self._trap_switches.size; i++) {
      self._trap_switches[i] rotatepitch(180, 0.5);
      self._trap_switches[i] playSound("evt_switch_flip_trap");
    }
    level flag::wait_till("masher_cooldown");
  }
}

function function_13fd863b(str_model) {
  for(i = 0; i < self._trap_lights.size; i++) {
    var_b079127 = self._trap_lights[i];
    var_b079127 setModel(str_model);
  }
}

function function_d12a18d7(e_player) {
  level flag::set("masher_on");
  level.var_6ac4e9cb.activated_by_player = e_player;
  level.var_995bb84e.activated_by_player = e_player;
  level.var_995bb84e thread function_df78b782();
  wait(0.5);
  level.var_6ac4e9cb function_8123d15a();
  level flag::clear("masher_on");
  level flag::set("masher_cooldown");
  level.var_6ac4e9cb.activated_by_player = undefined;
  level.var_995bb84e.activated_by_player = undefined;
  wait(60);
  level flag::clear("masher_cooldown");
}

function function_8123d15a() {
  array::run_all(self.var_beb932f1, &show);
  n_start_time = gettime();
  n_total_time = 0;
  while(20 > n_total_time && level flag::get("masher_on")) {
    self movez(-116, 0.25);
    self playSound("zmb_mashertrap_descend");
    self waittill("movedone");
    playrumbleonposition("zm_castle_gate_mash", self.origin);
    array::run_all(self.var_beb932f1, &hide);
    self movez(116, 0.25);
    self waittill("movedone");
    wait(0.25);
    array::run_all(self.var_beb932f1, &show);
    n_total_time = (gettime() - n_start_time) / 1000;
  }
  array::run_all(self.var_beb932f1, &hide);
}

function function_faccc214() {
  self.var_beb932f1 = getEntArray(self.target, "targetname");
  array::thread_all(self.var_beb932f1, &function_1a554e00, self);
}

function function_1a554e00(var_6ac4e9cb, var_8f915eab) {
  self._trap_type = "masher";
  self enablelinkto();
  if(isDefined(var_8f915eab)) {
    self linkto(var_6ac4e9cb, var_8f915eab);
  } else {
    self linkto(var_6ac4e9cb);
  }
  self thread trigger_damage(var_6ac4e9cb);
  self hide();
}

function trigger_damage(var_6ac4e9cb) {
  while(true) {
    self waittill("trigger", e_who);
    self.activated_by_player = var_6ac4e9cb.activated_by_player;
    if(level flag::get("masher_on")) {
      if(e_who.archetype === "zombie" && (!(isDefined(e_who.var_bd3a4420) && e_who.var_bd3a4420))) {
        e_who thread function_e80df8bf(var_6ac4e9cb.activated_by_player, self);
      } else {
        if(e_who.archetype === "mechz") {
          level flag::clear("masher_on");
        } else if(isDefined(e_who)) {
          e_who dodamage(e_who.health, e_who.origin, self, undefined, "none", "MOD_IMPACT");
        }
      }
    } else {
      wait(0.5);
    }
    wait(0.05);
  }
}

function function_e80df8bf(var_ecf98bb6, var_60532813) {
  n_chance = randomint(100);
  if(n_chance > 90) {
    self.var_bd3a4420 = 1;
    self thread zombie_utility::makezombiecrawler();
    wait(4);
    if(isDefined(self)) {
      self.var_bd3a4420 = undefined;
    }
  } else {
    if(n_chance > 50) {
      self thread zombie_utility::zombie_gut_explosion();
      level notify("hash_de71acc2", self, var_ecf98bb6);
      self dodamage(self.health + 100, self.origin, var_60532813, undefined, "none", "MOD_IMPACT");
    } else {
      self thread zombie_utility::gib_random_parts();
      level notify("hash_de71acc2", self, var_ecf98bb6);
      self dodamage(self.health + 100, self.origin, var_60532813, undefined, "none", "MOD_IMPACT");
    }
  }
  level.zombie_total++;
}

function function_9087381a() {
  wait(0.05);
  level waittill("start_zombie_round_logic");
  wait(0.05);
  setDvar("", 0);
  adddebugcommand("");
  while(true) {
    if(getdvarint("")) {
      setDvar("", 0);
      level thread function_d12a18d7(1);
    }
    wait(0.5);
  }
}