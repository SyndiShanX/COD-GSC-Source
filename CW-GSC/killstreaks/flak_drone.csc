/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\flak_drone.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#namespace flak_drone;

function init_shared() {
  if(!isDefined(level.var_5460023b)) {
    level.var_5460023b = {};
    clientfield::register("vehicle", "flak_drone_camo", 1, 3, "int", &active_camo_changed, 0, 0);
  }
}

function active_camo_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify(#"endtest");
  self thread doreveal(fieldname, bwastimejump != 0);
}

function doreveal(localclientnum, direction) {
  self notify(#"endtest");
  self endon(#"endtest");
  self endon(#"death");

  if(direction) {
    startval = 1;
  } else {
    startval = 0;
  }

  while(startval >= 0 && startval <= 1) {
    self mapshaderconstant(localclientnum, 0, "scriptVector0", startval, 0, 0, 0);

    if(direction) {
      startval -= 0.032;
    } else {
      startval += 0.032;
    }

    waitframe(1);
  }
}