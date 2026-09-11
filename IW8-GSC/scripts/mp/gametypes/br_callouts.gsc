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

  var_0 = level.mapcorners[0].origin[0];
  var_1 = level.mapcorners[1].origin[0];
  var_2 = var_1 - var_0;
  var_3 = level.mapcorners[0].origin[1];
  var_4 = level.mapcorners[1].origin[1];
  var_5 = var_4 - var_3;

  for(var_6 = 0;; var_6++) {
    var_7 = tablelookupbyrow(level.calloutglobals.callouttable, var_6, 5);

    if(!isDefined(var_7) || var_7 == "") {
      break;
    }

    if(var_7 != "1") {
      continue;
    }

    var_8 = tablelookupbyrow(level.calloutglobals.callouttable, var_6, 6);
    var_8 = float(var_8);
    var_8 = var_8 * var_2 + var_0;
    var_9 = tablelookupbyrow(level.calloutglobals.callouttable, var_6, 7);
    var_9 = float(var_9);
    var_9 = var_9 * var_5 + var_3;
    var_10 = tablelookupbyrow(level.calloutglobals.callouttable, var_6, 8);
    var_10 = float(var_10);
    var_11 = tablelookupbyrow(level.calloutglobals.callouttable, var_6, 1);
    var_12 = spawnStruct();
    var_12.origin = (var_8, var_9, 0);
    var_12.radius = var_10;
    level.calloutglobals.ref_11e29[var_11] = var_12;
  }
}

function removeminigunrestrictions(var_0) {
  var_1 = "";

  foreach(var_3 in level.calloutglobals.ref_11e29) {
    if(distance2dsquared(var_0, var_3.origin) <= var_3.radius * var_3.radius) {
      var_1 = var_4;
      break;
    }
  }

  return var_1;
}

function removematchingents_bymodel(var_0) {
  var_1 = "none";
  var_2 = -1;
  var_3 = 144000000;

  if(!isDefined(var_0.calloutarea) || var_0.calloutarea == var_1) {
    return var_2;
  }

  var_4 = var_0.origin;
  var_5 = 0;
  var_6 = var_2;
  var_7 = var_3;

  foreach(var_9 in level.calloutglobals.ref_11e29) {
    var_10 = distance2dsquared(var_4, var_9.origin);

    if(var_10 <= var_7) {
      var_7 = var_10;
      var_6 = var_5;
    }

    var_5++;
  }

  return var_6;
}