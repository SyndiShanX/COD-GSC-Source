/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_seaside_alt.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\compass;
#include scripts\core_common\flag_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\util_shared;
#include scripts\mp\mp_seaside_alt_fx;
#include scripts\mp\mp_seaside_alt_sound;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\load;

#namespace mp_seaside_alt;

event_handler[level_init] main(eventstruct) {
  precache();
  callback::on_game_playing(&on_game_playing);
  mp_seaside_alt_fx::main();
  mp_seaside_alt_sound::main();

  init_devgui();

    load::main();
  compass::setupminimap("");
  level.cleandepositpoints = array((56, -1016, 711), (1120, 288, 712), (-499, -2437, 776), (775, -2820, 725));
  function_2cdcf5c3();
}

function

on_game_playing() {
  array::delete_all(getEntArray("sun_block", "targetname"));
  wait getdvarfloat(#"hash_205d729c5c415715", 0.3);

  if(util::isfirstround()) {
    if(getdvarint(#"hash_1ee1f013d124a26a", 0)) {
      level thread scene::play(#"p8_fxanim_mp_seaside_tanks_bundle");
    }
  }
}

function_2cdcf5c3() {
  if(util::isfirstround()) {
    if(getdvarint(#"hash_1ee1f013d124a26a", 0)) {
      level scene::init(#"p8_fxanim_mp_seaside_tanks_bundle");
    }

    return;
  }

  if(getdvarint(#"hash_1ee1f013d124a26a", 0)) {
    level scene::skipto_end(#"p8_fxanim_mp_seaside_tanks_bundle");
  }
}

init_devgui() {
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x48>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x89>");
}

