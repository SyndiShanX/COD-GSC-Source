/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_elemental_bow_storm.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_ai_mechz;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_elemental_bow;
#using scripts\zm\_zm_weapons;
#namespace _zm_weap_elemental_bow_storm;

function autoexec __init__sytem__() {
  system::register("_zm_weap_elemental_bow_storm", & __init__, & __main__, undefined);
}

function __init__() {
  level.var_16e90d5f = getweapon("elemental_bow_storm");
  level.var_5d4538da = getweapon("elemental_bow_storm4");
  clientfield::register("toplayer", "elemental_bow_storm" + "_ambient_bow_fx", 5000, 1, "int");
  clientfield::register("missile", "elemental_bow_storm" + "_arrow_impact_fx", 5000, 1, "int");
  clientfield::register("missile", "elemental_bow_storm4" + "_arrow_impact_fx", 5000, 1, "int");
  clientfield::register("scriptmover", "elem_storm_fx", 5000, 1, "int");
  clientfield::register("toplayer", "elem_storm_whirlwind_rumble", 1, 1, "int");
  clientfield::register("scriptmover", "elem_storm_bolt_fx", 5000, 1, "int");
  clientfield::register("scriptmover", "elem_storm_zap_ambient", 5000, 1, "int");
  clientfield::register("actor", "elem_storm_shock_fx", 5000, 2, "int");
  callback::on_connect( & function_ff153c1a);
}

function __main__() {}

function function_ff153c1a() {
  self thread zm_weap_elemental_bow::function_982419bb("elemental_bow_storm");
  self thread zm_weap_elemental_bow::function_ececa597("elemental_bow_storm", "elemental_bow_storm4");
  self thread zm_weap_elemental_bow::function_7bc6b9d("elemental_bow_storm", "elemental_bow_storm4", & function_e2bef70c);
}

function function_e2bef70c(weapon, v_position, radius, attacker, normal) {
  self.var_a51c6ff2 = & function_3c763f48;
  if(issubstr(weapon.name, "elemental_bow_storm4")) {
    var_d68af64c = self zm_weap_elemental_bow::function_866906f(v_position, weapon.name, attacker, 64, self.var_a51c6ff2);
    v_position = (isdefined(var_d68af64c) ? var_d68af64c : v_position);
    self thread function_35612a9e(v_position + vectorscale((0, 0, 1), 48));
  } else {
    var_d68af64c = self zm_weap_elemental_bow::function_866906f(v_position, weapon.name, attacker, 32, self.var_a51c6ff2);
    v_position = (isdefined(var_d68af64c) ? var_d68af64c : v_position);
    self thread function_578bf1ca(v_position + vectorscale((0, 0, 1), 32), 3.6, attacker, 0);
  }
}

function function_578bf1ca(v_hit_pos, var_31d6c509, var_337b3336, var_94d13bd0) {
  zombie_utility::set_zombie_var("tesla_head_gib_chance", 75);
  var_ccda8d5b = (var_94d13bd0 ? 4 : 1);
  if(!(isdefined(var_94d13bd0) && var_94d13bd0)) {
    var_337b3336 = util::spawn_model("tag_origin", v_hit_pos);
    var_337b3336.b_in_use = 1;
    var_337b3336.var_ff541a23 = 1;
  }
  if(!isdefined(var_337b3336.var_5d0ae7cb)) {
    var_337b3336.var_5d0ae7cb = [];
    for (i = 0; i < var_ccda8d5b; i++) {
      var_337b3336.var_5d0ae7cb[i] = util::spawn_model("tag_origin", var_337b3336.origin);
      util::wait_network_frame();
    }
  }
  foreach(var_6e7a59eb in var_337b3336.var_5d0ae7cb) {
    var_6e7a59eb.var_83cc6f07 = 0;
  }
  var_337b3336.n_lifetime = var_31d6c509;
  var_98ecdcff = var_31d6c509 + 1;
  var_f52020f0 = 0;
  var_7b58139b = 160;
  var_c48d320e = 0.6;
  if(var_94d13bd0) {
    var_7b58139b = 320;
    var_c48d320e = 0.233;
  }
  if(!(isdefined(var_94d13bd0) && var_94d13bd0)) {
    var_337b3336 clientfield::set("elem_storm_zap_ambient", 1);
  }
  while (var_337b3336.n_lifetime > 0 && (isdefined(var_337b3336.b_in_use) && var_337b3336.b_in_use)) {
    if(var_337b3336.n_lifetime < var_98ecdcff) {
      var_f86783a4 = undefined;
      var_f86783a4 = var_337b3336 function_2624b852();
      if(isdefined(var_f86783a4)) {
        var_1c7748 = var_337b3336 function_8f86e6d5(var_7b58139b, self);
        foreach(ai_enemy in var_1c7748) {
          if(bullettracepassed(ai_enemy getcentroid(), var_337b3336.origin, 0, var_337b3336)) {
            ai_enemy thread function_2d3e3c1b(self, var_337b3336, var_f86783a4, var_94d13bd0);
            break;
          }
        }
      }
      var_98ecdcff = var_337b3336.n_lifetime - var_c48d320e;
    }
    wait(0.05);
    var_337b3336.n_lifetime = var_337b3336.n_lifetime - 0.05;
  }
  if(!(isdefined(var_94d13bd0) && var_94d13bd0)) {
    var_337b3336 clientfield::set("elem_storm_zap_ambient", 0);
  }
  if(isdefined(var_337b3336.var_ff541a23) && var_337b3336.var_ff541a23) {
    util::wait_network_frame();
    var_337b3336 delete();
    array::run_all(var_337b3336.var_5d0ae7cb, & delete);
    if(isdefined(var_337b3336.var_627f5ce9)) {
      var_337b3336.var_627f5ce9 delete();
    }
  } else {
    foreach(var_6e7a59eb in var_337b3336.var_5d0ae7cb) {
      var_6e7a59eb clientfield::set("elem_storm_bolt_fx", 0);
    }
  }
}

function function_8f86e6d5(var_7b58139b, e_player) {
  a_ai_enemies = getaiteamarray(level.zombie_team);
  var_1c7748 = array::get_all_closest(self.origin, a_ai_enemies, undefined, undefined, var_7b58139b);
  if(zm_utility::is_player_valid(e_player)) {
    var_1c7748 = array::get_all_closest(e_player.origin, var_1c7748);
  }
  var_1c7748 = array::filter(var_1c7748, 0, & zm_weap_elemental_bow::function_5aec3adc);
  var_1c7748 = array::filter(var_1c7748, 0, & function_172d425);
  return var_1c7748;
}

function function_172d425(ai_enemy) {
  return !(isdefined(ai_enemy.var_789ebfb2) && ai_enemy.var_789ebfb2);
}

function function_2624b852() {
  foreach(var_6e7a59eb in self.var_5d0ae7cb) {
    if(isdefined(var_6e7a59eb) && isdefined(var_6e7a59eb.var_83cc6f07) && !var_6e7a59eb.var_83cc6f07) {
      return var_6e7a59eb;
    }
  }
  return undefined;
}

function function_2d3e3c1b(e_player, var_337b3336, var_6e7a59eb, var_94d13bd0) {
  if(var_94d13bd0) {
    var_9b78d768 = var_337b3336.origin + (0, 0, randomintrange(0, 96));
  } else {
    var_9b78d768 = var_337b3336.origin;
  }
  self.var_789ebfb2 = 1;
  var_6e7a59eb.var_83cc6f07 = 1;
  var_b50659f2 = 0;
  var_6e7a59eb.origin = var_9b78d768;
  var_27dc1e70 = var_9b78d768;
  var_75332e4 = self getcentroid();
  var_21c86fc5 = vectornormalize(var_75332e4 - var_27dc1e70);
  var_ad60dac2 = vectortoangles(var_21c86fc5);
  var_ad60dac2 = (var_ad60dac2[0], var_ad60dac2[1], randomint(360));
  var_6e7a59eb.angles = var_ad60dac2;
  var_6e7a59eb linkto(var_337b3336);
  wait(0.05);
  var_6e7a59eb clientfield::set("elem_storm_bolt_fx", 1);
  wait(0.2);
  if(isdefined(self) && isalive(self)) {
    if(self.archetype === "mechz") {
      var_3bb42832 = level.mechz_health;
      if(isdefined(level.var_f4dc2834)) {
        var_3bb42832 = math::clamp(var_3bb42832, 0, level.var_f4dc2834);
      }
      var_508db998 = (var_94d13bd0 ? 0.03 : 0.01);
      n_damage = (var_3bb42832 * var_508db998) / 0.2;
      str_damage_mod = "MOD_PROJECTILE_SPLASH";
      var_79be6e3b = self.health / 0.2;
    } else {
      n_damage = 4782;
      str_damage_mod = "MOD_UNKNOWN";
      var_79be6e3b = self.health;
    }
    var_dfc0ef57 = 0;
    if(isdefined(e_player) && (isdefined(level.zombie_vars[e_player.team]["zombie_insta_kill"]) && level.zombie_vars[e_player.team]["zombie_insta_kill"]) && self.archetype !== "mechz") {
      var_dfc0ef57 = 1;
    }
    if(var_79be6e3b > n_damage && !var_dfc0ef57) {
      self dodamage(n_damage, self.origin, e_player, e_player, undefined, str_damage_mod, 0, level.var_16e90d5f);
      if(var_94d13bd0) {
        var_b50659f2 = 1;
        if(self.archetype === "mechz") {
          self thread function_23c30f35(e_player, var_9b78d768, var_337b3336);
        } else {
          self thread function_8a5627f3(e_player, var_9b78d768, var_337b3336);
        }
      } else {
        self.var_789ebfb2 = 0;
      }
    } else {
      self thread function_b6e08804(e_player, var_94d13bd0);
    }
  }
  if(var_b50659f2) {
    wait(2.166);
  }
  var_6e7a59eb clientfield::set("elem_storm_bolt_fx", 0);
  var_6e7a59eb.var_83cc6f07 = 0;
  var_6e7a59eb unlink();
}

function function_b6e08804(e_player, var_94d13bd0) {
  self endon("death");
  n_damage = self.health;
  str_damage_mod = "MOD_UNKNOWN";
  if(var_94d13bd0) {
    if(self.archetype === "zombie") {
      if(zm_weap_elemental_bow::function_5aec3adc(self)) {
        self setplayercollision(0);
        self.var_98056717 = 1;
        self clientfield::set("elem_storm_shock_fx", 2);
        self scene::play("cin_zm_dlc1_zombie_dth_deathray_0" + randomintrange(1, 5), self);
        self clientfield::set("elem_storm_shock_fx", 0);
        self.var_98056717 = 0;
        if(var_94d13bd0) {
          self zm_spawner::zombie_explodes_intopieces(0);
        }
      }
    } else if(self.archetype === "mechz") {
      n_damage = self.health / 0.2;
      str_damage_mod = "MOD_PROJECTILE_SPLASH";
    }
  } else if(self.archetype === "zombie") {
    self function_70319d26(1);
  }
  if(zm_utility::is_player_valid(e_player) && isdefined(e_player.zapped_zombies) && self.archetype === "zombie") {
    e_player.zapped_zombies++;
    e_player notify("zombie_zapped");
  }
  var_2f7fd5db = (var_94d13bd0 ? level.var_5d4538da : level.var_16e90d5f);
  self dodamage(n_damage, self.origin, e_player, e_player, undefined, str_damage_mod, 0, var_2f7fd5db);
  self.var_789ebfb2 = 0;
  self setplayercollision(1);
}

function function_8a5627f3(e_player, var_126c274b, var_337b3336) {
  self endon("death");
  var_8fd6fdde = 2.166;
  if(var_337b3336.n_lifetime < 2.166) {
    var_8fd6fdde = var_337b3336.n_lifetime;
  }
  if(var_8fd6fdde > 0.5) {
    self function_70319d26(var_8fd6fdde);
  }
  self function_b6e08804(e_player, 1);
}

function function_70319d26(n_time) {
  self endon("death");
  n_counter = 0;
  self clientfield::set("elem_storm_shock_fx", 1);
  while (n_counter < n_time) {
    self.zombie_tesla_hit = 1;
    wait(0.2);
    n_counter = n_counter + 0.2;
  }
  self.zombie_tesla_hit = 0;
  self notify("hash_6b758a38");
  self clientfield::set("elem_storm_shock_fx", 0);
}

function function_23c30f35(e_player, var_126c274b, var_337b3336) {
  self endon("death");
  if(!(isdefined(self.var_38fc90ba) && self.var_38fc90ba) && var_337b3336.n_lifetime > 2.5) {
    self.var_98056717 = 1;
    self.var_38fc90ba = 1;
    self.var_ab0efcf6 = self.origin;
    self thread scene::play("cin_zm_dlc1_mechz_dth_deathray_01", self);
    self thread function_ef25be5(var_337b3336);
    self thread function_bffbed67(e_player, var_337b3336);
    util::waittill_any_ents_two(self, "mechz_zap_lift_end", var_337b3336, "elem_storm_whirlwind_done");
    wait(0.1);
    self scene::stop("cin_zm_dlc1_mechz_dth_deathray_01");
    self thread zm_ai_mechz::function_bb84a54(self);
    self.var_789ebfb2 = 0;
    self.var_98056717 = 0;
    self.var_d3c478a0 = 1;
    wait(16);
    self.var_d3c478a0 = 0;
    self.var_38fc90ba = 0;
  } else {
    self.var_789ebfb2 = 0;
  }
}

function function_ef25be5(var_337b3336) {
  self endon("death");
  var_337b3336 endon("death");
  var_337b3336 endon("elem_storm_whirlwind_done");
  var_afc016d4 = distance(self.origin, var_337b3336.origin) + 200;
  var_2341c130 = (var_afc016d4 > 320 ? 320 : var_afc016d4);
  var_f33cfd13 = var_2341c130 * var_2341c130;
  while (true) {
    if(distancesquared(self.origin, var_337b3336.origin) > var_f33cfd13) {
      self notify("mechz_zap_lift_end");
      break;
    }
    wait(0.2);
  }
}

function function_bffbed67(e_player, var_337b3336) {
  self endon("death");
  self endon("mechz_zap_lift_end");
  var_337b3336 endon("elem_storm_whirlwind_done");
  if(!isdefined(var_337b3336.var_627f5ce9)) {
    var_337b3336.var_627f5ce9 = util::spawn_model("tag_origin", self.origin);
  }
  while (true) {
    wait(1.4);
    self thread function_2d3e3c1b(e_player, var_337b3336, var_337b3336.var_627f5ce9, 1);
  }
}

function function_35612a9e(v_hit_pos) {
  if(!isdefined(self.var_3b7b1ee)) {
    self.var_3b7b1ee = [];
    for (i = 0; i < 1; i++) {
      self.var_3b7b1ee[i] = util::spawn_model("tag_origin", (0, 0, 0), vectorscale((-1, 0, 0), 90));
      self.var_3b7b1ee[i].b_in_use = 0;
      util::wait_network_frame();
    }
  }
  if(zm_utility::is_player_valid(self)) {
    var_34137522 = self function_3f099cfa();
    if(isdefined(var_34137522)) {
      var_34137522.b_in_use = 1;
      var_34137522.script_int = gettime();
      var_34137522.var_d8bee13b = 0;
      v_ground_pos = util::ground_position(v_hit_pos, 1000, vectorscale((0, 0, 1), 16)[2]);
      if((v_hit_pos[2] - v_ground_pos[2]) < 64) {
        var_34137522.origin = v_ground_pos;
      } else {
        var_34137522.origin = v_hit_pos;
      }
      wait(0.05);
      var_34137522 clientfield::set("elem_storm_fx", 1);
      var_34137522 thread function_2f036bd6();
      var_34137522 thread function_50d5f4ab(self);
      var_34137522 thread function_8a0ca69(self);
      str_return = var_34137522 util::waittill_any_timeout(7.8, "elem_storm_whirlwind_force_off");
      var_34137522 clientfield::set("elem_storm_fx", 0);
      var_34137522 notify("elem_storm_whirlwind_done");
      var_34137522.b_in_use = 0;
    }
  }
}

function function_8a0ca69(e_player) {
  e_player function_578bf1ca((0, 0, 0), 7.8, self, 1);
}

function function_3f099cfa() {
  for (i = 0; i < self.var_3b7b1ee.size; i++) {
    if(!(isdefined(self.var_3b7b1ee[i].b_in_use) && self.var_3b7b1ee[i].b_in_use)) {
      return self.var_3b7b1ee[i];
    }
  }
  var_3b7b1ee = array::sort_by_script_int(self.var_3b7b1ee, 1);
  var_3b7b1ee[0] notify("elem_storm_whirlwind_force_off");
  wait(0.1);
  return var_3b7b1ee[0];
}

function function_50d5f4ab(e_player) {
  self endon("elem_storm_whirlwind_done");
  while (true) {
    v_ground_pos = util::ground_position(self.origin + (0, 0, 1), 1000, vectorscale((0, 0, 1), 16)[2]);
    n_z_diff = abs(self.origin[2] - v_ground_pos[2]);
    if(n_z_diff > 0) {
      n_time = n_z_diff / 256;
      self moveto(v_ground_pos, n_time, n_time * 0.5);
      wait(n_time);
    }
    v_away_from_source = undefined;
    var_dafafc83 = 64;
    a_ai_enemies = self function_8f86e6d5(768, e_player);
    if(a_ai_enemies.size) {
      foreach(ai_enemy in a_ai_enemies) {
        if(bullettracepassed(ai_enemy getcentroid(), self.origin + vectorscale((0, 0, 1), 12), 0, self)) {
          var_25cdb267 = vectornormalize(ai_enemy.origin - self.origin);
          var_25cdb267 = (var_25cdb267[0], var_25cdb267[1], 0);
          v_away_from_source = var_25cdb267 * 128;
          break;
        }
      }
    }
    if(!isdefined(v_away_from_source)) {
      var_29d9cc6 = randomintrange(-1, 2);
      if(!var_29d9cc6) {
        var_f72391bd = (randomint(100) < 50 ? 1 : -1);
      } else {
        var_f72391bd = randomintrange(-1, 2);
      }
      v_away_from_source = (128 * var_29d9cc6, 128 * var_f72391bd, 0);
      var_dafafc83 = randomfloatrange(16, 48);
      var_78870509 = self.origin + vectorscale((0, 0, 1), 12);
      a_trace = physicstraceex(var_78870509, var_78870509 + v_away_from_source, vectorscale((-1, -1, -1), 24), vectorscale((1, 1, 1), 24), self);
      v_away_from_source = v_away_from_source * a_trace["fraction"];
    }
    n_length = length(v_away_from_source);
    n_time = n_length / var_dafafc83;
    n_time = (n_time < 1 ? 1 : n_time);
    v_on_navmesh = getclosestpointonnavmesh(self.origin + v_away_from_source, 128, 64);
    if(!isdefined(v_on_navmesh)) {
      v_on_navmesh = self.origin + v_away_from_source;
    } else {
      v_on_navmesh = v_on_navmesh + vectorscale((0, 0, 1), 16);
    }
    self moveto(v_on_navmesh, n_time, n_time * 0.5);
    wait(n_time);
  }
}

function function_2f036bd6() {
  self endon("elem_storm_whirlwind_done");
  while (true) {
    foreach(e_player in level.activeplayers) {
      if(isdefined(e_player) && (!(isdefined(e_player.var_a70814ea) && e_player.var_a70814ea))) {
        if(distancesquared(e_player.origin, self.origin) < 16384) {
          e_player thread function_c9b501b8(self);
        }
      }
    }
    wait(0.05);
  }
}

function function_c9b501b8(var_34137522) {
  self endon("disconnect");
  self endon("bled_out");
  self.var_a70814ea = 1;
  self clientfield::set_to_player("elem_storm_whirlwind_rumble", 1);
  while (distancesquared(self.origin, var_34137522.origin) < 16384 && (isdefined(var_34137522.b_in_use) && var_34137522.b_in_use)) {
    wait(0.05);
  }
  self.var_a70814ea = 0;
  self clientfield::set_to_player("elem_storm_whirlwind_rumble", 0);
}

function function_88b53a11(var_80242169, v_hit_origin, var_3fee16b8) {
  var_bba6e664 = anglestoforward(var_3fee16b8.angles);
  var_3e878400 = vectornormalize(var_bba6e664 * -1);
  var_75181c09 = v_hit_origin + (var_3e878400 * var_80242169);
  return var_75181c09;
}

function function_3c763f48(str_weapon_name, v_source, v_destination) {
  wait(0.1);
  str_weapon_name = (str_weapon_name == "elemental_bow_storm4" ? "elemental_bow_storm4_ricochet" : "elemental_bow_storm_ricochet");
  magicbullet(getweapon(str_weapon_name), v_source, v_destination, self);
}