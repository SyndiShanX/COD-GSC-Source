/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\anim_scene.gsc
***********************************************/

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

anim_scene_create_actor(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.entity = var_0;
  var_5.animname = var_1;
  var_5.interruptable = 0;
  var_5.interrupted = 0;
  var_5.endscene = 0;
  var_5.forceendscene = 0;

  if(isDefined(var_2) && var_2) {
    var_5.is_player = var_2;

    if(isDefined(var_3))
      var_5.player_rig_visible = var_3;
    else
      var_5.player_rig_visible = 1;

    if(isDefined(var_4))
      var_5.disable_weapons = var_4;
    else
      var_5.disable_weapons = 1;
  } else {
    var_5.is_player = 0;
    var_5.entity.animname = var_5.animname;
    var_5.entity useanimtree(#animtree);
  }

  return var_5;
}

anim_scene_set_actor_interruptable(var_0, var_1, var_2) {
  self.interruptable = var_0;

  if(isDefined(var_1)) {
    self.interrupt_anime = var_1;

    if(isDefined(var_2))
      self.interrupt_first_frame = var_2;
    else
      self.interrupt_first_frame = 0;
  }
}

anim_scene(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  foreach(var_9 in var_0) {
    var_9.interrupted = 0;
    var_9.endscene = 0;
  }

  var_11 = _anim_scene_internal(var_0, var_1, 0, var_4, var_2, var_3, var_5, var_6, var_7);

  if(isDefined(var_11) && var_11)
    return 1;
  else
    return 0;
}

anim_scene_loop(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  foreach(var_9 in var_0) {
    var_9.interrupted = 0;
    var_9.endscene = 0;
  }

  _anim_scene_internal(var_0, var_1, 1, var_4, var_2, var_3, var_5, var_6, var_7);
  var_11 = 1;

  foreach(var_9 in var_0) {
    if(!var_9.endscene) {
      var_11 = 0;
      break;
    }
  }

  return var_11;
}

anim_scene_stop(var_0) {
  if(isDefined(var_0) && var_0)
    self notify("_encstr_9BD9152C73A5D6BE371BACE6CA7D33B7276CCA7DCACD8C");
  else
    self notify("_encstr_96540BE68EB71CFAE6B195CD59");
}

anim_scene_stop_actor(var_0) {
  var_0.endscene = 1;
}

_anim_scene_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("_encstr_B42B174F657021CFF32F70F8E2D1D260C33D887BCD886B350B");

  if(!isDefined(var_4))
    var_4 = 1;

  if(!isDefined(var_5))
    var_5 = 1;

  thread _anim_scene_ender_think(var_0);
  thread _anim_scene_force_end_think(var_0);
  var_12 = 0.0;
  thread _anim_scene_interrupt_think(var_0, var_3, var_5);

  if(var_4) {
    if(!isDefined(var_6))
      var_6 = 0.4;

    if(!isDefined(var_7))
      var_7 = 0.8;

    _anim_scene_internal_blend_in(var_0, var_1, var_3, var_6, var_8);
    _anim_scene_internal_finish_blend(var_0, var_6, var_7);
  }

  _anim_scene_internal_start_anims(var_0, var_1, var_2, var_3);

  if(!var_2) {
    foreach(var_10 in var_0) {
      var_10.animduration = _anim_scene_internal_get_anim_duration(var_10, var_1);

      if(var_10.animduration > var_12)
        var_12 = var_10.animduration;
    }

    foreach(var_10 in var_0) {
      if(var_10.animduration < var_12)
        thread _anim_scene_actor_end_interrupt_think(var_10);
    }
  }

  if(var_2)
    self waittill("_encstr_911E0605B80E912D");
  else
    wait(var_12);

  waittillframeend;
  self notify("_encstr_92D5135BF6CCF82047B2D1B83A1FEEE0E653EBF773");

  if(var_5)
    _anim_scene_internal_end(var_0);

  return 1;
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_anim_scene_internal_blend_in(var_0, var_1, var_2, var_3, var_4) {
  foreach(var_6 in var_0) {
    if(var_6.is_player) {
      if(istrue(var_4)) {
        var_7 = "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A";
        var_6.player_rig = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6.entity.origin);
        var_6.player_rig setModel(var_7);
        var_6.player_rig.animname = var_6.animname;
        var_6.player_rig useanimtree(#animtree);
        var_6.player_rig hide();
      } else {
        var_6.player_rig = spawn("_encstr_BEFE0C2FAB5A88876B4181EB4A5F", var_6.entity.origin, 0, 0, var_6.entity);
        var_6.player_rig.animname = var_6.animname;
        var_6.player_rig useanimtree(#animtree);
        var_6.player_rig hide();
        var_6.player_rig.entity = var_6.entity;
      }

      scripts\common\anim::anim_first_frame_solo(var_6.player_rig, var_1, var_2);
      var_6.entity setstance(prematchendtime(var_6));
      var_6.entity playerlinktoblend(var_6.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", var_3);

      if(var_6.disable_weapons)
        var_6.entity scripts\common\utility::allow_weapon(0);
    }
  }
}

prematchendtime(var_0) {
  if(isDefined(var_0.entity.bunker11puzzleactive))
    return var_0.entity.bunker11puzzleactive;

  return "_encstr_A5AD069B231F0BAF";
}

_anim_scene_internal_finish_blend(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;

  if(var_3 > 0.0) {
    wait(var_1);

    foreach(var_5 in var_0) {
      if(var_5.interrupted) {
        continue;
      }
      if(var_5.is_player)
        var_5.entity playerlinktodelta(var_5.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 0, 1, 1);
    }

    wait(var_3);

    foreach(var_5 in var_0) {
      if(var_5.interrupted) {
        continue;
      }
      if(var_5.is_player) {}
    }
  } else {
    wait(var_1);

    foreach(var_5 in var_0) {
      if(var_5.interrupted) {
        continue;
      }
      if(var_5.is_player)
        var_5.entity playerlinktodelta(var_5.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 0, 1, 1);
    }
  }
}

_anim_scene_internal_get_anim_duration(var_0, var_1) {
  var_2 = 0.0;

  if(var_0.is_player) {
    var_3 = getanimlength(level.scr_anim[var_0.player_rig.animname][var_1]);

    if(var_3 > var_2)
      var_2 = var_3;
  } else {
    var_3 = getanimlength(level.scr_anim[var_0.animname][var_1]);

    if(var_3 > var_2)
      var_2 = var_3;
  }

  return var_2;
}

_anim_scene_internal_start_anims(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    if(var_5.interrupted) {
      continue;
    }
    if(var_5.is_player) {
      if(var_2)
        var_5.entity playanimscriptsceneevent("_encstr_B8850F13491E8F3290F32417B7403FCBCD", level.scr_eventanim[var_5.animname][var_1][0]);
      else
        var_5.entity playanimscriptsceneevent("_encstr_B8850F13491E8F3290F32417B7403FCBCD", level.scr_eventanim[var_5.animname][var_1]);

      if(isDefined(level.scr_viewmodelanim[var_5.animname]) && isDefined(level.scr_viewmodelanim[var_5.animname][var_1]) && !istrue(var_5.entity.blockviewmodelanim)) {
        if(var_2)
          var_5.entity playviewmodelanim(level.scr_viewmodelanim[var_5.animname][var_1][0]);
        else
          var_5.entity playviewmodelanim(level.scr_viewmodelanim[var_5.animname][var_1]);
      }

      if(var_5.player_rig_visible)
        var_5.player_rig showonlytoplayer(var_5.entity);

      if(var_2)
        thread scripts\common\anim::anim_loop_solo(var_5.player_rig, var_1, "_encstr_96540BE68EB71CFAE6B195CD59", var_3);
      else
        thread scripts\common\anim::anim_single_solo(var_5.player_rig, var_1, var_3);

      continue;
    }

    if(var_2) {
      thread scripts\common\anim::anim_loop_solo(var_5.entity, var_1, "_encstr_96540BE68EB71CFAE6B195CD59", var_3);
      continue;
    }

    thread scripts\common\anim::anim_single_solo(var_5.entity, var_1, var_3);
  }
}

_anim_scene_internal_end(var_0) {
  foreach(var_2 in var_0) {
    if(var_2.interrupted) {
      continue;
    }
    if(var_2.is_player) {
      if(var_2.disable_weapons)
        var_2.entity scripts\common\utility::allow_weapon(1);

      var_2.entity unlink();
      var_2.entity setOrigin(var_2.entity.origin + (0, 0, 1));
      var_2.player_rig delete();
      var_2.player_rig = undefined;
    }
  }
}

_anim_scene_ender_think(var_0) {
  self endon("_encstr_92D5135BF6CCF82047B2D1B83A1FEEE0E653EBF773");
  self endon("_encstr_B42B174F657021CFF32F70F8E2D1D260C33D887BCD886B350B");
  self waittill("_encstr_96540BE68EB71CFAE6B195CD59");

  foreach(var_2 in var_0)
  var_2.endscene = 1;
}

_anim_scene_force_end_think(var_0) {
  self endon("_encstr_92D5135BF6CCF82047B2D1B83A1FEEE0E653EBF773");
  self endon("_encstr_B42B174F657021CFF32F70F8E2D1D260C33D887BCD886B350B");
  self waittill("_encstr_9BD9152C73A5D6BE371BACE6CA7D33B7276CCA7DCACD8C");

  foreach(var_2 in var_0)
  var_2.forceendscene = 1;
}

_anim_scene_actor_end_interrupt_think(var_0) {
  self endon("_encstr_92D5135BF6CCF82047B2D1B83A1FEEE0E653EBF773");
  self endon("_encstr_B42B174F657021CFF32F70F8E2D1D260C33D887BCD886B350B");
  wait(var_0.animduration);

  if(!var_0.interrupted)
    var_0.endscene = 1;
}

_anim_scene_interrupt_think(var_0, var_1, var_2) {
  self endon("_encstr_92D5135BF6CCF82047B2D1B83A1FEEE0E653EBF773");
  self endon("_encstr_B42B174F657021CFF32F70F8E2D1D260C33D887BCD886B350B");

  for(;;) {
    var_3 = 0;

    for(;;) {
      wait 0.05;

      foreach(var_5 in var_0) {
        if(var_5.endscene || var_5.forceendscene || !isDefined(var_5.entity) || var_5.is_player && !isalive(var_5.entity) || var_5.is_player && isDefined(var_5.entity.fauxdead)) {
          if(!var_5.interrupted) {
            var_3 = 1;
            break;
          }
        }
      }

      if(var_3) {
        break;
      }
    }

    var_7 = 1;

    foreach(var_5 in var_0) {
      var_9 = 0;

      if(!isDefined(var_5.entity) || var_5.is_player && !isalive(var_5.entity) || var_5.is_player && isDefined(var_5.entity.fauxdead))
        var_9 = 1;

      if(!var_9 && !var_5.endscene && !var_5.forceendscene && !var_5.interruptable) {
        var_7 = 0;
        continue;
      }

      var_5.interrupted = 1;

      if(var_9 && !var_5.is_player) {
        continue;
      }
      if(var_5.is_player) {
        if((var_2 || var_5.forceendscene) && !var_9) {
          if(var_5.disable_weapons) {
            if(!var_5.entity scripts\common\input_allow::is_input_allowed_internal("_encstr_AC20072B9FA9487832"))
              var_5.entity scripts\common\utility::allow_weapon(1);
          }

          var_5.entity stopanimscriptsceneevent();
          var_5.entity unlink();
          var_5.entity setOrigin(var_5.entity.origin + (0, 0, 1));
        }

        if(var_2 || var_5.forceendscene || var_9) {
          if(isent(var_5.player_rig)) {
            var_5.player_rig delete();
            var_5.player_rig = undefined;
          }
        }

        continue;
      }

      if(isDefined(var_5.interrupt_anime)) {
        if(var_5.interrupt_first_frame)
          thread scripts\common\anim::anim_first_frame_solo(var_5.entity, var_5.interrupt_anime, var_1);
        else {
          var_5.entity stopanimScripted();
          thread scripts\common\anim::anim_single_solo(var_5.entity, var_5.interrupt_anime, var_1);
        }

        continue;
      }

      var_5.entity stopanimScripted();
    }

    if(var_7) {
      self notify("_encstr_B42B174F657021CFF32F70F8E2D1D260C33D887BCD886B350B");
      return;
    }
  }
}