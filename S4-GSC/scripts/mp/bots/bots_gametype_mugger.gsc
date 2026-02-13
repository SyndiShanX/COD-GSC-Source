/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_mugger.gsc
****************************************************/

main() {
  level._id_28F3 = 200;
  _id_D795();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_2861;
  level._id_279D["gametype_loadout_modify"] = ::_id_2860;
}

_id_2861() {
  self notify("bot_mugger_think");
  self endon("bot_mugger_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self._id_8F36 = (0, 0, 0);
  self._id_ED39 = undefined;
  self._id_75FA = 0;
  self._id_7924 = 0;
  self._id_4578 = self _meth_8030("meleeChargeDist");
  childthread _id_ED48();

  if(self _meth_8030("strategyLevel") > 0) {
    childthread _id_ED3F();
  }

  if(self _meth_8030("strategyLevel") > 0) {
    childthread _id_5403();
  }

  for(;;) {
    if(self _meth_8030("strategyLevel") > 1) {
      if(isDefined(self._id_ED70) && level._id_A2C1 <= self._id_ED70) {
        if(!self._id_7924) {
          var_0 = _func_00B4(self.origin, 1000, 0, 500, "node_hide");
          var_1 = self _meth_8049(var_0, 3, "node_hide");

          if(isDefined(var_1)) {
            self _meth_8059(var_1, "critical");
            self._id_7924 = 1;
          }
        }
      } else if(self._id_7924) {
        self _meth_802B();
        self._id_7924 = 0;
      }
    }

    if(!self._id_7924) {
      if(!isDefined(self._id_ED39) && !self._id_75FA) {
        self[[self._id_B025]]();
      }
    }

    wait 0.05;
  }
}

_id_5403() {
  for(;;) {
    if(self _meth_8030("strategyLevel") < 2) {
      wait 0.5;
    } else {
      wait 0.2;
    }

    if(isDefined(self._id_0192) && isPlayer(self._id_0192) && isDefined(self._id_0192._id_ED70) && self._id_0192._id_ED70 >= 3 && self _meth_8028(self._id_0192) && distance(self.origin, self._id_0192.origin) <= 500) {
      self _meth_8053("meleeChargeDist", 500);
      self _meth_8054("prefer_melee", 1);
      self _meth_8054("throw_knife_melee", level._id_A2EA > 0);
      continue;
    }

    self _meth_8053("meleeChargeDist", self._id_4578);
    self _meth_8054("prefer_melee", 0);
    self _meth_8054("throw_knife_melee", 0);
  }
}

_id_ED3F() {
  for(;;) {
    level waittill("mugger_tag_pile", var_0);

    if(self.health <= 0) {
      continue;
    }
    if(self._id_7924) {
      continue;
    }
    if(!isDefined(self._id_8F6B) || gettime() - self._id_8F6B > 7500) {
      self._id_8F6B = undefined;
      self._id_8F6A = undefined;
      self._id_75FA = 0;
    }

    if(!isDefined(self._id_8F6A) || distancesquared(self.origin, self._id_8F6A) > distancesquared(self.origin, var_0)) {
      self._id_8F6B = gettime();
      self._id_8F6A = var_0;
    }
  }
}

_id_278E() {
  var_0 = self _meth_815E();
  var_1 = undefined;

  if(isDefined(var_0)) {
    var_2 = 1000000;
    var_3 = scripts\engine\utility::array_combine(level._id_4CE8, level._id_A2C6);

    foreach(var_5 in var_3) {
      if(var_5 _id_07D6::_id_318C(self.team)) {
        var_6 = distancesquared(self.origin, var_5._id_4140);

        if(!isDefined(var_1) || var_6 < var_2) {
          if(self _meth_8030("strategyLevel") > 0 && var_6 < 122500 || var_6 < 1000000 && scripts\mp\bots\bots_gametype_conf::_id_2810(var_5, var_0, self _meth_8032())) {
            var_2 = var_6;
            var_1 = var_5;
          }
        }
      }
    }
  }

  return var_1;
}

_id_2797(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_0)) {
    var_3 = scripts\engine\utility::array_combine(level._id_4CE8, level._id_A2C6);

    foreach(var_5 in var_3) {
      if(var_5 _id_07D6::_id_318C(self.team)) {
        if(isPlayer(self) || distancesquared(self.origin, var_5._id_4140) < 1000000) {
          if(scripts\mp\bots\bots_gametype_conf::_id_2810(var_5, var_0, var_1)) {
            var_6 = spawnStruct();
            var_6.origin = var_5._id_4140;
            var_6._id_0427 = var_5;
            var_2[var_2.size] = var_6;
          }
        }
      }
    }
  }

  return var_2;
}

_id_ED48() {
  wait(randomfloatrange(0, 0.5));

  for(;;) {
    if(self _meth_8030("strategyLevel") == 0) {
      wait 3.0;
    } else if(self _meth_8030("strategyLevel") == 1) {
      wait 1.5;
    } else {
      wait 0.5;
    }

    if(self.health <= 0) {
      continue;
    }
    if(self._id_7924) {
      continue;
    }
    if(isDefined(self._id_0192) && isPlayer(self._id_0192) && self _meth_8028(self._id_0192)) {
      continue;
    }
    var_0 = _id_278E();

    if(isDefined(var_0)) {
      _id_A2E3(var_0);
      continue;
    }

    if(!self._id_75FA) {
      if(isDefined(self._id_8F6A) && isDefined(self._id_8F6B) && gettime() - self._id_8F6B <= 7500) {
        thread _id_A2CA(self._id_8F6A);
      }
    }
  }
}

_id_A2CA(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self._id_75FA = 1;
  var_1 = spawnStruct();
  var_1._id_CD73 = "objective";
  var_1._id_A8A8 = level._id_28F3;
  _id_09F9::_id_2862("kill_tag_pile", var_0, 25, var_1);
  var_2 = scripts\engine\utility::_id_10897("death", "tag_spotted");
  self _meth_802B();
  self._id_75FA = 0;
  _id_09F9::_id_26EF("kill_tag_pile");
}

_id_A2E3(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self._id_ED39 = var_0;
  self notify("tag_spotted");
  childthread _id_A68E(var_0, "tag_picked_up");
  _id_09F9::_id_26EF("kill_tag");
  var_1 = var_0._id_4140;

  if(scripts\mp\bots\bots_util::_id_2916(self._id_8F36, var_0._id_4140)) {
    var_2 = var_0._id_A3F8;

    if(isDefined(var_2)) {
      var_3 = var_2.origin - var_1;
      var_1 = var_1 + vectornormalize(var_3) * length(var_3) * 0.5;
    }
  }

  self._id_8F36 = var_0._id_4140;
  var_4 = spawnStruct();
  var_4._id_CD73 = "objective";
  var_4._id_A8A8 = level._id_28F3;
  _id_09F9::_id_2862("kill_tag", var_1, 25, var_4);
  thread _id_A68D("tag_aborted");
  var_5 = scripts\engine\utility::_id_10897("death", "tag_picked_up");
  self notify("tag_watch_stop");
  self._id_ED39 = undefined;
  self _meth_802B();
  _id_09F9::_id_26EF("kill_tag");
}

_id_A68D(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("tag_watch_stop");

  while(_id_09F9::_id_27ED("kill_tag")) {
    wait 0.05;
  }

  self notify(var_0);
}

_id_A68E(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("tag_watch_stop");

  while(var_0 _id_07D6::_id_318C(self.team)) {
    wait 0.05;
  }

  self notify(var_1);
}

_id_2860(var_0) {
  var_1 = 0;
  var_2 = self _meth_802F();

  if(var_2 == "recruit") {
    var_1 = 0.1;
  } else if(var_2 == "regular") {
    var_1 = 0.25;
  } else if(var_2 == "hardened") {
    var_1 = 0.6;
  } else if(var_2 == "veteran") {
    var_1 = 0.9;
  }

  var_3 = var_0["loadoutEquipment"] == "s4_throwing_knife_mp";

  if(!var_3) {
    if(var_1 >= randomfloat(1)) {
      var_0["loadoutEquipment"] = "s4_throwing_knife_mp";
      var_3 = 1;
    }
  }

  if(var_1 >= randomfloat(1)) {
    if(var_0["loadoutOffhand"] != "s4_stun_gbr_n69_mp") {
      var_0["loadoutOffhand"] = "s4_stun_gbr_n69_mp";
    }
  }

  if(var_1 >= randomfloat(1)) {
    if(var_0["loadoutPrimaryAttachment"] != "tactical" && var_0["loadoutPrimaryAttachment2"] != "tactical") {
      var_4 = _id_09F6::_id_2912(var_0["loadoutPrimary"], var_0["loadoutPrimaryAttachment"], "tactical");

      if(var_4) {
        var_0["loadoutPrimaryAttachment2"] = "tactical";
      } else {
        var_4 = _id_09F6::_id_2912(var_0["loadoutPrimary"], "tactical", var_0["loadoutPrimaryAttachment2"]);

        if(var_4) {
          var_0["loadoutPrimaryAttachment"] = "tactical";
        }
      }
    }
  }

  if(var_1 >= randomfloat(1)) {
    if(var_0["loadoutSecondaryAttachment"] != "tactical" && var_0["loadoutSecondaryAttachment2"] != "tactical") {
      var_4 = _id_09F6::_id_2912(var_0["loadoutSecondary"], var_0["loadoutSecondaryAttachment"], "tactical");

      if(var_4) {
        var_0["loadoutSecondaryAttachment2"] = "tactical";
      } else {
        var_4 = _id_09F6::_id_2912(var_0["loadoutSecondary"], "tactical", var_0["loadoutSecondaryAttachment2"]);

        if(var_4) {
          var_0["loadoutSecondaryAttachment"] = "tactical";
        }
      }
    }
  }

  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];

  if(var_3) {
    var_8[var_8.size] = "specialty_extra_deadly";
  }

  var_8[var_8.size] = "specialty_lightweight";
  var_8[var_8.size] = "specialty_marathon";
  var_8[var_8.size] = "specialty_fastsprintrecovery";
  var_8[var_8.size] = "specialty_stun_resistance";

  for(var_9 = 1; var_9 < 9; var_9++) {
    if(isDefined(var_0["loadoutPerk" + var_9])) {
      if(var_0["loadoutPerk" + var_9] != "none") {
        var_5[var_5.size] = var_0["loadoutPerk" + var_9];
        var_6[var_6.size] = var_9;
        continue;
      }

      var_7[var_7.size] = var_9;
    }
  }

  foreach(var_11 in var_8) {
    if(var_1 >= randomfloat(1)) {
      if(!scripts\engine\utility::array_contains(var_5, var_11)) {
        var_12 = -1;

        if(var_7.size) {
          var_12 = var_7[0];
          var_7 = scripts\engine\utility::array_remove(var_7, var_12);
        } else if(var_6.size) {
          var_12 = scripts\engine\utility::random(var_6);
          var_6 = scripts\engine\utility::array_remove(var_6, var_12);
        }

        if(var_12 != -1) {
          var_0["loadoutPerk" + var_12] = var_11;
        }
      }
    }
  }

  return var_0;
}