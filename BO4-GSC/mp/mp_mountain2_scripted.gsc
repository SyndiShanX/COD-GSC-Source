/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_mountain2_scripted.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\draft;

#namespace mp_mountain2_scripted;

autoexec __init__system__() {
  system::register(#"mp_mountain2_scripted", &__init__, &__main__, undefined);
}

__init__() {
  callback::on_game_playing(&on_game_playing);
}

__main__() {

  init_devgui();

    level thread function_2cdcf5c3();
}

on_game_playing() {
  array::delete_all(getEntArray("sun_block", "targetname"));

  if(!getdvarint(#"hash_14f8907ba73d8e4f", 1)) {
    return;
  }

  exploder::stop_exploder("fxexp_blizzard");
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
    exploder::exploder("fxexp_blizzard");
    return;
  }

  if(math::cointoss()) {
    exploder::exploder("fxexp_blizzard");
  }
}

init_devgui() {
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x48>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x87>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xc6>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x105>");
}

