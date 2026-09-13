/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7e32c4283965a098.gsc
***********************************************/

_id_D8DF6AC7C62A1EBA() {
  level thread _id_701449195235BE31::_id_256740E934855015();
  level thread _id_58DDFF7D01EB5FD0();
}

_id_58DDFF7D01EB5FD0() {
  level endon("game_ended");
  level endon("dmz_bio_lab_radiation_started");
  level waittill("matchStartTimer_done");
  wait(level._id_FF04728F8E36403F);
  _id_AC56A2548A28B7E8 = getdvarint("dvar_7DEA1637F5BC2B5F", 2);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_AC56A2548A28B7E8; _id_AC0E594AC96AA3A8++) {
    _id_5BEB3E655732739D(_id_AC0E594AC96AA3A8 == _id_AC56A2548A28B7E8 - 1);
    wait(getdvarint("dvar_C25E5A451AFA38F8", 120));
  }
}

_id_CC8CF9C935AC4C33() {
  level endon("game_ended");
  _id_9B696815010BB8D3 = [];
  _id_101114B0DD43F574 = "elevator_3";
  _id_E5658FB0BE4CD4F5 = "elevator_6";

  if(!getdvarint("dvar_B794A9AFA3846839", 0))
    _id_9B696815010BB8D3 = scripts\engine\utility::array_add(_id_9B696815010BB8D3, _id_101114B0DD43F574);

  if(!getdvarint("dvar_75D519D598BA5696", 0))
    _id_9B696815010BB8D3 = scripts\engine\utility::array_add(_id_9B696815010BB8D3, _id_E5658FB0BE4CD4F5);

  wait 3;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9B696815010BB8D3.size; _id_AC0E594AC96AA3A8++)
    _id_5C118165D3E98A42::_id_20E0F2F56A5BA71F("exfil", "elevator_group_exfil", "waiting", _id_9B696815010BB8D3[_id_AC0E594AC96AA3A8], ::_id_AFBF36D94E008712);

  level waittill("dmz_bio_lab_shutdown_all_elevators");
  _id_675ED89AF78F6A12 = _func_82D95BA721744147(level.elevators["elevator_group_exfil"]);

  foreach(id in _id_9B696815010BB8D3) {
    _id_EEC55FABA21F3653 = _id_5C118165D3E98A42::_id_B7EE067FA2ED527D(id);

    if(scripts\engine\utility::array_contains(_id_675ED89AF78F6A12, _id_EEC55FABA21F3653))
      _id_EEC55FABA21F3653 _id_548E6611AA0A5A63();
  }
}

_id_5BEB3E655732739D(_id_11DB7E62C72D70DF) {
  _id_476FDBC4F0D1EF0A = "elevator_pick_rule_random_exclude_picked";
  _id_133738871E398CF3 = undefined;

  if(istrue(_id_11DB7E62C72D70DF)) {
    _id_1B6210DC23E9C1E5 = [2];

    if(_id_5C118165D3E98A42::_id_E273AC02F95D54E5("exfil", _id_1B6210DC23E9C1E5)) {
      _id_133738871E398CF3 = _id_1B6210DC23E9C1E5;
      _id_476FDBC4F0D1EF0A = "elevator_pick_rule_random_exclude_picked_on_specify_floors";
    }
  }

  _id_5C118165D3E98A42::_id_8435B8855414BB47("exfil", "elevator_group_exfil", "waiting", undefined, _id_476FDBC4F0D1EF0A, _id_133738871E398CF3);
}

_id_AFBF36D94E008712(_id_EEC55FABA21F3653, param) {
  _id_EEC55FABA21F3653._id_7E6513B2AE0D5C1D = 1;
}

_id_086D19A1E5F2B563(iconname, _id_AE52C3C4A761FB73, zoffset) {
  if(!isDefined(self.waypointid))
    self.waypointid = scripts\mp\objidpoolmanager::requestobjectiveid();

  origin = self.origin;

  if(isDefined(zoffset))
    origin = origin + (0, 0, zoffset);

  scripts\mp\objidpoolmanager::objective_add_objective(self.waypointid, "current", origin, iconname, "icon_regular");
  objective_setplayintro(self.waypointid, 0);
  objective_setbackground(self.waypointid, 1);
  objective_setfadedisabled(self.waypointid, 0);
  objective_setshowoncompass(self.waypointid, 1);
  objective_setshowdistance(self.waypointid, _id_AE52C3C4A761FB73);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.waypointid);
}

_id_B08C53A8C68C1491(players, _id_6958D396E4AD3B95, _id_55F38A9ECA24F5B8) {
  waitframe();
  _id_ABDA98D4F5975707 = spawnStruct();
  _id_ABDA98D4F5975707._id_6958D396E4AD3B95 = _id_6958D396E4AD3B95;
  _id_ABDA98D4F5975707._id_55F38A9ECA24F5B8 = _id_55F38A9ECA24F5B8;
  _id_ABDA98D4F5975707._id_5ABB8DC2E7CD678E = players;
  _id_ABDA98D4F5975707.priority = 1;
  _id_ABDA98D4F5975707.id = self.id;
  _id_ABDA98D4F5975707._id_26237A5432EF38B6 = self.car.origin;
  _id_ABDA98D4F5975707 thread _id_701449195235BE31::_id_FF5183505692184F();
}

_id_D62CE6271CADD6AD() {
  level endon("game_ended");

  while(!istrue(level._id_B212A36BEC6CF8DA))
    waitframe();

  scripts\engine\scriptable::scriptable_addusedcallbackbypart("elevator_ext_button", ::_id_E48F0D3775F2A3DA);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("elevator_int_button", ::_id_0D23A307DE97A0A8);
  _id_5C118165D3E98A42::_id_BA13D98DAB57CA7E("elevator_group_exfil", "waiting", ::_id_4497EC9C55F12123);
  _id_5C118165D3E98A42::_id_BA13D98DAB57CA7E("elevator_group_exfil", "doors_warming", ::_id_EACD3D40FF26ED40);
  _id_5C118165D3E98A42::_id_BA13D98DAB57CA7E("elevator_group_exfil", "doors_open", ::_id_EC009A967D1D5EB9);
  _id_5C118165D3E98A42::_id_BA13D98DAB57CA7E("elevator_group_exfil", "doors_closing", ::_id_8B680B3EF155FC34);
  _id_5C118165D3E98A42::_id_BA13D98DAB57CA7E("elevator_group_exfil", "cooldown", ::_id_E86A0C8FB947DB55);
}

_id_E48F0D3775F2A3DA(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(instance._id_EEC55FABA21F3653.group != "elevator_group_exfil") {
    return;
  }
  if(!isDefined(player)) {
    return;
  }
  instance setscriptablepartstate("elevator_button_lights", "down", 0);
  instance setscriptablepartstate("elevator_ext_button", "disabled");
  _id_F49A04061E6EB63D = instance._id_EEC55FABA21F3653._id_3EAD649FC902FEC2 - instance._id_EEC55FABA21F3653._id_33DE00DF8A9FBBE0;

  if(_id_F49A04061E6EB63D < 0)
    instance._id_0E4118BDA122B112 setscriptablepartstate("model", "down", 0);
  else
    instance._id_0E4118BDA122B112 setscriptablepartstate("model", "up", 0);

  instance._id_EEC55FABA21F3653.playerteam = player.team;
  players = scripts\mp\utility\teams::getteamdata(player.team, "players");
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("br_dmz_bio_labs_exfil_activate", players);

  foreach(_id_B2810E8D06E0A042 in players)
  _id_B2810E8D06E0A042 setplayermusicstate("dmz_exfil");

  _id_3707F44961816B2F::_id_F7035067E16DF948(20);

  if(issubstr(instance._id_EEC55FABA21F3653.id, "elevator_1"))
    _id_2D9C29F869A29FCA::_id_844DFE93476D59AB("garage_reinforcement", instance.origin, 0);
  else
    _id_2D9C29F869A29FCA::_id_844DFE93476D59AB("garage_reinforcement", instance.origin);

  instance._id_EEC55FABA21F3653 notify("exfil_elevator_start_warm");
  instance._id_EEC55FABA21F3653 _id_B08C53A8C68C1491(players, level._id_E26F46A3B89CD3BB, 0);
  playerteam = player.team;
  wait(level._id_E26F46A3B89CD3BB);
  _id_024AECB67BB3A207 = scripts\mp\utility\teams::getenemyplayers(playerteam, 1);
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("br_dmz_bio_labs_exfil_warn", _id_024AECB67BB3A207);
}

_id_548E6611AA0A5A63() {
  self.shutdown = 1;

  if(self.state == "waiting")
    _id_94EE6837BFDF0FD5();
}

_id_0D23A307DE97A0A8(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(instance.entity._id_EEC55FABA21F3653.group != "elevator_group_exfil") {
    return;
  }
  instance.entity._id_EEC55FABA21F3653 notify("exfil_elevator_start_extract");
}

_id_4497EC9C55F12123() {
  self._id_E108D0ABDB42CFF6[self._id_3EAD649FC902FEC2] _id_086D19A1E5F2B563("ui_map_icon_extraction", 1);
  self._id_E108D0ABDB42CFF6[self._id_3EAD649FC902FEC2] setscriptablepartstate("elevator_ext_button", "usable");
  _id_F49A04061E6EB63D = self._id_3EAD649FC902FEC2 - self._id_33DE00DF8A9FBBE0;
  self waittill("exfil_elevator_start_warm");
  self.state = "doors_warming";
}

_id_EACD3D40FF26ED40() {
  _id_5C118165D3E98A42::_id_AB1C91150C30299A();
  self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] setscriptablepartstate("elevator_ext_button", "disabled");
  self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] setscriptablepartstate("sound", "touched");
  objective_delete(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0].waypointid);
  self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_CE7F7E62DF1E0B51 _id_086D19A1E5F2B563("ui_map_icon_elevator", 1);
  wait(level._id_E26F46A3B89CD3BB);
  self.state = "doors_open";
}

_id_EC009A967D1D5EB9() {
  _id_C8F6F1542970369C = self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0];
  _id_C8F6F1542970369C setscriptablepartstate("elevator_button_lights", "off", 0);
  _id_C8F6F1542970369C._id_0E4118BDA122B112 setscriptablepartstate("model", "arrived", 0);
  self._id_7A27C9558344447A = [];
  _id_DB76C4BB596D090E = self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0];
  agentarray = getaiarrayinradius(_id_DB76C4BB596D090E.origin, 250);

  foreach(agent in agentarray) {
    if(isalive(agent) && !istrue(agent._id_950C1AB89C9C4E2A)) {
      _id_8BDB743B1288E020 = (agent.origin[0], agent.origin[1], agent.origin[2] + 50);

      if(ispointinvolume(_id_8BDB743B1288E020, _id_DB76C4BB596D090E._id_0907E66D3BF42C5A)) {
        agent._id_01339FF53060F729 = agent.goalpos;
        self._id_7A27C9558344447A[self._id_7A27C9558344447A.size] = agent;
      }
    }
  }

  if(self._id_7A27C9558344447A.size > 0) {
    logstring("=============== Kill agents in Elevator before exfil open===============");
    logstring("Event notification: " + self.event._id_EA3E3B2121E6713A);
    logstring("Elevator Id: " + self.id);
    logstring("Elevator Front Position: " + _id_DB76C4BB596D090E._id_BD440A13487263EF);

    foreach(agent in self._id_7A27C9558344447A) {
      logstring("[ Kill agent ] Orign: " + agent.origin + " agent_type: " + agent.agent_type + " GoalPos: " + agent._id_01339FF53060F729);
      agent setOrigin((agent.origin[0], agent.origin[1], -2000));
    }

    waitframe();

    foreach(agent in self._id_7A27C9558344447A)
    agent kill();

    logstring("=============== Kill agents in Elevator End ===============");
  }

  self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] thread _id_5C118165D3E98A42::_id_FEA8A1D17E4D669F();
  self.car thread scripts\common\anim::anim_single_solo(self.car, "open");
  wait 0.4;
  doors = self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0].doors;

  foreach(door in doors) {
    door.clip.origin = door.clip._id_C2FAC7A209524732;
    door._id_9932BF8D872AEC43.origin = door.clip._id_C2FAC7A209524732;
  }

  if(!istrue(self.shutdown)) {
    _id_F7AA701626610B5B = scripts\engine\utility::ter_op(istrue(self._id_7E6513B2AE0D5C1D), level._id_06B03A4FEAE848EA, level._id_D99059956F0D1F3D);
    scripts\engine\utility::waittill_any_timeout_1(_id_F7AA701626610B5B, "exfil_elevator_start_extract");
  }

  self.state = "doors_closing";
}

_id_8B680B3EF155FC34() {
  _id_4B1E414172FEC3A8 = self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_0E4118BDA122B112;
  self.car setscriptablepartstate("elevator_int_button", "disabled");
  players = scripts\mp\utility\teams::getteamdata(self.playerteam, "players");
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("br_dmz_bio_labs_exfil_extracting", players);
  _id_B08C53A8C68C1491(players, level._id_A0F6CF876AB471E6, 1);
  self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] thread _id_5C118165D3E98A42::_id_7C2ABB1B0D147A89();
  self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] setscriptablepartstate("elevator_ext_button", "disabled");
  _id_DB76C4BB596D090E = self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0];
  doors = self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0].doors;

  foreach(door in doors) {
    _id_295832D2FC0E963C = door.clip._id_F16D407674809F11;
    _id_F2B34DBC14E4C1ED = door.clip._id_C2FAC7A209524732;
    _id_804D947B6EEE1F7C = vectorlerp(_id_F2B34DBC14E4C1ED, _id_295832D2FC0E963C, 1);
    _id_992FB73F893B4AAE = vectorlerp(_id_F2B34DBC14E4C1ED, _id_295832D2FC0E963C, 1);
    door.clip moveTo(_id_804D947B6EEE1F7C, level._id_A0F6CF876AB471E6);
    door._id_9932BF8D872AEC43 moveTo(_id_992FB73F893B4AAE, level._id_A0F6CF876AB471E6);
  }

  wait(level._id_A0F6CF876AB471E6);
  self.car thread scripts\common\anim::anim_single_solo(self.car, "close");

  foreach(door in doors)
  door.clip moveTo(door.clip._id_F16D407674809F11, 0.1);

  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("br_dmz_bio_labs_exfil_extracted", level.players);
  level thread _id_3707F44961816B2F::_id_0E1CA44858CD8EA1("bio_lab_elevator_exfil_complete");
  _id_309C0A11484CC0DB = [];

  foreach(player in level.players) {
    if(player istouching(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_0907E66D3BF42C5A)) {
      if(scripts\mp\utility\player::isreallyalive(player)) {
        _id_309C0A11484CC0DB[_id_309C0A11484CC0DB.size] = player;
        continue;
      }

      player thread _id_7FADAFCF58E33879();
    }
  }

  _id_975F82D85855F22A(_id_309C0A11484CC0DB);
  _id_5307834CD39B435C::_id_309C0A11484CC0DB(_id_309C0A11484CC0DB);
  wait 4;
  agentarray = getaiarrayinradius(_id_DB76C4BB596D090E.origin, 250);

  foreach(agent in agentarray) {
    if(isalive(agent) && istrue(agent._id_950C1AB89C9C4E2A)) {
      _id_8BDB743B1288E020 = (agent.origin[0], agent.origin[1], agent.origin[2] + 50);

      if(ispointinvolume(_id_8BDB743B1288E020, _id_DB76C4BB596D090E._id_0907E66D3BF42C5A)) {
        _id_6A8EC730B2BFA844::_id_FF7F720788558A70(agent, _id_309C0A11484CC0DB);
        agent _id_48814951E916AF89::_id_28B90EB2B591003F();
      }
    }
  }

  _id_5307834CD39B435C::_id_0EFD3004BCAA728F("bio_lab_extract_success", _id_309C0A11484CC0DB);

  if(isDefined(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_CE7F7E62DF1E0B51.waypointid))
    objective_delete(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_CE7F7E62DF1E0B51.waypointid);

  self.playerteam = undefined;
  self.car setscriptablepartstate("elevator_int_button", "usable");

  if(istrue(self._id_7E6513B2AE0D5C1D)) {
    if(!istrue(self.shutdown)) {
      self.state = "cooldown";
      return;
    }
  }

  _id_4B1E414172FEC3A8 setscriptablepartstate("model", "off", 0);
  wait 10;
  _id_5C118165D3E98A42::_id_1526944EF1762358();
}

_id_E86A0C8FB947DB55() {
  if(!istrue(self.shutdown)) {
    wait(level._id_E14D6A1883B24ACC);

    if(!istrue(self.shutdown)) {
      self.state = "waiting";
      return;
    }
  }

  self waittill("dmz_bio_lab_this_notify_would_never_come");
}

_id_1D78E37DA1598763() {
  if(!isDefined(level.elevators["elevator_group_exfil"])) {
    return;
  }
  _id_675ED89AF78F6A12 = _func_82D95BA721744147(level.elevators["elevator_group_exfil"]);

  foreach(_id_EEC55FABA21F3653 in _id_675ED89AF78F6A12) {
    if(_id_EEC55FABA21F3653.state == "waiting")
      _id_EEC55FABA21F3653 _id_94EE6837BFDF0FD5();
  }
}

_id_94EE6837BFDF0FD5() {
  foreach(_id_C8F6F1542970369C in self._id_E108D0ABDB42CFF6) {
    if(isDefined(_id_C8F6F1542970369C.waypointid))
      objective_delete(_id_C8F6F1542970369C.waypointid);

    _id_C8F6F1542970369C setscriptablepartstate("elevator_ext_button", "disabled");
  }

  _id_5C118165D3E98A42::_id_1526944EF1762358();
}

_id_D0D9FB20A37E8C57() {
  level endon("game_ended");
  _id_06BC507AFE7A93A3::main();
  exfilstruct = _id_7CB2174A6DF5941F::_id_F4AC452FD3842F7C();
  level thread _id_CFCCF39F94045018();
  level waittill("dmz_bio_lab_radiation_started");
  wait(getdvarint("dvar_1D2DE649AE8CDB80", 30));
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_exfil_ready", level.players);
  level._id_91AFF47B4A0A0F8A = _id_DB8D75A8476DAE37(exfilstruct.origin);
  level._id_2C0329996F12B023 = _id_7281ADDBA4A02693(exfilstruct.origin);
  level._id_91AFF47B4A0A0F8A._id_D9EDD68EAD0035CB = 1;
  _id_D7E56FDFB634FF41(level._id_91AFF47B4A0A0F8A, "heli_exfil_trigger", "usable", undefined, 0);
  _id_3707F44961816B2F::_id_0E1CA44858CD8EA1("radiation_start_spread", 1);
}

_id_7281ADDBA4A02693(origin) {
  ent = spawn("script_model", origin);
  ent setModel("dmz_exfil_site_xmodel");
  ent.angles = (0, 0, 0);
  ent setscriptablepartstate("dmz_exfil_smoke", "smoking", 0);
  ent setscriptablepartstate("dmz_exfil_site", "standby", 0);
  return ent;
}

_id_DB8D75A8476DAE37(origin) {
  _id_A5AE61DD930BF2A5 = spawnscriptable("iw9_biolabs_helicopter_exfil_trigger", origin, (0, 0, 0));
  _id_A5AE61DD930BF2A5 _id_086D19A1E5F2B563("ui_map_icon_extraction", 1, 50);
  return _id_A5AE61DD930BF2A5;
}

_id_D7E56FDFB634FF41(instance, part, state, _id_EEE718E33217DC9E, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(instance)) {
    return;
  }
  level._id_8E04DDD9E18F8350 = [];
  triggerradius = spawn("trigger_radius", instance.origin, 0, 300, 80);
  triggerradius thread _id_62492444B26AD7FE();
  _id_84D927B5FE4AFEF5 = spawn("script_model", instance.origin + (0, 0, 10));
  _id_84D927B5FE4AFEF5.angles = (90, 0, 0);
  _id_84D927B5FE4AFEF5 setModel("dom_flag_scriptable");

  foreach(player in level.players) {
    if(!isalive(player)) {
      continue;
    }
    player setplayermusicstate("dmz_exfil");
    instance disablescriptablepartplayeruse(part, player);
  }

  if(istrue(level._id_91AFF47B4A0A0F8A._id_D9EDD68EAD0035CB))
    level thread _id_64ACB6CE534155B7::utilflare_shootflare(instance.origin, "dmz_exfil", 1);

  thread _id_116A7DDC4DB636A4(instance.waypointid, triggerradius, _id_84D927B5FE4AFEF5);
  level notify("heli_exfil_on_use");
}

_id_116A7DDC4DB636A4(waypointid, triggerradius, _id_84D927B5FE4AFEF5) {
  level endon("game_ended");
  _id_7CB2174A6DF5941F::_id_F7866C62B996B1E6();
  level thread _id_3707F44961816B2F::_id_0E1CA44858CD8EA1("bio_lab_helo_exfil");
  level thread _id_7886AA410741B230();
  _id_84D927B5FE4AFEF5 setscriptablepartstate("flag", "idle_300");
  _id_7CB2174A6DF5941F::_id_373DA23F1E6C21AB(53);
  level thread _id_3707F44961816B2F::_id_0E1CA44858CD8EA1("bio_lab_helo_arriving");
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("br_gametype_extract_heli_arrived", level.players);
  waitframe();
  wait 10;
  level._id_2C0329996F12B023 setscriptablepartstate("dmz_exfil_smoke", "stop", 0);
  _id_84D927B5FE4AFEF5 setscriptablepartstate("flag", "off");
  objective_delete(waypointid);
  _id_309C0A11484CC0DB = [];

  foreach(player in level._id_8E04DDD9E18F8350) {
    if(scripts\mp\utility\player::isreallyalive(player))
      _id_309C0A11484CC0DB[_id_309C0A11484CC0DB.size] = player;
  }

  foreach(player in level.players) {
    if(!scripts\engine\utility::array_contains(level._id_8E04DDD9E18F8350, player))
      player thread _id_7FADAFCF58E33879();
  }

  if(_id_309C0A11484CC0DB.size > 0) {
    _id_975F82D85855F22A(_id_309C0A11484CC0DB);
    level _id_7CB2174A6DF5941F::_id_231E512D244410AD(_id_309C0A11484CC0DB);
    level thread _id_3707F44961816B2F::_id_0E1CA44858CD8EA1("bio_lab_helo_leaving");
    _id_5307834CD39B435C::_id_309C0A11484CC0DB(_id_309C0A11484CC0DB);
  }

  _id_7CB2174A6DF5941F::_id_131F077855A5C35B();
  _id_7CB2174A6DF5941F::cleanup();
  triggerradius delete();
  _id_84D927B5FE4AFEF5 delete();
}

_id_A894CD6A343792C6(_id_5188156BCF936801, _id_55F38A9ECA24F5B8) {
  _id_ABDA98D4F5975707 = spawnStruct();
  _id_ABDA98D4F5975707._id_6958D396E4AD3B95 = _id_5188156BCF936801;
  _id_ABDA98D4F5975707._id_55F38A9ECA24F5B8 = _id_55F38A9ECA24F5B8;
  _id_ABDA98D4F5975707._id_5ABB8DC2E7CD678E = level.players;
  _id_ABDA98D4F5975707._id_C92DA37DD03A2FF3 = level.players;
  _id_ABDA98D4F5975707.priority = 0;
  _id_ABDA98D4F5975707.id = "heli";
  _id_ABDA98D4F5975707 thread _id_701449195235BE31::_id_FF5183505692184F();
}

_id_62492444B26AD7FE() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", ent);

    if(!isPlayer(ent) || !isalive(ent) || scripts\engine\utility::array_contains(level._id_8E04DDD9E18F8350, ent)) {
      continue;
    }
    level._id_8E04DDD9E18F8350[level._id_8E04DDD9E18F8350.size] = ent;
    level notify("extract_heli_player_in_radius_changed", ent);
    childthread _id_E83D683A42D4D323(ent, 90000);
  }
}

_id_E83D683A42D4D323(player, _id_8FA87D2C8780E014) {
  while(isalive(player) && isDefined(self) && distance2dsquared(self.origin, player.origin) < _id_8FA87D2C8780E014)
    wait 0.2;

  level._id_8E04DDD9E18F8350 = scripts\engine\utility::array_remove(level._id_8E04DDD9E18F8350, player);
  level notify("extract_heli_player_in_radius_changed", player);
}

_id_CFCCF39F94045018() {
  level endon("game_ended");
  breaker = scripts\engine\utility::getStruct("top_window_breaker", "targetname");
  level waittill("heli_exfil_on_use");
  wait 1;

  if(istrue(level._id_91AFF47B4A0A0F8A._id_D9EDD68EAD0035CB))
    radiusdamage(breaker.origin, 100, 2000, 1000, undefined, undefined, undefined, 1, 0);
}

_id_7FADAFCF58E33879() {
  level endon("game_ended");

  if(isDefined(self)) {
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.1);
    self allowmovement(0);
    self allowfire(0);
    scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
    self sethidenameplate(0);
    self disableoffhandprimaryweapons(0);
    self disableoffhandsecondaryweapons(0);
    self disableweapons(0);
    self disableweaponswitch(0);
    self setcamerathirdperson(1);
    self allowcrouch(0);
    self allowmelee(0);
    self allowjump(0);
    self allowprone(0);
    self.ignoreme = 1;
    level thread _id_F330414BF82DDADC(self);
    _id_4480C6CE37B2BDF3::_id_0865B1A5A62C49D7();
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.1);
  }
}

_id_F330414BF82DDADC(player) {
  _id_1E4A61DB11011446::updateclientmatchdata(player);

  if(isDefined(player)) {
    player _id_6A5D3BF7A5B7064A::onexitdeathsdoor(0);

    if(scripts\engine\utility::array_contains(level.teamdata[player.team]["alivePlayers"], player))
      player scripts\mp\playerlogic::removefromalivecount(1);

    scripts\mp\utility\teams::validatealivecount("remove", player.team, player);
    player _id_6489FCDFE6FA2E36::spawnintermissionatplayer(player);
    player setclientomnvar("ui_br_squad_eliminated_active", 1);
    player setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
    player setclientomnvar("ui_round_end_reason", game["end_reason"]["br_eliminated"]);
    player setclientdvar("ui_opensummary", 1);
  }

  level thread _id_4480C6CE37B2BDF3::_id_DA0FA1AFAA8835CF();
}

_id_975F82D85855F22A(_id_309C0A11484CC0DB) {
  if(!isDefined(level._id_11D0C321045F514F))
    level._id_11D0C321045F514F = [];

  foreach(player in _id_309C0A11484CC0DB) {
    if(!isDefined(level._id_11D0C321045F514F[player.team])) {
      _id_5940F376A254619D = spawn("script_model", (-990, 1858, 441));
      _id_5940F376A254619D.angles = (0, player.angles[1], 0);
      _id_5940F376A254619D setModel("tag_origin");
      level._id_11D0C321045F514F[player.team] = _id_5940F376A254619D;
    }
  }
}

_id_7886AA410741B230() {
  level endon("game_ended");
  wait 3;
  _id_A894CD6A343792C6(60, 3);
}