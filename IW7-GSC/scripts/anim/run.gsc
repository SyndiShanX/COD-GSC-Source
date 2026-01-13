/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\run.gsc
*********************************************/

func_BCEB() {
  var_0 = [[self.var_3EF3]]("stand");
  switch (var_0) {
    case "stand":
      if(scripts\anim\setposemovement::func_10B76()) {
        return;
      }

      if(isDefined(self.var_E80C)) {
        scripts\anim\move::func_BCF8(self.var_E80C, self.var_E80B);
        return;
      }

      if(func_10B77()) {
        return;
      }

      if(func_10B78()) {
        return;
      }

      scripts\anim\utility::func_12EB9();
      if(scripts\anim\utility::func_9E40()) {
        func_10B79();
      } else {
        func_10B7A();
      }
      break;

    case "crouch":
      if(scripts\anim\setposemovement::func_4A9E()) {
        return;
      }

      if(isDefined(self.var_4A9F)) {
        func_4AA1();
      } else {
        func_4AA0();
      }
      break;

    default:
      if(scripts\anim\setposemovement::func_DA84()) {
        return;
      }

      func_DA7F();
      break;
  }
}

getrunningforwardpainanim() {
  if(!isDefined(self.a.var_BCA5)) {
    return scripts\anim\utility::func_B027("run", "straight");
  }

  if(!self.livestreamingenable) {
    if(self.getcsplinepointtargetname == "none" || abs(self getspawnpoint_searchandrescue()) > 45) {
      return scripts\anim\utility::func_7FCC("move_f");
    }
  }

  if(self.getcsplinepointtargetname == "up") {
    return scripts\anim\utility::func_7FCC("stairs_up");
  } else if(self.getcsplinepointtargetname == "down") {
    return scripts\anim\utility::func_7FCC("stairs_down");
  }

  if(scripts\anim\utility::func_9E40() || isDefined(self.a.var_29CE) && self.a.var_29CE) {
    return scripts\anim\utility::func_7FCC("straight");
  }

  var_0 = scripts\anim\utility::func_7FCC("straight_twitch");
  if(!isDefined(var_0) || var_0.size == 0) {
    return scripts\anim\utility::func_7FCC("straight");
  }

  var_1 = scripts\anim\utility::setclientextrasuper(self.a.var_E860, 4);
  if(var_1 == 0) {
    var_1 = scripts\anim\utility::setclientextrasuper(self.a.var_E860, var_0.size);
    return var_0[var_1];
  }

  return scripts\anim\utility::func_7FCC("straight");
}

func_7E47() {
  if(!isDefined(self.a.var_BCA5)) {
    return scripts\anim\utility::func_B027("run", "crouch");
  }

  return scripts\anim\utility::func_7FCC("crouch");
}

func_DA7F() {
  self.a.movement = "run";
  self give_left_powers("runanim", scripts\anim\utility::func_7FCC("prone"), 1, 0.3, self.moveplaybackrate);
  func_E7E5();
  scripts\anim\notetracks::donotetracksfortime(0.25, "runanim");
}

func_98C6() {
  if(!isDefined(self.var_E873)) {
    self notify("stop_move_anim_update");
    self.var_12DEF = undefined;
    self clearanim( % combatrun_backward, 0.2);
    self clearanim( % combatrun_right, 0.2);
    self clearanim( % combatrun_left, 0.2);
    self clearanim( % w_aim_2, 0.2);
    self clearanim( % w_aim_4, 0.2);
    self clearanim( % w_aim_6, 0.2);
    self clearanim( % w_aim_8, 0.2);
    self.var_E873 = 1;
  }
}

func_11088() {
  if(isDefined(self.var_E873)) {
    self clearanim( % run_n_gun, 0.2);
    self.var_E873 = undefined;
  }

  return 0;
}

func_E873(var_0) {
  if(var_0) {
    var_1 = detach(0.2);
    var_2 = var_1 < 0;
  } else {
    var_1 = 0;
    var_2 = self.var_E879 < 0;
  }

  var_3 = 1 - var_2;
  var_4 = self.var_B4C3;
  var_5 = self.var_E878;
  var_6 = self.var_E876;
  if(!var_0 || squared(var_1) > var_4 * var_4) {
    self clearanim( % add_fire, 0);
    if(squared(self.var_E879) < var_6 * var_6) {
      self.var_E879 = 0;
      self.var_E873 = undefined;
      return 0;
    } else if(self.var_E879 > 0) {
      self.var_E879 = self.var_E879 - var_6;
    } else {
      self.var_E879 = self.var_E879 + var_6;
    }
  } else {
    var_7 = var_1 / var_4;
    var_8 = var_7 - self.var_E879;
    if(abs(var_8) < var_5 * 0.7) {
      self.var_E879 = var_7;
    } else if(var_8 > 0) {
      self.var_E879 = self.var_E879 + var_6;
    } else {
      self.var_E879 = self.var_E879 - var_6;
    }
  }

  func_98C6();
  var_9 = abs(self.var_E879);
  var_0A = scripts\anim\utility::func_B028("run_n_gun");
  if(var_9 > var_5) {
    var_0B = var_9 - var_5 / var_5;
    var_0B = clamp(var_0B, 0, 1);
    self clearanim(var_0A["F"], 0.2);
    self func_82AC(var_0A["L"], 1 - var_0B * var_2, 0.2);
    self func_82AC(var_0A["R"], 1 - var_0B * var_3, 0.2);
    self func_82AC(var_0A["LB"], var_0B * var_2, 0.2);
    self func_82AC(var_0A["RB"], var_0B * var_3, 0.2);
  } else {
    var_0B = clamp(var_0A / var_6, 0, 1);
    self func_82AC(var_0A["F"], 1 - var_0B, 0.2);
    self func_82AC(var_0A["L"], var_0B * var_2, 0.2);
    self func_82AC(var_0A["R"], var_0B * var_3, 0.2);
    if(var_5 < 1) {
      self clearanim(var_0A["LB"], 0.2);
      self clearanim(var_0A["RB"], 0.2);
    }
  }

  self give_left_powers("runanim", % run_n_gun, 1, 0.3, 0.8);
  func_E80F(undefined);
  self.a.var_1C8D = gettime() + 500;
  if(var_0 && isplayer(self.isnodeoccupied)) {
    self func_83CE();
  }

  return 1;
}

func_E874() {
  func_98C6();
  var_0 = scripts\anim\utility::func_B027("run_n_gun", "move_back");
  self give_left_powers("runanim", var_0, 1, 0.3, 0.8);
  func_E80F(var_0);
  if(isplayer(self.isnodeoccupied)) {
    self func_83CE();
  }

  scripts\anim\notetracks::donotetracksfortime(0.2, "runanim");
  self clearanim(var_0, 0.2);
}

func_DD62() {
  self endon("killanimscript");
  for(;;) {
    wait(0.2);
    if(!isDefined(self.var_DD39)) {
      break;
    }

    if(!isDefined(self.vehicle_getspawnerarray) || distancesquared(self.vehicle_getspawnerarray, self.origin) < squared(80)) {
      func_6382();
      self notify("interrupt_react_to_bullet");
      break;
    }
  }
}

func_6382() {
  self orientmode("face default");
  self.var_DD39 = undefined;
  self.var_E1B0 = undefined;
}

func_E87E() {
  func_6318();
  self endon("interrupt_react_to_bullet");
  self.var_DD39 = 1;
  self orientmode("face motion");
  var_0 = scripts\anim\utility::func_B028("running_react_to_bullets");
  var_1 = randomint(var_0.size);
  if(var_1 == level.var_A9E6) {
    var_1 = var_1 + 1 % var_0.size;
  }

  anim.var_A9E6 = var_1;
  var_2 = var_0[var_1];
  self func_82E7("reactanim", var_2, 1, 0.5, self.moveplaybackrate);
  func_E80F(var_2);
  thread func_DD62();
  scripts\anim\shared::donotetracks("reactanim");
  func_6382();
}

func_4C9A() {
  func_6318();
  self.var_DD39 = 1;
  self orientmode("face motion");
  var_0 = randomint(self.var_E80D.size);
  var_1 = self.var_E80D[var_0];
  self func_82E7("reactanim", var_1, 1, 0.5, self.moveplaybackrate);
  func_E80F(var_1);
  thread func_DD62();
  scripts\anim\shared::donotetracks("reactanim");
  func_6382();
}

func_8150() {
  var_0 = undefined;
  if(isDefined(self.objective_position)) {
    var_0 = scripts\anim\utility::func_7FCC("sprint_short");
  }

  if(!isDefined(var_0)) {
    var_0 = scripts\anim\utility::func_7FCC("sprint");
  }

  return var_0;
}

func_10086() {
  if(isDefined(self.var_10AB7)) {
    return 1;
  }

  if(isDefined(self.objective_position) && isDefined(self.isnodeoccupied) && self.objective_additionalcurrent == 1) {
    return distancesquared(self.origin, self.isnodeoccupied.origin) > 90000;
  }

  return 0;
}

func_10087() {
  if(isDefined(self.var_BEFA)) {
    return 0;
  }

  if(!self.livestreamingenable || self.getcsplinepointtargetname != "none") {
    return 0;
  }

  var_0 = gettime();
  if(isDefined(self.var_4D85)) {
    if(var_0 < self.var_4D85) {
      return 1;
    }

    if(var_0 - self.var_4D85 < 6000) {
      return 0;
    }
  }

  if(!isDefined(self.isnodeoccupied) || !issentient(self.isnodeoccupied)) {
    return 0;
  }

  if(randomint(100) < 25 && self lastknowntime(self.isnodeoccupied) + 2000 > var_0) {
    self.var_4D85 = var_0 + 2000 + randomint(1000);
    return 1;
  }

  return 0;
}

func_7FCF() {
  var_0 = self.moveplaybackrate;
  if(self.setomnvarforallclients && self.getcsplinepointtargetname == "none" && self.setomnvar < 300) {
    var_0 = var_0 * 0.75;
  }

  return var_0;
}

func_10B79() {
  var_0 = func_7FCF();
  self setanimknob( % combatrun, 1, 0.5, var_0);
  var_1 = 0;
  var_2 = isDefined(self.var_E1B0) && gettime() - self.var_E1B0 < 100;
  if(var_2 && randomfloat(1) < self.a.reacttobulletchance) {
    func_11088();
    func_F843(0);
    func_E87E();
    return;
  }

  if(func_10086()) {
    var_3 = func_8150();
    self give_left_powers("runanim", var_3, 1, 0.5, self.moveplaybackrate);
    func_E80F(var_3);
    func_F843(0);
    var_1 = 1;
  } else if(isDefined(self.isnodeoccupied) && scripts\anim\move::func_B4EC()) {
    func_F843(1);
    if(!self.livestreamingenable) {
      thread func_6A6B();
    } else if(self.var_FED7 != "none" && !isDefined(self.var_C09F)) {
      func_6318();
      if(canshoottargetfrompos()) {
        var_1 = func_E873(1);
      } else if(canshoottarget()) {
        func_E874();
        return;
      }
    } else if(isDefined(self.var_E879) && self.var_E879 != 0) {
      var_1 = func_E873(0);
    }
  } else if(isDefined(self.var_E879) && self.var_E879 != 0) {
    func_F843(0);
    var_1 = func_E873(0);
  } else {
    func_F843(0);
  }

  if(!var_1) {
    func_11088();
    if(var_2 && self.a.reacttobulletchance != 0) {
      func_E87E();
      return;
    }

    if(func_BC1D()) {
      return;
    }

    self clearanim( % stair_transitions, 0.1);
    if(func_10087()) {
      var_4 = scripts\anim\utility::func_7FCC("sprint_short");
    } else {
      var_4 = getrunningforwardpainanim();
    }

    self func_82E5("runanim", var_4, 1, 0.1, self.moveplaybackrate, 1);
    func_E80F(var_4);
    func_F7A9(scripts\anim\utility::func_7FCC("move_b"), scripts\anim\utility::func_7FCC("move_l"), scripts\anim\utility::func_7FCC("move_r"), self.var_101BB);
    thread setcombatstandmoveanimweights("run");
  }

  scripts\anim\notetracks::donotetracksfortime(0.2, "runanim");
}

func_815A(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "none";
  }

  if(var_0 == var_1) {
    return undefined;
  }

  if(var_0 == "up") {
    return scripts\anim\utility::func_7FCC("stairs_up_out");
  }

  if(var_0 == "down") {
    return scripts\anim\utility::func_7FCC("stairs_down_out");
  }

  if(var_1 == "up") {
    return scripts\anim\utility::func_7FCC("stairs_up_in");
  }

  if(var_1 == "down") {
    return scripts\anim\utility::func_7FCC("stairs_down_in");
  }
}

func_6A6B() {
  if(isDefined(self.var_1A32)) {
    return;
  }

  self.var_1A32 = 1;
  self endon("killanimscript");
  self endon("end_face_enemy_tracking");
  self func_82D0();
  var_0 = undefined;
  if(isDefined(self.var_440C) && isDefined(self.var_440C["walk_aims"])) {
    self func_82AC(self.var_440C["walk_aims"]["walk_aim_2"]);
    self func_82AC(self.var_440C["walk_aims"]["walk_aim_4"]);
    self func_82AC(self.var_440C["walk_aims"]["walk_aim_6"]);
    self func_82AC(self.var_440C["walk_aims"]["walk_aim_8"]);
  } else {
    var_1 = "walk";
    if(scripts\anim\utility::func_FFDB() && isDefined(scripts\anim\utility::func_B027("cqb", "aim_2"))) {
      var_1 = "cqb";
    }

    var_2 = scripts\anim\utility::func_B028(var_1);
    self func_82AC(var_2["aim_2"]);
    self func_82AC(var_2["aim_4"]);
    self func_82AC(var_2["aim_6"]);
    self func_82AC(var_2["aim_8"]);
    if(isDefined(var_2["aim_5"])) {
      self func_82AC(var_2["aim_5"]);
      var_0 = % w_aim_5;
    }
  }

  scripts\anim\track::func_11AF8( % w_aim_2, % w_aim_4, % w_aim_6, % w_aim_8, var_0);
}

func_6318() {
  self.var_1A32 = undefined;
  self notify("end_face_enemy_tracking");
}

func_F843(var_0) {
  var_1 = isDefined(self.var_3129);
  if(var_0) {
    self.var_3129 = var_0;
    if(!var_1) {
      thread func_E843();
      thread func_E89B();
      return;
    }

    return;
  }

  self.var_3129 = undefined;
  if(var_1) {
    self notify("end_shoot_while_moving");
    self notify("end_face_enemy_tracking");
    self.var_FE92 = undefined;
    self.var_1A32 = undefined;
    self.var_E873 = undefined;
  }
}

func_E843() {
  self endon("killanimscript");
  self endon("end_shoot_while_moving");
  scripts\anim\shoot_behavior::func_4F69("normal");
}

func_E89B() {
  self endon("killanimscript");
  self endon("end_shoot_while_moving");
  scripts\anim\move::func_FEEB();
}

func_1A3C() {
  var_0 = self getspawnpointdist();
  var_1 = vectortoangles(self.isnodeoccupied getshootatpos() - self getmuzzlepos());
  if(scripts\engine\utility::absangleclamp180(var_0[1] - var_1[1]) > 15) {
    return 0;
  }

  return scripts\engine\utility::absangleclamp180(var_0[0] - var_1[0]) <= 20;
}

canshoottargetfrompos() {
  if((!isDefined(self.var_E879) || self.var_E879 == 0) && abs(self getspawnpoint_searchandrescue()) > self.var_B4C3) {
    return 0;
  }

  return 1;
}

canshoottarget() {
  if(180 - abs(self getspawnpoint_searchandrescue()) >= 45) {
    return 0;
  }

  var_0 = detach(0.2);
  if(abs(var_0) > 30) {
    return 0;
  }

  return 1;
}

canshootinvehicle() {
  return scripts\anim\move::func_B4EC() && isDefined(self.isnodeoccupied) && canshoottargetfrompos() || canshoottarget();
}

detach(var_0) {
  var_1 = self.origin;
  var_2 = self.angles[1] + self getspawnpoint_searchandrescue();
  var_1 = var_1 + (cos(var_2), sin(var_2), 0) * length(self.var_381) * var_0;
  var_3 = self.angles[1] - vectortoyaw(self.isnodeoccupied.origin - var_1);
  var_3 = angleclamp180(var_3);
  return var_3;
}

func_BC1D() {
  var_0 = 0;
  var_1 = undefined;
  if(self.getcsplinepointtargetname == "none" && self.setomnvarforallclients) {
    if(scripts\anim\utility::func_FFDB()) {
      var_2 = 32;
    } else {
      var_2 = 48;
    }

    var_3 = self.origin + (0, 0, 6);
    var_4 = vectornormalize((self.setocclusionpreset[0], self.setocclusionpreset[1], 0));
    var_5 = var_3 + var_2 * var_4;
    var_6 = self aiphysicstrace(var_3, var_5, 15, 48, 1, 1);
    if(var_6["fraction"] < 1) {
      if(!isDefined(var_6["stairs"])) {
        return 0;
      }

      var_1 = func_815A("none", "up");
    } else {
      var_7 = 18;
      var_8 = var_5 + (0, 0, var_7);
      var_9 = var_5 - (0, 0, var_7);
      var_6 = self aiphysicstrace(var_8, var_9, 15, 48, 1, 1);
      if(var_6["fraction"] >= 1) {
        return 0;
      }

      if(!isDefined(var_6["stairs"])) {
        return 0;
      }

      var_1 = func_815A("none", "down");
    }
  } else if(self.getcsplinepointtargetname == "up") {
    var_2 = 24;
    var_7 = 18;
    var_5 = self.origin + var_2 * self.setocclusionpreset;
    var_8 = var_5 + (0, 0, var_7);
    var_9 = var_5 - (0, 0, var_7);
    var_6 = self aiphysicstrace(var_8, var_9, 15, 48, 1, 1);
    if(var_6["fraction"] <= 0 || var_6["fraction"] >= 1) {
      return 0;
    }

    if(isDefined(var_6["stairs"])) {
      return 0;
    }

    var_1 = func_815A("up", "none");
  } else if(self.getcsplinepointtargetname == "down" && !self.setomnvarforallclients) {
    var_2 = 24;
    var_7 = 18;
    var_5 = self.origin + var_2 * self.setocclusionpreset;
    var_8 = var_5 + (0, 0, var_7);
    var_9 = var_5 - (0, 0, var_7);
    var_6 = self aiphysicstrace(var_8, var_9, 15, 48, 1, 1);
    if(var_6["fraction"] <= 0 || var_6["fraction"] >= 1) {
      return 0;
    }

    if(isDefined(var_6["stairs"])) {
      return 0;
    }

    var_1 = func_815A("down", "none");
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  self notify("stop_move_anim_update");
  self.var_12DEF = undefined;
  self func_82E4("runanim", var_1, % body, 1, 0.1, self.moveplaybackrate);
  func_E80F(var_1);
  scripts\anim\shared::donotetracks("runanim");
  return 1;
}

func_10B7A() {
  self endon("movemode");
  self clearanim( % combatrun, 0.6);
  var_0 = func_7FCF();
  if(func_BC1D()) {
    return;
  }

  self clearanim( % stair_transitions, 0.1);
  self func_82A5( % combatrun, % body, 1, 0.2, var_0);
  if(func_10086()) {
    var_1 = func_8150();
  } else {
    var_1 = getrunningforwardpainanim();
  }

  if(self.getcsplinepointtargetname == "none") {
    var_2 = 0.3;
  } else {
    var_2 = 0.1;
  }

  self give_left_powers("runanim", var_1, 1, var_2, self.moveplaybackrate, 1);
  func_E80F(var_1);
  func_F7A9(scripts\anim\utility::func_7FCC("move_b"), scripts\anim\utility::func_7FCC("move_l"), scripts\anim\utility::func_7FCC("move_r"));
  thread setcombatstandmoveanimweights("run");
  var_3 = 0;
  if(self.setmapcenter > 0 && self.setmapcenter < 0.998) {
    var_3 = 1;
  } else if(self.setmapcenter < 0 && self.setmapcenter > -0.998) {
    var_3 = -1;
  }

  var_4 = max(0.2, var_2);
  scripts\anim\notetracks::donotetracksfortime(var_4, "runanim");
}

func_4AA1() {
  self endon("movemode");
  self func_82E3("runanim", self.var_4A9F, % body, 1, 0.4, self.moveplaybackrate);
  func_E80F(self.var_4A9F);
  scripts\anim\shared::donotetracks("runanim");
}

func_4AA0() {
  self endon("movemode");
  var_0 = func_7E47();
  self setanimknob(var_0, 1, 0.4);
  thread func_12ED3("crouchrun", var_0, scripts\anim\utility::func_B027("run", "crouch_b"), scripts\anim\utility::func_B027("run", "crouch_l"), scripts\anim\utility::func_B027("run", "crouch_r"));
  self func_82E3("runanim", % crouchrun, % body, 1, 0.2, self.moveplaybackrate);
  func_E80F(undefined);
  scripts\anim\notetracks::donotetracksfortime(0.2, "runanim");
}

func_10B78() {
  var_0 = isDefined(self.a.var_1C8D) && self.a.var_1C8D > gettime();
  var_0 = var_0 || isDefined(self.isnodeoccupied) && distancesquared(self.origin, self.isnodeoccupied.origin) < 65536;
  if(var_0) {
    if(!scripts\anim\utility_common::needtoreload(0)) {
      return 0;
    }
  } else if(!scripts\anim\utility_common::needtoreload(0.5)) {
    return 0;
  }

  if(isDefined(self.objective_position)) {
    return 0;
  }

  if(!self.livestreamingenable || self.getcsplinepointtargetname != "none") {
    return 0;
  }

  if(isDefined(self.var_596C) || isDefined(self.var_C0A0)) {
    return 0;
  }

  if(canshootinvehicle() && !scripts\anim\utility_common::needtoreload(0)) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray) || distancesquared(self.origin, self.vehicle_getspawnerarray) < 65536) {
    return 0;
  }

  var_1 = angleclamp180(self getspawnpoint_searchandrescue());
  if(abs(var_1) > 25) {
    return 0;
  }

  if(!scripts\anim\utility_common::usingriflelikeweapon()) {
    return 0;
  }

  if(!func_E861()) {
    return 0;
  }

  if(scripts\anim\utility::func_FFDB()) {
    scripts\anim\cqb::func_4790();
  } else {
    func_10B7B();
  }

  self notify("abort_reload");
  self orientmode("face default");
  return 1;
}

func_10B7B() {
  self endon("movemode");
  self orientmode("face motion");
  var_0 = "reload_" + scripts\anim\combat_utility::func_81EB();
  var_1 = scripts\anim\utility::func_B027("run", "reload");
  if(isarray(var_1)) {
    var_1 = var_1[randomint(var_1.size)];
  }

  self func_82E4(var_0, var_1, % body, 1, 0.25);
  func_E80F(var_1);
  self.var_12DF0 = 1;
  func_F7A9(scripts\anim\utility::func_7FCC("move_b"), scripts\anim\utility::func_7FCC("move_l"), scripts\anim\utility::func_7FCC("move_r"));
  thread setcombatstandmoveanimweights("run");
  scripts\anim\shared::donotetracks(var_0);
  self.var_12DF0 = undefined;
}

func_E861() {
  var_0 = self getscoreinfocategory( % walk_and_run_loops);
  var_1 = getanimlength(scripts\anim\utility::func_B027("run", "straight")) / 3;
  var_0 = var_0 * 3;
  if(var_0 > 3) {
    var_0 = var_0 - 2;
  } else if(var_0 > 2) {
    var_0 = var_0 - 1;
  }

  if(var_0 < 0.15 / var_1) {
    return 1;
  }

  if(var_0 > 1 - 0.3 / var_1) {
    return 1;
  }

  return 0;
}

func_F7A9(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  self func_82A9(var_0, 1, 0.1, var_3, 1);
  self func_82A9(var_1, 1, 0.1, var_3, 1);
  self func_82A9(var_2, 1, 0.1, var_3, 1);
}

setcombatstandmoveanimweights(var_0) {
  func_12ED3(var_0, % combatrun_forward, % combatrun_backward, % combatrun_left, % combatrun_right);
}

func_12ED3(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self.var_12DEF) && self.var_12DEF == var_0) {
    return;
  }

  self notify("stop_move_anim_update");
  self.var_12DEF = var_0;
  self.var_13910 = undefined;
  self endon("killanimscript");
  self endon("move_interrupt");
  self endon("stop_move_anim_update");
  for(;;) {
    func_12F08(var_1, var_2, var_3, var_4);
    wait(0.05);
    waittillframeend;
  }
}

func_12F08(var_0, var_1, var_2, var_3) {
  if(self.livestreamingenable && !scripts\anim\utility::func_FFDB() && !isDefined(self.var_12DF0)) {
    if(!isDefined(self.var_13910)) {
      self.var_13910 = 1;
      self give_attacker_kill_rewards(var_0, 1, 0.2, 1, 1);
      self give_attacker_kill_rewards(var_1, 0, 0.2, 1, 1);
      self give_attacker_kill_rewards(var_2, 0, 0.2, 1, 1);
      self give_attacker_kill_rewards(var_3, 0, 0.2, 1, 1);
      return;
    }

    return;
  }

  self.var_13910 = undefined;
  var_4 = scripts\anim\utility_common::quadrantanimweights(self getspawnpoint_searchandrescue());
  if(isDefined(self.var_12DF0)) {
    var_4["back"] = 0;
    if(var_4["front"] < 0.2) {
      var_4["front"] = 0.2;
    }
  }

  self give_attacker_kill_rewards(var_0, var_4["front"], 0.2, 1, 1);
  self give_attacker_kill_rewards(var_1, var_4["back"], 0.2, 1, 1);
  self give_attacker_kill_rewards(var_2, var_4["left"], 0.2, 1, 1);
  self give_attacker_kill_rewards(var_3, var_4["right"], 0.2, 1, 1);
}

func_10B77() {
  var_0 = isDefined(self.var_138DF) && self.var_138DF;
  var_1 = scripts\anim\utility_common::isshotgun(self.var_394);
  if(var_0 == var_1) {
    return 0;
  }

  if(!isDefined(self.vehicle_getspawnerarray) || distancesquared(self.origin, self.vehicle_getspawnerarray) < 65536) {
    return 0;
  }

  if(scripts\anim\utility_common::isusingsidearm()) {
    return 0;
  }

  if(self.var_394 == self.primaryweapon) {
    if(!var_0) {
      return 0;
    }

    if(scripts\anim\utility_common::isshotgun(self.secondaryweapon)) {
      return 0;
    }
  } else {
    if(var_0) {
      return 0;
    }

    if(scripts\anim\utility_common::isshotgun(self.primaryweapon)) {
      return 0;
    }
  }

  var_2 = angleclamp180(self getspawnpoint_searchandrescue());
  if(abs(var_2) > 25) {
    return 0;
  }

  if(!func_E861()) {
    return 0;
  }

  if(var_0) {
    func_FF02("shotgunPullout", scripts\anim\utility::func_B027("cqb", "shotgun_pullout"), "gun_2_chest", "none", self.secondaryweapon, "shotgun_pickup");
  } else {
    func_FF02("shotgunPutaway", scripts\anim\utility::func_B027("cqb", "shotgun_putaway"), "gun_2_back", "back", self.primaryweapon, "shotgun_pickup");
  }

  self notify("switchEnded");
  return 1;
}

func_FF02(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("movemode");
  self func_82E4(var_0, var_1, % body, 1, 0.25);
  func_E80F(var_1);
  self.var_12DF0 = 1;
  func_F7A9(scripts\anim\utility::func_7FCC("move_b"), scripts\anim\utility::func_7FCC("move_l"), scripts\anim\utility::func_7FCC("move_r"));
  thread setcombatstandmoveanimweights("run");
  thread func_13B40(var_0, var_2, var_3, var_4, var_5);
  scripts\anim\notetracks::donotetracksfortimeintercept(getanimlength(var_1) - 0.25, var_0, ::func_9A61);
  self.var_12DF0 = undefined;
}

func_9A61(var_0) {
  if(var_0 == "gun_2_chest" || var_0 == "gun_2_back") {
    return 1;
  }
}

func_13B40(var_0, var_1, var_2, var_3, var_4) {
  self endon("killanimscript");
  self endon("movemode");
  self endon("switchEnded");
  self waittillmatch(var_1, var_0);
  scripts\anim\shared::placeweaponon(self.var_394, var_2);
  thread func_FF01(var_3);
  self waittillmatch(var_4, var_0);
  self notify("complete_weapon_switch");
}

func_FF01(var_0) {
  self endon("death");
  scripts\engine\utility::waittill_any_3("killanimscript", "movemode", "switchEnded", "complete_weapon_switch");
  self.lastweapon = self.var_394;
  scripts\anim\shared::placeweaponon(var_0, "right");
  self.bulletsinclip = weaponclipsize(self.var_394);
}

func_E80F(var_0) {
  self.facialidx = scripts\anim\face::playfacialanim(var_0, "run", self.facialidx);
}

func_E7E5() {
  self.facialidx = undefined;
  self clearanim( % head, 0.2);
}