/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_c130airdrop.gsc
***************************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_c130Airdrop", "c130Airdrop_onCrateUse", ::_id_2E2A);
  level._id_2E2E = [];
  level._id_2E3E = [];
  level._id_2E27 = getdvarint("#x393ebe96468d436cd", 12000);
}

_id_2E29() {
  level endon("game_ended");
  var_0 = 1;
  level waittill("br_prematchEnded");

  for(;;) {
    var_1 = getdvarint("#x3417c7873dcd9050d", 1);

    if(!var_1) {
      waitframe();
      continue;
    }

    var_2 = getdvarint("#x33889971b558f5664", 3);
    var_3 = getdvarint("#x3e977a68adf7e48b4", 12);
    var_4 = getdvarint("#x353fce25972448ea5", 240);
    var_5 = getdvarint("#x3541fec59726aec5b", 360);
    var_6 = randomintrange(var_4, var_5);

    if(istrue(level._id_FE8D) && istrue(var_0)) {
      _id_07D1::_id_60C2("activate_cash_drops");
    } else {
      wait(var_6);
    }

    if(isDefined(level._id_2A73)) {
      level._id_2A73._id_2E1E = 3044;
    }

    var_7 = level._id_2E3E.size;

    if(var_7 < var_3) {
      var_8 = getdvarint("#x36134a94afe319e2a", 3);
      var_9 = var_3 - var_7;

      if(!istrue(var_0)) {
        var_2 = 1;
      }

      var_10 = min(var_2, _func_0037(var_9 / var_8));
      var_11 = var_9;

      for(var_12 = 0; var_12 < var_10; var_12++) {
        var_13 = min(var_8, var_11);
        var_11 = var_11 - var_13;
        var_14 = _id_2E20(var_12);
        var_15 = distance(var_14._id_E715, var_14._id_5340);
        var_16 = scripts\mp\gametypes\br_c130::_id_6940();
        var_17 = var_15 / var_16;
        var_18 = _id_2E2B(var_14._id_E715, var_14._id_5340, var_15, var_16, var_17);

        if(var_12 == 0) {
          scripts\mp\gametypes\br_gametype_dmz::_id_DCE6("br_c130airdrop_incoming");
        }

        var_18 _id_2E2C(var_13);

        if(istrue(level._id_FE8D)) {
          wait(randomintrange(4, 8));
        }
      }

      if(istrue(var_0)) {
        var_0 = 0;
      }
    }
  }
}

_id_2E20(var_0) {
  if(isDefined(level._id_2A73._id_2A7A) && isDefined(level._id_2A73._id_2A7B)) {
    var_1 = _id_2E21(var_0);
  } else {
    var_1 = scripts\mp\gametypes\br_c130::_id_E271();
  }

  return var_1;
}

_id_2E21(var_0) {
  var_1 = undefined;
  var_2 = level._id_2A73._id_2A7A;
  var_3 = scripts\mp\gametypes\br_c130::_id_6C3B();
  var_4 = (0, randomfloat(360), 0);

  if(!isDefined(var_0) || var_0 == 0) {
    var_5 = _id_2E26();
    var_6 = _id_2E25(var_5);
    var_4 = vectortoangles(var_2 - var_6 * (1, 1, 0));
    var_2 = var_2 + (0, 0, _id_0797::_id_693C());
    level._id_2E2F = var_4;
  } else {
    if(isDefined(level._id_2E2F)) {
      var_4 = level._id_2E2F;
      var_7 = 1;

      if(var_0 == 2) {
        var_7 = -1;
      }

      var_8 = anglestoright(var_4) * (var_3 * var_7);
      var_9 = randomint(2);
      var_10 = randomfloat(360);
      var_4 = (0, var_10, 0);
      var_4 = scripts\engine\utility::ter_op(var_9, var_4, var_4 + (0, 180, 0));
    } else {
      var_10 = randomfloat(360);
      var_8 = anglesToForward((0, var_10, 0));
      var_8 = var_8 * (var_3 * randomfloatrange(-1, 1));
    }

    var_8 = var_8 + (0, 0, _id_0797::_id_693C());
    var_2 = var_2 + var_8;
  }

  var_1 = scripts\mp\gametypes\br_c130::_id_E273(var_2, var_4);
  return var_1;
}

_id_2E26() {
  var_0 = undefined;
  var_1 = scripts\mp\gamescore::_id_6DD9();
  var_2 = [];

  foreach(var_4 in level._id_EF89) {
    var_5 = scripts\mp\utility\teams::_id_6DCA(var_4, "players");

    if(var_5.size > 0) {
      var_6 = 0;

      foreach(var_8 in var_5) {
        if(!isDefined(var_8)) {
          continue;
        }
        if(scripts\mp\utility\player::isreallyalive(var_8)) {
          var_6 = 1;
          break;
        }
      }

      if(!istrue(var_6)) {
        continue;
      }
      var_10 = var_1[var_4];

      if(!isDefined(var_0) || var_10 >= var_0) {
        var_0 = var_10;
        var_11 = var_2.size;
        var_2[var_11] = spawnStruct();
        var_2[var_11].team = var_4;
        var_2[var_11].players = var_5;
      }
    }
  }

  if(var_2.size > 0) {
    var_11 = 0;

    if(var_2.size > 1) {
      var_11 = randomint(var_2.size);
    }

    return var_2[var_11];
  }

  return;
}

_id_2E25(var_0) {
  if(!isDefined(var_0.players)) {
    return (randomfloatrange(-1000, 1000), 0, 0);
  }

  var_1 = (0, 0, 0);
  var_2 = 3000;
  var_3 = 1;

  foreach(var_5 in var_0.players) {
    if(!scripts\mp\utility\player::isreallyalive(var_5)) {
      continue;
    }
    var_1 = var_5.origin;

    foreach(var_7 in var_0.players) {
      if(var_7 == var_5) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(var_7)) {
        continue;
      }
      if(distance2dsquared(var_5.origin, var_7.origin) <= var_2 * var_2) {
        var_3++;
        var_1 = var_1 + var_7.origin;
        break;
      }
    }

    if(var_3 >= 2) {
      break;
    }
  }

  var_10 = var_1 / var_3;
  return var_10;
}

_id_2E2B(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", var_0);
  var_5 setModel("veh8_mil_air_acharlie130_magma_animated");
  var_5 setCanDamage(0);
  var_5.maxhealth = 100000;
  var_5.health = var_5.maxhealth;
  var_5._id_E715 = var_0;
  var_5._id_5340 = var_1;
  var_5._id_49C1 = vectornormalize(var_1 - var_0);
  var_5.angles = vectortoangles(var_5._id_49C1);
  var_5._id_AED9 = var_2;
  var_5.speed = var_3;
  var_5.lifetime = var_4;
  var_5._id_341E = spawn("script_model", var_0);
  var_5._id_341E setModel("veh8_mil_air_acharlie130_magma_rigid");
  var_5._id_341E linkto(var_5, "", (0, 0, 0), (0, 0, 0));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var_6 = var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("icon_minimap_dropship", undefined, undefined, 1, 1);
    var_5._id_9F26 = var_6;
  }

  level._id_2E2E[level._id_2E2E.size] = var_5;
  return var_5;
}

_id_2E2C(var_0) {
  self setscriptablepartstate("audio_lp_dmz", "on", 0);
  self moveto(self._id_5340, self.lifetime);
  thread _id_2E22();
  thread _id_2E23(var_0);
}

_id_2E22() {
  self endon("death");
  level endon("game_ended");
  wait(self.lifetime - 1);
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("veh8_mil_air_acharlie130_magma_scriptable");
  var_0 setscriptablepartstate("audio_exit_dmz", "on", 0);
  var_0 thread scripts\mp\utility\script::_id_46C7(10);
  wait 1;
  level._id_2E2E = scripts\engine\utility::array_remove(level._id_2E2E, self);
  self setscriptablepartstate("audio_lp_dmz", "off", 0);

  if(isDefined(self._id_9F26)) {
    _id_07F9::_id_C799(self._id_9F26);
  }

  if(isDefined(self._id_341E)) {
    self._id_341E delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

_id_2E23(var_0) {
  self endon("death");
  var_1 = self.lifetime;
  var_2 = var_1 * 0.4;
  var_3 = var_1 - var_2;
  var_4 = var_2 / 2;
  var_5 = var_3 / max(1, var_0 - 1);
  var_6 = 1;
  var_7 = 0;
  var_8 = var_4;
  var_9 = 0;

  while(var_9 < var_0) {
    if(!istrue(var_6)) {
      var_8 = var_5;
    }

    if(istrue(var_7)) {
      var_8 = var_5 / 3;
      var_7 = 0;
    }

    wait(var_8);

    if(istrue(var_6)) {
      var_6 = 0;
    }

    var_10 = _id_2E24(self.origin + anglesToForward(self.angles) * 500);

    if(!isDefined(var_10)) {
      var_7 = 1;
      continue;
    }

    var_11 = scripts\cp_mp\killstreaks\airdrop::_id_5015(var_10 + (0, 0, level._id_2E27 - 100), var_10, self.angles);

    if(!isDefined(var_11)) {
      var_7 = 1;
      continue;
    }

    var_9++;
    var_12 = scripts\cp_mp\killstreaks\airdrop::_id_6E00(var_11);
    var_12._id_FEE9 = 5;
    level._id_2E3E[level._id_2E3E.size] = var_11;
  }
}

_id_2E24(var_0) {
  var_1 = undefined;
  var_2 = var_0 - (0, 0, 20000);
  var_3 = [self, self._id_341E];
  var_4 = scripts\engine\trace::ray_trace(var_0, var_2, var_3);

  if(isDefined(var_4) && var_4["hittype"] != "hittype_none") {
    var_1 = var_4["position"];
  }

  if(isDefined(var_1)) {
    var_5 = scripts\mp\gametypes\br_c130::_id_89B2(var_1) && !_id_2E28(var_1);

    if(!istrue(var_5)) {
      var_1 = undefined;
    }
  }

  return var_1;
}

_id_2E28(var_0) {
  var_1 = 0;
  var_2 = level._id_2E3E;
  var_3 = getdvarint("#x386fbe5ebb473c7a2", 10000);
  var_4 = var_3 * var_3;

  foreach(var_6 in var_2) {
    if(distance2dsquared(var_0, var_6.origin) < var_4) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

_id_2E2A(var_0) {
  var_1 = "mp/loot_set_airdrop_contents_dmz.csv";
  self._id_8B39 = 0;
  var_2 = [];

  if(!scripts\mp\gametypes\br_public::_id_8805()) {
    var_3 = scripts\mp\gametypes\br_lootcache::_id_35A1(0, 1, "killstreak", var_1);
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  }

  var_3 = scripts\mp\gametypes\br_lootcache::_id_35A1(4, 1, "weapon", var_1);
  var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  var_3 = scripts\mp\gametypes\br_lootcache::_id_35A1(0, 2, "health", var_1);
  var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  var_3 = scripts\mp\gametypes\br_lootcache::_id_35A1(0, 2, "ammo", var_1);
  var_2 = scripts\engine\utility::array_combine(var_2, var_3);

  if(!scripts\mp\gametypes\br_public::_id_8805()) {
    var_3 = scripts\mp\gametypes\br_lootcache::_id_35A1(0, 1, "tablet", var_1);
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  }

  var_4 = randomint(3);

  if(var_4 == 2) {
    var_3 = scripts\mp\gametypes\br_lootcache::_id_35A1(0, 1, "revive", var_1);
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  }

  var_5 = 750;

  if(isDefined(level._id_13A4)) {
    var_5 = level._id_13A4;
  }

  if(istrue(level._id_25BB)) {
    var_5 = int(var_5 * level._id_AD72);
  }

  var_3 = scripts\mp\gametypes\br_plunder::_id_5052(var_5, 10);
  var_2 = scripts\engine\utility::array_combine(var_2, var_3);

  foreach(var_7 in var_2) {
    var_7._id_9898 = "c130_box";
  }

  if(!isDefined(var_0._id_9868)) {
    var_0._id_9868 = 1;
  } else {
    var_0._id_9868++;
  }

  var_0 scripts\mp\utility\stats::_id_D551(var_0._id_9868);
  var_0 thread _id_0A9F::_id_7003("br_c130_box_open");
}