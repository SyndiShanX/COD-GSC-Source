/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\asm.gsc
***********************************************/

function asm_getfunction(var_0, var_1) {
  return anim.asmfuncs[var_0][var_1];
}

function asm_getgenerichandler() {
  return &asm_generichandler;
}

function asm_getparams(var_0, var_1) {
  return anim.asmparams[var_0][var_1];
}

function asm_setupaim(var_0, var_1, var_2, var_3) {
  if(isDefined(self.fnasm_setupaim)) {
    self[[self.fnasm_setupaim]](var_0, var_1, var_2, var_3);
    return;
  }
}

function asm_settransitionorientmode(var_0) {
  switch (var_0) {
    case "face node":
      var_1 = 1024;

      if(scripts\engine\utility::actor_is3d()) {
        var_2 = self.angles;

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_1) {
          var_2 = scripts\asm\shared\utility::getnodeforwardangles(self.node);
        }

        self orientmode("face angle 3d", var_2);
      } else {
        var_3 = self.angles[1];

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_1) {
          var_3 = scripts\asm\shared\utility::getnodeforwardyaw(self.node);
        }

        self orientmode("face angle", var_3);
      }

      break;
    case "face current":
      self orientmode("face angle 3d", self.angles);
      break;
    default:
      self orientmode(var_0);
      break;
  }
}

function asm_settransitionanimmode(var_0) {
  if(isDefined(self.fnasm_setanimmode)) {
    self[[self.fnasm_setanimmode]](var_0);
    return;
  }

  self animmode(var_0, 0);
}

function asm_generichandler(var_0, var_1, var_2, var_3, var_4) {
  switch (var_0) {
    case "orientmode":
      asm_settransitionorientmode(var_2);
      break;
    case "setupaim":
      asm_setupaim(var_1, var_2, 0.2, undefined);
      break;
    case "setupgesture":
      if(isDefined(self.fnasm_setupgesture)) {
        self[[self.fnasm_setupgesture]](var_1, var_2);
      }

      break;
    case "archetype":
      self.asm.archetype = var_2;
      self.animationarchetype = var_2;
      break;
    case "note":
      var_5 = asm_getnotehandler(var_1, undefined);
      var_6 = [[self.fnasm_handlenotetrack]](var_3, var_2, var_5, undefined);

      if(!isDefined(var_6)) {
        var_6 = asm_handlenewnotetracks(var_1, var_3, var_2);
      }

      if(isDefined(var_6) && !asm_eventfired(var_1, "end")) {
        asm_fireevent(var_1, "end");
      }

      break;
    case "waitfordooropen":
      thread scripts\asm\shared\utility::waitfordooropen(var_1, var_2, var_3);
      break;
    case "move_threads":
      var_7 = var_2;
      thread scripts\asm\shared\utility::waitforcoverapproach(var_1, var_7);
      thread scripts\asm\shared\utility::waitforsharpturn(var_1, var_7);
      break;
    default:
      break;
  }
}

function asm_setoverrideparams(var_0, var_1) {
  var_2 = 9999;
  anim.asmparams[var_0][var_2] = var_1;
  return var_2;
}

function asm_globalinit() {
  if(isDefined(anim.asm)) {
    return;
  }

  anim.asm = [];
}

function asm_fireephemeralevent(var_0, var_1, var_2) {
  self asmfireephemeralevent(var_0, var_1, var_2);
}

function asm_init_blackboard() {
  if(isDefined(self._blackboard)) {
    return;
  }

  self._blackboard = self getaiblackboard();
  self._blackboard.asm_events = [];
  self._blackboard.asm_ephemeral_events = [];
  self._blackboard.asm_ephemeral_event_watchlist = [];
  self._blackboard.bfire = 0;
}

function asm_clearevents(var_0) {
  if(isDefined(self._blackboard.asm_events[var_0])) {
    self._blackboard.asm_events[var_0] = undefined;
    return;
  }
}

function asm_terminateandreplace(var_0, var_1) {
  self asmterminate();
  self clearaiblackboard();
  self._blackboard = undefined;
  self notify("asm_terminated");

  if(!isDefined(var_1)) {
    var_1 = self.asm.archetype;
  }

  asm_init_blackboard();
  self[[self.fnasm_init]](tolower(var_0), var_1);
}

function asm_getnotehandler(var_0, var_1) {
  var_2 = self asmgetnotehandler(var_0);

  if(var_2 != -1) {
    return anim.asmfuncs[var_0][var_2];
  }

  return undefined;
}

function asm_currentstatehasflag(var_0, var_1) {
  if(isDefined(self.asm.forcetrackloop)) {
    return 1;
  }

  return self asmcurrentstatehasflag(var_0, var_1);
}

function asm_fireevent_internal(var_0, var_1, var_2) {
  self asmfireevent(var_0, var_1, var_2);
}

function asm_fireevent(var_0, var_1, var_2) {
  asm_fireevent_internal(var_0, var_1, var_2);

  if(var_1 == "anim_will_finish" || var_1 == "finish") {
    var_1 = "end";
    asm_fireevent_internal(var_0, var_1);
    return;
  }
}

function asm_addephemeraleventtowatchlist(var_0, var_1) {
  self._blackboard.asm_ephemeral_event_watchlist[var_0] = var_1;
}

function asm_ephemeraleventfired(var_0, var_1, var_2) {
  var_3 = self asmephemeraleventfired(var_0, var_1);

  if(var_3) {
    return true;
  }

  if(!isDefined(var_2) || var_2) {
    asm_addephemeraleventtowatchlist(var_0, var_1);
  }

  return false;
}

function asm_eventfiredrecently(var_0, var_1) {
  return self asmeventfiredwithin(var_0, var_1, 50);
}

function asm_geteventtime(var_0, var_1) {
  return self asmgeteventtime(var_0, var_1);
}

function asm_geteventdata(var_0, var_1) {
  return self asmgeteventdata(var_0, var_1);
}

function asm_getephemeraleventdata(var_0, var_1) {
  return self asmgetephemeraleventdata(var_0, var_1);
}

function asm_clearallephemeralevents() {
  self asmclearephemeralevents();
}

function asm_shouldpowerdown(var_0, var_1) {
  if(!isDefined(self.bpowerdown) || !self.bpowerdown) {
    return false;
  }

  if(isDefined(self.asm.bpowereddown) && self.asm.bpowereddown) {
    return false;
  }

  if(!isalive(self)) {
    return false;
  }

  if(scripts\asm\asm_bb::bb_isanimScripted()) {
    return false;
  }

  if(isDefined(self._blackboard.btraversing)) {
    return false;
  }

  if(isDefined(self.melee)) {
    return false;
  }

  return true;
}

function asm_eventfired(var_0, var_1) {
  return self asmeventfired(var_0, var_1);
}

function asm_checktransitions(var_0, var_1, var_2) {
  self asmtick(1);
}

function asm_setstate(var_0, var_1) {
  if(self asmhasstate(self.asmname, var_0)) {
    self asmsetstate(self.asmname, var_0, var_1);
    return;
  }
}

function asm_tick() {}

function highestallowedstance(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\shared\utility::gethighestallowedstance();

  if(isDefined(var_4) && var_4 != var_3) {
    return false;
  }

  return true;
}

function asm_getdemeanor() {
  return self._blackboard.movetype;
}

function asm_updatefrantic() {
  if(!isDefined(self.pathgoalpos) || distancesquared(self.origin, self.pathgoalpos) > 4096) {
    self.asm.frantic = scripts\asm\asm_bb::bb_isfrantic();
    return;
  }
}

function asm_isfrantic() {
  return isDefined(self.asm) && self.asm.frantic;
}

function asm_iscrawlmelee() {
  return isDefined(self.asm.crawlmelee);
}

function asm_setcrawlmelee(var_0) {
  self.asm.crawlmelee = var_0;
}

function asm_setdemeanoranimoverride(var_0, var_1, var_2) {
  self.asm.animoverrides[var_0][var_1] = var_2;
}

function asm_cleardemeanoranimoverride(var_0, var_1) {
  if(asm_hasdemeanoranimoverride(var_0, var_1)) {
    self.asm.animoverrides[var_0][var_1] = undefined;
    return;
  }
}

function asm_hasdemeanoranimoverride(var_0, var_1) {
  return isDefined(self.asm.animoverrides[var_0]) && isDefined(self.asm.animoverrides[var_0][var_1]);
}

function asm_getdemeanoranimoverride(var_0, var_1) {
  return self.asm.animoverrides[var_0][var_1];
}

function asm_getcurrentstate(var_0) {
  return self asmgetcurrentstate(var_0);
}

function asm_hasalias(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(self.animationarchetype)) {
    var_2 = self.animationarchetype;
  } else {
    var_2 = self.asm.archetype;
  }

  var_3 = archetypegetrandomalias(var_2, var_0, var_1, asm_isfrantic());
  return isDefined(var_3);
}

function asm_getanim(var_0, var_1, var_2) {
  if(isarray(var_2)) {
    if(var_2.size == 1) {
      return self asmgetanim(var_0, var_1, var_2[0]);
    }

    if(var_2.size == 2) {
      return self asmgetanim(var_0, var_1, var_2[0], var_2[1]);
    }

    if(var_2.size == 3) {
      return self asmgetanim(var_0, var_1, var_2[0], var_2[1], var_2[2]);
    }

    return;
  }

  return self asmgetanim(var_0, var_1, var_2);
}

function asm_getrandomanim(var_0, var_1) {
  var_2 = asm_getrandomalias(var_1);
  return asm_lookupanimfromalias(var_1, var_2);
}

function asm_getrandomalias(var_0) {
  var_1 = archetypegetaliases(self.asm.archetype, var_0);
  return var_1[randomint(var_1.size)];
}

function asm_lookupanimfromaliasifexists(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(self.animationarchetype)) {
    var_2 = self.animationarchetype;
  } else {
    var_2 = self.asm.archetype;
  }

  var_3 = archetypegetrandomalias(var_2, var_0, var_1, asm_isfrantic());
  return var_3;
}

function asm_lookupanimfromalias(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(self.animationarchetype)) {
    var_2 = self.animationarchetype;
  } else {
    var_2 = self.asm.archetype;
  }

  var_3 = archetypegetrandomalias(var_2, var_0, var_1, asm_isfrantic());
  return var_3;
}

function asm_getallanimsforstate(var_0) {
  var_1 = self.asm.archetype;
  var_2 = archetypegetaliases(var_1, var_0);
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = archetypegetalias(var_1, var_0, var_5, 0);

    if(isarray(var_6.anims)) {
      var_3 = scripts\engine\utility::array_combine(var_3, var_6.anims);
      continue;
    }

    var_3 = var_6.anims;
  }

  return var_3;
}

function asm_getallanimsforalias(var_0, var_1, var_2) {
  var_3 = archetypegetalias(var_0, var_1, var_2, 1);

  if(!isDefined(var_3)) {
    return undefined;
  }

  var_4 = var_3.anims;

  if(!isarray(var_4)) {
    var_4 = [var_4];
  }

  return var_4;
}

function asm_getallanimindicesforalias(var_0, var_1) {
  return analyticsstreamerlogfileendstream(self.asm.archetype, var_0, var_1);
}

function asm_playanimstate(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = asm_getanim(var_0, var_1);
  self aisetanim(var_1, var_3);
  asm_playfacialanim(var_0, var_1, asm_getxanim(var_1, var_3));
  var_4 = asm_donotetracks(var_0, var_1, asm_getnotehandler(var_0, var_1));

  if(var_4 == "code_move") {
    var_4 = asm_donotetracks(var_0, var_1, asm_getnotehandler(var_0, var_1));
    return;
  }
}

function asm_hasknobs() {
  if(isagent(self) && !istrue(self.bsoldier) && self.unittype != "civilian") {
    return false;
  }

  return true;
}

function asm_loopanimstate(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");

  if(asm_hasknobs()) {
    var_4 = asm_getbodyknob();

    if(isDefined(var_3) && var_3) {
      var_5 = asm_lookupanimfromaliasifexists("knobs", "move");

      if(isDefined(var_5)) {
        var_6 = asm_getxanim("knobs", var_5);
        self setmoveanimknob(var_6);
      }
    }
  }

  var_7 = asm_getnotehandler(var_0, var_1);
  var_8 = 0.2;
  var_9 = isDefined(var_3) && var_3;
  var_10 = 1;

  for(;;) {
    var_11 = asm_getanim(var_0, var_1);
    var_12 = asm_getxanim(var_1, var_11);

    if(isDefined(var_3) && var_3) {
      var_2 = asm_getmoveplaybackrate();
      self codemoveanimrate(var_2);
    }

    if(!var_9) {
      var_10 = self aigetanimweight(var_12) == 0;
    }

    if(isnumber(var_11)) {
      self aisetanim(var_1, var_11, var_2);
    } else {
      var_13 = asm_lookupanimfromalias(var_1, "blank");
      self aisetanim(var_1, var_13);

      if(var_10) {
        self setflaggedanimrestart(var_1, var_11, 1, 0.2, var_2);
      } else {
        self setflaggedanim(var_1, var_11, 1, 0.2, var_2);
      }
    }

    if(var_9) {
      var_10 = 0;
    }

    asm_playfacialanim(var_0, var_1, var_12);
    var_14 = getanimlength(var_12);

    if(var_14 <= 0.05) {
      return;
    }

    var_15 = undefined;
    var_16 = var_2;

    while(!isDefined(var_15)) {
      var_15 = asm_donotetrackswithtimeout(var_0, var_1, var_8, var_7);

      if(!isDefined(var_15) && var_9) {
        var_2 = asm_getmoveplaybackrate();

        if(var_2 != var_16) {
          self codemoveanimrate(var_2);

          if(isnumber(var_11)) {
            self aisetanimrate(var_1, var_11, var_2);
            continue;
          }

          self setanimrate(var_12, var_2);
        }
      }
    }
  }
}

function asm_lookupdirectionalfootanim(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "";

  if(isDefined(var_4)) {
    var_5 = var_4;
  }

  if(var_3) {
    if(asm_eventfiredrecently(var_1, "pass_left")) {
      var_6 = var_5 + "left";
    } else if(asm_eventfiredrecently(var_2, "pass_right")) {
      var_6 += "right";
    } else if(self.asm.footsteps.foot == "right") {
      var_6 += "right";
    } else {
      var_6 += "left";
    }
  } else {
    var_6 = var_6;
  }

  var_7 = asm_lookupanimfromaliasifexists(var_6, var_6 + var_4);

  if(isDefined(var_7)) {
    return var_7;
  }

  if(var_6 != var_6) {
    var_7 = asm_lookupanimfromaliasifexists(var_6, var_6 + var_4);

    if(isDefined(var_7)) {
      return var_7;
    }
  }

  return undefined;
}

function asm_setmoveplaybackrate(var_0) {
  self.moveplaybackrate = var_0;
}

function asm_getmoveplaybackrate() {
  return self.moveplaybackrate;
}

function asm_getcurrentstatename(var_0) {
  return self asmgetcurrentstate(var_0);
}

function asm_dosinglenotetrack(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1;
  jumpiffalse(isDefined(var_4)) LOC_00000011;
  var_5 = var_4;
  self waittill(var_5, var_6);

  if(!isDefined(var_6)) {
    var_6 = ["undefined"];
  }

  if(!isarray(var_6)) {
    var_6 = [var_6];
  }

  var_7 = undefined;

  foreach(var_9 in var_6) {
    asm_fireevent(var_0, var_9);
    var_10 = [[self.fnasm_handlenotetrack]](var_9, var_5, var_2, var_3);

    if(!isDefined(var_10)) {
      var_10 = asm_handlenewnotetracks(var_0, var_9, var_1);
    }

    if(isDefined(var_10)) {
      var_7 = var_10;
    }
  }

  return var_7;
}

function asm_handlenewnotetracks(var_0, var_1, var_2) {
  if(asm_tryhandledeathstatechangenotetrack(var_1)) {
    return;
  }

  switch (var_1) {
    case "start_aim":
      if(asm_currentstatehasflag(var_0, "notetrackAim")) {
        asm_setupaim(var_0, var_2, 0.2);
      }

      break;
  }
}

function asm_tryhandledeathstatechangenotetrack(var_0) {
  if(!scripts\engine\utility::string_starts_with(var_0, "ds ")) {
    return false;
  }

  var_1 = 3;
  self.asm.deathstateoverride = spawnStruct();
  var_1 += 1;
  var_2 = "";

  while(var_1 < var_0.size && var_0[var_1] != "]") {
    var_2 += var_0[var_1];
    var_1 += 1;
  }

  self.asm.deathstateoverride.statename = var_2;
  var_1 += 1;

  if(var_1 < var_0.size) {
    var_1 += 2;
    var_3 = "";

    while(var_1 < var_0.size && var_0[var_1] != "]") {
      var_3 += var_0[var_1];
      var_1 += 1;
    }

    self.asm.deathstateoverride.params = var_3;
  }

  return true;
}

function asm_donotetracksfortime(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1 + "_timeout";
  self endon(var_5);
  GscBinSkip4(0x35, var_5, var_2);
}

function asm_donotetrackswithtimeout_helper(var_0, var_1, var_2) {
  self endon(var_0);
  wait var_2;
  self notify(var_1);
}

function asm_donotetrackswithtimeout(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1 + "_timeout";
  var_6 = var_1 + "_endHelper";
  self endon(var_5);
  GscBinSkip4(0x35, var_6, var_5, var_2);
}

function asm_donotetracks(var_0, var_1, var_2, var_3, var_4, var_5) {
  jumpiftrue(isDefined(var_5)) LOC_00000010;
  var_5 = 1;

  for(;;) {
    var_6 = asm_dosinglenotetrack(var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_6)) {
      if(var_5 && !asm_eventfired(var_0, "end")) {
        asm_fireevent(var_0, "end");
      }

      return var_6;
    }
  }
}

function asm_donotetrackswithinterceptor(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1;
  jumpiffalse(isDefined(var_4)) LOC_00000011;
  var_5 = var_4;

  for(;;) {
    self waittill(var_5, var_6);

    if(!isDefined(var_6)) {
      var_6 = ["undefined"];
    }

    if(!isarray(var_6)) {
      var_6 = [var_6];
    }

    var_7 = undefined;

    foreach(var_9 in var_6) {
      asm_fireevent(var_0, var_9);
      var_10 = [[var_2]](var_1, var_9, var_3);

      if(isDefined(var_10) && var_10) {
        continue;
      }

      var_11 = [[self.fnasm_handlenotetrack]](var_9, var_1, undefined, undefined);

      if(!isDefined(var_11)) {
        var_11 = asm_handlenewnotetracks(var_0, var_9, var_1);
      }

      if(isDefined(var_11)) {
        var_7 = var_11;
      }
    }

    if(isDefined(var_7)) {
      return var_7;
    }
  }
}

function asm_donotetrackssingleloop(var_0, var_1, var_2, var_3) {
  var_4 = var_1 + "_note_loop_end";
  self endon(var_4);
  var_5 = getanimlength(var_2);
  thread asm_donotetrackssingleloop_waiter(var_4, var_1 + "_finished", var_5);
  asm_donotetracks(var_0, var_1, var_3);
  self notify(var_4);
}

function asm_donotetrackssingleloop_waiter(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_0);
  self endon(var_1);
  wait var_2;
  self notify(var_0);
}

function asm_donotetracksfortime_helper(var_0, var_1) {
  wait var_1;
  self notify(var_0);
}

function asm_waitforaimnotetrack(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = 0;

  while(!var_3) {
    self waittill(var_1, var_4);

    if(!isarray(var_4)) {
      var_4 = [var_4];
    }

    foreach(var_6 in var_4) {
      if(var_6 == "start_aim") {
        asm_setupaim(var_0, var_1, var_2);
        var_3 = 1;
        break;
      }
    }
  }
}

function asm_lookuprandomalias(var_0, var_1, var_2) {
  var_3 = self.asm.archetype;
  var_4 = archetypegetaliases(var_3, var_0);
  var_5 = 0;
  var_6 = undefined;
  var_7 = -1;

  if(isDefined(var_1)) {
    var_7 = var_1.size;
  }

  if(!isDefined(var_4)) {
    return undefined;
  }

  foreach(var_10 in var_4) {
    if(var_7 < 0 || getsubstr(var_10, 0, var_7) == var_1) {
      var_5 += 1;
      var_11 = 1 / var_5;

      if(randomfloat(1) <= var_11) {
        var_6 = var_10;
      }
    }
  }

  return var_6;
}

function asm_chooseanim(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_3 = asm_lookuprandomalias(var_1);
    return asm_lookupanimfromalias(var_1, var_3);
  }

  var_4 = undefined;
  var_5 = scripts\asm\asm_bb::bb_getprefixstring(var_3);

  if(isDefined(var_5)) {
    var_3 = asm_lookuprandomalias(var_2, var_5);
    var_4 = asm_lookupanimfromalias(var_2, var_3);
  } else {
    var_4 = asm_lookupanimfromalias(var_2, var_3);
  }

  return var_4;
}

function asm_clearfacialanim() {
  if(self.facialstate != "filler") {
    if(isai(self)) {
      self setfacialindex("none");
      return;
    }

    scripts\asm\shared\utility::setfacialindexfornonai("none");
    return;
  }
}

function asm_restorefacialanim() {
  var_0 = self.asmname;
  var_1 = self asmgetcurrentstate(var_0);

  if(var_1 == "animscripted") {
    return;
  }

  asm_playfacialanim(var_0, var_1, undefined);
}

function asm_playfacialanim(var_0, var_1, var_2) {
  if(isDefined(self.fnasm_playfacialanim)) {
    [[self.fnasm_playfacialanim]](var_0, var_1, var_2);
  }
}

function asm_getroot() {
  var_0 = asm_lookupanimfromalias("knobs", "root");
  return asm_getxanim("knobs", var_0);
}

function asm_getbodyknob() {
  var_0 = asm_lookupanimfromalias("knobs", "body");
  return asm_getxanim("knobs", var_0);
}

function asm_getinnerrootknob() {
  var_0 = asm_lookupanimfromaliasifexists("knobs", "inner_root");

  if(isDefined(var_0)) {
    return asm_getxanim("knobs", var_0);
  }

  return asm_getbodyknob();
}

function asm_getfacialknob() {
  var_0 = asm_lookupanimfromaliasifexists("always_on", "facial");

  if(isDefined(var_0)) {
    return asm_getxanim("always_on", var_0);
  }
}

function asm_getheadlookknobifexists() {
  var_0 = asm_lookupanimfromaliasifexists("knobs", "headlook");

  if(isDefined(var_0)) {
    return asm_getxanim("knobs", var_0);
  }

  return undefined;
}

function asm_isweaponoverride() {
  var_0 = self.weapon;
  var_1 = getweaponbasename(var_0);
  var_2 = ["iw7_cheytac", "iw7_kbs", "iw7_m1", "iw7_m8", "iw7_mauler", "iw7_sdflmg", "iw7_ameli", "iw7_steeldragon", "iw7_sonic", "iw7_sdfshotty", "iw7_spas"];

  if(isDefined(var_1) && scripts\engine\utility::array_contains(var_2, var_1)) {
    return true;
  }

  return false;
}

function asm_getxanim(var_0, var_1) {
  if(isnumber(var_1)) {
    var_2 = undefined;

    if(!isDefined(self.asm)) {
      var_2 = self.animationarchetype;
    } else {
      var_2 = self.asm.archetype;
    }

    return animsetgetallanimindicesforalias(var_2, var_0, var_1);
  }

  return var_2;
}

function asm_playanimstatewithnotetrackinterceptor(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = asm_getanim(var_0, var_1);
  self aisetanim(var_1, var_4);
  asm_playfacialanim(var_0, var_1, asm_getxanim(var_1, var_4));
  var_5 = asm_donotetrackswithinterceptor(var_0, var_1, var_2, var_3);

  if(var_5 == "end") {
    if(!asm_eventfired(var_0, "end")) {
      asm_fireevent(var_0, "end");
      return;
    }

    return;
  }
}

function asm_playanimstatenotransition(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = asm_getanim(var_0, var_1);
  self aisetanim(var_1, var_3);
  asm_playfacialanim(var_0, var_1, asm_getxanim(var_1, var_3));
  var_4 = asm_donotetracks(var_0, var_1, asm_getnotehandler(var_0, var_1));
}

function asm_playadditiveanimloopstate(var_0, var_1, var_2) {
  [[self.fnasm_playadditiveanimloopstate]](var_0, var_1, var_2);
}

function setup_level_ents() {
  foreach(var_1 in getnodearray("traverse", "targetname")) {
    traversethink(var_1);
  }
}

function processdoublejumpmantletraversal(var_0) {
  self.doublejumpmantlepos = var_0.origin;
  self.startnodeoriginalangles = self.angles;

  if(isent(var_0)) {
    var_0 delete();
    return;
  }

  scripts\engine\utility::deletestruct_ref(var_0);
}

function traversethink() {
  var_0 = getEnt(self.target, "targetname");

  if(!isDefined(var_0)) {
    var_0 = scripts\engine\utility::getStruct(self.target, "targetname");
  }

  var_1 = getnode(self.target, "targetname");

  if(!isDefined(var_0)) {
    return;
  }

  switch (self.animscript) {
    case "wall_run":
      processwallruntraversal(var_0);
      return;
    case "double_jump_mantle":
    case "double_jump_vault":
      processdoublejumpmantletraversal(var_0);
      return;
    case "double_jump":
      self.startnodeoriginalangles = self.angles;

      if(!isDefined(var_0)) {
        return;
      }

      self.jump_over_offset = var_0.origin - self.origin;
      self.jump_over_ent_origin = var_0.origin;
      break;
    case "rail_hop_double_jump_down":
      self.startnodeoriginalangles = self.angles;
      break;
    default:
      break;
  }

  if(isDefined(var_0.target)) {
    var_3 = getEnt(var_0.target, "targetname");

    if(!isDefined(var_3)) {
      var_3 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    }

    calculate_traverse_data(var_0.origin, var_1.origin, var_3.origin);
  } else {
    calculate_traverse_data(var_0.origin, var_1.origin);
  }

  if(isDefined(self.parentname)) {
    store_original_traverse_data();
  }

  if(isent(var_0)) {
    var_0 delete();
    return;
  }

  scripts\engine\utility::deletestruct_ref(var_0);
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

  var_0 = getnode(self.target, "targetname");

  if(isDefined(var_0)) {
    self.original_data.endnode_pos = var_0.origin;
    return;
  }
}

function calculate_traverse_data(var_0, var_1, var_2) {
  self.traverse_height = var_0[2];
  self.traverse_height_delta = var_0[2] - self.origin[2];
  self.traverse_drop_height_delta = var_0[2] - var_1[2];
  self.apex_delta = var_0 - self.origin;

  if(isDefined(var_2)) {
    self.across_delta = var_2 - var_0;
    return;
  }
}

function re_calculate_traverse_data(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = self.origin + rotatevector(var_0.original_data.apex_delta_local, self.angles);
  }

  if(!isDefined(var_2)) {
    var_2 = var_0.original_data.endnode_pos;
  }

  if(!isDefined(var_3) && isDefined(var_0.original_data.across_delta_local)) {
    var_4 = rotatevector(var_0.original_data.across_delta_local, self.angles);
    var_3 = var_1 + var_4;
  }

  calculate_traverse_data(var_1, var_2, var_3);
}

function processwallruntraversal(var_0) {
  var_1 = getEnt(var_0.target, "targetname");

  if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  }

  self.wall_info = spawnStruct();
  var_3 = var_0;
  var_4 = 0;
  self.wall_info.startnodeoriginalangles = self.angles;
  var_6 = undefined;

  while(isDefined(var_3)) {
    self.wall_info.nodeoffsets[var_4] = var_3.origin - self.origin;
    var_4++;
    var_7 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    scripts\engine\utility::deletestruct_ref(var_3);
    var_3 = var_7;
    self.wall_info.nodeoffsets[var_4] = var_3.origin - self.origin;
    var_4++;

    if(isDefined(var_3.target)) {
      var_10 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    } else {
      var_10 = undefined;
    }

    scripts\engine\utility::deletestruct_ref(var_3);
    var_3 = var_10;

    if(isDefined(var_3) && isDefined(var_3.script_wallrun_type)) {
      if(var_3.script_wallrun_type == "wallrun_mantle") {
        self.wall_info.mantleoffset = var_3.origin - self.origin;

        if(isDefined(var_3.angles)) {
          self.wall_info.mantleangles = var_3.angles;
        }

        scripts\engine\utility::deletestruct_ref(var_3);
        break;
      }

      if(var_3.script_wallrun_type == "wallrun_vault") {
        self.wall_info.mantleoffset = var_3.origin - self.origin;
        self.wall_info.bvaultover = 1;
        scripts\engine\utility::deletestruct_ref(var_3);
        break;
      }
    }
  }
}