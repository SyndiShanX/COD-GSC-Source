/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\stealth\init.gsc
***********************************************/

#using scripts\core_common\stealth\manager;
#using scripts\core_common\stealth\player;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#namespace stealth_init;

function main() {
  stealth_manager::function_f9682fd();
}

function set_stealth_mode(enabled, musichidden, musicspotted) {
  if(enabled) {
    if(isDefined(musichidden) && isDefined(musicspotted)) {
      level thread namespace_979752dc::stealth_music(musichidden, musicspotted);
    }

    level thread stealth_threat_sight::threat_sight_set_enabled(1);

    foreach(player in getplayers()) {
      player thread stealth_player::main();
    }

    setsaveddvar(#"hash_3e8c4724c1db5fe7", 0);
  } else {
    level thread namespace_979752dc::stealth_music_stop();
    level thread stealth_threat_sight::threat_sight_set_enabled(0);
    setsaveddvar(#"hash_3e8c4724c1db5fe7", 1);
  }

  if(isDefined(level.stealth.fnsetstealthmode)) {
    level thread[[level.stealth.fnsetstealthmode]](enabled, musichidden, musicspotted);
  }
}