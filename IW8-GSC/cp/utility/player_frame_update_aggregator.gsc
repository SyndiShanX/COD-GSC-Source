/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\utility\player_frame_update_aggregator.gsc
*********************************************************/

init() {
  level.playerframeupdatecallbacks = [];
  level thread runupdates();
}

runupdates() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  for(;;) {
    foreach(var_1 in level.players) {
      foreach(var_3 in level.playerframeupdatecallbacks)
      var_1[[var_3]]();
    }

    waitframe();
  }
}

registerplayerframeupdatecallback(var_0) {
  level.playerframeupdatecallbacks[level.playerframeupdatecallbacks.size] = var_0;
}