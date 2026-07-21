/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_armor.gsc
***********************************************/

main() {
  level._id_1203E = ::_id_1203E;
}

_encstr_861519B969C353C3787F9DC45B2A71A97E3BE5DF730B4966A121D1() {
  var_0 = getdvarint("_encstr_8B6418CD3639FAC4E4D7B5B087BE8539D6ED9C7D86AC58B18EA1", 150);

  if(getdvarint("_encstr_91CC10B346F5F93A78B1150961675ADD7F11") == 1)
    self.br_maxarmorhealth = 50 * getdvarint("_encstr_96830E638E42AF091EBBC2024D3080E8", 1);

  return var_0;
}

teamfriendlyto() {
  self.br_armorhealth = 0;
  self.br_maxarmorhealth = _encstr_861519B969C353C3787F9DC45B2A71A97E3BE5DF730B4966A121D1();

  if(isPlayer(self)) {
    self setclientomnvar("_encstr_BD71131B60E0DBCAA1A31A1DA710590B1718D2A249", 0);
    scripts\mp\equipment\armor_plate::debug_state(0);
  }
}

getoldarmorent(var_0) {
  var_1 = spawnStruct();
  var_1.count = 1;
  var_1.maxcount = 1;
  var_1.stackable = 1;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::ishelmet(var_0.scriptablename)) {} else if(_encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::isgasmask(var_0.scriptablename))
    var_1.gasmaskhealth = self.gasmaskhealth;
  else
    var_1.armorhealth = self.br_armorhealth;

  return var_1;
}

helmetitemtypeforlevel(var_0) {
  switch (var_0) {
    case 1:
      return "_encstr_82E116229E8558408BD1E3FB551D182FA8EDB89577A05FBA";
    case 2:
      return "_encstr_96E116CE235227BA3B27F6D8806ACABF8B6D612A672CD9A3";
    case 3:
      return "_encstr_87E1162627B1BDDBE8D72C9CDABDE4FA345663D6591DEB99";
  }

  return undefined;
}

searchcirclesize(var_0) {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A7B606DA83796F4A")) {
    return;
  }
  var_1 = self;
  var_2 = 100;
  var_3 = getdvarint("_encstr_92B423E68D93BEC44EEB584EADF6E4F5EDEC594E932D8C2BA6D1164E3A4BCDEC59851BD556", -1);

  if(var_3 >= 0)
    var_2 = var_3;

  if(getdvarint("_encstr_BE8413F37E20A8AEF56E810BC337E1E001403E6F7A", 0) || istrue(var_0))
    var_2 = _encstr_861519B969C353C3787F9DC45B2A71A97E3BE5DF730B4966A121D1();

  var_1 scriptablescurid(var_2);
}

scriptablescurid(var_0) {
  if(!isDefined(var_0) || var_0 < 0) {
    return;
  }
  self.br_armorhealth = var_0;
  self.br_maxarmorhealth = _encstr_861519B969C353C3787F9DC45B2A71A97E3BE5DF730B4966A121D1();
  var_1 = self.br_armorhealth / self.br_maxarmorhealth;

  if(isPlayer(self)) {
    self setclientomnvar("_encstr_BD71131B60E0DBCAA1A31A1DA710590B1718D2A249", var_1);
    scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
  }
}

takehelmet(var_0, var_1) {
  self.br_helmetlevel = var_1;
  var_2 = level.br_pickups.br_itemrow[var_0.scriptablename];

  if(self.br_helmetlevel == 3)
    scripts\mp\utility\perk::giveperk("_encstr_8BC01A138148BECFDFF83B13662E73F3C877AA8D1F40C2E3F79042DA");
}

disable_map_ammo_munitions() {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasarmor())
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::damagearmor(self.br_armorhealth, 1);
}

isarmorbetterthanequipped(var_0) {
  var_1 = 0;

  if(var_0 == "_encstr_A6A70FACB8AB4BE0FA43ACC6DAB2D17DC4")
    var_1 = 1;
  else if(var_0 == "_encstr_95A70F37280BC1AB0F83E7DD7913A3AFBB")
    var_1 = 2;
  else if(var_0 == "_encstr_B4A70F68DBDB835FCF141D323D9D70D932")
    var_1 = 3;

  if(var_1 > 0) {
    if(!isDefined(self.br_helmetlevel) || self.br_helmetlevel < var_1)
      return 1;
  }

  return 0;
}

popoffhelmet(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = self gettagorigin("_encstr_9ABB0968F1402B19E2AFA9");

  if(!isDefined(var_3))
    var_3 = var_2 + (0, 0, 80);

  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin("_encstr_9ABB0968F1402B19E2AFA9"));
  var_4 setModel("_encstr_935A0C63DBF61DEB1A2B36ADAC1D");
  var_4.angles = var_1;
  var_5 = anglestoup(var_1);
  var_6 = var_0;
  var_7 = vectorNormalize(var_6 + var_5) * 2500;
  var_4 physicslaunchserver(var_4.origin, var_7);
  var_8 = "_encstr_B45C15028563BDD7559E6AA320206B79F803B48533A8C9" + self.br_helmetlevel;
  var_9 = 15;
  var_10 = 0.1;
  var_9 = var_9 * (1 / var_10);
  var_11 = var_4.origin;

  for(var_12 = 0; var_12 < var_9; var_12++) {
    wait(var_10);
    var_13 = var_11 - var_4.origin;

    if(var_13[0] < 2 && var_13[1] < 2 && var_13[2] < 2 && var_13[0] > -2 && var_13[1] > -2 && var_13[2] > -2) {
      var_14 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::remove_roof_nodes(var_4.origin, var_4.angles);
      var_4 delete();
      var_15 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(var_8, var_14);
      var_15.count = 1;
      return;
    }

    var_11 = var_4.origin;
  }

  var_4 delete();
}

_id_1203E(var_0, var_1) {
  if(isDefined(var_0))
    var_0 thread popoffhelmet(var_1, var_0.angles, var_0.origin);
}