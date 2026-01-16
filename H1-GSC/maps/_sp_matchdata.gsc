/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_sp_matchdata.gsc
********************************/

init() {}

increment_kill(var_0, var_1) {
  var_0 = getweaponbasename(var_0);
  var_2 = self;
  var_3 = int(getspmatchdata("career", "kills_total")) + 1;
  setspmatchdata("career", "kills_total", var_3);
  set_weapon_data(var_0, "kills_total");
  var_4 = getspmatchdata("checkpoints", "kills_total") + 1;
  setspmatchdata("checkpoints", "kills_total", var_4);

  if(var_1) {
    var_5 = getspmatchdata("checkpoints", "headshots_total") + 1;
    setspmatchdata("checkpoints", "headshots_total", var_5);
    set_weapon_data(var_0, "headshots_total");
  }
}

shots_fired(var_0) {
  set_weapon_data(getweaponbasename(var_0), "shots_total");
  var_1 = getspmatchdata("checkpoints", "shots_total") + 1;
  setspmatchdata("checkpoints", "shots_total", var_1);
}

increment_hit(var_0) {
  set_weapon_data(getweaponbasename(var_0), "shots_hit");
  var_1 = getspmatchdata("checkpoints", "hits_total") + 1;
  setspmatchdata("checkpoints", "hits_total", var_1);
}

register_death(var_0, var_1) {
  if(isdefined(var_0)) {
    var_0 = getweaponbasename(var_0);

    if(!cause_is_explosive(var_1))
      set_weapon_data(var_0, "deaths_total");
  }

  var_2 = getspmatchdata("checkpoints", "deaths_total") + 1;
  setspmatchdata("checkpoints", "deaths_total", var_2);
  maps\_utility::save_time_played();
  var_3 = level.player getplayerdata(common_scripts\utility::getstatsgroup_sp(), "career", "deaths_total");

  if(isdefined(var_3))
    level.player setplayerdata(common_scripts\utility::getstatsgroup_sp(), "career", "deaths_total", var_3 + 1);
}

register_boost_jump() {
  var_0 = getspmatchdata("checkpoints", "boosted_total") + 1;
  setspmatchdata("checkpoints", "boosted_total", var_0);
}

register_boost_slam() {
  var_0 = getspmatchdata("checkpoints", "boosted_total") + 1;
  setspmatchdata("checkpoints", "boosted_total", var_0);
}

register_boost_dodge() {
  self endon("death");

  for (;;) {
    self waittill("exo_dodge");
    var_0 = getspmatchdata("checkpoints", "dodges_total") + 1;
    setspmatchdata("checkpoints", "boosted_total", var_0);
  }
}

register_sp_perks() {
  self endon("death");

  for (;;) {
    self waittill("give_perk", var_0);
    setspmatchdata("perks", var_0, 1);
  }
}

level_complete(var_0) {
  var_1 = level.player getsystemtimesp();
  setspmatchdata("timestamp_end", var_1);
  setspmatchdata("career", "level_completion_timestamp", var_0, var_1);
  setspmatchdata("career", "levels_completed", var_0, 1);
  var_2 = level.player getplayersetting("gameskill");
  var_3 = level.difficultytype[int(var_2)];
  setspmatchdata("final_difficulty", var_3);
  maps\_utility::save_time_played();
}

does_weapon_exist(var_0) {
  var_1 = ["ammo", "iw5_bal27_sp", "iw5_ak12_sp", "iw5_hbra3_sp", "iw5_himar_sp", "iw5_arx160_sp", "iw5_m182spr_sp", "iw5_sn6_sp", "iw5_hmr9_sp", "iw5_mp11_sp", "iw5_sac3_sp", "iw5_asm1_sp", "iw5_kf5_sp", "iw5_mors_sp", "iw5_gm6_sp", "iw5_thor_sp", "iw5_uts19_sp", "iw5_maul_sp", "iw5_rhino_sp", "iw5_lsat_sp", "iw5_asaw_sp", "iw5_em1_sp", "iw5_epm3_sp", "iw5_titan45_sp", "iw5_pbw_sp", "iw5_vbr_sp", "iw5_rw1_sp", "iw5_microdronelauncher_sp", "iw5_stingerm7_sp", "iw5_mahem_sp", "iw5_maaws_sp", "unknown", ""];
  return common_scripts\utility::array_contains(var_1, var_0);
}

set_weapon_data(var_0, var_1) {
  if(isdefined(var_0) && does_weapon_exist(var_0)) {
    var_2 = int(getspmatchdata("weapon_stats", var_0, var_1)) + 1;
    setspmatchdata("weapon_stats", var_0, var_1, var_2);
  } else {
    var_2 = int(getspmatchdata("weapon_stats", "unknown", var_1)) + 1;
    setspmatchdata("weapon_stats", "unknown", var_1, var_2);
  }
}

cause_is_explosive(var_0) {
  var_0 = tolower(var_0);

  switch (var_0) {
    case "splash":
    case "mod_explosive":
    case "mod_projectile_splash":
    case "mod_projectile":
    case "mod_grenade_splash":
    case "mod_grenade":
      return 1;
    default:
      return 0;
  }

  return 0;
}