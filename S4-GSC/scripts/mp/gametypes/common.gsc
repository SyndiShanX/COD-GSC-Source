/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\common.gsc
*************************************************/

_id_D85A() {
  level._id_AB3F = ::_id_AA89;
  level._id_ABB3 = ::_id_AA8A;
  level._id_ABB9 = ::_id_AA8B;
  level._id_E356 = undefined;
  _id_0A97::_id_C28A(::_id_AB6C);
  scripts\mp\utility\game::_id_C250(scripts\mp\utility\game::getgametype(), 0);
  level._effect["cranked_explode"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
}

_id_FC39() {
  level._id_4CE9 = scripts\mp\utility\dvars::_id_509C("dogtags", 0, 0, 1);
  level._id_DCA1 = scripts\mp\utility\dvars::_id_509C("enemyDeathLoc", 0, 0, 3);

  if(level._id_4CE9) {
    scripts\mp\gametypes\obj_dogtag::init();
  }

  level._id_A2B2 = scripts\mp\utility\game::getgametype() == "hvt" || scripts\mp\utility\dvars::_id_6BFD(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_inGameLoot"), "#x32e44d746af5106c7");

  if(level._id_A2B2) {
    scripts\mp\gametypes\plunder::init();
  }
}

_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0;

  if(scripts\mp\utility\game::_id_8A95() && _id_07D1::_id_60BE("prematch_done")) {
    level thread _id_081F::_id_E35E(var_0, var_1, "new_trigger_spawned", var_3);
  }

  if(isbot(self) && isDefined(self._id_878C)) {
    self._id_878C = undefined;
  }

  if(istrue(level._id_5CD3)) {
    _id_07D2::_id_5CC9(var_1, var_0, gettime(), "kill_by_" + var_1.team);
  }

  var_7 = scripts\mp\utility\game::_id_8902() && istrue(var_0._id_B6BF);

  if(!var_7 && var_1.team != self.team) {
    var_8 = level._id_CC0E["death"] * -1;

    if(var_8 != 0) {
      if(level.teambased && !killstreakweapononlycheckfailed(var_5)) {
        level scripts\mp\gamescore::_id_7001(var_0.pers["team"], var_8, 0);
      } else {
        var_1 scripts\mp\gamescore::_id_6FCF("kill", var_8);
      }
    }

    var_6 = level._id_CC0E["kill"];

    if(istrue(var_5)) {
      var_6 = var_6 + level._id_CC0E["kskill"];
    }

    if(var_3 == "MOD_HEAD_SHOT") {
      var_6 = var_6 + level._id_CC0E["headshot"];
    }

    if(level._id_4CE9 && _id_07D1::_id_60BE("prematch_done")) {
      level thread scripts\mp\gametypes\obj_dogtag::_id_E298(var_0, var_1, "new_tag_spawned", var_3);
    }

    if(level._id_A2B2) {
      level thread scripts\mp\gametypes\plunder::_id_5050(var_0, var_1);
    }
  }

  if(istrue(level._id_EB99)) {
    if(scripts\mp\utility\game::matchmakinggame() && isDefined(var_1._id_3E59)) {
      if(!var_7) {
        var_6 = var_6 + 1;
        var_1 thread scripts\mp\rank::_id_CC00("teamscore_notify_" + var_6);
      }
    }

    var_1 _id_07C1::_id_AA91(var_0, var_1, var_2);
  }

  if(var_6 != 0) {
    if(level.teambased && !killstreakweapononlycheckfailed(var_5)) {
      level scripts\mp\gamescore::_id_7001(var_1.pers["team"], var_6, 0);
    } else {
      var_1 scripts\mp\gamescore::_id_6FCF("kill", var_6, var_0);
    }
  }
}

killstreakweapononlycheckfailed(var_0) {
  if(scripts\mp\utility\game::getgametype() == "kspoint") {
    if(!istrue(var_0)) {
      return 1;
    }
  }

  return 0;
}

_id_AA8A(var_0) {
  if(istrue(level._id_EB99)) {
    var_0 _id_07C1::_id_387A();
  }

  if(isDefined(level._id_CC0E)) {
    var_1 = level._id_CC0E["death"] * -1;

    if(var_1 != 0) {
      if(level.teambased) {
        level scripts\mp\gamescore::_id_7001(var_0.pers["team"], var_1, 0);
      }
    }
  }

  if(scripts\mp\utility\game::_id_8A95() && _id_07D1::_id_60BE("prematch_done")) {
    if(level.teambased) {
      level thread _id_081F::_id_E35E(var_0, var_0, "new_trigger_spawned", "MOD_SUICIDE");
    }
  }

  if(level._id_A2B2) {
    level thread scripts\mp\gametypes\plunder::_id_5050(var_0, undefined);
  }

  if(isDefined(level._id_9FE9)) {
    [[level._id_9FE9]](var_0);
  }
}

_id_AA8B(var_0) {
  if(istrue(level._id_EB99)) {
    var_0 _id_07C1::_id_387A();
  }

  if(isDefined(level._id_9FEA)) {
    [[level._id_9FEA]](var_0);
  }
}

_id_4CE4(var_0) {}

_id_4CE5(var_0) {}

_id_ABA5() {
  if(istrue(game["inLiveLobby"])) {
    var_0 = istrue(level._id_15CA) && istrue(level._id_E357);
    thread _id_9A2F(var_0);
  } else if(istrue(level._id_E357) && _id_07D1::_id_60BE("prematch_done")) {
    if(isDefined(level._id_E356)) {
      if([[level._id_E356]]()) {
        thread _id_9A2F(1);
      }
    } else
      thread _id_9A2F(1);
  }

  if(scripts\mp\utility\game::_id_8A95()) {
    thread _id_081F::_id_FD13();
  }

  self _meth_86CC();

  if(istrue(level._id_4ACD)) {
    self allowmountside(0);
    self allowmounttop(0);
  }

  if(isDefined(level._id_9FE8)) {
    [[level._id_9FE8]]();
  } else {
    thread _id_FCC3();
  }

  if(scripts\mp\utility\game::_id_6A65() != 0) {
    _id_FBF8();
  }

  if(istrue(game["practiceRound"])) {
    if(istrue(level._id_DFBF)) {
      thread _id_DFC0();
    } else {
      self sethudtutorialmessage("MP_INGAME_ONLY/PRACTICE_ROUND");
    }
  } else
    self clearhudtutorialmessage();
}

_id_A7BC(var_0) {
  self endon("disconnect");
  self notify("nvg_spawn_tutorial");
  self endon("nvg_spawn_tutorial");
  var_1 = 1;

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  for(;;) {
    if(var_1) {
      self waittill("giveLoadout");
    } else {
      self waittill("spawned");
    }

    if(var_0 < 2) {
      if(self usinggamepad()) {
        var_2 = 32;
      } else {
        var_2 = 33;
      }

      if(_id_07D1::_id_60BE("infil_will_run") && !_id_07D1::_id_60BE("prematch_done")) {
        level waittill("prematch_done");
        wait 5;
        _id_0A99::_id_D5EA(var_2);
        wait 5;
        _id_0A99::_id_D5EA(0);
      } else {
        if(!var_0) {
          wait 5;
        }

        _id_0A99::_id_D5EA(var_2);
        wait 5;
        _id_0A99::_id_D5EA(0);
      }

      var_0++;
      continue;
    }

    break;
  }
}

_id_AB71(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(scripts\mp\utility\game::_id_6A65() != 0) {
    _id_FBF8();
  }

  if(scripts\mp\utility\game::_id_8902() && istrue(self.inlaststand) && scripts\mp\utility\game::getgametype() != "br") {
    _id_AA89(self, var_1, var_9, var_3, var_4, var_10);
  }

  if(isDefined(level._id_AB70)) {
    [[level._id_AB70]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }
}

_id_AB5C() {
  for(;;) {
    level waittill("connected", var_0);

    if(isDefined(level.onplayerconnect)) {
      level thread[[level.onplayerconnect]](var_0);
    }

    if(getdvarint("#x359bf4722cdf0bcc", 0)) {
      var_0 _id_078A::_id_2F99();
    }

    if(scripts\cp_mp\utility\game_utility::isnightmap()) {
      var_0 thread _id_A7BC();
    }

    var_1 = !scripts\mp\utility\game::privatematch() && getdvarint("#x3a9c4045693a5c72b", 0);

    if(var_1) {
      var_0 setplayerdata("common", "numCapturedLoadouts", 0);
    }
  }
}

_id_AB64(var_0) {
  if(scripts\mp\utility\game::_id_6A65() != 0) {
    var_0 _id_FBF8();
  }

  if(isDefined(level._id_AB63)) {
    var_0 thread[[level._id_AB63]](var_0);
  }
}

_id_AB6C(var_0) {
  if(isDefined(level._id_AB6B)) {
    [[level._id_AB6B]](self);
  }

  if(istrue(level._id_4CE9)) {
    scripts\mp\gametypes\obj_dogtag::_id_AB69(var_0);
  }

  if(istrue(level._id_FEF8)) {
    scripts\mp\gametypes\obj_zonecapture::_id_AB69(var_0);
  }

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    var_0 thread _id_A7BC(1);
  }
}

_id_9A2F(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("remove_spawn_protection");
  thread _id_19EA();

  if(var_0) {
    wait(level._id_E357);
  }

  thread _id_C523();
}

_id_19EA() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("remove_spawn_protection");
  self waittill("spawned_player");
  self._id_E355 = 1;
  _id_07EA::_id_D5E2(self, 1000, undefined, 0);
}

_id_C523() {
  self endon("disconnect");

  if(isDefined(self)) {
    self._id_E355 = 0;
  }

  _id_07EA::_id_9455(self);
  self notify("remove_spawn_protection");
}

_id_FBF8() {
  if(isDefined(level._id_FBF8)) {
    self[[level._id_FBF8]]();
  } else {
    if(scripts\mp\utility\game::getgametype() == "br") {
      var_0 = 0;

      foreach(var_2 in level._id_EF89) {
        var_0 = var_0 + scripts\mp\utility\teams::_id_6DCA(var_2, "aliveCount");
      }

      setomnvar("ui_allies_alive", 0);
      setomnvar("ui_axis_alive", var_0);
      return;
    }

    setomnvar("ui_allies_alive", scripts\mp\utility\teams::_id_6DCA("allies", "aliveCount"));
    setomnvar("ui_axis_alive", scripts\mp\utility\teams::_id_6DCA("axis", "aliveCount"));
  }
}

_id_FCC3() {
  level endon("game_ended");
  self setclientomnvar("ui_match_status_hint_text", 0);
}

_id_5A07() {
  wait 1;

  if(isDefined(self)) {
    scripts\mp\hud_message::_id_DCA2("MP/FRIENDLY_FIRE_WILL_NOT");
  }
}

_id_DFC0() {
  self endon("death");

  if(!_id_07D1::_id_60BE("prematch_done")) {
    thread scripts\mp\utility\print::_id_F8D0("MP_INGAME_ONLY/PRACTICE_ROUND", 5);
    wait 6;
    _id_07D1::_id_60C2("prematch_done");
    thread scripts\mp\utility\print::_id_F8D0("MP_INGAME_ONLY/SNOWBALL_FIGHT", 5);
  } else
    thread scripts\mp\utility\print::_id_F8D0("MP_INGAME_ONLY/SNOWBALL_FIGHT", 5);
}