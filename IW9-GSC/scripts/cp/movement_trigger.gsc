/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\movement_trigger.gsc
***********************************************/

_id_ACBD5549E257C05F(ent, ref) {
  ent._id_C7146296A3FD5B15 = ref;
}

_id_9B5D305B348D3802(ent) {
  ent._id_C7146296A3FD5B15 = undefined;
}

_id_3FB9B9CF10D4F89C(ref, callback) {
  struct = _id_D7C5841BA3C7F86A();
  struct.entercallbacks[ref] = callback;
}

_id_6CCA8C5C6D8A5B90(ref, callback) {
  struct = _id_D7C5841BA3C7F86A();
  struct.exitcallbacks[ref] = callback;
}

_id_0AC7BA0E846DBD8E(ref, callback) {
  struct = _id_D7C5841BA3C7F86A();
  struct.outoftimecallbacks[ref] = callback;
}

_id_0E1BEC9DCC4CD3B3(ref, callback) {
  struct = _id_D7C5841BA3C7F86A();
  struct.clearcallbacks[ref] = callback;
}

_id_70B3CA07D4C0F3F8(ent, _id_3E36F415F762070E) {
  if(_id_B819716A1D02554D(ent))
    return 0;

  if(istrue(_id_3E36F415F762070E) && _id_B819716A1D02554D(ent))
    return 0;

  return isDefined(ent._id_38C28A5CC311C668) && ent._id_38C28A5CC311C668 > 0;
}

_id_65C16FD9E382BFA5(ent) {
  if(!isDefined(ent._id_38C28A5CC311C668))
    ent._id_38C28A5CC311C668 = 0;

  ent._id_38C28A5CC311C668++;

  if(ent._id_38C28A5CC311C668 >= 1) {
    if(!isDefined(ent._id_B55EFC7E48CDB8EA) || ent._id_B55EFC7E48CDB8EA <= 0)
      _id_E7092435542D8765(ent);
  }
}

_id_CB19EE46FAA81F4E(ent, _id_D5C909837FD4DEB4) {
  if(!isDefined(ent._id_38C28A5CC311C668)) {
    if(isDefined(ent)) {}
  }

  if(!istrue(_id_D5C909837FD4DEB4)) {}

  ent._id_38C28A5CC311C668--;

  if(ent._id_38C28A5CC311C668 == 0) {
    ent._id_38C28A5CC311C668 = undefined;

    if(!isDefined(ent._id_B55EFC7E48CDB8EA) || ent._id_B55EFC7E48CDB8EA <= 0)
      _id_D695C5F1C8B04647(ent, 0);
  }
}

_id_B819716A1D02554D(ent) {
  return isDefined(ent._id_B55EFC7E48CDB8EA) && ent._id_B55EFC7E48CDB8EA > 0;
}

_id_B3F8ECF3B39399B7(ent) {
  if(!isDefined(ent._id_B55EFC7E48CDB8EA))
    ent._id_B55EFC7E48CDB8EA = 0;

  ent._id_B55EFC7E48CDB8EA++;

  if(ent._id_B55EFC7E48CDB8EA == 1) {
    if(isDefined(ent._id_38C28A5CC311C668) && ent._id_38C28A5CC311C668 > 0)
      _id_D695C5F1C8B04647(ent, 0);
  }
}

_id_DA29A8F49C0535BC(ent) {
  ent._id_B55EFC7E48CDB8EA--;

  if(ent._id_B55EFC7E48CDB8EA == 0) {
    ent._id_B55EFC7E48CDB8EA = undefined;

    if(isDefined(ent._id_38C28A5CC311C668) && ent._id_38C28A5CC311C668 > 0)
      _id_E7092435542D8765(ent);
  }
}

_id_EAF4B556BCAC2919(ent, _id_FCEF8D217A441961) {
  ent notify("clear_movementTrigger");

  if(_id_70B3CA07D4C0F3F8(ent, 1))
    _id_D695C5F1C8B04647(ent, _id_FCEF8D217A441961, 1);

  _id_A92C68F274CD0239 = undefined;

  if(isPlayer(ent))
    _id_A92C68F274CD0239 = ::playerclearcallback;
  else if(isagent(ent))
    _id_A92C68F274CD0239 = ::playerclearcallback;
  else if(isDefined(ent._id_C7146296A3FD5B15)) {
    struct = _id_D7C5841BA3C7F86A();
    _id_A92C68F274CD0239 = struct.clearcallbacks[ent._id_C7146296A3FD5B15];
  }

  if(isDefined(_id_A92C68F274CD0239))
    ent[[_id_A92C68F274CD0239]]();

  ent._id_C7146296A3FD5B15 = undefined;
  ent._id_38C28A5CC311C668 = undefined;
  ent._id_B55EFC7E48CDB8EA = undefined;
  ent._id_5BBD76D99B3263CC = undefined;
  ent._id_8C09AC259B9C71CC = undefined;
  ent._id_CC69DADA300D6DCC = undefined;

  if(isDefined(ent._id_09A1BDB96D46FBF5)) {
    foreach(trigger in ent._id_09A1BDB96D46FBF5)
    trigger.entstouching[ent getentitynumber()] = undefined;

    ent._id_09A1BDB96D46FBF5 = undefined;
  }

  if(isDefined(ent._id_7BA5C84EB36C67FE)) {
    foreach(trigger in ent._id_7BA5C84EB36C67FE)
    trigger.entstouching[ent getentitynumber()] = undefined;

    ent._id_7BA5C84EB36C67FE = undefined;
  }
}

_id_3F976D2CDF3E3BD1() {
  if(istrue(self.allowedintrigger))
    return 0;

  if(!isDefined(level._id_09A1BDB96D46FBF5))
    return 0;

  foreach(trigger in level._id_09A1BDB96D46FBF5) {
    if(!_id_5D67F66EE32FFAF8(trigger, self)) {
      continue;
    }
    if(self istouching(trigger))
      return 1;
  }

  return 0;
}

_id_835C95339593D1A9(_id_863C619037F3AC74, _id_DA8CEC9BCE12F9CB) {
  _id_4352B6BF6EA78A79 = 0;

  if(!isDefined(level._id_09A1BDB96D46FBF5))
    return _id_4352B6BF6EA78A79;
  else {
    foreach(trigger in level._id_09A1BDB96D46FBF5) {
      if(ispointinvolume(_id_863C619037F3AC74, trigger)) {
        if(isDefined(trigger.script_team) && isDefined(_id_DA8CEC9BCE12F9CB) && trigger.script_team != _id_DA8CEC9BCE12F9CB)
          continue;
        else {
          _id_4352B6BF6EA78A79 = 1;
          break;
        }
      }
    }
  }

  return _id_4352B6BF6EA78A79;
}

_id_777C44BDFC80C0BB() {
  return getdvarint("dvar_7CE6917A4B3920EF", 0) == 1;
}

_id_FBBB9E404CE48427() {
  if(!scripts\engine\utility::flag_exist("radar_scramblers_initialized"))
    scripts\engine\utility::flag_init("radar_scramblers_initialized");

  if(!scripts\engine\utility::flag_exist("ready_for_region_spawning"))
    scripts\engine\utility::flag_init("ready_for_region_spawning");

  if(!scripts\engine\utility::flag_exist("ready_for_movement_trigger"))
    scripts\engine\utility::flag_init("ready_for_movement_trigger");

  if(!isDefined(level._id_09A1BDB96D46FBF5))
    level._id_09A1BDB96D46FBF5 = [];

  level._id_8D330DFEC4A5260F = ["cqb", "creep", "default"];
  level._id_09A1BDB96D46FBF5 = scripts\engine\utility::array_combine(level._id_09A1BDB96D46FBF5, getEntArray("movement_trigger", "targetname"));
  thread _id_63660D5C7F87DCAE();
}

_id_ADA79477E276D617() {
  if(!scripts\engine\utility::flag_exist("level_ready_for_script"))
    scripts\engine\utility::flag_init("level_ready_for_script");

  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(isDefined(level._id_FC46CD90F0A40C87))
    [[level._id_FC46CD90F0A40C87]]();

  if(!isDefined(level._id_09A1BDB96D46FBF5))
    level._id_09A1BDB96D46FBF5 = [];

  level._id_8D330DFEC4A5260F = ["cqb", "creep", "default"];
  level._id_09A1BDB96D46FBF5 = scripts\engine\utility::array_combine(level._id_09A1BDB96D46FBF5, getEntArray("movement_trigger", "targetname"));
  thread _id_63660D5C7F87DCAE();
}

_id_E7092435542D8765(ent) {
  _id_2D2D28B1528166D2 = undefined;
  trigger = _id_3FC7E9CFAAC73FDA(ent);
  triggertype = gettriggertype(ent, trigger);

  if(isPlayer(ent))
    _id_2D2D28B1528166D2 = ::playerentercallback;
  else if(isagent(ent))
    _id_2D2D28B1528166D2 = ::_id_B2A14335ECF202F8;
  else if(isDefined(ent._id_C7146296A3FD5B15)) {
    struct = _id_D7C5841BA3C7F86A();
    _id_2D2D28B1528166D2 = struct.entercallbacks[ent._id_C7146296A3FD5B15];
  }

  ent notify("movementTrigger_cooldown_end");

  if(isDefined(ent._id_5BBD76D99B3263CC) && previouslytouchedtriggertype(ent, triggertype)) {
    _id_35C02D7C9763F4E1 = ent._id_5BBD76D99B3263CC / 1000;
    ent._id_8C09AC259B9C71CC = int(gettime() + ent._id_5BBD76D99B3263CC);
    ent._id_5BBD76D99B3263CC = undefined;
    thread _id_C6CF2AA4715357ED(ent, _id_35C02D7C9763F4E1);
  } else {
    ent._id_5BBD76D99B3263CC = undefined;
    ent._id_CC69DADA300D6DCC = triggertype;
    _id_35C02D7C9763F4E1 = _id_44D732A7AFEBF0DB(triggertype);
    ent._id_8C09AC259B9C71CC = int(gettime() + _id_35C02D7C9763F4E1 * 1000);
    thread _id_C6CF2AA4715357ED(ent, _id_35C02D7C9763F4E1);
  }

  if(isDefined(_id_2D2D28B1528166D2))
    ent thread[[_id_2D2D28B1528166D2]]("exit_movementTrigger", "clear_movementTrigger", triggertype, trigger);
}

_id_D695C5F1C8B04647(ent, _id_FCEF8D217A441961, _id_704294F906FAD67E) {
  ent notify("exit_movementTrigger");
  _id_6166EC335950C5F2 = undefined;

  if(isPlayer(ent))
    _id_6166EC335950C5F2 = ::playerexitcallback;
  else if(isagent(ent))
    _id_6166EC335950C5F2 = ::_id_0D405DEE230E91B4;
  else if(isDefined(ent._id_C7146296A3FD5B15)) {
    struct = _id_D7C5841BA3C7F86A();
    _id_6166EC335950C5F2 = struct.exitcallbacks[ent._id_C7146296A3FD5B15];
  }

  ent notify("movementTrigger_timeout_end");

  if(!istrue(_id_704294F906FAD67E)) {
    if(isDefined(ent._id_8C09AC259B9C71CC)) {
      ent._id_5BBD76D99B3263CC = int(max(0, ent._id_8C09AC259B9C71CC - gettime()));
      ent._id_8C09AC259B9C71CC = undefined;
      trigger = _id_3FC7E9CFAAC73FDA(ent);
      triggertype = gettriggertype(ent, trigger);
      cooldowntime = getcooldowntime(triggertype);
      thread _id_B73235558AAEB3A2(ent, cooldowntime);
    }
  }

  if(isDefined(_id_6166EC335950C5F2))
    ent thread[[_id_6166EC335950C5F2]](_id_FCEF8D217A441961, _id_704294F906FAD67E, "clear_movementTrigger");
}

_id_07487311D783BEFD(ent) {
  _id_106B10573BDEADF0 = undefined;

  if(isPlayer(ent)) {
    _id_775C9A68F9C00019 = 1;

    if(_id_775C9A68F9C00019)
      _id_106B10573BDEADF0 = ::playeroutoftimecallback;
  } else if(isagent(ent)) {
    _id_775C9A68F9C00019 = 1;

    if(_id_775C9A68F9C00019)
      _id_106B10573BDEADF0 = ::playeroutoftimecallback;
  } else if(isDefined(ent._id_C7146296A3FD5B15)) {
    struct = _id_D7C5841BA3C7F86A();
    _id_106B10573BDEADF0 = struct.outoftimecallbacks[ent._id_C7146296A3FD5B15];
  }

  if(isDefined(_id_106B10573BDEADF0))
    ent thread[[_id_106B10573BDEADF0]]("movementTrigger_timeout_end", "clear_movementTrigger");
}

_id_C6CF2AA4715357ED(ent, _id_8DD9F2EB8215A139) {
  if(isPlayer(ent) || isagent(ent))
    ent endon("death");

  ent notify("movementTrigger_timeout_end");
  ent endon("movementTrigger_timeout_end");
  ent endon("clear_movementTrigger");
  wait(_id_8DD9F2EB8215A139);
  thread _id_07487311D783BEFD(ent);
}

_id_B73235558AAEB3A2(ent, _id_8DD9F2EB8215A139) {
  if(isPlayer(ent) || isagent(ent))
    ent endon("death");

  ent notify("movementTrigger_cooldown_end");
  ent endon("movementTrigger_cooldown_end");
  ent endon("clear_movementTrigger");
  wait(_id_8DD9F2EB8215A139);
  ent._id_5BBD76D99B3263CC = undefined;
  ent._id_CC69DADA300D6DCC = undefined;
}

playerentercallback(_id_44E306D53285E1F8, _id_93F5DB7E81311353, triggertype, trigger) {
  _id_4F78697BEF4476C0 = 1;

  if(isDefined(triggertype) && triggertype == "restricted")
    _id_4F78697BEF4476C0 = 2;

  self._id_19AE4118816007E7 = trigger;
  self notify("movement_speed_update_request", trigger);
}

_id_B2A14335ECF202F8(_id_44E306D53285E1F8, _id_93F5DB7E81311353, triggertype, trigger) {
  _id_4F78697BEF4476C0 = 1;

  if(isDefined(triggertype) && triggertype == "restricted")
    _id_4F78697BEF4476C0 = 2;

  _id_86AFCFB8EB7BF0D2(trigger);
  self._id_19AE4118816007E7 = trigger;
}

playerexitcallback(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353) {
  self notify("movement_speed_update_request", undefined, undefined, 1);

  if(scripts\engine\utility::array_contains(self._id_3F62A078D28C12E3, self._id_19AE4118816007E7.script_noteworthy))
    self._id_3F62A078D28C12E3 = scripts\engine\utility::array_remove(self._id_3F62A078D28C12E3, self._id_19AE4118816007E7.script_noteworthy);

  self._id_19AE4118816007E7 = undefined;
}

_id_0D405DEE230E91B4(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353) {
  self._id_19AE4118816007E7 = undefined;
  _id_D55ED59C0CE164D3();
}

playeroutoftimecallback(_id_2F57CFAE824CA728, _id_93F5DB7E81311353) {
  trigger = _id_3FC7E9CFAAC73FDA(self);
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
  _id_4F78697BEF4476C0 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.gametype == "arm" && isDefined(triggertype) && triggertype == "restricted")
    _id_4F78697BEF4476C0 = 2;

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

_id_2D13344310ED2A7B() {
  _id_3FB9B9CF10D4F89C("killstreak", ::killstreakentercallback);
  _id_6CCA8C5C6D8A5B90("killstreak", ::killstreakexitcallback);
  _id_0AC7BA0E846DBD8E("killstreak", ::killstreakoutoftimecallback);
  _id_0E1BEC9DCC4CD3B3("killstreak", ::killstreakclearcallback);
}

_id_63660D5C7F87DCAE() {
  _id_20533273F43DD4E2 = [];

  if(isDefined(level._id_09A1BDB96D46FBF5)) {
    foreach(trigger in level._id_09A1BDB96D46FBF5)
    thread _id_C8D3EF6178B94EE9(trigger);

    if(isDefined(level._id_5B706F51FFBF9302)) {
      foreach(trigger in level._id_5B706F51FFBF9302)
      thread _id_4E5513E51C2DD30E(trigger);
    }
  }
}

_id_C8D3EF6178B94EE9(trigger) {
  trigger notify("watchmovementTriggerTrigger");
  trigger endon("watchmovementTriggerTrigger");
  trigger.entstouching = [];

  if(isDefined(trigger.target)) {
    trigger._id_3EFE1B3A9EF1ABA0 = getEnt(trigger.target, "targetname");
    trigger._id_3EFE1B3A9EF1ABA0._id_281086936687228A = trigger;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  thread _id_5A24696121258749(trigger);
  thread _id_05C878EDA6A14E49(trigger);
}

_id_05C878EDA6A14E49(trigger) {
  level endon("game_ended");
  trigger notify("watchmovementTriggerTriggerEnter");
  trigger endon("watchmovementTriggerTriggerEnter");
  trigger endon("death");

  for(;;) {
    trigger waittill("trigger", ent);

    if(isPlayer(ent) && isDefined(ent.c130)) {
      continue;
    }
    if(!_id_5D67F66EE32FFAF8(trigger, ent)) {
      continue;
    }
    if(!_id_77DECE9A1B84CD8A(ent)) {
      continue;
    }
    _id_6BF7D3E9A6D1B183(trigger, ent);
  }
}

_id_5A24696121258749(trigger) {
  level endon("game_ended");
  trigger notify("watchmovementTriggerTriggerExit");
  trigger endon("watchmovementTriggerTriggerExit");
  trigger endon("death");

  for(;;) {
    _id_5C397C9CF7A06802 = trigger.entstouching;

    foreach(id, ent in _id_5C397C9CF7A06802) {
      if(!isDefined(ent))
        trigger.entstouching[id] = undefined;

      if(isDefined(ent) && !trigger istouching(ent))
        _id_7D18304AE5611CE9(trigger, ent);
    }

    waitframe();
  }
}

_id_6BF7D3E9A6D1B183(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }
  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent._id_09A1BDB96D46FBF5))
    ent._id_09A1BDB96D46FBF5 = [];

  _id_5C397C9CF7A06802 = [trigger];

  foreach(_id_7DC0E1C6207A7144 in ent._id_09A1BDB96D46FBF5)
  _id_5C397C9CF7A06802[_id_5C397C9CF7A06802.size] = _id_7DC0E1C6207A7144;

  ent._id_09A1BDB96D46FBF5 = _id_5C397C9CF7A06802;
  _id_65C16FD9E382BFA5(ent);
}

_id_7D18304AE5611CE9(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;

  if(isDefined(ent._id_38C28A5CC311C668))
    _id_CB19EE46FAA81F4E(ent);

  ent notify("clean_up_exit_threads");

  if(isDefined(ent._id_09A1BDB96D46FBF5)) {
    ent._id_09A1BDB96D46FBF5 = scripts\engine\utility::array_remove(ent._id_09A1BDB96D46FBF5, trigger);

    if(ent._id_09A1BDB96D46FBF5.size == 0)
      ent._id_09A1BDB96D46FBF5 = undefined;
  }
}

_id_4E5513E51C2DD30E(trigger) {
  trigger notify("watchmovementTriggerSuppressionTrigger");
  trigger endon("watchmovementTriggerSuppressionTrigger");
  trigger.entstouching = [];
  scripts\mp\flags::gameflagwait("prematch_done");
  thread _id_72432A14BA4FFD56(trigger);
  thread _id_F14070337C199F96(trigger);
}

_id_F14070337C199F96(trigger) {
  level endon("game_ended");
  trigger notify("watchmovementTriggerSupressionTriggerEnter");
  trigger endon("watchmovementTriggerSupressionTriggerEnter");
  trigger endon("death");

  for(;;) {
    trigger waittill("trigger", ent);

    if(!_id_77DECE9A1B84CD8A(ent)) {
      continue;
    }
    _id_7F94D7FD3ED90C14(trigger, ent);
  }
}

_id_72432A14BA4FFD56(trigger) {
  level endon("game_ended");
  trigger notify("watchmovementTriggerSuppressionTriggerExit");
  trigger endon("watchmovementTriggerSuppressionTriggerExit");
  trigger endon("death");

  for(;;) {
    _id_5C397C9CF7A06802 = trigger.entstouching;

    if(isDefined(_id_5C397C9CF7A06802)) {
      foreach(id, ent in _id_5C397C9CF7A06802) {
        if(!isDefined(ent))
          trigger.entstouching[id] = undefined;

        if(isDefined(ent) && !trigger istouching(ent))
          _id_AAEC10F2ED573950(trigger, ent);
      }
    }

    waitframe();
  }
}

_id_7F94D7FD3ED90C14(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }
  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent._id_7BA5C84EB36C67FE))
    ent._id_7BA5C84EB36C67FE = [];

  _id_5C397C9CF7A06802 = [trigger];

  foreach(_id_733B07B3A5D133F1 in ent._id_7BA5C84EB36C67FE)
  _id_5C397C9CF7A06802[_id_5C397C9CF7A06802.size] = _id_733B07B3A5D133F1;

  ent._id_7BA5C84EB36C67FE = _id_5C397C9CF7A06802;
  _id_B3F8ECF3B39399B7(ent);
}

_id_AAEC10F2ED573950(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;
  ent._id_7BA5C84EB36C67FE[trigger getentitynumber()] = undefined;

  if(ent._id_7BA5C84EB36C67FE.size == 0)
    ent._id_7BA5C84EB36C67FE = undefined;

  _id_DA29A8F49C0535BC(ent);
}

_id_5D67F66EE32FFAF8(trigger, ent) {
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

_id_77DECE9A1B84CD8A(ent) {
  if(isDefined(ent)) {
    if(isPlayer(ent) || isagent(ent)) {
      if(ent scripts\cp_mp\utility\player_utility::_isalive())
        return 1;
    }

    if(isDefined(ent._id_C7146296A3FD5B15)) {
      if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        if(!istrue(ent.isdestroyed))
          return 1;
      }

      if(isDefined(ent.streakinfo) && _id_DC7129967CA14621(ent.streakinfo.streakname))
        return 1;
    }
  }

  return 0;
}

_id_D7C5841BA3C7F86A() {
  struct = level._id_2060ABFE0097AA70;

  if(!isDefined(struct)) {
    struct = spawnStruct();
    struct.entercallbacks = [];
    struct.exitcallbacks = [];
    struct.outoftimecallbacks = [];
    struct.clearcallbacks = [];
    level._id_2060ABFE0097AA70 = struct;
  }

  return struct;
}

_id_DC7129967CA14621(streakname) {
  _id_0826F8E79D9FB33F = 0;

  switch (streakname) {
    case "pac_sentry":
    case "radar_drone_recon":
      _id_0826F8E79D9FB33F = 1;
      break;
  }

  return _id_0826F8E79D9FB33F;
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
      return _id_44D732A7AFEBF0DB(triggertype);
  }

  return undefined;
}

_id_44D732A7AFEBF0DB(triggertype) {
  switch (triggertype) {
    case "restricted":
    case "minefield":
    case "br":
    case "default":
      return _id_49DA3B35CC6BBB23();
  }

  return undefined;
}

_id_49DA3B35CC6BBB23() {
  _id_35C02D7C9763F4E1 = level._id_35C02D7C9763F4E1;

  if(!isDefined(_id_35C02D7C9763F4E1)) {
    _id_35C02D7C9763F4E1 = max(0, getdvarfloat("dvar_433957B265BB0FAB", 3));
    level._id_35C02D7C9763F4E1 = _id_35C02D7C9763F4E1;
  }

  return _id_35C02D7C9763F4E1;
}

_id_3FC7E9CFAAC73FDA(ent) {
  if(isDefined(ent._id_09A1BDB96D46FBF5))
    return ent._id_09A1BDB96D46FBF5[0];

  return undefined;
}

previouslytouchedtriggertype(_id_7EDFACE381884CA9, _id_D9D739B40FEDD346) {
  _id_1B99BB6CC4AEC0FE = 0;

  if(isDefined(_id_7EDFACE381884CA9._id_CC69DADA300D6DCC)) {
    _id_F4A7B9FD1E2F84F0 = _id_7EDFACE381884CA9._id_CC69DADA300D6DCC;

    if(_id_D9D739B40FEDD346 == _id_F4A7B9FD1E2F84F0)
      _id_1B99BB6CC4AEC0FE = 1;
    else if((_id_D9D739B40FEDD346 == "default" || _id_D9D739B40FEDD346 == "minefield") && (_id_F4A7B9FD1E2F84F0 == "default" || _id_F4A7B9FD1E2F84F0 == "minefield"))
      _id_1B99BB6CC4AEC0FE = 1;
  }

  return _id_1B99BB6CC4AEC0FE;
}

_id_86AFCFB8EB7BF0D2(trigger) {}

_id_D55ED59C0CE164D3() {}

_id_5E7912079314D79A() {
  level endon("game_ended");
  self notify("movementChangeRequests");
  self endon("movementChangeRequests");
  self endon("disconnect");
  self._id_3F62A078D28C12E3 = [];

  for(;;) {
    self waittill("movement_speed_update_request", _id_19AE4118816007E7, _id_8D04A2D6273459EB, _id_BBBA777ADF94982F);

    if(istrue(_id_BBBA777ADF94982F)) {
      _id_519BED5012F1C015::_id_36D589DC5C4191F6();
      continue;
    }

    if(!isDefined(_id_19AE4118816007E7)) {
      if(!isDefined(_id_19AE4118816007E7))
        continue;
    }

    _id_74DA84EAC189E996 = _id_19AE4118816007E7.script_noteworthy;

    if(!_id_1F20F0A1BD74A167(_id_74DA84EAC189E996)) {
      _id_519BED5012F1C015::_id_36D589DC5C4191F6();
      continue;
    }

    if(scripts\engine\utility::array_contains(self._id_3F62A078D28C12E3, _id_74DA84EAC189E996)) {
      continue;
    }
    self._id_3F62A078D28C12E3 = scripts\engine\utility::array_add(self._id_3F62A078D28C12E3, _id_74DA84EAC189E996);

    if(isDefined(_id_19AE4118816007E7.script_count)) {
      _id_519BED5012F1C015::_id_36D589DC5C4191F6(_id_74DA84EAC189E996, _id_19AE4118816007E7.script_count);
      continue;
    }

    _id_519BED5012F1C015::_id_36D589DC5C4191F6(_id_74DA84EAC189E996);
  }
}

_id_1F20F0A1BD74A167(_id_74DA84EAC189E996) {
  if(!isDefined(_id_74DA84EAC189E996))
    return 0;

  if(!scripts\engine\utility::array_contains(level._id_8D330DFEC4A5260F, _id_74DA84EAC189E996))
    return 0;

  return 1;
}

_id_04ACA25CBF5674E7() {
  return getdvarint("dvar_8A5DBCCAA1343D42", 0) != 0;
}