/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_rumble_invasion_aav_mp_wz_island.gsc
************************************************************************/

function initstructs() {
  var_0 = &ref_13933;
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (-29014, -15004, 998), (0, 0, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (-2112, -18483, 2099), (0, 0, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (42361, 27116, 1063), (0, 0, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (13568, 39834, 902), (0, 0, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (1580, 11424, 5911), (0, 0, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (12519, 21912, 6152), (0, 0, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (7207.38, -13799.7, 2048.99), (0, 176.286, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (-13831.8, -5713.76, 703.955), (0, -79.292, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (-13217.4, 15989.5, 2433.77), (0, -126.171, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (-5853.58, 31239.5, 861.014), (0, -38.5399, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (33548.4, 35298, 2721.76), (0, -148.331, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (-977.787, -2383.81, 2463.31), (0, 39.7689, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (40663.8, 36154.9, 1280.39), (0, -165.319, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (41240.2, 44447.2, 257.193), (0, -179.532, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (45037.3, 35908.5, 394.359), (0, -165.593, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (-18571.6, -15233.9, 887.559), (0, 45.8287, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (-10449.3, -15979.8, 888.014), (0, -0.873963, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (-25609.5, -26919.8, 886.905), (0, 134.716, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (-24840.8, -20052.5, 886.904), (0, 44.4286, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (20592.4, 24274.2, 4507.96), (0, -123.243, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (11914.2, -9497.97, 2023.56), (0, 129.366, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (-7760.79, 4303.05, 1018.39), (0, 42.6624, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (-5838.42, 16706.4, 1679.95), (0, -49.4464, 0), undefined);
  [[var_0]]("brRumbleInv_a_a_v_spawn_locations", (16711.6, 1509.36, 4142.12), (0, 73.8252, 0), undefined);
}

function ref_13933(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.targetname = var_0;
  var_4.origin = var_1;
  var_4.angles = var_2;
  var_4.script_parameters = var_3;

  if(isDefined(var_4.targetname)) {
    if(!isDefined(level.struct_class_names["targetname"][var_4.targetname])) {
      level.struct_class_names["targetname"][var_4.targetname] = [];
    }

    var_5 = level.struct_class_names["targetname"][var_4.targetname].size;
    level.struct_class_names["targetname"][var_4.targetname][var_5] = var_4;
    return;
  }
}