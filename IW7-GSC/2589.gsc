/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2589.gsc
************************/

func_234D(param_00) {
  scripts\asm\asm::func_234E();
  self.asm = spawnStruct();
  self.asm.animoverrides = [];
  self.asm.var_7360 = 0;
  self.var_164D = [];
  self.asmname = param_00;
  self.var_718F = ::func_230F;
  self.var_7193 = ::func_235A;
  self.var_7192 = ::func_2347;
  self.var_7191 = ::asm_getallanimsforstate;
  scripts\asm\asm::func_2351(param_00, 1);
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
      if(![
          [self.var_71D0]
        ]()) {
        continue;
      }
    } else if(!func_1004C()) {
      continue;
    }

    foreach(var_04, var_01 in self.var_164D) {
      var_02 = var_01.var_4BC0;
      var_03 = level.asm[var_04].states[var_02];
      if(!isDefined(var_03.var_C87F)) {
        continue;
      }

      scripts\asm\asm::func_2388(var_04, var_02, var_03, var_03.var_116FB);
      scripts\asm\asm::func_238A(var_04, var_03.var_C87F, 0.2, undefined, undefined, var_03.var_C87C);
    }
  }
}

traversehandler() {
  self endon("death");
  self endon("terminate_ai_threads");
  for(;;) {
    self waittill("traverse_begin", var_00, var_01);
    var_02 = self.asmname;
    var_03 = level.asm[var_02];
    var_04 = var_03.states[var_00];
    if(!isDefined(var_04)) {
      var_00 = "traverse_external";
    }

    var_05 = self.var_164D[var_02].var_4BC0;
    var_06 = var_03.states[var_05];
    scripts\asm\asm::func_2388(var_02, var_05, var_06, var_06.var_116FB);
    scripts\asm\asm::func_238A(var_02, var_00, 0.2, undefined, undefined, undefined);
  }
}

func_1004C() {
  var_00 = 300;
  if(isDefined(self.allowpain) && self.allowpain == 0) {
    return 0;
  }

  if(!scripts\asm\asm_bb::bb_wantstostrafe()) {
    if(isDefined(self.vehicle_getspawnerarray)) {
      if(self pathdisttogoal() < var_00) {
        return 0;
      }

      var_01 = self getspectatepoint();
      if(isDefined(var_01)) {
        var_02 = distancesquared(self.origin, var_01.origin);
        if(var_02 < var_00 * var_00) {
          return 0;
        }
      }
    }
  }

  return 1;
}

func_235F(param_00, param_01, param_02, param_03, param_04) {
  self endon(param_01 + "_finished");
  if(!isDefined(param_03)) {
    param_03 = 1;
  }

  var_05 = scripts\asm\asm::func_2341(param_00, param_01);
  for(;;) {
    var_06 = asm_getanim(param_00, param_01);
    self setanimstate(param_01, var_06, param_03);
    scripts\mp\agents\_scriptedagents::func_1384C(param_01, "end", param_01, var_06, var_05);
  }
}

func_2345(param_00, param_01, param_02, param_03) {
  scripts\asm\asm::asm_fireevent(param_01, param_00);
}

func_2365(param_00, param_01, param_02, param_03, param_04) {
  self endon(param_01 + "_finished");
  var_05 = scripts\asm\asm::func_2341(param_00, param_01);
  if(isDefined(param_04)) {
    scripts\mp\agents\_scriptedagents::func_CED2(param_01, param_03, param_04, param_01, "end", var_05);
    return;
  }

  scripts\mp\agents\_scriptedagents::func_CED5(param_01, param_03, param_01, "end", var_05);
}

func_2366(param_00, param_01, param_02, param_03) {
  func_2364(param_00, param_01, param_02, param_03);
}

func_2364(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = asm_getanim(param_00, param_01);
  var_05 = scripts\asm\asm::func_2341(param_00, param_01);
  scripts\mp\agents\_scriptedagents::func_CED5(param_01, var_04, param_01, "end", var_05);
}

func_2367(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
  var_04 = asm_getanim(param_00, param_01);
  var_05 = scripts\asm\asm::func_2341(param_00, param_01);
  scripts\mp\agents\_scriptedagents::func_CED5(param_01, var_04, param_01, param_03, var_05);
}

func_2361(param_00, param_01, param_02, param_03) {
  self endon(param_01 + "_finished");
}

func_2382(param_00, param_01) {
  if(!isDefined(param_01.var_4E6D)) {
    return 0;
  }

  if(isalive(self)) {
    return 0;
  }

  return 1;
}

func_237E(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "code_move";
  }

  self ghostlaunched(param_00);
}

func_237F(param_00) {
  switch (param_00) {
    case "face goal":
      var_01 = self _meth_8150();
      if(isDefined(var_01)) {
        var_02 = var_01 - self.origin;
        var_03 = vectornormalize(var_02);
        var_04 = vectortoangles(var_03);
        self orientmode("face angle abs", var_04);
        break;
      }

      break;

    case "face current":
      self orientmode("face angle abs", self.angles);
      break;

    case "face motion":
    case "face enemy":
      self orientmode(param_00);
      break;

    case "face node":
      var_05 = self.angles[1];
      var_06 = 1024;
      if(isDefined(self.target_getindexoftarget) && distancesquared(self.origin, self.target_getindexoftarget.origin) < var_06) {
        var_05 = scripts\asm\shared_utility::getnodeforwardyaw(self.target_getindexoftarget);
      }

      var_07 = (0, var_05, 0);
      self orientmode("face angle abs", var_07);
      break;

    default:
      break;
  }
}

func_230F(param_00) {
  if(isDefined(param_00.var_1FBA)) {
    func_237E(param_00.var_1FBA);
  }

  if(isDefined(param_00.var_C704)) {
    func_237F(param_00.var_C704);
  }
}

asm_getanim(param_00, param_01) {
  var_02 = level.asm[param_00].states[param_01].var_71A5;
  var_03 = level.asm[param_00].states[param_01].var_7DC8;
  var_04 = self[[var_02]](param_00, param_01, var_03);
  return var_04;
}

func_7EA3() {
  var_00 = undefined;
  if(!isDefined(self.heat)) {
    var_01 = 400;
  } else {
    var_01 = 4096;
  }

  if(isDefined(self.target_getindexoftarget) && distancesquared(self.origin, self.target_getindexoftarget.origin) < var_01) {
    var_00 = self.target_getindexoftarget;
  } else if(isDefined(self.weaponmaxdist) && distancesquared(self.origin, self.weaponmaxdist.origin) < var_01) {
    var_00 = self.weaponmaxdist;
  }

  if(isDefined(var_00) && isDefined(self.heat) && scripts\engine\utility::absangleclamp180(self.angles[1] - var_00.angles[1]) > 30) {
    return undefined;
  }

  return var_00;
}

func_235A(param_00, param_01) {
  param_01 = tolower(param_01);
  return self getsafecircleradius(param_00, param_01);
}

func_2347(param_00, param_01) {
  param_01 = tolower(param_01);
  if(!self getsantizedhealth(param_00, param_01)) {
    return 0;
  }

  return 1;
}

asm_getallanimsforstate(param_00, param_01) {
  var_02 = asm_getanim(param_00, param_01);
  var_03 = self getsafecircleorigin(param_01, var_02);
  return var_03;
}