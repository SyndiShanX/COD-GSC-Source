/**************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\activecamo_shared_util.gsc
**************************************************/

#namespace activecamo;

function function_b259f3e0(camoweapon) {
  assert(isDefined(camoweapon));
  var_e69cf15d = function_3786d342(camoweapon);

  if(isDefined(var_e69cf15d) && var_e69cf15d != level.weaponnone) {
    camoweapon = var_e69cf15d;
  }

  return camoweapon;
}

function function_c14cb514(weapon) {
  if(isDefined(level.var_f06de157)) {
    return [[level.var_f06de157]](weapon);
  }

  if(isDefined(weapon)) {
    if(level.weaponnone != weapon) {
      activecamoweapon = function_b259f3e0(weapon);

      if(activecamoweapon.isaltmode) {
        if(isDefined(activecamoweapon.altweapon) && level.weaponnone != activecamoweapon.altweapon) {
          activecamoweapon = activecamoweapon.altweapon;
        }
      }

      if(isDefined(activecamoweapon.rootweapon) && level.weaponnone != activecamoweapon.rootweapon) {
        return activecamoweapon.rootweapon;
      }

      return activecamoweapon;
    }
  }

  return weapon;
}

function function_94c2605(weapon) {
  if(isDefined(weapon)) {
    if(level.weaponnone != weapon) {
      activecamoweapon = weapon;

      if(activecamoweapon.inventorytype == "dwlefthand") {
        if(isDefined(activecamoweapon.dualwieldweapon) && level.weaponnone != activecamoweapon.dualwieldweapon) {
          activecamoweapon = activecamoweapon.dualwieldweapon;
        }
      }

      if(activecamoweapon.isaltmode) {
        if(isDefined(activecamoweapon.altweapon) && level.weaponnone != activecamoweapon.altweapon) {
          activecamoweapon = activecamoweapon.altweapon;
        }
      }

      return activecamoweapon;
    }
  }

  return weapon;
}

function function_13e12ab1(camoindex) {
  var_f4eb4a50 = undefined;
  activecamoname = getactivecamo(camoindex);

  if(isDefined(activecamoname) && activecamoname != # "") {
    var_f4eb4a50 = getscriptbundle(activecamoname);
  }

  return var_f4eb4a50;
}

function function_edd6511(camooptions) {
  camoindex = getcamoindex(camooptions);
  return function_13e12ab1(camoindex);
}

function function_5af7df72(camooptions) {
  camoindex = getcamoindex(camooptions);
  return getactivecamo(camoindex);
}

function function_54f0afd2(var_3594168e) {
  var_e2dbd42d = isDefined(var_3594168e.var_e2dbd42d) ? var_3594168e.var_e2dbd42d : 0;

  if(sessionmodeiszombiesgame() && isDefined(var_3594168e.var_9b0d1315) && var_3594168e.var_9b0d1315 > 0) {
    var_e2dbd42d = var_3594168e.var_9b0d1315;
  }

  return var_e2dbd42d;
}

function function_33ed1149(weapon, var_f879230e) {
  var_de0d8ad3 = function_7afd1b32(weapon, var_f879230e);

  if(isDefined(var_de0d8ad3.activecamoname) && var_de0d8ad3.activecamoname != # "") {
    return var_de0d8ad3.activecamoname;
  }

  foreach(attachment in var_de0d8ad3.attachments) {
    if(isDefined(attachment.activecamoname) && attachment.activecamoname != # "") {
      return attachment.activecamoname;
    }
  }

  return undefined;
}