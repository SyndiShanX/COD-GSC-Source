/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_movable_cover.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

init() {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  movable_cover_precache();
  waitframe();
  covers = getEntArray("movable_cover", "targetname");
  cover_proxy = getstructarray("movable_cover", "targetname");
  foreach(proxy in cover_proxy) {
    if(isDefined(proxy.target)) {
      cover = GetEnt(proxy.target, "targetname");
      if(isDefined(cover)) {
        covers[covers.size] = cover;
      }
    }
  }
  array_thread(covers, ::movable_cover_init);
}

movable_cover_precache() {
  level.movable_cover_use_icons = [];
  level.movable_cover_use_icons["dumpster"] = "hud_icon_push";

  level.movable_cover_move_sounds = [];
  level.movable_cover_move_sounds["dumpster"]["start"] = "mp_dumpster_start";
  level.movable_cover_move_sounds["dumpster"]["move"] = "mp_dumpster_mvmt_loop";
  level.movable_cover_move_sounds["dumpster"]["stop"] = "mp_dumpster_end";

  level.movable_cover_move_anim = [];
  level.movable_cover_move_anim["dumpster"] = [];
  level.movable_cover_move_anim["dumpster"]["move"] = "mp_lonestar_dumpster_jitter";
  level.movable_cover_move_anim["dumpster"]["idle"] = "mp_lonestar_dumpster_jitter_idle";

  level.movable_cover_default_parameters = [];
  level.movable_cover_default_parameters["dumpster"] = "goal_radius=1;max_speed=80;accel_time=.8;decel_time=.8;stances=crouch,stand";

  foreach(move_anim_type in level.movable_cover_move_anim) {
    foreach(move_anim in move_anim_type) {
      PrecacheMpAnim(move_anim);
    }
  }
}

movable_cover_init() {
  self.moving = false;
  self.stay = false;
  self.updatePaths = self.spawnflags & 1;

  self.movable_type = "default";
  if(isDefined(self.script_noteworthy))
    self.movable_type = self.script_noteworthy;

  self movable_cover_parse_parameters();

  end_points = [];

  links = self get_links();
  foreach(link in links) {
    point = getstruct(link, "script_linkname");
    if(isDefined(point) && isDefined(point.script_label)) {
      point.auto = isDefined(point.script_parameters) && point.script_parameters == "auto";
      point.stay = isDefined(point.script_parameters) && point.script_parameters == "stay";
      end_points[point.script_label] = point;
    }
  }

  targets = [];
  if(isDefined(self.target)) {
    structs = GetStructArray(self.target, "targetname");
    ents = getEntArray(self.target, "targetname");
    targets = array_combine(structs, ents);
  }

  link_to_ent = self;
  link_to_tag = undefined;
  if(isDefined(level.movable_cover_move_anim[self.movable_type])) {
    self.animate_ent = spawn("script_model", self.origin);
    self.animate_ent setModel("generic_prop_raven");
    self.animate_ent.angles = self.angles;
    self.animate_ent linkTo(self);
    link_to_ent = self.animate_ent;
    link_to_tag = "j_prop_1";
  }

  self.linked_ents = [];
  foreach(target in targets) {
    if(!isDefined(target.script_noteworthy)) {
      continue;
    }
    switch (target.script_noteworthy) {
      case "move_trigger":
        if(!isDefined(target.script_label) || !isDefined(end_points[target.script_label]))
          continue;
        target EnableLinkTo();
        target LinkTo(self);
        self thread movable_cover_trigger(target, end_points[target.script_label]);
        self thread movable_cover_update_use_icon(target, end_points[target.script_label]);
        break;
      case "link":
        self.linked_ents[self.linked_ents.size] = target;
        break;
      case "angels":
        if(isDefined(target.angles) && isDefined(self.animate_ent))
          self.animate_ent.angles = target.angles;
        break;
      case "mantlebrush":
        self.linked_ents[self.linked_ents.size] = target;

        break;
      default:
        break;
    }
  }

  foreach(ent in self.linked_ents) {
    if(isDefined(link_to_tag)) {
      ent LinkTo(link_to_ent, link_to_tag);
    } else {
      ent LinkTo(link_to_ent);
    }
  }

  all_nodes = self getLinknameNodes();
  self.traverse_nodes = [];
  foreach(node in all_nodes) {
    if(!isDefined(node.type)) {
      continue;
    }
    node.node_type = node.script_noteworthy;
    if(!isDefined(node.node_type))
      node.node_type = "closest";

    node_type_valid = false;
    switch (node.node_type) {
      case "closest":
        node_type_valid = true;
        break;
      case "radius":
      case "radius3d":
      case "radius2d":
        if(isDefined(node.target)) {
          target = getstruct(node.target, "targetname");
          if(isDefined(target) && isDefined(target.radius)) {
            node.test_origin = target.origin;
            node.test_radius = target.radius;
            node_type_valid = true;
          }
        }
        break;
      default:
        node_type_valid = false;
        break;
    }

    if(!node_type_valid) {
      continue;
    }
    if(node.type == "Begin" || node.type == "End") {
      if(node.type == "Begin") {
        node.connected_nodes = GetNodeArray(node.target, "targetname");
      } else {
        node.connected_nodes = GetNodeArray(node.targetname, "target");
      }

      foreach(connected_node in node.connected_nodes) {
        DisconnectNodePair(node, connected_node);
      }

      self.traverse_nodes[self.traverse_nodes.size] = node;
    }
  }
  self movable_cover_connect_traversals();
}

movable_cover_set_user(user, trigger) {
  if(!isDefined(self.user) && isDefined(user))
    self notify("new_user");
  else if(isDefined(self.user) && isDefined(user) && self.user != user)
    self notify("new_user");
  else if(isDefined(self.user) && !isDefined(user))
    self notify("clear_user");

  self.user = user;
  self.user_trigger = trigger;
}

movable_cover_update_use_icon(trigger, move_to) {
  if(!isDefined(level.movable_cover_use_icons[self.movable_type])) {
    return;
  }
  while(!isDefined(level.players)) {
    waitframe();
    continue;
  }

  show_dist = 100;
  show_dist_sqr = show_dist * show_dist;

  ent_num = trigger GetEntityNumber();
  trigger_name = "trigger_" + ent_num;
  while(1) {
    foreach(player in level.players) {
      if(!isDefined(player.movable_cover_huds))
        player.movable_cover_huds = [];

      dist_sqr = DistanceSquared(player.origin + (0, 0, 30), trigger.origin);
      if(dist_sqr <= show_dist_sqr && !self movable_cover_at_goal(move_to.origin)) {
        if(!isDefined(player.movable_cover_huds[trigger_name])) {
          player.movable_cover_huds[trigger_name] = movable_cover_use_icon(player, trigger);
          player.movable_cover_huds[trigger_name].alpha = 0;
        }

        player.movable_cover_huds[trigger_name] notify("stop_fade");
        player.movable_cover_huds[trigger_name] thread movable_cover_fade_in_use_icon();
      } else {
        if(isDefined(player.movable_cover_huds[trigger_name])) {
          player.movable_cover_huds[trigger_name] thread movable_cover_fade_out_use_icon();
        }
      }
    }
    wait .05;
  }
}

movable_cover_fade_in_use_icon() {
  self endon("death");

  if(self.alpha == 1) {
    return;
  }
  self FadeOverTime(.5);
  self.alpha = 1;
}

movable_cover_fade_out_use_icon() {
  self endon("death");
  self endon("stop_fade");

  if(self.alpha == 0) {
    return;
  }
  time = .5;
  self FadeOverTime(time);
  self.alpha = 0;
  wait time;

  self Destroy();
}

movable_cover_use_icon(player, ent) {
  icon = player createIcon(level.movable_cover_use_icons[self.movable_type], 16, 16);
  icon setWayPoint(true, false);
  icon SetTargetEnt(ent);
  icon.fading = false;
  return icon;
}

movable_cover_parse_parameters() {
  self.goal_radius = 1;
  self.max_speed = 50;
  self.accel_time = 1;
  self.decel_time = 1;
  self.requires_push = 1;
  self.start_delay = .2;
  self.stances = ["stand", "crouch"];

  if(!isDefined(self.script_parameters))
    self.script_parameters = "";

  default_parameters = level.movable_cover_default_parameters[self.movable_type];
  if(isDefined(default_parameters))
    self.script_parameters = default_parameters + self.script_parameters;

  params = StrTok(self.script_parameters, ";");
  foreach(param in params) {
    toks = strtok(param, "=");
    if(toks.size != 2) {
      continue;
    }
    switch (toks[0]) {
      case "goal_radius":
        self.goal_radius = float(toks[1]);
        self.goal_radius = max(1, self.goal_radius);
        break;
      case "max_speed":
        self.max_speed = float(toks[1]);
        break;
      case "accel_time":
        self.accel_time = float(toks[1]);
        break;
      case "decel_time":
        self.decel_time = float(toks[1]);
        self.decel_time = max(0.05, self.decel_time);
        break;
      case "stances":
        self.stances = StrTok(toks[1], ",");
        break;
      case "requires_push":
        self.requires_push = int(toks[1]);
        break;
      case "start_delay":
        self.start_delay = float(toks[1]);
        break;
      default:
        break;
    }
  }
}

movable_cover_trigger(trigger, move_to) {
  auto = move_to.auto;
  stay = move_to.stay;
  while(1) {
    player = undefined;
    if(auto && !self.stay) {
      waitframe();
      if(isDefined(self.user) && self.user_trigger != trigger)
        continue;
    } else {
      self movable_cover_set_user(undefined, undefined);
      while(1) {
        trigger waittill("trigger", player);
        if(isPlayer(player)) {
          break;
        }
      }
      self movable_cover_set_user(player, trigger);
    }

    if(self movable_cover_at_goal(move_to.origin)) {
      continue;
    }
    move_dir = VectorNormalize(move_to.origin - self.origin);
    if(!auto && !self movable_cover_move_delay(self.start_delay, player, trigger, move_dir)) {
      continue;
    }
    dist = Distance(self.origin, move_to.origin);
    time = dist / self.max_speed;

    if(auto && self.stay && !isDefined(self.user)) {
      continue;
    }
    if(self.moving) {
      continue;
    }
    if(self.updatePaths)
      self ConnectPaths();
    self movable_cover_disconnect_traversals();
    self.moving = true;
    self.stay = false;

    self notify("move_start");

    start_time = GetTime();
    accel_time = min(time, self.accel_time);
    if(auto)
      accel_time = time;

    start_sound = movable_cover_get_sound("start");
    if(isDefined(start_sound))
      self playSound(start_sound);

    move_sound = movable_cover_get_sound("move");
    if(isDefined(move_sound))
      self playLoopSound(move_sound);

    if(isDefined(self.animate_ent) && isDefined(level.movable_cover_move_anim[self.movable_type]["move"])) {
      self.animate_ent scriptmodelPlayanim(level.movable_cover_move_anim[self.movable_type]["move"]);
    }

    self MoveTo(move_to.origin, time, accel_time);

    if(auto) {
      self movable_cover_wait_for_user_or_timeout(time);
    } else {
      while(movable_cover_is_pushed(player, trigger, move_dir) && !self movable_cover_at_goal(move_to.origin)) {
        wait .05;
      }
      self movable_cover_set_user(undefined, undefined);
    }

    if(!self movable_cover_at_goal(move_to.origin)) {
      current_speed_scale = movable_cover_calc_move_speed_scale((GetTime() - start_time) / 1000, time, accel_time);
      current_speed = self.max_speed * current_speed_scale;

      dist = Distance(self.origin, move_to.origin);
      stop_dist = dist;
      if(current_speed > 0) {
        stop_dist = min(dist, current_speed * self.decel_time);
      }
      time = (2 * stop_dist) / self.max_speed;
      self MoveTo(self.origin + (stop_dist * move_dir), time, 0, time);
      wait time;
    }

    self StopLoopSound();

    stop_sound = movable_cover_get_sound("stop");
    if(isDefined(stop_sound))
      self playSound(stop_sound);
    if(isDefined(self.animate_ent) && isDefined(level.movable_cover_move_anim[self.movable_type]["idle"])) {
      self.animate_ent scriptmodelPlayanim(level.movable_cover_move_anim[self.movable_type]["idle"]);
    }

    if(stay && self movable_cover_at_goal(move_to.origin)) {
      self.stay = true;
    }

    if(self.updatePaths)
      self DisconnectPaths();
    self movable_cover_connect_traversals();
    self.moving = false;

    self notify("move_end");
  }
}

movable_cover_connect_traversals() {
  self movable_cover_disconnect_traversals();
  foreach(node in self.traverse_nodes) {
    switch (node.node_type) {
      case "closest":
        node.connected_to = getClosest(node.origin, node.connected_nodes);
        break;
      case "radius":
      case "radius3d":
        dist = Distance(node.origin, node.test_origin);
        if(dist <= node.test_radius)
          node.connected_to = node.connected_nodes[0];
        break;
      case "radius2d":
        dist2d = Distance2d(node.origin, node.test_origin);
        if(dist2d <= node.test_radius)
          node.connected_to = node.connected_nodes[0];
        break;
      default:
        break;
    }

    if(isDefined(node.connected_to)) {
      ConnectNodePair(node, node.connected_to);
    }
  }
}

movable_cover_disconnect_traversals() {
  foreach(node in self.traverse_nodes) {
    if(isDefined(node.connected_to)) {
      DisconnectNodePair(node, node.connected_to);
      node.connected_to = undefined;
    }
  }
}

movable_cover_get_sound(type) {
  if(!isDefined(level.movable_cover_move_sounds[self.movable_type]))
    return undefined;

  return level.movable_cover_move_sounds[self.movable_type][type];
}

movable_cover_wait_for_user_or_timeout(time) {
  self endon("new_user");
  wait time;
}

movable_cover_calc_move_speed_scale(current_time, move_time, accel_time, decel_time) {
  if(!isDefined(accel_time))
    accel_time = 0;
  if(!isDefined(decel_time))
    decel_time = 0;

  if(current_time >= move_time || current_time <= 0) {
    return 0;
  } else if(current_time < accel_time) {
    return 1 - ((accel_time - current_time) / accel_time);
  } else if(current_time > (move_time - decel_time)) {
    return 1 - ((current_time - (move_time - decel_time)) / decel_time);
  } else {
    return 1;
  }
}

movable_cover_is_pushed(player, trigger, move_dir) {
  if(!isDefined(player) || !IsReallyAlive(player) || !isPlayer(player))
    return false;

  if(!movable_cover_is_touched(trigger, player))
    return false;

  if(player IsMantling())
    return false;

  stance = player GetStance();
  if(!array_contains(self.stances, stance))
    return false;

  if(self.requires_push) {
    player_move_dir = player GetNormalizedMovement();
    player_move_dir = RotateVector(player_move_dir, -1 * player.angles);
    player_move_dir = VectorNormalize((player_move_dir[0], -1 * player_move_dir[1], 0));
    dot = VectorDot(move_dir, player_move_dir);
    return dot > 0.2;
  } else {
    return true;
  }
}

movable_cover_is_touched(trigger, player) {
  return isDefined(player) && isReallyAlive(player) && player IsTouching(trigger);
}

movable_cover_move_delay(delay, player, trigger, move_dir) {
  endTime = (delay * 1000) + GetTime();

  while(1) {
    if(!isDefined(player) || !isReallyAlive(player))
      return false;

    if(player IsMantling())
      return false;

    if(!movable_cover_is_pushed(player, trigger, move_dir))
      return false;

    if(self.moving)
      return false;

    if(getTime() >= endTime)
      return true;

    wait .05;
  }
}

movable_cover_at_goal(goal) {
  distSqr = DistanceSquared(self.origin, goal);

  return distSqr <= (self.goal_radius * self.goal_radius);
}

movable_cover_mantlebrush_think(mantlebrush) {
  self endon("death");

  while(1) {
    self waittill("move_start");
    if(isDefined(mantlebrush)) {
      mantlebrush.old_contents = mantlebrush SetContents(0);
      mantlebrush Hide();
    }
    self waittill("move_end");
    if(isDefined(mantlebrush)) {
      mantlebrush Show();
      mantlebrush SetContents(mantlebrush.old_contents);
    }
  }
}