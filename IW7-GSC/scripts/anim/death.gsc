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
  var_00 = 0.3;
  self clearanim( % scripted_talking, var_00);
  scripts\sp\anim::func_55C7(0);
  if(self.a.nodeath == 1) {
    return;
  }

  if(isDefined(self.var_4E46)) {
    var_01 = self[[self.var_4E46]]();
    if(!isDefined(var_01)) {
      var_01 = 1;
    }

    if(var_01) {
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

  var_02 = scripts\anim\pain::func_1390C();
  if(self.var_DD == "helmet" || self.var_DD == "head") {
    func_8E17();
  } else if(var_02 && randomint(3) == 0) {
    func_8E17();
  }

  self clearanim( % root, 0.3);
  if(!scripts\engine\utility::damagelocationisany("head", "helmet")) {
    if(self.var_EF) {} else {
      playdeathsound();
    }
  }

  if(var_02 && func_D469()) {
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

  var_03 = func_7E5F();
  func_CF0E(var_03);
}

func_58CB() {
  scripts\anim\shared::func_5D1A();
  self.var_10265 = 1;
  var_00 = 10;
  var_01 = scripts\engine\utility::getdamagetype(self.var_DE);
  if(isDefined(self.opcode::OP_EvalLocalVariableRefCached) && self.opcode::OP_EvalLocalVariableRefCached == level.player && var_01 == "melee") {
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

  self giverankxp_regularmp(self.var_DD, var_05);
  wait(0.05);
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
  if(self.var_DE == "MOD_MELEE" && isDefined(self.opcode::OP_EvalLocalVariableRefCached)) {
    var_00 = self.origin - self.var_4F.origin;
    var_01 = anglesToForward(self.angles);
    var_02 = vectornormalize((var_00[0], var_00[1], 0));
    var_03 = vectornormalize((var_01[0], var_01[1], 0));
    var_04 = func_B60C(var_03, var_02);
    var_05 = var_04 * 90;
    var_06 = (-1 * var_02[0], -1 * var_02[1], 0);
    var_07 = rotatevector(var_06, (0, var_05, 0));
    var_08 = vectortoyaw(var_07);
    self orientmode("face angle", var_08);
  }
}

func_CF0E(param_00) {
  if(!animhasnotetrack(param_00, "dropgun") && !animhasnotetrack(param_00, "fire_spray")) {
    scripts\anim\shared::func_5D1A();
  }

  func_C703();
  self _meth_82E4("deathanim", param_00, % body, 1, 0.1);
  scripts\anim\face::playfacialanim(param_00, "death");
  if(isDefined(self.var_10265)) {
    if(!isDefined(self.noragdoll)) {
      self giverankxp();
    }

    wait(0.05);
    self animmode("gravity");
  } else if(isDefined(self.ragdolltime)) {
    thread func_136DF(self.ragdolltime);
  } else if(!animhasnotetrack(param_00, "start_ragdoll")) {
    if(self.var_DE == "MOD_MELEE") {
      var_01 = 0.7;
    } else {
      var_01 = 0.35;
    }

    thread func_136DF(getanimlength(param_00) * var_01);
  }

  if(!isDefined(self.var_10265)) {
    thread playdeathfx();
  }

  scripts\anim\shared::donotetracks("deathanim");
  scripts\anim\shared::func_5D1A();
  self notify("endPlayDeathAnim");
}

func_136DF(param_00) {
  wait(param_00);
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
        var_00 = scripts\anim\utility::func_B027("death", "cover_right_stand");
        func_57FC(var_00);
      } else {
        var_00 = [];
        if(scripts\engine\utility::damagelocationisany("head", "neck")) {
          var_00 = scripts\anim\utility::func_B027("death", "cover_right_crouch_head");
        } else {
          var_00 = scripts\anim\utility::func_B027("death", "cover_right_crouch_default");
        }

        func_57FC(var_00);
      }
      return 1;

    case "cover_left":
      if(self.a.pose == "stand") {
        var_00 = scripts\anim\utility::func_B027("death", "cover_left_stand");
        func_57FC(var_00);
      } else {
        var_00 = scripts\anim\utility::func_B027("death", "cover_left_crouch");
        func_57FC(var_00);
      }
      return 1;

    case "cover_stand":
      var_00 = scripts\anim\utility::func_B027("death", "cover_stand");
      func_57FC(var_00);
      return 1;

    case "cover_crouch":
      var_00 = [];
      if(scripts\engine\utility::damagelocationisany("head", "neck") && self.var_E3 > 135 || self.var_E3 <= -45) {
        var_00[var_00.size] = scripts\anim\utility::func_B027("death", "cover_crouch_head");
      }

      if(self.var_E3 > -45 && self.var_E3 <= 45) {
        var_00[var_00.size] = scripts\anim\utility::func_B027("death", "cover_crouch_back");
      }

      var_00[var_00.size] = scripts\anim\utility::func_B027("death", "cover_crouch_default");
      func_57FC(var_00);
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
        var_00 = scripts\anim\utility::func_B027("death", "dying_crawl_crouch");
        func_57FC(var_00);
      } else {
        var_00 = scripts\anim\utility::func_B027("death", "dying_crawl_prone");
        func_57FC(var_00);
      }
      return 1;

    case "stumbling_pain":
      func_CF0E(self.a.var_11188[self.a.var_11188.size - 1]);
      return 1;
  }

  return 0;
}

func_57FC(param_00) {
  var_01 = param_00[randomint(param_00.size)];
  func_CF0E(var_01);
  if(isDefined(self.var_4E2E)) {
    self[[self.var_4E2E]]();
  }
}

playdeathsound() {
  scripts\anim\face::saygenericdialogue("death");
}

func_D8ED(param_00, param_01, param_02) {
  var_03 = param_02 * 20;
  for(var_04 = 0; var_04 < var_03; var_04++) {
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

  var_00 = getpartname(self.hatmodel, 0);
  var_01 = spawn("script_model", self.origin + (0, 0, 64));
  var_01 setModel(self.hatmodel);
  var_01.origin = self gettagorigin(var_00);
  var_01.angles = self gettagangles(var_00);
  var_01 thread func_8E13(self.var_DC);
  var_02 = self.hatmodel;
  self.hatmodel = undefined;
  wait(0.05);
  if(!isDefined(self)) {
    return;
  }

  self detach(var_02, "");
}

func_8E13(param_00) {
  var_01 = param_00;
  var_01 = var_01 * randomfloatrange(2000, 4000);
  var_02 = var_01[0];
  var_03 = var_01[1];
  var_04 = randomfloatrange(1500, 3000);
  var_05 = self.origin + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)) * 5;
  self physicslaunchclient(var_05, (var_02, var_03, var_04));
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

func_FFFA(param_00, param_01, param_02, param_03) {
  if(isDefined(self.a.var_58DA)) {
    return 0;
  }

  if(self.a.pose == "prone" || isDefined(self.a.onback)) {
    return 0;
  }

  if(param_00 == "none") {
    return 0;
  }

  if(param_02 > 500) {
    return 1;
  }

  if(param_01 == "MOD_MELEE") {
    return 0;
  }

  if(self.a.movement == "run" && !func_9D59(param_03, 275)) {
    if(randomint(100) < 65) {
      return 0;
    }
  }

  if(scripts\anim\utility_common::issniperrifle(param_00) && self.maxhealth < param_02) {
    return 1;
  }

  if(scripts\anim\utility_common::isshotgun(param_00) && func_9D59(param_03, 512)) {
    return 1;
  }

  if(isdepot(param_00) && func_9D59(param_03, 425)) {
    return 1;
  }

  return 0;
}

isdepot(param_00) {
  if(param_00 == "deserteagle") {
    return 1;
  }

  return 0;
}

func_9D59(param_00, param_01) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(distancesquared(self.origin, param_00.origin) > param_01 * param_01) {
    return 0;
  }

  return 1;
}

func_7E5F() {
  if(func_FFFA(self.var_E2, self.var_DE, self.var_E1, self.opcode::OP_EvalLocalVariableRefCached)) {
    var_00 = giveweapon();
    if(isDefined(var_00)) {
      return var_00;
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
  var_00 = abs(self.var_E3);
  if(var_00 < 45) {
    return;
  }

  if(var_00 > 150) {
    if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot")) {
      var_01 = scripts\anim\utility::func_B027("death", "strong_legs");
    } else if(self.var_DD == "torso_lower") {
      var_01 = scripts\anim\utility::func_B027("death", "strong_torso_lower");
    } else {
      var_01 = scripts\anim\utility::func_B027("death", "strong_default");
    }
  } else if(self.var_E3 < 0) {
    var_01 = scripts\anim\utility::func_B027("death", "strong_right");
  } else {
    var_01 = scripts\anim\utility::func_B027("death", "strong_left");
  }

  return var_01[randomint(var_01.size)];
}

getsafeanimmovedeltapercentage() {
  if(abs(self.var_E3) < 45) {
    var_00 = scripts\anim\utility::func_B027("death", "running_forward_f");
    var_01 = _meth_80C3(var_00);
    if(isDefined(var_01)) {
      return var_01;
    }
  }

  var_00 = scripts\anim\utility::func_B027("death", "running_forward");
  var_01 = _meth_80C3(var_00);
  if(isDefined(var_01)) {
    return var_01;
  }

  return getspectatingplayer();
}

_meth_80C3(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  var_01 = undefined;
  for(var_02 = param_00.size; var_02 > 0; var_02--) {
    var_03 = randomint(var_02);
    var_01 = param_00[var_03];
    if(!func_9D42(var_01)) {
      return var_01;
    }

    param_00[var_03] = param_00[var_02 - 1];
    param_00[var_02 - 1] = undefined;
  }

  return undefined;
}

func_E184(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    if(!isDefined(param_00[var_02])) {
      continue;
    }

    var_01[var_01.size] = param_00[var_02];
  }

  return var_01;
}

func_9D42(param_00) {
  var_01 = 1;
  if(animhasnotetrack(param_00, "code_move")) {
    var_01 = getnotetracktimes(param_00, "code_move")[0];
  }

  var_02 = getmovedelta(param_00, 0, var_01);
  var_03 = self gettweakablevalue(var_02);
  return !self maymovetopoint(var_03, 1, 1);
}

gettagangles() {
  var_00 = [];
  if(abs(self.var_E3) < 50) {
    var_00 = scripts\anim\utility::func_B027("death", "stand_pistol_forward");
  } else {
    if(abs(self.var_E3) < 110) {
      var_00 = scripts\anim\utility::func_B027("death", "stand_pistol_front");
    }

    if(self.var_DD == "torso_upper") {
      var_00 = scripts\engine\utility::array_combine(scripts\anim\utility::func_B027("death", "stand_pistol_torso_upper"), var_00);
    } else if(scripts\engine\utility::damagelocationisany("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
      var_00 = scripts\engine\utility::array_combine(scripts\anim\utility::func_B027("death", "stand_pistol_torso_upper"), var_00);
    }

    if(!scripts\engine\utility::damagelocationisany("head", "neck", "helmet", "left_foot", "right_foot", "left_hand", "right_hand", "gun") && randomint(2) == 0) {
      var_00 = scripts\engine\utility::array_combine(scripts\anim\utility::func_B027("death", "stand_pistol_upper_body"), var_00);
    }

    if(var_00.size == 0 || scripts\engine\utility::damagelocationisany("torso_lower", "torso_upper", "neck", "head", "helmet", "right_arm_upper", "left_arm_upper")) {
      var_00 = scripts\engine\utility::array_combine(scripts\anim\utility::func_B027("death", "stand_pistol_default"), var_00);
    }
  }

  return var_00;
}

getspectatingplayer() {
  var_00 = [];
  var_01 = [];
  if(scripts\anim\utility_common::isusingsidearm()) {
    var_00 = gettagangles();
  } else if(isDefined(self.opcode::OP_EvalLocalVariableRefCached) && self givenextgun(self.opcode::OP_EvalLocalVariableRefCached)) {
    if(self.var_E3 <= 120 || self.var_E3 > -120) {
      var_00 = scripts\anim\utility::func_B027("death", "melee_standing_front");
    } else if(self.var_E3 <= -60 && self.var_E3 > 60) {
      var_00 = scripts\anim\utility::func_B027("death", "melee_standing_back");
    } else if(self.var_E3 < 0) {
      var_00 = scripts\anim\utility::func_B027("death", "melee_standing_left");
    } else {
      var_00 = scripts\anim\utility::func_B027("death", "melee_standing_right");
    }
  } else {
    if(scripts\engine\utility::damagelocationisany("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_lower", "right_leg_lower")) {
      var_00 = scripts\anim\utility::func_B027("death", "stand_lower_body");
      var_01 = scripts\anim\utility::func_B027("death", "stand_lower_body_extended");
    } else if(scripts\engine\utility::damagelocationisany("head", "helmet")) {
      var_00 = scripts\anim\utility::func_B027("death", "stand_head");
    } else if(scripts\engine\utility::damagelocationisany("neck")) {
      var_00 = scripts\anim\utility::func_B027("death", "stand_neck");
    } else if(scripts\engine\utility::damagelocationisany("torso_upper", "left_arm_upper")) {
      var_00 = scripts\anim\utility::func_B027("death", "stand_left_shoulder");
    }

    if(scripts\engine\utility::damagelocationisany("torso_upper")) {
      var_00 = scripts\engine\utility::array_combine(var_00, scripts\anim\utility::func_B027("death", "stand_torso_upper"));
      var_01 = scripts\engine\utility::array_combine(var_01, scripts\anim\utility::func_B027("death", "stand_torso_upper_extended"));
    }

    if(self.var_E3 > 135 || self.var_E3 <= -135) {
      if(scripts\engine\utility::damagelocationisany("neck", "head", "helmet")) {
        var_00 = scripts\engine\utility::array_combine(var_00, scripts\anim\utility::func_B027("death", "stand_front_torso"));
        var_01 = scripts\engine\utility::array_combine(var_01, scripts\anim\utility::func_B027("death", "stand_front_torso_extended"));
      }

      if(scripts\engine\utility::damagelocationisany("torso_upper")) {
        var_00 = scripts\engine\utility::array_combine(var_00, scripts\anim\utility::func_B027("death", "stand_front_torso"));
        var_01 = scripts\engine\utility::array_combine(var_01, scripts\anim\utility::func_B027("death", "stand_front_torso_extended"));
      }
    } else if(self.var_E3 > -45 && self.var_E3 <= 45) {
      var_00 = scripts\engine\utility::array_combine(var_00, scripts\anim\utility::func_B027("death", "stand_back"));
    }

    var_02 = var_00.size > 0;
    if(!var_02 || randomint(100) < 15) {
      var_00 = scripts\engine\utility::array_combine(var_00, scripts\anim\utility::func_B027("death", "stand_default"));
    }

    if(randomint(100) < 10 && func_6DB2()) {
      var_00 = scripts\engine\utility::array_combine(var_00, scripts\anim\utility::func_B027("death", "stand_default_firing"));
      var_00 = func_E184(var_00);
    }
  }

  if(var_00.size == 0) {
    var_00[var_00.size] = scripts\anim\utility::func_B027("death", "stand_backup_default");
  }

  if(!self.a.disablelongdeath && self.getcsplinepointtargetname == "none" && !isDefined(self.a.var_C87B)) {
    var_03 = randomint(var_00.size + var_01.size);
    if(var_03 < var_00.size) {
      return var_00[var_03];
    } else {
      return var_01[var_03 - var_00.size];
    }
  }

  return var_00[randomint(var_00.size)];
}

func_7E45() {
  var_00 = [];
  if(isDefined(self.opcode::OP_EvalLocalVariableRefCached) && self givenextgun(self.opcode::OP_EvalLocalVariableRefCached)) {
    if(self.var_E3 <= 120 || self.var_E3 > -120) {
      var_00 = scripts\anim\utility::func_B027("death", "melee_crouching_front");
    } else if(self.var_E3 <= -60 && self.var_E3 > 60) {
      var_00 = scripts\anim\utility::func_B027("death", "melee_crouching_back");
    } else if(self.var_E3 < 0) {
      var_00 = scripts\anim\utility::func_B027("death", "melee_crouching_left");
    } else {
      var_00 = scripts\anim\utility::func_B027("death", "melee_crouching_right");
    }
  } else {
    if(scripts\engine\utility::damagelocationisany("head", "neck")) {
      var_00 = scripts\anim\utility::func_B027("death", "crouch_head");
    }

    if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck")) {
      var_00 = scripts\engine\utility::array_combine(var_00, scripts\anim\utility::func_B027("death", "crouch_torso"));
    }

    if(var_00.size < 2) {
      var_00 = scripts\engine\utility::array_combine(var_00, scripts\anim\utility::func_B027("death", "crouch_default1"));
    }

    if(var_00.size < 2) {
      var_00 = scripts\engine\utility::array_combine(var_00, scripts\anim\utility::func_B027("death", "crouch_default2"));
    }
  }

  return var_00[randomint(var_00.size)];
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

func_1288D(param_00) {
  return param_00;
}

func_1288E(param_00) {
  return param_00;
}

func_D469() {
  if(isDefined(self.var_A4A3)) {
    return 0;
  }

  if(self.var_DD != "none") {
    return 0;
  }
}