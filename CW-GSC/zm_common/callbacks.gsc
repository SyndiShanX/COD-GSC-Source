/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\callbacks.gsc
***********************************************/

#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\globallogic\globallogic_vehicle;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\weapons\deployable;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_actor;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\gametypes\globallogic_scriptmover;
#using scripts\zm_common\gametypes\hostmigration;
#using scripts\zm_common\zm_player;
#namespace callback;

function private autoexec __init__system__() {
  system::register(#"callback", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level thread setup_callbacks();
}

function setup_callbacks() {
  setdefaultcallbacks();
  level.idflags_noflag = 0;
  level.idflags_radius = 1;
  level.idflags_no_armor = 2;
  level.idflags_no_knockback = 4;
  level.idflags_penetration = 8;
  level.idflags_destructible_entity = 16;
  level.idflags_shield_explosive_impact = 32;
  level.idflags_shield_explosive_impact_huge = 64;
  level.idflags_shield_explosive_splash = 128;
  level.idflags_hurt_trigger_allow_laststand = 256;
  level.idflags_disable_ragdoll_skip = 512;
  level.idflags_no_team_protection = 8192;
  level.var_598c4d23 = 16384;
  level.var_681a9181 = 32768;
}

function setdefaultcallbacks() {
  level.callbackstartgametype = &globallogic::callback_startgametype;
  level.callbackplayerconnect = &globallogic_player::callback_playerconnect;
  level.callbackplayerdisconnect = &globallogic_player::callback_playerdisconnect;
  level.callbackplayermelee = &globallogic_player::callback_playermelee;
  level.callbackactorspawned = &globallogic_actor::callback_actorspawned;
  level.callbackactorcloned = &globallogic_actor::callback_actorcloned;
  level.var_6788bf11 = &globallogic_scriptmover::function_8c7ec52f;
  level.callbackvehiclespawned = &globallogic_vehicle::callback_vehiclespawned;
  level.callbackplayermigrated = &globallogic_player::callback_playermigrated;
  level.callbackhostmigration = &hostmigration::callback_hostmigration;
  level.callbackhostmigrationsave = &hostmigration::callback_hostmigrationsave;
  level.callbackprehostmigrationsave = &hostmigration::callback_prehostmigrationsave;
  level.var_69959686 = &deployable::function_209fda28;
  level.var_523faa05 = &function_2750bb69;
  level.var_3a9881cb = &zm_player::function_74b6d714;
  level._gametype_default = "zclassic";
}

function function_2750bb69(weapon) {
  self callback(#"hash_6dc96d04d1ba7f5a", {
    #weapon: weapon
  });
}

function function_6e6149a6(func, obj) {
  add_callback(#"hash_1eda827ff5e6895b", func, obj);
}

function function_823e7181(func, obj) {
  remove_callback(#"hash_34edc1c4f45e5572", func, obj);
}

function function_4b58e5ab(func, obj) {
  add_callback(#"hash_210adcf09e99fba1", func, obj);
}

function function_66d5d485(func, obj) {
  remove_callback(#"hash_1863ba8e81df2a64", func, obj);
}

function function_dfd4b1a0(func, obj) {
  add_callback(#"hash_7cdd5b06f3e281c6", func, obj);
}

function function_34700b93(func, obj) {
  remove_callback(#"hash_4e737d409e1399c9", func, obj);
}

function function_74872db6(func, obj) {
  add_callback(#"hash_6df5348c2fb9a509", func, obj);
}

function function_50fdac80(func, obj) {
  remove_callback(#"hash_6df5348c2fb9a509", func, obj);
}

function on_round_end(func, obj) {
  add_callback(#"on_round_end", func, obj);
}

function remove_on_round_end(func, obj) {
  remove_callback(#"on_round_end", func, obj);
}

function function_b3c9adb7(func, obj) {
  add_callback(#"hash_7d40e25056b9275c", func, obj);
}

function function_342b2f6(func, obj) {
  remove_callback(#"hash_7d40e25056b9275c", func, obj);
}

function function_aebeafc0(func, obj) {
  add_callback(#"hash_790b67aca1bf8fc0", func, obj);
}

function function_3e2ed898(func, obj) {
  remove_callback(#"hash_790b67aca1bf8fc0", func, obj);
}