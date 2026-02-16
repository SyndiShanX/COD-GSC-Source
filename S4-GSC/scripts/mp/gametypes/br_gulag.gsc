/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gulag.gsc
*************************************************/

_id_81A7() {
  level._id_C69B = getdvarfloat("#x31281781ce293d6b4", 0.75);

  if(!istrue(level._id_FE76)) {
    return;
  }
  if(scripts\mp\gametypes\br_gametypes::_id_8853("gulag")) {
    level._id_FE76 = 0;
    return;
  }

  setomnvar("ui_gulag_state", 1);
  setomnvar("ui_gulag_show_closing_state", 0);
  level._id_7262 = spawnStruct();
  level._id_7262._id_1AA6 = getdvarint("#x3f551922a2cc49a8c", 1);
  level._id_7262._id_9C93 = _id_6B48();
  level._id_7262._id_9CB7 = getdvarint("#x31eff2153c37d20b1", 1);
  level._id_7262._id_5337 = getdvarint("#x3b58a91b6894b2a34", 3);
  level._id_7262._id_F216 = getdvarint("#x342fcfba07db2404e", 15.0);
  level._id_7262._id_9C9B = getdvarint("#x3dc3ba76d5f861cb4", 3);
  level._id_7262._id_AABF = getdvarint("#x35f229d7ef19d20ae", 1);
  level._id_7262._id_A2F5 = getdvarint("#x3cce80ba2930c8f2b", 1);
  level._id_7262._id_B191 = getdvarint("#x3172b991b311b09ab", 0);
  level._id_7262._id_84D2 = getdvarint("#x391ea479831acaca", 1);
  level._id_7262._id_FE30 = getdvarint("#x327630dcd2d6b9121", 1);
  level._id_7262._id_FE71 = getdvarint("#x3965711ef9a0ccced", 0);
  level._id_7262._id_E31D = getdvarint("#x3f6928f73682a24cb", 0);
  level._id_7262._id_91E0 = getdvarint("#x31db7e0f1899271db", 4);
  level._id_7262._id_EA20 = getdvarint("#x34eebe78879d4f28d", 9);
  level._id_7262._id_A76D = getdvarint("#x31a79534252a5c823", 0);
  _id_0CE7("waypoint_captureneutral", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _id_0CE7("waypoint_capture", "enemy", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _id_0CE7("waypoint_defend", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0);
  _id_0CE7("waypoint_defending", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0);
  _id_0CE7("waypoint_contested", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1);
  _id_0CE7("waypoint_taking", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", 1);
  _id_0CE7("waypoint_losing", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", 1);
  level._id_7262._id_9085 = [];

  if(istrue(level._id_7262._id_1AA6)) {
    scripts\mp\gametypes\br_dom_quest::_id_D865();
  }

  level._id_7262._id_1ABF = _id_726C();
  _id_726B();
  _id_726E();

  if(level._id_7262._id_84D2) {
    _id_0A9A::_id_C287(::_id_B674);
  }

  if(level._id_7262._id_FE71) {
    _id_07A1::_id_CECC("brloot_rock", ::_id_C8C0);
  }

  level._id_7262._id_24DA = getdvarint("#x38c41ab38ab63eee9", 0);

  if(level._id_7262._id_24DA) {
    if(!istrue(level._id_2A9C)) {
      level._id_7262._id_24DA = 0;
    }
  }

  foreach(var_1 in level._id_7262._id_1ABF) {
    level thread _id_A114(var_1);
  }

  thread _id_E25A();
  _id_82B7();
  level._id_60D2 = ::_id_C14B;
}

_id_0CE7(var_0, var_1, var_2, var_3) {
  level._id_10CCD[var_0] = var_1;
  level._id_10CCC[var_0] = 1;
  level._id_10CD9[var_0] = var_2;
  level._id_10CD8[var_0] = "ui_mp_br_mapmenu_icon_gulag_overtime_objective";
  level._id_10CD1[var_0] = var_3;
}

_id_82B7() {
  game["dialog"]["gulag_spawn"] = "gulag_spawn";
  game["dialog"]["gulag_spawn_rules"] = "gulag_spawn_rules";
  game["dialog"]["gulag_objective"] = "gulag_objective";
  game["dialog"]["gulag_next"] = "gulag_next";
  game["dialog"]["gulag_win"] = "gulag_win";
  game["dialog"]["gulag_lose"] = "gulag_lose";
  game["dialog"]["gulag_teammate_gulag"] = "gulag_teammate_gulag";
  game["dialog"]["gulag_teammate_lose"] = "gulag_teammate_lose";
  game["dialog"]["gulag_teammate_win"] = "gulag_teammate_win";
  game["dialog"]["gulag_gulag_active"] = "gulag_gulag_active";
  game["dialog"]["gulag_gulag_close"] = "gulag_gulag_close";
  game["dialog"]["gulag_noenemy"] = "gulag_noenemy";
  game["dialog"]["gulag_timeout"] = "gulag_timeout";
  game["dialog"]["gulag_buyback"] = "gulag_buyback";
  game["dialog"]["gulag_taunt"] = "gulag_taunt";
  game["dialog"]["gulag_obj_wait"] = "gulag_obj_wait";
}

_id_726C() {
  var_0 = scripts\engine\utility::getStructArray("gulag", "targetname");
  var_0 = scripts\engine\utility::array_randomize(var_0);

  if(scripts\mp\gametypes\br_public::_id_878D()) {
    var_0 = scripts\engine\utility::getStructArray("gulag_tutorial", "targetname");
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    var_2._id_726D = var_1;
    _id_D848(var_2);
  }

  return var_0;
}

_id_D848(var_0) {
  var_0._id_8B61 = [];
  var_0._id_5A2E = [];
  var_0._id_3384 = [];
  var_0._id_620B = [];
  var_0._id_5D1C = [];
  var_0.weapons = [];
  var_0._id_A0A9 = [];
  var_0._id_8B5C = [];
  var_0._id_1ABE = [];
  var_0._id_9BC4 = [];
  var_0._id_9619 = [];
  var_0._id_5A2D = 1;
  var_0._id_AA3F = [];
  var_0._id_AA3F["ui_br_gulag_players_1"] = 0;
  var_0._id_AA3F["ui_br_gulag_data"] = 0;
  var_1 = [];
  var_2 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  foreach(var_4 in var_2) {
    if(var_4._id_039B == "prison_spawn") {
      var_0._id_8B61[var_0._id_8B61.size] = var_4;
      continue;
    }

    if(var_4._id_039B == "fight_spawn") {
      var_0._id_5A2E[var_0._id_5A2E.size] = var_4;
      continue;
    }

    if(var_4._id_039B == "cell_spawn") {
      var_0._id_3384[var_0._id_3384.size] = var_4;
      continue;
    }

    if(var_4._id_039B == "gulag_center") {
      var_0._id_3385 = var_4.origin;
      continue;
    }

    if(var_4._id_039B == "spectator") {
      var_0._id_E3E3 = var_4;
      continue;
    }

    if(isDefined(var_4._id_CE18) && var_4._id_CE18 == "gulag_loot") {
      var_1[var_1.size] = var_4;
    }
  }

  if(!isDefined(var_0._id_3385)) {
    var_0._id_3385 = _id_6A82(var_0);
  }

  if(getdvarint("#x3fc86900a68b6d990", 1) > 0) {
    var_0._id_5A2E = scripts\engine\utility::_id_1BD6(var_0._id_5A2E, ::_id_3AFF);
  } else {
    var_0._id_5A2E = scripts\engine\utility::_id_1BD6(var_0._id_5A2E, ::_id_3B00);
  }

  foreach(var_7 in var_0._id_3384) {
    _id_D856(var_0, var_7);
  }

  var_0._id_3384 = scripts\engine\utility::_id_1BD6(var_0._id_3384, ::_id_3B00);

  if(istrue(level._id_7262._id_E31D)) {
    var_0.weapons = _id_E322(var_1);
  }

  _id_E360(var_0);

  if(istrue(level._id_7262._id_1AA6)) {
    _id_D866(var_0);
  }
}

_id_726B() {
  level._id_7262._id_62EF = getdvarint("#x38aca6623953d30e2", 0);

  if(!istrue(level._id_7262._id_62EF)) {
    return;
  }
  level._id_7262._id_62EE = [];
  level._id_7262._id_62EE["fc_gesture_neg"] = ["iw8_ges_plyr_gesture_crush", "iw8_ges_plyr_gesture_rally", "iw8_ges_plyr_gesture_revive"];
  level._id_7262._id_62EE["fc_gesture_pos"] = ["iw8_ges_plyr_gesture_doubletime", "iw8_ges_plyr_gesture_hold", "iw8_ges_plyr_gesture_ok", "iw8_ges_plyr_gesture_thumbs_up"];
  level._id_7262._id_62F0["fc_gesture_neg"] = ["tmp_gulag_gesture_neg_crush", "tmp_gulag_gesture_neg_rally", "tmp_gulag_gesture_neg_revive"];
  level._id_7262._id_62F0["fc_gesture_pos"] = ["tmp_gulag_gesture_pos_doubletime", "tmp_gulag_gesture_pos_hold", "tmp_gulag_gesture_pos_ok", "tmp_gulag_gesture_pos_thumbs_up"];
}

_id_6B48() {
  var_0 = int(clamp(getdvarint("#x3a7406a3c370a6b1d", 2), 2, 2));

  if(var_0 % 2 != 0) {
    var_0 = var_0 - 1;
  }

  return var_0;
}

_id_3B00(var_0, var_1) {
  return var_0._id_CD8D < var_1._id_CD8D;
}

_id_3AFF(var_0, var_1) {
  if(var_0._id_CD8D == 4) {
    return 1;
  } else if(var_0._id_CD8D == 5) {
    return 1;
  } else if(var_1._id_CD8D == 4) {
    return 0;
  } else if(var_1._id_CD8D == 5) {
    return 0;
  }

  return _id_3B00(var_0, var_1);
}

_id_3D66(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0.origin + var_1;
  var_3.angles = var_0.angles;
  var_3._id_CD8D = var_2;
  return var_3;
}

_id_6A82(var_0) {
  var_1 = (0, 0, 0);

  foreach(var_3 in var_0._id_5A2E) {
    var_1 = var_1 + var_3.origin;
  }

  var_1 = var_1 / var_0._id_5A2E.size;
  return var_1;
}

_id_E3A7(var_0, var_1, var_2) {
  var_3 = scripts\mp\gametypes\br_weapons::_id_4053(getgroundposition(var_0.origin + (0, 0, 12), 12), var_0.angles + (0, 0, 90), var_1, []);
  var_3 thread _id_AD06(var_2);
  return var_3;
}

_id_E322(var_0) {
  var_1 = [];
  var_2 = [];
  var_2["none"] = ["none"];
  var_2["tactical"] = ::scripts\mp\gametypes\br_pickups::_id_6A84("tactical");
  var_2["lethal"] = ::scripts\mp\gametypes\br_pickups::_id_6A84("lethal");
  var_3 = [];

  foreach(var_5 in var_2) {
    foreach(var_7 in var_5) {
      var_8 = 1;

      if(isDefined(var_3[var_7])) {
        continue;
      }
      var_9 = level._id_2A77[var_7];

      if(isDefined(var_9)) {
        var_10 = level._id_2A77[var_7]._id_232D + "_mp";
        var_8 = weaponclipsize(var_10) * 1;
      }

      var_3[var_7] = var_8;
    }
  }

  var_13 = ["tactical", "tactical", "lethal", "lethal", "lethal"];
  var_13 = scripts\engine\utility::array_randomize(var_13);
  var_14 = [];
  var_14["floor_center_01"] = ::scripts\engine\utility::random(var_2[var_13[0]]);
  var_14["floor_center_02"] = ::scripts\engine\utility::random(var_2[var_13[1]]);
  var_14["floor_right_01"] = ::scripts\engine\utility::random(var_2[var_13[2]]);
  var_14["floor_left_01"] = ::scripts\engine\utility::random(var_2[var_13[3]]);
  var_14["floor_mid_01"] = ::scripts\engine\utility::random(var_2[var_13[4]]);

  if(getdvarint("#x3fc86900a68b6d990", 1) > 0) {
    var_14["floor_left_01"] = var_14["floor_right_01"];
  }

  foreach(var_16 in var_0) {
    if(!isDefined(var_16._id_039B)) {
      continue;
    }
    var_17 = var_14[var_16._id_039B];

    if(!isDefined(var_17)) {
      continue;
    }
    if(var_17 == "none") {
      continue;
    }
    var_18 = var_16.origin;
    var_19 = var_16.angles;

    if(!isDefined(var_19)) {
      var_19 = (0, 0, 0);
    } else {
      var_19 = (0, var_19[1], 0);
    }

    var_7 = _func_03C5(var_17, var_18, var_19);

    if(isDefined(var_7)) {
      var_7._id_AE77 = var_17;
      var_7._id_011A = var_3[var_17];
      var_7._id_8CC6 = 1;
      var_1[var_1.size] = var_7;
      continue;
    }
  }

  return var_1;
}

_id_B6E7(var_0) {
  if(_id_B6E8(var_0)) {
    var_1 = var_0._id_9BC4[0];

    foreach(var_3 in var_1) {
      if(var_3 == self) {
        continue;
      } else if(_id_8994(var_3, var_0)) {
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

_id_B6E8(var_0) {
  if(_id_8922(var_0)) {
    var_1 = var_0._id_9BC4[0];

    foreach(var_3 in var_1) {
      if(var_3 == self) {
        return 1;
      }
    }
  }

  return 0;
}

_id_8922(var_0) {
  if(var_0._id_9BC4.size == 0) {
    return 0;
  }

  var_1 = var_0._id_9BC4[0];

  if(var_1.size < 2) {
    return 0;
  }

  return 1;
}

_id_8858(var_0) {
  if(!_id_8922(var_0)) {
    return 0;
  }

  var_1 = var_0._id_9BC4[0];

  foreach(var_3 in var_1) {
    if(istrue(var_3._id_54D9) || !istrue(var_3._id_8B5B)) {
      return 0;
    }
  }

  return 1;
}

_id_A114(var_0) {
  level endon("game_ended");

  for(;;) {
    if(istrue(level._id_2AA8) && var_0._id_5A2D) {
      if(istrue(level._id_7262._id_DD08)) {
        if(var_0._id_9619.size != 0) {
          var_0 waittill("loadingPlayersEmpty");
        }

        if(level._id_7262._id_5337 == 1) {
          foreach(var_2 in var_0._id_8B5C) {
            var_2._id_727A = 1;
            var_2 _meth_81FA();
          }

          var_0._id_DD08 = 1;
          break;
        } else if(level._id_7262._id_5337 == 2) {
          thread _id_4D00(var_0);
          break;
        } else if(level._id_7262._id_5337 == 3 && !_id_8922(var_0) && !_id_1919()) {
          foreach(var_2 in var_0._id_8B5C) {
            if(isalive(var_2)) {
              var_2 _id_B6C5();
              thread _id_7289(var_0, var_2, 1, "shutdown");
            }
          }

          var_0._id_DD08 = 1;
          break;
        }
      }

      if(_id_8858(var_0)) {
        _id_24AE(var_0);
      } else {
        _id_D5C2(var_0);
      }
    }

    waitframe();
  }
}

_id_3734(var_0) {
  if(istrue(level._id_FE76) && !istrue(level._id_7262._id_DD08)) {
    var_1 = _id_6A83();

    if(var_0 >= var_1) {
      _id_DD0F("circle_index", var_0);
    }
  }
}

_id_DD0F(var_0, var_1, var_2) {
  if(!istrue(level._id_FE76) || istrue(level._id_7262._id_DD08)) {
    return;
  }
  setomnvar("ui_gulag_state", 0);
  setomnvar("ui_gulag_show_closing_state", 2);
  level._id_7262._id_DD08 = 1;
  thread _id_99D9();

  if(!istrue(var_2)) {
    foreach(var_4 in level.players) {
      if(istrue(var_4.inlaststand)) {
        level._id_7262._id_9085[level._id_7262._id_9085.size] = var_4;
        continue;
      }

      if(!isDefined(var_4) || !isalive(var_4) || isDefined(var_4._id_7262)) {
        continue;
      }
      var_4 _id_B6C7();
    }
  }

  _func_03BF("dlog_event_br_gulag_shutdown", ["reason", var_0, "reason_count", var_1]);
}

_id_1919() {
  return level._id_7262._id_9085.size > 0;
}

_id_B6E1() {
  if(!istrue(level._id_FE76) || !istrue(level._id_7262._id_DD08)) {
    return 0;
  }

  return scripts\engine\utility::array_contains(level._id_7262._id_9085, self);
}

_id_7275(var_0) {
  if(istrue(level._id_7262._id_DD08) && _id_1919()) {
    if(isDefined(var_0) && var_0 _id_B6E1()) {
      level._id_7262._id_9085 = scripts\engine\utility::array_remove(level._id_7262._id_9085, self);
      return 1;
    } else
      level._id_7262._id_9085 = scripts\engine\utility::_id_1BD1(level._id_7262._id_9085);
  }

  return 0;
}

_id_AB63(var_0) {
  if(!istrue(level._id_FE76)) {
    return;
  }
  _id_7275(var_0);
}

_id_B6A6(var_0) {
  if(!istrue(level._id_FE76)) {
    return;
  }
  if(istrue(var_0)) {
    if(_id_7275(self)) {
      _id_B6C7();
    }
  }
}

_id_6A83() {
  if(!isDefined(level._id_2A73) || !isDefined(level._id_2A73._id_2A21)) {
    return 0;
  }

  return level._id_2A73._id_2A21.size - 1 - getdvarint("#x33ab26f61bb4ace81", 3);
}

_id_D87A() {
  var_0 = _id_6DEC();
  var_1 = gettime() + var_0 * 1000;
  setomnvar("ui_gulag_timer", var_1);
  thread _id_DC91(var_0);
}

_id_DC91(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_1 = getdvarint("#x3919b46398dbcf44c", 90);
  var_2 = var_0 - var_1;

  if(0 < var_2) {
    wait(var_2);
    setomnvar("ui_gulag_show_closing_state", 1);
  }
}

_id_6DEC() {
  var_0 = 0;

  if(isDefined(level._id_2A73) && isDefined(level._id_2A73._id_2A1F)) {
    var_1 = _id_6A83();

    for(var_2 = 0; var_2 < var_1; var_2++) {
      var_3 = level._id_2A73._id_2A21[var_2];
      var_4 = level._id_2A73._id_2A20[var_2];
      var_0 = var_0 + var_3 + var_4;
    }
  }

  return int(var_0);
}

_id_B6C7() {
  if(istrue(self._id_7266)) {
    return;
  }
  self._id_7266 = 1;
  scripts\mp\gametypes\br_killstreaks::_id_4343(self, "gulag_closed", undefined, 2);
  scripts\mp\gametypes\br_public::_id_2BDD("gulag_gulag_close", self);

  if(istrue(level._id_2A95._id_C6C6) && scripts\mp\gametypes\br_public::_id_75A4()) {
    scripts\mp\gametypes\br_pickups::_id_C514();
    thread scripts\mp\hud_message::showsplash("br_respawn_token_disabled");
    thread _id_0A9F::_id_7003("br_respawn_token_convert");
  }
}

_id_4D00(var_0) {
  if(var_0._id_8B5C.size == 0) {
    var_0._id_DD08 = 1;
    return;
  }

  var_0._id_88DD = 1;
  var_0._id_1ABE = scripts\engine\utility::_id_1BD1(var_0._id_8B5C);
  _id_8B5A(var_0);
  var_1 = _id_6B15();

  foreach(var_3 in var_0._id_1ABE) {
    var_3 thread _id_727E(var_0);
    var_3 _id_825C(var_0, 1, var_1);

    if(istrue(level._id_7262._id_62EF) && !isbot(var_3)) {
      var_3 _id_B6C9();
    }

    if(getdvarint("#x39ba24256a04aeadc", 1) > 0 && var_0._id_1ABE.size > 0) {
      var_3 _meth_81AF(var_0._id_1ABE);
    }
  }

  playsoundatpos(var_0._id_3385, "iw8_mp_snatch_fight_start");
  var_0._id_5A2D = 0;

  if(!_id_8960(var_0)) {
    var_0._id_F1E8 = level._id_7262._id_F216;
    _id_FCC4(var_0, var_0._id_F1E8);
    _id_10956(var_0, 0);
  } else {
    var_0._id_F1E8 = 8;
    _id_FCC4(var_0, var_0._id_F1E8);
    wait(var_0._id_F1E8);
  }

  foreach(var_3 in var_0._id_1ABE) {
    if(isDefined(var_3) && isDefined(var_3._id_7274)) {
      var_3._id_7274 destroy();
    }
  }

  _id_743F(var_0);
  var_0._id_DD08 = 1;
}

_id_8B5A(var_0) {
  foreach(var_2 in var_0._id_1ABE) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2 thread scripts\mp\hud_message::showsplash("br_gulag_jail_break");

    if(getdvarint("#x39ba24256a04aeadc", 1) > 0) {
      var_2 _meth_81B2(var_0._id_1ABE, "outline_nodepth_red");
    }
  }

  wait 3;

  foreach(var_2 in var_0._id_1ABE) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2 _id_B654();
  }

  _id_7265(var_0, 0);

  foreach(var_2 in var_0._id_1ABE) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2 setclientomnvar("ui_match_start_countdown", 0);
    var_2 setclientomnvar("ui_match_in_progress", 1);

    if(isDefined(var_2) && isDefined(var_2._id_7274)) {
      var_2._id_7274.label = &"MP/BR_GULAG_JAILBREAK";
    }
  }
}

_id_B654() {
  self._id_7274 = scripts\mp\hud_util::createfontstring("default", 2);
  self._id_7274 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -150);
  self._id_7274.label = &"MP/BR_GULAG_JAILBREAK_IN";
}

_id_C611(var_0) {
  if(!istrue(level._id_7262._id_E31D)) {
    return;
  }
  for(var_1 = 0; var_1 < var_0.weapons.size; var_1++) {
    var_2 = var_0.weapons[var_1];
    var_2 setscriptablepartstate(var_2._id_AE77, "visible");
  }
}

_id_FF52(var_0) {
  return var_0._id_1ABE.size >= 2;
}

_id_24AE(var_0) {
  level endon("game_ended");
  var_0._id_5A2D = 0;
  _id_C611(var_0);
  _id_C601(var_0);
  var_0._id_1ABE = _id_B9E3(var_0);
  var_1 = 0;

  foreach(var_4, var_3 in var_0._id_1ABE) {
    if(isDefined(var_3)) {
      var_0._id_8B5C = scripts\engine\utility::array_remove(var_0._id_8B5C, var_3);
    }

    if(!isDefined(var_3)) {
      var_1 = 1;
      continue;
    }

    if(var_3._id_7262 == 0 || var_3._id_8B5B == 0 || var_3._id_7263 == 1) {
      scripts\mp\utility\script::_id_47BB("Player: " + var_3.name + " - invalid for gulag - p.gulag = " + var_3._id_7262 + ", p.jailed = " + var_3._id_8B5B + ", p.gulagArena = " + var_3._id_7263);
      var_1 = 1;
      continue;
    }

    var_3._id_5A2A = var_4;
  }

  foreach(var_6 in var_0._id_8B5C) {
    if(!isDefined(var_6)) {
      continue;
    }
    var_6._id_727F--;
    var_6 setweaponammoclip("rock_mp", 5);
  }

  if(var_1) {
    var_0._id_8B5C = scripts\engine\utility::_id_1BD1(var_0._id_8B5C);
    var_0._id_1ABE = scripts\engine\utility::_id_1BD1(var_0._id_1ABE);

    if(!_id_FF52(var_0)) {
      _id_743F(var_0, undefined, 1);
      return;
    }
  }

  var_8 = _id_E680(var_0, var_0._id_1ABE);

  if(getdvarint("#x3d2de21b8413cff2d", 0)) {
    thread _id_9A25(var_0, var_0._id_1ABE, var_8);
  }

  var_0._id_1AC0 = 0;
  var_9 = _id_6B15();

  foreach(var_6 in var_0._id_1ABE) {
    if(!isDefined(var_6)) {
      continue;
    }
    var_6 thread _id_727E(var_0, var_8);
    var_6 thread _id_825C(var_0, 0, var_9);
  }

  thread _id_10B99(var_0);
  wait 2;

  if(!_id_FF52(var_0)) {
    _id_743F(var_0, var_8, 1);
    return;
  }

  _id_FC05(var_0);
  _id_FC04(var_0);
  var_12 = _id_7265(var_0, 1, var_8);

  if(!var_12) {
    return;
  }
  _id_52E2(var_0, var_8);

  foreach(var_6 in var_0._id_1ABE) {
    var_6 _id_B6C5();
    var_6 thread _id_B7B1();
  }

  thread _id_E6AB(var_0);
  var_0._id_F1E8 = level._id_7262._id_F216;
  _id_FCC4(var_0, var_0._id_F1E8);
  _id_10956(var_0, 1);
  _id_743F(var_0, var_8);

  if(!_id_8858(var_0)) {
    _id_FCFD(var_0);
  }
}

_id_10B99(var_0) {
  var_0 endon("fight_over");
  var_0 endon("matchEnded");
  level endon("game_ended");

  if(level._id_7262._id_91E0 <= 0) {
    return;
  }
  var_0._id_91E4 = gettime();
  var_0._id_91E2 = var_0._id_91E4 + level._id_7262._id_91E0 * 1000 + 3000 + 2000;

  while(gettime() < var_0._id_91E2) {
    waitframe();
  }

  var_0 notify("lethal_delay_end");
}

_id_10B9C(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(level._id_7262._id_91E0 == 0) {
    return;
  }
  if(!isai(self)) {
    self notifyonplayercommand("lethal_attempt_gulag", "+frag");
    self notifyonplayercommand("lethal_attempt_gulag", "+smoke");
  }

  scripts\mp\equipment::_id_153B("primary", 0);
  scripts\mp\equipment::_id_153B("secondary", 0);
  _id_10B9B(var_0, self);
  scripts\mp\equipment::_id_153B("primary", 1);
  scripts\mp\equipment::_id_153B("secondary", 1);
  self setclientomnvar("ui_recharge_notify", 2);

  if(!isai(self)) {
    self _meth_824C("lethal_attempt_gulag", "+frag");
    self _meth_824C("lethal_attempt_gulag", "+smoke");
  }
}

_id_10B9B(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("matchEnded");
  var_0 endon("lethal_delay_end");

  for(;;) {
    self waittill("lethal_attempt_gulag");
    var_2 = (var_0._id_91E2 - gettime()) / 1000;
    var_2 = int(max(0, _func_0037(var_2)));
    var_1 scripts\mp\hud_message::_id_DCA2("MP/LETHALS_UNAVAILABLE_FOR_N", var_2);
  }
}

_id_E6AB(var_0) {
  var_0 endon("matchEnded");
  playsoundatpos(var_0._id_3385, "iw8_mp_snatch_fight_start");
  wait 1;
  scripts\mp\gametypes\br_public::_id_2BDC("gulag_gulag_active", 0, var_0._id_8B5C);
  scripts\mp\gametypes\br_public::_id_2BDC("gulag_objective", 0, var_0._id_1ABE);
  wait 2;

  foreach(var_2 in var_0._id_8B5C) {
    if(var_2._id_727F <= 1) {
      scripts\mp\gametypes\br_public::_id_2BDD("gulag_next", var_2, 0);
      continue;
    }

    if(var_2._id_727F == 2) {
      scripts\mp\gametypes\br_public::_id_2BDD("gulag_taunt", var_2, 0);
    }
  }
}

_id_B7B1() {
  self endon("disconnect");
  self setclientomnvar("ui_objective_text", 0);
  wait 3;
  self setclientomnvar("ui_objective_text", -1);
}

_id_7478(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && isPlayer(var_2) && var_1 != var_2 && isalive(var_2) && scripts\engine\utility::array_contains(var_0._id_1ABE, var_2)) {
    thread _id_7289(var_0, var_2, 0, "winner");
    _id_AF7C(var_3, var_2, 1);
  }

  _id_AF7C(var_3, var_1, 0);
}

_id_9A25(var_0, var_1, var_2) {
  _id_9A23(var_0, var_1, var_2);

  if(istrue(level._id_7262._id_AABF)) {
    return;
  }
  _id_9A24(var_0, var_1);
}

_id_9A26(var_0) {
  var_0 endon("fight_over");

  for(;;) {
    var_0 waittill("player_added_to_jail");
    _id_FCE1(var_0);
  }
}

_id_9A23(var_0, var_1, var_2) {
  var_0 endon("fight_over");
  thread _id_9A26(var_0);

  for(;;) {
    if(var_0._id_8B5C.size) {
      var_3 = scripts\engine\utility::_id_1BD1(var_0._id_8B5C);

      foreach(var_5 in var_1) {
        if(!isDefined(var_5)) {
          continue;
        }
        var_5 _meth_81B2(var_3, "outline_nodepth_white");
      }
    }

    if(isDefined(var_2)) {
      foreach(var_8 in var_2._id_24D8) {
        if(!isDefined(var_8.owner)) {
          continue;
        }
        var_9 = scripts\engine\utility::ter_op(var_2._id_24DB, var_8._id_B6AC, var_8._id_B666);

        if(var_9 != -1) {
          var_10 = var_2._id_5A2B[var_9];

          if(isDefined(var_10)) {
            var_10 _meth_81B1(var_8.owner, "outline_nodepth_green");
          }
        }
      }
    }

    var_0 waittill("update_outlines");
  }
}

_id_9A24(var_0, var_1) {
  var_2 = scripts\engine\utility::_id_1BD1(var_0._id_8B5C);

  if(!var_2.size) {
    return;
  }
  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4 _meth_81AF(var_2);
  }
}

_id_FCE1(var_0) {
  var_0 notify("update_outlines");
}

_id_B6C5() {
  _id_B7DD(1);
  self setclientomnvar("ui_br_infil_started", 1);
  self setclientomnvar("ui_match_start_countdown", 0);
  self setclientomnvar("ui_match_in_progress", 1);

  if(istrue(level._id_7262._id_62EF) && !isbot(self)) {
    _id_B6C9();
  }
}

_id_7265(var_0, var_1, var_2) {
  var_3 = 3;

  while(var_3 > 0) {
    foreach(var_5 in var_0._id_1ABE) {
      var_5 setclientomnvar("ui_match_in_progress", 0);
      var_5 setclientomnvar("ui_match_start_countdown", var_3);
    }

    var_3 = var_3 - 1;
    wait 1;

    if(istrue(var_1) && !_id_FF52(var_0)) {
      _id_743F(var_0, var_2, 1);
      return 0;
    }
  }

  return 1;
}

_id_727C(var_0, var_1, var_2) {
  var_0 endon("matchEnded");

  while(var_1 > 0) {
    if(level.gameended) {
      return;
    }
    var_3 = var_1;

    if(!istrue(var_0._id_AD6F)) {
      var_3 = var_3 - var_2;
    }

    if(var_3 <= 5) {
      var_4 = scripts\mp\gamelogic::_id_6966(var_3);
      _id_4C4C(var_0, var_4);
    }

    if(var_1 > 1) {
      var_1 = var_1 - 1;
    }

    wait 1;
  }
}

_id_4C4C(var_0, var_1) {
  foreach(var_3 in var_0._id_8B5C) {
    if(isDefined(var_3)) {
      var_3 playlocalsound(var_1);
    }
  }

  foreach(var_3 in var_0._id_1ABE) {
    if(isDefined(var_3)) {
      var_3 playlocalsound(var_1);
    }
  }
}

_id_6BFF() {
  return getdvarint("#x3f57d34518bd1fb99", 15.0);
}

_id_10956(var_0, var_1) {
  var_2 = _id_6BFF();
  var_0._id_F1E8 = var_0._id_F1E8 + var_2;
  thread _id_727C(var_0, var_0._id_F1E8, var_2);

  for(;;) {
    if(!_id_8756(var_0) || _id_8960(var_0)) {
      break;
    }

    var_0._id_F1E8 = var_0._id_F1E8 - level._id_5F3A;

    if(istrue(level._id_7262._id_1AA6) && !istrue(var_0._id_AD6F) && var_0._id_F1E8 <= var_2) {
      var_0._id_AD6F = 1;
      var_0._id_4D0D._id_1AA6 _id_1AB0(1);
      var_0._id_4D0D._id_1AA6 _id_1AB1(var_0, 1);
      var_0._id_4D0D._id_1AA6._id_5C3F _meth_827E("flag_spawned");
    }

    if(istrue(var_0._id_AD6F)) {
      var_3 = clamp(var_0._id_F1E8 / var_2, 0.0, 1.0);
      _id_D637(var_0, var_3);
    }

    if(var_0._id_F1E8 <= 0) {
      _id_10946(var_0);

      if(istrue(var_1)) {
        foreach(var_5 in var_0._id_1ABE) {
          var_5 thread _id_727D(var_0);
          var_5 setplayermusicstate("br_gulag_lose");
          var_5 playsoundtoplayer("gulag_crowd_boo_loser", var_5);
          var_5 _meth_8078(2);
        }
      }

      break;
    }

    waitframe();
  }

  var_0 notify("matchEnded");
}

_id_10946(var_0) {
  while(isDefined(var_0._id_4D0D._id_1AA6._id_37F6) && var_0._id_4D0D._id_1AA6._id_37F6 != "none" && !istrue(var_0._id_4D0D._id_1AA6._id_E57B)) {
    waitframe();
  }
}

_id_8756(var_0) {
  foreach(var_2 in var_0._id_1ABE) {
    if(isalive(var_2)) {
      return 1;
    }
  }

  return 0;
}

_id_8960(var_0) {
  var_1 = undefined;

  foreach(var_3 in var_0._id_1ABE) {
    if(isalive(var_3)) {
      if(!isDefined(var_1)) {
        var_1 = var_3.team;
        continue;
      }

      if(var_1 != var_3.team) {
        return 0;
      }
    }
  }

  return 1;
}

_id_743F(var_0, var_1, var_2) {
  var_0 notify("fight_over");
  var_0._id_5A2D = 1;
  _id_52E2(var_0, var_1);
  _id_FCC4(var_0, 0);
  var_3 = undefined;

  foreach(var_5 in var_0._id_1ABE) {
    if(!isDefined(var_5)) {
      continue;
    }
    if(isalive(var_5)) {
      var_3 = var_5;

      if(istrue(var_2)) {
        var_3 _id_B6C5();
      }

      thread _id_7289(var_0, var_5, 0, "winner");
    }
  }

  if(istrue(level._id_7262._id_1AA6) && istrue(var_0._id_AD6F)) {
    var_0._id_4D0D._id_1AA6 _id_1AB0(0);
  }

  _id_AF7D(var_3, var_1);
  wait 2.0;

  if(istrue(level._id_7262._id_1AA6) && istrue(var_0._id_AD6F)) {
    var_0._id_AD6F = 0;
    var_0._id_4D0D._id_1AA6 _id_1AB1(var_0, 0);
  }

  _id_3871(var_0);
  wait 1;
}

_id_6B83(var_0) {
  if(isDefined(var_0._id_8B60)) {
    var_0._id_8B60++;
    var_0._id_8B60 = var_0._id_8B60 % var_0._id_8B61.size;
  } else
    var_0._id_8B60 = 0;

  var_1 = var_0._id_8B61[var_0._id_8B60];
  return var_1;
}

_id_AD06(var_0) {
  self endon("death");
  self endon("trigger");
  self._id_ACCD = [];

  switch (var_0) {
    case 0:
    default:
      var_1 = "outline_depth_white";
      break;
    case 1:
      var_1 = "outline_depth_green";
      break;
    case 2:
      var_1 = "outline_depth_cyan";
      break;
    case 3:
      var_1 = "outline_depth_red";
      break;
    case 4:
      var_1 = "outline_depth_orange";
      break;
  }

  for(;;) {
    var_2 = scripts\common\utility::_id_B7BF(self.origin, 2000);
    var_3 = scripts\engine\utility::_id_1BA6(level.players, var_2);

    foreach(var_5 in var_2) {
      var_6 = distancesquared(self.origin, var_5.origin);
      var_7 = var_5 getentitynumber();

      if(!isDefined(self._id_ACCD[var_7])) {
        self._id_ACCD[var_7] = ::scripts\mp\utility\outline::outlineenableforplayer(self, var_5, var_1, "level_script");
      }
    }

    foreach(var_5 in var_3) {
      var_7 = var_5 getentitynumber();

      if(isDefined(self._id_ACCD[var_7])) {
        scripts\mp\utility\outline::outlinedisable(self._id_ACCD[var_7], self);
        self._id_ACCD[var_7] = undefined;
      }
    }

    waitframe();
  }
}

_id_7283(var_0) {
  if((isbot(self) || self _meth_878F()) && !istrue(self._id_97CC)) {
    return 0;
  }

  self _meth_87A3(10000.0);
  self _meth_86A3(var_0, 1);
  return !self _meth_86A5();
}

_id_7284() {
  if(!istrue(self._id_97CC)) {
    self endon("gulagStreamLocationComplete");
    thread _id_7285(level._id_7262._id_EA20);

    while(!self _meth_86A5()) {
      waitframe();
    }

    self notify("gulagStreamLocationComplete");
  } else
    wait(level._id_7262._id_EA20);
}

_id_7285(var_0) {
  self endon("disconnect");
  self endon("gulagStreamLocationComplete");
  wait(var_0);
  self notify("gulagStreamLocationComplete");
}

_id_7282() {
  self _meth_86A4();
  self notify("gulagStreamLocationComplete");
}

_id_7281() {
  self _meth_87A3(0.0);
}

_id_10E2(var_0, var_1) {
  var_1._id_54D9 = 1;
  var_0._id_9619[var_0._id_9619.size] = var_1;
  thread _id_10E3(var_0, var_1);
}

_id_10E3(var_0, var_1) {
  var_1 endon("removeLoadingPlayer");
  var_1 waittill("disconnect");
  thread _id_C4E0(var_0, var_1);
}

_id_C4E0(var_0, var_1) {
  var_1 notify("removeLoadingPlayer");
  var_0._id_9619 = scripts\engine\utility::array_remove(var_0._id_9619, var_1);

  if(var_0._id_9619.size == 0) {
    var_0 notify("loadingPlayersEmpty");
  }
}

_id_8994(var_0, var_1) {
  return scripts\engine\utility::array_contains(var_1._id_9619, var_0);
}

_id_54D8(var_0) {
  var_0 notify("enter_gulag");
  var_0._id_54D9 = 0;
  _id_07C5::_id_78F3(var_0);
}

_id_54D9(var_0) {
  if(var_0._id_54D9) {
    var_0 waittill("enter_gulag");
  }
}

_id_B6B8() {
  if(!istrue(level._id_7262._id_A2F5)) {
    return level._id_7262._id_1ABF[0];
  }

  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level._id_7262._id_1ABF) {
    foreach(var_6 in var_4._id_9BC4) {
      if(var_6.size == 1 && var_6[0].team != self.team && (!isDefined(var_1) || var_6[0]._id_8B62 < var_2)) {
        var_1 = var_4;
        var_2 = var_6[0]._id_8B62;
      }
    }
  }

  if(isDefined(var_1)) {
    return var_1;
  }

  var_9 = [];

  for(var_10 = 0; var_10 < level._id_7262._id_1ABF.size; var_10++) {
    var_4 = level._id_7262._id_1ABF[var_10];

    if(var_4._id_9BC4.size > 0 && var_4._id_9BC4.size < level._id_7262._id_9C9B) {
      var_9[var_9.size] = var_4;
    }
  }

  if(var_9.size > 0) {
    foreach(var_4 in var_9) {
      foreach(var_6 in var_4._id_9BC4) {
        foreach(var_14 in var_6) {
          if(var_14.team == self.team) {
            return var_4;
          }
        }
      }
    }

    var_4 = var_9[randomint(var_9.size)];
    return var_4;
  }

  var_1 = undefined;
  var_18 = undefined;

  for(var_10 = 0; var_10 < level._id_7262._id_1ABF.size; var_10++) {
    var_4 = level._id_7262._id_1ABF[var_10];

    if(var_4._id_9BC4.size == 0) {
      return var_4;
    } else if(!isDefined(var_18) || var_4._id_9BC4.size < var_18) {
      var_1 = var_4;
      var_18 = var_4._id_9BC4.size;
    }
  }

  return var_1;
}

_id_8995(var_0, var_1) {
  if(!_id_8922(var_0)) {
    return 0;
  }

  var_2 = var_1._id_727F - 1;

  if(var_2 >= 0 && var_0._id_9BC4[var_2].size > 1) {
    return 1;
  }

  return 0;
}

_id_D5C2(var_0) {
  foreach(var_2 in var_0._id_8B5C) {
    if(!_id_8995(var_0, var_2) && isDefined(var_2._id_8B63) && !isDefined(var_2._id_8B64)) {
      var_2 setclientomnvar("ui_br_gulag_match_end_time", var_2._id_8B63);
      var_2._id_8B64 = 1;
    }
  }
}

_id_B67B(var_0) {
  self._id_8B63 = undefined;
  self._id_8B64 = undefined;
  self setclientomnvar("ui_br_gulag_match_end_time", 0);
}

_id_B6EA(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("initPlayerArena");
  self endon("gulag_end");
  var_1 = getdvarint("#x3bc3ee3e06e7cf669", 95);

  if(var_1 <= 0) {
    return;
  }
  self._id_8B63 = gettime() + var_1 * 1000;
  wait(var_1);

  while(_id_8995(var_0, self)) {
    waitframe();
  }

  thread _id_7289(var_0, self, 1, "timeout");
}

_id_8265(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self._id_8B62 = gettime();
  scripts\mp\gametypes\br_analytics::_id_2AF3(self, scripts\engine\utility::ter_op(istrue(var_0), "default", "debug"));
  _id_B75A();
  var_1 = _id_B6B8();
  self._id_1A5C = var_1;

  if(!scripts\engine\utility::array_contains(var_1._id_8B5C, self)) {
    var_1 notify("player_added_to_jail", self);
    var_1._id_8B5C[var_1._id_8B5C.size] = self;
  }

  _id_B6CB(var_1);
  thread _id_B81D(var_1);
  _id_FCBE(var_1);
  _id_10E2(var_1, self);
  _id_7275(self);

  if(!isDefined(self._id_7288)) {
    self._id_7288 = 0;
  }

  self._id_7288++;
  _id_D67A(1);
  _id_D67B(0);
  _id_D666(1);
  _id_D661(var_1);
  scripts\mp\outofbounds::enableoobimmunity(self);

  if(isDefined(level._id_350B)) {
    [[level._id_350B]]();
  }

  var_2 = _id_6B83(var_1);
  var_3 = getgroundposition(var_2.origin, 12);
  var_4 = (0, 0, 0);

  if(isDefined(var_2.angles)) {
    var_4 = var_2.angles;
  }

  var_5 = _id_7283(var_3);
  self._id_7276 = 1;
  self._id_EA1E = spawnStruct();
  self._id_EA1E.origin = var_3;
  self._id_EA1E.angles = var_4;

  if(istrue(var_0)) {
    _id_54D9(self);
  } else {
    _id_54D8(self);
  }

  scripts\mp\gametypes\br_quest_util::_id_AB67();
  var_6 = gettime();

  if(scripts\mp\gametypes\br_public::_id_878D()) {
    self notify("play_gulag_vo");
  }

  _id_B743();

  if(var_5) {
    scripts\mp\gametypes\br::_id_E30E(var_3 + (0, 0, 100), self.angles);
    _id_081A::_id_D512();
    _id_7283(var_3);
  }

  if(var_5) {
    _id_7284();
  }

  scripts\mp\class::_id_9625("gamemode");
  self.pers["gamemodeLoadout"] = level._id_7262._id_8B5F;
  self.class = "gamemode";
  self._id_5EC2 = var_4;
  self._id_5EC7 = var_3;
  scripts\mp\playerlogic::_id_E337(undefined, 0);
  _id_0790::_id_0B9E();
  self setclientomnvar("ui_gulag", 1);
  self._id_EA1E = undefined;
  self._id_7276 = 0;
  _id_C633();

  if(var_5) {
    _id_7282();
  }

  _id_B7B4();
  _id_B815(var_6);

  if(scripts\mp\gametypes\br_public::_id_878D()) {
    self _meth_8680("iw8_br_gulag_tutorial", 2);
  } else {
    self _meth_8680("fade_to_black_all_except_music_and_scripted5", 2);
  }

  self _meth_83EF("br_gulag_intro_vo_plr_female");
  self _meth_83EF("br_gulag_intro_vo_plr_male");
  self setclientomnvar("ui_br_infil_started", 1);
  var_7 = var_1._id_5A2D && _id_B6E7(var_1);

  if(!var_7) {
    _id_7267();
  }

  _id_7278();

  if(level._id_7262._id_24DA) {
    var_8 = 3;

    if(isDefined(self._id_B95B)) {
      var_8 = int(max(var_8, int(self._id_B95B / 2)));
    }

    scripts\mp\gametypes\br_plunder::_id_B7A3(var_8);
  }

  if(!var_7) {
    scripts\mp\gametypes\br_public::_id_2BDD("gulag_spawn", self, 0);
  }

  foreach(var_10 in level._id_EF6A[self.team]["players"]) {
    if(!isDefined(var_10) || !isalive(var_10)) {
      continue;
    }
    if(var_10 != self) {
      var_10 thread scripts\mp\hud_message::showsplash("br_gulag_teammate_in", undefined, self);
      scripts\mp\gametypes\br_public::_id_2BDD("gulag_teammate_gulag", var_10);
    }
  }

  if(!istrue(self._id_8B5B)) {
    _id_D67C(1);
    scripts\mp\utility\perk::_id_259D("specialty_scavenger");
  }

  _id_C4E0(var_1, self);
  scripts\mp\gametypes\br_pickups::_id_825B(1);

  if(istrue(level._id_7262._id_62EF) && !isbot(self)) {
    thread _id_B6C8();
  }

  _id_B7DF(0);

  if(istrue(level._id_7262._id_1AA6) && istrue(var_1._id_AD6F)) {
    var_1._id_4D0D._id_1AA6 thread _id_1AB3(1, self);
  }

  thread _id_B6EA(var_1);
  thread _id_B6EB(var_1);
}

_id_B6EB(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("initPlayerArena");
  self endon("gulag_end");
  wait 5;

  if(_id_8922(var_0)) {
    return;
  }
  scripts\mp\gametypes\br_public::_id_2BDD("gulag_obj_wait", self, 0);
}

_id_B7DF(var_0) {
  if(var_0) {
    self enableoffhandthrowback();
  } else {
    self disableoffhandthrowback();
  }
}

_id_B6C8() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("gulag_gestures_stop");
  self enableoffhandweapons();
  self allowfire(0);
  self allowads(0);
  self notifyonplayercommand("fc_gesture_neg", "+attack");
  self notifyonplayercommand("fc_gesture_pos", "+speed_throw");
  var_0 = 0;

  for(;;) {
    var_1 = scripts\engine\utility::_id_10897("fc_gesture_neg", "fc_gesture_pos");

    if(self _meth_84B7() || self isswitchingweapon() || self _meth_81E0() || self _meth_81CE() || self _meth_81EF() || self israisingweapon() || self _meth_81CF()) {
      continue;
    }
    if(getdvarint("#x3bb1b0c192e973ff3", 0) > 0) {
      if(var_0 >= level._id_7262._id_62EE[var_1].size) {
        var_0 = 0;
      }

      var_2 = level._id_7262._id_62F0[var_1][var_0];
      var_3 = level._id_7262._id_62EE[var_1][var_0];
      var_0++;
    } else {
      var_0 = randomint(level._id_7262._id_62EE[var_1].size);
      var_2 = level._id_7262._id_62F0[var_1][var_0];
      var_3 = level._id_7262._id_62EE[var_1][var_0];
    }

    if(isDefined(var_2) && var_2 != "") {
      self playSound(var_2);
    }

    var_4 = makeweapon(var_3);

    if(isDefined(var_4) && !isnullweapon(var_4)) {
      _id_0793::_id_10BED(var_4);
    }
  }
}

_id_B6C9() {
  self notify("gulag_gestures_stop");
  self _meth_824C("fc_gesture_neg", "+attack");
  self _meth_824C("fc_gesture_pos", "+speed_throw");
  self allowfire(1);
  self allowads(1);
}

_id_58BC(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(var_0)) {
    var_0 = 1.0;
  }

  _id_7269();
  wait(var_0);
  _id_7267();
}

_id_7269(var_0) {
  _id_B675();

  if(istrue(var_0)) {
    _id_726A();
  }
}

_id_7267() {
  thread _id_B676();
  _id_7268();
}

_id_726A() {
  var_0 = scripts\mp\gametypes\br_spectate::_id_6D6B(self);

  foreach(var_2 in var_0) {
    var_2 _id_B675();
  }
}

_id_7268() {
  var_0 = scripts\mp\gametypes\br_spectate::_id_6D6B(self);

  foreach(var_2 in var_0) {
    var_2 thread _id_B676();
  }
}

_id_58BD(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(var_0)) {
    var_0 = 1.0;
  }

  _id_726A();
  wait(var_0);
  _id_7268();
}

_id_726F() {
  if(_id_B6E5()) {
    return 1;
  }

  return 0;
}

_id_7277() {
  var_0 = scripts\mp\hud_util::createfontstring("default", 1.5);
  var_0 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -100);
  var_0.label = &"MP/BR_GULAG_TRAVEL";
  self._id_7277 = var_0;
}

_id_7278() {
  if(isDefined(self._id_7277)) {
    self._id_7277 destroy();
  }
}

_id_B7F5(var_0, var_1) {
  self _meth_8063();
  self setorigin(var_0, 1);
  self setplayerangles(var_1);
}

_id_825C(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("initPlayerArena");
  scripts\mp\gametypes\br_pickups::_id_825B();
  self allowprone(0);
  self allowcrouch(0);
  _id_B7DF(1);
  _id_B7DD(0);
  _id_B7F1(var_0);
  _id_B67B(var_0);
  scripts\mp\equipment::_id_153B("primary", 0);
  scripts\mp\equipment::_id_153B("secondary", 0);
  thread _id_B6D3(var_0);

  if(istrue(var_1)) {
    _id_D67C(0);
    _id_D67B(1);
    _id_B6BC(var_0, var_2);

    if(level._id_7262._id_91E0 > 0) {
      thread _id_10B9C(var_0);
    }

    return;
  }

  scripts\mp\gametypes\br_public::_id_2BDD("gulag_spawn_rules", self, 0);
  var_3 = _id_726F();

  if(!var_3) {
    thread _id_58BC();
  }

  thread _id_58BD();
  wait 1;
  _id_B6BC(var_0, var_2);
  thread _id_B7FB(3);

  if(level._id_7262._id_91E0 > 0) {
    thread _id_10B9C(var_0);
  }

  var_4 = _id_6B7B(var_0);
  var_5 = getgroundposition(var_4.origin, 1);
  var_6 = var_4.angles;

  if(!isDefined(var_4.angles)) {
    var_6 = (0, 0, 0);
  }

  _id_B7F5(var_5, var_6);
  _id_D67C(0);
  _id_D67B(1);
  self.health = self.maxhealth;
  scripts\mp\gametypes\br_armor::_id_6F82(level._id_7262._id_A76D);

  if(getdvarint("#x39ba24256a04aeadc", 1) > 0) {
    self _meth_81B2(var_0._id_1ABE, "outline_nodepth_red");
  }

  if(var_3) {
    _id_7267();
  }

  wait 1;
  self allowprone(1);
  self allowcrouch(1);
  wait 2;
  wait 1;

  if(getdvarint("#x39ba24256a04aeadc", 1) > 0 && var_0._id_1ABE.size > 0) {
    self _meth_81AF(var_0._id_1ABE);
  }
}

_id_B7DD(var_0) {
  if(var_0) {
    self allowmelee(1);
    self allowmovement(1);
    self enableusability();
    self enableoffhandweapons();
    self allowads(1);
    self allowfire(1);
  } else {
    self allowmelee(0);
    self allowmovement(0);
    self disableusability();
    self disableoffhandweapons();
    self allowads(0);
    self allowfire(0);
  }
}

_id_6B7B(var_0) {
  if(!isDefined(var_0._id_1AC0)) {
    var_0._id_1AC0 = 0;
  }

  var_1 = undefined;

  if(_id_FE30(var_0)) {
    var_1 = var_0._id_3384[var_0._id_1AC0];
  } else {
    var_1 = var_0._id_5A2E[var_0._id_1AC0];
  }

  var_0._id_1AC0++;
  var_0._id_1AC0 = var_0._id_1AC0 % var_0._id_5A2E.size;
  return var_1;
}

_id_B7FB(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self._id_B928 = 1;
  scripts\engine\utility::_id_108AF(var_0, "death", "gulagRespawn");
  self._id_B928 = undefined;
}

_id_7289(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_1 notify("gulag_end");
  var_1 _id_B67B();
  var_1 thread _id_B7FB(5);
  var_1._id_727A = 0;

  if(var_0._id_8B5C.size > 0 && getdvarint("#x3d2de21b8413cff2d", 0)) {
    var_1 _meth_81AF(var_0._id_8B5C);
  }

  if(var_0._id_1ABE.size > 0 && getdvarint("#x39ba24256a04aeadc", 1) > 0) {
    var_1 _meth_81AF(var_0._id_1ABE);
  }

  var_0._id_1ABE = scripts\engine\utility::array_remove(var_0._id_1ABE, var_1);

  foreach(var_5 in level._id_EF6A[var_1.team]["players"]) {
    if(!isDefined(var_5) || !isalive(var_5)) {
      continue;
    }
    if(var_5 != var_1) {
      var_5 thread scripts\mp\hud_message::showsplash("br_gulag_teammate_out", undefined, var_1);
      scripts\mp\gametypes\br_public::_id_2BDD("gulag_teammate_win", var_5);
    }
  }

  var_7 = "";

  if(isDefined(var_3)) {
    var_7 = var_3;
  }

  var_1 thread _id_F631(3);

  if(var_2) {
    if(var_3 == "timeout") {
      scripts\mp\gametypes\br_public::_id_2BDD("gulag_timeout", var_1, 0);
    } else {
      scripts\mp\gametypes\br_public::_id_2BDD("gulag_noenemy", var_1, 0);
    }

    var_0._id_8B5C = scripts\engine\utility::array_remove(var_0._id_8B5C, var_1);
    _id_FCBE(var_0);
  } else
    scripts\mp\gametypes\br_public::_id_2BDD("gulag_win", var_1, 0);

  var_1 playsoundtoplayer("gulag_crowd_cheer_winner", var_1);
  var_1 setplayermusicstate("br_gulag_win");

  if(istrue(level._id_7262._id_AABF) && (istrue(var_0._id_88DD) || level._id_7262._id_9C93 > 2)) {
    var_1 playerhide();
  }

  var_1 _id_B7DF(1);
  var_1 _id_B7DD(1);
  var_1 _id_B6CC(0);
  var_1 scripts\mp\gametypes\br_public::_id_FC1A("isRespawning", 1);
  var_1 scripts\mp\weapons::_id_4785();
  var_8 = scripts\mp\gametypes\br_public::_id_69D7() / 1000;
  var_9 = var_1 _id_B6CA(0, var_8);
  var_10 = var_1 _id_B75C(var_9);
  wait 2.0;

  if(istrue(level._id_7262._id_1AA6)) {
    var_0._id_4D0D._id_1AA6 thread _id_1AB3(0, var_1);
  }

  var_1 _meth_8078(2);
  var_1 _id_7269(1);
  wait 1;
  var_1 _id_728C(0, var_3, var_9, 1, var_10);
}

_id_B75C(var_0) {
  var_1 = scripts\mp\gametypes\br_public::_id_B7E5(var_0.origin, var_0.height);
  self _meth_87A2(0.0);
  scripts\mp\gametypes\br_public::_id_B7E6(var_1);
  return var_1;
}

_id_727E(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gulag_end");
  self endon("gulagLost");
  self waittill("death", var_2);

  if(istrue(level._id_7262._id_AABF)) {
    _id_7478(var_0, self, var_2, var_1);
  }

  thread _id_727D(var_0);
}

_id_727D(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("gulagLost");

  if(istrue(self._id_727A)) {
    return;
  }
  self._id_727A = 1;
  self._id_E3E3 = var_0._id_E3E3;
  thread _id_B7AA(1);
  var_0._id_8B5C = scripts\engine\utility::_id_1BD1(var_0._id_8B5C);

  if(var_0._id_8B5C.size > 0 && getdvarint("#x3d2de21b8413cff2d", 0)) {
    self _meth_81AF(var_0._id_8B5C);
  }

  var_0._id_1ABE = scripts\engine\utility::_id_1BD1(var_0._id_1ABE);

  if(var_0._id_1ABE.size > 0 && getdvarint("#x39ba24256a04aeadc", 1) > 0) {
    self _meth_81AF(var_0._id_1ABE);
  }

  self setclientomnvar("ui_gulag", 0);
  var_0._id_1ABE = scripts\engine\utility::array_remove(var_0._id_1ABE, self);

  if(isDefined(self)) {
    var_1 = self.name;
  } else {
    var_1 = "<undefined>";
  }

  self setplayermusicstate("br_gulag_lose");
  scripts\mp\weapons::_id_4785();
  scripts\mp\gametypes\br::_id_9B84(self);
  scripts\mp\gametypes\br_public::_id_2BDD("gulag_lose", self, 0, 1);
  scripts\mp\gametypes\br_public::_id_2BDF("gulag_teammate_lose", self.team, self, 0, 0);

  if(isalive(self)) {
    thread scripts\mp\gametypes\br_spectate::_id_F61D();
    self._id_B928 = 1;
    self freezecontrols(1);
  }

  wait 2.0;
  self _meth_8078(2);

  if(istrue(level._id_7262._id_1AA6)) {
    var_0._id_4D0D._id_1AA6 thread _id_1AB3(0, self);
  }

  _id_07BC::_id_AAFA(2);
  scripts\mp\gametypes\br_analytics::_id_2AF2(self, "loser");
  _id_B692(var_0);
  _id_D67A(0);
  _id_D67B(0, 1);
  _id_D67C(0);

  if(isalive(self)) {
    if(!scripts\mp\gametypes\br_gametypes::_id_8853("teamSpectate")) {
      scripts\mp\gametypes\br_spectate::_id_9E8F(self, undefined, 1);
    }

    _id_7269();
    wait 1;

    if(!scripts\mp\gametypes\br_gametypes::_id_8853("teamSpectate")) {
      scripts\mp\gametypes\br_spectate::_id_9E8F(self, undefined, 1);
    }

    self._id_B928 = undefined;
    var_2 = spawnStruct();
    var_2.origin = self.origin;
    var_2.angles = self.angles;
    var_2.attacker = self._id_026E;
    self.health = 0;
    scripts\mp\gametypes\br_spectate::_id_E37D(var_2, 1, 1);
    scripts\mp\playerlogic::_id_C4A4(0);
    _id_7267();
  }
}

_id_B7AA(var_0) {
  if(istrue(level._id_FE76)) {
    if(var_0) {
      self._id_10A14 = var_0;
    } else {
      self._id_10A14 = undefined;
    }

    _id_D665(var_0);
  }
}

_id_B7D0() {
  if(istrue(level._id_FE76) && istrue(self._id_10A14) && level._id_EF6A[self.team]["aliveCount"] > 0) {
    scripts\mp\gametypes\br_public::_id_2BDD("gulag_buyback", self, 0, 1);
  }
}

_id_C14B(var_0, var_1) {
  if(istrue(var_1._id_7263)) {
    var_2 = var_1._id_1A5C;
    var_2._id_A0A9[var_2._id_A0A9.size] = var_0;
  }
}

_id_3871(var_0) {
  foreach(var_2 in var_0._id_A0A9) {
    if(isDefined(var_2)) {
      thread _id_0A11::_id_A043(var_2);
    }
  }

  var_0._id_A0A9 = [];
}

_id_7273(var_0) {
  var_1 = isDefined(level._id_2A1B) && isDefined(level._id_2A1B._id_CACA);

  if(!var_1) {
    return 1;
  }

  var_2 = scripts\mp\gametypes\br_circle::_id_6D02();
  var_3 = scripts\mp\gametypes\br_circle::_id_6D03();
  var_4 = distance2d(var_0, var_2);
  return var_4 < var_3;
}

_id_7272(var_0) {
  var_1 = isDefined(level._id_2A1B) && isDefined(level._id_2A1B._id_433D);

  if(!var_1) {
    return 1;
  }

  var_2 = scripts\mp\gametypes\br_circle::_id_69C5();
  var_3 = scripts\mp\gametypes\br_circle::_id_69C6();
  var_4 = distance2d(var_0, var_2);
  return var_4 < var_3;
}

_id_7270(var_0, var_1) {
  if(!scripts\mp\gametypes\br_c130::_id_89B2(var_0, 1)) {
    return 0;
  }

  if(!isDefined(level._id_2A1B) || !isDefined(level._id_2A1B._id_CACA) || !isDefined(level._id_2A1B._id_433D)) {
    return 1;
  }

  if(_id_7273(var_0)) {
    return 1;
  }

  if(!_id_7272(var_0)) {
    return 0;
  }

  if(isDefined(var_1)) {
    var_2 = scripts\mp\gametypes\br_circle::_id_6B5E(var_0);

    if(var_1 > var_2) {
      return 0;
    }
  }

  var_3 = scripts\mp\gametypes\br_circle::_id_6D02();
  var_4 = scripts\mp\gametypes\br_circle::_id_6D03();
  var_5 = scripts\mp\gametypes\br_circle::_id_69C5();
  var_6 = scripts\mp\gametypes\br_circle::_id_69C6();
  var_7 = length(var_5 - var_3);
  var_8 = vectornormalize(var_5 - var_3);
  var_9 = level._id_C69B;
  var_10 = var_3 + var_8 * var_7 * var_9;
  var_11 = var_4 + (var_6 - var_4) * var_9;
  var_12 = distance2d(var_0, var_10);
  return var_12 < var_11;
}

_id_89A7(var_0, var_1) {
  if(var_0 == self) {
    return 0;
  }

  if(!isalive(var_0) || var_0 scripts\mp\gametypes\br_public::_id_8991() || istrue(var_0._id_2A63)) {
    return 0;
  }

  if(!_id_7270(var_0.origin, var_1)) {
    return 0;
  }

  return 1;
}

_id_B6B5(var_0, var_1) {
  var_2 = undefined;

  if(istrue(level.onlinegame) && self getprivatepartysize()) {
    var_3 = undefined;

    foreach(var_5 in self _meth_8133()) {
      if(!_id_89A7(var_5, var_1)) {
        continue;
      }
      var_3 = var_5;

      if(var_5 _meth_81BF()) {
        break;
      }
    }

    if(isDefined(var_3) && istrue(var_0)) {
      var_2 = var_3;
      var_3 = undefined;

      foreach(var_5 in self _meth_8133()) {
        if(isDefined(var_2) && var_2 == var_5) {
          continue;
        }
        if(!_id_89A7(var_5, var_1)) {
          continue;
        }
        var_3 = var_5;

        if(var_5 _meth_81BF()) {
          break;
        }
      }
    }

    if(isDefined(var_3)) {
      return var_3;
    }
  }

  if(isDefined(self._id_8FBB)) {
    var_9 = undefined;
    var_10 = undefined;
    var_11 = scripts\mp\utility\teams::_id_6A59(self.team, 1);

    foreach(var_13 in var_11) {
      if(isDefined(var_2) && var_2 == var_13) {
        continue;
      }
      if(!_id_89A7(var_13, var_1)) {
        continue;
      }
      if(var_13 _meth_86B8() || var_13 isskydiving()) {
        continue;
      }
      var_14 = distance2dsquared(self._id_8FBB, var_13.origin);

      if(!isDefined(var_10) || var_14 < var_10) {
        var_9 = var_13;
        var_10 = var_14;
      }
    }

    if(isDefined(var_9) && istrue(var_0) && !isDefined(var_2)) {
      var_2 = var_9;
      var_9 = undefined;
      var_10 = undefined;

      foreach(var_13 in var_11) {
        if(isDefined(var_2) && var_2 == var_13) {
          continue;
        }
        if(!_id_89A7(var_13, var_1)) {
          continue;
        }
        if(var_13 _meth_86B8() || var_13 isskydiving()) {
          continue;
        }
        var_14 = distance2dsquared(self._id_8FBB, var_13.origin);

        if(!isDefined(var_10) || var_14 < var_10) {
          var_9 = var_13;
          var_10 = var_14;
        }
      }
    }

    if(isDefined(var_9)) {
      return var_9;
    }
  }

  var_9 = undefined;
  var_18 = scripts\engine\utility::array_randomize(level._id_EF6A[self.team]["alivePlayers"]);

  foreach(var_20 in var_18) {
    if(isDefined(var_2) && var_2 == var_20) {
      continue;
    }
    if(!_id_89A7(var_20, var_1)) {
      continue;
    }
    var_9 = var_20;

    if(istrue(var_20 scripts\mp\gametypes\br_public::_id_898B())) {
      break;
    }
  }

  if(isDefined(var_9)) {
    return var_9;
  } else if(scripts\mp\utility\game::_id_6D9E() == "dmz") {
    var_22 = scripts\mp\utility\teams::_id_6DCA(self.team, "teamCount");

    if(var_22 == 1) {
      return self;
    }
  }

  return undefined;
}

_id_6D04(var_0, var_1, var_2) {
  var_3 = 3.14159;
  var_4 = scripts\mp\gametypes\br_circle::_id_6D02();
  var_5 = vectornormalize(var_0 - var_4);
  var_6 = vectortoangles(var_5);
  var_7 = randomfloatrange(getdvarfloat("#x32922a0bb9f930b54", 10.0), getdvarfloat("#x329458ebb9fb92b76", 60.0));
  var_8 = var_5;
  var_9 = var_0 + var_8 * var_1;

  if(_id_7270(var_9, var_2)) {
    return var_9;
  }

  var_8 = var_8 * -1;
  var_9 = var_0 + var_8 * var_1;

  if(_id_7270(var_9, var_2)) {
    return var_9;
  }

  var_8 = vectornormalize(var_4 - var_0);
  var_9 = var_0 + var_8 * var_1;

  if(_id_7270(var_9, var_2)) {
    return var_9;
  }

  var_10 = var_1;
  var_11 = distance2d(var_0, var_4);
  var_12 = var_10 / var_11;

  if(var_12 > var_3) {
    var_12 = var_3;
  }

  var_13 = var_12 * 180 / var_3;
  var_9 = _func_01C6((0, 0, 1), var_0 - var_4, var_13) + var_4;

  if(_id_7270(var_9, var_2)) {
    return var_9;
  }

  var_9 = scripts\mp\gametypes\br_circle::_id_6CC7(var_0, var_1);
  return var_9;
}

_id_B6B4() {
  foreach(var_5, var_1 in level._id_BEAF._id_BEB8) {
    foreach(var_4, var_3 in var_1._id_8300) {
      if(var_4 == self.team && !scripts\mp\gametypes\br_quest_util::_id_89D0(var_3)) {
        switch (var_3._id_332F) {
          case "assassination":
            if(isDefined(var_3._id_EEF3)) {
              return var_3._id_EEF3.origin;
            }

            break;
          case "domination":
            if(isDefined(var_3._id_EABF) && isDefined(var_3._id_EABF._id_4D1E) && isDefined(var_3._id_EABF._id_4D1E._id_4140)) {
              return var_3._id_EABF._id_4D1E._id_4140;
            }

            break;
          case "scavenger":
            if(isDefined(var_3._id_EABF._id_2EA6.origin) && isDefined(var_3._id_EABF._id_2EA6)) {
              return var_3._id_EABF._id_2EA6.origin;
            }

            break;
          default:
            break;
        }
      }
    }
  }

  return undefined;
}

_id_B6B3(var_0) {
  foreach(var_2 in level._id_2A95._id_3E9B) {
    if(!isDefined(var_2) || !isDefined(var_2.team) || var_2.team != self.team) {
      continue;
    }
    if(isDefined(var_2._id_B790) && isDefined(var_2._id_B790[self getentitynumber()])) {
      continue;
    }
    if(_id_7270(var_2.origin, var_0)) {
      return var_2.origin;
    }
  }
}

_id_B6CA(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 1;

  if(isDefined(self._id_D6DA)) {
    var_2 = self._id_D6DA._id_B7D1;
    var_3 = self._id_D6DA._id_B7CB;
  }

  var_6 = getdvarfloat("#x3c13c19d58157cb9f", 1000);

  if(!isDefined(var_2) && var_6 >= 0) {
    var_7 = _id_B6B5(var_0, var_1);

    if(isDefined(var_7)) {
      var_8 = getdvarfloat("#x35883f5ac811825bd", 5.0) * 1000;
      var_9 = getdvarfloat("#x3b53c971ac6ae8cf5", 30.0) * 1000;

      if(getDvar("#x3f59526763711edc4", "") == "dmz" && isDefined(level._id_EF6A[self.team]["lastParachuteTime"]) && level._id_EF6A[self.team]["lastParachuteTime"] + var_9 > gettime() + var_8 && distance2d(level._id_EF6A[self.team]["lastParachuteOrigin"], var_7.origin) < getdvarfloat("#x3c13c19d58157cb9f", 1000) * 1.25) {
        var_2 = level._id_EF6A[self.team]["lastParachuteOrigin"];
        var_3 = level._id_EF6A[self.team]["lastParachuteAngles"];
      } else {
        var_2 = _id_6D04(var_7.origin, var_6, var_1);
        var_3 = _id_68BE(var_2, var_7.origin);
        level._id_EF6A[self.team]["lastParachuteOrigin"] = var_2;
        level._id_EF6A[self.team]["lastParachuteAngles"] = var_3;
        level._id_EF6A[self.team]["lastParachuteTime"] = gettime();
      }
    }
  }

  var_6 = getdvarfloat("#x370564b9020935cb9", 3000);

  if(!isDefined(var_2) && var_6 >= 0) {
    var_10 = _id_B6B4();

    if(isDefined(var_10)) {
      var_2 = _id_6D04(var_10, var_6, var_1);
      var_3 = _id_68BE(var_2, var_10);
    }
  }

  var_6 = getdvarfloat("#x3384cf868934ba288", 3000);

  if(!isDefined(var_2) && var_6 >= 0) {
    var_11 = _id_B6B3(var_1);

    if(isDefined(var_11)) {
      var_2 = _id_6D04(var_11, var_6, var_1);
      var_3 = _id_68BE(var_2, var_11);
    }
  }

  if(!isDefined(var_2)) {
    if(isDefined(level._id_2A1B) && isDefined(level._id_2A1B._id_CACA)) {
      var_12 = scripts\mp\gametypes\br_circle::_id_6D02();
      var_13 = scripts\mp\gametypes\br_circle::_id_6D03();
      var_14 = getdvarfloat("#x3817bd8f1b23dbc2f", 0.5);
      var_15 = getdvarfloat("#x3d0aeb4062a82621", 0.9);
      var_16 = getdvarint("#x3e81656e05d4eb583", 1);
      var_17 = getdvarint("#x3e4b157f3386c511f", 1);
      var_2 = scripts\mp\gametypes\br_circle::_id_6CC6(var_12, var_13, var_14, var_15, var_16, var_17, 0, var_1);
    } else if(isDefined(level._id_BBB2)) {
      if(isDefined(level._id_EF6A[self.team]["chosenSpawnWipeOrigin"]) && isDefined(level._id_EF6A[self.team]["spawnWipeOriginUseStartTime"]) && isDefined(level._id_1F51) && level._id_EF6A[self.team]["spawnWipeOriginUseStartTime"] + level._id_1F51 * 1000 > gettime()) {
        var_2 = level._id_EF6A[self.team]["chosenSpawnWipeOrigin"];
      } else {
        var_18 = [];

        foreach(var_20 in level._id_BBB2) {
          if(distance2dsquared(var_20.origin, self.origin) > var_6) {
            var_18[var_18.size] = var_20;
          }
        }

        if(var_18.size == 0) {
          var_18 = level._id_BBB2;
        }

        var_18 = scripts\engine\utility::array_randomize(var_18);
        var_2 = var_18[0].origin;
        var_2 = var_2 + scripts\engine\math::_id_BFF0() * randomfloatrange(100, 500);
        level._id_EF6A[self.team]["chosenSpawnWipeOrigin"] = var_2;
        level._id_EF6A[self.team]["spawnWipeOriginUseStartTime"] = gettime();
      }

      var_3 = (0, 0, 0);

      if(var_2[2] > 10000) {
        var_5 = 0;
        var_4 = scripts\mp\gametypes\br_infils::_id_6ABB();
      }
    } else {
      var_2 = (0, 0, 0);
      var_3 = (0, 0, 0);
    }
  }

  if(!isDefined(var_3)) {
    var_22 = scripts\mp\gametypes\br_circle::_id_6D02();
    var_23 = _func_0261(var_22 - var_2);
    var_3 = (0, var_23, 0);
  }

  if(var_5) {
    var_4 = _id_0797::_id_693D();

    if(isDefined(level._id_2A1B)) {
      var_24 = level._id_2A1B._id_372F;
      var_25 = _id_6A83();
      var_26 = isDefined(var_24) && var_24 >= var_25;

      if(var_26) {
        var_4 = var_4 * getdvarfloat("#x359342c9c7c346f6e", 0.55);
      }
    }

    if(isDefined(level._id_C6A2)) {
      var_4 = level._id_C6A2;
    }

    var_27 = (0, 0, var_4);
    var_2 = scripts\mp\gametypes\br::_id_6BCA(var_2, var_27);
  }

  var_28 = spawnStruct();
  var_28.origin = var_2;
  var_28.angles = var_3;
  var_28.height = var_4;
  return var_28;
}

_id_68BE(var_0, var_1) {
  var_2 = _func_0261(var_1 - var_0);
  var_3 = (0, var_2, 0);
  return var_3;
}

_id_728C(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = !istrue(var_0);

  if(!istrue(var_0)) {
    _id_07BC::_id_AAFA(1);
  }

  if(isDefined(var_1)) {
    scripts\mp\gametypes\br_analytics::_id_2AF2(self, var_1);
  }

  if(var_6) {
    _id_D67A(0);
    _id_D67B(0);
    _id_B692(self._id_1A5C);
    _id_D67C(0);
    self._id_8B62 = undefined;

    if(isDefined(self._id_ABE7)) {
      scripts\mp\outofbounds::disableoobimmunity(self);
    }
  }

  scripts\mp\gametypes\br::_id_6FAF(self);
  _id_B7F1(self._id_1A5C);
  _id_728A();

  if(isDefined(level._id_7262) && istrue(level._id_7262._id_B191)) {
    if(var_6) {
      _id_B769();
    }

    _id_7281();
    _id_B7A6();
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = _id_B6CA();
  }

  var_7 = var_2.origin;
  var_8 = var_2.angles;
  var_9 = var_7;

  if(isDefined(var_4)) {
    var_9 = var_4;
  }

  _id_7281();
  _id_B7F5(var_9, var_8);
  var_10 = spawn("script_model", var_9);
  var_10 setModel("tag_origin");
  var_10.angles = var_8;
  var_10 hide();
  var_10 showtoplayer(self);
  self playerlinktoabsolute(var_10, "tag_origin");
  self playerhide();
  thread _id_B677(var_10);
  waitframe();

  if(var_6) {
    _id_B769();
  }

  if(getdvarint("#x36dc712d351157361", 1) == 0) {
    scripts\mp\gametypes\br_public::_id_B817();
  }

  scripts\mp\gametypes\br_public::_id_B67D();

  if(isDefined(var_4)) {
    var_10.origin = var_7;
  }

  var_10 playsoundtoplayer("br_ac130_flyby", self);
  wait 1.5;
  self unlink();
  self _meth_8680("deaths_door_mp");
  self _meth_8078(1);
  self playershow();
  _id_B6CC(1);
  var_11 = 0;

  if(isDefined(level._id_AE2C)) {
    var_11 = level._id_AE2C;
  }

  if(!scripts\mp\gametypes\br_public::_id_8805()) {
    thread _id_0797::_id_E6AD(var_11, 0, undefined, undefined, 1);
  }

  if(!istrue(var_3)) {
    thread _id_F631(7);
  }

  if(istrue(var_5)) {
    self setclientomnvar("ui_br_transition_type", 0);
  }

  self setclientomnvar("ui_show_spectateHud", -1);
  _id_C633();
  scripts\mp\gametypes\br_armor::_id_6FF3();
  scripts\mp\gametypes\br_quest_util::_id_AB74();
  scripts\mp\gametypes\br_rewards::_id_AB74();
  wait 0.5;
  _id_7267();
  waitframe();
  var_10 delete();

  if(scripts\mp\gametypes\br_public::_id_878D()) {
    self notify("respawn_from_gulag");
  }

  self notify("can_show_splashes");

  if(isDefined(level._id_7262) && istrue(level._id_7262._id_DD08) && !istrue(self._id_7266)) {
    wait 2.0;
    _id_B6C7();
  }
}

_id_B677(var_0) {
  var_0 endon("death");
  self waittill("disconnect");

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_B6CC(var_0) {
  if(var_0) {
    self enableoffhandweapons();
    self enableusability();
  } else {
    self disableoffhandweapons();
    self disableusability();
  }
}

_id_F631(var_0) {
  self endon("disconnect");
  wait 0.5;
  thread scripts\mp\hud_message::showsplash("br_gulag_winner");
}

_id_B769() {
  self notify("gulagRespawn");
  _id_0A11::_id_A046();
  self.health = self.maxhealth;
  scripts\mp\healthoverlay::_id_AADF(1);
  scripts\mp\utility\player::_id_5265(0);
  self setclientomnvar("ui_gulag", 0);
  scripts\mp\gametypes\br_public::_id_FC1A("isRespawning", 0);
  self._id_1A5C = undefined;
}

_id_728A() {
  if(getdvarint("#x36a0aad576def2a22", 0) != 0) {
    _id_728B();
  } else if(isDefined(level._id_2ABE) || getdvarint("#x3b27dcdf61dcbba17", 1) != 0 && getdvarint("#x38c226be1ea05b48e", -1) > -1) {
    self._id_7286 = 1;
  }
}

_id_728E() {
  if(!istrue(level._id_FE76)) {
    return 0;
  }

  var_0 = 0;

  if(getdvarint("#x36a0aad576def2a22", 0) != 0) {
    var_0 = _id_728D();
  } else if(isDefined(level._id_2ABE) || getdvarint("#x3b27dcdf61dcbba17", 1) != 0 && getdvarint("#x38c226be1ea05b48e", -1) > -1) {
    var_0 = _id_728F();
  }

  return var_0;
}

_id_728B() {
  self._id_2A52 = self getcurrentprimaryweapon();
  var_0 = self getweaponslistprimaries();
  var_0 = scripts\engine\utility::array_remove(var_0, makeweapon("iw8_knifestab_mp"));
  var_0 = scripts\engine\utility::array_remove(var_0, makeweapon("s4_me_fists_mp"));
  self._id_2A53 = [];
  self._id_2A50 = [];

  foreach(var_2 in var_0) {
    var_3 = getcompleteweaponname(var_2);

    if(_func_00D6(var_3, 0, 4) == "alt_") {
      continue;
    }
    self._id_2A53[self._id_2A53.size] = var_2;
    self._id_2A50[var_3] = weaponclipsize(var_2) * 3;
  }

  var_5 = self _meth_8195();
  self._id_2A54 = [];

  foreach(var_7 in var_5) {
    var_8 = self getweaponammoclip(var_7);

    if(var_8 <= 0) {
      continue;
    }
    self._id_2A54[self._id_2A54.size] = var_7;
    var_9 = getcompleteweaponname(var_7);
    self._id_2A50[var_9] = _func_027D(var_7);
  }
}

_id_728D() {
  if(isDefined(self._id_2A53) && isDefined(self._id_2A54) && isDefined(self._id_2A50)) {
    self takeallweapons();
    scripts\mp\gametypes\br_weapons::_id_29FF();
    self.equipment["primary"] = undefined;
    self.equipment["secondary"] = undefined;
    self.equipment["health"] = undefined;
    self.equipment["super"] = undefined;

    if(self._id_2A53.size < 2) {
      self giveweapon(makeweapon("s4_me_fists_mp"));
    }

    var_0 = 0;

    foreach(var_2 in self._id_2A53) {
      var_3 = getcompleteweaponname(var_2);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);
      self setweaponammostock(var_2, 0);

      if(!var_0) {
        self _meth_84A1(var_3);
        scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_2);
        var_0 = 1;
      }

      scripts\mp\weapons::_id_5BFC(self, var_3);
      thread scripts\mp\gametypes\br_respawn::_id_7008(var_3);
      var_4 = weaponclipsize(var_2);
      var_5 = int(min(var_4, 25));

      if(isDefined(self._id_2A50[var_3])) {
        var_5 = int(max(var_5, self._id_2A50[var_3]));
      }

      var_6 = 0;

      if(var_5 > var_4) {
        var_6 = var_5 - var_4;
        var_5 = var_4;
      }

      self setweaponammoclip(var_2, var_5);

      if(var_6 > 0) {
        var_7 = scripts\mp\gametypes\br_weapons::_id_2A07(var_2);
        scripts\mp\gametypes\br_weapons::_id_29FB(self, var_7, var_6);
      }
    }

    scripts\mp\gametypes\br_weapons::_id_2A0C(self);

    foreach(var_10 in self._id_2A54) {
      var_11 = scripts\mp\equipment::_id_6A14(var_10);

      if(isDefined(var_11) && isDefined(level._id_2A95._id_2A43[var_11])) {
        var_12 = level._id_2A95._id_2A43[var_11];
        scripts\mp\gametypes\br_pickups::_id_2A46(self, var_12, 1);
        var_3 = getcompleteweaponname(var_10);

        if(isDefined(self._id_2A50[var_3])) {
          var_13 = self._id_2A50[var_3];
          self setweaponammoclip(var_10, var_13);
        }
      }
    }

    if(isDefined(self._id_2A52)) {
      self switchtoweaponimmediate(self._id_2A52);
    }

    self._id_2A51 = undefined;
    self._id_2A50 = undefined;
    self._id_2A54 = undefined;
    self._id_2A52 = undefined;
    return 1;
  }

  return 0;
}

_id_728F() {
  if(istrue(self._id_7286)) {
    var_0 = getdvarint("#x38c226be1ea05b48e", -1);

    if(var_0 > -1) {
      self.pers["gamemodeLoadout"] = level._id_BBAA[var_0];
    } else {
      self.pers["gamemodeLoadout"] = level._id_2ABE;
    }

    self.class = "gamemode";
    self._id_BC6C = undefined;
    var_1 = scripts\mp\class::_id_962A();
    var_1 = scripts\mp\class::_id_963A(var_1, "gamemode");
    scripts\mp\class::_id_BB99(var_1, 1, 1);
    scripts\mp\class::_id_6FB1(self.team, "gamemode", 0, 0);
    self _meth_819C(var_1._id_968A);
    self _meth_819C(var_1._id_9699);
    scripts\mp\gametypes\br::_id_6FAF(self);
    scripts\mp\gametypes\br_weapons::_id_29FF();
    scripts\mp\gametypes\br_weapons::_id_2A4C();
    scripts\mp\gametypes\br_weapons::_id_2A0C(self);
    self notify("ammo_update");
    thread scripts\mp\gametypes\br::_id_2A36();
    self._id_7286 = undefined;
    return 1;
  }

  return 0;
}

_id_B9E3(var_0) {
  var_1 = var_0._id_9BC4[0];
  var_0._id_9BC4 = scripts\engine\utility::array_remove_index(var_0._id_9BC4, 0);
  return var_1;
}

_id_3516() {
  if(level._id_7262._id_9CB7 >= 0) {
    var_0 = self._id_7288;

    if(!isDefined(var_0)) {
      var_0 = 0;
    }

    if(var_0 >= level._id_7262._id_9CB7) {
      return 0;
    }
  }

  return 1;
}

_id_F748() {
  if(!istrue(self._id_2A61) || !_id_07D1::_id_60BE("prematch_done")) {
    return 0;
  }

  if(istrue(self._id_7262)) {
    return 0;
  }

  if(scripts\mp\gametypes\br_public::_id_75A4() && !scripts\mp\gametypes\br_pickups::_id_C6C7()) {
    thread _id_B6C6();
    return 1;
  }

  if(!istrue(level._id_FE76)) {
    return 0;
  }

  if(istrue(level._id_7262._id_DD08) && !_id_B6E1()) {
    return 0;
  }

  if(getdvarint("#x32aa91d1834bc79f8", 0)) {
    return 0;
  }

  if(istrue(self._id_727A)) {
    return 0;
  }

  if(!_id_3516()) {
    return 0;
  }

  thread _id_8265(1);
  return 1;
}

_id_B6CB(var_0) {
  if(isDefined(var_0._id_5A2D) && !var_0._id_5A2D) {
    _id_B7A0(var_0);
  }

  if(isDefined(var_0._id_5A2D) && !var_0._id_5A2D && isDefined(var_0._id_F1E8) && var_0._id_F1E8 > 0) {
    var_1 = var_0._id_F1E8;

    if(!istrue(var_0._id_AD6F)) {
      var_2 = _id_6BFF();
      var_1 = var_1 - var_2;
    }

    self setclientomnvar("ui_br_gulag_match_end_time", gettime() + int(var_1 * 1000));
  } else
    self setclientomnvar("ui_br_gulag_match_end_time", 0);
}

_id_FCC4(var_0, var_1) {
  _id_0DAC(var_0._id_1ABE, var_1);
  _id_0DAC(var_0._id_8B5C, var_1);
}

_id_0DAC(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(var_1 > 0) {
      var_3 setclientomnvar("ui_br_gulag_match_end_time", gettime() + int(var_1 * 1000));
      continue;
    }

    var_3 setclientomnvar("ui_br_gulag_match_end_time", 0);
  }
}

_id_FCBE(var_0) {
  for(var_1 = 2; var_1 <= level._id_7262._id_9C93; var_1 = var_1 + 2) {
    var_2 = [];

    foreach(var_4 in var_0._id_8B5C) {
      if(!isDefined(var_4)) {
        continue;
      }
      var_5 = 0;

      foreach(var_12, var_7 in var_2) {
        if(var_7.size >= var_1) {
          continue;
        }
        var_8 = 0;

        foreach(var_10 in var_7) {
          if(var_10.team == var_4.team) {
            var_8 = 1;
            break;
          }
        }

        if(!var_8) {
          var_5 = 1;
          var_4._id_727F = var_12 + 1;
          var_2[var_12][var_2[var_12].size] = var_4;
          break;
        }
      }

      if(!var_5) {
        var_4._id_727F = var_2.size + 1;
        var_2[var_2.size] = [var_4];
      }
    }

    var_0._id_9BC4 = var_2;

    if(var_2.size <= level._id_7262._id_9C9B) {
      break;
    }
  }

  _id_FC05(var_0);
}

_id_B81D(var_0) {
  self endon("gulagLost");
  self endon("gulag_end");
  self waittill("death_or_disconnect");

  if(isDefined(self) && istrue(self._id_7263)) {
    return;
  }
  if(isDefined(self)) {
    if(istrue(self._id_7263)) {
      var_0._id_1ABE = scripts\engine\utility::array_remove(var_0._id_1ABE, self);
    } else if(istrue(self._id_8B5B)) {
      var_0._id_8B5C = scripts\engine\utility::array_remove(var_0._id_8B5C, self);
    }

    _id_B692(var_0);
  } else {
    var_0._id_8B5C = scripts\engine\utility::_id_1BD1(var_0._id_8B5C);
    var_0._id_1ABE = scripts\engine\utility::_id_1BD1(var_0._id_1ABE);
  }

  _id_FCBE(var_0);
}

_id_B692(var_0) {
  self setclientomnvar("ui_br_gulag_match_end_time", 0);

  if(isDefined(var_0)) {
    _id_B67A(var_0);
  }

  if(isDefined(self._id_7274)) {
    self._id_7274 destroy();
  }

  self._id_7279 = undefined;
}

_id_D67A(var_0) {
  if(isDefined(self._id_7262) && self._id_7262 == var_0) {
    return;
  }
  self._id_7262 = var_0;
  level notify("update_circle_hide");
}

_id_D67B(var_0, var_1) {
  if(isDefined(self._id_7263) && self._id_7263 == var_0) {
    return;
  }
  if(!istrue(var_1)) {
    _id_D665(var_0);
  }

  self._id_7263 = var_0;
  level notify("update_circle_hide");
}

_id_D665(var_0) {
  if(istrue(var_0)) {
    self._id_01F1 = self._id_01F1 | 1024;
  } else {
    self._id_01F1 = self._id_01F1 &~1024;
  }
}

_id_D67C(var_0) {
  if(isDefined(self._id_8B5B) && self._id_8B5B == var_0) {
    return;
  }
  _id_D666(var_0);
  self._id_8B5B = var_0;
}

_id_D666(var_0) {
  if(var_0) {
    self._id_01F1 = self._id_01F1 | 512;
  } else {
    self._id_01F1 = self._id_01F1 &~512;
  }
}

_id_D661(var_0) {
  if(var_0._id_726D > 7) {
    return;
  }
  var_1 = 3;
  var_2 = 3;
  var_3 = int(_func_01A6(2, var_1)) - 1;
  var_4 = (var_0._id_726D &var_3) << var_2;
  var_5 = ~(var_3 << var_2);
  var_6 = self._id_01F1;
  var_7 = var_6 &var_5;
  var_8 = var_7 + var_4;
  self._id_01F1 = var_8;
}

_id_E680(var_0, var_1) {
  if(!level._id_7262._id_24DA) {
    return undefined;
  }

  var_2 = spawnStruct();
  var_2._id_5A2B = var_1;
  var_2._id_24D8 = [];
  var_2._id_24DB = 1;
  var_2 thread _id_DC25(var_0);
  return var_2;
}

_id_DC25(var_0) {
  self endon("end_betting");

  for(;;) {
    var_1 = _id_6920(var_0, self);

    foreach(var_3 in var_1) {
      if(isbot(var_3)) {
        continue;
      }
      if(isDefined(self._id_24D8[var_3.guid])) {
        continue;
      }
      thread _id_DC8A(var_0, var_3);
    }

    var_0 waittill("player_added_to_jail");
  }
}

_id_DC8A(var_0, var_1) {
  self endon("end_betting");
  var_2 = spawnStruct();
  var_2.owner = var_1;
  self._id_24D8[var_1.guid] = var_2;
  var_3 = 10;
  var_4 = 0;
  var_2._id_7B67 = var_1 scripts\mp\hud_util::createfontstring("default", 1.2);
  var_2._id_7B67 scripts\mp\hud_util::setpoint("LEFT", "CENTER", var_3, var_4);
  var_2._id_7B67.label = &"";
  var_2._id_7B67.alpha = 0.0;
  var_5 = 5;
  var_6 = -50;
  var_2._id_7B5C = var_1 scripts\mp\hud_util::createfontstring("default", 1.2);
  var_2._id_7B5C scripts\mp\hud_util::setpoint("LEFT", "LEFT", var_5, var_6);
  var_2._id_7B5C.label = &"MP/BR_GULAG_BET_AVAILABLE";
  var_2._id_7B5C _id_07E1::_id_5E31();
  var_2._id_7B5D = var_1 scripts\mp\hud_util::createfontstring("default", 1.5);
  var_2._id_7B5D scripts\mp\hud_util::setpoint("LEFT", "LEFT", var_5, var_6 + 25);
  var_2._id_7B5D.label = &"";
  var_2._id_7B5B = var_1 scripts\mp\hud_util::createfontstring("default", 1.5);
  var_2._id_7B5B scripts\mp\hud_util::setpoint("LEFT", "LEFT", var_5, var_6 + 40);
  var_2._id_7B5B.label = &"MP/BR_GULAG_BET_AMMOUNT";
  var_2._id_B666 = -1;
  var_2._id_B6AC = -1;
  var_2._id_174E = 0;
  _id_FC13(var_2);
  thread _id_FC14(var_0, var_2);
  thread _id_10A9A(var_2);
}

_id_FC14(var_0, var_1) {
  self endon("end_betting");
  var_1.owner endon("disconnect");
  var_2 = 0.9;

  for(;;) {
    var_3 = -1;
    var_4 = -1.0;
    var_5 = var_1.owner getEye();
    var_6 = anglesToForward(var_1.owner getplayerangles());

    foreach(var_12, var_8 in self._id_5A2B) {
      if(!isDefined(var_8)) {
        continue;
      }
      var_9 = var_8.origin + (0, 0, 30);
      var_10 = vectornormalize(var_9 - var_5);
      var_11 = vectordot(var_6, var_10);

      if(var_11 < var_2 || var_11 < var_4) {
        continue;
      }
      var_3 = var_12;
      var_4 = var_11;
    }

    if(var_3 != var_1._id_B6AC) {
      var_1._id_B6AC = var_3;
      _id_FCE1(var_0);
      _id_FC13(var_1);
    }

    wait 0.05;
  }
}

_id_10A99(var_0) {
  self endon("end_betting");
  var_0.owner endon("disconnect");
  var_1 = "betClear";
  thread _id_A6A9(var_0.owner, var_1, "+weapnext");

  for(;;) {
    var_0.owner waittill(var_1);

    if(var_0._id_B666 == -1) {
      continue;
    }
    var_0._id_174E = 0;
    var_0._id_B666 = -1;
    _id_FC13(var_0);
  }
}

_id_10A9A(var_0) {
  self endon("end_betting");
  var_0.owner endon("disconnect");
  var_1 = "betPlaced";
  thread _id_A6A9(var_0.owner, var_1, "+usereload");

  for(;;) {
    var_0.owner waittill(var_1);

    if(var_0._id_B6AC == -1) {
      if(var_0._id_B666 == -1) {
        continue;
      }
      var_2 = 0;
    } else if(var_0._id_B666 == -1)
      var_2 = 1;
    else if(var_0._id_B666 == var_0._id_B6AC) {
      var_2 = var_0._id_174E + 1;
    } else {
      var_2 = 1;
    }

    if(var_2 > var_0.owner._id_B956) {
      _id_24D7(var_0);
      continue;
    }

    var_0._id_174E = var_2;
    var_0._id_B666 = var_0._id_B6AC;
    _id_FC13(var_0);
  }
}

_id_A6A9(var_0, var_1, var_2) {
  var_0 notifyonplayercommand(var_1, var_2);
  self waittill("end_betting");

  if(isDefined(var_0)) {
    var_0 _meth_824C(var_1, var_2);
  }
}

_id_24D7(var_0) {
  var_0.owner playlocalsound("br_pickup_deny");
  var_0._id_7B5C thread _id_07E1::_id_5E30(var_0.owner);
}

_id_FC13(var_0) {
  var_1 = 1000;
  var_0._id_7B5C _meth_83A3((var_0.owner._id_B956 - var_0._id_174E) * var_1);

  if(var_0._id_B666 != -1) {
    var_2 = self._id_5A2B[var_0._id_B666];

    if(isDefined(var_2)) {
      var_0._id_7B5D _meth_8367(var_2);
      var_0._id_7B5D.alpha = 1.0;
    } else
      var_0._id_7B5D.alpha = 0.0;
  } else
    var_0._id_7B5D.alpha = 0.0;

  if(var_0._id_174E > 0) {
    var_0._id_7B5B _meth_83A3(var_0._id_174E * var_1);
    var_0._id_7B5B.alpha = 1.0;
  } else
    var_0._id_7B5B.alpha = 0.0;

  if(var_0._id_B666 != -1) {
    if(var_0._id_B6AC == var_0._id_B666) {
      var_0._id_7B67.alpha = 1.0;
      var_0._id_7B67.label = &"MP/BR_GULAG_FOCUS_BET_INCREASE";
      var_0._id_7B67 settext(&"");
    } else if(var_0._id_B6AC != -1) {
      var_0._id_7B67.alpha = 1.0;
      var_0._id_7B67.label = &"MP/BR_GULAG_FOCUS_BET_CHANGE";
      var_2 = self._id_5A2B[var_0._id_B6AC];

      if(isDefined(var_2)) {
        var_0._id_7B67 _meth_8367(var_2);
        return;
      }
    } else {
      var_0._id_7B67.alpha = 1.0;
      var_0._id_7B67.label = &"MP/BR_GULAG_FOCUS_BET_CLEAR";
      var_0._id_7B67 settext(&"");
    }
  } else if(var_0._id_B6AC != -1) {
    var_0._id_7B67.alpha = 1.0;
    var_0._id_7B67.label = &"MP/BR_GULAG_FOCUS_BET";
    var_2 = self._id_5A2B[var_0._id_B6AC];

    if(isDefined(var_2)) {
      var_0._id_7B67 _meth_8367(var_2);
      return;
    }
  } else {
    var_0._id_7B67.alpha = 0.0;
    var_0._id_7B67.label = &"";
  }
}

_id_3874(var_0, var_1) {
  var_0 notify("cleanUpBetHud");

  if(isDefined(var_1)) {
    var_0 endon("cleanUpBetHud");
    wait(var_1);
  }

  var_2 = [var_0._id_7B5D, var_0._id_7B5B, var_0._id_7B5C, var_0._id_7B67];

  foreach(var_4 in var_2) {
    if(isDefined(var_4)) {
      var_4 destroy();
    }
  }
}

_id_10A98(var_0, var_1, var_2, var_3) {
  self endon("end_betting");

  for(;;) {
    var_1 waittill(var_2);
    var_0 notify("betPlaced", var_3);
  }
}

_id_52E2(var_0, var_1) {
  if(!isDefined(var_1) || !istrue(var_1._id_24DB)) {
    return;
  }
  var_1 notify("end_betting");
  var_1._id_24DB = 0;

  foreach(var_3 in var_1._id_24D8) {
    var_4 = [var_3._id_7B5C, var_3._id_7B67];

    if(var_3._id_B666 == -1) {
      var_4[var_4.size] = var_3._id_7B5D;
      var_4[var_4.size] = var_3._id_7B5B;
    }

    foreach(var_6 in var_4) {
      if(isDefined(var_6)) {
        var_6 destroy();
      }
    }
  }

  _id_FCE1(var_0);
}

_id_AF7D(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  var_2 = -1;

  if(isDefined(var_0)) {
    var_2 = var_0._id_5A2A;
  }

  foreach(var_4 in var_1._id_24D8) {
    if(var_4._id_B666 != -1 && isDefined(var_4.owner) && !istrue(var_4._id_ADD7)) {
      var_5 = var_4._id_B666 == var_2;
      _id_0BA5(var_1, var_4, var_5);
    }

    thread _id_3874(var_4, 2.5);
  }
}

_id_0BA5(var_0, var_1, var_2) {
  var_3 = (0, 1, 0);
  var_4 = (1, 0, 0);
  var_1._id_ADD7 = 1;

  if(var_2) {
    var_1.owner scripts\mp\gametypes\br_plunder::_id_B7A3(var_1.owner._id_B956 + var_1._id_174E);
    var_1._id_7B5D.color = var_3;
    var_1._id_7B5D.label = &"MP/BR_GULAG_BET_FIGHTER_NAME_WINNER";
    var_1._id_7B5B.color = var_3;
    var_1._id_7B5B.label = &"MP/BR_GULAG_BET_AMMOUNT_WON";
  } else {
    var_1._id_7B5D.color = var_4;
    var_1._id_7B5D.label = &"MP/BR_GULAG_BET_FIGHTER_NAME_LOSER";
    var_1._id_7B5B.color = var_4;
    var_1._id_7B5B.label = &"MP/BR_GULAG_BET_AMMOUNT_LOST";

    if(isalive(var_1.owner)) {
      var_5 = var_1.owner._id_B956 - var_1._id_174E;
      var_5 = int(max(0, var_5));
      var_1.owner scripts\mp\gametypes\br_plunder::_id_B7A3(var_5);
    }
  }

  var_6 = var_0._id_5A2B[var_1._id_B6AC];

  if(isDefined(var_6)) {
    var_6 _meth_81AE(var_1.owner);
  }
}

_id_6920(var_0, var_1) {
  var_2 = var_0._id_8B5C;

  if(level._id_7262._id_24DA > 1) {
    foreach(var_4 in var_1._id_5A2B) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_AF7C(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_4 in var_0._id_24D8) {
    if(var_4._id_B666 == var_1._id_5A2A && isDefined(var_4.owner) && !istrue(var_4._id_ADD7)) {
      _id_0BA5(var_0, var_4, var_2);
      thread _id_3874(var_4, 2.5);
    }
  }
}

_id_C898(var_0) {
  var_1 = self._id_1A5C;
  var_0 scripts\engine\utility::_id_108F5("missile_stuck", 4);
  wait 2;

  if(isDefined(var_0)) {
    var_0 delete();
  }

  if(level._id_7262._id_FE71) {
    _id_E35F(var_1);
  }
}

_id_E360(var_0) {
  var_0._id_C8BD = _func_03C0(var_0.target, "targetname");

  if(var_0._id_C8BD.size == 0 || !level._id_7262._id_FE71) {
    for(var_1 = 0; var_1 < var_0._id_C8BD.size; var_1++) {
      var_2 = var_0._id_C8BD[var_1];
      var_2 setscriptablepartstate("brloot_rock", "hidden");
    }

    return;
  }

  var_3 = 20;

  if(var_0._id_C8BD.size < var_3) {
    var_3 = var_0._id_C8BD.size;
  }

  var_0._id_C8BD = scripts\engine\utility::array_randomize(var_0._id_C8BD);
  var_0._id_C8A5 = var_3;
  var_4 = getdvarint("#x3a62a3ee04303c950", 1) == 0;

  for(var_1 = 0; var_1 < var_0._id_C8BD.size; var_1++) {
    var_2 = var_0._id_C8BD[var_1];
    var_2._id_1A5C = var_0;

    if(var_1 >= var_3 || var_4) {
      var_2 setscriptablepartstate("brloot_rock", "hidden");
    }
  }
}

_id_C8C0(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0) || !isDefined(var_3)) {
    return;
  }
  var_6 = makeweapon("rock_mp");

  if(var_3 hasweapon(var_6) && var_3 _meth_8109(var_6) > 0) {
    return;
  }
  var_0 setscriptablepartstate("brloot_rock", "hidden");
  var_3 thread scripts\mp\gametypes\br_pickups::_id_B744();
  var_3 scripts\mp\equipment::giveequipment("equip_rock", "primary");
  var_3 playlocalsound("br_rock_pickup");
}

_id_E35F(var_0) {
  if(istrue(var_0._id_DD08) || var_0._id_C8BD.size == 0) {
    return;
  }
  var_1 = var_0._id_C8BD[var_0._id_C8A5];
  var_1 setscriptablepartstate("brloot_rock", "visible");
  var_0._id_C8A5++;

  if(var_0._id_C8A5 >= var_0._id_C8BD.size) {
    var_0._id_C8A5 = 0;
  }
}

_id_B7F1(var_0) {
  var_1 = makeweapon("rock_mp");

  if(self hasweapon(var_1)) {
    self takeweapon(var_1);
    self clearaccessory();

    if(level._id_7262._id_FE71) {
      _id_E35F(var_0);
    }
  }
}

_id_6DB7(var_0, var_1, var_2) {
  var_3 = var_2[0] - var_0[0];
  var_4 = var_2[1] - var_0[1];
  var_5 = var_1;
  var_6 = var_3 * var_3;
  var_7 = var_4 * var_4;
  var_8 = var_5 * var_5;
  var_9 = var_6 + var_7 - var_8;
  var_10 = undefined;
  var_11 = 1;

  if(var_9 > 0) {
    var_12 = (var_8 * var_3 - var_5 * var_4 * _func_0218(var_6 + var_7 - var_8)) / (var_6 + var_7);
    var_13 = (var_8 * var_4 + var_5 * var_3 * _func_0218(var_6 + var_7 - var_8)) / (var_6 + var_7);
    var_10 = (var_12, var_13, var_2[2]) + (var_0[0], var_0[1], 0);
  } else {
    var_14 = vectornormalize((var_3, var_4, 0));
    var_15 = var_0 + var_14 * var_1;
    var_10 = (var_15[0], var_15[1], var_2[2]);
    var_11 = 0;
  }

  return [var_10, var_11];
}

_id_E25A() {
  if(!istrue(level._id_7262._id_B191)) {
    return;
  }
  level waittill("prematch_started");

  if(!istrue(level._id_2A60)) {
    wait 10;
  }

  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(level._id_29F4)) {
    var_0 = level._id_29F4._id_E715;
  } else {
    var_2 = scripts\mp\gametypes\br_c130::_id_4061();
    var_0 = var_2._id_E715;
  }

  if(isDefined(level._id_2A1B) && isDefined(level._id_2A1B._id_CACA)) {
    var_1 = level._id_2A1B._id_CACA.origin[2];
  } else {
    var_1 = level._id_2A73._id_2A25[0];
  }

  var_1 = var_1 - 100;
  [var_4, var_5] = _id_6DB7(level._id_2A73._id_2A7A, var_1, var_0);
  var_6 = 0;
  var_7 = 0;

  if(var_5) {
    var_6 = distance(var_0, var_4);
    var_7 = var_6 / scripts\mp\gametypes\br_c130::_id_6940();
  }

  var_8 = (level._id_2A73._id_2A7A[0], level._id_2A73._id_2A7A[1], var_0[2]);
  level._id_7262._id_0E42 = spawn("script_model", var_8);
  level._id_7262._id_0E42 setModel("tag_origin");
  level._id_7262._id_0E42._id_0359 = var_1;
  level._id_7262._id_0E18 = scripts\mp\gametypes\br_c130::_id_72F7(var_0, var_4, var_7, 0, ::_id_0E3D);
  level._id_7262._id_0E18 thread _id_0E46();
  level._id_7262._id_0E18._id_C835 = [];

  if(var_7 <= 0) {
    var_9 = var_4 - level._id_2A73._id_2A7A;
    var_10 = vectornormalize((var_9[0], var_9[1], 0));
    var_11 = vectortoangles(var_10);
    level._id_7262._id_0E18 unlink();
    level._id_7262._id_0E18.angles = (0, var_11[1] + 90, 0);
    level._id_7262._id_0E18.origin = var_4;
    level._id_7262._id_0E18 thread _id_0E41();
  }
}

_id_0E46() {
  var_0 = spawnStruct();
  self._id_18E7 = var_0;
  var_0._id_A289 = self;
  scripts\mp\gametypes\br_infils::_id_E33C(var_0, self);
  scripts\mp\gametypes\br_infils::_id_E33B(var_0, "j_prop_1");
  scripts\mp\gametypes\br_infils::_id_B319(var_0);
}

_id_0E3D(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self playLoopSound("br_ac130_lp");

  if(var_1 > 0) {
    self moveto(var_0, var_1, 0, 0);
    wait(var_1);
  }

  thread _id_0E41();
}

_id_0E41() {
  self notify("ac130LinkAndSpin");
  self endon("ac130LinkAndSpin");
  level._id_7262._id_0E42 endon("death");
  var_0 = 6.28318;
  var_1 = scripts\mp\gametypes\br_c130::_id_6940();
  var_2 = level._id_7262._id_0E42._id_0359;
  var_3 = var_0 * var_2 / var_1;
  self linkto(level._id_7262._id_0E42, "tag_origin");

  if(var_3 <= 0) {
    return;
  }
  for(;;) {
    level._id_7262._id_0E42 rotateyaw(360, var_3);
    wait(var_3);
  }
}

_id_10945() {
  var_0 = level._id_7262._id_1ABF.size;

  if(!istrue(level._id_7262._id_A2F5)) {
    var_0 = 1;
  }

  for(;;) {
    var_1 = 0;

    for(var_2 = 0; var_2 < var_0; var_2++) {
      var_3 = level._id_7262._id_1ABF[var_2];

      if(!istrue(var_3._id_DD08)) {
        var_1 = 1;
        break;
      }
    }

    if(!var_1) {
      return;
    }
    waitframe();
  }
}

_id_99D9() {
  if(!istrue(level._id_7262._id_B191)) {
    return;
  }
  var_0 = gettime();
  _id_10945();
  var_1 = gettime();
  wait(getdvarint("#x3d56a64f934e7f2c6", 15));
  waittillframeend;

  foreach(var_3 in level._id_7262._id_0E18._id_C835) {
    if(isDefined(var_3)) {
      var_3._id_8CA7 = "solo";
      var_3 notify("halo_kick_c130");
    }
  }

  while(level._id_7262._id_0E18._id_C835.size > 0) {
    waitframe();
  }

  var_5 = level._id_7262._id_0E18.origin;
  var_6 = anglesToForward(level._id_7262._id_0E18.angles);
  var_7 = level._id_2A73._id_2A25[0] * 2;
  var_8 = var_5 + var_6 * var_7;
  var_8 = var_8 + var_6 * scripts\mp\gametypes\br_c130::_id_6940();
  var_9 = distance(var_5, var_8);
  var_10 = var_9 / scripts\mp\gametypes\br_c130::_id_6940();
  level._id_7262._id_0E18 notify("ac130LinkAndSpin");
  level._id_7262._id_0E18 unlink();
  level._id_7262._id_0E18 moveto(var_8, var_10, 0, 0);
  wait(var_10);
  scripts\mp\gametypes\br_public::_id_383E(level._id_7262._id_0E18._id_18E7);

  if(isDefined(level._id_7262._id_0E18)) {
    level._id_7262._id_0E18 delete();
  }

  if(isDefined(level._id_7262._id_0E42)) {
    level._id_7262._id_0E42 delete();
  }
}

_id_F492(var_0, var_1) {
  if(!istrue(level._id_7262._id_B191)) {
    return;
  }
  if(!isDefined(level._id_7262._id_0E18) || !isDefined(level._id_7262._id_0E42)) {
    return;
  }
  var_2 = (level._id_2A1B._id_CACA.origin[0], level._id_2A1B._id_CACA.origin[1], level._id_7262._id_0E42.origin[2]);
  var_0 = var_0 - 100;

  if(level._id_7262._id_0E42._id_0359 != var_0) {
    var_3 = vectornormalize(level._id_7262._id_0E42.origin - level._id_7262._id_0E18.origin);
    var_4 = level._id_7262._id_0E18.origin + var_3 * var_0;
    level._id_7262._id_0E18 unlink();
    level._id_7262._id_0E42.origin = var_4;
    level._id_7262._id_0E42._id_0359 = var_0;
    level._id_7262._id_0E42 dontinterpolate();
    level._id_7262._id_0E18 thread _id_0E41();
  }

  level._id_7262._id_0E42 moveto(var_2, var_1);
  wait(var_1);
}

_id_B7A6() {
  self._id_7E64 = 1;
  self._id_88E7 = 0;
  scripts\mp\gametypes\br_infils::_id_B710(level._id_7262._id_0E18._id_18E7);
  thread scripts\mp\gametypes\br_infils::_id_B742(level._id_7262._id_0E18._id_18E7);
  thread _id_B75F(level._id_7262._id_0E18);
  scripts\mp\gametypes\br_infils::_id_B7A7(1);
  thread _id_B652();
  thread _id_B661();
  thread _id_B7D2();
  level._id_7262._id_0E18._id_C835[level._id_7262._id_0E18._id_C835.size] = self;
}

_id_B75F(var_0) {
  self.angles = var_0.angles;
  thread _id_954F(var_0);
  thread scripts\mp\gametypes\br_c130::_id_9550(var_0, 0);
  self._id_2E0E = level._id_7262._id_0E18;
  self._id_2A5E = "c130";
  thread scripts\mp\gametypes\br_c130::_id_AC5E(var_0);
}

_id_954F(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cancel_c130");
  self endon("br_jump");
  self._id_C16B = 0;
  scripts\engine\utility::_id_108C5("halo_jump_c130", "halo_jump_solo_c130");
  self._id_8CA7 = "solo";
  thread scripts\mp\gametypes\br_c130::_id_9168(var_0, 0, self getplayerangles(), 0);
}

_id_B7D2() {
  self endon("death_or_disconnect");
  self._id_B928 = 1;
  scripts\mp\gametypes\br_c130::_id_D67D(1);
  _id_10966(self);
  self._id_B928 = undefined;
  scripts\mp\gametypes\br_c130::_id_D67D(0);
}

_id_10966(var_0) {
  var_0 endon("timeout_gulag_ac130");
  thread _id_0DC8(var_0);
  var_0 waittill("infil_jump_done");

  while(!var_0 _meth_86B8() && !var_0 isonground()) {
    waitframe();
  }
}

_id_0DC8(var_0) {
  var_0 endon("death_or_disconnect");
  var_0 scripts\engine\utility::_id_108A8(getdvarint("#x3d56a64f934e7f2c6", 15), "halo_kick_c130", "halo_jump_solo_c130");
  wait 15;
  var_0 notify("timeout_gulag_ac130");
}

_id_B661() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("cancel_c130");
  self endon("br_jump");
  wait(getdvarint("#x3d56a64f934e7f2c6", 15));
  self._id_8CA7 = "solo";
  self notify("halo_kick_c130");
}

_id_B652() {
  level endon("game_ended");
  scripts\engine\utility::_id_10882("disconnect", "death", "cancel_c130", "infil_jump_done");

  if(!isDefined(level._id_7262._id_0E18._id_C835)) {
    return;
  }
  if(isDefined(self)) {
    level._id_7262._id_0E18._id_C835 = scripts\engine\utility::array_remove(level._id_7262._id_0E18._id_C835, self);
  } else {
    level._id_7262._id_0E18._id_C835 = scripts\engine\utility::_id_1BD1(level._id_7262._id_0E18._id_C835);
  }
}

_id_B6C6(var_0, var_1) {
  var_2 = self;
  level endon("game_ended");
  var_2 endon("disconnect");

  if(istrue(var_2._id_C6A6)) {
    return;
  }
  var_3 = var_2;
  var_4 = "token";

  if(isDefined(var_0)) {
    var_3 = var_0;
    var_4 = "token_sponsored";
    var_2 scripts\mp\playerlogic::_id_1157();
    scripts\mp\gametypes\br::_id_F997(var_2);

    if(istrue(var_1)) {
      var_5 = 6;
    } else {
      var_5 = 10;
    }

    var_2 thread _id_F631(var_5);
  }

  scripts\mp\gametypes\br_analytics::_id_2AF3(var_2, var_4);
  scripts\mp\gametypes\br_analytics::_id_2B05(self, int(isDefined(var_0)));
  var_3 scripts\mp\gametypes\br_pickups::_id_C514();
  var_2._id_C6A6 = 1;
  var_6 = istrue(var_2._id_BC03);

  if(var_6) {
    var_2 _id_0A99::_id_D5EA(76);

    while(istrue(var_2._id_BC03)) {
      waitframe();
    }
  }

  var_7 = scripts\mp\gametypes\br_public::_id_69D7() / 1000;
  var_8 = var_2 _id_B6CA(0, var_7);
  var_9 = var_2 _id_B75C(var_8);
  var_10 = 1.0;
  wait(var_10);

  if(var_6) {
    var_2 _id_0A99::_id_D5EA(0);
  }

  var_11 = 1.0;
  var_2 _id_7269();
  wait(var_11);
  var_2 scripts\mp\hud_message::_id_3983();
  var_2 scripts\mp\playerlogic::_id_E337(undefined, 0);
  var_2 _id_0790::_id_0B9E();
  var_2 scripts\mp\gametypes\br_pickups::_id_825B();
  var_2._id_C6A6 = undefined;

  if(!isDefined(var_0)) {
    var_2 thread _id_F631(4);
  }

  var_2 _id_728C(1, var_4, var_8, 1, var_9);
}

_id_726E() {
  level._id_7262._id_8B5F = _id_3FE9();
}

_id_3FE9() {
  var_0 = [];
  var_0["loadoutArchetype"] = "archetype_assault";
  var_0["loadoutPrimary"] = "s4_me_fists";
  var_0["loadoutPrimaryAttachment"] = "none";
  var_0["loadoutPrimaryAttachment2"] = "none";
  var_0["loadoutPrimaryCamo"] = "none";
  var_0["loadoutPrimaryReticle"] = "none";
  var_0["loadoutSecondary"] = "none";
  var_0["loadoutSecondaryAttachment"] = "none";
  var_0["loadoutSecondaryAttachment2"] = "none";
  var_0["loadoutSecondaryCamo"] = "none";
  var_0["loadoutSecondaryReticle"] = "none";
  var_0["loadoutMeleeSlot"] = "none";
  var_0["loadoutEquipmentPrimary"] = "equip_rock";
  var_0["loadoutEquipmentSecondary"] = "none";
  var_0["loadoutStreakType"] = "assault";
  var_0["loadoutKillstreak1"] = "none";
  var_0["loadoutKillstreak2"] = "none";
  var_0["loadoutKillstreak3"] = "none";
  var_0["loadoutSuper"] = "super_br_extract";
  var_0["loadoutPerks"] = ["specialty_null"];
  var_0["loadoutGesture"] = "playerData";
  var_0["loadoutExecution"] = "none";
  return var_0;
}

_id_B6BC(var_0, var_1) {
  if(getdvarint("#x3b27dcdf61dcbba17", 1) == 0) {
    return;
  }
  self.pers["gamemodeLoadout"] = level._id_BBAA[var_1];
  _id_3502(var_1);
  self.class = "gamemode";
  self._id_BC6C = undefined;
  var_2 = scripts\mp\class::_id_962A();
  var_2 = scripts\mp\class::_id_963A(var_2, "gamemode");
  scripts\mp\class::_id_BB99(var_2, 1, 1);
  scripts\mp\class::_id_6FB1(self.team, "gamemode", 0, 0);
  self _meth_819C(var_2._id_968A);
  self _meth_819C(var_2._id_9699);
  self._id_7279 = level._id_BBAA[var_1]["tableColumn"];
  _id_B7A2(var_0, "loadoutRow", self._id_7279);
}

_id_3502(var_0) {
  if(getdvarint("#x395344732688f8bdc", 0)) {
    switch (var_0) {
      case 0:
        var_1 = "s4_pi_mike1911";
        break;
      case 1:
        var_1 = "s4_pi_mike1911";
        break;
      case 2:
        var_1 = "s4_pi_mike1911";
        break;
      case 3:
        var_1 = "s4_pi_mike1911";
        break;
      case 4:
      default:
        var_1 = "s4_pi_mike1911";
    }

    self.pers["gamemodeLoadout"]["loadoutPrimary"] = var_1;
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment2"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment3"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment4"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment5"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondary"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment2"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment3"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment4"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment5"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPerks"] = ["specialty_null"];
  } else if(getdvarint("#x395e1d9c9a4f15da", 1)) {
    switch (var_0) {
      case 0:
        var_1 = "s4_pi_mike1911";
        break;
      case 1:
      default:
        var_1 = "s4_pi_mike1911";
    }

    self.pers["gamemodeLoadout"]["loadoutPrimary"] = var_1;
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment2"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment3"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment4"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPrimaryAttachment5"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondary"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment2"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment3"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment4"] = "none";
    self.pers["gamemodeLoadout"]["loadoutSecondaryAttachment5"] = "none";
    self.pers["gamemodeLoadout"]["loadoutPerks"] = ["specialty_null"];
  }
}

_id_6B15() {
  if(getdvarint("#x3b27dcdf61dcbba17", 1) == 0) {
    return;
  }
  var_0 = getdvarint("#x3b771c9ed1678f43e", -1);

  if(var_0 > -1 && var_0 < level._id_BBAA.size) {
    return var_0;
  }

  var_1 = randomint(level._id_BBAA.size);
  var_2 = getdvarint("#x324d836336deb9df3", 0);

  if(var_2) {
    var_3 = scripts\mp\utility\weapon::_id_6E6A(level._id_BBAA[var_1]["loadoutPrimary"] + "_mp");
    var_4 = weaponclass(var_3);

    if(var_4 != "spread" && var_3 != "iw8_sn_crossbow_mp") {
      for(var_1 = 0; var_1 < level._id_BBAA.size; var_1++) {
        var_3 = scripts\mp\utility\weapon::_id_6E6A(level._id_BBAA[var_1]["loadoutPrimary"] + "_mp");
        var_4 = weaponclass(var_3);

        if(var_4 == "spread" || var_3 == "iw8_sn_crossbow_mp") {
          return var_1;
        }
      }
    }
  }

  return var_1;
}

_id_D866(var_0) {
  var_1 = getdvarint("#x3b361edd3891971b7", 50);
  var_0._id_4D0D = spawnStruct();
  var_2 = getgroundposition(var_0._id_3385, 1);
  var_0._id_4D0D.trigger = spawn("trigger_radius", var_2, 0, int(var_1), int(level._id_2A37));
  var_3 = scripts\mp\gametypes\obj_dom::_id_D896(var_0._id_4D0D.trigger, "neutral", undefined, 1);
  var_3._id_ABCB = ::_id_1AAA;
  var_3._id_AA79 = ::_id_1AAB;
  var_3._id_AAC2 = ::_id_1AAC;
  var_3._id_ABD4 = ::_id_1AAD;
  var_3._id_AA8D = ::_id_1AA9;
  var_3._id_875C = 1;
  var_3 _id_07D6::_id_B0E7();
  var_3._id_7C8C = "domFlag";
  var_3 _id_07D6::_id_D4B2("persistent");
  var_3._id_03A9 delete();
  var_3._id_7D35 = 1;
  var_3 _id_07D6::_id_C579(1, 1, undefined, 0, 0);
  var_3._id_10416 = 1;
  var_3 _id_1AB0(0);
  var_3 _id_1AB1(var_0, 0);
  var_3._id_1A5C = var_0;
  var_0._id_4D0D._id_1AA6 = var_3;
}

_id_4D2E(var_0) {
  wait 1.0;

  if(isDefined(var_0) && isDefined(var_0._id_4D0D) && isDefined(var_0._id_4D0D._id_1AA6) && isDefined(var_0._id_4D0D._id_1AA6._id_5C3F)) {
    return;
  }
}

_id_1AB0(var_0) {
  if(var_0) {
    _id_07D6::_id_15DF("any");
    self.trigger scripts\engine\utility::_id_F5E2();
  } else {
    _id_07D6::_id_15DF("none");
    self.trigger scripts\engine\utility::_id_F5E0();
    _id_07D6::_id_C60A();
  }
}

_id_1AB1(var_0, var_1, var_2, var_3) {
  self notify("arenaFlag_setVisible");

  if(var_1) {
    var_4 = "waypoint_captureneutral";

    if(istrue(var_2)) {
      var_4 = level._id_7C76;
    }

    thread _id_1AA8(var_0);
    thread _id_07D6::_id_D61B(var_4);
    thread _id_07D6::_id_D639("neutral");
    thread scripts\mp\gametypes\obj_dom::_id_FC64("idle", 0, "none");
    self._id_5C3F show();
    thread _id_1AB4(var_0, 1);

    if(!istrue(var_2)) {
      _id_D636(var_0, 1);
      return;
    }
  } else
    thread _id_1AB2(var_0, var_2, var_3);
}

_id_1AB2(var_0, var_1, var_2) {
  self endon("arenaFlag_setVisible");

  if(!istrue(var_2)) {
    _func_016C(self._id_A908, 0);
    wait 1;
  }

  thread _id_1AB4(var_0, 0);
  thread _id_1AA7(var_2);
  thread scripts\mp\gametypes\obj_dom::_id_FC64("off", 0, "none");
  self._id_5C3F hide(1);

  if(!istrue(var_1)) {
    _id_D636(var_0, 0);
    _id_D637(var_0, 0);
  }
}

_id_1AB3(var_0, var_1) {
  var_1 endon("death_or_disconnect");

  if(var_0) {
    var_1 setclientomnvar("ui_overtime_timer_show", 1);
    _func_0185(self._id_A908, var_1);
  } else {
    _func_016E(self._id_A908, var_1);
    wait 1;
    var_1 setclientomnvar("ui_overtime_timer_show", 0);
    _func_0189(self._id_A908, var_1);
  }

  thread _id_1AB5(var_0, var_1);
}

_id_1AAE(var_0, var_1) {
  thread _id_1AB1(var_0, 1, 1);
  wait(var_1);
  thread _id_1AB1(var_0, 0, 1, 1);
}

_id_1AA8(var_0) {
  _func_018B(self._id_A908);

  foreach(var_2 in var_0._id_8B5C) {
    _func_0185(self._id_A908, var_2);
  }

  foreach(var_2 in var_0._id_1ABE) {
    _func_0185(self._id_A908, var_2);
  }

  _func_018C(self._id_A908);
}

_id_1AA7(var_0) {
  _func_017B(self._id_A908, 0);
  _func_018B(self._id_A908);
  _func_018C(self._id_A908);
}

_id_1AB4(var_0, var_1) {
  if(var_1) {
    if(var_0._id_8B5C.size > 0) {
      self._id_5C3F _meth_81B2(var_0._id_8B5C, "outline_nodepth_orange");
    }

    if(var_0._id_1ABE.size > 0) {
      self._id_5C3F _meth_81B2(var_0._id_1ABE, "outline_nodepth_orange");
    }
  } else {
    if(var_0._id_8B5C.size > 0) {
      self._id_5C3F _meth_81AF(var_0._id_8B5C);
    }

    if(var_0._id_1ABE.size > 0) {
      self._id_5C3F _meth_81AF(var_0._id_1ABE);
    }
  }
}

_id_1AB5(var_0, var_1) {
  if(var_0) {
    self._id_5C3F _meth_81B1(var_1, "outline_nodepth_orange");
  } else {
    self._id_5C3F _meth_81AE(var_1);
  }
}

_id_1AAB(var_0) {
  var_1 = getdvarint("#x39a9c5b2712821257", 3.0);
  var_0._id_87A3 = 1;
  var_2 = _id_07D6::_id_6C02();

  if(var_2 == "neutral") {
    var_0 setclientomnvar("ui_objective_state", 1);
  }

  self._id_A436 = istrue(level._id_5C41) && var_2 != "neutral";

  if(!istrue(self._id_A435)) {
    self._id_497A = 0;
  }

  var_3 = var_1;
  _id_07D6::_id_D8D2(var_3);

  if(istrue(level._id_322C)) {
    thread _id_07D6::_id_FE93(var_0.team);
  }

  if(var_3 > 0) {
    self._id_BC52 = scripts\mp\utility\game::_id_6BE2(var_0.team)[0];
    scripts\mp\gametypes\obj_dom::_id_FC63(var_0.team);
    _id_07D6::_id_D61B("waypoint_taking", "waypoint_losing");
  }
}

_id_1AAD(var_0, var_1, var_2, var_3) {
  var_4 = _id_07D6::_id_6C02();

  if(var_1 > 0.05 && var_2 && !self._id_497A) {
    self._id_497A = 1;
  }
}

_id_1AAC(var_0, var_1, var_2) {
  self._id_497A = 0;

  if(var_2) {
    _id_07F9::_id_A8C4(self._id_A908, 0);
  }

  if(isPlayer(var_1)) {
    var_1._id_87A3 = 0;
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1._id_F90E = undefined;
  }

  var_3 = _id_07D6::_id_6C02();

  if(var_3 == "neutral") {
    _id_07D6::_id_D61B("waypoint_captureneutral");
    thread scripts\mp\gametypes\obj_dom::_id_FC64("idle", 0);
  } else {
    _id_07D6::_id_D61B("waypoint_defend", "waypoint_capture");
    thread scripts\mp\gametypes\obj_dom::_id_FC64(var_3, 0);
  }

  if(!var_2) {
    self._id_A435 = 0;
  }
}

_id_1AAF(var_0, var_1) {
  _id_07D6::_id_D639(var_0);
  self notify("capture", var_1);
  self notify("assault", var_1);
  _id_07D6::_id_D61B("waypoint_defending", "waypoint_capture");
  self._id_A435 = 0;
  thread scripts\mp\gametypes\obj_dom::_id_FC64(var_0, 0, var_0);

  if(self._id_F396[var_0].size == 0 && isDefined(self._id_AA3C)) {
    self._id_F396 = self._id_AA3C;
  }

  foreach(var_3 in level._id_EF89) {
    if(isDefined(self._id_1D2E[var_3]) && var_3 != var_0) {
      self._id_1D2E[var_3] = [];
    }
  }
}

_id_1AAA(var_0) {
  var_1 = var_0.team;
  var_2 = _id_07D6::_id_6C02();
  var_3 = scripts\mp\utility\game::_id_6BE2(var_1)[0];
  self._id_3235 = gettime();
  self._id_A435 = 0;
  _id_1AAF(var_1, var_0);

  if(!self._id_A435) {
    foreach(var_5 in self._id_1A5C._id_1ABE) {
      if(isalive(var_5) && var_5.team != var_1) {
        var_5 thread _id_727D(self._id_1A5C);
      }
    }

    thread _id_743F(self._id_1A5C);
    self._id_5BC6 = 0;
  }
}

_id_1AA9() {
  _id_07D6::_id_D61B("waypoint_contested");
  _id_07F9::_id_A8B6(self._id_A908, undefined);
  thread scripts\mp\gametypes\obj_dom::_id_FC64("contested", 0);
}

_id_68CD(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = "";

  switch (var_0) {
    case "playerArena0":
      [var_2, var_3, var_4] = [0, 8, "ui_br_gulag_players_1"];
      var_1 = var_1 + 1;
      break;
    case "playerArena1":
      [var_2, var_3, var_4] = [8, 8, "ui_br_gulag_players_1"];
      var_1 = var_1 + 1;
      break;
    case "playerJail0":
      [var_2, var_3, var_4] = [16, 8, "ui_br_gulag_players_1"];
      var_1 = var_1 + 1;
      break;
    case "playerJail1":
      [var_2, var_3, var_4] = [24, 8, "ui_br_gulag_players_1"];
      var_1 = var_1 + 1;
      break;
    case "loadoutRow":
      [var_2, var_3, var_4] = [0, 8, "ui_br_gulag_data"];
      var_1 = var_1 + 1;
      break;
    case "playerHealth0":
      [var_2, var_3, var_4] = [8, 8, "ui_br_gulag_data"];
      break;
    case "playerHealth1":
      [var_2, var_3, var_4] = [16, 8, "ui_br_gulag_data"];
      break;
    default:
      break;
  }

  return [var_2, var_3, var_4, var_1];
}

_id_ADC8(var_0, var_1, var_2, var_3, var_4) {
  var_5 = int(_func_01A6(2, var_4)) - 1;
  var_6 = (var_2 &var_5) << var_3;
  var_7 = ~(var_5 << var_3);
  var_8 = var_0._id_AA3F[var_1];
  var_9 = var_8 &var_7;
  var_10 = var_9 + var_6;
  var_0._id_AA3F[var_1] = var_10;
}

_id_D47C(var_0, var_1, var_2) {
  [var_4, var_5, var_6, var_2] = _id_68CD(var_1, var_2);

  if(var_6 == "") {
    return;
  }
  _id_ADC8(var_0, var_6, var_2, var_4, var_5);
}

_id_D47E(var_0, var_1, var_2) {
  var_3 = -1;

  if(isDefined(var_2)) {
    var_3 = var_2 getentitynumber();
  }

  _id_D47C(var_0, var_1, var_3);
}

_id_D47D(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_2)) {
    var_3 = var_2.health;
  }

  _id_D47C(var_0, var_1, var_3);
}

_id_FC05(var_0) {
  var_0._id_AA3F["ui_br_gulag_players_1"] = 0;

  for(var_1 = 0; var_1 < level._id_7262._id_9C93; var_1++) {
    var_2 = var_0._id_1ABE[var_1];
    _id_D47E(var_0, "playerArena" + var_1, var_2);
  }

  var_3 = var_0._id_9BC4[0];

  if(!isDefined(var_3)) {
    var_3 = [];
  }

  _id_D47E(var_0, "playerJail0", var_3[0]);
  _id_D47E(var_0, "playerJail1", var_3[1]);
  var_4 = scripts\engine\utility::array_combine(var_0._id_8B5C, var_0._id_1ABE);

  foreach(var_2 in var_4) {
    var_2 setclientomnvar("ui_br_gulag_players_1", var_0._id_AA3F["ui_br_gulag_players_1"]);

    foreach(var_11, var_7 in var_0._id_9BC4) {
      if(isDefined(var_7[0]) && var_2 == var_7[0] || isDefined(var_7[1]) && var_2 == var_7[1]) {
        var_8 = !_id_8995(var_0, var_2);
        var_9 = var_11 + 1;
        var_10 = var_8 + (var_9 << 1);
        var_2 setclientomnvar("ui_br_gulag_queue_position", var_10);
        break;
      }
    }
  }
}

_id_B7A0(var_0) {
  self setclientomnvar("ui_br_gulag_data", var_0._id_AA3F["ui_br_gulag_data"]);
}

_id_FC04(var_0) {
  _id_C601(var_0);

  for(var_1 = 0; var_1 < level._id_7262._id_9C93; var_1++) {
    var_2 = var_0._id_1ABE[var_1];
    _id_D47D(var_0, "playerHealth" + var_1, var_2);
  }

  foreach(var_2 in var_0._id_8B5C) {
    var_2 _id_B7A0(var_0);
  }

  foreach(var_2 in var_0._id_1ABE) {
    var_2 _id_B79D(var_0);
  }
}

_id_C601(var_0) {
  var_0._id_AA3F["ui_br_gulag_data"] = 0;
}

_id_B79D(var_0) {
  if(!isDefined(self._id_7279)) {
    self setclientomnvar("ui_br_gulag_data", var_0._id_AA3F["ui_br_gulag_data"]);
  } else {
    _id_B7A2(var_0, "loadoutRow", self._id_7279);
  }
}

_id_B7A2(var_0, var_1, var_2) {
  [var_4, var_5, var_6, var_2] = _id_68CD(var_1, var_2);

  if(var_6 == "") {
    return;
  }
  _id_B737(var_0, var_6, var_2, var_4, var_5);
}

_id_B737(var_0, var_1, var_2, var_3, var_4) {
  var_5 = int(_func_01A6(2, var_4)) - 1;
  var_6 = (var_2 &var_5) << var_3;
  var_7 = ~(var_5 << var_3);
  var_8 = var_0._id_AA3F[var_1];
  var_9 = var_8 &var_7;
  var_10 = var_9 + var_6;
  self setclientomnvar(var_1, var_10);
}

_id_FCFD(var_0) {
  _id_FC05(var_0);
  _id_FC04(var_0);
}

_id_B67A(var_0) {
  var_1 = getarraykeys(var_0._id_AA3F);

  foreach(var_3 in var_1) {
    self setclientomnvar(var_3, 0);
  }
}

_id_D637(var_0, var_1) {
  foreach(var_3 in var_0._id_1ABE) {
    var_3 setclientomnvar("ui_overtime_timer", var_1);
  }

  foreach(var_3 in var_0._id_8B5C) {
    var_3 setclientomnvar("ui_overtime_timer", var_1);
  }
}

_id_D636(var_0, var_1) {
  foreach(var_3 in var_0._id_1ABE) {
    var_3 setclientomnvar("ui_overtime_timer_show", var_1);
  }

  foreach(var_3 in var_0._id_8B5C) {
    var_3 setclientomnvar("ui_overtime_timer_show", var_1);
  }
}

_id_B6D3(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gulag_end");
  var_1 = "playerHealth0";

  if(var_0._id_1ABE[0] != self) {
    var_1 = "playerHealth1";
  }

  for(;;) {
    _id_FC04(var_0);

    if(self.health <= 0) {
      return;
    }
    scripts\engine\utility::_id_10885("damage", "force_regeneration", "removeAdrenaline", "healed", "healhRegenThink", "vampirism", "spawned_player");
  }
}

_id_B75A() {
  if(level._id_7262._id_84D2 && !isbot(self)) {
    self _meth_8768("mp_donetsk_gulag_intro");
  }
}

_id_B743() {
  var_0 = undefined;

  if(scripts\mp\utility\player::_id_8855()) {
    var_0 = "br_gulag_intro_vo_plr_female";
  } else {
    var_0 = "br_gulag_intro_vo_plr_male";
  }

  if(level._id_7262._id_84D2 && !isbot(self)) {
    if(isDefined(var_0)) {
      self playlocalsound(var_0);
    }

    self setclientomnvar("ui_br_bink_overlay_state", 1);
    self setplayermusicstate("br_gulag_intro");

    if(scripts\mp\gametypes\br_public::_id_878D()) {
      self _meth_867F("iw8_br_gulag_tutorial", 0.5);
    } else {
      self _meth_867F("fade_to_black_all_except_music_and_scripted5", 0.5);
    }

    self _meth_8766("mp_donetsk_gulag_intro");
    self._id_B863 = 1;
  } else
    _id_7277();
}

_id_B7B4() {
  self setclientomnvar("ui_br_bink_overlay_state", 2);
}

_id_B815(var_0) {
  if(level._id_7262._id_84D2 && !isbot(self) && !self _meth_878F()) {
    self freezecontrols(1);
    _id_0C94(var_0);
    self freezecontrols(0);
    self setclientomnvar("ui_br_bink_overlay_state", 5);
    self _meth_8769();
    self._id_B863 = undefined;
    self _meth_83EF("br_gulag_intro_vo_plr_female");
    self _meth_83EF("br_gulag_intro_vo_plr_male");
  }
}

_id_0C94(var_0) {
  var_1 = 17000;
  self endon("bink_complete");

  while(gettime() - var_0 < var_1 && !self _meth_848D() && !self useButtonPressed() && !self jumpbuttonPressed()) {
    waitframe();
  }
}

_id_B674(var_0, var_1) {
  if(var_0 == "bink_complete") {
    self notify("bink_complete");
  }
}

_id_B6E5() {
  var_0 = self _meth_876E("ui_br_bink_overlay_state");

  if(var_0 != 0 && var_0 != 6) {
    return 1;
  }

  return 0;
}

_id_B6E4() {
  var_0 = self _meth_876E("ui_br_bink_overlay_state");
  return var_0 == 7;
}

_id_B675() {
  self setclientomnvar("ui_br_bink_overlay_state", 7);
}

_id_B676() {
  self endon("disconnect");

  if(_id_B6E5()) {
    self setclientomnvar("ui_br_bink_overlay_state", 6);
    wait 1;
    self setclientomnvar("ui_br_bink_overlay_state", 0);
  }
}

_id_D856(var_0, var_1) {
  if(!level._id_7262._id_FE30) {
    return;
  }
  var_2 = getEntArray(var_1.target, "targetname");

  if(var_2.size > 1) {
    level._id_7262._id_FE30 = 0;
  } else {
    var_1._id_4DBA = getent(var_1.target, "targetname");

    if(isDefined(var_1._id_4DBA)) {
      var_1._id_4DBA._id_39D3 = 1;
      var_3 = getent(var_1._id_4DBA.target, "targetname");
      var_3 delete();
      var_4 = anglesToForward(var_1._id_4DBA.angles);
      var_1._id_4DBA._id_39DC = var_1._id_4DBA.origin;
      var_1._id_4DBA._id_AC32 = var_1._id_4DBA.origin + var_4 * 60;
    }
  }
}

_id_FE30(var_0) {
  return level._id_7262._id_FE30 && var_0._id_3384.size > 0;
}

_id_C633() {
  var_0 = self;
  var_0._id_59BC = 0;
  var_0 scripts\mp\weapons::_id_FCCC();
}