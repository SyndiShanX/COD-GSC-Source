/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\init.gsc
***********************************************/

function main() {
  scripts\stealth\manager::main();
}

function set_stealth_mode(var0, var1, var2) {
  if(var0) {
    if(isDefined(var1) && isDefined(var2)) {
      level thread scripts\stealth\utility::stealth_music(var1, var2);
    }

    level thread scripts\stealth\threat_sight::threat_sight_set_enabled(1);

    foreach(var4 in level.players) {
      var4 thread scripts\stealth\player::main();
    }
  } else {
    level thread scripts\stealth\utility::stealth_music_stop();
    level thread scripts\stealth\threat_sight::threat_sight_set_enabled(0);
  }

  if(isDefined(level.stealth.fnsetstealthmode)) {
    level thread[[level.stealth.fnsetstealthmode]](var0, var1, var2);
    return;
  }
}