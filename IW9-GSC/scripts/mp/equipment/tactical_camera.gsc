/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\tactical_camera.gsc
****************************************************/

_id_5027F03ACD35A5CA() {
  level._effect["vfx/iw9/fieldupgrades/ammobox/vfx_ammobox_timeout.vfx"] = loadfx("vfx/iw9/fieldupgrades/ammobox/vfx_ammobox_timeout.vfx");
  _id_1311C5C284DD1537::_id_5D36462331845D5F("tacticalCameraList");
  level._id_BB0266F422D9AFA3["tacCam"] = spawnStruct();
  _id_C13D155AD0421754();
  level.superglobals.staticsuperdata["super_tac_camera"]._id_F6604EEBABCAC6C2 = ::_id_391F2C842BCE6B0A;
}

_id_C13D155AD0421754() {
  _id_962A30A9BB8C0F09 = _id_1311C5C284DD1537::_id_F0698AEE89C18210("tacCam");
  _id_962A30A9BB8C0F09._id_5237A188CCDA4D7B = "super_tac_camera";
  _id_962A30A9BB8C0F09.lifetime = getdvarint("dvar_13717E6E87CB530F", 120);
  _id_962A30A9BB8C0F09.startfunc = ::_id_A10D1D70759F9E83;
  _id_962A30A9BB8C0F09._id_BE3314F77FEF5D6B = ::_id_096ECBF2F7E001E7;
  _id_962A30A9BB8C0F09._id_4C663252DABD1483 = ::_id_FB4A392282A75942;
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
  _id_962A30A9BB8C0F09._id_53EC43FA38FC3243 = "tacticalCameraList";
  _id_962A30A9BB8C0F09._id_9C35CA95BD1D22FA = "tacticalCameras";
  _id_962A30A9BB8C0F09._id_1790D4C69D5F45A4 = 2;
  _id_962A30A9BB8C0F09._id_5B125DF6B587A5C2 = 10;
  _id_962A30A9BB8C0F09._id_4F401574FC47899E = "tacticalCamera_camera_added";
  _id_962A30A9BB8C0F09._id_67D467748271444C = "tacticalCamera_camera_removed";
  _id_962A30A9BB8C0F09._id_0315C43D476BB095 = "tacticalCamera_location_changed";
  _id_962A30A9BB8C0F09._id_36411D05D3F1E503 = "tacticalCamera_pilot_removed";
  _id_962A30A9BB8C0F09._id_6C8C1A666ED5F48D = "hud_icon_fieldupgrade_tac_cam";
  _id_962A30A9BB8C0F09._id_91389DD68A70BE33 = "equip_tactical_cam_marking";
  _id_962A30A9BB8C0F09.maxhealth = 100;
  _id_962A30A9BB8C0F09._id_604C545B594E97EC = ::_id_3888B35BA7E2F0A9;
  _id_962A30A9BB8C0F09._id_4F1335FCE3765DA0 = ::_id_A3C2CDBC9D8548FB;
  _id_962A30A9BB8C0F09._id_58906CC2DED735DB = scripts\engine\trace::create_contents(1, 0, 0, 1, 0, 1, 0, 1, 1);
  _id_962A30A9BB8C0F09._id_0106BF36856A998F = getEntArray("tacCameraInvalid", "targetname");
}

_id_332540CA356C18B8() {
  self notify("tacticalCamera_set");
  thread _id_1311C5C284DD1537::_id_362C9A13D18031B1("personal_camera_status_updated", "ui_tactical_camera_cam_", "tacticalCamera_unset");
  _id_1311C5C284DD1537::_id_B1D73DD45D89A318("tacCam");
  _id_1311C5C284DD1537::_id_081FB12166C3C0C2(self, undefined, ::_id_0A6302BC4D39A6FA, "super_tac_camera");
  thread _id_1311C5C284DD1537::_id_3C4DA29D1ED157C7("tacCamCluster", "tacticalCamera_unset", "tacticalCamera_camera_removed", 9000000, ::_id_0A6302BC4D39A6FA);
  self setclientomnvar("ui_block_fu_not_ready_error", 1);
  self.isusingcamera = 0;

  if(!isbot(self) && !isagent(self))
    thread _id_C0D6EA536D1AA6E3();
}

_id_E0AD06F46E6D9149() {
  self notify("tacticalCamera_unset");
  _id_1311C5C284DD1537::_id_F7A32619BBA6E450("tacCam");
  _id_0987961464BEF3A3();
  self.isusingcamera = undefined;
  _id_1311C5C284DD1537::_id_8B5781DD2D18A300(self);
  _id_1311C5C284DD1537::_id_081FB12166C3C0C2(self, 1, ::_id_0A6302BC4D39A6FA, "super_tac_camera");
  self setclientomnvar("ui_block_fu_not_ready_error", 0);
  _id_FB30706D5E4A4B27(undefined);
}

_id_60367230245C7390() {}

_id_5AD1423B15C27C76() {
  scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_2E7F831F8C6F4B38());
  waitframe();
  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_2E7F831F8C6F4B38());
}

_id_0987961464BEF3A3() {
  self setclientomnvar("ui_tactical_camera_cam_0_status", 0);
  self setclientomnvar("ui_tactical_camera_cam_1_status", 0);
}

_id_DBECA4D95F44293D(grenade) {
  self endon("disconnect");
  level endon("game_ended");
  camera = _id_C778DFBE6301129A(grenade, "super_tac_camera");

  if(isDefined(camera)) {
    scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("pmc_missions", "onPlaceTacCamera", camera);
    camera.usedcount = 0;
    camera endon("death");
    camera thread _id_A1C6DC676CF5AA86();
    waitframe();
    camera thread _id_1311C5C284DD1537::_id_C99B3A2B715C288B();
    scripts\cp_mp\challenges::_id_D997435895422ECC("super_tac_camera", 0);
  }
}

_id_A1C6DC676CF5AA86() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self.owner _id_1311C5C284DD1537::_id_57B6E09EDA0090D6(1);
  self.owner setclientomnvar("ui_mgl_tac_camera_state", 1);
}

_id_F730B242EBAB274B(grenade) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("death");
  _id_5F0B7D8E7D0627B8 = getdvarint("dvar_0143EBF37DC99E63", 150);
  _id_A681B7890CD017C7 = undefined;

  for(;;) {
    _id_A681B7890CD017C7 = _id_1311C5C284DD1537::_id_7C5E1578B6FC9166(grenade);
    _id_972C39A514F196D1 = _id_A681B7890CD017C7._id_972C39A514F196D1;
    _id_82D5E3B42D0191C9 = _id_A681B7890CD017C7._id_82D5E3B42D0191C9;
    _id_CB4D3248C7F2EADF = 0;

    if(isDefined(_id_82D5E3B42D0191C9)) {
      if(_id_82D5E3B42D0191C9 scripts\cp_mp\vehicles\vehicle::isvehicle() && _id_82D5E3B42D0191C9 scripts\cp_mp\vehicles\vehicle::_id_2A503318E000E11D()) {
        if(_id_82D5E3B42D0191C9.vehiclename == "pac_sentry" || _id_82D5E3B42D0191C9.vehiclename == "radar_drone_recon" || _id_82D5E3B42D0191C9.vehiclename == "assault_drone")
          _id_CB4D3248C7F2EADF = 1;
      }
    }

    if(isDefined(_id_972C39A514F196D1))
      _id_CB4D3248C7F2EADF = 1;

    if(_id_CB4D3248C7F2EADF) {
      _id_A14EE21EA6C8793D = vectordot(anglestoup(grenade.angles), (0, 0, 1)) >= 0.99;
      _id_C65F75877E6FADCD = anglestoup(grenade.angles) * _id_5F0B7D8E7D0627B8;

      if(_id_A14EE21EA6C8793D)
        _id_C65F75877E6FADCD = _id_C65F75877E6FADCD + anglesToForward(grenade.angles) * _id_5F0B7D8E7D0627B8;

      grenade unlink();
      grenade = scripts\mp\utility\weapon::_launchgrenade(_id_2E7F831F8C6F4B38(), grenade.origin, _id_C65F75877E6FADCD, undefined, 1, grenade);
      continue;
    }

    break;
  }

  return _id_A681B7890CD017C7;
}

_id_C778DFBE6301129A(grenade, superid) {
  _id_A681B7890CD017C7 = _id_F730B242EBAB274B(grenade);

  if(!isDefined(_id_A681B7890CD017C7)) {
    return;
  }
  _id_7A2D144A06A00B97 = _id_A681B7890CD017C7._id_82D5E3B42D0191C9;
  position = grenade gettagorigin("tag_player");
  camera = _id_1311C5C284DD1537::_id_EE24B83D39692536(grenade, _id_7A2D144A06A00B97, position, "tactical_camera_turret_mp", "turret_tactical_camera_v0", "tacCam");
  grenade delete();

  if(!scripts\mp\supers::issuperready())
    self notify("tacticalCamera_camera_spawned");

  if(level.teambased) {
    if(_id_1311C5C284DD1537::_id_E60E9CE3B6484E52("tacCam")) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("SUPER_MP/TACTICAL_CAMERA_MAX_TEAM_NUM");

      camera thread _id_98D9692F988BFE4D();
      scripts\mp\supers::refundsuper();
      return;
    }
  }

  camera endon("death");
  camera.hasexploded = 0;

  if(isDefined(_id_A681B7890CD017C7._id_6150B9D03028F80C))
    camera._id_6150B9D03028F80C = 1;

  camera thread _id_1311C5C284DD1537::_id_B3B59C099F93A503();
  camera._id_11F51147CCFF0163 = 1;
  camera thread _id_EA7D2B522E1E6E1A();
  camera.issuper = 1;
  camera.superid = level.superglobals.staticsuperdata[superid].id;
  camera.creationtime = gettime();
  camera.ownerteam = grenade.owner.team;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("deployable_camera", "attachXRays"))
    camera = [[scripts\cp_mp\utility\script_utility::getsharedfunc("deployable_camera", "attachXRays")]](camera);

  camera _id_1311C5C284DD1537::_id_23CF186C8B512748();
  thread _id_1311C5C284DD1537::_id_DA29E274CC4A86F4(camera);
  _id_1311C5C284DD1537::_id_9CD4393CAC778989(camera, undefined, 1);
  _id_1311C5C284DD1537::_id_99F14479415346E9(camera);
  waitframe();
  thread _id_1311C5C284DD1537::_id_CEF7DB6ABFE1CEEB(camera);
  _id_1311C5C284DD1537::_id_9C46884FE9337FA7(camera);
  camera thread _id_1311C5C284DD1537::_id_45A7E0EDC973D037();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "clearOOB"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "clearOOB")]](camera, 1);

  thread _id_1311C5C284DD1537::_id_8409D7CE07F426A1(camera);

  if(isDefined(camera._id_DF8EAB23E5A5A0B7[0]))
    camera setleftarc(camera._id_DF8EAB23E5A5A0B7[0]);

  if(isDefined(camera._id_DF8EAB23E5A5A0B7[1]))
    camera setrightarc(camera._id_DF8EAB23E5A5A0B7[1]);

  if(isDefined(camera._id_3EBF8C1AE3ACCE22[1]))
    camera setbottomarc(camera._id_3EBF8C1AE3ACCE22[1]);

  if(isDefined(camera._id_3EBF8C1AE3ACCE22[0]))
    camera settoparc(camera._id_3EBF8C1AE3ACCE22[0]);

  if(1)
    thread scripts\mp\weapons::outlineequipmentforowner(camera);

  if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    camera _id_1311C5C284DD1537::_id_FE1CD71ED406A649();

  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::_id_0AFAEFCF7B894E66);
  camera setscriptablepartstate("plant", "on", 0);
  camera setscriptablepartstate("ddos", "neutral", 0);
  camera _id_736DEC95A49487A6::_id_172D848D58051FDF(_id_1311C5C284DD1537::_id_652247CE1ACB67C2);
  camera scripts\cp_mp\emp_debuff::set_start_emp_callback(::_id_8B1C76D70CB37943);
  camera enableplayermarks("equipment");

  if(level.teambased)
    camera filteroutplayermarks(self.team);
  else
    camera filteroutplayermarks(self);

  _id_4A2FE2F78500ABD6 = camera _id_1311C5C284DD1537::_id_6436809A4ED7E363();

  if(_id_4A2FE2F78500ABD6)
    thread _id_1311C5C284DD1537::_id_45556AA41F4F9AE8(camera, camera._id_DEFBEED1A2C29C34, 1);
  else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("SUPER_MP/TACTICAL_CAMERA_INVALID_DEPLOYMENT");

  camera _id_49197CD063A740EA(::_id_FB4A392282A75942);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators)
    elevators thread _id_5F903436642211AF::_id_5C07037726AE5001(camera);
  }

  camera _id_0EB2CA6DA697DA5D();
  camera thread _id_1311C5C284DD1537::_id_5E8B74F5E3DC4C60();
  return camera;
}

_id_98D9692F988BFE4D(attacker, _id_4FAC8B8CE36E09F1) {
  self notify("explode");
  self.hasexploded = 1;
  self setscriptablepartstate("damaged", "off", 0);
  _id_FB4A392282A75942();
}

_id_FB4A392282A75942(immediate, _id_1548B5D7F8624206, _id_86B37B7A946B6A67) {
  if(!isDefined(immediate))
    immediate = !istrue(self.planted);

  _id_CBF7BE4F62A0DDB2 = 0;

  if(isDefined(self) && !istrue(self.isdestroyed)) {
    if(!isDefined(_id_86B37B7A946B6A67))
      _id_86B37B7A946B6A67 = _id_1311C5C284DD1537::_id_66758C7FFF976896();

    if(!istrue(_id_1548B5D7F8624206) && !_id_86B37B7A946B6A67)
      self.owner thread _id_1311C5C284DD1537::_id_45556AA41F4F9AE8(self, self._id_DEFBEED1A2C29C34, 3, undefined, 3.25);

    self setscriptablepartstate("destroyed", "on", 0);
    _id_1311C5C284DD1537::_id_06976F2B3945C32F("tacCam");
    _id_1311C5C284DD1537::_id_7ABFAE4E338CC940(self.owner, ::_id_C969B8D603818CFC);
    thread _id_84AB622261B746E3(_id_86B37B7A946B6A67);
  }
}

_id_66B731696D3BC6B8() {
  _id_1311C5C284DD1537::_id_57B6E09EDA0090D6(0);
  _id_1311C5C284DD1537::_id_86B60845E9A3D301("tacCam");
  self notify("tacticalCamera_allCamerasRemoved");
}

_id_84AB622261B746E3(_id_86B37B7A946B6A67) {
  self notify("death");
  self.isdestroyed = 1;
  self setCanDamage(0);

  if(isDefined(self.owner))
    self.owner scripts\mp\weapons::removeequip(self);

  _id_1311C5C284DD1537::_id_67240DB2BF930CCD();
  _id_1311C5C284DD1537::_id_FC9294FFBD3490F3();

  if(isDefined(self.owner) && !istrue(_id_86B37B7A946B6A67)) {
    self.owner setclientomnvar("ui_mgl_tac_camera_state", 0);
    _id_1311C5C284DD1537::_id_4BE323B74B86DBC9(self);

    if(!self.owner _id_1311C5C284DD1537::_id_3265A4A8A3BDB477("tacCam"))
      self.owner _id_66B731696D3BC6B8();

    self.owner _id_1311C5C284DD1537::_id_F5CDA4DA64C5C579(self);
  }

  self._id_DF8EAB23E5A5A0B7 = undefined;
  self.tag = undefined;
  self._id_A820130A6D38F1E4 = undefined;
  self._id_325727B6C2E7F058 = undefined;
  self setturretowner(undefined);

  if(!istrue(_id_86B37B7A946B6A67))
    self.owner scripts\cp_mp\challenges::_id_D997435895422ECC("super_tac_camera", 3, self.usedcount);

  self.usedcount = undefined;
  wait 0.1;
  self delete();
}

_id_7ACC5AA2B73FE93B() {
  return self._id_7D73CBB5CA5D6E32["tacCamCluster"];
}

_id_FB30706D5E4A4B27(val) {
  self._id_7D73CBB5CA5D6E32["tacCamCluster"] = val;
}

_id_C3D0CCB8F9A3D594() {
  self setclientomnvar("ui_block_fu_not_ready_error", 1);
}

_id_EA7D2B522E1E6E1A() {
  level endon("game_ended");
  self endon("death");
  scripts\engine\utility::waittill_notify_or_timeout("tactical_camera_has_been_piloted", 3.0);
  self._id_11F51147CCFF0163 = 0;
}

_id_C969B8D603818CFC(_id_161E86C260D6864C, player) {
  if(_id_161E86C260D6864C.markingent == self)
    _id_1311C5C284DD1537::_id_47C44D1BF801B8F0(_id_161E86C260D6864C, player, 0);
}

_id_0A6302BC4D39A6FA() {
  return _id_1311C5C284DD1537::_id_C827C58258222D48("tacCam");
}

_id_8ED527B613B0077E(_id_C380EB54A8ADB38C) {
  _id_B65E76E261A6ED4D = [[_id_C380EB54A8ADB38C]]();
  _id_922B0ED93B663936 = "ui_tactical_camera_pilot";
  self setclientomnvar(_id_922B0ED93B663936, undefined);
  self setclientomnvar("ui_tactical_camera_can_detonate_c4", 0);
  self setclientomnvar("ui_tactical_camera_index", 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
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

_id_55C50EE365C1CD12(camera, currenttime) {
  waitframe();
  health = camera _id_C0C307FAC6611F33();
  self setclientomnvar("ui_killstreak_health", health);
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
    _id_B65E76E261A6ED4D = _id_0A6302BC4D39A6FA();
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

    _id_B65E76E261A6ED4D = _id_0A6302BC4D39A6FA();
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

    _id_B65E76E261A6ED4D = _id_0A6302BC4D39A6FA();
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

  if(isPlayer(_id_B995F95867DE9AAB))
    _id_B995F95867DE9AAB scripts\mp\utility\stats::incpersstat("tacCamMarks", 1);

  self.usedcount++;
  _id_1311C5C284DD1537::_id_88B3522BBDF2F7C1(0);
  _id_1311C5C284DD1537::_id_88B3522BBDF2F7C1(1);
  _id_C8462289EDFC0ACA = _id_B995F95867DE9AAB _id_1311C5C284DD1537::_id_89B59BEDB3802E41();
  _id_1311C5C284DD1537::_id_EC57E0ACBC6C6879(_id_C8462289EDFC0ACA, target, 2);
  self.owner scripts\cp_mp\challenges::_id_D997435895422ECC("super_tac_camera", 1);
  _id_6A8EC730B2BFA844::_id_815A3DCB943176B3(self.owner, target);
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

_id_C0D6EA536D1AA6E3() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("monitoringCamActivation");
  self endon("monitoringCamActivation");
  self endon("tacticalCamera_unset");

  for(;;) {
    success = _id_1311C5C284DD1537::_id_30DD206C5D9B45A7();

    if(!success) {
      continue;
    }
    if(!_id_1311C5C284DD1537::_id_84582DD92C385507(_id_2E7F831F8C6F4B38())) {
      continue;
    }
    if(scripts\mp\supers::issuperready() && !istrue(self._id_75B981560F8453F4)) {
      continue;
    }
    grenade = undefined;
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

_id_1AF63ADB97F131A1(objweapon) {
  _id_1311C5C284DD1537::_id_EB1F8C19D4194AC3(objweapon, ::_id_7ACC5AA2B73FE93B, _id_2E7F831F8C6F4B38());
}

_id_5D3CBE464806A795(camera) {
  level endon("game_ended");
  self endon("disconnect");
  _id_1311C5C284DD1537::_id_9CD4393CAC778989(camera);
  self._id_77FEFC8456ADB545 = 1;
  _id_783B392BD5803792 = getdvarfloat("dvar_83F60684C63746BE", 0.0);
  _id_9B1DEB5E9D32BBE3 = _id_02AABAC61F2AE422::_id_CFEC51CAC79CA4E6(scripts\mp\supers::getcurrentsuper(), undefined, undefined, undefined, undefined, undefined, 0, _id_783B392BD5803792, undefined, 1);
  self._id_75B981560F8453F4 = undefined;

  if(!istrue(_id_9B1DEB5E9D32BBE3)) {
    self._id_77FEFC8456ADB545 = 0;
    return 0;
  }

  if(!isDefined(camera) || istrue(camera.isdestroyed)) {
    self._id_77FEFC8456ADB545 = 0;
    self notify("super_finished_with_deploy_weapon");
    return 0;
  }

  scripts\cp_mp\utility\killstreak_utility::movingplatform_playerlink(self);

  if(isDefined(camera._id_DF8EAB23E5A5A0B7[0]))
    camera setleftarc(camera._id_DF8EAB23E5A5A0B7[0]);

  if(isDefined(camera._id_DF8EAB23E5A5A0B7[1]))
    camera setrightarc(camera._id_DF8EAB23E5A5A0B7[1]);

  if(isDefined(camera._id_3EBF8C1AE3ACCE22[1]))
    camera setbottomarc(camera._id_3EBF8C1AE3ACCE22[1]);

  if(isDefined(camera._id_3EBF8C1AE3ACCE22[0]))
    camera settoparc(camera._id_3EBF8C1AE3ACCE22[0]);

  thread _id_A10D1D70759F9E83(camera);
}

_id_A10D1D70759F9E83(camera, _id_BB7199406CFB48D8) {
  self._id_77FEFC8456ADB545 = 0;

  if(!_id_1311C5C284DD1537::_id_0E5A484F7C5FAF5B(camera)) {
    self notify("cancel_all_super_deployments");
    return 0;
  }

  _id_1311C5C284DD1537::_id_4789702C319CD7A7(camera);
  self painvisionoff();
  camera notify("entering");
  self notify("usingCamera");

  if(!istrue(camera.hasbeenused)) {
    camera.hasbeenused = 1;
    camera notify("tactical_camera_has_been_piloted");
  }

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && (scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm"))
    self setclientomnvar("ui_dmz_hide_inventory", 1);

  self setclientomnvar("ui_mgl_tac_camera_state", 2);
  self.isusingcamera = 1;
  self.currentcamera = camera;
  _id_1311C5C284DD1537::_id_81704D1224BD6FE0(self.isusingcamera);
  _id_B65E76E261A6ED4D = _id_0A6302BC4D39A6FA();
  thread _id_9F19DB59E1560978(camera, _id_B65E76E261A6ED4D);
  thread _id_89CDD7BEC6A758EE();
  thread _id_A3D6F92E2C44200F();
  thread _id_44722FFCC8FE65DE();
  _id_1311C5C284DD1537::_id_57B6E09EDA0090D6(0, 1);
  thread _id_1311C5C284DD1537::_id_E170D8C3CACDBAF5(camera, "tacticalCamera_unset", "tacCam");
  self setclientomnvar("ui_rcd_outer_ring", 0);
  thread _id_55C50EE365C1CD12(camera);
  thread _id_D423BB11A1CF19A5(camera);
  thread _id_1311C5C284DD1537::_id_C7DBEA1F56DF2B64(camera, "tacCam");
  thread _id_1311C5C284DD1537::_id_FF216D4D2C47565C(5);
  thread _id_1311C5C284DD1537::_id_B0210563A392F1A1(camera);
  thread _id_1311C5C284DD1537::_id_B1FC1520E09105AA(camera);
  thread _id_1311C5C284DD1537::_id_9AC601E206D92DEF(camera, undefined, "tacCam");
  thread _id_1311C5C284DD1537::_id_2699A7C2C0B71D3E(camera, "tacCam");
  thread _id_1311C5C284DD1537::_id_073AF051EC0973E1(camera, "tacCamCluster", "tacCam");

  if(_id_2D9D24F7C63AC143::_id_8B121DD10A442DD2())
    self setclientomnvar("ui_br_inventory_disabled", 1);

  thread _id_97A30AE5803A8886(camera, _id_BB7199406CFB48D8);
  thread _id_1311C5C284DD1537::_id_EF76557BFC468AD7("tacticalCamera_allCamerasRemoved", camera);
  scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();

  if(!isDefined(camera.sfx) && istrue(self.isusingcamera)) {
    self _meth_E29E60C655E1220B(1);
    camera.sfx = spawn("script_origin", camera.origin);
    camera.sfx showonlytoplayer(self);
    camera.sfx playLoopSound("equip_tactical_cam_amb_lp");
  }
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

_id_096ECBF2F7E001E7(camera, _id_07873097F48BD513, _id_69DE8A76EEC00070) {
  if(istrue(self.isusingcamera)) {
    scripts\cp_mp\utility\player_utility::stopwatchingthermalinputchange();

    if(scripts\cp_mp\utility\player_utility::isreallyalive(self)) {
      scripts\cp_mp\utility\killstreak_utility::starttabletscreen("super_tac_camera", 0.0, 1);
      self setclientomnvar("ui_total_fade", 0);
    }

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && (scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm"))
      self setclientomnvar("ui_dmz_hide_inventory", 0);

    if(!istrue(_id_07873097F48BD513)) {
      _id_1311C5C284DD1537::_id_ECA023AD97260F51(camera);
      self painvisionon();
      self notify("super_finished_with_deploy_weapon");
      self.isusingcamera = 0;
      self.currentcamera = undefined;

      if(_id_1311C5C284DD1537::_id_3265A4A8A3BDB477("tacCam"))
        _id_1311C5C284DD1537::_id_57B6E09EDA0090D6(1);

      self notify("playerExitingCameraMode");
      thread _id_1311C5C284DD1537::_id_7858AA4F2BC91D80();
    }

    if(_id_1311C5C284DD1537::_id_58A0CAD2ABA60238(camera))
      thread _id_1311C5C284DD1537::_id_01E34B5A5489BE90(camera, _id_07873097F48BD513, "tacCam");
    else
      thread _id_1311C5C284DD1537::_id_B4E750DBD5734B12(camera, _id_07873097F48BD513);

    if(isDefined(camera) && !isDefined(camera.pilot) && (!isDefined(camera._id_81BD7C12AC1DCE18) || camera._id_81BD7C12AC1DCE18.size == 0)) {
      if(!istrue(_id_69DE8A76EEC00070)) {
        camera setscriptablepartstate("autopiloted", "on", 0);
        camera thread _id_1311C5C284DD1537::_id_C99B3A2B715C288B();
        camera setmode("sentry_offline");
        camera restoredefaultdroppitch();
      }
    }

    self._id_1A7488645F360CB1 = 0;
    _id_8ED527B613B0077E(::_id_0A6302BC4D39A6FA);

    if(scripts\cp_mp\utility\player_utility::isreallyalive(self))
      _id_1311C5C284DD1537::_id_81704D1224BD6FE0(0);

    _id_1311C5C284DD1537::_id_13E2543CD1847CA6();
    _id_1311C5C284DD1537::_id_57E0EFE2F886BD46();

    if(isDefined(camera)) {
      camera _id_1311C5C284DD1537::_id_EA3E848C25E3C926(self, undefined, "super_tac_camera");
      camera showtoplayer(self);
    }
  }

  thread _id_1311C5C284DD1537::_id_07DF57541F06A5F0();
  scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
  self notify("stopMonitoringCamera");
  self setclientomnvar("ui_mgl_tac_camera_state", 1);

  if(_id_2D9D24F7C63AC143::_id_8B121DD10A442DD2())
    self setclientomnvar("ui_br_inventory_disabled", 0);

  scripts\cp_mp\utility\killstreak_utility::movingplatform_playerunlink(self);

  if(isDefined(camera))
    self notify("stopMonitoringReticleState");

  self notify("playerLeavingCurrentCamera");
  self _meth_E29E60C655E1220B(0);

  if(isDefined(camera.sfx)) {
    camera.sfx stoploopsound("equip_tactical_cam_amb_lp");
    camera.sfx delete();
  }
}

_id_97A30AE5803A8886(camera, _id_BB7199406CFB48D8) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  camera endon("death");

  if(!istrue(self.isusingcamera)) {
    return;
  }
  if(isDefined(camera.pilot) && camera.pilot != self && camera.owner == self) {
    _id_80B45529E6EDC950 = camera.pilot;
    _id_80B45529E6EDC950 _id_096ECBF2F7E001E7(camera, 1, 1);
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
    thread _id_1311C5C284DD1537::_id_804A24F3E1A7B680();
    thread _id_1311C5C284DD1537::_id_2F4E45AB83F0B424(camera);
    camera setscriptablepartstate("piloted", "on", 0);
    camera setscriptablepartstate("autopiloted", "off", 0);
    camera setmode("manual");
    self remotecontrolturret(camera);
    self._id_1A7488645F360CB1 = 1;
    _id_1311C5C284DD1537::_id_C9AD5AAF3183B83C();
    _id_1311C5C284DD1537::_id_7ABFAE4E338CC940(self, _id_1311C5C284DD1537::_id_F1493744AA061205);
    thread _id_1311C5C284DD1537::_id_FC89B224136FE202(camera);
    camera thread _id_1311C5C284DD1537::_id_54DEA0F6292103CB();
    thread _id_1311C5C284DD1537::_id_A96F380B39543647(camera);
    camera thread _id_1311C5C284DD1537::_id_CA19A92A4F9D5C3D("tacCam");
  }

  _id_EB71A2588D9D796A(camera);
  thread _id_8DD9912EF55FBE3B(camera);
  thread _id_8F6AC6112BC43B15(camera);
  thread _id_1311C5C284DD1537::_id_E910B2EBA1AF834C();
  camera _id_1311C5C284DD1537::_id_EA3E848C25E3C926(self, undefined, "super_tac_camera");

  if(camera scripts\cp_mp\emp_debuff::is_empd())
    _id_1311C5C284DD1537::_id_9F25AE386DB6338A(camera);
}

_id_0AFAEFCF7B894E66(player) {
  _id_1311C5C284DD1537::_id_8B5781DD2D18A300(player);
  _id_1311C5C284DD1537::_id_F7A32619BBA6E450("tacCam");
}

_id_8B1C76D70CB37943(data) {
  _id_C0754CA9AA8976DA = getdvarfloat("dvar_1818FB198FA739FB", 1.0);
  _id_1311C5C284DD1537::_id_5A7867448F866939(data, _id_C0754CA9AA8976DA);
}

_id_A3C2CDBC9D8548FB(data) {
  if(data.meansofdeath == "MOD_IMPACT")
    return 0;

  _id_10D243B75EC6D6AE = !isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, data.attacker);
  _id_415AF0EA29077AD9 = data.damage;
  hits = undefined;

  if(isexplosivedamagemod(data.meansofdeath))
    hits = _id_E7A4ACA0FB7AA905(data, _id_10D243B75EC6D6AE);
  else if(scripts\engine\utility::isbulletdamage(data.meansofdeath))
    hits = _id_8CAA1657978D84CA(data, _id_10D243B75EC6D6AE);

  if(isDefined(hits))
    _id_415AF0EA29077AD9 = int(ceil(min(1, hits / 5) * self.maxhealth));

  self.owner setclientomnvar("ui_killstreak_health", (_id_C0C307FAC6611F33() - _id_415AF0EA29077AD9) / self.maxhealth);

  if(self.damagetaken + _id_415AF0EA29077AD9 / self.maxhealth > 0.5) {
    if(!istrue(self._id_325727B6C2E7F058)) {
      self._id_325727B6C2E7F058 = 1;
      self setscriptablepartstate("damaged", "on", 0);
    }
  }

  return _id_415AF0EA29077AD9;
}

_id_3888B35BA7E2F0A9(data) {
  _id_1BE0D458243B1EE1(data.attacker);
  thread _id_98D9692F988BFE4D(data.attacker, 1);
}

_id_8CAA1657978D84CA(data, _id_10D243B75EC6D6AE) {
  _id_2DDCAF824AC5D676 = scripts\engine\utility::ter_op(scripts\mp\utility\damage::isfmjdamage(data.objweapon, data.meansofdeath) && _id_10D243B75EC6D6AE, 2, 0);

  if(data.damage > 150)
    return _id_2DDCAF824AC5D676 + 10;

  if(data.damage >= 50)
    return _id_2DDCAF824AC5D676 + 5;
  else if(data.damage >= 30)
    return _id_2DDCAF824AC5D676 + 3;
  else if(data.damage >= 20)
    return _id_2DDCAF824AC5D676 + 2;
  else
    return _id_2DDCAF824AC5D676 + 1;
}

_id_E7A4ACA0FB7AA905(data, _id_10D243B75EC6D6AE) {
  if(data.damage > 200)
    return 20;

  if(data.damage > 70)
    return 10;
  else if(data.damage > 30)
    return 7;
  else
    return 2;
}

_id_C0C307FAC6611F33() {
  return int(max(0, self.maxhealth - self.damagetaken));
}

_id_1BE0D458243B1EE1(attacker) {
  if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_521EDEBB385E3753");
    attacker thread scripts\mp\battlechatter_mp::_id_883240EB5234490E("stat_0511AC9E9A1A18D8");
  }
}

_id_391F2C842BCE6B0A() {
  return _id_1311C5C284DD1537::_id_3265A4A8A3BDB477("tacCam");
}

_id_816F56A680E52D71() {
  _id_D039C888EFBBFCFD = _id_2669878CF5A1B6BC::getgrenadeinpullback();

  if(isDefined(_id_D039C888EFBBFCFD) && isDefined(_id_D039C888EFBBFCFD.basename) && _id_D039C888EFBBFCFD.basename == "tac_camera_mp") {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_D039C888EFBBFCFD);
    wait 0.05;
    scripts\mp\supers::refundsuper();
  }
}

_id_0EB2CA6DA697DA5D() {
  if(!isDefined(level.mapname) || level.mapname != "mp_bio_lab") {
    return;
  }
  if(!isDefined(self.owner))
    return 0;

  _id_52C4C7423DA6A533 = level._id_F2A8E4A4AF870513;
  _id_B94EB495411123FE = level._id_029CED2D4D9A0BDE;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_52C4C7423DA6A533.size; _id_AC0E594AC96AA3A8++) {
    area = _id_52C4C7423DA6A533[_id_AC0E594AC96AA3A8];
    _id_56945679B4F26DB9 = _id_52C4C7423DA6A533[_id_AC0E594AC96AA3A8] == "lv3_security_storage_lab";
    _id_6BCC6405C250ECB4 = level._id_029CED2D4D9A0BDE[area];

    if(!_id_56945679B4F26DB9) {
      continue;
    }
    if(self istouching(_id_6BCC6405C250ECB4)) {
      _id_6A8EC730B2BFA844::_id_A3E1795E126D3738(self.owner);
      return 1;
    }

    break;
  }

  return 0;
}

_id_2E7F831F8C6F4B38() {
  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    return "tac_camera_mp_mgl";
  else
    return "tac_camera_mp";
}

_id_49197CD063A740EA(_id_960061306B2CAAA6) {
  self._id_D1659ED0A33BF98F = _id_960061306B2CAAA6;
}