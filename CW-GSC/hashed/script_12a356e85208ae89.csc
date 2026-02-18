/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_12a356e85208ae89.csc
***********************************************/

#using script_18910f59cc847b42;
#using script_30c7fb449869910;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_42cbbdcd1e160063;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace doa_wild;

function init() {
  clientfield::register("world", "setWild", 1, 2, "int", &setwild, 0, 0);
  clientfield::register("world", "setWildTOD", 1, 3, "int", &settod, 0, 0);
  clientfield::register("world", "setWildSection", 1, 3, "int", &setsection, 0, 0);
  clientfield::register("world", "wilddeactivated", 1, 1, "counter", &wilddeactivated, 0, 0);
  var_581c8f9a = struct::get_array("doa_wild");
  level.doa.var_581c8f9a = [];

  foreach(wild in var_581c8f9a) {
    var_f784a248 = spawnStruct();
    var_f784a248.name = wild.script_noteworthy;
    var_f784a248.id = int(wild.script_int);
    level.doa.var_581c8f9a[level.doa.var_581c8f9a.size] = var_f784a248;
  }

  function_32d5e898();
}

function function_32d5e898(localclientnum) {
  level.doa.var_47dcd1f = undefined;
  level.doa.var_f9d8fba5 = undefined;
  level.doa.var_7c19cda1 = undefined;

  if(isDefined(level.doa.var_e2a9584a)) {
    stopradiantexploder(localclientnum, level.doa.var_e2a9584a);
    level.doa.var_e2a9584a = undefined;
  }
}

function wilddeactivated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_32d5e898(bwastimejump);
}

function setwild(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.doa.var_47dcd1f = undefined;

  foreach(wild in level.doa.var_581c8f9a) {
    if(wild.id == bwastimejump) {
      level.doa.var_47dcd1f = wild;
      return;
    }
  }
}

function setsection(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.doa.var_f9d8fba5 = bwastimejump + 1;
}

function settod(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(level.doa.var_e2a9584a)) {
    stopradiantexploder(fieldname, level.doa.var_e2a9584a);
    level.doa.var_e2a9584a = undefined;
  }

  if(!isDefined(level.doa.var_47dcd1f)) {
    return;
  }

  level.doa.var_7c19cda1 = "morning";

  switch (bwastimejump) {
    case 0:
      level.doa.var_7c19cda1 = "morning";
      setworldfogactivebank(fieldname, 1);
      break;
    case 1:
      level.doa.var_7c19cda1 = "noon";
      setworldfogactivebank(fieldname, 2);
      break;
    case 2:
      level.doa.var_7c19cda1 = "dusk";
      setworldfogactivebank(fieldname, 4);
      break;
    case 3:
      level.doa.var_7c19cda1 = "night";
      setworldfogactivebank(fieldname, 8);
      break;
    default:
      level.doa.var_7c19cda1 = "morning";
      setworldfogactivebank(fieldname, 1);
      break;
  }

  namespace_1e25ad94::debugmsg("<dev string:x38>" + level.doa.var_47dcd1f.name + "<dev string:x41>" + level.doa.var_7c19cda1);

  level.doa.var_e2a9584a = "fxexp_" + level.doa.var_47dcd1f.name + "_section_" + level.doa.var_f9d8fba5 + "_" + level.doa.var_7c19cda1;

  namespace_1e25ad94::debugmsg("<dev string:x5b>" + level.doa.var_e2a9584a + "<dev string:x74>" + fieldname);

  playradiantexploder(fieldname, level.doa.var_e2a9584a);
}