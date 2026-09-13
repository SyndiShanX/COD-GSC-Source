/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\playerlogic.gsc
***********************************************/

init() {
  level scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::onversusdone);
}

timeuntilwavespawn(_id_B3B6DED69B87F1EA) {
  if(!self.hasspawned)
    return 0;

  _id_E5D97F5785A5AE1E = gettime() + _id_B3B6DED69B87F1EA * 1000;
  _id_6DB95413DE85FE15 = level.lastwave[self.pers["team"]];
  wavedelay = level.wavedelay[self.pers["team"]] * 1000;
  _id_D5FF6F4E1AC704B8 = (_id_E5D97F5785A5AE1E - _id_6DB95413DE85FE15) / wavedelay;
  _id_90B839CE7FA33C5F = ceil(_id_D5FF6F4E1AC704B8);
  _id_F2E1870FF43512D4 = _id_6DB95413DE85FE15 + _id_90B839CE7FA33C5F * wavedelay;

  if(isDefined(self.respawntimerstarttime)) {
    _id_4B0EB3DD662207F4 = (gettime() - self.respawntimerstarttime) / 1000.0;

    if(self.respawntimerstarttime < _id_6DB95413DE85FE15)
      return 0;
  }

  if(isDefined(self.wavespawnindex))
    _id_F2E1870FF43512D4 = _id_F2E1870FF43512D4 + 50 * self.wavespawnindex;

  return (_id_F2E1870FF43512D4 - gettime()) / 1000;
}

teamkilldelay() {
  _id_DC956E0241B601D9 = self.pers["teamkills"];

  if(!isDefined(_id_DC956E0241B601D9) || level.maxallowedteamkills < 0 || _id_DC956E0241B601D9 <= level.maxallowedteamkills)
    return 0;

  _id_C8FC15C09EBA8D20 = _id_DC956E0241B601D9 - level.maxallowedteamkills;
  return scripts\mp\tweakables::gettweakablevalue("team", "teamkillspawndelay") * _id_C8FC15C09EBA8D20;
}

timeuntilspawn(_id_E02F2CD6C285F5D1) {
  if(level.ingraceperiod && !self.hasspawned || level.gameended)
    return 0;

  respawndelay = 0;

  if(self.hasspawned) {
    result = self[[level.onrespawndelay]]();

    if(isDefined(result))
      respawndelay = result;
    else
      respawndelay = getdvarfloat(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_playerrespawndelay"));

    if(_id_E02F2CD6C285F5D1 && isDefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"])
      respawndelay = respawndelay + teamkilldelay();

    if(isDefined(self.suicidespawndelay))
      respawndelay = respawndelay + getdvarfloat(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_suicidespawndelay"));

    if(isDefined(self.respawntimerstarttime) && !isDefined(level.spawndelay)) {
      _id_4B0EB3DD662207F4 = (gettime() - self.respawntimerstarttime) / 1000.0;
      respawndelay = respawndelay - _id_4B0EB3DD662207F4;

      if(respawndelay < 0)
        respawndelay = 0;
    }
  }

  _id_3E1DEAE4CD178CFB = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_waverespawndelay")) > 0;

  if(_id_3E1DEAE4CD178CFB)
    respawndelay = timeuntilwavespawn(respawndelay);

  if(level.ingraceperiod && !self.hasspawned || level.gameended)
    respawndelay = 0;
  else if(getdvarint("dvar_4AC8D16CE8DD74FD", 0) == 1)
    respawndelay = 999.0;

  if(!isDefined(self._id_DB03AE1B2B480308))
    self._id_DB03AE1B2B480308 = respawndelay;

  return respawndelay;
}

isdevelopmentspawningofbotclient(_id_2C6CA80E296FED3A) {
  return 0;
}

mayspawn() {
  if(istrue(level.nukeinfo._id_F30E30BC8F212949))
    return 0;

  if(scripts\mp\utility\game::getgametypenumlives() || isDefined(level.disablespawning)) {
    if(isDefined(level.teamswithplayers) && level.teamswithplayers.size == 1)
      return 1;

    if(istrue(level.disablespawning)) {
      if(!isdevelopmentspawningofbotclient(self))
        return 0;
    }

    if(istrue(self.pers["teamKillPunish"]))
      return 0;

    if(self.pers["lives"] <= 0 && scripts\mp\utility\game::gamehasstarted())
      return 0;
    else if(scripts\mp\utility\game::gamehasstarted()) {
      if(level.ingraceperiod && !self.hasspawned)
        return 1;

      if(!level.ingraceperiod && !self.hasspawned && (isDefined(level.allowlatecomers) && !level.allowlatecomers)) {
        if(isDefined(self.siegelatecomer) && !self.siegelatecomer)
          return 1;

        if(isdevelopmentspawningofbotclient(self))
          return 1;

        return 0;
      }
    }
  }

  if(isDefined(level.disablespawningforplayerfunc) && [[level.disablespawningforplayerfunc]](self))
    return 0;

  return 1;
}

spawnclient(_id_9156B53BCF7CE573) {
  self endon("becameSpectator");

  if(isDefined(level.modespawnclient)) {
    self[[level.modespawnclient]](_id_9156B53BCF7CE573);
    return;
  }

  if(isDefined(self.pers["next_round_class"]) && !self.hasspawned)
    self.class = self.pers["next_round_class"];

  if(isDefined(self.waitingtoselectclass) && self.waitingtoselectclass)
    self waittill("okToSpawn");

  if(isDefined(self.addtoteam)) {
    scripts\mp\menus::addtoteam(self.addtoteam);
    self.addtoteam = undefined;
  }

  if(!mayspawn()) {
    waitframe();
    _id_8ACE8BF028CAA1D8 = self.origin;
    _id_9DBC893FB4BE54F2 = self.angles;
    self notify("attempted_spawn");

    if(istrue(self.pers["teamKillPunish"])) {
      self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);
      scripts\mp\utility\lower_message::setlowermessageomnvar("no_friendly_fire");

      if(!self.hasspawned && self.pers["teamkills"] <= level.maxallowedteamkills)
        self.pers["teamKillPunish"] = 0;
    } else if(scripts\mp\utility\game::isroundbased() && game["finalRound"] == 0 || scripts\mp\utility\game::getgametypenumlives() != 0 && game["finalRound"] == 0 || istrue(level.disablespawning)) {
      _id_EED812FD1B7F551C = undefined;

      if(scripts\mp\utility\game::getgametype() != "arena" && isDefined(self.tagavailable) && self.tagavailable)
        scripts\mp\utility\lower_message::setlowermessageomnvar("spawn_tag_wait");
      else if(istrue(self.revivetriggerblockedinremote) && level.teamdata[self.team]["aliveCount"] > 0)
        scripts\mp\utility\lower_message::setlowermessageomnvar("spawn_revive_wait_notimer");
      else if(istrue(self.revivetriggeravailable)) {
        if(isDefined(self.timeuntilbleedout)) {
          if(isDefined(self.rallypoint))
            scripts\mp\utility\lower_message::setlowermessageomnvar("rally_point", int(gettime() + self.timeuntilbleedout * 1000));
          else if(!istrue(self.eliminated))
            scripts\mp\utility\lower_message::setlowermessageomnvar("spawn_revive_wait_bleedout", int(gettime() + self.timeuntilbleedout * 1000));
        } else if(level.teamdata[self.team]["aliveCount"] > 0)
          scripts\mp\utility\lower_message::setlowermessageomnvar("spawn_revive_wait_notimer");
        else
          scripts\mp\utility\lower_message::setlowermessageomnvar("spawn_next_round");
      } else if(scripts\mp\utility\game::getgametype() == "siege") {
        scripts\mp\utility\lower_message::setlowermessageomnvar("spawn_point_capture_wait");
        _id_EED812FD1B7F551C = 10;
      } else if(istrue(level.exfilstarted))
        scripts\mp\utility\lower_message::setlowermessageomnvar("exfil_eliminated");
      else if(scripts\mp\utility\game::isroundbased())
        scripts\mp\utility\lower_message::setlowermessageomnvar("spawn_next_round");
      else if(scripts\mp\utility\game::getgametype() == "oic" && scripts\mp\utility\game::matchmakinggame()) {
        scripts\mp\utility\lower_message::setlowermessageomnvar("player_eliminated_oic");
        _id_EED812FD1B7F551C = 30;
      } else {
        scripts\mp\utility\lower_message::setlowermessageomnvar("player_eliminated");
        _id_EED812FD1B7F551C = 10;
      }

      if(!isDefined(self.revivetriggeravailable))
        thread removespawnmessageshortly(scripts\engine\utility::ter_op(isDefined(_id_EED812FD1B7F551C), _id_EED812FD1B7F551C, 6.0));
    }

    if(self.sessionstate != "spectator")
      _id_8ACE8BF028CAA1D8 = _id_8ACE8BF028CAA1D8 + (0, 0, 60);

    if(scripts\mp\utility\player::isusingremote()) {
      self.spawningafterremotedeath = 1;
      self.deathposition = self.origin;
      self waittill("stopped_using_remote");
    }

    if(!istrue(level.nukeinfo._id_F30E30BC8F212949)) {
      if(!scripts\mp\flags::gameflag("prematch_done"))
        logstring("IWH-315293: DOLPHIN: can't spawn but prematch isn't over: " + self.name);

      thread spawnspectator(_id_8ACE8BF028CAA1D8, _id_9DBC893FB4BE54F2);
    }

    return;
  }

  if(self.waitingtospawn) {
    return;
  }
  self.waitingtospawn = 1;
  waitandspawnclient(_id_9156B53BCF7CE573);

  if(isDefined(self))
    self.waitingtospawn = 0;
}

waittillcanspawnclient(_id_9156B53BCF7CE573) {
  self endon("started_spawnPlayer");

  for(;;) {
    waitframe();

    if(self.team == "spectator" || self.team == "codcaster") {
      return;
    }
    if(isDefined(self) && (self.sessionstate == "spectator" || !scripts\mp\utility\player::isreallyalive(self))) {
      if(istrue(_id_9156B53BCF7CE573))
        self.pers["teamKillPunish"] = 0;

      self.pers["lives"] = 1;
      thread spawnclient(_id_9156B53BCF7CE573);
      continue;
    }

    return;
  }
}

waitandspawnclient(_id_9156B53BCF7CE573) {
  self endon("disconnect");
  self endon("end_respawn");
  level endon("game_ended");
  self notify("attempted_spawn");

  if(isDefined(level.prewaitandspawnclient))
    [[level.prewaitandspawnclient]](_id_9156B53BCF7CE573);

  waitforremoteend();
  spawnedasspectator = 0;

  if(istrue(self.pers["teamKillPunish"])) {
    teamkilldelay = teamkilldelay();

    if(teamkilldelay > 0) {
      scripts\mp\utility\lower_message::setlowermessageomnvar("no_friendly_fire_timer", int(gettime() + teamkilldelay * 1000));
      thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
      spawnedasspectator = 1;
      wait(teamkilldelay);
      scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
      self.respawntimerstarttime = gettime();
    }

    self.pers["teamKillPunish"] = 0;
  } else if(teamkilldelay())
    self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);

  if(!isDefined(self.wavespawnindex) && isDefined(level.waveplayerspawnindex[self.team])) {
    self.wavespawnindex = level.waveplayerspawnindex[self.team];
    level.waveplayerspawnindex[self.team]++;
  }

  if(isDefined(self.setspawnpoint) && !tivalidationcheck())
    scripts\mp\equipment\tac_insert::spawnpoint_clearspawnpoint(1);

  timeuntilspawn = timeuntilspawn(0);
  _id_D322C5816F6135B5 = 0.0;

  if(!istrue(level.disablespawncamera))
    _id_D322C5816F6135B5 = scripts\engine\utility::ter_op(istrue(level.snaptospawncamera), 1.25, 2.0);

  if(istrue(level.usespawnselection))
    _id_D322C5816F6135B5 = 0.5;

  if(level.ingraceperiod && !self.hasspawned || level.gameended) {
    _id_D322C5816F6135B5 = 0;
    timeuntilspawn = 0;
  }

  _id_D86B42B0FA413AA2 = 0;

  if(scripts\mp\utility\game::getgametype() == "hq" && isDefined(level.zone) && level.zone.ownerteam == self.team)
    _id_D86B42B0FA413AA2 = 1;

  if(!istrue(self.skippedkillcam) && isDefined(self.killcamwatchtime) && !_id_D86B42B0FA413AA2) {
    if(isDefined(self._id_DB03AE1B2B480308))
      timeuntilspawn = max(self._id_DB03AE1B2B480308 - self.killcamwatchtime, 0);
    else
      timeuntilspawn = max(timeuntilspawn - self.killcamwatchtime, 0);

    self.killcamwatchtime = undefined;
  }

  timeuntilspawn = max(timeuntilspawn, _id_D322C5816F6135B5);

  if(scripts\mp\arbitrary_up::isinarbitraryup()) {
    angles = self getworldupreferenceangles();
    up = anglestoup(angles);
    _id_086E75B5335F09F6 = up * 60;
  } else
    _id_086E75B5335F09F6 = (0, 0, 60);

  _id_FA3CDBD484FA39C3 = istrue(scripts\mp\flags::gameflag("prematch_done"));
  _id_6109158034DA3FE9 = scripts\mp\flags::gameflag("infil_will_run") && !istrue(scripts\mp\flags::gameflag("infil_started"));

  if(istrue(level._id_A6954A050D77D75C)) {
    if(!_id_6109158034DA3FE9 && !_id_FA3CDBD484FA39C3) {
      self clearpredictedstreampos();
      thread _id_AE6FB03B95FCA93E(getdvarint("dvar_41C2228192C27E59", 1));
    }
  } else if((scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict") && !_id_6109158034DA3FE9 && !_id_FA3CDBD484FA39C3) {
    _id_C2106FA614419D22 = [[level._id_E637D49948A038D3]](self.team);
    _id_11F3B4465C8B637B = _id_2CEDCC356F1B9FC8::playerstreamhintlocation(_id_C2106FA614419D22.startorigin);
    thread setuipregamefadeup();
    _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
    _id_5940F376A254619D = spawn("script_model", _id_C2106FA614419D22.startorigin);
    _id_5940F376A254619D setModel("tag_origin");
    _id_5940F376A254619D.angles = _id_C2106FA614419D22.startangles;
    self cameralinkTo(_id_5940F376A254619D, "tag_origin");
    _id_5940F376A254619D moveTo(_id_C2106FA614419D22.endorigin, 18);
    _id_5940F376A254619D rotateTo(_id_C2106FA614419D22.endangles, 18);
    scripts\mp\flags::gameflagwait("prematch_done");
    _id_FA3CDBD484FA39C3 = 1;
    self cameraunlink();
  }

  if(scripts\mp\spawncamera::_id_581A8FC6F76D525D() && timeuntilspawn > 0) {
    if(getdvarint("dvar_F011125B6F888598", 1) == 1)
      thread scripts\mp\spawncamera::startspawncamera(0, 0, 0.5);
    else
      thread scripts\mp\spawncamera::startspawncamera();
  }

  if(istrue(level.usespawnselection))
    scripts\mp\spawnselection::waitforspawnselection(timeuntilspawn, !istrue(_id_FA3CDBD484FA39C3));
  else {
    if(isDefined(self.setspawnpoint)) {
      _id_D82413D0D82E4E34 = scripts\mp\equipment\tac_insert::_id_617D41FFB1F25AA5();
      spawnedasspectator = 1;

      if(isDefined(self._id_15DB4B9B5E7DEBEC)) {
        timeuntilspawn = max(_id_D322C5816F6135B5, timeuntilspawn - _id_D82413D0D82E4E34);
        self setspectatedefaults(self.origin + _id_086E75B5335F09F6, self.angles);
        scripts\mp\spectating::setspectatepermissions();
      }
    }

    if(timeuntilspawn > 0) {
      _id_BCF42B30BA361835 = "waiting_to_spawn";

      if(scripts\mp\utility\game::getgametype() == "hq") {
        if(isDefined(level.zone)) {
          if(level.zone.ownerteam == self.team) {
            scripts\mp\utility\dialog::leaderdialogonplayer("hp_dead");
            _id_BCF42B30BA361835 = "waiting_for_hq";

            if(isDefined(self.suicidespawndelay)) {
              timeuntilspawn = timeuntilspawn - getdvarfloat("scr_hq_suicidespawndelay");
              timeuntilspawn = max(0, timeuntilspawn);
            }
          } else if(isDefined(self.suicidespawndelay) && getdvarfloat("scr_hq_suicidespawndelay") > 0 && level.zone.ownerteam == "neutral") {
            _id_BCF42B30BA361835 = "waiting_suicide_delay";
            self.suicidespawndelay = undefined;
          }
        }
      } else if(isDefined(self.suicidespawndelay) && getdvarfloat(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_suicidespawndelay")) > 0) {
        _id_BCF42B30BA361835 = "waiting_suicide_delay";
        self.suicidespawndelay = undefined;
      }

      scripts\mp\utility\lower_message::setlowermessageomnvar(_id_BCF42B30BA361835, int(gettime() + timeuntilspawn * 1000));

      if(getdvarint("dvar_F011125B6F888598", 1) == 1 && istrue(self.inspawncamera) && scripts\mp\utility\game::getgametype() == "gwtdm") {} else {
        if(!spawnedasspectator)
          thread respawn_asspectator(self.origin + _id_086E75B5335F09F6, self.angles);

        spawnedasspectator = 1;
      }

      scripts\engine\utility::waittill_any_timeout_no_endon_death_1(timeuntilspawn, "force_spawn");

      if(!istrue(self.waitingtoselectclass))
        self notify("stop_wait_safe_spawn_button");
    }
  }

  if(!isbot(self) && needsbuttontorespawn()) {
    if(_id_98811C91E3781166()) {
      if(self.hasspawned)
        _id_5ECF910EA9DFDB41();
    } else {
      if(!istrue(self.waitingtoselectclass))
        scripts\mp\utility\lower_message::setlowermessageomnvar("press_to_spawn");

      if(!spawnedasspectator)
        thread respawn_asspectator(self.origin + _id_086E75B5335F09F6, self.angles);

      spawnedasspectator = 1;
      waitrespawnbutton();
    }
  }

  if(!istrue(level.disablespawncamera) || scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict" || scripts\mp\utility\game::getgametype() == "risk")
    thread scripts\mp\spawncamera::endspawncamera();

  waitclassselected();

  if(isbot(self)) {
    if(!scripts\mp\bots\bots::bot_is_ready_to_spawn())
      self waittill("bot_ready_to_spawn");
  }

  while(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7() && !istrue(self _meth_F6C07D6EA7D83A5A()))
    waitframe();

  self.waitingtospawn = 0;
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  self.wavespawnindex = undefined;
  thread spawnplayer(undefined, _id_9156B53BCF7CE573);
}

_id_AE6FB03B95FCA93E(mintime) {
  self endon("death_or_disconnect");
  self waittill("spawned_player");
  self setclientomnvar("ui_world_fade", 1.0);
  starttime = gettime();
  _id_2CEDCC356F1B9FC8::playerstreamhintlocation(self getEye());
  self waittill("playerPrestreamComplete");
  self clearpredictedstreampos();

  if(isDefined(mintime)) {
    _id_3B5803E733581858 = (gettime() - starttime) / 1000;

    if(_id_3B5803E733581858 < mintime)
      wait(mintime - _id_3B5803E733581858);
  }

  _id_DFAB0807D83A77FE = 0.5;

  if(isDefined(_id_DFAB0807D83A77FE) && _id_DFAB0807D83A77FE > 0) {
    _id_C8D49BBA66D8DB34 = 1.0;
    _id_67C7CB82CFC5EE69 = _id_DFAB0807D83A77FE / level.framedurationseconds;
    _id_11B42FD8A12916AD = 1.0 / _id_67C7CB82CFC5EE69;
    _id_4A1830F604C82B9F = 0;

    while(_id_4A1830F604C82B9F < _id_67C7CB82CFC5EE69) {
      _id_4A1830F604C82B9F++;
      _id_C8D49BBA66D8DB34 = _id_C8D49BBA66D8DB34 - _id_11B42FD8A12916AD;
      _id_C8D49BBA66D8DB34 = clamp(_id_C8D49BBA66D8DB34, 0.0, 1.0);
      self setclientomnvar("ui_world_fade", _id_C8D49BBA66D8DB34);
      waitframe();
    }
  }

  self setclientomnvar("ui_world_fade", 0.0);
}

waitforremoteend() {
  level endon("game_ended");
  self endon("disconnect");

  if(scripts\mp\utility\player::isusingremote()) {
    self.spawningafterremotedeath = 1;
    self.deathposition = self.origin;
    self waittill("stopped_using_remote");

    if(istrue(level.nukeinfo._id_F30E30BC8F212949))
      return;
  }
}

shouldwaitforsquadspawn() {
  return 0;
}

queueclientforsquadspawn() {
  while(!level.squaddata[self.team][self._id_0FF97225579DE16A].isfull && !level.squaddata[self.team][self._id_0FF97225579DE16A].isstale)
    waitframe();
}

waitclassselected() {
  while(istrue(self.waitingtoselectclass))
    waitframe();
}

needsbuttontorespawn() {
  if(scripts\mp\flags::gameflag("infil_will_run") && !scripts\mp\flags::gameflag("prematch_done"))
    return 0;

  if(_id_98811C91E3781166())
    return 1;

  if(scripts\mp\tweakables::gettweakablevalue("player", "forcerespawn") != 0)
    return 0;

  if(!self.hasspawned)
    return 0;

  _id_3E1DEAE4CD178CFB = getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_waverespawndelay")) > 0;

  if(_id_3E1DEAE4CD178CFB)
    return 0;

  if(self.wantsafespawn)
    return 0;

  return 1;
}

waitrespawnbutton() {
  self endon("disconnect");
  self endon("end_respawn");

  for(;;) {
    if(self useButtonPressed()) {
      break;
    }

    wait 0.05;
  }
}

_id_98811C91E3781166() {
  if(scripts\cp_mp\utility\game_utility::_id_9CDAADFDDEDA4D7A() && !isbot(self) && !self isplayerheadless())
    return 1;

  return 0;
}

_id_5ECF910EA9DFDB41() {
  self openmenu("Shop");
  _id_4384ABBF498DF6A7::armorykioskused(0, undefined, undefined, self);
  _id_E02011BAF71D84AC();
}

_id_E02011BAF71D84AC() {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("buy_menu_close");
  self endon("game_ended");
  timeout = 10;

  for(;;) {
    wait(scripts\engine\utility::ter_op(scripts\mp\utility\game::matchmakinggame(), 10, 20));
    break;
  }
}

removespawnmessageshortly(delay) {
  self endon("disconnect");
  level endon("game_ended");
  waittillframeend;
  self endon("end_respawn");
  wait(delay);
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
}

tivalidationcheck() {
  if(!isDefined(self.setspawnpoint))
    return 0;

  if(isDefined(level.canspawnontacinsert) && ![[level.canspawnontacinsert]](self))
    return 0;

  carepackages = getEntArray("care_package", "targetname");

  foreach(_id_782866E364DCD2EF in carepackages) {
    if(distancesquared(_id_782866E364DCD2EF.origin, self.setspawnpoint.playerspawnpos) > 4096) {
      continue;
    }
    if(isDefined(_id_782866E364DCD2EF.owner))
      scripts\mp\hud_message::showsplash("destroyed_insertion", undefined, _id_782866E364DCD2EF.owner);

    scripts\mp\equipment\tac_insert::spawnpoint_clearspawnpoint();
    return 0;
  }

  _id_B65B7AEAB526E1AC = (30, 30, 80);
  _id_80745CF3E2877DF5 = self.setspawnpoint.playerspawnpos - _id_B65B7AEAB526E1AC;
  _id_809746F3E2AD954B = self.setspawnpoint.playerspawnpos + _id_B65B7AEAB526E1AC;
  contents = physics_createcontents(["physicscontents_vehicle"]);
  ignorelist = [];
  vehicles = physics_aabbbroadphasequery(_id_80745CF3E2877DF5, _id_809746F3E2AD954B, contents, ignorelist);

  if(isDefined(vehicles) && vehicles.size > 0) {
    _id_D41B7D5F40F6A360 = 1;

    foreach(vehicle in vehicles) {
      _id_EE54CB9980390850 = vehicle.code_classname == "scriptable" || vehicle.code_classname == "worldspawn";

      if(!_id_EE54CB9980390850) {
        _id_D41B7D5F40F6A360 = 0;
        break;
      }
    }

    if(!_id_D41B7D5F40F6A360)
      return 0;
  }

  startpos = self.setspawnpoint.playerspawnpos + (0, 0, 60);
  endpos = self.setspawnpoint.playerspawnpos + (0, 0, 1);
  ignoreents = [];
  ignoreents[0] = self;
  ignoreents[1] = self.setspawnpoint;
  contentoverride = physics_createcontents(["physicscontents_playerclip", "physicscontents_characterproxy", "physicscontents_glass"]);

  if(!scripts\engine\trace::ray_trace_passed(startpos, endpos, ignoreents, contentoverride))
    return 0;

  _id_4224C4FE61A423F0 = self.setspawnpoint.playerspawnpos + (0, 0, 1);
  _id_937C2383212D492F = playerphysicstrace(_id_4224C4FE61A423F0, self.setspawnpoint.playerspawnpos + (0, 0, -16));

  if(_id_4224C4FE61A423F0[2] == _id_937C2383212D492F[2])
    return 0;

  return 1;
}

revivespawnvalidationcheck() {
  if(!isDefined(self.forcespawnorigin))
    return 0;

  _id_E5F115AEE2BF7DE7 = spawnStruct();
  _id_E5F115AEE2BF7DE7.spawnposition = self.forcespawnorigin;
  _id_E5F115AEE2BF7DE7.isvalidpos = 1;
  ignoreents = [];
  ignoreents[0] = self;
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 0, 0, 1, 1);

  if(!scripts\engine\trace::ray_trace_passed(self.forcespawnorigin + (0, 0, 60), self.forcespawnorigin, ignoreents, contentoverride)) {
    _id_E5F115AEE2BF7DE7.isvalidpos = 0;
    return _id_E5F115AEE2BF7DE7;
  }

  forward = anglesToForward(self.angles);
  _id_3777ECE6A73EADA5 = vectorNormalize(forward) * 5;

  if(!scripts\engine\trace::ray_trace_passed(self.forcespawnorigin + _id_3777ECE6A73EADA5, self.forcespawnorigin + _id_3777ECE6A73EADA5 - (0, 0, 16), ignoreents, contentoverride)) {
    _id_E5F115AEE2BF7DE7.isvalidpos = 0;
    return _id_E5F115AEE2BF7DE7;
  }

  _id_4224C4FE61A423F0 = self.forcespawnorigin + (0, 0, 1);
  _id_937C2383212D492F = playerphysicstrace(_id_4224C4FE61A423F0, self.forcespawnorigin + (0, 0, -16));

  if(_id_4224C4FE61A423F0[2] == _id_937C2383212D492F[2]) {
    _id_E5F115AEE2BF7DE7.isvalidpos = 0;
    return _id_E5F115AEE2BF7DE7;
  } else {
    _id_E5F115AEE2BF7DE7.spawnposition = _id_937C2383212D492F;
    _id_E5F115AEE2BF7DE7.isvalidpos = 0;
  }

  if(isDefined(self.faux_spawn_stance) && self.faux_spawn_stance == "prone")
    self.faux_spawn_stance = "prone";
  else
    self.faux_spawn_stance = "crouch";

  _id_E5F115AEE2BF7DE7.isvalidpos = 1;
  return _id_E5F115AEE2BF7DE7;
}

spawningclientthisframereset() {
  self notify("spawningClientThisFrameReset");
  self endon("spawningClientThisFrameReset");
  waitframe();
  level.numplayerswaitingtospawn--;
}

getplayerassets(classstruct) {
  _id_D35B753EB7E96014 = spawnStruct();

  if(isDefined(classstruct.loadoutprimaryfullname) && classstruct.loadoutprimaryfullname != "none")
    _id_D35B753EB7E96014.primaryweapon = classstruct.loadoutprimaryfullname;

  if(isDefined(classstruct.loadoutsecondaryfullname) && classstruct.loadoutsecondaryfullname != "none")
    _id_D35B753EB7E96014.secondaryweapon = classstruct.loadoutsecondaryfullname;

  _id_56E7CF38A4910BA2 = scripts\mp\teams::getcustomization();

  if(isDefined(_id_56E7CF38A4910BA2["body"]))
    _id_D35B753EB7E96014.body = _id_56E7CF38A4910BA2["body"];

  if(isDefined(_id_56E7CF38A4910BA2["head"]))
    _id_D35B753EB7E96014.head = _id_56E7CF38A4910BA2["head"];

  return _id_D35B753EB7E96014;
}

loadplayerassets(_id_424DDD9840DA9529, _id_AE2C4ED794036495, _id_8C3977C9C8DC729B) {
  _id_E2705839F9350B00 = [];

  foreach(_id_D35B753EB7E96014 in _id_424DDD9840DA9529) {
    if(isDefined(_id_D35B753EB7E96014.primaryweapon))
      _id_E2705839F9350B00[_id_E2705839F9350B00.size] = _id_D35B753EB7E96014.primaryweapon;

    if(isDefined(_id_D35B753EB7E96014.secondaryweapon))
      _id_E2705839F9350B00[_id_E2705839F9350B00.size] = _id_D35B753EB7E96014.secondaryweapon;

    if(!istrue(_id_8C3977C9C8DC729B))
      self loadcustomization(_id_D35B753EB7E96014.body, _id_D35B753EB7E96014.head, _id_AE2C4ED794036495);
  }

  if(_id_E2705839F9350B00.size > 0)
    self loadweaponsforplayer(_id_E2705839F9350B00, _id_AE2C4ED794036495);
}

allplayershaveassetsloaded(_id_D35B753EB7E96014) {
  _id_E2705839F9350B00 = [];

  if(isDefined(_id_D35B753EB7E96014.primaryweapon))
    _id_E2705839F9350B00[_id_E2705839F9350B00.size] = _id_D35B753EB7E96014.primaryweapon;

  if(isDefined(_id_D35B753EB7E96014.secondaryweapon))
    _id_E2705839F9350B00[_id_E2705839F9350B00.size] = _id_D35B753EB7E96014.secondaryweapon;

  if(!self hasloadedviewweapons(_id_E2705839F9350B00))
    return 0;

  if(!self hasloadedcustomizationviewmodels(_id_D35B753EB7E96014.body))
    return 0;

  return 1;
}

getspawnpoint() {
  spawnpoint = undefined;
  spawnorigin = undefined;
  spawnangles = undefined;
  self.ti_spawn = 0;

  if(getdvarint("dvar_03F36284B49B3D7A", 0) != 0) {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      _id_EBE89F27EDDABE61 = getspawnarray("mp_dm_spawn_start");
    else
      _id_EBE89F27EDDABE61 = getspawnarray("mp_tdm_spawn_allies_start");

    spawnpoint = _id_EBE89F27EDDABE61[0];
    spawnorigin = spawnpoint.origin;
    spawnangles = spawnpoint.angles;
  } else if(isDefined(self.forcespawnorigin)) {
    _id_E5F115AEE2BF7DE7 = revivespawnvalidationcheck();

    if(!_id_E5F115AEE2BF7DE7.isvalidpos && isDefined(self.prevrevivepos) && !isDefined(self.rallypoint))
      spawnorigin = self.prevrevivepos;
    else {
      spawnorigin = self.forcespawnorigin;
      self.forcespawnorigin = undefined;
    }

    if(isDefined(self.forcespawnangles)) {
      spawnangles = self.forcespawnangles;
      self.forcespawnangles = undefined;
    } else
      spawnangles = (0, randomfloatrange(0, 360), 0);

    if(isDefined(self.reviver)) {
      if(istrue(self._id_C4C8B91E0B16AA5E)) {
        vehicles = vehicle_getarrayinradius(spawnorigin, 500);

        foreach(vehicle in vehicles) {
          if(vehicle scripts\cp_mp\vehicles\vehicle_occupancy::_id_4E4CF75E0F7E4184(spawnorigin)) {
            [_id_66FA427056010163, _id_2B16A165170D3506] = scripts\cp_mp\vehicles\vehicle_occupancy::_id_9D86FD9A89CD2702(self, vehicle, spawnorigin);
            spawnorigin = _id_66FA427056010163;
            break;
          }
        }
      } else if(positionwouldtelefrag(spawnorigin) || !_id_E5F115AEE2BF7DE7.isvalidpos) {
        spawnpoint = scripts\mp\spawnscoring::findteammatebuddyspawn(self.reviver);
        self.reviver = undefined;

        if(isDefined(spawnpoint)) {
          spawnorigin = spawnpoint.origin;
          spawnangles = spawnpoint.angles;
        }
      } else
        spawnorigin = _id_E5F115AEE2BF7DE7.spawnposition;
    }
  } else if(istrue(level.usespawnselection) && self[[level._id_D280C5FDB0036183]]() && istrue(scripts\mp\flags::gameflag("prematch_done"))) {
    spawnpoint = scripts\mp\spawnselection::getspawnpoint();
    spawnorigin = spawnpoint.origin;
    spawnangles = spawnpoint.angles;
  } else {
    spawnpoint = self[[level.getspawnpoint]]();
    spawnorigin = spawnpoint.origin;
    spawnangles = spawnpoint.angles;
  }

  if(isDefined(self.setspawnpoint)) {
    if(!istrue(level.usespawnselection))
      self.ti_spawn = 1;

    if(istrue(self.ti_spawn)) {
      spawnpoint = self.setspawnpoint;

      if(!istrue(self.setspawnpoint.notti)) {
        if(istrue(level.isgroundwarinfected) && istrue(level._id_624C83B532EFCE04) && level.mapname != "mp_aniyah") {
          self.movedtoinfected = undefined;
          _id_677FFA8B71C88AA7 = scripts\engine\utility::ter_op(istrue(level.alwaysdoskyspawnontacinsert), 1, istrue(self.setspawnpoint.issuper));

          if(_id_677FFA8B71C88AA7) {
            self.setspawnpoint.playerspawnpos = self.setspawnpoint.playerspawnpos + (0, 0, level.infectparachuteheightoffset);
            _id_297D86376147F0FD = getdvarint("dvar_492618A75E1C0035", 0);

            if(_id_297D86376147F0FD > 0) {
              if(self.setspawnpoint.playerspawnpos[2] > _id_297D86376147F0FD)
                self.setspawnpoint.playerspawnpos = (self.setspawnpoint.playerspawnpos[0], self.setspawnpoint.playerspawnpos[1], _id_297D86376147F0FD);
            }

            self.isparachutespawning = 1;
          }
        }

        self.ti_spawn = 1;
        self playlocalsound("tactical_spawn");

        if(level.teambased) {
          foreach(_id_F90358454413407F in level.teamnamelist) {
            if(_id_F90358454413407F != self.team)
              self playsoundtoteam("tactical_spawn", _id_F90358454413407F);
          }
        } else
          self playSound("tactical_spawn");
      }

      foreach(tank in level.ugvs) {
        if(distancesquared(tank.origin, spawnpoint.playerspawnpos) < 1024)
          tank notify("damage", 5000, tank.owner, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, makeweapon("killstreak_jammer_mp"));
      }

      if(scripts\mp\equipment\tac_insert::tacinsert_isvalidspawnposition(self.setspawnpoint.playerspawnpos, 1)) {
        spawnorigin = self.setspawnpoint.playerspawnpos;
        spawnangles = self.setspawnpoint.playerspawnangles;
      } else {
        _id_57F38E8D47549AF9 = getnodesinradiussorted(self.setspawnpoint.playerspawnpos, 512, 0, 64, "path");

        foreach(node in _id_57F38E8D47549AF9) {
          position = node.origin + (0, 0, 3);

          if(canspawn(position, self)) {
            spawnorigin = position;
            spawnangles = node.angles;
            break;
          }
        }
      }

      scripts\mp\equipment\tac_insert::spawnpoint_clearspawnpoint(0, 1);
      spawnpoint = undefined;
    }
  }

  spawndata = spawnStruct();
  spawndata.spawnpoint = spawnpoint;
  spawndata.spawnorigin = spawnorigin;

  if(!isDefined(spawnangles))
    spawnangles = (0, 0, 0);

  spawndata.spawnangles = (0, spawnangles[1], 0);
  return spawndata;
}

spawnplayer(_id_13FE2B86C5E85A64, _id_9156B53BCF7CE573) {
  self endon("disconnect");
  self endon("joined_spectators");
  self notify("spawned");
  self notify("end_respawn");
  self notify("started_spawnPlayer");

  if(self.team == "codcaster") {
    return;
  }
  if(!isDefined(_id_13FE2B86C5E85A64))
    _id_13FE2B86C5E85A64 = 0;

  if(!isDefined(_id_9156B53BCF7CE573))
    _id_9156B53BCF7CE573 = 0;

  if(scripts\mp\utility\game::teamhasinfil(self.team) && !scripts\mp\flags::gameflag("infil_started") && !isDefined(level.bypassclasschoicefunc)) {
    if(getdvarint("dvar_206A763969420CE0", 0) == 1 && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() != "dmz" && scripts\mp\utility\game::getsubgametype() != "exgm" && scripts\mp\utility\game::getsubgametype() != "plunder" && scripts\mp\utility\game::getsubgametype() != "risk" && scripts\mp\utility\game::getsubgametype() != "sandbox" && scripts\mp\utility\game::getsubgametype() != "rumble_mgl") {
      _id_F6F520C104BF3BDB = scripts\mp\utility\game::teamhasinfil(self.team);
      started = scripts\mp\flags::gameflag("infil_started");
      _id_B546524B3FD3D9C9 = isDefined(level.bypassclasschoicefunc);
      scripts\mp\utility\script::demoforcesre("spawnPlayer()" + self.name + " ui_options_menu = 2, hasInfil = " + _id_F6F520C104BF3BDB + " infil_started = " + started + "bypassClassChoiceFunc = " + _id_B546524B3FD3D9C9);
    }

    if(!istrue(self._id_10844DDCB34694EE))
      self setclientomnvar("ui_options_menu", 2);
  } else if((!isDefined(game["state"]) || game["state"] != "playing") && !istrue(self._id_A5C9FCD81C474AB0))
    self setclientomnvar("ui_options_menu", 0);

  self setclientomnvar("ui_hud_shake", 0);
  self setclientomnvar("ui_combat_report_num_attackers", 0);
  self.lastkillsplash = undefined;
  self.spawnedasspectator = undefined;
  self.scorestreakvariantattackerinfo = undefined;
  self.cratemantle = undefined;
  self._id_4A2F2F50A9020E2E = undefined;

  if(getdvarint("scr_game_forceuav", 0) != 0)
    level thread scripts\cp_mp\killstreaks\uav::_id_C11936B9C6C3A076(self);

  level.numplayerswaitingtospawn++;

  if(level.numplayerswaitingtospawn > 1) {
    self.waitingtospawnamortize = 1;
    wait(level.framedurationseconds * (level.numplayerswaitingtospawn - 1));
  }

  if(scripts\mp\utility\teams::getteamdata(self.team, "noRespawns") == 1) {
    return;
  }
  thread spawningclientthisframereset();
  self.waitingtospawnamortize = 0;
  self._id_917B4BB916A1C110 = 0;
  thread _id_36FB658DD865A01A();

  if(!isDefined(self.pers["copiedClass"]))
    _id_B45E94B269AE0A46 = scripts\mp\class::preloadandqueueclass(self.class, 1);
  else {
    classstruct = scripts\mp\class::loadout_getorbuildclassstruct(self.class);
    scripts\mp\class::loadout_fixcopiedclassstruct(self.pers["copiedClass"], classstruct);

    if(isDefined(self.pers["lastKiller"])) {
      logloadoutcopy(self.pers["lastKiller"]);
      self.pers["lastKiller"] = undefined;
    }

    scripts\mp\class::preloadandqueueclassstruct(self.pers["copiedClass"], 1);
    _id_B45E94B269AE0A46 = self.pers["copiedClass"];
    self.pers["copiedClass"] = undefined;
  }

  _id_90CDC2FA578A7859 = gettime();
  self.spawndata = getspawnpoint();
  setspawnvariables();
  _id_3B375A40F67C3C64 = self.hasspawned;
  self.suicidespawndelay = undefined;
  self.fauxdead = undefined;
  self sethidenameplate(0);
  self _meth_5226227BCE83EBE9(2, self.team);

  if(!_id_13FE2B86C5E85A64) {
    self.killsthislife = [];

    if(!istrue(self.inspawncamera))
      scripts\mp\utility\player::updatesessionstate("playing");

    scripts\mp\utility\player::clearkillcamstate();
    self.cancelkillcam = undefined;

    if(istrue(self._id_C4C8B91E0B16AA5E)) {}

    self.maxhealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");

    if(istrue(_id_9156B53BCF7CE573)) {
      health = scripts\mp\utility\dvars::getwatcheddvar("teamReviveHealth");

      if(!isDefined(health))
        self.health = getdvarint("dvar_A8543004B97470B5", 50);
      else
        self.health = health;

      thread notifyreviveregen();
    } else
      self.health = self.maxhealth;

    if(istrue(self.friendlyfiredeath)) {
      self.friendlyfiredeath = undefined;
      thread _id_0FD32F08E72B657F::ffmessageonspawn();
    }

    self.friendlydamage = undefined;
    self.spawntime = gettime();
    self.wasti = self.ti_spawn;
    self.damagedplayers = [];
    self.objectivescaler = 1;
    self.shieldbullethits = 0;
    self.recentshieldxp = 0;
    self.respawntimerstarttime = undefined;
    self._id_DB03AE1B2B480308 = undefined;
    self.lastgastouchtime = undefined;
    self.lastsnapshotgrenadetime = undefined;
    self.lastinsmoketime = undefined;
    self.lastburntime = undefined;
    self.lasttimedamaged = undefined;
    self._id_198B774C93C48891 = undefined;
    self._id_9691E7D8CDE294F2 = undefined;
    self._id_C365BEFD3D253AEF = undefined;
    self._id_B43706CBB600FE5A = undefined;
    self._id_07744DF488B629B5 = undefined;

    if(isDefined(self.pers["agentsKillstreakCount"]))
      self.pers["agentsKillstreakCount"] = 0;

    if(isDefined(self.stuckbygrenade) && self.stuckbygrenade.stuckenemyentity == self)
      self.stuckbygrenade.stuckenemyentity = undefined;

    self.stuckbygrenade = undefined;
    self.stuckbygrenadeowner = undefined;
    self.lifeid = 0;

    if(getdvarint("dvar_7DFC9D99D9C1FF2F", 0) == 1) {
      if(isDefined(game["gameStateRestore"]) && istrue(game["gameStateRestore"].enabled))
        self.pers["deaths"] = _id_60DD02BEC5783ECD::_id_9505807477B46FA4(self.name);
    }

    if(isDefined(self.pers["deaths"]))
      self.lifeid = self.pers["deaths"];

    scripts\cp_mp\utility\damage_utility::cleardamagemodifiers();
    scripts\mp\killcam::clearkillcamomnvars();
  }

  self.movespeedscaler = 1;

  if(!_id_13FE2B86C5E85A64) {
    self.avoidkillstreakonspawntimer = 5.0;
    _id_F6EF404DCB6EB18C = self.pers["lives"];

    if(_id_F6EF404DCB6EB18C == scripts\mp\utility\game::getgametypenumlives() && scripts\mp\utility\game::getgametype() != "control")
      addtolivescount();

    if(_id_F6EF404DCB6EB18C) {
      if(scripts\mp\utility\game::getgametype() != "control")
        self.pers["lives"]--;
    }

    if(!istrue(self.gulag) && !istrue(self.respawningfromtoken) && !istrue(self.respawningbr))
      addtoalivecount("spawnPlayer");

    if(!_id_3B375A40F67C3C64 || scripts\mp\utility\game::gamehasstarted() || scripts\mp\utility\game::gamehasstarted() && level.ingraceperiod && self.hasdonecombat) {
      if(scripts\mp\utility\game::getgametype() == "control" && !istrue(level._id_7CFD99E45A36D4FB) && istrue(self._id_5F07316A0CB9F1DE)) {} else
        removefromlivescount();
    }

    if(!istrue(self.wasaliveatmatchstart)) {
      _id_2208746F8409B6D0 = 20;

      if(scripts\mp\utility\game::gettimelimit() > 0 && _id_2208746F8409B6D0 < scripts\mp\utility\game::gettimelimit() / 4)
        _id_2208746F8409B6D0 = scripts\mp\utility\game::gettimelimit() / 4;

      if(level.ingraceperiod || scripts\mp\utility\game::gettimepassed() < _id_2208746F8409B6D0 * 1000)
        self.wasaliveatmatchstart = 1;
    }
  }

  thread scripts\cp_mp\challenges::onspawn();
  _id_CC0031B0B6EC18B1 = getDvar("scr_overridefov", "65");

  if(self isconsoleplayer())
    self setclientdvar("cg_fov", _id_CC0031B0B6EC18B1);

  if(isDefined(self.spawndata.spawnpoint)) {
    if(!istrue(self.shouldgetnewspawnpoint))
      scripts\mp\spawnlogic::finalizespawnpointchoice(self.spawndata.spawnpoint);

    self.lastspawntime = gettime();
  } else if(!isDefined(self.faux_spawn_infected))
    self.lastspawntime = gettime();

  self.spawnpos = self.spawndata.spawnorigin;

  if(_id_13FE2B86C5E85A64 && scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    if(self isonground()) {
      self normalizeworldupreferenceangles();
      self.spawndata.spawnorigin = self.spawndata.spawnorigin - (0, 0, 80);
    }

    spawnangles = self getworldupreferenceangles();
  }

  self._id_91FF03702332CC07 = 0;
  self._id_489F22C08F63BC0F = 0;
  scripts\mp\spectating::setspectatepermissions();

  if(istrue(self._id_C4C8B91E0B16AA5E)) {
    self sethidenameplate(0);
    self.healthregendisabled = 0;
    self._id_C4C8B91E0B16AA5E = 0;
    stopspectateplayer(self getentitynumber(), 1, 0);
    scripts\mp\utility\player::updatesessionstate("playing");
    scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
    scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("playerlogic::spawnPlayer()");
    self _meth_6B4C8718BC36D1EF(0);
    self _meth_E4CCD01FB7EC7A6F(0);
    self _meth_D87E1768229D0E3E();
    scripts\mp\utility\player::_freezecontrols(0, undefined, "liveRagdoll");
    scripts\mp\class::_id_C5CE8711741E44B8();
  } else {
    if(isDefined(self._id_F109E15FAE27DDC2))
      self _meth_FE283BAD58880808(self.spawndata.spawnorigin, self.spawndata.spawnangles[1], self._id_F109E15FAE27DDC2);
    else
      self spawn(self.spawndata.spawnorigin, self.spawndata.spawnangles);

    _id_3C70A7175FBFA3FC = undefined;

    if(isDefined(level._id_BDD92C05D3032F65))
      _id_3C70A7175FBFA3FC = self[[level._id_BDD92C05D3032F65]]();

    if(!isDefined(_id_3C70A7175FBFA3FC))
      _id_3C70A7175FBFA3FC = (0, self.spawndata.spawnangles[1], 0);

    self setplayerangles(_id_3C70A7175FBFA3FC, 1);
    scripts\mp\utility\player::printspawnmessage("playerlogic::spawnPlayer() !!!CODE SPAWN!!! @" + self.spawndata.spawnorigin);

    if(getDvar("dvar_87485ECA39B418A6") == "1" && scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587() && !istrue(self.gulag)) {
      scripts\mp\outline::hudoutline_add_channel_internal("target acquisition", 1, getDvar("dvar_B2A3957007BD8417", "outline_depth_trans_red"));
      scripts\mp\outline::hudoutline_add_channel_internal("target acquisition transparent", -1, "outline_depth_trans_transparent");

      if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73() && isDefined(self._id_3F78C6A0862F9E25))
        scripts\mp\outline::hudoutline_add_channel_internal("teammate outlines", 5, "outline_nodepth_cyan");
      else
        scripts\mp\outline::hudoutline_add_channel_internal("teammate outlines", 5, "outline_depth_cyan");

      if(!isbot(self))
        _id_8F1890D7F6B565C4();
    }

    if(getdvarint("dvar_432DF71393030BE5", 0) == 1)
      scripts\mp\outline::hudoutline_add_channel_internal("damage", 2, "outline_nodepth_white");
  }

  self._id_8A3630D09E62CCB3 = [];

  if(!istrue(self.inspawncamera)) {
    self._id_F109E15FAE27DDC2 = undefined;
    self._id_9066885BD8B59751 = undefined;
  }

  if(!isDefined(level.lastspawnpos))
    level.lastspawnpos = [];

  level.lastspawnpos[self.team] = self.spawndata.spawnorigin;
  self.death_timer_length = 1023;

  if((_id_13FE2B86C5E85A64 || _id_9156B53BCF7CE573) && isDefined(self.faux_spawn_stance)) {
    self setstance(self.faux_spawn_stance);
    self.faux_spawn_stance = undefined;
  }

  if(isai(self))
    scripts\mp\utility\player::_freezecontrols(1, undefined, "spawn");

  self motionblurhqenable();

  if(!_id_13FE2B86C5E85A64)
    self painvisionon();

  scripts\mp\utility\game::canparachutebecut(self);
  [[level.onspawnplayer]](_id_9156B53BCF7CE573);
  self clearpredictedstreampos();
  _id_89C45825FBC9944B = !_id_13FE2B86C5E85A64 || istrue(self.faux_spawn_infected);

  if(_id_89C45825FBC9944B) {
    if(isai(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["player_spawned"]))
      self[[level.bot_funcs["player_spawned"]]]();

    if(isDefined(level.matchrecording_logevent))
      [[level.matchrecording_logevent]](self.clientid, self.team, "SPAWN", self.spawnpos[0], self.spawnpos[1], self.spawntime);

    if(!isai(self) && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      thread totaldisttracking(self.spawndata.spawnorigin);
  }

  if(!_id_13FE2B86C5E85A64) {
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_player_spawned", self);
    _id_4C770A9A4AD7659C::callback("onPlayerSpawn_destroyEquipment");
    self.matchdatalifeindex = -1;

    if(_id_4A6760982B403BAD::_id_0892570944F6B6A2(self)) {
      self.matchdatalifeindex = game["life_count"];
      game["life_count"]++;
    }

    self.lastmatchdatakillstreakindex = -1;

    if(getdvarint("online_matchdata_enabled") != 0)
      setmatchdata("lifeCount", game["life_count"]);
  }

  if(isDefined(self.selectedspawnarea))
    scripts\mp\analyticslog::logevent_spawnselectionchoice(self, self.selectedspawnarea);

  scripts\mp\equipment::clearallequipment();

  if(istrue(level._id_606EB45E074FF204))
    scripts\mp\perks\perks::_id_7EF2F6D740DA9325();

  scripts\mp\class::setclass(self.class);

  if(isDefined(level.custom_giveloadout))
    self[[level.custom_giveloadout]](_id_13FE2B86C5E85A64, _id_9156B53BCF7CE573);
  else {
    if(istrue(self._id_309A9B707BA4B596))
      thread scripts\mp\equipment\tac_insert::_id_3807E5ACB77B5011(_id_9156B53BCF7CE573);
    else
      scripts\mp\class::giveloadout(self.team, self.class, undefined, undefined, _id_9156B53BCF7CE573);

    if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      scripts\mp\perks\perks::_id_F2DBAB6F947771F2();
      self._id_A7BEFB30CD4958CB = 1;

      if(!scripts\mp\utility\perk::_hasperk("specialty_overcharge_field_upgrade")) {
        scripts\mp\supers::_id_B3D636936EC98AA0(0);
        self._id_A68B289A82138067 = undefined;
      }
    }

    if(scripts\mp\utility\perk::_hasperk("specialty_survivor"))
      self._id_4945D0D82DD3964B = 0;
  }

  if(getomnvar("ui_prematch_period")) {
    thread showgamemodeobjectivetext();
    thread _id_155C4AAA1DAE57E6();
  }

  if(!istrue(game["isLaunchChunk"])) {
    thread logstartingloadout();

    if(level.codcasterenabled && !self _meth_8420670EAFC8D391())
      thread _id_1354D352DB863672(self);
  }

  if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] > 0) {
    if(!isDefined(self.classrefreshed) || !self.classrefreshed) {
      if(isDefined(self.class_num))
        self.classrefreshed = 1;
    }
  }

  if(getdvarint("camera_thirdPerson"))
    scripts\mp\utility\player::setthirdpersondof(1);

  if(isai(self))
    scripts\mp\utility\player::_freezecontrols(0, undefined, "spawn");

  if(istrue(game["inLiveLobby"]) || scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !scripts\mp\flags::gameflag("prematch_done")) {
    if(scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm")
      allowprematchlook(self);
  } else if(!scripts\mp\flags::gameflag("prematch_done"))
    allowprematchlook(self);
  else {
    _id_F8048727716242B0 = !self.hasspawned;
    scripts\mp\utility\player::_freezecontrols(0, _id_F8048727716242B0, "spawn");
    scripts\mp\utility\player::_freezelookcontrols(0, _id_F8048727716242B0);
  }

  if(!istrue(self.hasspawned))
    scripts\mp\gamelogic::updatematchhasmorethan1playeromnvaronplayersfirstspawn();

  if(isDefined(self.pers["hasEarnedHardlineStreak"]) && self.pers["hasEarnedHardlineStreak"] == 0)
    scripts\mp\killstreaks\killstreaks::givestreakpoints("stat_FAA043C8926419E6", 3, 0);

  self.hasspawned = 1;
  self.pers["hasSpawned"] = 1;

  if(isDefined(level._id_FA280DF6CFD09D0B))
    self[[level._id_FA280DF6CFD09D0B]]();

  waittillframeend;
  self.spawningafterremotedeath = undefined;
  self.delayedspawnedplayernotify = undefined;

  if(!istrue(level.disablespawncamera) && isDefined(self.spawncameraent) || istrue(level.disablespawncamera) && isDefined(self.spawncameraent) && (scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict" || scripts\mp\utility\game::getgametype() == "risk")) {
    self.wasrevivespawn = _id_9156B53BCF7CE573;
    self.delayedspawnedplayernotify = 1;
    self notify("spawncamera_start");
  }

  if(istrue(self._id_309A9B707BA4B596)) {
    self.wasrevivespawn = _id_9156B53BCF7CE573;
    self.delayedspawnedplayernotify = 1;
    self notify("ti_spawncamera_start");
  }

  if(!istrue(self.delayedspawnedplayernotify)) {
    self notify("spawned_player");
    level notify("player_spawned", self, _id_9156B53BCF7CE573);
    thread setspawnnotifyomnvar();
  }

  if(game["state"] == "postgame")
    scripts\mp\gamelogic::freezeplayerforroundend();

  if(scripts\mp\analyticslog::analyticsspawnlogenabled() && !_id_13FE2B86C5E85A64) {
    if(scripts\mp\analyticslog::analyticsdoesspawndataexist())
      level.spawncount = level.spawncount + 1;
    else
      scripts\mp\analyticslog::analyticsinitspawndata();

    if(scripts\mp\analyticslog::analyticssend_shouldsenddata(level.spawncount)) {
      if(isDefined(level.spawnglobals.spawnpointslist)) {
        scripts\mp\analyticslog::analyticssend_spawnfactors(self, self.spawnpointslist, level.spawncount, self.spawndata.spawnpoint);
        scripts\mp\analyticslog::analyticssend_spawntype(self.spawndata.spawnpoint.origin, self.team, self.lifeid, level.spawncount);
        scripts\mp\analyticslog::analyticssend_spawnplayerdetails(self, self.spawndata.spawnpoint.origin, level.spawncount);
      }
    }

    self.lastspawnpoint = self.spawndata.spawnpoint;
  }

  if(!istrue(self.delayedspawnedplayernotify))
    self.spawndata = undefined;

  if(!isDefined(self.revive_chosenclass))
    thread scripts\mp\class::updateinstantclassswapallowed();

  _id_C2AE70BAD4794C38 = 0;

  if(_id_C2AE70BAD4794C38 || scripts\mp\utility\game::gametypesupportsbasejumping() && scripts\mp\utility\game::mapsupportsbasejumping()) {
    self skydive_setbasejumpingstatus(1);
    self skydive_setdeploymentstatus(1);
  }

  self setscriptablepartstate("wind", "1", 0);
  self._id_917B4BB916A1C110 = 1;
  self notify("validate_spawn");

  if(istrue(self._id_B1E84FE29DA97885))
    level thread scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 0, 0.0);

  _id_4C770A9A4AD7659C::callback("player_spawned");
}

_id_36FB658DD865A01A() {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_timeout_1(1.0, "validate_spawn");

  if(!istrue(self._id_917B4BB916A1C110))
    kick(self getentitynumber(), "EXE/PLAYERKICKED");
}

_id_8F1890D7F6B565C4() {
  thread _id_9055412313C726AD();
  thread _id_AAFE8D770F651878();
}

_id_9055412313C726AD() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(self)) {
    return;
  }
  self._id_C7365ACBD7C37449 = [];
  _id_68A6CD6D3CB58E79 = spawnStruct();
  self._id_C6500DFC575DC550 = 0;
  self._id_17915DB3DE174953 = 0;
  thread _id_C1C09484380F4831();
  outlinedenemies = [];

  for(;;) {
    enemies = self getsightedplayers();

    if(!isDefined(enemies)) {
      continue;
    }
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < outlinedenemies.size; _id_AC0E594AC96AA3A8++) {
      _id_D70915D0410C43AC = 0;
      _id_459B2937F96D7A00 = outlinedenemies[_id_AC0E594AC96AA3A8];

      foreach(_id_83A92033FBDB65F8 in enemies) {
        if(_id_459B2937F96D7A00 == _id_83A92033FBDB65F8) {
          _id_D70915D0410C43AC = 1;
          break;
        }
      }

      if(!_id_D70915D0410C43AC) {
        _id_459B2937F96D7A00 scripts\mp\outline::_id_32DFA50C47325ABE(self, "target acquisition transparent", 1);
        _id_459B2937F96D7A00 scripts\mp\outline::_id_32DFA50C47325ABE(self, "target acquisition", 1);
        outlinedenemies[_id_AC0E594AC96AA3A8] = undefined;
      }
    }

    outlinedenemies = scripts\engine\utility::array_removeundefined(outlinedenemies);

    if(self._id_17915DB3DE174953) {
      if(!self._id_C6500DFC575DC550) {
        foreach(_id_83A92033FBDB65F8 in enemies)
        _id_83A92033FBDB65F8 scripts\mp\outline::_id_32DFA50C47325ABE(self, "target acquisition", 1);

        self._id_C6500DFC575DC550 = 1;
      }

      waitframe();
      continue;
    }

    _id_A9D32C0B976412DA(_id_68A6CD6D3CB58E79);
    _id_2FD22303C5FCA912 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() != "dmz";

    foreach(_id_83A92033FBDB65F8 in enemies) {
      if(_id_2FD22303C5FCA912) {
        if(isDefined(_id_83A92033FBDB65F8._id_6A984A8887A1A08B) && !_id_83A92033FBDB65F8._id_6A984A8887A1A08B)
          continue;
      }

      if(scripts\engine\utility::array_contains_key(self._id_C7365ACBD7C37449, _id_83A92033FBDB65F8.clientid))
        self._id_C7365ACBD7C37449[_id_83A92033FBDB65F8.clientid].visible = 1;
      else {
        self._id_C7365ACBD7C37449[_id_83A92033FBDB65F8.clientid] = spawnStruct();
        self._id_C7365ACBD7C37449[_id_83A92033FBDB65F8.clientid]._id_BBE3BC9D5DE09AF8 = _id_83A92033FBDB65F8;
        self._id_C7365ACBD7C37449[_id_83A92033FBDB65F8.clientid]._id_D32FF37E82AB0CFF = 0;
        thread _id_1610DBC40254209C(_id_83A92033FBDB65F8);
      }

      enable_outline = 0;
      _id_AA59B8437A574636 = _id_83A92033FBDB65F8 gettagorigin("j_spinelower") - self gettagorigin("tag_eye");
      _id_D2E4BDDEDDC9B4F9 = length(_id_AA59B8437A574636);

      if(self._id_C7365ACBD7C37449[_id_83A92033FBDB65F8.clientid]._id_D32FF37E82AB0CFF) {
        if(_id_D2E4BDDEDDC9B4F9 < _id_68A6CD6D3CB58E79.maxdist && _id_D2E4BDDEDDC9B4F9 > getdvarfloat("dvar_1ADFE2E839BC58A6")) {
          angle = scripts\engine\math::anglebetweenvectors(_id_AA59B8437A574636, anglesToForward(self getplayerangles()));

          if(angle < _id_68A6CD6D3CB58E79._id_07F870143D9150C8)
            enable_outline = 1;
        }
      }

      _id_EEB63A7ECA4DCE95 = scripts\engine\utility::ter_op(!isbot(self), self _meth_E9D534B5F70DC904(), 1);

      if(_id_EEB63A7ECA4DCE95 && enable_outline)
        _id_83A92033FBDB65F8 scripts\mp\outline::hudoutline_enable_internal(self, "target acquisition");
      else {
        _id_83A92033FBDB65F8 scripts\mp\outline::_id_32DFA50C47325ABE(self, "target acquisition", 1);
        _id_83A92033FBDB65F8 scripts\mp\outline::hudoutline_enable_internal(self, "target acquisition transparent");
      }

      _id_E0B5DB5B1887D589 = 0;

      foreach(_id_AB980B7F35205D3D in outlinedenemies) {
        if(_id_AB980B7F35205D3D == _id_83A92033FBDB65F8) {
          _id_E0B5DB5B1887D589 = 1;
          break;
        }
      }

      if(!_id_E0B5DB5B1887D589)
        outlinedenemies = scripts\engine\utility::array_add(outlinedenemies, _id_83A92033FBDB65F8);
    }

    _id_F421C15CB65F2710 = getarraykeys(self._id_C7365ACBD7C37449);

    foreach(_id_FD31C374B38D3C00 in _id_F421C15CB65F2710) {
      if(isDefined(self._id_C7365ACBD7C37449[_id_FD31C374B38D3C00].visible) && !self._id_C7365ACBD7C37449[_id_FD31C374B38D3C00].visible) {
        self._id_C7365ACBD7C37449[_id_FD31C374B38D3C00]._id_BBE3BC9D5DE09AF8 notify("out_of_sight_" + self.clientid);
        self._id_C7365ACBD7C37449 = scripts\engine\utility::array_remove_key(self._id_C7365ACBD7C37449, _id_FD31C374B38D3C00);
        continue;
      }

      self._id_C7365ACBD7C37449[_id_FD31C374B38D3C00].visible = 0;
    }

    waitframe();
  }
}

_id_AAFE8D770F651878() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(self)) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    if(isDefined(level.maxteamsize) && level.maxteamsize == 1) {
      return;
    }
    maxdistance = getdvarfloat("dvar_A92733A582A89BFD", 4000);
  } else
    maxdistance = getdvarfloat("dvar_DDE5893BEF72AAFA", 4000);

  for(;;) {
    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(self.team, "players");

    foreach(player in _id_6D5ED003AF1F9612) {
      if(player == self) {
        continue;
      }
      if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73() && isDefined(player._id_6A984A8887A1A08B) && !player._id_6A984A8887A1A08B) {
        continue;
      }
      if(!isDefined(player gettagorigin("j_spinelower"))) {
        continue;
      }
      _id_AA59B8437A574636 = player gettagorigin("j_spinelower") - self gettagorigin("tag_eye");
      _id_D2E4BDDEDDC9B4F9 = length(_id_AA59B8437A574636);

      if(_id_D2E4BDDEDDC9B4F9 < maxdistance && self _meth_33CE59C7119A90A6()) {
        player scripts\mp\outline::hudoutline_enable_internal(self, "teammate outlines");
        continue;
      }

      player scripts\mp\outline::_id_32DFA50C47325ABE(self, "teammate outlines", 1);
    }

    waitframe();
  }
}

_id_7F9B1DCEAE4360B8() {
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(self.team, "players");

  foreach(player in _id_6D5ED003AF1F9612) {
    if(player == self) {
      continue;
    }
    player scripts\mp\outline::_id_32DFA50C47325ABE(self, "teammate outlines", 1);
  }
}

_id_C1C09484380F4831() {
  self endon("death_or_disconnect");

  for(;;) {
    message = scripts\engine\utility::waittill_any_timeout_3(1, "vehicle_enter", "vehicle_change_seat", "vehicle_exit");

    if(self._id_C6500DFC575DC550 && message == "vehicle_exit") {
      self._id_C6500DFC575DC550 = 0;
      self._id_17915DB3DE174953 = 0;
      continue;
    }

    if(message == "vehicle_enter") {
      self._id_17915DB3DE174953 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self);
      continue;
    }

    if(message == "vehicle_change_seat") {
      self._id_C6500DFC575DC550 = self._id_17915DB3DE174953;
      self._id_17915DB3DE174953 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self);
    }
  }
}

_id_1610DBC40254209C(_id_83A92033FBDB65F8) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_83A92033FBDB65F8 endon("death_or_disconnect");
  _id_83A92033FBDB65F8 endon("out_of_sight_" + self.clientid);
  wait(getdvarfloat("dvar_BABF297F40EF9792", 1.5));
  self._id_C7365ACBD7C37449[_id_83A92033FBDB65F8.clientid]._id_D32FF37E82AB0CFF = 1;
}

_id_A9D32C0B976412DA(_id_68A6CD6D3CB58E79) {
  isads = self playerads() > 0.5;
  _id_BE5D9CFA452A86DA = self _meth_6C6D7E55687EB480();
  _id_3FA0F1B08D372850 = getdvarfloat("dvar_9166B379C429CA44");
  _id_4D927AEE6726BC33 = getdvarfloat("dvar_B04F78259746BFAA", 7.0);
  _id_68A6CD6D3CB58E79._id_779315766223441A = getdvarfloat("dvar_82BF79A286A47409", 1.0);

  if(isads && isDefined(_id_BE5D9CFA452A86DA) && _id_BE5D9CFA452A86DA < 6) {
    _id_68A6CD6D3CB58E79.maxdist = _id_3FA0F1B08D372850 * (1.0 + getdvarfloat("dvar_BD6366AA8FDD2C54", 0.35 * _id_BE5D9CFA452A86DA));
    _id_68A6CD6D3CB58E79._id_07F870143D9150C8 = _id_4D927AEE6726BC33;

    if(_id_BE5D9CFA452A86DA > 0)
      _id_68A6CD6D3CB58E79._id_07F870143D9150C8 = _id_68A6CD6D3CB58E79._id_07F870143D9150C8 - (1.0 + _id_BE5D9CFA452A86DA * 0.7);
  } else {
    _id_68A6CD6D3CB58E79.maxdist = getdvarfloat("dvar_D9A3414A981B1B5A");
    _id_68A6CD6D3CB58E79._id_07F870143D9150C8 = getdvarfloat("dvar_7544939A6EC22268", 12.0);
  }
}

logloadoutcopy(_id_6181DE250AFA5BB6) {
  if(isDefined(_id_6181DE250AFA5BB6))
    self dlog_recordplayerevent("dlog_event_loadout_copy", ["receiver_player_client_id", self.clientid, "receiver_gamertag", self.name, "giver_player_client_id", _id_6181DE250AFA5BB6.clientid, "giver_gamertag", _id_6181DE250AFA5BB6.name]);
}

logstartingloadout() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }
  if(isDefined(self.curclass) && self.curclass != "juggernaut")
    scripts\mp\class::_id_200C71E93799B32F(self.classstruct);

  scripts\mp\flags::gameflagwait("prematch_done");

  if(isDefined(self.curclass) && self.curclass != "juggernaut")
    scripts\mp\class::loadout_lognewlygivenloadout(self.globalstruct, self.classstruct, self.curclass);
}

notifyreviveregen() {
  self endon("disconnect");
  self waittill("spawned_player");
  waitframe();
  self notify("force_regeneration");
}

setspawnnotifyomnvar() {
  self endon("disconnect");
  waitframe();
  self setclientomnvar("ui_player_spawned_notify", gettime());
}

playerprematchallow(_id_CD187E38E3DF8F36, _id_71F0E4C2BD2CD3FC) {
  string = scripts\engine\utility::_id_53C4C53197386572(_id_71F0E4C2BD2CD3FC, "prematch");

  if(!_id_CD187E38E3DF8F36) {
    _id_3B64EB40368C1450::set(string, "allow_movement", 0);
    _id_3B64EB40368C1450::set(string, "fire", 0);
    _id_3B64EB40368C1450::set(string, "offhand_weapons", 0);
    _id_3B64EB40368C1450::set(string, "offhand_primary_weapons", 0);
    _id_3B64EB40368C1450::set(string, "offhand_secondary_weapons", 0);
    _id_3B64EB40368C1450::set(string, "supers", 0);
    _id_3B64EB40368C1450::set(string, "allow_jump", 0);
    _id_3B64EB40368C1450::set(string, "melee", 0);
    _id_3B64EB40368C1450::set(string, "sprint", 0);
    _id_3B64EB40368C1450::set(string, "killstreaks", 0);
    _id_3B64EB40368C1450::set(string, "usability", 0);

    if(!istrue(level.disablemount)) {
      _id_3B64EB40368C1450::set("prematch_mount", "mount_top", 0);
      _id_3B64EB40368C1450::set("prematch_mount", "mount_side", 0);
    }
  } else {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00(string);

    if(!istrue(level.disablemount))
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("prematch_mount");
  }
}

allowprematchlook(player) {
  player[[level.prematchallowfunc]](0);
  player.prematchlook = 1;
}

clearprematchlook(player) {
  if(istrue(player.prematchlook) && !level.gameended) {
    player[[level.prematchallowfunc]](1);
    player.prematchlook = undefined;
  }
}

waitforversusmenudone() {
  level endon("prematch_over");
  self endon("versus_menu_done");

  for(;;) {
    self waittill("luinotifyserver", result, value);

    if(result == "versus_done")
      self notify("versus_menu_done");
  }
}

_id_0B18BCC805B8800E() {
  _id_64E4C3AB6B01B316::_id_BCB1D5FB674FA3A0();
  _id_AC1D8E40765A422E = _id_07C40FA80892A721::_id_0600F6CF462E983F();
  _id_DCCF522FB0268D46 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("backpack", "getTotalItemCountInBag")) {
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_armor_plate");
    _id_DCCF522FB0268D46 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("backpack", "getTotalItemCountInBag")]](lootid);
  }

  _id_FBE8D53A303038C4 = _id_AC1D8E40765A422E + _id_DCCF522FB0268D46;
  scripts\mp\codcasterclientmatchdata::_id_F8B808CD6473E6CC(20, _id_FBE8D53A303038C4);
  _id_B8B6FA3D6F2F0B8C = 0;

  if(isDefined(self.gasmaskhealth) && isDefined(self.gasmaskmaxhealth))
    _id_B8B6FA3D6F2F0B8C = (self.gasmaskhealth + 1) / self.gasmaskmaxhealth;

  scripts\mp\codcasterclientmatchdata::_id_F8B808CD6473E6CC(21, _id_B8B6FA3D6F2F0B8C);
  hasselfrevivetoken = _id_2CEDCC356F1B9FC8::hasselfrevivetoken();
  scripts\mp\codcasterclientmatchdata::_id_F8B808CD6473E6CC(22, hasselfrevivetoken);
}

_id_1354D352DB863672(player) {
  player endon("death_or_disconnect");

  for(;;) {
    if(isDefined(player.primaryweaponobj))
      player setclientweaponinfo(0, getcompleteweaponname(player.primaryweaponobj));

    if(isDefined(player.secondaryweaponobj))
      player setclientweaponinfo(1, getcompleteweaponname(player.secondaryweaponobj));

    player updatemlgammoinfo();
    player updatecurrentweapon();
    player _id_0B18BCC805B8800E();
    wait 0.05;
  }
}

_id_38D8271A5B966538() {
  _id_C2DB1B6C79EA1C6C = scripts\engine\utility::getStructArray("camera_intro", "targetname");

  if(!isDefined(_id_C2DB1B6C79EA1C6C) || _id_C2DB1B6C79EA1C6C.size == 0) {
    _id_C2DB1B6C79EA1C6C = [];
    _id_C2DB1B6C79EA1C6C[0] = spawnStruct();
    _id_C2DB1B6C79EA1C6C[0].origin = (0, 0, 0);
    _id_C2DB1B6C79EA1C6C[0].angles = (0, 0, 0);
  }

  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case "mp_village2":
      _id_C2DB1B6C79EA1C6C[0].origin = (1606.95, 2238.61, 958.77);
      _id_C2DB1B6C79EA1C6C[0].angles = (17, 215, -4.14);
      break;
    case "mp_backlot2":
      _id_C2DB1B6C79EA1C6C[0].origin = (310, -627, 279);
      _id_C2DB1B6C79EA1C6C[0].angles = (4, 196, 0);
      break;
    case "mp_hideout":
      _id_C2DB1B6C79EA1C6C[0].origin = (1867, -2487, 664);
      _id_C2DB1B6C79EA1C6C[0].angles = (15, 118, 0);
      break;
    case "mp_crash2":
      _id_C2DB1B6C79EA1C6C[0].origin = (-856, 2771, 1030);
      _id_C2DB1B6C79EA1C6C[0].angles = (18, 313, 0);
      break;
    case "mp_m_king":
      _id_C2DB1B6C79EA1C6C[0].origin = (691, -536, 223);
      _id_C2DB1B6C79EA1C6C[0].angles = (9, 159, 0);
      _id_C2DB1B6C79EA1C6C[1] = spawnStruct();
      _id_C2DB1B6C79EA1C6C[1].origin = (428, 508, 14);
      _id_C2DB1B6C79EA1C6C[1].angles = (0, 182, 0);
      _id_D0F582ECE8584466 = 1;
      break;
    case "mp_m_pine":
      _id_C2DB1B6C79EA1C6C[0].origin = (1260, 203, 239);
      _id_C2DB1B6C79EA1C6C[0].angles = (15, 189, 0);
      _id_C2DB1B6C79EA1C6C[1] = spawnStruct();
      _id_C2DB1B6C79EA1C6C[1].origin = (-582, -154, 64);
      _id_C2DB1B6C79EA1C6C[1].angles = (0, 137, 0);
      _id_D0F582ECE8584466 = 1;
      break;
    case "mp_m_showers":
      _id_C2DB1B6C79EA1C6C[0].origin = (2446, 19, 377);
      _id_C2DB1B6C79EA1C6C[0].angles = (24, 178, 0);
      _id_C2DB1B6C79EA1C6C[1] = spawnStruct();
      _id_C2DB1B6C79EA1C6C[1].origin = (435, 11, 15);
      _id_C2DB1B6C79EA1C6C[1].angles = (0, 0, 0);
      _id_D0F582ECE8584466 = 1;
      break;
    case "mp_m_hill":
      _id_C2DB1B6C79EA1C6C[0].origin = (254, 1651, 353);
      _id_C2DB1B6C79EA1C6C[0].angles = (10, 253, 0);
      _id_C2DB1B6C79EA1C6C[1] = spawnStruct();
      _id_C2DB1B6C79EA1C6C[1].origin = (231, -1024, 37);
      _id_C2DB1B6C79EA1C6C[1].angles = (353, 89, 0);
      _id_D0F582ECE8584466 = 1;
      break;
    case "mp_sira2_dev":
    case "mp_sira_gw":
      _id_C2DB1B6C79EA1C6C[0].origin = (-36200, -25850, 2000);
      _id_C2DB1B6C79EA1C6C[0].angles = (25, 70, 0);
      break;
    case "mp_fishtown_gw":
      _id_C2DB1B6C79EA1C6C[0].origin = (-8982.57, -51049.3, 2653.06);
      _id_C2DB1B6C79EA1C6C[0].angles = (14, 59, 0);
  }

  return _id_C2DB1B6C79EA1C6C;
}

spawnspectatormapcam(_id_92BAF229CB5FFAD2) {
  _id_2365AFB9696E69A4 = 6;
  _id_63EFEE80A44E06E1 = 4;
  _id_C3899F8E31B31E75 = 4;
  _id_D0F582ECE8584466 = 0;
  self endon("disconnect");

  if(isai(self)) {
    return;
  }
  if(level.splitscreen || self issplitscreenplayer())
    self setclientdvars("cg_fovScale", "0.65");
  else
    self setclientdvars("cg_fovScale", "1");

  self setclientomnvar("ui_mapshot_camera", 1);
  self lerpfovbypreset("mapflyover");
  _id_C2DB1B6C79EA1C6C = _id_38D8271A5B966538();

  if(_id_C2DB1B6C79EA1C6C.size == 0 || scripts\mp\flags::gameflag("infil_will_run")) {
    self visionsetfadetoblackforplayer("", 0.75);
    return;
  }

  _id_04006E26A6A576E8 = undefined;
  endpoint = undefined;
  _id_940902E006C2D2A2 = undefined;
  setspawnvariables();
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  scripts\mp\utility\player::updatesessionstate("spectator");
  self.pers["team"] = "spectator";
  self.team = "spectator";
  scripts\mp\utility\player::clearkillcamstate();
  self.friendlydamage = undefined;
  resetuidvarsonspectate();

  foreach(_id_F90358454413407F in level.teamnamelist)
  self allowspectateteam(_id_F90358454413407F, 0);

  self allowspectateteam("freelook", 0);
  self allowspectateteam("none", 0);

  if(isDefined(_id_C2DB1B6C79EA1C6C) && _id_C2DB1B6C79EA1C6C.size > 1 && !istrue(_id_D0F582ECE8584466)) {
    _id_7342959C0A950BD8 = randomintrange(0, _id_C2DB1B6C79EA1C6C.size - 1);
    _id_04006E26A6A576E8 = _id_C2DB1B6C79EA1C6C[_id_7342959C0A950BD8];
  } else if(isDefined(_id_C2DB1B6C79EA1C6C)) {
    _id_04006E26A6A576E8 = _id_C2DB1B6C79EA1C6C[0];

    if(istrue(_id_D0F582ECE8584466))
      _id_940902E006C2D2A2 = _id_C2DB1B6C79EA1C6C[1];
  } else {}

  _id_04006E26A6A576E8.fil = 1;
  scripts\mp\utility\player::_freezecontrols(1, undefined, "spectatorMapCam");
  self setspectatedefaults(_id_04006E26A6A576E8.origin, _id_04006E26A6A576E8.angles);
  self spawn(_id_04006E26A6A576E8.origin, _id_04006E26A6A576E8.angles);
  scripts\mp\utility\player::printspawnmessage("playerlogic::spawnSpectatorMapCam() !!!CODE SPAWN!!! @" + _id_04006E26A6A576E8.origin);
  _id_2584E8F1C45FFB37 = spawn("script_model", _id_04006E26A6A576E8.origin);
  _id_2584E8F1C45FFB37 setModel("tag_origin");
  _id_2584E8F1C45FFB37.angles = _id_04006E26A6A576E8.angles;
  _id_A0FD91F162829A01 = undefined;

  if(istrue(_id_D0F582ECE8584466)) {
    _id_A0FD91F162829A01 = spawn("script_model", _id_940902E006C2D2A2.origin);
    _id_A0FD91F162829A01 setModel("tag_origin");
    _id_A0FD91F162829A01.angles = _id_940902E006C2D2A2.angles;
  }

  thread waitforversusmenudone();

  if(isDefined(_id_92BAF229CB5FFAD2) && _id_92BAF229CB5FFAD2 == 99)
    result = "debug";
  else if(scripts\mp\flags::gameflag("prematch_done"))
    result = "prematch_over";
  else if(self.versusdone)
    result = "versus_menu_done";
  else
    result = scripts\engine\utility::waittill_any_timeout_2(2, "versus_menu_done", "prematch_over");

  if(result == "timeout") {
    if(scripts\mp\flags::gameflag("prematch_done"))
      result = "prematch_over";
    else
      result = "versus_menu_done";
  }

  if(result == "prematch_over") {
    self visionsetfadetoblackforplayer("", 0.75);
    return;
  }

  if(self issplitscreenplayer() && self issplitscreenplayerprimary()) {
    _id_6EE5484560EC747C = self getothersplitscreenplayer();
    _id_6EE5484560EC747C notify("versus_menu_done");
    waitframe();
  }

  self cameralinkTo(_id_2584E8F1C45FFB37, "tag_origin", 1);
  self notify("mapCamera_start");

  switch (level.mapname) {
    case "mp_parkour":
      _id_2584E8F1C45FFB37 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_parkour");
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(_id_2365AFB9696E69A4 - 0.25);
      return;
    default:
      break;
  }

  wait 0.25;
  self visionsetfadetoblackforplayer("", 0.75);
  self playlocalsound("mp_camera_intro_whoosh");
  _id_951B839A25FB6BAD = _id_04006E26A6A576E8;
  endpoint[0] = spawnStruct();

  if(isDefined(_id_04006E26A6A576E8.target))
    endpoint[0] = scripts\engine\utility::getStruct(_id_04006E26A6A576E8.target, "targetname");
  else {
    endpoint[0].origin = (0, 0, 0);
    endpoint[0].angles = (0, 0, 0);
  }

  switch (level.mapname) {
    case "mp_village2":
      endpoint[0].origin = (1925, -857, 1033);
      endpoint[0].angles = (362, 127, 0);
      break;
    case "mp_backlot2":
      endpoint[0].origin = (-399, -1457, 667);
      endpoint[0].angles = (15, 57, 0);
      break;
    case "mp_hideout":
      endpoint[0].origin = (1422, 2073, 464);
      endpoint[0].angles = (6, 236, 0);
      break;
    case "mp_crash2":
      endpoint[0].origin = (1559, 1586, 1030);
      endpoint[0].angles = (30, 234, 0);
      break;
    case "mp_m_king":
      endpoint[0].origin = (921, 300, 223);
      endpoint[0].angles = (8, 202, 0);
      endpoint[1] = spawnStruct();
      endpoint[1].origin = (415, 372, 14);
      endpoint[1].angles = (3, 179, 0);
      break;
    case "mp_m_pine":
      endpoint[0].origin = (714, 440, 167);
      endpoint[0].angles = (13, 205, 0);
      endpoint[1] = spawnStruct();
      endpoint[1].origin = (-859, -349, 75);
      endpoint[1].angles = (7, 104, 0);
      break;
    case "mp_m_showers":
      endpoint[0].origin = (1952, 354, 77);
      endpoint[0].angles = (6, 208, 0);
      endpoint[1] = spawnStruct();
      endpoint[1].origin = (906, 9, 15);
      endpoint[1].angles = (0, 0, 0);
      _id_D0F582ECE8584466 = 1;
      break;
    case "mp_m_hill":
      endpoint[0].origin = (-1332, 483, 252);
      endpoint[0].angles = (11, 313, 0);
      endpoint[1] = spawnStruct();
      endpoint[1].origin = (65, -547, 351);
      endpoint[1].angles = (16, 83, 0);
      break;
    case "mp_sira2_dev":
    case "mp_sira_gw":
      endpoint[0].origin = (-30200, -23550, 2000);
      endpoint[0].angles = (25, 150, 0);
      break;
    case "mp_fishtown_gw":
      endpoint[0].origin = (6444.48, -46895.7, 2653.06);
      endpoint[0].angles = (16, 117, 0);
      break;
  }

  _id_A5BB1FA786D5B61E = 0;

  for(;;) {
    if(isDefined(_id_951B839A25FB6BAD.speedadjust)) {
      _id_600C46D6ED25DFD7 = 1 / _id_951B839A25FB6BAD.speedadjust;
      _id_A2FBFA1AC218A716 = _id_600C46D6ED25DFD7 * distance(_id_951B839A25FB6BAD.origin, endpoint[0].origin);
    } else
      _id_A2FBFA1AC218A716 = distance(_id_951B839A25FB6BAD.origin, endpoint[0].origin);

    _id_A5BB1FA786D5B61E = _id_A5BB1FA786D5B61E + _id_A2FBFA1AC218A716;
    _id_951B839A25FB6BAD.distancetotarg = _id_A2FBFA1AC218A716;
    _id_951B839A25FB6BAD = endpoint[0];

    if(isDefined(_id_951B839A25FB6BAD.target)) {
      endpoint[0] = scripts\engine\utility::getStruct(_id_951B839A25FB6BAD.target, "targetname");
      continue;
    }

    break;
  }

  _id_951B839A25FB6BAD.eol = 1;
  _id_951B839A25FB6BAD = _id_04006E26A6A576E8;

  if(isDefined(_id_04006E26A6A576E8.target))
    endpoint[0] = scripts\engine\utility::getStruct(_id_04006E26A6A576E8.target, "targetname");
  else {
    endpoint[0].origin = (0, 0, 0);
    endpoint[0].angles = (0, 0, 0);
  }

  if(_id_A5BB1FA786D5B61E > 0) {
    for(;;) {
      _id_12DA28838C27DBA0 = _id_951B839A25FB6BAD.distancetotarg / _id_A5BB1FA786D5B61E;
      timetomove = scripts\engine\utility::ter_op(istrue(_id_D0F582ECE8584466), _id_12DA28838C27DBA0 * _id_63EFEE80A44E06E1, _id_12DA28838C27DBA0 * _id_2365AFB9696E69A4);

      if(isDefined(endpoint[0].eol))
        decel = timetomove / 2;
      else
        decel = 0;

      if(isDefined(_id_951B839A25FB6BAD.fil))
        accel = timetomove / 2;
      else
        accel = 0;

      _id_2584E8F1C45FFB37 moveTo(endpoint[0].origin, timetomove, accel, decel);
      _id_2584E8F1C45FFB37 rotateTo(endpoint[0].angles, timetomove, accel, decel);

      if(isDefined(endpoint[0].eol)) {
        _id_C99E130247EA0019 = int(timetomove / 2);
        wait(_id_C99E130247EA0019);
        wait(_id_C99E130247EA0019);
      } else
        wait(timetomove);

      _id_951B839A25FB6BAD = endpoint[0];

      if(isDefined(_id_951B839A25FB6BAD.target)) {
        endpoint[0] = scripts\engine\utility::getStruct(_id_951B839A25FB6BAD.target, "targetname");
        continue;
      }

      break;
    }
  }

  if(istrue(_id_D0F582ECE8584466)) {
    _id_A5BB1FA786D5B61E = 0;
    _id_DD80E398990947F1 = _id_940902E006C2D2A2;
    self spawn(_id_940902E006C2D2A2.origin, _id_940902E006C2D2A2.angles);
    self cameralinkTo(_id_A0FD91F162829A01, "tag_origin", 1);
    wait 0.25;
    self visionsetfadetoblackforplayer("", 0.75);
    self playlocalsound("mp_camera_intro_whoosh");

    for(;;) {
      if(isDefined(_id_DD80E398990947F1.speedadjust)) {
        _id_600C46D6ED25DFD7 = 1 / _id_DD80E398990947F1.speedadjust;
        _id_A2FBFA1AC218A716 = _id_600C46D6ED25DFD7 * distance(_id_DD80E398990947F1.origin, endpoint[1].origin);
      } else
        _id_A2FBFA1AC218A716 = distance(_id_DD80E398990947F1.origin, endpoint[1].origin);

      _id_A5BB1FA786D5B61E = _id_A5BB1FA786D5B61E + _id_A2FBFA1AC218A716;
      _id_DD80E398990947F1.distancetotarg = _id_A2FBFA1AC218A716;

      if(isDefined(_id_DD80E398990947F1.target)) {
        endpoint[1] = scripts\engine\utility::getStruct(_id_951B839A25FB6BAD.target, "targetname");
        continue;
      }

      break;
    }

    _id_DD80E398990947F1.eol = 1;
    _id_DD80E398990947F1.fil = 1;
    endpoint[1].eol = 1;

    for(;;) {
      _id_12DA28838C27DBA0 = _id_DD80E398990947F1.distancetotarg / _id_A5BB1FA786D5B61E;
      timetomove = scripts\engine\utility::ter_op(istrue(_id_D0F582ECE8584466), _id_12DA28838C27DBA0 * _id_C3899F8E31B31E75, _id_12DA28838C27DBA0 * _id_2365AFB9696E69A4);

      if(isDefined(endpoint[1].eol))
        decel = timetomove / 2;
      else
        decel = 0;

      if(isDefined(_id_DD80E398990947F1.fil))
        accel = timetomove / 2;
      else
        accel = 0;

      _id_A0FD91F162829A01 moveTo(endpoint[1].origin, timetomove, accel, decel);
      _id_A0FD91F162829A01 rotateTo(endpoint[1].angles, timetomove, accel, decel);

      if(isDefined(endpoint[1].eol)) {
        _id_C99E130247EA0019 = int(timetomove / 2);
        wait(_id_C99E130247EA0019);
        wait(_id_C99E130247EA0019);
      } else
        wait(timetomove);

      _id_DD80E398990947F1 = endpoint[1];

      if(isDefined(_id_DD80E398990947F1.target)) {
        endpoint[1] = scripts\engine\utility::getStruct(_id_DD80E398990947F1.target, "targetname");
        continue;
      }

      break;
    }
  }

  scripts\mp\utility\player::_freezecontrols(0, undefined, "spectatorMapCam");
  self.startcament = _id_2584E8F1C45FFB37;
  self setclientomnvar("ui_mapshot_camera", 0);
}

spawnspectator(origin, angles, gameended) {
  self notify("spawned");
  self notify("end_respawn");
  self notify("joined_spectators");
  level notify("joined_spectators", self);
  self.spawnedasspectator = 1;

  if(isDefined(self.deathspectatepos)) {
    origin = self.deathspectatepos;
    angles = vectortoangles(self.origin - self.deathspectatepos);
  }

  if(isDefined(self.startcament) && !isDefined(origin)) {
    origin = self.startcament.origin;
    angles = self.startcament.angles;
    self.startcament delete();
  }

  in_spawnspectator(origin, angles, gameended);
}

respawn_asspectator(origin, angles) {
  if(isDefined(self.deathspectatepos)) {
    origin = self.deathspectatepos;

    if(isDefined(self.deathspectateangles))
      angles = self.deathspectateangles;
    else
      angles = vectortoangles(self.origin - self.deathspectatepos);
  }

  in_spawnspectator(origin, angles);
}

in_spawnspectator(origin, angles, gameended) {
  setspawnvariables();
  _id_B47248E0C4294FA4 = self.pers["team"];

  if(isDefined(_id_B47248E0C4294FA4) && (_id_B47248E0C4294FA4 == "spectator" || _id_B47248E0C4294FA4 == "codcaster") && !level.gameended)
    scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");

  scripts\mp\class::loadout_clearperks();
  scripts\mp\utility\player::updatesessionstate("spectator");
  scripts\mp\utility\player::clearkillcamstate();
  self.friendlydamage = undefined;
  resetuidvarsonspectate();
  scripts\mp\spectating::setspectatepermissions();
  onspawnspectator(origin, angles, gameended);

  if(level.teambased && !level.splitscreen && !self issplitscreenplayer())
    scripts\mp\utility\player::setdof_spectator();
}

getplayerfromclientnum(clientnum) {
  if(clientnum < 0)
    return undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(level.players[_id_AC0E594AC96AA3A8] getentitynumber() == clientnum)
      return level.players[_id_AC0E594AC96AA3A8];
  }

  return undefined;
}

onspawnspectator(origin, angles, gameended) {
  if(isDefined(origin) && isDefined(angles)) {
    self setspectatedefaults(origin, angles);
    self spawn(origin, angles);
    scripts\mp\utility\player::printspawnmessage("playerlogic::onSpawnSpectator() !!!CODE SPAWN!!! @" + origin);
    return;
  }

  spawnpoint = getspectatepoint();

  if(istrue(level.usespawnselection)) {
    if(scripts\mp\utility\game::getgametype() == "risk")
      spawnpoint = level.spawncameras["default"]["allies"];
    else if(istrue(level.usestaticspawnselectioncamera))
      spawnpoint = scripts\mp\spawnselection::getstaticcameraposition(self.sessionteam);
    else if(self.sessionteam == "allies")
      spawnpoint = level.spawncameras["gw_fob_alliesHQ"]["allies"];
    else if(self.sessionteam == "axis")
      spawnpoint = level.spawncameras["gw_fob_axisHQ"]["axis"];
  }

  _id_4816B1172F8E226B = 8;

  if(isDefined(level.camerapos) && level.camerapos.size) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.camerahighestindex + 1 && _id_AC0E594AC96AA3A8 < _id_4816B1172F8E226B; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(level.camerapos[_id_AC0E594AC96AA3A8]) || !isDefined(level.cameraang[_id_AC0E594AC96AA3A8])) {
        continue;
      }
      self setmlgcameradefaults(_id_AC0E594AC96AA3A8, level.camerapos[_id_AC0E594AC96AA3A8], level.cameraang[_id_AC0E594AC96AA3A8]);
      level.cameramapobjs[_id_AC0E594AC96AA3A8].origin = level.camerapos[_id_AC0E594AC96AA3A8];
      level.numbermapobjs[_id_AC0E594AC96AA3A8].origin = level.camerapos[_id_AC0E594AC96AA3A8];
      level.cameramapobjs[_id_AC0E594AC96AA3A8].angles = level.cameraang[_id_AC0E594AC96AA3A8];
      level.numbermapobjs[_id_AC0E594AC96AA3A8].angles = level.cameraang[_id_AC0E594AC96AA3A8];
    }
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4816B1172F8E226B; _id_AC0E594AC96AA3A8++)
      self setmlgcameradefaults(_id_AC0E594AC96AA3A8, spawnpoint.origin, spawnpoint.angles);
  }

  self setspectatedefaults(spawnpoint.origin, spawnpoint.angles);

  if(isDefined(gameended)) {
    self allowspectateteam("freelook", 1);
    self allowspectateteam("none", 1);
  }

  if(scripts\mp\utility\game::isgroundwarcoremode() && !self.hasspawned)
    self _meth_B88C89BB7CD1AB8E(spawnpoint.origin);

  self spawn(spawnpoint.origin, spawnpoint.angles);
  scripts\mp\utility\player::printspawnmessage("playerlogic::onSpawnSpectator() !!!CODE SPAWN!!! @" + spawnpoint.origin);
}

getspectatepoint() {
  if(scripts\mp\utility\game::getgametype() == "gwtdm")
    return level.spawncameras["default"][self.sessionteam];

  if(scripts\mp\utility\game::getgametype() == "brtdm" || scripts\mp\utility\game::getgametype() == "brtdm_mgl")
    return level.brtdm_config.spectatepoint;

  spawnpoints = getEntArray("mp_global_intermission", "classname");
  _id_59BA6BE73235750F = [];

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    if(level.localeid == "locale_6") {
      _id_3CC83B4E56D476A9 = spawn("script_origin", (25642, -26550, 1818));
      _id_3CC83B4E56D476A9.angles = (14, 101, 0);
      return _id_3CC83B4E56D476A9;
    } else if(level.localeid == "locale_3") {
      _id_3CC83B4E56D476A9 = spawn("script_origin", (34440, -18522, 995));
      _id_3CC83B4E56D476A9.angles = (10, 281, 0);
      return _id_3CC83B4E56D476A9;
    }

    _id_3CC83B4E56D476A9 = undefined;

    foreach(spawnpoint in spawnpoints) {
      if(isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy == level.localeid)
        _id_3CC83B4E56D476A9 = spawnpoint;
    }

    if(isDefined(_id_3CC83B4E56D476A9))
      return _id_3CC83B4E56D476A9;
    else {
      foreach(spawnpoint in spawnpoints) {
        if(!isDefined(spawnpoint.script_noteworthy) || !issubstr(spawnpoint.script_noteworthy, "locale")) {
          _id_59BA6BE73235750F[_id_59BA6BE73235750F.size] = spawnpoint;
          continue;
        }

        spawnpoint delete();
      }
    }
  } else if(spawnpoints.size != 1) {
    foreach(spawnpoint in spawnpoints) {
      if(!isDefined(spawnpoint.script_noteworthy) || !issubstr(spawnpoint.script_noteworthy, "locale")) {
        _id_59BA6BE73235750F[_id_59BA6BE73235750F.size] = spawnpoint;
        continue;
      }

      spawnpoint delete();
    }
  } else
    _id_59BA6BE73235750F = spawnpoints;

  spawnpoint = scripts\mp\spawnlogic::getspawnpoint_random(_id_59BA6BE73235750F);
  return spawnpoint;
}

spawnintermission(spawnpoint, sessionstate, _id_97AEAEB76BCE73E0) {
  self endon("disconnect");
  self notify("spawned");
  self notify("end_respawn");

  if(!isDefined(sessionstate))
    sessionstate = "intermission";

  if(!isDefined(_id_97AEAEB76BCE73E0))
    _id_97AEAEB76BCE73E0 = 1;

  setspawnvariables();
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  scripts\mp\utility\lower_message::clearlowermessages();

  if(!getdvarint("dvar_8117734E3E0F8BE5", 0))
    scripts\mp\utility\player::_freezecontrols(1, undefined, "spawnIntermission");

  if(_id_97AEAEB76BCE73E0)
    self setclientdvar("cg_everyoneHearsEveryone", 1);

  if(isDefined(level.finalkillcam_winner) && level.finalkillcam_winner != "none" && isDefined(level.match_end_delay) && scripts\mp\utility\game::waslastround() && !istrue(level.doingbroshot))
    wait(level.match_end_delay);

  if(!istrue(level.doingbroshot))
    scripts\mp\utility\player::updatesessionstate(sessionstate);

  scripts\mp\utility\player::clearkillcamstate();
  self.friendlydamage = undefined;

  if(!isDefined(spawnpoint)) {
    if(!isDefined(level.localeid)) {
      spawnpoints = getEntArray("mp_global_intermission", "classname");
      spawnpoints = scripts\mp\spawnscoring::checkdynamicspawns(spawnpoints);

      if(istrue(level._id_8CF13EF4FD814CCD))
        spawnpoint = scripts\engine\utility::_id_7A2AAA4A09A4D250(spawnpoints);
      else
        spawnpoint = spawnpoints[0];
    } else
      spawnpoint = getspectatepoint();
  }

  if(!isDefined(level.custom_ending)) {
    self spawn(spawnpoint.origin, spawnpoint.angles);
    scripts\mp\utility\player::printspawnmessage("playerlogic::spawnIntermission() !!!CODE SPAWN!!! @" + spawnpoint.origin);
    scripts\mp\utility\player::setdof_spectator();
  }

  if(!getdvarint("dvar_8117734E3E0F8BE5", 0))
    scripts\mp\utility\player::_freezecontrols(1, undefined, "spawnIntermission");
}

spawnendofgame() {
  if(isDefined(level.modespawnendofgame) && self[[level.modespawnendofgame]]()) {
    return;
  }
  if(isDefined(level.custom_ending) && scripts\mp\utility\game::waslastround())
    level notify("start_custom_ending");

  if(!istrue(self.controlsfrozen))
    scripts\mp\utility\player::_freezecontrols(1, undefined, "spawnEndOfGame");

  if(istrue(level.doingbroshot)) {
    self notify("spawned");
    scripts\mp\utility\player::clearkillcamstate();
  } else
    spawnspectator();
}

setspawnvariables() {
  scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
  self stoprumble("damage_heavy");
  self.deathposition = undefined;
}

_id_358A3AE71B7D1935(player) {
  if(!isPlayer(player) || isbot(player))
    return undefined;

  _id_4D1DB612C5B9184B = 0.0;
  _id_C1480A81B0387196 = player.pers["shotsFired"];
  _id_18E9670604A31D9F = player.pers["shotsHit"];

  if(isDefined(_id_C1480A81B0387196) && isDefined(_id_18E9670604A31D9F) && _id_C1480A81B0387196 > 0)
    _id_4D1DB612C5B9184B = float(_id_18E9670604A31D9F / _id_C1480A81B0387196 * 100);

  _id_0E34D7C876B7BA0C = 0;

  if(isDefined(player.pers["telemetry"]._id_0E34D7C876B7BA0C))
    _id_0E34D7C876B7BA0C = player.pers["telemetry"]._id_0E34D7C876B7BA0C;

  _id_3A6757BA728AE8D5 = 0;

  if(player scripts\mp\utility\game::rankingenabled() && player hasplayerdata())
    _id_3A6757BA728AE8D5 = player getplayerdata("common", "mpProgression", "playerLevel", "xp");

  playerstats = spawnStruct();
  playerstats._id_3860527DD55B1B94 = gettime() - player.connecttime;
  playerstats.kills = player scripts\mp\utility\stats::getpersstat("kills");
  playerstats.deaths = player scripts\mp\utility\stats::getpersstat("deaths");
  playerstats.headshots = player scripts\mp\utility\stats::getpersstat("headshots");
  playerstats._id_CBC3FCC6B1097835 = _id_3A6757BA728AE8D5 - _id_0E34D7C876B7BA0C;
  playerstats.accuracy = _id_4D1DB612C5B9184B;
  playerstats.xuid = player getxuid();
  return playerstats;
}

callback_playerdisconnect(_id_401C3A2E68AAB0FD) {
  if(!isDefined(self.connected)) {
    return;
  }
  self.disconnecting = 1;
  playerstats = _id_358A3AE71B7D1935(self);
  self _meth_FE84F716B4611373(playerstats);

  if(getdvarint("online_matchdata_enabled") != 0) {
    _id_111033081511109A = getmatchdata("commonMatchData", "player_count_left");
    _id_111033081511109A++;
    setmatchdata("commonMatchData", "player_count_left", _id_111033081511109A);
  }

  result = undefined;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(istrue(self.pers["hasDoneAnyCombat"]) || istrue(self.pers["participation"]))
      result = "eliminated";

    if(istrue(level._id_455A4E4B5E61F55F) && !isbot(self) && self isinexecutionvictim() && isalive(self)) {
      attacker = self getexecutionpartner();
      _id_BA9DC00E6D5896DC = self.health;

      if(scripts\mp\damage::shouldrecorddamagestats(self)) {
        attacker scripts\mp\utility\stats::incpersstat("damage", _id_BA9DC00E6D5896DC);

        if(!isDefined(attacker.damagethisround))
          attacker.damagethisround = _id_BA9DC00E6D5896DC;
        else
          attacker.damagethisround = attacker.damagethisround + _id_BA9DC00E6D5896DC;
      } else if(isDefined(level.onattackerdamagenottracked))
        attacker[[level.onattackerdamagenottracked]](_id_BA9DC00E6D5896DC);

      attacker _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("damageDealt", attacker.pers["damage"]);
      self kill(self.origin, attacker, attacker, "MOD_EXECUTION");
      self notify("disconnect");
    }
  }

  if(isDefined(level._id_3940D363B8FB58C3))
    result = level._id_3940D363B8FB58C3;

  scripts\mp\utility\disconnect_event_aggregator::_id_7104B549684A0447(self);
  scripts\cp_mp\utility\game_utility::stopkeyearning(result);

  if(scripts\mp\utility\killstreak::iscontrollingproxyagent())
    self restorecontrolagent();

  _id_5814D27874B48E54 = spawnStruct();
  _id_5814D27874B48E54.player = self;
  _id_5814D27874B48E54._id_934DC135AAF6F953 = _id_401C3A2E68AAB0FD;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_player_disconnect", _id_5814D27874B48E54);
  removeplayerondisconnect();
  scripts\cp_mp\utility\game_utility::removefromparticipantsarray();
  scripts\cp_mp\utility\game_utility::removefromcharactersarray();
  scripts\cp_mp\utility\player_utility::removefromdismembermentlist();
  entnum = self getentitynumber();

  if(!level.teambased)
    game["roundsWon"][self.guid] = undefined;

  if(level.splitscreen) {
    players = level.players;

    if(players.size <= 1)
      level thread scripts\mp\gamelogic::forceend();
  }

  if(isDefined(self.kills) && isDefined(self.deaths)) {
    if(scripts\mp\utility\game::getgametype() == "arena" && 3 > self.timeplayed["total"]) {
      if(!isDefined(self.arenadamage)) {
        return;
      }
      damage = self.arenadamage;
      setplayerteamrank(self, self.clientid, damage);
    } else if(120 < self.timeplayed["total"]) {
      _id_CE3B2F78F590611E = (self.kills - self.deaths) / (self.timeplayed["total"] / 60);
      setplayerteamrank(self, self.clientid, _id_CE3B2F78F590611E);
    }
  } else {}

  _id_8C559F8A74589A15 = self getentitynumber();
  _id_E51148F7759ECDDC = self.guid;
  logprint("Q;" + _id_E51148F7759ECDDC + ";" + _id_8C559F8A74589A15 + ";" + self.name + "\n");

  if(analyticsstreamerislogfilestreamingenabled())
    analyticsstreamerlogfilewritetobuffer("Q;" + _id_E51148F7759ECDDC + ";" + _id_8C559F8A74589A15 + ";" + self.name + "\n");

  thread scripts\mp\events::disconnected();

  if(level.gameended)
    scripts\mp\gamescore::removedisconnectedplayerfromplacement();

  if(isDefined(self.team)) {
    removefromteamcount();

    if(scripts\engine\utility::array_contains(level.teamdata[self.team]["alivePlayers"], self)) {
      removefromalivecount(1, "disconnect");
      scripts\mp\utility\teams::validatealivecount("disconnect", self.team, self, "Callback_PlayerDisconnect");
    }

    _id_76CC264B397DB9CB::leavesquad(self.team, self._id_0FF97225579DE16A);
  }

  scripts\cp_mp\utility\weapon_utility::clearlockedonondisconnect(self);
  level thread[[level.updategameevents]]();
  _id_04CDABCD91A92977::_id_8CF8FF669AC52156(_id_401C3A2E68AAB0FD);
  scripts\mp\utility\disconnect_event_aggregator::rundisconnectcallbacks(self);
  scripts\mp\gamelogic::updatematchhasmorethan1playeromnvaronplayerdisconnect();
  scripts\common\utility::trycall(level.matchdata_logplayerdata, _id_401C3A2E68AAB0FD);

  if(!scripts\mp\gamelogic::_id_8464FD951B451534())
    level thread _id_5101FD82B09E9363();
}

_id_5101FD82B09E9363() {
  level notify("endEmptyGameWatcher");
  level endon("endEmptyGameWatcher");
  level endon("connected");
  _id_C08C3B91ED82C26D = getdvarfloat("dvar_36C64ACC6CA5E510", 30.0);
  wait(_id_C08C3B91ED82C26D);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && getdvarint("dvar_E709033AFED344C5", 1) == 1 && istrue(level.br_prematchstarted))
    scripts\mp\gamelogic::sendendofmatchdata();

  thread scripts\mp\gamelogic::endgame("draw", game["end_reason"]["host_ended_game"]);
}

removeplayerondisconnect() {
  found = 0;

  for(_id_F90358454413407F = 0; _id_F90358454413407F < level.players.size; _id_F90358454413407F++) {
    if(level.players[_id_F90358454413407F] == self) {
      for(found = 1; _id_F90358454413407F < level.players.size - 1; _id_F90358454413407F++)
        level.players[_id_F90358454413407F] = level.players[_id_F90358454413407F + 1];

      level.players[_id_F90358454413407F] = undefined;
      break;
    }
  }

  level.playersbyentitynumber[self getentitynumber()] = undefined;
}

initclientdvarssplitscreenspecific() {
  if(level.splitscreen || self issplitscreenplayer()) {
    self setclientdvars("cg_fovScale", "0.75");
    setDvar("r_materialbloomhqscriptmasterenable", 0);
  } else
    self setclientdvars("cg_fovScale", "1");
}

initclientdvars() {
  setDvar("cg_drawCrosshair", 1);
  setDvar("cg_drawCrosshairNames", 1);

  if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19()) {
    setDvar("cg_drawCrosshair", 0);
    setDvar("cg_drawCrosshairNames", 1);
  }

  if(isDefined(level.alwaysdrawfriendlynames) && level.alwaysdrawfriendlynames)
    setDvar("cg_drawFriendlyNamesAlways", 1);
  else
    setDvar("cg_drawFriendlyNamesAlways", 0);

  self setclientdvars("cg_drawSpectatorMessages", 1);
  initclientdvarssplitscreenspecific();

  if(scripts\mp\utility\game::getgametypenumlives()) {
    if(level.teambased)
      self setclientdvars("cg_deadChatWithDead", 0, "cg_deadChatWithTeam", 1, "cg_deadHearTeamLiving", 1, "cg_deadHearAllLiving", 0);
    else
      self setclientdvars("cg_deadChatWithDead", 1, "cg_deadChatWithTeam", 0, "cg_deadHearTeamLiving", 0, "cg_deadHearAllLiving", 0);
  } else
    self setclientdvars("cg_deadChatWithDead", 0, "cg_deadChatWithTeam", 1, "cg_deadHearTeamLiving", 1, "cg_deadHearAllLiving", 0);

  if(level.teambased)
    self setclientdvars("cg_everyoneHearsEveryone", 0);

  self setclientdvar("voice_proximity_enemy_client", 1);
  self setclientdvar("cg_fov", 65.0);
  self setclientdvar("cg_disable_user_fov", 0);

  if(getdvarint("scr_hitloc_debug")) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 6; _id_AC0E594AC96AA3A8++)
      self setclientdvar(_func_2EF675C13CA1C4AF("ui_hitloc_", scripts\engine\utility::string(_id_AC0E594AC96AA3A8)), "");

    self.hitlocinited = 1;
  }
}

connect_validateplayerteam() {
  if(!isDefined(self)) {
    return;
  }
  _id_155C56B2E3DB23C9 = getDvar("scr_force_team", "");

  if(self.sessionteam == "none" && scripts\mp\utility\game::matchmakinggame() && level.teambased && !isbot(self) && !istestclient(self) && !self _meth_8420670EAFC8D391() && scripts\mp\utility\game::getgametype() != "infect" && !scripts\mp\utility\teams::isgameplayteam(_id_155C56B2E3DB23C9)) {
    dlog_recordevent("mp_invalid_team_error", ["player_xuid", self getxuid(), "isHost", self ishost()]);
    wait 1.5;
    kick(self getentitynumber(), "EXE/PLAYERKICKED_INVALIDTEAM");
  }
}

queueconnectednotify() {
  for(;;) {
    if(!isDefined(level.players_waiting_for_callback)) {
      waitframe();
      continue;
    }

    break;
  }

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players_waiting_for_callback.size; _id_AC0E594AC96AA3A8++) {
      player = level.players_waiting_for_callback[_id_AC0E594AC96AA3A8];

      if(isDefined(player)) {
        level notify("connected", player);
        player notify("connected_continue");
        level.players_waiting_for_callback[_id_AC0E594AC96AA3A8] = undefined;
        break;
      }
    }

    _id_50F783A5617F8940 = scripts\engine\utility::array_removeundefined(level.players_waiting_for_callback);
    level.players_waiting_for_callback = _id_50F783A5617F8940;
    waitframe();
  }
}

onversusdone(_id_7148C1A6F25491F8, _id_EA8523762E51DD5E) {
  if(_id_7148C1A6F25491F8 != "versus_done") {
    return;
  }
  self.versusdone = 1;
}

initsegmentstats() {
  level endon("game_ended");
  level thread recordplayersegmentdata();

  for(;;) {
    level waittill("connected", player);
    level thread createplayersegmentstats(player);
  }
}

recordplayersegmentdata() {
  level endon("game_ended");

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    level thread _id_6507ACD84AA694F8();
  else {
    scripts\mp\flags::gameflagwait("prematch_done");
    wait 4;
  }

  for(;;) {
    wait 1;

    foreach(player in level.players) {
      if(istrue(player.canrecordsegmentstats))
        player thread updateplayersegmentdata();
    }
  }
}

createplayersegmentstats(player) {
  player endon("disconnect");
  player waittill("spawned_player");

  if(!isDefined(player.pers["distanceTotal"]))
    player.pers["distanceTotal"] = 0;

  if(!isDefined(player.pers["movingTotal"]))
    player.pers["movingTotal"] = 0;

  if(!isDefined(player.pers["movementUpdateCount"]))
    player.pers["movementUpdateCount"] = 0;

  player.savedsegmentposition = player.origin;
  player.positionptm = player.origin;
  player.canrecordsegmentstats = 1;
}

_id_81556B07C7A4BF27() {
  self.pers["movementUpdateCount"] = 0;
  self.pers["distanceTotal"] = 0;
  self.pers["movingTotal"] = 0;
  self.savedsegmentposition = undefined;
  self.positionptm = undefined;
  self._id_6A984A8887A1A08B = 0;
  _id_7F9B1DCEAE4360B8();
}

_id_6507ACD84AA694F8() {
  scripts\mp\flags::gameflagwait("prematch_done");
  wait 4;

  foreach(player in level.players) {
    if(istrue(player.canrecordsegmentstats))
      player _id_81556B07C7A4BF27();
  }
}

updateplayersegmentdata() {
  self endon("disconnect");

  if(!isDefined(self.savedsegmentposition)) {
    self.savedsegmentposition = self.origin;
    self.positionptm = self.origin;
  }

  if(scripts\mp\utility\player::isusingremote()) {
    self waittill("stopped_using_remote");
    self.savedsegmentposition = self.origin;
    self.positionptm = self.origin;
    return;
  }

  self.pers["movementUpdateCount"]++;
  self.pers["distanceTotal"] = self.pers["distanceTotal"] + distance2d(self.savedsegmentposition, self.origin);
  self.savedsegmentposition = self.origin;

  if(self.pers["movementUpdateCount"] % 5 == 0) {
    _id_03738EA25E5A0F93 = distance2d(self.positionptm, self.origin);
    self.positionptm = self.origin;

    if(_id_03738EA25E5A0F93 > 16)
      self.pers["movingTotal"]++;
  }
}

shouldshowwidemapshot(_id_C924752368853F99) {
  if(istrue(level._id_A6954A050D77D75C) || getdvarint("scr_shoulddisablemapflyin", 1))
    return 0;

  return !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && _id_C924752368853F99 < level.prematchperiod && !istrue(self.btestclient) && !scripts\mp\flags::gameflag("infil_will_run");
}

_id_9FAC5C57173A9BB9() {
  self endon("disconnect");
  _id_F69BA8D7B96E8326 = getdvarfloat("dvar_E13BFF48D7059619", 1.0);
  wait(_id_F69BA8D7B96E8326);
  self notify("round_based_fade_up");
}

setuipregamefadeup(waitmsg, _id_C647AE2BF7B3DE70, _id_9C9865252730745E) {
  self endon("disconnect");

  if(istrue(_id_9C9865252730745E))
    scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 1, 0);
  else
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0);

  if(scripts\mp\flags::gameflag("infil_will_run") && !scripts\mp\flags::gameflag("prematch_done"))
    thread _id_AF273A2E9ABF2489(_id_9C9865252730745E);

  starttime = gettime();

  if(isDefined(_id_C647AE2BF7B3DE70) && isDefined(waitmsg)) {
    _id_C647AE2BF7B3DE70 waittill(waitmsg);

    if(waitmsg == "infil_started") {
      if(level.mapname == "mp_forsaken_gw")
        wait 1.0;
    }
  }

  _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
  mintime = getdvarint("dvar_D91436487F90E63C", 0);

  if(mintime > 0) {
    _id_897C2BAC1E48E4CD = (gettime() - starttime) / 1000;

    if(_id_897C2BAC1E48E4CD < mintime)
      wait(mintime - _id_897C2BAC1E48E4CD);
  }

  if(istrue(_id_9C9865252730745E))
    scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 0, 0.5);
  else
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.5);
}

_id_AF273A2E9ABF2489(_id_9C9865252730745E) {
  self endon("disconnect");
  level endon("start_scene");
  level waittill("post_game_ui_start");
  spawnpoints = getEntArray("mp_global_intermission", "classname");

  if(spawnpoints.size > 0) {
    _id_5F317A83D6CB6774 = scripts\engine\utility::getclosest(self.origin, spawnpoints);

    if(isDefined(_id_5F317A83D6CB6774)) {
      _id_A92E3D2FF7AF10C9 = spawn("script_model", _id_5F317A83D6CB6774.origin);

      if(isDefined(_id_A92E3D2FF7AF10C9)) {
        _id_A92E3D2FF7AF10C9 setModel("tag_origin");
        _id_A92E3D2FF7AF10C9.angles = _id_5F317A83D6CB6774.angles;
        _id_A92E3D2FF7AF10C9.data = _id_5F317A83D6CB6774;
        self cameralinkTo(_id_A92E3D2FF7AF10C9, "tag_origin", 1, 1);
      } else {}
    } else {}
  } else {}

  if(istrue(_id_9C9865252730745E))
    scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 0, 0.5);
  else
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.5);
}

callback_playeractive() {
  self.pers["streamSyncComplete"] = 1;
  self notify("player_active");

  if(isDefined(self.team) && scripts\mp\utility\teams::isgameplayteam(self.team)) {
    _id_56E7CF38A4910BA2 = scripts\mp\teams::getoperatorcustomization();
    body = _id_56E7CF38A4910BA2[0];
    head = _id_56E7CF38A4910BA2[1];
    self setcustomization(body, head);
  }
}

getmaxnumplayerslogging() {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return 30;
  else
    return 200;
}

_id_2724805D492E905D(origin, angles) {
  _id_5940F376A254619D = spawn("script_model", origin);
  _id_5940F376A254619D setModel("tag_origin");
  _id_5940F376A254619D.angles = angles;
  scripts\mp\utility\player::updatesessionstate("spectator");
  self cameralinkTo(_id_5940F376A254619D, "tag_origin");
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "spawned_player");
  _id_5940F376A254619D delete();
}

callback_playerconnect() {
  self.versusdone = 0;
  self.statusicon = "hud_status_connecting";
  self waittill("begin");
  self.statusicon = "";

  if(isai(self) || getdvarint("unattended", 0) == 1)
    callback_playeractive();

  self.connecttime = gettime();
  self clearpredictedstreampos();

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    self clearadditionalstreampos();

  _id_CE91130A97F4C478 = 1;

  if(isDefined(level.onplayerconnectstream))
    _id_CE91130A97F4C478 = self thread[[level.onplayerconnectstream]]();

  if(scripts\mp\spawncamera::_id_581A8FC6F76D525D() && isDefined(self.sessionteam) && scripts\mp\utility\teams::isgameplayteam(self.sessionteam))
    scripts\mp\spawncamera::_id_CDFF2F0B5DCF3AA1();

  if(scripts\mp\flags::gameflag("prematch_done") && istrue(level.usespawnselection) && isDefined(self.sessionteam)) {
    if(scripts\mp\utility\game::getgametype() == "risk")
      _id_D596480119E7A95B = level.spawncameras["default"]["allies"];
    else if(self.sessionteam == "allies") {
      _id_D596480119E7A95B = level.spawncameras["gw_fob_alliesHQ"]["allies"];
      self _meth_47933F5EB9F65AFE(_id_D596480119E7A95B.origin);
    } else if(self.sessionteam == "axis") {
      _id_D596480119E7A95B = level.spawncameras["gw_fob_axisHQ"]["axis"];
      self _meth_47933F5EB9F65AFE(_id_D596480119E7A95B.origin);
    }
  }

  self visionsetfadetoblackforplayer("bw", 0);
  waitmsg = "connected_continue";
  _id_9C9865252730745E = 0;
  _id_C647AE2BF7B3DE70 = self;
  _id_C924752368853F99 = scripts\mp\utility\game::gettimepassed() / 1000 + 6;

  if(scripts\mp\flags::gameflag("infil_will_run") && !scripts\mp\flags::gameflag("infil_started")) {
    waitmsg = "infil_started";
    _id_9C9865252730745E = 1;
    _id_C647AE2BF7B3DE70 = level;
  }

  if(!isDefined(self.pers["streamSyncComplete"]) && shouldshowwidemapshot(_id_C924752368853F99)) {
    _id_C2DB1B6C79EA1C6C = _id_38D8271A5B966538();
    _id_11F3B4465C8B637B = _id_2CEDCC356F1B9FC8::playerstreamhintlocation(_id_C2DB1B6C79EA1C6C[0].origin);
    waitmsg = "player_active";
  } else if(scripts\mp\utility\game::getsubgametype() == "dmz" && getdvarint("dvar_1ED3F112D3406B97", 1)) {
    if(!istrue(level._id_72E1667D06AB98DB) && isDefined(self.origin) && getdvarint("dvar_8502B5F6F282D7C1", 1)) {
      if(!istrue(level._id_466A09C79541FC26))
        waitmsg = "dmz_playInfil";
      else
        waitmsg = undefined;

      _id_9C9865252730745E = 1;
    } else if(!isDefined(self.pers["streamSyncComplete"])) {
      waitmsg = "player_active";
      _id_9C9865252730745E = 1;
    }
  } else if(scripts\mp\utility\game::isroundbased() && game["roundsPlayed"] > 0) {
    waitmsg = "round_based_fade_up";
    _id_9C9865252730745E = 1;
    thread _id_9FAC5C57173A9BB9();
  }

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || scripts\mp\utility\game::getsubgametype() == "dmz" && istrue(level._id_59FF09549058DDA2))
    thread setuipregamefadeup(waitmsg, _id_C647AE2BF7B3DE70, _id_9C9865252730745E);

  level.players_waiting_for_callback[level.players_waiting_for_callback.size] = self;
  self waittill("connected_continue");
  self.connected = 1;

  if(!isDefined(level.uniqueplayersconnected))
    level.uniqueplayersconnected = 1;
  else
    level.uniqueplayersconnected++;

  initinputtypewatcher();
  self setclientomnvar("ui_scoreboard_freeze", 0);

  if(self ishost())
    level.player = self;

  if(!level.splitscreen && !isDefined(self.pers["score"])) {
    _id_973C2033E57C470B = 0;
    _id_F56F146953CA91B5 = getdvarint("dvar_6A935F93A9854B13", 0);

    if(_id_F56F146953CA91B5 > 0) {
      if(isDefined(level.starttime)) {
        _id_3B5803E733581858 = (gettime() - level.starttime) / 1000;

        if(_id_3B5803E733581858 <= _id_F56F146953CA91B5)
          _id_973C2033E57C470B = 1;
      } else
        _id_973C2033E57C470B = 1;
    }

    if(_id_973C2033E57C470B == 0) {}
  }

  self.usingonlinedataoffline = self isusingonlinedataoffline();
  initclientdvars();
  initplayerstats();
  scripts\mp\accolades::applyaccoladestructtoplayerpers();

  if(getDvar("r_reflectionprobegenerate") == "1")
    level waittill("eternity");

  self.guid = scripts\mp\utility\player::getuniqueid();
  _id_7EC298E587EB6719 = 0;

  if(!isDefined(self.pers["clientid"])) {
    self.pers["clientid"] = game["clientid"];
    game["clientid"]++;
    maxplayers = getmaxnumplayerslogging();

    if(game["clientid"] >= maxplayers) {
      game["clientid"] = maxplayers - 1;
      self.pers["clientid"] = maxplayers - 1;
    }

    _id_7EC298E587EB6719 = 1;
    self.pers["matchdataWeaponStats"] = [];
    self.pers["matchdataScoreEventCounts"] = [];
    self.pers["xpAtLastDeath"] = 0;
    self.pers["scoreAtLastDeath"] = 0;
    self.pers["weaponStats"] = [];

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      if(getdvarint("dvar_FDD2344D2352C119", 0) == 1) {
        _id_8CA33DA989AB6666 = getdvarint("dvar_B5E42DBEC5BF8CC3", 16443);

        if(_id_8CA33DA989AB6666 > 0) {
          thread _id_FD6C077D98FA4BE9(_id_8CA33DA989AB6666);
          _id_0293BA44C408FEF1::_id_CF013B45184BB054(self, _id_8CA33DA989AB6666);
        }
      } else {
        _id_0B9C95D2F33C0D8B = _id_CE68631570796A41();

        if(isDefined(_id_0B9C95D2F33C0D8B)) {
          thread _id_408B1B8364D0E722(_id_0B9C95D2F33C0D8B);
          _id_0293BA44C408FEF1::_id_CF013B45184BB054(self, _id_0B9C95D2F33C0D8B);
        }
      }
    }
  }

  scripts\mp\codcasterclientmatchdata::_id_9B229B18B0750BAD();

  if(self _meth_8420670EAFC8D391() && getdvarint("dvar_2745598E35A47913") == 1) {
    _id_C9C655687BD338B8 = int(floor(scripts\mp\utility\game::_id_4C8FF40F12C474E9() / 1000));
    self setclientomnvar("ui_total_game_time", _id_C9C655687BD338B8);
  }

  if(istrue(level.flashpointactive))
    thread scripts\mp\flashpoint::flashpoint_trackplayerevents(self);

  if(_id_7EC298E587EB6719) {
    scripts\mp\persistence::statsetchildbuffered("round", "timePlayed", 0, 1);
    self setplayerdata("common", "round", "totalXp", 0);
    scripts\cp_mp\utility\game_utility::startkeyearning();

    if(!isDefined(game["uniquePlayerCount"]))
      game["uniquePlayerCount"] = 1;
    else
      game["uniquePlayerCount"]++;
  }

  self.clientid = self.pers["clientid"];
  self.pers["teamKillPunish"] = 0;
  logprint("J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\n");

  if(analyticsstreamerislogfilestreamingenabled())
    analyticsstreamerlogfilewritetobuffer("J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\n");

  self logstatmatchguid();

  if(getdvarint("online_matchdata_enabled") != 0) {
    _id_D12A341B40354143 = getmatchdata("commonMatchData", "player_count");

    if(_id_7EC298E587EB6719) {
      _id_D12A341B40354143++;
      setmatchdata("commonMatchData", "player_count", _id_D12A341B40354143);
    }

    if(isbot(self) || istestclient(self) || isai(self))
      _id_292E9342321C9151 = 1;
    else
      _id_292E9342321C9151 = 0;

    if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::denysystemicteamchoice() && !_id_292E9342321C9151) {}
  }

  if(_id_7EC298E587EB6719)
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_player_first_connect", self);

  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_player_connect", self);

  if(level.uniqueplayersconnected <= getmaxnumplayerslogging()) {
    if(_id_7EC298E587EB6719 && isDefined(level.matchrecording_logeventplayername))
      [[level.matchrecording_logeventplayername]](self.clientid, self.team, self.name);
  }

  if(_id_7EC298E587EB6719)
    _id_04CDABCD91A92977::_id_342AF7EA8A120B16();

  if(!level.teambased)
    game["roundsWon"][self.guid] = 0;

  if(!isDefined(self.pers["cur_kill_streak"]))
    self.pers["cur_kill_streak"] = 0;

  if(!isDefined(self.pers["cur_death_streak"]))
    self.pers["cur_death_streak"] = 0;

  if(level.onlinestatsenabled)
    self.bestlifetimekillstreak = scripts\mp\playerstats_interface::getplayerstat("bestStats", "killStreak");

  self.lastgrenadesuicidetime = -1;
  self.hasspawned = 0;
  self.waitingtospawn = 0;
  self.wantsafespawn = 0;
  self.wasaliveatmatchstart = 0;
  self.movespeedscaler = 1;
  self.objectivescaler = 1;
  self.killcountthislife = 0;
  resetuidvarsonconnect();
  self.lifeid = 0;

  if(isDefined(self.pers["deaths"]))
    self.lifeid = self.pers["deaths"];

  waittillframeend;
  level.players[level.players.size] = self;
  level.playersbyentitynumber[self getentitynumber()] = self;
  scripts\cp_mp\utility\game_utility::addtoparticipantsarray();
  scripts\cp_mp\utility\game_utility::addtocharactersarray();
  scripts\cp_mp\utility\player_utility::addtodismembermentlist();

  if(game["state"] == "postgame") {
    self.connectedpostgame = 1;
    self setclientdvars("cg_drawSpectatorMessages", 0);
    self visionsetfadetoblackforplayer("", 0.25);
    spawnintermission();
    return;
  }

  if(_id_7EC298E587EB6719 && (scripts\mp\utility\game::gettimepassed() >= 60000 || game["roundsPlayed"] > 0))
    self.joinedinprogress = 1;

  if(isai(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["think"]))
    self thread[[level.bot_funcs["think"]]]();

  level endon("game_ended");

  if(isDefined(level.hostmigrationtimer))
    thread scripts\mp\hostmigration::hostmigrationtimerthink();

  if(isDefined(level.onplayerconnectaudioinit))
    [[level.onplayerconnectaudioinit]]();

  thread scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_monitorplayerusability(self);
  thread scripts\cp_mp\vehicles\customization\battle_tracks::battle_tracks_monitorstandingonvehicles(self);
  thread scripts\cp_mp\vehicles\vehicle_interact::_id_356EA06606D08642(self);
  thread scripts\mp\perks\perkfunctions::markedentities_think();

  if(!isDefined(self.pers["team"])) {
    _id_C924752368853F99 = scripts\mp\utility\game::gettimepassed() / 1000 + 6;

    if(shouldshowwidemapshot(_id_C924752368853F99)) {
      _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
      spawnspectatormapcam();
      self lerpfovbypreset("default");
      self setclientomnvar("ui_mapshot_camera", 0);
      initclientdvarssplitscreenspecific();
      self.pers["team"] = "";
      self.team = "free";
    } else
      self visionsetfadetoblackforplayer("", 0.5);

    connect_validateplayerteam();

    if(isPlayer(self) && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      dlog_recordevent("dlog_event_br_player_connect", ["player_id", self.clientid, "player_name", self.name, "connect_time", int(gettime() / 1000)]);

    if(self _meth_8420670EAFC8D391())
      thread scripts\mp\menus::_id_9FF5C7531349CDFC();
    else if((isintournament() || scripts\mp\utility\game::privatematch()) && (self.sessionteam == "spectator" || self.sessionteam == "codcaster")) {
      self.pers["team"] = self.sessionteam;
      self.team = self.sessionteam;
      thread spawnspectator();
    } else if((scripts\mp\utility\game::matchmakinggame() || scripts\mp\utility\game::lobbyteamselectenabled()) && self.sessionteam != "none") {
      if(_id_CE91130A97F4C478)
        thread spawnspectator();

      if((getDvar("dvar_7611A2790A0BF7FE", "") == "dmz" || getDvar("dvar_7611A2790A0BF7FE", "") == "exgm" || getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk") && getdvarint("scr_br_manual_team_assignment", 0) == 1)
        thread scripts\mp\teams::persistantgametypeteamassign();
      else
        thread scripts\mp\menus::setteam(self.sessionteam, _id_7EC298E587EB6719);

      if(!scripts\mp\flags::gameflag("infil_will_run") && getdvarint("dvar_7958073A99A0D67E", 1) == 1 && scripts\mp\utility\game::getgametype() == "gwtdm")
        thread scripts\mp\spawncamera::startspawncamera();
      else if((scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict") && istrue(level._id_A6954A050D77D75C)) {
        if(isDefined(level.spawnselectionlocations) && isDefined(level._id_6121D66FFC5B8EC9[self.team])) {
          _id_14A780F439CFFF1D = level.spawnselectionlocations[level._id_6121D66FFC5B8EC9[self.team]][self.team].origin;
          thread _id_2CEDCC356F1B9FC8::playerstreamhintlocation(_id_14A780F439CFFF1D, 0, undefined, undefined, -1);
        }
      }

      if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
        if(getdvarint("dvar_206A763969420CE0", 0) == 1 && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() != "dmz" && scripts\mp\utility\game::getsubgametype() != "exgm" && scripts\mp\utility\game::getsubgametype() != "plunder" && scripts\mp\utility\game::getsubgametype() != "risk" && scripts\mp\utility\game::getsubgametype() != "sandbox" && scripts\mp\utility\game::getsubgametype() != "rumble_mgl") {
          _id_891D91911E4C1ADE = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
          scripts\mp\utility\script::demoforcesre("Callback_PlayerConnect() elseif MMG " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + _id_891D91911E4C1ADE);
        }

        if(!istrue(self._id_10844DDCB34694EE) && getdvarint("dvar_89556297EAAB6B6A", 0) == 0)
          self setclientomnvar("ui_options_menu", 2);
      }

      if(!scripts\mp\utility\game::runleanthreadmode() && scripts\mp\utility\game::matchmakinggame() && !getdvarint("dvar_9B383028DFD6542D", 0))
        thread kickifdontspawn();

      clearpinnedobjectives();
      return;
    } else {
      if(_id_CE91130A97F4C478)
        thread spawnspectator();

      scripts\mp\menus::autoassign();

      if(!scripts\mp\flags::gameflag("infil_will_run") && getdvarint("dvar_7958073A99A0D67E", 1) == 1 && scripts\mp\utility\game::getgametype() == "gwtdm")
        thread scripts\mp\spawncamera::startspawncamera();
      else if((scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict") && istrue(level._id_A6954A050D77D75C)) {
        if(isDefined(level.spawnselectionlocations) && isDefined(level._id_6121D66FFC5B8EC9[self.team])) {
          _id_14A780F439CFFF1D = level.spawnselectionlocations[level._id_6121D66FFC5B8EC9[self.team]][self.team].origin;
          thread _id_2CEDCC356F1B9FC8::playerstreamhintlocation(_id_14A780F439CFFF1D, 0, undefined, undefined, -1);
        }
      }

      if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
        if(getdvarint("dvar_206A763969420CE0", 0) == 1 && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() != "dmz" && scripts\mp\utility\game::getsubgametype() != "exgm" && scripts\mp\utility\game::getsubgametype() != "plunder" && scripts\mp\utility\game::getsubgametype() != "risk" && scripts\mp\utility\game::getsubgametype() != "sandbox" && scripts\mp\utility\game::getsubgametype() != "rumble_mgl") {
          _id_891D91911E4C1ADE = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
          scripts\mp\utility\script::demoforcesre("Callback_PlayerConnect() else " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + _id_891D91911E4C1ADE);
        }

        if(!istrue(self._id_10844DDCB34694EE) && getdvarint("dvar_89556297EAAB6B6A", 0) == 0)
          self setclientomnvar("ui_options_menu", 2);
      }

      if(!scripts\mp\utility\game::runleanthreadmode() && scripts\mp\utility\game::matchmakinggame())
        thread kickifdontspawn();

      clearpinnedobjectives();
      return;
    }
  } else {
    self visionsetfadetoblackforplayer("", 0.5);
    connect_validateplayerteam();
    playerteam = self.pers["team"];

    if(scripts\mp\utility\game::matchmakinggame() && !isbot(self) && !istestclient(self) && !self _meth_8420670EAFC8D391() && getdvarint("team_consistency_fix"))
      playerteam = self.sessionteam;

    scripts\mp\menus::addtoteam(playerteam, 1);
    thread _id_76CC264B397DB9CB::setsquad(playerteam);

    if(self _meth_8420670EAFC8D391()) {
      thread spawnspectator();
      clearpinnedobjectives();
      return;
    }

    if(scripts\mp\class::isvalidclass(self.pers["class"]) && playerteam != "spectator") {
      thread spawnclient();
      clearpinnedobjectives();
      return;
    }

    thread spawnspectator();

    if(self.pers["team"] == "spectator") {
      if(scripts\mp\utility\game::doesmodesupportplayerteamchoice() && !istrue(self.pers["playerChoseSpectatorTeam"]))
        scripts\mp\menus::beginteamchoice();
    } else
      scripts\mp\menus::beginclasschoice();
  }

  clearpinnedobjectives();
}

callback_playermigrated() {
  if(isDefined(self.connected) && self.connected)
    scripts\mp\utility\game::updateobjectivetext();

  if(self ishost())
    initclientdvarssplitscreenspecific();

  _id_B287376C626B75B6 = 0;

  foreach(player in level.players) {
    if(!isbot(player) && !istestclient(player))
      _id_B287376C626B75B6++;
  }

  if(!isbot(self) && !istestclient(self)) {
    level.hostmigrationreturnedplayercount++;

    if(level.hostmigrationreturnedplayercount >= _id_B287376C626B75B6 * 2 / 3)
      level notify("hostmigration_enoughplayers");
  }
}

_id_556228E50FF920D9() {
  thread _id_04CDABCD91A92977::_id_59121677F31F75A5();
}

_id_5C9544EF10CB9E0C(_id_401C3A2E68AAB0FD) {
  _id_04CDABCD91A92977::_id_8CF8FF669AC52156(_id_401C3A2E68AAB0FD, 1);
}

_id_2A643088582C8BE3(_id_4B86A4E17C656399, progress, _id_0ABC57BB73D4BF1A) {
  _id_04CDABCD91A92977::_id_A1B2DC3090437789(_id_4B86A4E17C656399, progress, _id_0ABC57BB73D4BF1A);
  _id_0FD32F08E72B657F::_id_59A736FFFDDC7C05(_id_4B86A4E17C656399, progress, _id_0ABC57BB73D4BF1A);
}

addlevelstoexperience(_id_10E595A04A4B748D, levels) {
  _id_00AE17C5A8B1BC1B = scripts\mp\rank::getrankforxp(_id_10E595A04A4B748D);
  minxp = scripts\mp\rank::getrankinfominxp(_id_00AE17C5A8B1BC1B);
  maxxp = scripts\mp\rank::getrankinfomaxxp(_id_00AE17C5A8B1BC1B);
  _id_00AE17C5A8B1BC1B = _id_00AE17C5A8B1BC1B + (_id_10E595A04A4B748D - minxp) / (maxxp - minxp);
  _id_00AE17C5A8B1BC1B = _id_00AE17C5A8B1BC1B + levels;

  if(_id_00AE17C5A8B1BC1B < 0) {
    _id_00AE17C5A8B1BC1B = 0;
    _id_A176DCDA08E09243 = 0.0;
  } else if(_id_00AE17C5A8B1BC1B >= level.maxrank + 1.0) {
    _id_00AE17C5A8B1BC1B = level.maxrank;
    _id_A176DCDA08E09243 = 1.0;
  } else {
    _id_A176DCDA08E09243 = _id_00AE17C5A8B1BC1B - floor(_id_00AE17C5A8B1BC1B);
    _id_00AE17C5A8B1BC1B = int(floor(_id_00AE17C5A8B1BC1B));
  }

  minxp = scripts\mp\rank::getrankinfominxp(_id_00AE17C5A8B1BC1B);
  maxxp = scripts\mp\rank::getrankinfomaxxp(_id_00AE17C5A8B1BC1B);
  return int(_id_A176DCDA08E09243 * (maxxp - minxp)) + minxp;
}

forcespawn() {
  self endon("death_or_disconnect");
  self endon("spawned");
  wait 60.0;

  if(self.hasspawned) {
    return;
  }
  if(self.pers["team"] == "spectator" || self.pers["team"] == "codcaster") {
    return;
  }
  if(!scripts\mp\class::isvalidclass(self.pers["class"])) {
    self.pers["class"] = "CLASS/CUSTOM1";
    self.class = self.pers["class"];
  }

  thread spawnclient();
}

kickifdontspawn() {
  if(getdvarint("debug_stopafkcheck", 0) == 1) {
    return;
  }
  if(istrue(self.spawnedasspectator) && !mayspawn()) {
    return;
  }
  self endon("death_or_disconnect");
  self endon("spawned");
  self endon("attempted_spawn");
  wait_time = getdvarfloat("scr_kick_time", 90);
  min_time = getdvarfloat("scr_kick_mintime", 45);
  _id_6392BB56F874343F = getdvarfloat("scr_kick_hosttime", 120);
  starttime = gettime();

  if(self ishost())
    kickwait(_id_6392BB56F874343F);
  else
    kickwait(wait_time);

  _id_3B5803E733581858 = (gettime() - starttime) / 1000;

  if(_id_3B5803E733581858 < wait_time - 0.1 && _id_3B5803E733581858 < min_time) {
    return;
  }
  if(self.hasspawned) {
    return;
  }
  if(self.pers["team"] == "spectator" || self.pers["team"] == "codcaster") {
    return;
  }
  kick(self getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
  level thread[[level.updategameevents]]();
}

kickwait(waittime) {
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(waittime);
}

monitorvotekick() {
  level endon("game_ended");
  self endon("disconnect");

  for(self.votestokick = 0; self.votestokick < 2; self.votestokick++)
    self waittill("voteToKick");

  kick(self getentitynumber(), "EXE/PLAYERKICKED_TEAMKILLS");
}

fakevote() {
  wait 1.0;
  self notify("voteToKick");
  wait 3.0;
  self notify("voteToKick");
  wait 2.0;
  self notify("voteToKick");
}

totaldisttracking(spawnorigin) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned");
  self notify("distFromSpawnTracking");
  self endon("distFromSpawnTracking");
  _id_DABF4CF09B2C06CA = spawnorigin;

  if(!isDefined(level._id_808E471A357552A4)) {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      level._id_808E471A357552A4 = getdvarint("dvar_A1F0EAC17092B910", 240);
    else
      level._id_808E471A357552A4 = getdvarint("dvar_35EFFE41515EB6D1", 120);
  }

  if(!isDefined(level._id_4C3AB9EF59DE46C9))
    level._id_4C3AB9EF59DE46C9 = getdvarfloat("dvar_DBCA7DAD12FDB6DF", 100.0);

  if(!isDefined(level._id_BC1ACB66E7FA31BE))
    level._id_BC1ACB66E7FA31BE = getdvarint("dvar_25B5BAF9DB6AF062", 3000);

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    scripts\mp\flags::gameflagwait("prematch_done");
    _id_DABF4CF09B2C06CA = self.origin;
  }

  _id_C6500DFC575DC550 = 0;
  _id_17915DB3DE174953 = 0;
  _id_F76842485BABEE15 = 300;

  if(scripts\mp\utility\game::getgametype() == "arena" || scripts\mp\utility\game::getgametype() == "infect")
    _id_F76842485BABEE15 = 50;
  else if(level._id_EC2FB549B15AD827)
    _id_F76842485BABEE15 = 50;

  for(;;) {
    message = scripts\engine\utility::waittill_any_timeout_5(2.0, "death", "vehicle_enter", "vehicle_change_seat", "vehicle_exit", "afk_tracking_resume");

    if(message == "vehicle_exit" && !isDefined(self.lastvehicleseatchangetime)) {
      continue;
    }
    if(istrue(self.ignoreafkcheck) || istrue(self._id_0CBECE90C5BEEA82)) {
      continue;
    }
    if(message == "afk_tracking_resume") {
      _id_DABF4CF09B2C06CA = self.origin;
      continue;
    }

    if(!isDefined(self.pers["totalDistTraveled"]))
      scripts\mp\utility\stats::initpersstat("totalDistTraveled");

    if(!isDefined(self.pers["totalDistTraveledAFK"]))
      scripts\mp\utility\stats::initpersstat("totalDistTraveledAFK");

    if(!isDefined(_id_DABF4CF09B2C06CA))
      _id_DABF4CF09B2C06CA = self.origin;

    dist = distance(_id_DABF4CF09B2C06CA, self.origin);

    if(isDefined(level._id_4C3AB9EF59DE46C9) && level._id_4C3AB9EF59DE46C9 > 0) {
      if(dist < level._id_4C3AB9EF59DE46C9)
        dist = 0;
    }

    scripts\mp\utility\stats::incpersstat("totalDistTraveled", dist);
    scripts\mp\utility\stats::incpersstat("totalDistTraveledAFK", dist);

    if(isDefined(scripts\mp\utility\stats::getpersstat("distanceTraveledInVehicle")) && (message == "vehicle_exit" || isDefined(self.vehicle)))
      scripts\mp\utility\stats::incpersstat("distanceTraveledInVehicle", dist);

    if(message == "vehicle_enter") {
      _id_17915DB3DE174953 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self);
      self.lastvehicleseatchangetime = gettime();
    }

    if(message == "vehicle_change_seat")
      _id_17915DB3DE174953 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self);

    if(_id_C6500DFC575DC550 != _id_17915DB3DE174953 || message == "vehicle_exit") {
      if(isDefined(self.lastvehicleseatchangetime)) {
        starttime = self.lastvehicleseatchangetime;
        time = (gettime() - starttime) / 1000;

        if(_id_C6500DFC575DC550) {
          if(isDefined(scripts\mp\utility\stats::getpersstat("timeSpentAsDriver")))
            scripts\mp\utility\stats::incpersstat("timeSpentAsDriver", time);
        } else if(isDefined(scripts\mp\utility\stats::getpersstat("timeSpentAsPassenger")))
          scripts\mp\utility\stats::incpersstat("timeSpentAsPassenger", time);
      }
    }

    if(message == "vehicle_enter" || message == "vehicle_change_seat")
      _id_C6500DFC575DC550 = _id_17915DB3DE174953;

    if(message == "vehicle_change_seat")
      self.lastvehicleseatchangetime = gettime();

    _id_DABF4CF09B2C06CA = self.origin;

    if(self.pers["totalDistTraveledAFK"] > _id_F76842485BABEE15)
      _id_E636E108DFFE6AB7();
    else if(dist > 0)
      self._id_03681793BFD7B68E = gettime() + level._id_BC1ACB66E7FA31BE;

    if(istrue(self.pers["distTrackingPassedOrResetTime"]) && _id_48C5A587383A90E7()) {
      _id_A0B3C6B277C1A146 = scripts\mp\teams::_id_19300ABFBB10928B();

      if(_id_A0B3C6B277C1A146 - self.pers["distTrackingPassedOrResetTime"] > level._id_808E471A357552A4) {
        self.pers["distTrackingPassed"] = 0;
        self.pers["totalDistTraveledAFK"] = 0;
        self._id_CB9581FC7FF5F394 = undefined;
      }
    }

    scripts\mp\utility\stats::incpersstat("averageAltitude", self.origin[2]);
    scripts\mp\utility\stats::incpersstat("averageAltitudeCount", 1);
  }
}

_id_E636E108DFFE6AB7() {
  self.pers["distTrackingPassed"] = 1;
  self.pers["totalDistTraveledAFK"] = 0;
  self.pers["distTrackingPassedOrResetTime"] = scripts\mp\teams::_id_19300ABFBB10928B();
  self._id_03681793BFD7B68E = undefined;
}

initleanplayerstats() {
  if(!isDefined(self.pers["deaths"])) {
    scripts\mp\utility\stats::initpersstat("deaths");
    scripts\mp\persistence::statsetchild("round", "deaths", 0);
  }

  self.deaths = scripts\mp\utility\stats::getpersstat("deaths");
  scripts\mp\utility\stats::initleaderboardstat("deaths");

  if(!isDefined(self.pers["score"])) {
    scripts\mp\utility\stats::initpersstat("score");
    scripts\mp\persistence::statsetchild("round", "score", 0);
  }

  self.score = scripts\mp\utility\stats::getpersstat("score");
  scripts\mp\utility\stats::initleaderboardstat("score");

  if(!isDefined(self.pers["kills"])) {
    scripts\mp\utility\stats::initpersstat("kills");
    scripts\mp\persistence::statsetchild("round", "kills", 0);
  }

  self.kills = scripts\mp\utility\stats::getpersstat("kills");
  scripts\mp\utility\stats::initleaderboardstat("kills");
}

initplayerstats() {
  scripts\mp\playerstats::initplayer();
  scripts\mp\persistence::initbufferedstats();

  if(!isDefined(self.leaderboarddata))
    self.leaderboarddata = [];

  initleanplayerstats();

  if(!isDefined(self.pers["suicides"]))
    scripts\mp\utility\stats::initpersstat("suicides");

  scripts\mp\utility\stats::initleaderboardstat("suicides");

  if(!isDefined(self.pers["headshots"]))
    scripts\mp\utility\stats::initpersstat("headshots");

  scripts\mp\utility\stats::initleaderboardstat("headshots");

  if(!isDefined(self.pers["executions"]))
    scripts\mp\utility\stats::initpersstat("executions");

  if(!isDefined(self.pers["assists"])) {
    scripts\mp\utility\stats::initpersstat("assists");
    scripts\mp\persistence::statsetchild("round", "assists", 0);
  }

  self.assists = scripts\mp\utility\stats::getpersstat("assists");
  scripts\mp\utility\stats::initleaderboardstat("assists");

  if(!isDefined(self.pers["captures"])) {
    scripts\mp\utility\stats::initpersstat("captures");
    scripts\mp\persistence::statsetchild("round", "captures", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("captures", scripts\cp_mp\challenges::_id_4FB61D33F02E8203);

  if(!isDefined(self.pers["returns"])) {
    scripts\mp\utility\stats::initpersstat("returns");
    scripts\mp\persistence::statsetchild("round", "returns", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("returns");

  if(!isDefined(self.pers["defends"])) {
    scripts\mp\utility\stats::initpersstat("defends");
    scripts\mp\persistence::statsetchild("round", "defends", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("defends");

  if(!isDefined(self.pers["plants"])) {
    scripts\mp\utility\stats::initpersstat("plants");
    scripts\mp\persistence::statsetchild("round", "plants", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("plants");

  if(!isDefined(self.pers["defuses"])) {
    scripts\mp\utility\stats::initpersstat("defuses");
    scripts\mp\persistence::statsetchild("round", "defuses", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("defuses");

  if(!isDefined(self.pers["destructions"])) {
    scripts\mp\utility\stats::initpersstat("destructions");
    scripts\mp\persistence::statsetchild("round", "destructions", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("destructions");

  if(!isDefined(self.pers["confirmed"])) {
    scripts\mp\utility\stats::initpersstat("confirmed");
    scripts\mp\persistence::statsetchild("round", "confirmed", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("confirmed", scripts\cp_mp\challenges::_id_58E830149FCB9A1E);

  if(!isDefined(self.pers["denied"])) {
    scripts\mp\utility\stats::initpersstat("denied");
    scripts\mp\persistence::statsetchild("round", "denied", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("denied");

  if(!isDefined(self.pers["rescues"])) {
    scripts\mp\utility\stats::initpersstat("rescues");
    scripts\mp\persistence::statsetchild("round", "rescues", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("rescues");

  if(!isDefined(self.pers["touchdowns"])) {
    scripts\mp\utility\stats::initpersstat("touchdowns");
    scripts\mp\persistence::statsetchild("round", "touchdowns", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("touchdowns");

  if(!isDefined(self.pers["fieldgoals"])) {
    scripts\mp\utility\stats::initpersstat("fieldgoals");
    scripts\mp\persistence::statsetchild("round", "fieldgoals", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("fieldgoals");

  if(!isDefined(self.pers["killChains"])) {
    scripts\mp\utility\stats::initpersstat("killChains");
    scripts\mp\persistence::statsetchild("round", "killChains", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("killChains");

  if(!isDefined(self.pers["killsAsSurvivor"])) {
    scripts\mp\utility\stats::initpersstat("killsAsSurvivor");
    scripts\mp\persistence::statsetchild("round", "killsAsSurvivor", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("killsAsSurvivor");

  if(!isDefined(self.pers["killsAsInfected"])) {
    scripts\mp\utility\stats::initpersstat("killsAsInfected");
    scripts\mp\persistence::statsetchild("round", "killsAsInfected", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("killsAsInfected");

  if(!isDefined(self.pers["teamkills"]))
    scripts\mp\utility\stats::initpersstat("teamkills");

  scripts\mp\utility\stats::initleaderboardstat("teamkills");

  if(!isDefined(self.pers["teamdamage"]))
    scripts\mp\utility\stats::initpersstat("teamdamage");

  if(!isDefined(self.pers["extrascore0"]))
    scripts\mp\utility\stats::initpersstat("extrascore0");

  scripts\mp\utility\stats::initleaderboardstat("extrascore0");

  if(!isDefined(self.pers["extrascore1"]))
    scripts\mp\utility\stats::initpersstat("extrascore1");

  scripts\mp\utility\stats::initleaderboardstat("extrascore1");

  if(!isDefined(self.pers["stabs"])) {
    scripts\mp\utility\stats::initpersstat("stabs");
    scripts\mp\persistence::statsetchild("round", "stabs", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("stabs");

  if(!isDefined(self.pers["setbacks"])) {
    scripts\mp\utility\stats::initpersstat("setbacks");
    scripts\mp\persistence::statsetchild("round", "setbacks", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("setbacks");

  if(!isDefined(self.pers["objTime"])) {
    scripts\mp\utility\stats::initpersstat("objTime");
    scripts\mp\persistence::statsetchild("round", "objTime", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("objTime");

  if(!isDefined(self.pers["gamemodeScore"])) {
    scripts\mp\utility\stats::initpersstat("gamemodeScore");
    scripts\mp\persistence::statsetchild("round", "gamemodeScore", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("gamemodeScore");

  if(!isDefined(self.pers["damage"])) {
    scripts\mp\utility\stats::initpersstat("damage");
    scripts\mp\persistence::statsetchild("round", "damage", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("damage", scripts\cp_mp\challenges::_id_73317C391C8E6D10);

  if(!isDefined(self.pers["supersEarned"]))
    scripts\mp\utility\stats::initpersstat("supersEarned");

  scripts\mp\utility\stats::initleaderboardstat("supersEarned");

  if(!isDefined(self.pers["downs"])) {
    scripts\mp\utility\stats::initpersstat("downs");
    scripts\mp\persistence::statsetchild("round", "downs", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("downs");

  if(!isDefined(self.pers["contracts"])) {
    scripts\mp\utility\stats::initpersstat("contracts");
    scripts\mp\persistence::statsetchild("round", "contracts", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("contracts");

  if(!isDefined(self.pers["wins"]))
    scripts\mp\utility\stats::initpersstat("wins");

  scripts\mp\utility\stats::initleaderboardstat("wins");

  if(!isDefined(self.pers["topFive"]))
    scripts\mp\utility\stats::initpersstat("topFive");

  scripts\mp\utility\stats::initleaderboardstat("topFive");

  if(!isDefined(self.pers["topTen"]))
    scripts\mp\utility\stats::initpersstat("topTen");

  scripts\mp\utility\stats::initleaderboardstat("topTen");

  if(!isDefined(self.pers["topTwentyFive"]))
    scripts\mp\utility\stats::initpersstat("topTwentyFive");

  scripts\mp\utility\stats::initleaderboardstat("topTwentyFive");

  if(!isDefined(self.pers["gamesPlayed"]))
    scripts\mp\utility\stats::initpersstat("gamesPlayed");

  scripts\mp\utility\stats::initleaderboardstat("gamesPlayed");

  if(!isDefined(self.pers["cash"]))
    scripts\mp\utility\stats::initpersstat("cash");

  scripts\mp\utility\stats::initleaderboardstat("cash");

  if(!isDefined(self.pers["eliteStarted"]))
    scripts\mp\utility\stats::initpersstat("eliteStarted");

  scripts\mp\utility\stats::initleaderboardstat("eliteStarted");

  if(!isDefined(self.pers["eliteCompleted"]))
    scripts\mp\utility\stats::initpersstat("eliteCompleted");

  scripts\mp\utility\stats::initleaderboardstat("eliteCompleted");

  if(!isDefined(self.pers["eliteBlocked"]))
    scripts\mp\utility\stats::initpersstat("eliteBlocked");

  scripts\mp\utility\stats::initleaderboardstat("eliteBlocked");

  if(!isDefined(self.pers["contribution"]))
    scripts\mp\utility\stats::initpersstat("contribution");

  scripts\mp\utility\stats::initleaderboardstat("contribution");

  if(!isDefined(self.pers["goals"]))
    scripts\mp\utility\stats::initpersstat("goals");

  scripts\mp\utility\stats::initleaderboardstat("goals");

  if(!isDefined(self.pers["segmentCaptures"])) {
    scripts\mp\utility\stats::initpersstat("segmentCaptures");
    scripts\mp\persistence::statsetchild("round", "segmentCaptures", 0);
  }

  scripts\mp\utility\stats::initleaderboardstat("segmentCaptures");

  if(!isDefined(self.pers["highestMultikill"]))
    scripts\mp\utility\stats::initpersstat("highestMultikill");

  if(!isDefined(self.pers["untradedDeaths"]))
    scripts\mp\utility\stats::initpersstat("untradedDeaths");

  if(!isDefined(self.pers["tradedKills"]))
    scripts\mp\utility\stats::initpersstat("tradedKills");

  if(!isDefined(self.pers["tradedDeaths"]))
    scripts\mp\utility\stats::initpersstat("tradedDeaths");

  if(!isDefined(self.pers["hvtKills"]))
    scripts\mp\utility\stats::initpersstat("hvtKills");

  scripts\mp\utility\stats::initleaderboardstat("hvtKills");

  if(!isDefined(self.pers["teamKillPunish"]))
    self.pers["teamKillPunish"] = 0;

  scripts\mp\utility\stats::initpersstat("longestStreak");
  scripts\mp\utility\stats::initleaderboardstat("longestStreak");
  self.pers["lives"] = scripts\mp\utility\game::getgametypenumlives();
  scripts\mp\persistence::statsetchild("round", "killStreak", 0);
  scripts\mp\persistence::statsetchild("round", "loss", 0);
  scripts\mp\persistence::statsetchild("round", "win", 0);
  scripts\mp\persistence::statsetchild("round", "scoreboardType", "none");
  scripts\mp\utility\stats::initleaderboardstat("killStreak");
  scripts\mp\utility\stats::initleaderboardstat("loss");
  scripts\mp\utility\stats::initleaderboardstat("win");
}

addtoteamcount(_id_C65FD3B0828B5D9B) {
  thread scripts\mp\utility\teams::addplayertoteam(self, self.team, _id_C65FD3B0828B5D9B);
  [[level.updategameevents]]();
}

removefromteamcount() {
  scripts\mp\utility\teams::removeplayerfromteam(self, self.team);
}

addtoalivecount(context) {
  _id_DA533FD7EBA790E5 = self.team;

  if(!(isDefined(self.alreadyaddedtoalivecount) && self.alreadyaddedtoalivecount)) {
    scripts\mp\utility\teams::modifyteamdata(_id_DA533FD7EBA790E5, "hasSpawned", 1);
    incrementalivecount(_id_DA533FD7EBA790E5, undefined, context);
  }

  self.alreadyaddedtoalivecount = undefined;
  _id_1F7BCAA53CA6D399 = 0;

  foreach(_id_F90358454413407F in level.teamnamelist)
  _id_1F7BCAA53CA6D399 = _id_1F7BCAA53CA6D399 + scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount");

  if(_id_1F7BCAA53CA6D399 > level.maxplayercount)
    level.maxplayercount = _id_1F7BCAA53CA6D399;
}

incrementalivecount(_id_DA533FD7EBA790E5, _id_28335DE6505D7E0C, context) {
  scripts\mp\utility\teams::addtoteamlives(self, _id_DA533FD7EBA790E5, _id_28335DE6505D7E0C, context);
  [[level.updategameevents]]();
}

removefromalivecount(disconnected, context) {
  _id_151277B69C5F6F70 = self.pers["lives"];
  _id_28335DE6505D7E0C = scripts\mp\utility\game::getgametypenumlives() != 0 && _id_151277B69C5F6F70 == 0 && !istrue(level.skipplaybodycountsound);
  self notify("remove_from_alive_count");
  _id_F559615FEC1D7733 = self.team;

  if(isDefined(self.switching_teams) && self.switching_teams && isDefined(self.joining_team) && self.joining_team == self.team)
    _id_F559615FEC1D7733 = self.leaving_team;

  if(isDefined(disconnected) && scripts\mp\utility\game::getgametype() != "control")
    removeallfromlivescount();
  else if(isDefined(self.switching_teams)) {
    if(!level.ingraceperiod || self.hasdonecombat) {
      scripts\mp\utility\teams::modifyteamdata(_id_F559615FEC1D7733, "hasSpawned", -1);

      if(_id_151277B69C5F6F70 && scripts\mp\utility\game::getgametype() != "control")
        self.pers["lives"]--;
    }
  }

  decrementalivecount(_id_F559615FEC1D7733, _id_28335DE6505D7E0C, context);
}

decrementalivecount(_id_F559615FEC1D7733, _id_28335DE6505D7E0C, context) {
  scripts\mp\utility\teams::removefromteamlives(self, _id_F559615FEC1D7733, _id_28335DE6505D7E0C, context);
  [[level.updategameevents]]();
}

addtolivescount() {
  scripts\mp\utility\teams::modifyteamdata(self.team, "livesCount", self.pers["lives"]);
}

removefromlivescount() {
  scripts\mp\utility\teams::setteamdata(self.team, "livesCount", int(max(0, scripts\mp\utility\teams::getteamdata(self.team, "livesCount") - 1)));
}

removeallfromlivescount() {
  scripts\mp\utility\teams::setteamdata(self.team, "livesCount", int(max(0, scripts\mp\utility\teams::getteamdata(self.team, "livesCount") - self.pers["lives"])));
}

resetuiomnvarscommon() {
  if(isDefined(level.resetuiomnvargamemode))
    [[level.resetuiomnvargamemode]]();

  self setclientomnvar("ui_objective_pinned_text_param", 0);
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_reviver_id", -1);
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_edge_glow", 0);
  self setclientomnvar("ui_life_kill_count", 0);
}

resetuidvarsonconnect() {
  resetuiomnvarscommon();
  self setclientdvar("ui_eyes_on_end_milliseconds", 0);
  scripts\mp\hud_message::_id_F004EF4606B9EFDC("hide_match_hint");
  self setclientomnvar("post_game_state", 0);

  if(scripts\mp\flags::gameflag("prematch_done"))
    self setclientomnvar("ui_match_in_progress", 1);
  else
    self setclientomnvar("ui_match_in_progress", 0);
}

resetuidvarsonspectate() {
  resetuiomnvarscommon();
  self setclientdvar("ui_eyes_on_end_milliseconds", 0);
}

clearpinnedobjectives() {
  if(isbot(self)) {
    return;
  }
  if(isDefined(level.objectives)) {
    foreach(objective in level.objectives) {
      if(isDefined(objective.objidnum))
        scripts\mp\objidpoolmanager::objective_unpin_player(objective.objidnum, self, objective.showoncompass);
    }
  }

  if(isDefined(level.uncapturableobjectives)) {
    foreach(objective in level.uncapturableobjectives) {
      if(isDefined(objective.objidnum))
        scripts\mp\objidpoolmanager::objective_unpin_player(objective.objidnum, self, objective.showoncompass);
    }
  }
}

watchtargethealth() {
  self endon("death_or_disconnect");
  self.targethealthinfo = [];

  for(;;) {
    tracestart = (self.origin[0], self.origin[1], self.origin[2] + 64);
    _id_3C70A7175FBFA3FC = self getplayerangles();
    _id_898F508242FA99F6 = anglesToForward(_id_3C70A7175FBFA3FC);
    _id_8B39E5984DA1FFAF = tracestart + _id_898F508242FA99F6 * 10000;
    results = scripts\engine\trace::_bullet_trace(tracestart, _id_8B39E5984DA1FFAF, 1, self, 0, 0, 0, 0, 0);
    _id_9595F9643C69A295 = results["entity"];

    if(isDefined(_id_9595F9643C69A295) && isPlayer(_id_9595F9643C69A295) && _id_9595F9643C69A295.team != self.team) {
      if(isDefined(_id_9595F9643C69A295))
        updatetargethealthvariable("ui_target_health", _id_9595F9643C69A295.health);

      if(isDefined(_id_9595F9643C69A295))
        updatetargethealthvariable("ui_target_max_health", _id_9595F9643C69A295.maxhealth);

      if(isDefined(_id_9595F9643C69A295))
        updatetargethealthvariable("ui_target_entity_num", _id_9595F9643C69A295 getentitynumber());
    } else
      updatetargethealthvariable("ui_target_entity_num", -1);

    wait 0.1;
  }
}

updatetargethealthvariable(_id_E9D476A3809CB3F1, value) {
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(value)) {
    return;
  }
  if(!isDefined(self.targethealthinfo[_id_E9D476A3809CB3F1]) || value != self.targethealthinfo[_id_E9D476A3809CB3F1]) {
    self setclientomnvar(_id_E9D476A3809CB3F1, value);
    self.targethealthinfo[_id_E9D476A3809CB3F1] = value;
  }
}

showgamemodeobjectivetext() {
  if(self.hasspawned) {
    return;
  }
  if(!showmatchhint()) {
    return;
  }
  if(scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }
  scripts\mp\flags::gameflagwait("prematch_done");
  self endon("disconnect");
  wait 1.0;

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.pers["team"])) {
    return;
  }
  _id_A369F87F8A7A9868 = self.pers["team"];
  hintmessage = scripts\mp\utility\game::getobjectivehinttext(_id_A369F87F8A7A9868);

  if(isDefined(hintmessage)) {
    _id_FE8F7703F6313ED4 = 0;

    if(game["defenders"] == _id_A369F87F8A7A9868)
      _id_FE8F7703F6313ED4 = 1;

    self setclientomnvar("ui_objective_text", _id_FE8F7703F6313ED4);
    wait 6;
    self setclientomnvar("ui_objective_text", -1);
  }
}

_id_155C4AAA1DAE57E6() {
  scripts\mp\flags::gameflagwait("prematch_done");
  _id_6A5D3BF7A5B7064A::onexitdeathsdoor(0);
}

showmatchhint() {
  gametype = scripts\mp\utility\game::getgametype();

  switch (gametype) {
    case "arena":
      if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] > 0)
        return 0;

      break;
    default:
      break;
  }

  return 1;
}

trydisableminimap() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && istrue(game["inLiveLobby"])) {
    return;
  }
  if(scripts\mp\utility\player::alwaysshowminimap()) {
    return;
  }
  if(!istrue(self.showuavminimaponspawn) && !scripts\mp\utility\perk::_hasperk("specialty_always_minimap"))
    scripts\mp\utility\player::hideminimap(1);

  self.showuavminimaponspawn = 0;
}

initinputtypewatcher() {
  self.gamepadwasenabled = scripts\engine\utility::is_player_gamepad_enabled();
}

managerespawnfade(_id_AD4DD16F29E24B77, _id_DFAB0807D83A77FE) {
  self endon("disconnect");

  if(istrue(self.respawnfade)) {
    return;
  }
  self.respawnfade = 1;
  self notify("fadeDown_start");

  if(!isDefined(_id_AD4DD16F29E24B77))
    _id_AD4DD16F29E24B77 = 0;

  _id_797B5F7FB23D24C3 = _id_AD4DD16F29E24B77;

  if(_id_797B5F7FB23D24C3 > 0) {
    _id_C8D49BBA66D8DB34 = 0.0;
    _id_67C7CB82CFC5EE69 = _id_797B5F7FB23D24C3 / level.framedurationseconds;
    _id_11B42FD8A12916AD = 1.0 / _id_67C7CB82CFC5EE69;
    _id_4A1830F604C82B9F = 0;

    while(_id_4A1830F604C82B9F < _id_67C7CB82CFC5EE69) {
      _id_4A1830F604C82B9F++;
      _id_C8D49BBA66D8DB34 = _id_C8D49BBA66D8DB34 + _id_11B42FD8A12916AD;
      _id_C8D49BBA66D8DB34 = clamp(_id_C8D49BBA66D8DB34, 0.0, 1.0);
      self setclientomnvar("ui_world_fade", _id_C8D49BBA66D8DB34);
      waitframe();
    }
  } else
    self setclientomnvar("ui_world_fade", 1.0);

  self notify("fadeDown_complete");
  _id_D2A2F36D8E05E3A6 = 0;

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    self waittill("spawned_player");
    _id_D2A2F36D8E05E3A6 = 1;
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  if(_id_D2A2F36D8E05E3A6)
    scripts\mp\utility\player::hidehudenable();

  wait 2.0;
  self notify("fadeUp_start");

  if(!isDefined(_id_DFAB0807D83A77FE))
    _id_DFAB0807D83A77FE = 0;

  _id_797B5F7FB23D24C3 = _id_DFAB0807D83A77FE;

  if(_id_797B5F7FB23D24C3 > 0) {
    _id_C8D49BBA66D8DB34 = 1.0;
    _id_67C7CB82CFC5EE69 = _id_797B5F7FB23D24C3 / level.framedurationseconds;
    _id_11B42FD8A12916AD = 1.0 / _id_67C7CB82CFC5EE69;
    _id_4A1830F604C82B9F = 0;

    while(_id_4A1830F604C82B9F < _id_67C7CB82CFC5EE69) {
      _id_4A1830F604C82B9F++;
      _id_C8D49BBA66D8DB34 = _id_C8D49BBA66D8DB34 - _id_11B42FD8A12916AD;
      _id_C8D49BBA66D8DB34 = clamp(_id_C8D49BBA66D8DB34, 0.0, 1.0);
      self setclientomnvar("ui_world_fade", _id_C8D49BBA66D8DB34);
      waitframe();
    }
  } else
    self setclientomnvar("ui_world_fade", 0.0);

  if(_id_D2A2F36D8E05E3A6)
    scripts\mp\utility\player::hidehuddisable();

  self.respawnfade = undefined;
  self notify("fadeUp_complete");
}

_id_48C5A587383A90E7() {
  if(isDefined(level._id_29F84151A47F0A35))
    return [[level._id_29F84151A47F0A35]]();

  return 1;
}

_id_CE68631570796A41() {
  _id_0B9C95D2F33C0D8B = undefined;

  if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1())
    _id_0B9C95D2F33C0D8B = getdvarint("dvar_04C90EF27A8730B6", 15919);
  else if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702())
    _id_0B9C95D2F33C0D8B = getdvarint("dvar_04C90EF27A8730B6", 9930);

  return _id_0B9C95D2F33C0D8B;
}

_id_408B1B8364D0E722(_id_0B9C95D2F33C0D8B) {
  self endon("disconnect");
  self waittillmatch("challengeProgress", _id_0B9C95D2F33C0D8B);
  self._id_D405F79D63134727 = self._id_3B3A45AF0209FF05[_id_0B9C95D2F33C0D8B].progress;

  if(isDefined(level._id_C83AA9DBC3654AFA) && isDefined(level._id_C83AA9DBC3654AFA._id_104F87CC51A1138D._id_E0D1E3A2B6F5323A)) {
    if(_id_728FFCEE8CBF30EE::_id_AEE3A8BE63DB5997(self))
      _id_728FFCEE8CBF30EE::_id_1B94D19475863421();
  }
}

_id_FD6C077D98FA4BE9(_id_8CA33DA989AB6666) {
  self endon("disconnect");
  self waittillmatch("challengeProgress", _id_8CA33DA989AB6666);
  _id_31FE93819B433368 = self._id_3B3A45AF0209FF05[_id_8CA33DA989AB6666].progress;
  scripts\cp_mp\challenges::initgameflags(_id_31FE93819B433368);
  self notify("game_flags_set");
}

_id_5C5F27D13E5EB129() {
  if(istrue(level.gameended)) {
    return;
  }
  self endon("disconnect");
  self endon("spawned_player");
  level endon("game_ended");
  self._id_3A8AB6F79EB16DD8 = undefined;
  self._id_CAEAE385D522AC4E = undefined;
  self._id_B1E84FE29DA97885 = undefined;

  for(;;) {
    self waittill("spectating_cycle_start", playertospectate);

    if(istrue(self.spectatekillcam)) {
      continue;
    }
    if(isDefined(playertospectate)) {
      if(!isDefined(self._id_B1E84FE29DA97885)) {
        _id_CB60F35D0E8977EB(1);
        thread _id_7F60FCD166830633();
        thread _id_A385F81E49ECDF52();
      }

      if(!scripts\mp\utility\player::isreallyalive(playertospectate)) {
        _id_CB60F35D0E8977EB(1);
        continue;
      }

      thread _id_C6D7A88859168573(playertospectate);
    }
  }
}

_id_C6D7A88859168573(playertospectate) {
  self endon("disconnect");
  self endon("spawned_player");
  level endon("game_ended");
  playertospectate endon("death_or_disconnect");
  self notify("removeSpectateBlackOnSpectateCycle");
  self endon("removeSpectateBlackOnSpectateCycle");
  self._id_3A8AB6F79EB16DD8 = playertospectate;
  self waittill("spectating_cycle");

  if(!isDefined(self._id_CAEAE385D522AC4E))
    level thread scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 0, 0.25);

  self._id_3A8AB6F79EB16DD8 = undefined;
  self._id_CAEAE385D522AC4E = playertospectate;
  thread _id_5BE55501B268C019();
}

_id_5BE55501B268C019() {
  self endon("disconnect");
  self endon("spawned_player");
  level endon("game_ended");
  self notify("watchForCurrentSpectateClientDeathOrDisconnect");
  self endon("watchForCurrentSpectateClientDeathOrDisconnect");
  self._id_CAEAE385D522AC4E waittill("death_or_disconnect");
  _id_CB60F35D0E8977EB(0);
}

_id_CB60F35D0E8977EB(_id_5E0065A1DC2434B6) {
  self._id_3A8AB6F79EB16DD8 = undefined;
  self._id_CAEAE385D522AC4E = undefined;
  self._id_B1E84FE29DA97885 = 1;
  _id_797B5F7FB23D24C3 = scripts\engine\utility::ter_op(istrue(_id_5E0065A1DC2434B6), 0.0, 1.0);
  level thread scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 1, _id_797B5F7FB23D24C3);
}

_id_7F60FCD166830633() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("removeSpectateBlackOnSpawn");
  self endon("removeSpectateBlackOnSpawn");
  self waittill("spawned_player");
  level thread scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 0, 0.0);
}

_id_A385F81E49ECDF52() {
  self endon("disconnect");
  level waittill("game_ended");
  level thread scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 0, 0.0);
}