/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2589.gsc
************************/

func_234D(var_0) {
  scripts\asm\asm::func_234E();
  self.asm = spawnStruct();
  self.asm.animoverrides = [];
  self.asm.var_7360 = 0;
  self.var_164D = [];
  self.asmname = var_0;
  self.var_718F = ::func_230F;
  self.var_7193 = ::func_235A;
  self.var_7192 = ::func_2347;
  self.var_7191 = ::asm_getallanimsforstate;
  scripts\asm\asm::func_2351(var_0, 1);
  self.a = spawnStruct();
  self.a.pose = "stand";
  self.a.var_85E2 = "stand";
  self.a.movement = "stop";
  self.a.state = "stop";
  self.a.var_10930 = "none";
  self.a.var_870D = "none";
  self.a.var_D8BD = -1;
  self.a.needstorechamber = 0;
  self.a.combatendtime = gettime();
  self.a.lastenemytime = gettime();
  self.a.var_112CB = 0;
  self.a.disablelongdeath = !self gettargetchargepos();
  self.a.var_AFFF = 0;
  self.a.var_C888 = 0;
  self.a.var_A9ED = 0;
  self.a.nextgrenadetrytime = 0;
  self.a.reacttobulletchance = 0.8;
  self.a.var_D707 = undefined;
  self.a.var_10B53 = "stand";
  self.a.var_B8D6 = 0;
  self.a.nodeath = 0;
  self.a.var_B8D6 = 0;
  self.a.var_B8D8 = 0;
  self.a.var_5605 = 0;
}

func_C878() {
  self endon("death");
  self endon("terminate_ai_threads");
  for(;;) {
    self waittill("pain");
    if(isDefined(self.var_71D0)) {
      if(![[self.var_71D0]]()) {
        continue;
      }
    } else if(!func_1004C()) {
      continue;
    }

    foreach(var_4, var_1 in self.var_164D) {
      var_2 = var_1.var_4BC0;
      var_3 = level.asm[var_4].states[var_2];
      if(!isDefined(var_3.var_C87F)) {
        continue;
      }

      scripts\asm\asm::func_2388(var_4, var_2, var_3, var_3.var_116FB);
      scripts\asm\asm::func_238A(var_4, var_3.var_C87F, 0.2, undefined, undefined, var_3.var_C87C);
    }
  }
}

traversehandler() {
  self endon("death");
  self endon("terminate_ai_threads");
  for(;;) {
    self waittill("traverse_begin", var_0, var_1);
    var_2 = self.asmname;
    var_3 = level.asm[var_2];
    var_4 = var_3.states[var_0];
    if(!isDefined(var_4)) {
      var_0 = "traverse_external";
    }

    var_5 = self.var_164D[var_2].var_4BC0;
    var_6 = var_3.states[var_5];
    scripts\asm\asm::func_2388(var_2, var_5, var_6, var_6.var_116FB);
    scripts\asm\asm::func_238A(var_2, var_0, 0.2, undefined, undefined, undefined);
  }
}

func_1004C() {
  var_0 = 300;
  if(isDefined(self.allowpain) && self.allowpain == 0) {
    return 0;
  }

  if(!scripts\asm\asm_bb::bb_wantstostrafe()) {
    if(isDefined(self.vehicle_getspawnerarray)) {
      if(self pathdisttogoal() < var_0) {
        return 0;
      }

      var_1 = self getspectatepoint();
      if(isDefined(var_1)) {
        var_2 = distancesquared(self.origin, var_1.origin);
        if(var_2 < var_0 * var_0) {
          return 0;
        }
      }
    }
  }

  return 1;
}

func_235F(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  var_5 = scripts\asm\asm::func_2341(var_0, var_1);
  for(;;) {
    var_6 = asm_getanim(var_0, var_1);
    self setanimstate(var_1, var_6, var_3);
    scripts\mp\agents\_scriptedagents::func_1384C(var_1, "end", var_1, var_6, var_5);
  }
}

func_2345(var_0, var_1, var_2, var_3) {
  scripts\asm\asm::asm_fireevent(var_1, var_0);
}

func_2365(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  var_5 = scripts\asm\asm::func_2341(var_0, var_1);
  if(isDefined(var_4)) {
    scripts\mp\agents\_scriptedagents::func_CED2(var_1, var_3, var_4, var_1, "end", var_5);
    return;
  }

  scripts\mp\agents\_scriptedagents::func_CED5(var_1, var_3, var_1, "end", var_5);
}

func_2366(var_0, var_1, var_2, var_3) {
  func_2364(var_0, var_1, var_2, var_3);
}

func_2364(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = asm_getanim(var_0, var_1);
  var_5 = scripts\asm\asm::func_2341(var_0, var_1);
  scripts\mp\agents\_scriptedagents::func_CED5(var_1, var_4, var_1, "end", var_5);
}

func_2367(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = asm_getanim(var_0, var_1);
  var_5 = scripts\asm\asm::func_2341(var_0, var_1);
  scripts\mp\agents\_scriptedagents::func_CED5(var_1, var_4, var_1, var_3, var_5);
}

func_2361(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
}

func_2382(var_0, var_1) {
  if(!isDefined(var_1.var_4E6D)) {
    return 0;
  }

  if(isalive(self)) {
    return 0;
  }

  return 1;
}

func_237E(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "code_move";
  }

  self ghostlaunched(var_0);
}

func_237F(var_0) {
  switch (var_0) {
    case "face goal":
      var_1 = self _meth_8150();
      if(isDefined(var_1)) {
        var_2 = var_1 - self.origin;
        var_3 = vectornormalize(var_2);
        var_4 = vectortoangles(var_3);
        self orientmode("face angle abs", var_4);
        break;
      }

      break;

    case "face current":
      self orientmode("face angle abs", self.angles);
      break;

    case "face motion":
    case "face enemy":
      self orientmode(var_0);
      break;

    case "face node":
      var_5 = self.angles[1];
      var_6 = 1024;
      if(isDefined(self.target_getindexoftarget) && distancesquared(self.origin, self.target_getindexoftarget.origin) < var_6) {
        var_5 = scripts\asm\shared_utility::getnodeforwardyaw(self.target_getindexoftarget);
      }

      var_7 = (0, var_5, 0);
      self orientmode("face angle abs", var_7);
      break;

    default:
      break;
  }
}

func_230F(var_0) {
  if(isDefined(var_0.var_1FBA)) {
    func_237E(var_0.var_1FBA);
  }

  if(isDefined(var_0.var_C704)) {
    func_237F(var_0.var_C704);
  }
}

asm_getanim(var_0, var_1) {
  var_2 = level.asm[var_0].states[var_1].var_71A5;
  var_3 = level.asm[var_0].states[var_1].var_7DC8;
  var_4 = self[[var_2]](var_0, var_1, var_3);
  return var_4;
}

func_7EA3() {
  var_0 = undefined;
  if(!isDefined(self.heat)) {
    var_1 = 400;
  } else {
    var_1 = 4096;
  }

  if(isDefined(self.target_getindexoftarget) && distancesquared(self.origin, self.target_getindexoftarget.origin) < var_1) {
    var_0 = self.target_getindexoftarget;
  } else if(isDefined(self.weaponmaxdist) && distancesquared(self.origin, self.weaponmaxdist.origin) < var_1) {
    var_0 = self.weaponmaxdist;
  }

  if(isDefined(var_0) && isDefined(self.heat) && scripts\engine\utility::absangleclamp180(self.angles[1] - var_0.angles[1]) > 30) {
    return undefined;
  }

  return var_0;
}

func_235A(var_0, var_1) {
  var_1 = tolower(var_1);
  return self getsafecircleradius(var_0, var_1);
}

func_2347(var_0, var_1) {
  var_1 = tolower(var_1);
  if(!self getsantizedhealth(var_0, var_1)) {
    return 0;
  }

  return 1;
}

asm_getallanimsforstate(var_0, var_1) {
  var_2 = asm_getanim(var_0, var_1);
  var_3 = self getsafecircleorigin(var_1, var_2);
  return var_3;
}