/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\archetypes\archcommon.gsc
************************************************/

function init() {
  level.archetypes = [];
  level.archetypeids = [];

  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("mp/battleRigTable.csv", var_0, 0);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_1 = int(var_1);
    var_2 = tablelookupbyrow("mp/battleRigTable.csv", var_0, 1);
    level.archetypes[var_1] = var_2;
    level.archetypeids[var_2] = var_1;
  }
}

function removearchetype(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = undefined;

  switch (var_0) {
    case "archetype_assault":
      var_1 = &scripts\mp\archetypes\archassault::removearchetype;
      break;
    default:
      return;
  }

  if(isDefined(var_1)) {
    self[[var_1]]();
    return;
  }
}

function _allowbattleslide(var_0) {
  if(var_0) {
    scripts\mp\utility\perk::giveperk("specialty_battleslide");
    return;
  }

  self notify("battleslide_unset");
}

function getrigindexfromarchetyperef(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return 0;
  }

  for(var_1 = 0; var_1 < level.archetypes.size; var_1++) {
    if(level.archetypes[var_1] == var_0) {
      return var_1;
    }
  }

  return 0;
}