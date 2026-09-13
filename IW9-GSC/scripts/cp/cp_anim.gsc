/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_anim.gsc
***********************************************/

init() {
  scripts\common\anim::initanim();

  if(!isDefined(level.scr_viewmodelanim))
    level.scr_viewmodelanim = [];

  if(!isDefined(level.scr_eventanim))
    level.scr_eventanim = [];

  anim.callbacks["PlaySoundAtViewHeight"] = ::play_sound_at_viewheight;
  anim.callbacks["TeleportEnt"] = ::teleport_entity;
  anim.callbacks["ShouldDoAnim"] = ::should_do_anim;
  anim.callbacks["DoAnimation"] = ::do_animation;
  anim.callbacks["DoFacialAnim"] = ::do_facial_anim;
  anim.callbacks["AnimHandleNotetrack"] = ::mp_anim_handle_notetrack;
  anim.callbacks["EntityHandleNotetrack"] = ::mp_entity_handle_notetrack;
  anim.callbacks["AIAnimFirstFrame"] = undefined;
}

play_sound_at_viewheight(aliasname, _id_B1A4E9FA39B3858A, _id_A68ADBD3EEFE9282) {
  self playSound(aliasname, _id_B1A4E9FA39B3858A, _id_A68ADBD3EEFE9282);
}

should_do_anim() {
  return 1;
}

teleport_entity(origin, angles) {
  if(self.code_classname == "script_vehicle") {
    self vehicle_teleport(origin, angles);
    self dontinterpolate();
  } else if(isPlayer(self)) {
    self setOrigin(origin);
    self setplayerangles(angles);
  } else {
    self.origin = origin;
    self.angles = angles;
    self dontinterpolate();
  }
}

do_facial_anim(_id_63A1F320F9C2DDF5, _id_09AC73A1996D2DAE, _id_83D9EFDEA230AF8E, anime, animname, dialogue) {
  return 0;
}

do_animation(org, angles, animname, anime, _id_314C4455B996B224, idleanim, _id_43E50904D011917E) {
  animation = undefined;

  if(isDefined(idleanim) && !isagent(self))
    animation = level.scr_anim[animname][anime][idleanim];
  else
    animation = level.scr_anim[animname][anime];

  goaltime = scripts\common\anim::anim_get_goal_time(animname, anime);
  scripts\common\anim::last_anim_time_check();

  if(!isDefined(idleanim))
    self._lastanime = anime;

  if(self.code_classname == "misc_turret" && !isDefined(idleanim))
    self setflaggedanim(_id_314C4455B996B224, animation, 1, goaltime);
  else {
    if(self.code_classname == "script_vehicle")
      self vehicleplayanim(animation);

    root = undefined;

    if(isDefined(self.anim_getrootfunc))
      root = [[self.anim_getrootfunc]]();

    _id_8C94765CA587F86C = scripts\engine\utility::ter_op(isDefined(angles), angles, (0, 0, 0));

    if(isagent(self))
      thread scripts\asm\shared\mp\utility::_id_577D8ABFF6067C23(anime, _id_314C4455B996B224, org, _id_8C94765CA587F86C);
    else
      self animScripted(_id_314C4455B996B224, org, _id_8C94765CA587F86C, animation, undefined, root, goaltime);
  }

  thread scripts\common\notetrack::start_notetrack_wait(self, _id_314C4455B996B224, anime, animname, animation);
  return getanimlength(animation);
}

mp_anim_handle_notetrack(scr_notetrack, guy, _id_966821FC90C3CA9D, _id_F20E2B3859E05E9F) {
  scripts\common\notetrack::anim_handle_notetrack(scr_notetrack, guy, _id_966821FC90C3CA9D, _id_F20E2B3859E05E9F);

  if(isDefined(scr_notetrack["flag"]))
    scripts\mp\flags::gameflagset(scr_notetrack["flag"]);

  if(isDefined(scr_notetrack["flag_clear"]))
    scripts\mp\flags::gameflagclear(scr_notetrack["flag_clear"]);

  if(isDefined(scr_notetrack["sound"])) {
    _id_A38DC1947E93B08D = undefined;

    if(!isDefined(scr_notetrack["sound_stays_death"]))
      _id_A38DC1947E93B08D = 1;

    tag = undefined;

    if(isDefined(scr_notetrack["sound_on_tag"]))
      tag = scr_notetrack["sound_on_tag"];

    guy thread play_snd_on_tag(scr_notetrack["sound"], tag);
  }
}

mp_entity_handle_notetrack(guy, notetrack) {
  if(guy mp_notetrack_prefix_handler(notetrack))
    return;
}

mp_notetrack_prefix_handler(notetrack) {
  _id_DEC9BCCE93873125 = getsubstr(notetrack, 0, 3);

  if(_id_DEC9BCCE93873125 == "as_") {
    alias = getsubstr(notetrack, 3);

    if(isDefined(self.anim_playsound_func))
      self thread[[self.anim_playsound_func]](alias);

    return 1;
  }

  if(_id_DEC9BCCE93873125 == "vm_") {
    animation = getsubstr(notetrack, 3);

    if(isDefined(self.anim_playvm_func))
      self thread[[self.anim_playvm_func]](animation);

    return 1;
  }

  if(_id_DEC9BCCE93873125 == "ws_") {
    state = getsubstr(notetrack, 3);

    if(isDefined(self.weapon_state_func))
      self thread[[self.weapon_state_func]](state);

    return 1;
  }

  if(_id_DEC9BCCE93873125 == "cm_") {
    _id_D8958445ED7AB829 = getsubstr(notetrack, 3);

    if(isDefined(self.cinematic_motion_override))
      self thread[[self.cinematic_motion_override]](_id_D8958445ED7AB829);

    return 1;
  }

  if(_id_DEC9BCCE93873125 == "df_") {
    _id_02C300A0C859AA22 = getsubstr(notetrack, 3);

    if(isDefined(self.dof_func))
      self thread[[self.dof_func]](_id_02C300A0C859AA22);

    return 1;
  }

  return 0;
}

anim_player_solo(player, player_rig, anime, tag, _id_9E8A16D47A03007A, _id_8E3B87ACAAD3DE58) {
  self endon("death");
  players[0] = player;
  player_rigs[0] = player_rig;

  if(!isDefined(_id_9E8A16D47A03007A))
    _id_9E8A16D47A03007A = 0;

  anim_player(players, player_rigs, anime, tag, _id_9E8A16D47A03007A, _id_8E3B87ACAAD3DE58);
}

anim_player(players, player_rigs, anime, tag, _id_9E8A16D47A03007A, _id_8E3B87ACAAD3DE58) {
  if(!isDefined(_id_9E8A16D47A03007A))
    _id_9E8A16D47A03007A = 0;

  anim_player_internal(players, player_rigs, anime, tag, _id_9E8A16D47A03007A, _id_8E3B87ACAAD3DE58);
}

anim_player_internal(players, player_rigs, anime, tag, _id_9E8A16D47A03007A, _id_8E3B87ACAAD3DE58) {
  duration = 0;

  foreach(player in players) {
    animname = undefined;

    if(isDefined(_id_8E3B87ACAAD3DE58))
      animname = _id_8E3B87ACAAD3DE58;
    else
      animname = player.animname;

    if(isDefined(level.scr_eventanim[animname]) && isDefined(level.scr_eventanim[animname][anime]))
      duration = player playanimscriptsceneevent("scripted_scene", level.scr_eventanim[animname][anime]);

    if(isDefined(level.scr_viewmodelanim[animname]) && isDefined(level.scr_viewmodelanim[animname][anime]) && !istrue(player.blockviewmodelanim))
      player playviewmodelanim(level.scr_viewmodelanim[animname][anime]);
  }

  if(isDefined(player_rigs))
    scripts\common\anim::anim_single(player_rigs, anime, tag, _id_9E8A16D47A03007A, _id_8E3B87ACAAD3DE58);
}

play_snd_on_tag(alias, tag) {
  if(isDefined(tag))
    playsoundatpos(self gettagorigin(tag), alias);
  else
    playsoundatpos(self.origin, alias);
}