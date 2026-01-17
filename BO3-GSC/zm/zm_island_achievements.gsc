/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_achievements.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_pack_a_punch_util;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace island_achievements;

function autoexec __init__sytem__() {
  system::register("zm_island_achievements", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_connect(&on_player_connect);
}

function on_player_connect() {
  self thread function_5efc5a29();
  self thread function_47538b42();
  self thread function_cdd905fd();
  self thread function_4a12afed();
  self thread function_d6e0957d();
  self thread function_ed8c7d0f();
  self thread function_53f54d29();
}

function function_5efc5a29() {
  level endon("end_game");
  self endon("disconnect");
  self waittill("hash_6c52e305");
  self giveachievement("ZM_ISLAND_CLONE_REVIVE");
}

function function_47538b42() {
  level endon("end_game");
  self endon("disconnect");
  self waittill("hash_aacf862e");
  self giveachievement("ZM_ISLAND_ELECTRIC_SHIELD");
}

function function_cdd905fd() {
  level endon("end_game");
  self endon("disconnect");
  self waittill("achievement_zm_island_thrasher_rescue");
  self giveachievement("ZM_ISLAND_THRASHER_RESCUE");
}

function function_ed8c7d0f() {
  level endon("end_game");
  self endon("disconnect");
  self waittill("hash_6c020c33");
  self giveachievement("ZM_ISLAND_DRINK_WINE");
}

function function_53f54d29() {
  level endon("end_game");
  self endon("disconnect");
  b_done = 0;
  while(!b_done) {
    var_8379db89 = 0;
    while(!self laststand::player_is_in_laststand() && self isplayerunderwater() && zombie_utility::is_player_valid(self) && !b_done) {
      wait(1);
      var_8379db89++;
      if(var_8379db89 >= 60) {
        self giveachievement("ZM_ISLAND_STAY_UNDERWATER");
        b_done = 1;
      }
    }
    wait(0.1);
  }
}

function function_4a12afed() {
  level endon("end_game");
  self endon("disconnect");
  self waittill("hash_1327d1d5");
  self giveachievement("ZM_ISLAND_DESTROY_WEBS");
}

function function_d6e0957d() {
  level endon("end_game");
  self endon("disconnect");
  self waittill("hash_cf72c127");
  self giveachievement("ZM_ISLAND_WONDER_KILL");
}