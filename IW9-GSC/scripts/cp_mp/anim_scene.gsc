/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\anim_scene.gsc
***********************************************/

#using_animtree("script_model");

anim_scene_create_actor(entity, animname, is_player, player_rig_visible, disable_weapons, _id_FDFAF00190EFAF80) {
  actor = spawnStruct();
  actor.entity = entity;
  actor.animname = animname;
  actor.interruptable = 0;
  actor.interrupted = 0;
  actor.endscene = 0;
  actor.forceendscene = 0;

  if(isDefined(is_player) && is_player) {
    actor.is_player = is_player;

    if(isDefined(player_rig_visible))
      actor.player_rig_visible = player_rig_visible;
    else
      actor.player_rig_visible = 1;

    if(isDefined(disable_weapons))
      actor.disable_weapons = disable_weapons;
    else
      actor.disable_weapons = 1;

    if(isDefined(_id_FDFAF00190EFAF80))
      actor._id_FDFAF00190EFAF80 = _id_FDFAF00190EFAF80;
    else
      actor._id_FDFAF00190EFAF80 = 0;
  } else {
    actor.is_player = 0;
    actor.entity.animname = actor.animname;
    actor.entity useanimtree(#animtree);
  }

  return actor;
}

anim_scene_set_actor_interruptable(_id_9C5FEB9C7EF9892D, interrupt_anime, first_frame) {
  self.interruptable = _id_9C5FEB9C7EF9892D;

  if(isDefined(interrupt_anime)) {
    self.interrupt_anime = interrupt_anime;

    if(isDefined(first_frame))
      self.interrupt_first_frame = first_frame;
    else
      self.interrupt_first_frame = 0;
  }
}

anim_scene(actors, anime, _id_55856A096D73670C, _id_C502534A60E19429, tag, blend_in_time, _id_AA3247C3C61F5E1C, _id_E1C732B6F63F3E8B) {
  foreach(actor in actors) {
    actor.interrupted = 0;
    actor.endscene = 0;
  }

  result = _anim_scene_internal(actors, anime, 0, tag, _id_55856A096D73670C, _id_C502534A60E19429, blend_in_time, _id_AA3247C3C61F5E1C, _id_E1C732B6F63F3E8B);

  if(isDefined(result) && result)
    return 1;
  else
    return 0;
}

anim_scene_loop(actors, anime, _id_55856A096D73670C, _id_C502534A60E19429, tag, blend_in_time, _id_AA3247C3C61F5E1C, _id_E1C732B6F63F3E8B) {
  foreach(actor in actors) {
    actor.interrupted = 0;
    actor.endscene = 0;
  }

  _anim_scene_internal(actors, anime, 1, tag, _id_55856A096D73670C, _id_C502534A60E19429, blend_in_time, _id_AA3247C3C61F5E1C, _id_E1C732B6F63F3E8B);
  _id_B51B919D4C5E5691 = 1;

  foreach(actor in actors) {
    if(!actor.endscene) {
      _id_B51B919D4C5E5691 = 0;
      break;
    }
  }

  return _id_B51B919D4C5E5691;
}

anim_scene_stop(_id_EC951E7A56C0F445) {
  if(isDefined(_id_EC951E7A56C0F445) && _id_EC951E7A56C0F445)
    self notify("anim_scene_force_end");
  else
    self notify("stop_scene");
}

anim_scene_stop_actor(actor) {
  actor.endscene = 1;
}

_anim_scene_internal(actors, anime, _id_1208CA5973245D19, tag, _id_55856A096D73670C, _id_C502534A60E19429, blend_in_time, _id_AA3247C3C61F5E1C, _id_E1C732B6F63F3E8B) {
  self endon("anim_scene_interrupted");

  if(!isDefined(_id_55856A096D73670C))
    _id_55856A096D73670C = 1;

  if(!isDefined(_id_C502534A60E19429))
    _id_C502534A60E19429 = 1;

  thread _anim_scene_ender_think(actors);
  thread _anim_scene_force_end_think(actors);
  _id_20D060C0D2EE7DE0 = 0.0;
  thread _anim_scene_interrupt_think(actors, tag, _id_C502534A60E19429);

  if(_id_55856A096D73670C) {
    if(!isDefined(blend_in_time))
      blend_in_time = 0.4;

    if(!isDefined(_id_AA3247C3C61F5E1C))
      _id_AA3247C3C61F5E1C = 0.8;

    _anim_scene_internal_blend_in(actors, anime, tag, blend_in_time, _id_E1C732B6F63F3E8B);
    _anim_scene_internal_finish_blend(actors, blend_in_time, _id_AA3247C3C61F5E1C);
  }

  _anim_scene_internal_start_anims(actors, anime, _id_1208CA5973245D19, tag);

  if(!_id_1208CA5973245D19) {
    foreach(actor in actors) {
      actor.animduration = _anim_scene_internal_get_anim_duration(actor, anime);

      if(actor.animduration > _id_20D060C0D2EE7DE0)
        _id_20D060C0D2EE7DE0 = actor.animduration;
    }

    foreach(actor in actors) {
      if(actor.animduration < _id_20D060C0D2EE7DE0)
        thread _anim_scene_actor_end_interrupt_think(actor);
    }
  }

  if(_id_1208CA5973245D19)
    self waittill("never");
  else
    wait(_id_20D060C0D2EE7DE0);

  waittillframeend;
  self notify("anim_scene_success");

  if(_id_C502534A60E19429)
    _anim_scene_internal_end(actors);

  return 1;
}

_anim_scene_internal_blend_in(actors, anime, tag, blend_in_time, _id_E1C732B6F63F3E8B) {
  foreach(actor in actors) {
    if(actor.is_player) {
      if(istrue(_id_E1C732B6F63F3E8B)) {
        _id_486DB5FA512A3B6B = "viewhands_base_iw8";
        actor.player_rig = spawn("script_model", actor.entity.origin);
        actor.player_rig setModel(_id_486DB5FA512A3B6B);
        actor.player_rig.animname = actor.animname;
        actor.player_rig useanimtree(#animtree);
        actor.player_rig hide();
      } else {
        actor.player_rig = spawn("script_arms", actor.entity.origin, 0, 0, actor.entity);
        actor.player_rig.animname = actor.animname;
        actor.player_rig useanimtree(#animtree);
        actor.player_rig hide();
        actor.player_rig.entity = actor.entity;
      }

      scripts\common\anim::anim_first_frame_solo(actor.player_rig, anime, tag);
      actor.entity setstance(get_actor_stance(actor));
      actor.entity playerlinktoblend(actor.player_rig, "tag_player", blend_in_time, 0, 0, 1, 1, actor._id_FDFAF00190EFAF80);

      if(actor.disable_weapons)
        actor.entity _id_3B64EB40368C1450::set("anim_scene", "weapon", 0);
    }
  }
}

get_actor_stance(actor) {
  if(isDefined(actor.entity.anim_scene_stance_override))
    return actor.entity.anim_scene_stance_override;

  return "stand";
}

_anim_scene_internal_finish_blend(actors, blend_in_time, _id_AA3247C3C61F5E1C) {
  _id_119FF7E589190B4B = _id_AA3247C3C61F5E1C - blend_in_time;

  if(_id_119FF7E589190B4B > 0.0) {
    wait(blend_in_time);

    foreach(actor in actors) {
      if(actor.interrupted) {
        continue;
      }
      if(actor.is_player)
        actor.entity playerlinktodelta(actor.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, actor._id_FDFAF00190EFAF80);
    }

    wait(_id_119FF7E589190B4B);

    foreach(actor in actors) {
      if(actor.interrupted) {
        continue;
      }
      if(actor.is_player) {}
    }
  } else {
    wait(blend_in_time);

    foreach(actor in actors) {
      if(actor.interrupted) {
        continue;
      }
      if(actor.is_player)
        actor.entity playerlinktodelta(actor.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, actor._id_FDFAF00190EFAF80);
    }
  }
}

_anim_scene_internal_get_anim_duration(actor, anime) {
  _id_20D060C0D2EE7DE0 = 0.0;

  if(actor.is_player) {
    _id_A0B4BE40585BBDED = getanimlength(level.scr_anim[actor.player_rig.animname][anime]);

    if(_id_A0B4BE40585BBDED > _id_20D060C0D2EE7DE0)
      _id_20D060C0D2EE7DE0 = _id_A0B4BE40585BBDED;
  } else {
    _id_A0B4BE40585BBDED = getanimlength(level.scr_anim[actor.animname][anime]);

    if(_id_A0B4BE40585BBDED > _id_20D060C0D2EE7DE0)
      _id_20D060C0D2EE7DE0 = _id_A0B4BE40585BBDED;
  }

  return _id_20D060C0D2EE7DE0;
}

_anim_scene_internal_start_anims(actors, anime, _id_1208CA5973245D19, tag) {
  foreach(actor in actors) {
    if(actor.interrupted) {
      continue;
    }
    if(actor.is_player) {
      if(_id_1208CA5973245D19)
        actor.entity playanimscriptsceneevent("scripted_scene", level.scr_eventanim[actor.animname][anime][0]);
      else
        actor.entity playanimscriptsceneevent("scripted_scene", level.scr_eventanim[actor.animname][anime]);

      if(isDefined(level.scr_viewmodelanim[actor.animname]) && isDefined(level.scr_viewmodelanim[actor.animname][anime]) && !istrue(actor.entity.blockviewmodelanim)) {
        if(_id_1208CA5973245D19)
          actor.entity playviewmodelanim(level.scr_viewmodelanim[actor.animname][anime][0]);
        else
          actor.entity playviewmodelanim(level.scr_viewmodelanim[actor.animname][anime]);
      }

      if(actor.player_rig_visible && isDefined(actor.player_rig) && !actor.entity _meth_C1092F42B6BBE490())
        actor.player_rig showonlytoplayer(actor.entity);

      if(_id_1208CA5973245D19)
        thread scripts\common\anim::anim_loop_solo(actor.player_rig, anime, "stop_scene", tag);
      else
        thread scripts\common\anim::anim_single_solo(actor.player_rig, anime, tag);

      continue;
    }

    if(_id_1208CA5973245D19) {
      thread scripts\common\anim::anim_loop_solo(actor.entity, anime, "stop_scene", tag);
      continue;
    }

    thread scripts\common\anim::anim_single_solo(actor.entity, anime, tag);
  }
}

_anim_scene_internal_end(actors) {
  foreach(actor in actors) {
    if(actor.interrupted) {
      continue;
    }
    if(actor.is_player) {
      actor.entity _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("anim_scene");
      actor.entity unlink();
      actor.player_rig delete();
      actor.player_rig = undefined;
    }
  }
}

_anim_scene_ender_think(actors) {
  self endon("anim_scene_success");
  self endon("anim_scene_interrupted");
  self waittill("stop_scene");

  foreach(actor in actors)
  actor.endscene = 1;
}

_anim_scene_force_end_think(actors) {
  self endon("anim_scene_success");
  self endon("anim_scene_interrupted");
  self waittill("anim_scene_force_end");

  foreach(actor in actors)
  actor.forceendscene = 1;
}

_anim_scene_actor_end_interrupt_think(actor) {
  self endon("anim_scene_success");
  self endon("anim_scene_interrupted");
  wait(actor.animduration);

  if(!actor.interrupted)
    actor.endscene = 1;
}

_anim_scene_interrupt_think(actors, tag, _id_C502534A60E19429) {
  self endon("anim_scene_success");
  self endon("anim_scene_interrupted");

  for(;;) {
    interrupted = 0;

    for(;;) {
      wait 0.05;

      foreach(actor in actors) {
        if(actor.endscene || actor.forceendscene || !isDefined(actor.entity) || actor.is_player && !isalive(actor.entity) || actor.is_player && isDefined(actor.entity.fauxdead)) {
          if(!actor.interrupted) {
            interrupted = 1;
            break;
          }
        }
      }

      if(interrupted) {
        break;
      }
    }

    _id_C37D8D58474BE788 = 1;

    foreach(actor in actors) {
      _id_4C28ED808C01983C = 0;

      if(!isDefined(actor.entity) || actor.is_player && !isalive(actor.entity) || actor.is_player && isDefined(actor.entity.fauxdead))
        _id_4C28ED808C01983C = 1;

      if(!_id_4C28ED808C01983C && !actor.endscene && !actor.forceendscene && !actor.interruptable) {
        _id_C37D8D58474BE788 = 0;
        continue;
      }

      actor.interrupted = 1;

      if(_id_4C28ED808C01983C && !actor.is_player) {
        continue;
      }
      if(actor.is_player) {
        if((_id_C502534A60E19429 || actor.forceendscene) && !_id_4C28ED808C01983C) {
          actor.entity _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("anim_scene");
          actor.entity stopanimscriptsceneevent();
          actor.entity unlink();
          actor.entity setOrigin(actor.entity.origin + (0, 0, 1));
        }

        if(_id_C502534A60E19429 || actor.forceendscene || _id_4C28ED808C01983C) {
          if(isent(actor.player_rig)) {
            actor.player_rig delete();
            actor.player_rig = undefined;
          }
        }

        continue;
      }

      if(isDefined(actor.interrupt_anime)) {
        if(actor.interrupt_first_frame)
          thread scripts\common\anim::anim_first_frame_solo(actor.entity, actor.interrupt_anime, tag);
        else {
          actor.entity stopanimScripted();
          thread scripts\common\anim::anim_single_solo(actor.entity, actor.interrupt_anime, tag);
        }

        continue;
      }

      actor.entity stopanimScripted();

      if(scripts\engine\utility::is_equal(actor.entity.classname, "script_model") || scripts\engine\utility::is_equal(actor.entity.code_classname, "script_model"))
        actor.entity scriptmodelclearanim();
    }

    if(_id_C37D8D58474BE788) {
      self notify("anim_scene_interrupted");
      return;
    }
  }
}