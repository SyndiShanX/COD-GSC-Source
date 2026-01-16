/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_station.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\compass;
#include scripts\core_common\doors_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\draft;
#include scripts\mp_common\load;
#include scripts\mp_common\util;

#namespace mp_station;

event_handler[level_init] main(eventstruct) {
  load::main();
  compass::setupminimap("");
  level.cleandepositpoints = array((-144, -1706, 176), (-2652, 782, -23), (1496, -624, 200), (-1518, -1132, -16), (1992, 496, 32));
  callback::on_game_playing(&on_game_playing);
  level thread function_2cdcf5c3();
}

function_2cdcf5c3() {
  if(util::isfirstround()) {
    while(!draft::function_d255fb3e()) {
      waitframe(1);
    }

    level thread scene::play("p8_fxanim_sta_helicopter_flyover_bundle", "Shot 1");
  }
}

on_game_playing() {
  array::delete_all(getEntArray("sun_block", "targetname"));
  wait getdvarfloat(#"hash_205d729c5c415715", 0.3);
  scene::add_scene_func(#"p8_fxanim_sta_runaway_vehicles_bundle", &function_8efe95d4, "play");
  scene::add_scene_func(#"p8_fxanim_sta_runaway_truck_wall_bundle", &function_8efe95d4, "play");

  if(util::isfirstround()) {
    level util::delay(getdvarfloat(#"hash_187afb4d5f703a4a", 0.2), undefined, &scene::play, "p8_fxanim_sta_helicopter_flyover_bundle", "Shot 2");
    level util::delay(getdvarfloat(#"hash_395638c05b097129", 0.2), undefined, &scene::play, #"p8_fxanim_sta_runaway_vehicles_bundle");
    level util::delay(getdvarfloat(#"hash_395638c05b097129", 0.2), undefined, &scene::play, #"p8_fxanim_sta_runaway_truck_wall_bundle");
    return;
  }

  level scene::skipto_end(#"p8_fxanim_sta_runaway_vehicles_bundle");
  level scene::skipto_end(#"p8_fxanim_sta_runaway_truck_wall_bundle");
}

function_8efe95d4(a_ents) {
  if(isDefined(a_ents)) {
    array::wait_any(a_ents, "death");
    array::delete_all(a_ents);
  }
}