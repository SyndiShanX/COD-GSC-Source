/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\init.gsc
***********************************************/

main() {
  scripts\stealth\manager::main();
}

set_stealth_mode(enabled, _id_BD2621A5F467FE6C, _id_A1F4D479A8C138CD) {
  if(enabled) {
    if(isDefined(_id_BD2621A5F467FE6C) && isDefined(_id_A1F4D479A8C138CD))
      level thread scripts\stealth\utility::stealth_music(_id_BD2621A5F467FE6C, _id_A1F4D479A8C138CD);

    level thread scripts\stealth\threat_sight::threat_sight_set_enabled(1);

    foreach(player in level.players)
    player thread scripts\stealth\player::main();
  } else {
    level thread scripts\stealth\utility::stealth_music_stop();
    level thread scripts\stealth\threat_sight::threat_sight_set_enabled(0);
  }

  if(isDefined(level.stealth.fnsetstealthmode))
    level thread[[level.stealth.fnsetstealthmode]](enabled, _id_BD2621A5F467FE6C, _id_A1F4D479A8C138CD);
}