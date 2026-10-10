/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\mp\anim.gsc
***********************************************/

#using scripts\anim\face;
#using scripts\anim\notetracks;
#using scripts\anim\notetracks_mp;
#using scripts\asm\shared\mp\utility;
#using scripts\common\anim;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace anim_mp;

function init() {
  initanim();

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
  anim.callbacks["reach_with_standard_adjustments_begin"] = &function_b9c0db166bfa05de;
  anim.callbacks["reach_with_standard_adjustments_end"] = &function_4e8646c3e9f9ec0a;
  anim.callbacks["AnimHandleNotetrack"] = &mp_anim_handle_notetrack;
  anim.callbacks["EntityHandleNotetrack"] = &mp_entity_handle_notetrack;
  anim.callbacks["EntityHandleNotetrackAnimEnd"] = &scripts\anim\notetracks::function_8b5c774e7238fec5;
  anim.callbacks["AIAnimFirstFrame"] = &scripts\asm\shared\mp\utility::ai_anim_first_frame;
  anim.callbacks["playXcam"] = &play_xcam;
}

function play_sound_at_viewheight(aliasname, notification_string, var_a68adbd3eefe9282) {
  self playSound(aliasname);
}

function should_do_anim() {
  return true;
}

function teleport_entity(origin, angles) {
  if(self.code_classname == "script_vehicle") {
    if(!function_c606ca98a77e09ca()) {
      self.origin = origin;
      self.angles = angles;
      self dontinterpolate();
    } else {
      self vehicle_teleport(origin, angles);
      self dontinterpolate();
    }

    return;
  }

  if(isPlayer(self)) {
    self setOrigin(origin);
    self setplayerangles(angles);
    return;
  }

  self.origin = origin;
  self.angles = angles;
  self dontinterpolate();
}

function function_c606ca98a77e09ca() {
  canteleport = 1;

  if(isDefined(self.vehiclename)) {
    switch (self.vehiclename) {
      case #"hash_2289ec11d77bce8f":
      case #"hash_56979e0566996b2e":
      case #"hash_d849f9d4eaa9ed93":
        canteleport = 0;
        break;
    }
  }

  return canteleport;
}

function do_facial_anim(dofacialanim, var_9ac73a1996d2dae, doanimation, anime, animname, dialogue) {
  return false;
}

function do_animation(org, angles, animname, anime, anim_string, idleanim, scripted_node_ent) {
  var_173bdb8ba434651d = 0;
  animation = undefined;

  if(isDefined(idleanim) && !isagent(self)) {
    animation = level.scr_anim[animname][anime][idleanim];
  } else {
    animation = level.scr_anim[animname][anime];
  }

  goaltime = anim_get_goal_time(animname, anime);
  last_anim_time_check();

  if(!isDefined(idleanim)) {
    self._lastanime = anime;
  }

  if(self.code_classname == "misc_turret" && !isDefined(idleanim)) {
    self setflaggedanim(anim_string, animation, 1, goaltime);
  } else {
    if(self.code_classname == "script_vehicle") {
      self vehicleplayanim(animation);
    }

    root = undefined;

    if(isDefined(self.anim_getrootfunc)) {
      root = [[self.anim_getrootfunc]]();
    }

    if(isagent(self)) {
      var_173bdb8ba434651d = 1;
      level_archetype = "agent_scripted_" + getDvar(@ "g_mapname");

      if(archetypeassetloaded(level_archetype)) {
        scripted_node = spawnStruct();

        if(isDefined(org)) {
          scripted_node.origin = org;
          scripted_node.angles = angles;
        }

        var_5a0a7dfb51da0682 = getanimname(animation);
        thread scripts\asm\shared\mp\utility::animscriptmp(level_archetype, "animscripted", var_5a0a7dfb51da0682, undefined, undefined, undefined, scripted_node);
      } else {
        thread scripts\asm\shared\mp\utility::animscriptedagent(anime, anim_string, org, angles);
      }
    } else {
      animmode = undefined;

      if(istrue(self.backwards)) {
        animmode = "backwards";
      }

      self animScripted(anim_string, org, angles, animation, animmode, root, goaltime);
    }
  }

  thread start_notetrack_wait(self, anim_string, anime, animname, animation, var_173bdb8ba434651d);
  return getanimlength(animation);
}

function mp_anim_handle_notetrack(scr_notetrack, guy, var_966821fc90c3ca9d, tag_owner) {
  anim_handle_notetrack(scr_notetrack, guy, var_966821fc90c3ca9d, tag_owner);

  if(isDefined(scr_notetrack["flag"])) {
    if(issharedfuncdefined("game", "gameflagSet")) {
      [[getsharedfunc("game", "gameflagSet")]](scr_notetrack["flag"]);
    }
  }

  if(isDefined(scr_notetrack["flag_clear"])) {
    if(issharedfuncdefined("game", "gameflagClear")) {
      [[getsharedfunc("game", "gameflagClear")]](scr_notetrack["flag_clear"]);
    }
  }

  if(isDefined(scr_notetrack["sound"])) {
    var_a38dc1947e93b08d = undefined;

    if(!isDefined(scr_notetrack["sound_stays_death"])) {
      var_a38dc1947e93b08d = 1;
    }

    tag = undefined;

    if(isDefined(scr_notetrack["sound_on_tag"])) {
      tag = scr_notetrack["sound_on_tag"];
    }

    if(issharedfuncdefined("game", "gameflagClear")) {
      guy thread[[getsharedfunc("sound", "playSoundOnTag")]](scr_notetrack["sound"], tag);
    }
  }
}

function mp_entity_handle_notetrack(guy, notetrack) {
  if(guy scripts\anim\notetracks_mp::function_6d9ff7d18e45dc9c(notetrack)) {
    return;
  }
}

function anim_player_solo(player, player_rig, anime, tag, var_9e8a16d47a03007a, animname_override) {
  self endon("death");
  players[0] = player;
  player_rigs[0] = player_rig;

  if(!isDefined(var_9e8a16d47a03007a)) {
    var_9e8a16d47a03007a = 0;
  }

  anim_player(players, player_rigs, anime, tag, var_9e8a16d47a03007a, animname_override);
}

function anim_player(players, player_rigs, anime, tag, var_9e8a16d47a03007a, animname_override) {
  if(!isDefined(var_9e8a16d47a03007a)) {
    var_9e8a16d47a03007a = 0;
  }

  anim_player_internal(players, player_rigs, anime, tag, var_9e8a16d47a03007a, animname_override);
}

function anim_player_internal(players, player_rigs, anime, tag, var_9e8a16d47a03007a, animname_override) {
  duration = 0;

  foreach(player in players) {
    animname = undefined;

    if(isDefined(animname_override)) {
      animname = animname_override;
    } else {
      animname = player.animname;
    }

    if(isDefined(level.scr_eventanim[animname]) && isDefined(level.scr_eventanim[animname][anime])) {
      duration = player playanimscriptsceneevent("scripted_scene", level.scr_eventanim[animname][anime]);
    }

    if(isDefined(level.scr_viewmodelanim[animname]) && isDefined(level.scr_viewmodelanim[animname][anime]) && !istrue(player.blockviewmodelanim)) {
      player playviewmodelanim(level.scr_viewmodelanim[animname][anime]);
    }
  }

  if(isDefined(player_rigs)) {
    anim_single(player_rigs, anime, tag, var_9e8a16d47a03007a, animname_override);
  }
}

function play_xcam(xcamasset, origin, angles) {
  camnum = undefined;
  camnum = default_to(camnum, 0);

  foreach(player in level.players) {
    player playxcam(xcamasset, camnum, origin, angles);
  }

  wait getxcamlength(xcamasset);
}

function function_3c8f0102ea5254f3(framecount) {
  frametime = 0.0333333 * framecount;

  if(frametime <= 0) {
    println("<dev string:x1c>" + frametime + "<dev string:x33>");
    return;
  }

  wait frametime;
}

function function_b9c0db166bfa05de(startorg, startangles) {
  self.oldgoalradius = self.goalradius;
  self.oldpathenemyfightdist = self.pathenemyfightdist;
  self.oldpathenemylookahead = self.pathenemylookahead;
  self.pathenemyfightdist = 0;
  self.pathenemylookahead = 128;
  self pushplayer(1);
  self.nododgemove = 1;
  self.doavoidanceblocking = 0;
  self.fixednodewason = self.fixednode;
  self.fixednode = 0;
  self.var_a4700673c6ef6c4 = self.var_b29c3655b12e292d;
  self.var_b29c3655b12e292d = 0;
  self.ignoreall = 1;

  if(!isDefined(self.scriptedarrivalent)) {
    self.old_disablearrivals = self.disablearrivals;
    self.disablearrivals = 1;
  } else {
    self.scriptedarrivalent.angles = startangles;
    self.scriptedarrivalent.origin = startorg;
  }

  self.reach_goal_pos = undefined;
  return startorg;
}

function function_4e8646c3e9f9ec0a() {
  self pushplayer(0);
  self.nododgemove = 0;
  self.doavoidanceblocking = 1;
  self.fixednode = self.fixednodewason;
  self.fixednodewason = undefined;
  self.var_b29c3655b12e292d = self.var_a4700673c6ef6c4;
  self.var_a4700673c6ef6c4 = undefined;
  self.pathenemyfightdist = self.oldpathenemyfightdist;
  self.pathenemylookahead = self.oldpathenemylookahead;
  self.ignoreall = 0;

  if(isDefined(self.old_disablearrivals)) {
    self.disablearrivals = self.old_disablearrivals;
  }
}