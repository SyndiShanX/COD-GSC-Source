/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_buoy_stash.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world;

#namespace wz_buoy_stash;

autoexec __init__system__() {
  system::register(#"wz_buoy_stash", &__init__, &__main__, undefined);
}

autoexec __init() {
  level.var_f45d4bf5 = (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isDefined(getgametypesetting(#"hash_1f840366731cc3e")) ? getgametypesetting(#"hash_1f840366731cc3e") : 0);
}

__init__() {
  clientfield::register("scriptmover", "buoy_light_fx_changed", 1, 2, "int");
}

__main__() {
  level thread function_c621758a();
}

function_c621758a() {
  var_90b35a6a = struct::get_array("buoy_stash", "targetname");

  foreach(scene in var_90b35a6a) {
    wait randomint(4);
    scene thread scene::play(#"p8_fxanim_wz_floating_buoy_bundle");
  }

  if(!level.var_f45d4bf5) {
    var_3d8e32a8 = getdynent("dock_yard_stash_2");
    item_world::function_4de3ca98();

    if(isDefined(var_3d8e32a8)) {
      item_world::function_160294c7(var_3d8e32a8);
    }

    return;
  }

  item_world::function_4de3ca98();

  foreach(scene in var_90b35a6a) {
    var_3d8e32a8 = getdynent("dock_yard_stash_2");

    if(isDefined(var_3d8e32a8)) {
      var_e052e788 = distance2d(var_3d8e32a8.origin, scene.origin);

      if(var_e052e788 < 200) {
        scene.scene_ents[#"prop 1"] clientfield::set("buoy_light_fx_changed", 2);
        scene.scene_ents[#"prop 1"] function_5a6d95();
        continue;
      }

      scene.scene_ents[#"prop 1"] clientfield::set("buoy_light_fx_changed", 1);
    }
  }
}

function_5a6d95() {
  buoy_stash = getdynent("dock_yard_stash_2");
  var_63ee2ffd = 0;

  if(isDefined(buoy_stash)) {
    while(!var_63ee2ffd && isDefined(self)) {
      if(function_ffdbe8c2(buoy_stash) == 2) {
        var_63ee2ffd = 1;
        self clientfield::set("buoy_light_fx_changed", 1);
        break;
      }

      wait 1;
    }
  }
}