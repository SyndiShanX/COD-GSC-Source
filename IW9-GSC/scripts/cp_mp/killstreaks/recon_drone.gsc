/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\recon_drone.gsc
*****************************************************/

init() {
  _id_BC37093624170142();
  _id_23F0D567614A93F0();
  _id_202017C74349F68C();
  _id_9283D83A13859206();
  _id_1BC16FFBB7C1131E();
}

_id_BC37093624170142() {
  level.helperdronesettings["radar_drone_recon"] = spawnStruct();
  level.helperdronesettings["radar_drone_recon"]._id_8316E01BE4051639 = getdvarint("dvar_0B82BD719C6E7913", 0);
  level.helperdronesettings["radar_drone_recon"].timeout = 45.0;
  level.helperdronesettings["radar_drone_recon"].maxhealth = 30;
  level.helperdronesettings["radar_drone_recon"].hitstokill = 1;
  level.helperdronesettings["radar_drone_recon"].speed = 140;
  level.helperdronesettings["radar_drone_recon"].accel = 20;
  level.helperdronesettings["radar_drone_recon"].halfsize = 27;
  level.helperdronesettings["radar_drone_recon"].spawndist = 30;
  level.helperdronesettings["radar_drone_recon"].streakname = "radar_drone_recon";
  level.helperdronesettings["radar_drone_recon"].vehicleinfo = "veh_radar_drone_recon_mp";
  level.helperdronesettings["radar_drone_recon"].modelbase = "veh9_mil_air_drone_recon_large_mp";
  level.helperdronesettings["radar_drone_recon"].teamsplash = "used_radar_drone_recon";
  level.helperdronesettings["radar_drone_recon"].destroyedsplash = "callout_destroyed_radar_drone_recon";
  level.helperdronesettings["radar_drone_recon"].scorepopup = "destroyed_radar_drone_recon";
  level.helperdronesettings["radar_drone_recon"].primarymode = "MANUAL";
  level.helperdronesettings["radar_drone_recon"].primarymodestring = &"KILLSTREAKS_HINTS/RCD_MANUAL";
  level.helperdronesettings["radar_drone_recon"].primarymodefunc = ::_id_09DFCA5C7AC12FC2;
  level.helperdronesettings["radar_drone_recon"].premoddamagefunc = undefined;
  level.helperdronesettings["radar_drone_recon"].postmoddamagefunc = scripts\cp_mp\killstreaks\helper_drone::_id_CAF721CB23374E2B;
  level.helperdronesettings["radar_drone_recon"]._id_1C606430B81B28FF = ::_id_AB931B44A2EFDDF7;
  level.helperdronesettings["radar_drone_recon"]._id_BE3314F77FEF5D6B = ::_id_1E3C638E5B7031E7;
  level.helperdronesettings["radar_drone_recon"]._id_63A39D0CEA63CBB2 = ::_id_76293A71A35B8692;
  level.helperdronesettings["radar_drone_recon"]._id_5D9D3E47B1B88B84 = ::_id_0DCC861687CC9E38;
  level.helperdronesettings["radar_drone_recon"]._id_9C6EFC85B74204CC = ::_id_8321764DA9DEAD70;
  level.helperdronesettings["radar_drone_recon"].deathfunc = scripts\cp_mp\killstreaks\helper_drone::_id_BA1C5496F8FC5F67;
  level.helperdronesettings["radar_drone_recon"].playfxcallback = scripts\cp_mp\killstreaks\helper_drone::_id_56966B077270A18E;
  level.helperdronesettings["radar_drone_recon"]._id_0C25A8137257A96D = ::_id_B576092FD50996BF;
  level.helperdronesettings["radar_drone_recon"]._id_191284E2E2837328 = ::_id_CBD53BEAD95F8409;
  level.helperdronesettings["radar_drone_recon"]._id_6A390682C21BC49E = 1;
  level.helperdronesettings["radar_drone_recon"]._id_1947A47C2174D02C = 1;
  level.helperdronesettings["radar_drone_recon"]._id_CB2C3FE0819193EB = 3062500;
  level.helperdronesettings["radar_drone_recon"]._id_D5EA718ABFC8FF5B = 6250000;
  level.helperdronesettings["radar_drone_recon"]._id_A117852275E49E64 = "recon_drone_color_mp";
  level.helperdronesettings["radar_drone_recon"]._id_2215FA459D8250C0 = "recon_drone_color_dark_mp";
  level.helperdronesettings["radar_drone_recon"]._id_52C3B4BC88132AEE = 1;
  level.helperdronesettings["radar_drone_recon"]._id_5C6A7212BF9FCBEA = 1;
}

_id_23F0D567614A93F0() {
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("reconDrone_switch", ["allow_movement", "allow_jump", "supers", "killstreaks", "vehicle_use", "offhand_weapons"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("reconDrone_deploy", ["usability", "melee", "offhand_weapons", "weapon_switch", "vehicle_use"]);
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("reconDrone_use", ["fire", "shellshock", "melee", "vehicle_use"]);
}

_id_202017C74349F68C() {
  game["dialog"]["radar_drone_recon_teamleader_friendly_inbound"] = "fieldupgrade_team_leader_ally_callout";
  game["dialog"]["radar_drone_recon_teamleader_enemy_inbound"] = "fieldupgrade_team_leader_enemy_callout";
  game["dialog"]["radar_drone_recon_timeout"] = "fieldupgrade_team_leader_timeout";
  game["dialog"]["radar_drone_recon_destroyed"] = "fieldupgrade_team_leader_crash";
}

_id_9283D83A13859206() {}

_id_1BC16FFBB7C1131E() {
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("recon_drone_color_mp");
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("recon_drone_color_dark_mp");
}

_id_57FD8A7006975CD6() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("radar_drone_recon", self);
  return _id_AB931B44A2EFDDF7(streakinfo);
}

_id_AB931B44A2EFDDF7(streakinfo) {
  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle())
    return 0;

  deployweaponobj = makeweapon("ks_remote_drone_mp");
  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, deployweaponobj, 1, scripts\cp_mp\killstreaks\helper_drone::weapongivenhelperdrone);

  if(!istrue(_id_9B1DEB5E9D32BBE3)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  helperdronetype = streakinfo.streakname;
  _id_FC4AA9DB408D9420 = 0.6;
  _id_E5C7FFB094DC9EEC = 2;
  result = scripts\engine\utility::waittill_any_timeout_2(_id_FC4AA9DB408D9420, "death", "weapon_switch_started");

  if(!isDefined(result) || result != "timeout") {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  result = scripts\engine\utility::waittill_any_timeout_1(_id_E5C7FFB094DC9EEC - _id_FC4AA9DB408D9420, "death");

  if(!isDefined(result) || result != "timeout") {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  startpos = scripts\cp_mp\killstreaks\helper_drone::_id_34280B807C23A453(helperdronetype);
  startangles = self.angles;
  _id_9551DC58F953D062 = _id_D8B72BA55B4292CF(startpos, startangles, helperdronetype, streakinfo);

  if(!isDefined(_id_9551DC58F953D062))
    return 0;

  thread scripts\cp_mp\killstreaks\helper_drone::helperdrone_giveplayerfauxremote(streakinfo);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakUse"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakUse")]]("recon_drone");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]()) {
      _id_9551DC58F953D062 vehicleshowonminimap(0);
      scripts\cp_mp\utility\killstreak_utility::playkillstreakusedialog(helperdronetype);
      _id_9551DC58F953D062 scripts\cp_mp\killstreaks\helper_drone::helperdrone_notifyenemyplayersinrange(helperdronetype);
    }
  }

  scripts\cp_mp\killstreaks\helper_drone::_id_C3786C4FBA09C2F2(streakinfo);
  thread scripts\cp_mp\killstreaks\helper_drone::starthelperdrone(_id_9551DC58F953D062);
  return 1;
}

_id_D8B72BA55B4292CF(startpos, startang, helperdronetype, streakinfo) {
  _id_9551DC58F953D062 = scripts\cp_mp\killstreaks\helper_drone::createhelperdrone(startpos, startang, helperdronetype, streakinfo, 0, 1);

  if(!isDefined(_id_9551DC58F953D062)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");

    scripts\cp_mp\killstreaks\helper_drone::helperdronecreationfailedfx(helperdronetype, startpos);
    streakinfo notify("killstreak_finished_with_deploy_weapon");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();

    scripts\cp_mp\killstreaks\helper_drone::_id_C3786C4FBA09C2F2(streakinfo);
    return undefined;
  }

  return _id_9551DC58F953D062;
}

_id_B576092FD50996BF(streakname) {
  hitstokill = level.helperdronesettings[streakname].hitstokill;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](streakname, hitstokill);
}

_id_CBD53BEAD95F8409(streakname) {
  hitstokill = level.helperdronesettings[streakname].hitstokill;
  weaponname = "emp_grenade_mp";
  weaponhitsperattack = hitstokill;
  _id_8B4500D6A881B7B2 = hitstokill;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);
}

_id_09DFCA5C7AC12FC2(config) {
  self._id_8316E01BE4051639 = config._id_8316E01BE4051639;

  if(!isDefined(self.enemiesmarked))
    self.enemiesmarked = [];

  if(!isDefined(self.usedcount))
    self.usedcount = 0;

  thread _id_622C97B11177264A(config);
}

_id_622C97B11177264A(config) {
  self.owner notify("droneStart");
  self.owner thread scripts\cp_mp\utility\player_utility::watchthermalinputchange(1);
  self.targetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerenemy", self.owner, undefined, self.owner, 0, 0, 0);
  self.playersfx = spawn("script_origin", self.origin);
  self.playersfx showonlytoplayer(self.owner);
  self.playersfx linkTo(self);
  self.playersfx playLoopSound("recon_drone_overlay");
  self.owner setsoundsubmix("mp_recon_drone", 1);
  self.ispiloted = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "setSuperIsActive"))
    self.owner thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "setSuperIsActive")]](1);

  self.owner _id_3B64EB40368C1450::_id_3633B947164BE4F3("reconDrone_use", 0);
  self.owner scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "reconDrone");
  self.owner scripts\cp_mp\utility\player_utility::_freezelookcontrols(0, 1);
  _id_306044DC14A537A2 = 0;
  self.owner.restoreangles = self.owner.angles;
  self.owner setplayerangles(self.angles);
  self.owner cameralinkTo(self, "tag_origin");
  self.owner remotecontrolvehicle(self);
  self.owner _id_6DE53543FEE67F02::_id_4F2C4138DACCA16A(1.0, 0.0, 0.015, 0.15);
  self.owner setclientomnvar("ui_killstreak_health", self.currenthealth / self.maxhealth);

  if(scripts\cp_mp\emp_debuff::is_empd())
    scripts\cp_mp\killstreaks\helper_drone::_id_FFBC19E1AEF5943C(1);

  self.owner painvisionoff();
  self.owner scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  self setscriptablepartstate("ddos", "neutral", 0);
  scripts\cp_mp\emp_debuff::set_start_emp_callback(::_id_31B413D9B6ABE7F8);
  scripts\cp_mp\emp_debuff::set_apply_emp_callback(::_id_41F3461C40E5A87C);
  scripts\cp_mp\emp_debuff::set_clear_emp_callback(::_id_6A90D81D42854ECD);
  _id_736DEC95A49487A6::_id_172D848D58051FDF(::_id_85F0FD88983D1893);
  scripts\cp_mp\utility\killstreak_utility::movingplatform_playerlink(self.owner);

  if(!istrue(_id_306044DC14A537A2)) {
    if(0)
      scripts\cp_mp\outofrange::setupoutofrangewatcher(self, undefined, self.owner, undefined, 2250000, 9000000);

    self.owner scripts\cp_mp\killstreaks\helper_drone::_id_89AF506D89AAD6ED(1, self);
    self.owner setclientomnvar("ui_rcd_outer_ring", 0);
    thread _id_DFC402EF72EFF688(config);
    thread _id_7730B66241EF6E46(config);
    thread _id_86E1C4F92C53CCFB(config);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "mark_players"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "mark_players")]](config);
    else
      thread _id_85B4E9E74B613D68(config);

    thread _id_435B4DC89B40E60A(config);
    thread _id_148A87125A1ECE3E();
  }

  return 1;
}

_id_439E22CA27F68CE3() {
  if(!isDefined(self.recondronesuper))
    return 0;
  else {
    drone = self.recondronesuper;

    if(!istrue(drone._id_8316E01BE4051639))
      return 0;

    if(!isnullweapon(self getheldoffhand()))
      return 0;

    if(!self isonground()) {
      if(scripts\cp_mp\utility\player_utility::_id_988138367C74B1F5())
        return 0;

      if(!scripts\cp_mp\utility\player_utility::_id_D474B372046544B0())
        return 0;
    }

    if(scripts\cp_mp\utility\player_utility::isinvehicle(1))
      return 0;

    _id_19163E14365D9264 = self.super;

    if(!isDefined(_id_19163E14365D9264))
      return 0;

    if(isDefined(_id_19163E14365D9264) && istrue(_id_19163E14365D9264.usepercent < 0.05))
      return 0;

    drone._id_EEE5DDAAFC619FA3 = 1;
    drone notify("regain_control");
    scripts\cp_mp\utility\player_utility::_freezelookcontrols(1);
    config = level.helperdronesettings[drone.helperdronetype];
    result = recondrone_givedeployweapon("ks_remote_device_mp", drone);
    thread scripts\cp_mp\killstreaks\helper_drone::helperdrone_giveplayerfauxremote(drone.streakinfo);

    if(!istrue(result)) {
      scripts\cp_mp\utility\player_utility::_freezelookcontrols(0, 1);
      _id_3B64EB40368C1450::_id_588F2307A3040610("reconDrone_switch");
      thread recondrone_takedeployweapon(1, "ks_remote_device_mp");

      if(istrue(scripts\cp_mp\utility\player_utility::isusingremote()))
        thread scripts\cp_mp\killstreaks\helper_drone::helperdrone_takeplayerfauxremote(drone.streakinfo);

      return 0;
    }

    drone scripts\cp_mp\utility\killstreak_utility::_id_A91EBB0263D086F3();
    drone _id_622C97B11177264A(config);
    scripts\cp_mp\killstreaks\helper_drone::_id_6A275656141AC8D6(drone);

    if(istrue(drone.isthermalenabled))
      scripts\cp_mp\utility\player_utility::setthermalvision(1, 12, 1000);
  }

  return 1;
}

_id_148A87125A1ECE3E() {
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 endon("disconnect");
  self endon("death");
  self endon("explode");
  self endon("switch_modes");
  _id_C401F442D80D23B6 = getdvarint("dvar_B432CE13C8A2CAC9", 0);

  if(_id_C401F442D80D23B6) {
    _id_6D5A295AE3C46554 notifyonplayercommand("recon_smoke_launch", "+attack");
    _id_6D5A295AE3C46554 setclientomnvar("ui_killstreak_weapon_1_ammo", 3);
    _id_0693832DA25C1999 = 3;

    while(_id_0693832DA25C1999 > 0) {
      _id_6D5A295AE3C46554 waittill("recon_smoke_launch");

      if(!self.ispiloted) {
        continue;
      }
      _id_51C1B45046E1647C = self.origin + anglesToForward(self.angles) * 50;
      _id_CC7D1FABF80C7DF5 = scripts\cp_mp\killstreaks\gunship::_id_CDF6E1BDFE5B42B5(_id_6D5A295AE3C46554);
      _id_7331D469160F6A41 = _id_CC7D1FABF80C7DF5 - _id_51C1B45046E1647C;
      magicgrenademanual("smoke_grenade_stick_mp", _id_51C1B45046E1647C, _id_7331D469160F6A41, 2);
      _id_0693832DA25C1999--;
      _id_6D5A295AE3C46554 setclientomnvar("ui_killstreak_weapon_1_ammo", _id_0693832DA25C1999);
    }
  } else
    _id_6D5A295AE3C46554 setclientomnvar("ui_killstreak_weapon_1_ammo", 0);
}

_id_85B4E9E74B613D68(config) {
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 endon("disconnect");
  self endon("death");
  self endon("explode");
  self endon("switch_modes");
  _id_820E590CB5620371 = 0;
  self.markingtarget = undefined;

  for(;;) {
    if(isDefined(self.targetmarkergroup)) {
      self.targethascoldblooded = 0;
      self.targetisnotinmarkingrange = 0;
      self.anyoneisinmarkingrange = 0;
      targets = self.targetsinouterradius;

      foreach(player in targets) {
        if(_id_820E590CB5620371 >= 3) {
          _id_820E590CB5620371 = 0;
          waitframe();
        }

        if(scripts\cp_mp\emp_debuff::is_empd()) {
          continue;
        }
        if(isPlayer(player) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
          if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](player))
            continue;
        }

        if(isagent(player)) {
          if(!isalive(player)) {
            continue;
          }
          if(isDefined(player.agent_type) && issubstr(player.agent_type, "civilian")) {
            scripts\cp_mp\killstreaks\helper_drone::_id_28368A23C20FF3E6(self.targetmarkergroup, player, 3);
            continue;
          }
        }

        if(!isDefined(player)) {
          continue;
        }
        if(_id_119A97BFB70A99D6(player)) {
          continue;
        }
        if(_id_5E38C3C0AE63E8AF(player)) {
          continue;
        }
        _id_820E590CB5620371++;
        scripts\cp_mp\killstreaks\helper_drone::_id_28368A23C20FF3E6(self.targetmarkergroup, player, 1);
        _id_C37B1CC67943336D = scripts\cp_mp\killstreaks\helper_drone::_id_F9C33DF98457A9A2(player);
        _id_20AA5B4097887CB6 = _id_6D5A295AE3C46554 _id_CCCBD62549B4440B(player, 70, 50);
        _id_CC86ADA7DF8F6C2F = _id_26D9D0C6CA7A5A8C(player);
        _id_177716BEC3407A6A = 0;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
          if(isPlayer(player) && player[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline"))
            _id_177716BEC3407A6A = 1;
        }

        if(_id_20AA5B4097887CB6 && _id_177716BEC3407A6A)
          self.targethascoldblooded = 1;

        if(_id_20AA5B4097887CB6 && !_id_CC86ADA7DF8F6C2F)
          self.targetisnotinmarkingrange = 1;

        if(_id_CC86ADA7DF8F6C2F)
          self.anyoneisinmarkingrange = 1;

        if(_id_177716BEC3407A6A) {
          scripts\cp_mp\killstreaks\helper_drone::_id_28368A23C20FF3E6(self.targetmarkergroup, player, 3);
          continue;
        }

        if((!_id_CC86ADA7DF8F6C2F || !_id_C37B1CC67943336D) && self.ispiloted) {
          scripts\cp_mp\killstreaks\helper_drone::_id_28368A23C20FF3E6(self.targetmarkergroup, player, 0);

          if(self._id_8316E01BE4051639)
            player thread _id_772EDE0CCE4020EC(self);

          continue;
        }

        if(!_id_20AA5B4097887CB6) {
          continue;
        }
        if(istrue(self.markingtarget)) {
          continue;
        }
        thread _id_2FD033DED40B93A9(player, "enemy");
      }
    }

    _id_820E590CB5620371 = 0;
    waitframe();
  }
}

_id_DFC402EF72EFF688(config) {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.owner endon("disconnect");
  reticlestate = 0;

  for(;;) {
    if(istrue(self.markingtarget) && reticlestate == 0) {
      self.owner setclientomnvar("ui_rcd_outer_ring", 1);
      reticlestate = 1;
    } else if(!istrue(self.markingtarget) && reticlestate == 1) {
      self.owner setclientomnvar("ui_rcd_outer_ring", 0);
      reticlestate = 0;
    }

    waitframe();
  }
}

_id_7730B66241EF6E46(config) {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.owner endon("disconnect");

  for(;;) {
    if(istrue(self.targethascoldblooded))
      self.owner setclientomnvar("ui_rcd_notification", 3);
    else if(istrue(self.targetisnotinmarkingrange))
      self.owner setclientomnvar("ui_rcd_notification", 1);
    else if(!istrue(self.anyoneisinmarkingrange))
      self.owner setclientomnvar("ui_rcd_notification", 2);
    else
      self.owner setclientomnvar("ui_rcd_notification", 0);

    waitframe();
  }
}

_id_86E1C4F92C53CCFB(config) {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  self.owner endon("disconnect");
  self.targetsinouterradius = [];

  for(;;) {
    if(!isDefined(self) || !isDefined(self.owner)) {
      return;
    }
    targetarray = _id_7D0DB4B7F46E7DC0();

    if(isDefined(level.additionalrecondronetargets)) {
      _id_ED5DEADF98F2B1BD = [];

      foreach(target in level.additionalrecondronetargets) {
        if(isDefined(target.datakey)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "gameFlag")) {
            if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "gameFlag")]]("prematch_done")) {
              if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isPlayerOnIntelChallenge")) {
                if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isPlayerOnIntelChallenge")]](self.owner, target.datakey))
                  _id_ED5DEADF98F2B1BD[_id_ED5DEADF98F2B1BD.size] = target;
              }
            }
          }

          continue;
        }

        _id_ED5DEADF98F2B1BD[_id_ED5DEADF98F2B1BD.size] = target;
      }

      _id_D3A3374BBD2C0EC7 = scripts\engine\utility::array_combine(targetarray, _id_ED5DEADF98F2B1BD);
    } else
      _id_D3A3374BBD2C0EC7 = targetarray;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "get_outer_reticle_targets"))
      _id_D3A3374BBD2C0EC7 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "get_outer_reticle_targets")]](config);

    foreach(ent in _id_D3A3374BBD2C0EC7) {
      if(!_id_2F23CBE83E1E57DF(ent)) {
        continue;
      }
      thread _id_7B0782113E604198(ent);
    }

    waitframe();
  }
}

_id_7B0782113E604198(target) {
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self endon("switch_modes");

  if(!isDefined(self.targetmarkergroup)) {
    return;
  }
  self.targetsinouterradius[self.targetsinouterradius.size] = target;
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(target, self.targetmarkergroup, 0);

  while(isDefined(target)) {
    if(isPlayer(target) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
      if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](target)) {
        break;
      }
    }

    if(isagent(target) && !isalive(target)) {
      break;
    }

    config = level.helperdronesettings[self.helperdronetype];

    if(istrue(config._id_1947A47C2174D02C) && !self.owner _id_CCCBD62549B4440B(target, 70, 300)) {
      break;
    }

    if(!_id_C26586725702EC8C(target)) {
      break;
    }

    if(!scripts\cp_mp\targetmarkergroups::_id_7C253E3D43E44097(target, self.targetmarkergroup)) {
      break;
    }

    waitframe();
  }

  if(isDefined(target)) {
    if(scripts\cp_mp\targetmarkergroups::targetmarkergroupexists(self.targetmarkergroup) && scripts\cp_mp\targetmarkergroups::_id_7C253E3D43E44097(target, self.targetmarkergroup) && !_id_5E38C3C0AE63E8AF(target))
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(target, self.targetmarkergroup);

    if(scripts\engine\utility::array_contains(self.targetsinouterradius, target))
      self.targetsinouterradius = scripts\engine\utility::array_remove(self.targetsinouterradius, target);
  } else
    self.targetsinouterradius = scripts\engine\utility::array_removeundefined(self.targetsinouterradius);
}

_id_435B4DC89B40E60A(config) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("regain_control");
  self.owner endon("disconnect");
  self waittill("switch_modes");
  _id_911A7F17FBAE1435 = self.origin;
  _id_55454AF7F74C5D8C = self.origin - (0, 0, 10000);
  contentoverride = scripts\engine\trace::create_world_contents();
  _id_0DB1541018D7BADF = scripts\engine\trace::ray_trace(_id_911A7F17FBAE1435, _id_55454AF7F74C5D8C, self, contentoverride);
  _id_48801B6206AA945E = _id_55454AF7F74C5D8C;

  if(isDefined(_id_0DB1541018D7BADF["hittype"]) && _id_0DB1541018D7BADF["hittype"] != "hittype_none")
    _id_48801B6206AA945E = _id_0DB1541018D7BADF["position"];

  _id_AD4B9279D500326A = 1750;
  _id_4A2788C9D6C42027 = self.origin[2] - _id_48801B6206AA945E[2];

  for(;;) {
    _id_213FDD3689D4B33E = [self.owner];

    if(level.teambased)
      _id_213FDD3689D4B33E = scripts\engine\utility::array_combine(_id_213FDD3689D4B33E, level.teamdata[self.team]["players"]);

    _id_12729FF62E52ED4D = scripts\common\utility::playersincylinder(_id_48801B6206AA945E, _id_AD4B9279D500326A, _id_213FDD3689D4B33E, _id_4A2788C9D6C42027);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "get_outer_reticle_targets"))
      _id_12729FF62E52ED4D = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "get_outer_reticle_targets")]](config);

    _id_7705A9232CD649A6 = 0;

    foreach(target in _id_12729FF62E52ED4D) {
      if(_id_80226370B4C80B06(target)) {
        _id_2FD033DED40B93A9(target, "enemy", 1);
        _id_7705A9232CD649A6 = 1;
        break;
      }
    }

    if(istrue(_id_7705A9232CD649A6)) {
      wait 3.0;
      continue;
    }

    wait 0.5;
  }
}

_id_772EDE0CCE4020EC(drone) {
  drone.owner endon("disconnect");
  level endon("game_ended");
  drone endon("death");
  drone endon("explode");
  drone endon("switch_modes");
  self notify("monitorUnmarking");
  self endon("monitorUnmarking");

  if(!isDefined(drone.targetmarkergroup)) {
    return;
  }
  while(drone.ispiloted)
    waitframe();

  for(;;) {
    if(isPlayer(self) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
      if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](self)) {
        break;
      }
    }

    if(!drone scripts\cp_mp\killstreaks\helper_drone::_id_F9C33DF98457A9A2(self, 1) || !drone _id_26D9D0C6CA7A5A8C(self)) {
      break;
    }

    waitframe();
  }

  scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(self, drone.targetmarkergroup);
}

_id_2FD033DED40B93A9(target, _id_39E02A8A79B6BA4C, _id_CD4E10C225A826D0) {
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self endon("switch_modes");
  _id_161E86C260D6864C = spawnStruct();
  _id_161E86C260D6864C.target = target;
  _id_161E86C260D6864C.targetnum = target getentitynumber();
  _id_161E86C260D6864C.markingent = self;
  _id_161E86C260D6864C.owner = _id_6D5A295AE3C46554;
  _id_161E86C260D6864C.ownerteam = _id_6D5A295AE3C46554.team;
  _id_161E86C260D6864C.outlineid = undefined;
  _id_161E86C260D6864C.headicon = undefined;
  _id_161E86C260D6864C.beingmarked = undefined;
  _id_161E86C260D6864C.reconmarked = undefined;
  _id_161E86C260D6864C.notifytoendmark = "unmarked_" + _id_161E86C260D6864C.targetnum;

  if(!isDefined(_id_161E86C260D6864C.targetnum)) {
    return;
  }
  if(!isDefined(self.targetmarkergroup) && !istrue(_id_CD4E10C225A826D0)) {
    return;
  }
  _id_161E86C260D6864C.beingmarked = 1;
  self.markingtarget = 1;
  self.owner notify("marking_target");
  _id_2095B8A1AFAAF65E = _id_DC5A1EA5EEF68F83();
  self.owner playlocalsound("recon_drone_marking_owner");
  self setscriptablepartstate("target_glint", "on");

  if(istrue(_id_CD4E10C225A826D0))
    self setlookatent(target);

  while(_id_2095B8A1AFAAF65E > 0) {
    if(!isDefined(target)) {
      return;
    }
    isstillvalidtarget = scripts\cp_mp\utility\player_utility::isreallyalive(target) && (istrue(_id_CD4E10C225A826D0) && (scripts\cp_mp\killstreaks\helper_drone::_id_F9C33DF98457A9A2(target, 1) && _id_26D9D0C6CA7A5A8C(target)) || _id_6D5A295AE3C46554 _id_CCCBD62549B4440B(target, 70, 50));

    if(!isstillvalidtarget) {
      _id_161E86C260D6864C.beingmarked = undefined;
      self.markingtarget = undefined;
      self.owner stoplocalsound("recon_drone_marking_owner");
      self setscriptablepartstate("target_glint", "off");
      self clearlookatent();
      return;
    }

    _id_2095B8A1AFAAF65E = _id_2095B8A1AFAAF65E - 0.05;
    wait 0.05;
  }

  if(isDefined(target.recondronemarkedcb))
    [[target.recondronemarkedcb]](_id_6D5A295AE3C46554, target);

  self clearlookatent();
  self setscriptablepartstate("target_glint", "off");
  thread _id_46E2D014D3DBF29B();
  _id_161E86C260D6864C.reconmarked = 1;
  self.markingtarget = undefined;
  _id_1BE8CC141C0B49CF(_id_161E86C260D6864C, undefined);
  self.owner playlocalsound("recon_drone_marked_owner");
  self.owner stoplocalsound("recon_drone_marking_owner");
  _func_C3FAFA01F5D05D23(1, _id_161E86C260D6864C.targetnum, _id_161E86C260D6864C.ownerteam, 1);

  if(!istrue(_id_CD4E10C225A826D0))
    scripts\cp_mp\killstreaks\helper_drone::_id_28368A23C20FF3E6(self.targetmarkergroup, target, 2);

  _id_4F43ED745364F234(target, _id_39E02A8A79B6BA4C);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pers", "incPersStat"))
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("pers", "incPersStat")]]("reconDroneMarks", 1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "combatRecordSuperMisc"))
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "combatRecordSuperMisc")]]("super_recon_drone");

  self.usedcount++;
  timeout = 5.0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "customMarkDuration"))
    timeout = [[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "customMarkDuration")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_improved_target_mark"))
      timeout = timeout + 2;
  }

  thread _id_4AE03252B19B76B9(_id_161E86C260D6864C, timeout);
}

_id_4F43ED745364F234(target, _id_39E02A8A79B6BA4C) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
    self.owner thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]](_func_2EF675C13CA1C4AF(_func_1823FF50BB28148D(self.helperdronetype), "_", _id_39E02A8A79B6BA4C, "_marked"));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "playerHasMoved"))
    self.owner thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "playerHasMoved")]]();
}

_id_4AE03252B19B76B9(_id_161E86C260D6864C, timeout) {
  level endon("game_ended");
  target = _id_161E86C260D6864C.target;
  target endon(_id_161E86C260D6864C.notifytoendmark);
  _id_C437A23C3CA84A5C(_id_161E86C260D6864C, timeout);
  _id_8BF0338C7A157C29(_id_161E86C260D6864C);
}

_id_C437A23C3CA84A5C(_id_161E86C260D6864C, timeout) {
  _id_6D5A295AE3C46554 = self.owner;
  _id_6D5A295AE3C46554 endon("disconnect");
  target = _id_161E86C260D6864C.target;
  target endon("death");
  starttime = gettime();

  while(gettime() <= starttime + timeout * 1000) {
    if(isDefined(self) && isDefined(self.owner) && istrue(self.ispiloted) && self.owner _id_CCCBD62549B4440B(target, 70, 50) && _id_26D9D0C6CA7A5A8C(target) && scripts\cp_mp\killstreaks\helper_drone::_id_F9C33DF98457A9A2(target))
      starttime = gettime();

    wait 0.05;
  }
}

_id_1083BF4D55C69E99(_id_8CA2917CFE80042E, target) {
  return scripts\engine\utility::array_contains(_id_8CA2917CFE80042E.targetsinouterradius, target);
}

_id_26D9D0C6CA7A5A8C(target) {
  config = level.helperdronesettings[self.helperdronetype];
  _id_DF1A93029C5DD1E1 = scripts\cp_mp\utility\game_utility::islargemap();
  _id_E3B6FA876ADEC2AB = scripts\engine\utility::ter_op(_id_DF1A93029C5DD1E1, config._id_D5EA718ABFC8FF5B, config._id_CB2C3FE0819193EB);
  _id_E3B6FA876ADEC2AB = scripts\engine\utility::ter_op(target scripts\cp_mp\utility\player_utility::_id_988138367C74B1F5(), 250000, _id_E3B6FA876ADEC2AB);

  if(isDefined(target.markdistanceoverride))
    _id_E3B6FA876ADEC2AB = target.markdistanceoverride;

  targetpos = target.origin;

  if(isPlayer(target)) {
    targetpos = (0, 0, 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive"))
      targetpos = target[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getStanceCenter")]]();
  }

  return distancesquared(self.origin, targetpos) < _id_E3B6FA876ADEC2AB;
}

_id_C26586725702EC8C(target) {
  _id_7122B969B1FC3CC3 = 25000000;

  if(istrue(target scripts\cp_mp\utility\player_utility::_id_988138367C74B1F5()))
    _id_7122B969B1FC3CC3 = 562500;

  return distancesquared(self.origin, target.origin) < _id_7122B969B1FC3CC3;
}

_id_A4C00A4B64FCB2FA(target) {
  _id_7122B969B1FC3CC3 = 3062500;

  if(target scripts\cp_mp\utility\player_utility::_id_988138367C74B1F5())
    _id_7122B969B1FC3CC3 = 250000;

  return distancesquared(self.origin, target.origin) < _id_7122B969B1FC3CC3;
}

_id_119A97BFB70A99D6(target) {
  if(!isDefined(self.enemiesmarked))
    return 0;

  _id_161E86C260D6864C = self.enemiesmarked[target getentitynumber()];

  if(!isDefined(_id_161E86C260D6864C))
    return 0;

  return isDefined(_id_161E86C260D6864C.beingmarked);
}

_id_5E38C3C0AE63E8AF(target) {
  if(!isDefined(self.enemiesmarked))
    return 0;

  _id_161E86C260D6864C = self.enemiesmarked[target getentitynumber()];

  if(!isDefined(_id_161E86C260D6864C))
    return 0;

  return istrue(_id_161E86C260D6864C.reconmarked);
}

_id_DC5A1EA5EEF68F83() {
  return scripts\engine\utility::ter_op(istrue(self.ispiloted), 0.75, 1.0);
}

_id_50DFDF2D06587791(target, _id_9E3A8D7DC51A2CAE, drone, timeout) {
  _id_161E86C260D6864C = spawnStruct();
  _id_161E86C260D6864C.target = target;
  _id_161E86C260D6864C.targetnum = target getentitynumber();
  _id_161E86C260D6864C.outlineid = undefined;
  _id_161E86C260D6864C.headicon = undefined;
  _id_6E2944C35C23A948 = spawn("script_model", _id_9E3A8D7DC51A2CAE);
  _id_6E2944C35C23A948 setModel("tag_origin");
  showto = undefined;

  if(level.teambased) {
    showto = [];

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      if(player.team != self.team) {
        continue;
      }
      showto[showto.size] = player;
    }
  } else
    showto = self.owner;

  if(!isDefined(showto)) {
    return;
  }
  if(isarray(showto) && showto.size == 0) {
    return;
  }
  if(1) {
    _id_F98E48F2527D4205 = "hud_icon_new_marked";

    if(scripts\cp_mp\entityheadicons::_id_6EDE573723F08C0F())
      _id_F98E48F2527D4205 = "hud_icon_head_marked";

    _id_161E86C260D6864C.headicon = _id_6E2944C35C23A948 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(showto, _id_F98E48F2527D4205, 15, 1, 5000, 500, undefined, 1, 1);
  }

  thread _id_720D2D338E9A63CA(_id_161E86C260D6864C, _id_6E2944C35C23A948, timeout);
}

_id_720D2D338E9A63CA(_id_161E86C260D6864C, _id_D99ED5531D1FDC1F, timeout) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_2(timeout, "death", "explode");

  if(isDefined(_id_161E86C260D6864C.icon)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(_id_161E86C260D6864C.icon);

    if(isDefined(_id_D99ED5531D1FDC1F))
      _id_D99ED5531D1FDC1F delete();
  }

  if(isDefined(_id_161E86C260D6864C.target))
    _id_161E86C260D6864C.target.locationmarked = undefined;

  self.enemiesmarked[_id_161E86C260D6864C.targetnum] = undefined;
}

_id_1BE8CC141C0B49CF(_id_161E86C260D6864C, timeout) {
  target = _id_161E86C260D6864C.target;
  self.enemiesmarked[_id_161E86C260D6864C.targetnum] = _id_161E86C260D6864C;
  _id_F98E48F2527D4205 = "hud_icon_new_marked";

  if(scripts\cp_mp\entityheadicons::_id_6EDE573723F08C0F())
    _id_F98E48F2527D4205 = "hud_icon_head_marked";

  _id_F9CD7FDA74E92E2A = 8;

  if(isPlayer(target)) {
    if(0) {
      if(level.teambased) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForTeam"))
          _id_161E86C260D6864C.outlineid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForTeam")]](target, "orange", self.owner.team, 0, 1, 0, "killstreak");
      } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForPlayer"))
        _id_161E86C260D6864C.outlineid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForPlayer")]](target, "orange", self.owner, 0, 1, 0, "killstreak");

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "hudOutlineViewmodelEnable"))
        target[[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "hudOutlineViewmodelEnable")]](5, 0, 1);
    }

    target thread _id_D16011CEDF620DC6();
    target _id_FA08D1D78CF5CB01();
    target playlocalsound("recon_drone_spotted_plr");
  } else if(0) {
    _id_C6E17B4BC2EED915 = _id_C938E22803FB2EFC(_id_F98E48F2527D4205, _id_F9CD7FDA74E92E2A, target);
    _id_F98E48F2527D4205 = _id_C6E17B4BC2EED915.weaponicon;
    _id_F9CD7FDA74E92E2A = _id_C6E17B4BC2EED915.weaponoffset;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pmc_missions", "onReconDroneMarkEnt"))
    target[[scripts\cp_mp\utility\script_utility::getsharedfunc("pmc_missions", "onReconDroneMarkEnt")]](self.owner, target);

  self.owner scripts\cp_mp\challenges::_id_D997435895422ECC("super_recon_drone", 1);

  if(1) {
    _id_161E86C260D6864C.headicon = target scripts\cp_mp\entityheadicons::setheadicon_singleimage([], _id_F98E48F2527D4205, _id_F9CD7FDA74E92E2A, 1, 4000, 500, undefined, 1, 1);
    _id_200B632D8B4AB566(_id_161E86C260D6864C);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "watchMarkingEntStatus"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "watchMarkingEntStatus")]](_id_161E86C260D6864C);
}

_id_D16011CEDF620DC6() {
  self endon("disconnect");

  if(istrue(scripts\cp_mp\utility\player_utility::isusingremote())) {
    return;
  }
  _id_FC0043E95242D5CB = "recon_drone_flash";

  if(istrue(self.pers["useNVG"]))
    _id_FC0043E95242D5CB = "recon_drone_flash_nvg";

  self visionsetfadetoblackforplayer(_id_FC0043E95242D5CB, 0.05);
  wait 0.08;
  self visionsetfadetoblackforplayer("", 1.2);
}

_id_FA08D1D78CF5CB01() {
  if(!isDefined(self.markedomnvar)) {
    self.markedomnvar = 1;
    self setclientomnvar("ui_rcd_target_notify", self.markedomnvar);
    thread _id_DFA102C1A8648B75();
  } else {
    if(self.markedomnvar == 1)
      self.markedomnvar = 2;
    else
      self.markedomnvar = 1;

    self setclientomnvar("ui_rcd_target_notify", self.markedomnvar);
  }
}

_id_DFA102C1A8648B75() {
  self endon("disconnect");
  self notify("markedUIUpdate");
  self endon("markedUIUpdate");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "get_mark_ui_duration"))
    wait(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "get_mark_ui_duration")]]());
  else
    wait 3;

  thread _id_A867654273504370();
}

_id_A867654273504370() {
  self notify("markedUIUpdate");
  self.markedomnvar = undefined;
  self setclientomnvar("ui_rcd_target_notify", 0);
}

_id_C938E22803FB2EFC(_id_BB093C5BEBC99B6F, _id_2F3CF0914D78AC25, target) {
  weaponicon = _id_BB093C5BEBC99B6F;
  weaponoffset = _id_2F3CF0914D78AC25;
  _id_558774275543A708 = spawnStruct();

  if(isDefined(target.weapon_name)) {
    weaponref = undefined;

    if(issubstr(target.weapon_name, "claymore"))
      weaponref = "equip_claymore";
    else if(issubstr(target.weapon_name, "c4"))
      weaponref = "equip_c4";
    else if(issubstr(target.weapon_name, "atMine"))
      weaponref = "equip_at_mine";
    else if(issubstr(target.weapon_name, "trophy"))
      weaponref = "equip_trophy";

    if(isDefined(weaponref)) {
      _id_58907637F9A8D293 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "getEquipmentTableInfo"))
        _id_58907637F9A8D293 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "getEquipmentTableInfo")]](weaponref);

      weaponicon = _id_58907637F9A8D293.image;
    }
  } else if(isDefined(target.streakinfo)) {
    _id_2B7CF61AF0CB9960 = target.streakinfo.streakname;
    _id_CBAB602E6919AAD7 = level._id_0B23156D776B1D85._id_038F2A11237246AC[_id_2B7CF61AF0CB9960];
    weaponicon = scripts\engine\utility::ter_op(isDefined(_id_CBAB602E6919AAD7) && isDefined(_id_CBAB602E6919AAD7._id_890BC2DE5DEADF64), _id_CBAB602E6919AAD7._id_890BC2DE5DEADF64, "");
    weaponoffset = 75;
  }

  _id_558774275543A708.weaponicon = weaponicon;
  _id_558774275543A708.weaponoffset = weaponoffset;
  return _id_558774275543A708;
}

_id_200B632D8B4AB566(_id_161E86C260D6864C) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      return;
    }
    _id_F1D272B5FC3A575C(_id_161E86C260D6864C, player);
  }
}

_id_F1D272B5FC3A575C(_id_161E86C260D6864C, player) {
  isfriendly = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isFriendly"))
    isfriendly = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isFriendly")]](_id_161E86C260D6864C.ownerteam, player);

  if(!level.teambased) {
    if(_id_161E86C260D6864C.owner == player)
      isfriendly = 1;
  }

  _id_A81AFC6275977E88 = isDefined(_id_161E86C260D6864C.markingent) && isDefined(_id_161E86C260D6864C.markingent.owner) && player == _id_161E86C260D6864C.markingent.owner;
  ispiloted = isDefined(_id_161E86C260D6864C.markingent) && istrue(_id_161E86C260D6864C.markingent.ispiloted);
  _id_2B596ACB0B767F5D = _id_A81AFC6275977E88 && ispiloted;

  if(isDefined(_id_161E86C260D6864C.headicon)) {
    if(isfriendly && !_id_2B596ACB0B767F5D)
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(_id_161E86C260D6864C.headicon, player);
    else
      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(_id_161E86C260D6864C.headicon, player);
  }
}

_id_8BF0338C7A157C29(_id_161E86C260D6864C) {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(_id_161E86C260D6864C.headicon);

  if(isDefined(_id_161E86C260D6864C.target)) {
    _id_161E86C260D6864C.reconmarked = undefined;
    _id_161E86C260D6864C.beingmarked = undefined;
    _func_C3FAFA01F5D05D23(1, _id_161E86C260D6864C.targetnum, _id_161E86C260D6864C.ownerteam, 0);

    if(isDefined(self))
      self.enemiesmarked[_id_161E86C260D6864C.targetnum] = undefined;

    if(isPlayer(_id_161E86C260D6864C.target) && 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](_id_161E86C260D6864C.outlineid, _id_161E86C260D6864C.target);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "hudOutlineViewmodelDisable"))
        _id_161E86C260D6864C.target[[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "hudOutlineViewmodelDisable")]]();
    }

    if(isDefined(self) && isDefined(self.targetmarkergroup))
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(_id_161E86C260D6864C.target, self.targetmarkergroup);

    _id_161E86C260D6864C.target notify(_id_161E86C260D6864C.notifytoendmark);
  } else if(isDefined(self))
    self.enemiesmarked[_id_161E86C260D6864C.targetnum] = undefined;
}

_id_1E3C638E5B7031E7() {
  if(istrue(self._id_8316E01BE4051639)) {
    self.owner scripts\cp_mp\utility\player_utility::stopwatchingthermalinputchange();
    self.owner setclientomnvar("ui_block_fu_not_ready_error", 1);
    self notify("switch_modes");

    if(isDefined(self.targetmarkergroup)) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.targetmarkergroup);
      self.targetmarkergroup = undefined;
    }

    if(scripts\cp_mp\emp_debuff::is_empd())
      scripts\cp_mp\killstreaks\helper_drone::_id_FFBC19E1AEF5943C(0);

    scripts\cp_mp\utility\killstreak_utility::_id_86FF095469A70CD2();
    _id_8321764DA9DEAD70(self.owner);

    if(isDefined(self.owner.super) && isDefined(self.owner.super.staticdata) && isDefined(self.owner.super.staticdata.id))
      self.owner setclientomnvar("ui_field_upgrade_use", self.owner.super.staticdata.id);

    thread _id_FCD08C370FE30D2C(self.origin);
  } else
    thread _id_76293A71A35B8692();
}

_id_FCD08C370FE30D2C(_id_B01459D2CAC1C01F) {
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self.owner endon("droneStart");
  wait 0.05;
  _id_821114E017D34F47 = level.helperdronesettings[self.helperdronetype];
  _id_924AB4970806F758 = _id_821114E017D34F47.speed;
  _id_9DE2A251A918A33B = _id_821114E017D34F47.accel;
  _id_83694CBCB46A36FD = _id_821114E017D34F47.speed * 0.5;
  _id_0ACB0183E038BB06 = _id_821114E017D34F47.accel * 2;
  _id_3078FD3C826F3EE3 = _id_0ACB0183E038BB06 * 0.5;
  self vehicle_setspeed(_id_83694CBCB46A36FD, _id_0ACB0183E038BB06, _id_3078FD3C826F3EE3);
  self sethoverparams(1, 5, 5);
  self setvehgoalpos(_id_B01459D2CAC1C01F, 1);
  self waittill("goal");
  _id_46104FF95396DBCE = 200;
  _id_A5DE0629EDCD96A2 = _id_46104FF95396DBCE * _id_46104FF95396DBCE;

  for(;;) {
    if(distancesquared(self.origin, _id_B01459D2CAC1C01F) >= _id_A5DE0629EDCD96A2) {
      self setvehgoalpos(_id_B01459D2CAC1C01F, 1);
      self waittill("goal");
    }

    waitframe();
  }
}

_id_76293A71A35B8692(timeout) {
  thread scripts\cp_mp\killstreaks\helper_drone::_id_06EDFDA4764129E3(0, 1, timeout);
}

_id_0DCC861687CC9E38(config, _id_4FAC8B8CE36E09F1, _id_D9B2677826930BF7, _id_28D4A6F776C18B73, _id_BD21744EB1B623FE) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "clearOOB"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "clearOOB")]](self, 1);

  scripts\cp_mp\emp_debuff::clear_emp(1);

  if(istrue(self.ispiloted))
    _id_8321764DA9DEAD70(self.owner);

  if(isDefined(self.owner) && isDefined(self.owner.super)) {
    self.owner setclientomnvar("ui_block_fu_not_ready_error", 0);
    self.owner setclientomnvar("ui_field_upgrade_use", 0);
  }

  scripts\cp_mp\killstreaks\helper_drone::_id_24085A0230958938();
}

_id_8321764DA9DEAD70(player) {
  if(!isDefined(player)) {
    return;
  }
  _id_7C344645CC98E70D = self.helperdronetype;
  config = level.helperdronesettings[_id_7C344645CC98E70D];
  self.ispiloted = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "setSuperIsActive"))
    self.owner thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "setSuperIsActive")]](0);

  if(isDefined(self.playersfx))
    self.playersfx delete();

  if(isDefined(self.enemiesmarked)) {
    foreach(_id_161E86C260D6864C in self.enemiesmarked)
    _id_F1D272B5FC3A575C(_id_161E86C260D6864C, player);
  }

  _id_A57879325A8E0669 = "ks_remote_drone_mp";

  if(istrue(self._id_EEE5DDAAFC619FA3))
    _id_A57879325A8E0669 = "ks_remote_device_mp";

  player thread recondrone_takedeployweapon(1, _id_A57879325A8E0669);
  player scripts\cp_mp\killstreaks\helper_drone::helperdrone_takeplayerfauxremote(self.streakinfo);
  player painvisionon();
  player scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("");

  if(istrue(self.isthermalenabled))
    player scripts\cp_mp\utility\player_utility::setthermalvision(0);

  player thread scripts\cp_mp\killstreaks\helper_drone::_id_F23D90F7483D67E4();
  player cameraunlink();

  if(!istrue(self._id_D31453E33D3E34CA))
    player remotecontrolvehicleoff();

  player scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "reconDrone");
  player scripts\cp_mp\utility\player_utility::_freezelookcontrols(0, 1);
  player _id_3B64EB40368C1450::_id_588F2307A3040610("reconDrone_deploy");
  player _id_3B64EB40368C1450::_id_588F2307A3040610("reconDrone_use");
  player _id_6DE53543FEE67F02::_id_E2EAE50826E12247();
  scripts\cp_mp\utility\killstreak_utility::movingplatform_playerunlink(player);

  if(scripts\cp_mp\utility\player_utility::isreallyalive(player) && isDefined(player.restoreangles))
    player setplayerangles((player.restoreangles[0], player.restoreangles[1], 0));

  player.restoreangles = undefined;
  player scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
}

recondrone_beginsuper() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  streakinfo = spawnStruct();
  streakinfo.streakname = "radar_drone_recon";
  streakinfo.weaponname = "ks_remote_drone_mp";
  streakinfo.issuper = 1;
  streakinfo.superid = level.superglobals.staticsuperdata["super_recon_drone"].id;
  streakinfo._id_EBEC497FF8B18A45 = level.superglobals.staticsuperdata["super_recon_drone"].ref;

  if(!scripts\cp_mp\killstreaks\helper_drone::tryusehelperdroneearlyout(streakinfo, 1)) {
    self.recondronereserved = 1;
    thread recondrone_watchcleanupreserved(streakinfo, 0);

    if(scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
      self.reconvehiclereserved = 1;
      thread recondrone_watchcleanupreserved(streakinfo, 1);

      if(recondrone_givedeployweapon("ks_remote_drone_mp")) {
        thread recondrone_watchsuper(streakinfo);
        scripts\cp_mp\challenges::_id_D997435895422ECC("super_recon_drone", 0);
        return 1;
      } else {
        _id_3B64EB40368C1450::_id_588F2307A3040610("reconDrone_switch");
        thread recondrone_takedeployweapon(1, "ks_remote_drone_mp");
        thread recondrone_cleanupreserved(streakinfo, 1);
      }
    } else
      thread recondrone_cleanupreserved(streakinfo, 0);
  }

  return 0;
}

recondrone_endsuper(_id_FCEF8D217A441961) {
  self notify("reconDroneEnded");
  self.recondronesafespawn = undefined;

  if(isDefined(self.recondronerefund)) {
    self.recondronerefund = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "giveSuperPoints") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "getSuperPointsNeeded"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]]([[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "getSuperPointsNeeded")]]());
  }

  if(isDefined(self.recondronereserved)) {
    self.recondronereserved = undefined;
    streakinfo = spawnStruct();
    streakinfo.streakname = "radar_drone_recon";
    recondrone_cleanupreserved(streakinfo);
  }

  if(isDefined(self.reconvehiclereserved)) {
    self.reconvehiclereserved = undefined;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  }
}

recondrone_watchsuper(streakinfo) {
  self endon("disconnect");
  result = recondrone_watchsuperinternal(streakinfo);

  if(!istrue(result)) {
    _id_3B64EB40368C1450::_id_588F2307A3040610("reconDrone_switch");
    _id_3B64EB40368C1450::_id_588F2307A3040610("reconDrone_deploy");
    thread recondrone_takedeployweapon(1, "ks_remote_drone_mp");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](1);
  } else if(!istrue(level.helperdronesettings["radar_drone_recon"]._id_8316E01BE4051639) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](0);
}

recondrone_watchsuperinternal(streakinfo) {
  self endon("death");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  thread recondrone_watchsuperendfromswitch();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("reconDrone", "onSuperStarted"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("reconDrone", "onSuperStarted")]]();

  _id_3B64EB40368C1450::_id_3633B947164BE4F3("reconDrone_deploy", 0);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "reconDrone");
  wait 1.85;
  childthread scripts\cp_mp\killstreaks\helper_drone::_id_34280B807C23A453(streakinfo.streakname);
  wait 0.15;

  if(level.gameended)
    self.recondronesafespawn = undefined;

  isinlaststand = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isInLastStand"))
    isinlaststand = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isInLastStand")]](self);

  if(isDefined(self.recondronesafespawn) && !isinlaststand) {
    self.reconvehiclereserved = undefined;
    thread recondrone_watchcleanupreserved(streakinfo, 0);
    _id_9551DC58F953D062 = _id_D8B72BA55B4292CF(self.recondronesafespawn, self.angles, streakinfo.streakname, streakinfo);
    self.recondronesafespawn = undefined;

    if(isDefined(_id_9551DC58F953D062)) {
      thread scripts\cp_mp\killstreaks\helper_drone::helperdrone_giveplayerfauxremote(streakinfo);
      _id_9551DC58F953D062 recondrone_addtolists(_id_9551DC58F953D062, self);
      scripts\cp_mp\killstreaks\helper_drone::_id_C3786C4FBA09C2F2(streakinfo);
      thread scripts\cp_mp\killstreaks\helper_drone::starthelperdrone(_id_9551DC58F953D062);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound"))
        level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "stat_C836F1CDB2DA4224");

      _id_E005D4B70D6F2611 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]();

      if(_id_E005D4B70D6F2611)
        _id_9551DC58F953D062 vehicleshowonminimap(0);

      scripts\cp_mp\utility\killstreak_utility::playkillstreakusedialog(streakinfo.streakname);
      _id_9551DC58F953D062 scripts\cp_mp\killstreaks\helper_drone::helperdrone_notifyenemyplayersinrange(streakinfo.streakname);
      self notify("successful_recon_deployment");
      return 1;
    } else {
      scripts\cp_mp\killstreaks\helper_drone::helperdronecreationfailedfx(streakinfo.streakname);
      scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "reconDrone");
    }
  } else {
    scripts\cp_mp\killstreaks\helper_drone::helperdronecreationfailedfx(streakinfo.streakname);
    scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1, "reconDrone");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");

  self notify("failed_recon_deployment");
  return 0;
}

recondrone_watchsuperendfromswitch() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  self endon("reconDrone_watchSuperEndFromSwitch");
  objweapon = makeweapon("ks_remote_drone_mp");

  for(;;) {
    if(self getcurrentweapon() != objweapon) {
      break;
    }

    waitframe();
  }
}

recondrone_unsetsuper(_id_FCEF8D217A441961) {
  self notify("reconDroneUnset");

  if(1) {
    _id_9551DC58F953D062 = self.recondronesuper;

    if(isDefined(_id_9551DC58F953D062)) {
      if(!istrue(_id_9551DC58F953D062.isdestroyed))
        _id_9551DC58F953D062 scripts\cp_mp\killstreaks\helper_drone::_id_BA1C5496F8FC5F67();
    }
  }

  thread recondrone_endsuper(_id_FCEF8D217A441961);
}

recondrone_givedeployweapon(deployweaponname, _id_D037FCE5B7051C4A) {
  self endon("death_or_disconnect");
  self endon("reconDroneWeaponTaken");
  self notify("reconDroneWeaponGiven");
  self endon("reconDroneWeaponGiven");
  objweapon = makeweapon(deployweaponname);

  if(!self hasweapon(objweapon) && objweapon.basename != "none")
    scripts\cp_mp\utility\inventory_utility::_giveweapon(objweapon);

  _id_3B64EB40368C1450::_id_3633B947164BE4F3("reconDrone_switch", 0);
  thread _id_7C3DC10C6270B3C8("melee_swipe_start", objweapon);
  thread _id_7C3DC10C6270B3C8("weapon_change", objweapon);
  thread _id_7C3DC10C6270B3C8("player_isHaywire", objweapon);

  if(isDefined(_id_D037FCE5B7051C4A))
    thread _id_31CC8545B41BADCA(_id_D037FCE5B7051C4A, objweapon);

  result = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(objweapon);

  if(result)
    _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "activate_drone");

  return result;
}

_id_7C3DC10C6270B3C8(_id_BF4A0ADF8E2321FE, _id_8881166E57766E3A) {
  self endon("death_or_disconnect");
  self endon("recon_drone_cancel");
  self endon("droneStart");
  level endon("game_ended");
  self waittill(_id_BF4A0ADF8E2321FE);

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(_id_8881166E57766E3A))
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(_id_8881166E57766E3A);

  self notify("recon_drone_cancel");
}

_id_31CC8545B41BADCA(drone, _id_8881166E57766E3A) {
  self endon("death_or_disconnect");
  self endon("recon_drone_cancel");
  self endon("droneStart");
  level endon("game_ended");
  drone scripts\engine\utility::waittill_any_2("death", "explode");

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(_id_8881166E57766E3A))
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(_id_8881166E57766E3A);

  scripts\cp_mp\utility\player_utility::_freezelookcontrols(0, 1);
  _id_3B64EB40368C1450::_id_588F2307A3040610("reconDrone_switch");
  self notify("recon_drone_cancel");
}

recondrone_takedeployweapon(_id_CD4F35A2AC5BD598, deployweaponname) {
  self endon("death_or_disconnect");
  self endon("reconDroneWeaponGiven");
  self notify("reconDroneWeaponTaken");
  self endon("reconDroneWeaponTaken");

  if(!isDefined(deployweaponname))
    return 0;

  objweapon = makeweapon(deployweaponname);

  if(istrue(_id_CD4F35A2AC5BD598)) {
    if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(objweapon)) {
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(objweapon);
      return;
    }
  }

  if(istrue(_id_CD4F35A2AC5BD598))
    scripts\cp_mp\utility\inventory_utility::getridofweapon(objweapon);

  _id_3B64EB40368C1450::_id_588F2307A3040610("reconDrone_switch");
}

recondrone_watchcleanupreserved(streakinfo, vehiclereserved) {
  self notify("reconDrone_cleanupReserved");
  self endon("reconDrone_cleanupReserved");
  self waittill("disconnect");
  thread recondrone_cleanupreserved(streakinfo, vehiclereserved);
}

recondrone_cleanupreserved(streakinfo, vehiclereserved) {
  self notify("reconDrone_cleanupReserved");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]](1);

  scripts\cp_mp\killstreaks\helper_drone::_id_C3786C4FBA09C2F2(streakinfo);

  if(istrue(vehiclereserved)) {
    if(istrue(self.reconvehiclereserved))
      self.reconvehiclereserved = undefined;

    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  }
}

recondrone_addtolists(drone, owner) {
  owner.recondronesuper = drone;
  owner.pausesuperpointsovertime = 1;
  id = drone getentitynumber();

  if(!isDefined(level.recondronesupers))
    level.recondronesupers = [];

  level.recondronesupers[id] = drone;
  thread recondrone_removefromlistsondeath(drone, owner, id);
}

recondrone_removefromlists(drone, owner, id) {
  if(isDefined(drone)) {
    drone notify("reconDrone_removeFromLists");
    id = drone getentitynumber();
  }

  if(isDefined(owner)) {
    owner.recondronesuper = undefined;
    owner.pausesuperpointsovertime = 0;
  }

  if(isDefined(level.recondronesupers))
    level.recondronesupers[id] = undefined;
}

recondrone_removefromlistsondeath(drone, owner, id) {
  drone endon("reconDrone_removeFromLists");
  drone waittill("death");
  thread recondrone_removefromlists(drone, owner, id);
}

_id_39CBA2C62062F32E() {
  if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
    foreach(drone in level.supportdrones) {
      if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self, drone.owner))) {
        if(isDefined(drone.enemiesmarked) && isDefined(drone.enemiesmarked[self getentitynumber()]))
          return 1;
      }
    }
  }

  return 0;
}

_id_CCCBD62549B4440B(_id_D89F028A5C8DB805, _id_C6CFD7BE26D2C7DF, _id_5E43B44751D01B1A) {
  _id_9B96536B85A38BC6 = 0;
  _id_08A4EA3A3BAA22E4 = _id_D89F028A5C8DB805.origin;

  if(isDefined(_id_D89F028A5C8DB805.recondronetraceoffset))
    _id_08A4EA3A3BAA22E4 = _id_08A4EA3A3BAA22E4 + _id_D89F028A5C8DB805.recondronetraceoffset;

  _id_20C094516733FFB1 = [_id_08A4EA3A3BAA22E4];

  if(isPlayer(_id_D89F028A5C8DB805)) {
    _id_295719F06C03407F = _id_D89F028A5C8DB805 scripts\cp_mp\utility\player_utility::getstancetop();
    _id_FC60036BA7BF253A = _id_D89F028A5C8DB805 scripts\cp_mp\utility\player_utility::getstancecenter();
    _id_20C094516733FFB1 = [_id_295719F06C03407F, _id_FC60036BA7BF253A, _id_08A4EA3A3BAA22E4];
  } else if(isagent(_id_D89F028A5C8DB805))
    _id_20C094516733FFB1 = [_id_08A4EA3A3BAA22E4 + (0, 0, 1)];

  foreach(point in _id_20C094516733FFB1) {
    if(self worldpointinreticle_circle(point, _id_C6CFD7BE26D2C7DF, _id_5E43B44751D01B1A)) {
      _id_9B96536B85A38BC6 = 1;
      break;
    }
  }

  return _id_9B96536B85A38BC6;
}

_id_2F23CBE83E1E57DF(_id_BD73C7ACC56CD20C) {
  config = level.helperdronesettings[self.helperdronetype];

  if(scripts\cp_mp\emp_debuff::is_empd())
    return 0;

  if(isPlayer(_id_BD73C7ACC56CD20C)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
      if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](_id_BD73C7ACC56CD20C))
        return 0;
    }

    if(!istrue(config._id_6A390682C21BC49E)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(_id_BD73C7ACC56CD20C[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline"))
          return 0;
      }
    }
  }

  if(isagent(_id_BD73C7ACC56CD20C)) {
    if(!isalive(_id_BD73C7ACC56CD20C))
      return 0;
  }

  if(level.teambased) {
    if(isDefined(_id_BD73C7ACC56CD20C.team) && _id_BD73C7ACC56CD20C.team == self.team)
      return 0;
  } else {
    if(isPlayer(_id_BD73C7ACC56CD20C) && _id_BD73C7ACC56CD20C == self.owner)
      return 0;

    if(isDefined(_id_BD73C7ACC56CD20C.owner) && _id_BD73C7ACC56CD20C.owner == self.owner)
      return 0;
  }

  if(!_id_C26586725702EC8C(_id_BD73C7ACC56CD20C))
    return 0;

  if(_id_5E38C3C0AE63E8AF(_id_BD73C7ACC56CD20C))
    return 0;

  if(_id_1083BF4D55C69E99(self, _id_BD73C7ACC56CD20C))
    return 0;

  config = level.helperdronesettings[self.helperdronetype];

  if(istrue(config._id_1947A47C2174D02C) && !self.owner _id_CCCBD62549B4440B(_id_BD73C7ACC56CD20C, 70, 300))
    return 0;

  return 1;
}

_id_80226370B4C80B06(_id_BD73C7ACC56CD20C) {
  config = level.helperdronesettings[self.helperdronetype];

  if(scripts\cp_mp\emp_debuff::is_empd())
    return 0;

  if(isPlayer(_id_BD73C7ACC56CD20C)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
      if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](_id_BD73C7ACC56CD20C))
        return 0;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(_id_BD73C7ACC56CD20C[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline"))
        return 0;
    }
  }

  if(isagent(_id_BD73C7ACC56CD20C)) {
    if(!isalive(_id_BD73C7ACC56CD20C))
      return 0;

    if(isDefined(_id_BD73C7ACC56CD20C.agent_type) && issubstr(_id_BD73C7ACC56CD20C.agent_type, "civilian"))
      return 0;
  }

  if(!scripts\cp_mp\killstreaks\helper_drone::_id_F9C33DF98457A9A2(_id_BD73C7ACC56CD20C, 1))
    return 0;

  if(_id_5E38C3C0AE63E8AF(_id_BD73C7ACC56CD20C))
    return 0;

  return 1;
}

_id_46E2D014D3DBF29B() {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("flash_glint", "on");
  wait 0.3;
  self setscriptablepartstate("flash_glint", "off");
}

_id_85F0FD88983D1893(data) {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  if(!isDefined(self.owner)) {
    return;
  }
  if(isDefined(data.attacker) && isDefined(data.inflictor) && self.currenthealth > 0)
    self dodamage(self.maxhealth, self.origin, data.attacker, data.inflictor);
}

_id_31B413D9B6ABE7F8(data) {
  self setscriptablepartstate("ddos", "disabled", 0);

  if(!isDefined(self.owner)) {
    return;
  }
  if(istrue(self.ispiloted))
    scripts\cp_mp\killstreaks\helper_drone::_id_FFBC19E1AEF5943C(1);
}

_id_41F3461C40E5A87C(data) {
  if(!isDefined(self.owner)) {
    return;
  }
  if(isDefined(data.attacker)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
      data.attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("disabled_recon_drone");
  }
}

_id_6A90D81D42854ECD(_id_B3990D56E2779F79) {
  self setscriptablepartstate("ddos", "neutral", 0);

  if(!isDefined(self.owner)) {
    return;
  }
  if(istrue(self.ispiloted))
    scripts\cp_mp\killstreaks\helper_drone::_id_FFBC19E1AEF5943C(0);
}

_id_7D0DB4B7F46E7DC0() {
  targetarray = [];
  contentoverride = scripts\engine\trace::create_world_contents();
  _id_3DF9D9A1027FB9BC = self.owner getvieworigin();
  _id_D90F07506FC6739A = _id_3DF9D9A1027FB9BC + anglesToForward(self.owner getplayerangles()) * 5000;
  ignoreents = [self];
  _id_6156EAF7876D53CD = scripts\engine\trace::ray_trace(_id_3DF9D9A1027FB9BC, _id_D90F07506FC6739A, ignoreents, contentoverride);

  if(_id_6156EAF7876D53CD["hittype"] != "hittype_none")
    _id_D90F07506FC6739A = _id_6156EAF7876D53CD["position"];

  targetarray = scripts\common\utility::_id_2D7FD59D039FA69B(_id_D90F07506FC6739A, 2500.0);
  return targetarray;
}

_id_157C2BCD50CA6207() {
  _id_9551DC58F953D062 = self.recondronesuper;
  return isDefined(_id_9551DC58F953D062) && !istrue(_id_9551DC58F953D062.isdestroyed);
}