/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_jungle2_alt_scripted.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\draft;

#namespace mp_jungle2_alt_scripted;

autoexec __init__system__() {
  system::register(#"mp_jungle2_scripted", &__init__, &__main__, undefined);
}

__init__() {
  clientfield::register("scriptmover", "spawn_flavor_napalm_rumble", 1, 1, "counter");
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
    level thread scene::add_scene_func(#"p8_fxanim_mp_jun_napalm_drop_bundle", &function_69a9563e, "Shot 2");
    level thread scene::play(#"p8_fxanim_mp_jun_napalm_drop_bundle", "Shot 2");

    foreach(scene in level.var_38bda94) {
      level thread scene::play(scene);
    }
  }
}

function_2cdcf5c3() {
  if(!getdvarint(#"hash_14f8907ba73d8e4f", 1)) {
    return;
  }

  level.var_38bda94 = array(#"p8_fxanim_mp_seaside_parrots_orange_flock_01_bundle", #"p8_fxanim_mp_seaside_parrots_orange_flock_02_bundle", #"p8_fxanim_mp_seaside_parrots_scarlet_flock_01_bundle", #"p8_fxanim_mp_seaside_parrots_scarlet_flock_02_bundle", #"p8_fxanim_mp_seaside_parrots_yellow_flock_01_bundle", #"p8_fxanim_mp_seaside_parrots_yellow_flock_02_bundle");

  if(util::isfirstround()) {
    foreach(scene in level.var_38bda94) {
      level thread scene::init(scene);
    }

    while(!draft::function_d255fb3e()) {
      waitframe(1);
    }

    level thread scene::play(#"p8_fxanim_mp_jun_napalm_drop_bundle", "Shot 1");
    return;
  }

  level thread scene::skipto_end(#"p8_fxanim_mp_jun_napalm_drop_bundle");

  foreach(scene in level.var_38bda94) {
    level thread scene::skipto_end(scene);
  }
}

function_69a9563e(a_ents) {
  while(isDefined(a_ents[#"prop 1"])) {
    a_ents[#"prop 1"] waittill(#"napalm_rumble", #"death");

    if(isDefined(a_ents[#"prop 1"])) {
      a_ents[#"prop 1"] clientfield::increment("spawn_flavor_napalm_rumble");
    }
  }
}

init_devgui() {
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x48>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x87>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xc6>");
}

