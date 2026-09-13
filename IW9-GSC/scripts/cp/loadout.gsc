/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\loadout.gsc
***********************************************/

init() {
  thread _id_E3D92C3C4D45ADD1();
  _id_4A1D700183A5A33D(1);
  _id_B82B35CA0F5529AA(1);
  initoperatorcustomization();
  level.available_player_characters = [];
  level.player_character_info = [];
  level.playercustomizationdata = [];
  level.custom_giveloadout = ::givedefaultloadout;
  level.move_speed_scale = ::updatemovespeedscale;
  level.registerplayercharfunc = ::registerplayercharacter;
  level.classtablename = "classtable:classtable";

  if(!isDefined(level.loadoutsgroup))
    level.loadoutsgroup = scripts\cp\utility::getplayerdataloadoutgroup();

  level._id_36074F5DB982129D = [];
  level._id_B2640B98DEE64871 = [];
  _id_14609B809484646E::_id_8ECE37593311858A(::_id_8597534AFC6FE0D2);
  initnightvisionheadoverrides();
}

_id_376BE2185B817BCF() {
  if(level.script == "cp_raid1" || level.script == "cp_raid1_trap")
    return ["gaz_western", "farah_western", "price_western"];

  return ["farah_western", "price_western", "alex_western"];
}

_id_E3D92C3C4D45ADD1() {
  _id_B6217B906C6BE73E = _id_376BE2185B817BCF();
  _id_92E71940E0DBF66C = [];
  table = "operators.csv";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B6217B906C6BE73E.size; _id_AC0E594AC96AA3A8++) {
    _id_9C9265C6D4356BC6 = tablelookup(table, 1, _id_B6217B906C6BE73E[_id_AC0E594AC96AA3A8], 0);
    struct = spawnStruct();

    if(_id_B6217B906C6BE73E[_id_AC0E594AC96AA3A8] == "farah_western")
      struct._id_9C9265C6D4356BC6 = tablelookup("operatorskins.csv", 1, "farah_western_raid", 0);

    if(_id_B6217B906C6BE73E[_id_AC0E594AC96AA3A8] == "gaz_western")
      struct._id_9C9265C6D4356BC6 = tablelookup("operatorskins.csv", 1, "gaz_western_raid", 0);

    if(_id_B6217B906C6BE73E[_id_AC0E594AC96AA3A8] == "price_western")
      struct._id_9C9265C6D4356BC6 = tablelookup("operatorskins.csv", 1, "price_western_raid", 0);

    if(_id_B6217B906C6BE73E[_id_AC0E594AC96AA3A8] == "alex_western")
      struct._id_9C9265C6D4356BC6 = tablelookup("operatorskins.csv", 1, "alex_western", 0);

    struct.name = _id_B6217B906C6BE73E[_id_AC0E594AC96AA3A8];
    _id_92E71940E0DBF66C[_id_AC0E594AC96AA3A8] = struct;
  }

  level._id_C2F521F34F3E9A27 = scripts\engine\utility::create_deck(_id_92E71940E0DBF66C, 1, 1, 1);
}

_id_6E059A1906778EC6() {
  _id_B6217B906C6BE73E = ["farah_western"];
  _id_92E71940E0DBF66C = [];
  table = "operators.csv";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B6217B906C6BE73E.size; _id_AC0E594AC96AA3A8++) {
    _id_9C9265C6D4356BC6 = tablelookup(table, 1, _id_B6217B906C6BE73E[_id_AC0E594AC96AA3A8], 0);
    struct = spawnStruct();
    struct._id_9C9265C6D4356BC6 = int(tablelookup("operatorskins.csv", 1, "farah_western_raid", 0));
    struct.name = _id_B6217B906C6BE73E[_id_AC0E594AC96AA3A8];
    _id_92E71940E0DBF66C[_id_AC0E594AC96AA3A8] = struct;
  }

  return _id_92E71940E0DBF66C[0];
}

_id_6A4BCCFCE8AAF66C() {
  _id_B6217B906C6BE73E = ["gaz_western"];
  _id_92E71940E0DBF66C = [];
  table = "operators.csv";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B6217B906C6BE73E.size; _id_AC0E594AC96AA3A8++) {
    _id_9C9265C6D4356BC6 = tablelookup(table, 1, _id_B6217B906C6BE73E[_id_AC0E594AC96AA3A8], 0);
    struct = spawnStruct();
    struct._id_9C9265C6D4356BC6 = int(tablelookup("operatorskins.csv", 1, "gaz_western_raid", 0));
    struct.name = _id_B6217B906C6BE73E[_id_AC0E594AC96AA3A8];
    _id_92E71940E0DBF66C[_id_AC0E594AC96AA3A8] = struct;
  }

  return _id_92E71940E0DBF66C[0];
}

_id_ED1C871CABC1FE60() {
  _id_B6217B906C6BE73E = ["alex_western"];
  _id_92E71940E0DBF66C = [];
  table = "operators.csv";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B6217B906C6BE73E.size; _id_AC0E594AC96AA3A8++) {
    _id_9C9265C6D4356BC6 = tablelookup(table, 1, _id_B6217B906C6BE73E[_id_AC0E594AC96AA3A8], 0);
    struct = spawnStruct();
    struct._id_9C9265C6D4356BC6 = int(tablelookup("operatorskins.csv", 1, "alex_western_a", 0));
    struct.name = _id_B6217B906C6BE73E[_id_AC0E594AC96AA3A8];
    _id_92E71940E0DBF66C[_id_AC0E594AC96AA3A8] = struct;
  }

  return _id_92E71940E0DBF66C[0];
}

_id_DB14ADEFCB598305() {
  _id_B6217B906C6BE73E = ["price_western"];
  _id_92E71940E0DBF66C = [];
  table = "operators.csv";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B6217B906C6BE73E.size; _id_AC0E594AC96AA3A8++) {
    _id_9C9265C6D4356BC6 = tablelookup(table, 1, _id_B6217B906C6BE73E[_id_AC0E594AC96AA3A8], 0);
    struct = spawnStruct();
    struct._id_9C9265C6D4356BC6 = int(tablelookup("operatorskins.csv", 1, "price_western_raid", 0));
    struct.name = _id_B6217B906C6BE73E[_id_AC0E594AC96AA3A8];
    _id_92E71940E0DBF66C[_id_AC0E594AC96AA3A8] = struct;
  }

  return _id_92E71940E0DBF66C[0];
}

_id_8597534AFC6FE0D2() {
  if(scripts\cp\utility::_id_138028CA2B958511()) {
    self._id_DC196D396886FB97 = _id_FBAC9497C03A0C89();
    self.pers["operator_override"] = self._id_DC196D396886FB97;
  }

  _id_66122A002AFF5D57::_id_2D55E66E05614871();
}

_id_FBAC9497C03A0C89() {
  if(getDvar("dvar_22221466D25E507C", "") != "" && !istrue(level._id_0C198402C3D81AD9)) {
    level._id_0C198402C3D81AD9 = 1;
    return _id_03EF470F786D308B();
  }

  if(isDefined(self.pers["operator_override"]))
    return _id_03EF470F786D308B(self.pers["operator_override"]);

  if(!isDefined(level.farah)) {
    level.farah = self;
    return _id_6E059A1906778EC6();
  }

  if(!isDefined(level.price)) {
    level.price = self;
    return _id_DB14ADEFCB598305();
  }

  if(!isDefined(level._id_E0632103DFA5BB19) && _id_6809A05D2C7CF04A()) {
    level._id_E0632103DFA5BB19 = self;
    return _id_6A4BCCFCE8AAF66C();
  }

  if(!isDefined(level.alex) && _id_79C69B5F0766F2A8()) {
    level.alex = self;
    return _id_ED1C871CABC1FE60();
  }
}

_id_6809A05D2C7CF04A() {
  return level.script == "cp_raid1" || level.script == "cp_raid1_trap";
}

_id_79C69B5F0766F2A8() {
  return level.script == "cp_raid1_boss1" || level.script == "cp_jugg_maze";
}

_id_03EF470F786D308B(_id_64317638DAAC04E1) {
  _id_30886334D5498514 = undefined;

  if(isDefined(_id_64317638DAAC04E1))
    _id_30886334D5498514 = _id_64317638DAAC04E1.name;

  if(!isDefined(_id_30886334D5498514))
    _id_30886334D5498514 = tolower(getDvar("dvar_22221466D25E507C"));

  switch (_id_30886334D5498514) {
    case "farah_western":
    case "farah":
      level.farah = self;
      return _id_6E059A1906778EC6();
    case "price_western":
    case "price":
      level.price = self;
      return _id_DB14ADEFCB598305();
    case "gaz_western":
    case "gaz":
      level._id_E0632103DFA5BB19 = self;
      return _id_6A4BCCFCE8AAF66C();
    case "alex_western":
    case "alex":
      level.alex = self;
      return _id_ED1C871CABC1FE60();
    case "default":
      return;
  }
}

initnightvisionheadoverrides() {
  if(!scripts\cp\utility::_id_6AAFBDD00B977115()) {
    return;
  }
  level.nvgheadoverrides = [];
  _id_962EF6817910EC78 = 0;

  for(;;) {
    head = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 5);
    _id_8CAF1716B3192F8F = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 17);
    _id_F164251D2631366A = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 16);

    if(!isDefined(head) || head == "") {
      break;
    }

    if(_id_8CAF1716B3192F8F != "")
      level.nvgheadoverrides[head]["up"] = _id_8CAF1716B3192F8F;

    if(_id_F164251D2631366A != "")
      level.nvgheadoverrides[head]["down"] = _id_F164251D2631366A;

    _id_962EF6817910EC78++;
  }

  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_1"]["up"] = "nvg_2";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_2"]["up"] = "nvg_2";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_3"]["up"] = "nvg_2";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_4"]["up"] = "nvg_2";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_lmg"]["up"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_nvg_1"]["down"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_nvg_1"]["up"] = "none";
}

givedefaultloadout(_id_86DB2022C4F0F4BF, _id_185EA69B2FE37360, _id_7CB3CE39E2414126, _id_9B02313FE7FF70DA) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self.gettingloadout = 1;
  self setclientomnvar("ui_options_menu", 0);

  if(istrue(self.is_doing_infil))
    self waittill("player_finished_infil");

  _id_2CC2B098AE66E28A = istestclient(self);
  scripts\cp\cp_accessories::clearplayeraccessory();
  self takeallweapons();
  scripts\cp\utility::_clearperks();
  setupplayermodel();
  scripts\engine\utility::flag_wait("introscreen_over");
  self notify("giveLoadout");
  scripts\cp\utility::giveperk("specialty_pistoldeath");
  self setperk("specialty_pistoldraw", 1);
  scripts\cp\utility::giveperk("specialty_hack");

  if(isDefined(_id_86DB2022C4F0F4BF) && _id_86DB2022C4F0F4BF) {
    self.gettingloadout = undefined;
    return;
  }

  if(!_id_2CC2B098AE66E28A && _id_B8339B310E7978A1() && _id_FF14B67DBA97FE88())
    _id_E37DF6C30163C181();
  else {
    if(!_id_2CC2B098AE66E28A) {
      give_weapons_from_loadout(_id_7CB3CE39E2414126, 1);

      if(isDefined(self.classstruct.loadoutaccessorydata) && isDefined(self.classstruct.loadoutaccessoryweapon) && self.classstruct.loadoutaccessoryweapon != "none")
        scripts\cp\cp_accessories::giveplayeraccessory(self.classstruct.loadoutaccessorydata, self.classstruct.loadoutaccessoryweapon, self.classstruct.loadoutaccessorylogic);
    }

    _id_777EAF15441A6BC6();
  }

  _id_601EE7C5E1B107F3();
  _id_A01818AE9EDECBE6();
  _id_A6EB74F88574F882();
  _id_37640F469A0BD7B4();

  if(!scripts\cp\utility::is_raid_gamemode())
    scripts\cp\utility::allow_player_basejumping(1, "giveDefaultLoadout");
  else
    scripts\cp\utility::allow_player_basejumping(0, "giveDefaultLoadout");

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.execution))
    scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);

  if(istrue(level.disable_nvg))
    self setactionslot(2, "");

  self setactionslot(3, "altmode");
  thread scripts\cp\utility::notify_delay("loadout_given", 0.05);
  self.changing_loadout = undefined;

  if(isDefined(self.operatorcustomization.clothtype) && self.operatorcustomization.clothtype != "")
    self setclothtype(self.operatorcustomization.clothtype);
  else
    self setclothtype("vestlight");

  if(isDefined(self.operatorcustomization._id_400EF51562606E7A) && self.operatorcustomization._id_400EF51562606E7A != "")
    self _meth_8ABE5A968CC3C220(self.operatorcustomization._id_400EF51562606E7A);
  else
    self _meth_8ABE5A968CC3C220("millghtgr");

  thread notify_when_loadout_given();

  if(!istestclient(self) && isDefined(level._id_5966C39CB60075F1))
    self[[level._id_5966C39CB60075F1]]();

  if(isDefined(level._id_0A980838233F4B37)) {
    if(isDefined(self._id_2A376311C6E39314)) {
      self._id_2A376311C6E39314 = undefined;
      self[[level._id_0A980838233F4B37]]();
    }
  }

  self.gettingloadout = undefined;
  thread _id_7DA7BD24B280D295(1);
}

_id_4A1D700183A5A33D(_id_E3108E412AFB3811) {
  level._id_E29974A766FB9885 = _id_E3108E412AFB3811;
}

_id_B82B35CA0F5529AA(_id_E3108E412AFB3811) {
  level._id_F44EAC8D457AA051 = _id_E3108E412AFB3811;
}

_id_B8339B310E7978A1() {
  return isDefined(self.pers) && isDefined(self.pers["loadout"]);
}

_id_FF14B67DBA97FE88() {
  return level._id_E29974A766FB9885;
}

_id_E37DF6C30163C181() {
  _id_45A6143A0A99851D(self);
}

give_weapons_from_loadout(_id_7CB3CE39E2414126, _id_168B196E80C44544) {
  struct = spawnStruct();
  _id_D0EF877013D341AF = spawnStruct();
  _id_A52C671ACCA08378 = cac_getloadoutselectedidx();

  if(isDefined(_id_7CB3CE39E2414126))
    _id_D0EF877013D341AF = loadout_updateclassdefault(struct, _id_7CB3CE39E2414126);
  else
    _id_D0EF877013D341AF = loadout_updateclasscustom(struct, _id_A52C671ACCA08378, _id_168B196E80C44544);

  _id_D0EF877013D341AF = _id_C03F8F1DC0DF9EAA(_id_D0EF877013D341AF);
  self.custom_loadout_index = _id_A52C671ACCA08378;
  self.classstruct = _id_D0EF877013D341AF;
  _id_210678FF7B05A155(_id_D0EF877013D341AF);
  _id_918C7D3ED87EA3E8 = _id_578FA1963D5F94AC(self, "primary", _id_D0EF877013D341AF);
  _id_F366AF1BB183316C = _id_F505F60C194B2770(_id_D0EF877013D341AF.loadoutequipmentprimary);

  if(!scripts\engine\utility::array_contains_key(level.equipment.table, _id_F366AF1BB183316C))
    _id_F366AF1BB183316C = "none";

  _id_DCA226EE1D93A538 = _id_578FA1963D5F94AC(self, "secondary", _id_D0EF877013D341AF);
  _id_5E7BDAD4B7D0C7AC = _id_F505F60C194B2770(_id_D0EF877013D341AF.loadoutequipmentsecondary);

  if(!scripts\engine\utility::array_contains_key(level.equipment.table, _id_5E7BDAD4B7D0C7AC))
    _id_5E7BDAD4B7D0C7AC = "none";

  _id_B8BA56B9EDD59CB7 = self getplayerdata("cp", "inventorySlots", "totalSlots");

  if(!istrue(level._id_A244732F8807FC19) && !istrue(self.changing_loadout)) {
    _id_644C18834356D9DC::reset_munitions(self, _id_B8BA56B9EDD59CB7);
    _id_644C18834356D9DC::assign_lowest_full_slot_to_active();
  }

  _id_7EF95BBA57DC4B82::giveequipment(_id_F366AF1BB183316C, "primary");
  _id_7EF95BBA57DC4B82::setequipmentammo(_id_F366AF1BB183316C, _id_918C7D3ED87EA3E8);
  _id_7EF95BBA57DC4B82::giveequipment(_id_5E7BDAD4B7D0C7AC, "secondary");
  _id_7EF95BBA57DC4B82::setequipmentammo(_id_5E7BDAD4B7D0C7AC, _id_DCA226EE1D93A538);
}

_id_210678FF7B05A155(_id_F961DA5EE5C149C1) {
  if(_id_F961DA5EE5C149C1.loadoutprimary == "none") {
    _id_F961DA5EE5C149C1.loadoutprimaryfullname = "none";
    _id_F961DA5EE5C149C1.loadoutprimaryobject = undefined;
  } else {
    _id_F961DA5EE5C149C1.loadoutprimaryobject = _id_2669878CF5A1B6BC::buildweapon(_id_F961DA5EE5C149C1.loadoutprimary, _id_F961DA5EE5C149C1.loadoutprimaryattachments, _id_F961DA5EE5C149C1.loadoutprimarycamo, _id_F961DA5EE5C149C1.loadoutprimaryreticle, _id_F961DA5EE5C149C1.loadoutprimaryvariantid, _id_F961DA5EE5C149C1.loadoutprimaryattachmentids, _id_F961DA5EE5C149C1.loadoutprimarycosmeticattachment, _id_F961DA5EE5C149C1.loadoutprimarystickers, istrue(_id_F961DA5EE5C149C1.loadouthasnvg));
    _id_F961DA5EE5C149C1.loadoutprimaryobject = give_weapon_alt_clip_ammo_hack(self, _id_F961DA5EE5C149C1.loadoutprimaryobject);
    _id_F961DA5EE5C149C1.loadoutprimaryfullname = getcompleteweaponname(_id_F961DA5EE5C149C1.loadoutprimaryobject);
  }

  if(_id_F961DA5EE5C149C1.loadoutsecondary == "none") {
    _id_F961DA5EE5C149C1.loadoutsecondaryfullname = "none";
    _id_F961DA5EE5C149C1.loadoutsecondaryobject = undefined;
  } else {
    _id_F961DA5EE5C149C1.loadoutsecondaryobject = _id_2669878CF5A1B6BC::buildweapon(_id_F961DA5EE5C149C1.loadoutsecondary, _id_F961DA5EE5C149C1.loadoutsecondaryattachments, _id_F961DA5EE5C149C1.loadoutsecondarycamo, _id_F961DA5EE5C149C1.loadoutsecondaryreticle, _id_F961DA5EE5C149C1.loadoutsecondaryvariantid, _id_F961DA5EE5C149C1.loadoutsecondaryattachmentids, _id_F961DA5EE5C149C1.loadoutsecondarycosmeticattachment, _id_F961DA5EE5C149C1.loadoutsecondarystickers, istrue(_id_F961DA5EE5C149C1.loadouthasnvg));
    _id_F961DA5EE5C149C1.loadoutsecondaryobject = give_weapon_alt_clip_ammo_hack(self, _id_F961DA5EE5C149C1.loadoutsecondaryobject);
    _id_F961DA5EE5C149C1.loadoutsecondaryfullname = getcompleteweaponname(_id_F961DA5EE5C149C1.loadoutsecondaryobject);
  }

  self.starting_weapon = _id_F961DA5EE5C149C1.loadoutprimaryobject;
  self.primaryweaponobj = self.starting_weapon;
  self.default_starting_pistol = _id_F961DA5EE5C149C1.loadoutsecondaryobject;
  self.secondaryweaponobj = self.default_starting_pistol;
}

loadout_updateclassdefault(struct, _id_089688461C79EF11) {
  self.class_num = _id_089688461C79EF11;
  struct.loadoutprimary = table_getweapon(level.classtablename, _id_089688461C79EF11, 0);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 5; _id_DF6D8E005B4B8020++)
    struct.loadoutprimaryattachments[_id_DF6D8E005B4B8020] = table_getweaponattachment(level.classtablename, _id_089688461C79EF11, 0, _id_DF6D8E005B4B8020);

  struct.loadoutprimarycamo = table_getweaponcamo(level.classtablename, _id_089688461C79EF11, 0);
  struct.loadoutprimaryreticle = table_getweaponreticle(level.classtablename, _id_089688461C79EF11, 0);
  struct.loadoutsecondary = table_getweapon(level.classtablename, _id_089688461C79EF11, 1);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 5; _id_DF6D8E005B4B8020++)
    struct.loadoutsecondaryattachments[_id_DF6D8E005B4B8020] = table_getweaponattachment(level.classtablename, _id_089688461C79EF11, 1, _id_DF6D8E005B4B8020);

  struct.loadoutsecondarycamo = table_getweaponcamo(level.classtablename, _id_089688461C79EF11, 1);
  struct.loadoutsecondaryreticle = table_getweaponreticle(level.classtablename, _id_089688461C79EF11, 1);
  struct.loadoutequipmentprimary = table_getequipmentprimary(level.classtablename, _id_089688461C79EF11);
  struct.loadoutextraequipmentprimary = table_getextraequipmentprimary(level.classtablename, _id_089688461C79EF11);
  struct.loadoutequipmentsecondary = table_getequipmentsecondary(level.classtablename, _id_089688461C79EF11);
  struct.loadoutextraequipmentsecondary = table_getextraequipmentsecondary(level.classtablename, _id_089688461C79EF11);
  struct.loadoutgesture = table_getgesture(level.classtablename, _id_089688461C79EF11);
  struct.loadoutexecution = cac_getexecution();
  _id_2DAD855D27735128(struct);
  struct.loadoutaccessoryweapon = cac_getaccessoryweapon();
  struct.loadoutaccessorydata = cac_getaccessorydata();
  struct.loadoutaccessorylogic = cac_getaccessorylogic();

  if(getdvarint("dvar_CEF27C8D9E5E0053", 0))
    struct.loadoutsuper = "super_bradley";

  return struct;
}

_id_C2AE0D2DB0C581EA(_id_9B02313FE7FF70DA, _id_185EA69B2FE37360) {
  if(istrue(_id_9B02313FE7FF70DA))
    scripts\cp\utility::_detachall(1);
  else {
    scripts\cp\utility::_detachall();

    if(isDefined(self.headmodel))
      self.headmodel = undefined;

    thread setmodelfromcustomization();
    _id_962EF6817910EC78 = lookupcurrentoperatorskin(self.team);
    _id_E89FD4C2E2E797B9 = getplayerfoleytype(_id_962EF6817910EC78);

    if(_id_E89FD4C2E2E797B9 == "")
      _id_E89FD4C2E2E797B9 = "vestlight";

    self setclothtype(_id_E89FD4C2E2E797B9);
  }
}

_id_777EAF15441A6BC6() {
  _id_144130378B339AB7 = self.melee_weapon;
  self.default_starting_melee_weapon = _id_144130378B339AB7;
  self.currentmeleeweapon = _id_144130378B339AB7;

  if(isundefinedweapon(self.default_starting_pistol)) {
    if(!isundefinedweapon(self.starting_weapon))
      self.default_starting_pistol = self.starting_weapon;
    else if(isDefined(level.default_weapon))
      self.default_starting_pistol = _id_2669878CF5A1B6BC::buildweapon(level.default_weapon, [], "none", "none", -1);
    else
      self.default_starting_pistol = _id_2669878CF5A1B6BC::buildweapon("iw9_pi_papa220_mp", [], "none", "none", -1);
  }

  self.last_stand_pistol = self.default_starting_pistol;

  if(!isundefinedweapon(self.starting_weapon) && self.starting_weapon == self.default_starting_pistol) {} else {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self.default_starting_pistol, undefined, undefined, 1);

    if(!(isDefined(self.onkillrelics) && istrue(self.onkillrelics["relic_oneInTheChamber"])))
      _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(self.default_starting_pistol);
  }

  if(!isundefinedweapon(self.starting_weapon)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self.starting_weapon, undefined, undefined, 1);

    if(!(isDefined(self.onkillrelics) && istrue(self.onkillrelics["relic_oneInTheChamber"])))
      _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(self.starting_weapon);
  }

  starting_weapon = self.default_starting_pistol;

  if(!isundefinedweapon(self.starting_weapon))
    starting_weapon = self.starting_weapon;

  thread wait_and_force_weapon_switch(starting_weapon, 1);
}

_id_720F2129E0579003() {
  _id_02A9F3313825D58D = _id_2669878CF5A1B6BC::buildweapon("iw9_me_climbfists");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_02A9F3313825D58D, undefined, undefined, 1);
}

_id_601EE7C5E1B107F3() {
  scripts\cp_mp\utility\inventory_utility::_giveweapon("super_default_zm");
  self assignweaponoffhandspecial("super_default_zm");
  self.specialoffhandgrenade = "super_default_zm";
}

notify_when_loadout_given() {
  self endon("disconnect");
  self waittill("loadout_given");

  if(!scripts\cp\utility::is_raid_gamemode() && !istrue(level.dogtag_revive))
    scripts\cp\utility::allow_player_basejumping(1, "loadout_given");

  if(!scripts\engine\utility::flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::flag_init("player_spawned_with_loadout");

  scripts\engine\utility::flag_set("player_spawned_with_loadout");

  if(!scripts\engine\utility::ent_flag_exist("player_spawned_with_loadout"))
    scripts\engine\utility::ent_flag_init("player_spawned_with_loadout");

  scripts\engine\utility::ent_flag_set("player_spawned_with_loadout");

  if(getdvarint("dvar_2D950B6324A825D9", 0) != 0)
    self nightvisionviewon();

  scripts\cp\calloutmarkerping_cp::setuppingspecificvars(self);

  if(scripts\cp\utility::is_wave_gametype())
    thread _id_644C18834356D9DC::clear_legacy_pickup_munitions();
}

allow_super(player) {
  if(isDefined(level.allow_super))
    return [[level.allow_super]](player);

  return 1;
}

setmodelfromcustomization() {
  _id_56E7CF38A4910BA2 = getcustomization();
  self setcustomization(_id_56E7CF38A4910BA2["body"], _id_56E7CF38A4910BA2["head"]);
  bodymodelname = self getcustomizationbody();
  headmodelname = self getcustomizationhead();
  _id_41BD2EEDA1C033D2 = self getcustomizationviewmodel();
  setcharactermodels(bodymodelname, headmodelname, _id_41BD2EEDA1C033D2);
}

getplayerviewmodelfrombody(_id_C993EC5D5206D3C6) {
  viewmodel = tablelookup("mp/cac/bodies.csv", 1, _id_C993EC5D5206D3C6, 3);

  if(!isDefined(viewmodel) || viewmodel == "")
    viewmodel = "viewhands_mp_base_iw8";

  return viewmodel;
}

setupplayermodel() {
  if(!isDefined(self.operatorcustomization) || self.operatorcustomization.rebuild == 1)
    createoperatorcustomization();

  body = self.operatorcustomization.defaultbody;
  head = self.operatorcustomization.defaulthead;
  vm = self.operatorcustomization.defaultvm;

  if(self getclientomnvar("ui_assault_suit_on") == 0)
    setcharactermodels(body, head, vm);
  else
    setcharactermodels("body_sp_opforce_shadow_company_elite_3_1", "head_sp_opforce_shadow_company_elite_1_1", "mp_vm_arms_jugg_aq_iw9_1_1");

  _id_7FDD3F9148F37ECE(self.operatorcustomization.suit);
  scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);
  _id_3AC7D9A950F1F115();
}

_id_3AC7D9A950F1F115() {
  if(!isDefined(self._id_DC196D396886FB97)) {
    return;
  }
  if(!isDefined(level._id_B6217B906C6BE73E))
    level._id_B6217B906C6BE73E = [];

  if(isstartstr(self._id_DC196D396886FB97.name, "price")) {
    level.price = self;
    level._id_B6217B906C6BE73E["price"] = self;
    self._id_938E8B2CA6549759 = "price";
  } else if(isstartstr(self._id_DC196D396886FB97.name, "farah")) {
    level.farah = self;
    level._id_B6217B906C6BE73E["farah"] = self;
    self._id_938E8B2CA6549759 = "farah";
  } else if(isstartstr(self._id_DC196D396886FB97.name, "gaz")) {
    level._id_E0632103DFA5BB19 = self;
    level._id_B6217B906C6BE73E["gaz"] = self;
    self._id_938E8B2CA6549759 = "gaz";
  } else {
    level.alex = self;
    level._id_B6217B906C6BE73E["alex"] = self;
    self._id_938E8B2CA6549759 = "alex";
  }
}

createoperatorcustomization(operatorref, _id_5864EA4E21A60CD4) {
  self.operatorcustomization = undefined;
  operatorcustomization = spawnStruct();

  if(!isDefined(operatorref) || !isDefined(_id_5864EA4E21A60CD4)) {
    operatorref = lookupcurrentoperator(self.team);
    _id_5864EA4E21A60CD4 = _id_ED273E317490CB02(operatorref);
  }

  if(getdvarint("dvar_A464CB031C16EE87", 0) > 0) {
    if(isDefined(self.team) && self.team == "allies") {
      operatorref = "t10_usa_bravo_infiltration";
      _id_5864EA4E21A60CD4 = 22;
    } else {
      operatorref = "t10_uk_stone_security";
      _id_5864EA4E21A60CD4 = 25;
    }
  }

  if(isDefined(self._id_DC196D396886FB97)) {
    operatorref = self._id_DC196D396886FB97.name;
    _id_5864EA4E21A60CD4 = self._id_DC196D396886FB97._id_9C9265C6D4356BC6;
  }

  operatorcustomization.operatorref = operatorref;
  operatorcustomization.skinref = _id_5864EA4E21A60CD4;
  operatorcustomization._id_D947B7E87C7243AB = _id_29B2AF59258D6501(_id_5864EA4E21A60CD4);
  operatorcustomization.gender = getoperatorgender(operatorref);
  operatorcustomization.voice = getoperatorvoice(operatorref, _id_5864EA4E21A60CD4);
  operatorcustomization.clothtype = getoperatorclothtype(_id_5864EA4E21A60CD4);
  operatorcustomization._id_400EF51562606E7A = _id_E8770349A2B50BEC(_id_5864EA4E21A60CD4);
  operatorcustomization.superfaction = getoperatorsuperfaction(operatorref);
  operatorcustomization.execution = getoperatorexecution(operatorref);
  operatorcustomization.executionquip = getoperatorexecutionquip(operatorref);

  if(getdvarint("dvar_A464CB031C16EE87", 0) > 0)
    operatorcustomization.suit = "t10_defaultsuit_mp";
  else
    operatorcustomization.suit = _id_ADA9A2308A4046E2(operatorref);

  operatorcustomization.brinfilsmokesuffix = getoperatorbrinfilsmokesuffix(_id_5864EA4E21A60CD4);
  operatorcustomization.rebuild = 0;
  self.operatorcustomization = operatorcustomization;
  _id_56E7CF38A4910BA2 = getoperatorcustomization();
  body = _id_56E7CF38A4910BA2[0];
  head = _id_56E7CF38A4910BA2[1];
  bodymodelname = self getcustomizationbody();
  headmodelname = self getcustomizationhead();
  _id_0E69FCB0BB9E108B = self getcustomizationviewmodel();
  _id_41BD2EEDA1C033D2 = getplayerviewmodelfrombody(body);

  if(!isagent(self))
    self setcustomization(body, head);
  else if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    bodymodelname = "fullbody_usmc_ar_br_infil";
    headmodelname = undefined;
    _id_0E69FCB0BB9E108B = "viewhands_mp_base_iw8";
    _id_41BD2EEDA1C033D2 = "viewhands_mp_base_iw8";
  } else {
    bodymodelname = "body_opforce_london_terrorist_1_2";
    headmodelname = "head_male_bc_03";
    _id_0E69FCB0BB9E108B = "viewmodel_mp_base_iw8";
    _id_41BD2EEDA1C033D2 = "viewmodel_mp_base_iw8";
  }

  self.operatorcustomization.body = body;
  self.operatorcustomization.defaultbody = bodymodelname;
  self.operatorcustomization.head = head;
  self.operatorcustomization.defaulthead = headmodelname;
  self.operatorcustomization.vm = _id_41BD2EEDA1C033D2;
  self.operatorcustomization.defaultvm = _id_0E69FCB0BB9E108B;

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female")
    self _meth_555E2D32E2756625("female");
  else
    self _meth_555E2D32E2756625("");

  if(istrue(game["isLaunchChunk"])) {
    if(isbot(self)) {
      if(self.team == "allies")
        self.operatorcustomization.voice = "ukft1";
      else
        self.operatorcustomization.voice = "ruft1";
    }
  }

  if(!isagent(self) && !isbot(self) && !isDefined(self.vehiclecustomization))
    self.vehiclecustomization = scripts\cp_mp\vehicles\vehicle::_id_1CD6D75165ECBC48();

  _id_1800697EBA3F6660(self.operatorcustomization);
}

_id_1800697EBA3F6660(operatorcustomization) {
  _id_CFBD5DFAB1E96CB1 = getdvarint("dvar_838359D5EBDCC7E0", 0);

  if(_id_CFBD5DFAB1E96CB1 == 0) {
    return;
  }
  _id_E701B52B2BDC35C5 = getdvarint("dvar_B77BB859108E69CD", 0);
  _id_179DD20BBF6C2F02 = getdvarint("dvar_91B801DDFB57AE8A", 0);

  if(scripts\common\utility::iscp() || !level.rankedmatch || !level.matchmakingmatch || !level.onlinestatsenabled) {
    return;
  }
  _id_4A654BD9A395C1FF = [];

  if(_id_E701B52B2BDC35C5 == 1)
    _id_4A654BD9A395C1FF[_id_4A654BD9A395C1FF.size] = self.operatorcustomization._id_D947B7E87C7243AB;

  if(_id_179DD20BBF6C2F02 == 1)
    _id_4A654BD9A395C1FF[_id_4A654BD9A395C1FF.size] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(self.operatorcustomization.execution);

  self _meth_616C0CA219597829(_id_4A654BD9A395C1FF);
}

_id_ED273E317490CB02(operatorref) {
  team = getoperatorteambyref(operatorref);

  if(scripts\cp\utility::getgametype() == "infect" && self.team == "axis")
    self.pers["operatorSkinIndex"] = 218;
  else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref))
    self.pers["operatorSkinIndex"] = self.operatorcustomization.skinref;
  else if(isai(self) || self isplayerheadless())
    self.pers["operatorSkinIndex"] = botpickskinid(operatorref);
  else
    self.pers["operatorSkinIndex"] = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "skin");

  return self.pers["operatorSkinIndex"];
}

_id_E8770349A2B50BEC(_id_5864EA4E21A60CD4) {
  _id_400EF51562606E7A = tablelookup("operatorskins.csv", 0, _id_5864EA4E21A60CD4, 23);
  return _id_400EF51562606E7A;
}

_id_ADA9A2308A4046E2(operatorref) {
  suit = tablelookup("operators.csv", 1, operatorref, 19);

  if(!isDefined(suit) || suit == "")
    suit = "iw9_suit_generic_west_mp";

  return suit;
}

getoperatorbrinfilsmokesuffix(_id_5864EA4E21A60CD4) {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_0E4731409BD255E0 = tablelookup("operatorskins.csv", 0, _id_5864EA4E21A60CD4, 24);
    return _id_0E4731409BD255E0;
  }

  return undefined;
}

_id_7FDD3F9148F37ECE(suit) {
  if(isDefined(self.suit) && self.suit == suit) {
    return;
  }
  self setsuit(suit);
  self.suit = suit;
}

lookupcurrentoperator(team) {
  if(!isPlayer(self) && !isai(self))
    return "";

  operatorref = undefined;

  if(isDefined(self._id_DC196D396886FB97))
    operatorref = self._id_DC196D396886FB97.name;
  else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.operatorref))
    operatorref = self.operatorcustomization.operatorref;
  else if(isai(self) || self isplayerheadless()) {
    if(isDefined(self.botoperatorref))
      operatorref = self.botoperatorref;
    else {
      _id_D650608C959C9675();

      if(!isDefined(self.botoperatorteam)) {
        self.botoperatorteam = self.team;

        if(!isDefined(level._id_B113F6FE0E7C93BF[self.botoperatorteam])) {
          _id_A35E0C377810107E = getarraykeys(level._id_B113F6FE0E7C93BF);
          self.botoperatorteam = scripts\engine\utility::random(_id_A35E0C377810107E);
        }
      }

      team = self.botoperatorteam;

      if(!isDefined(self.pers["operatorIndex"])) {
        _id_1F9F9C5D4663030C = randomint(level._id_B113F6FE0E7C93BF[team].size);
        self.pers["operatorIndex"] = _id_1F9F9C5D4663030C;
      } else
        _id_1F9F9C5D4663030C = self.pers["operatorIndex"];

      currentindex = 0;

      foreach(_id_257DF77381FCCC70, _id_EEF96DCED6DD39F1 in level._id_B113F6FE0E7C93BF[team]) {
        if(currentindex == _id_1F9F9C5D4663030C) {
          self.botoperatorref = _id_257DF77381FCCC70;
          operatorref = _id_257DF77381FCCC70;
          break;
        }

        currentindex++;
      }
    }

    if(!isDefined(operatorref) || operatorref == "")
      operatorref = "milsim_western_1";
  } else {
    _id_1F9F9C5D4663030C = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperatorIndex");
    _id_3EDA0EF65C9478AC = _id_1F9F9C5D4663030C;

    if(!isDefined(self.defaultoperatorteam)) {
      if(_id_3EDA0EF65C9478AC == 0)
        self.defaultoperatorteam = "allies";
      else
        self.defaultoperatorteam = "axis";
    }

    operatorref = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", _id_3EDA0EF65C9478AC);

    if(!isDefined(operatorref) || operatorref == "")
      operatorref = "milsim_western_1";
  }

  return operatorref;
}

_id_D650608C959C9675() {
  if(isDefined(level._id_B113F6FE0E7C93BF)) {
    return;
  }
  level._id_B113F6FE0E7C93BF = [];
  setDvar("dvar_2B669AD6C3E1D864", 1);
  setdvarifuninitialized("dvar_98C5CADF936AEB15", "");
  _id_B96BB7CC6652F794 = ["shared_iw9_t10"];
  _id_4D466347829517D4 = getDvar("dvar_98C5CADF936AEB15", "");

  if(_id_4D466347829517D4 != "") {
    _id_3F859A3D7AF673E9 = strtok(_id_4D466347829517D4, " ");
    _id_B96BB7CC6652F794 = scripts\engine\utility::array_combine(_id_B96BB7CC6652F794, _id_3F859A3D7AF673E9);
  }

  _id_91CB23E7AB33F8EF = 0;

  for(;;) {
    operatorref = tablelookupbyrow("operators.csv", _id_91CB23E7AB33F8EF, 1);

    if(!isDefined(operatorref) || operatorref == "") {
      break;
    }

    _id_31BA528E4A274A85 = tablelookupbyrow("operators.csv", _id_91CB23E7AB33F8EF, 32);

    if(scripts\engine\utility::array_contains(_id_B96BB7CC6652F794, _id_31BA528E4A274A85)) {
      superfaction = getoperatorsuperfaction(operatorref);
      team = scripts\engine\utility::ter_op(superfaction == 0, "allies", "axis");
      _id_7BE8B486A10B3DE8 = int(tablelookupbyrow("operators.csv", _id_91CB23E7AB33F8EF, 8));

      if(_id_7BE8B486A10B3DE8) {
        if(!isDefined(level._id_B113F6FE0E7C93BF[team]))
          level._id_B113F6FE0E7C93BF[team] = [];

        level._id_B113F6FE0E7C93BF[team][operatorref] = [];
      }
    }

    _id_91CB23E7AB33F8EF++;
  }

  _id_962EF6817910EC78 = 0;

  for(;;) {
    _id_DF0CFCC0964ACC07 = int(tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 20));
    skinref = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 1);
    lootid = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 0);

    if(!isDefined(skinref) || skinref == "") {
      break;
    }

    if(_id_DF0CFCC0964ACC07) {
      operatorref = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 2);
      team = getoperatorteambyref(operatorref);

      if(!isDefined(team)) {
        _id_962EF6817910EC78++;
        continue;
      }

      level._id_B113F6FE0E7C93BF[team][operatorref][level._id_B113F6FE0E7C93BF[team][operatorref].size] = lootid;
    }

    _id_962EF6817910EC78++;
  }
}

lookupcurrentoperatorskin(team) {
  operatorref = lookupcurrentoperator(team);
  operatorskinindex = undefined;
  clientnum = self getentitynumber();

  if(getdvarint("dvar_338DA2F6C53885E2", 1) == 1 && self isplayerheadless()) {
    if(!isDefined(level.playercustomizationdata[clientnum][team].operatorskinindex)) {
      if(!isDefined(level.headlessoperatorcustomization))
        initheadlessoperatorcustomization();

      _id_9A6BA9F5A0E705C7 = level.headlessoperatorcustomization[operatorref]["curIndex"];
      level.playercustomizationdata[clientnum][team].operatorskinindex = level.headlessoperatorcustomization[operatorref]["lootIDs"][_id_9A6BA9F5A0E705C7];
      level.headlessoperatorcustomization[operatorref]["curIndex"] = level.headlessoperatorcustomization[operatorref]["curIndex"] + 1;

      if(level.headlessoperatorcustomization[operatorref]["curIndex"] >= level.headlessoperatorcustomization[operatorref]["maxIndex"])
        level.headlessoperatorcustomization[operatorref]["curIndex"] = 0;
    }
  } else if(!isDefined(level.playercustomizationdata[clientnum][team].operatorskinindex)) {
    if(isai(self)) {
      if(!isDefined(self.botskinid))
        botpickskinid(operatorref);

      level.playercustomizationdata[clientnum][team].operatorskinindex = self.botskinid;
    } else
      level.playercustomizationdata[clientnum][team].operatorskinindex = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "skin");
  }

  operatorskinindex = level.playercustomizationdata[clientnum][team].operatorskinindex;

  if(isai(self) && (!isDefined(operatorskinindex) || operatorskinindex == 0) || !isDefined(operatorskinindex) || operatorskinindex == 0) {
    if(isai(self)) {
      if(isDefined(self.botskinid))
        operatorskinindex = self.botskinid;
      else
        botpickskinid(operatorref);
    } else
      operatorskinindex = 1;
  }

  return operatorskinindex;
}

botpickskinid(operatorref) {
  team = self.team;

  if(isDefined(self.botoperatorteam))
    team = self.botoperatorteam;

  if(!isDefined(self.pers["operatorSkinIndex"])) {
    _id_C645029CC8549E3F = randomint(level.operatorcustomization[team][operatorref].size);
    self.pers["operatorSkinIndex"] = _id_C645029CC8549E3F;
  } else
    _id_C645029CC8549E3F = self.pers["operatorSkinIndex"];

  currentindex = 0;

  foreach(skinref, _id_56E7CF38A4910BA2 in level.operatorcustomization[team][operatorref]) {
    if(currentindex == _id_C645029CC8549E3F) {
      lootid = int(tablelookup("operatorskins.csv", 1, skinref, 0));
      self.botskinid = lootid;
      operatorskinindex = lootid;
      break;
    }

    currentindex++;
  }
}

initheadlessoperatorcustomization() {
  if(isDefined(level.headlessoperatorcustomization)) {
    return;
  }
  level.headlessoperatorcustomization = [];
  _id_F87730061DCB36C4 = tablelookupgetnumrows("operatorskins.csv");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F87730061DCB36C4; _id_AC0E594AC96AA3A8++) {
    if(tablelookupbyrow("operatorskins.csv", _id_AC0E594AC96AA3A8, 18) != "") {
      operatorref = tablelookupbyrow("operatorskins.csv", _id_AC0E594AC96AA3A8, 2);
      lootid = tablelookupbyrow("operatorskins.csv", _id_AC0E594AC96AA3A8, 0);

      if(!isDefined(level.headlessoperatorcustomization[operatorref])) {
        level.headlessoperatorcustomization[operatorref]["lootIDs"] = [];
        level.headlessoperatorcustomization[operatorref]["curIndex"] = 0;
        level.headlessoperatorcustomization[operatorref]["maxIndex"] = 0;
      }

      level.headlessoperatorcustomization[operatorref]["lootIDs"][level.headlessoperatorcustomization[operatorref]["lootIDs"].size] = int(lootid);
      level.headlessoperatorcustomization[operatorref]["maxIndex"] = level.headlessoperatorcustomization[operatorref]["maxIndex"] + 1;
    }
  }
}

initoperatorcustomization() {
  if(isDefined(level.operatorcustomization)) {
    return;
  }
  level.operatorcustomization = [];
  setDvar("dvar_2B669AD6C3E1D864", 1);
  _id_91CB23E7AB33F8EF = 0;

  for(;;) {
    operatorref = tablelookupbyrow("operators.csv", _id_91CB23E7AB33F8EF, 1);
    superfaction = getoperatorsuperfaction(operatorref);
    team = scripts\engine\utility::ter_op(superfaction == 0, "allies", "axis");

    if(!isDefined(operatorref) || operatorref == "") {
      break;
    }

    _id_7BE8B486A10B3DE8 = int(tablelookupbyrow("operators.csv", _id_91CB23E7AB33F8EF, 8));

    if(_id_7BE8B486A10B3DE8) {
      if(!isDefined(level.operatorcustomization[team]))
        level.operatorcustomization[team] = [];

      level.operatorcustomization[team][operatorref] = [];
    }

    _id_91CB23E7AB33F8EF++;
  }

  _id_962EF6817910EC78 = 0;

  for(;;) {
    operatorref = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 2);
    skinref = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 1);
    body = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 4);
    head = tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 5);

    if(!isDefined(skinref) || skinref == "") {
      break;
    }

    team = getoperatorteambyref(operatorref);

    if(!isDefined(team)) {
      _id_962EF6817910EC78++;
      continue;
    }

    _id_56E7CF38A4910BA2 = [];
    _id_56E7CF38A4910BA2[0] = body;
    _id_56E7CF38A4910BA2[1] = head;
    level.operatorcustomization[team][operatorref][skinref] = _id_56E7CF38A4910BA2;
    _id_962EF6817910EC78++;
  }
}

getoperatorteambyref(operatorref) {
  foreach(team, _id_B6217B906C6BE73E in level.operatorcustomization) {
    foreach(operator, _id_0BFBF0D4002DD345 in _id_B6217B906C6BE73E) {
      if(operator == operatorref)
        return team;
    }
  }

  return undefined;
}

getcustomization() {
  _id_56E7CF38A4910BA2 = [];

  if(isDefined(self.operatorcustomization)) {
    _id_56E7CF38A4910BA2["body"] = self.operatorcustomization.body;
    _id_56E7CF38A4910BA2["head"] = self.operatorcustomization.head;
  } else {
    data = getoperatorcustomization();
    _id_56E7CF38A4910BA2["body"] = data[0];
    _id_56E7CF38A4910BA2["head"] = data[1];
  }

  return _id_56E7CF38A4910BA2;
}

getoperatorcustomization() {
  _id_56E7CF38A4910BA2 = [];
  body = undefined;
  head = undefined;

  if(istrue(game["isLaunchChunk"])) {
    initlaunchchunkoperatorskins();

    if(!isDefined(self.pers["defaultOperatorSkinIndex"]))
      self.pers["defaultOperatorSkinIndex"] = picklaunchchunkoperatorskin(self.team);

    body = level.defaultoperatorskins[self.team]["body"][self.pers["defaultOperatorSkinIndex"]];
    head = level.defaultoperatorskins[self.team]["head"][self.pers["defaultOperatorSkinIndex"]];
    _id_56E7CF38A4910BA2[0] = body;
    _id_56E7CF38A4910BA2[1] = head;
  } else {
    operatorskinindex = undefined;

    if(!isDefined(self.operatorcustomization))
      createoperatorcustomization();

    operatorskinindex = int(self.operatorcustomization.skinref);

    if(isDefined(self._id_DC196D396886FB97))
      operatorskinindex = self._id_DC196D396886FB97._id_9C9265C6D4356BC6;

    if(isDefined(level.modegetforceoperatorcustomization)) {
      _id_91CB23E7AB33F8EF = _id_1B5C55CB118D5CB4(operatorskinindex);
      [_id_91CB23E7AB33F8EF, operatorskinindex] = [[level.modegetforceoperatorcustomization]](self, _id_91CB23E7AB33F8EF, operatorskinindex);
    }

    operatorskinindex = int(operatorskinindex);

    if(operatorskinindex == 274 || operatorskinindex == 275) {
      initdefaultoperatorskins();
      _id_3060E7B91E020425 = level.teambased && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

      if(!isDefined(self.defaultoperatorteam) || _id_3060E7B91E020425 && self.defaultoperatorteam != self.team && (self.team == "allies" || self.team == "axis")) {
        self.defaultoperatorteam = self.team;

        if(self.team != "allies" && self.team != "axis")
          self.defaultoperatorteam = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "allies", "axis");
      }

      if(!isDefined(self.pers["defaultOperatorSkinIndex"]))
        self.pers["defaultOperatorSkinIndex"] = randomint(level.defaultoperatorskins[self.defaultoperatorteam]["body"].size);

      body = level.defaultoperatorskins[self.defaultoperatorteam]["body"][self.pers["defaultOperatorSkinIndex"]];

      if(!isDefined(self.pers["defaultOperatorHeadIndex"]))
        self.pers["defaultOperatorHeadIndex"] = randomint(level.defaultoperatorskins[self.defaultoperatorteam]["head"][self.pers["defaultOperatorSkinIndex"]].size);

      head = level.defaultoperatorskins[self.defaultoperatorteam]["head"][self.pers["defaultOperatorSkinIndex"]][self.pers["defaultOperatorHeadIndex"]];
    } else {
      body = tablelookup("operatorskins.csv", 0, operatorskinindex, 4);
      head = tablelookup("operatorskins.csv", 0, operatorskinindex, 5);
    }

    if(body == "" || head == "") {
      _id_F91A44E31CDE7D97 = tablelookup("operators.csv", 1, self.operatorcustomization.operatorref, 22);
      body = tablelookup("operatorskins.csv", 1, _id_F91A44E31CDE7D97, 4);
      head = tablelookup("operatorskins.csv", 1, _id_F91A44E31CDE7D97, 5);
    }

    self.bodymodelname = body;
    self.backuphead = head;
    _id_56E7CF38A4910BA2[0] = body;
    _id_56E7CF38A4910BA2[1] = head;
  }

  return _id_56E7CF38A4910BA2;
}

initlaunchchunkoperatorskins() {
  if(isDefined(level.defaultoperatorskins)) {
    return;
  }
  level.defaultoperatorskins = [];
  level.defaultoperatorskins["allies"] = [];
  level.defaultoperatorskins["allies"]["body"] = ["body_mp_western_fireteam_west_dmr_1_1_lod1", "body_mp_western_fireteam_west_ar_1_1_lod1"];
  level.defaultoperatorskins["allies"]["head"] = ["head_mp_western_fireteam_west_dmr_2_1", "head_mp_western_fireteam_west_ar_1_1"];
  level.defaultoperatorskins["allies"]["suit"] = ["iw8_suit_mp_wyatt"];
  level.defaultoperatorskins["axis"] = [];
  level.defaultoperatorskins["axis"]["body"] = ["body_mp_eastern_fireteam_east_ar_lod1", "body_mp_eastern_fireteam_east_lmg_lod1"];
  level.defaultoperatorskins["axis"]["head"] = ["head_mp_eastern_fireteam_east_ar_2", "head_mp_eastern_fireteam_east_lmg"];
  level.defaultoperatorskins["axis"]["suit"] = ["iw8_suit_mp_wyatt"];
}

picklaunchchunkoperatorskin(team) {
  if(!isDefined(level.launchchunkskins)) {
    level.launchchunkskins = [];
    level.launchchunkskins["allies"] = 0;
    level.launchchunkskins["axis"] = 0;
  }

  if(!isDefined(self.launchchunkcustomizationindex)) {
    if(level.launchchunkskins[team] == 2)
      level.launchchunkskins[team] = 0;

    self.launchchunkcustomizationindex = level.launchchunkskins[team];
    level.launchchunkskins[team]++;
  }

  return self.launchchunkcustomizationindex;
}

_id_6C2AE2B932A9FD51() {
  if(isDefined(self.operatorcustomization)) {
    if(isDefined(self.operatorcustomization.operatorref)) {
      if(issubstr(self.operatorcustomization.operatorref, "milsim"))
        return 1;
    }
  }

  return 0;
}

initdefaultoperatorskins() {
  if(isDefined(level.defaultoperatorskins)) {
    return;
  }
  level.defaultoperatorskins = [];
  level.defaultoperatorskins["allies"] = [];
  level.defaultoperatorskins["allies"]["body"] = ["body_mp_western_fireteam_west_ar_1_1_lod1", "body_mp_western_fireteam_west_smg_1_1_lod1", "body_mp_western_fireteam_west_dmr_1_1_lod1", "body_mp_western_fireteam_west_lmg_1_1_lod1", "body_mp_western_fireteam_west_sg_1_1_lod1"];
  level.defaultoperatorskins["allies"]["head"][0] = ["head_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_2_1"];
  level.defaultoperatorskins["allies"]["head"][1] = ["head_mp_western_fireteam_west_smg_1_1", "head_mp_western_fireteam_west_smg_2_1"];
  level.defaultoperatorskins["allies"]["head"][2] = ["head_mp_western_fireteam_west_dmr_1_1", "head_mp_western_fireteam_west_dmr_2_1"];
  level.defaultoperatorskins["allies"]["head"][3] = ["head_mp_western_fireteam_west_lmg_1_1", "head_mp_western_fireteam_west_lmg_2_1"];
  level.defaultoperatorskins["allies"]["head"][4] = ["head_mp_western_fireteam_west_sg_1_1", "head_mp_western_fireteam_west_sg_2_1"];
  level.defaultoperatorskins["allies"]["suit"] = ["iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp"];
  level.defaultoperatorskins["axis"] = [];
  level.defaultoperatorskins["axis"]["body"] = ["body_mp_eastern_fireteam_east_ar_lod1", "body_mp_eastern_fireteam_east_smg_lod1", "body_mp_eastern_fireteam_east_dmr_lod1", "body_mp_eastern_fireteam_east_lmg_lod1", "body_mp_eastern_fireteam_east_sg_lod1"];
  level.defaultoperatorskins["axis"]["head"][0] = ["head_mp_eastern_fireteam_east_ar_1", "head_mp_eastern_fireteam_east_ar_2", "head_mp_eastern_fireteam_east_ar_3", "head_mp_eastern_fireteam_east_ar_4"];
  level.defaultoperatorskins["axis"]["head"][1] = ["head_mp_eastern_fireteam_east_smg_1", "head_mp_eastern_fireteam_east_smg_2", "head_mp_eastern_fireteam_east_smg_3"];
  level.defaultoperatorskins["axis"]["head"][2] = ["head_mp_eastern_fireteam_east_dmr"];
  level.defaultoperatorskins["axis"]["head"][3] = ["head_mp_eastern_fireteam_east_lmg", "head_mp_eastern_fireteam_east_nvg_1"];
  level.defaultoperatorskins["axis"]["head"][4] = ["head_mp_eastern_fireteam_east_sg"];
  level.defaultoperatorskins["axis"]["suit"] = ["iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp", "iw9_suit_generic_west_mp"];
}

getoperatorexecution(operatorref) {
  _id_90B23EDBB5FCA35C = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "execution");

  if(_id_90B23EDBB5FCA35C == 0)
    self.loadoutexecution = tablelookup("operators.csv", 1, operatorref, 24);
  else
    self.loadoutexecution = tablelookup("mp_cp/executiontable.csv", 0, _id_90B23EDBB5FCA35C, 1);

  return self.loadoutexecution;
}

getoperatorexecutionquip(operatorref) {
  _id_635CB55857199A8D = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", operatorref, "taunt");

  if(_id_635CB55857199A8D == 0)
    self.loadoutexecutionquip = tablelookup("operators.csv", 1, operatorref, 23);
  else
    self.loadoutexecutionquip = tablelookup("operatorquips.csv", 0, _id_635CB55857199A8D, 6);

  return self.loadoutexecutionquip;
}

getoperatorsuperfaction(operatorref) {
  faction = tablelookup("operators.csv", 1, operatorref, 3);
  return int(faction);
}

getoperatorvoice(operatorref, _id_5864EA4E21A60CD4) {
  voice = tablelookup("operators.csv", 1, operatorref, 10);
  return voice;
}

getoperatorclothtype(_id_962EF6817910EC78) {
  clothtype = tablelookupbyrow("operatorskins.csv", int(_id_962EF6817910EC78), 22);
  return clothtype;
}

_id_29B2AF59258D6501(_id_962EF6817910EC78) {
  _id_0C26FC18BDA607B7 = tablelookup("operatorskins.csv", 0, _id_962EF6817910EC78, 1);
  _id_D947B7E87C7243AB = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_0C26FC18BDA607B7);
  return _id_D947B7E87C7243AB;
}

_id_1B5C55CB118D5CB4(_id_F2FBF2F4F3D38A71) {
  operatorref = tablelookup("operatorskins.csv", 0, _id_F2FBF2F4F3D38A71, 2);
  return operatorref;
}

getoperatorgender(operatorref) {
  gender = scripts\engine\utility::ter_op(tablelookup("operators.csv", 1, operatorref, 11) == "0", "male", "female");
  return gender;
}

get_player_character_num() {}

setcharactermodels(bodymodelname, headmodelname, _id_41BD2EEDA1C033D2, hairmodel) {
  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self setModel(bodymodelname);
  self setviewmodel(_id_41BD2EEDA1C033D2);
  self attach(headmodelname, "", 1);
  self.bodymodel = bodymodelname;
  self.headmodel = headmodelname;
  self.viewmodel = _id_41BD2EEDA1C033D2;
}

getplayerfoleytype(_id_962EF6817910EC78) {
  return tablelookupbyrow("operatorskins.csv", _id_962EF6817910EC78, 22);
}

updatemovespeedscale() {
  _id_8F053B6F8634C100 = undefined;

  if(isDefined(self.playerstreakspeedscale)) {
    _id_8F053B6F8634C100 = 1.0;
    _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.playerstreakspeedscale;
  } else {
    _id_8F053B6F8634C100 = getplayerspeedbyweapon(self);

    if(isDefined(self.chargemode_speedscale))
      _id_8F053B6F8634C100 = self.chargemode_speedscale;
    else if(isDefined(self.siege_speedscale))
      _id_8F053B6F8634C100 = self.siege_speedscale;
    else if(isDefined(self.overrideweaponspeed_speedscale))
      _id_8F053B6F8634C100 = self.overrideweaponspeed_speedscale;

    _id_F30C40867C01E4F9 = self.chill_data;

    if(isDefined(_id_F30C40867C01E4F9) && isDefined(_id_F30C40867C01E4F9.speedmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + _id_F30C40867C01E4F9.speedmod;

    if(isDefined(self.speedstripmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.speedstripmod;

    if(isDefined(self.phasespeedmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.phasespeedmod;

    if(isDefined(self.weaponaffinityspeedboost))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.weaponaffinityspeedboost;

    if(isDefined(self.weaponpassivespeedmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.weaponpassivespeedmod;

    if(isDefined(self.weaponpassivespeedonkillmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.weaponpassivespeedonkillmod;

    _id_8F053B6F8634C100 = min(1.5, _id_8F053B6F8634C100);
  }

  self.weaponspeed = _id_8F053B6F8634C100;

  if(!isDefined(self.combatspeedscalar))
    self.combatspeedscalar = 1;

  self setmovespeedscale(_id_8F053B6F8634C100 * self.movespeedscaler * self.combatspeedscalar);
}

getplayerspeedbyweapon(player) {
  weaponspeed = 1.0;
  self.weaponlist = self getweaponslistprimaries();

  if(!self.weaponlist.size)
    weaponspeed = 0.9;
  else {
    weapon = self getcurrentweapon();

    if(scripts\cp\utility::issuperweapon(weapon))
      weaponspeed = level.superweapons[getcompleteweaponname(weapon)].movespeed;
    else {
      _id_A6852F8E66761E58 = weaponinventorytype(weapon);

      if(_id_A6852F8E66761E58 != "primary" && _id_A6852F8E66761E58 != "altmode") {
        if(isDefined(self.saved_lastweapon))
          weapon = self.saved_lastweapon;
        else
          weapon = undefined;
      }

      if(!isDefined(weapon) || !self hasweapon(weapon))
        weaponspeed = getweaponspeedslowest();
      else {
        weaponspeed = getweaponspeed(weapon);

        if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924()) {
          class = weaponclass(weapon);

          if(isDefined(level._id_26109C02A53CEA84) && isDefined(level._id_26109C02A53CEA84[class]))
            weaponspeed = level._id_26109C02A53CEA84[class];
        }
      }
    }
  }

  weaponspeed = clampweaponspeed(weaponspeed);
  return weaponspeed;
}

getweaponspeed(weapon) {
  rootweapon = scripts\cp\utility::getbaseweaponname(weapon);
  weaponspeed = 1;

  if(isDefined(rootweapon) && isDefined(level.weaponmapdata) && isDefined(level.weaponmapdata[rootweapon]) && isDefined(level.weaponmapdata[rootweapon].speed)) {
    weaponspeed = level.weaponmapdata[rootweapon].speed;

    if(!isDefined(weaponspeed))
      weaponspeed = 1;
  }

  return weaponspeed;
}

getweaponspeedslowest() {
  _id_6155FF1652D3374F = 2.0;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(weapon in self.weaponlist) {
      weaponspeed = getweaponspeed(weapon);

      if(weaponspeed == 0) {
        continue;
      }
      if(weaponspeed < _id_6155FF1652D3374F)
        _id_6155FF1652D3374F = weaponspeed;
    }
  } else
    _id_6155FF1652D3374F = 0.9;

  _id_6155FF1652D3374F = clampweaponspeed(_id_6155FF1652D3374F);
  return _id_6155FF1652D3374F;
}

clampweaponspeed(value) {
  return clamp(value, 0.0, 1.0);
}

wait_and_force_weapon_switch(starting_weapon, _id_2FBB377EDFB4215D) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  wait 0.5;
  _id_BC9DA38A4BAB4CE2 = self getweaponslistprimaries();

  if(!isDefined(_id_BC9DA38A4BAB4CE2) || _id_BC9DA38A4BAB4CE2.size <= 0 || !isDefined(starting_weapon)) {
    return;
  }
  if(!istrue(_id_2FBB377EDFB4215D))
    add_ammo_if_needed(_id_BC9DA38A4BAB4CE2);

  if(!self hasweapon(starting_weapon)) {
    starting_weapon = _id_BC9DA38A4BAB4CE2[0];

    if(starting_weapon.basename == "iw9_me_diveknife_mp" && isDefined(_id_BC9DA38A4BAB4CE2[1]))
      starting_weapon = _id_BC9DA38A4BAB4CE2[1];
  }

  self setspawnweapon(starting_weapon);
}

add_ammo_if_needed(_id_BC9DA38A4BAB4CE2) {
  if(isDefined(self.perk_data) && istrue(self.perk_data["weapons_have_full_ammo"])) {
    foreach(weapon in _id_BC9DA38A4BAB4CE2)
    scripts\cp\utility::_id_AD3CE5E1679DF13D(weapon);
  }
}

_id_37640F469A0BD7B4() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("force_bleed_out");
  self endon("last_stand");
  self endon("revive_success");

  if(game["state"] != "postgame") {
    if(isDefined(level.player_suit)) {
      _id_7FDD3F9148F37ECE(level.player_suit);
      self.suit = level.player_suit;
    } else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.suit) && self.operatorcustomization.suit != "") {
      _id_7FDD3F9148F37ECE(self.operatorcustomization.suit);
      self.suit = self.operatorcustomization.suit;
    } else {
      _id_7FDD3F9148F37ECE("iw9_suit_cp");
      self.suit = "iw9_suit_cp";
    }
  }

  self allowslide(1);
  self allowmantle(1);

  if(_id_5E5507D57BBBB709::_id_0C4FD5298F57F111()) {
    _id_50A1492D3AAABB79 = _id_5E5507D57BBBB709::_id_7B2A99B6A0EC3642();

    if(isDefined(_id_50A1492D3AAABB79) && _id_50A1492D3AAABB79.size > 0) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_50A1492D3AAABB79.size; _id_AC0E594AC96AA3A8++)
        scripts\cp\utility::giveperk(_id_50A1492D3AAABB79[_id_AC0E594AC96AA3A8]);
    }
  }

  self notify("set_player_perks");
}

registerplayercharacter(_id_F8892FD366226EB7, _id_80D695139E2AD462, body_model, view_model, head_model, hair_model, vo_prefix, vo_suffix, pap_gesture, revive_gesture, photo_index, fate_card_weapon, intro_music, intro_gesture, melee_weapon, post_setup_func, starting_weapon) {
  _id_0E060043AC076039 = spawnStruct();
  _id_0E060043AC076039.body_model = body_model;
  _id_0E060043AC076039.view_model = view_model;
  _id_0E060043AC076039.head_model = head_model;
  _id_0E060043AC076039.hair_model = hair_model;
  _id_0E060043AC076039.vo_prefix = vo_prefix;
  _id_0E060043AC076039.vo_suffix = vo_suffix;
  _id_0E060043AC076039.pap_gesture = pap_gesture;
  _id_0E060043AC076039.revive_gesture = revive_gesture;
  _id_0E060043AC076039.photo_index = photo_index;
  _id_0E060043AC076039.fate_card_weapon = fate_card_weapon;
  _id_0E060043AC076039.intro_music = intro_music;
  _id_0E060043AC076039.intro_gesture = intro_gesture;
  _id_0E060043AC076039.melee_weapon = makeweaponfromstring(melee_weapon);
  _id_0E060043AC076039.starting_weapon = makeweaponfromstring(starting_weapon);
  _id_0E060043AC076039.post_setup_func = post_setup_func;
}

testclient_run_funcs() {
  if(!istestclient(self)) {
    return;
  }
  if(getdvarint("dvar_A31A2982A3EB161D", 0) > 0) {
    return;
  }
  thread scripts\cp\utility::notify_delay("loadout_given", 7);
  thread testclient_dev_laststand();
}

testclient_dev_laststand() {
  level endon("game_ended");
  self endon("disconnect");
  _id_B9C45882C66B8295 = 0;

  if(getdvarint("dvar_42E908DD6C9A5170", 0) > 0)
    _id_B9C45882C66B8295 = 1;

  wait 5;
  announcement("^2Testclient setting loadout...");
  wait 5;

  if(istestclient(self))
    thread testclient_ignoreme_dvar();

  for(;;) {
    if(getdvarint("dvar_42E908DD6C9A5170", 0) == 0) {
      waitframe();
      continue;
    }

    if(_id_B9C45882C66B8295 == 2) {
      scripts\engine\utility::waittill_any_3("landed_after_respawn", "revive_done", "revive");
      wait 7.5;
    }

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      self dodamage(self.health + 1, self.origin, self);
      announcement("^1TestClient Downed");
    }

    if(_id_B9C45882C66B8295 == 0)
      setDvar("dvar_42E908DD6C9A5170", 0);

    if(_id_B9C45882C66B8295 == 1)
      _id_B9C45882C66B8295 = 2;
  }
}

testclient_ignoreme_dvar() {
  if(getdvarint("dvar_BB2888F50EAE5956", 0) == 0) {
    return;
  }
  wait 3;
  self.ignoreme = 1;
}

change_loadout_watcher(player, value) {
  level endon("game_ended");
  player endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, value);

    if(isDefined(_id_7148C1A6F25491F8)) {
      switch (_id_7148C1A6F25491F8) {
        case "class_menu_closed":
        case "class_edit":
        case "class_select":
          if(is_player_carrying_special_item())
            self notify("switched_from_core");

          if(_id_7148C1A6F25491F8 == "class_select") {
            if(value >= 100)
              _id_089688461C79EF11 = value - 100;
            else
              _id_089688461C79EF11 = undefined;

            if(_id_0AFB7E332AEE4BF2::player_in_laststand(self))
              self notify("loadout_menu_closed");
            else {
              self.changing_loadout = 1;
              self.defaultclassindex = _id_089688461C79EF11;

              if(scripts\engine\utility::ent_flag_exist("player_spawned_with_loadout") && scripts\engine\utility::ent_flag("player_spawned_with_loadout"))
                self[[level.custom_giveloadout]](0, undefined, _id_089688461C79EF11, 1);
              else
                self[[level.custom_giveloadout]](0, undefined, _id_089688461C79EF11);

              thread display_relics_splash(self, 5);
            }
          }

          if(_id_7148C1A6F25491F8 == "class_menu_closed")
            self notify("loadout_menu_closed");

          break;
        case "update_super":
          _id_56EF8D52FE1B48A1::give_player_super();
          break;
        case "munitions_updated":
          _id_B8BA56B9EDD59CB7 = self getplayerdata("cp", "inventorySlots", "totalSlots");
          _id_644C18834356D9DC::reset_munitions(self, _id_B8BA56B9EDD59CB7);
          break;
      }
    }
  }
}

display_relics_splash(player, time) {
  wait 1.5;

  if(isDefined(level.set_relics) && level.set_relics.size > 0) {
    player setclientomnvar("ui_match_start_countdown", time);
    wait(time);
    player setclientomnvar("ui_match_start_countdown", -1);
  }
}

is_player_carrying_special_item() {
  if(_id_74502A9E0EF1F19C::player_has_minigun(self))
    return 1;
  else
    return 0;
}

drop_special_item() {
  if(_id_74502A9E0EF1F19C::player_has_minigun(self))
    _id_74502A9E0EF1F19C::drop_minigun(self);
}

_id_7DA7BD24B280D295(_id_69F988BDF6D3E44A) {
  if(!isDefined(self.pers))
    self.pers = [];

  _id_DF06032CFA393863 = [];
  _id_036A258E1E4DBE91 = self getweaponslistprimaries();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_036A258E1E4DBE91.size; _id_AC0E594AC96AA3A8++) {
    _id_E2D50C24D4058EC5 = 1;

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < level.additional_laststand_weapon_exclusion.size; _id_AC0E5C4AC96AAA41++) {
      if(issameweapon(level.additional_laststand_weapon_exclusion[_id_AC0E5C4AC96AAA41], _id_036A258E1E4DBE91[_id_AC0E594AC96AA3A8])) {
        _id_E2D50C24D4058EC5 = 0;
        break;
      }
    }

    _id_C47024AB9C2E9DDE = 0;

    if(_id_2669878CF5A1B6BC::isminigunweapon(_id_036A258E1E4DBE91[_id_AC0E594AC96AA3A8])) {
      _id_E2D50C24D4058EC5 = 0;
      _id_C47024AB9C2E9DDE = 1;
    }

    if(istrue(_id_C47024AB9C2E9DDE))
      _id_DF06032CFA393863[_id_DF06032CFA393863.size] = level._id_0BCD25CD23011249["fists"];

    if(_id_E2D50C24D4058EC5)
      _id_DF06032CFA393863[_id_DF06032CFA393863.size] = _id_036A258E1E4DBE91[_id_AC0E594AC96AA3A8];
  }

  _id_9770C3C2438B3068 = [];
  _id_2BDA810C9088BEC6 = [];
  _id_342175A1B9F9067E = _id_531CB1BE084314F7::_id_B13E35608B336D65(self);

  if(isDefined(_id_342175A1B9F9067E) && _id_342175A1B9F9067E >= 1) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_342175A1B9F9067E; _id_AC0E594AC96AA3A8++) {
      _id_E58EA7BE13F8D8A4 = _id_531CB1BE084314F7::_id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);
      _id_AF6F31D6359AFB68 = _id_531CB1BE084314F7::_id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8);

      if(_id_E58EA7BE13F8D8A4 != 0) {
        equipname = _id_531CB1BE084314F7::_id_91C1BE871300A518(_id_E58EA7BE13F8D8A4);
        _id_9770C3C2438B3068 = scripts\engine\utility::array_add(_id_9770C3C2438B3068, equipname);
        _id_2BDA810C9088BEC6 = scripts\engine\utility::array_add(_id_2BDA810C9088BEC6, _id_AF6F31D6359AFB68);
      }
    }
  }

  self.pers["loadout"] = _id_DF06032CFA393863;
  self.pers["powers"] = self.powers;
  self.pers["equipment"] = self.equipment;
  self.pers["backpack"] = _id_9770C3C2438B3068;
  self.pers["backpack_amounts"] = _id_2BDA810C9088BEC6;
  self.pers["last_checkpoint"] = "";
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "")
    self.pers["last_checkpoint"] = checkpoint;

  if(!istrue(_id_69F988BDF6D3E44A)) {
    if(_id_0AFB7E332AEE4BF2::hasselfrevivetoken())
      self.pers["has_revive_token"] = 1;
    else
      self.pers["has_revive_token"] = 0;
  }

  if(isDefined(self.munition_slots) && !istrue(_id_69F988BDF6D3E44A)) {
    _id_2EB600F8CA5D6625 = [];

    foreach(_id_A7F7342ABACA0E34 in self.munition_slots)
    _id_2EB600F8CA5D6625[_id_2EB600F8CA5D6625.size] = _id_A7F7342ABACA0E34.ref;

    _id_BBE818D3B1FCE218 = [];

    foreach(_id_A7F7342ABACA0E34 in _id_2EB600F8CA5D6625)
    _id_BBE818D3B1FCE218[_id_BBE818D3B1FCE218.size] = _id_A7F7342ABACA0E34;

    self.pers["munitions"] = _id_BBE818D3B1FCE218;
  }

  if(isDefined(self.super))
    self.pers["super"] = self.super._id_5237A188CCDA4D7B;
}

_id_82CE5817A5C19F25() {
  _id_3D6404612A600581 = [];

  foreach(slot, equipment in self.equipment) {
    _id_2EB625D9EAAA9671 = spawnStruct();
    _id_2EB625D9EAAA9671.equipment = equipment;
    _id_2EB625D9EAAA9671.count = _id_7EF95BBA57DC4B82::getequipmentammo(equipment);
    _id_3D6404612A600581[slot] = _id_2EB625D9EAAA9671;
  }

  self._id_1385A0C5D51C68F1 = _id_3D6404612A600581;
}

_id_249F6D125AEFB737(weaponlist) {
  _id_8685A74AB8093FCC = [];
  _id_31B2311ACBC7ABF4 = [];
  _id_F5C04F15F6DBACAB = [];
  _id_A322A76AFE84F375 = [];

  foreach(weapon in weaponlist) {
    if(!isweapon(weapon)) {
      continue;
    }
    if(weapon.inventorytype != "primary") {
      _id_A322A76AFE84F375[_id_A322A76AFE84F375.size] = weapon;
      continue;
    }

    if(weapon.classname == "pistol") {
      _id_F5C04F15F6DBACAB[_id_F5C04F15F6DBACAB.size] = weapon;
      continue;
    }

    _id_31B2311ACBC7ABF4[_id_31B2311ACBC7ABF4.size] = weapon;
  }

  foreach(weapon in _id_31B2311ACBC7ABF4)
  _id_8685A74AB8093FCC[_id_8685A74AB8093FCC.size] = weapon;

  foreach(weapon in _id_F5C04F15F6DBACAB)
  _id_8685A74AB8093FCC[_id_8685A74AB8093FCC.size] = weapon;

  foreach(weapon in _id_A322A76AFE84F375)
  _id_8685A74AB8093FCC[_id_8685A74AB8093FCC.size] = weapon;

  return _id_8685A74AB8093FCC;
}

_id_8938F74AFDBE2683() {
  level endon("game_ended");
  player = self;
  player _id_531CB1BE084314F7::br_forcegivecustompickupitem(player, "interactable_note_keycard_raid4_maze", 0, 1, 0, 0);
  level._id_2313A19F59121665 = player;
}

_id_45A6143A0A99851D(player) {
  if(!isDefined(player.pers))
    player.pers = [];

  if(!isDefined(player.pers["loadout"])) {
    return;
  }
  weaponlist = _id_249F6D125AEFB737(player.pers["loadout"]);
  _id_98E31F0A4B5B4FD8 = 0;

  foreach(weapon in weaponlist) {
    if(isweapon(weapon) && weapon.inventorytype == "primary") {
      if(scripts\engine\utility::array_contains(level._id_D5AB05B7947DE15A, weapon)) {
        continue;
      }
      _id_D5C21D00AA7AF170 = 0;

      foreach(_id_4AF808ECC0993014 in level._id_D5AB05B7947DE15A) {
        _id_F5E3D5EF35D5D2EA = getweaponbasename(_id_4AF808ECC0993014);
        _id_B61734FC9A40E354 = getweaponbasename(weapon);

        if(isDefined(_id_F5E3D5EF35D5D2EA) && isDefined(_id_B61734FC9A40E354)) {
          if(_id_F5E3D5EF35D5D2EA == _id_B61734FC9A40E354)
            _id_D5C21D00AA7AF170 = 1;
        }
      }

      if(_id_D5C21D00AA7AF170) {
        continue;
      }
      if(!player hasweapon(weapon))
        player scripts\cp_mp\utility\inventory_utility::_giveweapon(weapon);

      player setweaponammoclip(weapon, weaponclipsize(weapon));
      _id_811ABFDB6C33F17F = _id_66122A002AFF5D57::br_ammo_type_for_weapon(weapon);

      if(isDefined(_id_811ABFDB6C33F17F)) {
        _id_AB0EE360900BCB85 = _id_66122A002AFF5D57::_id_ECDFC73E68DCC209(_id_811ABFDB6C33F17F);

        if(isDefined(_id_AB0EE360900BCB85))
          _id_66122A002AFF5D57::br_ammo_give_type(player, _id_811ABFDB6C33F17F, _id_AB0EE360900BCB85);
      }

      if(!_id_98E31F0A4B5B4FD8) {
        player.starting_weapon = weapon;
        player.primaryweaponobj = weapon;
        _id_98E31F0A4B5B4FD8 = 1;
      } else {
        player.secondaryweaponobj = weapon;
        player.default_starting_pistol = weapon;
        player.secondaryweaponobj = weapon;
      }
    }
  }

  if(isDefined(player.pers["munitions"])) {
    _id_2EB600F8CA5D6625 = player.pers["munitions"];

    foreach(_id_A7F7342ABACA0E34 in _id_2EB600F8CA5D6625) {
      if(isDefined(_id_A7F7342ABACA0E34) && _id_A7F7342ABACA0E34 != "" && _id_A7F7342ABACA0E34 != "none")
        player thread _id_5E5507D57BBBB709::_id_4A1FD54AFFDAA367(_id_A7F7342ABACA0E34, 1, 1, 0, 1);
    }
  }

  thread wait_and_force_weapon_switch(player.starting_weapon, 1);

  if(!isDefined(player.pers["powers"]) && !isDefined(player.pers["equipment"])) {
    return;
  }
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(getdvarint("dvar_BD445B33649DDB33", 0) && isDefined(player.pers["equipment"]) && isDefined(checkpoint)) {
    if(isDefined(player.pers["equipment"]["primary"])) {
      if(isstruct(player.pers["equipment"]["primary"]) && isDefined(player.pers["equipment"]["primary"].equipment)) {
        player thread _id_7EF95BBA57DC4B82::giveequipment(player.pers["equipment"]["primary"].equipment, "primary");
        player thread _id_7EF95BBA57DC4B82::setequipmentammo(player.pers["equipment"]["primary"].equipment, player.pers["equipment"]["primary"].count);
      } else {
        player thread _id_7EF95BBA57DC4B82::giveequipment(player.pers["equipment"]["primary"], "primary");
        player thread _id_7EF95BBA57DC4B82::setequipmentammo(player.pers["equipment"]["primary"], player _id_7EF95BBA57DC4B82::getequipmentmaxammo(player.pers["equipment"]["primary"]));
      }
    }

    if(isDefined(player.pers["equipment"]["secondary"])) {
      if(isstruct(player.pers["equipment"]["primary"]) && isDefined(player.pers["equipment"]["secondary"].equipment)) {
        player thread _id_7EF95BBA57DC4B82::giveequipment(player.pers["equipment"]["secondary"].equipment, "secondary");
        player thread _id_7EF95BBA57DC4B82::setequipmentammo(player.pers["equipment"]["secondary"].equipment, player.pers["equipment"]["secondary"].count);
      } else {
        player thread _id_7EF95BBA57DC4B82::giveequipment(player.pers["equipment"]["secondary"], "secondary");
        player thread _id_7EF95BBA57DC4B82::setequipmentammo(player.pers["equipment"]["secondary"], player _id_7EF95BBA57DC4B82::getequipmentmaxammo(player.pers["equipment"]["secondary"]));
      }
    }
  }

  if(isDefined(player.pers["backpack"]) && player.pers["backpack"].size >= 1) {
    _id_58536EC7C448AA09 = player.pers["backpack"];
    _id_206AB2DF235DA70F = player.pers["backpack_amounts"];
    _id_AC0E5C4AC96AAA41 = 0;

    foreach(equipment in _id_58536EC7C448AA09) {
      if(isDefined(equipment) && equipment != "" && equipment != "none") {
        if(equipment == "interactable_note_keycard_raid4_maze" || equipment == "interactable_note_keycard_raid4_maze_2") {
          player _id_8938F74AFDBE2683();
          continue;
        }

        if(equipment == "interactable_note_keycard_a" || equipment == "interactable_note_keycard_b" || equipment == "interactable_note_keycard_c")
          continue;
        else {
          for(_id_AC0E5B4AC96AA80E = 0; _id_AC0E5B4AC96AA80E < _id_206AB2DF235DA70F[_id_AC0E5C4AC96AAA41]; _id_AC0E5B4AC96AA80E++)
            player _id_531CB1BE084314F7::br_forcegivecustompickupitem(player, equipment, 0, 1, 0, 0, _id_AC0E5C4AC96AAA41);
        }
      }

      _id_AC0E5C4AC96AAA41++;
    }
  }
}

_id_498B69E3A197B893(interaction, _id_350509BE582A5426, _id_EC8578A96ED649BC) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  interaction._id_591860925CE23B5D = ::enableplayeruse;
  interaction._id_890378114C004D66 = ::disableplayeruse;

  if(istrue(_id_EC8578A96ED649BC)) {
    interaction._id_591860925CE23B5D = ::_id_3D60A67E9D120AAB;
    interaction._id_890378114C004D66 = ::_id_D9BED4675EA53492;
  }

  interaction[[interaction._id_890378114C004D66]](self);
  level thread _id_3151E0CE2D788CCE(self, interaction);
  self setclientomnvar("cp_open_cac", -1);
  self setclientomnvar("ui_options_menu", 2);
  msg = scripts\engine\utility::waittill_any_ents_return(self, "loadout_given", self, "loadout_menu_closed");

  if(isDefined(msg) && msg == "loadout_given" && istrue(_id_350509BE582A5426))
    interaction notify("disabled_for_player", self);

  wait 1;
  self setclientomnvar("cp_open_cac", -2);

  if(isDefined(msg) && msg == "loadout_menu_closed")
    interaction[[interaction._id_591860925CE23B5D]](self);
  else if(isDefined(msg) && msg == "loadout_given" && !istrue(_id_350509BE582A5426)) {
    interaction[[interaction._id_591860925CE23B5D]](self);

    if(isDefined(level._id_377071435EDF746D))
      _id_7EF95BBA57DC4B82::_id_707926E6CE8DDC60("primary", level._id_377071435EDF746D);

    if(isDefined(level._id_1126CD09894FF2E1))
      _id_7EF95BBA57DC4B82::_id_707926E6CE8DDC60("secondary", level._id_1126CD09894FF2E1);

    wait 1;

    foreach(weapon in self.weaponlist) {
      clip_ammo = weaponclipsize(weapon);
      self setweaponammoclip(weapon, clip_ammo);
      _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(weapon);
    }
  } else if(isDefined(msg) && msg == "loadout_given" && istrue(_id_350509BE582A5426)) {
    if(isDefined(level._id_377071435EDF746D))
      _id_7EF95BBA57DC4B82::_id_707926E6CE8DDC60("primary", level._id_377071435EDF746D);

    if(isDefined(level._id_1126CD09894FF2E1))
      _id_7EF95BBA57DC4B82::_id_707926E6CE8DDC60("secondary", level._id_1126CD09894FF2E1);

    wait 1;

    foreach(weapon in self.weaponlist) {
      clip_ammo = weaponclipsize(weapon);
      self setweaponammoclip(weapon, clip_ammo);
      _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(weapon);
    }
  }
}

_id_3151E0CE2D788CCE(player, interaction) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("loadout_menu_closed");
  player waittill("last_stand_start");
  level thread _id_4006819486E3B7CC(player, interaction);
  player setclientomnvar("cp_open_cac", -2);
  player clearsoundsubmix("cp_store_duck", 1);
}

_id_4006819486E3B7CC(player, interaction) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("revive");
  player waittill("respawn_player");

  if(isDefined(interaction) && isPlayer(player))
    interaction[[interaction._id_591860925CE23B5D]](player);
}

_id_3D60A67E9D120AAB(player) {
  if(!isDefined(self.playerscaptured))
    self.playerscaptured = [];

  self.playerscaptured = scripts\engine\utility::array_remove(self.playerscaptured, player);
}

_id_D9BED4675EA53492(player) {
  if(!isDefined(self.playerscaptured))
    self.playerscaptured = [];

  self.playerscaptured = scripts\engine\utility::array_add(self.playerscaptured, player);
}

_id_2DAD855D27735128(struct) {
  if(!isDefined(struct._id_E4783B05BC8B859F))
    struct._id_E4783B05BC8B859F = "none";

  if(struct._id_E4783B05BC8B859F == "none")
    struct._id_E4783B05BC8B859F = "iw9_me_diveknife_mp";
}

_id_9743C56A4D2DC135(struct) {
  if(struct._id_E4783B05BC8B859F != "none")
    scripts\cp_mp\utility\inventory_utility::_giveweapon(level._id_F9E0E2877B743202);

  self._id_350710EA016EAC45 = struct._id_E4783B05BC8B859F;
}

_id_A01818AE9EDECBE6(_id_D89162F9D72CBFE1) {
  if(self hasweapon(level._id_F9E0E2877B743202)) {
    return;
  }
  scripts\cp_mp\utility\inventory_utility::_giveweapon(level._id_F9E0E2877B743202);

  if(istrue(_id_D89162F9D72CBFE1))
    thread _id_48C0BDF6DD0F6DDE();
}

_id_A6EB74F88574F882(_id_D89162F9D72CBFE1) {
  if(self hasweapon(level._id_A2DF868742D5F192)) {
    return;
  }
  scripts\cp_mp\utility\inventory_utility::_giveweapon(level._id_A2DF868742D5F192);
}

_id_48C0BDF6DD0F6DDE() {
  self endon("death_or_disconnect");
  _id_893FF9B814E04F95 = self getcurrentweapon();

  if(_id_893FF9B814E04F95.basename == "none" || _id_893FF9B814E04F95.basename == "iw9_me_diveknife_mp") {
    _id_102D661B1CAA8BC1 = undefined;
    _id_B954F3014FD20EA1 = self getweaponslistprimaries();

    if(_id_B954F3014FD20EA1.size > 0) {
      foreach(_id_D5CBBAC9155CA995 in _id_B954F3014FD20EA1) {
        if(_id_D5CBBAC9155CA995.basename != "none" && _id_D5CBBAC9155CA995.basename != "iw9_me_diveknife_mp") {
          _id_102D661B1CAA8BC1 = _id_D5CBBAC9155CA995;
          break;
        }
      }
    }

    if(isDefined(_id_102D661B1CAA8BC1)) {
      while(self _meth_E40102956C887F7C())
        wait 0.05;

      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(_id_102D661B1CAA8BC1);
      return;
    }
  }
}

cac_getloadoutselectedidx() {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "cpLoadoutSel");
}

cac_getloadoutperk(_id_089688461C79EF11, _id_2B8554E15B5C8E77) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "loadoutPerks", _id_2B8554E15B5C8E77);
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "loadoutPerks", _id_2B8554E15B5C8E77);
}

cac_getweapon(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", _id_FE4048AD22C35D73, "weapon");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "weapon");
}

cac_getweaponattachment(_id_089688461C79EF11, _id_FE4048AD22C35D73, _id_DF6D8E005B4B8020) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", _id_FE4048AD22C35D73, "attachmentSetup", _id_DF6D8E005B4B8020, "attachment");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "attachmentSetup", _id_DF6D8E005B4B8020, "attachment");
}

cac_getweaponattachmentid(_id_089688461C79EF11, _id_FE4048AD22C35D73, _id_DF6D8E005B4B8020) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "attachmentSetup", _id_DF6D8E005B4B8020, "variantID");
}

cac_getweaponlootitemid(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", _id_FE4048AD22C35D73, "lootItemID");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "lootItemID");
}

cac_getweaponvariantid(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", _id_FE4048AD22C35D73, "variantID");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "variantID");
}

cac_getweaponcamo(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", _id_FE4048AD22C35D73, "camo");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "camo");
}

cac_getweaponreticle(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", _id_FE4048AD22C35D73, "reticle");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "reticle");
}

cac_getweaponcosmeticattachment(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", _id_FE4048AD22C35D73, "cosmeticAttachment");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "cosmeticAttachment");
}

cac_getequipmentprimary(_id_089688461C79EF11) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 0, "equipment");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "equipmentSetups", 0, "equipment");
}

cac_getextraequipmentprimary(_id_089688461C79EF11) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 0, "extraCharge");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "equipmentSetups", 0, "extraCharge");
}

cac_getequipmentsecondary(_id_089688461C79EF11) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 1, "equipment");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "equipmentSetups", 1, "equipment");
}

cac_getextraequipmentsecondary(_id_089688461C79EF11) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 1, "extraCharge");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "equipmentSetups", 1, "extraCharge");
}

loadout_getclassstruct() {
  struct = spawnStruct();
  struct.loadoutarchetype = "none";
  struct.loadoutprimary = "none";
  struct.loadoutprimaryattachments = [];
  struct.loadoutprimaryattachmentids = [];

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 5; _id_DF6D8E005B4B8020++) {
    struct.loadoutprimaryattachments[_id_DF6D8E005B4B8020] = "none";
    struct.loadoutprimaryattachmentids[_id_DF6D8E005B4B8020] = 0;
  }

  struct.loadoutprimarycamo = "none";
  struct.loadoutprimaryreticle = "none";
  struct.loadoutprimarylootitemid = 0;
  struct.loadoutprimaryvariantid = -1;
  struct.loadoutprimarycosmeticattachment = "none";
  struct.loadoutprimaryweaponstickers = [];

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 5; _id_36D2ABBDCBCB186C++)
    struct.loadoutprimarystickers[_id_36D2ABBDCBCB186C] = "none";

  struct.loadoutsecondary = "none";
  struct.loadoutsecondaryattachments = [];
  struct.loadoutsecondaryattachmentids = [];

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 5; _id_DF6D8E005B4B8020++) {
    struct.loadoutsecondaryattachments[_id_DF6D8E005B4B8020] = "none";
    struct.loadoutsecondaryattachmentids[_id_DF6D8E005B4B8020] = 0;
  }

  struct.loadoutsecondarycamo = "none";
  struct.loadoutsecondaryreticle = "none";
  struct.loadoutsecondarylootitemid = 0;
  struct.loadoutsecondaryvariantid = -1;
  struct.loadoutsecondarycosmeticattachment = "none";
  struct.loadoutsecondaryweaponstickers = [];

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 4; _id_36D2ABBDCBCB186C++)
    struct.loadoutsecondaryweaponstickers[_id_36D2ABBDCBCB186C] = "none";

  struct.loadoutmeleeslot = "none";
  struct.loadoutperksfromgamemode = 0;
  struct.loadoutperks = [];
  struct.loadoutstandardperks = [];
  struct.loadoutextraperks = [];
  struct.loadoutrigtrait = "specialty_null";
  struct.loadoutequipmentprimary = "none";
  struct.loadoutextraequipmentprimary = 0;
  struct.loadoutequipmentsecondary = "none";
  struct.loadoutextraequipmentsecondary = 0;
  struct.loadoutsuper = "none";
  struct.loadoutfieldupgrade1 = "none";
  struct.loadoutfieldupgrade2 = "none";
  struct.loadoutgesture = "none";
  struct.loadoutaccessorydata = "none";
  struct.loadoutaccessoryweapon = "none";
  struct.loadoutexecution = "none";
  struct.loadoutstreaksfilled = 0;
  struct.loadoutstreaktype = "streaktype_assault";
  struct.loadoutkillstreak1 = "none";
  struct.loadoutkillstreak2 = "none";
  struct.loadoutkillstreak3 = "none";
  struct._id_E4783B05BC8B859F = "none";
  return struct;
}

loadout_updateclasscustom(struct, class, _id_168B196E80C44544) {
  _id_089688461C79EF11 = class;
  self.class_num = _id_089688461C79EF11;
  struct.loadoutprimary = cac_getweapon(_id_089688461C79EF11, 0);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 5; _id_DF6D8E005B4B8020++) {
    struct.loadoutprimaryattachments[_id_DF6D8E005B4B8020] = cac_getweaponattachment(_id_089688461C79EF11, 0, _id_DF6D8E005B4B8020);
    struct.loadoutprimaryattachmentids[_id_DF6D8E005B4B8020] = cac_getweaponattachmentid(_id_089688461C79EF11, 0, _id_DF6D8E005B4B8020);
  }

  if(!istrue(_id_168B196E80C44544)) {
    struct.loadoutprimarycamo = cac_getweaponcamo(_id_089688461C79EF11, 0);
    struct.loadoutprimaryreticle = cac_getweaponreticle(_id_089688461C79EF11, 0);
    struct.loadoutprimarylootitemid = cac_getweaponlootitemid(_id_089688461C79EF11, 0);
    struct.loadoutprimaryvariantid = cac_getweaponvariantid(_id_089688461C79EF11, 0);
    struct.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment(_id_089688461C79EF11, 0);

    for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 5; _id_36D2ABBDCBCB186C++)
      struct.loadoutprimarystickers[_id_36D2ABBDCBCB186C] = cac_getweaponsticker(_id_089688461C79EF11, 0, _id_36D2ABBDCBCB186C);
  } else {
    for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 5; _id_DF6D8E005B4B8020++)
      struct.loadoutprimaryattachmentids[_id_DF6D8E005B4B8020] = 0;
  }

  struct.loadoutsecondary = cac_getweapon(_id_089688461C79EF11, 1);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 5; _id_DF6D8E005B4B8020++) {
    struct.loadoutsecondaryattachments[_id_DF6D8E005B4B8020] = cac_getweaponattachment(_id_089688461C79EF11, 1, _id_DF6D8E005B4B8020);
    struct.loadoutsecondaryattachmentids[_id_DF6D8E005B4B8020] = cac_getweaponattachmentid(_id_089688461C79EF11, 1, _id_DF6D8E005B4B8020);
  }

  if(!istrue(_id_168B196E80C44544)) {
    struct.loadoutsecondarycamo = cac_getweaponcamo(_id_089688461C79EF11, 1);
    struct.loadoutsecondaryreticle = cac_getweaponreticle(_id_089688461C79EF11, 1);
    struct.loadoutsecondarylootitemid = cac_getweaponlootitemid(_id_089688461C79EF11, 1);
    struct.loadoutsecondaryvariantid = cac_getweaponvariantid(_id_089688461C79EF11, 1);
    struct.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment(_id_089688461C79EF11, 1);

    for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 4; _id_36D2ABBDCBCB186C++)
      struct.loadoutsecondarystickers[_id_36D2ABBDCBCB186C] = cac_getweaponsticker(_id_089688461C79EF11, 1, _id_36D2ABBDCBCB186C);
  } else {
    for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 5; _id_DF6D8E005B4B8020++)
      struct.loadoutsecondaryattachmentids[_id_DF6D8E005B4B8020] = 0;
  }

  struct.loadoutequipmentprimary = cac_getequipmentprimary(_id_089688461C79EF11);
  struct.loadoutextraequipmentprimary = cac_getextraequipmentprimary(_id_089688461C79EF11);
  struct.loadoutequipmentsecondary = cac_getequipmentsecondary(_id_089688461C79EF11);
  struct.loadoutextraequipmentsecondary = cac_getextraequipmentsecondary(_id_089688461C79EF11);
  struct.loadoutgesture = cac_getgesture();
  struct.loadoutexecution = cac_getexecution();
  struct.loadoutaccessoryweapon = cac_getaccessoryweapon();
  struct.loadoutaccessorydata = cac_getaccessorydata();
  struct.loadoutaccessorylogic = cac_getaccessorylogic();
  _id_2DAD855D27735128(struct);
  return struct;
}

validateloadout(loadout) {
  _id_35CCABD9AD4E542F = 0;

  if(!_id_2669878CF5A1B6BC::_id_89497FA763D431C0(loadout.loadoutprimary))
    _id_35CCABD9AD4E542F = 1;
  else if(isweaponuihidden(loadout.loadoutprimary))
    _id_35CCABD9AD4E542F = 1;

  if(weaponisrestricted(loadout.loadoutprimary)) {
    _id_35CCABD9AD4E542F = 1;
    _id_BC72F32B1575D517 = 1;
  }

  if(_id_35CCABD9AD4E542F) {
    loadout.loadoutprimary = "iw8_ar_mike4";
    loadout.loadoutprimaryattachments = [];
    loadout.loadoutprimarycamo = "none";
    loadout.loadoutprimaryreticle = "none";
    loadout.loadoutprimaryvariantid = -1;
    loadout.loadoutprimaryattachmentids = [];
    loadout.loadoutprimarycosmeticattachment = "none";
    loadout.loadoutprimarystickers[0] = "none";
    loadout.loadoutprimarystickers[1] = "none";
    loadout.loadoutprimarystickers[2] = "none";
    loadout.loadoutprimarystickers[3] = "none";
    loadout.loadoutprimarystickers[4] = "none";
  } else {
    if(isweaponvariantlocked(loadout.loadoutprimary, loadout.loadoutprimaryvariantid))
      loadout.loadoutprimaryvariantid = -1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < loadout.loadoutprimaryattachments.size; _id_AC0E594AC96AA3A8++) {
      attachment = loadout.loadoutprimaryattachments[_id_AC0E594AC96AA3A8];
      _id_E7BA2038935530DB = loadout.loadoutprimaryattachmentids[_id_AC0E594AC96AA3A8];

      if(isattachmentvariantlocked(loadout.loadoutprimary, attachment, _id_E7BA2038935530DB))
        loadout.loadoutprimaryattachmentids[_id_AC0E594AC96AA3A8] = 0;

      if(attachment != "none" && (attachmentisrestricted(attachment, loadout.loadoutprimary) || !isvalidattachmentunlock(loadout.loadoutprimary, attachment))) {
        loadout.loadoutprimaryattachments[_id_AC0E594AC96AA3A8] = "none";
        _id_E1388376A5BE9B75 = 1;
      }
    }
  }

  _id_35CCABD9AD4E542F = 0;

  if(!_id_2669878CF5A1B6BC::_id_89497FA763D431C0(loadout.loadoutsecondary))
    _id_35CCABD9AD4E542F = 1;
  else if(isweaponuihidden(loadout.loadoutsecondary))
    _id_35CCABD9AD4E542F = 1;

  if(weaponisrestricted(loadout.loadoutsecondary)) {
    _id_35CCABD9AD4E542F = 1;
    _id_BC72F32B1575D517 = 1;
  }

  if(_id_35CCABD9AD4E542F) {
    loadout.loadoutsecondary = "iw8_pi_mike1911";
    loadout.loadoutsecondaryattachments = [];
    loadout.loadoutsecondarycamo = "none";
    loadout.loadoutsecondaryreticle = "none";
    loadout.loadoutsecondaryvariantid = -1;
    loadout.loadoutsecondaryattachmentids = [];
    loadout.loadoutsecondarycosmeticattachment = "none";
    loadout.loadoutsecondarystickers[0] = "none";
    loadout.loadoutsecondarystickers[1] = "none";
    loadout.loadoutsecondarystickers[2] = "none";
    loadout.loadoutsecondarystickers[3] = "none";
    loadout.loadoutsecondarystickers[4] = "none";
  } else {
    if(isweaponvariantlocked(loadout.loadoutsecondary, loadout.loadoutsecondaryvariantid))
      loadout.loadoutsecondaryvariantid = -1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < loadout.loadoutsecondaryattachments.size; _id_AC0E594AC96AA3A8++) {
      attachment = loadout.loadoutsecondaryattachments[_id_AC0E594AC96AA3A8];
      _id_E7BA2038935530DB = loadout.loadoutsecondaryattachmentids[_id_AC0E594AC96AA3A8];

      if(isattachmentvariantlocked(loadout.loadoutsecondary, attachment, _id_E7BA2038935530DB))
        loadout.loadoutsecondaryattachmentids[_id_AC0E594AC96AA3A8] = 0;

      if(attachment != "none" && (attachmentisrestricted(attachment, loadout.loadoutsecondary) || !isvalidattachmentunlock(loadout.loadoutsecondary, attachment))) {
        loadout.loadoutsecondaryattachments[_id_AC0E594AC96AA3A8] = "none";
        _id_E1388376A5BE9B75 = 1;
      }
    }
  }

  return loadout;
}

isvalidattachmentunlock(_id_49E6EF3EDADD524E, _id_55F8624E7216D9AA) {
  _id_338C04A2F19BA8B6 = getdvarint("dvar_464624F0183DE3D0", 0) == 1;

  if(_id_338C04A2F19BA8B6)
    return attachmentisselectablerootname(_id_49E6EF3EDADD524E, _id_55F8624E7216D9AA);

  return 1;
}

attachmentisselectablerootname(_id_49E6EF3EDADD524E, _id_55F8624E7216D9AA) {
  _id_D38C5F29184756DD = level.weaponattachments[_id_49E6EF3EDADD524E];
  return isDefined(_id_D38C5F29184756DD) && isDefined(_id_D38C5F29184756DD[_id_55F8624E7216D9AA]);
}

isweaponuihidden(_id_49E6EF3EDADD524E) {
  return isDefined(level.weaponmapdata[_id_49E6EF3EDADD524E]) && istrue(level.weaponmapdata[_id_49E6EF3EDADD524E].uihidden);
}

isweaponvariantlocked(_id_49E6EF3EDADD524E, variantid) {
  if(!isDefined(variantid) || variantid <= 0)
    return 0;

  _id_A6ED1602A5107749 = _id_49E6EF3EDADD524E + "|" + variantid;
  return isDefined(level.weaponlootmapdata[_id_A6ED1602A5107749]) && istrue(level.weaponlootmapdata[_id_A6ED1602A5107749].islocked);
}

isattachmentvariantlocked(_id_49E6EF3EDADD524E, attachment, _id_1708B873A34EEB50) {
  if(!isDefined(_id_1708B873A34EEB50) || _id_1708B873A34EEB50 == 0 || attachment == "none")
    return 0;

  _id_FFE43E0D1655060E = 0;
  _id_ABF526089D208196 = 1;

  for(;;) {
    _id_A6ED1602A5107749 = _id_49E6EF3EDADD524E + "|" + _id_ABF526089D208196;

    if(!isDefined(level.weaponlootmapdata[_id_A6ED1602A5107749])) {
      break;
    }

    if(!level.weaponlootmapdata[_id_A6ED1602A5107749].islocked) {
      if(isDefined(level.weaponlootmapdata[_id_A6ED1602A5107749].attachcustomtoidmap)) {
        foreach(key, id in level.weaponlootmapdata[_id_A6ED1602A5107749].attachcustomtoidmap) {
          if(_id_1708B873A34EEB50 == id && attachment == key) {
            _id_FFE43E0D1655060E = 1;
            break;
          }
        }
      }

      if(_id_FFE43E0D1655060E) {
        break;
      }
    }

    _id_ABF526089D208196++;
  }

  return !_id_FFE43E0D1655060E;
}

cac_getgesture() {
  _id_DA50F25E979BAB7D = "none";

  if(isDefined(self.changedarchetypeinfo)) {
    _id_6D1A148EFA806994 = level.archetypeids[self.changedarchetypeinfo.archetype];
    _id_DA50F25E979BAB7D = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePreferences", _id_6D1A148EFA806994, "gesture");
  } else
    _id_DA50F25E979BAB7D = self getplayerdata(level.loadoutsgroup, "squadMembers", "gesture");

  return scripts\cp_mp\gestures::getgesturedata(_id_DA50F25E979BAB7D);
}

cac_getaccessoryweapon() {
  _id_160F3CB2BB4232D3 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\cp\cp_accessories::getaccessoryweaponbyindex(_id_160F3CB2BB4232D3);
}

cac_getaccessorydata() {
  _id_160F3CB2BB4232D3 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\cp\cp_accessories::getaccessorydatabyindex(_id_160F3CB2BB4232D3);
}

cac_getaccessorylogic() {
  _id_160F3CB2BB4232D3 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\cp\cp_accessories::getaccessorylogicbyindex(_id_160F3CB2BB4232D3);
}

cac_getexecution() {
  return "neck_stab";
}

cac_getweaponsticker(_id_089688461C79EF11, _id_FE4048AD22C35D73, _id_36D2ABBDCBCB186C) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "sticker", _id_36D2ABBDCBCB186C);
}

_id_578FA1963D5F94AC(player, _id_4EFDB87F020AAE7D, _id_D0EF877013D341AF) {
  if(scripts\cp\utility::is_wave_gametype()) {
    perk = cac_getloadoutperk(undefined, 2);

    if(perk == "specialty_extra_shrapnel")
      scripts\cp\utility::giveperk("specialty_extra_deadly");
  }

  if(scripts\cp\utility::_hasperk("specialty_extra_deadly") && _id_4EFDB87F020AAE7D == "primary")
    return 2;

  if(isDefined(self.perk_data["offhand_count"]))
    return self.perk_data["offhand_count"];

  return 1;
}

_id_F505F60C194B2770(_id_019CD48B2DAF2547) {
  return _id_019CD48B2DAF2547;
}

give_weapon_alt_clip_ammo_hack(player, weaponobj) {
  _id_6890A4CE965BBA99 = weaponobj getaltweapon();

  if(_id_6890A4CE965BBA99.basename != "none") {
    _id_91093EF03654702C = weaponclass(_id_6890A4CE965BBA99);

    if(_id_91093EF03654702C == "spread")
      player setweaponammoclip(_id_6890A4CE965BBA99, weaponclipsize(_id_6890A4CE965BBA99));
  }

  return weaponobj;
}

_id_ACAD491093697C6C(_id_00CEBA6EC7E8CA50) {
  if(!isDefined(level._id_F64740277F13E29B) || level._id_F64740277F13E29B.id != _id_00CEBA6EC7E8CA50) {
    level._id_F64740277F13E29B = spawnStruct();
    level._id_F64740277F13E29B.id = _id_00CEBA6EC7E8CA50;
    level._id_F64740277F13E29B._id_92F35FCFAE58B4EB = [];
    level._id_F64740277F13E29B._id_09DDC180A1A5121D = getscriptbundle(_id_00CEBA6EC7E8CA50);
  }

  return level._id_F64740277F13E29B;
}

_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  _id_F64740277F13E29B = _id_ACAD491093697C6C(_id_00CEBA6EC7E8CA50);

  if(!isDefined(_id_F64740277F13E29B._id_92F35FCFAE58B4EB[_id_089688461C79EF11])) {
    _id_5FF608A2CF5C041B = _id_F64740277F13E29B._id_09DDC180A1A5121D._id_8D5460BE7DB831C3[_id_089688461C79EF11];
    _id_F64740277F13E29B._id_92F35FCFAE58B4EB[_id_089688461C79EF11] = getscriptbundle("classtableentry:" + _id_5FF608A2CF5C041B._id_F90358454413407F);
  }

  return _id_F64740277F13E29B._id_92F35FCFAE58B4EB[_id_089688461C79EF11];
}

_id_DF2933F96D726D71(_id_00CEBA6EC7E8CA50) {
  _id_F64740277F13E29B = _id_ACAD491093697C6C(_id_00CEBA6EC7E8CA50);
  return _id_F64740277F13E29B._id_09DDC180A1A5121D._id_8D5460BE7DB831C3.size;
}

table_getweapon(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(_id_FE4048AD22C35D73 == 0)
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon.weapon;
  else
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon.weapon;
}

table_getweaponattachment(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_FE4048AD22C35D73, _id_DF6D8E005B4B8020) {
  _id_AD6F9AC053FF4870 = "none";
  classstruct = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11);

  if(!isDefined(classstruct.primaryweapon.attachments))
    classstruct.primaryweapon.attachments = [classstruct.primaryweapon._id_59F68715C04CE28F, classstruct.primaryweapon._id_59F68815C04CE4C2, classstruct.primaryweapon._id_59F68915C04CE6F5, classstruct.primaryweapon._id_59F68215C04CD790, classstruct.primaryweapon._id_59F68315C04CD9C3, classstruct.primaryweapon._id_59F68415C04CDBF6];

  if(!isDefined(classstruct.secondaryweapon.attachments))
    classstruct.secondaryweapon.attachments = [classstruct.secondaryweapon._id_59F68715C04CE28F, classstruct.secondaryweapon._id_59F68815C04CE4C2, classstruct.secondaryweapon._id_59F68915C04CE6F5, classstruct.secondaryweapon._id_59F68215C04CD790, classstruct.secondaryweapon._id_59F68315C04CD9C3];

  if(_id_FE4048AD22C35D73 == 0)
    _id_AD6F9AC053FF4870 = classstruct.primaryweapon.attachments[_id_DF6D8E005B4B8020];
  else
    _id_AD6F9AC053FF4870 = classstruct.secondaryweapon.attachments[_id_DF6D8E005B4B8020];

  if(!isDefined(_id_AD6F9AC053FF4870) || _id_AD6F9AC053FF4870 == "")
    return "none";
  else
    return _id_AD6F9AC053FF4870;
}

table_getweaponcamo(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(_id_FE4048AD22C35D73 == 0)
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon.camo;
  else
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon.camo;
}

table_getweaponreticle(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(_id_FE4048AD22C35D73 == 0)
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon.reticle;
  else
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon.reticle;
}

table_getequipmentprimary(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).equipment.primary;
}

table_getextraequipmentprimary(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  value = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11)._id_AD6972268C86A2BE.primary;
  return isDefined(value) && value == "1";
}

table_getequipmentsecondary(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).equipment._id_D7B9856A19F9B6B5;
}

table_getextraequipmentsecondary(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  value = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11)._id_AD6972268C86A2BE._id_D7B9856A19F9B6B5;
  return isDefined(value) && value == 1;
}

table_getgesture(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).gesture;
}

table_getperk(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_2B8554E15B5C8E77) {
  classstruct = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11);

  if(!isDefined(classstruct._id_77BC1C85DC4C173F))
    classstruct._id_77BC1C85DC4C173F = [classstruct.perks._id_16680ABD1742C050, classstruct.perks._id_16680DBD1742C6E9, classstruct.perks._id_16680CBD1742C4B6];

  return classstruct._id_77BC1C85DC4C173F[_id_2B8554E15B5C8E77];
}

_id_E2D370937C694C58(loadoutprimary, _id_8424B86904D76746, loadoutsecondary, _id_EC4F8B19B8A264DF, loadoutequipmentprimary, loadoutequipmentsecondary) {
  if(scripts\cp\cp_relics::is_relic_active("relic_oneInTheChamber")) {
    loadoutprimary = "iw9_dm_xmike2010_mp";
    _id_8424B86904D76746 = ["silencer", "laser"];
    loadoutsecondary = "iw9_pi_decho_mp";
    _id_EC4F8B19B8A264DF = ["silencer", "laserpstl_ads01"];
    loadoutequipmentprimary = "equip_throwing_knife";
  }

  _id_D0EF877013D341AF = spawnStruct();

  if(isDefined(loadoutprimary)) {
    _id_85C961F7BE4FBA08 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4(loadoutprimary);
    _id_D0EF877013D341AF.loadoutprimary = _id_85C961F7BE4FBA08.basename;

    if(isDefined(_id_8424B86904D76746)) {
      _id_85C961F7BE4FBA08 = _id_85C961F7BE4FBA08 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(_id_8424B86904D76746);
      _id_D0EF877013D341AF.loadoutprimaryattachments = _id_85C961F7BE4FBA08.attachments;
    } else {
      _id_8424B86904D76746 = ["none", "none", "none", "none", "none", "none"];
      _id_D0EF877013D341AF.loadoutprimaryattachments = _id_8424B86904D76746;
    }

    _id_D0EF877013D341AF.loadoutprimarycamo = "none";
    _id_D0EF877013D341AF.loadoutprimaryreticle = "none";
    _id_D0EF877013D341AF.loadoutprimaryvariantid = -1;
    _id_D0EF877013D341AF.loadoutprimarypaintjobid = 0;
    _id_D0EF877013D341AF.loadoutprimarycosmeticattachment = "none";
    _id_D0EF877013D341AF.loadoutprimarystickers[0] = "none";
    _id_D0EF877013D341AF.loadoutprimarystickers[1] = "none";
    _id_D0EF877013D341AF.loadoutprimarystickers[2] = "none";
    _id_D0EF877013D341AF.loadoutprimarystickers[3] = "none";
    _id_D0EF877013D341AF.loadoutprimarystickers[4] = "none";
  }

  if(isDefined(loadoutsecondary)) {
    _id_4439306AA2DB124B = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4(loadoutsecondary);
    _id_D0EF877013D341AF.loadoutsecondary = _id_4439306AA2DB124B.basename;

    if(isDefined(_id_EC4F8B19B8A264DF)) {
      _id_4439306AA2DB124B = _id_4439306AA2DB124B _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(_id_EC4F8B19B8A264DF);
      _id_D0EF877013D341AF.loadoutsecondaryattachments = _id_4439306AA2DB124B.attachments;
    } else {
      _id_EC4F8B19B8A264DF = ["none", "none", "none", "none", "none", "none"];
      _id_D0EF877013D341AF.loadoutsecondaryattachments = _id_EC4F8B19B8A264DF;
    }

    if(scripts\cp\cp_relics::is_relic_active("relic_oneInTheChamber"))
      _id_D0EF877013D341AF.loadoutsecondarycamo = "camo_k_04";
    else
      _id_D0EF877013D341AF.loadoutsecondarycamo = "none";

    _id_D0EF877013D341AF.loadoutsecondaryreticle = "none";
    _id_D0EF877013D341AF.loadoutsecondaryvariantid = -1;
    _id_D0EF877013D341AF._id_AC15239127EF4391 = 0;
    _id_D0EF877013D341AF.loadoutsecondarycosmeticattachment = "none";
    _id_D0EF877013D341AF.loadoutsecondarystickers[0] = "none";
    _id_D0EF877013D341AF.loadoutsecondarystickers[1] = "none";
    _id_D0EF877013D341AF.loadoutsecondarystickers[2] = "none";
    _id_D0EF877013D341AF.loadoutsecondarystickers[3] = "none";
    _id_D0EF877013D341AF.loadoutsecondarystickers[4] = "none";
  }

  level._id_36074F5DB982129D[level._id_36074F5DB982129D.size] = _id_D0EF877013D341AF;
}

_id_EBF2582B122904FC(loadoutequipmentprimary, loadoutequipmentsecondary) {
  _id_D0EF877013D341AF = spawnStruct();
  _id_D0EF877013D341AF.loadoutequipmentprimary = loadoutequipmentprimary;
  _id_D0EF877013D341AF.loadoutequipmentsecondary = loadoutequipmentsecondary;
  level._id_B2640B98DEE64871[level._id_B2640B98DEE64871.size] = _id_D0EF877013D341AF;
}

_id_C03F8F1DC0DF9EAA(_id_D0EF877013D341AF) {
  if(isDefined(level._id_36074F5DB982129D) && isDefined(_id_D0EF877013D341AF) && level._id_36074F5DB982129D.size > 0) {
    _id_F790A21D25442E99 = level._id_36074F5DB982129D[randomint(level._id_36074F5DB982129D.size)];

    if(isDefined(_id_F790A21D25442E99.loadoutprimary))
      _id_D0EF877013D341AF.loadoutprimary = _id_F790A21D25442E99.loadoutprimary;

    if(isDefined(_id_F790A21D25442E99.loadoutprimaryattachments))
      _id_D0EF877013D341AF.loadoutprimaryattachments = _id_F790A21D25442E99.loadoutprimaryattachments;

    if(isDefined(_id_F790A21D25442E99.loadoutprimarycamo))
      _id_D0EF877013D341AF.loadoutprimarycamo = _id_F790A21D25442E99.loadoutprimarycamo;

    if(isDefined(_id_F790A21D25442E99.loadoutprimaryreticle))
      _id_D0EF877013D341AF.loadoutprimaryreticle = _id_F790A21D25442E99.loadoutprimaryreticle;

    if(isDefined(_id_F790A21D25442E99.loadoutprimaryvariantid))
      _id_D0EF877013D341AF.loadoutprimaryvariantid = _id_F790A21D25442E99.loadoutprimaryvariantid;

    if(isDefined(_id_F790A21D25442E99.loadoutprimarypaintjobid))
      _id_D0EF877013D341AF.loadoutprimarypaintjobid = _id_F790A21D25442E99.loadoutprimarypaintjobid;

    if(isDefined(_id_F790A21D25442E99.loadoutprimarycosmeticattachment))
      _id_D0EF877013D341AF.loadoutprimarycosmeticattachment = _id_F790A21D25442E99.loadoutprimarycosmeticattachment;

    if(isDefined(_id_F790A21D25442E99.loadoutsecondary))
      _id_D0EF877013D341AF.loadoutsecondary = _id_F790A21D25442E99.loadoutsecondary;

    if(isDefined(_id_F790A21D25442E99.loadoutsecondaryattachments))
      _id_D0EF877013D341AF.loadoutsecondaryattachments = _id_F790A21D25442E99.loadoutsecondaryattachments;

    if(isDefined(_id_F790A21D25442E99.loadoutsecondarycamo))
      _id_D0EF877013D341AF.loadoutsecondarycamo = _id_F790A21D25442E99.loadoutsecondarycamo;

    if(isDefined(_id_F790A21D25442E99.loadoutsecondaryreticle))
      _id_D0EF877013D341AF.loadoutsecondaryreticle = _id_F790A21D25442E99.loadoutsecondaryreticle;

    if(isDefined(_id_F790A21D25442E99.loadoutsecondaryvariantid))
      _id_D0EF877013D341AF.loadoutsecondaryvariantid = _id_F790A21D25442E99.loadoutsecondaryvariantid;

    if(isDefined(_id_F790A21D25442E99._id_33E425A1F6C8B34D))
      _id_D0EF877013D341AF._id_33E425A1F6C8B34D = _id_F790A21D25442E99._id_33E425A1F6C8B34D;
  }

  if(isDefined(level._id_B2640B98DEE64871) && isDefined(_id_D0EF877013D341AF) && level._id_B2640B98DEE64871.size > 0) {
    _id_F790A21D25442E99 = level._id_B2640B98DEE64871[randomint(level._id_B2640B98DEE64871.size)];

    if(isDefined(_id_F790A21D25442E99.loadoutequipmentprimary))
      _id_D0EF877013D341AF.loadoutequipmentprimary = _id_F790A21D25442E99.loadoutequipmentprimary;

    if(isDefined(_id_F790A21D25442E99.loadoutequipmentsecondary))
      _id_D0EF877013D341AF.loadoutequipmentsecondary = _id_F790A21D25442E99.loadoutequipmentsecondary;
  }

  return _id_D0EF877013D341AF;
}

lookupotheroperator(team) {
  if(!isPlayer(self) && !isai(self))
    return "";

  _id_3EDA0EF65C9478AC = scripts\engine\utility::ter_op(team == "allies", 1, 0);
  operatorref = "";

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !scripts\cp\utility::_id_138028CA2B958511()) {
    if(level.teambased && !isai(self))
      operatorref = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", _id_3EDA0EF65C9478AC);
  }

  return operatorref;
}

respawnitems_assignrespawnitems(respawnitems) {
  self.respawnitems = respawnitems;
}