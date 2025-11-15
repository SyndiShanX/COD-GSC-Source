/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_spider_ee_quest.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\player_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_ai_spiders;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_pack_a_punch;
#using scripts\zm\_zm_pack_a_punch_util;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_controllable_spider;
#using scripts\zm\_zm_weap_keeper_skull;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\craftables\_zm_craftables;
#using scripts\zm\zm_island_perks;
#using scripts\zm\zm_island_util;
#using scripts\zm\zm_island_vo;
#namespace namespace_1aa6bd0c;

function init() {
  register_clientfields();
}

function register_clientfields() {
  clientfield::register("vehicle", "spider_glow_fx", 9000, 1, "int");
  clientfield::register("vehicle", "spider_drinks_fx", 9000, 2, "int");
  clientfield::register("scriptmover", "jungle_cage_charged_fx", 9000, 1, "int");
}

function main() {
  level flag::init("spider_from_mars_trapped_in_raised_cage");
  level flag::init("spiders_from_mars_round");
  level flag::init("spider_ee_quest_complete");
  level flag::init("charged_spider_cage_powerup");
  level.var_335f95e4 = undefined;
  level thread function_b27f5ad5();
  function_315620f9();
}

function function_b27f5ad5() {
  level thread function_89826011();
  level flag::wait_till("skull_quest_complete");
  level flag::wait_till("ww3_found");
  level.var_1821d194 = 0;
  level.var_2aacffb1 = & function_78b57752;
  level flag::wait_till("spiders_from_mars_round");
  level.var_2aacffb1 = undefined;
}

function function_78b57752() {
  if(!(isDefined(level.var_1821d194) && level.var_1821d194) && (!(isDefined(level.var_8c36ad2d) && level.var_8c36ad2d)) && self.archetype === "spider" && math::cointoss()) {
    self.var_b4e06d32 = 1;
    self.b_ignore_cleanup = 1;
    self flag::init("spider_from_mars_identified");
    level.var_1821d194 = 1;
    level thread function_f163b5b5();
    self thread function_ed878303();
    self thread function_241013f7();
  }
}

function function_f163b5b5() {
  level.var_8c36ad2d = 1;
  level waittill("between_round_over");
  level.var_8c36ad2d = undefined;
}

function function_ed878303() {
  self waittill("death");
  level.var_1821d194 = 0;
}

function function_241013f7() {
  self endon("death");
  self flag::wait_till("spider_from_mars_identified");
  self.var_75bf845a = [];
  while(true) {
    foreach(t_water in level.var_4a0060c0) {
      if(!isinarray(self.var_75bf845a, t_water.script_int) && self istouching(t_water)) {
        self.var_75bf845a[self.var_75bf845a.size] = t_water.script_int;
        self thread function_60b06e98(t_water.script_int);
      }
    }
    if(self.var_75bf845a.size == 3) {
      self thread function_c8ca27d0();
      break;
    }
    wait(1);
  }
}

function function_60b06e98(var_c6cad973) {
  self endon("death");
  self vehicle_ai::set_state("scripted");
  self clientfield::set("spider_drinks_fx", var_c6cad973);
  loop_snd_ent = spawn("script_origin", self.origin);
  loop_snd_ent playLoopSound("zmb_spider_drinking", 0.5);
  level thread zm_island_vo::function_1e767f71(self, 600, "ee", "spider_lure", 10, 1, 3);
  wait(3);
  self clientfield::set("spider_drinks_fx", 0);
  self vehicle_ai::set_state("combat");
  loop_snd_ent stoploopsound(0.5);
  loop_snd_ent delete();
}

function function_c8ca27d0() {
  self clientfield::set("spider_glow_fx", 1);
  self.var_f7522faa = 1;
}

function function_aa515242(var_c79d3f71) {
  var_c79d3f71 thread function_6dff284c();
  level.var_18ddef1f = 1;
  level.var_335f95e4 = var_c79d3f71;
}

function function_6dff284c() {
  self util::waittill_notify_or_timeout("death", 150);
  if(isalive(self)) {
    if(!(isDefined(level.var_3ef945d6) && level.var_3ef945d6)) {
      self util::stop_magic_bullet_shield();
      self dodamage(self.health, self.origin);
    } else {
      self waittill("death");
    }
  }
  level.var_67359403 = 0;
  level.var_18ddef1f = 0;
  level.var_335f95e4 = undefined;
  level flag::clear("spider_from_mars_trapped_in_raised_cage");
}

function function_89826011() {
  level endon("hash_d8d0f829");
  e_clip = getent("clip_spider_cage", "targetname");
  e_clip setCanDamage(1);
  e_clip.health = 100000;
  var_a2176993 = getent("jungle_lab_ee_control_panel_elf", "targetname");
  while(true) {
    e_clip waittill("damage", n_damage, e_attacker, v_direction, v_point, str_mod, str_tag_name, str_model_name, str_part_name, w_weapon);
    if(!level.var_1dbad94a && !level flag::get("power_on")) {
      continue;
    }
    if(w_weapon.name === "island_riotshield" && (isDefined(e_attacker.var_36c3d64a) && e_attacker.var_36c3d64a) && (!(isDefined(level.var_1deeff56) && level.var_1deeff56)) && (!(isDefined(level.var_90e478e7) && level.var_90e478e7)) && (!(isDefined(level.var_48762d0c) && level.var_48762d0c))) {
      e_attacker notify("riotshield_lost_lightning");
      level.var_1deeff56 = 1;
      var_a2176993 clientfield::set("jungle_cage_charged_fx", 1);
      level waittill("hash_59a385d1");
      var_a2176993 clientfield::set("jungle_cage_charged_fx", 0);
      level waittill("hash_35cee1df");
      level.var_1deeff56 = 0;
    }
  }
}

function function_69f5a9c5(var_1cdfa0f4) {
  level notify("hash_59a385d1");
  if(isDefined(level.var_18ddef1f) && level.var_18ddef1f) {
    level.var_335f95e4.allowdeath = 1;
    level.var_335f95e4 dodamage(level.var_335f95e4.health, level.var_335f95e4.origin);
    spiders_from_mars_round();
  } else if(!level flag::get("charged_spider_cage_powerup")) {
    level flag::set("charged_spider_cage_powerup");
    level thread function_901514b1();
  }
}

function function_901514b1() {
  level._powerup_timeout_custom_time = & function_3321a018;
  var_93eb638b = zm_powerups::specific_powerup_drop(undefined, level.var_1a139831.origin - vectorscale((0, 0, 1), 110));
  var_93eb638b linkto(level.var_1a139831);
  level._powerup_timeout_custom_time = undefined;
}

function function_3321a018(var_93eb638b) {
  return 90;
}

function function_c9e92f7b() {
  if(level.var_67359403) {
    level flag::set("spider_from_mars_trapped_in_raised_cage");
  }
  level notify("hash_35cee1df");
}

function function_49fac1ac() {
  if(self.archetype === "spider") {
    self clientfield::set("spider_glow_fx", 1);
  }
}

function spiders_from_mars_round() {
  function_7855f232();
  if(level flag::get("spider_round_in_progress")) {
    level flag::wait_till_clear("spider_round_in_progress");
    level.var_3013498 = level.round_number + 2;
  } else {
    level.var_3013498 = level.round_number + 1;
  }
  while(true) {
    level flag::wait_till("spider_round_in_progress");
    if(level flag::get("spider_round")) {
      level flag::set("spiders_from_mars_round");
      callback::on_ai_spawned( & function_49fac1ac);
      level waittill("end_of_round");
      level thread function_2176e192();
      break;
    }
  }
}

function function_7855f232() {
  level.var_39b24700 = getEntArray("spiders_from_mars_spawner", "script_noteworthy");
  if(level.var_39b24700.size == 0) {
    return;
  }
  for(i = 0; i < level.var_39b24700.size; i++) {
    if(zm_spawner::is_spawner_targeted_by_blocker(level.var_39b24700[i])) {
      level.var_39b24700[i].is_enabled = 0;
      continue;
    }
    level.var_39b24700[i].is_enabled = 1;
    level.var_39b24700[i].script_forcespawn = 1;
  }
  assert(level.var_39b24700.size > 0);
  array::thread_all(level.var_39b24700, & spawner::add_spawn_function, & zm_ai_spiders::function_7c1ef59b);
}

function function_2176e192() {
  level flag::set("spider_ee_quest_complete");
  level flag::clear("spiders_from_mars_round");
  callback::remove_on_ai_spawned( & function_49fac1ac);
  var_30ff0d6c = util::spawn_model("p7_zm_isl_cocoon_standing", level.var_1a139831.origin - vectorscale((0, 0, 1), 110), level.var_1a139831.angles);
  var_30ff0d6c linkto(level.var_1a139831);
  level.var_f5ad590f = undefined;
  level waittill("hash_35cee1df");
  var_db6efb17 = getent("venom_extractor", "targetname");
  var_db6efb17 thread scene::play("p7_fxanim_zm_island_venom_extractor_red_bundle", var_db6efb17);
  level waittill("hash_e48828c5");
  var_1f71eb1 = struct::get("spider_ee_quest_reward", "targetname");
  var_1f71eb1.origin = var_1f71eb1.origin;
  var_1f71eb1.angles = var_1f71eb1.angles;
  var_1f71eb1.e_parent = var_30ff0d6c;
  var_1f71eb1.script_unitrigger_type = "unitrigger_box_use";
  var_1f71eb1.cursor_hint = "HINT_NOICON";
  var_1f71eb1.require_look_at = 1;
  var_1f71eb1.script_width = 128;
  var_1f71eb1.script_length = 130;
  var_1f71eb1.script_height = 100;
  var_1f71eb1.prompt_and_visibility_func = & function_bf0f2293;
  zm_unitrigger::register_static_unitrigger(var_1f71eb1, & function_2818665b);
  var_f78dfee = struct::get("spider_cage_control");
  zm_unitrigger::unregister_unitrigger(var_f78dfee.trigger);
  level notify("hash_d8d0f829");
}

function function_bf0f2293(player) {
  if(player hasweapon(level.w_controllable_spider)) {
    self sethintstring("");
    return false;
  }
  self sethintstring("ZM_ISLAND_SPIDER_EQUIPMENT_PICKUP");
  return true;
}

function function_2818665b() {
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
    if(e_who hasweapon(level.w_controllable_spider)) {
      continue;
    }
    e_who notify("aquired_spider_equipment");
    e_who thread controllable_spider::function_468b927();
  }
}

function function_315620f9() {
  zm_devgui::add_custom_devgui_callback( & function_acbe4aed);
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
}

function function_acbe4aed(cmd) {
  switch (cmd) {
    case "": {
      var_c79d3f71 = undefined;
      a_ai = getaiteamarray("");
      foreach(ai in a_ai) {
        if(isDefined(ai.b_is_spider) && ai.b_is_spider && (isDefined(ai.var_b4e06d32) && ai.var_b4e06d32)) {
          var_c79d3f71 = ai;
          break;
        }
      }
      if(!isDefined(var_c79d3f71)) {
        var_19764360 = zm_ai_spiders::get_favorite_enemy();
        s_spawn_point = zm_ai_spiders::function_570247b9(var_19764360);
        var_c79d3f71 = zombie_utility::spawn_zombie(level.var_c38a4fee[0]);
        if(isDefined(var_c79d3f71)) {
          s_spawn_point thread zm_ai_spiders::function_49e57a3b(var_c79d3f71, s_spawn_point);
        }
      }
      var_c79d3f71 clientfield::set("", 1);
      var_c79d3f71.var_f7522faa = 1;
      return true;
    }
    case "": {
      level thread spiders_from_mars_round();
      return true;
    }
    case "": {
      if(!isDefined(var_c79d3f71)) {
        var_19764360 = zm_ai_spiders::get_favorite_enemy();
        s_spawn_point = zm_ai_spiders::function_570247b9(var_19764360);
        var_c79d3f71 = zombie_utility::spawn_zombie(level.var_c38a4fee[0]);
        if(isDefined(var_c79d3f71)) {
          s_spawn_point thread zm_ai_spiders::function_49e57a3b(var_c79d3f71, s_spawn_point);
        }
      }
      var_c79d3f71 clientfield::set("", 1);
      var_c79d3f71.var_b4e06d32 = 1;
      var_c79d3f71.b_ignore_cleanup = 1;
      var_c79d3f71 flag::init("");
      var_c79d3f71 flag::set("");
      level.var_1821d194 = 1;
      level thread function_f163b5b5();
      var_c79d3f71 thread function_ed878303();
      var_c79d3f71 thread function_241013f7();
      return true;
    }
  }
  return false;
}