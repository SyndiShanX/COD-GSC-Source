/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\teams\teamset_allies.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\mp_common\teams\teamset;

#namespace teamset_allies;

autoexec __init__system__() {
  system::register(#"teamset_allies", &__init__, undefined, undefined);
}

__init__() {
  init("free");

  foreach(team in level.teams) {
    if(team == #"axis") {
      continue;
    }

    init(team);
  }

  teamset::customteam_init();
}

init(team) {
  teamset::init();
  level.teamprefix[team] = "vox_st";
  level.teampostfix[team] = "st6";
  game.music["spawn_" + team] = "SPAWN_ST6";
  game.music["spawn_short" + team] = "SPAWN_SHORT_ST6";
  game.music["victory_" + team] = "VICTORY_ST6";
  game.voice[team] = "vox_st6_";
  game.flagmodels[team] = "p8_mp_flag_pole_1_blackops";
  game.carry_flagmodels[team] = "p8_mp_flag_carry_1_blackops";
  game.flagmodels[#"neutral"] = "p8_mp_flag_pole_1";
}