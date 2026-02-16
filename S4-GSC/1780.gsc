/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1780.gsc
*************************************************/

_id_1D22(var_0) {
  if(getdvarint("#x33a10d5bc01199efc", 1)) {
    if(!isDefined(var_0._id_B022) || var_0._id_B022.size < 1) {
      var_0._id_B022 = [];
      var_0 scripts\engine\utility::_id_5473("personal_ents_updating");

      for(var_1 = 0; var_1 < 20; var_1++) {
        var_2 = spawn("script_model", (0, 0, -5000));
        var_2._id_A9DB = (0, 0, -5000);
        var_2 setModel("tag_origin");
        var_2._id_37F0 = 0;
        var_2._id_FE3A = 0;
        _id_11A5(var_0, var_2);
        var_0._id_B022[var_0._id_B022.size] = var_2;
      }
    }

    _id_4AFB(var_0);
    level thread _id_4781(var_0);
    level thread _id_4782(var_0);
  }
}

_id_4782(var_0) {
  var_0 notify("deletePEntsOnRespawn");
  var_0 endon("deletePEntsOnRespawn");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_0 waittill("respawn_player", var_1);

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0._id_B022)) {
    return;
  }
  for(var_2 = 0; var_2 < var_0._id_B022.size; var_2++) {
    if(isDefined(var_0._id_B022[var_2])) {
      var_0._id_B022[var_2] delete();
    }
  }

  var_0._id_B022 = [];
}

_id_4781(var_0) {
  level endon("game_ended");
  var_0 notify("deletePEntsOnDisconnect");
  var_0 endon("deletePEntsOnDisconnect");
  var_0 waittill("disconnect");

  if(!isDefined(var_0._id_B022)) {
    return;
  }
  for(var_1 = 0; var_1 < var_0._id_B022.size; var_1++) {
    if(isDefined(var_0._id_B022[var_1])) {
      var_0._id_B022[var_1] delete();
    }
  }
}

_id_C297(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = spawnStruct();
  var_11.type = var_1;
  var_11._id_7C3B = var_2;
  var_11._id_0224 = var_3;
  var_11._id_BD27 = var_4;
  var_11._id_5090 = var_5;
  var_11._id_AB45 = var_6;
  var_11._id_7985 = var_7;
  var_11._id_798B = var_8;
  var_11._id_FE4C = var_9;
  var_11._id_FE72 = var_10;
  var_11._id_7965 = level._id_8393[var_0]._id_7965;
  var_11._id_0F07 = level._id_8393[var_0]._id_0F07;
  level._id_AF89[var_0] = var_11;
  level._id_8393[var_0]._id_7965 = undefined;
  level._id_8393[var_0]._id_0F07 = undefined;
}

_id_AF8A(var_0) {
  return isDefined(level._id_AF89[var_0]);
}

_id_6C24(var_0) {
  return level._id_AF89[var_0];
}

_id_402B(var_0, var_1, var_2) {
  var_3 = scripts\cp\utility::_id_3FF0(var_1.origin, var_0.type, var_0._id_7C3B, var_0._id_0224, var_0._id_BD27, var_0._id_5090, var_0._id_AB45, var_0._id_7985, var_0._id_798B, var_0._id_FE4C, var_0._id_FE72);
  return var_3;
}

_id_1167(var_0) {
  var_0 notify("addToPersonalInteractionList");

  if(!scripts\engine\utility::array_contains(level._id_418C, var_0)) {
    level._id_418C = scripts\engine\utility::array_add(level._id_418C, var_0);

    if(scripts\engine\utility::_id_5C0C("personal_ent_zones_initialized") && scripts\engine\utility::_id_5C00("personal_ent_zones_initialized")) {
      if(isDefined(level._id_B01B) && level._id_B01B.size > 0) {
        foreach(var_2 in level._id_B01B) {
          if(!isDefined(var_2._id_1D80)) {
            continue;
          }
          if(!isDefined(var_0._id_ADC3)) {
            continue;
          }
          if(_func_011A(var_0.origin, var_2)) {
            var_2._id_1D80[var_2._id_1D80.size] = var_0;
            var_0._id_ADC3[var_0._id_ADC3.size] = var_2;
            var_2._id_1D80 = scripts\engine\utility::_id_1BC1(var_2._id_1D80);
          }
        }
      }
    }
  }

  _id_FBC9(1);
}

_id_C4B1(var_0) {
  var_0 notify("removeFromPersonalInteractionList");

  if(scripts\engine\utility::array_contains(level._id_418C, var_0)) {
    level._id_418C = scripts\engine\utility::array_remove(level._id_418C, var_0);

    if(scripts\engine\utility::_id_5C0C("personal_ent_zones_initialized") && scripts\engine\utility::_id_5C00("personal_ent_zones_initialized")) {
      if(isDefined(var_0._id_ADC3)) {
        foreach(var_2 in var_0._id_ADC3) {
          var_2._id_1D80 = scripts\engine\utility::array_remove(var_2._id_1D80, var_0);
          var_2._id_1D80 = scripts\engine\utility::_id_1BC1(var_2._id_1D80);
        }
      }
    }
  }

  _id_FBC9(1);
}

_id_46B6(var_0) {
  wait 0.25;
  _id_C4B1(var_0);
  _id_0737::_id_C3C5(var_0);
}

_id_A245(var_0) {
  var_0 endon("disconnect");
  var_0 notify("movePEntsToStructs");
  var_0 endon("movePEntsToStructs");

  if(!scripts\engine\utility::_id_5C00("init_interaction_done")) {
    scripts\engine\utility::_id_5C24("init_interaction_done");
  }

  for(;;) {
    if(var_0 scripts\engine\utility::_id_5472("personal_ents_updating")) {
      var_0 scripts\engine\utility::_id_5474("personal_ents_updating");
    }

    var_6 = 0;
    var_7 = 0;

    if(isDefined(var_0._id_1466)) {
      var_8 = var_0._id_1466;
    } else {
      var_8 = scripts\engine\utility::_id_6369(var_0.origin, level._id_418C, undefined, 100);
    }

    if(var_8.size > 0) {
      var_8 = _id_C4D6(var_8, var_0);
      var_0 _id_C610(var_0, var_8);

      foreach(var_10 in var_8) {
        var_11 = undefined;

        if(isDefined(var_10.target)) {
          var_11 = scripts\engine\utility::getstruct(var_10.target, "targetname");
        }

        if(var_10 _id_759A(var_0, var_10)) {
          var_12 = _id_68DD(var_0, var_10);

          if(isDefined(var_12)) {
            if(isDefined(var_10._id_AF88) && var_10._id_AF88 != var_12.model) {
              var_12 setModel(var_10._id_AF88);
            }

            if(istrue(var_0._id_5E61)) {
              if(_id_EA76(var_10)) {
                var_12 thread _id_AF86(0, var_10, var_12, var_0, var_11);
              }
            }
          }

          continue;
        }

        var_12 = _id_6E1E(var_0, var_8);

        if(isDefined(var_12)) {
          if(_id_B3D4(var_10, var_0)) {
            continue;
          }
          var_10._id_1FC1 = 1;
          var_12 dontinterpolate();

          if(isDefined(var_11)) {
            var_12.origin = var_11.origin;

            if(isDefined(var_11.angles)) {
              var_12.angles = var_11.angles;
            } else {
              var_12.angles = (0, 0, 0);
            }
          } else {
            var_12.origin = var_10.origin;

            if(isDefined(var_10.angles)) {
              var_12.angles = var_10.angles;
            } else {
              var_12.angles = (0, 0, 0);
            }
          }

          if(isDefined(var_10._id_AF88)) {
            thread _id_AF87(var_0, var_12, var_10);
          } else {}

          if(_id_EA76(var_10)) {
            var_12 thread _id_AF86(0, var_10, var_12, var_0, var_11);
          }
        }
      }
    }

    var_0._id_5E61 = undefined;
    wait 0.25;

    if(var_0 scripts\engine\utility::_id_5472("personal_ents_updating")) {
      var_0 scripts\engine\utility::_id_5470("personal_ents_updating");
    }

    var_0 notify("pEntsUpdated");
    var_0 scripts\engine\utility::_id_10893(["zone_change", "updatePEnts"]);
  }
}

_id_B3D4(var_0, var_1) {
  if(istrue(var_0._id_ADC1)) {
    return 0;
  } else if(isDefined(level._id_AF8B) && istrue(level._id_AF8B[var_0._id_039B])) {
    return 0;
  } else {
    var_2 = scripts\engine\utility::_id_10E76(var_1 getEye(), var_1 getplayerangles(), var_0.origin, cos(65));

    if(var_2) {
      var_3 = scripts\engine\trace::ray_trace_passed(var_1 getEye(), var_0.origin, scripts\engine\utility::array_combine(level.players, var_1._id_B022));

      if(var_3) {
        return 1;
        return;
      }

      return 0;
      return;
    } else
      return 0;
  }
}

_id_EA76(var_0) {
  if(isDefined(var_0._id_039B)) {
    var_1 = var_0._id_039B;
  } else {
    return 0;
  }

  if(istrue(var_0._id_AF85)) {
    return 1;
  } else if(isDefined(level._id_A5C0[var_1])) {
    return 1;
  } else if(isDefined(level._id_E3C4[var_1])) {
    return 1;
  } else if(_id_AF8A(var_0._id_039B)) {
    return 1;
  } else {
    return 0;
  }
}

_id_AF87(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 endon("p_ent_reset");
  var_1._id_37F0 = 1;
  var_1._id_AE5E = var_2;

  if(!isDefined(var_2._id_9508)) {
    var_2._id_9508 = [];
  }

  var_2._id_9508[var_2._id_9508.size] = var_1;
  var_1._id_FE3A = 1;

  if(_id_B3D4(var_2, var_0)) {
    var_1 _id_C62A(var_1, var_0);
    return;
  }

  wait 0.1;
  var_1 setModel(var_2._id_AF88);

  if(isDefined(var_2._id_57A5)) {
    var_1 setscriptablepartstate(var_2._id_57A5[0], var_2._id_57A5[1], 1);
  }

  var_2._id_1FC1 = undefined;
}

_id_FBCA(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 notify("update_special_mode_for_player");
  var_0 endon("update_special_mode_for_player");

  if(istrue(var_1)) {}

  if(var_0 scripts\engine\utility::_id_5472("personal_ents_updating") && var_0 scripts\engine\utility::_id_546E("personal_ents_updating")) {
    var_0 scripts\engine\utility::_id_547B("personal_ents_updating");
  }

  var_0 notify("updatePEnts");
}

_id_FBC9(var_0) {
  level endon("game_ended");

  foreach(var_2 in level.players) {
    thread _id_FBCA(var_2, var_0);
  }
}

_id_C610(var_0, var_1) {
  var_2 = [];
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in var_0._id_B022) {
    if(!isent(var_6)) {
      continue;
    }
    var_7 = 0;

    foreach(var_4 in var_1) {
      if(isDefined(var_4._id_B72A) && isDefined(var_4._id_B72A[var_0.name])) {
        if(var_6.origin == var_4._id_B72A[var_0.name]) {
          var_3 = var_4._id_039B;
          var_7 = 1;
          break;
        }
      }

      if(isDefined(var_4.target)) {
        var_9 = scripts\engine\utility::getstruct(var_4.target, "targetname");

        if(isDefined(var_9) && var_6.origin == var_9.origin) {
          var_3 = var_4._id_039B;
          var_7 = 1;
          break;
        } else if(var_6.origin == var_4.origin) {
          var_3 = var_4._id_039B;
          var_7 = 1;
          break;
        }

        continue;
      }

      if(var_6.origin == var_4.origin) {
        var_3 = var_4._id_039B;
        var_7 = 1;
        break;
      }
    }

    if(!var_7) {
      if(isDefined(var_4) && _id_B3D4(var_4, var_0)) {
        continue;
      }
      var_6 _id_C62A(var_6, var_0);
    }
  }

  wait 0.1;
}

_id_C4D6(var_0, var_1) {
  var_2 = [];
  var_0 = _func_0204(var_0, var_1.origin);

  foreach(var_4 in var_0) {
    if(isDefined(var_1._id_4A8B) && scripts\engine\utility::array_contains(var_1._id_4A8B, var_4)) {
      continue;
    }
    if(isDefined(var_4._id_7D67)) {
      if(!istrue(var_4._id_7D67)) {
        continue;
      }
    } else if(isDefined(level._id_417B) && !scripts\engine\utility::array_contains(level._id_417B, var_4)) {
      continue;
    }
    if(isDefined(var_4.target)) {
      var_5 = scripts\engine\utility::getStructArray(var_4._id_0481, "targetname");

      foreach(var_7 in var_5) {
        if(isDefined(var_7.target) && var_7.target == var_4.target) {
          var_0 = scripts\engine\utility::array_remove(var_0, var_7);
        }
      }

      var_2[var_2.size] = var_4;

      if(var_2.size >= 20) {
        break;
      }

      continue;
    }

    var_2[var_2.size] = var_4;

    if(var_2.size >= 20) {
      break;
    }
  }

  return var_2;
}

_id_759A(var_0, var_1) {
  foreach(var_3 in var_0._id_B022) {
    if(isDefined(var_1._id_B72A) && isDefined(var_1._id_B72A[var_0.name])) {
      if(var_3.origin == var_1._id_B72A[var_0.name]) {
        var_3._id_FE3A = 1;
        return 1;
      }
    }

    if(isDefined(var_1.target)) {
      var_4 = scripts\engine\utility::getstruct(var_1.target, "targetname");

      if(isDefined(var_4) && var_3.origin == var_4.origin) {
        var_3._id_FE3A = 1;
        return 1;
      }
    }

    if(var_3.origin == var_1.origin) {
      var_3._id_FE3A = 1;
      return 1;
    }
  }

  return 0;
}

_id_11A5(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 == var_0) {
      var_1 showtoplayer(var_3);
      continue;
    }

    var_1 hidefromplayer(var_3);
  }
}

_id_C62A(var_0, var_1) {
  var_0 setModel("tag_origin");
  var_0._id_37F0 = 0;
  var_0._id_FE3A = 0;
  var_0 dontinterpolate();
  var_0.origin = var_0._id_A9DB;

  if(isDefined(var_0._id_AE5E)) {
    if(isDefined(var_0._id_AE5E._id_9508)) {
      if(scripts\engine\utility::array_contains(var_0._id_AE5E._id_9508, var_0)) {
        var_0._id_AE5E._id_9508 = scripts\engine\utility::array_remove(var_0._id_AE5E._id_9508, var_0);
      }
    }

    var_0._id_AE5E notify("p_ents_updated");
    var_0._id_AE5E = undefined;
  }

  var_0 notify("p_ent_reset");
}

_id_68DD(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0._id_B022) {
    if(isDefined(var_1._id_B72A) && isDefined(var_1._id_B72A[var_0.name])) {
      if(var_4.origin == var_1._id_B72A[var_0.name]) {
        return var_4;
      }
    }

    if(isDefined(var_1.target)) {
      var_5 = scripts\engine\utility::getstruct(var_1.target, "targetname");

      if(isDefined(var_5) && var_4.origin == var_5.origin) {
        return var_4;
      }
    }

    if(var_4.origin == var_1.origin) {
      return var_4;
    }
  }

  return undefined;
}

_id_6E1E(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0._id_B022) {
    var_5 = 0;

    foreach(var_7 in var_1) {
      if(isDefined(var_7._id_B72A) && isDefined(var_7._id_B72A[var_0.name])) {
        if(var_4.origin == var_7._id_B72A[var_0.name]) {
          var_5 = 1;
          break;
        }
      }

      if(isDefined(var_7.target)) {
        var_8 = scripts\engine\utility::getstruct(var_7.target, "targetname");

        if(isDefined(var_8) && var_4.origin == var_8.origin) {
          var_5 = 1;
          break;
        }
      }

      if(var_4.origin == var_7.origin) {
        var_5 = 1;
        break;
      }
    }

    if(!var_5) {
      return var_4;
    }
  }

  return undefined;
}

_id_10B43(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  scripts\engine\utility::_id_5C24("init_interaction_done");
  var_1 = getent("zone_change", "targetname");

  if(isDefined(var_1)) {
    for(;;) {
      if(var_0 istouching(var_1)) {
        var_0 notify("rave_status_changed");
        wait 1;
        continue;
      } else
        wait 0.1;
    }
  }
}

_id_AF86(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::ter_op(isDefined(var_1.name), var_1.name, var_1._id_039B);

  if(isDefined(level._id_A5C0[var_5])) {
    if(isDefined(var_4)) {
      var_2[[level._id_A5C0[var_5]]](var_2, var_4, 0, var_3);
    } else {
      var_2 thread[[level._id_A5C0[var_5]]](var_2, var_1, 0, var_3);
    }
  }

  if(_id_AF8A(var_1._id_039B)) {
    var_6 = _id_402B(_id_6C24(var_1._id_039B), var_1, undefined);
    var_2._id_7994 = var_6;

    foreach(var_8 in level.players) {
      if(var_8 == var_3) {
        var_6 _meth_80E0(var_3);
        continue;
      }

      var_6 disableplayeruse(var_8);
    }

    thread _id_10A5A(var_2, var_1, var_3, var_6);
    thread _id_C5EB(var_2, var_1, var_3, var_6);
    thread _id_10A44(var_2, var_1, var_3, var_6);
  }
}

_id_C5EB(var_0, var_1, var_2, var_3) {
  var_0 notify("reset_struct_when_pent_moves");
  var_0 endon("reset_struct_when_pent_moves");
  var_1 notify("reset_struct_when_pent_moves_" + var_2.name);
  var_1 endon("reset_struct_when_pent_moves_" + var_2.name);
  level endon("game_ended");
  scripts\engine\utility::_id_10888(var_0, "p_ent_reset", var_1, "remove_from_current_interaction_list", var_2, "remove_from_current_interaction_list_for_player_" + var_2.name);

  if(isDefined(var_3) && var_3 != var_0) {
    var_3 delete();
  } else if(isDefined(var_3)) {
    var_3 scripts\cp\utility::_id_3944(var_3);
  }

  if(isDefined(var_0._id_7994)) {
    var_0._id_7994 = undefined;
  }

  if(isDefined(var_0._id_3A5F)) {
    var_0._id_3A5F delete();
  }

  if(isDefined(var_1._id_3A5F)) {
    var_1._id_3A5F delete();
  }

  _id_0737::_id_1038(var_1, var_2);
  _id_FBC9(1);
}

_id_4AFB(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }
    if(isDefined(var_2._id_B022)) {
      for(var_3 = 0; var_3 < var_2._id_B022.size; var_3++) {
        if(isDefined(var_2._id_B022[var_3])) {
          var_2._id_B022[var_3] disableplayeruse(var_0);

          if(isDefined(var_2._id_B022[var_3]._id_7994)) {
            var_2._id_B022[var_3]._id_7994 disableplayeruse(var_0);
          }
        }
      }
    }
  }
}

_id_10A5A(var_0, var_1, var_2, var_3) {
  var_1 notify("watch_for_player_trigger_" + var_2.name);
  var_1 endon("watch_for_player_trigger_" + var_2.name);
  var_0 notify("watch_for_player_trigger");
  var_0 endon("watch_for_player_trigger");
  var_0 endon("p_ent_reset");
  var_4 = _id_6C23(var_1);
  var_0._id_7994 = var_3;

  if(isDefined(var_4)) {
    for(;;) {
      var_3 makeuseable();

      foreach(var_6 in level.players) {
        if(var_6 == var_2) {
          var_3 _meth_80E0(var_2);
          continue;
        }

        var_3 disableplayeruse(var_6);
      }

      var_3 waittill("trigger", var_8);

      if(isPlayer(var_8)) {
        level thread[[var_4]](var_1, var_2);
      }
    }
  }
}

_id_6C23(var_0) {
  if(isDefined(level._id_AF89[var_0._id_039B]._id_0F07)) {
    return level._id_AF89[var_0._id_039B]._id_0F07;
  } else if(isDefined(level._id_8393[var_0._id_039B]._id_0F07)) {
    return level._id_8393[var_0._id_039B]._id_0F07;
  } else {
    return undefined;
  }
}

_id_FBA2(var_0, var_1) {
  var_0._id_0224 = var_1;
  var_0 notify("pent_update_hint", var_1);
}

_id_10A44(var_0, var_1, var_2, var_3) {
  var_1 endon("watch_for_player_trigger_" + var_2.name);
  var_0 endon("watch_for_player_trigger");
  var_0 endon("p_ent_reset");

  for(;;) {
    var_1 waittill("pent_update_hint", var_4);

    if(!_id_759A(var_2, var_1)) {
      return;
    }
    var_3 sethintstring(var_4);
  }
}

_id_B5B3(var_0) {
  if(isDefined(level._id_B01B)) {
    thread _id_FBA3(var_0);
  } else {
    thread _id_FBA4(var_0);
  }
}

_id_FBA3(var_0) {
  level endon("game_ended");
  var_0 notify("update_pents_from_volumes");
  var_0 endon("update_pents_from_volumes");
  var_0 endon("disconnect");

  if(!scripts\engine\utility::_id_5C0C("personal_ent_zones_initialized")) {
    return;
  } else {
    scripts\engine\utility::_id_5C24("personal_ent_zones_initialized");
  }

  for(;;) {
    var_0._id_1466 = [];

    foreach(var_2 in level._id_B01B) {
      if(_func_011A(var_0.origin, var_2)) {
        var_0._id_1466 = scripts\engine\utility::array_combine(var_0._id_1466, var_2._id_1D80);
      }
    }

    wait 1;
    _id_FBCA(var_0);
  }
}

_id_FBA4(var_0) {
  level endon("game_ended");
  var_0 notify("update_pents_from_volumes");
  var_0 endon("update_pents_from_volumes");
  var_0 endon("disconnect");

  if(!scripts\engine\utility::_id_5C0C("personal_ent_zones_initialized")) {
    return;
  } else {
    scripts\engine\utility::_id_5C24("personal_ent_zones_initialized");
  }

  for(;;) {
    wait 1;
    _id_FBCA(var_0);
  }
}

_id_804C() {
  var_0 = level._id_418C;
  var_1 = getEntArray("p_ent_zone", "targetname");

  foreach(var_3 in var_1) {
    var_3._id_1D80 = [];

    foreach(var_5 in var_0) {
      if(!isDefined(var_5._id_ADC3)) {
        var_5._id_ADC3 = [];
      }

      if(_func_011A(var_5.origin, var_3)) {
        var_3._id_1D80[var_3._id_1D80.size] = var_5;
        var_5._id_ADC3[var_5._id_ADC3.size] = var_3;
      }
    }
  }

  if(var_1.size > 0) {
    level._id_B01B = var_1;
  }

  scripts\engine\utility::_id_5C1B("personal_ent_zones_initialized");
}