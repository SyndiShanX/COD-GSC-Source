/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_ee_yellow_snow.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\animation_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\zm_hms_util;
#include scripts\zm\zm_orange_pablo;
#include scripts\zm\zm_orange_snowball_piles;
#include scripts\zm\zm_orange_util;
#include scripts\zm_common\util\ai_dog_util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_cleanup_mgr;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_round_spawning;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_sq;
#include scripts\zm_common\zm_sq_modules;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_orange_ee_yellow_snow;

preload() {
  clientfield::register("scriptmover", "fx8_reward_brazier_fire_blue", 24000, 1, "int");
  clientfield::register("scriptmover", "fx8_snowpile_swap", 24000, 1, "int");
  clientfield::register("toplayer", "spleen_carry_sound", 20000, 1, "int");
  zm_sq_modules::function_d8383812(#"snowball_campfire_1", 24000, "snowball_campfire_1", &is_soul_capture, &soul_captured, 1);
  zm_sq_modules::function_d8383812(#"snowball_campfire_2", 24000, "snowball_campfire_2", &is_soul_capture, &soul_captured, 1);
  zm_sq_modules::function_d8383812(#"snowball_campfire_3", 24000, "snowball_campfire_3", &is_soul_capture, &soul_captured, 1);
  level flag::init(#"hash_5e095d53ae9513f5");
  level flag::init(#"hash_2b7269d8e32bf3d7");
}

main() {
  level function_47274b1e();
  level function_19f2a68d();
  zm_sq::register(#"yellow_snowballs", #"step_1", #"hash_2ed342ae0266e20", &function_8ba3d474, &function_f5a84740);
  zm_sq::register(#"yellow_snowballs", #"step_2", #"hash_2ed342ae0266e20", &function_37507fb7, &function_6ad60943);
  zm_sq::register(#"yellow_snowballs", #"step_3", #"hash_2ed342ae0266e20", &function_80794c22, &function_2b9f7a47);
  zm_sq::register(#"yellow_snowballs", #"step_4", #"hash_2ed342ae0266e20", &function_985dbc38, &function_256ebdea);
  level waittill(#"all_players_spawned");
  level function_698e6ba();

  if(!zm_utility::is_standard()) {
    zm_sq::start(#"yellow_snowballs", 1);
  }
}

function_47274b1e() {
  level.var_c2dce33e = 4;
  level flag::init(#"hash_6348b19cce4ffb0d");
  a_e_socks = getEntArray("axhead_black", "targetname");
  a_e_socks = array::randomize(a_e_socks);

  for(i = 0; i < a_e_socks.size; i++) {
    if(i == 0) {
      level.var_ad702d8c = a_e_socks[i];
      continue;
    }

    a_e_socks[i] delete();
  }

  a_e_socks = getEntArray("axhead_blood", "targetname");
  a_e_socks = array::randomize(a_e_socks);

  for(i = 0; i < a_e_socks.size; i++) {
    if(i == 0) {
      level.var_578ac6e1 = a_e_socks[i];
      continue;
    }

    a_e_socks[i] delete();
  }

  a_e_socks = getEntArray("axhead_silver", "targetname");
  a_e_socks = array::randomize(a_e_socks);

  for(i = 0; i < a_e_socks.size; i++) {
    if(i == 0) {
      level.var_c012bd5d = a_e_socks[i];
      continue;
    }

    a_e_socks[i] delete();
  }

  a_e_socks = getEntArray("axhead_copper", "targetname");
  a_e_socks = array::randomize(a_e_socks);

  for(i = 0; i < a_e_socks.size; i++) {
    if(i == 0) {
      level.a_cachinas = a_e_socks[i];
      continue;
    }

    a_e_socks[i] delete();
  }
}

function_19f2a68d() {
  level flag::init(#"hash_6faa166ee92f0315");
  a_s_campfires = struct::get_array("ax_blade", "targetname");
  a_s_campfires = array::randomize(a_s_campfires);

  for(i = 0; i < a_s_campfires.size; i++) {
    a_s_campfires[i].var_7944be4a = 0;
    a_s_campfires[i].var_b9989e12 = hash(a_s_campfires[i].script_noteworthy);
    a_s_campfires[i].e_vol = getent(a_s_campfires[i].target, "targetname");
    a_s_campfires[i].e_fire = getent(a_s_campfires[i].script_noteworthy, "targetname");
  }

  level.var_d41eca77 = a_s_campfires;
}

function_698e6ba() {
  level flag::init(#"hash_164603e43ce39588");
  level flag::init(#"hash_3ff453a959b4445b");
  level.var_292feb3b = getent("coozie", "targetname");
  level.var_3af3c634 = getent("warm_soda", "targetname");
  level exploder::exploder("fxexp_spleen_idle");
  level.var_3af3c634 hide();
  level.var_733d6b98 = undefined;
  level.var_27f2245a = 0;
}

function_8ba3d474(var_a276c861) {
  if(!var_a276c861) {
    level.var_ad702d8c setCanDamage(1);
    level.var_ad702d8c val::set("yellow_snowball_quest", "allowDeath", 0);
    level.var_ad702d8c thread function_f77c5d83();
    level.var_578ac6e1 setCanDamage(1);
    level.var_578ac6e1 val::set("yellow_snowball_quest", "allowDeath", 0);
    level.var_578ac6e1 thread function_f77c5d83();
    level.var_c012bd5d setCanDamage(1);
    level.var_c012bd5d val::set("yellow_snowball_quest", "allowDeath", 0);
    level.var_c012bd5d thread function_f77c5d83();
    level.a_cachinas setCanDamage(1);
    level.a_cachinas val::set("yellow_snowball_quest", "allowDeath", 0);
    level.a_cachinas thread function_f77c5d83();

    while(level.var_c2dce33e > 0) {
      wait 1;
    }
  }
}

function_f77c5d83() {
  b_hidden = 0;

  while(!b_hidden) {
    s_result = self waittill(#"damage");

    if(s_result.weapon.name === #"snowball" || s_result.weapon.name === #"snowball_upgraded") {
      level.var_c2dce33e -= 1;
      self hide();
      self setCanDamage(0);
      b_hidden = 1;

      if(level.var_c2dce33e <= 0) {
        s_result.attacker zm_orange_util::function_51b752a9("vox_generic_responses_positive", 1, 0);
      }
    }
  }
}

function_f5a84740(var_a276c861, var_19e802fa) {
  if(var_a276c861 || var_19e802fa) {
    level.var_ad702d8c setCanDamage(0);
    level.var_ad702d8c hide();
    level.var_c012bd5d setCanDamage(0);
    level.var_c012bd5d hide();
    level.var_578ac6e1 setCanDamage(0);
    level.var_578ac6e1 hide();
    level.a_cachinas setCanDamage(0);
    level.a_cachinas hide();
    level.var_c2dce33e = 0;
  }
}

function_37507fb7(var_a276c861) {
  if(!var_a276c861) {
    foreach(s_campfire in level.var_d41eca77) {
      s_campfire.e_fire setModel("p8_zm_gla_nor_fire_pit_01_wood_pile_emissive");

      switch (s_campfire.script_noteworthy) {
        case #"snowball_campfire_1":
          exploder::exploder("fxexp_campfire_house_blue");
          break;
        case #"snowball_campfire_2":
          exploder::exploder("fxexp_campfire_crevasse_blue");
          break;
        case #"snowball_campfire_3":
          exploder::exploder("fxexp_campfire_beach_blue");
          break;
      }

      s_campfire.e_snd = spawn("script_origin", s_campfire.origin);
      s_campfire.e_snd playLoopSound(#"hash_4557560b04b84279");
      zm_sq_modules::function_3f808d3d(s_campfire.var_b9989e12);
      s_campfire waittill(#"hash_1f9b852104ab2c13");
      s_campfire.e_fire setModel("p8_zm_gla_nor_fire_pit_01_wood_pile");

      switch (s_campfire.script_noteworthy) {
        case #"snowball_campfire_1":
          exploder::stop_exploder("fxexp_campfire_house_blue");
          break;
        case #"snowball_campfire_2":
          exploder::stop_exploder("fxexp_campfire_crevasse_blue");
          break;
        case #"snowball_campfire_3":
          exploder::stop_exploder("fxexp_campfire_beach_blue");
          break;
      }

      s_campfire.e_snd delete();
    }
  }
}

is_soul_capture(var_88206a50, ent) {
  if(isDefined(ent)) {
    b_killed_by_player = isDefined(ent.attacker) && isplayer(ent.attacker) || isDefined(ent.damageinflictor) && isplayer(ent.damageinflictor);
    var_e93788f1 = var_88206a50.e_vol;
    return (b_killed_by_player && ent istouching(var_e93788f1));
  }

  return false;
}

soul_captured(var_f0e6c7a2, ent) {
  n_souls_required = 20;
  var_f0e6c7a2.var_7944be4a++;

  if(level flag::get(#"soul_fill")) {
    var_f0e6c7a2.var_7944be4a = n_souls_required;
  }

    if(var_f0e6c7a2.var_7944be4a >= n_souls_required) {
      var_f0e6c7a2 function_a66f0de2();
    }
}

function_a66f0de2() {
  zm_sq_modules::function_2a94055d(self.var_b9989e12);
  self notify(#"hash_1f9b852104ab2c13");
}

function_6ad60943(var_a276c861, var_19e802fa) {
  if(var_19e802fa) {}

  zm_utility::play_sound_2d("zmb_yellow_snowball_stinger");

  iprintlnbold("<dev string:x38>");

    level.var_292feb3b setModel("p8_zm_ora_specimen_container_lrg_cracked");
  level thread function_cf298764();
}

function_80794c22(var_a276c861) {
  if(!var_a276c861) {
    level.var_292feb3b playSound(#"hash_455262d440576e2c");
    level.var_292feb3b setCanDamage(1);
    level.var_292feb3b val::set("yellow_snowball_quest", "allowDeath", 0);
    level.var_292feb3b thread function_7c1a1d9a();
    level flag::wait_till(#"hash_164603e43ce39588");
  }
}

function_cf298764() {
  a_players_in_zone = 0;
  is_done = 0;

  while(!is_done) {
    a_players_in_zone = zm_zonemgr::get_players_in_zone("upper_catwalk", 1);

    if(a_players_in_zone.size > 0) {
      e_speaker = array::random(a_players_in_zone);
      e_speaker thread zm_orange_util::function_51b752a9("vox_spleen_glass_shoot", -1, 1, 0);
      is_done = 1;
    } else {
      a_players_in_zone = zm_zonemgr::get_players_in_zone("upper_catwalk", 1);

      if(a_players_in_zone.size > 0) {
        e_speaker = array::random(a_players_in_zone);
        e_speaker thread zm_orange_util::function_51b752a9("vox_spleen_glass_shoot", -1, 1, 0);
        is_done = 1;
      }
    }

    wait 0.25;
  }
}

function_7c1a1d9a() {
  b_shattered = 0;

  while(!b_shattered) {
    s_result = self waittill(#"damage");

    if(isplayer(s_result.attacker) && !isbot(s_result.attacker)) {
      self setModel("p8_zm_ora_specimen_container_lrg_dmg");
      self playSound(#"hash_4284a1b7bc4ce7df");
      level exploder::kill_exploder("fxexp_spleen_idle");
      level exploder::exploder("fxexp_inf_tank_water_gush_fx_yllw_snow_quest");
      level exploder::exploder("fxexp_containment_exp");
      level.var_3af3c634 show();
      self setCanDamage(0);
      b_shattered = 1;
      level flag::set(#"hash_164603e43ce39588");
    }
  }
}

function_2b9f7a47(var_a276c861, var_19e802fa) {
  if(var_a276c861 || var_19e802fa) {
    level.var_292feb3b setModel("p8_zm_ora_specimen_container_lrg_dmg");
    level.var_292feb3b setCanDamage(0);
    level.var_3af3c634 show();
    level flag::set(#"hash_164603e43ce39588");
  }
}

function_985dbc38(var_a276c861) {
  if(!var_a276c861) {
    zm_orange_pablo::register_drop_off(10, #"hash_1edb26dc1cc6e119", #"hash_3ca7be08f434c427", &function_901d1798, &function_6d2ddf57);
    zm_orange_pablo::function_3f9e02b8(2, #"hash_423ddf1f1bc39137", #"hash_423ddf1f1bc39137", &function_ae42be1);
    level.var_3af3c634 zm_unitrigger::create("", 96);
    level.var_3af3c634 thread function_c0ee8171();
    level flag::wait_till(#"hash_3ff453a959b4445b");
    zm_orange_pablo::function_d83490c5(2);
    level flag::wait_till(#"hash_5e095d53ae9513f5");
  }
}

function_6d2ddf57(e_player) {
  if(isDefined(level.var_733d6b98) && e_player == level.var_733d6b98) {
    return 1;
  }

  return 0;
}

function_c0ee8171() {
  s_activation = self waittill(#"trigger_activated");
  e_who = s_activation.e_who;

  if(!level.var_27f2245a) {
    level thread pickup_spleen_vo(e_who);
    level.var_27f2245a = 1;
  }

  playsoundatposition(#"hash_16a225866d646305", level.var_3af3c634.origin);
  level.var_3af3c634 hide();
  level.var_733d6b98 = e_who;
  level zm_ui_inventory::function_7df6bb60("zm_orange_spleen", 1, level.var_733d6b98);
  zm_orange_pablo::function_d83490c5(10);
  level thread function_68789b17();
  level thread function_c9195d31();
}

pickup_spleen_vo(e_who) {
  e_who thread zm_orange_util::function_51b752a9("vox_spleen_pickup", -1, 1, 0);

  if(level.var_98138d6b > 1 && !level flag::get(#"hash_2b7269d8e32bf3d7")) {
    level flag::set(#"hash_2b7269d8e32bf3d7");
    level.var_1c53964e zm_hms_util::function_6a0d675d("vox_spleen_pickup", 0, 1, 0);
  }
}

function_c9195d31() {
  level endon(#"hash_4e1c4cd8c0b0a609");
  level endon(#"hash_3ff453a959b4445b");
  level.pablo_npc waittill(#"hash_276524e7f5657e50");

  if(level.pablo_npc.var_df3d62aa == 10) {
    level notify(#"hash_65989ff1ec5fcff9");
    level.var_733d6b98 clientfield::set_to_player("spleen_carry_sound", 0);
    level zm_ui_inventory::function_7df6bb60("zm_orange_spleen", 0, level.var_733d6b98);
  }
}

function_68789b17() {
  level endon(#"hash_3ff453a959b4445b");
  level endon(#"hash_65989ff1ec5fcff9");
  level.var_74f3565a = 0;
  level thread function_b4b483e7();
  level thread function_17567d83();

  while(level.var_74f3565a < 30) {
    if(zm_utility::is_player_valid(level.var_733d6b98) && level.var_733d6b98.b_in_water === 1) {
      if(level.var_74f3565a > 0) {
        level.var_74f3565a -= 0.2;
      }
    } else {
      level.var_74f3565a += 0.1;
    }

    wait 0.1;
  }

  level notify(#"hash_4e1c4cd8c0b0a609");
  level.var_733d6b98 clientfield::set_to_player("spleen_carry_sound", 0);

  if(isDefined(level.var_733d6b98)) {
    level thread function_d4d89065();
  }

  zm_orange_pablo::function_6aaeff92(10);
  level zm_ui_inventory::function_7df6bb60("zm_orange_spleen", 0, level.var_733d6b98);
  level.var_733d6b98 = undefined;
  level.var_3af3c634 show();
  level.var_3af3c634 thread function_c0ee8171();

  iprintlnbold("<dev string:x64>");

}

function_d4d89065() {
  level.var_733d6b98 zm_orange_util::function_51b752a9("vox_generic_responses_negative", -1, 1, 0);

  if(level.var_98138d6b > 1) {
    level.var_1c53964e zm_hms_util::function_6a0d675d("vox_spleen_fail", 0, 1, 0);
  }
}

function_b4b483e7() {
  level endon(#"hash_65989ff1ec5fcff9");
  level endon(#"hash_3ff453a959b4445b");
  level endon(#"hash_4e1c4cd8c0b0a609");

  while(true) {

    if(level.var_74f3565a >= 22.5) {
      iprintlnbold("<dev string:x93>");
    } else if(level.var_74f3565a >= 15) {
      iprintlnbold("<dev string:xa5>");
    } else if(level.var_74f3565a >= 7.5) {
      iprintlnbold("<dev string:xb7>");
    } else {
      iprintlnbold("<dev string:xc9>");
    }

      wait 2.5;
  }
}

function_17567d83() {
  level endon(#"hash_65989ff1ec5fcff9");
  level endon(#"hash_3ff453a959b4445b");
  level endon(#"hash_4e1c4cd8c0b0a609");

  if(isDefined(level.var_733d6b98)) {
    level.var_733d6b98 clientfield::set_to_player("spleen_carry_sound", 1);
  }

  while(true) {
    if(isDefined(level.var_733d6b98)) {
      level.var_733d6b98 playsoundtoplayer(#"hash_2c0513350d4300f3", level.var_733d6b98);
    }

    if(level.var_74f3565a >= 22.5) {
      n_wait_time = 0.3;
    } else if(level.var_74f3565a >= 15) {
      n_wait_time = 0.6;
    } else if(level.var_74f3565a >= 7.5) {
      n_wait_time = 1;
    } else {
      n_wait_time = 1.5;
    }

    wait n_wait_time;
  }
}

function_901d1798() {
  level flag::set(#"hash_3ff453a959b4445b");
}

function_ae42be1() {
  level flag::set(#"hash_5e095d53ae9513f5");
  level thread function_b51a6dd7();

  if(isDefined(level.var_d1206a2b)) {
    level.var_d1206a2b zm_orange_snowball_piles::function_79ef6b93();
  }
}

function_b51a6dd7() {
  a_s_snowball_piles = struct::get_array("snowball_pile");

  foreach(s_snowball_pile in a_s_snowball_piles) {
    s_snowball_pile.e_model setModel("p8_zm_ora_yellow_snowball_pile");
    s_snowball_pile.e_model clientfield::set("fx8_snowpile_swap", 1);
  }
}

function_256ebdea(var_a276c861, var_19e802fa) {
  if(var_a276c861 || var_19e802fa) {
    level thread function_b51a6dd7();
    level flag::set(#"hash_3ff453a959b4445b");
    level flag::set(#"hash_5e095d53ae9513f5");
  }
}