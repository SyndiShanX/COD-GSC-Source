/************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\utility.gsc
************************************/

func_97CF(param_00) {
  self clearanim( % body, 0.3);
  self give_attacker_kill_rewards( % body, 1, 0);
  if(param_00 != "pain" && param_00 != "death") {
    self.a.var_10930 = "none";
  }

  self.a.var_1A4B = 1;
  self.a.var_1A4D = 1;
  self.a.var_1A4C = 1;
  self.a.var_1A4F = 0;
  self.a.var_1A4E = 0;
  func_12EB9();
}

func_12E5F() {
  if(isDefined(self.var_5270) && self.var_5270 != self.a.pose) {
    if(self.a.pose == "prone") {
      exitpronewrapper(0.5);
    }

    if(self.var_5270 == "prone") {
      self give_run_perk(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
      enterpronewrapper(0.5);
      self _meth_82A5(func_B027("default_prone", "straight_level"), % body, 1, 0.1, 1);
    }
  }

  self.var_5270 = undefined;
}

func_9832(param_00) {
  if(getdvarint("ai_iw7", 0) == 1) {
    self endon("killanimscript");
    self waittill("Hellfreezesover");
    return;
  }

  if(isDefined(self.var_AFE7)) {
    if(param_00 != "pain" && param_00 != "death") {
      self _meth_81D0(self.origin);
    }

    if(param_00 != "pain") {
      self.var_AFE7 = undefined;
      self notify("kill_long_death");
    }
  }

  if(isDefined(self.a.var_B4E7) && param_00 != "death") {
    self _meth_81D0(self.origin);
  }

  if(isDefined(self.a.var_D707)) {
    var_01 = self.a.var_D707;
    self.a.var_D707 = undefined;
    [[var_01]](param_00);
  }

  if(param_00 != "combat" && param_00 != "pain" && param_00 != "death" && scripts\anim\utility_common::isusingsidearm()) {
    scripts\anim\combat::func_11380(func_B027("combat", "pistol_to_primary"), 1);
  }

  if(param_00 != "combat" && param_00 != "move" && param_00 != "pain") {
    self.a.var_B168 = undefined;
  }

  if(param_00 != "death") {
    self.a.nodeath = 0;
  }

  if(isDefined(self.var_9E33) && param_00 == "pain" || param_00 == "death" || param_00 == "flashed") {
    scripts\anim\combat_utility::func_5D29();
  }

  self.var_9E33 = undefined;
  scripts\anim\squadmanager::func_1B0E(param_00);
  self.covernode = undefined;
  self.var_112C8 = 0;
  self.isreloading = 0;
  self.var_3C60 = 0;
  self.a.var_1A3E = undefined;
  self.a.var_EF87 = gettime();
  self.a.var_2411 = 0;
  if(isDefined(self.target_getindexoftarget) && self.target_getindexoftarget.type == "Conceal Prone" || self.target_getindexoftarget.type == "Conceal Crouch" || self.target_getindexoftarget.type == "Conceal Stand") {
    self.a.var_2411 = 1;
  }

  func_97CF(param_00);
  func_12E5F();
}

detachall() {
  if(isDefined(self.var_138DF) && self.var_138DF) {
    if(scripts\anim\utility_common::isshotgun(self.primaryweapon)) {
      return self.primaryweapon;
    } else if(scripts\anim\utility_common::isshotgun(self.secondaryweapon)) {
      return self.secondaryweapon;
    }
  }

  return self.primaryweapon;
}

func_2758(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < param_00 * 20; var_03++) {
    for(var_04 = 0; var_04 < 10; var_04++) {
      var_05 = (0, randomint(360), 0);
      var_06 = anglesToForward(var_05);
      var_07 = var_06 * param_02;
    }

    wait(0.05);
  }
}

func_D912() {
  self endon("death");
  self notify("displaceprint");
  self endon("displaceprint");
  wait(0.05);
}

func_9E40(param_00) {
  if((!isDefined(param_00) || param_00) && self.opcode::OP_GetThisthread > 1) {
    return 1;
  }

  if(isDefined(self.isnodeoccupied)) {
    return 1;
  }

  return self.a.combatendtime > gettime();
}

func_12EB9() {
  if(isDefined(self.isnodeoccupied)) {
    self.a.combatendtime = gettime() + level.combatidlepreventoverlappingplayer + randomint(level.combatmemorytimeconst);
  }
}

_meth_824E(param_00, param_01) {
  var_02 = self gettagangles(param_00)[1] - scripts\anim\utility_common::getyawfromorigin(param_01, self gettagorigin(param_00));
  var_02 = angleclamp180(var_02);
  return var_02;
}

func_7EAD(param_00) {
  var_01 = self gettagangles("TAG_EYE")[1] - scripts\engine\utility::getyaw(param_00);
  var_01 = angleclamp180(var_01);
  return var_01;
}

func_9F75(param_00) {
  if(isDefined(self.covernode)) {
    return self.covernode getrandomattachments(param_00);
  }

  return self getteleportlonertargetplayer(param_00);
}

func_3EF2(param_00) {
  if(!isDefined(param_00)) {
    param_00 = self.a.pose;
  }

  switch (param_00) {
    case "stand":
      if(func_9F75("stand")) {
        var_01 = "stand";
      } else if(func_9F75("crouch")) {
        var_01 = "crouch";
      } else if(func_9F75("prone")) {
        var_01 = "prone";
      } else {
        var_01 = "stand";
      }
      break;

    case "crouch":
      if(func_9F75("crouch")) {
        var_01 = "crouch";
      } else if(func_9F75("stand")) {
        var_01 = "stand";
      } else if(func_9F75("prone")) {
        var_01 = "prone";
      } else {
        var_01 = "crouch";
      }
      break;

    case "prone":
      if(func_9F75("prone")) {
        var_01 = "prone";
      } else if(func_9F75("crouch")) {
        var_01 = "crouch";
      } else if(func_9F75("stand")) {
        var_01 = "stand";
      } else {
        var_01 = "prone";
      }
      break;

    default:
      var_01 = "stand";
      break;
  }

  return var_01;
}

func_CEA8(param_00) {
  if(isDefined(param_00)) {
    self _meth_82E4("playAnim", param_00, % root, 1, 0.1, 1);
    var_01 = getanimlength(param_00);
    var_01 = 3 * var_01 + 1;
    thread func_C15B("time is up", "time is up", var_01);
    self waittill("time is up");
    self notify("enddrawstring");
  }
}

func_C15B(param_00, param_01, param_02) {
  self endon("death");
  self endon(param_01);
  wait(param_02);
  self notify(param_00);
}

func_5B86(param_00) {
  self endon("killanimscript");
  self endon("enddrawstring");
  wait(0.05);
}

func_5B87(param_00, param_01, param_02, param_03) {
  var_04 = param_03 * 20;
  for(var_05 = 0; var_05 < var_04; var_05++) {
    wait(0.05);
  }
}

func_10136(param_00) {
  self notify("got known enemy2");
  self endon("got known enemy2");
  self endon("death");
  if(!isDefined(self.isnodeoccupied)) {
    return;
  }

  if(self.isnodeoccupied.team == "allies") {
    var_01 = (0.4, 0.7, 1);
  } else {
    var_01 = (1, 0.7, 0.4);
  }

  for(;;) {
    wait(0.05);
    if(!isDefined(self.setignoremegroup)) {
      continue;
    }
  }
}

func_8BED() {
  if(isDefined(self.target_getindexoftarget)) {
    return scripts\anim\utility_common::canseeenemyfromexposed() || scripts\anim\utility_common::cansuppressenemyfromexposed();
  }

  return scripts\anim\utility_common::canseeenemy() || scripts\anim\utility_common::cansuppressenemy();
}

func_7E90() {
  return self.goodshootpos;
}

utility_trigger_demeanoroverride() {
  if(!func_8BED()) {
    return;
  }

  self.var_9332 = func_7E90();
  self.var_932D = self.origin;
}

utility_trigger_deleter() {
  if(!func_8BED()) {
    return 0;
  }

  var_00 = self getmuzzlepos();
  var_01 = self getshootatpos() - var_00;
  if(isDefined(self.var_9332) && isDefined(self.var_932D)) {
    if(distance(self.origin, self.var_932D) < 25) {
      return 0;
    }
  }

  self.var_9332 = undefined;
  var_02 = self canshoot(func_7E90(), var_01);
  if(!var_02) {
    self.var_9332 = func_7E90();
    return 0;
  }

  return 1;
}

func_4F57() {
  wait(5);
  self notify("timeout");
}

func_4F4E(param_00, param_01, param_02) {
  self endon("death");
  self notify("stop debug " + param_00);
  self endon("stop debug " + param_00);
  var_03 = spawnStruct();
  var_03 thread func_4F57();
  var_03 endon("timeout");
  if(self.isnodeoccupied.team == "allies") {
    var_04 = (0.4, 0.7, 1);
  } else {
    var_04 = (1, 0.7, 0.4);
  }

  wait(0.05);
}

func_4F4D(param_00, param_01) {
  thread func_4F4E(param_00, param_01, 2.15);
}

func_4F4F(param_00, param_01, param_02) {
  thread func_4F4E(param_00, param_01, param_02);
}

func_4F38(param_00, param_01) {
  var_02 = param_00 / param_01;
  var_03 = undefined;
  if(param_00 == self.bulletsinclip) {
    var_03 = "all rounds";
  } else if(var_02 < 0.25) {
    var_03 = "small burst";
  } else if(var_02 < 0.5) {
    var_03 = "med burst";
  } else {
    var_03 = "long burst";
  }

  thread func_4F4F(self.origin + (0, 0, 42), var_03, 1.5);
  thread func_4F4D(self.origin + (0, 0, 60), "Suppressing");
}

func_D91C() {
  self endon("death");
  self notify("stop shoot " + self.var_6A0B);
  self endon("stop shoot " + self.var_6A0B);
  var_00 = 0.25;
  var_01 = var_00 * 20;
  for(var_02 = 0; var_02 < var_01; var_02 = var_02 + 1) {
    wait(0.05);
  }
}

func_D91B() {}

func_1011C(param_00, param_01, param_02, param_03) {
  self endon("death");
  var_04 = param_03 * 20;
  for(var_05 = 0; var_05 < var_04; var_05 = var_05 + 1) {
    wait(0.05);
  }
}

func_1011B(param_00, param_01, param_02, param_03) {
  thread func_1011C(param_00, param_01 + (0, 0, -5), param_02, param_03);
}

func_FE9C(param_00) {
  self.a.var_A9ED = gettime();
  scripts\sp\gameskill::func_F288();
  self notify("shooting");
  if(scripts\anim\utility_common::isasniper() && isDefined(self.asm.shootparams) && isDefined(self.asm.shootparams.pos)) {
    self shoot(1, self.asm.shootparams.pos, 1, 0, 1);
  } else {
    self shoot(1, undefined, param_00);
  }
}

func_FE9D(param_00) {
  level notify("an_enemy_shot", self);
  func_FE9C(param_00);
}

func_FED2(param_00, param_01) {
  self.a.var_A9ED = gettime();
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  self notify("shooting");
  if(scripts\anim\utility_common::isasniper()) {
    self shoot(1, param_00, 1, 1, 1);
  } else {
    var_02 = bulletspread(self getmuzzlepos(), param_00, 4);
    self shoot(1, var_02, param_01);
  }
}

func_11816() {
  var_00 = spawn("script_model", (0, 0, 0));
  var_00 setModel("temp");
  var_00.origin = self gettagorigin("tag_weapon_right") + (50, 50, 0);
  var_00.angles = self gettagangles("tag_weapon_right");
  var_01 = anglestoright(var_00.angles);
  var_01 = var_01 * 15;
  var_02 = anglesToForward(var_00.angles);
  var_02 = var_02 * 15;
  var_00 movegravity((0, 50, 150), 100);
  var_03 = "weapon_" + self.var_394;
  var_04 = spawn(var_03, var_00.origin);
  var_04.angles = self gettagangles("tag_weapon_right");
  var_04 linkto(var_00);
  var_05 = var_00.origin;
  while(isDefined(var_04) && isDefined(var_04.origin)) {
    var_06 = var_05;
    var_07 = var_00.origin;
    var_08 = vectortoangles(var_07 - var_06);
    var_02 = anglesToForward(var_08);
    var_02 = var_02 * 4;
    var_09 = bulletTrace(var_07, var_07 + var_02, 1, var_04);
    if(isalive(var_09["entity"]) && var_09["entity"] == self) {
      wait(0.05);
      continue;
    }

    if(var_09["fraction"] < 1) {
      break;
    }

    var_05 = var_00.origin;
    wait(0.05);
  }

  if(isDefined(var_04) && isDefined(var_04.origin)) {
    var_04 unlink();
  }

  var_00 delete();
}

func_CA76() {
  var_00 = "TAG_EYE";
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");
  while(isDefined(self)) {
    wait(0.05);
    if(!isDefined(self)) {
      break;
    }

    if(isDefined(self.a.movement) && self.a.movement == "stop") {
      if(isDefined(self.var_9E45) && self.var_9E45 == 1) {
        continue;
      }

      playFXOnTag(level._effect["cold_breath"], self, var_00);
      wait(2.5 + randomfloat(3));
      continue;
    }

    wait(0.5);
  }
}

func_CA78() {
  self notify("stop personal effect");
}

func_CA77() {
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");
  for(;;) {
    self waittill("spawned", var_00);
    if(scripts\sp\utility::func_106ED(var_00)) {
      continue;
    }

    var_00 thread func_CA76();
  }
}

func_9ED4() {
  if(self.testbrushedgesforgrapple <= self.suppressionthreshold * 0.25) {
    return 0;
  }

  return self issuppressed();
}

func_10137(param_00, param_01, param_02) {
  for(;;) {
    wait(0.05);
    wait(0.05);
  }
}

func_1E9D(param_00, param_01) {
  var_02 = param_00.size;
  var_03 = randomint(var_02);
  if(var_02 == 1) {
    return param_00[0];
  }

  var_04 = 0;
  var_05 = 0;
  for(var_06 = 0; var_06 < var_02; var_06++) {
    var_05 = var_05 + param_01[var_06];
  }

  var_07 = randomfloat(var_05);
  var_08 = 0;
  for(var_06 = 0; var_06 < var_02; var_06++) {
    var_08 = var_08 + param_01[var_06];
    if(var_07 >= var_08) {
      continue;
    }

    var_03 = var_06;
    break;
  }

  return param_00[var_03];
}

func_EB7E(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 500;
  }

  return gettime() - self.var_CA7E < param_00;
}

func_3928() {
  if(!self.objective_state) {
    return 0;
  }

  if(self.script_forcegrenade) {
    return 1;
  }

  return isplayer(self.isnodeoccupied);
}

func_13110() {
  return weaponisboltaction(self.var_394);
}

func_DCA3(param_00) {
  var_01 = randomint(param_00.size);
  if(param_00.size > 1) {
    var_02 = 0;
    for(var_03 = 0; var_03 < param_00.size; var_03++) {
      var_02 = var_02 + param_00[var_03];
    }

    var_04 = randomfloat(var_02);
    var_02 = 0;
    for(var_03 = 0; var_03 < param_00.size; var_03++) {
      var_02 = var_02 + param_00[var_03];
      if(var_04 < var_02) {
        var_01 = var_03;
        break;
      }
    }
  }

  return var_01;
}

func_F715(param_00, param_01, param_02) {
  if(!isDefined(level.optionalstepeffects)) {
    anim.optionalstepeffects = [];
  }

  level.optionalstepeffects[param_01] = 1;
  level._effect["step_" + param_01][param_00] = param_02;
}

func_F716(param_00, param_01, param_02) {
  if(!isDefined(level.optionalstepeffectssmall)) {
    anim.optionalstepeffectssmall = [];
  }

  level.optionalstepeffectssmall[param_01] = 1;
  level._effect["step_small_" + param_01][param_00] = param_02;
}

func_12CBF(param_00) {
  if(isDefined(level.optionalstepeffects)) {
    level.optionalstepeffects[param_00] = undefined;
  }

  level._effect["step_" + param_00] = undefined;
}

func_12CC0(param_00) {
  if(isDefined(level.optionalstepeffectssmall)) {
    level.optionalstepeffectssmall[param_00] = undefined;
  }

  level._effect["step_small_" + param_00] = undefined;
}

func_F7B9(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_02)) {
    param_02 = "all";
  }

  if(!isDefined(level._notetrackfx)) {
    level._notetrackfx = [];
  }

  level._notetrackfx[param_00][param_02] = spawnStruct();
  level._notetrackfx[param_00][param_02].physics_setgravitydynentscalar = param_01;
  level._notetrackfx[param_00][param_02].fx = param_03;
  func_F7BA(param_00, param_02, param_04, param_05);
}

func_F7BA(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_01)) {
    param_01 = "all";
  }

  if(!isDefined(level._notetrackfx)) {
    level._notetrackfx = [];
  }

  if(isDefined(level._notetrackfx[param_00][param_01])) {
    var_04 = level._notetrackfx[param_00][param_01];
  } else {
    var_04 = spawnStruct();
    level._notetrackfx[param_00][param_01] = var_04;
  }

  if(isDefined(param_02)) {
    var_04.sound_prefix = param_02;
  }

  if(isDefined(param_03)) {
    var_04.sound_suffix = param_03;
  }
}

enterpronewrapper(param_00) {
  thread func_662B(param_00);
}

func_662B(param_00) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self _meth_80DF(param_00, isDefined(self.a.onback));
  self waittill("killanimscript");
  if(self.a.pose != "prone" && !isDefined(self.a.onback)) {
    self.a.pose = "prone";
  }
}

exitpronewrapper(param_00) {
  thread func_697C(param_00);
}

func_697C(param_00) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self _meth_80E0(param_00);
  self waittill("killanimscript");
  if(self.a.pose == "prone") {
    self.a.pose = "crouch";
  }
}

func_3875() {
  if(self.a.var_2411) {
    return 0;
  }

  if(!scripts\anim\weaponlist::usingautomaticweapon()) {
    return 0;
  }

  if(weaponclass(self.var_394) == "mg") {
    return 0;
  }

  if(isDefined(self.var_5507) && self.var_5507 == 1) {
    return 0;
  }

  return 1;
}

func_38C0() {
  if(!func_8BED()) {
    return 0;
  }

  var_00 = self getmuzzlepos();
  return sighttracepassed(var_00, func_7E90(), 0, undefined);
}

func_7FCC(param_00) {
  return self.a.var_BCA5[param_00];
}

func_DCA6(param_00, param_01) {
  if(randomint(2)) {
    return param_00;
  }

  return param_01;
}

func_1F64(param_00) {
  return self.a.var_2274[param_00];
}

func_1F65(param_00) {
  return isDefined(self.a.var_2274[param_00]) && self.a.var_2274[param_00].size > 0;
}

func_1F67(param_00) {
  var_01 = randomint(self.a.var_2274[param_00].size);
  return self.a.var_2274[param_00][var_01];
}

func_2274(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C, param_0D) {
  var_0E = [];
  if(isDefined(param_00)) {
    var_0E[0] = param_00;
  } else {
    return var_0E;
  }

  if(isDefined(param_01)) {
    var_0E[1] = param_01;
  } else {
    return var_0E;
  }

  if(isDefined(param_02)) {
    var_0E[2] = param_02;
  } else {
    return var_0E;
  }

  if(isDefined(param_03)) {
    var_0E[3] = param_03;
  } else {
    return var_0E;
  }

  if(isDefined(param_04)) {
    var_0E[4] = param_04;
  } else {
    return var_0E;
  }

  if(isDefined(param_05)) {
    var_0E[5] = param_05;
  } else {
    return var_0E;
  }

  if(isDefined(param_06)) {
    var_0E[6] = param_06;
  } else {
    return var_0E;
  }

  if(isDefined(param_07)) {
    var_0E[7] = param_07;
  } else {
    return var_0E;
  }

  if(isDefined(param_08)) {
    var_0E[8] = param_08;
  } else {
    return var_0E;
  }

  if(isDefined(param_09)) {
    var_0E[9] = param_09;
  } else {
    return var_0E;
  }

  if(isDefined(param_0A)) {
    var_0E[10] = param_0A;
  } else {
    return var_0E;
  }

  if(isDefined(param_0B)) {
    var_0E[11] = param_0B;
  } else {
    return var_0E;
  }

  if(isDefined(param_0C)) {
    var_0E[12] = param_0C;
  } else {
    return var_0E;
  }

  if(isDefined(param_0D)) {
    var_0E[13] = param_0D;
  }

  return var_0E;
}

getaiprimaryweapon() {
  return self.primaryweapon;
}

getaisecondaryweapon() {
  return self.secondaryweapon;
}

getaisidearmweapon() {
  return self.var_101B4;
}

func_7DA1() {
  return self.var_394;
}

func_7DA2() {
  if(self.var_394 == self.primaryweapon) {
    return "primary";
  }

  if(self.var_394 == self.secondaryweapon) {
    return "secondary";
  }

  if(self.var_394 == self.var_101B4) {
    return "sidearm";
  }
}

func_1A18(param_00) {
  if(isDefined(self.var_39B[param_00])) {
    return 1;
  }

  return 0;
}

func_7DC6(param_00) {
  var_01 = getmovedelta(param_00, 0, 1);
  return self gettweakablevalue(var_01);
}

func_10000(param_00) {
  return isDefined(self.secondaryweapon) && self.secondaryweapon != "none" && param_00 < squared(512) || self.a.rockets < 1;
}

func_DC1F(param_00) {
  self endon("killanimscript");
  var_01 = self.origin;
  var_02 = (0, 0, 0);
  for(;;) {
    wait(0.05);
    var_03 = distance(self.origin, var_01);
    var_01 = self.origin;
    if(self.health == 1) {
      self.a.nodeath = 1;
      self giverankxp();
      self clearanim(param_00, 0.1);
      wait(0.05);
      physicsexplosionsphere(var_01, 600, 0, var_03 * 0.1);
      self notify("killanimscript");
      return;
    }
  }
}

func_FFDB() {
  return func_9D9B() && !isDefined(self.objective_position);
}

func_9D9B() {
  return isDefined(self.demeanoroverride) && self.demeanoroverride == "cqb";
}

func_9D9C() {
  return !self.livestreamingenable || func_9D9B();
}

func_DCB7() {
  self.a.var_92F9 = randomint(2);
}

setclientextrasuper(param_00, param_01) {
  var_02 = param_00 % level.var_DCB3;
  return level.var_DCB2[var_02] % param_01;
}

func_7E52() {
  if(scripts\anim\utility_common::isusingsecondary()) {
    return "secondary";
  }

  if(scripts\anim\utility_common::isusingsidearm()) {
    return "sidearm";
  }

  return "primary";
}

func_B027(param_00, param_01) {
  if(isDefined(self.var_1F62)) {
    if(isDefined(level.archetypes[self.var_1F62][param_00]) && isDefined(level.archetypes[self.var_1F62][param_00][param_01])) {
      return level.archetypes[self.var_1F62][param_00][param_01];
    }
  }

  return level.archetypes["soldier"][param_00][param_01];
}

func_B028(param_00) {
  if(isDefined(self.var_1F62)) {
    if(isDefined(level.archetypes[self.var_1F62][param_00])) {
      var_01 = level.archetypes["soldier"][param_00];
      foreach(var_04, var_03 in level.archetypes[self.var_1F62][param_00]) {
        var_01[var_04] = var_03;
      }

      return var_01;
    }
  }

  return level.archetypes["soldier"][var_04];
}

func_B031(param_00, param_01, param_02) {
  if(isDefined(self.var_1F62)) {
    if(isDefined(level.archetypes[self.var_1F62][param_00]) && isDefined(level.archetypes[self.var_1F62][param_00][param_01]) && isDefined(level.archetypes[self.var_1F62][param_00][param_01][param_02])) {
      return level.archetypes[self.var_1F62][param_00][param_01][param_02];
    }
  }

  return level.archetypes["soldier"][param_00][param_01][param_02];
}

func_B02B(param_00, param_01) {
  if(isDefined(self.var_1F62)) {
    if(isDefined(level.archetypes[self.var_1F62][param_00]) && isDefined(level.archetypes[self.var_1F62][param_00][param_01])) {
      return level.archetypes[self.var_1F62][param_00][param_01];
    }
  }

  return level.archetypes["dog"][param_00][param_01];
}

validatenotetracks(param_00, param_01, param_02) {}

func_9DDB(param_00) {
  return weaponusesenergybullets(param_00);
}