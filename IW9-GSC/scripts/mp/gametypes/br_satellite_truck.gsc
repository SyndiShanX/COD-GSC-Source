/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_satellite_truck.gsc
*******************************************************/

init() {
  level._effect["poi_sat_truck_available"] = loadfx("vfx/iw8_br/gameplay/vfx_br_poi_satnav_white.vfx");
  level._effect["poi_sat_truck_charging"] = loadfx("vfx/iw8_br/gameplay/vfx_br_poi_satnav_red.vfx");
  level.br_satellitetruck = [];
  level.br_satellite_truck_enabled = getdvarint("scr_br_satellite_truck", 0) != 0;
  level.satellitetruckactivetimeseconds = getdvarfloat("dvar_AED581BEB83F1B08", 15);
  level.satellitetruckplundercost = getdvarint("dvar_E361609D81154A08", 1);
  _id_1F6BC044DD1738AB::initstatemachineforpoitype("satellite_truck");
  _id_1F6BC044DD1738AB::registerstatecallbacksforpoitype("satellite_truck", 0, ::_onenterdefaultstate, undefined, ::_onexitdefaultstate);
  _id_1F6BC044DD1738AB::registerstatecallbacksforpoitype("satellite_truck", 1, ::_onenterchargingstate, undefined, ::_onexitchargingstate);
  _id_1F6BC044DD1738AB::registerstatecallbacksforpoitype("satellite_truck", 2, ::_onenteractivestate, undefined, ::_onexitactivestate);
  _id_1F6BC044DD1738AB::registerstatecallbacksforpoitype("satellite_truck", 3, ::_onenterscanningstate, undefined, ::_onexitscanningstate);
  _id_1F6BC044DD1738AB::registerstatecallbacksforpoitype("satellite_truck", 4, ::_onentercooldownstate, undefined, undefined);
}

spawnsatellitetruck(struct) {
  if(!istrue(level.br_satellite_truck_enabled)) {
    return;
  }
  _id_F95CD92C3F35A916 = spawn("script_model", struct.origin);

  if(isDefined(struct.angles))
    _id_F95CD92C3F35A916.angles = struct.angles;

  _id_F95CD92C3F35A916 setModel("veh8_mil_lnd_mkilo23_skud_static2");
  _id_B7729B6D8545A7FE = scripts\engine\utility::getStruct(struct.target, "targetname");

  if(!isDefined(_id_F95CD92C3F35A916.satellitekeyboard)) {
    satellitekeyboard = spawn("script_model", _id_B7729B6D8545A7FE.origin);

    if(isDefined(_id_B7729B6D8545A7FE.angles))
      satellitekeyboard.angles = _id_B7729B6D8545A7FE.angles;

    satellitekeyboard setModel("electrical_elevator_access_keypad_01");
    satellitekeyboard setCursorHint("HINT_NOICON");
    satellitekeyboard setuseholdduration("duration_medium");
    satellitekeyboard sethintdisplayfov(120);
    satellitekeyboard setusefov(120);
    satellitekeyboard setuserange(80);
    satellitekeyboard setusepriority(-1);
    _id_F95CD92C3F35A916.satellitekeyboard = satellitekeyboard;
  }

  satelliteiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(satelliteiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(satelliteiconid, "active", (0, 0, 0), "hud_icon_br_satellite_truck");
    scripts\mp\objidpoolmanager::update_objective_onentity(satelliteiconid, _id_F95CD92C3F35A916);
    scripts\mp\objidpoolmanager::update_objective_setbackground(satelliteiconid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(satelliteiconid);
    _id_F95CD92C3F35A916.satelliteiconid = satelliteiconid;
    _id_F95CD92C3F35A916 thread _satellitetruckmanageminimapicon();
  } else {}

  level.br_satellitetruck[level.br_satellitetruck.size] = _id_F95CD92C3F35A916;
  return _id_F95CD92C3F35A916;
}

onprematchdone() {
  foreach(_id_E08CF97A737EEDE1 in level.br_satellitetruck)
  _id_E08CF97A737EEDE1 _id_1F6BC044DD1738AB::gotopoistate("satellite_truck", 0);
}

_satellitetruckmanageminimapicon() {
  _id_E08CF97A737EEDE1 = self;
  _id_E08CF97A737EEDE1 endon("death");
  _id_C5452D63F815C7E9 = 1.0;
  _id_E2329E812C2919BB = 5000;
  _id_E08CF97A737EEDE1.playersinrange = [];

  for(;;) {
    wait(_id_C5452D63F815C7E9);

    if(!istrue(level.br_prematchstarted)) {
      continue;
    }
    foreach(player in _id_E08CF97A737EEDE1.playersinrange) {
      if(isDefined(player))
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_E08CF97A737EEDE1.satelliteiconid, player);
    }

    _id_E08CF97A737EEDE1.playersinrange = scripts\mp\utility\player::getplayersinradius(_id_E08CF97A737EEDE1.origin, _id_E2329E812C2919BB);

    foreach(player in _id_E08CF97A737EEDE1.playersinrange) {
      if(isDefined(_id_E08CF97A737EEDE1.playerteam) && player.team == _id_E08CF97A737EEDE1.playerteam && _id_E08CF97A737EEDE1.currentstate == 3) {
        continue;
      }
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(_id_E08CF97A737EEDE1.satelliteiconid, player);
    }
  }
}

_satellitetruckstartsound() {
  _id_E08CF97A737EEDE1 = self;
  _id_5C8800EDA76B9A59 = _id_E08CF97A737EEDE1;
  _id_0DD99C56A1F7A2B7 = _id_E08CF97A737EEDE1.satellitekeyboard;

  for(;;) {
    _id_E08CF97A737EEDE1 waittill("poi_state_change");
    state = _id_E08CF97A737EEDE1.currentstate;

    if(!isDefined(_id_E08CF97A737EEDE1.audiostate))
      _id_E08CF97A737EEDE1.audiostate = state;
    else if(_id_E08CF97A737EEDE1.audiostate == state) {
      continue;
    }
    _id_E08CF97A737EEDE1.audiostate = state;

    switch (state) {
      default:
        break;
      case 0:
        break;
      case 1:
        _id_5C8800EDA76B9A59 playSound("truck_sattruck_initialstartup_os");
        wait 7.5;
        _id_5C8800EDA76B9A59 playLoopSound("truck_sattruck_idling_lp");
        break;
      case 2:
        break;
      case 3:
        _id_E08CF97A737EEDE1.isscanning = 1;
        _id_0DD99C56A1F7A2B7 playSound("truck_sattruck_initdeploy_os");
        wait 4.0;
        _id_0DD99C56A1F7A2B7 playLoopSound("truck_sattruck_scanning_lp");
        break;
      case 4:
        _id_5C8800EDA76B9A59 playSound("truck_sattruck_engineoff");

        if(istrue(_id_E08CF97A737EEDE1.isscanning)) {
          _id_0DD99C56A1F7A2B7 playSound("truck_sattruck_scanning_off");
          _id_E08CF97A737EEDE1.isscanning = undefined;
          wait 0.05;
          _id_0DD99C56A1F7A2B7 stoploopsound();
        }

        wait 0.45;
        _id_5C8800EDA76B9A59 stoploopsound();
        break;
    }
  }
}

_satellitetruckendusethink() {
  _id_E08CF97A737EEDE1 = self;
  _id_E08CF97A737EEDE1 notify("satelliteTruckUseThinkEnd");
}

_satellitetruckusethink() {
  _id_E08CF97A737EEDE1 = self;
  _id_E08CF97A737EEDE1 endon("death");
  _id_E08CF97A737EEDE1 _satellitetruckendusethink();
  _id_E08CF97A737EEDE1 endon("satelliteTruckUseThinkEnd");
  _id_E08CF97A737EEDE1 thread _satellitetruckstartsound();
  _id_3268DF12A22D1A03 = _id_E08CF97A737EEDE1 _id_1F6BC044DD1738AB::getcurrentpoistate();

  for(;;) {
    _id_E08CF97A737EEDE1.satellitekeyboard waittill("trigger", player);

    if(_id_E08CF97A737EEDE1 _id_1F6BC044DD1738AB::getcurrentpoistate() != _id_3268DF12A22D1A03) {
      return;
    }
    if(_id_E08CF97A737EEDE1 _id_1F6BC044DD1738AB::getcurrentpoistate() == 0) {
      if(player.plundercount < level.satellitetruckplundercost) {
        player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/NOT_ENOUGH_PLUNDER_ACTIVATE");
        continue;
      } else
        player _id_6AFF3948CF4CCA03::playersetplundercount(player.plundercount - level.satellitetruckplundercost);
    }

    if(_id_3268DF12A22D1A03 == 0) {
      _id_E08CF97A737EEDE1.playerteam = player.team;
      _id_E08CF97A737EEDE1 thread _id_1F6BC044DD1738AB::gotopoistate("satellite_truck", 1);
      return;
    } else if(_id_3268DF12A22D1A03 == 2) {
      _id_E08CF97A737EEDE1.playerteam = player.team;
      _id_E08CF97A737EEDE1 thread _id_1F6BC044DD1738AB::gotopoistate("satellite_truck", 3);
    }
  }
}

_satellitetruckactivate() {
  _id_E08CF97A737EEDE1 = self;
  _id_E08CF97A737EEDE1 endon("death");
  level thread _id_1E4A61DB11011446::teamsplashbr("br_satellite_truck_active", _id_E08CF97A737EEDE1.player, _id_E08CF97A737EEDE1.playerteam);
  _id_7EBE382BCACFE466 = 0;
  _id_9B4A37BAF5F7793A = getdvarint("dvar_53E16EC28B970932", 500);
  _id_46D176FDCD576507 = getdvarint("dvar_D1658AC67EB8D4A8", 2);

  while(_id_7EBE382BCACFE466 * _id_46D176FDCD576507 <= level.satellitetruckactivetimeseconds) {
    triggerportableradarpingteam(self.origin, _id_E08CF97A737EEDE1.playerteam, 5000, _id_9B4A37BAF5F7793A);
    _id_7EBE382BCACFE466++;
    wait(_id_46D176FDCD576507);
  }

  _id_6E5BD4FA4B5FCF47 = getdvarfloat("dvar_9A9C532332E3743D", 3);
  _id_1F6BC044DD1738AB::showmiscmessagetoteam(_id_E08CF97A737EEDE1.playerteam, "br_satellite_truck_cooldown", _id_6E5BD4FA4B5FCF47);
  _id_E08CF97A737EEDE1 thread _id_1F6BC044DD1738AB::gotopoistate("satellite_truck", 4);
}

_onenterdefaultstate(_id_E08CF97A737EEDE1) {
  _id_4430B08D5A2D47BF = _id_1F6BC044DD1738AB::getinteractiveoutlineasset();
  _id_E08CF97A737EEDE1.satellitekeyboard hudoutlineenable(_id_4430B08D5A2D47BF);
  _id_E08CF97A737EEDE1.satellitekeyboard makeusable();
  _id_E08CF97A737EEDE1.satellitekeyboard setHintString(&"MP/BR_ACTIVATE_SATELLITE_TRUCK");
  _id_E08CF97A737EEDE1 thread _satellitetruckusethink();
  _id_018E46C38378F618 = scripts\engine\utility::getfx("poi_sat_truck_available");
  playFXOnTag(_id_018E46C38378F618, _id_E08CF97A737EEDE1, "tag_origin");
}

_onexitdefaultstate(_id_E08CF97A737EEDE1) {
  _id_E08CF97A737EEDE1.satellitekeyboard hudoutlinedisable();
  _id_E08CF97A737EEDE1 _satellitetruckendusethink();
  _id_E08CF97A737EEDE1.satellitekeyboard makeunusable();
  _id_018E46C38378F618 = scripts\engine\utility::getfx("poi_sat_truck_available");
  stopFXOnTag(_id_018E46C38378F618, _id_E08CF97A737EEDE1, "tag_origin");
}

_onenterchargingstate(_id_E08CF97A737EEDE1) {
  _id_3058DBC123E6C741 = getdvarfloat("dvar_9ECB6742D002ED16", 10);
  _id_E08CF97A737EEDE1 thread _id_1F6BC044DD1738AB::gotopoistateontimer("satellite_truck", 2, _id_3058DBC123E6C741);
  _id_1F6BC044DD1738AB::showmiscmessagetoteam(_id_E08CF97A737EEDE1.playerteam, "br_satellite_truck_charging", _id_3058DBC123E6C741, int(_id_3058DBC123E6C741 * 1000));
  _id_90D6A5C6923319DE = scripts\engine\utility::getfx("poi_sat_truck_charging");
  playFXOnTag(_id_90D6A5C6923319DE, _id_E08CF97A737EEDE1, "tag_origin");
}

_onexitchargingstate(_id_E08CF97A737EEDE1) {
  _id_90D6A5C6923319DE = scripts\engine\utility::getfx("poi_sat_truck_charging");
  stopFXOnTag(_id_90D6A5C6923319DE, _id_E08CF97A737EEDE1, "tag_origin");
}

_onenteractivestate(_id_E08CF97A737EEDE1) {
  _id_4430B08D5A2D47BF = _id_1F6BC044DD1738AB::getinteractiveoutlineasset();
  _id_E08CF97A737EEDE1.satellitekeyboard hudoutlineenable(_id_4430B08D5A2D47BF);
  _id_E08CF97A737EEDE1.satellitekeyboard makeusable();
  _id_E08CF97A737EEDE1.satellitekeyboard setHintString(&"MP/BR_USE_SATELLITE_TRUCK");
  _id_E08CF97A737EEDE1 thread _satellitetruckusethink();
}

_onexitactivestate(_id_E08CF97A737EEDE1) {
  _id_E08CF97A737EEDE1.satellitekeyboard hudoutlinedisable();
  _id_E08CF97A737EEDE1 _satellitetruckendusethink();
  _id_E08CF97A737EEDE1.satellitekeyboard makeunusable();
}

_onenterscanningstate(_id_E08CF97A737EEDE1) {
  _id_E08CF97A737EEDE1 thread _satellitetruckactivate();
}

_onexitscanningstate(_id_E08CF97A737EEDE1) {
  _id_E08CF97A737EEDE1.playerteam = undefined;
}

_onentercooldownstate(_id_E08CF97A737EEDE1) {
  _id_ECDA8DCB2C2CA2D2 = getdvarfloat("dvar_2333F90F274605A5", 15);
  _id_E08CF97A737EEDE1 thread _id_1F6BC044DD1738AB::gotopoistateontimer("satellite_truck", 0, _id_ECDA8DCB2C2CA2D2);
}