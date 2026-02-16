/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2079.gsc
*************************************************/

init() {
  level._id_ABB9 = ::_id_ABB9;
  level._id_C7F4 = [];
  level._id_A790 = scripts\mp\utility\game::_id_6A65();
  level._id_A797 = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_numRevives"), 0);
  level._id_4AE7 = 1;
  level thread onplayerconnect();
}

onplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0._id_A797 = level._id_A797;
  }
}

_id_ABB9(var_0) {
  if(var_0.team != "spectator") {
    level thread _id_E35E(var_0, var_0, "new_trigger_spawned", "MOD_SUICIDE");
  }
}

_id_FD13() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!istrue(_id_07D1::_id_60BE("prematch_done"))) {
    if(_id_07D1::_id_60BE("infil_will_run")) {
      level scripts\engine\utility::waittill_any_3("prematch_done", "start_mode_setup", "infil_started");
      var_0 = int(max(level._id_BBAE - 5, 5));
      wait(var_0);
    } else
      level scripts\engine\utility::waittill_any_3("prematch_done", "start_mode_setup", "match_start_real_countdown");
  }

  while(scripts\mp\utility\player::isreallyalive(self)) {
    if(_id_8AEC()) {
      _id_D8D5();
    }

    waitframe();
  }
}

_id_D8D5() {
  var_0 = self.origin;

  if(isbot(self)) {
    var_1 = self _meth_815E();

    if(!isDefined(var_1)) {
      var_0 = self.origin;
    } else {
      var_0 = var_1.origin;
    }
  } else {
    var_1 = self _meth_815E();

    if(!isDefined(var_1)) {
      var_1 = self.origin;
    } else {
      var_1 = var_1.origin;
    }
  }

  if(!isDefined(self._id_C7E8)) {
    self._id_BC5D = var_0;
  } else {
    self._id_BC5D = self._id_C7E8;
  }

  self._id_C7E8 = var_0;
  self._id_C7F6 = var_0;
  self._id_A3FE = var_1;
}

_id_8AEC() {
  var_0 = self.origin + (0, 0, 3);

  if(_func_0034(var_0) && self isonground() && !scripts\mp\utility\entity::_id_F394()) {
    return 1;
  } else {
    return 0;
  }
}

_id_E35E(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_4 = var_0.origin;
  var_0.pers["useNVG"] = 0;

  if(var_0 _meth_8632()) {
    var_0.pers["useNVG"] = 1;
  }

  var_5 = 1;

  if(istrue(level._id_A790)) {
    waitframe();
    var_5 = !scripts\mp\utility\player::isreallyalive(var_0) && !istrue(var_0.inlaststand);

    if(var_5) {
      var_5 = var_5 && !var_0 scripts\mp\playerlogic::_id_9CCD();
    }
  }

  var_6 = level._id_908E;

  if(var_6 != 0) {
    var_0._id_F283 = var_6;
  }

  if(var_0 scripts\mp\utility\player::_id_8ACE()) {
    var_0._id_C7EF = 1;
    var_0 waittill("stopped_using_remote");
    var_0._id_C7EE = 1;
  } else {
    var_0._id_C7EE = 1;
    wait 3;
  }

  if(istrue(var_0._id_F283)) {
    var_0 thread _id_C7ED(var_6);
  }

  if(!var_5) {
    return;
  }
  if(isagent(var_0) || !isDefined(var_0)) {
    return;
  } else {
    if(!isDefined(var_0._id_C7BC)) {
      var_0._id_C7BC = var_0.class;
    }

    var_7 = var_0 scripts\mp\class::_id_962E(var_0._id_C7BC);
    var_8 = var_0 scripts\mp\playerlogic::_id_6C42(var_7);
    var_0 scripts\mp\playerlogic::_id_96A6([var_8], 1);
  }

  if(isDefined(var_1) && isagent(var_1)) {
    var_1 = var_1.owner;
  }

  var_9[0] = spawn("script_model", (0, 0, 0));
  var_10 = var_9[0];
  var_9[0] setModel("tag_origin");

  if(istrue(level._id_A790)) {
    var_9[0] _meth_82F9(var_0);
  }

  var_9[0] setasgametypeobjective();
  var_11 = 0;
  var_12 = var_0.team;
  var_11 = level._id_908B;

  if(isDefined(var_0.attacker) && isDefined(var_0.attacker.classname) && var_0.attacker.classname == "trigger_hurt" && isDefined(var_0._id_A3FE)) {
    var_4 = var_0._id_A3FE;
  } else if(isDefined(var_0._id_C7F6)) {
    var_4 = var_0._id_C7F6;
  } else {
    var_13 = var_0 _meth_815E();

    if(isDefined(var_13)) {
      var_4 = var_13.origin;
    } else {
      var_4 = var_0.origin;
    }
  }

  var_14 = ["physicscontents_playerclip"];
  var_15 = physics_createcontents(var_14);
  var_16 = scripts\engine\trace::_id_E409(var_4 + (0, 0, 10), var_4 + (0, 0, 30), 2.0, undefined, var_15, 1);
  var_4 = var_16["position"];
  var_10.team = var_0.team;
  var_10._id_4823 = var_4;
  level._id_C7F4[var_0.guid] = _id_07D6::_id_3FF1(var_12, var_10, var_9, (0, 0, 0));
  level._id_C7F4[var_0.guid].trigger _id_9A0C(var_0.team, istrue(level._id_A797));
  level._id_C7F4[var_0.guid]._id_ADAE = var_0.team;
  level._id_C7F4[var_0.guid].trigger.owner = var_0;
  level._id_C7F4[var_0.guid].trigger._id_7C8C = "laststand_reviver";
  level._id_C7F4[var_0.guid]._id_83B6 = "friendly";
  level._id_C7F4[var_0.guid]._id_4143 = 0;
  level._id_C7F4[var_0.guid]._id_FEE7 = var_11;
  level._id_C7F4[var_0.guid]._id_45CC = var_11;
  level._id_C7F4[var_0.guid]._id_FEB1 = 1;
  level._id_C7F4[var_0.guid]._id_7C8C = "laststand_reviver";
  level._id_C7F4[var_0.guid]._id_56E2 = 0;
  level._id_C7F4[var_0.guid]._id_56E1 = 1;
  level._id_C7F4[var_0.guid]._id_DDC9 = 1;
  level._id_C7F4[var_0.guid]._id_DDB5 = 1;
  level._id_C7F4[var_0.guid]._id_AA79 = ::_id_C7F1;
  level._id_C7F4[var_0.guid]._id_ABCB = ::_id_C7F0;
  level._id_C7F4[var_0.guid]._id_AAC2 = ::_id_C7F2;
  level._id_C7F4[var_0.guid]._id_AA80 = ::_id_C7F3;
  level._id_C7F4[var_0.guid].trigger setcursorhint("HINT_BUTTON");
  level._id_C7F4[var_0.guid].trigger setuseholdduration("duration_none");
  level._id_C7F4[var_0.guid].trigger _meth_84D1(1);
  level._id_C7F4[var_0.guid].trigger _meth_84D7("tag_origin");
  level._id_C7F4[var_0.guid].trigger _meth_83A1(-2);
  level._id_C7F4[var_0.guid].trigger _meth_84D4(96);
  level._id_C7F4[var_0.guid].trigger sethintdisplayfov(120);
  level._id_C7F4[var_0.guid].trigger setuserange(96);
  level._id_C7F4[var_0.guid].trigger setusefov(360);
  level._id_C7F4[var_0.guid].trigger _meth_84D9("hide");
  level._id_C7F4[var_0.guid].trigger._id_0481 = "revive_trigger";

  if(!scripts\cp_mp\utility\game_utility::_id_89EC()) {
    level._id_C7F4[var_0.guid].trigger sethintstring(&"MP/LASTSTAND_REVIVE_USE");
  } else {}

  level._id_C7F4[var_0.guid] _id_07D6::_id_D8D2(var_11);
  level._id_C7F4[var_0.guid]._id_103C2 = var_0;
  level._id_C7F4[var_0.guid]._id_103CC = var_0.team;
  var_0 thread _id_C7F8(level._id_C7F4[var_0.guid]);
  var_0 thread _id_C7F7(level._id_C7F4[var_0.guid]);
  level._id_C7F4[var_0.guid]._id_43EF = 1;
  level._id_C7F4[var_0.guid]._id_4140 = var_4;
  level._id_C7F4[var_0.guid].trigger.origin = var_4;
  level._id_C7F4[var_0.guid]._id_10430[0].origin = var_4;
  level._id_C7F4[var_0.guid] _id_07D6::_id_81EA();

  if(isDefined(var_1)) {
    level._id_C7F4[var_0.guid].attacker = var_1;
    level._id_C7F4[var_0.guid]._id_1DE3 = var_1.team;
  }

  var_0._id_5EC7 = var_4;
  var_0._id_5EC2 = var_0.angles;
  var_0 thread _id_117E(level._id_C7F4[var_0.guid], var_0, var_0.team);
  level notify(var_2, level._id_C7F4[var_0.guid]);
  level notify("player_last_stand");
  var_0 scripts\mp\playerlogic::_id_D496(0);

  if(isDefined(level._id_A790) && level._id_A790) {
    var_0._id_0407 = "hud_status_revive_wh";
  }
}

_id_9A0C(var_0, var_1) {
  self makeuseable();
  thread _id_0DAE(var_0, var_1);
}

_id_0DAE(var_0, var_1) {
  self notify("start_team_trigger");
  self endon("start_team_trigger");
  self endon("death");

  for(;;) {
    foreach(var_3 in level.players) {
      if(!var_1) {
        var_3._id_A797 = 1;
      }

      if(var_3.team == var_0 && var_3._id_A797 && !istrue(var_3 scripts\mp\utility\perk::_hasperk("specialty_revive_use_weapon"))) {
        self _meth_80E0(var_3);
      } else {
        self disableplayeruse(var_3);
      }

      if(istrue(var_3 scripts\mp\utility\perk::_hasperk("specialty_revive_use_weapon"))) {
        var_3._id_7888[self getentitynumber()] = self;
      }
    }

    level waittill("joined_team");
  }
}

_id_0DAD(var_0) {
  self endon("death");

  foreach(var_2 in level.players) {
    if(var_2 != var_0) {
      self disableplayeruse(var_2);
      self hidefromplayer(var_2);
    }
  }
}

_id_C7ED(var_0) {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  self endon("trigger_removed");
  level endon("game_ended");
  self endon("team_eliminated");
  var_1 = level._id_C7F4[self.guid];
  level waittill("new_trigger_spawned", var_1);
  var_2 = var_0;

  for(;;) {
    waitframe();
    var_3 = var_0;

    if(!istrue(scripts\mp\playerlogic::_id_690A())) {
      var_0 = var_0 - level._id_5F3A;
      self._id_F215 = var_0;
      self setclientomnvar("ui_securing_progress", min(var_0 / var_3, 0.01));
      self setclientomnvar("ui_securing", 0);
    }

    if(level._id_EF6A[self.team]["aliveCount"] > 0) {
      _id_0A99::_id_D5EA(5, int(gettime() + var_0 * 1000));
    }

    if(istrue(self._id_5144)) {
      thread _id_C536(self.guid, 1);
      self notify("trigger_removed");
      return;
    }

    if(var_0 <= level._id_5F3A) {
      self notify("last_stand_bleedout");
      thread _id_C536(self.guid, 1, 1);

      if(scripts\mp\utility\game::getgametype() == "arm") {
        _id_0A99::_id_D5EA(18);
      } else {
        _id_0A99::_id_D5EA(2);
        thread scripts\mp\playerlogic::_id_C522(3.0);
      }

      self notify("trigger_removed");
      break;
    } else if(istrue(self._id_24C6)) {
      thread _id_C536(self.guid, 1);
      _id_0A99::_id_D5EA(0);
      self notify("trigger_removed");
      break;
    }
  }
}

_id_C536(var_0, var_1, var_2) {
  self._id_C7EE = undefined;

  if(isDefined(level._id_C7F4[var_0])) {
    if(isDefined(level._id_C7F4[var_0]._id_5430)) {
      level._id_C7F4[var_0]._id_5430 _id_C538(self);
    }

    level._id_C7F4[var_0] _id_C538(self);
    waitframe();

    if(isDefined(level._id_C7F4[var_0]._id_5430)) {
      level._id_C7F4[var_0]._id_5430 _id_C53C();
      level._id_C7F4[var_0]._id_5430 = undefined;
    }

    if(isDefined(level._id_C7F4[var_0])) {
      level._id_C7F4[var_0] _id_C53C();
    }

    level._id_C7F4[var_0] = undefined;

    if(isDefined(var_2)) {
      self._id_5EC7 = undefined;
      self._id_5EC2 = undefined;
    }
  }
}

_id_C538(var_0) {
  self notify("disabled");

  if(isDefined(self._id_43EF)) {
    if(isDefined(var_0._id_8FE8)) {
      var_0._id_8FE8 delete();
    }

    self._id_43EF = undefined;
  }

  _id_07D6::_id_15DF("none");
  self notify("reset");
}

_id_C53C() {
  self notify("death");

  for(var_0 = 0; var_0 < self._id_10430.size; var_0++) {
    if(isDefined(self._id_10430[var_0])) {
      self._id_10430[var_0] delete();
    }
  }

  if(!isDefined(self._id_DDB5)) {
    thread _id_07D6::_id_479D();
  }
}

_id_C31E(var_0) {
  var_1 = var_0 + (0, 0, 5);
  var_2 = level._id_C7F4[self.guid].trigger;
  var_2._id_4823 = var_1;
  var_2._id_4140 = var_1;
  var_2.origin = var_1;
  level._id_C7F4[self.guid]._id_10430[0].origin = var_1;
  self._id_5EC7 = var_1;
  self._id_8FE8.origin = var_1;
}

_id_C7F8(var_0) {
  level endon("game_ended");
  self endon("trigger_removed");
  var_0 endon("death");

  for(;;) {
    scripts\engine\utility::waittill_any_2("disconnect", "joined_team");
    thread _id_C536(self.guid, 1, 1);
  }
}

_id_C7F7(var_0) {
  level endon("game_ended");
  self endon("trigger_removed");
  var_0 endon("death");

  for(;;) {
    self waittill("joined_spectators");

    if(self.team == "spectator") {
      thread _id_C536(self.guid, 1, 1);
    }
  }
}

_id_AB8E(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.pers)) {
    waitframe();
  }

  var_2 = scripts\mp\rank::getscoreinfovalue(var_0);

  if(istrue(var_1._id_EAF5)) {
    var_2 = 0;
  }

  thread _id_0A9F::_id_7003(var_0, undefined, var_2);
}

_id_936D(var_0) {
  if(istrue(level._id_A797)) {
    var_0._id_A797--;
  }

  if(isDefined(var_0.pers["rescues"])) {
    var_0.pers["rescues"]++;
    var_0 scripts\mp\persistence::_id_E770("round", "rescues", var_0.pers["rescues"]);

    switch (scripts\mp\utility\game::getgametype()) {
      case "cyber":
      case "siege":
      case "sr":
        var_0 scripts\mp\utility\stats::_id_D551(var_0.pers["rescues"]);
    }
  }

  var_1 = [];
  var_1[var_1.size] = self._id_103C2;

  if(isDefined(self._id_103C2)) {
    level notify("tr_player_respawned", self._id_103C2);
    self._id_103C2 thread scripts\mp\rank::_id_CC00("revived");
    self._id_103C2 _id_0A8D::_id_9137("revived");

    if(!level.gameended) {
      self._id_103C2 scripts\mp\utility\player::_freezecontrols(0);

      if(istrue(self._id_9075)) {
        scripts\mp\utility\stats::_id_7DAE("clutchRevives", 1);
      }

      self._id_103C2 thread _id_C671();
    }

    self._id_103C2._id_C7EE = undefined;
    self._id_103C2._id_0407 = "";
    _id_07BC::_id_AB7C(var_0, self._id_103C2);
  }

  var_0 thread _id_AB8E("reviver", self._id_103C2);

  if(!isDefined(var_0._id_C596)) {
    var_0._id_C596 = [];
  }

  var_0._id_C596[self._id_103C2.guid] = 1;
  _id_07CE::_id_C7E1(var_0, self._id_103C2);
}

_id_936E(var_0) {
  if(isDefined(self._id_103C2)) {
    self._id_103C2 thread scripts\mp\hud_message::showsplash("sr_eliminated");
    level notify("sr_player_eliminated", self._id_103C2);
  }

  var_1 = [];
  var_1[var_1.size] = self._id_103C2;
  scripts\mp\hud_message::_id_A6B6("sr_ally_eliminated", "sr_enemy_eliminated", self._id_103C2.team, var_1);

  if(isDefined(self._id_103C2)) {
    if(!level.gameended) {
      self._id_103C2 _id_0A99::_id_D5EA(2);
      self._id_103C2 thread scripts\mp\playerlogic::_id_C522(3.0);
    }

    self._id_103C2._id_C7EE = undefined;
    self._id_103C2._id_0407 = "hud_status_dead";
  }

  if(self.attacker != var_0) {
    self.attacker thread _id_AB8E("kill_confirmed");
  }

  var_0 thread _id_AB8E("kill_confirmed");
  var_0 _id_0A8D::_id_9137("kill_confirmed");
}

_id_C671() {
  self._id_1643 = 1;
  scripts\mp\playerlogic::_id_7DE8(self.team, 1);
  thread scripts\mp\playerlogic::_id_1094C(1);
}

_id_C7F0(var_0) {
  if(isDefined(var_0.owner)) {
    var_0 = var_0.owner;
  }

  if(var_0.pers["team"] == self._id_103CC) {
    if(isDefined(self._id_103C2._id_25CA)) {
      self._id_103C2._id_25CA delete();
    }

    var_0 scripts\mp\utility\stats::_id_7DAE("denied", 1);
    var_0 scripts\mp\persistence::_id_E770("round", "denied", var_0.pers["denied"]);

    if(istrue(level._id_A790)) {
      _id_936D(var_0);
    }
  } else if(level._id_A790) {
    _id_936E(var_0);
    var_0 _id_0A99::_id_D5EA(2);
  }

  var_0 setclientomnvar("ui_securing", 0);
  var_0 setclientomnvar("ui_securing_progress", 0.01);
  var_0._id_F913 = undefined;
  self._id_103C2 notify("trigger_removed");
  self._id_103C2 thread _id_C536(self._id_103C2.guid);
}

_id_C7F1(var_0, var_1) {
  var_2 = self.trigger.owner;
  var_2 scripts\mp\playerlogic::_id_D496(1);

  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_medic")) {
    var_3 = level._id_C7F4[var_2.guid]._id_45CC;
    level._id_C7F4[var_2.guid] _id_07D6::_id_D8D2(var_3 * getdvarfloat("#x32c934f652434d3aa"));
  }

  self.trigger thread _id_0DAD(var_0);
  var_2._id_C7E9 = var_0;
  var_2 scripts\mp\playerlogic::_id_D496(1);
  level thread scripts\mp\battlechatter_mp::_id_F759(var_0, "reviving");

  if(!istrue(var_1)) {
    var_0 thread _id_15B3(0);
  }

  var_2 scripts\mp\utility\player::_id_BD21("teamrevive::reviveTriggerHoldOnUseBegin() Killcam SKIPPED");
  var_2 notify("abort_killcam");
  var_2._id_315D = 1;
  var_2 scripts\mp\utility\player::_freezecontrols(1);
  var_4 = var_0 getEye();
  var_5 = _id_6CF3(var_2, var_0);
  var_6 = var_5.origin;
  var_7 = var_5.angles;
  var_2._id_5EC2 = (0, var_7[1], 0);
  waitframe();
  var_2 scripts\mp\utility\player::_id_FD26("spectator");
  var_2 _id_081A::_id_D512();
  waitframe();

  if(isDefined(level._id_C7F4[var_2.guid]._id_75ED)) {
    if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
      var_8 = "hud_realism_head_reviving";
    } else {
      var_8 = "hud_icon_cyber_reviving";
    }

    _func_0356(level._id_C7F4[var_2.guid]._id_75ED, var_8);
  }

  var_9 = spawn("script_model", var_6);
  var_9 setModel("tag_origin");
  var_9.angles = var_7;
  var_2._id_C7DD = var_9;
  var_2 cameralinkto(var_9, "tag_origin", 1);
  var_2 thread _id_C7DE();

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    var_2 thread _id_19DF();
  }

  var_2 thread _id_CA72();
}

_id_6CF3(var_0, var_1) {
  var_2 = level._id_C7F4[var_0.guid]._id_4140;
  var_3 = var_2;
  var_4 = vectornormalize(var_1.origin - var_3);
  var_5 = 2;
  var_6 = 30;
  var_7 = 360 / var_6;
  var_8 = 1;
  var_9 = 1;
  var_10 = 100;
  var_11 = _func_030A(var_4, (0, 0, 1));
  var_12 = 0;
  var_13 = undefined;
  var_14 = 0;
  var_15 = var_3;
  var_16 = var_11;

  while(var_8 < var_7) {
    if(var_12) {
      var_12 = 0;
      var_13 = anglesToForward(var_11);
    } else {
      var_13 = anglesToForward(var_11 + (0, scripts\engine\utility::ter_op(var_9, var_6, var_6 * -1) * var_8, 0));
      var_9 = !var_9;

      if(var_9 == 1) {
        var_8++;
      }
    }

    var_17 = var_3 + (0, 0, 12);
    var_18 = var_3 + var_13 * var_10 + (0, 0, 100);
    var_19 = scripts\engine\trace::_id_E409(var_17, var_18, var_5, [var_1]);
    var_20 = 30;
    var_21 = var_19["position"];
    var_22 = 0;

    if(var_19["fraction"] < 1) {
      var_21 = var_21 + var_13 * var_5;
      var_22 = 1;
    }

    if(var_19["fraction"] > 0.99) {
      var_15 = var_21;
      var_16 = vectortoangles(var_13);
      break;
    }
  }

  var_23 = spawnStruct();
  var_23.origin = var_15;
  var_24 = vectornormalize(var_3 - var_15);
  var_23.angles = vectortoangles(var_24);
  return var_23;
}

_id_C7DE(var_0) {
  var_1 = self._id_C7DD.origin + anglesToForward(self._id_C7DD.angles) * 3.0;
  var_2 = self._id_C7DD.origin + anglesToForward(self._id_C7DD.angles) * 50.0;
  var_3 = scripts\engine\trace::_id_E409(var_1, var_2, 2.0, undefined)["position"];
  var_4 = level._id_C7F4[self.guid]._id_FEE7 / 1000;
  self._id_C7DD moveto(var_3, var_4, var_4 * 0.3, var_4 * 0.3);
}

_id_19DF() {
  self notify("stopNVGOnRevive");
  self endon("stopNVGOnRevive");
  wait 1;
  self _meth_8249(1);
}

_id_477E(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");
  var_0 delete();
}

_id_15B3(var_0) {
  scripts\common\utility::_id_1554(var_0);
  scripts\common\utility::_id_154E(var_0);
  scripts\mp\utility\player::_id_1543(var_0);
  scripts\common\utility::_id_1562(var_0);
}

_id_A228(var_0, var_1, var_2) {
  var_3 = 1.0;
  var_4 = 1.0;
  self moveto(var_0, 1.0, 0.5, 0.5);
  var_1 = (-9.5111, var_2.angles[1], 0);
  self rotateto(var_1, 1.0, 0.5, 0.5);
}

_id_C7F2(var_0, var_1, var_2, var_3) {
  if(isDefined(self.trigger.owner)) {
    var_4 = self.trigger.owner;
    var_5 = level._id_C7F4[var_4.guid]._id_45CC;
    level._id_C7F4[var_4.guid] _id_07D6::_id_D8D2(var_5);
    var_4 scripts\mp\playerlogic::_id_D496(0);

    if(var_2) {
      if(!isDefined(var_4._id_C7DF)) {
        var_4._id_C7DF = 1;
      } else {
        var_4._id_C7DF++;
      }

      var_6 = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveHealth");
      _id_07A9::_id_977B(var_4, var_6, var_1);
      var_4 setclientomnvar("ui_reviver_id", -1);
      var_4 setclientomnvar("ui_securing", 0);
    } else {
      self.trigger thread _id_0DAE(var_4.team, istrue(level._id_A797));

      if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
        var_7 = "hud_realism_head_revive";
      } else {
        var_7 = "hud_icon_cyber_revive";
      }

      if(isDefined(level._id_C7F4[var_4.guid]._id_75ED)) {
        _func_0356(level._id_C7F4[var_4.guid]._id_75ED, var_7);
      }

      var_4 scripts\mp\utility\player::_freezecontrols(0);
      var_4 scripts\mp\utility\player::_id_FD26("spectator");
      var_4 _meth_8060();
      var_4._id_C7DD delete();

      if(isDefined(var_4.team) && var_4.team != "spectator") {
        var_4 _meth_8013(var_4.team, 1);

        foreach(var_9 in level._id_EF89) {
          if(var_9 != var_4.team) {
            var_4 _meth_8013(var_9, 0);
          }
        }

        var_4 _meth_8606(var_1 getentitynumber());
      }
    }
  }

  if(!istrue(var_3)) {
    var_1 thread _id_15B3(1);
  }

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_securing", 0);
    var_1 setclientomnvar("ui_securing_progress", 0.01);
    var_1._id_F913 = undefined;
  }

  if(var_2) {
    var_1 scripts\mp\utility\stats::_id_7DAE("revives", 1);

    if(istrue(var_1._id_9075)) {
      var_1 scripts\mp\utility\stats::_id_7DAE("clutchRevives", 1);
    }
  }
}

_id_C7F3(var_0) {
  var_0 scripts\mp\hud_message::_id_DCA2("MP/PLAYER_ALREADY_BEING_REVIVED");
}

_id_117E(var_0, var_1, var_2) {
  if(!level.teambased) {
    return;
  }
  var_3 = var_0._id_10430[0].origin;
  var_1 endon("spawned_player");
  var_1 endon("disconnect");
  wait 0.05;
  scripts\mp\utility\script::_id_1096C();

  if(getDvar("#x3c7bd43665e01a790") == "0") {
    return;
  }
  _id_078F::_id_D593(self._id_8FE7);

  if(isDefined(self._id_8FE8)) {
    self._id_8FE8 delete();
  }

  self notify("revived_death_icon");

  if(!isDefined(var_2) || var_2 == "spectator") {
    return;
  }
  self._id_8FE8 = spawn("script_model", var_3);
  self._id_8FE8 setModel("tag_origin");
  self._id_8FE8.team = var_2;

  if(scripts\cp_mp\utility\game_utility::_id_89EC() || level._id_74C4) {
    var_4 = 0;
    var_5 = 500;
    var_6 = 100;
    var_7 = "hud_realism_head_revive";
  } else {
    var_4 = 1;
    var_5 = 8000;
    var_6 = 100;
    var_7 = "hud_icon_cyber_revive";
  }

  var_0._id_75ED = self._id_8FE8 thread _id_078F::_id_D598(var_2, var_7, undefined, undefined, 0, var_4, var_5, var_6);

  if(level._id_DCA1) {
    _func_0357(var_0._id_75ED, "hud_icon_death_hunter_spawn");

    foreach(var_9 in level._id_EF89) {
      _func_035F(var_0._id_75ED, var_9);
    }
  }
}

_id_CA72() {
  self notify("end_spawn_zoom");
  self endon("end_spawn_zoom");
  level endon("game_ended");
  self waittill("spawned_player");
  var_0 = self getEye();
  var_1 = self.angles;
  self cameralinkto(self._id_C7DD, "tag_origin", 1);
  self._id_C7DD moveto(var_0, 0.25, 0.1, 0.1);
  self._id_C7DD rotateto(var_1, 0.25, 0.1, 0.1);
  wait 0.25;
  self visionsetnakedforplayer("", 0.1);
  self _meth_8060();
  self._id_C7DD delete();
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "revived");
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
  var_0.alpha = 1;
  var_0._id_01D6 = 1;
  var_0 setshader("white", 640, 480);
  var_0 fadeovertime(0.4);
  var_0.alpha = 0.0;
  wait 0.4;
  var_0 destroy();
}

_id_389C() {
  foreach(var_1 in level._id_C7F4) {
    var_1 _id_07D6::_id_15DF("none");
    var_1 notify("reset");
    _id_078F::_id_D593(var_1._id_8FE7);

    if(isDefined(var_1._id_8FE8)) {
      var_1._id_8FE8 delete();
    }
  }
}

_id_FD67() {}

_id_1D27(var_0) {
  self._id_83B7 = var_0;

  foreach(var_2 in level.players) {
    _id_19EF(var_2);
  }
}

_id_19EF(var_0) {
  if(var_0.team == self._id_ADAE) {
    self._id_10430[0] showtoplayer(var_0);
  } else {
    self._id_10430[0] hidefromplayer(var_0);
  }
}

_id_1085B() {
  self endon("disconnect");
  self endon("started_spawnPlayer");
  self endon("team_eliminated");
  var_0 = 0;

  for(;;) {
    if(self useButtonPressed()) {
      while(self useButtonPressed()) {
        var_0 = var_0 + 0.05;

        if(var_0 >= 1.0) {
          break;
        }

        wait 0.05;
      }

      if(var_0 >= 0.5) {
        var_0 = var_0 + 0.05;
      }
    }

    var_0 = 0;
    wait 0.05;
  }
}