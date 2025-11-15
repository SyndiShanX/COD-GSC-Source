/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_gridlock.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\compass;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\util_shared;
#include scripts\mp\mp_gridlock_fx;
#include scripts\mp\mp_gridlock_sound;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\load;

#namespace mp_gridlock;

event_handler[level_init] main(eventstruct) {
  callback::on_game_playing(&on_game_playing);
  mp_gridlock_fx::main();
  mp_gridlock_sound::main();
  load::main();
  compass::setupminimap("");
  level.cleandepositpoints = array((138.5, -58.5, 60), (1904.5, 921.75, 8), (75, 1152, 0), (-1465.5, -1271, 8), (-106, -1500, 8));
  spawncollision("collision_clip_wall_128x128x10", "collider", (-957, -1170, 104), (0, 180, 0));
  spawncollision("collision_clip_wall_128x128x10", "collider", (-957, -1170, -24), (0, 180, 0));
  function_2cdcf5c3();
}

on_game_playing() {
  array::delete_all(getEntArray("sun_block", "targetname"));
  wait getdvarfloat(#"hash_205d729c5c415715", 0.3);

  if(util::isfirstround()) {
    exploder::exploder("fxexp_tanker_explosion");
  }
}

function_2cdcf5c3() {
  if(!util::isfirstround()) {
    exploder::stop_exploder("fxexp_tanker_explosion");
  }
}

init_devgui() {
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x48>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x89>");
}

