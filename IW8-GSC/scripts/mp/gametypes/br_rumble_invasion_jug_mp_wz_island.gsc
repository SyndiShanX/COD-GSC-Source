/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_rumble_invasion_jug_mp_wz_island.gsc
************************************************************************/

function initstructs() {
  var0 = &ref_13933;
  [[var0]]("brRumbleInv_jugg_drops", (19556, 27562.3, 3940.68), undefined, undefined);
  [[var0]]("brRumbleInv_jugg_drops", (-6009.87, 18457.1, 1680), undefined, undefined);
  [[var0]]("brRumbleInv_jugg_drops", (-2146.96, -2778.33, 2462.89), undefined, undefined);
  [[var0]]("brRumbleInv_jugg_drops", (19753.3, -5970.53, 3927.01), undefined, undefined);
  [[var0]]("brRumbleInv_jugg_drops", (21252.9, 10646.2, 4736.93), undefined, undefined);
}

function ref_13933(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.targetname = var0;
  var4.origin = var1;
  var4.angles = var2;
  var4.script_parameters = var3;

  if(isDefined(var4.targetname)) {
    if(!isDefined(level.struct_class_names["targetname"][var4.targetname])) {
      level.struct_class_names["targetname"][var4.targetname] = [];
    }

    var5 = level.struct_class_names["targetname"][var4.targetname].size;
    level.struct_class_names["targetname"][var4.targetname][var5] = var4;
    return;
  }
}