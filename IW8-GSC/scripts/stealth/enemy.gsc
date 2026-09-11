/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\enemy.gsc
***********************************************/

function main() {
  init_settings();
  init_flags();
  scripts\stealth\group::addtogroup(self.script_stealthgroup, self);
  setpatrolstyle_base();
  scripts\stealth\event::event_init_entity();
  thread monitor_damage_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
  set_alert_level("reset");
  bt_set_stealth_state("idle");
  stealth_init_goal_radius();

  if(isDefined(level.stealth.fninitenemygame)) {
    self thread[[level.stealth.fninitenemygame]]();
    return;
  }
}

function init_flags() {
  scripts\engine\utility::ent_flag_init("stealth_enabled");
  scripts\engine\utility::ent_flag_set("stealth_enabled");
  scripts\engine\utility::ent_flag_init("stealth_override_goal");
  scripts\engine\utility::ent_flag_init("stealth_hold_position");
  scripts\engine\utility::ent_flag_init("stealth_attack");
  scripts\engine\utility::ent_flag_init("stealth_cover_blown");
  scripts\engine\utility::ent_flag_init("stealth_local_investigation_only");
  scripts\engine\utility::ent_flag_init("stealth_disable_unresponsive_ai_check");
  scripts\engine\utility::ent_flag_init("stealth_non_player_combat");
  scripts\stealth\utility::group_flag_init("stealth_spotted");
  scripts\stealth\utility::group_flag_init("stealth_cover_blown");
  scripts\stealth\utility::group_flag_init("stealth_combat_hunting");
  scripts\stealth\utility::group_flag_init("stealth_disable_unresponsive_ai_check");
}

function stealth_init_goal_radius() {
  if(isDefined(self.script_radius)) {
    self.goalradius = self.script_radius;
    return;
  }

  if(!isDefined(self getgoalvolume())) {
    self.goalradius = level.default_goalradius;
    return;
  }
}

function init_settings() {
  self.stealth = spawnStruct();
  self.stealth.funcs = [];
  self.stealth.max_warnings = 2;
  self.stealth.reachedinvestigate = 0;
  self.newenemyreactiondistsq = squared(level.stealth.ai_event["ai_eventDistFootstepSprint"]["hidden"]);
  scripts\stealth\corpse::corpse_init_entity();
  self.stealth.event_escalation_scalar = 0;

  if(!isDefined(level.stealth.damage_auto_range)) {
    level.stealth.damage_auto_range = 175;
  }

  if(!isDefined(level.stealth.damage_sight_range)) {
    level.stealth.damage_sight_range = 600;
  }

  self.grenadeawareness = 0;
  self.canacquirenearbytacvisenemies = 0;
  self.stealth.bsmstate = -1;
}

function death_cleanup() {
  if(isDefined(self)) {
    scripts\stealth\threat_sight::threat_sight_set_state("death");
  } else {
    foreach(var1 in level.players) {
      foreach(var4, var3 in var1.stealth.threat_entities) {
        if(!isDefined(var3)) {
          var1.stealth.threat_entities[var4] = undefined;
        }
      }

      foreach(var3 in var1.stealth.threat_sighted) {
        if(!isDefined(var3)) {
          var1.stealth.threat_sighted[var4] = undefined;
        }
      }
    }
  }

  if(isDefined(self.stealth_vo_ent)) {
    thread death_vo_cleanup();
    return;
  }
}

function death_vo_cleanup() {
  self stopsounds();
  waitframe();
  self delete();
}

function add_active_sense_function(var0) {
  if(!isDefined(self.stealth.active_sense_funcs)) {
    self.stealth.active_sense_funcs = [];
  }

  self.stealth.active_sense_funcs[self.stealth.active_sense_funcs.size] = var0;
}

function proximity_check() {
  if(self.ignoreall) {
    return;
  }

  if(!isDefined(level.stealth)) {
    return;
  }

  var0 = self getapproxeyepos();
  var1 = (self.origin + var0) / 2;
  var2 = (0, 0, 35);

  if(isDefined(self.proximity_bump_dist_sqr_override)) {
    var3 = self.proximity_bump_dist_sqr_override;
  } else {
    var3 = 1764;
  }

  var4 = 11025;
  var5 = undefined;
  var6 = undefined;

  foreach(var8 in level.players) {
    var9 = 0;
    var10 = 0;

    if(!isalive(var8)) {
      continue;
    }

    if(issentient(var8) && (var8.ignoreme || var8.notarget)) {
      continue;
    }

    var11 = distancesquared(var2, var8.origin + var3);

    if(distance2dsquared(self.origin, var8.origin) < var3) {
      var12 = self.origin[2] - var8.origin[2];

      if(var12 * var12 < 5184) {
        var10 = 1;
        var9 = 1;
      }
    }

    if(!var9 && isDefined(level.stealth.proximity_combat_radius_fake_sight) && level.stealth.proximity_combat_radius_fake_sight > 0) {
      if(var11 < level.stealth.proximity_combat_radius_fake_sight * level.stealth.proximity_combat_radius_fake_sight) {
        if(!isDefined(self.stealth.blind)) {
          var13 = var8.origin - self.origin;
          var13 = (var13[0], var13[1], 0);
          var14 = anglesToForward((0, self.angles[1], 0));

          if(vectordot(var14, var13) > 0) {
            var10 = 1;
            var9 = 1;
          }
        }
      }
    }

    if(!var9 && isDefined(level.stealth.proximity_combat_radius_bump) && level.stealth.proximity_combat_radius_bump > 0) {
      if(var11 < level.stealth.proximity_combat_radius_bump * level.stealth.proximity_combat_radius_bump) {
        var15 = length2dsquared(var8 getvelocity());

        if(var15 > var4) {
          var10 = 1;
          var9 = 1;
        }
      }
    }

    if(!var9 && isDefined(level.stealth.proximity_combat_radius_sight) && level.stealth.proximity_combat_radius_sight > 0) {
      if(var11 < level.stealth.proximity_combat_radius_sight * level.stealth.proximity_combat_radius_sight) {
        if(self cansee(var8, 0)) {
          var9 = 1;
        }
      }
    }

    if(var9 && var10) {
      var9 = scripts\engine\trace::ray_trace_passed(self getapproxeyepos(), var8 getEye(), [self, var8]);
    }

    if(var9) {
      self aieventlistenerevent("proximity", var8, var8.origin);
      scripts\engine\utility::delaycall(0.05, &getenemyinfo, var8);
      return;
    }
  }
}

function set_blind(var0, var1) {
  if(!isDefined(self.stealth)) {
    return;
  }

  if(!var0 && !isDefined(self.stealth.blind)) {
    return;
  }

  var2 = isDefined(self.fnisinstealthcombat) && self[[self.fnisinstealthcombat]]();
  var3 = isDefined(self.fnisinstealthhunt) && self[[self.fnisinstealthhunt]]();
  var4 = var2 || var3;

  if(var0 && (!var4 || istrue(var1))) {
    self.stealth.blind = 1;
    set_sight_state("blind");
    return;
  }

  self.stealth.blind = undefined;

  if(var4) {
    set_sight_state("spotted");
    return;
  }

  set_sight_state("hidden");
}

function set_sight_state(var0) {
  switch (var0) {
    case "blind":
      scripts\stealth\threat_sight::threat_sight_set_state("blind");
      self.fovcosine = 0.98;
      self.fovcosinebusy = 0.98;
      self.fovcosinez = 0;
      self.fovground = 0;
      self.fovcosineperiph = 0.99;
      self.fovcosineperiphmaxdistsq = 1;
      break;
    case "unaware":
    case "hidden":
    case "idle":
      scripts\stealth\threat_sight::threat_sight_set_state("hidden");
      self.fovcosine = 0.7;
      self.fovcosinebusy = 0.86;
      self.fovcosinez = 0.97;
      self.fovground = 1;
      self.fovcosineperiph = 0.01;
      self.fovcosineperiphmaxdistsq = 90000;
      break;
    case "investigate":
      scripts\stealth\threat_sight::threat_sight_set_state("investigate");
      self.fovcosine = 0.7;
      self.fovcosinebusy = 0.86;
      self.fovcosinez = 0.97;
      self.fovground = 1;
      self.fovcosineperiph = 0.01;
      self.fovcosineperiphmaxdistsq = 90000;
      break;
    case "combat_hunt":
    case "hunt":
      scripts\stealth\threat_sight::threat_sight_set_state("combat_hunt");
      self.fovcosine = 0.7;
      self.fovcosinebusy = 0.86;
      self.fovcosinez = 0.97;
      self.fovground = 1;
      self.fovcosineperiph = 0.01;
      self.fovcosineperiphmaxdistsq = 90000;
      break;
    case "spotted":
    case "combat":
      scripts\stealth\threat_sight::threat_sight_set_state("spotted");
      self.fovcosine = 0.01;
      self.fovcosinebusy = 0.574;
      self.fovcosinez = 0;
      self.fovground = 0;
      self.fovcosineperiph = 0.01;
      self.fovcosineperiphmaxdistsq = 16384;
      break;
    case "flashlight_in_dark":
      break;
    case "townhouse":
      break;
    case "elevated":
      break;
  }
}

function alertlevel_normal(var0) {
  thread scripts\stealth\utility::addeventplaybcs("stealth", "announce5", "alertreset");
  set_alert_level("reset");
  bt_set_stealth_state("idle");
  scripts\stealth\utility::goto_last_goal();
}

function set_alert_level(var0) {
  if(!scripts\engine\utility::ent_flag("stealth_enabled")) {
    return;
  }

  if(isDefined(self.alertlevelscript) && self.alertlevelscript == var0) {
    return;
  }

  self notify("set_alert_level");
  self endon("set_alert_level");
  self endon("death");
  self.alertlevelscript = var0;

  while(isDefined(self.syncedmeleetarget)) {
    wait 0.05;
  }

  scripts\stealth\utility::set_stealth_state(var0);
  self notify("stealth_alertlevel_change", var0);
  self.alertlevel = scripts\stealth\utility::alertlevel_script_to_exe(var0);
  var1 = self.alertlevelint > 2;
  scripts\stealth\event::event_entity_core_set_enabled(!var1);
  self.ignoreexplosionevents = !var1;
}

function set_default_stealth_funcs() {
  level scripts\stealth\utility::set_stealth_func("go_to_node_wait", &go_to_node_wait);
  level scripts\stealth\utility::set_stealth_func("go_to_node_arrive", &go_to_node_arrived);
  level scripts\stealth\utility::set_stealth_func("go_to_node_post_wait", &go_to_node_post_wait);
  level scripts\stealth\utility::set_stealth_func("reset", &alertlevel_normal);
  level scripts\stealth\utility::set_stealth_func("set_patrol_style", &scripts\stealth\utility::set_patrol_style);
  level scripts\stealth\utility::set_stealth_func("trigger_cover_blown", &trigger_cover_blown);
  level scripts\stealth\utility::set_stealth_func("set_blind", &set_blind);
  level scripts\stealth\utility::set_stealth_func("investigate", &bt_event_handler_severity);
  level scripts\stealth\utility::set_stealth_func("cover_blown", &bt_event_handler_severity);
  level scripts\stealth\utility::set_stealth_func("combat", &bt_event_handler_severity);
}

function monitor_damage_thread(var0, var1) {
  var2 = undefined;
  var3 = self.team;

  for(;;) {
    if(!isalive(self)) {
      return;
    }

    self waittill("damage", var4, var5, var6, var7);
    check_kill_damage(var4, var5, var7);
    var8 = self.origin;

    if(isalive(self) && !scripts\engine\utility::ent_flag("stealth_enabled")) {
      continue;
    }

    if(isalive(var5)) {
      var2 = var5;
    }

    if(!isDefined(var2)) {
      continue;
    }

    self aieventlistenerevent("damage", var2, var2.origin);

    if(isPlayer(var2) || isDefined(var2.team) && var2.team != var3) {
      break;
    }

    if(isDefined(var2.classname) && var2.classname == "script_model") {
      if(var2.isbarrel) {
        break;
      }
    }
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.stealth.override_damage_auto_range)) {
    var0 = self.stealth.override_damage_auto_range;
  } else if(isDefined(level.stealth.override_damage_auto_range)) {
    var0 = level.stealth.override_damage_auto_range;
  }

  if(isDefined(self.stealth.override_damage_sight_range)) {
    var1 = self.stealth.override_damage_sight_range;
  } else if(isDefined(level.stealth.override_damage_sight_range)) {
    var1 = level.stealth.override_damage_sight_range;
  }

  if(isalive(self)) {
    scripts\stealth\event::event_broadcast_axis("ally_damaged", "ally_hurt_peripheral", var2, var0, var1);
    return;
  }

  scripts\stealth\event::event_broadcast_axis("ally_killed", "ally_hurt_peripheral", var2, var0, var1);
}

function check_kill_damage(var0, var1, var2) {
  if(isDefined(self.disableeasystealthheadshot)) {
    return;
  }

  if(var0 > 0 && self.damagemod != "MOD_MELEE" && self.alertlevelscript != "attack" && self.alertlevelscript != "combat") {
    var3 = self getEye();

    if(distancesquared(var2, var3) < squared(level.stealth.head_shot_dist)) {
      self dodamage(self.health, var2, var1, var1, "MOD_HEAD_SHOT");
      return;
    }

    return;
  }
}

function shotisreasonablysafe(var0) {
  var1 = getaiunittypearray("bad_guys", "all");
  var2 = [];
  var3 = squared(level.stealth.damage_auto_range);
  var4 = squared(level.stealth.damage_sight_range);

  foreach(var6 in var1) {
    if(var6 == var0) {
      continue;
    }

    var7 = distancesquared(var0.origin, var6.origin);

    if(var7 < var3) {
      return false;
    }

    if(var7 < var4) {
      if(var6 getthreatsight(self) > 0) {
        return false;
      }

      if(var6 scripts\engine\math::point_in_fov(var0.origin, 0) && var6 hastacvis(var0)) {
        return false;
      }

      var2 = var6;
    }
  }

  foreach(var6 in var2) {
    if(var6 cansee(var0)) {
      return false;
    }
  }

  return true;
}

function shotisbadidea(var0) {
  var1 = getaiunittypearray("bad_guys", "all");
  var2 = [];
  var3 = squared(level.stealth.damage_auto_range);
  var4 = squared(level.stealth.damage_sight_range);

  foreach(var6 in var1) {
    if(var6 == var0) {
      continue;
    }

    var7 = distancesquared(var0.origin, var6.origin);

    if(var7 < var3) {
      return true;
    }

    if(var7 < var4) {
      if(var6 getthreatsight(self) > 0) {
        return true;
      }

      if(var6 scripts\engine\math::point_in_fov(var0.origin, 0)) {
        if(var6 hastacvis(var0)) {
          return true;
        }

        var2 = var6;
      }
    }
  }

  foreach(var6 in var2) {
    if(var6 cansee(var0)) {
      return true;
    }
  }

  return false;
}

function headtrack_player_toggle(var0) {
  if(var0) {
    if(!isDefined(self.stealth.allowplayerheadtracking)) {
      self.stealth.allowplayerheadtracking = 1;
    } else if(!self.stealth.allowplayerheadtracking) {
      return;
    }

    if(!isDefined(self.stealth.looking_at_entity)) {
      self.stealth.looking_at_entity = level.player;
    }

    scripts\common\utility::lookatentity(level.player);
    return;
  }

  if(isDefined(self.stealth.looking_at_entity)) {
    self.stealth.looking_at_entity = undefined;
    scripts\common\utility::lookatentity();
    return;
  }
}

function lock_player_headtracking_off(var0) {
  self endon("death");
  self notify("lock_headtracking_off");
  self endon("lock_headtracking_off");
  disable_player_headtracking();
  wait var0;
  enable_player_headtracking();
}

function disable_player_headtracking() {
  self.stealth.allowplayerheadtracking = 0;
  headtrack_player_toggle(0);
}

function enable_player_headtracking() {
  self.stealth.allowplayerheadtracking = 1;
}

function event_handler_should_ignore(var0) {
  var1 = self.stealth.event_severity_min;

  if(!isDefined(var1)) {
    var1 = level.stealth.event_severity_min;
  }

  if(isDefined(var1)) {
    var2 = scripts\stealth\event::event_severity_compare(var1, var0.type);

    if(var2 > 0) {
      return 1;
    }
  }

  if(istrue(level.stealth.disguised) && event_override_disguise(var0)) {
    return 1;
  }

  if(var0.typeorig == "explode") {
    if(isDefined(var0.entity) && isDefined(var0.entity.team) && var0.entity.team == self.team) {
      return 1;
    }
  }

  if(var0.typeorig == "footstep_sprint") {
    if(should_ignore_sprint_footstep(var0)) {
      return 1;
    }
  }

  if(var0.typeorig == "silenced_shot") {
    if(isPlayer(var0.entity) && distancesquared(var0.entity getEye(), var0.origin) > 1296) {
      return 1;
    }
  }

  if(var0.typeorig == "gunshot" || var0.typeorig == "gunshot_teammate" || var0.typeorig == "bulletwhizby") {
    if(isai(var0.entity) && var0.entity isinscriptedstate()) {
      return 1;
    }
  }

  if(istrue(scripts\stealth\callbacks::stealth_call("event_should_ignore", var0))) {
    return 1;
  }

  var3 = scripts\stealth\callbacks::stealth_get_func("event_" + var0.type);

  if(isDefined(var3)) {
    return scripts\stealth\callbacks::stealth_call("event_" + var0.type, var0);
  }

  return 0;
}

function should_ignore_sprint_footstep(var0) {
  var1 = (0, 0, 18);
  var2 = level.stealth.cantracetoaiignoreents;

  if(isDefined(self.stealth.cantracetoaiignoreents)) {
    var2 = scripts\engine\utility::array_combine(var2, self.stealth.cantracetoaiignoreents);
  }

  if(isPlayer(var0.entity) && scripts\engine\utility::can_trace_to_ai(var0.origin + var1, self, var2)) {
    var3 = distancesquared(self.origin, var0.origin);
    var4 = 250;

    if(isDefined(self.sprintfootstepradius)) {
      var4 = self.sprintfootstepradius;
    }

    if(var3 < var4 * var4) {
      return false;
    }

    var5 = self cansee(var0.entity);

    if(!var5 && var0.entity scripts\stealth\threat_sight::player_is_sprinting_at_me(self)) {
      return false;
    }
  }

  return true;
}

function event_override_disguise(var0) {
  if(issentient(var0.entity)) {
    switch (var0.typeorig) {
      case "footstep_walk":
      case "footstep":
      case "footstep_sprint":
      case "proximity":
        thread scripts\stealth\threat_sight::threat_sight_force_visible(var0.entity, 1);
        return true;
    }
  }

  return false;
}

function event_override_controlling_robot(var0) {
  if(issentient(var0.entity)) {
    switch (var0.typeorig) {
      case "proximity":
        return true;
      case "silenced_shot":
      case "projectile_impact":
      case "gunshot":
      case "grenade danger":
      case "bulletwhizby":
      case "explode":
        var0.type = "combat";
        return false;
    }
  }

  if(var0.type != "combat") {
    return true;
  }

  return false;
}

function event_anyone_within_radius(var0, var1) {
  var2 = var1 * var1;
  var3 = getaiunittypearray("bad_guys", "all");

  foreach(var5 in var3) {
    if(distancesquared(var0, var5.origin) <= var2) {
      return true;
    }
  }

  return false;
}

function event_handler_translate_severity(var0) {
  if(!isDefined(var0) || !isDefined(var0.typeorig)) {
    return;
  }

  if(self[[self.fnisinstealthhunt]]()) {
    if(var0.type == "investigate") {
      var0.type = "cover_blown";
    }
  }

  switch (var0.typeorig) {
    case "sight":
      if(self.subclass == "dog") {
        var0.type = "investigate";
      } else if(isDefined(self.stealth.threat_sight_lost)) {
        var1 = undefined;

        if(isDefined(var0.entity) && issentient(var0.entity)) {
          var1 = var0.entity getentitynumber();
        }

        if(isDefined(var1) && isDefined(self.stealth.threat_sight_lost[var1]) && self.stealth.threat_sight_lost[var1] == 0) {
          var2 = var0.entity;

          if(isPlayer(var0.entity)) {
            var3 = var0.entity scripts\stealth\utility::quickdropnewitem();

            if(isDefined(var3) && !self cansee(var0.entity)) {
              var2 = var3;
            }
          }

          self getenemyinfo(var2);
          var0.type = "combat";
        }
      }

      break;
    case "grenade danger":
      if(event_anyone_within_radius(var0.origin, 128)) {
        var0.type = "combat";
      }

      break;
    case "explode":
      if(event_anyone_within_radius(var0.origin, 192)) {
        var0.type = "combat";
      } else if(distancesquared(var0.origin, self.origin) <= 1048576) {
        var0.type = "combat";
      }

      break;
    case "gunshot":
      if(distancesquared(var0.origin, self.origin) < 640000) {
        var0.type = "combat";
      }

      break;
    case "glass_destroyed":
      if(self hastacvis(var0.origin, 0) && distance2dsquared(var0.origin, self.origin) < 36864) {
        var0.type = "combat";
      }

      break;
  }
}

function trigger_cover_blown(var0, var1) {
  if(!isDefined(self.stealth)) {
    return;
  }

  self.stealth.bcoverhasbeenblown = 1;
  self.stealth.bdocoverblownreaction = var1;
}

function react_announce(var0) {
  self endon("death");
  var1 = randomfloatrange(0.5, 1.1);

  switch (var0.type) {
    case "investigate":
      thread scripts\stealth\utility::addeventplaybcs("stealth", "announce5", "investigate", var1);
      return true;
    case "cover_blown":
      thread scripts\stealth\utility::addeventplaybcs("stealth", "announce5", "coverblown", var1);
      return true;
    case "combat":
      thread scripts\stealth\utility::addeventplaybcs("stealth", "announce2", "combat", 1);
      return true;
  }

  return false;
}

function react_announce_specific(var0) {
  self endon("death");

  if(isDefined(var0.typeorig)) {
    var1 = randomfloatrange(0.5, 1);

    switch (var0.typeorig) {
      case "sight":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce2", "sight", var1);
        return true;
      case "explode":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce1", "explosion", var1);
        return true;
      case "grenade danger":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce2", "grenade_danger", var1);
        return true;
      case "seek_backup":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce4", "seek_backup", randomfloatrange(2, 2.5), var0);
        return true;
      case "found_corpse":
      case "saw_corpse":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce4", var0.typeorig, var1);
        return true;
      case "unresponsive_teammate":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce4", "unresponsive_teammate");
        return true;
      case "bulletwhizby":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce2", "bulletwhizby", 0.2, var0);
        return true;
      case "silenced_shot":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce2", "silenced_shot", randomfloatrange(0.8, 1.3), var0);
        return true;
      case "gunshot":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce1", "gunshot", 0.2, var0);
        return true;
      case "gunshot_teammate":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce1", "gunshot_teammate", 0.2, var0);
        return true;
      case "ally_damaged":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce1", "gunshot", randomfloatrange(0.8, 1.3), var0);
        return true;
      case "ally_killed":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce1", "ally_killed", 0.5);
        return true;
      case "proximity":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce1", "proximity", 0.5);
        return true;
      case "footstep":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce5", "footstep", var1);
        return true;
      case "footstep_sprint":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce5", "footstep_sprint", var1);
        return true;
      case "light_killed":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce4", "light_killed", var1);
        return true;
      case "glass_destroyed":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce4", "glass_destroyed", var1);
        return true;
      case "window_open":
        thread scripts\stealth\utility::addeventplaybcs("stealth", "announce4", "window_open", var1);
        return true;
      case "damage":
        return true;
      default:
        break;
    }
  }

  return false;
}

function go_to_node_wait_investigate(var0, var1, var2) {
  self endon("death");

  if(!isDefined(var2)) {
    var2 = 1;
  }

  var3 = !var2;

  while(scripts\stealth\utility::stealth_behavior_active() || !var3) {
    scripts\stealth\utility::stealth_behavior_wait();
    self[[var0]](var1);
    var3 = 1;
    self waittill("goal");
  }
}

function go_to_node_wait(var0, var1) {
  self endon("death");
  self._blackboard.idlenode = undefined;
  go_to_node_wait_investigate(var0, var1);
}

function go_to_node_post_wait(var0, var1) {
  self endon("death");
  self notify("gotonode_post_wait");

  if(isDefined(self.stealth.idle) && isDefined(var1.target)) {}

  if(isDefined(var1.target)) {
    self._blackboard.idlenode = undefined;
    return;
  }
}

function go_to_node_arrived(var0, var1) {
  go_to_node_wait_investigate(var0, var1, 0);

  if(isDefined(var1.script_moveplaybackrate)) {
    self.moveplaybackrate = var1.script_moveplaybackrate;
  }

  if((istrue(var1.script_delay) || istrue(var1.script_delay_min) || istrue(var1.script_wait) || isDefined(var1.script_idle) || istrue(var1.patrol_stop) || !isDefined(var1.target)) && isDefined(var1.angles)) {
    self._blackboard.idlenode = var1;

    if(!istrue(var1.script_delay) && !istrue(var1.script_wait)) {
      waitframe();
    }
  }

  if(isDefined(var1.script_animation)) {
    var2 = var1.script_animation;
    scripts\stealth\utility::animgenericcustomanimmode(self, "gravity", var2);
  } else if(isDefined(var1.script_idle)) {
    self._blackboard.idlenode = var1;
  }

  if(isDefined(var1.script_animation_exit)) {
    scripts\stealth\utility::animgenericcustomanimmode(self, "gravity", var1.script_animation_exit);
    return;
  }
}

function setpatrolstyle_base() {
  var0 = scripts\stealth\utility::get_patrol_style_default();
  var1 = isDefined(var0) && var0 != "unaware";
  var2 = scripts\stealth\group::getgroup(self.script_stealthgroup);

  if(var1 || isDefined(self.stealth.bcoverhasbeenblown) || isDefined(var2.bcoverhasbeenblown)) {
    var3 = isDefined(self.stealth.bdocoverblownreaction) && self.stealth.bdocoverblownreaction;
    var4 = scripts\asm\asm::asm_getdemeanor() == "patrol" && var3;
    scripts\stealth\utility::set_patrol_style("alert", var4, undefined, "small");
    return;
  }

  scripts\stealth\utility::set_patrol_style("unaware");
}

function bt_set_stealth_state(var0, var1) {
  self[[self.fnsetstealthstate]](var0, var1);
}

function bt_event_handler_severity(var0) {
  var1 = undefined;

  if(isPlayer(var0.entity) && var0.typeorig == "sight") {
    var2 = var0.entity scripts\stealth\utility::quickdropnewitem();

    if(isDefined(var2) && !self cansee(var0.entity)) {
      var1 = var2;
    }
  }

  var0.investigate_pos = var0.origin;

  if(isDefined(self.enemy) && isDefined(var0.entity) && var0.entity == self.enemy) {
    var0.investigate_pos = self lastknownpos(self.enemy);
  } else if(isDefined(var0.entity) && var0.typeorig == "bulletwhizby") {
    var0.investigate_pos = var0.entity.origin;
  } else if(isDefined(var1)) {
    var0.investigate_pos = var1.origin;
  }

  event_handler_translate_severity(var0);

  if(event_handler_should_ignore(var0)) {
    return false;
  }

  if(isDefined(var1)) {
    var0.entity = var1;
  }

  self.stealth.last_severity_time = gettime();

  if(!scripts\stealth\utility::bcisincombat()) {
    if(!react_announce_specific(var0)) {
      react_announce(var0);
    }
  }

  switch (var0.type) {
    case "investigate":
      thread bt_event_investigate(var0);
      break;
    case "cover_blown":
      thread bt_event_cover_blown(var0);
      break;
    case "combat":
      thread bt_event_combat(var0);
      break;
  }

  level notify("stealth_event", var0, self);
  var3 = scripts\stealth\callbacks::stealth_get_func(var0.typeorig);

  if(isDefined(var3) && var3 != &bt_event_handler_severity) {
    self thread[[var3]](var0);
  }

  return true;
}

function bt_event_investigate(var0) {
  set_alert_level("warning1");
  bt_set_stealth_state("investigate", var0);
}

function bt_event_cover_blown(var0) {
  set_alert_level("warning2");

  if(isDefined(var0.entity) && isDefined(var0.entity.classname) && var0.entity.classname == "script_vehicle_blackhornet") {
    return;
  }

  if(istrue(level.stealth.disguised)) {
    switch (var0.typeorig) {
      case "silenced_shot":
      case "gunshot":
      case "explode":
        scripts\stealth\utility::set_disguised(0);
        level scripts\engine\utility::delaythread(20, &scripts\stealth\utility::set_disguised, 1);
        break;
    }
  }

  if(var0.typeorig == "light_killed") {
    var0.look_pos = var0.investigate_pos;
    var0.investigate_pos = scripts\engine\utility::drop_to_ground(var0.investigate_pos, 24, -256);
  }

  if(!self[[self.fnisinstealthcombat]]()) {
    if(self[[self.fnisinstealthhunt]]()) {
      var1 = scripts\stealth\group::group_updatepodhuntorigin(self, var0.investigate_pos);

      if(!isDefined(self.pathgoalpos) || distancesquared(var1, self.pathgoalpos) > 576) {
        scripts\asm\asm::asm_fireephemeralevent("hunt", "knownpos", var0.investigate_pos);
        scripts\stealth\utility::set_patrol_react(var0.investigate_pos, "small");
        return;
      }

      return;
    }

    bt_set_stealth_state("investigate", var0);
    return;
  }
}

function bt_event_combat(var0) {
  self notify("investigate_behavior");
  self notify("stop_going_to_node");
  set_alert_level("attack");
  bt_set_stealth_state("combat", var0);

  if(isDefined(var0) && issentient(var0.entity)) {
    if(!isDefined(self.enemy)) {
      self resetthreatupdate();
    }

    thread set_provide_cover_fire();
  }

  scripts\engine\utility::ent_flag_set("stealth_attack");
}

function set_provide_cover_fire() {
  self.providecoveringfire = 1;
  self endon("death");
  self endon("stealth_investigate");
  self endon("stealth_hunt");
  self endon("stealth_combat");
  wait 5;
  self.providecoveringfire = 0;
}