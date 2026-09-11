/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\compass.gsc
***********************************************/

function setupminimap(var0, var1, var2) {
  level.minimap_image = var0;

  if(!isDefined(var1)) {
    var1 = "minimap_corner";
  }

  var3 = getdvarfloat("scr_requiredMapAspectRatio", 1);
  var4 = getEntArray(var1, "targetname");

  if(var4.size != 2) {
    return;
  }

  var5 = (var4[0].origin[0], var4[0].origin[1], 0);
  var6 = (var4[1].origin[0], var4[1].origin[1], 0);
  var7 = var6 - var5;
  var8 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var9 = (0 - var8[1], var8[0], 0);

  if(vectordot(var7, var9) > 0) {
    jumpiffalse(vectordot(var7, var8) > 0) LOC_000000b0;
    var10 = var6;
    var11 = var5;
    goto LOC_000000cf;
  } else if(vectordot(var11, var10) > 0) {
    var12 = vecscale(var10, vectordot(var11, var10));
    var10 = var9 + var12;
    var11 = var10 - var12;
  } else {
    var10 = var11;
    var11 = var10;
  }

  if(var9 > 0) {
    var13 = vectordot(var10 - var11, var10);
    var14 = vectordot(var10 - var11, var11);
    var15 = var14 / var13;

    if(var15 < var9) {
      var16 = var9 / var15;
      var17 = vecscale(var11, var14 * (var16 - 1) * 0.5);
    } else {
      var16 = var17 / var11;
      var17 = vecscale(var10, var15 * (var16 - 1) * 0.5);
    }

    var13 += var17;
    var14 -= var17;
  }

  level.map_extents = [];
  level.map_extents["top"] = var13[1];
  level.map_extents["left"] = var14[0];
  level.map_extents["bottom"] = var14[1];
  level.map_extents["right"] = var13[0];
  level.map_width = level.map_extents["right"] - level.map_extents["left"];
  level.map_height = level.map_extents["top"] - level.map_extents["bottom"];
  level.mapsize = vectordot(var13 - var14, var10);

  if(!isDefined(var10) || var10 < 1) {
    var10 = 1;
  }

  setminimap(var8, var13[0], var13[1], var14[0], var14[1], var10);
}

function vecscale(var0, var1) {
  return (var0[0] * var1, var0[1] * var1, var0[2] * var1);
}