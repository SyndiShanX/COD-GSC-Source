/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\asm.gsc
***********************************************/

#using scripts\anim\animselector;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace asm;

function function_c051a94f99bd65f1(asmname) {
  self asminstantiate(asmname);
  self.asmasset = undefined;
  self.animationarchetype = undefined;
}

function asm_getfunction(asmname, funcid) {
  assertex(isDefined(anim.asmfuncs[asmname]), "<dev string:x1c>" + asmname);
  assertex(isDefined(anim.asmfuncs[asmname][funcid]), "<dev string:x42>" + funcid + "<dev string:x5e>" + asmname);
  return anim.asmfuncs[asmname][funcid];
}

function asm_getgenerichandler() {
  return &asm_generichandler;
}

function asm_setupaim(asmname, statename, blendtime, use_5) {
  if(isDefined(self.fnasm_setupaim)) {
    self[[self.fnasm_setupaim]](asmname, statename, blendtime, use_5);
  }
}

function asm_settransitionorientmode(orient_mode) {
  if(!isai(self)) {
    return;
  }

  switch (orient_mode) {
    case #"hash_96a6a25bd7beed30":
      var_8e1451b5845405b1 = 1024;

      if(actor_is3d()) {
        orient_angles = self.angles;

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_8e1451b5845405b1) {
          orient_angles = self function_f134f30c17faeaf(self.node);
        }

        self orientmode("face angle 3d", orient_angles);
      } else {
        yaw = self.angles[1];

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_8e1451b5845405b1) {
          yaw = getnodeforwardyaw(self.node);
        }

        self orientmode("face angle", yaw);
      }

      break;
    case #"hash_579a1f64b8b40d31":
      self orientmode("face angle 3d", self.angles);
      break;
    default:
      self orientmode(orient_mode);
      break;
  }
}

function asm_settransitionanimmode(anim_mode) {
  if(isDefined(self.fnasm_setanimmode)) {
    self[[self.fnasm_setanimmode]](anim_mode);
    return;
  }

  self animmode(anim_mode, 0);
}

function asm_generichandler(handlername, asmname, param1, param2, param3) {
  switch (handlername) {
    case #"hash_fc8a71042f2cb15b":
      asm_setupaim(asmname, param1, 0.2, undefined);
      break;
    case #"hash_db521e4972a48a9d":
      customhandler = asm_getnotehandler(asmname, undefined);
      val = [[self.fnasm_handlenotetrack]](param2, param1, customhandler, undefined);

      if(!isDefined(val)) {
        val = asm_handlenewnotetracks(asmname, param2, param1);
      }

      if(isDefined(val) && !asm_eventfired(asmname, "end")) {
        asm_fireevent(asmname, "end");
      }

      break;
    default:
      assertmsg("<dev string:x6a>" + handlername);
      break;
  }
}

function asm_setoverrideparams(asmname, params) {
  assert(isDefined(anim.asmparams));
  assert(isDefined(anim.asmparams[asmname]));
  var_c237adaa8f06b26b = 9999;
  anim.asmparams[asmname][var_c237adaa8f06b26b] = params;
  return var_c237adaa8f06b26b;
}

function asm_globalinit() {
  if(isDefined(anim.asm)) {
    return;
  }

  anim.asm = [];
}

function asm_fireephemeralevent(eventtarget, eventname, params) {
  self asmfireephemeralevent(eventtarget, eventname, params);
}

function asm_init_blackboard() {
  if(isDefined(self._blackboard)) {
    return;
  }

  self._blackboard = self getaiblackboard();
  self._blackboard.bfire = 0;
}

function asm_terminateandreplace(newasmname, newarchetype) {
  self asmterminate();
  self clearaiblackboard();
  self._blackboard = undefined;
  self notify("asm_terminated");
  self.asmtrackasm = undefined;

  if(!isDefined(newarchetype)) {
    newarchetype = self.animsetname;
  }

  lowerasmname = tolower(newasmname);
  asm_init_blackboard();
  self[[self.fnasm_init]](lowerasmname, newarchetype);
  self.defaultasm = lowerasmname;
}

function asm_getnotehandler(asmname, statename) {
  noteid = self asmgetnotehandler(asmname);

  if(!isDefined(noteid)) {
    return undefined;
  }

  if(isint(noteid)) {
    if(noteid != -1) {
      return anim.asmfuncs[asmname][noteid];
    }

    return undefined;
  }

  return noteid;
}

function asm_currentstatehasflag(asmname, flagname) {
  if(istrue(self.asmforcetrackloop)) {
    return 1;
  }

  return self asmcurrentstatehasflag(asmname, flagname);
}

function asm_fireevent_internal(asmname, eventname, params) {
  self asmfireevent(asmname, eventname, params);
}

function asm_fireevent(asmname, eventname, params) {
  asm_fireevent_internal(asmname, eventname, params);

  if(eventname == "anim_will_finish" || eventname == "finish") {
    eventname = "end";
    asm_fireevent_internal(asmname, eventname);
  }
}

function asm_ephemeraleventfired(eventtarget, eventname, var_bd6b21f67400a4) {
  bfired = self asmephemeraleventfired(eventtarget, eventname);

  if(bfired) {
    return true;
  }

  return false;
}

function asm_eventfiredrecently(asmname, eventname) {
  return self asmeventfiredwithin(asmname, eventname, 50);
}

function asm_geteventtime(asmname, eventname) {
  return self asmgeteventtime(asmname, eventname);
}

function asm_geteventdata(asmname, eventname) {
  return self asmgeteventdata(asmname, eventname);
}

function asm_getephemeraleventdata(eventtarget, eventname) {
  return self asmgetephemeraleventdata(eventtarget, eventname);
}

function asm_clearallephemeralevents() {
  self asmclearephemeralevents();
}

function asm_shouldpowerdown(asmname, currentstate) {
  if(!isDefined(self.bpowerdown) || !self.bpowerdown) {
    return false;
  }

  if(isDefined(self.asm.bpowereddown) && self.asm.bpowereddown) {
    return false;
  }

  if(!isalive(self)) {
    return false;
  }

  if(bb_isanimScripted()) {
    return false;
  }

  if(isDefined(self._blackboard.btraversing)) {
    return false;
  }

  if(self.in_melee) {
    return false;
  }

  return true;
}

function asm_eventfired(asmname, eventname) {
  return self asmeventfired(asmname, eventname);
}

function asm_checktransitions(asmname, currentstatename, inpassthrough) {
  self asmtick(1);
}

function asm_setstate(tostatename, params) {
  if(self asmhasstate(self.asmname, tostatename)) {
    if(isDefined(anim.callbacks["StopAnimscripted"])) {
      self[[anim.callbacks["StopAnimscripted"]]]();
    }

    self asmsetstate(self.asmname, tostatename, params);
  }
}

function function_ac90fa5cc0a80298(state_name, params) {
  current = self asmgetcurrentstate(self.asmname);

  if(current != state_name) {
    if(isDefined(anim.callbacks["StopAnimscripted"])) {
      self[[anim.callbacks["StopAnimscripted"]]]();
    }

    self asmsetstate(self.asmname, state_name);
  }
}

function asm_tick() {
  assertmsg("<dev string:x7f>");
}

function highestallowedstance(asmname, statename, tostatename, stance) {
  assert(isDefined(stance));
  highestallowedstance = gethighestallowedstance();

  if(isDefined(highestallowedstance) && highestallowedstance != stance) {
    return false;
  }

  return true;
}

function asm_getdemeanor() {
  return self._blackboard.movetype;
}

function asm_updatefrantic() {}

function asm_isfrantic() {
  return false;
}

function asm_iscrawlmelee() {
  return isDefined(self.asm.crawlmelee);
}

function asm_setcrawlmelee(val) {
  self.asm.crawlmelee = val;
}

function asm_setdemeanoranimoverride(demeanor, override, anime) {
  self.asm.animoverrides[demeanor][override] = anime;
}

function asm_cleardemeanoranimoverride(demeanor, override) {
  if(asm_hasdemeanoranimoverride(demeanor, override)) {
    self.asm.animoverrides[demeanor][override] = undefined;
  }
}

function asm_hasdemeanoranimoverride(demeanor, override) {
  return isDefined(self.asm.animoverrides[demeanor]) && isDefined(self.asm.animoverrides[demeanor][override]);
}

function asm_getdemeanoranimoverride(demeanor, override) {
  assert(asm_hasdemeanoranimoverride(demeanor, override));
  return self.asm.animoverrides[demeanor][override];
}

function asm_getcurrentstate(asmname) {
  return self asmgetcurrentstate(asmname);
}

function asm_hasalias(statename, alias) {
  arcname = function_2285421dfc79c4d5();
  assertex(isDefined(arcname), "<dev string:xbf>");
  animresult = archetypegetrandomalias(arcname, statename, alias, asm_isfrantic());
  return isDefined(animresult);
}

function asm_getanim(asmname, statename, params) {
  if(isarray(params)) {
    if(params.size == 1) {
      return self asmgetanim(asmname, statename, params[0]);
    } else if(params.size == 2) {
      return self asmgetanim(asmname, statename, params[0], params[1]);
    } else if(params.size == 3) {
      return self asmgetanim(asmname, statename, params[0], params[1], params[2]);
    } else {
      assertmsg("<dev string:xe6>");
    }

    return;
  }

  return self asmgetanim(asmname, statename, params);
}

function asm_getrandomanim(asmname, statename) {
  randomalias = asm_getrandomalias(statename);
  return asm_lookupanimfromalias(statename, randomalias);
}

function asm_getrandomalias(statename) {
  aliases = archetypegetaliases(self.animsetname, statename);
  assertex(aliases.size > 0, "<dev string:x129>" + self.animsetname + "<dev string:x152>" + statename + "<dev string:x158>" + self.classname);
  return aliases[randomint(aliases.size)];
}

function function_c1bf21c5e8625ea(statename, alias) {
  arcname = self.basearchetype;
  assertex(isDefined(arcname), "<dev string:x162>");
  animresult = archetypegetrandomalias(arcname, statename, alias, asm_isfrantic());
  return animresult;
}

function asm_lookupanimfromaliasifexists(statename, alias) {
  arcname = function_2285421dfc79c4d5();
  assertex(isDefined(arcname), "<dev string:xbf>");
  animresult = archetypegetrandomalias(arcname, statename, alias, asm_isfrantic());
  return animresult;
}

function function_62d0bb5a77d09499(statename, alias) {
  arcname = self.basearchetype;
  assertex(isDefined(arcname), "<dev string:x162>");
  animresult = archetypegetrandomalias(arcname, statename, alias, asm_isfrantic());
  assertex(isDefined(animresult), "<dev string:x18e>" + getxhashsourcename(alias) + "<dev string:x1a8>" + arcname + "<dev string:x1bc>" + statename + "<dev string:x1c9>" + self.classname + "<dev string:x1d4>");
  return animresult;
}

function asm_lookupanimfromalias(statename, alias) {
  arcname = function_2285421dfc79c4d5();
  assertex(isDefined(arcname), "<dev string:xbf>");
  animresult = archetypegetrandomalias(arcname, statename, alias, asm_isfrantic());
  assertex(isDefined(animresult), "<dev string:x18e>" + getxhashsourcename(alias) + "<dev string:x1a8>" + arcname + "<dev string:x1bc>" + statename + "<dev string:x1c9>" + self.classname + "<dev string:x1d4>");
  return animresult;
}

function asm_getallanimsforstate(statename) {
  assert(isDefined(self.animsetname));
  arc = self.animsetname;
  aliases = archetypegetaliases(arc, statename);
  anims = [];

  foreach(alias in aliases) {
    animdata = archetypegetalias(arc, statename, alias, 0);

    if(isarray(animdata.anims)) {
      anims = scripts\engine\utility::array_combine(anims, animdata.anims);
      continue;
    }

    anims[anims.size] = animdata.anims;
  }

  return anims;
}

function asm_getallanimsforalias(archetype, statename, alias) {
  redanims = archetypegetalias(archetype, statename, alias, 1);

  if(!isDefined(redanims)) {
    return undefined;
  }

  returnanims = redanims.anims;

  if(!isarray(returnanims)) {
    returnanims = [returnanims];
  }

  return returnanims;
}

function asm_getallanimindicesforalias(statename, alias) {
  return animsetgetallanimindicesforalias(self.animsetname, statename, alias);
}

function asm_playanimstate(asmname, statename, params) {
  self endon(statename + "_finished");
  animid = asm_getanim(asmname, statename);
  self aisetanim(statename, animid);
  asm_playfacialanim(asmname, statename, asm_getxanim(statename, animid));
  endnote = asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));

  if(endnote == "code_move") {
    endnote = asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));
  }
}

function function_74a66de812856ba(asmname, statename, params) {
  self endon(statename + "_finished");
  var_abe93f4471a03711 = float(params);
  thread asm_playanimstate(asmname, statename, params);
  wait var_abe93f4471a03711;
  asm_fireevent(asmname, "end");
}

function asm_hasknobs() {
  if(isagent(self) && !istrue(self.bsoldier) && self.unittype != "civilian") {
    return false;
  }

  return true;
}

function function_fb56c9527636713f(asmname, statename, playbackrate, ismovestate) {
  self endon(statename + "_finished");

  if(!isDefined(playbackrate)) {
    playbackrate = 1;
  }

  if(asm_hasknobs()) {
    bodyknob = asm_getbodyknob();

    if(isDefined(ismovestate) && ismovestate) {
      moveid = asm_lookupanimfromaliasifexists("knobs", "move");

      if(isDefined(moveid)) {
        moveknob = asm_getxanim("knobs", moveid);
        self setmoveanimknob(moveknob);
      }
    }
  }

  notehandler = asm_getnotehandler(asmname, statename);
  timestep = 0.2;
  bmovestate = isDefined(ismovestate) && ismovestate;
  brestart = 1;

  while(true) {
    loopanim = asm_getanim(asmname, statename);
    loopxanim = asm_getxanim(statename, loopanim);

    if(isDefined(ismovestate) && ismovestate) {
      playbackrate = asm_getmoveplaybackrate();
      self codemoveanimrate(playbackrate);
    }

    if(!bmovestate) {
      brestart = self aigetanimweight(loopxanim) == 0;
    }

    if(isnumber(loopanim)) {
      self aisetanim(statename, loopanim, playbackrate);
    } else {
      assertex(utility::issp(), "<dev string:x1d9>");
      blankindex = asm_lookupanimfromalias(statename, "blank");
      self aisetanim(statename, blankindex);

      if(brestart) {
        self setflaggedanimrestart(statename, loopanim, 1, 0.2, playbackrate);
      } else {
        self setflaggedanim(statename, loopanim, 1, 0.2, playbackrate);
      }
    }

    if(bmovestate) {
      brestart = 0;
    }

    asm_playfacialanim(asmname, statename, loopxanim);
    animtime = getanimlength(loopxanim);

    if(animtime <= 0.05) {
      return;
    }

    lastnote = undefined;
    prevplaybackrate = playbackrate;

    while(!isDefined(lastnote)) {
      lastnote = asm_donotetrackswithtimeout(asmname, statename, timestep, notehandler);

      if(!isDefined(lastnote) && bmovestate) {
        playbackrate = asm_getmoveplaybackrate();

        if(playbackrate != prevplaybackrate) {
          self codemoveanimrate(playbackrate);

          if(isnumber(loopanim)) {
            self aisetanimrate(statename, loopanim, playbackrate);
            continue;
          }

          self setanimrate(loopxanim, playbackrate);
        }
      }
    }
  }
}

function asm_lookupdirectionalfootanim(keypaddirection, asmname, statename, var_5217df91f13c7c48, optionalprefix) {
  prefix = "";

  if(isDefined(optionalprefix)) {
    prefix = optionalprefix;
  }

  if(var_5217df91f13c7c48) {
    if(asm_eventfiredrecently(asmname, "pass_left")) {
      prefixfoot = prefix + "left";
    } else if(asm_eventfiredrecently(asmname, "pass_right")) {
      prefixfoot = prefix + "right";
    } else if(self.asm.footsteps.foot == "right") {
      prefixfoot = prefix + "right";
    } else {
      prefixfoot = prefix + "left";
    }
  } else {
    prefixfoot = prefix;
  }

  animid = asm_lookupanimfromaliasifexists(statename, prefixfoot + keypaddirection);

  if(isDefined(animid)) {
    return animid;
  }

  if(prefix != prefixfoot) {
    animid = asm_lookupanimfromaliasifexists(statename, prefix + keypaddirection);

    if(isDefined(animid)) {
      return animid;
    }
  }

  return undefined;
}

function asm_setmoveplaybackrate(rate) {
  self.moveplaybackrate = rate;
}

function asm_getmoveplaybackrate() {
  return self.moveplaybackrate;
}

function asm_getcurrentstatename(asmname) {
  return self asmgetcurrentstate(asmname);
}

function asm_dosinglenotetrack(asmname, statename, customfunction, customparams, customflagname) {
  flagname = statename;

  if(isDefined(customflagname)) {
    flagname = customflagname;
  }

  self waittill(flagname, notes);

  if(!isDefined(notes)) {
    notes = ["undefined"];
  }

  if(!isarray(notes)) {
    notes = [notes];
  }

  assert(isDefined(self.fnasm_handlenotetrack));
  defined_val = undefined;

  foreach(note in notes) {
    asm_fireevent(asmname, note);
    val = [[self.fnasm_handlenotetrack]](note, flagname, customfunction, customparams);

    if(!isDefined(val)) {
      val = asm_handlenewnotetracks(asmname, note, statename);
    }

    if(isDefined(val)) {
      defined_val = val;
    }
  }

  return defined_val;
}

function asm_handlenewnotetracks(asmname, note, statename) {
  if(asm_tryhandledeathstatechangenotetrack(note)) {
    return;
  }

  switch (note) {
    case #"hash_3f80c02caeb2ec99":
      if(asm_currentstatehasflag(asmname, "notetrackAim")) {
        asm_setupaim(asmname, statename, 0.2);
      }

      break;
    case #"hash_9076111750d00173":
      self.var_5e9ef980ddc3f18e = 1;
      break;
    case #"hash_39f7ecb43786b597":
      self.var_5e9ef980ddc3f18e = 0;
      break;
  }
}

function asm_tryhandledeathstatechangenotetrack(notetrack) {
  if(!isstartstr(notetrack, "ds ")) {
    return false;
  }

  charindex = 3;
  assertex(notetrack[charindex] == "<dev string:x233>", "<dev string:x238>");
  self.asm.deathstateoverride = spawnStruct();
  charindex += 1;
  deathstate = "";

  while(charindex < notetrack.size && notetrack[charindex] != "]") {
    deathstate += notetrack[charindex];
    charindex += 1;
  }

  self.asm.deathstateoverride.statename = deathstate;
  charindex += 1;

  if(charindex < notetrack.size) {
    assertex(notetrack[charindex] + notetrack[charindex + 1] == "<dev string:x283>", "<dev string:x289>");
    charindex += 2;
    params = "";

    while(charindex < notetrack.size && notetrack[charindex] != "]") {
      params += notetrack[charindex];
      charindex += 1;
    }

    self.asm.deathstateoverride.params = params;
  }

  return true;
}

function asm_donotetracksfortime(asmname, statename, time, customfunction, customparams) {
  sztimedout = statename + "_timeout";
  self endon(sztimedout);
  childthread asm_donotetracksfortime_helper(sztimedout, time);

  while(true) {
    asm_dosinglenotetrack(asmname, statename, customfunction, customparams);
  }
}

function asm_donotetrackswithtimeout_helper(endonstring, notifystring, timeout) {
  self endon(endonstring);
  wait timeout;
  self notify(notifystring);
}

function asm_donotetrackswithtimeout(asmname, statename, timeout, customfunction, customparams) {
  sztimedout = statename + "_timeout";
  var_7386724c9bd1d65c = statename + "_endHelper";
  self endon(sztimedout);
  childthread asm_donotetrackswithtimeout_helper(var_7386724c9bd1d65c, sztimedout, timeout);
  retval = asm_donotetracks(asmname, statename, customfunction, customparams);
  self notify(var_7386724c9bd1d65c);
  return retval;
}

function asm_donotetracks(asmname, statename, customfunction, customparams, customflagname, var_5c0d1cbfc351f2e1) {
  if(!isDefined(var_5c0d1cbfc351f2e1)) {
    var_5c0d1cbfc351f2e1 = 1;
  }

  for(;;) {
    val = asm_dosinglenotetrack(asmname, statename, customfunction, customparams, customflagname);

    if(isDefined(val)) {
      if(var_5c0d1cbfc351f2e1 && !asm_eventfired(asmname, "end")) {
        asm_fireevent(asmname, "end");
      }

      return val;
    }
  }
}

function asm_donotetrackswithinterceptor(asmname, statename, interceptfunction, interceptparams, customflagname) {
  assert(isDefined(interceptfunction));
  flagname = statename;

  if(isDefined(customflagname)) {
    flagname = customflagname;
  }

  for(;;) {
    self waittill(flagname, notes);

    if(!isDefined(notes)) {
      notes = ["undefined"];
    }

    if(!isarray(notes)) {
      notes = [notes];
    }

    defined_val = undefined;

    foreach(note in notes) {
      asm_fireevent(asmname, note);
      intercepted = [[interceptfunction]](statename, note, interceptparams);

      if(isDefined(intercepted) && intercepted) {
        continue;
      }

      assert(isDefined(self.fnasm_handlenotetrack));
      val = [[self.fnasm_handlenotetrack]](note, statename, undefined, undefined);

      if(!isDefined(val)) {
        val = asm_handlenewnotetracks(asmname, note, statename);
      }

      if(isDefined(val)) {
        defined_val = val;
      }
    }

    if(isDefined(defined_val)) {
      return defined_val;
    }
  }
}

function asm_donotetrackssingleloop(asmname, statename, xanim, customfunction) {
  notifyname = statename + "_note_loop_end";
  self endon(notifyname);
  length = getanimlength(xanim);
  assertex(length > 0, "<dev string:x2e3>" + statename + "<dev string:x2fe>" + xanim + "<dev string:x309>");
  thread asm_donotetrackssingleloop_waiter(notifyname, statename + "_finished", length);
  asm_donotetracks(asmname, statename, customfunction);
  self notify(notifyname);
}

function asm_donotetrackssingleloop_waiter(notifyname, endonname, time) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(notifyname);
  self endon(endonname);
  wait time;
  self notify(notifyname);
}

function asm_donotetracksfortime_helper(notifystring, time) {
  wait time;
  self notify(notifystring);
}

function asm_waitforaimnotetrack(asmname, statename, blendtime) {
  self endon(statename + "_finished");
  bdone = 0;

  while(!bdone) {
    self waittill(statename, notes);

    if(!isarray(notes)) {
      notes = [notes];
    }

    foreach(note in notes) {
      if(note == "start_aim") {
        asm_setupaim(asmname, statename, blendtime);
        bdone = 1;
        break;
      }
    }
  }
}

function asm_lookuprandomalias(statename, optionalprefix, allownone) {
  assertex(isDefined(self.animsetname), "<dev string:xbf>");
  archetype = self.animsetname;
  aliases = archetypegetaliases(archetype, statename);
  possible = 0;
  chosen = undefined;
  prefixlen = -1;

  if(isDefined(optionalprefix)) {
    prefixlen = optionalprefix.size;
  }

  if(!isDefined(aliases)) {
    if(!istrue(allownone)) {
      msg = "<dev string:x31e>" + statename + "<dev string:x346>" + archetype;

      if(isDefined(optionalprefix)) {
        msg += "<dev string:x358>" + optionalprefix;
      }

      assertmsg(msg);
    }

    return undefined;
  }

  foreach(aliasname in aliases) {
    if(prefixlen < 0 || getsubstr(aliasname, 0, prefixlen) == optionalprefix) {
      possible += 1;
      chance = 1 / possible;

      if(randomfloat(1) <= chance) {
        chosen = aliasname;
      }
    }
  }

  if(!istrue(allownone) && !isDefined(chosen)) {
    msg = "<dev string:x31e>" + statename + "<dev string:x346>" + archetype;

    if(isDefined(optionalprefix)) {
      msg += "<dev string:x358>" + optionalprefix;
    }

    assertmsg(msg);
  }

  return chosen;
}

function asm_chooseanim(asmname, statename, params) {
  if(!isDefined(params)) {
    randomalias = asm_lookuprandomalias(statename);

    if(isDefined(randomalias)) {
      return asm_lookupanimfromalias(statename, randomalias);
    } else {
      assertmsg("<dev string:x369>" + asmname + "<dev string:x3d0>" + statename);
      return undefined;
    }

    return;
  }

  result = undefined;
  prefixstr = bb_getprefixstring(params);

  if(isDefined(prefixstr)) {
    randomalias = asm_lookuprandomalias(statename, prefixstr);
    result = asm_lookupanimfromalias(statename, randomalias);
  } else {
    result = asm_lookupanimfromalias(statename, params);
  }

  return result;
}

function asm_clearfacialanim() {
  if(self.facialstate != "filler") {
    if(isai(self)) {
      self setfacialindex("none");
      return;
    }

    if(isDefined(self.var_5247d15da29e8539)) {
      facialknob = asm_lookupanimfromalias("knobs", "head_fakeactor");
      self clearanim(asm_getxanim("knobs", facialknob), 0.2);
      return;
    }

    setfacialindexfornonai("none");
  }
}

function asm_restorefacialanim() {
  asmname = self.asmname;
  statename = self asmgetcurrentstate(asmname);

  if(statename == "animscripted" || self function_e3dadb2823f1da8a(asmname)) {
    return;
  }

  asm_playfacialanim(asmname, statename, undefined);
}

function asm_playfacialanim(asmname, statename, animname) {
  if(isDefined(self.fnasm_playfacialanim)) {
    [[self.fnasm_playfacialanim]](asmname, statename, animname);
  }
}

function asm_getroot() {
  assert(asm_hasknobs());
  animid = asm_lookupanimfromaliasifexists("knobs", "root");

  if(isDefined(animid)) {
    return asm_getxanim("knobs", animid);
  }

  animid = function_62d0bb5a77d09499("knobs", "root");
  return function_6aa159fc2f693af7("knobs", animid);
}

function asm_getbodyknob() {
  animid = asm_lookupanimfromaliasifexists("knobs", "body");

  if(isDefined(animid)) {
    return asm_getxanim("knobs", animid);
  }

  animid = function_62d0bb5a77d09499("knobs", "body");
  return function_6aa159fc2f693af7("knobs", animid);
}

function asm_getinnerrootknob() {
  animid = asm_lookupanimfromaliasifexists("knobs", "inner_root");

  if(isDefined(animid)) {
    return asm_getxanim("knobs", animid);
  }

  animid = function_c1bf21c5e8625ea("knobs", "inner_root");

  if(isDefined(animid)) {
    return function_6aa159fc2f693af7("knobs", animid);
  }

  return asm_getbodyknob();
}

function asm_getfacialknob() {
  animid = asm_lookupanimfromaliasifexists("always_on", "facial");

  if(isDefined(animid)) {
    return asm_getxanim("always_on", animid);
  }

  animid = function_c1bf21c5e8625ea("always_on", "facial");

  if(isDefined(animid)) {
    return function_6aa159fc2f693af7("always_on", animid);
  }
}

function asm_getheadlookknobifexists() {
  animid = asm_lookupanimfromaliasifexists("knobs", "headlook");

  if(isDefined(animid)) {
    return asm_getxanim("knobs", animid);
  }

  animid = function_c1bf21c5e8625ea("knobs", "headlook");

  if(isDefined(animid)) {
    return function_6aa159fc2f693af7("knobs", animid);
  }
}

function asm_isweaponoverride() {
  currentweapon = self.weapon;
  weapon = getweaponbasename(currentweapon);
  weapontypeoverrides = ["iw7_cheytac", "iw7_kbs", "iw7_m1", "iw7_m8", "iw7_mauler", "iw7_sdflmg", "iw7_ameli", "iw7_steeldragon", "iw7_sonic", "iw7_sdfshotty", "iw7_spas"];

  if(isDefined(weapon) && array_contains(weapontypeoverrides, weapon)) {
    return true;
  }

  return false;
}

function function_6aa159fc2f693af7(statename, animid) {
  assert(isDefined(statename));
  assertex(isDefined(animid), "<dev string:x3dc>" + statename);

  if(isnumber(animid)) {
    archetype = self.basearchetype;
    return animsetgetanimfromindex(archetype, statename, animid);
  }

  return animid;
}

function asm_getxanim(statename, animid) {
  assert(isDefined(statename));
  assertex(isDefined(animid), "<dev string:x3dc>" + statename);

  if(isnumber(animid)) {
    archetype = function_2285421dfc79c4d5();
    return animsetgetanimfromindex(archetype, statename, animid);
  }

  return animid;
}

function asm_playanimstatewithnotetrackinterceptor(asmname, statename, var_179213470e3d2f54, var_49bd3392cc4caeb2) {
  self endon(statename + "_finished");
  animid = asm_getanim(asmname, statename);
  self aisetanim(statename, animid);
  asm_playfacialanim(asmname, statename, asm_getxanim(statename, animid));
  endnote = asm_donotetrackswithinterceptor(asmname, statename, var_179213470e3d2f54, var_49bd3392cc4caeb2);

  if(endnote == "end") {
    if(!asm_eventfired(asmname, "end")) {
      asm_fireevent(asmname, "end");
    }
  }
}

function asm_playanimstatenotransition(asmname, statename, params) {
  self endon(statename + "_finished");
  animid = asm_getanim(asmname, statename);
  self aisetanim(statename, animid);
  asm_playfacialanim(asmname, statename, asm_getxanim(statename, animid));
  endnote = asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));
}

function function_30df7eff2a4557a5(statename, aliasname) {
  self endon("death");
  scripts\asm\asm_bb::bb_setanimScripted();
  self asmsetstate(self.asmname, "animscripted");
  animindex = asm_lookupanimfromalias(statename, aliasname);
  self aisetanim(statename, animindex);
  xanim = asm_getxanim(statename, animindex);
  animlength = getanimlength(xanim);
  wait animlength;
  scripts\asm\asm_bb::bb_clearanimScripted();
}

function asm_playadditiveanimloopstate(asmname, statename, params) {
  assert(isDefined(self.fnasm_playadditiveanimloopstate));
  [[self.fnasm_playadditiveanimloopstate]](asmname, statename, params);
}

function function_6e9cb6cd0535fe65() {
  normalizedtime = self function_9f1a3a76adea61f6();
  self restartanim(normalizedtime);
}

function function_8d1655ae223d862a(rate) {
  self.animplaybackratedefault = rate;
}

function function_4bb232c0fca955f6() {
  return self.animplaybackratedefault;
}

function yawdiffto2468(diff) {
  if(diff < -135) {
    return "2";
  }

  if(diff < -45) {
    return "6";
  }

  if(diff > 135) {
    return "2";
  }

  if(diff > 45) {
    return "4";
  }

  return "8";
}

function asm_debugenabled() {
  if(isDefined(level.asmdebugenabled) && level.asmdebugenabled) {
    return 1;
  }

  return 0;
}

function debug_arrivals_on_actor() {
  dvar = getDvar(@ "debug_arrivals");

  if(dvar == "<dev string:x405>") {
    return 0;
  }

  if(dvar == "<dev string:x40c>") {
    return 1;
  }

  if(int(dvar) == self getentitynumber()) {
    return 1;
  }

  return 0;
}

function debug_arrival(msg) {
  if(!debug_arrivals_on_actor()) {
    return;
  }

  println(msg);
}

function asm_setupgesture(asmname, statename) {
  demeanor = asm_getdemeanor();
  bfrantic = asm_isfrantic();
  gestures = self.asm.gestures;
  arc = self.animsetname;
  gestures.gesture_moveup_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_move_up", bfrantic));
  gestures.gesture_armup_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_armup", bfrantic));
  gestures.gesture_onme_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_on_me", bfrantic));
  gestures.gesture_hold_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_hold", bfrantic));
  gestures.gesture_fallback_up_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_fallback_up", bfrantic));
  gestures.gesture_fallback_down_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_fallback_down", bfrantic));

  if(demeanor == "casual") {
    gestures.gesture_point_center = asm_getxanim("gesture_point", archetypegetrandomalias(arc, "gesture_point", "gesture_point_center", bfrantic));
    gestures.gesture_point_left = asm_getxanim("gesture_point", archetypegetrandomalias(arc, "gesture_point", "gesture_point_left", bfrantic));
    gestures.gesture_point_right = asm_getxanim("gesture_point", archetypegetrandomalias(arc, "gesture_point", "gesture_point_right", bfrantic));
    gestures.gesture_point_up = asm_getxanim("gesture_point", archetypegetrandomalias(arc, "gesture_point", "gesture_point_up", bfrantic));
    gestures.gesture_point_down = asm_getxanim("gesture_point", archetypegetrandomalias(arc, "gesture_point", "gesture_point_down", bfrantic));
    gestures.gesture_shrug_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_shrug_anim", bfrantic));
    gestures.gesture_cross_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_cross_anim", bfrantic));
    gestures.gesture_nod_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_nod_anim", bfrantic));
    gestures.gesture_shake_head_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_shake_head_anim", bfrantic));
    gestures.gesture_salute_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_salute_anim", bfrantic));
    gestures.gesture_wave_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_wave_anim", bfrantic));
    gestures.gesture_wait_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_wait_anim", bfrantic));
    return;
  }

  if(demeanor == "casual_gun") {
    gestures.gesture_point_center = asm_getxanim("gesture_point", archetypegetrandomalias(arc, "gesture_point", "gesture_casual_gun_point_center", bfrantic));
    gestures.gesture_point_left = asm_getxanim("gesture_point", archetypegetrandomalias(arc, "gesture_point", "gesture_casual_gun_point_left", bfrantic));
    gestures.gesture_point_right = asm_getxanim("gesture_point", archetypegetrandomalias(arc, "gesture_point", "gesture_casual_gun_point_right", bfrantic));
    gestures.gesture_point_up = asm_getxanim("gesture_point", archetypegetrandomalias(arc, "gesture_point", "gesture_casual_gun_point_up", bfrantic));
    gestures.gesture_point_down = asm_getxanim("gesture_point", archetypegetrandomalias(arc, "gesture_point", "gesture_casual_gun_point_down", bfrantic));
    gestures.gesture_shrug_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_gun_shrug_anim", bfrantic));
    gestures.gesture_cross_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_gun_cross_anim", bfrantic));
    gestures.gesture_nod_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_gun_nod_anim", bfrantic));
    gestures.gesture_shake_head_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_gun_shake_head_anim", bfrantic));
    gestures.gesture_salute_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_gun_salute_anim", bfrantic));
    gestures.gesture_wave_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_gun_wave_anim", bfrantic));
    gestures.gesture_wait_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_gun_wait_anim", bfrantic));
    return;
  }

  gestures.gesture_point_center = asm_getxanim("gesture_point", archetypegetrandomalias(arc, "gesture_point", "gesture_gun_point_center", bfrantic));
  gestures.gesture_point_left = asm_getxanim("gesture_point", archetypegetrandomalias(arc, "gesture_point", "gesture_gun_point_left", bfrantic));
  gestures.gesture_point_right = asm_getxanim("gesture_point", archetypegetrandomalias(arc, "gesture_point", "gesture_gun_point_right", bfrantic));
  gestures.gesture_point_up = asm_getxanim("gesture_point", archetypegetrandomalias(arc, "gesture_point", "gesture_gun_point_up", bfrantic));
  gestures.gesture_point_down = asm_getxanim("gesture_point", archetypegetrandomalias(arc, "gesture_point", "gesture_gun_point_down", bfrantic));
  gestures.gesture_shrug_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_gun_shrug_anim", bfrantic));
  gestures.gesture_cross_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_gun_cross_anim", bfrantic));
  gestures.gesture_nod_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_gun_nod_anim", bfrantic));
  gestures.gesture_shake_head_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_gun_shake_head_anim", bfrantic));
  gestures.gesture_salute_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_gun_salute_anim", bfrantic));
  gestures.gesture_wave_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_gun_wave_anim", bfrantic));
  gestures.gesture_wait_anim = asm_getxanim("gesture_old", archetypegetrandomalias(arc, "gesture_old", "gesture_gun_wait_anim", bfrantic));
}

function setup_level_ents() {
  level endon("game_ended");
  count = 0;

  foreach(t in getnodearray("traverse", "targetname")) {
    t traversethink();
    count++;

    if(count > 1000) {
      count = 0;
      waitframe();
    }
  }

  callback::callback("setup_all_traversals");

  foreach(t in getnodearray("<dev string:x412>", "<dev string:x429>")) {
    t thread deprecatedtraversethink();
  }

  level thread drawtraversaldata();
  level thread function_2bbb4d05ad09c81e();
}

function function_35dd4cad0ca3fafc() {
  foreach(t in getallnodes()) {
    if(isDefined(t.type) && t.type == "Begin" && !isDefined(t.traverse_height)) {
      t function_ece7865eb2447554();
      waitframe();
    }
  }
}

function processdoublejumpmantletraversal(target) {
  assert(isDefined(target));
  self.doublejumpmantlepos = target.origin;
  self.startnodeoriginalangles = self.angles;

  if(isent(target)) {
    target delete();
    return;
  }

  deletestruct_ref(target);
}

function traversethink() {
  ent = getEnt(self.target, "targetname");

  if(!isDefined(ent)) {
    ent = getStruct(self.target, "targetname");
  }

  end_node = getnode(self.target, "targetname");

  if(!isDefined(end_node)) {
    if(level.script != "mp_jup_map" && level.script != "mp_jup_bigmap_wz2" && level.script != "mp_jup_bm_live_wz2" && level.script != "mp_jup_bm_wz2_s4" && level.script != "mp_jup_escape5_hell") {
      assertex(isDefined(end_node), "<dev string:x437>" + self.origin + "<dev string:x486>" + self.target);
    }

    logstring("^1Warning: Unable to find matching negotiation_end_node for negotiation_start_node at " + self.origin + " " + self.target);
    return;
  }

  if(self.animscript == "traverse_ground") {
    function_2121ee28acaa2765(ent, end_node);
    return;
  }

  if(!isDefined(ent)) {
    println("<dev string:x48b>" + self.animscript + "<dev string:x4ad>");
    calculate_traverse_data(averagepoint([self.origin, end_node.origin]), end_node.origin);
    return;
  }

  switch (self.animscript) {
    case #"hash_8f681d217a32aef7":
      processwallruntraversal(ent);
      return;
    case #"hash_2517ba3af2f13858":
      function_af7d10bc22de3494(ent);
      return;
    case #"hash_6fc6878fd3fd1e7a":
    case #"hash_d14662a6eb371af5":

      if(getdvarint(@ "hash_a838875af4383ca1", 0) != 0) {
        if(isDefined(self.target)) {
          node = getnode(self.target, "<dev string:x429>");

          if(isDefined(node)) {
            self.var_2ec927a0b0085925 = node.origin;
          }
        }
      }

      processdoublejumpmantletraversal(ent);
      return;
    case #"hash_5f054fa72e77b8dd":

      if(getdvarint(@ "hash_a838875af4383ca1", 0) != 0) {
        if(isDefined(self.target)) {
          node = getnode(self.target, "<dev string:x429>");

          if(isDefined(node)) {
            self.var_2ec927a0b0085925 = node.origin;
          }
        }
      }

      self.startnodeoriginalangles = self.angles;
      self.jump_over_offset = ent.origin - self.origin;
      self.jump_over_ent_origin = ent.origin;
      break;
    case #"hash_3083e73248cdb399":
      self.startnodeoriginalangles = self.angles;

      if(getdvarint(@ "hash_a838875af4383ca1", 0) != 0) {
        self.var_2ec927a0b0085925 = getnode(self.target, "<dev string:x429>").origin;
        self.rail_hop_double_jump_down = ent.origin;
      }

      break;
    default:
      break;
  }

  if(isDefined(ent.target) && (level.script != "mp_jup_bigmap" && level.script != "mp_jup_bigmap_wz2" && level.script != "mp_jup_bm_live_wz2" && level.script != "mp_jup_bm_wz2_s4" || !isendstr(ent.target, "auto12190374188911454432"))) {
    ent2 = getEnt(ent.target, "targetname");

    if(!isDefined(ent2)) {
      ent2 = getStruct(ent.target, "targetname");
    }

    assertex(isDefined(ent2), self.animscript + "<dev string:x519>" + self.origin + "<dev string:x52a>" + ent.targetname + "<dev string:x537>" + ent.origin + "<dev string:x53f>" + ent.target);

    if(isDefined(ent2)) {
      calculate_traverse_data(ent.origin, end_node.origin, ent2.origin);
    } else {
      calculate_traverse_data(ent.origin, end_node.origin);
    }
  } else {
    calculate_traverse_data(ent.origin, end_node.origin);
  }

  if(isDefined(self.parentname)) {
    store_original_traverse_data();
  }

  if(isent(ent)) {
    ent delete();
    return;
  }

  deletestruct_ref(ent);
}

function function_ece7865eb2447554() {
  apex_pos = undefined;
  end_node = getnode(self.target, "targetname");
  assertex(isDefined(end_node), "<dev string:x437>" + self.origin + "<dev string:x486>" + self.target);
  apex_pos = function_fda6a76c32365675(self.origin, end_node.origin);

  if(!isDefined(apex_pos)) {
    assertmsg("<dev string:x563>" + self.origin + "<dev string:x5a3>");
    apex_pos = averagepoint([self.origin, end_node.origin]);
  }

  calculate_traverse_data(apex_pos, end_node.origin);
}

function store_original_traverse_data() {
  self.original_data = spawnStruct();
  self.original_data.origin = self.origin;
  self.original_data.angles = self.angles;
  self.original_data.traverse_height = self.traverse_height;
  self.original_data.traverse_height_delta = self.traverse_height_delta;
  self.original_data.traverse_drop_height_delta = self.traverse_drop_height_delta;
  self.original_data.apex_delta = self.apex_delta;
  self.original_data.apex_delta_local = rotatevectorinverted(self.apex_delta, self.angles);

  if(isDefined(self.across_delta)) {
    self.original_data.across_delta = self.across_delta;
    self.original_data.across_delta_local = rotatevectorinverted(self.across_delta, self.angles);
  }

  end_node = getnode(self.target, "targetname");

  if(isDefined(end_node)) {
    self.original_data.endnode_pos = end_node.origin;
  }
}

function calculate_traverse_data(struct_pos, endnode_pos, struct2_pos) {
  assert(self.type == "<dev string:x5e3>");

  if(self.animscript == "ladder_up" || self.animscript == "ladder_down") {
    ladderend = isDefined(struct2_pos) ? struct2_pos : isDefined(struct_pos) ? struct_pos : endnode_pos;
    self.traverse_height = ladderend[2];
    self.traverse_height_delta = ladderend[2] - self.origin[2];
    self.traverse_drop_height_delta = ladderend[2] - endnode_pos[2];
    self.apex_delta = ladderend - self.origin;
    return;
  }

  self.traverse_height = struct_pos[2];
  self.traverse_height_delta = struct_pos[2] - self.origin[2];
  self.traverse_drop_height_delta = struct_pos[2] - endnode_pos[2];
  self.apex_delta = struct_pos - self.origin;

  if(isDefined(struct2_pos)) {
    self.across_delta = struct2_pos - struct_pos;
  }
}

function re_calculate_traverse_data(ref_node, struct_pos, endnode_pos, struct2_pos) {
  if(!isDefined(struct_pos)) {
    struct_pos = self.origin + rotatevector(ref_node.original_data.apex_delta_local, self.angles);
  }

  if(!isDefined(endnode_pos)) {
    endnode_pos = ref_node.original_data.endnode_pos;
  }

  if(!isDefined(struct2_pos) && isDefined(ref_node.original_data.across_delta_local)) {
    var_f671cc4a667b804f = rotatevector(ref_node.original_data.across_delta_local, self.angles);
    struct2_pos = struct_pos + var_f671cc4a667b804f;
  }

  calculate_traverse_data(struct_pos, endnode_pos, struct2_pos);
}

function processwallruntraversal(target) {
  assert(isDefined(target));
  wallendnode = getEnt(target.target, "targetname");

  if(!isDefined(wallendnode)) {
    wallendnode = getStruct(target.target, "targetname");
  }

  assert(isDefined(wallendnode));

  dist = distance(self.origin, target.origin);

  if(dist > 400) {
    println("<dev string:x5ec>" + self.origin + "<dev string:x624>" + dist + "<dev string:x63f>" + 400);
  }

  self.wall_info = spawnStruct();
  var_70d5f712a9e22e96 = target;
  numnodes = 0;
  self.wall_info.startnodeoriginalangles = self.angles;

  deltaz = var_70d5f712a9e22e96.origin[2] - self.origin[2];

  if(deltaz > 208) {
    println("<dev string:x646>" + var_70d5f712a9e22e96.origin + "<dev string:x674>" + deltaz + "<dev string:x63f>" + 208);
  }

  walldir = undefined;

  while(isDefined(var_70d5f712a9e22e96)) {
    self.wall_info.nodeoffsets[numnodes] = var_70d5f712a9e22e96.origin - self.origin;
    numnodes++;
    var_d258406ada10ec0a = getStruct(var_70d5f712a9e22e96.target, "targetname");
    assert(isDefined(var_d258406ada10ec0a));

    dist = distance(var_70d5f712a9e22e96.origin, var_d258406ada10ec0a.origin);

    if(dist > 544) {
      println("<dev string:x6a1>" + var_70d5f712a9e22e96.origin + "<dev string:x6c5>" + dist + "<dev string:x63f>" + 544);
    }

    walldir = vectorNormalize(var_d258406ada10ec0a.origin - var_70d5f712a9e22e96.origin);
    dirtowall = var_70d5f712a9e22e96.origin - self.origin;
    dirtowall = (dirtowall[0], dirtowall[1], 0);
    dirtowall = vectorNormalize(dirtowall);
    dotprod = vectordot(walldir, dirtowall);

    if(dotprod < 0) {
      println("<dev string:x6e0>" + self.origin + "<dev string:x705>");
    }

    deletestruct_ref(var_70d5f712a9e22e96);
    var_70d5f712a9e22e96 = var_d258406ada10ec0a;
    assert(isDefined(var_70d5f712a9e22e96));
    self.wall_info.nodeoffsets[numnodes] = var_70d5f712a9e22e96.origin - self.origin;
    numnodes++;

    if(isDefined(var_70d5f712a9e22e96.target)) {
      temp = getStruct(var_70d5f712a9e22e96.target, "targetname");
    } else {
      temp = undefined;
    }

    deletestruct_ref(var_70d5f712a9e22e96);
    var_70d5f712a9e22e96 = temp;

    if(!isDefined(var_70d5f712a9e22e96)) {
      traversalendnode = getnode(self.target, "<dev string:x429>");
      assert(isDefined(traversalendnode));
      assert(isDefined(walldir));
      dirtoendnode = traversalendnode.origin - var_d258406ada10ec0a.origin;
      dirtoendnode = (dirtoendnode[0], dirtoendnode[1], 0);
      dirtoendnode = vectorNormalize(dirtoendnode);
      dotprod = vectordot(dirtoendnode, walldir);

      if(dotprod < 0) {
        println("<dev string:x6e0>" + self.origin + "<dev string:x72f>");
      }

      dist = distance(var_d258406ada10ec0a.origin, traversalendnode.origin);

      if(dist > 512) {
        println("<dev string:x6e0>" + self.origin + "<dev string:x777>" + dist + "<dev string:x63f>" + 512);
      }
    }

    if(isDefined(var_70d5f712a9e22e96) && isDefined(var_70d5f712a9e22e96.script_wallrun_type)) {
      if(var_70d5f712a9e22e96.script_wallrun_type == "wallrun_mantle") {
        dist = distance(var_d258406ada10ec0a.origin, var_70d5f712a9e22e96.origin);
        deltaz = var_70d5f712a9e22e96.origin[2] - var_d258406ada10ec0a.origin[2];

        if(deltaz > 0) {
          if(dist > 420) {
            println("<dev string:x7a9>" + var_70d5f712a9e22e96.origin + "<dev string:x7f1>" + dist + "<dev string:x63f>" + 420);
          }

          if(deltaz > 200) {
            println("<dev string:x803>" + var_70d5f712a9e22e96.origin + "<dev string:x832>" + deltaz + "<dev string:x63f>" + 200);
          }
        } else if(dist > 512) {
          println("<dev string:x862>" + var_70d5f712a9e22e96.origin + "<dev string:x7f1>" + dist + "<dev string:x63f>" + 512);
        }

        self.wall_info.mantleoffset = var_70d5f712a9e22e96.origin - self.origin;

        if(isDefined(var_70d5f712a9e22e96.angles)) {
          self.wall_info.mantleangles = var_70d5f712a9e22e96.angles;
        }

        deletestruct_ref(var_70d5f712a9e22e96);
        break;
      }

      if(var_70d5f712a9e22e96.script_wallrun_type == "wallrun_vault") {
        self.wall_info.mantleoffset = var_70d5f712a9e22e96.origin - self.origin;
        self.wall_info.bvaultover = 1;

        deltaz = var_70d5f712a9e22e96.origin[2] - var_d258406ada10ec0a.origin[2];

        if(deltaz > 164) {
          println("<dev string:x8aa>" + var_70d5f712a9e22e96.origin + "<dev string:x832>" + deltaz + "<dev string:x63f>" + 164);
        }

        deletestruct_ref(var_70d5f712a9e22e96);
        break;
      }
    }
  }
}

function function_2121ee28acaa2765(target, end_node) {
  assert(isDefined(end_node));
  self.walk_nodes = [];
  self.walk_nodes = array_add(self.walk_nodes, self.origin);

  for(currentgoal = target; isDefined(currentgoal); currentgoal = undefined) {
    self.walk_nodes = array_add(self.walk_nodes, currentgoal.origin);

    if(isDefined(currentgoal.target)) {
      currentgoal = getStruct(currentgoal.target, "targetname");
      continue;
    }
  }

  self.walk_nodes = array_add(self.walk_nodes, end_node.origin);
}

function function_af7d10bc22de3494(target) {
  assert(isDefined(target));
  self.wall_nodes = [];
  self.wall_rolls = [];
  currentgoal = target;

  while(isDefined(currentgoal)) {
    self.wall_nodes = array_add(self.wall_nodes, currentgoal.origin);
    self.wall_rolls = array_add(self.wall_rolls, currentgoal.angles[2]);
    oldgoal = currentgoal;

    if(isDefined(currentgoal.target)) {
      currentgoal = getStruct(currentgoal.target, "targetname");
    } else {
      currentgoal = undefined;
    }

    deletestruct_ref(oldgoal);
  }

  assert(self.wall_nodes.size >= 2);

  if(self.wall_nodes.size >= 2 && self.wall_rolls[0] == 0) {
    walldir = self.wall_nodes[1] - self.wall_nodes[0];
    wallright = vectorcross(walldir, (0, 0, 1));
    var_30501b8da540ea16 = self.wall_nodes[0] - self.origin;
    walldot = vectordot(wallright, var_30501b8da540ea16);
    self.var_143b20e77684b51 = vectordot(wallright, var_30501b8da540ea16) < 0;
  }

  self.traverse_height = 0;
}

function function_fda6a76c32365675(begin_pos, end_pos) {
  apex_pos = undefined;
  var_7533ff429b05d245 = begin_pos;
  var_f38af0b4e9fff9f1 = end_pos;
  var_a5d0297b89fc7ef4 = flatten_vector(end_pos - begin_pos);
  delta_z = abs(end_pos[2] - begin_pos[2]);
  start_z = min(begin_pos[2], end_pos[2]);
  current_z = max(begin_pos[2], end_pos[2]) + 1;
  begin_pos = (begin_pos[0], begin_pos[1], current_z);
  end_pos = (end_pos[0], end_pos[1], current_z);
  trace_end = physicstrace(begin_pos, end_pos);
  var_30d6320d769d3f2c = 0.01;

  if(distance2dsquared(trace_end, end_pos) < var_30d6320d769d3f2c) {
    if(var_7533ff429b05d245[2] < var_f38af0b4e9fff9f1[2]) {
      temp_pos = begin_pos;
      begin_pos = end_pos;
      end_pos = temp_pos;
    }

    iteration_limit = 3;
    cliff_pos = begin_pos;
    mid_point = undefined;
    var_a2d80e0c0cf75c95 = undefined;

    for(i = 0; i < iteration_limit; i++) {
      mid_point = averagepoint([begin_pos, end_pos]);
      pit_height = 20;
      var_a8da4fd8b61d7002 = mid_point - (0, 0, pit_height);
      trace_end = physicstrace(mid_point, var_a8da4fd8b61d7002);
      var_f49807d1d5831577 = vectordot(vectorNormalize(begin_pos - trace_end), vectorNormalize(end_pos - trace_end));

      if(trace_end == var_a8da4fd8b61d7002 || abs(var_f49807d1d5831577) > 0.2) {
        end_pos = mid_point;
        var_a2d80e0c0cf75c95 = mid_point;
        continue;
      }

      begin_pos = mid_point;
      cliff_pos = trace_end;
    }

    if(isDefined(var_a2d80e0c0cf75c95)) {
      var_8c522d40ce23da01 = (var_a2d80e0c0cf75c95[0], var_a2d80e0c0cf75c95[1], cliff_pos[2] - 1);
      apex_pos = physicstrace(var_8c522d40ce23da01, cliff_pos);
      apex_pos = (apex_pos[0], apex_pos[1], min(apex_pos[2], mid_point[2]));
    } else {
      apex_pos = (cliff_pos[0], cliff_pos[1], min(cliff_pos[2], mid_point[2]));
    }
  } else {
    found_top = 0;
    var_827921a3c3a33294 = trace_end;
    iteration_limit = 10;
    iteration_index = 0;
    var_bb3a6419e378030e = 15;

    while(!found_top && iteration_index < iteration_limit) {
      current_z += var_bb3a6419e378030e;
      begin_pos = (begin_pos[0], begin_pos[1], current_z);
      end_pos = (end_pos[0], end_pos[1], current_z);
      trace_end = physicstrace(begin_pos, end_pos);

      if(distance2dsquared(trace_end, end_pos) < var_30d6320d769d3f2c) {
        found_top = 1;
      } else {
        var_827921a3c3a33294 = trace_end;
      }

      iteration_index++;
    }

    if(istrue(found_top)) {
      above_top = var_827921a3c3a33294 + var_a5d0297b89fc7ef4 + (0, 0, var_bb3a6419e378030e);
      apex_pos = physicstrace(above_top, above_top - (0, 0, var_bb3a6419e378030e));
    }

    if(!isDefined(apex_pos)) {
      println("<dev string:x8d8>" + iteration_limit + "<dev string:x927>" + begin_pos);
    }
  }

  return apex_pos;
}

function function_e722e0c504ced0ee(asmname, statename, params) {
  self notify("agent_scene_stop");
  self clearoverridearchetype("animscript");
}

function deprecatedtraversethink() {
  wait 0.05;
  println("<dev string:x943>" + self.origin);

  if(getdvarint(@ "hash_60bc1b675216e3d")) {
    while(true) {
      print3d(self.origin, "<dev string:x988>");
      wait 0.05;
    }
  }
}

function validatetraverse(traverse) {
  return traverse == "<dev string:x9a0>" || traverse == "<dev string:x9b4>" || traverse == "<dev string:x9ca>" || traverse == "<dev string:x9e0>" || traverse == "<dev string:x9f8>" || traverse == "<dev string:xa12>" || traverse == "<dev string:xa25>";
}

function validatetraversenodes() {
  println("<dev string:xa36>");

  foreach(t in getnodearray("<dev string:xa55>", "<dev string:x429>")) {
    if(!validatetraverse(t.animscript)) {
      continue;
    }

    s = 20;

    while(s < 280) {
      yaw = -180;

      while(yaw <= 180) {
        featurearray = [];
        featurearray["<dev string:xa61>"] = t.traverse_height_delta;
        featurearray["<dev string:xa6b>"] = t.traverse_drop_height_delta;
        featurearray["<dev string:xa7a>"] = yaw;
        featurearray["<dev string:xa89>"] = s;

        if(t.animscript == "<dev string:x9e0>") {
          featurearray["<dev string:xa92>"] = length2d(t.across_delta);
        }

        alias = level scripts\anim\animselector::selectanim(t.animscript, featurearray, 0);

        if(alias == "<dev string:xa9c>") {
          nodestring = "<dev string:xaa7>";
          nodestring = nodestring + "<dev string:xae7>" + t.animscript;
          nodestring = nodestring + "<dev string:xaf2>" + t.origin;
          nodestring = nodestring + "<dev string:xafe>" + t.traverse_height_delta;
          nodestring = nodestring + "<dev string:xb0e>" + t.traverse_drop_height_delta;
          nodestring = nodestring + "<dev string:xb1c>" + s;
          nodestring = nodestring + "<dev string:xb2b>" + yaw;

          if(t.animscript == "<dev string:x9e0>") {
            nodestring = nodestring + "<dev string:xb38>" + length2d(t.across_delta);
          }

          nodestring += "<dev string:xb48>";
          println(nodestring);
        }

        yaw += 15;
      }

      waitframe();
      s += 10;
    }
  }
}

function drawtraversaldata() {
  while(true) {
    waitframe();

    if(getdvarint(@ "hash_c67513927ea56f3a", 0) <= 0) {
      continue;
    }

    recorder_enabled = getdvarint(@ "recorder_enablerec", 0) > 0;

    foreach(t in getallnodes()) {
      if(isDefined(t.type) && t.type == "<dev string:x5e3>" && isDefined(t.traverse_height)) {
        apex_pos = t.origin + t.apex_delta;

        if(recorder_enabled) {
          recordsphere(apex_pos, 15, (0.2, 1, 0));
          continue;
        }

        sphere(apex_pos, 15, (0.2, 1, 0));
      }
    }
  }
}

function private function_2bbb4d05ad09c81e() {
  level endon("<dev string:xb4e>");
  setdvarifuninitialized(@ "hash_e42ac6b1ddb1188e", 0);

  while(true) {
    if(getdvarint(@ "hash_e42ac6b1ddb1188e", 0) <= 0) {
      waitframe();
      continue;
    }

    break;
  }

  while(!isalive(level.players[0])) {
    waitframe();
  }

  var_c22f0f91887e7488 = spawnStruct();
  var_c22f0f91887e7488.room_nodes = [];
  var_c22f0f91887e7488.var_d1debc37b000d65d = [];
  level childthread function_25f6ff1e2f38d5a(var_c22f0f91887e7488);
  iprintlnbold("<dev string:xb5c>");
  room_index = 0;
  room_node = getroomnodeforindex(room_index);
  room_node = {
    #origin: getclosestpointonnavmesh(room_node.origin)
  };
  var_c52c258b548af58d = 0;

  while(isDefined(room_node)) {
    var_4b5523fa148a15c9 = undefined;
    var_3bbd592cb0b58f64 = [];

    foreach(var_80847fa4c21ff44b in var_c22f0f91887e7488.room_nodes) {
      can_pathfind = 0;
      dist = distance(room_node.origin, var_80847fa4c21ff44b.origin);

      if(dist > 4000) {
        continue;
      }

      if(is_equal(var_4b5523fa148a15c9, var_80847fa4c21ff44b.island_id)) {
        can_pathfind = 1;
      } else if(!can_pathfind) {
        path1 = findpathcustom(room_node.origin, var_80847fa4c21ff44b.origin);
        can_pathfind = function_b391661c3185e255(path1, var_80847fa4c21ff44b.origin);

        if(can_pathfind) {
          path2 = findpathcustom(var_80847fa4c21ff44b.origin, room_node.origin);
          can_pathfind = function_b391661c3185e255(path2, room_node.origin);
        }
      }

      if(can_pathfind) {
        var_4b5523fa148a15c9 = isDefined(var_4b5523fa148a15c9) ? var_4b5523fa148a15c9 : var_80847fa4c21ff44b.island_id;
        var_4b5523fa148a15c9 = min(var_4b5523fa148a15c9, var_80847fa4c21ff44b.island_id);
        var_3bbd592cb0b58f64[var_3bbd592cb0b58f64.size] = var_80847fa4c21ff44b;
      }
    }

    foreach(var_80847fa4c21ff44b in var_3bbd592cb0b58f64) {
      var_80847fa4c21ff44b.island_id = int(var_4b5523fa148a15c9);
    }

    var_c22f0f91887e7488.room_nodes[var_c22f0f91887e7488.room_nodes.size] = room_node;

    if(!isDefined(var_4b5523fa148a15c9)) {
      room_node.island_id = int(var_c52c258b548af58d);
      var_c52c258b548af58d++;
    } else {
      room_node.island_id = int(var_4b5523fa148a15c9);
    }

    room_index++;
    room_node = getroomnodeforindex(room_index);

    if(isDefined(room_node)) {
      room_node = {
        #origin: getclosestpointonnavmesh(room_node.origin)
      };
    }

    if(room_index % 150 == 0) {
      waitframe();
    }
  }

  foreach(room_node in var_c22f0f91887e7488.room_nodes) {
    var_c22f0f91887e7488.var_d1debc37b000d65d[room_node.island_id] = isDefined(var_c22f0f91887e7488.var_d1debc37b000d65d[room_node.island_id]) ? var_c22f0f91887e7488.var_d1debc37b000d65d[room_node.island_id] : 0;
    var_c22f0f91887e7488.var_d1debc37b000d65d[room_node.island_id] += 1;
  }

  waitframe();
  logstring("<dev string:xb82>");

  foreach(room_node in var_c22f0f91887e7488.room_nodes) {
    if(is_equal(var_c22f0f91887e7488.var_d1debc37b000d65d[room_node.island_id], 1)) {
      logstring("<dev string:xbbe>" + room_node.origin);
    }
  }

  iprintlnbold("<dev string:xbdf>");
}

function private function_b391661c3185e255(path, end_point) {
  if(isDefined(path) && path.size > 0) {
    dist = distance(path[path.size - 1], end_point);
    return (dist < 10);
  }

  return 0;
}

function private function_25f6ff1e2f38d5a(var_c22f0f91887e7488) {
  var_9a3849d89286b99c = [];
  render_frames = int(ceil(1 / level.framedurationseconds));

  while(true) {
    if(getdvarint(@ "hash_e42ac6b1ddb1188e", 0) <= 0) {
      waitframe();
      continue;
    }

    foreach(room_node in var_c22f0f91887e7488.room_nodes) {
      if(!isDefined(var_9a3849d89286b99c[room_node.island_id])) {
        var_9a3849d89286b99c[room_node.island_id] = (randomfloat(1), randomfloat(1), randomfloat(1));
      }

      col = var_9a3849d89286b99c[room_node.island_id];
      alpha = 1;

      if(isDefined(var_c22f0f91887e7488.var_d1debc37b000d65d[room_node.island_id])) {
        if(var_c22f0f91887e7488.var_d1debc37b000d65d[room_node.island_id] == 1) {
          line(room_node.origin, room_node.origin + (0, 0, 4000), col, undefined, 0, render_frames);
          sphere(room_node.origin + (0, 0, 4000), 500, col, 1, render_frames);
        } else if(var_c22f0f91887e7488.var_d1debc37b000d65d[room_node.island_id] > 50) {
          alpha = 0.5;

          if(distance(room_node.origin, level.players[0].origin) > 2000) {
            continue;
          }
        }
      }

      sphere(room_node.origin, 20, col, 0, render_frames);
      print3d(room_node.origin + (0, 0, 10), "<dev string:xc0e>" + room_node.island_id, col, alpha, undefined, render_frames);
    }

    wait 1;
  }
}

# /