/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5c55c87b89467a29.gsc
***********************************************/

#using_animtree("script_model");

_id_209B4F3CBE639411() {
  if(getdvarint("dvar_FF65C25889692DB8", 0) == 1) {
    return;
  }
  if(getdvarint("dvar_9C43B60485FBD92E", 0) == 1) {
    if(!istrue(level._id_72E1667D06AB98DB))
      level thread _id_362C40666180CACC();

    return;
  }

  level._id_B0A252247B4D921C = 1;
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::_id_AB0F4E43E75A740D);
  level._id_4CA71DF7C9F87195 = getdvarint("dvar_B4DD40C7E16F3A0D", 1);
  level._id_6032D9D6E714A2A3 = getdvarint("dvar_4788D52AD8B0D95B", 3);
  level._id_9474FD9F170EB8BB = getdvarint("dvar_BC48245CBEF08083", 10);
  level._id_8BB73EB201B171E2 = getdvarint("dvar_966200778CF1B8AA", 0);
  level._id_400484D15C2CFD6B = getdvarint("dvar_1E69EF33B46F5773", 400);
  level._id_EF3308C96486E0A9 = getdvarint("dvar_403F394C8232FDB1", 0);
  level._id_2D08577EFB11DACB = getdvarint("dvar_B6A86BE8437BB573", 5);
  level._id_E97FD1B659D67F4F = getdvarint("dvar_F5A76C762AB2AD27", -1);
  level._id_74E71AD99C620255 = [];
  level._id_FD915E8BD20B6D09 = ::_id_93E3FE0E5693889B;

  foreach(index, team in level.teamnamelist)
  level.requiredplayercount[team] = 0;

  level.prematchperiod = getdvarint("scr_game_graceperiod", 60);
  _id_BA9A385288D1A919 = getanimlength(%iw9_mp_dmz_infil_player1_cam);
  level.matchcountdowntime = _id_BA9A385288D1A919 + level._id_2D08577EFB11DACB;
  level.prematchperiodend = _id_BA9A385288D1A919 + level._id_2D08577EFB11DACB;
  level._id_7DF8A2D09A6044A2 = getanimlength(%iw9_mp_dmz_infil_player1_intro);
  level._id_7DF8A2D09A6044A2 = level._id_7DF8A2D09A6044A2 + getanimlength(%iw9_mp_dmz_infil_player1_exit);
  level._id_7DF8A2D09A6044A2 = level._id_7DF8A2D09A6044A2 + level._id_2D08577EFB11DACB;
  thread scripts\mp\gamelogic::matchstarttimer("match_starting_in", level.prematchperiod + level.prematchperiodend);
  _id_354E8D20FB63725D();
  level thread _id_EF34013DF19C0EE3();
}

_id_AB0F4E43E75A740D(_id_7148C1A6F25491F8, val) {
  if(_id_7148C1A6F25491F8 == "ui_dmz_mission_overlay")
    self._id_9DE396B15A642DE3 = 1;
}

_id_362C40666180CACC() {
  level._id_466A09C79541FC26 = 1;
  level waittill("match_start_real_countdown");
  level thread _id_7114995A34DF9681();
}

_id_9360AB8D73D433F8() {
  wait 10;

  foreach(point in level._id_C40817516B7D2B68) {
    level thread _id_336D34D696729F31(point.origin);

    if(isDefined(point.target)) {
      ent = scripts\engine\utility::getStruct(point.target, "targetname");
      level thread _id_336D34D696729F31(ent.origin);

      if(isDefined(ent.target)) {
        ent = scripts\engine\utility::getStruct(ent.target, "targetname");
        level thread _id_336D34D696729F31(ent.origin);
      }
    }
  }
}

_id_336D34D696729F31(pos) {
  color = (randomfloat(1), randomfloat(1), randomfloat(1));
  interval = 1;

  for(;;) {
    level thread scripts\mp\utility\debug::drawsphere(pos, 32, interval, color);
    wait(interval);
  }
}

_id_93E3FE0E5693889B() {
  _id_A95B157B75C7B989 = getdvarint("dvar_753D5D5F25EF4EF3", 1) == 1;

  if(!isDefined(level._id_D2A500C04F275698))
    level._id_D2A500C04F275698 = gettime();

  if(!isDefined(level._id_D5464D9D1AA6DCFF))
    level._id_D5464D9D1AA6DCFF = gettime();
  else
    level._id_7E910037D1FD046A = gettime();

  _id_19CC131BC3772E16 = 0;
  _id_71B179643F3088FE = _func_425D34DDD114F3DE();

  if(level.players.size < _id_71B179643F3088FE) {
    level._id_D2A500C04F275698 = gettime();
    return 0;
  }

  if(gettime() - level._id_D2A500C04F275698 < level._id_400484D15C2CFD6B)
    return 0;

  if(level.players.size > 0) {
    _id_19CC131BC3772E16 = 1;

    foreach(team in level.teamnamelist) {
      players = scripts\mp\utility\teams::getteamdata(team, "players");

      foreach(player in players) {
        if(_id_A95B157B75C7B989 && !player ispredictedstreamposready()) {
          _id_19CC131BC3772E16 = 0;
          break;
        }

        if(!istrue(player.pers["streamSyncComplete"]) || player.model == "") {
          if(!istrue(player.pers["streamSyncComplete"])) {
            if(!isDefined(player._id_560490E2DBF6BFFD))
              player._id_560490E2DBF6BFFD = gettime();
            else
              player._id_D8EF71A0AC335D44 = gettime();
          }

          if(player.model == "") {
            if(!isDefined(player._id_B1641227C0A9FFCD))
              player._id_B1641227C0A9FFCD = gettime();
            else
              player._id_85A6B126D7750A54 = gettime();
          }

          _id_19CC131BC3772E16 = 0;
          break;
        }
      }

      if(!_id_19CC131BC3772E16) {
        break;
      }
    }
  }

  return _id_19CC131BC3772E16;
}

_id_EF34013DF19C0EE3() {
  level waittill("match_start_real_countdown");
  level thread _id_7114995A34DF9681();

  if(isDefined(level._id_D5464D9D1AA6DCFF))
    logstring("Infil Waiting for Connecting Players Start: " + level._id_D5464D9D1AA6DCFF);

  if(isDefined(level._id_7E910037D1FD046A))
    logstring("Infil Waiting for Connecting Players End: " + level._id_7E910037D1FD046A);

  foreach(_id_FABF84450735DD93 in level.teamnamelist) {
    _id_652F47620AC4713F = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "teamCount");

    if(_id_652F47620AC4713F)
      level thread _id_C9001909B0E28B18(_id_FABF84450735DD93, "dmz_infil_");
  }
}

_id_7114995A34DF9681() {
  level notify("dmzInfil_start");
  setomnvar("ui_in_infil", 1);
  wait(level.prematchperiodend - 4.0);
  setomnvar("ui_in_infil", 2);
  level notify("dmzInfil_countdownStart");
  level waittill("prematch_done");
  setomnvar("ui_in_infil", -1);
  level notify("dmzInfil_start");
}

_id_EF949B68AD626C8E() {
  timer = 0;

  if(level._id_8BB73EB201B171E2) {
    maxplayers = getdvarint("party_maxplayers", 0);

    while(level.players.size < maxplayers) {
      timer = timer + level.framedurationseconds;

      if(timer > level._id_9474FD9F170EB8BB)
        return timer;

      waitframe();
    }
  }

  if(level._id_6032D9D6E714A2A3 > 0) {
    foreach(team in level.teamnamelist) {
      if(scripts\mp\utility\teams::getteamdata(team, "teamCount")) {
        _id_19CC131BC3772E16 = 0;

        for(players = scripts\mp\utility\teams::getteamdata(team, "players"); players.size < level._id_6032D9D6E714A2A3 || !_id_19CC131BC3772E16; players = scripts\mp\utility\teams::getteamdata(team, "players")) {
          timer = timer + level.framedurationseconds;

          if(players.size >= level._id_6032D9D6E714A2A3) {
            _id_19CC131BC3772E16 = 1;

            foreach(player in players) {
              if(!istrue(player.pers["streamSyncComplete"]) || player.model == "")
                _id_19CC131BC3772E16 = 0;
            }
          }

          if(timer > level._id_9474FD9F170EB8BB)
            return timer;

          waitframe();
        }
      }
    }
  }

  return timer;
}

_id_354E8D20FB63725D() {
  level.scr_anim["dmzExfil_player0"]["dmz_infil_proto_a"] = % iw9_mp_infil_proto_a_guy_a;
  level.scr_eventanim["dmzExfil_player0"]["dmz_infil_proto_a"] = getanimname(%iw9_mp_infil_proto_a_guy_a);
  level.scr_anim["dmzExfil_player1"]["dmz_infil_proto_a"] = % iw9_mp_infil_proto_a_guy_b;
  level.scr_eventanim["dmzExfil_player1"]["dmz_infil_proto_a"] = getanimname(%iw9_mp_infil_proto_a_guy_b);
  level.scr_anim["dmzExfil_player2"]["dmz_infil_proto_a"] = % iw9_mp_infil_proto_a_guy_c;
  level.scr_eventanim["dmzExfil_player2"]["dmz_infil_proto_a"] = getanimname(%iw9_mp_infil_proto_a_guy_c);
  level.scr_anim["dmzExfil_player0"]["dmz_infil_intro"] = % iw9_mp_dmz_infil_player1_intro;
  level.scr_eventanim["dmzExfil_player0"]["dmz_infil_intro"] = getanimname(%iw9_mp_dmz_infil_player1_intro);
  level.scr_anim["dmzExfil_player0"]["dmz_infil_idle"] = % iw9_mp_dmz_infil_player1_idle;
  level.scr_eventanim["dmzExfil_player0"]["dmz_infil_idle"] = getanimname(%iw9_mp_dmz_infil_player1_idle);
  level.scr_anim["dmzExfil_player0"]["dmz_infil_exit"] = % iw9_mp_dmz_infil_player1_exit;
  level.scr_eventanim["dmzExfil_player0"]["dmz_infil_exit"] = getanimname(%iw9_mp_dmz_infil_player1_exit);
  level.scr_anim["dmzExfil_player1"]["dmz_infil_intro"] = % iw9_mp_dmz_infil_player2_intro;
  level.scr_eventanim["dmzExfil_player1"]["dmz_infil_intro"] = getanimname(%iw9_mp_dmz_infil_player2_intro);
  level.scr_anim["dmzExfil_player1"]["dmz_infil_idle"] = % iw9_mp_dmz_infil_player2_idle;
  level.scr_eventanim["dmzExfil_player1"]["dmz_infil_idle"] = getanimname(%iw9_mp_dmz_infil_player2_idle);
  level.scr_anim["dmzExfil_player1"]["dmz_infil_exit"] = % iw9_mp_dmz_infil_player2_exit;
  level.scr_eventanim["dmzExfil_player1"]["dmz_infil_exit"] = getanimname(%iw9_mp_dmz_infil_player2_exit);
  level.scr_anim["dmzExfil_player2"]["dmz_infil_intro"] = % iw9_mp_dmz_infil_player3_intro;
  level.scr_eventanim["dmzExfil_player2"]["dmz_infil_intro"] = getanimname(%iw9_mp_dmz_infil_player3_intro);
  level.scr_anim["dmzExfil_player2"]["dmz_infil_idle"] = % iw9_mp_dmz_infil_player3_idle;
  level.scr_eventanim["dmzExfil_player2"]["dmz_infil_idle"] = getanimname(%iw9_mp_dmz_infil_player3_idle);
  level.scr_anim["dmzExfil_player2"]["dmz_infil_exit"] = % iw9_mp_dmz_infil_player3_exit;
  level.scr_eventanim["dmzExfil_player2"]["dmz_infil_exit"] = getanimname(%iw9_mp_dmz_infil_player3_exit);

  if(getdvarint("dvar_947A9B74FCBD8126", 1) == 1) {
    level.scr_anim["dmzExfil_cam"]["dmz_infil_"] = % iw9_mp_dmz_infil_player1_cam;
    level.scr_anim["dmzExfil_cam"]["dmz_infil_1"] = % iw9_mp_dmz_infil_player1_cam;
    level.scr_anim["dmzExfil_cam"]["dmz_infil_2"] = % iw9_mp_dmz_infil_player2_cam;
    level.scr_anim["dmzExfil_cam"]["dmz_infil_3"] = % iw9_mp_dmz_infil_player3_cam;
    level.scr_anim["dmzExfil_cam"]["dmz_infil_low"] = % iw9_mp_dmz_infil_player1_lowcam_test;
  } else if(getdvarint("dvar_D38AB35EFDB1A60D", 1) == 1)
    level.scr_anim["dmzExfil_cam"]["dmz_infil_proto_a"] = % iw9_mp_infil_proto_a_guy_cam_alt;
  else
    level.scr_anim["dmzExfil_cam"]["dmz_infil_proto_a"] = % iw9_mp_infil_proto_a_guy_cam;
}

_id_E5F3A754C68EF261(pos, angles) {
  cameraent = spawn("script_model", pos);

  if(isDefined(angles))
    cameraent.angles = angles;

  cameraent setModel("tag_origin");
  cameraent.animname = "dmzExfil_cam";
  cameraent useanimtree(#animtree);
  return cameraent;
}

_id_C9001909B0E28B18(_id_FABF84450735DD93, _id_E26F44ACAD48DDD1, _id_CFC2CA5EBFA83DB2) {
  if(level.mapname == "mp_dmz_hydro")
    setglobalsoundcontext("wind", "heavy", 0.05);

  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  spawnpoint = scripts\engine\utility::ter_op(isDefined(_id_CFC2CA5EBFA83DB2), _id_CFC2CA5EBFA83DB2, level.teamdata[_id_FABF84450735DD93]["startPoint"]);

  foreach(player in players) {
    if(isDefined(player._id_B1641227C0A9FFCD))
      logstring("Player " + player.name + " Model Load Time Start: " + player._id_B1641227C0A9FFCD);

    if(isDefined(player._id_85A6B126D7750A54))
      logstring("Player " + player.name + " Model Load Time End: " + player._id_85A6B126D7750A54);

    if(isDefined(player._id_560490E2DBF6BFFD))
      logstring("Player " + player.name + " Stream Sync Time Start: " + player._id_560490E2DBF6BFFD);

    if(isDefined(player._id_D8EF71A0AC335D44))
      logstring("Player " + player.name + " Stream Sync Time End: " + player._id_D8EF71A0AC335D44);

    logstring("Player " + player.name + " Infil Started: " + gettime());
  }

  if(getdvarint("dvar_696CC1E380833AC0", 0) == 1)
    players = scripts\engine\utility::array_randomize(players);

  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  if(players.size < 1) {
    return;
  }
  level._id_466A09C79541FC26 = 1;
  _id_DAF67907B493B764 = _id_E5F3A754C68EF261(spawnpoint.origin, spawnpoint.angles);
  animstruct = _id_236F4CBF385B007F(players[0], _id_DAF67907B493B764, undefined, spawnpoint);
  _id_BBF920AFF68A45F0 = animstruct;

  if(isDefined(players[0]) && players[0].model != "")
    players[0] scripts\common\anim::anim_first_frame_solo(animstruct.cam, _id_E26F44ACAD48DDD1, "tag_origin");

  animlength = getanimlength(level.scr_anim[animstruct.cam.animname][_id_E26F44ACAD48DDD1]);
  _id_0774C9CA5D1D6221 = min(players.size, 3);

  if(players.size > 3) {
    for(_id_AC0E594AC96AA3A8 = int(_id_0774C9CA5D1D6221); _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
      players[_id_AC0E594AC96AA3A8] scripts\mp\utility\player::_freezecontrols(0);
      players[_id_AC0E594AC96AA3A8] scripts\mp\utility\player::_freezelookcontrols(0);
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0774C9CA5D1D6221; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(players[_id_AC0E594AC96AA3A8]) || players[_id_AC0E594AC96AA3A8].model == "") {
      continue;
    }
    _id_9F18E73F8F2216F5 = undefined;
    players[_id_AC0E594AC96AA3A8]._id_1CD92A64C5B20FA0 = "dmzExfil_player" + _id_AC0E594AC96AA3A8;

    if(isDefined(spawnpoint) && isDefined(spawnpoint.target)) {
      _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(spawnpoint.target, "targetname");

      foreach(struct in _id_9E4E1482CB40C9C5) {
        if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "infil_camera")
          _id_9F18E73F8F2216F5 = struct;
      }
    }

    if(_id_AC0E594AC96AA3A8 > 0) {
      if(isDefined(spawnpoint) && isDefined(spawnpoint.target)) {
        _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(spawnpoint.target, "targetname");

        foreach(struct in _id_9E4E1482CB40C9C5) {
          if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "infil_camera") {
            _id_9F18E73F8F2216F5 = struct;
            continue;
          }

          spawnpoint = struct;
        }
      } else
        spawnpoint = undefined;

      if(level._id_4CA71DF7C9F87195 == 1) {
        _id_DAF67907B493B764 = _id_E5F3A754C68EF261(players[_id_AC0E594AC96AA3A8].origin);
        animstruct = _id_236F4CBF385B007F(players[_id_AC0E594AC96AA3A8], _id_DAF67907B493B764, _id_BBF920AFF68A45F0, spawnpoint, _id_E26F44ACAD48DDD1);

        if(isDefined(players[_id_AC0E594AC96AA3A8]) && players[_id_AC0E594AC96AA3A8].model != "")
          players[_id_AC0E594AC96AA3A8] scripts\common\anim::anim_first_frame_solo(animstruct.cam, _id_E26F44ACAD48DDD1 + (_id_AC0E594AC96AA3A8 + 1), "tag_origin");
      } else
        animstruct = _id_236F4CBF385B007F(players[_id_AC0E594AC96AA3A8], _id_DAF67907B493B764, _id_BBF920AFF68A45F0, spawnpoint, _id_E26F44ACAD48DDD1);
    }

    players[_id_AC0E594AC96AA3A8] thread _id_67AD64CCFB9082A8(animstruct, _id_E26F44ACAD48DDD1, _id_9F18E73F8F2216F5);
  }

  if(level._id_4CA71DF7C9F87195 == 0)
    players[0] thread scripts\common\anim::anim_single_solo(animstruct.cam, _id_E26F44ACAD48DDD1, "tag_origin");

  level thread _id_1E328368618D72DA(_id_FABF84450735DD93);
}

_id_236F4CBF385B007F(player, cam, _id_ACF69B6C3FBFE7B0, spawnpoint, _id_E26F44ACAD48DDD1) {
  startpoint = undefined;

  if(level._id_EF3308C96486E0A9 == 1 && isDefined(level._id_74E71AD99C620255[player.team]))
    startpoint = level._id_74E71AD99C620255[player.team];
  else if(isDefined(spawnpoint))
    startpoint = spawnpoint;
  else
    startpoint = level.teamdata[player.team]["startPoint"];

  animstruct = spawnStruct();
  animstruct.origin = scripts\engine\utility::player_drop_to_ground(startpoint.origin, 32, undefined, undefined, (0, 0, 1));
  animstruct.angles = startpoint.angles;
  animstruct.cam = cam;

  if(isDefined(startpoint.script_parameters))
    animstruct.script_parameters = startpoint.script_parameters;

  if(isDefined(_id_ACF69B6C3FBFE7B0)) {
    _id_E68CF76E0696CA00 = getoriginforanimtime(_id_ACF69B6C3FBFE7B0.origin, _id_ACF69B6C3FBFE7B0.angles, level.scr_anim[player._id_1CD92A64C5B20FA0][_id_E26F44ACAD48DDD1 + "intro"], 1);
    _id_689A1188271A0BE5 = scripts\engine\utility::player_drop_to_ground(_id_E68CF76E0696CA00, 32, undefined, undefined, (0, 0, 1));
    targetpos = _id_ACF69B6C3FBFE7B0.origin;

    if(isDefined(spawnpoint)) {
      _id_E68CF76E0696CA00 = getoriginforanimtime(spawnpoint.origin, spawnpoint.angles, level.scr_anim[player._id_1CD92A64C5B20FA0][_id_E26F44ACAD48DDD1 + "intro"], 1);
      _id_689A1188271A0BE5 = scripts\engine\utility::player_drop_to_ground(spawnpoint.origin, 32, undefined, undefined, (0, 0, 1));
      targetpos = spawnpoint.origin + (spawnpoint.origin - _id_E68CF76E0696CA00);
    }

    _id_32149F41AB89B731 = _id_ACF69B6C3FBFE7B0.origin[2];

    if(isDefined(spawnpoint))
      _id_32149F41AB89B731 = spawnpoint.origin[2];

    animstruct.origin = (targetpos[0], targetpos[1], _id_32149F41AB89B731 + (_id_689A1188271A0BE5[2] - _id_E68CF76E0696CA00[2]));
    animstruct.angles = _id_ACF69B6C3FBFE7B0.angles;
    animstruct._id_F69BA77714DAC6C2 = spawnStruct();
    animstruct._id_F69BA77714DAC6C2.origin = _id_689A1188271A0BE5;
    animstruct._id_F69BA77714DAC6C2.angles = animstruct.angles;
  } else {
    animstruct._id_F69BA77714DAC6C2 = spawnStruct();
    animstruct._id_F69BA77714DAC6C2.origin = animstruct.origin;
    animstruct._id_F69BA77714DAC6C2.angles = animstruct.angles;
  }

  return animstruct;
}

_id_1E328368618D72DA(team) {
  wait 2.0;

  if(_id_4480C6CE37B2BDF3::_id_A7F9424636F37FB1())
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("match_intro_generic", team);
  else
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("match_intro", team);

  wait 15.0;

  if(!istrue(level._id_644A33D86D8514BF))
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_contract_reminder", scripts\mp\utility\teams::getteamdata(team, "players"));
}

_id_0706EAF553CDB684(_id_5940F376A254619D, path, time) {
  starttime = gettime();
  totaldist = 0;

  for(_id_AC0E594AC96AA3A8 = path.size - 1; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
    path[_id_AC0E594AC96AA3A8].dist = distance(path[_id_AC0E594AC96AA3A8].origin, path[_id_AC0E594AC96AA3A8 - 1].origin);
    totaldist = totaldist + path[_id_AC0E594AC96AA3A8].dist;
  }

  _id_969E785C4E00A1D1 = 0;
  _id_976824F5544DC282 = 0;

  for(_id_AC0E594AC96AA3A8 = path.size - 1; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
    _id_E4419D3414ABDD13 = path[_id_AC0E594AC96AA3A8].dist / totaldist;
    _id_969E785C4E00A1D1 = _id_976824F5544DC282;
    _id_976824F5544DC282 = _id_976824F5544DC282 + _id_E4419D3414ABDD13;
    _id_77B3F0514A25C019 = (gettime() - starttime) / 1000 / time;

    while(_id_77B3F0514A25C019 < _id_976824F5544DC282) {
      _id_77B3F0514A25C019 = (gettime() - starttime) / 1000 / time;
      _id_774E0F07388B5AAB = (_id_77B3F0514A25C019 - _id_969E785C4E00A1D1) / _id_E4419D3414ABDD13;
      _id_5940F376A254619D.angles = anglelerpquatfrac(path[_id_AC0E594AC96AA3A8].angles, path[_id_AC0E594AC96AA3A8 - 1].angles, _id_774E0F07388B5AAB);
      _id_5940F376A254619D.origin = vectorlerp(path[_id_AC0E594AC96AA3A8].origin, path[_id_AC0E594AC96AA3A8 - 1].origin, _id_774E0F07388B5AAB);
      waitframe();
    }
  }
}

_id_67AD64CCFB9082A8(animstruct, _id_E26F44ACAD48DDD1, _id_9F18E73F8F2216F5) {
  self notify("dmz_playInfil");
  self endon("disconnect");
  thread _id_4A22EEF220BFF896();
  thread scripts\cp_mp\utility\inventory_utility::_id_FC6A5B145563BE33();
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated(self._id_1CD92A64C5B20FA0, self.origin, self.angles);
  self cameraunlink();
  animstruct scripts\common\anim::anim_first_frame_solo(self.player_rig, _id_E26F44ACAD48DDD1 + "intro");
  self cameralinkTo(animstruct.cam, "tag_origin", 1, 1);
  self setclientdvar("cg_fov", 40);

  if(isDefined(_id_9F18E73F8F2216F5) && getdvarint("dvar_5BDA28FA688A245C", 0) == 1) {
    _id_51434CE2F3AC3CFF = [_id_9F18E73F8F2216F5];

    for(_id_C80EAEAC6487D3B9 = _id_9F18E73F8F2216F5; isDefined(_id_C80EAEAC6487D3B9.target); _id_51434CE2F3AC3CFF[_id_51434CE2F3AC3CFF.size] = _id_C80EAEAC6487D3B9)
      _id_C80EAEAC6487D3B9 = scripts\engine\utility::getStruct(_id_C80EAEAC6487D3B9.target, "targetname");

    animstruct thread _id_0706EAF553CDB684(animstruct.cam, _id_51434CE2F3AC3CFF, getanimlength(%iw9_mp_dmz_infil_player1_intro));
  } else if(level._id_4CA71DF7C9F87195 == 1) {
    _id_4752910CFABA108A = _id_E26F44ACAD48DDD1;

    if(isDefined(animstruct.script_parameters))
      _id_4752910CFABA108A = animstruct.script_parameters;

    animstruct._id_F69BA77714DAC6C2 thread scripts\common\anim::anim_single_solo(animstruct.cam, _id_4752910CFABA108A);
  }

  self attach("offhand2h_wm_tablet_dmz", "tag_accessory_left");
  animstruct thread scripts\mp\anim::anim_player_solo(self, self.player_rig, _id_E26F44ACAD48DDD1 + "intro");
  self playlocalsound("dmz_camera_zoom_in");
  _id_AC1EA7394A9A1A08 = getanimlength(%iw9_mp_dmz_infil_player1_intro);
  wait(_id_AC1EA7394A9A1A08 - 1.8);

  if(isDefined(self.hidehudenabled))
    scripts\mp\utility\player::hidehuddisable();

  if(getdvarint("dvar_8DA4A5E690432CD0", 1) == 1) {
    thread _id_DFF9480861B2ACB1();
    scripts\mp\utility\player::_freezecontrols(0, 1);
  }

  wait 1.8;

  if(level._id_E97FD1B659D67F4F == -1)
    thread _id_E31AB6A7EBEF3680();
  else
    thread _id_80959DD6D2C10831(level._id_E97FD1B659D67F4F);

  self clearadditionalstreampos();
  _id_2B14C4DBF6EBD391(animstruct, _id_E26F44ACAD48DDD1, 1);
  animstruct thread scripts\mp\anim::anim_player_solo(self, self.player_rig, _id_E26F44ACAD48DDD1 + "exit");

  if(getdvarint("dvar_E985D309E4BF9569", 0) == 1)
    thread _id_F43A907C9B43B440(animstruct.cam);
  else
    thread _id_F687B7EA0DA59A4C(animstruct);

  _id_539A64D23AA56D91 = getanimlength(%iw9_mp_dmz_infil_player1_exit);
  wait(_id_539A64D23AA56D91);
  _id_076651B5D03AD861 = self getattachsize();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_076651B5D03AD861; _id_AC0E594AC96AA3A8++) {
    attached = self getattachmodelname(_id_AC0E594AC96AA3A8);

    if(attached == "offhand2h_wm_tablet_dmz")
      self detach("offhand2h_wm_tablet_dmz", "tag_accessory_left");
  }

  if(getdvarint("dvar_8DA4A5E690432CD0", 1) == 0)
    scripts\mp\utility\player::_freezecontrols(0);

  scripts\mp\utility\player::_freezelookcontrols(0);

  if(level._id_4CA71DF7C9F87195 == 1)
    animstruct.cam delete();

  self notify("dmzInfil_complete");
}

_id_4A22EEF220BFF896() {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_timeout_1(30, "dmzInfil_complete");
  wait 5;

  if(self getclientomnvar("ui_world_fade") > 0)
    scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 0, 0.5);

  if(self getclientomnvar("ui_total_fade") > 0)
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.5);
}

_id_E31AB6A7EBEF3680() {
  self endon("death_or_disconnect");
  self endon("dmzInfil_stopIdle");
  level waittill("prematch_done");
  self setclientomnvar("ui_dmz_mission_overlay", 0);
  self notify("dmzInfil_stopIdle");
}

_id_80959DD6D2C10831(maxtime) {
  self endon("death_or_disconnect");
  self endon("dmzInfil_stopIdle");
  wait(maxtime);
  self setclientomnvar("ui_dmz_mission_overlay", 0);
  self notify("dmzInfil_stopIdle");
}

_id_2B14C4DBF6EBD391(animstruct, _id_E26F44ACAD48DDD1, _id_906A882502DD814A) {
  self endon("death_or_disconnect");
  self endon("dmzInfil_stopIdle");
  thread _id_C5693AEE7D75230A(animstruct, _id_E26F44ACAD48DDD1);
  wait(_id_906A882502DD814A);

  while(!istrue(self._id_9DE396B15A642DE3))
    waitframe();

  self notify("dmzInfil_stopIdle");
}

_id_C5693AEE7D75230A(animstruct, _id_E26F44ACAD48DDD1) {
  self endon("death_or_disconnect");
  self endon("dmzInfil_stopIdle");
  animlength = getanimlength(level.scr_anim[self.player_rig.animname][_id_E26F44ACAD48DDD1 + "idle"]);

  if(animlength < 0.1)
    return;
  else {
    for(;;) {
      if(!isDefined(self) || !isDefined(self.player_rig) || !scripts\mp\utility\player::isreallyalive(self) || !isDefined(animstruct)) {
        return;
      }
      animstruct thread scripts\mp\anim::anim_player_solo(self, self.player_rig, _id_E26F44ACAD48DDD1 + "idle");
      wait(animlength);
    }
  }
}

_id_DFF9480861B2ACB1() {
  self setclientomnvar("ui_dmz_mission_overlay", 1);
}

_id_301D27FDA3EC6B41(_id_FABF84450735DD93) {
  timer = 0;
  players = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");

  for(;;) {
    timer = timer + level.framedurationseconds;
    _id_19CC131BC3772E16 = 1;

    foreach(player in players) {
      if(!istrue(player.pers["streamSyncComplete"]) || player.model == "")
        _id_19CC131BC3772E16 = 0;
    }

    if(_id_19CC131BC3772E16) {
      return;
    }
    waitframe();
  }
}

_id_0F58B70C3D35C2F5() {
  scripts\mp\utility\player::_freezecontrols(1);
  scripts\mp\utility\player::_freezelookcontrols(1);

  while(self.model == "")
    waitframe();
}

_id_F687B7EA0DA59A4C(animstruct) {
  self endon("disconnect");
  scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 1, 0.5);
  self lerpfovbypreset("default");
  self cameraunlink();

  if(scripts\mp\utility\player::isreallyalive(self)) {
    if(isDefined(self.player_rig))
      self.player_rig scripts\mp\utility\infilexfil::handleweaponstatenotetrack("drop");

    wait 0.2;

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(self.player_rig))
      self.player_rig scripts\mp\utility\infilexfil::handleweaponstatenotetrack("raise");
  }

  self setplayerangles(animstruct.angles);
  self notify("remove_rig");
  self notify("screen_completely_black");
  scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 0, 0.5);
}

_id_F43A907C9B43B440(cam) {
  _id_64177B5A8B8ADBA4 = _id_E5F3A754C68EF261(cam.origin, cam.angles);
  targetpos = self getEye();
  targetangles = self.angles;
  self cameralinkTo(_id_64177B5A8B8ADBA4, "tag_origin", 1, 1);
  _id_64177B5A8B8ADBA4 moveTo(targetpos, 1);
  _id_64177B5A8B8ADBA4 rotateTo(targetangles, 1, 0.5);
  wait 1;
  self lerpfovbypreset("default");
  self cameraunlink();
  self notify("remove_rig");
  _id_64177B5A8B8ADBA4 delete();
}

_id_C8556D47C98BB0EC(_id_FABF84450735DD93, node) {
  level._id_EF3308C96486E0A9 = 1;
  level._id_74E71AD99C620255[_id_FABF84450735DD93] = node;
  _id_C9001909B0E28B18(_id_FABF84450735DD93, "dmz_infil_", node);
}

_id_6D198A62F4EFE4A7() {
  if(!isDefined(level._id_6FC7BE33ECE5533A)) {
    level._id_6FC7BE33ECE5533A = [];

    foreach(player in level.players) {
      if(scripts\engine\utility::array_contains(level._id_6FC7BE33ECE5533A, player.team)) {
        continue;
      }
      level._id_6FC7BE33ECE5533A[level._id_6FC7BE33ECE5533A.size] = player.team;
    }
  }

  level._id_4DEC411F05D13CAA = 0;
  player = level.players[0];
  level._id_9A816FF63217244A = scripts\engine\utility::array_combine(level._id_C40817516B7D2B68[0].points, level._id_C40817516B7D2B68[1].points);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_9A816FF63217244A.size; _id_AC0E594AC96AA3A8++) {
    offset = 0;

    foreach(team in level._id_6FC7BE33ECE5533A) {
      index = _id_AC0E594AC96AA3A8 + offset;

      if(index > level._id_9A816FF63217244A.size)
        index = index - level._id_9A816FF63217244A.size;

      _id_C8556D47C98BB0EC(team, level._id_9A816FF63217244A[index]);
      offset = offset + 1;
    }

    _id_937491868C5DA50F = level._id_7DF8A2D09A6044A2;

    if(istrue(level._id_4DEC411F05D13CAA)) {
      return;
    }
    wait(_id_937491868C5DA50F);

    if(istrue(level._id_4DEC411F05D13CAA))
      return;
  }
}

_id_97A8D8477D7B7D01(index) {
  player = level.players[0];
  level._id_4DEC411F05D13CAA = 1;
  _id_C8556D47C98BB0EC(player.team, level._id_C40817516B7D2B68.points[index]);
}

_id_843789F93292C6B7() {
  player = level.players[0];
  level._id_4DEC411F05D13CAA = 1;
  _id_42CA41C7DADAE0C0 = distancesquared(level._id_C40817516B7D2B68[0].points[0].origin, player.origin);
  targetnode = level._id_C40817516B7D2B68[0].points[0];

  foreach(_id_9BF46F9D9E9F78F4 in level._id_C40817516B7D2B68) {
    foreach(point in _id_9BF46F9D9E9F78F4.points) {
      dist = distancesquared(point.origin, player.origin);

      if(_id_42CA41C7DADAE0C0 > dist)
        targetnode = point;
    }
  }

  _id_C8556D47C98BB0EC(player.team, targetnode);
}