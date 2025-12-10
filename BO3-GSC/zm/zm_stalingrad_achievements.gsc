/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_achievements.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_stalingrad_achievements;

function autoexec __init__sytem__() {
  system::register("zm_stalingrad_achievements", &__init__, undefined, undefined);
}

function __init__() {
  level thread function_73d8758f();
  level thread function_42b2ae41();
  callback::on_connect(&on_player_connect);
}

function on_player_connect() {
  self thread function_69021ea7();
  self thread function_35e5c39b();
  self thread function_68cad44c();
  self thread function_77f84ddb();
  self thread function_3a3c9cc6();
  self thread function_b6e817dd();
  self thread function_bdcf8e90();
  self thread function_54dbe534();
}

function function_73d8758f() {
  level waittill("hash_c1471acf");
  array::run_all(level.players, &giveachievement, "ZM_STALINGRAD_NIKOLAI");
}

function function_69021ea7() {
  self endon("death");
  self waittill("hash_4e21f047");
  self giveachievement("ZM_STALINGRAD_WIELD_DRAGON");
}

function function_42b2ae41() {
  level waittill("hash_399599c1");
  array::run_all(level.players, &giveachievement, "ZM_STALINGRAD_TWENTY_ROUNDS");
}

function function_35e5c39b() {
  self endon("death");
  self waittill("hash_2e47bc4a");
  self giveachievement("ZM_STALINGRAD_RIDE_DRAGON");
}

function function_68cad44c() {
  self endon("death");
  self waittill("hash_1d89afbc");
  self giveachievement("ZM_STALINGRAD_LOCKDOWN");
}

function function_77f84ddb() {
  self endon("death");
  self waittill("hash_41370469");
  self giveachievement("ZM_STALINGRAD_SOLO_TRIALS");
}

function function_3a3c9cc6() {
  self endon("death");
  while(true) {
    self waittill("hash_c925c266", n_kill_count);
    if(n_kill_count >= 20) {
      self giveachievement("ZM_STALINGRAD_BEAM_KILL");
      return;
    }
  }
}

function function_b6e817dd() {
  self endon("death");
  while(true) {
    self waittill("hash_ddb84fad", n_kill_count);
    if(n_kill_count >= 8) {
      self giveachievement("ZM_STALINGRAD_STRIKE_DRAGON");
      return;
    }
  }
}

function function_bdcf8e90() {
  self endon("death");
  while(true) {
    self waittill("hash_8c80a390", n_kill_count);
    if(n_kill_count >= 10) {
      self giveachievement("ZM_STALINGRAD_FAFNIR_KILL");
      return;
    }
  }
}

function function_54dbe534() {
  self thread function_99a5ed1a(10);
  self thread function_60593db9(10);
}

function function_99a5ed1a(n_target_kills) {
  self endon("death");
  self endon("hash_c43b59a6");
  while(true) {
    self waittill("hash_e442448", n_kill_count);
    if(n_kill_count >= n_target_kills) {
      self giveachievement("ZM_STALINGRAD_AIR_ZOMBIES");
      self notify("hash_c43b59a6");
    }
  }
}

function function_60593db9(n_target_kills) {
  self endon("death");
  self endon("hash_c43b59a6");
  while(true) {
    self waittill("hash_f7608efe", n_kill_count);
    if(n_kill_count >= n_target_kills) {
      self giveachievement("ZM_STALINGRAD_AIR_ZOMBIES");
      self notify("hash_c43b59a6");
    }
  }
}