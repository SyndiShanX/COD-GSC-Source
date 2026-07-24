/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3324.gsc
**************************************/

_id_95C1() {
  self.perk_data = [];
  self.perk_data["health"] = scripts\cp\perks\perkfunctions::_id_96C2();
  self.perk_data["damagemod"] = scripts\cp\perks\perkfunctions::_id_96BF();
  self.perk_data["medic"] = scripts\cp\perks\perkfunctions::_id_96C8();
  self.perk_data["rigger"] = scripts\cp\perks\perkfunctions::_id_96CB();
  self.perk_data["robotics"] = scripts\cp\perks\perkfunctions::_id_96CC();
  self.perk_data["demolition"] = scripts\cp\perks\perkfunctions::_id_96C0();
  self.perk_data["gunslinger"] = scripts\cp\perks\perkfunctions::_id_96C1();
  self.perk_data["hybrid"] = scripts\cp\perks\perkfunctions::_id_96C3();
  self.perk_data["pistol"] = scripts\cp\perks\perkfunctions::_id_96CA();
  self.perk_data["pistol"] = scripts\cp\perks\perkfunctions::_id_96CA();
  self.perk_data["pistol"] = scripts\cp\perks\perkfunctions::_id_96CA();
  self.perk_data["pistol"] = scripts\cp\perks\perkfunctions::_id_96CA();
  self.perk_data["none"] = scripts\cp\perks\perkfunctions::_id_96C9();
}

perk_getmeleescalar() {
  return self.perk_data["health"].melee_scalar;
}

perk_getmaxhealth() {
  return self.perk_data["health"].max_health;
}

perk_getbulletdamagescalar() {
  return self.perk_data["damagemod"].bullet_damage_scalar;
}

perk_getrevivetimescalar() {
  return self.perk_data["medic"].revive_time_scalar;
}

_id_CA37() {
  return self.perk_data["medic"]._id_76AC;
}

_id_CA3B() {
  return self.perk_data["medic"]._id_BC6F;
}

_id_CA40() {
  return self.perk_data["medic"]._id_E496;
}

perk_getdrillhealthscalar() {
  return self.perk_data["rigger"]._id_5B99;
}

perk_getdrilltimescalar() {
  return self.perk_data["rigger"]._id_5BB8;
}

_id_CA42() {
  return self.perk_data["rigger"]._id_1269D;
}

_id_CA43() {
  return self.perk_data["rigger"]._id_1269E;
}

_id_CA44() {
  return self.perk_data["rigger"]._id_1269F;
}

perk_getcurrencyscaleperhive() {
  return self.perk_data["rigger"]._id_4B35;
}

_id_CA3F() {
  return self.perk_data["rigger"]._id_E18F;
}

_id_CA30() {
  return self.perk_data["robotics"]._id_2180;
}

_id_CA31() {
  return self.perk_data["robotics"]._id_2181;
}

perk_getexplosivedamagescalar() {
  return self.perk_data["demolition"].explosive_damage_scalar;
}

perk_getoffhandcount() {
  return self.perk_data["demolition"].offhand_count;
}

_id_CA38() {
  return self.perk_data["demolition"]._id_AAAA;
}

_id_CA3E() {
  return self.perk_data["pistol"]._id_CBDC;
}

_id_CA3D() {
  return self.perk_data["pistol"].pistol_overkill;
}

_id_7C4D() {}

_id_7C4E() {
  var_0 = "perk_none";
  return var_0;
}

_id_E2BC() {
  var_0 = _id_7C4D();
  var_1 = _id_7B75();
  scripts\cp\cp_persistence::set_perk(_id_7B79("perk_0", var_0, var_1));
  var_2 = _id_7C4E();

  if(var_2 != "perk_none") {
    var_3 = level.alien_perks["perk_0"][var_2];
    scripts\cp\cp_persistence::set_perk(_id_7B79("perk_0", var_3.ref, var_1));
  }
}

_id_7B79(var_0, var_1, var_2) {
  return level.alien_perks[var_0][var_1]._id_12F7A[var_2].ref;
}

_id_7B75() {
  return self getrankedplayerdata("cp", "alienSession", "perk_0_level");
}

_id_7B76() {
  return self getrankedplayerdata("cp", "alienSession", "perk_1_level");
}

_id_7B77() {
  return self getrankedplayerdata("cp", "alienSession", "perk_2_level");
}