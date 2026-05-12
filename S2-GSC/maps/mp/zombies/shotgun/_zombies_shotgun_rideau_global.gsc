/**********************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\shotgun\_zombies_shotgun_rideau_global.gsc
**********************************************************************/

run_rideau_supply_drop_comment() {
  var_00 = ["zmb_bp_wind_ride_ivecalledinairsupportourf", "zmb_bp_wind_ride_imcallinginmoresuppliesth", "zmb_bp_wind_ride_welldonecrewletsgetloaded"];
  var_01 = level.objectivescompleted - 1;
  if(var_01 < 0) {
    var_01 = 0;
  }

  if(var_01 >= var_00.size) {
    var_02 = var_00[var_00.size - 1];
  } else {
    var_02 = var_01[var_02];
  }

  if(dlg_played_on_hidden_character(["ride"], [var_02])) {
    return;
  }

  level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::play_global_vo(var_02, 1, 1);
}

run_rideau_bomber_comment() {
  var_00 = ["ride", "bata", "mount", "hunt"];
  var_01 = ["zmb_dlc3_gbl_ride_thatbomberisheadingtoward", "zmb_dlc3_gbl_bata_priorityzerostopthebomber", "zmb_dlc3_gbl_mount_makeeveryshotcount", "zmb_dlc3_gbl_hunt_focusyourfireonthebomber"];
  if(dlg_played_on_hidden_character(var_00, var_01)) {
    return;
  }

  level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::play_global_vo("zmb_dlc3_gbl_ride_thatbomberisheadingtoward", 1, 1);
}

run_rideau_defense_comment() {
  var_00 = ["ride", "bata"];
  var_01 = ["zmb_dlc3_gbl_ride_wewereabletogetoutofgerma", "zmb_dlc3_gbl_bata_soldierspostuparoundtheba"];
  if(dlg_played_on_hidden_character(var_00, var_01)) {
    return;
  }

  level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::play_global_vo("zmb_dlc3_gbl_ride_wewereabletogetoutofgerma", 1, 1);
}

run_rideau_escort_bomber_comment() {
  var_00 = ["ride", "bata", "hunt", "ride"];
  var_01 = ["zmb_bp_wind_ride_iwantthisblockageclearedo", "zmb_bp_wind_bata_thiscouldtakehourssirwedo", "zmb_bp_wind_hunt_wedonothavethetoolsbutour", "zmb_bp_wind_ride_clevergirl"];
  if(dlg_played_on_hidden_character(var_00, var_01)) {
    return;
  }

  level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::play_global_vo("zmb_bp_wind_ride_nobodytouchthatbomberwene", 1, 1);
}

run_rideau_zeppelin_comment() {
  var_00 = ["ride", "bata", "mount"];
  var_01 = ["zmb_bp_wind_ride_theyvegotairsupportwatchy", "zmb_bp_wind_bata_eyesonthesky", "zmb_bp_wind_mount_takecovertheycannothitwha"];
  if(dlg_played_on_hidden_character(var_00, var_01)) {
    return;
  }

  level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::play_global_vo("zmb_bp_wind_ride_theyvegotairsupportwatchy", 1, 1);
}

run_extermination_dialog() {
  maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::try_run_conversation(level.extermination_story, 1);
}

dlg_played_on_hidden_character(param_00, param_01) {
  if(maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::is_character_present_in_match(param_00)) {
    level thread maps\mp\zombies\shotgun\_zombies_shotgun_vo_util::random_valid_character_player(param_00, param_01);
    return 1;
  }

  return 0;
}