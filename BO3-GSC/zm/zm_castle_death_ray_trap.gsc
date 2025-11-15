/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_death_ray_trap.gsc
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
#using scripts\zm\_zm_ai_mechz;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_lightning_chain;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_traps;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#namespace zm_castle_death_ray_trap;

function main() {
  register_clientfields();
  level thread function_b8bad181();
}

function register_clientfields() {
  clientfield::register("actor", "death_ray_shock_fx", 5000, 1, "int");
  clientfield::register("actor", "death_ray_shock_eye_fx", 5000, 1, "int");
  clientfield::register("actor", "death_ray_explode_fx", 5000, 1, "counter");
  clientfield::register("scriptmover", "death_ray_status_light", 5000, 2, "int");
  clientfield::register("actor", "tesla_beam_fx", 5000, 1, "counter");
  clientfield::register("toplayer", "tesla_beam_fx", 5000, 1, "counter");
  clientfield::register("actor", "tesla_beam_mechz", 5000, 1, "int");
}

function function_b8bad181() {
  level flag::init("tesla_coil_on");
  level flag::init("tesla_coil_cooldown");
  var_144aea6c = getent("tesla_coil_activate", "targetname");
  var_144aea6c thread tesla_coil_activate();
}

function tesla_coil_activate() {
  level waittill("power_on");
  exploder::exploder("fxexp_710");
  exploder::exploder("fxexp_720");
  self thread function_40bac98d();
  self thread function_66bab678();
  unitrigger_stub = spawnStruct();
  unitrigger_stub.origin = self.origin;
  unitrigger_stub.angles = self.angles;
  unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
  unitrigger_stub.cursor_hint = "HINT_NOICON";
  unitrigger_stub.hint_parm1 = 1000;
  unitrigger_stub.radius = 64;
  unitrigger_stub.require_look_at = 0;
  unitrigger_stub.var_42d723eb = self;
  unitrigger_stub.prompt_and_visibility_func = & function_1b068db6;
  zm_unitrigger::register_static_unitrigger(unitrigger_stub, & function_3d3feaa2);
}

function function_66bab678() {
  while(true) {
    level flag::wait_till("tesla_coil_on");
    self playSound("zmb_deathray_on");
    self playLoopSound("zmb_deathray_lp", 2);
    level flag::wait_till_clear("tesla_coil_on");
    self stoploopsound(1);
    self playSound("zmb_deathray_off");
  }
}

function function_40bac98d() {
  level thread function_79ce76bb();
  var_95e2b9fb = getent("tesla_coil_panel", "targetname");
  while(true) {
    var_95e2b9fb clientfield::set("death_ray_status_light", 1);
    level flag::wait_till("tesla_coil_on");
    self rotateroll(-120, 0.5);
    self playSound("evt_tram_lever");
    var_95e2b9fb clientfield::set("death_ray_status_light", 2);
    level thread function_2f45472d();
    level flag::wait_till("tesla_coil_cooldown");
    level flag::wait_till_clear("tesla_coil_cooldown");
    self rotateroll(120, 0.5);
    self playSound("evt_tram_lever");
  }
}

function function_79ce76bb() {
  exploder::exploder("lgt_deathray_green");
}

function function_2f45472d() {
  exploder::stop_exploder("lgt_deathray_green");
  while(level flag::get("tesla_coil_on")) {
    exploder::exploder("lgt_deathray_red");
    wait(0.25);
    exploder::stop_exploder("lgt_deathray_red");
    wait(0.25);
  }
  exploder::exploder("lgt_deathray_green");
}

function function_1b068db6(player) {
  if(level flag::get("tesla_coil_on") || player.is_drinking > 0) {
    self sethintstring("");
    return false;
  }
  if(level flag::get("tesla_coil_cooldown")) {
    self sethintstring(&"ZM_CASTLE_DEATH_RAY_COOLDOWN");
    return false;
  }
  self sethintstring(&"ZM_CASTLE_DEATH_RAY_TRAP", self.stub.hint_parm1);
  return true;
}

function function_3d3feaa2() {
  while(true) {
    self waittill("trigger", e_who);
    self setinvisibletoall();
    if(e_who.is_drinking > 0) {
      continue;
    }
    if(e_who zm_utility::in_revive_trigger()) {
      continue;
    }
    if(zm_utility::is_player_valid(e_who) && !level flag::get("tesla_coil_on") && !level flag::get("tesla_coil_cooldown")) {
      if(!e_who zm_score::can_player_purchase(1000)) {
        e_who zm_audio::create_and_play_dialog("general", "transport_deny");
      } else {
        e_who zm_score::minus_to_player_score(1000);
        self.stub.var_42d723eb thread function_f796bd32(e_who);
        level thread function_43b12d8e(self.origin);
        e_who thread function_90df19();
        e_who playrumbleonentity("zm_castle_interact_rumble");
        level flag::wait_till("tesla_coil_cooldown");
      }
    }
    self setvisibletoall();
  }
}

function function_f796bd32(player) {
  level flag::set("tesla_coil_on");
  exploder::exploder("fxexp_700");
  level flag::set("death_ray_trap_used");
  zombie_utility::set_zombie_var("tesla_head_gib_chance", 75);
  var_cb1f7664 = getEntArray(self.target, "targetname");
  foreach(var_6ba90bc4 in var_cb1f7664) {
    var_6ba90bc4 thread function_65680b09(player);
  }
  level flag::wait_till_clear("tesla_coil_on");
  exploder::stop_exploder("fxexp_700");
}

function function_65680b09(player) {
  var_9ffdb9e2 = struct::get(self.target, "targetname");
  n_start_time = gettime();
  n_total_time = 0;
  var_c998e88a = 0;
  self._trap_type = "death_ray";
  self.activated_by_player = player;
  while(n_total_time < 15) {
    if(var_c998e88a > 0) {
      var_c998e88a = var_c998e88a - 0.1;
    } else {
      var_c998e88a = 0;
      var_1c7748 = self function_98484afb();
      foreach(ai_enemy in var_1c7748) {
        if(!(isDefined(ai_enemy.var_1ea49cd7) && ai_enemy.var_1ea49cd7)) {
          ai_enemy thread function_991ffb6c(var_9ffdb9e2);
        }
        if(!(isDefined(ai_enemy.var_bce6e774) && ai_enemy.var_bce6e774)) {
          ai_enemy thread function_120a8b07(player, self);
        }
        var_c998e88a = randomfloatrange(0.6, 1.8);
      }
    }
    foreach(e_player in level.activeplayers) {
      if(zm_utility::is_player_valid(e_player) && e_player function_55b881b7(self) && (!(isDefined(e_player.var_1ea49cd7) && e_player.var_1ea49cd7))) {
        e_player thread function_383d6ca4(var_9ffdb9e2, self);
      }
    }
    wait(0.1);
    n_total_time = (gettime() - n_start_time) / 1000;
  }
  level flag::clear("tesla_coil_on");
  foreach(player in level.players) {
    player.var_1ea49cd7 = undefined;
    player.var_bf3163c8 = undefined;
  }
  level flag::set("tesla_coil_cooldown");
  level util::waittill_any_timeout(60, "between_round_over");
  level flag::clear("tesla_coil_cooldown");
}

function function_98484afb() {
  a_ai_enemies = getaiteamarray(level.zombie_team);
  var_1c7748 = [];
  foreach(ai_zombie in a_ai_enemies) {
    if(ai_zombie function_55b881b7(self)) {
      array::add(var_1c7748, ai_zombie, 0);
    }
  }
  var_1c7748 = array::filter(var_1c7748, 0, & function_172d425, self);
  array::thread_all(var_1c7748, & function_9eaff330);
  var_1c7748 = array::randomize(var_1c7748);
  var_d5157ddf = [];
  for(i = 0; i < 4; i++) {
    array::add(var_d5157ddf, var_1c7748[i], 0);
  }
  return var_d5157ddf;
}

function function_9eaff330() {
  self endon("death");
  if(isDefined(self.var_5e3b2ce3)) {
    return;
  }
  self.var_5e3b2ce3 = self.zombie_move_speed;
  self.zombie_move_speed = "walk";
  level flag::wait_till("tesla_coil_cooldown");
  self.zombie_move_speed = self.var_5e3b2ce3;
  self.var_5e3b2ce3 = undefined;
}

function function_172d425(ai_enemy, var_2c11866b) {
  return isalive(ai_enemy) && (!(isDefined(ai_enemy.var_98056717) && ai_enemy.var_98056717)) && !ai_enemy.var_1ea49cd7 === 1;
}

function function_383d6ca4(var_9ffdb9e2, var_2c11866b) {
  level endon("tesla_coil_cooldown");
  if(isgodmode(self)) {
    return;
  }
  n_damage = self.maxhealth / 4;
  while(zm_utility::is_player_valid(self) && self function_55b881b7(var_2c11866b)) {
    n_cur_time = gettime();
    if(!isDefined(self.var_bf3163c8) || (n_cur_time - self.var_bf3163c8) > 2000) {
      self thread function_991ffb6c(var_9ffdb9e2);
      self.var_bf3163c8 = n_cur_time;
      if(n_damage >= self.health) {
        self dodamage(self.health + 100, self.origin, undefined, undefined, undefined, "MOD_ELECTROCUTED");
      } else {
        n_duration = 1.2;
        self setelectrified(n_duration);
        self shellshock("castle_electrocution_zm", n_duration);
        self playSound("wpn_teslatrap_zap");
        self playrumbleonentity("zm_castle_tesla_electrocution");
        self dodamage(n_damage, self.origin, undefined, undefined, undefined, "MOD_ELECTROCUTED");
      }
    }
    wait(0.1);
  }
  self.var_1ea49cd7 = undefined;
  self.var_bf3163c8 = undefined;
}

function function_55b881b7(var_2c11866b) {
  var_94ef9ffe = getent("tesla_coil_zone", "targetname");
  var_4ca7bb70 = getent("telsa_safety_zone", "targetname");
  if(isDefined(var_4ca7bb70) && self istouching(var_4ca7bb70)) {
    return false;
  }
  if(self istouching(var_94ef9ffe)) {
    return true;
  }
  return false;
}

function function_120a8b07(var_ecf98bb6, e_panel) {
  self endon("death");
  if(self.isdog) {
    self kill(self.origin, e_panel);
  } else {
    if(self.archetype == "mechz") {
      if(!(isDefined(self.var_bce6e774) && self.var_bce6e774)) {
        self clientfield::set("death_ray_shock_fx", 1);
        self clientfield::set("tesla_beam_mechz", 1);
        self thread function_41ecbdf9();
        wait(randomfloatrange(0.2, 0.5));
        self.var_ab0efcf6 = self.origin;
        self thread scene::play("cin_zm_dlc1_mechz_dth_deathray_01", self);
        level flag::wait_till_clear("tesla_coil_on");
        self scene::stop("cin_zm_dlc1_mechz_dth_deathray_01");
        self thread zm_ai_mechz::function_bb84a54(self);
        self clientfield::set("death_ray_shock_fx", 0);
        self clientfield::set("tesla_beam_mechz", 0);
        self.var_bce6e774 = undefined;
        wait(randomfloatrange(0.5, 1.5));
        self.zombie_tesla_hit = 0;
      }
      self.var_1ea49cd7 = undefined;
    } else {
      self clientfield::set("death_ray_shock_fx", 1);
      self thread function_41ecbdf9();
      self.no_damage_points = 1;
      self.deathpoints_already_given = 1;
      if(isDefined(self.var_1ea49cd7) && self.var_1ea49cd7) {
        if(math::cointoss()) {
          if(isDefined(self.tesla_head_gib_func) && !self.head_gibbed) {
            self[[self.tesla_head_gib_func]]();
          }
        } else {
          self clientfield::set("death_ray_shock_eye_fx", 1);
        }
      }
      self scene::play("cin_zm_dlc1_zombie_dth_deathray_0" + randomintrange(1, 5), self);
      self clientfield::set("death_ray_shock_eye_fx", 0);
      self clientfield::set("death_ray_shock_fx", 0);
      self.var_bce6e774 = undefined;
      if(isDefined(var_ecf98bb6) && isDefined(var_ecf98bb6.zapped_zombies)) {
        var_ecf98bb6.zapped_zombies++;
        var_ecf98bb6 notify("zombie_zapped");
      }
      self thread function_67cc41d(var_ecf98bb6, e_panel);
    }
  }
}

function function_67cc41d(attacker, e_panel) {
  self zombie_utility::zombie_eye_glow_stop();
  self clientfield::increment("death_ray_explode_fx");
  self notify("exploding");
  self notify("end_melee");
  self playSound("zmb_deathray_zombie_poof");
  if(isDefined(attacker)) {
    self notify("death", e_panel);
    level notify("trap_kill", self, attacker);
  }
  self ghost();
  self util::delay(0.25, undefined, & zm_utility::self_delete);
}

function function_41ecbdf9() {
  self endon("death");
  self.var_bce6e774 = 1;
  self.zombie_tesla_hit = 1;
  while(isDefined(self.var_bce6e774) && self.var_bce6e774) {
    if(!self.zombie_tesla_hit) {
      self.zombie_tesla_hit = 1;
    }
    wait(0.1);
  }
}

function function_991ffb6c(var_1a8c0e14) {
  self.var_1ea49cd7 = 1;
  if(isplayer(self)) {
    self clientfield::increment_to_player("tesla_beam_fx");
  } else {
    self clientfield::increment("tesla_beam_fx");
  }
}

function function_43b12d8e(v_position) {
  playsoundatposition("vox_maxis_tesla_pa_begin_1", v_position);
  level flag::wait_till("tesla_coil_cooldown");
  level flag::wait_till_clear("tesla_coil_cooldown");
  playsoundatposition("vox_maxis_tesla_pa_begin_0", v_position);
}

function function_90df19() {
  self endon("death");
  self endon("disconnect");
  wait(3);
  self zm_audio::create_and_play_dialog("trap", "start");
}

function debug_line(v_start, v_end) {
  n_timer = 0;
  while(n_timer < 10) {
    line(v_start, v_end, (1, 0, 0));
    wait(0.05);
    n_timer = n_timer + 0.05;
  }
}