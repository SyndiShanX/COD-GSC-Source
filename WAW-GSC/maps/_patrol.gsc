/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_patrol.gsc
**************************************/

#include maps\_utility;
#include maps\_anim;
#using_animtree("generic_human");
patrol(start_target) {
  if(isDefined(self.enemy)) {
    return;
  }
  self endon("death");
  self endon("end_patrol");
  level endon("_stealth_spotted");
  level endon("_stealth_found_corpse");
  self thread waittill_combat();
  self thread waittill_death();
  assert(!isDefined(self.enemy));
  self endon("enemy");
  self.goalradius = 32;
  self allowedStances("stand");
  self.disableArrivals = true;
  self.disableExits = true;
  self.allowdeath = true;
  self.script_patroller = 1;

  walkanim = "patrol_walk";
  if(isDefined(self.patrol_walk_anim))
    walkanim = self.patrol_walk_anim;

  waittillframeend;

  self set_generic_run_anim(walkanim, true);
  self thread patrol_walk_twitch_loop();

  get_goal_func[true][true] = ::get_target_ents;
  get_goal_func[true][false] = ::get_linked_ents;
  get_goal_func[false][true] = ::get_target_nodes;
  get_goal_func[false][false] = ::get_linked_nodes;
  set_goal_func[true] = ::set_goal_ent;
  set_goal_func[false] = ::set_goal_node;

  if(isDefined(start_target))
    self.target = start_target;

  assertEx(isDefined(self.target) || isDefined(self.script_linkto), "Patroller with no target or script_linkto defined.");

  if(isDefined(self.target)) {
    link_type = true;
    ents = self get_target_ents();
    nodes = self get_target_nodes();

    if(ents.size) {
      currentgoal = random(ents);
      goal_type = true;
    } else {
      currentgoal = random(nodes);
      goal_type = false;
    }
  } else {
    link_type = false;
    ents = self get_linked_ents();
    nodes = self get_linked_nodes();

    if(ents.size) {
      currentgoal = random(ents);
      goal_type = true;
    } else {
      currentgoal = random(nodes);
      goal_type = false;
    }
  }

  assertex(isDefined(currentgoal), "Initial goal for patroller is undefined");

  nextgoal = currentgoal;
  for(;;) {
    while(isDefined(nextgoal.patrol_claimed)) {
      wait 0.05;
    }

    currentgoal.patrol_claimed = undefined;
    currentgoal = nextgoal;
    self notify("release_node");

    assertex(!isDefined(currentgoal.patrol_claimed), "Goal was already claimed");
    currentgoal.patrol_claimed = true;

    self.last_patrol_goal = currentgoal;

    [[set_goal_func[goal_type]]](currentgoal);

    if(isDefined(currentgoal.radius) && currentgoal.radius > 0)
      self.goalradius = currentgoal.radius;
    else
      self.goalradius = 32;

    self waittill("goal");
    currentgoal notify("trigger", self);

    if(isDefined(currentgoal.script_animation)) {
      stop = "patrol_stop";
      self anim_generic_custom_animmode(self, "gravity", stop);
      switch (currentgoal.script_animation) {
        case "pause":
          idle = "patrol_idle_" + randomintrange(1, 6);
          self anim_generic(self, idle);
          start = "patrol_start";
          self anim_generic_custom_animmode(self, "gravity", start);
          break;
        case "turn180":
          turn = "patrol_turn180";
          self anim_generic_custom_animmode(self, "gravity", turn);
          break;
        case "smoke":
          anime = "patrol_idle_smoke";
          self anim_generic(self, anime);
          start = "patrol_start";
          self anim_generic_custom_animmode(self, "gravity", start);
          break;
        case "stretch":
          anime = "patrol_idle_stretch";
          self anim_generic(self, anime);
          start = "patrol_start";
          self anim_generic_custom_animmode(self, "gravity", start);
          break;
        case "checkphone":
          anime = "patrol_idle_checkphone";
          self anim_generic(self, anime);
          start = "patrol_start";
          self anim_generic_custom_animmode(self, "gravity", start);
          break;
        case "phone":
          anime = "patrol_idle_phone";
          self anim_generic(self, anime);
          start = "patrol_start";
          self anim_generic_custom_animmode(self, "gravity", start);
          break;
      }
    }

    currentgoals = currentgoal[[get_goal_func[goal_type][link_type]]]();

    if(!currentgoals.size) {
      self notify("reached_path_end");
      break;
    }

    nextgoal = random(currentgoals);
  }
}

patrol_walk_twitch_loop() {
  self endon("death");
  self endon("enemy");
  self endon("end_patrol");
  level endon("_stealth_spotted");
  level endon("_stealth_found_corpse");

  self notify("patrol_walk_twitch_loop");
  self endon("patrol_walk_twitch_loop");

  if(isDefined(self.patrol_walk_anim) && !isDefined(self.patrol_walk_twitch)) {
    return;
  }
  while(1) {
    wait randomfloatrange(8, 20);

    walkanim = "patrol_walk_twitch";
    if(isDefined(self.patrol_walk_twitch))
      walkanim = self.patrol_walk_twitch;

    self set_generic_run_anim(walkanim, true);
    length = getanimlength(getanim_generic(walkanim));
    wait length;

    walkanim = "patrol_walk";
    if(isDefined(self.patrol_walk_anim))
      walkanim = self.patrol_walk_anim;

    self set_generic_run_anim(walkanim, true);
  }
}

waittill_combat_wait() {
  self endon("end_patrol");
  level endon("_stealth_spotted");
  level endon("_stealth_found_corpse");
  self waittill("enemy");
}

waittill_death() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self notify("release_node");

  if(!isDefined(self.last_patrol_goal)) {
    return;
  }
  self.last_patrol_goal.patrol_claimed = undefined;
}

waittill_combat() {
  self endon("death");

  assert(!isDefined(self.enemy));

  waittill_combat_wait();

  if(!isDefined(self._stealth)) {
    self clear_run_anim();
    self allowedStances("stand", "crouch", "prone");
    self.disableArrivals = false;
    self.disableExits = false;
    self stopanimscripted();
    self notify("stop_animmode");
  }
  self.allowdeath = false;

  if(!isDefined(self)) {
    return;
  }
  self notify("release_node");

  if(!isDefined(self.last_patrol_goal)) {
    return;
  }
  self.last_patrol_goal.patrol_claimed = undefined;
}

get_target_ents() {
  array = [];

  if(isDefined(self.target))
    array = getEntArray(self.target, "targetname");

  return array;
}

get_target_nodes() {
  array = [];

  if(isDefined(self.target))
    array = getnodearray(self.target, "targetname");

  return array;
}

get_linked_nodes() {
  array = [];

  if(isDefined(self.script_linkto)) {
    linknames = strtok(self.script_linkto, " ");
    for(i = 0; i < linknames.size; i++) {
      ent = getnode(linknames[i], "script_linkname");
      if(isDefined(ent))
        array[array.size] = ent;
    }
  }

  return array;
}

showclaimed(goal) {
  self endon("release_node");

  for(;;) {
    entnum = self getentnum();
    print3d(goal.origin, entnum, (1.0, 1.0, 0.0), 1);
    wait 0.05;
  }
}