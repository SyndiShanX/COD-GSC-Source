/******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: common_scripts\_bcs_location_trigs_dlc.gsc
******************************************************/

bcs_location_trigs_dlc_init() {
  if(isDefined(level.var_2A3D) && isDefined(level.var_1672)) {
    return;
  }

  level.var_166F = [];
  bcs_dlc_location_trigger_mapping();
  bcs_dlc_trigs_assign_aliases();
  level.var_166F = undefined;
  anim.var_5E5E = [];
}

bcs_dlc_trigs_assign_aliases() {
  var_00 = getEntArray();
  var_01 = [];
  foreach(var_03 in var_00) {
    if(isDefined(var_03.var_003A) && issubstr(var_03.var_003A, "trigger_multiple_bcs")) {
      var_01[var_01.size] = var_03;
    }
  }

  foreach(var_03 in var_01) {
    if(!isDefined(level.var_166F[var_03.var_003A])) {
      continue;
    }

    var_06 = func_6E89(level.var_166F[var_03.var_003A]);
    if(var_06.size > 1) {
      var_06 = common_scripts\utility::func_0F92(var_06);
    }

    var_03.var_5E5C = var_06;
    level.var_1672[level.var_1672.size] = var_03;
  }

  anim.var_1672 = var_01;
}

func_6E89(param_00) {
  var_01 = strtok(param_00, " ");
  return var_01;
}

func_0903(param_00, param_01) {
  if(isDefined(level.var_166F[param_00])) {
    var_02 = level.var_166F[param_00];
    var_03 = func_6E89(var_02);
    var_04 = func_6E89(param_01);
    foreach(var_06 in var_04) {
      foreach(var_08 in var_03) {
        if(var_06 == var_08) {
          return;
        }
      }
    }

    var_02 = var_02 + " " + param_01;
    level.var_166F[param_00] = var_02;
    return;
  }

  level.var_166F[param_00] = param_01;
}

bcs_dlc_location_trigger_mapping() {
  if(!common_scripts\utility::func_57D7()) {
    mp_raid_dlc3();
  }
}

mp_raid_dlc3() {
  func_0903("trigger_multiple_bcs_dlc_mp_dlc3_command_bunker", "mp_dlc3_command_bunker");
  func_0903("trigger_multiple_bcs_dlc_mp_dlc3_storage_bunker", "mp_dlc3_storage_bunker");
  func_0903("trigger_multiple_bcs_dlc_mp_dlc3_camo_netting", "mp_dlc3_camo_netting");
  func_0903("trigger_multiple_bcs_dlc_mp_dlc3_tanks", "mp_dlc3_tanks");
  func_0903("trigger_multiple_bcs_dlc_mp_dlc3_fence", "mp_dlc3_fence");
  func_0903("trigger_multiple_bcs_dlc_mp_dlc3_scaffold", "mp_dlc3_scaffold");
  func_0903("trigger_multiple_bcs_dlc_mp_dlc3_aa_gun", "mp_dlc3_aa_gun");
  func_0903("trigger_multiple_bcs_dlc_mp_dlc3_upstairs", "mp_dlc3_command_bunker");
  func_0903("trigger_multiple_bcs_dlc_mp_dlc3_stairwell", "mp_dlc3_stairwell");
  func_0903("trigger_multiple_bcs_dlc_mp_dlc3_courtyard", "mp_dlc3_courtyard");
  func_0903("trigger_multiple_bcs_dlc_mp_dlc3_trenches", "mp_dlc3_trenches");
  func_0903("trigger_multiple_bcs_dlc_mp_dlc3_munitions_storage", "mp_dlc3_munitions_storage");
  func_0903("trigger_multiple_bcs_dlc_mp_dlc3_radio_room", "mp_dlc3_radio_room");
  func_0903("trigger_multiple_bcs_dlc_mp_dlc3_vehicles", "mp_dlc3_vehicles");
}