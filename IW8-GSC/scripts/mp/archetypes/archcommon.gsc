/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\archetypes\archcommon.gsc
************************************************/

function init() {
  level.archetypes = [];
  level.archetypeids = [];

  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("mp/battleRigTable.csv", var0, 0);

    if(!isDefined(var1) || var1 == "") {
      break;
    }

    var1 = int(var1);
    var2 = tablelookupbyrow("mp/battleRigTable.csv", var0, 1);
    level.archetypes[var1] = var2;
    level.archetypeids[var2] = var1;
  }
}

function removearchetype(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var1 = undefined;

  switch (var0) {
    case "archetype_assault":
      var1 = &scripts\mp\archetypes\archassault::removearchetype;
      break;
    default:
      return;
  }

  if(isDefined(var1)) {
    self[[var1]]();
    return;
  }
}

function _allowbattleslide(var0) {
  if(var0) {
    scripts\mp\utility\perk::giveperk("specialty_battleslide");
    return;
  }

  self notify("battleslide_unset");
}

function getrigindexfromarchetyperef(var0) {
  if(!isDefined(var0) || var0 == "none") {
    return 0;
  }

  for(var1 = 0; var1 < level.archetypes.size; var1++) {
    if(level.archetypes[var1] == var0) {
      return var1;
    }
  }

  return 0;
}