/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: stealth\init.gsc
***********************************************/

main() {
  scripts\stealth\manager::main();
}

set_stealth_mode(var_0, var_1, var_2) {
  if(var_0) {
    if(isDefined(var_1) && isDefined(var_2))
      level thread scripts\stealth\utility::stealth_music(var_1, var_2);

    level thread scripts\stealth\threat_sight::threat_sight_set_enabled(1);

    foreach(var_4 in level.players)
    var_4 thread scripts\stealth\player::main();
  } else {
    level thread scripts\stealth\utility::stealth_music_stop();
    level thread scripts\stealth\threat_sight::threat_sight_set_enabled(0);
  }

  if(isDefined(level.stealth.fnsetstealthmode))
    level thread[[level.stealth.fnsetstealthmode]](var_0, var_1, var_2);
}