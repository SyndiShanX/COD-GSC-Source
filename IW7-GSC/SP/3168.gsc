/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3168.gsc
************************/

func_4E4A() {
  if(!isDefined(self.var_1198.var_AB58)) {
    return;
  }

  var_00 = self.var_1198.var_AB58;
  var_00 delete();
  self.var_1198.var_AB58 = undefined;
  scripts\sp\utility::func_72EC(self.primaryweapon, "primary");
}

func_CF0E(param_00, param_01, param_02, param_03) {
  func_11043();
  func_E166(self.origin);
  level.var_C222--;
  level.var_C221--;
  func_4E4A();
  if(self.a.nodeath) {
    func_4E36();
    return;
  } else if(isDefined(self.var_DC1A) || self.missile_createattractororigin) {
    if(isDefined(self.var_57E1) && self.var_57E1) {
      self animmode("noclip");
    } else {
      self animmode("gravity");
    }

    func_58CB();
    if(!isDefined(self)) {
      return;
    }
  }

  var_04 = scripts\anim\pain::func_1390C();
  if(func_10024(var_04)) {
    func_8E17();
  }

  if(func_10021(var_04)) {
    func_8C99();
  }

  if(!isDefined(self.var_10265)) {
    self clearanim(lib_0A1E::func_2342(), 0.3);
  }

  playdeathsound(var_04);
  if(isDefined(self.asm.var_4E40)) {
    self[[self.asm.var_4E40]]();
    if(!isDefined(self.var_4E46)) {
      func_4E36();
      return;
    }
  }

  if(isDefined(self.var_4E46)) {
    var_05 = self[[self.var_4E46]]();
    if(!isDefined(var_05)) {
      var_05 = 1;
    }

    if(var_05) {
      func_4E36();
      return;
    }
  }

  self endon("entitydeleted");
  if(lib_0A1E::func_FFBD() && self.unittype != "c12") {
    if(self.unittype == "c6" || self.unittype == "c8") {
      thread atomizerrobotbodyfx();
      return;
    }

    thread func_2453();
  }

  if(func_1001C() && !self _meth_81B7()) {
    if(self.unittype == "c6") {
      anim thread[[self.var_3135.var_71CC]](self, 150, 120, 1);
      return;
    }

    scripts\anim\shared::func_5D1A();
    func_58B8();
    self hide();
    wait(0.1);
    if(isDefined(self)) {
      func_4E36();
      self delete();
    }

    return;
  }

  if(isDefined(self.var_4E30) && !isDefined(self.var_4E2A)) {
    self.var_4E2A = hide();
  }

  var_06 = undefined;
  if(!isDefined(self.var_10265)) {
    if(isDefined(self.var_4E2A)) {
      var_06 = self.var_4E2A;
    } else {
      var_07 = level.asm[param_00].states[param_01].var_71A5;
      var_06 = self[[var_07]](param_00, param_01, param_03);
    }

    if(!animhasnotetrack(var_06, "dropgun") && !animhasnotetrack(var_06, "fire_spray")) {
      scripts\anim\shared::func_5D1A();
    }

    if(animhasnotetrack(var_06, "dropgun")) {
      self.var_1198.var_26C6 = 1;
    }

    func_C703();
    self _meth_82E4(param_01, var_06, lib_0A1E::asm_getbodyknob(), 1, 0.1);
    lib_0A1E::func_2369(param_00, param_01, var_06);
  }

  if(isDefined(self.var_10265)) {
    if(!isDefined(self.noragdoll)) {
      if(isDefined(self.var_71C8)) {
        self[[self.var_71C8]]();
      }

      if(!isDefined(self)) {
        return;
      }

      self giverankxp();
    }

    wait(0.05);
    self animmode("gravity");
  } else if(isDefined(self.ragdolltime)) {
    thread func_136DF(self.ragdolltime);
  } else if(!animhasnotetrack(var_06, "start_ragdoll")) {
    if(self.var_DE == "MOD_MELEE") {
      var_08 = 0.7;
    } else {
      var_08 = 0.35;
    }

    thread func_136DF(getanimlength(var_06) * var_08);
  }

  if(isDefined(self.var_4E2C)) {
    self animmode(self.var_4E2C);
  }

  if(!isDefined(self.var_10265)) {
    thread playdeathfx();
  }

  self endon("terminate_death_thread");
  if(isDefined(self.var_10265)) {
    wait(0.05);
  } else {
    lib_0A1E::func_231F(param_00, param_01, ::func_4E51);
  }

  if(!isDefined(self)) {
    return;
  }

  scripts\anim\shared::func_5D1A();
  self notify("endPlayDeathAnim");
  if(isDefined(self.var_DC1A) || self.missile_createattractororigin) {
    wait(0.5);
    if(!isDefined(self)) {
      return;
    }

    self _meth_82B1(lib_0A1E::func_2342(), 0);
  }

  func_4E36();
}

func_4E51(param_00) {
  if(self.unittype == "c8") {
    anim thread func_34F8(self, param_00);
    return;
  }

  scripts\sp\anim::func_C0DB(param_00);
}

func_34F8(param_00, param_01) {
  var_02 = getsubstr(param_01, 0, 3);
  if(var_02 == "vo_") {
    var_03 = getsubstr(param_01, 3);
    param_00 getyawtoenemy(var_03);
    return;
  }

  if(var_03 != "ps_") {
    return;
  }

  var_03 = getsubstr(var_02, 3);
  if(!isDefined(param_00.var_4E67)) {
    param_00.var_4E67 = spawn("script_origin", param_00.origin);
    param_00.var_4E67 linkto(param_00, "");
  }

  var_04 = param_00.var_4E67;
  var_04 notify("stop_C8DeathSound");
  var_04 endon("stop_C8DeathSound");
  var_04 playSound(var_03);
  var_05 = lookupsoundlength(var_03);
  wait(var_05 * 0.001 + 0.1);
  var_04 delete();
}

func_D46A(param_00, param_01, param_02, param_03) {
  if((scripts\engine\utility::istrue(self.var_E2 == "iw7_knife_upgrade1") || scripts\engine\utility::wasdamagedbyoffhandshield() || scripts\sp\utility::func_9DB4("iw7_sonic")) && isDefined(self.var_4F)) {
    var_04 = vectortoyaw(self.var_4F.origin - self.origin);
    if(self.var_E3 > 135 || self.var_E3 <= -135) {
      self orientmode("face angle", var_04);
    } else if(self.var_E3 > 45 && self.var_E3 <= 135) {
      self orientmode("face angle", var_04 + 90);
    } else if(self.var_E3 > -45 && self.var_E3 <= 45) {
      self orientmode("face angle", var_04 - 180);
    } else {
      self orientmode("face angle", var_04 - 90);
    }
  }

  func_CF0E(param_00, param_01, param_02, param_03);
}

func_CF11(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_2029)) {
    self.var_2029 delete();
  }

  self.missile_createattractororigin = 1;
  self.var_57E1 = 1;
  self.var_10265 = 1;
  func_CF0E(param_00, param_01, param_02, param_03);
}

func_CF0F(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_B647)) {
    var_04 = param_03;
    if(!isDefined(var_04)) {
      var_04 = 10;
    }

    lib_0A1E::func_2323(param_00, self.var_B647, var_04);
  }

  scripts\anim\shared::func_5D1A();
  if(isDefined(self.var_71C8)) {
    self[[self.var_71C8]]();
  }

  if(!isDefined(self)) {
    return;
  }

  self giverankxp();
  wait(0.1);
  func_4E36();
}

func_4E36() {
  if(isDefined(self)) {
    if(self.unittype == "c6") {} else if(self.unittype == "c8") {
      func_34B9();
    }
  }

  self notify("terminate_ai_threads");
  var_00 = 3;
  while(isDefined(self) && self.script != "death" && var_00 > 0) {
    var_00--;
    wait(0.05);
  }

  self notify("killanimscript");
}

func_3EF6(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "standing");
}

func_10052(param_00, param_01, param_02, param_03) {
  return lib_0A1E::func_9F4C() || isDefined(self.var_FE4A);
}

func_10045(param_00, param_01, param_02, param_03) {
  if(scripts\anim\pain::func_1390C()) {
    return 1;
  }

  return 0;
}

func_10059(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.var_E2) || self.var_E2 == "none") {
    return 0;
  }

  if(isDefined(self.a.var_58DA)) {
    return 0;
  }

  if(self.a.pose == "prone" || isDefined(self.a.onback)) {
    return 0;
  }

  if(self.var_DE == "MOD_MELEE") {
    return 0;
  }

  if(abs(self.var_E3) < 45) {
    return 0;
  }

  if(self.var_E1 > 500) {
    return 1;
  }

  if(self.a.movement == "run" && !func_9D59(self.var_4F, 275)) {
    if(randomint(100) < 65) {
      return 0;
    }
  }

  if(scripts\anim\utility_common::issniperrifle(self.var_E2) && self.maxhealth < self.var_E1) {
    return 1;
  }

  if(scripts\anim\utility_common::isshotgun(self.var_E2) && func_9D59(self.var_4F, 512)) {
    return 1;
  }

  if(getweaponbasename(self.var_E2) == "iw7_devastator" && scripts\sp\utility::func_9FFE(self.var_E2)) {
    return 1;
  }

  return 0;
}

func_11043() {
  self _meth_83AC("voice_bchatter_1_3d");
  scripts\sp\anim::func_55C7(0);
  self stoploopsound();
}

func_33AA() {
  if(!isDefined(self)) {
    return;
  }

  self.var_3135.var_55CE = 1;
  if(isDefined(self.asm.var_2F3B)) {
    return;
  }

  self.asm.var_2F3B = 1;
  self.var_EF39 = 1;
  if(!isDefined(self.var_1198.scriptableparts)) {
    return;
  }

  foreach(var_03, var_01 in self.var_1198.scriptableparts) {
    var_02 = var_01.state;
    if(var_02 == "normal") {
      continue;
    }

    if(issubstr(var_02, "_both")) {
      var_02 = "dmg_both";
    }

    self setscriptablepartstate(var_03, var_02 + "_stopfx");
  }

  self setscriptablepartstate("torso_overload_fx", "normal");
}

func_34B9() {
  self.var_3135.var_55CE = 1;
  if(isDefined(self.asm.var_2F3B)) {
    return;
  }

  self.asm.var_2F3B = 1;
  self.var_EF39 = 1;
  if(!isDefined(self.var_1198.scriptableparts)) {
    return;
  }

  foreach(var_02, var_01 in self.var_1198.scriptableparts) {
    if(issubstr(var_02, "dmg_fx")) {
      self setscriptablepartstate(var_02, "stopfx");
    }
  }

  self setscriptablepartstate("torso_overload_fx", "normal");
}

func_3EE2(param_00, param_01, param_02) {
  if(abs(self.var_E3) < 45) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "running_forward_8");
  }

  if(abs(self.var_E3) > 135) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "running_forward_2");
  }

  if(scripts\engine\utility::cointoss()) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "running_forward_4");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "running_forward_6");
}

func_3ECA(param_00, param_01, param_02) {
  if(scripts\engine\utility::damagelocationisany("head", "neck")) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "head");
  }

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck")) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "torso");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "default");
}

func_3EC6(param_00, param_01, param_02) {
  switch (param_02) {
    case "cover_stand":
      return scripts\asm\asm::asm_lookupanimfromalias(param_01, "stand");

    case "cover_exposed":
      return scripts\asm\asm::asm_lookupanimfromalias(param_01, "exposed");

    case "cover_crouch":
      if(scripts\engine\utility::damagelocationisany("head", "neck") && self.var_E3 > 135 || self.var_E3 <= -45) {
        return scripts\asm\asm::asm_lookupanimfromalias(param_01, "crouch_head");
      }

      if(self.var_E3 > -45 && self.var_E3 <= 45) {
        return scripts\asm\asm::asm_lookupanimfromalias(param_01, "crouch_back");
      }
      return scripts\asm\asm::asm_lookupanimfromalias(param_01, "crouch_default");

    case "cover_right":
      if(self.a.pose == "stand") {
        return scripts\asm\asm::asm_lookupanimfromalias(param_01, "right_stand");
      } else {
        if(scripts\engine\utility::damagelocationisany("head", "neck")) {
          return scripts\asm\asm::asm_lookupanimfromalias(param_01, "right_crouch_head");
        }

        return scripts\asm\asm::asm_lookupanimfromalias(param_01, "right_crouch_default");
      }

      break;

    case "cover_left":
      if(self.a.pose == "stand") {
        return scripts\asm\asm::asm_lookupanimfromalias(param_01, "left_stand");
      } else {
        return scripts\asm\asm::asm_lookupanimfromalias(param_01, "left_crouch");
      }

      break;

    case "cover_3d":
      return scripts\asm\asm::asm_lookupanimfromalias(param_01, "3d");
  }
}

func_3F00(param_00, param_01, param_02) {
  if(scripts\anim\utility_common::isusingsidearm()) {
    return func_3F02(param_00, param_01, param_02);
  }

  if(isDefined(self.var_4F) && self givenextgun(self.var_4F)) {
    return func_3F01(param_00, param_01, param_02);
  }

  var_03 = [];
  if(scripts\engine\utility::damagelocationisany("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_lower", "right_leg_lower")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "lower_body");
  } else if(scripts\engine\utility::damagelocationisany("head", "helmet")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "head");
  } else if(scripts\engine\utility::damagelocationisany("neck")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "neck");
  } else if(scripts\engine\utility::damagelocationisany("torso_upper", "left_arm_upper")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "left_shoulder");
  }

  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "torso_upper");
  }

  if(self.var_E3 > 135 || self.var_E3 <= -135) {
    if(scripts\engine\utility::damagelocationisany("neck", "head", "helmet")) {
      var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "torso_2");
    }

    if(scripts\engine\utility::damagelocationisany("torso_upper")) {
      var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "torso_2");
    }
  } else if(self.var_E3 > -45 && self.var_E3 <= 45) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "back");
  }

  var_04 = var_03.size > 0;
  if(!var_04 || randomint(100) < 15) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "default");
  }

  if(randomint(100) < 10 && func_6DB2()) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "default_firing");
  }

  return var_03[randomint(var_03.size)];
}

func_3ED8(param_00, param_01, param_02) {
  if(self.var_E3 > 135 || self.var_E3 <= -135) {
    var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_01, "explosive_b");
  } else if(self.var_E3 > 45 && self.var_E3 <= 135) {
    var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_02, "explosive_l");
  } else if(self.var_E3 > -45 && self.var_E3 <= 45) {
    var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_02, "explosive_f");
  } else {
    var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_02, "explosive_r");
  }

  if(getdvar("scr_expDeathMayMoveCheck", "on") == "on") {
    var_04 = 1;
    var_05 = getnotetracktimes(var_03, "start_ragdoll");
    if(var_05.size > 0) {
      var_04 = var_05[0];
    }

    var_06 = getmovedelta(var_03, 0, var_04);
    var_07 = self gettweakablevalue(var_06);
    var_08 = 0;
    if(scripts\engine\utility::actor_is3d()) {
      var_08 = navtrace3d(self.origin, var_07, 0);
    } else {
      var_08 = self maymovefrompointtopoint(self.origin, var_07, 0, 1);
    }

    if(!var_08) {
      var_03 = scripts\asm\asm::asm_lookupanimfromalias(param_01, "default");
    }
  }

  self.var_4E2C = "nogravity";
  return var_03;
}

func_3F02(param_00, param_01, param_02) {
  if(abs(self.var_E3) < 50) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "pistol_2");
  }

  var_03 = [];
  if(abs(self.var_E3) < 110) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "pistol_2");
  }

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "pistol_torso_upper");
  }

  if(!scripts\engine\utility::damagelocationisany("head", "neck", "helmet", "left_foot", "right_foot", "left_hand", "right_hand", "gun") && randomint(2) == 0) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "pistol_upper_body");
  }

  if(var_03.size == 0 || scripts\engine\utility::damagelocationisany("torso_lower", "torso_upper", "neck", "head", "helmet", "right_arm_upper", "left_arm_upper")) {
    var_03[var_03.size] = ::scripts\asm\asm::asm_lookupanimfromalias(param_01, "pistol_default");
  }

  return var_03[randomint(var_03.size)];
}

func_3F01(param_00, param_01, param_02) {
  return scripts\asm\asm::asm_lookupanimfromalias(param_01, "default");
}

func_6DB2() {
  return 0;
}

playdeathfx() {
  self endon("killanimscript");
  if(self.getcsplinepointtargetname != "none") {
    return;
  }

  wait(2);
  play_blood_pool();
}

play_blood_pool(param_00, param_01) {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_10264)) {
    return;
  }

  var_02 = self gettagorigin("j_SpineUpper");
  var_03 = self gettagangles("j_SpineUpper");
  var_04 = anglesToForward(var_03);
  var_05 = anglestoup(var_03);
  var_06 = anglestoright(var_03);
  var_02 = var_02 + var_04 * -8.5 + var_05 * 5 + var_06 * 0;
  var_07 = bulletTrace(var_02 + (0, 0, 30), var_02 - (0, 0, 100), 0, undefined);
  if(var_07["normal"][2] > 0.9) {
    playFX(level._effect["deathfx_bloodpool_generic"], var_02);
  }
}

func_136DF(param_00) {
  wait(param_00);
  if(isDefined(self)) {
    scripts\anim\shared::func_5D1A();
  }

  if(isDefined(self.var_71C8)) {
    self[[self.var_71C8]]();
  }

  if(isDefined(self) && !isDefined(self.noragdoll)) {
    self giverankxp();
  }
}

func_58CB() {
  scripts\anim\shared::func_5D1A();
  self.var_10265 = 1;
  if(isDefined(self.var_71C8)) {
    self[[self.var_71C8]]();
  }

  if(!isDefined(self)) {
    return;
  }

  var_00 = 10;
  var_01 = scripts\engine\utility::getdamagetype(self.var_DE);
  if(isDefined(self.var_4F) && self.var_4F == level.player && var_01 == "melee") {
    var_00 = 5;
  }

  var_02 = self.var_E1;
  if(var_01 == "bullet") {
    var_02 = max(var_02, 300);
  }

  var_03 = var_00 * var_02;
  var_04 = max(0.3, self.var_DC[2]);
  var_05 = (self.var_DC[0], self.var_DC[1], var_04);
  if(isDefined(self.var_DC15)) {
    var_05 = var_05 * self.var_DC15;
  } else {
    var_05 = var_05 * var_03;
  }

  if(self.missile_createattractororigin) {
    var_05 = var_05 + self.weaponmaxammo * 20 * 10;
  }

  if(isDefined(self.var_DC1D)) {
    var_05 = var_05 + self.var_DC1D * 10;
  }

  var_06 = self.var_DD;
  if(isDefined(self.var_DC14) && var_06 == "none") {
    var_06 = self.var_DC14;
  }

  if(isDefined(self.var_57E1) && self.var_57E1 == 1) {
    var_05 = vectornormalize((self.var_DC[0], self.var_DC[1], self.var_DC[2]));
    var_05 = var_05 * 1500;
  }

  self giverankxp_regularmp(var_06, var_05);
  wait(0.05);
}

func_10025(param_00) {
  if(isDefined(self.var_C065) && self.var_C065) {
    return 0;
  }

  if(isDefined(self.sethalfresparticles) && isDefined(self.sethalfresparticles.team) && isDefined(self.team) && self.sethalfresparticles.team == self.team) {
    return 0;
  }

  if(isDefined(self.var_8E1E) && !param_00) {
    return 0;
  }

  if(isDefined(self.var_C554) && self.var_C554) {
    return 0;
  }

  if(isDefined(self.var_B14F) && self.var_B14F) {
    return 0;
  }

  if(isDefined(self.var_DD) && self.var_DD == "helmet") {
    return 1;
  }

  if(param_00 && randomint(2) == 0) {
    return 1;
  }

  return 0;
}

func_10024(param_00) {
  if(isDefined(self.var_C065) && self.var_C065) {
    return 0;
  }

  if(self.unittype != "soldier") {
    return 0;
  }

  if(self.var_DE == "MOD_MELEE" && randomint(3) < 2) {
    return 0;
  }

  if(self.var_DD == "helmet" || self.var_DD == "head") {
    return 1;
  }

  if(param_00 && randomint(3) == 0) {
    return 1;
  }

  return 0;
}

func_8E17() {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.hatmodel)) {
    return;
  }

  if(isDefined(self.var_5952) && self.var_5952) {
    return;
  }

  var_00 = self gettagorigin("j_head");
  if(isDefined(self.var_8E1A)) {
    var_01 = anglesToForward(self gettagangles("j_head"));
    playFX(self.var_8E1A, var_00, var_01);
  }

  playworldsound("bullet_small_flesh_helmet_npc", var_00);
  if(isDefined(self.var_8E1E)) {
    self.var_8E1E = undefined;
    var_02 = self _meth_850C("helmet", "helmet");
    if(var_02 > 0) {
      self _meth_850B(var_02, "helmet", "helmet");
    }
  }

  self detach(self.hatmodel, "");
  self.hatmodel = undefined;
  if(isalive(self) && func_1005A()) {
    playFXOnTag(level.var_7649["helmet_break_suffocate"], self, "j_head");
    if(self.asmname != "zero_gravity_space" && self.asmname != "zero_gravity") {
      self.var_4E30 = 1;
    }

    self _meth_81D0();
  }
}

hide() {
  var_00 = undefined;
  if(randomint(11) >= 1) {
    return var_00;
  }

  if(self.a.pose == "stand") {
    var_01 = [ % hm_grnd_red_exposed_death_neck_falls_8_ar, % hm_grnd_red_exposed_death_neck_falls_4_ar];
    var_00 = scripts\engine\utility::random(var_01);
  } else if(self.a.pose == "crouch") {
    var_00 = % cornercrr_alert_death_neck;
  }

  return var_00;
}

func_1005A() {
  if(scripts\engine\utility::istrue(self.var_C015)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.var_4E52)) {
    return 1;
  }

  if(scripts\sp\utility::func_ABD9()) {
    return 0;
  }

  return 1;
}

func_10021(param_00) {
  if(self.unittype != "soldier") {
    return 0;
  }

  if(isDefined(self.var_72C9)) {
    return 1;
  }

  if(self.var_DE == "MOD_MELEE") {
    return 0;
  }

  if(self.var_E2 == "none") {
    return 0;
  }

  if(randomint(3) == 0) {
    if(param_00) {
      return 1;
    }

    if(scripts\anim\utility::func_9DDB(self.var_E2) && self.var_DD == "helmet" || self.var_DD == "head") {
      return 1;
    }
  }

  return 0;
}

func_8C99() {
  if(!isDefined(self.headmodel)) {
    return;
  }

  var_00 = self gettagorigin("j_head");
  var_01 = anglesToForward(self gettagangles("j_head"));
  playFXOnTag(level.var_7649["human_gib_head"], self, "j_head");
  self detach(self.headmodel, "");
  self.headmodel = undefined;
}

func_4A7E(param_00, param_01) {
  return param_00[0] * param_01[1] - param_01[0] * param_00[1];
}

func_B60C(param_00, param_01) {
  var_02 = vectordot(param_01, param_00);
  var_03 = cos(60);
  if(squared(var_02) < squared(var_03)) {
    if(func_4A7E(param_00, param_01) > 0) {
      return 1;
    }

    return 3;
  }

  if(var_02 < 0) {
    return 0;
  }

  return 2;
}

func_C703() {
  if(scripts\sp\utility::func_9DB4("iw7_knife_upgrade1") || scripts\sp\utility::func_9DB4("iw7_sonic")) {
    return;
  }

  if(self.var_DE == "MOD_MELEE" && isDefined(self.var_4F) && !scripts\engine\utility::wasdamagedbyoffhandshield() && !scripts\sp\utility::func_9DB4("iw7_sonic")) {
    if(scripts\engine\utility::actor_is3d()) {
      var_00 = self.var_4F.origin - self.origin;
      var_01 = generateaxisanglesfromforwardvector(var_00, self.angles);
      self orientmode("face angle 3d", var_01);
      return;
    }

    var_02 = self.origin - self.var_4F.origin;
    var_03 = anglesToForward(self.angles);
    var_04 = vectornormalize((var_02[0], var_02[1], 0));
    var_05 = vectornormalize((var_03[0], var_03[1], 0));
    var_06 = func_B60C(var_05, var_04);
    var_07 = var_06 * 90;
    var_08 = (-1 * var_04[0], -1 * var_04[1], 0);
    var_09 = rotatevector(var_08, (0, var_07, 0));
    var_0A = vectortoyaw(var_09);
    self orientmode("face angle", var_0A);
  }
}

playdeathsound(param_00) {
  if(scripts\engine\utility::damagelocationisany("head", "helmet") && !scripts\engine\utility::wasdamagedbyoffhandshield() && !scripts\sp\utility::func_9DB4("iw7_sonic")) {
    return;
  }

  if(isDefined(self.var_EF) && self.var_EF) {
    return;
  }

  if(param_00) {
    scripts\anim\face::saygenericdialogue("explodeath");
    return;
  }

  scripts\anim\face::saygenericdialogue("death");
}

func_E166(param_00) {
  for(var_01 = 0; var_01 < level.var_10AE5.size; var_01++) {
    level.var_10AE5[var_01] func_41DC(param_00);
  }
}

func_41DC(param_00) {
  if(!isDefined(self.var_101E5)) {
    return;
  }

  if(distance(param_00, self.var_101E5) < 80) {
    self.var_101E5 = undefined;
    self.var_101E8 = gettime();
  }
}

func_9D59(param_00, param_01) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(distance(self.origin, param_00.origin) > param_01) {
    return 0;
  }

  return 1;
}

func_9F6D(param_00, param_01, param_02, param_03) {
  if(lib_0A1E::func_9F4C()) {
    return 1;
  }

  return 0;
}

func_3EFD(param_00, param_01, param_02) {
  if(lib_0A1E::func_9F4C()) {
    return scripts\asm\asm::asm_lookupanimfromalias(param_01, "shock_death");
  }

  return scripts\asm\asm::asm_lookupanimfromalias("death_generic", "default");
}

func_1001C() {
  if(isDefined(self.var_C061)) {
    return 0;
  }

  if(self.unittype != "soldier" && self.unittype != "c6" && self.unittype != "civilian") {
    return 0;
  }

  if(isDefined(self.var_FE4A)) {
    return 0;
  }

  if(isDefined(self.var_DE) && self.var_DE == "MOD_MELEE") {
    return 0;
  }

  if(isDefined(self.var_DE) && isexplosivedamagemod(self.var_DE)) {
    if(self.var_E1 > 120) {
      return 1;
    }
  }

  if(scripts\sp\utility::func_9DB4("iw7_penetrationrail")) {
    return 1;
  }

  if(scripts\sp\utility::func_9DB4("iw7_ake_gold") && self.var_DD == "head" || self.var_DD == "helmet") {
    return 1;
  }

  if(scripts\sp\utility::func_9DB4("iw7_devastator") && scripts\sp\utility::func_9FFE(self.var_E2) && self.var_E1 > 120) {
    return 1;
  }

  return weaponisbeam(self.var_E2);
}

func_58B9(param_00) {
  var_01 = param_00 gettagorigin("j_spine4");
  playFX(level.var_7649["human_gib_fullbody"], var_01, (1, 0, 0));
  var_02 = spawn("script_origin", var_01);
  var_02 playSound("gib_fullbody", "sounddone");
  var_02 waittill("sounddone");
  wait(0.1);
  var_02 delete();
}

func_58B8() {
  if(isDefined(self.scragentsetscripted)) {
    level thread[[self.scragentsetscripted]](self);
    return;
  }

  level thread func_58B9(self);
}

func_10051(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_E2) && weapontype(self.var_E2) == "shield" || self.var_E2 == "iw7_mauler_c8hack" || self.var_E2 == "iw7_c6hack_melee" || self.var_E2 == "iw7_c6worker_fists") {
    return 1;
  }

  if(isDefined(self.sethalfresparticles) && isDefined(self.sethalfresparticles.unittype) && self.sethalfresparticles.unittype == "c8" && isDefined(self.var_DE) && self.var_DE == "MOD_MELEE") {
    return 1;
  }

  return 0;
}

func_5AA8(param_00, param_01, param_02, param_03) {
  func_11043();
  scripts\anim\shared::func_5D1A();
  var_04 = vectornormalize(self.origin - level.player.origin + (0, 0, 30));
  if(self.var_E2 == "iw7_c6hack_melee" || self.var_E2 == "iw7_c6worker_fists") {
    var_04 = vectornormalize(self.origin - level.player.origin + (0, 0, 30) + anglestoright(level.player.angles) * 50);
  }

  self _meth_82B1(lib_0A1E::func_2342(), 0);
  if(isDefined(self.var_71C8)) {
    self[[self.var_71C8]]();
  }

  if(!isDefined(self)) {
    return;
  }

  self giverankxp_regularmp("torso_upper", var_04 * 2400);
  if(isDefined(self.unittype) && self.unittype == "c6") {
    self playSound("shield_death_c6_1");
  }

  level.player _meth_8244("damage_heavy");
  earthquake(0.5, 1, level.player.origin, 100);
  level.player scripts\engine\utility::delaycall(0.25, ::stoprumble, "damage_heavy");
  wait(1);
  func_4E36();
}

func_FFF0(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_E2) && self.var_E2 == "iw7_knife_upgrade1") {
    return 1;
  }

  return 0;
}

func_58E4(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_A709)) {
    return;
  }

  self.var_A709 = 1;
  var_04 = undefined;
  level.player _meth_8244("damage_heavy");
  earthquake(0.5, 1, level.player.origin, 100);
  thread scripts\sp\art::func_583F(0, 1, 0.02, 203, 211, 3, 0.05);
  if(self.a.pose == "stand") {
    var_04 = "shock_loop_stand";
  } else if(self.a.pose == "crouch") {
    var_04 = "shock_loop_crouch";
  }

  playFXOnTag(level.var_7649["c6_death"], self, "j_spine4");
  if(soundexists("shock_knife_blast")) {
    playworldsound("shock_knife_blast", level.player getEye());
  }

  thread lib_0C66::func_FE4E(param_00, var_04, 0.02, 1, 0, 1);
  wait(0.5);
  self notify(var_04 + "_finished");
  self stopsounds();
  level.player stoprumble("damage_heavy");
  thread scripts\sp\art::func_583D(0.5);
  func_CF0E(param_00, "death_shocked");
}

playatomizerfx(param_00) {
  playFX(level.var_7649["atomize_body"], self gettagorigin(param_00), anglesToForward(self gettagangles(param_00)));
}

func_2453() {
  self.var_10264 = 1;
  self playSound("bullet_atomizer_impact_npc");
  var_00[0][0] = "j_spineupper";
  var_00[0][1] = "j_spinelower";
  var_00[0][2] = "j_head";
  var_00[0][3] = "j_shoulder_ri";
  var_00[0][4] = "j_shoulder_le";
  var_00[1][0] = "j_knee_ri";
  var_00[1][1] = "j_knee_le";
  var_00[1][2] = "j_elbow_ri";
  var_00[1][3] = "j_elbow_le";
  var_00[1][4] = "j_hip_ri";
  var_00[1][5] = "j_hip_le";
  var_00[2][0] = "j_ankle_le";
  var_00[2][1] = "j_ankle_ri";
  var_00[2][2] = "j_wrist_le";
  var_00[2][3] = "j_wrist_ri";
  foreach(var_02 in var_00) {
    if(!isDefined(self)) {
      return;
    }

    foreach(var_04 in var_02) {
      playatomizerfx(var_04);
    }

    wait(0.05);
  }

  self hide();
  self.noragdoll = 1;
  scripts\anim\shared::func_5D1A();
}

atomizercheckpartdismembered(param_00) {
  if(!isDefined(self.var_1198)) {
    return 0;
  }

  if(!isDefined(self.var_1198.scriptableparts)) {
    return 0;
  }

  if(!isDefined(self.var_1198.scriptableparts[param_00])) {
    return 0;
  }

  return self.var_1198.scriptableparts[param_00].state == "dismember";
}

atomizerrobotbodyfx() {
  self playSound("bullet_atomizer_impact_npc");
  playatomizerfx("j_spinelower");
  playatomizerfx("j_shoulder_ri");
  playatomizerfx("j_shoulder_le");
  if(!scripts\asm\asm_bb::ispartdismembered("head")) {
    playatomizerfx("j_head");
  }

  if(!scripts\asm\asm_bb::ispartdismembered("right_leg")) {
    playatomizerfx("j_knee_ri");
  }

  if(!scripts\asm\asm_bb::ispartdismembered("left_leg")) {
    playatomizerfx("j_knee_le");
  }

  if(!scripts\asm\asm_bb::ispartdismembered("right_arm")) {
    if(scripts\engine\utility::cointoss()) {
      playatomizerfx("j_elbow_ri");
    } else {
      playatomizerfx("j_wrist_ri");
    }
  }

  if(!scripts\asm\asm_bb::ispartdismembered("left_arm") && self.unittype != "c8") {
    if(scripts\engine\utility::cointoss()) {
      playatomizerfx("j_elbow_le");
    } else {
      playatomizerfx("j_wrist_le");
    }
  }

  anim thread[[self.var_3135.var_71CC]](self);
}