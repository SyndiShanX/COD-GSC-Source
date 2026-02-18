/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\mp\weaponobjects.gsc
***********************************************/

#using script_6b221588ece2c4aa;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\mp_common\util;
#using scripts\weapons\weaponobjects;
#namespace weaponobjects;

function private autoexec __init__system__() {
  system::register(#"weaponobjects", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
  callback::on_start_gametype(&start_gametype);
}

function start_gametype() {
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
}

function on_player_spawned() {}