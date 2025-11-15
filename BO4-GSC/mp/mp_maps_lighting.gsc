/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_maps_lighting.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;

#namespace mp_maps_lighting;

autoexec __init__system__() {
  system::register(#"mp_maps_lighting", &__init__, undefined, undefined);
}

__init__() {
  callback::on_game_playing(&on_game_playing);
}

on_game_playing() {
  array::delete_all(getEntArray("sun_block", "targetname"));
}