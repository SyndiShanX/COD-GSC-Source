/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\perk_shared.gsc
***********************************************/



#namespace perk_shared;

function function_56ad1b98a0613f8a(perkname) {
  return isDefined(perkname) && isDefined(self.perks) && isDefined(self.perks[perkname]);
}