/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\888.gsc
**************************************/

_id_8D89() {
  level._id_071D = spawnStruct();
  level._id_11CB = spawnStruct();
  _id_8D88();
  _id_8D75();

  if(getdvarint("2803", 0) > 0) {
    thread _id_A8E4();
  }

  if(isDefined(level._id_8D62)) {
    self[[level._id_8D62]]();
  } else {
    _id_048E::_id_8D80();
  }
}

_id_A8E4() {
  self endon("game_ended");
  setdvarifuninitialized("e3_trailer_submix", 0);
  setdvarifuninitialized("e3_mix_mode_activate", 0);

  for(;;) {
    if(getdvarint("e3_mix_mode_activate", 0) == 1) {
      setDvar("e3_mix_mode_activate", 0);

      if(getdvarint("e3_trailer_submix", 0) == 0) {
        foreach(var_1 in level.players) {
          var_1 clientclearallsubmixes(0.5);
          waitframe();
          var_1 clientaddsoundsubmix("mp_init_mix");
        }
      } else if(getdvarint("e3_trailer_submix", 0) == 1) {
        foreach(var_1 in level.players) {
          var_1 clientclearallsubmixes(0.5);
          waitframe();
          var_1 clientaddsoundsubmix("mp_init_mix");
          waitframe();
          var_1 clientaddsoundsubmix("mp_e3_trailer_mix_no_vox");
        }
      } else if(getdvarint("e3_trailer_submix", 0) == 2) {
        foreach(var_1 in level.players) {
          var_1 clientclearallsubmixes(0.5);
          waitframe();
          var_1 clientaddsoundsubmix("mp_init_mix");
          waitframe();
          var_1 clientaddsoundsubmix("mp_e3_trailer_mix_vox");
        }
      }
    }

    waitframe();
  }
}

_id_8D88() {
  var_0 = "OmnvarChanged";
  var_0 = "ClientScriptInit";
  var_0 = "OmnvarChanged";
  var_0 = "FxNotify";
  var_0 = "FxBounceNotify";
  var_0 = "FxSparkNotify";
  var_0 = "NotetrackNotify";
  var_0 = "PlaySoundAttached";
  var_0 = "UpdateSoundAttached";
}

_id_8D8A() {
  self._id_071D = spawnStruct();
  self._id_11CB = spawnStruct();
  _id_8D74("player_connect");
}

_id_8D75() {
  if(!isDefined(level._id_071D)) {
    level._id_071D = spawnStruct();
  }

  if(!isDefined(level._id_071D._id_611B)) {
    level._id_071D._id_611B = [];
  }
}

_id_8DC7(var_0, var_1) {
  _id_8D14(isDefined(level._id_071D), "Need to call snd_message_init( ) before calling this function.");
  _id_8D14(_isarray(level._id_071D._id_611B));
  level._id_071D._id_611B[var_0] = var_1;
}

_id_8D84(var_0, var_1, var_2) {
  level notify("stop_other_music");
  level endon("stop_other_music");

  if(isDefined(var_2)) {
    childthread _id_8D74("snd_music_handler", var_0, var_1, var_2);
  } else if(isDefined(var_1)) {
    childthread _id_8D74("snd_music_handler", var_0, var_1);
  } else {
    childthread _id_8D74("snd_music_handler", var_0);
  }
}

_id_8D74(var_0, var_1, var_2, var_3) {
  _id_8D14(isDefined(level._id_071D), "Need to call snd_message_init( ) before calling this function.");
  _id_8D14(_isarray(level._id_071D._id_611B));

  if(isDefined(level._id_071D._id_611B[var_0])) {
    if(isDefined(var_3)) {
      thread[[level._id_071D._id_611B[var_0]]](var_1, var_2, var_3);
    } else if(isDefined(var_2)) {
      thread[[level._id_071D._id_611B[var_0]]](var_1, var_2);
    } else if(isDefined(var_1)) {
      thread[[level._id_071D._id_611B[var_0]]](var_1);
    } else {
      thread[[level._id_071D._id_611B[var_0]]]();
    }
  }
}

snd_zmb_set_sound_alias_parameter_modifier(var_0, var_1) {
  self _meth_85A7("snd_zmb_set_sound_alias_parameter_modifier", var_0, var_1);
}

_id_9266() {
  self _meth_85A7("snd_start_player_vox");
}

_id_93E2() {
  self _meth_85A7("snd_stop_player_vox");
}

_id_8DDD(var_0, var_1) {
  self _meth_85A7("snd_set_plr_speed_smoothing", var_0, var_1);
}

_id_8DDB(var_0, var_1) {
  self _meth_85A7("snd_set_plr_fatigue_smoothing", var_0, var_1);
}

_id_8DDC(var_0) {
  self _meth_85A7("snd_set_plr_is_female", var_0);
}

_id_8DDA(var_0) {
  self _meth_85A7("snd_set_plr_char_id", var_0);
}

_id_8DCE(var_0, var_1) {
  self _meth_85A7("snd_set_breath_master_vol", var_0, var_1);
}

_id_8DD3(var_0) {
  self _meth_85A7("snd_set_expletive_enabled", var_0);
}

set_expletive_chance(var_0) {
  self _meth_85A7("set_expletive_chance", var_0);
}

set_max_breath_lev_num(var_0) {
  self _meth_85A7("set_max_breath_lev_num", var_0);
}

sethidetrigger(var_0) {
  self _meth_85A7("set_max_plr_speed", var_0);
}

_id_92F3(var_0, var_1) {
  thread _id_9266();

  if(isDefined(var_0) && isDefined(var_1)) {
    _id_8DDB(var_0, var_1);
  }
}

_id_1BBE() {
  self endon("disconnect");
  self waittill("death");
  thread _id_93E2();
}

_id_1BBF() {
  self endon("disconnect");
  self endon("death");

  for(;;) {
    level common_scripts\utility::_id_A70A("game_ended", "round_end_finished");
    thread _id_93E2();
  }
}

_id_1BBD() {
  var_0 = 0;
  var_1 = self._id_20D8;

  if(self hasfemalecustomizationmodel()) {
    var_0 = 1;
  }

  if(isDefined(var_1)) {
    _id_8DDA(var_1);

    switch (var_1) {
      case 5:
      case 3:
      case 2:
        var_0 = 1;
        break;
    }
  } else
    _id_8DDA(undefined);

  _id_8DDC(var_0);
}

_id_8DF7(var_0) {
  var_1 = 0;

  if(isDefined(level.players)) {
    foreach(var_3 in level.players) {
      if(var_0 == var_3) {
        return 1;
      }
    }
  }

  return var_1;
}

_id_8DF8(var_0) {
  var_1 = 1;

  if(!_isarray(var_0)) {
    var_1 = 0;
  } else {
    foreach(var_3 in var_0) {
      var_4 = 1;

      foreach(var_6 in level.players) {
        if(var_3 == var_6) {
          var_4 = 0;
          break;
        }
      }

      if(var_4) {
        var_1 = 0;
        break;
      }
    }
  }

  return var_1;
}

_id_8DFE(var_0, var_1, var_2) {}

_id_8D14(var_0, var_1, var_2) {}

_id_8D86() {
  if(!isDefined(level._id_071D.guid)) {
    level._id_071D.guid = 0;
  }

  if(maps\mp\_utility::_id_585F()) {
    if(level._id_071D.guid > 10000) {
      level._id_071D.guid = 0;
    }
  }

  level._id_071D.guid++;
  return level._id_071D.guid;
}

_id_8D72(var_0, var_1) {
  return _piecewiselinearlookup(var_0, var_1);
}

_id_8D73(var_0, var_1, var_2, var_3) {
  _id_8D14(isDefined(var_0));
  _id_8D14(isDefined(var_3));
  _id_8D14(var_2 != var_1);
  var_4 = (var_0 - var_1) / (var_2 - var_1);
  var_4 = clamp(var_4, 0.0, 1.0);
  return _piecewiselinearlookup(var_4, var_3);
}

_id_8DCB(var_0, var_1, var_2) {
  var_1 = _id_8D49(1, var_1);
  var_2 = _id_8D49(1, var_2);

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_0[var_3][0] = var_0[var_3][0] * var_1;
    var_0[var_3][1] = var_0[var_3][1] * var_2;
  }

  return var_0;
}

_id_8D49(var_0, var_1) {
  var_2 = var_0;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  return var_2;
}

_id_8D1B(var_0) {
  return _randomfloat(1.0) < _id_8D49(0.5, var_0);
}

_id_8DEB(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self;
  var_7 = var_0 + "_line_emitter_" + _id_8D86();
  _id_8D14(_soundexists(var_0));
  _id_8D14(isDefined(var_1));
  _id_8D14(isDefined(var_2));
  var_3 = max(_id_8D49(0.1, var_3), 0);
  var_4 = max(_id_8D49(0.1, var_4), 0);
  var_5 = max(_id_8D49(0.05, var_5), 0.05);

  if(!isDefined(var_6._id_071D._id_5D87)) {
    var_6._id_071D._id_5D87 = [];
  }

  var_8 = spawn("script_origin", (0, 0, 0));
  var_6._id_071D._id_5D87[var_7] = var_8;
  var_6 _meth_85A7("snd_start_line_emitter", var_7, var_8, var_0, var_1, var_2, var_3, var_4, var_5);
  return var_7;
}

_id_8DEE(var_0) {
  _id_8D14(_isstring(var_0));
  _id_8D14(_isarray(level._id_071D._id_5D87));

  if(isDefined(level._id_071D._id_5D87[var_0])) {
    _func_307(level.players, "snd_stop_line_emitter", var_0);
    var_1 = level._id_071D._id_5D87[var_0];
    level._id_071D._id_5D87[var_0] = undefined;

    if(isDefined(var_1)) {
      var_1 delete();
    }
  }
}

_id_8DA7(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(getdvarint("snd_debug")) {
    _id_8D14(0, "snd_play_loop_at() IS OBSOLETE - DO NOT USE");
  }

  _id_8D14(_isstring(var_0));
  _id_8D14(isDefined(var_1));
  _id_8D14(_isstring(var_2));
  var_1 = _id_8D49((0, 0, 0), var_1);
  var_7 = _id_8D49(0.0, var_3);
  var_8 = _id_8D49(0.1, var_4);
  var_9 = _id_8D49(1.0, var_5);
  var_10 = _id_8D49(level, var_6);
  thread _id_8E88(var_0, var_1, var_2, var_7, var_8, var_9, var_10);
}

_id_8E88(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _func_351(var_0, undefined, var_1, undefined, undefined, undefined, var_3, undefined, var_5);

  if(!isDefined(var_7)) {
    return;
  }
  var_6 common_scripts\utility::_id_A732(var_2, "death");
  _func_352(var_7, var_4);
}

_id_8DAA(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(getdvarint("snd_debug")) {
    _id_8D14(0, "snd_play_loop_on() IS OBSOLETE - DO NOT USE");
  }

  _id_8D14(_isstring(var_0));
  _id_8D14(isDefined(var_1));
  _id_8D14(_isstring(var_2));
  var_6 = _id_8D49(0.0, var_3);
  var_7 = _id_8D49(0.1, var_4);
  var_8 = _id_8D49(1.0, var_5);
  thread _id_8E8A(var_0, var_1, var_2, var_6, var_7, var_8);
}

_id_8E8A(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _func_351(var_0, var_1, undefined, undefined, undefined, "hard", var_3, var_4, var_5);

  if(!isDefined(var_6)) {
    return;
  }
  var_1 common_scripts\utility::_id_A732(var_2, "death");
  _func_352(var_6, var_4);
}

_id_8D9E(var_0, var_1, var_2, var_3, var_4) {
  _func_307(level.players, "snd_play_dist_conditional_at", var_0, var_1, var_2, var_3, var_4);
}

_id_8D55(var_0, var_1, var_2, var_3) {}

_id_8D5B(var_0, var_1) {}

_id_8D56(var_0) {
  foreach(var_2 in self._id_5ADF) {
    _id_8D5B(var_2, "");
  }
}

_id_8D5A(var_0, var_1) {}

_id_8D57(var_0, var_1, var_2) {}

_id_8E7A(var_0, var_1, var_2) {}

_id_8E7B(var_0) {}

_id_8D58() {}

_id_8DC2(var_0, var_1) {}

_id_8D64(var_0) {}

_id_8D3B() {}

_id_8DE8(var_0) {}

_id_7207(var_0, var_1, var_2, var_3) {
  var_4 = var_0;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = var_2;
  var_11 = undefined;
  var_12 = var_3;
  var_13 = var_2;
  var_14 = var_1;
  var_15 = undefined;
  return _func_351(var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);
}

_id_7208(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0;
  var_6 = undefined;
  var_2 = var_2;
  var_7 = "world";
  var_8 = undefined;
  var_9 = undefined;
  var_10 = var_3;
  var_11 = undefined;
  var_12 = var_4;
  var_13 = var_3;
  var_14 = var_1;
  var_15 = undefined;
  return _func_351(var_5, var_6, var_2, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);
}

_id_7209(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_0;
  var_8 = var_2;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = _id_8D49("hard", var_6);
  var_13 = var_3;
  var_14 = var_4;
  var_15 = var_5;
  var_16 = var_3;
  var_17 = var_1;
  var_18 = undefined;
  return _func_351(var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18);
}

_id_8D0B(var_0) {
  foreach(var_2 in level.players) {
    var_2 clientaddsoundsubmix(var_0);
  }
}

_id_8D18(var_0) {
  foreach(var_2 in level.players) {
    var_2 clientclearsoundsubmix(var_0);
  }
}

_id_8D0C(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level.players;
  } else if(!_isarray(var_1)) {
    var_1 = [var_1];
  }

  foreach(var_3 in var_1) {
    var_3 clientaddsoundsubmix(var_0);
  }
}

_id_8D19(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level.players;
  } else if(!_isarray(var_1)) {
    var_1 = [var_1];
  }

  foreach(var_3 in var_1) {
    var_3 clientclearsoundsubmix(var_0);
  }
}

_id_307C(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_77EF = _id_8E5E(::_id_3082);
  var_3._id_586D = undefined;
  var_3._id_20CD = [];
  var_3._id_20CE = [];
  var_3.char_name_callouts = [];
  var_3.char_name_overrides = [];

  if(isDefined(var_0)) {
    for(var_4 = 0; var_4 < var_0.size; var_4++) {
      var_3._id_20CD[var_4] = var_0[var_4];
      var_3._id_20CE[var_0[var_4]] = var_4;

      if(isDefined(var_1) && var_1.size > 0 && isDefined(var_1[var_4])) {
        var_3.char_name_callouts[var_4] = var_1[var_4];
      }

      if(isDefined(var_2) && var_2.size > 0 && isDefined(var_2[var_4])) {
        var_3.char_name_overrides[var_4] = var_2[var_4];
      }
    }
  }

  level._id_071D._id_305D = var_3;
  var_3 thread _id_3086();
}

_id_307D() {}

_id_307E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_3083();
  var_6 = self;
  var_7 = undefined;

  if(isDefined(var_1)) {
    if(_isarray(var_1)) {
      var_7 = var_1;
    } else {
      var_7 = [var_1];
    }
  }

  var_11 = var_5 _id_3080(var_0, var_6, var_7, var_2, var_3);

  if(_isstring(var_4)) {
    var_5 thread _id_308A(var_6, var_11, var_4);
  } else {
    var_6 waittill(var_11);
  }

  return;
}

_id_308A(var_0, var_1, var_2) {
  var_0 waittill(var_1);
  var_0 notify(var_2);
}

_id_307B(var_0) {
  var_1 = _id_3083();
  return var_1._id_20CD[var_0];
}

_id_307A(var_0) {
  var_1 = _id_3083();
  return var_1._id_20CE[var_0];
}

dlg_get_char_name_callouts_from_name(var_0) {
  var_1 = _id_3083();
  var_2 = _id_307A(var_0);
  return var_1.char_name_callouts[var_2];
}

dlg_get_char_name_callouts_from_index(var_0) {
  var_1 = _id_3083();
  return var_1.char_name_callouts[var_0];
}

dlg_get_char_name_override_from_index(var_0) {
  var_1 = _id_3083();
  return var_1.char_name_overrides[var_0];
}

dlg_get_char_name_override_from_name(var_0) {
  var_1 = _id_3083();
  var_2 = _id_307A(var_0);
  return var_1.char_name_overrides[var_2];
}

_id_307F(var_0) {
  var_1 = _id_3083();
  var_1._id_A22A = var_0;
}

_id_3083() {
  return level._id_071D._id_305D;
}

_id_3080(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  var_6 = var_5 _id_3087(var_0, var_1, var_2, var_3, var_4);
  var_5._id_77EF _id_8E61(var_6);
  return var_6._id_3220;
}

_id_3087(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5._id_0BB4 = var_0;
  var_5._id_90BE = var_1;
  var_5._id_5DD0 = var_2;
  var_5._id_90C0 = _id_307B(var_1._id_20D8);
  var_5.priority = _id_8D49(0, var_3);
  var_5._id_1F18 = _id_8D49(0, var_4);
  var_5._id_3220 = var_0 + "_" + _id_8D86();
  return var_5;
}

_id_3086() {
  var_0 = undefined;

  for(;;) {
    if(self._id_77EF _id_8E62() > 0) {
      var_1 = _id_3084();
      var_2 = _id_3088(var_1);

      if(isDefined(var_2)) {
        if(isDefined(self._id_A22A)) {
          var_3 = var_1._id_90BE[[self._id_A22A]]("begin", var_2, var_1._id_0BB4);

          if(isDefined(var_3)) {
            dlgx_set_sound_handle_volume(var_2, var_3);
          }
        }

        var_1._id_90BE waittill(var_1._id_3220);

        if(isDefined(self._id_A22A)) {
          var_1._id_90BE[[self._id_A22A]]("end", var_2, var_1._id_0BB4);
        }
      } else
        waitframe();

      continue;
    }

    self._id_77EF waittill("size_changed");
  }
}

_id_3088(var_0) {
  var_1 = [var_0._id_90BE];

  if(isDefined(var_0._id_5DD0)) {
    foreach(var_3 in var_0._id_5DD0) {
      if(var_3 != var_0._id_90BE) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  var_5 = var_0._id_90BE;
  var_6 = 0;
  var_7 = 0.25;
  var_8 = 1.0;
  var_9 = _id_0380::_id_288D(var_0._id_0BB4, var_1, var_5, var_6, var_8, var_7);

  if(isDefined(var_9)) {
    var_0._id_8E51 = var_9;
    _id_308B(var_0);
    thread _id_3089(var_0);
  } else
    _id_8D14(0, "dlgx_monitor(): could not play alias <" + var_0._id_0BB4 + "> on CharacterIndex " + var_0._id_90BE._id_20D8);

  return var_9;
}

dlgx_set_sound_handle_volume(var_0, var_1) {
  _id_0380::_id_2891(var_0, var_1, 0);
}

_id_3089(var_0) {
  _func_359(var_0._id_8E51, var_0._id_90BE, var_0._id_3220);
  var_1 = gettime();
  var_0._id_90BE waittill(var_0._id_3220);
  var_2 = (gettime() - var_1) / 1000.0;
  _id_3081();
}

_id_3082(var_0, var_1) {}

_id_3085() {
  return isDefined(self._id_586D);
}

_id_308B(var_0) {
  self._id_586D = var_0;
}

_id_3081() {
  self._id_586D = undefined;
}

_id_3084() {
  return self._id_77EF _id_8E60();
}

_id_8E5E(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_586C = _id_8D49(::_id_8E5F, var_0);
  var_2._id_6062 = _id_8D49(10, var_1);
  var_2._id_28CC = 0;
  var_2._id_00B9 = 0;
  var_2._id_95BE = 0;
  var_2._id_2A35 = [];
  return var_2;
}

_id_8E5F(var_0, var_1) {}

_id_8E61(var_0) {
  if(!_id_8E64()) {
    self._id_2A35[self._id_95BE] = var_0;
    self._id_95BE = (self._id_95BE + 1) % self._id_6062;
    self._id_28CC++;
    self notify("size_changed");
  } else
    _id_8D14(0, "QUE OVERFLOW");
}

_id_8E60() {
  var_0 = undefined;

  if(!_id_8E63()) {
    var_0 = self._id_2A35[self._id_00B9];
    self._id_00B9 = (self._id_00B9 + 1) % self._id_6062;
    self._id_28CC--;
    self notify("size_changed");
  } else
    _id_8D14(0, "QUE UNDERFLOW");

  return var_0;
}

_id_8E62() {
  return self._id_28CC;
}

_id_8E63() {
  return self._id_00B9 == self._id_95BE;
}

_id_8E64() {
  return self._id_00B9 == (self._id_95BE + 1) % self._id_6062;
}

_id_8DE9(var_0, var_1, var_2, var_3) {
  var_4 = _id_8D49(var_2, var_3);
  var_5 = 1.0;

  if(var_1 > var_0) {
    var_5 = var_2;
  } else if(var_1 < var_0) {
    var_5 = var_4;
  }

  return var_0 + var_5 * (var_1 - var_0);
}