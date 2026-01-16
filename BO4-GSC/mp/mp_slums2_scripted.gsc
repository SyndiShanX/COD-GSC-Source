/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_slums2_scripted.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace mp_slums2_scripted;

autoexec __init__system__() {
  system::register(#"mp_slums2_scripted", &__init__, &__main__, undefined);
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
    level scene::add_scene_func(#"p8_fxanim_mp_slu_cop_car_explosion_bundle", &function_33022f5b, "play");
    level thread scene::play(#"p8_fxanim_mp_slu_cop_car_explosion_bundle");
    level thread scene::play(#"p8_fxanim_mp_slu_car_powerline_bundle");
  }
}

function_2cdcf5c3() {
  if(!getdvarint(#"hash_14f8907ba73d8e4f", 1)) {
    return;
  }

  if(!util::isfirstround()) {
    level thread scene::skipto_end(#"p8_fxanim_mp_slu_cop_car_explosion_bundle");
    level thread scene::skipto_end(#"p8_fxanim_mp_slu_car_powerline_bundle");
  }
}

function_33022f5b(a_ents) {
  if(isDefined(a_ents[#"prop 1"])) {
    physicsexplosionsphere(a_ents[#"prop 1"].origin, 512, 1, 1);
  }
}

init_devgui() {
  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x48>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x87>");
  adddebugcommand("<dev string:x38>" + mapname + "<dev string:xc6>");
}

