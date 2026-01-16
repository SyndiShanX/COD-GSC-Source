/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_flinger_trap.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#namespace zm_genesis_flinger_trap;

function main() {
  var_565a8d95 = getentarray("flinger_trap_trigger", "targetname");
  array::thread_all(var_565a8d95, & init_flinger);
}

function init_flinger() {
  self flag::init("trap_active");
  self flag::init("trap_cooldown");
  self.zombie_cost = 1000;
  level.var_6075220 = 0;
  self.var_ad39b789 = [];
  self.a_s_triggers = [];
  self.var_3ad9e05d = [];
  a_e_parts = getentarray(self.target, "targetname");
  for (i = 0; i < a_e_parts.size; i++) {
    if(isdefined(a_e_parts[i].script_noteworthy)) {
      switch (a_e_parts[i].script_noteworthy) {
        case "switch": {
          self.var_ad39b789[self.var_ad39b789.size] = a_e_parts[i];
          break;
        }
      }
    }
  }
  var_da104453 = struct::get_array(self.target, "targetname");
  for (i = 0; i < var_da104453.size; i++) {
    if(isdefined(var_da104453[i].script_noteworthy)) {
      switch (var_da104453[i].script_noteworthy) {
        case "buy_trigger": {
          self.a_s_triggers[self.a_s_triggers.size] = var_da104453[i];
          break;
        }
        case "fling_direction": {
          self.var_b4f536a1 = var_da104453[i];
          break;
        }
        case "flinger_fxanim": {
          self.var_3d0a6850 = var_da104453[i];
          break;
        }
        case "player_fling_pos": {
          self.var_3ad9e05d[self.var_3ad9e05d.size] = var_da104453[i];
          break;
        }
      }
    }
  }
  self thread trap_move_switches();
  self triggerenable(0);
  array::thread_all(self.a_s_triggers, & function_38d940ac, self);
}

function function_38d940ac(var_60532813) {
  s_unitrigger = self zm_unitrigger::create_unitrigger(&"ZOMBIE_NEED_POWER", 64, & function_dc9dafb8);
  s_unitrigger.require_look_at = 1;
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger, 1);
  s_unitrigger.var_60532813 = var_60532813;
  s_unitrigger.script_int = var_60532813.script_int;
  var_60532813._trap_type = "flinger";
  while (true) {
    self waittill("trigger_activated", e_player);
    if(e_player zm_utility::in_revive_trigger()) {
      continue;
    }
    if(e_player.is_drinking > 0) {
      continue;
    }
    if(!zm_utility::is_player_valid(e_player)) {
      continue;
    }
    if(e_player zm_score::can_player_purchase(1000)) {
      e_player zm_score::minus_to_player_score(1000);
      var_60532813 thread function_c7f4ae43(self, e_player);
      var_60532813.activated_by_player = e_player;
    } else {
      zm_utility::play_sound_at_pos("no_purchase", self.origin);
      if(isdefined(level.custom_generic_deny_vo_func)) {
        e_player thread[[level.custom_generic_deny_vo_func]](1);
      } else {
        e_player zm_audio::create_and_play_dialog("general", "outofmoney");
      }
    }
  }
}

function function_dc9dafb8(e_player) {
  if(isdefined(e_player.zombie_vars["zombie_powerup_minigun_on"]) && e_player.zombie_vars["zombie_powerup_minigun_on"]) {
    self sethintstring(&"");
    return false;
  }
  if(isdefined(self.stub.script_int) && !level flag::get("power_on" + self.stub.script_int)) {
    self sethintstring(&"ZOMBIE_NEED_POWER");
    return false;
  }
  if(self.stub.var_60532813 flag::get("trap_active")) {
    self sethintstring(&"ZOMBIE_TRAP_ACTIVE");
    return false;
  }
  if(self.stub.var_60532813 flag::get("trap_cooldown")) {
    self sethintstring(&"ZOMBIE_TRAP_COOLDOWN");
    return false;
  }
  self sethintstring(&"ZM_GENESIS_FLINGER_TRAP_USE", 1000);
  return true;
}

function trap_move_switches() {
  for (i = 0; i < self.var_ad39b789.size; i++) {
    self.var_ad39b789[i] rotatepitch(160, 0.5);
  }
  self.var_ad39b789[0] waittill("rotatedone");
  if(isdefined(self.script_int) && !level flag::get("power_on" + self.script_int)) {
    level flag::wait_till("power_on" + self.script_int);
  }
  self trap_lights_green();
  while (true) {
    self flag::wait_till("trap_active");
    self trap_lights_red();
    for (i = 0; i < self.var_ad39b789.size; i++) {
      self.var_ad39b789[i] rotatepitch(-160, 0.5);
      self.var_ad39b789[i] playsound("evt_switch_flip_trap");
    }
    self.var_ad39b789[0] waittill("rotatedone");
    self flag::wait_till("trap_cooldown");
    for (i = 0; i < self.var_ad39b789.size; i++) {
      self.var_ad39b789[i] rotatepitch(160, 0.5);
    }
    self.var_ad39b789[0] waittill("rotatedone");
    self flag::wait_till_clear("trap_cooldown");
    self trap_lights_green();
  }
}

function trap_lights_red() {
  if(isdefined(self.script_notworthy)) {
    exploder::exploder(self.script_notworthy + "_red");
    exploder::stop_exploder(self.script_notworthy + "_green");
  }
}

function trap_lights_green() {
  if(isdefined(self.script_notworthy)) {
    exploder::exploder(self.script_notworthy + "_green");
    exploder::stop_exploder(self.script_notworthy + "_red");
  }
}

function function_c7f4ae43(var_c4f1ee44, e_player) {
  self flag::set("trap_active");
  self thread function_ef013ee8(var_c4f1ee44, e_player);
  self waittill("trap_done");
  self flag::clear("trap_active");
  self flag::set("trap_cooldown");
  wait(45);
  self flag::clear("trap_cooldown");
}

function function_ef013ee8(var_c4f1ee44, e_player) {
  n_start_time = gettime();
  n_total_time = 0;
  level notify("trap_activate", self);
  while (30 > n_total_time) {
    playrumbleonposition("zm_stalingrad_interact_rumble", self.origin);
    self function_e0c7ad1e();
    self function_54227761();
    self.var_3d0a6850 scene::play(self.var_3d0a6850.scriptbundlename);
    wait(0.5);
    level function_1ff56fb0("p7_fxanim_zm_stal_flinger_trap_bundle");
    n_total_time = (gettime() - n_start_time) / 1000;
  }
  self notify("trap_done");
}

function function_e0c7ad1e() {
  foreach(e_player in level.activeplayers) {
    if(e_player istouching(self)) {
      e_player thread function_fce6cca8(self);
    }
  }
}

function function_fce6cca8(e_trigger) {
  self endon("death");
  var_f4df9eab = array::random(e_trigger.var_3ad9e05d);
  var_848f1155 = spawn("script_model", self.origin);
  var_848f1155 setmodel("tag_origin");
  self playerlinkto(var_848f1155, "tag_origin");
  self notsolid();
  var_848f1155 notsolid();
  n_time = var_848f1155 zm_utility::fake_physicslaunch(var_f4df9eab.origin, 400);
  wait(n_time);
  if(!(isdefined(self.b_no_trap_damage) && self.b_no_trap_damage)) {
    self dodamage(self.maxhealth * 0.34, self.origin);
  }
  self solid();
  var_848f1155 delete();
}

function function_54227761() {
  a_ai_zombies = getaiteamarray(level.zombie_team);
  foreach(ai_zombie in a_ai_zombies) {
    if(ai_zombie istouching(self) && (!(isdefined(self.var_b07a0f56) && self.var_b07a0f56))) {
      ai_zombie thread function_d2f913f5(self);
    }
  }
}

function function_d2f913f5(e_trigger) {
  self.var_b07a0f56 = 1;
  v_fling = anglestoforward(e_trigger.var_b4f536a1.angles);
  if(level.var_6075220 > 8) {
    self do_zombie_explode();
    return;
  }
  self thread function_f5ad0ae6();
  self startragdoll();
  self launchragdoll(v_fling * 200);
  if(!(isdefined(self.exclude_cleanup_adding_to_total) && self.exclude_cleanup_adding_to_total)) {
    level.zombie_total++;
    level.zombie_respawns++;
    self.var_4d11bb60 = 1;
    if(isdefined(self.maxhealth) && self.health < self.maxhealth) {
      if(!isdefined(level.a_zombie_respawn_health[self.archetype])) {
        level.a_zombie_respawn_health[self.archetype] = [];
      }
      if(!isdefined(level.a_zombie_respawn_health[self.archetype])) {
        level.a_zombie_respawn_health[self.archetype] = [];
      } else if(!isarray(level.a_zombie_respawn_health[self.archetype])) {
        level.a_zombie_respawn_health[self.archetype] = array(level.a_zombie_respawn_health[self.archetype]);
      }
      level.a_zombie_respawn_health[self.archetype][level.a_zombie_respawn_health[self.archetype].size] = self.health;
    }
    self zombie_utility::reset_attack_spot();
  }
  level notify("hash_4b262135", self);
  self kill();
}

function function_f5ad0ae6() {
  level.var_6075220++;
  self waittill("death");
  level.var_6075220--;
}

function private do_zombie_explode() {
  util::wait_network_frame();
  if(isdefined(self)) {
    self zombie_utility::zombie_eye_glow_stop();
    self clientfield::increment("skull_turret_explode_fx");
    self ghost();
    self util::delay(0.25, undefined, & zm_utility::self_delete);
  }
}

function function_1ff56fb0(str_scene) {
  s_scene = struct::get(str_scene, "scriptbundlename");
  if(isdefined(s_scene)) {
    s_scene.scene_played = 0;
  }
}