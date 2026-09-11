/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\calloutmarkerping.gsc
***********************************************/

function setupminimap(var0, var1) {
  var2 = getdvarfloat("scr_RequiredMapAspectratio", 1);
  var3 = [];
  var4 = getEntArray("minimap_corner", "targetname");
  var3 = getcornersfromarray(var4, 0);

  if(var3.size != 2) {
    return;
  }

  var5 = (var3[0].origin[0], var3[0].origin[1], 0);
  var6 = (var3[1].origin[0], var3[1].origin[1], 0);
  var7 = var6 - var5;
  var8 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var9 = (0 - var8[1], var8[0], 0);

  if(vectordot(var7, var9) > 0) {
    jumpiffalse(vectordot(var7, var8) > 0) LOC_000000ad;
    var10 = var6;
    var11 = var5;
    goto LOC_000000cc;
  } else if(vectordot(var11, var10) > 0) {
    var12 = vecscale(var10, vectordot(var11, var10));
    var10 = var9 + var12;
    var11 = var10 - var12;
  } else {
    var10 = var11;
    var11 = var10;
  }

  if(var8 > 0) {
    var13 = vectordot(var10 - var11, var10);
    var14 = vectordot(var10 - var11, var11);
    var15 = var14 / var13;

    if(var15 < var8) {
      var16 = var8 / var15;
      var17 = vecscale(var11, var14 * (var16 - 1) * 0.5);
    } else {
      var16 = var17 / var10;
      var17 = vecscale(var10, var15 * (var16 - 1) * 0.5);
    }

    var13 += var17;
    var14 -= var17;
  }

  var11[0].origin = var13;
  var11[1].origin = var14;
  level.mapsize = vectordot(var13 - var14, var10);
  level.mapcorners = var11;
  level.mapcorners[0].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[1].origin - level.mapcorners[0].origin), (0, 0, 1));
  level.mapcorners[0] addyaw(45);
  level.mapcorners[1].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[0].origin - level.mapcorners[1].origin), (0, 0, 1));
  level.mapcorners[1] addyaw(45);

  if(!isDefined(var9) || var9 < 1) {
    var9 = 1;
  }

  setminimap(var8, var13[0], var13[1], var14[0], var14[1], var9);
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