/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_outofbounds.gsc
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

  if(ent.oob == 1) {
    if(!isDefined(ent.oobimmunity) || ent.oobimmunity <= 0)
      onenteroob(ent);
  }
}

disableoob(ent) {
  ent.oob--;

  if(ent.oob == 0) {
    ent.oob = undefined;

    if(!isDefined(ent.oobimmunity) || ent.oobimmunity <= 0)
      onexitoob(ent, 0);
  }
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

initoob() {
  if(!isDefined(level.outofboundstriggers))
    level.outofboundstriggers = [];

  outofboundstriggers = getEntArray("OutOfBounds", "targetname");

  foreach(trigger in outofboundstriggers)
  level.outofboundstriggers[level.outofboundstriggers.size] = trigger;

  _id_3B64EB40368C1450::_id_2D6E7E0B80767910("enterOOB", ["killstreaks", "supers"]);
  thread watchoobtriggers();
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

add_trigger_to_oob_system(trigger) {
  if(isDefined(level.outofboundstriggers))
    level.outofboundstriggers[level.outofboundstriggers.size] = trigger;
  else
    level.outofboundstriggers[0] = trigger;

  thread watchoobtrigger(trigger);
}

onenteroob(ent) {
  if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isDefined(ent.streakinfo)) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ent);

    foreach(_id_F85572CD5F6117C6 in occupants)
    onenteroobtrigger(self, _id_F85572CD5F6117C6);
  }

  _id_2D2D28B1528166D2 = undefined;
  trigger = getlastoobtrigger(ent);

  if(!isDefined(trigger))
    trigger = self;

  triggertype = gettriggertype(ent, trigger);

  if(isPlayer(ent))
    _id_2D2D28B1528166D2 = ::playerentercallback;
  else if(isDefined(ent.oobref)) {
    struct = getoobdata();
    _id_2D2D28B1528166D2 = struct.entercallbacks[ent.oobref];
  }

  ent notify("oob_cooldown_end");

  if(isDefined(ent.oobtimeleft) && previouslytouchedtriggertype(ent, triggertype)) {
    outofboundstime = ent.oobtimeleft / 1000;
    ent.oobendtime = int(gettime() + ent.oobtimeleft);
    ent.oobtimeleft = undefined;
    thread watchooboutoftime(ent, outofboundstime);
  } else {
    ent.oobtimeleft = undefined;
    ent.oobtriggertype = triggertype;
    outofboundstime = getoutofboundstime(triggertype);
    ent.oobendtime = int(gettime() + outofboundstime * 1000);
    thread watchooboutoftime(ent, outofboundstime);
  }

  if(isDefined(_id_2D2D28B1528166D2))
    ent thread[[_id_2D2D28B1528166D2]]("exit_oob", "clear_oob", triggertype);
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

onexitoob(ent, _id_FCEF8D217A441961, _id_704294F906FAD67E) {
  if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isDefined(ent.streakinfo)) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ent);

    foreach(_id_F85572CD5F6117C6 in occupants)
    onexitoobtrigger(self, _id_F85572CD5F6117C6);
  }

  ent notify("exit_oob");
  _id_6166EC335950C5F2 = undefined;

  if(isPlayer(ent))
    _id_6166EC335950C5F2 = ::playerexitcallback;
  else if(isDefined(ent.oobref)) {
    struct = getoobdata();
    _id_6166EC335950C5F2 = struct.exitcallbacks[ent.oobref];
  }

  ent notify("oob_timeout_end");

  if(!istrue(_id_704294F906FAD67E)) {
    if(isDefined(ent.oobendtime)) {
      ent.oobtimeleft = int(max(0, ent.oobendtime - gettime()));
      ent.oobendtime = undefined;
      trigger = getlastoobtrigger(ent);
      triggertype = gettriggertype(ent, trigger);
      cooldowntime = getcooldowntime(triggertype);
      thread watchoobcooldown(ent, cooldowntime);
    }
  }

  if(isDefined(_id_6166EC335950C5F2))
    ent thread[[_id_6166EC335950C5F2]](_id_FCEF8D217A441961, _id_704294F906FAD67E, "clear_oob");
}

onooboutoftime(ent) {
  _id_106B10573BDEADF0 = undefined;

  if(isDefined(ent.vehicle))
    ent.vehicle scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_outoftimecallback("oob_timeout_end", "clear_oob");
  else if(isDefined(ent.oobref)) {
    struct = getoobdata();
    _id_106B10573BDEADF0 = struct.outoftimecallbacks[ent.oobref];
  } else if(isPlayer(ent))
    _id_106B10573BDEADF0 = ::playeroutoftimecallback;

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
  _id_49E84EC5D8AA4F0A = 1;
  self._id_4A3CC04781D25C6F = _id_49E84EC5D8AA4F0A;
  self setclientomnvar("ui_out_of_bounds_type", _id_49E84EC5D8AA4F0A);
  self setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("enterOOB", 0);
}

playerexitcallback(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353) {
  self setclientomnvar("ui_out_of_bounds_type", 0);
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
  _id_3B64EB40368C1450::_id_588F2307A3040610("enterOOB");
}

playeroutoftimecallback(_id_2F57CFAE824CA728, _id_93F5DB7E81311353) {
  trigger = getlastoobtrigger(self);
  triggertype = gettriggertype(self, trigger);

  if(triggertype == "minefield")
    thread playeroutoftimeminefield(_id_2F57CFAE824CA728, _id_93F5DB7E81311353);
  else {
    self.oob = 1;
    self.shouldskiplaststand = 1;
    self dodamage(self.health + 100, self.origin);
  }
}

playerclearcallback(_id_93F5DB7E81311353) {
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

  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  mine setscriptablepartstate("explosion", "on", 0);
  self.shouldskiplaststand = 1;
  self dodamage(2000, self.origin, self, self, "MOD_EXPLOSIVE", "minefield_mp");
  return 1;
}

killstreakentercallback(_id_44E306D53285E1F8, _id_93F5DB7E81311353) {
  if(isDefined(self.owner))
    self.owner setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
}

killstreakexitcallback(_id_FCEF8D217A441961, _id_704294F906FAD67E, _id_93F5DB7E81311353) {
  if(isDefined(self.owner))
    self.owner setclientomnvar("ui_out_of_bounds_countdown", 0);
}

killstreakoutoftimecallback(_id_2F57CFAE824CA728, _id_93F5DB7E81311353) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "doDamageToKillstreak"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "doDamageToKillstreak")]](10000, self.owner, self, self.team, self.origin, "MOD_EXPLOSIVE", "nuke_multi_mp");
}

killstreakclearcallback() {
  if(isDefined(self.owner))
    self.owner setclientomnvar("ui_out_of_bounds_countdown", 0);
}

killstreakregisteroobcallbacks() {
  registeroobentercallback("killstreak", ::killstreakentercallback);
  registeroobexitcallback("killstreak", ::killstreakexitcallback);
  registerooboutoftimecallback("killstreak", ::killstreakoutoftimecallback);
  registeroobclearcallback("killstreak", ::killstreakclearcallback);
}

watchoobtriggers() {
  if(isDefined(level.outofboundstriggers)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.outofboundstriggers.size; _id_AC0E594AC96AA3A8++)
      thread watchoobtrigger(level.outofboundstriggers[_id_AC0E594AC96AA3A8]);

    if(isDefined(level.outofboundstriggerpatches)) {
      foreach(trigger in level.outofboundstriggerpatches)
      thread watchoobsuppressiontrigger(trigger);
    }
  }
}

watchoobtrigger(trigger) {
  trigger.entstouching = [];
  thread watchoobtriggerexit(trigger);
  thread watchoobtriggerenter(trigger);
}

watchoobtriggerenter(trigger) {
  level endon("game_ended");
  trigger endon("death");

  for(;;) {
    trigger waittill("trigger", ent);
    playerent = ent;

    if(istrue(level._id_C3DA524E90FA9FB4)) {
      wait 1;
      continue;
    }

    if(isPlayer(ent)) {
      if(isDefined(ent.c130))
        continue;
    }

    if(isDefined(ent.vehiclename) && ent.vehiclename == "cruise_predator") {
      if(gettime() < ent.birthtime + 5000)
        continue;
    }

    if(isDefined(trigger.script_team)) {
      _id_5AF6B346CD92A66B = 0;

      if(ent scripts\cp_mp\vehicles\vehicle::isvehicle())
        _id_5AF6B346CD92A66B = 1;

      if(_id_5AF6B346CD92A66B && isDefined(ent.owner) && ent.owner.team != trigger.script_team) {
        continue;
      }
      if(!_id_5AF6B346CD92A66B && ent.team != trigger.script_team)
        continue;
    }

    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(ent.owner))
      playerent = ent.owner;

    if(!interactswithoobtriggers(playerent)) {
      continue;
    }
    onenteroobtrigger(trigger, playerent);
  }
}

watchoobtriggerexit(trigger) {
  level endon("game_ended");
  trigger endon("death");

  for(;;) {
    _id_5C397C9CF7A06802 = trigger.entstouching;

    foreach(id, ent in _id_5C397C9CF7A06802) {
      if(!isDefined(ent))
        trigger.entstouching[id] = undefined;

      if(isDefined(ent) && !trigger istouching(ent))
        onexitoobtrigger(trigger, ent);
    }

    waitframe();
  }
}

onenteroobtrigger(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }
  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent.oobtriggers))
    ent.oobtriggers = [];

  _id_5C397C9CF7A06802 = [trigger];

  foreach(_id_70E9548D1E3EA919 in ent.oobtriggers)
  _id_5C397C9CF7A06802[_id_5C397C9CF7A06802.size] = _id_70E9548D1E3EA919;

  ent.oobtriggers = _id_5C397C9CF7A06802;
  enableoob(ent);
}

onexitoobtrigger(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;
  disableoob(ent);
  ent.oobtriggers = scripts\engine\utility::array_remove(ent.oobtriggers, trigger);

  if(ent.oobtriggers.size == 0)
    ent.oobtriggers = undefined;
}

watchoobsuppressiontrigger(trigger) {
  trigger.entstouching = [];
  wait 10;
  thread watchoobsuppressiontriggerexit();
  thread watchoobsupressiontriggerenter();
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

    foreach(id, ent in _id_5C397C9CF7A06802) {
      if(!isDefined(ent))
        trigger.entstouching[id] = undefined;

      if(!trigger istouching(ent))
        onexitoobsupressiontrigger(trigger, ent);
    }
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

  ent.oobsupressiontriggers[trigger getentitynumber()] = trigger;
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

interactswithoobtriggers(ent) {
  if(isDefined(ent)) {
    if(isPlayer(ent)) {
      if(ent scripts\cp_mp\utility\player_utility::_isalive())
        return 1;
    }

    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      if(istrue(ent.oobimmunity))
        return 0;
      else if(isDefined(ent.owner) && isPlayer(ent.owner)) {
        if(ent.owner scripts\cp_mp\utility\player_utility::_isalive())
          return 1;
      }
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
    case "pac_sentry":
    case "radar_drone_recon":
      _id_60F0EEDDE53BB451 = 1;
      break;
  }

  return _id_60F0EEDDE53BB451;
}

gettriggertype(ent, trigger) {
  triggertype = "default";

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
    case "minefield":
      return getmaxoutofboundscooldown();
    case "default":
      return getmaxoutofboundscooldown();
  }

  return undefined;
}

getoutofboundstime(triggertype) {
  switch (triggertype) {
    case "minefield":
      return getmaxoutofboundsminefieldtime();
    case "default":
      return getmaxoutofboundstime();
  }

  return undefined;
}

getlastoobtrigger(ent) {
  if(isDefined(ent.oobtriggers))
    return ent.oobtriggers[0];

  return undefined;
}

getmaxoutofboundstime() {
  outofboundstime = level.outofboundstime;

  if(!isDefined(outofboundstime)) {
    outofboundstime = max(0, getdvarfloat("dvar_B773758221A0C100", 15));
    level.outofboundstime = outofboundstime;
  }

  return outofboundstime;
}

getmaxoutofboundscooldown() {
  outofboundscooldown = level.outofboundscooldown;

  if(!isDefined(outofboundscooldown)) {
    outofboundscooldown = max(0, getdvarfloat("dvar_1E90A42100FF3964", 3));
    level.outofboundscooldown = outofboundscooldown;
  }

  return outofboundscooldown;
}

getmaxoutofboundsminefieldtime() {
  outofboundstimeminefield = level.outofboundstimeminefield;

  if(!isDefined(outofboundstimeminefield)) {
    outofboundstimeminefield = max(0, getdvarfloat("dvar_E4BB2AF9293410E5", 10));
    level.outofboundstimeminefield = outofboundstimeminefield;
  }

  return outofboundstimeminefield;
}

_id_34DB328BAED4337E(_id_E3108E412AFB3811) {
  level._id_C3DA524E90FA9FB4 = !_id_E3108E412AFB3811;
}