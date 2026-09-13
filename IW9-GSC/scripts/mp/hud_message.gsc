/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\hud_message.gsc
***********************************************/

init() {
  game["round_end"]["draw"] = 1;
  game["round_end"]["round_draw"] = 2;
  game["round_end"]["round_win"] = 3;
  game["round_end"]["round_loss"] = 4;
  game["round_end"]["victory"] = 5;
  game["round_end"]["defeat"] = 6;
  game["round_end"]["halftime"] = 7;
  game["round_end"]["overtime"] = 8;
  game["round_end"]["roundend"] = 9;
  game["round_end"]["intermission"] = 10;
  game["round_end"]["side_switch"] = 11;
  game["round_end"]["match_bonus"] = 12;
  game["round_end"]["tie"] = 13;
  game["round_end"]["spectator"] = 14;
  game["round_end"]["final_round"] = 15;
  game["round_end"]["match_point"] = 16;
  game["round_end"]["practice_round"] = 17;
  game["round_end"]["win_by_two"] = 18;
  game["end_reason"]["score_limit_reached"] = 1;
  game["end_reason"]["time_limit_reached"] = 2;
  game["end_reason"]["players_forfeited"] = 3;
  game["end_reason"]["target_destroyed"] = 4;
  game["end_reason"]["bomb_defused"] = 5;
  game["end_reason"]["rusf_eliminated"] = 6;
  game["end_reason"]["usmc_eliminated"] = 7;
  game["end_reason"]["sas_eliminated"] = 8;
  game["end_reason"]["zvir_eliminated"] = 9;
  game["end_reason"]["icorps_eliminated"] = 10;
  game["end_reason"]["grp9_eliminated"] = 11;
  game["end_reason"]["spetsnaz_forfeited"] = 12;
  game["end_reason"]["marines_forfeited"] = 13;
  game["end_reason"]["sas_forfeited"] = 14;
  game["end_reason"]["zvir_forfeited"] = 15;
  game["end_reason"]["icorps_forfeited"] = 16;
  game["end_reason"]["grp9_forfeited"] = 17;
  game["end_reason"]["enemies_eliminated"] = 18;
  game["end_reason"]["tie"] = 19;
  game["end_reason"]["objective_completed"] = 20;
  game["end_reason"]["objective_failed"] = 21;
  game["end_reason"]["switching_sides"] = 22;
  game["end_reason"]["round_limit_reached"] = 23;
  game["end_reason"]["ended_game"] = 24;
  game["end_reason"]["host_ended_game"] = 25;
  game["end_reason"]["loss_stat_prevented"] = 26;
  game["end_reason"]["time_to_beat_ctf_win"] = 27;
  game["end_reason"]["time_to_beat_ctf_loss"] = 28;
  game["end_reason"]["time_to_beat_uplink_win"] = 29;
  game["end_reason"]["time_to_beat_uplink_loss"] = 30;
  game["end_reason"]["nuke_end"] = 31;
  game["end_reason"]["enemies_forfeited"] = 32;
  game["end_reason"]["arena_time_health_win"] = 33;
  game["end_reason"]["arena_time_health_loss"] = 34;
  game["end_reason"]["arena_time_lives_win"] = 35;
  game["end_reason"]["arena_time_lives_loss"] = 36;
  game["end_reason"]["arena_otflag_completed"] = 37;
  game["end_reason"]["arena_otflag_failed"] = 38;
  game["end_reason"]["outpost_defended"] = 39;
  game["end_reason"]["practice_round_over"] = 40;
  game["end_reason"]["br_eliminated"] = 41;
  game["end_reason"]["cyber_tie"] = 42;
  game["end_reason"]["mercy_win"] = 43;
  game["end_reason"]["mercy_loss"] = 44;
  game["end_reason"]["blank"] = 45;
  game["end_reason"]["mlg_time_to_beat_ctf"] = 46;
  game["end_reason"]["mlg_time_to_beat_uplink"] = 47;
  game["end_reason"]["mlg_time_lives"] = 48;
  game["end_reason"]["mlg_time_health"] = 49;
  game["end_reason"]["mlg_eliminated"] = 50;
  game["end_reason"]["mlg_forfeited"] = 51;
  game["end_reason"]["siege_allflags_win"] = 52;
  game["end_reason"]["siege_allflags_loss"] = 53;
  game["end_reason"]["siege_flag_win"] = 54;
  game["end_reason"]["siege_flag_loss"] = 55;
  game["end_reason"]["arena_tournament_tie_win"] = 56;
  game["end_reason"]["arena_tournament_tie_loss"] = 57;
  game["end_reason"]["plunder_loss"] = 58;
  game["end_reason"]["plunder_win"] = 59;
  game["end_reason"]["enemy_forfeit"] = 60;
  game["end_reason"]["survivors_eliminated"] = 61;
  game["end_reason"]["siege_force_end"] = 62;
  game["end_reason"]["dom_force_end"] = 63;
  game["end_reason"]["ko_flag_win"] = 64;
  game["end_reason"]["ko_flag_loss"] = 65;
  game["end_reason"]["ko_flag_hold_win"] = 66;
  game["end_reason"]["ko_flag_hold_loss"] = 67;
  game["end_reason"]["ko_alive_count_win"] = 68;
  game["end_reason"]["ko_alive_count_loss"] = 69;
  game["end_reason"]["ko_draw_award_point"] = 70;
  game["end_reason"]["win_by_two_tie"] = 71;
  game["end_reason"]["all_hostage_extracted"] = 72;
  game["end_reason"]["mlg_otflag_captured"] = 73;
  game["end_reason"]["mlg_tournament_tie"] = 74;
  game["end_reason"]["team_defending_most_segments"] = 75;
  game["end_reason"]["team_defending_most_kills"] = 76;
  game["end_reason"]["team_defending"] = 77;
  game["end_reason"]["control_allzones_win"] = 78;
  game["end_reason"]["control_allzones_loss"] = 79;
  game["end_reason"]["mlg_allzones_captured"] = 80;
  game["end_reason"]["friendlies_eliminated"] = 81;
  game["round_end_exmsg"]["intermission"] = 1;
  game["round_end_exmsg"]["switching_sides"] = 2;
  game["round_end_exmsg"]["match_point"] = 3;
  game["end_reason_mlg_mapping"][game["end_reason"]["time_to_beat_ctf_win"]] = game["end_reason"]["mlg_time_to_beat_ctf"];
  game["end_reason_mlg_mapping"][game["end_reason"]["time_to_beat_ctf_loss"]] = game["end_reason"]["mlg_time_to_beat_ctf"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_time_health_win"]] = game["end_reason"]["mlg_time_health"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_time_health_loss"]] = game["end_reason"]["mlg_time_health"];
  game["end_reason_mlg_mapping"][game["end_reason"]["time_to_beat_uplink_win"]] = game["end_reason"]["mlg_time_to_beat_uplink"];
  game["end_reason_mlg_mapping"][game["end_reason"]["time_to_beat_uplink_loss"]] = game["end_reason"]["mlg_time_to_beat_uplink"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_time_lives_win"]] = game["end_reason"]["mlg_time_lives"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_time_lives_loss"]] = game["end_reason"]["mlg_time_lives"];
  game["end_reason_mlg_mapping"][game["end_reason"]["rusf_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["usmc_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["sas_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["zvir_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["icorps_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["grp9_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["spetsnaz_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["marines_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["sas_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["zvir_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["icorps_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["grp9_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["enemies_eliminated"]] = game["end_reason"]["mlg_eliminated"];
  game["end_reason_mlg_mapping"][game["end_reason"]["enemies_forfeited"]] = game["end_reason"]["mlg_forfeited"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_otflag_completed"]] = game["end_reason"]["mlg_otflag_captured"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_otflag_failed"]] = game["end_reason"]["mlg_otflag_captured"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_tournament_tie_win"]] = game["end_reason"]["mlg_tournament_tie"];
  game["end_reason_mlg_mapping"][game["end_reason"]["arena_tournament_tie_loss"]] = game["end_reason"]["mlg_tournament_tie"];
  game["end_reason_mlg_mapping"][game["end_reason"]["control_allzones_win"]] = game["end_reason"]["mlg_allzones_captured"];
  game["end_reason_mlg_mapping"][game["end_reason"]["control_allzones_loss"]] = game["end_reason"]["mlg_allzones_captured"];
  level.splashtablecache = [];
  level._id_4CD98C0C1064CFC0 = [];
  level._id_97CD5EE2098D8181 = -2;
  level thread onplayerconnect();
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::splashshowncallback);
  level.showerrormessagefunc = ::showerrormessage;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player thread lowermessagethink();
    player thread eventsplashesthink();
  }
}

showkillstreaksplash(_id_F7B6CC6C062A7A43, _id_F06B5C1AC51DF6A6, _id_69E685E96DBF1D48, _id_042B1E877AB187C6) {
  if(!isPlayer(self)) {
    return;
  }
  altdisplayindex = undefined;

  if(istrue(_id_69E685E96DBF1D48))
    altdisplayindex = 1;

  _id_F7B6CC6C062A7A43 = getspecialistsplashfromkillstreak(_id_F7B6CC6C062A7A43);
  showsplash(_id_F7B6CC6C062A7A43, _id_F06B5C1AC51DF6A6, undefined, altdisplayindex, undefined, _id_042B1E877AB187C6);

  if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    scripts\cp_mp\utility\killstreak_utility::_id_08959C1606F65E65(_id_F7B6CC6C062A7A43, _func_1823FF50BB28148D(_id_F7B6CC6C062A7A43));
}

getspecialistsplashfromkillstreak(_id_F7B6CC6C062A7A43) {
  _id_FEC8B7A457ED3A4F = _id_F7B6CC6C062A7A43;
  specialistperk = scripts\mp\perks\perks::getspecialistperkforstreak(_id_F7B6CC6C062A7A43);

  if(isDefined(specialistperk))
    _id_FEC8B7A457ED3A4F = specialistperk;

  return _id_FEC8B7A457ED3A4F;
}

showsplashwithkillcheckhack(ref, optionalnumber, playerforplayercard, altdisplayindex, _id_042B1E877AB187C6, _id_00E79995FA243CA9) {
  level endon("game_ended");
  self endon("disconnect");
  waitframe();

  if(isDefined(self.lastkilltime)) {
    _id_49AB8094244F4FE1 = getdvarfloat("scr_splash_kill_buffer", 0.5) * 1000;
    _id_74B5B12BB6514385 = int(max(_id_49AB8094244F4FE1 - (gettime() - self.lastkilltime), 0));
    wait(_id_74B5B12BB6514385 / 1000.0);
  }

  showsplash(ref, optionalnumber, playerforplayercard, altdisplayindex, 1, _id_042B1E877AB187C6, _id_00E79995FA243CA9);
}

showsplash(ref, optionalnumber, playerforplayercard, altdisplayindex, _id_EF4849B4CB3AC7E2, _id_042B1E877AB187C6, _id_00E79995FA243CA9) {
  if(_id_4E3EB46838440959() && !istrue(_id_00E79995FA243CA9)) {
    return;
  }
  if(!istrue(_id_EF4849B4CB3AC7E2)) {
    thread showsplashwithkillcheckhack(ref, optionalnumber, playerforplayercard, altdisplayindex, _id_042B1E877AB187C6, _id_00E79995FA243CA9);
    return;
  }

  playernumforplayercard = undefined;

  if(isDefined(playerforplayercard))
    playernumforplayercard = playerforplayercard getentitynumber();

  if(isDefined(self.recentsplashcount) && self.recentsplashcount >= 6) {
    queuesplash(ref, optionalnumber, playerforplayercard, playernumforplayercard, altdisplayindex, _id_042B1E877AB187C6);
    return;
  }

  if(!scripts\mp\utility\player::isreallyalive(self) && isPlayer(self) && !self _meth_8420670EAFC8D391()) {
    queuesplash(ref, optionalnumber, playerforplayercard, playernumforplayercard, altdisplayindex, _id_042B1E877AB187C6);
    return;
  }

  showsplashinternal(ref, optionalnumber, playerforplayercard, playernumforplayercard, altdisplayindex, _id_042B1E877AB187C6);
}

showsplashinternal(ref, optionalnumber, playerforplayercard, playernumforplayercard, altdisplayindex, _id_042B1E877AB187C6) {
  if(!isPlayer(self)) {
    return;
  }
  if(isDefined(playernumforplayercard)) {
    if(!isDefined(playerforplayercard))
      return;
  }

  if(getdvarint("dvar_EF4F06E55F320347", 0) == 1) {
    _id_A4E353FA34A0F7BD = 1;
    _id_83AFA1BB13298AC7 = _id_73BAF095C3B9CCE6(ref, _id_042B1E877AB187C6);

    if(!isDefined(_id_83AFA1BB13298AC7) || _id_83AFA1BB13298AC7 < 0) {
      _id_A4E353FA34A0F7BD = 0;
      _id_83AFA1BB13298AC7 = getsplashid(ref);
    }
  } else {
    _id_A4E353FA34A0F7BD = 0;
    _id_83AFA1BB13298AC7 = getsplashid(ref);

    if(!isDefined(_id_83AFA1BB13298AC7) || _id_83AFA1BB13298AC7 < 0) {
      _id_83AFA1BB13298AC7 = _id_73BAF095C3B9CCE6(ref, _id_042B1E877AB187C6);
      _id_A4E353FA34A0F7BD = 1;
    }
  }

  if(!isDefined(_id_83AFA1BB13298AC7) || _id_83AFA1BB13298AC7 < 0) {
    return;
  }
  if(!isDefined(self._id_E04F5D9B477CB89F))
    self._id_E04F5D9B477CB89F = 0;

  if(!isDefined(self._id_E983B466B2EC69D5))
    self._id_E983B466B2EC69D5 = 1;

  _id_5C9DDCF56D36F133 = _id_83AFA1BB13298AC7;

  if(self._id_E983B466B2EC69D5)
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 | 2048;

  if(isDefined(optionalnumber)) {
    if(level._id_97CD5EE2098D8181 < optionalnumber)
      level._id_97CD5EE2098D8181 = optionalnumber;

    self setclientomnvar("ui_player_splash_param_" + self._id_E04F5D9B477CB89F, optionalnumber);
  } else
    self setclientomnvar("ui_player_splash_param_" + self._id_E04F5D9B477CB89F, -1);

  if(isDefined(playernumforplayercard))
    self setclientomnvar("ui_player_splash_cardClientId_" + self._id_E04F5D9B477CB89F, playernumforplayercard);
  else
    self setclientomnvar("ui_player_splash_cardClientId_" + self._id_E04F5D9B477CB89F, -1);

  if(isDefined(altdisplayindex))
    self setclientomnvar("ui_player_splash_use_alt_" + self._id_E04F5D9B477CB89F, altdisplayindex);
  else
    self setclientomnvar("ui_player_splash_use_alt_" + self._id_E04F5D9B477CB89F, 0);

  self setclientomnvar("ui_player_splash_scriptBundle_" + self._id_E04F5D9B477CB89F, _id_A4E353FA34A0F7BD);
  self setclientomnvar("ui_player_splash_id_" + self._id_E04F5D9B477CB89F, _id_5C9DDCF56D36F133);

  if(!isDefined(self.recentsplashcount))
    self.recentsplashcount = 1;
  else
    self.recentsplashcount++;

  thread cleanuplocalplayersplashlist();
  self._id_E04F5D9B477CB89F++;

  if(self._id_E04F5D9B477CB89F >= 6) {
    self._id_E04F5D9B477CB89F = 0;
    self._id_E983B466B2EC69D5 = !self._id_E983B466B2EC69D5;
  }
}

queuesplash(ref, optionalnumber, playerforplayercard, playernumforplayercard, altdisplayindex, _id_042B1E877AB187C6) {
  struct = spawnStruct();
  struct.ref = ref;
  struct.optionalnumber = optionalnumber;
  struct.playerforplayercard = playerforplayercard;
  struct.playernumforplayercard = playernumforplayercard;
  struct.altdisplayindex = altdisplayindex;
  struct._id_042B1E877AB187C6 = _id_042B1E877AB187C6;

  if(!isDefined(self.splashqueuehead)) {
    self.splashqueuehead = struct;
    self.splashqueuetail = struct;
    thread handlesplashqueue();
  } else {
    _id_520AE50DDF0F19C4 = self.splashqueuetail;
    _id_520AE50DDF0F19C4.nextsplash = struct;
    self.splashqueuetail = struct;
  }
}

handlesplashqueue() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("clearSplashQueue");

  while(isDefined(self.splashqueuehead)) {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && (scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm" || scripts\mp\utility\game::getsubgametype() == "plunder" || scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "rumble_mgl"))
      scripts\engine\utility::waittill_any_2("splash_list_cleared", "can_show_splashes");
    else
      scripts\engine\utility::waittill_any_2("splash_list_cleared", "spawned_player");

    for(_id_2ACA94DD41D845F8 = 0; _id_2ACA94DD41D845F8 < 6; _id_2ACA94DD41D845F8++) {
      struct = self.splashqueuehead;
      showsplashinternal(struct.ref, struct.optionalnumber, struct.playerforplayercard, struct.playernumforplayercard, struct.altdisplayindex, struct._id_042B1E877AB187C6);
      self.splashqueuehead = struct.nextsplash;

      if(!isDefined(self.splashqueuehead)) {
        break;
      }
    }
  }

  self.splashqueuetail = undefined;
}

clearsplashqueue() {
  self notify("clearSplashQueue");

  for(nextsplash = self.splashqueuehead; isDefined(nextsplash); _id_7FC1E5683A6EBEBD.nextsplash = undefined) {
    _id_7FC1E5683A6EBEBD = nextsplash;
    nextsplash = _id_7FC1E5683A6EBEBD.nextsplash;
  }

  self.splashqueuehead = undefined;
  self.splashqueuetail = undefined;
}

getsplashid(_id_F7B6CC6C062A7A43) {
  id = level.splashtablecache[_id_F7B6CC6C062A7A43];

  if(!isDefined(id)) {
    id = tablelookuprownum(getsplashtablename(), 0, _id_F7B6CC6C062A7A43);
    level.splashtablecache[_id_F7B6CC6C062A7A43] = id;
  }

  return id;
}

_id_73BAF095C3B9CCE6(_id_F7B6CC6C062A7A43, _id_042B1E877AB187C6) {
  id = level._id_4CD98C0C1064CFC0[_id_F7B6CC6C062A7A43];

  if(isDefined(id))
    return id;

  _id_C1C3E6A4F162AB45 = undefined;

  if(isDefined(_id_042B1E877AB187C6))
    _id_C1C3E6A4F162AB45 = _id_042B1E877AB187C6;

  if(!isDefined(_id_C1C3E6A4F162AB45) && isDefined(level._id_62F6F7640E4431E3))
    _id_C1C3E6A4F162AB45 = level._id_62F6F7640E4431E3._id_F7D29CEF55A5FB26;

  if(!isDefined(_id_C1C3E6A4F162AB45))
    _id_C1C3E6A4F162AB45 = level._id_1A2B600A06EC21F4._id_F7D29CEF55A5FB26;

  if(!isDefined(_id_C1C3E6A4F162AB45))
    return undefined;

  _id_F7D29CEF55A5FB26 = getscriptbundle(_func_2EF675C13CA1C4AF("enum_7AC5A0B15C7D50E5", _id_C1C3E6A4F162AB45));

  if(!isDefined(_id_F7D29CEF55A5FB26) || !isDefined(_id_F7D29CEF55A5FB26._id_194DF4FE813AE6D7))
    return undefined;

  foreach(_id_68CC4B3BF54ADCFE in _id_F7D29CEF55A5FB26._id_194DF4FE813AE6D7) {
    if(_id_68CC4B3BF54ADCFE.ref != _id_F7B6CC6C062A7A43) {
      continue;
    }
    id = _func_2336488258354FBC("stat_A372798EADBA5C90", _func_2EF675C13CA1C4AF("enum_39857EA6520CF871", _id_68CC4B3BF54ADCFE._id_C922A8C8A92C3282));

    if(isDefined(id))
      level._id_4CD98C0C1064CFC0[_id_F7B6CC6C062A7A43] = id;

    return id;
  }

  return undefined;
}

_id_CD236201B71F07E2(_id_F7B6CC6C062A7A43, _id_DE02835724550257, _id_0510DF850B7BBEE9) {
  self endon("disconnect");

  if(self getclientomnvar("ui_match_in_progress") == 1) {
    return;
  }
  if(isDefined(level._id_5135022CC0F6A101) && level._id_5135022CC0F6A101) {
    return;
  }
  if(!isDefined(level.matchcountdowntime)) {
    return;
  }
  if(level.matchcountdowntime < _id_DE02835724550257) {
    return;
  }
  while(level.matchcountdowntime > _id_DE02835724550257)
    wait 1.0;

  if(isDefined(_id_0510DF850B7BBEE9))
    wait(_id_0510DF850B7BBEE9);

  showsplash(_id_F7B6CC6C062A7A43);
  level._id_5135022CC0F6A101 = 1;
}

lowermessagethink() {
  self endon("disconnect");
  self.lowermessages = [];
  lowermessagefont = "default";

  if(isDefined(level.lowermessagefont))
    lowermessagefont = level.lowermessagefont;

  _id_7417D49A6C72A483 = level.lowertexty;
  _id_4C254F3E1813B5AC = level.lowertextfontsize;
  _id_ED9168DA0F317746 = 1.25;

  if(level.splitscreen || self issplitscreenplayer() && !isai(self)) {
    _id_7417D49A6C72A483 = _id_7417D49A6C72A483 - 40;
    _id_4C254F3E1813B5AC = level.lowertextfontsize * 1.3;
    _id_ED9168DA0F317746 = _id_ED9168DA0F317746 * 1.5;
  }

  self.lowermessage = scripts\mp\hud_util::createfontstring(lowermessagefont, _id_4C254F3E1813B5AC);
  self.lowermessage settext("");
  self.lowermessage.archived = 0;
  self.lowermessage.sort = 10;
  self.lowermessage.showinkillcam = 0;
  self.lowermessage scripts\mp\hud_util::setpoint("CENTER", level.lowertextyalign, 0, _id_7417D49A6C72A483);
  self.lowertimer = scripts\mp\hud_util::createfontstring("default", _id_ED9168DA0F317746);
  self.lowertimer scripts\mp\hud_util::setparent(self.lowermessage);
  self.lowertimer scripts\mp\hud_util::setpoint("TOP", "BOTTOM", 0, 0);
  self.lowertimer settext("");
  self.lowertimer.archived = 0;
  self.lowertimer.sort = 10;
  self.lowertimer.showinkillcam = 0;
}

isdoingsplash() {
  return 0;
}

teamoutcomenotify(winner, _id_83C9459B644DC44F, _id_F0500919D8C387B9, _id_656B99FC50E799AE, roundendextramessage) {
  self endon("disconnect");
  _id_F15E96279C3BC254 = winner;

  if(isDefined(roundendextramessage))
    self setclientomnvar("ui_round_end_extra_message", roundendextramessage);

  team = self.pers["team"];

  if(self _meth_8420670EAFC8D391())
    team = self _meth_638EEBEFF841E16A();

  if(!isDefined(team) || !scripts\engine\utility::array_contains(level.teamnamelist, team))
    team = "allies";

  if(winner == "halftime") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["halftime"]);
    _id_F15E96279C3BC254 = "allies";
  } else if(winner == "intermission") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["intermission"]);
    _id_F15E96279C3BC254 = "allies";
  } else if(winner == "switching_sides") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["side_switch"]);
    _id_F15E96279C3BC254 = "allies";
  } else if(winner == "roundend") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["roundend"]);
    _id_F15E96279C3BC254 = "allies";
  } else if(winner == "overtime") {
    if(scripts\mp\utility\game::iswinbytworulegametype() && !scripts\mp\utility\game::allteamstied())
      self setclientomnvar("ui_round_end_title", game["round_end"]["match_point"]);
    else
      self setclientomnvar("ui_round_end_title", game["round_end"]["overtime"]);

    _id_F15E96279C3BC254 = "allies";
  } else if(winner == "match_point") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["match_point"]);
    _id_F15E96279C3BC254 = "allies";
  } else if(winner == "final_round") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["final_round"]);
    _id_F15E96279C3BC254 = "allies";
  } else if(winner == "win_by_two") {
    self setclientomnvar("ui_round_end_title", game["round_end"]["win_by_two"]);
    _id_F15E96279C3BC254 = "allies";
  } else if(winner == "tie") {
    if(_id_83C9459B644DC44F && !scripts\mp\utility\game::waslastround())
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_draw"]);
    else
      self setclientomnvar("ui_round_end_title", game["round_end"]["draw"]);

    _id_F15E96279C3BC254 = "allies";
  } else if(self _meth_8420670EAFC8D391())
    self setclientomnvar("ui_round_end_title", game["round_end"]["spectator"]);
  else if(isDefined(self.pers["team"]) && winner == team) {
    if(_id_83C9459B644DC44F && !scripts\mp\utility\game::waslastround())
      self setclientomnvar("ui_round_end_title", game["round_end"]["round_win"]);
    else
      self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
  } else if(_id_83C9459B644DC44F && !scripts\mp\utility\game::waslastround())
    self setclientomnvar("ui_round_end_title", game["round_end"]["round_loss"]);
  else {
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);

    if(istrue(self.joinedinprogress) && scripts\mp\utility\game::onlinestatsenabled())
      _id_F0500919D8C387B9 = game["end_reason"]["loss_stat_prevented"];
  }

  if(!self _meth_8420670EAFC8D391())
    winner = _id_F15E96279C3BC254;

  if(scripts\mp\utility\game::getgametype() == "arena" || scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict" || scripts\mp\utility\game::getgametype() == "siege" || scripts\mp\utility\game::getgametype() == "control") {
    if(isDefined(_id_656B99FC50E799AE)) {
      if(isDefined(self.pers["team"]) && winner == team)
        _id_F0500919D8C387B9 = _id_F0500919D8C387B9;
      else
        _id_F0500919D8C387B9 = _id_656B99FC50E799AE;
    }
  } else if(scripts\mp\utility\game::inovertime() && scripts\mp\utility\game::waslastround() && scripts\mp\utility\game::istimetobeatrulegametype()) {
    if(scripts\mp\utility\game::getgametype() == "ctf") {
      if(isDefined(self.pers["team"]) && winner == team)
        _id_F0500919D8C387B9 = game["end_reason"]["time_to_beat_ctf_win"];
      else if(isDefined(self.pers["team"]) && winner == scripts\mp\utility\game::getotherteam(self.pers["team"])[0])
        _id_F0500919D8C387B9 = game["end_reason"]["time_to_beat_ctf_loss"];
    } else if(scripts\mp\utility\game::getgametype() == "ball") {
      if(isDefined(self.pers["team"]) && winner == team)
        _id_F0500919D8C387B9 = game["end_reason"]["time_to_beat_uplink_win"];
      else if(isDefined(self.pers["team"]) && winner == scripts\mp\utility\game::getotherteam(self.pers["team"])[0])
        _id_F0500919D8C387B9 = game["end_reason"]["time_to_beat_uplink_loss"];
    }
  } else if(isDefined(_id_656B99FC50E799AE)) {
    if(isDefined(self.pers["team"]) && winner == team)
      _id_F0500919D8C387B9 = _id_F0500919D8C387B9;
    else
      _id_F0500919D8C387B9 = _id_656B99FC50E799AE;
  }

  if(!isDefined(_id_F0500919D8C387B9))
    _id_F0500919D8C387B9 = 1;

  if(self _meth_8420670EAFC8D391()) {
    if(isDefined(game["end_reason_mlg_mapping"][_id_F0500919D8C387B9]))
      _id_F0500919D8C387B9 = game["end_reason_mlg_mapping"][_id_F0500919D8C387B9];
  }

  if(_id_F0500919D8C387B9 == game["end_reason"]["switching_sides"])
    self setclientomnvar("ui_round_end_reason", 0);
  else
    self setclientomnvar("ui_round_end_reason", _id_F0500919D8C387B9);

  if(self _meth_8420670EAFC8D391()) {
    if(winner == "axis")
      self setclientomnvar("ui_round_end_winner", 1);
    else if(winner == "allies")
      self setclientomnvar("ui_round_end_winner", 2);
    else
      self setclientomnvar("ui_round_end_winner", 0);
  }

  if(!scripts\mp\utility\game::isroundbased() || !scripts\mp\utility\game::isobjectivebased() || scripts\mp\utility\game::ismoddedroundgame()) {
    _id_12BE976EF709F668 = scripts\mp\gamescore::_getteamscore(team);

    if(_id_12BE976EF709F668 > 16000)
      _id_12BE976EF709F668 = 16000;

    _id_B2FA932257032883 = scripts\mp\gamescore::_getteamscore(scripts\mp\utility\game::getotherteam(team)[0]);

    if(_id_B2FA932257032883 > 16000)
      _id_B2FA932257032883 = 16000;

    self setclientomnvar("ui_round_end_friendly_score", _id_12BE976EF709F668);
    self setclientomnvar("ui_round_end_enemy_score", _id_B2FA932257032883);
  } else {
    self setclientomnvar("ui_round_end_friendly_score", game["roundsWon"][team]);
    self setclientomnvar("ui_round_end_enemy_score", game["roundsWon"][scripts\mp\utility\game::getotherteam(team)[0]]);
  }

  if(isDefined(self.matchbonus))
    self setclientomnvar("ui_round_end_match_bonus", self.matchbonus);
}

outcomenotify(winner, _id_F0500919D8C387B9, _id_656B99FC50E799AE) {
  self endon("disconnect");
  players = level.placement["all"];
  _id_8BCF55E50A4A221C = players[0];
  _id_3E270BE7101B9308 = players[1];
  _id_F4FDBA919AF1736D = players[2];
  _id_2571942A4DCD338E = level.players.size > 3;

  if(isstring(winner) && winner == "tie") {
    if(isDefined(_id_8BCF55E50A4A221C) && scripts\mp\gamescore::_getplayerscore(_id_8BCF55E50A4A221C) == scripts\mp\gamescore::_getplayerscore(self)) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["tie"]);
      self setclientomnvar("ui_round_end_reason", _id_F0500919D8C387B9);
    } else if(isDefined(_id_8BCF55E50A4A221C) && self == _id_8BCF55E50A4A221C || isDefined(_id_3E270BE7101B9308) && self == _id_3E270BE7101B9308 || isDefined(_id_F4FDBA919AF1736D) && self == _id_F4FDBA919AF1736D) {
      self setclientomnvar("ui_round_end_title", game["round_end"]["tie"]);
      self setclientomnvar("ui_round_end_reason", _id_F0500919D8C387B9);
    } else {
      self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
      self setclientomnvar("ui_round_end_reason", scripts\engine\utility::ter_op(isDefined(_id_656B99FC50E799AE), _id_656B99FC50E799AE, _id_F0500919D8C387B9));
    }
  } else if(isDefined(_id_8BCF55E50A4A221C) && self == _id_8BCF55E50A4A221C || istrue(_id_2571942A4DCD338E) && (isDefined(_id_3E270BE7101B9308) && self == _id_3E270BE7101B9308 || isDefined(_id_F4FDBA919AF1736D) && self == _id_F4FDBA919AF1736D)) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
    self setclientomnvar("ui_round_end_reason", _id_F0500919D8C387B9);
  } else {
    self setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
    self setclientomnvar("ui_round_end_reason", scripts\engine\utility::ter_op(isDefined(_id_656B99FC50E799AE), _id_656B99FC50E799AE, _id_F0500919D8C387B9));

    if(istrue(self.joinedinprogress) && scripts\mp\utility\game::onlinestatsenabled())
      _id_F0500919D8C387B9 = game["end_reason"]["loss_stat_prevented"];
  }

  if(isDefined(self.matchbonus))
    self setclientomnvar("ui_round_end_match_bonus", self.matchbonus);
}

getsplashtablename() {
  if(isDefined(level._id_1A2B600A06EC21F4) && isDefined(level._id_1A2B600A06EC21F4._id_FA386C9362C91A3E) && level._id_1A2B600A06EC21F4._id_FA386C9362C91A3E != "")
    return level._id_1A2B600A06EC21F4._id_FA386C9362C91A3E;

  return getDvar("dvar_B7B83CC9DF67C558", "mp/splashTable.csv");
}

getsplashtablemaxaltdisplays() {
  return 5;
}

cleanuplocalplayersplashlist() {
  self endon("disconnect");
  self notify("cleanupLocalPlayerSplashList()");
  self endon("cleanupLocalPlayerSplashList()");
  scripts\engine\utility::waittill_notify_or_timeout("death", 0.5);

  while(!scripts\mp\utility\player::isreallyalive(self) && !self _meth_8420670EAFC8D391())
    wait 0.15;

  self.recentsplashcount = undefined;
  self notify("splash_list_cleared");
}

splashshowncallback(_id_7148C1A6F25491F8, _id_EA8523762E51DD5E) {
  if(_id_7148C1A6F25491F8 != "splash_shown")
    return;
}

onkillstreaksplashshown(_id_F7B6CC6C062A7A43) {
  scripts\cp_mp\utility\killstreak_utility::_id_08959C1606F65E65(_id_F7B6CC6C062A7A43, _id_F7B6CC6C062A7A43);
  thread checkforspecialistbonusvo(_id_F7B6CC6C062A7A43);
}

checkforspecialistbonusvo(_id_F7B6CC6C062A7A43) {
  specialistperk = scripts\mp\perks\perks::getspecialistperkforstreak();

  if(_id_F7B6CC6C062A7A43 == "specialist_perk_bonus") {
    wait 2.0;
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_66D4835263B12EE1");
  }
}

showerrormessage(_id_1797174F9E968E96, _id_D153265565DF63DA) {
  _id_09DD5D9E57E7E36D = tablelookuprownum("mp/errorMessages.csv", 0, _id_1797174F9E968E96);

  if(isDefined(_id_D153265565DF63DA))
    self setclientomnvar("ui_mp_error_message_param", _id_D153265565DF63DA);
  else
    self setclientomnvar("ui_mp_error_message_param", -1);

  if(isDefined(_id_09DD5D9E57E7E36D))
    self setclientomnvar("ui_mp_error_message_id", _id_09DD5D9E57E7E36D);

  if(!isDefined(self.errormessagebitflipper))
    self.errormessagebitflipper = 0;

  self.errormessagebitflipper = !self.errormessagebitflipper;
  self setclientomnvar("ui_mp_error_trigger", scripts\engine\utility::ter_op(self.errormessagebitflipper, 2, 1));
}

showerrormessagetoallplayers(_id_1797174F9E968E96, _id_D153265565DF63DA) {
  foreach(player in level.players)
  player showerrormessage(_id_1797174F9E968E96, _id_D153265565DF63DA);
}

testmiscmessage(messageref) {
  _id_09DD5D9E57E7E36D = tablelookuprownum("mp/miscMessages.csv", 0, messageref);

  if(isDefined(_id_09DD5D9E57E7E36D) && _id_09DD5D9E57E7E36D >= 0)
    return 1;

  return 0;
}

showmiscmessage(messageref) {
  _id_09DD5D9E57E7E36D = tablelookuprownum("mp/miscMessages.csv", 0, messageref);
  sound = tablelookupbyrow("mp/miscMessages.csv", _id_09DD5D9E57E7E36D, 3);

  if(isDefined(sound) && sound != "")
    self playlocalsound(sound);

  self setclientomnvar("ui_misc_message_id", _id_09DD5D9E57E7E36D);
  self setclientomnvar("ui_misc_message_trigger", 1);
}

eventsplashesthink() {
  self endon("disconnect");

  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  _id_AB5E2871FC88494C = 0;

  if(!isDefined(self.pers["hasSpawned"]))
    _id_AB5E2871FC88494C = 1;

  if(scripts\mp\flags::gameflag("infil_will_run")) {
    if(!scripts\mp\flags::gameflag("prematch_done"))
      level scripts\mp\flags::gameflagwait("prematch_done");
  }

  self waittill("loadout_class_selected");

  if(!isDefined(self)) {
    return;
  }
  _id_9BFBC8300ED86A03 = self getprivatepartysize() > 1;

  if(_id_AB5E2871FC88494C) {
    if(scripts\cp_mp\utility\game_utility::_id_E3EF0908B595E8E1() == 2 || _id_9BFBC8300ED86A03 && getdvarint("online_mp_party_xpscale") == 2 || self isps4player() && getdvarfloat("dvar_010F733902FB6E20") == 2)
      showsplash("event_double_xp", undefined, self);

    if(getdvarint("online_mp_weapon_xpscale") == 2 || _id_9BFBC8300ED86A03 && getdvarint("online_mp_party_weapon_xpscale") == 2)
      showsplash("event_double_weapon_xp", undefined, self);

    if(getdvarint("online_battle_xpscale") == 2)
      showsplash("event_double_battle_xp", undefined, self);

    if(getdvarint("online_double_keys") > 0)
      showsplash("event_double_keys", undefined, self);

    if(getdvarint("online_mp_missionteam_xpscale") == 2 || _id_9BFBC8300ED86A03 && getdvarint("online_mp_party_missionteam_xpscale") == 2)
      showsplash("event_double_xp_teams", undefined, self);
  }
}

notifyteam(_id_2B9A889F3BE2981B, _id_818AC67C76F27D3A, _id_AC6CA28A64718193, _id_4725E52B7C3AA25C, _id_6ACC43FA4DB03A7F, _id_6AD135FA4DB6448C, playerforplayercard) {
  foreach(player in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(!scripts\mp\utility\teams::isgameplayteam(player.team)) {
      continue;
    }
    if(player.team == _id_AC6CA28A64718193) {
      if(!scripts\mp\hud_util::canshowsplash(_id_2B9A889F3BE2981B)) {
        continue;
      }
      if(isDefined(_id_4725E52B7C3AA25C)) {
        if(!scripts\engine\utility::array_contains(_id_4725E52B7C3AA25C, player))
          player thread showsplash(_id_2B9A889F3BE2981B, _id_6ACC43FA4DB03A7F, playerforplayercard);
      } else
        player thread showsplash(_id_2B9A889F3BE2981B, _id_6ACC43FA4DB03A7F, playerforplayercard);

      continue;
    }

    if(!scripts\mp\hud_util::canshowsplash(_id_818AC67C76F27D3A)) {
      continue;
    }
    if(isDefined(_id_4725E52B7C3AA25C)) {
      if(!scripts\engine\utility::array_contains(_id_4725E52B7C3AA25C, player))
        player thread showsplash(_id_818AC67C76F27D3A, _id_6AD135FA4DB6448C, playerforplayercard);

      continue;
    }

    player thread showsplash(_id_818AC67C76F27D3A, _id_6AD135FA4DB6448C, playerforplayercard);
  }
}

_id_2B88D4A7A0B44E30(ref) {
  _id_5C9DDCF56D36F133 = int(tablelookup("mp/matchStatusHintTextTable.csv", 2, ref, 0));
  return _id_5C9DDCF56D36F133;
}

_id_F004EF4606B9EFDC(ref) {
  self setclientomnvar("ui_match_status_hint_text", _id_2B88D4A7A0B44E30(ref));
}

updatematchstatushintforallplayers(_id_AC6CA28A64718193, _id_7272B671334AA84F, _id_ED7758B45551517E, _id_6DB141A3A3E03B2B, _id_DC3596691B18226A) {
  level notify("updateHint");
  level endon("updateHint");

  foreach(player in level.players) {
    if(isDefined(_id_AC6CA28A64718193) && player.team == _id_AC6CA28A64718193) {
      if(isDefined(_id_6DB141A3A3E03B2B) && player == _id_6DB141A3A3E03B2B)
        player _id_F004EF4606B9EFDC(_id_DC3596691B18226A);
      else
        player _id_F004EF4606B9EFDC(_id_7272B671334AA84F);

      continue;
    }

    if(isDefined(_id_ED7758B45551517E))
      player _id_F004EF4606B9EFDC(_id_ED7758B45551517E);
  }
}

_id_4E3EB46838440959() {
  return istrue(level._id_CC9E990B6E83975B) || !istrue(getdvarint("dvar_AACC4977E4EA1009", 1));
}