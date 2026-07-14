/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\asm.gsc
**************************************/

#using scripts\anim\animselector;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace asm;

function function_ad98228cc73bd51c(asmname) {
  self asminstantiate(asmname);
  self.asmasset = undefined;
  self.animationarchetype = undefined;
}

function asm_getfunction(asmname, funcid) {
  assert(isDefined(anim.asmfuncs[asmname]), "<dev string:x24>" + asmname);
  assert(isDefined(anim.asmfuncs[asmname][funcid]), "<dev string:x4a>" + funcid + "<dev string:x66>" + asmname);
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

function function_e4caaa59f812360f(var_f382079c3425cee6, var_87bc3552a49f9d07) {
  if(var_f382079c3425cee6) {
    updatepainvars();
  }

  if(!shouldplaypainanim(var_87bc3552a49f9d07)) {
    return 0;
  }

  didpain = self asmevalpaintransition(self.asmname);
  return didpain;
}

function shouldplaypainanim(var_87bc3552a49f9d07) {
  if(isDefined(self.fnshouldplaypainanim)) {
    return self[[self.fnshouldplaypainanim]]();
  }

  if(self.a.disablepain) {
    return 0;
  }

  if(self.allowpain == 0) {
    return 0;
  }

  if(self.var_28a81dd923b494fe) {
    return 0;
  }

  if(isDefined(self.pathgoalpos) && self pathdisttogoal(var_87bc3552a49f9d07) < 64) {
    return 0;
  }

  return 1;
}

function private updatepainvars(damagedsubpart) {
  if(self.damageshield && !isDefined(self.disabledamageshieldpain)) {
    if(!isDefined(self.a.lastpaintime)) {
      self.a.lastpaintime = 0;
    }

    if(!isDefined(self.damageshieldcounter) || gettime() - self.a.lastpaintime > 1500) {
      self.damageshieldcounter = randomintrange(2, 3);
    }

    if(isDefined(self.lastattacker) && distancesquared(self.origin, self.lastattacker.origin) < squared(512)) {
      self.damageshieldcounter = 0;
    }

    if(self.damageshieldcounter > 0) {
      self.damageshieldcounter--;
    }
  }

  if(isDefined(damagedsubpart)) {
    self.damagedsubpart = damagedsubpart;
    return;
  }

  self.damagedsubpart = undefined;
}

function asm_settransitionorientmode(orient_mode) {
  if(!isai(self)) {
    return;
  }

  switch (orient_mode) {
    case #"hash_96a6a25bd7beed30":
      var_bea7fb00cbc6d91e = 1024;

      if(utility::actor_is3d()) {
        orient_angles = self.angles;

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_bea7fb00cbc6d91e) {
          orient_angles = self function_dabf98356d840a64(self.node);
        }

        self orientmode("face angle 3d", orient_angles);
      } else {
        yaw = self.angles[1];

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_bea7fb00cbc6d91e) {
          yaw = utility::getnodeforwardyaw(self.node);
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
      assertmsg("<dev string:x72>" + handlername);
      break;
  }
}

function asm_setoverrideparams(asmname, params) {
  assert(isDefined(anim.asmparams));
  assert(isDefined(anim.asmparams[asmname]));
  var_c872504af26084a6 = 9999;
  anim.asmparams[asmname][var_c872504af26084a6] = params;
  return var_c872504af26084a6;
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

function function_5696a376795811d5(newasmname, newarchetype) {
  self asmterminate();
  self notify("asm_terminated");
  self.asmtrackasm = undefined;

  if(!isDefined(newarchetype)) {
    newarchetype = self.animsetname;
  }

  lowerasmname = tolower(newasmname);
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
  if(self.asmforcetrackloop) {
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

function asm_ephemeraleventfired(eventtarget, eventname, var_8f8f4be4171af73) {
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

  if(asm_bb::bb_isanimScripted()) {
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

function function_7256f5ba459c840b(state_name, params) {
  current = self asmgetcurrentstate(self.asmname);

  if(current != state_name) {
    if(isDefined(anim.callbacks["StopAnimscripted"])) {
      self[[anim.callbacks["StopAnimscripted"]]]();
    }

    self asmsetstate(self.asmname, state_name);
  }
}

function asm_tick() {
  assertmsg("<dev string:x87>");
}

function highestallowedstance(asmname, statename, tostatename, stance) {
  assert(isDefined(stance));
  highestallowedstance = utility::gethighestallowedstance();

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
  arcname = utility::function_18bf04f16702b9b2();
  assert(isDefined(arcname), "<dev string:xc7>");
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
      assertmsg("<dev string:xee>");
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
  assert(aliases.size > 0, "<dev string:x131>" + self.animsetname + "<dev string:x15a>" + statename + "<dev string:x160>" + self.classname);
  return aliases[randomint(aliases.size)];
}

function function_a0231b5621315b1(statename, alias) {
  arcname = self.basearchetype;
  assert(isDefined(arcname), "<dev string:x16a>");
  animresult = archetypegetrandomalias(arcname, statename, alias, asm_isfrantic());
  return animresult;
}

function asm_lookupanimfromaliasifexists(statename, alias) {
  arcname = utility::function_18bf04f16702b9b2();
  assert(isDefined(arcname), "<dev string:xc7>");
  animresult = archetypegetrandomalias(arcname, statename, alias, asm_isfrantic());
  return animresult;
}

function function_9cf70e7bc311b2de(statename, alias) {
  arcname = self.basearchetype;
  assert(isDefined(arcname), "<dev string:x16a>");
  animresult = archetypegetrandomalias(arcname, statename, alias, asm_isfrantic());

  if(isint(alias)) {
    alias += "<dev string:x196>";
  }

  assert(isDefined(animresult), "<dev string:x19a>" + getxhashsourcename(alias) + "<dev string:x1b4>" + arcname + "<dev string:x1c8>" + statename + "<dev string:x1d5>" + self.classname + "<dev string:x1e0>");

  return animresult;
}

function asm_lookupanimfromalias(statename, alias) {
  arcname = utility::function_18bf04f16702b9b2();
  assert(isDefined(arcname), "<dev string:xc7>");
  animresult = archetypegetrandomalias(arcname, statename, alias, asm_isfrantic());

  if(isint(alias)) {
    alias += "<dev string:x196>";
  }

  assert(isDefined(animresult), "<dev string:x19a>" + getxhashsourcename(alias) + "<dev string:x1b4>" + arcname + "<dev string:x1c8>" + statename + "<dev string:x1d5>" + self.classname + "<dev string:x1e0>");

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
      anims = arraycombine(anims, animdata.anims);
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

function function_22bfe157adf276dd(asmname, statename, params) {
  self endon(statename + "_finished");
  max_time_s = float(params);
  thread asm_playanimstate(asmname, statename, params);
  wait max_time_s;
  asm_fireevent(asmname, "end");
}

function asm_hasknobs() {
  if(isagent(self) && !self.bsoldier && self.unittype != "civilian" && self.unittype != "dog") {
    return false;
  }

  return true;
}

function function_b7619cbe4e9abaf4(asmname, statename, playbackrate, ismovestate) {
  self endon(statename + "_finished");

  if(!isDefined(playbackrate)) {
    playbackrate = 1;
  }

  if(asm_hasknobs()) {
    bodyknob = asm_getbodyknob();

    if(ismovestate) {
      moveid = asm_lookupanimfromaliasifexists("knobs", "move");

      if(isDefined(moveid)) {
        moveknob = asm_getxanim("knobs", moveid);
        self setmoveanimknob(moveknob);
      }
    }
  }

  notehandler = asm_getnotehandler(asmname, statename);
  timestep = 0.2;
  bmovestate = istrue(ismovestate);
  brestart = 1;

  while(true) {
    loopanim = asm_getanim(asmname, statename);
    loopxanim = asm_getxanim(statename, loopanim);

    if(ismovestate) {
      playbackrate = asm_getmoveplaybackrate();
      self codemoveanimrate(playbackrate);
    }

    if(!bmovestate) {
      brestart = self aigetanimweight(loopxanim) == 0;
    }

    if(isnumber(loopanim)) {
      self aisetanim(statename, loopanim, playbackrate);
    } else {
      assert(utility::issp(), "<dev string:x1e5>");
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

function asm_lookupdirectionalfootanim(keypaddirection, asmname, statename, var_6c70d8d5ac969ca9, optionalprefix) {
  prefix = "";

  if(isDefined(optionalprefix)) {
    prefix = optionalprefix;
  }

  if(var_6c70d8d5ac969ca9) {
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

  var_7237854e3be197ca = asm_lookupanimfromaliasifexists(statename, prefixfoot + keypaddirection);

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  if(prefix != prefixfoot) {
    var_7237854e3be197ca = asm_lookupanimfromaliasifexists(statename, prefix + keypaddirection);

    if(isDefined(var_7237854e3be197ca)) {
      return var_7237854e3be197ca;
    }
  }
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

  assert(isDefined(self.fnasm_handlenotetrack), "<dev string:x23f>");
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
      self.var_d4da0a58a936a837 = 1;
      break;
    case #"hash_39f7ecb43786b597":
      self.var_d4da0a58a936a837 = 0;
      break;
  }
}

function asm_tryhandledeathstatechangenotetrack(notetrack) {
  if(!isstartstr(notetrack, "ds ")) {
    return false;
  }

  charindex = 3;
  assert(notetrack[charindex] == "<dev string:x2a8>", "<dev string:x2ad>");
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
    assert(notetrack[charindex] + notetrack[charindex + 1] == "<dev string:x2f8>", "<dev string:x2fe>");
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
  var_246417e0e941e01b = statename + "_endHelper";
  self endon(sztimedout);
  childthread asm_donotetrackswithtimeout_helper(var_246417e0e941e01b, sztimedout, timeout);
  retval = asm_donotetracks(asmname, statename, customfunction, customparams);
  self notify(var_246417e0e941e01b);
  return retval;
}

function asm_donotetracks(asmname, statename, customfunction, customparams, customflagname, var_ecd7cff44d4c6bbc) {
  if(!isDefined(var_ecd7cff44d4c6bbc)) {
    var_ecd7cff44d4c6bbc = 1;
  }

  for(;;) {
    val = asm_dosinglenotetrack(asmname, statename, customfunction, customparams, customflagname);

    if(isDefined(val)) {
      if(var_ecd7cff44d4c6bbc && !asm_eventfired(asmname, "end")) {
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

    last_defined_val = undefined;

    foreach(note in notes) {
      asm_fireevent(asmname, note);
      intercepted = [[interceptfunction]](statename, note, interceptparams);

      if(intercepted) {
        continue;
      }

      assert(isDefined(self.fnasm_handlenotetrack));
      val = [[self.fnasm_handlenotetrack]](note, statename, undefined, undefined) ?? asm_handlenewnotetracks(asmname, note, statename);

      if(isDefined(val)) {
        last_defined_val = val;
      }
    }

    var_7237854e3be197ca = last_defined_val;

    if(isDefined(var_7237854e3be197ca)) {
      return var_7237854e3be197ca;
    }
  }
}

function asm_donotetrackssingleloop(asmname, statename, xanim, customfunction) {
  notifyname = statename + "_note_loop_end";
  self endon(notifyname);
  animlength = getanimlength(xanim);
  assert(animlength > 0, "<dev string:x358>" + statename + "<dev string:x373>" + getxhashsourcename(getanimname(xanim)) + "<dev string:x37e>");
  thread asm_donotetrackssingleloop_waiter(notifyname, statename + "_finished", animlength);
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
  assert(isDefined(self.animsetname), "<dev string:xc7>");
  archetype = self.animsetname;
  aliases = archetypegetaliases(archetype, statename);
  possible = 0;
  chosen = undefined;
  prefixlen = -1;

  if(isDefined(optionalprefix)) {
    prefixlen = optionalprefix.size;
  }

  if(!isDefined(aliases)) {
    if(!allownone) {
      msg = "<dev string:x393>" + statename + "<dev string:x3bb>" + archetype;

      if(isDefined(optionalprefix)) {
        msg += "<dev string:x3cd>" + optionalprefix;
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

  if(!allownone && !isDefined(chosen)) {
    msg = "<dev string:x393>" + statename + "<dev string:x3bb>" + archetype;

    if(isDefined(optionalprefix)) {
      msg += "<dev string:x3cd>" + optionalprefix;
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
      assertmsg("<dev string:x3de>" + asmname + "<dev string:x445>" + statename);
      return undefined;
    }

    return;
  }

  result = undefined;
  prefixstr = asm_bb::bb_getprefixstring(params);

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

    if(isDefined(self.var_2eb71d32b982e8a4)) {
      facialknob = asm_lookupanimfromalias("knobs", "head_fakeactor");
      self clearanim(asm_getxanim("knobs", facialknob), 0.2);
      return;
    }

    utility::setfacialindexfornonai("none");
  }
}

function asm_restorefacialanim() {
  asmname = self.asmname;
  statename = self asmgetcurrentstate(asmname);

  if(statename == "animscripted" || self function_fb1905f4ebf9177f(asmname)) {
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

  animid = function_9cf70e7bc311b2de("knobs", "root");
  return function_e9dad979e1b462c6("knobs", animid);
}

function asm_getbodyknob() {
  animid = asm_lookupanimfromaliasifexists("knobs", "body");

  if(isDefined(animid)) {
    return asm_getxanim("knobs", animid);
  }

  animid = function_9cf70e7bc311b2de("knobs", "body");
  return function_e9dad979e1b462c6("knobs", animid);
}

function asm_getinnerrootknob() {
  animid = asm_lookupanimfromaliasifexists("knobs", "inner_root");

  if(isDefined(animid)) {
    return asm_getxanim("knobs", animid);
  }

  animid = function_a0231b5621315b1("knobs", "inner_root");

  if(isDefined(animid)) {
    return function_e9dad979e1b462c6("knobs", animid);
  }

  return asm_getbodyknob();
}

function asm_getfacialknob() {
  animid = asm_lookupanimfromaliasifexists("always_on", "facial");

  if(isDefined(animid)) {
    return asm_getxanim("always_on", animid);
  }

  animid = function_a0231b5621315b1("always_on", "facial");

  if(isDefined(animid)) {
    return function_e9dad979e1b462c6("always_on", animid);
  }
}

function asm_getheadlookknobifexists() {
  animid = asm_lookupanimfromaliasifexists("knobs", "headlook");

  if(isDefined(animid)) {
    return asm_getxanim("knobs", animid);
  }

  animid = function_a0231b5621315b1("knobs", "headlook");

  if(isDefined(animid)) {
    return function_e9dad979e1b462c6("knobs", animid);
  }
}

function asm_isweaponoverride() {
  currentweapon = self.weapon;
  weapon = getweaponbasename(currentweapon);
  weapontypeoverrides = ["iw7_cheytac", "iw7_kbs", "iw7_m1", "iw7_m8", "iw7_mauler", "iw7_sdflmg", "iw7_ameli", "iw7_steeldragon", "iw7_sonic", "iw7_sdfshotty", "iw7_spas"];

  if(isDefined(weapon) && arraycontains(weapontypeoverrides, weapon)) {
    return true;
  }

  return false;
}

function function_e9dad979e1b462c6(statename, animid) {
  assert(isDefined(statename));
  assert(isDefined(animid), "<dev string:x451>" + statename);

  if(isnumber(animid)) {
    archetype = self.basearchetype;
    return animsetgetanimfromindex(archetype, statename, animid);
  }

  return animid;
}

function asm_getxanim(statename, animid) {
  assert(isDefined(statename));
  assert(isDefined(animid), "<dev string:x451>" + statename);

  if(isnumber(animid)) {
    archetype = utility::function_18bf04f16702b9b2();
    assert(animid != -1, "<dev string:x47a>" + statename + "<dev string:x49c>" + archetype);
    return animsetgetanimfromindex(archetype, statename, animid);
  }

  return animid;
}

function asm_playanimstatewithnotetrackinterceptor(asmname, statename, var_ec9a99e9158712bf, var_c4d43a269775940d) {
  self endon(statename + "_finished");
  animid = asm_getanim(asmname, statename);
  self aisetanim(statename, animid);
  asm_playfacialanim(asmname, statename, asm_getxanim(statename, animid));
  endnote = asm_donotetrackswithinterceptor(asmname, statename, var_ec9a99e9158712bf, var_c4d43a269775940d);

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

function function_48f01027f17c6d8(statename, aliasname) {
  self endon("death");
  asm_bb::bb_setanimScripted();
  self asmsetstate(self.asmname, "animscripted");
  animindex = asm_lookupanimfromalias(statename, aliasname);
  self aisetanim(statename, animindex);
  xanim = asm_getxanim(statename, animindex);
  animlength = getanimlength(xanim);
  wait animlength;
  asm_bb::bb_clearanimScripted();
}

function asm_playadditiveanimloopstate(asmname, statename, params) {
  assert(isDefined(self.fnasm_playadditiveanimloopstate));
  [[self.fnasm_playadditiveanimloopstate]](asmname, statename, params);
}

function function_24133a663bba593c() {
  normalizedtime = self getnormalizedanimtime();
  self restartanim(normalizedtime);
}

function function_d82cb83c9c260d49(rate) {
  self.animplaybackratedefault = rate;
}

function function_27be172b46a89235() {
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

function function_ae2d2cb168819b86() {
  dvar = getDvar(@ "debug_arrivals");

  if(dvar == "<dev string:x4a4>") {
    return 0;
  }

  if(dvar == "<dev string:x4ab>") {
    return 1;
  }

  if(int(dvar) == self getentitynumber()) {
    return 1;
  }

  return 0;
}

function debug_arrival(msg) {
  if(!function_ae2d2cb168819b86()) {
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

  if(getdvarint(@ "hash_96f0961c5045c40f", 1) == 0) {
    count = 0;

    foreach(t in getnodearray("traverse", #targetname)) {
      t traversethink();
      count++;

      if(count > 1000) {
        count = 0;
        waitframe();
      }
    }

    callback::callback("setup_all_traversals");
  }

  foreach(t in getnodearray("<dev string:x4b1>", #targetname)) {
    t thread deprecatedtraversethink();
  }

  level thread drawtraversaldata();
  level thread function_29d96ec9eaf4d567();
}

function setup_level_ents_procedural() {
  foreach(t in getallnodes()) {
    if(t.type == "Begin" && !isDefined(t.traverse_height)) {
      t function_80f47e6604a0bd05();
      waitframe();
    }
  }
}

function function_222bc7369d339dc0(startnode) {
  startnode function_80f47e6604a0bd05();
}

function processdoublejumpmantletraversal(target) {
  assert(isDefined(target));
  self.doublejumpmantlepos = target.origin;
  self.startnodeoriginalangles = self.angles;

  if(isent(target)) {
    target delete();
    return;
  }

  utility::deletestruct_ref(target);
}

function function_83faa08e56039deb(startnode) {
  ent = undefined;

  if(!level.var_13b70b3b5724494f) {
    ent = utility::getStruct(startnode.target, "targetname");
  }

  if(isDefined(ent) && startnode.animscript == "traverse_wall") {
    startnode function_10f85acdeccd847f(ent);
    startnode.var_213a703686d12d7a = 1;
    return;
  } else if(startnode.animscript == "traverse_ground") {
    startnode function_1ac102ffa6ca2786(ent);
    startnode.var_213a703686d12d7a = 1;
    return;
  }

  traversedata = gettraversaldata(startnode);

  if(traversedata.var_2ad2e2c048afac29) {
    startnode.apex_delta = traversedata.apexdelta;
    startnode.endpos = traversedata.endposition;
    startnode.traverse_height = traversedata.traverseheight;
    startnode.traverse_height_delta = traversedata.traverseheightdelta;
    startnode.traverse_drop_height_delta = traversedata.var_a0a64078ec2e6068;
    startnode.var_213a703686d12d7a = 1;

    if(traversedata.var_73675b828542c89c) {
      startnode.across_delta = traversedata.acrossdelta;
    }

    if(isDefined(self.parentname)) {
      startnode store_original_traverse_data();
    }
  } else {
    startnode traversethink();
  }

  if(!isDefined(startnode.traverse_height)) {
    callback::callback("setup_traversal", startnode);
  }
}

function traversethink() {
  ent = getEnt(self.target, #targetname);

  if(!isDefined(ent)) {
    ent = utility::getStruct(self.target, "targetname");
  }

  end_node = getnode(self.target, #targetname);

  if(!isDefined(end_node)) {
    if(level.script != "mp_jup_map" && level.script != "mp_jup_bigmap_wz2" && level.script != "mp_jup_bm_live_wz2" && level.script != "mp_jup_bm_wz2_s4") {
      assert(isDefined(end_node), "<dev string:x4c8>" + self.origin + "<dev string:x517>" + self.target);
    }

    logstring("^1Warning: Unable to find matching negotiation_end_node for negotiation_start_node at " + self.origin + " " + self.target);
    return;
  }

  if(self.animscript == "traverse_ground") {
    function_1ac102ffa6ca2786(ent);
    return;
  }

  if(!isDefined(ent)) {
    println("<dev string:x51c>" + self.animscript + "<dev string:x53e>");
    calculate_traverse_data(averagepoint([self.origin, end_node.origin]), end_node.origin);
    return;
  }

  switch (self.animscript) {
    case #"hash_8f681d217a32aef7":
      processwallruntraversal(ent);
      return;
    case #"hash_2517ba3af2f13858":
      function_10f85acdeccd847f(ent);
      return;
    case #"hash_6fc6878fd3fd1e7a":
    case #"hash_d14662a6eb371af5":

      if(getdvarint(@ "hash_a838875af4383ca1", 0) != 0) {
        if(isDefined(self.target)) {
          node = getnode(self.target, #targetname);

          if(isDefined(node)) {
            self.var_52abd4c0d33d2de2 = node.origin;
          }
        }
      }

      processdoublejumpmantletraversal(ent);
      return;
    case #"hash_5f054fa72e77b8dd":

      if(getdvarint(@ "hash_a838875af4383ca1", 0) != 0) {
        if(isDefined(self.target)) {
          node = getnode(self.target, #targetname);

          if(isDefined(node)) {
            self.var_52abd4c0d33d2de2 = node.origin;
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
        self.var_52abd4c0d33d2de2 = getnode(self.target, #targetname).origin;
        self.var_fb3c10ddbdbd47bc = ent.origin;
      }

      break;
    default:
      break;
  }

  if(isDefined(ent.target) && (level.script != "mp_jup_bigmap" && level.script != "mp_jup_bigmap_wz2" && level.script != "mp_jup_bm_live_wz2" && level.script != "mp_jup_bm_wz2_s4" || !isendstr(ent.target, "auto12190374188911454432"))) {
    ent2 = getEnt(ent.target, #targetname);

    if(!isDefined(ent2)) {
      ent2 = utility::getStruct(ent.target, "targetname");
    }

    assert(isDefined(ent2), self.animscript + "<dev string:x5aa>" + self.origin + "<dev string:x5bb>" + ent.targetname + "<dev string:x5c8>" + ent.origin + "<dev string:x5d0>" + ent.target);

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

  utility::deletestruct_ref(ent);
}

function function_80f47e6604a0bd05() {
  apex_pos = undefined;
  end_node = getnode(self.target, #targetname);
  assert(isDefined(end_node), "<dev string:x4c8>" + self.origin + "<dev string:x517>" + self.target);
  apex_pos = function_5f6e47af34199e3a(self.origin, end_node.origin);

  if(!isDefined(apex_pos)) {
    assertmsg("<dev string:x5f4>" + self.origin + "<dev string:x634>");
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

  if(isDefined(self.endpos)) {
    self.original_data.endnode_pos = self.endpos;
    return;
  }

  end_node = getnode(self.target, #targetname);

  if(isDefined(end_node)) {
    self.original_data.endnode_pos = end_node.origin;
  }
}

function calculate_traverse_data(struct_pos, endnode_pos, struct2_pos) {
  assert(self.type == "<dev string:x674>");

  if(self.animscript == "ladder_up" || self.animscript == "ladder_down") {
    ladderend = struct2_pos ?? struct_pos ?? endnode_pos;
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
    var_f5f5d5a5a8e43492 = rotatevector(ref_node.original_data.across_delta_local, self.angles);
    struct2_pos = struct_pos + var_f5f5d5a5a8e43492;
  }

  calculate_traverse_data(struct_pos, endnode_pos, struct2_pos);
}

function processwallruntraversal(target) {
  assert(isDefined(target));
  wallendnode = getEnt(target.target, #targetname);

  if(!isDefined(wallendnode)) {
    wallendnode = utility::getStruct(target.target, "targetname");
  }

  assert(isDefined(wallendnode));

  dist = distance(self.origin, target.origin);

  if(dist > 400) {
    println("<dev string:x67d>" + self.origin + "<dev string:x6b5>" + dist + "<dev string:x6d0>" + 400);
  }

  self.wall_info = spawnStruct();
  var_767e71695667e555 = target;
  numnodes = 0;
  self.wall_info.startnodeoriginalangles = self.angles;

  deltaz = var_767e71695667e555.origin[2] - self.origin[2];

  if(deltaz > 208) {
    println("<dev string:x6d7>" + var_767e71695667e555.origin + "<dev string:x705>" + deltaz + "<dev string:x6d0>" + 208);
  }

  walldir = undefined;

  while(isDefined(var_767e71695667e555)) {
    self.wall_info.nodeoffsets[numnodes] = var_767e71695667e555.origin - self.origin;
    numnodes++;
    var_1201543d3f39d723 = utility::getStruct(var_767e71695667e555.target, "targetname");
    assert(isDefined(var_1201543d3f39d723));

    dist = distance(var_767e71695667e555.origin, var_1201543d3f39d723.origin);

    if(dist > 544) {
      println("<dev string:x732>" + var_767e71695667e555.origin + "<dev string:x756>" + dist + "<dev string:x6d0>" + 544);
    }

    walldir = vectorNormalize(var_1201543d3f39d723.origin - var_767e71695667e555.origin);
    dirtowall = var_767e71695667e555.origin - self.origin;
    dirtowall = (dirtowall[0], dirtowall[1], 0);
    dirtowall = vectorNormalize(dirtowall);
    dotprod = vectordot(walldir, dirtowall);

    if(dotprod < 0) {
      println("<dev string:x771>" + self.origin + "<dev string:x796>");
    }

    utility::deletestruct_ref(var_767e71695667e555);
    var_767e71695667e555 = var_1201543d3f39d723;
    assert(isDefined(var_767e71695667e555));
    self.wall_info.nodeoffsets[numnodes] = var_767e71695667e555.origin - self.origin;
    numnodes++;

    if(isDefined(var_767e71695667e555.target)) {
      temp = utility::getStruct(var_767e71695667e555.target, "targetname");
    } else {
      temp = undefined;
    }

    utility::deletestruct_ref(var_767e71695667e555);
    var_767e71695667e555 = temp;

    if(!isDefined(var_767e71695667e555)) {
      traversalendnode = getnode(self.target, #targetname);
      assert(isDefined(traversalendnode));
      assert(isDefined(walldir));
      dirtoendnode = traversalendnode.origin - var_1201543d3f39d723.origin;
      dirtoendnode = (dirtoendnode[0], dirtoendnode[1], 0);
      dirtoendnode = vectorNormalize(dirtoendnode);
      dotprod = vectordot(dirtoendnode, walldir);

      if(dotprod < 0) {
        println("<dev string:x771>" + self.origin + "<dev string:x7c0>");
      }

      dist = distance(var_1201543d3f39d723.origin, traversalendnode.origin);

      if(dist > 512) {
        println("<dev string:x771>" + self.origin + "<dev string:x808>" + dist + "<dev string:x6d0>" + 512);
      }
    }

    if(isDefined(var_767e71695667e555) && isDefined(var_767e71695667e555.script_wallrun_type)) {
      if(var_767e71695667e555.script_wallrun_type == "wallrun_mantle") {
        dist = distance(var_1201543d3f39d723.origin, var_767e71695667e555.origin);
        deltaz = var_767e71695667e555.origin[2] - var_1201543d3f39d723.origin[2];

        if(deltaz > 0) {
          if(dist > 420) {
            println("<dev string:x83a>" + var_767e71695667e555.origin + "<dev string:x882>" + dist + "<dev string:x6d0>" + 420);
          }

          if(deltaz > 200) {
            println("<dev string:x894>" + var_767e71695667e555.origin + "<dev string:x8c3>" + deltaz + "<dev string:x6d0>" + 200);
          }
        } else if(dist > 512) {
          println("<dev string:x8f3>" + var_767e71695667e555.origin + "<dev string:x882>" + dist + "<dev string:x6d0>" + 512);
        }

        self.wall_info.mantleoffset = var_767e71695667e555.origin - self.origin;

        if(isDefined(var_767e71695667e555.angles)) {
          self.wall_info.mantleangles = var_767e71695667e555.angles;
        }

        utility::deletestruct_ref(var_767e71695667e555);
        break;
      }

      if(var_767e71695667e555.script_wallrun_type == "wallrun_vault") {
        self.wall_info.mantleoffset = var_767e71695667e555.origin - self.origin;
        self.wall_info.bvaultover = 1;

        deltaz = var_767e71695667e555.origin[2] - var_1201543d3f39d723.origin[2];

        if(deltaz > 164) {
          println("<dev string:x93b>" + var_767e71695667e555.origin + "<dev string:x8c3>" + deltaz + "<dev string:x6d0>" + 164);
        }

        utility::deletestruct_ref(var_767e71695667e555);
        break;
      }
    }
  }
}

function function_1ac102ffa6ca2786(target) {
  self.walk_nodes = [];
  self.walk_nodes[self.walk_nodes.size] = self.origin;

  for(currentgoal = target; isDefined(currentgoal); currentgoal = undefined) {
    self.walk_nodes[self.walk_nodes.size] = currentgoal.origin;

    if(isDefined(currentgoal.target)) {
      currentgoal = utility::getStruct(currentgoal.target, "targetname");
      continue;
    }
  }

  end_node = getnode(self.target, #targetname);

  if(isDefined(end_node)) {
    self.walk_nodes[self.walk_nodes.size] = end_node.origin;
  }

  self.traverse_height = 0;
}

function function_10f85acdeccd847f(target) {
  assert(isDefined(target));
  self.wall_nodes = [];
  self.wall_angles = [];
  self.var_62d0d61e122d910 = [];
  var_e154fb7c68162084 = 10;
  var_c4fc7876bc56e462 = 12;
  var_1d85dff58a96d23c = 10;
  var_9c8376fad05b0e33 = 8;
  contents = trace::create_contents(0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0);
  currentgoal = target;

  while(isDefined(currentgoal)) {
    upvec = anglestoup(currentgoal.angles);
    var_b1a02f9b65f21f23 = currentgoal.origin + upvec * var_c4fc7876bc56e462;
    endwalltracepos = currentgoal.origin + -1 * upvec * var_c4fc7876bc56e462;
    walltrace = physics_raycast(var_b1a02f9b65f21f23, endwalltracepos, trace::create_world_contents(), [], 0, "physicsquery_closest");

    if(isDefined(walltrace[0]["position"])) {
      self.wall_nodes[self.wall_nodes.size] = walltrace[0]["position"] + upvec * var_1d85dff58a96d23c;
    } else {
      self.wall_nodes[self.wall_nodes.size] = currentgoal.origin + -1 * upvec * var_9c8376fad05b0e33;
    }

    self.wall_angles[self.wall_angles.size] = currentgoal.angles;

    if(isDefined(currentgoal.var_755f0cc0b4d3c984)) {
      self.var_62d0d61e122d910[self.var_62d0d61e122d910.size] = currentgoal.var_755f0cc0b4d3c984;
    } else {
      self.var_62d0d61e122d910[self.var_62d0d61e122d910.size] = var_e154fb7c68162084;
    }

    oldgoal = currentgoal;

    if(isDefined(currentgoal.target)) {
      currentgoal = utility::getStruct(currentgoal.target, "targetname");
    } else {
      currentgoal = undefined;
    }

    utility::deletestruct_ref(oldgoal);
  }

  assert(self.wall_nodes.size >= 2 && self.wall_nodes.size == self.var_62d0d61e122d910.size);
  self.traverse_height = 0;
}

function function_5f6e47af34199e3a(begin_pos, end_pos) {
  apex_pos = undefined;
  original_begin_pos = begin_pos;
  original_end_pos = end_pos;
  var_fc77e113f1f988eb = utility::flatten_vector(end_pos - begin_pos);
  delta_z = abs(end_pos[2] - begin_pos[2]);
  start_z = min(begin_pos[2], end_pos[2]);
  current_z = max(begin_pos[2], end_pos[2]) + 1;
  begin_pos = (begin_pos[0], begin_pos[1], current_z);
  end_pos = (end_pos[0], end_pos[1], current_z);
  trace_end = physicstrace(begin_pos, end_pos);
  var_e4890a00d660c30f = 0.01;
  dist = distance2dsquared(trace_end, end_pos);

  if(dist < var_e4890a00d660c30f) {
    if(original_begin_pos[2] < original_end_pos[2]) {
      temp_pos = begin_pos;
      begin_pos = end_pos;
      end_pos = temp_pos;
    }

    iteration_limit = 3;
    cliff_pos = begin_pos;
    mid_point = undefined;
    var_e4fcddb41dacefb8 = undefined;

    for(i = 0; i < iteration_limit; i++) {
      mid_point = averagepoint([begin_pos, end_pos]);
      pit_height = 20;
      var_2709bf035525ea1d = mid_point - (0, 0, pit_height);
      trace_end = physicstrace(mid_point, var_2709bf035525ea1d);
      var_66b1882ab25c63a = vectordot(vectorNormalize(begin_pos - trace_end), vectorNormalize(end_pos - trace_end));

      if(trace_end == var_2709bf035525ea1d) {
        end_pos = mid_point;
        var_e4fcddb41dacefb8 = mid_point;
        continue;
      }

      begin_pos = mid_point;
      cliff_pos = trace_end;
    }

    if(isDefined(var_e4fcddb41dacefb8)) {
      var_99cbc7d598ae5812 = (var_e4fcddb41dacefb8[0], var_e4fcddb41dacefb8[1], cliff_pos[2] - 1);
      apex_pos = physicstrace(var_99cbc7d598ae5812, cliff_pos);
      apex_pos = (apex_pos[0], apex_pos[1], min(apex_pos[2], mid_point[2]));
    } else {
      apex_pos = (cliff_pos[0], cliff_pos[1], min(cliff_pos[2], mid_point[2]));
    }
  } else {
    found_top = 0;
    previous_trace_end = trace_end;
    iteration_limit = 10;
    iteration_index = 0;
    z_step_increment = 15;

    while(!found_top && iteration_index < iteration_limit) {
      current_z += z_step_increment;
      begin_pos = (begin_pos[0], begin_pos[1], current_z);
      end_pos = (end_pos[0], end_pos[1], current_z);
      trace_end = physicstrace(begin_pos, end_pos);

      if(distance2dsquared(trace_end, end_pos) < var_e4890a00d660c30f) {
        found_top = 1;
      } else {
        previous_trace_end = trace_end;
      }

      iteration_index++;
    }

    if(found_top) {
      above_top = previous_trace_end + var_fc77e113f1f988eb + (0, 0, z_step_increment);
      apex_pos = physicstrace(above_top, above_top - (0, 0, z_step_increment));
    }

    if(!isDefined(apex_pos)) {
      println("<dev string:x969>" + iteration_limit + "<dev string:x9b8>" + begin_pos);
    }
  }

  return apex_pos;
}

function function_1b867cf5be4cf0b(asmname, statename, params) {
  self notify("agent_scene_stop");
  self clearoverridearchetype("animscript");
}

function function_85622bf0cacb63d6(door) {
  if(door scriptableisdoor() && door scriptabledoorisclosed()) {
    return false;
  }

  curstate = door getscriptablepartstate("door", 1);
  assert(isDefined(curstate));

  if(curstate == "closed" || curstate == "setup") {
    return false;
  }

  doortome = self.origin - door.origin;
  var_a0dfb0032303fa04 = vectortoyaw(doortome);
  doorclosedangles = door function_9ae4daa2a11c58bd();
  anglediff = angleclamp180(var_a0dfb0032303fa04 - doorclosedangles[1]);
  openangle = angleclamp180(door.angles[1] - doorclosedangles[1]);
  return anglediff * openangle > 0;
}

function function_a4a0d4a33b623013(door) {
  assert(isDefined(self._blackboard.doorpos));
  return self._blackboard.doorpos;
}

function deprecatedtraversethink() {
  wait 0.05;
  println("<dev string:x9d4>" + self.origin);

  if(getdvarint(@ "scr_traverse_debug")) {
    while(true) {
      print3d(self.origin, "<dev string:xa19>");
      wait 0.05;
    }
  }
}

function validatetraverse(traverse) {
  return traverse == "<dev string:xa31>" || traverse == "<dev string:xa45>" || traverse == "<dev string:xa5b>" || traverse == "<dev string:xa71>" || traverse == "<dev string:xa89>" || traverse == "<dev string:xaa3>" || traverse == "<dev string:xab6>";
}

function validatetraversenodes() {
  println("<dev string:xac7>");

  foreach(t in getnodearray("<dev string:xae6>", #targetname)) {
    if(!validatetraverse(t.animscript)) {
      continue;
    }

    if(getdvarint(@ "hash_96f0961c5045c40f", 1) != 0) {
      if(!t.var_213a703686d12d7a) {
        function_83faa08e56039deb(t);
      }
    }

    s = 20;

    while(s < 280) {
      yaw = -180;

      while(yaw <= 180) {
        featurearray = [];
        featurearray["<dev string:xaf2>"] = t.traverse_height_delta;
        featurearray["<dev string:xafc>"] = t.traverse_drop_height_delta;
        featurearray["<dev string:xb0b>"] = yaw;
        featurearray["<dev string:xb1a>"] = s;

        if(t.animscript == "<dev string:xa71>") {
          featurearray["<dev string:xb23>"] = length2d(t.across_delta);
        }

        alias = level animselector::selectanim(t.animscript, featurearray, 0);

        if(alias == "<dev string:xb2d>") {
          nodestring = "<dev string:xb38>";
          nodestring = nodestring + "<dev string:xb78>" + t.animscript;
          nodestring = nodestring + "<dev string:xb83>" + t.origin;
          nodestring = nodestring + "<dev string:xb8f>" + t.traverse_height_delta;
          nodestring = nodestring + "<dev string:xb9f>" + t.traverse_drop_height_delta;
          nodestring = nodestring + "<dev string:xbad>" + s;
          nodestring = nodestring + "<dev string:xbbc>" + yaw;

          if(t.animscript == "<dev string:xa71>") {
            nodestring = nodestring + "<dev string:xbc9>" + length2d(t.across_delta);
          }

          nodestring += "<dev string:xbd9>";
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
      if(t.type == "<dev string:x674>") {
        if(getdvarint(@ "hash_96f0961c5045c40f", 1) != 0) {
          if(!t.var_213a703686d12d7a) {
            function_83faa08e56039deb(t);
          }
        }

        if(isDefined(t.traverse_height)) {
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
}

function private function_29d96ec9eaf4d567() {
  level endon("<dev string:xbdf>");
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

  room_nodes_struct = spawnStruct();
  room_nodes_struct.room_nodes = [];
  room_nodes_struct.var_4c1eb3cfe83f0e70 = [];
  level childthread function_ef87eba444c374a5(room_nodes_struct);
  iprintlnbold("<dev string:xbed>");
  room_index = 0;
  room_node = getroomnodeforindex(room_index);
  room_node = {
    #origin: getclosestpointonnavmesh(room_node.origin)
  };
  var_7483aac93b95a062 = 0;

  while(isDefined(room_node)) {
    calculated_island_id = undefined;
    var_dd9d1d4ea45f231 = [];

    foreach(prev_room_node in room_nodes_struct.room_nodes) {
      can_pathfind = 0;
      dist = distance(room_node.origin, prev_room_node.origin);

      if(dist > 4000) {
        continue;
      }

      if(calculated_island_id == prev_room_node.island_id) {
        can_pathfind = 1;
      } else if(!can_pathfind) {
        path1 = findpathcustom(room_node.origin, prev_room_node.origin);
        can_pathfind = function_368265f3dd2ea684(path1, prev_room_node.origin);

        if(can_pathfind) {
          path2 = findpathcustom(prev_room_node.origin, room_node.origin);
          can_pathfind = function_368265f3dd2ea684(path2, room_node.origin);
        }
      }

      if(can_pathfind) {
        if(!isDefined(calculated_island_id)) {
          calculated_island_id = prev_room_node.island_id;
        }

        calculated_island_id = min(calculated_island_id, prev_room_node.island_id);
        var_dd9d1d4ea45f231[var_dd9d1d4ea45f231.size] = prev_room_node;
      }
    }

    foreach(prev_room_node in var_dd9d1d4ea45f231) {
      prev_room_node.island_id = int(calculated_island_id);
    }

    room_nodes_struct.room_nodes[room_nodes_struct.room_nodes.size] = room_node;

    if(!isDefined(calculated_island_id)) {
      room_node.island_id = int(var_7483aac93b95a062);
      var_7483aac93b95a062++;
    } else {
      room_node.island_id = int(calculated_island_id);
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

  foreach(room_node in room_nodes_struct.room_nodes) {
    if(!isDefined(room_nodes_struct.var_4c1eb3cfe83f0e70[room_node.island_id])) {
      room_nodes_struct.var_4c1eb3cfe83f0e70[room_node.island_id] = 0;
    }

    room_nodes_struct.var_4c1eb3cfe83f0e70[room_node.island_id] += 1;
  }

  waitframe();
  logstring("<dev string:xc13>");

  foreach(room_node in room_nodes_struct.room_nodes) {
    if(room_nodes_struct.var_4c1eb3cfe83f0e70[room_node.island_id] == 1) {
      logstring("<dev string:xc4f>" + room_node.origin);
    }
  }

  iprintlnbold("<dev string:xc70>");
}

function private function_368265f3dd2ea684(path, end_point) {
  if(isDefined(path) && path.size > 0) {
    dist = distance(path[path.size - 1], end_point);
    return (dist < 10);
  }

  return 0;
}

function private function_ef87eba444c374a5(room_nodes_struct) {
  var_afc64bc64c4c9d95 = [];
  render_frames = int(ceil(1 / level.framedurationseconds));

  while(true) {
    if(getdvarint(@ "hash_e42ac6b1ddb1188e", 0) <= 0) {
      waitframe();
      continue;
    }

    foreach(room_node in room_nodes_struct.room_nodes) {
      if(!isDefined(var_afc64bc64c4c9d95[room_node.island_id])) {
        var_afc64bc64c4c9d95[room_node.island_id] = (randomfloat(1), randomfloat(1), randomfloat(1));
      }

      col = var_afc64bc64c4c9d95[room_node.island_id];
      alpha = 1;

      if(isDefined(room_nodes_struct.var_4c1eb3cfe83f0e70[room_node.island_id])) {
        if(room_nodes_struct.var_4c1eb3cfe83f0e70[room_node.island_id] == 1) {
          line(room_node.origin, room_node.origin + (0, 0, 4000), col, undefined, 0, render_frames);
          sphere(room_node.origin + (0, 0, 4000), 500, col, 1, render_frames);
        } else if(room_nodes_struct.var_4c1eb3cfe83f0e70[room_node.island_id] > 50) {
          alpha = 0.5;

          if(distance(room_node.origin, level.players[0].origin) > 2000) {
            continue;
          }
        }
      }

      sphere(room_node.origin, 20, col, 0, render_frames);
      print3d(room_node.origin + (0, 0, 10), "<dev string:xc9f>" + room_node.island_id, col, alpha, undefined, render_frames);
    }

    wait 1;
  }
}

function freeze_ai() {
  self.default_animrate = function_27be172b46a89235();
  function_d82cb83c9c260d49(1e-06);
  function_24133a663bba593c();
  self.aifrozen = 1;
  self setlookatenabled(0);
}

function unfreeze_ai() {
  if(isDefined(self.default_animrate)) {
    function_d82cb83c9c260d49(self.default_animrate);
    function_24133a663bba593c();
  }

  self.aifrozen = 0;
  self setlookatenabled(1);
}