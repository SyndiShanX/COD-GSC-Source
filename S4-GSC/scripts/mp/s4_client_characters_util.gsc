/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\s4_client_characters_util.gsc
****************************************************/

setup_client_characters(var_0, var_1) {
  if(!isDefined(level.clientcharacterarrays)) {
    level.clientcharacterarrays = [];
  }

  if(!isDefined(level.clientcharacterarrays[var_1])) {
    level.clientcharacterarrays[var_1] = [];
  }

  if(!isDefined(level.clientcharacterarrays[var_1][var_0])) {
    level.clientcharacterarrays[var_1][var_0] = [];
  }

  foreach(var_3 in level.clientcharacterarrays[var_1][var_0]) {
    var_3 delete();
  }

  level.clientcharacterarrays[var_1][var_0] = [];

  if(!isDefined(level._id_00E9)) {
    level._id_00E9 = [];
  }

  if(!isDefined(level._id_00E9[var_1])) {
    level._id_00E9[var_1] = [];
  }

  if(!isDefined(level._id_00E9[var_1][var_0])) {
    level._id_00E9[var_1][var_0] = -1;
  }

  level._id_00E9[var_1][var_0] = -1;
}

increment_client_character_num_for_team(var_0, var_1) {
  level._id_00E9[var_1][var_0]++;
}

get_client_character_num_for_team(var_0, var_1) {
  return level._id_00E9[var_1][var_0];
}