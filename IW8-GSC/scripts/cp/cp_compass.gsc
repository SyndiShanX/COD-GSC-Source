/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_compass.gsc
***********************************************/

function setupminimap(var0, var1) {
  var2 = getdvarfloat("scr_RequiredMapAspectratio", 1);
  var3 = [];
  var4 = getEntArray("minimap_corner", "targetname");

  if(var4.size < 1) {
    return;
  }

  var3 = [var4[0], var4[1]];
  var5 = getDvar("NSQLTTMRMP");

  switch (var5) {
    case "cp_dntsk_raid":
      var3[0].origin = (-65536, 86016, 0);
      var3[1].origin = (81920, -61440, 0);
      break;
    case "cp_dwn_twn_2":
      var3[0].origin = (44048, -32792, -152);
      var3[1].origin = (-1008, 12264, -152);
      break;
    case "cp_arms_dealer":
      var3[0].origin = (-33792, 23552, 0);
      var3[1].origin = (-2048, -8192, 0);
      break;
    case "cp_armsdealer_2":
      var3[0].origin = (-49152, -24576, 0);
      var3[1].origin = (16384, 40960, 0);
      break;
    case "cp_smuggler":
      var3[0].origin = (-24576, 65536, 0);
      var3[1].origin = (45056, -4096, 0);
      break;
    case "cp_smuggler_2":
      var3[0].origin = (14336, 53248, 0);
      var3[1].origin = (47104, 20480, 0);
      break;
    case "cp_landlord":
      var3[0].origin = (4096, 24576, 0);
      var3[1].origin = (49152, -20480, 0);
      break;
    case "cp_landlord_2":
      var3[0].origin = (-12288, 72704, 0);
      var3[1].origin = (32768, 27648, 0);
      break;
    case "cp_raid_complex":
      var6 = [var4[0], var4[1]];
      var6[0].origin = (-2620, 8092, 0);
      var6[1].origin = (3156, 3486, 0);
      ref_1325d("compass_map_cp_jugg_maze", var6, var2);
      var3[0].origin = (-5508, 10395, 0);
      var3[1].origin = (6044, 1183, 0);
      break;
  }

  var7 = (var3[0].origin[0], var3[0].origin[1], 0);
  var8 = (var3[1].origin[0], var3[1].origin[1], 0);
  var9 = var8 - var7;
  var10 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var11 = (0 - var10[1], var10[0], 0);

  if(vectordot(var9, var11) > 0) {
    jumpiffalse(vectordot(var9, var10) > 0) LOC_00000320;
    var12 = var8;
    var13 = var7;
    goto LOC_0000033f;
  } else if(vectordot(var13, var12) > 0) {
    var14 = vecscale(var12, vectordot(var13, var12));
    var12 = var11 + var14;
    var13 = var12 - var14;
  } else {
    var12 = var13;
    var13 = var12;
  }

  if(var9 > 0) {
    var15 = vectordot(var12 - var13, var12);
    var16 = vectordot(var12 - var13, var13);
    var17 = var16 / var15;

    if(var17 < var9) {
      var18 = var9 / var17;
      var19 = vecscale(var13, var16 * (var18 - 1) * 0.5);
    } else {
      var18 = var19 / var11;
      var19 = vecscale(var12, var17 * (var18 - 1) * 0.5);
    }

    var15 += var19;
    var16 -= var19;
  }

  var12[0].origin = var15;
  var12[1].origin = var16;
  level.mapsize = vectordot(var15 - var16, var12);
  level.mapcorners = var12;
  level.mapcorners[0].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[1].origin - level.mapcorners[0].origin), (0, 0, 1));
  level.mapcorners[0] addyaw(45);
  level.mapcorners[1].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[0].origin - level.mapcorners[1].origin), (0, 0, 1));
  level.mapcorners[1] addyaw(45);

  if(!isDefined(var10) || var10 < 1) {
    var10 = 1;
  }

  setminimap(var9, var15[0], var15[1], var16[0], var16[1], var10);
}

function ref_1325d(var0, var1, var2) {
  var3 = (var1[0].origin[0], var1[0].origin[1], 0);
  var4 = (var1[1].origin[0], var1[1].origin[1], 0);
  var5 = var4 - var3;
  var6 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var7 = (0 - var6[1], var6[0], 0);

  if(vectordot(var5, var7) > 0) {
    jumpiffalse(vectordot(var5, var6) > 0) LOC_0000007e;
    var8 = var4;
    var9 = var3;
    goto LOC_0000009d;
  } else if(vectordot(var9, var8) > 0) {
    var10 = vecscale(var8, vectordot(var9, var8));
    var8 = var7 + var10;
    var9 = var8 - var10;
  } else {
    var8 = var9;
    var9 = var8;
  }

  if(var8 > 0) {
    var11 = vectordot(var8 - var9, var8);
    var12 = vectordot(var8 - var9, var9);
    var13 = var12 / var11;

    if(var13 < var8) {
      var14 = var8 / var13;
      var15 = vecscale(var9, var12 * (var14 - 1) * 0.5);
    } else {
      var14 = var15 / var8;
      var15 = vecscale(var8, var13 * (var14 - 1) * 0.5);
    }

    var11 += var15;
    var12 -= var15;
  }

  brmatchstarted(var8, var11[0], var11[1], var12[0], var12[1]);
}

function vecscale(var0, var1) {
  return (var0[0] * var1, var0[1] * var1, var0[2] * var1);
}

function getcornersfromarray(var0, var1) {
  var2 = [];
  jumpiffalse(var1) LOC_00000054;

  foreach(var4 in var0) {
    if(isDefined(var4.script_noteworthy) && var4.script_noteworthy == level.localeid) {
      var2 = var4;
    }
  }

  goto LOC_000000a8;
}