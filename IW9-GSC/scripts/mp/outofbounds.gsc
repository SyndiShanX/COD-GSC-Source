/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\outofbounds.gsc
***********************************************/

registerentforoob(ent, ref) {
  ent.oobref = ref;
}

deregisterentforoob(ent) {
  ent.oobref = undefined;
}

registeroobentercallback(ref, callback) {
  struct = getoobdata();
  struct.entercallbacks[ref] = callback;
}

registeroobexitcallback(ref, callback) {
  struct = getoobdata();
  struct.exitcallbacks[ref] = callback;
}

registerooboutoftimecallback(ref, callback) {
  struct = getoobdata();
  struct.outoftimecallbacks[ref] = callback;
}

registeroobclearcallback(ref, callback) {
  struct = getoobdata();
  struct.clearcallbacks[ref] = callback;
}

isoob(ent, _id_3E36F415F762070E) {
  if(isoobimmune(ent))
    return 0;

  if(istrue(_id_3E36F415F762070E) && isoobimmune(ent))
    return 0;

  return isDefined(ent.oob) && ent.oob > 0;
}

enableoob(ent) {
  if(!isDefined(ent.oob))
    ent.oob = 0;

  ent.oob++;

  if(!isDefined(ent.oobimmunity) || ent.oobimmunity <= 0)
    onenteroob(ent);

  if(isDefined(ent._id_076B2C48898593E9))
    [[ent._id_076B2C48898593E9]](ent);
}

disableoob(ent) {
  if(!isDefined(ent.oob)) {
    return;
  }
  ent.oob--;

  if(ent.oob == 0)
    ent.oob = undefined;

  if(!isDefined(ent.oobimmunity) || ent.oobimmunity <= 0)
    onexitoob(ent, 0);
}

isoobimmune(ent) {
  return isDefined(ent.oobimmunity) && ent.oobimmunity > 0;
}

enableoobimmunity(ent) {
  if(!isDefined(ent.oobimmunity))
    ent.oobimmunity = 0;

  ent.oobimmunity++;

  if(ent.oobimmunity == 1) {
    if(isDefined(ent.oob) && ent.oob > 0)
      onexitoob(ent, 0);
  }
}

disableoobimmunity(ent) {
  ent.oobimmunity--;

  if(ent.oobimmunity == 0) {
    ent.oobimmunity = undefined;

    if(isDefined(ent.oob) && ent.oob > 0)
      onenteroob(ent);
  }
}

clearoob(ent, _id_FCEF8D217A441961) {
  ent notify("clear_oob");

  if(isoob(ent, 1))
    onexitoob(ent, _id_FCEF8D217A441961, 1);

  _id_A92C68F274CD0239 = undefined;

  if(isPlayer(ent))
    _id_A92C68F274CD0239 = ::playerclearcallback;
  else if(isDefined(ent.oobref)) {
    struct = getoobdata();
    _id_A92C68F274CD0239 = struct.clearcallbacks[ent.oobref];
  }

  if(isDefined(_id_A92C68F274CD0239))
    ent[[_id_A92C68F274CD0239]]();

  ent.oobref = undefined;
  ent.oob = undefined;
  ent.oobimmunity = undefined;
  ent.oobtimeleft = undefined;
  ent.oobendtime = undefined;
  ent.oobtriggertype = undefined;
  ent._id_4A3CC04781D25C6F = undefined;

  if(isDefined(ent.oobtriggers)) {
    foreach(trigger in ent.oobtriggers)
    trigger.entstouching[ent getentitynumber()] = undefined;

    ent.oobtriggers = undefined;
  }

  if(isDefined(ent.oobsupressiontriggers)) {
    foreach(trigger in ent.oobsupressiontriggers)
    trigger.entstouching[ent getentitynumber()] = undefined;

    ent.oobsupressiontriggers = undefined;
  }
}

istouchingoobtrigger() {
  if(istrue(self.allowedintrigger))
    return 0;

  if(!isDefined(level.outofboundstriggers))
    return 0;

  foreach(trigger in level.outofboundstriggers) {
    if(!interactswithgivenoobtrigger(trigger, self)) {
      continue;
    }
    if(self istouching(trigger))
      return 1;
  }

  return 0;
}

ispointinoutofbounds(_id_863C619037F3AC74, _id_DA8CEC9BCE12F9CB) {
  _id_E448B9771980DFD6 = 0;

  if(!isDefined(level.outofboundstriggers))
    return _id_E448B9771980DFD6;
  else {
    foreach(trigger in level.outofboundstriggers) {
      if(ispointinvolume(_id_863C619037F3AC74, trigger)) {
        if(isDefined(trigger.script_team) && isDefined(_id_DA8CEC9BCE12F9CB) && trigger.script_team != _id_DA8CEC9BCE12F9CB)
          continue;
        else {
          _id_E448B9771980DFD6 = 1;
          break;
        }
      }
    }
  }

  return _id_E448B9771980DFD6;
}

initoob() {
  thread watchoobtriggers();
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("enterOOB", ["killstreaks", "supers"]);
}

onenteroob(ent) {
  _id_AADBC2B08CD0C218 = [];
  trigger = self;

  if(!isDefined(trigger))
    trigger = self;

  triggertype = gettriggertype(ent, trigger);

  if(isPlayer(ent))
    _id_AADBC2B08CD0C218[_id_AADBC2B08CD0C218.size] = ::playerentercallback;

  if(isDefined(ent.oobref)) {
    struct = getoobdata();
    _id_AADBC2B08CD0C218[_id_AADBC2B08CD0C218.size] = struct.entercallbacks[ent.oobref];
  }

  ent notify("oob_cooldown_end");

  if(isDefined(ent.oobtimeleft) && previouslytouchedtriggertype(ent, triggertype) && !isDefined(ent.vehicle)) {
    outofboundstime = ent.oobtimeleft / 1000;
    ent.oobendtime = int(gettime() + ent.oobtimeleft);
    ent.oobtimeleft = undefined;
    thread watchooboutoftime(ent, outofboundstime);
  } else {
    outofboundstime = getoutofboundstime(triggertype);

    if(isPlayer(ent) && isDefined(ent.vehicle) && isDefined(ent.vehicle.oobendtime))
      outofboundstime = (ent.vehicle.oobendtime - gettime()) / 1000;
    else if(isDefined(ent.oobtimeleft))
      outofboundstime = min(ent.oobtimeleft / 1000, outofboundstime);
    else if(isDefined(ent.oobendtime))
      outofboundstime = min((ent.oobendtime - gettime()) / 1000, outofboundstime);

    ent.oobtimeleft = undefined;
    ent.oobtriggertype = triggertype;
    ent.oobendtime = int(gettime() + outofboundstime * 1000);
    thread watchooboutoftime(ent, outofboundstime);
  }

  foreach(_id_CE174178F5680DFC in _id_AADBC2B08CD0C218) {
    if(isDefined(_id_CE174178F5680DFC))
      ent thread[[_id_CE174178F5680DFC]]("exit_oob", "clear_oob", triggertype);
  }

  if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isDefined(ent.streakinfo)) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ent);

    foreach(_id_F85572CD5F6117C6 in occupants)
    onenteroobtrigger(self, _id_F85572CD5F6117C6);
  }
}

onexitoob(ent, _id_FCEF8D217A441961, _id_704294F906FAD67E) {
  trigger = self;
  ent notify("exit_oob");
  _id_6166EC335950C5F2 = undefined;

  if(!isDefined(ent.oob)) {
    ent notify("oob_timeout_end");

    if(isPlayer(ent))
      _id_6166EC335950C5F2 = ::playerexitcallback;
    else if(isDefined(ent.oobref)) {
      struct = getoobdata();
      _id_6166EC335950C5F2 = struct.exitcallbacks[ent.oobref];
    }

    if(!istrue(_id_704294F906FAD67E)) {
      if(isDefined(ent.oobendtime)) {
        ent.oobtimeleft = int(max(0, ent.oobendtime - gettime()));
        ent.oobendtime = undefined;
        triggertype = gettriggertype(ent, trigger);
        cooldowntime = getcooldowntime(triggertype);
        thread watchoobcooldown(ent, cooldowntime);
      }
    }
  }

  if(isDefined(_id_6166EC335950C5F2))
    ent thread[[_id_6166EC335950C5F2]](_id_FCEF8D217A441961, _id_704294F906FAD67E, "clear_oob");

  if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isDefined(ent.streakinfo)) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ent);

    foreach(_id_F85572CD5F6117C6 in occupants) {
      if(isDefined(_id_F85572CD5F6117C6))
        onexitoobtrigger(trigger, _id_F85572CD5F6117C6);
    }
  }
}

onooboutoftime(ent) {
  _id_106B10573BDEADF0 = undefined;

  if(isPlayer(ent)) {
    _id_775C9A68F9C00019 = 1;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      if(istrue(level.infilcinematicactive))
        _id_775C9A68F9C00019 = 0;
      else if(isDefined(level.matchcountdowntime) && level.matchcountdowntime < 2)
        _id_775C9A68F9C00019 = 0;
    }

    if(_id_775C9A68F9C00019)
      _id_106B10573BDEADF0 = ::playeroutoftimecallback;
  } else if(isDefined(ent.oobref)) {
    struct = getoobdata();
    _id_106B10573BDEADF0 = struct.outoftimecallbacks[ent.oobref];
  }

  if(isDefined(_id_106B10573BDEADF0))
    ent thread[[_id_106B10573BDEADF0]]("oob_timeout_end", "clear_oob");
}

watchooboutoftime(ent, _id_8DD9F2EB8215A139) {
  if(isPlayer(ent))
    ent endon("death_or_disconnect");
  else
    ent endon("death");

  ent notify("oob_timeout_end");
  ent endon("oob_timeout_end");
  ent endon("clear_oob");
  wait(_id_8DD9F2EB8215A139);
  thread onooboutoftime(ent);
}

watchoobcooldown(ent, _id_8DD9F2EB8215A139) {
  if(isPlayer(ent))
    ent endon("death_or_disconnect");
  else
    ent endon("death");

  ent notify("oob_cooldown_end");
  ent endon("oob_cooldown_end");
  ent endon("clear_oob");
  wait(_id_8DD9F2EB8215A139);
  ent.oobtimeleft = undefined;
  ent.oobtriggertype = undefined;
}

playerentercallback(_id_44E306D53285E1F8, _id_93F5DB7E81311353, triggertype) {
  _id_49E84EC5D8AA4F0A = _id_0C6AA39A55C49DC1(triggertype);
  self._id_4A3CC04781D25C6F = _id_49E84EC5D8AA4F0A;
  self setclientomnvar("ui_out_of_bounds_type", _id_49E84EC5D8AA4F0A);
  self setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("enterOOB", 0);

  if(!isDefined(self.vehicle))
    thread _id_39C5BD55494A224B();
}

playerexitcallback(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353) {
  self setclientomnvar("ui_out_of_bounds_type", 0);
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
  _id_3B64EB40368C1450::_id_588F2307A3040610("enterOOB");

  if(istrue(self._id_0F9B51BE13B8DEFC))
    self._id_0F9B51BE13B8DEFC = undefined;
}

playeroutoftimecallback(_id_2F57CFAE824CA728, _id_93F5DB7E81311353) {
  trigger = getlastoobtrigger(self);
  triggertype = gettriggertype(self, trigger);

  if(triggertype == "minefield")
    thread playeroutoftimeminefield(_id_2F57CFAE824CA728, _id_93F5DB7E81311353);
  else {
    self._id_93532EA94ACCABDB = 1;
    scripts\mp\utility\damage::_suicide(undefined, 1);
    self._id_93532EA94ACCABDB = undefined;
  }
}

playerclearcallback(_id_93F5DB7E81311353) {
  self setclientomnvar("ui_out_of_bounds_type", 0);
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
}

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

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  mine setscriptablepartstate("explosion", "on", 0);
  wait 0.05;
  self dodamage(2000, self.origin, self, mine, "MOD_EXPLOSIVE", "minefield_mp");
  return 1;
}

_id_39C5BD55494A224B() {
  self endon("death_or_disconnect");
  self endon("exit_oob");
  self waittill("vehicle_enter");

  if(isDefined(self.vehicle) && !scripts\common\vehicle::_id_A0F7306FC3C08ECF(self.vehicle, 1))
    self._id_0F9B51BE13B8DEFC = 1;
}

killstreakentercallback(_id_44E306D53285E1F8, _id_93F5DB7E81311353, triggertype) {
  _id_49E84EC5D8AA4F0A = _id_0C6AA39A55C49DC1(triggertype);
  self._id_4A3CC04781D25C6F = _id_49E84EC5D8AA4F0A;

  if(isDefined(self.owner) && istrue(self.ispiloted)) {
    self.owner setclientomnvar("ui_out_of_bounds_type", _id_49E84EC5D8AA4F0A);
    self.owner setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
  }
}

killstreakexitcallback(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353) {
  if(isDefined(self.owner) && istrue(self.ispiloted)) {
    self.owner setclientomnvar("ui_out_of_bounds_type", 0);
    self.owner setclientomnvar("ui_out_of_bounds_countdown", 0);
  }
}

killstreakoutoftimecallback(_id_2F57CFAE824CA728, _id_93F5DB7E81311353) {
  scripts\mp\utility\killstreak::dodamagetokillstreak(10000, self.owner, self, self.team, self.origin, "MOD_EXPLOSIVE", "nuke_multi_mp");
}

killstreakclearcallback() {
  if(isDefined(self.owner) && istrue(self.ispiloted)) {
    self.owner setclientomnvar("ui_out_of_bounds_type", 0);
    self.owner setclientomnvar("ui_out_of_bounds_countdown", 0);
  }
}

killstreakregisteroobcallbacks() {
  registeroobentercallback("killstreak", ::killstreakentercallback);
  registeroobexitcallback("killstreak", ::killstreakexitcallback);
  registerooboutoftimecallback("killstreak", ::killstreakoutoftimecallback);
  registeroobclearcallback("killstreak", ::killstreakclearcallback);
}

watchoobtriggers() {
  if(scripts\mp\utility\game::lpcfeaturegated() && !scripts\mp\utility\game_utility_mp::_id_9A2FD0D19774EDDE() && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  if(isDefined(level.outofboundstriggers)) {
    foreach(trigger in level.outofboundstriggers)
    thread watchoobtrigger(trigger);

    if(isDefined(level.outofboundstriggerpatches)) {
      foreach(trigger in level.outofboundstriggerpatches)
      thread watchoobsuppressiontrigger(trigger);
    }
  }
}

watchoobtrigger(trigger) {
  trigger.entstouching = [];

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    scripts\mp\flags::gameflagwait("prematch_done");

  thread watchoobtriggerexit(trigger);
  thread watchoobtriggerenter(trigger);
}

watchoobtriggerenter(trigger) {
  level endon("game_ended");

  for(;;) {
    trigger waittill("trigger", ent);

    if(isPlayer(ent) && isDefined(ent.c130)) {
      continue;
    }
    if(!interactswithgivenoobtrigger(trigger, ent)) {
      continue;
    }
    if(!interactswithoobtriggers(ent)) {
      continue;
    }
    onenteroobtrigger(trigger, ent);
  }
}

watchoobtriggerexit(trigger) {
  level endon("game_ended");
  _id_C30CD90A1A82D688 = isent(trigger);

  for(;;) {
    _id_5C397C9CF7A06802 = trigger.entstouching;

    foreach(id, ent in _id_5C397C9CF7A06802) {
      if(!isDefined(ent))
        trigger.entstouching[id] = undefined;

      if(isDefined(ent) && !trigger _id_E3C3BC95AF1159B8(ent, _id_C30CD90A1A82D688) && (!isDefined(ent.vehicle) || istrue(ent._id_0F9B51BE13B8DEFC)))
        onexitoobtrigger(trigger, ent);
    }

    waitframe();
  }
}

_id_E3C3BC95AF1159B8(ent, _id_994E7746ED176AEC) {
  return _id_994E7746ED176AEC && self istouching(ent) || !_id_994E7746ED176AEC && ispointinvolume(ent.origin, self);
}

onenteroobtrigger(trigger, ent, _id_E260297371D759C4) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum]) && !istrue(_id_E260297371D759C4)) {
    return;
  }
  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent.oobtriggers))
    ent.oobtriggers = [];

  _id_5C397C9CF7A06802 = [trigger];

  foreach(_id_70E9548D1E3EA919 in ent.oobtriggers)
  _id_5C397C9CF7A06802[_id_5C397C9CF7A06802.size] = _id_70E9548D1E3EA919;

  ent.oobtriggers = _id_5C397C9CF7A06802;
  trigger enableoob(ent);
}

onexitoobtrigger(trigger, ent) {
  if(!isDefined(ent)) {
    return;
  }
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;
  trigger disableoob(ent);
  ent.oobtriggers = scripts\engine\utility::array_remove(ent.oobtriggers, trigger);

  if(ent.oobtriggers.size == 0)
    ent.oobtriggers = undefined;
}

watchoobsuppressiontrigger(trigger) {
  trigger.entstouching = [];
  scripts\mp\flags::gameflagwait("prematch_done");
  thread watchoobsuppressiontriggerexit(trigger);
  thread watchoobsupressiontriggerenter(trigger);
}

watchoobsupressiontriggerenter(trigger) {
  level endon("game_ended");

  for(;;) {
    trigger waittill("trigger", ent);

    if(!interactswithoobtriggers(ent)) {
      continue;
    }
    onenteroobsuppressiontrigger(trigger, ent);
  }
}

watchoobsuppressiontriggerexit(trigger) {
  level endon("game_ended");

  for(;;) {
    _id_5C397C9CF7A06802 = trigger.entstouching;

    if(isDefined(_id_5C397C9CF7A06802)) {
      foreach(id, ent in _id_5C397C9CF7A06802) {
        if(!isDefined(ent))
          trigger.entstouching[id] = undefined;

        if(isDefined(ent) && !trigger istouching(ent))
          onexitoobsupressiontrigger(trigger, ent);
      }
    }

    waitframe();
  }
}

onenteroobsuppressiontrigger(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }
  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent.oobsupressiontriggers))
    ent.oobsupressiontriggers = [];

  _id_5C397C9CF7A06802 = [trigger];

  foreach(_id_90410C262793087E in ent.oobsupressiontriggers)
  _id_5C397C9CF7A06802[_id_5C397C9CF7A06802.size] = _id_90410C262793087E;

  ent.oobsupressiontriggers = _id_5C397C9CF7A06802;
  enableoobimmunity(ent);
}

onexitoobsupressiontrigger(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;
  ent.oobsupressiontriggers[trigger getentitynumber()] = undefined;

  if(ent.oobsupressiontriggers.size == 0)
    ent.oobsupressiontriggers = undefined;

  disableoobimmunity(ent);
}

interactswithgivenoobtrigger(trigger, ent) {
  isvehicle = ent scripts\cp_mp\vehicles\vehicle::isvehicle();

  if(isDefined(trigger.script_team)) {
    if(scripts\mp\utility\game::isgroundwarcoremode() || istrue(level._id_CBB6EC6B15529252))
      return 0;

    if(isvehicle) {
      if(isDefined(ent.team) && ent.team != "neutral" && ent.team != trigger.script_team)
        return 0;

      if(isDefined(ent.owner) && ent.owner.team != trigger.script_team)
        return 0;

      if(isDefined(ent.occupants)) {
        foreach(_id_F85572CD5F6117C6 in ent.occupants) {
          if(isDefined(_id_F85572CD5F6117C6.team) && _id_F85572CD5F6117C6.team != trigger.script_team)
            return 0;
        }
      }
    } else if(!isDefined(ent.team) || ent.team != trigger.script_team)
      return 0;
  }

  if(isvehicle) {
    ref = ent scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(ref, "interactsWithOOBTrigger") && ![[scripts\cp_mp\utility\script_utility::getsharedfunc(ref, "interactsWithOOBTrigger")]](trigger, ent))
      return 0;
  }

  if(isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == "onlyVehOOB") {
    if(!istrue(isvehicle))
      return 0;
  }

  return 1;
}

interactswithoobtriggers(ent) {
  if(isDefined(ent)) {
    if(isPlayer(ent)) {
      if(ent scripts\cp_mp\utility\player_utility::_isalive())
        return 1;
    }

    if(isDefined(ent.oobref)) {
      if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        if(!istrue(ent.isdestroyed))
          return 1;
      }

      if(isDefined(ent.streakinfo) && iskillstreakaffectedbyobb(ent.streakinfo.streakname))
        return 1;
    }
  }

  return 0;
}

getoobdata() {
  struct = level.oobdata;

  if(!isDefined(struct)) {
    struct = spawnStruct();
    struct.entercallbacks = [];
    struct.exitcallbacks = [];
    struct.outoftimecallbacks = [];
    struct.clearcallbacks = [];
    level.oobdata = struct;
  }

  return struct;
}

iskillstreakaffectedbyobb(streakname) {
  _id_60F0EEDDE53BB451 = 0;

  switch (streakname) {
    case "radar_drone_recon":
    case "pac_sentry":
    case "assault_drone":
      _id_60F0EEDDE53BB451 = 1;
      break;
  }

  return _id_60F0EEDDE53BB451;
}

gettriggertype(ent, trigger) {
  triggertype = "default";

  if(trigger scripts\cp_mp\vehicles\vehicle::isvehicle())
    return "vehicle";

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

_id_0C6AA39A55C49DC1(triggertype) {
  _id_4A3CC04781D25C6F = 1;
  _id_7C4A4F886922A011 = 0;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    gametype = scripts\mp\utility\game::getgametype();

    switch (gametype) {
      case "gwtdm":
      case "gwbomb":
      case "conflict":
      case "risk":
      case "arm":
        _id_7C4A4F886922A011 = 1;
        break;
    }

    if(scripts\mp\utility\game::isgroundwarcoremode())
      _id_7C4A4F886922A011 = 1;
  }

  if(istrue(_id_7C4A4F886922A011)) {
    if(isDefined(triggertype) && triggertype == "restricted")
      _id_4A3CC04781D25C6F = 2;
  }

  return _id_4A3CC04781D25C6F;
}

getcooldowntime(triggertype) {
  switch (triggertype) {
    case "restricted":
    case "minefield":
    case "br":
    case "vehicle":
    case "default":
      return scripts\mp\utility\game::getmaxoutofboundscooldown();
  }

  return undefined;
}

getoutofboundstime(triggertype) {
  switch (triggertype) {
    case "minefield":
      return scripts\mp\utility\game::getmaxoutofboundsminefieldtime();
    case "restricted":
      return scripts\mp\utility\game::getmaxoutofboundsrestrictedtime();
    case "br":
      return scripts\mp\utility\game::getmaxoutofboundsbrtime();
    case "default":
      return scripts\mp\utility\game::getmaxoutofboundstime();
    case "vehicle":
      return scripts\mp\utility\game::_id_A01D18A56C6CC1AA();
  }

  return undefined;
}

getlastoobtrigger(ent) {
  if(isDefined(ent.oobtriggers))
    return ent.oobtriggers[0];

  return undefined;
}

previouslytouchedtriggertype(_id_7EDFACE381884CA9, _id_D9D739B40FEDD346) {
  _id_1B99BB6CC4AEC0FE = 0;

  if(isDefined(_id_7EDFACE381884CA9.oobtriggertype)) {
    _id_F4A7B9FD1E2F84F0 = _id_7EDFACE381884CA9.oobtriggertype;

    if(_id_D9D739B40FEDD346 == _id_F4A7B9FD1E2F84F0)
      _id_1B99BB6CC4AEC0FE = 1;
    else if((_id_D9D739B40FEDD346 == "default" || _id_D9D739B40FEDD346 == "minefield") && (_id_F4A7B9FD1E2F84F0 == "default" || _id_F4A7B9FD1E2F84F0 == "minefield"))
      _id_1B99BB6CC4AEC0FE = 1;
  }

  return _id_1B99BB6CC4AEC0FE;
}

_id_420D6EDA841FD001(triggertype, origin, angles, radius, height, _id_2C40E29836434CBE) {
  trigger = spawn(triggertype, origin, 0, radius, height);
  trigger.angles = angles;
  level.outofboundstriggers[level.outofboundstriggers.size] = trigger;
}

_id_49F55AB317DA5250() {
  _id_2C40E29836434CBE = 0;
  _id_AFF10137FA371A53 = scripts\engine\utility::getStructArray("OutOfBounds", "targetname");

  if(isDefined(_id_AFF10137FA371A53)) {
    foreach(_id_102CB12A631DA712 in _id_AFF10137FA371A53)
    _id_420D6EDA841FD001("trigger_rotatable_radius", _id_102CB12A631DA712.origin, _id_102CB12A631DA712.angles, _id_102CB12A631DA712.radius, _id_102CB12A631DA712.height, _id_2C40E29836434CBE);
  }
}