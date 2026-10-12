/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\init.gsc
***********************************************/



#using scripts\stealth\manager;
#using scripts\stealth\player;
#using scripts\stealth\threat_sight;
#using scripts\stealth\utility;
#namespace init;

function main() {
  scripts\stealth\manager::main();
}

function set_stealth_mode(enabled, musichidden, musicspotted) {
  if(enabled) {
    if(isDefined(musichidden) && isDefined(musicspotted)) {
      level thread scripts\stealth\utility::stealth_music(musichidden, musicspotted);
    }

    level thread scripts\stealth\threat_sight::threat_sight_set_enabled(1);

    foreach(player in level.players) {
      player thread scripts\stealth\player::main();
    }
  } else {
    level thread scripts\stealth\utility::stealth_music_stop();
    level thread scripts\stealth\threat_sight::threat_sight_set_enabled(0);
  }

  if(isDefined(level.stealth.fnsetstealthmode)) {
    level thread[[level.stealth.fnsetstealthmode]](enabled, musichidden, musicspotted);
  }
}