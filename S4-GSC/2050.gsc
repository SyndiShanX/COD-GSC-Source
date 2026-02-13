/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2050.gsc
*************************************************/

init() {
  level _id_0A9A::_id_C287(::_id_ABD7);
}

_id_F289(var_0) {
  if(!self._id_75B4) {
    return 0;
  }

  var_1 = gettime() + var_0 * 1000;
  var_2 = level._id_90C5[self.pers["team"]];
  var_3 = level._id_10CB5[self.pers["team"]] * 1000;
  var_4 = (var_1 - var_2) / var_3;
  var_5 = _func_0037(var_4);
  var_6 = var_2 + var_5 * var_3;

  if(isDefined(self._id_C6C5)) {
    var_7 = (gettime() - self._id_C6C5) / 1000.0;

    if(self._id_C6C5 < var_2) {
      return 0;
    }
  }

  if(isDefined(self._id_10CB9)) {
    var_6 = var_6 + 50 * self._id_10CB9;
  }

  return (var_6 - gettime()) / 1000;
}

_id_EF7F() {
  var_0 = self.pers["teamkills"];

  if(!isDefined(var_0) || level._id_9C50 < 0 || var_0 <= level._id_9C50) {
    return 0;
  }

  var_1 = var_0 - level._id_9C50;
  return scripts\mp\tweakables::_id_6E14("team", "teamkillspawndelay") * var_1;
}

_id_F287(var_0) {
  if(level._id_7EB0 && !self._id_75B4 || level.gameended) {
    return 0;
  }

  var_1 = 0;

  if(self._id_75B4) {
    var_2 = self[[level._id_AB8C]]();

    if(isDefined(var_2)) {
      var_1 = var_2;
    } else {
      var_1 = getdvarfloat(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_playerrespawndelay"));
    }

    if(var_0 && isDefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"]) {
      var_1 = var_1 + _id_EF7F();
    }

    if(isDefined(self._id_EAF5)) {
      var_1 = var_1 + getdvarfloat(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_suicidespawndelay"));
    }

    if(isDefined(self._id_C6C5) && !isDefined(level._id_E295)) {
      var_3 = (gettime() - self._id_C6C5) / 1000.0;
      var_1 = var_1 - var_3;

      if(var_1 < 0) {
        var_1 = 0;
      }
    }

    if(isDefined(self._id_D6DA)) {
      var_1 = var_1 + level._id_F295;
    }
  }

  var_4 = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_waverespawndelay")) > 0;

  if(var_4) {
    var_1 = _id_F289(var_1);
  }

  if(level._id_7EB0 && !self._id_75B4 || level.gameended) {
    var_1 = 0;
  } else if(getdvarint("#x3caae75b25d1aedb3", 0) == 1) {
    var_1 = 999.0;
  }

  var_1 = getdvarint("#x3675de9a274856337", var_1);
  return var_1;
}

_id_87FE(var_0) {
  return 0;
}

_id_9CCD() {
  if(istrue(level._id_A735)) {
    return 0;
  }

  if(istrue(level._id_1A83)) {
    return 0;
  }

  if(isDefined(self._id_9CCD) && !self._id_9CCD) {
    return 0;
  }

  if(scripts\mp\utility\game::_id_6A65() || isDefined(level._id_4AE8)) {
    if(isDefined(level._id_EFB3) && level._id_EFB3.size == 1 && level.teambased) {
      return 1;
    }

    if(istrue(level._id_4AE8)) {
      if(!_id_87FE(self)) {
        return 0;
      }
    }

    if(istrue(self.pers["teamKillPunish"])) {
      return 0;
    }

    if(self.pers["lives"] <= 0 && scripts\mp\utility\game::_id_60C5()) {
      return 0;
    } else if(scripts\mp\utility\game::_id_60C5()) {
      if(level._id_7EB0 && !self._id_75B4) {
        return 1;
      }

      if(scripts\mp\utility\game::getgametype() == "sd" && !self._id_75B4 && inbotonlymatch()) {
        return 1;
      }

      if(!level._id_7EB0 && !self._id_75B4 && (isDefined(level._id_15BE) && !level._id_15BE)) {
        if(isDefined(self._id_DD2D) && !self._id_DD2D) {
          return 1;
        }

        if(_id_87FE(self)) {
          return 1;
        }

        return 0;
      }
    }
  }

  return 1;
}

_id_E285(var_0) {
  self endon("becameSpectator");

  if(isDefined(level._id_9FEF)) {
    self[[level._id_9FEF]](var_0);
    return;
  }

  if(isDefined(self.pers["next_round_class"]) && !self._id_75B4) {
    self.class = self.pers["next_round_class"];
  }

  if(isDefined(self._id_10848) && self._id_10848) {
    self waittill("okToSpawn");
  }

  if(isDefined(self._id_1176)) {
    _id_07F2::_id_1176(self._id_1176);
    self._id_1176 = undefined;
  }

  if(!_id_9CCD()) {
    waitframe();
    var_1 = self.origin;
    var_2 = self.angles;
    self notify("attempted_spawn");

    if(istrue(self.pers["teamKillPunish"])) {
      self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);
      _id_0A99::_id_D5EA(24);

      if(!self._id_75B4 && self.pers["teamkills"] <= level._id_9C50) {
        self.pers["teamKillPunish"] = 0;
      }
    } else if(scripts\mp\utility\game::isroundbased() && game["finalRound"] == 0 || scripts\mp\utility\game::_id_6A65() != 0 && game["finalRound"] == 0 || istrue(level._id_4AE8)) {
      if(isDefined(self._id_ED4A) && self._id_ED4A) {
        _id_0A99::_id_D5EA(8);
      } else if(istrue(self._id_C7EF) && level._id_EF6A[self.team]["aliveCount"] > 0) {
        _id_0A99::_id_D5EA(64);
      } else if(istrue(self._id_C7EE)) {
        if(isDefined(self._id_F283)) {
          if(isDefined(self._id_BFBD)) {
            _id_0A99::_id_D5EA(25, int(gettime() + self._id_F283 * 1000));
          } else if(!istrue(self._id_5144)) {
            _id_0A99::_id_D5EA(6, int(gettime() + self._id_F283 * 1000));
          }
        } else if(level._id_EF6A[self.team]["aliveCount"] > 0)
          _id_0A99::_id_D5EA(64);
        else {
          _id_0A99::_id_D5EA(2);
        }
      } else if(scripts\mp\utility\game::getgametype() == "siege")
        _id_0A99::_id_D5EA(4);
      else if(istrue(level._id_572B)) {
        _id_0A99::_id_D5EA(26);
      } else {
        _id_0A99::_id_D5EA(2);
      }

      if(!isDefined(self._id_C7EE)) {
        thread _id_C522(3.0);
      }
    }

    if(self.sessionstate != "spectator") {
      var_1 = var_1 + (0, 0, 60);
    }

    if(scripts\mp\utility\player::_id_8ACE()) {
      self._id_E307 = 1;
      self._id_43F8 = self.origin;
      self waittill("stopped_using_remote");
    }

    if(!istrue(level._id_A735)) {
      thread _id_E37D(var_1, var_2);

      if(scripts\mp\utility\game::_id_875D()) {
        self.isspectating = 1;
        self notify("exit_spectate_listener");
        thread scripts\mp\gametypes\arena_evo_tourney::arenatournament_listen_report(1);
      }
    }

    return;
  }

  if(self._id_10849) {
    return;
  }
  self._id_10849 = 1;
  _id_107DC(var_0);

  if(isDefined(self)) {
    self._id_10849 = 0;
  }
}

_id_1094C(var_0) {
  self endon("started_spawnPlayer");

  for(;;) {
    waitframe();

    if(self.team == "spectator" || self.team == "follower") {
      return;
    }
    if(isDefined(self) && (self.sessionstate == "spectator" || !scripts\mp\utility\player::isreallyalive(self))) {
      if(istrue(var_0)) {
        self.pers["teamKillPunish"] = 0;
      }

      self.pers["lives"] = 1;
      thread _id_E285(var_0);
      continue;
    }

    return;
  }
}

_id_107DC(var_0) {
  self endon("disconnect");
  self endon("end_respawn");
  level endon("game_ended");
  self notify("attempted_spawn");

  if(isDefined(level._id_BC70)) {
    [[level._id_BC70]](var_0);
  }

  if(scripts\mp\utility\player::_id_8ACE()) {
    self._id_E307 = 1;
    self._id_43F8 = self.origin;
    self waittill("stopped_using_remote");

    if(istrue(level._id_A735)) {
      return;
    }
  }

  self.wasusingfixeddeathcamera = self _meth_85B8();
  var_1 = 0;

  if(istrue(self.pers["teamKillPunish"])) {
    var_2 = _id_EF7F();

    if(var_2 > 0) {
      _id_0A99::_id_D5EA(65, int(gettime() + var_2 * 1000));
      thread _id_C673(self.origin + (0, 0, 60), self.angles);
      var_1 = 1;
      wait(var_2);
      _id_0A99::_id_D5EA(0);
      self._id_C6C5 = gettime();
    }

    self.pers["teamKillPunish"] = 0;
  } else if(_id_EF7F())
    self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);

  if(!isDefined(self._id_10CB9) && isDefined(level._id_10CB6[self.team])) {
    self._id_10CB9 = level._id_10CB6[self.team];
    level._id_10CB6[self.team]++;
  }

  if(isDefined(self._id_D6DA) && !_id_F299()) {
    _id_0A18::_id_E343(1);
  }

  var_3 = _id_F287(0);
  var_4 = 0.0;

  if(!istrue(level._id_4AE7) && !scripts\mp\utility\game::privatematch()) {
    var_4 = scripts\engine\utility::ter_op(istrue(level._id_DEC6), 1.25, 2.0);
  }

  if(!istrue(level._id_4AE7) && scripts\mp\utility\game::privatematch()) {
    var_4 = scripts\engine\utility::ter_op(istrue(level._id_DEC6), 0.15, 2.0);
  }

  if(istrue(level._id_FECE)) {
    var_4 = 0.5;
  }

  if(level._id_7EB0 && !self._id_75B4 || level.gameended) {
    var_4 = 0;
    var_3 = 0;
  }

  var_5 = 0;

  if(scripts\mp\utility\game::getgametype() == "hq" && isDefined(level._id_110CF) && level._id_110CF._id_ADAE == self.team) {
    var_5 = 1;
  }

  if(!istrue(self._id_DDC1) && isDefined(self._id_8D6D) && !var_5) {
    var_3 = max(var_3 - self._id_8D6D, 0);
    self._id_8D6D = undefined;
  }

  if(isDefined(self._id_D6DA)) {
    var_4 = 0;
    var_3 = 0;
  }

  var_3 = max(var_3, var_4);

  if(_id_07AD::_id_88B6()) {
    var_6 = self _meth_8541();
    var_7 = anglestoup(var_6);
    var_8 = var_7 * 60;
  } else
    var_8 = (0, 0, 60);

  var_9 = istrue(_id_07D1::_id_60BE("prematch_done"));
  var_10 = _id_07D1::_id_60BE("infil_will_run") && !istrue(_id_07D1::_id_60BE("infil_started"));

  if(scripts\mp\utility\game::getgametype() == "arm" && !var_10 && !var_9) {
    var_11 = scripts\mp\gametypes\arm::_id_6B60(self.team);
    var_12 = spawn("script_model", var_11._id_E706);
    var_12 setModel("tag_origin");
    var_12.angles = var_11._id_E67A;
    self cameralinkto(var_12, "tag_origin");
    var_12 moveto(var_11._id_533C, 18);
    var_12 rotateto(var_11._id_52DF, 18);
    _id_07D1::_id_60C2("prematch_done");
    var_9 = 1;
    self _meth_8060();
  } else if(istrue(level._id_8885) && !self._id_75B4) {
    var_9 = 1;
    var_3 = scripts\engine\utility::ter_op(istrue(level._id_DEC6), 1.25, 2.0);
  }

  if(!istrue(level._id_4AE7) && var_9 && !istrue(self._id_DDC7) && !istrue(level._id_FECE) && var_3 > 0) {
    thread _id_0815::_id_E722();
  }

  if(istrue(level._id_FECE) && !isDefined(self._id_D6DA)) {
    if(istrue(self._id_B072) || istrue(self.isredeploying)) {
      self._id_10849 = 0;
      self._id_10CB9 = undefined;
      return;
    }

    _id_0819::_id_1082A(var_3, !istrue(var_9));
  } else if(var_3 > 0) {
    var_13 = 9;

    if(scripts\mp\utility\game::getgametype() == "hq") {
      if(isDefined(level._id_110CF)) {
        if(level._id_110CF._id_ADAE == self.team) {
          _id_0A8D::_id_9137("hp_dead");
          var_13 = 30;

          if(isDefined(self._id_EAF5)) {
            var_3 = var_3 - getdvarfloat("#x371bce0ece575fbaf");
            var_3 = max(0, var_3);
          }
        } else if(isDefined(self._id_EAF5) && getdvarfloat("#x371bce0ece575fbaf") > 0 && level._id_110CF._id_ADAE == "neutral") {
          var_13 = 31;
          self._id_EAF5 = undefined;
        }
      }
    } else if(isDefined(self._id_EAF5) && getdvarfloat(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_suicidespawndelay")) > 0) {
      var_13 = 31;
      self._id_EAF5 = undefined;
    }

    _id_0A99::_id_D5EA(var_13, int(gettime() + var_3 * 1000));

    if(!var_1) {
      thread _id_C673(self.origin + var_8, self.angles);
    }

    var_1 = 1;
    scripts\engine\utility::_id_108AE(var_3, "force_spawn");

    if(!istrue(self._id_10848)) {
      self notify("stop_wait_safe_spawn_button");
    }
  }

  if(_id_A408()) {
    if(!istrue(self._id_10848)) {
      _id_0A99::_id_D5EA(1);
    }

    if(!var_1) {
      thread _id_C673(self.origin + var_8, self.angles);
    }

    var_1 = 1;
    _id_1085B();
  }

  if(!istrue(level._id_4AE7) || scripts\mp\utility\game::getgametype() == "arm") {
    thread _id_0815::_id_534A();
  }

  _id_107E6();

  if(isbot(self)) {
    if(!scripts\mp\bots\bots::_id_280E()) {
      self waittill("bot_ready_to_spawn");
    }
  }

  self._id_10849 = 0;
  _id_0A99::_id_D5EA(0);
  self._id_10CB9 = undefined;
  thread _id_E337(undefined, var_0);
}

_id_DC0E() {
  return 0;
}

_id_BECB() {
  while(!level._id_E48E[self.team][self._id_E496]._id_8874 && !level._id_E48E[self.team][self._id_E496]._id_8A62) {
    waitframe();
  }
}

_id_107E6() {
  while(istrue(self._id_10848)) {
    waitframe();
  }
}

_id_A408() {
  if(scripts\mp\tweakables::_id_6E14("player", "forcerespawn") != 0) {
    return 0;
  }

  if(!self._id_75B4) {
    return 0;
  }

  var_0 = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_waverespawndelay")) > 0;

  if(var_0) {
    return 0;
  }

  if(self._id_109C6) {
    return 0;
  }

  return 1;
}

_id_1085B() {
  self endon("disconnect");
  self endon("end_respawn");
  self.waitingforrespawnbutton = 1;

  for(;;) {
    if(self usebuttonpressed()) {
      self.waitingforrespawnbutton = 0;
      break;
    }

    wait 0.05;
  }
}

_id_C522(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  waittillframeend;
  self endon("end_respawn");
  wait(var_0);
  _id_0A99::_id_D5EA(0);
}

_id_F299() {
  if(!isDefined(self._id_D6DA)) {
    return 0;
  }

  if(isDefined(level._id_31E0) && ![[level._id_31E0]](self)) {
    return 0;
  }

  if(istrue(self._id_B072)) {
    return 0;
  }

  var_0 = getEntArray("care_package", "targetname");

  foreach(var_2 in var_0) {
    if(distancesquared(var_2.origin, self._id_D6DA._id_B7D1) > 4096) {
      continue;
    }
    if(isDefined(var_2.owner)) {
      scripts\mp\hud_message::showsplash("destroyed_insertion", undefined, var_2.owner);
    }

    _id_0A18::_id_E343();
    return 0;
  }

  var_4 = (30, 30, 80);
  var_5 = self._id_D6DA._id_B7D1 - var_4;
  var_6 = self._id_D6DA._id_B7D1 + var_4;
  var_7 = physics_createcontents(["physicscontents_vehicle"]);
  var_8 = [];
  var_9 = _func_02BF(var_5, var_6, var_7, var_8);

  if(isDefined(var_9) && var_9.size > 0) {
    var_10 = 1;

    foreach(var_12 in var_9) {
      var_13 = var_12._id_00EC == "scriptable" || var_12._id_00EC == "worldspawn";

      if(!var_13) {
        var_10 = 0;
        break;
      }
    }

    if(!var_10) {
      return 0;
    }
  }

  var_15 = self._id_D6DA._id_B7D1 + (0, 0, 60);
  var_16 = self._id_D6DA._id_B7D1 + (0, 0, 1);
  var_17 = [];
  var_17[0] = self;
  var_17[1] = self._id_D6DA;
  var_18 = physics_createcontents(["physicscontents_characterproxy", "physicscontents_playerclip", "physicscontents_glass"]);

  if(!scripts\engine\trace::ray_trace_passed(var_15, var_16, var_17, var_18)) {
    return 0;
  }

  var_19 = self._id_D6DA._id_B7D1 + (0, 0, 1);
  var_20 = _func_019A(var_19, self._id_D6DA._id_B7D1 + (0, 0, -16));

  if(var_19[2] == var_20[2]) {
    return 0;
  }

  return 1;
}

_id_C7EB() {
  if(!isDefined(self._id_5EC7)) {
    return 0;
  }

  var_0 = spawnStruct();
  var_0._id_E353 = self._id_5EC7;
  var_0._id_8AEB = 1;
  var_1 = [];
  var_1[0] = self;
  var_2 = scripts\engine\trace::_id_3EE5(1, 1, 1, 0, 0, 1, 1);

  if(!scripts\engine\trace::ray_trace_passed(self._id_5EC7 + (0, 0, 60), self._id_5EC7, var_1, var_2)) {
    var_0._id_8AEB = 0;
    return var_0;
  }

  var_3 = anglesToForward(self.angles);
  var_4 = vectornormalize(var_3) * 5;

  if(!scripts\engine\trace::ray_trace_passed(self._id_5EC7 + var_4, self._id_5EC7 + var_4 - (0, 0, 16), var_1, var_2)) {
    var_0._id_8AEB = 0;
    return var_0;
  }

  var_5 = self._id_5EC7 + (0, 0, 1);
  var_6 = _func_019A(var_5, self._id_5EC7 + (0, 0, -16));

  if(var_5[2] == var_6[2]) {
    var_0._id_8AEB = 0;
    return var_0;
  } else {
    var_0._id_E353 = var_6;
    var_0._id_8AEB = 0;
  }

  self._id_59DF = "crouch";
  var_0._id_8AEB = 1;
  return var_0;
}

_id_E308() {
  self notify("spawningClientThisFrameReset");
  self endon("spawningClientThisFrameReset");
  waitframe();
  level._id_A796--;
}

_id_6C42(var_0) {
  var_1 = spawnStruct();

  if(var_0._id_9688 != "none") {
    var_1._id_034C = var_0._id_9688;
  }

  if(var_0._id_9697 != "none") {
    var_1._id_03B5 = var_0._id_9697;
  }

  var_2 = scripts\mp\teams::_id_69B9();

  if(isDefined(var_2["body"])) {
    var_1._id_25CA = var_2["body"];
  }

  if(isDefined(var_2["head"])) {
    var_1._id_75DA = var_2["head"];
  }

  return var_1;
}

_id_96A6(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    if(isDefined(var_5._id_034C)) {
      var_3[var_3.size] = var_5._id_034C;
    }

    if(isDefined(var_5._id_03B5)) {
      var_3[var_3.size] = var_5._id_03B5;
    }

    if(!istrue(var_2)) {
      self _meth_8527(var_5._id_25CA, var_5._id_75DA, var_1);
    }
  }

  if(var_3.size > 0) {
    self loadweaponsforplayer(var_3, var_1);
  }
}

_id_15E9(var_0) {
  var_1 = [];

  if(isDefined(var_0._id_034C)) {
    var_1[var_1.size] = var_0._id_034C;
  }

  if(isDefined(var_0._id_03B5)) {
    var_1[var_1.size] = var_0._id_03B5;
  }

  if(!self _meth_851A(var_1)) {
    return 0;
  }

  if(!self _meth_853A(var_0._id_25CA)) {
    return 0;
  }

  return 1;
}

_id_6D4A() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  self._id_F1D9 = 0;

  if(getdvarint("#x33b36102d7de7a194", 0) != 0) {
    if(level.gametype == "br") {
      var_3 = _func_00CB("mp_dm_spawn_start");
    } else {
      var_3 = _func_00CB("mp_tdm_spawn_allies_start");
    }

    var_0 = var_3[0];
    var_1 = var_0.origin;
    var_2 = var_0.angles;
    scripts\mp\utility\player::_id_BD21("playerlogic::getSpawnPoint() useProfileSpawn");
  } else if(isDefined(self._id_5EC7)) {
    var_4 = _id_C7EB();

    if(!var_4._id_8AEB && isDefined(self._id_BC5D) && !isDefined(self._id_BFBD)) {
      var_1 = self._id_BC5D;
      scripts\mp\utility\player::_id_BD21("playerlogic::getSpawnPoint() forceSpawnOrigin previous");
    } else {
      var_1 = self._id_5EC7;
      self._id_5EC7 = undefined;
      scripts\mp\utility\player::_id_BD21("playerlogic::getSpawnPoint() forceSpawnOrigin");
    }

    if(isDefined(self._id_5EC2)) {
      var_2 = self._id_5EC2;
      self._id_5EC2 = undefined;
    } else
      var_2 = (0, randomfloatrange(0, 360), 0);

    if(isDefined(self._id_C7E9)) {
      if(_func_01A5(var_1) || !var_4._id_8AEB) {
        var_0 = _id_0818::_id_5B07(self._id_C7E9);
        self._id_C7E9 = undefined;

        if(isDefined(var_0)) {
          var_1 = var_0.origin;
          var_2 = var_0.angles;
          scripts\mp\utility\player::_id_BD21("playerlogic::getSpawnPoint() forceSpawnOrigin reviver failed, buddy spawn");
        }
      } else {
        var_1 = var_4._id_E353;
        scripts\mp\utility\player::_id_BD21("playerlogic::getSpawnPoint() forceSpawnOrigin reviver");
      }
    }
  } else if(isDefined(self._id_D6DA)) {
    var_0 = self._id_D6DA;

    if(!istrue(self._id_D6DA._id_A6C0)) {
      if(istrue(level._id_8885) && istrue(self._id_D6DA._id_8A74) && level.mapname != "mp_aniyah") {
        var_5 = min(level._id_7E22 - self._id_D6DA._id_B7D1[2], level._id_7E22);
        self._id_D6DA._id_B7D1 = self._id_D6DA._id_B7D1 + (0, 0, var_5);
      }

      self._id_F1D9 = 1;
      thread _id_0A8D::_id_9137("ti_spawn");
    }

    foreach(var_7 in level._id_F906) {
      if(distancesquared(var_7.origin, var_0._id_B7D1) < 1024) {
        var_7 notify("damage", 5000, var_7.owner, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, makeweapon("killstreak_jammer_mp"));
      }
    }

    var_1 = self._id_D6DA._id_B7D1;
    var_2 = self._id_D6DA._id_B7CB;
    scripts\mp\utility\player::_id_BD21("playerlogic::getSpawnPoint() self.setSpawnPoint, TI" + !istrue(self._id_D6DA._id_A6C0));
    _id_0A18::_id_E343(0, 1);
    var_0 = undefined;
  } else if(istrue(level._id_FECE) && istrue(_id_07D1::_id_60BE("prematch_done"))) {
    var_0 = _id_0819::_id_6D4A();
    var_1 = var_0.origin;
    var_2 = var_0.angles;
    scripts\mp\utility\player::_id_BD21("playerlogic::getSpawnPoint() level.useSpawnSelection");
  } else {
    var_0 = self[[level._id_6D4A]]();
    var_1 = var_0.origin;
    var_2 = var_0.angles;
    scripts\mp\utility\player::_id_BD21("playerlogic::getSpawnPoint() level.getSpawnPoint");
  }

  var_9 = spawnStruct();
  var_9._id_E342 = var_0;
  var_9._id_E332 = var_1;
  var_9._id_E267 = (0, var_2[1], 0);
  return var_9;
}

_id_E337(var_0, var_1) {
  self endon("disconnect");
  self endon("joined_spectators");
  self notify("spawned");
  self notify("end_respawn");
  self notify("started_spawnPlayer");

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(scripts\mp\utility\game::_id_EF76(self.team) && !_id_07D1::_id_60BE("infil_started") && !isDefined(level._id_2DF4)) {
    self setclientomnvar("ui_options_menu", 2);
  } else if(!isDefined(game["state"]) || game["state"] != "playing") {
    self setclientomnvar("ui_options_menu", 0);
  }

  if(isDefined(self.krampustargetrespawndelay)) {
    wait(self.krampustargetrespawndelay);
    self.krampustargetrespawndelay = undefined;
  }

  if(level.gametype == "base" && isDefined(self._id_E291)) {
    scripts\mp\gametypes\base::resetplayerspawndamage();
  }

  scripts\mp\utility\game::_id_3551();
  self setclientomnvar("ui_hud_shake", 0);
  self._id_8FFF = undefined;
  self._id_CC22 = undefined;
  self._id_3E94 = undefined;

  if(getdvarint("#x3a93070affbb9fe0d") > 1) {
    level thread _id_09BD::_id_D56A(self);
  }

  level._id_A796++;

  if(level._id_A796 > 1) {
    self._id_1084A = 1;
    wait(level._id_5F3A * (level._id_A796 - 1));
  }

  thread _id_E308();
  self._id_1084A = 0;

  if(!isDefined(self.pers["copiedClass"])) {
    var_2 = scripts\mp\class::_id_BB98(self.class, 1);
  } else {
    var_3 = scripts\mp\class::_id_962E(self.class);
    scripts\mp\class::_id_9627(self.pers["copiedClass"], var_3);
    scripts\mp\class::_id_BB99(self.pers["copiedClass"], 1);
    var_2 = self.pers["copiedClass"];
    self.pers["copiedClass"] = undefined;
  }

  var_4 = gettime();
  self._id_E293 = _id_6D4A();
  self.spawnevaluationid = undefined;
  self.spawncriticalfactorbucket = undefined;
  self.spawnpointindex = undefined;

  if(isDefined(self._id_E293) && isDefined(self._id_E293._id_E342)) {
    self.spawnevaluationid = self._id_E293._id_E342._id_567E;
    self.spawncriticalfactorbucket = self._id_E293._id_E342._id_2C7C;
    self.spawnpointindex = self._id_E293._id_E342.index;
  }

  _id_D6DD();
  var_5 = self._id_75B4;
  self._id_EAF5 = undefined;
  self._id_59E0 = undefined;
  self _meth_8736(0);
  self _meth_8851(2, self.team);

  if(!var_0) {
    self._id_8DA5 = [];

    if(!istrue(self._id_82F0)) {
      scripts\mp\utility\player::_id_FD26("playing");
    }

    scripts\mp\utility\player::_id_394E();
    self._id_315D = undefined;
    self.maxhealth = scripts\mp\tweakables::_id_6E14("player", "maxhealth");

    if(istrue(var_1)) {
      var_6 = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveHealth");

      if(!isDefined(var_6)) {
        self.health = getdvarint("#x348fdfb7cf90ff4ec", 50);
      } else {
        self.health = var_6;
      }

      thread _id_A6B3();
    } else
      self.health = self.maxhealth;

    if(istrue(self._id_5FB3)) {
      self._id_5FB3 = undefined;
      thread scripts\mp\gametypes\common::_id_5A07();
    }

    self._id_5FA4 = undefined;
    self._id_E393 = gettime();
    self._id_10A22 = self._id_F1D9;
    self._id_42F6 = [];
    self._id_A8EC = 1;
    self._id_D9D7 = 0;
    self._id_C0FB = 0;
    self._id_C6C5 = undefined;
    self._id_8FDB = undefined;
    self._id_9049 = undefined;
    self._id_8FF7 = undefined;
    self._id_8F9E = undefined;
    self._id_8FB6 = undefined;
    self._id_90A7 = undefined;
    self.firstdamagedeliveredtime = undefined;
    self.firstdamagedeliveredtype = undefined;
    self.firstdamagedeliveredweapon = undefined;
    self.firstdamagereceivedtime = undefined;
    self.firstdamagereceivedtype = undefined;
    self.firstdamagereceivedweapon = undefined;

    if(isDefined(self._id_EA8D) && self._id_EA8D._id_EA8F == self) {
      self._id_EA8D._id_EA8F = undefined;
    }

    self._id_EA8D = undefined;
    self._id_EA8E = undefined;
    self._id_936C = 0;

    if(isDefined(self.pers["deaths"])) {
      self._id_936C = self.pers["deaths"];
    }

    _id_09BF::_id_3935();
    _id_07E7::_id_394D();
  }

  self._id_A25F = 1;

  if(!var_0) {
    self._id_1FAF = 5.0;
    var_7 = self.pers["lives"];

    if(var_7 == scripts\mp\utility\game::_id_6A65() && scripts\mp\utility\game::getgametype() != "control") {
      _id_1163();
    }

    if(var_7) {
      if(scripts\mp\utility\game::getgametype() != "control") {
        self.pers["lives"]--;
      }
    }

    if(!istrue(self._id_7262) && !istrue(self._id_C6A6)) {
      _id_1157();
    }

    if(!var_5 || scripts\mp\utility\game::_id_60C5() || scripts\mp\utility\game::_id_60C5() && level._id_7EB0 && self._id_7555) {
      if(scripts\mp\utility\game::getgametype() == "control" && !istrue(level.suicideteamkilllowerslives) && istrue(self.uncounteddeath)) {} else
        _id_C4AF();
    }

    if(!self._id_10A0A) {
      var_8 = 20;

      if(scripts\mp\utility\game::_id_6DE5() > 0 && var_8 < scripts\mp\utility\game::_id_6DE5() / 4) {
        var_8 = scripts\mp\utility\game::_id_6DE5() / 4;
      }

      if(level._id_7EB0 || scripts\mp\utility\game::_id_6DE6() < var_8 * 1000) {
        self._id_10A0A = 1;
      }
    }
  }

  thread _id_07BC::_id_ABA0();
  var_9 = getDvar("#x3a8ff1255cbaa60fc", "65");

  if(self _meth_8684()) {
    self setclientdvar("#x356e0c9e15809767a", var_9);
  }

  if(isDefined(self._id_E293._id_E342)) {
    if(!istrue(self._id_DB64)) {
      _id_0817::_id_5AA0(self._id_E293._id_E342);
    }

    self._id_904F = gettime();
  } else if(!isDefined(self._id_59DE))
    self._id_904F = gettime();

  self._id_E352 = self._id_E293._id_E332;

  if(var_0 && _id_07D6::_id_F38E()) {
    if(self isonground()) {
      self _meth_8542();
      self._id_E293._id_E332 = self._id_E293._id_E332 - (0, 0, 80);
    }

    var_10 = self _meth_8541();
  }

  _id_081A::_id_D6E2();
  self spawn(self._id_E293._id_E332, self._id_E293._id_E267);
  self setplayerangles((0, self._id_E293._id_E267[1], 0));
  scripts\mp\utility\player::_id_BD21("playerlogic::spawnPlayer() !!!CODE SPAWN!!! @" + self._id_E293._id_E332);

  if(!isDefined(level._id_904D)) {
    level._id_904D = [];
  }

  level._id_904D[self.team] = self._id_E293._id_E332;
  self _meth_85B7(0);
  self._id_0154 = 1023;

  if((var_0 || var_1) && isDefined(self._id_59DF)) {
    self setstance(self._id_59DF);
    self._id_59DF = undefined;
  }

  if(isai(self)) {
    scripts\mp\utility\player::_freezecontrols(1);
  }

  self _meth_8236();

  if(!var_0 && !(scripts\mp\utility\game::getgametype() == "br")) {
    self painvisionon();
  }

  self _meth_876B();
  [[level._id_ABA4]]();
  self _meth_8283();
  var_11 = !var_0 || istrue(self._id_59DE);

  if(var_11) {
    if(isai(self) && isDefined(level._id_279D) && isDefined(level._id_279D["player_spawned"])) {
      self[[level._id_279D["player_spawned"]]]();
    }

    if(isDefined(level._id_9BDA)) {
      [[level._id_9BDA]](self._id_399D, self.team, "SPAWN", self._id_E352[0], self._id_E352[1], self._id_E393);
    }

    if(!isai(self)) {
      if(!isDefined(self.pers["distTrackingPassed"])) {
        thread _id_F378(self._id_E293._id_E332);
      } else {
        var_12 = scripts\mp\persistence::_id_E761("round", "timePlayed", 0);

        if(var_12 - self.pers["afkResetTime"] > 240) {
          self.pers["afkResetTime"] = var_12;
          self.pers["distTrackingPassed"] = undefined;
          self.pers["totalDistTraveledAFK"] = undefined;
          thread _id_F378(self._id_E293._id_E332);
        }
      }
    }
  }

  if(!var_0) {
    _id_06E2::_id_4C2A("callback_on_player_spawned", self);
    self._id_9BC0 = -1;

    if(_id_06E2::is_valid_client(self)) {
      self._id_9BC0 = game["life_count"];
      game["life_count"]++;
    }

    self._id_900E = -1;

    if(getdvarint("#x366fca6702ea24ddf") != 0) {
      setmatchdata("lifeCount", game["life_count"]);
    }
  }

  if(isDefined(self._id_D066)) {
    _id_07A9::_id_9788(self, self._id_D066);
  }

  if(!istrue(self._id_DB64)) {
    self._id_D066 = undefined;
  }

  scripts\mp\equipment::_id_391D();
  scripts\mp\class::_id_D4D3(self.class);

  if(isDefined(level._id_4249)) {
    self[[level._id_4249]](var_0);
  } else {
    scripts\mp\class::_id_6FB1(self.team, self.class, undefined, undefined, var_1 || self._id_936C > 0);
  }

  if(_func_00BE("ui_prematch_period")) {
    thread _id_DCAF();
  }

  if(!istrue(game["isLaunchChunk"])) {
    thread _id_97B3();

    if(level.codcasterenabled && !self _meth_81D3()) {
      thread _id_FC33(self);
    }
  }

  if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] > 0) {
    if(!isDefined(self._id_3805) || !self._id_3805) {
      if(isDefined(self._id_37FF)) {
        self._id_3805 = 1;
      }
    }
  }

  var_13 = !scripts\mp\utility\game::privatematch() && getdvarint("#x3a9c4045693a5c72b", 0);

  if(var_13) {
    self setplayerdata("common", "capturedLoadout", "source", "unused");
  }

  if(getdvarint("#x36c8f5946a1247e70")) {
    scripts\mp\utility\player::setthirdpersondof(1);
  }

  if(isai(self)) {
    scripts\mp\utility\player::_freezecontrols(0);
  }

  scripts\common\utility::_id_157A(0);

  if(istrue(game["inLiveLobby"]) || scripts\mp\utility\game::getgametype() == "br" && !_id_07D1::_id_60BE("prematch_done")) {} else if(!_id_07D1::_id_60BE("prematch_done"))
    _id_15CB(self);
  else {
    var_14 = !self._id_75B4;
    scripts\mp\utility\player::_freezecontrols(0, var_14);
    scripts\mp\utility\player::_id_0BEE(0, var_14);
  }

  if(!istrue(self._id_75B4)) {
    scripts\mp\gamelogic::_id_FCBD();
  }

  self._id_75B4 = 1;
  self.pers["hasSpawned"] = 1;

  if(getdvarint("#x38152736fd83d6b5e", 0) == 1) {
    self disableoffhandweapons();
  }

  waittillframeend;
  self._id_E307 = undefined;
  self._id_46C3 = undefined;

  if(!istrue(level._id_4AE7) && isDefined(self._id_E277) || istrue(level._id_4AE7) && isDefined(self._id_E277) && scripts\mp\utility\game::getgametype() == "arm") {
    self._id_10A1E = var_1;
    self._id_46C3 = 1;
    self notify("spawncamera_start");
  }

  if(!istrue(self._id_46C3)) {
    self notify("spawned_player");
    level notify("player_spawned", self, var_1);
    thread _id_D6D9();
  }

  if(game["state"] == "postgame") {
    scripts\mp\gamelogic::_id_5F64();
  }

  if(_id_07A9::_id_176F() && !var_0) {
    if(_id_07A9::_id_1764()) {
      level._id_E28F = level._id_E28F + 1;
    } else {
      _id_07A9::_id_1766();
    }

    if(_id_07A9::_id_176B(level._id_E28F)) {
      if(isDefined(level._id_E2F4._id_E350)) {
        _id_07A9::_id_176C(self, self._id_E350, level._id_E28F, self._id_E293._id_E342);
        _id_07A9::_id_176E(self._id_E293._id_E342.origin, self.team, self._id_936C, level._id_E28F);
        _id_07A9::_id_176D(self, self._id_E293._id_E342.origin, level._id_E28F);
      }
    }

    self._id_904C = self._id_E293._id_E342;
  }

  if(!istrue(self._id_46C3)) {
    self._id_E293 = undefined;
  }

  if(!isDefined(self._id_C7BC)) {
    thread scripts\mp\class::_id_FC91();
  }

  var_15 = 0;

  if(var_15 || scripts\mp\utility\game::_id_60F7() && scripts\mp\utility\game::_id_9ACA()) {
    self _meth_86B3(1);
    self _meth_86B2(1);
  }

  clearplayercamoscripts();
  thread deathwatcherplayercamoandpersistentvfx();
  thread runplayercamoscripts();
}

_id_97B3() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(_id_07D1::_id_60BE("prematch_done")) {
    return;
  }
  if(isDefined(self._id_413A) && self._id_413A != "juggernaut") {
    scripts\mp\class::loadout_setcodcasterclientloadoutdata(self._id_3808);
  }

  _id_07D1::_id_60C2("prematch_done");

  if(isDefined(self._id_413A) && self._id_413A != "juggernaut") {
    scripts\mp\class::_id_9635(self._id_704A, self._id_3808, self._id_413A);
  }
}

_id_A6B3() {
  waitframe();
  self notify("force_regeneration");
}

_id_D6D9() {
  self endon("disconnect");
  waitframe();
  self setclientomnvar("ui_player_spawned_notify", gettime());
}

_id_B75B(var_0) {
  self allowmovement(var_0);
  scripts\common\utility::_id_153E(var_0);

  if(!(var_0 && scripts\mp\utility\game::_id_875D())) {
    scripts\mp\equipment::allow_equipment(var_0);
  }

  scripts\common\utility::_id_1587(var_0);
  scripts\common\utility::_id_154E(var_0);
  scripts\common\utility::_id_1554(var_0);
  scripts\common\utility::_id_1581(var_0);
  scripts\common\utility::_id_154F(var_0);

  if(!istrue(level._id_4ACD)) {
    scripts\common\utility::_id_1558(var_0);
    scripts\common\utility::_id_1557(var_0);
  }
}

_id_15CB(var_0) {
  var_0[[level._id_BB9F]](0);
  var_0._id_BBAB = 1;
}

_id_3970(var_0) {
  if(istrue(var_0._id_BBAB) && !level.gameended) {
    var_0[[level._id_BB9F]](1);
    var_0._id_BBAB = undefined;
  }
}

_id_10835() {
  level endon("prematch_over");
  self endon("versus_menu_done");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "versus_done") {
      self notify("versus_menu_done");
    }
  }
}

_id_FC33(var_0) {
  var_0 endon("death_or_disconnect");

  for(;;) {
    var_0 _meth_8775();
    var_0 _meth_877C();
    wait 0.05;
  }
}

_id_E37E(var_0) {
  switch (scripts\mp\utility\game::getgametype()) {
    case "base":
      var_1 = getdvarfloat("scr_base_cine_time", 12);
      break;
    default:
      var_1 = 5;
      break;
  }

  self endon("disconnect");

  if(isai(self)) {
    return;
  }
  if(level.splitscreen || self _meth_81E2()) {
    self _meth_82F6("#x38bd4585c77e2050", "0.65");
  } else {
    self _meth_82F6("#x38bd4585c77e2050", "1");
  }

  self setclientomnvar("ui_mapshot_camera", 1);
  self _meth_8577("mapflyover");
  var_2 = scripts\engine\utility::getstructarray("camera_intro", "targetname");

  if(var_2.size == 0 || _id_07D1::_id_60BE("infil_will_run")) {
    self _meth_844E("", 0.75);
    return;
  }

  var_3 = undefined;
  var_4 = undefined;
  _id_D6DD();
  _id_0A99::_id_D5EA(0);
  scripts\mp\utility\player::_id_FD26("spectator");
  self.pers["team"] = "spectator";
  self.team = "spectator";
  scripts\mp\utility\player::_id_394E();
  self._id_5FA4 = undefined;
  _id_C64F();

  foreach(var_6 in level._id_EF89) {
    self _meth_8013(var_6, 0);
  }

  self _meth_8013("freelook", 0);
  self _meth_8013("none", 0);

  if(isDefined(var_2) && var_2.size > 1) {
    var_8 = randomintrange(0, var_2.size - 1);
    var_3 = var_2[var_8];
  } else if(isDefined(var_2))
    var_3 = var_2[0];
  else {}

  var_3._id_5A2F = 1;
  scripts\mp\utility\player::_freezecontrols(1);
  self _meth_8380(var_3.origin, var_3.angles);
  self spawn(var_3.origin, var_3.angles);
  scripts\mp\utility\player::_id_BD21("playerlogic::spawnSpectatorMapCam() !!!CODE SPAWN!!! @" + var_3.origin);

  if(isDefined(level._id_84D1)) {
    self visionsetnakedforplayer(level._id_84D1, 0);
  }

  var_9 = spawn("script_model", var_3.origin);
  var_9 setModel("tag_origin");
  var_9.angles = var_3.angles;
  thread _id_10835();

  if(isDefined(var_0) && var_0 == 99) {
    var_10 = "debug";
  } else if(_id_07D1::_id_60BE("prematch_done")) {
    var_10 = "prematch_over";
  } else if(self._id_103AC) {
    var_10 = "versus_menu_done";
  } else {
    var_10 = scripts\engine\utility::_id_108A8(2, "versus_menu_done", "prematch_over");
  }

  if(var_10 == "timeout") {
    if(_id_07D1::_id_60BE("prematch_done")) {
      var_10 = "prematch_over";
    } else {
      var_10 = "versus_menu_done";
    }
  }

  if(var_10 == "prematch_over") {
    self _meth_844E("", 0.75);
    return;
  }

  if(self _meth_81E2() && self _meth_81E3()) {
    var_11 = self _meth_81E4();
    var_11 notify("versus_menu_done");
    waitframe();
  }

  self cameralinkto(var_9, "tag_origin", 1);
  var_12 = scripts\cp_mp\utility\game_utility::_id_6B2D();
  self notify("mapCamera_start");

  switch (var_12) {
    case "mp_parkour":
      var_9 _meth_82CC("iw7_mp_intro_camera_parkour");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_frontier":
      var_9 _meth_82CC("iw7_mp_intro_camera_frontier");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_fallen":
      var_9 _meth_82CC("iw7_mp_intro_camera_fallen");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_proto":
      var_9 _meth_82CC("iw7_mp_intro_camera_proto");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_metropolis":
      var_9 _meth_82CC("iw7_mp_intro_camera_metropolis");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_dome_iw":
      var_9 _meth_82CC("iw7_mp_intro_camera_dome_iw");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_breakneck":
      var_9 _meth_82CC("iw7_mp_intro_camera_breakneck");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_desert":
      var_9 _meth_82CC("iw7_mp_intro_camera_desert");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_divide":
      var_9 _meth_82CC("iw7_mp_intro_camera_divide");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_quarry":
      var_9 _meth_82CC("iw7_mp_intro_camera_quarry");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_skyway":
      var_9 _meth_82CC("iw7_mp_intro_camera_skyway");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_rivet":
      var_9 _meth_82CC("iw7_mp_intro_camera_rivet");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_riot":
      var_9 _meth_82CC("iw7_mp_intro_camera_riot");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_dome_dusk":
      var_9 _meth_82CC("iw7_mp_intro_camera_dome_iw");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_geneva":
      var_9 _meth_82CC("iw7_mp_intro_camera_geneva");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_afghan":
      var_9 _meth_82CC("iw7_mp_intro_camera_afghan");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_neon":
      var_9 _meth_82CC("iw7_mp_intro_camera_neon");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_prime":
      var_9 _meth_82CC("iw7_mp_intro_camera_prime");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_flip":
      var_9 _meth_82CC("iw7_mp_intro_camera_flip");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_mansion":
      var_9 _meth_82CC("iw7_mp_intro_camera_mansion");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_marsoasis":
      var_9 _meth_82CC("iw7_mp_intro_camera_marsoasis");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    case "mp_junk":
      var_9 _meth_82CC("iw7_mp_intro_camera_junk");
      self _meth_844E("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      return;
    default:
      break;
  }

  wait 0.25;
  self _meth_844E("", 0.75);
  var_13 = var_3;
  var_4 = scripts\engine\utility::getstruct(var_3.target, "targetname");
  var_14 = 0;

  for(;;) {
    if(!isDefined(var_13._id_E3F7) && isDefined(var_13._id_039B)) {
      if(int(var_13._id_039B) > 0) {
        var_13._id_E3F7 = int(var_13._id_039B);
      }
    }

    if(isDefined(var_13._id_E3F7)) {
      var_15 = 1 / var_13._id_E3F7;
      var_16 = var_15 * distance(var_13.origin, var_4.origin);
    } else
      var_16 = distance(var_13.origin, var_4.origin);

    var_14 = var_14 + var_16;
    var_13._id_4B97 = var_16;
    var_13 = var_4;

    if(isDefined(var_13.target)) {
      var_4 = scripts\engine\utility::getstruct(var_13.target, "targetname");
      continue;
    }

    break;
  }

  var_13._id_5539 = 1;
  var_13 = var_3;
  var_4 = scripts\engine\utility::getstruct(var_3.target, "targetname");

  if(level.gametype == "base") {
    thread scripts\common\infil_ftue::create_base_infil_ftue();
  }

  spectatorcammove(var_9, var_13, var_4, var_14, var_1);

  if(level.gametype == "base" && !_id_07D1::_id_60BE("prematch_waitForPlayers_Complete")) {
    thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 1, 0);
    thread scripts\mp\gametypes\base::base_unfadefromblackafterdelay(5);
  }

  scripts\mp\utility\player::_freezecontrols(0);

  if(isDefined(level._id_45CE)) {
    self visionsetnakedforplayer(level._id_45CE, 0);
  }

  self._id_E68B = var_9;
  self setclientomnvar("ui_mapshot_camera", 0);

  if(level.gametype == "base") {
    scripts\common\infil_ftue::infil_ftue_end();
  }
}

spectatorcammove(var_0, var_1, var_2, var_3, var_4) {
  if(level.gametype == "base" && getdvarint("scr_base_countdown_overrides_cine", 1)) {
    level endon("prematch_waitForPlayers_Complete");
  }

  for(;;) {
    var_5 = var_1._id_4B97 / var_3;
    var_6 = var_5 * var_4;

    if(isDefined(var_2._id_5539)) {
      var_7 = var_6 / 2;
    } else {
      var_7 = 0;
    }

    if(isDefined(var_1._id_5A2F)) {
      var_8 = var_6 / 2;
    } else {
      var_8 = 0;
    }

    var_9 = 0;

    if(scripts\engine\utility::is_equal(var_2._id_CE18, "move_fade")) {
      if(level.gametype == "base") {
        scripts\common\infil_ftue::infil_ftue_next();
      }

      thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 1, var_6);
      var_9 = 1;
    }

    var_0 moveto(var_2.origin, var_6, var_8, var_7);
    var_0 rotateto(var_2.angles, var_6, var_8, var_7);

    if(isDefined(var_2._id_5539)) {
      var_10 = int(var_6 / 2);
      wait(var_10);
      wait(var_10);
    } else
      wait(var_6);

    if(var_9) {
      thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 0, var_6);
    }

    var_1 = var_2;

    if(isDefined(var_1.target)) {
      var_2 = scripts\engine\utility::getstruct(var_1.target, "targetname");
      continue;
    }

    break;
  }

  if(level.gametype == "base") {
    scripts\common\infil_ftue::infil_ftue_end();
  }
}

debugspectatorcam(var_0, var_1, var_2) {
  for(;;) {
    waitframe();
  }
}

_id_E37D(var_0, var_1, var_2) {
  self notify("spawned");
  self notify("end_respawn");
  self notify("joined_spectators");
  level notify("joined_spectators", self);

  if(isDefined(self._id_4411)) {
    var_0 = self._id_4411;
    var_1 = vectortoangles(self.origin - self._id_4411);
  }

  if(isDefined(self._id_E68B) && !isDefined(var_0)) {
    var_0 = self._id_E68B.origin;
    var_1 = self._id_E68B.angles;
    self._id_E68B delete();
  }

  _id_7D7B(var_0, var_1, var_2);
}

_id_C673(var_0, var_1) {
  if(isDefined(self._id_4411)) {
    var_0 = self._id_4411;

    if(isDefined(self._id_4410)) {
      var_1 = self._id_4410;
    } else {
      var_1 = vectortoangles(self.origin - self._id_4411);
    }
  }

  _id_7D7B(var_0, var_1);

  if(self.wasusingfixeddeathcamera) {
    self.wasusingfixeddeathcamera = 0;
    self _meth_85B7(1);
  }
}

_id_7D7B(var_0, var_1, var_2) {
  _id_D6DD();
  var_3 = self.pers["team"];

  if(isDefined(var_3) && (var_3 == "spectator" || var_3 == "follower") && !level.gameended) {
    _id_0A99::_id_D5EA(0);
  }

  scripts\mp\class::_id_961E();
  scripts\mp\utility\player::_id_FD26("spectator");
  scripts\mp\utility\player::_id_394E();
  self._id_5FA4 = undefined;
  _id_C64F();
  _id_081A::_id_D6E2();
  _id_ABA6(var_0, var_1, var_2);

  if(level.teambased && !level.splitscreen && !self _meth_81E2()) {
    scripts\mp\utility\player::_id_D52A();
  }
}

_id_6C50(var_0) {
  if(var_0 < 0) {
    return undefined;
  }

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(level.players[var_1] getentitynumber() == var_0) {
      return level.players[var_1];
    }
  }

  return undefined;
}

_id_ABA6(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1)) {
    self _meth_8380(var_0, var_1);
    self spawn(var_0, var_1);
    scripts\mp\utility\player::_id_BD21("playerlogic::onSpawnSpectator() !!!CODE SPAWN!!! @" + var_0);
    return;
  }

  var_3 = _id_6D6A();

  if(istrue(level._id_FECE)) {
    if(self.sessionteam == "allies") {
      var_3 = level._id_E278["gw_fob_alliesHQ"]["allies"];
    } else if(self.sessionteam == "axis") {
      var_3 = level._id_E278["gw_fob_axisHQ"]["axis"];
    }
  }

  var_4 = 8;

  if(isDefined(level._id_309F) && level._id_309F.size) {
    for(var_5 = 0; var_5 < level._id_308F + 1 && var_5 < var_4; var_5++) {
      if(!isDefined(level._id_309F[var_5]) || !isDefined(level._id_3083[var_5])) {
        continue;
      }
      self _meth_834D(var_5, level._id_309F[var_5], level._id_3083[var_5]);
      level._id_3098[var_5].origin = level._id_309F[var_5];
      level._id_A773[var_5].origin = level._id_309F[var_5];
      level._id_3098[var_5].angles = level._id_3083[var_5];
      level._id_A773[var_5].angles = level._id_3083[var_5];
    }
  } else {
    for(var_5 = 0; var_5 < var_4; var_5++) {
      self _meth_834D(var_5, var_3.origin, var_3.angles);
    }
  }

  self _meth_8380(var_3.origin, var_3.angles);

  if(isDefined(var_2)) {
    self _meth_8013("freelook", 1);
    self _meth_8013("none", 1);
  }

  if(istrue(level._id_8885) && !self._id_75B4) {
    self _meth_8282(var_3.origin);
  }

  self spawn(var_3.origin, var_3.angles);
  scripts\mp\utility\player::_id_BD21("playerlogic::onSpawnSpectator() !!!CODE SPAWN!!! @" + var_3.origin);
}

_id_6D6A() {
  var_0 = getEntArray("mp_global_intermission", "classname");
  var_1 = [];

  if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18())) {
    if(level._id_96CC == "locale_6") {
      var_2 = spawn("script_origin", (25642, -26550, 1818));
      var_2.angles = (14, 101, 0);
      return var_2;
    } else if(level._id_96CC == "locale_3") {
      var_2 = spawn("script_origin", (34440, -18522, 995));
      var_2.angles = (10, 281, 0);
      return var_2;
    }

    var_2 = undefined;

    foreach(var_4 in var_0) {
      if(isDefined(var_4._id_039B) && var_4._id_039B == level._id_96CC) {
        var_2 = var_4;
      }
    }

    if(isDefined(var_2)) {
      return var_2;
    } else {
      foreach(var_4 in var_0) {
        if(!isDefined(var_4._id_039B) || !issubstr(var_4._id_039B, "locale")) {
          var_1[var_1.size] = var_4;
          continue;
        }

        var_4 delete();
      }
    }
  } else if(var_0.size != 1) {
    foreach(var_4 in var_0) {
      if(!isDefined(var_4._id_039B) || !issubstr(var_4._id_039B, "locale")) {
        var_1[var_1.size] = var_4;
        continue;
      }

      var_4 delete();
    }
  } else
    var_1 = var_0;

  var_4 = _id_0817::_id_6D4C(var_1);
  return var_4;
}

_id_E30E(var_0, var_1, var_2) {
  if(_id_0828::_id_86DC()) {
    return;
  }
  self endon("disconnect");
  self notify("spawned");
  self notify("end_respawn");

  if(!isDefined(var_1)) {
    var_1 = "intermission";
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  _id_D6DD();
  _id_0A99::_id_D5EA(0);
  _id_0A99::_id_3959();
  scripts\mp\utility\player::_freezecontrols(1);

  if(var_2) {
    self setclientdvar("#x3acf57c223df6ab1e", 1);
  }

  if(isDefined(level._id_5AA3) && level._id_5AA3 != "none" && isDefined(level._id_9BA5) && scripts\mp\utility\game::_id_10A16() && !istrue(level._id_4CFA)) {
    wait(level._id_9BA5);
  }

  if(!istrue(level._id_4CFA)) {
    scripts\mp\utility\player::_id_FD26(var_1);
  }

  scripts\mp\utility\player::_id_394E();
  self._id_5FA4 = undefined;

  if(!isDefined(var_0)) {
    if(!isDefined(level._id_96CC)) {
      var_3 = getEntArray("mp_global_intermission", "classname");
      var_3 = _id_0818::_id_34F7(var_3);
      var_0 = var_3[0];
    } else
      var_0 = _id_6D6A();
  }

  if(!isDefined(level._id_4241)) {
    self spawn(var_0.origin, var_0.angles);
    scripts\mp\utility\player::_id_BD21("playerlogic::spawnIntermission() !!!CODE SPAWN!!! @" + var_0.origin);
    scripts\mp\utility\player::_id_D52A();
  }

  scripts\mp\utility\player::_freezecontrols(1);
}

_id_E2C1() {
  if(isDefined(level._id_9FF0) && self[[level._id_9FF0]]()) {
    return;
  }
  if(isDefined(level._id_4241) && scripts\mp\utility\game::_id_10A16()) {
    level notify("start_custom_ending");
  }

  if(!istrue(self._id_3C69)) {
    scripts\mp\utility\player::_freezecontrols(1);
  }

  if(istrue(level._id_4CFA)) {
    self notify("spawned");
    scripts\mp\utility\player::_id_394E();
  } else
    _id_E37D();
}

_id_D6DD() {
  _id_09C8::_id_0D89();
  self _meth_83F4("damage_heavy");
  self._id_43F8 = undefined;
}

_id_2F3A(var_0) {
  if(!isDefined(self._id_3B81)) {
    return;
  }
  if(getdvarint("#x366fca6702ea24ddf") != 0) {
    var_1 = _func_00AC("commonMatchData", "player_count_left");
    var_1++;
    setmatchdata("commonMatchData", "player_count_left", var_1);
  }

  if(scripts\mp\utility\killstreak::_id_87C0()) {
    self _meth_850F();
  }

  scripts\common\utility::_id_F73A(level._id_9BB6, var_0);
  var_2 = spawnStruct();
  var_2.player = self;
  var_2.disconnectreason = var_0;
  _id_06E2::_id_4C2A("callback_on_player_disconnect", var_2);
  _id_C50B();
  _id_0817::_id_C4B0();
  _id_0817::_id_C4A7();
  scripts\cp_mp\utility\player_utility::_id_C4A8();
  var_3 = self getentitynumber();

  if(!level.teambased) {
    game["roundsWon"][self.guid] = undefined;
  }

  if(level.splitscreen) {
    var_4 = level.players;

    if(var_4.size <= 1) {
      level thread scripts\mp\gamelogic::forceend();
    }
  }

  if(isDefined(self._id_0267) && isDefined(self._id_0157)) {
    if(scripts\mp\utility\game::_id_875E() && 3 > self._id_F242["total"]) {
      if(!isDefined(self._id_1A9F)) {
        return;
      }
      var_5 = self._id_1A9F;
      _func_01ED(self, self._id_399D, var_5);
    } else if(120 < self._id_F242["total"]) {
      var_6 = (self._id_0267 - self._id_0157) / (self._id_F242["total"] / 60);
      _func_01ED(self, self._id_399D, var_6);
    }
  } else {}

  var_7 = self getentitynumber();
  var_8 = self.guid;
  _func_0140("Q;" + var_8 + ";" + var_7 + ";" + self.name + "\n");

  if(_func_0391()) {
    _func_038F("Q;" + var_8 + ";" + var_7 + ";" + self.name + "\n");
  }

  thread _id_07CE::_id_4B17();

  if(level.gameended) {
    scripts\mp\gamescore::_id_C490();
  }

  if(isDefined(self.team)) {
    _id_C4BD();
  }

  scripts\cp_mp\utility\weapon_utility::_id_3955(self);

  if(isDefined(self.team) && isDefined(self._id_E496) && self.team != "spectator" && self.team != "follower") {
    _id_07F2::_id_916A(self.team, self._id_E496);
  }

  if(self.sessionstate == "playing" && !(isDefined(self._id_59E0) && self._id_59E0)) {
    _id_C4A4(1);
  } else if(self.sessionstate != "playing" && (scripts\mp\gametypes\br_public::_id_8B00(self) || scripts\mp\gametypes\br_public::_id_890F(self) || scripts\mp\gametypes\br_public::_id_8A02(self))) {
    _id_C4A4(1);
  } else if(self.sessionstate == "intermission" && isDefined(self.team) && scripts\engine\utility::array_contains(level._id_EF6A[self.team]["alivePlayers"], self)) {
    _id_C4A4(1);
  } else if(self.sessionstate == "spectator" || self.sessionstate == "dead") {
    level thread[[level._id_FC75]]();
  }

  if(isDefined(self.team)) {
    scripts\mp\utility\teams::_id_FF42("disconnect", self.team, self);
  }

  _id_0A8E::_id_CA31(self);
  scripts\mp\gamelogic::_id_FCBC();
}

_id_C50B() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(level.players[var_1] == self) {
      for(var_0 = 1; var_1 < level.players.size - 1; var_1++) {
        level.players[var_1] = level.players[var_1 + 1];
      }

      level.players[var_1] = undefined;
      break;
    }
  }

  if(!isbot(self)) {
    level._id_B687[self getentitynumber()] = undefined;
  }

  level._id_B78E[self getentitynumber()] = undefined;
}

_id_8163() {
  if(level.splitscreen || self _meth_81E2()) {
    self _meth_82F6("#x38bd4585c77e2050", "0.75");
    setDvar("#x39e121f7b6097fb74", 0);
  } else
    self _meth_82F6("#x38bd4585c77e2050", "1");
}

_id_8162() {
  setDvar("#x374e27e8df3d55867", 1);
  setDvar("#x396e27990abf87bd5", 1);

  if(level._id_74C4) {
    setDvar("#x374e27e8df3d55867", 0);
    setDvar("#x396e27990abf87bd5", 1);
  }

  if(isDefined(level._id_1658) && level._id_1658) {
    setDvar("#x379a74717c4043423", 1);
  } else {
    setDvar("#x379a74717c4043423", 0);
  }

  self _meth_82F6("#x3e9de50fa971cd442", 1);
  _id_8163();

  if(scripts\mp\utility\game::_id_6A65()) {
    self _meth_82F6("#x3b5ba1bcd76e618ed", 0, "#x3b5721151de5f5352", 1, "#x3abb511cb818d7f09", 1, "#x3cd356b42db4dc9e1", 0);
  } else {
    self _meth_82F6("#x3b5ba1bcd76e618ed", 0, "#x3b5721151de5f5352", 1, "#x3abb511cb818d7f09", 1, "#x3cd356b42db4dc9e1", 0);
  }

  if(level.teambased) {
    self _meth_82F6("#x3acf57c223df6ab1e", 0);
  }

  self setclientdvar("#x3fb6716a48e67d4f6", 0);

  if(getdvarint("#x376b80553bab6c03c")) {
    for(var_0 = 0; var_0 < 6; var_0++) {
      self setclientdvar(_func_0483("#x3ed4086fbf94d8a6f", scripts\engine\utility::_id_EA52(var_0)), "");
    }

    self._id_79AB = 1;
  }

  setdvarifuninitialized("#x3fb31985943553e45", 3.0);
}

_id_3B80() {
  if(!isDefined(self)) {
    return;
  }
  if(self.sessionteam == "none" && scripts\mp\utility\game::matchmakinggame() && level.teambased && !isbot(self) && !_func_03DA(self) && !self _meth_81D3() && scripts\mp\utility\game::getgametype() != "infect") {
    wait 1.5;
    kick(self getentitynumber(), "EXE/PLAYERKICKED_INVALIDTEAM");
  }
}

_id_BECC() {
  for(;;) {
    if(!isDefined(level._id_B786)) {
      waitframe();
      continue;
    }

    break;
  }

  for(;;) {
    for(var_0 = 0; var_0 < level._id_B786.size; var_0++) {
      var_1 = level._id_B786[var_0];

      if(isDefined(var_1)) {
        level notify("connected", var_1);
        var_1 notify("connected_continue");
        level._id_B786[var_0] = undefined;
        break;
      }
    }

    var_2 = scripts\engine\utility::_id_1BD1(level._id_B786);
    level._id_B786 = var_2;
    waitframe();
  }
}

_id_ABD7(var_0, var_1) {
  if(var_0 != "versus_done") {
    return;
  }
  self._id_103AC = 1;
}

_id_8289() {
  level endon("game_ended");
  level thread _id_C14D();

  for(;;) {
    level waittill("connected", var_0);
    level thread _id_4032(var_0);
  }
}

_id_C14D() {
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");
  wait 4;

  for(;;) {
    wait 1;

    foreach(var_1 in level.players) {
      if(istrue(var_1._id_31BB)) {
        var_1 thread _id_FD01();
      }
    }
  }
}

_id_4032(var_0) {
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  var_0._id_D02F = [];
  var_0._id_D02F["distanceTotal"] = 0;
  var_0._id_D02F["movingTotal"] = 0;
  var_0._id_D02F["movementUpdateCount"] = 0;
  var_0._id_CB4D = var_0.origin;
  var_0._id_BA0D = var_0.origin;
  var_0._id_31BB = 1;
}

_id_FD01() {
  self endon("disconnect");

  if(!isDefined(self._id_CB4D)) {
    self._id_CB4D = self.origin;
    self._id_BA0D = self.origin;
  }

  if(scripts\mp\utility\player::_id_8ACE()) {
    self waittill("stopped_using_remote");
    self._id_CB4D = self.origin;
    self._id_BA0D = self.origin;
    return;
  }

  self._id_D02F["movementUpdateCount"]++;
  self._id_D02F["distanceTotal"] = self._id_D02F["distanceTotal"] + distance2d(self._id_CB4D, self.origin);
  self._id_CB4D = self.origin;

  if(self._id_D02F["movementUpdateCount"] % 5 == 0) {
    var_0 = distance2d(self._id_BA0D, self.origin);
    self._id_BA0D = self.origin;

    if(var_0 > 16) {
      self._id_D02F["movingTotal"]++;
    }
  }
}

_id_DBD3(var_0) {
  return scripts\mp\utility\game::getgametype() != "br" && var_0 < level._id_BBAD && !istrue(self._id_2C68) && !_id_07D1::_id_60BE("infil_will_run") && !istrue(level.infil_s4_will_run) && !_id_07D1::_id_60BE("prematch_waitForPlayers_Complete");
}

_id_D73B(var_0) {
  var_1 = newclienthudelem(self);
  var_1.x = 0;
  var_1.y = 0;
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.sort = 1;
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1._id_01D6 = 1;
  var_2 = 0.0;
  var_3 = 0.5;

  if(isDefined(var_2) && var_2 > 0) {
    var_1.alpha = 0;
  } else {
    var_1.alpha = 1;
  }

  var_1 setshader("black", 640, 480);

  if(isDefined(var_2) && var_2 > 0) {
    if(isDefined(self)) {
      self notify("fadeDown_start");
    }

    var_1 fadeovertime(var_2);
    var_1.alpha = 1.0;
    wait(var_2);
  }

  if(isDefined(self)) {
    self waittill(var_0);
  }

  var_1 fadeovertime(var_3);
  var_1.alpha = 0.0;
  wait(var_3);

  if(isDefined(var_1)) {
    var_1 destroy();
  }
}

_id_2F36() {
  self.pers["streamSyncComplete"] = 1;
  self notify("player_active");
}

_id_6B3C() {
  if(level.gametype != "br") {
    return 30;
  } else {
    return 200;
  }
}

_id_2F37() {
  self._id_103AC = 0;
  self.pers["afkResetTime"] = 0;
  self._id_0407 = "hud_status_connecting";
  self waittill("begin");
  self._id_0407 = "";

  if(isai(self) || getdvarint("#x3db605c8e3b0ad2a6", 0) == 1) {
    _id_2F36();
  }

  self._id_3B86 = undefined;
  self _meth_8283();

  if(scripts\mp\utility\game::getgametype() != "br") {
    self _meth_86A4();
  }

  var_0 = 1;

  if(isDefined(level._id_AB60)) {
    var_0 = self thread[[level._id_AB60]]();
  }

  if(_id_07D1::_id_60BE("prematch_done") && istrue(level._id_FECE) && isDefined(self.sessionteam)) {
    if(self.sessionteam == "allies") {
      var_1 = level._id_E278["gw_fob_alliesHQ"]["allies"];
      self _meth_86A3(var_1.origin, 1);
    } else if(self.sessionteam == "axis") {
      var_1 = level._id_E278["gw_fob_axisHQ"]["axis"];
      self _meth_86A3(var_1.origin, 1);
    }
  }

  self _meth_844E("bw", 0);
  var_2 = "connected_continue";
  var_3 = scripts\mp\utility\game::_id_6DE6() / 1000 + 6;

  if(!isDefined(self.pers["streamSyncComplete"]) && _id_DBD3(var_3)) {
    var_2 = "player_active";
  }

  thread _id_D73B(var_2);
  scripts\mp\utility\game::_id_3551();
  level._id_B786[level._id_B786.size] = self;
  self waittill("connected_continue");
  self._id_3B81 = 1;

  if(!isDefined(level._id_F952)) {
    level._id_F952 = 1;
  } else {
    level._id_F952++;
  }

  _id_81FE();
  self setclientomnvar("ui_scoreboard_freeze", 0);

  if(self ishost()) {
    level.player = self;
  }

  if(getDvar("#x35c7ba724d46aa917") == "1") {
    if(_id_07D1::_id_60BE("prematch_done")) {
      setomnvar("ui_last_player_connected", self getentitynumber());
    }
  } else if(!level.splitscreen && !isDefined(self.pers["score"])) {
    var_4 = 0;
    var_5 = getdvarint("#x3ad1c231f9d6c1d11", 0);

    if(var_5 > 0) {
      if(isDefined(level._id_E72D)) {
        var_6 = (gettime() - level._id_E72D) / 1000;

        if(var_6 <= var_5) {
          var_4 = 1;
        }
      } else
        var_4 = 1;
    }

    if(var_4 == 0) {}
  }

  self.usingonlinedataoffline = self _meth_81F3();
  _id_8162();
  _id_826F();
  _id_07A7::_id_19C4();

  if(getDvar("#x3a8fb0620196c6263") == "1") {
    level waittill("eternity");
  }

  self.guid = scripts\mp\utility\player::getuniqueid();
  var_7 = 0;

  if(!isDefined(self.pers["clientid"])) {
    self.pers["clientid"] = game["clientid"];
    game["clientid"]++;
    var_8 = _id_6B3C();

    if(game["clientid"] >= var_8) {
      game["clientid"] = var_8 - 1;
      self.pers["clientid"] = var_8 - 1;
    }

    var_7 = 1;
    self.pers["weaponStats"] = [];
    self.pers["matchdataScoreEventCounts"] = [];
    self.pers["xpAtLastDeath"] = 0;
    self.pers["scoreAtLastDeath"] = 0;
  }

  _id_07BF::_id_C769();

  if(self _meth_81D3() && getdvarint("#x39533ac66feb2d0b1") == 1 && isDefined(game["total_game_time"])) {
    self setclientomnvar("ui_total_game_time", game["total_game_time"]);
  }

  if(istrue(level._id_5CD3)) {
    thread _id_07D2::_id_5CD0(self);
  }

  if(var_7) {
    scripts\mp\persistence::_id_E771("round", "timePlayed", 0, 1);
    self setplayerdata("common", "round", "totalXp", 0);
    scripts\cp_mp\utility\game_utility::_id_E6DE();

    if(!isDefined(game["uniquePlayerCount"])) {
      game["uniquePlayerCount"] = 1;
    } else {
      game["uniquePlayerCount"]++;
    }
  }

  self._id_399D = self.pers["clientid"];
  self.pers["teamKillPunish"] = 0;
  _func_0140("J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\n");

  if(_func_0391()) {
    _func_038F("J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\n");
  }

  if(getdvarint("#x366fca6702ea24ddf") != 0) {
    var_9 = _func_00AC("commonMatchData", "player_count");

    if(var_7) {
      var_9++;
      setmatchdata("commonMatchData", "player_count", var_9);
    }

    if(isbot(self) || _func_03DA(self) || isai(self)) {
      var_10 = 1;
    } else {
      var_10 = 0;
    }

    if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::_id_47C7() && !var_10) {}
  }

  self.killcamvanityindex = self getplayerdata(level.loadoutsgroup, "customizationSetup", "killcamTheme");

  if(var_7) {
    _id_06E2::_id_4C2A("callback_on_player_first_connect", self);
  }

  _id_06E2::_id_4C2A("callback_on_player_connect", self);

  if(level._id_F952 <= _id_6B3C()) {
    if(var_7 && isDefined(level._id_9BDC)) {
      [[level._id_9BDC]](self._id_399D, self.team, self.name);
    }
  }

  if(!level.teambased) {
    game["roundsWon"][self.guid] = 0;
  }

  if(!isDefined(self.pers["cur_kill_streak"])) {
    self.pers["cur_kill_streak"] = 0;
  }

  if(!isDefined(self.pers["cur_death_streak"])) {
    self.pers["cur_death_streak"] = 0;
  }

  if(level.onlinestatsenabled) {
    self._id_24D1 = _id_0804::_id_6C64("bestStats", "killStreak");
  }

  self._id_8FDE = -1;
  self._id_75B4 = 0;
  self._id_10849 = 0;
  self._id_109C6 = 0;
  self._id_10A0A = 0;
  self._id_A25F = 1;
  self._id_A8EC = 1;
  self._id_8D6F = 0;
  self._id_936C = 0;

  if(isDefined(self.pers["deaths"])) {
    self._id_936C = self.pers["deaths"];
  }

  _id_C64E();
  waittillframeend;
  level.players[level.players.size] = self;
  level._id_B78E[self getentitynumber()] = self;
  _id_0817::_id_1165();
  _id_0817::_id_115A();
  scripts\cp_mp\utility\player_utility::_id_115B();

  if(game["state"] == "postgame") {
    self._id_3B82 = 1;
    thread _id_E37D();
    self _meth_82F6("#x3e9de50fa971cd442", 0);
    self _meth_844E("", 0.25);
    _id_E30E();
    return;
  }

  if(var_7 && (scripts\mp\utility\game::_id_6DE6() >= 60000 || game["roundsPlayed"] > 0)) {
    self._id_8BD9 = 1;
  }

  if(isai(self) && isDefined(level._id_279D) && isDefined(level._id_279D["think"])) {
    self thread[[level._id_279D["think"]]]();
  }

  if(_func_0391() && !isai(self)) {
    _func_0390(self.guid);
  }

  level endon("game_ended");

  if(isDefined(level._id_7AAE)) {
    thread scripts\mp\hostmigration::_id_7AAF();
  }

  if(isDefined(level._id_AB5B)) {
    [[level._id_AB5B]]();
  }

  thread _id_09E1::_id_100FB(self);
  thread _id_0A6B::_id_9B38();

  if(!isDefined(self.pers["team"])) {
    if(istrue(level.leagueplaymatch) && !istrue(level.leagueplayloadingcomplete)) {
      level waittill("leaguePlayLoadingComplete");
    }

    var_3 = scripts\mp\utility\game::_id_6DE6() / 1000 + 6;

    if(_id_DBD3(var_3)) {
      _id_E37E();
      self _meth_8577("default");
      self setclientomnvar("ui_mapshot_camera", 0);
      _id_8163();
      self.pers["team"] = "";
      self.team = "free";
    } else
      self _meth_844E("", 0.5);

    _id_3B80();

    if(self _meth_81D3()) {
      if(self _meth_8156()) {
        thread _id_07F2::_id_D565();
      } else {
        thread _id_07F2::_id_D6E4();
      }
    } else if(_func_0394() && (self.sessionteam == "spectator" || self.sessionteam == "follower")) {
      self.pers["team"] = self.sessionteam;
      self.team = self.sessionteam;
      thread _id_E37D();
    } else if((scripts\mp\utility\game::matchmakinggame() || scripts\mp\utility\game::_id_96B9() || isgamebattlematch()) && self.sessionteam != "none") {
      if(var_0) {
        thread _id_E37D();
      }

      if(getDvar("#x3f59526763711edc4", "") == "dmz" && getdvarint("#x364ace41c3ed32ae4", 0) == 1) {
        thread scripts\mp\teams::_id_B010();
      } else {
        thread _id_07F2::_id_D70D(self.sessionteam);
      }

      if(scripts\mp\utility\game::_id_159D() || scripts\mp\utility\game::_id_DCA8() && !isai(self)) {
        self setclientomnvar("ui_options_menu", 2);
      }

      if(!scripts\mp\utility\game::_id_CA4B() && scripts\mp\utility\game::matchmakinggame() && !isgamebattlematch()) {
        thread _id_8CE3();
      }

      _id_396A();
      return;
    } else {
      if(var_0) {
        thread _id_E37D();
      }

      _id_07F2::_id_1F1D();

      if(scripts\mp\utility\game::_id_159D() || scripts\mp\utility\game::_id_DCA8() && !isai(self)) {
        self setclientomnvar("ui_options_menu", 2);
      }

      if(!scripts\mp\utility\game::_id_CA4B() && scripts\mp\utility\game::matchmakinggame()) {
        thread _id_8CE3();
      }

      _id_396A();
      return;
    }
  } else {
    self _meth_844E("", 0.5);
    _id_3B80();
    var_14 = self.pers["team"];

    if(scripts\mp\utility\game::matchmakinggame() && !isbot(self) && !_func_03DA(self) && !self _meth_81D3() && getdvarint("#x35290e243d8624eba")) {
      var_14 = self.sessionteam;
    }

    _id_07F2::_id_1176(var_14, 1);

    if(self _meth_81D3()) {
      thread _id_E37D();
      _id_396A();
      return;
    }

    if(scripts\mp\class::_id_8AE0(self.pers["class"]) && var_14 != "spectator") {
      thread _id_E285();
      _id_396A();
      return;
    }

    thread _id_E37D();

    if(self.pers["team"] == "spectator") {
      if(scripts\mp\utility\game::_id_4C79() && !istrue(self.pers["playerChoseSpectatorTeam"])) {
        _id_07F2::_id_24B7();
      }
    } else
      _id_07F2::_id_24A6();
  }

  _id_396A();
}

_id_2F3E() {
  if(isDefined(self._id_3B81) && self._id_3B81) {
    scripts\mp\utility\game::_id_FCD2();
  }

  if(self ishost()) {
    _id_8163();
  }

  var_0 = 0;

  foreach(var_2 in level.players) {
    if(!isbot(var_2) && !_func_03DA(var_2)) {
      var_0++;
    }
  }

  if(!isbot(self) && !_func_03DA(self)) {
    level._id_7AAC++;

    if(level._id_7AAC >= var_0 * 2 / 3) {
      level notify("hostmigration_enoughplayers");
    }
  }
}

_id_10E1(var_0, var_1) {
  var_2 = scripts\mp\rank::getrankforxp(var_0);
  var_3 = scripts\mp\rank::_id_6CDD(var_2);
  var_4 = scripts\mp\rank::getrankinfomaxxp(var_2);
  var_2 = var_2 + (var_0 - var_3) / (var_4 - var_3);
  var_2 = var_2 + var_1;

  if(var_2 < 0) {
    var_2 = 0;
    var_5 = 0.0;
  } else if(var_2 >= level.maxrank + 1.0) {
    var_2 = level.maxrank;
    var_5 = 1.0;
  } else {
    var_5 = var_2 - floor(var_2);
    var_2 = int(floor(var_2));
  }

  var_3 = scripts\mp\rank::_id_6CDD(var_2);
  var_4 = scripts\mp\rank::getrankinfomaxxp(var_2);
  return int(var_5 * (var_4 - var_3)) + var_3;
}

_id_5EC1() {
  self endon("death_or_disconnect");
  self endon("spawned");
  wait 60.0;

  if(self._id_75B4) {
    return;
  }
  if(self.pers["team"] == "spectator" || self.pers["team"] == "follower") {
    return;
  }
  if(!scripts\mp\class::_id_8AE0(self.pers["class"])) {
    self.pers["class"] = "CLASS/CUSTOM1";
    self.class = self.pers["class"];
  }

  thread _id_E285();
}

_id_8CE3() {
  if(getdvarint("#x3d1c9984568884f80", 0) == 1) {
    return;
  }
  self endon("death_or_disconnect");
  self endon("spawned");
  self endon("attempted_spawn");
  var_0 = getdvarfloat("#x317cf5221d4d36a31", 90);
  var_1 = getdvarfloat("#x32a2aea8f84c78f15", 45);
  var_2 = getdvarfloat("#x3f42d70b3f5f460b", 120);
  var_3 = gettime();

  if(self ishost()) {
    _id_8CEB(var_2);
  } else {
    _id_8CEB(var_0);
  }

  var_4 = (gettime() - var_3) / 1000;

  if(var_4 < var_0 - 0.1 && var_4 < var_1) {
    return;
  }
  if(self._id_75B4) {
    return;
  }
  if(self.pers["team"] == "spectator" || self.pers["team"] == "follower") {
    return;
  }
  kick(self getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
  level thread[[level._id_FC75]]();
}

_id_8CEB(var_0) {
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
}

_id_A14C() {
  level endon("game_ended");
  self endon("disconnect");

  for(self._id_106B1 = 0; self._id_106B1 < 2; self._id_106B1++) {
    self waittill("voteToKick");
  }

  kick(self getentitynumber(), "EXE/PLAYERKICKED_TEAMKILLS");
}

_id_5957() {
  wait 1.0;
  self notify("voteToKick");
  wait 3.0;
  self notify("voteToKick");
  wait 2.0;
  self notify("voteToKick");
}

_id_F378(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned");
  self notify("distFromSpawnTracking");
  self endon("distFromSpawnTracking");
  var_1 = var_0;

  if(!_id_07D1::_id_60BE("prematch_done")) {
    _id_07D1::_id_60C2("prematch_done");
    var_1 = self.origin;
  }

  var_2 = 0;
  var_3 = 0;

  for(;;) {
    var_4 = scripts\engine\utility::_id_108AA(5.0, "death", "vehicle_enter", "vehicle_change_seat", "vehicle_exit");

    if(var_4 == "vehicle_exit" && !isDefined(self._id_90C3)) {
      continue;
    }
    if(!isDefined(self.pers["totalDistTraveled"])) {
      scripts\mp\utility\stats::_id_8257("totalDistTraveled");
    }

    if(!isDefined(self.pers["totalDistTraveledAFK"])) {
      scripts\mp\utility\stats::_id_8257("totalDistTraveledAFK");
    }

    var_5 = distance(var_1, self.origin);
    scripts\mp\utility\stats::_id_7DAE("totalDistTraveled", var_5);
    scripts\mp\utility\stats::_id_7DAE("totalDistTraveledAFK", var_5);

    if(var_4 == "vehicle_exit" || isDefined(self.vehicle)) {
      scripts\mp\utility\stats::_id_7DAE("distanceTraveledInVehicle", var_5);
    }

    if(var_4 == "vehicle_enter") {
      var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101E8(self);
      self._id_90C3 = gettime();
    }

    if(var_4 == "vehicle_change_seat") {
      var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101E8(self);
    }

    if(var_2 != var_3 || var_4 == "vehicle_exit") {
      var_6 = self._id_90C3;
      var_7 = (gettime() - var_6) / 1000;

      if(var_2) {
        scripts\mp\utility\stats::_id_7DAE("timeSpentAsDriver", var_7);
      } else {
        scripts\mp\utility\stats::_id_7DAE("timeSpentAsPassenger", var_7);
      }
    }

    if(var_4 == "vehicle_enter" || var_4 == "vehicle_change_seat") {
      var_2 = var_3;
    }

    if(var_4 == "vehicle_change_seat") {
      self._id_90C3 = gettime();
    }

    var_1 = self.origin;

    if(scripts\mp\utility\game::_id_875E()) {
      if(self.pers["totalDistTraveledAFK"] > 50) {
        self.pers["distTrackingPassed"] = 1;
        self.pers["afkRounds"] = 0;
      }
    } else if(!istrue(self.pers["distTrackingPassed"])) {
      if(self.pers["totalDistTraveledAFK"] > 300) {
        self.pers["distTrackingPassed"] = 1;
      }
    } else {
      var_8 = scripts\mp\utility\game::getgametype() != "br";

      if(var_8) {
        var_9 = scripts\mp\persistence::_id_E761("round", "timePlayed", 0);

        if(var_9 - self.pers["afkResetTime"] > 240) {
          self.pers["afkResetTime"] = var_9;
          self.pers["distTrackingPassed"] = undefined;
          self.pers["totalDistTraveledAFK"] = undefined;
        }
      }
    }

    scripts\mp\utility\stats::_id_7DAE("averageAltitude", self.origin[2]);
    scripts\mp\utility\stats::_id_7DAE("averageAltitudeCount", 1);
  }
}

_id_820C() {
  if(!isDefined(self.pers["deaths"])) {
    scripts\mp\utility\stats::_id_8257("deaths");
    scripts\mp\persistence::_id_E770("round", "deaths", 0);
  }

  self._id_0157 = scripts\mp\utility\stats::_id_6C29("deaths");
  scripts\mp\utility\stats::_id_820B("deaths");

  if(!isDefined(self.pers["score"])) {
    scripts\mp\utility\stats::_id_8257("score");
    scripts\mp\persistence::_id_E770("round", "score", 0);
  }

  self._id_038F = scripts\mp\utility\stats::_id_6C29("score");
  scripts\mp\utility\stats::_id_820B("score");

  if(!isDefined(self.pers["kills"])) {
    scripts\mp\utility\stats::_id_8257("kills");
    scripts\mp\persistence::_id_E770("round", "kills", 0);
  }

  self._id_0267 = scripts\mp\utility\stats::_id_6C29("kills");
  scripts\mp\utility\stats::_id_820B("kills");
}

_id_826F() {
  _id_0803::_id_825B();
  scripts\mp\persistence::_id_8158();

  if(!isDefined(self._id_9134)) {
    self._id_9134 = [];
  }

  _id_820C();

  if(!isDefined(self.pers["suicides"])) {
    scripts\mp\utility\stats::_id_8257("suicides");
  }

  scripts\mp\utility\stats::_id_820B("suicides");

  if(!isDefined(self.pers["headshots"])) {
    scripts\mp\utility\stats::_id_8257("headshots");
  }

  scripts\mp\utility\stats::_id_820B("headshots");

  if(!isDefined(self.pers["executions"])) {
    scripts\mp\utility\stats::_id_8257("executions");
  }

  if(!isDefined(self.pers["assists"])) {
    scripts\mp\utility\stats::_id_8257("assists");
    scripts\mp\persistence::_id_E770("round", "assists", 0);
  }

  self._id_006F = scripts\mp\utility\stats::_id_6C29("assists");
  scripts\mp\utility\stats::_id_820B("assists");

  if(!isDefined(self.pers["captures"])) {
    scripts\mp\utility\stats::_id_8257("captures");
    scripts\mp\persistence::_id_E770("round", "captures", 0);
  }

  scripts\mp\utility\stats::_id_820B("captures");

  if(!isDefined(self.pers["returns"])) {
    scripts\mp\utility\stats::_id_8257("returns");
    scripts\mp\persistence::_id_E770("round", "returns", 0);
  }

  scripts\mp\utility\stats::_id_820B("returns");

  if(!isDefined(self.pers["defends"])) {
    scripts\mp\utility\stats::_id_8257("defends");
    scripts\mp\persistence::_id_E770("round", "defends", 0);
  }

  scripts\mp\utility\stats::_id_820B("defends");

  if(!isDefined(self.pers["assaults"])) {
    scripts\mp\utility\stats::_id_8257("assaults");
    scripts\mp\persistence::_id_E770("round", "assaults", 0);
  }

  scripts\mp\utility\stats::_id_820B("assaults");

  if(!isDefined(self.pers["plants"])) {
    scripts\mp\utility\stats::_id_8257("plants");
    scripts\mp\persistence::_id_E770("round", "plants", 0);
  }

  scripts\mp\utility\stats::_id_820B("plants");

  if(!isDefined(self.pers["defuses"])) {
    scripts\mp\utility\stats::_id_8257("defuses");
    scripts\mp\persistence::_id_E770("round", "defuses", 0);
  }

  scripts\mp\utility\stats::_id_820B("defuses");

  if(!isDefined(self.pers["destructions"])) {
    scripts\mp\utility\stats::_id_8257("destructions");
    scripts\mp\persistence::_id_E770("round", "destructions", 0);
  }

  scripts\mp\utility\stats::_id_820B("destructions");

  if(!isDefined(self.pers["confirmed"])) {
    scripts\mp\utility\stats::_id_8257("confirmed");
    scripts\mp\persistence::_id_E770("round", "confirmed", 0);
  }

  scripts\mp\utility\stats::_id_820B("confirmed");

  if(!isDefined(self.pers["denied"])) {
    scripts\mp\utility\stats::_id_8257("denied");
    scripts\mp\persistence::_id_E770("round", "denied", 0);
  }

  scripts\mp\utility\stats::_id_820B("denied");

  if(!isDefined(self.pers["rescues"])) {
    scripts\mp\utility\stats::_id_8257("rescues");
    scripts\mp\persistence::_id_E770("round", "rescues", 0);
  }

  scripts\mp\utility\stats::_id_820B("rescues");

  if(!isDefined(self.pers["touchdowns"])) {
    scripts\mp\utility\stats::_id_8257("touchdowns");
    scripts\mp\persistence::_id_E770("round", "touchdowns", 0);
  }

  scripts\mp\utility\stats::_id_820B("touchdowns");

  if(!isDefined(self.pers["fieldgoals"])) {
    scripts\mp\utility\stats::_id_8257("fieldgoals");
    scripts\mp\persistence::_id_E770("round", "fieldgoals", 0);
  }

  scripts\mp\utility\stats::_id_820B("fieldgoals");

  if(!isDefined(self.pers["killChains"])) {
    scripts\mp\utility\stats::_id_8257("killChains");
    scripts\mp\persistence::_id_E770("round", "killChains", 0);
  }

  scripts\mp\utility\stats::_id_820B("killChains");

  if(!isDefined(self.pers["killsAsSurvivor"])) {
    scripts\mp\utility\stats::_id_8257("killsAsSurvivor");
    scripts\mp\persistence::_id_E770("round", "killsAsSurvivor", 0);
  }

  scripts\mp\utility\stats::_id_820B("killsAsSurvivor");

  if(!isDefined(self.pers["killsAsInfected"])) {
    scripts\mp\utility\stats::_id_8257("killsAsInfected");
    scripts\mp\persistence::_id_E770("round", "killsAsInfected", 0);
  }

  scripts\mp\utility\stats::_id_820B("killsAsInfected");

  if(!isDefined(self.pers["teamkills"])) {
    scripts\mp\utility\stats::_id_8257("teamkills");
  }

  scripts\mp\utility\stats::_id_820B("teamkills");

  if(!isDefined(self.pers["teamdamage"])) {
    scripts\mp\utility\stats::_id_8257("teamdamage");
  }

  if(!isDefined(self.pers["extrascore0"])) {
    scripts\mp\utility\stats::_id_8257("extrascore0");
  }

  scripts\mp\utility\stats::_id_820B("extrascore0");

  if(!isDefined(self.pers["extrascore1"])) {
    scripts\mp\utility\stats::_id_8257("extrascore1");
  }

  scripts\mp\utility\stats::_id_820B("extrascore1");

  if(!isDefined(self.pers["stabs"])) {
    scripts\mp\utility\stats::_id_8257("stabs");
    scripts\mp\persistence::_id_E770("round", "stabs", 0);
  }

  scripts\mp\utility\stats::_id_820B("stabs");

  if(!isDefined(self.pers["setbacks"])) {
    scripts\mp\utility\stats::_id_8257("setbacks");
    scripts\mp\persistence::_id_E770("round", "setbacks", 0);
  }

  scripts\mp\utility\stats::_id_820B("setbacks");

  if(!isDefined(self.pers["objTime"])) {
    scripts\mp\utility\stats::_id_8257("objTime");
    scripts\mp\persistence::_id_E770("round", "objTime", 0);
  }

  scripts\mp\utility\stats::_id_820B("objTime");

  if(!isDefined(self.pers["gamemodeScore"])) {
    scripts\mp\utility\stats::_id_8257("gamemodeScore");
    scripts\mp\persistence::_id_E770("round", "gamemodeScore", 0);
  }

  scripts\mp\utility\stats::_id_820B("gamemodeScore");

  if(!isDefined(self.pers["damage"])) {
    scripts\mp\utility\stats::_id_8257("damage");
    scripts\mp\persistence::_id_E770("round", "damage", 0);
  }

  scripts\mp\utility\stats::_id_820B("damage");

  if(!isDefined(self.pers["supersEarned"])) {
    scripts\mp\utility\stats::_id_8257("supersEarned");
  }

  scripts\mp\utility\stats::_id_820B("supersEarned");

  if(!isDefined(self.pers["downs"])) {
    scripts\mp\utility\stats::_id_8257("downs");
    scripts\mp\persistence::_id_E770("round", "downs", 0);
  }

  scripts\mp\utility\stats::_id_820B("downs");

  if(!isDefined(self.pers["contracts"])) {
    scripts\mp\utility\stats::_id_8257("contracts");
    scripts\mp\persistence::_id_E770("round", "contracts", 0);
  }

  scripts\mp\utility\stats::_id_820B("contracts");

  if(!isDefined(self.pers["wins"])) {
    scripts\mp\utility\stats::_id_8257("wins");
  }

  scripts\mp\utility\stats::_id_820B("wins");

  if(!isDefined(self.pers["topFive"])) {
    scripts\mp\utility\stats::_id_8257("topFive");
  }

  scripts\mp\utility\stats::_id_820B("topFive");

  if(!isDefined(self.pers["topTen"])) {
    scripts\mp\utility\stats::_id_8257("topTen");
  }

  scripts\mp\utility\stats::_id_820B("topTen");

  if(!isDefined(self.pers["topTwentyFive"])) {
    scripts\mp\utility\stats::_id_8257("topTwentyFive");
  }

  scripts\mp\utility\stats::_id_820B("topTwentyFive");

  if(!isDefined(self.pers["gamesPlayed"])) {
    scripts\mp\utility\stats::_id_8257("gamesPlayed");
  }

  scripts\mp\utility\stats::_id_820B("gamesPlayed");

  if(!isDefined(self.pers["cash"])) {
    scripts\mp\utility\stats::_id_8257("cash");
  }

  scripts\mp\utility\stats::_id_820B("cash");

  if(!isDefined(self.pers["killstreaksUsed"])) {
    scripts\mp\utility\stats::_id_8257("killstreaksUsed");
  }

  if(!isDefined(self.pers["explosiveKills"])) {
    scripts\mp\utility\stats::_id_8257("explosiveKills");
  }

  if(!isDefined(self.pers["objectiveKills"])) {
    scripts\mp\utility\stats::_id_8257("objectiveKills");
  }

  if(!isDefined(self.pers["teamKillPunish"])) {
    self.pers["teamKillPunish"] = 0;
  }

  scripts\mp\utility\stats::_id_8257("longestStreak");
  scripts\mp\utility\stats::_id_820B("longestStreak");
  self.pers["lives"] = ::scripts\mp\utility\game::_id_6A65();
  scripts\mp\persistence::_id_E770("round", "killStreak", 0);
  scripts\mp\persistence::_id_E770("round", "loss", 0);
  scripts\mp\persistence::_id_E770("round", "win", 0);
  scripts\mp\persistence::_id_E770("round", "scoreboardType", "none");
  scripts\mp\utility\stats::_id_820B("killStreak");
  scripts\mp\utility\stats::_id_820B("loss");
  scripts\mp\utility\stats::_id_820B("win");
  scripts\mp\utility\stats::_id_8257("damageTaken");
}

_id_1177(var_0) {
  thread scripts\mp\utility\teams::_id_1114(self, self.team, var_0);
  [[level._id_FC75]]();
}

_id_C4BD() {
  scripts\mp\utility\teams::_id_C509(self, self.team);
}

_id_1157() {
  var_0 = self.team;

  if(!(isDefined(self._id_1643) && self._id_1643)) {
    scripts\mp\utility\teams::_id_A010(var_0, "hasSpawned", 1);
    _id_7DE8(var_0);
  }

  self._id_1643 = undefined;
  var_1 = 0;

  foreach(var_3 in level._id_EF89) {
    var_1 = var_1 + scripts\mp\utility\teams::_id_6DCA(var_3, "aliveCount");
  }

  if(var_1 > level._id_9C91) {
    level._id_9C91 = var_1;
  }
}

_id_7DE8(var_0, var_1) {
  scripts\mp\utility\teams::_id_1178(self, var_0, var_1);
  [[level._id_FC75]]();
}

_id_C4A4(var_0) {
  var_1 = self.pers["lives"];
  var_2 = scripts\mp\utility\game::_id_6A65() != 0 && var_1 == 0;
  self notify("remove_from_alive_count");
  var_3 = self.team;

  if(isDefined(self._id_EC33) && self._id_EC33 && isDefined(self._id_8BDA) && self._id_8BDA == self.team) {
    var_3 = self._id_916E;
  }

  if(isDefined(var_0) && scripts\mp\utility\game::getgametype() != "control") {
    _id_C46F();
  } else if(isDefined(self._id_EC33)) {
    if(!level._id_7EB0 || self._id_7555) {
      scripts\mp\utility\teams::_id_A010(var_3, "hasSpawned", -1);

      if(var_1 && scripts\mp\utility\game::getgametype() != "control") {
        self.pers["lives"]--;
      }
    }
  }

  _id_4554(var_3, var_2);
}

_id_4554(var_0, var_1) {
  scripts\mp\utility\teams::_id_C4BE(self, var_0, var_1);
  [[level._id_FC75]]();
}

_id_1163() {
  scripts\mp\utility\teams::_id_A010(self.team, "livesCount", self.pers["lives"]);
}

_id_C4AF() {
  scripts\mp\utility\teams::_id_D70F(self.team, "livesCount", int(max(0, scripts\mp\utility\teams::_id_6DCA(self.team, "livesCount") - 1)));
}

_id_C46F() {
  scripts\mp\utility\teams::_id_D70F(self.team, "livesCount", int(max(0, scripts\mp\utility\teams::_id_6DCA(self.team, "livesCount") - self.pers["lives"])));
}

_id_C651() {
  if(isDefined(level._id_C650)) {
    [[level._id_C650]]();
  }

  self setclientomnvar("ui_objective_state", 0);
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_reviver_id", -1);
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_edge_glow", 0);
  self setclientomnvar("ui_edge_glow_secondary", 0);
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self setclientomnvar("ui_life_kill_count", 0);
  self setclientomnvar("ui_is_laststand", 0);
}

_id_C64E() {
  _id_C651();
  self setclientdvar("#x3e513aac4b5fb5250", 0);
  self setclientomnvar("ui_match_status_hint_text", -1);
  self setclientomnvar("post_game_state", 0);

  if(_id_07D1::_id_60BE("prematch_done")) {
    self setclientomnvar("ui_match_in_progress", 1);
  } else {
    self setclientomnvar("ui_match_in_progress", 0);
  }
}

_id_C64F() {
  _id_C651();
  self setclientdvar("#x3e513aac4b5fb5250", 0);
}

_id_396A() {
  if(isbot(self)) {
    return;
  }
  if(isDefined(level._id_A8E8)) {
    foreach(var_1 in level._id_A8E8) {
      if(isDefined(var_1._id_A908)) {
        _id_07F9::_id_A8CF(var_1._id_A908, self, var_1._id_DCD1);
      }
    }
  }

  if(isDefined(level._id_F935)) {
    foreach(var_1 in level._id_F935) {
      if(isDefined(var_1._id_A908)) {
        _id_07F9::_id_A8CF(var_1._id_A908, self, var_1._id_DCD1);
      }
    }
  }
}

_id_10C13() {
  self endon("death_or_disconnect");
  self._id_EEA5 = [];

  for(;;) {
    var_0 = (self.origin[0], self.origin[1], self.origin[2] + 64);
    var_1 = self getplayerangles();
    var_2 = anglesToForward(var_1);
    var_3 = var_0 + var_2 * 10000;
    var_4 = scripts\engine\trace::_bullet_trace(var_0, var_3, 1, self, 0, 0, 0, 0, 0);
    var_5 = var_4["entity"];

    if(isDefined(var_5) && isPlayer(var_5) && var_5.team != self.team) {
      if(isDefined(var_5)) {
        _id_FD52("ui_target_health", var_5.health);
      }

      if(isDefined(var_5)) {
        _id_FD52("ui_target_max_health", var_5.maxhealth);
      }

      if(isDefined(var_5)) {
        _id_FD52("ui_target_entity_num", var_5 getentitynumber());
      }
    } else
      _id_FD52("ui_target_entity_num", -1);

    wait 0.1;
  }
}

_id_FD52(var_0, var_1) {
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(self._id_EEA5[var_0]) || var_1 != self._id_EEA5[var_0]) {
    self setclientomnvar(var_0, var_1);
    self._id_EEA5[var_0] = var_1;
  }
}

_id_DCAF() {
  if(self._id_75B4) {
    return;
  }
  if(!_id_DCC2()) {
    return;
  }
  if(_id_07D1::_id_60BE("prematch_done")) {
    return;
  }
  _id_07D1::_id_60C2("prematch_done");
  self endon("disconnect");
  wait 1.0;

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.pers["team"])) {
    return;
  }
  var_0 = self.pers["team"];
  var_1 = scripts\mp\utility\game::_id_6BBE(var_0);

  if(isDefined(var_1)) {
    var_2 = 0;

    if(game["defenders"] == var_0) {
      var_2 = 1;
    }

    self setclientomnvar("ui_objective_text", var_2);
    wait 6;
    self setclientomnvar("ui_objective_text", -1);
  }
}

_id_DCC2() {
  var_0 = scripts\mp\utility\game::getgametype();

  switch (var_0) {
    case "arena_evo":
    case "arena":
      if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] > 0) {
        return 0;
      }

      break;
    default:
      break;
  }

  return 1;
}

_id_F73D() {
  if(scripts\mp\utility\player::_id_165C() || scripts\mp\utility\game::getgametype() == "br") {
    return;
  }
  if(!istrue(self._id_DCF8) && !scripts\mp\utility\perk::_hasperk("specialty_always_minimap")) {
    scripts\mp\utility\player::_id_7908(1);
  }

  self._id_DCF8 = 0;
}

_id_81FE() {
  self._id_60E0 = scripts\engine\utility::is_player_gamepad_enabled();
}

_id_FC90() {
  var_0 = scripts\engine\utility::is_player_gamepad_enabled();

  if(self._id_60E0 != var_0) {
    self notify("input_type_changed", var_0);
    self._id_60E0 = var_0;
  }
}

_id_FC50() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level.players) {
      if(!isDefined(var_1)) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(var_1)) {
        continue;
      }
      var_1 scripts\mp\abilities\wall_destructible_dash_mp::playerbashmonitorcoremp();
    }

    wait 0.1;
  }
}

_id_FD07() {
  var_0 = 100;
  var_1 = 700;
  var_2 = var_1 - var_0;
  var_3 = 0;
  var_4 = 10;

  for(;;) {
    foreach(var_6 in level.players) {
      if(!isDefined(var_6)) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(var_6)) {
        continue;
      }
      if(istrue(var_6._id_9A67)) {
        continue;
      }
      if(isDefined(var_6.vehicle)) {
        var_7 = clamp(length(var_6.vehicle _meth_8431()), var_0, var_1);
      } else {
        var_7 = clamp(length(var_6 getvelocity()), var_0, var_1);
      }

      var_8 = (var_7 - var_0) / var_2;
      var_8 = var_8 * 10;
      var_8 = int(var_8);

      if(!isDefined(var_6._id_10E31) || var_6._id_10E31 != var_8) {
        switch (var_8) {
          case 0:
            var_6 setscriptablepartstate("wind", "0", 0);
            break;
          case 1:
            var_6 setscriptablepartstate("wind", "10", 0);
            break;
          case 2:
            var_6 setscriptablepartstate("wind", "20", 0);
            break;
          case 3:
            var_6 setscriptablepartstate("wind", "30", 0);
            break;
          case 4:
            var_6 setscriptablepartstate("wind", "40", 0);
            break;
          case 5:
            var_6 setscriptablepartstate("wind", "50", 0);
            break;
          case 6:
            var_6 setscriptablepartstate("wind", "60", 0);
            break;
          case 7:
            var_6 setscriptablepartstate("wind", "70", 0);
            break;
          case 8:
            var_6 setscriptablepartstate("wind", "80", 0);
            break;
          case 9:
            var_6 setscriptablepartstate("wind", "90", 0);
            break;
          case 10:
            var_6 setscriptablepartstate("wind", "100", 0);
            break;
        }
      }

      var_6._id_10E31 = var_8;
      var_3++;

      if(var_3 == var_4) {
        waitframe();
        var_3 = 0;
      }
    }

    wait 0.1;
  }
}

_id_D496(var_0) {
  self._id_24C7 = var_0;
  self _meth_8776(var_0);
}

_id_690A() {
  return istrue(self._id_24C7) || istrue(self._id_8A25);
}

infil_lighting() {
  var_0 = getEntArray("lgts_infil", "targetname");
  var_1 = getEntArray("lgt_winner", "targetname");

  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(level.infil_light_count == 0) {
        var_3._id_AC87 = var_3 _meth_8146();
      }
    }

    level.infil_light_count = 1;
    thread infil_lighting_infil_manage(var_0);
  }

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(level.winner_light_count == 0) {
        var_3._id_AC87 = var_3 _meth_8146();
      }
    }

    level.winner_light_count = 1;
    thread infil_lighting_winner_manage(var_1);
  }
}

infil_lighting_infil_manage(var_0) {
  foreach(var_2 in var_0) {
    var_2 _meth_8338(var_2._id_AC87);
  }

  if(isDefined(level.sunvfx)) {
    scripts\engine\utility::_id_8D1F(level.sunvfx);
  }

  level waittill("s4_infil_animation_done");

  foreach(var_2 in var_0) {
    var_2 _meth_8338(0);
  }

  if(isDefined(level.sunvfx)) {
    scripts\engine\utility::_id_57BA(level.sunvfx);
  }
}

infil_lighting_winner_manage(var_0) {
  wait 0.05;

  foreach(var_2 in var_0) {
    var_2 _meth_8338(0);
  }

  level waittill("s4_infil_animation_done");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isDefined(var_2._id_AC87)) {
      var_2 _meth_8338(var_2._id_AC87);
    }
  }
}

wc_lighting() {
  var_0 = getEntArray("lgts_infil", "targetname");
  var_1 = getEntArray("lgt_winner", "targetname");

  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(level.infil_light_count == 0) {
        var_3._id_AC87 = var_3 _meth_8146();
      }
    }

    level.infil_light_count = 1;
    thread wc_lighting_infil_manage(var_0);
  }

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(level.winner_light_count == 0) {
        var_3._id_AC87 = var_3 _meth_8146();
      }
    }

    level.winner_light_count = 1;
    thread wc_lighting_winner_manage(var_1);
  }
}

wc_lighting_infil_manage(var_0) {
  foreach(var_2 in var_0) {
    var_2 _meth_8338(0);
  }

  if(isDefined(level.sunvfx)) {
    scripts\engine\utility::_id_8D1F(level.sunvfx);
  }
}

wc_lighting_winner_manage(var_0) {
  level waittill("winner_start");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isDefined(var_2._id_AC87)) {
      var_2 _meth_8338(var_2._id_AC87);
    }
  }
}

inbotonlymatch() {
  foreach(var_1 in level.players) {
    if(self == var_1) {
      continue;
    }
    if(isPlayer(var_1) && !isai(var_1)) {
      return 0;
    }
  }

  return 1;
}

get_const_min_dist_traveled() {
  return 300;
}

runplayercamoscripts() {
  if(!getdvarint("#x3b1d87d8e0b53e10", 1)) {
    return;
  }
  if(playerhasreactivecamo()) {
    thread playerreactivecamo();
    thread devplayerreactivecamo();
  } else
    self setscriptablepartstate("playerActiveCamo", "no_stage");
}

deathwatcherplayercamoandpersistentvfx() {
  self endon("endPlayerReactiveCamoThread");

  if(!playerhasreactivecamo() && !playerhasultravfx()) {
    return;
  }
  for(;;) {
    var_0 = scripts\engine\utility::_id_10897("disconnect", "death");

    if(!isDefined(var_0)) {
      waitframe();
      continue;
    }

    _func_0130(self);
    return;
  }
}

clearplayercamoscripts() {
  self notify("endPlayerReactiveCamoThread");

  if(isDefined(self.playerreactivecamo)) {
    self.playerreactivecamo.stage = 0;
    self.playerreactivecamo._id_0267 = 0;
  }

  self setscriptablepartstate("playerActiveCamo", "no_stage");
}

playerreactivecamosetstage(var_0, var_1) {
  self.playerreactivecamo.stage = var_0;

  if(var_1 == 1) {
    self setscriptablepartstate("playerActiveCamo", "stage" + var_0);
  } else {
    self setscriptablepartstate("playerActiveCamo", "init_stage" + var_0);
  }

  scripts\mp\teams::setultraoperatorskinreactivestage(var_0);
}

playerreactivecamowatchgesturenotetracks() {
  self.playerreactivecamocurprocgestures = [];

  if(!isDefined(level.playerreactivecamoexcludedgestures)) {
    level.playerreactivecamoexcludedgestures = [];
  }

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(!self _meth_84B7() && !self _meth_887C()) {
      waitframe();
      continue;
    }

    if(self _meth_84B7()) {
      var_0 = self _meth_84AE();

      foreach(var_2 in var_0) {
        if(scripts\engine\utility::array_contains(self.playerreactivecamocurprocgestures, var_2) || scripts\engine\utility::array_contains(level.playerreactivecamoexcludedgestures, var_2)) {
          waitframe();
          continue;
        }

        var_3 = self _meth_8879(var_2, "prac_");

        if(var_3.size > 0) {
          var_4 = self _meth_887A(var_2);
          var_5 = self _meth_8495(var_2);

          if(var_4 > var_5 * 0.75) {
            waitframe();
            continue;
          }

          thread end_watcher_gesture(var_2);
          thread playerreactivecamonotetrackwatcher(var_3, var_4, var_5, var_2);
          continue;
        }

        level.playerreactivecamoexcludedgestures = scripts\engine\utility::array_add(level.playerreactivecamoexcludedgestures, var_2);
      }
    } else if(self _meth_887C()) {
      var_7 = self getcurrentweapon();

      if(scripts\engine\utility::array_contains(self.playerreactivecamocurprocgestures, var_7.basename) || scripts\engine\utility::array_contains(level.playerreactivecamoexcludedgestures, var_7.basename)) {
        waitframe();
        continue;
      }

      var_3 = self _meth_887F("prac_");

      if(var_3.size > 0) {
        var_8 = self _meth_887D();
        var_9 = self _meth_887E();

        if(var_8 > var_9 * 0.75) {
          waitframe();
          continue;
        }

        thread end_watcher_inspect(var_7.basename);
        thread playerreactivecamonotetrackwatcher(var_3, var_8, var_9, var_7.basename);
      } else
        level.playerreactivecamoexcludedgestures = scripts\engine\utility::array_add(level.playerreactivecamoexcludedgestures, var_7.basename);
    }

    waitframe();
  }
}

end_watcher_gesture(var_0) {
  while(self _meth_84B7(var_0)) {
    waitframe();
  }

  self notify("cancel_player_reactive_watcher");
  self.playerreactivecamocurprocgestures = scripts\engine\utility::array_remove(self.playerreactivecamocurprocgestures, var_0);
}

end_watcher_inspect(var_0) {
  while(self _meth_887C()) {
    waitframe();
  }

  self notify("cancel_player_reactive_watcher");
  self.playerreactivecamocurprocgestures = scripts\engine\utility::array_remove(self.playerreactivecamocurprocgestures, var_0);
}

playerreactivecamonotetrackcomparefunc(var_0, var_1) {
  return var_0._id_110F4 < var_1._id_110F4;
}

playerreactivecamonotetrackwatcher(var_0, var_1, var_2, var_3) {
  self endon("cancel_player_reactive_watcher");
  self.playerreactivecamocurprocgestures = scripts\engine\utility::array_add(self.playerreactivecamocurprocgestures, var_3);
  var_0 = scripts\engine\utility::_id_1BD6(var_0, ::playerreactivecamonotetrackcomparefunc);
  var_4 = 0.0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];

    if(var_6._id_110F4 * var_2 < var_1) {
      playerreactivecamoprocessnotetrack(var_6.name);
      continue;
    }

    break;
  }

  var_4 = var_1;

  for(var_7 = var_5; var_7 < var_0.size; var_7++) {
    var_8 = var_0[var_7]._id_110F4 * var_2;
    wait(var_8 - var_4);
    var_4 = var_8;
    playerreactivecamoprocessnotetrack(var_0[var_7].name);
  }

  wait(var_2 - var_4);
  self.playerreactivecamocurprocgestures = scripts\engine\utility::array_remove(self.playerreactivecamocurprocgestures, var_3);
}

playerreactivecamoprocessnotetrack(var_0) {
  var_1 = getplayerreactivecamostagecount();
  var_2 = getplayerreactivecamostage();
  var_3 = 0;
  var_0 = _func_00D6(var_0, 5);
  var_4 = strtok(var_0, ",");

  if(var_4[0] == "increment") {
    if(var_4.size > 1 && var_4[1] == "cyclical") {
      var_2 = (var_2 + 1) % var_1;
      var_3 = 2;
    } else {
      var_2 = int(min(var_2 + 1, var_1 - 1));
      var_3 = 1;
    }
  } else if(var_4[0] == "set" && var_4.size > 1) {
    var_2 = int(var_4[1]);
    var_2 = int(clamp(var_2, 0, var_1));
    var_3 = 2;
  }

  var_5 = 0;

  if(var_4.size > var_3) {
    var_5 = int(var_4[var_3]) == 1;
  }

  setplayerreactivecamostage(var_2, var_5);
}

playerreactivecamosetup() {
  if(!isDefined(self.playerreactivecamo)) {
    self.playerreactivecamo = spawnStruct();
    self.playerreactivecamo._id_0267 = 0;
    self.playerreactivecamo.stage = 0;
    self.playerreactivecamo._id_E06D = getplayerreactivesource();
    var_0 = getplayerreactivestagesetdef();
    self _meth_8884(var_0);
  }
}

getplayerreactivecamostage() {
  if(!isDefined(self.playerreactivecamo)) {
    return -1;
  }

  return self.playerreactivecamo.stage;
}

setplayerreactivecamostage(var_0, var_1) {
  playerreactivecamosetup();
  playerreactivecamosetstage(var_0, var_1);
}

getplayerreactivecamostagecount() {
  var_0 = self _meth_8886();
  return var_0.size;
}

playerreactivecamo() {
  self endon("disconnect");
  self endon("death");
  self endon("endPlayerReactiveCamoThread");
  playerreactivecamosetup();

  if(!istrue(self.handledplayerreactivecamo)) {
    self.handledplayerreactivecamo = 1;
    thread playerreactivecamowatchgesturenotetracks();
  }

  var_0 = self.playerreactivecamo;
  playerreactivecamosetstage(var_0.stage, 0);

  if(var_0._id_E06D == "kills") {
    var_1 = self _meth_8886();
    var_2 = int(var_1.size - 1);

    for(;;) {
      scripts\engine\utility::_id_108C5("got_a_kill", "scr_advanceplayerreactivecamo");
      var_3 = int(var_1[int(min(var_0.stage + 1, var_2))]);
      var_0._id_0267++;

      if(var_0._id_0267 == var_3) {
        playerreactivecamosetstage(var_0.stage + 1, 1);
      }
    }
  } else if(var_0._id_E06D == "heal") {
    for(;;) {
      self waittill("heal_started");
      playerreactivecamosetstage(2, 1);
      scripts\engine\utility::waittill_any_3("healed", "heal_interrupted", "death");
      wait(getdvarfloat("#x3fb31985943553e45", 3.0));
      playerreactivecamosetstage(1, 1);
    }
  }
}

devplayerreactivecamo(var_0) {
  self endon("disconnect");
  self endon("death");
  self endon("endPlayerReactiveCamoThread");
  playerreactivecamosetup();

  for(;;) {
    self waittill("scr_resetplayerreactivecamo");
    var_1 = self.playerreactivecamo;
    var_1._id_0267 = 0;
    var_1.stage = 0;
    playerreactivecamosetstage(var_1.stage, 0);
  }
}

getplayerreactivestagesetdef() {
  return scripts\mp\teams::getoperatorreactivestagesetdef();
}

getplayerreactivesource() {
  return scripts\mp\teams::getoperatorreactivesource();
}

playerhasreactivecamo() {
  return getplayerreactivestagesetdef() != "";
}

playerhasultravfx() {
  return scripts\mp\teams::getoperatorultrascriptablestate() != "";
}