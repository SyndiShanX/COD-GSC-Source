/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_madagascar.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\compass;
#include scripts\core_common\flag_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\mp\mp_madagascar_fx;
#include scripts\mp\mp_madagascar_sound;
#include scripts\mp_common\load;
#include scripts\mp_common\util;

#namespace mp_madagascar;

event_handler[level_init] main(eventstruct) {
  mp_madagascar_fx::main();
  mp_madagascar_sound::main();
  setdvar(#"hash_3910a4196fe6b62e", 0);
  load::main();
  compass::setupminimap("");
  level.cleandepositpoints = array((1628.25, -356.25, 16), (1635, 2070, 187), (-1884.25, -156.75, -86.5), (463.25, 386.25, 196));
  callback::on_game_playing(&on_game_playing);
  level thread function_2cdcf5c3();
}

function_2cdcf5c3() {
  if(util::isfirstround()) {
    level thread scene::play("p8_fxanim_mp_mad_lemurs_01_bundle", "idle");
  }
}

on_game_playing() {
  array::delete_all(getEntArray("sun_block", "targetname"));
  level flag::wait_till("first_player_spawned");
  wait getdvarfloat(#"hash_205d729c5c415715", 0);

  if(util::isfirstround()) {
    level thread scene::play("p8_fxanim_mp_mad_lemurs_01_bundle", "run");
    level thread scene::play("p8_fxanim_mp_mad_heli_aid_bundle");
    util::delay(7, undefined, &scene::stop, "p8_fxanim_mp_mad_lemurs_01_bundle", 1);
    util::delay(12, undefined, &scene::stop, "p8_fxanim_mp_mad_heli_aid_bundle", 1);
  }
}