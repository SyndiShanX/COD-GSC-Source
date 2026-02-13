/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2554.gsc
*************************************************/

_id_27CA(var_0, var_1, var_2, var_3) {
  var_4 = _func_00B4(self.origin, var_1, var_0);
  var_5 = [];
  var_6 = self _meth_815E();
  var_7 = anglesToForward(self getplayerangles());
  var_8 = vectornormalize(var_7 * (1, 1, 0));

  foreach(var_10 in var_4) {
    var_11 = vectornormalize((var_10.origin - self.origin) * (1, 1, 0));
    var_12 = vectordot(var_11, var_8);

    if(var_12 > var_2) {
      if(!var_3 || isDefined(var_6) && _func_0158(var_10, var_6, 1)) {
        var_5[var_5.size] = var_10;
      }
    }
  }

  return var_5;
}

_id_27DD(var_0, var_1) {
  if(var_0 == "none") {
    return var_1 == "none";
  } else if(var_0 == "hunt") {
    return var_1 == "hunt" || var_1 == "none";
  } else if(var_0 == "guard") {
    return var_1 == "guard" || var_1 == "hunt" || var_1 == "none";
  } else if(var_0 == "objective") {
    return var_1 == "objective" || var_1 == "guard" || var_1 == "hunt" || var_1 == "none";
  } else if(var_0 == "critical") {
    return var_1 == "critical" || var_1 == "objective" || var_1 == "guard" || var_1 == "hunt" || var_1 == "none";
  } else if(var_0 == "tactical") {
    return 1;
  }
}

_id_28C8(var_0) {
  self _meth_8056(var_0);
  _id_09F7::_id_2701();
  self _meth_802B();
}

_id_28C4(var_0, var_1) {
  if(var_0 == "default") {
    var_0 = _id_2732();
  }

  var_3 = self _meth_802F();
  self _meth_8052(var_0);

  if(isPlayer(self) && var_3 != var_0) {
    self.pers["rankxp"] = _id_66EC();
    scripts\mp\rank::_id_B80A();
  }
}

_id_2732() {
  if(!isDefined(level._id_2773)) {
    level._id_2773 = [];

    if(level.rankedmatch) {
      level._id_2773[level._id_2773.size] = "normal";
      level._id_2773[level._id_2773.size] = "hard";
    } else {
      level._id_2773[level._id_2773.size] = "easy";
      level._id_2773[level._id_2773.size] = "normal";
      level._id_2773[level._id_2773.size] = "hard";
    }
  }

  if(!isDefined(level._id_2863)) {
    level._id_2863 = [];
  }

  if(!isDefined(level._id_2863["allies"])) {
    level._id_2863["allies"] = 0;
  }

  if(!isDefined(level._id_2863["axis"])) {
    level._id_2863["axis"] = 0;
  }

  if(!isDefined(level._id_2863["all"])) {
    level._id_2863["all"] = 0;
  }

  if(!isDefined(self.pers["bot_chosen_difficulty"])) {
    var_0 = undefined;

    if(level.teambased && level.gametype != "arena_evo") {
      var_1 = self.team;

      if(!isDefined(var_1)) {
        var_1 = self._id_28F7;
      }

      if(!isDefined(var_1)) {
        var_1 = self.pers["team"];
      }
    } else
      var_1 = "all";

    var_0 = level._id_2863[var_1];
    var_2 = level._id_2773[var_0];
    self.pers["bot_chosen_difficulty"] = _id_644B(var_2);
    level._id_2863[var_1] = (level._id_2863[var_1] + 1) % level._id_2773.size;
  }

  return self.pers["bot_chosen_difficulty"];
}

_id_644B(var_0) {
  if(var_0 == "easy") {
    return "recruit";
  } else if(var_0 == "normal") {
    return "regular";
  } else if(var_0 == "hard") {
    return scripts\engine\utility::random(["hardened", "veteran"]);
  } else {}
}

_id_2801() {
  if(_id_2805()) {
    if(self._id_276F == "capture" || self._id_276F == "capture_zone") {
      return 1;
    }
  }

  return 0;
}

_id_280A() {
  if(_id_2805()) {
    if(self._id_276F == "patrol") {
      return 1;
    }
  }

  return 0;
}

_id_280B() {
  if(_id_2805()) {
    if(self._id_276F == "protect" || self._id_276F == "protect_zone") {
      return 1;
    }
  }

  return 0;
}

_id_2800() {
  if(_id_2805()) {
    if(self._id_276F == "bodyguard") {
      return 1;
    }
  }

  return 0;
}

_id_2805() {
  return isDefined(self._id_2769);
}

_id_2806(var_0) {
  if(_id_2805()) {
    if(_id_2916(self._id_276A, var_0)) {
      return 1;
    }
  }

  return 0;
}

_id_2807(var_0) {
  if(_id_2800() && self._id_2764 == var_0) {
    return 1;
  }

  return 0;
}

_id_5520(var_0, var_1, var_2) {
  var_3 = (0, 0, 11);
  var_4 = (0, 0, 40);
  var_5 = undefined;

  if(var_2 == "stand") {
    return 1;
  } else if(var_2 == "crouch") {
    var_5 = var_4;
  } else if(var_2 == "prone") {
    var_5 = var_3;
  }

  return _func_0202(var_1 + var_5, var_0 + var_5, 0, undefined);
}

_id_6497(var_0, var_1) {
  var_2 = _id_601E(var_0, var_1);

  if(isDefined(var_2)) {
    var_2 = _id_C3AF(var_2);
    var_2 = _id_632C(var_2);
  }

  return var_2;
}

_id_601F(var_0, var_1) {
  return _func_00C4(var_0, var_1);
}

_id_601E(var_0, var_1) {
  return _func_00B7(var_0, var_1);
}

_id_6019(var_0, var_1, var_2) {
  return _func_0020(var_0, var_1, var_2);
}

_id_A55D(var_0, var_1) {
  if(!isDefined(self._id_AA5B)) {
    return 0;
  }

  if(isDefined(self._id_AA5B[var_0]) && isDefined(self._id_AA5B[var_0][var_1]) && self._id_AA5B[var_0][var_1]) {
    return 1;
  }

  if(isDefined(self._id_AA5B[var_1]) && isDefined(self._id_AA5B[var_1][var_0]) && self._id_AA5B[var_1][var_0]) {
    return 1;
  }

  return 0;
}

_id_632C(var_0) {
  var_1 = var_0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = _func_00A6(var_0[var_2]);

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(!scripts\engine\utility::array_contains(var_1, var_3[var_4])) {
        var_1 = scripts\engine\utility::array_add(var_1, var_3[var_4]);
      }
    }
  }

  return var_1;
}

_id_681F(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(_func_0158(var_4, var_1, 1)) {
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }
  }

  return var_2;
}

_id_C3AF(var_0) {
  var_0[var_0.size - 1] = undefined;
  var_0[0] = undefined;
  return scripts\engine\utility::_id_1BD1(var_0);
}

_id_291B(var_0) {
  while(!_id_270B(var_0)) {
    wait 0.5;
  }
}

_id_270B(var_0) {
  if(_func_001D() != "off") {
    return 1;
  }

  if(_id_2942(var_0)) {
    return 1;
  }

  return 0;
}

_id_291D(var_0) {
  var_1 = gettime();

  for(;;) {
    if(isDefined(var_0)) {
      if(gettime() > var_1 + var_0) {
        return;
      }
    }

    if(!isDefined(self._id_0192)) {
      return;
    } else if(!_id_27F7()) {
      return;
    }
    wait 0.05;
  }
}

_id_27F7(var_0) {
  if(self._id_8F1D == 0) {
    return 0;
  }

  var_1 = gettime() - self._id_8F1D;
  var_2 = level._id_2878;

  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  return var_1 < var_2;
}

_id_291C(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1) && isDefined(var_2)) {}

  if((!isDefined(var_1) || !isDefined(var_2)) && isDefined(var_3)) {}

  var_4 = ["goal", "bad_path", "no_path", "node_relinquished", "script_goal_changed"];

  if(isDefined(var_1)) {
    var_4[var_4.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_4[var_4.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_4[var_4.size] = var_3;
  }

  if(isDefined(var_0)) {
    var_5 = scripts\engine\utility::_id_10890(var_4, var_0);
  } else {
    var_5 = scripts\engine\utility::_id_10892(var_4);
  }

  return var_5;
}

_id_290E(var_0, var_1, var_2) {
  level endon("game_ended");
  childthread _id_FDC6();
  var_3 = scripts\engine\utility::_id_108AA(var_0, var_1, var_2, "use_button_no_longer_pressed", "finished_use");
  self notify("stop_usebutton_watcher");
  return var_3;
}

_id_FDC6(var_0, var_1) {
  self endon("stop_usebutton_watcher");
  wait 0.05;

  while(self usebuttonpressed()) {
    wait 0.05;
  }

  self notify("use_button_no_longer_pressed");
}

_id_2942(var_0) {
  foreach(var_2 in level._id_AE7C) {
    if(isai(var_2)) {
      if(isDefined(var_0) && var_0) {
        if(!scripts\mp\utility\entity::_id_8A94(var_2)) {
          continue;
        }
      }

      return 1;
    }
  }

  return 0;
}

_id_27BD(var_0, var_1, var_2) {
  if(!isDefined(level._id_551E)) {
    return undefined;
  }

  if(_func_0107(var_1)) {
    if(isDefined(var_2) && var_2) {
      var_3 = undefined;
      var_4 = 999999999;

      foreach(var_6 in var_1) {
        var_7 = scripts\engine\utility::_id_1BAB(level._id_551A, var_6);
        var_8 = level._id_551C[var_7];
        var_9 = distancesquared(self.origin, var_8);

        if(var_9 < var_4) {
          var_3 = var_6;
          var_4 = var_9;
        }
      }

      var_1 = var_3;
    } else
      var_1 = scripts\engine\utility::random(var_1);
  }

  var_11 = level._id_551D[var_1];

  if(!isDefined(var_0) || var_0 == "stand") {
    return var_11;
  } else if(var_0 == "crouch") {
    var_12 = [];

    foreach(var_14 in var_11) {
      if(var_14._id_40A1[var_1]) {
        var_12 = scripts\engine\utility::array_add(var_12, var_14);
      }
    }

    return var_12;
  } else if(var_0 == "prone") {
    var_12 = [];

    foreach(var_14 in var_11) {
      if(var_14._id_BDAC[var_1]) {
        var_12 = scripts\engine\utility::array_add(var_12, var_14);
      }
    }

    return var_12;
  }

  return undefined;
}

_id_2793(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = self._id_2764 getvelocity();

  if(_func_0135(var_4) > 100) {
    var_5 = _func_00B4(var_0, var_1 * 1.75, var_1 * 0.5, 500);
    var_6 = [];
    var_7 = vectornormalize(var_4);

    for(var_8 = 0; var_8 < var_5.size; var_8++) {
      var_9 = vectornormalize(var_5[var_8].origin - self._id_2764.origin);

      if(vectordot(var_9, var_7) > 0.1) {
        var_6[var_6.size] = var_5[var_8];
      }
    }
  } else
    var_6 = _func_00B4(var_0, var_1, 0, 500);

  if(isDefined(var_2) && var_2) {
    var_10 = vectornormalize(self._id_2764.origin - self.origin);
    var_11 = var_6;
    var_6 = [];

    foreach(var_13 in var_11) {
      var_9 = vectornormalize(var_13.origin - self._id_2764.origin);

      if(vectordot(var_10, var_9) > 0.2) {
        var_6[var_6.size] = var_13;
      }
    }
  }

  var_15 = [];
  var_16 = [];
  var_17 = [];

  for(var_8 = 0; var_8 < var_6.size; var_8++) {
    var_18 = distancesquared(var_6[var_8].origin, var_0) > 10000;
    var_19 = abs(var_6[var_8].origin[2] - self._id_2764.origin[2]) < 50;

    if(var_18) {
      var_15[var_15.size] = var_6[var_8];
    }

    if(var_19) {
      var_16[var_16.size] = var_6[var_8];
    }

    if(var_18 && var_19) {
      var_17[var_17.size] = var_6[var_8];
    }

    if(var_8 % 100 == 99) {
      wait 0.05;
    }
  }

  if(var_17.size > 0) {
    var_3 = self _meth_8049(var_17, var_17.size * 0.15, "node_capture", var_0, undefined, self._id_4628);
  }

  if(!isDefined(var_3)) {
    wait 0.05;

    if(var_16.size > 0) {
      var_3 = self _meth_8049(var_16, var_16.size * 0.15, "node_capture", var_0, undefined, self._id_4628);
    }

    if(!isDefined(var_3) && var_15.size > 0) {
      wait 0.05;
      var_3 = self _meth_8049(var_15, var_15.size * 0.15, "node_capture", var_0, undefined, self._id_4628);
    }
  }

  return var_3;
}

_id_2791(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = _func_00B4(var_0, var_1, 0, 500);

  if(var_4.size > 0) {
    var_3 = self _meth_8049(var_4, var_4.size * 0.15, "node_capture", var_0, var_2, self._id_4628);
  }

  return var_3;
}

_id_2792(var_0, var_1) {
  var_2 = undefined;

  if(var_0.size > 0) {
    var_2 = self _meth_8049(var_0, var_0.size * 0.15, "node_capture", undefined, var_1, self._id_4628);
  }

  return var_2;
}

_id_2794(var_0, var_1) {
  var_2 = undefined;

  if(var_0.size > 0) {
    var_2 = self _meth_8049(var_0, var_0.size * 0.25, "node_capture", var_1, undefined, self._id_4628);
  }

  return var_2;
}

_id_2790(var_0, var_1) {
  var_2 = undefined;
  var_3 = _func_00B4(var_0, var_1, 0, 500);

  if(var_3.size > 0) {
    var_2 = self _meth_8049(var_3, var_3.size * 0.15, "node_protect", var_0, self._id_4628);
  }

  return var_2;
}

_id_288B(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = _func_00B4(var_0, var_1, 0, 500);

  if(isDefined(var_6) && var_6.size >= 2) {
    var_5 = _id_2795(var_6, var_2);
  }

  if(!isDefined(var_5)) {
    if(!isDefined(var_3)) {
      var_3 = 0;
    }

    if(!isDefined(var_4)) {
      var_4 = 1;
    }

    var_7 = randomfloatrange(self._id_276D * var_3, self._id_276D * var_4);
    var_8 = anglesToForward((0, randomint(360), 0));
    var_5 = var_0 + var_8 * var_7;
  }

  return var_5;
}

_id_288A(var_0, var_1, var_2) {
  var_3 = undefined;

  if(var_1.size >= 2) {
    var_3 = _id_2795(var_1, var_2);
  }

  if(!isDefined(var_3)) {
    var_4 = scripts\engine\utility::random(var_1);
    var_5 = var_4.origin - var_0;
    var_3 = var_0 + vectornormalize(var_5) * length(var_5) * randomfloat(1.0);
  }

  return var_3;
}

_id_2795(var_0, var_1) {
  var_2 = undefined;
  var_3 = scripts\engine\utility::array_randomize(var_0);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    for(var_5 = var_4 + 1; var_5 < var_3.size; var_5++) {
      var_6 = var_3[var_4];
      var_7 = var_3[var_5];

      if(_func_0158(var_6, var_7, 1)) {
        var_2 = ((var_6.origin[0] + var_7.origin[0]) * 0.5, (var_6.origin[1] + var_7.origin[1]) * 0.5, (var_6.origin[2] + var_7.origin[2]) * 0.5);

        if(isDefined(var_1) && self[[var_1]](var_2) == 1) {
          return var_2;
        }
      }
    }
  }

  return var_2;
}

_id_45E3() {
  if(isDefined(self._id_276C)) {
    return self._id_276C.origin;
  } else if(isDefined(self._id_276A)) {
    return self._id_276A;
  }

  return undefined;
}

_id_26FC() {
  if(!istrue(level._id_15BD)) {
    return 0;
  }

  if(scripts\mp\utility\game::_id_88EE()) {
    return 0;
  }

  if(_id_280F()) {
    return 0;
  }

  if(self _meth_81F4()) {
    return 0;
  }

  if(isDefined(level._id_A737)) {
    return 0;
  }

  if(isDefined(self._id_F941) && self._id_F941) {
    return 0;
  }

  if(isDefined(self._id_3C69) && self._id_3C69) {
    return 0;
  }

  if(self _meth_81D7()) {
    return 0;
  }

  if(scripts\mp\utility\game::_id_6A65() > 0) {
    var_0 = 1;

    foreach(var_2 in level._id_AE7C) {
      if(isalive(var_2) && !_func_03D9(self, var_2)) {
        var_0 = 0;
      }
    }

    if(var_0) {
      return 0;
    }
  }

  if(istrue(self._id_292D)) {
    return 0;
  }

  if(!_id_27F7(500)) {
    return 1;
  }

  if(!isalive(self._id_0192)) {
    return 1;
  }

  return 0;
}

_id_28A4() {
  var_0 = undefined;
  var_1 = _func_0027("investigated", "killer_died");
  var_2 = _func_0027("investigated");
  var_3 = scripts\engine\utility::random(_func_0021(0, gettime() - 10000, 1, "death", var_1, self));

  if(isDefined(var_3)) {
    var_0 = var_3;
    self._id_2857 = 10000;
  } else {
    var_4 = undefined;

    if(self _meth_803E() != "none") {
      var_4 = self _meth_803B();
    }

    var_5 = _func_0021(0, gettime() - 45000, 1, "kill", var_2, self);
    var_6 = _func_0021(0, gettime() - 45000, 1, "death", var_1, self);
    var_3 = scripts\engine\utility::random(scripts\engine\utility::array_combine(var_5, var_6));

    if(isDefined(var_3) > 0 && (!isDefined(var_4) || distancesquared(var_4, var_3) > 1000000)) {
      var_0 = var_3;
      self._id_2857 = 45000;
    }
  }

  if(isDefined(var_0)) {
    var_7 = _func_00F5(var_0);
    var_8 = _func_00F5(self.origin);

    if(isDefined(var_7) && isDefined(var_8) && var_8 != var_7) {
      var_9 = _func_0029(var_7, self.team, "ally") + _func_0029(var_7, self.team, "path_ally");

      if(var_9 > 1) {
        var_0 = undefined;
      }
    }
  }

  if(isDefined(var_0)) {
    self._id_2856 = var_0;
  }

  return var_0;
}

_id_277F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

_id_2780(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

_id_277E(var_0, var_1, var_2, var_3, var_4) {}

_id_27D7() {
  var_0 = 0;
  var_1 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var_1 = self.weaponlist;
  } else {
    var_1 = self getweaponslistprimaries();
  }

  foreach(var_3 in var_1) {
    var_0 = var_0 + self getweaponammoclip(var_3);
    var_0 = var_0 + self getweaponammostock(var_3);
  }

  return var_0;
}

_id_2877() {
  var_0 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var_0 = self.weaponlist;
  } else {
    var_0 = self getweaponslistprimaries();
  }

  foreach(var_2 in var_0) {
    if(self getweaponammoclip(var_2) > 0) {
      return 0;
    }

    if(self getweaponammostock(var_2) > 0) {
      return 0;
    }
  }

  return 1;
}

_id_27BE() {
  var_0 = 0;
  var_1 = self _meth_8195();

  foreach(var_3 in var_1) {
    var_0 = var_0 + self getweaponammostock(var_3);
  }

  return var_0;
}

_id_2812(var_0, var_1) {
  switch (var_0) {
    case "trap_directional":
      switch (var_1.basename) {
        case "claymore_mp":
          return 1;
      }

      break;
    case "trap":
      switch (var_1.basename) {
        case "at_mine_mp":
        case "motion_sensor_mp":
        case "proximity_explosive_mp":
        case "trophy_mp":
          return 1;
      }

      break;
    case "trap_follower":
      switch (var_1.basename) {
        case "tracking_drone_mp":
          return 1;
      }

      break;
    case "c4":
      switch (var_1.basename) {
        case "s4_c4_mp":
          return 1;
      }

      break;
    case "tacticalinsertion":
      switch (var_1.basename) {
        case "s4_hand_flare_mp":
          return 1;
      }

      break;
  }

  return 0;
}

_id_2925(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self notify("bot_watch_nodes");
  self endon("bot_watch_nodes");
  self endon("bot_watch_nodes_stop");
  self endon("using_remote");
  self endon("death_or_disconnect");

  if(isDefined(var_4)) {
    self endon(var_4);
  }

  if(isDefined(var_5)) {
    self endon(var_5);
  }

  if(isDefined(var_6)) {
    self endon(var_6);
  }

  if(isDefined(var_7)) {
    self endon(var_7);
  }

  wait 0.5;
  var_8 = 1;

  if(self _meth_81F4()) {
    var_8 = 0;
  }

  var_9 = _func_0219(self _meth_803D());

  while(var_8) {
    if(self _meth_8042() && self _meth_804F()) {
      if(distancesquared(self _meth_803B(), self.origin) < var_9) {
        if(length(self getvelocity()) <= 1) {
          var_8 = 0;
        }
      }
    }

    if(var_8) {
      wait 0.05;
    }
  }

  var_10 = self.origin;
  var_11 = (0, 0, self _meth_8172());

  if(isDefined(var_0)) {
    self._id_10A77 = [];

    foreach(var_13 in var_0) {
      var_14 = 0;

      if(distance2dsquared(self.origin, var_13.origin) <= 40) {
        var_14 = 1;
      }

      var_15 = self getEye();
      var_16 = vectordot((0, 0, 1), vectornormalize(var_13.origin + var_11 - var_15));

      if(abs(var_16) > 0.92) {
        var_14 = 1;
      }

      if(!var_14) {
        self._id_10A77[self._id_10A77.size] = var_13;
      }
    }
  }

  if(!isDefined(self._id_10A77)) {
    return;
  }
  thread _id_10A78();
  self._id_10A77 = scripts\engine\utility::array_randomize(self._id_10A77);

  foreach(var_13 in self._id_10A77) {
    var_13._id_10A75[self._id_5501] = 1.0;
    var_13._id_10A74[self._id_5501] = 1.0;
  }

  var_20 = [];

  for(var_21 = 0; var_21 < self._id_10A77.size; var_21++) {
    var_20[var_21] = [];
    var_22 = vectornormalize(self._id_10A77[var_21].origin - self.origin);

    for(var_23 = 0; var_23 < self._id_10A77.size; var_23++) {
      if(var_21 == var_23) {
        continue;
      }
      var_24 = vectornormalize(self._id_10A77[var_23].origin - self.origin);
      var_25 = vectordot(var_22, var_24);

      if(var_25 > 0.94) {
        var_20[var_21] = ::scripts\engine\utility::array_add(var_20[var_21], var_23);
      }
    }
  }

  for(;;) {
    var_26 = -1;
    var_27 = 0;

    for(var_21 = 0; var_21 < self._id_10A77.size; var_21++) {
      if(var_20[var_21].size > var_27) {
        var_26 = var_21;
        var_27 = var_20[var_21].size;
      }
    }

    if(var_26 == -1) {
      break;
    }

    self._id_10A77[var_26]._id_10A75[self._id_5501] = 0.5;
    self._id_10A77[var_26]._id_10A74[self._id_5501] = 0.5;
    var_20[var_26] = [];

    for(var_21 = 0; var_21 < var_20.size; var_21++) {
      if(scripts\engine\utility::array_contains(var_20[var_21], var_26)) {
        var_20[var_21] = ::scripts\engine\utility::array_remove(var_20[var_21], var_26);
      }
    }
  }

  var_28 = gettime();
  var_29 = var_28;
  var_30 = [];
  var_31 = undefined;

  if(isDefined(var_1)) {
    var_31 = (0, var_1, 0);
  }

  var_32 = isDefined(var_31) && isDefined(var_2);
  var_33 = undefined;
  var_34 = undefined;
  wait 0.1;

  for(;;) {
    var_35 = gettime();
    self notify("still_watching_nodes");
    var_36 = self _meth_8032();

    if(isDefined(var_3) && var_35 >= var_3) {
      return;
    }
    if(_id_09F9::_id_27ED()) {
      self _meth_8045(undefined);
      wait 0.2;
      continue;
    }

    if(!self _meth_8042() || !self _meth_804F()) {
      wait 0.2;
      continue;
    }

    if(isDefined(var_34) && var_34._id_10A75[self._id_5501] == 0.0) {
      var_29 = var_35;
    }

    if(self._id_10A77.size > 0) {
      var_37 = 0;

      if(isDefined(self._id_0192)) {
        var_38 = self _meth_8204(self._id_0192);
        var_39 = self _meth_8205(self._id_0192);

        if(var_39 && var_35 - var_39 < 5000) {
          var_40 = vectornormalize(var_38 - self.origin);
          var_41 = 0;

          for(var_21 = 0; var_21 < self._id_10A77.size; var_21++) {
            var_42 = vectornormalize(self._id_10A77[var_21].origin - self.origin);
            var_25 = vectordot(var_40, var_42);

            if(var_25 > var_41) {
              var_41 = var_25;
              var_34 = self._id_10A77[var_21];
              var_37 = 1;
            }
          }
        }
      }

      if(!var_37 && var_35 >= var_29) {
        var_43 = [];

        for(var_21 = 0; var_21 < self._id_10A77.size; var_21++) {
          var_13 = self._id_10A77[var_21];
          var_44 = var_13 _meth_8162();

          if(var_32 && !scripts\engine\utility::_id_10E76(self.origin, var_31, var_13.origin, var_2)) {
            continue;
          }
          if(distance2dsquared(self.origin, var_13.origin) <= 10) {
            continue;
          }
          if(!isDefined(var_30[var_44])) {
            var_30[var_44] = 0;
          }

          if(scripts\engine\utility::_id_10E76(self.origin, self getplayerangles(), var_13.origin, var_36)) {
            var_30[var_44] = var_35;
          }

          for(var_45 = 0; var_45 < var_43.size; var_45++) {
            if(var_30[var_43[var_45] _meth_8162()] > var_30[var_44]) {
              break;
            }
          }

          var_43 = scripts\engine\utility::_id_1BB3(var_43, var_13, var_45);
        }

        var_33 = var_34;
        var_34 = undefined;

        if(var_43.size == 1) {
          var_34 = var_43[0];
        } else if(var_43.size > 1) {
          var_46 = [];
          var_47 = 0;

          for(var_21 = 0; var_21 < var_43.size; var_21++) {
            var_48 = 1.0 - var_21 / (var_43.size - 1) * 0.5;
            var_49 = [var_43[var_21], var_43[var_21]._id_10A75[self._id_5501] * var_48];
            var_46[var_46.size] = var_49;
            var_47 = var_47 + var_49[1];
          }

          var_50 = randomfloat(var_47);

          for(var_21 = 0; var_21 < var_46.size; var_21++) {
            if(var_50 < var_46[var_21][1]) {
              var_34 = var_46[var_21][0];
              break;
            }

            var_50 = var_50 - var_46[var_21][1];
          }
        }

        if(isDefined(var_34)) {
          var_29 = var_35 + randomintrange(3000, 5000);
          var_51 = !isDefined(var_33) || var_33 != var_34;

          if(var_51 && istrue(self._id_271A)) {
            childthread _id_27E8(var_34);
          }
        }
      }

      if(isDefined(var_34)) {
        var_52 = var_34.origin + var_11;

        if(distance2dsquared(self.origin, var_52) <= 10) {
          self _meth_8045(undefined);
          var_34 = undefined;
          var_29 = 0;
        } else
          self _meth_8045(var_52, 0.4, "script_search");
      }
    }

    wait 0.2;
  }
}

_id_27E8(var_0) {
  if(isDefined(self._id_412E)) {
    var_1 = self._id_412E;

    if(var_1 == "prone" && self getstance() == "prone") {
      self _meth_805B("crouch");
      wait 1.0;
    }

    if(var_1 == "prone") {
      if(_id_10A7B(self _meth_815E(), var_0)) {
        self _meth_805B("prone");
      } else {
        var_1 = "crouch";
      }
    }

    if(var_1 == "crouch") {
      if(_id_10A7A(self _meth_815E(), var_0)) {
        self _meth_805B("crouch");
      } else {
        var_1 = "stand";
      }
    }

    if(var_1 == "stand") {
      self _meth_805B("stand");
    }
  }
}

_id_10A7B(var_0, var_1) {
  var_2 = var_1 _meth_8162();

  if(!isDefined(var_0._id_BDB1) || !isDefined(var_0._id_BDB1[var_2])) {
    var_3 = _func_0202(var_0.origin + (0, 0, 11), var_1.origin + (0, 0, 11), 0, undefined);
    var_0._id_BDB1[var_2] = var_3;
  }

  return var_0._id_BDB1[var_2];
}

_id_10A7A(var_0, var_1) {
  var_2 = var_1 _meth_8162();

  if(!isDefined(var_0._id_BDB1) || !isDefined(var_0._id_BDB1[var_2])) {
    var_3 = _func_0202(var_0.origin + (0, 0, 40), var_1.origin + (0, 0, 11), 0, undefined);
    var_0._id_BDB1[var_2] = var_3;
  }

  return var_0._id_BDB1[var_2];
}

_id_10A79() {
  self notify("bot_watch_nodes_stop");

  if(isDefined(self._id_10A77)) {
    foreach(var_1 in self._id_10A77) {
      _id_10A76(var_1);
    }
  }

  self._id_10A77 = undefined;
}

_id_10A76(var_0) {
  var_0._id_10A75[self._id_5501] = undefined;
  var_0._id_10A74[self._id_5501] = undefined;
}

_id_10A78() {
  self notify("watch_nodes_aborted");
  self endon("watch_nodes_aborted");
  self endon("bot_watch_nodes_stop");
  self endon("disconnect");

  for(;;) {
    var_0 = scripts\engine\utility::_id_108A7(0.5, "still_watching_nodes");

    if(!isDefined(var_0) || var_0 != "still_watching_nodes") {
      thread _id_10A79();
      return;
    }
  }
}

_id_2832(var_0, var_1) {
  if(isDefined(var_1) && var_1 != (0, 0, 0)) {
    if(!scripts\engine\utility::_id_10E76(self.origin, self getplayerangles(), var_1, self _meth_8032())) {
      var_2 = self _meth_804D(var_1);

      if(isDefined(var_2)) {
        self _meth_8045(var_2 + (0, 0, 40), 1.0, "script_seek");
      }
    }

    self _meth_8046("known_enemy", undefined, var_1);
  }
}

_id_27C5(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.classname)) {
    if(var_1.classname == "grenade") {
      if(isDefined(var_0) && var_0.classname == "worldspawn") {
        return undefined;
      }

      if(!_id_2787(var_1)) {
        return var_0;
      }
    } else if(var_1.classname == "rocket") {
      if(isDefined(var_1._id_100A9)) {
        return var_1._id_100A9;
      }

      if(isDefined(var_1.type) && var_1.type == "remote") {
        return var_1;
      }

      if(isDefined(var_1.owner)) {
        return var_1.owner;
      }
    } else if(var_1.classname == "worldspawn" || var_1.classname == "trigger_hurt")
      return undefined;

    return var_1;
  }

  return var_0;
}

_id_2787(var_0) {
  var_1 = var_0.weapon_name;

  if(!isDefined(var_1)) {
    var_1 = var_0._id_04FE;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(issubstr(var_1, "s4_c4_mp")) {
    return 1;
  }

  if(issubstr(var_1, "claymore_mp")) {
    return 1;
  }

  if(issubstr(var_1, "mine_mp")) {
    return 1;
  }

  if(issubstr(var_1, "proximity_explosive_mp")) {
    return 1;
  }

  return 0;
}

_id_2916(var_0, var_1) {
  return var_0[0] == var_1[0] && var_0[1] == var_1[1] && var_0[2] == var_1[2];
}

_id_26F5(var_0) {
  var_0._id_7925 = [];

  if(var_0._id_27FE == "use") {
    _id_26F6(var_0);
  } else if(var_0._id_27FE == "damage") {
    _id_26F4(var_0);
  } else {}
}

_id_28A6(var_0) {
  var_0._id_1642 = 1;
  level._id_9340 = scripts\engine\utility::array_remove(level._id_9340, var_0);
}

_id_26F6(var_0) {
  if(!issubstr(var_0._id_00EC, "trigger_use")) {
    return;
  }
  if(!isDefined(var_0.target)) {
    return;
  }
  if(isDefined(var_0._id_28F4)) {
    return;
  }
  if(!isDefined(var_0._id_FE12)) {
    return;
  }
  var_1 = _func_00B3(var_0.target, "targetname");

  if(var_1.size != 1) {
    return;
  }
  var_0._id_28F4 = var_1[0];

  if(!isDefined(level._id_9340)) {
    level._id_9340 = [];
  }

  level._id_9340 = scripts\engine\utility::array_add(level._id_9340, var_0);
}

_id_26F4(var_0) {
  if(!issubstr(var_0._id_00EC, "trigger_damage")) {
    return;
  }
  var_1 = _func_00B3(var_0.target, "targetname");

  if(var_1.size != 2) {
    return;
  }
  var_0._id_28F6 = var_1;

  if(!isDefined(level._id_9340)) {
    level._id_9340 = [];
  }

  level._id_9340 = scripts\engine\utility::array_add(level._id_9340, var_0);
}

_id_27D1(var_0, var_1) {
  var_2 = 0;

  foreach(var_5, var_4 in var_0) {
    if(var_2 == var_1) {
      return var_5;
    }

    var_2++;
  }

  return undefined;
}

_id_27D9(var_0, var_1) {
  for(var_2 = 0; var_2 < level._id_110E1; var_2++) {
    var_3 = _func_00F6(var_2);
    var_3._id_10426 = 0;
  }

  var_4 = _func_00F6(var_0);
  return _id_27DA(var_4, var_1);
}

_id_27DA(var_0, var_1) {
  var_2 = [];
  var_2[0] = _func_00B8(var_0);
  var_0._id_10426 = 1;
  var_3 = _func_00A6(var_0);

  foreach(var_5 in var_3) {
    if(!var_5._id_10426) {
      var_6 = distance(var_0.origin, var_5.origin);

      if(var_6 < var_1) {
        var_7 = _id_27DA(var_5, var_1 - var_6);
        var_2 = scripts\engine\utility::array_combine(var_7, var_2);
      }
    }
  }

  return var_2;
}

_id_27C9(var_0) {
  return level._id_2854[var_0];
}

_id_27D2() {
  return int(bot_get_client_limit() / 2);
}

bot_get_client_limit() {
  var_0 = getdvarint("#x3db5d3184a15d696d", 0);
  var_0 = max(var_0, getdvarint("#x38d0f89ef3006396", 0));

  if(var_0 > level._id_9C5D) {
    return level._id_9C5D;
  }

  return var_0;
}

_id_289C() {
  self notify("bot_queued_process_level_thread");
  self endon("bot_queued_process_level_thread");
  wait 0.05;

  for(;;) {
    if(isDefined(level._id_289E) && level._id_289E.size > 0) {
      var_0 = level._id_289E[0];

      if(isDefined(var_0) && isDefined(var_0.owner)) {
        var_1 = undefined;

        if(isDefined(var_0._id_AE65)) {
          var_1 = var_0.owner[[var_0._id_6016]](var_0._id_AE62, var_0._id_AE63, var_0._id_AE64, var_0._id_AE65);
        } else if(isDefined(var_0._id_AE64)) {
          var_1 = var_0.owner[[var_0._id_6016]](var_0._id_AE62, var_0._id_AE63, var_0._id_AE64);
        } else if(isDefined(var_0._id_AE63)) {
          var_1 = var_0.owner[[var_0._id_6016]](var_0._id_AE62, var_0._id_AE63);
        } else if(isDefined(var_0._id_AE62)) {
          var_1 = var_0.owner[[var_0._id_6016]](var_0._id_AE62);
        } else {
          var_1 = var_0.owner[[var_0._id_6016]]();
        }

        var_0.owner notify(var_0._id_A3C8, var_1);
      }

      var_2 = [];

      for(var_3 = 1; var_3 < level._id_289E.size; var_3++) {
        var_2[var_3 - 1] = level._id_289E[var_3];
      }

      level._id_289E = var_2;
    }

    wait 0.05;
  }
}

_id_289B(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_289E)) {
    level._id_289E = [];
  }

  foreach(var_8, var_7 in level._id_289E) {
    if(var_7.owner == self && var_7.name == var_0) {
      self notify(var_7.name);
      level._id_289E[var_8] = undefined;
    }
  }

  var_7 = spawnStruct();
  var_7.owner = self;
  var_7.name = var_0;
  var_7._id_A3C8 = var_7.name + "_done";
  var_7._id_6016 = var_1;
  var_7._id_AE62 = var_2;
  var_7._id_AE63 = var_3;
  var_7._id_AE64 = var_4;
  var_7._id_AE65 = var_5;
  level._id_289E[level._id_289E.size] = var_7;

  if(!isDefined(level._id_289D)) {
    level._id_289D = 1;
    level thread _id_289C();
  }

  self waittill(var_7._id_A3C8, var_9);
  return var_9;
}

_id_280F() {
  return scripts\mp\utility\player::_id_8ACE() || self _meth_81CC();
}

_id_27C8(var_0) {
  var_1 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var_1 = self.weaponlist;
  } else {
    var_1 = self getweaponslistprimaries();
  }

  foreach(var_3 in var_1) {
    var_4 = weaponclipsize(var_3);
    var_5 = self getweaponammostock(var_3);

    if(var_5 <= var_4) {
      return 1;
    }

    if(self _meth_8135(var_3) <= var_0) {
      return 1;
    }
  }

  return 0;
}

_id_27C7(var_0) {
  var_1 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var_1 = self.weaponlist;
  } else {
    var_1 = self getweaponslistprimaries();
  }

  var_2 = 0;
  var_3 = 0;

  foreach(var_5 in var_1) {
    var_6 = weaponclipsize(var_5);
    var_7 = self getweaponammostock(var_5);

    if(var_7 <= var_6 || self _meth_8135(var_5) <= var_0) {
      var_3++;
    }
  }

  if(var_3 == var_1.size) {
    var_2 = 1;
  }

  return var_2;
}

_id_2891(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 256;
  }

  if(!isDefined(var_2)) {
    var_2 = 72;
  }

  var_3 = _func_02AB(var_0);
  var_4 = var_3 - var_0;

  if(_func_0134(var_4) > var_1 * var_1) {
    return 0;
  }

  if(abs(var_4[2]) > var_2) {
    return 0;
  }

  return 1;
}

_id_285A(var_0) {
  level endon("game_ended");
  self notify("bot_monitor_enemy_camp_spots");
  self endon("bot_monitor_enemy_camp_spots");
  level._id_538C = [];
  level._id_538B = [];
  level._id_538A = [];

  for(;;) {
    wait 1.0;
    var_1 = [];

    if(!isDefined(var_0)) {
      continue;
    }
    foreach(var_3 in level._id_AE7C) {
      if(!isDefined(var_3.team)) {
        continue;
      }
      if(var_3[[var_0]]() && !isDefined(var_1[var_3.team])) {
        level._id_538A[var_3.team] = undefined;
        level._id_538C[var_3.team] = var_3 _meth_804C(1);

        if(isDefined(level._id_538C[var_3.team])) {
          if(!isDefined(level._id_538B[var_3.team]) || !scripts\engine\utility::array_contains(level._id_538C[var_3.team], level._id_538B[var_3.team])) {
            level._id_538B[var_3.team] = ::scripts\engine\utility::random(level._id_538C[var_3.team]);
          }

          if(isDefined(level._id_538B[var_3.team])) {
            var_4 = [];

            foreach(var_6 in level._id_AE7C) {
              if(!isDefined(var_6.team)) {
                continue;
              }
              if(var_6[[var_0]]() && var_6.team == var_3.team) {
                var_4[var_4.size] = var_6;
              }
            }

            var_4 = _func_0204(var_4, level._id_538B[var_3.team]);

            if(var_4.size > 0) {
              level._id_538A[var_3.team] = var_4[0];
            }
          }
        }

        var_1[var_3.team] = 1;
      }
    }
  }
}

_id_290F() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isai(self)) {
    return 0;
  }

  if(!isDefined(self.team)) {
    return 0;
  }

  if(self.team == "spectator") {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(!scripts\mp\utility\entity::_id_8744(self)) {
    return 0;
  }

  if(!isDefined(self._id_B023) || self._id_B023 == "camper") {
    return 0;
  }

  return 1;
}

_id_290C() {
  if(!isDefined(level._id_538A)) {
    return;
  }
  if(!isDefined(level._id_538A[self.team])) {
    return;
  }
  if(level._id_538A[self.team] == self) {
    _id_09F9::_id_2766();
    self _meth_8058(level._id_538B[self.team], 128, "objective", undefined, 256);
    _id_291C();
  }
}

_id_279B(var_0, var_1) {
  self notify("bot_force_stance_for_time");
  self endon("bot_force_stance_for_time");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self _meth_805B(var_0);
  wait(var_1);
  self _meth_805B("none");
}

_id_D249(var_0) {
  if(!(isDefined(self._id_7925) && scripts\engine\utility::array_contains(self._id_7925, var_0))) {
    self._id_7925 = scripts\engine\utility::array_add(self._id_7925, var_0);
    var_0 notify("calculate_new_level_targets");
  }
}

_id_1032(var_0, var_1) {
  if(isDefined(level._id_279D) && isDefined(level._id_279D["bots_add_to_level_targets"])) {
    var_0._id_FE12 = var_1;
    var_0._id_27FE = "use";
    [[level._id_279D["bots_add_to_level_targets"]]](var_0);
  }
}

_id_C3C4(var_0) {
  if(isDefined(level._id_279D) && isDefined(level._id_279D["bots_remove_from_level_targets"])) {
    [[level._id_279D["bots_remove_from_level_targets"]]](var_0);
  }
}

_id_1031(var_0) {
  if(isDefined(level._id_279D) && isDefined(level._id_279D["bots_add_to_level_targets"])) {
    var_0._id_27FE = "damage";
    [[level._id_279D["bots_add_to_level_targets"]]](var_0);
  }
}

_id_C3C3(var_0) {
  if(isDefined(level._id_279D) && isDefined(level._id_279D["bots_remove_from_level_targets"])) {
    [[level._id_279D["bots_remove_from_level_targets"]]](var_0);
  }
}

_id_A66D(var_0) {
  if(isDefined(level._id_279D) && isDefined(level._id_279D["notify_enemy_bots_bomb_used"])) {
    self[[level._id_279D["notify_enemy_bots_bomb_used"]]](var_0);
  }
}

_id_66EC() {
  if(isDefined(level._id_279D) && isDefined(level._id_279D["bot_get_rank_xp"])) {
    return self[[level._id_279D["bot_get_rank_xp"]]]();
  }
}

_id_2811() {
  return self _meth_8043();
}

_id_399B(var_0) {
  if(!isbot(var_0)) {
    return 0;
  }

  if(!_id_48DA()) {
    return 0;
  }

  return 1;
}

_id_48DA() {
  return 0;
}

_id_2774(var_0) {
  self notify("bot_disable_movement_for_time");
  self endon("bot_disable_movement_for_time");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self _meth_8054("disable_movement", 1);
  wait(var_0);
  self _meth_8054("disable_movement", 0);
}

_id_6022(var_0) {
  var_1 = tablelookupgetnumrows(var_0);
  var_2 = spawnStruct();
  var_2._id_D729 = [];
  var_2._id_D729["recruit"] = [];
  var_2._id_D729["regular"] = [];
  var_2._id_D729["hardened"] = [];
  var_2._id_D729["veteran"] = [];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = tablelookupbyrow(var_0, var_3, 0);
    var_2._id_D729["recruit"][var_4] = spawnStruct();
    var_2._id_D729["regular"][var_4] = spawnStruct();
    var_2._id_D729["hardened"][var_4] = spawnStruct();
    var_2._id_D729["veteran"][var_4] = spawnStruct();
    var_5 = tablelookupbyrow(var_0, var_3, 1);
    var_2._id_D729["recruit"][var_4] = var_5;
    var_6 = tablelookupbyrow(var_0, var_3, 2);
    var_2._id_D729["regular"][var_4] = var_6;
    var_7 = tablelookupbyrow(var_0, var_3, 3);
    var_2._id_D729["hardened"][var_4] = var_7;
    var_8 = tablelookupbyrow(var_0, var_3, 4);
    var_2._id_D729["veteran"][var_4] = var_8;
  }

  return var_2;
}

_id_290D(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level._id_498C;
  }

  var_2 = var_1._id_D729[var_0];
  var_3 = getarraykeys(var_2);

  foreach(var_5 in var_3) {
    if(var_5 == "burstFireType") {
      var_6 = var_1._id_D729[var_0][var_5];
    } else {
      var_6 = float(var_1._id_D729[var_0][var_5]);
    }

    self _meth_8053(var_5, var_6);
  }
}

_id_28C5(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = level._id_498C;
  }

  var_3 = var_2._id_D729[var_0];
  var_4 = getarraykeys(var_3);

  foreach(var_6 in var_4) {
    if(var_6 != var_1) {
      continue;
    }
    if(var_6 == "burstFireType") {
      var_7 = var_2._id_D729[var_0][var_6];
    } else {
      var_7 = float(var_2._id_D729[var_0][var_6]);
    }

    self _meth_8053(var_6, var_7);
    return;
  }
}