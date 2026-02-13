/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1991.gsc
*************************************************/

init() {}

_id_CDBE() {}

#using_animtree("script_model");

_id_3F5D(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0._id_B5A4)) {
    return;
  }
  var_0._id_18AF = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  var_0._id_B5A4 = spawn("script_model", var_0.origin);
  var_0._id_B5A4 setModel(var_2);
  var_0._id_B5A4 hide();
  var_0._id_B5A4._id_18AF = var_1;
  var_0._id_B5A4 useanimtree(#animtree);
  var_0 playerlinktodelta(var_0._id_B5A4, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  var_0 _id_10A7E();
  _id_C436(var_0);
}

_id_C436(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_B5A4)) {
    return;
  }
  var_0 unlink();
  var_1 = var_0 _meth_812D(var_0.origin);

  if(isDefined(var_1)) {
    var_0 setorigin(var_1);
  } else {
    var_0 setorigin(var_0.origin + (0, 0, 100));
  }

  var_0._id_B5A4 delete();
  var_0._id_B5A4 = undefined;
}

_id_10A7E(var_0) {
  scripts\engine\utility::waittill_any_2("remove_rig", "death_or_disconnect");
}

_id_0FB7(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);

  foreach(var_4 in var_2) {
    var_5 = spawnStruct();
    _id_0FB6(var_5, var_4);
    var_5 _id_1D1E(level._id_EF89);

    if(!isDefined(level._id_487E[var_0])) {
      level._id_487E[var_0] = [];
    }

    level._id_487E[var_0][level._id_487E[var_0].size] = var_5;
    var_5 _id_BD3B("init");
  }
}

_id_0FB6(var_0, var_1) {
  if(!isDefined(var_0._id_5526)) {
    var_0._id_5526 = [];
  }

  var_0 _id_C0A1(var_1);
  var_0 _id_C09D(var_1);
  var_0._id_5526[var_0._id_5526.size] = var_1;
  var_1.parent = var_0;

  if(isDefined(var_1.target)) {
    var_2 = getEntArray(var_1.target, "targetname");

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_4 in var_2) {
        _id_0FB6(var_0, var_4);
      }
    }
  }
}

_id_C0A1(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0.classname) {
    case "trigger_use_touch":
      self._id_FE16 = var_0;
      break;
    case "script_origin":
      var_1 = var_0._id_CD99;

      if(isDefined(var_1)) {
        switch (var_1) {
          case "usePrompt_front":
            if(!isDefined(self._id_FE96)) {
              self._id_FE96 = [];
            }

            self._id_FE96["front"] = _id_D761(var_0.origin);
            self._id_FE96["front"]._id_CBD1 = "front";
            break;
          case "sceneNode_front":
            if(!isDefined(self._id_CBD3)) {
              self._id_CBD3 = [];
            }

            self._id_CBD3["front"] = var_0;
            break;
          case "usePrompt_back":
            if(!isDefined(self._id_FE96)) {
              self._id_FE96 = [];
            }

            self._id_FE96["back"] = _id_D761(var_0.origin);
            self._id_FE96["back"]._id_CBD1 = "back";
            break;
          case "sceneNode_back":
            if(!isDefined(self._id_CBD3)) {
              self._id_CBD3 = [];
            }

            self._id_CBD3["back"] = var_0;
            break;
        }
      }

      break;
    case "scriptable":
      self._id_03A9 = var_0;
      break;
  }
}

_id_C09D(var_0) {
  if(!isDefined(var_0._id_039B)) {
    return;
  }
  var_1 = strtok(var_0._id_039B, ",");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "|");

    if(!isDefined(var_4)) {
      return;
    }
    if(var_4.size < 2) {
      return;
    }
    var_3 = var_4[0];

    if(!isDefined(var_0._id_0E8E)) {
      var_0._id_0E8E = [];
    }

    if(!isDefined(var_0._id_0E8E[var_3])) {
      var_0._id_0E8E[var_3] = [];
    }

    for(var_5 = 1; var_5 < var_4.size; var_5++) {
      var_0._id_0E8E[var_3][var_0._id_0E8E[var_3].size] = var_4[var_5];
    }
  }
}

_id_10972(var_0, var_1) {
  level endon("game_ended");
  wait(var_1);
  _id_BD3B(var_0);
}

_id_10852(var_0) {
  level endon("game_ended");
  self waittill(var_0);
  _id_BD3B(var_0);
}

_id_BD3B(var_0) {
  if(!isDefined(self._id_5526)) {
    return;
  }
  foreach(var_2 in self._id_5526) {
    if(isDefined(var_2._id_0E8E) && isDefined(var_2._id_0E8E[var_0])) {
      foreach(var_4 in var_2._id_0E8E[var_0]) {
        var_2 _id_0E8C(var_4);
      }
    }
  }

  self._id_E747 = var_0;
}

_id_0E8C(var_0) {
  switch (var_0) {
    case "show":
      self show();
      break;
    case "hide":
      self hide();
      break;
    case "solid":
      self solid();
      break;
    case "notsolid":
      self notsolid();
      break;
    case "disconnectpaths":
      self _meth_80B5();
      break;
    case "connectpaths":
      self _meth_8093();
      break;
    case "bomb_explosion":
      var_1 = self.origin;
      var_2 = self.angles;
      var_3 = spawnfx(level._effect["breach_explode"], var_1, anglesToForward(var_2) * -1.0, (0, 0, 1));
      triggerfx(var_3);
      physicsexplosionsphere(var_1, 200, 100, 3);
      playrumbleonposition("grenade_rumble", var_1);
      earthquake(0.5, 1.0, var_1, 1500);
      self.parent._id_B1CB setscriptablepartstate("bomb", "destroy");
      break;
  }
}

_id_D761(var_0) {
  var_1 = _id_07D6::_id_3FF0(var_0, "HINT_BUTTON", "hud_icon_c4_plant", &"MP/BREACH", undefined, undefined, undefined, 800, 120, 72, 120);

  if(!isDefined(level._id_2B70)) {
    level._id_2B70 = [];
  }

  level._id_2B70[level._id_2B70.size] = var_1;
  self._id_463E = 0;
  thread _id_FEEB(var_1);
  return var_1;
}

_id_261B(var_0, var_1) {
  var_2 = var_1.team;
  self._id_463E = 0;

  if(!isDefined(self._id_2B6C)) {
    if(!isDefined(level._id_2B6C)) {
      level._id_2B6C = 0;
    } else {
      level._id_2B6C++;
    }

    self._id_2B6C = level._id_2B6C;
  }

  _id_260A(var_2);

  if(!self._id_463E) {
    _id_BD3B("destroyed");
    var_3 = self._id_FE96[var_0].origin;

    if(isDefined(self._id_03A9)) {
      if(var_0 == "front") {
        self._id_03A9 setscriptablepartstate("base", "destroyFront");
      } else {
        self._id_03A9 setscriptablepartstate("base", "destroyBack");
      }
    } else {
      var_4 = self._id_FE96[var_0].angles;
      var_5 = spawnfx(level._effect["breach_explode"], var_3, anglesToForward(var_4) * -1.0, (0, 0, 1));
      triggerfx(var_5);
      self._id_B1CB setscriptablepartstate("bomb", "destroy");
    }

    physicsexplosionsphere(var_3, 200, 100, 3);
    playrumbleonposition("grenade_rumble", var_3);
    earthquake(0.5, 1.0, var_3, 1500);

    foreach(var_7 in self._id_FE96) {
      var_7 delete();
      level._id_2B70 = scripts\engine\utility::array_remove(level._id_2B70, var_7);
    }

    wait 0.1;

    if(isDefined(var_1)) {
      self._id_B1CB radiusdamage(self._id_B1CB.origin, 300, 120, 10, var_1, "MOD_EXPLOSIVE", "bomb_site_mp");
    } else {
      self._id_B1CB radiusdamage(self._id_B1CB.origin, 300, 120, 10, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
    }

    if(isDefined(level._id_7A96)) {
      thread _id_B850(self._id_B1CB.origin);
    }
  }

  self._id_B1CB delete();
  self._id_B1CB = undefined;
  self._id_B1CD = undefined;
  setomnvar("ui_ingame_timer_" + self._id_2B6C, 0);
  setomnvar("ui_ingame_timer_ent_" + self._id_2B6C, undefined);

  if(self._id_463E) {
    foreach(var_7 in self._id_FE96) {
      var_7 sethintstring(&"MP/BREACH");
    }

    _id_1D1E(level._id_EF89);
    _id_BD3B("init");
  }
}

_id_B850(var_0) {
  wait 1;

  if(distance2d(level._id_7A96[0].origin, var_0) < 500) {
    level._id_7A96[0] playSound("dx_mpb_us3_hvt_up");
  }
}

_id_260A(var_0) {
  self endon("defused");

  foreach(var_2 in self._id_FE96) {
    var_2 sethintstring(&"MP/BREACH_DEFUSE");
  }

  self._id_F25D = spawn("script_model", self._id_B1CB.origin);
  self._id_F25D makeuseable();
  _id_1D1E(scripts\mp\utility\teams::_id_6A01(var_0));
  var_4 = gettime();
  var_5 = int(var_4 + 5000);
  setomnvar("ui_ingame_timer_" + self._id_2B6C, var_5);
  setomnvar("ui_ingame_timer_ent_" + self._id_2B6C, self._id_F25D);
  var_6 = var_5 - var_4;

  while(!self._id_463E && var_6 > 0) {
    var_4 = gettime();
    var_6 = var_5 - var_4;

    if(var_6 < 1500) {
      if(var_6 <= 250) {
        self._id_B1CB playSound("breach_warning_beep_05");
      } else if(var_6 < 500) {
        self._id_B1CB playSound("breach_warning_beep_04");
      } else if(var_6 < 1500) {
        self._id_B1CB playSound("breach_warning_beep_03");
      } else {
        self._id_B1CB playSound("breach_warning_beep_02");
      }

      wait 0.25;
    } else if(var_6 < 3500) {
      self._id_B1CB playSound("breach_warning_beep_02");
      wait 0.5;
    } else {
      self._id_B1CB playSound("breach_warning_beep_01");
      wait 1.0;
    }

    if(var_6 < 0) {
      break;
    }
  }
}

_id_FEEB(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!scripts\engine\utility::array_contains(self._id_83B7, var_1.team)) {
      continue;
    }
    if(var_1 scripts\mp\utility\weapon::_id_7169()) {
      return 0;
    }

    if(var_1 meleebuttonpressed()) {
      return 0;
    }

    if(var_1 scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    if(!isDefined(self._id_B1CB)) {
      _id_B1C7(var_0, var_1);
      continue;
    }

    _id_463D(var_1);
  }
}

_id_B1C7(var_0, var_1) {
  thread _id_10BD6(var_1);
  var_1._id_9515 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_1 playerlinktodelta(var_1._id_9515, "tag_origin", 1, 0, 0, 0, 0, 0);
  var_1._id_9515 moveto(self._id_CBD3[var_0._id_CBD1].origin, 0.25, 0.1, 0.1);
  var_1._id_9515 rotateto(self._id_CBD3[var_0._id_CBD1].angles, 0.25, 0.1, 0.1);
  var_1 setstance("stand");

  if(!var_1 _id_6FA0()) {
    var_1 unlink();
    var_1._id_9515 delete();
    var_1._id_9515 = undefined;
    return 0;
  }

  if(istrue(self._id_3163)) {
    return 0;
  }

  var_1 unlink();
  var_1._id_9515 delete();
  var_1._id_9515 = undefined;
  var_1 setorigin(self._id_CBD3[var_0._id_CBD1].origin);
  var_1 setplayerangles(self._id_CBD3[var_0._id_CBD1].angles);

  foreach(var_3 in self._id_FE96) {
    var_3 hide();
  }

  level thread scripts\mp\battlechatter_mp::_id_F759(var_1, "c4_plant");
  var_5 = scripts\engine\utility::ter_op(var_1.team == "allies", "usp1", "afp1");

  if(level.mapname == "mp_hackney_yard") {
    var_5 = scripts\engine\utility::ter_op(var_1.team == "allies", "ukp1", "abp1");
  }

  var_1 _meth_8287("dx_mpp_" + var_5 + "_breach_plant", "cop_breach_plant", 2);
  thread _id_3F5D(var_1, "planter");
  var_1 thread _id_07AA::_id_17FD(var_1, var_1._id_B5A4, "plant");
  var_6 = spawn("script_model", self._id_CBD3[var_0._id_CBD1].origin);
  var_6 setModel("offhand_wm_c4");
  var_6._id_18AF = "c4";
  var_6 useanimtree(#animtree);
  self._id_B1CB = var_6;
  self._id_B1CD = var_0._id_CBD1;
  self._id_CBD3[var_0._id_CBD1] thread _id_06C6::_id_1845(var_6, "plant");
  var_7 = _func_0079(level._id_CC31["planter"]["plant"]);
  var_8 = 0.5;
  wait(var_7 - var_8);

  if(istrue(self._id_3163)) {
    return 0;
  }

  thread _id_261B(var_0._id_CBD1, var_1);
  _id_6F87(var_1);
  wait(var_8 - 0.1);
  var_1 thread _id_EDC3();
  _id_C436(var_1);
  _id_BD3B("onuse");
  self notify("breach_complete");
  return 1;
}

_id_10BD6(var_0) {
  self endon("breach_complete");
  self._id_3163 = 0;

  for(;;) {
    if(!isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
      foreach(var_2 in self._id_FE96) {
        var_2 show();
      }

      if(isDefined(self._id_B1CB)) {
        self._id_B1CB delete();
        self._id_B1CB = undefined;
        self._id_B1CD = undefined;
      }

      self._id_3163 = 1;
      break;
    }

    waitframe();
  }
}

_id_15C9(var_0) {
  if(isDefined(level._id_2B70)) {
    foreach(var_2 in level._id_2B70) {
      var_2 _meth_80E0(var_0);
    }
  }
}

_id_4B07(var_0) {
  if(isDefined(level._id_2B70)) {
    foreach(var_2 in level._id_2B70) {
      var_2 disableplayeruse(var_0);
    }
  }
}

_id_463D(var_0) {
  self._id_463E = 1;
  self notify("defused");
  _id_6F91(var_0);
}

_id_AB69(var_0) {
  foreach(var_2 in level._id_487E) {
    foreach(var_4 in var_2) {
      var_4 _id_19D9(var_0);
    }
  }
}

_id_1D1E(var_0) {
  self._id_83B7 = var_0;

  foreach(var_2 in level.players) {
    _id_19D9(var_2);
  }
}

_id_19D9(var_0) {
  if(self._id_E747 == "destroyed") {
    return;
  }
  if(!isDefined(self._id_FE96)) {
    return;
  }
  if(scripts\engine\utility::array_contains(self._id_83B7, var_0.team)) {
    if(isDefined(self._id_B1CB)) {
      self._id_F25D hidefromplayer(var_0);

      foreach(var_3, var_2 in self._id_FE96) {
        if(var_3 == self._id_B1CD) {
          var_2 setuseholdduration("duration_medium");
          var_2 _meth_80E0(var_0);
          var_2 showtoplayer(var_0);
          continue;
        }

        var_2 disableplayeruse(var_0);
        var_2 hidefromplayer(var_0);
      }

      return;
    }

    foreach(var_3, var_2 in self._id_FE96) {
      var_2 setuseholdduration("duration_short");
      var_2 _meth_80E0(var_0);
      var_2 showtoplayer(var_0);
    }

    return;
  } else {
    if(isDefined(self._id_B1CB)) {
      self._id_F25D showtoplayer(var_0);
    }

    foreach(var_2 in self._id_FE96) {
      var_2 disableplayeruse(var_0);
      var_2 hidefromplayer(var_0);
    }
  }
}

_id_6F87(var_0) {
  var_1 = "breach";
  var_2 = scripts\mp\rank::getscoreinfovalue(var_1);
  var_0 thread scripts\mp\rank::giverankxp(var_1, var_2);
  var_0 thread scripts\mp\rank::_id_CC00(var_1);
}

_id_6F91(var_0) {
  var_1 = "breach_defuse";
  var_2 = scripts\mp\rank::getscoreinfovalue(var_1);
  var_0 thread scripts\mp\rank::giverankxp(var_1, var_2);
  var_0 thread scripts\mp\rank::_id_CC00(var_1);
}

_id_6FA0() {
  self endon("death_or_disconnect");
  var_0 = makeweapon("s4_gunless");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  var_1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 0);

  if(var_1) {
    self._id_72C3 = var_0;
    scripts\common\utility::_id_1593(0);
    scripts\common\utility::_id_1562(0);
    scripts\common\utility::_id_1554(0);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    scripts\cp_mp\utility\inventory_utility::_id_5ED6();
  }

  return var_1;
}

_id_EDC3() {
  self endon("death_or_disconnect");

  if(!isDefined(self._id_72C3) || !self hasweapon(self._id_72C3)) {
    return;
  }
  self._id_EDE2 = 1;
  scripts\common\utility::_id_1593(1);

  while(self hasweapon(self._id_72C3)) {
    if(!scripts\cp_mp\utility\inventory_utility::_id_87E0(self._id_72C3)) {
      scripts\cp_mp\utility\inventory_utility::_id_0E0C(self._id_72C3);
    } else {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self._id_72C3);
      scripts\cp_mp\utility\inventory_utility::_id_5ED6();
    }

    waitframe();
  }

  self._id_EDE2 = 0;
  self._id_72C3 = undefined;
  scripts\common\utility::_id_1562(1);
  scripts\common\utility::_id_1554(1);
}

_id_C8A0() {
  waitframe();
  _id_06DE::_id_C8A0();
  scripts\engine\utility::_id_1BE2(level._id_C8A4._id_32F8, ::_id_C8A1);
}

_id_C8A1() {
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level._id_C8A4._id_32F8) {
      if(!isDefined(var_1)) {
        continue;
      }
      var_2 = [];

      foreach(var_4 in level.players) {
        if(!scripts\mp\utility\player::isreallyalive(var_4)) {
          continue;
        }
        var_5 = var_4 getentitynumber();

        if(isDefined(var_1.players[var_5])) {
          continue;
        }
        if(var_4 _meth_81CE()) {
          continue;
        }
        var_6 = var_4 _meth_815A();

        if(!isDefined(var_6) || var_6 != var_1) {
          continue;
        }
        var_7 = var_4.origin - var_1._id_F349;

        if(vectordot(var_7, var_1._id_04BD) < 0) {
          continue;
        }
        var_8 = vectordot(var_7, var_1._id_01D7);
        var_9 = abs(var_8);
        var_10 = var_9 / var_1._id_73BA;

        if(var_10 > 1) {
          continue;
        }
        var_11 = vectordot(var_7, var_1._id_0376);
        var_12 = abs(var_11);
        var_13 = var_12 / var_1._id_73BE;

        if(var_13 > 1) {
          continue;
        }
        var_5 = var_4 getentitynumber();
        var_2[var_5] = var_4;
        var_1 _id_C89C(var_4, var_10, var_13, var_8, var_11);
      }

      foreach(var_5, var_4 in var_1.players) {
        var_16 = gettime() - var_1._id_F397[var_5];

        if(!isDefined(var_4) || !scripts\mp\utility\player::isreallyalive(var_4)) {
          var_1 _id_C89B(var_5, undefined, 0);
          continue;
        }

        if(var_4 _meth_81CE()) {
          var_1 _id_C89B(var_5, var_16, 1);
          continue;
        }

        var_6 = var_4 _meth_815A();

        if(!isDefined(var_6) || var_6 != var_1) {
          var_1 _id_C89B(var_5, var_16, 1);
          continue;
        }

        var_7 = var_4.origin - var_1._id_F349;

        if(vectordot(var_7, var_1._id_04BD) < 0) {
          var_1 _id_C89B(var_5, var_16, 1);
          continue;
        }

        var_8 = vectordot(var_7, var_1._id_01D7);
        var_9 = abs(var_8);
        var_10 = var_9 / var_1._id_73BA;

        if(var_10 > 1) {
          var_1 _id_C89B(var_5, var_16, 1);
          continue;
        }

        var_11 = vectordot(var_7, var_1._id_0376);
        var_12 = abs(var_11);
        var_13 = var_12 / var_1._id_73BE;

        if(var_13 > 1) {
          var_1 _id_C89B(var_5, var_16, 1);
          continue;
        }

        var_1._id_F397[var_5] = gettime();
      }

      foreach(var_5, var_4 in var_2) {
        var_1 _id_C899(var_4);
      }
    }

    waitframe();
  }
}

_id_C899(var_0) {
  var_1 = var_0 getentitynumber();
  self.players[var_1] = var_0;
  self._id_F397[var_1] = gettime();
}

_id_C89B(var_0, var_1, var_2) {
  if(var_2) {
    if(isDefined(var_1) && var_1 >= 200) {
      self.players[var_0] = undefined;
      self._id_F397[var_0] = undefined;
      self._id_C8BF[var_0] = undefined;
      self._id_C8BE[var_0] = undefined;
    }
  } else {
    self.players[var_0] = undefined;
    self._id_F397[var_0] = undefined;
    self._id_C8BF[var_0] = undefined;
    self._id_C8BE[var_0] = undefined;
  }
}

_id_C89C(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 > 0.3 && var_2 > 0) {
    var_5 = scripts\engine\utility::ter_op(var_3 >= 0, "front", "back");
    var_6 = scripts\engine\utility::ter_op(var_4 >= 0, "right", "left");
    self setscriptablepartstate("Anim_PlayerStandRock", var_5 + "_" + var_6, 0);
    var_7 = var_0 getentitynumber();
    self._id_C8BF[var_7] = gettime();
    self._id_C8BE[var_7] = var_5 + var_6;
  }
}

remove_destructible_walls() {
  var_0 = 1;

  for(;;) {
    var_1 = tablelookupbyrow("mp/destructible_walls.csv", var_0, 0);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_2 = _func_03C0("scriptable_" + var_1, "classname");

    foreach(var_4 in var_2) {
      if(var_4 _meth_8679("main_part")) {
        if(var_4 _meth_867A("main_part", "no_more_collmap")) {
          var_4 setscriptablepartstate("main_part", "no_more_collmap");
        }
      }

      var_4 _meth_8871(10000);
    }

    var_0++;
  }
}