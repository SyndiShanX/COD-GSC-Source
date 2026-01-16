/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_patrol.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#using_animtree("generic_human");

patrol_init() {
  level.scr_anim["generic"]["patrol_walk"] = % patrol_bored_patrolwalk;
  level.scr_anim["generic"]["patrol_walk_twitch"] = % patrol_bored_patrolwalk_twitch;
  level.scr_anim["generic"]["patrol_stop"] = % patrol_bored_walk_2_bored;
  level.scr_anim["generic"]["patrol_start"] = % patrol_bored_2_walk;
  level.scr_anim["generic"]["patrol_turn180"] = % patrol_bored_2_walk_180turn;
  level.scr_anim["generic"]["patrol_idle_1"] = % patrol_bored_idle;
  level.scr_anim["generic"]["patrol_idle_2"] = % patrol_bored_idle_smoke;
  level.scr_anim["generic"]["patrol_idle_3"] = % patrol_bored_idle_cellphone;
  level.scr_anim["generic"]["patrol_idle_4"] = % patrol_bored_twitch_bug;
  level.scr_anim["generic"]["patrol_idle_5"] = % patrol_bored_twitch_checkphone;
  level.scr_anim["generic"]["patrol_idle_6"] = % patrol_bored_twitch_stretch;
  level.scr_anim["generic"]["patrol_idle_smoke"] = % patrol_bored_idle_smoke;
  level.scr_anim["generic"]["patrol_idle_checkphone"] = % patrol_bored_twitch_checkphone;
  level.scr_anim["generic"]["patrol_idle_stretch"] = % patrol_bored_twitch_stretch;
  level.scr_anim["generic"]["patrol_idle_phone"] = % patrol_bored_idle_cellphone;
  level._patrol_init = 1;
}

patrol(start_target) {
  if(!isDefined(level._patrol_init))
    patrol_init();

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
  self allowedstances("stand");
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.disableturns = 1;
  self.allowdeath = 1;
  self.script_patroller = 1;
  waittillframeend;
  walkanim = "patrol_walk";

  if(isDefined(self.unique_patrol_walk_anim)) {
    walkanim = self.unique_patrol_walk_anim;
    self set_run_anim(walkanim, 1);
  } else {
    if(isDefined(self.patrol_walk_anim))
      walkanim = self.patrol_walk_anim;

    if(isDefined(self.script_patrol_walk_anim))
      walkanim = self.script_patrol_walk_anim;

    self set_generic_run_anim(walkanim, 1);
  }

  self thread patrol_walk_twitch_loop();
  get_goal_func = [];
  get_goal_func[1][1] = ::get_target_ents;
  get_goal_func[1][0] = ::get_linked_ents;
  get_goal_func[0][1] = ::get_target_nodes;
  get_goal_func[0][0] = ::get_linked_nodes;
  set_goal_func[1] = ::set_goal_ent;
  set_goal_func[0] = ::set_goal_node;

  if(isDefined(start_target))
    self.target = start_target;

  assert(isDefined(self.target) || isDefined(self.script_linkto), "Patroller with no target or script_linkto defined.");

  if(isDefined(self.target)) {
    link_type = 1;
    ents = self get_target_ents();
    nodes = self get_target_nodes();

    if(ents.size) {
      currentgoal = random(ents);
      goal_type = 1;
    } else {
      currentgoal = random(nodes);
      goal_type = 0;
    }
  } else {
    link_type = 0;
    ents = self get_linked_ents();
    nodes = self get_linked_nodes();

    if(ents.size) {
      currentgoal = random(ents);
      goal_type = 1;
    } else {
      currentgoal = random(nodes);
      goal_type = 0;
    }
  }

  assert(isDefined(currentgoal), "Initial goal for patroller is undefined");
  nextgoal = currentgoal;

  for(;;) {
    while(isDefined(nextgoal.patrol_claimed))
      wait 0.05;

    currentgoal.patrol_claimed = undefined;
    currentgoal = nextgoal;
    self notify("release_node");
    assert(!isDefined(currentgoal.patrol_claimed), "Goal was already claimed");

    if(!is_true(self.patrol_dont_claim_node))
      currentgoal.patrol_claimed = 1;

    self.last_patrol_goal = currentgoal;
    [
      [set_goal_func[goal_type]]
    ](currentgoal);

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
        default:
          if(isDefined(currentgoal.script_animation)) {
            anime = "patrol_idle_" + currentgoal.script_animation;
            self anim_generic(self, anime);
            start = "patrol_start";
            self anim_generic_custom_animmode(self, "gravity", start);
          }

          break;
      }
    }

    currentgoals = currentgoal[[get_goal_func[goal_type][link_type]]]();

    if(!currentgoals.size) {
      self notify("reached_path_end");

      if(isDefined(self) && isDefined(self.patroller_delete_on_path_end) && self.patroller_delete_on_path_end) {
        release_claimed_node();
        self notify("patroller_deleted_on_path_end");
        self delete();
      }

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

  if((isDefined(self.patrol_walk_anim) || isDefined(self.unique_patrol_walk_anim)) && !isDefined(self.patrol_walk_twitch)) {
    return;
  }
  while(true) {
    wait(randomfloatrange(8, 20));
    walkanim = "patrol_walk_twitch";

    if(isDefined(self.patrol_walk_twitch))
      walkanim = self.patrol_walk_twitch;

    self set_generic_run_anim(walkanim, 1);
    length = getanimlength(getanim_generic(walkanim));
    wait(length);
    walkanim = "patrol_walk";

    if(isDefined(self.unique_patrol_walk_anim)) {
      walkanim = self.unique_patrol_walk_anim;
      self set_run_anim(walkanim, 1);
    } else {
      if(isDefined(self.patrol_walk_anim))
        walkanim = self.patrol_walk_anim;

      if(isDefined(self.script_patrol_walk_anim))
        walkanim = self.script_patrol_walk_anim;

      self set_generic_run_anim(walkanim, 1);
    }
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
  release_claimed_node();
}

release_claimed_node() {
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
  self clear_run_anim();
  self allowedstances("stand", "crouch", "prone");
  self.disablearrivals = 0;
  self.disableexits = 0;
  self.disableturns = 0;
  self stopanimscripted();
  self notify("stop_animmode");
  self.allowdeath = 0;

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
    array = getentarray(self.target, "targetname");

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
    print3d(goal.origin, entnum, (1, 1, 0), 1);
    wait 0.05;
  }

}