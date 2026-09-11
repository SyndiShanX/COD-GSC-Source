/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\anim_scene.gsc
***********************************************/

#using_animtree("script_model");

function anim_scene_create_actor(var0, var1, var2, var3, var4) {
  var5 = spawnStruct();
  var5.entity = var0;
  var5.animname = var1;
  var5.interruptable = 0;
  var5.interrupted = 0;
  var5.endscene = 0;
  var5.forceendscene = 0;

  if(isDefined(var2) && var2) {
    var5.is_player = var2;

    if(isDefined(var3)) {
      var5.player_rig_visible = var3;
    } else {
      var5.player_rig_visible = 1;
    }

    if(isDefined(var4)) {
      var5.disable_weapons = var4;
    } else {
      var5.disable_weapons = 1;
    }
  } else {
    var5.is_player = 0;
    var5.entity.animname = var5.animname;
    var5.entity useanimtree(#animtree);
  }

  return var5;
}

function anim_scene_set_actor_interruptable(var0, var1, var2) {
  self.interruptable = var0;

  if(isDefined(var1)) {
    self.interrupt_anime = var1;

    if(isDefined(var2)) {
      self.interrupt_first_frame = var2;
      return;
    }

    self.interrupt_first_frame = 0;
    return;
  }
}

function anim_scene(var0, var1, var2, var3, var4, var5, var6, var7) {
  foreach(var9 in var0) {
    var9.interrupted = 0;
    var9.endscene = 0;
  }

  var11 = _anim_scene_internal(var0, var1, 0, var4, var2, var3, var5, var6, var7);

  if(isDefined(var11) && var11) {
    return 1;
  }

  return 0;
}

function anim_scene_loop(var0, var1, var2, var3, var4, var5, var6, var7) {
  foreach(var9 in var0) {
    var9.interrupted = 0;
    var9.endscene = 0;
  }

  _anim_scene_internal(var0, var1, 1, var4, var2, var3, var5, var6, var7);
  var11 = 1;

  foreach(var9 in var0) {
    if(!var9.endscene) {
      var11 = 0;
      break;
    }
  }

  return var11;
}

function anim_scene_stop(var0) {
  if(isDefined(var0) && var0) {
    self notify("anim_scene_force_end");
    return;
  }

  self notify("stop_scene");
}

function anim_scene_stop_actor(var0) {
  var0.endscene = 1;
}

function _anim_scene_internal(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  self endon("anim_scene_interrupted");

  if(!isDefined(var4)) {
    var4 = 1;
  }

  if(!isDefined(var5)) {
    var5 = 1;
  }

  thread _anim_scene_ender_think(var0);
  thread _anim_scene_force_end_think(var0);
  var12 = 0;
  thread _anim_scene_interrupt_think(var0, var3, var5);

  if(var4) {
    if(!isDefined(var6)) {
      var6 = 0.4;
    }

    if(!isDefined(var7)) {
      var7 = 0.8;
    }

    _anim_scene_internal_blend_in(var0, var1, var3, var6, var8);
    _anim_scene_internal_finish_blend(var0, var6, var7);
  }

  _anim_scene_internal_start_anims(var0, var1, var2, var3);

  if(!var2) {
    foreach(var10 in var0) {
      var10.animduration = _anim_scene_internal_get_anim_duration(var10, var1);

      if(var10.animduration > var12) {
        var12 = var10.animduration;
      }
    }

    foreach(var10 in var0) {
      if(var10.animduration < var12) {
        thread _anim_scene_actor_end_interrupt_think(var10);
      }
    }
  }

  if(var2) {
    self waittill("never");
  } else {
    wait var12;
  }

  waittillframeend();
  self notify("anim_scene_success");

  if(var5) {
    _anim_scene_internal_end(var0);
  }

  return true;
}

#using_animtree("");

function _anim_scene_internal_blend_in(var0, var1, var2, var3, var4) {
  foreach(var6 in var0) {
    if(var6.is_player) {
      if(istrue(var4)) {
        var7 = "viewhands_base_iw8";
        var6.player_rig = spawn("script_model", var6.entity.origin);
        var6.player_rig setModel(var7);
        var6.player_rig.animname = var6.animname;
        var6.player_rig useanimtree(#animtree);
        var6.player_rig hide();
      } else {
        var6.player_rig = spawn("script_arms", var6.entity.origin, 0, 0, var6.entity);
        var6.player_rig.animname = var6.animname;
        var6.player_rig useanimtree(#animtree);
        var6.player_rig hide();
        var6.player_rig.entity = var6.entity;
      }

      scripts\common\anim::anim_first_frame_solo(var6.player_rig, var1, var2);
      var6.entity setstance(prematchendtime(var6));
      var6.entity playerlinktoblend(var6.player_rig, "tag_player", var3);

      if(var6.disable_weapons) {
        var6.entity scripts\common\utility::allow_weapon(0);
      }
    }
  }
}

function prematchendtime(var0) {
  if(isDefined(var0.entity.bunker11puzzleactive)) {
    return var0.entity.bunker11puzzleactive;
  }

  return "stand";
}

function _anim_scene_internal_finish_blend(var0, var1, var2) {
  var3 = var2 - var1;

  if(var3 > 0) {
    wait var1;

    foreach(var5 in var0) {
      if(var5.interrupted) {
        continue;
      }

      if(var5.is_player) {
        var5.entity playerlinktodelta(var5.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1);
      }
    }

    wait var3;

    foreach(var5 in var0) {
      if(var5.interrupted) {
        continue;
      }

      if(var5.is_player) {}
    }

    return;
  }

  wait var2;

  foreach(var5 in var1) {
    if(var5.interrupted) {
      continue;
    }

    if(var5.is_player) {
      var5.entity playerlinktodelta(var5.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1);
    }
  }
}

function _anim_scene_internal_get_anim_duration(var0, var1) {
  var2 = 0;

  if(var0.is_player) {
    var3 = getanimlength(level.scr_anim[var0.player_rig.animname][var1]);

    if(var3 > var2) {
      var2 = var3;
    }
  } else {
    var3 = getanimlength(level.scr_anim[var1.animname][var2]);

    if(var3 > var3) {
      var3 = var3;
    }
  }

  return var3;
}

function _anim_scene_internal_start_anims(var0, var1, var2, var3) {
  foreach(var5 in var0) {
    if(var5.interrupted) {
      continue;
    }

    if(var5.is_player) {
      if(var2) {
        var5.entity playanimscriptsceneevent("scripted_scene", level.scr_eventanim[var5.animname][var1][0]);
      } else {
        var5.entity playanimscriptsceneevent("scripted_scene", level.scr_eventanim[var5.animname][var1]);
      }

      if(isDefined(level.scr_viewmodelanim[var5.animname]) && isDefined(level.scr_viewmodelanim[var5.animname][var1]) && !istrue(var5.entity.blockviewmodelanim)) {
        if(var2) {
          var5.entity playviewmodelanim(level.scr_viewmodelanim[var5.animname][var1][0]);
        } else {
          var5.entity playviewmodelanim(level.scr_viewmodelanim[var5.animname][var1]);
        }
      }

      if(var5.player_rig_visible) {
        var5.player_rig showonlytoplayer(var5.entity);
      }

      if(var2) {
        thread scripts\common\anim::anim_loop_solo(var5.player_rig, var1, "stop_scene", var3);
      } else {
        thread scripts\common\anim::anim_single_solo(var5.player_rig, var1, var3);
      }

      continue;
    }

    if(var2) {
      thread scripts\common\anim::anim_loop_solo(var5.entity, var1, "stop_scene", var3);
      continue;
    }

    thread scripts\common\anim::anim_single_solo(var5.entity, var1, var3);
  }
}

function _anim_scene_internal_end(var0) {
  foreach(var2 in var0) {
    if(var2.interrupted) {
      continue;
    }

    if(var2.is_player) {
      if(var2.disable_weapons) {
        var2.entity scripts\common\utility::allow_weapon(1);
      }

      var2.entity unlink();
      var2.entity setOrigin(var2.entity.origin + (0, 0, 1));
      var2.player_rig delete();
      var2.player_rig = undefined;
    }
  }
}

function _anim_scene_ender_think(var0) {
  self endon("anim_scene_success");
  self endon("anim_scene_interrupted");
  self waittill("stop_scene");

  foreach(var2 in var0) {
    var2.endscene = 1;
  }
}

function _anim_scene_force_end_think(var0) {
  self endon("anim_scene_success");
  self endon("anim_scene_interrupted");
  self waittill("anim_scene_force_end");

  foreach(var2 in var0) {
    var2.forceendscene = 1;
  }
}

function _anim_scene_actor_end_interrupt_think(var0) {
  self endon("anim_scene_success");
  self endon("anim_scene_interrupted");
  wait var0.animduration;

  if(!var0.interrupted) {
    var0.endscene = 1;
    return;
  }
}

function _anim_scene_interrupt_think(var0, var1, var2) {
  self endon("anim_scene_success");
  self endon("anim_scene_interrupted");

  for(;;) {
    var3 = 0;

    for(;;) {
      wait 0.05;

      foreach(var5 in var0) {
        if(var5.endscene || var5.forceendscene || !isDefined(var5.entity) || var5.is_player && !isalive(var5.entity) || var5.is_player && isDefined(var5.entity.fauxdead)) {
          if(!var5.interrupted) {
            var3 = 1;
            break;
          }
        }
      }

      if(var3) {
        break;
      }
    }

    var7 = 1;

    foreach(var5 in var0) {
      var9 = 0;

      if(!isDefined(var5.entity) || var5.is_player && !isalive(var5.entity) || var5.is_player && isDefined(var5.entity.fauxdead)) {
        var9 = 1;
      }

      if(!var9 && !var5.endscene && !var5.forceendscene && !var5.interruptable) {
        var7 = 0;
        continue;
      }

      var5.interrupted = 1;

      if(var9 && !var5.is_player) {
        continue;
      }

      if(var5.is_player) {
        if((var2 || var5.forceendscene) && !var9) {
          if(var5.disable_weapons) {
            if(!var5.entity scripts\common\input_allow::is_input_allowed_internal("weapon")) {
              var5.entity scripts\common\utility::allow_weapon(1);
            }
          }

          var5.entity stopanimscriptsceneevent();
          var5.entity unlink();
          var5.entity setOrigin(var5.entity.origin + (0, 0, 1));
        }

        if(var2 || var5.forceendscene || var9) {
          if(isent(var5.player_rig)) {
            var5.player_rig delete();
            var5.player_rig = undefined;
          }
        }

        continue;
      }

      if(isDefined(var5.interrupt_anime)) {
        if(var5.interrupt_first_frame) {
          thread scripts\common\anim::anim_first_frame_solo(var5.entity, var5.interrupt_anime, var1);
        } else {
          var5.entity stopanimScripted();
          thread scripts\common\anim::anim_single_solo(var5.entity, var5.interrupt_anime, var1);
        }

        continue;
      }

      var5.entity stopanimScripted();
    }

    if(var7) {
      self notify("anim_scene_interrupted");
      return;
    }
  }
}