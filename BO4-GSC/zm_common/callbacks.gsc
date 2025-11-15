/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\callbacks.gsc
***********************************************/

#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\bots\bot;
#include scripts\core_common\bots\bot_traversals;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\globallogic\globallogic_vehicle;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\weapons\deployable;
#include scripts\zm_common\gametypes\globallogic;
#include scripts\zm_common\gametypes\globallogic_actor;
#include scripts\zm_common\gametypes\globallogic_player;
#include scripts\zm_common\gametypes\globallogic_scriptmover;
#include scripts\zm_common\gametypes\hostmigration;

#namespace callback;

autoexec __init__system__() {
  system::register(#"callback", &__init__, undefined, undefined);
}

__init__() {
  level thread setup_callbacks();
}

setup_callbacks() {
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

setdefaultcallbacks() {
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
  level.callbackbotentereduseredge = &bot::callback_botentereduseredge;
  level.callbackbotcreateplayerbot = &bot::function_c6e29bdf;
  level.callbackbotshutdown = &bot::function_3d575aa3;
  level.var_69959686 = &deployable::function_209fda28;
  level._gametype_default = "zclassic";
}

function_6e6149a6(func, obj) {
  add_callback(#"hash_1eda827ff5e6895b", func, obj);
}

function_823e7181(func, obj) {
  remove_callback(#"hash_34edc1c4f45e5572", func, obj);
}

function_4b58e5ab(func, obj) {
  add_callback(#"hash_210adcf09e99fba1", func, obj);
}

function_66d5d485(func, obj) {
  remove_callback(#"hash_1863ba8e81df2a64", func, obj);
}

function_74872db6(func, obj) {
  add_callback(#"hash_6df5348c2fb9a509", func, obj);
}

function_50fdac80(func, obj) {
  remove_callback(#"hash_6df5348c2fb9a509", func, obj);
}

on_round_end(func, obj) {
  add_callback(#"on_round_end", func, obj);
}

remove_on_round_end(func, obj) {
  remove_callback(#"on_round_end", func, obj);
}

function_b3c9adb7(func, obj) {
  add_callback(#"hash_7d40e25056b9275c", func, obj);
}

function_342b2f6(func, obj) {
  remove_callback(#"hash_7d40e25056b9275c", func, obj);
}

function_aebeafc0(func, obj) {
  add_callback(#"hash_790b67aca1bf8fc0", func, obj);
}

function_3e2ed898(func, obj) {
  remove_callback(#"hash_790b67aca1bf8fc0", func, obj);
}