/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1851.gsc
*************************************************/

_id_2F25(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1)) {
    if(isPlayer(var_1) || isagent(var_1)) {
      self._id_8F15 = var_1;
    }
  }

  if(isDefined(level._id_8F64)) {
    self[[level._id_8F64]]();
  }

  var_10 = _id_0726::_id_642F(self);
  var_11 = 1;
  _id_0705::_id_9764(self, var_1);
  scripts\cp\telemetry_cp::logevent_playerdown(self, var_3, var_1);

  if(isDefined(level._id_AE36)) {
    self[[level._id_AE36]]();
  }

  _id_4584(var_9, var_1);
  return 1;
}

_id_4584(var_0, var_1) {
  if(isDefined(self._id_0157)) {
    self._id_0157++;
  } else {
    self._id_0157 = 1;
  }

  var_2 = _id_60E5(self);

  if(var_2 && isDefined(level._id_52F7) && isDefined(level._id_52A0)) {
    var_3 = scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(var_3)) {}

    if(isDefined(level._id_3BE9._id_0F51)) {
      level thread _id_0987::_id_A871(level._id_3BE9._id_0F51, 0, level._id_52A0["kia"]);
    } else {
      level thread[[level._id_52F7]]("axis", level._id_52A0["kia"]);
    }
  }

  self.pers["cur_kill_streak"] = 0;
  thread _id_5034(var_0, var_2, var_1);
}

_id_4B68() {
  if(isDefined(level._id_A8EB) && isDefined(level._id_0F24) && level._id_0F24 != "") {
    var_0 = level._id_A8F6[level._id_0F24].index;
    var_1 = level._id_A8F6[level._id_0F24]._id_58D9;

    if(isDefined(var_1) && var_1 != "") {
      self setclientomnvar("ui_cp_mission_fail_index", var_0);
      return;
    }

    self setclientomnvar("ui_cp_mission_fail_index", 0);
    return;
  } else
    self setclientomnvar("ui_cp_mission_fail_index", 0);
}

_id_DAD6(var_0) {
  return !istrue(scripts\cp\utility::_id_74D8()) && istrue(var_0._id_DBD8);
}

_id_5034(var_0, var_1, var_2) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("last_stand");
  self notify("last_stand_start");
  var_3 = gettime() + 3000;

  if(isDefined(level.set_min_last_stand_wait_override_func)) {
    var_3 = [[level.set_min_last_stand_wait_override_func]]();
  }

  var_4 = scripts\cp\utility::_id_74D8();
  _id_549E(var_2);

  if(!istrue(self.b_force_laststand)) {
    _id_73EC();
    _id_C42D();
  }

  _id_549F();
  _id_54A6();

  if((scripts\cp\utility::_id_89AE() || level._id_AB30) && _id_75AE()) {
    self.revived = _id_1084B(var_0, var_1, var_4);

    if(istrue(self._id_8303)) {
      self.revived = 1;
    }

    if(!self.revived && isDefined(level._id_52F7) && isDefined(level._id_52A0)) {
      level thread[[level._id_52F7]]("axis", level._id_52A0["kia"]);
      _id_1084C(var_0, 1);
    }
  } else if(_id_DB67(self) || _id_DAD6(self))
    _id_1084C(var_0, var_1);
  else if(_id_9CC5(var_1, var_0)) {
    self.revived = _id_1084B(var_0, var_1);

    if(istrue(self._id_8303)) {
      self.revived = 1;
    }

    if(!self.revived) {
      _id_1084C(var_0, var_1);
    }
  } else
    _id_1084C(var_0, var_1);

  var_5 = (var_3 - gettime()) / 1000;

  if(var_5 > 0) {
    wait(var_5);
  }

  self notify("revive");
  level notify("revive_success", self);
  self._id_8303 = 0;
  _id_574E();
  _id_5748();
  thread scripts\cp\cp_weapon::_id_F42D(1);
  _id_5747();
}

_id_73EC() {
  if(isDefined(level._id_A6DF) && level._id_A6DF == self) {
    _id_073C::_id_4FFF();
  } else if(scripts\cp\cp_weapon::_id_B4C8(self)) {
    if(!istrue(self._id_88DF)) {
      _id_073C::_id_4FFF();
    }
  }
}

_id_C42D() {
  self.a_laststand_lost_perks = [];

  if(isDefined(self._id_11086) && self._id_11086.size > 0) {
    var_0 = getarraykeys(self._id_11086);
    var_1 = 1;

    if(isDefined(self.n_min_perk_level)) {
      var_1 = self.n_min_perk_level;
    }

    foreach(var_3 in var_0) {
      if(self._id_11086[var_3] > var_1) {
        scripts\cp\zombies\perks\zm_perks::decrement_perk(var_3);
        self.a_laststand_lost_perks = scripts\engine\utility::array_add(self.a_laststand_lost_perks, var_3);
      }
    }
  }
}

restore_perks_lost_on_last_stand() {
  if(isDefined(self.a_laststand_lost_perks)) {
    foreach(var_1 in self.a_laststand_lost_perks) {
      if(!scripts\cp\zombies\perks\zm_perks::is_perk_max_level(var_1)) {
        scripts\cp\zombies\perks\zm_perks::increment_perk(var_1);
      }
    }
  }

  self.a_laststand_lost_perks = undefined;
}

_id_7471() {
  self._id_9080 = _func_02B0(self);
  childthread _id_A240();
  scripts\engine\utility::_id_10884("death", "disconnect", "revive", "game_ended", "exit_last_stand", "entered_spectate");
  _func_02B1(self._id_9080);
}

_id_A240() {
  self._id_9081 = self.origin;
  var_0 = 2500;

  while(isDefined(self._id_8F67) && self._id_8F67 == "last_stand") {
    if(!_func_0458(self) && distancesquared(self._id_9081, self.origin) > var_0) {
      _func_02B1(self._id_9080);
      self._id_9080 = _func_02B0(self);
      self._id_9081 = self.origin;
    }

    wait 0.2;
  }
}

_id_54A6() {
  self._id_8F67 = "last_stand";
  self.inlaststand = 1;
  self._id_FF13 = undefined;
  self.health = 1;
  scripts\common\utility::_id_158A(0);
  scripts\cp\utility::_id_1566(1);
  self notify("healthRegeneration");
  self._id_C7CF = 0;
  self._id_4EB2 = _id_0945::_id_664E("downed_crawl_speed");
  _id_FCCC();

  if(!no_hope_left(self)) {
    self playsoundtoplayer("zmb_laststand_enter", self);
    self setscriptablepartstate("lastStand", "active");
    self playsoundtoteam("zmb_revive_alert", self.team, self, self);
  }

  var_0 = 1;

  foreach(var_2 in level.players) {
    if(isalive(var_2) && !_id_B50F(var_2) && !_id_B4EF(var_2)) {
      var_0 = 0;
      break;
    }
  }

  if(var_0) {
    scripts\aitypes\zombie_common\move::start_move_away(self.origin);
  }

  thread _id_7471();
}

_id_574E() {
  self notify("exit_last_stand");
  self _meth_8206();
  self setstance("stand");
  self.inlaststand = 0;
  self._id_6DF1 = 0;
  self._id_8F67 = undefined;
  self._id_887D = 0;
  self._id_24A1 = undefined;
  self.health = _id_6A8F();
  self._id_4EB2 = 0;
  self._id_C7E9 = undefined;
  self._id_86B3 = 0;
  self.proximityreviver = undefined;
  scripts\engine\utility::delaythread(1, scripts\cp\utility::_id_5E70);
  thread _id_9059();
  thread scripts\cp\utility::_id_7970("manual_revive", 0);
  set_revive_bar_visibility(0, self);
  _id_FCCC();
  _id_38E4(self);
  self playsoundtoplayer("zmb_laststand_exit", self);
  self setscriptablepartstate("lastStand", "inactive");
  scripts\aitypes\zombie_common\move::stop_move_away();

  if(isDefined(level._id_C7E0)) {
    self[[level._id_C7E0]]();
  }

  scripts\engine\utility::delaythread(1, ::_id_D17D);
  self._id_8F15 = undefined;
}

_id_9059() {
  self endon("disconnect");
  self._id_0E05 = 1;

  if(!istrue(level.b_force_skip_laststand_shield)) {
    wait 3;
  }

  if(scripts\cp\utility::_id_88B5()) {
    scripts\cp\utility::_id_1566(0);
  }

  self._id_0E05 = undefined;
}

_id_D17D(var_0) {
  if(!isDefined(var_0)) {
    self cameradefault();
    self setcamerathirdperson(0);
  } else
    self _meth_8697(var_0);
}

_id_4674(var_0, var_1) {
  self endon("revive_done");
  self endon("disconnect");
  wait(var_0);

  if(isDefined(var_1)) {
    _id_D17D(var_1);
  } else {
    _id_D17D("camera_custom_orbit_2_cp");
  }
}

_id_6A8F() {
  if(isDefined(level._id_6676)) {
    return [[level._id_6676]](self);
  }

  return int(self.maxhealth);
}

_id_549F() {
  if(!scripts\cp\utility::_hasperk("specialty_pistoldeath")) {
    scripts\cp\utility::_id_6FC2("specialty_pistoldeath");
  }

  _id_072C::_id_FBD9(_id_072C::_id_67C3(), "num_players_enter_laststand");
  var_0 = [];

  if(isDefined(level._id_10D0)) {
    var_0 = scripts\engine\utility::array_combine(var_0, level._id_10D0);
  }

  if(isDefined(self._id_5F02)) {
    var_0[var_0.size] = self._id_5F02;
  }

  if(isDefined(self.gauntlet_given_pistol)) {
    var_0[var_0.size] = self.gauntlet_given_pistol;
  }

  var_1 = self getcurrentweapon();

  if(scripts\cp\utility::_id_88F6(var_1)) {
    var_0[var_0.size] = var_1;
  }

  if(!istrue(self._id_2C59)) {
    if(isDefined(self._id_5A0F)) {
      switch (self._id_5A0F) {
        case 6:
        case 5:
        case 4:
        case 3:
        case 2:
        case 1:
        default:
          self takeweapon("s4_knife_eng");

          if(isDefined(self.primaryweaponobj)) {
            scripts\cp_mp\utility\inventory_utility::_giveweapon(self.primaryweaponobj, undefined, undefined, 0);

            if(isDefined(self.primaryweaponclipammo)) {
              self setweaponammoclip(self.primaryweaponobj, self.primaryweaponclipammo);
              self setweaponammostock(self.primaryweaponobj, self.primaryweaponstockammo);
            }

            self switchtoweaponimmediate(self.primaryweaponobj);
          }

          if(isDefined(self.secondaryweaponobj)) {
            scripts\cp_mp\utility\inventory_utility::_giveweapon(self.secondaryweaponobj, undefined, undefined, 1);

            if(isDefined(self._id_CFEA)) {
              self setweaponammoclip(self.secondaryweaponobj, self._id_CFEA);
              self setweaponammostock(self.secondaryweaponobj, self._id_CFEC);
            }
          }

          break;
      }
    }

    scripts\cp\utility::_id_E9BB(var_0, 1);
    self._id_90C6 = _id_54A0(var_0, 1);
    self._id_2549 = undefined;
    self._id_CB43 = self._id_8F65;
    self._id_BB4B = self getweaponslistprimaries()[0];
    self._id_BB4D = self getweaponammostock(self._id_BB4B);
    self._id_BB4C = self getweaponammoclip(self._id_BB4B);
  } else {}

  self._id_24C2 = 0;
  _id_345A();
  thread _id_AB31();
  _id_074E::_id_7DDB(self);
  _id_0705::_id_7D8F();
  _id_072E::_id_2BF8(self, 1);
  self _meth_8494();
  self _meth_8655();

  if(self _meth_8683()) {
    self _meth_8656();
  }
}

_id_345A() {
  if(!isDefined(self._id_3D58)) {
    return;
  }
  if(scripts\cp\utility::_id_8580("just_a_flesh_wound")) {
    return;
  }
  var_0 = undefined;

  if(isDefined(self._id_90C6) && !scripts\engine\utility::array_contains(self._id_3D58, self._id_90C6)) {
    self._id_3D58 = scripts\engine\utility::array_add(self._id_3D58, self._id_90C6);
  }

  foreach(var_2 in self._id_3D58) {
    if(istrue(var_2._id_0245)) {
      continue;
    }
    if(var_2 _meth_8624("doubletap", 1)) {
      var_0 = var_2 _meth_866A("doubletap");
      var_3 = getcompleteweaponname(var_0);

      if(scripts\engine\utility::array_contains(self._id_3D58, var_2)) {
        self._id_3D58 = scripts\engine\utility::array_remove(self._id_3D58, var_2);
        self._id_3D58[self._id_3D58.size] = var_0;
      }

      if(issubstr(self._id_3D62.basename, var_2.basename)) {
        self._id_3D62 = var_0;
      }

      var_4 = getarraykeys(self._id_3D5F);
      var_5 = getarraykeys(self._id_3D61);

      foreach(var_7 in var_4) {
        if(issubstr(var_7, var_2.basename)) {
          if(var_3 != var_7) {
            self._id_3D5F[var_3] = self._id_3D5F[var_7];
            self._id_3D5F[var_7] = undefined;
          }
        }
      }

      foreach(var_10 in var_5) {
        if(issubstr(var_10, var_2.basename)) {
          if(var_3 != var_10) {
            self._id_3D61[var_3] = self._id_3D61[var_10];
            self._id_3D61[var_10] = undefined;
          }
        }
      }

      if(issubstr(self._id_90C6.basename, var_2.basename)) {
        self._id_90C6 = var_0;
      }

      if(issubstr(self._id_BB4B.basename, var_2.basename)) {
        self._id_BB4B = var_0;
      }
    }
  }
}

_id_54A0(var_0, var_1) {
  var_2 = scripts\cp\utility::_id_6E34(var_0);

  if(isDefined(self._id_BB34)) {
    var_2 = self._id_BB34;
  }

  var_3 = 0;

  if(isnullweapon(var_2)) {
    var_3 = 1;
  } else if(scripts\engine\utility::array_contains(var_0, var_2)) {
    var_3 = 1;
  } else if(scripts\engine\utility::array_contains(var_0, var_2 _meth_8625())) {
    var_3 = 1;
  } else if(istrue(var_1) && scripts\cp\utility::_id_8632(var_2, 1)) {
    var_3 = 1;
  }

  if(scripts\cp\utility::_id_868A(var_2)) {
    var_3 = 0;
  }

  if(var_3) {
    var_4 = _id_3591(var_0, var_1, 1);

    if(isDefined(var_4)) {
      var_2 = var_4;
    }
  }

  return var_2;
}

_id_3591(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < self._id_3D58.size; var_3++) {
    if(isnullweapon(self._id_3D58[var_3])) {
      continue;
    } else if(scripts\engine\utility::array_contains(var_0, self._id_3D58[var_3])) {
      continue;
    } else if(scripts\engine\utility::array_contains(var_0, self._id_3D58[var_3] _meth_8625())) {
      continue;
    } else if(istrue(var_1) && scripts\cp\utility::_id_8632(self._id_3D58[var_3], var_2)) {
      continue;
    } else {
      return self._id_3D58[var_3];
    }
  }
}

_id_5748() {
  self._id_75D0 = 1;

  if(isDefined(level.revive_dmg_shield_time_override)) {
    self._id_4329 = gettime() + level.revive_dmg_shield_time_override;
  } else {
    self._id_4329 = gettime() + 3000;
  }

  var_0 = [];

  if(istrue(self.revived)) {
    scripts\cp\utility::_id_C706(var_0);
    thread _id_0728::_id_C70B();
    _id_0766::restoresuperammo();

    if(isDefined(self._id_BB4D)) {
      self setweaponammostock(self._id_BB4B, self._id_BB4D);
    }

    if(isDefined(self._id_BB4C)) {
      self setweaponammoclip(self._id_BB4B, self._id_BB4C);
    }

    self setspawnweapon(_id_671E(self, self._id_90C6), 1);
    _id_6EEA(self);
  }

  if(isDefined(self._id_AC3D) && isDefined(self._id_AC3D._id_56F2)) {}

  _id_072E::_id_2BF8(self, 0);
  self._id_2549 = undefined;
  _id_0705::_id_7D91();
  _id_071A::_id_D267(self, 0);
  _id_FCCC();
  _id_072E::_id_FCBD();
}

_id_549E(var_0) {
  if(isDefined(level._id_905A)) {
    [[level._id_905A]](self, var_0);
  }

  if(isDefined(level._id_905B)) {
    [[level._id_905B]](self);
  }
}

_id_5747() {
  if(isDefined(level._id_905C)) {
    [[level._id_905C]](self);
  }
}

_id_1084B(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("revive");
  self endon("revive_success");
  self endon("self_revive_success");
  level endon("game_ended");
  var_3 = _id_6922();

  if(!var_1) {
    thread _id_B387(var_3);

    if(scripts\cp\utility::_id_89AE() || level._id_AB30) {
      _id_ED8C(self, 1);
      _id_D26A(self, var_3);
    } else
      _id_D26A(self, var_3);
  }

  foreach(var_5 in level.players) {
    if(var_5 != self) {
      var_5 thread scripts\cp\cp_hud_message::showsplash("cp_in_laststand", undefined, self);
    }
  }

  return _id_107B0(self, self.origin, undefined, undefined, 1, (0.33, 0.75, 0.24), var_3, 0, var_1, 1, var_2);
}

_id_6922() {
  if(isDefined(level._id_6399)) {
    return [[level._id_6399]]();
  }

  var_0 = 45 + int(_id_0945::_id_664E("downed_duration_increase"));
  return var_0;
}

_id_1084C(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  self._id_24A1 = 1;
  wait 0.5;
  _id_072E::_id_FCBC();
  self notify("death");
  self notify("death_or_disconnect");
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
  waitframe();
  var_1 = _id_60E5(self);

  if(istrue(var_1)) {
    level thread[[level._id_52F7]]("axis", level._id_52A0["kia"]);
  } else {
    if(!istrue(self.hassoloselfrevive) && scripts\cp\utility::_id_8580("self_revive")) {
      _id_0981::_id_C391("self_revive");
    }

    _id_072E::_id_2BF8(self, 2);
    _id_C137(var_0);

    if(isDefined(self._id_2549)) {
      var_0 = self._id_2549;
      self._id_2549 = undefined;
    }

    if(_id_8618(var_0)) {
      var_2 = self;

      if(isDefined(var_0)) {
        var_2 = var_0;
      }

      var_3 = scripts\engine\utility::_id_5000(var_2.origin, 32, -64) + (0, 0, 5);
      var_4 = var_2.angles;
    } else {
      var_3 = self.origin;
      var_4 = self.angles;
    }

    _id_38E4(self);
    self._id_E3E5 = 1;
    self._id_24A1 = undefined;

    if(getdvarint("#x3dee089cb49164e4e", 0) != 1) {
      scripts\cp\utility::_id_3918();
      _id_0953::start_respawn();
    }

    if(isDefined(level._id_C67F) && !scripts\cp\utility::_id_871A()) {
      self._id_8F67 = "bleed_out";

      if(isDefined(level._id_1F4B)) {
        while(!istrue(level._id_1F48)) {
          wait 1;
        }

        if(!istrue(level._id_1F4A)) {
          level thread[[level._id_1F4B]]();
        }
      }

      if(self[[level._id_C67F]](self, var_3)) {
        _id_DC20(self);
        _id_072E::_id_2BF8(self, 0);
        self._id_E3E5 = undefined;
        scripts\cp\utility::_id_FD26("playing");

        if(!isDefined(self._id_5EC7) && !isDefined(self._id_5EC2)) {
          self._id_5EC7 = var_3;
          self._id_5EC2 = var_4;
        }

        if(isDefined(level._id_BBEB)) {
          [[level._id_BBEB]](self);
        }

        if(istrue(self._id_5E88)) {
          self._id_5E88 = undefined;
          [[level._id_E33A]]();
        } else
          [[level._id_E33A]]();

        self._id_DBD8 = 0;
        return;
      }

      return;
      return;
    }

    if(isDefined(level._id_54C6)) {
      level thread[[level._id_54C6]](self);
    }

    self notify("entered_spectate");

    if(!scripts\cp\utility::_id_871A()) {
      var_5 = _id_107B0(self, var_3, undefined, undefined, 0, (1, 0, 0), _id_6922(), 1, var_1, 0);
    } else {
      thread _id_54C5(self, var_3, undefined);
      self._id_8F67 = "bleed_out";
      scripts\engine\utility::_id_10888(level, "timeout_wave", self, "revive_success", self, "self_revive_success");
    }

    _id_DC20(self);
    _id_072E::_id_2BF8(self, 0);
    self._id_E3E5 = undefined;
    self._id_24A1 = undefined;
    scripts\cp\utility::_id_FD26("playing");

    if(!isDefined(self._id_5EC7) && !isDefined(self._id_5EC2)) {
      self._id_5EC7 = var_3;
      self._id_5EC2 = var_4;
    }

    if(isDefined(level._id_BBEB)) {
      [[level._id_BBEB]](self);
    }

    [[level._id_E33A]]();

    if(!istrue(level._id_1475)) {
      self._id_DBD8 = 0;
    }

    scripts\cp\utility::_id_5F63(0);
  }
}

_id_C137(var_0) {
  _id_074E::_id_5530("deaths", 1);

  if(!_id_8618(var_0)) {
    _id_072C::_id_FBD9(_id_072C::_id_67C3(), "num_players_bleed_out");
    _id_0705::_id_7D8E();
  }
}

_id_107B0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = _id_9A09(var_0, var_1, var_2, var_3, var_4);

  if(var_7) {
    thread _id_54C5(var_0, var_1, var_11);
    var_0._id_8F67 = "bleed_out";
  } else
    level notify("waiting_to_be_revived_from_laststand", var_0);

  if(var_8) {
    level waittill("forever");
    return 0;
  } else {
    var_12 = var_11;

    if(var_7) {
      var_12 = _id_9A0B(var_0, var_11);
    }

    if(var_9) {
      var_12 _id_9A0A(var_12, var_0, var_5, var_6);
    }

    var_0._id_C7E2 = var_11;
    var_0._id_C7E5 = var_12;
    var_0._id_2547 = _id_998F(var_0, var_6);
    var_0 thread _id_FB3D(var_6);

    if(var_9) {
      var_11 thread _id_9092(var_0);
    }

    if(istrue(1)) {
      var_11 thread _id_907E(var_0);
    }

    if(_id_75AE()) {
      if(isDefined(level.self_revive_override_func)) {
        [[level.self_revive_override_func]](self);
      } else {
        var_11 thread _id_9091(var_0);
      }
    }

    var_11 thread laststandwaitforproximityrevive(var_0);

    if(isDefined(var_6)) {
      var_13 = var_11 scripts\engine\utility::_id_1088B(var_6, var_11, "revive_success", var_11, "self_revive_success", var_11, "proximity_revive_success", var_0, "revive_success", var_0, "challenge_complete_revive", level, "begin_successful_objective_ended", var_0, "begin_vortex_fx", var_0, "auto_respawn");
    } else {
      var_13 = var_11 scripts\engine\utility::_id_1088C(var_11, "revive_success", var_11, "self_revive_success", var_11, "proximity_revive_success", var_0, "challenge_complete_revive", level, "begin_successful_objective_ended", var_0, "begin_vortex_fx");
    }

    if(var_13 == "timeout" && _id_8566(var_0)) {
      var_13 = var_11 scripts\engine\utility::_id_1089B("revive_success", "revive_fail", "self_revive_success", "self_revive_fail", "proximity_revive_success", "proximity_revive_fail");
    }

    if(isDefined(var_0._id_C7E2)) {
      var_0._id_C7E2 makeunusable();
    }

    if(isDefined(var_0._id_C7E5)) {
      var_0._id_C7E5 makeunusable();
    }

    if(isDefined(var_0._id_2547)) {
      var_0._id_2547 scripts\cp\utility::destroyelem();
    }

    var_0 notify("give_up_done");
    var_0._id_C7E9 = undefined;

    foreach(var_15 in level.players) {
      if(isDefined(var_15.currentlyreviving) && var_15.currentlyreviving == var_0) {
        var_15.currentlyreviving = undefined;
        var_15 setclientomnvar("ui_securing", 0);
        var_15 find_best_revive();
      }
    }

    if(var_13 == "revive_success" || var_13 == "challenge_complete_revive" || var_13 == "self_revive_success" || var_13 == "begin_successful_objective_ended" || var_13 == "proximity_revive_success" || var_13 == "begin_vortex_fx" || var_13 == "auto_respawn") {
      return 1;
    } else {
      return 0;
    }
  }
}

_id_9A69(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("revive");
  var_1 = 120;
  wait(var_1);
  var_0 notifyonplayercommand("manual_revive", "+usereload");
  var_0 thread scripts\cp\utility::_id_7970("manual_revive", 1);
  var_0 waittill("manual_revive");
  var_0 thread scripts\cp\utility::_id_7970("manual_revive", 0);

  if(isDefined(var_0._id_4CDE)) {
    var_0._id_4CDE delete();
  }

  var_0 thread _id_F02F();
  var_0 thread _id_8302(var_0);
}

_id_F02F() {
  level._id_9A57 = level._id_102C7[0].origin + (0, 0, 200);

  if(!isDefined(level._id_9A57)) {
    return;
  }
  level endon("game_ended");
  scripts\engine\utility::_id_108A7(3, "revive");
  self setorigin(level._id_9A57);
}

_id_BE70(var_0) {
  if(!var_0 isonground()) {
    var_1 = scripts\engine\utility::_id_5000(var_0.origin, 5, -1500);
    var_1 = _func_02AB(var_1);
    var_0 setorigin(var_1);
  }
}

_id_9092(var_0) {
  self endon("death");
  self endon("self_revive_success");
  self endon("proximity_revive_success");
  level endon("begin_successful_objective_ended");
  var_0 endon("begin_vortex_fx");
  var_0 endon("disconnect");
  level endon("game_ended");

  if(isDefined(level._id_C7C0)) {
    self thread[[level._id_C7C0]](var_0, self);
  }

  _id_BE70(var_0);

  if(!istrue(level.b_force_cut_enter_laststand_vo)) {
    var_0 _id_0720::_id_BEC0("downed");
  }

  for(;;) {
    self makeuseable();
    self _meth_83A2();
    self waittill("trigger", var_1);
    self makeunusable();

    if(istrue(var_0._id_887D)) {
      continue;
    }
    if(istrue(var_0._id_86B3)) {
      continue;
    }
    if(!var_1 isonground()) {
      continue;
    }
    if(var_1 _meth_81CF()) {
      continue;
    }
    if(istrue(var_1._id_8E9A)) {
      continue;
    }
    if(!isPlayer(var_1) && !istrue(var_1._id_30EB)) {
      continue;
    }
    if(istrue(var_0._id_11B4)) {
      continue;
    }
    if(istrue(var_1._id_FF04)) {
      continue;
    }
    if(istrue(var_1._id_86A2)) {
      continue;
    }
    if(!isDefined(var_1._id_C7D7)) {
      var_1._id_C7D7 = 0;
    }

    if(gettime() > var_1._id_C7D7) {
      level thread _id_0750::_id_F759(var_1, "reviving");
      var_1._id_C7D7 = gettime() + 10000;
    }

    _id_49DA(var_0);
    var_2 = var_1 _id_6706(var_0);

    if(scripts\cp\utility::_id_86C9()) {
      var_1 scripts\common\utility::_id_158D(0);
    } else {
      var_1 disableusability();
    }

    level thread _id_C7E7(self, var_1);
    var_3 = _id_6705(var_0, var_1, self.origin, int(var_2));
    _id_51DB(var_0);

    if(var_3) {
      if(scripts\cp\utility::_id_86C9()) {
        var_1 scripts\common\utility::_id_158D(1);
      } else {
        if(isDefined(var_1._id_C7CA)) {
          var_1 setorigin(var_1._id_C7CA);
          var_1._id_C7CA = undefined;
        }

        var_0._id_6DF1 = 1;
        _id_38E4(var_0);
        var_1._id_0E05 = 1;
        var_1 thread _id_C59C();
        var_1 _id_D17D();
        var_1 unlink();
        var_1 scripts\engine\utility::delaythread(1, scripts\cp\utility::_id_5E70);
      }

      level thread play_revive_dialogue(var_0, var_1);

      if(isDefined(var_1._id_105F0)) {
        if(isDefined(level._id_C7D2)) {
          level thread[[level._id_C7D2]](var_1, var_0);
        }
      } else
        level thread _id_0750::_id_F759(var_0, "revived");

      _id_C13D(var_1, var_0);
      var_1 notify("revive_teammate", var_0);
      _id_0705::_id_978A(var_0, var_1);
      var_4 = _id_0726::_id_642F(var_1);
      var_5 = 1;
      var_0._id_8F67 = undefined;

      if(isPlayer(var_1) && istrue(var_1._id_30CC)) {
        var_1 _id_0752::_id_7003("revived_teammate_zm");
        var_1._id_30CC = 0;

        if(isDefined(var_1._id_11E0)) {
          var_1 _id_0752::_id_7003("aether_shroud_revive");
        }
      }

      break;
    } else {
      var_1 notify("revive_done");
      var_0 notify("revive_done");
      _id_D389(var_0._id_C7E2, var_0._id_C7E2._id_C7C3, 1);

      if(scripts\cp\utility::_id_86C9()) {
        var_1 scripts\common\utility::_id_158D(1);
      } else {
        var_1 scripts\cp\utility::_id_5E70();
      }

      if(isDefined(var_1._id_C7D0)) {
        var_1._id_C7D0 delete();
        var_1._id_C7D0 = undefined;
      }

      if(isDefined(var_1._id_C7CA)) {
        var_1 setorigin(var_1._id_C7CA);
        var_1._id_C7CA = undefined;
      }

      var_0 thread _id_450B();
      self notify("revive_fail");
      continue;
    }
  }

  _id_38E4(var_0);
  var_1 playSound("zmb_health_regen_complete");
  self notify("revive_success");
}

play_revive_dialogue(var_0, var_1) {
  level endon("begin_successful_objective_ended");
  var_0 endon("begin_vortex_fx");
  var_0 endon("death_or_disconnect");
  level endon("game_ended");
  var_1 _id_0720::_id_BEC0("revive");

  if(var_1._id_493C) {
    var_1 waittill("dialogue_finished");
    var_0 _id_0720::_id_BEC0("revive_response");
  }
}

_id_9091(var_0) {
  self endon("death");
  self endon("revive_success");
  self endon("proximity_revive_success");
  level endon("begin_successful_objective_ended");
  var_0 endon("begin_vortex_fx");
  var_0 endon("disconnect");
  level endon("game_ended");

  if(var_0 _id_30F7()) {
    var_1 = int(_func_0222("cp/cp_hints.csv", 1, "self_revive", 0));
    var_0 setclientomnvar("zm_hint_index", var_1);
  }

  while(var_0 usebuttonpressed()) {
    waitframe();
  }

  for(;;) {
    if(var_0 _id_30F7() && var_0 usebuttonpressed() && !istrue(var_0.b_force_block_revive)) {
      var_0._id_86B3 = 1;
      var_2 = _id_6705(var_0, var_0, self.origin, var_0 _id_6706(var_0));

      if(var_2) {
        var_0._id_6DF1 = 1;
        _id_38E4(var_0);

        if(istrue(var_0.hassoloselfrevive)) {
          var_0.hasusedsoloselfrevive = 1;
          var_0.hassoloselfrevive = undefined;
        }

        var_0 _id_0981::_id_C391("self_revive");
        var_0 playSound("zmb_health_regen_complete");
        self notify("self_revive_success");
      } else {
        self notify("self_revive_fail");
        var_0._id_86B3 = 0;
      }
    } else
      var_0 thread _id_450B();

    waitframe();
  }
}

laststandwaitforproximityrevive(var_0) {
  self endon("death");
  self endon("revive_success");
  self endon("self_revive_success");
  level endon("begin_successful_objective_ended");
  var_0 endon("begin_vortex_fx");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_1 = _id_65EF();

  for(;;) {
    wait 0.1;

    if(isDefined(var_0._id_C7E9) || istrue(var_0._id_86B3)) {
      continue;
    }
    foreach(var_3 in level.players) {
      if(var_3 == var_0 || istrue(var_3.inlaststand)) {
        continue;
      }
      if(var_3 scripts\cp\utility::_hasperk("specialty_proximity_revive")) {
        var_4 = var_3 _id_0945::_id_664E("proximity_revive_distance");
        var_5 = var_4 * var_4;
        var_6 = distancesquared(var_3.origin, var_0.origin);

        if(var_6 <= var_5) {
          var_7 = var_0._id_C7CF * var_1;
          var_0 notify("reviving");
          var_0 setclientomnvar("ui_securing_progress", var_0._id_C7CF);
          var_0 setclientomnvar("ui_reviver_id", var_3 getentitynumber());
          var_0.proximityreviver = var_3;

          if(!isDefined(var_3.currentlyreviving) || isDefined(var_3.currentlyreviving.proximityreviver) && var_3.currentlyreviving._id_C7CF < var_0._id_C7CF) {
            set_revive_bar_visibility(1, var_0, var_3);
            var_3 setclientomnvar("ui_securing_progress", var_0._id_C7CF);
            var_3.currentlyreviving = var_0;
          } else
            set_revive_bar_visibility(1, var_0);

          _id_520D(var_0, var_3);

          while(var_6 <= var_5 && !isDefined(var_0._id_C7E9) && !istrue(var_3.inlaststand)) {
            if(var_7 >= var_1) {
              _id_C13D(var_3, var_0);
              var_3 notify("revive_teammate", var_0);
              _id_0705::_id_978A(var_0, var_3);
              var_0._id_8F67 = undefined;

              if(isPlayer(var_3) && istrue(var_3._id_30CC)) {
                var_3 thread _id_0752::_id_7003("reviver");
                var_3._id_30CC = 0;
              }

              _id_38E4(var_0);
              var_0.proximityreviver = undefined;

              if(isDefined(var_3.currentlyreviving) && var_3.currentlyreviving == var_0) {
                set_revive_bar_visibility(0, var_0, var_3);
                var_3.currentlyreviving = undefined;
                var_3 find_best_revive();
              } else
                set_revive_bar_visibility(0, var_0);

              _id_4A2D(var_0, var_3);
              var_3 playSound("zmb_health_regen_complete");
              self notify("proximity_revive_success");
              return;
            }

            var_0._id_C7CF = var_7 / var_1;
            var_8 = undefined;

            if(isDefined(var_3.currentlyreviving) && var_3.currentlyreviving == var_0) {
              var_8 = var_3;
            }

            _id_FBB5(var_0, var_8, var_0._id_C7CF);
            var_7 = var_7 + 50;
            waitframe();
            var_6 = distancesquared(var_3.origin, var_0.origin);
          }

          var_0.proximityreviver = undefined;

          if(isDefined(var_3.currentlyreviving) && var_3.currentlyreviving == var_0) {
            var_3 setclientomnvar("ui_securing", 0);
            var_3.currentlyreviving = undefined;
            var_3 find_best_revive();
          }

          if(!isDefined(var_0._id_C7E9)) {
            set_revive_bar_visibility(0, var_0);
            _id_4A2D(var_0, var_3);
            self notify("proximity_revive_fail");
          }

          var_0 thread _id_450B();
        }
      }
    }
  }
}

_id_450B() {
  self endon("disconnect");
  self endon("reviving");
  self endon("death");
  level endon("game_ended");

  while(self._id_C7CF > 0 && !isDefined(self._id_C7E9) && !isDefined(self.proximityreviver)) {
    wait 0.1;
    self._id_C7CF = max(self._id_C7CF - 0.1, 0);
  }
}

find_best_revive() {
  if(isDefined(self.currentlyreviving)) {
    return;
  }
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(isDefined(var_2._id_C7E9) && var_2._id_C7E9 == self) {
      self.currentlyreviving = var_2;
      break;
    }

    if(isDefined(var_2.proximityreviver) && var_2.proximityreviver == self && var_2._id_C7CF > var_0) {
      var_0 = var_2._id_C7CF;
      self.currentlyreviving = var_2;
    }
  }

  if(isDefined(self.currentlyreviving)) {
    self setclientomnvar("ui_securing_progress", self.currentlyreviving._id_C7CF);
    self setclientomnvar("ui_securing", 5);
  }
}

_id_C7E7(var_0, var_1) {
  var_0 endon("revive_fail");
  var_0 endon("revive_success");
  var_0 endon("self_revive_success");
  var_1 endon("death_or_disconnect");
  var_0 waittill("death");
  var_1 scripts\cp\utility::_id_5E70();
}

_id_C59C() {
  self endon("disconnect");
  wait 2;
  self._id_0E05 = undefined;
}

_id_49DA(var_0) {
  if(isDefined(var_0._id_56EB)) {
    if(isDefined(level._id_49DB)) {
      level thread[[level._id_49DB]](var_0);
    }
  }
}

_id_51DB(var_0) {
  if(isDefined(var_0._id_56EB)) {
    if(isDefined(level._id_51DC)) {
      level thread[[level._id_51DC]](var_0);
    }
  }
}

_id_907E(var_0) {
  self endon("death");
  level endon("game_ended");
  var_1 = 600;
  var_2 = var_1 * var_1;
  var_3 = 3000;
  var_4 = 0;
  var_5 = -3;
  var_6 = var_0.origin;

  while(var_4 < var_3) {
    if(var_4 >= var_5 + 3) {
      var_7 = _func_0262();

      foreach(var_9 in var_7) {
        if(distancesquared(var_0.origin, var_9.origin) < var_2) {
          var_10 = _func_0133(var_0.origin - var_6);

          if(var_10 > 500 && var_10 < 5000) {
            var_0 scripts\cp\utility::_id_A247(1200);
            var_5 = var_4;
          }
        }
      }
    }

    var_4 = var_4 + 2;
    wait 2;
  }
}

_id_6CF4(var_0, var_1) {
  if(istrue(var_0._id_30EB)) {
    return 2;
  }

  var_2 = var_0 _id_0945::_id_664E("revive_time_scalar");

  if(var_1 scripts\cp\utility::_id_8580("faster_revive_upgrade")) {
    var_2 = var_2 * 2;
  }

  return var_2;
}

_id_C13D(var_0, var_1) {
  if(isPlayer(var_0)) {
    var_0 _id_0741::_id_BD77("mt_reviver");
    var_0 _id_074E::_id_7DE0(var_0);
    var_0 _id_0741::_id_BD77("mt_revives");
    var_0 _id_074E::_id_5530("revives", 1);
    var_1 thread scripts\cp\cp_hud_message::showsplash("cp_revived", undefined, var_0);

    if(isDefined(level._id_C7D1)) {
      [[level._id_C7D1]](var_0);
    }
  }
}

_id_9A09(var_0, var_1, var_2, var_3, var_4) {
  var_5 = (0, 0, 20);
  var_6 = anglesToForward(var_0.angles) * 30;
  var_1 = scripts\engine\utility::_id_5000(var_1 + var_5 + var_6, 32, -64);
  var_7 = spawn("script_model", var_1);
  var_7 sethintstring(&"COOP_GAME_PLAY/REVIVE_USE");
  var_7 _meth_84D4(256);
  var_7 setuserange(84);
  var_7 setusefov(180);
  var_7 setcursorhint("HINT_NOICON");
  var_7 sethintdisplayfov(180);
  var_7 _meth_84D9("hide");
  var_7 setuseholdduration("duration_none");
  var_7.owner = var_0;
  var_7._id_84EF = 0;
  var_7._id_0481 = "revive_trigger";

  if(isDefined(var_2)) {
    var_7 setModel(var_2);
  }

  if(isDefined(var_3)) {
    var_7 _meth_82CB(var_3);
  }

  if(var_4) {
    var_7 linkto(var_0, "tag_origin", var_5, (0, 0, 0));
  }

  var_7 disableplayeruse(var_0);
  var_7 thread _id_388E(var_0);
  return var_7;
}

_id_998F(var_0, var_1) {
  var_2 = scripts\cp\utility::_id_4035(0, 20, 200, 10);
  var_2 scripts\cp\utility::_id_FC11(1, -1 / var_1);
  var_2 thread _id_3833(var_0);
  return var_2;
}

_id_3833(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_any_3("death", "disconnect", "revive");
  scripts\cp\utility::destroyelem();
}

_id_FB3D(var_0) {
  self endon("death");
  self endon("revive");
  level endon("game_ended");

  if(_id_3ED7()) {
    for(var_1 = 0; var_1 < 3; var_1++) {
      wait(var_0 / 4);

      if(isDefined(self._id_2548) && isDefined(self._id_2548[var_1])) {
        scripts\cp\zombies\perks\zm_perks::decrement_perk(self._id_2548[var_1]);
      }

      if(isDefined(self._id_2547) && isDefined(self._id_2547._id_AFD0[var_1])) {
        self._id_2547._id_AFD0[var_1] scripts\cp\utility::destroyelem();
      }
    }
  }
}

_id_3ED7() {
  if(isDefined(self._id_11086)) {
    self._id_2548 = [];
    self._id_2547._id_AFD0 = [];
    var_0 = getarraykeys(self._id_11086);
    var_1 = int(min(3, self._id_11086.size));

    for(var_2 = 0; var_2 < var_1; var_2++) {
      var_3 = _func_0222("cp/zombies/zombie_perks_bit_mask_table.csv", 1, var_0[var_2], 2);

      if(_func_0121(var_3) && var_3 != "") {
        var_4 = 3 - var_1 + var_2;
        var_5 = scripts\cp\utility::createicon(var_3, 20, 20);
        var_5 scripts\cp\utility::setparent(self._id_2547);
        var_5.alignx = "center";
        var_5.x = self._id_2547.width * (1 - var_4) / 4;
        var_5.y = self._id_2547.y + 5;
        self._id_2548[var_4] = var_0[var_2];
        self._id_2547._id_AFD0[var_4] = var_5;
      }
    }

    return 1;
  }

  return 0;
}

_id_99E9(var_0, var_1) {
  var_2 = (0, 0, 20);
  var_1 = scripts\engine\utility::_id_5000(var_1 + var_2, 32, -64);
  var_3 = spawn("script_model", var_1);
  var_3 setcursorhint("HINT_NOICON");
  var_3 sethintstring(&"COOP_GAME_PLAY/EXECUTE");
  var_3.owner = var_0;
  var_3._id_84EF = 0;
  var_3 linkto(var_0, "tag_origin", var_2, (0, 0, 0));
  var_3 thread _id_56EC(var_3);
  var_3 thread _id_388E(var_0);
  var_0._id_56EB = var_3;
  return var_3;
}

_id_56EC(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 makeuseable();
    var_0 _meth_83A2();
    var_0 waittill("trigger", var_1);
    var_0 makeunusable();
    var_2 = var_0.owner;
    var_2._id_C7E2 makeunusable();
    var_3 = _id_549D(var_2, var_1);
    var_4 = _id_56E8(var_2, var_1);
    _id_5745(var_2, var_1, var_3);

    if(var_4) {
      var_2 playerhide();
      var_2 notify("force_bleed_out");
      return;
    }
  }
}

_id_549D(var_0, var_1) {
  var_0 iprintlnbold("You are being ^1executed^7 by ^1" + var_1.name);
  var_1 _meth_8697("camera_custom_orbit_2");
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("tag_origin");
  var_2.angles = var_1 getplayerangles();
  var_0 playerlinktodelta(var_2, "tag_origin", 0.5, 60, 60);
  return var_2;
}

_id_5745(var_0, var_1, var_2) {
  if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 unlink();
  }

  if(isPlayer(var_1)) {
    var_1 cameradefault();
  }

  var_2 delete();
}

_id_56E8(var_0, var_1) {
  var_0 setclientomnvar("ui_securing", 1);
  var_1 setclientomnvar("ui_securing", 1);
  var_0 setclientomnvar("ui_securing_progress", 0);
  var_1 setclientomnvar("ui_securing_progress", 0);
  var_2 = 0;
  var_3 = 0;

  while(_id_DAA1(var_1)) {
    if(var_2 >= 2.5) {
      var_3 = 1;
      break;
    }

    var_4 = var_2 / 2.5;
    var_0 setclientomnvar("ui_securing_progress", var_4);
    var_1 setclientomnvar("ui_securing_progress", var_4);
    var_2 = var_2 + 0.05;
    waitframe();
  }

  if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 setclientomnvar("ui_securing", 0);
  }

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_securing", 0);
  }

  return var_3;
}

_id_9A0B(var_0, var_1) {
  var_2 = (0, 0, 30);
  var_3 = spawn("script_model", var_1.origin + var_2);
  var_3 thread _id_388E(var_0);
  return var_3;
}

_id_9CC5(var_0, var_1) {
  if(scripts\cp\utility::_id_89AE() || level._id_AB30) {
    return _id_E017(var_0, var_1);
  } else {
    return _id_3D1A(var_1);
  }
}

_id_E017(var_0, var_1) {
  if(var_0 && _id_8618(var_1)) {
    return 0;
  }

  return 1;
}

_id_3D1A(var_0) {
  if(_id_8618(var_0)) {
    return 0;
  }

  return 1;
}

_id_AB31() {
  if(istrue(self._id_87A7)) {
    wait 0.5;
  }

  var_0 = [makeweapon("iw8_knife_mp"), makeweapon("super_default_zm")];

  if(isDefined(self._id_5E85)) {
    _id_0D94(var_0);
    self giveweapon(self._id_5E85);
    self switchtoweaponimmediate(self._id_5E85);
    return;
  }

  var_1 = _id_6544();

  if(self hasweapon(var_1)) {
    self takeweapon(var_1);
  }

  if(weaponclass(var_1) != "pistol" || var_1.basename == "s4_me_rindigo_mp" || issubstr(var_1.basename, "iw8_knife_mp")) {
    var_1 = scripts\cp\cp_weapon::buildweapon("s4_pi_mike1911_mp", [], "none", "none", -1);
  }

  if(var_1 _meth_8624("akimbo", 1)) {
    var_2 = var_1._id_030D;
    var_3 = undefined;

    foreach(var_5 in var_2) {
      if(issubstr(var_5, "akimbo")) {
        var_3 = var_5;
        break;
      }
    }

    if(isDefined(var_3)) {
      var_1 = var_1 _meth_866A(var_3);
    }
  }

  self giveweapon(var_1);
  var_7 = _id_310A(self);

  if(var_7) {
    var_0[var_0.size] = var_1;
  }

  var_8 = self getcurrentweapon();

  if(scripts\cp\utility::_id_88F6(var_8)) {
    self notify("non_temp_weapon_switch");
    var_0[var_0.size] = var_8;
  }

  _id_0D94(var_0);
  var_9 = _id_6604();

  if(var_7) {
    var_10 = self _meth_8109(var_1);
    var_11 = weaponclipsize(var_1);
    self setweaponammostock(var_1, var_11 * var_9);
    self setweaponammoclip(var_1, var_11);
    self switchtoweaponimmediate(var_1);
  }
}

_id_6604() {
  return 2;
}

_id_6544() {
  if(isDefined(self._id_8F65)) {
    return self._id_8F65;
  }

  var_0 = self._id_458F;
  var_1 = self getweaponslistprimaries()[0];

  if(scripts\cp\utility::_id_6902(var_0) == scripts\cp\utility::_id_6902(var_1)) {
    return var_1;
  } else {
    return var_0;
  }
}

_id_310A(var_0) {
  if(isDefined(level._id_310B)) {
    return [[level._id_310B]](var_0);
  } else {
    return 1;
  }
}

_id_388E(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_any_3("death", "disconnect", "revive");
  self delete();
}

_id_C3D3(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  var_1._id_C7C8 = scripts\engine\utility::array_remove(var_1._id_C7C8, var_0);
}

_id_4582() {
  _id_8096(self);
}

_id_6F01(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = var_0 _id_6542() + var_1;
  _id_D269(var_0, var_2);
}

_id_ED8C(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = var_0 _id_6542() - var_1;
  _id_D269(var_0, max(var_2, 0));
}

_id_60E5(var_0) {
  if((scripts\cp\utility::_id_89AE() || level._id_AB30) && (var_0 scripts\cp\utility::_id_74D8() || _id_A6D5())) {
    return 0;
  }

  if(scripts\engine\utility::is_equal(level._id_5707, 1)) {
    return 0;
  }

  if(scripts\cp\utility::_id_89AE() || level._id_AB30) {
    return _id_E015(var_0);
  } else {
    return _id_3D15(var_0);
  }
}

_id_E015(var_0) {
  if(_id_B4EF(var_0)) {
    return 0;
  }

  return !var_0 _id_30F7();
}

_id_3D15(var_0) {
  if(isDefined(level._id_3D16)) {
    return [[level._id_3D16]](var_0);
  }

  if(var_0 _id_30F7()) {
    return 0;
  }

  return _id_56CD(var_0);
}

_id_56CD(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }
    if(_id_B50F(var_2)) {
      continue;
    }
    if(istrue(var_2._id_E3E5) && istrue(var_2.on_initializing)) {
      continue;
    }
    if(_id_B51E(var_2)) {
      return 0;
    }

    if(!_id_B4EF(var_2)) {
      return 0;
    }

    if(istrue(var_2._id_6DF1)) {
      return 0;
    }

    if(var_2 _id_30F7(1)) {
      return 0;
    }
  }

  return 1;
}

_id_6705(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\utility::_id_406D(var_2);
  var_4 thread _id_388E(var_0);
  var_5 = _id_C7D4(var_0, var_1, var_4, var_3);
  return var_5;
}

_id_B387(var_0) {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");

  if(!isDefined(var_0)) {
    return;
  }
  scripts\cp\utility::_id_B386();
  wait(var_0 / 3);
  scripts\cp\utility::_id_B386();
  wait(var_0 / 3);
  level thread _id_0750::_id_F759(self, "player_last_stand");
  scripts\cp\utility::_id_B386();
}

_id_54C5(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  level endon("game_ended");

  if(isDefined(var_0._id_32E7)) {
    var_0._id_32E7 destroy();
  }

  var_0._id_74DC = 0;

  if(istrue(level._id_520B)) {
    var_2 thread _id_9A69(var_0);
  }

  var_0 _id_5490(var_0);
  var_0 _id_B8DB();
}

_id_3080(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_2 endon("revive_success");
    var_2 endon("self_revive_success");
  }

  var_3 = (0, 0, 30);
  var_4 = (0, 0, 100);
  var_5 = (0, 0, 400);
  var_6 = 2.0;
  var_7 = 0.6;
  var_8 = 0.6;
  var_9 = var_1 + var_3;
  var_10 = scripts\engine\trace::_bullet_trace(var_9, var_9 + var_4, 0, var_0);
  var_11 = var_10["position"];
  var_10 = scripts\engine\trace::_bullet_trace(var_11, var_11 + var_5, 0, var_0);
  var_12 = var_10["position"];
  var_13 = spawn("script_model", var_11);
  var_13 setModel("tag_origin");
  var_13.angles = vectortoangles((0, 0, -1));
  var_13 thread _id_388E(var_0);
  var_0 cameralinkto(var_13, "tag_origin");
  var_13 moveto(var_12, var_6, var_7, var_8);
  var_13 waittill("movedone");
  var_13 delete();
  var_0 _id_5490(var_0);
}

_id_5490(var_0) {
  if(isDefined(level._id_B3C5)) {
    var_0[[level._id_B3C5]](var_0);
  } else if(isDefined(level._id_54E2)) {
    var_0[[level._id_54E2]]();
  }
}

_id_5491() {
  self playerhide();
  self freezecontrols(1);
}

_id_5739() {
  self _meth_8060();
  self freezecontrols(0);
}

_id_B8DB() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  var_0._id_01D6 = 1;
  var_0 setshader("white", 640, 480);
  var_0 fadeovertime(0.05);
  var_0.alpha = 1;
  wait 0.05;
  var_0 destroy();
}

_id_C7D4(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1._id_105F0)) {
    if(isDefined(level._id_C7D5)) {
      level thread[[level._id_C7D5]](var_1, var_0);
    }
  }

  var_1 setclientomnvar("ui_securing_progress", 0);
  var_0 setclientomnvar("ui_securing_progress", 0);
  _id_54BF(var_0, var_1, var_2, var_3);
  _id_D389(var_0._id_C7E2, (0.0117, 0.9882, 0.9882), 1);
  _id_B2B0(var_1, var_0);
  var_1._id_FF65 = var_1 scripts\cp\utility::_id_6E34();
  thread _id_1070C(var_0, var_1, var_2, var_1._id_FF65);
  var_0._id_C7E9 = var_1;
  var_4 = var_0._id_C7CF * var_3;
  var_5 = 0;
  _id_520D(var_0, var_1);

  if(isPlayer(var_1)) {
    var_0 notify("reviving");
  }

  while(_id_DAC7(var_1)) {
    if(var_4 >= var_3) {
      var_5 = 1;
      break;
    }

    var_0._id_C7CF = var_4 / var_3;
    _id_FBB5(var_0, var_1, var_0._id_C7CF);
    var_4 = var_4 + 50;
    waitframe();
  }

  _id_4A2D(var_0, var_1);

  if(istrue(var_5)) {
    var_2 notify("use_hold_think_success");
  } else {
    var_2 notify("use_hold_think_fail");
    var_0._id_C7E9 = undefined;
  }

  var_2 waittill("exit_use_hold_think_complete");
  return var_5;
}

_id_B2B0(var_0, var_1) {
  if(isDefined(level._id_A6DF)) {
    if(level._id_A6DF == var_0) {
      return;
    }
  }

  var_0 allowmelee(0);
  var_0 disableweaponswitch();
  var_0 notify("offhand_end");
}

_id_E8D7(var_0, var_1) {
  if(isDefined(level._id_A6DF)) {
    if(level._id_A6DF == var_0) {
      return;
    }
  }

  var_0 enableweaponswitch();
  var_0 allowmelee(1);
}

_id_6703(var_0) {
  return "ges_revive_ally";
}

_id_FBB5(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(var_4 == var_0 || isDefined(var_1) && var_4 == var_1) {
      var_4 setclientomnvar("ui_securing_progress", var_2);
      continue;
    }

    if(isDefined(var_0._id_C7CE)) {
      var_4 setclientomnvar("zm_revive_bar_" + var_0._id_C7CE + "_progress", var_2);
    }
  }
}

set_revive_bar_visibility(var_0, var_1, var_2) {
  if(var_0) {
    var_1 setclientomnvar("ui_securing", 6);

    if(isDefined(var_2)) {
      var_2 setclientomnvar("ui_securing", 5);
    }

    if(!istrue(var_1.playing_revive_loop)) {
      var_1 playLoopSound("zmb_health_regen_bar_lp");
      var_1.playing_revive_loop = 1;

      if(isDefined(var_2)) {
        var_2 playSound("zmb_health_regen_start");
      }
    }
  } else {
    var_1 setclientomnvar("ui_securing", 0);

    if(isDefined(var_2)) {
      var_2 setclientomnvar("ui_securing", 0);
    }

    if(istrue(var_1.playing_revive_loop)) {
      var_1 stoploopsound("zmb_health_regen_bar_lp");
      var_1.playing_revive_loop = 0;
    }
  }
}

_id_54BF(var_0, var_1, var_2, var_3) {
  var_1 setclientomnvar("ui_securing_progress", var_0._id_C7CF);
  var_0 setclientomnvar("ui_securing_progress", var_0._id_C7CF);
  var_0 setclientomnvar("ui_reviver_id", var_1 getentitynumber());
  set_revive_bar_visibility(1, var_0, var_1);

  if(!scripts\cp\utility::_id_86C9()) {
    var_1 scripts\common\utility::_id_1561(0);
    var_1 scripts\common\utility::_id_1559(0);
    var_0 scripts\common\utility::_id_1559(0);
  }

  _id_96E8(var_1);
  var_0._id_24C2 = 1;

  if(isPlayer(var_1)) {
    var_1 _id_0753::_id_BA9F();
  }

  var_1._id_8A07 = 1;
  var_1.currentlyreviving = var_0;
}

_id_85C8(var_0) {
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = (var_2[0], var_2[1], 0);
  var_4 = vectornormalize(var_3);
  var_5 = var_0.origin - self.origin;
  var_6 = (var_5[0], var_5[1], 0);
  var_7 = vectornormalize(var_6);
  var_8 = vectordot(var_4, var_7);
  return var_8 > cos(30);
}

_id_310C(var_0, var_1) {
  return _id_85C8(var_1) && _func_0202(self.origin, var_1.origin, 1, self, var_0);
}

_id_FBBD(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("revive");
  var_0 endon("death");
  var_1 endon("death");
  level endon("game_ended");

  for(;;) {
    wait 0.1;

    foreach(var_3 in level.players) {
      if(var_3 == var_0) {
        continue;
      }
      if(var_3 _id_310C(var_0, var_1) && !_id_B4EF(var_3)) {
        var_1 _meth_80E0(var_3);
        continue;
      }

      var_1 disableplayeruse(var_3);
    }
  }
}

_id_96E8(var_0) {
  var_1 = var_0 getstance();

  switch (var_1) {
    case "stand":
      var_0 allowstand(1);
      var_0 allowcrouch(0);
      var_0 allowprone(0);
      return;
    case "crouch":
      var_0 allowstand(0);
      var_0 allowcrouch(1);
      var_0 allowprone(0);
      return;
    case "prone":
      var_0 allowprone(1);
      var_0 allowstand(0);
      var_0 allowcrouch(0);
      return;
  }
}

_id_1070C(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::_id_1088C(var_2, "use_hold_think_success", var_2, "use_hold_think_fail", var_0, "disconnect", var_0, "revive", var_0, "force_bleed_out", var_1, "challenge_complete", var_0, "death");

  if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 unlink();
    var_0 scripts\engine\utility::delaythread(1, ::_id_D17D);

    if(!scripts\cp\utility::_id_86C9()) {
      if(var_4 == "use_hold_think_success") {
        _id_38E4(var_0);
      }
    }

    var_0 setclientomnvar("ui_reviver_id", -1);
    var_0 setclientomnvar("ui_securing_progress", 0);
    set_revive_bar_visibility(0, var_0);
    var_0 thread _id_C5A9();

    if(!scripts\cp\utility::_id_86C9()) {
      var_0 scripts\common\utility::_id_1559(1);
    }
  }

  var_1._id_8A07 = 0;
  var_1.currentlyreviving = undefined;

  if(isPlayer(var_1)) {
    if(!scripts\cp\utility::_id_86C9()) {
      var_1 scripts\common\utility::_id_1561(1);
      var_1 scripts\common\utility::_id_1559(1);
    }

    var_1 _id_E8D7(var_1, var_1._id_FF65);
    var_1 unlink();
    var_1 _id_D17D();
    var_1 setclientomnvar("ui_securing", 0);
    var_1 setclientomnvar("ui_securing_progress", 0);
    var_1 setclientomnvar("ui_reviver_id", -1);
    var_1 allowstand(1);
    var_1 allowcrouch(1);
    var_1 allowprone(1);
    var_1._id_182F = undefined;
    var_1 _id_0753::_id_BAA4();
    var_1 unlink();
    var_1 notify("stop_revive");
  }

  var_1 find_best_revive();
  var_2 notify("exit_use_hold_think_complete");
}

_id_C5A9() {
  self endon("disconnect");
  self._id_24C2 = 0;
}

_id_B2AC(var_0) {
  var_0 endon("disconnect");
  var_0 endon("stop_playing_revive_anim");
  var_0 _meth_84FE("power_active_cp", "gesture015");
}

_id_DAC7(var_0) {
  if(istrue(var_0.b_force_block_revive)) {
    return 0;
  }

  if(istrue(var_0._id_30EB)) {
    return 1;
  }

  return !level.gameended && var_0 scripts\cp_mp\utility\player_utility::_isalive() && var_0 usebuttonpressed() && (var_0 == self.owner || !_id_B4EF(var_0) && var_0 _id_310C(self.owner, self));
}

_id_DAA1(var_0) {
  return !level.gameended && var_0 scripts\cp_mp\utility\player_utility::_isalive() && var_0 usebuttonpressed() && !_id_B4EF(var_0);
}

_id_0D94(var_0) {
  var_1 = self getweaponslistall();

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::array_contains(var_0, var_3) || issubstr(var_3.basename, "_watch_")) {
      continue;
    } else {
      self takeweapon(var_3);
    }
  }
}

_id_8618(var_0) {
  return isDefined(var_0) || istrue(self._id_ABE3) || istrue(self._id_DBD8);
}

_id_D269(var_0, var_1) {
  var_1 = int(var_1);
  var_0 setplayerdata("cp", "alienSession", "last_stand_count", var_1);
}

_id_D26A(var_0, var_1) {
  if(isDefined(var_1)) {
    var_0 setclientomnvar("zm_ui_laststand_end_milliseconds", gettime() + var_1 * 1000);
  }
}

_id_38E4(var_0) {
  if(isDefined(var_0)) {
    var_0 setclientomnvar("zm_ui_laststand_end_milliseconds", 0);
    var_0 setclientomnvar("zm_hint_index", 0);
    var_0 setclientomnvar("zm_hint_progress", 0);
  }
}

_id_8302(var_0) {
  if(_id_8566(var_0)) {
    return;
  }
  if(!isDefined(var_0) || !isent(var_0)) {
    return;
  }
  var_0._id_8303 = 1;
  var_0 notify("revive_success");

  if(isDefined(var_0._id_C7E2)) {
    var_0._id_C7E2 notify("revive_success");
  }

  if(_id_8566(var_0)) {
    _id_4A2D(var_0, var_0._id_C7E9);
  }

  _id_38E4(var_0);
}

_id_D38A(var_0, var_1) {
  if(isDefined(var_0)) {
    level._id_A5C1 = var_0;
  }

  if(isDefined(var_1)) {
    level._id_E3E8 = var_1;
  }
}

_id_65EF() {
  if(isDefined(level._id_A5C1)) {
    return level._id_A5C1;
  } else {
    return 3000;
  }
}

_id_6775() {
  if(isDefined(level._id_E3E8)) {
    return level._id_E3E8;
  } else {
    return 6000;
  }
}

_id_6706(var_0) {
  if(self != var_0) {
    return _id_65EF() * _id_6CF4(self, var_0);
  }

  return _id_65EF();
}

_id_FCCC() {
  self[[level._id_A201]]();
}

_id_6422(var_0) {
  if(isDefined(level._id_9058)) {
    return [[level._id_9058]](var_0);
  }

  return 500;
}

_id_9A0A(var_0, var_1, var_2, var_3) {
  _id_D816(var_0);
  var_0._id_4196 = var_2;
  var_0._id_C7C3 = var_2;
  var_0 thread _id_C7E6(var_0);
  var_4 = undefined;

  foreach(var_6 in level.players) {
    if(var_6 == var_1) {
      continue;
    }
    if(isDefined(level._id_DAD1) && ![[level._id_DAD1]](var_6, var_1)) {
      continue;
    }
    var_4 = _id_DC67(var_0, var_6);
    _id_1053(var_0, var_4);
  }

  if(isDefined(var_3)) {
    var_0 thread _id_C7C4(var_3, var_1);
  }

  return var_4;
}

_id_DC67(var_0, var_1) {
  var_2 = newclienthudelem(var_1);
  var_2 setshader("waypoint_cp_revive", 8, 8);
  var_2 _meth_83B2(1, 1);
  var_2 _meth_83B3();
  var_2 _meth_8388(var_0);
  var_2.alpha = _id_6704(var_1);
  var_2.color = var_0._id_4196;
  _id_104C(var_1, var_2);
  var_2 thread _id_C7E4(var_0, var_1);
  return var_2;
}

_id_C7E6(var_0) {
  var_0 waittill("death");
  _id_C3D8(var_0);
}

_id_C7E4(var_0, var_1) {
  scripts\engine\utility::_id_1088C(var_0, "death", var_1, "disconnect");
  _id_C3D3(self, var_1);

  if(isDefined(self)) {
    self destroy();
  }
}

_id_C7C4(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  wait(var_0 / 3);
  _id_D389(self, (1, 0.941, 0));
  self._id_C7C3 = (1, 0.941, 0);
  wait(var_0 / 3);
  _id_D389(self, (0.929, 0.231, 0.141));
  self._id_C7C3 = (0.929, 0.231, 0.141);
}

_id_D389(var_0, var_1, var_2) {
  if(istrue(var_0.owner._id_86B3)) {
    var_1 = (0.0117, 0.9882, 0.9882);
    var_2 = 1;
  }

  var_0._id_4196 = var_1;
  var_0._id_C7C8 = scripts\engine\utility::_id_1BD1(var_0._id_C7C8);

  if(istrue(var_2) || isDefined(var_0.owner._id_C7E9) && !istrue(var_0.owner._id_C7E9._id_8A07) || !isDefined(var_0.owner._id_C7E9)) {
    foreach(var_4 in var_0._id_C7C8) {
      var_4.color = var_1;
    }
  }
}

_id_7FCE() {
  level._id_C7C5 = [];
  level._id_B76D = [];
  level thread _id_C7C7();
  level._id_C7C0 = ::_id_FBBD;
  _id_7FCF();
}

_id_1054(var_0) {
  level._id_C7C5[level._id_C7C5.size] = var_0;
}

_id_C3D8(var_0) {
  level._id_C7C5 = scripts\engine\utility::array_remove(level._id_C7C5, var_0);
  level._id_C7C5 = scripts\engine\utility::_id_1BD1(level._id_C7C5);
}

_id_C7C7() {
  level endon("game_ended");

  if(istrue(level._id_4A44)) {
    return;
  }
  for(;;) {
    level waittill("connected", var_0);

    foreach(var_2 in level._id_C7C5) {
      _id_DC67(var_2, var_0);
    }

    foreach(var_5 in level._id_B76D) {
      if(isDefined(var_5)) {
        var_0 setclientomnvar("zm_revive_bar_" + var_5._id_C7CE + "_target", var_5);
      }
    }
  }
}

_id_D816(var_0) {
  var_0._id_C7C8 = [];
  _id_1054(var_0);
}

_id_1053(var_0, var_1) {
  var_0._id_C7C8[var_0._id_C7C8.size] = var_1;
}

_id_8096(var_0) {
  var_0._id_C7C8 = [];
}

_id_104C(var_0, var_1) {
  var_0._id_C7C8[var_0._id_C7C8.size] = var_1;
}

_id_C3D4(var_0, var_1) {
  var_0._id_C7C8 = scripts\engine\utility::array_remove(var_0._id_C7C8, var_1);
}

_id_6704(var_0) {
  if(isDefined(var_0._id_8F67) && var_0._id_8F67 == "bleed_out") {
    return 0;
  } else {
    return 1;
  }
}

_id_DC20(var_0) {
  foreach(var_2 in var_0._id_C7C8) {
    var_2.alpha = 1;
  }
}

_id_788C(var_0) {
  foreach(var_2 in var_0._id_C7C8) {
    var_2.alpha = 0;
  }
}

_id_520D(var_0, var_1) {
  var_2 = _id_104E(var_0);
  var_3 = "zm_revive_bar_" + var_2 + "_target";

  foreach(var_5 in level.players) {
    if(var_5 == var_0 || var_5 == var_1) {
      continue;
    }
    var_5 setclientomnvar(var_3, var_0);
  }
}

_id_4A2D(var_0, var_1) {
  if(!isDefined(var_0._id_C7CE)) {
    return;
  }
  var_2 = "zm_revive_bar_" + var_0._id_C7CE + "_target";
  _id_C3D6(var_0);

  foreach(var_4 in level.players) {
    if(var_4 == var_0 || var_4 == var_1) {
      continue;
    }
    var_4 setclientomnvar(var_2, undefined);
  }
}

_id_104E(var_0) {
  if(isDefined(var_0._id_C7CE)) {
    return var_0._id_C7CE;
  }

  for(var_1 = 0; var_1 < 4; var_1++) {
    if(!isDefined(level._id_B76D[var_1])) {
      level._id_B76D[var_1] = var_0;
      var_2 = var_1 + 1;
      var_0._id_C7CE = var_2;
      return var_2;
    }
  }
}

_id_C3D6(var_0) {
  for(var_1 = 0; var_1 < 4; var_1++) {
    if(isDefined(level._id_B76D[var_1]) && level._id_B76D[var_1] == var_0) {
      level._id_B76D[var_1] = undefined;
      var_0._id_C7CE = undefined;
      return;
    }
  }
}

_id_DB67(var_0) {
  if(getdvarint("#x3d610ba52c29ec6f9", 0) != 0) {
    return 1;
  }

  if(_id_44B8()) {
    return 1;
  }

  if(isDefined(level._id_DB68)) {
    return [[level._id_DB68]](var_0);
  }

  if(istrue(var_0._id_5E83)) {
    return 1;
  }

  return 0;
}

_id_44B8() {
  return 0;
}

_id_75AE() {
  return scripts\cp\gametypes\zombie::_id_751A();
}

_id_6542() {
  return self getplayerdata("cp", "alienSession", "last_stand_count");
}

_id_8566(var_0) {
  return istrue(var_0._id_24C2) || isDefined(var_0.proximityreviver);
}

_id_B51E(var_0) {
  return istrue(var_0._id_86B3);
}

_id_B4EF(var_0) {
  return var_0.inlaststand;
}

_id_B50F(var_0) {
  return istrue(var_0._id_59E0);
}

_id_521F(var_0) {
  if(!isDefined(var_0._id_D07D)) {
    var_0._id_D07D = 0;
  }

  var_0._id_D07D++;
}

_id_4A48(var_0) {
  var_0._id_D07D--;
}

_id_D07D(var_0) {
  _id_BE70(var_0);
  var_1 = 3;

  if(isDefined(level._id_D07F)) {
    var_1 = level._id_D07F;
  }

  if(isDefined(var_0._id_D07F)) {
    var_1 = var_0._id_D07F;
  }

  var_0 scripts\engine\utility::_id_108A7(var_1, "revive_success");
  return 1;
}

_id_30F7(var_0) {
  var_1 = scripts\engine\utility::ter_op(istrue(var_0), 0, isDefined(self._id_C7E9));
  return !var_1 && _id_75AE() && !istrue(self._id_E3E5) && !istrue(self._id_24A1);
}

_id_6EEA(var_0) {
  if(_id_7506(var_0)) {
    self giveweapon("s4_knife_eng");
    self switchtoweaponimmediate("s4_knife_eng");
    self setspawnweapon("s4_knife_eng", 1);
  }
}

_id_7506(var_0) {
  var_1 = var_0 getweaponslistall();

  foreach(var_3 in var_1) {
    var_4 = var_3.basename;

    if(var_4 == "none") {
      continue;
    }
    if(var_4 == "super_default_zm") {
      continue;
    }
    if(var_4 == "s4_knife_eng") {
      continue;
    }
    return 0;
  }

  return 1;
}

_id_A6D5() {
  return istrue(level._id_F0EF);
}

_id_671D(var_0) {
  var_1 = scripts\cp\utility::_id_6673();

  if(!isDefined(var_0)) {
    var_0 = "steady_rumble";
  }

  var_2 = spawn("script_origin", var_1 getEye());
  var_2._id_023B = 1;
  var_2 thread _id_FBBF(var_1, var_0);
  return var_2;
}

_id_D38E(var_0) {
  self._id_023B = var_0;
}

_id_C99C(var_0) {
  thread _id_C99D(1, var_0);
}

_id_C99B(var_0) {
  thread _id_C99D(0, var_0);
}

_id_C99D(var_0, var_1) {
  self notify("new_ramp");
  self endon("new_ramp");
  self endon("death");
  var_2 = var_1 * 20;
  var_3 = var_0 - self._id_023B;
  var_4 = var_3 / var_2;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self._id_023B = self._id_023B + var_4;
    wait 0.05;
  }

  self._id_023B = var_0;
}

_id_FBBF(var_0, var_1) {
  self endon("death");
  self endon("give_up_done");
  var_2 = 0;

  for(;;) {
    if(self._id_023B > 0.0001 && gettime() > 300) {
      if(!var_2) {
        self _meth_8278(var_1);
        var_2 = 1;
      }
    } else if(var_2) {
      self _meth_83F4(var_1);
      var_2 = 0;
    }

    var_3 = 1 - self._id_023B;
    var_3 = var_3 * 1000;
    self.origin = var_0 getEye() + (0, 0, var_3);
    wait 0.05;
  }
}

#using_animtree("script_model");

_id_7FCF() {
  if(istrue(level._id_98D4)) {
    return;
  }
  level._id_98D4 = 1;
  level._id_CC34["ls_revive_helper"] = #animtree;
  level._id_CC34["ls_revive_wounded"] = #animtree;
  level._id_CC31["ls_revive_helper"]["in_stand_1"] = % sdr_mp_laststand_stand_revive_in_helper_1;
  level._id_CC32["ls_revive_helper"]["in_stand_1"] = "sdr_mp_laststand_stand_revive_in_helper_1";
  level._id_CC3B["ls_revive_helper"]["in_stand_1"] = "ls_stand_h_in_1";
  level._id_CC31["ls_revive_helper"]["in_stand_2"] = % sdr_mp_laststand_stand_revive_in_helper_2;
  level._id_CC32["ls_revive_helper"]["in_stand_2"] = "sdr_mp_laststand_stand_revive_in_helper_2";
  level._id_CC3B["ls_revive_helper"]["in_stand_2"] = "ls_stand_h_in_2";
  level._id_CC31["ls_revive_helper"]["in_stand_3"] = % sdr_mp_laststand_stand_revive_in_helper_3;
  level._id_CC32["ls_revive_helper"]["in_stand_3"] = "sdr_mp_laststand_stand_revive_in_helper_3";
  level._id_CC3B["ls_revive_helper"]["in_stand_3"] = "ls_stand_h_in_3";
  level._id_CC31["ls_revive_helper"]["in_stand_4"] = % sdr_mp_laststand_stand_revive_in_helper_4;
  level._id_CC32["ls_revive_helper"]["in_stand_4"] = "sdr_mp_laststand_stand_revive_in_helper_4";
  level._id_CC3B["ls_revive_helper"]["in_stand_4"] = "ls_stand_h_in_4";
  level._id_CC31["ls_revive_helper"]["in_stand_6"] = % sdr_mp_laststand_stand_revive_in_helper_6;
  level._id_CC32["ls_revive_helper"]["in_stand_6"] = "sdr_mp_laststand_stand_revive_in_helper_6";
  level._id_CC3B["ls_revive_helper"]["in_stand_6"] = "ls_stand_h_in_6";
  level._id_CC31["ls_revive_helper"]["in_stand_7"] = % sdr_mp_laststand_stand_revive_in_helper_7;
  level._id_CC32["ls_revive_helper"]["in_stand_7"] = "sdr_mp_laststand_stand_revive_in_helper_7";
  level._id_CC3B["ls_revive_helper"]["in_stand_7"] = "ls_stand_h_in_7";
  level._id_CC31["ls_revive_helper"]["in_stand_8"] = % sdr_mp_laststand_stand_revive_in_helper_8;
  level._id_CC32["ls_revive_helper"]["in_stand_8"] = "sdr_mp_laststand_stand_revive_in_helper_8";
  level._id_CC3B["ls_revive_helper"]["in_stand_8"] = "ls_stand_h_in_8";
  level._id_CC31["ls_revive_helper"]["in_stand_9"] = % sdr_mp_laststand_stand_revive_in_helper_9;
  level._id_CC32["ls_revive_helper"]["in_stand_9"] = "sdr_mp_laststand_stand_revive_in_helper_9";
  level._id_CC3B["ls_revive_helper"]["in_stand_9"] = "ls_stand_h_in_9";
  level._id_CC31["ls_revive_helper"]["idle_stand_1"] = % sdr_mp_laststand_stand_revive_loop_helper_1;
  level._id_CC32["ls_revive_helper"]["idle_stand_1"] = "sdr_mp_laststand_stand_revive_loop_helper_1";
  level._id_CC3B["ls_revive_helper"]["idle_stand_1"] = "ls_stand_h_lp_1";
  level._id_CC31["ls_revive_helper"]["idle_stand_2"] = % sdr_mp_laststand_stand_revive_loop_helper_2;
  level._id_CC32["ls_revive_helper"]["idle_stand_2"] = "sdr_mp_laststand_stand_revive_loop_helper_2";
  level._id_CC3B["ls_revive_helper"]["idle_stand_2"] = "ls_stand_h_lp_2";
  level._id_CC31["ls_revive_helper"]["idle_stand_3"] = % sdr_mp_laststand_stand_revive_loop_helper_3;
  level._id_CC32["ls_revive_helper"]["idle_stand_3"] = "sdr_mp_laststand_stand_revive_loop_helper_3";
  level._id_CC3B["ls_revive_helper"]["idle_stand_3"] = "ls_stand_h_lp_3";
  level._id_CC31["ls_revive_helper"]["idle_stand_4"] = % sdr_mp_laststand_stand_revive_loop_helper_4;
  level._id_CC32["ls_revive_helper"]["idle_stand_4"] = "sdr_mp_laststand_stand_revive_loop_helper_4";
  level._id_CC3B["ls_revive_helper"]["idle_stand_4"] = "ls_stand_h_lp_4";
  level._id_CC31["ls_revive_helper"]["idle_stand_6"] = % sdr_mp_laststand_stand_revive_loop_helper_6;
  level._id_CC32["ls_revive_helper"]["idle_stand_6"] = "sdr_mp_laststand_stand_revive_loop_helper_6";
  level._id_CC3B["ls_revive_helper"]["idle_stand_6"] = "ls_stand_h_lp_6";
  level._id_CC31["ls_revive_helper"]["idle_stand_7"] = % sdr_mp_laststand_stand_revive_loop_helper_7;
  level._id_CC32["ls_revive_helper"]["idle_stand_7"] = "sdr_mp_laststand_stand_revive_loop_helper_7";
  level._id_CC3B["ls_revive_helper"]["idle_stand_7"] = "ls_stand_h_lp_7";
  level._id_CC31["ls_revive_helper"]["idle_stand_8"] = % sdr_mp_laststand_stand_revive_loop_helper_8;
  level._id_CC32["ls_revive_helper"]["idle_stand_8"] = "sdr_mp_laststand_stand_revive_loop_helper_8";
  level._id_CC3B["ls_revive_helper"]["idle_stand_8"] = "ls_stand_h_lp_8";
  level._id_CC31["ls_revive_helper"]["idle_stand_9"] = % sdr_mp_laststand_stand_revive_loop_helper_9;
  level._id_CC32["ls_revive_helper"]["idle_stand_9"] = "sdr_mp_laststand_stand_revive_loop_helper_9";
  level._id_CC3B["ls_revive_helper"]["idle_stand_9"] = "ls_stand_h_lp_9";
  level._id_CC31["ls_revive_helper"]["out_stand_1"] = % sdr_mp_laststand_stand_revive_out_helper_1;
  level._id_CC32["ls_revive_helper"]["out_stand_1"] = "sdr_mp_laststand_stand_revive_out_helper_1";
  level._id_CC3B["ls_revive_helper"]["out_stand_1"] = "ls_stand_h_out_1";
  level._id_CC31["ls_revive_helper"]["out_stand_2"] = % sdr_mp_laststand_stand_revive_out_helper_2;
  level._id_CC32["ls_revive_helper"]["out_stand_2"] = "sdr_mp_laststand_stand_revive_out_helper_2";
  level._id_CC3B["ls_revive_helper"]["out_stand_2"] = "ls_stand_h_out_2";
  level._id_CC31["ls_revive_helper"]["out_stand_3"] = % sdr_mp_laststand_stand_revive_out_helper_3;
  level._id_CC32["ls_revive_helper"]["out_stand_3"] = "sdr_mp_laststand_stand_revive_out_helper_3";
  level._id_CC3B["ls_revive_helper"]["out_stand_3"] = "ls_stand_h_out_3";
  level._id_CC31["ls_revive_helper"]["out_stand_4"] = % sdr_mp_laststand_stand_revive_out_helper_4;
  level._id_CC32["ls_revive_helper"]["out_stand_4"] = "sdr_mp_laststand_stand_revive_out_helper_4";
  level._id_CC3B["ls_revive_helper"]["out_stand_4"] = "ls_stand_h_out_4";
  level._id_CC31["ls_revive_helper"]["out_stand_6"] = % sdr_mp_laststand_stand_revive_out_helper_6;
  level._id_CC32["ls_revive_helper"]["out_stand_6"] = "sdr_mp_laststand_stand_revive_out_helper_6";
  level._id_CC3B["ls_revive_helper"]["out_stand_6"] = "ls_stand_h_out_6";
  level._id_CC31["ls_revive_helper"]["out_stand_7"] = % sdr_mp_laststand_stand_revive_out_helper_7;
  level._id_CC32["ls_revive_helper"]["out_stand_7"] = "sdr_mp_laststand_stand_revive_out_helper_7";
  level._id_CC3B["ls_revive_helper"]["out_stand_7"] = "ls_stand_h_out_7";
  level._id_CC31["ls_revive_helper"]["out_stand_8"] = % sdr_mp_laststand_stand_revive_out_helper_8;
  level._id_CC32["ls_revive_helper"]["out_stand_8"] = "sdr_mp_laststand_stand_revive_out_helper_8";
  level._id_CC3B["ls_revive_helper"]["out_stand_8"] = "ls_stand_h_out_8";
  level._id_CC31["ls_revive_helper"]["out_stand_9"] = % sdr_mp_laststand_stand_revive_out_helper_9;
  level._id_CC32["ls_revive_helper"]["out_stand_9"] = "sdr_mp_laststand_stand_revive_out_helper_9";
  level._id_CC3B["ls_revive_helper"]["out_stand_9"] = "ls_stand_h_out_9";
  level._id_CC31["ls_revive_wounded"]["in_stand_1"] = % sdr_mp_laststand_stand_revive_in_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["in_stand_1"] = "sdr_mp_laststand_stand_revive_in_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["in_stand_1"] = "ls_stand_w_in_147";
  level._id_CC31["ls_revive_wounded"]["in_stand_2"] = % sdr_mp_laststand_stand_revive_in_wounded_2;
  level._id_CC32["ls_revive_wounded"]["in_stand_2"] = "sdr_mp_laststand_stand_revive_in_wounded_2";
  level._id_CC3B["ls_revive_wounded"]["in_stand_2"] = "ls_stand_w_in_2";
  level._id_CC31["ls_revive_wounded"]["in_stand_3"] = % sdr_mp_laststand_stand_revive_in_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["in_stand_3"] = "sdr_mp_laststand_stand_revive_in_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["in_stand_3"] = "ls_stand_w_in_369";
  level._id_CC31["ls_revive_wounded"]["in_stand_4"] = % sdr_mp_laststand_stand_revive_in_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["in_stand_4"] = "sdr_mp_laststand_stand_revive_in_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["in_stand_4"] = "ls_stand_w_in_147";
  level._id_CC31["ls_revive_wounded"]["in_stand_6"] = % sdr_mp_laststand_stand_revive_in_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["in_stand_6"] = "sdr_mp_laststand_stand_revive_in_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["in_stand_6"] = "ls_stand_w_in_369";
  level._id_CC31["ls_revive_wounded"]["in_stand_7"] = % sdr_mp_laststand_stand_revive_in_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["in_stand_7"] = "sdr_mp_laststand_stand_revive_in_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["in_stand_7"] = "ls_stand_w_in_147";
  level._id_CC31["ls_revive_wounded"]["in_stand_8"] = % sdr_mp_laststand_stand_revive_in_wounded_8;
  level._id_CC32["ls_revive_wounded"]["in_stand_8"] = "sdr_mp_laststand_stand_revive_in_wounded_8";
  level._id_CC3B["ls_revive_wounded"]["in_stand_8"] = "ls_stand_w_in_8";
  level._id_CC31["ls_revive_wounded"]["in_stand_9"] = % sdr_mp_laststand_stand_revive_in_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["in_stand_9"] = "sdr_mp_laststand_stand_revive_in_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["in_stand_9"] = "ls_stand_w_in_369";
  level._id_CC31["ls_revive_wounded"]["idle_stand_1"] = % sdr_mp_laststand_stand_revive_loop_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["idle_stand_1"] = "sdr_mp_laststand_stand_revive_loop_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["idle_stand_1"] = "ls_stand_w_lp_147";
  level._id_CC31["ls_revive_wounded"]["idle_stand_2"] = % sdr_mp_laststand_stand_revive_loop_wounded_2;
  level._id_CC32["ls_revive_wounded"]["idle_stand_2"] = "sdr_mp_laststand_stand_revive_loop_wounded_2";
  level._id_CC3B["ls_revive_wounded"]["idle_stand_2"] = "ls_stand_w_lp_2";
  level._id_CC31["ls_revive_wounded"]["idle_stand_3"] = % sdr_mp_laststand_stand_revive_loop_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["idle_stand_3"] = "sdr_mp_laststand_stand_revive_loop_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["idle_stand_3"] = "ls_stand_w_lp_369";
  level._id_CC31["ls_revive_wounded"]["idle_stand_4"] = % sdr_mp_laststand_stand_revive_loop_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["idle_stand_4"] = "sdr_mp_laststand_stand_revive_loop_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["idle_stand_4"] = "ls_stand_w_lp_147";
  level._id_CC31["ls_revive_wounded"]["idle_stand_6"] = % sdr_mp_laststand_stand_revive_loop_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["idle_stand_6"] = "sdr_mp_laststand_stand_revive_loop_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["idle_stand_6"] = "ls_stand_w_lp_369";
  level._id_CC31["ls_revive_wounded"]["idle_stand_7"] = % sdr_mp_laststand_stand_revive_loop_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["idle_stand_7"] = "sdr_mp_laststand_stand_revive_loop_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["idle_stand_7"] = "ls_stand_w_lp_147";
  level._id_CC31["ls_revive_wounded"]["idle_stand_8"] = % sdr_mp_laststand_stand_revive_loop_wounded_8;
  level._id_CC32["ls_revive_wounded"]["idle_stand_8"] = "sdr_mp_laststand_stand_revive_loop_wounded_8";
  level._id_CC3B["ls_revive_wounded"]["idle_stand_8"] = "ls_stand_w_lp_8";
  level._id_CC31["ls_revive_wounded"]["idle_stand_9"] = % sdr_mp_laststand_stand_revive_loop_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["idle_stand_9"] = "sdr_mp_laststand_stand_revive_loop_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["idle_stand_9"] = "ls_stand_w_lp_369";
  level._id_CC31["ls_revive_wounded"]["out_stand_1"] = % sdr_mp_laststand_stand_revive_out_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["out_stand_1"] = "sdr_mp_laststand_stand_revive_out_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["out_stand_1"] = "ls_stand_w_out_147";
  level._id_CC31["ls_revive_wounded"]["out_stand_2"] = % sdr_mp_laststand_stand_revive_out_wounded_2;
  level._id_CC32["ls_revive_wounded"]["out_stand_2"] = "sdr_mp_laststand_stand_revive_out_wounded_2";
  level._id_CC3B["ls_revive_wounded"]["out_stand_2"] = "ls_stand_w_out_2";
  level._id_CC31["ls_revive_wounded"]["out_stand_3"] = % sdr_mp_laststand_stand_revive_out_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["out_stand_3"] = "sdr_mp_laststand_stand_revive_out_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["out_stand_3"] = "ls_stand_w_out_369";
  level._id_CC31["ls_revive_wounded"]["out_stand_4"] = % sdr_mp_laststand_stand_revive_out_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["out_stand_4"] = "sdr_mp_laststand_stand_revive_out_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["out_stand_4"] = "ls_stand_w_out_147";
  level._id_CC31["ls_revive_wounded"]["out_stand_6"] = % sdr_mp_laststand_stand_revive_out_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["out_stand_6"] = "sdr_mp_laststand_stand_revive_out_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["out_stand_6"] = "ls_stand_w_out_369";
  level._id_CC31["ls_revive_wounded"]["out_stand_7"] = % sdr_mp_laststand_stand_revive_out_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["out_stand_7"] = "sdr_mp_laststand_stand_revive_out_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["out_stand_7"] = "ls_stand_w_out_147";
  level._id_CC31["ls_revive_wounded"]["out_stand_8"] = % sdr_mp_laststand_stand_revive_out_wounded_8;
  level._id_CC32["ls_revive_wounded"]["out_stand_8"] = "sdr_mp_laststand_stand_revive_out_wounded_8";
  level._id_CC3B["ls_revive_wounded"]["out_stand_8"] = "ls_stand_w_out_8";
  level._id_CC31["ls_revive_wounded"]["out_stand_9"] = % sdr_mp_laststand_stand_revive_out_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["out_stand_9"] = "sdr_mp_laststand_stand_revive_out_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["out_stand_9"] = "ls_stand_w_out_369";
  level._id_CC31["ls_revive_helper"]["in_crouch_1"] = % sdr_mp_laststand_crouch_revive_in_helper_1;
  level._id_CC32["ls_revive_helper"]["in_crouch_1"] = "sdr_mp_laststand_crouch_revive_in_helper_1";
  level._id_CC3B["ls_revive_helper"]["in_crouch_1"] = "ls_crouch_h_in_1";
  level._id_CC31["ls_revive_helper"]["in_crouch_2"] = % sdr_mp_laststand_crouch_revive_in_helper_2;
  level._id_CC32["ls_revive_helper"]["in_crouch_2"] = "sdr_mp_laststand_crouch_revive_in_helper_2";
  level._id_CC3B["ls_revive_helper"]["in_crouch_2"] = "ls_crouch_h_in_2";
  level._id_CC31["ls_revive_helper"]["in_crouch_3"] = % sdr_mp_laststand_crouch_revive_in_helper_3;
  level._id_CC32["ls_revive_helper"]["in_crouch_3"] = "sdr_mp_laststand_crouch_revive_in_helper_3";
  level._id_CC3B["ls_revive_helper"]["in_crouch_3"] = "ls_crouch_h_in_3";
  level._id_CC31["ls_revive_helper"]["in_crouch_4"] = % sdr_mp_laststand_crouch_revive_in_helper_4;
  level._id_CC32["ls_revive_helper"]["in_crouch_4"] = "sdr_mp_laststand_crouch_revive_in_helper_4";
  level._id_CC3B["ls_revive_helper"]["in_crouch_4"] = "ls_crouch_h_in_4";
  level._id_CC31["ls_revive_helper"]["in_crouch_6"] = % sdr_mp_laststand_crouch_revive_in_helper_6;
  level._id_CC32["ls_revive_helper"]["in_crouch_6"] = "sdr_mp_laststand_crouch_revive_in_helper_6";
  level._id_CC3B["ls_revive_helper"]["in_crouch_6"] = "ls_crouch_h_in_6";
  level._id_CC31["ls_revive_helper"]["in_crouch_7"] = % sdr_mp_laststand_crouch_revive_in_helper_7;
  level._id_CC32["ls_revive_helper"]["in_crouch_7"] = "sdr_mp_laststand_crouch_revive_in_helper_7";
  level._id_CC3B["ls_revive_helper"]["in_crouch_7"] = "ls_crouch_h_in_7";
  level._id_CC31["ls_revive_helper"]["in_crouch_8"] = % sdr_mp_laststand_crouch_revive_in_helper_8;
  level._id_CC32["ls_revive_helper"]["in_crouch_8"] = "sdr_mp_laststand_crouch_revive_in_helper_8";
  level._id_CC3B["ls_revive_helper"]["in_crouch_8"] = "ls_crouch_h_in_8";
  level._id_CC31["ls_revive_helper"]["in_crouch_9"] = % sdr_mp_laststand_crouch_revive_in_helper_9;
  level._id_CC32["ls_revive_helper"]["in_crouch_9"] = "sdr_mp_laststand_crouch_revive_in_helper_9";
  level._id_CC3B["ls_revive_helper"]["in_crouch_9"] = "ls_crouch_h_in_9";
  level._id_CC31["ls_revive_helper"]["idle_crouch_1"] = % sdr_mp_laststand_crouch_revive_loop_helper_1;
  level._id_CC32["ls_revive_helper"]["idle_crouch_1"] = "sdr_mp_laststand_crouch_revive_loop_helper_1";
  level._id_CC3B["ls_revive_helper"]["idle_crouch_1"] = "ls_crouch_h_lp_1";
  level._id_CC31["ls_revive_helper"]["idle_crouch_2"] = % sdr_mp_laststand_crouch_revive_loop_helper_2;
  level._id_CC32["ls_revive_helper"]["idle_crouch_2"] = "sdr_mp_laststand_crouch_revive_loop_helper_2";
  level._id_CC3B["ls_revive_helper"]["idle_crouch_2"] = "ls_crouch_h_lp_2";
  level._id_CC31["ls_revive_helper"]["idle_crouch_3"] = % sdr_mp_laststand_crouch_revive_loop_helper_3;
  level._id_CC32["ls_revive_helper"]["idle_crouch_3"] = "sdr_mp_laststand_crouch_revive_loop_helper_3";
  level._id_CC3B["ls_revive_helper"]["idle_crouch_3"] = "ls_crouch_h_lp_3";
  level._id_CC31["ls_revive_helper"]["idle_crouch_4"] = % sdr_mp_laststand_crouch_revive_loop_helper_4;
  level._id_CC32["ls_revive_helper"]["idle_crouch_4"] = "sdr_mp_laststand_crouch_revive_loop_helper_4";
  level._id_CC3B["ls_revive_helper"]["idle_crouch_4"] = "ls_crouch_h_lp_4";
  level._id_CC31["ls_revive_helper"]["idle_crouch_6"] = % sdr_mp_laststand_crouch_revive_loop_helper_6;
  level._id_CC32["ls_revive_helper"]["idle_crouch_6"] = "sdr_mp_laststand_crouch_revive_loop_helper_6";
  level._id_CC3B["ls_revive_helper"]["idle_crouch_6"] = "ls_crouch_h_lp_6";
  level._id_CC31["ls_revive_helper"]["idle_crouch_7"] = % sdr_mp_laststand_crouch_revive_loop_helper_7;
  level._id_CC32["ls_revive_helper"]["idle_crouch_7"] = "sdr_mp_laststand_crouch_revive_loop_helper_7";
  level._id_CC3B["ls_revive_helper"]["idle_crouch_7"] = "ls_crouch_h_lp_7";
  level._id_CC31["ls_revive_helper"]["idle_crouch_8"] = % sdr_mp_laststand_crouch_revive_loop_helper_8;
  level._id_CC32["ls_revive_helper"]["idle_crouch_8"] = "sdr_mp_laststand_crouch_revive_loop_helper_8";
  level._id_CC3B["ls_revive_helper"]["idle_crouch_8"] = "ls_crouch_h_lp_8";
  level._id_CC31["ls_revive_helper"]["idle_crouch_9"] = % sdr_mp_laststand_crouch_revive_loop_helper_9;
  level._id_CC32["ls_revive_helper"]["idle_crouch_9"] = "sdr_mp_laststand_crouch_revive_loop_helper_9";
  level._id_CC3B["ls_revive_helper"]["idle_crouch_9"] = "ls_crouch_h_lp_9";
  level._id_CC31["ls_revive_helper"]["out_crouch_1"] = % sdr_mp_laststand_crouch_revive_out_helper_1;
  level._id_CC32["ls_revive_helper"]["out_crouch_1"] = "sdr_mp_laststand_crouch_revive_out_helper_1";
  level._id_CC3B["ls_revive_helper"]["out_crouch_1"] = "ls_crouch_h_out_1";
  level._id_CC31["ls_revive_helper"]["out_crouch_2"] = % sdr_mp_laststand_crouch_revive_out_helper_2;
  level._id_CC32["ls_revive_helper"]["out_crouch_2"] = "sdr_mp_laststand_crouch_revive_out_helper_2";
  level._id_CC3B["ls_revive_helper"]["out_crouch_2"] = "ls_crouch_h_out_2";
  level._id_CC31["ls_revive_helper"]["out_crouch_3"] = % sdr_mp_laststand_crouch_revive_out_helper_3;
  level._id_CC32["ls_revive_helper"]["out_crouch_3"] = "sdr_mp_laststand_crouch_revive_out_helper_3";
  level._id_CC3B["ls_revive_helper"]["out_crouch_3"] = "ls_crouch_h_out_3";
  level._id_CC31["ls_revive_helper"]["out_crouch_4"] = % sdr_mp_laststand_crouch_revive_out_helper_4;
  level._id_CC32["ls_revive_helper"]["out_crouch_4"] = "sdr_mp_laststand_crouch_revive_out_helper_4";
  level._id_CC3B["ls_revive_helper"]["out_crouch_4"] = "ls_crouch_h_out_4";
  level._id_CC31["ls_revive_helper"]["out_crouch_6"] = % sdr_mp_laststand_crouch_revive_out_helper_6;
  level._id_CC32["ls_revive_helper"]["out_crouch_6"] = "sdr_mp_laststand_crouch_revive_out_helper_6";
  level._id_CC3B["ls_revive_helper"]["out_crouch_6"] = "ls_crouch_h_out_6";
  level._id_CC31["ls_revive_helper"]["out_crouch_7"] = % sdr_mp_laststand_crouch_revive_out_helper_7;
  level._id_CC32["ls_revive_helper"]["out_crouch_7"] = "sdr_mp_laststand_crouch_revive_out_helper_7";
  level._id_CC3B["ls_revive_helper"]["out_crouch_7"] = "ls_crouch_h_out_7";
  level._id_CC31["ls_revive_helper"]["out_crouch_8"] = % sdr_mp_laststand_crouch_revive_out_helper_8;
  level._id_CC32["ls_revive_helper"]["out_crouch_8"] = "sdr_mp_laststand_crouch_revive_out_helper_8";
  level._id_CC3B["ls_revive_helper"]["out_crouch_8"] = "ls_crouch_h_out_8";
  level._id_CC31["ls_revive_helper"]["out_crouch_9"] = % sdr_mp_laststand_crouch_revive_out_helper_9;
  level._id_CC32["ls_revive_helper"]["out_crouch_9"] = "sdr_mp_laststand_crouch_revive_out_helper_9";
  level._id_CC3B["ls_revive_helper"]["out_crouch_9"] = "ls_crouch_h_out_9";
  level._id_CC31["ls_revive_wounded"]["in_crouch_1"] = % sdr_mp_laststand_crouch_revive_in_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["in_crouch_1"] = "sdr_mp_laststand_crouch_revive_in_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["in_crouch_1"] = "ls_crouch_w_in_147";
  level._id_CC31["ls_revive_wounded"]["in_crouch_2"] = % sdr_mp_laststand_crouch_revive_in_wounded_2;
  level._id_CC32["ls_revive_wounded"]["in_crouch_2"] = "sdr_mp_laststand_crouch_revive_in_wounded_2";
  level._id_CC3B["ls_revive_wounded"]["in_crouch_2"] = "ls_crouch_w_in_2";
  level._id_CC31["ls_revive_wounded"]["in_crouch_3"] = % sdr_mp_laststand_crouch_revive_in_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["in_crouch_3"] = "sdr_mp_laststand_crouch_revive_in_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["in_crouch_3"] = "ls_crouch_w_in_369";
  level._id_CC31["ls_revive_wounded"]["in_crouch_4"] = % sdr_mp_laststand_crouch_revive_in_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["in_crouch_4"] = "sdr_mp_laststand_crouch_revive_in_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["in_crouch_4"] = "ls_crouch_w_in_147";
  level._id_CC31["ls_revive_wounded"]["in_crouch_6"] = % sdr_mp_laststand_crouch_revive_in_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["in_crouch_6"] = "sdr_mp_laststand_crouch_revive_in_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["in_crouch_6"] = "ls_crouch_w_in_369";
  level._id_CC31["ls_revive_wounded"]["in_crouch_7"] = % sdr_mp_laststand_crouch_revive_in_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["in_crouch_7"] = "sdr_mp_laststand_crouch_revive_in_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["in_crouch_7"] = "ls_crouch_w_in_147";
  level._id_CC31["ls_revive_wounded"]["in_crouch_8"] = % sdr_mp_laststand_crouch_revive_in_wounded_8;
  level._id_CC32["ls_revive_wounded"]["in_crouch_8"] = "sdr_mp_laststand_crouch_revive_in_wounded_8";
  level._id_CC3B["ls_revive_wounded"]["in_crouch_8"] = "ls_crouch_w_in_8";
  level._id_CC31["ls_revive_wounded"]["in_crouch_9"] = % sdr_mp_laststand_crouch_revive_in_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["in_crouch_9"] = "sdr_mp_laststand_crouch_revive_in_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["in_crouch_9"] = "ls_crouch_w_in_369";
  level._id_CC31["ls_revive_wounded"]["idle_crouch_1"] = % sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["idle_crouch_1"] = "sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["idle_crouch_1"] = "ls_crouch_w_lp_147";
  level._id_CC31["ls_revive_wounded"]["idle_crouch_2"] = % sdr_mp_laststand_crouch_revive_loop_wounded_2;
  level._id_CC32["ls_revive_wounded"]["idle_crouch_2"] = "sdr_mp_laststand_crouch_revive_loop_wounded_2";
  level._id_CC3B["ls_revive_wounded"]["idle_crouch_2"] = "ls_crouch_w_lp_2";
  level._id_CC31["ls_revive_wounded"]["idle_crouch_3"] = % sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["idle_crouch_3"] = "sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["idle_crouch_3"] = "ls_crouch_w_lp_369";
  level._id_CC31["ls_revive_wounded"]["idle_crouch_4"] = % sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["idle_crouch_4"] = "sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["idle_crouch_4"] = "ls_crouch_w_lp_147";
  level._id_CC31["ls_revive_wounded"]["idle_crouch_6"] = % sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["idle_crouch_6"] = "sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["idle_crouch_6"] = "ls_crouch_w_lp_369";
  level._id_CC31["ls_revive_wounded"]["idle_crouch_7"] = % sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["idle_crouch_7"] = "sdr_mp_laststand_crouch_revive_loop_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["idle_crouch_7"] = "ls_crouch_w_lp_147";
  level._id_CC31["ls_revive_wounded"]["idle_crouch_8"] = % sdr_mp_laststand_crouch_revive_loop_wounded_8;
  level._id_CC32["ls_revive_wounded"]["idle_crouch_8"] = "sdr_mp_laststand_crouch_revive_loop_wounded_8";
  level._id_CC3B["ls_revive_wounded"]["idle_crouch_8"] = "ls_crouch_w_lp_8";
  level._id_CC31["ls_revive_wounded"]["idle_crouch_9"] = % sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["idle_crouch_9"] = "sdr_mp_laststand_crouch_revive_loop_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["idle_crouch_9"] = "ls_crouch_w_lp_369";
  level._id_CC31["ls_revive_wounded"]["out_crouch_1"] = % sdr_mp_laststand_crouch_revive_out_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["out_crouch_1"] = "sdr_mp_laststand_crouch_revive_out_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["out_crouch_1"] = "ls_crouch_w_out_147";
  level._id_CC31["ls_revive_wounded"]["out_crouch_2"] = % sdr_mp_laststand_crouch_revive_out_wounded_2;
  level._id_CC32["ls_revive_wounded"]["out_crouch_2"] = "sdr_mp_laststand_crouch_revive_out_wounded_2";
  level._id_CC3B["ls_revive_wounded"]["out_crouch_2"] = "ls_crouch_w_out_2";
  level._id_CC31["ls_revive_wounded"]["out_crouch_3"] = % sdr_mp_laststand_crouch_revive_out_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["out_crouch_3"] = "sdr_mp_laststand_crouch_revive_out_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["out_crouch_3"] = "ls_crouch_w_out_369";
  level._id_CC31["ls_revive_wounded"]["out_crouch_4"] = % sdr_mp_laststand_crouch_revive_out_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["out_crouch_4"] = "sdr_mp_laststand_crouch_revive_out_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["out_crouch_4"] = "ls_crouch_w_out_147";
  level._id_CC31["ls_revive_wounded"]["out_crouch_6"] = % sdr_mp_laststand_crouch_revive_out_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["out_crouch_6"] = "sdr_mp_laststand_crouch_revive_out_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["out_crouch_6"] = "ls_crouch_w_out_369";
  level._id_CC31["ls_revive_wounded"]["out_crouch_7"] = % sdr_mp_laststand_crouch_revive_out_wounded_1_4_7;
  level._id_CC32["ls_revive_wounded"]["out_crouch_7"] = "sdr_mp_laststand_crouch_revive_out_wounded_1_4_7";
  level._id_CC3B["ls_revive_wounded"]["out_crouch_7"] = "ls_crouch_w_out_147";
  level._id_CC31["ls_revive_wounded"]["out_crouch_8"] = % sdr_mp_laststand_crouch_revive_out_wounded_8;
  level._id_CC32["ls_revive_wounded"]["out_crouch_8"] = "sdr_mp_laststand_crouch_revive_out_wounded_8";
  level._id_CC3B["ls_revive_wounded"]["out_crouch_8"] = "ls_crouch_w_out_8";
  level._id_CC31["ls_revive_wounded"]["out_crouch_9"] = % sdr_mp_laststand_crouch_revive_out_wounded_3_6_9;
  level._id_CC32["ls_revive_wounded"]["out_crouch_9"] = "sdr_mp_laststand_crouch_revive_out_wounded_3_6_9";
  level._id_CC3B["ls_revive_wounded"]["out_crouch_9"] = "ls_crouch_w_out_369";
  level._id_CC31["ls_revive_wounded"]["in_prone_1"] = % sdr_mp_laststand_prone_revive_in_wounded_1;
  level._id_CC32["ls_revive_wounded"]["in_prone_1"] = "sdr_mp_laststand_prone_revive_in_wounded_1";
  level._id_CC3B["ls_revive_wounded"]["in_prone_1"] = "ls_prone_w_in_1";
  level._id_CC31["ls_revive_wounded"]["in_prone_2"] = % sdr_mp_laststand_prone_revive_in_wounded_2;
  level._id_CC32["ls_revive_wounded"]["in_prone_2"] = "sdr_mp_laststand_prone_revive_in_wounded_2";
  level._id_CC3B["ls_revive_wounded"]["in_prone_2"] = "ls_prone_w_in_2";
  level._id_CC31["ls_revive_wounded"]["in_prone_3"] = % sdr_mp_laststand_prone_revive_in_wounded_3;
  level._id_CC32["ls_revive_wounded"]["in_prone_3"] = "sdr_mp_laststand_prone_revive_in_wounded_3";
  level._id_CC3B["ls_revive_wounded"]["in_prone_3"] = "ls_prone_w_in_3";
  level._id_CC31["ls_revive_wounded"]["in_prone_4"] = % sdr_mp_laststand_prone_revive_in_wounded_4;
  level._id_CC32["ls_revive_wounded"]["in_prone_4"] = "sdr_mp_laststand_prone_revive_in_wounded_4";
  level._id_CC3B["ls_revive_wounded"]["in_prone_4"] = "ls_prone_w_in_4";
  level._id_CC31["ls_revive_wounded"]["in_prone_6"] = % sdr_mp_laststand_prone_revive_in_wounded_6;
  level._id_CC32["ls_revive_wounded"]["in_prone_6"] = "sdr_mp_laststand_prone_revive_in_wounded_6";
  level._id_CC3B["ls_revive_wounded"]["in_prone_6"] = "ls_prone_w_in_6";
  level._id_CC31["ls_revive_wounded"]["in_prone_7"] = % sdr_mp_laststand_prone_revive_in_wounded_7;
  level._id_CC32["ls_revive_wounded"]["in_prone_7"] = "sdr_mp_laststand_prone_revive_in_wounded_7";
  level._id_CC3B["ls_revive_wounded"]["in_prone_7"] = "ls_prone_w_in_7";
  level._id_CC31["ls_revive_wounded"]["in_prone_8"] = % sdr_mp_laststand_prone_revive_in_wounded_8;
  level._id_CC32["ls_revive_wounded"]["in_prone_8"] = "sdr_mp_laststand_prone_revive_in_wounded_8";
  level._id_CC3B["ls_revive_wounded"]["in_prone_8"] = "ls_prone_w_in_8";
  level._id_CC31["ls_revive_wounded"]["in_prone_9"] = % sdr_mp_laststand_prone_revive_in_wounded_9;
  level._id_CC32["ls_revive_wounded"]["in_prone_9"] = "sdr_mp_laststand_prone_revive_in_wounded_9";
  level._id_CC3B["ls_revive_wounded"]["in_prone_9"] = "ls_prone_w_in_9";
  level._id_CC31["ls_revive_wounded"]["idle_prone_1"] = % sdr_mp_laststand_prone_revive_loop_wounded_1;
  level._id_CC32["ls_revive_wounded"]["idle_prone_1"] = "sdr_mp_laststand_prone_revive_loop_wounded_1";
  level._id_CC3B["ls_revive_wounded"]["idle_prone_1"] = "ls_prone_w_lp_1";
  level._id_CC31["ls_revive_wounded"]["idle_prone_2"] = % sdr_mp_laststand_prone_revive_loop_wounded_2;
  level._id_CC32["ls_revive_wounded"]["idle_prone_2"] = "sdr_mp_laststand_prone_revive_loop_wounded_2";
  level._id_CC3B["ls_revive_wounded"]["idle_prone_2"] = "ls_prone_w_lp_2";
  level._id_CC31["ls_revive_wounded"]["idle_prone_3"] = % sdr_mp_laststand_prone_revive_loop_wounded_3;
  level._id_CC32["ls_revive_wounded"]["idle_prone_3"] = "sdr_mp_laststand_prone_revive_loop_wounded_3";
  level._id_CC3B["ls_revive_wounded"]["idle_prone_3"] = "ls_prone_w_lp_3";
  level._id_CC31["ls_revive_wounded"]["idle_prone_4"] = % sdr_mp_laststand_prone_revive_loop_wounded_4;
  level._id_CC32["ls_revive_wounded"]["idle_prone_4"] = "sdr_mp_laststand_prone_revive_loop_wounded_4";
  level._id_CC3B["ls_revive_wounded"]["idle_prone_4"] = "ls_prone_w_lp_4";
  level._id_CC31["ls_revive_wounded"]["idle_prone_6"] = % sdr_mp_laststand_prone_revive_loop_wounded_6;
  level._id_CC32["ls_revive_wounded"]["idle_prone_6"] = "sdr_mp_laststand_prone_revive_loop_wounded_6";
  level._id_CC3B["ls_revive_wounded"]["idle_prone_6"] = "ls_prone_w_lp_6";
  level._id_CC31["ls_revive_wounded"]["idle_prone_7"] = % sdr_mp_laststand_prone_revive_loop_wounded_7;
  level._id_CC32["ls_revive_wounded"]["idle_prone_7"] = "sdr_mp_laststand_prone_revive_loop_wounded_7";
  level._id_CC3B["ls_revive_wounded"]["idle_prone_7"] = "ls_prone_w_lp_7";
  level._id_CC31["ls_revive_wounded"]["idle_prone_8"] = % sdr_mp_laststand_prone_revive_loop_wounded_8;
  level._id_CC32["ls_revive_wounded"]["idle_prone_8"] = "sdr_mp_laststand_prone_revive_loop_wounded_8";
  level._id_CC3B["ls_revive_wounded"]["idle_prone_8"] = "ls_prone_w_lp_8";
  level._id_CC31["ls_revive_wounded"]["idle_prone_9"] = % sdr_mp_laststand_prone_revive_loop_wounded_9;
  level._id_CC32["ls_revive_wounded"]["idle_prone_9"] = "sdr_mp_laststand_prone_revive_loop_wounded_9";
  level._id_CC3B["ls_revive_wounded"]["idle_prone_9"] = "ls_prone_w_lp_9";
  level._id_CC31["ls_revive_wounded"]["out_prone_1"] = % sdr_mp_laststand_prone_revive_out_wounded_1;
  level._id_CC32["ls_revive_wounded"]["out_prone_1"] = "sdr_mp_laststand_prone_revive_out_wounded_1";
  level._id_CC3B["ls_revive_wounded"]["out_prone_1"] = "ls_prone_w_out_1";
  level._id_CC31["ls_revive_wounded"]["out_prone_2"] = % sdr_mp_laststand_prone_revive_out_wounded_2;
  level._id_CC32["ls_revive_wounded"]["out_prone_2"] = "sdr_mp_laststand_prone_revive_out_wounded_2";
  level._id_CC3B["ls_revive_wounded"]["out_prone_2"] = "ls_prone_w_out_2";
  level._id_CC31["ls_revive_wounded"]["out_prone_3"] = % sdr_mp_laststand_prone_revive_out_wounded_3;
  level._id_CC32["ls_revive_wounded"]["out_prone_3"] = "sdr_mp_laststand_prone_revive_out_wounded_3";
  level._id_CC3B["ls_revive_wounded"]["out_prone_3"] = "ls_prone_w_out_3";
  level._id_CC31["ls_revive_wounded"]["out_prone_4"] = % sdr_mp_laststand_prone_revive_out_wounded_4;
  level._id_CC32["ls_revive_wounded"]["out_prone_4"] = "sdr_mp_laststand_prone_revive_out_wounded_4";
  level._id_CC3B["ls_revive_wounded"]["out_prone_4"] = "ls_prone_w_out_4";
  level._id_CC31["ls_revive_wounded"]["out_prone_6"] = % sdr_mp_laststand_prone_revive_out_wounded_6;
  level._id_CC32["ls_revive_wounded"]["out_prone_6"] = "sdr_mp_laststand_prone_revive_out_wounded_6";
  level._id_CC3B["ls_revive_wounded"]["out_prone_6"] = "ls_prone_w_out_6";
  level._id_CC31["ls_revive_wounded"]["out_prone_7"] = % sdr_mp_laststand_prone_revive_out_wounded_7;
  level._id_CC32["ls_revive_wounded"]["out_prone_7"] = "sdr_mp_laststand_prone_revive_out_wounded_7";
  level._id_CC3B["ls_revive_wounded"]["out_prone_7"] = "ls_prone_w_out_7";
  level._id_CC31["ls_revive_wounded"]["out_prone_8"] = % sdr_mp_laststand_prone_revive_out_wounded_8;
  level._id_CC32["ls_revive_wounded"]["out_prone_8"] = "sdr_mp_laststand_prone_revive_out_wounded_8";
  level._id_CC3B["ls_revive_wounded"]["out_prone_8"] = "ls_prone_w_out_8";
  level._id_CC31["ls_revive_wounded"]["out_prone_9"] = % sdr_mp_laststand_prone_revive_out_wounded_9;
  level._id_CC32["ls_revive_wounded"]["out_prone_9"] = "sdr_mp_laststand_prone_revive_out_wounded_9";
  level._id_CC3B["ls_revive_wounded"]["out_prone_9"] = "ls_prone_w_out_9";
  level._id_CC31["ls_revive_helper"]["in_prone_1"] = % sdr_mp_laststand_prone_revive_in_helper_1;
  level._id_CC32["ls_revive_helper"]["in_prone_1"] = "sdr_mp_laststand_prone_revive_in_helper_1";
  level._id_CC3B["ls_revive_helper"]["in_prone_1"] = "ls_prone_h_in_1";
  level._id_CC31["ls_revive_helper"]["in_prone_2"] = % sdr_mp_laststand_prone_revive_in_helper_2;
  level._id_CC32["ls_revive_helper"]["in_prone_2"] = "sdr_mp_laststand_prone_revive_in_helper_2";
  level._id_CC3B["ls_revive_helper"]["in_prone_2"] = "ls_prone_h_in_2";
  level._id_CC31["ls_revive_helper"]["in_prone_3"] = % sdr_mp_laststand_prone_revive_in_helper_3;
  level._id_CC32["ls_revive_helper"]["in_prone_3"] = "sdr_mp_laststand_prone_revive_in_helper_3";
  level._id_CC3B["ls_revive_helper"]["in_prone_3"] = "ls_prone_h_in_3";
  level._id_CC31["ls_revive_helper"]["in_prone_4"] = % sdr_mp_laststand_prone_revive_in_helper_4;
  level._id_CC32["ls_revive_helper"]["in_prone_4"] = "sdr_mp_laststand_prone_revive_in_helper_4";
  level._id_CC3B["ls_revive_helper"]["in_prone_4"] = "ls_prone_h_in_4";
  level._id_CC31["ls_revive_helper"]["in_prone_6"] = % sdr_mp_laststand_prone_revive_in_helper_6;
  level._id_CC32["ls_revive_helper"]["in_prone_6"] = "sdr_mp_laststand_prone_revive_in_helper_6";
  level._id_CC3B["ls_revive_helper"]["in_prone_6"] = "ls_prone_h_in_6";
  level._id_CC31["ls_revive_helper"]["in_prone_7"] = % sdr_mp_laststand_prone_revive_in_helper_7;
  level._id_CC32["ls_revive_helper"]["in_prone_7"] = "sdr_mp_laststand_prone_revive_in_helper_7";
  level._id_CC3B["ls_revive_helper"]["in_prone_7"] = "ls_prone_h_in_7";
  level._id_CC31["ls_revive_helper"]["in_prone_8"] = % sdr_mp_laststand_prone_revive_in_helper_8;
  level._id_CC32["ls_revive_helper"]["in_prone_8"] = "sdr_mp_laststand_prone_revive_in_helper_8";
  level._id_CC3B["ls_revive_helper"]["in_prone_8"] = "ls_prone_h_in_8";
  level._id_CC31["ls_revive_helper"]["in_prone_9"] = % sdr_mp_laststand_prone_revive_in_helper_9;
  level._id_CC32["ls_revive_helper"]["in_prone_9"] = "sdr_mp_laststand_prone_revive_in_helper_9";
  level._id_CC3B["ls_revive_helper"]["in_prone_9"] = "ls_prone_h_in_9";
  level._id_CC31["ls_revive_helper"]["idle_prone_1"] = % sdr_mp_laststand_prone_revive_loop_helper_1;
  level._id_CC32["ls_revive_helper"]["idle_prone_1"] = "sdr_mp_laststand_prone_revive_loop_helper_1";
  level._id_CC3B["ls_revive_helper"]["idle_prone_1"] = "ls_prone_h_lp_1";
  level._id_CC31["ls_revive_helper"]["idle_prone_2"] = % sdr_mp_laststand_prone_revive_loop_helper_2;
  level._id_CC32["ls_revive_helper"]["idle_prone_2"] = "sdr_mp_laststand_prone_revive_loop_helper_2";
  level._id_CC3B["ls_revive_helper"]["idle_prone_2"] = "ls_prone_h_lp_2";
  level._id_CC31["ls_revive_helper"]["idle_prone_3"] = % sdr_mp_laststand_prone_revive_loop_helper_3;
  level._id_CC32["ls_revive_helper"]["idle_prone_3"] = "sdr_mp_laststand_prone_revive_loop_helper_3";
  level._id_CC3B["ls_revive_helper"]["idle_prone_3"] = "ls_prone_h_lp_3";
  level._id_CC31["ls_revive_helper"]["idle_prone_4"] = % sdr_mp_laststand_prone_revive_loop_helper_4;
  level._id_CC32["ls_revive_helper"]["idle_prone_4"] = "sdr_mp_laststand_prone_revive_loop_helper_4";
  level._id_CC3B["ls_revive_helper"]["idle_prone_4"] = "ls_prone_h_lp_4";
  level._id_CC31["ls_revive_helper"]["idle_prone_6"] = % sdr_mp_laststand_prone_revive_loop_helper_6;
  level._id_CC32["ls_revive_helper"]["idle_prone_6"] = "sdr_mp_laststand_prone_revive_loop_helper_6";
  level._id_CC3B["ls_revive_helper"]["idle_prone_6"] = "ls_prone_h_lp_6";
  level._id_CC31["ls_revive_helper"]["idle_prone_7"] = % sdr_mp_laststand_prone_revive_loop_helper_7;
  level._id_CC32["ls_revive_helper"]["idle_prone_7"] = "sdr_mp_laststand_prone_revive_loop_helper_7";
  level._id_CC3B["ls_revive_helper"]["idle_prone_7"] = "ls_prone_h_lp_7";
  level._id_CC31["ls_revive_helper"]["idle_prone_8"] = % sdr_mp_laststand_prone_revive_loop_helper_8;
  level._id_CC32["ls_revive_helper"]["idle_prone_8"] = "sdr_mp_laststand_prone_revive_loop_helper_8";
  level._id_CC3B["ls_revive_helper"]["idle_prone_8"] = "ls_prone_h_lp_8";
  level._id_CC31["ls_revive_helper"]["idle_prone_9"] = % sdr_mp_laststand_prone_revive_loop_helper_9;
  level._id_CC32["ls_revive_helper"]["idle_prone_9"] = "sdr_mp_laststand_prone_revive_loop_helper_9";
  level._id_CC3B["ls_revive_helper"]["idle_prone_9"] = "ls_prone_h_lp_9";
  level._id_CC31["ls_revive_helper"]["out_prone_1"] = % sdr_mp_laststand_prone_revive_out_helper_1;
  level._id_CC32["ls_revive_helper"]["out_prone_1"] = "sdr_mp_laststand_prone_revive_out_helper_1";
  level._id_CC3B["ls_revive_helper"]["out_prone_1"] = "ls_prone_h_out_1";
  level._id_CC31["ls_revive_helper"]["out_prone_2"] = % sdr_mp_laststand_prone_revive_out_helper_2;
  level._id_CC32["ls_revive_helper"]["out_prone_2"] = "sdr_mp_laststand_prone_revive_out_helper_2";
  level._id_CC3B["ls_revive_helper"]["out_prone_2"] = "ls_prone_h_out_2";
  level._id_CC31["ls_revive_helper"]["out_prone_3"] = % sdr_mp_laststand_prone_revive_out_helper_3;
  level._id_CC32["ls_revive_helper"]["out_prone_3"] = "sdr_mp_laststand_prone_revive_out_helper_3";
  level._id_CC3B["ls_revive_helper"]["out_prone_3"] = "ls_prone_h_out_3";
  level._id_CC31["ls_revive_helper"]["out_prone_4"] = % sdr_mp_laststand_prone_revive_out_helper_4;
  level._id_CC32["ls_revive_helper"]["out_prone_4"] = "sdr_mp_laststand_prone_revive_out_helper_4";
  level._id_CC3B["ls_revive_helper"]["out_prone_4"] = "ls_prone_h_out_4";
  level._id_CC31["ls_revive_helper"]["out_prone_6"] = % sdr_mp_laststand_prone_revive_out_helper_6;
  level._id_CC32["ls_revive_helper"]["out_prone_6"] = "sdr_mp_laststand_prone_revive_out_helper_6";
  level._id_CC3B["ls_revive_helper"]["out_prone_6"] = "ls_prone_h_out_6";
  level._id_CC31["ls_revive_helper"]["out_prone_7"] = % sdr_mp_laststand_prone_revive_out_helper_7;
  level._id_CC32["ls_revive_helper"]["out_prone_7"] = "sdr_mp_laststand_prone_revive_out_helper_7";
  level._id_CC3B["ls_revive_helper"]["out_prone_7"] = "ls_prone_h_out_7";
  level._id_CC31["ls_revive_helper"]["out_prone_8"] = % sdr_mp_laststand_prone_revive_out_helper_8;
  level._id_CC32["ls_revive_helper"]["out_prone_8"] = "sdr_mp_laststand_prone_revive_out_helper_8";
  level._id_CC3B["ls_revive_helper"]["out_prone_8"] = "ls_prone_h_out_8";
  level._id_CC31["ls_revive_helper"]["out_prone_9"] = % sdr_mp_laststand_prone_revive_out_helper_9;
  level._id_CC32["ls_revive_helper"]["out_prone_9"] = "sdr_mp_laststand_prone_revive_out_helper_9";
  level._id_CC3B["ls_revive_helper"]["out_prone_9"] = "ls_prone_h_out_9";
  _id_06C6::_id_10F1("ls_revive_wounded", "cp_foley_revive_wounded_down", ::_id_C7D9);
  _id_06C6::_id_10F1("ls_revive_wounded", "cp_last_stand_revive_out_wounded", ::_id_C7DA);
  _id_06C6::_id_10F1("ls_revive_wounded", "cp_foley_revive_wounded_recover_standing", ::_id_C7DB);
  _id_06C6::_id_10F1("ls_revive_helper", "stim_attach", ::_id_EC4B);
  _id_06C6::_id_10F1("ls_revive_helper", "syringe_inject", ::_id_EC4A);
  _id_06C6::_id_10F1("ls_revive_helper", "syringe_finish", ::_id_EC47);
  _id_06C6::_id_10F1("ls_revive_helper", "syringe_finish_crouching", ::_id_EC48);
  _id_06C6::_id_10F1("ls_revive_helper", "syringe_finish_standing", ::_id_EC49);
}

_id_EC4B(var_0) {
  var_0._id_019B notify("spawn_stim");

  if(_func_0205("cp_foley_revive_helper_syringe_out")) {
    var_0 _meth_827E("cp_foley_revive_helper_syringe_out");
  }
}

_id_EC4A(var_0) {
  if(_func_0205("cp_foley_revive_helper_syringe_inject")) {
    var_0 _meth_827E("cp_foley_revive_helper_syringe_inject");
  }
}

_id_EC47(var_0) {
  if(_func_0205("cp_foley_revive_helper_syringe_finish")) {
    var_0 _meth_827E("cp_foley_revive_helper_syringe_finish");
  }

  var_0._id_019B notify("remove_stim");
}

_id_EC48(var_0) {
  if(_func_0205("cp_foley_revive_helper_recover_crouching")) {
    var_0 _meth_827E("cp_foley_revive_helper_recover_crouching");
  }

  var_0._id_019B notify("remove_stim");
}

_id_EC49(var_0) {
  if(_func_0205("cp_last_stand_revive_out_helper")) {
    var_0 _meth_827E("cp_last_stand_revive_out_helper");
  }

  var_0._id_019B notify("remove_stim");
}

_id_C7D9(var_0) {
  var_0 _meth_827E("cp_foley_revive_wounded_down");
}

_id_C7DA(var_0) {
  var_0 _meth_827E("cp_last_stand_revive_out_wounded");
}

_id_C7DB(var_0) {
  var_0 _meth_827E("cp_foley_revive_wounded_recover_standing");
}

_id_B272(var_0, var_1) {
  var_0 endon("revive_done");
  var_1 endon("revive_done");
  var_1 endon("disconnect");
  var_0._id_182F = var_0 getstance();
  var_2 = var_0 _id_63E5(var_1);
  var_3 = _id_0788::_id_182C(var_0, "ls_revive_helper", 1, 0, 1);
  var_4 = _id_0788::_id_182C(var_1, "ls_revive_wounded", 1, 0, 1);
  var_5 = spawnStruct();
  var_5.origin = var_1.origin;
  var_5.angles = var_1.angles;
  var_1._id_CBD0 = var_5;
  var_0._id_C7CA = var_0.origin;
  var_0 setcamerathirdperson(1);
  var_1 setcamerathirdperson(1);
  var_6 = "in_" + var_2._id_10FD2;
  var_7 = "idle_" + var_2._id_10FD2;
  var_8 = "out_" + var_2._id_10FD2;
  var_0 thread _id_7412(var_1);

  if(istrue(var_0._id_88DF)) {
    if(var_0._id_182F != "prone") {
      var_5 _id_0788::_id_182B([var_3, var_4], var_6, 1, 0, undefined, undefined, undefined, 1);
    }
  } else
    var_5 _id_0788::_id_182B([var_3, var_4], var_6, 1, 0);

  if(!isDefined(var_0.class) || !istrue(var_0.class == "medic")) {
    if(istrue(var_0._id_88DF)) {
      var_5 _id_0788::_id_182B([var_3, var_4], var_7, 0, 0, undefined, undefined, undefined, 1);
    } else {
      var_5 _id_0788::_id_182B([var_3, var_4], var_7, 0, 0);
    }
  }

  var_1 thread _id_905D();

  if(istrue(var_0._id_88DF)) {
    var_5 _id_0788::_id_182B([var_3, var_4], var_8, 0, 1, undefined, undefined, undefined, 1);
  } else {
    var_5 _id_0788::_id_182B([var_3, var_4], var_8, 0, 1);
  }
}

_id_905D() {
  self endon("revive_done");
  self endon("disconnect");
  wait 1;
  self _meth_8206();
}

_id_7412(var_0) {
  self notify("handle_stim");
  self endon("handle_stim");
  self waittill("spawn_stim");

  if(isDefined(self._id_C7D0)) {
    return;
  }
  var_1 = spawn("script_model", self gettagorigin("tag_accessory_right"));
  var_1.angles = self gettagangles("tag_accessory_right");
  var_1 setModel("offhand_wm_stim");
  var_1 linkto(self, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  self._id_C7D0 = var_1;
  scripts\engine\utility::_id_10888(self, "remove_stim", self, "revive_done", self, "revive_teammate", self, "disconnect", self, "last_stand", var_0, "disconnect", var_0, "entered_spectate");

  if(isDefined(var_1)) {
    var_1 delete();
  }

  self._id_C7D0 = undefined;
}

_id_63E5(var_0, var_1) {
  var_2 = self getstance();
  var_3 = [var_2 + "_1", var_2 + "_2", var_2 + "_3", var_2 + "_4", var_2 + "_6", var_2 + "_7", var_2 + "_8", var_2 + "_9"];
  var_4 = [];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = _id_6579(var_0, var_3[var_5]);

    if(isDefined(var_6)) {
      var_4[var_4.size] = var_6;
    }
  }

  if(var_4.size < 1) {
    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      var_6 = _id_6579(var_0, var_3[var_5], 1);

      if(isDefined(var_6)) {
        var_4[var_4.size] = var_6;
      }
    }
  }

  return scripts\engine\utility::_id_6969(self.origin, var_4);
}

_id_6579(var_0, var_1, var_2) {
  var_3 = level._id_CC31["ls_revive_helper"]["in_" + var_1];
  var_4 = spawnStruct();
  var_4.origin = getstartorigin(var_0.origin, var_0.angles, var_3);
  var_4.angles = _func_00D2(var_0.origin, var_0.angles, var_3);
  var_5 = _func_040B(var_0.origin, var_0.angles, var_3);
  var_6 = _func_040C(var_0.origin, var_0.angles, var_3);
  var_4._id_10FD2 = var_1;
  var_4._id_10FD3 = level._id_CC32["ls_revive_helper"]["in_" + var_1];
  var_7 = self.origin + (0, 0, 20);
  var_8 = physics_createcontents(["physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot"]);

  if(!istrue(var_2)) {
    var_9 = scripts\engine\trace::_id_B609(var_7, var_4.origin + (0, 0, 20), self.angles, [self, var_0]);
    var_10 = scripts\engine\trace::_id_B609(var_7, var_5 + (0, 0, 20), var_6, [self, var_0]);

    if(!var_9 || !var_10) {
      return undefined;
    }
  }

  return var_4;
}

_id_671E(var_0, var_1) {
  var_2 = ["super_default_zm"];

  if(scripts\engine\utility::array_contains(var_2, var_1.basename)) {
    var_3 = var_0 getweaponslistprimaries();

    if(var_3.size == 0) {
      return makeweapon("s4_knife_eng");
      return;
    }

    return var_3[0];
    return;
  } else
    return var_1;
}

no_hope_left(var_0) {
  var_1 = (scripts\cp\utility::_id_89AE() || level._id_AB30) && var_0 _id_75AE();
  var_2 = !_id_56CD(var_0) || var_0 _id_75AE();
  return !var_2 && !var_1;
}