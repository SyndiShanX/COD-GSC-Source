/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\dlc4\alien_anim_utils.gsc
*************************************************/

func_97C5() {
  if(isDefined(level.var_1BBA)) {
    return;
  }

  level.var_1BBA = spawnStruct();
  func_97C8(level.var_1BBA);
  level.var_1BBA.var_A4E4 = 107.659;
  level.var_1BBA.var_1108C = 99.4488;
  level.var_1B74 = 1.05;
  level.var_1B73 = 900;
}

func_97C8(var_0) {
  level.var_1BBA.var_A4E2 = 907.0294;
  level.var_1BBA.var_A4E6 = 16.8476;
  level.var_1BBA.var_A4E7 = 0.111111;
  level.var_1BBA.var_A4E5 = [];
  level.var_1BBA.var_A4E5["jump_launch_up"] = [];
  level.var_1BBA.var_A4E5["jump_launch_level"] = [];
  level.var_1BBA.var_A4E5["jump_launch_down"] = [];
  level.var_1BBA.var_A4E5["jump_launch_up"][0] = (0.338726, 0, 0.940885);
  level.var_1BBA.var_A4E5["jump_launch_up"][1] = (0.688542, 0, 0.725196);
  level.var_1BBA.var_A4E5["jump_launch_up"][2] = (0.906517, 0, 0.422169);
  level.var_1BBA.var_A4E5["jump_launch_level"][0] = (0.248516, 0, 0.968628);
  level.var_1BBA.var_A4E5["jump_launch_level"][1] = (0.579155, 0, 0.815218);
  level.var_1BBA.var_A4E5["jump_launch_level"][2] = (0.906514, 0, 0.422177);
  level.var_1BBA.var_A4E5["jump_launch_down"][0] = (0.333125, 0, 0.942883);
  level.var_1BBA.var_A4E5["jump_launch_down"][1] = (0.518112, 0, 0.855313);
  level.var_1BBA.var_A4E5["jump_launch_down"][2] = (0.892489, 0, 0.451068);
  level.var_1BBA.var_93B2 = [];
  level.var_1BBA.var_93B2["jump_launch_up"] = [];
  level.var_1BBA.var_93B2["jump_launch_level"] = [];
  level.var_1BBA.var_93B2["jump_launch_down"] = [];
  level.var_1BBA.var_93B2["jump_launch_up"]["jump_land_up"] = 0;
  level.var_1BBA.var_93B2["jump_launch_up"]["jump_land_level"] = 1;
  level.var_1BBA.var_93B2["jump_launch_up"]["jump_land_down"] = 2;
  level.var_1BBA.var_93B2["jump_launch_level"]["jump_land_up"] = 3;
  level.var_1BBA.var_93B2["jump_launch_level"]["jump_land_level"] = 4;
  level.var_1BBA.var_93B2["jump_launch_level"]["jump_land_down"] = 5;
  level.var_1BBA.var_93B2["jump_launch_down"]["jump_land_up"] = 6;
  level.var_1BBA.var_93B2["jump_launch_down"]["jump_land_level"] = 7;
  level.var_1BBA.var_93B2["jump_launch_down"]["jump_land_down"] = 8;
  level.var_1BBA.var_93B2["jump_launch_up"]["jump_land_sidewall_high"] = 9;
  level.var_1BBA.var_93B2["jump_launch_level"]["jump_land_sidewall_high"] = 9;
  level.var_1BBA.var_93B2["jump_launch_down"]["jump_land_sidewall_high"] = 9;
  level.var_1BBA.var_93B2["jump_launch_up"]["jump_land_sidewall_low"] = 9;
  level.var_1BBA.var_93B2["jump_launch_level"]["jump_land_sidewall_low"] = 9;
  level.var_1BBA.var_93B2["jump_launch_down"]["jump_land_sidewall_low"] = 9;
}