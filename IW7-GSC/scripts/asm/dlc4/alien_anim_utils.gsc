/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\dlc4\alien_anim_utils.gsc
*************************************************/

_id_97C5() {
  if(isDefined(level._id_1BBA)) {
    return;
  }
  level._id_1BBA = spawnStruct();
  _id_97C8(level._id_1BBA);
  level._id_1BBA._id_A4E4 = 107.659;
  level._id_1BBA._id_1108C = 99.4488;
  level._id_1B74 = 1.05;
  level._id_1B73 = 900;
}

_id_97C8(var_0) {
  level._id_1BBA._id_A4E2 = 907.029;
  level._id_1BBA._id_A4E6 = 16.8476;
  level._id_1BBA._id_A4E7 = 0.111111;
  level._id_1BBA._id_A4E5 = [];
  level._id_1BBA._id_A4E5["jump_launch_up"] = [];
  level._id_1BBA._id_A4E5["jump_launch_level"] = [];
  level._id_1BBA._id_A4E5["jump_launch_down"] = [];
  level._id_1BBA._id_A4E5["jump_launch_up"][0] = (0.338726, 0, 0.940885);
  level._id_1BBA._id_A4E5["jump_launch_up"][1] = (0.688542, 0, 0.725196);
  level._id_1BBA._id_A4E5["jump_launch_up"][2] = (0.906517, 0, 0.422169);
  level._id_1BBA._id_A4E5["jump_launch_level"][0] = (0.248516, 0, 0.968628);
  level._id_1BBA._id_A4E5["jump_launch_level"][1] = (0.579155, 0, 0.815218);
  level._id_1BBA._id_A4E5["jump_launch_level"][2] = (0.906514, 0, 0.422177);
  level._id_1BBA._id_A4E5["jump_launch_down"][0] = (0.333125, 0, 0.942883);
  level._id_1BBA._id_A4E5["jump_launch_down"][1] = (0.518112, 0, 0.855313);
  level._id_1BBA._id_A4E5["jump_launch_down"][2] = (0.892489, 0, 0.451068);
  level._id_1BBA._id_93B2 = [];
  level._id_1BBA._id_93B2["jump_launch_up"] = [];
  level._id_1BBA._id_93B2["jump_launch_level"] = [];
  level._id_1BBA._id_93B2["jump_launch_down"] = [];
  level._id_1BBA._id_93B2["jump_launch_up"]["jump_land_up"] = 0;
  level._id_1BBA._id_93B2["jump_launch_up"]["jump_land_level"] = 1;
  level._id_1BBA._id_93B2["jump_launch_up"]["jump_land_down"] = 2;
  level._id_1BBA._id_93B2["jump_launch_level"]["jump_land_up"] = 3;
  level._id_1BBA._id_93B2["jump_launch_level"]["jump_land_level"] = 4;
  level._id_1BBA._id_93B2["jump_launch_level"]["jump_land_down"] = 5;
  level._id_1BBA._id_93B2["jump_launch_down"]["jump_land_up"] = 6;
  level._id_1BBA._id_93B2["jump_launch_down"]["jump_land_level"] = 7;
  level._id_1BBA._id_93B2["jump_launch_down"]["jump_land_down"] = 8;
  level._id_1BBA._id_93B2["jump_launch_up"]["jump_land_sidewall_high"] = 9;
  level._id_1BBA._id_93B2["jump_launch_level"]["jump_land_sidewall_high"] = 9;
  level._id_1BBA._id_93B2["jump_launch_down"]["jump_land_sidewall_high"] = 9;
  level._id_1BBA._id_93B2["jump_launch_up"]["jump_land_sidewall_low"] = 9;
  level._id_1BBA._id_93B2["jump_launch_level"]["jump_land_sidewall_low"] = 9;
  level._id_1BBA._id_93B2["jump_launch_down"]["jump_land_sidewall_low"] = 9;
}