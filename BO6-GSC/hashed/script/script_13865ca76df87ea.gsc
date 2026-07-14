/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_13865ca76df87ea.gsc
****************************************************/

#using scripts\engine\utility;
#namespace namespace_4218517d5f56ae20;

function genericblueprint_getweaponname(blueprintname, weaponkey) {
  var_cdebbe29b7b6ef8 = function_986fed229fefefda("hj\xf6\xd7/\x91v\x06\xe6\x17U\x0f\xa4\x86\xeaA", blueprintname);

  if(!isDefined(var_cdebbe29b7b6ef8)) {
    errortext = "<dev string:x24>" + getxhashsourcename(blueprintname) + "<dev string:x4d>";
    iprintln(errortext);

    return undefined;
  }

  foreach(entry in var_cdebbe29b7b6ef8.weaponlist) {
    if(entry.key == weaponkey) {
      if(entry.weapon == "") {
        return undefined;
      }

      return entry.weapon;
    }
  }

  errortext = "<dev string:x52>" + getxhashsourcename(weaponkey) + "<dev string:x75>" + getxhashsourcename(blueprintname) + "<dev string:x4d>";
  iprintln(errortext);

  return undefined;
}

function function_db49bc6a9441fab7(blueprintname, weaponkey) {
  var_cdebbe29b7b6ef8 = function_986fed229fefefda("hj\xf6\xd7/\x91v\x06\xe6\x17U\x0f\xa4\x86\xeaA", blueprintname);

  if(!isDefined(var_cdebbe29b7b6ef8)) {
    errortext = "<dev string:x24>" + getxhashsourcename(blueprintname) + "<dev string:x4d>";
    iprintln(errortext);

    return undefined;
  }

  foreach(entry in var_cdebbe29b7b6ef8.weaponlist) {
    if(entry.key == weaponkey) {
      if(entry.weaponblueprint == "") {
        return undefined;
      }

      return entry.weaponblueprint;
    }
  }

  errortext = "<dev string:x52>" + getxhashsourcename(weaponkey) + "<dev string:x75>" + getxhashsourcename(blueprintname) + "<dev string:x4d>";
  iprintln(errortext);

  return undefined;
}

function function_4df433630865b22b(var_af47a9c8fd9416a1, vehiclekey, vehicleasset) {
  var_cdebbe29b7b6ef8 = function_986fed229fefefda("hj\xf6\xd7/\x91v\x06\xe6\x17U\x0f\xa4\x86\xeaA", var_af47a9c8fd9416a1);

  if(!isDefined(var_cdebbe29b7b6ef8)) {
    errortext = "<dev string:x24>" + getxhashsourcename(var_af47a9c8fd9416a1) + "<dev string:x4d>";
    iprintln(errortext);

    return undefined;
  }

  foreach(entry in var_cdebbe29b7b6ef8.vehiclelist) {
    if(entry.key == vehiclekey && entry.vehicle == vehicleasset) {
      if(entry.vehicleblueprint == "") {
        return undefined;
      }

      return entry.vehicleblueprint;
    }
  }

  errortext = "<dev string:x95>" + getxhashsourcename(vehiclekey) + "<dev string:x75>" + getxhashsourcename(var_af47a9c8fd9416a1) + "<dev string:x4d>";
  iprintln(errortext);

  return undefined;
}

function private genericblueprint_getassetlist(bundle, assettype) {
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

      errortext = "<dev string:xb9>";
      iprintln(errortext);

      return undefined;
  }
}

function function_3ddbedcf9262a14b(blueprintname, assettype, key) {
  var_cdebbe29b7b6ef8 = function_986fed229fefefda("hj\xf6\xd7/\x91v\x06\xe6\x17U\x0f\xa4\x86\xeaA", blueprintname);

  if(!isDefined(var_cdebbe29b7b6ef8)) {
    errortext = "<dev string:x24>" + getxhashsourcename(blueprintname) + "<dev string:x4d>";
    iprintln(errortext);

    return undefined;
  }

  assetlist = genericblueprint_getassetlist(var_cdebbe29b7b6ef8, assettype);

  foreach(entry in assetlist) {
    if(entry.key == key) {
      if(entry.value == "") {
        return undefined;
      }

      return entry.value;
    }
  }

  errortext = "<dev string:xdd>" + getxhashsourcename(assettype) + "<dev string:x100>" + getxhashsourcename(key) + "<dev string:x114>" + getxhashsourcename(blueprintname) + "<dev string:x4d>";
  iprintln(errortext);

  return undefined;
}

function private function_164c786e741ec0eb(weaponname, weaponblueprintname, attachmentname, attachmentblueprintname) {
  var_10492491e7017fd = undefined;

  if(isDefined(weaponblueprintname)) {
    weaponblueprintnames = getweaponblueprintnames(weaponname);

    foreach(name, index in weaponblueprintnames) {
      if(name == weaponblueprintname) {
        var_10492491e7017fd = index;
        break;
      }
    }
  }

  attachmentarray = [];

  if(isDefined(attachmentname)) {
    attachmentarray = [attachmentname];
  }

  var_3e8ba8b1e043ed10 = [];

  if(isDefined(attachmentblueprintname) && isDefined(attachmentname) && isDefined(weaponblueprintname)) {
    var_3e8ba8b1e043ed10 = [0];
    weaponblueprintattachmentnames = function_cbf44a76c1f44c23(weaponname, weaponblueprintname);

    foreach(index in weaponblueprintattachmentnames) {
      if(name == attachmentname) {
        var_3e8ba8b1e043ed10 = [index];
        break;
      }
    }
  }

  return makeweapon(weaponname, attachmentarray, undefined, undefined, var_10492491e7017fd, var_3e8ba8b1e043ed10);
}

function function_303d06984d941a4(bundle, blueprintindex) {
  genericblueprintname = undefined;

  if(isDefined(bundle.genericblueprintlist.blueprints) && bundle.genericblueprintlist.blueprints.size > 0 && isDefined(blueprintindex) && blueprintindex > 0) {
    genericblueprintname = bundle.genericblueprintlist.blueprints[blueprintindex - 1].genericblueprint;
  } else if(isDefined(bundle.genericblueprintlist.blueprint_default)) {
    genericblueprintname = bundle.genericblueprintlist.blueprint_default;
  }

  return genericblueprintname;
}

function genericblueprint_makeweapon(blueprintname, weaponkey) {
  if(isDefined(blueprintname) && isDefined(weaponkey)) {
    var_cdebbe29b7b6ef8 = function_986fed229fefefda("hj\xf6\xd7/\x91v\x06\xe6\x17U\x0f\xa4\x86\xeaA", blueprintname);
    weaponentry = undefined;

    foreach(weaponlistentry in var_cdebbe29b7b6ef8.weaponlist) {
      if(weaponlistentry.key == weaponkey) {
        weaponentry = weaponlistentry;
        break;
      }
    }

    if(!isDefined(weaponentry)) {
      utility::error("<dev string:x131>" + getxhashsourcename(blueprintname));

      return;
    }

    weaponname = weaponentry.weapon != "" ? weaponentry.weapon : undefined;
    weaponblueprintname = weaponentry.weaponblueprint != "" ? weaponentry.weaponblueprint : undefined;
    attachmentname = weaponentry.attachment != "" ? weaponentry.attachment : undefined;
    attachmentblueprintname = weaponentry.attachmentblueprint != "" ? weaponentry.attachmentblueprint : undefined;
    return function_164c786e741ec0eb(weaponname, weaponblueprintname, attachmentname, attachmentblueprintname);
  }

  if(!isDefined(blueprintname)) {
    utility::error("\xa0x\x12\xedTs\bi\x01.r\x11\xedDN\x8c\xf08w\xa8\x13\xb2\bKu\x04\xd2");
  }

  if(!isDefined(blueprintname)) {
    utility::error("I*\xe9\xca\xbf\xb6\b\x04\x88\x93\x9b\xdf\x1f\xd7\xef}\xa2{\xbd\x11d\xeb-");
  }

  return undefined;
}

function function_67b53b325f9c3d63(grenade, weaponkey, bundle) {
  if(!isDefined(bundle)) {
    bundle = grenade.bundle;
  }

  if(isDefined(grenade.weapon_object.variantid) && isDefined(bundle)) {
    blueprintname = function_303d06984d941a4(bundle, grenade.weapon_object.variantid);
    return genericblueprint_makeweapon(blueprintname, weaponkey);
  }
}

function function_f5a88f522da0797e(genericblueprintname) {
  if(!isDefined(genericblueprintname)) {
    return;
  }

  genericblueprint = function_986fed229fefefda("hj\xf6\xd7/\x91v\x06\xe6\x17U\x0f\xa4\x86\xeaA", genericblueprintname);

  foreach(vfx in genericblueprint_getassetlist(genericblueprint, #"vfx")) {
    utility::add_fx(genericblueprintname + "\xb0" + vfx.key, vfx.value);
  }
}

function function_808810819abc06f7(bundle) {
  defaultblueprintname = bundle.genericblueprintlist.blueprint_default;
  function_f5a88f522da0797e(defaultblueprintname);

  if(isDefined(bundle.genericblueprintlist.blueprints)) {
    foreach(blueprint in bundle.genericblueprintlist.blueprints) {
      function_f5a88f522da0797e(blueprint.genericblueprint);
    }
  }
}

function genericblueprint_playFX(bundle, blueprintindex, vfxkey, position) {
  genericblueprintname = function_303d06984d941a4(bundle, blueprintindex);
  playFX(utility::getfx(genericblueprintname + "\xb0" + vfxkey), position);
}

function function_53eb52330bac5702(bundle, blueprintindex) {
  genericblueprintname = function_303d06984d941a4(bundle, blueprintindex);
  blueprintdefindex = function_e7710b12014cf46f(genericblueprintname);
  return blueprintdefindex;
}

function function_70817e2bd353b78e(var_af47a9c8fd9416a1, vehiclekey, vehicleasset) {
  vehicle = self;
  assert(isDefined(vehiclekey) && isDefined(var_af47a9c8fd9416a1) && isDefined(vehicleasset));
  vehicleblueprintasset = function_4df433630865b22b(var_af47a9c8fd9416a1, vehiclekey, vehicleasset);

  if(!isDefined(vehicleblueprintasset)) {
    utility::error("<dev string:x166>" + getxhashsourcename(var_af47a9c8fd9416a1));

    return;
  }

  vehicle function_53c500e546137d16(vehicleblueprintasset);
}