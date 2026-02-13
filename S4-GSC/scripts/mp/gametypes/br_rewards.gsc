/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_rewards.gsc
*************************************************/

_id_7F0E() {
  _id_BD72();
  level._id_F1E6 = [];
  level._id_F1E6[3] = 0;
  level._id_F1E6[2] = 0;
  level._id_F1E6[1] = 0;
  level._id_F1E6[0] = 0;
}

_id_CA4E(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(!isDefined(var_0._id_C809)) {
    var_4 = _id_5AE5(var_0);

    if(!isDefined(var_4)) {
      var_4 = _id_2EE5(var_0, 64, 2048);
    }
  } else
    var_4 = var_0._id_C809;

  if(isDefined(var_2)) {
    thread _id_CA48(var_4, var_1, var_2);
  } else if(isDefined(var_3)) {
    thread _id_CA48(var_4, var_1, _id_6ADA(var_3));
  } else {
    thread _id_CA48(var_4, var_1, _id_6ADA(3));
  }
}

_id_CA48(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = undefined;

  if(!istrue(var_0._id_88D2)) {
    var_4 = 72;
  } else {
    var_4 = 40;
  }

  var_5 = _id_07D6::_id_4026(var_0.origin, "neutral", (0, 0, var_4), undefined, "any");
  _id_9B9D(var_5, var_1);
  var_5.origin = var_0.origin;
  var_5.angles = var_0.angles;
  thread _id_4C53(undefined, var_0, 16);
  var_5._id_7C73 = "_incoming";
  var_5._id_970A = 0;
  var_5 _id_07D6::_id_D61B(var_2);
  var_5._id_970A = 1;
  wait 3;
  wait 1;

  if(!istrue(var_0._id_88D2)) {
    var_3 = scripts\cp_mp\killstreaks\airdrop::_id_500C(var_1.team, var_2, var_0.origin, (0, randomint(360), 0), undefined);
    var_3._id_DDB4 = 1;
    var_3._id_A443 = 0;
    var_3._id_10813 = 1;
    var_3._id_8D8A = 0;
    var_3._id_4B06 = 1;
    var_3._id_8760 = 1;
    var_3 waittill("crate_dropped");
    var_5._id_FE90 = var_3;
    var_5.origin = var_3.origin;
  } else {
    var_5._id_FE90 = spawn("script_model", var_5.origin);
    var_5._id_FE90._id_4B06 = 1;
    var_5._id_FE90.cratetype = "arm_no_owner";
    var_6 = scripts\cp_mp\killstreaks\airdrop::_id_6B00(var_5._id_FE90.cratetype);
    var_5._id_FE90._id_9F23 = var_6._id_9F23;
    var_5._id_FE90._id_3234 = var_6._id_3234;
    var_5._id_FE90._id_C58F = var_6._id_C58F;
    var_5._id_FE90._id_EB9F = var_6._id_EB9F;
    var_5._id_FE90._id_8815 = 1;
    var_5._id_FE90._id_8760 = 1;
    var_5._id_FE90._id_4350 = scripts\cp_mp\killstreaks\airdrop::_id_68D0(var_2);
    _id_07F9::_id_FB93(var_5._id_A908, var_5._id_FE90);
    _id_07F9::_id_FB9D(var_5._id_A908, 40);
  }

  var_7 = 0;
  var_8 = 0.1;

  if(istrue(var_0._id_88D2)) {
    var_9 = 15;
  } else {
    var_9 = 1;
  }

  wait(var_9);

  if(!istrue(var_0._id_88D2)) {
    var_3 notify("objective_activate");
    _id_07F9::_id_FB93(var_5._id_A908, var_3);
    _id_07F9::_id_FB9D(var_5._id_A908, 72);
  } else {
    var_5._id_FE90 scripts\cp_mp\killstreaks\airdrop::_id_99E4();
    var_6 = scripts\cp_mp\killstreaks\airdrop::_id_6B00(var_5._id_FE90.cratetype);
    _id_07F9::_id_FB9D(var_5._id_A908, 40);
  }

  var_5._id_7C73 = "";
  var_5._id_970A = 0;
  var_5 _id_07D6::_id_D61B(var_2);
  var_5._id_970A = 1;
  _func_0167(var_5._id_A908, "");

  if(isDefined(var_3)) {
    var_3 waittill("death");
  } else {
    var_5._id_FE90 waittill("death");
  }

  var_5 _id_07D6::_id_D8E0("none");
  var_5 _id_07D6::_id_C300();
  var_5._id_1041A = "none";
}

_id_5028(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\killstreaks\airdrop::_id_500C(var_2, var_0, var_1.origin, (0, randomint(360), 0), undefined);
  return var_3;
}

_id_4C53(var_0, var_1, var_2) {
  var_3 = var_1.origin + (0, 0, 2000);
  var_4 = scripts\common\utility::groundpos(var_3, (0, 0, 1));
  var_1._id_103BE = spawn("script_model", var_4);
  var_1._id_103BE setModel("tag_origin");
  var_1._id_103BE.angles = (0, 0, 0);
  var_1._id_103BE playLoopSound("smoke_carepackage_smoke_lp");
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), var_1._id_103BE, "tag_origin");

  if(isDefined(var_0)) {
    var_0 scripts\engine\utility::_id_108A7(var_2, "crate_dropped");
  } else {
    wait(var_2);
  }

  stopFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), var_1._id_103BE, "tag_origin");
  var_1._id_103BE delete();
}

_id_6ADA(var_0) {
  if(!isDefined(level._id_8DE8)) {
    _id_BD72();
  }

  level._id_8DE8[var_0] = ::scripts\engine\utility::array_randomize(level._id_8DE8[var_0]);
  return level._id_8DE8[var_0][0];
}

_id_2A49() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 10;
  var_7 = 35;
  var_8 = 35;
  var_9 = 20;

  if(isDefined(level._id_F1E6[0]) && level._id_F1E6[0] < 2 || 0) {
    var_0 = var_0 + 10;
  } else {
    var_2 = 1;
    var_6 = 0;
  }

  if(isDefined(level._id_F1E6[1]) && level._id_F1E6[1] < -1 || 1) {
    var_0 = var_0 + 35;

    if(!var_2) {
      var_7 = var_7 + 10;
    }
  } else {
    var_3 = 1;
    var_7 = 0;
  }

  if(isDefined(level._id_F1E6[2]) && level._id_F1E6[2] < -1 || 1) {
    var_0 = var_0 + 35;

    if(!var_2) {
      var_8 = var_8 + 10;
    }

    if(!var_3) {
      var_8 = var_8 + 35;
    }
  } else {
    var_4 = 1;
    var_8 = 0;
  }

  if(isDefined(level._id_F1E6[3]) && level._id_F1E6[3] < 15 || 0) {
    var_0 = var_0 + 20;

    if(!var_2) {
      var_9 = var_9 + 10;
    }

    if(!var_3) {
      var_9 = var_9 + 35;
    }

    if(!var_3) {
      var_9 = var_9 + 35;
    }
  } else {
    var_5 = 1;
    var_9 = 0;
  }

  var_10 = randomintrange(1, var_0);

  if(var_10 <= var_6) {
    level._id_F1E6[0]++;
    var_11 = scripts\engine\utility::array_randomize(level._id_8DE8[0]);
    return var_11[0];
  } else if(var_10 <= var_7) {
    level._id_F1E6[1]++;
    var_11 = scripts\engine\utility::array_randomize(level._id_8DE8[1]);
    return var_11[0];
  } else if(var_10 <= var_8) {
    level._id_F1E6[2]++;
    var_11 = scripts\engine\utility::array_randomize(level._id_8DE8[2]);
    return var_11[0];
  } else {
    level._id_F1E6[3]++;
    var_11 = scripts\engine\utility::array_randomize(level._id_8DE8[3]);
    return var_11[0];
  }
}

_id_BD72() {
  level._id_8DE8 = [];
  level._id_8DE8[3] = ["cruise_predator", "scrambler_drone_guard", "uav"];
  level._id_8DE8[2] = ["precision_airstrike", "multi_airstrike", "bradley"];
  level._id_8DE8[1] = ["toma_strike", "uav", "pac_sentry", "white_phosphorus"];
  level._id_8DE8[0] = ["uav"];
}

_id_2A4A(var_0) {
  return level._id_8DD5._id_EA18._id_EC74[var_0]["hudIcon"];
}

_id_5074(var_0) {
  level endon("game_ended");
  var_1 = scripts\cp_mp\killstreaks\airdrop::_id_5029(undefined, undefined, "battle_royale", var_0, (0, randomfloat(360), 0), 3000, 3000, var_0, scripts\cp_mp\killstreaks\airdrop::_id_692A("weapon"));

  if(!isDefined(var_1)) {
    return undefined;
  } else if(!isDefined(var_1._id_3E6D)) {
    return undefined;
  }

  return var_1._id_3E6D;
}

_id_8186() {
  scripts\cp_mp\killstreaks\airdrop::_id_8272();
  level._id_10CD9["icon_waypoint_marker"] = "DROP_BAG";
  level._id_500F = spawnStruct();
  level._id_500F._id_3A0B = scripts\engine\utility::getstructarray("dropBagCluterNode", "script_noteworthy");
  var_0 = scripts\engine\utility::getstructarray("dropBagLocation", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2._id_84EF = 0;

    foreach(var_4 in level._id_500F._id_3A0B) {
      if(var_2.target == var_4._id_0481) {
        if(!isDefined(var_4._id_503C)) {
          var_4._id_503C = [];
        }

        var_4._id_503C[var_4._id_503C.size] = var_2;
        continue;
      }
    }
  }

  _id_8187();
}

_id_8187() {
  game["dialog"]["dropbag_incoming"] = "gamestate_dropbag_incoming";
  game["dialog"]["dropbag_available"] = "gamestate_dropbag_available";
}

_id_BB77(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = scripts\mp\gametypes\br_circle::_id_6D02();
  var_4 = scripts\mp\gametypes\br_circle::_id_6D03();
  var_5 = getarraykeys(level._id_EF6A);

  foreach(var_7 in var_5) {
    if(level._id_EF6A[var_7]["teamCount"] > 0) {
      var_8 = 0;
      var_9 = undefined;

      foreach(var_11 in level._id_EF6A[var_7]["alivePlayers"]) {
        if(!isDefined(var_9) && !istrue(var_11._id_7262)) {
          var_9 = var_11;
        }

        if(istrue(var_11._id_8A5D) && !istrue(var_11._id_7262)) {
          var_8 = 1;
          var_1[var_1.size] = var_11;

          if(istrue(var_0) && isDefined(level._id_2AB8[var_11.team]._id_71D2)) {
            var_2[var_2.size] = level._id_2AB8[var_11.team]._id_71D2;
          } else {
            var_2[var_2.size] = var_11.origin;
          }

          break;
        }
      }

      if(!var_8) {
        if(isDefined(var_9)) {
          var_11 = var_9;
          var_1[var_1.size] = var_11;

          if(istrue(var_0) && isDefined(level._id_2AB8[var_11.team]._id_71D2)) {
            var_2[var_2.size] = level._id_2AB8[var_11.team]._id_71D2;
          } else {
            var_2[var_2.size] = var_11.origin;
          }
        } else if(level._id_EF6A[var_7]["aliveCount"] > 0) {
          var_11 = level._id_EF6A[var_7]["alivePlayers"][0];
          var_1[var_1.size] = var_11;
          var_13 = randomfloat(360.0);
          var_14 = randomfloat(var_4);
          var_15 = var_3 + (cos(var_13) * var_14, sin(var_13) * var_14, 0.0);
          var_2[var_2.size] = var_15;
        }
      }
    }
  }

  var_17 = 5;

  if(isDefined(level._id_500F._id_3A0B) && level._id_500F._id_3A0B.size && isDefined(level._id_500F._id_3A0B[0]._id_503C)) {
    var_17 = level._id_500F._id_3A0B[0]._id_503C.size;
  }

  var_18 = getdvarfloat("#x3b57669903424184d", 3000);
  var_19 = getdvarfloat("#x3b98f4438c7018b37", 7000);
  var_20 = spawnStruct();
  var_20.origin = (0, 0, 0);
  var_21 = [var_20];

  if(isDefined(level._id_2A73)) {
    var_21 = _func_03F6(var_2, level._id_500F._id_3A0B, level._id_2A73._id_2A78, var_18, var_19, 2000, var_17, 128, var_3, var_4);
  }

  if(isDefined(var_21)) {
    for(var_22 = 0; var_22 < var_21.size; var_22++) {
      var_11 = var_1[var_22];

      if(isDefined(var_21[var_22]._id_02ED)) {
        var_23 = var_21[var_22]._id_02ED;
        var_24 = level._id_500F._id_3A0B[var_23];
        var_25 = var_21[var_22].index;
        var_11._id_BB75 = var_24._id_503C[var_25].origin;
        continue;
      }

      var_11._id_BB75 = var_21[var_22].origin;
    }

    level._id_BB76 = 1;
    level thread _id_E29E(var_1);
  }

  level thread _id_9A19();
}

_id_9A19() {
  level notify("manageDropBags");
  level endon("manageDropBags");
  var_0 = -1;
  var_1 = getdvarfloat("#x35c1f014a34d9a6f7", 2400.0);

  for(;;) {
    if(!isDefined(level._id_2A95._id_3E9B) || !level._id_2A95._id_3E9B.size) {
      var_0 = -1;
      wait 1.0;
      continue;
    }

    var_0 = (var_0 + 1) % level._id_2A95._id_3E9B.size;
    var_2 = level._id_2A95._id_3E9B[var_0];

    if(!isDefined(var_2)) {
      level._id_2A95._id_3E9B = scripts\engine\utility::_id_1BD1(level._id_2A95._id_3E9B);
      waitframe();
      continue;
    }

    if(isDefined(var_2.team)) {
      var_3 = 0;

      if(isDefined(var_2._id_A79D)) {
        var_3 = var_2._id_A79D;
      }

      if(var_3 >= level._id_EF6A[var_2.team]["teamCount"]) {
        var_2 thread scripts\cp_mp\killstreaks\airdrop::_id_4843();
        waitframe();
        continue;
      }
    }

    var_4 = scripts\mp\gametypes\br_circle::_id_69C6();

    if(var_4 > 0.0) {
      var_5 = scripts\mp\gametypes\br_circle::_id_69C5();
      var_6 = distance2dsquared(var_2.origin, var_5);
      var_7 = max(0, var_4 + var_1);

      if(var_6 > var_7 * var_7) {
        var_2 thread scripts\cp_mp\killstreaks\airdrop::_id_4843();
        waitframe();
        continue;
      }
    }

    waitframe();
  }
}

_id_386F(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level._id_2A95._id_3E9B) {
    if(!isDefined(var_4) || var_4.team != var_0) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  var_6 = var_2.size - var_1;

  if(var_6 <= 0) {
    return;
  }
  for(var_7 = var_6 - 1; var_7 >= 0; var_7--) {
    var_8 = var_2[var_7];
    var_8 thread scripts\cp_mp\killstreaks\airdrop::_id_4843();
  }
}

_id_E29B(var_0) {
  _id_386F(self.team, 1);
  var_1 = scripts\cp_mp\killstreaks\airdrop::_id_501C(self.team, var_0 + (0, 0, 4096), var_0 + (0, 0, 512));
  var_1 endon("death");
  _id_5249(var_1);
  _id_35F3(var_1);
  var_2 = [];

  foreach(var_4 in level._id_EF6A[self.team]["alivePlayers"]) {
    if(isDefined(var_4) && !var_4 scripts\mp\gametypes\br_public::_id_8990()) {
      var_2[var_2.size] = var_4;
      var_4 thread scripts\mp\hud_message::showsplash("br_airdrop_incoming");
    }
  }

  if(!scripts\mp\gametypes\br_public::_id_8AB8()) {
    scripts\mp\gametypes\br_public::_id_2BDE("dropbag_incoming", self.team, 1);
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\mp\gametypes\br_analytics::_id_2AEC(self, var_0, var_1);
  }
}

_id_E29E(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_3 = var_2._id_BB75;

    if(isDefined(level._id_2A1B) && isDefined(level._id_2A1B._id_CACA)) {
      var_4 = scripts\mp\gametypes\br_circle::_id_6D02();
      var_5 = scripts\mp\gametypes\br_circle::_id_6D03();

      if(distance2dsquared(var_4, var_3) > var_5 * var_5) {
        var_6 = vectornormalize(var_3 - var_4);
        var_7 = var_4 + var_6 * var_5 * 0.95;

        if(_func_03DC()) {
          var_3 = _func_02AB(var_7);
        } else {
          var_3 = var_7;
        }
      }

      if(scripts\mp\outofbounds::_id_89B8(var_3)) {
        var_4 = scripts\mp\gametypes\br_circle::_id_6D02();
        var_7 = scripts\mp\gametypes\br_c130::_id_DEAF(var_4, var_3);

        if(_func_03DC()) {
          var_3 = _func_02AB(var_7);
        } else {
          var_3 = var_7;
        }
      }
    }

    var_2 _id_E29B(var_3);
    waitframe();
  }
}

_id_E29D() {
  var_0 = undefined;
  var_0 = _id_5B0D(self);

  if(!isDefined(var_0)) {
    var_1 = getdvarfloat("#x3b57669903424184d", 3000);
    var_2 = getdvarfloat("#x3b98f4438c7018b37", 7000);
    var_0 = _id_2EE5(self, var_1, var_2);
  }

  if(isDefined(var_0)) {
    thread _id_E29B(var_0.origin);
    level thread _id_9A19();
  }
}

_id_5B0D(var_0) {
  var_1 = [];
  var_2 = getdvarfloat("#x3b57669903424184d", 3000);
  var_3 = getdvarfloat("#x3b98f4438c7018b37", 7000);
  var_4 = var_2 * var_2;
  var_5 = var_3 * var_3;

  foreach(var_7 in level._id_500F._id_3A0B) {
    var_8 = distance2dsquared(var_0.origin, var_7.origin);

    if(var_8 >= var_4 && var_8 <= var_5) {
      var_1[var_1.size] = var_7;
    }
  }

  if(var_1.size == 0) {
    return undefined;
  }

  var_1 = scripts\engine\utility::array_randomize(var_1);
  var_10 = 0;

  foreach(var_7 in var_1) {
    var_12 = scripts\engine\utility::array_randomize(var_7._id_503C);

    foreach(var_14 in var_12) {
      if(!var_14._id_84EF) {
        var_14._id_84EF = 1;
        return var_14;
      }
    }
  }

  return undefined;
}

_id_5249(var_0) {
  var_0 setotherent(self);
  var_0 setscriptablepartstate("objective", "active");
}

_id_35F3(var_0) {
  var_0 setotherent(self);
  var_0 setscriptablepartstate("model", "choose");
}

_id_46AE(var_0) {
  level endon("game_ended");
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_4 = var_3 - var_1;

    if(var_4 > 0) {
      wait(var_4);
    }

    var_1 = var_3;
    _id_BB77(0);
  }
}

_id_15CD() {
  foreach(var_1 in level._id_2A95._id_3E9B) {
    if(!isDefined(var_1) || var_1.team != self.team) {
      continue;
    }
    var_2 = isDefined(var_1._id_B790) && isDefined(var_1._id_B790[self getentitynumber()]);

    if(var_2) {
      var_1._id_B790[self getentitynumber()] = undefined;

      for(var_3 = 0; var_3 < var_1._id_B7E9.size; var_3++) {
        if(isDefined(var_1._id_B7E9[var_3]) && var_1._id_B7E9[var_3] == self) {
          var_1._id_B7E9[var_3] = undefined;
        }
      }

      var_1._id_B7E9 = scripts\engine\utility::_id_1BD1(var_1._id_B7E9);
      var_1._id_A79D--;
    }
  }
}

_id_AB74() {
  _id_15CD();
}

_id_F0DC() {
  _id_CA4E(level.players[0], level.players[0], undefined, 3);
}

_id_5AE5(var_0) {
  var_1 = var_0 scripts\engine\utility::_id_1BD6(level._id_500F._id_3A0B, ::_id_E034);

  foreach(var_3 in var_1) {
    var_4 = scripts\engine\utility::array_randomize(var_3._id_503C);

    foreach(var_6 in var_4) {
      if(!var_6._id_84EF) {
        var_6._id_84EF = 1;
        return var_6;
      }
    }
  }

  return undefined;
}

_id_E034(var_0, var_1) {
  return distancesquared(var_0.origin, self.origin) < distancesquared(var_1.origin, self.origin);
}

_id_2EE5(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = randomint(2);
  var_7 = scripts\engine\utility::ter_op(var_6, -1.0, 1.0);

  if(var_7 > 0) {
    var_4 = randomfloatrange(var_3[0] + var_1 * var_7, var_3[0] + var_2 * var_7);

    if(var_4 >= level._id_2A73._id_2A78[0][0]) {
      var_4 = level._id_2A73._id_2A78[0][0] - 250;
    }
  } else {
    var_4 = randomfloatrange(var_3[0] + var_2 * var_7, var_3[0] + var_1 * var_7);

    if(var_4 <= level._id_2A73._id_2A78[1][0]) {
      var_4 = level._id_2A73._id_2A78[1][0] + 250;
    }
  }

  var_6 = randomint(2);
  var_7 = scripts\engine\utility::ter_op(var_6, -1.0, 1.0);

  if(var_7 > 0) {
    var_5 = randomfloatrange(var_3[1] + var_1 * var_7, var_3[1] + var_2 * var_7);

    if(var_5 >= level._id_2A73._id_2A78[0][1]) {
      var_5 = level._id_2A73._id_2A78[0][1] - 250;
    }
  } else {
    var_5 = randomfloatrange(var_3[1] + var_2 * var_7, var_3[1] + var_1 * var_7);

    if(var_5 <= level._id_2A73._id_2A78[1][1]) {
      var_5 = level._id_2A73._id_2A78[1][1] + 250;
    }
  }

  if(_func_03DC()) {
    var_8 = _func_02AB((var_4, var_5, var_3[2]));

    if(isDefined(var_8)) {
      var_9 = spawnStruct();
      var_9.origin = var_8;
      return var_9;
    }
  }

  var_9 = spawnStruct();
  var_9.origin = (var_4, var_5, var_3[2]);
  return var_9;
}

_id_44FE(var_0) {}

_id_9B9D(var_0, var_1) {
  var_0._id_10416 = 1;
  _func_018B(var_0._id_A908);

  foreach(var_3 in level._id_E48E[var_1.team][var_1._id_E496].players) {
    _func_0185(var_0._id_A908, var_3);
  }
}