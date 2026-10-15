/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\teams\teamset_axis.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\mp_common\teams\teamset;

#namespace teamset_axis;

autoexec __init__system__() {
  system::register(#"teamset_axis", &__init__, undefined, undefined);
}

__init__() {
  init(level.teams[#"axis"]);
  teamset::customteam_init();
}

init(team) {
  teamset::init();
  level.teamprefix[team] = "vox_pm";
  level.teampostfix[team] = "axis";
  game.music["spawn_" + team] = "SPAWN_PMC";
  game.music["spawn_short" + team] = "SPAWN_SHORT_PMC";
  game.music["victory_" + team] = "VICTORY_PMC";
  game.voice[team] = "vox_pmc_";
  game.flagmodels[team] = "p8_mp_flag_pole_1_mercs";
  game.carry_flagmodels[team] = "p8_mp_flag_carry_1_mercs";
  game.flagmodels[#"neutral"] = "p8_mp_flag_pole_1";
}