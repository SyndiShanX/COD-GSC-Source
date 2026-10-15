/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\teams\teamset_multiteam.gsc
*************************************************/

#include scripts\mp_common\teams\teamset;

#namespace teamset_multiteam;

main() {
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

init_allies(team) {
  level.teamprefix[team] = "vox_st";
  level.teampostfix[team] = "st6";
  game.music["spawn_" + team] = "SPAWN_ST6";
  game.music["spawn_short" + team] = "SPAWN_SHORT_ST6";
  game.music["victory_" + team] = "VICTORY_ST6";
  game.voice[team] = "vox_st6_";
  game.flagmodels[team] = "mp_flag_allies_1";
  game.carry_flagmodels[team] = "mp_flag_allies_1_carry";
}

init_axis(team) {
  level.teamprefix[team] = "vox_pm";
  level.teampostfix[team] = "init_axis";
  game.music["spawn_" + team] = "SPAWN_PMC";
  game.music["spawn_short" + team] = "SPAWN_SHORT_PMC";
  game.music["victory_" + team] = "VICTORY_PMC";
  game.voice[team] = "vox_pmc_";
  game.flagmodels[team] = "mp_flag_axis_1";
  game.carry_flagmodels[team] = "mp_flag_axis_1_carry";
}