/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_asylum.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world;

#namespace wz_asylum;

autoexec __init__system__() {
  system::register(#"wz_asylum", &__init__, undefined, undefined);
}

autoexec __init() {
  level.var_7ad3f6a0 = (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isDefined(getgametypesetting(#"hash_6382d9dfeaeaa0f3")) ? getgametypesetting(#"hash_6382d9dfeaeaa0f3") : 0);
  level.var_afa44b2d = isDefined(getgametypesetting(#"hash_7d5d04df4914095e")) ? getgametypesetting(#"hash_7d5d04df4914095e") : 0;
}

__init__() {
  clientfield::register("world", "toilet_ee_play", 19000, 2, "int");
  level thread function_6e7c4665();
}

function_6e7c4665() {
  if(!level.var_7ad3f6a0) {
    var_8294540 = getdynentarray("asylum_toilet");
    item_world::function_1b11e73c();

    foreach(var_2eb2cfa9 in var_8294540) {
      setdynentstate(var_2eb2cfa9, 3);
    }

    item_world::function_4de3ca98();

    foreach(var_2eb2cfa9 in var_8294540) {
      setdynentstate(var_2eb2cfa9, 3);
    }
  }
}

private event_handler[event_9673dc9a] function_3981d015(eventstruct) {
  if(isDefined(level.var_7ad3f6a0) && !level.var_7ad3f6a0) {
    return;
  }

  if(isDefined(eventstruct.ent) && eventstruct.ent.targetname === "asylum_toilet") {
    if(eventstruct.state === 3) {
      wait 3;

      if(isDefined(eventstruct.ent.target)) {
        s_sound = struct::get(eventstruct.ent.target, "targetname");

        if(isDefined(s_sound)) {
          song = randomint(2);
          song++;

          if(!(isDefined(level.var_afa44b2d) && level.var_afa44b2d)) {
            song = 3;
          }

          level clientfield::set("toilet_ee_play", song);
        }
      }
    }
  }
}