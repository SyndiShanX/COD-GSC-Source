/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_13865ca76df87ea.gsc
************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_4f3742cd39063b9;

function genericblueprint_getweaponname(blueprintname, weaponkey) {
  var_5a0f9e1af605f0f5 = function_98442f5bef361b2b("genericblueprint", blueprintname);

  if(!isDefined(var_5a0f9e1af605f0f5)) {
    errortext = "<dev string:x1c>" + getxhashsourcename(blueprintname) + "<dev string:x45>";
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

  errortext = "<dev string:x4a>" + getxhashsourcename(weaponkey) + "<dev string:x6d>" + getxhashsourcename(blueprintname) + "<dev string:x45>";
  iprintln(errortext);

  return undefined;
}

function function_b9ff4b6230995332(blueprintname, weaponkey) {
  var_5a0f9e1af605f0f5 = function_98442f5bef361b2b("genericblueprint", blueprintname);

  if(!isDefined(var_5a0f9e1af605f0f5)) {
    errortext = "<dev string:x1c>" + getxhashsourcename(blueprintname) + "<dev string:x45>";
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

  errortext = "<dev string:x4a>" + getxhashsourcename(weaponkey) + "<dev string:x6d>" + getxhashsourcename(blueprintname) + "<dev string:x45>";
  iprintln(errortext);

  return undefined;
}

function getassetlist(bundle, assettype) {
  switch (assettype) {
    case #"xmodel":
      return bundle.xmodellist;
    case #"vfx":
      return bundle.vfxlist;
    case #"string":
      return bundle.stringlist;
    case #"suit":
      return bundle.suitlist;
    case #"execution":
      return bundle.executionlist;
    default:

      errortext = "<dev string:x8d>";
      iprintln(errortext);

      return undefined;
  }
}

function function_29e16a88682086b2(blueprintname, assettype, key) {
  var_5a0f9e1af605f0f5 = function_98442f5bef361b2b("genericblueprint", blueprintname);

  if(!isDefined(var_5a0f9e1af605f0f5)) {
    errortext = "<dev string:x1c>" + getxhashsourcename(blueprintname) + "<dev string:x45>";
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

  errortext = "<dev string:xb1>" + assettype + "<dev string:xd4>" + getxhashsourcename(key) + "<dev string:xe8>" + getxhashsourcename(blueprintname) + "<dev string:x45>";
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

    foreach(name, index in weaponblueprintattachmentnames) {
      if(name == attachmentname) {
        var_e658498427cc5a29 = [index];
        break;
      }
    }
  }

  return makeweapon(weaponname, attachmentarray, undefined, undefined, var_9be202c49cdf67ec, var_e658498427cc5a29);
}

function function_71efed8bf57f1d39(bundle, blueprintindex) {
  genericblueprintname = undefined;

  if(isDefined(bundle.genericblueprintlist.blueprints) && bundle.genericblueprintlist.blueprints.size > 0 && blueprintindex > 0) {
    genericblueprintname = bundle.genericblueprintlist.blueprints[blueprintindex - 1].genericblueprint;
  } else if(isDefined(bundle.genericblueprintlist.blueprint_default)) {
    genericblueprintname = bundle.genericblueprintlist.blueprint_default;
  }

  return genericblueprintname;
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
      error("<dev string:x105>" + getxhashsourcename(blueprintname));

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

function function_a03b57f924bf9a77(genericblueprintname) {
  genericblueprint = function_98442f5bef361b2b("genericblueprint", genericblueprintname);

  foreach(vfx in getassetlist(genericblueprint, #"vfx")) {
    utility::add_fx(getxhashhexname(genericblueprintname) + ":" + vfx.key, vfx.value);
  }
}

function function_b68fa1978a63823a(bundle) {
  defaultblueprintname = bundle.genericblueprintlist.blueprint_default;
  function_a03b57f924bf9a77(defaultblueprintname);

  foreach(blueprint in bundle.genericblueprintlist.blueprints) {
    function_a03b57f924bf9a77(blueprint.genericblueprint);
  }
}

function genericblueprint_playfx(bundle, blueprintindex, vfxkey, position) {
  genericblueprintname = function_71efed8bf57f1d39(bundle, blueprintindex);
  playFX(utility::getfx(getxhashhexname(genericblueprintname) + ":" + vfxkey), position);
}

function function_696473ef4d75f1d3(bundle, blueprintindex) {
  genericblueprintname = function_71efed8bf57f1d39(bundle, blueprintindex);
  blueprintdefindex = function_3948a353eff6c51a(genericblueprintname);
  return blueprintdefindex;
}