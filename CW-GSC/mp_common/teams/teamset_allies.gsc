/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\teams\teamset_allies.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\mp_common\teams\teamset;
#namespace teamset_allies;

function private autoexec __init__system__() {
  system::register(#"teamset_allies", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init(#"none");

  foreach(team in level.teams) {
    if(team == # "axis") {
      continue;
    }

    init(team);
  }
}

function init(team) {
  teamset::init();
  game.music["spawn_" + team] = "SPAWN_ST6";
  game.music["spawn_short" + team] = "SPAWN_SHORT_ST6";
  game.music["victory_" + team] = "VICTORY_ST6";
  game.voice[team] = "vox_st6_";
}