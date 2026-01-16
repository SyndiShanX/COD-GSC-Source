/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\mp\weaponobjects.gsc
***********************************************/

#include script_6b221588ece2c4aa;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\weapons_shared;
#include scripts\mp_common\util;
#include scripts\weapons\weaponobjects;

#namespace weaponobjects;

autoexec __init__system__() {
  system::register(#"weaponobjects", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
  callback::on_start_gametype(&start_gametype);
}

start_gametype() {
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
}

on_player_spawned() {}