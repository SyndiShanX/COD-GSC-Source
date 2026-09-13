/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\ballmode.gsc
***********************************************/

main() {
  if(getDvar("g_mapname") == "mp_background") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 480);
    scripts\mp\utility\game::setovertimelimitdvar(120);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 5);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_704789086C9AD943(scripts\mp\utility\game::getgametype(), 1);
  }

  setspecialloadout();
  updategametypedvars();
  level.teambased = 1;
  level.vehiclegod = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.ontimelimit = ::ontimelimit;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerconnect = ::onplayerconnect;
  level.bypassclasschoicefunc = scripts\mp\class::alwaysgamemodeclass;
  level.nosuspensemusic = 1;
  level.requiredplayercountoveride = 1;
  level.requiredplayercount["allies"] = getdvarint("ballmode_requiredplayercount", 3);
  level.requiredplayercount["axis"] = getdvarint("ballmode_requiredplayercount", 3);

  if(getdvarint("dvar_CD7A289C3A33CEDA", 0) != 0)
    level.onplayerkilled = ::onhotfootplayerkilled;

  game["dialog"]["offense_obj"] = "iw9_gmst_anno_uktl_gsoa";
  game["dialog"]["defense_obj"] = "iw9_gmst_anno_uktl_gsoa";
  level.testtdmanywhere = getdvarint("scr_tdmanywhere", 0);
  level.tdmanywhere_dropheight = getdvarfloat("dvar_0C692D2A11DD6615", 1000);
  level.tdmanywhere_perpenoffset = getdvarfloat("dvar_631C58033F43C2DC", 2048);
  level.tdmanywhere_distoffset = getdvarfloat("dvar_F314048C87AE28AA", 4092);
  level._id_832F3E2F27BC167F = getdvarint("dvar_F4485E63F712EEE1", 0);

  if(istrue(level.testtdmanywhere))
    scripts\cp_mp\parachute::initparachutedvars();

  if(scripts\mp\utility\game::matchmakinggame())
    level.shouldgamelobbyremainintact = ::shouldgamelobbyremainintact;

  level._id_15C7E6EC178FEEF1 = 1;
  level._id_227023E744A288B6 = "veh9_atv_boost";
  scripts\cp_mp\utility\script_utility::registersharedfunc(level._id_227023E744A288B6, "flippedEnd", ::_id_AC6A3BDE1C50BF84);
  _id_37092055E9712F79::main();
  scripts\cp_mp\vehicles\vehicle::_id_66AB4FB2175555E1("veh9_atv_boost");
  _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_spawned", ::onplayerspawned);
  scripts\engine\utility::add_fx("ball_contact", "vfx/iw9/level/mp_futbol/vfx_futbol_soccerball_contact.vfx");
  scripts\engine\utility::add_fx("ball_contact_pulse", "vfx/iw9/level/mp_futbol/vfx_futbol_soccerball_contact_pulse.vfx");
  scripts\engine\utility::add_fx("grenade_contact", "vfx/iw9/level/mp_futbol/vfx_futbol_pickup_grenade_active.vfx");
  scripts\engine\utility::add_fx("player_rammed", "vfx/iw9/level/mp_futbol/vfx_futbol_atv_ram_explosion.vfx");
  scripts\engine\utility::add_fx("player_respawn", "vfx/iw9/level/mp_futbol/vfx_futbol_atv_ram_respawn.vfx");
  scripts\engine\utility::add_fx("grenade_launch", "vfx/iw9/level/mp_futbol/vfx_futbol_atv_grenade_launch.vfx");
  thread _id_2EF7BEF336791C1E();
  thread _id_0EAE183E660ED1BD();
  thread _id_B98A63C3E6F4D6DB();
  setDvar("cg_vehiclecameraoverridepolarclamping", 1);
}

_id_B98A63C3E6F4D6DB() {
  level endon("game_ended");
  _id_04400D6A8D876BD9 = getdvarint("dvar_72DF5F8FCEFC0BAD", 30);
  wait(_id_04400D6A8D876BD9);
  setnojipscore(1, 1);
  setnojiptime(1, 1);
  level.nojip = 1;
}

_id_9BAA17DB0BDDC192(entity) {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(objid == -1) {
    return;
  }
  _id_53480B10269770A5 = 100;
  objective_setlabel(objid, "");
  objective_setplayintro(objid, 0);
  objective_setpings(objid, 1);
  objective_setzoffset(objid, _id_53480B10269770A5);
  objective_icon(objid, "icon_waypoint_enemy_goal");
  objective_setbackground(objid, 1);
  objective_state(objid, "current");
  objective_position(objid, entity.origin + (0, 0, _id_53480B10269770A5));
  objective_setshowdistance(objid, 0);
  scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(objid, entity);
}

_id_FB4FCF1CECF14944() {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(objid == -1) {
    return;
  }
  _id_53480B10269770A5 = 100;
  objective_setlabel(objid, "");
  objective_setplayintro(objid, 0);
  objective_setpings(objid, 1);
  objective_setzoffset(objid, _id_53480B10269770A5);
  objective_icon(objid, "icon_waypoint_soccer_ball");
  objective_setbackground(objid, 1);
  objective_state(objid, "current");
  objective_onentity(objid, level.ball);
  objective_setshowdistance(objid, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);
}

vehiclespawn_getspawndata(loc) {
  spawndata = spawnStruct();
  spawndata.origin = loc.origin;
  spawndata.angles = loc.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.showheadicon = 1;
  spawndata.vehicleoverride = scripts\engine\utility::ter_op(self.team == "axis", "veh9_mil_lnd_atv_physics_mp_boostball_al", "veh9_mil_lnd_atv_physics_mp_boostball_las");
  return spawndata;
}

_id_D7522FF35BA39906() {
  self notify("respawn");
  self._id_EA02A8BFCFDE7C4B = 1;
  position = spawnStruct();
  position.origin = self.origin;
  position.angles = self.angles;
  spawndata = vehiclespawn_getspawndata(position);
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(level._id_227023E744A288B6, spawndata);
  vehicle._id_A8F4BB03B366AA80 = 1;
  vehicle.godmode = 1;
  vehicle._id_22AA4AA0CF0AA6BB = 1;
  vehicle.lastpushtime = -1;
  vehicle.rider = self;

  if(level._id_E94DE5572E12C3FB)
    thread entervehicle(vehicle);
  else
    entervehicle(vehicle);
}

entervehicle(vehicle) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  _id_C641ED06D8042061 = spawnStruct();

  if(level._id_E94DE5572E12C3FB) {
    while(!istrue(_id_C641ED06D8042061.success)) {
      waitframe();
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", self, _id_C641ED06D8042061, 1);
    }
  } else
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", self, _id_C641ED06D8042061, 1);

  if(getdvarint("dvar_F5E40A9AA678AFCD", 0)) {
    vehicle._id_35FD13041DDE93E8 = "v004";
    vehicle _meth_788D3C14D6B4BA6B("v004");
  } else if(!isDefined(vehicle._id_35FD13041DDE93E8)) {
    if(self.team == "axis") {
      vehicle._id_35FD13041DDE93E8 = "v008";
      vehicle _meth_788D3C14D6B4BA6B("v008");
    } else {
      vehicle._id_35FD13041DDE93E8 = "v009";
      vehicle _meth_788D3C14D6B4BA6B("v009");
    }
  }

  _id_65091E17847072C9 = getdvarint("ballmode_pulse", 0);

  if(self.team == "axis")
    self.vehicle setscriptablepartstate("tail_lights", "green", 1);
  else
    self.vehicle setscriptablepartstate("tail_lights", "yellow", 1);

  if(_id_65091E17847072C9) {
    thread _id_263274274F7871FA();
    thread _id_57751AB79ABF8F20();
    thread _id_72B3E6D160929C0A();
  }

  thread _id_C484EBBDF856FFEC();

  if(!istrue(level._id_47697CB343760D89)) {
    if(istrue(level._id_315F3774D5792BEE)) {
      _id_AC6CA28A64718193 = "outline_nodepth_blue";
      enemyteam = "outline_nodepth_red";
      scripts\mp\utility\outline::outlineenableforteam(self, self.team, _id_AC6CA28A64718193, "level_script", [self]);
      scripts\mp\utility\outline::outlineenableforteam(self.vehicle, self.team, _id_AC6CA28A64718193, "level_script", [self]);
      scripts\mp\utility\outline::outlineenableforteam(self, enemyteam(self.team), enemyteam, "level_script");
      scripts\mp\utility\outline::outlineenableforteam(self.vehicle, enemyteam(self.team), enemyteam, "level_script");
    } else {
      _id_B2B80C62FF341E87 = scripts\engine\utility::ter_op(self.team == "allies", "outline_nodepth_yellow", "outline_nodepth_green");
      scripts\mp\utility\outline::outlineenableforteam(self, self.team, _id_B2B80C62FF341E87, "level_script", [self]);
      scripts\mp\utility\outline::outlineenableforteam(self.vehicle, self.team, _id_B2B80C62FF341E87, "level_script", [self]);
      scripts\mp\utility\outline::outlineenableforteam(self, enemyteam(self.team), _id_B2B80C62FF341E87, "level_script");
      scripts\mp\utility\outline::outlineenableforteam(self.vehicle, enemyteam(self.team), _id_B2B80C62FF341E87, "level_script");
    }
  }

  thread _id_32DF9962EEA79205();
  thread _id_31FC5B37975D1293(self);
}

_id_C484EBBDF856FFEC() {
  while(!isDefined(level.ball))
    waitframe();

  if(istrue(self.pers["lookingAtBall"])) {
    self _meth_522FB0CBB445CDC8(level.ball);
    self setclientomnvar("ballmode_cameramode", 1);
    self.pers["lookingAtBall"] = 1;
  } else {
    self _meth_522FB0CBB445CDC8();
    self setclientomnvar("ballmode_cameramode", 0);
    self.pers["lookingAtBall"] = 0;
  }
}

_id_AC6A3BDE1C50BF84(vehicle, _id_DD9707A466EFA528) {
  if(isDefined(vehicle) && istrue(_id_DD9707A466EFA528)) {
    position = vehicle.origin + (0, 0, 100);
    angles = (0, vehicle.angles[1], 0);
    vehicle vehicle_teleport(position, angles);
  }
}

_id_690BE95DE2E8C072() {
  if(!isDefined(self.pers["lookingAtBall"]) || !isDefined(level.ball) || !isDefined(self.vehicle)) {
    return;
  }
  if(!self.pers["lookingAtBall"]) {
    self _meth_522FB0CBB445CDC8(level.ball);
    self setclientomnvar("ballmode_cameramode", 1);
    self.pers["lookingAtBall"] = 1;
  } else {
    self _meth_522FB0CBB445CDC8();
    self setclientomnvar("ballmode_cameramode", 0);
    self.pers["lookingAtBall"] = 0;
  }
}

_id_D9702C5B7D3EAA95() {
  self endon("disconnect");
  self notifyonplayercommand("toggleLookAt", "+melee_zoom");

  for(;;) {
    self waittill("toggleLookAt");
    _id_690BE95DE2E8C072();
    wait 0.5;
  }
}

onplayerspawned(params) {
  self.plotarmor = 1;

  if(level._id_832F3E2F27BC167F > 0) {
    level._id_832F3E2F27BC167F = level._id_832F3E2F27BC167F - 1;
    return;
  }

  scripts\mp\battlechatter_mp::disablebattlechatter(self);
  _id_D7522FF35BA39906();
  self clearsoundsubmix("iw9_mp_soccer_goal", 1);
  self clearsoundsubmix("deaths_door_mp");
  self clearsoundsubmix("iw9_mp_killcam", 2);
  self clearclienttriggeraudiozone(2);
  thread _id_CB63E733BD0D9F0B();
  thread _id_7331BA007CEA2319();
  thread time();
  thread _id_D9702C5B7D3EAA95();
  thread _id_9E64420982A86219();
  _id_4DB9734EFFB2DD9D = spawnfx(scripts\engine\utility::getfx("player_respawn"), self.origin);
  triggerfx(_id_4DB9734EFFB2DD9D);
  _id_887D4CB1410C4FFC = scripts\mp\teams::lookupcurrentoperator(self.team);

  if(_id_887D4CB1410C4FFC == "neymar_eastern" || _id_887D4CB1410C4FFC == "messi_western" || _id_887D4CB1410C4FFC == "pogba_western")
    self._id_023511319CEC8F63 = 1;

  if(self._id_023511319CEC8F63 && getdvarint("dvar_17A42017D84DF7EC", 0)) {
    self playSound("equip_codball_shockstick_pickup");
    self._id_A9FBDE0565FC4BE7 = 1;
    self setclientomnvar("ballmode_grenade", self._id_A9FBDE0565FC4BE7);
  }

  scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(self.pers["goals"]))
    scripts\mp\utility\stats::setextrascore0(self.pers["goals"]);
}

time() {
  level endon("game_ended");
  self endon("disconnect");
  self._id_3C11F592093DC36D = 0;

  for(;;) {
    waitframe();
    self._id_3C11F592093DC36D = self._id_3C11F592093DC36D + level.framedurationseconds;
  }
}

_id_E1EF76F2CB1B17A1() {
  self endon("disconnect");
  self.isstunned = 1;
  self allowmovement(0);
  self.vehicle setscriptablepartstate("stunned", "stunned", 1);
  self earthquakeforplayer(0.3, 0.6, self.origin, 5000);
  self.vehicle vehicle_settopspeedforward(self.normalspeed * getdvarfloat("dvar_1576E2EA08AA2848", 0.8));
  scripts\mp\hud_message::showsplash("ballmode_stunned_by_player");
  wait 1.0;
  self.vehicle vehicle_settopspeedforward(self.normalspeed);
  self.vehicle setscriptablepartstate("stunned", "not_stunned", 1);
  self allowmovement(1);
  self.isstunned = 0;
}

_id_B81DDB79CB822F7A(_id_B81DDB79CB822F7A) {
  if(_id_B81DDB79CB822F7A) {
    return;
  }
  self _meth_D5592214ACC99425();
  return;
}

_id_9E64420982A86219() {
  self endon("disconnect");
  slot = scripts\mp\equipment::getdefaultslot("equip_shockstick_ballmode");
  scripts\mp\equipment::giveequipment("equip_shockstick_ballmode", slot);
  self notifyonplayercommand("ballmode_preview_grenade", "+attack");
  self notifyonplayercommand("ballmode_throw_grenade", "-attack");

  for(;;) {
    self waittill("ballmode_preview_grenade");

    if(!istrue(self.isstunned) && istrue(self._id_A9FBDE0565FC4BE7) && isalive(self))
      _id_B81DDB79CB822F7A(1);

    self waittill("ballmode_throw_grenade");
    _id_B81DDB79CB822F7A(0);

    if(istrue(self.isstunned)) {
      waitframe();
      continue;
    }

    if(!istrue(self._id_A9FBDE0565FC4BE7)) {
      waitframe();
      continue;
    }

    if(!isalive(self)) {
      waitframe();
      continue;
    }

    _id_60151E580078E160 = getdvarfloat("dvar_02E6A0A6EE3B2CD6", 40);
    _id_F0CDE6BBA09C4AB6 = getdvarvector("dvar_73B69837141AE856", (0, 0, 40));
    _id_8367267663479C02 = getdvarfloat("dvar_90221071EBBF785E", 1500);
    _id_7A65053818BA8FAB = getdvarvector("dvar_3EA5F4B035285D67", (0, 0, 150));
    self._id_A9FBDE0565FC4BE7 = 0;
    self setclientomnvar("ballmode_grenade", self._id_A9FBDE0565FC4BE7);
    _id_3C70A7175FBFA3FC = anglesToForward(self _meth_AA015A529E61C67D());
    _id_9DFDF50ED960E7F3 = anglesToForward(self.angles);
    _id_CF329C44C802E680 = self.vehicle.origin + _id_9DFDF50ED960E7F3 * _id_60151E580078E160 + _id_F0CDE6BBA09C4AB6;

    if(vectordot(_id_3C70A7175FBFA3FC, _id_9DFDF50ED960E7F3) < 0)
      _id_CF329C44C802E680 = self.vehicle.origin - _id_9DFDF50ED960E7F3 * _id_60151E580078E160 + _id_F0CDE6BBA09C4AB6;

    grenade = scripts\mp\utility\weapon::_launchgrenade("shock_stick_mp_ballmode", _id_CF329C44C802E680, _id_3C70A7175FBFA3FC * _id_8367267663479C02 + _id_7A65053818BA8FAB, 1, undefined, undefined);
    self playSound("weap_codball_shockstick_fire");
    triggerfx(spawnfx(scripts\engine\utility::getfx("grenade_launch"), _id_CF329C44C802E680));
    grenade scripts\engine\utility::waittill_any_timeout_1(5, "missile_stuck");
    position = grenade.origin;
    playFX(scripts\engine\utility::getfx("grenade_contact"), position);

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      player earthquakeforplayer(0.3, 0.2, position, 1000);

      if(player.team == self.team) {
        continue;
      }
      if(length(player.origin - position) < 150) {
        player thread _id_E1EF76F2CB1B17A1();
        scripts\mp\utility\points::_id_0366980B6A8796AE("stat_89E428EE14238868");
      }
    }

    waitframe();
    grenade delete();
  }
}

_id_E69BA41CCDF770AF(_id_0979E96006D8A4E2) {
  level endon("game_ended");
  pickup = spawnscriptable("ballmode_grenade_pickup", _id_0979E96006D8A4E2.origin + (0, 0, 30));
  pickup setscriptablepartstate("grenade_pickup", "ready", 1);

  for(;;) {
    _id_373C494D2156CD01 = undefined;

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      if(istrue(player._id_A9FBDE0565FC4BE7)) {
        continue;
      }
      if(lengthsquared(player.origin - pickup.origin) < 3600) {
        _id_373C494D2156CD01 = player;
        break;
      }
    }

    if(!isDefined(_id_373C494D2156CD01)) {
      waitframe();
      continue;
    }

    pickup setscriptablepartstate("grenade_pickup", "inactive", 1);
    _id_373C494D2156CD01 playSound("equip_codball_shockstick_pickup");
    _id_373C494D2156CD01._id_A9FBDE0565FC4BE7 = 1;
    _id_373C494D2156CD01 setclientomnvar("ballmode_grenade", _id_373C494D2156CD01._id_A9FBDE0565FC4BE7);
    wait(getdvarint("ballmode_grenade_respawn", 20));
    pickup setscriptablepartstate("grenade_pickup", "ready", 1);
    playsoundatpos(_id_0979E96006D8A4E2.origin, "equip_codball_shockstick_spawn");
  }
}

_id_2EF7BEF336791C1E() {
  level endon("game_ended");
  waitframe();
  level._id_3E5A26826D8B8E2F = getEnt("goal_axis", "targetname");
  level._id_3E5A26826D8B8E2F.team = "axis";
  level._id_A970FBBF4C65F18C = getEnt("goal_allies", "targetname");
  level._id_A970FBBF4C65F18C.team = "allies";
  level._id_36B1C8C99A6B27EF = scripts\engine\utility::getStruct("ball_respawn", "targetname");
  _id_1A8A97698664C7C9::_id_2E68AB6566B199CB(level._id_3E5A26826D8B8E2F.team, scripts\mp\gamescore::_getteamscore(level._id_3E5A26826D8B8E2F.team));
  _id_1A8A97698664C7C9::_id_2E68AB6566B199CB(level._id_A970FBBF4C65F18C.team, scripts\mp\gamescore::_getteamscore(level._id_A970FBBF4C65F18C.team));
  _id_AFC0CF2F0E71EAE3 = scripts\engine\utility::getStructArray("ballmode_pickup", "targetname");
  level thread _id_E69BA41CCDF770AF(_id_AFC0CF2F0E71EAE3[0]);
  level thread _id_E69BA41CCDF770AF(_id_AFC0CF2F0E71EAE3[1]);
  level thread _id_E69BA41CCDF770AF(_id_AFC0CF2F0E71EAE3[2]);
  level thread _id_E69BA41CCDF770AF(_id_AFC0CF2F0E71EAE3[3]);
  wait 5;
  level.ball = spawn("script_model", level._id_36B1C8C99A6B27EF.origin);
  level.ball setModel("art_stadium_ball");
  level.ball.targetname = "ball";
  level.ball physicslaunchserver((0, 0, 0), (0, 0, 0), -1000);
  level.ball thread _id_26A3F9262C0E61C1();
  _id_9BAA17DB0BDDC192(level._id_3E5A26826D8B8E2F);
  _id_9BAA17DB0BDDC192(level._id_A970FBBF4C65F18C);
  _id_FB4FCF1CECF14944();

  if(isDefined(game["ballmodeTimePassed"])) {
    level.starttime = gettime();
    _id_B2FF82EC901486E4 = _func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_timelimit");
    level.watchdvars[_id_B2FF82EC901486E4].value = game["ballmodeTimePassed"] / 1000;
    setDvar(_id_B2FF82EC901486E4, game["ballmodeTimePassed"] / 1000);
  }

  _id_1FBF6AAA31163FEB = undefined;

  for(;;) {
    if(level._id_3E5A26826D8B8E2F istouching(level.ball)) {
      _id_1FBF6AAA31163FEB = level._id_3E5A26826D8B8E2F.team;
      break;
    }

    if(level._id_A970FBBF4C65F18C istouching(level.ball)) {
      _id_1FBF6AAA31163FEB = level._id_A970FBBF4C65F18C.team;
      break;
    }

    waitframe();
  }

  level notify("ballmode_goal_scored");
  _id_75CA6E1E31FA03A8(_id_1FBF6AAA31163FEB);

  foreach(player in level.players) {
    player._id_9835CDC5507AFA4F = 0;
    player earthquakeforplayer(0.4, 2.5, level.ball.origin, 5000);
    _id_D4EAF53B4475969E(player, _id_1FBF6AAA31163FEB);

    if(player.team == _id_1FBF6AAA31163FEB) {
      if(isDefined(level.ball._id_9B593F980E1DF35B) && player == level.ball._id_9B593F980E1DF35B.player) {
        level.ball._id_9B593F980E1DF35B.player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_32F5ADDA6DEA5496");
        player scripts\mp\utility\stats::incpersstat("goals", 1);
        player scripts\mp\utility\stats::setextrascore0(player.pers["goals"]);

        if(istrue(level.ball._id_9B593F980E1DF35B._id_909DD2932BF61C47))
          level.ball._id_9B593F980E1DF35B.player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_622E70D79766B33F");

        player.pers["hasDoneAnyCombat"] = 1;
        continue;
      }

      if(isDefined(level.ball._id_FD1B69DAEA740E45) && isDefined(level.ball._id_FD1B69DAEA740E45[player.guid])) {
        player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_503431BE2973FC9B");
        player.pers["hasDoneAnyCombat"] = 1;
        player.pers["assists"] = player.pers["assists"] + 1;
      }

      player scripts\mp\utility\points::_id_0366980B6A8796AE("stat_7F2B80912012133F");
    }
  }

  scripts\mp\gamelogic::pausetimer();
  game["ballmodeTimePassed"] = scripts\mp\gamelogic::gettimeremaining();
  level._id_18250DF1DD55DA52 = 1;
  wait 3;
  scripts\mp\gamescore::giveteamscoreforobjective(_id_1FBF6AAA31163FEB, 1, 1, undefined, 1);
  _id_1A8A97698664C7C9::_id_2E68AB6566B199CB(level._id_3E5A26826D8B8E2F.team, scripts\mp\gamescore::_getteamscore(level._id_3E5A26826D8B8E2F.team));
  _id_1A8A97698664C7C9::_id_2E68AB6566B199CB(level._id_A970FBBF4C65F18C.team, scripts\mp\gamescore::_getteamscore(level._id_A970FBBF4C65F18C.team));

  if(game["status"] == "overtime")
    level thread scripts\mp\gamelogic::endgame(_id_1FBF6AAA31163FEB, game["end_reason"]["score_limit_reached"]);
  else {
    scripts\mp\gamelogic::pausetimer();
    game["ballmodeTimePassed"] = scripts\mp\gamelogic::gettimeremaining();
  }
}

_id_75CA6E1E31FA03A8(_id_200A113A1E7807EB) {
  if(_id_200A113A1E7807EB == "axis")
    scripts\engine\utility::exploder("goal_2");
  else
    scripts\engine\utility::exploder("goal_1");

  setmusicstate("goal_scored");
  playsoundatpos(level.ball.origin, "mp_codball_goal_whistle");
  playsoundatpos(level.ball.origin, "mp_codball_goal_cheer");
  thread _id_D5FE07F36853C957();
}

_id_D5FE07F36853C957() {
  _id_7AB5B649FA408138::_id_4E8BA327EB12540C(level.players, "iw9_mp_soccer_goal", 2);
}

_id_76D65F0B5902D51D() {
  if(self._id_1F5985D661E980FE == 0)
    return 0;

  _id_D51D711DD370439C = getdvarint("ballmode_pulse", 0);
  return _id_D51D711DD370439C && self._id_3C11F592093DC36D >= self._id_1F5985D661E980FE && self._id_3C11F592093DC36D <= self._id_1F5985D661E980FE + self._id_8C9DA67CF413DF2E;
}

_id_81905C4905CBCB80(vehicle, ball, normal, _id_EFCE983B772A6F22, _id_251C5472955825A4) {
  if(isDefined(vehicle.lastpushtime) && vehicle.rider._id_3C11F592093DC36D < vehicle.lastpushtime + 0.2) {
    return;
  }
  if(isDefined(vehicle.lastpushtime)) {}

  vehicle.lastpushtime = vehicle.rider._id_3C11F592093DC36D;
  _id_76D65F0B5902D51D = _id_76D65F0B5902D51D();
  _id_745A7280C169244D = 1;
  _id_07F6F2FF9DC45CED = 1;

  if(_id_76D65F0B5902D51D) {
    _id_745A7280C169244D = getdvarint("dvar_EB8AE893BDADFA96", 3);
    _id_07F6F2FF9DC45CED = _id_745A7280C169244D / 2;
  }

  _id_B671DDA1C1164EC4 = vehicle vehicle_getvelocity();
  _id_2547EEC1179557E3 = ball.velocity;
  _id_558115A08635DE95 = _id_B671DDA1C1164EC4 - _id_2547EEC1179557E3;
  _id_CE2277814A41A6A2 = scripts\engine\math::remap(clamp(length(_id_558115A08635DE95), 0, 1000), 0, 1000, 0, 1);
  _id_EB3B42597661A6EA = scripts\engine\math::remap(_id_CE2277814A41A6A2, 0, 1, 20, 60);
  _id_AD3DC842BED328B9 = _id_EB3B42597661A6EA * _id_07F6F2FF9DC45CED;

  if(ball.velocity[2] > 40.0)
    _id_AD3DC842BED328B9 = _id_AD3DC842BED328B9 / 3.0;

  ball physics_applyimpulse(ball.origin, (0, 0, _id_AD3DC842BED328B9));
  normal = vectorNormalize((normal[0], normal[1], normal[2] * 0.8));
  _id_5A4ED8BED236876A = scripts\engine\math::remap(_id_CE2277814A41A6A2, 0, 1, 100, 600);
  _id_09E8D543BA58E308 = normal * _id_5A4ED8BED236876A;
  ball physics_applyimpulse(ball.origin, _id_09E8D543BA58E308 * _id_EFCE983B772A6F22 * _id_745A7280C169244D);

  if(_id_76D65F0B5902D51D) {
    playFX(scripts\engine\utility::getfx("ball_contact_pulse"), _id_251C5472955825A4);
    _id_508A666F8C32E510(ball, _id_5A4ED8BED236876A, 0, 1);
  } else {
    playFX(scripts\engine\utility::getfx("ball_contact"), _id_251C5472955825A4);
    _id_508A666F8C32E510(ball, _id_5A4ED8BED236876A, 0, 0);
  }

  if(_id_76D65F0B5902D51D)
    vehicle.rider earthquakeforplayer(0.3, 0.6, ball.origin, 5000);
  else
    vehicle.rider earthquakeforplayer(0.15, 0.3, ball.origin, 5000);
}

_id_508A666F8C32E510(ball, _id_E4571CC8915E45FB, _id_54A18641EE8161C5, pulse) {
  _id_9E3BD18D45E1DAA4 = "mp_codball_ball_impact";
  surfacetype = "_grass";
  _id_A78160B865206AE9 = "_light";
  soundalias = "mp_codball_ball_impact_grass_light";
  _id_AA3F1450E82E8306 = 0;
  _id_FB21AAA624AB594D = 200;
  _id_453830ECCD9EA0CF = 500;

  if(_id_54A18641EE8161C5 > 2 || _id_54A18641EE8161C5 < 0) {
    return;
  }
  switch (_id_54A18641EE8161C5) {
    case 0:
      surfacetype = "_atv";

      if(pulse)
        surfacetype = "_atv_pulse";

      break;
    case 1:
      surfacetype = "_grass";
      break;
    case 2:
      surfacetype = "_wall";
      break;
  }

  if(_id_E4571CC8915E45FB >= _id_453830ECCD9EA0CF)
    _id_A78160B865206AE9 = "_heavy";
  else if(_id_E4571CC8915E45FB >= _id_FB21AAA624AB594D)
    _id_A78160B865206AE9 = "_medium";

  soundalias = _id_9E3BD18D45E1DAA4 + surfacetype + _id_A78160B865206AE9;

  if(isDefined(soundalias) && isDefined(ball))
    ball playSound(soundalias);
}

_id_CB63E733BD0D9F0B() {
  self endon("disconnect");

  for(;;) {
    if(!isDefined(self.vehicle)) {
      waitframe();
      continue;
    }

    self.vehicle waittill("collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum);

    if(!isDefined(ent) || !isDefined(ent.owner)) {
      continue;
    }
    if(isDefined(ent.targetname) && ent.targetname == "ball") {
      _id_81905C4905CBCB80(self.vehicle, ent, normal, 1, position);
      continue;
    }

    isentityvehicle = isDefined(ent) && ent.classname == "script_vehicle";
    _id_9DA4991E43437A9E = isDefined(ent.owner) && ent.owner.team == self.team;

    if(isentityvehicle && !_id_9DA4991E43437A9E && istrue(self._id_9835CDC5507AFA4F)) {
      _id_2B047F029FF53AD4 = vectorNormalize(position - self.vehicle.origin);
      _id_F00CAD494ACE11F1 = vectorNormalize(anglesToForward(self.vehicle.angles));
      _id_9913FD1FFEA99C33 = vectordot(_id_2B047F029FF53AD4, _id_F00CAD494ACE11F1);
      _id_D23ED04594864BEA = acos(_id_9913FD1FFEA99C33);

      if(_id_D23ED04594864BEA < 60) {
        if(!isDefined(self._id_A9BCF4E8440E11BE["ballmode_rammed_player"]) || gettime() - self._id_A9BCF4E8440E11BE["ballmode_rammed_player"] > 100) {
          scripts\mp\utility\points::_id_0366980B6A8796AE("stat_BF39416A176595AA");
          self._id_A9BCF4E8440E11BE["ballmode_rammed_player"] = gettime();
        }

        self.pers["hasDoneAnyCombat"] = 1;
        self.pers["lastRamTime"] = scripts\mp\teams::_id_19300ABFBB10928B();
        ent.owner _id_B81DDB79CB822F7A(0);
        ent.owner.plotarmor = 0;
        ent.owner dodamage(ent.owner.maxhealth, ent.owner.origin, self, self.vehicle, "MOD_EXPLOSIVE", self.vehicle.objweapon, "torso_upper");
        ent.owner scripts\mp\hud_message::showsplash("ballmode_rammed_by_player");
        _id_5A60B3AFC04B3E22 = spawnfx(scripts\engine\utility::getfx("player_rammed"), ent.origin);
        playsoundatpos(ent.origin, "veh9_dmg_mil_lnd_atv_codball_explode");
        triggerfx(_id_5A60B3AFC04B3E22);
        playrumbleonposition("grenade_rumble", ent.origin);
        earthquake(0.5, 1.0, ent.origin, 500);
      }
    }
  }
}

_id_26A3F9262C0E61C1() {
  level endon("game_ended");
  _id_63AB34B4A76E8F86 = 0.1;
  _id_7856E907F2D37675 = 1;
  _id_64F13C589A594107 = 3;
  _id_38F5340B182B64F0 = 0;
  _id_653BF22A4D053B24 = 0;
  _id_4BE5096CA36000AF = 200;
  _id_C59CE7533110CAFF = 500;
  _id_179AED0864D2F9CD = 1;
  _id_9D498E7C2FCA6288 = 1;
  _id_530C26140DF7C1F8 = 2;
  self physics_registerforcollisioncallback();

  for(;;) {
    self waittill("collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum);
    _id_895F3C282BC9FC68 = physics_getsurfacetypefromflags(flag1);
    surfacetype = getsubstr(_id_895F3C282BC9FC68["name"], 9);

    if(normalspeed > _id_63AB34B4A76E8F86 && surfacetype != "metal_car") {
      if(normalspeed > _id_64F13C589A594107)
        _id_38F5340B182B64F0 = _id_C59CE7533110CAFF;
      else if(normalspeed > _id_7856E907F2D37675)
        _id_38F5340B182B64F0 = _id_4BE5096CA36000AF;
      else
        _id_38F5340B182B64F0 = _id_653BF22A4D053B24;

      _id_179AED0864D2F9CD = _id_9D498E7C2FCA6288;

      if(surfacetype != "grass_short")
        _id_179AED0864D2F9CD = _id_530C26140DF7C1F8;

      _id_508A666F8C32E510(self, _id_38F5340B182B64F0, _id_179AED0864D2F9CD, 0);
      waitframe();
    }
  }
}

_id_F16883296ADE7F2F(v, _id_1AD2A33FB3C88895) {
  return vectordot(v, _id_1AD2A33FB3C88895) / vectordot(_id_1AD2A33FB3C88895, _id_1AD2A33FB3C88895);
}

_id_7331BA007CEA2319() {
  self endon("disconnect");

  for(;;) {
    if(!isDefined(level.ball)) {
      waitframe();
      continue;
    }

    if(!isDefined(self.vehicle)) {
      waitframe();
      continue;
    }

    _id_C02ECDADD14A8875 = level.ball.origin - self.vehicle.origin;
    normal = vectorNormalize(_id_C02ECDADD14A8875);
    forward = anglesToForward(self.vehicle.angles);
    left = anglestoleft(self.vehicle.angles);
    up = anglestoup(self.vehicle.angles);
    _id_68E32EDB50F84A85 = _id_F16883296ADE7F2F(_id_C02ECDADD14A8875, forward * 90);
    _id_C99486F221182123 = _id_F16883296ADE7F2F(_id_C02ECDADD14A8875, left * 60);
    _id_89E70A63B116955B = _id_F16883296ADE7F2F(_id_C02ECDADD14A8875, up * 85);
    _id_11FA10620A425B56 = sqrt(_id_68E32EDB50F84A85 * _id_68E32EDB50F84A85 + _id_C99486F221182123 * _id_C99486F221182123 + _id_89E70A63B116955B * _id_89E70A63B116955B);

    if(_id_11FA10620A425B56 < 1.0) {
      if(!isDefined(level.ball._id_FD1B69DAEA740E45))
        level.ball._id_FD1B69DAEA740E45 = [];

      if(!isDefined(level.ball._id_FD1B69DAEA740E45[self.guid])) {
        scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F87DEDF6AA32E256");
        level.ball._id_FD1B69DAEA740E45[self.guid] = self;
      }

      if(istrue(self._id_9835CDC5507AFA4F)) {
        if(!isDefined(self._id_A9BCF4E8440E11BE["ballmode_rammed_ball"]) || gettime() - self._id_A9BCF4E8440E11BE["ballmode_rammed_ball"] > 100) {
          scripts\mp\utility\points::_id_0366980B6A8796AE("stat_0DEA729E842329FE");
          self._id_A9BCF4E8440E11BE["ballmode_rammed_ball"] = gettime();
        }
      }

      self.pers["hasDoneAnyCombat"] = 1;
      self.pers["lastTouchTime"] = scripts\mp\teams::_id_19300ABFBB10928B();
      goalent = undefined;

      if(self.team == "allies")
        goalent = level._id_3E5A26826D8B8E2F;
      else
        goalent = level._id_A970FBBF4C65F18C;

      if(isDefined(goalent) && (!isDefined(level.ball._id_9B593F980E1DF35B) || level.ball._id_9B593F980E1DF35B != self)) {
        _id_579B57F0F6FF2CF2 = goalent.origin - level.ball.origin;
        _id_E5B0EC0E97542A26 = length(_id_579B57F0F6FF2CF2);
        _id_474316929FF377FE = vectordot(level.ball.velocity, _id_579B57F0F6FF2CF2);

        if(_id_E5B0EC0E97542A26 <= 500 && _id_474316929FF377FE > 0) {
          _id_0C81D07983E9FB9B = vectorNormalize(level.ball.velocity);
          _id_6B36173E1C9D0057 = level.ball.origin + _id_0C81D07983E9FB9B * _id_E5B0EC0E97542A26;
          trace = scripts\engine\trace::sphere_trace(level.ball.origin, _id_6B36173E1C9D0057, 28, [self, self.vehicle, level.ball]);

          if(trace["fraction"] > 0.99)
            thread _id_3EA35B42C5E9419E();
        }
      }

      _id_9B593F980E1DF35B = spawnStruct();
      _id_9B593F980E1DF35B.player = self;

      if(_id_68E32EDB50F84A85 < 0) {
        velocity = self.vehicle vehicle_getvelocity();

        if(vectordot(velocity, forward) < 0)
          _id_9B593F980E1DF35B._id_909DD2932BF61C47 = 1;
      }

      level.ball._id_9B593F980E1DF35B = _id_9B593F980E1DF35B;
      thread _id_53EB14EEDD8C8CF8();
      _id_81905C4905CBCB80(self.vehicle, level.ball, normal, 1, level.ball.origin);
    }

    waitframe();
  }
}

_id_53EB14EEDD8C8CF8() {
  self notify("ballmode_watch_for_assist");
  level endon("game_ended");
  self endon("disconnect");
  self endon("ballmode_watch_for_assist");
  wait(level._id_1E09D32EAB14E224);
  level.ball._id_FD1B69DAEA740E45[self.guid] = undefined;
}

_id_3EA35B42C5E9419E() {
  self notify("ballmode_watch_for_save");
  level endon("game_ended");
  level endon("ballmode_goal_scored");
  self endon("disconnect");
  self endon("ballmode_watch_for_save");
  wait 1;
  scripts\mp\utility\points::_id_0366980B6A8796AE("stat_24EA0BE5EFEC97C5");
  self.pers["hasDoneAnyCombat"] = 1;
}

_id_263274274F7871FA() {
  self endon("disconnect");
  self endon("respawn");
  level endon("game_ended");
  self._id_1F5985D661E980FE = 0;
  self._id_7E44AEF4FDC0E5D3 = 100;
  self._id_8C9DA67CF413DF2E = getdvarint("dvar_8839756EE5E73455", 1);
  self.normalspeed = getdvarint("dvar_B41AEC456A71399A", 35);
  _id_09381CA324B30F76 = getdvarint("dvar_B8EE638DB3D40FA6", 50);
  _id_C02646F657BD26C0 = getdvarfloat("dvar_B7615C14184146DD", 8.0);

  if(self._id_023511319CEC8F63 && getdvarint("dvar_BEA2F654590E1855", 0))
    _id_C02646F657BD26C0 = getdvarint("dvar_BEA2F654590E1855", 0);

  if(self._id_023511319CEC8F63 && getdvarint("dvar_21590FE81942FF74", 0))
    self.normalspeed = getdvarint("dvar_21590FE81942FF74", 0);

  self.vehicle setscriptablepartstate("pulse", "default", 1);
  _id_913AE0D782D6DAFA = 0;
  self.vehicle vehicle_settopspeedforward(self.normalspeed);

  for(;;) {
    if(!isDefined(self.vehicle)) {
      waitframe();
      continue;
    }

    if(!scripts\mp\flags::gameflag("prematch_done")) {
      waitframe();
      continue;
    }

    if(istrue(self.isstunned)) {
      waitframe();
      continue;
    }

    self._id_7E44AEF4FDC0E5D3 = self._id_7E44AEF4FDC0E5D3 + _id_C02646F657BD26C0 * level.framedurationseconds;

    if(self._id_7E44AEF4FDC0E5D3 > 100.0)
      self._id_7E44AEF4FDC0E5D3 = 100.0;

    self setclientomnvar("ballmode_pulse_recharge", self._id_7E44AEF4FDC0E5D3 / 100.0);

    if(self._id_7E44AEF4FDC0E5D3 >= 100) {
      if(!_id_913AE0D782D6DAFA) {
        self.vehicle setscriptablepartstate("pulse", "pulse_ready", 1);
        self playlocalsound("mp_codball_pulse_ready_plr");
        self playSound("mp_codball_pulse_ready_npc", self, self);
        _id_913AE0D782D6DAFA = 1;
      }

      if(self jumpbuttonPressed()) {
        self._id_7E44AEF4FDC0E5D3 = 0;
        self setclientomnvar("ballmode_pulse_recharge", self._id_7E44AEF4FDC0E5D3 / 100.0);
        self._id_1F5985D661E980FE = self._id_3C11F592093DC36D;
        self._id_5018479A0F0CA9C2 = self._id_48D12DE553C8EEAD;
        _id_913AE0D782D6DAFA = 0;
        self.vehicle vehicle_settopspeedforward(_id_09381CA324B30F76);
        self.vehicle setscriptablepartstate("pulse", "pulsing", 1);
        self playlocalsound("mp_codball_pulse_plr");
        self playSound("mp_codball_pulse_npc", self, self);
        self earthquakeforplayer(0.15, 0.5, self.origin, 5000);
        scripts\mp\utility\points::_id_0366980B6A8796AE("stat_78BF5D029B54A6D9");
        self.pers["hasDoneAnyCombat"] = 1;

        for(x = 0; x < 5; x++) {
          self.vehicle _meth_E0201404A8B6F664(anglesToForward(self.vehicle.angles), 55, 0);
          wait 0.1;

          if(!isDefined(self.vehicle)) {
            break;
          }
        }

        wait 0.5;

        if(!isDefined(self.vehicle)) {
          break;
        }

        self.vehicle vehicle_settopspeedforward(self.normalspeed);
        self.vehicle setscriptablepartstate("pulse", "default", 1);
      }
    }

    waitframe();
  }
}

_id_57751AB79ABF8F20() {
  self endon("disconnect");
  self endon("respawn");
  self.vehicle setscriptablepartstate("max_speed", "default", 1);
  _id_99BB1F0DB99012F0 = 0;
  self._id_48D12DE553C8EEAD = 0;
  _id_3815E60BA5DDC269 = 0;

  for(;;) {
    if(!isDefined(self.vehicle)) {
      waitframe();
      continue;
    }

    velocity = self.vehicle vehicle_getvelocity();

    if(length(velocity) > 530 && vectordot(anglesToForward(self.vehicle.angles), velocity) > 0) {
      self._id_48D12DE553C8EEAD = 1;

      if(!_id_99BB1F0DB99012F0) {
        _id_99BB1F0DB99012F0 = 1;

        if(getdvarint("dvar_3D45B5BAD11C6FF1", 1))
          self.vehicle setscriptablepartstate("max_speed", "max_speed", 1);
      }
    }

    if(length(velocity) < 100) {
      if(_id_99BB1F0DB99012F0) {
        _id_99BB1F0DB99012F0 = 0;
        self.vehicle setscriptablepartstate("max_speed", "default", 1);
        self._id_48D12DE553C8EEAD = 0;
      }
    }

    waitframe();
    _id_3815E60BA5DDC269 = _id_3815E60BA5DDC269 + level.framedurationseconds;

    if(_id_3815E60BA5DDC269 >= 0.25) {
      _id_3815E60BA5DDC269 = _id_3815E60BA5DDC269 - 0.25;

      if(!self._id_48D12DE553C8EEAD) {
        if(_id_99BB1F0DB99012F0) {
          _id_99BB1F0DB99012F0 = 0;
          self.vehicle setscriptablepartstate("max_speed", "default", 1);
        }
      }

      self._id_48D12DE553C8EEAD = 0;
    }
  }
}

_id_72B3E6D160929C0A() {
  self endon("disconnect");
  self endon("respawn");
  self._id_9835CDC5507AFA4F = 0;
  self.vehicle setscriptablepartstate("ramming", "default", 1);

  for(;;) {
    if(!isDefined(self.vehicle)) {
      waitframe();
      continue;
    }

    _id_76D65F0B5902D51D = _id_76D65F0B5902D51D();

    if(!_id_76D65F0B5902D51D) {
      waitframe();
      continue;
    }

    if(istrue(self._id_5018479A0F0CA9C2)) {
      self.vehicle setscriptablepartstate("ramming", "ramming", 1);

      if(!istrue(level._id_18250DF1DD55DA52))
        self._id_9835CDC5507AFA4F = 1;
    }

    wait(self._id_8C9DA67CF413DF2E);
    self.vehicle setscriptablepartstate("ramming", "default", 1);
    self._id_9835CDC5507AFA4F = 0;
    waitframe();
  }
}

_id_31FC5B37975D1293(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");

  if(!istrue(level._id_31FC5B37975D1293)) {
    return;
  }
  while(isDefined(player.vehicle) && !istrue(player.vehicle.isdestroyed))
    waitframe();

  player.plotarmor = 0;
  player dodamage(player.maxhealth, player.origin);
}

_id_32DF9962EEA79205() {
  level endon("game_ended");
  self endon("respawn");
  _id_7C1608ABED261E5C = self.vehicle;
  self waittill("death_or_disconnect");
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(_id_7C1608ABED261E5C, "driver", self);
  scripts\cp_mp\vehicles\vehicle::vehicle_death(_id_7C1608ABED261E5C);
}

_id_0EAE183E660ED1BD(ball) {
  for(;;) {
    if(isDefined(level.ball) && isDefined(level.ball.origin)) {
      if(!isDefined(level.ball._id_E5D77BF46A926594))
        level.ball._id_E5D77BF46A926594 = level.ball.origin;

      level.ball.velocity = (level.ball.origin - level.ball._id_E5D77BF46A926594) / level.framedurationseconds;
      level.ball._id_E5D77BF46A926594 = level.ball.origin;
    }

    waitframe();
  }
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_war_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("scr_war_promode", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");
  level.scorelimitoverride = 1;
  level.roundenddelay = 3.0;

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    _id_2B21F2FBE8DD5C6E = game["attackers"];
    _id_8D904E28CF14C8AE = game["defenders"];
    game["attackers"] = _id_8D904E28CF14C8AE;
    game["defenders"] = _id_2B21F2FBE8DD5C6E;
  }

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/WAR");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/WAR_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/WAR_HINT");
  }

  if(isDefined(level.initspawnsoverridefunc))
    [[level.initspawnsoverridefunc]]();
  else
    initspawns();

  _id_641E4E9B12A99632::inittankspawns();

  if(getdvarint("dvar_CD7A289C3A33CEDA", 0) != 0)
    thread monitorhotfoot();
}

updategametypedvars() {
  level._id_0180810732F27F05 = scripts\mp\utility\dvars::dvarintvalue("postGoalCooldown", 8, 0, 10);
  level._id_1E09D32EAB14E224 = scripts\mp\utility\dvars::dvarintvalue("assistTouchTime", 10, 0, 30);
  level._id_47697CB343760D89 = scripts\mp\utility\dvars::dvarintvalue("disablePlayerOutlines", 0, 0, 1);
  level._id_315F3774D5792BEE = scripts\mp\utility\dvars::dvarintvalue("useRedAndBluePlayerOutlines", 0, 0, 1);
  level._id_B00236A60FD803D0 = scripts\mp\utility\dvars::dvarintvalue("useRedAndBlueGoalScoreSplashes", 1, 0, 1);
  level._id_0D9F9B5E6CE431DA = scripts\mp\utility\dvars::dvarintvalue("useTeamNamesOnGoalScoreSplashes", 0, 0, 1);
  level._id_E94DE5572E12C3FB = scripts\mp\utility\dvars::dvarintvalue("forceRetryOnVehicleOccupancyFailed", 1, 0, 1);
  level._id_31FC5B37975D1293 = scripts\mp\utility\dvars::dvarintvalue("listenForVehicleExit", 1, 0, 1);
  _id_0FD32F08E72B657F::updatecommongametypedvars();
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  if(getdvarint("t10", 0) > 0)
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  else if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()))
    scripts\mp\spawnlogic::setactivespawnlogic("BigTDM", "Crit_Frontline");
  else
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");

  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  _id_2FD93EA689E77097 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", _id_2FD93EA689E77097);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  _id_29D9D2428185616D = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  _id_3A5288F40C8BE099 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", _id_29D9D2428185616D);
  scripts\mp\spawnlogic::registerspawnset("fallback", _id_3A5288F40C8BE099);

  if(istrue(level.testtdmanywhere)) {
    x = getdvarfloat("scr_tdmanywhere_centerx", randomfloatrange(-4096, 4096));
    y = getdvarfloat("scr_tdmanywhere_centery", randomfloatrange(-4096, 4096));
    z = getdvarfloat("scr_tdmanywhere_centerz", randomfloatrange(0, 512));
    level.mapcenter = (x, y, z);
    tdmanywhere_debugshowlocs();
  } else {
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
  }
}

getspawnpoint() {
  spawnteam = self.pers["team"];
  spawnpoint = undefined;

  if(spawnteam == game["attackers"]) {
    scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
  } else {
    scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
  }

  return spawnpoint;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("kill");

  if(!istrue(level.testtdmanywhere)) {
    return;
  }
  self setplayerangles(vectortoangles(level.mapcenter - self.origin));
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
}

ontimelimit() {
  winner = scripts\mp\gamescore::gethighestscoringteam();

  if(game["status"] == "overtime")
    level thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["time_limit_reached"]);
  else if(winner == "tie") {
    foreach(player in level.players)
    player scripts\mp\hud_message::showsplash("ballmode_overtime_banner");

    game["status"] = "overtime";
    level.starttime = gettime();
    _id_B2FF82EC901486E4 = _func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_timelimit");
    level.watchdvars[_id_B2FF82EC901486E4].value = getdvarint("dvar_0E55EF5D10527388");
    setDvar(_id_B2FF82EC901486E4, getdvarint("dvar_0E55EF5D10527388"));
  } else
    level thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["time_limit_reached"]);
}

tdmanywhere_debugshowlocs() {
  thread scripts\mp\utility\debug::drawsphere(level.mapcenter, 128, 100, (0, 1, 0));

  if(!isDefined(level.tdmanywherefrontline))
    waitframe();

  _id_CC015915D647FBDF = level.tdmanywherefrontline.anchordir * level.tdmanywhere_distoffset;
  _id_C1D9D45C8845EB82 = level.tdmanywherefrontline.anchorrt * level.tdmanywhere_perpenoffset;
  thread scripts\mp\utility\debug::drawline(level.mapcenter, level.mapcenter + _id_CC015915D647FBDF, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::drawline(level.mapcenter, level.mapcenter - _id_CC015915D647FBDF, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::drawline(level.mapcenter + _id_CC015915D647FBDF, level.mapcenter + _id_CC015915D647FBDF + _id_C1D9D45C8845EB82, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter + _id_CC015915D647FBDF, level.mapcenter + _id_CC015915D647FBDF - _id_C1D9D45C8845EB82, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter - _id_CC015915D647FBDF, level.mapcenter - _id_CC015915D647FBDF + _id_C1D9D45C8845EB82, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(level.mapcenter - _id_CC015915D647FBDF, level.mapcenter - _id_CC015915D647FBDF - _id_C1D9D45C8845EB82, 1000, (0, 0, 1));
}

enemyteam(_id_AC6CA28A64718193) {
  if(_id_AC6CA28A64718193 == "allies")
    return "axis";
  else
    return "allies";
}

monitorhotfoot() {
  level endon("game_ended");
  level.outlinedplayers = [];
  level.hotfootabsloops = 0;
  _id_3B5803E733581858 = 0;
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    foreach(player in level.players) {
      if(!isDefined(player.hotfootlastposition)) {
        player.hotfootdisttraveledsq = 0;
        player.hotfootlastposition = player.origin;
        player.abshotfootlastposition = player.origin;
      }

      player.hotfootdisttraveledsq = player.hotfootdisttraveledsq + distancesquared(player.hotfootlastposition, player.origin);
      player.hotfootlastposition = player.origin;
    }

    _id_3B5803E733581858 = _id_3B5803E733581858 + level.framedurationseconds;

    if(_id_3B5803E733581858 > 3.0) {
      if(level.hotfootabsloops >= 2) {
        level.hotfootabsloops = 0;

        foreach(player in level.players) {
          if(!isDefined(player.abshotfootlastposition))
            player.abshotfootlastposition = player.origin;

          player.forceabshotfoot = distancesquared(player.abshotfootlastposition, player.origin) < 4225;
          player.abshotfootlastposition = player.origin;
        }
      }

      foreach(player in level.players) {
        entnum = player getentitynumber();
        _id_AC6CA28A64718193 = player.pers["team"];
        enemyteam = enemyteam(_id_AC6CA28A64718193);

        if(isalive(player) && (istrue(player.forceabshotfoot) || player.hotfootdisttraveledsq < 4225 && !istrue(player.hotfootreset))) {
          player.forceabshotfoot = 0;

          if(!isDefined(level.outlinedplayers[entnum])) {
            level.outlinedplayers[entnum] = player;
            player.outlineidfriend = scripts\mp\utility\outline::outlineenableforteam(player, _id_AC6CA28A64718193, "outline_nodepth_orange", "level_script");
            player.outlineidenemy = scripts\mp\utility\outline::outlineenableforteam(player, enemyteam, "outline_nodepth_red", "level_script");
            player scripts\mp\utility\outline::_hudoutlineviewmodelenable("outlinefill_nodepth_orange", 0);
          }
        } else {
          if(isalive(player))
            player.hotfootreset = 0;

          player.forceabshotfoot = 0;

          if(isDefined(level.outlinedplayers[entnum])) {
            scripts\mp\utility\outline::outlinedisable(player.outlineidfriend, player);
            scripts\mp\utility\outline::outlinedisable(player.outlineidenemy, player);
            player scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
            player.outlineidfriend = undefined;
            player.outlineidenemy = undefined;
            level.outlinedplayers[entnum] = undefined;
          }
        }

        player.hotfootdisttraveledsq = 0;
      }

      _id_3B5803E733581858 = 0;
    }

    level.hotfootabsloops++;
    waitframe();
  }
}

onhotfootplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  entnum = self getentitynumber();

  if(isDefined(level.outlinedplayers[entnum])) {
    scripts\mp\utility\outline::outlinedisable(self.outlineidfriend, self);
    scripts\mp\utility\outline::outlinedisable(self.outlineidenemy, self);
    self.outlineidfriend = undefined;
    self.outlineidenemy = undefined;
    level.outlinedplayers[entnum] = undefined;
  }

  self.hotfootreset = 1;
}

shouldgamelobbyremainintact() {
  _id_18A3FAB290E780C2 = int(game["teamScores"]["axis"]);
  _id_43A41488C3C487DF = int(game["teamScores"]["allies"]);
  _id_F9C7AAE8C6ACD600 = _id_18A3FAB290E780C2 - _id_43A41488C3C487DF;
  return _id_F9C7AAE8C6ACD600 < 10;
}

onplayerconnect(player) {
  player scripts\mp\class::_id_A16868D4DCD81A4B();
  player.pers["gamemodeLoadout"] = level._id_D4867C54E1AE2315;
  player allowspectateallteams(0);
  player._id_A9BCF4E8440E11BE = [];
  player._id_023511319CEC8F63 = 0;
}

setspecialloadout() {
  level._id_D4867C54E1AE2315["loadoutPrimary"] = "iw9_me_fists";
  level._id_D4867C54E1AE2315["loadoutPrimaryAttachment"] = "none";
  level._id_D4867C54E1AE2315["loadoutPrimaryAttachment2"] = "none";
  level._id_D4867C54E1AE2315["loadoutPrimaryCamo"] = "none";
  level._id_D4867C54E1AE2315["loadoutPrimaryReticle"] = "none";
  level._id_D4867C54E1AE2315["loadoutPrimaryVariantID"] = 0;
  level._id_D4867C54E1AE2315["loadoutSecondary"] = "none";
  level._id_D4867C54E1AE2315["loadoutSecondaryAttachment"] = "none";
  level._id_D4867C54E1AE2315["loadoutSecondaryAttachment2"] = "none";
  level._id_D4867C54E1AE2315["loadoutSecondaryCamo"] = "none";
  level._id_D4867C54E1AE2315["loadoutSecondaryReticle"] = "none";
  level._id_D4867C54E1AE2315["loadoutSecondaryVariantID"] = 0;
  level._id_D4867C54E1AE2315["loadoutEquipment"] = "specialty_null";
  level._id_D4867C54E1AE2315["loadoutOffhand"] = "none";
  level._id_D4867C54E1AE2315["loadoutStreakType"] = "assault";
  level._id_D4867C54E1AE2315["loadoutKillstreak1"] = "none";
  level._id_D4867C54E1AE2315["loadoutKillstreak2"] = "none";
  level._id_D4867C54E1AE2315["loadoutKillstreak3"] = "none";
  level._id_D4867C54E1AE2315["loadoutPerks"] = [];
  level._id_D4867C54E1AE2315["loadoutGesture"] = "playerData";
}

_id_D4EAF53B4475969E(player, _id_1FBF6AAA31163FEB) {
  if(!isDefined(player) || !isDefined(player.team) || !isDefined(_id_1FBF6AAA31163FEB)) {
    return;
  }
  _id_FABF84450735DD93 = undefined;
  _id_B2B80C62FF341E87 = undefined;

  if(level._id_0D9F9B5E6CE431DA)
    _id_FABF84450735DD93 = _id_1FBF6AAA31163FEB;
  else if(player.team == _id_1FBF6AAA31163FEB)
    _id_FABF84450735DD93 = "friendly";
  else
    _id_FABF84450735DD93 = "enemy";

  if(!level._id_B00236A60FD803D0)
    _id_B2B80C62FF341E87 = scripts\engine\utility::ter_op(_id_1FBF6AAA31163FEB == "allies", "yellow", "green");
  else if(player.team == _id_1FBF6AAA31163FEB)
    _id_B2B80C62FF341E87 = "blue";
  else
    _id_B2B80C62FF341E87 = "red";

  splashname = scripts\engine\utility::_id_996B01CD49D0128D(["ballmode_goal_score", _id_FABF84450735DD93, _id_B2B80C62FF341E87], "_");
  player scripts\mp\hud_message::showsplash(splashname);
}