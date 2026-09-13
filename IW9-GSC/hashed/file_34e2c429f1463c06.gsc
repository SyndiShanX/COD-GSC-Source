/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_34e2c429f1463c06.gsc
***********************************************/

_id_C35F8FE1F419BB40() {
  level._effect["vfx/iw9/fieldupgrades/ammobox/vfx_ammobox_timeout.vfx"] = loadfx("vfx/iw9/fieldupgrades/ammobox/vfx_ammobox_timeout.vfx");
  _id_1311C5C284DD1537::_id_5D36462331845D5F("reconDartList");
  level._id_BB0266F422D9AFA3["reconDart"] = spawnStruct();
  _id_B1ED6E7B94CF2A7E();
  _id_0EC06E376C416317();
  _id_0EA90EBAD8B7A7A9();
  thread _id_C1A14856AEBB53F0();
}

_id_B1ED6E7B94CF2A7E() {
  _id_962A30A9BB8C0F09 = _id_1311C5C284DD1537::_id_F0698AEE89C18210("reconDart");
  _id_962A30A9BB8C0F09._id_5237A188CCDA4D7B = "super_tac_camera";
  _id_962A30A9BB8C0F09.lifetime = getdvarint("dvar_13717E6E87CB530F", 120);
  _id_962A30A9BB8C0F09.startfunc = ::_id_A10D1D70759F9E83;
  _id_962A30A9BB8C0F09._id_BE3314F77FEF5D6B = ::_id_1D751F90A61B1801;
  _id_962A30A9BB8C0F09._id_4C663252DABD1483 = ::_id_986AA37BC2622D44;
  _id_962A30A9BB8C0F09._id_0E04BD0DDC6EC05B = ::_id_4CCB840525638E85;
  _id_962A30A9BB8C0F09._id_D6FDC3B56B33F4E3 = ::_id_7ACC5AA2B73FE93B;
  _id_962A30A9BB8C0F09._id_273F2A99F4833F00 = ::_id_DAF83774B715C487;
  _id_962A30A9BB8C0F09._id_547E8B267C03D017 = ::_id_1EE10C87668846D9;
  _id_962A30A9BB8C0F09._id_1EB35A5A7992E498 = ::_id_7ACC5AA2B73FE93B;
  _id_962A30A9BB8C0F09._id_06E5F6320607EB69 = ::_id_A60052D904A2D492;
  _id_962A30A9BB8C0F09._id_4FBADC7102D30912 = 2480625;
  _id_962A30A9BB8C0F09._id_16187E4D354C3C97 = 619369;
  _id_962A30A9BB8C0F09._id_37782917998D4FF2 = 2480625;
  _id_962A30A9BB8C0F09._id_9953DC2E8C205B77 = 619369;
  _id_962A30A9BB8C0F09._id_0EFF1AB975C47FE2 = 9000000;
  _id_962A30A9BB8C0F09._id_57B8F3BCFCA33A4B = 3.0;
  _id_962A30A9BB8C0F09._id_53EC43FA38FC3243 = "reconDartList";
  _id_962A30A9BB8C0F09._id_9C35CA95BD1D22FA = "reconDarts";
  _id_962A30A9BB8C0F09._id_1790D4C69D5F45A4 = 3;
  _id_962A30A9BB8C0F09._id_4F401574FC47899E = "tacticalCamera_camera_added";
  _id_962A30A9BB8C0F09._id_67D467748271444C = "tacticalCamera_camera_removed";
  _id_962A30A9BB8C0F09._id_0315C43D476BB095 = "tacticalCamera_location_changed";
  _id_962A30A9BB8C0F09._id_36411D05D3F1E503 = "tacticalCamera_pilot_removed";
  _id_962A30A9BB8C0F09._id_6C8C1A666ED5F48D = "hud_icon_fieldupgrade_tac_cam";
  _id_962A30A9BB8C0F09._id_91389DD68A70BE33 = "equip_tactical_cam_marking";
}

_id_0EC06E376C416317() {
  _id_962A30A9BB8C0F09 = _id_1311C5C284DD1537::_id_F0698AEE89C18210("reconDart");
  _id_962A30A9BB8C0F09.firetypes = [];
  _id_962A30A9BB8C0F09.firetypeweights = [];
  _id_962A30A9BB8C0F09._id_871967428B3ACD58 = [];
  _id_962A30A9BB8C0F09._id_E5F140D112AC9F48 = [];
  _id_962A30A9BB8C0F09._id_0DDAF8E63BFE0FE4 = [];
  _id_962A30A9BB8C0F09._id_0DFE06E63C247666 = [];
  _id_962A30A9BB8C0F09._id_F6F38F14951D15FA = getdvarfloat("dvar_D3926F8C39CA520B", 4);
  _id_962A30A9BB8C0F09._id_32BA1548CC879801 = getdvarfloat("dvar_939F680C8B7BD4A7", 2);
  _id_962A30A9BB8C0F09._id_C6C0C9D205C3A9D7 = getdvarint("dvar_9F5973A323881A4D", 3);
  _id_962A30A9BB8C0F09._id_5F90E570A199B76F = getdvarfloat("dvar_8241B785C55EEEB3", 800);
  _id_962A30A9BB8C0F09.firetypes[_id_962A30A9BB8C0F09.firetypes.size] = "ar";
  _id_962A30A9BB8C0F09._id_871967428B3ACD58["ar"] = 0.4;
  _id_962A30A9BB8C0F09.firetypeweights["ar"] = getdvarint("dvar_6D05892E26E1BC20", 35);
  _id_962A30A9BB8C0F09._id_E5F140D112AC9F48["ar"] = getdvarint("dvar_637F35BCE33C662C", 3);
  _id_962A30A9BB8C0F09._id_0DDAF8E63BFE0FE4["ar"] = getdvarfloat("dvar_BE611222E6BCCFA6", 0.5);
  _id_962A30A9BB8C0F09._id_0DFE06E63C247666["ar"] = getdvarfloat("dvar_BE842422E6E33EF4", 2);
}

_id_0EA90EBAD8B7A7A9() {
  _id_962A30A9BB8C0F09 = _id_1311C5C284DD1537::_id_F0698AEE89C18210("reconDart");
  _id_962A30A9BB8C0F09._id_6ECEC22397E50B64 = getdvarint("dvar_21AE64F1D46824D0", 256);
  _id_962A30A9BB8C0F09._id_96E1D0B5257833F5 = getdvarint("dvar_E48BE2CEF86F21DC", 540);
  _id_962A30A9BB8C0F09._id_969232101115A16F = getdvarint("dvar_E48BE2CEF86F21DC", 0);
  _id_962A30A9BB8C0F09._id_0250B70D11F662FE = _id_962A30A9BB8C0F09._id_96E1D0B5257833F5 - _id_962A30A9BB8C0F09._id_969232101115A16F;
  _id_962A30A9BB8C0F09._id_A3DCD4386E0E216B = getdvarint("dvar_3704CA981A6134EE", -30);
  _id_962A30A9BB8C0F09._id_C72EDF49FCA36B64 = getdvarint("dvar_A8A0B941C08F9A33", 35);
  _id_962A30A9BB8C0F09._id_40834EFD8B5E0C85 = getdvarint("dvar_C50E8210D6CCF9F4", 65);
  _id_962A30A9BB8C0F09._id_71671DA3E0847B95 = _id_962A30A9BB8C0F09._id_C72EDF49FCA36B64 + _id_962A30A9BB8C0F09._id_40834EFD8B5E0C85;
  _id_962A30A9BB8C0F09._id_3526ACFA98CBE798 = getdvarfloat("dvar_7FDE54A03CDD9B38", 3.6);
  _id_962A30A9BB8C0F09._id_9A4D9CE87D4ACFC7 = getdvarint("dvar_0BA62E8EBD3618C6", 1) == 1;
}

_id_C1A14856AEBB53F0() {
  if(getdvarint("dvar_6341B85ECD5B3F07", 0) != 1) {
    return;
  }
  for(;;) {
    wait 1;
    _id_B1ED6E7B94CF2A7E();
    _id_0EC06E376C416317();
    _id_0EA90EBAD8B7A7A9();
  }
}

_id_2CF7E1E0B6513C6F() {
  self notify("tacticalCamera_set");
  thread _id_1311C5C284DD1537::_id_362C9A13D18031B1("personal_camera_status_updated", "ui_tactical_camera_cam_", "tacticalCamera_unset");
  _id_1311C5C284DD1537::_id_081FB12166C3C0C2(self, undefined, ::_id_C46995E65D020FCC, "super_recon_dart");
  thread _id_1311C5C284DD1537::_id_3C4DA29D1ED157C7("tacCamCluster", "tacticalCamera_unset", "tacticalCamera_camera_removed", 9000000, ::_id_C46995E65D020FCC);

  if(!isbot(self) && !isagent(self))
    thread _id_2E07A35180DE2A29();
}

_id_79893D5ED21AE366() {
  self notify("tacticalCamera_unset");
  _id_1311C5C284DD1537::_id_F7A32619BBA6E450("reconDart");
  _id_1311C5C284DD1537::_id_8B5781DD2D18A300(self);
  _id_1311C5C284DD1537::_id_081FB12166C3C0C2(self, 1, ::_id_C46995E65D020FCC, "super_recon_dart");
  _id_FB30706D5E4A4B27(undefined);
}

_id_EC71C6A3676C9EE6(_id_E314A4412AFF5E4A, stuckto, position) {
  camera = _id_97AEE59BE6C51C15(_id_E314A4412AFF5E4A, stuckto, position, "super_recon_dart");

  if(isDefined(camera)) {
    camera endon("death");
    camera thread _id_01092EE52C1C5A6C();
    waitframe();
    camera thread _id_1311C5C284DD1537::_id_C99B3A2B715C288B();
  }

  return camera;
}

_id_97AEE59BE6C51C15(_id_E314A4412AFF5E4A, stuckto, position, superid) {
  self endon("disconnect");
  level endon("game_ended");
  camera = _id_1311C5C284DD1537::_id_EE24B83D39692536(_id_E314A4412AFF5E4A, stuckto, position, "tactical_camera_turret_mp", "turret_recon_dart_v0", "reconDart");
  camera endon("death");
  camera.hasexploded = 0;
  self.isusingcamera = 0;
  camera thread _id_1311C5C284DD1537::_id_B3B59C099F93A503();
  camera thread _id_EA7D2B522E1E6E1A();
  camera.issuper = 1;
  camera.superid = level.superglobals.staticsuperdata[superid].id;
  camera.creationtime = gettime();
  camera.ownerteam = _id_E314A4412AFF5E4A.owner.team;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("deployable_camera", "attachXRays"))
    camera = [[scripts\cp_mp\utility\script_utility::getsharedfunc("deployable_camera", "attachXRays")]](camera);

  thread _id_1311C5C284DD1537::_id_DA29E274CC4A86F4(camera);

  if(!_id_1311C5C284DD1537::_id_3265A4A8A3BDB477("reconDart"))
    _id_C3D0CCB8F9A3D594();

  _id_1311C5C284DD1537::_id_99F14479415346E9(camera);
  _id_1311C5C284DD1537::_id_9C46884FE9337FA7(camera);
  waitframe();
  self notify("personal_camera_status_updated", camera, camera._id_DEFBEED1A2C29C34, 1);
  camera thread _id_1311C5C284DD1537::_id_45A7E0EDC973D037();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "clearOOB"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "clearOOB")]](camera, 1);

  camera thread _id_1311C5C284DD1537::_id_5E8B74F5E3DC4C60();
  _id_1311C5C284DD1537::_id_9CD4393CAC778989(camera);

  if(1)
    thread scripts\mp\weapons::outlineequipmentforowner(camera);

  if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    camera _id_1311C5C284DD1537::_id_FE1CD71ED406A649();

  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::_id_0AFAEFCF7B894E66);
  camera setscriptablepartstate("ddos", "neutral", 0);
  camera _id_736DEC95A49487A6::_id_172D848D58051FDF(_id_1311C5C284DD1537::_id_652247CE1ACB67C2);
  camera scripts\cp_mp\emp_debuff::set_start_emp_callback(::_id_8B1C76D70CB37943);
  camera enableplayermarks("equipment");

  if(level.teambased)
    camera filteroutplayermarks(self.team);
  else
    camera filteroutplayermarks(self);

  camera _id_A839F4B0078F8F69();
  camera _id_F7B712CED2DAB1FC();
  return camera;
}

_id_01092EE52C1C5A6C() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self.owner _id_1311C5C284DD1537::_id_57B6E09EDA0090D6(1);
}

_id_986AA37BC2622D44(immediate, _id_1548B5D7F8624206) {
  if(!isDefined(immediate))
    immediate = !istrue(self.planted);

  if(isDefined(self)) {
    if(!istrue(_id_1548B5D7F8624206))
      self.owner notify("personal_camera_status_updated", self, self._id_DEFBEED1A2C29C34, 3);

    self setscriptablepartstate("destroyed", "on", 0);
    _id_1311C5C284DD1537::_id_06976F2B3945C32F();
    _id_1311C5C284DD1537::_id_7ABFAE4E338CC940(self.owner, ::_id_C969B8D603818CFC);
    thread _id_17DD1C4132E3E355();
  }
}

_id_66B731696D3BC6B8() {
  _id_1311C5C284DD1537::_id_57B6E09EDA0090D6(0);
  self setclientomnvar("ui_tactical_camera_use", 0);
  _id_1311C5C284DD1537::_id_86B60845E9A3D301("reconDart");
  self notify("reconDart_allCamerasRemoved");
}

_id_17DD1C4132E3E355() {
  self notify("death");
  self.isdestroyed = 1;

  if(isDefined(self.owner))
    self.owner scripts\mp\weapons::removeequip(self);

  _id_1311C5C284DD1537::_id_67240DB2BF930CCD();
  _id_1311C5C284DD1537::_id_FC9294FFBD3490F3();

  if(isDefined(self.owner)) {
    _id_1311C5C284DD1537::_id_4BE323B74B86DBC9(self);

    if(!self.owner _id_1311C5C284DD1537::_id_3265A4A8A3BDB477("reconDart"))
      self.owner _id_66B731696D3BC6B8();

    self.owner _id_1311C5C284DD1537::_id_F5CDA4DA64C5C579(self);
  }

  self._id_DF8EAB23E5A5A0B7 = undefined;
  self.tag = undefined;
  self._id_A820130A6D38F1E4 = undefined;
  self._id_325727B6C2E7F058 = undefined;
  self.useturret = undefined;
  self setturretowner(undefined);
  wait 0.1;
  self delete();
}

_id_65C2611EFF3A7DC4(camera) {
  self endon("disconnect");
  self endon("death");
  self endon("playerExitingCameraMode");
  self notify("cameraSelfDestructMonitored");
  self endon("cameraSelfDestructMonitored");

  for(;;) {
    self notifyonplayercommand("selfDestruct", "+weapnext");
    self waittill("selfDestruct");

    if(!isDefined(camera) || istrue(camera.isdestroyed)) {
      return;
    }
    if(camera scripts\cp_mp\emp_debuff::is_empd()) {
      continue;
    }
    if(camera.pilot == self) {
      _id_1D929B8E8487C576(camera);
      camera thread _id_986AA37BC2622D44();
      return;
    } else {}
  }
}

_id_A9FF1672FCC0B3F8() {
  self notifyonplayercommandremove("selfDestruct", "+weapnext");
}

_id_1D929B8E8487C576(camera) {
  _id_962A30A9BB8C0F09 = _id_1311C5C284DD1537::_id_F0698AEE89C18210("reconDart");
  _id_1311C5C284DD1537::_id_C57955CDA07E6609();

  foreach(targetarray in level._id_E725F44030790232 scripts\engine\utility::_id_0DF633F460888A47(camera.origin)) {
    foreach(victim in targetarray) {
      if(!isDefined(victim)) {
        continue;
      }
      if(victim == self && !_id_962A30A9BB8C0F09._id_9A4D9CE87D4ACFC7) {
        continue;
      }
      dist = distance(victim.origin, camera.origin);
      weight = 0;

      if(victim scripts\mp\utility\perk::_hasperk("specialty_stun_resistance") && victim != self) {
        _id_5762AC2F22202BA2::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);

        if(scripts\cp_mp\utility\player_utility::playersareenemies(victim, self))
          victim scripts\cp_mp\challenges::resistedstun(victim);

        victim scripts\mp\perks\perks::_id_5A3FEF8CB39336B8("specialty_tac_resist");
        victim thread scripts\mp\equipment\flash_grenade::applyflash(self, _id_962A30A9BB8C0F09._id_3526ACFA98CBE798);
        return;
      }

      dist = clamp(dist, _id_962A30A9BB8C0F09._id_969232101115A16F, scripts\engine\utility::ter_op(victim == self, _id_962A30A9BB8C0F09._id_6ECEC22397E50B64, _id_962A30A9BB8C0F09._id_96E1D0B5257833F5));
      _id_AE3412F7B9B48D44 = 1 - (dist - _id_962A30A9BB8C0F09._id_969232101115A16F) / _id_962A30A9BB8C0F09._id_0250B70D11F662FE;
      weight = weight + floor(_id_AE3412F7B9B48D44 * _id_962A30A9BB8C0F09._id_40834EFD8B5E0C85);

      if(scripts\engine\utility::within_fov(victim.origin, victim getplayerangles(), camera.origin, 0.5))
        weight = weight + _id_962A30A9BB8C0F09._id_C72EDF49FCA36B64;

      if(!scripts\cp_mp\utility\player_utility::playersareenemies(victim, self))
        weight = weight + _id_962A30A9BB8C0F09._id_A3DCD4386E0E216B;

      weight = max(0, weight);
      _id_453227E7B36F0B24 = weight / _id_962A30A9BB8C0F09._id_71671DA3E0847B95;
      _id_5F651E1139EF776F = 4;
      _id_6B7054210E5DF55D = 6;
      duration = _id_5F651E1139EF776F + (_id_6B7054210E5DF55D - _id_5F651E1139EF776F) * _id_453227E7B36F0B24;
      victim thread scripts\mp\equipment\flash_grenade::applyflash(self, duration);
    }
  }
}

_id_3F78CC9FF3012D4D() {
  _id_A78DC38B12EAFEBA = 0;
  _id_2873368D0CD5753F = [];
  _id_962A30A9BB8C0F09 = _id_1311C5C284DD1537::_id_F0698AEE89C18210("reconDart");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_962A30A9BB8C0F09.firetypes.size; _id_AC0E594AC96AA3A8++) {
    firetype = _id_962A30A9BB8C0F09.firetypes[_id_AC0E594AC96AA3A8];
    _id_A78DC38B12EAFEBA = _id_A78DC38B12EAFEBA + _id_962A30A9BB8C0F09.firetypeweights[firetype];
    _id_2873368D0CD5753F[_id_AC0E594AC96AA3A8] = _id_A78DC38B12EAFEBA;
  }

  _id_854B5C669A29592A = randomint(_id_A78DC38B12EAFEBA);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2873368D0CD5753F.size; _id_AC0E594AC96AA3A8++) {
    if(_id_854B5C669A29592A < _id_2873368D0CD5753F[_id_AC0E594AC96AA3A8]) {
      self.firetype = _id_962A30A9BB8C0F09.firetypes[_id_AC0E594AC96AA3A8];
      return;
    }
  }
}

_id_A839F4B0078F8F69() {
  self.decoyassists = 0;
  _id_3F78CC9FF3012D4D();
}

_id_F7B712CED2DAB1FC() {
  self._id_9F0213AEBF49E280 = 1;
}

_id_8CFFE9D2B3560375() {
  self._id_9F0213AEBF49E280 = 0;
}

_id_F8C09EABC74D0CA3(camera) {
  self endon("disconnect");
  self endon("death");
  self endon("playerExitingCameraMode");
  self notify("cameraDecoyNoiseMonitored");
  self endon("cameraDecoyNoiseMonitored");

  for(;;) {
    self notifyonplayercommand("decoyNoiseCommand", "+attack");
    self waittill("decoyNoiseCommand");

    if(!isDefined(camera) || istrue(camera.isdestroyed)) {
      return;
    }
    if(camera.pilot == self) {
      if(!istrue(camera._id_9F0213AEBF49E280)) {
        continue;
      }
      if(camera scripts\cp_mp\emp_debuff::is_empd()) {
        continue;
      }
      camera thread _id_825911430C0634A9(self);
      continue;
    }
  }
}

_id_66B4AFA128DECD2E() {
  self notifyonplayercommandremove("decoyNoiseCommand", "+attack");
}

_id_825911430C0634A9(_id_414F12081917F613) {
  self endon("death");
  self setscriptablepartstate("beacon", "active", 0);
  _id_8CFFE9D2B3560375();
  _id_962A30A9BB8C0F09 = _id_1311C5C284DD1537::_id_F0698AEE89C18210("reconDart");
  _id_1B4A45E3E20BBB65 = 1 + randomint(_id_962A30A9BB8C0F09._id_E5F140D112AC9F48[self.firetype]);

  for(;;) {
    _id_1B4A45E3E20BBB65--;

    if(!scripts\cp_mp\emp_debuff::is_empd())
      _id_F0D575A0A800D2B8(_id_414F12081917F613);

    if(_id_1B4A45E3E20BBB65 == 0) {
      break;
    }

    wait(randomfloatrange(_id_962A30A9BB8C0F09._id_0DDAF8E63BFE0FE4[self.firetype], _id_962A30A9BB8C0F09._id_0DFE06E63C247666[self.firetype]));
  }

  self setscriptablepartstate("beacon", "neutral", 0);
  wait(_id_962A30A9BB8C0F09._id_F6F38F14951D15FA);
  _id_F7B712CED2DAB1FC();
}

_id_F0D575A0A800D2B8(_id_414F12081917F613) {
  _id_962A30A9BB8C0F09 = _id_1311C5C284DD1537::_id_F0698AEE89C18210("reconDart");
  firetype = self.firetype;
  self setscriptablepartstate("weaponFire", firetype + "Fire", 0);
  self setscriptablepartstate("weaponSounds", firetype + "Fire", 0);

  if(isDefined(self.ownerteam))
    pinglocationenemyteams(self.origin, self.ownerteam, self.owner);

  _id_0B36C71C670B33B4(_id_414F12081917F613);
  wait(_id_962A30A9BB8C0F09._id_871967428B3ACD58[firetype]);
}

_id_0B36C71C670B33B4(_id_414F12081917F613) {
  _id_962A30A9BB8C0F09 = _id_1311C5C284DD1537::_id_F0698AEE89C18210("reconDart");
  _id_1311C5C284DD1537::_id_C57955CDA07E6609();

  foreach(targetarray in level._id_E725F44030790232 scripts\engine\utility::_id_0DF633F460888A47(self.origin)) {
    foreach(_id_7DC3241E7F3C6B24 in targetarray) {
      if(isPlayer(_id_7DC3241E7F3C6B24) && !_id_7DC3241E7F3C6B24 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, _id_7DC3241E7F3C6B24))) {
        continue;
      }
      if(isPlayer(_id_7DC3241E7F3C6B24)) {
        dist = distance(_id_7DC3241E7F3C6B24.origin, self.origin);

        if(distance(_id_7DC3241E7F3C6B24.origin, self.origin) > _id_962A30A9BB8C0F09._id_5F90E570A199B76F) {
          continue;
        }
        thread _id_09E2311FEEC72EC0(_id_7DC3241E7F3C6B24, _id_414F12081917F613);
        continue;
      }

      _id_7DC3241E7F3C6B24 aieventlistenerevent("gunshot", self, self.origin);
    }
  }
}

_id_09E2311FEEC72EC0(player, _id_414F12081917F613) {
  player endon("disconnect");
  self endon("death");
  _id_414F12081917F613 endon("disconnect");
  _id_962A30A9BB8C0F09 = _id_1311C5C284DD1537::_id_F0698AEE89C18210("reconDart");
  playerid = player getentitynumber();
  _id_414F12081917F613 notify("reconDart_assitWaiting_" + playerid);
  _id_414F12081917F613 endon("reconDart_assitWaiting_" + playerid);
  result = player scripts\engine\utility::waittill_notify_or_timeout_return("death", _id_962A30A9BB8C0F09._id_32BA1548CC879801);

  if(isDefined(player.lastkilledby) && player.lastkilledby != _id_414F12081917F613) {
    if(result == "death" && scripts\cp_mp\utility\player_utility::playersareenemies(player, _id_414F12081917F613)) {
      if(self.decoyassists < _id_962A30A9BB8C0F09._id_C6C0C9D205C3A9D7) {
        _id_414F12081917F613 thread scripts\mp\utility\points::_id_0366980B6A8796AE("assist_decoy");
        self.decoyassists++;
      }
    }
  }
}

_id_7ACC5AA2B73FE93B() {
  return self._id_7D73CBB5CA5D6E32["tacCamCluster"];
}

_id_FB30706D5E4A4B27(val) {
  self._id_7D73CBB5CA5D6E32["tacCamCluster"] = val;
}

_id_C3D0CCB8F9A3D594() {
  self setclientomnvar("ui_tactical_camera_use", 1);
}

_id_EA7D2B522E1E6E1A() {
  level endon("game_ended");
  self endon("death");
  self._id_11F51147CCFF0163 = 1;
  scripts\engine\utility::waittill_notify_or_timeout("tactical_camera_has_been_piloted", 3.0);
  self._id_11F51147CCFF0163 = 0;
}

_id_C969B8D603818CFC(_id_161E86C260D6864C, player) {
  if(_id_161E86C260D6864C.markingent == self)
    _id_1311C5C284DD1537::_id_47C44D1BF801B8F0(_id_161E86C260D6864C, player, 0);
}

_id_C46995E65D020FCC() {
  return _id_1311C5C284DD1537::_id_C827C58258222D48("reconDart");
}

_id_8ED527B613B0077E(_id_C380EB54A8ADB38C) {
  _id_B65E76E261A6ED4D = [[_id_C380EB54A8ADB38C]]();
  _id_922B0ED93B663936 = "ui_tactical_camera_pilot";
  self setclientomnvar(_id_922B0ED93B663936, undefined);
  self setclientomnvar("ui_tactical_camera_can_detonate_c4", 0);
  self setclientomnvar("ui_tactical_camera_index", 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= _id_B65E76E261A6ED4D.size; _id_AC0E594AC96AA3A8++) {
    _id_1004988AB02E2B5A = "ui_tactical_camera_" + scripts\engine\utility::string(_id_AC0E594AC96AA3A8) + "_location";
    _id_DD13AD74BC01D314 = "ui_tactical_camera_" + scripts\engine\utility::string(_id_AC0E594AC96AA3A8) + "_status";
    self setclientomnvar(_id_1004988AB02E2B5A, 63);
    self setclientomnvar(_id_DD13AD74BC01D314, 0);
  }
}

_id_D423BB11A1CF19A5(camera) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("usingCamera");
  camera endon("death");

  for(;;) {
    if(self.isusingcamera)
      self setclientomnvar("ui_killstreak_countdown", camera._id_5C93B81B2052D23B);

    waitframe();
  }
}

_id_E105ACA0D2B82E2E(camera, _id_B65E76E261A6ED4D) {
  _id_FE8F7703F6313ED4 = camera._id_59D945F45B4733EE;

  if(isDefined(_id_FE8F7703F6313ED4))
    self setclientomnvar("ui_tactical_camera_index", _id_FE8F7703F6313ED4 + 1);
}

_id_A3D6F92E2C44200F() {
  level endon("game_ended");
  self endon("stopMonitoringCamera");
  self endon("death_or_disconnect");

  for(;;) {
    level waittill("tacticalCamera_location_changed", camera);
    _id_B65E76E261A6ED4D = _id_C46995E65D020FCC();
    _id_FE8F7703F6313ED4 = scripts\engine\utility::array_find(_id_B65E76E261A6ED4D, camera);

    if(isDefined(_id_FE8F7703F6313ED4)) {
      _id_E9D476A3809CB3F1 = "ui_tactical_camera_" + scripts\engine\utility::string(_id_FE8F7703F6313ED4) + "_location";
      self setclientomnvar(_id_E9D476A3809CB3F1, camera._id_49996EBEBBBBF375);
    }

    waitframe();
  }
}

_id_B327B26A701CFA7A(player, index) {
  level endon("game_ended");
  player endon("disconnect");
  self endon("death");
  player endon("stopMonitoringCamera");

  for(;;) {
    _id_6D38DF6EA2EB7767 = _id_1311C5C284DD1537::_id_3ECFBD63A3E3BED3(player);

    if(!isDefined(self.status) || isDefined(self.status) && _id_6D38DF6EA2EB7767 != self.status) {
      self.status = _id_6D38DF6EA2EB7767;
      _id_E9D476A3809CB3F1 = "ui_tactical_camera_" + scripts\engine\utility::string(index) + "_status";
      player setclientomnvar(_id_E9D476A3809CB3F1, self.status);
    }

    waitframe();
  }
}

_id_9F19DB59E1560978(_id_B8B54662C5C2E4B9, _id_B65E76E261A6ED4D) {
  _id_F2A82F1E1AFFDE6E = "_is_piloted";
  _id_52B021DAECB30118 = "_location";
  _id_E105ACA0D2B82E2E(_id_B8B54662C5C2E4B9, _id_B65E76E261A6ED4D);

  foreach(index, camera in _id_B65E76E261A6ED4D) {
    _id_59D945F45B4733EE = camera._id_59D945F45B4733EE;

    if(!isDefined(camera._id_59D945F45B4733EE)) {
      continue;
    }
    _id_8CFB97AE498AB61E(camera, _id_59D945F45B4733EE);

    if(isDefined(camera.pilot))
      self setclientomnvar("ui_tactical_camera_" + _id_59D945F45B4733EE + _id_F2A82F1E1AFFDE6E, 1);
    else
      self setclientomnvar("ui_tactical_camera_" + _id_59D945F45B4733EE + _id_F2A82F1E1AFFDE6E, 0);

    if(isDefined(camera._id_49996EBEBBBBF375)) {
      self setclientomnvar("ui_tactical_camera_" + scripts\engine\utility::string(_id_59D945F45B4733EE) + _id_52B021DAECB30118, camera._id_49996EBEBBBBF375);
      continue;
    }

    self setclientomnvar("ui_tactical_camera_" + scripts\engine\utility::string(_id_59D945F45B4733EE) + _id_52B021DAECB30118, 63);
  }
}

_id_8CFB97AE498AB61E(camera, index) {
  status = camera _id_1311C5C284DD1537::_id_3ECFBD63A3E3BED3(self);
  camera.status = status;
  _id_E9D476A3809CB3F1 = "ui_tactical_camera_" + scripts\engine\utility::string(index) + "_status";
  self setclientomnvar(_id_E9D476A3809CB3F1, status);
  camera thread _id_B327B26A701CFA7A(self, index);
}

_id_EB71A2588D9D796A(camera) {
  if(isDefined(camera.pilot))
    self setclientomnvar("ui_tactical_camera_pilot", camera.pilot);
  else
    self setclientomnvar("ui_tactical_camera_pilot", undefined);
}

_id_8DD9912EF55FBE3B(camera) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stopMonitoringCamera");
  camera endon("death");

  for(;;) {
    level waittill("camera_piloted", _id_207BAC97B3703DC3);

    if(_id_207BAC97B3703DC3 == camera)
      _id_EB71A2588D9D796A(camera);

    _id_B65E76E261A6ED4D = _id_C46995E65D020FCC();
    _id_FE8F7703F6313ED4 = scripts\engine\utility::array_find(_id_B65E76E261A6ED4D, _id_207BAC97B3703DC3);

    if(isDefined(_id_FE8F7703F6313ED4))
      self setclientomnvar("ui_tactical_camera_" + _id_FE8F7703F6313ED4 + "_is_piloted", 1);

    waitframe();
  }
}

_id_8F6AC6112BC43B15(camera) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stopMonitoringCamera");
  camera endon("death");

  for(;;) {
    level waittill("tacticalCamera_pilot_removed", _id_B53D41C47A512505);

    if(_id_B53D41C47A512505 == camera)
      _id_EB71A2588D9D796A(camera);

    _id_B65E76E261A6ED4D = _id_C46995E65D020FCC();
    _id_FE8F7703F6313ED4 = scripts\engine\utility::array_find(_id_B65E76E261A6ED4D, _id_B53D41C47A512505);

    if(isDefined(_id_FE8F7703F6313ED4))
      self setclientomnvar("ui_tactical_camera_" + _id_FE8F7703F6313ED4 + "_is_piloted", 0);

    waitframe();
  }
}

_id_DAF83774B715C487(_id_161E86C260D6864C, _id_B995F95867DE9AAB, target, _id_39E02A8A79B6BA4C, _id_CAD4997EBDA279C7, useoutline) {
  level endon("game_ended");
  _id_B995F95867DE9AAB endon("disconnect");
  self.owner endon("disconnect");
  self endon("explode");
  _id_161E86C260D6864C.reconmarked = 1;
  self.markingtarget = undefined;
  _id_B995F95867DE9AAB stoplocalsound("equip_tactical_cam_marking");
  _id_B995F95867DE9AAB playlocalsound("equip_tactical_cam_marked");
  self setscriptablepartstate("marking_target", "off", 0);
  success = _id_1311C5C284DD1537::_id_6F8FB8F7F63E5164(_id_161E86C260D6864C, _id_B995F95867DE9AAB, 1, 0);

  if(!success)
    return 0;

  _id_1311C5C284DD1537::_id_88B3522BBDF2F7C1(0);
  _id_1311C5C284DD1537::_id_88B3522BBDF2F7C1(1);
  _id_C8462289EDFC0ACA = _id_B995F95867DE9AAB _id_1311C5C284DD1537::_id_89B59BEDB3802E41();
  _id_1311C5C284DD1537::_id_EC57E0ACBC6C6879(_id_C8462289EDFC0ACA, target, 2);
  timeout = 5.0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_improved_target_mark"))
      timeout = timeout + 2;
  }

  thread _id_1311C5C284DD1537::_id_6643DD06CF63B76A(_id_161E86C260D6864C, _id_B995F95867DE9AAB, timeout, 0);
}

_id_A60052D904A2D492(target) {
  _id_EFF562DDDEAA6B73 = getdvarfloat("dvar_4ED00D07F5187137", 0.3);
  return _id_EFF562DDDEAA6B73;
}

_id_1EE10C87668846D9(target, _id_39E02A8A79B6BA4C) {
  if(!isDefined(self.markedentitieslifeindicices))
    self.markedentitieslifeindicices = [];

  _id_8B1683C8EAD7B9BE = target getentitynumber();
  _id_59A52BFE186A64C9 = scripts\engine\utility::ter_op(isDefined(self.matchdatalifeindex), self.matchdatalifeindex, 0);
  thread _id_3A942D83B1617A65(target);

  if(!isDefined(self.markedentitieslifeindicices[_id_8B1683C8EAD7B9BE]) || self.markedentitieslifeindicices[_id_8B1683C8EAD7B9BE] > _id_59A52BFE186A64C9) {
    self.markedentitieslifeindicices[_id_8B1683C8EAD7B9BE] = _id_59A52BFE186A64C9;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
      _id_1311C5C284DD1537::_id_C84CFCB1299F9B39() thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]](_func_2EF675C13CA1C4AF("stat_C692976B76D1B3C6", _id_39E02A8A79B6BA4C, "_marked"));
  }
}

_id_3A942D83B1617A65(target) {
  level endon("game_ended");
  self endon("death");
  target endon("disconnect");
  result = target scripts\engine\utility::waittill_notify_or_timeout_return("death", 5.0);
  _id_46CC280CB7C20C7A = result == "death" || !isalive(target);

  if(_id_46CC280CB7C20C7A && isDefined(target.lastkilledby) && target.lastkilledby != self.owner) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent")) {
      _id_DA7B4F7C35CFE0A0 = _id_1311C5C284DD1537::_id_C84CFCB1299F9B39();
      _id_DA7B4F7C35CFE0A0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("tactical_camera_enemy_killed_assist");
    }
  }
}

_id_2E07A35180DE2A29() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("monitoringCamActivation");
  self endon("monitoringCamActivation");
  self endon("tacticalCamera_unset");

  for(;;) {
    success = _id_1311C5C284DD1537::_id_30DD206C5D9B45A7();
    currentweapon = self getcurrentweapon();

    if(currentweapon.basename != _id_202D9F0EA7DB3A23::_id_79A632D01CF0C669()) {
      continue;
    }
    if(!success) {
      continue;
    }
    if(!_id_1311C5C284DD1537::_id_84582DD92C385507()) {
      continue;
    }
    if(scripts\mp\supers::issuperready() && !istrue(self._id_75B981560F8453F4)) {
      continue;
    }
    if(self.super.staticdata.ref == "super_select") {
      continue;
    }
    cam = undefined;
    _id_EA5E69CB5E96E49C = _id_7ACC5AA2B73FE93B();

    if(!isDefined(_id_EA5E69CB5E96E49C))
      continue;
    else if(isDefined(_id_EA5E69CB5E96E49C) && _id_EA5E69CB5E96E49C.size == 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("SUPER_MP/TACTICAL_CAMERA_OUT_OF_RANGE");

      continue;
    } else {
      _id_A11E3EB9A5212FCB = sortbydistance(_id_7ACC5AA2B73FE93B(), self.origin);
      cam = _id_A11E3EB9A5212FCB[0];
    }

    if(isDefined(cam))
      thread _id_5D3CBE464806A795(cam);

    waitframe();
  }
}

_id_5D3CBE464806A795(camera) {
  level endon("game_ended");
  self endon("disconnect");
  self._id_77FEFC8456ADB545 = 1;
  _id_783B392BD5803792 = getdvarfloat("dvar_83F60684C63746BE", 0.0);
  _id_9B1DEB5E9D32BBE3 = _id_02AABAC61F2AE422::_id_CFEC51CAC79CA4E6(scripts\mp\supers::getcurrentsuper(), undefined, undefined, undefined, undefined, undefined, 0, _id_783B392BD5803792, undefined, 1);
  self._id_75B981560F8453F4 = undefined;

  if(!istrue(_id_9B1DEB5E9D32BBE3)) {
    self._id_77FEFC8456ADB545 = 0;
    return 0;
  }

  if(!isDefined(camera)) {
    self._id_77FEFC8456ADB545 = 0;
    self notify("super_finished_with_deploy_weapon");
    return 0;
  }

  thread _id_A10D1D70759F9E83(camera);
}

_id_A10D1D70759F9E83(camera, _id_BB7199406CFB48D8) {
  if(!isDefined(self) || !isalive(self) || !isDefined(camera)) {
    return;
  }
  self visionsetkillstreakforplayer("tacCam", 0.0);
  self painvisionoff();
  camera notify("entering");
  self notify("usingCamera");

  if(!istrue(camera.hasbeenused)) {
    camera.hasbeenused = 1;
    camera notify("tactical_camera_has_been_piloted");
  }

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && (scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm"))
    self setclientomnvar("ui_dmz_hide_inventory", 1);

  self.isusingcamera = 1;
  self._id_77FEFC8456ADB545 = 0;
  self.currentcamera = camera;
  _id_1311C5C284DD1537::_id_81704D1224BD6FE0(self.isusingcamera);
  _id_B65E76E261A6ED4D = _id_C46995E65D020FCC();
  thread _id_9F19DB59E1560978(camera, _id_B65E76E261A6ED4D);
  thread _id_89CDD7BEC6A758EE();
  thread _id_A3D6F92E2C44200F();
  thread _id_44722FFCC8FE65DE();
  _id_1311C5C284DD1537::_id_57B6E09EDA0090D6(0);
  thread _id_1311C5C284DD1537::_id_E170D8C3CACDBAF5(camera);
  self setclientomnvar("ui_rcd_outer_ring", 0);
  thread _id_D423BB11A1CF19A5(camera);
  thread _id_1311C5C284DD1537::_id_C7DBEA1F56DF2B64(camera);
  thread _id_1311C5C284DD1537::_id_FF216D4D2C47565C(5);
  thread _id_1311C5C284DD1537::_id_B0210563A392F1A1(camera);
  thread _id_1311C5C284DD1537::_id_B1FC1520E09105AA(camera);
  thread _id_1311C5C284DD1537::_id_9AC601E206D92DEF(camera);
  thread _id_1311C5C284DD1537::_id_2699A7C2C0B71D3E(camera);
  thread _id_1FF427DC4B377ABC(camera, _id_BB7199406CFB48D8);
  thread _id_1311C5C284DD1537::_id_EF76557BFC468AD7("reconDart_allCamerasRemoved", camera);
  self _meth_E29E60C655E1220B(1);
}

_id_89CDD7BEC6A758EE() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stopMonitoringCamera");

  for(;;) {
    level waittill("tacticalCamera_camera_added", camera, _id_25519AB43F5666DF);

    if(camera.ownerteam == self.team)
      _id_8CFB97AE498AB61E(camera, _id_25519AB43F5666DF);

    waitframe();
  }
}

_id_44722FFCC8FE65DE() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stopMonitoringCamera");

  for(;;) {
    level waittill("tacticalCamera_camera_removed", camera, _id_59D945F45B4733EE);

    if(_id_1311C5C284DD1537::_id_B501CE7305720779(camera))
      self setclientomnvar("ui_tactical_camera_" + _id_59D945F45B4733EE + "_status", 0);
  }
}

_id_1D751F90A61B1801(camera, _id_07873097F48BD513, _id_4FAEC397E81604AC) {
  if(self.isusingcamera) {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && (scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm"))
      self setclientomnvar("ui_dmz_hide_inventory", 0);

    if(isDefined(camera) && !camera.hasexploded)
      _id_1311C5C284DD1537::_id_6ECB6C565C248E04(camera);

    if(!istrue(_id_07873097F48BD513)) {
      self visionsetkillstreakforplayer("");
      self painvisionon();
      self notify("super_finished_with_deploy_weapon");
      self.isusingcamera = 0;
      self.currentcamera = undefined;

      if(_id_1311C5C284DD1537::_id_3265A4A8A3BDB477("reconDart"))
        _id_1311C5C284DD1537::_id_57B6E09EDA0090D6(1);

      self notify("playerExitingCameraMode");
      thread _id_1311C5C284DD1537::_id_7858AA4F2BC91D80();
    }

    if(_id_1311C5C284DD1537::_id_58A0CAD2ABA60238(camera))
      thread _id_1311C5C284DD1537::_id_01E34B5A5489BE90(camera, _id_07873097F48BD513);
    else
      thread _id_1311C5C284DD1537::_id_B4E750DBD5734B12(camera, _id_07873097F48BD513);

    if(isDefined(camera) && !isDefined(camera.pilot) && (!isDefined(camera._id_81BD7C12AC1DCE18) || camera._id_81BD7C12AC1DCE18.size == 0)) {
      if(!istrue(_id_4FAEC397E81604AC)) {
        camera setscriptablepartstate("autopiloted", "on", 0);
        camera thread _id_1311C5C284DD1537::_id_C99B3A2B715C288B();

        if(istrue(camera.useturret)) {
          camera setmode("sentry_offline");
          camera restoredefaultdroppitch();
        }
      }
    }

    _id_A9FF1672FCC0B3F8();
    _id_66B4AFA128DECD2E();
    _id_1311C5C284DD1537::_id_13E2543CD1847CA6();
    _id_1311C5C284DD1537::_id_57E0EFE2F886BD46();
    _id_8ED527B613B0077E(::_id_C46995E65D020FCC);
    camera _id_1311C5C284DD1537::_id_EA3E848C25E3C926(self, undefined, "super_recon_dart");
    _id_1311C5C284DD1537::_id_81704D1224BD6FE0(0);
    camera showtoplayer(self);
  }

  self notify("stopMonitoringCamera");

  if(isDefined(camera))
    self notify("stopMonitoringReticleState");

  self notify("playerLeavingCurrentCamera");
  self _meth_E29E60C655E1220B(0);
}

_id_1FF427DC4B377ABC(camera, _id_BB7199406CFB48D8) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  camera endon("death");

  if(!isDefined(camera) || istrue(camera.isdestroyed))
    return 0;

  if(isDefined(camera.pilot) && camera.pilot != self && camera.owner == self) {
    _id_80B45529E6EDC950 = camera.pilot;
    _id_80B45529E6EDC950 _id_1D751F90A61B1801(camera, 1, 1);
    _id_80B45529E6EDC950 thread _id_A10D1D70759F9E83(camera, 1);
  }

  if(isDefined(camera.pilot) || istrue(_id_BB7199406CFB48D8)) {
    if(!isDefined(camera._id_81BD7C12AC1DCE18))
      camera._id_81BD7C12AC1DCE18 = [];

    camera._id_81BD7C12AC1DCE18[self getentitynumber()] = self;
    camera._id_1B381F3AA944D595[self getentitynumber()] = gettime();
    _id_1311C5C284DD1537::_id_C9AD5AAF3183B83C();
    self lerpfov(80, 0.0);
    self cameralinkTo(camera._id_A820130A6D38F1E4, "tag_origin", 1, 1);
  } else {
    level notify("camera_piloted", camera);
    camera.pilot = self;
    camera setscriptablepartstate("piloted", "on", 0);
    camera setscriptablepartstate("autopiloted", "off", 0);
    camera.useturret = getdvarint("dvar_74A62120279457E0", 1);

    if(camera.useturret) {
      camera setmode("manual");
      self remotecontrolturret(camera);
      self setplayerangles(camera.tag.angles);
    } else {
      self playerlinkweaponviewtodelta(camera.tag, "tag_player", 1.0, camera._id_DF8EAB23E5A5A0B7[1], camera._id_DF8EAB23E5A5A0B7[0], camera._id_3EBF8C1AE3ACCE22[0], camera._id_3EBF8C1AE3ACCE22[1], 0);
      self setplayerangles(camera.tag.angles);
      self playerlinkedsetviewznear(0);
    }

    _id_1311C5C284DD1537::_id_C9AD5AAF3183B83C();
    _id_1311C5C284DD1537::_id_7ABFAE4E338CC940(self, _id_1311C5C284DD1537::_id_F1493744AA061205);
    thread _id_1311C5C284DD1537::_id_FC89B224136FE202(camera);
    camera thread _id_1311C5C284DD1537::_id_54DEA0F6292103CB();
    thread _id_1311C5C284DD1537::_id_A96F380B39543647(camera);
    camera thread _id_1311C5C284DD1537::_id_CA19A92A4F9D5C3D();
  }

  _id_EB71A2588D9D796A(camera);
  thread _id_8DD9912EF55FBE3B(camera);
  thread _id_8F6AC6112BC43B15(camera);
  thread _id_1311C5C284DD1537::_id_E910B2EBA1AF834C();
  thread _id_65C2611EFF3A7DC4(camera);
  thread _id_F8C09EABC74D0CA3(camera);
  camera _id_1311C5C284DD1537::_id_EA3E848C25E3C926(self, undefined, "super_recon_dart");

  if(camera scripts\cp_mp\emp_debuff::is_empd())
    _id_1311C5C284DD1537::_id_9F25AE386DB6338A(camera, ::_id_4CCB840525638E85);
}

_id_0AFAEFCF7B894E66(player) {
  player visionsetkillstreakforplayer("");
  _id_1311C5C284DD1537::_id_8B5781DD2D18A300(player);
  _id_1311C5C284DD1537::_id_F7A32619BBA6E450("reconDart");
}

_id_4CCB840525638E85(camera) {
  return "tacCam";
}

_id_8B1C76D70CB37943(data) {
  _id_C0754CA9AA8976DA = getdvarfloat("dvar_1818FB198FA739FB", 1.0);
  _id_1311C5C284DD1537::_id_5A7867448F866939(data, _id_C0754CA9AA8976DA, ::_id_4CCB840525638E85);
}