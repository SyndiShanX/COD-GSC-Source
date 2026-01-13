/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\corner.gsc
*********************************************/

func_4661(var_0, var_1) {
  self endon("killanimscript");
  self.var_1F66["exposed"]["stand"] = ::func_F5AD;
  self.var_1F66["exposed"]["crouch"] = ::func_F317;
  self.covernode = self.target_getindexoftarget;
  self.var_4664 = var_0;
  self.a.var_4667 = "unknown";
  self.a.var_1A3E = undefined;
  scripts\anim\cover_behavior::func_129B4(var_1);
  func_F30C();
  self.var_9F4D = 0;
  self.var_11AE0 = 0;
  self.var_4662 = 0;
  scripts\anim\track::func_F641(0);
  self.var_8C4B = 0;
  var_2 = spawnStruct();
  if(!self.logstring) {
    var_2.var_BD1C = ::scripts\anim\cover_behavior::func_BD1C;
  }

  var_2.var_B24A = ::func_B24A;
  var_2.openfile = ::func_4668;
  var_2.var_AB2D = ::func_10F8B;
  var_2.setnojipscore = ::func_B01C;
  var_2.var_6B9B = ::func_6B9B;
  var_2.var_92CC = ::func_92CC;
  var_2.objective_position = ::func_128AF;
  var_2.func_85BF = ::func_128B0;
  var_2.var_2B99 = ::func_2B99;
  scripts\anim\cover_behavior::main(var_2);
}

func_62F3() {
  self.var_10F8C = undefined;
  self.a.var_AAF2 = undefined;
}

func_F30C() {
  if(self.a.pose == "crouch") {
    func_F2AE("crouch");
    return;
  }

  if(self.a.pose == "stand") {
    func_F2AE("stand");
    return;
  }

  scripts\anim\utility::exitpronewrapper(1);
  self.a.pose = "crouch";
  func_F2AE("crouch");
}

func_FFD1() {
  if(!isDefined(self.isnodeoccupied)) {
    return 0;
  }

  if(!isDefined(self.var_3C5B)) {
    self.var_3C5B = gettime() + randomintrange(5000, 20000);
  }

  if(gettime() > self.var_3C5B) {
    self.var_3C5B = gettime() + randomintrange(5000, 20000);
    if(isDefined(self.var_DC5C) && self.a.pose == "stand") {
      return 0;
    }

    self.a.var_D892 = undefined;
    return 1;
  }

  return 0;
}

func_B24A() {
  var_0 = "stand";
  if(self.a.pose == "crouch") {
    var_0 = "crouch";
    if(self.covernode getrandomattachments("stand")) {
      if(!self.covernode getrandomattachments("crouch") || func_FFD1()) {
        var_0 = "stand";
      }
    }
  } else if(self.covernode getrandomattachments("crouch")) {
    if(!self.covernode getrandomattachments("stand") || func_FFD1()) {
      var_0 = "crouch";
    }
  }

  if(self.var_8C4B) {
    transitiontostance(var_0);
    return;
  }

  if(self.a.pose == var_0) {
    if(isDefined(self.var_C2) && isDefined(self.var_C2.var_8ED9) && self.var_C2.var_8ED9 == "back") {
      var_1 = scripts\anim\utility::func_1F64("alert_idle_back");
    } else {
      var_1 = scripts\anim\utility::func_1F64("alert_idle");
    }

    func_846D(var_1, 0.3, 0.4);
  } else {
    var_2 = scripts\anim\utility::func_1F64("stance_change");
    func_846D(var_2, 0.3, getanimlength(var_2));
    func_F2AE(var_0);
  }

  self.var_8C4B = 1;
}

func_D921() {
  wait(2);
  for(;;) {
    func_D922();
    wait(0.05);
  }
}

shootposwrapper_func() {
  if(!isDefined(self.var_FECF)) {
    return 0;
  }

  var_0 = self.covernode scripts\anim\utility_common::getyawtoorigin(self.var_FECF);
  if(self.a.var_4667 == "over") {
    return var_0 > self.setmatchdatadef || self.setdevdvar > var_0;
  }

  if(self.var_4664 == "up") {
    return var_0 < -50 || var_0 > 50;
  }

  if(self.var_4664 == "left") {
    if(self.a.var_4667 == "B") {
      return var_0 > self.var_1513 || var_0 < -14;
    }

    if(self.a.var_4667 == "A") {
      return var_0 < self.var_1513;
    }

    return var_0 > 50 || var_0 < -8;
  }

  if(self.a.var_4667 == "B") {
    return var_0 < -1 * self.var_1513 || var_0 > 12;
  }

  if(self.a.var_4667 == "A") {
    return var_0 > -1 * self.var_1513;
  }

  return var_0 < -50 || var_0 > 8;
}

func_7E3C(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  if(isDefined(var_1)) {
    var_3 = var_0 scripts\anim\utility_common::getyawtoorigin(var_1);
  }

  var_4 = [];
  if(isDefined(var_0) && self.a.pose == "crouch" && var_3 < self.setmatchdatadef && self.setdevdvar < var_3) {
    var_4 = var_0 func_8169();
  }

  if(self.var_4664 == "up") {
    if(scripts\engine\utility::actor_is3d()) {
      var_5 = 0;
      if(isDefined(var_1)) {
        var_6 = anglestoup(self.angles);
        var_5 = scripts\anim\combat_utility::func_8063(var_1, self getEye() + (var_6[0] * 12, var_6[1] * 12, var_6[2] * 12));
      }

      if(func_38C5(var_5, -80, 5)) {
        var_2 = func_10032();
        var_4[var_4.size] = "lean";
        var_4[var_4.size] = "lean";
      }

      if(!var_2) {
        var_4[var_4.size] = "A";
      }
    } else {
      var_4[var_4.size] = "A";
    }
  } else if(self.var_4664 == "left") {
    if(func_38C5(var_3, 0, 40)) {
      var_2 = func_10032();
      var_4[var_4.size] = "lean";
    }

    if(!var_2 && var_3 > -14) {
      if(var_3 > self.var_1513) {
        var_4[var_4.size] = "A";
      } else {
        var_4[var_4.size] = "B";
      }
    }
  } else {
    if(func_38C5(var_3, -40, 0)) {
      var_2 = func_10032();
      var_4[var_4.size] = "lean";
    }

    if(!var_2 && var_3 < 12) {
      if(var_3 > -1 * self.var_1513) {
        var_4[var_4.size] = "A";
      } else {
        var_4[var_4.size] = "B";
      }
    }
  }

  return scripts\anim\combat_utility::dospawn(var_4);
}

func_7E03() {
  var_0 = 0;
  if(scripts\anim\utility_common::cansuppressenemy()) {
    var_0 = self.covernode scripts\anim\utility_common::getyawtoorigin(scripts\anim\utility::func_7E90());
  } else if(self.var_FC && isDefined(self.var_FECF)) {
    var_0 = self.covernode scripts\anim\utility_common::getyawtoorigin(self.var_FECF);
  }

  if(self.a.var_4667 == "lean") {
    return "lean";
  }

  if(self.a.var_4667 == "over") {
    return "over";
  }

  if(self.a.var_4667 == "B") {
    if(self.var_4664 == "left") {
      if(var_0 > self.var_1513) {
        return "A";
      }
    } else if(self.var_4664 == "right") {
      if(var_0 < -1 * self.var_1513) {
        return "A";
      }
    }

    return "B";
  }

  if(self.a.var_4667 == "A") {
    if(self.var_4664 == "up") {
      return "A";
    } else if(self.var_4664 == "left") {
      if(var_0 < self.var_1513) {
        return "B";
      }
    } else if(self.var_4664 == "right") {
      if(var_0 > -1 * self.var_1513) {
        return "B";
      }
    }

    return "A";
  }
}

func_3C5D() {
  self endon("killanimscript");
  var_0 = func_7E03();
  if(var_0 == self.a.var_4667) {
    return 0;
  }

  self.var_3C60 = 1;
  self notify("done_changing_cover_pos");
  var_1 = self.a.var_4667 + "_to_" + var_0;
  var_2 = scripts\anim\utility::func_1F67(var_1);
  if(scripts\engine\utility::actor_is3d() && var_1 == "A_to_B" || var_1 == "B_to_A") {
    return 0;
  }

  var_3 = !scripts\engine\utility::actor_is3d();
  var_4 = destroy();
  if(!self maymovetopoint(var_4, var_3)) {
    return 0;
  }

  if(!self maymovefrompointtopoint(var_4, scripts\anim\utility::func_7DC6(var_2), var_3)) {
    return 0;
  }

  scripts\anim\combat_utility::func_6309();
  func_1105C(0.3);
  var_5 = self.a.pose;
  self func_82AC(scripts\anim\utility::func_1F64("straight_level"), 0, 0.2);
  self give_left_powers("changeStepOutPos", var_2, 1, 0.2, 1.2);
  func_465E(var_2);
  thread donotetrackswithendon("changeStepOutPos");
  var_6 = animhasnotetrack(var_2, "start_aim");
  if(var_6) {
    self waittillmatch("start_aim", "changeStepOutPos");
  } else {
    self waittillmatch("end", "changeStepOutPos");
  }

  thread func_10D6A(undefined, 0, 0.3);
  if(var_6) {
    self waittillmatch("end", "changeStepOutPos");
  }

  self clearanim(var_2, 0.1);
  self.a.var_4667 = var_0;
  self.var_3C60 = 0;
  self.var_4740 = gettime();
  if(self.a.pose != var_5) {
    func_F2AE(self.a.pose);
  }

  thread func_3C50(undefined, 1, 0.3);
  return 1;
}

func_38C5(var_0, var_1, var_2) {
  if(self.a.var_BEF9) {
    return 0;
  }

  return var_1 <= var_0 && var_0 <= var_2;
}

func_10032() {
  if(self.team == "allies") {
    return 1;
  }

  if(scripts\anim\utility::func_9ED4()) {
    return 1;
  }

  return 0;
}

donotetrackswithendon(var_0) {
  self endon("killanimscript");
  scripts\anim\shared::donotetracks(var_0);
}

func_10D6A(var_0, var_1, var_2) {
  self.var_4662 = 1;
  if(self.a.var_4667 == "lean") {
    self.a.var_AAF2 = 1;
  } else {
    self.a.var_AAF2 = undefined;
  }

  func_F637(var_0, var_1, var_2);
}

func_3C50(var_0, var_1, var_2) {
  if(self.a.var_4667 == "lean") {
    self.a.var_AAF2 = 1;
  } else {
    self.a.var_AAF2 = undefined;
  }

  func_F637(var_0, var_1, var_2);
}

func_1105C(var_0) {
  self.var_4662 = 0;
  self clearanim( % add_fire, var_0);
  scripts\anim\track::func_F641(0, var_0);
  self.facialidx = undefined;
  self clearanim( % head, 0.2);
}

func_F637(var_0, var_1, var_2) {
  self.var_10A5A = var_0;
  self func_82AC( % exposed_modern, 1, var_2);
  self func_82AC( % exposed_aiming, 1, var_2);
  self func_82AC( % add_idle, 1, var_2);
  scripts\anim\track::func_F641(1, var_2);
  func_465D(undefined);
  var_3 = undefined;
  if(isDefined(self.a.var_2274["lean_aim_straight"])) {
    var_3 = self.a.var_2274["lean_aim_straight"];
  }

  thread scripts\anim\combat_utility::func_1A3E();
  if(isDefined(self.a.var_AAF2)) {
    self func_82AC(var_3, 1, var_2);
    self func_82AC(scripts\anim\utility::func_1F64("straight_level"), 0, 0);
    self func_82A9(scripts\anim\utility::func_1F64("lean_aim_left"), 1, var_2);
    self func_82A9(scripts\anim\utility::func_1F64("lean_aim_right"), 1, var_2);
    self func_82A9(scripts\anim\utility::func_1F64("lean_aim_up"), 1, var_2);
    self func_82A9(scripts\anim\utility::func_1F64("lean_aim_down"), 1, var_2);
    return;
  }

  if(var_1) {
    self func_82AC(scripts\anim\utility::func_1F64("straight_level"), 1, var_2);
    if(isDefined(var_3)) {
      self func_82AC(var_3, 0, 0);
    }

    self func_82A9(scripts\anim\utility::func_1F64("add_aim_up"), 1, var_2);
    self func_82A9(scripts\anim\utility::func_1F64("add_aim_down"), 1, var_2);
    self func_82A9(scripts\anim\utility::func_1F64("add_aim_left"), 1, var_2);
    self func_82A9(scripts\anim\utility::func_1F64("add_aim_right"), 1, var_2);
    return;
  }

  self func_82AC(scripts\anim\utility::func_1F64("straight_level"), 0, var_2);
  if(isDefined(var_3)) {
    self func_82AC(var_3, 0, 0);
  }

  self func_82A9(scripts\anim\utility::func_1F64("add_turn_aim_up"), 1, var_2);
  self func_82A9(scripts\anim\utility::func_1F64("add_turn_aim_down"), 1, var_2);
  self func_82A9(scripts\anim\utility::func_1F64("add_turn_aim_left"), 1, var_2);
  self func_82A9(scripts\anim\utility::func_1F64("add_turn_aim_right"), 1, var_2);
}

func_10F8A() {
  if(self.a.var_4667 == "over") {
    return 1;
  }

  return scripts\anim\combat_utility::func_DCAD();
}

func_10F89() {
  self.a.var_4667 = "alert";
  if(self.objective_playermask_showto < 64) {
    self.objective_playermask_showto = 64;
  }

  func_F6B9();
  if(self.a.pose == "stand") {
    self.var_1513 = 38;
  } else {
    self.var_1513 = 31;
  }

  var_0 = self.a.pose;
  func_F2AE(var_0);
  scripts\anim\combat::func_F337();
  var_1 = "none";
  if(scripts\anim\utility::func_8BED()) {
    var_1 = func_7E3C(self.covernode, scripts\anim\utility::func_7E90());
  } else {
    var_1 = func_7E3C(self.covernode);
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = "alert_to_" + var_1;
  if(!scripts\anim\utility::func_1F65(var_2)) {
    return 0;
  }

  var_3 = scripts\anim\utility::func_1F67(var_2);
  if(var_1 == "lean" && !func_9EDA()) {
    return 0;
  }

  if(var_1 != "over" && !func_9ED6(var_3, var_1 != "lean")) {
    return 0;
  }

  self.a.var_4667 = var_1;
  self.a.var_D892 = var_1;
  if(self.a.var_4667 == "lean") {
    scripts\anim\combat::func_F337(self.covernode);
  }

  if(var_1 == "A" || var_1 == "B") {
    self.a.var_10930 = "cover_" + self.var_4664 + "_" + self.a.pose + "_" + var_1;
  } else if(var_1 == "over") {
    self.a.var_10930 = "cover_crouch_aim";
  } else {
    self.a.var_10930 = "none";
  }

  self.sendmatchdata = 1;
  var_4 = 0;
  self.var_3C60 = 1;
  self notify("done_changing_cover_pos");
  var_5 = func_10F8A();
  self.closefile = 0;
  self func_82E4("stepout", var_3, % root, 1, 0.2, var_5);
  func_465E(var_3);
  thread donotetrackswithendon("stepout");
  var_4 = animhasnotetrack(var_3, "start_aim");
  if(var_4) {
    self.var_10F8C = self.angles[1] + getangledelta(var_3, 0, 1);
    self waittillmatch("start_aim", "stepout");
  } else {
    self waittillmatch("end", "stepout");
  }

  if(var_1 == "B" && scripts\engine\utility::cointoss() && self.var_4664 == "right") {
    self.a.var_10930 = "corner_right_martyrdom";
  }

  func_F2AF(var_0);
  var_6 = var_1 == "over" || scripts\engine\utility::actor_is3d();
  func_10D6A(undefined, var_6, 0.3);
  thread scripts\anim\track::func_11B07();
  if(var_4) {
    self waittillmatch("end", "stepout");
    self.var_10F8C = undefined;
  }

  func_3C50(undefined, 1, 0.2);
  self clearanim( % cover, 0.1);
  self clearanim( % corner, 0.1);
  self.var_3C60 = 0;
  self.var_4740 = gettime();
  self.closefile = 1;
  return 1;
}

func_10F8B() {
  self.sendmatchdata = 1;
  if(isDefined(self.var_DC5C) && randomfloat(1) < self.var_DC5C) {
    if(func_DC57()) {
      return 1;
    }
  }

  if(!func_10F89()) {
    return 0;
  }

  shootastold();
  if(isDefined(self.var_FECF)) {
    var_0 = lengthsquared(self.origin - self.var_FECF);
    if(scripts\anim\utility_common::usingrocketlauncher() && scripts\anim\utility::func_10000(var_0)) {
      if(self.a.pose == "stand") {
        scripts\anim\shared::func_1180E(scripts\anim\utility::func_B027("combat", "drop_rpg_stand"));
      } else {
        scripts\anim\shared::func_1180E(scripts\anim\utility::func_B027("combat", "drop_rpg_crouch"));
      }

      thread func_E841();
      return;
    }
  }

  func_E47A();
  self.sendmatchdata = 0;
  return 1;
}

func_8C4E(var_0) {
  if(!isDefined(self.var_A9D8)) {
    return 1;
  }

  return gettime() - self.var_A9D8 > var_0 * 1000;
}

func_DC57() {
  if(!scripts\anim\utility::func_8BED()) {
    return 0;
  }

  var_0 = 0;
  var_1 = 90;
  var_2 = self.covernode scripts\anim\utility_common::getyawtoorigin(scripts\anim\utility::func_7E90());
  if(self.var_4664 == "right") {
    var_2 = 0 - var_2;
  }

  if(var_2 < -30) {
    var_1 = 45;
    if(self.var_4664 == "left") {
      var_0 = -45;
    } else {
      var_0 = 45;
    }
  }

  var_3 = "rambo" + var_1;
  if(!scripts\anim\utility::func_1F65(var_3)) {
    return 0;
  }

  var_4 = scripts\anim\utility::func_1F67(var_3);
  var_5 = destroy(48);
  if(!self maymovetopoint(var_5, !scripts\engine\utility::actor_is3d())) {
    return 0;
  }

  self.var_4740 = gettime();
  func_F6B9();
  self.sendmatchdata = 1;
  self.var_9F15 = 1;
  self.a.var_D892 = "rambo";
  self.var_3C60 = 1;
  thread scripts\anim\shared::func_DC59(var_0);
  self func_82E4("rambo", var_4, % body, 1, 0, 1);
  func_465E(var_4);
  scripts\anim\shared::donotetracks("rambo");
  self notify("rambo_aim_end");
  self.var_3C60 = 0;
  self.sendmatchdata = 0;
  self.var_A9D8 = gettime();
  self.var_3C60 = 0;
  self.var_9F15 = undefined;
  return 1;
}

shootastold() {
  scripts\sp\gameskill::func_54C4();
  for(;;) {
    for(;;) {
      if(isDefined(self.var_1006D)) {
        break;
      }

      if(!isDefined(self.var_FECF)) {
        self waittill("do_slow_things");
        waittillframeend;
        if(isDefined(self.var_FECF)) {
          continue;
        }

        break;
      }

      if(!self.bulletsinclip) {
        break;
      }

      if(shootposwrapper_func()) {
        if(!func_3C5D()) {
          if(func_7E03() == self.a.var_4667) {
            break;
          }

          func_FEE2(0.2);
          continue;
        }

        if(shootposwrapper_func()) {
          break;
        }

        continue;
      }

      func_FEE0(1);
      self clearanim( % add_fire, 0.2);
    }

    if(canreturntocover(self.a.var_4667 != "lean")) {
      break;
    }

    if(shootposwrapper_func() && func_3C5D()) {
      continue;
    }

    func_FEE2(0.2);
  }
}

func_FEE2(var_0) {
  thread func_C173(var_0);
  var_1 = gettime();
  func_FEE0(0);
  self notify("stopNotifyStopShootingAfterTime");
  var_2 = gettime() - var_1 / 1000;
  if(var_2 < var_0) {
    wait(var_0 - var_2);
  }
}

func_C173(var_0) {
  self endon("killanimscript");
  self endon("stopNotifyStopShootingAfterTime");
  wait(var_0);
  self notify("stopShooting");
}

func_FEE0(var_0) {
  self endon("return_to_cover");
  if(var_0) {
    thread func_1E82();
  }

  thread scripts\anim\combat_utility::func_1A3E();
  scripts\anim\combat_utility::func_FEDF();
}

func_1E82() {
  self endon("killanimscript");
  self notify("newAngleRangeCheck");
  self endon("newAngleRangeCheck");
  self endon("take_cover_at_corner");
  for(;;) {
    if(shootposwrapper_func()) {
      break;
    }

    wait(0.1);
  }

  self notify("stopShooting");
}

func_10154() {
  self.isnodeoccupied endon("death");
  self endon("enemy");
  self endon("stopshowstate");
  wait(0.05);
}

canreturntocover(var_0) {
  var_1 = !scripts\engine\utility::actor_is3d();
  if(var_0) {
    var_2 = destroy();
    if(!self maymovetopoint(var_2, var_1)) {
      return 0;
    }

    return self maymovefrompointtopoint(var_2, self.covernode.origin, var_1);
  }

  return self maymovetopoint(self.covernode.origin, var_2);
}

func_E47A() {
  scripts\anim\combat_utility::func_631A();
  var_0 = scripts\anim\utility_common::issuppressedwrapper();
  self notify("take_cover_at_corner");
  self.var_3C60 = 1;
  self notify("done_changing_cover_pos");
  var_1 = self.a.var_4667 + "_to_alert";
  var_2 = scripts\anim\utility::func_1F67(var_1);
  func_1105C(0.3);
  var_3 = 0;
  if(self.a.var_4667 != "lean" && var_0 && scripts\anim\utility::func_1F65(var_1 + "_reload") && randomfloat(100) < 75) {
    var_2 = scripts\anim\utility::func_1F67(var_1 + "_reload");
    var_3 = 1;
  }

  var_4 = func_10F8A();
  if(scripts\engine\utility::actor_is3d()) {
    self clearanim( % exposed_modern, 0.2);
  } else {
    self clearanim( % body, 0.1);
  }

  self func_82EA("hide", var_2, 1, 0.1, var_4);
  func_465E(var_2);
  scripts\anim\shared::donotetracks("hide");
  if(var_3) {
    scripts\anim\weaponlist::refillclip();
  }

  self.var_3C60 = 0;
  if(self.var_4664 == "up") {
    self.a.var_10930 = "cover_up";
  } else if(self.var_4664 == "left") {
    self.a.var_10930 = "cover_left";
  } else {
    self.a.var_10930 = "cover_right";
  }

  self.sendmatchdata = 0;
  self clearanim(var_2, 0.2);
}

func_2B99() {
  if(!scripts\anim\utility::func_1F65("blind_fire")) {
    return 0;
  }

  func_F6B9();
  self.sendmatchdata = 1;
  var_0 = scripts\anim\utility::func_1F67("blind_fire");
  self func_82E4("blindfire", var_0, % body, 1, 0, 1);
  func_465E(var_0);
  scripts\anim\shared::donotetracks("blindfire");
  self.sendmatchdata = 0;
  return 1;
}

func_ACF4(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = (1, 1, 1);
  }

  for(var_3 = 0; var_3 < 100; var_3++) {
    wait(0.05);
  }
}

func_128B0(var_0) {
  return func_128AF(var_0, 1);
}

func_128AF(var_0, var_1) {
  if(!self maymovetopoint(destroy())) {
    return 0;
  }

  if(isDefined(self.dontevershoot) || isDefined(var_0.var_5951)) {
    return 0;
  }

  var_2 = undefined;
  if(isDefined(self.var_DC5C) && randomfloat(1) < self.var_DC5C) {
    if(isDefined(self.a.var_2274["grenade_rambo"])) {
      var_2 = scripts\anim\utility::func_1F64("grenade_rambo");
    }
  }

  if(!isDefined(var_2)) {
    if(isDefined(var_1) && var_1) {
      if(!isDefined(self.a.var_2274["grenade_safe"])) {
        return 0;
      }

      var_2 = scripts\anim\utility::func_1F64("grenade_safe");
    } else {
      if(!isDefined(self.a.var_2274["grenade_exposed"])) {
        return 0;
      }

      var_2 = scripts\anim\utility::func_1F64("grenade_exposed");
    }
  }

  func_F6B9();
  self.sendmatchdata = 1;
  var_3 = scripts\anim\combat_utility::func_128A0(var_0, var_2);
  self.sendmatchdata = 0;
  return var_3;
}

func_D922() {}

func_B01C(var_0) {
  if(!isDefined(self.a.var_2274["alert_to_look"])) {
    return 0;
  }

  func_F6B9();
  self.sendmatchdata = 1;
  if(!func_C9FC()) {
    return 0;
  }

  scripts\anim\shared::func_D4C2(scripts\anim\utility::func_1F64("look_idle"), var_0, ::func_3915);
  var_1 = undefined;
  if(scripts\anim\utility_common::issuppressedwrapper()) {
    var_1 = scripts\anim\utility::func_1F64("look_to_alert_fast");
  } else {
    var_1 = scripts\anim\utility::func_1F64("look_to_alert");
  }

  self func_82E4("looking_end", var_1, % body, 1, 0.1, 1);
  func_465E(var_1);
  scripts\anim\shared::donotetracks("looking_end");
  func_F6B9();
  self.sendmatchdata = 0;
  return 1;
}

func_9EDA() {
  var_0 = self.covernode.angles;
  if(scripts\engine\utility::actor_is3d()) {
    var_0 = scripts\anim\utility_common::gettruenodeangles(self.covernode);
  }

  var_1 = self getEye();
  var_2 = anglestoright(var_0);
  var_3 = anglestoup(var_0);
  if(self.var_4664 == "right") {
    var_1 = var_1 + var_2 * 30;
  } else if(self.var_4664 == "left") {
    var_1 = var_1 - var_2 * 30;
  } else {
    var_1 = var_1 + var_3 * 30;
  }

  var_4 = var_1 + anglesToForward(var_0) * 30;
  return sighttracepassed(var_1, var_4, 1, self);
}

func_C9FC() {
  if(isDefined(self.covernode.var_ED6A)) {
    return 0;
  }

  if(isDefined(self.var_BFA3) && gettime() < self.var_BFA3) {
    return 0;
  }

  if(!func_9EDA()) {
    self.var_BFA3 = gettime() + 3000;
    return 0;
  }

  var_0 = scripts\anim\utility::func_1F64("alert_to_look");
  self func_82E3("looking_start", var_0, % body, 1, 0.2, 1);
  func_465E(var_0);
  scripts\anim\shared::donotetracks("looking_start");
  return 1;
}

func_3915() {
  return self maymovetopoint(self.covernode.origin, !scripts\engine\utility::actor_is3d());
}

func_6B9B() {
  return 0;
}

func_4668() {
  var_0 = scripts\anim\utility::func_1F67("reload");
  self func_82E7("cornerReload", var_0, 1, 0.2);
  func_465E(var_0);
  scripts\anim\shared::donotetracks("cornerReload");
  self notify("abort_reload");
  scripts\anim\weaponlist::refillclip();
  self give_capture_credit(scripts\anim\utility::func_1F64("alert_idle"), 1, 0.2);
  self clearanim(var_0, 0.2);
  return 1;
}

func_9ED6(var_0, var_1) {
  var_2 = !scripts\engine\utility::actor_is3d();
  if(var_1) {
    var_3 = destroy();
    if(!self maymovetopoint(var_3, var_2)) {
      return 0;
    }

    if(scripts\engine\utility::actor_is3d()) {
      return 1;
    }

    return self maymovefrompointtopoint(var_3, scripts\anim\utility::func_7DC6(var_0), var_2);
  }

  if(scripts\engine\utility::actor_is3d()) {
    return 1;
  }

  return self maymovetopoint(scripts\anim\utility::func_7DC6(var_1), var_3);
}

destroy(var_0) {
  var_1 = self.covernode.angles;
  var_2 = anglestoright(var_1);
  if(!isDefined(var_0)) {
    var_0 = 36;
  }

  var_3 = self.script;
  switch (var_3) {
    case "cover_left":
      var_2 = var_2 * 0 - var_0;
      break;

    case "cover_right":
      var_2 = var_2 * var_0;
      break;

    default:
      break;
  }

  return self.covernode.origin + (var_2[0], var_2[1], 0);
}

func_92CC() {
  self endon("end_idle");
  for(;;) {
    var_0 = randomint(2) == 0 && isDefined(self.a.var_2274["alert_idle_twitch"]) && scripts\anim\utility::func_1F65("alert_idle_twitch");
    if(var_0) {
      var_1 = scripts\anim\utility::func_1F67("alert_idle_twitch");
    } else {
      var_1 = scripts\anim\utility::func_1F64("alert_idle");
    }

    func_D49E(var_1, var_0);
  }
}

func_6F27() {
  if(!scripts\anim\utility::func_1F65("alert_idle_flinch")) {
    return 0;
  }

  func_D49E(scripts\anim\utility::func_1F67("alert_idle_flinch"), 1);
  return 1;
}

func_D49E(var_0, var_1) {
  if(var_1) {
    self func_82E4("idle", var_0, % body, 1, 0.1, 1);
  } else {
    self func_82E3("idle", var_0, % body, 1, 0.1, 1);
  }

  func_465E(var_0);
  scripts\anim\shared::donotetracks("idle");
}

func_F2AE(var_0) {
  [[self.var_1F66["hiding"][var_0]]]();
  [[self.var_1F66["exposed"][var_0]]]();
}

func_F2AF(var_0) {
  [[self.var_1F66["exposed"][var_0]]]();
}

transitiontostance(var_0) {
  if(self.a.pose == var_0) {
    func_F2AE(var_0);
    return;
  }

  var_1 = scripts\anim\utility::func_1F64("stance_change");
  self func_82E4("changeStance", var_1, % body);
  func_465E(var_1);
  func_F2AE(var_0);
  scripts\anim\shared::donotetracks("changeStance");
  wait(0.2);
}

func_846D(var_0, var_1, var_2) {
  var_3 = scripts\anim\utility_common::getnodedirection();
  var_4 = scripts\anim\utility_common::func_7E28();
  var_5 = var_3 + self.var_8EDF;
  if(scripts\engine\utility::actor_is3d()) {
    self notify("force_space_rotation_update", 0, 0);
  } else {
    self orientmode("face angle", var_5);
  }

  self animmode("normal");
  if(isDefined(var_4)) {
    thread scripts\anim\shared::func_BD1D(var_4, var_1);
  }

  self func_82E4("coveranim", var_0, % body, 1, var_1);
  func_465E(var_0);
  scripts\anim\notetracks::donotetracksfortime(var_2, "coveranim");
  while(scripts\engine\utility::absangleclamp180(self.angles[1] - var_5) > 1) {
    scripts\anim\notetracks::donotetracksfortime(0.1, "coveranim");
    var_3 = scripts\anim\utility_common::getnodedirection();
    var_5 = var_3 + self.var_8EDF;
  }

  func_F6B9();
  if(self.var_4664 == "left") {
    self.a.var_10930 = "cover_left";
    return;
  }

  if(self.var_4664 == "right") {
    self.a.var_10930 = "cover_right";
    return;
  }

  self.a.var_10930 = "cover_up";
}

drawoffset() {
  self endon("killanimscript");
  wait(0.05);
}

func_F5AD() {
  if(!isDefined(self.a.var_2274)) {}

  var_0 = scripts\anim\utility::func_B028("default_stand");
  self.a.var_2274["add_aim_up"] = var_0["add_aim_up"];
  self.a.var_2274["add_aim_down"] = var_0["add_aim_down"];
  self.a.var_2274["add_aim_left"] = var_0["add_aim_left"];
  self.a.var_2274["add_aim_right"] = var_0["add_aim_right"];
  self.a.var_2274["add_turn_aim_up"] = var_0["add_turn_aim_up"];
  self.a.var_2274["add_turn_aim_down"] = var_0["add_turn_aim_down"];
  self.a.var_2274["add_turn_aim_left"] = var_0["add_turn_aim_left"];
  self.a.var_2274["add_turn_aim_right"] = var_0["add_turn_aim_right"];
  self.a.var_2274["straight_level"] = var_0["straight_level"];
  if(self.a.var_4667 == "lean") {
    var_1 = self.a.var_2274["lean_fire"];
    var_2 = self.a.var_2274["lean_single"];
    self.a.var_2274["fire"] = var_1;
    self.a.var_2274["single"] = scripts\anim\utility::func_2274(var_2);
    self.a.var_2274["semi2"] = var_2;
    self.a.var_2274["semi3"] = var_2;
    self.a.var_2274["semi4"] = var_2;
    self.a.var_2274["semi5"] = var_2;
    self.a.var_2274["burst2"] = var_1;
    self.a.var_2274["burst3"] = var_1;
    self.a.var_2274["burst4"] = var_1;
    self.a.var_2274["burst5"] = var_1;
    self.a.var_2274["burst6"] = var_1;
  } else {
    self.a.var_2274["fire"] = var_0["fire_corner"];
    self.a.var_2274["semi2"] = var_0["semi2"];
    self.a.var_2274["semi3"] = var_0["semi3"];
    self.a.var_2274["semi4"] = var_0["semi4"];
    self.a.var_2274["semi5"] = var_0["semi5"];
    if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
      self.a.var_2274["single"] = scripts\anim\utility::func_B027("shotgun_stand", "single");
    } else {
      self.a.var_2274["single"] = var_0["single"];
    }

    self.a.var_2274["burst2"] = var_0["burst2"];
    self.a.var_2274["burst3"] = var_0["burst3"];
    self.a.var_2274["burst4"] = var_0["burst4"];
    self.a.var_2274["burst5"] = var_0["burst5"];
    self.a.var_2274["burst6"] = var_0["burst6"];
  }

  self.a.var_2274["exposed_idle"] = var_0["exposed_idle"];
}

func_F317() {
  if(!isDefined(self.a.var_2274)) {}

  var_0 = scripts\anim\utility::func_B028("default_crouch");
  var_1["add_aim_up"] = scripts\anim\utility::func_B027("cover_crouch", "add_aim_up");
  var_2["add_aim_up"] = scripts\anim\utility::func_B027("cover_crouch", "add_aim_up");
  var_3[0] = scripts\anim\utility::func_B027("cover_crouch", "add_aim_up");
  if(self.a.var_4667 == "over") {
    self.a.var_2274["add_aim_up"] = scripts\anim\utility::func_B027("cover_crouch", "add_aim_up");
    self.a.var_2274["add_aim_down"] = scripts\anim\utility::func_B027("cover_crouch", "add_aim_down");
    self.a.var_2274["add_aim_left"] = scripts\anim\utility::func_B027("cover_crouch", "add_aim_left");
    self.a.var_2274["add_aim_right"] = scripts\anim\utility::func_B027("cover_crouch", "add_aim_right");
    self.a.var_2274["straight_level"] = scripts\anim\utility::func_B027("cover_crouch", "straight_level");
    self.a.var_2274["exposed_idle"] = scripts\anim\utility::func_B027("default_stand", "exposed_idle");
    return;
  }

  if(self.a.var_4667 == "lean") {
    var_4 = self.a.var_2274["lean_fire"];
    var_5 = self.a.var_2274["lean_single"];
    self.a.var_2274["fire"] = var_4;
    self.a.var_2274["single"] = scripts\anim\utility::func_2274(var_5);
    self.a.var_2274["semi2"] = var_5;
    self.a.var_2274["semi3"] = var_5;
    self.a.var_2274["semi4"] = var_5;
    self.a.var_2274["semi5"] = var_5;
    self.a.var_2274["burst2"] = var_4;
    self.a.var_2274["burst3"] = var_4;
    self.a.var_2274["burst4"] = var_4;
    self.a.var_2274["burst5"] = var_4;
    self.a.var_2274["burst6"] = var_4;
  } else {
    self.a.var_2274["fire"] = var_0["fire"];
    self.a.var_2274["semi2"] = var_0["semi2"];
    self.a.var_2274["semi3"] = var_0["semi3"];
    self.a.var_2274["semi4"] = var_0["semi4"];
    self.a.var_2274["semi5"] = var_0["semi5"];
    if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
      self.a.var_2274["single"] = scripts\anim\utility::func_B027("shotgun_crouch", "single");
    } else {
      self.a.var_2274["single"] = var_0["single"];
    }

    self.a.var_2274["burst2"] = var_0["burst2"];
    self.a.var_2274["burst3"] = var_0["burst3"];
    self.a.var_2274["burst4"] = var_0["burst4"];
    self.a.var_2274["burst5"] = var_0["burst5"];
    self.a.var_2274["burst6"] = var_0["burst6"];
  }

  self.a.var_2274["add_aim_up"] = var_0["add_aim_up"];
  self.a.var_2274["add_aim_down"] = var_0["add_aim_down"];
  self.a.var_2274["add_aim_left"] = var_0["add_aim_left"];
  self.a.var_2274["add_aim_right"] = var_0["add_aim_right"];
  self.a.var_2274["add_turn_aim_up"] = var_0["add_turn_aim_up"];
  self.a.var_2274["add_turn_aim_down"] = var_0["add_turn_aim_down"];
  self.a.var_2274["add_turn_aim_left"] = var_0["add_turn_aim_left"];
  self.a.var_2274["add_turn_aim_right"] = var_0["add_turn_aim_right"];
  self.a.var_2274["straight_level"] = var_0["straight_level"];
  self.a.var_2274["exposed_idle"] = var_0["exposed_idle"];
}

func_E841() {
  self notify("killanimscript");
  thread scripts\anim\combat::main();
}

func_F6B9() {
  if(scripts\engine\utility::actor_is3d()) {
    self animmode("nogravity");
    return;
  }

  self animmode("zonly_physics");
}

func_465E(var_0) {
  if(self.var_4664 == "left") {
    var_1 = "corner_stand_L";
  } else {
    var_1 = "corner_stand_R";
  }

  self.facialidx = scripts\anim\face::playfacialanim(var_0, var_1, self.facialidx);
}

func_465D(var_0) {
  self.facialidx = scripts\anim\face::playfacialanim(var_0, "aim", self.facialidx);
}

func_465B() {
  self.facialidx = undefined;
  self clearanim( % head, 0.2);
}