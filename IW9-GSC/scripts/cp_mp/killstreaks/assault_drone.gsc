/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\assault_drone.gsc
*******************************************************/

init() {
  _id_308EC7DA3CB5926A();
  _id_D91E42F2A9D746A8();
  _id_3A2D3D065646C104();
  _id_13C1D2376167D45E();
  _id_2A27F30882F6A886();
}

_id_308EC7DA3CB5926A() {
  level.helperdronesettings["assault_drone"] = spawnStruct();
  level.helperdronesettings["assault_drone"].timeout = 30.0;
  level.helperdronesettings["assault_drone"].maxhealth = 100;
  level.helperdronesettings["assault_drone"].hitstokill = 1;
  level.helperdronesettings["assault_drone"].speed = 100;
  level.helperdronesettings["assault_drone"].accel = 20;
  level.helperdronesettings["assault_drone"].halfsize = 27;
  level.helperdronesettings["assault_drone"].spawndist = 30;
  level.helperdronesettings["assault_drone"].streakname = "assault_drone";
  level.helperdronesettings["assault_drone"].vehicleinfo = "veh_assault_drone_mp";
  level.helperdronesettings["assault_drone"].modelbase = "veh9_mil_air_bomb_drone_c4_attached_mp";
  level.helperdronesettings["assault_drone"].teamsplash = "used_assault_drone";
  level.helperdronesettings["assault_drone"].destroyedsplash = "callout_destroyed_assault_drone";
  level.helperdronesettings["assault_drone"].scorepopup = "destroyed_assault_drone";
  level.helperdronesettings["assault_drone"].primarymode = "MANUAL";
  level.helperdronesettings["assault_drone"].primarymodestring = "test string";
  level.helperdronesettings["assault_drone"].primarymodefunc = ::_id_FB7ED8DFABEAED9A;
  level.helperdronesettings["assault_drone"].premoddamagefunc = undefined;
  level.helperdronesettings["assault_drone"].postmoddamagefunc = scripts\cp_mp\killstreaks\helper_drone::_id_CAF721CB23374E2B;
  level.helperdronesettings["assault_drone"].deathfunc = scripts\cp_mp\killstreaks\helper_drone::_id_BA1C5496F8FC5F67;
  level.helperdronesettings["assault_drone"]._id_1C606430B81B28FF = ::_id_2445ADF5D64EEF6F;
  level.helperdronesettings["assault_drone"]._id_BE3314F77FEF5D6B = ::_id_91AE4F6ECE59691F;
  level.helperdronesettings["assault_drone"]._id_63A39D0CEA63CBB2 = ::_id_87AD014181A233AA;
  level.helperdronesettings["assault_drone"]._id_5D9D3E47B1B88B84 = ::_id_F09621755C154350;
  level.helperdronesettings["assault_drone"]._id_9C6EFC85B74204CC = ::_id_A4CFBE3F567AF798;
  level.helperdronesettings["assault_drone"].playfxcallback = scripts\cp_mp\killstreaks\helper_drone::_id_56966B077270A18E;
  level.helperdronesettings["assault_drone"]._id_0C25A8137257A96D = ::_id_29A52FE5C2A8EB57;
  level.helperdronesettings["assault_drone"]._id_191284E2E2837328 = ::_id_8648618E4FAC5041;
  level.helperdronesettings["assault_drone"]._id_6A390682C21BC49E = 0;
  level.helperdronesettings["assault_drone"]._id_1947A47C2174D02C = 0;
  level.helperdronesettings["assault_drone"]._id_CB2C3FE0819193EB = 73984;
  level.helperdronesettings["assault_drone"]._id_D5EA718ABFC8FF5B = 10000;
  level.helperdronesettings["assault_drone"]._id_A117852275E49E64 = "assault_drone_color_mp";
  level.helperdronesettings["assault_drone"]._id_2215FA459D8250C0 = "assault_drone_color_dark_mp";
  level.helperdronesettings["assault_drone"]._id_52C3B4BC88132AEE = 1;
  level.helperdronesettings["assault_drone"]._id_5C59BDB4308EE080 = 0;
  level.helperdronesettings["assault_drone"]._id_DD47AEDE4AD7E18A = 1;
  level.helperdronesettings["assault_drone"]._id_52858F12C0EF4C03 = 1;
  level.helperdronesettings["assault_drone"]._id_5C6A7212BF9FCBEA = 0;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    level.helperdronesettings["assault_drone"].diewithowner = 1;
}

_id_D91E42F2A9D746A8() {
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("assaultDrone_switch", ["allow_movement", "allow_jump", "supers", "killstreaks", "vehicle_use"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("assaultDrone_deploy", ["usability", "melee", "offhand_weapons", "weapon_switch"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("assaultDrone_use", ["fire", "shellshock", "melee"]);
}

_id_3A2D3D065646C104() {
  game["dialog"]["assault_drone_use"] = "killstreak_remote_operator_request_response";
  game["dialog"]["assault_drone_timeout"] = "killstreak_remote_operator_timeout";
  game["dialog"]["assault_drone_destroyed"] = "killstreak_remote_operator_crash";
  game["dialog"]["assault_drone_hit_target"] = "killstreak_remote_operator_hit_target";
  game["dialog"]["assault_drone_miss_target"] = "killstreak_remote_operator_miss_target";
}

_id_13C1D2376167D45E() {}

_id_2A27F30882F6A886() {
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("assault_drone_color_mp");
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("assault_drone_color_dark_mp");
}

_id_E24EF5600F59548E() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("assault_drone", self);
  return _id_2445ADF5D64EEF6F(streakinfo);
}

_id_2445ADF5D64EEF6F(streakinfo) {
  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle())
    return 0;

  _id_3B64EB40368C1450::_id_3633B947164BE4F3("assaultDrone_switch", 0);

  if(scripts\common\utility::iscp())
    deployweaponobj = makeweapon("ks_assault_drone_cp");
  else
    deployweaponobj = makeweapon("ks_assault_drone_mp");

  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, deployweaponobj, 1, scripts\cp_mp\killstreaks\helper_drone::weapongivenhelperdrone);

  if(!istrue(_id_9B1DEB5E9D32BBE3)) {
    _id_3B64EB40368C1450::_id_588F2307A3040610("assaultDrone_switch");
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      _id_3B64EB40368C1450::_id_588F2307A3040610("assaultDrone_switch");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      streakinfo notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }
  }

  helperdronetype = streakinfo.streakname;
  _id_E5C7FFB094DC9EEC = 2;
  _id_52A5BE2E2F91D710 = 0.5;
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("assaultDrone_deploy", 0);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "heliEndRide");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);

  result = scripts\engine\utility::waittill_any_timeout_1(_id_E5C7FFB094DC9EEC, "death");

  if(!isDefined(result) || result != "timeout") {
    scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "assaultDrone");
    _id_3B64EB40368C1450::_id_588F2307A3040610("assaultDrone_switch");
    _id_3B64EB40368C1450::_id_588F2307A3040610("assaultDrone_deploy");
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  startpos = scripts\cp_mp\killstreaks\helper_drone::_id_34280B807C23A453(helperdronetype);
  startangles = self.angles;
  _id_876657A6669C093A = _id_37873A0B82DAD887(startpos, startangles, helperdronetype, streakinfo);

  if(!isDefined(_id_876657A6669C093A)) {
    scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "assaultDrone");
    _id_3B64EB40368C1450::_id_588F2307A3040610("assaultDrone_switch");
    _id_3B64EB40368C1450::_id_588F2307A3040610("assaultDrone_deploy");
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "_launchGrenade")) {
    dangericonent = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "_launchGrenade")]]("assault_drone_danger_mp", _id_876657A6669C093A.origin, (0, 0, 0), 100, 1);
    dangericonent linkTo(_id_876657A6669C093A);
    _id_876657A6669C093A.dangericonent = dangericonent;
  }

  thread scripts\cp_mp\killstreaks\helper_drone::helperdrone_giveplayerfauxremote(streakinfo);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakUse"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakUse")]]("assault_drone");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]())
      _id_876657A6669C093A vehicleshowonminimap(0);
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakusedialog(streakinfo.streakname);
  _id_876657A6669C093A scripts\cp_mp\killstreaks\helper_drone::helperdrone_notifyenemyplayersinrange(streakinfo.streakname);
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "assaultDrone");
  scripts\cp_mp\killstreaks\helper_drone::_id_C3786C4FBA09C2F2(streakinfo);
  thread scripts\cp_mp\killstreaks\helper_drone::starthelperdrone(_id_876657A6669C093A);
  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(streakinfo.streakname, streakinfo.streakname + "_use", 1, _id_52A5BE2E2F91D710);
  return 1;
}

_id_37873A0B82DAD887(startpos, startang, helperdronetype, streakinfo) {
  _id_876657A6669C093A = scripts\cp_mp\killstreaks\helper_drone::createhelperdrone(startpos, startang, helperdronetype, streakinfo, 0, 1);

  if(!isDefined(_id_876657A6669C093A)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");

    scripts\cp_mp\killstreaks\helper_drone::helperdronecreationfailedfx(helperdronetype, startpos);
    streakinfo notify("killstreak_finished_with_deploy_weapon");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();

    scripts\cp_mp\killstreaks\helper_drone::_id_C3786C4FBA09C2F2(streakinfo);
    return undefined;
  }

  return _id_876657A6669C093A;
}

_id_29A52FE5C2A8EB57(streakname) {
  hitstokill = level.helperdronesettings[streakname].hitstokill;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](streakname, hitstokill);
}

_id_8648618E4FAC5041(streakname) {
  hitstokill = level.helperdronesettings[streakname].hitstokill;
  weaponname = "emp_grenade_mp";
  weaponhitsperattack = hitstokill;
  _id_8B4500D6A881B7B2 = hitstokill;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);
}

_id_FB7ED8DFABEAED9A(config) {
  if(!isDefined(self.usedcount))
    self.usedcount = 0;

  thread _id_74247AC518A2DF62(config);
}

_id_74247AC518A2DF62(config) {
  self.owner thread scripts\cp_mp\utility\player_utility::watchthermalinputchange(1);
  self.playersfx = spawn("script_origin", self.origin);
  self.playersfx showonlytoplayer(self.owner);
  self.playersfx linkTo(self);
  self.playersfx playLoopSound("recon_drone_overlay");
  self.owner setsoundsubmix("mp_recon_drone", 1);
  self.targetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerenemy", self.owner, undefined, self.owner, 0, 0, 0);
  self.ispiloted = 1;
  self.owner _id_3B64EB40368C1450::_id_3633B947164BE4F3("assaultDrone_use", 0);
  self.owner.restoreangles = self.owner.angles;
  self.owner setplayerangles(self.angles);
  self.owner cameralinkTo(self, "tag_origin", 0, 1);

  if(!isDefined(self.empcount) || isDefined(self.empcount) && self.empcount == 0) {
    self.owner remotecontrolvehicle(self);
    self.owner _id_6DE53543FEE67F02::_id_4F2C4138DACCA16A(1.0, 0.0, 0.015, 0.15);
  }

  self.owner painvisionoff();
  self setscriptablepartstate("ddos", "neutral", 0);
  scripts\cp_mp\emp_debuff::set_start_emp_callback(::_id_7D0712E71E309E60);
  scripts\cp_mp\emp_debuff::set_apply_emp_callback(::_id_35DE57C9587F7F44);
  scripts\cp_mp\emp_debuff::set_clear_emp_callback(::_id_C58F1C9F5FF4F9C5);
  _id_736DEC95A49487A6::_id_172D848D58051FDF(::_id_C3FAC7E77EBBB27B);
  scripts\cp_mp\utility\killstreak_utility::movingplatform_playerlink(self.owner);
  self.owner scripts\cp_mp\killstreaks\helper_drone::_id_89AF506D89AAD6ED(1, self);
  self.owner setclientomnvar("ui_rcd_outer_ring", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "registerEntForOOB"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "registerEntForOOB")]](self, "killstreak");

  if(scripts\cp_mp\emp_debuff::is_empd())
    scripts\cp_mp\killstreaks\helper_drone::_id_FFBC19E1AEF5943C(1);

  thread _id_6D68CFDF0836123C::_id_86E1C4F92C53CCFB(config);
  thread _id_EE8FD2B2321035C0(config);
  thread _id_DA8B343109516850(config);
  self setscriptablepartstate("warning_beep", "on", 0);
  self.owner scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  thread _id_518A6887376E8B13(config);
  return 1;
}

_id_EE8FD2B2321035C0(config) {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.owner endon("disconnect");
  reticlestate = 0;

  for(;;) {
    if(istrue(self._id_12DCE598075360D8) && reticlestate == 0) {
      self.owner setclientomnvar("ui_rcd_outer_ring", 1);
      reticlestate = 1;
    } else if(!istrue(self._id_12DCE598075360D8) && reticlestate == 1) {
      self.owner setclientomnvar("ui_rcd_outer_ring", 0);
      reticlestate = 0;
    }

    waitframe();
  }
}

_id_DA8B343109516850(config) {
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 endon("disconnect");
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  _id_820E590CB5620371 = 0;

  for(;;) {
    targets = self.targetsinouterradius;
    _id_12DCE598075360D8 = 0;

    foreach(player in targets) {
      if(_id_820E590CB5620371 >= 3) {
        _id_820E590CB5620371 = 0;
        waitframe();
      }

      if(!isDefined(player)) {
        continue;
      }
      if(isPlayer(player) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
        if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](player))
          continue;
      }

      _id_820E590CB5620371++;
      scripts\cp_mp\killstreaks\helper_drone::_id_28368A23C20FF3E6(self.targetmarkergroup, player, 1);
      _id_C37B1CC67943336D = scripts\cp_mp\killstreaks\helper_drone::_id_F9C33DF98457A9A2(player);
      _id_CC86ADA7DF8F6C2F = _id_6D68CFDF0836123C::_id_26D9D0C6CA7A5A8C(player);

      if(!istrue(_id_C37B1CC67943336D)) {
        scripts\cp_mp\killstreaks\helper_drone::_id_28368A23C20FF3E6(self.targetmarkergroup, player, 0);
        continue;
      } else if(!istrue(_id_CC86ADA7DF8F6C2F)) {
        continue;
      }
      _id_12DCE598075360D8 = 1;
      scripts\cp_mp\killstreaks\helper_drone::_id_28368A23C20FF3E6(self.targetmarkergroup, player, 2);
    }

    self._id_12DCE598075360D8 = _id_12DCE598075360D8;
    _id_820E590CB5620371 = 0;
    waitframe();
  }
}

_id_91AE4F6ECE59691F() {
  thread _id_87AD014181A233AA();

  if(scripts\cp_mp\emp_debuff::is_empd())
    scripts\cp_mp\killstreaks\helper_drone::_id_FFBC19E1AEF5943C(0);
}

_id_87AD014181A233AA(timeout) {
  thread scripts\cp_mp\killstreaks\helper_drone::_id_06EDFDA4764129E3(0, 1, timeout);
}

_id_F09621755C154350(config, _id_4FAC8B8CE36E09F1, _id_D9B2677826930BF7, _id_28D4A6F776C18B73, _id_BD21744EB1B623FE) {
  if(isDefined(self.empcount) && self.empcount > 0) {
    self.owner scripts\cp_mp\utility\player_utility::_freezelookcontrols(0, 1);
    scripts\cp_mp\killstreaks\helper_drone::_id_FFBC19E1AEF5943C(0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "clearOOB"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "clearOOB")]](self, 1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("assault_drone", "explode"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("assault_drone", "explode")]](self, config, _id_4FAC8B8CE36E09F1, _id_D9B2677826930BF7, _id_28D4A6F776C18B73, _id_BD21744EB1B623FE);

  if(isDefined(self.dangericonent))
    self.dangericonent delete();

  self setscriptablepartstate("warning_beep", "off", 0);
  _id_A4CFBE3F567AF798(self.owner);

  if(istrue(_id_BD21744EB1B623FE) || istrue(_id_D9B2677826930BF7) && istrue(config._id_5C59BDB4308EE080) || istrue(_id_28D4A6F776C18B73) && istrue(config._id_52858F12C0EF4C03) || istrue(_id_4FAC8B8CE36E09F1) && istrue(config._id_DD47AEDE4AD7E18A)) {
    scripts\cp_mp\killstreaks\helper_drone::_id_9FE87B841A44448F();
    thread _id_1E7E724AA1C163AB();
  } else
    scripts\cp_mp\killstreaks\helper_drone::_id_24085A0230958938();
}

_id_A4CFBE3F567AF798(player) {
  if(!isDefined(player)) {
    return;
  }
  self setentityowner(player);
  self clearscriptabledamageowner();
  _id_7C344645CC98E70D = self.helperdronetype;
  config = level.helperdronesettings[_id_7C344645CC98E70D];
  self.ispiloted = 0;

  if(isDefined(player.super))
    player.super.isactive = 0;

  if(isDefined(self.playersfx))
    self.playersfx delete();

  if(isDefined(self.enemiesmarked)) {
    foreach(_id_161E86C260D6864C in self.enemiesmarked)
    _id_6D68CFDF0836123C::_id_F1D272B5FC3A575C(_id_161E86C260D6864C, player);
  }

  _id_A57879325A8E0669 = "ks_remote_drone_mp";

  if(istrue(self._id_EEE5DDAAFC619FA3))
    _id_A57879325A8E0669 = "ks_remote_device_mp";

  player thread _id_6D68CFDF0836123C::recondrone_takedeployweapon(1, _id_A57879325A8E0669);
  player scripts\cp_mp\killstreaks\helper_drone::helperdrone_takeplayerfauxremote(self.streakinfo);
  player painvisionon();
  player scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("");

  if(istrue(self.isthermalenabled))
    player scripts\cp_mp\utility\player_utility::setthermalvision(0);

  player scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "assaultDrone");
  player scripts\cp_mp\utility\player_utility::_freezelookcontrols(0, 1);
  player _id_3B64EB40368C1450::_id_588F2307A3040610("assaultDrone_switch");
  player _id_3B64EB40368C1450::_id_588F2307A3040610("assaultDrone_deploy");
  player _id_3B64EB40368C1450::_id_588F2307A3040610("assaultDrone_use");
  player thread scripts\cp_mp\killstreaks\helper_drone::_id_F23D90F7483D67E4();
  player cameraunlink();

  if(!istrue(self._id_D31453E33D3E34CA))
    player remotecontrolvehicleoff();

  player _id_6DE53543FEE67F02::_id_E2EAE50826E12247();
  scripts\cp_mp\utility\killstreak_utility::movingplatform_playerunlink(player);
  player setplayerangles((player.restoreangles[0], player.restoreangles[1], 0));
  player.restoreangles = undefined;
  player scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
}

_id_413DF2DE080E3CC1(config) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self.owner endon("disconnect");
  self.owner notifyonplayercommand("drone_camera_switch", "+melee_zoom");

  for(;;) {
    self.owner waittill("drone_camera_switch");
    _id_1C3E9C203EA72971 = 0;

    if(!istrue(_id_1C3E9C203EA72971)) {
      continue;
    }
    if(self._id_D0D1AF898ACDC9AF == "default") {
      self.owner scripts\cp_mp\utility\player_utility::_freezelookcontrols(1);
      _id_521E734765A10CA9(2, "under", "tag_undercam");
      thread _id_080269A0D716399F(config);
      continue;
    }

    self.owner scripts\cp_mp\utility\player_utility::_freezelookcontrols(0, 1);
    _id_521E734765A10CA9(1, "default", "tag_origin");
    thread _id_518A6887376E8B13(config);
  }
}

_id_080269A0D716399F(config) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("detonate_bomb");
  self.owner endon("disconnect");
  self notify("release_bomb");
  self.owner notifyonplayercommand("drone_release_bomb", "+attack");
  self.owner waittill("drone_release_bomb");
  childthread _id_6756B4A82C91CE02();
}

_id_1E7E724AA1C163AB() {
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

  if(!isDefined(_id_6D5A295AE3C46554._id_05431D89A36B0936))
    _id_6D5A295AE3C46554._id_05431D89A36B0936 = 0;

  if(_id_6D5A295AE3C46554.recentkillcount >= 1 || _id_6D5A295AE3C46554._id_05431D89A36B0936 >= 1)
    _id_6D5A295AE3C46554 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("assault_drone", "assault_drone_hit_target", 1);
  else
    _id_6D5A295AE3C46554 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("assault_drone", "assault_drone_miss_target", 1);
}

_id_518A6887376E8B13(config) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("release_bomb");
  self.owner endon("disconnect");
  self notify("detonate_bomb");

  for(;;) {
    self.owner notifyonplayercommand("drone_detonate", "+attack");
    self.owner waittill("drone_detonate");

    if(scripts\cp_mp\emp_debuff::is_empd())
      continue;
    else
      thread scripts\cp_mp\killstreaks\helper_drone::_id_06EDFDA4764129E3(0, 0, 0, 1);

    waitframe();
  }
}

_id_521E734765A10CA9(_id_2B9318495421E36F, _id_D0D1AF898ACDC9AF, _id_1EDD840D40B43222) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self.owner endon("disconnect");
  self.owner cameraunlink();
  self.owner scripts\cp_mp\killstreaks\helper_drone::_id_89AF506D89AAD6ED(0);
  waitframe();
  self.owner cameralinkTo(self, _id_1EDD840D40B43222, 0, 1);
  self.owner scripts\cp_mp\killstreaks\helper_drone::_id_89AF506D89AAD6ED(_id_2B9318495421E36F, self);
  self._id_D0D1AF898ACDC9AF = _id_D0D1AF898ACDC9AF;
}

_id_6756B4A82C91CE02() {
  _id_60FD2AF6CAF85A21 = vectorNormalize(self.origin - (0, 0, 5) - self.origin);
  _id_9EA4FAF9F08CB80D = self.origin + _id_60FD2AF6CAF85A21 * 10;
  _id_CC7D1FABF80C7DF5 = _id_9EA4FAF9F08CB80D + _id_60FD2AF6CAF85A21 * 100;
  _id_7331D469160F6A41 = _id_CC7D1FABF80C7DF5 - _id_9EA4FAF9F08CB80D;
  projectile = magicgrenademanual("assault_drone_mp", _id_9EA4FAF9F08CB80D, _id_7331D469160F6A41, 99, self.owner);
  projectile.streakinfo = self.streakinfo;
  wait 2;
  thread _id_87AD014181A233AA();
}

_id_C3FAC7E77EBBB27B(data) {
  if(!isDefined(self.owner)) {
    return;
  }
  if(isDefined(data.attacker) && isDefined(data.inflictor) && self.currenthealth > 0)
    self dodamage(self.maxhealth, self.origin, data.attacker, data.inflictor);
}

_id_7D0712E71E309E60(data) {
  self setscriptablepartstate("ddos", "disabled", 0);
  self setscriptablepartstate("warning_beep", "off", 0);

  if(!isDefined(self.owner)) {
    return;
  }
  if(isDefined(data.attacker)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
      data.attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("disabled_bomb_drone");
  }

  if(istrue(self.ispiloted))
    scripts\cp_mp\killstreaks\helper_drone::_id_FFBC19E1AEF5943C(1);
}

_id_35DE57C9587F7F44(data) {
  if(!isDefined(self.owner)) {
    return;
  }
  if(isDefined(data.attacker)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
      data.attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("disabled_bomb_drone");
  }
}

_id_C58F1C9F5FF4F9C5(_id_B3990D56E2779F79) {
  self setscriptablepartstate("ddos", "neutral", 0);
  self setscriptablepartstate("warning_beep", "on", 0);

  if(!isDefined(self.owner)) {
    return;
  }
  if(istrue(self.ispiloted))
    scripts\cp_mp\killstreaks\helper_drone::_id_FFBC19E1AEF5943C(0);
}

_id_571F1E65C43FB585(inflictor, victim, _id_24DF708F286B0562) {
  if(!isDefined(inflictor) || !isDefined(victim))
    return _id_24DF708F286B0562;

  _id_59F806A0AB5D37FC = victim _id_07C40FA80892A721::_id_9BCA5C1D23A3E0B3();

  if(istrue(_id_59F806A0AB5D37FC)) {
    _id_5A76B167B0298C0D = scripts\common\utility::playersnear(inflictor.origin, 100);
    _id_72601FE316A42077 = 0;

    foreach(_id_BD73C7ACC56CD20C in _id_5A76B167B0298C0D) {
      if(_id_BD73C7ACC56CD20C != victim) {
        continue;
      }
      _id_72601FE316A42077 = 1;
      break;
    }

    if(!istrue(_id_72601FE316A42077)) {
      _id_24DF708F286B0562 = victim _id_07C40FA80892A721::_id_AC266FC218266D08() + victim.health - 1;

      if(isDefined(inflictor.owner)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent")) {
          if(isDefined(victim._id_04045F099F3DA4BD) && victim._id_04045F099F3DA4BD == "brloot_plate_carrier_tempered")
            inflictor.owner thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("stat_4CAA4F3C52EAA383");
          else
            inflictor.owner thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("stat_676AA7832878D5EF");
        }
      }
    }
  }

  return _id_24DF708F286B0562;
}