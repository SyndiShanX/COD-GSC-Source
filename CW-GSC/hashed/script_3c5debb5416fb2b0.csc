/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3c5debb5416fb2b0.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace world_event_radio_tuning;

function private autoexec __init__system__() {
  system::register(#"hash_7811e7ce71e374d0", &preinit, undefined, undefined, undefined);
}

function preinit() {
  if(!zm_utility::is_survival()) {
    return;
  }

  if(is_true(getgametypesetting(#"hash_1e1a5ebefe2772ba"))) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_4e8a552c8b6dcbb2")) && !getdvarint(#"hash_730311c63805303a", 0)) {
    return;
  }

  util::register_system(#"musicunlock", &function_214fe607);
}

function function_214fe607(localclientnum, state, oldstate) {
  if(!isDefined(oldstate)) {
    return;
  }

  var_8c7054cc = undefined;

  switch (oldstate) {
    case # "unlocksrmus_01":
      var_8c7054cc = # "musictrack_sr_lullaby";
      break;
    case # "unlocksrmus_02":
      var_8c7054cc = # "musictrack_sr_theone";
      break;
    case # "unlocksrmus_03":
      var_8c7054cc = # "musictrack_sr_abra";
      break;
    case # "unlocksrmus_04":
      var_8c7054cc = # "musictrack_sr_brave";
      break;
    case # "unlocksrmus_05":
      var_8c7054cc = # "musictrack_sr_aminfil";
      break;
    case # "unlocksrmus_06":
      var_8c7054cc = # "musictrack_zm_silver_ee";
      break;
    case # "unlocksrmus_07":
      var_8c7054cc = # "musictrack_zm_gold_ee";
      break;
    case # "unlocksrmus_08":
      var_8c7054cc = # "musictrack_sr_generation";
      break;
    case # "unlocksrmus_09":
      var_8c7054cc = # "musictrack_sr_avogadro";
      break;
    case # "unlocksrmus_10":
      var_8c7054cc = # "musictrack_sr_frequency";
      break;
    case # "unlocksrmus_11":
      var_8c7054cc = # "musictrack_sr_boa";
      break;
    case # "unlocksrmus_12":
      var_8c7054cc = # "musictrack_sr_pareidolia";
      break;
    case # "unlocksrmus_13":
      var_8c7054cc = # "musictrack_sr_tribes";
      break;
  }

  if(isDefined(var_8c7054cc)) {
    function_2cca7b47(state, var_8c7054cc);
  }
}