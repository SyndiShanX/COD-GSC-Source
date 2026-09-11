/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\anim.gsc
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

function play_sound_at_viewheight(var0, var1, var2) {
  self playSound(var0);
}

function should_do_anim() {
  return true;
}

function teleport_entity(var0, var1) {
  if(self.code_classname == "script_vehicle") {
    self vehicle_teleport(var0, var1);
    self dontinterpolate();
    return;
  }

  if(isPlayer(self)) {
    self setOrigin(var0);
    self setplayerangles(var1);
    return;
  }

  self.origin = var0;
  self.angles = var1;
  self dontinterpolate();
}

function do_facial_anim(var0, var1, var2, var3, var4, var5) {
  return false;
}

function do_animation(var0, var1, var2, var3, var4, var5) {
  var6 = undefined;

  if(isDefined(var5)) {
    var6 = level.scr_anim[var2][var3][var5];
  } else {
    var6 = level.scr_anim[var2][var3];
  }

  var7 = scripts\common\anim::anim_get_goal_time(var2, var3);
  scripts\common\anim::last_anim_time_check();

  if(!isDefined(var5)) {
    self._lastanime = var3;
  }

  if(self.code_classname == "misc_turret" && !isDefined(var5)) {
    self setflaggedanim(var4, var6, 1, var7);
  } else {
    if(self.code_classname == "script_vehicle") {
      self vehicleplayanim(var6);
    }

    var8 = undefined;

    if(isDefined(self.anim_getrootfunc)) {
      var8 = [[self.anim_getrootfunc]]();
    }

    self animScripted(var4, var0, var1, var6, undefined, var8, var7);
  }

  thread scripts\common\notetrack::start_notetrack_wait(self, var4, var3, var2, var6);
  return getanimlength(var6);
}

function mp_anim_handle_notetrack(var0, var1, var2, var3) {
  scripts\common\notetrack::anim_handle_notetrack(var0, var1, var2, var3);

  if(isDefined(var0["flag"])) {
    scripts\mp\flags::gameflagset(var0["flag"]);
  }

  if(isDefined(var0["flag_clear"])) {
    scripts\mp\flags::gameflagclear(var0["flag_clear"]);
  }

  if(isDefined(var0["sound"])) {
    var4 = undefined;

    if(!isDefined(var0["sound_stays_death"])) {
      var4 = 1;
    }

    var5 = undefined;

    if(isDefined(var0["sound_on_tag"])) {
      var5 = var0["sound_on_tag"];
    }

    var1 thread scripts\mp\utility\sound::play_sound_on_tag(var0["sound"], var5);
    return;
  }
}

function mp_entity_handle_notetrack(var0, var1) {
  if(mp_notetrack_prefix_handler(var0, var1)) {
    return;
  }
}

function mp_notetrack_prefix_handler(var0) {
  var1 = getsubstr(var0, 0, 3);

  if(var1 == "as_") {
    var2 = getsubstr(var0, 3);

    if(isDefined(self.anim_playsound_func)) {
      self thread[[self.anim_playsound_func]](var2);
    }

    return true;
  }

  if(var2 == "vm_") {
    var3 = getsubstr(var1, 3);

    if(isDefined(self.anim_playvm_func)) {
      self thread[[self.anim_playvm_func]](var3);
    }

    return true;
  }

  if(var3 == "ws_") {
    var4 = getsubstr(var2, 3);

    if(isDefined(self.weapon_state_func)) {
      self thread[[self.weapon_state_func]](var4);
    }

    return true;
  }

  if(var4 == "cm_") {
    var5 = getsubstr(var3, 3);

    if(isDefined(self.cinematic_motion_override)) {
      self thread[[self.cinematic_motion_override]](var5);
    }

    return true;
  }

  if(var5 == "df_") {
    var6 = getsubstr(var4, 3);

    if(isDefined(self.dof_func)) {
      self thread[[self.dof_func]](var6);
    }

    return true;
  }

  return false;
}

function anim_player_solo(var0, var1, var2, var3, var4, var5) {
  self endon("death");
  GscBinSkip1(0x45, 0, var0);
}

function anim_player(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var4)) {
    var4 = 0;
  }

  anim_player_internal(var0, var1, var2, var3, var4, var5);
}

function anim_player_internal(var0, var1, var2, var3, var4, var5) {
  var6 = 0;

  foreach(var8 in var0) {
    var9 = undefined;

    if(isDefined(var5)) {
      var9 = var5;
    } else {
      var9 = var8.animname;
    }

    if(isDefined(level.scr_eventanim[var9]) && isDefined(level.scr_eventanim[var9][var2])) {
      var6 = var8 playanimscriptsceneevent("scripted_scene", level.scr_eventanim[var9][var2]);
    }

    if(isDefined(level.scr_viewmodelanim[var9]) && isDefined(level.scr_viewmodelanim[var9][var2]) && !istrue(var8.blockviewmodelanim)) {
      var8 playviewmodelanim(level.scr_viewmodelanim[var9][var2]);
    }
  }

  if(isDefined(var1)) {
    scripts\common\anim::anim_single(var1, var2, var3, var4, var5);
    return;
  }
}