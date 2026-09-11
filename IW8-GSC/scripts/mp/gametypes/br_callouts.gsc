/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_callouts.gsc
************************************************/

function init() {
  level.calloutglobals.calloutzones = getEntArray("location_volume", "targetname");
  level.calloutglobals.ref_11e29 = [];

  if(!tableexists(level.calloutglobals.callouttable)) {
    return;
  }

  var0 = level.mapcorners[0].origin[0];
  var1 = level.mapcorners[1].origin[0];
  var2 = var1 - var0;
  var3 = level.mapcorners[0].origin[1];
  var4 = level.mapcorners[1].origin[1];
  var5 = var4 - var3;

  for(var6 = 0;; var6++) {
    var7 = tablelookupbyrow(level.calloutglobals.callouttable, var6, 5);

    if(!isDefined(var7) || var7 == "") {
      break;
    }

    if(var7 != "1") {
      continue;
    }

    var8 = tablelookupbyrow(level.calloutglobals.callouttable, var6, 6);
    var8 = float(var8);
    var8 = var8 * var2 + var0;
    var9 = tablelookupbyrow(level.calloutglobals.callouttable, var6, 7);
    var9 = float(var9);
    var9 = var9 * var5 + var3;
    var10 = tablelookupbyrow(level.calloutglobals.callouttable, var6, 8);
    var10 = float(var10);
    var11 = tablelookupbyrow(level.calloutglobals.callouttable, var6, 1);
    var12 = spawnStruct();
    var12.origin = (var8, var9, 0);
    var12.radius = var10;
    level.calloutglobals.ref_11e29[var11] = var12;
  }
}

function removeminigunrestrictions(var0) {
  var1 = "";

  foreach(var3 in level.calloutglobals.ref_11e29) {
    if(distance2dsquared(var0, var3.origin) <= var3.radius * var3.radius) {
      var1 = var4;
      break;
    }
  }

  return var1;
}

function removematchingents_bymodel(var0) {
  var1 = "none";
  var2 = -1;
  var3 = 144000000;

  if(!isDefined(var0.calloutarea) || var0.calloutarea == var1) {
    return var2;
  }

  var4 = var0.origin;
  var5 = 0;
  var6 = var2;
  var7 = var3;

  foreach(var9 in level.calloutglobals.ref_11e29) {
    var10 = distance2dsquared(var4, var9.origin);

    if(var10 <= var7) {
      var7 = var10;
      var6 = var5;
    }

    var5++;
  }

  return var6;
}