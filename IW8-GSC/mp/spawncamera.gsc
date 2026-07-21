/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\spawncamera.gsc
***********************************************/

init() {
  if(!isDefined(level.loadoutdefaultfiresalediscount))
    level.loadoutdefaultfiresalediscount = getdvarint("_encstr_A7A71CCDC69CD7EC2C6BCAFA194B6E2C13B1B2E68385DDB9C60BB5B2E416", 0) == 1;

  level.snaptospawncamera = getdvarint("_encstr_AF771A1BB6BB57DAA78A27705B08D9FF8646E90DDD821FCF9BE60BF8", 1) == 1;
  level.evaluatefrontline = getdvarint("_encstr_8C811F3FE8BBA78AC3B157C1A6C922378040EFCFA0D3D13115D6DD850D89FAE609", 0) == 1;
  level.evaluatespawnforcameraselection = getdvarint("_encstr_A1D420E6C64EBEECB0B6ACF5CD0758EEE61B16B6594E0B7DB98316EEDC38DE96B93A", 1) == 1;
  level.updatedefaultcamera = ::blank_func;
  level.updategamemodecamera = ::blank_func;

  if(!istrue(level.loadoutdefaultfiresalediscount))
    initcameras();
}

blank_func() {}

initcameras() {
  level.spawncameras = [];
  level.currentcamera = [];

  foreach(var_1 in level.teamnamelist)
  level.currentcamera[var_1] = "_encstr_8B1608EC43B8D647A113";

  var_3 = scripts\engine\utility::getStructArray("_encstr_9AF4179B3858BBB9FA9B59C6B2C61DB47B73BE8D165BAC4E58", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_3.size == 0 || level.mapname == "_encstr_83970EDA1CFAC2E65AF21686BE47C28D") {
    createdefaultcameras();
    return;
  }

  foreach(var_5 in var_3) {
    var_6 = var_5.script_label;

    if(!isDefined(var_6) || var_6 == "_encstr_9AF4179B3858BBB9FA9B59C6B2C61DB47B73BE8D165BAC4E58")
      var_6 = var_5.script_noteworthy;

    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      var_7 = var_5.script_noteworthy;

      if(!isDefined(var_7) || isDefined(var_7) && var_7 != level.localeid)
        continue;
    }

    if(!isDefined(level.spawncameras[var_6]))
      level.spawncameras[var_6] = [];

    var_8 = var_5.script_team;

    if(var_8 == "_encstr_AF1904A7F929") {
      foreach(var_1 in level.teamnamelist)
      level.spawncameras[var_6][var_1] = var_5;

      continue;
    }

    if(istrue(level.usestaticspawnselectioncamera)) {
      var_11 = scripts\mp\spawnselection::getstaticcameraposition(var_8);
      var_5.origin = var_11.origin;
      var_5.angles = var_11.angles;
    }

    level.spawncameras[var_6][var_8] = var_5;
  }

  createdefaultcameras();
}

createdefaultcameras() {
  if(isDefined(level.spawncameras["_encstr_8B1608EC43B8D647A113"])) {
    var_0 = 1;

    foreach(var_2 in level.teamnamelist) {
      if(!isDefined(level.spawncameras["_encstr_8B1608EC43B8D647A113"][var_2])) {
        var_0 = 0;
        break;
      }
    }

    if(var_0)
      return;
  } else
    level.spawncameras["_encstr_8B1608EC43B8D647A113"] = [];

  var_4 = (0, 0, 0);

  if(isDefined(level.mapcorners) && isDefined(level.mapcorners[0]) && isDefined(level.mapcorners[1])) {
    level.mapcornervector = level.mapcorners[1].origin - level.mapcorners[0].origin;
    level.mapcornercenter = level.mapcorners[0].origin + level.mapcornervector * 0.5;
  }

  foreach(var_2 in level.teamnamelist) {
    if(isDefined(level.spawncameras["_encstr_8B1608EC43B8D647A113"][var_2])) {
      level.spawncameras["_encstr_8B1608EC43B8D647A113"][var_2].radiantplaced = 1;
      continue;
    }

    var_6 = spawnStruct();
    var_6.origin = (0, 0, 0);
    var_6.angles = (0, 0, 0);
    level.spawncameras["_encstr_8B1608EC43B8D647A113"][var_2] = var_6;
  }

  level.spawncamerastartspawnallies = getstartspawnavg("_encstr_9A8507BA4040188D08");
  level.spawncamerastartspawnaxis = getstartspawnavg("_encstr_8E8405EA382B2A");
  level.spawncamerastartspawnaxisang = scripts\engine\utility::ter_op(distancesquared(level.spawncamerastartspawnaxis, level.mapcorners[0].origin) < distancesquared(level.spawncamerastartspawnaxis, level.mapcorners[1].origin), level.mapcorners[0].angles, level.mapcorners[1].angles);
  var_8 = level.spawncamerastartspawnaxis - level.spawncamerastartspawnallies;
  var_9 = level.spawncamerastartspawnallies + var_8 * 0.5;

  if(distancesquared(level.spawncamerastartspawnallies, level.mapcorners[0].origin) < distancesquared(level.spawncamerastartspawnallies, level.mapcorners[1].origin)) {
    var_10 = anglesToForward(level.mapcorners[0].angles);
    var_11 = anglestoright(level.mapcorners[0].angles);

    if(abs(vectordot(var_8, var_10)) > abs(vectordot(var_8, var_11)))
      level.spawncamerastartspawnalliesvec = var_10;
    else
      level.spawncamerastartspawnalliesvec = var_11;
  } else {
    var_10 = anglesToForward(level.mapcorners[1].angles);
    var_11 = anglestoright(level.mapcorners[1].angles);

    if(abs(vectordot(var_8, var_10)) > abs(vectordot(var_8, var_11)))
      level.spawncamerastartspawnalliesvec = var_10;
    else
      level.spawncamerastartspawnalliesvec = var_11;
  }

  if(distancesquared(level.spawncamerastartspawnaxis, level.mapcorners[0].origin) < distancesquared(level.spawncamerastartspawnaxis, level.mapcorners[1].origin)) {
    var_10 = anglesToForward(level.mapcorners[0].angles);
    var_11 = anglestoright(level.mapcorners[0].angles);

    if(abs(vectordot(var_8, var_10)) > abs(vectordot(var_8, var_11)))
      level.spawncamerastartspawnaxisvec = var_10;
    else
      level.spawncamerastartspawnaxisvec = var_11;
  } else {
    var_10 = anglesToForward(level.mapcorners[1].angles);
    var_11 = anglestoright(level.mapcorners[1].angles);

    if(abs(vectordot(var_8, var_10)) > abs(vectordot(var_8, var_11)))
      level.spawncamerastartspawnaxisvec = var_10;
    else
      level.spawncamerastartspawnaxisvec = var_11;
  }

  var_12 = distance(level.spawncamerastartspawnallies, level.spawncamerastartspawnaxis);
  level.spawncameradistfactor = var_12;
  orientdefaulttomapcenterusingmapcorners();
}

init_trap_room_traps() {
  if(isDefined(level.updatedefaultcamera))
    [[level.updatedefaultcamera]]();

  if(isDefined(level.updategamemodecamera))
    self[[level.updategamemodecamera]]();

  var_0 = self.origin + (0, 0, 60);
  var_1 = self.angles;

  if(isDefined(self.squadspectatepos)) {
    self.deathspectatepos = self.squadspectatepos;
    self.deathspectateangles = self.squadspectateang;
  } else {
    self.deathspectatepos = var_0;
    self.deathspectateangles = var_1;
  }

  if(!isDefined(self.spawncameraent)) {
    var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.deathspectatepos);
    var_2 scripts\cp_mp\ent_manager::registerspawncount(1);
    var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_2.angles = self.deathspectateangles;
    self.spawncameraent = var_2;
  } else {
    self.spawncameraent.origin = self.deathspectatepos;
    self.spawncameraent.angles = self.deathspectateangles;
  }
}

startspawncamera(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\mp\utility\player::_id_12898("_encstr_8DD9269B072CDDB9D0585BAC395874D1CD8EB0938EA9382CEE37682CAD562758412501A645509251");
  scripts\mp\utility\player::hideminimap(1);
  init_trap_room_traps();

  if(!isDefined(self.spawncameraent)) {
    scripts\mp\utility\player::_id_12898("_encstr_B2EC3CB38343A3C31DDF05056E61AAB8CFB81ADB487FDA3773B033398989C3B681FA962121B95FF3ECB83D14379793F6D73928F8D103C2274590D4699FF1");
    thread playslamzoomflash(0.0, getspawncamerawaittime(), 0.5);
    return;
  }

  if(istrue(level.loadoutdefaultfiresalediscount) && scripts\mp\utility\game::getgametype() != "_encstr_B81904B04E6B") {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(istrue(self.inspawncamera)) {
    return;
  }
  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(self.setspawnpoint)) {
    return;
  }
  self.inspawncamera = 1;
  scripts\mp\utility\player::setdof_default();
  waitframe();
  scripts\mp\spectating::setdisabled();
  scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  self setclientomnvar("_encstr_A63C1393641F0870B99FB9A3B792D090F9FD198B8E", 1);

  if(!isDefined(var_0))
    var_0 = 0.0;

  if(!isDefined(var_1))
    var_1 = 0.25;

  if(!isDefined(var_2))
    var_2 = 0.25;

  thread playslamzoomflash(var_0, var_1, var_2);
  scripts\engine\utility::_id_143BF(0.1, "_encstr_A3D50C33DE93B159EBCD1CB0DDB9");
  thread removecameraondisconnect(self.spawncameraent);
  self cameralinkTo(self.spawncameraent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1, 1);
  scripts\mp\utility\player::_id_12898("_encstr_859E2F8E2A22DFE06BA77038C361B29DEBD30F9683B999492783390B47BDF363062C57865E320BD31963607077E46809BE");
  self clearadditionalstreampos();
  thread snaptospawncamera();
}

getspawncamerawaittime() {
  if(isDefined(self.spawncameratime))
    return self.spawncameratime;
  else if(istrue(self.squadspawnaborted) || !istrue(level.snaptospawncamera) && (istrue(self.skippedkillcam) || !isDefined(self.killcamwatchtime) || self.killcamwatchtime < 2.0))
    return 2.5;
  else
    return 1.5;
}

room_door_windows() {
  return 1.0;
}

getspawncamera() {
  var_0 = undefined;

  if(scripts\mp\utility\game::unset_relic_landlocked())
    self.forcedspawncameraref = "_encstr_8B1608EC43B8D647A113";

  if(isDefined(self.forcedspawncameraref)) {
    if(isDefined(level.spawncameras[self.forcedspawncameraref]))
      var_0 = level.spawncameras[self.forcedspawncameraref][self.team];
    else if(issubstr(self.forcedspawncameraref, "_encstr_8C950626C2CB5B19")) {
      var_1 = self.forcedspawncameraref;

      if(var_1 == "_encstr_AB460DF3C2D5A895590373035B82E6")
        var_2 = level.squaddata[self.team][self.squadindex].squadleaderindex;
      else
        var_2 = int(getsubstr(var_1, var_1.size - 1, var_1.size));

      var_3 = undefined;

      if(isDefined(level.squaddata[self.team]) && isDefined(level.squaddata[self.team][self.squadindex]) && isDefined(level.squaddata[self.team][self.squadindex].players[var_2]))
        var_3 = level.squaddata[self.team][self.squadindex].players[var_2];

      if(isDefined(var_3)) {
        var_4 = level.spawnselectionteamforward[self.team];
        var_5 = var_3.origin + var_4 * -8500 + (0, 0, 7000);
        var_6 = vectorNormalize(var_3.origin - var_5);
        var_7 = scripts\mp\utility\script::vectortoanglessafe(var_6, (0, 0, 1));

        if(istrue(level.useunifiedspawnselectioncameraheight)) {
          var_8 = scripts\mp\spawnselection::getunifedspawnselectioncameraheight();
          var_5 = (var_5[0], var_5[1], var_8);
        }

        var_5 = var_5 + _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::calculatecameraoffset(self.team, var_3.origin);
        var_0 = spawnStruct();
        var_0.origin = var_5;
        var_0.angles = var_7;
      }
    } else if(issubstr(self.forcedspawncameraref, "_encstr_9A50080BA7292FFA0DA2")) {
      var_1 = self.forcedspawncameraref;
      var_9 = undefined;

      if(isDefined(level.spawnselectionlocations[var_1]) && isDefined(level.spawnselectionlocations[var_1][self.team]))
        var_9 = level.spawnselectionlocations[var_1][self.team].dynamicent;

      var_4 = level.spawnselectionteamforward[self.team];

      if(isDefined(var_9) && !istrue(var_9.isdestroyed)) {
        var_5 = [];
        var_7 = [];

        if(istrue(level.usestaticspawnselectioncamera)) {
          var_10 = scripts\mp\spawnselection::getstaticcameraposition(self.team);
          var_5 = var_10.origin;
          var_7 = var_10.angles;
        } else {
          var_5 = var_9.origin + var_4 * -8500 + (0, 0, 7000);

          if(istrue(level.useunifiedspawnselectioncameraheight)) {
            var_8 = scripts\mp\spawnselection::getunifedspawnselectioncameraheight();
            var_5 = (var_5[0], var_5[1], var_8);
          }

          var_11 = level.spawnselectionlocations[var_1][self.team].anchorentity.origin;
          var_12 = var_11 + var_4 * -8500 + (0, 0, 7000);
          var_13 = vectorNormalize(var_11 - var_12);
          var_7 = scripts\mp\utility\script::vectortoanglessafe(var_13, (0, 0, 1));
          var_5 = var_5 + _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::calculatecameraoffset(self.team, var_11);
        }

        var_0 = spawnStruct();
        var_0.origin = var_5;
        var_0.angles = var_7;
      }
    }
  } else if(istrue(level.evaluatespawnforcameraselection) && isDefined(level.was_seq3_gassed) && isDefined(level.was_seq3_gassed[self.team])) {
    var_14 = level.was_seq3_gassed[self.team];
    var_15 = undefined;
    var_16 = undefined;

    foreach(var_20, var_18 in level.spawncameras[level.currentcamera[self.team]]) {
      var_19 = distancesquared(var_18.origin, var_14);

      if(!isDefined(var_16) || var_19 < var_15) {
        var_16 = var_18;
        var_15 = var_19;
      }
    }

    var_0 = var_16;
  } else if(istrue(level.evaluatefrontline)) {
    var_21 = calulatefrontline();
    var_15 = undefined;
    var_16 = undefined;

    foreach(var_20, var_18 in level.spawncameras[level.currentcamera[self.team]]) {
      var_23 = distancesquared(var_18.origin, var_21.teamavg[self.team]);
      var_24 = distancesquared(var_18.origin, var_21.origin);

      if(!isDefined(var_16) || var_23 < var_24) {
        var_16 = var_18;
        var_15 = var_23;
      }
    }

    var_0 = var_16;
  } else {
    if(istrue(level.usec130spawn)) {
      while(!isDefined(level.currentcamera[self.team]))
        waitframe();
    }

    if(!isstring(level.currentcamera[self.team])) {
      var_0 = spawnStruct();
      var_0.origin = level.currentcamera[self.team].origin;
      var_0.angles = level.currentcamera[self.team].angles;
      var_0.usingintermissionpos = 1;
    } else
      var_0 = level.spawncameras[level.currentcamera[self.team]][self.team];
  }

  if(!isDefined(var_0)) {
    if(isDefined(level.availablespawnlocations) && isDefined(level.availablespawnlocations[self.team])) {
      level.currentcamera[self.team] = level.availablespawnlocations[self.team][0];
      var_0 = level.spawncameras[level.currentcamera[self.team]][self.team];
    } else {
      level.currentcamera[self.team] = "_encstr_8B1608EC43B8D647A113";
      var_0 = level.spawncameras[level.currentcamera[self.team]][self.team];
    }
  }

  return var_0;
}

movetospawncamerainitial() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_8DBA1EDCAC779AED672B2A7BD40785BBE6D058DAB29C1629375A1D5A2C8EACC8");
  self endon("_encstr_8DBA1EDCAC779AED672B2A7BD40785BBE6D058DAB29C1629375A1D5A2C8EACC8");
  self endon("_encstr_A7EE1CA3B3DE9907E03381924B3047C2B8C54767337E41C3C859C59F8130");
  self endon("_encstr_AD49123763B0AD96F6EDDAA4B95A1D96C28ECA91");
  var_0 = getspawncamera();
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = self.spawncameraent.origin;
  var_4 = vectorNormalize(var_3 - var_0.origin);
  var_5 = scripts\mp\utility\script::vectortoanglessafe(var_4, (0, 0, 1));
  self.spawncameraent.angles = var_5;
  var_6 = distance(var_3, var_1);
  var_7 = var_6 / 3520;
  var_7 = clamp(var_7, 1.5, 3.0);
  self.spawncameratargetpos = var_1;
  self.spawncameratargetang = var_2;
  self.spawncameratime = var_7;
  self.spawncameraendtime = gettime() + var_7 * 1000;

  if(!istrue(var_0.usingintermissionpos)) {
    self.spawncameraent moveTo(var_1, var_7, var_7 * 0.3, var_7 * 0.4);
    self.spawncameraent rotateTo(var_2, var_7, var_7 * 0.3, var_7 * 0.4);
    wait 1.0;
  } else {
    self.spawncameraent.origin = var_1;
    self.spawncameraent.angles = var_2;
    self.deathspectatepos = var_1;
  }

  applythermal();
  thread startoperatorsound();

  if(isDefined(self) && isDefined(self.spawncameraent) && !istrue(self.inspawnselection)) {
    var_8 = anglesToForward(var_2) * 300;
    var_8 = var_8 * (1, 1, 0);
    self earthquakeforplayer(0.03, 15.0, var_1, 1000);
  }

  self notify("_encstr_883D12A03B66AF883733E7E90DBB5137CCE2D0E8");
}

movetospawncamera(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_8DBA1EDCAC779AED672B2A7BD40785BBE6D058DAB29C1629375A1D5A2C8EACC8");
  self endon("_encstr_8DBA1EDCAC779AED672B2A7BD40785BBE6D058DAB29C1629375A1D5A2C8EACC8");
  self endon("_encstr_B4B31C4716C6EBBDE0E6BE5B2CE0F56E566395C6A32DBDE67DEC16D85AC8");
  self endon("_encstr_A7EE1CA3B3DE9907E03381924B3047C2B8C54767337E41C3C859C59F8130");
  self endon("_encstr_AD49123763B0AD96F6EDDAA4B95A1D96C28ECA91");
  var_1 = getspawncamera();
  var_2 = var_1.origin;
  var_3 = var_1.angles;

  if(isDefined(self.spawncameratargetpos) && isDefined(self.spawncameratargetang) && self.spawncameratargetpos == var_2 && self.spawncameratargetang == var_3) {
    return;
  }
  var_4 = self.spawncameraent.origin;
  var_5 = vectorNormalize(var_4 - var_1.origin);
  self.spawncameratargetpos = var_2;
  self.spawncameratargetang = var_3;
  self.spawncameraent moveTo(var_2, 1.0, 0.25, 0.75);
  self.spawncameraent rotateTo(var_3, 1.0, 0.25, 0.75);
  wait 1.0;

  if(isDefined(self) && isDefined(self.spawncameraent) && !istrue(self.inspawnselection)) {
    var_6 = anglesToForward(var_3) * 300;
    var_6 = var_6 * (1, 1, 0);
    self.spawncameraent moveTo(var_2 + var_6, 15.0, 1.0, 1.0);
    self earthquakeforplayer(0.03, 15.0, var_2, 1000);
  }

  self notify("_encstr_883D12A03B66AF883733E7E90DBB5137CCE2D0E8");
}

snaptospawncamera() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(!istrue(self.get_bomb_icon_on_cell_phone_func))
    waitframe();

  var_0 = getspawncamera();
  self.spawncameraent dontinterpolate();
  self.spawncameraent.origin = var_0.origin;
  self.spawncameraent.angles = var_0.angles;
  scripts\mp\utility\player::_id_12898("_encstr_83B621EB581B0B6BA577ADDD9689728E67737253E1EFCACBD964A6F327D0F7DAEB4A7E");

  if(!istrue(level.nukedetonated))
    self visionsetnakedforplayer("_encstr_B40101", 0);

  applythermal();
  thread startoperatorsound();

  if(isDefined(self) && isDefined(self.spawncameraent) && !istrue(self.inspawnselection)) {
    var_1 = anglesToForward(self.spawncameraent.angles) * 300;
    var_1 = var_1 * (1, 1, 0);
    self.spawncameraent moveTo(self.spawncameraent.origin + var_1, 15.0, 1.0, 1.0);
    self earthquakeforplayer(0.03, 15.0, self.spawncameraent.origin, 1000);
  }

  self notify("_encstr_883D12A03B66AF883733E7E90DBB5137CCE2D0E8");
}

endspawncamera() {
  if(isDefined(self._id_12135)) {
    self clearsoundsubmix("_encstr_AF5F144BBBE0FAAD83FA37E02CBB37AF3658AD959C85");
    self._id_12135 stoploopsound(self._id_12136);
    self._id_12135 delete();
    self._id_12135 = undefined;
    self._id_12136 = undefined;
  }

  if(!isDefined(self.spawncameraent)) {
    return;
  }
  if(istrue(level.gameended)) {
    return;
  }
  scripts\mp\utility\player::hideminimap(1);
  thread _id_13917();
  runslamzoomonspawn();
}

deletespawncamera() {
  self cameraunlink();
  self.spawncameraent scripts\cp_mp\ent_manager::deregisterspawn();
  self.spawncameraent delete();
  self.spawncameraent = undefined;
  self.isusingspawnmapcamera = undefined;
  self.inspawncamera = 0;
  self notify("_encstr_9AA31537C158EEE6EB8D0BB5AC27C2D79156D895E8B223");
}

removecameraondisconnect(var_0) {
  self endon("_encstr_9AA31537C158EEE6EB8D0BB5AC27C2D79156D895E8B223");
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_0)) {
    var_0 scripts\cp_mp\ent_manager::deregisterspawn();
    var_0 delete();
  }
}

_id_13917() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_8291127AABA8D77A26533F179DDF912BE811B203");
  self predictstreampos(self getEye());
  self waittill("_encstr_A2FB163B03BFCF8DE1E7495DF3D01627D698529328051B87");
  self clearpredictedstreampos();
}

runslamzoomonspawn(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\mp\utility\player::_id_12898("_encstr_9B1F283EC7BA5C053D9F5B392D893A7262FDBBDF13F1427AA7A78BEF3DDA4FBA0BDDE919299ABCE136D1");
  self waittill("_encstr_8291127AABA8D77A26533F179DDF912BE811B203");
  scripts\mp\utility\player::_id_12898("_encstr_86133B3BCB921FD5517F91CDDAEA1A2DBA4BE6E3928F48A82017DB278E1F62EF679548BC68B66869D363A0312BF575E30830BBB0EDE3771F4192CF3D55");
  self notify("_encstr_AD49123763B0AD96F6EDDAA4B95A1D96C28ECA91");
  scripts\mp\utility\player::_freezecontrols(1, undefined, "_encstr_A63009702AB62BBE476FB1");
  self playerhide();
  self setbeingrevived(1);
  self.plotarmor = 1;
  scripts\common\utility::allow_vehicle_use(0);
  scripts\mp\spectating::setdisabled();
  scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  self cameralinkTo(self.spawncameraent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  scripts\mp\utility\player::_id_12898("_encstr_AD21316EC12CBBDCA185ADCA3916A3A39CD5CD3536C2DAB4B7DBDAF49B351C58BBCD054A083458B5ACE40B26B4B9B52AB74149");
  handlemovetoblended();
  deletespawncamera();

  if(self.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    scripts\mp\playerlogic::removefromalivecount();
    self setclientomnvar("_encstr_A63C1393641F0870B99FB9A3B792D090F9FD198B8E", 0);

    if(!istrue(level.nukedetonated))
      self visionsetnakedforplayer("_encstr_B40101", 0.5);

    scripts\mp\utility\player::_freezecontrols(0, undefined, "_encstr_A63009702AB62BBE476FB1");
    self setbeingrevived(0);
    self.plotarmor = 0;
    thread scripts\mp\spectating::setspectatepermissions();
    return;
  }

  scripts\mp\utility\player::updatesessionstate("_encstr_877508C1D8C22F2DDC3B");

  if(istrue(self._id_132FF)) {
    var_1 = scripts\mp\playerlogic::getspawnpoint();
    self setOrigin(var_1.spawnorigin);
    self setplayerangles(var_1.spawnangles);
    scripts\mp\spawnlogic::finalizespawnpointchoice(var_1.spawnpoint);
    self._id_132FF = undefined;
    self.selectedspawnarea = undefined;
  }

  self setclientomnvar("_encstr_A63C1393641F0870B99FB9A3B792D090F9FD198B8E", 0);

  if(!istrue(level.nukedetonated))
    self visionsetnakedforplayer("_encstr_B40101", 0.5);

  scripts\mp\utility\player::_freezecontrols(0, undefined, "_encstr_A63009702AB62BBE476FB1");
  self playershow();
  self setbeingrevived(0);
  self.plotarmor = 0;
  scripts\common\utility::allow_vehicle_use(1);
  self notify("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  level notify("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", self, self.wasrevivespawn);
  thread scripts\mp\playerlogic::setspawnnotifyomnvar();
  self.wasrevivespawn = undefined;
  self.delayedspawnedplayernotify = undefined;
  self.spawndata = undefined;
  scripts\mp\utility\player::_id_12898("_encstr_A3E72B4BD0F0BBB06D0170F8E29FEA32AEAB580FCD7858E1F7EF2597AD0E722F9B53391CB7B1C041A95C79BD4F");
}

handlemoveTo(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = self getEye();
  var_2 = self.angles;
  var_3 = (var_1[0], var_1[1], self.spawncameraent.origin[2]);
  var_3 = var_3 + anglesToForward(var_2) * -480;
  self.spawncameraent moveTo(var_3, 0.75, 0.25, 0.25);
  var_4 = vectorNormalize(var_1 - var_3);
  var_5 = scripts\mp\utility\script::vectortoanglessafe(var_4, (0, 0, 1));
  self.spawncameraent rotateTo(var_5, 0.75, 0.25, 0.25);
  wait 0.75;
  self visionsetnakedforplayer("_encstr_9A591141C97E59285BA366EBBAF7D188952FEB", 0.2);
  var_6 = var_1 + anglesToForward(var_2) * -60;
  self.spawncameraent moveTo(var_6, 0.5, 0.1, 0.4);
  self.spawncameraent rotateTo(var_2, 0.7, 0.45, 0.05);
  wait 0.5;
  thread playslamzoomflash();
  self.spawncameraent moveTo(var_1, 0.6, 0.1, 0.1);
  wait 0.2;
  self visionsetnakedforplayer("_encstr_B40101", 0);
}

handlemovetoblended(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A3031C7F0F6A9949D0E60841CD851141F2CBEB8F93A2C868FCFF7059B76C");
  scripts\mp\utility\player::_id_12898("_encstr_B19D22DCE0C2DD738685B559C90BA3E8340B37911B59A6BDCE5945DB419208A62A824A51");
  var_1 = self.spawndata.spawnorigin + (0, 0, 60);
  var_2 = self.spawndata.spawnangles;

  if(isDefined(self.forcespawncameraorg)) {
    var_1 = self.forcespawncameraorg;
    var_2 = self.forcespawncameraang;
    self.forcespawncameraorg = undefined;
    self.forcespawncameraang = undefined;
  }

  var_3 = angle_diff(self.spawncameraent.angles[1], var_2[1]) < 45;
  var_4 = distance2dsquared(self.spawncameraent.origin, var_1) > 1000000;
  thread fadeblackforgeo(var_1);

  if(!var_3 || !var_4) {
    if(!istrue(level.nukedetonated)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
        removethermal();
        self visionsetnakedforplayer("_encstr_B40101", 0);
      } else
        self visionsetnakedforplayer("_encstr_996415C320636002F728F1F6879B1A2A49893B3798B8BC", 0);
    }

    wait 0.05;
    self.spawncameraent moveTo(var_1, 1.0, 0.1, 0.9);
    self.spawncameraent rotateTo(var_2, 1.0, 0.9, 0.1);
    scripts\mp\utility\player::_id_12898("_encstr_99B72B4BD930E3FBE661820A2BDF9208D063DEA409C8A5B7249909927803325F41916468EDE8F76BC519713A1B");

    if(!istrue(level.nukedetonated)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap())
        self visionsetnakedforplayer("_encstr_9A591141C97E59285BA366EBBAF7D188952FEB", 0.8);
    }

    wait 0.8;
    wait 0.2;
  } else {
    var_5 = vectorNormalize(var_1 - self.spawncameraent.origin);
    var_6 = scripts\mp\utility\script::vectortoanglessafe(var_5, (0, 0, 1));
    self.spawncameraent rotateTo(var_6, 0.7, 0.2, 0.2);
    scripts\mp\utility\player::_id_12898("_encstr_882B319B1C58DDDCD085B6AC9C5847471A85B923C695D4ED67AC45B7149440C8A44AD41502841489648009B12BE623086AB2A3");

    if(!istrue(level.nukedetonated)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
        removethermal();
        self visionsetnakedforplayer("_encstr_B40101", 0);
      } else
        self visionsetnakedforplayer("_encstr_996415C320636002F728F1F6879B1A2A49893B3798B8BC", 0);
    }

    wait 0.05;
    self.spawncameraent moveTo(var_1, 1.0, 0.1, 0.9);

    if(!istrue(level.nukedetonated)) {
      if(!scripts\cp_mp\utility\game_utility::isnightmap())
        self visionsetnakedforplayer("_encstr_9A591141C97E59285BA366EBBAF7D188952FEB", 0.8);
    }

    wait 0.5;
    self.spawncameraent rotateTo(var_2, 0.5, 0.2, 0.1);
    scripts\mp\utility\player::_id_12898("_encstr_A20232F8633E87A07F19C935E21FE2C5A4DAA8C83A57BBD893055D388066D95F47342901D0BE49D5130E7FB6AC7FD88966A9E058");
    wait 0.3;
    wait 0.2;
  }

  scripts\mp\utility\player::_id_12898("_encstr_BA2F25DC8358BBCDA12CADB293B08EE8432CCD91D8B253DECECA8AB714920886A7D41431542A15");
  self notify("_encstr_A2FB163B03BFCF8DE1E7495DF3D01627D698529328051B87");
}

fadeblackforgeo(var_0) {
  var_1 = ["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0", "_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_A60119487802A71B0FC0568F305BCBE829E016EA88DA307605DCD9"];
  var_2 = physics_createcontents(var_1);
  var_3 = scripts\engine\trace::ray_trace(self.spawncameraent.origin, var_0, undefined, var_2);
  var_4 = scripts\engine\trace::ray_trace(var_0, self.spawncameraent.origin, undefined, var_2);
  var_5 = var_3["_encstr_A53009A25003666B9818C6"];
  var_6 = var_4["_encstr_A53009A25003666B9818C6"];
  var_7 = 0.11;

  if(istrue(self.spawningintovehicle)) {
    self setsoundsubmix("_encstr_9A611504947AB7DB013168E3E8AB017510E1C87859A09B", 0.1);
    thread clear_plr_vehicle_submix();
  }

  if(istrue(self.spawningintovehicle) || scripts\cp_mp\utility\game_utility::isnightmap()) {
    self.spawningintovehicle = undefined;

    if(isDefined(self._id_14268) && self._id_14268 == "_encstr_AF390B295782C3585F1B21D8C4") {
      var_5 = min(var_5, 0.95);
      var_6 = 0.0;
      var_7 = 0.75;
    } else {
      var_5 = min(var_5, 0.95);
      var_6 = 0.0;
    }
  }

  if(istrue(self._id_132FF)) {
    var_5 = min(var_5, 0.5);
    var_6 = 0.0;
    thread _id_14360();
  }

  if(var_5 < 1.0) {
    var_5 = clamp(var_5 - 0.1, 0.0, 0.95);

    if(var_5 - 0.22 > 0.0)
      wait(var_5 - 0.22);

    thread playslamzoomflash(0.1, 1.0 - var_5 - var_6 + var_7, 0.25);
  }
}

_id_14360() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_867E0DE2A9B51FDB1027D3DC7328DB");
  self notify("_encstr_A3031C7F0F6A9949D0E60841CD851141F2CBEB8F93A2C868FCFF7059B76C");
}

clear_plr_vehicle_submix() {
  wait 2.5;
  self clearsoundsubmix("_encstr_9A611504947AB7DB013168E3E8AB017510E1C87859A09B", 1);
}

playslamzoomflash(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.get_bomb_icon_on_cell_phone_func = 0;

  if(!isDefined(var_2))
    var_2 = 0.5;

  self notify("_encstr_B60B0FCA9A60EFF8603C7D2137E1E7EBA9");

  if(isDefined(var_0) && var_0 > 0) {
    var_3 = 0.0;
    var_4 = var_0 / level.framedurationseconds;
    var_5 = 1.0 / var_4;
    var_6 = 0;

    while(var_6 < var_4) {
      var_6++;
      var_3 = var_3 + var_5;
      var_3 = clamp(var_3, 0.0, 1.0);
      self setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", var_3);
      waitframe();
    }
  } else
    self setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", 1.0);

  self notify("_encstr_846A12C7CB49F517D04F68A71A88850BD5F8BB35");
  self.get_bomb_icon_on_cell_phone_func = 1;

  if(isDefined(var_1) && var_1 > 0)
    wait(var_1);

  self notify("_encstr_867E0DE2A9B51FDB1027D3DC7328DB");

  if(isDefined(var_2) && var_2 > 0) {
    var_3 = 1.0;
    var_4 = var_2 / level.framedurationseconds;
    var_5 = 1.0 / var_4;
    var_6 = 0;

    while(var_6 < var_4) {
      var_6++;
      var_3 = var_3 - var_5;
      var_3 = clamp(var_3, 0.0, 1.0);
      self setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", var_3);
      waitframe();
    }
  } else
    self setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", 0.0);

  self notify("_encstr_B43C108731387D4137B78F472BDF1AB56019");
}

movecameratomappos(var_0, var_1, var_2) {
  self moveTo(var_1, 1.0, 0.5, 0.5);
  self rotateTo(var_2, 1.0, 0.5, 0.5);
  var_0 thread startoperatorsound();
  wait 1.1;
}

applythermal() {
  if(istrue(self.spawncameraskipthermalonce)) {
    self.spawncameraskipthermalonce = 0;
    return;
  }

  if(istrue(self.spawncameraskipthermal)) {
    return;
  }
  if(!istrue(level.nukedetonated)) {
    if(scripts\cp_mp\utility\game_utility::isnightmap())
      self visionsetnakedforplayer("_encstr_996415C320636002F728F1F6879B1A2A49893B3798B8BC", 0);
    else
      self visionsetnakedforplayer("_encstr_99120F5E030B4F21971861D8B997FDFB72", 0);
  }
}

removethermal() {}

startoperatorsound() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self._id_12135)) {
    return;
  }
  if(istrue(level.nukeincoming)) {
    return;
  }
  self._id_12135 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
  self._id_12135 showonlytoplayer(self);
  self setsoundsubmix("_encstr_AF5F144BBBE0FAAD83FA37E02CBB37AF3658AD959C85");
  var_0 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
  var_1 = "_encstr_84690847F92EFD1AD01F" + var_0 + "_encstr_A19F1655B72FD2EA70D03FCF9869B19B39461C4E1DD11A12";

  if(!soundexists(var_1))
    var_1 = "_encstr_BAD81F70790955381FE60302588397F4CB12C85F7712BA1FD8096A7AC0EBE36043";

  self._id_12136 = var_1;
  self._id_12135 playLoopSound(var_1);
  thread needs_radar();
}

needs_radar() {
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_0 = self._id_12135;
  var_1 = self._id_12136;
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_0)) {
    var_0 stoploopsound(var_1);
    var_0 delete();
  }
}

setgamemodecamera(var_0, var_1) {
  level.spawncameras["_encstr_AAAC09D09972B9C83F2B7F"][var_0] = var_1;
  setspawncamera(var_0, "_encstr_AAAC09D09972B9C83F2B7F");
}

setspawncamera(var_0, var_1) {
  level.currentcamera[var_0] = var_1;
}

orientdefaulttomapcenterusingmapcorners() {
  if(!istrue(level.spawncameras["_encstr_8B1608EC43B8D647A113"]["_encstr_9A8507BA4040188D08"].radiantplaced)) {
    var_0 = level.mapcornercenter + level.spawncamerastartspawnalliesvec * level.spawncameradistfactor * -0.85 + (0, 0, 1) * level.spawncameradistfactor * 0.45;
    var_1 = vectorNormalize(level.mapcornercenter - var_0);
    var_2 = scripts\mp\utility\script::vectortoanglessafe(var_1, (0, 0, 1));
    level.spawncameras["_encstr_8B1608EC43B8D647A113"]["_encstr_9A8507BA4040188D08"].origin = var_0;
    level.spawncameras["_encstr_8B1608EC43B8D647A113"]["_encstr_9A8507BA4040188D08"].angles = var_2;
  }

  if(!istrue(level.spawncameras["_encstr_8B1608EC43B8D647A113"]["_encstr_8E8405EA382B2A"].radiantplaced)) {
    var_3 = level.mapcornercenter + level.spawncamerastartspawnaxisvec * level.spawncameradistfactor * -0.85 + (0, 0, 1) * level.spawncameradistfactor * 0.45;
    var_1 = vectorNormalize(level.mapcornercenter - var_3);
    var_4 = scripts\mp\utility\script::vectortoanglessafe(var_1, (0, 0, 1));
    level.spawncameras["_encstr_8B1608EC43B8D647A113"]["_encstr_8E8405EA382B2A"].origin = var_3;
    level.spawncameras["_encstr_8B1608EC43B8D647A113"]["_encstr_8E8405EA382B2A"].angles = var_4;
  }
}

orientdefaulttofrontline() {
  var_0 = scripts\mp\utility\teams::getfriendlyplayers("_encstr_9A8507BA4040188D08", 1);
  var_1 = level.spawncamerastartspawnallies;

  if(var_0.size > 0) {
    var_1 = (0, 0, 0);

    foreach(var_3 in var_0)
    var_1 = var_1 + var_3.origin;

    var_1 = var_1 / var_0.size;
  }

  var_5 = scripts\mp\utility\teams::getfriendlyplayers("_encstr_8E8405EA382B2A", 1);
  var_6 = level.spawncamerastartspawnaxis;

  if(var_5.size > 0) {
    var_6 = (0, 0, 0);

    foreach(var_3 in var_5)
    var_6 = var_6 + var_3.origin;

    var_6 = var_6 / var_5.size;
  }

  var_9 = var_6 - var_1;
  var_10 = vectorNormalize(var_9);
  var_11 = vectordot(var_9, var_9);

  if(var_11 < 1048576) {
    return;
  }
  var_12 = level.mapcornercenter + var_10 * level.spawncameradistfactor * -0.5 + (0, 0, 1) * level.spawncameradistfactor * 0.2;
  var_13 = vectorNormalize(level.mapcornercenter - var_12);
  var_14 = scripts\mp\utility\script::vectortoanglessafe(var_13, (0, 0, 1));
  level.spawncameras["_encstr_8B1608EC43B8D647A113"]["_encstr_9A8507BA4040188D08"].origin = var_12;
  level.spawncameras["_encstr_8B1608EC43B8D647A113"]["_encstr_9A8507BA4040188D08"].angles = var_14;
  var_15 = level.mapcornercenter + var_10 * level.spawncameradistfactor * 0.5 + (0, 0, 1) * level.spawncameradistfactor * 0.2;
  var_13 = vectorNormalize(level.mapcornercenter - var_15);
  var_16 = scripts\mp\utility\script::vectortoanglessafe(var_13, (0, 0, 1));
  level.spawncameras["_encstr_8B1608EC43B8D647A113"]["_encstr_8E8405EA382B2A"].origin = var_15;
  level.spawncameras["_encstr_8B1608EC43B8D647A113"]["_encstr_8E8405EA382B2A"].angles = var_16;
  thread scripts\mp\utility\debug::drawline(var_12, level.mapcornercenter, 60.0, (0, 0, 1));
  thread scripts\mp\utility\debug::drawline(var_15, level.mapcornercenter, 60.0, (1, 0, 0));
}

calulatefrontline() {
  var_0 = scripts\mp\utility\teams::getfriendlyplayers("_encstr_9A8507BA4040188D08", 1);
  var_1 = getstartspawnavg("_encstr_9A8507BA4040188D08");

  if(var_0.size > 0) {
    var_1 = (0, 0, 0);

    foreach(var_3 in var_0)
    var_1 = var_1 + var_3.origin;

    var_1 = var_1 / var_0.size;
  }

  var_5 = scripts\mp\utility\teams::getfriendlyplayers("_encstr_8E8405EA382B2A", 1);
  var_6 = getstartspawnavg("_encstr_8E8405EA382B2A");

  if(var_5.size > 0) {
    var_6 = (0, 0, 0);

    foreach(var_3 in var_5)
    var_6 = var_6 + var_3.origin;

    var_6 = var_6 / var_5.size;
  }

  var_9 = var_6 - var_1;
  var_10 = vectorNormalize(var_9);
  var_11 = spawnStruct();
  var_11.origin = (var_1 + var_6) * 0.5;
  var_11.angles = vectorcross(var_10, (0, 0, 1));
  var_11.teamavg = [];
  var_11.teamavg["_encstr_9A8507BA4040188D08"] = var_1;
  var_11.teamavg["_encstr_8E8405EA382B2A"] = var_6;
  return var_11;
}

getstartspawnavg(var_0) {
  if(isDefined(level.startspawnavg) && isDefined(level.startspawnavg[var_0]))
    return level.startspawnavg[var_0];

  if(!isDefined(level.startspawnavg))
    level.startspawnavg = [];

  level.startspawnavg[var_0] = (0, 0, 0);
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A1BD0E5B07D7E823D6D7371C58BB37F5" + var_0 + "_encstr_B4810709B378B9F3F5");
  var_2 = (0, 0, 0);

  foreach(var_4 in var_1)
  var_2 = var_2 + var_4.origin;

  if(var_1.size > 0)
    var_2 = var_2 / var_1.size;

  level.startspawnavg[var_0] = var_2;
  return level.startspawnavg[var_0];
}

angle_diff(var_0, var_1) {
  return 180 - abs(abs(var_0 - var_1) - 180);
}