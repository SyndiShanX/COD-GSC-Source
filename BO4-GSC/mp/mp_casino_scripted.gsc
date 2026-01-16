/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_casino_scripted.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\draft;
#include scripts\mp_common\util;

#namespace mp_casino_scripted;

autoexec __init__system__() {
  system::register(#"mp_casino_scripted", &__init__, &__main__, undefined);
}

__init__() {
  callback::on_game_playing(&on_game_playing);
}

__main__() {

  init_devgui();

    function_2cdcf5c3();
}

on_game_playing() {
  array::delete_all(getEntArray("sun_block", "targetname"));

  if(util::function_94a3be2()) {
    return;
  }

  wait getdvarfloat(#"hash_68cf1e8e429452b0", 0);

  if(util::isfirstround()) {
    array::run_all(getEntArray("spawn_flavor_veh", "script_noteworthy"), &show);
    level thread scene::skipto_end("p8_fxanim_mp_cas_swat_driveup_bundle");
    level util::delay(getdvarfloat(#"hash_187afb4d5f703a4a", 0.2), undefined, &scene::play, "p8_fxanim_mp_cas_helicopter_flyover_bundle", "Shot 2");
    return;
  }
}

function_2cdcf5c3() {
  if(util::function_94a3be2()) {
    return;
  }

  if(util::isfirstround()) {
    array::run_all(getEntArray("spawn_flavor_veh", "script_noteworthy"), &hide);

    while(!draft::function_d255fb3e()) {
      waitframe(1);
    }

    level thread scene::play("p8_fxanim_mp_cas_helicopter_flyover_bundle", "Shot 1");
    level thread scene::play("p8_fxanim_mp_cas_swat_driveup_bundle");
    return;
  }
}

init_devgui() {
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x48>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x87>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xc6>");
}

