/******************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\shotgun\_zombies_shotgun_rideau_global.gsc
******************************************************************************/

run_rideau_supply_drop_comment() {
  var_0 = ["zmb_bp_wind_ride_ivecalledinairsupportourf", "zmb_bp_wind_ride_imcallinginmoresuppliesth", "zmb_bp_wind_ride_welldonecrewletsgetloaded"];
  var_1 = level.objectivescompleted - 1;

  if(var_1 < 0)
    var_1 = 0;

  if(var_1 >= var_0.size)
    var_2 = var_0[var_0.size - 1];
  else
    var_2 = var_0[var_1];

  if(dlg_played_on_hidden_character(["ride"], [var_2])) {
    return;
  }
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::play_global_vo(var_2, 1.0, 1);
}

run_rideau_bomber_comment() {
  var_0 = ["ride", "bata", "mount", "hunt"];
  var_1 = ["zmb_dlc3_gbl_ride_thatbomberisheadingtoward", "zmb_dlc3_gbl_bata_priorityzerostopthebomber", "zmb_dlc3_gbl_mount_makeeveryshotcount", "zmb_dlc3_gbl_hunt_focusyourfireonthebomber"];

  if(dlg_played_on_hidden_character(var_0, var_1)) {
    return;
  }
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::play_global_vo("zmb_dlc3_gbl_ride_thatbomberisheadingtoward", 1.0, 1);
}

run_rideau_defense_comment() {
  var_0 = ["ride", "bata"];
  var_1 = ["zmb_dlc3_gbl_ride_wewereabletogetoutofgerma", "zmb_dlc3_gbl_bata_soldierspostuparoundtheba"];

  if(dlg_played_on_hidden_character(var_0, var_1)) {
    return;
  }
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::play_global_vo("zmb_dlc3_gbl_ride_wewereabletogetoutofgerma", 1.0, 1);
}

run_rideau_escort_bomber_comment() {
  var_0 = ["ride", "bata", "hunt", "ride"];
  var_1 = ["zmb_bp_wind_ride_iwantthisblockageclearedo", "zmb_bp_wind_bata_thiscouldtakehourssirwedo", "zmb_bp_wind_hunt_wedonothavethetoolsbutour", "zmb_bp_wind_ride_clevergirl"];

  if(dlg_played_on_hidden_character(var_0, var_1)) {
    return;
  }
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::play_global_vo("zmb_bp_wind_ride_nobodytouchthatbomberwene", 1.0, 1);
}

run_rideau_zeppelin_comment() {
  var_0 = ["ride", "bata", "mount"];
  var_1 = ["zmb_bp_wind_ride_theyvegotairsupportwatchy", "zmb_bp_wind_bata_eyesonthesky", "zmb_bp_wind_mount_takecovertheycannothitwha"];

  if(dlg_played_on_hidden_character(var_0, var_1)) {
    return;
  }
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::play_global_vo("zmb_bp_wind_ride_theyvegotairsupportwatchy", 1.0, 1);
}

run_extermination_dialog() {
  maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::try_run_conversation(level.extermination_story, 1);
}

dlg_played_on_hidden_character(var_0, var_1) {
  if(maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::is_character_present_in_match(var_0)) {
    level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::random_valid_character_player(var_0, var_1);
    return 1;
  }

  return 0;
}