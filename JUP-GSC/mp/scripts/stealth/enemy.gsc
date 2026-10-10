/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\stealth\enemy.gsc
***********************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\gameskill;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\stealth\callbacks;
#using scripts\stealth\corpse;
#using scripts\stealth\debug;
#using scripts\stealth\door;
#using scripts\stealth\event;
#using scripts\stealth\group;
#using scripts\stealth\threat_sight;
#using scripts\stealth\utility;
#namespace enemy;

function main() {
  init_settings();
  init_flags();
  scripts\stealth\group::addtogroup(self.script_stealthgroup, self);

  if(!istrue(self.var_b19befc7a8bfc30f)) {
    self function_4db6fc194702d153();
  }

  scripts\stealth\event::event_init_entity();
  thread monitor_damage_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
  self function_1aff80c5fc5a3eea("noncombat");
  bt_set_stealth_state("idle");
  stealth_init_goal_radius();

  thread debug_enemy();

  if(isDefined(self.fnstealthflashlighton)) {
    self.stealth.funcs["flashlight_on"] = self.fnstealthflashlighton;
  }

  if(isDefined(self.fnstealthflashlightoff)) {
    self.stealth.funcs["flashlight_off"] = self.fnstealthflashlightoff;
  }

  if(isDefined(self.var_5221cb0637cd44e7)) {
    self.stealth.funcs["flashlight_attach"] = self.var_5221cb0637cd44e7;
  }

  if(isDefined(self.fnstealthflashlightdetach)) {
    self.stealth.funcs["flashlight_detach"] = self.fnstealthflashlightdetach;
  }

  self.stealth.funcs["on_state_change"] = &onstatechange;

  if(getdvarint(@ "hash_3dd93292c69a9d62", 0) == 0) {
    self.stealth_groupname = self.script_stealthgroup;
  }

  if(getdvarint(@ "hash_6109644d57e1122e", 0)) {
    thread scripts\stealth\door::suspicious_door_thread();
  }

  if(isDefined(level.stealth) && isDefined(level.stealth.var_b164de1a339a2b06) && !(isDefined(self.aisettings) && isDefined(self.aisettings.var_4975344f645984a6))) {
    self function_d493e7fe15e5eaf4(level.stealth.var_b164de1a339a2b06);
  }

  if(isDefined(level.var_4fa3c4eb77c24130)) {
    self[[level.var_4fa3c4eb77c24130]]();
  }

  if(isDefined(level.stealth.fninitenemygame)) {
    self thread[[level.stealth.fninitenemygame]]();
  }
}

function init_flags() {
  ent_flag_init("stealth_enabled");
  ent_flag_set("stealth_enabled");
  scripts\stealth\utility::group_flag_init("stealth_spotted");
}

function stealth_init_goal_radius() {
  if(isDefined(self.goalradius)) {
    return;
  }

  if(isDefined(self.script_radius)) {
    self.goalradius = self.script_radius;
    return;
  }

  if(isDefined(self.script_goalradius)) {
    self.goalradius = self.script_goalradius;
    return;
  }

  if(!isDefined(self getgoalvolume())) {
    self.goalradius = level.default_goalradius;
  }
}

function init_settings() {
  self.stealth = spawnStruct();
  self.stealth_enabled = 1;
  self.var_fe5ebefa740c7106 = 4;
  self.stealth.funcs = [];
  self.stealth.max_warnings = 2;

  self.stealth.ai_event = "<dev string:x1c>";
  self.stealth.var_4fc268e229e1af6c = "<dev string:x1c>";

  var_8c591f1bde417eb4 = function_61b03c8c194a6733("hidden", "footstep_sprint");
  self.newenemyreactiondistsq = ter_op(isDefined(var_8c591f1bde417eb4), var_8c591f1bde417eb4, squared(function_9d30fd63965bafa9("footstep_sprint", undefined)));
  scripts\stealth\corpse::corpse_init_entity();
  self.event_escalation_scalar = 0;

  if(!isDefined(level.stealth.damage_auto_range)) {
    level.stealth.damage_auto_range = 240;
  }

  if(!isDefined(level.stealth.damage_sight_range)) {
    level.stealth.damage_sight_range = 750;
  }

  self.grenadeawareness = 0;
  self.canacquirenearbytacvisenemies = 0;
}

function death_cleanup() {
  if(isDefined(self)) {
    self function_24cb3b5e0d4216b1("death");
  }

  if(isDefined(self.stealth_vo_ent)) {
    self.stealth_vo_ent thread death_vo_cleanup();
  }
}

function death_vo_cleanup() {
  self stopsounds();
  waitframe();
  self delete();
}

function add_active_sense_function(function) {
  assertex(isDefined(self.stealth), "<dev string:x20>" + self getentitynumber() + "<dev string:x43>" + self.origin);

  if(!isDefined(self.stealth.active_sense_funcs)) {
    self.stealth.active_sense_funcs = [];
  }

  self.stealth.active_sense_funcs[self.stealth.active_sense_funcs.size] = function;
}

function set_blind(blind, force) {
  if(!isDefined(self.stealth)) {
    return;
  }

  if(!blind && !istrue(self.stealthblind)) {
    return;
  }

  var_238c192f07833950 = isDefined(self.fnisinstealthcombat) && self[[self.fnisinstealthcombat]]();
  var_2e660c634ae5407d = isDefined(self.fnisinstealthhunt) && self[[self.fnisinstealthhunt]]();
  iscombat = var_238c192f07833950 || var_2e660c634ae5407d;

  if(blind && (!iscombat || istrue(force))) {
    self.stealthblind = 1;
    self function_ea50442798fca4c1("blind");
    return;
  }

  self.stealthblind = 0;

  if(iscombat) {
    self function_ea50442798fca4c1("spotted");
    return;
  }

  self function_ea50442798fca4c1("hidden");
}

function alertlevel_normal(param) {
  thread scripts\stealth\utility::addeventplaybcs("stealth", "announce5", "alertreset");
  self function_1aff80c5fc5a3eea("noncombat");
  bt_set_stealth_state("idle");
  scripts\stealth\utility::function_783cf2a7aaab23c();
}

function set_default_stealth_funcs() {
  level scripts\stealth\utility::set_stealth_func("go_to_node_wait", &go_to_node_wait);
  level scripts\stealth\utility::set_stealth_func("go_to_node_arrive", &go_to_node_arrived);
  level scripts\stealth\utility::set_stealth_func("go_to_node_post_wait", &go_to_node_post_wait);
  level scripts\stealth\utility::set_stealth_func("reset", &alertlevel_normal);
  level scripts\stealth\utility::set_stealth_func("set_patrol_style", &scripts\stealth\utility::set_patrol_style);
  level scripts\stealth\utility::set_stealth_func("trigger_cover_blown", &trigger_cover_blown);
  level scripts\stealth\utility::set_stealth_func("investigate", &bt_event_handler_severity);
  level scripts\stealth\utility::set_stealth_func("cover_blown", &bt_event_handler_severity);
  level scripts\stealth\utility::set_stealth_func("combat", &bt_event_handler_severity);
  level scripts\stealth\utility::set_stealth_func("finish", &function_dfdec2ff9ba6b863);
  level scripts\stealth\utility::set_stealth_func("override_should_ignore", &function_d83f0e5272e07d8c);
}

function monitor_damage_thread(rangeauto, rangesight) {
  team = self.team;

  while(isalive(self)) {
    other = undefined;

    while(true) {
      if(!isalive(self)) {
        return;
      }

      self waittill("damage", dmg, attacker, null, point, type);
      check_kill_damage(dmg, attacker, point);
      event_spot = self.origin;

      if(isalive(self) && !ent_flag("stealth_enabled")) {
        continue;
      }

      if(isalive(attacker)) {
        other = attacker;
      }

      if(!isDefined(other)) {
        continue;
      }

      if(istrue(stealth_call("damage", dmg, attacker, type))) {
        continue;
      }

      self aieventlistenerevent("damage", other, other.origin);

      if(isPlayer(other) || isDefined(other.team) && other.team != team) {
        break;
      }

      if(isDefined(other.classname) && other.classname == "script_model") {
        if(istrue(other.isbarrel)) {
          break;
        }
      }
    }

    if(!isDefined(self) || !isDefined(self.stealth)) {
      return;
    }

    if(isDefined(self.stealth.override_damage_auto_range)) {
      rangeauto = self.stealth.override_damage_auto_range;
    } else if(isDefined(level.stealth.override_damage_auto_range)) {
      rangeauto = level.stealth.override_damage_auto_range;
    }

    if(isDefined(self.stealth.override_damage_sight_range)) {
      rangesight = self.stealth.override_damage_sight_range;
    } else if(isDefined(level.stealth.override_damage_sight_range)) {
      rangesight = level.stealth.override_damage_sight_range;
    }

    if(isalive(self)) {
      function_aad7a0ea8ac4ca23("ally_damaged", self, other, rangeauto, rangesight, type);
      continue;
    }

    function_aad7a0ea8ac4ca23("ally_killed", self, other, rangeauto, rangesight, type);
  }
}

function check_kill_damage(damage, attacker, origin) {
  if(isDefined(self.disableeasystealthheadshot)) {
    return;
  }

  if(damage > 0 && self.damagemod != "MOD_MELEE" && self.damagemod != "MOD_IMPACT" && self.alertlevel != "combat") {
    eyepos = self getEye();

    if(distancesquared(origin, eyepos) < squared(level.stealth.head_shot_dist)) {
      self dodamage(self.health, origin, attacker, attacker, "MOD_HEAD_SHOT");
      self.stealth.override_damage_auto_range = 128;
    }
  }
}

function shotisreasonablysafe(target) {
  guys = getaiunittypearray("bad_guys", "all");
  potentialguys = [];
  var_61337b0b147086d7 = squared(level.stealth.damage_auto_range);
  var_6b29dceda0f0afaf = squared(level.stealth.damage_sight_range);

  foreach(guy in guys) {
    if(guy == target) {
      continue;
    }

    var_ec59b0d4c5cf7b28 = distancesquared(target.origin, guy.origin);

    if(var_ec59b0d4c5cf7b28 < var_61337b0b147086d7) {
      return false;
    }

    if(var_ec59b0d4c5cf7b28 < var_6b29dceda0f0afaf) {
      if(guy getthreatsight(self) > 0) {
        return false;
      }

      if(guy math::point_in_fov(target.origin, 0) && guy hastacvis(target)) {
        return false;
      }

      potentialguys[potentialguys.size] = guy;
    }
  }

  foreach(guy in potentialguys) {
    if(guy cansee(target)) {
      return false;
    }
  }

  return true;
}

function shotisbadidea(target) {
  guys = getaiunittypearray("bad_guys", "all");
  potentialguys = [];
  var_61337b0b147086d7 = squared(level.stealth.damage_auto_range);
  var_6b29dceda0f0afaf = squared(level.stealth.damage_sight_range);

  foreach(guy in guys) {
    if(guy == target) {
      continue;
    }

    var_ec59b0d4c5cf7b28 = distancesquared(target.origin, guy.origin);

    if(var_ec59b0d4c5cf7b28 < var_61337b0b147086d7) {
      return true;
    }

    if(var_ec59b0d4c5cf7b28 < var_6b29dceda0f0afaf) {
      if(guy getthreatsight(self) > 0) {
        return true;
      }

      if(guy math::point_in_fov(target.origin, 0)) {
        if(guy hastacvis(target)) {
          return true;
        }

        potentialguys[potentialguys.size] = guy;
      }
    }
  }

  foreach(guy in potentialguys) {
    if(guy cansee(target)) {
      return true;
    }
  }

  return false;
}

function headtrack_player_toggle(bool) {
  if(bool) {
    if(!isDefined(self.stealth.allowplayerheadtracking)) {
      self.stealth.allowplayerheadtracking = 1;
    } else if(!self.stealth.allowplayerheadtracking) {
      return;
    }

    if(!isDefined(self.stealth.looking_at_entity)) {
      self.stealth.looking_at_entity = level.player;
    }

    utility::lookatentity(level.player);
    return;
  }

  if(isDefined(self.stealth.looking_at_entity)) {
    self.stealth.looking_at_entity = undefined;
    utility::lookatentity();
  }
}

function lock_player_headtracking_off(duration) {
  self endon("death");
  self notify("lock_headtracking_off");
  self endon("lock_headtracking_off");
  disable_player_headtracking();
  wait duration;
  enable_player_headtracking();
}

function disable_player_headtracking() {
  self.stealth.allowplayerheadtracking = 0;
  headtrack_player_toggle(0);
}

function enable_player_headtracking() {
  self.stealth.allowplayerheadtracking = 1;
}

function event_handler_should_ignore(event) {
  event_severity_min = self.stealth.event_severity_min;

  if(!isDefined(event_severity_min)) {
    event_severity_min = level.stealth.event_severity_min;
  }

  if(isDefined(event_severity_min)) {
    diff = scripts\stealth\event::event_severity_compare(event_severity_min, event.type);

    if(diff > 0) {
      return 1;
    }
  }

  if(event.typeorig == "explosion") {
    if(isDefined(event.entity) && isDefined(event.entity.team) && event.entity.team == self.team) {
      return 1;
    }
  }

  if(event.typeorig == "footstep" || event.typeorig == "footstep_walk") {
    if(function_44f457c9d6a9d038(event)) {
      return 1;
    }
  }

  if(event.typeorig == "footstep_sprint") {
    if(should_ignore_sprint_footstep(event)) {
      return 1;
    }
  }

  if(event.typeorig == "silenced_shot") {
    if(isPlayer(event.entity) && distancesquared(event.entity getEye(), event.origin) > 1296) {
      return 1;
    }
  }

  if(event.typeorig == "gunshot" || event.typeorig == "gunshot_impact" || event.typeorig == "gunshot_teammate" || event.typeorig == "bulletwhizby") {
    if(isagent(event.entity) && event.entity isinscriptedstate()) {
      return 1;
    }
  }

  return function_d83f0e5272e07d8c(event);
}

function function_d83f0e5272e07d8c(event) {
  if(istrue(stealth_call("event_should_ignore", event))) {
    return 1;
  }

  var_3d816d7a91186fbb = stealth_get_func("event_" + event.type);

  if(isDefined(var_3d816d7a91186fbb)) {
    originaleventtype = event.type;
    originaleventname = event.typeorig;
    bignore = stealth_call("event_" + event.type, event);

    if(isDefined(event.typeorig)) {
      function_6eb2235636d28921(event.typeorig, event.entity, self, event.type, event.origin, event.investigate_pos);
    } else {
      assertmsg("<dev string:x4f>" + originaleventtype + "<dev string:xc4>" + originaleventname);
    }

    return bignore;
  }

  return 0;
}

function function_44f457c9d6a9d038(event) {
  if(!isPlayer(event.entity)) {
    return true;
  }

  if(event.entity getstance() != "stand") {
    return true;
  }

  return false;
}

function should_ignore_sprint_footstep(event) {
  if(isPlayer(event.entity)) {
    dist_sq = distancesquared(self.origin, event.origin);
    traceoffset = (0, 0, 18);
    ignoreents = array_combine(function_67e2b3dda1bee8a(), self function_e2fc2d773338e90f());
    var_4513d58533339de5 = self function_be2f606dbaa90a7d(event.entity, "footstep");

    if(dist_sq < var_4513d58533339de5 * var_4513d58533339de5) {
      return false;
    } else if(can_trace_to_ai(event.origin + traceoffset, self, ignoreents)) {
      if(isDefined(self.sprintfootstepradius)) {
        sprintfootstepradius = self.sprintfootstepradius;

        if(dist_sq < sprintfootstepradius * sprintfootstepradius) {
          return false;
        }
      }

      playervisible = self cansee(event.entity);

      if(!playervisible && self function_89931185060d4d6f(event.entity)) {
        return false;
      }
    }
  }

  return true;
}

function event_override_disguise(event) {
  if(issentient(event.entity)) {
    switch (event.typeorig) {
      case #"hash_161d2d6c65d1cc82":
      case #"hash_37d1562da9bab005":
      case #"hash_52ad2c78c47fbfc8":
      case #"hash_9715afcc5dd0e063":
        thread threat_sight_force_visible(event.entity, 1);
        return true;
    }
  }

  return false;
}

function event_override_controlling_robot(event) {
  if(issentient(event.entity)) {
    switch (event.typeorig) {
      case #"hash_161d2d6c65d1cc82":
        return true;
      case #"hash_1d0022d9b49074c0":
      case #"hash_1de3ab20a61203e4":
      case #"hash_412938e72fd9ab35":
      case #"hash_46bae15508b25675":
      case #"hash_937c75a05af24ea4":
      case #"hash_c910677ee9c31085":
      case #"hash_de811d1d5fa7e6b4":
      case #"hash_ea10345acf995244":
        event.type = "combat";
        return false;
    }
  }

  if(event.type != "combat") {
    return true;
  }

  return false;
}

function event_anyone_within_radius(eventorigin, dist) {
  distsq = dist * dist;
  ais = getaiunittypearray("bad_guys", "all");

  foreach(ai in ais) {
    if(distancesquared(eventorigin, ai.origin) <= distsq) {
      return true;
    }
  }

  return false;
}

function event_handler_translate_severity(event) {
  if(!isDefined(event) || !isDefined(event.typeorig)) {
    return;
  }

  if(self[[self.fnisinstealthhunt]]()) {
    if(event.type == "investigate") {
      event.type = "cover_blown";
    }
  }

  switch (event.typeorig) {
    case #"hash_641050446d8ad59e":
      if(self.unittype == "dog") {
        event.type = "investigate";
      } else {
        var_926a11e24ff33ab5 = undefined;

        if(isDefined(event.entity) && issentient(event.entity)) {
          var_926a11e24ff33ab5 = event.entity getentitynumber();
        }

        if(isDefined(var_926a11e24ff33ab5) && self function_f4d54a90334a7dea(event.entity, 2)) {
          var_24b0344b8d70d598 = event.entity;

          if(isPlayer(event.entity)) {
            drone = event.entity scripts\stealth\utility::get_player_drone();

            if(isDefined(drone) && !self cansee(event.entity)) {
              var_24b0344b8d70d598 = drone;
            }
          }

          self getenemyinfo(var_24b0344b8d70d598);
          event.type = "combat";
        }
      }

      break;
    case #"hash_ea10345acf995244":
      if(isDefined(event.entity) && is_equal(event.entity.model, "offhand_1h_wm_bottle_v0")) {
        event.type = "cover_blown";
      } else if(event_anyone_within_radius(event.origin, 128)) {
        event.type = "combat";
      }

      break;
    case #"hash_1d0022d9b49074c0":
      if(event_anyone_within_radius(event.origin, 192)) {
        event.type = "combat";
      } else if(distancesquared(event.origin, self.origin) <= 1048576) {
        event.type = "combat";
      }

      break;
    case #"hash_412938e72fd9ab35":
      if(distancesquared(event.origin, self.origin) < 640000) {
        event.type = "combat";
      }

      break;
    case #"hash_eaa4394d31c175bf":
      if(self hastacvis(event.origin, 0) && distance2dsquared(event.origin, self.origin) < 36864) {
        event.type = "combat";
      }

      break;
  }
}

function trigger_cover_blown(event) {
  if(!isDefined(self.stealth)) {
    return;
  }

  self.var_e31ee88092e41cc8 = 1;
}

function react_announce(event) {
  self endon("death");
  delaytime = randomfloatrange(0.5, 1.1);

  switch (event.type) {
    case #"hash_e21b072df2b47f94":
      thread scripts\stealth\utility::addeventplaybcs("stealth", "announce5", "investigate", delaytime, event);
      println("<dev string:xd5>" + self getentitynumber() + "<dev string:xf0>" + event.typeorig + "<dev string:x124>");

      scripts\stealth\debug::function_ec780a18fdfb4982(self, "<dev string:x147>");

      return true;
    case #"hash_f796130a9b9cec5":
      thread scripts\stealth\utility::addeventplaybcs("stealth", "announce5", "coverblown", delaytime, event);
      println("<dev string:xd5>" + self getentitynumber() + "<dev string:x14f>" + event.typeorig + "<dev string:x124>");

      scripts\stealth\debug::function_ec780a18fdfb4982(self, "<dev string:x183>");

      return true;
    case #"hash_9e02cd4a0f3ca981":
      thread scripts\stealth\utility::addeventplaybcs("stealth", "announce2", "combat", 1, event);
      println("<dev string:xd5>" + self getentitynumber() + "<dev string:x194>" + event.typeorig + "<dev string:x124>");

      scripts\stealth\debug::function_ec780a18fdfb4982(self, "<dev string:x1c3>");

      return true;
  }

  return false;
}

function react_announce_specific(event) {
  self endon("death");

  if(isDefined(event.typeorig)) {
    delaytime = randomfloatrange(0.5, 1);
    thread scripts\stealth\utility::addeventplaybcs("stealth", "announce4", event.typeorig, delaytime, event);
    return true;
  }

  return false;
}

function go_to_node_wait_investigate(goto_func, node, var_5297224e2a5333e6) {
  self endon("death");

  if(!isDefined(var_5297224e2a5333e6)) {
    var_5297224e2a5333e6 = 1;
  }

  alreadysetgoal = !var_5297224e2a5333e6;

  while(!alreadysetgoal) {
    self[[goto_func]](node);
    alreadysetgoal = 1;
    self waittill("goal");
  }
}

function go_to_node_wait(goto_func, node) {
  self endon("death");
  self function_f7cff9f6dafb297();

  if(isDefined(node.script_scenescriptbundle)) {
    function_b6a081f78a507c7a(goto_func, node);
    return;
  }

  self[[goto_func]](node);
  self waittill("goal");
}

function function_b6a081f78a507c7a(goto_func, node) {
  self endon("death");
  self[[goto_func]](node);
  self waittill("goal");

  if(isDefined(node.script_scenescriptbundle)) {
    node scene::play(self, 0);
  }
}

function go_to_node_post_wait(goto_func, node) {
  self endon("death");
  self notify("gotonode_post_wait");

  if(isDefined(self.stealth.idle) && isDefined(node.target)) {}

  id = self function_92435c7a6ae85c3c();

  if(isDefined(id)) {
    self leaveinteraction();
  }

  if(isDefined(node.target)) {
    self function_f7cff9f6dafb297();
  }
}

function go_to_node_arrived(goto_func, node) {
  go_to_node_wait_investigate(goto_func, node, 0);

  if(isDefined(node.script_moveplaybackrate)) {
    self.moveplaybackrate = node.script_moveplaybackrate;
  }

  if((istrue(node.script_delay) || istrue(node.script_delay_min) || istrue(node.script_wait) || isDefined(node.script_idle) || istrue(node.patrol_stop) || !isDefined(node.target)) && isDefined(node.angles)) {
    packagename = undefined;

    if(isDefined(node.script_idle)) {
      packagename = node.script_idle;
    }

    self function_e4b58a023e0da030(node.origin, node.angles, packagename);
    self._blackboard.idlenode = node;

    if(!istrue(node.script_delay) && !istrue(node.script_wait)) {
      waitframe();
    }
  }

  if(isDefined(node.script_animation)) {
    anime = node.script_animation;
    scripts\stealth\utility::animgenericcustomanimmode(self, "gravity", anime);
  } else if(isDefined(node.script_scenescriptbundle)) {
    node scene::play(self, 0);
  } else if(isDefined(node.script_idle)) {
    packagename = undefined;

    if(isDefined(node.script_idle)) {
      packagename = node.script_idle;
    }

    self function_e4b58a023e0da030(node.origin, node.angles, packagename);
    self._blackboard.idlenode = node;
  }

  if(isDefined(node.script_animation_exit)) {
    scripts\stealth\utility::animgenericcustomanimmode(self, "gravity", node.script_animation_exit);
  }
}

function bt_set_stealth_state(statename, event) {
  assert(isDefined(self.fnsetstealthstate));
  self[[self.fnsetstealthstate]](statename, event);
}

function bt_event_handler_severity(event) {
  var_a16e3d3c7cafcd0e = undefined;

  if(isPlayer(event.entity) && event.typeorig == "sight") {
    drone = event.entity scripts\stealth\utility::get_player_drone();

    if(isDefined(drone) && !self cansee(event.entity)) {
      var_a16e3d3c7cafcd0e = drone;
    }
  }

  event.investigate_pos = event.origin;

  if(isDefined(self.enemy) && isDefined(event.entity) && event.entity == self.enemy) {
    event.investigate_pos = self lastknownpos(self.enemy);
  } else if(isDefined(event.entity) && (event.typeorig == "bulletwhizby" || event.typeorig == "throwingknife_whizby")) {
    event.investigate_pos = event.entity.origin;
  } else if(isDefined(event.entity) && issentient(event.entity) && self function_97bb81acbb14c09c(event.entity) && self cansee(event.entity)) {
    event.investigate_pos = event.entity.origin;
  } else if(isDefined(var_a16e3d3c7cafcd0e)) {
    event.investigate_pos = var_a16e3d3c7cafcd0e.origin;
  }

  event_handler_translate_severity(event);

  if(event_handler_should_ignore(event)) {
    return false;
  }

  if(isDefined(var_a16e3d3c7cafcd0e)) {
    event.entity = var_a16e3d3c7cafcd0e;
  }

  self.last_severity_time = gettime();
  function_dfdec2ff9ba6b863(event);
  return true;
}

function function_dfdec2ff9ba6b863(event) {
  if(!scripts\stealth\utility::bcisincombat()) {
    if(!react_announce_specific(event)) {
      react_announce(event);
    }
  }

  switch (event.type) {
    case #"hash_e21b072df2b47f94":
      thread bt_event_investigate(event);
      break;
    case #"hash_f796130a9b9cec5":
      thread bt_event_cover_blown(event);
      break;
    case #"hash_9e02cd4a0f3ca981":
      thread bt_event_combat(event);
      break;
  }

  level notify("stealth_event", event, self);
  func = stealth_get_func(event.typeorig);

  if(isDefined(func) && func != &bt_event_handler_severity) {
    self thread[[func]](event);
  }

  return true;
}

function bt_event_investigate(event) {
  if(self[[self.fnisinstealthcombat]]()) {
    return;
  }

  self function_1aff80c5fc5a3eea("alert");
  bt_set_stealth_state("investigate", event);
}

function bt_event_cover_blown(event) {
  if(!isDefined(self.fnisinstealthcombat) || self[[self.fnisinstealthcombat]]()) {
    return;
  }

  if(isDefined(event.entity) && isDefined(event.entity.classname) && event.entity.classname == "script_vehicle_blackhornet") {
    return;
  }

  if(event.typeorig == "light_killed") {
    event.look_pos = event.investigate_pos;
    event.investigate_pos = drop_to_ground(event.investigate_pos, 24, -256);
  }

  if(event.typeorig == "grenade danger") {
    self.grenadeawareness = 1;
    self.grenadereturnthrowchance = 0;

    if(self.var_fe5ebefa740c7106 == 2) {
      return;
    }
  }

  self function_1aff80c5fc5a3eea("alert");

  if(self[[self.fnisinstealthhunt]]()) {
    if(function_cb5dc7bd04b05b04(event, self)) {
      return;
    }

    return;
  }

  bt_set_stealth_state("investigate", event);
}

function bt_event_combat(event) {
  self notify("stop_going_to_node");
  bt_set_stealth_state("combat", event);

  if(isDefined(event) && issentient(event.entity)) {
    if(!isDefined(self.enemy)) {
      self resetthreatupdate();
    }
  }
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

function onstatechange(fromstate, tostate, var_d24e406e7deefabc) {
  switch (tostate) {
    case 0:
      thread scripts\stealth\utility::addeventplaybcs("stealth", "state_change", "idle", undefined, undefined);
      break;
    case 1:
      if(fromstate == 1) {
        thread scripts\stealth\utility::addeventplaybcs("stealth", "state_change", "update_investigate", undefined, undefined);
      } else {
        self.script_forcegoal = 0;
        level thread scripts\stealth\group::function_92f7df07df367143(self);

        if(var_d24e406e7deefabc) {}
      }

      break;
    case 2:
      self.last_set_goalnode = undefined;
      self.last_set_goalent = undefined;
      level thread scripts\stealth\group::pod_hunt_vo();

      if(var_d24e406e7deefabc) {
        squadid = function_8d0e1f40856173f4(self);
        thread scripts\stealth\group::pod_hunt_update(squadid);
      }

      if(isDefined(self.script_stealth_region_group)) {
        self function_9e200fd4120297e8(self.script_stealth_region_group);
      }

      thread scripts\stealth\utility::addeventplaybcs("stealth", "state_change", "hunt", undefined, undefined);
      break;
    case 3:
      scripts\stealth\event::event_escalation_clear();

      if(isDefined(self.script_stealthgroup)) {
        goalvolume = level.stealth.combat_volumes[self.script_stealthgroup];

        if(isDefined(goalvolume)) {
          self setgoalvolumeauto(goalvolume);
          self forceupdategoalpos();
        } else if(isDefined(level.stealth.combat_goalradius) && isDefined(level.stealth.combat_goalradius[self.script_stealthgroup])) {
          self setgoalpos(self.scriptgoalpos, level.stealth.combat_goalradius[self.script_stealthgroup]);
          self forceupdategoalpos();
        }
      }

      scripts\common\gameskill::grenadeawareness();

      if(var_d24e406e7deefabc) {
        pod = function_bc5df124338cefea(self);

        if(isDefined(pod)) {
          pod thread scripts\stealth\group::pod_combat_update_checklosttarget();
        }

        combattype = ter_op(fromstate < 2, "first_combat", "combat");
      } else {
        combattype = "join_combat";
      }

      if(combattype == "first_combat") {
        function_216c67ab6749137a(self, undefined, "initial_combat", undefined, 2);
      }

      if(combattype == "first_combat" && getdvarint(@ "hash_df03d7ac5b31599") == 1) {
        return;
      } else {
        function_216c67ab6749137a(self, undefined, combattype, undefined, 2);
      }

      break;
    default:
      assertmsg("<dev string:x1cf>" + tostate);
      break;
  }
}