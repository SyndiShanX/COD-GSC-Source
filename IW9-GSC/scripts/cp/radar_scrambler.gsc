/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\radar_scrambler.gsc
***********************************************/

_id_5E22F6EB6E70E147(ent, ref) {
  ent._id_61E67DD981E04FA7 = ref;
}

_id_685226F608467EBC(ent) {
  ent._id_61E67DD981E04FA7 = undefined;
}

_id_1CBB16C6BA553DF4(ref, callback) {
  struct = _id_BA2C0913938C899C();
  struct.entercallbacks[ref] = callback;
}

_id_6FC424055F4E95E8(ref, callback) {
  struct = _id_BA2C0913938C899C();
  struct.exitcallbacks[ref] = callback;
}

_id_F4F717F11D752BD6(ref, callback) {
  struct = _id_BA2C0913938C899C();
  struct.outoftimecallbacks[ref] = callback;
}

_id_B312D240CF7DE0AB(ref, callback) {
  struct = _id_BA2C0913938C899C();
  struct.clearcallbacks[ref] = callback;
}

_id_115A3EAEE4810F76(ent, _id_3E36F415F762070E) {
  if(_id_9A757451BA80F667(ent))
    return 0;

  if(istrue(_id_3E36F415F762070E) && _id_9A757451BA80F667(ent))
    return 0;

  return isDefined(ent._id_5384D4A6C5CD21C6) && ent._id_5384D4A6C5CD21C6 > 0;
}

_id_D064E7371BA358C1(ent) {
  if(!isDefined(ent._id_5384D4A6C5CD21C6))
    ent._id_5384D4A6C5CD21C6 = 0;

  ent._id_5384D4A6C5CD21C6++;

  if(ent._id_5384D4A6C5CD21C6 == 1) {
    if(!isDefined(ent._id_1AC0AED2528825D4) || ent._id_1AC0AED2528825D4 <= 0)
      _id_B96AA092DCA79D81(ent);
  }
}

_id_8F7BA87B5415AC10(ent, _id_D5C909837FD4DEB4) {
  if(!isDefined(ent._id_5384D4A6C5CD21C6)) {
    if(isDefined(ent)) {
      ent hudoutlineenable("outline_cp_teleport_debug");
      iprintlnbold("ent vars:script_suspend_group: ^1" + ent.script_suspend_group + "^5 script_suspend: ^1" + ent.script_suspend);
    }
  }

  if(!istrue(_id_D5C909837FD4DEB4)) {}

  ent._id_5384D4A6C5CD21C6--;

  if(ent._id_5384D4A6C5CD21C6 == 0) {
    ent._id_5384D4A6C5CD21C6 = undefined;

    if(!isDefined(ent._id_1AC0AED2528825D4) || ent._id_1AC0AED2528825D4 <= 0)
      _id_DDE838674BE7AB8F(ent, 0);
  }
}

_id_9A757451BA80F667(ent) {
  return isDefined(ent._id_1AC0AED2528825D4) && ent._id_1AC0AED2528825D4 > 0;
}

_id_718F576400D123AB(ent) {
  if(!isDefined(ent._id_1AC0AED2528825D4))
    ent._id_1AC0AED2528825D4 = 0;

  ent._id_1AC0AED2528825D4++;

  if(ent._id_1AC0AED2528825D4 == 1) {
    if(isDefined(ent._id_5384D4A6C5CD21C6) && ent._id_5384D4A6C5CD21C6 > 0)
      _id_DDE838674BE7AB8F(ent, 0);
  }
}

_id_904C55FE002F0632(ent) {
  ent._id_1AC0AED2528825D4--;

  if(ent._id_1AC0AED2528825D4 == 0) {
    ent._id_1AC0AED2528825D4 = undefined;

    if(isDefined(ent._id_5384D4A6C5CD21C6) && ent._id_5384D4A6C5CD21C6 > 0)
      _id_B96AA092DCA79D81(ent);
  }
}

_id_09701C5AF0AE46CD(ent, _id_FCEF8D217A441961) {
  ent notify("clear_radarScrambler");

  if(_id_115A3EAEE4810F76(ent, 1))
    _id_DDE838674BE7AB8F(ent, _id_FCEF8D217A441961, 1);

  _id_A92C68F274CD0239 = undefined;

  if(isPlayer(ent))
    _id_A92C68F274CD0239 = ::playerclearcallback;
  else if(isagent(ent))
    _id_A92C68F274CD0239 = ::playerclearcallback;
  else if(isDefined(ent._id_61E67DD981E04FA7)) {
    struct = _id_BA2C0913938C899C();
    _id_A92C68F274CD0239 = struct.clearcallbacks[ent._id_61E67DD981E04FA7];
  }

  if(isDefined(_id_A92C68F274CD0239))
    ent[[_id_A92C68F274CD0239]]();

  ent._id_61E67DD981E04FA7 = undefined;
  ent._id_5384D4A6C5CD21C6 = undefined;
  ent._id_1AC0AED2528825D4 = undefined;
  ent._id_C0DCA0D832B0FED6 = undefined;
  ent._id_CEBD9D0B4638AEDA = undefined;
  ent._id_007A3A633F3137EE = undefined;

  if(isDefined(ent._id_F676BE7150162CA7)) {
    foreach(trigger in ent._id_F676BE7150162CA7)
    trigger.entstouching[ent getentitynumber()] = undefined;

    ent._id_F676BE7150162CA7 = undefined;
  }

  if(isDefined(ent._id_540861E2AF03A290)) {
    foreach(trigger in ent._id_540861E2AF03A290)
    trigger.entstouching[ent getentitynumber()] = undefined;

    ent._id_540861E2AF03A290 = undefined;
  }
}

_id_9ECB03C3E2B1A959() {
  if(istrue(self.allowedintrigger))
    return 0;

  if(!isDefined(level._id_F676BE7150162CA7))
    return 0;

  foreach(trigger in level._id_F676BE7150162CA7) {
    if(!_id_07B13EE86BDAAEBA(trigger, self)) {
      continue;
    }
    if(self istouching(trigger))
      return 1;
  }

  return 0;
}

_id_29955EF665E7793D(_id_863C619037F3AC74, _id_DA8CEC9BCE12F9CB) {
  _id_85AA6256B13776AD = 0;

  if(!isDefined(level._id_F676BE7150162CA7))
    return _id_85AA6256B13776AD;
  else {
    foreach(trigger in level._id_F676BE7150162CA7) {
      if(ispointinvolume(_id_863C619037F3AC74, trigger)) {
        if(isDefined(trigger.script_team) && isDefined(_id_DA8CEC9BCE12F9CB) && trigger.script_team != _id_DA8CEC9BCE12F9CB)
          continue;
        else {
          _id_85AA6256B13776AD = 1;
          break;
        }
      }
    }
  }

  return _id_85AA6256B13776AD;
}

_id_044A315340C86E09(point, circlecenter, circleradius) {
  x = point[0];
  y = point[1];

  if((x - circlecenter[0]) * (x - circlecenter[0]) + (y - circlecenter[1]) * (y - circlecenter[1]) <= circleradius * circleradius)
    return 1;
  else
    return 0;
}

_id_D86F905B2EFC08B9() {
  level.overwatch_emp_low = 0.8;
  level.overwatch_emp_high = 1.2;
  level.overwatch_emp_free = 5;

  if(!scripts\engine\utility::flag_exist("radar_scramblers_initialized"))
    scripts\engine\utility::flag_init("radar_scramblers_initialized");

  if(!scripts\engine\utility::flag_exist("ready_for_region_spawning"))
    scripts\engine\utility::flag_init("ready_for_region_spawning");

  if(!isDefined(level._id_F676BE7150162CA7))
    level._id_F676BE7150162CA7 = [];

  level._id_F676BE7150162CA7 = scripts\engine\utility::array_combine(level._id_F676BE7150162CA7, getEntArray("radar_scrambler", "targetname"));
  thread _id_60EC8AA27CC049E6();
}

_id_A8000C9CBF395DB1() {
  if(!scripts\engine\utility::flag_exist("level_ready_for_script"))
    scripts\engine\utility::flag_init("level_ready_for_script");

  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(isDefined(level._id_FC46CD90F0A40C87))
    [[level._id_FC46CD90F0A40C87]]();

  if(!isDefined(level._id_F676BE7150162CA7))
    level._id_F676BE7150162CA7 = [];

  level._id_F676BE7150162CA7 = scripts\engine\utility::array_combine(level._id_F676BE7150162CA7, getEntArray("radar_scrambler", "targetname"));
  thread _id_60EC8AA27CC049E6();
}

_id_B96AA092DCA79D81(ent) {
  _id_2D2D28B1528166D2 = undefined;
  trigger = _id_3D92E694EC2D0078(ent);
  triggertype = gettriggertype(ent, trigger);

  if(isPlayer(ent))
    _id_2D2D28B1528166D2 = ::playerentercallback;
  else if(isagent(ent))
    _id_2D2D28B1528166D2 = ::_id_B2A14335ECF202F8;
  else if(isDefined(ent._id_61E67DD981E04FA7)) {
    struct = _id_BA2C0913938C899C();
    _id_2D2D28B1528166D2 = struct.entercallbacks[ent._id_61E67DD981E04FA7];
  }

  ent notify("radarScrambler_cooldown_end");

  if(isDefined(ent._id_C0DCA0D832B0FED6) && previouslytouchedtriggertype(ent, triggertype)) {
    _id_24AB8327AF3F90DF = ent._id_C0DCA0D832B0FED6 / 1000;
    ent._id_CEBD9D0B4638AEDA = int(gettime() + ent._id_C0DCA0D832B0FED6);
    ent._id_C0DCA0D832B0FED6 = undefined;
    thread _id_C9DA074C99CDAD85(ent, _id_24AB8327AF3F90DF);
  } else {
    ent._id_C0DCA0D832B0FED6 = undefined;
    ent._id_007A3A633F3137EE = triggertype;
    _id_24AB8327AF3F90DF = _id_11982FA04C4ADE15(triggertype);
    ent._id_CEBD9D0B4638AEDA = int(gettime() + _id_24AB8327AF3F90DF * 1000);
    thread _id_C9DA074C99CDAD85(ent, _id_24AB8327AF3F90DF);
  }

  if(isDefined(_id_2D2D28B1528166D2))
    ent thread[[_id_2D2D28B1528166D2]]("exit_radarScrambler", "clear_radarScrambler", triggertype, trigger);
}

_id_DDE838674BE7AB8F(ent, _id_FCEF8D217A441961, _id_704294F906FAD67E) {
  ent notify("exit_radarScrambler");
  _id_6166EC335950C5F2 = undefined;

  if(isPlayer(ent))
    _id_6166EC335950C5F2 = ::playerexitcallback;
  else if(isagent(ent))
    _id_6166EC335950C5F2 = ::_id_0D405DEE230E91B4;
  else if(isDefined(ent._id_61E67DD981E04FA7)) {
    struct = _id_BA2C0913938C899C();
    _id_6166EC335950C5F2 = struct.exitcallbacks[ent._id_61E67DD981E04FA7];
  }

  ent notify("radarScrambler_timeout_end");

  if(!istrue(_id_704294F906FAD67E)) {
    if(isDefined(ent._id_CEBD9D0B4638AEDA)) {
      ent._id_C0DCA0D832B0FED6 = int(max(0, ent._id_CEBD9D0B4638AEDA - gettime()));
      ent._id_CEBD9D0B4638AEDA = undefined;
      trigger = _id_3D92E694EC2D0078(ent);
      triggertype = gettriggertype(ent, trigger);
      cooldowntime = getcooldowntime(triggertype);
      thread _id_E209A39163F0883A(ent, cooldowntime);
    }
  }

  if(isDefined(_id_6166EC335950C5F2))
    ent thread[[_id_6166EC335950C5F2]](_id_FCEF8D217A441961, _id_704294F906FAD67E, "clear_radarScrambler");
}

_id_42DAAB738A799575(ent) {
  _id_106B10573BDEADF0 = undefined;

  if(isPlayer(ent)) {
    _id_775C9A68F9C00019 = 1;

    if(_id_775C9A68F9C00019)
      _id_106B10573BDEADF0 = ::playeroutoftimecallback;
  } else if(isagent(ent)) {
    _id_775C9A68F9C00019 = 1;

    if(_id_775C9A68F9C00019)
      _id_106B10573BDEADF0 = ::playeroutoftimecallback;
  } else if(isDefined(ent._id_61E67DD981E04FA7)) {
    struct = _id_BA2C0913938C899C();
    _id_106B10573BDEADF0 = struct.outoftimecallbacks[ent._id_61E67DD981E04FA7];
  }

  if(isDefined(_id_106B10573BDEADF0))
    ent thread[[_id_106B10573BDEADF0]]("radarScrambler_timeout_end", "clear_radarScrambler");
}

_id_C9DA074C99CDAD85(ent, _id_8DD9F2EB8215A139) {
  if(isPlayer(ent) || isagent(ent))
    ent endon("death");

  ent notify("radarScrambler_timeout_end");
  ent endon("radarScrambler_timeout_end");
  ent endon("clear_radarScrambler");
  wait(_id_8DD9F2EB8215A139);
  thread _id_42DAAB738A799575(ent);
}

_id_E209A39163F0883A(ent, _id_8DD9F2EB8215A139) {
  if(isPlayer(ent) || isagent(ent))
    ent endon("death");

  ent notify("radarScrambler_cooldown_end");
  ent endon("radarScrambler_cooldown_end");
  ent endon("clear_radarScrambler");
  wait(_id_8DD9F2EB8215A139);
  ent._id_C0DCA0D832B0FED6 = undefined;
  ent._id_007A3A633F3137EE = undefined;
}

playerentercallback(_id_44E306D53285E1F8, _id_93F5DB7E81311353, triggertype, trigger) {
  _id_3A44172702973AB6 = 1;

  if(isDefined(triggertype) && triggertype == "restricted")
    _id_3A44172702973AB6 = 2;

  self._id_A67651C67E18C594 = trigger;
  emp_effects_flickering(self);
}

_id_B2A14335ECF202F8(_id_44E306D53285E1F8, _id_93F5DB7E81311353, triggertype, trigger) {
  _id_3A44172702973AB6 = 1;

  if(isDefined(triggertype) && triggertype == "restricted")
    _id_3A44172702973AB6 = 2;

  _id_86AFCFB8EB7BF0D2(trigger);
  self._id_A67651C67E18C594 = trigger;
}

playerexitcallback(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353) {
  self._id_A67651C67E18C594 = undefined;
  _id_11011E6292A21C15(self);
}

_id_0D405DEE230E91B4(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353) {
  self._id_A67651C67E18C594 = undefined;
  _id_D55ED59C0CE164D3();
}

playeroutoftimecallback(_id_2F57CFAE824CA728, _id_93F5DB7E81311353) {
  trigger = _id_3D92E694EC2D0078(self);
  triggertype = gettriggertype(self, trigger);
}

playerclearcallback(_id_93F5DB7E81311353) {}

playeroutoftimeminefield(_id_2F57CFAE824CA728, _id_93F5DB7E81311353) {
  _id_64AC6C50CE3A7C25 = self.origin;
  _id_CAB9F210984BED37 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 1000), self);

  if(isDefined(_id_CAB9F210984BED37["hittype"] != "hittype_none") && isDefined(_id_CAB9F210984BED37["position"]))
    _id_64AC6C50CE3A7C25 = _id_CAB9F210984BED37["position"];

  mine = spawn("script_model", _id_64AC6C50CE3A7C25);
  mine setModel("ks_minefield_mp");
  mine setentityowner(self);
  mine setotherent(self);
  mine setscriptablepartstate("warning_click", "on", 0);
  _id_3F67BB4D035FB5A1 = playeroutoftimeminefieldinternal(mine, _id_2F57CFAE824CA728, _id_93F5DB7E81311353);

  if(istrue(_id_3F67BB4D035FB5A1))
    wait 2;

  mine delete();
}

playeroutoftimeminefieldinternal(mine, _id_2F57CFAE824CA728, _id_93F5DB7E81311353) {
  self endon("death_or_disconnect");

  if(isDefined(_id_2F57CFAE824CA728))
    self endon(_id_2F57CFAE824CA728);

  if(isDefined(_id_93F5DB7E81311353))
    self endon(_id_93F5DB7E81311353);

  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  mine setscriptablepartstate("explosion", "on", 0);
  wait 0.05;
  self dodamage(2000, self.origin, self, mine, "MOD_EXPLOSIVE", "minefield_mp");
  return 1;
}

killstreakentercallback(_id_44E306D53285E1F8, _id_93F5DB7E81311353, triggertype, trigger) {
  _id_3A44172702973AB6 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.gametype == "arm" && isDefined(triggertype) && triggertype == "restricted")
    _id_3A44172702973AB6 = 2;

  if(isDefined(self.owner)) {
    if(isPlayer(self.owner))
      self.owner playerentercallback(_id_44E306D53285E1F8, _id_93F5DB7E81311353, triggertype, trigger);
    else if(isagent(self.owner))
      self.owner _id_B2A14335ECF202F8(_id_44E306D53285E1F8, _id_93F5DB7E81311353, triggertype, trigger);
  }
}

killstreakexitcallback(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353) {
  if(isDefined(self.owner)) {
    if(isPlayer(self.owner))
      self.owner playerexitcallback(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353);
    else if(isagent(self.owner))
      self.owner _id_0D405DEE230E91B4(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353);
  }
}

killstreakoutoftimecallback(_id_2F57CFAE824CA728, _id_93F5DB7E81311353) {}

killstreakclearcallback() {
  if(isDefined(self.owner)) {
    if(isPlayer(self.owner))
      self.owner playerclearcallback();
    else if(isagent(self.owner))
      self.owner playerclearcallback();
  }
}

_id_831C13BFEE564637() {
  _id_1CBB16C6BA553DF4("killstreak", ::killstreakentercallback);
  _id_6FC424055F4E95E8("killstreak", ::killstreakexitcallback);
  _id_F4F717F11D752BD6("killstreak", ::killstreakoutoftimecallback);
  _id_B312D240CF7DE0AB("killstreak", ::killstreakclearcallback);
}

_id_60EC8AA27CC049E6() {
  _id_20533273F43DD4E2 = [];

  if(isDefined(level._id_F676BE7150162CA7)) {
    scripts\engine\utility::flag_set("radar_scramblers_initialized");

    foreach(trigger in level._id_F676BE7150162CA7)
    thread _id_F229476781D024F1(trigger);

    if(isDefined(level._id_C03CDC5F3AD34EE0)) {
      foreach(trigger in level._id_C03CDC5F3AD34EE0)
      thread _id_E0A087327B3B40F6(trigger);
    }
  }
}

_id_F229476781D024F1(trigger) {
  trigger notify("watchradarScramblerTrigger");
  trigger endon("watchradarScramblerTrigger");
  trigger.entstouching = [];

  if(isDefined(trigger.target)) {
    trigger._id_3EFE1B3A9EF1ABA0 = getEnt(trigger.target, "targetname");
    trigger._id_3EFE1B3A9EF1ABA0._id_281086936687228A = trigger;
    trigger._id_3EFE1B3A9EF1ABA0 thread _id_E849523551C4F041();
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  thread _id_BB49E64A0F5DD911(trigger);
  thread _id_6FA3082C13812071(trigger);
}

_id_6FA3082C13812071(trigger) {
  level endon("game_ended");
  trigger notify("watchradarScramblerTriggerEnter");
  trigger endon("watchradarScramblerTriggerEnter");
  trigger endon("death");

  for(;;) {
    trigger waittill("trigger", ent);

    if(isPlayer(ent) && isDefined(ent.c130)) {
      continue;
    }
    if(!_id_07B13EE86BDAAEBA(trigger, ent)) {
      continue;
    }
    if(!_id_2E7A2D85639052EA(ent)) {
      continue;
    }
    _id_1916E100F11C7787(trigger, ent);
  }
}

_id_BB49E64A0F5DD911(trigger) {
  level endon("game_ended");
  trigger notify("watchradarScramblerTriggerExit");
  trigger endon("watchradarScramblerTriggerExit");
  trigger endon("death");

  for(;;) {
    _id_5C397C9CF7A06802 = trigger.entstouching;

    foreach(id, ent in _id_5C397C9CF7A06802) {
      if(!isDefined(ent))
        trigger.entstouching[id] = undefined;

      if(isDefined(ent) && !trigger istouching(ent))
        _id_45EFA9BC7F471EF1(trigger, ent);
    }

    waitframe();
  }
}

_id_1916E100F11C7787(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }
  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent._id_F676BE7150162CA7))
    ent._id_F676BE7150162CA7 = [];

  _id_5C397C9CF7A06802 = [trigger];

  foreach(_id_530E3190CC4E3FCE in ent._id_F676BE7150162CA7)
  _id_5C397C9CF7A06802[_id_5C397C9CF7A06802.size] = _id_530E3190CC4E3FCE;

  ent._id_F676BE7150162CA7 = _id_5C397C9CF7A06802;
  _id_D064E7371BA358C1(ent);
}

_id_45EFA9BC7F471EF1(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;
  _id_8F7BA87B5415AC10(ent);
  ent notify("clean_up_exit_threads");

  if(isDefined(ent._id_F676BE7150162CA7)) {
    ent._id_F676BE7150162CA7 = scripts\engine\utility::array_remove(ent._id_F676BE7150162CA7, trigger);

    if(ent._id_F676BE7150162CA7.size == 0)
      ent._id_F676BE7150162CA7 = undefined;
  }
}

_id_E0A087327B3B40F6(trigger) {
  trigger notify("watchradarScramblerSuppressionTrigger");
  trigger endon("watchradarScramblerSuppressionTrigger");
  trigger.entstouching = [];
  scripts\mp\flags::gameflagwait("prematch_done");
  thread _id_861C4C3943F268DE(trigger);
  thread _id_2C51CC91A2D4752E(trigger);
}

_id_2C51CC91A2D4752E(trigger) {
  level endon("game_ended");
  trigger notify("watchradarScramblerSupressionTriggerEnter");
  trigger endon("watchradarScramblerSupressionTriggerEnter");
  trigger endon("death");

  for(;;) {
    trigger waittill("trigger", ent);

    if(!_id_2E7A2D85639052EA(ent)) {
      continue;
    }
    _id_1D37828868E98950(trigger, ent);
  }
}

_id_861C4C3943F268DE(trigger) {
  level endon("game_ended");
  trigger notify("watchradarScramblerSuppressionTriggerExit");
  trigger endon("watchradarScramblerSuppressionTriggerExit");
  trigger endon("death");

  for(;;) {
    _id_5C397C9CF7A06802 = trigger.entstouching;

    if(isDefined(_id_5C397C9CF7A06802)) {
      foreach(id, ent in _id_5C397C9CF7A06802) {
        if(!isDefined(ent))
          trigger.entstouching[id] = undefined;

        if(isDefined(ent) && !trigger istouching(ent))
          _id_2AAD14C8236AC768(trigger, ent);
      }
    }

    waitframe();
  }
}

_id_1D37828868E98950(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }
  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent._id_540861E2AF03A290))
    ent._id_540861E2AF03A290 = [];

  _id_5C397C9CF7A06802 = [trigger];

  foreach(_id_78A0318DE6E1E56F in ent._id_540861E2AF03A290)
  _id_5C397C9CF7A06802[_id_5C397C9CF7A06802.size] = _id_78A0318DE6E1E56F;

  ent._id_540861E2AF03A290 = _id_5C397C9CF7A06802;
  _id_718F576400D123AB(ent);
}

_id_2AAD14C8236AC768(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;
  ent._id_540861E2AF03A290[trigger getentitynumber()] = undefined;

  if(ent._id_540861E2AF03A290.size == 0)
    ent._id_540861E2AF03A290 = undefined;

  _id_904C55FE002F0632(ent);
}

_id_07B13EE86BDAAEBA(trigger, ent) {
  if(isDefined(trigger.script_team)) {
    isvehicle = 0;

    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle())
      isvehicle = 1;

    if(isvehicle) {
      if(isvehicle && isDefined(ent.team) && ent.team != "neutral" && ent.team != trigger.script_team)
        return 0;

      if(isvehicle && isDefined(ent.owner) && ent.owner.team != trigger.script_team)
        return 0;

      if(isvehicle && isDefined(ent.occupants)) {
        foreach(_id_F85572CD5F6117C6 in ent.occupants) {
          if(_id_F85572CD5F6117C6.team != trigger.script_team)
            return 0;
        }
      }
    } else if(ent.team != trigger.script_team)
      return 0;
  }

  return 1;
}

_id_2E7A2D85639052EA(ent) {
  if(isDefined(ent)) {
    if(isPlayer(ent) || isagent(ent)) {
      if(ent scripts\cp_mp\utility\player_utility::_isalive())
        return 1;
    }

    if(isDefined(ent._id_61E67DD981E04FA7)) {
      if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        if(!istrue(ent.isdestroyed))
          return 1;
      }

      if(isDefined(ent.streakinfo) && _id_A8C8F4079A8961F5(ent.streakinfo.streakname))
        return 1;
    }
  }

  return 0;
}

_id_BA2C0913938C899C() {
  struct = level._id_918019B3BB20E3C6;

  if(!isDefined(struct)) {
    struct = spawnStruct();
    struct.entercallbacks = [];
    struct.exitcallbacks = [];
    struct.outoftimecallbacks = [];
    struct.clearcallbacks = [];
    level._id_918019B3BB20E3C6 = struct;
  }

  return struct;
}

_id_A8C8F4079A8961F5(streakname) {
  _id_1990E52AB5821AA7 = 0;

  switch (streakname) {
    case "pac_sentry":
    case "radar_drone_recon":
      _id_1990E52AB5821AA7 = 1;
      break;
  }

  return _id_1990E52AB5821AA7;
}

gettriggertype(ent, trigger) {
  triggertype = "default";

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return "br";

  if(isDefined(trigger) && isDefined(trigger.script_team))
    return "restricted";

  if(isDefined(ent) && ent scripts\cp_mp\vehicles\vehicle::isvehicle())
    return "default";

  if(isDefined(ent) && isDefined(ent.streakinfo))
    return "default";

  if(isDefined(trigger) && isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == "MineField")
    triggertype = "minefield";

  return triggertype;
}

getcooldowntime(triggertype) {
  switch (triggertype) {
    case "restricted":
    case "minefield":
    case "br":
    case "default":
      return _id_11982FA04C4ADE15(triggertype);
  }

  return undefined;
}

_id_11982FA04C4ADE15(triggertype) {
  switch (triggertype) {
    case "restricted":
    case "minefield":
    case "br":
    case "default":
      return _id_F301B665C2864E7D();
  }

  return undefined;
}

_id_F301B665C2864E7D() {
  _id_24AB8327AF3F90DF = level._id_24AB8327AF3F90DF;

  if(!isDefined(_id_24AB8327AF3F90DF)) {
    _id_24AB8327AF3F90DF = max(0, getdvarfloat("dvar_9C25E05A8010D645", 3));
    level._id_24AB8327AF3F90DF = _id_24AB8327AF3F90DF;
  }

  return _id_24AB8327AF3F90DF;
}

_id_3D92E694EC2D0078(ent) {
  if(isDefined(ent._id_F676BE7150162CA7))
    return ent._id_F676BE7150162CA7[0];

  return undefined;
}

previouslytouchedtriggertype(_id_7EDFACE381884CA9, _id_D9D739B40FEDD346) {
  _id_1B99BB6CC4AEC0FE = 0;

  if(isDefined(_id_7EDFACE381884CA9._id_007A3A633F3137EE)) {
    _id_F4A7B9FD1E2F84F0 = _id_7EDFACE381884CA9._id_007A3A633F3137EE;

    if(_id_D9D739B40FEDD346 == _id_F4A7B9FD1E2F84F0)
      _id_1B99BB6CC4AEC0FE = 1;
    else if((_id_D9D739B40FEDD346 == "default" || _id_D9D739B40FEDD346 == "minefield") && (_id_F4A7B9FD1E2F84F0 == "default" || _id_F4A7B9FD1E2F84F0 == "minefield"))
      _id_1B99BB6CC4AEC0FE = 1;
  }

  return _id_1B99BB6CC4AEC0FE;
}

_id_86AFCFB8EB7BF0D2(trigger) {}

_id_D55ED59C0CE164D3() {}

_id_417718DB737858B7() {
  wait 5;
  level.overwatch_emp_low = 0.8;
  level.overwatch_emp_high = 1.2;
  level.overwatch_emp_free = 5;
  level._id_3D1E30B1D4CDEA65 = getEntArray("emp_jammer", "targetname");

  foreach(_id_C9771233DA58F66C in level._id_3D1E30B1D4CDEA65) {
    _id_C9771233DA58F66C hudoutlineenable("outline_nodepth_red");
    _id_C9771233DA58F66C thread _id_E849523551C4F041();
  }
}

_id_E849523551C4F041() {
  self endon("death");
  self setCanDamage(1);
  self.health = 9999;
  self.maxhealth = 9999;
  self._id_ABBAA2FC2B3DA347 = 0;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(!isPlayer(attacker)) {
      continue;
    }
    if(meansofdeath == "MOD_GRENADE_SPLASH") {
      continue;
    }
    attacker thread _id_354C862768CFE202::updatedamagefeedback("hitturret", undefined, damage, 1);
    self._id_ABBAA2FC2B3DA347++;

    if(self._id_ABBAA2FC2B3DA347 < 5) {
      continue;
    }
    if(isDefined(self._id_281086936687228A)) {
      foreach(ent in self._id_281086936687228A.entstouching)
      _id_45EFA9BC7F471EF1(self._id_281086936687228A, ent);
    }

    self._id_281086936687228A delete();
    self delete();
  }
}

emp_effects_flickering(player) {
  level endon("stop_overwatch_emp_effects");
  player endon("stop_overwatch_emp_effects");
  player endon("disconnect");
  player notify("emp_effects_flickering");
  player endon("emp_effects_flickering");
  _id_3996095E0B23A557 = 0.75;

  for(;;) {
    _id_5321EB7C0023B4A7 = randomfloatrange(level.overwatch_emp_low, level.overwatch_emp_high);
    player thread scripts\cp_mp\emp_debuff::play_scramble_for_player_until_cleared(player, 5);
    _id_445B8E3C7F65E081 = randomfloat(level.overwatch_emp_free);
    wait(_id_5321EB7C0023B4A7 + _id_3996095E0B23A557 + _id_445B8E3C7F65E081);
  }
}

_id_11011E6292A21C15(player) {
  player notify("stop_overwatch_emp_effects");
  player notify("emp_cleared");
  player.mark_emp_effects = undefined;
}

stop_emp_effects_on_players() {
  level notify("stop_overwatch_emp_effects");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    level notify("emp_cleared");
    level.players[_id_AC0E594AC96AA3A8].mark_emp_effects = undefined;
  }
}