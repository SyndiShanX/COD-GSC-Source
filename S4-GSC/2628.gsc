/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2628.gsc
*************************************************/

_id_5C81(var_0) {
  self._id_5C8A = var_0;
  self._id_5C89 = [];
  thread _id_8E44();
}

_id_5C82(var_0, var_1) {
  var_2 = "tag_origin";

  if(!isDefined(var_0)) {
    var_0 = "vehicle_flares";
  }

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  playsoundatpos(self gettagorigin(var_2), "ks_apache_flares");
  playFXOnTag(level._effect[var_0], self, var_2);
}

_id_5C76() {
  var_0 = spawn("script_origin", self.origin + (0, 0, -256));
  var_0.angles = self.angles;
  var_0 movegravity((0, 0, -1), 5.0);
  self._id_5C89[self._id_5C89.size] = var_0;
  var_0 thread _id_5C75(5.0, 2.0, self);
  return var_0;
}

_id_5C75(var_0, var_1, var_2) {
  if(isDefined(var_1) && isDefined(var_2)) {
    var_0 = var_0 - var_1;
    wait(var_1);

    if(isDefined(var_2)) {
      var_2._id_5C89 = scripts\engine\utility::array_remove(var_2._id_5C89, self);
    }
  }

  wait(var_0);
  self delete();
}

_id_5C7D(var_0) {
  return var_0._id_5C8A;
}

_id_5C73(var_0) {
  _id_5C74(var_0);
  return var_0._id_5C8A > 0 || var_0._id_5C89.size > 0;
}

_id_5C7C(var_0) {
  _id_5C84(var_0);
  var_0 thread _id_5C82();
  var_1 = var_0 _id_5C76();
  return var_1;
}

_id_5C74(var_0) {
  var_0._id_5C89 = scripts\engine\utility::_id_1BD1(var_0._id_5C89);
}

_id_5C7B(var_0) {
  _id_5C74(var_0);
  var_1 = undefined;

  if(var_0._id_5C89.size > 0) {
    var_1 = var_0._id_5C89[var_0._id_5C89.size - 1];
  }

  return var_1;
}

_id_8E44() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  while(_id_5C73(self)) {
    level waittill("laserGuidedMissiles_incoming", var_0, var_1, var_2);

    if(!isDefined(var_2) || var_2 != self) {
      continue;
    }
    if(!_func_0107(var_1)) {
      var_1 = [var_1];
    }

    foreach(var_4 in var_1) {
      if(_func_0128(var_4)) {
        level thread _id_8E45(var_4, var_0, var_0.team, var_2);
      }
    }
  }
}

_id_8E45(var_0, var_1, var_2, var_3) {
  var_3 endon("death");
  var_0 endon("death");
  var_0 endon("missile_targetChanged");

  while(_id_5C73(var_3)) {
    if(!isDefined(var_3) || !_func_0128(var_0)) {
      break;
    }

    var_4 = var_3 _meth_8174(0, 0, 0);

    if(distancesquared(var_0.origin, var_4) < 4000000) {
      var_5 = _id_5C7B(var_3);

      if(!isDefined(var_5)) {
        var_5 = _id_5C7C(var_3);
      }

      scripts\cp_mp\utility\weapon_utility::_id_3971(var_0);
      var_0 missile_settargetent(var_5);
      var_0 notify("missile_pairedWithFlare");
      break;
    }

    waitframe();
  }
}

_id_5C7E(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  for(;;) {
    level waittill("sam_fired", var_1, var_2, var_3);

    if(!isDefined(var_3) || var_3 != self) {
      continue;
    }
    if(isDefined(var_0)) {
      level thread[[var_0]](var_1, var_1.team, var_3, var_2);
      continue;
    }

    level thread _id_5C86(var_1, var_1.team, var_3, var_2);
  }
}

_id_5C86(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_2 endon("death");

  for(;;) {
    var_4 = var_2 _meth_8174(0, 0, 0);
    var_5 = [];

    for(var_6 = 0; var_6 < var_3.size; var_6++) {
      if(isDefined(var_3[var_6])) {
        var_5[var_6] = distance(var_3[var_6].origin, var_4);
      }
    }

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      if(isDefined(var_5[var_6])) {
        if(var_5[var_6] < 4000 && var_2._id_5C8A > 0) {
          _id_5C84(var_2);
          var_2 thread _id_5C82();
          var_7 = var_2 _id_5C76();

          for(var_8 = 0; var_8 < var_3.size; var_8++) {
            if(isDefined(var_3[var_8])) {
              scripts\cp_mp\utility\weapon_utility::_id_3971(var_3[var_8]);
              var_3[var_8] missile_settargetent(var_7);
              var_3[var_8] notify("missile_pairedWithFlare");
            }
          }

          return;
        }
      }
    }

    waitframe();
  }
}

_id_5C7F(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  if(!isDefined(self._id_5C89)) {
    self._id_5C89 = [];
  }

  for(;;) {
    level waittill("stinger_fired", var_2, var_3, var_4);

    if(!isDefined(var_4) || var_4 != self) {
      continue;
    }
    if(isDefined(var_0)) {
      var_3 thread[[var_0]](var_2, var_2.team, var_4, var_1);
      continue;
    }

    var_3 thread _id_5C87(var_2, var_2.team, var_4, var_1);
  }
}

_id_5C87(var_0, var_1, var_2, var_3) {
  self endon("death");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 _meth_8174(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2._id_5C8A > 0) {
      _id_5C84(var_2);
      var_2 thread _id_5C82(undefined, var_3);
      var_6 = var_2 _id_5C76();
      scripts\cp_mp\utility\weapon_utility::_id_3971(self);
      self missile_settargetent(var_6);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

_id_5C84(var_0) {
  var_0._id_5C8A--;

  if(isDefined(var_0.owner)) {
    var_0.owner setclientomnvar("ui_killstreak_flares", var_0._id_5C8A);
  }
}

_id_8E49(var_0, var_1, var_2, var_3) {
  self._id_5C8A = var_0;
  self._id_5C89 = [];

  if(isDefined(var_2)) {
    self.owner setclientomnvar(var_2, var_0);
  }

  thread _id_8E48(var_1, var_2);
  thread _id_8E46(var_3);
}

_id_8E48(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  if(!isai(self.owner)) {
    self.owner notifyonplayercommand("manual_flare_popped", var_0);
  }

  while(_id_5C7D(self)) {
    self.owner waittill("manual_flare_popped");
    var_2 = _id_5C7C(self);

    if(isDefined(var_2) && isDefined(self.owner) && !isai(self.owner)) {
      self.owner playlocalsound("ks_ac130_flares");

      if(isDefined(var_1)) {
        self.owner setclientomnvar(var_1, _id_5C7D(self));
      }
    }
  }
}

_id_8E46(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("helicopter_done");

  while(_id_5C73(self)) {
    self waittill("targeted_by_incoming_missile", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    self.owner thread _id_8E4B(self, "missile_incoming");

    if(isDefined(var_0)) {
      var_2 = vectornormalize(var_1[0].origin - self.origin);
      var_3 = vectornormalize(anglestoright(self.angles));
      var_4 = vectordot(var_2, var_3);
      var_5 = 1;

      if(var_4 > 0) {
        var_5 = 2;
      } else if(var_4 < 0) {
        var_5 = 3;
      }

      self.owner setclientomnvar(var_0, var_5);
    }

    foreach(var_7 in var_1) {
      if(_func_0128(var_7)) {
        thread _id_8E47(var_7);
      }
    }
  }
}

_id_8E47(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    if(!isDefined(self) || !_func_0128(var_0)) {
      break;
    }

    var_1 = self _meth_8174(0, 0, 0);

    if(distancesquared(var_0.origin, var_1) < 4000000) {
      var_2 = _id_5C7B(self);

      if(isDefined(var_2)) {
        scripts\cp_mp\utility\weapon_utility::_id_3971(var_0);
        var_0 missile_settargetent(var_2);
        var_0 notify("missile_pairedWithFlare");
        self.owner _meth_83EF("missile_incoming");
        break;
      }
    }

    waitframe();
  }
}

_id_8E4B(var_0, var_1) {
  self endon("disconnect");
  var_0 waittill("death");
  self _meth_83EF(var_1);
}