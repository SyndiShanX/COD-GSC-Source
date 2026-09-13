/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_34dfc67dd9cbac0b.gsc
***********************************************/

_id_52A84590522475B3(_id_92C4DE821390F609) {
  if(!scripts\engine\utility::flag_exist("samsite_initted"))
    scripts\engine\utility::flag_init("samsite_initted");

  if(!scripts\engine\utility::flag_exist("samsite_activated"))
    scripts\engine\utility::flag_init("samsite_activated");

  _id_03B819B9C304F403 = scripts\engine\utility::getStruct(_id_92C4DE821390F609, "script_noteworthy");
  _id_2EEC3B2AC0695F33 = _id_FEFA23BED4E70FB2(_id_03B819B9C304F403);
  _id_84BD84DEB891A915 = scripts\engine\utility::getStructArray(_id_03B819B9C304F403.target, "targetname");
  _id_2EEC3B2AC0695F33._id_AFD35A84EE058EDA = "deactivated";

  foreach(struct in _id_84BD84DEB891A915) {
    struct._id_2EEC3B2AC0695F33 = _id_2EEC3B2AC0695F33;

    if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "samsite_scan") {} else if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "samsite_launch") {
      _id_2EEC3B2AC0695F33._id_51152C59638B9762 = _id_18AF78602B67B70C::_id_683F024F53CEE760(struct, &"CP_HARRIER_BOSS/SAM_LAUNCH_BUTTON");
      _id_2EEC3B2AC0695F33 thread _id_726999FEE807FB28(_id_2EEC3B2AC0695F33._id_51152C59638B9762);
    } else if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "samsite_beacon") {
      _id_2EEC3B2AC0695F33._id_C6D69F0ECD0FA26F = struct;
      _id_613F06D21C031784(_id_2EEC3B2AC0695F33, struct);
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("samsite_initted");
  _id_2EEC3B2AC0695F33 _id_75BBC7B04A32E838(_id_2EEC3B2AC0695F33);
}

_id_FEFA23BED4E70FB2(struct) {
  turret = spawnturret("misc_turret", struct.origin, "iw9_tur_samsite_cp");

  if(!isDefined(struct.angles))
    struct.angles = (0, 0, 0);

  turret.angles = struct.angles;
  turret.team = "axis";
  turret setModel("military_samsite_01_rig_skeleton");
  turret settoparc(75);
  turret setbottomarc(0);
  turret setleftarc(360);
  turret setrightarc(360);
  turret setscriptablepartstate("rocket1", "hidden");
  turret setscriptablepartstate("rocket2", "hidden");
  turret setscriptablepartstate("rocket3", "hidden");
  turret _meth_DFB78B3E724AD620(0);
  return turret;
}

_id_613F06D21C031784(_id_2EEC3B2AC0695F33, _id_03B819B9C304F403) {
  beacon = spawn("script_model", _id_03B819B9C304F403.origin);
  beacon.angles = scripts\engine\utility::ter_op(isDefined(_id_03B819B9C304F403.angles), _id_03B819B9C304F403.angles, (0, 0, 0));
  beacon setModel("offhand_2h_c4_prop");
  beacon._id_C327ADFAD89EFC23 = _id_2EEC3B2AC0695F33;
  beacon _id_6FABA6219A5A20C0();
  beacon.objindex = scripts\cp\cp_objectives::requestworldid("sam_beacon");
  objective_setlabel(beacon.objindex, &"CP_HARRIER_BOSS/YOU_HAVE_THE_BEACON");
  objective_onentity(beacon.objindex, beacon);

  foreach(player in level.players)
  objective_removeallfrommask(beacon.objindex, player);

  _id_2EEC3B2AC0695F33.beacon = beacon;
  _id_2EEC3B2AC0695F33 thread _id_E137ABB9EC4F3457();
  return beacon;
}

_id_DCAEE0A35F84385C(_id_2EEC3B2AC0695F33) {
  level endon("game_ended");

  if(isDefined(_id_2EEC3B2AC0695F33.beacon)) {
    if(isDefined(_id_2EEC3B2AC0695F33.beacon.objindex)) {
      level thread scripts\cp\cp_objectives::freeworldid("sam_beacon");

      if(isDefined(_id_2EEC3B2AC0695F33.beacon.objindex))
        objective_delete(_id_2EEC3B2AC0695F33.beacon.objindex);
    }

    _id_2EEC3B2AC0695F33.beacon delete();
    _id_2EEC3B2AC0695F33.beacon = undefined;
  }

  wait 5;
  _id_613F06D21C031784(_id_2EEC3B2AC0695F33, _id_2EEC3B2AC0695F33._id_C6D69F0ECD0FA26F);
}

removeheadicon(beacon) {
  deleteheadicon(beacon.headicon);
}

_id_25397F8033010B1F(beacon) {
  if(_id_4A79CE628E453CCF(beacon))
    hideheadiconfromplayersinmask(beacon.headicon);
  else
    showheadicontoplayersinmask(beacon.headicon);
}

_id_6643FB41282F6BDB(player) {
  return isDefined(player._id_F80643446EB396D6);
}

_id_4A79CE628E453CCF(beacon) {
  return isDefined(beacon._id_16E3F5AB016DBF91);
}

_id_E137ABB9EC4F3457() {
  level endon("game_ended");
  self endon("samsite_disabled");
  scripts\engine\utility::flag_wait("samsite_initted");
  beacon = self.beacon;
  beacon scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_HARRIER_BOSS/PICKUP_BEACON", 25, "duration_medium", "hide", 256, 180, 64, 165);
  beacon _meth_DFB78B3E724AD620(1);

  for(;;) {
    beacon waittill("trigger", player);

    if(!isPlayer(player)) {
      waitframe();
      continue;
    }

    beacon _meth_DFB78B3E724AD620(0);
    _id_3B12F69C10F4C7B0(self, player);
    return;
  }
}

_id_3B12F69C10F4C7B0(_id_C327ADFAD89EFC23, player) {
  player forceplaygestureviewmodel("ges_swipe", _id_C327ADFAD89EFC23.beacon);
  _id_C327ADFAD89EFC23.beacon._id_16E3F5AB016DBF91 = player;
  player._id_F80643446EB396D6 = _id_C327ADFAD89EFC23.beacon;

  if(isDefined(_id_C327ADFAD89EFC23.beacon.objindex)) {
    objective_icon(_id_C327ADFAD89EFC23.beacon.objindex, "icon_waypoint_objective_general");
    objective_state(_id_C327ADFAD89EFC23.beacon.objindex, "current");
    objective_addclienttomask(_id_C327ADFAD89EFC23.beacon.objindex, player);
    objective_hideprogressforteam(_id_C327ADFAD89EFC23.beacon.objindex, "allies");
    objective_pinforclient(_id_C327ADFAD89EFC23.beacon.objindex, player);
  }

  _id_25397F8033010B1F(_id_C327ADFAD89EFC23.beacon);
  _id_C327ADFAD89EFC23.beacon linkTo(player);
  _id_C327ADFAD89EFC23.beacon hide();
  _id_C327ADFAD89EFC23.beacon notify("beacon_picked_up");
  level thread _id_E34D0ADE36E7F03E(_id_C327ADFAD89EFC23, player);
}

_id_E34D0ADE36E7F03E(_id_C327ADFAD89EFC23, player) {
  level endon("game_ended");
  player endon("planted_beacon");
  beacon = player._id_F80643446EB396D6;
  player scripts\engine\utility::waittill_any_3("last_stand", "disconnect", "death");
  beacon.origin = getclosestpointonnavmesh(beacon.origin) + (0, 0, 40);
  _id_AE29108278A5B8EF(player, beacon);
  _id_25397F8033010B1F(beacon);
  _id_C327ADFAD89EFC23 thread _id_E137ABB9EC4F3457();
  _id_C327ADFAD89EFC23 thread _id_1C2443A36F18E6EF(beacon);
}

_id_AE29108278A5B8EF(player, beacon) {
  if(isDefined(beacon.objindex)) {
    objective_state(beacon.objindex, "failed");
    objective_removeclientfrommask(beacon.objindex, player);
    objective_hideprogressforteam(beacon.objindex, "allies");
    objective_unpinforclient(beacon.objindex, player);
  }

  beacon._id_16E3F5AB016DBF91 = undefined;
  player._id_F80643446EB396D6 = undefined;
  beacon unlink();
  beacon show();
}

_id_1C2443A36F18E6EF(beacon) {
  level endon("game_ended");
  objid = scripts\cp\cp_objectives::requestworldid("samsiteBeacon", 15);
  objective_setlabel(objid, &"CP_HARRIER_BOSS/SAM_BEACON");
  objective_setshowprogress(objid, 1);
  objective_setprogress(objid, 1);
  objective_state(objid, "current");
  objective_setownerteam(objid, "allies");
  objective_setzoffset(objid, 50);
  objective_onentity(objid, beacon);
  _id_FDCB2DAAF2B5C345 = 10;
  progress = 0;
  waittime = _id_FDCB2DAAF2B5C345 * 1000;
  starttime = gettime();

  while(!isDefined(beacon._id_16E3F5AB016DBF91) && gettime() - starttime < waittime) {
    progress = clamp(progress + 1, progress, _id_FDCB2DAAF2B5C345);
    objective_setprogress(objid, progress / _id_FDCB2DAAF2B5C345);
    wait 1;
  }

  objective_delete(objid);

  if(!isDefined(beacon._id_16E3F5AB016DBF91))
    beacon.origin = self._id_C6D69F0ECD0FA26F.origin;
}

_id_7001B801F6F65973(_id_E043B9463E6F45DA) {
  return _id_E043B9463E6F45DA._id_AFD35A84EE058EDA == "scanning";
}

_id_3C6E0D0F24AB8A06(_id_E043B9463E6F45DA) {
  if(!isDefined(_id_E043B9463E6F45DA.beacon))
    return 0;

  _id_DBEAB02668051D67 = _id_E043B9463E6F45DA.origin[2] + 100 >= _id_E043B9463E6F45DA.beacon.origin[2];
  _id_0B93764EEE510E55 = isDefined(_id_E043B9463E6F45DA.beacon._id_16E3F5AB016DBF91) || istrue(_id_E043B9463E6F45DA.beacon._id_2850387A8CB23B4F);
  return !istrue(_id_DBEAB02668051D67) && istrue(_id_0B93764EEE510E55);
}

_id_B44A40732AC3F46A(button) {
  level endon("game_ended");
  self endon("samsite_disabled");
  scripts\engine\utility::flag_wait("samsite_initted");

  for(;;) {
    button waittill("trigger", player);

    if(!isPlayer(player)) {
      waitframe();
      continue;
    }

    button _meth_DFB78B3E724AD620(0);
    _id_9B2BE436F94AFD29(player, &"CP_HARRIER_BOSS/SAM_SCANNING_NOW", 1);
    level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guid8ff33a36cd0245c6b79f7d6498ad8faa");
    wait 0.3;

    if(_id_3C6E0D0F24AB8A06(self)) {
      self._id_AFD35A84EE058EDA = "scanning";
      level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_HARRIER_BOSS/SAM_LAUNCH_READY");
      player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_HARRIER_BOSS/SAM_LAUNCH_READY", 2);
      level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guida461c80b99ac4bb4a5240f8bc0c455d9");
      self settargetentity(self.beacon);
      wait 10;
      self cleartargetentity();
      self._id_AFD35A84EE058EDA = "deactivated";
      level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_HARRIER_BOSS/SAM_SCAN_ENDED");
      player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_HARRIER_BOSS/SAM_SCAN_ENDED", 2);
    } else {
      self._id_AFD35A84EE058EDA = "deactivated";
      _id_9B2BE436F94AFD29(player, &"CP_HARRIER_BOSS/SAM_NO_BEACON", 2);
    }

    button _meth_DFB78B3E724AD620(1);
  }
}

_id_22B0434F49CD6BAB(player, _id_3F0EF0F4373C1D91) {
  _id_9B2BE436F94AFD29(player, &"CP_HARRIER_BOSS/SAM_SCANNING_NOW", 1);
  level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guid8ff33a36cd0245c6b79f7d6498ad8faa");
  wait 5;

  if(_id_3C6E0D0F24AB8A06(_id_3F0EF0F4373C1D91)) {
    _id_3F0EF0F4373C1D91._id_AFD35A84EE058EDA = "scanning";
    level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_HARRIER_BOSS/SAM_LAUNCH_READY");
    player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_HARRIER_BOSS/SAM_LAUNCH_READY", 2);
    level thread _id_18AF78602B67B70C::_id_775CD164C569E279("dx_guida461c80b99ac4bb4a5240f8bc0c455d9");
    return 1;
  } else {
    _id_3F0EF0F4373C1D91._id_AFD35A84EE058EDA = "deactivated";
    _id_9B2BE436F94AFD29(player, &"CP_HARRIER_BOSS/SAM_NO_BEACON", 2);
    return 0;
  }
}

_id_726999FEE807FB28(button) {
  level endon("game_ended");
  self endon("samsite_disabled");
  scripts\engine\utility::flag_wait("samsite_initted");

  for(;;) {
    button waittill("trigger", player);

    if(!isPlayer(player)) {
      waitframe();
      continue;
    }

    button _meth_DFB78B3E724AD620(0);

    if(isDefined(self.beacon))
      self settargetentity(self.beacon);

    _id_AFAABE917BFD890A = _id_22B0434F49CD6BAB(player, self);

    if(istrue(_id_AFAABE917BFD890A))
      _id_280B73E4B41FE8ED(self);
    else {
      thread _id_0A8EB82855A7E6E0(self.beacon);
      _id_9B2BE436F94AFD29(player, &"CP_HARRIER_BOSS/SAM_NO_BEACON", 2);
    }

    self cleartargetentity();
    button _meth_DFB78B3E724AD620(1);
  }
}

_id_9B2BE436F94AFD29(player, _id_89AEC769ADBA3083, time) {
  level endon("game_ended");
  player thread scripts\cp\cp_hud_message::tutorialprint(_id_89AEC769ADBA3083, time);
  wait(time);
}

_id_0A8EB82855A7E6E0(beacon) {
  level endon("game_ended");
  objindex = scripts\cp\cp_objectives::requestworldid("beacon_ping");
  objective_setlabel(objindex, &"CP_HARRIER_BOSS/PICKUP_BEACON");
  objective_icon(objindex, "icon_waypoint_objective_general");
  objective_position(objindex, beacon.origin + (0, 0, 100));
  objective_setownerteam(objindex, "allies");
  objective_setplayintro(objindex, 1);
  objective_setplayoutro(objindex, 0);
  objective_state(objindex, "current");
  beacon scripts\engine\utility::waittill_any_timeout_1(10, "beacon_picked_up");
  objective_delete(objindex);
  scripts\cp\cp_objectives::freeworldid("beacon_ping");
}

_id_E92B323B6314FDE1(fxorigin) {
  level endon("game_ended");
  _id_EFDFC6EBE7A152C5 = spawnfx(level._effect["vfx_javelin_expl"], fxorigin);
  triggerfx(_id_EFDFC6EBE7A152C5);

  if(soundexists("breach_c4_expl_trans"))
    playsoundatpos(fxorigin, "breach_c4_expl_trans");

  wait 10;

  if(isDefined(_id_EFDFC6EBE7A152C5))
    _id_EFDFC6EBE7A152C5 delete();
}

_id_280B73E4B41FE8ED(_id_311F32609C363F70, _id_ABFE04EB6DA78EB9) {
  _id_311F32609C363F70 endon("death");

  if(!isDefined(_id_ABFE04EB6DA78EB9))
    _id_ABFE04EB6DA78EB9 = 0;

  missile = undefined;
  _id_FACF9F5A4B563C03 = 0;

  if(isDefined(_id_311F32609C363F70._id_692FC766D262881A)) {
    missile = _id_311F32609C363F70._id_692FC766D262881A;
    _id_311F32609C363F70._id_692FC766D262881A notify("launched");
    _id_311F32609C363F70._id_692FC766D262881A = undefined;

    if(!_id_311F32609C363F70 isnearanyplayer(5000) || istrue(_id_ABFE04EB6DA78EB9))
      _id_311F32609C363F70._id_692FC766D262881A = _id_311F32609C363F70 _id_316BE6EF08C56E9B(1);
  } else if(isDefined(_id_311F32609C363F70._id_692FC666D26285E7)) {
    missile = _id_311F32609C363F70._id_692FC666D26285E7;
    _id_311F32609C363F70._id_692FC666D26285E7 notify("launched");
    _id_311F32609C363F70._id_692FC666D26285E7 = undefined;

    if(!_id_311F32609C363F70 isnearanyplayer(5000) || istrue(_id_ABFE04EB6DA78EB9))
      _id_311F32609C363F70._id_692FC666D26285E7 = _id_311F32609C363F70 _id_316BE6EF08C56E9B(2);
  } else if(isDefined(_id_311F32609C363F70._id_692FC566D26283B4)) {
    missile = _id_311F32609C363F70._id_692FC566D26283B4;
    _id_311F32609C363F70._id_692FC566D26283B4 notify("launched");
    _id_311F32609C363F70._id_692FC566D26283B4 = undefined;
    _id_FACF9F5A4B563C03 = 1;
  }

  _id_311F32609C363F70 setscriptablepartstate("launch", "on");

  if(!isDefined(missile) || !isDefined(_id_311F32609C363F70.beacon)) {
    return;
  }
  missile._id_DA169210CED21C6B = 1;
  _id_3865E73449A5A438 = makeweapon("iw9_la_samsite_cp");
  magicbullet(_id_3865E73449A5A438, missile.origin, missile.origin);
  missile unlink();
  wait 0.5;
  _id_311F32609C363F70 thread _id_841BCDB84223F84A();
  earthquake(0.4, 1, missile.origin, 1200);

  if(isDefined(_id_311F32609C363F70.beacon))
    missile moveTo(_id_311F32609C363F70.beacon.origin, 0.75);
  else
    missile moveTo(missile.origin + anglesToForward(missile.angles) * 40000, 15);

  wait 0.75;

  if(isDefined(_id_311F32609C363F70.beacon))
    _id_980DFD4D9D8425DA = _id_311F32609C363F70.beacon.origin;
  else
    _id_980DFD4D9D8425DA = missile.origin;

  lastknownmissilepos = missile.origin;
  radiusdamage(lastknownmissilepos, 128, 1000, 1000, undefined, "MOD_EXPLOSIVE");
  scripts\cp\utility\cp_controlled_callbacks::runcontrolledcallback("Earthquake", 1.0, 0.6, lastknownmissilepos, 128);
  earthquake(1.0, 0.6, lastknownmissilepos, 128);
  level thread _id_E92B323B6314FDE1(lastknownmissilepos);

  if(!isDefined(_id_311F32609C363F70.beacon))
    level notify("sam_impact_successful", lastknownmissilepos);
  else
    level notify("sam_impact_successful", _id_311F32609C363F70.beacon.origin);

  if(isDefined(level._id_806FA1B87ED46CC1)) {
    foreach(_id_34B904EC46C07061 in level._id_806FA1B87ED46CC1) {
      if(distance(_id_980DFD4D9D8425DA, _id_34B904EC46C07061.origin) <= _id_34B904EC46C07061._id_CAACE6041804C99A)
        level thread[[_id_34B904EC46C07061._id_4DA80A9369117AC8]]();
    }
  }

  if(isDefined(missile))
    missile delete();

  _id_DCAEE0A35F84385C(_id_311F32609C363F70);

  if(istrue(_id_FACF9F5A4B563C03)) {
    level notify("last_sam_missile_launched");

    if(!_id_311F32609C363F70 isnearanyplayer(5000) || istrue(_id_ABFE04EB6DA78EB9))
      _id_311F32609C363F70._id_692FC566D26283B4 = _id_311F32609C363F70 _id_316BE6EF08C56E9B(3);
    else if(getdvarint("dvar_BC6481C5BD012176", 0) > 0)
      _id_311F32609C363F70 scripts\engine\utility::delaythread(5, ::_id_75BBC7B04A32E838);
    else
      _id_311F32609C363F70 notify("samsite_disabled");
  }
}

_id_316BE6EF08C56E9B(num) {
  missile = spawn("script_model", self gettagorigin("mg0" + num));
  missile setModel("military_missile_rig_skeleton");
  missile.angles = self gettagangles("mg0" + num);
  missile linkTo(self, "mg0" + num);
  missile thread _id_771602924D0F5FE5(self);
  return missile;
}

_id_75BBC7B04A32E838(turret) {
  if(!isDefined(turret))
    turret = self;

  turret._id_692FC766D262881A = turret _id_316BE6EF08C56E9B(1);
  turret._id_692FC666D26285E7 = turret _id_316BE6EF08C56E9B(2);
  turret._id_692FC566D26283B4 = turret _id_316BE6EF08C56E9B(3);
}

_id_841BCDB84223F84A() {
  _id_83564B777BE8CBDE();
  self.animname = "samsite";
  self useanimtree(level.scr_animtree["samsite"]);
  scripts\common\anim::anim_single([self], "fire");
}

#using_animtree("script_model");

_id_83564B777BE8CBDE() {
  level.scr_animtree["samsite"] = #animtree;
  level.scr_anim["samsite"]["fire"] = % iw9_mp_prop_samsite_launch;
}

_id_0A3881561D79E6A2(idamage) {
  return 0;
}

_id_771602924D0F5FE5(_id_FAC1DD2A5472BECE) {
  self endon("death");
  self.health = 999999;
  self setCanDamage(1);
  self setCanRadiusDamage(1);
  self._id_880A990D25B43AAA = 0;
  self._id_59A09303493E759D = 750;
  self._id_689D46E1E37CC5AD = ::_id_0A3881561D79E6A2;
  attacker = undefined;

  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);

    if(!isPlayer(attacker) || !isexplosivedamagemod(meansofdeath) && meansofdeath != "MOD_IMPACT") {
      if(isPlayer(attacker) && scripts\engine\utility::isbulletdamage(meansofdeath)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
          _id_F56FB412974C87C8 = scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback");
          attacker thread[[_id_F56FB412974C87C8]]("hitnobulletdamage");
        }
      }

      self.health = self.health + amount;
      continue;
    }

    if(!isexplosivedamagemod(meansofdeath)) {
      self.health = self.health + amount;
      continue;
    }

    if(isDefined(objweapon) && objweapon.basename == "c4_mp")
      amount = 350;

    self._id_880A990D25B43AAA = self._id_880A990D25B43AAA + amount;

    if(self._id_880A990D25B43AAA > self._id_59A09303493E759D) {
      break;
    }
  }

  self.health = 0;
  playFX(level._effect["c4_explosion_convoy"], self.origin);
  earthquake(0.35, 1, self.origin, 1024);
  org = self.origin;

  if(isDefined(self))
    self delete();

  radiusdamage(org, 350, 300, 300, attacker, "MOD_EXPLOSIVE");
}

_id_6FABA6219A5A20C0() {
  level endon("game_ended");
  self endon("death");
  head_icon = createheadicon(self);
  setheadiconimage(head_icon, "hud_icon_head_equipment_friendly");
  setheadiconmaxdistance(head_icon, 0);
  self.headicon = head_icon;

  foreach(player in level.players)
  addclienttoheadiconmask(head_icon, player);

  showheadicontoplayersinmask(head_icon);
}

_id_A969379E8D9062A8() {
  level endon("game_ended");
  self endon("death");
  turret = self;
  _id_1A8097F1A065C786 = anglestoleft(turret.angles) * 500;
  _id_1A2A7C570678A79D = anglestoright(turret.angles) * 500;
  turret settargetentity(turret.beacon);
  turret.beacon moveTo(scripts\engine\utility::getStruct("harrier_flyby_takeoff", "script_noteworthy").origin, 5);
  turret setscriptablepartstate("audio", "rotate_start");
  wait 5;
  turret setscriptablepartstate("audio", "rotate_stop");
  pos = "right";

  for(;;) {
    wait 1;
    turret thread _id_280B73E4B41FE8ED(turret);
    wait 10;
    turret thread _id_280B73E4B41FE8ED(turret);
    wait 10;
    turret thread _id_280B73E4B41FE8ED(turret);
    wait 5;
    _id_75BBC7B04A32E838(turret);
    wait 1;

    if(pos == "right") {
      turret.beacon moveTo(scripts\engine\utility::getStruct("harrier_flyby_takeoff", "script_noteworthy").origin, 5);
      pos = "left";
    } else if(pos == "left") {
      turret.beacon moveTo(scripts\engine\utility::getStruct("harrier_risetoroof_end", "script_noteworthy").origin, 5);
      pos = "right";
    }

    turret setscriptablepartstate("audio", "rotate_start");
    wait 5;
    turret setscriptablepartstate("audio", "rotate_stop");
  }
}

_id_2EFE4AE8ADF0E384(_id_E355CF7C5A5371F6, attachtag, _id_4DA80A9369117AC8, _id_CAACE6041804C99A, _id_4EEA72A373570008) {
  if(!isDefined(level._id_806FA1B87ED46CC1))
    level._id_806FA1B87ED46CC1 = [];

  _id_7998C1C302950D8D = spawn("script_model", _id_E355CF7C5A5371F6.origin);
  _id_7998C1C302950D8D._id_B5F33954B6B6C3C7 = _id_E355CF7C5A5371F6;
  _id_7998C1C302950D8D.origin = _id_E355CF7C5A5371F6.origin;
  _id_7998C1C302950D8D.angles = scripts\engine\utility::ter_op(isDefined(_id_E355CF7C5A5371F6.angles), _id_E355CF7C5A5371F6.angles, (0, 0, 0));
  _id_7998C1C302950D8D setModel("tag_origin");
  _id_7998C1C302950D8D.attachtag = scripts\engine\utility::ter_op(isDefined(attachtag), attachtag, "tag_origin");
  _id_7998C1C302950D8D._id_4DA80A9369117AC8 = _id_4DA80A9369117AC8;
  _id_7998C1C302950D8D._id_CAACE6041804C99A = _id_CAACE6041804C99A;

  if(!isDefined(_id_4EEA72A373570008))
    _id_4EEA72A373570008 = (0, 0, 0);

  _id_87E2E8F44C052486 = _id_E355CF7C5A5371F6.origin;

  if(isDefined(attachtag))
    _id_87E2E8F44C052486 = _id_E355CF7C5A5371F6 gettagorigin(attachtag);

  _id_F208EB71426FC5F5 = _id_87E2E8F44C052486 + _id_4EEA72A373570008;
  _id_7998C1C302950D8D._id_7E86C3D129AD81A8 = spawn("script_model", _id_F208EB71426FC5F5);
  _id_7998C1C302950D8D._id_7E86C3D129AD81A8.angles = scripts\engine\utility::ter_op(isDefined(_id_E355CF7C5A5371F6.angles), _id_E355CF7C5A5371F6.angles, (0, 0, 0));
  _id_7998C1C302950D8D._id_7E86C3D129AD81A8 setModel("tag_origin");
  _id_7998C1C302950D8D._id_7E86C3D129AD81A8 linkTo(_id_E355CF7C5A5371F6);
  _id_7998C1C302950D8D linkTo(_id_E355CF7C5A5371F6, _id_7998C1C302950D8D.attachtag);
  level._id_806FA1B87ED46CC1[level._id_806FA1B87ED46CC1.size] = _id_7998C1C302950D8D;
  _id_7998C1C302950D8D thread _id_3E2362D4C51EE0D6(_id_7998C1C302950D8D);
}

_id_3E2362D4C51EE0D6(_id_223D75FAD90D2F84) {
  level endon("game_ended");
  _id_223D75FAD90D2F84._id_B5F33954B6B6C3C7 endon("death");
  _id_223D75FAD90D2F84 endon("receptor_deregistered");
  _id_223D75FAD90D2F84._id_7E86C3D129AD81A8 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_HARRIER_BOSS/PLANT_BEACON", -10, "duration_medium", "show", 300, 270, 256, 180);
  waitframe();
  _id_223D75FAD90D2F84._id_7E86C3D129AD81A8 _meth_DFB78B3E724AD620(1);

  for(;;) {
    _id_223D75FAD90D2F84._id_7E86C3D129AD81A8 waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(!_id_6643FB41282F6BDB(player)) {
      player scripts\cp\cp_hud_message::tutorialprint(&"CP_HARRIER_BOSS/BEACON_NEEDED", 2);
      continue;
    }

    _id_223D75FAD90D2F84._id_7E86C3D129AD81A8 _meth_DFB78B3E724AD620(0);
    beacon = player._id_F80643446EB396D6;
    player forceplaygestureviewmodel("ges_swipe", beacon);
    player notify("planted_beacon");
    _id_AE29108278A5B8EF(player, beacon);
    waitframe();
    beacon linkTo(_id_223D75FAD90D2F84._id_B5F33954B6B6C3C7, _id_223D75FAD90D2F84.attachtag);
    beacon._id_2850387A8CB23B4F = 1;
    level notify("planted_beacon", player.origin, beacon._id_C327ADFAD89EFC23);
    wait 5;
    _id_223D75FAD90D2F84._id_7E86C3D129AD81A8 _meth_DFB78B3E724AD620(1);
  }
}