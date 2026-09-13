/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_65984970c8fd9780.gsc
***********************************************/

_id_7F51120D757C476D() {
  level._id_D13F0C77C8CA3733 = spawnStruct();
  level._id_D13F0C77C8CA3733.arenas = _id_B6B17B702DACC929();
  level._id_D13F0C77C8CA3733.streamtimeout = getdvarint("dvar_B04DB7FA026D7D85", 9);
  level._id_D13F0C77C8CA3733._id_2874B9C947A0B65C = getdvarint("dvar_03819A53B2F8F113", 30);
  level._id_D13F0C77C8CA3733._id_B798ED936BA9BE91 = getdvarint("dvar_1DB139972ED7F7E8", 15000);
  level._id_D13F0C77C8CA3733._id_A3F304150AF9E2B1 = getdvarint("dvar_A36A6AF722CF1166", 15000);
  level._id_D13F0C77C8CA3733._id_521F243349AF668D = getdvarint("dvar_0042380EE32ED0FE", 50);
  level._id_D13F0C77C8CA3733._id_14DD394D0DA36979 = getdvarfloat("dvar_B03747967FFD56A6", 2.0);
  level._id_D13F0C77C8CA3733._id_24A76548721885FA = getdvarint("dvar_B54C39C746EC6F02", 2000);
  level._id_D13F0C77C8CA3733._id_1D4A31E5DB2FC768 = getdvarint("dvar_E322647BFC84BA18", 2000);
  level._id_D13F0C77C8CA3733._id_35E74BF677D87AA7 = getdvarint("dvar_CB3E48A75C3B8E7D", 2500);
  level._id_D13F0C77C8CA3733._id_D7C1034DAEFF8100 = getdvarint("dvar_E0C40C22FC1CFAA6", 3000);
  level._id_D13F0C77C8CA3733._id_3E1D67D0805529CF = getdvarint("dvar_DC5E3DB7ED5890E7", 3000);
  level._id_D13F0C77C8CA3733._id_88B1F74D6A183865 = getdvarint("dvar_7AE8070A7CF6A2DB", 2000);
  level._id_D13F0C77C8CA3733._id_B7139738B0DF963B = getdvarint("dvar_B37C9162842619EE", 4);
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::playercinematiccompletecallback);
  setomnvar("ui_gulag_state", 1);
  setomnvar("ui_gulag_show_closing_state", 0);
}

_id_B6B17B702DACC929() {
  _id_DBB6B038608FD9F0 = getDvar("dvar_7453401BBD201B1F", "");

  if(_id_DBB6B038608FD9F0 == "")
    arenas = scripts\engine\utility::getStructArray("gulag", "targetname");
  else {
    arenas = scripts\engine\utility::getStructArray(_id_DBB6B038608FD9F0, "targetname");

    if(arenas.size == 0)
      arenas = scripts\engine\utility::getStructArray("gulag", "targetname");
  }

  arenas = scripts\engine\utility::array_randomize(arenas);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < arenas.size; _id_AC0E594AC96AA3A8++) {
    arena = arenas[_id_AC0E594AC96AA3A8];
    arena._id_65E4FD32C2391CA9 = _id_AC0E594AC96AA3A8;
    setuparena(arena);
  }

  return arenas;
}

setuparena(arena) {
  arena.fightspawns = [];
  arena._id_EF9A0B82CE1A505A = [];
  arena.cellspawns = [];
  arena.gates = [];
  arena.floor = [];
  arena.weapons = [];
  arena.players = [];
  arena._id_79F102B3ABCC6F8A = [];
  _id_03C7899636CBA8AB = [];
  targets = scripts\engine\utility::getStructArray(arena.target, "targetname");

  foreach(target in targets) {
    if(target.script_noteworthy == "fight_spawn") {
      arena.fightspawns[arena.fightspawns.size] = target;
      continue;
    }

    if(target.script_noteworthy == "gulag_twotwo_spawn_fight") {
      arena.fightspawns[arena.fightspawns.size] = target;
      continue;
    }

    if(target.script_noteworthy == "gulag_twotwo_spawn_fight_alt1") {
      arena._id_EF9A0B82CE1A505A[arena._id_EF9A0B82CE1A505A.size] = target;
      continue;
    }

    if(target.script_noteworthy == "gulag_dom_player_spawn") {
      arena.fightspawns[arena.fightspawns.size] = target;
      continue;
    }

    if(target.script_noteworthy == "cell_spawn") {
      arena.cellspawns[arena.cellspawns.size] = target;
      continue;
    }

    if(target.script_noteworthy == "gulag_center") {
      arena.center = target.origin;
      continue;
    }

    if(target.script_noteworthy == "spectator") {
      arena.spectatepoint = target;
      continue;
    }

    if(target.script_noteworthy == "gulag_twotwo_spectator") {
      arena.spectatepoint = target;
      continue;
    }

    if(target.script_noteworthy == "gulag_dom_prematch_spawn") {
      arena._id_C379148A901939AC = target;
      continue;
    }

    if(target.script_noteworthy == "gulag_twotwo_jugg_spawn") {
      arena._id_79F102B3ABCC6F8A[target.script_index] = target;
      continue;
    }

    if(isDefined(target.script_parameters) && target.script_parameters == "gulag_loot")
      _id_03C7899636CBA8AB[_id_03C7899636CBA8AB.size] = target;
  }

  if(!isDefined(arena.center))
    arena.center = _id_037CF6890F0E9210(arena);

  thread _id_735C3F70A42AC83A(arena);
}

_id_037CF6890F0E9210(arena) {
  _id_2F432D8C975DECC6 = (0, 0, 0);

  foreach(struct in arena.fightspawns)
  _id_2F432D8C975DECC6 = _id_2F432D8C975DECC6 + struct.origin;

  _id_2F432D8C975DECC6 = _id_2F432D8C975DECC6 / arena.fightspawns.size;
  return _id_2F432D8C975DECC6;
}

circletimer(circleindex) {
  if(!istrue(level._id_D13F0C77C8CA3733.shutdown)) {
    _id_DB09EC981E3CC8E5 = _id_CF8F519F5EA70BDB();

    if(circleindex >= _id_DB09EC981E3CC8E5)
      _id_5DDD44AD63D05D85("circle_index", circleindex);
  }
}

_id_5DDD44AD63D05D85(_id_401C3A2E68AAB0FD, _id_B4617E1677838AB5, _id_DEDCC523DB8309B1) {
  if(istrue(level._id_D13F0C77C8CA3733.shutdown)) {
    return;
  }
  setomnvar("ui_gulag_state", 0);
  setomnvar("ui_gulag_show_closing_state", 2);
  level._id_D13F0C77C8CA3733.shutdown = 1;

  if(!istrue(_id_DEDCC523DB8309B1)) {
    foreach(player in level.players) {
      if(!isDefined(player) || !isalive(player) || isDefined(player._id_D13F0C77C8CA3733)) {
        continue;
      }
      player _id_3860250B579EF9FD();
    }
  }

  level notify("armory_closed");
}

_id_CF8F519F5EA70BDB() {
  if(!isDefined(level.br_level) || !isDefined(level.br_level.br_circledelaytimes))
    return 0;

  offset = level.br_level._id_E978F01A35B90E7D;

  if(!isDefined(offset))
    offset = 0;

  return level.br_level.br_circledelaytimes.size - 1 - getdvarint("dvar_1141FEA0C6EF428F", 3) - offset;
}

_id_3C238BA7323E4681() {
  _id_2948CA54731DE34F = _id_4C0D237204394C7D();
  _id_754110404C0D574F = gettime() + _id_2948CA54731DE34F * 1000;
  setomnvar("ui_gulag_timer", _id_754110404C0D574F);
  thread showclosingmessage(_id_2948CA54731DE34F);
}

showclosingmessage(_id_2948CA54731DE34F) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  _id_FC133E1A9D8063A1 = getdvarint("dvar_254852C2FF215006", 90);
  _id_DA3AD048198AB965 = _id_2948CA54731DE34F - _id_FC133E1A9D8063A1;

  if(0 < _id_DA3AD048198AB965) {
    wait(_id_DA3AD048198AB965);
    setomnvar("ui_gulag_show_closing_state", 1);
  }
}

_id_4C0D237204394C7D() {
  time = 0;

  if(isDefined(level.br_level) && isDefined(level.br_level.br_circlecenters)) {
    _id_DB09EC981E3CC8E5 = _id_CF8F519F5EA70BDB();

    for(circleindex = 0; circleindex < _id_DB09EC981E3CC8E5; circleindex++) {
      _id_3702CBA57F844507 = level.br_level.br_circledelaytimes[circleindex];
      _id_3D8565E2775A243C = level.br_level.br_circleclosetimes[circleindex];
      time = time + _id_3702CBA57F844507 + _id_3D8565E2775A243C;
    }
  }

  return int(time);
}

_id_3860250B579EF9FD() {
  if(istrue(self._id_38387B422285483F)) {
    return;
  }
  self._id_38387B422285483F = 1;
  _id_1671F48D05259D22::dangernotifyplayer(self, "armory_closed", 3);
}

_id_F863CB103165FC30(_id_11F3B4465C8B637B) {
  if((isbot(self) || self isplayerheadless()) && !istrue(self._id_F5F0502303CB904D))
    return 0;

  if(getdvarint("dvar_723A4B3AC39BC3E2", 0))
    return 0;

  self setallstreamloaddist(10000.0);
  self _meth_670863FC4008C3D8(_id_11F3B4465C8B637B);
  return 1;
}

_id_28EC01D73D0ECA9D() {
  if(!istrue(self._id_F5F0502303CB904D)) {
    self endon("armoryStreamLocationComplete");
    thread _id_8683421E328A0040(level._id_D13F0C77C8CA3733.streamtimeout);

    while(!self isadditionalstreamposready())
      waitframe();

    self notify("armoryStreamLocationComplete");
  } else
    wait(level._id_D13F0C77C8CA3733.streamtimeout);
}

_id_8683421E328A0040(timelimit) {
  self endon("disconnect");
  self endon("armoryStreamLocationComplete");
  wait(timelimit);
  self notify("armoryStreamLocationComplete");
}

_id_BF2845510060C991() {
  self clearadditionalstreampos();
  self notify("armoryStreamLocationComplete");
}

addloadingplayer(arena, player) {
  player._id_F8A997096CECDA0A = 1;
}

_id_091E18CE3201E333(player) {
  player notify("enter_armory");
  player._id_F8A997096CECDA0A = 0;
  scripts\mp\deathicons::hidedeathicon(player);
}

_id_F8A997096CECDA0A(player) {
  if(player._id_F8A997096CECDA0A)
    player waittill("enter_armory");
}

playergetnextarena() {
  _id_94AFB7D602135955 = getdvarint("dvar_8BDEE07FA09E810A", -1);

  if(_id_94AFB7D602135955 > -1)
    return level._id_D13F0C77C8CA3733.arenas[_id_94AFB7D602135955];

  maxplayers = getdvarint("party_maxplayers");
  _id_B1ADC08837BB1D16 = int(ceil(level._id_D13F0C77C8CA3733.arenas.size / float(maxplayers)));

  foreach(arena in level._id_D13F0C77C8CA3733.arenas) {
    if(arena.players.size < _id_B1ADC08837BB1D16)
      return arena;
  }

  return level._id_D13F0C77C8CA3733.arenas[0];
}

_id_BC00041E45770FF2(_id_80B642A0F8C9659D) {
  if(!isDefined(self._id_DD8553EB7663EE83)) {
    _id_25F230EBAB6F59FB = gettime() + _id_80B642A0F8C9659D * 1000;
    self setclientomnvar("ui_br_gulag_match_end_time", _id_25F230EBAB6F59FB);
    self._id_DD8553EB7663EE83 = 1;
    self._id_AB24BA599CBB7809 = _id_60E4A3BBB3596257::_id_D528348949C55989(_id_80B642A0F8C9659D, 0, 120, "center", "middle", "center", "middle");
  }
}

_id_236A093A9A4517C3(arena) {
  self._id_DD8553EB7663EE83 = undefined;
  self setclientomnvar("ui_br_gulag_match_end_time", 0);

  if(isDefined(self._id_AB24BA599CBB7809))
    self._id_AB24BA599CBB7809 destroy();
}

_id_747E4674642E01B1(arena) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("armory_end");
  _id_74B5B12BB6514385 = getdvarint("dvar_21024DE6BE572E9B", 60);

  if(_id_74B5B12BB6514385 <= 0) {
    return;
  }
  _id_BC00041E45770FF2(_id_74B5B12BB6514385);
  wait(_id_74B5B12BB6514385);
  thread _id_5D67812E2D6CA9E3(arena, self);
}

initplayerarena(_id_DB8FB5275CEB12F5) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("armory_end");
  self._id_360BBFCE98A8056A = gettime();
  playerpreloadintrocinematic();
  arena = playergetnextarena();
  self.arena = arena;

  if(!scripts\engine\utility::array_contains(arena.players, self))
    arena.players[arena.players.size] = self;

  thread playerwatchdisconnect(arena);
  addloadingplayer(arena, self);

  if(!isDefined(self._id_0C990BB0E3679AA3))
    self._id_0C990BB0E3679AA3 = 0;

  self._id_0C990BB0E3679AA3++;
  _id_31A4C88B15E309B1(1);
  _id_E87A2870AC8A5BBC(1);
  _id_51918195255E4510(arena);
  scripts\mp\outofbounds::enableoobimmunity(self);
  _id_8F5D6F42D8464DE0 = getnextarenaspawn(arena);
  spawnorigin = getgroundposition(_id_8F5D6F42D8464DE0.origin, 12);
  spawnangles = (0, 0, 0);

  if(isDefined(_id_8F5D6F42D8464DE0.angles))
    spawnangles = _id_8F5D6F42D8464DE0.angles;

  _id_3F39A8B789073E7B = _id_F863CB103165FC30(spawnorigin);
  self._id_DB6F41C218095E85 = 1;
  self.streampoint = spawnStruct();
  self.streampoint.origin = spawnorigin;
  self.streampoint.angles = spawnangles;

  if(istrue(_id_DB8FB5275CEB12F5))
    _id_F8A997096CECDA0A(self);
  else
    _id_091E18CE3201E333(self);

  _id_64ACB6CE534155B7::onplayerentergulag();
  starttime = gettime();
  playerplayintrocinematic();
  self setOrigin(spawnorigin);
  self setplayerangles(spawnangles);

  if(_id_3F39A8B789073E7B) {
    _id_F863CB103165FC30(spawnorigin);
    _id_28EC01D73D0ECA9D();
  }

  self.streampoint = undefined;
  self._id_DB6F41C218095E85 = 0;
  _id_5BAB271917698DC4::resetplayermovespeedscale();

  if(_id_3F39A8B789073E7B)
    _id_BF2845510060C991();

  playershowskippromptcinematic();
  playerwaittillcinematiccomplete(starttime);
  self clearsoundsubmix("solo_cin_igc_music", 2);
  self setclientomnvar("ui_br_infil_started", 1);
  _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
  _id_34ACE2409E58960F();
  scripts\mp\utility\perk::blockperkfunction("specialty_scavenger");
  playerstartarenasetcontrols(0);
  _id_D78B7BCA9758D357(arena);
  thread _id_747E4674642E01B1(arena);
}

_id_4129FE7FBF29D45E() {
  text = scripts\mp\hud_util::createfontstring("default", 1.5);
  text scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -100);
  text.label = &"MP/BR_GULAG_TRAVEL";
  self._id_4129FE7FBF29D45E = text;
}

_id_34ACE2409E58960F() {
  if(isDefined(self._id_4129FE7FBF29D45E))
    self._id_4129FE7FBF29D45E destroy();
}

playerwatchdisconnect(arena) {
  self endon("armoryLost");
  self endon("armory_end");
  self waittill("death_or_disconnect");

  if(isDefined(self))
    arena.players = scripts\engine\utility::array_remove(arena.players, self);
  else
    arena.players = scripts\engine\utility::array_removeundefined(arena.players);

  playerdestroyhud(arena);
}

playerdestroyhud(arena) {
  self setclientomnvar("ui_br_gulag_match_end_time", 0);
  self._id_E7D4483BF887586B = undefined;
}

playerstartarenasetcontrols(enable) {
  if(enable) {
    self allowmelee(1);
    self enableoffhandweapons();
    self allowads(1);
    self allowfire(1);
  } else {
    self allowmelee(0);
    self disableoffhandweapons();
    self allowads(0);
    self allowfire(0);
  }
}

getnextarenaspawn(arena) {
  if(!isDefined(arena.arenaspawncounter))
    arena.arenaspawncounter = 0;

  _id_8F5D6F42D8464DE0 = arena.fightspawns[arena.arenaspawncounter];
  _id_AAF901DC990498C5 = arena.fightspawns.size;
  arena.arenaspawncounter++;
  arena.arenaspawncounter = arena.arenaspawncounter % _id_AAF901DC990498C5;
  return _id_8F5D6F42D8464DE0;
}

playertimedinvunerable(timeout) {
  level endon("game_ended");
  self endon("disconnect");
  self.plotarmor = 1;
  scripts\engine\utility::waittill_any_timeout_no_endon_death_2(timeout, "death", "armoryRespawn");
  self.plotarmor = undefined;
}

_id_5D67812E2D6CA9E3(arena, player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player notify("armory_end");
  player _id_236A093A9A4517C3();
  player thread playertimedinvunerable(5);
  arena.players = scripts\engine\utility::array_remove(arena.players, player);
  _id_D78B7BCA9758D357(arena);
  player playerstartarenasetcontrols(1);
  player _id_5BAB271917698DC4::_id_D669022F6CD65402(0);
  streamtimeout = _id_2CEDCC356F1B9FC8::getdefaultstreamhinttimeoutms() / 1000;

  if(isDefined(level.bot_funcs["bot_armory_get_respawn_point"]) && isbot(player))
    spawnpoint = player[[level.bot_funcs["bot_armory_get_respawn_point"]]](0, streamtimeout);
  else
    spawnpoint = player _id_5BAB271917698DC4::_id_952548D8AED47102(0, streamtimeout);

  _id_11F3B4465C8B637B = player _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
  wait(_id_181BC8A575C1D40B());
  player clearclienttriggeraudiozone(2);
  player _id_5BAB271917698DC4::_id_334A8FE67E88BBE7(1);
  wait 1;
  player._id_538959F1AED7E1D3 = 1;
  player _id_8F56146B370CC700(spawnpoint, _id_11F3B4465C8B637B);
}

_id_181BC8A575C1D40B() {
  waittime = 2.0;
  return waittime;
}

_id_8F56146B370CC700(spawnpoint, _id_11F3B4465C8B637B) {
  _id_30A91E1938CFD1B2 = _id_33EA1CC1AE7EECC6();
  _id_5BAB271917698DC4::_id_7642A6BEE4CDAAA2(spawnpoint, _id_11F3B4465C8B637B, _id_30A91E1938CFD1B2);
}

_id_33EA1CC1AE7EECC6() {
  _id_CDD53A78F51F64FE = _id_5BAB271917698DC4::_id_ADE48AF7C782E202(::_id_2B2A6FE609DF7352, "veh_br_gulag_redeploy_flyby", 1);
  _id_CDD53A78F51F64FE _id_5BAB271917698DC4::_id_9FD565BCD654ED48(::_id_F8F8CB082D70138E);
  _id_CDD53A78F51F64FE _id_5BAB271917698DC4::_id_B4C313DF5D7FB216(::_id_B7ABE335B0B028D0);
  _id_CDD53A78F51F64FE _id_5BAB271917698DC4::_id_02556973693D6315(::_id_3C058746A766D5EF);
  _id_CDD53A78F51F64FE._id_9FDC1F9E4FC628E4._id_491D9866301A91D1 = 1;
  return _id_CDD53A78F51F64FE;
}

_id_B7ABE335B0B028D0(_id_9FDC1F9E4FC628E4) {
  _id_9FDC1F9E4FC628E4._id_AB53D8433A949828 = 1;
  _id_31A4C88B15E309B1(0);
  _id_E87A2870AC8A5BBC(0);
  playerdestroyhud(self.arena);
  self._id_360BBFCE98A8056A = undefined;
  return 0;
}

_id_F8F8CB082D70138E(_id_9FDC1F9E4FC628E4) {
  if(istrue(self._id_060F4C86076523F3)) {
    self._id_060F4C86076523F3 = undefined;
    self setclientdvar("dvar_B21F1157C582FF15", 1);
  }

  self.plotarmor = undefined;
  self.c130 = undefined;
  return 1;
}

_id_3C058746A766D5EF(_id_9FDC1F9E4FC628E4) {
  if(isDefined(level._id_D13F0C77C8CA3733) && istrue(level._id_D13F0C77C8CA3733.shutdown) && !istrue(self._id_38387B422285483F)) {
    if(!isDefined(self)) {
      return;
    }
    _id_3860250B579EF9FD();
  }
}

_id_2B2A6FE609DF7352(_id_9FDC1F9E4FC628E4) {
  self notify("armoryRespawn");
  _id_3B64EB40368C1450::set("isRespawning", "player_for_spawn_logic", 0);
  self setclientomnvar("ui_gulag", 0);
  self.arena = undefined;
}

_id_31A4C88B15E309B1(value) {
  if(isDefined(self._id_D13F0C77C8CA3733) && self._id_D13F0C77C8CA3733 == value) {
    return;
  }
  self._id_D13F0C77C8CA3733 = value;
  level notify("update_circle_hide");
}

_id_E87A2870AC8A5BBC(value, _id_731BE535E00271C8) {
  if(isDefined(self._id_9874B71C4068019A) && self._id_9874B71C4068019A == value) {
    return;
  }
  if(!istrue(_id_731BE535E00271C8))
    _id_9C8F21528B90AEAC(value);

  self._id_9874B71C4068019A = value;
  level notify("update_circle_hide");
}

_id_9C8F21528B90AEAC(value) {
  if(istrue(value))
    self.game_extrainfo = self.game_extrainfo | 1024;
  else
    self.game_extrainfo = self.game_extrainfo &~1024;
}

_id_51918195255E4510(arena) {
  if(arena._id_65E4FD32C2391CA9 > 7) {
    return;
  }
  _id_8534515023AFC188 = 3;
  _id_64571E3AECCD1A07 = 3;
  mask = int(pow(2, _id_8534515023AFC188)) - 1;
  _id_A463992091F1D483 = (arena._id_65E4FD32C2391CA9 &mask) << _id_64571E3AECCD1A07;
  _id_F8F977081D3DA8B4 = ~(mask << _id_64571E3AECCD1A07);
  _id_EE27F3F198276535 = self.game_extrainfo;
  _id_ED711AEAF5E8CB76 = _id_EE27F3F198276535 &_id_F8F977081D3DA8B4;
  _id_82A90E56E416FA55 = _id_ED711AEAF5E8CB76 + _id_A463992091F1D483;
  self.game_extrainfo = _id_82A90E56E416FA55;
}

playerpreloadintrocinematic() {
  if(!isbot(self))
    self preloadcinematicforplayer("gulag_enter");
}

playerplayintrocinematic() {
  if(!isbot(self)) {
    self setclientomnvar("ui_br_bink_overlay_state", 1);
    _id_7B2FEA7137B990B1 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_gulag_intro");
    self setplayermusicstate(_id_7B2FEA7137B990B1);
    self setsoundsubmix("solo_cin_igc_music", 0.5);
    self _meth_786FEE88B4749DFF(0);
    self._id_BD7A91335B894041 = 1;
  } else
    _id_4129FE7FBF29D45E();
}

playershowskippromptcinematic() {
  self setclientomnvar("ui_br_bink_overlay_state", 2);
}

playerwaittillcinematiccomplete(starttime) {
  if(!isbot(self) && !self isplayerheadless()) {
    self freezecontrols(1);
    _id_FDEF1592FFDA3A4A = _playerwaittillcinematiccompleteinternal(starttime);

    if(!isDefined(_id_FDEF1592FFDA3A4A))
      _id_FDEF1592FFDA3A4A = 1;

    self freezecontrols(0);
    self setclientomnvar("ui_br_bink_overlay_state", 5);
    self stopcinematicforplayer(_id_FDEF1592FFDA3A4A);
    self._id_BD7A91335B894041 = undefined;
  }
}

_playerwaittillcinematiccompleteinternal(starttime) {
  self endon("bink_complete");

  while(gettime() - starttime < 17000) {
    if(self crouchbuttonPressed() || self useButtonPressed() || self jumpbuttonPressed())
      return 1;

    waitframe();
  }

  return 0;
}

playercinematiccompletecallback(_id_7148C1A6F25491F8, val) {
  if(_id_7148C1A6F25491F8 == "bink_complete")
    self notify("bink_complete");
}

_id_6BA5BA23432E39C5(grenade) {
  player = self;
  player endon("disconnect");
  grenade endon("explode_end");
  grenade thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  player thread _id_EF6946684471EC36(grenade);
  grenade waittill("explode", position);
  player notify("armory_drop_finished");
  thread _id_A72C872ABB157337(position);

  if(scripts\mp\outofbounds::ispointinoutofbounds(position)) {
    if(isDefined(grenade))
      grenade delete();

    if(isDefined(player.super))
      player scripts\mp\supers::superusefinished(1);

    return;
  }

  heli = _id_C85B35CDF7A35B69(player, position);

  if(isDefined(player.super)) {
    if(isDefined(heli))
      player scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
    else
      player scripts\mp\supers::superusefinished(1);
  }
}

_id_EF6946684471EC36(grenade) {
  player = self;
  player endon("disconnect");
  player endon("armory_drop_finished");
  grenade waittill("death");
  waitframe();

  if(isDefined(player.super))
    player scripts\mp\supers::superusefinished(1);
}

_id_A72C872ABB157337(position) {
  _id_0BA3396E2B7597B2 = spawn("script_origin", position);
  _id_0BA3396E2B7597B2 playLoopSound("smoke_carepackage_smoke_lp");
  wait 21;
  _id_0BA3396E2B7597B2 playSound("smoke_canister_tail_dissipate");
  _id_0BA3396E2B7597B2 stoploopsound("smoke_carepackage_smoke_lp");
  wait 5;
  _id_0BA3396E2B7597B2 delete();
}

_id_C85B35CDF7A35B69(owner, position) {
  extractgroundpos = position;
  _id_DB4ADBA9675A31AA = extractgroundpos + (0, 0, 2000);
  _id_CC089176A2D8AB71 = extractgroundpos + (0, 0, 8000);
  _id_7CE2EF2A1EFE71A6 = extractgroundpos + (0, 0, 800);
  flightyaw = 0;
  _id_FDA870B32AB92C1F = (0, 0, 0);
  flightyaw = _id_6AFF3948CF4CCA03::getclearpathflightyaw(undefined, _id_CC089176A2D8AB71, _id_DB4ADBA9675A31AA);
  _id_FDA870B32AB92C1F = (0, flightyaw, 0);

  if(getdvarint("dvar_D5878CA9E558DD32", 0) == 1) {
    _id_CB2DC60F7CAFC6D4 = -100;
    _id_F0DB3D408327DB23 = 60;
    _id_67C2F437706DE4A1 = anglesToForward(_id_FDA870B32AB92C1F);
    _id_954350C43B0BCBC2 = anglestoright(_id_FDA870B32AB92C1F);
    extractgroundpos = extractgroundpos + _id_67C2F437706DE4A1 * _id_CB2DC60F7CAFC6D4 + _id_954350C43B0BCBC2 * _id_F0DB3D408327DB23;
    _id_DB4ADBA9675A31AA = extractgroundpos + (0, 0, 2000);
    _id_7CE2EF2A1EFE71A6 = extractgroundpos + (0, 0, 800);
  }

  _id_16CEDB94FAF4D596 = _id_CC089176A2D8AB71 - anglesToForward(_id_FDA870B32AB92C1F) * 20000;
  heli = spawnheli(self, _id_16CEDB94FAF4D596, _id_DB4ADBA9675A31AA, _id_7CE2EF2A1EFE71A6, extractgroundpos);
  return heli;
}

spawnheli(owner, enterpos, descendpos, hoverpos, extractgroundpos) {
  _id_87CEF10BF5729579 = 1;
  _id_1D4278103BA47A16 = vectortoangles(descendpos * (1, 1, 0) - enterpos * (1, 1, 0));
  heli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(owner, enterpos, _id_1D4278103BA47A16, "veh_apache_plunder_mp", "veh8_mil_air_mindia8_plunder_x");

  if(!isDefined(heli)) {
    return;
  }
  heli.damagecallback = _id_6AFF3948CF4CCA03::callback_vehicledamage;
  heli.speed = 100;
  heli.accel = 125;
  heli.health = 1000;
  heli.maxhealth = heli.health;
  heli.team = owner.team;
  heli.owner = owner;
  heli.lifeid = 0;
  heli.flaresreservecount = _id_87CEF10BF5729579;
  heli.enterpos = enterpos;
  heli.descendpos = descendpos;
  heli.hoverpos = hoverpos;
  heli.extractgroundpos = extractgroundpos;
  heli.sceneangles = _id_1D4278103BA47A16;
  heli.vehiclename = "magma_plunder_chopper";
  heli.animname = "plunder_extract_heli";
  heli setCanDamage(1);
  heli setmaxpitchroll(10, 25);
  heli vehicle_setspeed(heli.speed, heli.accel);
  heli sethoverparams(1, 1, 1);
  heli setturningability(0.05);
  heli setyawspeed(45, 25, 25, 0.5);
  heli setotherent(owner);
  heli setscriptablepartstate("engine", "on");
  heli setscriptablepartstate("tail_light", "red");
  heli setscriptablepartstate("cockpit_light", "on");
  heli setscriptablepartstate("infil_lights", "on");
  heli.scenenode = spawn("script_model", heli.extractgroundpos);
  heli.scenenode.angles = heli.sceneangles;
  heli.scenenode setModel("tag_origin");
  heli.scenenode scripts\common\anim::anim_first_frame_solo(heli, "heli_in");
  heli thread _id_8A0D8BC485BF74B7();
  spawnropeandbag(heli);
  return heli;
}

spawnropeandbag(heli) {
  rope = spawn("script_model", (0, 0, 0));
  rope setModel("misc_rapelling_rope_01_fiber_br");
  rope linkTo(heli, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  rope.animname = heli.animname;
  rope scripts\common\anim::setanimtree();
  heli scripts\common\anim::anim_first_frame_solo(rope, "rope_in", "origin_animate_jnt");
  heli.rope = rope;
}

_id_8A0D8BC485BF74B7() {
  self endon("death");
  self endon("leaving");
  groundz = self.extractgroundpos[2];
  _id_625180CE8D2F8F77 = self.descendpos[2] - groundz;
  self.flytime = _id_6AFF3948CF4CCA03::calculatehelitimetoarrive(_id_625180CE8D2F8F77);
  thread heliwatchgameendleave();
  self.preventleave = 1;
  helidescend();
  self.preventleave = undefined;
  self setscriptablepartstate("vector_field", "on");
  thread _id_EFA0615330E0E60F();
  wait(level._id_D13F0C77C8CA3733._id_2874B9C947A0B65C);
  self.rope makeunusable();
  thread _id_6AFF3948CF4CCA03::helileave(1);
}

heliwatchgameendleave() {
  self endon("death");
  self endon("try_to_leave");
  level waittill("game_ended");
  thread helileave(0);
}

helidescend() {
  self endon("death");
  _id_228083B1CC503599 = getanimlength(level.scr_anim[self.animname]["heli_in"]);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, "heli_in");
  thread scripts\common\anim::anim_single_solo(self.rope, "rope_in", "origin_animate_jnt");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_228083B1CC503599);
  thread _id_6AFF3948CF4CCA03::heliplayloopanim();
  thread _id_6AFF3948CF4CCA03::heliplayloopropeanim();
}

helileave(_id_C76F5BA0AD745444) {
  if(istrue(self.tryingtoleave) || istrue(self.leaving)) {
    return;
  }
  self endon("death");
  self notify("try_to_leave");
  self.tryingtoleave = 1;
  self.readytoleave = 1;
  self waittill("ready_to_leave");
  self notify("leaving");
  self.leaving = 1;
  self.tryingtoleave = undefined;
  _id_DBEE990416F1879A = getanimlength(level.scr_anim[self.animname]["heli_out"]);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, "heli_out");
  thread scripts\common\anim::anim_single_solo(self.rope, "rope_out", "origin_animate_jnt");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_DBEE990416F1879A);
  self stoploopsound();
  self notify("heli_gone");
  _id_6AFF3948CF4CCA03::helidelete();
}

_id_EFA0615330E0E60F() {
  self endon("death");
  self endon("ready_to_leave");
  rope = self.rope;
  rope makeusable();
  rope sethinttag("j_carabiner_gate");
  rope setCursorHint("HINT_NOICON");
  rope sethintonobstruction("show");
  rope sethintdisplayrange(200);
  rope sethintdisplayfov(180);
  rope setuserange(200);
  rope setusefov(180);
  rope setuseprioritymax();
  rope setuseholdduration("duration_none");
  rope setHintString(&"BR_BURN/USE_ROPE");

  for(;;) {
    rope waittill("trigger", player);

    if(istrue(player._id_D13F0C77C8CA3733)) {
      continue;
    }
    player thread initplayerarena();
  }
}

_id_735C3F70A42AC83A(arena) {
  spawnpoint = arena.center;

  if(isDefined(arena._id_1DF1ACEE38DCCA72))
    spawnpoint = arena._id_1DF1ACEE38DCCA72;

  spawnpoint = getgroundposition(spawnpoint, 1);
  _id_0C26FC18BDA607B7 = "chili_western_chuy";
  _id_E3BF2B6FB9AF5BF7 = spawn("script_model", spawnpoint);
  body = tablelookup("operatorSkins.csv", 1, _id_0C26FC18BDA607B7, 4);
  head = tablelookup("operatorSkins.csv", 1, _id_0C26FC18BDA607B7, 5);

  if(body == "" || head == "") {
    return;
  }
  _id_E3BF2B6FB9AF5BF7 _meth_DD6D30B9EC87C1B3(body, head, "iw9_avatar_scriptable_mp");
  _id_E3BF2B6FB9AF5BF7 scriptmodelplayanim("intd_0500_sniper_rifle_handoff_idle_graves", "graves_notify");
  _id_884DD6B790DB5582 = spawn("script_model", spawnpoint + (0, 0, 80));
  _id_884DD6B790DB5582 makeusable();
  _id_884DD6B790DB5582 setCursorHint("HINT_NOICON");
  _id_884DD6B790DB5582 sethintonobstruction("show");
  _id_884DD6B790DB5582 sethintdisplayrange(200);
  _id_884DD6B790DB5582 sethintdisplayfov(180);
  _id_884DD6B790DB5582 setuserange(150);
  _id_884DD6B790DB5582 setusefov(180);
  _id_884DD6B790DB5582 setuseprioritymax();
  _id_884DD6B790DB5582 setuseholdduration("duration_none");
  _id_884DD6B790DB5582 setHintString(&"BR_BURN/ARMORY_BUY");
  arena._id_E3BF2B6FB9AF5BF7 = _id_E3BF2B6FB9AF5BF7;
  _id_E3BF2B6FB9AF5BF7.objid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(_id_E3BF2B6FB9AF5BF7.objid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(_id_E3BF2B6FB9AF5BF7.objid, "current", (0, 0, 0), "ui_mp_br_mapmenu_icon_timedrun_objective");
    scripts\mp\objidpoolmanager::update_objective_setbackground(_id_E3BF2B6FB9AF5BF7.objid, 1);
    objective_showtoplayersinmask(_id_E3BF2B6FB9AF5BF7.objid);
    _func_D76CC64B205084A3(_id_E3BF2B6FB9AF5BF7.objid, 1);
    objective_sethideelevation(_id_E3BF2B6FB9AF5BF7.objid, 1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(_id_E3BF2B6FB9AF5BF7.objid, 0);
    scripts\mp\objidpoolmanager::update_objective_position(_id_E3BF2B6FB9AF5BF7.objid, _id_E3BF2B6FB9AF5BF7.origin + (0, 0, 80));
    _id_D78B7BCA9758D357(arena);
  } else {}

  for(;;) {
    _id_884DD6B790DB5582 waittill("trigger", player);

    if(isDefined(player._id_A9A0460EBCE07076)) {
      continue;
    }
    player thread _id_64C89942F49B60F4();
  }
}

_id_D78B7BCA9758D357(arena) {
  if(arena._id_E3BF2B6FB9AF5BF7.objid == -1) {
    return;
  }
  objective_removeallfrommask(arena._id_E3BF2B6FB9AF5BF7.objid);

  foreach(player in arena.players)
  objective_addclienttomask(arena._id_E3BF2B6FB9AF5BF7.objid, player);

  objective_showtoplayersinmask(arena._id_E3BF2B6FB9AF5BF7.objid);
}

_id_64C89942F49B60F4() {
  self endon("armory_end");
  self endon("armory_menu_done");
  _id_DAE95CD0065FE9D1(1);
  _id_18D080F08E691918();
  thread _id_D249B630F2DBBEBA();
  thread _id_9144ED91909634A9();
  _id_832427E22C3BDC9C = _id_74E6B08E2FD1F185();

  if(!isDefined(_id_832427E22C3BDC9C)) {
    return;
  }
  for(;;) {
    result = scripts\engine\utility::waittill_any_return_3("button_up", "button_down", "button_buy");

    if(result == "button_up")
      _id_832427E22C3BDC9C = _id_D00D668DE6EB4FC0(_id_832427E22C3BDC9C, -1);
    else if(result == "button_down")
      _id_832427E22C3BDC9C = _id_D00D668DE6EB4FC0(_id_832427E22C3BDC9C, 1);
    else if(result == "button_buy") {
      _id_F7F5C39F5859E72B(_id_832427E22C3BDC9C);
      _id_832427E22C3BDC9C = _id_74E6B08E2FD1F185();
    }

    if(!isDefined(_id_832427E22C3BDC9C))
      return;
  }
}

_id_18D080F08E691918() {
  yoffset = -140;
  self._id_A9A0460EBCE07076 = [];
  self._id_DD7363ADE6EB121D = [];
  _id_EFAB1E46C4D0895F = _id_60E4A3BBB3596257::_id_0EB34F4E3E2AAEAC(0, yoffset, "center", "middle", "center", "middle", (1, 1, 1), &"BR_BURN/MENU_TITLE");
  _id_EFAB1E46C4D0895F.fontscale = 2.5;
  self._id_A9A0460EBCE07076[self._id_A9A0460EBCE07076.size] = _id_EFAB1E46C4D0895F;
  yoffset = yoffset + 20;
  _id_EFAB1E46C4D0895F = _id_60E4A3BBB3596257::_id_0EB34F4E3E2AAEAC(0, yoffset, "center", "middle", "center", "middle", (1, 1, 1), &"BR_BURN/MENU_DESC");
  _id_EFAB1E46C4D0895F.fontscale = 1.75;
  self._id_A9A0460EBCE07076[self._id_A9A0460EBCE07076.size] = _id_EFAB1E46C4D0895F;
  yoffset = yoffset + 30;
  _id_EFAB1E46C4D0895F = _id_60E4A3BBB3596257::_id_0EB34F4E3E2AAEAC(0, yoffset, "center", "middle", "center", "middle", (1, 1, 1), &"BR_BURN/MENU_CASH", self.plundercount * 10);
  _id_EFAB1E46C4D0895F.fontscale = 1.75;
  self._id_A9A0460EBCE07076[self._id_A9A0460EBCE07076.size] = _id_EFAB1E46C4D0895F;
  self._id_06BF118285D7F9CD = _id_EFAB1E46C4D0895F;
  yoffset = yoffset + 30;
  _id_F6E3C342CCBB6C72(yoffset, &"BR_BURN/MENU_OPTION_AMMO", level._id_D13F0C77C8CA3733._id_24A76548721885FA, ::_id_F91E948CA4E26000, ::_id_FF17F5D996EB9282);
  yoffset = yoffset + 20;
  _id_F6E3C342CCBB6C72(yoffset, &"BR_BURN/MENU_OPTION_HEALTH", level._id_D13F0C77C8CA3733._id_1D4A31E5DB2FC768, ::_id_D347AF27ED1A2EB4, ::_id_ACC6C66E1FCAF1A0);
  yoffset = yoffset + 20;
  _id_F6E3C342CCBB6C72(yoffset, &"BR_BURN/MENU_OPTION_ARMOR", level._id_D13F0C77C8CA3733._id_35E74BF677D87AA7, ::_id_4E542EADC428EF35, ::_id_94A5CDA0E4C0CDAB);
  yoffset = yoffset + 20;
  _id_F6E3C342CCBB6C72(yoffset, &"BR_BURN/MENU_OPTION_LOADOUT", 2000, ::_id_C7D104AE52DF83CA);
  yoffset = yoffset + 20;
  _id_F6E3C342CCBB6C72(yoffset, &"BR_BURN/MENU_OPTION_FORESIGHT", level._id_D13F0C77C8CA3733._id_3E1D67D0805529CF, ::_id_4D5E345A0B046F31, ::_id_A95E7808D5E90321);
  yoffset = yoffset + 20;
  _id_F6E3C342CCBB6C72(yoffset, &"BR_BURN/MENU_OPTION_ASSASSIN", level._id_D13F0C77C8CA3733._id_88B1F74D6A183865, ::_id_C5BE79F613D58BAB, ::_id_C6B9B5B7D7701D13);

  if(!istrue(self._id_2DF5E965025C9E72)) {
    yoffset = yoffset + 20;
    _id_F6E3C342CCBB6C72(yoffset, &"BR_BURN/MENU_OPTION_JUGG", 0, ::_id_DDF2F0BD3F906D36, ::_id_8222BDCAC72DA4A4, level._id_D13F0C77C8CA3733._id_B7139738B0DF963B);
  }

  yoffset = yoffset + 30;
  _id_EFAB1E46C4D0895F = _id_60E4A3BBB3596257::_id_0EB34F4E3E2AAEAC(-50, yoffset, "center", "middle", "center", "middle", (1, 1, 1), &"BR_BURN/MENU_BUY");
  _id_EFAB1E46C4D0895F.fontscale = 1.75;
  self._id_A9A0460EBCE07076[self._id_A9A0460EBCE07076.size] = _id_EFAB1E46C4D0895F;
  _id_EFAB1E46C4D0895F = _id_60E4A3BBB3596257::_id_0EB34F4E3E2AAEAC(50, yoffset, "center", "middle", "center", "middle", (1, 1, 1), &"BR_BURN/MENU_CANCEL");
  _id_EFAB1E46C4D0895F.fontscale = 1.75;
  self._id_A9A0460EBCE07076[self._id_A9A0460EBCE07076.size] = _id_EFAB1E46C4D0895F;
}

_id_F6E3C342CCBB6C72(yoffset, text, cost, _id_EA377760DD2E8165, _id_2575553F2D6EA40F, keys) {
  value = cost;

  if(isDefined(keys))
    value = keys;

  _id_EFAB1E46C4D0895F = _id_60E4A3BBB3596257::_id_0EB34F4E3E2AAEAC(0, yoffset, "center", "middle", "center", "middle", (1, 1, 1), text, value);
  _id_EFAB1E46C4D0895F.cost = int(cost / 10);
  _id_EFAB1E46C4D0895F._id_EA377760DD2E8165 = _id_EA377760DD2E8165;
  _id_EFAB1E46C4D0895F._id_2575553F2D6EA40F = _id_2575553F2D6EA40F;
  _id_EFAB1E46C4D0895F.fontscale = 1.5;
  _id_EFAB1E46C4D0895F._id_CD064165DD4505E8 = keys;
  self._id_DD7363ADE6EB121D[self._id_DD7363ADE6EB121D.size] = _id_EFAB1E46C4D0895F;
}

_id_9144ED91909634A9() {
  result = scripts\engine\utility::waittill_any_return_no_endon_death_3("armory_end", "armory_menu_done", "disconnect");

  if(result != "disconnect")
    _id_DAE95CD0065FE9D1(0);

  foreach(item in self._id_A9A0460EBCE07076) {
    if(isDefined(item))
      item destroy();
  }

  self._id_A9A0460EBCE07076 = undefined;

  foreach(item in self._id_DD7363ADE6EB121D) {
    if(isDefined(item))
      item destroy();
  }

  self._id_DD7363ADE6EB121D = undefined;
}

_id_F7F5C39F5859E72B(index) {
  _id_EFAB1E46C4D0895F = self._id_DD7363ADE6EB121D[index];

  if(_id_EFAB1E46C4D0895F.cost > 0) {
    _id_4D6E86BFD7C3B678 = self.plundercount - _id_EFAB1E46C4D0895F.cost;
    _id_6AFF3948CF4CCA03::playersetplundercount(_id_4D6E86BFD7C3B678);
    self._id_06BF118285D7F9CD setvalue(self.plundercount * 10);
  } else if(isDefined(_id_EFAB1E46C4D0895F._id_CD064165DD4505E8))
    self._id_CD064165DD4505E8 = self._id_CD064165DD4505E8 - _id_EFAB1E46C4D0895F._id_CD064165DD4505E8;

  self playsoundtoplayer("br_legendary_loot_pickup", self);

  if(!_id_106F209929F632F6(_id_EFAB1E46C4D0895F) || !_id_505CCD7C679217B2()) {
    _id_EFAB1E46C4D0895F.color = (1, 0, 0);
    _id_EFAB1E46C4D0895F.fontscale = 1.5;
  }

  self[[_id_EFAB1E46C4D0895F._id_EA377760DD2E8165]]();
}

_id_2AFC5E37C0E4786A() {
  _id_7E52B56769FA7774::forcegivekillstreak("uav", 1, 0, 0, 0);
}

_id_F91E948CA4E26000() {
  self._id_11525426FEEB297A = 1;
  self._id_F497AE55EEF569AF = 1;

  foreach(ammotype in level.br_ammo_types)
  self.pers["br_ammo"][ammotype] = int(level._id_E6EA72FC5E3FCD00[ammotype] * level._id_D13F0C77C8CA3733._id_14DD394D0DA36979);

  self notify("br_spawned");
}

_id_FF17F5D996EB9282() {
  if(_id_60E4A3BBB3596257::_id_0194C860F5134A8E(self.team))
    return 0;

  return !istrue(self._id_F497AE55EEF569AF);
}

_id_D347AF27ED1A2EB4() {
  self._id_998FAFEC36D8DF37 = level._id_D13F0C77C8CA3733._id_521F243349AF668D;
  self.maxhealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth") + self._id_998FAFEC36D8DF37;
  self.health = self.maxhealth;
  _id_60E4A3BBB3596257::_id_E8D143F10B79AE82();
}

_id_ACC6C66E1FCAF1A0() {
  if(_id_60E4A3BBB3596257::_id_0194C860F5134A8E(self.team))
    return 0;

  return !isDefined(self._id_998FAFEC36D8DF37);
}

_id_4E542EADC428EF35() {
  _id_60E4A3BBB3596257::_id_B2502A42DB5D61D0();
  self._id_4D90DDC000519B22 = 1;
  self._id_BED158A6DFAC230D = 4;
  self._id_8790C077C95DB752 = self._id_BED158A6DFAC230D * 50;
  self.armorhealth = self._id_8790C077C95DB752;
  _id_60E4A3BBB3596257::_id_CF547D762189DEAA();
}

_id_94A5CDA0E4C0CDAB() {
  if(_id_60E4A3BBB3596257::_id_0194C860F5134A8E(self.team))
    return 0;

  return !istrue(self._id_4D90DDC000519B22);
}

_id_C7D104AE52DF83CA() {
  _id_7E52B56769FA7774::forcegivesuper("super_supply_drop", 1, 0, 0, 0);
}

_id_65A41D705FAF6B0D() {}

_id_4D5E345A0B046F31() {
  _id_5238DEE479BBF7FB::_id_647A8C40104E4866(self.team);
}

_id_A95E7808D5E90321() {
  if(_id_60E4A3BBB3596257::_id_0194C860F5134A8E(self.team))
    return 0;

  if(istrue(level.br_circle_disabled))
    return 0;

  if(!isDefined(level.teamswithcirclepeek[self.team]))
    return 1;

  index = level.teamswithcirclepeek[self.team] + 1 + level.br_circle.circleindex + 1;

  if(!isDefined(level.circlepeeks[index]))
    return 0;

  return 1;
}

_id_C5BE79F613D58BAB() {
  thread _id_60E4A3BBB3596257::_id_4E8E7C7B894A161E(self.team, 1);
}

_id_C6B9B5B7D7701D13() {
  return _id_60E4A3BBB3596257::_id_0194C860F5134A8E(self.team);
}

_id_DDF2F0BD3F906D36() {
  streakinfo = spawnStruct();
  thread scripts\cp_mp\killstreaks\juggernaut::activatejugg(streakinfo);
  self._id_2DF5E965025C9E72 = 1;
}

_id_8222BDCAC72DA4A4() {
  if(_id_60E4A3BBB3596257::_id_0194C860F5134A8E(self.team))
    return 0;

  return !istrue(self._id_2DF5E965025C9E72);
}

_id_106F209929F632F6(item) {
  if(item.cost > 0 && self.plundercount < item.cost)
    return 0;

  if(isDefined(item._id_CD064165DD4505E8) && self._id_CD064165DD4505E8 < item._id_CD064165DD4505E8)
    return 0;

  return !isDefined(item._id_2575553F2D6EA40F) || [[item._id_2575553F2D6EA40F]]();
}

_id_74E6B08E2FD1F185() {
  _id_E59CF0315464DA11 = undefined;

  foreach(index, item in self._id_DD7363ADE6EB121D) {
    if(!_id_106F209929F632F6(item)) {
      item.color = (1, 0, 0);
      item.fontscale = 1.5;
      continue;
    }

    if(!isDefined(_id_E59CF0315464DA11)) {
      _id_E59CF0315464DA11 = index;
      item.color = (0, 1, 1);
      item.fontscale = 1.75;
      continue;
    }

    item.color = (1, 1, 1);
    item.fontscale = 1.5;
  }

  return _id_E59CF0315464DA11;
}

_id_505CCD7C679217B2() {
  foreach(index, item in self._id_DD7363ADE6EB121D) {
    if(_id_106F209929F632F6(item))
      return 1;
  }

  return 0;
}

_id_D00D668DE6EB4FC0(_id_832427E22C3BDC9C, _id_301D62DA1A0738F1) {
  _id_FA8DA2EA2583F71E = undefined;
  _id_D8A90D71EDD48B85 = _id_832427E22C3BDC9C;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_DD7363ADE6EB121D.size; _id_AC0E594AC96AA3A8++) {
    _id_D8A90D71EDD48B85 = _id_D8A90D71EDD48B85 + _id_301D62DA1A0738F1;

    if(_id_D8A90D71EDD48B85 < 0)
      _id_D8A90D71EDD48B85 = self._id_DD7363ADE6EB121D.size - 1;
    else if(_id_D8A90D71EDD48B85 >= self._id_DD7363ADE6EB121D.size)
      _id_D8A90D71EDD48B85 = 0;

    _id_EFAB1E46C4D0895F = self._id_DD7363ADE6EB121D[_id_D8A90D71EDD48B85];

    if(_id_106F209929F632F6(_id_EFAB1E46C4D0895F)) {
      if(_id_832427E22C3BDC9C != _id_D8A90D71EDD48B85) {
        _id_EFAB1E46C4D0895F.color = (0, 1, 1);
        _id_EFAB1E46C4D0895F.fontscale = 1.75;
        _id_15599B715E8F0D6A = self._id_DD7363ADE6EB121D[_id_832427E22C3BDC9C];
        _id_15599B715E8F0D6A.color = (1, 1, 1);
        _id_15599B715E8F0D6A.fontscale = 1.5;
      }

      return _id_D8A90D71EDD48B85;
    }
  }

  return _id_832427E22C3BDC9C;
}

_id_D249B630F2DBBEBA() {
  self endon("armory_end");
  self endon("armory_menu_done");
  _id_B0ACC21791CD1733 = 0;

  for(;;) {
    if(self getnormalizedmovement()[0] > 0 && _id_B0ACC21791CD1733 < gettime()) {
      self notify("button_up");
      _id_B0ACC21791CD1733 = gettime() + 100;
    } else if(self getnormalizedmovement()[0] < 0 && _id_B0ACC21791CD1733 < gettime()) {
      self notify("button_down");
      _id_B0ACC21791CD1733 = gettime() + 100;
    } else if(self useButtonPressed()) {
      self notify("button_buy");
      wait 1.0;
    } else if(self crouchbuttonPressed())
      self notify("armory_menu_done");

    waitframe();
  }
}

_id_DAE95CD0065FE9D1(_id_F68A36431E44BA75) {
  if(_id_F68A36431E44BA75) {
    self allowmovement(0);
    self allowcrouch(0);
    self allowprone(0);
    self allowjump(0);
  } else {
    self allowmovement(1);
    self allowcrouch(1);
    self allowprone(1);
    self allowjump(1);
  }
}