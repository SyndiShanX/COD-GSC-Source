/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\anim_scene.gsc
***********************************************/

#using_animtree("script_model");

function anim_scene_create_actor(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.entity = var_0;
  var_5.animname = var_1;
  var_5.interruptable = 0;
  var_5.interrupted = 0;
  var_5.endscene = 0;
  var_5.forceendscene = 0;

  if(isDefined(var_2) && var_2) {
    var_5.is_player = var_2;

    if(isDefined(var_3)) {
      var_5.player_rig_visible = var_3;
    } else {
      var_5.player_rig_visible = 1;
    }

    if(isDefined(var_4)) {
      var_5.disable_weapons = var_4;
    } else {
      var_5.disable_weapons = 1;
    }
  } else {
    var_5.is_player = 0;
    var_5.entity.animname = var_5.animname;
    var_5.entity useanimtree(#animtree);
  }

  return var_5;
}

function anim_scene_set_actor_interruptable(var_0, var_1, var_2) {
  self.interruptable = var_0;

  if(isDefined(var_1)) {
    self.interrupt_anime = var_1;

    if(isDefined(var_2)) {
      self.interrupt_first_frame = var_2;
      return;
    }

    self.interrupt_first_frame = 0;
    return;
  }
}

function anim_scene(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  foreach(var_9 in var_0) {
    var_9.interrupted = 0;
    var_9.endscene = 0;
  }

  var_11 = _anim_scene_internal(var_0, var_1, 0, var_4, var_2, var_3, var_5, var_6, var_7);

  if(isDefined(var_11) && var_11) {
    return 1;
  }

  return 0;
}

function anim_scene_loop(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
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

function anim_scene_stop(var_0) {
  if(isDefined(var_0) && var_0) {
    self notify("anim_scene_force_end");
    return;
  }

  self notify("stop_scene");
}

function anim_scene_stop_actor(var_0) {
  var_0.endscene = 1;
}

function _anim_scene_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("anim_scene_interrupted");

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  thread _anim_scene_ender_think(var_0);
  thread _anim_scene_force_end_think(var_0);
  var_12 = 0;
  thread _anim_scene_interrupt_think(var_0, var_3, var_5);

  if(var_4) {
    if(!isDefined(var_6)) {
      var_6 = 0.4;
    }

    if(!isDefined(var_7)) {
      var_7 = 0.8;
    }

    _anim_scene_internal_blend_in(var_0, var_1, var_3, var_6, var_8);
    _anim_scene_internal_finish_blend(var_0, var_6, var_7);
  }

  _anim_scene_internal_start_anims(var_0, var_1, var_2, var_3);

  if(!var_2) {
    foreach(var_10 in var_0) {
      var_10.animduration = _anim_scene_internal_get_anim_duration(var_10, var_1);

      if(var_10.animduration > var_12) {
        var_12 = var_10.animduration;
      }
    }

    foreach(var_10 in var_0) {
      if(var_10.animduration < var_12) {
        thread _anim_scene_actor_end_interrupt_think(var_10);
      }
    }
  }

  if(var_2) {
    self waittill("never");
  } else {
    wait var_12;
  }

  waittillframeend();
  self notify("anim_scene_success");

  if(var_5) {
    _anim_scene_internal_end(var_0);
  }

  return true;
}

#using_animtree("");

function _anim_scene_internal_blend_in(var_0, var_1, var_2, var_3, var_4) {
  foreach(var_6 in var_0) {
    if(var_6.is_player) {
      if(istrue(var_4)) {
        var_7 = "viewhands_base_iw8";
        var_6.player_rig = spawn("script_model", var_6.entity.origin);
        var_6.player_rig setModel(var_7);
        var_6.player_rig.animname = var_6.animname;
        var_6.player_rig useanimtree(#animtree);
        var_6.player_rig hide();
      } else {
        var_6.player_rig = spawn("script_arms", var_6.entity.origin, 0, 0, var_6.entity);
        var_6.player_rig.animname = var_6.animname;
        var_6.player_rig useanimtree(#animtree);
        var_6.player_rig hide();
        var_6.player_rig.entity = var_6.entity;
      }

      scripts\common\anim::anim_first_frame_solo(var_6.player_rig, var_1, var_2);
      var_6.entity setstance(prematchendtime(var_6));
      var_6.entity playerlinktoblend(var_6.player_rig, "tag_player", var_3);

      if(var_6.disable_weapons) {
        var_6.entity scripts\common\utility::allow_weapon(0);
      }
    }
  }
}

function prematchendtime(var_0) {
  if(isDefined(var_0.entity.bunker11puzzleactive)) {
    return var_0.entity.bunker11puzzleactive;
  }

  return "stand";
}

function _anim_scene_internal_finish_blend(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;

  if(var_3 > 0) {
    wait var_1;

    foreach(var_5 in var_0) {
      if(var_5.interrupted) {
        continue;
      }

      if(var_5.is_player) {
        var_5.entity playerlinktodelta(var_5.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1);
      }
    }

    wait var_3;

    foreach(var_5 in var_0) {
      if(var_5.interrupted) {
        continue;
      }

      if(var_5.is_player) {}
    }

    return;
  }

  wait var_2;

  foreach(var_5 in var_1) {
    if(var_5.interrupted) {
      continue;
    }

    if(var_5.is_player) {
      var_5.entity playerlinktodelta(var_5.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1);
    }
  }
}

function _anim_scene_internal_get_anim_duration(var_0, var_1) {
  var_2 = 0;

  if(var_0.is_player) {
    var_3 = getanimlength(level.scr_anim[var_0.player_rig.animname][var_1]);

    if(var_3 > var_2) {
      var_2 = var_3;
    }
  } else {
    var_3 = getanimlength(level.scr_anim[var_1.animname][var_2]);

    if(var_3 > var_3) {
      var_3 = var_3;
    }
  }

  return var_3;
}

function _anim_scene_internal_start_anims(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    if(var_5.interrupted) {
      continue;
    }

    if(var_5.is_player) {
      if(var_2) {
        var_5.entity playanimscriptsceneevent("scripted_scene", level.scr_eventanim[var_5.animname][var_1][0]);
      } else {
        var_5.entity playanimscriptsceneevent("scripted_scene", level.scr_eventanim[var_5.animname][var_1]);
      }

      if(isDefined(level.scr_viewmodelanim[var_5.animname]) && isDefined(level.scr_viewmodelanim[var_5.animname][var_1]) && !istrue(var_5.entity.blockviewmodelanim)) {
        if(var_2) {
          var_5.entity playviewmodelanim(level.scr_viewmodelanim[var_5.animname][var_1][0]);
        } else {
          var_5.entity playviewmodelanim(level.scr_viewmodelanim[var_5.animname][var_1]);
        }
      }

      if(var_5.player_rig_visible) {
        var_5.player_rig showonlytoplayer(var_5.entity);
      }

      if(var_2) {
        thread scripts\common\anim::anim_loop_solo(var_5.player_rig, var_1, "stop_scene", var_3);
      } else {
        thread scripts\common\anim::anim_single_solo(var_5.player_rig, var_1, var_3);
      }

      continue;
    }

    if(var_2) {
      thread scripts\common\anim::anim_loop_solo(var_5.entity, var_1, "stop_scene", var_3);
      continue;
    }

    thread scripts\common\anim::anim_single_solo(var_5.entity, var_1, var_3);
  }
}

function _anim_scene_internal_end(var_0) {
  foreach(var_2 in var_0) {
    if(var_2.interrupted) {
      continue;
    }

    if(var_2.is_player) {
      if(var_2.disable_weapons) {
        var_2.entity scripts\common\utility::allow_weapon(1);
      }

      var_2.entity unlink();
      var_2.entity setOrigin(var_2.entity.origin + (0, 0, 1));
      var_2.player_rig delete();
      var_2.player_rig = undefined;
    }
  }
}

function _anim_scene_ender_think(var_0) {
  self endon("anim_scene_success");
  self endon("anim_scene_interrupted");
  self waittill("stop_scene");

  foreach(var_2 in var_0) {
    var_2.endscene = 1;
  }
}

function _anim_scene_force_end_think(var_0) {
  self endon("anim_scene_success");
  self endon("anim_scene_interrupted");
  self waittill("anim_scene_force_end");

  foreach(var_2 in var_0) {
    var_2.forceendscene = 1;
  }
}

function _anim_scene_actor_end_interrupt_think(var_0) {
  self endon("anim_scene_success");
  self endon("anim_scene_interrupted");
  wait var_0.animduration;

  if(!var_0.interrupted) {
    var_0.endscene = 1;
    return;
  }
}

function _anim_scene_interrupt_think(var_0, var_1, var_2) {
  self endon("anim_scene_success");
  self endon("anim_scene_interrupted");

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

      if(!isDefined(var_5.entity) || var_5.is_player && !isalive(var_5.entity) || var_5.is_player && isDefined(var_5.entity.fauxdead)) {
        var_9 = 1;
      }

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
            if(!var_5.entity scripts\common\input_allow::is_input_allowed_internal("weapon")) {
              var_5.entity scripts\common\utility::allow_weapon(1);
            }
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
        if(var_5.interrupt_first_frame) {
          thread scripts\common\anim::anim_first_frame_solo(var_5.entity, var_5.interrupt_anime, var_1);
        } else {
          var_5.entity stopanimScripted();
          thread scripts\common\anim::anim_single_solo(var_5.entity, var_5.interrupt_anime, var_1);
        }

        continue;
      }

      var_5.entity stopanimScripted();
    }

    if(var_7) {
      self notify("anim_scene_interrupted");
      return;
    }
  }
}