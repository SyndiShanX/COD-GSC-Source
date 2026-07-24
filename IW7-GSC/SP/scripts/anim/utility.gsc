/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\utility.gsc
**************************************/

#using_animtree("generic_human");

_id_97CF(var_0) {
  self clearanim(%body, 0.3);
  self _meth_82A2(%body, 1, 0);

  if(var_0 != "pain" && var_0 != "death")
    self.a._id_10930 = "none";

  self.a._id_1A4B = 1.0;
  self.a._id_1A4D = 1.0;
  self.a._id_1A4C = 1.0;
  self.a._id_1A4F = 0;
  self.a._id_1A4E = 0;
  _id_12EB9();
}

_id_12E5F() {
  if(isDefined(self._id_5270) && self._id_5270 != self.a.pose) {
    if(self.a.pose == "prone")
      exitpronewrapper(0.5);

    if(self._id_5270 == "prone") {
      self setproneanimnodes(-45, 45, %prone_legs_down, %exposed_aiming, %prone_legs_up);
      enterpronewrapper(0.5);
      self _meth_82A5(_id_B027("default_prone", "straight_level"), %body, 1, 0.1, 1);
    }
  }

  self._id_5270 = undefined;
}

_id_9832(var_0) {
  if(getdvarint("ai_iw7", 0) == 1) {
    self endon("killanimscript");
    self waittill("Hellfreezesover");
    return;
  }

  if(isDefined(self._id_AFE7)) {
    if(var_0 != "pain" && var_0 != "death")
      self _meth_81D0(self.origin);

    if(var_0 != "pain") {
      self._id_AFE7 = undefined;
      self notify("kill_long_death");
    }
  }

  if(isDefined(self.a._id_B4E7) && var_0 != "death")
    self _meth_81D0(self.origin);

  if(isDefined(self.a._id_D707)) {
    var_1 = self.a._id_D707;
    self.a._id_D707 = undefined;
    [[var_1]](var_0);
  }

  if(var_0 != "combat" && var_0 != "pain" && var_0 != "death" && scripts\anim\utility_common::isusingsidearm())
    scripts\anim\combat::_id_11380(_id_B027("combat", "pistol_to_primary"), 1);

  if(var_0 != "combat" && var_0 != "move" && var_0 != "pain")
    self.a._id_B168 = undefined;

  if(var_0 != "death")
    self.a.nodeath = 0;

  if(isDefined(self._id_9E33) && (var_0 == "pain" || var_0 == "death" || var_0 == "flashed"))
    scripts\anim\combat_utility::_id_5D29();

  self._id_9E33 = undefined;
  scripts\anim\squadmanager::_id_1B0E(var_0);
  self.covernode = undefined;
  self._id_112C8 = 0;
  self.isreloading = 0;
  self._id_3C60 = 0;
  self.a._id_1A3E = undefined;
  self.a._id_EF87 = gettime();
  self.a._id_2411 = 0;

  if(isDefined(self.node) && (self.node.type == "Conceal Prone" || self.node.type == "Conceal Crouch" || self.node.type == "Conceal Stand"))
    self.a._id_2411 = 1;

  _id_97CF(var_0);
  _id_12E5F();
}

_id_8097() {
  if(isDefined(self._id_138DF) && self._id_138DF) {
    if(scripts\anim\utility_common::isshotgun(self.primaryweapon))
      return self.primaryweapon;
    else if(scripts\anim\utility_common::isshotgun(self.secondaryweapon))
      return self.secondaryweapon;
  }

  return self.primaryweapon;
}

_id_2758(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_0 * 20; var_3++) {
    for(var_4 = 0; var_4 < 10; var_4++) {
      var_5 = (0, randomint(360), 0);
      var_6 = anglesToForward(var_5);
      var_7 = var_6 * var_2;
    }

    wait 0.05;
  }
}

_id_D912() {
  self endon("death");
  self notify("displaceprint");
  self endon("displaceprint");

  for(;;)
    wait 0.05;
}

_id_9E40(var_0) {
  if((!isDefined(var_0) || var_0) && self.alertlevelint > 1)
    return 1;

  if(isDefined(self.enemy))
    return 1;

  return self.a.combatendtime > gettime();
}

_id_12EB9() {
  if(isDefined(self.enemy))
    self.a.combatendtime = gettime() + anim.combatidlepreventoverlappingplayer + randomint(anim.combatmemorytimeconst);
}

_id_824E(var_0, var_1) {
  var_2 = self gettagangles(var_0)[1] - scripts\anim\utility_common::getyawfromorigin(var_1, self gettagorigin(var_0));
  var_2 = angleclamp180(var_2);
  return var_2;
}

_id_7EAD(var_0) {
  var_1 = self gettagangles("TAG_EYE")[1] - scripts\engine\utility::getyaw(var_0);
  var_1 = angleclamp180(var_1);
  return var_1;
}

_id_9F75(var_0) {
  if(isDefined(self.covernode))
    return self.covernode doesnodeallowstance(var_0);

  return self _meth_81BF(var_0);
}

_id_3EF2(var_0) {
  if(!isDefined(var_0))
    var_0 = self.a.pose;

  switch (var_0) {
    case "stand":
      if(_id_9F75("stand"))
        var_1 = "stand";
      else if(_id_9F75("crouch"))
        var_1 = "crouch";
      else if(_id_9F75("prone"))
        var_1 = "prone";
      else
        var_1 = "stand";

      break;
    case "crouch":
      if(_id_9F75("crouch"))
        var_1 = "crouch";
      else if(_id_9F75("stand"))
        var_1 = "stand";
      else if(_id_9F75("prone"))
        var_1 = "prone";
      else
        var_1 = "crouch";

      break;
    case "prone":
      if(_id_9F75("prone"))
        var_1 = "prone";
      else if(_id_9F75("crouch"))
        var_1 = "crouch";
      else if(_id_9F75("stand"))
        var_1 = "stand";
      else
        var_1 = "prone";

      break;
    default:
      var_1 = "stand";
      break;
  }

  return var_1;
}

_id_CEA8(var_0) {
  if(isDefined(var_0)) {
    self _meth_82E4("playAnim", var_0, %root, 1, 0.1, 1);
    var_1 = getanimlength(var_0);
    var_1 = 3 * var_1 + 1;
    thread _id_C15B("time is up", "time is up", var_1);
    self waittill("time is up");
    self notify("enddrawstring");
  }
}

_id_C15B(var_0, var_1, var_2) {
  self endon("death");
  self endon(var_1);
  wait(var_2);
  self notify(var_0);
}

_id_5B86(var_0) {
  self endon("killanimscript");
  self endon("enddrawstring");

  for(;;)
    wait 0.05;
}

_id_5B87(var_0, var_1, var_2, var_3) {
  var_4 = var_3 * 20;

  for(var_5 = 0; var_5 < var_4; var_5++)
    wait 0.05;
}

_id_10136(var_0) {
  self notify("got known enemy2");
  self endon("got known enemy2");
  self endon("death");

  if(!isDefined(self.enemy)) {
    return;
  }
  if(self.enemy.team == "allies")
    var_1 = (0.4, 0.7, 1);
  else
    var_1 = (1, 0.7, 0.4);

  for(;;) {
    wait 0.05;

    if(!isDefined(self.lastenemysightpos))
      continue;
  }
}

_id_8BED() {
  if(isDefined(self.node))
    return scripts\anim\utility_common::canseeenemyfromexposed() || scripts\anim\utility_common::cansuppressenemyfromexposed();
  else
    return scripts\anim\utility_common::canseeenemy() || scripts\anim\utility_common::cansuppressenemy();
}

_id_7E90() {
  return self.goodshootpos;
}

utility_trigger_demeanoroverride() {
  if(!_id_8BED()) {
    return;
  }
  self._id_9332 = _id_7E90();
  self._id_932D = self.origin;
}

utility_trigger_deleter() {
  if(!_id_8BED())
    return 0;

  var_0 = self getmuzzlepos();
  var_1 = self getshootatpos() - var_0;

  if(isDefined(self._id_9332) && isDefined(self._id_932D)) {
    if(distance(self.origin, self._id_932D) < 25)
      return 0;
  }

  self._id_9332 = undefined;
  var_2 = self canshoot(_id_7E90(), var_1);

  if(!var_2) {
    self._id_9332 = _id_7E90();
    return 0;
  }

  return 1;
}

_id_4F57() {
  wait 5;
  self notify("timeout");
}

_id_4F4E(var_0, var_1, var_2) {
  self endon("death");
  self notify("stop debug " + var_0);
  self endon("stop debug " + var_0);
  var_3 = spawnStruct();
  var_3 thread _id_4F57();
  var_3 endon("timeout");

  if(self.enemy.team == "allies")
    var_4 = (0.4, 0.7, 1);
  else
    var_4 = (1, 0.7, 0.4);

  for(;;)
    wait 0.05;
}

_id_4F4D(var_0, var_1) {
  thread _id_4F4E(var_0, var_1, 2.15);
}

_id_4F4F(var_0, var_1, var_2) {
  thread _id_4F4E(var_0, var_1, var_2);
}

_id_4F38(var_0, var_1) {
  var_2 = var_0 / var_1;
  var_3 = undefined;

  if(var_0 == self.bulletsinclip)
    var_3 = "all rounds";
  else if(var_2 < 0.25)
    var_3 = "small burst";
  else if(var_2 < 0.5)
    var_3 = "med burst";
  else
    var_3 = "long burst";

  thread _id_4F4F(self.origin + (0, 0, 42), var_3, 1.5);
  thread _id_4F4D(self.origin + (0, 0, 60), "Suppressing");
}

_id_D91C() {
  self endon("death");
  self notify("stop shoot " + self._id_6A0B);
  self endon("stop shoot " + self._id_6A0B);
  var_0 = 0.25;
  var_1 = var_0 * 20;

  for(var_2 = 0; var_2 < var_1; var_2 = var_2 + 1)
    wait 0.05;
}

_id_D91B() {}

_id_1011C(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = var_3 * 20;

  for(var_5 = 0; var_5 < var_4; var_5 = var_5 + 1)
    wait 0.05;
}

_id_1011B(var_0, var_1, var_2, var_3) {
  thread _id_1011C(var_0, var_1 + (0, 0, -5), var_2, var_3);
}

_id_FE9C(var_0) {
  self.a._id_A9ED = gettime();
  scripts\sp\gameskill::_id_F288();
  self notify("shooting");

  if(scripts\anim\utility_common::isasniper() && isDefined(self.asm.shootparams) && isDefined(self.asm.shootparams.pos))
    self shoot(1, self.asm.shootparams.pos, 1, 0, 1);
  else
    self shoot(1, undefined, var_0);
}

_id_FE9D(var_0) {
  level notify("an_enemy_shot", self);
  _id_FE9C(var_0);
}

_id_FED2(var_0, var_1) {
  self.a._id_A9ED = gettime();

  if(!isDefined(var_1))
    var_1 = 1;

  self notify("shooting");

  if(scripts\anim\utility_common::isasniper())
    self shoot(1, var_0, 1, 1, 1);
  else {
    var_2 = bulletspread(self getmuzzlepos(), var_0, 4);
    self shoot(1, var_2, var_1);
  }
}

_id_11816() {
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
  var_4 linkTo(var_0);
  var_5 = var_0.origin;

  while(isDefined(var_4) && isDefined(var_4.origin)) {
    var_6 = var_5;
    var_7 = var_0.origin;
    var_8 = vectortoangles(var_7 - var_6);
    var_2 = anglesToForward(var_8);
    var_2 = var_2 * 4;
    var_9 = bulletTrace(var_7, var_7 + var_2, 1, var_4);

    if(isalive(var_9["entity"]) && var_9["entity"] == self) {
      wait 0.05;
      continue;
    }

    if(var_9["fraction"] < 1.0) {
      break;
    }

    var_5 = var_0.origin;
    wait 0.05;
  }

  if(isDefined(var_4) && isDefined(var_4.origin))
    var_4 unlink();

  var_0 delete();
}

_id_CA76() {
  var_0 = "TAG_EYE";
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");

  while(isDefined(self)) {
    wait 0.05;

    if(!isDefined(self)) {
      break;
    }

    if(isDefined(self.a.movement) && self.a.movement == "stop") {
      if(isDefined(self._id_9E45) && self._id_9E45 == 1) {
        continue;
      }
      playFXOnTag(level._effect["cold_breath"], self, var_0);
      wait(2.5 + randomfloat(3));
      continue;
    }

    wait 0.5;
  }
}

_id_CA78() {
  self notify("stop personal effect");
}

_id_CA77() {
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");

  for(;;) {
    self waittill("spawned", var_0);

    if(scripts\sp\utility::_id_106ED(var_0)) {
      continue;
    }
    var_0 thread _id_CA76();
  }
}

_id_9ED4() {
  if(self.suppressionmeter <= self.suppressionthreshold * 0.25)
    return 0;

  return self issuppressed();
}

_id_10137(var_0, var_1, var_2) {
  for(;;) {
    wait 0.05;
    wait 0.05;
  }
}

_id_1E9D(var_0, var_1) {
  var_2 = var_0.size;
  var_3 = randomint(var_2);

  if(var_2 == 1)
    return var_0[0];

  var_4 = 0;
  var_5 = 0;

  for(var_6 = 0; var_6 < var_2; var_6++)
    var_5 = var_5 + var_1[var_6];

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

_id_EB7E(var_0) {
  if(!isDefined(var_0))
    var_0 = 500;

  return gettime() - self._id_CA7E < var_0;
}

_id_3928() {
  if(!self.grenadeammo)
    return 0;

  if(self.script_forcegrenade)
    return 1;

  return isPlayer(self.enemy);
}

_id_13110() {
  return weaponisboltaction(self.weapon);
}

_id_DCA3(var_0) {
  var_1 = randomint(var_0.size);

  if(var_0.size > 1) {
    var_2 = 0;

    for(var_3 = 0; var_3 < var_0.size; var_3++)
      var_2 = var_2 + var_0[var_3];

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

_id_F715(var_0, var_1, var_2) {
  if(!isDefined(anim.optionalstepeffects))
    anim.optionalstepeffects = [];

  anim.optionalstepeffects[var_1] = 1;
  level._effect["step_" + var_1][var_0] = var_2;
}

_id_F716(var_0, var_1, var_2) {
  if(!isDefined(anim.optionalstepeffectssmall))
    anim.optionalstepeffectssmall = [];

  anim.optionalstepeffectssmall[var_1] = 1;
  level._effect["step_small_" + var_1][var_0] = var_2;
}

_id_12CBF(var_0) {
  if(isDefined(anim.optionalstepeffects))
    anim.optionalstepeffects[var_0] = undefined;

  level._effect["step_" + var_0] = undefined;
}

_id_12CC0(var_0) {
  if(isDefined(anim.optionalstepeffectssmall))
    anim.optionalstepeffectssmall[var_0] = undefined;

  level._effect["step_small_" + var_0] = undefined;
}

_id_F7B9(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2))
    var_2 = "all";

  if(!isDefined(level._notetrackfx))
    level._notetrackfx = [];

  level._notetrackfx[var_0][var_2] = spawnStruct();
  level._notetrackfx[var_0][var_2].tag = var_1;
  level._notetrackfx[var_0][var_2].fx = var_3;
  _id_F7BA(var_0, var_2, var_4, var_5);
}

_id_F7BA(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = "all";

  if(!isDefined(level._notetrackfx))
    level._notetrackfx = [];

  if(isDefined(level._notetrackfx[var_0][var_1]))
    var_4 = level._notetrackfx[var_0][var_1];
  else {
    var_4 = spawnStruct();
    level._notetrackfx[var_0][var_1] = var_4;
  }

  if(isDefined(var_2))
    var_4.sound_prefix = var_2;

  if(isDefined(var_3))
    var_4.sound_suffix = var_3;
}

enterpronewrapper(var_0) {
  thread _id_662B(var_0);
}

_id_662B(var_0) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self _meth_80DF(var_0, isDefined(self.a.onback));
  self waittill("killanimscript");

  if(self.a.pose != "prone" && !isDefined(self.a.onback))
    self.a.pose = "prone";
}

exitpronewrapper(var_0) {
  thread _id_697C(var_0);
}

_id_697C(var_0) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self _meth_80E0(var_0);
  self waittill("killanimscript");

  if(self.a.pose == "prone")
    self.a.pose = "crouch";
}

_id_3875() {
  if(self.a._id_2411)
    return 0;

  if(!scripts\anim\weaponlist::usingautomaticweapon())
    return 0;

  if(weaponclass(self.weapon) == "mg")
    return 0;

  if(isDefined(self._id_5507) && self._id_5507 == 1)
    return 0;

  return 1;
}

_id_38C0() {
  if(!_id_8BED())
    return 0;

  var_0 = self getmuzzlepos();
  return sighttracepassed(var_0, _id_7E90(), 0, undefined);
}

_id_7FCC(var_0) {
  return self.a._id_BCA5[var_0];
}

_id_DCA6(var_0, var_1) {
  if(randomint(2))
    return var_0;
  else
    return var_1;
}

_id_1F64(var_0) {
  return self.a._id_2274[var_0];
}

_id_1F65(var_0) {
  return isDefined(self.a._id_2274[var_0]) && self.a._id_2274[var_0].size > 0;
}

_id_1F67(var_0) {
  var_1 = randomint(self.a._id_2274[var_0].size);
  return self.a._id_2274[var_0][var_1];
}

_id_2274(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = [];

  if(isDefined(var_0))
    var_14[0] = var_0;
  else
    return var_14;

  if(isDefined(var_1))
    var_14[1] = var_1;
  else
    return var_14;

  if(isDefined(var_2))
    var_14[2] = var_2;
  else
    return var_14;

  if(isDefined(var_3))
    var_14[3] = var_3;
  else
    return var_14;

  if(isDefined(var_4))
    var_14[4] = var_4;
  else
    return var_14;

  if(isDefined(var_5))
    var_14[5] = var_5;
  else
    return var_14;

  if(isDefined(var_6))
    var_14[6] = var_6;
  else
    return var_14;

  if(isDefined(var_7))
    var_14[7] = var_7;
  else
    return var_14;

  if(isDefined(var_8))
    var_14[8] = var_8;
  else
    return var_14;

  if(isDefined(var_9))
    var_14[9] = var_9;
  else
    return var_14;

  if(isDefined(var_10))
    var_14[10] = var_10;
  else
    return var_14;

  if(isDefined(var_11))
    var_14[11] = var_11;
  else
    return var_14;

  if(isDefined(var_12))
    var_14[12] = var_12;
  else
    return var_14;

  if(isDefined(var_13))
    var_14[13] = var_13;

  return var_14;
}

getaiprimaryweapon() {
  return self.primaryweapon;
}

getaisecondaryweapon() {
  return self.secondaryweapon;
}

getaisidearmweapon() {
  return self._id_101B4;
}

_id_7DA1() {
  return self.weapon;
}

_id_7DA2() {
  if(self.weapon == self.primaryweapon)
    return "primary";
  else if(self.weapon == self.secondaryweapon)
    return "secondary";
  else if(self.weapon == self._id_101B4)
    return "sidearm";
  else {}
}

_id_1A18(var_0) {
  if(isDefined(self.weaponinfo[var_0]))
    return 1;

  return 0;
}

_id_7DC6(var_0) {
  var_1 = getmovedelta(var_0, 0, 1);
  return self localtoworldcoords(var_1);
}

_id_10000(var_0) {
  return isDefined(self.secondaryweapon) && self.secondaryweapon != "none" && (var_0 < squared(512) || self.a.rockets < 1);
}

_id_DC1F(var_0) {
  self endon("killanimscript");
  var_1 = self.origin;
  var_2 = (0, 0, 0);

  for(;;) {
    wait 0.05;
    var_3 = distance(self.origin, var_1);
    var_1 = self.origin;

    if(self.health == 1) {
      self.a.nodeath = 1;
      self startragdoll();
      self clearanim(var_0, 0.1);
      wait 0.05;
      physicsexplosionsphere(var_1, 600, 0, var_3 * 0.1);
      self notify("killanimscript");
      return;
    }
  }
}

_id_FFDB() {
  return _id_9D9B() && !isDefined(self.grenade);
}

_id_9D9B() {
  return isDefined(self.demeanoroverride) && self.demeanoroverride == "cqb";
}

_id_9D9C() {
  return !self.facemotion || _id_9D9B();
}

_id_DCB7() {
  self.a._id_92F9 = randomint(2);
}

_id_80BD(var_0, var_1) {
  var_2 = var_0 % anim._id_DCB3;
  return anim._id_DCB2[var_2] % var_1;
}

_id_7E52() {
  if(scripts\anim\utility_common::isusingsecondary())
    return "secondary";

  if(scripts\anim\utility_common::isusingsidearm())
    return "sidearm";

  return "primary";
}

_id_B027(var_0, var_1) {
  if(isDefined(self._id_1F62)) {
    if(isDefined(anim.archetypes[self._id_1F62][var_0]) && isDefined(anim.archetypes[self._id_1F62][var_0][var_1]))
      return anim.archetypes[self._id_1F62][var_0][var_1];
  }

  return anim.archetypes["soldier"][var_0][var_1];
}

_id_B028(var_0) {
  if(isDefined(self._id_1F62)) {
    if(isDefined(anim.archetypes[self._id_1F62][var_0])) {
      var_1 = anim.archetypes["soldier"][var_0];

      foreach(var_4, var_3 in anim.archetypes[self._id_1F62][var_0])
      var_1[var_4] = var_3;

      return var_1;
    }
  }

  return anim.archetypes["soldier"][var_0];
}

_id_B031(var_0, var_1, var_2) {
  if(isDefined(self._id_1F62)) {
    if(isDefined(anim.archetypes[self._id_1F62][var_0]) && isDefined(anim.archetypes[self._id_1F62][var_0][var_1]) && isDefined(anim.archetypes[self._id_1F62][var_0][var_1][var_2]))
      return anim.archetypes[self._id_1F62][var_0][var_1][var_2];
  }

  return anim.archetypes["soldier"][var_0][var_1][var_2];
}

_id_B02B(var_0, var_1) {
  if(isDefined(self._id_1F62)) {
    if(isDefined(anim.archetypes[self._id_1F62][var_0]) && isDefined(anim.archetypes[self._id_1F62][var_0][var_1]))
      return anim.archetypes[self._id_1F62][var_0][var_1];
  }

  return anim.archetypes["dog"][var_0][var_1];
}

validatenotetracks(var_0, var_1, var_2) {}

_id_9DDB(var_0) {
  return weaponusesenergybullets(var_0);
}