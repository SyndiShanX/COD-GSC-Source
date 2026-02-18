/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\teams\teamset_multiteam.gsc
*************************************************/

#using scripts\mp_common\teams\teamset;
#namespace teamset_multiteam;

function main() {
  teamset::init();
  toggle = 0;

  foreach(team in level.teams) {
    if(toggle % 2) {
      init_axis(team);
    } else {
      init_allies(team);
    }

    toggle++;
  }
}

function init_allies(team) {
  game.music["spawn_" + team] = "SPAWN_ST6";
  game.music["spawn_short" + team] = "SPAWN_SHORT_ST6";
  game.music["victory_" + team] = "VICTORY_ST6";
  game.voice[team] = "vox_st6_";
}

function init_axis(team) {
  game.music["spawn_" + team] = "SPAWN_PMC";
  game.music["spawn_short" + team] = "SPAWN_SHORT_PMC";
  game.music["victory_" + team] = "VICTORY_PMC";
  game.voice[team] = "vox_pmc_";
}