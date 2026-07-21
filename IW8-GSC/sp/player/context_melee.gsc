/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\player\context_melee.gsc
***********************************************/

main() {
  if(istrue(level.context_melee_enabled)) {
    return;
  }
  if(!isDefined(level.context_melee_has_been_enabled))
    level.context_melee_has_been_enabled = 0;

  if(!isDefined(level.context_melee_enabled))
    level.context_melee_enabled = 1;

  setdvarifuninitialized("context_melee_silent", 1);
  setdvarifuninitialized("context_melee_blocked_hints", 0);
  setdvarifuninitialized("context_melee_use_cursor_hint", 0);

  if(!level.context_melee_has_been_enabled)
    precache();

  level.player thread enable_dynamic_takedowns();
  level.context_melee_has_been_enabled = 1;
  print_debug("context_melee enabled: " + gettime());
}

precache() {
  level.context_melee_lastframe_bone = "tag_player";
  level.context_melee_player_link_bone = "tag_player";
  level.context_melee_lastframe_type = "player_capsule";
  level.context_melee_sight_disabled = 0;
  level._effect["vfx_contextmelee_stab"] = loadfx("vfx/iw8/weap/_knife/vfx_contextmele_neckstab_med_ch2.vfx ");

  if(!getdvarint("context_melee_use_cursor_hint")) {
    scripts\engine\sp\utility::add_hint_string("context_melee_silent", &"CONTEXT_MELEE/SILENT_KILL", ::context_melee_hint_break);
    scripts\engine\sp\utility::add_hint_string("context_melee_stealth", &"CONTEXT_MELEE/STEALTH_KILL", ::context_melee_hint_break);
    scripts\engine\sp\utility::add_hint_string("context_melee_blocked", &"CONTEXT_MELEE/BLOCKED", ::context_melee_hint_fail);
    scripts\engine\sp\utility::add_hint_string("context_melee_scripted_fail", &"CONTEXT_MELEE/SCRIPTED_FAIL", ::context_melee_hint_scripted_fail);
    scripts\engine\sp\utility::add_hint_string("context_melee_scripted_noweap", &"CONTEXT_MELEE/SCRIPTED_NOWEAP", ::context_melee_hint_scripted_noweap);
  }

  precachemodel("weapon_vm_me_soscar_knife");
  precachemodel("axis_guide_simple");
  dynamic_knife_anims();
}

play_sound_safe(var_0) {
  if(!soundexists(var_0)) {
    return;
  }
  self playSound(var_0);
  return;
}

dynamic_knife_anims() {
  scripts\engine\utility::flag_init("hold_context_melee");
  dynamic_knife_kill_anims();
  dynamic_knife_kill_anims_player();
}

#using_animtree("generic_human");

dynamic_knife_kill_anims() {
  var_0 = [];
  var_0["context_melee_kill_01_back"] = % vm_sp_context_melee_stand_1_rear_enemy;
  var_0["context_melee_kill_01_left"] = % vm_sp_context_melee_stand_1_left_enemy;
  var_0["context_melee_kill_01_right"] = % vm_sp_context_melee_stand_1_right_enemy;
  var_0["context_melee_kill_01_front"] = % vm_sp_context_melee_stand_1_front_enemy;
  var_0["context_melee_kill_02_back"] = % vm_sp_context_melee_stand_2_rear_enemy;
  var_0["context_melee_kill_02_left"] = % vm_sp_context_melee_stand_2_left_enemy;
  var_0["context_melee_kill_02_right"] = % vm_sp_context_melee_stand_2_right_enemy;
  var_0["context_melee_kill_02_front"] = % vm_sp_context_melee_stand_2_front_enemy;

  foreach(var_3, var_2 in var_0) {
    level.scr_anim["generic"][var_3] = var_2;
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_death", ::context_melee_death, var_3);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_ragdoll", ::context_melee_ragdoll, var_3);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_fx", ::context_melee_fx, var_3);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_sfx", ::context_melee_sfx, var_3);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_rumble_light", ::context_melee_rumble_light, var_3);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_rumble_heavy", ::context_melee_rumble_heavy, var_3);
  }
}

#using_animtree("player");

dynamic_knife_kill_anims_player() {
  level.scr_animtree["context_melee_player_rig"] = #animtree;

  if(!isDefined(level.scr_model) || !isDefined(level.scr_model["context_melee_player_rig"]))
    level.scr_model["context_melee_player_rig"] = "viewhands_base_iw8";

  level.scr_anim["context_melee_player_rig"]["context_melee_kill_01_back"] = % vm_sp_context_melee_stand_1_rear_player;
  level.scr_anim["context_melee_player_rig"]["context_melee_kill_01_left"] = % vm_sp_context_melee_stand_1_left_player;
  level.scr_anim["context_melee_player_rig"]["context_melee_kill_01_right"] = % vm_sp_context_melee_stand_1_right_player;
  level.scr_anim["context_melee_player_rig"]["context_melee_kill_01_front"] = % vm_sp_context_melee_stand_1_front_player;
  scripts\common\anim::addnotetrack_customfunction("context_melee_player_rig", "cm_sfx_player", ::context_melee_sfx_player, "context_melee_kill_01_back");
  scripts\common\anim::addnotetrack_customfunction("context_melee_player_rig", "cm_sfx_player", ::context_melee_sfx_player, "context_melee_kill_01_left");
  scripts\common\anim::addnotetrack_customfunction("context_melee_player_rig", "cm_sfx_player", ::context_melee_sfx_player, "context_melee_kill_01_right");
  scripts\common\anim::addnotetrack_customfunction("context_melee_player_rig", "cm_sfx_player", ::context_melee_sfx_player, "context_melee_kill_01_front");
  level.scr_anim["context_melee_player_rig"]["context_melee_kill_02_back"] = % vm_sp_context_melee_stand_2_rear_player;
  level.scr_anim["context_melee_player_rig"]["context_melee_kill_02_left"] = % vm_sp_context_melee_stand_2_left_player;
  level.scr_anim["context_melee_player_rig"]["context_melee_kill_02_right"] = % vm_sp_context_melee_stand_2_right_player;
  level.scr_anim["context_melee_player_rig"]["context_melee_kill_02_front"] = % vm_sp_context_melee_stand_2_front_player;
  scripts\common\anim::addnotetrack_customfunction("context_melee_player_rig", "cm_sfx_player", ::context_melee_sfx_player, "context_melee_kill_02_back");
  scripts\common\anim::addnotetrack_customfunction("context_melee_player_rig", "cm_sfx_player", ::context_melee_sfx_player, "context_melee_kill_02_left");
  scripts\common\anim::addnotetrack_customfunction("context_melee_player_rig", "cm_sfx_player", ::context_melee_sfx_player, "context_melee_kill_02_right");
  scripts\common\anim::addnotetrack_customfunction("context_melee_player_rig", "cm_sfx_player", ::context_melee_sfx_player, "context_melee_kill_02_front");
}

context_melee_hint_break() {
  if(!isDefined(level.player.context_melee_victim))
    return 1;

  if(!isDefined(level.player.context_melee_hint))
    return 1;

  if(isDefined(level.player.context_melee_allow_directions) && isDefined(level.player.context_melee_direction)) {
    if(!scripts\engine\utility::array_contains(level.player.context_melee_allow_directions, level.player.context_melee_direction))
      return 1;
  }

  return istrue(level.player.context_melee_victim.in_melee_death);
}

context_melee_hint_fail() {
  if(!getdvarint("context_melee_blocked_hints"))
    return 1;

  if(context_melee_hint_not_allowed())
    return 1;

  if(!isDefined(level.player.context_melee_has_enemy))
    return 1;

  return 0;
}

context_melee_hint_scripted_fail() {
  if(!getdvarint("context_melee_blocked_hints"))
    return 1;

  if(context_melee_hint_not_allowed())
    return 1;

  if(!isDefined(level.player.context_melee_scripted_enemy_guess))
    return 1;

  if(!is_enemy_onscreen(level.player.context_melee_scripted_enemy_guess))
    return 1;

  return 0;
}

context_melee_hint_scripted_noweap() {
  if(!getdvarint("context_melee_blocked_hints"))
    return 1;

  if(context_melee_hint_not_allowed())
    return 1;

  if(!isDefined(level.player.context_melee_scripted_enemy_guess))
    return 1;

  if(!is_enemy_onscreen(level.player.context_melee_scripted_enemy_guess))
    return 1;

  return 0;
}

context_melee_hint_not_allowed() {
  if(!isDefined(level.player.context_melee_hint))
    return 1;

  if(level.player getstance() == "prone")
    return 1;

  if(isDefined(level.player.context_melee_allow_directions) && isDefined(level.player.context_melee_direction)) {
    if(!scripts\engine\utility::array_contains(level.player.context_melee_allow_directions, level.player.context_melee_direction)) {
      level.player.context_melee_hinted = 0;
      return 1;
    }
  }

  return 0;
}

scripted_melee_active(var_0) {
  if(var_0 && !level.player isscriptedmeleeactive()) {
    print_debug("scripted melee active " + gettime());
    level.player.context_melee_last_active_time = gettime();
    level.player setscriptedmeleeactive(var_0);
  } else if(!var_0 && level.player isscriptedmeleeactive()) {
    print_debug("scripted melee INactive " + gettime());
    level.player.context_melee_last_inactive_time = gettime();
    level.player setscriptedmeleeactive(var_0);
  }
}

context_melee_cursor_hint_create() {
  if(isDefined(level.player.context_melee_allow_directions) && isDefined(level.player.context_melee_direction)) {
    if(!scripts\engine\utility::array_contains(level.player.context_melee_allow_directions, level.player.context_melee_direction))
      return;
  }

  if(getdvarint("context_melee_use_cursor_hint") == 1) {
    if(!isDefined(level.context_melee_hint_ent_set)) {
      level.context_melee_hint_ent_set = 1;
      level.context_melee_hint_ent thread scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", undefined, level.player.context_melee_hint, 360, 5000, 2000, undefined, undefined, undefined, undefined, "duration_none", "+melee", 0, 360);
      level.context_melee_hint_ent setuseprioritymax();
    } else {
      level.context_melee_hint_ent setHintString(level.player.context_melee_hint);
      level.context_melee_hint_ent sethinticon("blank");
      level.context_melee_hint_ent setusecommand("+melee");
    }
  } else if(getdvarint("context_melee_use_cursor_hint") == 2) {
    setomnvar("ui_in_world_text_index", 2);
    setomnvar("ui_in_world_text_entnum", level.context_melee_hint_ent getentitynumber());
  }
}

context_melee_cursor_hint_remove() {
  if(getdvarint("context_melee_use_cursor_hint") && isDefined(level.context_melee_hint_ent)) {
    level.context_melee_hint_ent_set = undefined;

    if(getdvarint("context_melee_use_cursor_hint") == 1)
      level.context_melee_hint_ent thread scripts\sp\player\cursor_hint::remove_cursor_hint();

    level.context_melee_hint_ent delete();
  }
}

context_melee_cursor_hint_blocked() {
  if(isDefined(level.context_melee_hint_ent)) {
    if(getdvarint("context_melee_use_cursor_hint") == 1) {
      level.player.context_melee_hint_blocked = scripts\engine\utility::ter_op(isDefined(level.player.context_melee_hint_blocked_custom), level.player.context_melee_hint_blocked_custom, &"CONTEXT_MELEE/BLOCKED");
      level.context_melee_hint_ent setHintString(level.player.context_melee_hint_blocked);
      level.context_melee_hint_ent sethinticon("hud_ability_disabled_x");
    }

    if(getdvarint("context_melee_use_cursor_hint") == 2)
      return;
  }
}

dynamic_takedowns_monitor() {
  level endon("stop_context_melee");

  for(;;) {
    if(istrue(self.in_melee_death)) {
      scripted_melee_active(0);
      level thread context_melee_cursor_hint_remove();
      waitframe();
      continue;
    }

    self.context_melee_victim = undefined;
    self.context_melee_direction = undefined;
    self.context_melee_animation = undefined;

    if(scripts\engine\utility::flag("hold_context_melee"))
      scripts\engine\utility::flag_waitopen("hold_context_melee");

    var_0 = check_for_close_victim();

    if(isDefined(var_0) && istrue(var_0.in_melee_death)) {
      scripted_melee_active(0);
      level thread context_melee_cursor_hint_remove();
      self.context_melee_victim = undefined;
      waitframe();
      continue;
    }

    if(isDefined(var_0)) {
      var_1 = var_0 player_stealth_kill_direction();
      var_2 = var_0 get_anim_from_direction(var_1);

      if(var_0 check_player_can_stealth_kill_me(var_2, var_1)) {
        self.context_melee_victim = var_0;
        self.context_melee_direction = var_1;
        self.context_melee_animation = var_2;
        scripted_melee_active(1);

        if(getdvarint("context_melee_use_cursor_hint")) {
          if(level.player getstance() == "stand")
            var_3 = var_0.origin + anglesToForward(vectortoangles(level.player.origin - var_0.origin)) * 16 + (0, 0, level.context_melee_eye_height_stand);
          else
            var_3 = var_0.origin + anglesToForward(vectortoangles(level.player.origin - var_0.origin)) * 16 + (0, 0, level.context_melee_eye_height_crouch);

          if(!isDefined(level.context_melee_hint_ent))
            level.context_melee_hint_ent = scripts\engine\utility::spawn_tag_origin(var_3);
          else
            level.context_melee_hint_ent.origin = var_3;

          self.context_melee_hint = scripts\engine\utility::ter_op(isDefined(self.context_melee_hint_custom), self.context_melee_hint_custom, &"CONTEXT_MELEE/STEALTH_KILL_HINT");
          level thread context_melee_cursor_hint_create();
        } else {
          self.context_melee_hint = scripts\engine\utility::ter_op(isDefined(self.context_melee_hint_custom), self.context_melee_hint_custom, "context_melee_stealth");
          thread scripts\engine\sp\utility::display_hint_forced(self.context_melee_hint);
        }
      } else {
        print3d_debug(self.origin, "^1no animation", (0, 1, 0), 1, 0.1, 1, "line5");
        self.context_melee_victim = undefined;
        scripted_melee_active(0);
      }
    } else
      scripted_melee_active(0);

    waitframe();
  }
}

enable_dynamic_takedowns() {
  level notify("stop_context_melee");

  if(!isDefined(self.melee_arms))
    self.melee_arms = scripts\engine\sp\utility::spawn_anim_model("context_melee_player_rig", self.origin, self.angles);

  self.melee_arms notsolid();
  self.melee_arms hide();
  level endon("stop_context_melee");
  self notifyonplayercommand("player_scripted_melee", "+melee_zoom");
  thread dynamic_takedowns_monitor();

  for(;;) {
    self waittill("player_scripted_melee");

    if(level.script == "estate" && self isuseinprogress()) {
      continue;
    }
    if(isalive(self.context_melee_victim)) {
      var_0 = self.context_melee_victim;
      var_1 = self.context_melee_direction;
      var_2 = self.context_melee_animation;

      if(isDefined(var_2)) {
        if(isDefined(self.skip_context_melee_anim))
          self notify("skipped_melee_anim");
        else {
          var_0 thread do_context_melee(var_2, var_1);
          level scripts\sp\utility::context_melee_waittill_player_finished();
        }
      }
    }
  }
}

disable_dynamic_takedowns() {
  level notify("stop_context_melee");
  level.context_melee_enabled = 0;
  scripted_melee_active(0);
  level thread context_melee_cursor_hint_remove();
  self.context_melee_victim = undefined;
  print_debug("context_melee disabled: " + gettime());
}

check_for_close_victim() {
  level endon("stop_context_melee");

  if(getdvarint("LLNPMPRMLN") != 640)
    setsaveddvar("LLNPMPRMLN", 640);

  if(getdvarint("OKQOTRLPRQ") != 384)
    setsaveddvar("OKQOTRLPRQ", 384);

  if(getdvarint("MOSLLOQQSS") != 100)
    setsaveddvar("MOSLLOQQSS", 100);

  var_0 = scripts\engine\sp\utility::get_all_closest_living(level.player.origin, getaiarray("team3"), 512, 0);
  var_1 = scripts\engine\sp\utility::get_all_closest_living(level.player.origin, getaiarray("axis"), 512, 0);
  var_1 = scripts\engine\utility::array_combine(var_0, var_1);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.context_melee_combatsight_buffer))
      var_3.context_melee_combatsight_buffer = 0;

    if(!isDefined(var_3.context_melee_combatsight_lastime))
      var_3.context_melee_combatsight_lastime = gettime();

    if(!isDefined(var_3.context_melee_combat_buffer) || var_3.context_melee_combat_buffer == 0) {
      if(var_3 scripts\stealth\utility::bcisincombat() && isDefined(var_3.enemy) && var_3.enemy == level.player) {
        if(var_3 context_melee_cansee()) {
          var_3.context_melee_combatsight_buffer = var_3.context_melee_combatsight_buffer + 1;
          var_3.context_melee_combatsight_lastime = gettime();
          print3d_debug(var_3.origin, "cm sight buffer " + var_3.context_melee_combatsight_buffer, (1, 0, 0), 1, 0.1, 1, "line1");
        } else if(gettime() - var_3.context_melee_combatsight_lastime > 2000) {
          var_3.context_melee_combatsight_buffer = 0;
          print3d_debug(var_3.origin, "cm sight buffer " + var_3.context_melee_combatsight_buffer, (0, 1, 0), 1, 0.1, 1, "line1");
        }
      } else {
        var_3.context_melee_combatsight_buffer = 0;
        print3d_debug(var_3.origin, "cm sight buffer " + var_3.context_melee_combatsight_buffer, (0, 1, 0), 1, 0.1, 1, "line1");
      }

      continue;
    }

    var_3.context_melee_combatsight_buffer = 0;
    print3d_debug(var_3.origin, "cm sight buffer " + var_3.context_melee_combatsight_buffer, (0, 1, 0), 1, 0.1, 1, "line1");
  }

  var_3 = level.player getscriptedmeleetarget();

  if(!isDefined(var_3)) {
    var_3 = scripts\engine\sp\utility::get_closest_living(level.player.origin, var_1);

    if(isDefined(var_3) && distance(level.player.origin, var_3.origin) < 92) {
      print_debug("scripted melee not returning an enemy but you're close enough to one.");
      level.player.context_melee_scripted_enemy_guess = var_3;

      if(!getdvarint("context_melee_use_cursor_hint"))
        level.player thread scripts\engine\sp\utility::display_hint("context_melee_scripted_fail");
      else
        context_melee_cursor_hint_blocked();
    } else {
      level thread context_melee_cursor_hint_remove();
      level.player.context_melee_scripted_enemy_guess = undefined;
    }

    level.player.context_melee_has_enemy = undefined;
    return undefined;
  }

  level.player.context_melee_has_enemy = var_3;
  level.player.context_melee_scripted_enemy_guess = undefined;

  if(isPlayer(var_3))
    return undefined;

  if(level.player ismeleeing())
    return undefined;

  if(!isalive(var_3))
    return undefined;

  if(var_3 scripts\sp\fakeactor::is_fakeactor() || !isai(var_3))
    return undefined;

  if(isDefined(var_3.context_melee_allowed) && !var_3.context_melee_allowed)
    return undefined;

  if(!isDefined(var_3.animtree) || var_3.animtree != "generic_human")
    return undefined;

  if(isDefined(var_3.unittype)) {
    switch (var_3.unittype) {
      case "suicidebomber":
      case "juggernaut":
      case "dog":
        return undefined;
    }
  }

  if(var_3 scripts\engine\utility::doinglongdeath())
    return undefined;

  if(getdvarint("context_melee_debug")) {
    var_5 = var_3 gettagorigin("j_head");
    var_6 = var_3 gettagorigin("tag_origin");
    var_7 = vectorNormalize(var_5 - level.player.origin);
    var_8 = vectordot(var_7, anglestoright(var_3 gettagangles("j_head")));
    print3d_debug(var_5, "dot: " + abs(var_8), (1, 1, 1), 1, 0.05, 1);
    line_debug(var_5, var_5 + anglestoright(var_3 gettagangles("j_head")) * 60, (1, 1, 1), 1, 0, 1);
    line_debug(var_6, var_6 + anglesToForward(var_3 gettagangles("tag_origin")) * 60, (1, 1, 1), 1, 0, 1);
  }

  if(!isDefined(var_3.context_melee_combat_buffer))
    var_3.context_melee_combat_buffer = 0;

  if(!isDefined(var_3.context_melee_sight_buffer))
    var_3.context_melee_sight_buffer = 0;

  if(isDefined(var_3.context_melee_last_melee_finish_time) && gettime() - var_3.context_melee_last_melee_finish_time < 600) {
    print3d_debug(var_3.origin, "waiting for previous melee buffer: " + gettime(), (1, 0, 0), 1, 0.1, 1, "line3");
    var_3.context_melee_sight_buffer = 12;
    var_3.context_melee_combat_buffer = 12;
    var_3 thread combat_counter_reset();
    return undefined;
  }

  if(var_3 scripts\stealth\utility::bcisincombat() && isDefined(var_3.enemy) && var_3.enemy == level.player) {
    if(var_3.context_melee_combatsight_buffer > 15) {
      print3d_debug(var_3.origin, " no buffer bc I've been looking at you!", (0, 1, 0), 1, 0.1, 1, "line2");
      return undefined;
    }

    var_3.context_melee_combat_buffer = var_3.context_melee_combat_buffer + 1;

    if(var_3.context_melee_combat_buffer > 12)
      return undefined;
    else {
      print3d_debug(var_3.origin, "combat buffer", (1, 0, 1), 1, 0.1, 1, "line3");
      var_3 thread combat_counter_reset();
    }
  } else
    var_3.context_melee_combat_buffer = 0;

  if(var_3 isinscriptedstate() && var_3 context_melee_cansee()) {
    var_3.context_melee_sight_buffer = var_3.context_melee_sight_buffer + 1;

    if(var_3.context_melee_sight_buffer > 12)
      return undefined;
    else {
      print3d_debug(var_3.origin, "I SEE YOU!", (1, 0, 0), 1, 0.1, 1, "line3");
      var_3 thread combat_counter_reset();
    }
  } else
    var_3.context_melee_sight_buffer = 0;

  return var_3;
}

combat_counter_reset() {
  self notify("counter_reset_stop");
  self endon("death");
  self endon("counter_reset_stop");
  var_0 = gettime();

  for(;;) {
    if(gettime() - var_0 > 2000 && !context_melee_cansee()) {
      break;
    } else if(context_melee_cansee())
      var_0 = gettime();

    waitframe();
  }

  print_debug("combat counter reset: " + gettime());
  self.context_melee_sight_buffer = 0;
  self.context_melee_combat_buffer = 0;
}

is_enemy_onscreen(var_0) {
  if(isDefined(level.player worldpointtoscreenpos(var_0 gettagorigin("j_head"), getdvarint("MRNKTKLLKP"))))
    return 1;
  else if(isDefined(level.player worldpointtoscreenpos(var_0 gettagorigin("j_spinelower"), getdvarint("MRNKTKLLKP"))))
    return 1;
  else if(isDefined(level.player worldpointtoscreenpos(var_0 gettagorigin("tag_origin"), getdvarint("MRNKTKLLKP"))))
    return 1;

  return 0;
}

physics_test(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_4))
    var_4 = "collision failed";

  var_8 = undefined;

  if(isDefined(var_5) && isDefined(var_5.capsule_radius) && var_5.capsule_radius == 15)
    var_9 = 1;
  else
    var_9 = 0.8;

  switch (var_0) {
    case "ray":
      var_8 = physics_raycast(var_1, var_2, get_melee_contents(), [level.player, var_3], 0, "physicsquery_closest", 1);
      break;
    case "player_eye_cast":
      var_8 = physics_spherecast(var_1, var_2, 2, get_melee_contents(), [level.player, var_3], "physicsquery_closest");
      sphere_debug(var_1, 2, (1, 0, 1), 0, 1);
      sphere_debug(var_2, 2, (1, 0, 1), 0, 1);
      break;
    case "player_capsule_cast":
      var_8 = physics_capsulecast(var_1, var_2, var_5.capsule_radius * var_9, var_5.capsule_halfheight * var_9, level.player getplayerangles(1), get_melee_contents(), [level.player, var_3], "physicsquery_closest");
      capsule_debug(var_1 - (0, 0, var_5.capsule_midpoint_height * 0.5), var_5.capsule_radius * var_9, var_5.capsule_halfheight * var_9 * 2, level.player getplayerangles(1), (1, 0, 1), 0, 1);
      capsule_debug(var_2 - (0, 0, var_6.capsule_midpoint_height * 0.5), var_6.capsule_radius * var_9, var_6.capsule_halfheight * var_9 * 2, level.player getplayerangles(1), (1, 0, 1), 0, 1);
      break;
    case "capsule":
      var_8 = physics_capsulecast(var_1, var_2, var_5.capsule_radius, var_5.capsule_halfheight, level.player getplayerangles(1), get_melee_contents(), [level.player, var_3], "physicsquery_closest");
      break;
    case "player_eye":
      var_8 = physics_getclosestpointtosphere(var_1 + (0, 0, 2), 2, 0, get_melee_contents(), [level.player, var_3], "physicsquery_closest");
      sphere_debug(var_1 + (0, 0, 2), 2, (1, 1, 1), 0, 1);
      break;
    case "enemy_eye":
      var_8 = physics_getclosestpointtosphere(var_1 + (0, 0, 2), 2, 0, get_melee_sight_contents(), [level.player, var_3, self], "physicsquery_closest");
      sphere_debug(var_1 + (0, 0, 2), 2, (1, 1, 1), 0, 1);
      break;
    case "player_capsule":
      var_8 = physics_getclosestpointtocapsule(var_1, var_6.capsule_radius * var_9, var_6.capsule_halfheight * var_9, level.player getplayerangles(1), 0, get_melee_contents(), [level.player, var_3], "physicsquery_closest");
      capsule_debug(var_1 - (0, 0, var_6.capsule_midpoint_height * 0.5), var_6.capsule_radius * var_9, var_6.capsule_halfheight * var_9 * 2, level.player getplayerangles(1), (1, 1, 0), 0, 1);
      break;
  }

  if(istrue(var_8.size)) {
    print3d_debug(var_8[0]["position"], var_4, (1, 0, 0), 1, 0.1, 1);
    line_debug(var_1, var_8[0]["position"], (1, 0, 0), 1, 0, 1);
    sphere_debug(var_8[0]["position"], 2, (1, 0, 0), 0, 1);
    return 0;
  }

  return 1;
}

anim_collision_check(var_0, var_1, var_2) {
  level notify("tag_view_debug_end");

  if(level.player getstance() == "prone")
    return 0;

  var_3 = level.player getcollision(level.player getstance());
  var_4 = level.player getcollision("stand");
  var_5 = level.player getcollision("crouch");

  if(var_3.capsule_halfheight < var_3.capsule_radius)
    var_3.capsule_halfheight = var_3.capsule_radius;

  var_6 = [0];
  var_7 = scripts\engine\sp\utility::spawn_anim_model("context_melee_player_rig", level.player.origin, level.player.angles);
  var_7 notsolid();
  var_7 hide();
  var_8 = scripts\engine\sp\utility::spawn_anim_model("context_melee_player_rig", level.player.origin, level.player.angles);
  var_8 notsolid();
  var_8 hide();
  var_9 = scripts\engine\utility::spawn_tag_origin();
  set_scripted_node_angles(var_9, var_1, var_2);
  var_9 scripts\common\anim::anim_first_frame_solo(var_7, var_0);
  var_9 scripts\common\anim::anim_last_frame_solo(var_8, var_0);
  var_7 linkTo(var_9);
  var_8 linkTo(var_9);
  level.context_melee_eye_height_stand = var_4.capsule_halfheight + var_4.capsule_midpoint_height;
  level.context_melee_eye_height_crouch = var_5.capsule_halfheight + var_5.capsule_midpoint_height;
  var_10 = var_8 gettagorigin(level.context_melee_lastframe_bone) + anglestoup(var_8 gettagangles(level.context_melee_lastframe_bone)) * level.context_melee_eye_height_stand;

  foreach(var_15, var_12 in var_6) {
    if(getdvarint("context_melee_debug")) {
      line_debug(level.player getEye() + (0, 0, -0.1), var_7 gettagorigin("tag_view"), (1, 1, 1), 1, 0, 1);
      circle_debug(var_7 gettagorigin(level.context_melee_player_link_bone), var_3.capsule_radius, (1, 0, 0), 1, 1, 1);
      circle_debug(var_8 gettagorigin(level.context_melee_lastframe_bone), var_3.capsule_radius, (1, 1, 0), 1, 1, 1);
      line_debug(var_8 gettagorigin(level.context_melee_lastframe_bone), var_8 gettagorigin(level.context_melee_lastframe_bone) + anglestoup(var_8 gettagangles(level.context_melee_lastframe_bone)) * level.context_melee_eye_height_stand, (0, 0, 1), 1, 0, 1);
      line_debug(var_8 gettagorigin(level.context_melee_lastframe_bone) + anglestoup(var_8 gettagangles(level.context_melee_lastframe_bone)) * level.context_melee_eye_height_stand, var_8 gettagorigin(level.context_melee_lastframe_bone) + anglestoup(var_8 gettagangles(level.context_melee_lastframe_bone)) * level.context_melee_eye_height_stand + (0, 0, -60), (0, 0, 1), 1, 1, 1);
      circle_debug(var_10, var_3.capsule_radius, (0, 0, 1), 1, 1, 1);

      if(isDefined(self.proximity_bump_dist_sqr_override))
        circle_debug(self.origin, sqrt(self.proximity_bump_dist_sqr_override), (1, 1, 0), 1, 1, 1);
      else
        circle_debug(self.origin, 16, (0, 1, 0), 1, 1, 1);

      if(getdvarint("context_melee_debug_extra")) {
        var_7 show();
        var_8 show();
      }
    }

    var_13 = anglestoup(level.player getplayerangles(1)) * (var_3.capsule_midpoint_height + var_3.capsule_radius);
    var_14 = anglestoup(level.player getplayerangles(1)) * (var_4.capsule_midpoint_height + var_4.capsule_radius);

    if(!physics_test("player_capsule_cast", level.player.origin + var_13, var_7 gettagorigin(level.context_melee_player_link_bone) + var_14, self, "player capsule cast failed", var_3, var_4))
      return !collision_check_failed(var_9, var_7, var_8);

    switch (level.context_melee_lastframe_type) {
      case "player_eye":
        if(!physics_test("player_eye", var_8 gettagorigin(level.context_melee_lastframe_bone), undefined, self, "end pos eye failed", var_3))
          return !collision_check_failed(var_9, var_7, var_8);

        break;
      case "player_capsule":
        if(!physics_test("player_capsule", var_10 - (0, 0, var_4.capsule_halfheight * 0.5), undefined, self, "end pos capsule failed", var_3, var_4)) {
          if(var_15 < var_6.size - 1) {
            var_9 rotateYaw(var_12, 0.05, 0, 0);
            break;
          } else
            return !collision_check_failed(var_9, var_7, var_8);
        }

        break;
    }
  }

  var_9 delete();
  var_7 scripts\engine\utility::delaycall(0.05, ::delete);
  var_8 scripts\engine\utility::delaycall(0.05, ::delete);
  return 1;
}

collision_check_failed(var_0, var_1, var_2) {
  var_0 delete();
  var_1 scripts\engine\utility::delaycall(0.05, ::delete);
  var_2 scripts\engine\utility::delaycall(0.05, ::delete);

  if(!isDefined(level.player.context_melee_blocked_hint_allowed) || level.player.context_melee_blocked_hint_allowed) {
    if(!getdvarint("context_melee_use_cursor_hint")) {
      level.player.context_melee_hint_blocked = scripts\engine\utility::ter_op(isDefined(level.player.context_melee_hint_blocked_custom), level.player.context_melee_hint_blocked_custom, "context_melee_blocked");
      level.player thread scripts\engine\sp\utility::display_hint_forced(level.player.context_melee_hint_blocked);
    } else
      context_melee_cursor_hint_blocked();
  }

  return 1;
}

get_melee_contents() {
  var_0 = ["physicscontents_clipshot", "physicscontents_itemclip", "physicscontents_player", "physicscontents_playernosight", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_glass"];
  return physics_createcontents(var_0);
}

get_melee_sight_contents() {
  var_0 = ["physicscontents_foliage", "physicscontents_clipshot", "physicscontents_itemclip", "physicscontents_player", "physicscontents_playernosight", "physicscontents_solid", "physicscontents_vehicle"];
  return physics_createcontents(var_0);
}

check_stealth_kill_visible(var_0) {
  self endon("death");
  level.player endon("death");
  level endon("stop_context_melee");

  if(!getdvarint("context_melee_silent"))
    return 0;

  var_1 = 600;

  if(isDefined(level.stealth) && isDefined(level.stealth.damage_sight_range))
    var_1 = level.stealth.damage_sight_range;

  var_2 = 100;

  if(isDefined(level.stealth) && isDefined(level.stealth.proximity_combat_radius_bump))
    var_2 = level.stealth.proximity_combat_radius_bump;

  var_3 = squared(var_1 + 36);
  var_4 = getaiarrayinradius(level.player.origin, 2048, "axis");
  var_5 = getaiarrayinradius(level.player.origin, 2048, "team3");
  var_0 = scripts\engine\utility::array_combine(var_4, var_5);
  var_0 = scripts\engine\utility::array_remove(var_0, self);
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);

  if(var_0.size < 1) {
    print3d_debug(self.origin, "only enemy alive, no silent check", (0, 1, 0), 1, 0.1, 1, "line2");
    return 0;
  }

  var_0 = sortbydistance(var_0, self.origin);

  foreach(var_7 in var_0) {
    if(var_7 context_melee_cansee())
      return 1;
    else if(var_7 context_melee_cansee(self) && distancesquared(var_7.origin, self.origin) < var_3)
      return 1;
    else if(distancesquared(var_7.origin, self.origin) < squared(100)) {
      if(physics_test("enemy_eye", self getEye(), var_7 getEye(), var_7, "silent sight check failed!", undefined)) {}

      return 1;
    }
  }

  return 0;
}

do_context_melee(var_0, var_1) {
  self notify("start_context_melee");
  var_2 = level.player.origin;
  var_3 = level.player getstance();

  if(!isDefined(self)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  if(isDefined(self.stealth) && !istrue(self.keepstealthoncontextmelee))
    scripts\engine\utility::ent_flag_clear("stealth_enabled");

  self notify("end_patrol");
  var_4 = scripts\engine\utility::spawn_tag_origin();
  var_5 = self getlinkedparent();

  if(getdvarint("context_melee_debug"))
    var_4 thread anim_ent_debug();

  scripts\engine\sp\utility::anim_stopanimScripted();

  if(isDefined(self.context_melee_origin))
    var_4.origin = self.context_melee_origin;
  else
    var_4.origin = self.origin;

  if(isDefined(self.context_melee_angles))
    var_4.angles = self.context_melee_angles;
  else {
    set_scripted_node_angles(var_4, var_1, level.context_melee_collision_offset);
    print_debug("^1Context Melee Kill from direction: " + var_1);
  }

  var_4 axis_debug((0, 1, 1), 1000, 10);
  print3d_debug(self.origin, "enemy melee pos: " + var_1, (0, 1, 1), 1, 0.1, 1000);
  line_debug(level.player.origin, self.origin, (0, 1, 1), 1, 0, 1000);
  circle_debug(self.origin, 16, (0, 1, 1), 1, 1, 1000);
  level.player.in_melee_death = 1;
  self.context_melee_og_maxsightdistsqrd = self.maxsightdistsqrd;
  self.context_melee_og_newenemyreactiondistsq = self.newenemyreactiondistsq;
  self.context_melee_og_battlechatter = self.battlechatterallowed;
  self.context_melee_og_allowdeath = self.allowdeath;
  self.context_melee_og_animname = self.animname;
  self.in_melee_death = 1;
  self.allowantigrav = 0;
  self.dontmelee = 1;
  self.maxsightdistsqrd = 1;
  self.fixednode = 0;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.newenemyreactiondistsq = 0;
  self.allowdeath = 0;
  self.a.disablepain = 1;
  self.allowpain = 0;
  self.battlechatterallowed = 0;
  self.animname = "generic";
  self.context_melee_anim = var_0;
  self.remove_from_animloop = 1;

  if(isDefined(self.script_stealthgroup) && !isDefined(self.context_melee_victim_lives))
    scripts\stealth\group::group_removefrompod(undefined, self);

  if(!isDefined(self.context_melee_victim_lives)) {
    self setgoalpos(var_4.origin);
    self clearpath();
  }

  if(isDefined(self) && isalive(self) && !isDefined(self.delayeddeath) && !isDefined(self.melee))
    thread scripts\common\ai::magic_bullet_shield();

  if(isDefined(self) || isalive(self)) {
    level.player enableinvulnerability();
    level.player enablequickweaponswitch(1);
    var_4 scripts\common\anim::anim_first_frame_solo(level.player.melee_arms, var_0);
    waitframe();

    if(getdvarint("context_melee_debug")) {
      var_6 = level.player getcollision("stand");
      level.player.melee_arms thread tag_view_debug();
      print3d_debug(level.player.melee_arms gettagorigin(level.context_melee_player_link_bone), "melee anim start", (1, 0, 0), 1, 0.1, 1000);
      line_debug(level.player.melee_arms gettagorigin(level.context_melee_player_link_bone), level.player.melee_arms.origin + anglesToForward(level.player.melee_arms.angles) * 100, (1, 0, 0), 1, 0, 1000);
      circle_debug(level.player.melee_arms gettagorigin(level.context_melee_player_link_bone), var_6.capsule_radius, (1, 0, 0), 1, 1, 1000);

      if(isDefined(self.context_melee_combat_buffer) && self.context_melee_combat_buffer > 0)
        print_debug("combat counter was at: " + self.context_melee_combat_buffer + " of " + 12);
    }

    var_7 = spawn("script_model", level.player.origin);

    if(isDefined(level.player.context_melee_knife))
      var_7 setModel(level.player.context_melee_knife);
    else
      var_7 setModel("weapon_vm_me_soscar_knife");

    var_7 notsolid();
    var_7 linkTo(level.player.melee_arms, "tag_accessory_right", (0, 0, 0), (0, 0, 0));

    if(!isDefined(self.context_melee_victim_lives))
      scripts\engine\utility::delaythread(5, ::death_safety, self);

    level.player notify("context_melee_anim_started");
    level.player prep_player_and_enemy(self, var_4, var_0);

    if(isDefined(var_5)) {
      print_debug("linking");
      var_4 linkTo(var_5);
      self linkTo(var_4);
      level.player.melee_arms linkTo(var_4);
    }

    level.player lerpfovscalefactor(0, 0.25);
    var_8 = getanimlength(scripts\engine\utility::getanim(var_0));
    var_9 = getanimlength(level.player.melee_arms scripts\engine\utility::getanim(var_0));

    if(var_8 > var_9)
      level.player thread scripts\engine\sp\utility::notify_delay("context_melee_longest_anim_ended", var_8);
    else
      level.player thread scripts\engine\sp\utility::notify_delay("context_melee_longest_anim_ended", var_9);

    thread scripts\engine\sp\utility::notify_delay("context_melee_anim_ended_internal", var_8);
    level.player thread scripts\engine\sp\utility::notify_delay("context_melee_anim_ended", var_9);
    var_10 = 0.5;
    level.player scripts\engine\utility::delaycall(var_9 - var_10, ::lerpfovscalefactor, 1, var_10);
    self notify("damage", 0, level.player, undefined, undefined, "MOD_MELEE");
    thread enemy_end_death_logic(var_0, var_5);
    level.player thread player_end_death_logic(var_7, var_4, var_2, var_3, var_1);
    var_4 thread scripts\common\anim::anim_single([self, level.player.melee_arms], var_0);
  }

  level.player waittill("context_melee_longest_anim_ended");
  print_debug("longest melee anim finished");
}

anim_ent_debug() {
  self endon("death");

  for(;;) {
    sphere_debug(self.origin, 4, (1, 1, 1), 0, 1);
    waitframe();
  }
}

context_melee_launch(var_0, var_1) {
  level.player endon("death");
  print_debug("launching!");
  level.player.context_melee_launching = 1;
  level.player enableweapons();

  if(!level.player hasweapon("iw8_gunless_farrah"))
    level.player giveweapon("iw8_gunless_farrah");

  level.player switchtoweaponimmediate("iw8_gunless_farrah");
  earthquake(1, 0.3, level.player.origin, 75);
  level.player playRumbleOnEntity("heavy_1s");
  level.player thread scripts\sp\player::radial_distortion(0.05, 0.2, 0.25);
  visionsetpain("damage_severe");
  setsaveddvar("MLLRKTPNRR", 0);
  setsaveddvar("OONLORSMO", 1.9);
  level.player painvisionon();
  level.player scripts\engine\utility::delaycall(0.2, ::painvisionoff);
  waitframe();
  level.player unlink();
  level.player thread launch_push_player2();
  var_2 = getDvar("OMNONNMOTP");
  setsaveddvar("OMNONNMOTP", "0.1 400 2 1000");
  level.player scripts\engine\sp\utility::player_gesture_force("ges_htf_stab_a");
  wait(level.player getgestureanimlength("ges_htf_stab_a"));
  setsaveddvar("OMNONNMOTP", var_2);
  level.player.context_melee_launching = undefined;
}

launch_push_player() {
  var_0 = vectorNormalize(anglesToForward(level.player.angles));
  var_1 = var_0 * -1;

  for(var_2 = 0; var_2 < 6; var_2++) {
    level.player pushplayervector(var_1);
    waitframe();
    var_1 = var_1 * 1.7;
  }

  wait 0.8;
  var_1 = var_1 * -0.6;

  for(;;) {
    var_1 = var_1 * 0.75;

    if(vectordot(var_1, var_0) < 0.5) {
      level.player pushplayervector((0, 0, 0));
      waitframe();
      break;
    } else
      level.player pushplayervector(var_1);

    waitframe();
  }

  print_debug("launching finished t:" + gettime());

  if(getdvarint("context_melee_debug")) {
    var_3 = level.player getcollision("stand");
    print3d_debug(level.player.origin + (0, 0, -2), "slide end", (1, 1, 0), 1, 0.1, 1000);
    circle_debug(level.player.origin, var_3.capsule_radius, (1, 1, 0), 1, 1, 1000);
  }
}

launch_push_player2() {
  var_0 = vectorNormalize(anglesToForward(level.player.angles)) * -500;
  level.player setvelocity(var_0);
}

set_scripted_node_angles(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  switch (var_1) {
    case "front":
      var_0.angles = vectortoangles(level.player.origin - self.origin) + var_2;
      break;
    case "left":
      var_0.angles = vectortoangles(level.player.origin - self.origin) + (0, -90, 0) + var_2;
      break;
    case "right":
      var_0.angles = vectortoangles(level.player.origin - self.origin) + (0, 90, 0) + var_2;
      break;
    case "back":
      var_0.angles = vectortoangles(self.origin - level.player.origin) + var_2;
      break;
    default:
  }
}

enemy_end_death_logic(var_0, var_1) {
  self endon("death");
  level endon("stop_context_melee");
  self waittill("context_melee_anim_ended_internal");

  if(!isDefined(self.context_melee_victim_lives)) {
    context_melee_death(self);
    context_melee_ragdoll(self);
  } else {
    self.in_melee_death = 0;
    self.allowantigrav = 1;
    self.dontmelee = 0;
    self.maxsightdistsqrd = self.context_melee_og_maxsightdistsqrd;
    self.fixednode = 0;
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.newenemyreactiondistsq = self.context_melee_og_newenemyreactiondistsq;
    self.a.disablepain = 0;
    self.battlechatterallowed = self.context_melee_og_battlechatter;
    self.context_melee_anim = var_0;
    self.remove_from_animloop = undefined;
    self.allowdeath = self.context_melee_og_allowdeath;
    self.animname = self.context_melee_og_animname;
    self.context_melee_last_melee_finish_time = gettime();

    if(isDefined(var_1))
      self linkTo(var_1);
  }

  self notify("context_melee_anim_ended");
}

player_end_death_logic(var_0, var_1, var_2, var_3, var_4) {
  level.player endon("death");
  level.player waittill("context_melee_anim_ended");
  var_0 delete();
  var_1 delete();
  level.player.melee_arms hide();

  if(getdvarint("context_melee_debug")) {
    var_5 = level.player getcollision("stand");
    print3d_debug(level.player.origin + (0, 0, -2), "melee anim end", (1, 1, 0), 1, 0.1, 1000);
    circle_debug(level.player.origin, var_5.capsule_radius, (1, 1, 0), 1, 1, 1000);
  }

  level.player release_player_from_viewmodel_anim(var_2, var_3, var_4, var_1);
  level.player disableinvulnerability();
  level.player enablequickweaponswitch(0);
  level.player.melee_arms hide();
  level.player.context_melee_next = get_next_anim(level.player.context_melee_next);
  level.player.in_melee_death = undefined;
}

tag_view_debug() {
  self endon("death");
  level endon("tag_view_debug_end");

  if(getdvarint("context_melee_debug_extra")) {
    for(;;) {
      arrow_debug(self gettagorigin("tag_view"), self gettagorigin("tag_view") + anglesToForward(self gettagangles("tag_view")) * 10, (0.25, 0.25, 1), 1000);
      wait 0.1;
    }
  }
}

prep_player_and_enemy(var_0, var_1, var_2) {
  prepare_player_for_viewmodel_anim();
  var_3 = getstartangles(var_1.origin, var_1.angles, var_0 scripts\engine\utility::getanim(var_2));
  line_debug(var_0.origin, var_0.origin + anglesToForward(var_0.angles) * 36, (0, 1, 0), 1, 0, 1000);
  line_debug(var_0.origin, var_0.origin + anglesToForward(var_3) * 36, (1, 0, 1), 1, 0, 1000);
  thread axis_debug((0, 1, 0), 1000, 10);
  print3d_debug(self.origin, "pre melee pos", (0, 1, 0), 1, 0.1, 1000);
  line_debug(self.origin, self.origin + anglesToForward(self getplayerangles(1)) * 100, (0, 1, 0), 1, 0, 1000);
  var_4 = 0.2;
  self playerlinktoblend(self.melee_arms, level.context_melee_player_link_bone, var_4, 0.05, 0.1);
  var_5 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_0 linktoblendtotag(var_5, "tag_origin");
  var_5 rotateTo(var_3, var_4, 0.1);
  wait(var_4);
  self playerlinktoabsolute(self.melee_arms, level.context_melee_player_link_bone);
  var_5 delete();
  self.melee_arms show();
}

context_melee_death(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isalive(var_0)) {
    return;
  }
  var_0.skipdeathanim = 1;
  var_0.noragdoll = 1;
  var_0 pushplayer(0);
  var_0 scripts\anim\shared.gsc::dropallaiweapons();

  if(isDefined(self.asm.flashlight) && isDefined(self.fnstealthflashlightdetach) && self.asm.flashlight)
    self[[self.fnstealthflashlightdetach]]();

  var_0.allowdeath = 1;
  var_0.diequietly = 1;

  if(isDefined(var_0.magic_bullet_shield))
    var_0 scripts\common\ai::stop_magic_bullet_shield();

  if(isDefined(var_0.damageshield))
    var_0.damageshield = 0;

  if(isDefined(var_0.stealth))
    var_0.stealth.override_damage_auto_range = 60;

  var_0 kill((0, 0, 0), level.player, level.player, "MOD_MELEE");

  if(!istrue(var_0.context_melee_ragdoll))
    level.player.context_melee_kill_origin = var_0.origin;
}

context_melee_fx(var_0) {
  if(isDefined(var_0) && isDefined(var_0.context_melee_anim)) {
    switch (var_0.context_melee_anim) {
      case "context_melee_kill_01_back":
        playFXOnTag(scripts\engine\utility::getfx("vfx_contextmelee_stab"), var_0, "j_neck");
        break;
      default:
        playFXOnTag(scripts\engine\utility::getfx("vfx_contextmelee_stab"), var_0, "j_neck");
    }
  }
}

context_melee_sfx(var_0) {}

context_melee_ragdoll(var_0) {
  if(!isDefined(var_0) && isDefined(level.player.context_melee_kill_origin)) {
    foreach(var_2 in getcorpsearray()) {
      if(istrue(var_2.context_melee_ragdoll)) {
        continue;
      }
      if(var_2 isragdoll()) {
        continue;
      }
      var_3 = var_2.origin;

      if(getdvarint("MQSNSOSMPN"))
        var_3 = var_2 getcorpsephysicsorigin();

      if(isDefined(var_3) && distancesquared(var_3, level.player.context_melee_kill_origin) < squared(60)) {
        var_2 startragdoll();
        var_2.context_melee_ragdoll = 1;
      }
    }
  } else if(isDefined(var_0) && !istrue(var_0.context_melee_ragdoll)) {
    var_0 thread scripts\anim\shared.gsc::dropallaiweapons();
    var_0 startragdoll();
    var_0.context_melee_ragdoll = 1;
  }

  level.player.context_melee_kill_origin = undefined;
}

context_melee_rumble_light(var_0) {
  level.player playRumbleOnEntity("damage_light");
}

context_melee_rumble_heavy(var_0) {
  level.player playRumbleOnEntity("heavy_1s");
}

death_safety(var_0) {
  if(isDefined(var_0)) {
    if(isalive(var_0)) {
      if(isDefined(var_0.magic_bullet_shield))
        var_0 scripts\common\ai::stop_magic_bullet_shield();
    }
  }
}

check_player_can_stealth_kill_me(var_0, var_1) {
  level endon("stop_context_melee");

  if(isDefined(self.context_melee_allow_directions)) {
    if(!scripts\engine\utility::array_contains(self.context_melee_allow_directions, var_1)) {
      print3d_debug(self.origin, "no melee!, direction " + var_1 + " not allowed!", (1, 0, 0), 1, 0.1, 1, "line5");
      return 0;
    }
  }

  if(!isDefined(var_0)) {
    print3d_debug(self.origin, "no melee!, target but no animation", (1, 0, 0), 1, 0.1, 1, "line5");
    return 0;
  }

  if(!isDefined(level.scr_anim["generic"][var_0])) {
    print3d_debug(self.origin, "no melee!, target but no generic animation", (1, 0, 0), 1, 0.1, 1, "line5");
    return 0;
  }

  if(self.currentpose != "stand" && self.currentpose != "crouch") {
    print3d_debug(self.origin, "no melee!, AI is crouching or moving", (1, 0, 0), 1, 0.1, 1, "line5");
    return 0;
  }

  if(isDefined(self.melee)) {
    if(isDefined(self.melee.initiated) && self.melee.initiated || isDefined(self.melee.inprogress) && self.melee.inprogress) {
      print3d_debug(self.origin, "no melee!, target is already meleeing player!", (1, 0, 0), 1, 0.1, 1, "line5");
      return 0;
    }
  }

  var_2 = abs(self.origin[2] - level.player.origin[2]);

  if(var_2 >= 20) {
    print3d_debug(self.origin, "no melee! height difference is " + var_2 + " units", (1, 0, 0), 1, 0.1, 1, "line5");
    return 0;
  }

  if(level.player isjumping()) {
    print3d_debug(self.origin, "no melee!, player is jumping", (1, 0, 0), 1, 0.1, 1, "line5");
    return 0;
  }

  if(!anim_collision_check(var_0, var_1)) {
    if(!isDefined(level.context_melee_fail_attempts))
      level.context_melee_fail_attempts = 0;

    var_3 = [5, -5, 15, -15, 30, -30, 45, -45];

    if(level.context_melee_fail_attempts < var_3.size) {
      level.context_melee_collision_offset = (0, var_3[level.context_melee_fail_attempts], 0);

      if(!anim_collision_check(var_0, var_1, level.context_melee_collision_offset)) {
        level.context_melee_fail_attempts = level.context_melee_fail_attempts + 1;
        print3d_debug(self.origin, "collision extra fail attempts: " + level.context_melee_fail_attempts, (1, 0, 0), 1, 0.1, 1, "line3");
        return 0;
      } else
        print3d_debug(self.origin, "collision extra success offset: " + level.context_melee_collision_offset, (0, 1, 1), 1, 0.1, 1, "line3");
    } else {
      level.context_melee_fail_attempts = undefined;
      level.context_melee_collision_offset = undefined;
      return 0;
    }
  } else {
    level.context_melee_fail_attempts = undefined;
    level.context_melee_collision_offset = undefined;
  }

  if(getdvarint("context_melee_silent")) {
    if(check_stealth_kill_visible())
      return 0;
  }

  print3d_debug(self.origin, "IS stealth melee target with anime: " + var_0, (0, 1, 0), 1, 0.1, 1, "line5");
  return 1;
}

player_stealth_kill_direction() {
  var_0 = self gettagangles("tag_origin");
  var_1 = self gettagorigin("tag_origin");
  var_2 = anglestoright(var_0);
  var_3 = anglesToForward(var_0);
  var_4 = level.player.origin - var_1;
  var_4 = (var_4[0], var_4[1], 0);
  var_4 = vectorNormalize(var_4);
  var_5 = abs(vectordot(var_3, (0, 0, 1)));

  if(var_5 > 0.7)
    var_3 = vectorNormalize((var_2[0], var_2[1], 0));
  else
    var_3 = vectorNormalize((var_3[0], var_3[1], 0));

  var_6 = anglesToForward(self.angles);

  if(vectordot(var_4, var_6) > vectordot(var_3, var_6))
    var_3 = var_6;

  var_2 = vectorcross(var_3, (0, 0, 1));
  var_7 = vectordot(var_3, var_4);
  var_8 = vectordot(var_2, var_4);

  if(isDefined(self.context_melee_back_dot_override))
    var_9 = self.context_melee_back_dot_override;
  else
    var_9 = -0.5;

  if(var_7 < var_9) {
    print3d_debug(self.origin, "direction: back dot: " + var_7 + " threat: " + self getthreatsight(level.player), (0, 1, 0), 1, 0.1, 1, "line4");
    return "back";
  } else if(var_7 > 0.6) {
    print3d_debug(self.origin, "direction: front dot: " + var_7 + " threat: " + self getthreatsight(level.player), (0, 1, 0), 1, 0.1, 1, "line4");
    return "front";
  } else if(var_8 > 0) {
    print3d_debug(self.origin, "direction: right dot: " + var_7 + " threat: " + self getthreatsight(level.player), (0, 1, 0), 1, 0.1, 1, "line4");
    return "right";
  } else {
    print3d_debug(self.origin, "direction: left dot: " + var_7 + " threat: " + self getthreatsight(level.player), (0, 1, 0), 1, 0.1, 1, "line4");
    return "left";
  }

  return undefined;
}

get_next_anim(var_0, var_1) {
  var_2 = var_0;

  for(;;) {
    var_3 = "context_melee_kill_0" + var_2 + "_";

    if(isDefined(var_1)) {
      if(isDefined(level.scr_anim["generic"][var_3 + var_1]))
        return var_3 + var_1;
    }

    var_2++;
    var_3 = "context_melee_kill_0" + var_2 + "_";

    if(!isDefined(level.scr_anim["generic"][var_3 + "back"]) && !isDefined(level.scr_anim["generic"][var_3 + "front"]) && !isDefined(level.scr_anim["generic"][var_3 + "left"]) && !isDefined(level.scr_anim["generic"][var_3 + "right"]))
      var_2 = 1;

    if(!isDefined(var_1))
      return var_2;

    if(var_2 == var_0) {
      break;
    }
  }

  return undefined;
}

get_anim_from_direction(var_0) {
  if(!isDefined(level.player.context_melee_next))
    level.player.context_melee_next = 1;

  var_1 = undefined;

  if(isDefined(self.context_melee_anim_name)) {
    if(isDefined(self.context_melee_anim_name[var_0]))
      var_1 = self.context_melee_anim_name[var_0];
    else if(isDefined(self.context_melee_anim_name["all"]))
      var_1 = self.context_melee_anim_name["all"];
  }

  if(!isDefined(var_1))
    var_1 = get_next_anim(level.player.context_melee_next, var_0);

  return var_1;
}

prepare_player_for_viewmodel_anim() {
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  level.player setstance("stand", 0, 1, 1);
  level.player thread freeze_controls_when_standing();
  level.player freezelookcontrols(1);
  level.player disableweapons();
  level.player scripts\common\utility::allow_melee(0, "context_melee");
  level.player scripts\common\utility::allow_prone(0, "context_melee");
  level.player scripts\common\utility::allow_crouch(0, "context_melee");
}

freeze_controls_when_standing() {
  self endon("death");
  level endon("stop_context_melee");

  while(self getstance() != "stand")
    waitframe();

  self freezecontrols(1);
}

release_player_from_viewmodel_anim(var_0, var_1, var_2, var_3) {
  if(istrue(level.context_melee_do_launch))
    level.player context_melee_launch(var_2, var_3);

  level.player unlink();
  level.player freezecontrols(0);
  level.player freezelookcontrols(0);
  level.player scripts\common\utility::allow_melee(1, "context_melee");
  level.player scripts\common\utility::allow_prone(1, "context_melee");
  level.player scripts\common\utility::allow_crouch(1, "context_melee");
  level.player enableweapons();
  level.player setstance(var_1);
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

context_melee_sfx_player(var_0) {
  var_0 play_sound_safe("context_melee_kill_02_back");
}

context_melee_cansee(var_0) {
  if(level.context_melee_sight_disabled)
    return 0;

  if(!isDefined(var_0))
    var_0 = level.player;

  if(self aipointinfov(var_0 getEye()) && self cansee(var_0))
    return 1;

  return 0;
}

print_debug(var_0) {
  if(getdvarint("context_melee_debug"))
    iprintln(var_0);
}

print3d_debug(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_6))
    var_6 = "nothing";

  var_7 = level.player getcollision(level.player getstance());

  switch (var_6) {
    case "nothing":
      var_6 = (0, 0, 0);
      break;
    case "line1":
      var_6 = (0, 0, 8) + (0, 0, var_7.capsule_midpoint_height);
      break;
    case "line2":
      var_6 = (0, 0, 6) + (0, 0, var_7.capsule_midpoint_height);
      break;
    case "line3":
      var_6 = (0, 0, 4) + (0, 0, var_7.capsule_midpoint_height);
      break;
    case "line4":
      var_6 = (0, 0, 2) + (0, 0, var_7.capsule_midpoint_height);
      break;
    case "line5":
      var_6 = (0, 0, 0) + (0, 0, var_7.capsule_midpoint_height);
      break;
  }

  if(getdvarint("context_melee_debug"))
    return;
}

line_debug(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(getdvarint("context_melee_debug"))
    return;
}

sphere_debug(var_0, var_1, var_2, var_3, var_4) {
  if(getdvarint("context_melee_debug"))
    return;
}

axis_debug(var_0, var_1, var_2) {
  if(getdvarint("context_melee_debug"))
    scripts\engine\utility::draw_ent_axis(var_0, var_1, var_2);
}

circle_debug(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(getdvarint("context_melee_debug"))
    scripts\engine\utility::draw_circle(var_0, var_1, var_2, var_3, var_4, var_5);
}

capsule_debug(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(getdvarint("context_melee_debug"))
    scripts\engine\utility::draw_capsule(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

angles_debug(var_0, var_1, var_2, var_3, var_4) {
  if(getdvarint("context_melee_debug"))
    scripts\engine\utility::draw_angles(var_0, var_1, var_2, var_3, var_4);
}

box_debug(var_0, var_1, var_2, var_3, var_4) {
  if(getdvarint("context_melee_debug"))
    scripts\engine\utility::draw_angles(var_0, var_1, var_2, var_3, var_4);
}

arrow_debug(var_0, var_1, var_2, var_3) {
  if(getdvarint("context_melee_debug")) {
    var_4 = vectortoangles(var_0 - var_1);
    var_5 = anglesToForward(var_4);
    line_debug(var_0, var_1, var_2, 1, 0, var_3);
    line_debug(var_0, var_0 + var_5 * 1, (1, 0, 0), 1, 0, var_3);
  }
}