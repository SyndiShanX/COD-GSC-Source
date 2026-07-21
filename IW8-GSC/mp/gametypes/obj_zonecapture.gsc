/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\obj_zonecapture.gsc
***********************************************/

setupobjective(var_0, var_1, var_2, var_3) {
  var_4 = var_0;

  if(!isDefined(var_1)) {
    var_1 = [];
    var_1[0] = var_4;
  }

  var_4 = postshipmodifiedkothzones(var_4);

  if(istrue(var_2))
    var_5 = 0;
  else
    var_5 = undefined;

  var_4 = scripts\mp\gameobjects::createuseobject("_encstr_A7A408B9CA5D1D4E2C63", var_4, var_1, (0, 0, 0), var_5, var_3);
  var_4 scripts\mp\gameobjects::disableobject();

  if(scripts\mp\utility\game::getgametype() == "_encstr_BDD705AD7BD143") {
    for(var_6 = 0; var_6 < var_4.visuals.size; var_6++)
      var_4.visuals[var_6] hide();
  } else
    var_4.visuals[0] scriptmodelplayanim("_encstr_A90A1F71F7DAC9971FC6E2AAC8FB8B3EE073CFC853390E234F9B7AB131412F72E0");

  var_4 scripts\mp\gameobjects::cancontestclaim(1);
  var_4.claimgracetime = level.zonecapturetime * 1000;
  var_4 scripts\mp\gameobjects::pinobjiconontriggertouch();

  if(isDefined(var_0.objectivekey))
    var_4.objectivekey = var_0.objectivekey;
  else
    var_4.objectivekey = var_4 scripts\mp\gameobjects::getlabel();

  if(level.usehqrules && !level.usehprules)
    var_4 scripts\mp\gameobjects::mustmaintainclaim(0);
  else
    var_4 scripts\mp\gameobjects::mustmaintainclaim(1);

  var_4.id = "_encstr_B67B0A1A2C279107DBB49BA3";

  if(isDefined(var_4.trigger.target) && scripts\mp\utility\game::getgametype() == "_encstr_BDD705AD7BD143")
    var_4 thread assignchevrons(var_4.trigger.target, var_4.trigger.script_label);

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349")
      var_4 thread _id_14396(var_4);
    else if(scripts\mp\utility\game::getgametype() == "_encstr_9A7205B39CB919")
      var_4 thread _id_14395(var_4);
  }

  return var_4;
}

_id_14396(var_0) {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_1 = anglesToForward(var_0.visuals[0].angles);
  var_2 = var_1 * 5;
  var_3 = var_0.visuals[0] gettagorigin("_encstr_86870EA9FA1BB0838EBD0EFA3A9CB097");
  playFX(level.spawnoffsettacinsertmax["_encstr_A6CB0CD90DBDE6D1B185D1AF43EE"], var_3 + var_2);
}

_id_14395(var_0) {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  playFX(level.spawnoffsettacinsertmax["_encstr_B8A50F48057D083AF8E073F74820B7A3D0"], getgroundposition(var_0.trigger.origin, 4) + (0, 0, 2));
}

postshipmodifiedkothzones(var_0) {
  if(level.mapname == "_encstr_82740C4F78166D12D1B3CA0495DD") {
    if(var_0.script_label == "_encstr_A34C02BB")
      var_0.origin = var_0.origin - (0, 0, 5);
  } else if(level.mapname == "_encstr_8B1D09FFC8A63802BDEF7B") {
    if(var_0.script_label == "_encstr_A34C02BB")
      var_0.origin = var_0.origin + (0, 3, 0);
  }

  return var_0;
}

assignchevrons(var_0, var_1) {
  wait 1.0;
  var_2 = getentitylessscriptablearrayinradius(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = _id_12BFF(var_2, var_1);
  var_2 = _id_12806(var_2, var_1);
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = var_3.size;
    var_3[var_6] = var_5;
    var_3[var_6].numchevrons = 1;

    if(isDefined(var_5.script_noteworthy)) {
      if(var_5.script_noteworthy == "_encstr_A74C0222") {
        var_3[var_6].numchevrons = 2;
        continue;
      }

      if(var_5.script_noteworthy == "_encstr_A14C023B") {
        var_3[var_6].numchevrons = 3;
        continue;
      }

      if(var_5.script_noteworthy == "_encstr_AC4C024A")
        var_3[var_6].numchevrons = 4;
    }
  }

  self.chevrons = var_3;
}

updatechevrons(var_0) {
  if(scripts\mp\utility\game::getgametype() != "_encstr_BDD705AD7BD143") {
    return;
  }
  self notify("_encstr_8BBA0F9540A319D1677008783BFAAFB047");
  self endon("_encstr_8BBA0F9540A319D1677008783BFAAFB047");

  while(!isDefined(self.chevrons))
    waitframe();

  foreach(var_2 in self.chevrons) {
    for(var_3 = 0; var_3 < var_2.numchevrons; var_3++)
      var_2 setscriptablepartstate("_encstr_917509E648C510D3A7781F" + var_3, var_0);
  }
}

activatezone() {
  self.onuse = ::zone_onuse;
  self.onbeginuse = ::zone_onusebegin;
  self.onuseupdate = ::zone_onuseupdate;
  self.onenduse = ::zone_onuseend;
  self.onunoccupied = ::zone_onunoccupied;
  self.oncontested = ::zone_oncontested;
  self.onuncontested = ::zone_onuncontested;
  self.stompprogressreward = ::zone_stompprogressreward;
  self.onpinnedstate = ::zone_onpinnedstate;
  self.onunpinnedstate = ::zone_onunpinnedstate;
  self.didstatusnotify = 0;
  scripts\mp\gameobjects::requestid(1, 1, 0, 1, 0);
  var_0 = self.curorigin;

  if(isDefined(level.remove_last_used_node))
    var_0 = [[level.remove_last_used_node]]();

  var_1 = 1024;

  if(isDefined(level.remove_launcher_xmags))
    var_1 = [[level.remove_launcher_xmags]]();

  var_2 = [];
  var_2[var_2.size] = scripts\mp\spawnlogic::addspawndangerzone(var_0 - (0, 0, 2048), var_1, 4096, "_encstr_9A8507BA4040188D08", undefined, undefined, undefined, undefined, undefined, 1);
  var_2[var_2.size] = scripts\mp\spawnlogic::addspawndangerzone(var_0 - (0, 0, 2048), var_1, 4096, "_encstr_8E8405EA382B2A", undefined, undefined, undefined, undefined, undefined, 1);
  self.isburstweapon = var_2;

  if(scripts\mp\utility\game::getgametype() == "_encstr_BDD705AD7BD143" || scripts\mp\utility\game::getgametype() == "_encstr_9A7205B39CB919") {
    self.ignorestomp = 1;
    self.alwaysstalemate = 1;
    level thread _encstr_AF471E7B265A8F1B8B620F63E2500A8BBBDF4CB0E15DBF881C1F03FB7D1287E8::awardcapturepoints();
  } else {
    self._id_138B2 = ::_id_1471E;
    scripts\mp\objidpoolmanager::update_objective_position(self.objidnum, self.visuals[0].origin + (0, 0, 70));
  }
}

deactivatezone() {
  self.onuse = undefined;
  self.onbeginuse = undefined;
  self.onuseupdate = undefined;
  self.onunoccupied = undefined;
  self.oncontested = undefined;
  self.onuncontested = undefined;
  self.stalemate = 0;
  self.wasstalemate = 0;
  self.didstatusnotify = 0;
  thread updatechevrons("_encstr_BA19049F4B2D");

  foreach(var_1 in self.isburstweapon)
  scripts\mp\spawnlogic::removespawndangerzone(var_1);

  self.isburstweapon = undefined;

  foreach(var_4 in level.players)
  scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, var_4);

  self.trigger scripts\engine\utility::trigger_off();
  thread _id_1439D();
  scripts\mp\gameobjects::releaseid(1, 0);

  if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349") {
    self.visuals[0] playSound("_encstr_A1451509A249699BEF3B88901FFC509D724BF598FA72F1");
    thread scripts\mp\music_and_dialog::headquarters_deactivate_music(self.lastclaimteam);
    self.visuals[0] scriptmodelplayanim("_encstr_A90A1F71F7DAC9971FC6E2AAC8FB8B3EE073CFC853390E234F9B7AB131412F72E0");
    level.zone.visuals[0] stoploopsound();
  }

  level._id_12F0E = 0;
}

zonetimerwait() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A6940FED853B0E2535D3E028F988FFE0AF");
  var_0 = int(level.zonemovetime * 1000 + gettime());

  if(!isDefined(level.zoneselectiondelay) || level.zoneselectiondelay < 10)
    thread hp_move_soon(level.zonemovetime);

  level thread handlehostmigration(var_0);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.zonemovetime);
}

hp_move_soon(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349")
    level endon("_encstr_A29C0FA77BE659D74656B9479CDBE52B91");

  if(int(var_0) > 12) {
    var_1 = var_0 - 12;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1);

    foreach(var_3 in level.teamnamelist)
    level scripts\mp\utility\dialog::statusdialog("_encstr_A2D90D0DE07DB6BDD956D7DCB7EDB9", var_3);
  }
}

handlehostmigration(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_ACA10DAE80E31A1FC960CB8FF8C11C");
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_86C30E225D088A98370A61DBF31607CC");
  level waittill("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", 1);
  var_1 = scripts\mp\hostmigration::waittillhostmigrationdone();
  setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", 0);

  if(var_1 > 0)
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.zoneendtime + var_1);
  else
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.zoneendtime);
}

_id_1199E(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = level.framedurationseconds;
  var_3 = var_2 * 1000;
  var_4 = var_0 * 1000;
  var_5 = var_4 - var_3;
  self.radialtimeobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(self.radialtimeobjid != -1) {
    var_6 = "_encstr_A2BE0AB4DC3BB46E5A981BAC";
    scripts\mp\objidpoolmanager::objective_add_objective(self.radialtimeobjid, var_6, var_1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.radialtimeobjid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(self.radialtimeobjid, 0);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.radialtimeobjid);
    self.showworldicon = 1;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget, level.icontarget, self.radialtimeobjid);
  var_7 = gettime() + var_4;

  while(gettime() < var_7) {
    var_8 = var_5 / var_4;
    scripts\mp\objidpoolmanager::objective_show_progress(self.radialtimeobjid, 1);
    scripts\mp\objidpoolmanager::objective_set_progress(self.radialtimeobjid, var_8);
    var_5 = max(var_5 - var_3, 1);
    waitframe();
  }

  scripts\mp\objidpoolmanager::returnobjectiveid(self.radialtimeobjid);
  self.radialtimeobjid = -1;
}

hardpoint_setneutral() {
  self notify("_encstr_BA4A0DE659885FF7B839CBE3E30773");
  scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
  playhardpointneutralfx();
  thread updatechevrons("_encstr_A7C5056BD931D1");
}

trackgametypevips() {
  thread cleanupgametypevips();
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_87BD0BFA5FF0DFF73978FBF221");

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 istouching(level.zone.trigger)) {
        var_1 setgametypevip(1);
        continue;
      }

      var_1 setgametypevip(0);
    }

    wait 0.5;
  }
}

cleanupgametypevips() {
  level scripts\engine\utility::_id_143A5("_encstr_9B1D0BC7932875276230426AA1", "_encstr_87BD0BFA5FF0DFF73978FBF221");

  foreach(var_1 in level.players)
  var_1 setgametypevip(0);
}

zone_onuse(var_0) {
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  var_1 = var_0.team;
  var_2 = gettime();
  var_3 = [];
  var_4 = getarraykeys(self.touchlist[var_1]);

  for(var_5 = 0; var_5 < var_4.size; var_5++)
    var_3[var_4[var_5]] = self.touchlist[var_1][var_4[var_5]];

  if(level.usehqrules && !level.usehprules && self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63") {
    setomnvar("_encstr_86491063E151C0C7078283A80A9B7D10764D", 0);
    level notify("_encstr_A29C0FA77BE659D74656B9479CDBE52B91");

    foreach(var_7 in level.players)
    scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, var_7);

    level.zone thread _id_1439D();
    level _encstr_AF471E7B265A8F1B8B620F63E2500A8BBBDF4CB0E15DBF881C1F03FB7D1287E8::updateservericons("_encstr_83270B204F9E4157D3C463FCDB", 0);

    if(isDefined(var_3)) {
      var_9 = getarraykeys(var_3);

      foreach(var_11 in var_9) {
        var_7 = self.assisttouchlist[var_1][var_11].player;

        if(isDefined(var_7.owner))
          var_7 = var_7.owner;

        if(!isPlayer(var_7)) {
          continue;
        }
        var_7 scripts\cp\vehicles\vehicle_compass_cp::_id_12003();
      }
    }

    level thread _encstr_A2931C378DE4D2381DDC79AD07CB9D16AD95E89783959B791A5C17769B6C::give_capture_credit(var_3, var_2, var_1, undefined, var_0, self);

    if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349") {
      level scripts\mp\utility\dialog::statusdialog("_encstr_86CF15588B077A4350BBADB2A2F1D7952A64D2BAFD3992", var_0.team);
      level scripts\mp\utility\dialog::statusdialog("_encstr_95010ED0E0F5DEBBCD2B327D63DEB9E8", self.ownerteam);
    } else {
      level scripts\mp\utility\dialog::statusdialog("_encstr_86CF15588B077A4350BBADB2A2F1D7952A64D2BAFD3992", var_0.team);
      level scripts\mp\utility\dialog::statusdialog("_encstr_B1341202FF59E78993406BB05124317D280B40A2", self.ownerteam);
    }
  } else {
    if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349") {
      var_13 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B");

      foreach(var_7 in var_13) {
        var_7 scripts\cp\vehicles\vehicle_compass_cp::_id_12003();
        var_7.skipspawncamera = 1;
      }
    }

    var_16 = scripts\mp\gameobjects::getownerteam();
    var_17 = scripts\mp\utility\game::getotherteam(var_1)[0];
    scripts\mp\gameobjects::setownerteam(var_1);

    if(level.usehqrules && !level.usehprules) {
      setomnvar("_encstr_86491063E151C0C7078283A80A9B7D10764D", _encstr_A2931C378DE4D2381DDC79AD07CB9D16AD95E89783959B791A5C17769B6C::gethqownerteamvalue(self.ownerteam));
      setomnvar("_encstr_AD5F10BA5AFA1AE2EB73AE5BBE581B5AB359", scripts\mp\utility\teams::getteamdata(self.ownerteam, "_encstr_8A2A0B936CCCC3078547970A8B"));
    }

    if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349" && !level.usehprules) {
      level thread _encstr_A2931C378DE4D2381DDC79AD07CB9D16AD95E89783959B791A5C17769B6C::awardcapturepoints();
      var_18 = scripts\mp\gamescore::_getteamscore(var_1);
      var_19 = scripts\mp\gamescore::_getteamscore(var_17);

      if(var_18 > var_19)
        level._id_12F0E = 1;

      binoculars_clearexpirationtimer(var_1);
    } else if(level._id_1221A)
      level scripts\mp\gamelogic::pausetimer();

    level.usestartspawns = 0;
    var_20 = 0;
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    level _encstr_AF471E7B265A8F1B8B620F63E2500A8BBBDF4CB0E15DBF881C1F03FB7D1287E8::updateservericons(var_1, 0);

    if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349" && !level.usehprules) {
      thread scripts\mp\utility\print::printandsoundoneveryone(var_1, var_17, undefined, undefined, "_encstr_AF841588B30FD127CB0E030550B7FEB7F82ACBD80E0DC1", undefined, var_0);
      thread scripts\mp\music_and_dialog::headquarters_captured_music();
    }

    if(!isDefined(level.lastcaptureteam) || level.lastcaptureteam != var_1) {
      if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349" && !level.usehprules) {
        if(isDefined(level.kothhillrotation && level.kothhillrotation == 0))
          level.delayleadtakendialog = 4;
        else
          level.delayleadtakendialog = undefined;

        level thread delaydialogstatustoavoidcaptureoverlap(var_1, var_17);
      } else {
        level scripts\mp\utility\dialog::statusdialog("_encstr_86CF15588B077A4350BBADB2A2F1D7952A64D2BAFD3992", var_1);
        level scripts\mp\utility\dialog::statusdialog("_encstr_B1341202FF59E78993406BB05124317D280B40A2", var_17);
      }

      if(scripts\mp\utility\game::getgametype() == "_encstr_BDD705AD7BD143")
        level thread _encstr_AF471E7B265A8F1B8B620F63E2500A8BBBDF4CB0E15DBF881C1F03FB7D1287E8::give_capture_credit(var_3, var_2, var_1, level.lastcaptureteam, var_0, self);
      else if(scripts\mp\utility\game::getgametype() == "_encstr_9A7205B39CB919")
        level thread _encstr_A9631EE6B1939638D1B9F2B6C1973B85B6AC3AF283ACE65EEC4EDC2371CEDCD8::give_capture_credit(var_3, var_2, var_1, level.lastcaptureteam, var_0, self);
      else
        level thread _encstr_A2931C378DE4D2381DDC79AD07CB9D16AD95E89783959B791A5C17769B6C::give_capture_credit(var_3, var_2, var_1, level.lastcaptureteam, var_0, self);
    }

    foreach(var_22 in level.players)
    showcapturedhardpointeffecttoplayer(var_1, var_22);

    level.zone thread updatechevrons(var_1);

    if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349") {
      level.zone.visuals[0] stoploopsound();
      level.zone.visuals[0] scriptmodelplayanim("_encstr_9555233BE7727E438251C0F87A9C39F12381A823594721852ECB884122F2C3E83F094DA9A5");

      if(!level.usehprules) {
        var_24 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B");

        foreach(var_7 in var_24)
        var_7 thread _encstr_A2931C378DE4D2381DDC79AD07CB9D16AD95E89783959B791A5C17769B6C::showrespawnwarningmessage();
      }
    }

    level.hpcapteam = var_1;
    self.capturecount++;
    level.lastcaptureteam = var_1;
    level notify("_encstr_86C30E225D088A98370A61DBF31607CC");
    level notify("_encstr_86C30E225D088A98370A61DBF31607CC" + var_1);
  }

  if(istrue(level.setplayerselfrevivingextrainfo))
    playFX(level.spawnoffsettacinsertmax["_encstr_8C930DA4C67A4BFBF8F7C0C00F0E13"], level.zone.trigger.origin + (0, 0, 40));
}

_id_1439D() {
  waitframe();
  scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
}

zone_onusebegin(var_0) {
  if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349" && !level.usehprules) {
    var_1 = scripts\mp\gameobjects::getownerteam();

    if(var_1 != "_encstr_A7A408B9CA5D1D4E2C63" && self.claimteam != var_1)
      binoculars_clearexpirationtimer(var_1, 1);

    if(!istrue(var_0.ui_dom_securing) || !istrue(self.stalemate)) {
      if(var_1 == "_encstr_A7A408B9CA5D1D4E2C63")
        var_0 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 1);
      else
        var_0 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 2);

      var_0.ui_dom_securing = 1;
    }
  }

  if(!isDefined(self.statusnotifytime))
    self.statusnotifytime = gettime();

  if(self.statusnotifytime > self.statusnotifytime + 10000) {
    self.didstatusnotify = 0;
    self.statusnotifytime = gettime();
  }

  scripts\mp\gameobjects::setusetime(level.zonecapturetime);

  if(level.zonecapturetime > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(var_0.team)[0];
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosing, level.icontaking);
  }
}

zone_onuseupdate(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gameobjects::getownerteam();

  if(var_4 == "_encstr_A7A408B9CA5D1D4E2C63" && self.claimteam != var_4)
    binoculars_clearexpirationtimer(self.claimteam);
  else if(var_4 != "_encstr_A7A408B9CA5D1D4E2C63" && self.claimteam != var_4)
    binoculars_clearexpirationtimer(var_4, 1);
  else if(level._id_1221A)
    level scripts\mp\gamelogic::pausetimer();

  if((scripts\mp\utility\game::getgametype() == "_encstr_8E07030349" || scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B") && var_1 < 1.0 && !level.usehprules && !level.gameended)
    playcapturesound(var_1, var_0);

  var_4 = scripts\mp\gameobjects::getownerteam();
  var_5 = scripts\mp\utility\game::getotherteam(var_0)[0];

  if(var_1 > 0.05 && var_2 && !self.didstatusnotify) {
    if(var_4 == "_encstr_A7A408B9CA5D1D4E2C63") {
      scripts\mp\utility\dialog::statusdialog("_encstr_8FAD16C8485FB69008A3CB7B2F38CFF06F434BED08E06968", var_0);
      scripts\mp\utility\dialog::statusdialog("_encstr_8DF313F87BE7D973ABBB25AED462B78605EB6858C7", var_5);
    } else if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349") {
      scripts\mp\utility\dialog::statusdialog("_encstr_AC1516D05941A7677EE1F21AC8D867D120C559258D406D6F", var_4);
      scripts\mp\utility\dialog::statusdialog("_encstr_AC9B13200B91103B23F1D051328E5C914138BFC247", var_0);
    } else {
      scripts\mp\utility\dialog::statusdialog("_encstr_8DF313F87BE7D973ABBB25AED462B78605EB6858C7", var_4);
      scripts\mp\utility\dialog::statusdialog("_encstr_8FAD16C8485FB69008A3CB7B2F38CFF06F434BED08E06968", var_0);
    }

    self.didstatusnotify = 1;
  }
}

delaydialogstatustoavoidcaptureoverlap(var_0, var_1) {
  wait 0.5;
  level scripts\mp\utility\dialog::statusdialog("_encstr_B1C0144383BECD56B1AB9CAC32EB66E4A5B27319D8CB", var_0);
  level scripts\mp\utility\dialog::statusdialog("_encstr_B1341202FF59E78993406BB05124317D280B40A2", var_1);
}

playcapturesound(var_0, var_1) {
  if(!isDefined(self.lastsfxplayedtime))
    self.lastsfxplayedtime = gettime();

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_2 = "_encstr_B40101";
    var_0 = int(floor(var_0 * 10));
    var_2 = "_encstr_856B180A5867CF6F6068A3D9972B4F12537312A1E0E3C6A71EC7" + var_0;
    self.visuals[0] playsoundtoteam(var_2, var_1);
  }
}

zone_onuseend(var_0, var_1, var_2) {
  var_3 = level.zone scripts\mp\gameobjects::getownerteam();

  if(!var_2) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349") {
      if(level.usehprules) {
        if(level._id_1221A)
          level scripts\mp\gamelogic::resumetimer();
      } else if(var_3 != "_encstr_A7A408B9CA5D1D4E2C63")
        binoculars_clearexpirationtimer(var_3);
    } else if(level._id_1221A)
      level scripts\mp\gamelogic::resumetimer();
  }

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
    var_1.ui_dom_securing = undefined;
  }

  if(var_3 == "_encstr_A7A408B9CA5D1D4E2C63") {
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);

    if(istrue(level.usehpzonebrushes)) {
      foreach(var_1 in level.players)
      level.zone showzoneneutralbrush(var_1);
    }
  } else {
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

    foreach(var_1 in level.players)
    level.zone showcapturedhardpointeffecttoplayer(var_3, var_1);
  }
}

zone_onunoccupied() {
  if(level.usehqrules && !level.usehprules && self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63") {
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    binoculars_clearexpirationtimer(self.ownerteam);
  } else {
    level notify("_encstr_A29C0FA77BE659D74656B9479CDBE52B91");
    level.hpcapteam = "_encstr_A7A408B9CA5D1D4E2C63";

    if(level._id_1221A)
      level scripts\mp\gamelogic::resumetimer();

    var_0 = 1;

    foreach(var_2 in level.teamnamelist) {
      if(self.numtouching[var_2] > 0) {
        var_0 = 0;
        break;
      }
    }

    if(var_0) {
      level.zone.wasleftunoccupied = 1;
      level _encstr_AF471E7B265A8F1B8B620F63E2500A8BBBDF4CB0E15DBF881C1F03FB7D1287E8::updateservericons("_encstr_A7A408B9CA5D1D4E2C63", 0);
      level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
      level.zone playhardpointneutralfx();
      level.zone thread updatechevrons("_encstr_A7C5056BD931D1");
    }
  }
}

zone_oncontested() {
  if(level._id_1221A)
    level scripts\mp\gamelogic::resumetimer();

  self.hostvictimoverride = gettime();
  var_0 = level.zone scripts\mp\gameobjects::getownerteam();
  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  level _encstr_AF471E7B265A8F1B8B620F63E2500A8BBBDF4CB0E15DBF881C1F03FB7D1287E8::updateservericons(var_0, 1);
  level.zone thread updatechevrons("_encstr_B85C0AD87B9B8E95CD8E2B46");

  foreach(var_2 in level.teamnamelist) {
    if(self.touchlist[var_2].size) {
      var_3 = self.touchlist[var_2];
      var_4 = getarraykeys(var_3);

      for(var_5 = 0; var_5 < var_4.size; var_5++) {
        var_6 = var_3[var_4[var_5]].player;
        var_6 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 3);
      }
    }
  }

  foreach(var_6 in level.players)
  level.zone showcapturedhardpointeffecttoplayer(var_0, var_6);

  if(var_0 == "_encstr_A7A408B9CA5D1D4E2C63")
    var_10 = self.claimteam;
  else
    var_10 = var_0;

  foreach(var_12 in level.teamnamelist)
  scripts\mp\utility\dialog::statusdialog("_encstr_8C5E0D34E0BEB1DBCD1D59373A2B23", var_12);

  level.zone thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_BAD40FD04A6BE12916A71D51D57A383D13", level.zone.trigger.origin);
  self.didstatusnotify = 1;
}

zone_onuncontested(var_0) {
  if(level._id_1221A)
    level scripts\mp\gamelogic::pausetimer();

  var_1 = level.zone scripts\mp\gameobjects::getownerteam();

  if(var_0 == "_encstr_8BBA05185F8B99" || var_1 == "_encstr_A7A408B9CA5D1D4E2C63") {
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);

    if(istrue(level.usehpzonebrushes)) {
      foreach(var_3 in level.players)
      level.zone showzoneneutralbrush(var_3);
    }

    level.zone thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_83830BCCF8B0BC39751B7B635B", level.zone.trigger.origin);
  } else {
    if(scripts\mp\utility\game::getgametype() == "_encstr_BDD705AD7BD143") {
      scripts\mp\utility\sound::playsoundonplayers("_encstr_88DB1FA8039FB07B93B79F28CC6A699E0BDFC898FF6AA93929DA182E24239BE375", var_1);
      scripts\mp\utility\sound::playsoundonplayers("_encstr_83371F10BB2778B34B7F67E014A2D1C64397805037A2116161E5D5FC6E5BD32BAD", scripts\mp\utility\game::getotherteam(var_1)[0]);
    } else if(scripts\mp\utility\game::getgametype() == "_encstr_9A7205B39CB919") {
      scripts\mp\utility\sound::playsoundonplayers("_encstr_AAFE1E62300FB76348A7E2FFB0D10FBE9BC87B7B88C3EF9FC3B7D3E15578E347", var_1);
      scripts\mp\utility\sound::playsoundonplayers("_encstr_87881E305B89A92BD7704AC8E607766FEEC37048D35FD1C6FB3DDC37D41F1B3B", scripts\mp\utility\game::getotherteam(var_1)[0]);
    }

    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

    foreach(var_3 in level.players)
    level.zone showcapturedhardpointeffecttoplayer(var_1, var_3);

    level.zone thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_AF5E1143B4B163EBAB7336DECD3AB2B947598C", level.zone.trigger.origin);
  }

  var_7 = (gettime() - self.hostvictimoverride) * 0.001;
  scripts\mp\utility\game::_id_119AC(undefined, undefined, "_encstr_81830F9940E56FB245904E6CBD6B2BB729", level.zone.trigger.origin, var_7 + "_encstr_8B6909873A3DC1109D8AA6");
  self.hostvictimoverride = undefined;
  var_8 = scripts\engine\utility::ter_op(var_1 == "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A7C5056BD931D1", var_1);
  level.zone thread updatechevrons(var_8);
  level _encstr_AF471E7B265A8F1B8B620F63E2500A8BBBDF4CB0E15DBF881C1F03FB7D1287E8::updateservericons(var_1, 0);
  self.didstatusnotify = 0;
}

_id_1471E(var_0) {
  binoculars_clearexpirationtimer(var_0);
}

zone_stompprogressreward(var_0) {
  var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_A20C07ABF304625E08");
  var_0 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

zone_onpinnedstate(var_0) {
  if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

zone_onunpinnedstate(var_0) {
  if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && !self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

binoculars_clearexpirationtimer(var_0, var_1) {
  if(!level._id_1221A) {
    return;
  }
  var_2 = scripts\mp\gamescore::_getteamscore(var_0);
  var_3 = scripts\mp\gamescore::_getteamscore(scripts\mp\utility\game::getotherteam(var_0)[0]);

  if(istrue(var_1)) {
    if(var_3 > var_2)
      level scripts\mp\gamelogic::resumetimer();
    else
      level scripts\mp\gamelogic::pausetimer();
  } else if(var_2 > var_3)
    level scripts\mp\gamelogic::resumetimer();
  else
    level scripts\mp\gamelogic::pausetimer();
}

setcrankedtimerzonecap(var_0) {
  if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var_0.cranked) && var_0.cranked)
    var_0 scripts\mp\cranked::setcrankedplayerbombtimer("_encstr_A1BD075837DCD29B47");
}

playhardpointneutralfx() {
  if(istrue(level.usehpzonebrushes)) {
    foreach(var_1 in level.players)
    showzoneneutralbrush(var_1);
  }
}

showcapturedhardpointeffecttoplayer(var_0, var_1) {
  var_2 = var_1.team;
  var_3 = var_1 ismlgspectator();

  if(var_3) {
    if(var_1 enablereloading() || var_1 useinvisibleplayerduringspawnselection())
      var_2 = "_encstr_9A8507BA4040188D08";
    else
      var_2 = var_1 getmlgspectatorteam();
  }

  if(istrue(level.usehpzonebrushes)) {
    if(level.zone.stalemate)
      showzonecontestedbrush(var_1);
    else if(var_2 == var_0)
      showzonefriendlybrush(var_1);
    else
      showzoneenemybrush(var_1);
  }
}

showzoneneutralbrush(var_0) {
  level.zone.friendlybrush hidefromplayer(var_0);
  level.zone.enemybrush hidefromplayer(var_0);
  level.zone.contestedbrush hidefromplayer(var_0);
  level.zone.neutralbrush showtoplayer(var_0);
}

showzonefriendlybrush(var_0) {
  level.zone.friendlybrush showtoplayer(var_0);
  level.zone.enemybrush hidefromplayer(var_0);
  level.zone.contestedbrush hidefromplayer(var_0);
  level.zone.neutralbrush hidefromplayer(var_0);
}

showzoneenemybrush(var_0) {
  level.zone.friendlybrush hidefromplayer(var_0);
  level.zone.enemybrush showtoplayer(var_0);
  level.zone.contestedbrush hidefromplayer(var_0);
  level.zone.neutralbrush hidefromplayer(var_0);
}

showzonecontestedbrush(var_0) {
  level.zone.friendlybrush hidefromplayer(var_0);
  level.zone.enemybrush hidefromplayer(var_0);
  level.zone.contestedbrush showtoplayer(var_0);
  level.zone.neutralbrush hidefromplayer(var_0);
}

hideplayerspecificbrushes(var_0) {
  self.friendlybrush hidefromplayer(var_0);
  self.enemybrush hidefromplayer(var_0);
  self.neutralbrush hidefromplayer(var_0);
  self.contestedbrush hidefromplayer(var_0);
}

onplayerjoinedteam(var_0) {
  if(var_0.team != "_encstr_AF8C0A1B6A1D6045925B4F7D" && level.zone.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63")
    level.zone showcapturedhardpointeffecttoplayer(level.zone.ownerteam, var_0);
}

_id_12BFF(var_0, var_1) {
  var_2 = [];
  var_3 = [];

  switch (level.mapname) {
    case "_encstr_A5110B50E25F68A83BD3D3EBBB":
      var_3["_encstr_A34C02BB"] = [(-564, 1848, 24)];
      var_3["_encstr_A74C0222"] = [(-1314, 440, 24), (-1362, 816, 24)];
      break;
    case "_encstr_BDFF088922C9FF1946BF":
    case "_encstr_99020BB0027F38974BA78783FF":
      var_3["_encstr_A14C023B"] = [(-692, 1828, 42), (-300, 1548, 76)];
      break;
    case "_encstr_A3890850E25F90B79A83":
      var_3["_encstr_864C02F9"] = [(688, 256, 280)];
      var_3["_encstr_990703B2F9"] = [(212, 1436, 338)];
      break;
    case "_encstr_8B1D09FFC8A63802BDEF7B":
      var_3["_encstr_914C02DC"] = [(-1230.29, -25.4772, 240.125)];
      break;
    default:
      break;
  }

  if(isDefined(var_3[var_1])) {
    foreach(var_5 in var_0) {
      foreach(var_7 in var_3[var_1]) {
        if(distance(var_5.origin, var_7) < 10) {
          var_2[var_2.size] = var_5;
          break;
        }
      }
    }
  }

  var_0 = scripts\engine\utility::array_remove_array(var_0, var_2);
  return var_0;
}

_id_12806(var_0, var_1) {
  var_2 = [];
  var_3 = [];

  switch (level.mapname) {
    case "_encstr_A5110B50E25F68A83BD3D3EBBB":
      var_2["_encstr_A34C02BB"] = [];
      var_2["_encstr_A34C02BB"][0] = [(-564, 1880, 24), (0, 180, 0)];
      var_2["_encstr_A34C02BB"][1] = [(-564, 1976, 24), (0, 180, 0)];
      var_2["_encstr_A34C02BB"][2] = [(-564, 2072, 24), (0, 180, 0)];
      var_2["_encstr_A74C0222"] = [];
      var_2["_encstr_A74C0222"][0] = [(-1314, 472, 24), (0, 180, 0)];
      var_2["_encstr_A74C0222"][1] = [(-1314, 568, 24), (0, 180, 0)];
      var_2["_encstr_A74C0222"][2] = [(-1474, 816, 24), (0, 270, 0)];
      var_2["_encstr_A74C0222"][3] = [(-1378, 816, 24), (0, 270, 0)];
      var_2["_encstr_AC4C024A"] = [];
      var_2["_encstr_AC4C024A"][0] = [(-1298, 1992, 24), (0, 180, 0)];
      var_2["_encstr_AC4C024A"][1] = [(-1400, 2262, 24), (0, 270, 0)];
      var_2["_encstr_AC4C024A"][2] = [(-1690, 2264, 24), (0, 270, 0)];
      break;
    case "_encstr_86D70CE85A1768FD42CB95B7CB2A":
      var_2["_encstr_A74C0222"] = [];
      var_2["_encstr_A74C0222"][0] = [(436, 3435, 207.694), (0, 360, 0)];
      var_2["_encstr_A74C0222"][1] = [(436, 3188, 247.694), (0, 360, 0)];
      var_2["_encstr_A74C0222"][2] = [(436, 3098, 258.694), (0, 360, 0)];
      var_2["_encstr_A74C0222"][3] = [(1051, 2796, 304), (0, 117.509, 0)];
      var_2["_encstr_A74C0222"][4] = [(931, 2680, 304), (0, 147.509, 0)];
      var_2["_encstr_A74C0222"][5] = [(515, 3522, 215), (0, 276, 0)];
      var_2["_encstr_8C0703491D"] = [];
      var_2["_encstr_8C0703491D"][0] = [(-400, 651, 436), (0, 180, 0)];
      var_2["_encstr_8C0703491D"][1] = [(-400, 557, 439), (0, 180, 0)];
      var_2["_encstr_8C0703491D"][2] = [(-400, 461, 446), (0, 180, 0)];
      var_2["_encstr_8C0703491D"][3] = [(-410, -65, 446), (0, 180, 0)];
      var_2["_encstr_8C0703491D"][4] = [(-408, 31, 448), (0, 180, 0)];
      break;
    case "_encstr_A3890850E25F90B79A83":
      var_2["_encstr_B84C027E"] = [];
      var_2["_encstr_B84C027E"][0] = [(-3118.59, 230.46, 292), (0, 0, 0)];
      var_2["_encstr_864C02F9"] = [];
      var_2["_encstr_864C02F9"][0] = [(688, 256, 295), (0, 270, 0)];
      var_2["_encstr_864C02F9"][1] = [(749, 248, 295), (0, 270, 0)];
      var_2["_encstr_8C0703491D"] = [];
      var_2["_encstr_8C0703491D"][0] = [(-1490.62, -972.979, 422), (0, 90, 0)];
      var_2["_encstr_A90703297F"] = [];
      var_2["_encstr_A90703297F"][0] = [(-1695.67, 3211.7, 310), (0, 270, 0)];
      var_2["_encstr_A90703297F"][1] = [(-1804.59, 3219.27, 284), (0, 270, 0)];
      var_2["_encstr_990703B2F9"] = [];
      var_2["_encstr_990703B2F9"][0] = [(260, 1416, 338), (0, 90, 0)];
      break;
    case "_encstr_BDFF088922C9FF1946BF":
    case "_encstr_99020BB0027F38974BA78783FF":
      var_2["_encstr_A14C023B"] = [];
      var_2["_encstr_A14C023B"][0] = [(-514, 1328, 32), (0, 100, 0)];
      var_2["_encstr_A14C023B"][1] = [(-692, 1828, 42), (0, 260, 0)];
      var_2["_encstr_A14C023B"][2] = [(-564, 1804, 44), (0, 260, 0)];
      var_2["_encstr_A14C023B"][3] = [(-500, 1788, 54), (0, 260, 0)];
      var_2["_encstr_A14C023B"][4] = [(-312, 1528, 78), (0, 145, 0)];
      break;
    case "_encstr_994B10FAA8973CA771A27E6D431E0F8635E0":
    case "_encstr_86570E71DA311191DB1FD8887FCFA9A3":
      var_2["_encstr_864C02F9"] = [];
      var_2["_encstr_864C02F9"][0] = [(994.552, 1760.12, 44), (0, 270, 0)];
      var_2["_encstr_8B4C0227"] = [];
      var_2["_encstr_8B4C0227"][0] = [(1322, -407.18, 29.184), (0, 90, 0)];
      break;
    case "_encstr_93FB0A6B1C7D2CB92D5EB00D":
      var_2["_encstr_A90703297F"] = [];
      var_2["_encstr_A90703297F"][0] = [(1995.79, 394.828, 424), (0, 270, 0)];
      break;
    case "_encstr_8B1D09FFC8A63802BDEF7B":
      var_2["_encstr_914C02DC"] = [];
      var_2["_encstr_914C02DC"][0] = [(-1231.9, -132.317, 183.246), (0, 90, 0)];
      break;
    default:
      break;
  }

  if(isDefined(var_2[var_1])) {
    foreach(var_5 in var_2[var_1]) {
      var_6 = var_5[0];
      var_7 = var_5[1];
      var_8 = easepower("_encstr_9B6512802B78F73340D0E24BFEAE8B6FF0B50F1E", var_6, var_7);
      var_3[var_3.size] = var_8;
    }
  }

  var_0 = scripts\engine\utility::array_combine(var_0, var_3);
  return var_0;
}

init_vo_arrays(var_0, var_1, var_2) {
  var_0.origin = var_1;
  var_0.angles = var_2;
  return var_0;
}

_id_144DA() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A2FA163B83B8D3C1A0E35C53E908D5C7C8FBA30249045F42");
  var_0 = self.entnum;
  self.trigger scripts\engine\utility::trigger_on();

  foreach(var_2 in level.teamnamelist) {
    self.playerzombiedelayturnonfx[var_2] = 0;
    self.playerzombiedestroyhud[var_2] = [];
  }

  self.playerzombiedelayturnonfx["_encstr_A7A408B9CA5D1D4E2C63"] = 0;
  self.playerzombiedestroyhud["_encstr_A7A408B9CA5D1D4E2C63"] = [];
  self.playerzombiedestroyhud["_encstr_8BBA05185F8B99"] = [];
  self.getinventoryslotvo = 1;

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_4);

    if(!scripts\mp\utility\player::isreallyalive(var_4)) {
      continue;
    }
    if(isagent(var_4)) {
      continue;
    }
    if(!scripts\mp\utility\entity::isgameparticipant(var_4)) {
      continue;
    }
    if(istrue(var_4.inlaststand)) {
      continue;
    }
    if(isDefined(var_4.classname) && var_4.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
      continue;
    }
    if(!isDefined(var_4.initialized_gameobject_vars)) {
      continue;
    }
    var_5 = scripts\mp\gameobjects::getrelativeteam(var_4.pers["_encstr_8AEF05472BC2D6"]);

    if(isDefined(self.teamusetimes[var_5]) && self.teamusetimes[var_5] < 0) {
      continue;
    }
    if(scripts\mp\utility\player::isreallyalive(var_4) && !isDefined(var_4.touchtriggers[var_0])) {
      var_2 = var_4.pers["_encstr_8AEF05472BC2D6"];
      self.playerzombiedelayturnonfx[var_2]++;
      var_6 = var_4.guid;
      var_7 = spawnStruct();
      var_7.player = var_4;
      var_7.starttime = gettime();
      self.playerzombiedestroyhud[var_2][var_6] = var_7;
      var_4.spawn_sentry_at_pos = 0;
    }

    if(scripts\mp\utility\player::isreallyalive(var_4) && !isDefined(var_4.touchtriggers[var_0]))
      var_4 thread playerzombiedovehicledamageimmunity(self);
  }
}

playerzombiedovehicledamageimmunity(var_0) {
  level endon("_encstr_A2FA163B83B8D3C1A0E35C53E908D5C7C8FBA30249045F42");
  var_1 = self.pers["_encstr_8AEF05472BC2D6"];

  while(scripts\mp\utility\player::isreallyalive(self) && isDefined(var_0.trigger) && self istouching(var_0.trigger) && !level.gameended) {
    if(isDefined(var_0.checkinteractteam) && var_0.team != var_1) {
      break;
    }

    if(istrue(self.inlaststand)) {
      break;
    }

    if(isDefined(var_0.interactsquads) && !isDefined(var_0.interactsquads[self.team]) || isDefined(var_0.interactsquads) && !scripts\engine\utility::array_contains(var_0.interactsquads[self.team], self.squadindex)) {
      break;
    }

    waitframe();
  }

  if(level.gameended) {
    return;
  }
  if(isDefined(self)) {
    var_0.playerzombiedestroyhud[var_1][self.guid] = undefined;
    self.spawn_sentry_at_pos = 0;
  } else {
    var_2 = [];

    foreach(var_5, var_4 in var_0.playerzombiedestroyhud[var_1]) {
      if(!isDefined(var_4.player))
        var_2[var_2.size] = var_5;
    }

    foreach(var_5 in var_2)
    var_0.playerzombiedestroyhud[var_1][var_5] = undefined;
  }

  var_0.playerzombiedelayturnonfx[var_1]--;
}