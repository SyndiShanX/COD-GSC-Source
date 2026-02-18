/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1c9985482fdb98fa.gsc
***********************************************/

#using script_1fd2c6e5fc8cb1c3;
#using script_4c90e79630523e91;
#using script_4ec222619bffcfd1;
#using script_7901e9dc8618be8a;
#using script_798f7d52f57a9c40;
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
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#namespace kgb_aslt_vault_breach;

function starting(var_d3440450) {
  level thread namespace_e77bf565::function_277bceaa(0);
}

function main(var_d3440450, var_50cc0d4f) {
  level flag::set("aslt_vault_breach_begin");
  level battlechatter::function_2ab9360b(1);

  if(is_true(var_50cc0d4f)) {
    level.adler = namespace_e77bf565::function_52fe0eb3(var_d3440450);
    level.adler namespace_e77bf565::function_5770c74("assault");
    level thread scene::skipto_end_noai("scene_kgb_door_kick", "Last_Frame", undefined, 1);
    level thread scene::init("scene_kgb_open_vault");
    level thread scene::init("scene_kgb_door_shoulder");
    level thread kgb_aslt_escape_lights_out::function_a0d18564();
    level thread namespace_e77bf565::function_1067ebf5("rotating_object_bunker", "player_grabbed_armor");
  }

  level thread scene::skipto_end_noai("scene_kgb_utility_room_adler", "Door_Closed", undefined, 1);
  level thread namespace_e77bf565::function_7feb07bb(var_d3440450, var_50cc0d4f);
  namespace_353d803e::music("deactivate_11.3_combat2");
  level thread function_b735db01(var_50cc0d4f);
  level flag::wait_till("aslt_vault_breach_complete");

  if(isDefined(var_d3440450)) {
    skipto::function_4e3ab877(var_d3440450);
  }
}

function cleanup(name, starting, direct, player) {}

function init_flags() {
  level flag::init("aslt_vault_breach_begin");
  level flag::init("aslt_vault_breach_complete");
  level flag::init("update_objective_position_on_vault_door");
  level flag::init("vault_breach_started");
  level flag::init("adler_enter_vault");
  level flag::init("adler_entered_vault");
  level flag::init("vault_breach_obj_org_obj_created");
}

function init_clientfields() {}

function function_22b7fffd() {
  scene::add_scene_func("scene_kgb_open_vault", &function_d0e338f0, "init");
  scene::add_scene_func("scene_kgb_open_vault", &function_d0e338f0);
  scene::add_scene_func("scene_kgb_open_vault", &function_d0e338f0, "done");
  animation::add_notetrack_func("kgb_aslt_vault_breach::player_end_function", &function_a5bde76d);
}

function function_b735db01(var_50cc0d4f = 0) {
  level.player endon(#"death");
  level thread function_7adf5eeb();
  level thread function_1b4d1d8b();
  wait 1;
  level flag::set("update_objective_position_on_vault_door");
  vault_breach_obj_org = struct::get("vault_breach_obj_org", "targetname");
  vault_breach_obj_org util::create_cursor_hint(undefined, undefined, #"hash_79514b2930c650bc", undefined, undefined, undefined, undefined, undefined, undefined, 0, 0);
  level flag::wait_till("vault_breach_obj_org_obj_created");
  vault_breach_obj_org prompts::set_objective("obj_goto");
  level thread function_50f19d5b();
  vault_breach_obj_org waittill(#"trigger");
  level thread kgb_aslt_bunker_escape::function_bfe40bf0();
  level thread kgb_aslt_vault::function_259d8d6f();
  vault_breach_obj_org util::remove_cursor_hint();
  level flag::set("vault_breach_started");
  level thread kgb_aslt_vault::function_833a9413(var_50cc0d4f);
  level notify(#"hash_46aa399eec4ff274");
  level thread function_3f313a71();
  level flag::set("adler_enter_vault");
  level.player val::set(#"scene_kgb_open_vault", "disable_weapons", 1);
  level scene::play("scene_kgb_open_vault", "Open_Vault");
  level flag::set("vault_opened");
}

function function_a5bde76d(params) {
  level.player val::reset(#"scene_kgb_open_vault", "disable_weapons");
}

function function_3f313a71() {
  level thread kgb_aslt_vault::function_46fe3d22(14);
  level thread namespace_353d803e::function_8c558bef();
  wait 13;
  level flag::set("aslt_vault_breach_complete");
}

function function_1b4d1d8b() {
  level.adler dialogue::queue("vox_cp_rkgb_04000_adlr_theresthevault_41");
  level.adler dialogue::queue("vox_cp_rkgb_04000_adlr_openthedooriveg_6c");
}

function function_7adf5eeb() {
  level.adler colors::disable();
  level thread scene::play("scene_kgb_vault_approach", "Wait_Outside_Vault");
  level flag::wait_till("adler_enter_vault");
  scene::play("scene_kgb_vault_approach", "Wait_For_Vault_Open_Enter");
  level thread scene::play("scene_kgb_vault_approach", "Wait_For_Vault_Open_Idle");
  level flag::set("adler_entered_vault");
}

function function_50f19d5b() {
  level endon(#"hash_46aa399eec4ff274");
  level.player endon(#"death");
  var_50f19d5b = [];
  var_50f19d5b[var_50f19d5b.size] = "vox_cp_rkgb_04000_adlr_comeonbellopent_fa";
  var_50f19d5b[var_50f19d5b.size] = "vox_cp_rkgb_04000_adlr_getthevaultopen_e0";
  var_50f19d5b[var_50f19d5b.size] = "vox_cp_rkgb_04000_adlr_openupthevaultb_30";
  wait 10;
  i = 0;

  while(true) {
    level.player thread objectives_ui::show_objectives();
    level.adler dialogue::queue("" + var_50f19d5b[i]);
    i++;

    if(i + 1 > var_50f19d5b.size) {
      i = 0;
    }

    wait 10;
  }
}

function function_d0e338f0(a_ents) {
  if(isDefined(a_ents[# "vault_door"])) {
    if(!isDefined(a_ents[# "vault_door"].var_89ce14f1)) {
      a_ents[# "vault_door"].var_89ce14f1 = getent("vault_door_clip_left", "targetname");

      if(isDefined(a_ents[# "vault_door"].var_89ce14f1)) {
        a_ents[# "vault_door"].var_89ce14f1 linkto(a_ents[# "vault_door"], "j_hinge_le", (0, 0, 0), (0, 180, 0));
      }
    }

    if(!isDefined(a_ents[# "vault_door"].var_82cafee)) {
      a_ents[# "vault_door"].var_82cafee = getent("vault_door_clip_right", "targetname");

      if(isDefined(a_ents[# "vault_door"].var_82cafee)) {
        a_ents[# "vault_door"].var_82cafee linkto(a_ents[# "vault_door"], "j_hinge_ri", (-18, 0, 0), (0, 0, 0));
      }
    }
  }
}