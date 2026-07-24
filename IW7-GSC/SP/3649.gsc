/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3649.gsc
**************************************/

_id_F701() {
  level.player setperk("specialty_fastreload", 1);
}

_id_12CBC() {
  level.player unsetperk("specialty_fastreload", 1);
}

setstaticuicircles() {
  level.player setperk("specialty_bulletaccuracy", 1);
}

unsetspotter() {
  level.player unsetperk("specialty_bulletaccuracy", 1);
}

setquickswap() {
  level.player setperk("specialty_quickswap", 1);
}

unsetquickswap() {
  level.player unsetperk("specialty_quickswap", 1);
}

_id_F712() {
  level.player setperk("specialty_reducedsway", 1);
  level.player setviewkickscale(0.35);
}

_id_12CBE() {
  level.player unsetperk("specialty_reducedsway", 1);
  level.player setviewkickscale(1.0);
}

_id_F80F() {
  level.player setperk("specialty_quickdraw", 1);
}

_id_12D12() {
  level.player unsetperk("specialty_quickdraw", 1);
}

_id_F636() {
  level.player setperk("specialty_sprintfire", 1);
}

_id_12C6F() {
  level.player unsetperk("specialty_sprintfire", 1);
}

setextraequipment() {
  _id_0B2A::_id_6240(1);
}

unsetextraequipment() {
  _id_0B2A::_id_6240(0);
}

setblastshield() {
  level.player setperk("specialty_explosivearmor", 1);
}

unsetblastshield() {
  level.player unsetperk("specialty_explosivearmor", 1);
}

_id_F700() {
  scripts\sp\gameskill::_id_F52D(0.85, 0.75);
  scripts\sp\gameskill::_id_12E5A();
}

_id_12CBB() {
  scripts\sp\gameskill::_id_F52D(1.0, 1.0);
  scripts\sp\gameskill::_id_12E5A();
}

_id_F849() {
  if(isDefined(self.perks) && isDefined(self.perks["specialty_shocker"]))
    self.perks["specialty_shocker"] = undefined;

  scripts\sp\utility::_id_13705();
  scripts\sp\utility::_id_12641("weapon_iw7_knife_perk_tr");
  scripts\sp\utility::_id_82EA("iw7_knife_perk");
}

_id_12D2F() {
  scripts\sp\utility::_id_1143E();
}

_id_F83E() {
  if(isDefined(self.perks) && isDefined(self.perks["specialty_slasher"]))
    self.perks["specialty_slasher"] = undefined;

  scripts\sp\utility::_id_13705();
  scripts\sp\utility::_id_12641("weapon_iw7_knife_upgrade1_tr");
  scripts\sp\utility::_id_82EA("iw7_knife_upgrade1");
}

_id_12D2A() {
  scripts\sp\utility::_id_1143E();
}

_id_11314(var_0, var_1, var_2) {
  level.player endon("death");
  level.player endon(var_2);
  var_3 = level.player getweaponslistall();

  if(scripts\engine\utility::array_contains(var_3, var_0)) {
    level.player takeweapon(var_0);
    level.player giveweapon(var_1);
  }

  for(;;) {
    level.player waittill("equipment_change");
    var_3 = level.player getweaponslistall();

    if(scripts\engine\utility::array_contains(var_3, var_0)) {
      level.player takeweapon(var_0);
      level.player giveweapon(var_1);
    }
  }
}

_id_E0A3(var_0, var_1) {
  var_2 = level.player getweaponslistall();

  if(scripts\engine\utility::array_contains(var_2, var_1)) {
    level.player takeweapon(var_1);
    level.player giveweapon(var_0);
  }
}

_id_FAB8() {
  thread _id_11314("frag", "frag_up1", "unsetUpgradeFrag1");
}

_id_12D5A() {
  level.player notify("unsetUpgradeFrag1");
  thread _id_E0A3("frag", "frag_up1");
}

_id_FAB9() {
  _id_FAB8();
  level.player._id_735A = 1;
}

_id_12D5B() {
  _id_12D5A();
  level.player._id_735A = undefined;
}

_id_FAC0() {
  level.player._id_612D._id_4A6D = 0.5;
  level.player._id_612D._id_4A6C = 0.75;
  level.player._id_612D._id_4A6E = 0.1;
  level.player._id_612D._id_12F6D = 1;
}

_id_12D62() {
  level.player._id_612D._id_4A6D = 0.35;
  level.player._id_612D._id_4A6C = 0.6;
  level.player._id_612D._id_4A6E = 0.2;
  level.player._id_612D._id_12F6D = 0;
}

_id_FAC1() {
  level.player._id_612D._id_12F6D = 2;
}

_id_12D63() {
  level.player._id_612D._id_12F6D = 0;
}

_id_FAB2() {
  level.player._id_202A = 1;
}

_id_12D54() {
  level.player._id_202A = undefined;
}

_id_FAB3() {
  _id_FAB2();
  level.player._id_202B = 1;
}

_id_12D55() {
  _id_12D54();
  level.player._id_202B = undefined;
}

_id_FABC() {
  level.player._id_F179._id_45BF = 1;
}

_id_12D5E() {
  level.player._id_F179._id_45BF = 0;
}

_id_FABD() {
  _id_FABC();
  level.player._id_F179._id_9076 = 1;
}

_id_12D5F() {
  _id_12D5E();
  level.player._id_F179._id_9076 = 0;
}

_id_FABA() {
  level.player._id_885E = 1;
  level.player._id_885D = 1;
}

_id_12D5C() {
  level.player._id_885E = undefined;
  level.player._id_885D = undefined;
}

_id_FABE() {
  level.player notify("unsetUpgradeShield1");
  thread _id_11314("offhandshield", "offhandshield_up1", "unsetUpgradeShield1");
  level.player._id_C337._id_9936 = 1;
}

_id_12D60() {
  level.player notify("unsetUpgradeShield1");
  thread _id_E0A3("offhandshield", "offhandshield_up1");
  level.player._id_C337._id_9936 = 0;
}

_id_FAB6() {
  level.player._id_5CB3 = 1;
  thread _id_11314("supportdrone", "supportdrone_up2", "unsetUpgradeDrone1");
}

_id_12D58() {
  level.player._id_5CB3 = undefined;
  level.player notify("unsetUpgradeDrone1");
  thread _id_E0A3("supportdrone", "supportdrone_up2");
}

_id_FAB4() {
  level.player._id_4759._id_389C = 1;
}

_id_12D56() {
  level.player._id_4759._id_389C = 0;
}