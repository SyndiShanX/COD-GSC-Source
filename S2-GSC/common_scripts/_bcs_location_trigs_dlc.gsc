/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_bcs_location_trigs_dlc.gsc
******************************************************/

bcs_location_trigs_dlc_init() {
  if(isDefined(level._id_2A3D) && isDefined(anim.bcs_locations)) {
    return;
  }
  level.bcs_location_mappings = [];
  bcs_dlc_location_trigger_mapping();
  bcs_dlc_trigs_assign_aliases();
  level.bcs_location_mappings = undefined;
  anim._id_5E5E = [];
}

bcs_dlc_trigs_assign_aliases() {
  var_0 = getEntArray();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.classname) && issubstr(var_3.classname, "trigger_multiple_bcs"))
      var_1[var_1.size] = var_3;
  }

  foreach(var_3 in var_1) {
    if(!isDefined(level.bcs_location_mappings[var_3.classname])) {
      continue;
    }
    var_6 = parselocationaliases(level.bcs_location_mappings[var_3.classname]);

    if(var_6.size > 1)
      var_6 = common_scripts\utility::array_randomize(var_6);

    var_3._id_5E5C = var_6;
    anim.bcs_locations[anim.bcs_locations.size] = var_3;
  }

  anim.bcs_locations = var_1;
}

parselocationaliases(var_0) {
  var_1 = strtok(var_0, " ");
  return var_1;
}

add_bcs_location_mapping(var_0, var_1) {
  if(isDefined(level.bcs_location_mappings[var_0])) {
    var_2 = level.bcs_location_mappings[var_0];
    var_3 = parselocationaliases(var_2);
    var_4 = parselocationaliases(var_1);

    foreach(var_6 in var_4) {
      foreach(var_8 in var_3) {
        if(var_6 == var_8)
          return;
      }
    }

    var_2 = var_2 + (" " + var_1);
    level.bcs_location_mappings[var_0] = var_2;
    return;
  }

  level.bcs_location_mappings[var_0] = var_1;
}

bcs_dlc_location_trigger_mapping() {
  if(!common_scripts\utility::issp())
    mp_raid_dlc3();
}

mp_raid_dlc3() {
  add_bcs_location_mapping("trigger_multiple_bcs_dlc_mp_dlc3_command_bunker", "mp_dlc3_command_bunker");
  add_bcs_location_mapping("trigger_multiple_bcs_dlc_mp_dlc3_storage_bunker", "mp_dlc3_storage_bunker");
  add_bcs_location_mapping("trigger_multiple_bcs_dlc_mp_dlc3_camo_netting", "mp_dlc3_camo_netting");
  add_bcs_location_mapping("trigger_multiple_bcs_dlc_mp_dlc3_tanks", "mp_dlc3_tanks");
  add_bcs_location_mapping("trigger_multiple_bcs_dlc_mp_dlc3_fence", "mp_dlc3_fence");
  add_bcs_location_mapping("trigger_multiple_bcs_dlc_mp_dlc3_scaffold", "mp_dlc3_scaffold");
  add_bcs_location_mapping("trigger_multiple_bcs_dlc_mp_dlc3_aa_gun", "mp_dlc3_aa_gun");
  add_bcs_location_mapping("trigger_multiple_bcs_dlc_mp_dlc3_upstairs", "mp_dlc3_command_bunker");
  add_bcs_location_mapping("trigger_multiple_bcs_dlc_mp_dlc3_stairwell", "mp_dlc3_stairwell");
  add_bcs_location_mapping("trigger_multiple_bcs_dlc_mp_dlc3_courtyard", "mp_dlc3_courtyard");
  add_bcs_location_mapping("trigger_multiple_bcs_dlc_mp_dlc3_trenches", "mp_dlc3_trenches");
  add_bcs_location_mapping("trigger_multiple_bcs_dlc_mp_dlc3_munitions_storage", "mp_dlc3_munitions_storage");
  add_bcs_location_mapping("trigger_multiple_bcs_dlc_mp_dlc3_radio_room", "mp_dlc3_radio_room");
  add_bcs_location_mapping("trigger_multiple_bcs_dlc_mp_dlc3_vehicles", "mp_dlc3_vehicles");
}