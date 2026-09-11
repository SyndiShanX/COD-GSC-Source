/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_armor.gsc
***********************************************/

function main() {
  level.ref_1203e = &ref_1203e;
}

function getdefaultmaxarmorhealth() {
  var0 = getdvarint("scr_br_max_armor_health", 150);

  if(getdvarint("scr_game_hcmode") == 1) {
    self.br_maxarmorhealth = 50 * getdvarint("scr_hcplatnum", 1);
  }

  return var0;
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

function getoldarmorent(var0) {
  var1 = spawnStruct();
  var1.count = 1;
  var1.maxcount = 1;
  var1.stackable = 1;

  if(scripts\mp\gametypes\br_public::ishelmet(var0.scriptablename)) {} else if(scripts\mp\gametypes\br_pickups::isgasmask(var0.scriptablename)) {
    var1.gasmaskhealth = self.gasmaskhealth;
  } else {
    var1.armorhealth = self.br_armorhealth;
  }

  return var1;
}

function helmetitemtypeforlevel(var0) {
  switch (var0) {
    case 1:
      return "brloot_armor_helmet_1";
    case 2:
      return "brloot_armor_helmet_2";
    case 3:
      return "brloot_armor_helmet_3";
  }

  return undefined;
}

function searchcirclesize(var0) {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("armor")) {
    return;
  }

  var1 = self;
  var2 = 100;
  var3 = getdvarint("scr_br_armor_overrideStartingValue", -1);

  if(var3 >= 0) {
    var2 = var3;
  }

  if(getdvarint("scr_br_alt_mode_gg", 0) || istrue(var0)) {
    var2 = getdefaultmaxarmorhealth();
  }

  scriptablescurid(var1, var2);
}

function scriptablescurid(var0) {
  if(!isDefined(var0) || var0 < 0) {
    return;
  }

  self.br_armorhealth = var0;
  self.br_maxarmorhealth = getdefaultmaxarmorhealth();
  var1 = self.br_armorhealth / self.br_maxarmorhealth;

  if(isPlayer(self)) {
    self setclientomnvar("ui_br_armor_damage", var1);
    scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
    return;
  }
}

function takehelmet(var0, var1) {
  self.br_helmetlevel = var1;
  var2 = level.br_pickups.br_itemrow[var0.scriptablename];

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

function isarmorbetterthanequipped(var0) {
  var1 = 0;

  if(var0 == "equip_helmet_1") {
    var1 = 1;
  } else if(var0 == "equip_helmet_2") {
    var1 = 2;
  } else if(var0 == "equip_helmet_3") {
    var1 = 3;
  }

  if(var1 > 0) {
    if(!isDefined(self.br_helmetlevel) || self.br_helmetlevel < var1) {
      return true;
    }
  }

  return false;
}

function popoffhelmet(var0, var1, var2) {
  level endon("game_ended");
  var3 = self gettagorigin("j_helmet");

  if(!isDefined(var3)) {
    var3 = var2 + (0, 0, 80);
  }

  var4 = spawn("script_model", self gettagorigin("j_helmet"));
  var4 setModel("loot_helmet");
  var4.angles = var1;
  var5 = anglestoup(var1);
  var6 = var0;
  var7 = vectorNormalize(var6 + var5) * 2500;
  var4 physicslaunchserver(var4.origin, var7);
  var8 = "brloot_armor_helmet_" + self.br_helmetlevel;
  var9 = 15;
  var10 = 0.1;
  var9 *= 1 / var10;
  var11 = var4.origin;
  var12 = 0;

  while(var12 < var9) {
    wait var10;
    var13 = var11 - var4.origin;

    if(var13[0] < 2 && var13[1] < 2 && var13[2] < 2 && var13[0] > -2 && var13[1] > -2 && var13[2] > -2) {
      var14 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var4.origin, var4.angles);
      var4 delete();
      var15 = scripts\mp\gametypes\br_pickups::spawnpickup(var8, var14);
      var15.count = 1;
      return;
    }

    var13 = var6.origin;
    var14++;
  }

  var6 delete();
}

function ref_1203e(var0, var1) {
  if(isDefined(var0)) {
    thread popoffhelmet(var0, var1, var0.angles);
    return;
  }
}