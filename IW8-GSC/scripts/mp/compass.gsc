/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\compass.gsc
***********************************************/

function setupminimap(var0, var1, var2) {
  var3 = getdvarfloat("scr_RequiredMapAspectratio", 1);

  if(!isDefined(var1)) {
    var1 = var0;
  }

  var4 = [];
  var5 = getEntArray("minimap_corner", "targetname");

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && scripts\mp\utility\game::getgametype() != "war" && !scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
    if(level.localeid != "locale_6") {
      var4 = getcornersfromarray(var5, 1);

      if(var4.size != 2) {
        var4 = getcornersfromarray(var5, 0);
      }
    } else {
      var4 = [];
      var4 = spawn("script_origin", (-1040, 12288, -136));
      var4 = spawn("script_origin", (44016, -32768, -136));
    }

    if(scripts\mp\utility\game::getgametype() == "arm") {
      var0 = var0 + "_" + level.localeid;
      var1 = var1 + "_" + level.localeid;
    }
  } else if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death() || scripts\cp_mp\utility\game_utility::getmapname() == "mp_br_quarry") {
    var4 = [];
    var4 = spawn("script_origin", (-65536, 86016, 5400));
    var4 = spawn("script_origin", (81920, -61440, -2048));
  } else {
    var4 = getcornersfromarray(var5, 0);
  }

  if(var4.size != 2) {
    return;
  }

  var6 = (var4[0].origin[0], var4[0].origin[1], 0);
  var7 = (var4[1].origin[0], var4[1].origin[1], 0);
  var8 = var7 - var6;
  var9 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var10 = (0 - var9[1], var9[0], 0);

  if(vectordot(var8, var10) > 0) {
    jumpiffalse(vectordot(var8, var9) > 0) LOC_000001b6;
    var11 = var7;
    var12 = var6;
    goto LOC_000001d5;
  } else if(vectordot(var12, var11) > 0) {
    var13 = vecscale(var11, vectordot(var12, var11));
    var11 = var10 + var13;
    var12 = var11 - var13;
  } else {
    var11 = var12;
    var12 = var11;
  }

  if(var9 > 0) {
    var14 = vectordot(var11 - var12, var11);
    var15 = vectordot(var11 - var12, var12);
    var16 = var15 / var14;

    if(var16 < var9) {
      var17 = var9 / var16;
      var18 = vecscale(var12, var15 * (var17 - 1) * 0.5);
    } else {
      var17 = var18 / var11;
      var18 = vecscale(var11, var16 * (var17 - 1) * 0.5);
    }

    var14 += var18;
    var15 -= var18;
  }

  var12[0].origin = var14;
  var12[1].origin = var15;
  level.mapsize = vectordot(var14 - var15, var11);
  level.mapcorners = var12;
  level.mapcorners[0].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[1].origin - level.mapcorners[0].origin), (0, 0, 1));
  level.mapcorners[0] addyaw(45);
  level.mapcorners[1].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[0].origin - level.mapcorners[1].origin), (0, 0, 1));
  level.mapcorners[1] addyaw(45);

  if(!isDefined(var10) || var10 < 1) {
    var10 = 1;
  }

  setminimap(var8, var14[0], var14[1], var15[0], var15[1], var10, var9);
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