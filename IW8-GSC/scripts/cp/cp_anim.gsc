/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_anim.gsc
***********************************************/

function init() {
  scripts\common\anim::initanim();

  if(!isDefined(level.scr_viewmodelanim)) {
    level.scr_viewmodelanim = [];
  }

  if(!isDefined(level.scr_eventanim)) {
    level.scr_eventanim = [];
  }

  anim.callbacks["PlaySoundAtViewHeight"] = &play_sound_at_viewheight;
  anim.callbacks["TeleportEnt"] = &teleport_entity;
  anim.callbacks["ShouldDoAnim"] = &should_do_anim;
  anim.callbacks["DoAnimation"] = &do_animation;
  anim.callbacks["DoFacialAnim"] = &do_facial_anim;
  anim.callbacks["AnimHandleNotetrack"] = &mp_anim_handle_notetrack;
  anim.callbacks["EntityHandleNotetrack"] = &mp_entity_handle_notetrack;
  anim.callbacks["AIAnimFirstFrame"] = undefined;
}

function play_sound_at_viewheight(var_0, var_1, var_2) {
  self playSound(var_0, var_1, var_2);
}

function should_do_anim() {
  return true;
}

function teleport_entity(var_0, var_1) {
  if(self.code_classname == "script_vehicle") {
    self vehicle_teleport(var_0, var_1);
    self dontinterpolate();
    return;
  }

  if(isPlayer(self)) {
    self setOrigin(var_0);
    self setplayerangles(var_1);
    return;
  }

  self.origin = var_0;
  self.angles = var_1;
  self dontinterpolate();
}

function do_facial_anim(var_0, var_1, var_2, var_3, var_4, var_5) {
  return false;
}

function do_animation(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(isDefined(var_5)) {
    var_6 = level.scr_anim[var_2][var_3][var_5];
  } else {
    var_6 = level.scr_anim[var_2][var_3];
  }

  var_7 = scripts\common\anim::anim_get_goal_time(var_2, var_3);
  scripts\common\anim::last_anim_time_check();

  if(!isDefined(var_5)) {
    self._lastanime = var_3;
  }

  if(self.code_classname == "misc_turret" && !isDefined(var_5)) {
    self setflaggedanim(var_4, var_6, 1, var_7);
  } else {
    if(self.code_classname == "script_vehicle") {
      self vehicleplayanim(var_6);
    }

    var_8 = undefined;

    if(isDefined(self.anim_getrootfunc)) {
      var_8 = [[self.anim_getrootfunc]]();
    }

    var_9 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, (0, 0, 0));
    self animScripted(var_4, var_0, var_9, var_6, undefined, var_8, var_7);
  }

  thread scripts\common\notetrack::start_notetrack_wait(self, var_4, var_3, var_2, var_6);
  return getanimlength(var_6);
}

function mp_anim_handle_notetrack(var_0, var_1, var_2, var_3) {
  scripts\common\notetrack::anim_handle_notetrack(var_0, var_1, var_2, var_3);

  if(isDefined(var_0["flag"])) {
    scripts\mp\flags::gameflagset(var_0["flag"]);
  }

  if(isDefined(var_0["flag_clear"])) {
    scripts\mp\flags::gameflagclear(var_0["flag_clear"]);
  }

  if(isDefined(var_0["sound"])) {
    var_4 = undefined;

    if(!isDefined(var_0["sound_stays_death"])) {
      var_4 = 1;
    }

    var_5 = undefined;

    if(isDefined(var_0["sound_on_tag"])) {
      var_5 = var_0["sound_on_tag"];
    }

    thread play_snd_on_tag(var_1, var_0["sound"]);
    return;
  }
}

function mp_entity_handle_notetrack(var_0, var_1) {
  if(mp_notetrack_prefix_handler(var_0, var_1)) {
    return;
  }
}

function mp_notetrack_prefix_handler(var_0) {
  var_1 = getsubstr(var_0, 0, 3);

  if(var_1 == "as_") {
    var_2 = getsubstr(var_0, 3);

    if(isDefined(self.anim_playsound_func)) {
      self thread[[self.anim_playsound_func]](var_2);
    }

    return true;
  }

  if(var_2 == "vm_") {
    var_3 = getsubstr(var_1, 3);

    if(isDefined(self.anim_playvm_func)) {
      self thread[[self.anim_playvm_func]](var_3);
    }

    return true;
  }

  if(var_3 == "ws_") {
    var_4 = getsubstr(var_2, 3);

    if(isDefined(self.weapon_state_func)) {
      self thread[[self.weapon_state_func]](var_4);
    }

    return true;
  }

  if(var_4 == "cm_") {
    var_5 = getsubstr(var_3, 3);

    if(isDefined(self.cinematic_motion_override)) {
      self thread[[self.cinematic_motion_override]](var_5);
    }

    return true;
  }

  if(var_5 == "df_") {
    var_6 = getsubstr(var_4, 3);

    if(isDefined(self.dof_func)) {
      self thread[[self.dof_func]](var_6);
    }

    return true;
  }

  return false;
}

function anim_player_solo(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  GscBinSkip1(0x45, 0, var_0);
}

function anim_player(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  anim_player_internal(var_0, var_1, var_2, var_3, var_4, var_5);
}

function anim_player_internal(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0;

  foreach(var_8 in var_0) {
    var_9 = undefined;

    if(isDefined(var_5)) {
      var_9 = var_5;
    } else {
      var_9 = var_8.animname;
    }

    if(isDefined(level.scr_eventanim[var_9]) && isDefined(level.scr_eventanim[var_9][var_2])) {
      var_6 = var_8 playanimscriptsceneevent("scripted_scene", level.scr_eventanim[var_9][var_2]);
    }

    if(isDefined(level.scr_viewmodelanim[var_9]) && isDefined(level.scr_viewmodelanim[var_9][var_2]) && !istrue(var_8.blockviewmodelanim)) {
      var_8 playviewmodelanim(level.scr_viewmodelanim[var_9][var_2]);
    }
  }

  if(isDefined(var_1)) {
    scripts\common\anim::anim_single(var_1, var_2, var_3, var_4, var_5);
    return;
  }
}

function play_snd_on_tag(var_0, var_1) {
  if(isDefined(var_1)) {
    playsoundatpos(self gettagorigin(var_1), var_0);
    return;
  }

  playsoundatpos(self.origin, var_0);
}