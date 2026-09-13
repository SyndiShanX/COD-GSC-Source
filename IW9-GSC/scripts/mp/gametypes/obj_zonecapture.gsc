/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_zonecapture.gsc
****************************************************/

setupobjective(trigger, visuals, _id_5DDBC1FAED2C56E6, _id_08B9949739F4E0F6) {
  zone = trigger;

  if(!isDefined(visuals)) {
    visuals = [];
    visuals[0] = zone;
  }

  if(istrue(_id_5DDBC1FAED2C56E6))
    _id_3C2389BA69E5822B = 0;
  else
    _id_3C2389BA69E5822B = undefined;

  zone = scripts\mp\gameobjects::createuseobject("neutral", zone, visuals, (0, 0, 0), _id_3C2389BA69E5822B, _id_08B9949739F4E0F6);
  zone scripts\mp\gameobjects::disableobject();
  _id_C8F4C582625F492D = _func_1823FF50BB28148D(scripts\mp\utility\game::getgametype());

  if(_id_C8F4C582625F492D == "stat_E16C1F723535FEBD") {} else if(_id_C8F4C582625F492D == "stat_018BECD72BBC155B" || _id_C8F4C582625F492D == "stat_6A87626330D9D40E") {
    for(index = 0; index < zone.visuals.size; index++)
      zone.visuals[index] hide();
  } else
    zone.visuals[0] scriptmodelplayanim("iw8_mp_military_hq_crate_close");

  zone scripts\mp\gameobjects::cancontestclaim(1);
  zone.claimgracetime = level.zonecapturetime * 1000;
  zone scripts\mp\gameobjects::pinobjiconontriggertouch();

  if(isDefined(trigger.objectivekey))
    zone.objectivekey = trigger.objectivekey;
  else
    zone.objectivekey = zone scripts\mp\gameobjects::getlabel();

  if(_id_C8F4C582625F492D == "stat_08BA4707B55E9B12" || _id_C8F4C582625F492D == "stat_E16C1F723535FEBD")
    zone scripts\mp\gameobjects::mustmaintainclaim(0);
  else
    zone scripts\mp\gameobjects::mustmaintainclaim(1);

  zone.id = "hardpoint";

  if(isDefined(zone.trigger.target) && _id_C8F4C582625F492D == "stat_018BECD72BBC155B" || _id_C8F4C582625F492D == "stat_6A87626330D9D40E")
    zone thread assignchevrons(zone.trigger.target, zone.trigger.script_label);

  return zone;
}

postshipmodifiedkothzones(zone) {
  if(level.mapname == "mp_parkour") {
    if(zone.script_label == "1")
      zone.origin = zone.origin + (0, 0, 135);
  }

  if(level.mapname == "mp_fallen") {
    if(zone.script_label == "3")
      zone.origin = zone.origin - (0, 0, 50);
  }

  if(level.mapname == "mp_junk") {
    if(zone.script_label == "4")
      zone.origin = zone.origin - (0, 7, 0);
  }

  return zone;
}

assignchevrons(target, label) {
  zone = self;
  wait 1.0;
  _id_C236336A4B27E7DA = getentitylessscriptablearray(target, "targetname");
  _id_C236336A4B27E7DA = removechevronsfromarray(_id_C236336A4B27E7DA, label);
  _id_C236336A4B27E7DA = postshipmodifychevrons(_id_C236336A4B27E7DA, label);
  chevrons = [];

  foreach(visual in _id_C236336A4B27E7DA) {
    index = chevrons.size;
    chevrons[index] = visual;
    chevrons[index].numchevrons = 1;

    if(isDefined(visual.script_noteworthy)) {
      if(visual.script_noteworthy == "2") {
        chevrons[index].numchevrons = 2;
        continue;
      }

      if(visual.script_noteworthy == "3") {
        chevrons[index].numchevrons = 3;
        continue;
      }

      if(visual.script_noteworthy == "4")
        chevrons[index].numchevrons = 4;
    }
  }

  zone.chevrons = chevrons;
}

updatechevrons(state) {
  _id_C8F4C582625F492D = _func_1823FF50BB28148D(scripts\mp\utility\game::getgametype());

  if(_id_C8F4C582625F492D != "stat_018BECD72BBC155B" && _id_C8F4C582625F492D != "stat_6A87626330D9D40E") {
    return;
  }
  zone = self;
  zone notify("updateChevrons");
  zone endon("updateChevrons");

  while(!isDefined(zone.chevrons))
    waitframe();

  foreach(_id_0EAE85273686F4F4 in zone.chevrons) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0EAE85273686F4F4.numchevrons; _id_AC0E594AC96AA3A8++)
      _id_0EAE85273686F4F4 setscriptablepartstate("chevron_" + _id_AC0E594AC96AA3A8, state);
  }
}

activatezone(objid) {
  zone = self;
  zone.onuse = ::zone_onuse;
  zone.onbeginuse = ::zone_onusebegin;
  zone.onuseupdate = ::zone_onuseupdate;
  zone.onenduse = ::zone_onuseend;
  zone.onunoccupied = ::zone_onunoccupied;
  zone.oncontested = ::zone_oncontested;
  zone.onuncontested = ::zone_onuncontested;
  zone.stompprogressreward = ::zone_stompprogressreward;
  zone.onpinnedstate = ::zone_onpinnedstate;
  zone.onunpinnedstate = ::zone_onunpinnedstate;
  zone.didstatusnotify = 0;
  _id_C8F4C582625F492D = _func_1823FF50BB28148D(scripts\mp\utility\game::getgametype());

  if(isDefined(objid) && _id_C8F4C582625F492D == "stat_6A87626330D9D40E")
    zone scripts\mp\gameobjects::requestid(1, 1, objid, 1, 0);
  else
    zone scripts\mp\gameobjects::requestid(1, 1, 0, 1, 0);

  _id_40DB97C5DB5E1E3E = zone.curorigin;

  if(isDefined(level.gethillspawnshutofforigin))
    _id_40DB97C5DB5E1E3E = [[level.gethillspawnshutofforigin]]();

  dangerzoneradius = 1024;

  if(isDefined(level.gethillspawnshutoffradius))
    dangerzoneradius = [[level.gethillspawnshutoffradius]]();

  dangerzoneids = [];
  dangerzoneids[dangerzoneids.size] = scripts\mp\spawnlogic::addspawndangerzone(_id_40DB97C5DB5E1E3E - (0, 0, 2048), dangerzoneradius, 4096, "allies", undefined, undefined, undefined, undefined, undefined, 1);
  dangerzoneids[dangerzoneids.size] = scripts\mp\spawnlogic::addspawndangerzone(_id_40DB97C5DB5E1E3E - (0, 0, 2048), dangerzoneradius, 4096, "axis", undefined, undefined, undefined, undefined, undefined, 1);
  zone.dangerzoneids = dangerzoneids;

  if(_id_C8F4C582625F492D == "stat_018BECD72BBC155B" || _id_C8F4C582625F492D == "stat_FB49AD7243D37B76") {
    zone.ignorestomp = 1;
    zone.alwaysstalemate = 1;

    if(istrue(level._id_64C1863A9E80414E)) {
      zone.alwaysstalemate = 0;
      zone._id_88806E65C3197677 = 1;
    }
  } else {
    zone.stompeenemyprogressupdate = ::zone_stompeenemyprogressupdate;
    scripts\mp\objidpoolmanager::update_objective_position(zone.objidnum, zone.visuals[0].origin + (0, 0, 70));
  }
}

deactivatezone() {
  zone = self;
  zone.onuse = undefined;
  zone.onbeginuse = undefined;
  zone.onuseupdate = undefined;
  zone.onunoccupied = undefined;
  zone.oncontested = undefined;
  zone.onuncontested = undefined;
  zone.stalemate = 0;
  zone.wasstalemate = 0;
  zone.didstatusnotify = 0;
  zone thread updatechevrons("off");

  foreach(_id_DD73EB1591960567 in zone.dangerzoneids)
  scripts\mp\spawnlogic::removespawndangerzone(_id_DD73EB1591960567);

  zone.dangerzoneids = undefined;

  foreach(player in level.players)
  scripts\mp\objidpoolmanager::objective_unpin_player(zone.objidnum, player);

  zone.trigger scripts\engine\utility::trigger_off();
  zone thread waitthensetvisibleteam();
  zone scripts\mp\gameobjects::releaseid(1, 0);
  _id_C8F4C582625F492D = _func_1823FF50BB28148D(scripts\mp\utility\game::getgametype());

  if(_id_C8F4C582625F492D == "stat_08BA4707B55E9B12") {
    zone.visuals[0] playSound("mp_hq_deactivate_sfx");
    thread scripts\mp\music_and_dialog::headquarters_deactivate_music(zone.lastclaimteam);
    zone.visuals[0] scriptmodelplayanim("iw8_mp_military_hq_crate_close");
    zone.visuals[0] stoploopsound();
  }

  level.scoreleadchanged = 0;
}

zonetimerwait() {
  level endon("game_ended");
  level endon("dev_force_zone");
  _id_FF049FF4093F7A4E = int(level.zonemovetime * 1000 + gettime());

  if(!isDefined(level.zoneselectiondelay) || level.zoneselectiondelay < 10)
    thread hp_move_soon(level.zonemovetime);

  level thread handlehostmigration(_id_FF049FF4093F7A4E);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.zonemovetime);
}

hp_move_soon(timer) {
  level endon("game_ended");
  _id_C8F4C582625F492D = _func_1823FF50BB28148D(scripts\mp\utility\game::getgametype());

  if(_id_C8F4C582625F492D == "stat_08BA4707B55E9B12")
    level endon("zone_destroyed");

  if(isDefined(level._id_088EA071F9ABF23E))
    timer = max(timer - level._id_088EA071F9ABF23E, 0.0);

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(timer);

  if(isDefined(level._id_FBB04FF4FFA6D364)) {
    scripts\mp\objidpoolmanager::objective_set_play_intro(1, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(1, 0);
    scripts\mp\objidpoolmanager::update_objective_state(1, "current");
    scripts\mp\objidpoolmanager::update_objective_position(1, level._id_FBB04FF4FFA6D364.visuals[0].origin + level._id_FBB04FF4FFA6D364.offset3d);
    level._id_FBB04FF4FFA6D364 scripts\mp\gameobjects::setvisibleteam("any", 1);
    level._id_FBB04FF4FFA6D364 scripts\mp\gameobjects::setobjectivestatusicons(level._id_7520A0FC17909B95, level._id_7520A0FC17909B95, 1);
  } else if(isDefined(level._id_E7E94C1FECA60900) && isDefined(level._id_7F2484C1D7066D39))
    level thread[[level._id_7F2484C1D7066D39]]();

  if(timer < 3.0)
    wait 3.0;

  foreach(_id_F90358454413407F in level.teamnamelist)
  level scripts\mp\utility\dialog::statusdialog("hp_move_soon", _id_F90358454413407F);
}

handlehostmigration(_id_FF049FF4093F7A4E) {
  level endon("game_ended");
  level endon("bomb_defused");
  level endon("disconnect");
  level endon("zone_captured");
  level waittill("host_migration_begin");
  setomnvar("ui_objective_timer_stopped", 1);
  _id_3B5803E733581858 = scripts\mp\hostmigration::waittillhostmigrationdone();
  setomnvar("ui_objective_timer_stopped", 0);

  if(_id_3B5803E733581858 > 0)
    setomnvar("ui_hardpoint_timer", level.zoneendtime + _id_3B5803E733581858);
  else
    setomnvar("ui_hardpoint_timer", level.zoneendtime);
}

hardpoint_setneutral() {
  zone = self;
  zone notify("flag_neutral");
  zone scripts\mp\gameobjects::setownerteam("neutral");
  playhardpointneutralfx();
  zone thread updatechevrons("idle");
}

trackgametypevips() {
  thread cleanupgametypevips();
  level endon("game_ended");
  level endon("zone_moved");
  zone = self;

  for(;;) {
    foreach(player in level.players) {
      if(player istouching(zone.trigger)) {
        player setgametypevip(1);
        continue;
      }

      player setgametypevip(0);
    }

    wait 0.5;
  }
}

cleanupgametypevips() {
  level scripts\engine\utility::waittill_any_2("game_ended", "zone_moved");

  foreach(player in level.players)
  player setgametypevip(0);
}

zone_onuse(_id_22282E7D48CA3400) {
  if(!isDefined(_id_22282E7D48CA3400) || !isDefined(_id_22282E7D48CA3400.team)) {
    return;
  }
  zone = self;
  scripts\mp\objidpoolmanager::objective_set_progress(zone.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(zone.objidnum, 0);
  _id_8C4EC3E8ADAFD3FF = _id_22282E7D48CA3400.team;
  capturetime = gettime();
  touchlist = [];
  _id_BCCFAF72141AE300 = getarraykeys(zone.touchlist[_id_8C4EC3E8ADAFD3FF]);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_BCCFAF72141AE300.size; _id_AC0E594AC96AA3A8++)
    touchlist[_id_BCCFAF72141AE300[_id_AC0E594AC96AA3A8]] = zone.touchlist[_id_8C4EC3E8ADAFD3FF][_id_BCCFAF72141AE300[_id_AC0E594AC96AA3A8]];

  _id_C8F4C582625F492D = _func_1823FF50BB28148D(scripts\mp\utility\game::getgametype());

  if(_id_C8F4C582625F492D == "stat_018BECD72BBC155B")
    level notify("Objective_SetShowProgress", zone.objidnum);

  if(_id_C8F4C582625F492D == "stat_08BA4707B55E9B12" && zone.ownerteam != "neutral") {
    setomnvar("ui_hq_ownerteam", 0);
    level notify("zone_destroyed");

    foreach(player in level.players)
    scripts\mp\objidpoolmanager::objective_unpin_player(zone.objidnum, player);

    zone thread waitthensetvisibleteam();
    level _id_734EA6311B19A424::updateservericons("zone_shift", 0);

    if(isDefined(touchlist)) {
      _id_59DB5D0F4E3000A7 = getarraykeys(touchlist);

      foreach(playerid in _id_59DB5D0F4E3000A7) {
        player = zone.assisttouchlist[_id_8C4EC3E8ADAFD3FF][playerid].player;

        if(isDefined(player.owner))
          player = player.owner;

        if(!isPlayer(player)) {
          continue;
        }
        player scripts\cp_mp\challenges::oncapture();
      }
    }

    level thread _id_154439FDBDB10B95::give_capture_credit(touchlist, capturetime, _id_8C4EC3E8ADAFD3FF, undefined, _id_22282E7D48CA3400, zone);

    if(_id_C8F4C582625F492D == "stat_08BA4707B55E9B12") {
      level scripts\mp\utility\dialog::statusdialog("hp_timeout", _id_22282E7D48CA3400.team);
      level scripts\mp\utility\dialog::statusdialog("hp_owned_lost", zone.ownerteam);
      return;
    }

    level scripts\mp\utility\dialog::statusdialog("hp_captured_friendly", _id_22282E7D48CA3400.team);
    level scripts\mp\utility\dialog::statusdialog("hp_captured_enemy", zone.ownerteam);
    return;
  } else {
    if(_id_C8F4C582625F492D == "stat_08BA4707B55E9B12") {
      _id_3B8DBAE5DDC5D624 = scripts\mp\utility\teams::getteamdata(_id_8C4EC3E8ADAFD3FF, "players");

      foreach(player in _id_3B8DBAE5DDC5D624) {
        player scripts\cp_mp\challenges::oncapture();
        player.skipspawncamera = 1;
      }
    }

    _id_8A04AA0E0755E7E3 = zone scripts\mp\gameobjects::getownerteam();
    otherteam = scripts\mp\utility\game::getotherteam(_id_8C4EC3E8ADAFD3FF)[0];
    zone scripts\mp\gameobjects::setownerteam(_id_8C4EC3E8ADAFD3FF);

    if(_id_C8F4C582625F492D == "stat_08BA4707B55E9B12") {
      setomnvar("ui_hq_ownerteam", _id_154439FDBDB10B95::gethqownerteamvalue(zone.ownerteam));
      setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::getteamdata(zone.ownerteam, "aliveCount"));
    }

    if(_id_C8F4C582625F492D == "stat_08BA4707B55E9B12") {
      level thread _id_154439FDBDB10B95::awardcapturepoints();
      _id_E3F1A73A39054069 = scripts\mp\gamescore::_getteamscore(_id_8C4EC3E8ADAFD3FF);
      _id_AC865A705B3E1162 = scripts\mp\gamescore::_getteamscore(otherteam);

      if(_id_E3F1A73A39054069 > _id_AC865A705B3E1162)
        level.scoreleadchanged = 1;

      adjustmatchtimerpausedstatefromscore(_id_8C4EC3E8ADAFD3FF);
    } else if(isDefined(level._id_A9BDEF06142064A3))
      level thread[[level._id_A9BDEF06142064A3]](zone, _id_22282E7D48CA3400);
    else {
      level thread _id_734EA6311B19A424::awardcapturepoints();

      if(level.pausemodetimer)
        level scripts\mp\gamelogic::pausetimer();
    }

    level.usestartspawns = 0;
    _id_65FBB1944E8B5D4D = 0;
    zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
    level _id_734EA6311B19A424::updateservericons(_id_8C4EC3E8ADAFD3FF, 0);

    if(_id_C8F4C582625F492D == "stat_08BA4707B55E9B12") {
      thread scripts\mp\utility\print::printandsoundoneveryone(_id_8C4EC3E8ADAFD3FF, otherteam, undefined, undefined, "mp_dom_flag_captured", undefined, _id_22282E7D48CA3400);
      thread scripts\mp\music_and_dialog::headquarters_captured_music();
    }

    if(!isDefined(level.lastcaptureteam) || level.lastcaptureteam != _id_8C4EC3E8ADAFD3FF) {
      if(_id_C8F4C582625F492D == "stat_08BA4707B55E9B12") {
        if(isDefined(level.kothhillrotation && level.kothhillrotation == 0))
          level.delayleadtakendialog = 4;
        else
          level.delayleadtakendialog = undefined;

        level thread delaydialogstatustoavoidcaptureoverlap(_id_8C4EC3E8ADAFD3FF, otherteam);
      }

      if(_id_C8F4C582625F492D == "stat_6A87626330D9D40E") {} else if(_id_C8F4C582625F492D == "stat_018BECD72BBC155B" || _id_C8F4C582625F492D == "stat_FB49AD7243D37B76")
        level thread _id_734EA6311B19A424::give_capture_credit(touchlist, capturetime, _id_8C4EC3E8ADAFD3FF, level.lastcaptureteam, _id_22282E7D48CA3400, zone);
      else
        level thread _id_154439FDBDB10B95::give_capture_credit(touchlist, capturetime, _id_8C4EC3E8ADAFD3FF, level.lastcaptureteam, _id_22282E7D48CA3400, zone);
    }

    foreach(_id_80CE5B9516CCA684 in level.players)
    zone showcapturedhardpointeffecttoplayer(_id_8C4EC3E8ADAFD3FF, _id_80CE5B9516CCA684);

    zone thread updatechevrons(_id_8C4EC3E8ADAFD3FF);

    if(_id_C8F4C582625F492D == "stat_08BA4707B55E9B12") {
      zone.visuals[0] stoploopsound();
      zone.visuals[0] scriptmodelplayanim("iw8_mp_military_hq_crate_open_idle");
      players = scripts\mp\utility\teams::getteamdata(_id_8C4EC3E8ADAFD3FF, "players");

      foreach(player in players)
      player thread _id_154439FDBDB10B95::showrespawnwarningmessage();
    }

    level.hpcapteam = _id_8C4EC3E8ADAFD3FF;
    zone.capturecount++;
    level.lastcaptureteam = _id_8C4EC3E8ADAFD3FF;
    level notify("zone_captured");
    level notify("zone_captured" + _id_8C4EC3E8ADAFD3FF);
  }
}

waitthensetvisibleteam() {
  zone = self;
  waitframe();
  zone scripts\mp\gameobjects::setvisibleteam("none");
}

zone_onusebegin(player) {
  player.isonobjective = 1;
  zone = self;
  _id_C8F4C582625F492D = _func_1823FF50BB28148D(scripts\mp\utility\game::getgametype());

  if(_id_C8F4C582625F492D == "stat_08BA4707B55E9B12") {
    ownerteam = zone scripts\mp\gameobjects::getownerteam();

    if(ownerteam != "neutral" && zone.claimteam != ownerteam)
      adjustmatchtimerpausedstatefromscore(ownerteam, 1);

    if(!istrue(zone.stalemate)) {
      if(ownerteam == "neutral")
        player setclientomnvar("ui_objective_pinned_text_param", 1);
      else
        player setclientomnvar("ui_objective_pinned_text_param", 2);
    }
  }

  if(!isDefined(zone.statusnotifytime))
    zone.statusnotifytime = gettime();

  if(zone.statusnotifytime > zone.statusnotifytime + 10000) {
    zone.didstatusnotify = 0;
    zone.statusnotifytime = gettime();
  }

  zone scripts\mp\gameobjects::setusetime(level.zonecapturetime);

  if(level.zonecapturetime > 0) {
    zone.prevownerteam = scripts\mp\utility\game::getotherteam(player.team)[0];
    zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosing, level.icontaking);
  }
}

zone_onuseupdate(team, progress, _id_301D62DA1A0738F1, _id_4B22E50E504339FE) {
  zone = self;
  zone scripts\mp\objidpoolmanager::_id_9B1A086F348520B0(zone.objidnum, team);
  ownerteam = zone scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral" && zone.claimteam != ownerteam)
    adjustmatchtimerpausedstatefromscore(zone.claimteam);
  else if(ownerteam != "neutral" && zone.claimteam != ownerteam)
    adjustmatchtimerpausedstatefromscore(ownerteam, 1);
  else if(level.pausemodetimer)
    level scripts\mp\gamelogic::pausetimer();

  _id_C8F4C582625F492D = _func_1823FF50BB28148D(scripts\mp\utility\game::getgametype());

  if(_id_C8F4C582625F492D == "stat_08BA4707B55E9B12" && progress < 1.0 && !level.gameended)
    playcapturesound(progress, team);

  ownerteam = zone scripts\mp\gameobjects::getownerteam();
  otherteam = scripts\mp\utility\game::getotherteam(team)[0];

  if(progress > 0.05 && _id_301D62DA1A0738F1 && !zone.didstatusnotify && _id_C8F4C582625F492D != "stat_6A87626330D9D40E") {
    if(ownerteam == "neutral") {
      scripts\mp\utility\dialog::statusdialog("hp_capturing_friendly", team);
      scripts\mp\utility\dialog::statusdialog("hp_capturing_enemy", otherteam);
    } else if(_id_C8F4C582625F492D == "stat_08BA4707B55E9B12") {
      scripts\mp\utility\dialog::statusdialog("hp_disabling_friendly", ownerteam);
      scripts\mp\utility\dialog::statusdialog("hp_disabling_enemy", team);
    } else {
      scripts\mp\utility\dialog::statusdialog("hp_capturing_enemy", ownerteam);
      scripts\mp\utility\dialog::statusdialog("hp_capturing_friendly", team);
    }

    zone.didstatusnotify = 1;
  }
}

delaydialogstatustoavoidcaptureoverlap(_id_8C4EC3E8ADAFD3FF, otherteam) {
  wait 0.5;
  level scripts\mp\utility\dialog::statusdialog("hp_secured_friendly", _id_8C4EC3E8ADAFD3FF);
  level scripts\mp\utility\dialog::statusdialog("hp_captured_enemy", otherteam);
}

playcapturesound(progress, team) {
  zone = self;

  if(!isDefined(zone.lastsfxplayedtime))
    zone.lastsfxplayedtime = gettime();

  if(zone.lastsfxplayedtime + 995 < gettime()) {
    zone.lastsfxplayedtime = gettime();
    _id_C3DDFB0EAA8F761C = "";
    progress = int(floor(progress * 10));
    _id_C3DDFB0EAA8F761C = "mp_dom_capturing_tick_0" + progress;
    zone.visuals[0] playsoundtoteam(_id_C3DDFB0EAA8F761C, team);
  }
}

zone_onuseend(team, player, success) {
  if(isDefined(player))
    player.isonobjective = 0;

  zone = self;
  ownerteam = zone scripts\mp\gameobjects::getownerteam();
  level notify("stop_contested_stats_thread");

  if(!success) {
    _id_C8F4C582625F492D = _func_1823FF50BB28148D(scripts\mp\utility\game::getgametype());

    if(_id_C8F4C582625F492D == "stat_08BA4707B55E9B12") {
      if(ownerteam != "neutral")
        adjustmatchtimerpausedstatefromscore(ownerteam);
    } else if(level.pausemodetimer)
      level scripts\mp\gamelogic::resumetimer();
  }

  if(isPlayer(player))
    player setclientomnvar("ui_objective_pinned_text_param", 0);

  if(ownerteam == "neutral") {
    zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);

    if(istrue(level.usehpzonebrushes)) {
      foreach(player in level.players)
      zone showzoneneutralbrush(player);
    }
  } else {
    zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

    foreach(player in level.players)
    zone showcapturedhardpointeffecttoplayer(ownerteam, player);
  }
}

zone_onunoccupied() {
  zone = self;
  _id_C8F4C582625F492D = _func_1823FF50BB28148D(scripts\mp\utility\game::getgametype());

  if(_id_C8F4C582625F492D == "stat_08BA4707B55E9B12" && zone.ownerteam != "neutral") {
    zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    adjustmatchtimerpausedstatefromscore(zone.ownerteam);
  } else {
    level notify("zone_destroyed");
    level.hpcapteam = "neutral";

    if(level.pausemodetimer)
      level scripts\mp\gamelogic::resumetimer();

    _id_FA225DAB25CC2762 = 1;

    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(zone.numtouching[_id_F90358454413407F] > 0) {
        _id_FA225DAB25CC2762 = 0;
        break;
      }
    }

    if(_id_FA225DAB25CC2762) {
      if(_id_C8F4C582625F492D == "stat_6A87626330D9D40E") {
        scripts\mp\gameobjects::setownerteam("neutral");

        if(isDefined(zone.usetime)) {
          scripts\mp\objidpoolmanager::objective_set_progress(zone.objidnum, 0);
          scripts\mp\objidpoolmanager::objective_show_progress(zone.objidnum, 0);
        }
      }

      level _id_734EA6311B19A424::updateservericons("neutral", 0);
      zone.wasleftunoccupied = 1;
      zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
      zone playhardpointneutralfx();
      zone thread updatechevrons("idle");
    }
  }

  zone scripts\mp\objidpoolmanager::_id_9B1A086F348520B0(zone.objidnum, "neutral");
}

zone_oncontested() {
  zone = self;
  zone thread _id_734EA6311B19A424::_id_69C581621849DF52();

  if(level.pausemodetimer)
    level scripts\mp\gamelogic::resumetimer();

  zone.contestedtime = gettime();
  ownerteam = zone scripts\mp\gameobjects::getownerteam();
  zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  level _id_734EA6311B19A424::updateservericons(ownerteam, 1);
  zone thread updatechevrons("contested");

  foreach(team in level.teamnamelist) {
    if(zone.touchlist[team].size) {
      touchlist = zone.touchlist[team];
      _id_59DB5D0F4E3000A7 = getarraykeys(touchlist);

      for(index = 0; index < _id_59DB5D0F4E3000A7.size; index++) {
        player = touchlist[_id_59DB5D0F4E3000A7[index]].player;
        player setclientomnvar("ui_objective_pinned_text_param", 3);
      }
    }
  }

  foreach(player in level.players)
  zone showcapturedhardpointeffecttoplayer(ownerteam, player);

  if(ownerteam == "neutral")
    notifyteam = zone.claimteam;
  else
    notifyteam = ownerteam;

  _id_C8F4C582625F492D = _func_1823FF50BB28148D(scripts\mp\utility\game::getgametype());

  if(_id_C8F4C582625F492D != "stat_6A87626330D9D40E") {
    foreach(_id_F90358454413407F in level.teamnamelist)
    scripts\mp\utility\dialog::statusdialog("hp_contested", _id_F90358454413407F);
  }

  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9.player = zone;
  _id_7E2C53B0BCF117D9.eventname = "hill_contested";
  _id_7E2C53B0BCF117D9.position = zone.trigger.origin;
  zone.didstatusnotify = 1;
  zone scripts\mp\objidpoolmanager::_id_9B1A086F348520B0(zone.objidnum, "neutral");
}

zone_onuncontested(lastclaimteam) {
  zone = self;
  level notify("stop_contested_stats_thread");

  if(level.pausemodetimer)
    level scripts\mp\gamelogic::pausetimer();

  ownerteam = zone scripts\mp\gameobjects::getownerteam();

  if(lastclaimteam == "none" || ownerteam == "neutral") {
    zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);

    if(istrue(level.usehpzonebrushes)) {
      foreach(player in level.players)
      zone showzoneneutralbrush(player);
    }

    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = zone;
    _id_7E2C53B0BCF117D9.eventname = "hill_empty";
    _id_7E2C53B0BCF117D9.position = zone.trigger.origin;
  } else {
    _id_C8F4C582625F492D = _func_1823FF50BB28148D(scripts\mp\utility\game::getgametype());

    if(_id_C8F4C582625F492D == "stat_018BECD72BBC155B") {
      scripts\mp\utility\sound::playsoundonplayers("mp_hardpoint_captured_positive", ownerteam);
      scripts\mp\utility\sound::playsoundonplayers("mp_hardpoint_captured_negative", scripts\mp\utility\game::getotherteam(ownerteam)[0]);
    } else if(_id_C8F4C582625F492D == "stat_FB49AD7243D37B76") {
      scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_captured_positive", ownerteam);
      scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_captured_negative", scripts\mp\utility\game::getotherteam(ownerteam)[0]);
    }

    zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

    foreach(player in level.players)
    zone showcapturedhardpointeffecttoplayer(ownerteam, player);

    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = zone;
    _id_7E2C53B0BCF117D9.eventname = "hill_uncontested";
    _id_7E2C53B0BCF117D9.position = zone.trigger.origin;
  }

  contestedtime = (gettime() - zone.contestedtime) * 0.001;
  scripts\mp\utility\game::logannouncement(undefined, undefined, "Zone Contested", zone.trigger.origin, contestedtime + " seconds");
  zone.contestedtime = undefined;
  _id_520EAD5ACD9E02E9 = scripts\engine\utility::ter_op(ownerteam == "neutral", "idle", ownerteam);
  zone thread updatechevrons(_id_520EAD5ACD9E02E9);
  level _id_734EA6311B19A424::updateservericons(ownerteam, 0);
  zone.didstatusnotify = 0;
  zone scripts\mp\objidpoolmanager::_id_9B1A086F348520B0(zone.objidnum, "neutral");
}

zone_stompeenemyprogressupdate(team) {
  adjustmatchtimerpausedstatefromscore(team);
}

zone_stompprogressreward(player) {
  zone = self;
  player thread scripts\mp\rank::scoreeventpopup("stat_6FF0E80C570DACA1");
  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2D96CED878338CD2");
  zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

zone_onpinnedstate(player) {
  zone = self;

  if(zone.ownerteam != "neutral" && zone.numtouching[zone.ownerteam] && !zone.stalemate)
    zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

zone_onunpinnedstate(player) {
  zone = self;

  if(!zone.stalemate) {
    if(zone.ownerteam != "neutral" && !zone.numtouching[zone.ownerteam] || isDefined(player.team) && !zone.numtouching[player.team])
      zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }
}

adjustmatchtimerpausedstatefromscore(team, _id_AC8CFC833C6F6E23) {
  if(!level.pausemodetimer) {
    return;
  }
  _id_E3F1A73A39054069 = scripts\mp\gamescore::_getteamscore(team);
  _id_AC865A705B3E1162 = scripts\mp\gamescore::_getteamscore(scripts\mp\utility\game::getotherteam(team)[0]);

  if(istrue(_id_AC8CFC833C6F6E23)) {
    if(_id_AC865A705B3E1162 > _id_E3F1A73A39054069)
      level scripts\mp\gamelogic::resumetimer();
    else
      level scripts\mp\gamelogic::pausetimer();
  } else if(_id_E3F1A73A39054069 > _id_AC865A705B3E1162)
    level scripts\mp\gamelogic::resumetimer();
  else
    level scripts\mp\gamelogic::pausetimer();
}

setcrankedtimerzonecap(player) {
  if((scripts\mp\utility\game::_id_F698BFD3EFA33302() || scripts\mp\utility\game::_id_E9F3A160BBEFE208(player)) && isDefined(player.cranked) && player.cranked)
    player scripts\mp\cranked::setcrankedplayerbombtimer("assist");
}

playhardpointneutralfx() {
  if(istrue(level.usehpzonebrushes)) {
    foreach(player in level.players)
    showzoneneutralbrush(player);
  }
}

showcapturedhardpointeffecttoplayer(_id_8C4EC3E8ADAFD3FF, player) {
  zone = self;
  _id_8E879FAF3052E0D2 = player.team;
  _id_8420670EAFC8D391 = player _meth_8420670EAFC8D391();

  if(_id_8420670EAFC8D391) {
    if(player ismlgfreecamenabled() || player ismlgaerialcamenabled())
      _id_8E879FAF3052E0D2 = "allies";
    else
      _id_8E879FAF3052E0D2 = player _meth_638EEBEFF841E16A();
  }

  if(istrue(level.usehpzonebrushes)) {
    if(zone.stalemate)
      showzonecontestedbrush(player);
    else if(_id_8E879FAF3052E0D2 == _id_8C4EC3E8ADAFD3FF)
      showzonefriendlybrush(player);
    else
      showzoneenemybrush(player);
  }
}

showzoneneutralbrush(player) {
  zone = self;
  zone.friendlybrush hidefromplayer(player);
  zone.enemybrush hidefromplayer(player);
  zone.contestedbrush hidefromplayer(player);
  zone.neutralbrush showtoplayer(player);
}

showzonefriendlybrush(player) {
  zone = self;
  zone.friendlybrush showtoplayer(player);
  zone.enemybrush hidefromplayer(player);
  zone.contestedbrush hidefromplayer(player);
  zone.neutralbrush hidefromplayer(player);
}

showzoneenemybrush(player) {
  zone = self;
  zone.friendlybrush hidefromplayer(player);
  zone.enemybrush showtoplayer(player);
  zone.contestedbrush hidefromplayer(player);
  zone.neutralbrush hidefromplayer(player);
}

showzonecontestedbrush(player) {
  zone = self;
  zone.friendlybrush hidefromplayer(player);
  zone.enemybrush hidefromplayer(player);
  zone.contestedbrush showtoplayer(player);
  zone.neutralbrush hidefromplayer(player);
}

hideplayerspecificbrushes(player) {
  zone = self;
  zone.friendlybrush hidefromplayer(player);
  zone.enemybrush hidefromplayer(player);
  zone.neutralbrush hidefromplayer(player);
  zone.contestedbrush hidefromplayer(player);
}

onplayerjoinedteam(player) {
  zone = self;

  if(player.team != "spectator" && zone.ownerteam != "neutral")
    zone showcapturedhardpointeffecttoplayer(zone.ownerteam, player);
}

removechevronsfromarray(_id_C236336A4B27E7DA, label) {
  _id_C081A38873B1D5E3 = [];
  _id_D23F6234846F86A6 = [];

  switch (level.mapname) {
    case "mp_m_speed":
      _id_D23F6234846F86A6["1"] = [(-564, 1848, 24)];
      _id_D23F6234846F86A6["2"] = [(-1314, 440, 24), (-1362, 816, 24)];
      break;
    case "mp_cave":
    case "mp_cave_am":
      _id_D23F6234846F86A6["3"] = [(-692, 1828, 42), (-300, 1548, 76)];
      break;
    case "mp_raid":
      _id_D23F6234846F86A6["8"] = [(688, 256, 280)];
      _id_D23F6234846F86A6["20"] = [(212, 1436, 338)];
      break;
    case "mp_farm_18":
      _id_D23F6234846F86A6["5"] = [(778, -1458, 136), (860, -1226, 158)];
      break;
    case "mp_wartorn":
      _id_D23F6234846F86A6["5"] = [(-6792, 42420, 221), (-6680, 42778, 213)];
      break;
    default:
      break;
  }

  if(isDefined(_id_D23F6234846F86A6[label])) {
    foreach(visual in _id_C236336A4B27E7DA) {
      foreach(_id_F90358454413407F in _id_D23F6234846F86A6[label]) {
        if(distance(visual.origin, _id_F90358454413407F) < 10) {
          _id_C081A38873B1D5E3[_id_C081A38873B1D5E3.size] = visual;
          break;
        }
      }
    }
  }

  _id_C236336A4B27E7DA = scripts\engine\utility::array_remove_array(_id_C236336A4B27E7DA, _id_C081A38873B1D5E3);
  return _id_C236336A4B27E7DA;
}

postshipmodifychevrons(_id_C236336A4B27E7DA, label) {
  _id_34DCE00DF63CFF91 = [];
  _id_C081A38873B1D5E3 = [];

  switch (level.mapname) {
    case "mp_m_speed":
      _id_34DCE00DF63CFF91["1"] = [];
      _id_34DCE00DF63CFF91["1"][0] = [(-564, 1880, 24), (0, 180, 0)];
      _id_34DCE00DF63CFF91["1"][1] = [(-564, 1976, 24), (0, 180, 0)];
      _id_34DCE00DF63CFF91["1"][2] = [(-564, 2072, 24), (0, 180, 0)];
      _id_34DCE00DF63CFF91["2"] = [];
      _id_34DCE00DF63CFF91["2"][0] = [(-1314, 472, 24), (0, 180, 0)];
      _id_34DCE00DF63CFF91["2"][1] = [(-1314, 568, 24), (0, 180, 0)];
      _id_34DCE00DF63CFF91["2"][2] = [(-1474, 816, 24), (0, 270, 0)];
      _id_34DCE00DF63CFF91["2"][3] = [(-1378, 816, 24), (0, 270, 0)];
      _id_34DCE00DF63CFF91["4"] = [];
      _id_34DCE00DF63CFF91["4"][0] = [(-1298, 1992, 24), (0, 180, 0)];
      _id_34DCE00DF63CFF91["4"][1] = [(-1400, 2262, 24), (0, 270, 0)];
      _id_34DCE00DF63CFF91["4"][2] = [(-1690, 2264, 24), (0, 270, 0)];
      break;
    case "mp_deadzone":
      _id_34DCE00DF63CFF91["2"] = [];
      _id_34DCE00DF63CFF91["2"][0] = [(436, 3435, 207.694), (0, 360, 0)];
      _id_34DCE00DF63CFF91["2"][1] = [(436, 3188, 247.694), (0, 360, 0)];
      _id_34DCE00DF63CFF91["2"][2] = [(436, 3098, 258.694), (0, 360, 0)];
      _id_34DCE00DF63CFF91["2"][3] = [(1051, 2796, 304), (0, 117.509, 0)];
      _id_34DCE00DF63CFF91["2"][4] = [(931, 2680, 304), (0, 147.509, 0)];
      _id_34DCE00DF63CFF91["2"][5] = [(515, 3522, 215), (0, 276, 0)];
      _id_34DCE00DF63CFF91["12"] = [];
      _id_34DCE00DF63CFF91["12"][0] = [(-400, 651, 436), (0, 180, 0)];
      _id_34DCE00DF63CFF91["12"][1] = [(-400, 557, 439), (0, 180, 0)];
      _id_34DCE00DF63CFF91["12"][2] = [(-400, 461, 446), (0, 180, 0)];
      _id_34DCE00DF63CFF91["12"][3] = [(-410, -65, 446), (0, 180, 0)];
      _id_34DCE00DF63CFF91["12"][4] = [(-408, 31, 448), (0, 180, 0)];
      break;
    case "mp_raid":
      _id_34DCE00DF63CFF91["5"] = [];
      _id_34DCE00DF63CFF91["5"][0] = [(-3118.59, 230.46, 292), (0, 0, 0)];
      _id_34DCE00DF63CFF91["8"] = [];
      _id_34DCE00DF63CFF91["8"][0] = [(688, 256, 295), (0, 270, 0)];
      _id_34DCE00DF63CFF91["8"][1] = [(749, 248, 295), (0, 270, 0)];
      _id_34DCE00DF63CFF91["12"] = [];
      _id_34DCE00DF63CFF91["12"][0] = [(-1490.62, -972.979, 422), (0, 90, 0)];
      _id_34DCE00DF63CFF91["13"] = [];
      _id_34DCE00DF63CFF91["13"][0] = [(-1695.67, 3211.7, 310), (0, 270, 0)];
      _id_34DCE00DF63CFF91["13"][1] = [(-1804.59, 3219.27, 284), (0, 270, 0)];
      _id_34DCE00DF63CFF91["20"] = [];
      _id_34DCE00DF63CFF91["20"][0] = [(260, 1416, 338), (0, 90, 0)];
      break;
    case "mp_cave":
    case "mp_cave_am":
      _id_34DCE00DF63CFF91["3"] = [];
      _id_34DCE00DF63CFF91["3"][0] = [(-514, 1328, 32), (0, 100, 0)];
      _id_34DCE00DF63CFF91["3"][1] = [(-692, 1828, 42), (0, 260, 0)];
      _id_34DCE00DF63CFF91["3"][2] = [(-564, 1804, 44), (0, 260, 0)];
      _id_34DCE00DF63CFF91["3"][3] = [(-500, 1788, 54), (0, 260, 0)];
      _id_34DCE00DF63CFF91["3"][4] = [(-312, 1528, 78), (0, 145, 0)];
      break;
    case "mp_hackney_yard":
    case "mp_hackney_am":
      _id_34DCE00DF63CFF91["8"] = [];
      _id_34DCE00DF63CFF91["8"][0] = [(994.552, 1760.12, 44), (0, 270, 0)];
      _id_34DCE00DF63CFF91["9"] = [];
      _id_34DCE00DF63CFF91["9"][0] = [(1322, -407.18, 29.184), (0, 90, 0)];
      break;
    case "mp_aniyah":
      _id_34DCE00DF63CFF91["13"] = [];
      _id_34DCE00DF63CFF91["13"][0] = [(1995.79, 394.828, 424), (0, 270, 0)];
      break;
    case "mp_luxury":
      _id_34DCE00DF63CFF91["1"] = [];
      _id_34DCE00DF63CFF91["1"][0] = [(848, 955, 0), (270, 0, 0)];
      _id_34DCE00DF63CFF91["1"][1] = [(400, 1120, 0), (0, 0, 0)];
      break;
    case "mp_farm_18":
      _id_34DCE00DF63CFF91["5"] = [];
      _id_34DCE00DF63CFF91["5"][0] = [(778, -1454, 136), (0, 0, 0)];
      _id_34DCE00DF63CFF91["5"][1] = [(778, -1383, 136), (0, 0, 0)];
      _id_34DCE00DF63CFF91["5"][2] = [(860, -1672, 158), (0, 90, 0)];
      _id_34DCE00DF63CFF91["5"][3] = [(1045, -1226, 158), (0, 270, 0)];
      _id_34DCE00DF63CFF91["5"][4] = [(1106, -1226, 158), (0, 270, 0)];
      break;
    default:
      break;
  }

  if(isDefined(_id_34DCE00DF63CFF91[label])) {
    foreach(_id_F90358454413407F in _id_34DCE00DF63CFF91[label]) {
      origin = _id_F90358454413407F[0];
      angles = _id_F90358454413407F[1];
      scriptable = spawnscriptable("hardpoint_chevron", origin, angles);
      _id_C081A38873B1D5E3[_id_C081A38873B1D5E3.size] = scriptable;
    }
  }

  _id_C236336A4B27E7DA = scripts\engine\utility::array_combine(_id_C236336A4B27E7DA, _id_C081A38873B1D5E3);
  return _id_C236336A4B27E7DA;
}

createvisualsinfo(scriptable, origin, angles) {
  scriptable.origin = origin;
  scriptable.angles = angles;
  return scriptable;
}