/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\asm.gsc
***********************************************/

function asm_getfunction(var0, var1) {
  return anim.asmfuncs[var0][var1];
}

function asm_getgenerichandler() {
  return &asm_generichandler;
}

function asm_getparams(var0, var1) {
  return anim.asmparams[var0][var1];
}

function asm_setupaim(var0, var1, var2, var3) {
  if(isDefined(self.fnasm_setupaim)) {
    self[[self.fnasm_setupaim]](var0, var1, var2, var3);
    return;
  }
}

function asm_settransitionorientmode(var0) {
  switch (var0) {
    case "face node":
      var1 = 1024;

      if(scripts\engine\utility::actor_is3d()) {
        var2 = self.angles;

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var1) {
          var2 = scripts\asm\shared\utility::getnodeforwardangles(self.node);
        }

        self orientmode("face angle 3d", var2);
      } else {
        var3 = self.angles[1];

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var1) {
          var3 = scripts\asm\shared\utility::getnodeforwardyaw(self.node);
        }

        self orientmode("face angle", var3);
      }

      break;
    case "face current":
      self orientmode("face angle 3d", self.angles);
      break;
    default:
      self orientmode(var0);
      break;
  }
}

function asm_settransitionanimmode(var0) {
  if(isDefined(self.fnasm_setanimmode)) {
    self[[self.fnasm_setanimmode]](var0);
    return;
  }

  self animmode(var0, 0);
}

function asm_generichandler(var0, var1, var2, var3, var4) {
  switch (var0) {
    case "orientmode":
      asm_settransitionorientmode(var2);
      break;
    case "setupaim":
      asm_setupaim(var1, var2, 0.2, undefined);
      break;
    case "setupgesture":
      if(isDefined(self.fnasm_setupgesture)) {
        self[[self.fnasm_setupgesture]](var1, var2);
      }

      break;
    case "archetype":
      self.asm.archetype = var2;
      self.animationarchetype = var2;
      break;
    case "note":
      var5 = asm_getnotehandler(var1, undefined);
      var6 = [[self.fnasm_handlenotetrack]](var3, var2, var5, undefined);

      if(!isDefined(var6)) {
        var6 = asm_handlenewnotetracks(var1, var3, var2);
      }

      if(isDefined(var6) && !asm_eventfired(var1, "end")) {
        asm_fireevent(var1, "end");
      }

      break;
    case "waitfordooropen":
      thread scripts\asm\shared\utility::waitfordooropen(var1, var2, var3);
      break;
    case "move_threads":
      var7 = var2;
      thread scripts\asm\shared\utility::waitforcoverapproach(var1, var7);
      thread scripts\asm\shared\utility::waitforsharpturn(var1, var7);
      break;
    default:
      break;
  }
}

function asm_setoverrideparams(var0, var1) {
  var2 = 9999;
  anim.asmparams[var0][var2] = var1;
  return var2;
}

function asm_globalinit() {
  if(isDefined(anim.asm)) {
    return;
  }

  anim.asm = [];
}

function asm_fireephemeralevent(var0, var1, var2) {
  self asmfireephemeralevent(var0, var1, var2);
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

function asm_clearevents(var0) {
  if(isDefined(self._blackboard.asm_events[var0])) {
    self._blackboard.asm_events[var0] = undefined;
    return;
  }
}

function asm_terminateandreplace(var0, var1) {
  self asmterminate();
  self clearaiblackboard();
  self._blackboard = undefined;
  self notify("asm_terminated");

  if(!isDefined(var1)) {
    var1 = self.asm.archetype;
  }

  asm_init_blackboard();
  self[[self.fnasm_init]](tolower(var0), var1);
}

function asm_getnotehandler(var0, var1) {
  var2 = self asmgetnotehandler(var0);

  if(var2 != -1) {
    return anim.asmfuncs[var0][var2];
  }

  return undefined;
}

function asm_currentstatehasflag(var0, var1) {
  if(isDefined(self.asm.forcetrackloop)) {
    return 1;
  }

  return self asmcurrentstatehasflag(var0, var1);
}

function asm_fireevent_internal(var0, var1, var2) {
  self asmfireevent(var0, var1, var2);
}

function asm_fireevent(var0, var1, var2) {
  asm_fireevent_internal(var0, var1, var2);

  if(var1 == "anim_will_finish" || var1 == "finish") {
    var1 = "end";
    asm_fireevent_internal(var0, var1);
    return;
  }
}

function asm_addephemeraleventtowatchlist(var0, var1) {
  self._blackboard.asm_ephemeral_event_watchlist[var0] = var1;
}

function asm_ephemeraleventfired(var0, var1, var2) {
  var3 = self asmephemeraleventfired(var0, var1);

  if(var3) {
    return true;
  }

  if(!isDefined(var2) || var2) {
    asm_addephemeraleventtowatchlist(var0, var1);
  }

  return false;
}

function asm_eventfiredrecently(var0, var1) {
  return self asmeventfiredwithin(var0, var1, 50);
}

function asm_geteventtime(var0, var1) {
  return self asmgeteventtime(var0, var1);
}

function asm_geteventdata(var0, var1) {
  return self asmgeteventdata(var0, var1);
}

function asm_getephemeraleventdata(var0, var1) {
  return self asmgetephemeraleventdata(var0, var1);
}

function asm_clearallephemeralevents() {
  self asmclearephemeralevents();
}

function asm_shouldpowerdown(var0, var1) {
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

function asm_eventfired(var0, var1) {
  return self asmeventfired(var0, var1);
}

function asm_checktransitions(var0, var1, var2) {
  self asmtick(1);
}

function asm_setstate(var0, var1) {
  if(self asmhasstate(self.asmname, var0)) {
    self asmsetstate(self.asmname, var0, var1);
    return;
  }
}

function asm_tick() {}

function highestallowedstance(var0, var1, var2, var3) {
  var4 = scripts\asm\shared\utility::gethighestallowedstance();

  if(isDefined(var4) && var4 != var3) {
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

function asm_setcrawlmelee(var0) {
  self.asm.crawlmelee = var0;
}

function asm_setdemeanoranimoverride(var0, var1, var2) {
  self.asm.animoverrides[var0][var1] = var2;
}

function asm_cleardemeanoranimoverride(var0, var1) {
  if(asm_hasdemeanoranimoverride(var0, var1)) {
    self.asm.animoverrides[var0][var1] = undefined;
    return;
  }
}

function asm_hasdemeanoranimoverride(var0, var1) {
  return isDefined(self.asm.animoverrides[var0]) && isDefined(self.asm.animoverrides[var0][var1]);
}

function asm_getdemeanoranimoverride(var0, var1) {
  return self.asm.animoverrides[var0][var1];
}

function asm_getcurrentstate(var0) {
  return self asmgetcurrentstate(var0);
}

function asm_hasalias(var0, var1) {
  var2 = undefined;

  if(isDefined(self.animationarchetype)) {
    var2 = self.animationarchetype;
  } else {
    var2 = self.asm.archetype;
  }

  var3 = archetypegetrandomalias(var2, var0, var1, asm_isfrantic());
  return isDefined(var3);
}

function asm_getanim(var0, var1, var2) {
  if(isarray(var2)) {
    if(var2.size == 1) {
      return self asmgetanim(var0, var1, var2[0]);
    }

    if(var2.size == 2) {
      return self asmgetanim(var0, var1, var2[0], var2[1]);
    }

    if(var2.size == 3) {
      return self asmgetanim(var0, var1, var2[0], var2[1], var2[2]);
    }

    return;
  }

  return self asmgetanim(var0, var1, var2);
}

function asm_getrandomanim(var0, var1) {
  var2 = asm_getrandomalias(var1);
  return asm_lookupanimfromalias(var1, var2);
}

function asm_getrandomalias(var0) {
  var1 = archetypegetaliases(self.asm.archetype, var0);
  return var1[randomint(var1.size)];
}

function asm_lookupanimfromaliasifexists(var0, var1) {
  var2 = undefined;

  if(isDefined(self.animationarchetype)) {
    var2 = self.animationarchetype;
  } else {
    var2 = self.asm.archetype;
  }

  var3 = archetypegetrandomalias(var2, var0, var1, asm_isfrantic());
  return var3;
}

function asm_lookupanimfromalias(var0, var1) {
  var2 = undefined;

  if(isDefined(self.animationarchetype)) {
    var2 = self.animationarchetype;
  } else {
    var2 = self.asm.archetype;
  }

  var3 = archetypegetrandomalias(var2, var0, var1, asm_isfrantic());
  return var3;
}

function asm_getallanimsforstate(var0) {
  var1 = self.asm.archetype;
  var2 = archetypegetaliases(var1, var0);
  var3 = [];

  foreach(var5 in var2) {
    var6 = archetypegetalias(var1, var0, var5, 0);

    if(isarray(var6.anims)) {
      var3 = scripts\engine\utility::array_combine(var3, var6.anims);
      continue;
    }

    var3 = var6.anims;
  }

  return var3;
}

function asm_getallanimsforalias(var0, var1, var2) {
  var3 = archetypegetalias(var0, var1, var2, 1);

  if(!isDefined(var3)) {
    return undefined;
  }

  var4 = var3.anims;

  if(!isarray(var4)) {
    var4 = [var4];
  }

  return var4;
}

function asm_getallanimindicesforalias(var0, var1) {
  return analyticsstreamerlogfileendstream(self.asm.archetype, var0, var1);
}

function asm_playanimstate(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = asm_getanim(var0, var1);
  self aisetanim(var1, var3);
  asm_playfacialanim(var0, var1, asm_getxanim(var1, var3));
  var4 = asm_donotetracks(var0, var1, asm_getnotehandler(var0, var1));

  if(var4 == "code_move") {
    var4 = asm_donotetracks(var0, var1, asm_getnotehandler(var0, var1));
    return;
  }
}

function asm_hasknobs() {
  if(isagent(self) && !istrue(self.bsoldier) && self.unittype != "civilian") {
    return false;
  }

  return true;
}

function asm_loopanimstate(var0, var1, var2, var3) {
  self endon(var1 + "_finished");

  if(asm_hasknobs()) {
    var4 = asm_getbodyknob();

    if(isDefined(var3) && var3) {
      var5 = asm_lookupanimfromaliasifexists("knobs", "move");

      if(isDefined(var5)) {
        var6 = asm_getxanim("knobs", var5);
        self setmoveanimknob(var6);
      }
    }
  }

  var7 = asm_getnotehandler(var0, var1);
  var8 = 0.2;
  var9 = isDefined(var3) && var3;
  var10 = 1;

  for(;;) {
    var11 = asm_getanim(var0, var1);
    var12 = asm_getxanim(var1, var11);

    if(isDefined(var3) && var3) {
      var2 = asm_getmoveplaybackrate();
      self codemoveanimrate(var2);
    }

    if(!var9) {
      var10 = self aigetanimweight(var12) == 0;
    }

    if(isnumber(var11)) {
      self aisetanim(var1, var11, var2);
    } else {
      var13 = asm_lookupanimfromalias(var1, "blank");
      self aisetanim(var1, var13);

      if(var10) {
        self setflaggedanimrestart(var1, var11, 1, 0.2, var2);
      } else {
        self setflaggedanim(var1, var11, 1, 0.2, var2);
      }
    }

    if(var9) {
      var10 = 0;
    }

    asm_playfacialanim(var0, var1, var12);
    var14 = getanimlength(var12);

    if(var14 <= 0.05) {
      return;
    }

    var15 = undefined;
    var16 = var2;

    while(!isDefined(var15)) {
      var15 = asm_donotetrackswithtimeout(var0, var1, var8, var7);

      if(!isDefined(var15) && var9) {
        var2 = asm_getmoveplaybackrate();

        if(var2 != var16) {
          self codemoveanimrate(var2);

          if(isnumber(var11)) {
            self aisetanimrate(var1, var11, var2);
            continue;
          }

          self setanimrate(var12, var2);
        }
      }
    }
  }
}

function asm_lookupdirectionalfootanim(var0, var1, var2, var3, var4) {
  var5 = "";

  if(isDefined(var4)) {
    var5 = var4;
  }

  if(var3) {
    if(asm_eventfiredrecently(var1, "pass_left")) {
      var6 = var5 + "left";
    } else if(asm_eventfiredrecently(var2, "pass_right")) {
      var6 += "right";
    } else if(self.asm.footsteps.foot == "right") {
      var6 += "right";
    } else {
      var6 += "left";
    }
  } else {
    var6 = var6;
  }

  var7 = asm_lookupanimfromaliasifexists(var6, var6 + var4);

  if(isDefined(var7)) {
    return var7;
  }

  if(var6 != var6) {
    var7 = asm_lookupanimfromaliasifexists(var6, var6 + var4);

    if(isDefined(var7)) {
      return var7;
    }
  }

  return undefined;
}

function asm_setmoveplaybackrate(var0) {
  self.moveplaybackrate = var0;
}

function asm_getmoveplaybackrate() {
  return self.moveplaybackrate;
}

function asm_getcurrentstatename(var0) {
  return self asmgetcurrentstate(var0);
}

function asm_dosinglenotetrack(var0, var1, var2, var3, var4) {
  var5 = var1;
  jumpiffalse(isDefined(var4)) LOC_00000011;
  var5 = var4;
  self waittill(var5, var6);

  if(!isDefined(var6)) {
    var6 = ["undefined"];
  }

  if(!isarray(var6)) {
    var6 = [var6];
  }

  var7 = undefined;

  foreach(var9 in var6) {
    asm_fireevent(var0, var9);
    var10 = [[self.fnasm_handlenotetrack]](var9, var5, var2, var3);

    if(!isDefined(var10)) {
      var10 = asm_handlenewnotetracks(var0, var9, var1);
    }

    if(isDefined(var10)) {
      var7 = var10;
    }
  }

  return var7;
}

function asm_handlenewnotetracks(var0, var1, var2) {
  if(asm_tryhandledeathstatechangenotetrack(var1)) {
    return;
  }

  switch (var1) {
    case "start_aim":
      if(asm_currentstatehasflag(var0, "notetrackAim")) {
        asm_setupaim(var0, var2, 0.2);
      }

      break;
  }
}

function asm_tryhandledeathstatechangenotetrack(var0) {
  if(!scripts\engine\utility::string_starts_with(var0, "ds ")) {
    return false;
  }

  var1 = 3;
  self.asm.deathstateoverride = spawnStruct();
  var1 += 1;
  var2 = "";

  while(var1 < var0.size && var0[var1] != "]") {
    var2 += var0[var1];
    var1 += 1;
  }

  self.asm.deathstateoverride.statename = var2;
  var1 += 1;

  if(var1 < var0.size) {
    var1 += 2;
    var3 = "";

    while(var1 < var0.size && var0[var1] != "]") {
      var3 += var0[var1];
      var1 += 1;
    }

    self.asm.deathstateoverride.params = var3;
  }

  return true;
}

function asm_donotetracksfortime(var0, var1, var2, var3, var4) {
  var5 = var1 + "_timeout";
  self endon(var5);
  GscBinSkip4(0x35, var5, var2);
}

function asm_donotetrackswithtimeout_helper(var0, var1, var2) {
  self endon(var0);
  wait var2;
  self notify(var1);
}

function asm_donotetrackswithtimeout(var0, var1, var2, var3, var4) {
  var5 = var1 + "_timeout";
  var6 = var1 + "_endHelper";
  self endon(var5);
  GscBinSkip4(0x35, var6, var5, var2);
}

function asm_donotetracks(var0, var1, var2, var3, var4, var5) {
  jumpiftrue(isDefined(var5)) LOC_00000010;
  var5 = 1;

  for(;;) {
    var6 = asm_dosinglenotetrack(var0, var1, var2, var3, var4);

    if(isDefined(var6)) {
      if(var5 && !asm_eventfired(var0, "end")) {
        asm_fireevent(var0, "end");
      }

      return var6;
    }
  }
}

function asm_donotetrackswithinterceptor(var0, var1, var2, var3, var4) {
  var5 = var1;
  jumpiffalse(isDefined(var4)) LOC_00000011;
  var5 = var4;

  for(;;) {
    self waittill(var5, var6);

    if(!isDefined(var6)) {
      var6 = ["undefined"];
    }

    if(!isarray(var6)) {
      var6 = [var6];
    }

    var7 = undefined;

    foreach(var9 in var6) {
      asm_fireevent(var0, var9);
      var10 = [[var2]](var1, var9, var3);

      if(isDefined(var10) && var10) {
        continue;
      }

      var11 = [[self.fnasm_handlenotetrack]](var9, var1, undefined, undefined);

      if(!isDefined(var11)) {
        var11 = asm_handlenewnotetracks(var0, var9, var1);
      }

      if(isDefined(var11)) {
        var7 = var11;
      }
    }

    if(isDefined(var7)) {
      return var7;
    }
  }
}

function asm_donotetrackssingleloop(var0, var1, var2, var3) {
  var4 = var1 + "_note_loop_end";
  self endon(var4);
  var5 = getanimlength(var2);
  thread asm_donotetrackssingleloop_waiter(var4, var1 + "_finished", var5);
  asm_donotetracks(var0, var1, var3);
  self notify(var4);
}

function asm_donotetrackssingleloop_waiter(var0, var1, var2) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var0);
  self endon(var1);
  wait var2;
  self notify(var0);
}

function asm_donotetracksfortime_helper(var0, var1) {
  wait var1;
  self notify(var0);
}

function asm_waitforaimnotetrack(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = 0;

  while(!var3) {
    self waittill(var1, var4);

    if(!isarray(var4)) {
      var4 = [var4];
    }

    foreach(var6 in var4) {
      if(var6 == "start_aim") {
        asm_setupaim(var0, var1, var2);
        var3 = 1;
        break;
      }
    }
  }
}

function asm_lookuprandomalias(var0, var1, var2) {
  var3 = self.asm.archetype;
  var4 = archetypegetaliases(var3, var0);
  var5 = 0;
  var6 = undefined;
  var7 = -1;

  if(isDefined(var1)) {
    var7 = var1.size;
  }

  if(!isDefined(var4)) {
    return undefined;
  }

  foreach(var10 in var4) {
    if(var7 < 0 || getsubstr(var10, 0, var7) == var1) {
      var5 += 1;
      var11 = 1 / var5;

      if(randomfloat(1) <= var11) {
        var6 = var10;
      }
    }
  }

  return var6;
}

function asm_chooseanim(var0, var1, var2) {
  if(!isDefined(var2)) {
    var3 = asm_lookuprandomalias(var1);
    return asm_lookupanimfromalias(var1, var3);
  }

  var4 = undefined;
  var5 = scripts\asm\asm_bb::bb_getprefixstring(var3);

  if(isDefined(var5)) {
    var3 = asm_lookuprandomalias(var2, var5);
    var4 = asm_lookupanimfromalias(var2, var3);
  } else {
    var4 = asm_lookupanimfromalias(var2, var3);
  }

  return var4;
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
  var0 = self.asmname;
  var1 = self asmgetcurrentstate(var0);

  if(var1 == "animscripted") {
    return;
  }

  asm_playfacialanim(var0, var1, undefined);
}

function asm_playfacialanim(var0, var1, var2) {
  if(isDefined(self.fnasm_playfacialanim)) {
    [[self.fnasm_playfacialanim]](var0, var1, var2);
  }
}

function asm_getroot() {
  var0 = asm_lookupanimfromalias("knobs", "root");
  return asm_getxanim("knobs", var0);
}

function asm_getbodyknob() {
  var0 = asm_lookupanimfromalias("knobs", "body");
  return asm_getxanim("knobs", var0);
}

function asm_getinnerrootknob() {
  var0 = asm_lookupanimfromaliasifexists("knobs", "inner_root");

  if(isDefined(var0)) {
    return asm_getxanim("knobs", var0);
  }

  return asm_getbodyknob();
}

function asm_getfacialknob() {
  var0 = asm_lookupanimfromaliasifexists("always_on", "facial");

  if(isDefined(var0)) {
    return asm_getxanim("always_on", var0);
  }
}

function asm_getheadlookknobifexists() {
  var0 = asm_lookupanimfromaliasifexists("knobs", "headlook");

  if(isDefined(var0)) {
    return asm_getxanim("knobs", var0);
  }

  return undefined;
}

function asm_isweaponoverride() {
  var0 = self.weapon;
  var1 = getweaponbasename(var0);
  var2 = ["iw7_cheytac", "iw7_kbs", "iw7_m1", "iw7_m8", "iw7_mauler", "iw7_sdflmg", "iw7_ameli", "iw7_steeldragon", "iw7_sonic", "iw7_sdfshotty", "iw7_spas"];

  if(isDefined(var1) && scripts\engine\utility::array_contains(var2, var1)) {
    return true;
  }

  return false;
}

function asm_getxanim(var0, var1) {
  if(isnumber(var1)) {
    var2 = undefined;

    if(!isDefined(self.asm)) {
      var2 = self.animationarchetype;
    } else {
      var2 = self.asm.archetype;
    }

    return animsetgetallanimindicesforalias(var2, var0, var1);
  }

  return var2;
}

function asm_playanimstatewithnotetrackinterceptor(var0, var1, var2, var3) {
  self endon(var1 + "_finished");
  var4 = asm_getanim(var0, var1);
  self aisetanim(var1, var4);
  asm_playfacialanim(var0, var1, asm_getxanim(var1, var4));
  var5 = asm_donotetrackswithinterceptor(var0, var1, var2, var3);

  if(var5 == "end") {
    if(!asm_eventfired(var0, "end")) {
      asm_fireevent(var0, "end");
      return;
    }

    return;
  }
}

function asm_playanimstatenotransition(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = asm_getanim(var0, var1);
  self aisetanim(var1, var3);
  asm_playfacialanim(var0, var1, asm_getxanim(var1, var3));
  var4 = asm_donotetracks(var0, var1, asm_getnotehandler(var0, var1));
}

function asm_playadditiveanimloopstate(var0, var1, var2) {
  [[self.fnasm_playadditiveanimloopstate]](var0, var1, var2);
}

function setup_level_ents() {
  foreach(var1 in getnodearray("traverse", "targetname")) {
    traversethink(var1);
  }
}

function processdoublejumpmantletraversal(var0) {
  self.doublejumpmantlepos = var0.origin;
  self.startnodeoriginalangles = self.angles;

  if(isent(var0)) {
    var0 delete();
    return;
  }

  scripts\engine\utility::deletestruct_ref(var0);
}

function traversethink() {
  var0 = getEnt(self.target, "targetname");

  if(!isDefined(var0)) {
    var0 = scripts\engine\utility::getStruct(self.target, "targetname");
  }

  var1 = getnode(self.target, "targetname");

  if(!isDefined(var0)) {
    return;
  }

  switch (self.animscript) {
    case "wall_run":
      processwallruntraversal(var0);
      return;
    case "double_jump_mantle":
    case "double_jump_vault":
      processdoublejumpmantletraversal(var0);
      return;
    case "double_jump":
      self.startnodeoriginalangles = self.angles;

      if(!isDefined(var0)) {
        return;
      }

      self.jump_over_offset = var0.origin - self.origin;
      self.jump_over_ent_origin = var0.origin;
      break;
    case "rail_hop_double_jump_down":
      self.startnodeoriginalangles = self.angles;
      break;
    default:
      break;
  }

  if(isDefined(var0.target)) {
    var3 = getEnt(var0.target, "targetname");

    if(!isDefined(var3)) {
      var3 = scripts\engine\utility::getStruct(var0.target, "targetname");
    }

    calculate_traverse_data(var0.origin, var1.origin, var3.origin);
  } else {
    calculate_traverse_data(var0.origin, var1.origin);
  }

  if(isDefined(self.parentname)) {
    store_original_traverse_data();
  }

  if(isent(var0)) {
    var0 delete();
    return;
  }

  scripts\engine\utility::deletestruct_ref(var0);
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

  var0 = getnode(self.target, "targetname");

  if(isDefined(var0)) {
    self.original_data.endnode_pos = var0.origin;
    return;
  }
}

function calculate_traverse_data(var0, var1, var2) {
  self.traverse_height = var0[2];
  self.traverse_height_delta = var0[2] - self.origin[2];
  self.traverse_drop_height_delta = var0[2] - var1[2];
  self.apex_delta = var0 - self.origin;

  if(isDefined(var2)) {
    self.across_delta = var2 - var0;
    return;
  }
}

function re_calculate_traverse_data(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = self.origin + rotatevector(var0.original_data.apex_delta_local, self.angles);
  }

  if(!isDefined(var2)) {
    var2 = var0.original_data.endnode_pos;
  }

  if(!isDefined(var3) && isDefined(var0.original_data.across_delta_local)) {
    var4 = rotatevector(var0.original_data.across_delta_local, self.angles);
    var3 = var1 + var4;
  }

  calculate_traverse_data(var1, var2, var3);
}

function processwallruntraversal(var0) {
  var1 = getEnt(var0.target, "targetname");

  if(!isDefined(var1)) {
    var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  }

  self.wall_info = spawnStruct();
  var3 = var0;
  var4 = 0;
  self.wall_info.startnodeoriginalangles = self.angles;
  var6 = undefined;

  while(isDefined(var3)) {
    self.wall_info.nodeoffsets[var4] = var3.origin - self.origin;
    var4++;
    var7 = scripts\engine\utility::getStruct(var3.target, "targetname");
    scripts\engine\utility::deletestruct_ref(var3);
    var3 = var7;
    self.wall_info.nodeoffsets[var4] = var3.origin - self.origin;
    var4++;

    if(isDefined(var3.target)) {
      var10 = scripts\engine\utility::getStruct(var3.target, "targetname");
    } else {
      var10 = undefined;
    }

    scripts\engine\utility::deletestruct_ref(var3);
    var3 = var10;

    if(isDefined(var3) && isDefined(var3.script_wallrun_type)) {
      if(var3.script_wallrun_type == "wallrun_mantle") {
        self.wall_info.mantleoffset = var3.origin - self.origin;

        if(isDefined(var3.angles)) {
          self.wall_info.mantleangles = var3.angles;
        }

        scripts\engine\utility::deletestruct_ref(var3);
        break;
      }

      if(var3.script_wallrun_type == "wallrun_vault") {
        self.wall_info.mantleoffset = var3.origin - self.origin;
        self.wall_info.bvaultover = 1;
        scripts\engine\utility::deletestruct_ref(var3);
        break;
      }
    }
  }
}