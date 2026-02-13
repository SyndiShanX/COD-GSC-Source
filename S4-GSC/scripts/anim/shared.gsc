/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\anim\shared.gsc
*************************************************/

_id_B17E(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;

  if(isweapon(var_0)) {
    var_3 = var_0;
    var_4 = getcompleteweaponname(var_0);
  } else {
    var_3 = makeweaponfromstring(var_0);
    var_4 = var_0;
  }

  self notify("weapon_position_change");
  var_5 = self.weaponinfo[var_4]._id_033E;

  if(var_1 != "none" && isDefined(self._id_0DDF._id_10DC1[var_1]) && self._id_0DDF._id_10DC1[var_1] == var_3) {
    return;
  }
  _id_4889();

  if(var_5 != "none") {
    _id_4891(var_3);
  }

  if(var_1 == "none") {
    _id_FC0F();
    return;
  }

  if(!_func_0376(self._id_0DDF._id_10DC1[var_1])) {
    _id_4891(self._id_0DDF._id_10DC1[var_1]);
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2 && (var_1 == "left" || var_1 == "right")) {
    _id_1DBE(var_3, var_1);
    self._id_04F6 = var_3;
  } else
    _id_1DBE(var_3, var_1);

  _id_FC0F();
}

_id_4891(var_0) {
  var_1 = getcompleteweaponname(var_0);
  self._id_0DDF._id_10DC1[self.weaponinfo[var_1]._id_033E] = undefined;
  self.weaponinfo[var_1]._id_033E = "none";
}

_id_1DBE(var_0, var_1) {
  var_2 = getcompleteweaponname(var_0);
  self.weaponinfo[var_2]._id_033E = var_1;
  self._id_0DDF._id_10DC1[var_1] = var_0;

  if(!_func_0376(self._id_0DDF._id_10DC2[var_1])) {
    self notify("end_weapon_drop_" + var_1);
    self._id_0DDF._id_10DC2[var_1] = undefined;
  }
}

_id_6E72(var_0) {
  var_1 = self._id_0DDF._id_10DC1[var_0];

  if(_func_0376(var_1)) {
    return self._id_0DDF._id_10DC2[var_0];
  }

  return var_1;
}

_id_4889() {
  var_0 = [];
  var_0[var_0.size] = "right";
  var_0[var_0.size] = "left";
  var_0[var_0.size] = "chest";
  var_0[var_0.size] = "back";
  var_0[var_0.size] = "thigh";
  self _meth_8202();

  foreach(var_2 in var_0) {
    var_3 = _id_6E72(var_2);

    if(_func_0376(var_3)) {
      continue;
    }
    if(weapontype(var_3) == "riotshield" && isDefined(self._id_D9DC)) {
      if(isDefined(self._id_D9D6) && self._id_D9D6) {
        playFXOnTag(scripts\engine\utility::getfx("riot_shield_dmg"), self, "TAG_BRASS");
        self._id_D9D6 = undefined;
      }
    }
  }

  self _meth_8419();
}

_id_FC0F() {
  var_0 = [];
  var_1 = [];
  var_2 = [];
  var_0[var_0.size] = "right";
  var_0[var_0.size] = "left";
  var_0[var_0.size] = "chest";
  var_0[var_0.size] = "back";
  var_0[var_0.size] = "thigh";

  foreach(var_4 in var_0) {
    var_5 = var_1.size;
    var_6 = _id_6E72(var_4);

    if(!_func_0376(var_6) && !isnullweapon(var_6)) {
      var_7 = getcompleteweaponname(var_6);

      if(self.weaponinfo[var_7]._id_FE32 && !self.weaponinfo[var_7]._id_754D) {
        var_6 = var_6 _meth_866A(var_6._id_028D);
      }
    }

    if(isDefined(var_6)) {
      var_8 = _id_6DB4(var_4);

      if(self tagexists(var_8)) {
        var_1[var_5] = var_6;
        var_2[var_2.size] = var_8;
      }
    }
  }

  self _meth_8419(var_1[0], var_2[0], var_1[1], var_2[1], var_1[2], var_2[2], var_1[3], var_2[3]);
  self _meth_886D();
}

_id_6DB4(var_0) {
  switch (var_0) {
    case "chest":
      return "tag_stowed_chest";
    case "back":
      return "tag_stowed_back";
    case "left":
      return "tag_weapon_left";
    case "right":
      return "tag_weapon_right";
    case "hand":
      return "tag_accessory_right";
    case "thigh":
      return "tag_stowed_thigh";
    default:
      break;
  }
}

_id_5008(var_0) {
  var_1 = getcompleteweaponname(var_0);
  var_2 = self.weaponinfo[var_1]._id_033E;

  if(!istrue(self._id_A57F) && self._id_0188 && var_2 != "none") {
    thread _id_5077(var_0, var_2);
  }

  _id_4891(var_0);

  if(var_0 == self._id_04F6) {
    self._id_04F6 = _func_0375();
  }

  if(var_0 == self._id_034C) {
    self._id_034C = _func_0375();
  }

  if(var_0 == self._id_03B5) {
    self._id_03B5 = _func_0375();
  }

  if(var_0 == self._id_03D6) {
    if(!isnullweapon(self._id_034C)) {
      _id_5008(self._id_034C);
    }

    self._id_03D6 = _func_0375();
  }
}

_id_5007(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self._id_04F6;
  }

  if(isnullweapon(var_0)) {
    return;
  }
  _id_4889();
  _id_5008(var_0);

  if(isnullweapon(self._id_034C)) {
    if(!isnullweapon(self._id_04F6)) {
      self._id_034C = self._id_04F6;
    } else if(!isnullweapon(self._id_03B5)) {
      self._id_034C = self._id_03B5;
    } else if(!isnullweapon(self._id_03D6)) {
      self._id_034C = self._id_03D6;
    }

    if(self._id_034C == self._id_03B5) {
      self._id_03B5 = _func_0375();
    }
  }

  _id_FC0F();
}

_id_5009() {
  if(!isDefined(self._id_0DDF) || !isDefined(self._id_0DDF._id_10DC1)) {
    return;
  }
  var_0 = [];
  var_0[var_0.size] = "left";
  var_0[var_0.size] = "right";
  var_0[var_0.size] = "chest";
  var_0[var_0.size] = "back";
  var_0[var_0.size] = "thigh";
  _id_4889();

  foreach(var_2 in var_0) {
    var_3 = self._id_0DDF._id_10DC1[var_2];

    if(_func_0376(var_3)) {
      continue;
    }
    var_4 = getcompleteweaponname(var_3);
    self.weaponinfo[var_4]._id_033E = "none";
    self._id_0DDF._id_10DC1[var_2] = undefined;

    if(!istrue(self._id_A57F) && self._id_0188) {
      thread _id_5077(var_3, var_2);
    }
  }

  self._id_04F6 = _func_0375();
  _id_FC0F();
}

_id_5077(var_0, var_1) {
  if(self _meth_81DF()) {
    return "none";
  }

  self._id_0DDF._id_10DC2[var_1] = var_0;
  var_2 = var_0;
  var_3 = var_0.basename;

  if(issubstr(tolower(var_3), "_ai")) {
    var_3 = _func_00D6(var_3, 0, var_3.size - 3);
    var_2 = makeweapon(var_3, var_0._id_0070);
  }

  thread _id_D538(var_2);

  if(isagent(self)) {
    if(isDefined(level._id_5044)) {
      self thread[[level._id_5044]](var_2, var_1);
    } else {
      self _meth_862E(var_2, var_1);
    }
  } else if(_id_3111(self)) {
    if(var_1 == "back" || var_1 == "thigh") {
      var_4 = "tag_stowed_" + var_1;
    } else {
      var_4 = "tag_weapon_" + var_1;
    }

    if(!scripts\engine\utility::hastag(self.model, var_4)) {
      self _meth_80C5(var_2, var_1, 0);
      self endon("end_weapon_drop_" + var_1);
      waitframe();
      return;
    }

    var_5 = self gettagorigin(var_4);
    self endon("end_weapon_drop_" + var_1);
    waitframe();

    if(!isDefined(self)) {
      return;
    }
    var_6 = self gettagorigin(var_4);
    var_7 = self gettagangles(var_4);
    var_8 = getcompleteweaponname(var_2);
    var_9 = spawn("weapon_" + var_8, var_6);
    var_9.angles = var_7;
    var_10 = var_6 - var_5;
    var_11 = vectornormalize(var_10);
    var_12 = 20;
    var_13 = 50;
    var_14 = min(length(var_10) * var_12, var_13);
    var_15 = var_11 * var_14;
    var_16 = (0, 0, 950);
    var_17 = var_6 + var_11 * -1;
    var_18 = var_15 + var_16;

    if(weaponclass(var_2) == "pistol") {
      var_18 = var_18 * 0.5;
    }

    var_9 _meth_8256(var_17, var_18);
  } else {
    self _meth_80C5(var_2, var_1, 0);
    self endon("end_weapon_drop_" + var_1);
    waitframe();
  }

  if(!isDefined(self)) {
    return;
  }
  if(isagent(self) && !isalive(self)) {
    return;
  }
  _id_4889();
  self._id_0DDF._id_10DC2[var_1] = undefined;
  _id_FC0F();
}

_id_3111(var_0) {
  if(!getdvarint("#x3acf4f82edff1b29f", 0)) {
    return 0;
  }

  if(!scripts\common\utility::issp()) {
    return 0;
  }

  if(!isDefined(var_0._id_026E)) {
    return 0;
  }

  if(!isPlayer(var_0._id_026E)) {
    return 0;
  }

  if(_func_010F(var_0.damagemod)) {
    return 1;
  }

  var_1 = 300;

  if(distance(var_0._id_026E.origin, var_0.origin) < var_1) {
    return 0;
  }

  return 1;
}

_id_D538(var_0) {
  self waittill("weapon_dropped", var_1);
  var_1 endon("death");

  if(isDefined(var_0) && _id_8AE3(var_0)) {
    if(isDefined(var_1)) {
      var_1 physics_registerforcollisioncallback();
      var_1 thread _id_10D7A(var_0);
      var_2 = _func_00D6(var_1.classname, 7, var_1.classname.size);
      var_1 _id_D6BE(var_2, self);
    }
  }
}

_id_8AE3(var_0) {
  if(var_0._id_0249) {
    return 0;
  }

  return 1;
}

_id_10D7A(var_0) {
  self endon("death");
  self endon("timeout");
  thread _id_10D7B(2);
  self waittill("collision", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  var_9 = _func_02CA(var_4);
  var_10 = _func_00D6(var_9["name"], 9);

  if(var_10 == "user_terrain1") {
    var_10 = "user_terrain_1";
  }

  if(isDefined(var_0.classname) && isDefined(self)) {
    var_11 = "weap_drop_med";

    switch (var_0.classname) {
      case "rifle":
        var_11 = "weap_drop_med";
        break;
      case "smg":
        var_11 = "weap_drop_small";
        break;
      case "mg":
        var_11 = "weap_drop_xlarge";
        break;
      case "spread":
        var_11 = "weap_drop_large";
        break;
      case "sniper":
        var_11 = "weap_drop_large";
        break;
      case "pistol":
        var_11 = "weap_drop_pistol";
        break;
      case "grenade":
        var_11 = "weap_drop_launcher";
        break;
      case "rocketlauncher":
        var_11 = "weap_drop_launcher";
        break;
    }

    if(_func_0205(var_11)) {
      self _meth_8281(var_11, var_10);
    } else if(getdvarint("#x35bc54bd882c1d8a6", 1) == 1) {
      return;
    }
  }
}

_id_10D7B(var_0) {
  wait(var_0);
  self notify("timeout");
}

_id_6898() {
  if(!isDefined(self._id_DA2A)) {
    if(!isDefined(self._id_DA32)) {
      return 0;
    }

    return scripts\engine\utility::_id_6896(self._id_DA32);
  }

  return scripts\engine\utility::_id_6896(self._id_DA2A _meth_8176());
}

_id_6895() {
  var_0 = _id_6C2C();

  if(self.script == "cover_crouch" && isDefined(self._id_0DDF._id_3DE8) && self._id_0DDF._id_3DE8 == "lean") {
    var_0 = var_0 - anim._id_3DD7;
  }

  return var_0;
}

_id_6C2C() {
  if(!isDefined(self._id_DA2A)) {
    if(!isDefined(self._id_DA32)) {
      return 0;
    }

    return scripts\anim\combat_utility::_id_6C2D(self._id_DA32);
  }

  return scripts\anim\combat_utility::_id_6C2D(self._id_DA2A _meth_8176());
}

_id_BFCB(var_0) {
  self endon("killanimscript");
  _id_BFCC(var_0);
}

_id_BFCC(var_0) {}

_id_451A() {
  var_0 = 0;
  var_1 = weaponburstcount(self._id_04F6);

  if(var_1) {
    var_0 = var_1;
  } else if(scripts\anim\weaponlist::_id_FF1C()) {
    var_0 = anim._id_D090[randomint(anim._id_D090.size)];
  } else if(self._id_59BA) {
    var_0 = anim._id_59BB[randomint(anim._id_59BB.size)];
  } else {
    var_0 = anim._id_2DAE[randomint(anim._id_2DAE.size)];
  }

  if(var_0 <= self._id_00CC) {
    return var_0;
  }

  if(self._id_00CC <= 0) {
    return 1;
  }

  return self._id_00CC;
}

_id_451B() {
  var_0 = self._id_00CC;

  if(weaponclass(self._id_04F6) == "mg") {
    var_1 = randomfloat(10);

    if(var_1 < 3) {
      var_0 = randomintrange(2, 6);
    } else if(var_1 < 8) {
      var_0 = randomintrange(6, 12);
    } else {
      var_0 = randomintrange(12, 20);
    }
  }

  return var_0;
}

_id_791B(var_0) {
  self.weaponinfo[var_0]._id_754D = 0;
  _id_FC0F();
}

_id_DCFE(var_0) {
  self.weaponinfo[var_0]._id_754D = 1;
  _id_FC0F();
}

_id_743C(var_0) {
  self endon("abort_reload");
  self endon(var_0 + "_finished");
  var_1 = self._id_04F6;
  var_2 = getcompleteweaponname(var_1);
  var_3 = undefined;

  if(self.weaponinfo[var_2]._id_FE32) {
    var_3 = _func_00EE(self._id_04F6);
  }

  if(self.weaponinfo[var_2]._id_754D) {
    if(scripts\anim\utility_common::_id_8AD4()) {
      self playSound("weap_reload_pistol_clipout_npc");
    } else {
      self playSound("weap_reload_smg_clipout_npc");
    }

    if(isDefined(var_3)) {
      _id_791B(var_2);
      thread _id_5025(var_3, "tag_clip");
    }
  }

  var_4 = 0;

  while(!var_4) {
    self waittill(var_0, var_5);

    if(!_func_0107(var_5)) {
      var_5 = [var_5];
    }

    foreach(var_7 in var_5) {
      switch (var_7) {
        case "attach clip left":
          if(isDefined(var_3)) {
            if(!istrue(self.weaponinfo[var_2].clipattachedleft)) {
              self attach(var_3, "tag_accessory_left");

              if(isDefined(var_3)) {
                self _meth_81AB("tag_offscreen", var_3);
              }

              self.weaponinfo[var_2].clipattachedleft = 1;
            } else {}
          }

          scripts\anim\weaponlist::_id_C194();
          break;
        case "attach clip right":
          if(isDefined(var_3)) {
            if(!istrue(self.weaponinfo[var_2].clipattachedright)) {
              self attach(var_3, "tag_accessory_right");

              if(isDefined(var_3)) {
                self _meth_81AB("tag_offscreen", var_3);
              }

              self.weaponinfo[var_2].clipattachedright = 1;
            } else {}
          }

          scripts\anim\weaponlist::_id_C194();
          break;
        case "detach clip nohand":
          if(isDefined(var_3)) {
            if(istrue(self.weaponinfo[var_2].clipattachedright)) {
              self detach(var_3, "tag_accessory_right");
              self.weaponinfo[var_2].clipattachedright = undefined;
            } else {}
          }

          break;
        case "detach clip right":
          if(isDefined(var_3)) {
            if(istrue(self.weaponinfo[var_2].clipattachedright)) {
              self detach(var_3, "tag_accessory_right");
              self.weaponinfo[var_2].clipattachedright = undefined;
            } else {}

            if(var_1 == self._id_04F6) {
              _id_DCFE(var_2);
            } else {
              self.weaponinfo[getcompleteweaponname(self._id_04F6)]._id_754D = 1;
              self.weaponinfo[var_2]._id_754D = 1;
            }

            self notify("clip_detached");
          }

          self._id_0DDF._id_A411 = 0;
          var_4 = 1;
          break;
        case "detach clip left":
          if(isDefined(var_3)) {
            if(istrue(self.weaponinfo[var_2].clipattachedleft)) {
              self detach(var_3, "tag_accessory_left");
              self.weaponinfo[var_2].clipattachedleft = undefined;
            } else {}

            if(var_1 == self._id_04F6) {
              _id_DCFE(var_2);
            } else {
              self.weaponinfo[getcompleteweaponname(self._id_04F6)]._id_754D = 1;
              self.weaponinfo[var_2]._id_754D = 1;
            }

            self notify("clip_detached");
          }

          self._id_0DDF._id_A411 = 0;
          var_4 = 1;
          break;
      }
    }
  }
}

_id_5025(var_0, var_1) {}

_id_A273(var_0, var_1) {
  self endon("killanimscript");
  var_2 = var_0.origin;
  var_3 = distancesquared(self.origin, var_2);

  if(var_3 < 1) {
    self _meth_82AA(var_2);
    return;
  }

  if(var_3 > 256 && !self _meth_822D(var_2, !scripts\engine\utility::_id_0F78())) {
    return;
  }
  self._id_0260 = 1;
  var_4 = distance(self.origin, var_2);
  var_5 = int(var_1 * 20);

  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_2 = var_0.origin;
    var_7 = self.origin - var_2;
    var_7 = vectornormalize(var_7);
    var_8 = var_2 + var_7 * var_4;
    var_9 = var_8 + (var_2 - var_8) * ((var_6 + 1) / var_5);
    self _meth_82AA(var_9);
    wait 0.05;
  }

  self._id_0260 = 0;
}

_id_C7A0() {
  return 1;
}

#using_animtree("generic_human");

_id_B882(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = ::_id_C7A0;
  }

  for(var_3 = 0; var_3 < var_1 * 10; var_3++) {
    if(isalive(self._id_0192)) {
      if(scripts\anim\utility_common::_id_31CC() && [[var_2]]()) {
        return;
      }
    }

    if(scripts\anim\utility_common::_id_8A82() && [[var_2]]()) {
      return;
    }
    self _meth_82DC(var_0, %body, 1, 0.1);
    wait 0.1;
  }
}

_id_F18B(var_0) {
  self endon("killanimscript");
  _id_B17E(self._id_03B5, "right");
  _id_06D7::_id_4979();
}

_id_C984() {
  var_0 = _id_C986();

  if(var_0 == 0) {
    return;
  }
  self endon("death");

  for(;;) {
    level waittill("an_enemy_shot", var_1);

    if(var_1 != self) {
      continue;
    }
    if(!isDefined(var_1._id_0192)) {
      continue;
    }
    if(!isPlayer(var_1._id_0192)) {
      continue;
    }
    if(isDefined(level._id_403F) && level._id_403F == 0) {
      continue;
    }
    thread _id_C985(var_1._id_0192);
    var_0--;

    if(var_0 <= 0) {
      return;
    }
  }
}

_id_C986() {
  var_0 = scripts\common\utility::_id_69DE();

  switch (var_0) {
    case "gimp":
    case "easy":
      return 2;
    case "difficult":
    case "medium":
    case "hard":
      return 1;
    case "fu":
      return 0;
  }

  return 2;
}

_id_C985(var_0) {
  var_1 = _func_014D(var_0, 5000, 800);
  wait 4.0;
  _func_014F(var_1);
}

_id_B066() {
  if(isDefined(self._id_10DB8) && self._id_10DB8) {
    return;
  }
  if(scripts\engine\utility::_id_10E76(level.player.origin, level.player getplayerangles(), self.origin, 0.173648)) {
    return;
  }
  var_0 = undefined;

  if(distancesquared(self.origin, self._id_0192.origin) < self._id_39FA * self._id_39FA) {
    var_0 = self._id_5E9A;
  } else {
    var_0 = self._id_5E9B;
  }

  if(var_0 != self._id_04F6) {
    _id_5ED5(var_0, "primary");
    self._id_10D1B setModel(getweaponmodel(self._id_5E99));
    self._id_5E99 = var_0;
  }
}

_id_5ED5(var_0, var_1) {
  var_2 = undefined;

  if(isweapon(var_0)) {
    var_2 = var_0;
  } else {
    var_2 = [[level._id_5D69]](var_0);
  }

  if(istrue(self._id_CD38) || istrue(self._id_CD21)) {
    _id_06C5::_id_72A1();
    _id_06C5::_id_7292(getweaponattachmentworldmodels(var_2));
    return;
  }

  if(!scripts\common\utility::_id_8B07(var_2)) {
    scripts\common\utility::_id_82BA(var_2);
  }

  var_3 = !isnullweapon(self._id_04F6);
  var_4 = scripts\anim\utility_common::_id_8ACD();
  var_5 = scripts\anim\utility_common::_id_8AD4();
  var_6 = var_1 == "sidearm";
  var_7 = var_1 == "secondary";
  var_8 = var_1 == "primary";

  if(var_3 && var_5 != var_6) {
    if(var_5) {
      var_9 = "none";
    } else {
      var_9 = "back";
    }

    _id_B17E(self._id_04F6, var_9);
    self._id_90C6 = self._id_04F6;
  } else
    self._id_90C6 = var_2;

  if(var_3 && (var_4 && var_8)) {
    self._id_90C6 = self._id_04F6;
  } else {
    _id_B17E(var_2, "right");
  }

  if(var_6) {
    self._id_03D6 = var_2;
  } else if(var_7) {
    self._id_03B5 = var_2;
  } else {
    self._id_034C = var_2;
  }

  self._id_04F6 = var_2;
  self._id_00CC = weaponclipsize(self._id_04F6);
  self notify("weapon_switch_done");
  _id_FD87(weaponclass(self._id_04F6));
}

_id_FD87(var_0) {
  if(!isDefined(self._id_0B67) || _id_06BD::_id_23CE() || !isDefined(self._id_1C30) || !isDefined(self._id_1C30._id_1A35)) {
    return;
  }
  var_1 = self _meth_87CE();

  if(var_0 == "pistol" && _func_031B(var_1 + "_pistol")) {
    self _meth_87CB("weapon", var_1 + "_pistol");
  } else if(var_0 == "mg" && _func_031B(var_1 + "_lmg")) {
    self _meth_87CB("weapon", var_1 + "_lmg");
  } else {
    self _meth_87CC("weapon");
  }
}

_id_56CC() {
  if(scripts\anim\utility_common::_id_8A2E(self._id_03B5)) {
    return 1;
  }

  if(weaponclass(self._id_034C) == "rocketlauncher") {
    return 1;
  }

  return 0;
}

_id_459F(var_0) {
  if(!isDefined(self._id_E9D1)) {
    if(istrue(self._id_24FB)) {
      self._id_E9D1 = "thigh";
    } else {
      self._id_E9D1 = anim._id_E9D2;
    }
  }

  if(istrue(self._id_CF80)) {
    if(isDefined(level._id_5DB9)) {
      if(isDefined(self._id_CF81)) {
        self._id_034C = [[level._id_5DB9]](self._id_CF81);
        self._id_CF81 = undefined;
      }

      if(isDefined(self._id_CF83)) {
        self._id_03D6 = [[level._id_5DB9]](self._id_CF83, "sidearm");
        self._id_CF83 = undefined;
      }

      if(isDefined(self._id_CF82)) {
        self._id_03B5 = [[level._id_5DB9]](self._id_CF82);
        self._id_CF82 = undefined;
      }
    }
  } else if(!istrue(self._id_FEC7) && (!isDefined(self._id_1210) || !(self._id_1210 == "actor_enemy_cp_rus_desert_ar_ak_laser" || self._id_1210 == "actor_enemy_cp_rus_desert_sniper_nvg"))) {
    if(!scripts\common\utility::issp()) {
      if(isweapon(self._id_034C)) {
        var_1 = getweaponbasename(self._id_034C);

        if(!scripts\common\utility::iscp()) {
          var_1 = [[level._id_5D91]](var_1);
        }

        if(var_1 != "none") {
          self._id_034C = [[level._id_5D69]](var_1, [], "none", "none");
        }
      } else
        self._id_034C = [[level._id_5D69]](self._id_034C, [], "none", "none");

      if(isweapon(self._id_03B5)) {
        var_1 = getweaponbasename(self._id_03B5);

        if(!scripts\common\utility::iscp()) {
          var_1 = [[level._id_5D91]](var_1);
        }

        if(var_1 != "none") {
          self._id_03B5 = [[level._id_5D69]](var_1, [], "none", "none");
        }
      } else
        self._id_03B5 = [[level._id_5D69]](self._id_03B5, [], "none", "none");

      if(isweapon(self._id_03D6)) {
        var_1 = getweaponbasename(self._id_03D6);

        if(!scripts\common\utility::iscp()) {
          var_1 = [[level._id_5D91]](var_1);
        }

        if(var_1 != "none") {
          self._id_03D6 = [[level._id_5D69]](var_1, [], "none", "none");
        }
      } else
        self._id_03D6 = [[level._id_5D69]](self._id_03D6, [], "none", "none");
    } else {
      self._id_034C = [[level._id_5D69]](self._id_034C, []);
      self._id_03B5 = [[level._id_5D69]](self._id_03B5, []);
      self._id_03D6 = [[level._id_5D69]](self._id_03D6, []);
    }
  }

  self._id_10D1F = [];
  scripts\common\utility::_id_82BA(self._id_034C);
  scripts\common\utility::_id_82BA(self._id_03B5);
  scripts\common\utility::_id_82BA(self._id_03D6);
  var_2 = self.classname;

  if(isagent(self)) {
    var_2 = self._id_1210;
  }

  var_3 = scripts\engine\utility::ter_op(isDefined(self._id_57EE), self._id_57EE, "");
  self _meth_8309();
  self._id_0DDF._id_10DC1 = [];
  self._id_0DDF._id_10DC2 = [];
  self._id_90C6 = self._id_04F6;
  var_4 = scripts\anim\utility_common::_id_FF1B();
  self._id_0DDF._id_A43F = var_4;

  if(var_4) {
    thread _id_C984();
  }

  self._id_037B = 100;
  _id_B17E(self._id_034C, "right");

  if(scripts\anim\utility_common::_id_8A2E(self._id_03B5)) {
    _id_B17E(self._id_03B5, "back");
  }

  if(!isnullweapon(self._id_03D6) && isDefined(self._id_E9D1)) {
    _id_B17E(self._id_03D6, self._id_E9D1);
  }

  if(self.team != "allies") {
    self._id_7505 = 1;
  }

  scripts\anim\weaponlist::_id_C194();
  _id_FD90(self._id_04F6);
  thread _id_ABD8();
}

_id_ABD8() {
  self endon("death");

  for(;;) {
    self waittill("weapon_change", var_0);
    _id_FD90(var_0);
  }
}

_id_FD90(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0.classname;

    if(isDefined(self._id_10D1F[var_1])) {
      self._id_0500 = self._id_10D1F[var_1]._id_9CA8;
      self._id_0501 = self._id_10D1F[var_1].attackercountaccuracymodifier;
    } else {
      self._id_0500 = 512;
      self._id_0501 = 0.75;
    }
  }
}

_id_8179() {
  anim._id_A77A = randomintrange(0, 15);
  anim._id_A779 = randomintrange(0, 10);
  anim._id_A499 = gettime() + randomintrange(0, 20000);
  anim._id_A49A = gettime() + randomintrange(0, 10000);
  anim._id_A496 = gettime() + randomintrange(0, 15000);
  anim._id_A490 = gettime() + randomintrange(0, 1000);
}

_id_812A() {
  level._id_8F88 = [];
  level._id_8F88["axis"] = 0;
  level._id_8F88["allies"] = 0;
  level._id_8F88["team3"] = 0;
  level._id_8F88["neutral"] = 0;
  level._id_8F86 = [];
  level._id_8F86["axis"] = (0, 0, 0);
  level._id_8F86["allies"] = (0, 0, 0);
  level._id_8F86["team3"] = (0, 0, 0);
  level._id_8F86["neutral"] = (0, 0, 0);
  level._id_8F87 = [];
  level._id_8F87["axis"] = (0, 0, 0);
  level._id_8F87["allies"] = (0, 0, 0);
  level._id_8F87["team3"] = (0, 0, 0);
  level._id_8F87["neutral"] = (0, 0, 0);
  level._id_8F85 = [];
  level._id_11DA = [];
  level._id_11DA["axis"] = 0;
  level._id_11DA["allies"] = 0;
  level._id_11DA["team3"] = 0;
  level._id_11DA["neutral"] = 0;
  level._id_11DC = 2000;
  level._id_11DB = 3;
}

_id_821E() {
  anim._id_9D78["c6"] = 0;
  anim._id_9D75["c6"] = 9000;
  anim._id_9D77["c6"] = 0;
  anim._id_9D76["c6"] = 15000;
  anim._id_9D78["seeker"] = 0;
  anim._id_9D75["seeker"] = 9000;
  anim._id_9D77["seeker"] = 0;
  anim._id_9D76["seeker"] = 15000;
}

_id_80C0() {
  if(isDefined(anim._id_E497) && anim._id_E497) {
    return;
  }
  anim._id_E48C = [];
  anim._id_E48D = [];
  anim._id_E4A8 = [];
  anim._id_E496 = [];
  anim._id_E4A6 = 0;
  anim._id_E497 = 1;
}

_id_8137() {
  anim._id_18A7 = 0;
  anim._id_3AB5 = 10000;
  anim._id_3AB6 = 6000;
  anim._id_10DD1 = [];
  anim._id_10DD1["c12"] = ::_id_2E0D;
  anim._id_4B44 = [];
  anim._id_10DDB = ::_id_B066;

  if(!isDefined(anim._id_AC55)) {
    anim._id_AC55 = [];
  }

  if(!isDefined(anim._id_AC57)) {
    anim._id_AC57 = [];
  }

  if(!isDefined(anim._id_AC52)) {
    anim._id_AC52 = [];
  }

  if(!isDefined(anim._id_DA27)) {
    anim._id_DA27 = scripts\anim\utility::_id_DA29;
  }

  if(!isDefined(anim._id_DA34)) {
    anim._id_DA34 = scripts\anim\utility::_id_DA33;
  }

  anim._id_5B46 = [];
  anim._id_8FA6 = -100000;
  anim._id_2DAE = scripts\anim\utility::_id_1B8A(1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5);
  anim._id_59BB = scripts\anim\utility::_id_1B8A(2, 3, 3, 3, 4, 4, 4, 5, 5);
  anim._id_D090 = scripts\anim\utility::_id_1B8A(1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5);
  anim._id_20F5 = [];
  anim._id_20F4 = 0;
}

_id_2E02() {
  if(scripts\anim\utility_common::_id_FF1B()) {
    return "rocket";
  } else if(scripts\anim\utility_common::_id_FF1A()) {
    return "minigun";
  }

  return undefined;
}

_id_2E0D() {
  self.weapons = [];

  if(!isnullweapon(self._id_034C)) {
    self._id_04F6 = self._id_034C;
    self.weapons["right"] = _id_2E02();
  }

  if(!isnullweapon(self._id_03B5)) {
    self._id_04F6 = self._id_03B5;
    self.weapons["left"] = _id_2E02();
  }

  self._id_04F6 = _func_0375();
  self._id_00CC = 1;
}

_id_82BD() {
  level._id_10E3A[0] = -36.8552;
  level._id_10E3A[1] = -27.0095;
  level._id_10E3A[2] = -15.5981;
  level._id_10E3A[3] = -4.37769;
  level._id_10E3A[4] = 17.7776;
  level._id_10E3A[5] = 59.8499;
  level._id_10E3A[6] = 104.808;
  level._id_10E3A[7] = 152.325;
  level._id_10E3A[8] = 201.052;
  level._id_10E3A[9] = 250.244;
  level._id_10E3A[10] = 298.971;
  level._id_10E3A[11] = 330.681;
}

_id_D8A9() {
  anim._id_BFFF = 60;
  anim._id_BFFE = [];

  for(var_0 = 0; var_0 < anim._id_BFFF; var_0++) {
    anim._id_BFFE[var_0] = var_0;
  }

  for(var_0 = 0; var_0 < anim._id_BFFF; var_0++) {
    var_1 = randomint(anim._id_BFFF);
    var_2 = anim._id_BFFE[var_0];
    anim._id_BFFE[var_0] = anim._id_BFFE[var_1];
    anim._id_BFFE[var_1] = var_2;
  }
}

_id_D8C7() {
  self endon("death");
  scripts\engine\utility::_id_5C24("load_finished");

  if(isDefined(anim._id_10DD1) && isDefined(anim._id_10DD1[self._id_04B9])) {
    self[[anim._id_10DD1[self._id_04B9]]]();
  } else {
    _id_459F();
  }
}

_id_D6BE(var_0, var_1, var_2) {
  if(isDefined(var_1._id_CC97)) {
    self _meth_81F6(var_1._id_CC97, var_1._id_CC98);
  } else if(isDefined(var_1._id_CC98)) {
    self _meth_81F6(var_1._id_CC97, var_1._id_CC98);
  }

  if(isDefined(var_1._id_CC95)) {
    self _meth_81F6(var_1._id_CC95, var_1._id_CC96, undefined, 1);
  } else if(isDefined(var_1._id_CC96)) {
    self _meth_81F6(var_1._id_CC95, var_1._id_CC96, undefined, 1);
  }

  if(isDefined(var_1._id_CC99)) {
    self _meth_81F6(weaponclipsize(self), weaponmaxammo(self));
  }

  if(istrue(var_2)) {
    self _meth_81F6(1, 6, 0, 1);
  } else if(issubstr(var_0, "ub_golf25_sp") || issubstr(var_0, "ub_mike203_sp")) {
    self _meth_81F6(1, 1, 0, 1);
  }
}