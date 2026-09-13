/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3e32e216ce730ac2.gsc
***********************************************/

_id_80D68C9701E1AEA5(data) {
  _id_B6C4EAAF734A5F98 = scripts\engine\utility::array_randomize(scripts\engine\utility::getStructArray("dmz_boatdrive_start", "script_noteworthy"));
  _id_B3FB853F67DDBB77 = scripts\engine\utility::array_randomize(scripts\engine\utility::getStructArray("dmz_boatdrive_end", "script_noteworthy"));
  level._id_41880BC6655538CA = [];

  foreach(node in _id_B3FB853F67DDBB77) {
    if(!_id_1174ABEDBEFE9ADA::_id_CDCAB1374DB7F007(node.origin))
      level._id_41880BC6655538CA[level._id_41880BC6655538CA.size] = node;
  }

  level._id_A143A83F1D3038EC = [];

  foreach(start in _id_B6C4EAAF734A5F98) {
    foreach(end in level._id_41880BC6655538CA) {
      if(istrue(end.inuse)) {
        continue;
      }
      dist = distance2d(start.origin, end.origin);

      if(dist > 25000 && dist < 40000) {
        start.end = end;
        end.start = start;
        end.inuse = 1;
        level._id_A143A83F1D3038EC[level._id_A143A83F1D3038EC.size] = start;
      }
    }
  }

  _id_7828C1AFE3365DD2();
  _id_440A6F7F2D90CC3C::_id_3E3A73F1039CA16D();
  _id_03314ADD7998AB13::_id_B713F2D39B34540F(data, ::_id_8811F695B5E87B84, level._id_A143A83F1D3038EC);
}

_id_8811F695B5E87B84(_id_EFA8EF05B190D7D0, node) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_DC2F3D89D774DC4D;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_E930F02BB2CEB38F;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_F5CC4925E5B36EA6;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_88CC122B335D9302;
  _id_B8EBE3F71A08AB40.funcs["onForceEnd"] = ::_id_8A340139361C0E9B;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_022E0898B918C342;
  _id_B8EBE3F71A08AB40.funcs["onCancel"] = ::_id_FD0A97F1103DCBD5;
  _id_B8EBE3F71A08AB40.ref = "dmz_boatdrive_explore";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  _id_B8EBE3F71A08AB40.node = node;
  _id_B8EBE3F71A08AB40.end = node.end;

  if(!isDefined(level._id_9FB539420ED34F34))
    level._id_9FB539420ED34F34 = 0;

  _id_B8EBE3F71A08AB40._id_6CD05F946A7917F7 = "boatDriveMission" + level._id_9FB539420ED34F34;
  level._id_9FB539420ED34F34++;
  _id_B8EBE3F71A08AB40.numagents = 0;
  return _id_B8EBE3F71A08AB40;
}

_id_DC2F3D89D774DC4D() {
  if(!isDefined(self.node)) {
    return;
  }
  _id_6C4E8CEA70BF4B6D::_id_C847BFD52C064289(self.node.origin + (0, 0, 60));

  if(!isDefined(self.end) || !scripts\cp_mp\vehicles\vehicle::_id_FA537F1AB52A76D1("veh9_patrol_boat"))
    _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
  else {
    self._id_EFA8EF05B190D7D0.origin = self.node.origin;
    _id_48814951E916AF89::_id_93ADD0B65DB9F722(::_id_6259C52471AF01F2);
    _id_37F4F6505381D02A = 1;

    if(istrue(_id_37F4F6505381D02A)) {
      self._id_3F099428157FFA21 = _id_2F2628D802EB2807::_id_E09936350B8D90FE();
      return;
    }

    self._id_3F099428157FFA21 = _id_772861646614D63A::_id_E09936350B8D90FE();
  }
}

_id_88CC122B335D9302(_id_FABF84450735DD93) {
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_boatdrive_accept", _id_FABF84450735DD93);
  thread _id_7A036ED55902A5A1();

  if(_id_4480C6CE37B2BDF3::_id_A7F9424636F37FB1())
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boatdrive_assigned_generic", _id_FABF84450735DD93, 2.0);
  else
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boatdrive_assigned", _id_FABF84450735DD93, 2.0);

  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_start", 1.5, "dmz_activity_start_classic");
}

_id_022E0898B918C342(_id_FABF84450735DD93) {
  if(isDefined(self._id_E2E4A2412ACAFDA7))
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boatdrive_approach", _id_FABF84450735DD93);
  else
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boatdrive_approach_dropped", _id_FABF84450735DD93);

  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, undefined, 0.0);
}

_id_E930F02BB2CEB38F(player) {}

_id_F5CC4925E5B36EA6(player) {}

_id_8A340139361C0E9B() {
  _id_A9305BD4DC095942();
}

_id_FD0A97F1103DCBD5(_id_FABF84450735DD93) {
  _id_2D69BD312DE68C60();
}

_id_A9305BD4DC095942() {
  _id_48814951E916AF89::_id_66A6064FAD612BF3(::_id_6259C52471AF01F2);
  _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();

  if(isDefined(self._id_8588743BAFF0701E))
    self._id_8588743BAFF0701E thread[[self._id_3F099428157FFA21._id_25D090D8443B08A4]]();

  if(isDefined(self._id_E2667C67E81FD8D2))
    self._id_E2667C67E81FD8D2.readytoleave = 1;
}

_id_2D69BD312DE68C60(_id_FABF84450735DD93) {
  self endon("task_ended");
  _id_A9305BD4DC095942();

  if(isDefined(_id_FABF84450735DD93)) {
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boatdrive_heli_extracted", _id_FABF84450735DD93);
    _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
    wait 5;
    _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_boatdrive_complete", "vehicledrive", self._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11, _id_FABF84450735DD93);
    _id_6C4E8CEA70BF4B6D::_id_CD4F277CF0D6A560(_id_FABF84450735DD93);
  }

  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3(_id_FABF84450735DD93);
}

_id_7A036ED55902A5A1() {
  self endon("task_ended");
  level endon("game_ended");
  _id_A3010F9814A40C8D = undefined;
  players = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");

  if(!isDefined(players)) {
    _id_2D69BD312DE68C60();
    return;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size && !isDefined(_id_A3010F9814A40C8D); _id_AC0E594AC96AA3A8++)
    _id_A3010F9814A40C8D = players[_id_AC0E594AC96AA3A8];

  if(!isDefined(_id_A3010F9814A40C8D)) {
    _id_2D69BD312DE68C60();
    return;
  }

  self._id_E2E4A2412ACAFDA7 = _id_0DCA84F44880B74D(self.node.origin, self.node.angles, _id_A3010F9814A40C8D);
  self.vehicle = self._id_E2E4A2412ACAFDA7;

  if(!istrue(self._id_E2E4A2412ACAFDA7.deployed))
    self._id_E2E4A2412ACAFDA7 waittill("deployed");

  thread _id_C23D51ABA69E0718();
  thread _id_ACB7E3E09AF20B16();
  _id_6C4E8CEA70BF4B6D::_id_B3C1BA9FBD1DD01E(self._id_E2E4A2412ACAFDA7, 50);
  _id_6C4E8CEA70BF4B6D::_id_5314298E777E5688("dmz_boatdrive_wait");

  for(driver = undefined; !isDefined(driver); driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self._id_E2E4A2412ACAFDA7, 1))
    wait 0.1;

  _id_506C6E78C81FB92A = self._id_E2E4A2412ACAFDA7.origin;
  self._id_E2E4A2412ACAFDA7 _meth_481C2A63F2BA3332(0);
  _id_6C4E8CEA70BF4B6D::_id_5314298E777E5688("dmz_boatdrive");
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boatdrive_entered", self.teams[0], 3);
  self thread[[self._id_3F099428157FFA21._id_E0FD93CDDC4B8912]]();
  _id_6C4E8CEA70BF4B6D::_id_CEF2ED613A8338BE(self.end.origin + (0, 0, 50));
  self._id_E2E4A2412ACAFDA7._id_A21A9516D1DEDE9E = driver.team;
  self._id_E2E4A2412ACAFDA7 makeentitysentient(self._id_E2E4A2412ACAFDA7._id_A21A9516D1DEDE9E);
  self._id_E2E4A2412ACAFDA7 makeentitynomeleetarget();

  while(isDefined(self._id_E2E4A2412ACAFDA7) && distance2dsquared(self._id_E2E4A2412ACAFDA7.origin, _id_506C6E78C81FB92A) < 9000000)
    wait 0.1;

  self._id_8588743BAFF0701E = self[[self._id_3F099428157FFA21.spawnheli]](self._id_E2E4A2412ACAFDA7);
  thread _id_29578EDC44176C7D(self.teams[0]);
  wait 5;
  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("vehicledrive_enemyheliinbound", self.teams[0]);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(self.teams[0], "dmz_boss_chopper_combat", 1.5);
}

_id_09E0EAB9A6A39506(owner, pos, angles) {
  data = spawnStruct();
  data.origin = pos;
  data.angles = angles;
  data.team = owner.team;
  data.disableusabilityatspawn = 1;
  heli = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_blima", data);
  heli.animname = "blima";
  heli scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  heli._id_1E897AE1C018B2C2 = owner.team;
  return heli;
}

_id_6AA807E90EF0AFAD() {
  _id_53456645791DF147 = scripts\engine\utility::getStructArray("vehicledrive_guard", "targetname");
  _id_D067DED4779DB731 = scripts\engine\utility::get_array_of_closest(self.node.origin, _id_53456645791DF147, undefined, undefined, 2000);
  agents = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D067DED4779DB731.size; _id_AC0E594AC96AA3A8++) {
    angles = _id_D067DED4779DB731[_id_AC0E594AC96AA3A8].angles;
    origin = _id_D067DED4779DB731[_id_AC0E594AC96AA3A8].origin;
    aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("ar");
    agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, origin, angles, "high", "mission", "vehicleDriveGuards", undefined, undefined, undefined, self.node._id_B205D90302DA2F07);

    if(isDefined(agent)) {
      agents[_id_AC0E594AC96AA3A8] = agent;
      thread _id_120270BD0A747A35::_id_B11C1964F528574B(agent);
    }
  }

  self.numagents = self.numagents + agents.size;
}

_id_6259C52471AF01F2(agent, _id_6181DE250AFA5BB6) {
  _id_4565ED16F15AC73C = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "assignment");

  if(isDefined(_id_4565ED16F15AC73C) && _id_4565ED16F15AC73C == self._id_6CD05F946A7917F7)
    self.numagents--;
}

_id_29578EDC44176C7D(_id_FABF84450735DD93) {
  self._id_E2E4A2412ACAFDA7 endon("death");
  self endon("task_ended");
  _id_23CD6D769CD06450 = 0;
  _id_A8BB556710CB6939 = squared(int(100));
  _id_6120F45E53120064 = 0;

  for(;;) {
    wait 0.1;

    if(!isDefined(self._id_E2E4A2412ACAFDA7) || !isDefined(self._id_E2E4A2412ACAFDA7.payload)) {
      if(isDefined(self._id_E2667C67E81FD8D2)) {
        self._id_E2667C67E81FD8D2.readytoleave = 1;
        self._id_E2667C67E81FD8D2 notify("ready_to_leave");
      }

      if(isDefined(self._id_8588743BAFF0701E)) {
        self._id_8588743BAFF0701E thread[[self._id_3F099428157FFA21._id_25D090D8443B08A4]]();
        _id_6120F45E53120064 = 1;
      }

      return;
    }

    _id_6B40B4C28ABE0A05 = distancesquared(self._id_E2E4A2412ACAFDA7.payload.origin, self.end.origin);

    if(_id_6B40B4C28ABE0A05 <= _id_A8BB556710CB6939) {
      break;
    }

    if(isDefined(self._id_8588743BAFF0701E) && !_id_6120F45E53120064 && distancesquared(self._id_E2E4A2412ACAFDA7.origin, self.end.origin) <= 20250000) {
      self._id_8588743BAFF0701E thread[[self._id_3F099428157FFA21._id_25D090D8443B08A4]]();
      _id_6120F45E53120064 = 1;
    }

    if(!_id_23CD6D769CD06450 && _id_6B40B4C28ABE0A05 <= 256000000) {
      players = scripts\mp\utility\teams::getteamdata(self._id_E2E4A2412ACAFDA7._id_A21A9516D1DEDE9E, "players");

      if(isDefined(players) && players.size)
        self._id_E2667C67E81FD8D2 = players[0] _id_440A6F7F2D90CC3C::_id_5A081E065A93BD08(self.end.origin, (0, 0, 60));

      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boatdrive_heli_exfil", self._id_E2E4A2412ACAFDA7._id_A21A9516D1DEDE9E);
      _id_23CD6D769CD06450 = 1;
    }
  }

  self._id_E2E4A2412ACAFDA7.payload notsolid();
  waitframe();
  self._id_E2E4A2412ACAFDA7.payload unlink();
  self._id_E2E4A2412ACAFDA7.payload linkTo(self._id_E2667C67E81FD8D2.crate, "tag_origin", (0, 0, -110), (0, 0, 0));
  self notify("payload_delivered");
  self._id_E2667C67E81FD8D2.readytoleave = 1;
  self._id_E2667C67E81FD8D2 notify("ready_to_leave");
  _id_536A5C2E42582B98 = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(self._id_E2E4A2412ACAFDA7, "iw9_mg_patrol_boat_back_mp");
  _id_536A5C2E42582B98._id_9F925F5509626DF1 = _id_536A5C2E42582B98._id_A682A8256C580B8C;
  self._id_E2667C67E81FD8D2.crate playsoundonmovingent("mp_dmz_cargo_delivery_hook");
  thread _id_2D69BD312DE68C60(self.teams[0]);
}

_id_C23D51ABA69E0718() {
  level endon("game_ended");
  self endon("payload_delivered");
  self endon("task_ended");
  self._id_E2E4A2412ACAFDA7 endon("death");

  for(;;) {
    if(isDefined(self._id_E2E4A2412ACAFDA7) && isDefined(self._id_E2E4A2412ACAFDA7.occupants)) {
      driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self._id_E2E4A2412ACAFDA7, 1);

      if(isDefined(driver) && isDefined(driver.team) && driver.team != self.teams[0]) {
        _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_boatdrive_fail_stolen", "vehicledrive", 0, self.teams[0]);
        thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boatdrive_boat_stolen", self.teams[0], 2.0);
        _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(self.teams[0], "dmz_activity_lose", 1.0, "dmz_activity_lose_classic");
        _id_2D69BD312DE68C60();
        return;
      }
    }

    wait 1.0;
  }
}

_id_ACB7E3E09AF20B16() {
  level endon("game_ended");
  self endon("payload_delivered");
  self endon("task_ended");
  self._id_E2E4A2412ACAFDA7 waittill("death");
  _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_boatdrive_fail_destroyed", "vehicledrive", 0, self.teams[0]);
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boatdrive_boat_destroyed", self.teams[0], 2.0);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(self.teams[0], "dmz_activity_lose", 1.0, "dmz_activity_lose_classic");
  _id_2D69BD312DE68C60();
}

#using_animtree("script_model");

_id_7828C1AFE3365DD2() {
  level.scr_animtree["rope1"] = #animtree;
  level.scr_anim["rope1"]["armored_patrol_boat_dropoff"] = % iw9_mp_armored_patrol_boat_dropoff_rope1;
  level.scr_animname["rope1"]["armored_patrol_boat_dropoff"] = "iw9_mp_armored_patrol_boat_dropoff_rope1";
  level.scr_animtree["rope2"] = #animtree;
  level.scr_anim["rope2"]["armored_patrol_boat_dropoff"] = % iw9_mp_armored_patrol_boat_dropoff_rope2;
  level.scr_animname["rope2"]["armored_patrol_boat_dropoff"] = "iw9_mp_armored_patrol_boat_dropoff_rope2";
  _id_1ECFC00892DB5FE2();
}

#using_animtree("mp_vehicles_always_loaded");

_id_1ECFC00892DB5FE2() {
  level.scr_animtree["armored_patrol_boat"] = #animtree;
  level.scr_anim["armored_patrol_boat"]["armored_patrol_boat_dropoff"] = % iw9_mp_armored_patrol_boat_dropoff_boat;
  level.scr_animtree["blima"] = #animtree;
  level.scr_anim["blima"]["armored_patrol_boat_dropoff"] = % iw9_mp_armored_patrol_boat_dropoff_heli;
}

_id_118D4D3861116A71() {
  wait 18;
  self playsoundonmovingent("iw9_drop_chute_release");
}

_id_61B857E8EAA21D3B() {
  wait 2.25;
  self playsoundonmovingent("mp_care_package_impact_water_body");
}

_id_31DEDDA3E342EBDE() {
  wait 6;
  self setscriptablepartstate("boat_dropoff_sfx", "on");
}

_id_8BED43BA9AD1726D(origin, angles) {
  _id_4EB8738FA8609B12 = spawnStruct();
  _id_4EB8738FA8609B12.origin = origin;
  _id_4EB8738FA8609B12.angles = angles;
  _id_E2E4A2412ACAFDA7 = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_patrol_boat", _id_4EB8738FA8609B12);
  _id_E2E4A2412ACAFDA7.animname = "armored_patrol_boat";
  _id_536A5C2E42582B98 = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(_id_E2E4A2412ACAFDA7, "iw9_mg_patrol_boat_back_mp");
  _id_536A5C2E42582B98._id_A682A8256C580B8C = _id_536A5C2E42582B98._id_9F925F5509626DF1;
  _id_536A5C2E42582B98._id_9F925F5509626DF1 = (-100, 45, -7);
  payload = spawn("script_model", _id_E2E4A2412ACAFDA7.origin + (0, 0, 5) + anglesToForward(_id_E2E4A2412ACAFDA7.angles) * -90);
  payload.angles = _id_E2E4A2412ACAFDA7.angles;
  payload setModel("cargo_pallet_02_dmz_script");
  payload linkTo(_id_E2E4A2412ACAFDA7);
  _id_E2E4A2412ACAFDA7.payload = payload;
  thread _id_0A62705CB078EC0A::_id_CF8F787850F621F9(_id_E2E4A2412ACAFDA7);
  return _id_E2E4A2412ACAFDA7;
}

_id_0DCA84F44880B74D(origin, angles, player) {
  _id_DC1711FFC6CD2BF1 = origin - (-49.233, 15.251, -575.692);
  sceneangles = angles;
  forward = anglesToForward(sceneangles);
  height = 700;

  for(_id_30F22E255C6CED30 = 0; height < 3000; height = height + 200) {
    _id_63E26D5A86AC531C = _id_DC1711FFC6CD2BF1 + (0, 0, height);
    start = _id_63E26D5A86AC531C - forward * 3000 + (0, 0, 2000);
    end = _id_63E26D5A86AC531C + forward * 3000 + (0, 0, 2000);
    trace = scripts\engine\trace::sphere_trace(_id_63E26D5A86AC531C, start, 500);

    if(trace["hittype"] == "hittype_none") {
      trace = scripts\engine\trace::sphere_trace(_id_63E26D5A86AC531C, end, 500);

      if(trace["hittype"] == "hittype_none") {
        _id_30F22E255C6CED30 = 1;
        break;
      }
    }
  }

  if(!istrue(_id_30F22E255C6CED30)) {
    _id_E2E4A2412ACAFDA7 = _id_8BED43BA9AD1726D(origin + 3000, angles);
    _id_E2E4A2412ACAFDA7.deployed = 1;
    _id_E2E4A2412ACAFDA7 vehicleshowonminimap(1);
    return _id_E2E4A2412ACAFDA7;
  }

  _id_DC1711FFC6CD2BF1 = _id_DC1711FFC6CD2BF1 + (0, 0, height);
  _id_E2E4A2412ACAFDA7 = _id_8BED43BA9AD1726D(_id_DC1711FFC6CD2BF1 + rotatevector((-6491.19, 8.381, 2602.64), sceneangles), combineangles(sceneangles, (21.543, 0, 0)));
  _id_E2E4A2412ACAFDA7 vehphys_forcekeyframedmotion();
  heli = _id_09E0EAB9A6A39506(player, _id_DC1711FFC6CD2BF1 + rotatevector((-6226.31, 0, 3287.4), sceneangles), combineangles(sceneangles, (8.289, 0, 0)));
  heli vehphys_forcekeyframedmotion();
  heli _meth_247AD6A91F6A4FFE(1);
  _id_7D1AE3814C85B788 = spawn("script_model", _id_DC1711FFC6CD2BF1 + rotatevector((-6233.72, -23.428, 3195.29), sceneangles));
  _id_7D1AE3814C85B788.angles = combineangles(sceneangles, (7.507, -0.229, -1.363));
  _id_7D1AE3814C85B788 setModel("veh9_mil_air_heli_airdrop_rig");
  _id_7D1AE3814C85B788.animname = "rope1";
  _id_7D1AE3814C85B788 scripts\common\anim::setanimtree();
  _id_7D1AE3814C85B788 show();
  _id_7D1AE6814C85BE21 = spawn("script_model", _id_DC1711FFC6CD2BF1 + rotatevector((-6233.57, 22.939, 3194.19), sceneangles));
  _id_7D1AE6814C85BE21.angles = combineangles(sceneangles, (7.507, -0.229, -1.363));
  _id_7D1AE6814C85BE21 setModel("veh9_mil_air_heli_airdrop_rig");
  _id_7D1AE6814C85BE21.animname = "rope2";
  _id_7D1AE6814C85BE21 scripts\common\anim::setanimtree();
  _id_7D1AE6814C85BE21 show();
  thread _id_8ED7CC8DB82DD643(heli, _id_7D1AE3814C85B788, _id_7D1AE6814C85BE21);
  thread _id_4A72E137F2AB1BDA(_id_E2E4A2412ACAFDA7);
  return _id_E2E4A2412ACAFDA7;
}

_id_8ED7CC8DB82DD643(heli, _id_7D1AE3814C85B788, _id_7D1AE6814C85BE21) {
  _id_23D42B1195DDA679 = spawnStruct();
  _id_23D42B1195DDA679.origin = heli.origin;
  _id_23D42B1195DDA679.angles = heli.angles;
  _id_0D6951E00866D274 = spawnStruct();
  _id_0D6951E00866D274.origin = _id_7D1AE3814C85B788.origin;
  _id_0D6951E00866D274.angles = _id_7D1AE3814C85B788.angles;
  _id_C92E8ED49B8990C9 = spawnStruct();
  _id_C92E8ED49B8990C9.origin = _id_7D1AE6814C85BE21.origin;
  _id_C92E8ED49B8990C9.angles = _id_7D1AE6814C85BE21.angles;
  _id_0D6951E00866D274 scripts\common\anim::anim_first_frame_solo(_id_7D1AE3814C85B788, "armored_patrol_boat_dropoff");
  _id_C92E8ED49B8990C9 scripts\common\anim::anim_first_frame_solo(_id_7D1AE6814C85BE21, "armored_patrol_boat_dropoff");
  waitframe();
  _id_0D6951E00866D274 thread scripts\common\anim::anim_single_solo(_id_7D1AE3814C85B788, "armored_patrol_boat_dropoff");
  _id_C92E8ED49B8990C9 thread scripts\common\anim::anim_single_solo(_id_7D1AE6814C85BE21, "armored_patrol_boat_dropoff");
  heli animScripted("notify", _id_23D42B1195DDA679.origin, _id_23D42B1195DDA679.angles, %iw9_mp_armored_patrol_boat_dropoff_heli);
  heli thread _id_31DEDDA3E342EBDE();
  duration = getanimlength(level.scr_anim["blima"]["armored_patrol_boat_dropoff"]);
  wait(duration);
  heli delete();
  _id_7D1AE3814C85B788 delete();
  _id_7D1AE6814C85BE21 delete();
}

_id_4A72E137F2AB1BDA(_id_E2E4A2412ACAFDA7) {
  _id_AD183E553E6D41E7 = spawnStruct();
  _id_AD183E553E6D41E7.origin = _id_E2E4A2412ACAFDA7.origin;
  _id_AD183E553E6D41E7.angles = _id_E2E4A2412ACAFDA7.angles;
  _id_AD183E553E6D41E7 scripts\common\anim::anim_first_frame_solo(_id_E2E4A2412ACAFDA7, "armored_patrol_boat_dropoff");
  waitframe();
  _id_AD183E553E6D41E7 thread scripts\common\anim::anim_single_solo(_id_E2E4A2412ACAFDA7, "armored_patrol_boat_dropoff");
  _id_E2E4A2412ACAFDA7 thread _id_118D4D3861116A71();
  waittime = 18.0333;
  wait(waittime);
  _id_E2E4A2412ACAFDA7 stopanimScripted();
  _id_E2E4A2412ACAFDA7 vehphys_setdefaultmotion();
  _id_E2E4A2412ACAFDA7 vehicleshowonminimap(1);
  _id_E2E4A2412ACAFDA7.deployed = 1;
  _id_E2E4A2412ACAFDA7 notify("deployed");
  _id_E2E4A2412ACAFDA7 thread _id_61B857E8EAA21D3B();
}