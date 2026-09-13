/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_548072087c9fd504.gsc
***********************************************/

_id_F63556DC2AA67FDC(_id_0C5D283ED5F06437, clientnum, _id_ADCE5B7BC256C5DD) {
  if(!isDefined(level._id_07CA54722D668488) || level._id_07CA54722D668488 == 0)
    level thread _id_A30DC284F3733320();

  _id_2C51173BC42B79DA(_id_192E97BD8B292434(_id_0C5D283ED5F06437, clientnum, _id_ADCE5B7BC256C5DD));
  level notify("codcasterNotificationEnqueued");
}

_id_A30DC284F3733320() {
  level endon("game_ended");
  level._id_07CA54722D668488 = 1;

  for(;;) {
    if(!isDefined(game["codcasterEncodedNotificationQueue"]) || !isarray(game["codcasterEncodedNotificationQueue"]))
      game["codcasterEncodedNotificationQueue"] = [];

    while(game["codcasterEncodedNotificationQueue"].size > 0) {
      _id_4783F8205617B467(game["codcasterEncodedNotificationQueue"][0]);
      game["codcasterEncodedNotificationQueue"] = scripts\engine\utility::array_remove_index(game["codcasterEncodedNotificationQueue"], 0, 0);
      _id_AB401DBD01B23F5E(getdvarint("dvar_F56B9053764E5971", 3));
    }

    _id_4783F8205617B467(999);
    level waittill("codcasterNotificationEnqueued");
  }
}

_id_2C51173BC42B79DA(_id_09BE4E325A10DDCE) {
  game["codcasterEncodedNotificationQueue"] = scripts\engine\utility::array_add_safe(game["codcasterEncodedNotificationQueue"], _id_09BE4E325A10DDCE);
}

_id_4783F8205617B467(_id_09BE4E325A10DDCE) {
  if(isDefined(_id_09BE4E325A10DDCE))
    setomnvar("ui_codcaster_notification", _id_09BE4E325A10DDCE);
}

_id_20038A4ADA38BE4D(_id_D40DF2F2B26ADA41) {
  _id_4A3CC04781D25C6F = 0;
  _id_35A334482F930BE6 = 0;

  if(isDefined(self._id_4A3CC04781D25C6F))
    _id_4A3CC04781D25C6F = self._id_4A3CC04781D25C6F;

  if(isDefined(self.oobendtime))
    _id_35A334482F930BE6 = self.oobendtime;

  _id_D40DF2F2B26ADA41 setclientomnvar("ui_out_of_bounds_type", _id_4A3CC04781D25C6F);
  _id_D40DF2F2B26ADA41 setclientomnvar("ui_out_of_bounds_countdown", _id_35A334482F930BE6);
}

_id_192E97BD8B292434(_id_0C5D283ED5F06437, clientnum, _id_ADCE5B7BC256C5DD) {
  _id_09BE4E325A10DDCE = _id_0C5D283ED5F06437;

  if(isDefined(clientnum))
    _id_09BE4E325A10DDCE = _id_09BE4E325A10DDCE + (clientnum + 1) * 100 * 10;

  if(isDefined(_id_ADCE5B7BC256C5DD)) {
    if(isnumber(_id_ADCE5B7BC256C5DD))
      _id_09BE4E325A10DDCE = _id_09BE4E325A10DDCE + (_id_ADCE5B7BC256C5DD + 1) * 100 * 10 * 1000;
    else
      scripts\engine\utility::error("codcaster notification extra data supports numbers only. Invalid extra data: " + _id_ADCE5B7BC256C5DD);
  }

  return _id_09BE4E325A10DDCE;
}

_id_B6FD5F72A2973C10() {
  level endon("game_ended");

  for(;;) {
    _id_C9C655687BD338B8 = int(floor(scripts\mp\utility\game::_id_4C8FF40F12C474E9() / 1000));

    foreach(player in level.players) {
      if(player _meth_8420670EAFC8D391())
        player setclientomnvar("ui_total_game_time", _id_C9C655687BD338B8);
    }

    waitframe();
  }
}

_id_6FC852802774B304(_id_D72F1F113E6FE171, discardtime) {
  if(getdvarint("dvar_588C1DED10E6DF94") == 1 && level.gametype != "koth") {
    if(getdvarint("dvar_E69436F6610D6667") == 0)
      setDvar("dvar_E69436F6610D6667", 1);

    if(_id_D72F1F113E6FE171)
      _id_5FFBC7F1400D0FFC(discardtime);

    while(getdvarint("dvar_588C1DED10E6DF94") == 1)
      waitframe();

    setDvar("dvar_E69436F6610D6667", 0);
    return 5;
  }

  return -1;
}

_id_5FFBC7F1400D0FFC(discardtime) {
  if(!isDefined(level._id_D659494E95BD9496) || !level._id_D659494E95BD9496) {
    level._id_D659494E95BD9496 = 1;
    level._id_CC683B074A559F27 = discardtime;
    scripts\mp\gamelogic::pausetimer();
  }
}

_id_07A921EB7B2CBB5D() {
  if(isDefined(level._id_D659494E95BD9496) && level._id_D659494E95BD9496) {
    level._id_D659494E95BD9496 = 0;
    scripts\mp\gamelogic::resumetimer();
  }
}

_id_AB401DBD01B23F5E(_id_9AD425776B4DA797) {
  _id_9D7857DDFB81CB1E = _id_9AD425776B4DA797;

  while(_id_9D7857DDFB81CB1E > 0) {
    _id_9D7857DDFB81CB1E = _id_9D7857DDFB81CB1E - 1;
    waitframe();
  }
}

_id_7D42D3F8DD68280C(_id_E5D995C78098F9AB, team, clientnum, _id_ADCE5B7BC256C5DD) {
  _id_E5D995C78098F9AB = _id_E5D995C78098F9AB + 100;

  if(isDefined(team)) {
    if(team == "axis")
      _id_E5D995C78098F9AB = _id_E5D995C78098F9AB + 100;
    else if(team == "allies")
      _id_E5D995C78098F9AB = _id_E5D995C78098F9AB + 200;
  }

  _id_F63556DC2AA67FDC(_id_E5D995C78098F9AB, clientnum, _id_ADCE5B7BC256C5DD);
}

_id_305124A537C95967() {
  val = self.data[self.index];
  self.index = self.index + 1;
  return val;
}

_id_8C8838610394416A() {
  _id_E8183E36E63A01AF = spawnStruct();

  if(istrue(game["gameStateRestoreAlreadyUsed"]))
    _id_E8183E36E63A01AF.enabled = 0;
  else {
    _id_A9C983DC8D98CDA3 = _func_1AD3C760A0D54763();
    _id_D757F466DF8C71D3 = spawnStruct();
    _id_D757F466DF8C71D3.data = _id_A9C983DC8D98CDA3;
    _id_D757F466DF8C71D3.index = 0;
    _id_E8183E36E63A01AF.enabled = _id_D757F466DF8C71D3 _id_305124A537C95967();

    if(_id_E8183E36E63A01AF.enabled) {
      _id_E8183E36E63A01AF.gametime = _id_D757F466DF8C71D3 _id_305124A537C95967();
      _id_E8183E36E63A01AF._id_462CCACDBC27588F = _id_D757F466DF8C71D3 _id_305124A537C95967();
      _id_E8183E36E63A01AF._id_BBB396FC2F580332 = _id_D757F466DF8C71D3 _id_305124A537C95967();
      _id_E8183E36E63A01AF._id_8211A93C015E7700 = _id_D757F466DF8C71D3 _id_305124A537C95967();
      _id_E8183E36E63A01AF._id_E861F99F136BD454 = _id_D757F466DF8C71D3 _id_305124A537C95967();
      _id_E8183E36E63A01AF._id_6EB8962F9CA9F5C1 = _id_D757F466DF8C71D3 _id_305124A537C95967();
      _id_E8183E36E63A01AF._id_C56813D5326A9D1B = _id_D757F466DF8C71D3 _id_305124A537C95967();
      players = [];

      for(playerid = 0; playerid < 8; playerid++) {
        if(_id_D757F466DF8C71D3 _id_305124A537C95967() == 0) {
          break;
        }

        players[playerid] = spawnStruct();
        players[playerid].identifier = _id_D757F466DF8C71D3 _id_305124A537C95967();
        players[playerid].kills = _id_D757F466DF8C71D3 _id_305124A537C95967();
        players[playerid].deaths = _id_D757F466DF8C71D3 _id_305124A537C95967();
        players[playerid]._id_56F525DE50B57A43 = _id_D757F466DF8C71D3 _id_305124A537C95967();
        players[playerid]._id_E7CBF3263DB69417 = _id_D757F466DF8C71D3 _id_305124A537C95967();
        killstreaks = [];

        for(_id_EC78825BED0280DE = 0; _id_EC78825BED0280DE < 4; _id_EC78825BED0280DE++) {
          if(_id_D757F466DF8C71D3 _id_305124A537C95967() == 0) {
            break;
          }

          killstreaks[_id_EC78825BED0280DE] = spawnStruct();
          killstreaks[_id_EC78825BED0280DE]._id_D79CAAB4489A152E = _id_D757F466DF8C71D3 _id_305124A537C95967();
          killstreaks[_id_EC78825BED0280DE].earned = _id_D757F466DF8C71D3 _id_305124A537C95967();
          killstreaks[_id_EC78825BED0280DE].used = _id_D757F466DF8C71D3 _id_305124A537C95967();
        }

        players[playerid].killstreaks = killstreaks;
        players[playerid]._id_B5F07F928D5E50C1 = spawnStruct();
        players[playerid]._id_B5F07F928D5E50C1._id_D79CAAB4489A152E = _id_D757F466DF8C71D3 _id_305124A537C95967();
        players[playerid]._id_B5F07F928D5E50C1.progress = _id_D757F466DF8C71D3 _id_305124A537C95967();
      }

      _id_E8183E36E63A01AF.players = players;
    }
  }
}

_id_0216B35CA5806EC6(_id_A2B0850689543530, team) {
  clamp(_id_A2B0850689543530, 0, 1023);

  if(isDefined(team))
    return;
  else if(team == "allies") {
    foreach(player in level.players) {
      if(!isDefined(player) || player.team != "codcaster") {
        continue;
      }
      player setclientomnvar("ui_round_end_friendly_score", _id_A2B0850689543530);
    }
  } else if(team == "axis") {
    foreach(player in level.players) {
      if(!isDefined(player) || player.team != "codcaster") {
        continue;
      }
      player setclientomnvar("ui_round_end_enemy_score", _id_A2B0850689543530);
    }
  }
}

_id_D2F9149ADFA20419() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    waitframe();
    _id_364E9F0E6173004B = self _meth_A98CA97B806417A2();
    _id_B3F2A05DDB2ED262 = self getentitynumber();

    if(!isDefined(_id_364E9F0E6173004B) || !isDefined(_id_B3F2A05DDB2ED262) || self._id_58C7D0139E08B036 == _id_364E9F0E6173004B) {
      if(_id_B3F2A05DDB2ED262 == _id_364E9F0E6173004B)
        self setclientomnvar("ui_br_bink_overlay_state", 0);

      continue;
    }

    self._id_28493EC3B9D0BBEF = undefined;

    foreach(player in level.players) {
      _id_7676221CCA996819 = player getentitynumber();

      if(_id_7676221CCA996819 == _id_364E9F0E6173004B) {
        self._id_28493EC3B9D0BBEF = player;
        self._id_58C7D0139E08B036 = _id_364E9F0E6173004B;
        break;
      }
    }

    if(isDefined(self._id_28493EC3B9D0BBEF)) {
      _id_CFC7C272F572513F = self._id_28493EC3B9D0BBEF getclientomnvar("ui_br_bink_overlay_state");
      self setclientomnvar("ui_br_bink_overlay_state", _id_CFC7C272F572513F);
      continue;
    }

    self setclientomnvar("ui_br_bink_overlay_state", 0);
  }
}