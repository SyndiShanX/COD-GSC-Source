/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_weapon.gsc
***********************************************/



#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\weapon;
#namespace cp_weapon;

function function_e83615f8a92e4378(rootname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg) {
  if(function_2b7981cbc7ca24b4(rootname)) {
    return;
  }

  return buildweapon(rootname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg);
}

function function_2b7981cbc7ca24b4(weapon_str) {
  if(getdvarint(@ "hash_216da3534a88c00", 0)) {
    return false;
  }

  if(getsubstr(weapon_str, 0, 4) == "iw8_") {
    println("<dev string:x1c>" + weapon_str + "<dev string:x9c>");
    return true;
  }

  return false;
}

function get_weapon_level(weapon) {
  return scripts\cp\weapon::get_weapon_level(weapon);
}

function has_weapon_variation(weapon) {
  return scripts\cp\weapon::has_weapon_variation(weapon);
}