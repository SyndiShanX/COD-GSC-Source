/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\archetypes\archcommon.gsc
***************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\archetypes\archassault;
#using scripts\mp\utility\perk;
#namespace archcommon;

function init() {
  level.archetypes = [];
  level.archetypeids = [];

  for(row = 0; true; row++) {
    index = tablelookupbyrow("mp/battleRigTable.csv", row, 0);

    if(!isDefined(index) || index == "") {
      break;
    }

    index = int(index);
    ref = tablelookupbyrow("mp/battleRigTable.csv", row, 1);
    assertex(isDefined("<dev string:x1c>"), "<dev string:x23>" + index + "<dev string:x33>");
    level.archetypes[index] = ref;
    level.archetypeids[ref] = index;
  }
}

function removearchetype(loadoutarchetype) {
  if(!isDefined(loadoutarchetype)) {
    return;
  }

  funcremove = undefined;

  switch (loadoutarchetype) {
    case #"hash_98ff6f21872f18e0":
      funcremove = &scripts\mp\archetypes\archassault::removearchetype;
      break;
    default:
      return;
  }

  if(isDefined(funcremove)) {
    self[[funcremove]]();
  }
}

function _allowbattleslide(allow) {
  if(allow) {
    giveperk("specialty_battleslide");
    return;
  }

  self notify("battleslide_unset");
}

function getrigindexfromarchetyperef(archetyperefstring) {
  if(!isDefined(archetyperefstring) || archetyperefstring == "none") {
    return 0;
  }

  for(rigindex = 0; rigindex < level.archetypes.size; rigindex++) {
    if(level.archetypes[rigindex] == archetyperefstring) {
      return rigindex;
    }
  }

  return 0;
}