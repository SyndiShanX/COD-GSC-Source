/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1cf95a746cd3f159.gsc
***********************************************/

#using script_1351b3cdb6539f9b;
#using script_32a61480150c683;
#using script_3dc93ca9902a9cda;
#using script_61fee52bb750ac99;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace namespace_3ab3b856;

function start(str_objective) {}

function main(str_objective, var_50cc0d4f) {
  while(!isDefined(level.player_connected) || isDefined(level.player_connected) && level.player_connected != 1) {
    wait 1;
  }

  player = getplayers()[0];
  player val::set(#"temp_intro", "show_hud", 0);
  player val::set(#"temp_intro", "freezecontrols");
  player val::set(#"temp_intro", "disable_weapons");
  player val::set(#"temp_intro", "takedamage", 0);
  player val::set(#"temp_intro", "allowdeath", 0);
  player val::set(#"temp_intro", "hide");

  while(player.origin == (0, 0, 0)) {
    wait 1;
  }

  level namespace_b6fe1dbe::music("1.0_intro");
  level thread namespace_b6fe1dbe::intro_scene();
  wait 1;
  thread function_1fc6733a();
  wait 16.8;
  level thread globallogic_ui::function_7bc0e4b9();
  thread dialogue::radio("vox_cp_prsn_00100_adlr_duringamissiont_52");
  wait 7.5;
  thread dialogue::radio("vox_cp_prsn_00100_pilo_shitwevebeenhit_c6");
  wait 5;
  thread dialogue::radio("vox_cp_prsn_01000_adlr_accordingtoyour_54");
  level.var_708ccf64 = 1;
  level thread namespace_c6aa31df::function_61c7a808();
  wait 0.5;
  player val::reset(#"temp_intro", "show_hud");
  player val::reset(#"temp_intro", "freezecontrols");
  player val::reset(#"temp_intro", "disable_weapons");
  player val::reset(#"temp_intro", "takedamage");
  player val::reset(#"temp_intro", "allowdeath");
  player val::reset(#"temp_intro", "hide");

  if(isDefined(level.var_d7d201ba)) {
    level.player flag::set(level.var_d7d201ba);
  }

  wait 1.5;
  transient = savegame::function_6440b06b();
  transient.var_711aa308 = 1;
  skipto::function_4e3ab877("intro");
  wait 0.5;
}

function function_1fc6733a() {
  snd::play("vox_cp_prsn_00100_pers_donottrustadler_18");
  thread function_44a53adb(1.92, "vox_cp_prsn_02000_pers_adlerislyingtoy_9f");
  thread function_44a53adb(5.65, "vox_cp_prsn_02000_pers_dontlistentoadl_a4");
  thread function_44a53adb(8.14, "vox_cp_prsn_02000_pers_heslyingtoyoufi_3b");
  thread function_44a53adb(10.06, "vox_cp_prsn_02000_pers_heslyingtoyou_38");
  thread function_44a53adb(11.2, "vox_cp_prsn_02000_pers_donttrustadler_54");
}

function function_44a53adb(delay, alias) {
  wait delay;
  snd::play(alias);
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {}

function function_c26b0bc0() {
  level flag::init("start_vnm_sfx");
}