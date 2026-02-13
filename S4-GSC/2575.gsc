/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2575.gsc
*************************************************/

_id_8B6E() {
  level._id_8B78 = [];
  level._effect["jammer_destroyed"] = loadfx("vfx/s4/equipment/vfx_jammer_damaged");
}

_id_8B65() {
  var_0 = 0;

  foreach(var_2 in level._id_8B78) {
    foreach(var_4 in var_2) {
      var_0++;

      if(var_0 > 1) {
        return 0;
      }
    }
  }

  return 1;
}

_id_8B66(var_0) {
  jammer_add_to_level_jammers(self, var_0);
  var_0.owner = self;
  var_0._id_75E9 = var_0 thread _id_078F::_id_D594(0, 8);
  var_1 = getgroundposition(self.origin, 1);
  var_2 = spawn("script_model", var_1);
  var_0._id_CC53 = var_2;
  var_0._id_CC53.owner = self;
  var_0._id_CC53.team = self.team;
  var_0._id_CC53 setotherent(self);
  var_2 _meth_8223(self);
  thread _id_084C::jammer_plant(self, var_2);
  var_0 _meth_86FE("equipment");

  if(level.teambased) {
    var_0 _meth_8706(self.team);
  } else {
    var_0 _meth_8706(self);
  }

  var_0 thread _id_8B67(self);
  var_0 thread _id_07CD::_id_C33E(::_id_8B68, 1, 1);
  var_0 thread jammer_watch_for_disowned();
  var_0 thread jammer_watch_lifetime();
  var_0 thread scripts\mp\equipment::equipmentwatchoob(::_id_8B68);
  var_0._id_CC53 thread _id_8B76(self);
}

jammer_watch_lifetime() {
  self endon("death");
  wait 30;
  _id_8B68();
}

jammer_watch_for_disowned() {
  self endon("death");
  self._id_CC53.owner scripts\engine\utility::_id_10882("joined_team", "joined_spectators", "disconnect", "game_ended");
  _id_8B68();
}

_id_8B6A() {}

_id_8B74() {
  var_0 = self getentitynumber();

  if(!isDefined(level._id_8B78[var_0])) {
    return;
  }
  foreach(var_2 in level._id_8B78[var_0]) {
    var_2 _id_8B68();
  }
}

_id_8B67(var_0) {
  _id_07C3::_id_A0FF(150, "hitequip", ::_id_8B6C, ::_id_8B70, 0);
}

_id_8B70(var_0) {
  var_1 = var_0.objweapon;
  var_2 = var_0._id_9CD6;
  return _id_07C3::_id_7468(var_1, var_2, var_0.damage);
}

_id_8B6C(var_0) {
  var_1 = var_0.attacker;

  if(isDefined(self.owner) && istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_1))) {
    var_1 scripts\mp\battlechatter_mp::_id_555B(self);
    var_1 scripts\mp\killstreaks\killstreaks::_id_6FEA(self);
    var_2 = self.owner getentitynumber();

    if(level._id_8B78[var_2].size > 1) {
      self.owner thread _id_0A8D::_id_9137("ja_destroyed_m");
    } else {
      self.owner thread _id_0A8D::_id_9137("ja_destroyed_s");
    }
  }

  var_3 = scripts\engine\utility::ter_op(isDefined(var_0.objweapon), var_0.objweapon, "");

  if(var_1.team != self.team && isDefined(self._id_014E) && self._id_014E >= self.maxhealth) {
    var_1 thread _id_07BC::createfieldupgradechallengeevent("destroy", var_3);
  }

  _id_8B68();
}

_id_8B68() {
  self.owner notify("jammer_destroyed");

  if(isDefined(self.owner)) {
    jammer_remove_from_level_jammers(self.owner, self);
  }

  _id_078F::_id_D593(self._id_75E9);
  playFX(level._effect["jammer_destroyed"], self.origin);
  thread _id_084C::jammer_explode(self.owner, self.origin);
  earthquake(0.5, 1, self.origin, 512);
  self._id_CC53 _id_8B69();
  self._id_CC53 _meth_8084();
  self._id_CC53 delete();
  self setscriptablepartstate("hacked", "neutral", 0);
  self delete();
}

_id_8B76(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("scramble_super_finished");

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = self.owner;
  }

  self._id_5374 = [];
  var_1 = 0;
  var_2 = 500.0;
  var_3 = physics_createcontents(["physicscontents_characterproxy"]);
  var_4 = self.origin;
  var_5 = (var_2, var_2, 3000);
  var_6 = var_4 - var_5;
  var_7 = var_4 + var_5;

  for(;;) {
    var_8 = _func_02BF(var_6, var_7, var_3, []);

    foreach(var_10 in level.players) {
      if(scripts\engine\utility::array_contains(var_8, var_10)) {
        var_11 = var_10;
        var_12 = 0;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
          var_12 = var_11[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_scrambler_resist");
        }

        var_13 = distance2dsquared(self.origin, var_11.origin);
        var_14 = var_2 * var_2;

        if(isDefined(var_11) && var_13 < var_14 && var_11 scripts\cp_mp\utility\player_utility::_isalive() && !var_12) {
          if(var_1 || level.teambased && var_11.team != self.team && var_11.team != "spectator" || !level.teambased && var_11 != self.owner) {
            if(var_11 scripts\cp_mp\utility\player_utility::_id_8ACE()) {
              continue;
            }
            if(var_11 _id_8B6B(self, var_1)) {
              continue;
            }
            var_11 _id_8B73(1, self, var_1);
            var_11._id_8A19 = 1;
          } else if(isDefined(var_11._id_CC52) && var_11._id_CC52 == self) {
            if(scripts\engine\utility::array_contains(self._id_5374, var_11)) {
              self._id_5374 = scripts\engine\utility::array_remove(self._id_5374, var_11);
            } else {
              self._id_5374 = scripts\engine\utility::_id_1BD1(self._id_5374);
            }

            if(var_11 _id_8B6B(self, var_1)) {
              continue;
            }
            if(var_11 scripts\cp_mp\utility\player_utility::_id_8ACE()) {
              continue;
            }
            var_11._id_8A19 = 0;
            var_11 notify("scramble_off");
          }
        }

        continue;
      }

      var_15 = var_10;

      if(istrue(var_15._id_8A19)) {
        var_15 notify("scramble_off");
      }

      var_15._id_8A19 = 0;
    }

    waitframe();
  }
}

_id_8B6B(var_0, var_1) {
  var_2 = 0;
  var_3 = undefined;

  if(isDefined(level._id_EB9A) && level._id_EB9A.size > 0) {
    foreach(var_5 in level._id_EB9A) {
      if(var_5._id_786F != "scrambler_drone_guard") {
        continue;
      }
      if(level.teambased) {
        if(!isDefined(var_1) && var_5.team == self.team) {
          var_3 = var_5._id_5F72;
        } else {
          var_3 = var_5._id_5374;
        }
      } else if(!isDefined(var_1) && var_5.owner == self)
        var_3 = var_5._id_5F72;
      else {
        var_3 = var_5._id_5374;
      }

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.size > 0) {
        foreach(var_7 in var_3) {
          if(self == var_7 || isDefined(var_7.owner) && self == var_7.owner) {
            var_2 = 1;
            break;
          }
        }

        if(istrue(var_2)) {
          break;
        }
      }
    }
  }

  return var_2;
}

_id_8B73(var_0, var_1, var_2) {
  var_3 = self;

  if(istrue(var_0)) {
    if(isDefined(var_3._id_41EC)) {
      return;
    }
    var_3._id_CC52 = var_1;

    if(!scripts\engine\utility::array_contains(var_1._id_5374, var_3)) {
      var_1._id_5374[var_1._id_5374.size] = var_3;
    }

    var_3 thread _id_8B6F(var_1, var_2);
    var_3 thread _id_8B75(var_1);
  } else if(isDefined(var_3)) {
    var_3._id_CC52 = undefined;
    var_3 _id_078D::_id_E891(var_3._id_41EC);
    var_3._id_BC43 = undefined;
    var_3._id_41EC = undefined;
  }
}

_id_8B6F(var_0, var_1) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("death", "scramble_off");

  if(isDefined(self)) {
    if(isDefined(var_0) && isDefined(var_0._id_5374)) {
      var_0._id_5374 = scripts\engine\utility::array_remove(var_0._id_5374, self);
    }
  }

  _id_8B73(0, var_0, var_1);
}

_id_8B75(var_0) {
  self endon("death");
  self endon("scramble_off");
  self endon("disconnect");
  var_0 endon("death");
  var_1 = 0;
  var_2 = 0;
  var_3 = 500.0;
  var_4 = var_3 * var_3;

  for(;;) {
    var_5 = distance2dsquared(var_0.origin, self.origin);

    if(var_5 > var_4) {
      var_2 = 0;
    } else if(var_5 >= var_4 * 0.8) {
      var_2 = 1;
    } else if(var_5 >= var_4 * 0.6) {
      var_2 = 2;
    } else if(var_5 >= var_4 * 0.4) {
      var_2 = 3;
    } else if(var_5 >= var_4 * 0.2) {
      var_2 = 4;
    } else {
      var_2 = 5;
    }

    if(var_1 == 0 || var_2 != var_1) {
      self._id_BC43 = var_1;
      self._id_41EC = var_2;

      if(self._id_BC43 > 1) {
        var_6 = self._id_BC43;
      }

      if(self._id_41EC > 1) {
        var_6 = self._id_41EC;
      }

      _id_078D::_id_E891(var_1);
      _id_078D::_id_B21E(var_2);
      var_1 = var_2;
    }

    waitframe();
  }
}

_id_8B69() {
  self notify("scramble_super_finished");

  if(isDefined(self._id_5374) && self._id_5374.size > 0) {
    foreach(var_1 in self._id_5374) {
      if(isDefined(var_1)) {
        var_2 = var_1;
        var_2._id_8A19 = 0;

        if(isDefined(var_2.owner)) {
          var_2 = var_2.owner;
        }

        var_2 notify("scramble_off");
      }
    }
  }

  if(isDefined(self._id_5F72) && self._id_5F72.size > 0) {
    foreach(var_5 in self._id_5F72) {
      if(isDefined(var_5)) {
        var_5._id_8A19 = 0;
        var_5 notify("scramble_off");
      }
    }
  }
}

jammer_remove_from_level_jammers(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  var_3 = [];

  for(var_4 = 0; var_4 < level._id_8B78[var_2].size; var_4++) {
    var_5 = level._id_8B78[var_2][var_4];

    if(var_5 != var_1) {
      var_3[var_3.size] = var_5;
    }
  }

  level._id_8B78[var_2] = var_3;
}

jammer_add_to_level_jammers(var_0, var_1) {
  var_2 = var_0 getentitynumber();

  if(!isDefined(level._id_8B78[var_2])) {
    level._id_8B78[var_2] = [];
  }

  var_3 = level._id_8B78[var_2].size;

  if(var_3 + 1 > 2) {
    level._id_8B78[var_2][0] _id_8B68();
    var_3--;
  }

  level._id_8B78[var_2][var_3] = var_1;
}

_id_8B71(var_0) {
  jammer_remove_from_level_jammers(var_0, self);
  jammer_add_to_level_jammers(self.owner, self);
  self._id_CC53.team = self.owner.team;
  self setscriptablepartstate("hacked", "active", 0);
}