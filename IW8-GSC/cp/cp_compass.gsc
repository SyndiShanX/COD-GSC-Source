/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_compass.gsc
***********************************************/

setupminimap(var_0, var_1) {
  var_2 = getdvarfloat("_encstr_9B831B9BC64EF5A42B2EEA2DC9AC23A685C1146EC1596C8EE485A3D2B7", 1);
  var_3 = [];
  var_4 = getEntArray("_encstr_A6BC0F4183703022A7E3EFDE40DB48380B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_4.size < 1) {
    return;
  }
  var_3 = [var_4[0], var_4[1]];
  var_5 = getDvar("_encstr_9A050BF1B1D21107C3D5B601E0");

  switch (var_5) {
    case "_encstr_ABB40E5E9BB78D683307878123218F50":
      var_3[0].origin = (-65536, 86016, 0);
      var_3[1].origin = (81920, -61440, 0);
      break;
    case "_encstr_BE1D0DD8E07D46BB37F5E8BB73AFC8":
      var_3[0].origin = (44048, -32792, -152);
      var_3[1].origin = (-1008, 12264, -152);
      break;
    case "_encstr_86A90F8D07AF0B4EB6E67DC82B2C36AC39":
      var_3[0].origin = (-33792, 23552, 0);
      var_3[1].origin = (-2048, -8192, 0);
      break;
    case "_encstr_8A37107778166123D3B60F4797E96A3ABEF2":
      var_3[0].origin = (-49152, -24576, 0);
      var_3[1].origin = (16384, 40960, 0);
      break;
    case "_encstr_93580C1B837DB9DAAECED936B239":
      var_3[0].origin = (-24576, 65536, 0);
      var_3[1].origin = (45056, -4096, 0);
      break;
    case "_encstr_88E50E81C30E039F77AC67E0E78B6132":
      var_3[0].origin = (14336, 53248, 0);
      var_3[1].origin = (47104, 20480, 0);
      break;
    case "_encstr_AC850C5F503EB4CA3DD5F52DC6C1":
      var_3[0].origin = (4096, 24576, 0);
      var_3[1].origin = (49152, -20480, 0);
      break;
    case "_encstr_96250E8F105945B875F131AFB3CBAEB7":
      var_3[0].origin = (-12288, 72704, 0);
      var_3[1].origin = (32768, 27648, 0);
      break;
    case "_encstr_8B82108D07AF93585A237D6CB7D60E1B951E":
      var_6 = [var_4[0], var_4[1]];
      var_6[0].origin = (-2620, 8092, 0);
      var_6[1].origin = (3156, 3486, 0);
      _id_1325D("_encstr_965519C6EDB61C0BE6B97DAD580ED76C0EFAD4BACEECF5B558A756", var_6, var_2);
      var_3[0].origin = (-5508, 10395, 0);
      var_3[1].origin = (6044, 1183, 0);
      break;
  }

  var_7 = (var_3[0].origin[0], var_3[0].origin[1], 0);
  var_8 = (var_3[1].origin[0], var_3[1].origin[1], 0);
  var_9 = var_8 - var_7;
  var_10 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var_11 = (0 - var_10[1], var_10[0], 0);

  if(vectordot(var_9, var_11) > 0) {
    if(vectordot(var_9, var_10) > 0) {
      var_12 = var_8;
      var_13 = var_7;
    } else {
      var_14 = vecscale(var_10, vectordot(var_9, var_10));
      var_12 = var_8 - var_14;
      var_13 = var_7 + var_14;
    }
  } else if(vectordot(var_9, var_10) > 0) {
    var_14 = vecscale(var_10, vectordot(var_9, var_10));
    var_12 = var_7 + var_14;
    var_13 = var_8 - var_14;
  } else {
    var_12 = var_7;
    var_13 = var_8;
  }

  if(var_2 > 0) {
    var_15 = vectordot(var_12 - var_13, var_10);
    var_16 = vectordot(var_12 - var_13, var_11);
    var_17 = var_16 / var_15;

    if(var_17 < var_2) {
      var_18 = var_2 / var_17;
      var_19 = vecscale(var_11, var_16 * (var_18 - 1) * 0.5);
    } else {
      var_18 = var_17 / var_2;
      var_19 = vecscale(var_10, var_15 * (var_18 - 1) * 0.5);
    }

    var_12 = var_12 + var_19;
    var_13 = var_13 - var_19;
  }

  var_3[0].origin = var_12;
  var_3[1].origin = var_13;
  level.mapsize = vectordot(var_12 - var_13, var_10);
  level.mapcorners = var_3;
  level.mapcorners[0].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[1].origin - level.mapcorners[0].origin), (0, 0, 1));
  level.mapcorners[0] addyaw(45.0);
  level.mapcorners[1].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[0].origin - level.mapcorners[1].origin), (0, 0, 1));
  level.mapcorners[1] addyaw(45.0);

  if(!isDefined(var_1) || var_1 < 1)
    var_1 = 1;

  setminimap(var_0, var_12[0], var_12[1], var_13[0], var_13[1], var_1);
}

_id_1325D(var_0, var_1, var_2) {
  var_3 = (var_1[0].origin[0], var_1[0].origin[1], 0);
  var_4 = (var_1[1].origin[0], var_1[1].origin[1], 0);
  var_5 = var_4 - var_3;
  var_6 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var_7 = (0 - var_6[1], var_6[0], 0);

  if(vectordot(var_5, var_7) > 0) {
    if(vectordot(var_5, var_6) > 0) {
      var_8 = var_4;
      var_9 = var_3;
    } else {
      var_10 = vecscale(var_6, vectordot(var_5, var_6));
      var_8 = var_4 - var_10;
      var_9 = var_3 + var_10;
    }
  } else if(vectordot(var_5, var_6) > 0) {
    var_10 = vecscale(var_6, vectordot(var_5, var_6));
    var_8 = var_3 + var_10;
    var_9 = var_4 - var_10;
  } else {
    var_8 = var_3;
    var_9 = var_4;
  }

  if(var_2 > 0) {
    var_11 = vectordot(var_8 - var_9, var_6);
    var_12 = vectordot(var_8 - var_9, var_7);
    var_13 = var_12 / var_11;

    if(var_13 < var_2) {
      var_14 = var_2 / var_13;
      var_15 = vecscale(var_7, var_12 * (var_14 - 1) * 0.5);
    } else {
      var_14 = var_13 / var_2;
      var_15 = vecscale(var_6, var_11 * (var_14 - 1) * 0.5);
    }

    var_8 = var_8 + var_15;
    var_9 = var_9 - var_15;
  }

  brmatchstarted(var_0, var_8[0], var_8[1], var_9[0], var_9[1]);
}

vecscale(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}

getcornersfromarray(var_0, var_1) {
  var_2 = [];

  if(var_1) {
    foreach(var_4 in var_0) {
      if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == level.localeid)
        var_2[var_2.size] = var_4;
    }
  } else {
    foreach(var_4 in var_0) {
      if(!isDefined(var_4.script_noteworthy) || isDefined(var_4.script_noteworthy) && !issubstr(var_4.script_noteworthy, "_encstr_82E007C2104628C1CF"))
        var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}