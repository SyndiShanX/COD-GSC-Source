/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\objective_trigger.gsc
***********************************************/

_id_B0637EFA07AB9DF9(ent, ref) {
  ent._id_4791D0F4B01A8675 = ref;
}

_id_51AC8764C365BC6E(ent) {
  ent._id_4791D0F4B01A8675 = undefined;
}

_id_10431805097C3712(ref, callback) {
  struct = _id_E5293BF61B1E0026();
  struct.entercallbacks[ref] = callback;
}

_id_A4CF949E6A5A2F32(ref, callback) {
  struct = _id_E5293BF61B1E0026();
  struct.exitcallbacks[ref] = callback;
}

_id_2C3B3ED775A05030(ref, callback) {
  struct = _id_E5293BF61B1E0026();
  struct.outoftimecallbacks[ref] = callback;
}

_id_9FECBA6DBCD17779(ref, callback) {
  struct = _id_E5293BF61B1E0026();
  struct.clearcallbacks[ref] = callback;
}

_id_A689A50C8F318FB8(ent, _id_3E36F415F762070E) {
  if(_id_8546BD495F6A810D(ent))
    return 0;

  if(istrue(_id_3E36F415F762070E) && _id_8546BD495F6A810D(ent))
    return 0;

  return isDefined(ent._id_FBE3CC20F5ADF348) && ent._id_FBE3CC20F5ADF348 > 0;
}

_id_5544F479A69046CB(ent) {
  if(!isDefined(ent._id_FBE3CC20F5ADF348))
    ent._id_FBE3CC20F5ADF348 = 0;

  ent._id_FBE3CC20F5ADF348++;

  if(ent._id_FBE3CC20F5ADF348 >= 1) {
    if(!isDefined(ent._id_EC6F43AA20537ACA) || ent._id_EC6F43AA20537ACA <= 0)
      _id_EF917FD93CCB888B(ent);
  }
}

_id_676E774A951AF28A(ent, _id_D5C909837FD4DEB4) {
  if(!isDefined(ent._id_FBE3CC20F5ADF348)) {
    if(isDefined(ent)) {}
  }

  if(!istrue(_id_D5C909837FD4DEB4)) {}

  ent._id_FBE3CC20F5ADF348--;

  if(ent._id_FBE3CC20F5ADF348 == 0) {
    ent._id_FBE3CC20F5ADF348 = undefined;

    if(!isDefined(ent._id_EC6F43AA20537ACA) || ent._id_EC6F43AA20537ACA <= 0)
      _id_DC3AB6F4F4115F21(ent, 0);
  }
}

_id_8546BD495F6A810D(ent) {
  return isDefined(ent._id_EC6F43AA20537ACA) && ent._id_EC6F43AA20537ACA > 0;
}

_id_0D74114CEF7502D9(ent) {
  if(!isDefined(ent._id_EC6F43AA20537ACA))
    ent._id_EC6F43AA20537ACA = 0;

  ent._id_EC6F43AA20537ACA++;

  if(ent._id_EC6F43AA20537ACA == 1) {
    if(isDefined(ent._id_FBE3CC20F5ADF348) && ent._id_FBE3CC20F5ADF348 > 0)
      _id_DC3AB6F4F4115F21(ent, 0);
  }
}

_id_ACB17AD29BB16600(ent) {
  ent._id_EC6F43AA20537ACA--;

  if(ent._id_EC6F43AA20537ACA == 0) {
    ent._id_EC6F43AA20537ACA = undefined;

    if(isDefined(ent._id_FBE3CC20F5ADF348) && ent._id_FBE3CC20F5ADF348 > 0)
      _id_EF917FD93CCB888B(ent);
  }
}

_id_3C54D0E74E6305CF(ent, _id_FCEF8D217A441961) {
  ent notify("clear_objectiveTrigger");

  if(_id_A689A50C8F318FB8(ent, 1))
    _id_DC3AB6F4F4115F21(ent, _id_FCEF8D217A441961, 1);

  _id_A92C68F274CD0239 = undefined;

  if(isPlayer(ent))
    _id_A92C68F274CD0239 = ::playerclearcallback;
  else if(isagent(ent))
    _id_A92C68F274CD0239 = ::playerclearcallback;
  else if(isDefined(ent._id_4791D0F4B01A8675)) {
    struct = _id_E5293BF61B1E0026();
    _id_A92C68F274CD0239 = struct.clearcallbacks[ent._id_4791D0F4B01A8675];
  }

  if(isDefined(_id_A92C68F274CD0239))
    ent[[_id_A92C68F274CD0239]]();

  ent._id_4791D0F4B01A8675 = undefined;
  ent._id_FBE3CC20F5ADF348 = undefined;
  ent._id_EC6F43AA20537ACA = undefined;
  ent._id_74C4FAE1DE63D2AC = undefined;
  ent._id_AE108624F7F46D2C = undefined;
  ent._id_86A97258F28D622C = undefined;

  if(isDefined(ent._id_B4782A67E2E204D5)) {
    foreach(trigger in ent._id_B4782A67E2E204D5)
    trigger.entstouching[ent getentitynumber()] = undefined;

    ent._id_B4782A67E2E204D5 = undefined;
  }

  if(isDefined(ent._id_04E2FC0E57EDB2DE)) {
    foreach(trigger in ent._id_04E2FC0E57EDB2DE)
    trigger.entstouching[ent getentitynumber()] = undefined;

    ent._id_04E2FC0E57EDB2DE = undefined;
  }
}

_id_7A59631F369CF28F() {
  if(istrue(self.allowedintrigger))
    return 0;

  if(!isDefined(level._id_B4782A67E2E204D5))
    return 0;

  foreach(trigger in level._id_B4782A67E2E204D5) {
    if(!_id_05EF32E4317FCAD8(trigger, self)) {
      continue;
    }
    if(self istouching(trigger))
      return 1;
  }

  return 0;
}

_id_8C2EE7CB53F2D33F(_id_863C619037F3AC74, _id_DA8CEC9BCE12F9CB) {
  _id_3D03B5C55B1367AF = 0;

  if(!isDefined(level._id_B4782A67E2E204D5))
    return _id_3D03B5C55B1367AF;
  else {
    foreach(trigger in level._id_B4782A67E2E204D5) {
      if(ispointinvolume(_id_863C619037F3AC74, trigger)) {
        if(isDefined(trigger.script_team) && isDefined(_id_DA8CEC9BCE12F9CB) && trigger.script_team != _id_DA8CEC9BCE12F9CB)
          continue;
        else {
          _id_3D03B5C55B1367AF = 1;
          break;
        }
      }
    }
  }

  return _id_3D03B5C55B1367AF;
}

_id_AB29F5844AA437FB() {
  if(level.script == "cp_hydro")
    return 1;

  return getdvarint("dvar_296C4DCD03CEE72B", 0) == 1;
}

_id_AE2BC8E7D8D4FC9B() {
  if(!scripts\engine\utility::flag_exist("radar_scramblers_initialized"))
    scripts\engine\utility::flag_init("radar_scramblers_initialized");

  if(!scripts\engine\utility::flag_exist("ready_for_region_spawning"))
    scripts\engine\utility::flag_init("ready_for_region_spawning");

  if(!scripts\engine\utility::flag_exist("ready_for_objective_trigger"))
    scripts\engine\utility::flag_init("ready_for_objective_trigger");

  if(!isDefined(level._id_B4782A67E2E204D5))
    level._id_B4782A67E2E204D5 = [];

  level._id_B4782A67E2E204D5 = scripts\engine\utility::array_combine(level._id_B4782A67E2E204D5, getEntArray("objective_trigger", "targetname"));
  thread _id_D76603EC2CCEC43C();

  if(getdvarint("dvar_0F9CA8E1807C937D", 0) != 0)
    thread _id_ECFA3BAECA7307D3();
  else
    thread _id_ECFA3BAECA7307D3(1);
}

_id_B661F9FCA2D11CDB() {
  if(!scripts\engine\utility::flag_exist("level_ready_for_script"))
    scripts\engine\utility::flag_init("level_ready_for_script");

  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(isDefined(level._id_FC46CD90F0A40C87))
    [[level._id_FC46CD90F0A40C87]]();

  if(!isDefined(level._id_B4782A67E2E204D5))
    level._id_B4782A67E2E204D5 = [];

  level._id_B4782A67E2E204D5 = scripts\engine\utility::array_combine(level._id_B4782A67E2E204D5, getEntArray("objective_trigger", "targetname"));
  thread _id_D76603EC2CCEC43C();

  if(getdvarint("dvar_0F9CA8E1807C937D", 0) != 0)
    thread _id_ECFA3BAECA7307D3();
  else
    thread _id_ECFA3BAECA7307D3(1);
}

_id_EF917FD93CCB888B(ent) {
  _id_2D2D28B1528166D2 = undefined;
  trigger = _id_76D6F049CA4670CE(ent);
  triggertype = gettriggertype(ent, trigger);

  if(isPlayer(ent))
    _id_2D2D28B1528166D2 = ::playerentercallback;
  else if(isDefined(ent.owner)) {
    if(isPlayer(ent.owner))
      _id_2D2D28B1528166D2 = ::playerentercallback;
  } else if(isDefined(ent._id_4791D0F4B01A8675)) {
    struct = _id_E5293BF61B1E0026();
    _id_2D2D28B1528166D2 = struct.entercallbacks[ent._id_4791D0F4B01A8675];
  }

  ent notify("objectiveTrigger_cooldown_end");

  if(isDefined(ent._id_74C4FAE1DE63D2AC) && previouslytouchedtriggertype(ent, triggertype)) {
    _id_644A8646988EBAC1 = ent._id_74C4FAE1DE63D2AC / 1000;
    ent._id_AE108624F7F46D2C = int(gettime() + ent._id_74C4FAE1DE63D2AC);
    ent._id_74C4FAE1DE63D2AC = undefined;
    thread _id_214637C8C6D3C1C7(ent, _id_644A8646988EBAC1);
  } else {
    ent._id_74C4FAE1DE63D2AC = undefined;
    ent._id_86A97258F28D622C = triggertype;
    _id_644A8646988EBAC1 = _id_7854A56A0F3CAD3F(triggertype);
    ent._id_AE108624F7F46D2C = int(gettime() + _id_644A8646988EBAC1 * 1000);
    thread _id_214637C8C6D3C1C7(ent, _id_644A8646988EBAC1);
  }

  if(isDefined(_id_2D2D28B1528166D2))
    ent thread[[_id_2D2D28B1528166D2]]("exit_objectiveTrigger", "clear_objectiveTrigger", triggertype, trigger);
}

_id_DC3AB6F4F4115F21(ent, _id_FCEF8D217A441961, _id_704294F906FAD67E) {
  ent notify("exit_objectiveTrigger");
  _id_6166EC335950C5F2 = undefined;

  if(isPlayer(ent))
    _id_6166EC335950C5F2 = ::playerexitcallback;
  else if(isDefined(ent.owner)) {
    if(isPlayer(ent.owner))
      _id_6166EC335950C5F2 = ::playerexitcallback;
  } else if(isDefined(ent._id_4791D0F4B01A8675)) {
    struct = _id_E5293BF61B1E0026();
    _id_6166EC335950C5F2 = struct.exitcallbacks[ent._id_4791D0F4B01A8675];
  }

  ent notify("objectiveTrigger_timeout_end");

  if(!istrue(_id_704294F906FAD67E)) {
    if(isDefined(ent._id_AE108624F7F46D2C)) {
      ent._id_74C4FAE1DE63D2AC = int(max(0, ent._id_AE108624F7F46D2C - gettime()));
      ent._id_AE108624F7F46D2C = undefined;
      trigger = _id_76D6F049CA4670CE(ent);
      triggertype = gettriggertype(ent, trigger);
      cooldowntime = getcooldowntime(triggertype);
      thread _id_20F4B12AE43EB94C(ent, cooldowntime);
    }
  }

  if(isDefined(_id_6166EC335950C5F2))
    ent thread[[_id_6166EC335950C5F2]](_id_FCEF8D217A441961, _id_704294F906FAD67E, "clear_objectiveTrigger");
}

_id_395F3346BE3D7DF7(ent) {
  _id_106B10573BDEADF0 = undefined;

  if(isPlayer(ent)) {
    _id_775C9A68F9C00019 = 1;

    if(_id_775C9A68F9C00019)
      _id_106B10573BDEADF0 = ::playeroutoftimecallback;
  } else if(isagent(ent)) {
    _id_775C9A68F9C00019 = 1;

    if(_id_775C9A68F9C00019)
      _id_106B10573BDEADF0 = ::playeroutoftimecallback;
  } else if(isDefined(ent._id_4791D0F4B01A8675)) {
    struct = _id_E5293BF61B1E0026();
    _id_106B10573BDEADF0 = struct.outoftimecallbacks[ent._id_4791D0F4B01A8675];
  }

  if(isDefined(_id_106B10573BDEADF0))
    ent thread[[_id_106B10573BDEADF0]]("objectiveTrigger_timeout_end", "clear_objectiveTrigger");
}

_id_214637C8C6D3C1C7(ent, _id_8DD9F2EB8215A139) {
  if(isPlayer(ent) || isagent(ent))
    ent endon("death");

  ent notify("objectiveTrigger_timeout_end");
  ent endon("objectiveTrigger_timeout_end");
  ent endon("clear_objectiveTrigger");
  wait(_id_8DD9F2EB8215A139);
  thread _id_395F3346BE3D7DF7(ent);
}

_id_20F4B12AE43EB94C(ent, _id_8DD9F2EB8215A139) {
  if(isPlayer(ent) || isagent(ent))
    ent endon("death");

  ent notify("objectiveTrigger_cooldown_end");
  ent endon("objectiveTrigger_cooldown_end");
  ent endon("clear_objectiveTrigger");
  wait(_id_8DD9F2EB8215A139);
  ent._id_74C4FAE1DE63D2AC = undefined;
  ent._id_86A97258F28D622C = undefined;
}

playerentercallback(_id_44E306D53285E1F8, _id_93F5DB7E81311353, triggertype, trigger) {
  _id_7E02C245F06F3CA0 = 1;

  if(isDefined(triggertype) && triggertype == "restricted")
    _id_7E02C245F06F3CA0 = 2;

  self._id_3DB3AC8C06039207 = trigger;
  level notify("global_objective_request", trigger, 1);
}

_id_B2A14335ECF202F8(_id_44E306D53285E1F8, _id_93F5DB7E81311353, triggertype, trigger) {
  _id_7E02C245F06F3CA0 = 1;

  if(isDefined(triggertype) && triggertype == "restricted")
    _id_7E02C245F06F3CA0 = 2;

  _id_86AFCFB8EB7BF0D2(trigger);
  self._id_3DB3AC8C06039207 = trigger;
}

playerexitcallback(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353) {
  _id_BBBA777ADF94982F = 0;

  foreach(player in level.players) {
    if(player != self) {
      if(isDefined(player._id_3DB3AC8C06039207))
        _id_BBBA777ADF94982F = 1;
    }
  }

  if(istrue(_id_BBBA777ADF94982F))
    level notify("global_objective_request", undefined, undefined, _id_BBBA777ADF94982F);

  self._id_3DB3AC8C06039207 = undefined;
}

_id_0D405DEE230E91B4(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353) {
  self._id_3DB3AC8C06039207 = undefined;
  _id_D55ED59C0CE164D3();
}

playeroutoftimecallback(_id_2F57CFAE824CA728, _id_93F5DB7E81311353) {
  trigger = _id_76D6F049CA4670CE(self);
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
  _id_7E02C245F06F3CA0 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.gametype == "arm" && isDefined(triggertype) && triggertype == "restricted")
    _id_7E02C245F06F3CA0 = 2;

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

_id_EADC517453265031() {
  _id_10431805097C3712("killstreak", ::killstreakentercallback);
  _id_A4CF949E6A5A2F32("killstreak", ::killstreakexitcallback);
  _id_2C3B3ED775A05030("killstreak", ::killstreakoutoftimecallback);
  _id_9FECBA6DBCD17779("killstreak", ::killstreakclearcallback);
}

_id_D76603EC2CCEC43C() {
  _id_20533273F43DD4E2 = [];

  if(isDefined(level._id_B4782A67E2E204D5)) {
    foreach(trigger in level._id_B4782A67E2E204D5)
    thread _id_5323115D2E0146A7(trigger);

    if(isDefined(level._id_7AD9BDA566C961E2)) {
      foreach(trigger in level._id_7AD9BDA566C961E2)
      thread _id_52995B442A0732F0(trigger);
    }
  }
}

_id_5323115D2E0146A7(trigger) {
  trigger notify("watchobjectiveTriggerTrigger");
  trigger endon("watchobjectiveTriggerTrigger");
  trigger.entstouching = [];

  if(isDefined(trigger.target)) {
    trigger._id_3EFE1B3A9EF1ABA0 = getEnt(trigger.target, "targetname");
    trigger._id_3EFE1B3A9EF1ABA0._id_281086936687228A = trigger;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  thread _id_EC019FA6DA14CA67(trigger);
  thread _id_29EAB5EC1944E9D3(trigger);
}

_id_29EAB5EC1944E9D3(trigger) {
  level endon("game_ended");
  trigger notify("watchobjectiveTriggerTriggerEnter");
  trigger endon("watchobjectiveTriggerTriggerEnter");
  trigger endon("death");

  for(;;) {
    trigger waittill("trigger", ent);

    if(!_id_05EF32E4317FCAD8(trigger, ent)) {
      continue;
    }
    if(!_id_230474EDD3A1D4D8(ent)) {
      continue;
    }
    _id_D5ACE299257DE7D5(trigger, ent);
  }
}

_id_EC019FA6DA14CA67(trigger) {
  level endon("game_ended");
  trigger notify("watchobjectiveTriggerTriggerExit");
  trigger endon("watchobjectiveTriggerTriggerExit");
  trigger endon("death");

  for(;;) {
    _id_5C397C9CF7A06802 = trigger.entstouching;

    foreach(id, ent in _id_5C397C9CF7A06802) {
      if(!isDefined(ent))
        trigger.entstouching[id] = undefined;

      if(isDefined(ent) && !trigger istouching(ent))
        _id_6D0BD2B7230B50A7(trigger, ent);
    }

    waitframe();
  }
}

_id_D5ACE299257DE7D5(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }
  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent._id_B4782A67E2E204D5))
    ent._id_B4782A67E2E204D5 = [];

  _id_5C397C9CF7A06802 = [trigger];

  foreach(_id_FA552D9E6C2B24A4 in ent._id_B4782A67E2E204D5)
  _id_5C397C9CF7A06802[_id_5C397C9CF7A06802.size] = _id_FA552D9E6C2B24A4;

  ent._id_B4782A67E2E204D5 = _id_5C397C9CF7A06802;
  _id_5544F479A69046CB(ent);
}

_id_6D0BD2B7230B50A7(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;

  if(isDefined(ent._id_FBE3CC20F5ADF348))
    _id_676E774A951AF28A(ent);

  ent notify("clean_up_exit_threads");

  if(isDefined(ent._id_B4782A67E2E204D5)) {
    ent._id_B4782A67E2E204D5 = scripts\engine\utility::array_remove(ent._id_B4782A67E2E204D5, trigger);

    if(ent._id_B4782A67E2E204D5.size == 0)
      ent._id_B4782A67E2E204D5 = undefined;
  }
}

_id_52995B442A0732F0(trigger) {
  trigger notify("watchobjectiveTriggerSuppressionTrigger");
  trigger endon("watchobjectiveTriggerSuppressionTrigger");
  trigger.entstouching = [];
  scripts\mp\flags::gameflagwait("prematch_done");
  thread _id_006D39E0E71A1E00(trigger);
  thread _id_D2BAA277E84E3A80(trigger);
}

_id_D2BAA277E84E3A80(trigger) {
  level endon("game_ended");
  trigger notify("watchobjectiveTriggerSupressionTriggerEnter");
  trigger endon("watchobjectiveTriggerSupressionTriggerEnter");
  trigger endon("death");

  for(;;) {
    trigger waittill("trigger", ent);

    if(!_id_230474EDD3A1D4D8(ent)) {
      continue;
    }
    _id_5793B781F72EB2B2(trigger, ent);
  }
}

_id_006D39E0E71A1E00(trigger) {
  level endon("game_ended");
  trigger notify("watchobjectiveTriggerSuppressionTriggerExit");
  trigger endon("watchobjectiveTriggerSuppressionTriggerExit");
  trigger endon("death");

  for(;;) {
    _id_5C397C9CF7A06802 = trigger.entstouching;

    if(isDefined(_id_5C397C9CF7A06802)) {
      foreach(id, ent in _id_5C397C9CF7A06802) {
        if(!isDefined(ent))
          trigger.entstouching[id] = undefined;

        if(isDefined(ent) && !trigger istouching(ent))
          _id_1E6C93C4667A5A56(trigger, ent);
      }
    }

    waitframe();
  }
}

_id_5793B781F72EB2B2(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }
  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent._id_04E2FC0E57EDB2DE))
    ent._id_04E2FC0E57EDB2DE = [];

  _id_5C397C9CF7A06802 = [trigger];

  foreach(_id_72B3F955DC9651D1 in ent._id_04E2FC0E57EDB2DE)
  _id_5C397C9CF7A06802[_id_5C397C9CF7A06802.size] = _id_72B3F955DC9651D1;

  ent._id_04E2FC0E57EDB2DE = _id_5C397C9CF7A06802;
  _id_0D74114CEF7502D9(ent);
}

_id_1E6C93C4667A5A56(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;
  ent._id_04E2FC0E57EDB2DE[trigger getentitynumber()] = undefined;

  if(ent._id_04E2FC0E57EDB2DE.size == 0)
    ent._id_04E2FC0E57EDB2DE = undefined;

  _id_ACB17AD29BB16600(ent);
}

_id_05EF32E4317FCAD8(trigger, ent) {
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

_id_230474EDD3A1D4D8(ent) {
  if(isDefined(ent)) {
    if(isPlayer(ent)) {
      if(ent scripts\cp_mp\utility\player_utility::_isalive())
        return 1;
    }

    if(isDefined(ent._id_4791D0F4B01A8675)) {
      if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        if(!istrue(ent.isdestroyed))
          return 1;
      }

      if(isDefined(ent.streakinfo) && _id_988F25F45FDFEA57(ent.streakinfo.streakname))
        return 1;
    }
  }

  return 0;
}

_id_E5293BF61B1E0026() {
  struct = level._id_D16604D2A4BE9B50;

  if(!isDefined(struct)) {
    struct = spawnStruct();
    struct.entercallbacks = [];
    struct.exitcallbacks = [];
    struct.outoftimecallbacks = [];
    struct.clearcallbacks = [];
    level._id_D16604D2A4BE9B50 = struct;
  }

  return struct;
}

_id_988F25F45FDFEA57(streakname) {
  if(level.script == "cp_hydro")
    return 1;

  _id_4528D83C55F68159 = 0;

  switch (streakname) {
    case "pac_sentry":
    case "radar_drone_recon":
      _id_4528D83C55F68159 = 1;
      break;
  }

  return _id_4528D83C55F68159;
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
      return _id_7854A56A0F3CAD3F(triggertype);
  }

  return undefined;
}

_id_7854A56A0F3CAD3F(triggertype) {
  switch (triggertype) {
    case "restricted":
    case "minefield":
    case "br":
    case "default":
      return _id_D92BC82CF09792E7();
  }

  return undefined;
}

_id_D92BC82CF09792E7() {
  _id_644A8646988EBAC1 = level._id_644A8646988EBAC1;

  if(!isDefined(_id_644A8646988EBAC1)) {
    _id_644A8646988EBAC1 = max(0, getdvarfloat("dvar_4385C822D0F7FF6F", 3));
    level._id_644A8646988EBAC1 = _id_644A8646988EBAC1;
  }

  return _id_644A8646988EBAC1;
}

_id_76D6F049CA4670CE(ent) {
  if(isDefined(ent._id_B4782A67E2E204D5))
    return ent._id_B4782A67E2E204D5[0];

  return undefined;
}

previouslytouchedtriggertype(_id_7EDFACE381884CA9, _id_D9D739B40FEDD346) {
  _id_1B99BB6CC4AEC0FE = 0;

  if(isDefined(_id_7EDFACE381884CA9._id_86A97258F28D622C)) {
    _id_F4A7B9FD1E2F84F0 = _id_7EDFACE381884CA9._id_86A97258F28D622C;

    if(_id_D9D739B40FEDD346 == _id_F4A7B9FD1E2F84F0)
      _id_1B99BB6CC4AEC0FE = 1;
    else if((_id_D9D739B40FEDD346 == "default" || _id_D9D739B40FEDD346 == "minefield") && (_id_F4A7B9FD1E2F84F0 == "default" || _id_F4A7B9FD1E2F84F0 == "minefield"))
      _id_1B99BB6CC4AEC0FE = 1;
  }

  return _id_1B99BB6CC4AEC0FE;
}

_id_86AFCFB8EB7BF0D2(trigger) {}

_id_D55ED59C0CE164D3() {}

_id_ECFA3BAECA7307D3(_id_CAD5E66C0A5DC607) {
  level endon("game_ended");
  level notify("globalObjectiveChangeRequests");
  level endon("globalObjectiveChangeRequests");
  level._id_92ACCDCD4283F715 = [];

  for(;;) {
    level waittill("global_objective_request", _id_3DB3AC8C06039207, _id_3948981FF1DD7AF6, _id_BBBA777ADF94982F);

    if(istrue(_id_CAD5E66C0A5DC607)) {
      if(isDefined(_id_3DB3AC8C06039207)) {
        _id_B46496BA73DC641B = _id_3DB3AC8C06039207.script_noteworthy;
        level thread[[level._id_06B67B924A327783]](_id_B46496BA73DC641B);
      }

      continue;
    }

    if(istrue(_id_BBBA777ADF94982F)) {
      thread scripts\cp\cp_objectives::run_objective("stealth_container", "primary");
      continue;
    }

    if(!isDefined(_id_3DB3AC8C06039207)) {
      if(!isDefined(_id_3DB3AC8C06039207))
        continue;
    }

    _id_B46496BA73DC641B = _id_3DB3AC8C06039207.script_noteworthy;

    if(scripts\engine\utility::array_contains(level._id_92ACCDCD4283F715, _id_B46496BA73DC641B)) {
      continue;
    }
    if(istrue(_id_3948981FF1DD7AF6))
      _id_DA21AF5D15C8DC18(_id_B46496BA73DC641B);

    level._id_92ACCDCD4283F715 = scripts\engine\utility::array_add(level._id_92ACCDCD4283F715, _id_B46496BA73DC641B);
    thread scripts\cp\cp_objectives::run_objective(_id_B46496BA73DC641B, "primary");
  }
}

_id_DA21AF5D15C8DC18(_id_B46496BA73DC641B) {
  foreach(struct in level.activequests) {
    name = struct.objname;

    if(name == _id_B46496BA73DC641B) {
      continue;
    }
    objectivestruct = scripts\cp\cp_objectives::getobjectivestructfromref(name);
    scripts\cp\cp_objectives::_id_4312A455BFDAA469(objectivestruct, name);
    level._id_92ACCDCD4283F715 = scripts\engine\utility::array_remove(level._id_92ACCDCD4283F715, name);
  }
}

_id_DF7E197C7E058E4B() {
  return getdvarint("dvar_C4ABDD14BCE1E11C", 0) != 0;
}