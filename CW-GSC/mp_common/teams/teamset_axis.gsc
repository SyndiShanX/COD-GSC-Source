/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\teams\teamset_axis.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\mp_common\teams\teamset;
#namespace teamset_axis;

function private autoexec __init__system__() {
  system::register(#"teamset_axis", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!isDefined(level.teams[#"axis"])) {
    return;
  }

  init(level.teams[#"axis"]);
}

function init(team) {
  teamset::init();
  game.music["spawn_" + team] = "SPAWN_PMC";
  game.music["spawn_short" + team] = "SPAWN_SHORT_PMC";
  game.music["victory_" + team] = "VICTORY_PMC";
  game.voice[team] = "vox_pmc_";
}