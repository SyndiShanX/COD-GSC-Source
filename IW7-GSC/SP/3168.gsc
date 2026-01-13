/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3168.gsc
*********************************************/

func_4E4A() {
  if(!isDefined(self._blackboard.var_AB58)) {
    return;
  }

  var_0 = self._blackboard.var_AB58;
  var_0 delete();
  self._blackboard.var_AB58 = undefined;
  scripts\sp\utility::func_72EC(self.primaryweapon, "primary");
}

func_CF0E(var_0, var_1, var_2, var_3) {
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

  var_4 = scripts\anim\pain::func_1390C();
  if(func_10024(var_4)) {
    func_8E17();
  }

  if(func_10021(var_4)) {
    func_8C99();
  }

  if(!isDefined(self.var_10265)) {
    self clearanim(lib_0A1E::func_2342(), 0.3);
  }

  playdeathsound(var_4);
  if(isDefined(self.asm.var_4E40)) {
    self[[self.asm.var_4E40]]();
    if(!isDefined(self.var_4E46)) {
      func_4E36();
      return;
    }
  }

  if(isDefined(self.var_4E46)) {
    var_5 = self[[self.var_4E46]]();
    if(!isDefined(var_5)) {
      var_5 = 1;
    }

    if(var_5) {
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

  if(func_1001C() && !self func_81B7()) {
    if(self.unittype == "c6") {
      anim thread[[self.bt.var_71CC]](self, 150, 120, 1);
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

  var_6 = undefined;
  if(!isDefined(self.var_10265)) {
    if(isDefined(self.var_4E2A)) {
      var_6 = self.var_4E2A;
    } else {
      var_7 = level.asm[var_0].states[var_1].var_71A5;
      var_6 = self[[var_7]](var_0, var_1, var_3);
    }

    if(!animhasnotetrack(var_6, "dropgun") && !animhasnotetrack(var_6, "fire_spray")) {
      scripts\anim\shared::func_5D1A();
    }

    if(animhasnotetrack(var_6, "dropgun")) {
      self._blackboard.var_26C6 = 1;
    }

    func_C703();
    self func_82E4(var_1, var_6, lib_0A1E::asm_getbodyknob(), 1, 0.1);
    lib_0A1E::func_2369(var_0, var_1, var_6);
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
  } else if(!animhasnotetrack(var_6, "start_ragdoll")) {
    if(self.var_DE == "MOD_MELEE") {
      var_8 = 0.7;
    } else {
      var_8 = 0.35;
    }

    thread func_136DF(getanimlength(var_6) * var_8);
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
    lib_0A1E::func_231F(var_0, var_1, ::func_4E51);
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

    self func_82B1(lib_0A1E::func_2342(), 0);
  }

  func_4E36();
}

func_4E51(var_0) {
  if(self.unittype == "c8") {
    anim thread func_34F8(self, var_0);
    return;
  }

  scripts\sp\anim::func_C0DB(var_0);
}

func_34F8(var_0, var_1) {
  var_2 = getsubstr(var_1, 0, 3);
  if(var_2 == "vo_") {
    var_3 = getsubstr(var_1, 3);
    var_0 getyawtoenemy(var_3);
    return;
  }

  if(var_3 != "ps_") {
    return;
  }

  var_3 = getsubstr(var_2, 3);
  if(!isDefined(var_0.var_4E67)) {
    var_0.var_4E67 = spawn("script_origin", var_0.origin);
    var_0.var_4E67 linkto(var_0, "");
  }

  var_4 = var_0.var_4E67;
  var_4 notify("stop_C8DeathSound");
  var_4 endon("stop_C8DeathSound");
  var_4 playSound(var_3);
  var_5 = lookupsoundlength(var_3);
  wait(var_5 * 0.001 + 0.1);
  var_4 delete();
}

func_D46A(var_0, var_1, var_2, var_3) {
  if((scripts\engine\utility::istrue(self.var_E2 == "iw7_knife_upgrade1") || scripts\engine\utility::wasdamagedbyoffhandshield() || scripts\sp\utility::func_9DB4("iw7_sonic")) && isDefined(self.var_4F)) {
    var_4 = vectortoyaw(self.var_4F.origin - self.origin);
    if(self.var_E3 > 135 || self.var_E3 <= -135) {
      self orientmode("face angle", var_4);
    } else if(self.var_E3 > 45 && self.var_E3 <= 135) {
      self orientmode("face angle", var_4 + 90);
    } else if(self.var_E3 > -45 && self.var_E3 <= 45) {
      self orientmode("face angle", var_4 - 180);
    } else {
      self orientmode("face angle", var_4 - 90);
    }
  }

  func_CF0E(var_0, var_1, var_2, var_3);
}

func_CF11(var_0, var_1, var_2, var_3) {
  if(isDefined(self.var_2029)) {
    self.var_2029 delete();
  }

  self.missile_createattractororigin = 1;
  self.var_57E1 = 1;
  self.var_10265 = 1;
  func_CF0E(var_0, var_1, var_2, var_3);
}

func_CF0F(var_0, var_1, var_2, var_3) {
  if(isDefined(self.var_B647)) {
    var_4 = var_3;
    if(!isDefined(var_4)) {
      var_4 = 10;
    }

    lib_0A1E::func_2323(var_0, self.var_B647, var_4);
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
  var_0 = 3;
  while(isDefined(self) && self.script != "death" && var_0 > 0) {
    var_0--;
    wait(0.05);
  }

  self notify("killanimscript");
}

func_3EF6(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "standing");
}

func_10052(var_0, var_1, var_2, var_3) {
  return lib_0A1E::func_9F4C() || isDefined(self.var_FE4A);
}

func_10045(var_0, var_1, var_2, var_3) {
  if(scripts\anim\pain::func_1390C()) {
    return 1;
  }

  return 0;
}

func_10059(var_0, var_1, var_2, var_3) {
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
  self func_83AC("voice_bchatter_1_3d");
  scripts\sp\anim::func_55C7(0);
  self stoploopsound();
}

func_33AA() {
  if(!isDefined(self)) {
    return;
  }

  self.bt.var_55CE = 1;
  if(isDefined(self.asm.var_2F3B)) {
    return;
  }

  self.asm.var_2F3B = 1;
  self.var_EF39 = 1;
  if(!isDefined(self._blackboard.scriptableparts)) {
    return;
  }

  foreach(var_3, var_1 in self._blackboard.scriptableparts) {
    var_2 = var_1.state;
    if(var_2 == "normal") {
      continue;
    }

    if(issubstr(var_2, "_both")) {
      var_2 = "dmg_both";
    }

    self setscriptablepartstate(var_3, var_2 + "_stopfx");
  }

  self setscriptablepartstate("torso_overload_fx", "normal");
}

func_34B9() {
  self.bt.var_55CE = 1;
  if(isDefined(self.asm.var_2F3B)) {
    return;
  }

  self.asm.var_2F3B = 1;
  self.var_EF39 = 1;
  if(!isDefined(self._blackboard.scriptableparts)) {
    return;
  }

  foreach(var_2, var_1 in self._blackboard.scriptableparts) {
    if(issubstr(var_2, "dmg_fx")) {
      self setscriptablepartstate(var_2, "stopfx");
    }
  }

  self setscriptablepartstate("torso_overload_fx", "normal");
}

func_3EE2(var_0, var_1, var_2) {
  if(abs(self.var_E3) < 45) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "running_forward_8");
  }

  if(abs(self.var_E3) > 135) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "running_forward_2");
  }

  if(scripts\engine\utility::cointoss()) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "running_forward_4");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "running_forward_6");
}

func_3ECA(var_0, var_1, var_2) {
  if(scripts\engine\utility::damagelocationisany("head", "neck")) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "head");
  }

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck")) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
}

func_3EC6(var_0, var_1, var_2) {
  switch (var_2) {
    case "cover_stand":
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "stand");

    case "cover_exposed":
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "exposed");

    case "cover_crouch":
      if(scripts\engine\utility::damagelocationisany("head", "neck") && self.var_E3 > 135 || self.var_E3 <= -45) {
        return scripts\asm\asm::asm_lookupanimfromalias(var_1, "crouch_head");
      }

      if(self.var_E3 > -45 && self.var_E3 <= 45) {
        return scripts\asm\asm::asm_lookupanimfromalias(var_1, "crouch_back");
      }
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "crouch_default");

    case "cover_right":
      if(self.a.pose == "stand") {
        return scripts\asm\asm::asm_lookupanimfromalias(var_1, "right_stand");
      } else {
        if(scripts\engine\utility::damagelocationisany("head", "neck")) {
          return scripts\asm\asm::asm_lookupanimfromalias(var_1, "right_crouch_head");
        }

        return scripts\asm\asm::asm_lookupanimfromalias(var_1, "right_crouch_default");
      }

      break;

    case "cover_left":
      if(self.a.pose == "stand") {
        return scripts\asm\asm::asm_lookupanimfromalias(var_1, "left_stand");
      } else {
        return scripts\asm\asm::asm_lookupanimfromalias(var_1, "left_crouch");
      }

      break;

    case "cover_3d":
      return scripts\asm\asm::asm_lookupanimfromalias(var_1, "3d");
  }
}

func_3F00(var_0, var_1, var_2) {
  if(scripts\anim\utility_common::isusingsidearm()) {
    return func_3F02(var_0, var_1, var_2);
  }

  if(isDefined(self.var_4F) && self givenextgun(self.var_4F)) {
    return func_3F01(var_0, var_1, var_2);
  }

  var_3 = [];
  if(scripts\engine\utility::damagelocationisany("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_lower", "right_leg_lower")) {
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "lower_body");
  } else if(scripts\engine\utility::damagelocationisany("head", "helmet")) {
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "head");
  } else if(scripts\engine\utility::damagelocationisany("neck")) {
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "neck");
  } else if(scripts\engine\utility::damagelocationisany("torso_upper", "left_arm_upper")) {
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "left_shoulder");
  }

  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_upper");
  }

  if(self.var_E3 > 135 || self.var_E3 <= -135) {
    if(scripts\engine\utility::damagelocationisany("neck", "head", "helmet")) {
      var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_2");
    }

    if(scripts\engine\utility::damagelocationisany("torso_upper")) {
      var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "torso_2");
    }
  } else if(self.var_E3 > -45 && self.var_E3 <= 45) {
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "back");
  }

  var_4 = var_3.size > 0;
  if(!var_4 || randomint(100) < 15) {
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
  }

  if(randomint(100) < 10 && func_6DB2()) {
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default_firing");
  }

  return var_3[randomint(var_3.size)];
}

func_3ED8(var_0, var_1, var_2) {
  if(self.var_E3 > 135 || self.var_E3 <= -135) {
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "explosive_b");
  } else if(self.var_E3 > 45 && self.var_E3 <= 135) {
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_2, "explosive_l");
  } else if(self.var_E3 > -45 && self.var_E3 <= 45) {
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_2, "explosive_f");
  } else {
    var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_2, "explosive_r");
  }

  if(getdvar("scr_expDeathMayMoveCheck", "on") == "on") {
    var_4 = 1;
    var_5 = getnotetracktimes(var_3, "start_ragdoll");
    if(var_5.size > 0) {
      var_4 = var_5[0];
    }

    var_6 = getmovedelta(var_3, 0, var_4);
    var_7 = self gettweakablevalue(var_6);
    var_8 = 0;
    if(scripts\engine\utility::actor_is3d()) {
      var_8 = navtrace3d(self.origin, var_7, 0);
    } else {
      var_8 = self maymovefrompointtopoint(self.origin, var_7, 0, 1);
    }

    if(!var_8) {
      var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
    }
  }

  self.var_4E2C = "nogravity";
  return var_3;
}

func_3F02(var_0, var_1, var_2) {
  if(abs(self.var_E3) < 50) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_2");
  }

  var_3 = [];
  if(abs(self.var_E3) < 110) {
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_2");
  }

  if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_torso_upper");
  }

  if(!scripts\engine\utility::damagelocationisany("head", "neck", "helmet", "left_foot", "right_foot", "left_hand", "right_hand", "gun") && randomint(2) == 0) {
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_upper_body");
  }

  if(var_3.size == 0 || scripts\engine\utility::damagelocationisany("torso_lower", "torso_upper", "neck", "head", "helmet", "right_arm_upper", "left_arm_upper")) {
    var_3[var_3.size] = scripts\asm\asm::asm_lookupanimfromalias(var_1, "pistol_default");
  }

  return var_3[randomint(var_3.size)];
}

func_3F01(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
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

play_blood_pool(var_0, var_1) {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_10264)) {
    return;
  }

  var_2 = self gettagorigin("j_SpineUpper");
  var_3 = self gettagangles("j_SpineUpper");
  var_4 = anglesToForward(var_3);
  var_5 = anglestoup(var_3);
  var_6 = anglestoright(var_3);
  var_2 = var_2 + var_4 * -8.5 + var_5 * 5 + var_6 * 0;
  var_7 = bulletTrace(var_2 + (0, 0, 30), var_2 - (0, 0, 100), 0, undefined);
  if(var_7["normal"][2] > 0.9) {
    playFX(level._effect["deathfx_bloodpool_generic"], var_2);
  }
}

func_136DF(var_0) {
  wait(var_0);
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

  var_0 = 10;
  var_1 = scripts\engine\utility::getdamagetype(self.var_DE);
  if(isDefined(self.var_4F) && self.var_4F == level.player && var_1 == "melee") {
    var_0 = 5;
  }

  var_2 = self.var_E1;
  if(var_1 == "bullet") {
    var_2 = max(var_2, 300);
  }

  var_3 = var_0 * var_2;
  var_4 = max(0.3, self.var_DC[2]);
  var_5 = (self.var_DC[0], self.var_DC[1], var_4);
  if(isDefined(self.var_DC15)) {
    var_5 = var_5 * self.var_DC15;
  } else {
    var_5 = var_5 * var_3;
  }

  if(self.missile_createattractororigin) {
    var_5 = var_5 + self.weaponmaxammo * 20 * 10;
  }

  if(isDefined(self.var_DC1D)) {
    var_5 = var_5 + self.var_DC1D * 10;
  }

  var_6 = self.var_DD;
  if(isDefined(self.var_DC14) && var_6 == "none") {
    var_6 = self.var_DC14;
  }

  if(isDefined(self.var_57E1) && self.var_57E1 == 1) {
    var_5 = vectornormalize((self.var_DC[0], self.var_DC[1], self.var_DC[2]));
    var_5 = var_5 * 1500;
  }

  self giverankxp_regularmp(var_6, var_5);
  wait(0.05);
}

func_10025(var_0) {
  if(isDefined(self.var_C065) && self.var_C065) {
    return 0;
  }

  if(isDefined(self.sethalfresparticles) && isDefined(self.sethalfresparticles.team) && isDefined(self.team) && self.sethalfresparticles.team == self.team) {
    return 0;
  }

  if(isDefined(self.var_8E1E) && !var_0) {
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

  if(var_0 && randomint(2) == 0) {
    return 1;
  }

  return 0;
}

func_10024(var_0) {
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

  if(var_0 && randomint(3) == 0) {
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

  var_0 = self gettagorigin("j_head");
  if(isDefined(self.var_8E1A)) {
    var_1 = anglesToForward(self gettagangles("j_head"));
    playFX(self.var_8E1A, var_0, var_1);
  }

  playworldsound("bullet_small_flesh_helmet_npc", var_0);
  if(isDefined(self.var_8E1E)) {
    self.var_8E1E = undefined;
    var_2 = self func_850C("helmet", "helmet");
    if(var_2 > 0) {
      self func_850B(var_2, "helmet", "helmet");
    }
  }

  self detach(self.hatmodel, "");
  self.hatmodel = undefined;
  if(isalive(self) && func_1005A()) {
    playFXOnTag(level.var_7649["helmet_break_suffocate"], self, "j_head");
    if(self.asmname != "zero_gravity_space" && self.asmname != "zero_gravity") {
      self.var_4E30 = 1;
    }

    self func_81D0();
  }
}

hide() {
  var_0 = undefined;
  if(randomint(11) >= 1) {
    return var_0;
  }

  if(self.a.pose == "stand") {
    var_1 = [ % hm_grnd_red_exposed_death_neck_falls_8_ar, % hm_grnd_red_exposed_death_neck_falls_4_ar];
    var_0 = scripts\engine\utility::random(var_1);
  } else if(self.a.pose == "crouch") {
    var_0 = % cornercrr_alert_death_neck;
  }

  return var_0;
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

func_10021(var_0) {
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
    if(var_0) {
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

  var_0 = self gettagorigin("j_head");
  var_1 = anglesToForward(self gettagangles("j_head"));
  playFXOnTag(level.var_7649["human_gib_head"], self, "j_head");
  self detach(self.headmodel, "");
  self.headmodel = undefined;
}

func_4A7E(var_0, var_1) {
  return var_0[0] * var_1[1] - var_1[0] * var_0[1];
}

func_B60C(var_0, var_1) {
  var_2 = vectordot(var_1, var_0);
  var_3 = cos(60);
  if(squared(var_2) < squared(var_3)) {
    if(func_4A7E(var_0, var_1) > 0) {
      return 1;
    }

    return 3;
  }

  if(var_2 < 0) {
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
      var_0 = self.var_4F.origin - self.origin;
      var_1 = generateaxisanglesfromforwardvector(var_0, self.angles);
      self orientmode("face angle 3d", var_1);
      return;
    }

    var_2 = self.origin - self.var_4F.origin;
    var_3 = anglesToForward(self.angles);
    var_4 = vectornormalize((var_2[0], var_2[1], 0));
    var_5 = vectornormalize((var_3[0], var_3[1], 0));
    var_6 = func_B60C(var_5, var_4);
    var_7 = var_6 * 90;
    var_8 = (-1 * var_4[0], -1 * var_4[1], 0);
    var_9 = rotatevector(var_8, (0, var_7, 0));
    var_0A = vectortoyaw(var_9);
    self orientmode("face angle", var_0A);
  }
}

playdeathsound(var_0) {
  if(scripts\engine\utility::damagelocationisany("head", "helmet") && !scripts\engine\utility::wasdamagedbyoffhandshield() && !scripts\sp\utility::func_9DB4("iw7_sonic")) {
    return;
  }

  if(isDefined(self.var_EF) && self.var_EF) {
    return;
  }

  if(var_0) {
    scripts\anim\face::saygenericdialogue("explodeath");
    return;
  }

  scripts\anim\face::saygenericdialogue("death");
}

func_E166(var_0) {
  for(var_1 = 0; var_1 < level.var_10AE5.size; var_1++) {
    level.var_10AE5[var_1] func_41DC(var_0);
  }
}

func_41DC(var_0) {
  if(!isDefined(self.var_101E5)) {
    return;
  }

  if(distance(var_0, self.var_101E5) < 80) {
    self.var_101E5 = undefined;
    self.var_101E8 = gettime();
  }
}

func_9D59(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(distance(self.origin, var_0.origin) > var_1) {
    return 0;
  }

  return 1;
}

func_9F6D(var_0, var_1, var_2, var_3) {
  if(lib_0A1E::func_9F4C()) {
    return 1;
  }

  return 0;
}

func_3EFD(var_0, var_1, var_2) {
  if(lib_0A1E::func_9F4C()) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "shock_death");
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

func_58B9(var_0) {
  var_1 = var_0 gettagorigin("j_spine4");
  playFX(level.var_7649["human_gib_fullbody"], var_1, (1, 0, 0));
  var_2 = spawn("script_origin", var_1);
  var_2 playSound("gib_fullbody", "sounddone");
  var_2 waittill("sounddone");
  wait(0.1);
  var_2 delete();
}

func_58B8() {
  if(isDefined(self.scragentsetscripted)) {
    level thread[[self.scragentsetscripted]](self);
    return;
  }

  level thread func_58B9(self);
}

func_10051(var_0, var_1, var_2, var_3) {
  if(isDefined(self.var_E2) && weapontype(self.var_E2) == "shield" || self.var_E2 == "iw7_mauler_c8hack" || self.var_E2 == "iw7_c6hack_melee" || self.var_E2 == "iw7_c6worker_fists") {
    return 1;
  }

  if(isDefined(self.sethalfresparticles) && isDefined(self.sethalfresparticles.unittype) && self.sethalfresparticles.unittype == "c8" && isDefined(self.var_DE) && self.var_DE == "MOD_MELEE") {
    return 1;
  }

  return 0;
}

func_5AA8(var_0, var_1, var_2, var_3) {
  func_11043();
  scripts\anim\shared::func_5D1A();
  var_4 = vectornormalize(self.origin - level.player.origin + (0, 0, 30));
  if(self.var_E2 == "iw7_c6hack_melee" || self.var_E2 == "iw7_c6worker_fists") {
    var_4 = vectornormalize(self.origin - level.player.origin + (0, 0, 30) + anglestoright(level.player.angles) * 50);
  }

  self func_82B1(lib_0A1E::func_2342(), 0);
  if(isDefined(self.var_71C8)) {
    self[[self.var_71C8]]();
  }

  if(!isDefined(self)) {
    return;
  }

  self giverankxp_regularmp("torso_upper", var_4 * 2400);
  if(isDefined(self.unittype) && self.unittype == "c6") {
    self playSound("shield_death_c6_1");
  }

  level.player func_8244("damage_heavy");
  earthquake(0.5, 1, level.player.origin, 100);
  level.player scripts\engine\utility::delaycall(0.25, ::stoprumble, "damage_heavy");
  wait(1);
  func_4E36();
}

func_FFF0(var_0, var_1, var_2, var_3) {
  if(isDefined(self.var_E2) && self.var_E2 == "iw7_knife_upgrade1") {
    return 1;
  }

  return 0;
}

func_58E4(var_0, var_1, var_2, var_3) {
  if(isDefined(self.var_A709)) {
    return;
  }

  self.var_A709 = 1;
  var_4 = undefined;
  level.player func_8244("damage_heavy");
  earthquake(0.5, 1, level.player.origin, 100);
  thread scripts\sp\art::func_583F(0, 1, 0.02, 203, 211, 3, 0.05);
  if(self.a.pose == "stand") {
    var_4 = "shock_loop_stand";
  } else if(self.a.pose == "crouch") {
    var_4 = "shock_loop_crouch";
  }

  playFXOnTag(level.var_7649["c6_death"], self, "j_spine4");
  if(soundexists("shock_knife_blast")) {
    playworldsound("shock_knife_blast", level.player getEye());
  }

  thread lib_0C66::func_FE4E(var_0, var_4, 0.02, 1, 0, 1);
  wait(0.5);
  self notify(var_4 + "_finished");
  self stopsounds();
  level.player stoprumble("damage_heavy");
  thread scripts\sp\art::func_583D(0.5);
  func_CF0E(var_0, "death_shocked");
}

playatomizerfx(var_0) {
  playFX(level.var_7649["atomize_body"], self gettagorigin(var_0), anglesToForward(self gettagangles(var_0)));
}

func_2453() {
  self.var_10264 = 1;
  self playSound("bullet_atomizer_impact_npc");
  var_0[0][0] = "j_spineupper";
  var_0[0][1] = "j_spinelower";
  var_0[0][2] = "j_head";
  var_0[0][3] = "j_shoulder_ri";
  var_0[0][4] = "j_shoulder_le";
  var_0[1][0] = "j_knee_ri";
  var_0[1][1] = "j_knee_le";
  var_0[1][2] = "j_elbow_ri";
  var_0[1][3] = "j_elbow_le";
  var_0[1][4] = "j_hip_ri";
  var_0[1][5] = "j_hip_le";
  var_0[2][0] = "j_ankle_le";
  var_0[2][1] = "j_ankle_ri";
  var_0[2][2] = "j_wrist_le";
  var_0[2][3] = "j_wrist_ri";
  foreach(var_2 in var_0) {
    if(!isDefined(self)) {
      return;
    }

    foreach(var_4 in var_2) {
      playatomizerfx(var_4);
    }

    wait(0.05);
  }

  self hide();
  self.noragdoll = 1;
  scripts\anim\shared::func_5D1A();
}

atomizercheckpartdismembered(var_0) {
  if(!isDefined(self._blackboard)) {
    return 0;
  }

  if(!isDefined(self._blackboard.scriptableparts)) {
    return 0;
  }

  if(!isDefined(self._blackboard.scriptableparts[var_0])) {
    return 0;
  }

  return self._blackboard.scriptableparts[var_0].state == "dismember";
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

  anim thread[[self.bt.var_71CC]](self);
}