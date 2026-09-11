/**************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_rumble_invasion_kiosk_mp_wz_island.gsc
**************************************************************************/

function initstructs() {
  var_0 = &ref_13933;
  [[var_0]]("brRumbleInv_kiosk_locations", (6990.54, 36829.3, 671), (0, 225.094, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (40632.5, 36642.5, 1280.9), (0, 200.11, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (-10367.5, -17387.2, 888), (0, 179.238, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (-27542.9, -14642.7, 1000.48), (0, 134.065, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (-16138.7, -3125.03, 488.72), (0, 86.4657, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (-2509.86, -22761.8, 2036.75), (0, 53.2804, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (-22477.6, -27009.8, 888), (0, 317.765, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (4458.05, -25668.2, 2509.55), (0, 242.921, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (1660.02, -7913.22, 1746.94), (0, 180.872, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (12920.1, 1138.77, 4712.11), (0, 22.9914, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (28412.1, 19956.6, 2335.9), (0, 172.002, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (40654.4, 21295.4, 1134.28), (0, 264.948, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (31351.7, 43256.4, 1671.69), (0, 48.4927, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (19316, 24730.4, 4508.99), (0, 323.353, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (17246.6, 45187.3, 416.141), (0, 225.857, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (-2507.8, 31210.5, 1042.92), (0, 179.488, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (1413.77, 12519.1, 5919.95), (0, 89.1203, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (-9871.38, 15381.2, 2008.01), (0, 270.404, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (-4920.59, 8617.12, 1370.06), (0, 44.0924, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (-979.573, 20030.3, 2980), (0, 359.734, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (21097.6, 10411.4, 4735.71), (0, 213.293, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (11934.6, 28250, 4584.21), (0, 181.772, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (33212.5, 32238.4, 2938.69), (0, 179.475, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (13021.7, 14660.2, 8864), (0, 186.487, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (17298.4, -5168.57, 3102.48), (0, 55.0393, 0), undefined);
  [[var_0]]("brRumbleInv_kiosk_locations", (10206.9, -11837.9, 1877), (0, 137.285, 0), undefined);
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