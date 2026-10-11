/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_13865ca76df87ea.gsc
************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_4f3742cd39063b9;

function genericblueprint_getweaponname(blueprintname, weaponkey) {
  var_5a0f9e1af605f0f5 = function_98442f5bef361b2b("genericblueprint", blueprintname);

  if(!isDefined(var_5a0f9e1af605f0f5)) {
    errortext = "<dev string:x1c>" + blueprintname + "<dev string:x42>";
    iprintln(errortext);

    return undefined;
  }

  foreach(entry in var_5a0f9e1af605f0f5.weaponlist) {
    if(entry.key == weaponkey) {
      if(entry.weapon == "") {
        return undefined;
      }

      return entry.weapon;
    }
  }

  errortext = "<dev string:x44>" + weaponkey + "<dev string:x64>" + blueprintname + "<dev string:x42>";
  iprintln(errortext);

  return undefined;
}

function function_b9ff4b6230995332(blueprintname, weaponkey) {
  var_5a0f9e1af605f0f5 = function_98442f5bef361b2b("genericblueprint", blueprintname);

  if(!isDefined(var_5a0f9e1af605f0f5)) {
    errortext = "<dev string:x1c>" + blueprintname + "<dev string:x42>";
    iprintln(errortext);

    return undefined;
  }

  foreach(entry in var_5a0f9e1af605f0f5.weaponlist) {
    if(entry.key == weaponkey) {
      if(entry.weaponblueprint == "") {
        return undefined;
      }

      return entry.weaponblueprint;
    }
  }

  errortext = "<dev string:x44>" + weaponkey + "<dev string:x64>" + blueprintname + "<dev string:x42>";
  iprintln(errortext);

  return undefined;
}

function getassetlist(bundle, assettype) {
  switch (assettype) {
    case #"hash_769eb8a21188fc4":
      return bundle.xmodellist;
    case #"hash_2ac140ce3b5ea398":
      return bundle.stringlist;
    case #"hash_2b36138a33884fe0":
      return bundle.suitlist;
    case #"hash_bfc3667f5f819e35":
      return bundle.executionlist;
    default:

      errortext = "<dev string:x81>";
      iprintln(errortext);

      return undefined;
  }
}

function function_29e16a88682086b2(blueprintname, assettype, key) {
  var_5a0f9e1af605f0f5 = function_98442f5bef361b2b("genericblueprint", blueprintname);

  if(!isDefined(var_5a0f9e1af605f0f5)) {
    errortext = "<dev string:x1c>" + blueprintname + "<dev string:x42>";
    iprintln(errortext);

    return undefined;
  }

  assetlist = getassetlist(var_5a0f9e1af605f0f5, assettype);

  foreach(entry in assetlist) {
    if(entry.key == key) {
      if(entry.value == "") {
        return undefined;
      }

      return entry.value;
    }
  }

  errortext = "<dev string:xa2>" + assettype + "<dev string:xc2>" + key + "<dev string:xd3>" + blueprintname + "<dev string:x42>";
  iprintln(errortext);

  return undefined;
}

function function_b9bd0a3d37510bfd(weaponname, weaponblueprintname, attachmentname, attachmentblueprintname) {
  var_9be202c49cdf67ec = undefined;

  if(isDefined(weaponblueprintname)) {
    weaponblueprintnames = getweaponblueprintnames(weaponname);

    foreach(name, index in weaponblueprintnames) {
      if(name == weaponblueprintname) {
        var_9be202c49cdf67ec = index;
        break;
      }
    }
  }

  attachmentarray = [];

  if(isDefined(attachmentname)) {
    attachmentarray = [attachmentname];
  }

  var_e658498427cc5a29 = [];

  if(isDefined(attachmentname) && isDefined(attachmentblueprintname) && isDefined(weaponblueprintname)) {
    var_e658498427cc5a29 = [0];
    weaponblueprintattachmentnames = function_3211981142ec5aee(weaponname, weaponblueprintname);

    foreach(index in weaponblueprintattachmentnames) {
      if(name == attachmentname) {
        var_e658498427cc5a29 = [index];
        break;
      }
    }
  }

  return makeweapon(weaponname, attachmentarray, undefined, undefined, var_9be202c49cdf67ec, var_e658498427cc5a29);
}

function genericblueprint_makeweapon(blueprintname, weaponkey) {
  if(isDefined(blueprintname) && isDefined(weaponkey)) {
    var_5a0f9e1af605f0f5 = function_98442f5bef361b2b("genericblueprint", blueprintname);
    weaponentry = undefined;

    foreach(weaponlistentry in var_5a0f9e1af605f0f5.weaponlist) {
      if(weaponlistentry.key == weaponkey) {
        weaponentry = weaponlistentry;
        break;
      }
    }

    if(!isDefined(weaponentry)) {
      error("could not find weaponIndex for generic blueprint " + blueprintname);
      return;
    }

    weaponname = ter_op(weaponentry.weapon != "", weaponentry.weapon, undefined);
    weaponblueprintname = ter_op(weaponentry.weaponblueprint != "", weaponentry.weaponblueprint, undefined);
    attachmentname = ter_op(weaponentry.attachment != "", weaponentry.attachment, undefined);
    attachmentblueprintname = ter_op(weaponentry.attachmentblueprint != "", weaponentry.attachmentblueprint, undefined);
    return function_b9bd0a3d37510bfd(weaponname, weaponblueprintname, attachmentname, attachmentblueprintname);
  }

  if(!isDefined(blueprintname)) {
    error("blueprintName not specified");
  }

  if(!isDefined(blueprintname)) {
    error("weaponKey not specified");
  }

  return undefined;
}