/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_rumble_invasion_jug_mp_wz_island.gsc
************************************************************************/

function initstructs() {
  var_0 = &ref_13933;
  [[var_0]]("brRumbleInv_jugg_drops", (19556, 27562.3, 3940.68), undefined, undefined);
  [[var_0]]("brRumbleInv_jugg_drops", (-6009.87, 18457.1, 1680), undefined, undefined);
  [[var_0]]("brRumbleInv_jugg_drops", (-2146.96, -2778.33, 2462.89), undefined, undefined);
  [[var_0]]("brRumbleInv_jugg_drops", (19753.3, -5970.53, 3927.01), undefined, undefined);
  [[var_0]]("brRumbleInv_jugg_drops", (21252.9, 10646.2, 4736.93), undefined, undefined);
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