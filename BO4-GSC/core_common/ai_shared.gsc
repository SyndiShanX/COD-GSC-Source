/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai_shared.gsc
***********************************************/

#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\colors_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;

#namespace ai;

set_pacifist(val) {
  assert(issentient(self), "<dev string:x38>");
  self.pacifist = val;
}

disable_pain() {
  assert(isalive(self), "<dev string:x57>");
  self.allowpain = 0;
}

enable_pain() {
  assert(isalive(self), "<dev string:x7b>");
  self.allowpain = 1;
}

gun_remove() {
  self shared::placeweaponon(self.weapon, "none");
  self.gun_removed = 1;
}

gun_switchto(weapon, whichhand) {
  self shared::placeweaponon(weapon, whichhand);
}

gun_recall() {
  self shared::placeweaponon(self.primaryweapon, "right");
  self.gun_removed = undefined;
}

set_behavior_attribute(attribute, value) {
  if(isDefined(level.b_gmodifier_only_humans) && level.b_gmodifier_only_humans || isDefined(level.b_gmodifier_only_robots) && level.b_gmodifier_only_robots) {
    if(has_behavior_attribute(attribute)) {
      setaiattribute(self, attribute, value);
    }

    return;
  }

  setaiattribute(self, attribute, value);
}

get_behavior_attribute(attribute) {
  return getaiattribute(self, attribute);
}

has_behavior_attribute(attribute) {
  return hasaiattribute(self, attribute);
}

is_dead_sentient() {
  if(issentient(self) && !isalive(self)) {
    return 1;
  }

  return 0;
}

waittill_dead(guys, num, timeoutlength) {
  allalive = 1;

  for(i = 0; i < guys.size; i++) {
    if(isalive(guys[i])) {
      continue;
    }

    allalive = 0;
    break;
  }

  assert(allalive, "<dev string:x9e>");

  if(!allalive) {
    newarray = [];

    for(i = 0; i < guys.size; i++) {
      if(isalive(guys[i])) {
        newarray[newarray.size] = guys[i];
      }
    }

    guys = newarray;
  }

  ent = spawnStruct();

  if(isDefined(timeoutlength)) {
    ent endon(#"thread_timed_out");
    ent thread waittill_dead_timeout(timeoutlength);
  }

  ent.count = guys.size;

  if(isDefined(num) && num < ent.count) {
    ent.count = num;
  }

  array::thread_all(guys, &waittill_dead_thread, ent);

  while(ent.count > 0) {
    ent waittill(#"waittill_dead guy died");
  }
}

waittill_dead_or_dying(guys, num, timeoutlength) {
  newarray = [];

  for(i = 0; i < guys.size; i++) {
    if(isalive(guys[i])) {
      newarray[newarray.size] = guys[i];
    }
  }

  guys = newarray;
  ent = spawnStruct();

  if(isDefined(timeoutlength)) {
    ent endon(#"thread_timed_out");
    ent thread waittill_dead_timeout(timeoutlength);
  }

  ent.count = guys.size;

  if(isDefined(num) && num < ent.count) {
    ent.count = num;
  }

  array::thread_all(guys, &waittill_dead_or_dying_thread, ent);

  while(ent.count > 0) {
    ent waittill(#"waittill_dead_guy_dead_or_dying");
  }
}

private waittill_dead_thread(ent) {
  self waittill(#"death");
  ent.count--;
  ent notify(#"waittill_dead guy died");
}

waittill_dead_or_dying_thread(ent) {
  self util::waittill_either("death", "pain_death");
  ent.count--;
  ent notify(#"waittill_dead_guy_dead_or_dying");
}

waittill_dead_timeout(timeoutlength) {
  wait timeoutlength;
  self notify(#"thread_timed_out");
}

private wait_for_shoot() {
  self endon(#"stop_shoot_at_target", #"death");

  if(isvehicle(self) || isbot(self)) {
    self waittill(#"weapon_fired");
  } else {
    self waittill(#"shoot");
  }

  self.start_duration_comp = 1;
}

shoot_at_target(mode, target, tag, duration, sethealth, ignorefirstshotwait) {
  self endon(#"death", #"stop_shoot_at_target");
  assert(isDefined(target), "<dev string:xfb>");
  assert(isDefined(mode), "<dev string:x12c>");
  mode_flag = mode === "normal" || mode === "shoot_until_target_dead" || mode === "kill_within_time";
  assert(mode_flag, "<dev string:x167>");

  if(isDefined(duration)) {
    assert(duration >= 0, "<dev string:x1c2>");
  } else {
    duration = 0;
  }

  if(isDefined(sethealth) && isDefined(target)) {
    target.health = sethealth;
  }

  if(!isDefined(target) || mode === "shoot_until_target_dead" && target.health <= 0) {
    return;
  }

  if(isDefined(tag) && tag != "") {
    self setentitytarget(target, 1, tag);
  } else {
    self setentitytarget(target, 1);
  }

  self.start_duration_comp = 0;

  switch (mode) {
    case #"normal":
      break;
    case #"shoot_until_target_dead":
      duration = -1;
      break;
    case #"kill_within_time":
      target damagemode("next_shot_kills");
      break;
  }

  if(isvehicle(self)) {
    self util::clearallcooldowns();
  }

  if(ignorefirstshotwait === 1) {
    self.start_duration_comp = 1;
  } else {
    self thread wait_for_shoot();
  }

  if(isDefined(duration) && isDefined(target) && target.health > 0) {
    if(duration >= 0) {
      elapsed = 0;

      while(isDefined(target) && target.health > 0 && elapsed <= duration) {
        elapsed += 0.05;

        if(!(isDefined(self.start_duration_comp) && self.start_duration_comp)) {
          elapsed = 0;
        }

        waitframe(1);
      }

      if(isDefined(target) && mode == "kill_within_time") {
        self.perfectaim = 1;
        self.aim_set_by_shoot_at_target = 1;
        target waittill(#"death");
      }
    } else if(duration == -1) {
      target waittill(#"death");
    }
  }

  stop_shoot_at_target();
}

stop_shoot_at_target() {
  self clearentitytarget();

  if(isDefined(self.aim_set_by_shoot_at_target) && self.aim_set_by_shoot_at_target) {
    self.perfectaim = 0;
    self.aim_set_by_shoot_at_target = 0;
  }

  self notify(#"stop_shoot_at_target");
}

wait_until_done_speaking() {
  self endon(#"death");

  while(self.isspeaking) {
    waitframe(1);
  }
}

set_goal(value, key = "targetname", b_force = 0) {
  goal = getnode(value, key);

  if(isDefined(goal)) {
    self setgoal(goal, b_force);
  } else {
    goal = getent(value, key);

    if(isDefined(goal)) {
      self setgoal(goal, b_force);
    } else {
      goal = struct::get(value, key);

      if(isDefined(goal)) {
        self setgoal(goal.origin, b_force);
      }
    }
  }

  return goal;
}

force_goal(goto, b_shoot = 1, str_end_on, b_keep_colors = 0, b_should_sprint = 0) {
  self endon(#"death");
  s_tracker = spawnStruct();
  self thread _force_goal(s_tracker, goto, b_shoot, str_end_on, b_keep_colors, b_should_sprint);
  s_tracker waittill(#"done");
}

_force_goal(s_tracker, goto, b_shoot = 1, str_end_on, b_keep_colors = 0, b_should_sprint = 0) {
  self endon(#"death");
  self notify(#"new_force_goal");
  flagsys::wait_till_clear("force_goal");
  flagsys::set(#"force_goal");
  color_enabled = 0;

  if(!b_keep_colors) {
    if(isDefined(colors::get_force_color())) {
      color_enabled = 1;
      self colors::disable();
    }
  }

  allowpain = self.allowpain;
  ignoresuppression = self.ignoresuppression;
  grenadeawareness = self.grenadeawareness;

  if(!b_shoot) {
    self val::set(#"ai_forcegoal", "ignoreall", 1);
  } else if(self has_behavior_attribute("move_mode")) {
    var_a5151bf = self get_behavior_attribute("move_mode");
    self set_behavior_attribute("move_mode", "rambo");
  }

  if(b_should_sprint && self has_behavior_attribute("sprint")) {
    self set_behavior_attribute("sprint", 1);
  }

  self.ignoresuppression = 1;
  self.grenadeawareness = 0;
  self val::set(#"ai_forcegoal", "ignoreme", 1);
  self disable_pain();

  if(!isplayer(self)) {
    self pushplayer(1);
  }

  if(isDefined(goto)) {
    self setgoal(goto, 1);
  }

  self waittill(#"goal", #"new_force_goal", str_end_on);

  if(color_enabled) {
    colors::enable();
  }

  if(!isplayer(self)) {
    self pushplayer(0);
  }

  self clearforcedgoal();
  self val::reset(#"ai_forcegoal", "ignoreme");
  self val::reset(#"ai_forcegoal", "ignoreall");

  if(isDefined(allowpain) && allowpain) {
    self enable_pain();
  }

  if(self has_behavior_attribute("sprint")) {
    self set_behavior_attribute("sprint", 0);
  }

  if(isDefined(var_a5151bf)) {
    self set_behavior_attribute("move_mode", var_a5151bf);
  }

  self.ignoresuppression = ignoresuppression;
  self.grenadeawareness = grenadeawareness;
  flagsys::clear(#"force_goal");
  s_tracker notify(#"done");
}

stoppainwaitinterval() {
  self notify(#"painwaitintervalremove");
}

private _allowpainrestore() {
  self endon(#"death");
  self waittill(#"painwaitintervalremove", #"painwaitinterval");
  self.allowpain = 1;
}

painwaitinterval(msec) {
  self endon(#"death");
  self notify(#"painwaitinterval");
  self endon(#"painwaitinterval", #"painwaitintervalremove");
  self thread _allowpainrestore();

  if(!isDefined(msec) || msec < 20) {
    msec = 20;
  }

  while(isalive(self)) {
    self waittill(#"pain");
    self.allowpain = 0;
    wait float(msec) / 1000;
    self.allowpain = 1;
  }
}

patrol(start_path_node) {
  self endon(#"death", #"stop_patrolling");
  assert(isDefined(start_path_node), self.targetname + "<dev string:x1f3>");

  if(start_path_node.type === #"bad node") {
    errormsg = "<dev string:x24f>" + start_path_node.targetname + "<dev string:x266>" + int(start_path_node.origin[0]) + "<dev string:x26c>" + int(start_path_node.origin[1]) + "<dev string:x26c>" + int(start_path_node.origin[2]) + "<dev string:x270>";
    iprintln(errormsg);

    return;
  }

  assert(start_path_node.type === #"path" || isDefined(start_path_node.scriptbundlename), "<dev string:x282>" + start_path_node.targetname + "<dev string:x299>");
  self notify(#"go_to_spawner_target");
  self.target = undefined;
  self.old_goal_radius = self.goalradius;
  self.goalradius = 16;
  self thread end_patrol_on_enemy_targetting();
  self.currentgoal = start_path_node;
  self.patroller = 1;

  while(true) {
    if(isDefined(self.currentgoal.type) && self.currentgoal.type == "Path") {
      if(self has_behavior_attribute("patrol")) {
        self set_behavior_attribute("patrol", 1);
      }

      self setgoal(self.currentgoal, 1);
      self waittill(#"goal");

      if(isDefined(self.currentgoal.script_notify)) {
        self notify(self.currentgoal.script_notify);
        level notify(self.currentgoal.script_notify);
      }

      if(isDefined(self.currentgoal.script_flag_set)) {
        flag = self.currentgoal.script_flag_set;

        if(!isDefined(level.flag[flag])) {
          level flag::init(flag);
        }

        level flag::set(flag);
      }

      if(isDefined(self.currentgoal.script_flag_wait)) {
        flag = self.currentgoal.script_flag_wait;
        assert(isDefined(level.flag[flag]), "<dev string:x2d9>" + flag);
        level flag::wait_till(flag);
      }

      if(!isDefined(self.currentgoal.script_wait_min)) {
        self.currentgoal.script_wait_min = 0;
      }

      if(!isDefined(self.currentgoal.script_wait_max)) {
        self.currentgoal.script_wait_max = 0;
      }

      assert(self.currentgoal.script_wait_min <= self.currentgoal.script_wait_max, "<dev string:x310>" + self.currentgoal.targetname);

      if(!isDefined(self.currentgoal.scriptbundlename)) {
        wait_variability = self.currentgoal.script_wait_max - self.currentgoal.script_wait_min;
        wait_time = self.currentgoal.script_wait_min + randomfloat(wait_variability);
        self notify(#"patrol_goal", {
          #node: self.currentgoal
        });
        wait wait_time;
      } else {
        self scene::play(self.currentgoal.scriptbundlename, self);
      }
    } else if(isDefined(self.currentgoal.scriptbundlename)) {
      self.currentgoal scene::play(self.currentgoal.scriptbundlename, self);
    }

    self patrol_next_node();
  }
}

patrol_next_node() {
  target_nodes = [];
  target_scenes = [];

  if(isDefined(self.currentgoal.target)) {
    target_nodes = getnodearray(self.currentgoal.target, "targetname");
    target_scenes = struct::get_array(self.currentgoal.target, "targetname");
  }

  if(target_nodes.size == 0 && target_scenes.size == 0) {
    self end_and_clean_patrol_behaviors();
    return;
  }

  if(target_nodes.size != 0) {
    self.currentgoal = array::random(target_nodes);
    return;
  }

  self.currentgoal = array::random(target_scenes);
}

end_patrol_on_enemy_targetting() {
  self endon(#"death", #"alerted");

  while(true) {
    if(isDefined(self.should_stop_patrolling) && self.should_stop_patrolling) {
      self end_and_clean_patrol_behaviors();
    }

    wait 0.1;
  }
}

end_and_clean_patrol_behaviors() {
  if(isDefined(self.currentgoal) && isDefined(self.currentgoal.scriptbundlename)) {
    self stopanimscripted();
  }

  if(self has_behavior_attribute("patrol")) {
    self set_behavior_attribute("patrol", 0);
  }

  if(isDefined(self.old_goal_radius)) {
    self.goalradius = self.old_goal_radius;
  }

  self clearforcedgoal();
  self notify(#"stop_patrolling");
  self.patroller = undefined;
  self notify(#"alerted");
}

bloody_death(n_delay, hit_loc) {
  self endon(#"death");

  if(!isDefined(self)) {
    return;
  }

  assert(isactor(self));
  assert(isalive(self));

  if(isDefined(self.__bloody_death) && self.__bloody_death) {
    return;
  }

  self.__bloody_death = 1;

  if(isDefined(n_delay)) {
    wait n_delay;
  }

  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(isDefined(hit_loc)) {
    assert(isinarray(array("<dev string:x340>", "<dev string:x349>", "<dev string:x350>", "<dev string:x357>", "<dev string:x365>", "<dev string:x371>", "<dev string:x37f>", "<dev string:x391>", "<dev string:x3a2>", "<dev string:x3b4>", "<dev string:x3c5>", "<dev string:x3d2>", "<dev string:x3de>", "<dev string:x3f0>", "<dev string:x401>", "<dev string:x413>", "<dev string:x424>", "<dev string:x431>", "<dev string:x43d>", "<dev string:x443>"), hit_loc), "<dev string:x450>");
  } else {
    hit_loc = array::random(array("helmet", "head", "neck", "torso_upper", "torso_mid", "torso_lower", "right_arm_upper", "left_arm_upper", "right_arm_lower", "left_arm_lower", "right_hand", "left_hand", "right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot", "gun", "riotshield"));
  }

  self dodamage(self.health + 100, self.origin, undefined, undefined, hit_loc);
}

shouldregisterclientfieldforarchetype(archetype) {
  if(isDefined(level.clientfieldaicheck) && level.clientfieldaicheck && !isarchetypeloaded(archetype)) {
    return false;
  }

  return true;
}

set_protect_ent(entity) {
  if(!isDefined(entity.protect_tactical_influencer) && sessionmodeiscampaigngame()) {
    teammask = util::getteammask(self.team);
    entity.protect_tactical_influencer = createtacticalinfluencer("protect_entity_influencer_def", entity, teammask);
  }

  self.protectent = entity;

  if(isactor(self)) {
    self setblackboardattribute("_defend", "defend_enabled");
  }
}

set_group_protect_ent(e_ent_to_protect, defend_volume_name_or_ent) {
  a_defenders = self;

  if(!isDefined(a_defenders)) {
    a_defenders = [];
  } else if(!isarray(a_defenders)) {
    a_defenders = array(a_defenders);
  }

  if(isstring(defend_volume_name_or_ent)) {
    vol_defend = getent(defend_volume_name_or_ent, "targetname");
  } else if(isentity(defend_volume_name_or_ent)) {
    vol_defend = defend_volume_name_or_ent;
  }

  array::run_all(a_defenders, &setgoal, vol_defend, 1);
  array::thread_all(a_defenders, &set_protect_ent, e_ent_to_protect);
}

remove_protect_ent() {
  self.protectent = undefined;

  if(isactor(self)) {
    self setblackboardattribute("_defend", "defend_disabled");
  }
}

t_cylinder(origin, radius, halfheight) {
  struct = spawnStruct();
  struct.type = 1;
  struct.origin = origin;
  struct.radius = float(radius);
  struct.halfheight = float(halfheight);
  return struct;
}

function_470c0597(center, halfsize, angles) {
  assert(isvec(center));
  assert(isvec(halfsize));
  assert(isvec(angles));
  struct = spawnStruct();
  struct.type = 2;
  struct.center = center;
  struct.halfsize = halfsize;
  struct.angles = angles;
  return struct;
}

function_c2ee22a3(active) {
  self endon(#"death");

  if(active === 1) {
    self clearenemy();
    self.var_62376916 = 1;

    if(self has_behavior_attribute("patrol")) {
      self set_behavior_attribute("patrol", 1);
    }

    fov = 0.7;
    var_672a1bab = 1000000;
    self function_aa4579e2(fov, var_672a1bab);

    while(isDefined(self) && self.var_62376916 === 1 && !isDefined(self.enemy)) {
      wait 0.25;
    }
  }

  self.var_62376916 = 0;

  if(self has_behavior_attribute("patrol")) {
    self set_behavior_attribute("patrol", 0);
  }

  fov = 0;
  var_672a1bab = 64000000;

  if(isDefined(self.sightdistance)) {
    var_672a1bab = self.sightdistance * self.sightdistance;
  }

  self function_aa4579e2(0, 64000000);
}

function_aa4579e2(fovcosine, maxsightdistsqrd) {
  self.fovcosine = fovcosine;
  self.maxsightdistsqrd = maxsightdistsqrd;
}

function_1628d95b(cansee = 0, var_9a21f98d = 1, overrideorigin = self.origin) {
  var_56203bf4 = function_4d8c71ce(util::get_enemy_team(self.team), #"team3");
  nearesttarget = undefined;
  var_46e1d165 = undefined;

  foreach(target in var_56203bf4) {
    if(!isalive(target) || isDefined(target.var_becd4d91) && target.var_becd4d91 || target function_41b04632()) {
      continue;
    }

    if(cansee && var_9a21f98d) {
      if(!self cansee(target)) {
        continue;
      }
    } else if(cansee && !var_9a21f98d) {
      targetpoint = isDefined(target.var_88f8feeb) ? target.var_88f8feeb : target getcentroid();

      if(!sighttracepassed(self getEye(), targetpoint, 0, target)) {
        continue;
      }
    }

    distsq = distancesquared(overrideorigin, target.origin);

    if(!isDefined(nearesttarget) || distsq < var_46e1d165) {
      nearesttarget = target;
      var_46e1d165 = distsq;
    }
  }

  return nearesttarget;
}

function_31a31a25(var_9a21f98d = 1) {
  return function_1628d95b(1, var_9a21f98d);
}

function_41b04632() {
  return isDefined(self.targetname) && self.targetname == "destructible" && !isDefined(getent(self.target, "targetname"));
}

function_63734291(enemy) {
  if(!isDefined(enemy)) {
    return false;
  }

  var_aba9ee4c = 1;

  if(isDefined(self.var_ffa507cd)) {
    var_e1ea86de = self.var_ffa507cd;

    if(var_e1ea86de < randomfloat(1)) {
      var_aba9ee4c = 0;
    }
  }

  if(var_aba9ee4c && isvehicle(enemy) && !(isDefined(enemy.var_c95dcb15) && enemy.var_c95dcb15)) {
    dist_squared = distancesquared(self.origin, enemy.origin);

    if(dist_squared >= 562500) {
      enemy notify(#"hash_4853a85e5ddc4a47");
      return true;
    }
  }

  return false;
}

stun(duration = self.var_95d94ac4) {
  if(!isDefined(duration) || !(isDefined(self.var_28aab32a) && self.var_28aab32a) || isDefined(self.var_c2986b66) && self.var_c2986b66 || isDefined(self.var_b736fc8b) && self.var_b736fc8b) {
    return;
  }

  end_time = gettime() + int(duration * 1000);

  if(isDefined(self.var_3d461e6f) && self.var_3d461e6f > end_time) {
    return;
  }

  self.var_3d461e6f = end_time;
}

is_stunned() {
  return isDefined(self.var_3d461e6f) && gettime() < self.var_3d461e6f;
}

clear_stun() {
  self.var_3d461e6f = undefined;
}

function_9139c839() {
  if(!isDefined(self.var_76167463)) {
    if(isDefined(self.aisettingsbundle)) {
      settingsbundle = self.aisettingsbundle;
    } else if(isspawner(self) && isDefined(self.aitype)) {
      settingsbundle = function_edf479a3(self.aitype);
    } else if(isvehicle(self) && isDefined(self.scriptbundlesettings)) {
      settingsbundle = getscriptbundle(self.scriptbundlesettings).aisettingsbundle;
    }

    if(!isDefined(settingsbundle)) {
      return undefined;
    }

    self.var_76167463 = settingsbundle;

    if(!isDefined(level.var_e3a467cf)) {
      level.var_e3a467cf = [];
    }

    if(!isDefined(level.var_e3a467cf[self.var_76167463])) {
      level.var_e3a467cf[self.var_76167463] = getscriptbundle(self.var_76167463);
    }
  }

  return level.var_e3a467cf[self.var_76167463];
}

function_71919555(var_45302432, fieldname) {
  if(!isDefined(level.var_e3a467cf)) {
    level.var_e3a467cf = [];
  }

  if(!isDefined(level.var_e3a467cf[var_45302432])) {
    level.var_e3a467cf[var_45302432] = getscriptbundle(var_45302432);
  }

  if(isDefined(level.var_e3a467cf[var_45302432])) {
    return level.var_e3a467cf[var_45302432].(fieldname);
  }

  return undefined;
}