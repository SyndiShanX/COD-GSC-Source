/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2456.gsc
*************************************************/

_id_8120() {
  scripts\engine\utility::_id_5C11("doors_initialized");
  scripts\engine\utility::_id_5C11("first_door_opened");

  if(!scripts\engine\utility::_id_5C00("init_interaction_done")) {
    scripts\engine\utility::_id_5C24("init_interaction_done");
  }

  _id_7F5D();
  _id_80CF();
  _id_7F1D();
  scripts\engine\utility::_id_5C1B("doors_initialized");
}

_id_4E22() {
  self endon("death");
  self endon("disconnect");
  self endon("saw_door_tutorial");
  wait 5;
  var_0 = cos(85);

  for(;;) {
    var_1 = getEntArray("door_buy", "targetname");
    var_2 = _func_0204(var_1, self.origin);

    if(var_2.size > 0) {
      if(distancesquared(var_2[0].origin, self.origin) < 9216 && scripts\engine\utility::_id_10E76(self.origin, self.angles, var_2[0].origin, var_0)) {
        thread scripts\cp\cp_hud_message::_id_F8BA("door_buy");
        self notify("saw_door_tutorial");
        wait 1;
      }
    }

    wait 0.1;
  }
}

_id_7F5D() {
  var_0 = getEntArray("door_buy", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_CE42)) {
      var_2 setuserange(var_2._id_CE42);
    }

    level thread _id_7F5C(var_2);
    wait 0.05;
  }

  level._id_4E21 = var_0;
}

_id_7F5C(var_0) {
  var_0 sethintstring(level._id_835D[var_0._id_039B]);
  var_1 = [];

  foreach(var_3 in level._id_417B) {
    if(!isDefined(var_3.target)) {
      continue;
    }
    if(var_3.target == var_0.target) {
      var_1[var_1.size] = var_3;
    }
  }

  var_5 = _id_69F0(var_1[0]._id_039B);

  if(isDefined(level._id_548F)) {
    var_0 _meth_8557(level._id_548F, var_5);
  } else {
    var_0 _meth_8557(&"CP_ZMB_INTERACTIONS/ENTER_THIS_AREA", var_5);
  }

  if(isDefined(level._id_4E0B)) {
    [[level._id_4E0B]](var_0);
  }

  for(;;) {
    var_0 waittill("trigger", var_6);

    if(isent(var_6) && !var_6 scripts\cp\utility::_id_8708()) {
      continue;
    }
    if(isPlayer(var_6)) {
      if(!var_6 _id_0737::_id_30E6(var_1[0], level._id_8393[var_1[0]._id_039B]._id_3D91, level._id_8393[var_1[0]._id_039B]._id_E3FF)) {
        level notify("interaction", "purchase_denied", level._id_8393[var_1[0]._id_039B], var_6);
        var_6 _id_DC62();
        continue;
      }

      var_0 notify("purchased");

      if(!scripts\engine\utility::_id_5C00("can_drop_coins")) {
        scripts\engine\utility::_id_5C1B("can_drop_coins");
      }

      var_6 _id_0741::_id_BD77("mt_purchase_doors");
      var_6 _id_074E::_id_ED93(level._id_8393[var_1[0]._id_039B]._id_3D91, 1, "door");
      _id_0995::_id_973B(1, var_6, var_1[0]._id_CCA3, level._id_8393[var_1[0]._id_039B]._id_3D91, level._id_10C9F);
      var_7 = int(250);
      var_6 _id_074E::_id_6F38(var_7, 1);
    }

    if(isDefined(level._id_5602)) {
      level notify(level._id_5602);
    }

    if(!scripts\engine\utility::_id_5C00("first_door_opened")) {
      scripts\engine\utility::_id_5C1B("first_door_opened");
    }

    if(isPlayer(var_6) && var_6 scripts\cp\utility::_id_8708() || isDefined(var_0._id_155B)) {
      foreach(var_9 in var_1) {
        var_9 notify("door_opened");

        if(!isDefined(level._id_E245[var_9._id_CCA3])) {
          continue;
        }
        if(level._id_E245[var_9._id_CCA3]._id_0026) {
          if(isDefined(level._id_BE2C) && !isDefined(var_0._id_155B)) {
            level[[level._id_BE2C]](var_9._id_CCA3, var_6);
          }
        }
      }
    }

    level thread[[level._id_8393[var_1[0]._id_039B]._id_0F07]](var_1[0], var_6);

    foreach(var_9 in var_1) {
      _id_09A4::_id_D131(var_9);
      _id_09A4::_id_0EE2(var_9._id_CCA3);
      wait 0.05;
    }

    break;
  }

  if(isDefined(var_0.target)) {
    var_13 = var_0.target;

    if(isDefined(var_0._id_0481)) {
      var_14 = getEntArray(var_0._id_0481, "targetname");

      foreach(var_16 in var_14) {
        if(var_16.target == var_13) {
          var_16 delete();
        }
      }
    }
  }
}

_id_69F0(var_0) {
  return int(level._id_8393[var_0]._id_3D91);
}

_id_DC62() {
  self endon("disconnect");
  thread _id_076F::_id_F72D("no_cash", "zmb_comment_vo", "high", 30, 0, 0, 1, 50);
  self _meth_80FD(&"COOP_INTERACTIONS/NEED_MONEY");
  wait 1;
  self _meth_80FC();
}

_id_80CF() {
  level._id_EF4E = [];

  foreach(var_1 in getEntArray("team_killdoor", "targetname")) {
    var_2 = level._id_EF4E.size;
    var_3 = spawnStruct();
    var_3.name = var_2;
    var_3.trigger = var_1;

    if(isDefined(var_1._id_011A)) {
      var_3._id_22A1 = var_1._id_011A;
    } else {
      var_3._id_22A1 = 10;
    }

    var_3._id_8D28 = var_3._id_22A1;
    var_3._id_707C = 1;
    var_3._id_8D0F = 0;
    var_3.players = [];
    var_3._id_C488 = 0;
    var_3._id_CD45 = "flag_" + var_2;
    scripts\engine\utility::_id_5C11(var_3._id_CD45);
    var_3._id_3A29 = undefined;
    var_3._id_03A9 = undefined;
    var_3._id_BD8B = [];
    var_3._id_BD8A = undefined;

    foreach(var_5 in getEntArray(var_1.target, "targetname")) {
      var_5 _meth_8359(1);

      if(issubstr(var_5.classname, "brushmodel")) {
        if(isDefined(var_5._id_039B) && var_5._id_039B == "progress") {
          var_5._id_E630 = var_5.origin;
          var_3._id_BD8B[var_3._id_BD8B.size] = var_5;
        } else
          var_3._id_3A29 = var_5;

        continue;
      }

      if(issubstr(var_5.classname, "scriptable")) {
        var_3._id_03A9 = var_5;
      }
    }

    var_3._id_0F06 = [];

    if(isDefined(var_1._id_CCA3)) {
      foreach(var_8 in strtok(var_1._id_CCA3, ",")) {
        var_3._id_0F06[var_3._id_0F06.size] = var_8;
      }
    }

    level._id_EF4E[var_2] = var_3;
    var_3 thread _id_EF4D();
    wait 0.05;
  }
}

_id_EF4D() {
  level endon("open_killdoor_" + self.name);
  childthread _id_EF4B();

  for(;;) {
    scripts\engine\utility::_id_5C24(self._id_CD45);
    level waittill("zombie_killed", var_0, var_1, var_2, var_3);

    if(istrue(var_3._id_86BA) && isDefined(var_3._id_B736)) {
      var_3 = var_3._id_B736;
    }

    if(!isent(var_3) || !var_3 scripts\cp\utility::_id_8708()) {
      continue;
    }
    if(!var_3 istouching(self.trigger)) {
      continue;
    }
    thread _id_3223(var_0, var_3);
  }
}

_id_EF4B() {
  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    scripts\engine\utility::_id_5C1B(self._id_CD45);
    self._id_03A9 setscriptablepartstate("fx", "active");
    _id_EF4C();
    scripts\engine\utility::_id_5C04(self._id_CD45);
    self._id_03A9 setscriptablepartstate("fx", "normal");
  }
}

_id_EF4C() {
  self endon("killdoor_deactivate");

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(isPlayer(var_0)) {
      _id_3F31(var_0);
      childthread _id_8D74();
      thread _id_B605(var_0);
    }
  }
}

_id_3F31(var_0) {
  if(isDefined(var_0._id_8D73)) {
    return;
  }
  var_0._id_8D73 = newclienthudelem(var_0);
  var_0._id_8D73._id_96CF = 0;
  var_0._id_8D73._id_01D6 = 1;
  var_0._id_8D73.fontscale = 1;
  var_0._id_8D73.sort = 20;
  var_0._id_8D73.alpha = 1;
  var_0._id_8D73.y = 120;
  var_0._id_8D73.alignx = "center";
  var_0._id_8D73.horzalign = "center";
  var_0._id_8D73.color = (1, 0, 1);
  self.players = scripts\engine\utility::_id_1BD1(self.players);
  self.players[self.players.size] = var_0;
}

_id_8D74() {
  self notify("stop_killdoor_timeout");
  self endon("stop_killdoor_timeout");
  wait 1;
  self notify("killdoor_deactivate");
}

_id_B605(var_0) {
  var_0 endon("disconnect");
  var_0 notify("stop_player_killdoor_timeout");
  var_0 endon("stop_player_killdoor_timeout");
  wait 1;
  self.players = scripts\engine\utility::array_remove(self.players, var_0);
  var_0._id_8D73 destroy();
}

_id_3223(var_0, var_1) {
  _id_E04F(var_0);

  if(self._id_C488) {
    return;
  }
  _id_0995::_id_9746(1, var_1, self.name, self._id_8D28, level._id_10C9F);

  foreach(var_1 in self.players) {
    if(isDefined(var_1)) {}
  }

  foreach(var_5 in self._id_BD8B) {
    var_5 moveto(var_5._id_E630 + (0, 0, 16 / self._id_8D28) * self._id_8D0F, 0.1);
  }

  if(self._id_8D0F >= self._id_8D28) {
    thread _id_AC1F(var_1);
  }
}

_id_E04F(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("tag_origin_soultrail");
  var_2 = self._id_03A9.origin + (0, 0, 50);

  for(;;) {
    var_3 = distance(var_0, var_2);
    var_4 = var_3 / 600;

    if(var_4 < 0.05) {
      var_4 = 0.05;
    }

    var_1 moveto(var_2, var_4);
    wait 0.05;

    if(!self._id_C488 && distancesquared(var_1.origin, var_2) > 256) {
      continue;
    } else {
      break;
    }
  }

  if(!self._id_C488) {
    self._id_8D0F++;
  }

  var_1 delete();
}

_id_AC1F(var_0) {
  level notify("open_killdoor_" + self.name);
  self._id_C488 = 1;

  foreach(var_0 in self.players) {
    if(isDefined(var_0._id_8D73)) {
      var_0._id_8D73 destroy();
    }
  }

  foreach(var_4 in self._id_0F06) {
    _id_09A4::_id_0EE2(var_4);
  }

  if(isDefined(self._id_3A29)) {
    self._id_3A29 _meth_8093();
    self._id_3A29 notsolid();
  }

  foreach(var_7 in self._id_BD8B) {
    var_7 delete();
  }

  thread _id_AC20(self._id_8387);
  self._id_03A9 setscriptablepartstate("fx", "normal");
  self._id_03A9 setscriptablepartstate("default", "hide");
  _id_0995::_id_973B(1, var_0, self.name, self._id_8D28, level._id_10C9F);
  var_0 _id_0741::_id_BD77("mt_purchase_doors");
  var_0 thread _id_076F::_id_F72D("door_kill_purchase", "disco_comment_vo");

  if(scripts\cp\utility::_id_89AE() || istrue(level._id_AB30)) {
    var_0 _id_074E::_id_6F38(250, 1);
  } else {
    var_0 _id_074E::_id_6F38(75, 1);
  }
}

_id_AC20(var_0) {
  wait 0.5;
  playsoundatpos(self._id_03A9.origin, "zmb_clear_barricade");
  wait 0.5;
}

_id_7F1D() {
  foreach(var_1 in getEntArray("chi_door", "targetname")) {
    var_1 thread _id_3573();
    wait 0.05;
  }
}

_id_3573() {
  foreach(var_1 in getEntArray(self.target, "targetname")) {
    if(issubstr(var_1.classname, "scriptable")) {
      self._id_03A9 = var_1;
    }
  }

  var_3 = [];

  foreach(var_5 in level._id_417B) {
    if(!isDefined(var_5.target)) {
      continue;
    }
    if(var_5.target == self.target) {
      var_3[var_3.size] = var_5;
    }
  }

  if(var_3.size == 0) {
    return;
  }
  self sethintstring(level._id_835D[self._id_039B]);
  var_7 = _id_69F0(var_3[0]._id_039B);

  if(isDefined(level._id_548F)) {
    self _meth_8557(level._id_548F, var_7);
  } else {
    self _meth_8557(&"CP_ZMB_INTERACTIONS/ENTER_THIS_AREA", var_7);
  }

  if(isDefined(level._id_4E0B)) {
    [[level._id_4E0B]](self);
  }

  for(;;) {
    self._id_03A9 waittill("damage", var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17);

    if(!isDefined(level._id_AC1A) || !level._id_AC1A) {
      if(!var_9 scripts\cp\utility::_id_8708()) {
        continue;
      }
      var_18 = undefined;

      if(isDefined(var_17)) {
        var_18 = getcompleteweaponname(var_17);
      }

      if(issubstr(var_18, "fists_zm_")) {} else if(!issubstr(var_18, "shuriken")) {
        var_19 = ["door_chi_none_1", "door_chi_none", "door_chi_notenough"];
        var_9 thread _id_076F::_id_F72D(scripts\engine\utility::random(var_19), "disco_comment_vo");
        continue;
      }

      var_9 _id_0741::_id_BD77("mt_purchase_doors");
      _id_0995::_id_973B(1, var_9, var_3[0]._id_CCA3, level._id_8393[var_3[0]._id_039B]._id_3D91, level._id_10C9F);
      var_20 = int(250);
      var_9 _id_074E::_id_6F38(var_20, 1);
    }

    if(isPlayer(var_9) && var_9 scripts\cp\utility::_id_8708()) {
      foreach(var_22 in var_3) {
        if(!isDefined(level._id_E245[var_22._id_CCA3])) {
          continue;
        }
        if(level._id_E245[var_22._id_CCA3]._id_0026) {
          if(isDefined(level._id_BE2C)) {
            level[[level._id_BE2C]](var_22._id_CCA3, var_9, 1);
          }
        }
      }
    }

    level thread[[level._id_8393[var_3[0]._id_039B]._id_0F07]](var_3[0], var_9);

    foreach(var_22 in var_3) {
      _id_09A4::_id_D131(var_22);
      _id_09A4::_id_0EE2(var_22._id_CCA3);
      wait 0.05;
    }

    break;
  }

  if(isDefined(self.target)) {
    var_26 = self.target;

    if(isDefined(self._id_0481)) {
      var_27 = getEntArray(self._id_0481, "targetname");

      foreach(var_29 in var_27) {
        if(var_29.target == var_26) {
          var_29 delete();
        }
      }
    }
  }
}

_id_DC63(var_0) {
  self endon("disconnect");
  var_1 = ["door_kill_notenough", "door_wooden_fail", "door_chi_notenough"];
  thread _id_076F::_id_F72D(scripts\engine\utility::random(var_1), "disco_comment_vo");
}