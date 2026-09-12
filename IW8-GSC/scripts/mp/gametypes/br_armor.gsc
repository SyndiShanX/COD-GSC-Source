/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_armor.gsc
***********************************************/

function main() {
  level.ref_1203E = &ref_1203E;
}

function getdefaultmaxarmorhealth() {
  var_0 = getdvarint("scr_br_max_armor_health", 150);

  if(getdvarint("scr_game_hcmode") == 1) {
    self.br_maxarmorhealth = 50 * getdvarint("scr_hcplatnum", 1);
  }

  return var_0;
}

function teamfriendlyto() {
  self.br_armorhealth = 0;
  self.br_maxarmorhealth = getdefaultmaxarmorhealth();

  if(isPlayer(self)) {
    self setclientomnvar("ui_br_armor_damage", 0);
    scripts\mp\equipment\armor_plate::debug_state(0);
    return;
  }
}

function getoldarmorent(var_0) {
  var_1 = spawnStruct();
  var_1.count = 1;
  var_1.maxcount = 1;
  var_1.stackable = 1;

  if(scripts\mp\gametypes\br_public::ishelmet(var_0.scriptablename)) {} else if(scripts\mp\gametypes\br_pickups::isgasmask(var_0.scriptablename)) {
    var_1.gasmaskhealth = self.gasmaskhealth;
  } else {
    var_1.armorhealth = self.br_armorhealth;
  }

  return var_1;
}

function helmetitemtypeforlevel(var_0) {
  switch (var_0) {
    case 1:
      return "brloot_armor_helmet_1";
    case 2:
      return "brloot_armor_helmet_2";
    case 3:
      return "brloot_armor_helmet_3";
  }

  return undefined;
}

function searchcirclesize(var_0) {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("armor")) {
    return;
  }

  var_1 = self;
  var_2 = 100;
  var_3 = getdvarint("scr_br_armor_overrideStartingValue", -1);

  if(var_3 >= 0) {
    var_2 = var_3;
  }

  if(getdvarint("scr_br_alt_mode_gg", 0) || istrue(var_0)) {
    var_2 = getdefaultmaxarmorhealth();
  }

  scriptablescurid(var_1, var_2);
}

function scriptablescurid(var_0) {
  if(!isDefined(var_0) || var_0 < 0) {
    return;
  }

  self.br_armorhealth = var_0;
  self.br_maxarmorhealth = getdefaultmaxarmorhealth();
  var_1 = self.br_armorhealth / self.br_maxarmorhealth;

  if(isPlayer(self)) {
    self setclientomnvar("ui_br_armor_damage", var_1);
    scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
    return;
  }
}

function takehelmet(var_0, var_1) {
  self.br_helmetlevel = var_1;
  var_2 = level.br_pickups.br_itemrow[var_0.scriptablename];

  if(self.br_helmetlevel == 3) {
    scripts\mp\utility\perk::giveperk("specialty_stun_resistance");
    return;
  }
}

function disable_map_ammo_munitions() {
  if(scripts\mp\gametypes\br_public::hasarmor()) {
    scripts\mp\gametypes\br_public::damagearmor(self.br_armorhealth, 1);
    return;
  }
}

function isarmorbetterthanequipped(var_0) {
  var_1 = 0;

  if(var_0 == "equip_helmet_1") {
    var_1 = 1;
  } else if(var_0 == "equip_helmet_2") {
    var_1 = 2;
  } else if(var_0 == "equip_helmet_3") {
    var_1 = 3;
  }

  if(var_1 > 0) {
    if(!isDefined(self.br_helmetlevel) || self.br_helmetlevel < var_1) {
      return true;
    }
  }

  return false;
}

function popoffhelmet(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = self gettagorigin("j_helmet");

  if(!isDefined(var_3)) {
    var_3 = var_2 + (0, 0, 80);
  }

  var_4 = spawn("script_model", self gettagorigin("j_helmet"));
  var_4 setModel("loot_helmet");
  var_4.angles = var_1;
  var_5 = anglestoup(var_1);
  var_6 = var_0;
  var_7 = vectorNormalize(var_6 + var_5) * 2500;
  var_4 physicslaunchserver(var_4.origin, var_7);
  var_8 = "brloot_armor_helmet_" + self.br_helmetlevel;
  var_9 = 15;
  var_10 = 0.1;
  var_9 *= 1 / var_10;
  var_11 = var_4.origin;
  var_12 = 0;

  while(var_12 < var_9) {
    wait var_10;
    var_13 = var_11 - var_4.origin;

    if(var_13[0] < 2 && var_13[1] < 2 && var_13[2] < 2 && var_13[0] > -2 && var_13[1] > -2 && var_13[2] > -2) {
      var_14 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var_4.origin, var_4.angles);
      var_4 delete();
      var_15 = scripts\mp\gametypes\br_pickups::spawnpickup(var_8, var_14);
      var_15.count = 1;
      return;
    }

    var_13 = var_6.origin;
    var_14++;
  }

  var_6 delete();
}

function ref_1203E(var_0, var_1) {
  if(isDefined(var_0)) {
    thread popoffhelmet(var_0, var_1, var_0.angles);
    return;
  }
}