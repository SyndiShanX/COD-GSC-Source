/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\cruise_predator.gsc
*********************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "init")]]();

  level _id_EB11A8DFBD2505A0();
  level _id_10865A43B7B1243E();
  level _id_CE236B9143B76125();
  level _id_F0B48909ABA12866();
  level _id_F06E9C09AB54C2BF();
  level _id_328FD4C30CAFCCE0();
}

_id_EB11A8DFBD2505A0() {
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("cruise_predator", "invisible", 7);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("cruise_predator", "on", 8);
}

_id_10865A43B7B1243E() {
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("cruisePredator", ["allow_movement", "allow_jump", "fire", "weapon_switch", "melee", "usability", "shellshock", "offhand_weapons", "killstreaks"]);
}

_id_CE236B9143B76125() {}

_id_F0B48909ABA12866() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "registerVO"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "registerVO")]]();
}

_id_F06E9C09AB54C2BF() {
  level._effect["predator_pod_break"] = loadfx("vfx/iw8_mp/killstreak/vfx_cruise_predator_explosion.vfx");
}

_id_328FD4C30CAFCCE0() {
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("cruise_color_mp");
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("cruise_color_fog_mp");
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("cruise_intro_shipment");
}

weapongivencruisepredator(streakinfo) {
  return 1;
}

tryusecruisepredator() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("cruise_predator", self);
  return tryusecruisepredatorfromstruct(streakinfo);
}

tryusecruisepredatorfromstruct(streakinfo) {
  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle())
    return 0;

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(streakinfo, ::weapongivencruisepredator);

  if(!istrue(_id_9B1DEB5E9D32BBE3)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      streakinfo notify("killstreak_finished_with_deploy_weapon");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  if(level.gameended) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  _id_EB86A5CD1650B4AF = getdvarint("scr_cruise_3rd", 0);
  result = runcruisepredator(streakinfo.streakname, streakinfo, _id_EB86A5CD1650B4AF);

  if(!istrue(result))
    return 0;

  return 1;
}

runcruisepredator(streakname, streakinfo, _id_EB86A5CD1650B4AF) {
  self disablephysicaldepthoffieldscripting();
  _id_5FA1E1697A302583 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  heightoffset = 10000;

  if(isDefined(_id_5FA1E1697A302583))
    heightoffset = _id_5FA1E1697A302583.origin[2] + 4500;

  _id_D38145343175DDE9 = level.mapcenter;
  _id_82A6786725452F17 = getdvarint("dvar_8A48B9267ED26D75", 0);

  if(scripts\cp_mp\utility\game_utility::islargemap() || scripts\common\utility::iscp() || istrue(_id_82A6786725452F17))
    _id_D38145343175DDE9 = self.origin;

  _id_2DBC7C5305828A30 = [];
  _id_05E57C125BA3E9B8 = (0, 0, 0);
  _id_90B08876A946FDF5 = undefined;
  _id_72B9F31491F124AA = level.players;

  if(scripts\common\utility::iscp()) {
    _id_72B9F31491F124AA = level.characters;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "disable_backpack_inventory"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "disable_backpack_inventory")]](1);
  }

  foreach(player in _id_72B9F31491F124AA) {
    if(player == self) {
      continue;
    }
    if(level.teambased && player.team == self.team) {
      continue;
    }
    _id_05E57C125BA3E9B8 = _id_05E57C125BA3E9B8 + (player.origin - _id_D38145343175DDE9);
    _id_2DBC7C5305828A30[_id_2DBC7C5305828A30.size] = player;
  }

  if(isDefined(_id_05E57C125BA3E9B8) && _id_2DBC7C5305828A30.size > 0) {
    _id_90B08876A946FDF5 = vectorNormalize(_id_05E57C125BA3E9B8 / _id_2DBC7C5305828A30.size);
    _id_90B08876A946FDF5 = _id_90B08876A946FDF5 * (1, 1, 0);
  } else {
    _id_308DA9B1FED33701 = randomint(360);
    _id_90B08876A946FDF5 = anglesToForward((0, _id_308DA9B1FED33701, 0));
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "directionOverride"))
    _id_90B08876A946FDF5 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "directionOverride")]](_id_90B08876A946FDF5);

  _id_9806E3C29658CC34 = _id_D38145343175DDE9 + (0, 0, heightoffset);
  startpos = _id_9806E3C29658CC34 - _id_90B08876A946FDF5 * 3000;
  targetpos = _id_D38145343175DDE9 + (0, 0, int(heightoffset * 0.5));
  _id_B8EE7DDD93755F86 = spawn("script_model", startpos);
  _id_B8EE7DDD93755F86 setModel("wmd_vm_missile_cruise_mp");
  _id_B8EE7DDD93755F86.owner = self;
  _id_B8EE7DDD93755F86.origin = startpos;
  _id_B8EE7DDD93755F86.angles = vectortoangles(targetpos - startpos);
  _id_B8EE7DDD93755F86.type = "remote";
  _id_B8EE7DDD93755F86.team = self.team;
  _id_B8EE7DDD93755F86.entitynumber = _id_B8EE7DDD93755F86 getentitynumber();
  _id_B8EE7DDD93755F86.streakinfo = streakinfo;
  _id_B8EE7DDD93755F86.duration = 30;
  _id_B8EE7DDD93755F86._id_E684FC6E068EE951 = "pod_flying";
  self.restoreangles = self.angles;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](streakname, _id_B8EE7DDD93755F86.origin);

  level.rockets[_id_B8EE7DDD93755F86.entitynumber] = _id_B8EE7DDD93755F86;
  level.remotemissileinprogress = 1;
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(streakname, streakname + "_use", 1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_cruise_predator", self);

  result = cruisepredator_followmissilepod(_id_B8EE7DDD93755F86, targetpos, _id_EB86A5CD1650B4AF, streakinfo);
  return result;
}

cruisepredator_watchintropoddisown(streakinfo, enemytargetmarkergroup, friendlytargetmarkergroup) {
  self endon("death");
  level endon("game_ended");
  self waittill("disowned");

  if(isDefined(self)) {
    cruisepredator_detachplayerfromintro(streakinfo, enemytargetmarkergroup, friendlytargetmarkergroup);
    self delete();
  }
}

cruisepredator_detachplayerfromintro(streakinfo, enemytargetmarkergroup, friendlytargetmarkergroup) {
  _id_4084C95C19C7937A = self.owner;

  if(isDefined(_id_4084C95C19C7937A)) {
    _id_4084C95C19C7937A disablephysicaldepthoffieldscripting();
    _id_4084C95C19C7937A visionsetnakedforplayer("", 0.0);
    _id_4084C95C19C7937A cameraunlink();
    _id_4084C95C19C7937A _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("cruisePredator");
    _id_4084C95C19C7937A scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(streakinfo.streakname, "off");
    _id_4084C95C19C7937A setclientomnvar("ui_predator_missile", 0);
    _id_4084C95C19C7937A painvisionon();
    _id_4084C95C19C7937A scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    _id_4084C95C19C7937A scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("");
    _id_4084C95C19C7937A scripts\cp_mp\utility\killstreak_utility::_id_8B676F496920E2AB();
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(_id_4084C95C19C7937A, 0, 0);
  }

  streakinfo notify("killstreak_finished_with_deploy_weapon");

  if(isDefined(enemytargetmarkergroup))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(enemytargetmarkergroup);

  if(isDefined(friendlytargetmarkergroup))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(friendlytargetmarkergroup);
}

#using_animtree("script_model");

cruisepredator_followmissilepod(_id_B205CC0302DA1270, _id_8929D2C10BEB2FDE, _id_EB86A5CD1650B4AF, streakinfo) {
  _id_7B7BC27E7E8B05E2 = scripts\engine\utility::get_notetrack_time(%mp_cruise_missile_move_intro, "wingtrails");
  _id_2CF1418BD3474069 = scripts\engine\utility::get_notetrack_time(%mp_cruise_missile_move_intro, "shell_break");
  _id_9E0FA77C44B24BF9 = scripts\engine\utility::get_notetrack_time(%mp_cruise_missile_move_intro, "second_missile_thruster");
  _id_6431D9C900610F5B = scripts\engine\utility::get_notetrack_time(%mp_cruise_missile_move_intro, "anim_end");
  _id_3B5E0765D72BE907 = _id_7B7BC27E7E8B05E2;
  _id_421E2F527A382FB4 = _id_2CF1418BD3474069 - _id_7B7BC27E7E8B05E2;
  _id_169C111FAB319DA1 = _id_9E0FA77C44B24BF9 - _id_2CF1418BD3474069;
  _id_A2F273DF08E79256 = _id_6431D9C900610F5B - _id_9E0FA77C44B24BF9;
  enemytargetmarkergroup = undefined;
  friendlytargetmarkergroup = undefined;

  if(!istrue(_id_EB86A5CD1650B4AF)) {
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    _id_3B64EB40368C1450::_id_3633B947164BE4F3("cruisePredator", 0);
    scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(streakinfo.streakname, "invisible");
    self setclientomnvar("ui_predator_missile", 1);
    _id_2CD52BBC2A67B7CF = [];
    _id_FF93381949523976 = [];
    _id_2AF53266405CD5BC = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "assignTargetMarkers"))
      _id_2AF53266405CD5BC = self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "assignTargetMarkers")]](self);

    if(isDefined(_id_2AF53266405CD5BC.enemytargetmarkergroup))
      _id_2CD52BBC2A67B7CF = _id_2AF53266405CD5BC.enemytargetmarkergroup;

    if(isDefined(_id_2AF53266405CD5BC.friendlytargetmarkergroup))
      _id_FF93381949523976 = _id_2AF53266405CD5BC.friendlytargetmarkergroup;

    enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerenemy", self, _id_2CD52BBC2A67B7CF, self, 0, 1, 1);
    friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerfriendly", self, _id_FF93381949523976, self, 1, 1);
    thread scripts\cp_mp\utility\killstreak_utility::_id_D13D2A81214FBFB8("80_instant_noscale", 1);

    if(isDefined(level.mapname) && issubstr(level.mapname, "mp_shipment"))
      self visionsetnakedforplayer("cruise_intro_shipment", 0.0);

    self cameralinkTo(_id_B205CC0302DA1270, "tag_player", 1, 1);
    _id_B205CC0302DA1270 thread cruisepredator_playdofsequence(_id_9E0FA77C44B24BF9);
    self painvisionoff();
    scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
    _id_B205CC0302DA1270 thread cruisepredator_watchintropoddisown(streakinfo, enemytargetmarkergroup, friendlytargetmarkergroup);
    _id_B205CC0302DA1270 thread cruisepredator_watchownerdisownaction("disconnect");
    _id_B205CC0302DA1270 thread cruisepredator_watchownerdisownaction("joined_team");
    _id_B205CC0302DA1270 thread cruisepredator_watchownerdisownaction("joined_spectators");
    _id_B205CC0302DA1270 thread cruisepredator_watchownerdisownaction("player_fatal_death");
  }

  _id_620F959EC25A2C58 = "mp_cruise_missile_move_intro";
  _id_B205CC0302DA1270 scriptmodelplayanimdeltamotion(_id_620F959EC25A2C58);
  _id_B205CC0302DA1270 setscriptablepartstate("main_thruster", "on", 0);

  if(!istrue(_id_EB86A5CD1650B4AF))
    _id_B205CC0302DA1270 playsoundtoplayer("iw9_cruise_missile_plr_intro", self);

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_3B5E0765D72BE907);

  if(!isDefined(_id_B205CC0302DA1270))
    return 0;

  _id_B205CC0302DA1270 setscriptablepartstate("wing_trails", "on");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_421E2F527A382FB4);

  if(!isDefined(_id_B205CC0302DA1270))
    return 0;

  _id_B205CC0302DA1270._id_E684FC6E068EE951 = "pod_break";
  _id_B205CC0302DA1270 setscriptablepartstate("wing_trails", "off");
  _id_B205CC0302DA1270 setscriptablepartstate("main_thruster", "off", 0);
  playFXOnTag(scripts\engine\utility::getfx("predator_pod_break"), _id_B205CC0302DA1270, "tag_missile");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_169C111FAB319DA1);

  if(!isDefined(_id_B205CC0302DA1270))
    return 0;

  _id_B205CC0302DA1270._id_E684FC6E068EE951 = "missile_thrusters";
  _id_B205CC0302DA1270 setscriptablepartstate("sub_thruster", "on", 0);

  if(!isDefined(_id_B205CC0302DA1270) || !isDefined(self))
    return 0;

  thread cruisepredator_delayplayslamzoom(_id_B205CC0302DA1270, _id_A2F273DF08E79256 - 0.15, _id_EB86A5CD1650B4AF);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_A2F273DF08E79256 - 0.05);

  if(!isDefined(_id_B205CC0302DA1270) || !isDefined(self))
    return 0;

  thread cruisepredator_takecontrol(_id_B205CC0302DA1270, streakinfo, _id_EB86A5CD1650B4AF, enemytargetmarkergroup, friendlytargetmarkergroup);
  return 1;
}

cruisepredator_playdofsequence(_id_C21A2B0040F7613C) {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  self.owner enablephysicaldepthoffieldscripting();
  self.owner setphysicaldepthoffield(1.4, 85, 1000, 1000);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_C21A2B0040F7613C);
  self.owner setphysicaldepthoffield(0.5, 1024, 50, 50);
}

cruisepredator_takecontrol(_id_B205CC0302DA1270, streakinfo, _id_EB86A5CD1650B4AF, enemytargetmarkergroup, friendlytargetmarkergroup) {
  _id_B205CC0302DA1270 endon("death");
  self endon("disconnect");
  level endon("game_ended");
  _id_B205CC0302DA1270 setscriptablepartstate("sub_thruster", "off", 0);
  _id_3B64EB40368C1450::set("cruisePredatorUse", "allow_movement", 1);
  _id_3B64EB40368C1450::set("cruisePredatorUse", "fire", 1);
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  spawndata = spawnStruct();
  spawndata.origin = _id_B205CC0302DA1270 gettagorigin("tag_missile");
  spawndata.angles = _id_B205CC0302DA1270.angles;
  spawndata.modelname = "wmd_vm_missile_cruise_warhead_mp";
  spawndata.vehicletype = "veh_cruise_predator_mp";
  spawndata.targetname = "rcplane";
  spawndata.cannotbesuspended = 1;
  _id_EE8DA5624236DC89 = spawnStruct();
  missile = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata, _id_EE8DA5624236DC89);

  if(!isDefined(missile)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle"))
    missile[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](streakinfo.streakname);

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(missile);
  streakinfo.shots_fired++;
  missile setCanDamage(0);
  missile setotherent(self);
  missile setentityowner(self);
  missile.angles = spawndata.angles;
  missile.team = self.team;
  missile.owner = self;
  missile.streakinfo = streakinfo;
  missile.lifetime = 10;
  missile.weapon_name = "cruise_proj_mp";
  missile.enemytargetmarkergroup = enemytargetmarkergroup;
  missile.friendlytargetmarkergroup = friendlytargetmarkergroup;
  missile setscriptablepartstate("warhead_thruster", "on", 0);
  level thread scripts\cp_mp\utility\killstreak_utility::_id_EE93617532D8A679(missile, self, undefined, undefined, 1);
  missile setvehicleteam(missile.team);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
    missile[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", self, 0, 1, 50);

  missile.killcament = spawn("script_model", missile gettagorigin("tag_player"));
  missile.killcament setModel("tag_origin");
  missile.killcament linkTo(missile, "tag_player");
  missile endon("death");
  missile scripts\cp_mp\emp_debuff::set_apply_emp_callback(::cruisepredator_empapplied);
  fxent = spawn("script_model", missile gettagorigin("tag_fx"));
  fxent setModel("ks_cruise_predator_mp");
  fxent.angles = missile gettagangles("tag_fx");
  fxent.team = missile.team;
  fxent.owner = missile.owner;
  fxent.streakinfo = missile.streakinfo;
  fxent linkTo(missile, "tag_fx");
  fxent setscriptablepartstate("fake_trail", "on", 0);
  fxent setotherent(self);
  fxent thread cruisepredator_watchgameend(missile, _id_EB86A5CD1650B4AF, streakinfo);
  fxent thread cruisepredator_watchmissileinfo(missile);
  fxent thread cruisepredator_watchmissileexplosion(missile, self, missile.killcament, _id_EB86A5CD1650B4AF, enemytargetmarkergroup, friendlytargetmarkergroup);
  missile thread cruisepredator_watchownerdisownaction("disconnect");
  missile thread cruisepredator_watchownerdisownaction("joined_team");
  missile thread cruisepredator_watchownerdisownaction("joined_spectators");
  missile thread cruisepredator_watchownerdisownaction("player_fatal_death");

  if(!istrue(_id_EB86A5CD1650B4AF)) {
    self visionsetnakedforplayer("", 0.0);
    scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("");
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);

  if(!istrue(_id_EB86A5CD1650B4AF)) {
    self disablephysicaldepthoffieldscripting();
    self cameraunlink();
    thread scripts\cp_mp\utility\killstreak_utility::_id_D13D2A81214FBFB8("default");
    self cameralinkTo(missile, "tag_player", 1);
    self usevehicle(missile, 0);
    _id_FCE69F389FC06869 = "cruise_color_mp";

    if(isDefined(level.mapname) && (issubstr(level.mapname, "mp_shipment") || issubstr(level.mapname, "mp_skerries")))
      _id_FCE69F389FC06869 = "cruise_color_fog_mp";

    scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785(_id_FCE69F389FC06869);
    self.soundent = spawn("script_origin", missile.origin);
    self.soundent showonlytoplayer(self);
    self.soundent playLoopSound("iw9_cruise_missile_plr");
    scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_mp", "top", missile.lifetime, 0);
    scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(streakinfo.streakname, "on");
    self setclientomnvar("ui_predator_missile", 2);
    self setclientomnvar("ui_killstreak_health", 1);
    self setclientomnvar("ui_killstreak_countdown", gettime() + int(10000));
    self setclientomnvar("ui_predator_missiles_left", -1);

    if(_id_ECC973AD47944E1E()) {
      _id_0E8BEDFCE1E0C7D2 = scripts\cp_mp\utility\killstreak_utility::_id_44E0BD95B98288AB();
      scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785(_id_0E8BEDFCE1E0C7D2);
      scripts\cp_mp\utility\player_utility::setthermalvision(1, 12, 1500);
      scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_flir_mp", "top", missile.lifetime, 0);
    }
  }

  missile thread cruisepredator_delaymissilecollision();
  _id_610520BE555433B2 = randomintrange(1, 3);
  missile thread cruisepredator_watchtimer(self);
  waitframe();

  if(isDefined(_id_B205CC0302DA1270))
    _id_B205CC0302DA1270 delete();
}

cruisepredator_watchkillborder() {
  if(!isDefined(level.kill_border_triggers)) {
    return;
  }
  self endon("death");
  self endon("cruise_missile_explode");

  for(;;) {
    if(cruisepredator_istouchingkillborder(level.kill_border_triggers)) {
      self notify("explode");
      break;
    }

    waitframe();
  }
}

cruisepredator_istouchingkillborder(_id_3662CE7FBC059B7F) {
  _id_5BEF4D0C7C1D06A8 = 0;

  foreach(trigger in _id_3662CE7FBC059B7F) {
    if(self istouching(trigger)) {
      _id_5BEF4D0C7C1D06A8 = 1;
      break;
    }
  }

  return _id_5BEF4D0C7C1D06A8;
}

cruisepredator_delaymissilecollision() {
  self endon("death");
  self endon("cruise_missile_explode");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.75);
  self vehphys_enablecollisioncallback(1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.25);
  thread cruisepredator_watchkillborder();
}

cruisepredator_watchgameend(missile, _id_EB86A5CD1650B4AF, streakinfo) {
  missile endon("death");
  missile endon("cruise_missile_explode");
  self endon("death");
  self.owner endon("disconnect");
  level scripts\engine\utility::waittill_any_2("start_game_ended", "game_ended");
  missile notify("cruise_missile_force_eject");
  rider = self.owner;

  if(isDefined(missile.enemytargetmarkergroup))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(missile.enemytargetmarkergroup);

  if(isDefined(missile.friendlytargetmarkergroup))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(missile.friendlytargetmarkergroup);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "CPUnMarkEnemies"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "CPUnMarkEnemies")]](rider);

  if(isDefined(rider)) {
    if(!istrue(_id_EB86A5CD1650B4AF)) {
      rider cameraunlink();
      rider _meth_C0505F05660D120C();

      if(isDefined(rider.soundent)) {
        rider.soundent stoploopsound("iw9_cruise_missile_plr");
        rider.soundent delete();
      }
    }

    rider scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(streakinfo.streakname, "off");
    rider setclientomnvar("ui_predator_missile", 0);
    rider thread cruisepredator_returnplayer(streakinfo);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "removeItemFromSlot"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "removeItemFromSlot")]](rider);
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(missile);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(missile);
}

cruisepredator_watchmissileinfo(missile) {
  self endon("death");

  for(;;) {
    self.missilelastpos = missile.origin;
    self.missilelastangle = missile.angles;
    waitframe();
  }
}

cruisepredator_watchmissileexplosion(missile, rider, killcament, _id_EB86A5CD1650B4AF, enemytargetmarkergroup, friendlytargetmarkergroup) {
  missile endon("cruise_missile_force_eject");
  _id_2846210D509EDCF3 = killcament;
  _id_45292519459D6838 = undefined;
  _id_D0B12377BC0EC26F = undefined;
  streakinfo = missile.streakinfo;
  _id_DF4B15EE230BF93A = undefined;

  for(;;) {
    _id_DF4B15EE230BF93A = missile cruisepredator_waittillexplode("collision", "explode", "death", "disowned", "emp_defused", "trophy_blocked");

    if(isDefined(_id_DF4B15EE230BF93A.msg) && _id_DF4B15EE230BF93A.msg == "collision") {
      _id_895F3C282BC9FC68 = physics_getsurfacetypefromflags(_id_DF4B15EE230BF93A.param4);
      surfacetype = getsubstr(_id_895F3C282BC9FC68["name"], 9);
      _id_716D785156E6FFB2 = getdvarint("dvar_B1FA07A51B801B6B", 0);

      if(surfacetype == "glass_pane")
        continue;
    }

    break;
  }

  if(isDefined(missile)) {
    missile setscriptablepartstate("warhead_thruster", "off", 0);
    missile notify("cruise_missile_explode");
  }

  if(isDefined(enemytargetmarkergroup))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(enemytargetmarkergroup);

  if(isDefined(friendlytargetmarkergroup))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(friendlytargetmarkergroup);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "CPUnMarkEnemies"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "CPUnMarkEnemies")]](rider);

  if(isDefined(self)) {
    self setscriptablepartstate("fake_trail", "off", 0);
    thread _id_1A20D385B2F41E0E();
    _id_45292519459D6838 = self.missilelastpos;
    _id_D0B12377BC0EC26F = self.missilelastangle;

    if(isDefined(rider) && !istrue(_id_EB86A5CD1650B4AF)) {
      rider cameraunlink();
      rider _meth_C0505F05660D120C();
    }

    if(isDefined(missile)) {
      scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(missile);
      scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(missile);
    }

    if(!isDefined(_id_DF4B15EE230BF93A) || _id_DF4B15EE230BF93A.msg != "emp_defused" && _id_DF4B15EE230BF93A.msg != "trophy_blocked") {
      _id_35BBF066F50AC582 = 600;
      _id_5D28F39073721E59 = "MOD_EXPLOSIVE";
      _id_23F8C678BD9D023E = "cruise_proj_mp";

      if(isDefined(rider)) {
        _id_F9FB154DDE29912B = isDefined(_id_DF4B15EE230BF93A) && _id_DF4B15EE230BF93A.msg == "disowned";

        if(!istrue(_id_F9FB154DDE29912B))
          self radiusdamage(_id_45292519459D6838, _id_35BBF066F50AC582, 1000, 1000, rider, _id_5D28F39073721E59, _id_23F8C678BD9D023E);

        players = scripts\common\utility::playersinsphere(_id_45292519459D6838, _id_35BBF066F50AC582);

        foreach(player in players) {
          if(player scripts\cp_mp\utility\player_utility::_isalive() && scripts\cp_mp\utility\player_utility::playersareenemies(player, rider)) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound"))
              level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](player, "stat_2F4FCDB5F53AF5CA", undefined, 1);
          }
        }
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "artillery_earthQuake"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "artillery_earthQuake")]](_id_45292519459D6838);

    thread cruisepredator_handlevfxstates(_id_DF4B15EE230BF93A);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "eventRecord"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "eventRecord")]](_id_45292519459D6838);

  if(isDefined(rider)) {
    rider thread cruisepredator_watchkills(_id_DF4B15EE230BF93A);

    if(!istrue(_id_EB86A5CD1650B4AF)) {
      if(isDefined(rider.soundent)) {
        rider.soundent stoploopsound("iw9_cruise_missile_plr");
        rider.soundent delete();
      }

      rider scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(streakinfo.streakname, "off");
      rider setclientomnvar("ui_predator_missile", 0);

      if(_id_ECC973AD47944E1E())
        rider scripts\cp_mp\utility\player_utility::setthermalvision(0);

      _id_FC0043E95242D5CB = "killstreak_static";
      _id_EE006CF398BCD8FD = 0.4;
      _id_06EA9CF1222359E6 = 0.6;
      _id_C8FE6E3CA9715960 = 0.05;

      if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
        _id_FC0043E95242D5CB = undefined;
        _id_EE006CF398BCD8FD = 0.05;
      }

      rider thread cruisepredator_startfadecamtransition(_id_EE006CF398BCD8FD, _id_06EA9CF1222359E6, _id_C8FE6E3CA9715960, _id_FC0043E95242D5CB);
      rider playlocalsound("iw9_cruise_missile_exp_static");
      rider earthquakeforplayer(0.3, 3.5, rider.origin, 100);
      rider setclientomnvar("ui_hud_shake", 1);
      rider playrumbleonpositionforclient("artillery_rumble", rider.origin);
      rider thread cruisepredator_returnplayer(streakinfo, 1);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("cruise_predator", "removeItemFromSlot"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("cruise_predator", "removeItemFromSlot")]](rider);
}

_id_1A20D385B2F41E0E() {
  level endon("game_ended");
  minimapid = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective"))
    minimapid = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("icon_minimap_cruisemissile", self.team, undefined, 1, undefined, "icon_large");

  wait 2;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](minimapid);
}

cruisepredator_cameramove(targetpos, startpos) {
  self moveTo(targetpos, 0.2, 0, 0.05);
  wait 0.15;
  self moveTo(targetpos + vectorNormalize(startpos - targetpos) * 24, 2);
}

cruisepredator_returnplayer(streakinfo, exploded) {
  self endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "disable_backpack_inventory"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "disable_backpack_inventory")]](0);

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](streakinfo);

  level thread scripts\cp_mp\utility\killstreak_utility::restorekillstreakplayerangles(self);

  if(istrue(exploded))
    wait 0.5;

  scripts\cp_mp\utility\killstreak_utility::_id_8B676F496920E2AB();
  scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("");
  self painvisionon();
  scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
  _id_3B64EB40368C1450::_id_588F2307A3040610("cruisePredator");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("cruisePredatorUse");
  streakinfo notify("killstreak_finished_with_deploy_weapon");
  scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
}

cruisepredator_watchtimer(rider) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10.1);
  self notify("explode", self.origin);
}

cruisepredator_watchexplosiondistance(rider, _id_B205CC0302DA1270) {
  self endon("death");
  rider endon("disconnect");
  level endon("game_ended");
  _id_2FC7B90001702E5C = [self, _id_B205CC0302DA1270];
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 0, 0);

  for(;;) {
    _id_801D37E9149BBC7C = anglesToForward(self.angles);
    startpos = self gettagorigin("tag_missile");
    rider.lastknownmissilepos = startpos;
    rider.lastknownmissileangles = self.angles;
    _id_43BE0526C21A84EC = getdvarint("scr_cruise_impact_dist", 50);

    if(isDefined(self.missilebooston))
      _id_43BE0526C21A84EC = getdvarint("scr_cruise_impact_boost_dist", 150);

    endpos = startpos + _id_801D37E9149BBC7C * _id_43BE0526C21A84EC;
    trace = scripts\engine\trace::sphere_trace(startpos, endpos, 5, _id_2FC7B90001702E5C, contentoverride);

    if(isDefined(trace["hittype"]) && trace["hittype"] != "hittype_none") {
      if(isDefined(trace["position"])) {
        rider.lastknowntrace = trace;
        self notify("missile_close_explode", trace["position"]);
        break;
      }
    }

    wait 0.05;
  }
}

cruisepredator_watchmissileboost(rider) {
  rider endon("disconnect");
  self endon("death");
  level endon("game_ended");
  rider notifyonplayercommand("missile_boost_on", "+attack");

  for(;;) {
    rider waittill("missile_boost_on");
    self.missilebooston = 1;
    break;
  }
}

cruisepredator_watchownerdisownaction(action) {
  self endon("death");
  self endon("disowned");
  level endon("game_ended");
  _id_4084C95C19C7937A = self.owner;
  _id_4084C95C19C7937A waittill(action);
  self notify("disowned");
}

cruisepredator_startexplodecamtransition() {
  scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("killstreak_slamzoom");
  wait 0.1;
  scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("");
}

cruisepredator_startfadecamtransition(_id_EE006CF398BCD8FD, _id_06EA9CF1222359E6, _id_C8FE6E3CA9715960, _id_2007EDE6118D6B9F) {
  self endon("disconnect");

  if(!isDefined(_id_EE006CF398BCD8FD))
    _id_EE006CF398BCD8FD = 0.5;

  if(!isDefined(_id_06EA9CF1222359E6))
    _id_06EA9CF1222359E6 = 0.5;

  if(!isDefined(_id_C8FE6E3CA9715960))
    _id_C8FE6E3CA9715960 = 0.05;

  if(isDefined(_id_2007EDE6118D6B9F)) {
    scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785(_id_2007EDE6118D6B9F);
    wait(_id_06EA9CF1222359E6);
    scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("");
  } else {
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, _id_EE006CF398BCD8FD);
    wait(_id_06EA9CF1222359E6);
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, _id_C8FE6E3CA9715960);
  }
}

cruisepredator_shakerider(_id_23250AC0C394B3C8) {
  self endon("disconnect");
  counter = 0;

  while(counter < _id_23250AC0C394B3C8) {
    self playrumbleonpositionforclient("damage_light", self.origin);
    counter = counter + 0.05;
    wait 0.05;
  }
}

cruisepredator_waittillexplode(_id_E127AF0EAB592C1A, _id_E127AE0EAB5929E7, _id_E127AD0EAB5927B4, _id_E127AC0EAB592581, _id_E127AB0EAB59234E, _id_E127AA0EAB59211B) {
  ent = spawnStruct();

  if(isDefined(_id_E127AF0EAB592C1A))
    thread waittill_explodestring(_id_E127AF0EAB592C1A, ent);

  if(isDefined(_id_E127AE0EAB5929E7))
    thread waittill_explodestring(_id_E127AE0EAB5929E7, ent);

  if(isDefined(_id_E127AD0EAB5927B4))
    thread waittill_explodestring(_id_E127AD0EAB5927B4, ent);

  if(isDefined(_id_E127AC0EAB592581))
    thread waittill_explodestring(_id_E127AC0EAB592581, ent);

  if(isDefined(_id_E127AB0EAB59234E))
    thread waittill_explodestring(_id_E127AB0EAB59234E, ent);

  if(isDefined(_id_E127AA0EAB59211B))
    thread waittill_explodestring(_id_E127AA0EAB59211B, ent);

  ent waittill("returned", msg, param1, param2, param3, param4, param5, param6, param7, param8);
  ent notify("die");
  _id_DF4B15EE230BF93A = spawnStruct();
  _id_DF4B15EE230BF93A.msg = msg;
  _id_DF4B15EE230BF93A.param1 = param1;
  _id_DF4B15EE230BF93A.param2 = param2;
  _id_DF4B15EE230BF93A.param3 = param3;
  _id_DF4B15EE230BF93A.param4 = param4;
  _id_DF4B15EE230BF93A.param5 = param5;
  _id_DF4B15EE230BF93A.param6 = param6;
  _id_DF4B15EE230BF93A.param7 = param7;
  _id_DF4B15EE230BF93A.param8 = param8;
  return _id_DF4B15EE230BF93A;
}

waittill_explodestring(msg, ent) {
  self endon("death");
  ent endon("die");
  self waittill(msg, param1, param2, param3, param4, param5, param6);
  ent notify("returned", msg, param1, param2, param3, param4, param5, param6);
}

cruisepredator_handlevfxstates(_id_DF4B15EE230BF93A) {
  self endon("death");
  self unlink();

  if(!isDefined(_id_DF4B15EE230BF93A) || _id_DF4B15EE230BF93A.msg == "explode" || _id_DF4B15EE230BF93A.msg == "disowned" || _id_DF4B15EE230BF93A.msg == "emp_defused" || _id_DF4B15EE230BF93A.msg == "trophy_blocked") {
    self setscriptablepartstate("air_explosion", "on", 0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.2);
    self delete();
  }

  _id_303D9FA226476812 = (0, 0, 1);
  _id_5E8EDE0EF6D7F3AB = _id_DF4B15EE230BF93A.param6;
  self.angles = vectortoangles(_id_5E8EDE0EF6D7F3AB);
  _id_75FB158DC4A7D84D = vectordot(_id_5E8EDE0EF6D7F3AB, _id_303D9FA226476812);

  if(_id_75FB158DC4A7D84D >= 0.7)
    self setscriptablepartstate("ground_explosion", "on", 0);
  else
    self setscriptablepartstate("air_explosion", "on", 0);

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  self delete();
}

cruisepredator_watchkills(_id_DF4B15EE230BF93A) {
  self endon("disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

  if(isDefined(self) && isDefined(self.recentkillcount)) {
    if(self.recentkillcount >= 1)
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("cruise_predator", "cruise_predator_hit_target", 1);
    else
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("cruise_predator", "cruise_predator_miss_target", 1);
  }
}

cruisepredator_delayplayslamzoom(_id_B205CC0302DA1270, _id_74B5B12BB6514385, _id_EB86A5CD1650B4AF) {
  self endon("disconnect");
  _id_B205CC0302DA1270 endon("disowned");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);

  if(!istrue(_id_EB86A5CD1650B4AF)) {
    scripts\cp_mp\utility\killstreak_utility::_id_26D001518CF98785("killstreak_slamzoom");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.2);
    wait 0.2;
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0);
  }
}

cruisepredator_empapplied(data) {
  if(isDefined(self))
    self notify("emp_defused");
}

_id_ECC973AD47944E1E() {
  return scripts\cp_mp\utility\game_utility::isnightmap() || level.mapname == "mp_grandprix_pm_2";
}