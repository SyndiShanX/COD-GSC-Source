/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_rumble_invasion_jug_mp_wz_island.gsc
****************************************************************/

initstructs() {
  var_0 = ::_id_13933;
  [[var_0]]("_encstr_8D58176A3ABE63B21558ED43E0DDD86A3D1F07F90CE5D8BBCB", (19556, 27562.3, 3940.68), undefined, undefined);
  [[var_0]]("_encstr_8D58176A3ABE63B21558ED43E0DDD86A3D1F07F90CE5D8BBCB", (-6009.87, 18457.1, 1680), undefined, undefined);
  [[var_0]]("_encstr_8D58176A3ABE63B21558ED43E0DDD86A3D1F07F90CE5D8BBCB", (-2146.96, -2778.33, 2462.89), undefined, undefined);
  [[var_0]]("_encstr_8D58176A3ABE63B21558ED43E0DDD86A3D1F07F90CE5D8BBCB", (19753.3, -5970.53, 3927.01), undefined, undefined);
  [[var_0]]("_encstr_8D58176A3ABE63B21558ED43E0DDD86A3D1F07F90CE5D8BBCB", (21252.9, 10646.2, 4736.93), undefined, undefined);
}

_id_13933(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.targetname = var_0;
  var_4.origin = var_1;
  var_4.angles = var_2;
  var_4.script_parameters = var_3;

  if(isDefined(var_4.targetname)) {
    if(!isDefined(level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_4.targetname]))
      level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_4.targetname] = [];

    var_5 = level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_4.targetname].size;
    level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_4.targetname][var_5] = var_4;
  }
}