/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_armor.gsc
***********************************************/

main() {
  level.onhelmetsniped = ::onhelmetsniped;
}

initarmor() {
  self.br_armorhealth = 0;
  self.br_maxarmorhealth = 150;
  self setclientomnvar("ui_armor_percent", 0);
  scripts\mp\equipment\armor_plate::br_armor_plate_amount_equipped_set(0);
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::brdpadcallback);
}

brdpadcallback(_id_EA3E3B2121E6713A, _id_E1D097C517C3AF5B) {
  if(isDefined(_id_EA3E3B2121E6713A) && _id_EA3E3B2121E6713A == "try_use_heal_slot")
    _id_57D8F859DC2DD35D = _id_E1D097C517C3AF5B;
}

getoldarmorent(_id_B66C691C7EFB8A01) {
  pickup = spawnStruct();
  pickup.count = 1;
  pickup.maxcount = 1;
  pickup.stackable = 1;

  if(_id_2CEDCC356F1B9FC8::ishelmet(_id_B66C691C7EFB8A01.scriptablename)) {} else if(_id_7E52B56769FA7774::isgasmask(_id_B66C691C7EFB8A01.scriptablename))
    pickup.gasmaskhealth = self.gasmaskhealth;
  else
    pickup.armorhealth = self.br_armorhealth;

  return pickup;
}

helmetitemtypeforlevel(_id_9FB8A8EE3A677CEA) {
  switch (_id_9FB8A8EE3A677CEA) {
    case 1:
      return "brloot_armor_helmet_1";
    case 2:
      return "brloot_armor_helmet_2";
    case 3:
      return "brloot_armor_helmet_3";
  }

  return undefined;
}

givestartingarmor(_id_25D647AF59249079) {
  if(isDefined(_id_25D647AF59249079))
    _id_9A5097FE8A19DCFD = _id_25D647AF59249079;
  else
    _id_9A5097FE8A19DCFD = 100;

  if(getdvarint("scr_br_alt_mode_gg", 0))
    _id_9A5097FE8A19DCFD = 150;

  _id_4FB4B206A997692D = getdvarint("dvar_6F491F10C40CF0A9", -1);

  if(_id_4FB4B206A997692D >= 0)
    _id_9A5097FE8A19DCFD = _id_4FB4B206A997692D;

  givearmorvalue(_id_9A5097FE8A19DCFD);
}

givearmorvalue(value) {
  if(!isDefined(value) || value < 0) {
    return;
  }
  self.br_armorhealth = value;
  self.br_maxarmorhealth = 150;
  _id_CE50C3E3E9D89E29 = self.br_armorhealth / self.br_maxarmorhealth;
  self setclientomnvar("ui_armor_percent", _id_CE50C3E3E9D89E29);
  scripts\mp\equipment\armor_plate::br_armor_plate_amount_equipped_set(self.br_armorhealth);
}

takehelmet(_id_73B1997698AE0DEB, _id_9FB8A8EE3A677CEA) {
  self.br_helmetlevel = _id_9FB8A8EE3A677CEA;
  _id_CB89110314447B2F = level.br_pickups.br_itemrow[_id_73B1997698AE0DEB.scriptablename];

  if(self.br_helmetlevel == 3)
    scripts\mp\utility\perk::giveperk("specialty_stun_resistance");
}

breakarmor() {
  _id_07C40FA80892A721::damagearmor(self.br_armorhealth, 1);
}

isarmorbetterthanequipped(_id_DBD090CC010CD89B) {
  _id_9FB8A8EE3A677CEA = 0;

  if(_id_DBD090CC010CD89B == "equip_helmet_1")
    _id_9FB8A8EE3A677CEA = 1;
  else if(_id_DBD090CC010CD89B == "equip_helmet_2")
    _id_9FB8A8EE3A677CEA = 2;
  else if(_id_DBD090CC010CD89B == "equip_helmet_3")
    _id_9FB8A8EE3A677CEA = 3;

  if(_id_9FB8A8EE3A677CEA > 0) {
    if(!isDefined(self.br_helmetlevel) || self.br_helmetlevel < _id_9FB8A8EE3A677CEA)
      return 1;
  }

  return 0;
}

popoffhelmet(_id_483B72BBC1109AB2, _id_3C70A7175FBFA3FC, playerorigin) {
  level endon("game_ended");
  _id_332F92D26F25D2BC = self gettagorigin("j_helmet");

  if(!isDefined(_id_332F92D26F25D2BC))
    _id_332F92D26F25D2BC = playerorigin + (0, 0, 80);

  helmet = spawn("script_model", self gettagorigin("j_helmet"));
  helmet setModel("loot_helmet");
  helmet.angles = _id_3C70A7175FBFA3FC;
  up = anglestoup(_id_3C70A7175FBFA3FC);
  forward = _id_483B72BBC1109AB2;
  vel = vectorNormalize(forward + up) * 2500;
  helmet physicslaunchserver(helmet.origin, vel);
  _id_73B1997698AE0DEB = "brloot_armor_helmet_" + self.br_helmetlevel;
  _id_29511A1C049E1067 = 15;
  _id_F246E6DC812FBCFE = 0.1;
  _id_29511A1C049E1067 = _id_29511A1C049E1067 * (1 / _id_F246E6DC812FBCFE);
  _id_30226C918113271E = helmet.origin;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_29511A1C049E1067; _id_AC0E594AC96AA3A8++) {
    wait(_id_F246E6DC812FBCFE);
    _id_76A2EA10CCBC4C62 = _id_30226C918113271E - helmet.origin;

    if(_id_76A2EA10CCBC4C62[0] < 2 && _id_76A2EA10CCBC4C62[1] < 2 && _id_76A2EA10CCBC4C62[2] < 2 && _id_76A2EA10CCBC4C62[0] > -2 && _id_76A2EA10CCBC4C62[1] > -2 && _id_76A2EA10CCBC4C62[2] > -2) {
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(helmet.origin, helmet.angles);
      helmet delete();
      pickupent = _id_7E52B56769FA7774::spawnpickup(_id_73B1997698AE0DEB, _id_CB4FAD49263E20C4);
      pickupent.count = 1;
      return;
    }

    _id_30226C918113271E = helmet.origin;
  }

  helmet delete();
}

onhelmetsniped(victim, _id_483B72BBC1109AB2) {
  if(isDefined(victim))
    victim thread popoffhelmet(_id_483B72BBC1109AB2, victim.angles, victim.origin);
}

_id_BCB1D5FB674FA3A0() {
  if(isDefined(self.armorhealth)) {
    _id_CE50C3E3E9D89E29 = self.armorhealth / 150;
    scripts\mp\codcasterclientmatchdata::_id_F8B808CD6473E6CC(18, _id_CE50C3E3E9D89E29);
  }
}