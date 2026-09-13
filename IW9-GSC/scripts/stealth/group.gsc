/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\group.gsc
***********************************************/

_id_4E29112AC7171EC8() {
  return 0;
}

initgroup(groupname) {
  if(!isDefined(level.stealth.groupdata))
    level.stealth.groupdata = spawnStruct();

  groupdata = level.stealth.groupdata;

  if(!isDefined(groupdata.groups))
    groupdata.groups = [];

  _id_5C38C36E9F129B3E = groupdata.groups[groupname];

  if(!isDefined(_id_5C38C36E9F129B3E)) {
    _id_5C38C36E9F129B3E = _func_FF39FD6D3D8E4D65(groupname);
    groupdata.groups[groupname] = _id_5C38C36E9F129B3E;
  }

  level.stealth.groupdata notify(groupname);
}

addtogroup(groupname, guy) {
  if(!isDefined(level.stealth.groupdata) || !isDefined(level.stealth.groupdata.groups) || !isDefined(level.stealth.groupdata.groups[groupname]))
    initgroup(groupname);

  _id_5C38C36E9F129B3E = level.stealth.groupdata.groups[groupname];
  _func_C30ACBB55783D011(groupname, guy);
  _id_5C38C36E9F129B3E thread group_waitfordeath(guy);
}

group_waitfordeath(guy) {
  guy waittill("death");
  guy thread scripts\stealth\enemy::death_cleanup();

  if(isDefined(guy)) {
    group_removefrompod(guy);
    _func_BF304EFE09A7CEEB(self.name, guy);
  }
}

clearallgroups() {
  if(!isDefined(level.stealth.groupdata)) {
    return;
  }
  if(!isDefined(level.stealth.groupdata.groups)) {
    return;
  }
  level.stealth.groupdata.groups = undefined;
}

getgroup(groupname) {
  return level.stealth.groupdata.groups[groupname];
}

makenewpod(groupname, state, origin) {
  _id_6C53C959D5828324 = _func_08858434F2625BF7(groupname, state, origin);
  _id_6C53C959D5828324._id_BA700A27DB96934B = groupname;
  return _id_6C53C959D5828324;
}

addtopod(_id_B205CC0302DA1270, guy) {
  _func_8107C79679A9F8E1(_id_B205CC0302DA1270.id, guy);
}

group_trytojoinexistingpod(_id_0454DADDE3D9B791, _id_AA6726F343A56725, guy, _id_2AFC91629DE00A1A) {
  if(isDefined(_id_0454DADDE3D9B791))
    _id_AB308D685D86FC64 = _id_0454DADDE3D9B791.id;
  else
    _id_AB308D685D86FC64 = undefined;

  _id_CD514BF5922B5A83 = _func_4AF71893064929F8(_id_AA6726F343A56725, _id_2AFC91629DE00A1A, guy.script_stealthgroup, _id_AB308D685D86FC64);

  if(isDefined(_id_CD514BF5922B5A83)) {
    group_removefrompod(guy);
    addtopod(_id_CD514BF5922B5A83, guy);
    return _id_CD514BF5922B5A83;
  }
}

group_assigntoinvestigatepod(guy, _id_2AFC91629DE00A1A) {
  _id_CD514BF5922B5A83 = group_trytojoinexistingpod(undefined, 1, guy, _id_2AFC91629DE00A1A);

  if(isDefined(_id_CD514BF5922B5A83)) {
    if(!isDefined(_id_CD514BF5922B5A83.investigateoriginguy))
      _id_CD514BF5922B5A83 pod_updateinvestigateorigin(guy, _id_2AFC91629DE00A1A);

    return 0;
  }

  group_removefrompod(guy);
  _id_6C53C959D5828324 = makenewpod(guy.script_stealthgroup, 1, _id_2AFC91629DE00A1A);
  addtopod(_id_6C53C959D5828324, guy);
  _id_6C53C959D5828324.investigateoriginguy = guy;
  vol = level.stealth.investigate_volumes[self.script_stealthgroup];

  if(isDefined(vol)) {
    _id_6C53C959D5828324.volume = vol;
    _id_6C53C959D5828324.borigininvolume = ispointinvolume(_id_2AFC91629DE00A1A, vol);
  }

  if(!isDefined(self.script_stealthgroup))
    _id_6C53C959D5828324._id_EDCA2D230A0013AA = _func_25040278E58D8DA3("investigate", self.origin);

  level thread _id_92F7DF07DF367143(guy);
  return 1;
}

group_removefrompod(guy) {
  _id_B205CC0302DA1270 = _func_BC5DF124338CEFEA(guy);

  if(!isDefined(_id_B205CC0302DA1270)) {
    return;
  }
  _func_6DAA1CA6FED22CF3(_id_B205CC0302DA1270.id, guy);

  if(isDefined(_id_B205CC0302DA1270._id_8C189FFA521C9391) && isDefined(guy) && isDefined(_id_B205CC0302DA1270._id_8C189FFA521C9391[guy getentitynumber()])) {
    guy notify("pod_job_abort");
    _id_B205CC0302DA1270._id_8C189FFA521C9391[guy getentitynumber()] = undefined;
  }

  if(_id_B205CC0302DA1270.members.size == 0)
    _id_B205CC0302DA1270 pod_delete();
}

group_findsomeotherguytoinvestigate(pos, _id_032A96BF508FBD2F) {
  _id_7E6C997A4D1908FC = 2304;
  _id_CC2828DA32453F24 = undefined;
  _id_84D4866087B00608 = 2359296;
  _id_ADFA0C3861A668C6 = [];

  foreach(group in level.stealth.groupdata.groups) {
    if(group.name == _id_032A96BF508FBD2F) {
      continue;
    }
    volume = level.stealth.investigate_volumes[group.name];

    if(isDefined(volume) && !ispointinvolume(pos, volume)) {
      continue;
    }
    foreach(_id_B205CC0302DA1270 in group.pods) {
      if(_id_B205CC0302DA1270.state == 1 && distance2dsquared(_id_B205CC0302DA1270.origin, pos) < _id_7E6C997A4D1908FC)
        return undefined;
    }

    foreach(guy in group.members) {
      if([[self.fnisinstealthidle]]()) {
        distsq = distancesquared(guy.origin, pos);

        if(distsq < _id_84D4866087B00608) {
          _id_ADFA0C3861A668C6[_id_ADFA0C3861A668C6.size] = guy;

          if(_id_ADFA0C3861A668C6.size > 8) {
            break;
          }
        }
      }
    }
  }

  if(_id_ADFA0C3861A668C6.size > 0)
    _id_CC2828DA32453F24 = findclosestpointbyapproxpathdist(_id_ADFA0C3861A668C6, pos);

  return _id_CC2828DA32453F24;
}

group_checkrequestbackupoutsideofvolume(e) {
  volume = level.stealth.investigate_volumes[self.script_stealthgroup];

  if(isDefined(volume)) {
    if(!ispointinvolume(e.investigate_pos, volume)) {
      _id_CC2828DA32453F24 = group_findsomeotherguytoinvestigate(e.investigate_pos, self.script_stealthgroup);

      if(isDefined(_id_CC2828DA32453F24)) {
        _id_CC2828DA32453F24 aieventlistenerevent("seek_backup", self, e.investigate_pos);
        return 1;
      }
    }
  }

  return 0;
}

group_eventinvestigate(guy, e) {
  _id_D24E406E7DEEFABC = group_assigntoinvestigatepod(guy, e.investigate_pos);

  if(_id_D24E406E7DEEFABC)
    guy thread group_investigate_seekbackup(e);
}

group_investigate_seekbackup(e) {
  self endon("death");
  self endon("start_context_melee");
  self endon("scripted_melee_start");
  waitframe();
  group_checkrequestbackupoutsideofvolume(e);

  if(!isDefined(self.script_stealthgroup)) {
    return;
  }
  waitframe();
  group = getgroup(self.script_stealthgroup);
  _id_B205CC0302DA1270 = group_findpod(group, self);

  if(!isDefined(_id_B205CC0302DA1270)) {
    return;
  }
  if(_id_B205CC0302DA1270.members.size == 1) {
    _id_7A7EAB776DAF7A0A = group.members.size;

    for(_id_206BD3DACA6681FA = 0; _id_206BD3DACA6681FA < _id_7A7EAB776DAF7A0A; _id_206BD3DACA6681FA++) {
      _id_CC2828DA32453F24 = group.members[_id_206BD3DACA6681FA];

      if(_id_CC2828DA32453F24._id_FE5EBEFA740C7106 == 0 && distancesquared(_id_CC2828DA32453F24.origin, self.origin) < 10000)
        _id_CC2828DA32453F24 glanceatentity(self);
    }
  }
}

group_findpod(groupdata, guy) {
  if(!isDefined(groupdata.pods)) {
    return;
  }
  _id_223C150C67B7BC3F = groupdata.pods.size;

  for(_id_B58B3BB6EEAE68D3 = 0; _id_B58B3BB6EEAE68D3 < _id_223C150C67B7BC3F; _id_B58B3BB6EEAE68D3++) {
    _id_B205CC0302DA1270 = groupdata.pods[_id_B58B3BB6EEAE68D3];
    _id_7A7EAB776DAF7A0A = _id_B205CC0302DA1270.members.size;

    for(_id_206BD3DACA6681FA = 0; _id_206BD3DACA6681FA < _id_7A7EAB776DAF7A0A; _id_206BD3DACA6681FA++) {
      if(_id_B205CC0302DA1270.members[_id_206BD3DACA6681FA] == guy)
        return _id_B205CC0302DA1270;
    }
  }
}

group_eventcoverblown(groupname, guy, e) {
  if(isDefined(groupname))
    groupdata = getgroup(groupname);
  else
    groupdata = undefined;

  groupdata thread group_delayedcoverblownpropagation(guy);
  _id_D24E406E7DEEFABC = group_assigntoinvestigatepod(guy, e.investigate_pos);

  if(_id_D24E406E7DEEFABC)
    thread group_coverblown_seekbackup(groupdata, e);
}

group_delayedcoverblownpropagation(guy) {
  wait 2;

  if(isDefined(guy) && isalive(guy))
    self.bcoverhasbeenblown = 1;
}

group_coverblown_seekbackup(groupdata, e) {
  self endon("death");
  self endon("start_context_melee");
  self endon("scripted_melee_start");
  waitframe();
  _id_B205CC0302DA1270 = _func_BC5DF124338CEFEA(self);

  if(!isDefined(_id_B205CC0302DA1270)) {
    return;
  }
  if(isDefined(groupdata) && _id_B205CC0302DA1270.members.size == 1) {
    _id_7A7EAB776DAF7A0A = groupdata.members.size;

    for(_id_206BD3DACA6681FA = 0; _id_206BD3DACA6681FA < _id_7A7EAB776DAF7A0A; _id_206BD3DACA6681FA++) {
      _id_CC2828DA32453F24 = groupdata.members[_id_206BD3DACA6681FA];

      if(_id_CC2828DA32453F24 != self && _id_CC2828DA32453F24._id_FE5EBEFA740C7106 == 0 && distancesquared(_id_CC2828DA32453F24.origin, self.origin) < 10000)
        _id_CC2828DA32453F24 glanceatentity(self);
    }
  }

  if(group_checkrequestbackupoutsideofvolume(e)) {
    return;
  }
  if(isDefined(groupdata) && groupdata.members.size > 1) {
    _id_B205CC0302DA1270 = _func_BC5DF124338CEFEA(self);

    if(isDefined(_id_B205CC0302DA1270) && _id_B205CC0302DA1270.state == 1 && _id_B205CC0302DA1270.members.size == 1 && (!isDefined(_id_B205CC0302DA1270.volume) || _id_B205CC0302DA1270.borigininvolume))
      thread scripts\stealth\utility::addeventplaybcs("stealth", "announce2", "seek_backup", 2.0, undefined, 1);
  }
}

pod_updateinvestigateorigin(guy, pos) {
  self.origin = pos;
  self.investigateoriginguy = guy;
  self.needsupdate = scripts\engine\utility::array_add(self.needsupdate, guy);
}

group_updatepodhuntorigin(guy, _id_F31054CB5CAB2166) {}

pod_hunt_update(squadid) {
  _id_B205CC0302DA1270 = spawnStruct();
  _id_B205CC0302DA1270.squadid = squadid;
  _id_B205CC0302DA1270 thread _id_9919694707B210DF();
}

_id_561073DB8E56E510(guy) {
  _id_F68D091E4829568A = 48;
  _id_FDC0268BD71773D8 = 5000;

  if(!isDefined(guy) || !isalive(guy))
    return 0;

  if(isDefined(self._id_8C189FFA521C9391[guy getentitynumber()]))
    return 0;

  if(isDefined(guy.pathgoalpos) && guy pathdisttogoal(1) < _id_F68D091E4829568A)
    return 0;

  if(guy scripts\asm\asm_bb::bb_playsmartobjectrequested())
    return 0;

  if(isDefined(guy.stealth._id_003FCBEC5AF762E2) && gettime() - guy.stealth._id_003FCBEC5AF762E2 < _id_FDC0268BD71773D8)
    return 0;

  return 1;
}

_id_9919694707B210DF() {
  _id_03C1365BACF30636 = 262144;

  if(!isDefined(self._id_8C189FFA521C9391))
    self._id_8C189FFA521C9391 = [];

  _id_36D5AC8294F54F45 = 0;

  for(;;) {
    if(!isDefined(self.squadid)) {
      return;
    }
    members = _func_B9E807F454D30FE4(self.squadid);

    if(!isDefined(members) || members.size == 0) {
      return;
    }
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < members.size; _id_AC0E594AC96AA3A8++) {
      guy = members[_id_AC0E594AC96AA3A8];

      if(scripts\engine\utility::is_dead_or_dying(guy) || !_id_561073DB8E56E510(guy)) {
        continue;
      }
      entnum = guy getentitynumber();
      _id_30FC4F3E175E52CB = guy.lookaheaddir;

      for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 + 1; _id_AC0E5C4AC96AAA41 < members.size; _id_AC0E5C4AC96AAA41++) {
        _id_CC2828DA32453F24 = members[_id_AC0E5C4AC96AAA41];

        if(!isDefined(_id_CC2828DA32453F24) || !isalive(_id_CC2828DA32453F24)) {
          continue;
        }
        if(scripts\engine\utility::is_dead_or_dying(_id_CC2828DA32453F24)) {
          continue;
        }
        _id_643CF7B28C35D12E = _id_CC2828DA32453F24 getentitynumber();

        if(distancesquared(guy.origin, _id_CC2828DA32453F24.origin) < _id_03C1365BACF30636) {
          if(!_id_561073DB8E56E510(_id_CC2828DA32453F24)) {
            continue;
          }
          _id_483427E5F1C2060B = _id_CC2828DA32453F24.lookaheaddir;
          _id_21704FFA3438468F = vectorNormalize(_id_CC2828DA32453F24.origin - guy.origin);

          if(vectordot(_id_30FC4F3E175E52CB, _id_21704FFA3438468F) < 0 && vectordot(_id_30FC4F3E175E52CB, _id_483427E5F1C2060B) < 0) {
            continue;
          }
          _id_DBD6700FA110570E = guy.origin;
          _id_397B216DF790894E = _id_CC2828DA32453F24.origin;
          midpoint = (_id_DBD6700FA110570E + _id_397B216DF790894E) / 2;
          _id_CFFC7C7F4795B067 = vectorNormalize(midpoint - guy.origin);
          _id_2B410386A2207DA7 = vectorNormalize(midpoint - _id_CC2828DA32453F24.origin);

          if(vectordot(_id_CFFC7C7F4795B067, _id_30FC4F3E175E52CB) < 0.5) {
            continue;
          }
          if(vectordot(_id_2B410386A2207DA7, _id_483427E5F1C2060B) < 0.5) {
            continue;
          }
          if(guy hastacvis(_id_CC2828DA32453F24) || _id_CC2828DA32453F24 hastacvis(guy)) {
            midpoint = guy getclosestreachablepointonnavmesh(midpoint);
            _id_DBD6700FA110570E = guy getclosestreachablepointonnavmesh(midpoint + 30 * vectorNormalize(_id_DBD6700FA110570E - midpoint));
            _id_397B216DF790894E = _id_CC2828DA32453F24 getclosestreachablepointonnavmesh(midpoint + 30 * vectorNormalize(_id_397B216DF790894E - midpoint));
            _id_2924E404150FF758 = spawnStruct();
            _id_2924E404150FF758.guys = [];
            _id_2924E404150FF758.guys[_id_2924E404150FF758.guys.size] = guy;
            _id_2924E404150FF758.guys[_id_2924E404150FF758.guys.size] = _id_CC2828DA32453F24;
            _id_2924E404150FF758._id_10098495A8E7E9E7 = [];
            _id_2924E404150FF758._id_10098495A8E7E9E7[entnum] = _id_DBD6700FA110570E;
            _id_2924E404150FF758._id_10098495A8E7E9E7[_id_643CF7B28C35D12E] = _id_397B216DF790894E;
            _id_2924E404150FF758.state[entnum] = "init";
            _id_2924E404150FF758.state[_id_643CF7B28C35D12E] = "init";
            _id_2924E404150FF758.leader = guy;
            _id_2924E404150FF758.requesttime = gettime();
            _id_2924E404150FF758.id = _id_36D5AC8294F54F45;
            self._id_8C189FFA521C9391[_id_643CF7B28C35D12E] = _id_2924E404150FF758;
            self._id_8C189FFA521C9391[entnum] = _id_2924E404150FF758;
            childthread _id_67386B112E199533(_id_2924E404150FF758);
            _id_36D5AC8294F54F45++;
            wait 5;
            break;
          }
        }
      }
    }

    wait 1;
  }
}

_id_87601E94F761AF22(_id_2924E404150FF758) {
  self endon("pod_job_complete");
  self waittill("pod_job_abort");
  _id_2924E404150FF758.state[self getentitynumber()] = "done";
}

_id_67386B112E199533(_id_2924E404150FF758) {
  status = "wait_for_arrival";
  _id_BD628A3CC63EB86D = _id_2924E404150FF758.guys[0] getentitynumber();
  _id_BD62873CC63EB1D4 = _id_2924E404150FF758.guys[1] getentitynumber();
  leader = _id_2924E404150FF758.leader;

  if(_id_2924E404150FF758.leader == _id_2924E404150FF758.guys[0])
    _id_F5CCB6C745FF8F0B = _id_2924E404150FF758.guys[1];
  else
    _id_F5CCB6C745FF8F0B = _id_2924E404150FF758.guys[0];

  leader endon("death");
  _id_F5CCB6C745FF8F0B endon("death");
  leader.gunposeoverride_internal = "gun_down";
  _id_F5CCB6C745FF8F0B.gunposeoverride_internal = "gun_down";
  leader _meth_1C339DAABA3F71DB(1);
  _id_F5CCB6C745FF8F0B _meth_1C339DAABA3F71DB(1);
  leader childthread _id_87601E94F761AF22(_id_2924E404150FF758);
  _id_F5CCB6C745FF8F0B childthread _id_87601E94F761AF22(_id_2924E404150FF758);
  leader endon("pod_job_abort");
  _id_F5CCB6C745FF8F0B endon("pod_job_abort");
  _id_C1A82BA971C52F69 = "";
  _id_C1A828A971C528D0 = "";
  leader scripts\engine\utility::delaycall(randomfloatrange(0.2, 1.0), ::setlookatentity, _id_F5CCB6C745FF8F0B, 0);
  _id_F5CCB6C745FF8F0B scripts\engine\utility::delaycall(randomfloatrange(0.2, 1.0), ::setlookatentity, leader, 0);

  for(;;) {
    if(!isDefined(_id_2924E404150FF758.guys[0]) || !isalive(_id_2924E404150FF758.guys[0])) {
      break;
    }

    if(!isDefined(_id_2924E404150FF758.guys[1]) || !isalive(_id_2924E404150FF758.guys[1])) {
      break;
    }

    guy1 = _id_2924E404150FF758.guys[0];
    guy2 = _id_2924E404150FF758.guys[1];

    if(status == "wait_for_arrival") {
      if(_id_C1A82BA971C52F69 != "arrived" && !isDefined(guy1.pathgoalpos)) {
        _id_C1A82BA971C52F69 = "arrived";
        _id_2924E404150FF758.state[_id_BD628A3CC63EB86D] = "wait";
      }

      if(_id_C1A828A971C528D0 != "arrived" && !isDefined(guy2.pathgoalpos)) {
        _id_C1A828A971C528D0 = "arrived";
        _id_2924E404150FF758.state[_id_BD62873CC63EB1D4] = "wait";
      }

      if(_id_C1A82BA971C52F69 == "arrived" && _id_C1A828A971C528D0 == "arrived")
        status = "gesture";
    }

    if(status == "gesture") {
      _id_2924E404150FF758.state[leader getentitynumber()] = "gesture";
      leader _id_C5BFEF99B23E74BE("hunt_gesture");

      if(!isDefined(leader) || !isalive(leader)) {
        break;
      }

      _id_2924E404150FF758.state[leader getentitynumber()] = "wait";
      _id_2924E404150FF758.state[_id_F5CCB6C745FF8F0B getentitynumber()] = "gesture";
      _id_F5CCB6C745FF8F0B _id_C5BFEF99B23E74BE("hunt_gesture");

      if(!isDefined(_id_F5CCB6C745FF8F0B) || !isalive(_id_F5CCB6C745FF8F0B)) {
        break;
      }

      _id_2924E404150FF758.state[_id_F5CCB6C745FF8F0B getentitynumber()] = "wait";
      status = "complete";
    }

    if(status == "complete") {
      _id_2924E404150FF758.state[_id_BD628A3CC63EB86D] = "done";
      _id_2924E404150FF758.state[_id_BD62873CC63EB1D4] = "done";
      break;
    }

    waitframe();
  }

  leader notify("pod_job_complete");
  _id_F5CCB6C745FF8F0B notify("pod_job_complete");
}

_id_C5BFEF99B23E74BE(flag) {
  self endon("death");
  self endon("smartobject_logic_finished");
  self endon("hunt_gesture_timeout");
  childthread _id_1E36BD48FC41811E(10);

  for(;;) {
    self waittill(flag, status);

    if(status == "gesture_finish" || status == "gesture_cancel") {
      break;
    }
  }
}

_id_1E36BD48FC41811E(t) {
  wait(t);
  self notify("hunt_gesture_timeout");
}

_id_75087B386454D072(guy) {
  if(!isDefined(self._id_8C189FFA521C9391)) {
    return;
  }
  return self._id_8C189FFA521C9391[guy getentitynumber()];
}

_id_B121DDE73E7DA661(guy) {
  if(!isDefined(self._id_8C189FFA521C9391)) {
    return;
  }
  self._id_8C189FFA521C9391[guy getentitynumber()] = undefined;
}

_id_92F7DF07DF367143(guy) {
  level notify("stop investigate start vo");
  level endon("stop investigate start vo");
  groupdata = getgroup(guy.script_stealthgroup);
  groupdata._id_A67F19DDE4BB4421 = 1;
  wait 0.1;

  if(groupdata.pods.size == 0) {
    return;
  }
  _id_804640963E89351F = [];
  _id_B2F98CC1C4EC5171 = [];
  _id_9DAD3F5A14A525A3 = [];
  _id_43545EFD7DF4555E = groupdata.pods[0];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < groupdata.pods.size; _id_AC0E594AC96AA3A8++) {
    if(_id_43545EFD7DF4555E.members.size < groupdata.pods[_id_AC0E594AC96AA3A8].members.size)
      _id_43545EFD7DF4555E = groupdata.pods[_id_AC0E594AC96AA3A8];
  }

  if(scripts\common\utility::issp())
    _id_7D2852D02216C876 = scripts\engine\utility::getclosest(level.player.origin, _id_43545EFD7DF4555E.members);
  else
    _id_7D2852D02216C876 = scripts\engine\utility::random(_id_43545EFD7DF4555E.members);

  if(!isDefined(_id_7D2852D02216C876) || !isDefined(_id_7D2852D02216C876.battlechatter)) {
    return;
  }
  _id_B2F98CC1C4EC5171 = _id_43545EFD7DF4555E.members;

  foreach(_id_B205CC0302DA1270 in groupdata.pods) {
    if(_id_B205CC0302DA1270 != _id_43545EFD7DF4555E)
      _id_9DAD3F5A14A525A3 = scripts\engine\utility::array_combine(_id_9DAD3F5A14A525A3, _id_B205CC0302DA1270.members);
  }

  _id_804640963E89351F = scripts\engine\utility::array_remove_array(groupdata.members, scripts\engine\utility::array_combine(_id_B2F98CC1C4EC5171, _id_9DAD3F5A14A525A3));
  _id_804640963E89351F = scripts\engine\utility::array_remove(_id_804640963E89351F, _id_7D2852D02216C876);

  if(_id_9DAD3F5A14A525A3.size == 0 && _id_B2F98CC1C4EC5171.size == 0 && _id_804640963E89351F.size == 0)
    groupdata._id_A67F19DDE4BB4421 = 0;
  else {
    if(!isDefined(_id_7D2852D02216C876) || !isDefined(_id_7D2852D02216C876.battlechatter)) {
      return;
    }
    _id_7D2852D02216C876.battlechatter._id_C9011E302F0673BC = spawnStruct();
    _id_7D2852D02216C876.battlechatter._id_C9011E302F0673BC._id_804640963E89351F = _id_804640963E89351F;
    _id_7D2852D02216C876.battlechatter._id_C9011E302F0673BC._id_B2F98CC1C4EC5171 = _id_B2F98CC1C4EC5171;
    _id_7D2852D02216C876.battlechatter._id_C9011E302F0673BC._id_9DAD3F5A14A525A3 = _id_9DAD3F5A14A525A3;
    _id_7D2852D02216C876 thread scripts\stealth\utility::addeventplaybcs("stealth", "state_change", "investigate");

    if(_id_9DAD3F5A14A525A3.size > 0) {
      if(_id_B2F98CC1C4EC5171.size > 0) {
        if(_id_804640963E89351F.size > 0)
          _id_7D2852D02216C876 thread scripts\stealth\utility::addeventplaybcs("stealth", "investigate", "start_spreadoutwithmestay", undefined, undefined, 1);
        else
          _id_7D2852D02216C876 thread scripts\stealth\utility::addeventplaybcs("stealth", "investigate", "start_spreadoutwithme", undefined, undefined, 1);
      } else if(_id_804640963E89351F.size > 0)
        _id_7D2852D02216C876 thread scripts\stealth\utility::addeventplaybcs("stealth", "investigate", "start_singlespreadoutstay", undefined, undefined, 1);
      else
        _id_7D2852D02216C876 thread scripts\stealth\utility::addeventplaybcs("stealth", "investigate", "start_singlespreadout", undefined, undefined, 1);
    } else {
      if(_id_B2F98CC1C4EC5171.size > 0) {
        return;
      }
      if(_id_804640963E89351F.size > 0)
        return;
    }
  }
}

_id_500FE4721ADCCAB3(array) {
  _id_38D1DE6D4017E745 = [];

  foreach(guy in array) {
    if(isDefined(guy.bccallsign))
      _id_38D1DE6D4017E745 = scripts\engine\utility::array_add(_id_38D1DE6D4017E745, guy.bccallsign);
  }

  return _id_38D1DE6D4017E745;
}

pod_hunt_vo() {
  if(isDefined(level.bcs_stealthhuntthink)) {
    return;
  }
  level.bcs_stealthhuntthink = 1;
  level._id_CC7FB07B623A0EF5 = scripts\engine\utility::_id_53C4C53197386572(level._id_CC7FB07B623A0EF5, [6, 12]);
  first_lost = undefined;

  for(;;) {
    _id_7FAC5B3FFF459084 = [];

    foreach(group in level.stealth.groupdata.groups) {
      if(!isDefined(group.pods)) {
        continue;
      }
      foreach(_id_B205CC0302DA1270 in group.pods) {
        if(!isDefined(_id_B205CC0302DA1270.state) || _id_B205CC0302DA1270.state != 2) {
          continue;
        }
        foreach(_id_A9FF06560DA3D11F in _id_B205CC0302DA1270.members)
        _id_7FAC5B3FFF459084 = scripts\engine\utility::array_add(_id_7FAC5B3FFF459084, _id_A9FF06560DA3D11F);
      }
    }

    if(_id_7FAC5B3FFF459084.size < 1) {
      break;
    }

    if(_id_7FAC5B3FFF459084.size > 1) {
      if(scripts\common\utility::issp())
        _id_7FAC5B3FFF459084 = sortbydistance(_id_7FAC5B3FFF459084, level.player.origin);
      else
        _id_7FAC5B3FFF459084 = scripts\engine\utility::array_randomize(_id_7FAC5B3FFF459084);

      _id_7FAC5B3FFF459084[0].battlechatter._id_220CB768ABCAD30B = _id_7FAC5B3FFF459084;
      leader = _id_7FAC5B3FFF459084[0];
      _id_7FAC5B3FFF459084 = scripts\engine\utility::array_remove(_id_7FAC5B3FFF459084, leader);
      wait(randomfloatrange(2, 2.5));
      _id_7FAC5B3FFF459084 = scripts\engine\utility::array_removedead_or_dying(_id_7FAC5B3FFF459084);

      if(scripts\common\utility::issp())
        _id_7FAC5B3FFF459084 = sortbydistance(_id_7FAC5B3FFF459084, level.player.origin);
      else
        _id_7FAC5B3FFF459084 = scripts\engine\utility::array_randomize(_id_7FAC5B3FFF459084);

      _id_A9FF06560DA3D11F = undefined;

      switch (_id_7FAC5B3FFF459084.size) {
        case 0:
          break;
        case 3:
        case 2:
        case 1:
          _id_A9FF06560DA3D11F = _id_7FAC5B3FFF459084[randomint(_id_7FAC5B3FFF459084.size)];
          break;
        default:
          _id_A9FF06560DA3D11F = _id_7FAC5B3FFF459084[randomint(3)];
          break;
      }

      if(!isDefined(_id_A9FF06560DA3D11F)) {
        break;
      }

      _id_7FAC5B3FFF459084 = scripts\engine\utility::array_add(_id_7FAC5B3FFF459084, leader);
      _id_A9FF06560DA3D11F.battlechatter._id_220CB768ABCAD30B = _id_7FAC5B3FFF459084;
    } else {
      _id_A9FF06560DA3D11F = _id_7FAC5B3FFF459084[0];

      if(!isDefined(first_lost)) {} else {}
    }

    if(isarray(level._id_CC7FB07B623A0EF5)) {
      wait(randomfloatrange(level._id_CC7FB07B623A0EF5[0], level._id_CC7FB07B623A0EF5[1]));
      continue;
    }

    wait(level._id_CC7FB07B623A0EF5);
  }

  level.bcs_stealthhuntthink = undefined;
}

group_anyoneincombat(groupname) {
  groupdata = getgroup(groupname);

  foreach(_id_B205CC0302DA1270 in groupdata.pods) {
    if(_id_B205CC0302DA1270.state == 3)
      return 1;
  }

  return 0;
}

_id_624F57A99242F017(groupname) {
  groupdata = getgroup(groupname);

  foreach(_id_B205CC0302DA1270 in groupdata.pods) {
    if(_id_B205CC0302DA1270.state == 1)
      return 1;
  }

  return 0;
}

groups_combat_checklosttarget() {}

pod_combat_update_checklosttarget() {
  self endon("state_change");
  wait(level.stealth._id_E012FD4F27172998);

  if(istrue(self._id_DFF7984130ECE673)) {
    while(self._id_DFF7984130ECE673)
      wait 0.5;

    wait(randomfloatrange(0.5, 1.0));
  }

  if(!pod_haslostenemy() && isDefined(level.stealth.funcs) && isDefined(level.stealth.funcs["call_backup"]))
    self thread[[level.stealth.funcs["call_backup"]]]();

  if(isDefined(level.stealth.bstayincombatoncealerted)) {
    return;
  }
  self.bchecklosttarget = 1;
}

pod_haslostenemy() {
  ctimetolose = 10000;
  _id_7C08DD16FFA22BA8 = 15000;
  cstillrighttheredistsq = 50625;

  if(isDefined(level.stealth._id_792E4B9A380ADE11))
    ctimetolose = level.stealth._id_792E4B9A380ADE11;

  if(isDefined(level.stealth._id_094F8771062F2161))
    _id_7C08DD16FFA22BA8 = level.stealth._id_094F8771062F2161;

  if(isDefined(level.stealth._id_E2E3C78D7DC88605))
    cstillrighttheredistsq = level.stealth._id_E2E3C78D7DC88605;

  _id_6B7BEE46F2C6DA28 = gettime();
  _id_397AFC8BC8EC2D48 = undefined;

  foreach(guy in self.members) {
    if(isDefined(guy.stealth.funcs) && isDefined(guy.stealth.funcs["has_lost_enemy"])) {
      if(!guy[[guy.stealth.funcs["has_lost_enemy"]]]())
        return 0;
    } else {
      enemy = guy.enemy;

      if(isDefined(enemy) && issentient(enemy) && isalive(enemy)) {
        if(scripts\common\utility::issp() && enemy.team != "allies")
          return 0;

        _id_B4C04337A6A90C84 = guy lastknowntime(enemy);

        if(_id_6B7BEE46F2C6DA28 < _id_B4C04337A6A90C84 + ctimetolose)
          return 0;

        _id_FB806200A8E9A011 = guy lastknownpos(enemy);

        if(_id_B4C04337A6A90C84 > 0 && distancesquared(enemy.origin, _id_FB806200A8E9A011) < cstillrighttheredistsq)
          return 0;

        if(_id_6B7BEE46F2C6DA28 < _id_B4C04337A6A90C84 + _id_7C08DD16FFA22BA8 && enemy hastacvis(_id_FB806200A8E9A011))
          return 0;

        if(istrue(guy.benemyinlowcover))
          return 0;

        continue;
      }

      if(!isDefined(guy.enemy) && guy scripts\engine\utility::ent_flag_exist("in_the_dark") && guy scripts\engine\utility::ent_flag("in_the_dark") && _id_6B7BEE46F2C6DA28 - guy.lastenemysighttime < ctimetolose)
        return 0;
    }
  }

  return 1;
}

pod_settohunt(_id_D384E7929FBDB26C) {
  _id_AF71CF8E790A407F = self.members;

  foreach(guy in _id_AF71CF8E790A407F) {
    _id_332044E98950634F = 1;

    if(isDefined(guy.stealth.funcs) && isDefined(guy.stealth.funcs["should_hunt"]))
      _id_332044E98950634F = guy[[guy.stealth.funcs["should_hunt"]]]();

    if(!_id_332044E98950634F) {
      guy scripts\stealth\enemy::bt_set_stealth_state("idle", undefined);
      continue;
    }

    if(isDefined(_id_D384E7929FBDB26C)) {
      guy._id_4B1FA39975A3FD58 = randomint(_id_D384E7929FBDB26C);
      guy thread _id_B32F74BB1F7E968E(_id_D384E7929FBDB26C / 1000);

      if(scripts\engine\utility::cointoss())
        guy._id_587D8840DEA10869 = 1;
    }

    guy scripts\stealth\enemy::bt_set_stealth_state("hunt", undefined);
  }
}

_id_B32F74BB1F7E968E(_id_74B5B12BB6514385) {
  self endon("death");
  wait(_id_74B5B12BB6514385);
  self._id_4B1FA39975A3FD58 = undefined;
  self._id_587D8840DEA10869 = undefined;
}

pod_settoidle() {
  foreach(guy in self.members)
  guy aieventlistenerevent("reset", guy, guy.origin);
}

pod_isleader(guy) {
  _id_B205CC0302DA1270 = _func_BC5DF124338CEFEA(guy);

  if(!isDefined(_id_B205CC0302DA1270))
    return 0;

  return _id_B205CC0302DA1270.members[0] == guy;
}

pod_delete() {
  self notify("state_change");
  _func_90814EE949699BAA(self.id);
}