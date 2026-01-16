/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\utility.gsc
*********************************************/

func_97CF(var_0) {
  self clearanim( % body, 0.3);
  self give_attacker_kill_rewards( % body, 1, 0);
  if(var_0 != "pain" && var_0 != "death") {
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
      self func_82A5(func_B027("default_prone", "straight_level"), % body, 1, 0.1, 1);
    }
  }

  self.var_5270 = undefined;
}

func_9832(var_0) {
  if(getdvarint("ai_iw7", 0) == 1) {
    self endon("killanimscript");
    self waittill("Hellfreezesover");
    return;
  }

  if(isDefined(self.var_AFE7)) {
    if(var_0 != "pain" && var_0 != "death") {
      self func_81D0(self.origin);
    }

    if(var_0 != "pain") {
      self.var_AFE7 = undefined;
      self notify("kill_long_death");
    }
  }

  if(isDefined(self.a.var_B4E7) && var_0 != "death") {
    self func_81D0(self.origin);
  }

  if(isDefined(self.a.var_D707)) {
    var_1 = self.a.var_D707;
    self.a.var_D707 = undefined;
    [[var_1]](var_0);
  }

  if(var_0 != "combat" && var_0 != "pain" && var_0 != "death" && scripts\anim\utility_common::isusingsidearm()) {
    scripts\anim\combat::func_11380(func_B027("combat", "pistol_to_primary"), 1);
  }

  if(var_0 != "combat" && var_0 != "move" && var_0 != "pain") {
    self.a.var_B168 = undefined;
  }

  if(var_0 != "death") {
    self.a.nodeath = 0;
  }

  if(isDefined(self.var_9E33) && var_0 == "pain" || var_0 == "death" || var_0 == "flashed") {
    scripts\anim\combat_utility::func_5D29();
  }

  self.var_9E33 = undefined;
  scripts\anim\squadmanager::func_1B0E(var_0);
  self.covernode = undefined;
  self.var_112C8 = 0;
  self.isreloading = 0;
  self.var_3C60 = 0;
  self.a.var_1A3E = undefined;
  self.a.var_EF87 = gettime();
  self.a.var_2411 = 0;
  if(isDefined(self.node) && self.node.type == "Conceal Prone" || self.node.type == "Conceal Crouch" || self.node.type == "Conceal Stand") {
    self.a.var_2411 = 1;
  }

  func_97CF(var_0);
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

func_2758(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_0 * 20; var_3++) {
    for(var_4 = 0; var_4 < 10; var_4++) {
      var_5 = (0, randomint(360), 0);
      var_6 = anglesToForward(var_5);
      var_7 = var_6 * var_2;
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

func_9E40(var_0) {
  if((!isDefined(var_0) || var_0) && self.opcode::OP_GetThisthread > 1) {
    return 1;
  }

  if(isDefined(self.enemy)) {
    return 1;
  }

  return self.a.combatendtime > gettime();
}

func_12EB9() {
  if(isDefined(self.enemy)) {
    self.a.combatendtime = gettime() + level.combatidlepreventoverlappingplayer + randomint(level.combatmemorytimeconst);
  }
}

func_824E(var_0, var_1) {
  var_2 = self gettagangles(var_0)[1] - scripts\anim\utility_common::getyawfromorigin(var_1, self gettagorigin(var_0));
  var_2 = angleclamp180(var_2);
  return var_2;
}

func_7EAD(var_0) {
  var_1 = self gettagangles("TAG_EYE")[1] - scripts\engine\utility::getyaw(var_0);
  var_1 = angleclamp180(var_1);
  return var_1;
}

func_9F75(var_0) {
  if(isDefined(self.covernode)) {
    return self.covernode getrandomattachments(var_0);
  }

  return self getteleportlonertargetplayer(var_0);
}

func_3EF2(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.a.pose;
  }

  switch (var_0) {
    case "stand":
      if(func_9F75("stand")) {
        var_1 = "stand";
      } else if(func_9F75("crouch")) {
        var_1 = "crouch";
      } else if(func_9F75("prone")) {
        var_1 = "prone";
      } else {
        var_1 = "stand";
      }
      break;

    case "crouch":
      if(func_9F75("crouch")) {
        var_1 = "crouch";
      } else if(func_9F75("stand")) {
        var_1 = "stand";
      } else if(func_9F75("prone")) {
        var_1 = "prone";
      } else {
        var_1 = "crouch";
      }
      break;

    case "prone":
      if(func_9F75("prone")) {
        var_1 = "prone";
      } else if(func_9F75("crouch")) {
        var_1 = "crouch";
      } else if(func_9F75("stand")) {
        var_1 = "stand";
      } else {
        var_1 = "prone";
      }
      break;

    default:
      var_1 = "stand";
      break;
  }

  return var_1;
}

func_CEA8(var_0) {
  if(isDefined(var_0)) {
    self func_82E4("playAnim", var_0, % root, 1, 0.1, 1);
    var_1 = getanimlength(var_0);
    var_1 = 3 * var_1 + 1;
    thread func_C15B("time is up", "time is up", var_1);
    self waittill("time is up");
    self notify("enddrawstring");
  }
}

func_C15B(var_0, var_1, var_2) {
  self endon("death");
  self endon(var_1);
  wait(var_2);
  self notify(var_0);
}

func_5B86(var_0) {
  self endon("killanimscript");
  self endon("enddrawstring");
  wait(0.05);
}

func_5B87(var_0, var_1, var_2, var_3) {
  var_4 = var_3 * 20;
  for(var_5 = 0; var_5 < var_4; var_5++) {
    wait(0.05);
  }
}

func_10136(var_0) {
  self notify("got known enemy2");
  self endon("got known enemy2");
  self endon("death");
  if(!isDefined(self.enemy)) {
    return;
  }

  if(self.enemy.team == "allies") {
    var_1 = (0.4, 0.7, 1);
  } else {
    var_1 = (1, 0.7, 0.4);
  }

  for(;;) {
    wait(0.05);
    if(!isDefined(self.lastenemysightpos)) {
      continue;
    }
  }
}

func_8BED() {
  if(isDefined(self.node)) {
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

  var_0 = self getmuzzlepos();
  var_1 = self getshootatpos() - var_0;
  if(isDefined(self.var_9332) && isDefined(self.var_932D)) {
    if(distance(self.origin, self.var_932D) < 25) {
      return 0;
    }
  }

  self.var_9332 = undefined;
  var_2 = self canshoot(func_7E90(), var_1);
  if(!var_2) {
    self.var_9332 = func_7E90();
    return 0;
  }

  return 1;
}

func_4F57() {
  wait(5);
  self notify("timeout");
}

func_4F4E(var_0, var_1, var_2) {
  self endon("death");
  self notify("stop debug " + var_0);
  self endon("stop debug " + var_0);
  var_3 = spawnStruct();
  var_3 thread func_4F57();
  var_3 endon("timeout");
  if(self.enemy.team == "allies") {
    var_4 = (0.4, 0.7, 1);
  } else {
    var_4 = (1, 0.7, 0.4);
  }

  wait(0.05);
}

func_4F4D(var_0, var_1) {
  thread func_4F4E(var_0, var_1, 2.15);
}

func_4F4F(var_0, var_1, var_2) {
  thread func_4F4E(var_0, var_1, var_2);
}

func_4F38(var_0, var_1) {
  var_2 = var_0 / var_1;
  var_3 = undefined;
  if(var_0 == self.bulletsinclip) {
    var_3 = "all rounds";
  } else if(var_2 < 0.25) {
    var_3 = "small burst";
  } else if(var_2 < 0.5) {
    var_3 = "med burst";
  } else {
    var_3 = "long burst";
  }

  thread func_4F4F(self.origin + (0, 0, 42), var_3, 1.5);
  thread func_4F4D(self.origin + (0, 0, 60), "Suppressing");
}

func_D91C() {
  self endon("death");
  self notify("stop shoot " + self.var_6A0B);
  self endon("stop shoot " + self.var_6A0B);
  var_0 = 0.25;
  var_1 = var_0 * 20;
  for(var_2 = 0; var_2 < var_1; var_2 = var_2 + 1) {
    wait(0.05);
  }
}

func_D91B() {}

func_1011C(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = var_3 * 20;
  for(var_5 = 0; var_5 < var_4; var_5 = var_5 + 1) {
    wait(0.05);
  }
}

func_1011B(var_0, var_1, var_2, var_3) {
  thread func_1011C(var_0, var_1 + (0, 0, -5), var_2, var_3);
}

func_FE9C(var_0) {
  self.a.var_A9ED = gettime();
  scripts\sp\gameskill::func_F288();
  self notify("shooting");
  if(scripts\anim\utility_common::isasniper() && isDefined(self.asm.shootparams) && isDefined(self.asm.shootparams.pos)) {
    self shoot(1, self.asm.shootparams.pos, 1, 0, 1);
  } else {
    self shoot(1, undefined, var_0);
  }
}

func_FE9D(var_0) {
  level notify("an_enemy_shot", self);
  func_FE9C(var_0);
}

func_FED2(var_0, var_1) {
  self.a.var_A9ED = gettime();
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  self notify("shooting");
  if(scripts\anim\utility_common::isasniper()) {
    self shoot(1, var_0, 1, 1, 1);
  } else {
    var_2 = bulletspread(self getmuzzlepos(), var_0, 4);
    self shoot(1, var_2, var_1);
  }
}

func_11816() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("temp");
  var_0.origin = self gettagorigin("tag_weapon_right") + (50, 50, 0);
  var_0.angles = self gettagangles("tag_weapon_right");
  var_1 = anglestoright(var_0.angles);
  var_1 = var_1 * 15;
  var_2 = anglesToForward(var_0.angles);
  var_2 = var_2 * 15;
  var_0 movegravity((0, 50, 150), 100);
  var_3 = "weapon_" + self.weapon;
  var_4 = spawn(var_3, var_0.origin);
  var_4.angles = self gettagangles("tag_weapon_right");
  var_4 linkto(var_0);
  var_5 = var_0.origin;
  while(isDefined(var_4) && isDefined(var_4.origin)) {
    var_6 = var_5;
    var_7 = var_0.origin;
    var_8 = vectortoangles(var_7 - var_6);
    var_2 = anglesToForward(var_8);
    var_2 = var_2 * 4;
    var_9 = bulletTrace(var_7, var_7 + var_2, 1, var_4);
    if(isalive(var_9["entity"]) && var_9["entity"] == self) {
      wait(0.05);
      continue;
    }

    if(var_9["fraction"] < 1) {
      break;
    }

    var_5 = var_0.origin;
    wait(0.05);
  }

  if(isDefined(var_4) && isDefined(var_4.origin)) {
    var_4 unlink();
  }

  var_0 delete();
}

func_CA76() {
  var_0 = "TAG_EYE";
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

      playFXOnTag(level._effect["cold_breath"], self, var_0);
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
    self waittill("spawned", var_0);
    if(scripts\sp\utility::func_106ED(var_0)) {
      continue;
    }

    var_0 thread func_CA76();
  }
}

func_9ED4() {
  if(self.suppressionmeter <= self.suppressionthreshold * 0.25) {
    return 0;
  }

  return self issuppressed();
}

func_10137(var_0, var_1, var_2) {
  for(;;) {
    wait(0.05);
    wait(0.05);
  }
}

func_1E9D(var_0, var_1) {
  var_2 = var_0.size;
  var_3 = randomint(var_2);
  if(var_2 == 1) {
    return var_0[0];
  }

  var_4 = 0;
  var_5 = 0;
  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_5 = var_5 + var_1[var_6];
  }

  var_7 = randomfloat(var_5);
  var_8 = 0;
  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_8 = var_8 + var_1[var_6];
    if(var_7 >= var_8) {
      continue;
    }

    var_3 = var_6;
    break;
  }

  return var_0[var_3];
}

func_EB7E(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 500;
  }

  return gettime() - self.var_CA7E < var_0;
}

func_3928() {
  if(!self.objective_state) {
    return 0;
  }

  if(self.script_forcegrenade) {
    return 1;
  }

  return isplayer(self.enemy);
}

func_13110() {
  return weaponisboltaction(self.weapon);
}

func_DCA3(var_0) {
  var_1 = randomint(var_0.size);
  if(var_0.size > 1) {
    var_2 = 0;
    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_2 = var_2 + var_0[var_3];
    }

    var_4 = randomfloat(var_2);
    var_2 = 0;
    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_2 = var_2 + var_0[var_3];
      if(var_4 < var_2) {
        var_1 = var_3;
        break;
      }
    }
  }

  return var_1;
}

func_F715(var_0, var_1, var_2) {
  if(!isDefined(level.optionalstepeffects)) {
    anim.optionalstepeffects = [];
  }

  level.optionalstepeffects[var_1] = 1;
  level._effect["step_" + var_1][var_0] = var_2;
}

func_F716(var_0, var_1, var_2) {
  if(!isDefined(level.optionalstepeffectssmall)) {
    anim.optionalstepeffectssmall = [];
  }

  level.optionalstepeffectssmall[var_1] = 1;
  level._effect["step_small_" + var_1][var_0] = var_2;
}

func_12CBF(var_0) {
  if(isDefined(level.optionalstepeffects)) {
    level.optionalstepeffects[var_0] = undefined;
  }

  level._effect["step_" + var_0] = undefined;
}

func_12CC0(var_0) {
  if(isDefined(level.optionalstepeffectssmall)) {
    level.optionalstepeffectssmall[var_0] = undefined;
  }

  level._effect["step_small_" + var_0] = undefined;
}

func_F7B9(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2)) {
    var_2 = "all";
  }

  if(!isDefined(level._notetrackfx)) {
    level._notetrackfx = [];
  }

  level._notetrackfx[var_0][var_2] = spawnStruct();
  level._notetrackfx[var_0][var_2].physics_setgravitydynentscalar = var_1;
  level._notetrackfx[var_0][var_2].fx = var_3;
  func_F7BA(var_0, var_2, var_4, var_5);
}

func_F7BA(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = "all";
  }

  if(!isDefined(level._notetrackfx)) {
    level._notetrackfx = [];
  }

  if(isDefined(level._notetrackfx[var_0][var_1])) {
    var_4 = level._notetrackfx[var_0][var_1];
  } else {
    var_4 = spawnStruct();
    level._notetrackfx[var_0][var_1] = var_4;
  }

  if(isDefined(var_2)) {
    var_4.sound_prefix = var_2;
  }

  if(isDefined(var_3)) {
    var_4.sound_suffix = var_3;
  }
}

enterpronewrapper(var_0) {
  thread func_662B(var_0);
}

func_662B(var_0) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self func_80DF(var_0, isDefined(self.a.onback));
  self waittill("killanimscript");
  if(self.a.pose != "prone" && !isDefined(self.a.onback)) {
    self.a.pose = "prone";
  }
}

exitpronewrapper(var_0) {
  thread func_697C(var_0);
}

func_697C(var_0) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self func_80E0(var_0);
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

  if(weaponclass(self.weapon) == "mg") {
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

  var_0 = self getmuzzlepos();
  return sighttracepassed(var_0, func_7E90(), 0, undefined);
}

func_7FCC(var_0) {
  return self.a.var_BCA5[var_0];
}

func_DCA6(var_0, var_1) {
  if(randomint(2)) {
    return var_0;
  }

  return var_1;
}

func_1F64(var_0) {
  return self.a.var_2274[var_0];
}

func_1F65(var_0) {
  return isDefined(self.a.var_2274[var_0]) && self.a.var_2274[var_0].size > 0;
}

func_1F67(var_0) {
  var_1 = randomint(self.a.var_2274[var_0].size);
  return self.a.var_2274[var_0][var_1];
}

func_2274(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = [];
  if(isDefined(var_0)) {
    var_14[0] = var_0;
  } else {
    return var_14;
  }

  if(isDefined(var_1)) {
    var_14[1] = var_1;
  } else {
    return var_14;
  }

  if(isDefined(var_2)) {
    var_14[2] = var_2;
  } else {
    return var_14;
  }

  if(isDefined(var_3)) {
    var_14[3] = var_3;
  } else {
    return var_14;
  }

  if(isDefined(var_4)) {
    var_14[4] = var_4;
  } else {
    return var_14;
  }

  if(isDefined(var_5)) {
    var_14[5] = var_5;
  } else {
    return var_14;
  }

  if(isDefined(var_6)) {
    var_14[6] = var_6;
  } else {
    return var_14;
  }

  if(isDefined(var_7)) {
    var_14[7] = var_7;
  } else {
    return var_14;
  }

  if(isDefined(var_8)) {
    var_14[8] = var_8;
  } else {
    return var_14;
  }

  if(isDefined(var_9)) {
    var_14[9] = var_9;
  } else {
    return var_14;
  }

  if(isDefined(var_10)) {
    var_14[10] = var_10;
  } else {
    return var_14;
  }

  if(isDefined(var_11)) {
    var_14[11] = var_11;
  } else {
    return var_14;
  }

  if(isDefined(var_12)) {
    var_14[12] = var_12;
  } else {
    return var_14;
  }

  if(isDefined(var_13)) {
    var_14[13] = var_13;
  }

  return var_14;
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
  return self.weapon;
}

func_7DA2() {
  if(self.weapon == self.primaryweapon) {
    return "primary";
  }

  if(self.weapon == self.secondaryweapon) {
    return "secondary";
  }

  if(self.weapon == self.var_101B4) {
    return "sidearm";
  }
}

func_1A18(var_0) {
  if(isDefined(self.weaponinfo[var_0])) {
    return 1;
  }

  return 0;
}

func_7DC6(var_0) {
  var_1 = getmovedelta(var_0, 0, 1);
  return self gettweakablevalue(var_1);
}

func_10000(var_0) {
  return isDefined(self.secondaryweapon) && self.secondaryweapon != "none" && var_0 < squared(512) || self.a.rockets < 1;
}

func_DC1F(var_0) {
  self endon("killanimscript");
  var_1 = self.origin;
  var_2 = (0, 0, 0);
  for(;;) {
    wait(0.05);
    var_3 = distance(self.origin, var_1);
    var_1 = self.origin;
    if(self.health == 1) {
      self.a.nodeath = 1;
      self giverankxp();
      self clearanim(var_0, 0.1);
      wait(0.05);
      physicsexplosionsphere(var_1, 600, 0, var_3 * 0.1);
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

setclientextrasuper(var_0, var_1) {
  var_2 = var_0 % level.var_DCB3;
  return level.var_DCB2[var_2] % var_1;
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

func_B027(var_0, var_1) {
  if(isDefined(self.var_1F62)) {
    if(isDefined(level.archetypes[self.var_1F62][var_0]) && isDefined(level.archetypes[self.var_1F62][var_0][var_1])) {
      return level.archetypes[self.var_1F62][var_0][var_1];
    }
  }

  return level.archetypes["soldier"][var_0][var_1];
}

func_B028(var_0) {
  if(isDefined(self.var_1F62)) {
    if(isDefined(level.archetypes[self.var_1F62][var_0])) {
      var_1 = level.archetypes["soldier"][var_0];
      foreach(var_4, var_3 in level.archetypes[self.var_1F62][var_0]) {
        var_1[var_4] = var_3;
      }

      return var_1;
    }
  }

  return level.archetypes["soldier"][var_4];
}

func_B031(var_0, var_1, var_2) {
  if(isDefined(self.var_1F62)) {
    if(isDefined(level.archetypes[self.var_1F62][var_0]) && isDefined(level.archetypes[self.var_1F62][var_0][var_1]) && isDefined(level.archetypes[self.var_1F62][var_0][var_1][var_2])) {
      return level.archetypes[self.var_1F62][var_0][var_1][var_2];
    }
  }

  return level.archetypes["soldier"][var_0][var_1][var_2];
}

func_B02B(var_0, var_1) {
  if(isDefined(self.var_1F62)) {
    if(isDefined(level.archetypes[self.var_1F62][var_0]) && isDefined(level.archetypes[self.var_1F62][var_0][var_1])) {
      return level.archetypes[self.var_1F62][var_0][var_1];
    }
  }

  return level.archetypes["dog"][var_0][var_1];
}

validatenotetracks(var_0, var_1, var_2) {}

func_9DDB(var_0) {
  return weaponusesenergybullets(var_0);
}