/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\perks\_abilities.gsc
****************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

givePerksFromKnownLoadout(loadoutPerks, validatePerks) {
  validatePerks = ter_op(isDefined(validatePerks), validatePerks, true);

  foreach(perk in loadoutPerks) {
    if(validatePerks) {
      perk = maps\mp\perks\_perks::validatePerk(perk);
    }
    self givePerk(perk, false);
  }
}

giveSpeedPerks(numPoints) {
  loadOutPerks = [];

  switch (numPoints) {
    case 0:
      break;
    case 1:
      loadoutPerks[loadoutPerks.size] = "specialty_lightweight_3";
      break;
    case 2:
      loadoutPerks[loadoutPerks.size] = "specialty_lightweight_3";
      loadoutPerks[loadoutPerks.size] = "specialty_fastreload";
      break;
    case 3:
      loadoutPerks[loadoutPerks.size] = "specialty_lightweight_4";
      loadoutPerks[loadoutPerks.size] = "specialty_marathon";
      loadoutPerks[loadoutPerks.size] = "specialty_fastreload";
      break;
    case 4:
      loadoutPerks[loadoutPerks.size] = "specialty_lightweight_7";
      loadoutPerks[loadoutPerks.size] = "specialty_marathon";
      loadoutPerks[loadoutPerks.size] = "specialty_fastreload";
      break;
    case 5:
      loadoutPerks[loadoutPerks.size] = "specialty_lightweight_7";
      loadoutPerks[loadoutPerks.size] = "specialty_marathon";
      loadoutPerks[loadoutPerks.size] = "specialty_stalker";
      loadoutPerks[loadoutPerks.size] = "specialty_fastreload";
      break;
  }

  self.pers["loadoutPerks"] = loadoutPerks;
  self givePerksFromKnownLoadout(loadoutPerks);
}

giveHandlingPerks(numPoints) {
  loadOutPerks = [];

  switch (numPoints) {
    case 0:
      break;
    case 1:
      loadoutPerks[loadoutPerks.size] = "specialty_bulletaccuracy_10";
      break;
    case 2:
      loadoutPerks[loadoutPerks.size] = "specialty_bulletaccuracy_10";
      loadoutPerks[loadoutPerks.size] = "specialty_reducedsway";
      break;
    case 3:
      loadoutPerks[loadoutPerks.size] = "specialty_bulletaccuracy_10";
      loadoutPerks[loadoutPerks.size] = "specialty_reducedsway";
      loadoutPerks[loadoutPerks.size] = "specialty_quickswap";
      break;
    case 4:
      loadoutPerks[loadoutPerks.size] = "specialty_bulletaccuracy_10";
      loadoutPerks[loadoutPerks.size] = "specialty_reducedsway";
      loadoutPerks[loadoutPerks.size] = "specialty_quickswap";
      loadoutPerks[loadoutPerks.size] = "specialty_marksman_10";
      break;
    case 5:
      loadoutPerks[loadoutPerks.size] = "specialty_bulletaccuracy_10";
      loadoutPerks[loadoutPerks.size] = "specialty_reducedsway";
      loadoutPerks[loadoutPerks.size] = "specialty_quickswap";
      loadoutPerks[loadoutPerks.size] = "specialty_marksman_10";
      loadoutPerks[loadoutPerks.size] = "specialty_quickdraw";
      break;
  }

  tempArray = array_combine(loadoutPerks, self.pers["loadoutPerks"]);
  self.pers["loadoutPerks"] = tempArray;

  givePerksFromKnownLoadout(loadoutPerks);
}

giveStealthPerks(numPoints) {
  loadOutPerks = [];

  switch (numPoints) {
    case 0:
      break;
    case 1:
      loadoutPerks[loadoutPerks.size] = "specialty_spygame";
      break;
    case 2:
      loadoutPerks[loadoutPerks.size] = "specialty_blindeye";
      loadoutPerks[loadoutPerks.size] = "specialty_spygame";
      break;
    case 3:
      loadoutPerks[loadoutPerks.size] = "specialty_spygame";
      loadoutPerks[loadoutPerks.size] = "specialty_blindeye";
      loadoutPerks[loadoutPerks.size] = "specialty_coldblooded";
      break;
    case 4:
      loadoutPerks[loadoutPerks.size] = "specialty_spygame";
      loadoutPerks[loadoutPerks.size] = "specialty_quieter";
      loadoutPerks[loadoutPerks.size] = "specialty_blindeye";
      loadoutPerks[loadoutPerks.size] = "specialty_coldblooded";
      loadoutPerks[loadoutPerks.size] = "specialty_heartbreaker";
      break;
    case 5:
      loadoutPerks[loadoutPerks.size] = "specialty_spygame";
      loadoutPerks[loadoutPerks.size] = "specialty_quieter";
      loadoutPerks[loadoutPerks.size] = "specialty_blindeye";
      loadoutPerks[loadoutPerks.size] = "specialty_coldblooded";
      loadoutPerks[loadoutPerks.size] = "specialty_heartbreaker";
      loadoutPerks[loadoutPerks.size] = "specialty_quieter";
      break;
  }

  tempArray = array_combine(loadoutPerks, self.pers["loadoutPerks"]);
  self.pers["loadoutPerks"] = tempArray;

  givePerksFromKnownLoadout(loadoutPerks);
}

giveAwarenessPerks(numPoints) {
  loadOutPerks = [];

  switch (numPoints) {
    case 0:
      break;
    case 1:
      loadoutPerks[loadoutPerks.size] = "specialty_paint";
      loadoutPerks[loadoutPerks.size] = "specialty_paint_pro";
      break;
    case 2:
      loadoutPerks[loadoutPerks.size] = "specialty_paint";
      loadoutPerks[loadoutPerks.size] = "specialty_paint_pro";
      loadoutPerks[loadoutPerks.size] = "specialty_scavenger";
      break;
    case 3:
      loadoutPerks[loadoutPerks.size] = "specialty_paint";
      loadoutPerks[loadoutPerks.size] = "specialty_paint_pro";
      loadoutPerks[loadoutPerks.size] = "specialty_scavenger";
      loadoutPerks[loadoutPerks.size] = "specialty_detectexplosive";
      break;
    case 4:
      loadoutPerks[loadoutPerks.size] = "specialty_selectivehearing";
      loadoutPerks[loadoutPerks.size] = "specialty_paint";
      loadoutPerks[loadoutPerks.size] = "specialty_paint_pro";
      loadoutPerks[loadoutPerks.size] = "specialty_scavenger";
      loadoutPerks[loadoutPerks.size] = "specialty_detectexplosive";
      break;
    case 5:
      loadoutPerks[loadoutPerks.size] = "specialty_autospot";
      loadoutPerks[loadoutPerks.size] = "specialty_selectivehearing";
      loadoutPerks[loadoutPerks.size] = "specialty_paint";
      loadoutPerks[loadoutPerks.size] = "specialty_paint_pro";
      loadoutPerks[loadoutPerks.size] = "specialty_scavenger";
      loadoutPerks[loadoutPerks.size] = "specialty_detectexplosive";
      break;
  }

  tempArray = array_combine(loadoutPerks, self.pers["loadoutPerks"]);
  self.pers["loadoutPerks"] = tempArray;

  givePerksFromKnownLoadout(loadoutPerks);
}

giveResistancePerks(numPoints) {
  loadOutPerks = [];

  switch (numPoints) {
    case 0:
      break;
    case 1:
      loadoutPerks[loadoutPerks.size] = "specialty_stun_resistance_6";
      break;
    case 2:
      loadoutPerks[loadoutPerks.size] = "specialty_stun_resistance_6";
      loadoutPerks[loadoutPerks.size] = "_specialty_blastshield";
      self.blastShieldMod = .65;
      break;
    case 3:
      loadoutPerks[loadoutPerks.size] = "specialty_stun_resistance_6";
      loadoutPerks[loadoutPerks.size] = "_specialty_blastshield";
      loadoutPerks[loadoutPerks.size] = "specialty_delaymine";
      self.blastShieldMod = .65;
      break;
    case 4:
      loadoutPerks[loadoutPerks.size] = "specialty_stun_resistance_6";
      loadoutPerks[loadoutPerks.size] = "_specialty_blastshield";
      loadoutPerks[loadoutPerks.size] = "specialty_delaymine";
      loadoutPerks[loadoutPerks.size] = "specialty_sharp_focus";
      self.blastShieldMod = .65;
      break;
    case 5:
      loadoutPerks[loadoutPerks.size] = "specialty_stun_resistance_10";
      loadoutPerks[loadoutPerks.size] = "_specialty_blastshield";
      loadoutPerks[loadoutPerks.size] = "specialty_delaymine";
      loadoutPerks[loadoutPerks.size] = "specialty_sharp_focus";
      self.blastShieldMod = .85;
      break;
  }

  tempArray = array_combine(loadoutPerks, self.pers["loadoutPerks"]);
  self.pers["loadoutPerks"] = tempArray;

  givePerksFromKnownLoadout(loadoutPerks);
}

giveEquipmentPerks(numPoints) {
  loadOutPerks = [];

  switch (numPoints) {
    case 0:
      break;
    case 1:
      loadoutPerks[loadoutPerks.size] = "specialty_extraammo";
      break;
    case 2:
      loadoutPerks[loadoutPerks.size] = "specialty_extraammo";
      loadoutPerks[loadoutPerks.size] = "specialty_extra_equipment";
      break;
    case 3:
      loadoutPerks[loadoutPerks.size] = "specialty_extraammo";
      loadoutPerks[loadoutPerks.size] = "specialty_extra_equipment";
      loadoutPerks[loadoutPerks.size] = "specialty_fastsprintrecovery";
      break;
    case 4:
      loadoutPerks[loadoutPerks.size] = "specialty_extraammo";
      loadoutPerks[loadoutPerks.size] = "specialty_extra_equipment";
      loadoutPerks[loadoutPerks.size] = "specialty_extra_deadly";
      loadoutPerks[loadoutPerks.size] = "specialty_fastsprintrecovery";
      break;
    case 5:
      loadoutPerks[loadoutPerks.size] = "specialty_extraammo";
      loadoutPerks[loadoutPerks.size] = "specialty_extra_equipment";
      loadoutPerks[loadoutPerks.size] = "specialty_extra_deadly";
      loadoutPerks[loadoutPerks.size] = "specialty_fastsprintrecovery";
      loadoutPerks[loadoutPerks.size] = "specialty_hardline";
      break;
  }

  tempArray = array_combine(loadoutPerks, self.pers["loadoutPerks"]);
  self.pers["loadoutPerks"] = tempArray;

  givePerksFromKnownLoadout(loadoutPerks);
}