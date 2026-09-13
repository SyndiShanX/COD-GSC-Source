/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_a62705cb078ec0a.gsc
***********************************************/

_id_80D68C9701E1AEA5(data) {
  spawnpoints = scripts\engine\utility::getStructArray("dmz_vehicledrive_start", "targetname");
  destinations = scripts\engine\utility::getStructArray("dmz_vehicledrive_end", "targetname");
  level._id_8D5EA37EAFA7B186 = [];

  foreach(node in destinations) {
    if(!_id_1174ABEDBEFE9ADA::_id_CDCAB1374DB7F007(node.origin))
      level._id_8D5EA37EAFA7B186[level._id_8D5EA37EAFA7B186.size] = node;
  }

  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_sliding_barn_door", ::_id_259857D59F9C9072);
  _id_440A6F7F2D90CC3C::_id_3E3A73F1039CA16D();
  level._id_77AA416377054823 = scripts\engine\utility::getStructArray("heli_reinforceNode", "script_noteworthy");
  thread _id_B6593B8E64DD523C();
  _id_03314ADD7998AB13::_id_B713F2D39B34540F(data, ::_id_753DBB93CBAA8966, spawnpoints);
}

_id_753DBB93CBAA8966(_id_EFA8EF05B190D7D0, node) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_DC2F3D89D774DC4D;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_E930F02BB2CEB38F;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_F5CC4925E5B36EA6;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_88CC122B335D9302;
  _id_B8EBE3F71A08AB40.funcs["onForceEnd"] = ::_id_8A340139361C0E9B;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_022E0898B918C342;
  _id_B8EBE3F71A08AB40.funcs["onCancel"] = ::_id_FD0A97F1103DCBD5;
  _id_B8EBE3F71A08AB40.ref = "dmz_vehicledrive_explore";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  _id_B8EBE3F71A08AB40.node = node;

  if(!isDefined(level._id_C2C053D36F37CE2C))
    level._id_C2C053D36F37CE2C = 0;

  _id_B8EBE3F71A08AB40._id_6CD05F946A7917F7 = "vehicleDriveMission" + level._id_C2C053D36F37CE2C;
  level._id_C2C053D36F37CE2C++;
  _id_B8EBE3F71A08AB40.numagents = 0;
  _id_636C8575D7A7768B = getdvarint("dvar_F6F97C5AEAF073CA", 30000);
  maxdist = getdvarint("dvar_B8EC1183DFC532CC", 60000);
  destinations = scripts\engine\utility::array_randomize(scripts\engine\utility::get_array_of_closest(_id_B8EBE3F71A08AB40.node.origin, level._id_8D5EA37EAFA7B186, undefined, undefined, maxdist, _id_636C8575D7A7768B));

  foreach(_id_815D30728A6EF9D9 in destinations) {
    if(!istrue(_id_815D30728A6EF9D9.inuse)) {
      _id_B8EBE3F71A08AB40.end = _id_815D30728A6EF9D9;
      _id_815D30728A6EF9D9.inuse = 1;
      break;
    }
  }

  return _id_B8EBE3F71A08AB40;
}

_id_DC2F3D89D774DC4D() {
  if(!isDefined(self.node)) {
    return;
  }
  _id_6C4E8CEA70BF4B6D::_id_C847BFD52C064289(self.node.origin + (0, 0, 60));

  if(!isDefined(self.end) || !scripts\cp_mp\vehicles\vehicle::_id_FA537F1AB52A76D1("veh9_jltv_mg"))
    _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
  else {
    self._id_EFA8EF05B190D7D0.origin = self.node.origin;
    self._id_B1673F16AB572566 = _id_CECAA2FCD2694301(self.node);
    self._id_B1673F16AB572566 vehicleshowonminimap(0);
    self._id_B1673F16AB572566.godmode = 1;
    self.vehicle = self._id_B1673F16AB572566;
    _id_4948CDF739393D2D::_id_B672261B8246A1E5(self._id_B1673F16AB572566.origin, "vehicle_forts", 0, 1, 0, 0, 0);
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(self._id_B1673F16AB572566);
    _id_6AA807E90EF0AFAD();
    _id_AD1A0DB8D7D893E9 = getentitylessscriptablearray(undefined, undefined, self.node.origin, 1024, "dmz_sliding_barn_door");

    if(isDefined(_id_AD1A0DB8D7D893E9) && _id_AD1A0DB8D7D893E9.size > 0) {
      self.garagedoor = _id_AD1A0DB8D7D893E9[0];
      self.garagedoor.track = spawnscriptable("door_metal_barn_02_track", self.garagedoor.origin, self.garagedoor.angles);
      self.garagedoor setscriptablepartstate("dmz_sliding_barn_door", "locked_unusable");
      self.garagedoor._id_37B6A48530B11990 = createnavobstaclebybounds(self.garagedoor.origin + anglestoright(self.garagedoor.angles) * -125, (10, 125, 10), self.garagedoor.angles);
    } else {}

    _id_48814951E916AF89::_id_93ADD0B65DB9F722(::_id_6259C52471AF01F2);
    self._id_B1673F16AB572566 vehicle_settopspeedforward(30);
    self._id_B1673F16AB572566 vehicle_settopspeedreverse(30);
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
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_vehicledrive_assigned", _id_FABF84450735DD93);
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("vehicledrive_accept", _id_FABF84450735DD93, 2.0);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_start", 1.5, "dmz_activity_start_classic");
  self.garagedoor setscriptablepartstate("dmz_sliding_barn_door", "locked");

  foreach(player in level.players)
  self.garagedoor disablescriptableplayeruse(player);

  foreach(player in players)
  self.garagedoor enablescriptableplayeruse(player);

  thread _id_FACD504AA91576D5();
  thread _id_ACB7E3E09AF20B16();
  thread _id_D79B39EEC000DDAA();
}

_id_022E0898B918C342(_id_FABF84450735DD93) {
  level endon("game_ended");
  self._id_B1673F16AB572566 endon("death");
  self endon("task_ended");
  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("vehicledrive_assign", _id_FABF84450735DD93);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_tension", 0.0, "dmz_activity_tension_classic");
  _id_506C6E78C81FB92A = self._id_B1673F16AB572566.origin;
  _id_29D8A3A92F9037D8 = undefined;

  while(!isDefined(_id_29D8A3A92F9037D8) || isDefined(_id_29D8A3A92F9037D8) && isDefined(_id_29D8A3A92F9037D8.team) && _id_29D8A3A92F9037D8.team != self.teams[0]) {
    _id_29D8A3A92F9037D8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self._id_B1673F16AB572566, 1);
    wait 0.1;
  }

  _id_6C4E8CEA70BF4B6D::_id_5314298E777E5688("dmz_vehicledrive");
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("vehicledrive_destination", _id_FABF84450735DD93, 3);
  self thread[[self._id_3F099428157FFA21._id_E0FD93CDDC4B8912]]();
  _id_6C4E8CEA70BF4B6D::_id_CEF2ED613A8338BE(self.end.origin + (0, 0, 50));

  while(isDefined(self._id_B1673F16AB572566) && distance2dsquared(self._id_B1673F16AB572566.origin, _id_506C6E78C81FB92A) < 9000000)
    wait 0.1;

  self._id_8588743BAFF0701E = self[[self._id_3F099428157FFA21.spawnheli]](self._id_B1673F16AB572566);
  self._id_B1673F16AB572566._id_A21A9516D1DEDE9E = _id_29D8A3A92F9037D8.team;
  self._id_B1673F16AB572566 makeentitysentient(self._id_B1673F16AB572566._id_A21A9516D1DEDE9E);
  self._id_B1673F16AB572566 makeentitynomeleetarget();
  thread _id_29578EDC44176C7D(_id_FABF84450735DD93);
  wait 5;
  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("vehicledrive_enemyheliinbound", _id_FABF84450735DD93);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_boss_chopper_combat", 1.5);
}

_id_E930F02BB2CEB38F(player) {
  self.garagedoor enablescriptablepartplayeruse("dmz_sliding_barn_door", player);
}

_id_F5CC4925E5B36EA6(player) {
  self.garagedoor disablescriptablepartplayeruse("dmz_sliding_barn_door", player);
}

_id_8A340139361C0E9B() {
  _id_A9305BD4DC095942();
}

_id_FD0A97F1103DCBD5(_id_FABF84450735DD93) {
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  foreach(player in players) {
    self.garagedoor disablescriptablepartplayeruse("dmz_sliding_barn_door", player);
    player setplayermusicstate("");
  }

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
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("vehicledrive_packagesecure", _id_FABF84450735DD93);
    _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(_id_FABF84450735DD93, "dmz_activity_win", 1.5, "dmz_activity_win_classic");
    wait 5;
    _id_6C4E8CEA70BF4B6D::_id_A1738A95D7AA8094("dmz_vehicledrive_complete", "vehicledrive", self._id_EFA8EF05B190D7D0._id_723B8F7CB71CEB11, _id_FABF84450735DD93);
    _id_6C4E8CEA70BF4B6D::_id_CD4F277CF0D6A560(_id_FABF84450735DD93);
  }

  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3(_id_FABF84450735DD93);
}

_id_CECAA2FCD2694301(node) {
  node._id_3474B4E818850C46 = "veh9_mil_lnd_jltv_turret_cargo_vehphys_mp";
  _id_7B147BFA44B8941D = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_jltv_mg", node);
  _id_7B147BFA44B8941D._id_A8F4BB03B366AA80 = 1;
  _id_7B147BFA44B8941D._id_7EE6203C5532A9E6 = 1;
  _id_7B147BFA44B8941D._id_AAB9695C92B0ED96["tag_bumper_front_damaged"]._id_A776F097EB36E500 = 0;
  _id_7B147BFA44B8941D._id_AAB9695C92B0ED96["tag_bumper_back_damaged"]._id_A776F097EB36E500 = 0;
  payload = spawn("script_model", _id_7B147BFA44B8941D.origin + (0, 0, 4) + anglesToForward(_id_7B147BFA44B8941D.angles) * -84);
  payload.angles = _id_7B147BFA44B8941D.angles;
  payload setModel("cargo_pallet_02_dmz_script");
  payload linkTo(_id_7B147BFA44B8941D);
  _id_7B147BFA44B8941D.payload = payload;
  thread _id_CF8F787850F621F9(_id_7B147BFA44B8941D);
  return _id_7B147BFA44B8941D;
}

_id_CF8F787850F621F9(vehicle) {
  payload = vehicle.payload;
  vehicle waittill("death");

  if(isDefined(payload)) {
    effect = "cargo_pallet_destruction";
    _id_408F3E834E201526 = payload.origin;
    _id_EFDFC6EBE7A152C5 = spawnfx(level._effect[effect], _id_408F3E834E201526);
    triggerfx(_id_EFDFC6EBE7A152C5);
    thread scripts\engine\utility::play_sound_in_space("mp_dmz_cargo_destroyed", _id_408F3E834E201526);
    payload delete();
    _id_EFDFC6EBE7A152C5 thread scripts\engine\utility::_id_B4B04DE87729A6F3(10.0);
  }
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

_id_259857D59F9C9072(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  instance setscriptablepartstate("dmz_sliding_barn_door", "opening");
  destroynavobstacle(instance._id_37B6A48530B11990);
  instance.open = 1;
  instance notify("vehicledrive_doorOpened");
}

_id_FACD504AA91576D5() {
  level endon("game_ended");
  self._id_B1673F16AB572566 endon("death");
  self endon("task_ended");

  if(istrue(self.garagedoor.open))
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeusable(self._id_B1673F16AB572566);

  self.garagedoor waittill("vehicledrive_doorOpened");
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeusable(self._id_B1673F16AB572566);
  thread _id_C23D51ABA69E0718();
  self._id_B1673F16AB572566 vehicleshowonminimap(1);
  self._id_B1673F16AB572566.godmode = 0;
}

_id_29578EDC44176C7D(_id_FABF84450735DD93) {
  self._id_B1673F16AB572566 endon("death");
  self endon("task_ended");
  _id_23CD6D769CD06450 = 0;
  _id_A8BB556710CB6939 = squared(int(100));
  _id_6120F45E53120064 = 0;

  for(;;) {
    wait 0.1;

    if(!isDefined(self._id_B1673F16AB572566) || !isDefined(self._id_B1673F16AB572566.payload)) {
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

    _id_6B40B4C28ABE0A05 = distancesquared(self._id_B1673F16AB572566.payload.origin, self.end.origin);

    if(_id_6B40B4C28ABE0A05 <= _id_A8BB556710CB6939) {
      break;
    }

    if(isDefined(self._id_8588743BAFF0701E) && !_id_6120F45E53120064 && distancesquared(self._id_B1673F16AB572566.origin, self.end.origin) <= 20250000) {
      self._id_8588743BAFF0701E thread[[self._id_3F099428157FFA21._id_25D090D8443B08A4]]();
      _id_6120F45E53120064 = 1;
    }

    if(!_id_23CD6D769CD06450 && _id_6B40B4C28ABE0A05 <= 256000000) {
      players = scripts\mp\utility\teams::getteamdata(self._id_B1673F16AB572566._id_A21A9516D1DEDE9E, "players");

      if(isDefined(players) && players.size)
        self._id_E2667C67E81FD8D2 = players[0] _id_440A6F7F2D90CC3C::_id_5A081E065A93BD08(self.end.origin, (0, 0, 80));

      _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("vehicledrive_extractinbound", self._id_B1673F16AB572566._id_A21A9516D1DEDE9E);
      _id_23CD6D769CD06450 = 1;
    }
  }

  self._id_B1673F16AB572566.payload notsolid();
  waitframe();
  self._id_B1673F16AB572566.payload unlink();
  self._id_B1673F16AB572566.payload linkTo(self._id_E2667C67E81FD8D2.crate, "tag_origin", (0, 0, -110), (0, 0, 0));
  self notify("payload_delivered");
  self._id_E2667C67E81FD8D2.readytoleave = 1;
  self._id_E2667C67E81FD8D2 notify("ready_to_leave");
  thread _id_2D69BD312DE68C60(self.teams[0]);
  self._id_E2667C67E81FD8D2.crate playsoundonmovingent("mp_dmz_cargo_delivery_hook");
}

_id_C23D51ABA69E0718() {
  level endon("game_ended");
  self endon("payload_delivered");
  self endon("task_ended");
  self._id_B1673F16AB572566 endon("death");

  for(;;) {
    if(isDefined(self._id_B1673F16AB572566) && isDefined(self._id_B1673F16AB572566.occupants)) {
      driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self._id_B1673F16AB572566, 1);

      if(isDefined(driver) && isDefined(driver.team) && driver.team != self.teams[0]) {
        thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("activity_failed", self.teams[0], 2);
        _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_vehicledrive_fail_stolen", self.teams[0]);
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
  self._id_B1673F16AB572566 waittill("death");
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("activity_failed", self.teams[0], 2);
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_vehicledrive_fail_destroyed", self.teams[0]);
  _id_65F58F3C394DCF9A::_id_C1FD3441CCFBA6F8(self.teams[0], "dmz_activity_lose", 1.0, "dmz_activity_lose_classic");
  _id_2D69BD312DE68C60();
}

_id_D79B39EEC000DDAA() {
  level endon("game_ended");
  self endon("task_ended");

  for(;;) {
    players = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");

    foreach(player in players) {
      dist = distance2dsquared(player.origin, self.garagedoor.origin);

      if(dist < 562500) {
        _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("vehicledrive_neardoor", players);
        return;
      }
    }

    wait 1.0;
  }
}

_id_B6593B8E64DD523C() {
  for(;;) {
    if(getdvarint("dvar_361E499F400FEE2A", 0)) {
      setDvar("dvar_361E499F400FEE2A", 0);
      node = spawnStruct();
      node.origin = level.players[0].origin + anglesToForward(level.players[0].angles) * 500 + (0, 0, 200);
      node.angles = level.players[0].angles;
      _id_CECAA2FCD2694301(node);
    }

    if(getdvarint("dvar_E04153469EDA5D1D", 0)) {
      setDvar("dvar_E04153469EDA5D1D", 0);
      node = spawnStruct();
      node.origin = level.players[0].origin + anglesToForward(level.players[0].angles) * 500 + (0, 0, 200);
      node.angles = level.players[0].angles;
      node _id_440A6F7F2D90CC3C::_id_5A081E065A93BD08(node.origin, (0, 0, 20));
    }

    wait 1.0;
  }
}