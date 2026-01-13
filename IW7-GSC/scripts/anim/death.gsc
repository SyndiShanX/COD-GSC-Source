/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\death.gsc
**********************************/

func_9510() {}

func_95A2() {
  scripts\engine\utility::add_fx("deathfx_bloodpool_generic", "vfx\core\impacts\deathfx_bloodpool_generic.vfx");
}

main() {
  self endon("killanimscript");
  if(getdvarint("ai_iw7", 0) != 0) {
    self waittill("hellfreezesover");
  }

  self _meth_83AC("voice_bchatter_1_3d");
  var_0 = 0.3;
  self clearanim( % scripted_talking, var_0);
  scripts\sp\anim::func_55C7(0);
  if(self.a.nodeath == 1) {
    return;
  }

  if(isDefined(self.var_4E46)) {
    var_1 = self[[self.var_4E46]]();
    if(!isDefined(var_1)) {
      var_1 = 1;
    }

    if(var_1) {
      return;
    }
  }

  scripts\anim\utility::func_9832("death");
  func_E166(self.origin);
  level.var_C222--;
  level.var_C221--;
  if(isDefined(self.var_DC1A) || self.missile_createattractororigin) {
    func_58CB();
  }

  if(isDefined(self.var_4E2A)) {
    func_CF0E(self.var_4E2A);
    if(isDefined(self.var_4E2E)) {
      self[[self.var_4E2E]]();
    }

    return;
  }

  var_2 = scripts\anim\pain::func_1390C();
  if(self.var_DD == "helmet" || self.var_DD == "head") {
    func_8E17();
  } else if(var_2 && randomint(3) == 0) {
    func_8E17();
  }

  self clearanim( % root, 0.3);
  if(!scripts\engine\utility::damagelocationisany("head", "helmet")) {
    if(self.var_EF) {} else {
      playdeathsound();
    }
  }

  if(var_2 && func_D469()) {
    return;
  }

  if(isDefined(self.var_10957)) {
    if([
        [self.var_10957]
      ]()) {
      return;
    }
  }

  if(func_10956()) {
    return;
  }

  var_3 = func_7E5F();
  func_CF0E(var_3);
}

func_58CB() {
  scripts\anim\shared::func_5D1A();
  self.var_10265 = 1;
  var_0 = 10;
  var_1 = scripts\engine\utility::getdamagetype(self.var_DE);
  if(isDefined(self.opcode::OP_EvalLocalVariableRefCached) && self.opcode::OP_EvalLocalVariableRefCached == level.player && var_1 == "melee") {
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

  self giverankxp_regularmp(self.var_DD, var_5);
  wait(0.05);
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
  if(self.var_DE == "MOD_MELEE" && isDefined(self.opcode::OP_EvalLocalVariableRefCached)) {
    var_0 = self.origin - self.var_4F.origin;
    var_1 = anglesToForward(self.angles);
    var_2 = vectornormalize((var_0[0], var_0[1], 0));
    var_3 = vectornormalize((var_1[0], var_1[1], 0));
    var_4 = func_B60C(var_3, var_2);
    var_5 = var_4 * 90;
    var_6 = (-1 * var_2[0], -1 * var_2[1], 0);
    var_7 = rotatevector(var_6, (0, var_5, 0));
    var_8 = vectortoyaw(var_7);
    self orientmode("face angle", var_8);
  }
}

func_CF0E(var_0) {
  if(!animhasnotetrack(var_0, "dropgun") && !animhasnotetrack(var_0, "fire_spray")) {
    scripts\anim\shared::func_5D1A();
  }

  func_C703();
  self _meth_82E4("deathanim", var_0, % body, 1, 0.1);
  scripts\anim\face::playfacialanim(var_0, "death");
  if(isDefined(self.var_10265)) {
    if(!isDefined(self.noragdoll)) {
      self giverankxp();
    }

    wait(0.05);
    self animmode("gravity");
  } else if(isDefined(self.ragdolltime)) {
    thread func_136DF(self.ragdolltime);
  } else if(!animhasnotetrack(var_0, "start_ragdoll")) {
    if(self.var_DE == "MOD_MELEE") {
      var_1 = 0.7;
    } else {
      var_1 = 0.35;
    }

    thread func_136DF(getanimlength(var_0) * var_1);
  }

  if(!isDefined(self.var_10265)) {
    thread playdeathfx();
  }

  scripts\anim\shared::donotetracks("deathanim");
  scripts\anim\shared::func_5D1A();
  self notify("endPlayDeathAnim");
}

func_136DF(var_0) {
  wait(var_0);
  if(isDefined(self)) {
    scripts\anim\shared::func_5D1A();
  }

  if(isDefined(self) && !isDefined(self.noragdoll)) {
    self giverankxp();
  }
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

func_10956() {
  if(self.a.var_10930 == "none") {
    return 0;
  }

  if(self.var_DE == "MOD_MELEE") {
    return 0;
  }

  switch (self.a.var_10930) {
    case "cover_right":
      if(self.a.pose == "stand") {
        var_0 = scripts\anim\utility::func_B027("death", "cover_right_stand");
        func_57FC(var_0);
      } else {
        var_0 = [];
        if(scripts\engine\utility::damagelocationisany("head", "neck")) {
          var_0 = scripts\anim\utility::func_B027("death", "cover_right_crouch_head");
        } else {
          var_0 = scripts\anim\utility::func_B027("death", "cover_right_crouch_default");
        }

        func_57FC(var_0);
      }
      return 1;

    case "cover_left":
      if(self.a.pose == "stand") {
        var_0 = scripts\anim\utility::func_B027("death", "cover_left_stand");
        func_57FC(var_0);
      } else {
        var_0 = scripts\anim\utility::func_B027("death", "cover_left_crouch");
        func_57FC(var_0);
      }
      return 1;

    case "cover_stand":
      var_0 = scripts\anim\utility::func_B027("death", "cover_stand");
      func_57FC(var_0);
      return 1;

    case "cover_crouch":
      var_0 = [];
      if(scripts\engine\utility::damagelocationisany("head", "neck") && self.var_E3 > 135 || self.var_E3 <= -45) {
        var_0[var_0.size] = ::scripts\anim\utility::func_B027("death", "cover_crouch_head");
      }

      if(self.var_E3 > -45 && self.var_E3 <= 45) {
        var_0[var_0.size] = ::scripts\anim\utility::func_B027("death", "cover_crouch_back");
      }

      var_0[var_0.size] = ::scripts\anim\utility::func_B027("death", "cover_crouch_default");
      func_57FC(var_0);
      return 1;

    case "saw":
      if(self.a.pose == "stand") {
        func_57FC(scripts\anim\utility::func_B027("death", "saw_stand"));
      } else if(self.a.pose == "crouch") {
        func_57FC(scripts\anim\utility::func_B027("death", "saw_crouch"));
      } else {
        func_57FC(scripts\anim\utility::func_B027("death", "saw_prone"));
      }
      return 1;

    case "dying_crawl":
      if(isDefined(self.a.onback) && self.a.pose == "crouch") {
        var_0 = scripts\anim\utility::func_B027("death", "dying_crawl_crouch");
        func_57FC(var_0);
      } else {
        var_0 = scripts\anim\utility::func_B027("death", "dying_crawl_prone");
        func_57FC(var_0);
      }
      return 1;

    case "stumbling_pain":
      func_CF0E(self.a.var_11188[self.a.var_11188.size - 1]);
      return 1;
  }

  return 0;
}

func_57FC(var_0) {
  var_1 = var_0[randomint(var_0.size)];
  func_CF0E(var_1);
  if(isDefined(self.var_4E2E)) {
    self[[self.var_4E2E]]();
  }
}

playdeathsound() {
  scripts\anim\face::saygenericdialogue("death");
}

func_D8ED(var_0, var_1, var_2) {
  var_3 = var_2 * 20;
  for(var_4 = 0; var_4 < var_3; var_4++) {
    wait(0.05);
  }
}

func_8E17() {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.hatmodel)) {
    return;
  }

  var_0 = getpartname(self.hatmodel, 0);
  var_1 = spawn("script_model", self.origin + (0, 0, 64));
  var_1 setModel(self.hatmodel);
  var_1.origin = self gettagorigin(var_0);
  var_1.angles = self gettagangles(var_0);
  var_1 thread func_8E13(self.var_DC);
  var_2 = self.hatmodel;
  self.hatmodel = undefined;
  wait(0.05);
  if(!isDefined(self)) {
    return;
  }

  self detach(var_2, "");
}

func_8E13(var_0) {
  var_1 = var_0;
  var_1 = var_1 * randomfloatrange(2000, 4000);
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_4 = randomfloatrange(1500, 3000);
  var_5 = self.origin + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)) * 5;
  self physicslaunchclient(var_5, (var_2, var_3, var_4));
  wait(60);
  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    if(distancesquared(self.origin, level.player.origin) > 262144) {
      break;
    }

    wait(30);
  }

  self delete();
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

func_FFF4() {
  if(self.a.movement != "run") {
    return 0;
  }

  if(self getspawnpoint_searchandrescue() > 60 || self getspawnpoint_searchandrescue() < -60) {
    return 0;
  }

  if(self.var_DE == "MOD_MELEE") {
    return 0;
  }

  return 1;
}

func_FFFA(var_0, var_1, var_2, var_3) {
  if(isDefined(self.a.var_58DA)) {
    return 0;
  }

  if(self.a.pose == "prone" || isDefined(self.a.onback)) {
    return 0;
  }

  if(var_0 == "none") {
    return 0;
  }

  if(var_2 > 500) {
    return 1;
  }

  if(var_1 == "MOD_MELEE") {
    return 0;
  }

  if(self.a.movement == "run" && !func_9D59(var_3, 275)) {
    if(randomint(100) < 65) {
      return 0;
    }
  }

  if(scripts\anim\utility_common::issniperrifle(var_0) && self.maxhealth < var_2) {
    return 1;
  }

  if(scripts\anim\utility_common::isshotgun(var_0) && func_9D59(var_3, 512)) {
    return 1;
  }

  if(isdepot(var_0) && func_9D59(var_3, 425)) {
    return 1;
  }

  return 0;
}

isdepot(var_0) {
  if(var_0 == "deserteagle") {
    return 1;
  }

  return 0;
}

func_9D59(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(distancesquared(self.origin, var_0.origin) > var_1 * var_1) {
    return 0;
  }

  return 1;
}

func_7E5F() {
  if(func_FFFA(self.var_E2, self.var_DE, self.var_E1, self.opcode::OP_EvalLocalVariableRefCached)) {
    var_0 = giveweapon();
    if(isDefined(var_0)) {
      return var_0;
    }
  }

  if(isDefined(self.a.onback)) {
    if(self.a.pose == "crouch") {
      return func_7DF1();
    } else {
      scripts\anim\notetracks::stoponback();
    }
  }

  if(self.a.pose == "stand") {
    if(func_FFF4()) {
      return getsafeanimmovedeltapercentage();
    }

    return getspectatingplayer();
  }

  if(self.a.pose == "crouch") {
    return func_7E45();
  }

  if(self.a.pose == "prone") {
    return _meth_809F();
  }
}

giveweapon() {
  var_0 = abs(self.var_E3);
  if(var_0 < 45) {
    return;
  }

  if(var_0 > 150) {
    if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot")) {
      var_1 = scripts\anim\utility::func_B027("death", "strong_legs");
    } else if(self.var_DD == "torso_lower") {
      var_1 = scripts\anim\utility::func_B027("death", "strong_torso_lower");
    } else {
      var_1 = scripts\anim\utility::func_B027("death", "strong_default");
    }
  } else if(self.var_E3 < 0) {
    var_1 = scripts\anim\utility::func_B027("death", "strong_right");
  } else {
    var_1 = scripts\anim\utility::func_B027("death", "strong_left");
  }

  return var_1[randomint(var_1.size)];
}

getsafeanimmovedeltapercentage() {
  if(abs(self.var_E3) < 45) {
    var_0 = scripts\anim\utility::func_B027("death", "running_forward_f");
    var_1 = _meth_80C3(var_0);
    if(isDefined(var_1)) {
      return var_1;
    }
  }

  var_0 = scripts\anim\utility::func_B027("death", "running_forward");
  var_1 = _meth_80C3(var_0);
  if(isDefined(var_1)) {
    return var_1;
  }

  return getspectatingplayer();
}

_meth_80C3(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = undefined;
  for(var_2 = var_0.size; var_2 > 0; var_2--) {
    var_3 = randomint(var_2);
    var_1 = var_0[var_3];
    if(!func_9D42(var_1)) {
      return var_1;
    }

    var_0[var_3] = var_0[var_2 - 1];
    var_0[var_2 - 1] = undefined;
  }

  return undefined;
}

func_E184(var_0) {
  var_1 = [];
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!isDefined(var_0[var_2])) {
      continue;
    }

    var_1[var_1.size] = var_0[var_2];
  }

  return var_1;
}

func_9D42(var_0) {
  var_1 = 1;
  if(animhasnotetrack(var_0, "code_move")) {
    var_1 = getnotetracktimes(var_0, "code_move")[0];
  }

  var_2 = getmovedelta(var_0, 0, var_1);
  var_3 = self gettweakablevalue(var_2);
  return !self maymovetopoint(var_3, 1, 1);
}

gettagangles() {
  var_0 = [];
  if(abs(self.var_E3) < 50) {
    var_0 = scripts\anim\utility::func_B027("death", "stand_pistol_forward");
  } else {
    if(abs(self.var_E3) < 110) {
      var_0 = scripts\anim\utility::func_B027("death", "stand_pistol_front");
    }

    if(self.var_DD == "torso_upper") {
      var_0 = scripts\engine\utility::array_combine(scripts\anim\utility::func_B027("death", "stand_pistol_torso_upper"), var_0);
    } else if(scripts\engine\utility::damagelocationisany("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
      var_0 = scripts\engine\utility::array_combine(scripts\anim\utility::func_B027("death", "stand_pistol_torso_upper"), var_0);
    }

    if(!scripts\engine\utility::damagelocationisany("head", "neck", "helmet", "left_foot", "right_foot", "left_hand", "right_hand", "gun") && randomint(2) == 0) {
      var_0 = scripts\engine\utility::array_combine(scripts\anim\utility::func_B027("death", "stand_pistol_upper_body"), var_0);
    }

    if(var_0.size == 0 || scripts\engine\utility::damagelocationisany("torso_lower", "torso_upper", "neck", "head", "helmet", "right_arm_upper", "left_arm_upper")) {
      var_0 = scripts\engine\utility::array_combine(scripts\anim\utility::func_B027("death", "stand_pistol_default"), var_0);
    }
  }

  return var_0;
}

getspectatingplayer() {
  var_0 = [];
  var_1 = [];
  if(scripts\anim\utility_common::isusingsidearm()) {
    var_0 = gettagangles();
  } else if(isDefined(self.opcode::OP_EvalLocalVariableRefCached) && self givenextgun(self.opcode::OP_EvalLocalVariableRefCached)) {
    if(self.var_E3 <= 120 || self.var_E3 > -120) {
      var_0 = scripts\anim\utility::func_B027("death", "melee_standing_front");
    } else if(self.var_E3 <= -60 && self.var_E3 > 60) {
      var_0 = scripts\anim\utility::func_B027("death", "melee_standing_back");
    } else if(self.var_E3 < 0) {
      var_0 = scripts\anim\utility::func_B027("death", "melee_standing_left");
    } else {
      var_0 = scripts\anim\utility::func_B027("death", "melee_standing_right");
    }
  } else {
    if(scripts\engine\utility::damagelocationisany("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_lower", "right_leg_lower")) {
      var_0 = scripts\anim\utility::func_B027("death", "stand_lower_body");
      var_1 = scripts\anim\utility::func_B027("death", "stand_lower_body_extended");
    } else if(scripts\engine\utility::damagelocationisany("head", "helmet")) {
      var_0 = scripts\anim\utility::func_B027("death", "stand_head");
    } else if(scripts\engine\utility::damagelocationisany("neck")) {
      var_0 = scripts\anim\utility::func_B027("death", "stand_neck");
    } else if(scripts\engine\utility::damagelocationisany("torso_upper", "left_arm_upper")) {
      var_0 = scripts\anim\utility::func_B027("death", "stand_left_shoulder");
    }

    if(scripts\engine\utility::damagelocationisany("torso_upper")) {
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility::func_B027("death", "stand_torso_upper"));
      var_1 = scripts\engine\utility::array_combine(var_1, scripts\anim\utility::func_B027("death", "stand_torso_upper_extended"));
    }

    if(self.var_E3 > 135 || self.var_E3 <= -135) {
      if(scripts\engine\utility::damagelocationisany("neck", "head", "helmet")) {
        var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility::func_B027("death", "stand_front_torso"));
        var_1 = scripts\engine\utility::array_combine(var_1, scripts\anim\utility::func_B027("death", "stand_front_torso_extended"));
      }

      if(scripts\engine\utility::damagelocationisany("torso_upper")) {
        var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility::func_B027("death", "stand_front_torso"));
        var_1 = scripts\engine\utility::array_combine(var_1, scripts\anim\utility::func_B027("death", "stand_front_torso_extended"));
      }
    } else if(self.var_E3 > -45 && self.var_E3 <= 45) {
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility::func_B027("death", "stand_back"));
    }

    var_2 = var_0.size > 0;
    if(!var_2 || randomint(100) < 15) {
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility::func_B027("death", "stand_default"));
    }

    if(randomint(100) < 10 && func_6DB2()) {
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility::func_B027("death", "stand_default_firing"));
      var_0 = func_E184(var_0);
    }
  }

  if(var_0.size == 0) {
    var_0[var_0.size] = ::scripts\anim\utility::func_B027("death", "stand_backup_default");
  }

  if(!self.a.disablelongdeath && self.getcsplinepointtargetname == "none" && !isDefined(self.a.var_C87B)) {
    var_3 = randomint(var_0.size + var_1.size);
    if(var_3 < var_0.size) {
      return var_0[var_3];
    } else {
      return var_1[var_3 - var_0.size];
    }
  }

  return var_0[randomint(var_0.size)];
}

func_7E45() {
  var_0 = [];
  if(isDefined(self.opcode::OP_EvalLocalVariableRefCached) && self givenextgun(self.opcode::OP_EvalLocalVariableRefCached)) {
    if(self.var_E3 <= 120 || self.var_E3 > -120) {
      var_0 = scripts\anim\utility::func_B027("death", "melee_crouching_front");
    } else if(self.var_E3 <= -60 && self.var_E3 > 60) {
      var_0 = scripts\anim\utility::func_B027("death", "melee_crouching_back");
    } else if(self.var_E3 < 0) {
      var_0 = scripts\anim\utility::func_B027("death", "melee_crouching_left");
    } else {
      var_0 = scripts\anim\utility::func_B027("death", "melee_crouching_right");
    }
  } else {
    if(scripts\engine\utility::damagelocationisany("head", "neck")) {
      var_0 = scripts\anim\utility::func_B027("death", "crouch_head");
    }

    if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck")) {
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility::func_B027("death", "crouch_torso"));
    }

    if(var_0.size < 2) {
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility::func_B027("death", "crouch_default1"));
    }

    if(var_0.size < 2) {
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility::func_B027("death", "crouch_default2"));
    }
  }

  return var_0[randomint(var_0.size)];
}

_meth_809F() {}

func_7DF1() {}

func_6DB2() {
  if(!isDefined(self.var_394) || !scripts\anim\utility_common::usingriflelikeweapon() || !weaponisauto(self.var_394) || !weaponisbeam(self.var_394) || self.var_EF) {
    return 0;
  }

  if(self.a.weaponpos["right"] == "none") {
    return 0;
  }

  return 1;
}

func_1288D(var_0) {
  return var_0;
}

func_1288E(var_0) {
  return var_0;
}

func_D469() {
  if(isDefined(self.var_A4A3)) {
    return 0;
  }

  if(self.var_DD != "none") {
    return 0;
  }
}