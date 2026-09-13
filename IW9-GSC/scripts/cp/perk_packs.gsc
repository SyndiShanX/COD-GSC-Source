/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\perk_packs.gsc
***********************************************/

_id_9DE497922EA1A6BF() {
  level._id_B3CBB613D49FF5A3 = [];
  level._id_E23F2A9C37C8597C = [];
  _id_B3C5BA25A66D7CE9("perk_pack_speedy", ::_id_FA0BB7D172F87C23, ::_id_494742BEBD999D7A);
  _id_B3C5BA25A66D7CE9("perk_pack_buff", ::_id_B206A39197180C92, ::_id_9F0BAC6BDEA9712F);
  _id_B3C5BA25A66D7CE9("perk_pack_mule", ::_id_581E926068AD6972, ::_id_E772D952AD274643);
  _id_B3C5BA25A66D7CE9("perk_pack_medic", ::_id_0A7AC939F2C1D839, ::_id_ED6749412E69FE02);
  _id_B3C5BA25A66D7CE9("perk_pack_ammo_buff", ::_id_0F4E87426380BE51, ::_id_54F94DDCC1F58996);
  _id_B3C5BA25A66D7CE9("perk_pack_armor_buff", ::_id_448CEA0F7C6FBF36, ::_id_77EB1D81D0F5E81F);
}

_id_645EB4E3639DE90D() {
  if(!isDefined(self._id_1EB38C7058EDF8E0)) {
    self._id_1EB38C7058EDF8E0 = [];
    self._id_C50870864FD5FA67 = 4;
    _id_10BE613F34FF473A();
  }
}

_id_B3C5BA25A66D7CE9(_id_42695DC3BF559617, setfunc, unsetfunc) {
  if(isDefined(setfunc))
    level._id_B3CBB613D49FF5A3[_id_42695DC3BF559617] = setfunc;

  if(isDefined(unsetfunc))
    level._id_E23F2A9C37C8597C[_id_42695DC3BF559617] = unsetfunc;
}

_id_10BE613F34FF473A() {
  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++) {
    self._id_1EB38C7058EDF8E0[_id_AC0E594AC96AA3A8] = spawnStruct();
    self._id_1EB38C7058EDF8E0[_id_AC0E594AC96AA3A8]._id_E0250163954DE501 = 0;
    self._id_1EB38C7058EDF8E0[_id_AC0E594AC96AA3A8]._id_7DE943E918BC4562 = "none";
  }
}

_id_EB542C381F315290() {
  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < self._id_C50870864FD5FA67 + 1; _id_AC0E594AC96AA3A8++) {
    if(self._id_1EB38C7058EDF8E0[_id_AC0E594AC96AA3A8]._id_7DE943E918BC4562 == "none")
      return _id_AC0E594AC96AA3A8;
  }

  return 0;
}

_id_E752C81048E56E3C(slot, _id_E0250163954DE501) {
  if(isDefined(_id_E0250163954DE501))
    self._id_1EB38C7058EDF8E0[slot]._id_E0250163954DE501 = _id_E0250163954DE501;
}

_id_DFCEFFB521D7D4CB(perkname) {
  switch (perkname) {
    case "specialty_hustle":
      return "perk_pack_mule";
    case "medic":
      return "perk_pack_medic";
    case "specialty_eod":
      return "perk_pack_buff";
    case "specialty_quick_fix":
      return "perk_pack_mule";
    default:
      return "perk_pack_speed";
  }
}

_id_7184B43950D947EA(_id_5C210D26D98203D3, slot, _id_E0250163954DE501) {
  omnvar = undefined;

  if(slot == 1)
    omnvar = "ui_spawn_perk_0";
  else if(slot == 2)
    omnvar = "ui_spawn_perk_1";
  else if(slot == 3)
    omnvar = "ui_spawn_perk_2";
  else if(slot == 4)
    omnvar = "ui_spawn_perk_3";

  if(_id_5C210D26D98203D3 != "none") {
    if(isDefined(omnvar)) {
      _id_24DB96216C5F6124 = int(tablelookup("cp/perk_pack_table.csv", 1, _id_5C210D26D98203D3, 0));

      if(isDefined(_id_24DB96216C5F6124))
        self setclientomnvar(omnvar, _id_24DB96216C5F6124);
    }
  } else
    self setclientomnvar(omnvar, -1);
}

_id_74320E884B9A3FD8(_id_7DE943E918BC4562) {
  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < self._id_C50870864FD5FA67 + 1; _id_AC0E594AC96AA3A8++) {
    if(self._id_1EB38C7058EDF8E0[_id_AC0E594AC96AA3A8]._id_7DE943E918BC4562 == _id_7DE943E918BC4562)
      return self._id_1EB38C7058EDF8E0[_id_AC0E594AC96AA3A8]._id_E0250163954DE501;
  }

  return 0;
}

_id_8F03ACC557E2B610(_id_7DE943E918BC4562) {
  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < self._id_C50870864FD5FA67 + 1; _id_AC0E594AC96AA3A8++) {
    if(self._id_1EB38C7058EDF8E0[_id_AC0E594AC96AA3A8]._id_7DE943E918BC4562 == _id_7DE943E918BC4562)
      return 1;
  }

  return 0;
}

_id_F82E41138806E225() {
  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < self._id_C50870864FD5FA67 + 1; _id_AC0E594AC96AA3A8++) {
    if(self._id_1EB38C7058EDF8E0[_id_AC0E594AC96AA3A8]._id_7DE943E918BC4562 == "none")
      return 0;
  }

  return 1;
}

_id_DE2C47C49E185540(_id_7DE943E918BC4562) {
  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < self._id_C50870864FD5FA67 + 1; _id_AC0E594AC96AA3A8++) {
    if(self._id_1EB38C7058EDF8E0[_id_AC0E594AC96AA3A8]._id_7DE943E918BC4562 == _id_7DE943E918BC4562)
      return _id_AC0E594AC96AA3A8;
  }

  return 0;
}

_id_09AB372B1DC1A8E3() {
  slot = 0;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < self._id_C50870864FD5FA67 + 1; _id_AC0E594AC96AA3A8++) {
    if(self._id_1EB38C7058EDF8E0[_id_AC0E594AC96AA3A8]._id_7DE943E918BC4562 == "none")
      slot = _id_AC0E594AC96AA3A8;
  }

  return slot;
}

_id_7F62B61FC20B6540(_id_B8237431C9AA7E36) {
  return self._id_1EB38C7058EDF8E0[_id_B8237431C9AA7E36]._id_7DE943E918BC4562;
}

_id_47AE9E67FAFC2FC4(_id_B8237431C9AA7E36, _id_D1FC596F54BECC5A) {
  _id_EFBE3CB0D8D22512 = _id_7F62B61FC20B6540(_id_B8237431C9AA7E36);
  _id_7175C0FBCE3FED06(_id_EFBE3CB0D8D22512);
  _id_9DFBC3169C4FB507(_id_D1FC596F54BECC5A, 3);
}

_id_6906DAB2C6805A25(_id_7DE943E918BC4562, _id_E0250163954DE501) {
  slot = _id_DE2C47C49E185540(_id_7DE943E918BC4562);

  if(slot > 0) {
    _id_8FF4765EAC369993 = _id_74320E884B9A3FD8(_id_7DE943E918BC4562);

    if(_id_8FF4765EAC369993 < 2)
      _id_E752C81048E56E3C(slot, _id_E0250163954DE501);
  }
}

_id_9DFBC3169C4FB507(_id_7DE943E918BC4562, _id_E0250163954DE501) {
  slot = _id_EB542C381F315290();

  if(slot != 0) {
    self._id_1EB38C7058EDF8E0[slot]._id_7DE943E918BC4562 = _id_7DE943E918BC4562;
    _id_E752C81048E56E3C(slot, _id_E0250163954DE501);
    _id_7184B43950D947EA(_id_7DE943E918BC4562, slot, _id_E0250163954DE501);
    self[[level._id_B3CBB613D49FF5A3[_id_7DE943E918BC4562]]](_id_E0250163954DE501);
  }
}

_id_083829CDB2347C8F() {
  _id_7175C0FBCE3FED06("perk_pack_speedy");
  _id_7175C0FBCE3FED06("perk_pack_buff");
  _id_7175C0FBCE3FED06("perk_pack_medic");
  _id_7175C0FBCE3FED06("perk_pack_mule");
  _id_A201DBDAEC933AE6();
}

_id_7175C0FBCE3FED06(_id_7DE943E918BC4562) {
  for(slot = 1; slot < self._id_C50870864FD5FA67 + 1; slot++) {
    if(self._id_1EB38C7058EDF8E0[slot]._id_7DE943E918BC4562 == _id_7DE943E918BC4562) {
      self._id_1EB38C7058EDF8E0[slot]._id_7DE943E918BC4562 = "none";
      self._id_1EB38C7058EDF8E0[slot]._id_E0250163954DE501 = 0;
      _id_7184B43950D947EA("none", slot, 0);
      self[[level._id_E23F2A9C37C8597C[_id_7DE943E918BC4562]]](0);
    }
  }
}

_id_ED49C972DAEB7575() {
  self._id_C50870864FD5FA67 = 2;
}

_id_A201DBDAEC933AE6() {
  self._id_C50870864FD5FA67 = 4;
}

_id_3CF76F4DAB9DC93C() {
  if(self._id_C50870864FD5FA67 == 2)
    return 1;

  return 0;
}

_id_FA0BB7D172F87C23(_id_E0250163954DE501) {
  scripts\cp\utility::giveperk("specialty_hustle");
  scripts\cp\utility::giveperk("specialty_fastcrouchmovement");
  scripts\cp\utility::giveperk("specialty_stalker");
  scripts\cp\utility::giveperk("specialty_fastreload");
  scripts\cp\utility::giveperk("specialty_tactical_recon");
  scripts\cp\utility::giveperk("specialty_warhead");
}

_id_494742BEBD999D7A(_id_E0250163954DE501) {
  scripts\cp\utility::takeperk("specialty_hustle");
  scripts\cp\utility::takeperk("specialty_fastcrouchmovement");
  scripts\cp\utility::takeperk("specialty_stalker");
  scripts\cp\utility::takeperk("specialty_fastreload");
  scripts\cp\utility::takeperk("specialty_tactical_recon");
  scripts\cp\utility::takeperk("specialty_warhead");
}

_id_0A7AC939F2C1D839(_id_E0250163954DE501) {
  scripts\cp\utility::giveperk("specialty_fast_health_regen");
  scripts\cp\utility::giveperk("specialty_quick_revive");
}

_id_ED6749412E69FE02(_id_E0250163954DE501) {
  scripts\cp\utility::takeperk("specialty_fast_health_regen");
  scripts\cp\utility::takeperk("specialty_quick_revive");
}

_id_0F4E87426380BE51(_id_E0250163954DE501) {
  _id_1B4ADA49A21B51CA = "cp_super_ammo_used";
  scripts\cp\cp_hud_message::showsplash(_id_1B4ADA49A21B51CA, undefined, self);
  self setclientomnvar("ui_ammo_class_power_on", gettime());
  scripts\cp\utility::giveperk("specialty_bulletdamage");
}

_id_54F94DDCC1F58996(_id_E0250163954DE501) {
  scripts\cp\utility::takeperk("specialty_bulletdamage");
  self setclientomnvar("ui_ammo_class_power_off", gettime());
}

_id_448CEA0F7C6FBF36(_id_E0250163954DE501) {
  _id_1B4ADA49A21B51CA = "cp_super_armor_used";
  _id_C791EAD1F39669F4 = self._id_4CB4A6EBD0885FFD;
  _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(_id_C791EAD1F39669F4);
  self.old_armor_scalar = _id_6E09A830FAB9468F::get_perk("enemy_damage_to_player_armor_scalar");
  _id_6E09A830FAB9468F::set_perk("enemy_damage_to_player_armor_scalar", self.old_armor_scalar * 1.5);
  self._id_C99DB8962A6B36BB = 1;
  _id_018C9036DC9A4081::_id_E0D47DE3DF5F23EA();
}

_id_77EB1D81D0F5E81F(_id_E0250163954DE501) {
  _id_6E09A830FAB9468F::set_perk("enemy_damage_to_player_armor_scalar", self.old_armor_scalar);
  self._id_C99DB8962A6B36BB = 0;
  _id_018C9036DC9A4081::_id_E0D47DE3DF5F23EA();
}

_id_B206A39197180C92(_id_E0250163954DE501) {
  scripts\cp\utility::giveperk("specialty_extra_armor");
  _id_018C9036DC9A4081::_id_8CE284D6441202B8(_id_E0250163954DE501);
  _id_079287CC290242A2(self, _id_E0250163954DE501);
  scripts\cp\utility::giveperk("specialty_eod");
}

_id_9F0BAC6BDEA9712F(_id_E0250163954DE501) {
  scripts\cp\utility::takeperk("specialty_extra_armor");
  _id_018C9036DC9A4081::_id_8CE284D6441202B8(0);
  _id_079287CC290242A2(self, 0);
  scripts\cp\utility::takeperk("specialty_eod");
}

_id_079287CC290242A2(player, _id_E0250163954DE501) {
  _id_1DAB4A6BAD01C509 = player getentitynumber();
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "hivesdestroyed", _id_E0250163954DE501);
}

_id_581E926068AD6972(_id_E0250163954DE501) {
  scripts\cp\utility::giveperk("specialty_extra_weapon");
  scripts\cp\utility::giveperk("specialty_armor_satchel");
  self setclientomnvar("ui_br_has_plate_pouch", 1);
  scripts\cp\utility::giveperk("specialty_extra_shrapnel");
}

_id_E772D952AD274643(_id_E0250163954DE501) {
  scripts\cp\utility::takeperk("specialty_extra_weapon");
  scripts\cp\utility::takeperk("specialty_armor_satchel");
  self setclientomnvar("ui_br_has_plate_pouch", 0);
  scripts\cp\utility::takeperk("specialty_extra_shrapnel");
  _id_03E9CE650EBB5CEE();
}

_id_03E9CE650EBB5CEE() {
  _id_BC002676438672C9 = self getweaponslistprimaries();
  _id_388F7437F9B4BA85 = 0;
  self._id_419B06083E47444D = [];

  foreach(weapon in _id_BC002676438672C9) {
    if(weapon.inventorytype == "primary") {
      self._id_419B06083E47444D[_id_388F7437F9B4BA85] = weapon;
      _id_388F7437F9B4BA85 = _id_388F7437F9B4BA85 + 1;
    }
  }

  if(_id_388F7437F9B4BA85 >= 3) {
    _id_CCA6009E1ACB40ED = scripts\engine\utility::random(self._id_419B06083E47444D);

    if(isDefined(_id_CCA6009E1ACB40ED))
      self takeweapon(_id_CCA6009E1ACB40ED);
  }
}

_id_E5EA666722BE9CD0(num) {
  if(!isDefined(num))
    num = 4;

  if(scripts\cp\utility::_hasperk("specialty_extra_shrapnel"))
    num = num + 2;

  return num;
}