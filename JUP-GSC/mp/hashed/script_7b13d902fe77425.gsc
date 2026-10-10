/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7b13d902fe77425.gsc
************************************************/

#using script_485622d93fa7e4cf;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#namespace namespace_c241d988869e3ed2;

function private autoexec __init__system__() {
  system::register(#"hash_e73402fc3d333fae", undefined, &__init__, undefined);
}

function __init__() {
  if(!getdvarint(@ "hash_abc1d9ea495ec189", 0)) {
    return;
  }

  level.var_5797f7ed908af14 = &function_eaee8a3e6cdeefcf;
  level._effect["rift_gate_contract_streak_toxic"] = loadfx("vfx/s4/zombie/vfx_loot_trail_green.vfx");
  level._effect["rift_gate_contract_streak_electric"] = loadfx("vfx/s4/zombie/vfx_loot_trail_white.vfx");
  level._effect["rift_gate_contract_streak_fire"] = loadfx("vfx/s4/zombie/vfx_loot_trail_orange.vfx");
  level._effect["rift_gate_aether_tear_toxic"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_outbreak_tear_loop_green.vfx");
  level._effect["rift_gate_aether_tear_electric"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_outbreak_tear_loop_yellow.vfx");
  level._effect["rift_gate_aether_tear_fire"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_outbreak_tear_loop_red.vfx");
  level._effect["rift_gate_contract_glow_toxic"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_activity_phone_poison.vfx");
  level._effect["rift_gate_contract_glow_electric"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_activity_phone_elec.vfx");
  level._effect["rift_gate_contract_glow_fire"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_activity_phone_fire.vfx");
}

function function_22431e2db2413411(player) {
  if(getdvarint(@ "hash_9b01ae5336c960a6", 0)) {
    return 1;
  }

  return player namespace_510e82113265fae9::function_3bb8b73991355a1(19);
}

function function_eaee8a3e6cdeefcf(player) {
  if(getdvarint(@ "hash_368966a08aa72516", 0) == 0 || istrue(player.var_2123e95946a8122a) || !function_22431e2db2413411(player)) {
    return false;
  }

  return true;
}