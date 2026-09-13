/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle.gsc
***********************************************/

vehicle_init() {
  if(getdvarint("r_reflectionprobegenerate", 0)) {
    return;
  }
  if(getdvarint("dvar_742CAA13B3C2E685")) {
    return;
  }
  if(!isDefined(level.vehicle))
    level.vehicle = spawnStruct();

  level.vehicle.vehicledata = [];
  level.vehicle._id_2F4397218F74E45A = ::_id_2F4397218F74E45A;
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "init")]]();

  if(getdvarint("t10") > 0)
    level._id_7BF42D565645A485 = 1;

  if(getdvarint("dvar_50E5FEED8F9F6F56", 0) == 1)
    level._id_1B4DA6B781C9DFBD = 1;

  scripts\common\vehicle_code::vehicle_setuplevelvariables();

  if(istrue(level._id_7BF42D565645A485)) {
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_init();
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_init();
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_init();
    scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_init();
    scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_init();
    scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_init();
    scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_init();
    scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_init();
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_init();
    scripts\cp_mp\vehicles\vehicle_collision::vehicle_collision_init();
    scripts\cp_mp\vehicles\customization\battle_tracks::_id_620AA345AC2F9963();
    level thread _id_466CDEC791B7EDFE();
    level thread _id_5FF2C834CA229322();
    _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("player_connect", ::_id_4B1CC40CC7B8441E);

    if(isDefined(level._id_54CE42FA004DDE04)) {
      foreach(func in level._id_54CE42FA004DDE04)[[func]]();
    }

    level._id_54C8ACFD634A416C = 1;
  } else {
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_init();
    scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_init();
    scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_init();
    scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_init();
    scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_init();
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_init();
  }

  scripts\engine\utility::flag_set("vehicle_init_complete");
}

_id_C0B3DDC9A6BDCC46(_id_7731ADEF63E19B0C, func) {
  level._id_7BF42D565645A485 = 1;

  if(_id_038F50DECB5603D7(_id_7731ADEF63E19B0C)) {
    return;
  }
  if(!isDefined(level._id_54CE42FA004DDE04))
    level._id_54CE42FA004DDE04 = [];

  level._id_54CE42FA004DDE04[_id_7731ADEF63E19B0C] = func;

  if(istrue(level._id_54C8ACFD634A416C))
    [[func]]();
}

_id_038F50DECB5603D7(_id_7731ADEF63E19B0C) {
  return isDefined(level._id_54CE42FA004DDE04) && isDefined(level._id_54CE42FA004DDE04[_id_7731ADEF63E19B0C]);
}

_id_66AB4FB2175555E1(_id_7731ADEF63E19B0C) {
  if(!isDefined(level._id_B3585D083F213844))
    level._id_B3585D083F213844 = [];

  level._id_B3585D083F213844[_id_7731ADEF63E19B0C] = 1;

  if(_id_038F50DECB5603D7(_id_7731ADEF63E19B0C) && istrue(level._id_54C8ACFD634A416C) && !_id_FA537F1AB52A76D1(_id_7731ADEF63E19B0C))
    [[level._id_54CE42FA004DDE04[_id_7731ADEF63E19B0C]]]();
}

_id_9697379150687859(_id_7731ADEF63E19B0C) {
  return istrue(level._id_1B4DA6B781C9DFBD) || isDefined(level._id_B3585D083F213844) && istrue(level._id_B3585D083F213844[_id_7731ADEF63E19B0C]) || scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F(_id_7731ADEF63E19B0C).size > 0;
}

_id_2F4397218F74E45A() {
  _id_85D0FA0353BE9C53 = self._id_CA4A4DD2F8495667;

  if(!isDefined(_id_85D0FA0353BE9C53)) {
    return;
  }
  _id_7731ADEF63E19B0C = _id_85D0FA0353BE9C53.ref;

  if(!isDefined(_id_7731ADEF63E19B0C) || !_id_FA537F1AB52A76D1(_id_7731ADEF63E19B0C)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(_id_7731ADEF63E19B0C, "spawn")) {
    return;
  }
  spawndata = spawnStruct();
  spawndata.origin = self.origin;
  spawndata.angles = self.angles;
  spawndata.spawntype = "LEVEL";
  _id_BBA34CF920370FF4(_id_7731ADEF63E19B0C, spawndata, undefined, self);
}

_id_466CDEC791B7EDFE() {
  while(!isnavmeshloaded())
    waitframe();

  waitframe();

  foreach(_id_690D1CF274CFE40A in ["vehicle_large", "vehicle_med", "soldier"]) {
    if(isnavmeshloaded(_id_690D1CF274CFE40A)) {
      level._id_2814A8F25A392EAA = _id_690D1CF274CFE40A;
      break;
    }
  }
}

_id_5FF2C834CA229322() {
  for(;;) {
    level waittill("vehicle_integrity_failure", _id_44F1C37D516C2ACB);

    foreach(_id_32955835D1DBC4DC in _id_44F1C37D516C2ACB) {
      _id_F35BC3914DD968E3 = _id_32955835D1DBC4DC[0];
      _id_401C3A2E68AAB0FD = _id_32955835D1DBC4DC[1];

      if(_id_F35BC3914DD968E3 _id_2A503318E000E11D()) {
        _id_B1E2DC0593D7CA82 = _id_F35BC3914DD968E3._id_3098BBCD22D0E052;

        if(isDefined(_id_B1E2DC0593D7CA82))
          _id_F35BC3914DD968E3 thread[[_id_B1E2DC0593D7CA82._id_2EFC43F3F9071BC7]](_id_401C3A2E68AAB0FD);

        continue;
      }

      if(_id_F35BC3914DD968E3 isvehicle()) {
        _id_F35BC3914DD968E3._id_A8F4BB03B366AA80 = 1;

        if(istrue(_id_F35BC3914DD968E3._id_1693991455559C14))
          vehicle_death(_id_F35BC3914DD968E3);
        else
          _id_F35BC3914DD968E3 _id_AB08028468AB68F9();

        continue;
      }

      _id_F35BC3914DD968E3 delete();
    }
  }
}

_id_4B1CC40CC7B8441E(params) {
  thread _id_0973CFF70A385B03();
}

_id_0973CFF70A385B03() {
  self endon("disconnect");

  for(;;) {
    scripts\engine\utility::waittill_any_2("ascender_attach", "ascender_detach");
    thread vehicle_preventplayercollisiondamagefortimeafterexit(undefined, self);
  }
}

isvehicle() {
  return isDefined(self.vehiclename);
}

_id_794B5F886CCED2D0() {
  if(isDefined(self) && isvehicle()) {
    ref = _id_D93EC4635290FEBD();

    if(isDefined(ref) && _id_89DC39DC11F3988C(ref))
      return isDefined(_id_29B4292C92443328(ref).interact) && istrue(_id_29B4292C92443328(ref).interact._id_591DE85CD0986F8D);
  }

  return 0;
}

_id_A164FB69837475D5() {
  return isDefined(self) && isDefined(self._id_ABD157413AC4E022) && isDefined(self._id_91E81CEB674FDD8C);
}

_id_160EF1C877C69AB1(player, vehicle, turret, tag) {
  player._id_ABD157413AC4E022 = vehicle;
  player._id_91E81CEB674FDD8C = turret;
  player._id_E9A71C27FEF1B65A = tag;

  if(!isDefined(vehicle._id_3A442282FB9074E1))
    vehicle._id_3A442282FB9074E1 = [];

  vehicle._id_3A442282FB9074E1[vehicle._id_3A442282FB9074E1.size] = player;
}

_id_4D2324450A951B2B(player, vehicle) {
  if(isDefined(player)) {
    player._id_ABD157413AC4E022 = undefined;
    player._id_91E81CEB674FDD8C = undefined;
    player._id_E9A71C27FEF1B65A = undefined;
  }

  vehicle._id_3A442282FB9074E1 = scripts\engine\utility::array_remove(vehicle._id_3A442282FB9074E1, player);
}

_id_C2D52509BD96DC18() {
  if(!_id_A164FB69837475D5()) {
    return;
  }
  ref = self._id_ABD157413AC4E022 _id_D93EC4635290FEBD();

  if(!isDefined(ref)) {
    return;
  }
  self._id_91E81CEB674FDD8C scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(ref, "exitExternalTurret", self, self._id_ABD157413AC4E022);
}

isvehicledestroyed() {
  return istrue(self.isdestroyed);
}

_id_62CCFB7EA15A4520() {
  return isvehicle() && !isDefined(self.owner) && isDefined(self._id_0566868292EE2A1B);
}

vehiclecanfly() {
  _id_E2818AD39A3341B4 = vehicle_getleveldataforvehicle(self.vehiclename);

  if(isDefined(_id_E2818AD39A3341B4))
    return istrue(_id_E2818AD39A3341B4.canfly);

  return undefined;
}

_id_9502AA416CCD1247() {
  if(self vehicle_isphysveh() && self _meth_784F000D59E38105())
    return !self _meth_76FA53E72547FF02();

  if(!self _meth_76FA53E72547FF02())
    return 0;

  data = vehicle_getleveldataforvehicle(_id_D93EC4635290FEBD());

  if(isDefined(data) && isDefined(data.interact) && self vehicle_isphysveh()) {
    _id_96629AB4F22A62CE = scripts\engine\utility::_id_53C4C53197386572(data.interact._id_710719BC8C0E95D1, 20);

    if(isDefined(self._id_F2B4D0E8470F108B))
      _id_96629AB4F22A62CE = _id_96629AB4F22A62CE - 2 * self._id_F2B4D0E8470F108B.size;

    return self _meth_100D3BF35FCA6A7F() > _id_96629AB4F22A62CE;
  }

  return 0;
}

_id_B7148A3BFC4DEFB2() {
  return istrue(self._id_B7148A3BFC4DEFB2);
}

_id_7C62CA52F72901A1() {
  _id_E2818AD39A3341B4 = vehicle_getleveldataforvehicle(_id_D93EC4635290FEBD());

  if(isDefined(_id_E2818AD39A3341B4))
    return istrue(_id_E2818AD39A3341B4._id_941D95491D4D4817);

  return 0;
}

_id_2A503318E000E11D() {
  if(isDefined(self) && isvehicle()) {
    if(isDefined(self.streakinfo))
      return 1;
  }

  return 0;
}

_id_E0187E3C57F0F72E() {
  return !vehiclecanfly() && !_id_7C62CA52F72901A1();
}

vehicle_getleveldataforvehicle(_id_7731ADEF63E19B0C, create) {
  if(istrue(create) && !_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C))
    level._id_A0B2C978CA57FFC5[_id_7731ADEF63E19B0C] = spawnStruct();
  else if(!_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C)) {}

  if(_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C))
    return _id_29B4292C92443328(_id_7731ADEF63E19B0C);
}

_id_08497E7E46B5E397(_id_7731ADEF63E19B0C, callbacks) {
  if(isDefined(callbacks)) {
    foreach(key, func in callbacks)
    scripts\cp_mp\utility\script_utility::registersharedfunc(_id_7731ADEF63E19B0C, key, func);
  }

  _id_35A03F008736204D(_id_7731ADEF63E19B0C);
  _id_2AE5EAE26E26EFE9(_id_7731ADEF63E19B0C);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(_id_7731ADEF63E19B0C, "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc(_id_7731ADEF63E19B0C, "init")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(_id_7731ADEF63E19B0C, "initLate"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc(_id_7731ADEF63E19B0C, "initLate")]]();
}

_id_35A03F008736204D(_id_7731ADEF63E19B0C) {
  if(!isDefined(level._id_A0B2C978CA57FFC5))
    level._id_A0B2C978CA57FFC5 = [];

  _id_FA3697898BE9A322 = _id_7731ADEF63E19B0C + scripts\engine\utility::ter_op(!scripts\common\utility::iscp(), "_mp", "_cp");
  level._id_A0B2C978CA57FFC5[_id_7731ADEF63E19B0C] = getscriptbundle("vehiclebundle:" + _id_FA3697898BE9A322);
}

_id_2AE5EAE26E26EFE9(_id_7731ADEF63E19B0C) {
  data = _id_29B4292C92443328(_id_7731ADEF63E19B0C);

  if(isDefined(data._id_14090BC312DBF6C8) && isDefined(data._id_14090BC312DBF6C8.vfx))
    level._effect[_id_7731ADEF63E19B0C + "_explosion"] = loadfx(data._id_14090BC312DBF6C8.vfx);

  if(istrue(data._id_FB41D1CA75009BF0._id_F2CF04C055FD760E) && isDefined(data._id_FB41D1CA75009BF0.ref) && isDefined(data._id_EB61D7C4087C9207) && isDefined(data._id_EB61D7C4087C9207.vfx))
    level._effect[data._id_FB41D1CA75009BF0.ref + "_explosion"] = loadfx(data._id_EB61D7C4087C9207.vfx);

  if(isDefined(data.compositemodel) && data.compositemodel != "")
    data.model = data.compositemodel;

  data.compositemodel = undefined;

  if(isDefined(data._id_FB41D1CA75009BF0.compositemodel) && data._id_FB41D1CA75009BF0.compositemodel != "")
    data._id_FB41D1CA75009BF0.model = data._id_FB41D1CA75009BF0.compositemodel;

  data._id_FB41D1CA75009BF0.compositemodel = undefined;

  if(isDefined(data.ai.compositemodel) && data.ai.compositemodel != "")
    data.ai.model = data.ai.compositemodel;

  data.ai.compositemodel = undefined;
  data.occupancy.exitoffsets = [];
  data.occupancy.exitdirections = [];

  foreach(_id_9F925F5509626DF1 in data._id_39A64A5E09C1284A) {
    data.occupancy.exitoffsets[_id_9F925F5509626DF1.ref] = (scripts\engine\utility::_id_53C4C53197386572(_id_9F925F5509626DF1.offset.x, 0), scripts\engine\utility::_id_53C4C53197386572(_id_9F925F5509626DF1.offset.y, 0), scripts\engine\utility::_id_53C4C53197386572(_id_9F925F5509626DF1.offset.z, 0));
    data.occupancy.exitdirections[_id_9F925F5509626DF1.ref] = _id_9F925F5509626DF1.direction;
  }

  data._id_39A64A5E09C1284A = undefined;
  data.occupancy.seatdata = [];

  foreach(seatdata in data._id_4DF083E7CE48A6E5)
  data.occupancy.seatdata[seatdata.ref] = seatdata;

  data.seatswitcharray = [];

  foreach(index, _id_E634BC0732415D0C in data._id_4DF083E7CE48A6E5)
  data.seatswitcharray[index] = _id_E634BC0732415D0C.ref;

  data.occupancy.seatids = [];
  data.occupancy.id = data.id;
  data.id = undefined;

  foreach(seatid, seatdata in data.occupancy.seatdata) {
    if(seatdata.restrictions == "driver_can_fire" || seatdata.restrictions == "turret_passenger")
      seatdata._id_4C78BDF78D543129 = 1;

    switch (seatdata.restrictions) {
      case "driver":
        seatdata.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
        break;
      case "driver_can_fire":
        seatdata.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::_id_B9CC4AD5C15D3CEE();
        break;
      case "combat_passenger":
        seatdata.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
        break;
      case "turret_passenger":
        seatdata.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
        break;
      case "passive_passenger":
        seatdata.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getpassivepassengerrestrictions();
        break;
    }

    if(seatdata.animtag == "tag_turret")
      seatdata.animtag = undefined;

    seatdata.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(seatid, data.seatswitcharray);
    seatdata.damagemodifier = scripts\engine\utility::_id_53C4C53197386572(seatdata.damagemodifier, 0);
    seatdata._id_DCFC487F4EF1103C = scripts\engine\utility::_id_53C4C53197386572(seatdata._id_DCFC487F4EF1103C, 0);

    if(seatdata._id_DCFC487F4EF1103C < 0)
      seatdata._id_DCFC487F4EF1103C = undefined;

    if(isDefined(seatdata.turretweapon) && seatdata.turretweapon != "")
      seatdata.turretobjweapon = makeweapon(seatdata.turretweapon);

    data.occupancy.seatids[seatid] = scripts\engine\utility::_id_53C4C53197386572(seatdata._id_3E99C59055B3DE67, 0);
  }

  if(data.occupancy._id_C08D88C04569A00B == "no_roof_exit")
    data.occupancy._id_C08D88C04569A00B = undefined;

  data._id_4DF083E7CE48A6E5 = undefined;
  data.spawn.abandonedtimeoutcallback = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_abandonedtimeoutcallback;

  if(isDefined(data._id_CD5AB16B94BC2745) && data._id_CD5AB16B94BC2745 == "")
    data._id_CD5AB16B94BC2745 = undefined;

  foreach(_id_35FD13041DDE93E8 in data._id_35FD13041DDE93E8) {
    if(isDefined(_id_35FD13041DDE93E8._id_9C6D62E1C42BE80A) && _id_35FD13041DDE93E8._id_9C6D62E1C42BE80A.size > 0) {
      _id_365929041E4386ED = [];

      foreach(_id_1AE3A63ED6578D45 in _id_35FD13041DDE93E8._id_9C6D62E1C42BE80A)
      _id_365929041E4386ED[_id_1AE3A63ED6578D45.weapon] = _id_1AE3A63ED6578D45._id_FE99F86A708E76EF;

      _id_35FD13041DDE93E8._id_9C6D62E1C42BE80A = _id_365929041E4386ED;
      continue;
    }

    _id_35FD13041DDE93E8._id_9C6D62E1C42BE80A = undefined;
  }

  data.damage.weapon = data.weapon;
  data.damage.visualpercents = [];
  data.damage.visualcallbacks = [];
  data.damage.visualclearcallbacks = [];
  data.damage.damagestatedata = [];
  data.damage._id_AAB9695C92B0ED96 = [];
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_registerdefaultstates(_id_7731ADEF63E19B0C);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_applytabletovehicle(_id_7731ADEF63E19B0C);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setvehiclehitdamagedata(_id_7731ADEF63E19B0C, data.damage._id_F5D36C635CC8546B);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setdeathcallback(_id_7731ADEF63E19B0C, ::_id_AB08028468AB68F9);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setweaponhitdamagedata(data.damage.weapon, data.damage._id_C3B0005F41B92649);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1F39191797C711B6(_id_7731ADEF63E19B0C, data.damage._id_10175926AEB1591E);

  if(istrue(data._id_FB41D1CA75009BF0._id_F2CF04C055FD760E)) {
    scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setvehiclehitdamagedata(data._id_FB41D1CA75009BF0.ref, data.damage._id_F5D36C635CC8546B);

    if(isDefined(data._id_FB41D1CA75009BF0.weapon))
      scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setweaponhitdamagedata(data._id_FB41D1CA75009BF0.weapon, data.damage._id_C3B0005F41B92649);

    if(!scripts\common\utility::iscp())
      scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setdeathcallback(data._id_FB41D1CA75009BF0.ref, ::_id_AB08028468AB68F9);
  } else
    data._id_EB61D7C4087C9207 = undefined;

  data.interact.lights = [];

  foreach(light in data.lights)
  data.interact.lights[light.tag] = light;

  data.lights = undefined;
  data.damage._id_9D70F02394C136DA = [];
  data.damage._id_CCFDE1208EF2964B = [];

  foreach(_id_BAFA22FCDEFFF511 in data._id_AAB9695C92B0ED96) {
    if(!istrue(_id_BAFA22FCDEFFF511.enabled)) {
      continue;
    }
    if(istrue(_id_BAFA22FCDEFFF511._id_0231ADCAE1AE30C4))
      data.damage._id_9D70F02394C136DA[_id_BAFA22FCDEFFF511._id_DA9F4CD603F44758] = _id_BAFA22FCDEFFF511;

    if(istrue(_id_BAFA22FCDEFFF511._id_6B48CB7FDF031749))
      data.damage._id_CCFDE1208EF2964B[_id_BAFA22FCDEFFF511._id_DA9F4CD603F44758] = _id_BAFA22FCDEFFF511;

    switch (_id_BAFA22FCDEFFF511.ref) {
      case "row4_right_wheel":
      case "row4_left_wheel":
      case "row3_right_wheel":
      case "row3_left_wheel":
      case "row2_right_wheel":
      case "row2_left_wheel":
      case "row1_right_wheel":
      case "row1_left_wheel":
        _id_BAFA22FCDEFFF511._id_7CBFFE9DE982BCAD = _func_E84A5F30606D3A09(_id_BAFA22FCDEFFF511.ref, "_wheel");
        break;
      case "back_left_door":
      case "back_right_door":
      case "front_left_door":
      case "front_right_door":
      case "left_door":
      case "right_door":
      case "back_door":
      case "front_door":
      case "driver_door":
        data.occupancy._id_C0AC99D7D5E195A4 = 1;
        _id_BAFA22FCDEFFF511._id_49CF4824F012BFEA = _func_E84A5F30606D3A09(_id_BAFA22FCDEFFF511.ref, "_door");
        break;
      case "back_left_window":
      case "back_right_window":
      case "front_left_window":
      case "front_right_window":
      case "left_window":
      case "right_window":
      case "back_window":
      case "front_window":
      case "driver_window":
        _id_199B7EB356C9D5A9 = _func_E84A5F30606D3A09(_id_BAFA22FCDEFFF511.ref, "_window");

        if(isDefined(data.occupancy.seatdata[_id_199B7EB356C9D5A9]))
          data.occupancy.seatdata[_id_199B7EB356C9D5A9]._id_9A3DB3C861DA8D62 = _id_BAFA22FCDEFFF511._id_DA9F4CD603F44758;
      case "generic_window":
        _id_BAFA22FCDEFFF511._id_9EB2AF3A3212B936 = _id_BAFA22FCDEFFF511.ref;
        break;
      case "light":
        break;
    }

    _id_BAFA22FCDEFFF511.ref = undefined;

    if(isDefined(_id_BAFA22FCDEFFF511._id_7CBFFE9DE982BCAD)) {
      switch (_id_BAFA22FCDEFFF511._id_7CBFFE9DE982BCAD) {
        case "row1_left":
          _id_BAFA22FCDEFFF511._id_B4FCCC158C681073 = scripts\cp_mp\vehicles\vehicle_damage::_id_4B3EF3D76F7E39B6;
          break;
        case "row1_right":
          _id_BAFA22FCDEFFF511._id_B4FCCC158C681073 = scripts\cp_mp\vehicles\vehicle_damage::_id_D4C899AFE6CBF533;
          break;
        case "row2_left":
          _id_BAFA22FCDEFFF511._id_B4FCCC158C681073 = scripts\cp_mp\vehicles\vehicle_damage::_id_1C35D2BEE2C14D7B;
          break;
        case "row2_right":
          _id_BAFA22FCDEFFF511._id_B4FCCC158C681073 = scripts\cp_mp\vehicles\vehicle_damage::_id_2E20B5A5D4F70228;
          break;
        case "row3_left":
          _id_BAFA22FCDEFFF511._id_B4FCCC158C681073 = scripts\cp_mp\vehicles\vehicle_damage::_id_79B9F63570444468;
          break;
        case "row3_right":
          _id_BAFA22FCDEFFF511._id_B4FCCC158C681073 = scripts\cp_mp\vehicles\vehicle_damage::_id_4C7A8D0B6C6C16CD;
          break;
        case "row4_left":
          _id_BAFA22FCDEFFF511._id_B4FCCC158C681073 = scripts\cp_mp\vehicles\vehicle_damage::_id_1CBE55C0515820B5;
          break;
        case "row4_right":
          _id_BAFA22FCDEFFF511._id_B4FCCC158C681073 = scripts\cp_mp\vehicles\vehicle_damage::_id_6469EA91038491E2;
          break;
      }
    }

    data.damage._id_AAB9695C92B0ED96[_id_BAFA22FCDEFFF511._id_DA9F4CD603F44758] = _id_BAFA22FCDEFFF511;
    scripts\common\vehicle::_id_9039B650FFB212C8(_id_BAFA22FCDEFFF511._id_DA9F4CD603F44758);
  }

  data._id_AAB9695C92B0ED96 = undefined;
  data.damage.frontextents = scripts\engine\utility::_id_53C4C53197386572(data.damage._id_9CC800BABF1F05AF._id_CFF021654A47B60C, 0);
  data.damage.backextents = scripts\engine\utility::_id_53C4C53197386572(data.damage._id_9CC800BABF1F05AF.back, 0);
  data.damage.leftextents = scripts\engine\utility::_id_53C4C53197386572(data.damage._id_9CC800BABF1F05AF.left, 0);
  data.damage.rightextents = scripts\engine\utility::_id_53C4C53197386572(data.damage._id_9CC800BABF1F05AF.right, 0);
  data.damage.bottomextents = scripts\engine\utility::_id_53C4C53197386572(data.damage._id_9CC800BABF1F05AF._id_8A925332BA34F25E, 0);
  data.damage.loscheckoffset = (scripts\engine\utility::_id_53C4C53197386572(data.damage._id_8E266D8413972567.x, 0), scripts\engine\utility::_id_53C4C53197386572(data.damage._id_8E266D8413972567.y, 0), scripts\engine\utility::_id_53C4C53197386572(data.damage._id_8E266D8413972567.z, 0));
  data.damage._id_8E266D8413972567 = undefined;
  data.damage._id_9CC800BABF1F05AF = undefined;

  if(istrue(data.damage._id_98277A386E38941F)) {
    data.damage._id_C0D2F358F2E54245._id_CFF021654A47B60C = scripts\engine\utility::_id_53C4C53197386572(data.damage._id_C0D2F358F2E54245._id_CFF021654A47B60C, 0);
    data.damage._id_C0D2F358F2E54245.back = scripts\engine\utility::_id_53C4C53197386572(data.damage._id_C0D2F358F2E54245.back, 0);
    data.damage._id_C0D2F358F2E54245.left = scripts\engine\utility::_id_53C4C53197386572(data.damage._id_C0D2F358F2E54245.left, 0);
    data.damage._id_C0D2F358F2E54245.right = scripts\engine\utility::_id_53C4C53197386572(data.damage._id_C0D2F358F2E54245.right, 0);
    data.damage._id_C0D2F358F2E54245.top = scripts\engine\utility::_id_53C4C53197386572(data.damage._id_C0D2F358F2E54245.top, 0);
    data.damage._id_C0D2F358F2E54245._id_8A925332BA34F25E = scripts\engine\utility::_id_53C4C53197386572(data.damage._id_C0D2F358F2E54245._id_8A925332BA34F25E, 0);
  } else
    data.damage._id_C0D2F358F2E54245 = undefined;

  data.occupancy.exitextents["front"] = scripts\engine\utility::_id_53C4C53197386572(data.exitextents._id_CFF021654A47B60C, 0);
  data.occupancy.exitextents["back"] = scripts\engine\utility::_id_53C4C53197386572(data.exitextents.back, 0);
  data.occupancy.exitextents["left"] = scripts\engine\utility::_id_53C4C53197386572(data.exitextents.left, 0);
  data.occupancy.exitextents["right"] = scripts\engine\utility::_id_53C4C53197386572(data.exitextents.right, 0);
  data.occupancy.exitextents["top"] = scripts\engine\utility::_id_53C4C53197386572(data.exitextents.top, 0);
  data.occupancy.exitextents["bottom"] = scripts\engine\utility::_id_53C4C53197386572(data.exitextents._id_8A925332BA34F25E, 0);
  data.exitextents = undefined;
  data.interact._id_ED5C39E0B1EF815C = [];
  data.interact.pointdata = [];
  scripts\cp_mp\vehicles\vehicle_interact::_id_3E11A192D07B42EA(_id_7731ADEF63E19B0C, "single", data.seatswitcharray);
  level.vehicle.oob.outoftimecallbacks[_id_7731ADEF63E19B0C] = ::_id_AB08028468AB68F9;
  data.occupancy.data = [];
  data.occupancy.rotationids = [];
  data.occupancy.warningbits = [];
  data.occupancy.warningstartcallbacks = [];
  data.occupancy.warningendcallbacks = [];
  data.occupancy.warningclearcallbacks = [];
  data.occupancy.rotationrefsbyseatandweapon = [];
  data.occupancy.warningbits["burningDown"] = 1;
  data.occupancy.warningbits["missileLocking"] = 2;
  data.occupancy.warningbits["missileIncoming"] = 4;
  data.occupancy.warningbits["movementDisabled"] = 3;
  data.occupancy.warningbits["outOfFuel"] = 6;
  data.occupancy.warningbits["lowFuel"] = 5;
  data.occupancy.warningbits["BunkerBusterAttached"] = 7;
  data.occupancy.warningbits["shockStickAttached"] = 8;
  data.occupancy.warningbits["DDoSed"] = 9;
  data.occupancy.warningbits["locked"] = 10;

  if(scripts\common\utility::_id_A10967D736DC56E5() && istrue(data.ai._id_289DF80E1DED586F)) {
    unload_groups = [];
    unload_groups["default"] = [];
    unload_groups["all"] = [];

    foreach(index, seatdata in data._id_F4EAE2A1481B7DD3) {
      if(isDefined(seatdata.vehicle_getinanim) && isDefined(seatdata.vehicle_getinanim.id))
        seatdata.vehicle_getinanim = seatdata.vehicle_getinanim.id;
      else
        seatdata.vehicle_getinanim = undefined;

      if(isDefined(seatdata.vehicle_getoutanim) && isDefined(seatdata.vehicle_getoutanim.id))
        seatdata.vehicle_getoutanim = seatdata.vehicle_getoutanim.id;
      else
        seatdata.vehicle_getoutanim = undefined;

      if(isDefined(seatdata.vehicle_getoutanim_combat) && isDefined(seatdata.vehicle_getoutanim_combat.id))
        seatdata.vehicle_getoutanim_combat = seatdata.vehicle_getoutanim_combat.id;
      else
        seatdata.vehicle_getoutanim_combat = undefined;

      if(isDefined(seatdata.vehicle_getoutanim_combat_run) && isDefined(seatdata.vehicle_getoutanim_combat_run.id))
        seatdata.vehicle_getoutanim_combat_run = seatdata.vehicle_getoutanim_combat_run.id;
      else
        seatdata.vehicle_getoutanim_combat_run = undefined;

      if(isDefined(seatdata.linkoffset)) {
        x = scripts\engine\utility::_id_53C4C53197386572(seatdata.linkoffset.x, 0);
        y = scripts\engine\utility::_id_53C4C53197386572(seatdata.linkoffset.y, 0);
        z = scripts\engine\utility::_id_53C4C53197386572(seatdata.linkoffset.z, 0);

        if(x != 0 || y != 0 || z != 0) {
          seatdata.linkoffset = (x, y, z);
          seatdata._id_03630FFA8EDAFEF8 = (0, 0, 0);
        } else
          seatdata.linkoffset = undefined;
      }

      if(isDefined(data._id_7C19CAE9EDC84D70) && isDefined(data._id_7C19CAE9EDC84D70[index])) {
        _id_62B78F0013665CE9 = data._id_7C19CAE9EDC84D70[index];

        if(isDefined(_id_62B78F0013665CE9.idle) && isDefined(_id_62B78F0013665CE9.idle.id))
          seatdata.idle = _id_62B78F0013665CE9.idle.id;

        if(isDefined(_id_62B78F0013665CE9.getin) && isDefined(_id_62B78F0013665CE9.getin.id))
          seatdata.getin = _id_62B78F0013665CE9.getin.id;

        if(isDefined(_id_62B78F0013665CE9.getout) && isDefined(_id_62B78F0013665CE9.getout.id))
          seatdata.getout = _id_62B78F0013665CE9.getout.id;

        if(isDefined(_id_62B78F0013665CE9.death) && isDefined(_id_62B78F0013665CE9.death.id))
          seatdata.death = _id_62B78F0013665CE9.death.id;

        if(isDefined(_id_62B78F0013665CE9.ragdoll_fall_anim) && isDefined(_id_62B78F0013665CE9.ragdoll_fall_anim.id))
          seatdata.ragdoll_fall_anim = _id_62B78F0013665CE9.ragdoll_fall_anim.id;

        if(isDefined(_id_62B78F0013665CE9.idle_anim) && _id_62B78F0013665CE9.idle_anim != "")
          seatdata.idle_anim = _id_62B78F0013665CE9.idle_anim;
      }

      if(!istrue(seatdata.do_not_unload)) {
        unload_groups["default"][unload_groups["default"].size] = index;
        unload_groups["all"][unload_groups["all"].size] = index;
      }
    }

    foreach(_id_7E219B890204C40D in data.unloadgroups) {
      unload_groups[_id_7E219B890204C40D.name] = [];

      foreach(index, seatdata in _id_7E219B890204C40D._id_4DF083E7CE48A6E5)
      unload_groups[_id_7E219B890204C40D.name][unload_groups[_id_7E219B890204C40D.name].size] = seatdata._id_BC676A8C07563150;
    }

    data.unloadgroups = undefined;
    data._id_7C19CAE9EDC84D70 = undefined;
    scripts\common\vehicle_build::build_template(data.ai._id_CDB848190A1B2F99, data.model, data.vehicle, data.ai.classname);
    scripts\common\vehicle_build::_id_A82F8A25AD7E6B3F(data._id_F4EAE2A1481B7DD3, data.ai.vehicleanimalias);
    scripts\common\vehicle_build::_id_AB7252DA140C8FE7(unload_groups);
  }

  if(istrue(data._id_03EF9B41093F5752._id_E01DB00D1CCB42EA)) {
    effect = loadfx(data._id_03EF9B41093F5752.vfx);
    level._effect[_id_7731ADEF63E19B0C + "_land"] = effect;
    data._id_03EF9B41093F5752.effect = effect;
    data._id_03EF9B41093F5752._id_0E25D1D189177A7C = _id_7731ADEF63E19B0C + "_drop";
    level.scr_animtree["ac130"] = data._id_03EF9B41093F5752._id_D6DBD39DBD5AB5FC.animtree.id;
    level.scr_anim["ac130"][data._id_03EF9B41093F5752._id_0E25D1D189177A7C] = data._id_03EF9B41093F5752._id_D6DBD39DBD5AB5FC.animname.id;
    level.scr_animname["ac130"][data._id_03EF9B41093F5752._id_0E25D1D189177A7C] = getanimname(data._id_03EF9B41093F5752._id_D6DBD39DBD5AB5FC.animname.id);
    level.scr_animtree["parachute"] = data._id_03EF9B41093F5752._id_6A32DEE944EB39AD.animtree.id;
    level.scr_anim["parachute"][data._id_03EF9B41093F5752._id_0E25D1D189177A7C] = data._id_03EF9B41093F5752._id_6A32DEE944EB39AD.animname.id;
    level.scr_animname["parachute"][data._id_03EF9B41093F5752._id_0E25D1D189177A7C] = getanimname(data._id_03EF9B41093F5752._id_6A32DEE944EB39AD.animname.id);
    level.scr_animtree[_id_7731ADEF63E19B0C] = data._id_03EF9B41093F5752._id_96A21E181F0221F5.animtree.id;
    level.scr_anim[_id_7731ADEF63E19B0C][data._id_03EF9B41093F5752._id_0E25D1D189177A7C] = data._id_03EF9B41093F5752._id_96A21E181F0221F5.animname.id;

    if(isDefined(data._id_03EF9B41093F5752._id_B39C395CD7EFE672) && isDefined(data._id_03EF9B41093F5752._id_B39C395CD7EFE672.animname) && isDefined(data._id_03EF9B41093F5752._id_B39C395CD7EFE672.animname.id)) {
      data._id_03EF9B41093F5752._id_150B11A4DA8461BC = _id_7731ADEF63E19B0C + "_follow_up";
      level.scr_anim[_id_7731ADEF63E19B0C][data._id_03EF9B41093F5752._id_150B11A4DA8461BC] = data._id_03EF9B41093F5752._id_B39C395CD7EFE672.animname.id;
    }

    data._id_03EF9B41093F5752._id_D6DBD39DBD5AB5FC = undefined;
    data._id_03EF9B41093F5752._id_6A32DEE944EB39AD = undefined;
    data._id_03EF9B41093F5752._id_96A21E181F0221F5 = undefined;
    data._id_03EF9B41093F5752._id_B39C395CD7EFE672 = undefined;
  } else
    data._id_03EF9B41093F5752 = undefined;

  if(data._id_8F2C463C6016CE59.size == 0)
    data._id_8F2C463C6016CE59 = undefined;
  else {
    _id_D43CD65AC3E21E46 = [];

    foreach(_id_37879FC7B1CC0618 in data._id_8F2C463C6016CE59)
    _id_D43CD65AC3E21E46[_id_37879FC7B1CC0618.ref] = _id_37879FC7B1CC0618;

    data._id_8F2C463C6016CE59 = _id_D43CD65AC3E21E46;
  }
}

_id_29B4292C92443328(_id_7731ADEF63E19B0C) {
  if(_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C))
    return level._id_A0B2C978CA57FFC5[_id_7731ADEF63E19B0C];
  else {}
}

_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C) {
  return isDefined(level._id_A0B2C978CA57FFC5) && isDefined(level._id_A0B2C978CA57FFC5[_id_7731ADEF63E19B0C]);
}

_id_FA537F1AB52A76D1(_id_7731ADEF63E19B0C) {
  return _id_89DC39DC11F3988C(_id_7731ADEF63E19B0C);
}

vehicle_spawn(_id_7731ADEF63E19B0C, spawndata, _id_EE8DA5624236DC89) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(_id_7731ADEF63E19B0C, "spawn"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc(_id_7731ADEF63E19B0C, "spawn")]](spawndata, _id_EE8DA5624236DC89);
  else
    return _id_BBA34CF920370FF4(_id_7731ADEF63E19B0C, spawndata, _id_EE8DA5624236DC89);
}

_id_BBA34CF920370FF4(_id_7731ADEF63E19B0C, spawndata, _id_EE8DA5624236DC89, vehicle) {
  if(!_id_FA537F1AB52A76D1(_id_7731ADEF63E19B0C))
    return undefined;
  else {}

  vehicledata = _id_29B4292C92443328(_id_7731ADEF63E19B0C);
  spawndata = scripts\cp_mp\vehicles\vehicle_spawn::_id_37480E9C9C701CF2(_id_7731ADEF63E19B0C, spawndata);

  if(isDefined(vehicle)) {
    vehicle.targetname = spawndata.targetname;
    spawndata.vehicletype = vehicle.vehicletype;
    vehicle.spawndata = spawndata;
  } else {
    vehicle = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata, _id_EE8DA5624236DC89);

    if(!isDefined(vehicle))
      return undefined;
  }

  vehicle_create(vehicle, _id_7731ADEF63E19B0C, spawndata);
  vehicle.objweapon = makeweapon(scripts\cp_mp\vehicles\vehicle_damage::_id_7AAA7AE503292F43(_id_7731ADEF63E19B0C));
  scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_registerinstance(vehicle);
  vehicle_createlate(vehicle, spawndata);
  vehicle thread vehicle_watchflipped();
  vehicle thread _id_4A387C035EB677D0(istrue(vehicledata._id_941D95491D4D4817));
  vehicle thread _id_1E24ABEF827F0807();
  vehicle thread scripts\common\vehicle_code::_id_C2B5282B537A56BC();

  if(istrue(vehicledata._id_941D95491D4D4817))
    vehicle _meth_481C2A63F2BA3332(-1, scripts\engine\utility::_id_53C4C53197386572(level._id_DF44F8CC05382071, 100));
  else if(!vehicle _meth_784F000D59E38105())
    vehicle thread _id_1B69321FF9937FC5();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(_id_7731ADEF63E19B0C, "create"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc(_id_7731ADEF63E19B0C, "create")]](vehicle);

  if(scripts\common\utility::_id_A10967D736DC56E5() && istrue(vehicledata.ai._id_289DF80E1DED586F) && istrue(spawndata._id_F16652E1462A3739))
    vehicle _id_810DFD134E9A7A04(vehicledata);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(_id_7731ADEF63E19B0C, "onStartRiding") && scripts\cp_mp\utility\script_utility::issharedfuncdefined(_id_7731ADEF63E19B0C, "onEndRiding"))
    vehicle thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_34D70AA8129B0D74();

  return vehicle;
}

_id_0FFFE750FCE66784(_id_7731ADEF63E19B0C, spawndata, _id_EE8DA5624236DC89, _id_DEE73A1FA79B1B6D, donotwatchabandoned, _id_35FD13041DDE93E8) {
  if(!_id_FA537F1AB52A76D1(_id_7731ADEF63E19B0C) || !istrue(_id_29B4292C92443328(_id_7731ADEF63E19B0C)._id_FB41D1CA75009BF0._id_F2CF04C055FD760E))
    return undefined;

  data = _id_29B4292C92443328(_id_7731ADEF63E19B0C);
  _id_064A02A3BA94254D = data._id_FB41D1CA75009BF0.ref;
  spawndata = scripts\cp_mp\vehicles\vehicle_spawn::_id_1CC780D5CAC1E7CD(_id_7731ADEF63E19B0C, spawndata, _id_DEE73A1FA79B1B6D);
  _id_FB41D1CA75009BF0 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata, _id_EE8DA5624236DC89);

  if(!isDefined(_id_FB41D1CA75009BF0))
    return undefined;

  _id_FB41D1CA75009BF0._id_B7148A3BFC4DEFB2 = 1;
  _id_FB41D1CA75009BF0._id_5E7ED8E7A332998A = _id_7731ADEF63E19B0C;
  vehicle_create(_id_FB41D1CA75009BF0, _id_064A02A3BA94254D, spawndata);
  _id_FB41D1CA75009BF0.objweapon = makeweapon(scripts\cp_mp\vehicles\vehicle_damage::_id_06C17ABF5C5D88CA(_id_7731ADEF63E19B0C));
  _id_FB41D1CA75009BF0._id_6DC04302DA1A9D03 = spawndata._id_6DC04302DA1A9D03;
  vehicle_createlate(_id_FB41D1CA75009BF0, spawndata);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(_id_064A02A3BA94254D, "create"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc(_id_064A02A3BA94254D, "create")]](_id_FB41D1CA75009BF0);

  _id_FB41D1CA75009BF0 thread scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_watchabandoned();
  _id_78EBF58592491D35 = scripts\cp_mp\vehicles\vehicle_spawn::_id_89CDA5BA9BFC8D56(_id_7731ADEF63E19B0C);
  _id_E85CE9CA904D8DFC = undefined;

  if(isDefined(_id_35FD13041DDE93E8)) {
    _id_FB41D1CA75009BF0._id_35FD13041DDE93E8 = _id_35FD13041DDE93E8;

    if(isDefined(_id_35FD13041DDE93E8._id_C3606975AB404C5C))
      _id_E85CE9CA904D8DFC = _id_35FD13041DDE93E8._id_C3606975AB404C5C;
  }

  if(isDefined(_id_78EBF58592491D35)) {
    foreach(struct in _id_78EBF58592491D35) {
      if(isDefined(_id_E85CE9CA904D8DFC) && _id_FB41D1CA75009BF0 getscriptableparthasstate(struct._id_01FB6B56A662DF98, _id_E85CE9CA904D8DFC)) {
        _id_FB41D1CA75009BF0 setscriptablepartstate(struct._id_01FB6B56A662DF98, _id_E85CE9CA904D8DFC);
        continue;
      }

      _id_FB41D1CA75009BF0 setscriptablepartstate(struct._id_01FB6B56A662DF98, "on");
    }
  }

  _id_A7D11025C5CD54EC = scripts\cp_mp\vehicles\vehicle_spawn::_id_AADE62C6CF163888(_id_7731ADEF63E19B0C);

  if(isDefined(_id_A7D11025C5CD54EC))
    _id_FB41D1CA75009BF0 _meth_E4FE23E19F4BF900(_id_A7D11025C5CD54EC);

  _id_FB41D1CA75009BF0 scripts\cp_mp\vehicles\vehicle_damage::_id_CF63DB12F07ABF78(_id_7731ADEF63E19B0C, _id_FB41D1CA75009BF0._id_AAB9695C92B0ED96);
  _id_FB41D1CA75009BF0 scripts\common\vehicle_code::_id_2B8B11C3C14C9BAA(undefined, spawndata, data.damage._id_D59DDC542FB76578);
  _id_FB41D1CA75009BF0 _meth_1CD1EE312FD03BB4(1);
  _id_FB41D1CA75009BF0 vehicleshowonminimap(0);

  if(_id_FB41D1CA75009BF0 vehicle_isphysveh()) {
    _id_FB41D1CA75009BF0 vehphys_crash();

    if(!_id_FB41D1CA75009BF0 _id_7C62CA52F72901A1() && _id_FB41D1CA75009BF0 _meth_76FA53E72547FF02())
      _id_FB41D1CA75009BF0 _meth_B0AF0DD0F9B4FDDF(0);
  } else
    _id_FB41D1CA75009BF0 scripts\cp_mp\vehicles\vehicle_occupancy::_id_887B4E2CBE3AB92C();

  return _id_FB41D1CA75009BF0;
}

_id_D93EC4635290FEBD() {
  if(_id_B7148A3BFC4DEFB2())
    return self._id_5E7ED8E7A332998A;

  return self.vehiclename;
}

_id_9005B7FC076293F8() {
  if(isDefined(level._id_A0B2C978CA57FFC5))
    return getarraykeys(level._id_A0B2C978CA57FFC5);
}

vehicle_create(vehicle, _id_7731ADEF63E19B0C, spawndata) {
  vehicle.maxhealth = 2147483647;
  vehicle.health = vehicle.maxhealth;
  vehicle.vehiclename = _id_7731ADEF63E19B0C;
  vehicle._id_22AA4AA0CF0AA6BB = spawndata._id_22AA4AA0CF0AA6BB;
  vehicle setnodeploy(1);
  vehicle makeunusable();
  vehicle scripts\cp_mp\vehicles\vehicle_occupancy::_id_887B4E2CBE3AB92C();

  if(!vehicle _id_B7148A3BFC4DEFB2()) {
    vehicledata = _id_29B4292C92443328(_id_7731ADEF63E19B0C);

    if(istrue(vehicledata.canfly))
      vehicle.isheli = 1;

    vehicle _meth_9A5E0E2D6D715BB1(istrue(vehicledata.interact._id_018F075AAF63A3DA));
    vehicle _id_736DEC95A49487A6::_id_172D848D58051FDF(::_id_78FA8A2FF553F7C8);
    vehicle _id_736DEC95A49487A6::_id_AA823A31304ED981(::_id_0B92C4E2D8733661);
    vehicle scripts\cp_mp\emp_debuff::set_start_emp_callback(::vehicle_empstartcallback);
    vehicle scripts\cp_mp\emp_debuff::set_clear_emp_callback(::vehicle_empclearcallback);
  } else
    vehicle _meth_9A5E0E2D6D715BB1(0);

  if(!istrue(spawndata._id_F16652E1462A3739) && vehicle vehicle_isphysveh() && vehicle _meth_76FA53E72547FF02())
    vehicle _meth_65AA053C077C003A(1);

  if(isDefined(spawndata.owner))
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setoriginalowner(vehicle, spawndata.owner);

  if(isDefined(spawndata.team))
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(vehicle, spawndata.team);
  else
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(vehicle, "neutral");

  if(isDefined(spawndata._id_35FD13041DDE93E8))
    _id_4201160D49C885A7(vehicle, _id_19D89390EE87E7C2(_id_7731ADEF63E19B0C, spawndata._id_35FD13041DDE93E8));

  scripts\cp_mp\utility\weapon_utility::setlockedoncallback(vehicle, ::vehicle_lockedoncallback);
  scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(vehicle, ::vehicle_lockedonremovedcallback);
  scripts\cp_mp\utility\weapon_utility::setincomingcallback(vehicle, ::vehicle_incomingcallback);
  scripts\cp_mp\utility\weapon_utility::setincomingremovedcallback(vehicle, ::vehicle_incomingremovedcallback);
  scripts\cp_mp\utility\weapon_utility::_id_53FD22613EA65204(vehicle, ::_id_A2D1400BCF46869A);
  scripts\cp_mp\utility\weapon_utility::_id_B55A664E824540D2(vehicle, ::_id_A2D1400BCF46869A);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_registerinstance(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::_id_A203F8033EEB57F1(_id_7731ADEF63E19B0C, vehicle);
  vehicle scripts\engine\flags::assign_unique_id();

  if(scripts\common\utility::_id_A10967D736DC56E5() || isnavmeshloaded()) {
    if(istrue(vehicle.isheli) && !istrue(spawndata._id_F16652E1462A3739))
      vehicle thread scripts\common\vehicle_code::vehicle_ai_avoidance_heli();
    else if(!istrue(vehicle.isheli))
      vehicle thread scripts\common\vehicle_code::vehicle_ai_avoidance_logic();
  }

  if((!scripts\common\utility::iscp() || !istrue(spawndata.disableusabilityatspawn)) && !vehicle _id_B7148A3BFC4DEFB2())
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance(vehicle);

  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("vehicle", "create", vehicle, spawndata);
  thread vehicle_update(vehicle);
  thread scripts\cp_mp\vehicles\vehicle_collision::vehicle_collision_updateinstance(vehicle);
}

vehicle_createlate(vehicle, spawndata) {
  vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  scripts\cp_mp\vehicles\vehicle_damage::_id_268E0E5863858DCF(vehicle, spawndata);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(vehicle, spawndata.owner, spawndata.team);
  scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_spawnevent(vehicle, spawndata.spawntype);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "createLate"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "createLate")]](vehicle, spawndata);
}

_id_AB08028468AB68F9(data, immediate) {
  if(isvehicledestroyed()) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(self.vehiclename, "explode"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc(self.vehiclename, "explode")]](data, immediate);
  else if(_id_B7148A3BFC4DEFB2())
    _id_E3FF0A92AD2BF58D(data, immediate);
  else
    _id_9672DA471530B44A(data, immediate);
}

_id_F7AF4D1C91CA6E2F() {
  self _meth_6A325F91941ED47C("p2p");
  self vehicle_cleardrivingstate();
  self _meth_247AD6A91F6A4FFE(0);

  for(;;) {
    self waittill("damage", amount, attacker);

    if(isPlayer(attacker)) {
      continue;
    }
    break;
  }

  _id_AB08028468AB68F9(undefined, 1);
}

_id_E3FF0A92AD2BF58D(data, immediate) {
  if(isvehicledestroyed()) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  self setscriptablepartstate("visibility", "hide", 0);
  thread vehicle_death(self);
  thread scripts\cp_mp\vehicles\vehicle_damage::_id_D0DF49DE517DED03();
}

_id_9672DA471530B44A(data, immediate) {
  if(isvehicledestroyed()) {
    return;
  }
  if(!isDefined(data)) {
    data = spawnStruct();
    data.inflictor = self;
    data.objweapon = scripts\cp_mp\vehicles\vehicle_damage::_id_7AAA7AE503292F43(self.vehiclename);
    data.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_ondeathscore(data);
  _id_AFE012D734BD72C7(data);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, data);
  thread vehicle_death(self, data);
  thread scripts\cp_mp\vehicles\vehicle_damage::_id_D0DF49DE517DED03();

  if(isDefined(data.attacker)) {
    _id_EE8EF5BA92AB121D = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle(_id_D93EC4635290FEBD())._id_EE8EF5BA92AB121D;

    if(!isDefined(_id_EE8EF5BA92AB121D) || _id_EE8EF5BA92AB121D == "")
      _id_EE8EF5BA92AB121D = "generic";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](data.attacker, _func_2EF675C13CA1C4AF("stat_748C50AA6182EC4B", _id_EE8EF5BA92AB121D));
  }
}

vehicle_death(vehicle, damagedata) {
  if(vehicle isvehicledestroyed()) {
    return;
  }
  _id_7731ADEF63E19B0C = vehicle _id_D93EC4635290FEBD();
  _id_F2CF04C055FD760E = istrue(_id_29B4292C92443328(_id_7731ADEF63E19B0C)._id_FB41D1CA75009BF0._id_F2CF04C055FD760E);

  if(vehicle _id_B7148A3BFC4DEFB2())
    scripts\cp_mp\vehicles\vehicle_damage::_id_EC4B6F058D183338(vehicle);

  _id_DEE73A1FA79B1B6D = vehicle.vehicletype;
  _id_35FD13041DDE93E8 = vehicle._id_35FD13041DDE93E8;
  _id_6181DE250AFA5BB6 = undefined;

  if(isDefined(damagedata))
    _id_6181DE250AFA5BB6 = damagedata.attacker;

  vehicle vehicle_deletenextframe(vehicle, _id_6181DE250AFA5BB6);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(_id_7731ADEF63E19B0C, "delete"))
    vehicle[[scripts\cp_mp\utility\script_utility::getsharedfunc(_id_7731ADEF63E19B0C, "delete")]](vehicle);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(_id_7731ADEF63E19B0C, "onEndRiding") && isDefined(vehicle._id_8784C427B1AF24A6)) {
    _id_7B468990DA46C73C = scripts\cp_mp\utility\script_utility::getsharedfunc(_id_7731ADEF63E19B0C, "onEndRiding");

    foreach(player in vehicle._id_8784C427B1AF24A6) {
      if(isDefined(player))
        vehicle[[_id_7B468990DA46C73C]](player);
    }
  }

  _id_575EF651FFAB4369 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(vehicle);

  if(isDefined(_id_575EF651FFAB4369) && istrue(_id_575EF651FFAB4369._id_F16652E1462A3739)) {
    if(isDefined(self.riders)) {
      foreach(g in self.riders) {
        if(isDefined(damagedata) && isDefined(damagedata.attacker) && isPlayer(damagedata.attacker)) {
          _id_371B4C2AB5861E62::_id_350CF0DB9F5E0CBE(g, "vehicleKiller", damagedata.attacker);
          damagedata.attacker thread _id_098B53A7358927D9::_id_E800498086E36C29("stat_EF9582D72160F199", damagedata.objweapon, undefined, undefined, g, undefined, undefined, 1, undefined, 1);
        }
      }
    }

    vehicle scripts\common\vehicle_paths::delete_riders();
  }

  waitframe();
  spawndata = undefined;

  if(_id_F2CF04C055FD760E && !istrue(vehicle._id_A8F4BB03B366AA80))
    spawndata = vehicle scripts\cp_mp\vehicles\vehicle_spawn::_id_75CE57F81B582B38(vehicle, _id_7731ADEF63E19B0C);

  vehicle vehicle_deletenextframelate(vehicle);
  _id_FB41D1CA75009BF0 = undefined;

  if(!vehicle _id_B7148A3BFC4DEFB2() && _id_F2CF04C055FD760E && !istrue(vehicle._id_A8F4BB03B366AA80))
    _id_FB41D1CA75009BF0 = _id_0FFFE750FCE66784(_id_7731ADEF63E19B0C, spawndata, undefined, _id_DEE73A1FA79B1B6D, vehicle.donotwatchabandoned, _id_35FD13041DDE93E8);

  if(isDefined(_id_FB41D1CA75009BF0))
    _id_575EF651FFAB4369 notify("husk_spawn", _id_FB41D1CA75009BF0);
  else
    _id_575EF651FFAB4369 notify("husk_failed");

  if(isDefined(vehicle._id_AA2660B54E981080))
    vehicle._id_AA2660B54E981080 delete();
}

_id_12F5A0E2344C10C5() {
  self.spawndata endon("husk_failed");
  self.spawndata waittill("husk_spawn", _id_FB41D1CA75009BF0);
  return _id_FB41D1CA75009BF0;
}

vehicle_deletenextframe(vehicle, _id_6181DE250AFA5BB6) {
  if(istrue(vehicle.isdestroyed)) {
    return;
  }
  vehicle notify("death", _id_6181DE250AFA5BB6);
  vehicle.isdestroyed = 1;

  if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn() && vehicle scripts\cp_mp\vehicles\vehicle_spawn::_id_81D89CA10080F386()) {
    ref = vehicle _id_D93EC4635290FEBD();
    _id_F2CF04C055FD760E = istrue(_id_29B4292C92443328(ref)._id_FB41D1CA75009BF0._id_F2CF04C055FD760E);

    if((vehicle _id_B7148A3BFC4DEFB2() || !_id_F2CF04C055FD760E || istrue(vehicle._id_A8F4BB03B366AA80)) && scripts\cp_mp\utility\script_utility::issharedfuncdefined(ref, "onDeathRespawn"))
      vehicle thread[[scripts\cp_mp\utility\script_utility::getsharedfunc(ref, "onDeathRespawn")]]();
    else if(vehicle _id_B7148A3BFC4DEFB2())
      vehicle thread scripts\cp_mp\vehicles\vehicle_spawn::_id_FA044E2304E9E1A4();
    else if(!_id_F2CF04C055FD760E || istrue(vehicle._id_A8F4BB03B366AA80))
      vehicle thread scripts\cp_mp\vehicles\vehicle_spawn::_id_284795E4A9E3762C();
  }

  vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  vehicle setnonstick(1);
  scripts\cp_mp\utility\weapon_utility::clearlockedon(vehicle);
  vehicle scripts\cp_mp\emp_debuff::clear_emp(1);
  scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_hide(vehicle);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_deregisterinstance(vehicle);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_deregisterinstance(vehicle);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(vehicle);
  scripts\cp_mp\vehicles\customization\battle_tracks::battle_tracks_stopbattletrackstoalloccupants(vehicle);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "deleteNextFrame"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "deleteNextFrame")]](vehicle);
}

vehicle_deletenextframelate(vehicle) {
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_deregisterinstance(vehicle);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "deleteNextFrameLate"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "deleteNextFrameLate")]](vehicle);

  turrets = vehicle_getturrets(vehicle);

  if(isDefined(turrets)) {
    foreach(turret in turrets)
    turret delete();
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(vehicle);
}

_id_AFE012D734BD72C7(data) {
  _id_7731ADEF63E19B0C = _id_D93EC4635290FEBD();

  if(isDefined(_id_7731ADEF63E19B0C) && isDefined(data)) {
    vehicledata = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C);

    if(isDefined(vehicledata) && istrue(vehicledata._id_45C7E4F315C93C29) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "processScrapAssist"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "processScrapAssist")]](data.attacker);
  }
}

vehicle_update(vehicle) {
  vehicle notify("vehicle_update");
  vehicle endon("vehicle_update");
  level endon("game_ended");

  if(vehicle _id_B7148A3BFC4DEFB2()) {
    return;
  }
  _id_BD169AF9B46727EF = istrue(scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle(vehicle _id_D93EC4635290FEBD())._id_BD169AF9B46727EF);
  _id_79A9BB156A8EF2BF = isDefined(vehicle._id_35FD13041DDE93E8) && isDefined(vehicle._id_35FD13041DDE93E8.vehicletrail);
  canfly = vehicle vehiclecanfly();
  _id_079F057DB79DD500 = scripts\cp_mp\utility\script_utility::issharedfuncdefined(vehicle.vehiclename, "update");
  updatefunc = undefined;

  if(_id_079F057DB79DD500)
    updatefunc = scripts\cp_mp\utility\script_utility::getsharedfunc(vehicle.vehiclename, "update");

  if(!_id_BD169AF9B46727EF && !_id_79A9BB156A8EF2BF && !_id_079F057DB79DD500) {
    return;
  }
  while(isDefined(vehicle) && !istrue(vehicle.isdestroyed)) {
    if(_id_BD169AF9B46727EF)
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsperframe(vehicle);

    if(_id_79A9BB156A8EF2BF) {
      _id_79A9BB156A8EF2BF = vehicle_checktrailvfx(vehicle, canfly);

      if(!_id_79A9BB156A8EF2BF && !_id_BD169AF9B46727EF && !_id_079F057DB79DD500)
        return;
    }

    if(_id_079F057DB79DD500) {
      data = spawnStruct();
      vehicle[[updatefunc]](data);
    }

    waitframe();
  }
}

vehicle_checktrailvfx(vehicle, canfly) {
  trail = vehicle._id_35FD13041DDE93E8.vehicletrail;
  velocity = vehicle vehicle_getvelocity();
  forward = anglesToForward(vehicle.angles);
  state = vehicle getscriptablepartstate("trail");

  if(state == "disabled")
    return 0;

  if(canfly && isDefined(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(vehicle)))
    _id_9B1941CB7354665E = trail;
  else if(vehicle vehicle_getspeed() > 1 && vectordot(velocity, forward) >= 0)
    _id_9B1941CB7354665E = trail;
  else
    _id_9B1941CB7354665E = trail + "_idle";

  if(state == _id_9B1941CB7354665E)
    return 1;

  if(vehicle getscriptableparthasstate("trail", _id_9B1941CB7354665E))
    vehicle setscriptablepartstate("trail", _id_9B1941CB7354665E);

  return 1;
}

vehicle_registerturret(vehicle, entity, objweapon, _id_D112D057A062EE5E) {
  if(!isDefined(entity.objweapon))
    entity.objweapon = objweapon;

  if(!isDefined(vehicle.turrets))
    vehicle.turrets = [];

  weaponname = undefined;

  if(isstring(objweapon))
    weaponname = objweapon;
  else
    weaponname = objweapon.basename;

  vehicle.turrets[weaponname] = entity;
  childoutlineents = vehicle.childoutlineents;

  if(!isDefined(childoutlineents))
    childoutlineents = [vehicle];

  if(!scripts\engine\utility::array_contains(childoutlineents, entity))
    childoutlineents = scripts\engine\utility::array_add(childoutlineents, entity);

  vehicle.childoutlineents = childoutlineents;

  if(istrue(_id_D112D057A062EE5E))
    thread vehicle_trackturretprojectile(vehicle, entity);
}

vehicle_deregisterturret(vehicle, objweapon) {
  if(!isDefined(vehicle.turrets)) {
    return;
  }
  weaponname = undefined;

  if(isstring(objweapon))
    weaponname = objweapon;
  else
    weaponname = objweapon.basename;

  entity = vehicle.turrets[weaponname];
  vehicle.turrets[weaponname] = undefined;

  if(isDefined(entity)) {
    childoutlineents = vehicle.childoutlineents;

    if(isDefined(childoutlineents)) {
      childoutlineents = scripts\engine\utility::array_remove(childoutlineents, entity);
      vehicle.childoutlineents = childoutlineents;
    }

    entity notify("vehicle_trackTurretProjectile");
  }
}

vehicle_getturretbyweapon(vehicle, objweapon) {
  if(!isDefined(vehicle.turrets))
    return undefined;

  weaponname = undefined;

  if(isstring(objweapon))
    weaponname = objweapon;
  else
    weaponname = objweapon.basename;

  return vehicle.turrets[weaponname];
}

vehicle_getturrets(vehicle) {
  turrets = [];

  if(isDefined(vehicle.turrets))
    turrets = vehicle.turrets;

  return turrets;
}

vehicle_trackturretprojectile(vehicle, entity) {
  entity endon("death");
  entity notify("vehicle_trackTurretProjectile");
  entity endon("vehicle_trackTurretProjectile");

  for(;;) {
    entity waittill("missile_fire", missile);

    if(isDefined(missile))
      missile.vehicle = vehicle;
  }
}

vehicle_isfriendlytoplayer(vehicle, player) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered(vehicle))
    return scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isfriendlytoplayer(vehicle, player);
  else if(level.teambased) {
    team = vehicle.team;

    if(!isDefined(team) || team == "neutral") {
      if(isDefined(vehicle.owner))
        vehicle.team = vehicle.owner.team;
    }

    if(!isDefined(team))
      return 0;

    return vehicle.team == player.team;
  } else
    return isDefined(vehicle.owner) && vehicle.owner == player;
}

vehicle_isenemytoplayer(vehicle, player) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered(vehicle))
    return scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isenemytoplayer(vehicle, player);
  else if(level.teambased) {
    team = vehicle.team;

    if(!isDefined(team) || team == "neutral") {
      if(isDefined(vehicle.owner))
        vehicle.team = vehicle.owner.team;
    }

    if(!isDefined(team))
      return 0;

    return vehicle.team != player.team;
  } else
    return isDefined(vehicle.owner) && vehicle.owner != player;
}

vehicle_isneutraltoplayer(vehicle, player) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered(vehicle))
    return scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isneutraltoplayer(vehicle, player);
  else if(level.teambased)
    return (!isDefined(vehicle.team) || vehicle.team == "neutral") && !isDefined(vehicle.owner);
  else
    return !isDefined(vehicle.owner);
}

vehicle_isfriendlytoteam(vehicle, team) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered(vehicle))
    return scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isfriendlytoteam(vehicle, team);
  else {
    if(level.teambased)
      return isDefined(vehicle.team) && vehicle.team == team;

    return undefined;
  }
}

vehicle_isenemytoteam(vehicle, team) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered(vehicle))
    return scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isenemytoteam(vehicle, team);
  else {
    if(level.teambased)
      return isDefined(vehicle.team) && vehicle.team != team;

    return undefined;
  }
}

vehicle_isneutraltoteam(vehicle, team) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered(vehicle))
    return scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isneutraltoteam(vehicle, team);
  else {
    if(level.teambased)
      return !isDefined(vehicle.team) || vehicle.team == "neutral";

    return undefined;
  }
}

vehicle_getteamfriendlyto(vehicle) {
  if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered(vehicle))
    return scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getteamfriendlyto(vehicle);
  else {
    if(isDefined(vehicle.team) && vehicle.team != "neutral")
      return vehicle.team;

    return undefined;
  }
}

vehicle_docollisiondamagetoplayer(vehicle, player, _id_F8048727716242B0) {
  isenemy = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isenemytoplayer(vehicle, player);

  if(istrue(_id_F8048727716242B0) || isenemy) {
    _id_ADE894A502513A02 = istrue(player.inlaststand);
    _id_FCDF19E3CDD29669 = player.health;

    if(isDefined(vehicle.objweapon))
      level._id_52F65A03EFF3D1A2 = "MOD_EXPLOSIVE";

    attacker = undefined;

    if(!isenemy)
      attacker = player;
    else if(isDefined(vehicle.streakinfo))
      attacker = scripts\engine\utility::_id_53C4C53197386572(vehicle.owner, player);
    else
      attacker = scripts\engine\utility::_id_53C4C53197386572(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(vehicle), player);

    player dodamage(1000, vehicle.origin, attacker, vehicle, "MOD_CRUSH", vehicle.objweapon);
    level._id_52F65A03EFF3D1A2 = undefined;

    if(!isalive(player))
      return 1;

    if(!_id_ADE894A502513A02 && istrue(player.inlaststand))
      return 1;

    if(_id_FCDF19E3CDD29669 > player.health)
      return 1;
  }

  return 0;
}

vehicle_preventplayercollisiondamagefortimeafterexit(vehicle, player) {
  player endon("disconnect");
  player notify("vehicle_preventPlayerCollisionDamageForTimeAfterExit");
  player endon("vehicle_preventPlayerCollisionDamageForTimeAfterExit");
  player.vehiclecollisionignorearray = [];
  player.vehiclecollisionignorearray["inflictor"] = vehicle;
  player.vehiclecollisionignorearray["meansOfDeath"] = "MOD_CRUSH";
  vehicle_preventplayercollisiondamagefortimeafterexitinternal(player);
  thread vehicle_clearpreventplayercollisiondamagefortimeafterexit(player);
}

vehicle_preventplayercollisiondamagefortimeafterexitinternal(player) {
  player endon("death");
  wait 4;
}

vehicle_clearpreventplayercollisiondamagefortimeafterexit(player) {
  player notify("vehicle_preventPlayerCollisionDamageForTimeAfterExit");
  player.vehiclecollisionignorearray = undefined;
}

vehicle_playershouldignorecollisiondamage(inflictor, victim, meansofdeath, objweapon) {
  if(!isDefined(victim.vehiclecollisionignorearray))
    return 0;

  if(!isDefined(inflictor))
    return 0;

  if(isDefined(victim.vehiclecollisionignorearray["inflictor"]) && inflictor != victim.vehiclecollisionignorearray["inflictor"])
    return 0;

  if(meansofdeath != victim.vehiclecollisionignorearray["meansOfDeath"])
    return 0;

  return 1;
}

_id_E4768BD722E98562(inflictor, victim, smeansofdeath) {
  if(!isDefined(smeansofdeath) || smeansofdeath != "MOD_CRUSH")
    return 0;

  if(!isDefined(victim) || !isDefined(victim.origin))
    return 0;

  if(!isDefined(inflictor) || !isDefined(inflictor.origin) || !isDefined(inflictor.angles))
    return 0;

  if(!inflictor isvehicle() || inflictor.vehiclename == "cargo_train" || !isent(inflictor))
    return 0;

  _id_7731ADEF63E19B0C = inflictor _id_D93EC4635290FEBD();

  if(!_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C))
    return 0;

  data = _id_29B4292C92443328(_id_7731ADEF63E19B0C);

  if(istrue(data.canfly) || istrue(data._id_941D95491D4D4817))
    return 0;

  if(!isDefined(data.occupancy) || !isDefined(data.occupancy.exitextents))
    return 0;

  if(!inflictor vehicle_isonground())
    return 0;

  if(inflictor vehicle_getspeed() < 1)
    return 0;

  _id_31901FB1AD49530A = data.occupancy.exitextents;

  if(!isDefined(_id_31901FB1AD49530A["front"]) || !isDefined(_id_31901FB1AD49530A["back"]))
    return 0;

  forward = anglesToForward(inflictor.angles);
  moving = inflictor vehicle_getvelocity();
  _id_8423818ECF85A883 = scripts\engine\math::anglebetweenvectors(forward, moving);
  _id_801901A9FB6CDC30 = undefined;

  if(_id_8423818ECF85A883 < 45)
    _id_801901A9FB6CDC30 = 1;
  else if(_id_8423818ECF85A883 > 135)
    _id_801901A9FB6CDC30 = 0;
  else
    return 0;

  _id_EA3B9640A6AD3C8E = _func_D559A384B9C4E7D9(victim.origin, inflictor.origin, inflictor.angles);

  if(_id_801901A9FB6CDC30 && _id_EA3B9640A6AD3C8E[0] < _id_31901FB1AD49530A["front"] - 30)
    return 1;

  if(!_id_801901A9FB6CDC30 && _id_EA3B9640A6AD3C8E[0] > -1 * (_id_31901FB1AD49530A["back"] - 30))
    return 1;

  return 0;
}

_id_4687F4DA72911323(_id_642470E1ABC1BBF9) {
  if(!isDefined(_id_642470E1ABC1BBF9.meansofdeath) || _id_642470E1ABC1BBF9.meansofdeath != "MOD_CRUSH")
    return 0;

  if(!isDefined(_id_642470E1ABC1BBF9.inflictor) || !_id_642470E1ABC1BBF9.inflictor isvehicle())
    return 0;

  return 1;
}

_id_107EFD42D596B2D3(_id_642470E1ABC1BBF9) {
  return isdismembermentenabled() && !istrue(_id_642470E1ABC1BBF9.victim._id_C4C8B91E0B16AA5E) && istrue(_id_642470E1ABC1BBF9.inflictor.isheli) && _id_642470E1ABC1BBF9.damage == 999999;
}

vehicle_playerkilledbycollision(_id_642470E1ABC1BBF9) {
  if(!_id_4687F4DA72911323(_id_642470E1ABC1BBF9)) {
    return;
  }
  if(_id_107EFD42D596B2D3(_id_642470E1ABC1BBF9))
    thread vehicle_playerkilledfx(_id_642470E1ABC1BBF9.victim);
  else
    playsoundatpos(_id_642470E1ABC1BBF9.victim.origin + (0, 0, 18), "vehicle_body_hit");
}

vehicle_playerkilledfx(victim) {
  _id_13F57E11D55F32D4 = 35;
  victim.nocorpse = 1;
  playsoundatpos(victim.origin + (0, 0, 18), "vehicle_body_hit");
  players = scripts\cp_mp\utility\player_utility::getdismembermentlist();

  if(players.size < _id_13F57E11D55F32D4) {
    fxent = spawn("script_model", victim gettagorigin("j_mainroot"));
    fxent.angles = victim.angles;
    fxent setModel("iw9_player_death_fx");
    fxent setscriptablepartstate("effects", "gib", 0);

    foreach(player in players)
    fxent hidefromplayer(player);

    wait 0.5;
    fxent delete();
  }
}

_id_1B69321FF9937FC5() {
  level endon("game_ended");
  self endon("death");
  ref = _id_D93EC4635290FEBD();
  _id_E751A1EB999DD1A5 = ref == "light_tank" || ref == "veh9_cougar";
  interactdata = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle(ref);
  _id_F9F7DB3DD47E1280 = interactdata._id_F9F7DB3DD47E1280;

  for(;;) {
    self waittill("floating");

    while(self _meth_100D3BF35FCA6A7F() > 0.01) {
      endtime = gettime() + 1000 * _id_F9F7DB3DD47E1280;

      for(;;) {
        waitframe();

        if(!_id_9502AA416CCD1247()) {
          break;
        }

        if(gettime() >= endtime) {
          break;
        }
      }

      if(_id_9502AA416CCD1247()) {
        self._id_F6B881F5981D97C7 = 1;

        if(self vehicle_isphysveh())
          self _meth_B0AF0DD0F9B4FDDF(0);

        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowspawninto(self, 0);
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(self, 0);
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 0);

        if(!_id_E751A1EB999DD1A5)
          wait 5;

        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(self);
        scripts\cp_mp\vehicles\vehicle_occupancy::_id_D0092C44C5588870();
        wait(scripts\engine\utility::ter_op(_id_E751A1EB999DD1A5, 10, 25));
        thread scripts\cp_mp\vehicles\vehicle_spawn::_id_357783D7C1D96273();
        return;
      }
    }
  }
}

_id_4A387C035EB677D0(_id_941D95491D4D4817) {
  level endon("game_ended");
  self endon("death");
  self waittill("veh_submerged");
  self._id_F6B881F5981D97C7 = 1;
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowspawninto(self, 0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(self, 0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 0);

  if(!_id_941D95491D4D4817)
    wait 1;

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(self);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_D0092C44C5588870();

  if(!_id_941D95491D4D4817)
    wait 15;

  thread scripts\cp_mp\vehicles\vehicle_spawn::_id_357783D7C1D96273();
}

vehicle_watchflipped() {
  self endon("death");
  self endon("flipped_end");
  level endon("game_ended");
  ref = _id_D93EC4635290FEBD();
  _id_6397176A090F7ACA = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(ref, "flippedStart"))
    _id_6397176A090F7ACA = scripts\cp_mp\utility\script_utility::getsharedfunc(ref, "flippedStart");

  _id_267AAEF67672447F = ::vehicle_flippedendcallback;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(ref, "flippedEnd"))
    _id_267AAEF67672447F = scripts\cp_mp\utility\script_utility::getsharedfunc(ref, "flippedEnd");

  data = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle(ref);
  _id_BA70A83BE9B6B59C = data._id_BA70A83BE9B6B59C;
  _id_B1FC50342F9A99DD = data._id_B1FC50342F9A99DD;
  _id_6EF53048A884F4E0 = 0;
  starttime = undefined;
  endtime = undefined;

  for(;;) {
    wait 1;
    _id_0D1D371436301D73 = 0;
    angle = scripts\engine\math::anglebetweenvectorsunit((0, 0, 1), anglestoup(self.angles));

    if(angle > _id_B1FC50342F9A99DD) {
      _id_0D1D371436301D73 = 1;
      starttime = undefined;
    } else if(angle > _id_BA70A83BE9B6B59C) {
      if(!isDefined(starttime))
        starttime = gettime() + 3000;

      if(gettime() > starttime) {
        _id_0D1D371436301D73 = 1;
        starttime = undefined;
      }
    } else {
      if(_id_6EF53048A884F4E0) {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowspawninto(self, 1);
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(self, 1);
        _id_6EF53048A884F4E0 = 0;
      }

      _id_0D1D371436301D73 = 0;
      starttime = undefined;
    }

    if(_id_0D1D371436301D73) {
      if(isDefined(_id_6397176A090F7ACA))
        thread[[_id_6397176A090F7ACA]](self);

      if(!_id_6EF53048A884F4E0) {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowspawninto(self, 0);
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(self, 0);
        _id_6EF53048A884F4E0 = 1;
      }

      if(getdvarint("dvar_CE3FFD0926397091", 0) == 1)
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(self);

      _id_DD9707A466EFA528 = 0;
      endtime = gettime() + 3000;

      for(;;) {
        waitframe();
        angle = scripts\engine\math::anglebetweenvectorsunit((0, 0, 1), anglestoup(self.angles));

        if(angle <= _id_BA70A83BE9B6B59C) {
          break;
        }

        if(gettime() >= endtime) {
          _id_DD9707A466EFA528 = 1;
          break;
        }
      }

      endtime = undefined;

      if(isDefined(_id_267AAEF67672447F))
        thread[[_id_267AAEF67672447F]](self, _id_DD9707A466EFA528);
    }
  }
}

vehicle_flippedendcallback(vehicle, _id_DD9707A466EFA528) {
  if(_id_DD9707A466EFA528 && !istrue(vehicle._id_F6B881F5981D97C7)) {
    vehicle._id_F6B881F5981D97C7 = 1;
    vehicle thread scripts\cp_mp\vehicles\vehicle_spawn::_id_357783D7C1D96273();
  }
}

vehicle_deletecollmapvehicles() {
  level notify("vehicle_deleteCollmapVehicles");
  level endon("vehicle_deleteCollmapVehicles");
  wait 1;
  vehicles = getEntArray("delete_me", "targetname");

  if(isDefined(vehicles) && vehicles.size > 0) {
    for(_id_AC0E594AC96AA3A8 = vehicles.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--)
      vehicles[_id_AC0E594AC96AA3A8] delete();
  }
}

_id_78FA8A2FF553F7C8(data) {
  vehicle = data.victim;

  if(istrue(vehicle._id_12BFB031C0A0EFD8) || istrue(vehicle._id_4970CB0EDEF7623B)) {
    return;
  }
  vehicle._id_12BFB031C0A0EFD8 = 1;
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(vehicle, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("shockStickAttached", occupants, vehicle.vehiclename);
  vehicle._id_70EC04F736523DD0 = vehicle vehicle_gettopspeedforward();
  vehicle._id_ABDFBC385C923E9F = vehicle vehicle_gettopspeedreverse();
  vehicle vehicle_settopspeedforward(10.0);
  vehicle vehicle_settopspeedreverse(10.0);
  vehicle scripts\common\utility::_id_3677F2BE30FDD581("haywire", "on");
}

_id_0B92C4E2D8733661(data) {
  vehicle = data.victim;

  if(!isDefined(vehicle) || istrue(vehicle._id_4970CB0EDEF7623B)) {
    return;
  }
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(vehicle, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("shockStickAttached", occupants, vehicle.vehiclename);

  if(isDefined(vehicle._id_70EC04F736523DD0))
    vehicle vehicle_settopspeedforward(vehicle._id_70EC04F736523DD0);

  if(isDefined(vehicle._id_ABDFBC385C923E9F))
    vehicle vehicle_settopspeedreverse(vehicle._id_ABDFBC385C923E9F);

  vehicle._id_70EC04F736523DD0 = undefined;
  vehicle._id_ABDFBC385C923E9F = undefined;
  vehicle scripts\common\utility::_id_3677F2BE30FDD581("haywire", "off");
}

vehicle_lockedoncallback() {
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", occupants, self.vehiclename);

  foreach(_id_F85572CD5F6117C6 in occupants) {
    _id_F85572CD5F6117C6 stoplocalsound("veh_warning_missile_locking");
    _id_F85572CD5F6117C6 playlocalsound("veh_warning_missile_locking");
  }
}

vehicle_lockedonremovedcallback() {
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", occupants, self.vehiclename);

  foreach(_id_F85572CD5F6117C6 in occupants)
  _id_F85572CD5F6117C6 stoplocalsound("veh_warning_missile_locking");
}

_id_A2D1400BCF46869A() {
  _id_047F2A8EC0EF5ED2 = istrue(self._id_15C05FE1C0F6DE03);
  _id_AC7254614112A03C = 0;

  if(isDefined(self._id_F2F04BCC448FAB3A)) {
    foreach(team in self._id_F2F04BCC448FAB3A) {
      if(!vehicle_isfriendlytoteam(self, team)) {
        _id_AC7254614112A03C = 1;
        break;
      }
    }
  }

  if(_id_047F2A8EC0EF5ED2 == _id_AC7254614112A03C) {
    return;
  }
  self._id_15C05FE1C0F6DE03 = _id_AC7254614112A03C;
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self, 0);

  if(_id_AC7254614112A03C)
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("BunkerBusterAttached", occupants, self.vehiclename);
  else
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("BunkerBusterAttached", occupants, self.vehiclename);
}

vehicle_incomingcallback() {
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileIncoming", occupants, self.vehiclename);

  foreach(_id_F85572CD5F6117C6 in occupants) {
    _id_F85572CD5F6117C6 stoplocalsound("veh_warning_missile_incoming");
    _id_F85572CD5F6117C6 playlocalsound("veh_warning_missile_incoming");
  }
}

vehicle_incomingremovedcallback() {
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileIncoming", occupants, self.vehiclename);

  foreach(_id_F85572CD5F6117C6 in occupants)
  _id_F85572CD5F6117C6 stoplocalsound("veh_warning_missile_incoming");
}

vehicle_empstartcallback(data) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp", "onVehicleEMPed"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("emp", "onVehicleEMPed")]](data);

  if(isDefined(self._id_B31F13A4E30B5AA5))
    self._id_0285A0756C95A7A5 = 1;

  self._id_EC76FFDBE2F37C5B = 1;
  scripts\common\utility::_id_3677F2BE30FDD581("ddos", "disabled");

  if(getdvarint("dvar_10320E52E3E9AB5C", 0) == 0) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self, 0);
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("DDoSed", occupants, self.vehiclename);
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 0, 0, self._id_64C5A4A6F78C0674);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_A1A583C3CC871645(0);
}

vehicle_empclearcallback(_id_FCEF8D217A441961) {
  if(!_id_FCEF8D217A441961)
    scripts\common\utility::_id_3677F2BE30FDD581("ddos", "neutral");

  if(isDefined(self._id_B31F13A4E30B5AA5))
    self._id_0285A0756C95A7A5 = undefined;

  self._id_EC76FFDBE2F37C5B = undefined;

  if(getdvarint("dvar_10320E52E3E9AB5C", 0) == 0) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::_id_0EFA75AA7F0A1289(self, 0);
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("DDoSed", occupants, self.vehiclename);
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 1);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_A1A583C3CC871645(1);
}

_id_810DFD134E9A7A04(vehicledata) {
  self.script_badplace = 1;
  scripts\engine\utility::ent_flag_init("unloaded");
  scripts\engine\utility::ent_flag_init("loaded");
  scripts\engine\utility::ent_flag_init("landed");
  self.riders = [];
  self.unloadque = [];
  self.unload_group = "default";
  self.fastroperig = [];
  self.vehicleanimalias = vehicledata.ai.vehicleanimalias;
  self.classname_mp = vehicledata.ai.classname;
  thread scripts\common\vehicle_aianim::handle_attached_guys();
}

_id_95022424D8B0DC1C(_id_7731ADEF63E19B0C) {
  if(!_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C))
    return 0;

  data = _id_29B4292C92443328(_id_7731ADEF63E19B0C);

  if(!isDefined(data.ai) || !istrue(data.ai._id_289DF80E1DED586F))
    return 0;

  return data._id_F4EAE2A1481B7DD3.size;
}

_id_F92FAAAF5C5077C6(riders, spawninvehicle, _id_420BA29D9EFC4756) {
  _id_7731ADEF63E19B0C = _id_D93EC4635290FEBD();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(_id_7731ADEF63E19B0C, "loadAI"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc(_id_7731ADEF63E19B0C, "loadAI")]](riders, spawninvehicle, _id_420BA29D9EFC4756);
  else
    _id_19E0F5686D59B76F(riders, spawninvehicle, _id_420BA29D9EFC4756);
}

_id_19E0F5686D59B76F(riders, spawninvehicle, _id_420BA29D9EFC4756) {
  if(!isDefined(spawninvehicle))
    spawninvehicle = 0;

  scripts\cp_mp\vehicles\vehicle_occupancy::_id_9E710C9F3A15FFDA();
  thread _id_0F77E18D192719AC();
  vehicledata = _id_29B4292C92443328(_id_D93EC4635290FEBD());
  turrets = [];

  foreach(turret in vehicle_getturrets(self))
  turrets[turrets.size] = turret;

  foreach(index, rider in riders) {
    if(!isDefined(rider) || !isDefined(rider._blackboard)) {
      _id_ED7BBD7E1327B7FB(rider);
      continue;
    }

    _id_B87E69DF003B39F5 = scripts\common\vehicle_aianim::get_availablepositions();

    if(isDefined(rider.spawner) && isDefined(rider.spawner.script_startingposition))
      rider.script_startingposition = int(rider.spawner.script_startingposition);
    else if(!isDefined(rider.script_startingposition)) {
      rider.script_startingposition = index;

      if(isDefined(rider.spawner))
        rider.spawner.script_startingposition = index;
    }

    pos = scripts\common\vehicle_aianim::choose_vehicle_position(rider, _id_B87E69DF003B39F5, 0);
    rider.vehicle_position = pos.vehicle_position;
    rider thread scripts\vehicle\vehicle_common::entervehicle(self, spawninvehicle, pos, scripts\common\vehicle_aianim::anim_pos(self, pos.vehicle_position));
    thread _id_36581EAB345137D4(rider);
    self.riders[self.riders.size] = rider;
    rider.ridingvehicle = self;
    rider.vehicle = self;

    if(isDefined(rider.team) && pos.vehicle_position == 0) {
      self._id_FE321E008E65C319 = rider;
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self, rider.team);

      if(!istrue(_id_420BA29D9EFC4756))
        rider thread _id_35F4A61CE36D99BB(self);

      continue;
    }

    if(isDefined(vehicledata._id_F4EAE2A1481B7DD3[pos.vehicle_position]) && istrue(vehicledata._id_F4EAE2A1481B7DD3[pos.vehicle_position].mgturret) && turrets.size > 0) {
      if(!isDefined(self.mgturret))
        self.mgturret = [];

      turret = turrets[self.mgturret.size];

      if(!isDefined(turret)) {
        continue;
      }
      self.mgturret[self.mgturret.size] = turret;
      turret setturretteam(rider.team);
      rider _id_6FBA7DF440C493C4::use_vehicle_turret(turret, "stand");
    }
  }
}

_id_ED7BBD7E1327B7FB(rider) {}

_id_36581EAB345137D4(rider) {
  self endon("death");
  self endon("unloaded");
  rider waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self.riders = scripts\engine\utility::array_remove(self.riders, rider);
}

_id_0F77E18D192719AC() {
  self endon("unloaded");
  self waittill("death");
  thread scripts\common\vehicle_code::vehicle_killriders();
}

_id_35F4A61CE36D99BB(vehicle) {
  vehicle endon("unloaded");
  vehicle endon("death");
  vehicle endon("vehicle_OnDriverDeath_early");
  self waittill("death");
  vehicle notify("driverdeath");

  if(istrue(vehicle.isheli)) {
    if(istrue(vehicle._id_E6036CC5FE1C5C9E))
      vehicle thread _id_F7AF4D1C91CA6E2F();
    else {
      wait 1.5;
      vehicle thread _id_AB08028468AB68F9(undefined, 1);
    }
  } else if(istrue(vehicle._id_6E156BE4871C1ABD))
    vehicle thread _id_24E4405CF93F20ED::_id_FB7E5919765650EA();
}

_id_1CD6D75165ECBC48() {
  if(getdvarint("dvar_742CAA13B3C2E685"))
    return undefined;

  if(isagent(self))
    return undefined;

  vehiclecustomization = spawnStruct();
  vehiclecustomization._id_94B01AC7CDDDF04D = [];
  vehiclecustomization._id_37DF38D20E12F77D = [];
  _id_AC35FE7145852EE1 = _func_03CB5DA19764BAA3();

  if(_id_AC35FE7145852EE1 == "JUP")
    return vehiclecustomization;

  foreach(ref, data in level._id_A0B2C978CA57FFC5) {
    _id_039FB4F123CB0FF0 = _id_86F6F784630B11FB(ref);

    if(!isDefined(_id_039FB4F123CB0FF0)) {
      continue;
    }
    vehiclecustomization._id_37DF38D20E12F77D[ref] = _id_4D5B0A0260555DCD(_id_039FB4F123CB0FF0);
    vehiclecustomization._id_94B01AC7CDDDF04D[ref] = getvehicleplayerhorn(_id_039FB4F123CB0FF0);
  }

  return vehiclecustomization;
}

_id_4D5B0A0260555DCD(data) {
  if(!isDefined(data) || !isDefined(data._id_35FD13041DDE93E8) || data._id_35FD13041DDE93E8.size == 0)
    return undefined;

  id = self getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", data.ref, "camo");
  id = id - 1;

  if(isDefined(id))
    return data._id_35FD13041DDE93E8[id];

  return undefined;
}

getvehicleplayerhorn(data) {
  if(!isDefined(data) || !isDefined(data._id_94B01AC7CDDDF04D) || data._id_94B01AC7CDDDF04D.size == 0)
    return undefined;

  id = self getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", data.ref, "horn");
  id = id - 1;

  if(isDefined(id) && isDefined(data._id_94B01AC7CDDDF04D[id]))
    return data._id_94B01AC7CDDDF04D[id].alias;

  return undefined;
}

_id_471CDE1983A05F66(player, _id_7731ADEF63E19B0C) {
  _id_35FD13041DDE93E8 = undefined;

  if(isDefined(player.vehiclecustomization._id_37DF38D20E12F77D[_id_7731ADEF63E19B0C]))
    _id_35FD13041DDE93E8 = player.vehiclecustomization._id_37DF38D20E12F77D[_id_7731ADEF63E19B0C];
  else if(getdvarint("dvar_42C1E6EB518BF4FC", 0) == 1 && scripts\engine\utility::cointoss()) {
    data = _id_29B4292C92443328(_id_7731ADEF63E19B0C);

    if(isDefined(data) && isDefined(data._id_35FD13041DDE93E8) && data._id_35FD13041DDE93E8.size > 0)
      _id_35FD13041DDE93E8 = scripts\engine\utility::random(data._id_35FD13041DDE93E8);
  } else if(getdvarint("dvar_D0405B9FEE9D9869", -1) > -1) {
    _id_41A3450F3FBFFF13 = getdvarint("dvar_D0405B9FEE9D9869", -1);
    data = _id_29B4292C92443328(_id_7731ADEF63E19B0C);

    if(isDefined(data) && isDefined(data._id_35FD13041DDE93E8) && data._id_35FD13041DDE93E8.size > 0 && _id_41A3450F3FBFFF13 < data._id_35FD13041DDE93E8.size)
      _id_35FD13041DDE93E8 = data._id_35FD13041DDE93E8[_id_41A3450F3FBFFF13];
  }

  return _id_35FD13041DDE93E8;
}

_id_4201160D49C885A7(vehicle, _id_35FD13041DDE93E8) {
  if(!isDefined(_id_35FD13041DDE93E8)) {
    return;
  }
  vehicle._id_35FD13041DDE93E8 = _id_35FD13041DDE93E8;
  vehicle _meth_788D3C14D6B4BA6B(_id_35FD13041DDE93E8.ref);

  if(isDefined(_id_35FD13041DDE93E8._id_FE99F86A708E76EF) || isDefined(_id_35FD13041DDE93E8._id_9C6D62E1C42BE80A)) {
    foreach(weapon, turret in vehicle_getturrets(vehicle)) {
      if(isDefined(_id_35FD13041DDE93E8._id_9C6D62E1C42BE80A) && isDefined(_id_35FD13041DDE93E8._id_9C6D62E1C42BE80A[weapon])) {
        turret setvehicleturretcamo(_id_35FD13041DDE93E8._id_9C6D62E1C42BE80A[weapon]);
        continue;
      }

      if(isDefined(_id_35FD13041DDE93E8._id_FE99F86A708E76EF))
        turret setvehicleturretcamo(_id_35FD13041DDE93E8._id_FE99F86A708E76EF);
    }
  }

  if(isDefined(_id_35FD13041DDE93E8.vehicletrail))
    vehicle thread vehicle_update(vehicle);
}

_id_19D89390EE87E7C2(_id_7731ADEF63E19B0C, _id_B687F9C1EF7E6A28) {
  if(!isDefined(_id_B687F9C1EF7E6A28) || !isDefined(_id_7731ADEF63E19B0C)) {
    return;
  }
  data = _id_86F6F784630B11FB(_id_7731ADEF63E19B0C);

  if(!isDefined(data) || !isDefined(data._id_35FD13041DDE93E8)) {
    return;
  }
  _id_962EF6817910EC78 = undefined;

  foreach(struct in data._id_35FD13041DDE93E8) {
    if(scripts\engine\utility::is_equal(_id_B687F9C1EF7E6A28, struct.ref))
      return struct;
  }
}

_id_86F6F784630B11FB(_id_7731ADEF63E19B0C) {
  data = _id_29B4292C92443328(_id_7731ADEF63E19B0C);

  if(isDefined(data) && isDefined(data._id_CD5AB16B94BC2745)) {
    _id_7731ADEF63E19B0C = data._id_CD5AB16B94BC2745;

    if(!_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C)) {
      if(!isDefined(level._id_C7FEE21D5D5E1A1C))
        level._id_C7FEE21D5D5E1A1C = [];

      if(isDefined(level._id_C7FEE21D5D5E1A1C[_id_7731ADEF63E19B0C]))
        data = level._id_C7FEE21D5D5E1A1C[_id_7731ADEF63E19B0C];
      else {
        _id_FA3697898BE9A322 = _id_7731ADEF63E19B0C + scripts\engine\utility::ter_op(!scripts\common\utility::iscp(), "_mp", "_cp");
        data = _func_50F8A8F765BAD85E(_func_2EF675C13CA1C4AF("enum_1A8BE015B33237A4", _id_FA3697898BE9A322), ["stat_89E9C01960F4C582", "stat_FAD9715041E583AF", "stat_E86873F0FA4FE5EF", "stat_30599E7B3D259869", "stat_07E353191747E874"]);
        level._id_C7FEE21D5D5E1A1C[_id_7731ADEF63E19B0C] = data;
      }
    } else
      data = _id_29B4292C92443328(_id_7731ADEF63E19B0C);
  }

  if(!isDefined(data) || !isDefined(data.vehicle) || !isDefined(data.interact) || istrue(data.interact._id_6BE1425A9EA8586D))
    return undefined;

  if((!isDefined(data._id_94B01AC7CDDDF04D) || data._id_94B01AC7CDDDF04D.size == 0) && (!isDefined(data._id_35FD13041DDE93E8) || data._id_35FD13041DDE93E8.size == 0) && !istrue(data._id_539862AA827974A3))
    return undefined;

  return data;
}

_id_1E24ABEF827F0807() {
  if(getdvarint("dvar_B1E5A269C62E79C7", 1) == 0) {
    return;
  }
  ref = _id_D93EC4635290FEBD();

  if(!isDefined(ref) || !_id_89DC39DC11F3988C(ref)) {
    return;
  }
  data = _id_29B4292C92443328(ref);

  if(!isDefined(data) || !isDefined(data._id_8F2C463C6016CE59)) {
    return;
  }
  self endon("death");
  childthread _id_45585D05C17C31AA();

  for(;;) {
    self waittill("trick_in", _id_ADD0F0B19CF87473);

    if(!isDefined(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self))) {
      continue;
    }
    if(isDefined(self._id_1FB1C203624107A7[_id_ADD0F0B19CF87473]) && self._id_1FB1C203624107A7[_id_ADD0F0B19CF87473] == gettime()) {
      continue;
    }
    if(!isDefined(data._id_8F2C463C6016CE59[_id_ADD0F0B19CF87473])) {
      continue;
    }
    _id_AA78A8CAF5D9087D = _func_1823FF50BB28148D(_id_ADD0F0B19CF87473);
    childthread _id_436B3366F1D5B495(_id_ADD0F0B19CF87473, data._id_8F2C463C6016CE59[_id_ADD0F0B19CF87473], _id_AA78A8CAF5D9087D);
  }
}

_id_436B3366F1D5B495(_id_ADD0F0B19CF87473, _id_37879FC7B1CC0618, _id_AA78A8CAF5D9087D) {
  self notify(_id_ADD0F0B19CF87473 + "_rewarding");
  self endon(_id_ADD0F0B19CF87473 + "_rewarding");
  self endon(_id_ADD0F0B19CF87473 + "_ended");
  _id_F5429DC7523F92F8 = scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("rank", "getScoreInfoXP", _id_AA78A8CAF5D9087D);
  wait(_id_37879FC7B1CC0618.delay);
  player = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

  if(!isDefined(player)) {
    return;
  }
  player scripts\cp_mp\challenges::_id_5C3AA65DB46763FF(self, _id_ADD0F0B19CF87473);

  if(_id_ADD0F0B19CF87473 == "frontflip" || _id_ADD0F0B19CF87473 == "backflip" || _id_ADD0F0B19CF87473 == "nacnac_left" || _id_ADD0F0B19CF87473 == "nacnac_right" || _id_ADD0F0B19CF87473 == "superman")
    player scripts\cp_mp\challenges::_id_5C3AA65DB46763FF(self, "any_air_trick");

  if(!isDefined(self._id_DDFBC5F492FB65C6))
    self._id_DDFBC5F492FB65C6 = [];

  index = scripts\engine\utility::array_find(self._id_DDFBC5F492FB65C6, _id_ADD0F0B19CF87473);
  _id_E101B88D6655F13B = 1;

  if(isDefined(index)) {
    switch (index) {
      case 0:
        _id_E101B88D6655F13B = 0.2;
        break;
      case 1:
        _id_E101B88D6655F13B = 0.4;
        break;
      case 2:
        _id_E101B88D6655F13B = 0.6;
        break;
      case 3:
        _id_E101B88D6655F13B = 0.8;
        break;
    }
  }

  _id_F5429DC7523F92F8 = _id_F5429DC7523F92F8 * _id_E101B88D6655F13B;
  self._id_DDFBC5F492FB65C6 = scripts\engine\utility::array_remove(self._id_DDFBC5F492FB65C6, _id_ADD0F0B19CF87473);
  self._id_DDFBC5F492FB65C6 = scripts\engine\utility::array_insert(self._id_DDFBC5F492FB65C6, _id_ADD0F0B19CF87473, 0);

  if(isDefined(self._id_8BB6B9B919C2C19D) && self._id_8BB6B9B919C2C19D != _id_ADD0F0B19CF87473)
    player _id_95F73E34041BEE68("stat_6D65A58E1DE667E1", scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("rank", "getScoreInfoXP", "stat_6D65A58E1DE667E1"));

  thread _id_4F15A249DFB589C2(_id_ADD0F0B19CF87473);

  if(_id_37879FC7B1CC0618.type == "reward_points_once")
    player _id_95F73E34041BEE68(_id_AA78A8CAF5D9087D, int(_id_F5429DC7523F92F8));
  else {
    for(_id_D533BFE71A304271 = 1.0; isDefined(player); player = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self)) {
      xp = int(max(1, _func_C5CF558181E12D1F(_id_F5429DC7523F92F8 * _id_D533BFE71A304271)));
      player _id_95F73E34041BEE68(_id_AA78A8CAF5D9087D, xp);
      _id_D533BFE71A304271 = _id_D533BFE71A304271 - 0.2;

      if(_id_D533BFE71A304271 < 0.1) {
        return;
      }
      wait 0.5;
    }
  }
}

_id_95F73E34041BEE68(event, xp) {
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("rank", "displayScoreEventPoints", xp, event);
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("rank", "killEventTextPopup", event, 1);
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("rank", "giveRankXP", event, xp, undefined, 1, undefined, 1);
}

_id_45585D05C17C31AA() {
  self._id_1FB1C203624107A7 = [];

  for(;;) {
    self waittill("trick_out", _id_ADD0F0B19CF87473);
    self notify(_id_ADD0F0B19CF87473 + "_ended");
    self._id_1FB1C203624107A7[_id_ADD0F0B19CF87473] = gettime();
  }
}

_id_4F15A249DFB589C2(_id_ADD0F0B19CF87473) {
  if(self _meth_2124BFE74C1872B1(0) != "none" && self _meth_2124BFE74C1872B1(1) != "none") {
    return;
  }
  self._id_8BB6B9B919C2C19D = _id_ADD0F0B19CF87473;
  self notify("watchCombo");
  self endon("watchCombo");
  self endon("death");
  _id_F0A619CDE9B0CE82 = 0;

  for(;;) {
    if(self _meth_2124BFE74C1872B1(0) != "none" && self _meth_2124BFE74C1872B1(1) != "none")
      _id_F0A619CDE9B0CE82 = _id_F0A619CDE9B0CE82 + level.framedurationseconds;
    else
      _id_F0A619CDE9B0CE82 = 0;

    if(_id_F0A619CDE9B0CE82 >= 0.25) {
      break;
    }

    waitframe();
  }

  self._id_8BB6B9B919C2C19D = undefined;
}