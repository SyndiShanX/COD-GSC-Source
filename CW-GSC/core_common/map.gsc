/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\map.gsc
***********************************************/

#namespace map;

function init() {
  get_script_bundle();
}

function get_script_bundle() {
  if(!isDefined(level.var_427d6976)) {
    level.var_427d6976 = function_2717b55f();
  }

  if(!isDefined(level.var_427d6976)) {
    level.var_179eaba8 = 1;
    level.var_427d6976 = {};
  } else {
    level.var_179eaba8 = 0;
  }

  return level.var_427d6976;
}

function is_default() {
  if(!isDefined(level.var_179eaba8)) {
    level.var_179eaba8 = 1;
  }

  return level.var_179eaba8;
}

function function_596f8772() {
  var_427d6976 = get_script_bundle();

  if(isDefined(var_427d6976.factionlist)) {
    factionlist = getscriptbundle(var_427d6976.factionlist);
  } else {
    switch (currentsessionmode()) {
      case 0:
        faction = # "factions_zm";
        break;
      case 1:
        faction = # "factions_mp";
        break;
      case 2:
        faction = # "factions_cp";
        break;
      case 3:
        faction = # "factions_wz";
        break;
    }

    factionlist = getscriptbundle(faction);
  }

  if(isDefined(factionlist.faction)) {
    return factionlist;
  }

  return undefined;
}