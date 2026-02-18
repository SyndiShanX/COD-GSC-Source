/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_29b2775606111b4b.gsc
***********************************************/

#using script_1fd2c6e5fc8cb1c3;
#using script_2d443451ce681a;
#using script_4ec222619bffcfd1;
#using script_7901e9dc8618be8a;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#namespace kgb_aslt_vault_approach;

function starting(var_d3440450) {
  level thread namespace_e77bf565::function_277bceaa(0);
}

function main(var_d3440450, var_50cc0d4f) {
  level flag::set("aslt_vault_approach_begin");
  level battlechatter::function_2ab9360b(1);

  if(is_true(var_50cc0d4f)) {
    level.adler = namespace_e77bf565::function_52fe0eb3(var_d3440450);
    level.adler namespace_e77bf565::function_5770c74("assault");
    level thread scene::skipto_end_noai("scene_kgb_door_kick", "Last_Frame", undefined, 1);
    level thread scene::init("scene_kgb_utility_room_adler");
    level thread scene::init("scene_kgb_utility_room_player");
    level thread kgb_aslt_escape_lights_out::function_a0d18564();
    level thread namespace_e77bf565::function_1067ebf5("rotating_object_bunker", "player_grabbed_armor");
    level thread scene::init("scene_kgb_elevator_intro");
  }

  namespace_353d803e::music("11.0_sabotage");
  spawner::add_spawn_function_group("vault_guards", "script_noteworthy", &function_e38e5c6e);
  level thread namespace_e77bf565::function_7feb07bb(var_d3440450, var_50cc0d4f);
  level thread function_b735db01();
  level thread scene::init("scene_kgb_open_vault");
  level thread scene::init("scene_kgb_door_shoulder");
  level flag::wait_till("aslt_vault_approach_complete");

  if(isDefined(var_d3440450)) {
    skipto::function_4e3ab877(var_d3440450);
  }
}

function cleanup(name, starting, direct, player) {}

function init_flags() {
  level flag::init("aslt_vault_approach_begin");
  level flag::init("aslt_vault_approach_complete");
  level flag::init("player_plant_gas_started");
  level flag::init("player_planted_gas");
  level flag::init("vault_approach_runners_dead");
  level flag::init("assault_plant_gas_org_obj_created");
  level flag::init("scene_kgb_elevator_intro_inited");
}

function init_clientfields() {}

function function_22b7fffd() {
  animation::add_notetrack_func("kgb_aslt_vault_approach::vault_approach_runners", &vault_approach_runners);
  scene::add_scene_func("scene_kgb_elevator_intro", &function_dacdaa59, "init");
}

function function_3dacefac() {
  level.player endon(#"death");
  assault_plant_gas_org = struct::get("assault_plant_gas_org", "targetname");
  assault_plant_gas_org util::create_cursor_hint(undefined, undefined, #"hash_3047884ddd4a1374", undefined, undefined, undefined, undefined, undefined, undefined, 0, 0);
  level flag::wait_till("assault_plant_gas_org_obj_created");
  assault_plant_gas_org prompts::set_objective("obj_goto");
  level thread function_a133f1c5();
  assault_plant_gas_org waittill(#"trigger");
  level flag::set("player_plant_gas_started");
  level notify(#"hash_f7174846bbb8709");
  assault_plant_gas_org util::remove_cursor_hint();
  level thread namespace_e77bf565::cleanup_corpses();
  level.player val::set(#"scene_kgb_utility_room_player", "disable_weapons", 1);
  scene::play("scene_kgb_utility_room_player");
  level.player val::reset(#"scene_kgb_utility_room_player", "disable_weapons");
  level thread savegame::checkpoint_save();
  level flag::set("player_planted_gas");
}

function function_b735db01() {
  level.adler thread dialogue::queue("vox_cp_rkgb_03500_adlr_ifthingsgosouth_e6");
  level thread function_3dacefac();
  level.adler colors::disable();
  level scene::play("scene_kgb_utility_room_adler", "Intro");
  level thread scene::play("scene_kgb_utility_room_adler", "Loop");
  level flag::set("adler_at_vault_approach");
  level flag::wait_till("player_planted_gas");
  level.adler dialogue::queue("vox_cp_rkgb_03500_adlr_goodletsgettoth_a8");
  namespace_353d803e::music("11.3_combat2");
  level flag::wait_till("vault_approach_move_00");
  level scene::play("scene_kgb_utility_room_adler", "Outro");
  level.adler colors::set_force_color("g");
  level.adler colors::enable();
  level flag::wait_till("vault_approach_move_20");
  level thread savegame::checkpoint_save();
  level.adler dialogue::queue("vox_cp_rkgb_03600_adlr_werealmosttothe_1c");
}

function function_a133f1c5() {
  level endon(#"hash_f7174846bbb8709");
  level.player endon(#"death");
  var_a133f1c5 = [];
  var_a133f1c5[var_a133f1c5.size] = "vox_cp_rkgb_03500_adlr_hurryupandsetth_c8";
  var_a133f1c5[var_a133f1c5.size] = "vox_cp_rkgb_03500_adlr_clockstickingbe_65";
  var_a133f1c5[var_a133f1c5.size] = "vox_cp_rkgb_03500_adlr_getthegasreadyw_fe";
  wait 10;
  i = 0;

  while(true) {
    level.player thread objectives_ui::show_objectives();
    level.adler dialogue::queue("" + var_a133f1c5[i]);
    i++;

    if(i + 1 > var_a133f1c5.size) {
      i = 0;
    }

    wait 10;
  }
}

function vault_approach_runners(params) {
  enemies = spawner::simple_spawn("vault_approach_runners");
  ai::waittill_dead_or_dying(enemies);
  level flag::set("vault_approach_runners_dead");
}

function function_e38e5c6e() {
  self.ignoresuppression = 1;
}

function function_dacdaa59(params) {
  level flag::set("scene_kgb_elevator_intro_inited");
}