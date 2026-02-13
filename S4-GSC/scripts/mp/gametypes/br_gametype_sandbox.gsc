/********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_sandbox.gsc
********************************************************/

init() {
  scripts\mp\gametypes\br_gametypes::_id_4AB8("circle");
  scripts\mp\gametypes\br_gametypes::_id_4AB8("infil");
  scripts\mp\gametypes\br_gametypes::_id_4AB8("gulag");
  scripts\mp\gametypes\br_gametypes::_id_4AB8("teamSpectate");
  scripts\mp\gametypes\br_gametypes::_id_4AB8("oneLife");
  scripts\mp\gametypes\br_gametypes::_id_5254("dropBagLoop");
  scripts\mp\gametypes\br_gametypes::_id_5254("allowLateJoiners");
  scripts\mp\gametypes\br_gametypes::_id_5254("tabletReplace");
  var_0 = getdvarint("#x3989f19ff52f8cade", 300);
  scripts\mp\gametypes\br_gametypes::_id_C242("dropBagDelay", var_0);
  scripts\mp\gametypes\br_gametypes::_id_C243("playerWelcomeSplashes", ::_id_B821);
  scripts\mp\gametypes\br_gametypes::_id_C243("spawnHandled", ::_id_E2F8);
  scripts\mp\gametypes\br_gametypes::_id_C243("onPlayerKilled", ::_id_AB70);
  scripts\mp\gametypes\br_gametypes::_id_C243("onPlayerConnect", ::onplayerconnect);
  level._id_2BB5._id_583F = getdvarint("#x3e0755aa12aeef5b7", 0);

  if(level._id_2BB5._id_583F) {
    level._id_2BB5._id_A77F = 0;
    scripts\mp\gametypes\br_gametypes::_id_C243("postPlunder", ::_id_B759);
    scripts\mp\gametypes\br_gametypes::_id_C243("postBankPlunder", ::_id_B759);
    scripts\mp\gametypes\br_gametypes::_id_C243("playerDropPlunderOnDeath", ::_id_B69D);
  }

  level._id_2BB5._id_8D6E = 0;
  level._id_2BB5._id_9C7F = getdvarint("#x3f23463f8bcf928d", 5000);
  level._id_2BB5._id_F216 = getdvarint("#x32b9d8e10e74c1b16", 1500);
  setDvar("#x31d612510c03263f1", getdvarint("#x313731b19dd1800f3", 0));
  level._id_2BB5._id_9C96 = 0;
  level._id_2BB5._id_48B8 = getDvar("#x38f0fd92c8119f5d9", "kills");
  level._id_2BB5._id_9142 = getdvarint("#x35227c758efc289a3", 0);
  level._id_2BB5._id_9143 = getdvarint("#x35227c758efc289a3", 100);
  level._id_2BB5._id_8BDB = getdvarint("#x37b5bd55bebbe8b85", 900);
  level._id_2BB5._id_4F47 = getdvarint("#x383fd65fceab7186c", 1);
  level._id_2BB5._id_5BDE = "tie";
  level._id_BBAE = 0;
  level._id_2A60 = 1;
  level._id_DDC3 = 1;
  thread _id_8274();
}

_id_8274() {
  waittillframeend;
  level._id_9FE5 = ::_id_2BED;
  level._id_9FE8 = ::_id_ABA4;
  level._id_6D4A = ::_id_B6BA;
  level._id_AE38 = ::_id_253E;
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "gameModeSupportsRespawn", ::_id_10284);
  level.vehicle._id_E09E._id_C69F = getdvarint("#x3516ed51103ead6f1", 30);
  thread _id_D876();
  thread _id_D8BB();

  if(level._id_2BB5._id_583F) {
    thread scripts\mp\gametypes\br_gametype_extraction::_id_D8B9();
  }

  if(level._id_2BB5._id_9C96) {
    thread _id_D8BA();
  }

  if(level._id_2BB5._id_9142) {
    thread _id_CA4A();
  }

  if(level._id_2BB5._id_8BDB) {
    thread _id_CA46();
  }

  if(level._id_2BB5._id_4F47) {
    thread _id_CA32();
  }
}

_id_253E() {}

_id_10284() {
  return 1;
}

onplayerconnect(var_0) {
  var_0 _id_078A::_id_2F99();
}

_id_ABA4() {
  self notify("br_spawned");
  var_0 = istrue(self._id_7262);
  scripts\mp\gametypes\br_pickups::_id_825B(var_0);
  scripts\mp\gametypes\br_functional_poi::_id_825B();
  scripts\mp\gametypes\br_armor::_id_813B();
  self._id_AA39 = undefined;
  self._id_A459 = undefined;
  self._id_7647 = 0;
  self._id_2A6D = gettime();
  self._id_A417 = undefined;
  self._id_72C3 = undefined;
  level._id_EB1C = 0;
  level._id_EB3C = 1;
  self._id_2A86 = [0, 0, 0, 0, 0];
  self._id_2A85 = 0;

  if(level._id_AE25) {
    self _meth_876C();
  } else {
    self _meth_876D();
  }

  if(level._id_AE26) {
    self _meth_876A();
  } else {
    self _meth_876B();
  }
}

_id_B821(var_0) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_sandbox_welcome");
}

_id_E2F8(var_0) {
  var_0 thread _id_B7CA();
  return 1;
}

_id_2BED(var_0) {
  var_0 thread _id_B768();
  return 1;
}

_id_B768() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = getdvarfloat("#x3ebf36a72b36a8406", 0);
  var_1 = int(gettime() + var_0 * 1000);

  if(var_0 > 0) {
    _id_0A99::_id_D5EA(9, var_1);
  }

  var_2 = 1.0;
  wait(var_2);
  var_3 = 1.0;
  thread scripts\mp\gametypes\br_gulag::_id_58BC(var_3);
  var_1 = var_1 - var_3 * 1000;
  var_4 = var_1 - gettime();

  if(var_4 > 0) {
    wait(var_4 / 1000);
  }

  wait(var_3);
  _id_B7CA();
}

_id_B7CA() {
  self.class = scripts\mp\gametypes\br::_id_B074();
  self._id_BBED = _id_B6BA();
  scripts\mp\playerlogic::_id_107DC(0);
  self freezecontrols(1);
  thread scripts\mp\gametypes\br::_id_BBA2();
  waitframe();
  scripts\mp\gametypes\br::_id_6FAF(self);
  scripts\mp\gametypes\br_armor::_id_6FF3();
  var_0 = getdvarint("#x322f3614fde3c00cd", -1);

  if(var_0 == -2) {
    foreach(var_2 in [self._id_034C, self._id_03B5]) {
      if(isDefined(var_2)) {
        var_3 = weaponclipsize(var_2);
        self setweaponammoclip(var_2, var_3);
        self givemaxammo(var_2);
      }
    }

    scripts\mp\gametypes\br_weapons::_id_2A0C(self);
  } else if(var_0 == -1)
    scripts\mp\gametypes\br_weapons::_id_2A04();
  else if(var_0 > 0) {
    foreach(var_6 in [self._id_034C, self._id_03B5]) {
      if(isDefined(var_6)) {
        var_3 = weaponclipsize(var_6);
        self setweaponammoclip(var_6, var_3);
        var_2 = makeweaponfromstring(var_6);
        var_7 = scripts\mp\gametypes\br_weapons::_id_2A07(var_2);
        scripts\mp\gametypes\br_weapons::_id_29FB(self, var_7, var_3 * var_0);
      }
    }

    scripts\mp\gametypes\br_weapons::_id_2A0C(self);
  }

  self _meth_86B2(0);
  self _meth_86B3(0);
  var_9 = !self _meth_878F();

  if(var_9) {
    while(isalive(self) && isDefined(self.weaponlist) && !self _meth_851A(self.weaponlist)) {
      waitframe();
    }
  }

  self notify("brWaitAndSpawnClientComplete");
  self._id_10849 = 0;
  self freezecontrols(0);
}

_id_B7B0(var_0) {
  return 1;
}

_id_B6BA(var_0) {
  if(isDefined(self._id_BBED)) {
    var_1 = self._id_BBED;
    self._id_BBED = undefined;
    return var_1;
  }

  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = getdvarfloat("#x3c13c19d58157cb9f", 1000);

  if(var_5 >= 0) {
    var_6 = scripts\mp\gametypes\br_gulag::_id_B6B5();

    if(isDefined(var_6)) {
      var_2 = scripts\mp\gametypes\br_gulag::_id_6D04(var_6.origin, var_5);
      var_3 = scripts\mp\gametypes\br_gulag::_id_68BE(var_2, var_6.origin);
    }
  }

  var_5 = getdvarfloat("#x370564b9020935cb9", 3000);

  if(!isDefined(var_2) && var_5 >= 0) {
    var_7 = scripts\mp\gametypes\br_gulag::_id_B6B4();

    if(isDefined(var_7)) {
      var_2 = scripts\mp\gametypes\br_gulag::_id_6D04(var_7, var_5);
      var_3 = scripts\mp\gametypes\br_gulag::_id_68BE(var_2, var_7);
    }
  }

  var_5 = getdvarfloat("#x3384cf868934ba288", 3000);

  if(!isDefined(var_2) && var_5 >= 0) {
    var_8 = scripts\mp\gametypes\br_gulag::_id_B6B3();

    if(isDefined(var_8)) {
      var_2 = scripts\mp\gametypes\br_gulag::_id_6D04(var_8, var_5);
      var_3 = scripts\mp\gametypes\br_gulag::_id_68BE(var_2, var_8);
    }
  }

  if(!isDefined(var_2)) {
    var_9 = scripts\mp\gametypes\br::_id_6D4A(1);

    if(isDefined(var_9)) {
      var_2 = var_9.origin;
      var_3 = var_9.angles;
      var_4 = (0, 0, 0);
    }
  }

  var_2 = scripts\mp\gametypes\br::_id_6BCA(var_2, var_4);

  if(!isDefined(var_3)) {
    var_3 = (0, randomint(0, 360), 0);
  }

  var_1 = spawnStruct();
  var_1.origin = var_2;
  var_1.angles = var_3;
  var_1.index = -1;
  return var_1;
}

_id_2BAA() {
  wait 1.5;
  _id_7440();
  scripts\mp\gamelogic::_id_52FD(level._id_2BB5._id_5BDE, game["end_reason"]["objective_completed"], game["end_reason"]["br_eliminated"]);
}

_id_7440() {
  foreach(var_1 in level.players) {
    var_1 setclientomnvar("post_game_state", 2);
  }
}

_id_D8BB() {
  level endon("game_ended");
  var_0 = 120;
  _id_07D1::_id_60C2("prematch_done");

  if(level._id_2BB5._id_F216 <= 0) {
    return;
  }
  var_1 = scripts\mp\hud_util::_id_404A("default", 1.5);
  var_1 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 120, -170);
  setomnvar("ui_hardpoint_timer", gettime() + int(level._id_2BB5._id_F216 * 1000));
  var_1 _meth_8391(level._id_2BB5._id_F216);
  var_2 = max(level._id_2BB5._id_F216 - var_0, 0);
  wait(var_2);
  var_3 = max(level._id_2BB5._id_F216 - var_2, 0);
  var_1.color = (1, 0, 0);
  var_1 thread _id_7B61();
  thread _id_39B3(var_3);
  wait(var_3);
  var_1 destroy();
  _id_749F();
  thread _id_2BAA();
}

_id_D876() {
  if(!level._id_2BB5._id_9C7F) {
    return;
  }
  var_0 = 2;
  var_1 = -2;
  level._id_2BB5._id_7B68 = _id_3FF3(&"MP_BR_INGAME/SANDBOX_GLOBAL_KILLS", 0, "RIGHT", "CENTER", -120 + var_1, -170);
  level._id_2BB5._id_7B69 = _id_3FF3(&"MP_BR_INGAME/EXTRACT_MAX", level._id_2BB5._id_9C7F, "LEFT", "CENTER", -120 + var_0, -170);
}

_id_AB70(var_0) {
  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker) || !isDefined(var_0._id_103C2) || var_0.attacker == var_0._id_103C2) {
    return;
  }
  if(level.gameended) {
    return;
  }
  var_1 = var_0.attacker.team;

  if(!isDefined(level._id_EF6A[var_1]["kills"])) {
    level._id_EF6A[var_1]["kills"] = 0;
  }

  level._id_EF6A[var_1]["kills"]++;
  level._id_2BB5._id_8D6E++;

  if(level._id_2BB5._id_9C7F) {
    level._id_2BB5._id_7B68 _meth_83A3(level._id_2BB5._id_8D6E);

    if(level._id_2BB5._id_8D6E >= level._id_2BB5._id_9C7F) {
      _id_749F();
      thread _id_2BAA();
    }
  }
}

_id_749F() {
  var_0 = [];

  switch (level._id_2BB5._id_48B8) {
    case "plunder":
      var_0 = scripts\engine\utility::_id_1BD6(level._id_EF89, ::_id_3AFB);
      break;
    case "kills":
    default:
      var_0 = scripts\engine\utility::_id_1BD6(level._id_EF89, ::_id_3AFA);
      break;
  }

  level._id_2BB5._id_5BDE = var_0[0];
  var_1 = 1;
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(!isDefined(level._id_EF6A[var_4]["teamCount"]) || level._id_EF6A[var_4]["teamCount"] == 0) {
      continue;
    }
    var_5 = level._id_EF6A[var_4]["kills"];

    if(!isDefined(var_5)) {
      var_5 = 0;
    }

    if(var_3 > 0 && var_5 != var_2) {
      var_1++;
    }

    var_6 = var_1;
    var_2 = var_5;

    foreach(var_8 in level._id_EF6A[var_4]["players"]) {
      var_8 setclientomnvar("ui_br_player_position", var_6);

      if(var_6 > 1) {
        var_8 setclientomnvar("ui_br_squad_eliminated_active", 1);
        var_8 setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
        var_8 setclientomnvar("ui_round_end_reason", game["end_reason"]["br_eliminated"]);
      }
    }
  }
}

_id_3AFA(var_0, var_1) {
  var_2 = level._id_EF6A[var_0]["kills"];
  var_3 = level._id_EF6A[var_1]["kills"];

  if(!isDefined(var_2)) {
    return 0;
  } else if(!isDefined(var_3)) {
    return 1;
  } else {
    return var_2 > var_3;
  }
}

_id_3AFB(var_0, var_1) {
  var_2 = scripts\mp\gametypes\br_gametype_extraction::_id_6DD5(var_0);
  var_3 = scripts\mp\gametypes\br_gametype_extraction::_id_6DD5(var_1);

  if(!isDefined(var_2)) {
    return 0;
  } else if(!isDefined(var_3)) {
    return 1;
  } else {
    return var_2 > var_3;
  }
}

_id_3FF3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 1.5;

  if(isDefined(var_7)) {
    var_9 = newteamhudelem(var_7);
  } else {
    var_9 = newhudelem();
  }

  var_9.elemtype = "font";
  var_9.font = "default";
  var_9.fontscale = var_8;
  var_9._id_22B8 = var_8;
  var_9.x = 0;
  var_9.y = 0;
  var_9.width = 0;
  var_9.height = int(level.fontheight * var_8);
  var_9.xoffset = 0;
  var_9.yoffset = 0;
  var_9.children = [];
  var_9 scripts\mp\hud_util::setparent(level.uiparent);
  var_9.hidden = 0;
  var_9.alpha = 1;
  var_9 scripts\mp\hud_util::setpoint(var_2, var_3, var_4, var_5);

  if(isDefined(var_0)) {
    var_9.label = var_0;
  }

  if(isDefined(var_1)) {
    var_9 _meth_83A3(var_1);
  }

  if(isDefined(var_6)) {
    var_9.color = var_6;
  }

  return var_9;
}

_id_7B61() {
  self endon("death");

  if(istrue(self._id_BE2A)) {
    return;
  }
  var_0 = 0.5;
  var_1 = 4;
  self._id_BE2A = 1;
  var_2 = self.fontscale;
  self changefontscaleovertime(var_0);
  self.fontscale = var_1;
  wait(var_0);
  self changefontscaleovertime(var_0);
  self.fontscale = var_2;
  self._id_BE2A = undefined;
}

_id_39B3(var_0) {
  level endon("game_ended");
  _func_01EA("ui_final_moments_notify", gettime() + var_0 * 1000);

  while(var_0 > 0) {
    var_1 = 0;
    var_2 = scripts\mp\gamelogic::_id_6966(var_0);

    if(var_0 > 60 && var_0 % 10 == 0 || var_0 <= 60 && var_0 > 30 && var_0 % 2 == 0 || var_0 <= 30) {
      var_1 = 1;
    }

    if(var_1) {
      foreach(var_4 in level.players) {
        var_4 playlocalsound(var_2);
      }
    }

    var_0 = var_0 - 1;
    wait 1;
  }
}

_id_B69D(var_0) {
  var_1 = getdvarfloat("#x3f93baa8055f9b0e9", 0.0);
  var_2 = int(self._id_B956 * var_1);
  var_3 = self._id_B956 - var_2;
  var_4 = getdvarint("#x35cc91687b1e8f754", 10);
  var_3 = max(var_4, var_3);
  var_5 = getdvarint("#x3cf6974f3fc7ed6bf", 0);
  var_3 = var_3 + var_5;
  self._id_B95B = var_2;
  scripts\mp\gametypes\br_plunder::_id_B7A3(var_2);
  scripts\mp\gametypes\br_gametype_extraction::_id_5052(var_3, var_0);
  return 1;
}

_id_B759(var_0) {
  var_1 = scripts\mp\gametypes\br_gametype_extraction::_id_6DD5(self.team);
  var_2 = scripts\mp\gametypes\br_gametype_extraction::_id_6DD6(self.team);
  var_2._id_B956 = var_1;
  thread scripts\mp\gametypes\br_gametype_extraction::_id_4CF5(var_2, self.team);
  level notify("update_plunder_leaderboard");

  if(level._id_2BB5._id_9C96 && var_1 >= level._id_2BB5._id_9C96) {
    _id_749F();
    thread _id_2BAA();
  }
}

_id_D8BA() {
  var_0 = getdvarint("#x363223aa1e32eaddc", 3);
  var_1 = 14;
  var_2 = getdvarint("#x32fabcb6377809da4", -60);
  var_3 = getdvarint("#x3a53f59e168f47677", -400) + (var_0 + 1) * var_1;
  var_4 = -5;
  var_5 = _id_4049("default", 1);
  var_5 scripts\mp\hud_util::setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", var_2, var_3);
  var_5.label = &"MP/BR_PLUNDER_LEADER";
  var_6 = [];

  for(var_7 = 0; var_7 < var_0; var_7++) {
    var_6[var_7] = spawnStruct();
    var_6[var_7]._id_A3CD = _id_4049("default", 1);
    var_6[var_7]._id_A3CD scripts\mp\hud_util::setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", var_2 + var_4, var_3 + (var_7 + 1) * var_1);
    var_6[var_7]._id_A3CD.alpha = 0;
    var_6[var_7]._id_FF6D = _id_4049("default", 1);
    var_6[var_7]._id_FF6D scripts\mp\hud_util::setpoint("BOTTOM LEFT", "BOTTOM RIGHT", var_2, var_3 + (var_7 + 1) * var_1);
    var_6[var_7]._id_FF6D.label = &"MP/BR_PLUNDER_BLANK";
    var_6[var_7]._id_FF6D.alpha = 0;
  }

  for(;;) {
    var_8 = scripts\mp\utility\script::_id_BEF7(level._id_EF89, ::_id_3AFB);
    var_9 = 0;

    for(var_7 = 0; var_7 < var_8.size; var_7++) {
      var_10 = var_8[var_7];
      var_11 = scripts\mp\gametypes\br_gametype_extraction::_id_6DD5(var_10);

      if(var_7 == 0) {
        _id_FCA6(var_10, var_11);
      }

      if(!var_11) {
        break;
      }

      var_12 = scripts\mp\utility\teams::_id_6DCA(var_10, "players");

      if(!var_12.size) {
        continue;
      }
      var_13 = var_12[0];

      for(var_14 = 1; var_14 < var_12.size; var_14++) {
        if(var_12[var_14] scripts\mp\gametypes\br_public::_id_898B()) {
          var_13 = var_12[var_14];
          break;
        }
      }

      var_6[var_7]._id_A3CD _meth_8367(var_13);
      var_6[var_7]._id_FF6D _meth_83A3(var_11 * 100);
      var_6[var_7]._id_A3CD.alpha = 1;
      var_6[var_7]._id_FF6D.alpha = 1;
      var_9++;

      if(var_9 == var_0) {
        break;
      }
    }

    for(var_7 = var_9; var_7 < var_0; var_7++) {
      var_6[var_7]._id_A3CD.alpha = 0;
      var_6[var_7]._id_FF6D.alpha = 0;
    }

    level waittill("update_plunder_leaderboard");
  }
}

_id_4049(var_0, var_1) {
  var_2 = newhudelem();
  var_2.elemtype = "font";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2._id_22B8 = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 scripts\mp\hud_util::setparent(level.uiparent);
  var_2.hidden = 0;
  return var_2;
}

_id_CA4A() {
  level._id_9141 = spawnStruct();
  level._id_9141.team = undefined;
  level._id_9141._id_A8DD = [];
  level thread _id_10B98();
  level thread _id_FCA7();
}

_id_FCA6(var_0, var_1) {
  level notify("leadUpdate", var_0, var_1);
}

_id_10B98() {
  level endon("game_ended");
  var_0 = level._id_2BB5._id_9143;

  for(;;) {
    level waittill("leadUpdate", var_1, var_2);

    if(isDefined(level._id_9141.team) && level._id_9141.team == var_1 && var_2 > var_0) {
      continue;
    }
    if(isDefined(level._id_9141.team)) {
      _id_ABBB(level._id_9141.team);
    }

    if(var_2 > var_0) {
      _id_ABBA(var_1);
    }
  }
}

_id_10DF() {
  var_0 = _id_07F9::_id_C57D(1);

  if(var_0 != -1) {
    _id_07F9::_id_A867(var_0, "active", (0, 0, 0), "ui_mp_br_mapmenu_icon_vip_objective");
    _id_07F9::_id_FB98(var_0, 1);
    _id_07F9::_id_A8B1(var_0, 1);
    _func_018C(var_0);
    _func_0188(var_0);
    return var_0;
  }
}

_id_C4DD(var_0) {
  _id_07F9::_id_A89F(var_0);
  _id_07F9::_id_C799(var_0);
}

_id_ABBB(var_0) {
  level._id_9141.team = undefined;
}

_id_ABBA(var_0) {
  level._id_9141.team = var_0;
}

_id_EC45() {
  var_0 = 0;

  if(isDefined(level._id_9141.team)) {
    var_0 = scripts\mp\utility\teams::_id_6DCA(level._id_9141.team, "aliveCount");
  }

  var_1 = level._id_9141._id_A8DD.size;

  if(var_0 == var_1) {
    return;
  }
  var_2 = var_1 - var_0;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = level._id_9141._id_A8DD[level._id_9141._id_A8DD.size - 1];
    level._id_9141._id_A8DD[level._id_9141._id_A8DD.size - 1] = undefined;
    _id_C4DD(var_4);
  }

  var_5 = var_0 - var_1;

  for(var_3 = 0; var_3 < var_5; var_3++) {
    var_4 = _id_10DF();
    level._id_9141._id_A8DD[level._id_9141._id_A8DD.size] = var_4;
  }
}

_id_A233() {
  if(!isDefined(level._id_9141.team)) {
    return;
  }
  var_0 = scripts\mp\utility\teams::_id_6DCA(level._id_9141.team, "alivePlayers");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(level._id_9141._id_A8DD.size > var_1) {
      var_2 = var_0[var_1];
      var_3 = level._id_9141._id_A8DD[var_1];
      _id_07F9::_id_FB97(var_3, var_2.origin);
    }
  }
}

_id_FCA7() {
  level endon("game_ended");

  for(;;) {
    _id_EC45();
    _id_A233();
    waitframe();
  }
}

_id_CA46() {
  wait(level._id_2BB5._id_8BDB);
  level._id_15BE = 0;
  _func_01E7(1, 1);
  _func_01E6(1, 1);
}

_id_CA32() {
  if(!isDefined(level._id_BBB2)) {
    return;
  }
  var_0 = [];

  foreach(var_2 in level._id_BBB2) {
    [var_4, var_5] = ::scripts\mp\gametypes\br::_id_6C87(var_2);
    var_6 = _func_03EF(var_2.origin[0], var_2.origin[1], var_5);
    var_6 _meth_872C(11);
    var_6 _meth_872D(1);
    var_0[var_0.size] = var_6;
  }
}