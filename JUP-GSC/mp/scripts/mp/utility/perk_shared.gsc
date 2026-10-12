/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\perk_shared.gsc
***********************************************/

#namespace perk_shared;

function function_56ad1b98a0613f8a(perkname) {
  if(getdvarint(@ "hash_72ba2c5c35486a09", 0) == 0) {
    if(perkname == "specialty_super_speed" || perkname == "specialty_super_speed_script" || perkname == "specialty_super_strength" || perkname == "specialty_durability") {
      return false;
    }
  }

  return isDefined(perkname) && isDefined(self.perks) && isDefined(self.perks[perkname]);
}