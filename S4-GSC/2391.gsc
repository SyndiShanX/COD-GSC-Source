/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2391.gsc
*************************************************/

_id_DDDE(var_0, var_1, var_2) {
  var_3 = newclienthudelem(self);
  var_3.x = 0;
  var_3.y = 0;
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.sort = 1;
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3._id_01D6 = 1;

  if(isDefined(var_0) && var_0 > 0) {
    var_3.alpha = 0;
  } else {
    var_3.alpha = 1;
  }

  var_3 setshader("black", 640, 480);

  if(isDefined(var_0) && var_0 > 0) {
    self notify("fadeDown_start");
    var_3 fadeovertime(var_0);
    var_3.alpha = 1.0;
    wait(var_0);
    self notify("fadeDown_complete");
  }

  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  self notify("fadeUp_start");

  if(!isDefined(var_2)) {
    var_2 = 0.5;
  }

  if(var_2 > 0) {
    var_3 fadeovertime(var_2);
    var_3.alpha = 0.0;
    wait(var_2);
  }

  self notify("fadeUp_complete");

  if(isDefined(var_3)) {
    var_3 destroy();
  }
}

_id_8D02() {
  _id_0743::_id_E879();
  level._id_1674 = 1;

  foreach(var_1 in level.agentarray) {
    if(!istrue(var_1.isactive)) {
      continue;
    }
    var_1._id_A546 = 1;
    var_1 dodamage(var_1.health + 1000, var_1.origin, undefined, undefined, "MOD_EXPLOSIVE", "iw8_la_rpapa7_mp_friendly");
  }

  level._id_1674 = 0;
}

_id_C2D3(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_0 endon("disconnect");
  var_0 disableweapons();
  var_0 scripts\cp\utility::_id_5F63(1);
  var_0 setclientomnvar("ui_hide_hud", 1);
  var_4 = newclienthudelem(var_0);
  var_4.x = 0;
  var_4.y = 0;
  var_4 setshader("black", 640, 480);
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.sort = 1;
  var_4.horzalign = "fullscreen";
  var_4.vertalign = "fullscreen";
  var_4.alpha = 1;
  var_4._id_01D6 = 1;
  level waittill(var_1);
  var_0 thread _id_DC64(var_2);
  level waittill(var_3);
  var_0 setclientomnvar("ui_chyron_on", 0);
  var_0 setclientomnvar("ui_hide_hud", 0);
  var_0 scripts\cp\utility::_id_5F63(0);
  var_0 enableweapons();
  var_4 fadeovertime(2);
  var_4.alpha = 0.5;
  wait 2;
  var_4 destroy();
}

_id_F2CE(var_0) {
  if(istrue(var_0)) {
    level._id_4A0B = 1;
    level._id_4CE0 = 1;
    level._id_4A26 = 1;
    level._id_E30B = 1;
  } else {
    if(!istrue(level._id_C307)) {
      level._id_4A0B = 0;
      level._id_4CE0 = 0;
    }

    level._id_4A26 = 0;
    level._id_E30B = 0;
  }

  if(var_0) {
    level thread _id_0739::_id_F2E3(0);
    level._id_BA32 = ::_id_BA32;
  } else {
    level thread _id_0739::_id_F2E3(1);
    level._id_BA32 = undefined;
  }

  foreach(var_2 in level.players) {
    var_2 _id_F2C8(var_0);
  }
}

_id_F2C8(var_0) {
  var_1 = self;

  if(var_0) {
    var_1 _meth_84AC("safe", "iw8_ges_demeanor_safe");
    var_1 thread _id_103D6();
    var_1 disableweaponswitch();
    var_1 disableoffhandweapons();
    var_1 allowmelee(0);
    var_1 _meth_86CD(0);
    var_1 allowsprint(0);
    var_1 allowads(0);
    var_1 allowcrouch(0);
    var_1 allowprone(0);
    var_1 allowmantle(0);
    var_1 allowjump(0);
    var_1 setclientomnvar("ui_briefing", 1);
    var_1._id_15AF = 0;
    var_1.ignoreme = 1;
  } else {
    var_1 notify("normal_demeanor");
    var_1 _meth_84AC("normal");
    var_1 enableweaponswitch();
    var_1 enableoffhandweapons();
    var_1 allowmelee(1);
    var_1 _meth_86CD(1);
    var_1 allowsprint(1);
    var_1 allowads(1);
    var_1 allowcrouch(1);
    var_1 allowprone(1);
    var_1 allowmantle(1);
    var_1 allowjump(1);
    var_1 setclientomnvar("ui_briefing", 0);
    var_1._id_15AF = 1;
    var_1.ignoreme = 0;
  }
}

_id_103D6() {
  self endon("normal_demeanor");
  self notify("viewmodel_demeanor");
  self endon("viewmodel_demeanor");

  for(;;) {
    self waittill("loadout_given");
    wait 2;

    if(istrue(self._id_15AF)) {
      self _meth_84AC("normal");
      continue;
    }

    self _meth_84AC("safe", "iw8_ges_demeanor_safe");
  }
}

_id_5103(var_0) {
  level endon("game_ended");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  var_1 scripts\cp\utility::_id_D5A6(undefined, "HINT_BUTTON", undefined, &"CP_DWN_TWN_OBJECTIVES/DWN_TWN_LOADOUT", 25, "duration_short", "hide", 256, 65, 64, 65);
  var_1._id_75E9 = _func_0353(var_1);
  _func_0355(var_1._id_75E9, "hud_icon_survival_weapon");
  _func_035B(var_1._id_75E9, 0);
  _func_035A(var_1._id_75E9, 1024);
  _func_0359(var_1._id_75E9, 30);
  _func_035D(var_1._id_75E9, 10);

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(!var_2 scripts\cp\utility::_id_8708()) {
      continue;
    }
    var_2 thread _id_5102(var_1);
  }
}

_id_5102(var_0) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  var_0 disableplayeruse(self);
  self setclientomnvar("cp_open_cac", -1);
  self setclientomnvar("ui_options_menu", 2);
  scripts\engine\utility::waittill_any_2("loadout_given", "loadout_menu_closed");
  wait 1;
  self setclientomnvar("cp_open_cac", -2);
  var_0 _meth_80E0(self);
}

_id_9F91(var_0) {
  for(;;) {
    self waittill("trigger", var_1);

    if(!var_1 scripts\cp\utility::_id_8708()) {
      continue;
    }
    self makeunusable();
    _id_0720::_id_E88B();
    thread _id_C9E0(var_0);
    level notify("mission_selected", var_0);
    self._id_FE3A = 1;
    return;
  }
}

_id_C9E0(var_0) {
  scripts\engine\utility::delaythread(2, _id_0748::_id_C9E7, var_0, "primary");
}

_id_CADE(var_0) {
  foreach(var_4, var_2 in level.players) {
    var_3 = 0;

    if(_id_073B::_id_B4EF(var_2)) {
      var_3 = 1;
    }

    var_2 thread _id_B54E(var_0, var_4, var_3);
  }
}

_id_B54E(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0[var_1].angles = scripts\engine\utility::ter_op(isDefined(var_0[var_1].angles), var_0[var_1].angles, (0, 0, 0));
  self._id_C67C = var_0[var_1].origin;
  self._id_C67B = var_0[var_1].angles;

  if(istrue(var_2)) {
    _id_073B::_id_8302(self);
  }

  if(isDefined(self._id_4205)) {
    self._id_4205 notify("kill_turret", 0, 0);
  }

  if(isDefined(level._id_36AE)) {
    foreach(var_4 in level._id_36AE) {
      var_4 _id_09AD::_id_3697(0, 0);
    }
  }

  if(isDefined(self._id_781A)) {
    self._id_781A _id_09B5::_id_786C(0);
  }

  if(istrue(self isonladder())) {
    self setorigin(getgroundposition(self.origin + anglesToForward(self.angles) * -50, 16));
    wait 0.1;
  }

  var_6 = scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_6)) {
    var_7 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A6(var_6, self);
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_10182(var_6, var_7, self, undefined, 1);
  }

  self setorigin(var_0[var_1].origin);
  self setplayerangles(var_0[var_1].angles);
}

_id_A75E(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    foreach(var_3 in level.players) {
      if(var_3 istouching(var_0)) {
        var_1++;
      }
    }
  }

  return var_1;
}

_id_CADD(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  while(var_2 < 31) {
    var_4 = _id_A75E(var_0);
    var_5 = _id_6702();

    if(var_4 && var_5.size == 0) {
      level notify("player_entered_safehouse_vol");

      if(var_4 == level.players.size) {
        if(!var_3) {
          thread scripts\cp\utility::_id_A8D1("safehouse_return_timer", 6, undefined, undefined, 1, undefined, 1, 1);
          var_3 = 1;
          var_2 = int(max(var_2, 25));
        }
      } else if(!var_3) {
        thread scripts\cp\utility::_id_A8D1("safehouse_return_timer", 30, 20, 10, 1, undefined, 1, 1);
        var_3 = 1;
      }

      var_2++;
    } else {
      if(var_3) {
        _id_0748::_id_9905("safehouse_return_timer");
        thread scripts\cp\utility::_id_A8D1("safehouse_return");
        var_3 = 0;
      }

      var_2 = 0;
    }

    wait 1;
  }

  if(isDefined(var_1) && scripts\engine\utility::_id_5C0C(var_1)) {
    scripts\engine\utility::_id_5C1B(var_1);
  }
}

_id_6702() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(istrue(var_2._id_BECE) || istrue(var_2 _meth_86B8()) || istrue(var_2 isskydiving()) || istrue(self._id_8A07) || istrue(self._id_24C7)) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

_id_CAD0(var_0) {
  foreach(var_2 in var_0) {
    var_2 thread scripts\cp\utility::_id_3F0E();
  }
}

_id_F2CD(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _func_03C0("scriptable_" + var_3, var_4, var_1, var_2);

  foreach(var_7 in var_5) {
    if(var_7 _meth_872A()) {
      if(var_0) {
        var_8 = 0;
        var_7 _meth_873D();

        while(!var_7 _meth_8728() && var_8 < 10) {
          wait 0.1;
          var_8++;
        }

        var_7 _meth_8727(1);
        continue;
      }

      var_7 _meth_8727(0);
    }
  }
}

_id_10705(var_0, var_1, var_2, var_3) {
  var_4 = _func_03C0("scriptable_" + var_2, var_3, var_0, var_1);

  foreach(var_6 in var_4) {
    if(var_6 _meth_872A()) {
      var_6 thread _id_1072B();
    }
  }
}

_id_1072B() {
  while(self _meth_8728()) {
    wait 1;
  }

  level notify("safehouse_door_opened");
}

_id_B299(var_0) {
  var_1 = [];
  var_2 = [];
  var_1[var_1.size] = "dx_cps_kama_convo_start_10";
  var_1[var_1.size] = "dx_cps_kama_convo_start_20";
  var_1[var_1.size] = "dx_cps_kama_convo_start_30";
  var_2[var_2.size] = "dx_cps_lass_convo_start_10";
  var_2[var_2.size] = "dx_cps_lass_convo_start_20";
  var_2[var_2.size] = "dx_cps_lass_convo_start_30";
  var_3 = undefined;

  if(isDefined(var_0)) {
    if(var_0 == "kama") {
      var_3 = scripts\engine\utility::random(var_1);
    } else if(var_0 == "lass") {
      var_3 = scripts\engine\utility::random(var_2);
    }
  } else if(scripts\engine\utility::cointoss())
    var_3 = scripts\engine\utility::random(var_1);
  else {
    var_3 = scripts\engine\utility::random(var_2);
  }

  level _id_076F::_id_F730(var_3, "allies");
  _id_B295(undefined, "conv_generic_reply");
}

_id_B295(var_0, var_1) {
  var_2 = scripts\cp\utility::_id_6C61("allies");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_3[var_3.size] = var_5;
    }
  }

  var_7 = scripts\engine\utility::random(var_3);

  if(isDefined(var_0)) {
    var_7 = var_0;
  }

  var_8 = level _id_0750::_id_F759(var_7, var_1);

  if(_func_0110(var_8)) {
    wait(var_8);
  }

  wait(0.4 + randomfloat(0.4));
}

_id_CAD4() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_0);

    if(istrue(level._id_E30B)) {
      var_0 thread _id_CAE0();
    }
  }
}

_id_CAE0() {
  self endon("disconnect");
  var_0 = self;
  var_1 = 0;

  for(;;) {
    if(isDefined(level._id_4198)) {
      foreach(var_3 in level._id_4198) {
        if(!scripts\cp\utility::_id_190A(var_3.origin, 64)) {
          if(!isDefined(var_3.angles)) {
            var_3.angles = (0, 0, 0);
          }

          var_0._id_C67C = var_3.origin;
          var_0._id_C67B = var_3.angles;
          var_0 setorigin(var_3.origin);
          var_0 setplayerangles(var_3.angles);
          var_0 dontinterpolate();
          var_0 _id_F2C8(1);
          var_1 = 1;
        }
      }
    }

    if(var_1) {
      return;
    }
    wait 0.05;
  }
}

_id_BA32() {
  self endon("disconnect");
  level endon("game_ended");

  while(isnullweapon(self getcurrentprimaryweapon())) {
    wait 0.05;
  }

  var_0 = self getcurrentprimaryweapon();
  self setspawnweapon(var_0, 1);

  if(istrue(level._id_E30B)) {
    self _meth_84AC("safe", "iw8_ges_demeanor_safe");
    _id_F2C8(1);
    self._id_B532 = 1;
  }
}

_id_DC64(var_0) {
  var_1 = getDvar("#x36d16f02578d0ee10");
  var_2 = "cp/" + var_1 + "_objectives.csv";
  var_3 = int(_func_0222(var_2, 1, var_0, 0));
  self setclientomnvar("ui_hide_hud", 0);
  self setclientomnvar("ui_chyron_mission_index", var_3);
  self setclientomnvar("ui_chyron_on", 1);
  wait 5;
  level notify("regroup_text_done");
}