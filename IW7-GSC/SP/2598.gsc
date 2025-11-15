/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2598.gsc
************************/

func_3ED1(param_00, param_01, param_02) {
  if(!scripts\asm\asm::asm_hasalias(param_01, self.a.pose)) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "default");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, self.a.pose);
}

func_10073(param_00, param_01, param_02, param_03) {
  if(scripts\asm\asm_bb::bb_selfdestructnow()) {
    return 1;
  }

  return 0;
}

func_C875(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm::func_232B(param_01, "end") && scripts\asm\asm_bb::bb_isselfdestruct();
}

func_337F(param_00, param_01, param_02, param_03) {
  return lib_0A0B::func_2040();
}

func_33AC(param_00, param_01, param_02, param_03) {
  lib_0C60::func_11043();
  self playSound("shield_death_c6_1");
  func_3368();
  scripts\anim\shared::func_5D1A();
  var_04 = vectornormalize(self.origin - level.player.origin + (0, 0, 30));
  if(self.var_E2 == "iw7_c6hack_melee" || self.var_E2 == "iw7_c6worker_fists") {
    var_04 = vectornormalize(self.origin - level.player.origin + (0, 0, 30) + anglestoright(level.player.angles) * 50);
  }

  self _meth_82B1(lib_0A1E::func_2342(), 0);
  if(isDefined(self.var_71C8)) {
    self[[self.var_71C8]]();
  }

  self giverankxp_regularmp("torso_upper", var_04 * 2400);
  level.player _meth_8244("damage_heavy");
  earthquake(0.5, 1, level.player.origin, 100);
  level.player scripts\engine\utility::delaycall(0.25, ::stoprumble, "damage_heavy");
  wait(1);
  lib_0C60::func_4E36();
}

func_3368() {
  if(!isDefined(self.var_4D5D)) {
    return;
  }

  foreach(var_05, var_01 in self.var_4D5D) {
    if(var_05 == "head" && self _meth_850C(var_05) <= 0) {
      continue;
    }

    foreach(var_04, var_03 in self.var_4D5D[var_05].partnerheli) {
      if(!isDefined(self)) {
        return;
      }

      self setscriptablepartstate(var_05, "dmg_" + var_04 + "_both", 1);
    }
  }
}

func_3361(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_A709)) {
    return;
  }

  self.var_A709 = 1;
  var_04 = undefined;
  level.player _meth_8244("damage_heavy");
  earthquake(0.5, 1, level.player.origin, 100);
  thread scripts\sp\art::func_583F(0, 1, 0.02, 203, 211, 3, 0.05);
  if(self.asmname == "c6_worker") {
    var_04 = "pain_shock";
  } else if(self.a.pose == "stand") {
    var_04 = "shock_loop_stand";
  } else if(self.a.pose == "crouch") {
    var_04 = "shock_loop_crouch";
  }

  thread func_3368();
  playFXOnTag(level.var_7649["c6_death"], self, "j_spine4");
  if(soundexists("emp_shock_short")) {
    playworldsound("shock_knife_blast", level.player getEye());
  }

  thread lib_0C66::func_FE4E(self.asmname, var_04, 0.02, 1, 0, 1);
  wait(0.5);
  self notify(var_04 + "_finished");
  self stopsounds();
  level.player stoprumble("damage_heavy");
  thread scripts\sp\art::func_583D(0.5);
  scripts\anim\shared::func_5D1A();
  if(isDefined(self.var_71C8)) {
    self[[self.var_71C8]]();
  }

  self giverankxp_regularmp("torso_upper", vectornormalize(self.origin - level.player.origin + (0, 0, 10)) * 2200);
  wait(0.1);
  var_05 = lib_0A1E::asm_getbodyknob();
  self clearanim(var_05, 0.05);
  lib_0C60::func_4E36();
}