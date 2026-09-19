/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1384.gsc
**************************************/

init() {
  level._id_0A41["zombie_klaus"] = level._id_0A41["zombie"];
  level._id_0A41["zombie_klaus"]["think"] = ::_id_5A9A;
  level._id_0A41["zombie_klaus"]["move_mode"] = ::_id_5A8F;
  level._id_0A41["zombie_klaus"]["on_damaged"] = ::_id_5A92;
  level._id_0A41["zombie_klaus"]["on_damaged_finished"] = ::_id_5A91;
  level._id_0A41["zombie_klaus"]["is_hit_weak_point"] = ::_id_5A8E;
  var_0 = spawnStruct();
  var_0._id_0A4B = "zombie_klaus";
  var_0._id_0EAE = "zombie_animclass";
  var_0._id_0879 = "zombie_generic";
  var_0._id_4C12 = 1;
  var_0._id_60E2 = 0;
  var_0._id_2F9B = 1;
  var_0.parenttype = "zombie_generic";
  var_0._id_5ED2["revived klaus"]["whole_body"] = "zom_klaus_wholebody";
  _id_0547::_id_0A52(var_0, "zombie_klaus");
  _id_0547::_id_7BD0("klauspossum", ::_id_5A93, ::_id_5A95, 8);
}

_id_5A9A() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  maps\mp\agents\humanoid\_humanoid::_id_8A27();
  thread _id_0547::_id_A692();
  self _meth_85A1("zombie");
  self._id_480F = 1;
  self._id_6816 = 1;
  self._id_00CE = 1;
  self.shouldnotpreventlaststand = 1;
  self.failsafe_exempt = 1;
  self._id_55AB = 1;
  self._id_562B = 1;
  self._id_00CF = 1;
  self._id_0C29 = 0;
  self.ispassiveexempt = 1;
  self._id_2FA4 = 1;
  self _meth_8539(0);
  self _meth_8540(1);
  self _meth_853E(1);
  self _meth_85E0(1);

  for(;;) {
    if(_id_053C::_id_4F9B()) {} else
      _id_053C::_id_0647();

    wait 0.2;
  }
}

_id_5A92(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {}

_id_5A91(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {}

_id_5A8E() {
  return 0;
}

_id_5A8F() {
  return "walk";
}

_id_5A97(var_0, var_1) {
  var_2 = _id_054D::_id_90BA("zombie_klaus", var_0, "klaus", 0, 1, 0);
  var_2.origin = var_0.origin;
  var_2.angles = var_0.angles;
  var_2._id_509A = 1;
  self._id_00CE = 1;
  self.shouldnotpreventlaststand = 1;
  self.failsafe_exempt = 1;
  self._id_55AB = 1;
  self._id_562B = 1;
  self._id_00CF = 1;
  self._id_0C29 = 0;
  self.ispassiveexempt = 1;
  var_2 maps\mp\agents\_agent_utility::_id_83FE(level._id_746E);
  var_2._id_6701 = 1;

  if(common_scripts\utility::_id_562E(var_1))
    var_2 _id_0547::_id_84CB();
  else
    var_2 thread _id_0547::_id_7D1A("klauspossum");

  return var_2;
}

_id_5A93() {
  _id_0366::_id_8E48(0);
  var_0 = "s2_klaus_revive";
  maps\mp\agents\humanoid\_humanoid_util::_id_8318(self.origin, self.angles, var_0, 0, 0, undefined, 1, 1, "klaus_getup");
  self _meth_83A2(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "ScriptedAnimation");
  self _meth_839C("anim deltas");
  self _meth_839B("face angle abs", self.angles);
  self _meth_839D("noclip");
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_0, 1, 1, "scripted_anim", "end", undefined);
  _id_5A94();
}

_id_5A94() {
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "ScriptedAnimation");
  self _meth_83A2(0);
  self _meth_839D("gravity");
  _id_0547::_id_84CB();
  self notify("klaus_getup_finished");
}

_id_5A95() {
  _id_5A94();
}

_id_5A90(var_0) {
  self._id_1928 = var_0;
  _id_5A9B(var_0);
}

_id_5A9B(var_0) {
  var_1 = 75;

  for(;;) {
    if(distance(self.origin, var_0.origin) < var_1) {
      break;
    }

    wait 0.1;
  }
}

_id_5A98() {
  self._id_5A8B = 1;
  self._id_78C5 = _func_2A8(common_scripts\utility::_id_44F5("temp_klaus_radius"), self, "J_MainRoot");
  _func_14C(self._id_78C5);
  self._id_78C5 thread _id_0547::_id_2D19(self);
  thread _id_5A8C();
}

_id_5A99() {
  self._id_5A8B = 0;
  self._id_78C5 delete();
  self notify("stop_aura");

  foreach(var_1 in level.players) {
    var_1 _id_0547::_id_7458(0, "klaus_aura");
    var_1._id_5377 = 0;
  }
}

_id_5A8C() {
  self endon("stop_aura");
  self endon("death");
  thread klaus_knockback_effect_think();

  for(;;) {
    if(common_scripts\utility::_id_562E(self._id_5A8B)) {
      foreach(var_1 in level.players) {
        var_2 = _func_0E1(var_1.origin, self.origin) < 256 && _func_0AE(var_1.origin[2] - self.origin[2]) < 64.0 && !_id_0547::_id_577E(var_1);

        if(var_2) {
          var_1 _id_0547::_id_7454(3);
          var_3 = _id_0547::_id_408F();

          foreach(var_5 in var_3) {
            if(distance(var_5.origin, var_1.origin) > 128) {
              continue;
            }
            var_5 _meth_8059(500, var_1.origin, var_1);
          }
        }

        if(common_scripts\utility::_id_562E(var_1._id_5377) == var_2) {
          continue;
        }
        var_1._id_5377 = var_2;
        var_1 _id_0547::_id_7458(var_2, "klaus_aura");
      }
    }

    wait 1;
  }
}

klaus_knockback_effect_think() {
  self endon("stop_aura");
  self endon("death");

  for(;;) {
    if(common_scripts\utility::_id_562E(self._id_5A8B)) {
      foreach(var_1 in level.players) {
        if(!isalive(var_1)) {
          continue;
        }
        if(_id_0547::_id_577E(var_1)) {
          continue;
        }
        if(var_1 istouching(self)) {
          var_2 = 200;
          var_3 = 1 - distance(self.origin + (0, 0, 42), var_1.origin) / var_2;

          if(var_3 < 0)
            var_3 = 0;

          var_1 klaus_knockback(self.origin + (0, 0, 42), var_3 * var_2 + 100);
        }
      }
    }

    waitframe();
  }
}

klaus_knockback(var_0, var_1) {
  var_2 = self.origin - var_0;
  var_3 = var_1 * vectorNormalize(var_2);
  var_3 = (var_3[0], var_3[1], 150);

  if(var_1 > 0)
    self _meth_82F7(var_3);
}

_id_5A96() {
  thread _id_5A99();
  var_0 = "s2_klaus_death";
  self _meth_83A2(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "ScriptedAnimation");
  self _meth_839C("anim deltas");
  self _meth_839B("face angle abs", self.angles);
  self _meth_839D("noclip");
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_0, 0, 1, "scripted_anim", "disapear", undefined);
  self._id_1DEB = 1;
  self suicide();
}