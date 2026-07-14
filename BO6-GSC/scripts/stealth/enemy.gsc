/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\stealth\enemy.gsc
**************************************/

#using scripts\common\callbacks;
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
  group::addtogroup(self.script_stealthgroup, self);

  if(!istrue(self.var_5f61e2875358bab6)) {
    self setpatrolstylebase();
  }

  event::event_init_entity();
  thread monitor_damage_thread();
  self function_a207af2267b47c4b("\xbd\xc3\x19\x1f\x83^\xa0\xba\x18");
  bt_set_stealth_state("\x91\x88\xc2*");
  stealth_init_goal_radius();

  thread debug::debug_enemy();

  if(isDefined(self.fnstealthflashlighton)) {
    self.stealth.funcs["A\xf6\xaf\x87\x04\xfa\xd35\x0f\xf3\xbcC\xae"] = self.fnstealthflashlighton;
  }

  if(isDefined(self.fnstealthflashlightoff)) {
    self.stealth.funcs[">\x10\xc3\xcb\x92\xc0\xe4\x9f8s\xf3(\xbb;"] = self.fnstealthflashlightoff;
  }

  if(isDefined(self.var_9cdb21fc98e9c4f2)) {
    self.stealth.funcs["\xe8\x1e\xc3\xc0\xb0!\x02\xc7\f\x83\x9f\xccu\x97&\xf4\x98"] = self.var_9cdb21fc98e9c4f2;
  }

  if(isDefined(self.fnstealthflashlightdetach)) {
    self.stealth.funcs["\xed\x81]n/\xd7\x84\xfeu\x8e\xe0\x1f\xd8(g=0"] = self.fnstealthflashlightdetach;
  }

  self.stealth.funcs["\xfb\x82<$\x9d\xab\xb5\xe1\xf4\f<3\xd9\xf5\xfd"] = &onstatechange;

  if(getdvarint(@ "ai_disablestealthgroups", 0) == 0) {
    self.stealth_groupname = self.script_stealthgroup;
  }

  if(isDefined(level.interactive_doors) && istrue(level.interactive_doors.var_1c2fb6a9190a2421)) {
    thread door::suspicious_door_thread();
  }

  if(isDefined(level.stealth) && isDefined(level.stealth.sightconfigtemplate) && !(isDefined(self.aisettings) && isDefined(self.aisettings.var_be59d324e19c4aef))) {
    self function_e15f282e60ad1131(level.stealth.sightconfigtemplate);
  }

  if(isDefined(level.var_fa2893e96de08985)) {
    self[[level.var_fa2893e96de08985]]();
  }

  if(isDefined(level.stealth.fninitenemygame)) {
    self thread[[level.stealth.fninitenemygame]]();
  }
}

function init_flags() {
  utility::ent_flag_init("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
  utility::ent_flag_set("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
  utility::group_flag_init("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");
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
  self.stealth_bsmstate = 4;
  self.stealth.funcs = [];
  self.stealth.max_warnings = 2;

  self.stealth.ai_event = "<dev string:x24>";
  self.stealth.var_a2c560078d1a8025 = "<dev string:x24>";

  self.newenemyreactiondistsq = squared(geteventdefaultdistance("\x82\xe4/D\x10Z\x7f\x11\x031\x94:\xddY>")) ?? 640;
  corpse::corpse_init_entity();
  self.event_escalation_scalar = 0;
  self.disablegrenaderesponse = 1;
  self.canacquirenearbytacvisenemies = 0;
}

function death_cleanup() {
  if(isDefined(self)) {
    self setthreatsightstate("\x1e\xfd\xd1\xa2\a");
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
  assert(isDefined(self.stealth), "<dev string:x28>" + self getentitynumber() + "<dev string:x4b>" + self.origin);

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

  var_b3adaeb6a1d5f42d = isDefined(self.fnisinstealthcombat) && self[[self.fnisinstealthcombat]]();
  var_456db267608c3184 = isDefined(self.fnisinstealthhunt) && self[[self.fnisinstealthhunt]]();
  iscombat = var_b3adaeb6a1d5f42d || var_456db267608c3184;

  if(blind && (!iscombat || istrue(force))) {
    self.stealthblind = 1;
    self setsightstate("\xe0V\x90\xef~");
    return;
  }

  self.stealthblind = 0;

  if(iscombat) {
    self setsightstate("\x1f\x93?pK+\x9c");
    return;
  }

  self setsightstate("\xf8VZW\xd3\xad");
}

function alertlevel_normal(param) {
  thread utility::addeventplaybcs("\x12\xc2\xc8\x9d-\x1d\x9b", "\xf5\xad\x03\x84(\xdd\xde\b\x9a", "\xbd\xeeXky\xcd\xcd\tG\xc3");
  self function_a207af2267b47c4b("\xbd\xc3\x19\x1f\x83^\xa0\xba\x18");
  bt_set_stealth_state("\x91\x88\xc2*");
  utility::function_21a129be478aa01();
}

function set_default_stealth_funcs() {
  level utility::set_stealth_func("\x90O\x19\xb7+D\x98\nk\x9d\xc6\x0f\x9c\xb8\xc0", &go_to_node_wait);
  level utility::set_stealth_func("\x03\xbe\xf5\xb6\x1b\xb2\x8f\xce\x18\xb13\t\xf0Zac\x12", &go_to_node_arrived);
  level utility::set_stealth_func("Yz\xd7\xea\xbf?-\x10\x06\x86\x03\xc0\x04\xbd\xf3\xc1\x83;\xbd5", &go_to_node_post_wait);
  level utility::set_stealth_func("\x8fHC\xa9\xed", &alertlevel_normal);
  level utility::set_stealth_func("D\x8aXz\xcf\xd7\b\xac\x9d$4\xb8\x89\xa1`\xfe", &utility::set_patrol_style);
  level utility::set_stealth_func("}\x1c\xad\x15j\xd7\xd1\xf4\xf7B\x96\xc2V\xb8&\xab\x94\xe3M", &trigger_cover_blown);
  level utility::set_stealth_func("\xc2\x99.K\xdd\x9fBw>]\x8e", &bt_event_handler_severity);
  level utility::set_stealth_func("\x8e\x86U\b\xe9s\xa7\xb1\x87\x99\xb9", &bt_event_handler_severity);
  level utility::set_stealth_func("\xe3\xd0\xc3e\x85h", &bt_event_handler_severity);
  level utility::set_stealth_func("\xd7\xca\xae\xca\xff\xdb", &function_8f130a41bfedd2ca);
  level utility::set_stealth_func(";\x80\xd9$\x14[\xc3*\x8e\xaf\xac\xb2v1\x99Z\x9dJ\x9c\xc5wy", &function_3a3141c96bcce349);
}

function monitor_damage_thread() {
  team = self.team;

  while(isalive(self)) {
    other = undefined;

    while(true) {
      if(!isalive(self)) {
        return;
      }

      self waittill("\fU`\xc0y\x95", dmg, attacker, null, point, type);
      check_kill_damage(dmg, attacker, point);
      event_spot = self.origin;

      if(isalive(self) && !utility::ent_flag("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3")) {
        continue;
      }

      if(isalive(attacker)) {
        other = attacker;
      }

      if(!isDefined(other)) {
        continue;
      }

      if(istrue(callbacks::stealth_call("\fU`\xc0y\x95", dmg, attacker, type))) {
        continue;
      }

      self aieventlistenerevent("\fU`\xc0y\x95", other, other.origin);

      if(isPlayer(other) || isDefined(other.team) && other.team != team) {
        break;
      }

      if(isDefined(other.classname) && other.classname == "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6") {
        if(istrue(other.isbarrel)) {
          break;
        }
      }
    }

    if(isalive(self)) {
      utility::function_dad7b074713963f6("5\xba\x8fe\xc3ze\xabn\xaf\xf6\\", other, type);
      utility::function_dad7b074713963f6("\x02\xae\xd8\xda\xd1A\x1ame\x9dC\x92\xbf\x80l\x11\n(\xb0\x1a\xb3QC", other, type, 1);
      continue;
    }

    utility::function_dad7b074713963f6("Y5\x90\xb5\xa1\xb3\x91\xa0\x8c'\\", other, type);
    utility::function_dad7b074713963f6("\x02\xae\xd8\xda\xd1A\x1ame\x9dC\x92\xbf\x80l\x11\n(\xb0\x1a\xb3QC", other, type, 1);
  }
}

function check_kill_damage(damage, attacker, origin) {
  if(isDefined(self.disableeasystealthheadshot) || !istrue(level.gamemodebundle.var_9984cb5f609d9689)) {
    return;
  }

  if(isalive(self) && damage > 0 && self.damagemod != "\x13\x1e\xe31{\xb4\xf1\x85\x18" && self.damagemod != "M\x81\xaf\xee\xc9\xcfD\xef\x91J" && self.alertlevel != "\xe3\xd0\xc3e\x85h") {
    eyepos = self getEye();

    if(distancesquared(origin, eyepos) < squared(level.stealth.head_shot_dist)) {
      self dodamage(self.health, origin, attacker, attacker, "\xc3z\x8ap\xf0\x04C\x0f\xc1g\x14\xdb5");

      if(isDefined(self.stealth)) {
        self.stealth.override_damage_auto_range = 128;
      }
    }
  }
}

function shotisreasonablysafe(target) {
  guys = getaiunittypearray("\x9a\x1f\x83\x1bs=\x13\xf8", "\xc0\xc6J");
  potentialguys = [];
  autorangesq = squared(level.stealth.damage_auto_range);
  sightrangesq = squared(level.stealth.damage_sight_range);

  foreach(guy in guys) {
    if(guy == target) {
      continue;
    }

    var_c32ae4c3e16c92b1 = distancesquared(target.origin, guy.origin);

    if(var_c32ae4c3e16c92b1 < autorangesq) {
      return false;
    }

    if(var_c32ae4c3e16c92b1 < sightrangesq) {
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
  guys = getaiunittypearray("\x9a\x1f\x83\x1bs=\x13\xf8", "\xc0\xc6J");
  potentialguys = [];
  autorangesq = squared(level.stealth.damage_auto_range);
  sightrangesq = squared(level.stealth.damage_sight_range);

  foreach(guy in guys) {
    if(guy == target) {
      continue;
    }

    var_c32ae4c3e16c92b1 = distancesquared(target.origin, guy.origin);

    if(var_c32ae4c3e16c92b1 < autorangesq) {
      return true;
    }

    if(var_c32ae4c3e16c92b1 < sightrangesq) {
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
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\x15\xe0\x10c\xf1\xcb3w{\t\xee\xda\xa3\xe8\x88\r_\x9e\x186Z");
  self endon("\x15\xe0\x10c\xf1\xcb3w{\t\xee\xda\xa3\xe8\x88\r_\x9e\x186Z");
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
    diff = event::event_severity_compare(event_severity_min, event.type);

    if(diff > 0) {
      return 1;
    }
  }

  if(event.typeorig == "+\x1e\x1c\xd8\xbds\xd2{\xb9") {
    if(isDefined(event.entity) && isDefined(event.entity.team) && event.entity.team == self.team) {
      return 1;
    }
  }

  if(event.typeorig == "3\xdb\xb7tn:\x95\xe0" || event.typeorig == "]\xa0\xfb\x14$N\xda\xdb\x06\x0e\x1a\x99\x01") {
    if(function_f8b7903d1d4efbb5(event)) {
      return 1;
    }
  }

  if(event.typeorig == "\x82\xe4/D\x10Z\x7f\x11\x031\x94:\xddY>") {
    if(should_ignore_sprint_footstep(event)) {
      return 1;
    }
  }

  if(event.typeorig == "s\xaef\xed\xd27]\xd1oeV\xe5V") {
    if(isPlayer(event.entity) && distancesquared(event.entity getEye(), event.origin) > 1296) {
      return 1;
    }
  }

  if(event.typeorig == "\xa3^6\xd74#\xbd" || event.typeorig == "k\x83\xdb6\xf8Wz`Q\x95N\x88\x8eu" || event.typeorig == "\x81\x14x1w\x98F\x13\xb6\x15D\xaf\x93\xbbvP" || event.typeorig == "\x9c\xae\x01\x94\xb8\xb5F\xc1\x94\row") {
    if(isagent(event.entity) && event.entity isinscriptedstate()) {
      return 1;
    }
  }

  return function_3a3141c96bcce349(event);
}

function function_3a3141c96bcce349(event) {
  if(istrue(callbacks::stealth_call("\xdf\xb6\x92p\xdaL\xe8\x18\xf8(\"\xd8&\x13\x94\xba\x82&\x96", event))) {
    return 1;
  }

  var_9b9b4e54e9fdf8ae = callbacks::stealth_get_func("\xfd\x1b\xb8\x95\xff\x1b" + event.type);

  if(isDefined(var_9b9b4e54e9fdf8ae)) {
    originaleventtype = event.type;
    originaleventname = event.typeorig;
    bignore = callbacks::stealth_call("\xfd\x1b\xb8\x95\xff\x1b" + event.type, event);

    if(isDefined(event.typeorig)) {
      function_5080b8cdfc48fac8(event.typeorig, event.entity, self, event.type, event.origin, event.investigate_pos);
    } else {
      assertmsg("<dev string:x57>" + originaleventtype + "<dev string:xcc>" + originaleventname);
    }

    return bignore;
  }

  return 0;
}

function function_f8b7903d1d4efbb5(event) {
  if(!isPlayer(event.entity)) {
    return true;
  }

  if(event.entity getstance() != "\x8b\x90\xb5\xc4W") {
    return true;
  }

  return false;
}

function should_ignore_sprint_footstep(event) {
  if(isPlayer(event.entity)) {
    dist_sq = distancesquared(self.origin, event.origin);
    traceoffset = (0, 0, 18);
    ignoreents = utility::array_combine(function_a67d81ca66a25657(), self function_f2638d87185b4fc2());
    var_648b36848f77a078 = self function_51cbca962ab14c44(event.entity, "3\xdb\xb7tn:\x95\xe0");

    if(dist_sq < var_648b36848f77a078 * var_648b36848f77a078) {
      return false;
    } else if(utility::can_trace_to_ai(event.origin + traceoffset, self, ignoreents)) {
      if(isDefined(self.sprintfootstepradius)) {
        sprintfootstepradius = self.sprintfootstepradius;

        if(dist_sq < sprintfootstepradius * sprintfootstepradius) {
          return false;
        }
      }

      playervisible = self cansee(event.entity);

      if(!playervisible && self function_dab47704d29ee6fe(event.entity)) {
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
        thread threat_sight::threat_sight_force_visible(event.entity, 1);
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
        event.type = "\xe3\xd0\xc3e\x85h";
        return false;
    }
  }

  if(event.type != "\xe3\xd0\xc3e\x85h") {
    return true;
  }

  return false;
}

function event_anyone_within_radius(eventorigin, dist) {
  distsq = dist * dist;
  ais = getaiunittypearray("\x9a\x1f\x83\x1bs=\x13\xf8", "\xc0\xc6J");

  foreach(ai in ais) {
    if(distancesquared(eventorigin, ai.origin) <= distsq) {
      return true;
    }
  }

  return false;
}

function event_handler_translate_severity(event) {
  if(!(isDefined(event) && isDefined(event.typeorig))) {
    return;
  }

  if(self[[self.fnisinstealthhunt]]()) {
    if(event.type == "\xc2\x99.K\xdd\x9fBw>]\x8e") {
      event.type = "\x8e\x86U\b\xe9s\xa7\xb1\x87\x99\xb9";
    }
  }

  switch (event.typeorig) {
    case #"hash_641050446d8ad59e":
      if(self.unittype == "\xde\x9d\xa5") {
        event.type = "\xc2\x99.K\xdd\x9fBw>]\x8e";
      } else {
        evententid = undefined;

        if(isDefined(event.entity) && issentient(event.entity)) {
          evententid = event.entity getentitynumber();
        }

        if(isDefined(evententid) && self getthreatsightflag(event.entity, 2)) {
          var_93db7a5044b425c9 = event.entity;

          if(isPlayer(event.entity)) {
            drone = event.entity utility::get_player_drone();

            if(isDefined(drone) && !self cansee(event.entity)) {
              var_93db7a5044b425c9 = drone;
            }
          }

          self getenemyinfo(var_93db7a5044b425c9);
          event.type = "\xe3\xd0\xc3e\x85h";
        }
      }

      break;
    case #"hash_ea10345acf995244":
      if(isDefined(event.entity) && event.entity.model == "\xacT\x1e\xcd\x91`:%\x9cv_s\xbe\xbcr\x8eP).zow{") {
        event.type = "\x8e\x86U\b\xe9s\xa7\xb1\x87\x99\xb9";
      } else if(event_anyone_within_radius(event.origin, 128)) {
        event.type = "\xe3\xd0\xc3e\x85h";
      }

      break;
    case #"hash_1d0022d9b49074c0":
      if(event_anyone_within_radius(event.origin, 192)) {
        event.type = "\xe3\xd0\xc3e\x85h";
      } else if(distancesquared(event.origin, self.origin) <= 1048576) {
        event.type = "\xe3\xd0\xc3e\x85h";
      }

      break;
    case #"hash_412938e72fd9ab35":
      if(distancesquared(event.origin, self.origin) < 640000) {
        event.type = "\xe3\xd0\xc3e\x85h";
      }

      break;
    case #"hash_eaa4394d31c175bf":
      if(self hastacvis(event.origin, 0) && distance2dsquared(event.origin, self.origin) < 36864) {
        event.type = "\xe3\xd0\xc3e\x85h";
      }

      break;
  }
}

function trigger_cover_blown(event) {
  if(!isDefined(self.stealth)) {
    return;
  }

  self.var_1d6eabfad177376d = 1;
}

function react_announce(event) {
  self endon("\x1e\xfd\xd1\xa2\a");
  delaytime = randomfloatrange(0.5, 1.1);

  switch (event.type) {
    case #"hash_e21b072df2b47f94":
      thread utility::addeventplaybcs("\x12\xc2\xc8\x9d-\x1d\x9b", "\xf5\xad\x03\x84(\xdd\xde\b\x9a", "\xc2\x99.K\xdd\x9fBw>]\x8e", delaytime, event);
      println("<dev string:xdd>" + self getentitynumber() + "<dev string:xf8>" + event.typeorig + "<dev string:x12c>");

      debug::function_f8d23469e4a91a5f(self, "<dev string:x14f>");

      return true;
    case #"hash_f796130a9b9cec5":
      thread utility::addeventplaybcs("\x12\xc2\xc8\x9d-\x1d\x9b", "\xf5\xad\x03\x84(\xdd\xde\b\x9a", "\"\aw\x88AV\x02jr:", delaytime, event);
      println("<dev string:xdd>" + self getentitynumber() + "<dev string:x157>" + event.typeorig + "<dev string:x12c>");

      debug::function_f8d23469e4a91a5f(self, "<dev string:x18b>");

      return true;
    case #"hash_9e02cd4a0f3ca981":
      thread utility::addeventplaybcs("\x12\xc2\xc8\x9d-\x1d\x9b", "\x10X\xdb\xc01\xad\xfb\xe1o", "\xe3\xd0\xc3e\x85h", 1, event);
      println("<dev string:xdd>" + self getentitynumber() + "<dev string:x19c>" + event.typeorig + "<dev string:x12c>");

      debug::function_f8d23469e4a91a5f(self, "<dev string:x1cb>");

      return true;
  }

  return false;
}

function react_announce_specific(event) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(event.typeorig)) {
    delaytime = randomfloatrange(0.5, 1);
    thread utility::addeventplaybcs("\x12\xc2\xc8\x9d-\x1d\x9b", "b\xf4\xe5Q\xde*\x90\x1e\xec", event.typeorig, delaytime, event);
    return true;
  }

  return false;
}

function go_to_node_wait_investigate(goto_func, node, var_69d15c663644e0f) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(var_69d15c663644e0f)) {
    var_69d15c663644e0f = 1;
  }

  alreadysetgoal = !var_69d15c663644e0f;

  while(!alreadysetgoal) {
    self[[goto_func]](node);
    alreadysetgoal = 1;
    self waittill("\x83\xd6\xaf\x11");
  }
}

function go_to_node_wait(goto_func, node) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self function_bd5db781a7b801b2();

  if(isDefined(node.script_scenescriptbundle)) {
    function_87fb21ad65ed3e0f(goto_func, node);
    return;
  }

  self[[goto_func]](node);
  self waittill("\x83\xd6\xaf\x11");
}

function function_87fb21ad65ed3e0f(goto_func, node) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self[[goto_func]](node);
  self waittill("\x83\xd6\xaf\x11");

  if(isDefined(node.script_scenescriptbundle)) {
    node scene::play(self, 0);
  }
}

function go_to_node_post_wait(goto_func, node) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("{\xa5\x01xCnW\xd7\x16\x12\xff'\xfb\xda\x14\n\xe2u");

  if(isDefined(self.stealth.idle) && isDefined(node.target)) {}

  id = self getinteractionid();

  if(isDefined(id)) {
    self leaveinteraction();
  }

  if(isDefined(node.target)) {
    self function_bd5db781a7b801b2();
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

    self function_fb658b82df84e811(node.origin, node.angles, packagename);
    self._blackboard.idlenode = node;

    if(!istrue(node.script_delay) && !istrue(node.script_wait)) {
      waitframe();
    }
  }

  if(isDefined(node.script_animation)) {
    anime = node.script_animation;
    utility::animgenericcustomanimmode(self, "\x1b\x9e\x86\xecr\x97\xa2", anime);
  } else if(isDefined(node.script_scenescriptbundle)) {
    node scene::play(self, 0);
  } else if(isDefined(node.script_idle)) {
    packagename = undefined;

    if(isDefined(node.script_idle)) {
      packagename = node.script_idle;
    }

    self function_fb658b82df84e811(node.origin, node.angles, packagename);
    self._blackboard.idlenode = node;
  }

  if(isDefined(node.script_animation_exit)) {
    utility::animgenericcustomanimmode(self, "\x1b\x9e\x86\xecr\x97\xa2", node.script_animation_exit);
  }
}

function bt_set_stealth_state(statename, event) {
  assert(isDefined(self.fnsetstealthstate));
  self[[self.fnsetstealthstate]](statename, event);
}

function bt_event_handler_severity(event) {
  eventtargetoverride = undefined;

  if(isPlayer(event.entity) && event.typeorig == "\xc7@\xe1xS") {
    drone = event.entity utility::get_player_drone();

    if(isDefined(drone) && !self cansee(event.entity)) {
      eventtargetoverride = drone;
    }
  }

  event.investigate_pos = event.origin;

  if(isDefined(self.enemy) && isDefined(event.entity) && event.entity == self.enemy) {
    event.investigate_pos = self lastknownpos(self.enemy);
  } else if(isDefined(event.entity) && (event.typeorig == "\x9c\xae\x01\x94\xb8\xb5F\xc1\x94\row" || event.typeorig == "\x14\xba\xdeS\x05\xc8,\x01\xf9m\xcd?\x92x~2(&\xa6\x10")) {
    event.investigate_pos = event.entity.origin;
  } else if(isDefined(event.entity) && issentient(event.entity) && self function_e2b0c45f2ad4d89(event.entity) && self cansee(event.entity)) {
    event.investigate_pos = event.entity.origin;
  } else if(isDefined(eventtargetoverride)) {
    event.investigate_pos = eventtargetoverride.origin;
  }

  event_handler_translate_severity(event);

  if(event_handler_should_ignore(event)) {
    return false;
  }

  if(isDefined(eventtargetoverride)) {
    event.entity = eventtargetoverride;
  }

  self.last_severity_time = gettime();
  function_8f130a41bfedd2ca(event);
  return true;
}

function function_8f130a41bfedd2ca(event) {
  if(!utility::bcisincombat()) {
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

  level notify("\xdc\xe8+,\x8d\xa3\x1a_\xb2\xece\xdc:", event, self);
  func = callbacks::stealth_get_func(event.typeorig);

  if(isDefined(func) && func != &bt_event_handler_severity) {
    self thread[[func]](event);
  }

  return true;
}

function bt_event_investigate(event) {
  if(self[[self.fnisinstealthcombat]]()) {
    return;
  }

  self function_a207af2267b47c4b("\\*\xe3\xec\x10");
  bt_set_stealth_state("\xc2\x99.K\xdd\x9fBw>]\x8e", event);
}

function bt_event_cover_blown(event) {
  if(!isDefined(self.fnisinstealthcombat) || self[[self.fnisinstealthcombat]]()) {
    return;
  }

  if(isDefined(event.entity) && isDefined(event.entity.classname) && event.entity.classname == "\xd6\xbc\x99\vL\xcd?\xc1]-\xfe\xf6\xad\xe5\xaf\xc8k\xd8\xec\x0f3\b\\\bjL") {
    return;
  }

  if(event.typeorig == "\xdd\x10\xe9y\xc0\x91\xf7\x92\xba\xd7\xc6\x80") {
    event.look_pos = event.investigate_pos;
    event.investigate_pos = utility::drop_to_ground(event.investigate_pos, 24, -256);
  }

  if(event.typeorig == "[\x97mzNX\xa8 q(\xd4\xcf\xb9\x88") {
    self.grenadeawareness = 1;
    self.grenadereturnthrowchance = 0;

    if(self.stealth_bsmstate == 2) {
      return;
    }
  }

  self function_a207af2267b47c4b("\\*\xe3\xec\x10");

  if(self[[self.fnisinstealthhunt]]()) {
    if(function_776a0bae362079f1(event, self)) {
      return;
    }

    return;
  }

  bt_set_stealth_state("\xc2\x99.K\xdd\x9fBw>]\x8e", event);
}

function bt_event_combat(event) {
  self notify("\x83\xcb\xd4\xd6XoZ\xca)\xadaz\x95\x9e\xcf\xa6\xe2\xf1");
  bt_set_stealth_state("\xe3\xd0\xc3e\x85h", event);

  if(isDefined(event) && issentient(event.entity)) {
    if(!isDefined(self.enemy)) {
      self resetthreatupdate();
    }
  }
}

function set_provide_cover_fire() {
  self.providecoveringfire = 1;
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x16\x1c\x87\xe3\xdf\x8f`\xc9\x1fL=\xfa\xb7d\xe3\r.\x8c\xa7");
  self endon("\xb6\x15\xa8U\xb5\xfd\a<\\b\xec\xd9");
  self endon("'\x1c\x9b\x90\x9b|\x9f\xec\xe6\xdf\xbc\x89\x80 ");
  wait 5;
  self.providecoveringfire = 0;
}

function onstatechange(fromstate, tostate, bnewpod) {
  self notify("\x935Z\xacd\xdb\x12\x90\xa1\x0f\x82\xf7\xcb\xba\xc1AZb\xf7\xb4", tostate, fromstate);
  callback::callback(#"hash_10831fc4ff641282", {
    #fromstate: fromstate, #tostate: tostate
  });

  switch (tostate) {
    case 0:
      thread utility::addeventplaybcs("\x12\xc2\xc8\x9d-\x1d\x9b", "\xe4\xdcJq)\x99\xc9\x04\xa6\xd5\x1bi", "\x91\x88\xc2*", undefined, undefined);
      break;
    case 1:
      if(fromstate == 1) {
        thread utility::addeventplaybcs("\x12\xc2\xc8\x9d-\x1d\x9b", "\xe4\xdcJq)\x99\xc9\x04\xa6\xd5\x1bi", "\xff+8\x8b\xff\x060\xf8\xdbY\x06\xf2\x81?\x95q\xd3\x85", undefined, undefined);
      } else {
        self.script_forcegoal = 0;

        if(bnewpod) {}
      }

      break;
    case 2:
      self.last_set_goalnode = undefined;
      self.last_set_goalent = undefined;
      level thread group::pod_hunt_vo();

      if(bnewpod) {
        squadid = function_f3be97d1f4c0bbd9(self);
        thread group::pod_hunt_update(squadid);
      }

      thread utility::addeventplaybcs("\x12\xc2\xc8\x9d-\x1d\x9b", "\xe4\xdcJq)\x99\xc9\x04\xa6\xd5\x1bi", "\x11t\x12\x1a", undefined, undefined);
      break;
    case 3:
      event::event_escalation_clear();

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

      self.disablegrenaderesponse = 0;

      if(bnewpod) {
        combattype = fromstate < 2 ? "N93y\x94Cd\xed\xefiM\xd5" : "\xe3\xd0\xc3e\x85h";
      } else {
        combattype = "\xc3[g\xc9X\x8e\xf8\xd9\x9dy\x1f";
      }

      if(isDefined(level.battlechatter) && combattype == "N93y\x94Cd\xed\xefiM\xd5") {
        function_99e8e66d1969d7cb(self, undefined, "\x84\xefS\xff\x1ar7\x96\xd4F\xf2\xa2\xcf\x89", undefined, 2);
      }

      if(combattype == "N93y\x94Cd\xed\xefiM\xd5" && getdvarint(@ "ai_shoulddohesherecallout") == 1) {
        return;
      } else if(isDefined(level.battlechatter)) {
        function_99e8e66d1969d7cb(self, undefined, combattype, undefined, 2);
      }

      break;
    default:
      assertmsg("<dev string:x1d7>" + tostate);
      break;
  }
}

function private function_b127cae4ae2daa88() {
  assert(isDefined(level));
  var_3f6028300a0f986b = 1;
}