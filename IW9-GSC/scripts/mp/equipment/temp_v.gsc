/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\temp_v.gsc
***********************************************/

init() {
  level._id_B35FC6D4A1B9424F = spawnStruct();
  level._id_B35FC6D4A1B9424F.powers = [];
  level._id_2DDD5FA2CFA55AFE = 0;
  _id_268C558DDB2267AA::_id_41C4A42AE28C7E16();
  level._effect["superPower_teleportOut"] = loadfx("vfx/iw9/gameplay/theboys/vfx_gameplay_theboys_teleport_out.vfx");
  game["dialog"]["supe_spotted"] = "game_ovld_spes";
  game["dialog"]["supe_lost"] = "game_ovld_spec";
  game["dialog"]["supe_killed"] = "game_ovld_sprk";
}

_id_D3F8E1C800B2E8C0() {
  thread scripts\mp\hud_message::showsplash("super_temp_v_pickup", undefined, self, undefined, undefined, undefined, 1);
}

_id_4364C764FCF6194D() {
  thread _id_A44C81F35835AB6F();
  _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "self_apply");
  return 1;
}

_id_A44C81F35835AB6F() {
  while(isDefined(self getheldoffhand()) && self getheldoffhand().basename == "tempv_mp")
    waitframe();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    self setclientomnvar("ui_super_warning", 1);

  if(isDefined(level._id_2DDD5FA2CFA55AFE)) {
    level._id_2DDD5FA2CFA55AFE--;

    if(level._id_2DDD5FA2CFA55AFE < 0)
      level._id_2DDD5FA2CFA55AFE = 0;
  }

  self setscriptablepartstate("superpowers_aura", "on", 0);
  self setscriptablepartstate("superpowers_veins", "on", 0);
  thread _id_ACF86641A7105328();
  thread _id_F2C35147CD83E1C7();
  _id_79CD1B77A631E77C(self);
  thread _id_A823070A9E81D9D8();
  thread _id_4C30D408AE45AA33();
  thread _id_CEF1C8463D56BB49();
}

_id_636D60AA04F7E10D() {
  return 1;
}

_id_C0B7105AAE16A9B3(mapname) {
  _id_2123D54C68C8EE8E = ["super_teleport_deploy", "super_electric_discharge", "super_high_jump", "super_laser_charge"];

  if(level.mapname == "mp_bio_lab" || level.mapname == "mp_biobunker")
    _id_2123D54C68C8EE8E = ["super_electric_discharge", "super_laser_charge"];

  return _id_2123D54C68C8EE8E;
}

_id_A823070A9E81D9D8() {
  _id_2123D54C68C8EE8E = _id_C0B7105AAE16A9B3(level.mapname);
  _id_F4CAE9D2914CC11B = randomint(_id_2123D54C68C8EE8E.size);
  _id_EF7579BE51267BDB = _id_2123D54C68C8EE8E[_id_F4CAE9D2914CC11B];
  _id_85071C984EECD1A9 = getDvar("dvar_18CC28F3820EDBD6", "");

  if(_id_85071C984EECD1A9 != "") {
    if(_id_85071C984EECD1A9 == "teleport")
      _id_EF7579BE51267BDB = "super_teleport_deploy";
    else if(_id_85071C984EECD1A9 == "electric")
      _id_EF7579BE51267BDB = "super_electric_discharge";
    else if(_id_85071C984EECD1A9 == "jump")
      _id_EF7579BE51267BDB = "super_high_jump";
    else if(_id_85071C984EECD1A9 == "laser")
      _id_EF7579BE51267BDB = "super_laser_charge";
  }

  equipname = "equip_";
  _id_A25D9C067A51BCEE = getsubstr(_id_EF7579BE51267BDB, 6);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    scripts\mp\supers::_id_08C7B1312CF5986B(0);
    equipname = equipname + _id_A25D9C067A51BCEE;
    _id_7E52B56769FA7774::_givebrsuper(equipname, _id_EF7579BE51267BDB, 1);
  } else {
    scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades(_id_EF7579BE51267BDB);
    scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded(), undefined, 0);
  }

  superid = level.superglobals.staticsuperdata[_id_EF7579BE51267BDB].id;
  self setclientomnvar("ui_field_upgrade_use", superid);
  scripts\mp\supers::showsuperremindersplash();
}

_id_95B57B12158252C3() {
  scripts\mp\supers::givesuper("super_melee_jugg", 0, 1);
}

_id_7BDDC961A86C19B2() {
  scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades("super_teleport_deploy");
}

_id_6460412BC7E7DF87() {
  scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades("super_electric_discharge");
}

_id_7705327AF583D75C() {
  scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades("super_high_jump");
}

_id_11E36F0EFFE3E0A7() {
  scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades("super_laser_charge");
}

_id_269B97F3D86EB172(_id_EB3AA4092C07D861, _id_DC9CDB0DDE14C2E3, _id_4A82C38656BEF462) {
  if(isDefined(_id_4A82C38656BEF462)) {
    if(isarray(_id_4A82C38656BEF462))
      scripts\engine\utility::_id_5ADCA43F839A3CCE(_id_4A82C38656BEF462);
    else
      self waittill(_id_4A82C38656BEF462);
  }

  if(istrue(_id_EB3AA4092C07D861))
    scripts\mp\supers::superusefinished();

  _id_102BAA631C8E7151 = 0;
  _id_19163E14365D9264 = self.super;

  if(!isDefined(_id_19163E14365D9264) || !scripts\mp\supers::_id_907944A173ED27E1(_id_19163E14365D9264.staticdata.ref))
    _id_102BAA631C8E7151 = 1;

  if(!istrue(_id_DC9CDB0DDE14C2E3) && !_id_102BAA631C8E7151) {
    scripts\mp\supers::clearsuper();

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "superSlotCleanUp"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "superSlotCleanUp")]](self);
  }

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    self setclientomnvar("ui_super_warning", 0);

  self setscriptablepartstate("superpowers", "off", 0);
  self setscriptablepartstate("superpowers_aura", "off", 0);
  self setscriptablepartstate("heroDiveVfx", "off", 0);

  if(getdvarint("dvar_93804FE50A4DDEAB", 0))
    scripts\engine\utility::delaythread(0.25, ::_id_8F385D41D37C6572);

  self notify("temp_v_finished");
}

_id_8F385D41D37C6572() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_7E52B56769FA7774::_givebrsuper("equip_temp_v", "super_temp_v", 1);
  else
    scripts\mp\perks\perkpackage::perkpackage_giveimmediate("super_temp_v");
}

_id_333146DD4B1C3317(equipmentref) {
  if(!isDefined(equipmentref))
    return 0;

  switch (equipmentref) {
    case "equip_electric_discharge":
    case "equip_teleport_deploy":
    case "equip_high_jump":
    case "equip_laser_charge":
      return 1;
    default:
      return 0;
  }
}

_id_988143193CD6A03A(instance) {
  if(!istrue(level._id_7EBAD80A50484A39)) {
    return;
  }
  _id_3F2D768DB35932E1 = undefined;
  _id_B5858D9A2232E324 = getdvarint("dvar_F15BC465EB216C3E", 5);

  switch (instance.type) {
    case "br_loot_cache_lege":
      _id_B5858D9A2232E324 = getdvarint("dvar_202437D366AB08BF", 50);
      break;
    default:
      if(issubstr(instance.type, "br_loot_cache"))
        _id_B5858D9A2232E324 = getdvarint("dvar_2F77DE10BAFC6229", 25);

      if(istrue(getdvarint("dvar_1C4ECB2E31A1B8E8", 0)))
        _id_B5858D9A2232E324 = 0;

      break;
  }

  _id_9768B22610B34D9D = getdvarint("dvar_69E3493C0E7DC860", 0);
  _id_3F2D768DB35932E1 = undefined;
  _id_65B1523CA1AA20D2 = getdvarint("dvar_A0594EDD74C2CD34", 100);

  if(level._id_2DDD5FA2CFA55AFE < _id_65B1523CA1AA20D2) {
    _id_AB6AC2A474126EA3 = randomintrange(1, 100);

    if(istrue(_id_9768B22610B34D9D) || _id_B5858D9A2232E324 > 0 && _id_AB6AC2A474126EA3 <= _id_B5858D9A2232E324) {
      level._id_2DDD5FA2CFA55AFE++;
      _id_3F2D768DB35932E1 = "brloot_super_temp_v";
    }
  }

  return _id_3F2D768DB35932E1;
}

_id_ACF86641A7105328() {
  self endon("disconnect");
  self visionsetnakedforplayer("battlerage-low-health", 0.5);
  scripts\engine\utility::waittill_any_timeout_1(0.2, "death");
  self visionsetnakedforplayer("", 0.5);
}

_id_F2C35147CD83E1C7() {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_timeout_1(1.0, "death");
  self setscriptablepartstate("superpowers_veins", "off", 0);
}

_id_79CD1B77A631E77C(player) {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  if(!getdvarint("dvar_AB08E8567915ABB8", 1)) {
    return;
  }
  _id_CC75E0B74EE84D57 = spawnStruct();
  _id_CC75E0B74EE84D57._id_D66266E27481ACE9 = 0;
  _id_CC75E0B74EE84D57._id_40CA706DA5962314 = 1;
  _id_CC75E0B74EE84D57._id_CFCFFC70799935EE = 0;
  _id_CC75E0B74EE84D57._id_E6F187BCB4B1648E = "TempV_Br";
  _id_CC75E0B74EE84D57._id_D77771D6BFB89518 = "hud_icon_power_temp_v";
  _id_CC75E0B74EE84D57.circleradius = getdvarint("dvar_E232615A13615B53", 1000);
  _id_CC75E0B74EE84D57._id_212406C9408B2D05 = getdvarint("dvar_C3C506F46B023D34", 5);
  _id_CC75E0B74EE84D57._id_9FCCD0C71039EFF7 = ::_id_DD9F4B8CEED5962E;
  _id_CC75E0B74EE84D57._id_981FDA4F385C05D5 = ::_id_DF6BA84C45EF214E;
  _id_CC75E0B74EE84D57._id_7073A47DB2F80848 = ::_id_6F1E076A4BA6DBCE;
  _id_CC75E0B74EE84D57._id_1E7FE7292618D1C5 = 0;
  _id_CC75E0B74EE84D57.priority = 1;
  _id_26660AE1076E2D99::_id_4647CBF23F54D6F6(player, _id_CC75E0B74EE84D57);
}

_id_DD9F4B8CEED5962E(_id_CC75E0B74EE84D57, _id_C17CAED8C315B4A6) {
  if(!isDefined(_id_C17CAED8C315B4A6)) {
    return;
  }
  if(!isDefined(_id_C17CAED8C315B4A6._id_20C4102E2DDC6FC2))
    _id_C17CAED8C315B4A6._id_20C4102E2DDC6FC2 = 0;

  _id_C17CAED8C315B4A6._id_20C4102E2DDC6FC2++;

  if(!_id_60461F95DB3442B4(_id_C17CAED8C315B4A6, _id_CC75E0B74EE84D57)) {
    return;
  }
  _id_C17CAED8C315B4A6._id_1D7CE7F4BAF78710 = gettime();
  _id_2CEDCC356F1B9FC8::brleaderdialogplayer("supe_spotted", _id_C17CAED8C315B4A6, 1, 0, undefined, undefined, "dx_br_bds4_");
}

_id_DF6BA84C45EF214E(_id_CC75E0B74EE84D57, _id_81C4E06C9530F1CC) {
  if(!isDefined(_id_81C4E06C9530F1CC)) {
    return;
  }
  _id_81C4E06C9530F1CC._id_20C4102E2DDC6FC2--;

  if(_id_81C4E06C9530F1CC._id_20C4102E2DDC6FC2 <= 0)
    _id_81C4E06C9530F1CC._id_20C4102E2DDC6FC2 = 0;

  if(!_id_60461F95DB3442B4(_id_81C4E06C9530F1CC, _id_CC75E0B74EE84D57, 1)) {
    return;
  }
  _id_81C4E06C9530F1CC._id_1D7CE7F4BAF78710 = gettime();

  if(isDefined(_id_CC75E0B74EE84D57.player) && !_id_CC75E0B74EE84D57.player scripts\cp_mp\utility\player_utility::_isalive())
    _id_2CEDCC356F1B9FC8::brleaderdialogplayer("supe_killed", _id_81C4E06C9530F1CC, 1, 0, undefined, undefined, "dx_br_bds4_");
  else
    _id_2CEDCC356F1B9FC8::brleaderdialogplayer("supe_lost", _id_81C4E06C9530F1CC, 1, 0, undefined, undefined, "dx_br_bds4_");
}

_id_60461F95DB3442B4(_id_1F6573E24689CF5F, _id_CC75E0B74EE84D57, _id_506B84B2EAFA32C5) {
  if(!getdvarint("dvar_3F710C257C1C6FB2", 1))
    return 0;

  if(!isDefined(_id_1F6573E24689CF5F))
    return 0;

  if(isDefined(_id_1F6573E24689CF5F) && _id_1F6573E24689CF5F.team == _id_CC75E0B74EE84D57.player.team)
    return 0;

  if(isDefined(_id_1F6573E24689CF5F._id_1D7CE7F4BAF78710)) {
    _id_FBD43DA47D8CECDF = (gettime() - _id_1F6573E24689CF5F._id_1D7CE7F4BAF78710) / 1000;

    if(_id_FBD43DA47D8CECDF <= getdvarint("dvar_1B11C351D93C1126", 5))
      return 0;
  }

  if(istrue(_id_506B84B2EAFA32C5)) {
    if(isDefined(_id_1F6573E24689CF5F._id_20C4102E2DDC6FC2) && _id_1F6573E24689CF5F._id_20C4102E2DDC6FC2 > 0)
      return 0;
  } else if(isDefined(_id_1F6573E24689CF5F._id_20C4102E2DDC6FC2) && _id_1F6573E24689CF5F._id_20C4102E2DDC6FC2 > 1)
    return 0;

  return 1;
}

_id_6F1E076A4BA6DBCE(_id_CC75E0B74EE84D57) {
  level endon("game_ended");
  _id_CC75E0B74EE84D57 endon("bounty_end");
  _id_CC75E0B74EE84D57.player scripts\engine\utility::waittill_any_5("death_or_disconnect", "enter_live_ragdoll", "successful_exfil", "map_to_map_warp", "temp_v_finished");
  _id_26660AE1076E2D99::_id_A10C4276271C4AD7(_id_CC75E0B74EE84D57, 1, 2);
}

_id_4C30D408AE45AA33() {
  self endon("temp_v_finished");
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("death", "unset_super");
  thread _id_269B97F3D86EB172(0, 1);
}

_id_CEF1C8463D56BB49() {
  self endon("temp_v_finished");
  self endon("disconnect");
  level waittill("game_ended");
  thread _id_269B97F3D86EB172(0, 1);
}