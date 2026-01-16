/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_icebreaker_scripted.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\draft;

#namespace mp_icebreaker_scripted;

autoexec __init__system__() {
  system::register(#"mp_icebreaker_scripted", &__init__, &__main__, undefined);
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

  if(!getdvarint(#"hash_14f8907ba73d8e4f", 1)) {
    return;
  }

  wait getdvarfloat(#"hash_68cf1e8e429452b0", 0);

  if(util::isfirstround()) {
    level thread scene::play(#"p8_fxanim_mp_icebreaker_ice_shelf_bundle", "Shot 2");
    level scene::play(#"p8_fxanim_mp_icebreaker_container_drop_bundle", "Shot 2");
    level thread scene::play(#"p8_fxanim_mp_icebreaker_container_drop_bundle", "Shot 3");
    return;
  }
}

function_2cdcf5c3() {
  if(!getdvarint(#"hash_14f8907ba73d8e4f", 1)) {
    return;
  }

  if(util::isfirstround()) {
    while(!draft::function_d255fb3e()) {
      waitframe(1);
    }

    wait getdvarfloat(#"hash_142927c6a6db817c", 0);
    level thread scene::play(#"p8_fxanim_mp_icebreaker_container_drop_bundle", "Shot 1");
    level thread scene::play(#"p8_fxanim_mp_icebreaker_ice_shelf_bundle", "Shot 1");
    return;
  }

  level thread scene::skipto_end(#"p8_fxanim_mp_icebreaker_container_drop_bundle");
  level thread scene::skipto_end(#"p8_fxanim_mp_icebreaker_ice_shelf_bundle");
}

init_devgui() {
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x48>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x87>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xc6>");
}

