/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_array_broadcast.gsc
***********************************************/

#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\mp_common\item_world;

#namespace wz_array_broadcast;

autoexec __init__system__() {
  system::register(#"wz_array_broadcast", &__init__, undefined, undefined);
}

autoexec __init() {
  level.var_47f205b = (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isDefined(getgametypesetting(#"hash_24e281e778894ac9")) ? getgametypesetting(#"hash_24e281e778894ac9") : 0);
}

__init__() {
  level thread function_2bbffff9();
}

function_2bbffff9() {
  hidemiscmodels("array_tv_on");
  level.var_e46e7048 = 0;

  if(!level.var_47f205b) {
    var_8294540 = getdynentarray("array_broadcast");
    item_world::function_1b11e73c();

    foreach(var_2eb2cfa9 in var_8294540) {
      setdynentstate(var_2eb2cfa9, 3);
    }

    item_world::function_4de3ca98();

    foreach(var_2eb2cfa9 in var_8294540) {
      setdynentstate(var_2eb2cfa9, 3);
    }

    return;
  }

  var_8294540 = getdynentarray("array_broadcast");

  foreach(var_2eb2cfa9 in var_8294540) {
    var_2eb2cfa9.onuse = &function_1e224132;
  }
}

function_1e224132(activator, laststate, state) {
  if(level.var_e46e7048 === 0 && isplayer(activator)) {
    activator stats::function_d40764f3(#"activation_count_broadcast", 1);
  }
}

event_handler[event_9673dc9a] function_3981d015(eventstruct) {
  if(isDefined(level.var_47f205b) && !level.var_47f205b) {
    return;
  }

  if(eventstruct.ent.targetname === "array_broadcast") {
    if(eventstruct.state === 1 && !level.var_e46e7048) {
      level.var_e46e7048 = 1;
      showmiscmodels("array_tv_on");
      hidemiscmodels("array_tv_off");
    }
  }
}