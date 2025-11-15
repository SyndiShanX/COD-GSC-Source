/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_seaside.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\compass;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\mp\mp_seaside_fx;
#include scripts\mp\mp_seaside_sound;
#include scripts\mp_common\draft;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\load;
#include scripts\mp_common\util;

#namespace mp_seaside;

event_handler[level_init] main(eventstruct) {
  precache();
  level.var_7fd6bd44 = 1800;
  callback::on_game_playing(&on_game_playing);
  clientfield::register("world", "remove_blood_decals", 1, 1, "int");
  clientfield::register("vehicle", "hide_tank_rob", 1, 1, "int");
  mp_seaside_fx::main();
  mp_seaside_sound::main();

  init_devgui();

    load::main();
  compass::setupminimap("");
  level.cleandepositpoints = array((0, -1016, 711), (1120, 288, 712), (-499, -2437, 776), (-745, -1165, 776), (775, -2820, 725));
  tank_scene = struct::get("spawn_flavor_tanks", "targetname");

  if(isDefined(tank_scene) && isDefined(tank_scene.scene_ents)) {
    tank_scene.scene_ents[#"vehicle 1"] clientfield::set("hide_tank_rob", 1);
    tank_scene.scene_ents[#"vehicle 2"] clientfield::set("hide_tank_rob", 1);
    tank_scene.scene_ents[#"vehicle 3"] clientfield::set("hide_tank_rob", 1);
    tank_scene.scene_ents[#"vehicle 1"] notsolid();
    tank_scene.scene_ents[#"vehicle 2"] notsolid();
    tank_scene.scene_ents[#"vehicle 3"] notsolid();
  }
}

function

on_game_playing() {
  array::delete_all(getEntArray("sun_block", "targetname"));
  wait getdvarfloat(#"hash_205d729c5c415715", 0);

  if(util::isfirstround()) {
    if(!(isDefined(level.var_2a0adaaa) && level.var_2a0adaaa)) {
      level clientfield::set("remove_blood_decals", 1);
    }

    level thread scene::play(#"p8_fxanim_mp_seaside_pigeon_flock_bundle");

    if(getdvarint(#"hash_1ee1f013d124a26a", 1)) {
      level thread scene::play(#"p8_fxanim_mp_seaside_tanks_bundle", "Shot 2");
    }
  }
}

function_2cdcf5c3() {
  if(util::function_94a3be2()) {
    return;
  } else if(util::isfirstround()) {
    level scene::init(#"p8_fxanim_mp_seaside_pigeon_flock_bundle");

    if(getdvarint(#"hash_1ee1f013d124a26a", 1)) {
      while(!draft::function_d255fb3e()) {
        waitframe(1);
      }

      level thread scene::play(#"p8_fxanim_mp_seaside_tanks_bundle", "Shot 1");
    }

    return;
  }

  level scene::skipto_end(#"p8_fxanim_mp_seaside_pigeon_flock_bundle");

  if(getdvarint(#"hash_1ee1f013d124a26a", 1)) {
    level scene::skipto_end(#"p8_fxanim_mp_seaside_tanks_bundle");
  }
}

init_devgui() {
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x48>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x89>");
}

