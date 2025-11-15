/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_planting.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\aat_shared;
#using scripts\shared\ai\archetype_thrasher;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_attackables;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_hero_weapon;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_pack_a_punch;
#using scripts\zm\_zm_pack_a_punch_util;
#using scripts\zm\_zm_perk_random;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_power;
#using scripts\zm\_zm_powerup_island_seed;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_cymbal_monkey;
#using scripts\zm\_zm_weap_keeper_skull;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\craftables\_zm_craftables;
#using scripts\zm\zm_island_main_ee_quest;
#using scripts\zm\zm_island_power;
#using scripts\zm\zm_island_skullweapon_quest;
#using scripts\zm\zm_island_takeo_fight;
#using scripts\zm\zm_island_util;
#using scripts\zm\zm_island_vo;
#namespace zm_island_planting;

function main() {
  register_clientfields();
  level.bonus_points_powerup_override = & function_bb96e04a;
  level thread init_planting_spots();
  function_54af12e9();
  function_72298dfd();
  function_cd4b5ba1();
  function_349e17a5();
  function_869faee7();
  function_1b391116();
  function_e851ad39();
}

function register_clientfields() {
  clientfield::register("scriptmover", "plant_growth_siege_anims", 9000, 2, "int");
  clientfield::register("scriptmover", "cache_plant_interact_fx", 9000, 1, "int");
  clientfield::register("scriptmover", "plant_hit_with_ww_fx", 9000, 1, "int");
  clientfield::register("scriptmover", "plant_watered_fx", 9000, 1, "int");
  clientfield::register("scriptmover", "planter_model_watered", 9000, 1, "int");
  clientfield::register("scriptmover", "babysitter_plant_fx", 9000, 1, "int");
  clientfield::register("scriptmover", "trap_plant_fx", 9000, 1, "int");
  clientfield::register("toplayer", "player_spawned_from_clone_plant", 9000, 1, "int");
  clientfield::register("toplayer", "player_cloned_fx", 9000, 1, "int");
  clientfield::register("scriptmover", "zombie_or_grenade_spawned_from_minor_cache_plant", 9000, 2, "int");
  clientfield::register("allplayers", "player_vomit_fx", 9000, 1, "int");
}

function function_bb96e04a() {
  return 500;
}

function init_planting_spots() {
  a_s_planting_spots = struct::get_array("planting_spot", "targetname");
  foreach(s_planting_spot in a_s_planting_spots) {
    s_planting_spot function_fedc998b();
  }
  level.a_s_planting_spots = a_s_planting_spots;
}

function function_fedc998b(var_e7abf7d0 = 0) {
  if(var_e7abf7d0 == 0) {
    self.model = util::spawn_model("p7_zm_isl_plant_planter", self.origin, self.angles);
  }
  s_plant_unitrigger = spawnStruct();
  s_plant_unitrigger.origin = self.origin + vectorscale((0, 0, 1), 8);
  s_plant_unitrigger.angles = self.angles;
  s_plant_unitrigger.s_parent = self;
  s_plant_unitrigger.script_unitrigger_type = "unitrigger_box_use";
  s_plant_unitrigger.cursor_hint = "HINT_NOICON";
  s_plant_unitrigger.require_look_at = 0;
  s_plant_unitrigger.script_width = 100;
  s_plant_unitrigger.script_length = 100;
  s_plant_unitrigger.script_height = 150;
  s_plant_unitrigger.prompt_and_visibility_func = & planting_spot_trigger_visibility;
  zm_unitrigger::register_static_unitrigger(s_plant_unitrigger, & planting_spot_unitrigger_think);
  self.s_plant_unitrigger = s_plant_unitrigger;
  self.var_75c7a97e = 0;
  self.var_594609f9 = 0;
  self.var_e7abf7d0 = var_e7abf7d0;
  self.s_plant = spawnStruct();
  self.s_plant.model = util::spawn_model("tag_origin", self.origin, self.angles);
  self.s_plant.var_75bf845a = [];
  self.s_plant.var_49d71b32 = 0;
  self.s_plant.var_198c12a1 = 0;
  self.s_plant.var_8d8becb0 = 0;
  self.s_plant.var_5a41bc99 = 0;
  self.s_plant.var_4d34f582 = 0;
  self.s_plant flag::init("plant_interact_trigger_used");
  self thread function_ae64b39a(undefined, self.var_e7abf7d0);
}

function planting_spot_trigger_visibility(e_player) {
  if(e_player zm_utility::in_revive_trigger()) {
    self sethintstring(&"");
    return false;
  }
  if(e_player.is_drinking > 0) {
    self sethintstring(&"");
    return false;
  }
  if(!zm_utility::is_player_valid(e_player)) {
    self sethintstring(&"");
    return false;
  }
  if(self.stub.s_parent.s_plant.var_198c12a1 == 1) {
    self sethintstring(&"");
    return false;
  }
  if(self.stub.s_parent.var_75c7a97e == 0) {
    if(e_player clientfield::get_to_player("has_island_seed")) {
      self sethintstring(&"ZM_ISLAND_PLANT_SEED");
      return true;
    }
    self sethintstring(&"");
    return false;
  }
  if(self.stub.s_parent.var_594609f9 == 0 && self.stub.s_parent.s_plant.var_4d34f582 == 0 && self.stub.s_parent.s_plant.var_5a41bc99 == 0 && self.stub.s_parent.var_e7abf7d0 == 0) {
    if(isDefined(e_player.var_6fd3d65c) && e_player.var_6fd3d65c && e_player.var_bb2fd41c > 0) {
      self sethintstring(&"ZM_ISLAND_WATER_PLANT");
      return true;
    }
    self sethintstring(&"");
    return false;
  }
  self sethintstring(&"");
  return false;
}

function planting_spot_unitrigger_think() {
  while(true) {
    self waittill("trigger", e_who);
    if(e_who zm_utility::in_revive_trigger()) {
      continue;
    }
    if(e_who.is_drinking > 0) {
      continue;
    }
    if(!zm_utility::is_player_valid(e_who)) {
      continue;
    }
    if(self.stub.s_parent.var_75c7a97e == 0) {
      if(e_who clientfield::get_to_player("has_island_seed")) {
        self.stub.s_parent notify("hash_fa482f7", e_who);
      }
    } else if(self.stub.s_parent.s_plant.var_4d34f582 == 0 && self.stub.s_parent.s_plant.var_5a41bc99 == 0 && self.stub.s_parent.var_e7abf7d0 == 0) {
      if(isDefined(e_who.var_6fd3d65c) && e_who.var_6fd3d65c && isDefined(e_who.var_bb2fd41c) && e_who.var_bb2fd41c > 0 && isDefined(e_who.var_c6cad973)) {
        self.stub.s_parent notify("hash_8626f7f1", e_who);
      }
    }
  }
}

function function_ae64b39a(var_9636d237, var_f40460f5, var_895cb900 = 0) {
  self endon("hash_378095a2");
  self endon("hash_7a0cef7b");
  while(true) {
    if(!isDefined(var_9636d237) && !var_895cb900) {
      self waittill("hash_fa482f7", e_who);
      if(!e_who clientfield::get_to_player("has_island_seed")) {
        continue;
      }
      self.var_561a9c48 = e_who;
      level thread zm_powerup_island_seed::function_58b6724f(e_who);
      e_who playSound("evt_island_seed_plant");
      e_who zm_island_vo::function_7f4cb4c("plant", "seed", 1);
    } else {
      self.var_561a9c48 = level.activeplayers[0];
    }
    self.var_75c7a97e = 1;
    self.s_plant.var_198c12a1 = 1;
    self thread function_18d2ce8b();
    self thread function_447658c7(var_9636d237, var_f40460f5);
    self thread function_4357491f();
    self waittill("hash_98cf252f");
    if(isDefined(var_f40460f5) && var_f40460f5) {
      wait(2);
    } else if(!isDefined(var_9636d237)) {
      level waittill("end_of_round");
    }
    self scene::play("p7_fxanim_zm_island_plant_dead_bundle", self.s_plant.model);
    self.s_plant.model ghost();
    self.var_75c7a97e = 0;
    self.var_561a9c48 = undefined;
    if(isDefined(var_9636d237)) {
      var_9636d237 = undefined;
    }
  }
}

function function_18d2ce8b() {
  wait(1);
  self.s_plant.var_198c12a1 = 0;
}

function function_447658c7(var_9636d237, var_f40460f5) {
  if(!isDefined(var_9636d237)) {
    self thread function_ffa65395(var_f40460f5);
    self thread function_5026698c(var_f40460f5);
    self.s_plant.var_8d8becb0 = 0;
    self.s_plant.var_5a41bc99 = 0;
    for(n_round = 0; n_round < 3; n_round++) {
      switch (n_round) {
        case 0: {
          self.s_plant.model setModel("p7_fxanim_zm_island_plant_seed_mod");
          self.s_plant.model show();
          self.s_plant.model notsolid();
          self scene::init("p7_fxanim_zm_island_plant_stage1_bundle", self.s_plant.model);
          self.s_plant.model playSound("evt_island_seed_grow_stage_1");
          break;
        }
        case 1: {
          self.s_plant.model clientfield::set("plant_growth_siege_anims", 1);
          self scene::play("p7_fxanim_zm_island_plant_stage1_bundle", self.s_plant.model);
          self.s_plant.model playSound("evt_island_seed_grow_stage_2");
          break;
        }
        case 2: {
          self.s_plant.model solid();
          self.s_plant.model disconnectpaths();
          self.s_plant.model clientfield::set("plant_growth_siege_anims", 2);
          self scene::play("p7_fxanim_zm_island_plant_stage2_bundle", self.s_plant.model);
          self.s_plant.model playSound("evt_island_seed_grow_stage_3");
          self thread function_4357491f();
          break;
        }
        default: {
          break;
        }
      }
      if(isDefined(var_f40460f5) && var_f40460f5) {
        wait(2);
        self notify("hash_67f478bd");
        continue;
      }
      if(self.s_plant.var_5a41bc99 == 1) {
        util::wait_network_frame();
        continue;
        continue;
      }
      level waittill("end_of_round");
      if(isDefined(self.s_plant.var_8d8becb0) && self.s_plant.var_8d8becb0) {
        self.s_plant.var_8d8becb0 = 0;
        continue;
      }
      self notify("hash_70cb3a5f");
      self.s_plant.var_5a41bc99 = 1;
    }
  }
  if(isDefined(var_f40460f5) && var_f40460f5) {
    self.s_plant.model clientfield::set("plant_hit_with_ww_fx", 0);
  }
  self.s_plant.model clientfield::set("plant_growth_siege_anims", 3);
  self thread scene::play("p7_fxanim_zm_island_plant_stage3_bundle", self.s_plant.model);
  self.s_plant.model waittill("hash_116e737b");
  self.var_594609f9 = 1;
  self.s_plant.model clientfield::set("plant_hit_with_ww_fx", 0);
  self.s_plant.model clientfield::set("plant_watered_fx", 0);
  println("");
  self function_26651461(self.s_plant.var_75bf845a, self.s_plant.var_49d71b32, var_9636d237, var_f40460f5);
  self.s_plant.model clientfield::set("cache_plant_interact_fx", 0);
  if(!isDefined(var_9636d237)) {
    self.s_plant.model setModel("p7_fxanim_zm_island_plant_dead_mod");
    self scene::init("p7_fxanim_zm_island_plant_dead_bundle", self.s_plant.model);
  }
  self.s_plant.model notsolid();
  self.s_plant.model connectpaths();
  self notify("hash_98cf252f");
  self.var_594609f9 = 0;
  self.s_plant.var_75bf845a = [];
}

function function_49a83594() {
  self endon("hash_98cf252f");
  var_793f092a = 5;
  var_2bbd3ff9 = 40;
  t_kill = spawn("trigger_radius", self.origin + vectorscale((0, 0, 1), 50), 0, var_793f092a, var_2bbd3ff9);
  self thread function_b88d99d(t_kill);
  while(true) {
    foreach(player in level.activeplayers) {
      if(player istouching(t_kill) && zm_utility::is_player_valid(player)) {
        wait(2);
        if(player istouching(t_kill) && zm_utility::is_player_valid(player)) {
          v_moveto = undefined;
          while(!isDefined(v_moveto)) {
            v_moveto = getclosestpointonnavmesh(self.origin, 64);
            wait(0.05);
          }
          player playlocalsound(level.zmb_laugh_alias);
          player setorigin(v_moveto);
          player dodamage(player.health, self.origin);
        }
      }
    }
    wait(2);
  }
}

function function_b88d99d(t_kill) {
  self waittill("hash_98cf252f");
  t_kill delete();
}

function function_4357491f() {
  mdl_clip = spawncollision("collision_player_cylinder_32x256", "collider", self.origin + vectorscale((0, 0, 1), 125), (0, 0, 0));
  self waittill("hash_98cf252f");
  mdl_clip delete();
}

function function_ffa65395(var_f40460f5) {
  self endon("hash_70cb3a5f");
  if(isDefined(var_f40460f5) && var_f40460f5) {
    return;
  }
  self.s_plant.var_75bf845a = [];
  self.s_plant.var_2a1e031c = [];
  wait(1);
  for(n_round = 0; n_round < 3; n_round++) {
    self.s_plant.var_4d34f582 = 0;
    self waittill("hash_8626f7f1", user);
    if(isDefined(user.playernum)) {
      println((("" + user.playernum) + "") + user.var_c6cad973);
    }
    self.s_plant.var_4d34f582 = 1;
    user notify("update_challenge_1_3");
    user playSound("evt_island_seed_water");
    if(!isDefined(user.var_f6130406)) {
      user.var_f6130406 = 1;
      user notify("player_watered_plant");
    } else {
      n_rand = randomintrange(1, 101);
      if(n_rand <= 20) {
        user notify("player_watered_plant");
      }
    }
    self.s_plant.var_75bf845a[self.s_plant.var_75bf845a.size] = user.var_c6cad973;
    user thread zm_island_power::function_a84a1aec();
    array::add(self.s_plant.var_2a1e031c, user, 1);
    if(n_round == 2) {
      if(self.s_plant.var_2a1e031c[0] === self.s_plant.var_2a1e031c[1] && self.s_plant.var_2a1e031c[1] === self.s_plant.var_2a1e031c[2]) {
        user notify("update_challenge_1_1");
      }
    }
    self.s_plant.var_8d8becb0 = 1;
    self.s_plant.model clientfield::set("plant_watered_fx", 1);
    self.model clientfield::set("planter_model_watered", 1);
    level waittill("end_of_round");
    self.s_plant.model clientfield::set("plant_watered_fx", 0);
    self.model clientfield::set("planter_model_watered", 0);
  }
}

function function_5026698c(var_f40460f5) {
  self endon("hash_70cb3a5f");
  self.s_plant.var_49d71b32 = 0;
  for(n_round = 0; n_round < 3; n_round++) {
    self waittill("hash_8dfde2c8");
    self.s_plant.var_49d71b32++;
    self.s_plant.var_8d8becb0 = 1;
    self.s_plant.model clientfield::set("plant_hit_with_ww_fx", 1);
    if(isDefined(var_f40460f5) && var_f40460f5) {
      return;
    }
    level waittill("end_of_round");
    self.s_plant.model clientfield::set("plant_hit_with_ww_fx", 0);
  }
}

function function_26651461(var_75bf845a, var_49d71b32, var_9636d237, var_f40460f5) {
  var_b47da5df = [];
  var_b47da5df[0] = 0;
  var_b47da5df[1] = 0;
  var_b47da5df[2] = 0;
  var_b47da5df[3] = 0;
  var_b47da5df[4] = 0;
  var_b47da5df[5] = 0;
  var_b47da5df[6] = 0;
  var_b47da5df[7] = 0;
  var_b47da5df[8] = 0;
  var_b47da5df[9] = 0;
  var_b47da5df[10] = 0;
  var_1e67e37 = 0;
  var_34c1ce60 = 0;
  var_eaa9733b = 0;
  var_98b687fa = 0;
  if(self.script_noteworthy === "ee_planting_spot") {
    b_ee_planting_spot = 1;
  } else {
    b_ee_planting_spot = 0;
  }
  for(i = 0; i < var_75bf845a.size; i++) {
    if(var_75bf845a[i] == 4) {
      if(b_ee_planting_spot && !level flag::get("ww_upgrade_spawned_from_plant")) {
        continue;
        continue;
      }
      var_75bf845a[i] = randomintrange(1, 4);
    }
  }
  foreach(var_1153caa9 in var_75bf845a) {
    if(var_1153caa9 == 1) {
      var_1e67e37++;
      continue;
    }
    if(var_1153caa9 == 2) {
      var_34c1ce60++;
      continue;
    }
    if(var_1153caa9 == 3) {
      var_eaa9733b++;
      continue;
    }
    if(var_1153caa9 == 4) {
      var_98b687fa++;
    }
  }
  if(self.script_noteworthy === "ee_planting_spot") {
    self function_5726c670(var_98b687fa);
    return;
  }
  n_total = 0;
  if(level.var_50d5cc84 < 4) {
    if(var_49d71b32 == 3) {
      var_b47da5df[10] = 20;
    } else {
      var_b47da5df[10] = 5 * var_49d71b32;
    }
  }
  var_a476b929 = 100 - var_b47da5df[10];
  n_total = n_total + var_b47da5df[10];
  if(var_1e67e37 == 1 && var_34c1ce60 == 1 && var_eaa9733b == 1) {
    var_b47da5df[8] = var_a476b929 / 2;
    var_b47da5df[2] = (var_a476b929 / 2) / 3;
    var_b47da5df[4] = (var_a476b929 / 2) / 3;
    var_b47da5df[6] = (var_a476b929 / 2) / 3;
    var_b47da5df[0] = 0;
    var_b47da5df[1] = 0;
  } else {
    var_b47da5df[2] = var_a476b929 * (var_1e67e37 / 3);
    var_b47da5df[4] = var_a476b929 * (var_eaa9733b / 3);
    var_b47da5df[6] = var_a476b929 * (var_34c1ce60 / 3);
    n_total = n_total + ((var_b47da5df[2] + var_b47da5df[4]) + var_b47da5df[6]);
    if(var_75bf845a.size === 0 && var_49d71b32 === 0) {
      var_b47da5df[0] = 100 - n_total;
      var_b47da5df[1] = 0;
    } else {
      var_b47da5df[0] = 0;
      var_b47da5df[1] = 100 - n_total;
    }
  }
  var_b47da5df[3] = var_b47da5df[2] * (var_49d71b32 / 3);
  var_b47da5df[2] = abs(var_b47da5df[2] - var_b47da5df[3]);
  var_b47da5df[5] = var_b47da5df[4] * (var_49d71b32 / 3);
  var_b47da5df[4] = abs(var_b47da5df[4] - var_b47da5df[5]);
  var_b47da5df[7] = var_b47da5df[6] * (var_49d71b32 / 3);
  var_b47da5df[6] = abs(var_b47da5df[6] - var_b47da5df[7]);
  var_b47da5df[9] = var_b47da5df[8] * (var_49d71b32 / 3);
  var_b47da5df[8] = abs(var_b47da5df[8] - var_b47da5df[9]);
  if(isDefined(var_f40460f5) && var_f40460f5) {
    var_b47da5df = [];
    if(var_49d71b32 > 0) {
      var_b47da5df[5] = 100;
    } else {
      var_b47da5df[4] = 100;
    }
  }
  var_f48f47cc = [];
  var_29cc53bd = 0;
  foreach(plant, n_score in var_b47da5df) {
    if(n_score > 0) {
      var_f48f47cc[plant] = var_29cc53bd + n_score;
      var_29cc53bd = var_29cc53bd + n_score;
    }
  }
  n_random = randomfloatrange(0, 100);
  foreach(n_score in var_f48f47cc) {
    if(n_random <= n_score) {
      break;
    }
  }
  if(isDefined(var_9636d237)) {
    plant = var_9636d237;
  }
  switch (plant) {
    case 0: {
      self function_41663231();
      break;
    }
    case 1: {
      self function_41663231(1);
      break;
    }
    case 2: {
      self function_a6084535(0, var_98b687fa);
      break;
    }
    case 3: {
      self function_a6084535(1, var_98b687fa);
      break;
    }
    case 4: {
      self function_5d62716(0, var_f40460f5);
      break;
    }
    case 5: {
      self function_5d62716(1, var_f40460f5);
      break;
    }
    case 6: {
      self function_12c8548e();
      break;
    }
    case 7: {
      self function_12c8548e(1);
      break;
    }
    case 8: {
      self function_fd098f17();
      break;
    }
    case 9: {
      self function_fd098f17(1);
      break;
    }
    case 10: {
      self function_3e429652();
      break;
    }
    default: {
      break;
    }
  }
}

function function_54af12e9() {
  level.var_3f5e92d = getweapon("pistol_standard");
  level.var_f3798849 = getweapon("sniper_fastbolt");
  level.var_c29d7558 = getweapon("launcher_standard");
  level.var_b00f35c1 = getweapon("ar_marksman");
  var_b0612bf3 = [];
  var_b0612bf3["points"] = 10;
  var_b0612bf3["pistol"] = 10;
  var_b0612bf3["sniper"] = 10;
  var_b0612bf3["launcher"] = 10;
  var_b0612bf3["ar"] = 10;
  var_b0612bf3["zombie"] = 25;
  var_b0612bf3["grenade"] = 25;
  var_29cc53bd = 0;
  level.var_349b9c58 = [];
  foreach(str_reward, n_chance in var_b0612bf3) {
    level.var_349b9c58[str_reward] = n_chance + var_29cc53bd;
    var_29cc53bd = var_29cc53bd + n_chance;
  }
  var_ec35bcf6 = [];
  var_ec35bcf6["points"] = 35;
  var_ec35bcf6["pistol"] = 35;
  var_ec35bcf6["sniper"] = 10;
  var_ec35bcf6["launcher"] = 10;
  var_ec35bcf6["ar"] = 10;
  var_29cc53bd = 0;
  level.var_9d5349d = [];
  foreach(str_reward, n_chance in var_ec35bcf6) {
    level.var_9d5349d[str_reward] = n_chance + var_29cc53bd;
    var_29cc53bd = var_29cc53bd + n_chance;
  }
}

function function_41663231(b_upgraded = 0) {
  if(b_upgraded == 1) {
    println("");
  } else {
    println("");
  }
  if(isDefined(self.var_561a9c48)) {
    self.var_561a9c48 notify("minor_cache_plant_spawned");
  }
  level notify("minor_cache_plant_spawned");
  self.s_plant.model stopanimscripted();
  self.s_plant.model setModel("p7_fxanim_zm_island_plant_cache_minor_mod");
  self.s_plant.model show();
  self.s_plant.model solid();
  self.s_plant.model disconnectpaths();
  self.s_plant.model clientfield::set("cache_plant_interact_fx", 1);
  self thread scene::init("p7_fxanim_zm_island_plant_cache_minor_bundle", self.s_plant.model);
  self.s_plant.model waittill("hash_1879b5e4");
  self thread function_a6ebbe13();
  self waittill("hash_ebe5cad7", e_who);
  println("");
  zm_unitrigger::unregister_unitrigger(self.var_23c5e7a6);
  self.var_23c5e7a6 = undefined;
  self.s_plant.model clientfield::set("cache_plant_interact_fx", 0);
  self scene::play("p7_fxanim_zm_island_plant_cache_minor_bundle", self.s_plant.model);
  if(b_upgraded == 1) {
    var_3d9ef8e9 = level.var_9d5349d;
  } else {
    var_3d9ef8e9 = level.var_349b9c58;
  }
  n_reward = randomfloatrange(0, 100);
  foreach(n_chance in var_3d9ef8e9) {
    if(n_reward <= n_chance) {
      break;
    }
  }
  switch (str_reward) {
    case "points": {
      var_93eb638b = zm_powerups::specific_powerup_drop("bonus_points_player", self.origin + vectorscale((0, 0, 1), 8), undefined, undefined, 1);
      e_who notify("player_revealed_cache_plant_good");
      var_93eb638b util::waittill_any("powerup_grabbed", "death", "powerup_reset", "powerup_timedout");
      break;
    }
    case "pistol": {
      e_who notify("player_revealed_cache_plant_bad");
      self dig_up_weapon(e_who, level.var_3f5e92d);
      break;
    }
    case "sniper": {
      e_who notify("player_revealed_cache_plant_bad");
      self dig_up_weapon(e_who, level.var_f3798849);
      break;
    }
    case "launcher": {
      e_who notify("player_revealed_cache_plant_bad");
      self dig_up_weapon(e_who, level.var_c29d7558);
      break;
    }
    case "ar": {
      e_who notify("player_revealed_cache_plant_bad");
      self dig_up_weapon(e_who, level.var_b00f35c1);
      break;
    }
    case "zombie": {
      self.s_plant.model notsolid();
      self.s_plant.model connectpaths();
      wait(0.05);
      s_temp = spawnStruct();
      s_temp.origin = function_15c62ca8(self.origin, 20);
      if(!isDefined(s_temp.origin)) {
        s_temp.origin = self.origin;
      }
      s_temp.script_noteworthy = "custom_spawner_entry quick_riser_location";
      s_temp.script_string = "find_flesh";
      zombie_utility::spawn_zombie(level.zombie_spawners[0], "aether_zombie", s_temp);
      util::wait_network_frame();
      s_temp struct::delete();
      self.s_plant.model clientfield::set("zombie_or_grenade_spawned_from_minor_cache_plant", 1);
      self.s_plant.model util::delay(3, undefined, & clientfield::set, "zombie_or_grenade_spawned_from_minor_cache_plant", 0);
      e_who notify("player_revealed_cache_plant_bad");
      break;
    }
    case "grenade": {
      self.s_plant.model notsolid();
      self.s_plant.model connectpaths();
      wait(0.05);
      v_spawnpt = self.origin;
      grenade = getweapon("frag_grenade");
      e_who magicgrenadetype(grenade, v_spawnpt, vectorscale((0, 0, 1), 300), 3);
      self.s_plant.model clientfield::set("zombie_or_grenade_spawned_from_minor_cache_plant", 2);
      self.s_plant.model util::delay(3, undefined, & clientfield::set, "zombie_or_grenade_spawned_from_minor_cache_plant", 0);
      e_who notify("player_revealed_cache_plant_bad");
      break;
    }
    default: {
      break;
    }
  }
  self.s_plant.model clientfield::set("plant_growth_siege_anims", 0);
  self scene::play("p7_fxanim_zm_island_plant_cache_minor_death_bundle", self.s_plant.model);
}

function function_a6ebbe13() {
  s_plant_unitrigger = spawnStruct();
  s_plant_unitrigger.origin = self.origin + vectorscale((0, 0, 1), 8);
  s_plant_unitrigger.angles = self.angles;
  s_plant_unitrigger.s_parent = self;
  s_plant_unitrigger.script_unitrigger_type = "unitrigger_box_use";
  s_plant_unitrigger.cursor_hint = "HINT_NOICON";
  s_plant_unitrigger.require_look_at = 1;
  s_plant_unitrigger.script_width = 100;
  s_plant_unitrigger.script_length = 100;
  s_plant_unitrigger.script_height = 150;
  s_plant_unitrigger.prompt_and_visibility_func = & function_be57d4be;
  zm_unitrigger::register_static_unitrigger(s_plant_unitrigger, & function_241f6a3e);
  self.var_23c5e7a6 = s_plant_unitrigger;
  self.s_plant flag::clear("plant_interact_trigger_used");
}

function function_be57d4be(e_player) {
  if(e_player zm_utility::in_revive_trigger()) {
    self sethintstring(&"");
    return false;
  }
  if(e_player.is_drinking > 0) {
    self sethintstring(&"");
    return false;
  }
  if(!zm_utility::is_player_valid(e_player)) {
    self sethintstring(&"");
    return false;
  }
  if(self.stub.s_parent.s_plant flag::get("plant_interact_trigger_used")) {
    self sethintstring(&"");
    return false;
  }
  self sethintstring(&"ZM_ISLAND_CACHE_PLANT");
  return true;
}

function function_241f6a3e() {
  if(1) {
    for(;;) {
      self waittill("trigger", e_who);
    }
    for(;;) {}
    for(;;) {}
    if(e_who zm_utility::in_revive_trigger()) {}
    if(e_who.is_drinking > 0) {}
    if(!zm_utility::is_player_valid(e_who)) {}
    self.stub.s_parent notify("hash_ebe5cad7", e_who);
    self.stub.s_parent.s_plant flag::set("plant_interact_trigger_used");
    return;
  }
}

function function_72298dfd() {
  level.var_df105f37 = 50;
  var_b2846cef = getweapon("smg_mp40");
  var_f27e0342 = getweapon("shotgun_semiauto");
  var_6b0419bd = getweapon("ar_damage");
  var_1a2b2be0 = getweapon("lmg_slowfire");
  var_8847e925 = getweapon("ar_garand");
  var_21057d5f = getweapon("smg_longrange");
  level.var_b39227d1 = array(var_b2846cef, var_f27e0342, var_6b0419bd, var_1a2b2be0, var_8847e925, var_21057d5f);
  level.var_c88b32a2 = array("full_ammo", "nuke", "insta_kill", "double_points", "fire_sale", "carpenter", "minigun");
  var_56b02536 = getweapon("pistol_shotgun_dw");
  var_722e06cb = getweapon("shotgun_fullauto");
  var_d6376f9e = getweapon("sniper_fastsemi");
  var_4fa7d135 = getweapon("ray_gun");
  var_c71381ba = getweapon("bowie_knife");
  var_b4550164 = getweapon("cymbal_monkey");
  level.var_8aee1d4 = array(var_56b02536, var_722e06cb, var_d6376f9e, var_4fa7d135, var_c71381ba, var_b4550164);
  level.var_1a1ac6dd = array("full_ammo", "nuke", "insta_kill", "double_points", "fire_sale", "minigun");
  var_b0612bf3 = [];
  var_c6f9cb70 = 100;
  var_b0612bf3["points"] = var_c6f9cb70 / 3;
  var_b0612bf3["weapon"] = var_c6f9cb70 / 3;
  var_b0612bf3["powerup"] = var_c6f9cb70 / 3;
  var_29cc53bd = 0;
  level.var_170b1e5c = [];
  foreach(str_reward, n_chance in var_b0612bf3) {
    level.var_170b1e5c[str_reward] = n_chance + var_29cc53bd;
    var_29cc53bd = var_29cc53bd + n_chance;
  }
  level.var_e6d4b4ec = var_29cc53bd;
  var_ec35bcf6 = [];
  var_ec35bcf6["points"] = 30;
  var_ec35bcf6["weapon"] = 25;
  var_ec35bcf6["powerup"] = 25;
  var_ec35bcf6["perk_bottle"] = 20;
  var_29cc53bd = 0;
  level.var_ff3b49 = [];
  foreach(str_reward, n_chance in var_ec35bcf6) {
    level.var_ff3b49[str_reward] = n_chance + var_29cc53bd;
    var_29cc53bd = var_29cc53bd + n_chance;
  }
  level.var_2afecb6f = var_29cc53bd;
}

function function_a6084535(b_upgraded = 0, var_98b687fa) {
  if(b_upgraded == 1) {
    println("");
  } else {
    println("");
  }
  if(isDefined(self.var_561a9c48)) {
    self.var_561a9c48 notify("major_cache_plant_spawned");
  }
  level notify("major_cache_plant_spawned");
  self.s_plant.model stopanimscripted();
  if(b_upgraded == 1) {
    self.s_plant.model setModel("p7_fxanim_zm_island_plant_cache_major_glow_mod");
  } else {
    self.s_plant.model setModel("p7_fxanim_zm_island_plant_cache_major_mod");
  }
  self.s_plant.model clientfield::set("cache_plant_interact_fx", 1);
  self.s_plant.model show();
  self.s_plant.model solid();
  self.s_plant.model disconnectpaths();
  self thread scene::init("p7_fxanim_zm_island_plant_cache_major_bundle", self.s_plant.model);
  self.s_plant.model waittill("hash_aa2731d8");
  self thread function_192bd777();
  self waittill("hash_983c15d3", e_who);
  println("");
  zm_unitrigger::unregister_unitrigger(self.var_23c5e7a6);
  self.var_23c5e7a6 = undefined;
  self.s_plant.model clientfield::set("cache_plant_interact_fx", 0);
  self scene::play("p7_fxanim_zm_island_plant_cache_major_bundle", self.s_plant.model);
  if(b_upgraded == 1) {
    var_3d9ef8e9 = level.var_ff3b49;
    var_582b5c62 = level.var_2afecb6f;
  } else {
    var_3d9ef8e9 = level.var_170b1e5c;
    var_582b5c62 = level.var_e6d4b4ec;
  }
  n_reward = randomfloatrange(0, var_582b5c62);
  foreach(n_chance in var_3d9ef8e9) {
    if(n_reward <= n_chance) {
      break;
    }
  }
  if(b_upgraded == 1) {
    if(level flag::get("trilogy_released") && !level flag::get("aa_gun_ee_complete") && !level flag::get("player_has_aa_gun_ammo") && !level flag::get("aa_gun_ammo_loaded")) {
      n_chance = randomfloatrange(0, 100);
      if(n_chance <= level.var_df105f37) {
        str_reward = "aa_gun_ammo";
      } else {
        level.var_df105f37 = level.var_df105f37 + 10;
      }
    }
  }
  switch (str_reward) {
    case "points": {
      var_93eb638b = zm_powerups::specific_powerup_drop("bonus_points_team", self.origin + vectorscale((0, 0, 1), 8), undefined, undefined, 1);
      var_93eb638b thread function_61d38f32();
      e_who notify("player_revealed_cache_plant_good");
      var_93eb638b util::waittill_any("powerup_grabbed", "death", "powerup_reset", "powerup_timedout");
      break;
    }
    case "weapon": {
      if(b_upgraded == 1) {
        e_who notify("player_revealed_cache_plant_good");
        self dig_up_weapon(e_who, array::random(level.var_8aee1d4));
      } else {
        e_who notify("player_revealed_cache_plant_good");
        self dig_up_weapon(e_who, array::random(level.var_b39227d1));
      }
      break;
    }
    case "powerup": {
      if(b_upgraded == 1) {
        str_powerup = array::random(level.var_1a1ac6dd);
      } else {
        str_powerup = array::random(level.var_c88b32a2);
      }
      var_93eb638b = zm_powerups::specific_powerup_drop(str_powerup, self.origin + vectorscale((0, 0, 1), 8), undefined, undefined, 1);
      var_93eb638b thread function_61d38f32();
      e_who notify("player_revealed_cache_plant_good");
      var_93eb638b util::waittill_any("powerup_grabbed", "death", "powerup_reset", "powerup_timedout");
      break;
    }
    case "perk_bottle": {
      var_93eb638b = zm_powerups::specific_powerup_drop("empty_perk", self.origin + vectorscale((0, 0, 1), 8), undefined, undefined, 1);
      var_93eb638b thread function_61d38f32();
      e_who notify("player_revealed_cache_plant_good");
      var_93eb638b util::waittill_any("powerup_grabbed", "death", "powerup_reset", "powerup_timedout");
      break;
    }
    case "aa_gun_ammo": {
      self main_quest::function_1f4e6abd();
      break;
    }
  }
  self.s_plant.model clientfield::set("plant_growth_siege_anims", 0);
  self scene::play("p7_fxanim_zm_island_plant_cache_major_death_bundle", self.s_plant.model);
}

function function_192bd777() {
  s_plant_unitrigger = spawnStruct();
  s_plant_unitrigger.origin = self.origin + vectorscale((0, 0, 1), 8);
  s_plant_unitrigger.angles = self.angles;
  s_plant_unitrigger.s_parent = self;
  s_plant_unitrigger.script_unitrigger_type = "unitrigger_box_use";
  s_plant_unitrigger.cursor_hint = "HINT_NOICON";
  s_plant_unitrigger.require_look_at = 1;
  s_plant_unitrigger.script_width = 100;
  s_plant_unitrigger.script_length = 100;
  s_plant_unitrigger.script_height = 150;
  s_plant_unitrigger.prompt_and_visibility_func = & function_4fdc4f62;
  zm_unitrigger::register_static_unitrigger(s_plant_unitrigger, & function_a5e6439a);
  self.var_23c5e7a6 = s_plant_unitrigger;
  self.s_plant flag::clear("plant_interact_trigger_used");
}

function function_4fdc4f62(e_player) {
  if(e_player zm_utility::in_revive_trigger()) {
    self sethintstring(&"");
    return false;
  }
  if(e_player.is_drinking > 0) {
    self sethintstring(&"");
    return false;
  }
  if(!zm_utility::is_player_valid(e_player)) {
    self sethintstring(&"");
    return false;
  }
  if(self.stub.s_parent.s_plant flag::get("plant_interact_trigger_used")) {
    self sethintstring(&"");
    return false;
  }
  self sethintstring(&"ZM_ISLAND_CACHE_PLANT");
  return true;
}

function function_a5e6439a() {
  if(1) {
    for(;;) {
      self waittill("trigger", e_who);
    }
    for(;;) {}
    for(;;) {}
    if(e_who zm_utility::in_revive_trigger()) {}
    if(e_who.is_drinking > 0) {}
    if(!zm_utility::is_player_valid(e_who)) {}
    self.stub.s_parent notify("hash_983c15d3", e_who);
    self.stub.s_parent.s_plant flag::set("plant_interact_trigger_used");
    return;
  }
}

function function_cd4b5ba1() {
  scene::add_scene_func("zm_dlc2_plant_babysitter_gib_zombie", & function_389c8477, "play");
  scene::add_scene_func("zm_dlc2_plant_babysitter_grab_zombie_crawler", & function_a4a048a1, "play");
  scene::add_scene_func("zm_dlc2_plant_babysitter_grab_spider", & function_6d8761e4, "play");
  scene::add_scene_func("zm_dlc2_plant_babysitter_outro", & function_7a4276be, "done");
}

function function_12c8548e(b_upgraded = 0) {
  if(b_upgraded == 1) {
    println("");
  } else {
    println("");
  }
  if(isDefined(self.var_561a9c48)) {
    self.var_561a9c48 notify("babysitter_plant_spawned");
  }
  level notify("babysitter_plant_spawned");
  if(b_upgraded == 1) {
    self.s_plant.model setModel("p7_zm_isl_plant_babysitter_glow");
  } else {
    self.s_plant.model setModel("p7_zm_isl_plant_babysitter");
  }
  self.s_plant.model show();
  self.s_plant.model solid();
  self.s_plant.model disconnectpaths();
  self.model clientfield::set("babysitter_plant_fx", 1);
  self scene::init("zm_dlc2_plant_babysitter_intro", self.s_plant.model);
  self.s_plant.model waittill("hash_fca5370b");
  self.s_plant.trigger = spawn("trigger_radius", self.origin, 17, 150, 150);
  while(true) {
    self.s_plant.trigger waittill("trigger", e_who);
    if(isDefined(e_who.var_61f7b3a0) && e_who.var_61f7b3a0) {
      continue;
    }
    if(isplayer(e_who)) {
      continue;
    }
    if(!(isDefined(e_who.b_is_spider) && e_who.b_is_spider) && e_who.completed_emerging_into_playable_area !== 1) {
      continue;
    }
    var_b28a4a84 = 0;
    str_zone = self.s_plant.model zm_utility::get_current_zone();
    foreach(player in level.players) {
      str_player_zone = player zm_utility::get_current_zone();
      if(str_zone === str_player_zone) {
        var_b28a4a84 = 1;
        break;
      }
    }
    if(var_b28a4a84 == 0) {
      continue;
    }
    if(isalive(e_who)) {
      if(isDefined(e_who.missinglegs) && e_who.missinglegs) {
        e_who thread function_160d5071(self, "ai_zm_dlc2_zombie_crawl_grabbed_by_babysitter");
      } else {
        if(isDefined(e_who.b_is_spider) && e_who.b_is_spider) {
          e_who thread function_40428876(self, "ai_zm_dlc2_spider_grabbed_by_babysitter");
        } else {
          e_who thread function_8be57636(self);
          e_who thread function_160d5071(self, "ai_zm_dlc2_zombie_gibbed_by_babysitter");
        }
      }
      e_who util::waittill_any("death", "zombie_reached_anim_spot");
      if(!isalive(e_who)) {
        continue;
      }
      e_who.b_ignore_cleanup = 1;
      e_who.is_inert = 1;
      var_73dc61d6 = array(self.s_plant.model, e_who);
      break;
    }
  }
  if(!(isDefined(e_who.missinglegs) && e_who.missinglegs) && (!(isDefined(e_who.b_is_spider) && e_who.b_is_spider))) {
    e_who.var_2ff6aa22 = 1;
    e_who thread util::delay(1, "death", & function_9a107da1);
    self scene::play("zm_dlc2_plant_babysitter_gib_zombie", var_73dc61d6);
  }
  if(isDefined(e_who.b_is_spider) && e_who.b_is_spider) {
    self scene::play("zm_dlc2_plant_babysitter_grab_spider", var_73dc61d6);
  } else {
    self scene::play("zm_dlc2_plant_babysitter_grab_zombie_crawler", var_73dc61d6);
  }
  println("");
  level thread zm_island_vo::function_1e767f71(self.s_plant.model, 600, "babysitter", "grab", 120, 0, -1);
  if(b_upgraded == 1) {
    e_who util::waittill_any_timeout(3600, "death");
  } else {
    e_who util::waittill_any_timeout(480, "death");
  }
  self.s_plant.model notify("hash_9ed7f404");
  if(isDefined(e_who) && isalive(e_who)) {
    if(isDefined(e_who.b_is_spider) && e_who.b_is_spider) {
      self scene::play("zm_dlc2_plant_babysitter_drop_spider", var_73dc61d6);
      e_who vehicle_ai::stop_scripted();
    } else {
      self scene::play("zm_dlc2_plant_babysitter_drop_zombie_crawler", var_73dc61d6);
    }
    e_who.b_ignore_cleanup = 0;
    e_who.is_inert = 0;
  }
  wait(1);
  self.s_plant.model clientfield::set("plant_growth_siege_anims", 0);
  self thread scene::play("zm_dlc2_plant_babysitter_outro", self.s_plant.model);
  self.s_plant.model waittill("hash_7a4276be");
  self.model clientfield::set("babysitter_plant_fx", 0);
  self.s_plant.trigger delete();
  wait(0.05);
  self.s_plant.model stopanimscripted();
  wait(0.05);
}

function function_8be57636(s_plant) {
  self endon("death");
  self endon("zombie_reached_anim_spot");
  while(true) {
    if(isDefined(self.missinglegs) && self.missinglegs) {
      self notify("hash_e9a97726");
      self thread function_160d5071(s_plant, "ai_zm_dlc2_zombie_crawl_grabbed_by_babysitter");
      break;
    }
    wait(0.05);
  }
}

function function_389c8477(a_ents) {
  level thread function_14ae573d(a_ents);
  ai_zombie = a_ents["zombie"];
  ai_zombie setCanDamage(0);
  ai_zombie waittill("gibbed");
  ai_zombie zombie_utility::makezombiecrawler(1);
}

function function_14ae573d(a_ents) {
  a_ents["babysitter"] waittill("hash_c75436ca");
  v_org = a_ents["babysitter"] gettagorigin("j_claw_1_anim");
  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }
    n_dist = distance2dsquared(player.origin, v_org);
    if(n_dist < 2304) {
      player dodamage(50, player.origin);
      player playrumbleonentity("damage_light");
    }
  }
  a_enemy_ai = getaiteamarray("axis");
  foreach(ai in a_enemy_ai) {
    if(!isalive(ai) || (isDefined(ai.var_2ff6aa22) && ai.var_2ff6aa22)) {
      continue;
    }
    n_dist = distance2dsquared(ai.origin, v_org);
    if(n_dist < 2304) {
      if(isDefined(ai.var_61f7b3a0) && ai.var_61f7b3a0) {
        n_damage = ai.maxhealth * 0.25;
        ai dodamage(n_damage, ai.origin);
        continue;
      }
      if(isDefined(ai.b_is_spider) && ai.b_is_spider) {
        ai dodamage(ai.health, ai.origin);
        continue;
      }
      if(isDefined(ai.missinglegs) && ai.missinglegs) {
        ai dodamage(ai.health, ai.origin);
        continue;
      }
      ai zombie_utility::makezombiecrawler();
    }
  }
}

function function_9a107da1() {
  self.var_2ff6aa22 = 0;
}

function function_a4a048a1(a_ents) {
  a_ents["zombie"] setCanDamage(0);
  a_ents["zombie"] waittill("hash_58f0843e");
  a_ents["zombie"] setCanDamage(1);
}

function function_6d8761e4(a_ents) {
  a_ents["spider"] setCanDamage(0);
  a_ents["spider"] waittill("hash_dfabd1fb");
  a_ents["spider"] setCanDamage(1);
}

function function_7a4276be(a_ents) {
  a_ents["babysitter"] notify("hash_7a4276be");
}

function function_349e17a5() {
  scene::add_scene_func("zm_dlc2_plant_trap_outro", & function_2df6714, "done");
  scene::add_scene_func("zm_dlc2_plant_trap_attack_front", & function_9e124689, "play");
  scene::add_scene_func("zm_dlc2_plant_trap_attack_back", & function_9e124689, "play");
  scene::add_scene_func("zm_dlc2_plant_trap_attack_left", & function_9e124689, "play");
  scene::add_scene_func("zm_dlc2_plant_trap_attack_right", & function_9e124689, "play");
  scene::add_scene_func("zm_dlc2_plant_trap_attack_no_target_front", & function_9e124689, "play");
  scene::add_scene_func("zm_dlc2_plant_trap_attack_no_target_back", & function_9e124689, "play");
  scene::add_scene_func("zm_dlc2_plant_trap_attack_no_target_left", & function_9e124689, "play");
  scene::add_scene_func("zm_dlc2_plant_trap_attack_no_target_right", & function_9e124689, "play");
  scene::add_scene_func("zm_dlc2_plant_trap_attack_crawler_front", & function_9e124689, "play");
  scene::add_scene_func("zm_dlc2_plant_trap_attack_crawler_back", & function_9e124689, "play");
  scene::add_scene_func("zm_dlc2_plant_trap_attack_crawler_left", & function_9e124689, "play");
  scene::add_scene_func("zm_dlc2_plant_trap_attack_crawler_right", & function_9e124689, "play");
  scene::add_scene_func("zm_dlc2_plant_trap_attack_spider_front", & function_b1a9e247, "play");
  scene::add_scene_func("zm_dlc2_plant_trap_attack_spider_back", & function_b1a9e247, "play");
  scene::add_scene_func("zm_dlc2_plant_trap_attack_spider_left", & function_b1a9e247, "play");
  scene::add_scene_func("zm_dlc2_plant_trap_attack_spider_right", & function_b1a9e247, "play");
}

function function_5d62716(b_upgraded = 0, var_f40460f5) {
  if(b_upgraded == 1) {
    println("");
  } else {
    println("");
  }
  if(isDefined(self.var_561a9c48)) {
    self.var_561a9c48 notify("trap_plant_spawned");
  }
  level notify("trap_plant_spawned");
  if(isDefined(var_f40460f5) && var_f40460f5) {
    level notify("hash_35728d0b");
  }
  if(!self.s_plant.model flag::exists("trap_plant_attacking")) {
    self.s_plant.model flag::init("trap_plant_attacking");
  }
  if(b_upgraded == 1) {
    self.s_plant.model setModel("p7_zm_isl_plant_trap_glow");
  } else {
    self.s_plant.model setModel("p7_zm_isl_plant_trap");
  }
  self.s_plant.model show();
  self.s_plant.model solid();
  self.s_plant.model disconnectpaths();
  self.model clientfield::set("trap_plant_fx", 1);
  self scene::init("zm_dlc2_plant_trap_intro", self.s_plant.model);
  self.s_plant.model waittill("hash_73ada233");
  level thread zm_island_vo::function_1e767f71(self.s_plant.model, 600, "trap", "plant_encounter", 60, 1, -1);
  self.s_plant.trigger = spawn("trigger_radius", self.origin, 0, 75, 150);
  self thread function_ff90a1ba(b_upgraded);
  self thread function_2870d1b8(var_f40460f5);
  self waittill("hash_4729ad2");
  self.model clientfield::set("trap_plant_fx", 0);
  self.s_plant.trigger delete();
  self.s_plant.model flag::wait_till_clear("trap_plant_attacking");
  self.s_plant.model clientfield::set("plant_growth_siege_anims", 0);
  self thread scene::play("zm_dlc2_plant_trap_outro", self.s_plant.model);
  self.s_plant.model waittill("hash_2df6714");
  wait(0.05);
  self.s_plant.model stopanimscripted();
  wait(0.05);
}

function function_ff90a1ba(b_upgraded) {
  var_c746b61a = struct::get_array(self.target, "targetname");
  foreach(var_b454101b in var_c746b61a) {
    if(b_upgraded == 1 && var_b454101b.script_noteworthy === "attackable_upgraded") {
      break;
      continue;
    }
    if(var_b454101b.script_noteworthy === "attackable") {
      break;
    }
  }
  var_b454101b zm_attackables::activate();
  self.s_plant.var_b454101b = var_b454101b;
  var_b454101b.b_deferred_deactivation = 1;
  self thread function_813b723b();
  self thread function_4bc7c145(b_upgraded);
  var_b454101b waittill("attackable_deactivated");
  self notify("hash_4729ad2");
  self.s_plant.model notify("hash_9ed7f404");
  self.s_plant.model waittill("hash_cf8d499a");
  self.s_plant.var_b454101b zm_attackables::deactivate();
  self.s_plant.var_b454101b.b_deferred_deactivation = undefined;
  self.s_plant.var_b454101b = undefined;
}

function function_813b723b() {
  self endon("hash_4729ad2");
  n_damage_amount = self.s_plant.var_b454101b.health / 5;
  while(true) {
    level waittill("end_of_round");
    self.s_plant.var_b454101b zm_attackables::do_damage(n_damage_amount);
  }
}

function function_4bc7c145(b_upgraded) {
  if(b_upgraded) {
    var_922fc340 = 1280;
  } else {
    var_922fc340 = 1180;
  }
  if(level.round_number <= 30) {
    self.s_plant.var_b454101b.health = var_922fc340 * level.round_number;
  } else {
    self.s_plant.var_b454101b.health = var_922fc340 * 30;
  }
}

function function_2870d1b8(var_f40460f5) {
  self endon("hash_4729ad2");
  if(!isDefined(self.var_b17878ae)) {
    var_99098466 = [];
    var_70e1ee03 = getstartorigin(self.origin, self.angles, "ai_zm_dlc2_zombie_dth_plant_trap_front");
    var_99098466["front"] = var_70e1ee03;
    var_ce06045f = getstartorigin(self.origin, self.angles, "ai_zm_dlc2_zombie_dth_plant_trap_back");
    var_99098466["back"] = var_ce06045f;
    var_778b0569 = getstartorigin(self.origin, self.angles, "ai_zm_dlc2_zombie_dth_plant_trap_left");
    var_99098466["left"] = var_778b0569;
    var_9d6b7614 = getstartorigin(self.origin, self.angles, "ai_zm_dlc2_zombie_dth_plant_trap_right");
    var_99098466["right"] = var_9d6b7614;
    var_e7fb417b = [];
    foreach(key, v_pos in var_99098466) {
      if(ispointonnavmesh(v_pos)) {
        var_e7fb417b[key] = v_pos;
      }
    }
    assert(var_e7fb417b.size > 0);
    self.var_b17878ae = var_e7fb417b;
  }
  while(true) {
    var_f19144da = [];
    var_566f2991 = undefined;
    a_enemy_ai = getaiteamarray("axis");
    foreach(ai in a_enemy_ai) {
      if(isalive(ai) && ai istouching(self.s_plant.trigger)) {
        var_f19144da[var_f19144da.size] = ai;
      }
    }
    foreach(player in level.activeplayers) {
      if(isDefined(player) && player istouching(self.s_plant.trigger)) {
        var_f19144da[var_f19144da.size] = player;
      }
    }
    if(var_f19144da.size == 0) {
      wait(0.1);
      continue;
    }
    n_dist_closest = undefined;
    var_d0aaf7a2 = undefined;
    var_121609e = undefined;
    foreach(key, v_pos in self.var_b17878ae) {
      e_target = arraygetclosest(v_pos, var_f19144da);
      n_dist = distance2dsquared(v_pos, e_target.origin);
      if(!isDefined(n_dist_closest)) {
        n_dist_closest = n_dist;
        var_d0aaf7a2 = e_target;
        var_121609e = key;
        continue;
      }
      if(n_dist < n_dist_closest) {
        n_dist_closest = n_dist;
        var_d0aaf7a2 = e_target;
        var_121609e = key;
      }
    }
    var_566f2991 = var_d0aaf7a2;
    if(isDefined(var_566f2991)) {
      if(isplayer(var_566f2991) || (isDefined(var_566f2991.var_61f7b3a0) && var_566f2991.var_61f7b3a0)) {
        self function_fa3e7444(var_121609e);
      } else {
        if(isDefined(var_566f2991.b_is_spider) && var_566f2991.b_is_spider) {
          var_2202a6b5 = self function_32c5773c(var_566f2991, var_121609e);
          if(var_2202a6b5 == 0) {
            wait(0.05);
            continue;
          }
        } else {
          var_2202a6b5 = self function_6b938a09(var_566f2991, var_121609e);
          if(var_2202a6b5 == 0) {
            wait(0.05);
            continue;
          }
        }
      }
      wait(0.5);
    } else {
      wait(0.05);
    }
  }
}

function function_fa3e7444(var_121609e) {
  switch (var_121609e) {
    case "front": {
      self thread scene::play("zm_dlc2_plant_trap_attack_no_target_front", self.s_plant.model);
      break;
    }
    case "back": {
      self thread scene::play("zm_dlc2_plant_trap_attack_no_target_back", self.s_plant.model);
      break;
    }
    case "left": {
      self thread scene::play("zm_dlc2_plant_trap_attack_no_target_left", self.s_plant.model);
      break;
    }
    case "right": {
      self thread scene::play("zm_dlc2_plant_trap_attack_no_target_right", self.s_plant.model);
      break;
    }
  }
  self thread function_7f34488a(var_121609e);
  self.s_plant.model waittill("hash_4ce89178");
}

function function_6b938a09(var_d0aaf7a2, var_121609e) {
  var_73dc61d6 = array(self.s_plant.model, var_d0aaf7a2);
  var_d0aaf7a2.var_7d79a6 = 1;
  var_d0aaf7a2 thread function_79faa463(self);
  var_d0aaf7a2 pushactors(0);
  var_ea0c0e00 = 0;
  if(isDefined(var_d0aaf7a2.missinglegs) && var_d0aaf7a2.missinglegs) {
    var_ea0c0e00 = 1;
  }
  var_464eccec = 1;
  switch (var_121609e) {
    case "front": {
      str_crawler_anim_name = "ai_zm_dlc2_zombie_crawl_dth_plant_trap_front";
      str_anim_name = "ai_zm_dlc2_zombie_dth_plant_trap_front";
      str_crawler_scene_name = "zm_dlc2_plant_trap_attack_crawler_front";
      str_scene_name = "zm_dlc2_plant_trap_attack_front";
      break;
    }
    case "back": {
      str_crawler_anim_name = "ai_zm_dlc2_zombie_crawl_dth_plant_trap_back";
      str_anim_name = "ai_zm_dlc2_zombie_dth_plant_trap_back";
      str_crawler_scene_name = "zm_dlc2_plant_trap_attack_crawler_back";
      str_scene_name = "zm_dlc2_plant_trap_attack_back";
      break;
    }
    case "left": {
      str_crawler_anim_name = "ai_zm_dlc2_zombie_crawl_dth_plant_trap_left";
      str_anim_name = "ai_zm_dlc2_zombie_dth_plant_trap_left";
      str_crawler_scene_name = "zm_dlc2_plant_trap_attack_crawler_left";
      str_scene_name = "zm_dlc2_plant_trap_attack_left";
      break;
    }
    case "right": {
      str_crawler_anim_name = "ai_zm_dlc2_zombie_crawl_dth_plant_trap_right";
      str_anim_name = "ai_zm_dlc2_zombie_dth_plant_trap_right";
      str_crawler_scene_name = "zm_dlc2_plant_trap_attack_crawler_right";
      str_scene_name = "zm_dlc2_plant_trap_attack_right";
      break;
    }
  }
  if(var_ea0c0e00 == 1) {
    var_d0aaf7a2 thread function_160d5071(self, str_crawler_anim_name);
  } else {
    var_d0aaf7a2 thread function_374f973e(self, str_crawler_anim_name);
    var_d0aaf7a2 thread function_160d5071(self, str_anim_name);
  }
  var_d0aaf7a2 util::waittill_any("death", "zombie_reached_anim_spot");
  if(isalive(var_d0aaf7a2)) {
    if(isDefined(var_d0aaf7a2.missinglegs) && var_d0aaf7a2.missinglegs) {
      self thread scene::play(str_crawler_scene_name, var_73dc61d6);
      self thread function_7f34488a(var_121609e, 1);
    } else {
      self thread scene::play(str_scene_name, var_73dc61d6);
      self thread function_7f34488a(var_121609e);
    }
  } else {
    var_464eccec = 0;
    return var_464eccec;
  }
  self.s_plant.model waittill("hash_4ce89178");
  return var_464eccec;
}

function function_79faa463(s_plant) {
  self endon("death");
  s_plant waittill("hash_4729ad2");
  if(isalive(self)) {
    self.var_7d79a6 = 0;
  }
}

function function_374f973e(s_plant, str_crawler_anim_name) {
  self endon("death");
  self endon("zombie_reached_anim_spot");
  s_plant endon("hash_4729ad2");
  while(true) {
    if(isDefined(self.missinglegs) && self.missinglegs) {
      self notify("hash_e9a97726");
      self thread function_160d5071(s_plant, str_crawler_anim_name);
      break;
    }
    wait(0.05);
  }
}

function function_32c5773c(var_d0aaf7a2, var_121609e) {
  var_73dc61d6 = array(self.s_plant.model, var_d0aaf7a2);
  var_d0aaf7a2.var_7d79a6 = 1;
  var_d0aaf7a2 thread function_79faa463(self);
  var_464eccec = 1;
  switch (var_121609e) {
    case "front": {
      str_anim_name = "ai_zm_dlc2_spider_dth_plant_trap_front";
      str_scene_name = "zm_dlc2_plant_trap_attack_spider_front";
      break;
    }
    case "back": {
      str_anim_name = "ai_zm_dlc2_spider_dth_plant_trap_back";
      str_scene_name = "zm_dlc2_plant_trap_attack_spider_back";
      break;
    }
    case "left": {
      str_anim_name = "ai_zm_dlc2_spider_dth_plant_trap_left";
      str_scene_name = "zm_dlc2_plant_trap_attack_spider_left";
      break;
    }
    case "right": {
      str_anim_name = "ai_zm_dlc2_spider_dth_plant_trap_right";
      str_scene_name = "zm_dlc2_plant_trap_attack_spider_right";
      break;
    }
  }
  var_d0aaf7a2 function_40428876(self, str_anim_name);
  if(isalive(var_d0aaf7a2)) {
    self thread scene::play(str_scene_name, var_73dc61d6);
    self thread function_7f34488a(var_121609e, 1);
  } else {
    var_464eccec = 0;
    return var_464eccec;
  }
  self.s_plant.model waittill("hash_4ce89178");
  return var_464eccec;
}

function function_9e124689(a_ents) {
  e_target = a_ents["zombie"];
  var_31678178 = a_ents["plant_trap"];
  var_31678178 flag::set("trap_plant_attacking");
  var_31678178 util::waittill_any("spawn_head", "plant_melee");
  if(isalive(e_target)) {
    self thread function_e6f615b3(e_target);
    var_fdbb0645 = e_target.head + "_prop";
    gibserverutils::gibhead(e_target);
    e_target dodamage(e_target.health, e_target.origin);
    v_org = var_31678178 gettagorigin("tag_plant_grab");
    v_angles = var_31678178 gettagangles("tag_plant_grab");
    var_c40b12dc = util::spawn_model(var_fdbb0645, v_org, v_angles);
    var_c40b12dc linkto(var_31678178, "tag_plant_grab");
    var_31678178 waittill("hash_af56254a");
    var_c40b12dc delete();
  }
  var_31678178 waittill("hash_350a84f");
  var_31678178 flag::clear("trap_plant_attacking");
  var_31678178 notify("hash_4ce89178");
}

function function_b1a9e247(a_ents) {
  e_target = a_ents["spider"];
  var_31678178 = a_ents["plant_trap"];
  var_31678178 flag::set("trap_plant_attacking");
  var_31678178 waittill("spawn_head");
  if(isalive(e_target)) {
    self thread function_e6f615b3(e_target);
    e_target dodamage(e_target.health, e_target.origin);
  }
  var_31678178 waittill("hash_350a84f");
  var_31678178 flag::clear("trap_plant_attacking");
  var_31678178 notify("hash_4ce89178");
}

function function_e6f615b3(e_target) {
  level thread zm_island_vo::function_1e767f71(self.s_plant.model, 600, "trap", "plant_kill", 60, 0, 2);
  if(zm_utility::is_player_valid(self.var_561a9c48)) {
    self.var_561a9c48 notify("hash_e6f615b3");
    self.var_561a9c48 notify("trap_plant_killed_" + e_target.archetype);
  }
  if(isDefined(self.var_e7abf7d0) && self.var_e7abf7d0) {
    level notify("hash_8c54f723");
  }
}

function function_7f34488a(str_loc, var_23237415 = 0) {
  self.s_plant.model util::waittill_any("spawn_head", "plant_melee");
  v_org = self.var_b17878ae[str_loc];
  foreach(player in level.players) {
    if(var_23237415 == 0) {
      str_stance = player getstance();
      if(str_stance != "stand") {
        continue;
      }
    }
    n_dist = distance2dsquared(player.origin, v_org);
    if(n_dist < 2304) {
      player dodamage(50, player.origin);
      player playrumbleonentity("damage_light");
      player zm_island_vo::function_1881817("trap", "plant_attacked", 10, 3);
    }
  }
  a_enemy_ai = getaiteamarray("axis");
  foreach(ai in a_enemy_ai) {
    if(isDefined(ai.var_61f7b3a0) && ai.var_61f7b3a0) {
      n_dist = distance2dsquared(ai.origin, v_org);
      if(n_dist < 2304) {
        n_damage = ai.maxhealth * 0.25;
        ai dodamage(n_damage, ai.origin);
      }
    }
  }
}

function function_2df6714(a_ents) {
  a_ents["plant_trap"] notify("hash_2df6714");
}

function function_869faee7() {
  level.func_clone_plant_respawn = & func_clone_plant_respawn;
  level.check_end_solo_game_override = & check_end_solo_game_override;
  level.var_50d5cc84 = 0;
}

function function_3e429652() {
  println("");
  level.var_50d5cc84++;
  if(isDefined(self.var_561a9c48)) {
    self.var_561a9c48 notify("hash_aa62194d");
  }
  level notify("hash_aa62194d");
  self.s_plant.model setModel("p7_fxanim_zm_island_plant_clone_grow_mod");
  self.s_plant.model show();
  self.s_plant.model solid();
  self.s_plant.model disconnectpaths();
  self thread scene::init("p7_fxanim_zm_island_plant_clone_grow1_bundle", self.s_plant.model);
  self.s_plant.model waittill("hash_83d08c0f");
  self thread function_b78c42da();
  self waittill("hash_f7fd4ace", e_player);
  zm_unitrigger::unregister_unitrigger(self.var_23c5e7a6);
  self.var_23c5e7a6 = undefined;
  level zm_utility::increment_no_end_game_check();
  e_player thread function_15142bc5(self);
  e_player zm_island_vo::function_7f4cb4c("clone", "imprint", 1);
  self thread scene::play("p7_fxanim_zm_island_plant_clone_grow1_bundle", self.s_plant.model);
  str_notify = e_player util::waittill_any_return("player_clone_spawned", "clone_plant_overwritten", "disconnect");
  level zm_utility::decrement_no_end_game_check();
  if(isDefined(e_player) && str_notify == "player_clone_spawned") {
    self function_14d216b1(e_player);
  }
  self.s_plant.model clientfield::set("plant_growth_siege_anims", 0);
  self.s_plant.model setModel("p7_fxanim_zm_island_plant_clone_pop_mod");
  self.s_plant.model notsolid();
  self scene::play("p7_fxanim_zm_island_plant_clone_pop_bundle", self.s_plant.model);
  if(isDefined(e_player) && str_notify == "player_clone_spawned") {
    visionset_mgr::deactivate("visionset", "zm_isl_thrasher_stomach_visionset", e_player);
    e_player clientfield::set_to_player("player_spawned_from_clone_plant", 0);
    e_player clientfield::set_to_player("player_cloned_fx", 0);
    wait(3);
    if(isDefined(e_player)) {
      e_player zm_utility::decrement_ignoreme();
      e_player.var_6e61a720 = undefined;
    }
  }
  wait(0.05);
  self.s_plant.model stopanimscripted();
  wait(0.05);
}

function function_14d216b1(e_player) {
  e_player endon("disconnect");
  e_player.var_6e61a720 = 1;
  e_player lui::screen_fade_out(0.1);
  e_player zm_utility::increment_ignoreme();
  e_player clientfield::set_to_player("player_spawned_from_clone_plant", 1);
  e_player clientfield::set_to_player("player_cloned_fx", 1);
  visionset_mgr::activate("visionset", "zm_isl_thrasher_stomach_visionset", e_player, 2);
  e_player ghost();
  self thread scene::play("p_zom_plant_exit_bundle", e_player);
  wait(0.1);
  self.s_plant.model hidepart("clone_body_jnt", "p7_fxanim_zm_island_plant_clone_grow_mod", 1);
  e_player show();
  e_player lui::screen_fade_in(1);
  e_player util::waittill_any_timeout(5, "disconnect", "player_emerge_from_clone_plant");
  e_player thread function_cbb90d18();
  self.s_plant.model showpart("clone_body_jnt", "p7_fxanim_zm_island_plant_clone_grow_mod", 1);
  if(isDefined(e_player) && (isDefined(level.var_5258ba34) && level.var_5258ba34)) {
    if(zm_utility::is_player_valid(e_player) && e_player zm_zonemgr::entity_in_active_zone()) {
      e_player waittill("hash_84fb0f4d");
      e_player zm_island_takeo_fight::function_75275516();
    }
  }
}

function function_cbb90d18() {
  self endon("disconnect");
  self waittill("hash_84fb0f4d");
  self zm_island_vo::function_cf8fccfe(0);
  self zm_island_vo::function_7f4cb4c("clone", "cloned", 1);
}

function function_b78c42da() {
  s_plant_unitrigger = spawnStruct();
  s_plant_unitrigger.origin = self.origin + vectorscale((0, 0, 1), 8);
  s_plant_unitrigger.angles = self.angles;
  s_plant_unitrigger.s_parent = self;
  s_plant_unitrigger.script_unitrigger_type = "unitrigger_box_use";
  s_plant_unitrigger.cursor_hint = "HINT_NOICON";
  s_plant_unitrigger.require_look_at = 1;
  s_plant_unitrigger.script_width = 100;
  s_plant_unitrigger.script_length = 100;
  s_plant_unitrigger.script_height = 150;
  s_plant_unitrigger.prompt_and_visibility_func = & function_d4d40251;
  zm_unitrigger::register_static_unitrigger(s_plant_unitrigger, & function_7756fe45);
  self.var_23c5e7a6 = s_plant_unitrigger;
  self.s_plant flag::clear("plant_interact_trigger_used");
}

function function_d4d40251(e_player) {
  if(e_player zm_utility::in_revive_trigger()) {
    self sethintstring(&"");
    return false;
  }
  if(e_player.is_drinking > 0) {
    self sethintstring(&"");
    return false;
  }
  if(!zm_utility::is_player_valid(e_player)) {
    self sethintstring(&"");
    return false;
  }
  if(!e_player zm_magicbox::can_buy_weapon()) {
    self sethintstring(&"");
    return false;
  }
  if(self.stub.s_parent.s_plant flag::get("plant_interact_trigger_used")) {
    self sethintstring(&"");
    return false;
  }
  self sethintstring(&"ZM_ISLAND_CLONE_PLANT");
  return true;
}

function function_7756fe45() {
  if(1) {
    for(;;) {
      self waittill("trigger", e_who);
    }
    for(;;) {}
    for(;;) {}
    for(;;) {}
    if(e_who zm_utility::in_revive_trigger()) {}
    if(e_who.is_drinking > 0) {}
    if(!zm_utility::is_player_valid(e_who)) {}
    if(!e_who zm_magicbox::can_buy_weapon()) {}
    self.stub.s_parent notify("hash_f7fd4ace", e_who);
    self.stub.s_parent.s_plant flag::set("plant_interact_trigger_used");
    return;
  }
}

function function_15142bc5(s_plant) {
  self endon("disconnect");
  if(isDefined(self.s_clone_plant)) {
    self notify("clone_plant_overwritten");
  }
  self.s_clone_plant = s_plant;
  self.var_5942b967 = spawnStruct();
  if(isDefined(self.perks_active)) {
    self.var_5942b967.a_perks = [];
    foreach(perk in self.perks_active) {
      array::add(self.var_5942b967.a_perks, perk, 0);
    }
  }
  if(bgb::is_enabled("zm_bgb_disorderly_combat") && isDefined(self.var_fe555a38)) {
    self.var_5942b967.w_current_weapon = self.var_fe555a38;
  } else {
    self.var_5942b967.w_current_weapon = self getcurrentweapon();
  }
  self.var_5942b967.aat = self.aat;
  self.var_5942b967.var_6a4d6d26 = 0;
  var_c5716cdc = self getweaponslist(1);
  self.var_5942b967.a_weapons = [];
  foreach(weapon in var_c5716cdc) {
    if(bgb::is_enabled("zm_bgb_disorderly_combat")) {
      if(self.var_8cee13f3 === weapon) {
        continue;
      }
    }
    var_e59ac7e4 = zm_weapons::get_nonalternate_weapon(weapon);
    if(weapon != var_e59ac7e4) {
      continue;
    }
    if(weapon == level.var_c003f5b) {
      self.var_5942b967.var_6a4d6d26 = 1;
      self.var_5942b967.var_64d58722 = self gadgetpowerget(0);
      continue;
    }
    n_index = self.var_5942b967.a_weapons.size;
    self.var_5942b967.a_weapons[n_index] = spawnStruct();
    self.var_5942b967.a_weapons[n_index].weapon = weapon;
    self.var_5942b967.a_weapons[n_index].clip_amt = self getweaponammoclip(weapon);
    self.var_5942b967.a_weapons[n_index].left_clip_amt = 0;
    var_bc62c240 = weapon.dualwieldweapon;
    if(level.weaponnone != var_bc62c240) {
      self.var_5942b967.a_weapons[n_index].left_clip_amt = self getweaponammoclip(var_bc62c240);
    }
    self.var_5942b967.a_weapons[n_index].stock_amt = self getweaponammostock(weapon);
  }
  self.var_5942b967.n_score = self.score;
  self.var_5942b967.bgb = self.bgb;
  self.var_5942b967.var_2ecea42d = self clientfield::get_to_player("bucket_held");
  if(!self.var_5942b967.var_2ecea42d) {
    self.var_5942b967.var_bb2fd41c = 0;
    self.var_5942b967.var_c6cad973 = 0;
  } else {
    self.var_5942b967.var_bb2fd41c = self.var_bb2fd41c;
    self.var_5942b967.var_c6cad973 = self.var_c6cad973;
  }
  self.var_5942b967.var_f65b973 = zm_powerup_island_seed::function_735cfef2(self);
  self.var_5942b967.var_1493e376 = self.var_df4182b1;
}

function func_clone_plant_respawn() {
  self endon("disconnect");
  self thread zm_island_vo::function_cf8fccfe(1);
  if(isDefined(self.thrasherconsumed) && self.thrasherconsumed) {
    thrasherserverutils::thrasherreleaseplayer(self.thrasher, self);
  }
  self notify("stop_revive_trigger");
  wait(0.05);
  self setorigin(self.s_clone_plant.origin);
  self setplayerangles(self.s_clone_plant.angles);
  self.s_clone_plant = undefined;
  self zm_laststand::auto_revive(self);
  wait(0.05);
  assert(isDefined(self.var_5942b967));
  if(isDefined(self.var_5942b967.a_perks)) {
    foreach(perk in self.var_5942b967.a_perks) {
      self zm_perks::give_perk(perk);
    }
  }
  assert(isDefined(self.var_5942b967.a_weapons));
  assert(isDefined(self.var_5942b967.w_current_weapon));
  var_c5716cdc = self getweaponslist(1);
  foreach(weapon in var_c5716cdc) {
    if(weapon == level.var_c003f5b) {
      self zm_weapons::weapon_take(weapon);
      self zm_hero_weapon::set_hero_weapon_state(level.var_c003f5b, 0);
      self thread zm_island_skullquest::function_29d2aa0e(0, undefined, 0);
      self notify("watch_hero_weapon_take");
      self notify("stop_watch_hero_power");
      self notify("watch_hero_weapon_give");
      self notify("watch_hero_weapon_change");
      self notify("watch_hero_power");
      self notify("stop_draining_hero_weapon");
      self zm_hero_weapon::on_player_spawned();
      continue;
    }
    self zm_weapons::weapon_take(weapon);
  }
  foreach(s_info in self.var_5942b967.a_weapons) {
    if(s_info.weapon.isriotshield) {
      self.do_not_display_equipment_pickup_hint = 1;
      self thread function_da2cdc7f();
      self zm_equipment::give(s_info.weapon);
      if(isDefined(self.player_shield_reset_health)) {
        self[[self.player_shield_reset_health]]();
      }
      continue;
    }
    weapon = self zm_weapons::give_build_kit_weapon(s_info.weapon.rootweapon);
    self setweaponammoclip(weapon, s_info.clip_amt);
    var_bc62c240 = weapon.dualwieldweapon;
    if(level.weaponnone != var_bc62c240) {
      self setweaponammoclip(var_bc62c240, s_info.left_clip_amt);
    }
    self setweaponammostock(weapon, s_info.stock_amt);
    a_keys = getarraykeys(self.var_5942b967.aat);
    if(isinarray(a_keys, weapon)) {
      self aat::acquire(weapon, self.var_5942b967.aat[weapon]);
    }
  }
  if(self.var_5942b967.var_6a4d6d26 == 1) {
    self thread function_a0e11c4();
  }
  self switchtoweapon(self.var_5942b967.w_current_weapon);
  assert(isDefined(self.var_5942b967.n_score));
  self.score = self.var_5942b967.n_score;
  self.pers["score"] = self.score;
  __protected__setbgbunlocked(1);
  self bgb::function_d35f60a1(self.var_5942b967.bgb);
  __protected__setbgbunlocked(0);
  assert(isDefined(self.var_5942b967.var_2ecea42d));
  if(!self.var_5942b967.var_2ecea42d && self clientfield::get_to_player("bucket_held")) {
    self notify("clone_plant_bucket_lost");
  } else {
    self.var_bb2fd41c = self.var_5942b967.var_bb2fd41c;
    self.var_c6cad973 = self.var_5942b967.var_c6cad973;
    self zm_island_power::function_ef097ea(self.var_c6cad973, self.var_bb2fd41c, self zm_island_power::function_89538fbb(), 1);
  }
  assert(isDefined(self.var_5942b967.var_f65b973));
  self zm_powerup_island_seed::function_aeda54f6(self.var_5942b967.var_f65b973);
  assert(isDefined(self.var_5942b967.var_1493e376));
  self.var_df4182b1 = self.var_5942b967.var_1493e376;
  if(!self.var_df4182b1) {
    self notify("player_lost_gasmask");
  } else {
    self notify("player_has_gasmask");
  }
  self notify("player_clone_spawned");
  self notify("hash_6c52e305");
  self.var_5942b967 = undefined;
}

function function_da2cdc7f() {
  self endon("disconnect");
  wait(1);
  self.do_not_display_equipment_pickup_hint = 0;
}

function function_a0e11c4() {
  self endon("disconnect");
  self zm_weapons::weapon_give(level.var_c003f5b, undefined, undefined, 1);
  self gadgetpowerset(0, self.var_5942b967.var_64d58722);
  self setweaponammoclip(level.var_c003f5b, 0);
  power = self gadgetpowerget(0);
  if(power < 100) {
    self zm_hero_weapon::set_hero_weapon_state(level.var_c003f5b, 1);
  } else {
    self zm_hero_weapon::set_hero_weapon_state(level.var_c003f5b, 2);
  }
  self thread zm_island_skullquest::function_29d2aa0e(3, undefined, 0);
  self thread zm_hero_weapon::watch_hero_weapon_take();
}

function check_end_solo_game_override() {
  if(isDefined(self.s_clone_plant)) {
    return true;
  }
  return false;
}

function function_1b391116() {
  level.var_5ef907c8 = getweapon("fruit_eat_success");
  level.var_8a542f3f = getweapon("fruit_eat_fail");
  level thread include_perks_in_random_rotation();
}

function include_perks_in_random_rotation() {
  zm_perk_random::include_perk_in_random_rotation("specialty_armorvest");
  zm_perk_random::include_perk_in_random_rotation("specialty_quickrevive");
  zm_perk_random::include_perk_in_random_rotation("specialty_fastreload");
  zm_perk_random::include_perk_in_random_rotation("specialty_doubletap2");
  zm_perk_random::include_perk_in_random_rotation("specialty_staminup");
  zm_perk_random::include_perk_in_random_rotation("specialty_additionalprimaryweapon");
  zm_perk_random::include_perk_in_random_rotation("specialty_deadshot");
  zm_perk_random::include_perk_in_random_rotation("specialty_electriccherry");
  zm_perk_random::include_perk_in_random_rotation("specialty_widowswine");
}

function function_fd098f17(b_upgraded = 0) {
  if(b_upgraded == 1) {
    println("");
  } else {
    println("");
  }
  if(isDefined(self.var_561a9c48)) {
    self.var_561a9c48 notify("fruit_plant_spawned");
  }
  level notify("fruit_plant_spawned");
  if(b_upgraded == 1) {
    var_d583f9d = "p7_fxanim_zm_island_plant_fruit_glow_mod";
  } else {
    var_d583f9d = "p7_fxanim_zm_island_plant_fruit_mod";
  }
  self.s_plant.model setModel(var_d583f9d);
  self.s_plant.model show();
  self.s_plant.model solid();
  self.s_plant.model disconnectpaths();
  self thread scene::init("p7_fxanim_zm_island_plant_fruit_bundle", self.s_plant.model);
  self.s_plant.model waittill("hash_334ee3df");
  self thread function_bf89dc95();
  self waittill("hash_f224e16d", e_player);
  zm_unitrigger::unregister_unitrigger(self.var_23c5e7a6);
  self.var_23c5e7a6 = undefined;
  e_player notify("hash_3e1e1a8");
  if(b_upgraded == 1) {
    if(e_player zm_utility::can_player_purchase_perk()) {
      level thread function_cccc72b3(e_player);
    } else {
      level thread function_cc0c1582(e_player);
    }
  } else {
    n_chance = randomfloatrange(0, 100);
    if(n_chance <= 75) {
      if(e_player zm_utility::can_player_purchase_perk()) {
        level thread function_cccc72b3(e_player);
      } else {
        level thread function_cc0c1582(e_player);
      }
    } else {
      level thread function_cc0c1582(e_player);
    }
  }
  self.s_plant.model clientfield::set("plant_growth_siege_anims", 0);
  self.s_plant.model hidepart("plant_fruit_stalk_egg_hide_jnt", var_d583f9d);
  self scene::play("p7_fxanim_zm_island_plant_fruit_bundle", self.s_plant.model);
  self.s_plant.model showpart("plant_fruit_stalk_egg_hide_jnt", var_d583f9d);
}

function function_bf89dc95() {
  s_plant_unitrigger = spawnStruct();
  s_plant_unitrigger.origin = self.origin + vectorscale((0, 0, 1), 8);
  s_plant_unitrigger.angles = self.angles;
  s_plant_unitrigger.s_parent = self;
  s_plant_unitrigger.script_unitrigger_type = "unitrigger_box_use";
  s_plant_unitrigger.cursor_hint = "HINT_NOICON";
  s_plant_unitrigger.require_look_at = 1;
  s_plant_unitrigger.script_width = 100;
  s_plant_unitrigger.script_length = 100;
  s_plant_unitrigger.script_height = 150;
  s_plant_unitrigger.prompt_and_visibility_func = & function_7187558;
  zm_unitrigger::register_static_unitrigger(s_plant_unitrigger, & function_c31605a8);
  self.var_23c5e7a6 = s_plant_unitrigger;
  self.s_plant flag::clear("plant_interact_trigger_used");
}

function function_7187558(e_player) {
  if(e_player zm_utility::in_revive_trigger()) {
    self sethintstring(&"");
    return false;
  }
  if(e_player.is_drinking > 0) {
    self sethintstring(&"");
    return false;
  }
  if(!zm_utility::is_player_valid(e_player)) {
    self sethintstring(&"");
    return false;
  }
  if(self.stub.s_parent.s_plant flag::get("plant_interact_trigger_used")) {
    self sethintstring(&"");
    return false;
  }
  self sethintstring(&"ZM_ISLAND_FRUIT_PLANT");
  return true;
}

function function_c31605a8() {
  if(1) {
    for(;;) {
      self waittill("trigger", e_who);
    }
    for(;;) {}
    for(;;) {}
    if(e_who zm_utility::in_revive_trigger()) {}
    if(e_who.is_drinking > 0) {}
    if(!zm_utility::is_player_valid(e_who)) {}
    self.stub.s_parent notify("hash_f224e16d", e_who);
    self.stub.s_parent.s_plant flag::set("plant_interact_trigger_used");
    return;
  }
}

function function_cccc72b3(e_player) {
  e_player endon("disconnect");
  e_player function_3d33e23e(1);
  random_perk = zm_perk_random::get_weighted_random_perk(e_player);
  e_player thread zm_perks::wait_give_perk(random_perk);
  e_player notify("hash_7285e7d");
  println("" + random_perk);
  e_player notify("player_ate_fruit_success");
  e_player notify("perk_purchased", random_perk);
}

function function_cc0c1582(e_player) {
  e_player endon("disconnect");
  println("");
  e_player thread function_3d33e23e(0);
  e_player thread zm_island_vo::function_6fc10b64();
  e_player giveachievement("ZM_ISLAND_EAT_FRUIT");
}

function function_3d33e23e(b_success = 1) {
  self endon("disconnect");
  self thread function_afacd209();
  self.var_db9c1f55 = 0;
  self thread function_7a0f914c(b_success);
  self util::waittill_any("fake_death", "death", "player_downed", "weapon_change_complete", "player_cancel_fruit_eat");
  self function_37e9f650(b_success);
  var_7cf98153 = undefined;
  self.var_db9c1f55 = 0;
  self notify("hash_68922ea0");
}

function function_afacd209() {
  self endon("disconnect");
  self endon("hash_68922ea0");
  self waittill("player_eaten_by_thrasher");
  if(self.is_drinking > 0) {
    self zm_utility::decrement_is_drinking();
  }
  self notify("hash_68922ea0");
}

function function_7a0f914c(b_success) {
  self endon("disconnect");
  if(!self.is_drinking > 0) {
    self zm_utility::increment_is_drinking();
  }
  w_original = self getcurrentweapon();
  var_c9d7dbd3 = function_d60b4013(b_success);
  if(w_original != level.weaponnone && (!(isDefined(zm_utility::is_placeable_mine(w_original)) && zm_utility::is_placeable_mine(w_original))) && (!(isDefined(zm_equipment::is_equipment(w_original)) && zm_equipment::is_equipment(w_original))) && (!(isDefined(self zm_laststand::is_reviving_any()) && self zm_laststand::is_reviving_any())) && (!(isDefined(self laststand::player_is_in_laststand()) && self laststand::player_is_in_laststand()))) {
    self.original_weapon = w_original;
  } else {
    self notify("player_cancel_fruit_eat");
    return;
  }
  self.var_db9c1f55 = 1;
  self zm_utility::disable_player_move_states(1);
  self giveweapon(var_c9d7dbd3);
  self switchtoweapon(var_c9d7dbd3);
}

function function_37e9f650(b_success) {
  self endon("disconnect");
  self zm_utility::enable_player_move_states();
  var_c9d7dbd3 = function_d60b4013(b_success);
  if(self laststand::player_is_in_laststand() || (isDefined(self.intermission) && self.intermission)) {
    self takeweapon(var_c9d7dbd3);
    return;
  }
  if(self.is_drinking > 0) {
    self zm_utility::decrement_is_drinking();
  }
  var_d82ff565 = self getweaponslistprimaries();
  self takeweapon(var_c9d7dbd3);
  if(self.is_drinking > 0) {
    return;
  }
  if(isDefined(self.original_weapon)) {
    self switchtoweapon(self.original_weapon);
  } else {
    if(isDefined(var_d82ff565) && var_d82ff565.size > 0) {
      self switchtoweapon(var_d82ff565[0]);
    } else {
      if(self hasweapon(level.laststandpistol)) {
        self switchtoweapon(level.laststandpistol);
      } else {
        self zm_weapons::give_fallback_weapon();
      }
    }
  }
}

function function_d60b4013(b_success) {
  if(b_success == 1) {
    var_c9d7dbd3 = level.var_5ef907c8;
  } else {
    var_c9d7dbd3 = level.var_8a542f3f;
  }
  return var_c9d7dbd3;
}

function function_5726c670(var_98b687fa) {
  if(level flag::get("ww_obtained") && !level flag::get("ww_upgrade_spawned_from_plant") && var_98b687fa == 3) {
    self.s_plant.model setModel("p7_fxanim_zm_island_plant_underwater_teal_mod");
    self.s_plant.model show();
    self.s_plant.model solid();
    self.s_plant.model disconnectpaths();
    self scene::play("p7_fxanim_zm_island_plant_underwater_bundle", self.s_plant.model);
    level flag::set("ww_upgrade_spawned_from_plant");
    level flag::wait_till("wwup3_found");
    self.s_plant.model clientfield::set("plant_growth_siege_anims", 0);
    return;
  }
}

function dig_up_weapon(e_digger, wpn_to_spawn, var_c6fcdf22 = undefined) {
  v_spawnpt = self.origin + (0, 0, 40);
  v_spawnang = (0, 0, 0);
  v_angles = e_digger getplayerangles();
  v_angles = (0, v_angles[1], 0) + vectorscale((0, 1, 0), 90) + v_spawnang;
  m_weapon = zm_utility::spawn_buildkit_weapon_model(e_digger, wpn_to_spawn, undefined, v_spawnpt, v_angles);
  m_weapon.angles = v_angles;
  m_weapon thread timer_til_despawn(v_spawnpt, 40 * -1);
  m_weapon endon("dig_up_weapon_timed_out");
  m_weapon.trigger = zm_island_util::spawn_trigger_radius(v_spawnpt, 100, 1);
  m_weapon.trigger.wpn = wpn_to_spawn;
  m_weapon.trigger.prompt_and_visibility_func = & weapon_trigger_update_prompt;
  m_weapon.trigger flag::init("weapon_grabbed_or_timed_out");
  m_weapon.trigger waittill("trigger", player);
  m_weapon notify("weapon_grabbed");
  player thread zm_island_util::swap_weapon(wpn_to_spawn);
  if(isDefined(m_weapon.trigger)) {
    m_weapon.trigger flag::set("weapon_grabbed_or_timed_out");
    zm_unitrigger::unregister_unitrigger(m_weapon.trigger);
    m_weapon.trigger = undefined;
  }
  if(isDefined(m_weapon)) {
    m_weapon delete();
  }
  if(player != e_digger) {
    e_digger notify("dig_up_weapon_shared");
  }
}

function timer_til_despawn(v_float, n_dist) {
  self endon("weapon_grabbed");
  wait(15);
  for(i = 0; i < 40; i++) {
    if(i % 2) {
      self weapon_show(0);
    } else {
      self weapon_show(1);
    }
    if(i < 15) {
      wait(0.5);
      continue;
    }
    if(i < 25) {
      wait(0.25);
      continue;
    }
    wait(0.1);
  }
  self notify("dig_up_weapon_timed_out");
  if(isDefined(self.trigger)) {
    self.trigger flag::set("weapon_grabbed_or_timed_out");
    zm_unitrigger::unregister_unitrigger(self.trigger);
    self.trigger = undefined;
  }
  if(isDefined(self)) {
    self delete();
  }
}

function weapon_show(visible) {
  if(!visible) {
    self ghost();
    if(isDefined(self.worldgundw)) {
      self.worldgundw ghost();
    }
  } else {
    self show();
    if(isDefined(self.worldgundw)) {
      self.worldgundw show();
    }
  }
}

function weapon_trigger_update_prompt(player) {
  if(!zm_utility::is_player_valid(player) || player.is_drinking > 0 || !player zm_magicbox::can_buy_weapon() || player bgb::is_enabled("zm_bgb_disorderly_combat")) {
    self sethintstring(&"");
    return false;
  }
  if(self.stub flag::get("weapon_grabbed_or_timed_out")) {
    self sethintstring(&"");
    return false;
  }
  self setcursorhint("HINT_WEAPON", self.stub.wpn);
  self sethintstring(&"ZOMBIE_TRADE_WEAPON_FILL");
  return true;
}

function function_15c62ca8(v_pos, radius) {
  v_origin = getclosestpointonnavmesh(v_pos, radius);
  if(!isDefined(v_origin)) {
    e_player = zm_utility::get_closest_player(v_pos);
    v_origin = getclosestpointonnavmesh(e_player.origin, radius);
  }
  if(!isDefined(v_origin)) {
    v_origin = v_pos;
  }
  return v_origin;
}

function function_688119e4() {
  self endon("death");
  a_perks = self getperks();
  n_perks = a_perks.size;
  if(isDefined(self.player_perk_purchase_limit) && n_perks < self.player_perk_purchase_limit) {
    return true;
  }
  if(n_perks < level.perk_purchase_limit) {
    return true;
  }
  return false;
}

function function_61d38f32() {
  self endon("powerup_timedout");
  self waittill("powerup_grabbed");
  if(zm_utility::is_player_valid(self.power_up_grab_player)) {
    self.power_up_grab_player notify("hash_61bbe625");
  }
}

function function_160d5071(s_plant, str_anim) {
  self endon("death");
  self endon("hash_e9a97726");
  s_plant endon("hash_4729ad2");
  v_goal = getstartorigin(s_plant.origin, s_plant.angles, str_anim);
  v_goal = getclosestpointonnavmesh(v_goal);
  assert(isDefined(v_goal), (("" + s_plant.origin) + "") + str_anim);
  self.v_zombie_custom_goal_pos = v_goal;
  self.n_zombie_custom_goal_radius = 8;
  self thread function_b0fddaee(s_plant);
  while(true) {
    n_delta = distancesquared(v_goal, self.origin);
    if(n_delta > 256) {
      wait(0.05);
    } else {
      break;
    }
  }
  self.v_zombie_custom_goal_pos = undefined;
  wait(0.05);
  self notify("zombie_reached_anim_spot");
}

function function_b0fddaee(s_plant) {
  self endon("death");
  s_plant waittill("hash_4729ad2");
  if(isDefined(self.v_zombie_custom_goal_pos)) {
    self.v_zombie_custom_goal_pos = undefined;
  }
}

function function_40428876(s_plant, str_anim) {
  self endon("death");
  v_goal = getstartorigin(s_plant.origin, s_plant.angles, str_anim);
  self vehicle_ai::start_scripted();
  self setvehgoalpos(v_goal);
  self waittill("goal");
  self notify("zombie_reached_anim_spot");
}

function function_e851ad39() {
  zm_devgui::add_custom_devgui_callback( & function_2dbcc8ad);
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
}

function function_2dbcc8ad(cmd) {
  switch (cmd) {
    case "":
    case "":
    case "":
    case "":
    case "":
    case "":
    case "":
    case "":
    case "":
    case "":
    case "": {
      level thread function_b529e6f4(cmd);
      return true;
    }
    case "": {
      foreach(var_a68e9e1 in level.a_s_planting_spots) {
        if(!(isDefined(var_a68e9e1.var_75c7a97e) && var_a68e9e1.var_75c7a97e)) {
          var_a68e9e1.var_75c7a97e = 1;
          var_a68e9e1 notify("hash_378095a2");
          var_a68e9e1 thread function_ae64b39a(undefined, undefined, 1);
        }
      }
      return true;
    }
  }
  return false;
}

function function_b529e6f4(cmd) {
  switch (cmd) {
    case "": {
      var_a68e9e1 = level.players[0] function_c3cee22e();
      if(isDefined(var_a68e9e1)) {
        var_a68e9e1 notify("hash_378095a2");
        var_a68e9e1 thread function_ae64b39a(0);
      }
      break;
    }
    case "": {
      var_a68e9e1 = level.players[0] function_c3cee22e();
      if(isDefined(var_a68e9e1)) {
        var_a68e9e1 notify("hash_378095a2");
        var_a68e9e1 thread function_ae64b39a(1);
      }
      break;
    }
    case "": {
      var_a68e9e1 = level.players[0] function_c3cee22e();
      if(isDefined(var_a68e9e1)) {
        var_a68e9e1 notify("hash_378095a2");
        var_a68e9e1 thread function_ae64b39a(2);
      }
      break;
    }
    case "": {
      var_a68e9e1 = level.players[0] function_c3cee22e();
      if(isDefined(var_a68e9e1)) {
        var_a68e9e1 notify("hash_378095a2");
        var_a68e9e1 thread function_ae64b39a(3);
      }
      break;
    }
    case "": {
      var_a68e9e1 = level.players[0] function_c3cee22e();
      if(isDefined(var_a68e9e1)) {
        var_a68e9e1 notify("hash_378095a2");
        var_a68e9e1 thread function_ae64b39a(4);
      }
      break;
    }
    case "": {
      var_a68e9e1 = level.players[0] function_c3cee22e();
      if(isDefined(var_a68e9e1)) {
        var_a68e9e1 notify("hash_378095a2");
        var_a68e9e1 thread function_ae64b39a(5);
      }
      break;
    }
    case "": {
      var_a68e9e1 = level.players[0] function_c3cee22e();
      if(isDefined(var_a68e9e1)) {
        var_a68e9e1 notify("hash_378095a2");
        var_a68e9e1 thread function_ae64b39a(6);
      }
      break;
    }
    case "": {
      var_a68e9e1 = level.players[0] function_c3cee22e();
      if(isDefined(var_a68e9e1)) {
        var_a68e9e1 notify("hash_378095a2");
        var_a68e9e1 thread function_ae64b39a(7);
      }
      break;
    }
    case "": {
      var_a68e9e1 = level.players[0] function_c3cee22e();
      if(isDefined(var_a68e9e1)) {
        var_a68e9e1 notify("hash_378095a2");
        var_a68e9e1 thread function_ae64b39a(8);
      }
      break;
    }
    case "": {
      var_a68e9e1 = level.players[0] function_c3cee22e();
      if(isDefined(var_a68e9e1)) {
        var_a68e9e1 notify("hash_378095a2");
        var_a68e9e1 thread function_ae64b39a(9);
      }
      break;
    }
    case "": {
      var_a68e9e1 = level.players[0] function_c3cee22e();
      if(isDefined(var_a68e9e1)) {
        var_a68e9e1 notify("hash_378095a2");
        var_a68e9e1 thread function_ae64b39a(10);
      }
      break;
    }
  }
}

function function_c3cee22e() {
  var_5eaa768a = level.a_s_planting_spots;
  n_index = zm_utility::get_closest_index(self.origin, var_5eaa768a);
  s_spot = var_5eaa768a[n_index];
  if(!(isDefined(s_spot.var_75c7a97e) && s_spot.var_75c7a97e)) {
    s_spot.var_75c7a97e = 1;
    return s_spot;
  }
  return undefined;
}