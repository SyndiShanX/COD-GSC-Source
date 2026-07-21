/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\asm.gsc
***********************************************/

asm_getfunction(var_0, var_1) {
  return anim.asmfuncs[var_0][var_1];
}

asm_getgenerichandler() {
  return::asm_generichandler;
}

asm_getparams(var_0, var_1) {
  return anim.asmparams[var_0][var_1];
}

asm_setupaim(var_0, var_1, var_2, var_3) {
  if(isDefined(self.fnasm_setupaim))
    self[[self.fnasm_setupaim]](var_0, var_1, var_2, var_3);
}

asm_settransitionorientmode(var_0) {
  switch (var_0) {
    case "_encstr_AB490A2BB8D9DDBE1D70D78F":
      var_1 = 1024.0;

      if(scripts\engine\utility::actor_is3d()) {
        var_2 = self.angles;

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_1)
          var_2 = scripts\asm\shared\utility::getnodeforwardangles(self.node);

        self orientmode("_encstr_91440EF5D7AA1B467F70DAB9531A9ED1", var_2);
      } else {
        var_3 = self.angles[1];

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_1)
          var_3 = scripts\asm\shared\utility::getnodeforwardyaw(self.node);

        self orientmode("_encstr_A34A0B518A172592D6E64FA115", var_3);
      }

      break;
    case "_encstr_91730D640BC68899BFF532BB38850B":
      self orientmode("_encstr_91440EF5D7AA1B467F70DAB9531A9ED1", self.angles);
      break;
    default:
      self orientmode(var_0);
      break;
  }
}

asm_settransitionanimmode(var_0) {
  if(isDefined(self.fnasm_setanimmode)) {
    self[[self.fnasm_setanimmode]](var_0);
    return;
  }

  self animmode(var_0, 0);
}

asm_generichandler(var_0, var_1, var_2, var_3, var_4) {
  switch (var_0) {
    case "_encstr_A1370BA72B7F1AD5301DB8F515":
      asm_settransitionorientmode(var_2);
      break;
    case "_encstr_8EB2099B8041FB63B123FD":
      asm_setupaim(var_1, var_2, 0.2, undefined);
      break;
    case "_encstr_9A440DB8723BC323AF5D867D2593C9":
      if(isDefined(self.fnasm_setupgesture))
        self[[self.fnasm_setupgesture]](var_1, var_2);

      break;
    case "_encstr_96400A3B8A2EB05D3B73D379":
      self.asm.archetype = var_2;
      self.animationarchetype = var_2;
      break;
    case "_encstr_83BA0526F0CBD7":
      var_5 = asm_getnotehandler(var_1, undefined);
      var_6 = [[self.fnasm_handlenotetrack]](var_3, var_2, var_5, undefined);

      if(!isDefined(var_6))
        var_6 = asm_handlenewnotetracks(var_1, var_3, var_2);

      if(isDefined(var_6) && !asm_eventfired(var_1, "_encstr_961804BD954A"))
        asm_fireevent(var_1, "_encstr_961804BD954A");

      break;
    case "_encstr_83A210BB16D23ACC7B9323DBBDE4B783CA73":
      thread scripts\asm\shared\utility::waitfordooropen(var_1, var_2, var_3);
      break;
    case "_encstr_A2160D2218CC6F29A0D9627DE308EA":
      var_7 = var_2;
      thread scripts\asm\shared\utility::waitforcoverapproach(var_1, var_7);
      thread scripts\asm\shared\utility::waitforsharpturn(var_1, var_7);
      break;
    default:
      break;
  }
}

asm_setoverrideparams(var_0, var_1) {
  var_2 = 9999;
  anim.asmparams[var_0][var_2] = var_1;
  return var_2;
}

asm_globalinit() {
  if(isDefined(anim.asm)) {
    return;
  }
  anim.asm = [];
}

asm_fireephemeralevent(var_0, var_1, var_2) {
  self asmfireephemeralevent(var_0, var_1, var_2);
}

asm_init_blackboard() {
  if(isDefined(self._blackboard)) {
    return;
  }
  self._blackboard = self getaiblackboard();
  self._blackboard.asm_events = [];
  self._blackboard.asm_ephemeral_events = [];
  self._blackboard.asm_ephemeral_event_watchlist = [];
  self._blackboard.bfire = 0;
}

asm_clearevents(var_0) {
  if(isDefined(self._blackboard.asm_events[var_0]))
    self._blackboard.asm_events[var_0] = undefined;
}

asm_terminateandreplace(var_0, var_1) {
  self asmterminate();
  self clearaiblackboard();
  self._blackboard = undefined;
  self notify("_encstr_A6F10F617BFFE8E0674AEBFB4E4EA84D63");

  if(!isDefined(var_1))
    var_1 = self.asm.archetype;

  asm_init_blackboard();
  self[[self.fnasm_init]](tolower(var_0), var_1);
}

asm_getnotehandler(var_0, var_1) {
  var_2 = self asmgetnotehandler(var_0);

  if(var_2 != -1)
    return anim.asmfuncs[var_0][var_2];

  return undefined;
}

asm_currentstatehasflag(var_0, var_1) {
  if(isDefined(self.asm.forcetrackloop))
    return 1;

  return self asmcurrentstatehasflag(var_0, var_1);
}

asm_fireevent_internal(var_0, var_1, var_2) {
  self asmfireevent(var_0, var_1, var_2);
}

asm_fireevent(var_0, var_1, var_2) {
  asm_fireevent_internal(var_0, var_1, var_2);

  if(var_1 == "_encstr_8110118AE84BCDEF6333EC14C0A9FFD593A8A2" || var_1 == "_encstr_B4BA07CC5ADCB4CDD0") {
    var_1 = "_encstr_961804BD954A";
    asm_fireevent_internal(var_0, var_1);
  }
}

asm_addephemeraleventtowatchlist(var_0, var_1) {
  self._blackboard.asm_ephemeral_event_watchlist[var_0] = var_1;
}

asm_ephemeraleventfired(var_0, var_1, var_2) {
  var_3 = self asmephemeraleventfired(var_0, var_1);

  if(var_3)
    return 1;

  if(!isDefined(var_2) || var_2)
    asm_addephemeraleventtowatchlist(var_0, var_1);

  return 0;
}

asm_eventfiredrecently(var_0, var_1) {
  return self asmeventfiredwithin(var_0, var_1, 50);
}

asm_geteventtime(var_0, var_1) {
  return self asmgeteventtime(var_0, var_1);
}

asm_geteventdata(var_0, var_1) {
  return self asmgeteventdata(var_0, var_1);
}

asm_getephemeraleventdata(var_0, var_1) {
  return self asmgetephemeraleventdata(var_0, var_1);
}

asm_clearallephemeralevents() {
  self asmclearephemeralevents();
}

asm_shouldpowerdown(var_0, var_1) {
  if(!isDefined(self.bpowerdown) || !self.bpowerdown)
    return 0;

  if(isDefined(self.asm.bpowereddown) && self.asm.bpowereddown)
    return 0;

  if(!isalive(self))
    return 0;

  if(scripts\asm\asm_bb::bb_isanimScripted())
    return 0;

  if(isDefined(self._blackboard.btraversing))
    return 0;

  if(isDefined(self.melee))
    return 0;

  return 1;
}

asm_eventfired(var_0, var_1) {
  return self asmeventfired(var_0, var_1);
}

asm_checktransitions(var_0, var_1, var_2) {
  self asmtick(1);
}

asm_setstate(var_0, var_1) {
  if(self asmhasstate(self.asmname, var_0))
    self asmsetstate(self.asmname, var_0, var_1);
}

asm_tick() {}

highestallowedstance(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\shared\utility::gethighestallowedstance();

  if(isDefined(var_4) && var_4 != var_3)
    return 0;

  return 1;
}

asm_getdemeanor() {
  return self._blackboard.movetype;
}

asm_updatefrantic() {
  if(!isDefined(self.pathgoalpos) || distancesquared(self.origin, self.pathgoalpos) > 4096.0)
    self.asm.frantic = scripts\asm\asm_bb::bb_isfrantic();
}

asm_isfrantic() {
  return isDefined(self.asm) && self.asm.frantic;
}

asm_iscrawlmelee() {
  return isDefined(self.asm.crawlmelee);
}

asm_setcrawlmelee(var_0) {
  self.asm.crawlmelee = var_0;
}

asm_setdemeanoranimoverride(var_0, var_1, var_2) {
  self.asm.animoverrides[var_0][var_1] = var_2;
}

asm_cleardemeanoranimoverride(var_0, var_1) {
  if(asm_hasdemeanoranimoverride(var_0, var_1))
    self.asm.animoverrides[var_0][var_1] = undefined;
}

asm_hasdemeanoranimoverride(var_0, var_1) {
  return isDefined(self.asm.animoverrides[var_0]) && isDefined(self.asm.animoverrides[var_0][var_1]);
}

asm_getdemeanoranimoverride(var_0, var_1) {
  return self.asm.animoverrides[var_0][var_1];
}

asm_getcurrentstate(var_0) {
  return self asmgetcurrentstate(var_0);
}

asm_hasalias(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(self.animationarchetype))
    var_2 = self.animationarchetype;
  else
    var_2 = self.asm.archetype;

  var_3 = archetypegetrandomalias(var_2, var_0, var_1, asm_isfrantic());
  return isDefined(var_3);
}

asm_getanim(var_0, var_1, var_2) {
  if(isarray(var_2)) {
    if(var_2.size == 1)
      return self asmgetanim(var_0, var_1, var_2[0]);
    else if(var_2.size == 2)
      return self asmgetanim(var_0, var_1, var_2[0], var_2[1]);
    else if(var_2.size == 3)
      return self asmgetanim(var_0, var_1, var_2[0], var_2[1], var_2[2]);
    else {}
  } else
    return self asmgetanim(var_0, var_1, var_2);
}

asm_getrandomanim(var_0, var_1) {
  var_2 = asm_getrandomalias(var_1);
  return asm_lookupanimfromalias(var_1, var_2);
}

asm_getrandomalias(var_0) {
  var_1 = archetypegetaliases(self.asm.archetype, var_0);
  return var_1[randomint(var_1.size)];
}

asm_lookupanimfromaliasifexists(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(self.animationarchetype))
    var_2 = self.animationarchetype;
  else
    var_2 = self.asm.archetype;

  var_3 = archetypegetrandomalias(var_2, var_0, var_1, asm_isfrantic());
  return var_3;
}

asm_lookupanimfromalias(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(self.animationarchetype))
    var_2 = self.animationarchetype;
  else
    var_2 = self.asm.archetype;

  var_3 = archetypegetrandomalias(var_2, var_0, var_1, asm_isfrantic());
  return var_3;
}

asm_getallanimsforstate(var_0) {
  var_1 = self.asm.archetype;
  var_2 = archetypegetaliases(var_1, var_0);
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = archetypegetalias(var_1, var_0, var_5, 0);

    if(isarray(var_6.anims)) {
      var_3 = scripts\engine\utility::array_combine(var_3, var_6.anims);
      continue;
    }

    var_3[var_3.size] = var_6.anims;
  }

  return var_3;
}

asm_getallanimsforalias(var_0, var_1, var_2) {
  var_3 = archetypegetalias(var_0, var_1, var_2, 1);

  if(!isDefined(var_3))
    return undefined;

  var_4 = var_3.anims;

  if(!isarray(var_4))
    var_4 = [var_4];

  return var_4;
}

asm_getallanimindicesforalias(var_0, var_1) {
  return analyticsstreamerlogfileendstream(self.asm.archetype, var_0, var_1);
}

asm_playanimstate(var_0, var_1, var_2) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  var_3 = asm_getanim(var_0, var_1);
  self aisetanim(var_1, var_3);
  asm_playfacialanim(var_0, var_1, asm_getxanim(var_1, var_3));
  var_4 = asm_donotetracks(var_0, var_1, asm_getnotehandler(var_0, var_1));

  if(var_4 == "_encstr_B6B30A278FC7F078673A0B11")
    var_4 = asm_donotetracks(var_0, var_1, asm_getnotehandler(var_0, var_1));
}

asm_hasknobs() {
  if(isagent(self) && !istrue(self.bsoldier) && self.unittype != "_encstr_83E8094727E333E8F9CE50")
    return 0;

  return 1;
}

asm_loopanimstate(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");

  if(asm_hasknobs()) {
    var_4 = asm_getbodyknob();

    if(isDefined(var_3) && var_3) {
      var_5 = asm_lookupanimfromaliasifexists("_encstr_999306BA95FACD6B", "_encstr_ACA20538F84D39");

      if(isDefined(var_5)) {
        var_6 = asm_getxanim("_encstr_999306BA95FACD6B", var_5);
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

    if(!var_9)
      var_10 = self aigetanimweight(var_12) == 0;

    if(isnumber(var_11))
      self aisetanim(var_1, var_11, var_2);
    else {
      var_13 = asm_lookupanimfromalias(var_1, "_encstr_AFAB063620A0C612");
      self aisetanim(var_1, var_13);

      if(var_10)
        self setflaggedanimrestart(var_1, var_11, 1, 0.2, var_2);
      else
        self setflaggedanim(var_1, var_11, 1, 0.2, var_2);
    }

    if(var_9)
      var_10 = 0;

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

asm_lookupdirectionalfootanim(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "_encstr_B40101";

  if(isDefined(var_4))
    var_5 = var_4;

  if(var_3) {
    if(asm_eventfiredrecently(var_1, "_encstr_A2A90A0E16B9E6EB1BAC99D1"))
      var_6 = var_5 + "_encstr_A5AD056A019C63";
    else if(asm_eventfiredrecently(var_1, "_encstr_8B830BC116B99BD79C4B9D0D3A"))
      var_6 = var_5 + "_encstr_8253060E2B5FE330";
    else if(self.asm.footsteps.foot == "_encstr_8253060E2B5FE330")
      var_6 = var_5 + "_encstr_8253060E2B5FE330";
    else
      var_6 = var_5 + "_encstr_A5AD056A019C63";
  } else
    var_6 = var_5;

  var_7 = asm_lookupanimfromaliasifexists(var_2, var_6 + var_0);

  if(isDefined(var_7))
    return var_7;

  if(var_5 != var_6) {
    var_7 = asm_lookupanimfromaliasifexists(var_2, var_5 + var_0);

    if(isDefined(var_7))
      return var_7;
  }

  return undefined;
}

asm_setmoveplaybackrate(var_0) {
  self.moveplaybackrate = var_0;
}

asm_getmoveplaybackrate() {
  return self.moveplaybackrate;
}

asm_getcurrentstatename(var_0) {
  return self asmgetcurrentstate(var_0);
}

asm_dosinglenotetrack(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1;

  if(isDefined(var_4))
    var_5 = var_4;

  self waittill(var_5, var_6);

  if(!isDefined(var_6))
    var_6 = ["_encstr_8C500ABA9B23CACC2D37AC8C"];

  if(!isarray(var_6))
    var_6 = [var_6];

  var_7 = undefined;

  foreach(var_9 in var_6) {
    asm_fireevent(var_0, var_9);
    var_10 = [[self.fnasm_handlenotetrack]](var_9, var_5, var_2, var_3);

    if(!isDefined(var_10))
      var_10 = asm_handlenewnotetracks(var_0, var_9, var_1);

    if(isDefined(var_10))
      var_7 = var_10;
  }

  return var_7;
}

asm_handlenewnotetracks(var_0, var_1, var_2) {
  if(asm_tryhandledeathstatechangenotetrack(var_1)) {
    return;
  }
  switch (var_1) {
    case "_encstr_82AB0A82D3502A13E08BE78F":
      if(asm_currentstatehasflag(var_0, "_encstr_B43B0D73DE3AAC1DC9851B6D50D2B5"))
        asm_setupaim(var_0, var_2, 0.2);

      break;
  }
}

asm_tryhandledeathstatechangenotetrack(var_0) {
  if(!scripts\engine\utility::string_starts_with(var_0, "_encstr_9118045463D6"))
    return 0;

  var_1 = 3;
  self.asm.deathstateoverride = spawnStruct();
  var_1 = var_1 + 1;

  for(var_2 = "_encstr_B40101"; var_1 < var_0.size && var_0[var_1] != "_encstr_8C4C0209"; var_1 = var_1 + 1)
    var_2 = var_2 + var_0[var_1];

  self.asm.deathstateoverride.statename = var_2;
  var_1 = var_1 + 1;

  if(var_1 < var_0.size) {
    var_1 = var_1 + 2;

    for(var_3 = "_encstr_B40101"; var_1 < var_0.size && var_0[var_1] != "_encstr_8C4C0209"; var_1 = var_1 + 1)
      var_3 = var_3 + var_0[var_1];

    self.asm.deathstateoverride.params = var_3;
  }

  return 1;
}

asm_donotetracksfortime(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1 + "_encstr_A3BD09C633595885CA97A1";
  self endon(var_5);
  childthread asm_donotetracksfortime_helper(var_5, var_2);

  for(;;)
    asm_dosinglenotetrack(var_0, var_1, var_3, var_4);
}

asm_donotetrackswithtimeout_helper(var_0, var_1, var_2) {
  self endon(var_0);
  wait(var_2);
  self notify(var_1);
}

asm_donotetrackswithtimeout(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1 + "_encstr_A3BD09C633595885CA97A1";
  var_6 = var_1 + "_encstr_86910B788F3219C4AD73389863";
  self endon(var_5);
  childthread asm_donotetrackswithtimeout_helper(var_6, var_5, var_2);
  var_7 = asm_donotetracks(var_0, var_1, var_3, var_4);
  self notify(var_6);
  return var_7;
}

asm_donotetracks(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5))
    var_5 = 1;

  for(;;) {
    var_6 = asm_dosinglenotetrack(var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_6)) {
      if(var_5 && !asm_eventfired(var_0, "_encstr_961804BD954A"))
        asm_fireevent(var_0, "_encstr_961804BD954A");

      return var_6;
    }
  }
}

asm_donotetrackswithinterceptor(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1;

  if(isDefined(var_4))
    var_5 = var_4;

  for(;;) {
    self waittill(var_5, var_6);

    if(!isDefined(var_6))
      var_6 = ["_encstr_8C500ABA9B23CACC2D37AC8C"];

    if(!isarray(var_6))
      var_6 = [var_6];

    var_7 = undefined;

    foreach(var_9 in var_6) {
      asm_fireevent(var_0, var_9);
      var_10 = [[var_2]](var_1, var_9, var_3);

      if(isDefined(var_10) && var_10) {
        continue;
      }
      var_11 = [[self.fnasm_handlenotetrack]](var_9, var_1, undefined, undefined);

      if(!isDefined(var_11))
        var_11 = asm_handlenewnotetracks(var_0, var_9, var_1);

      if(isDefined(var_11))
        var_7 = var_11;
    }

    if(isDefined(var_7))
      return var_7;
  }
}

asm_donotetrackssingleloop(var_0, var_1, var_2, var_3) {
  var_4 = var_1 + "_encstr_95CC0FEBE6BD1DACD7C6B7F638D7B2738C";
  self endon(var_4);
  var_5 = getanimlength(var_2);
  thread asm_donotetrackssingleloop_waiter(var_4, var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C", var_5);
  asm_donotetracks(var_0, var_1, var_3);
  self notify(var_4);
}

asm_donotetrackssingleloop_waiter(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B2F1150BDFFAE03B721F4963CFAA732994F4B3A14654D8");
  self endon(var_0);
  self endon(var_1);
  wait(var_2);
  self notify(var_0);
}

asm_donotetracksfortime_helper(var_0, var_1) {
  wait(var_1);
  self notify(var_0);
}

asm_waitforaimnotetrack(var_0, var_1, var_2) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  var_3 = 0;

  while(!var_3) {
    self waittill(var_1, var_4);

    if(!isarray(var_4))
      var_4 = [var_4];

    foreach(var_6 in var_4) {
      if(var_6 == "_encstr_82AB0A82D3502A13E08BE78F") {
        asm_setupaim(var_0, var_1, var_2);
        var_3 = 1;
        break;
      }
    }
  }
}

asm_lookuprandomalias(var_0, var_1, var_2) {
  var_3 = self.asm.archetype;
  var_4 = archetypegetaliases(var_3, var_0);
  var_5 = 0.0;
  var_6 = undefined;
  var_7 = -1;

  if(isDefined(var_1))
    var_7 = var_1.size;

  if(!isDefined(var_4))
    return undefined;

  foreach(var_10 in var_4) {
    if(var_7 < 0 || getsubstr(var_10, 0, var_7) == var_1) {
      var_5 = var_5 + 1.0;
      var_11 = 1.0 / var_5;

      if(randomfloat(1.0) <= var_11)
        var_6 = var_10;
    }
  }

  return var_6;
}

asm_chooseanim(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_3 = asm_lookuprandomalias(var_1);
    return asm_lookupanimfromalias(var_1, var_3);
  } else {
    var_4 = undefined;
    var_5 = scripts\asm\asm_bb::bb_getprefixstring(var_2);

    if(isDefined(var_5)) {
      var_3 = asm_lookuprandomalias(var_1, var_5);
      var_4 = asm_lookupanimfromalias(var_1, var_3);
    } else
      var_4 = asm_lookupanimfromalias(var_1, var_2);

    return var_4;
  }
}

asm_clearfacialanim() {
  if(self.facialstate != "_encstr_92A9077D73BCC33072") {
    if(isai(self))
      self setfacialindex("_encstr_8BBA05185F8B99");
    else
      scripts\asm\shared\utility::setfacialindexfornonai("_encstr_8BBA05185F8B99");
  }
}

asm_restorefacialanim() {
  var_0 = self.asmname;
  var_1 = self asmgetcurrentstate(var_0);

  if(var_1 == "_encstr_84610D49100897C2DF809A03583BFF") {
    return;
  }
  asm_playfacialanim(var_0, var_1, undefined);
}

asm_playfacialanim(var_0, var_1, var_2) {
  if(isDefined(self.fnasm_playfacialanim))
    [[self.fnasm_playfacialanim]](var_0, var_1, var_2);
}

asm_getroot() {
  var_0 = asm_lookupanimfromalias("_encstr_999306BA95FACD6B", "_encstr_9A1F0539BDB747");
  return asm_getxanim("_encstr_999306BA95FACD6B", var_0);
}

asm_getbodyknob() {
  var_0 = asm_lookupanimfromalias("_encstr_999306BA95FACD6B", "_encstr_AD9B0589ED9197");
  return asm_getxanim("_encstr_999306BA95FACD6B", var_0);
}

asm_getinnerrootknob() {
  var_0 = asm_lookupanimfromaliasifexists("_encstr_999306BA95FACD6B", "_encstr_B6FE0B2D9BB95993D727DBB7E8");

  if(isDefined(var_0))
    return asm_getxanim("_encstr_999306BA95FACD6B", var_0);

  return asm_getbodyknob();
}

asm_getfacialknob() {
  var_0 = asm_lookupanimfromaliasifexists("_encstr_AAE20A695D3F40F36327BFB5", "_encstr_8E99078E2BF0B477C1");

  if(isDefined(var_0))
    return asm_getxanim("_encstr_AAE20A695D3F40F36327BFB5", var_0);
}

asm_getheadlookknobifexists() {
  var_0 = asm_lookupanimfromaliasifexists("_encstr_999306BA95FACD6B", "_encstr_928209A075E953A567C81A");

  if(isDefined(var_0))
    return asm_getxanim("_encstr_999306BA95FACD6B", var_0);

  return undefined;
}

asm_isweaponoverride() {
  var_0 = self.weapon;
  var_1 = getweaponbasename(var_0);
  var_2 = ["_encstr_8E790C2DDDCDBEC63495BCD12C1B", "_encstr_A186083A8BA22E5AD263", "_encstr_A6410710E377B9F15F", "_encstr_AA41072DEEDCEBAD1C", "_encstr_B13A0B8B872FF0080933F8D11A", "_encstr_B44D0B31B7E289AF55A1B2AA69", "_encstr_A18D0AD277B9D758B5ACB12D", "_encstr_A2C9104BDD6EEBE6A395561B32270BB3DBB9", "_encstr_AAE30A689B7FB1F6A2E3B3AF", "_encstr_9A7F0EDA7F475676EC95B7680FB3C517", "_encstr_8CA70922A0B386CA97FF48"];

  if(isDefined(var_1) && scripts\engine\utility::array_contains(var_2, var_1))
    return 1;

  return 0;
}

asm_getxanim(var_0, var_1) {
  if(isnumber(var_1)) {
    var_2 = undefined;

    if(!isDefined(self.asm))
      var_2 = self.animationarchetype;
    else
      var_2 = self.asm.archetype;

    return animsetgetallanimindicesforalias(var_2, var_0, var_1);
  } else
    return var_1;
}

asm_playanimstatewithnotetrackinterceptor(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  var_4 = asm_getanim(var_0, var_1);
  self aisetanim(var_1, var_4);
  asm_playfacialanim(var_0, var_1, asm_getxanim(var_1, var_4));
  var_5 = asm_donotetrackswithinterceptor(var_0, var_1, var_2, var_3);

  if(var_5 == "_encstr_961804BD954A") {
    if(!asm_eventfired(var_0, "_encstr_961804BD954A"))
      asm_fireevent(var_0, "_encstr_961804BD954A");
  }
}

asm_playanimstatenotransition(var_0, var_1, var_2) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  var_3 = asm_getanim(var_0, var_1);
  self aisetanim(var_1, var_3);
  asm_playfacialanim(var_0, var_1, asm_getxanim(var_1, var_3));
  var_4 = asm_donotetracks(var_0, var_1, asm_getnotehandler(var_0, var_1));
}

asm_playadditiveanimloopstate(var_0, var_1, var_2) {
  [[self.fnasm_playadditiveanimloopstate]](var_0, var_1, var_2);
}

setup_level_ents() {
  foreach(var_1 in getnodearray("_encstr_B8C809C3F5BF6B6D9093AF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"))
  var_1 traversethink();
}

processdoublejumpmantletraversal(var_0) {
  self.doublejumpmantlepos = var_0.origin;
  self.startnodeoriginalangles = self.angles;

  if(isent(var_0))
    var_0 delete();
  else
    scripts\engine\utility::deletestruct_ref(var_0);
}

traversethink() {
  var_0 = getEnt(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0))
    var_0 = scripts\engine\utility::getStruct(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  var_1 = getnode(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0)) {
    return;
  }
  switch (self.animscript) {
    case "_encstr_96DC09BB2C8DD8BE935DB9":
      processwallruntraversal(var_0);
      return;
    case "_encstr_84DE130AA0F5DB4D70DF0205A383592F1778831249":
    case "_encstr_B4091227778F4614AFAF82DDFBA0C70C18334DA8":
      processdoublejumpmantletraversal(var_0);
      return;
    case "_encstr_930E0CB7185B92D411396307B0EB":
      self.startnodeoriginalangles = self.angles;

      if(!isDefined(var_0)) {
        return;
      }
      self.jump_over_offset = var_0.origin - self.origin;
      self.jump_over_ent_origin = var_0.origin;
      break;
    case "_encstr_AB341A5537228141A81DC33EC78758CECA8F97ED9F8A5779FC752B10":
      self.startnodeoriginalangles = self.angles;
      break;
    default:
      break;
  }

  if(isDefined(var_0.target)) {
    var_3 = getEnt(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(!isDefined(var_3))
      var_3 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    calculate_traverse_data(var_0.origin, var_1.origin, var_3.origin);
  } else
    calculate_traverse_data(var_0.origin, var_1.origin);

  if(isDefined(self.parentname))
    store_original_traverse_data();

  if(isent(var_0))
    var_0 delete();
  else
    scripts\engine\utility::deletestruct_ref(var_0);
}

store_original_traverse_data() {
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

  var_0 = getnode(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0))
    self.original_data.endnode_pos = var_0.origin;
}

calculate_traverse_data(var_0, var_1, var_2) {
  self.traverse_height = var_0[2];
  self.traverse_height_delta = var_0[2] - self.origin[2];
  self.traverse_drop_height_delta = var_0[2] - var_1[2];
  self.apex_delta = var_0 - self.origin;

  if(isDefined(var_2))
    self.across_delta = var_2 - var_0;
}

re_calculate_traverse_data(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = self.origin + rotatevector(var_0.original_data.apex_delta_local, self.angles);

  if(!isDefined(var_2))
    var_2 = var_0.original_data.endnode_pos;

  if(!isDefined(var_3) && isDefined(var_0.original_data.across_delta_local)) {
    var_4 = rotatevector(var_0.original_data.across_delta_local, self.angles);
    var_3 = var_1 + var_4;
  }

  calculate_traverse_data(var_1, var_2, var_3);
}

processwallruntraversal(var_0) {
  var_1 = getEnt(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_1))
    var_1 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  self.wall_info = spawnStruct();
  var_3 = var_0;
  var_4 = 0;
  self.wall_info.startnodeoriginalangles = self.angles;
  var_6 = undefined;

  while(isDefined(var_3)) {
    self.wall_info.nodeoffsets[var_4] = var_3.origin - self.origin;
    var_4++;
    var_7 = scripts\engine\utility::getStruct(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    scripts\engine\utility::deletestruct_ref(var_3);
    var_3 = var_7;
    self.wall_info.nodeoffsets[var_4] = var_3.origin - self.origin;
    var_4++;

    if(isDefined(var_3.target))
      var_10 = scripts\engine\utility::getStruct(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    else
      var_10 = undefined;

    scripts\engine\utility::deletestruct_ref(var_3);
    var_3 = var_10;

    if(isDefined(var_3) && isDefined(var_3.script_wallrun_type)) {
      if(var_3.script_wallrun_type == "_encstr_A1560FDDC21B1B9CAB73D7AD2C73E81B2B") {
        self.wall_info.mantleoffset = var_3.origin - self.origin;

        if(isDefined(var_3.angles))
          self.wall_info.mantleangles = var_3.angles;

        scripts\engine\utility::deletestruct_ref(var_3);
        break;
      } else if(var_3.script_wallrun_type == "_encstr_BE9D0E4CAE3229A39D5B21604FB53841") {
        self.wall_info.mantleoffset = var_3.origin - self.origin;
        self.wall_info.bvaultover = 1;
        scripts\engine\utility::deletestruct_ref(var_3);
        break;
      }
    }
  }
}