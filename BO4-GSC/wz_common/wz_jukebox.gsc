/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_jukebox.gsc
***********************************************/

#include scripts\core_common\player\player_stats;
#include scripts\mp_common\item_world;

#namespace wz_jukebox;

autoexec __init() {
  level.var_8b13d130 = (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isDefined(getgametypesetting(#"hash_6935c178012cf77e")) ? getgametypesetting(#"hash_6935c178012cf77e") : 0);
}

event_handler[level_init] main(eventstruct) {
  level thread function_2bf3c36e();
}

function_2bf3c36e() {
  dynents = getdynentarray("dynent_jukebox");

  if(level.var_8b13d130) {
    foreach(dynent in dynents) {
      dynent.onuse = &function_1f3a1c47;
    }

    return;
  }

  waitframe(1);

  foreach(dynent in dynents) {
    setdynentenabled(dynent, 0);
  }

  item_world::function_4de3ca98();

  foreach(dynent in dynents) {
    setdynentenabled(dynent, 0);
  }
}

function_1f3a1c47(activator, laststate, state) {
  if(isDefined(activator)) {
    if(!level.inprematchperiod && laststate === 0) {
      activator stats::function_d40764f3(#"activation_count_jukebox", 1);
    }
  }
}

event_handler[event_9673dc9a] function_3981d015(eventstruct) {
  if(isDefined(level.var_8b13d130) && !level.var_8b13d130) {
    if(eventstruct.ent.targetname === "dynent_jukebox") {
      setdynentenabled(eventstruct.ent, 0);
    }

    return;
  }

  if(eventstruct.ent.targetname === "dynent_jukebox") {
    if(eventstruct.state == 1) {
      eventstruct.ent thread function_d143760c();
    }

    if(eventstruct.state == 3) {
      eventstruct.ent thread function_b55a0a4();
    }
  }
}

function_d143760c() {
  wait 2;
  setdynentstate(self, 2);
}

function_b55a0a4() {
  wait 2;
  setdynentstate(self, 1);
}