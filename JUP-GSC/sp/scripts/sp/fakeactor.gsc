/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\fakeactor.gsc
***********************************************/



#using script_1d1c16f25c2bda5e;
#using scripts\anim\face;
#using scripts\anim\notetracks;
#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\code\character;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\debug;
#using scripts\sp\fakeactor_node;
#using scripts\sp\friendlyfire;
#using scripts\sp\names;
#using scripts\sp\spawner;
#using scripts\sp\utility;
#namespace fakeactor;

function fakeactor_spawner_init() {
  if(isDefined(level.var_7e52ed5e6f4f3456)) {
    return;
  }

  level.var_7e52ed5e6f4f3456 = 1;
  setdvarifuninitialized(@ "debug_fakeactor", 0);
  setdvarifuninitialized(@ "hash_ab259d9b09bad834", 0);
  level._effect["fakeactor_muzflash"] = loadfx("vfx/core/muzflash/ak47_flash_wv");

  if(!isDefined(level.max_fakeactors)) {
    level.max_fakeactors = [];
  }

  if(!isDefined(level.max_fakeactors["allies"])) {
    level.max_fakeactors["allies"] = 9999;
  }

  if(!isDefined(level.max_fakeactors["axis"])) {
    level.max_fakeactors["axis"] = 9999;
  }

  if(!isDefined(level.max_fakeactors["team3"])) {
    level.max_fakeactors["team3"] = 9999;
  }

  if(!isDefined(level.max_fakeactors["neutral"])) {
    level.max_fakeactors["neutral"] = 9999;
  }

  if(!isDefined(level.fakeactors)) {
    level.fakeactors = [];
  }

  if(!isDefined(level.fakeactors["allies"])) {
    level.fakeactors["allies"] = struct_arrayspawn();
  }

  if(!isDefined(level.fakeactors["axis"])) {
    level.fakeactors["axis"] = struct_arrayspawn();
  }

  if(!isDefined(level.fakeactors["team3"])) {
    level.fakeactors["team3"] = struct_arrayspawn();
  }

  if(!isDefined(level.fakeactors["neutral"])) {
    level.fakeactors["neutral"] = struct_arrayspawn();
  }

  if(!isDefined(level.fa_state_machines)) {
    add_state("default", "anim", &play_anim_think, &play_anim_check, 30);
    add_state("default", "move", &move_think, &move_check, 10);
    add_state("default", "traverse", &traverse_think, &traverse_check, 20);
    add_state("default", "idle", &idle_think, &idle_check, 40);
  }

  level.fakeactor_spawn_func = &fakeactor_init;

  if(!isDefined(anim.fa_nodeyaws)) {
    yaws = [];
    yaws["Cover Left"] = 0;
    yaws["Cover Right"] = -90;
    yaws["Cover Crouch"] = -90;
    yaws["Cover Stand"] = -90;
    yaws["Cover Stand 3D"] = -90;
    anim.fa_nodeyaws = yaws;
    yaws = [];
    yaws["Cover Left"] = 180;
    yaws["Cover Left Crouch"] = 0;
    yaws["Cover Right"] = 180;
    yaws["Cover Crouch"] = 180;
    yaws["Cover Stand"] = 180;
    anim.fa_franticnodeyaws = yaws;
  }

  if(getDvar(@ "debug_fakeactor") == "<dev string:x1c>") {
    if(!isDefined(level.var_2f9d164a52baaa1f)) {
      level.var_2f9d164a52baaa1f = 1;
      level thread fakeactor_node_debug();
    }
  }

}

function spawndroneaitype(aitypename, spawnorigin, spawnangles) {
  drone = function_222b1f15eb8b4c99(aitypename, spawnorigin, spawnangles);
  aitypestruct = drone function_2342f46a32ebb549(aitypename);
  charactername = drone function_5b013e24038aeed0(aitypename, drone.script_char_index, drone.script_char_group, drone.characterlistname);
  fakeactorstruct = drone function_1594d4be88eaa4aa(charactername);
  function_7da0d54cb9c485b6(drone, aitypestruct, fakeactorstruct, charactername);
  drone rundronepostspawn();
  return drone;
}

function spawndrone() {
  drone = self spawndronecode();
  aitypestruct = self function_2342f46a32ebb549();
  charactername = self function_5b013e24038aeed0(drone.classname, self.script_char_index, self.script_char_group, self.characterlistname);
  fakeactorstruct = self function_1594d4be88eaa4aa(charactername);
  function_7da0d54cb9c485b6(drone, aitypestruct, fakeactorstruct, charactername);
  drone rundronepostspawn();
  return drone;
}

function function_7da0d54cb9c485b6(drone, aitypestruct, fakeactorstruct, charactername) {
  drone.team = aitypestruct.team;
  drone.unittype = aitypestruct.unittype;
  drone.animationarchetype = fakeactorstruct.animationarchetype;
  drone.animtree = fakeactorstruct.animtree;
  drone.voice = fakeactorstruct.voice;
  drone function_86ac638eaef7e755(fakeactorstruct.animationarchetype);

  if(isDefined(fakeactorstruct.bodymodel)) {
    drone setModel(fakeactorstruct.bodymodel);
  } else if(isDefined(fakeactorstruct.bodyalias)) {
    drone function_6b0082dec4510b24(fakeactorstruct.bodyalias, [[level.fncharacterxmodelalias[charactername]]](fakeactorstruct.bodyalias));
  }

  if(isDefined(fakeactorstruct.headmodel)) {
    drone attach(fakeactorstruct.headmodel, "", 1);
    drone.headmodel = fakeactorstruct.headmodel;
  } else if(isDefined(fakeactorstruct.headalias)) {
    drone scripts\code\character::attachhead(fakeactorstruct.headalias, [[level.fncharacterxmodelalias[charactername]]](fakeactorstruct.headalias));
  }

  if(isDefined(fakeactorstruct.hatmodel)) {
    drone.hatmodel = fakeactorstruct.hatmodel;
    drone attach(fakeactorstruct.hatmodel);
    return;
  }

  if(isDefined(fakeactorstruct.hatalias)) {
    drone scripts\code\character::attachhat(fakeactorstruct.hatalias, [[level.fncharacterxmodelalias[charactername]]](fakeactorstruct.hatalias));
  }
}

function get_fakeactors(team) {
  return level.fakeactors[team].array;
}

function is_fakeactor() {
  return isDefined(self.script_fakeactor) && self.script_fakeactor;
}

function fakeactor_init(expendable) {
  expendable = default_to(expendable, 0);

  if(level.fakeactors[self.team].array.size >= level.max_fakeactors[self.team]) {
    assertmsg("You have reached the MAX_FAKEACTORS limit of " + 9999 + " for team " + self.team + ". What is wrong with you?! Fake Actor not created.");
    self delete();
    return;
  }

  thread array_handling(self);
  level notify("new_fakeactor");
  self.script_forcespawn = undefined;
  self.flags = 0;
  self.upaimlimit = -89;
  self.downaimlimit = 45;
  self.rightaimlimit = -45;
  self.leftaimlimit = 45;
  self.baseaccuracy = 1;

  if(isDefined(self.var_f7e4ad5c054874e1)) {
    self.look_ahead_value = self.var_f7e4ad5c054874e1;
  } else {
    self.look_ahead_value = 200;
  }

  if(isDefined(self.var_e0e17a8b499a050c)) {
    self.loop_time = self.var_e0e17a8b499a050c;
  } else {
    self.loop_time = 0.5;
  }

  set_animsets(["exposed"]);

  if(isDefined(self.script_demeanor)) {
    if(self.script_demeanor == "frantic") {
      set_frantic(1);
    }

    self.script_demeanor = undefined;
  }

  if(isDefined(self.script_do_arrivals)) {
    set_do_arrivals(self.script_do_arrivals);
    self.script_do_arrivals = undefined;
  }

  if(isDefined(self.script_do_exits)) {
    set_do_exits(self.script_do_exits);
    self.script_do_exits = undefined;
  }

  if(isDefined(self.script_ignore_claimed)) {
    set_ignore_claimed(self.script_ignore_claimed);
    self.script_ignore_claimed = undefined;
  }

  if(isDefined(self.script_use_real_fire)) {
    set_real_fire(self.script_use_real_fire);
    self.script_use_real_fire = undefined;
  }

  if(isDefined(self.script_use_pain)) {
    set_use_pain(self.script_use_pain);
    self.script_use_pain = undefined;
  }

  if(isDefined(self.script_animname)) {
    self.animname = self.script_animname;
    self.script_animname = undefined;
  }

  if(istrue(level.var_7ccd8910ee20ea8e)) {
    function_cc5fb4563e4cbd5d();
  }

  fakeactor_give_soul();
  self hide();
  delaycall(0.05, &show);

  if(self.team == "axis" && !isDefined(self.script_ignoreme)) {
    self enableaimassist();
  }

  function_1141363bb50145eb();

  if(!istrue(self.var_a328fea8cfacdcec)) {
    self makeentitysentient(self.team, expendable);
  }

  thread fakeactor_thinks();
}

function function_b4deaa96649c12db() {
  if(isDefined(self.health) && self.health > 0) {
    return;
  }

  set_animsets(["exposed"]);
  fakeactor_give_soul();
  self.health = 1;
  self setCanDamage(0);
}

function function_b247aabd62f70947() {
  if(function_2fdfcaea9fdf106a()) {
    return;
  }

  fakeactor_give_soul();
  set_animsets(["exposed"]);
  function_1141363bb50145eb();
  self.flags = 4096;
  thread death_think();
}

function private function_1141363bb50145eb() {
  self setCanDamage(1);
  self.health = 150;

  if(self.team == "neutral") {
    self.team = "allies";
  }
}

function create_state_machine(machinename) {
  if(!isDefined(level.fa_state_machines)) {
    level.fa_state_machines = [];
  }

  level.fa_state_machines[machinename] = [];
}

function get_state_machine(machinename) {
  return level.fa_state_machines[machinename];
}

function add_state(machinename, statename, thinkfunc, changefunc, priority) {
  if(!isDefined(level.fa_state_machines)) {
    level.fa_state_machines = [];
  }

  if(!isDefined(level.fa_state_machines[machinename])) {
    create_state_machine(machinename);
  }

  index = level.fa_state_machines[machinename].size;
  level.fa_state_machines[machinename][index] = [];
  level.fa_state_machines[machinename][index]["priority"] = priority;
  level.fa_state_machines[machinename][index]["stateName"] = statename;
  level.fa_state_machines[machinename][index]["thinkFunc"] = thinkfunc;
  level.fa_state_machines[machinename][index]["changeFunc"] = changefunc;
  level.fa_state_machines[machinename] = array_sort_with_func(level.fa_state_machines[machinename], &is_higher_priority);
}

function remove_state(machinename, statename) {
  if(!isDefined(level.fa_state_machines[machinename])) {
    return;
  }

  new_states = [];

  foreach(state in level.fa_state_machines[machinename]) {
    if(state["stateName"] != statename) {
      new_states[new_states.size] = state;
    }
  }

  level.fa_state_machines[machinename] = new_states;
}

function fakeactor_give_soul() {
  setup_animation();

  if(self.team == "allies" && isDefined(self.name)) {
    scripts\sp\names::get_name();
    self setlookattext(self.name, &"");
  } else if(self.team == "axis") {
    self setlookattext("enemy", &"");
  }

  if(isDefined(self.script_moveplaybackrate)) {
    self.moveplaybackrate = self.script_moveplaybackrate;
  } else {
    self.moveplaybackrate = 1;
  }

  if(!isDefined(self.script_friendly_fire_disable) || !self.script_friendly_fire_disable) {
    level thread scripts\sp\friendlyfire::friendly_fire_think(self);
  }

  self startusingheroonlylighting();

  if(isDefined(self.target)) {
    fakeactor_target = getStructArray(self.target, "targetname");
    fakeactor_target = random(fakeactor_target);

    if(isDefined(fakeactor_target) && fakeactor_target is_fakeactor_node()) {
      set_current_node(fakeactor_target);
    }
  }
}

function fakeactor_thinks() {
  waittillframeend();
  thread update_state_machine();
  thread move_message_think();
  thread watch_aim_target_think();
  thread make_real_ai_think();
  thread death_think();

  if(getDvar(@ "debug_fakeactor") == "<dev string:x1c>") {
    thread debug_draw();
  }
}

function make_real_ai_think() {
  self endon("death");
  thread real_ai_distance_check();
  self waittill("make_real_ai");
  stop_magic_bullet_shield();
  current_weapon = self.weapon;
  target_override = "";

  if(isDefined(self.current_node) && isDefined(self.current_node.target)) {
    target_override = self.current_node.target;
  }

  ai = scripts\sp\spawner::spawner_makerealai(self, target_override);
  ai scripts\anim\shared::placeweaponon(current_weapon, "right");

  if(isDefined(self)) {
    self delete();
  }
}

function function_cc5fb4563e4cbd5d(radius) {
  fakeai = self;

  if(!isDefined(fakeai.nav_repulsor)) {
    if(!isDefined(radius)) {
      radius = -1;
    }

    repulsorname = "navRepulsor" + fakeai getentitynumber();
    fakeai.nav_repulsor = repulsorname;
    createnavrepulsor(repulsorname, -1, fakeai, radius);
    fakeai thread function_1cd7838306276b5f();
  }
}

function function_ca5cea9991fa5306() {
  fakeai = self;

  if(isDefined(fakeai.nav_repulsor)) {
    destroynavrepulsor(fakeai.nav_repulsor);
    fakeai.nav_repulsor = undefined;
    self notify("removed_nav_repulsor");
  }
}

function private function_1cd7838306276b5f() {
  self endon("removed_nav_repulsor");
  self waittill("death");
  function_ca5cea9991fa5306();
}

function watch_for_obstacles_think() {
  self endon("death");
  self endon("goal");
  var_f3edcefbabc5a8f0 = squared(128);

  while(true) {
    if(distancesquared(level.player getorigin(), self.origin) < var_f3edcefbabc5a8f0) {
      obstacle_in_way(1);
    } else {
      obstacle_in_way(0);
    }

    wait 0.05;
  }
}

function real_ai_distance_check() {
  self endon("death");
  self endon("make_real_ai");

  if(!isDefined(self.radius) || self.radius <= 0) {
    return;
  }

  while(true) {
    if(distancesquared(level.player getEye(), self.origin) < squared(self.radius)) {
      self notify("make_real_ai");
      return;
    }

    wait 0.05;
  }
}

function check_node_is_claimed() {
  if(is_ignore_claimed()) {
    return 0;
  }

  return self.current_node fakeactor_node_is_claimed_by(self);
}

function change_state(state) {
  self.previous_state = self.current_state;
  self notify("change_state");
  cleanup_state_ents();
  self.current_state = state["stateName"];
  self thread[[state["thinkFunc"]]]();
}

function add_state_ent(ent) {
  if(!isDefined(self.current_state_ents)) {
    self.current_state_ents = [];
  }

  self.current_state_ents[self.current_state_ents.size] = ent;
}

function cleanup_state_ents() {
  if(isDefined(self.current_state_ents)) {
    foreach(ent in self.current_state_ents) {
      if(isDefined(ent)) {
        ent delete();
      }
    }
  }
}

function update_state_machine() {
  self endon("death");
  self endon("make_real_ai");
  self.previous_state = "";
  state_machine = "default";

  if(isDefined(self.state_machine)) {
    state_machine = self.state_machine;
  }

  while(true) {
    wait 0.05;

    if(is_controlled()) {
      continue;
    }

    foreach(state in get_state_machine(state_machine)) {
      if(isDefined(self.current_state) && self.current_state == state["stateName"]) {
        continue;
      }

      if([[state["changeFunc"]]]()) {
        change_state(state);
        break;
      }
    }
  }
}

function idle_check() {
  if(!isDefined(self.current_state)) {
    return true;
  }

  if(self.current_node fakeactor_node_is_claimed_by(self)) {
    return true;
  }

  return false;
}

function idle_think() {
  self endon("death");
  self endon("change_state");
  self endon("cap_start");
  fakeactor_check_delete();
  self notify("goal");

  while(isDefined(self)) {
    if(isDefined(self.idle_anim_override)) {
      play_scripted_anim(get_idle_anim());
      continue;
    }

    if(isDefined(self.unittype) && self.unittype == "civilian") {
      childthread civ_think();
      self waittill("start_next_fight");
      continue;
    }

    childthread fight_think();
    self waittill("start_next_fight");
  }
}

function fight_think() {
  self endon("death");
  self endon("change_state");
  self endon("cap_start");

  if(!isDefined(self.ignoreall)) {
    if(isDefined(self.current_node)) {
      possible_targets = self.current_node get_linked_ents();
      possible_targets = array_combine(possible_targets, self.current_node get_linked_structs());

      if(possible_targets.size) {
        target = random(possible_targets);
        offset = (0, 0, 0);

        if(isDefined(target.radius)) {
          x_offset = randomfloatrange(target.radius * -1, target.radius);
          y_offset = randomfloatrange(target.radius * -1, target.radius);
          offset = (x_offset, y_offset, 0);
        }

        set_aim_target(target, offset);
      }
    }

    hide_to_aim_anim = get_hide_to_aim_anim();
    aim_to_hide_anim = get_aim_to_hide_anim();
    old_origin = self.origin;

    if(isDefined(hide_to_aim_anim) && isDefined(aim_to_hide_anim)) {
      play_scripted_anim(hide_to_aim_anim);
    }

    self notify("start_aim");
    fire_weapon(get_shoot_anim());
    self notify("end_aim");

    if(isDefined(hide_to_aim_anim) && isDefined(aim_to_hide_anim)) {
      play_scripted_anim(aim_to_hide_anim);
    }

    if(should_fire()) {
      reload_anim = get_reload_anim();

      if(isDefined(reload_anim)) {
        play_scripted_anim(reload_anim);
      }
    }

    if(cointoss()) {
      prev_animset = self.animset;
      pick_random_animset();

      if(self.animset != prev_animset) {
        play_scripted_anim(get_stance_change_anim());
      }
    }
  }

  play_scripted_anim(get_idle_anim());
  set_wants_to_move(1);
  self notify("start_next_fight");
}

function civ_think() {
  play_scripted_anim(get_idle_anim());
  self notify("start_next_fight");
}

function traverse_check() {
  if(isDefined(self.current_node) && self.current_node fakeactor_node_is_claimed_by(self) && self.current_node fakeactor_node_is_traverse()) {
    return true;
  }

  return false;
}

function traverse_think() {
  self endon("death");
  set_controlled(1);
  animation = do_traverse_anim(self.current_node.traverse_animscript);
  set_controlled(0);
  set_wants_to_move(1);
}

function turn_check() {
  if(self.current_node fakeactor_node_is_claimed_by(self) && self.current_node fakeactor_node_is_turn()) {
    return true;
  }

  return false;
}

function turn_think() {
  self endon("death");
  set_controlled(1);
  next_node = self.current_node fakeactor_node_get_next();
  play_scripted_anim(get_turn_anim(self.angles, self.origin, next_node.origin));
  set_controlled(0);
  set_wants_to_move(1);
}

function play_anim_check() {
  if(isDefined(self.current_node) && self.current_node fakeactor_node_is_claimed_by(self) && self.current_node fakeactor_node_is_animation()) {
    if(!isDefined(self.current_node.last_actor) || self.current_node.last_actor != self) {
      return true;
    }
  }

  return false;
}

function play_anim_think() {
  self endon("death");
  set_controlled(1);
  self.current_node.anim_node anim_generic_run(self, self.current_node.animation);
  self.current_node.last_actor = self;
  set_controlled(0);
  set_wants_to_move(1);
  self notify("played_anim");
}

function do_traverse_anim(traverse_animscript) {
  traverse_animation = get_traverse_anim(traverse_animscript);

  if(!isDefined(traverse_animation)) {
    assertmsg("<dev string:x1e>");
  }

  play_scripted_anim(traverse_animation, undefined, &handletraversenotetracks, "traverseAnim", self.current_node);
}

function move_message_think() {
  self endon("death");
  self endon("make_real_ai");

  while(true) {
    self waittill("move");
    set_wants_to_move(1);
  }
}

function move_check() {
  if(isDefined(self.forced_node_path)) {
    self.node_path = self.forced_node_path;
    self.forced_node_path = undefined;
    return true;
  }

  if(!isDefined(self.current_node)) {
    return false;
  }

  wants_to_move = does_want_to_move();
  node_path = undefined;

  if(!isDefined(self.current_state) && isDefined(self.current_node)) {
    node_path = fakeactor_node_get_path(self.current_node, self.origin, is_frantic(), wants_to_move);
  }

  if(self.current_node fakeactor_node_is_claimed_by(self) && !self.current_node fakeactor_node_is_end_path(wants_to_move)) {
    next_node = self.current_node fakeactor_node_get_next();
    node_path = fakeactor_node_get_path(next_node, self.origin, is_frantic(), wants_to_move);
  }

  if(isDefined(node_path)) {
    foreach(node in node_path) {
      if(node["dist"] > 0) {
        self.node_path = node_path;
        return true;
      }
    }
  }

  return false;
}

function play_running_anim() {
  self endon("death");
  self endon("change_state");
  self endon("cap_start");
  self notify("stop_running_anim");
  self endon("stop_running_anim");
  run_rate = 1;

  if(isDefined(self.run_rate_min) && isDefined(self.run_rate_max)) {
    run_rate = randomfloatrange(self.run_rate_min, self.run_rate_max);
  }

  while(true) {
    run_anim = get_movement_anim();
    var_efdb0df9410c1967 = get_anim_data(run_anim);
    run_speed = var_efdb0df9410c1967.run_speed;
    anim_relative = var_efdb0df9410c1967.anim_relative;
    play_running_anim_internal(run_anim, run_rate);
    wait getanimlength(run_anim);
  }
}

function move_think() {
  self endon("death");
  self endon("change_state");
  self endon("cap_start");
  self notify("exit_node");
  start_pos = self.origin;
  wants_to_move = does_want_to_move();

  if(self.node_path.size == 0) {
    assertmsg("How did you start moving but have no path to move on?");
  }

  if(isDefined(self.current_node)) {
    self.current_node fakeactor_node_remove_claimed(self);
  }

  run_anim = get_movement_anim();
  var_efdb0df9410c1967 = get_anim_data(run_anim);
  run_speed = var_efdb0df9410c1967.run_speed;
  anim_relative = var_efdb0df9410c1967.anim_relative;

  if(!anim_relative) {
    childthread lock_to_ground(run_speed);
  }

  last_node = self.node_path[self.node_path.size - 1];

  if(self.node_path[0]["total_dist"] < 64) {
    thread play_scripted_anim(get_idle_anim());
    mover = spawn_script_origin(self.origin, self.angles);
    add_state_ent(mover);
    self linkTo(mover);
    time = 0.2;
    mover moveTo(last_node["origin"], time);
    mover rotateTo(last_node["angles"], time);
    waittill_notify_or_timeout("death", time);
    self unlink();
    mover delete();

    if(self.current_node != last_node["node"]) {
      self.current_node = last_node["node"];
    }

    self.current_node fakeactor_node_set_claimed(self);
    fakeactor_check_node(self.current_node);
    set_wants_to_move(0);
    self notify("arrive_node");
    return;
  }

  var_5b24559811e24059 = 0;
  exit_pos = undefined;

  if(should_do_exits()) {
    next_node = 0;

    foreach(node in self.node_path) {
      if(next_node) {
        exit_pos = node["origin"];
        break;
      }

      if(node["dist"] > 0) {
        next_node = 1;
      }
    }

    if(isDefined(exit_pos)) {
      exit_anim = get_exit_anim(exit_pos);
      play_scripted_anim(exit_anim);
    }
  }

  arrival_anim = undefined;
  arrival_cover = random(last_node["node"] fakeactor_node_get_cover_list());

  if(should_do_arrivals() && !last_node["node"] fakeactor_node_is_traverse() && !last_node["node"] fakeactor_node_is_turn() && last_node["node"] fakeactor_node_allow_arrivals()) {
    start_node = self;

    if(isDefined(self.node_path[self.node_path.size - 2]["node"])) {
      start_node = self.node_path[self.node_path.size - 2]["node"];
    }

    arrival_anim = get_arrival_anim(last_node["node"], start_node, arrival_cover);

    if(isDefined(arrival_anim)) {
      move_delta = getmovedelta(arrival_anim, 0, 1);
      angles_delta = getangledelta3d(arrival_anim, 0, 1);
      var_d0c16329c928493d = invertangles(angles_delta);
      new_angles = combineangles(last_node["angles"], var_d0c16329c928493d);
      new_origin = last_node["origin"] - rotatevector(move_delta, new_angles);
      last_node["anim_node"] = spawn_script_origin(new_origin, new_angles);
      add_state_ent(last_node["anim_node"]);
      last_node["origin"] = new_origin;
      last_node["angles"] = new_angles;
    }
  }

  thread play_running_anim();
  thread watch_for_obstacles_think();
  self.current_node = self.node_path[var_5b24559811e24059 + 1]["node"];
  move_scale = 1;

  if(isDefined(self.move_scale)) {
    move_scale = self.move_scale;
  }

  while(true) {
    var_af9a86169a742594 = self.node_path[var_5b24559811e24059]["to_next_node"];
    var_54cf1c15e3ab960a = self.origin - self.node_path[var_5b24559811e24059]["origin"];
    var_e59c6c4e67c2f3c5 = vectordot(var_af9a86169a742594, var_54cf1c15e3ab960a);

    if(var_5b24559811e24059 == self.node_path.size) {
      break;
    }

    var_b5b08eaf3fc975bb = var_e59c6c4e67c2f3c5 + self.look_ahead_value;

    while(var_b5b08eaf3fc975bb > self.node_path[var_5b24559811e24059]["dist"]) {
      var_b5b08eaf3fc975bb -= self.node_path[var_5b24559811e24059]["dist"];
      var_5b24559811e24059++;

      if(var_5b24559811e24059 == self.node_path.size) {
        if(self.current_node != last_node["node"]) {
          self.current_node = last_node["node"];
        }

        time = 0;
        desired_forward = (0, 0, 0);
        current_up = (0, 0, 0);
        new_right = (0, 0, 0);
        var_eab404ade8bcb9f6 = last_node["origin"] - self.origin;
        desired_forward = vectortoangles(var_eab404ade8bcb9f6);
        dist = length(var_eab404ade8bcb9f6);
        time = dist / run_speed * move_scale;

        if(time > 0) {
          if(anim_relative) {
            self moveTo(last_node["origin"], time);
            self rotateTo(desired_forward, time * 0.25);
            wait time;
          } else {
            mover = spawn_script_origin(self.origin, self.angles);
            add_state_ent(mover);
            self linkTo(mover);
            mover moveTo(last_node["origin"], time);
            mover rotateTo(desired_forward, time * 0.25);
            waittill_notify_or_timeout("death", time);
            self unlink();
            mover delete();
          }
        }

        if(isDefined(arrival_anim)) {
          self notify("stop_running_anim");
          play_scripted_anim(arrival_anim, undefined, undefined, undefined, last_node["anim_node"], 0);
          last_node["anim_node"] delete();
          set_animsets([arrival_cover]);
        } else {
          self.angles = last_node["angles"];
          set_animsets(self.current_node fakeactor_node_get_cover_list());
        }

        if(isDefined(self.node_path[var_5b24559811e24059 - 1]["looping"])) {
          var_5b24559811e24059 = 1;
          self.current_node = self.node_path[var_5b24559811e24059 + 1]["node"];
          break;
        } else {
          self.current_node fakeactor_node_set_claimed(self);
          fakeactor_check_node(self.current_node);
          self notify("stop_running_anim");
          set_wants_to_move(0);
          self notify("arrive_node");
          self notify("reached_path_end");
          self notify("goal");
          return;
        }

        continue;
      }

      if(self.current_node != self.node_path[var_5b24559811e24059]["node"]) {
        self.current_node = self.node_path[var_5b24559811e24059]["node"];
        set_animsets(self.current_node fakeactor_node_get_cover_list());
        fakeactor_check_node(self.current_node);
      }
    }

    desired_pos = self.node_path[var_5b24559811e24059]["to_next_node"] * var_b5b08eaf3fc975bb;
    desired_pos += self.node_path[var_5b24559811e24059]["origin"];
    var_a86ab88612b32cc5 = desired_pos;

    if(!anim_relative) {
      self.look_ahead_point = var_a86ab88612b32cc5;
    }

    new_angles = vectortoangles(var_a86ab88612b32cc5 - self.origin);
    childthread fakeactor_rotate_to(new_angles, self.loop_time);

    if(anim_relative) {
      var_bdef066b5fcbae91 = run_speed * self.loop_time * move_scale;
      move_vec = vectorNormalize(var_a86ab88612b32cc5 - self.origin);
      desired_pos = move_vec * var_bdef066b5fcbae91;
      desired_pos += self.origin;
      self moveTo(desired_pos, self.loop_time);
    }

    if(getDvar(@ "debug_fakeactor") == "<dev string:x1c>") {
      sphere(var_a86ab88612b32cc5, 5, (0, 1, 1), 1, int(self.loop_time * 30) - 1);
      print3d(var_a86ab88612b32cc5, var_b5b08eaf3fc975bb + "<dev string:x82>" + self.node_path[var_5b24559811e24059]["<dev string:x84>"] + "<dev string:x89>" + var_5b24559811e24059 + "<dev string:xa3>", (1, 1, 1), 1, 0.5, int(self.loop_time * 30) - 1);
    }

    wait self.loop_time;
  }

  self.node_path = undefined;
  set_wants_to_move(0);
  self notify("arrive_node");
  self notify("reached_path_end");
  self notify("goal");
}

function fakeactor_rotate_to(target_angles, time) {
  start_forward = anglesToForward(self.angles);
  target_forward = anglesToForward(target_angles);
  progress = 0;
  inv_time = 1 / time;

  while(true) {
    t = progress * inv_time;
    new_forward = vectorlerp(start_forward, target_forward, t);
    self.angles = vectortoangles(new_forward);
    progress += 0.05;
    wait 0.05;

    if(progress >= time) {
      break;
    }
  }

  self.angles = target_angles;
}

function fakeactor_check_delete() {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.script_noteworthy)) {
    return;
  }

  switch (self.script_noteworthy) {
    case #"hash_2c3612c489888b90":
      if(isDefined(self.magic_bullet_shield)) {
        stop_magic_bullet_shield();
      }

      self delete();
      break;
    case #"hash_1b3e853d9bd4735f":
      self kill();
      break;
  }
}

function fakeactor_check_node(node) {
  if(isDefined(node.script_noteworthy)) {
    switch (node.script_noteworthy) {
      case #"hash_2c3612c489888b90":
        if(isDefined(self.magic_bullet_shield)) {
          stop_magic_bullet_shield();
        }

        self delete();
        break;
      case #"hash_1b3e853d9bd4735f":
        self kill();
        break;
    }
  }

  if(isDefined(node.script_flag_set)) {
    flag_set(node.script_flag_set);
  }

  if(isDefined(node.script_flag_clear)) {
    flag_clear(node.script_flag_clear);
  }

  if(isDefined(node.script_ent_flag_set)) {
    ent_flag_set(node.script_ent_flag_set);
  }

  if(isDefined(self.script_ent_flag_clear)) {
    ent_flag_set(node.script_ent_flag_clear);
  }

  if(isDefined(node.script_demeanor)) {
    if(node.script_demeanor == "frantic") {
      set_frantic(1);
    }
  }

  if(isDefined(node.script_do_arrival)) {
    set_do_arrivals(node.script_do_arrival);
  }

  if(isDefined(node.script_do_exits)) {
    set_do_exits(node.script_do_exits);
  }

  if(isDefined(node.script_use_real_fire)) {
    set_real_fire(node.script_use_real_fire);
  }

  if(isDefined(node.script_use_pain)) {
    set_use_pain(node.script_use_pain);
  }
}

function lock_to_ground(run_speed) {
  self endon("death");
  self endon("change_state");
  self endon("cap_start");
  self notify("drone_move_z");
  self endon("drone_move_z");
  var_94228ab58074c00b = 0.05;

  for(;;) {
    if(isDefined(self.look_ahead_point) && run_speed > 0) {
      z_delta = self.look_ahead_point[2] - self.origin[2];
      xy_delta = distance2d(self.look_ahead_point, self.origin);
      time_left = xy_delta / run_speed;

      if(time_left > 0 && z_delta != 0) {
        var_b3f7146efd71904c = abs(z_delta) / time_left;
        var_5679ee98e71167a8 = var_b3f7146efd71904c * var_94228ab58074c00b;

        if(z_delta >= var_b3f7146efd71904c) {
          self.origin = (self.origin[0], self.origin[1], self.origin[2] + var_5679ee98e71167a8);
        } else if(z_delta <= var_b3f7146efd71904c * -1) {
          self.origin = (self.origin[0], self.origin[1], self.origin[2] - var_5679ee98e71167a8);
        }
      }
    }

    wait var_94228ab58074c00b;
  }
}

function set_current_node(target_node) {
  if(isDefined(self.current_node)) {
    self.current_node fakeactor_node_remove_claimed(self);
  }

  self.forced_node_path = undefined;
  self.current_node = target_node;
  set_animsets(self.current_node fakeactor_node_get_cover_list());
}

function teleport_to_node(target_node) {
  set_current_node(target_node);
  self.current_node fakeactor_node_set_claimed(self);
  fakeactor_check_node(self.current_node);
  self dontinterpolate();
  self.origin = self.current_node.origin;
  self.angles = self.current_node fakeactor_node_get_angles(is_frantic());
}

function clear_node_path() {
  if(isDefined(self.node_path)) {
    foreach(object in self.node_path) {
      if(isDefined(object["node"])) {
        object["node"] fakeactor_node_remove_claimed(self);
      }
    }
  }
}

function should_fire() {
  if(self.animset == "exposed") {
    return 0;
  }

  if(isDefined(self.aim_target)) {
    return is_target_in_view();
  }

  return 1;
}

function fire_weapon(fire_anim) {
  self endon("death");
  childthread aim_think();
  wait 0.25;
  var_163082abc33a0c44 = weaponclipsize(self.weapon);
  weapon_fire_time = weaponfiretime(self.weapon);
  var_aed09de616a15798 = weaponburstcount(self.weapon);
  weapon_class = weaponclass(self.weapon);
  weapon_ammo = var_163082abc33a0c44;

  if(weapon_class == "sniper") {
    weapon_ammo = 5;
  } else if(var_aed09de616a15798 > 0) {
    weapon_ammo = var_aed09de616a15798;
  }

  while(weapon_ammo > 0) {
    if(should_fire()) {
      flash_origin = self gettagorigin("tag_flash");
      flash_angles = self gettagangles("tag_flash");
      shoot_dir = anglesToForward(flash_angles);
      end_pos = flash_origin + shoot_dir * 1000;

      if(isDefined(self.aim_target)) {
        trace = ray_trace(flash_origin, end_pos, self);

        if(getDvar(@ "debug_fakeactor") == "<dev string:x1c>") {
          draw_trace(trace, (0, 1, 1), 1, int(weapon_fire_time * 30));
        }

        if(isDefined(trace["entity"]) && trace["entity"] == self.aim_target) {
          accuracy = get_accuracy();

          if(randomfloat(1) > accuracy) {
            target_coll = self.aim_target physics_getcharactercollisioncapsule();
            target_up = anglestoup(self.aim_target.angles);
            up_miss = randomfloatrange(0, target_coll["half_height"] * 2);
            target_right = anglestoright(self.aim_target.angles);
            right_miss = target_coll["radius"] * randomfloatrange(1, 2);

            if(cointoss()) {
              right_miss *= -1;
            }

            var_20d7932a634603fd = self.aim_target.origin + target_up * up_miss + target_right * right_miss;
            shoot_dir = vectorNormalize(var_20d7932a634603fd - flash_origin);
            end_pos = flash_origin + shoot_dir * 1000;
          }
        }
      }

      if(should_real_fire()) {
        magicbullet(self.weapon, flash_origin, end_pos);
      } else {
        fake_bullet(self.weapon, flash_origin, end_pos, self.no_weapon_sound);
      }

      self setanimknobrestart(fire_anim, 1, 0.2, 1);
      delaycall(0.15, &clearanim, fire_anim, 0);
    }

    weapon_ammo--;
    wait max(weapon_fire_time, 0.1);
  }
}

function get_accuracy(debug) {
  self_acc = self.baseaccuracy;
  target_acc = 1;

  if(isDefined(self.aim_target) && isDefined(self.aim_target.attackeraccuracy)) {
    target_acc = self.aim_target.attackeraccuracy;
  }

  dist_to_target = distance(self.origin, self.aim_target.origin);
  weapon_acc = getaccuracyfraction(self.weapon, dist_to_target, isPlayer(self.aim_target));
  pose = "stand";

  if(isPlayer(self.aim_target)) {
    pose = self.aim_target getstance();
  } else if(isai(self.aim_target)) {
    pose = self.aim_target.currentpose;
  }

  stance_acc = 1;

  if(pose == "crouch") {
    stance_acc = 0.75;
  } else if(pose == "prone") {
    stance_acc = 0.5;
  }

  movement_acc = 1;

  if(isPlayer(self.aim_target)) {
    movement = level.player getnormalizedmovement();
    movement_acc = 1 - length(movement) * 0.3;
  } else if(isai(self.aim_target)) {}

  sight_acc = 0.75;
  total_acc = self_acc * target_acc * weapon_acc * stance_acc * movement_acc * sight_acc;

  if(isDefined(debug) && debug) {
    text_scale = 0.5;
    new_line = 11 * text_scale;
    cam_angles = level.player getplayerangles();
    cam_up = anglestoup(cam_angles);
    text_pos = self.origin;
    print3d(text_pos - cam_up * new_line * 0, "<dev string:xa5>" + self_acc, (1, 1, 1), 1, text_scale);
    print3d(text_pos - cam_up * new_line * 1, "<dev string:xb0>" + target_acc, (1, 1, 1), 1, text_scale);
    print3d(text_pos - cam_up * new_line * 2, "<dev string:xbb>" + weapon_acc, (1, 1, 1), 1, text_scale);
    print3d(text_pos - cam_up * new_line * 3, "<dev string:xc6>" + stance_acc, (1, 1, 1), 1, text_scale);
    print3d(text_pos - cam_up * new_line * 4, "<dev string:xd1>" + movement_acc, (1, 1, 1), 1, text_scale);
    print3d(text_pos - cam_up * new_line * 5, "<dev string:xdc>" + sight_acc, (1, 1, 1), 1, text_scale);
    print3d(text_pos - cam_up * new_line * 6, "<dev string:xe7>" + total_acc, (1, 0, 0), 1, text_scale);
  }

  return total_acc;
}

function fake_bullet(weapon, start, end, no_sound) {
  bullettracer(start, end, weapon);
  playFXOnTag(getfx("fakeactor_muzflash"), self, "tag_flash");

  if(!isDefined(no_sound) || !no_sound) {}
}

function get_target_point(ent) {
  if(isPlayer(ent)) {
    if(is_human()) {
      aim_height = 50;
    } else {
      aim_height = 50;
    }

    player_angles = ent getplayerangles();
    target_point = ent getorigin() + anglestoup(player_angles) * aim_height;
    return target_point;
  }

  if(isai(ent)) {
    return ent gettagorigin("j_SpineUpper");
  }

  target_point = ent.origin;

  if(isDefined(self.aim_target_offset)) {
    target_point += self.aim_target_offset;
  }

  return target_point;
}

function aim_think() {
  self endon("end_aim");
  transtime = 0.2;
  var_88dfe311e464ec62 = get_aim_anim("aim_5");

  if(isDefined(var_88dfe311e464ec62)) {
    self setanimknoball(var_88dfe311e464ec62, self.anim_branch["body"], 1, transtime);
  }

  self setanimlimited(get_aim_anim("aim_2"), 1, transtime);
  self setanimlimited(get_aim_anim("aim_4"), 1, transtime);
  self setanimlimited(get_aim_anim("aim_6"), 1, transtime);
  self setanimlimited(get_aim_anim("aim_8"), 1, transtime);
  var_aaf3547fcb39da5d = 10;
  prevyawdelta = 0;
  prevpitchdelta = 0;
  firstframe = 1;

  while(isDefined(self.aim_target)) {
    my_eye = self gettagorigin("tag_flash");
    target_eye = get_target_point(self.aim_target);
    adjusted_aim = worldtolocalcoords(target_eye) - worldtolocalcoords(my_eye);
    shoot_angles = vectortoangles(adjusted_aim);
    pitchdelta = angleclamp180(shoot_angles[0]);
    yawdelta = angleclamp180(shoot_angles[1]);

    if(pitchdelta < self.upaimlimit || pitchdelta > self.downaimlimit || yawdelta < self.rightaimlimit || yawdelta > self.leftaimlimit) {
      set_target_in_view(0);
      pitchdelta = 0;
      yawdelta = 0;
    } else {
      set_target_in_view(1);
    }

    if(getDvar(@ "debug_fakeactor") == "<dev string:x1c>") {
      base_angles = self gettagangles("<dev string:xf2>");
      draw_angles(base_angles, self gettagorigin("<dev string:xf2>"));
      line(my_eye, target_eye, (1, 0, 1));
    }

    if(!firstframe) {
      yawdeltachange = yawdelta - prevyawdelta;

      if(abs(yawdeltachange) > var_aaf3547fcb39da5d) {
        yawdelta = prevyawdelta + clamp(yawdeltachange, -1 * var_aaf3547fcb39da5d, var_aaf3547fcb39da5d);
      }

      pitchdeltachange = pitchdelta - prevpitchdelta;

      if(abs(pitchdeltachange) > var_aaf3547fcb39da5d) {
        pitchdelta = prevpitchdelta + clamp(pitchdeltachange, -1 * var_aaf3547fcb39da5d, var_aaf3547fcb39da5d);
      }
    }

    pitchdelta = clamp(pitchdelta, self.upaimlimit, self.downaimlimit);
    yawdelta = clamp(yawdelta, self.rightaimlimit, self.leftaimlimit);
    firstframe = 0;
    prevyawdelta = yawdelta;
    prevpitchdelta = pitchdelta;
    aim_weights(self.anim_branch["aim_2"], self.anim_branch["aim_4"], self.anim_branch["aim_6"], self.anim_branch["aim_8"], pitchdelta, yawdelta);
    wait 0.05;
  }
}

function get_animation_from_alias(archetype, statename, alias, frantic) {
  assertex(isDefined(archetype), "Archetype is not defined.");
  aliasdata = archetypegetalias(archetype, statename, alias, frantic);

  if(isDefined(aliasdata)) {
    if(isarray(aliasdata.anims)) {
      if(isDefined(aliasdata.weights)) {
        totalweights = 0;

        foreach(weight in aliasdata.weights) {
          totalweights += weight;
        }

        assertex(aliasdata.anims.size == aliasdata.weights.size, "Array size mismatch between aliases and animweights for archetype " + archetype + " state " + statename + " alias " + alias);
        randnum = randomfloat(totalweights);
        accum = 0;

        for(ianim = 0; ianim < aliasdata.anims.size; ianim++) {
          accum += aliasdata.weights[ianim];

          if(accum > randnum) {
            return aliasdata.anims[ianim];
          }
        }

        assertmsg("Anim weights not properly normalized for " + archetype + " | " + statename + " | " + alias);
      } else {
        randnum = randomint(aliasdata.anims.size);
        return aliasdata.anims[randnum];
      }
    } else {
      return aliasdata.anims;
    }

    return;
  }

  assertmsg("get_animation_from_alias was unable to find alias " + alias + " in state " + statename + " for archetype " + archetype);
}

function get_animation(statename, alias) {
  animation = get_animation_from_alias(self.animationarchetype, statename, alias, is_frantic());

  if(isarray(animation)) {
    animation = random(animation);
  }

  self.last_anim = statename + "<dev string:xfd>" + alias;

  return animation;
}

function get_idle_anim() {
  if(isDefined(self.idle_anim_override)) {
    return self.idle_anim_override;
  }

  if(self.unittype != "civilian") {
    if(cointoss()) {
      if(self.animset == "exposed") {
        return get_animation("noncombat_stand_idle", "noncombat_stand_idle");
      } else {
        return get_animation(self.animset, "hide_loop");
      }
    } else {
      switch (self.animset) {
        case #"hash_175771022bc5e75d":
        case #"hash_4ddb655e251e06c8":
        case #"hash_c475427a998ee26c":
          return get_animation(self.animset, "hide_loop");
        case #"hash_d44cb989edc40ab3":
          return get_animation("noncombat_stand_idle", "noncombat_stand_idle_twitch");
        case #"hash_9d76c99eddd14433":
        case #"hash_e7aface284179b3b":
        case #"hash_f1676baca0ae608b":
          return get_animation(self.animset + "_peek", "peek");
      }
    }

    return;
  }

  switch (self.animset) {
    case #"hash_d44cb989edc40ab3":
      return get_animation("idle", "default");
  }
}

function get_movement_anim() {
  if(isDefined(self.run_anim_override)) {
    return self.run_anim_override;
  }

  alias = "default";

  if(isDefined(self.run_anim_alias)) {
    alias = self.run_anim_alias;
  }

  return get_animation("stand_run_loop", alias);
}

function get_turn_anim(viewerangles, viewerorigin, targetorigin) {
  anglestopoint = vectortoangles(targetorigin - viewerorigin);
  angle = viewerangles[1] - anglestopoint[1];
  angle += 360;
  angle = int(angle) % 360;
  direction = "";

  if(angle > 315 || angle < 45) {
    return undefined;
  } else if(angle >= 150 && angle <= 210) {
    direction = "2";
  } else if(angle < 90) {
    direction = "9";
  } else if(angle > 270) {
    direction = "7";
  } else if(angle < 135) {
    direction = "6";
  } else if(angle > 225) {
    direction = "4";
  } else if(angle < 150) {
    direction = "3";
  } else if(angle > 210) {
    direction = "1";
  }

  return get_animation("run_turn", "left" + direction);
}

function get_shoot_anim() {
  switch (self.animset) {
    case #"hash_9d76c99eddd14433":
    case #"hash_c475427a998ee26c":
    case #"hash_e7aface284179b3b":
      return get_animation("crouch_shoot_full", "fire");
    case #"hash_175771022bc5e75d":
    case #"hash_4ddb655e251e06c8":
    case #"hash_f1676baca0ae608b":
      return get_animation("shoot_full", "fire");
    case #"hash_d44cb989edc40ab3":
      return get_animation("shoot_full", "fire");
  }
}

function get_aim_anim(aim) {
  switch (self.animset) {
    case #"hash_9d76c99eddd14433":
      return get_animation("cover_crouch_aim", "rifle_" + aim);
    case #"hash_e7aface284179b3b":
      if(aim == "aim_5") {
        return undefined;
      }

      return get_animation("cover_crouch_exposed_left", "rifle_" + aim);
    case #"hash_c475427a998ee26c":
      if(aim == "aim_5") {
        return undefined;
      }

      return get_animation("cover_crouch_exposed_right", "rifle_" + aim);
    case #"hash_f1676baca0ae608b":
      return get_animation("cover_stand_exposed", "rifle_" + aim);
    case #"hash_4ddb655e251e06c8":
      if(aim == "aim_5") {
        return undefined;
      }

      return get_animation("cover_left_exposed_B", "rifle_" + aim);
    case #"hash_175771022bc5e75d":
      if(aim == "aim_5") {
        return undefined;
      }

      return get_animation("cover_right_exposed_B", "rifle_" + aim);
    case #"hash_d44cb989edc40ab3":
      return get_animation("exposed_idle", "rifle_" + aim);
  }
}

function get_hide_to_aim_anim() {
  switch (self.animset) {
    case #"hash_9d76c99eddd14433":
      return get_animation("cover_crouch_hide_to_aim", "hide_to_aim");
    case #"hash_f1676baca0ae608b":
      return get_animation("cover_stand_hide_to_exposed", "hide_to_exposed");
    case #"hash_4ddb655e251e06c8":
      return get_animation("cover_left_hide_to_B", "hide_to_exposed");
    case #"hash_175771022bc5e75d":
      return get_animation("cover_right_hide_to_B", "hide_to_exposed");
    case #"hash_e7aface284179b3b":
      return get_animation("cover_left_crouch_hide_to_B", "hide_to_B");
    case #"hash_c475427a998ee26c":
      return get_animation("cover_right_crouch_hide_to_B", "hide_to_B");
  }

  return undefined;
}

function get_aim_to_hide_anim() {
  switch (self.animset) {
    case #"hash_9d76c99eddd14433":
      return get_animation("cover_crouch_aim_to_hide", "aim_to_hide");
    case #"hash_f1676baca0ae608b":
      return get_animation("cover_stand_exposed_to_hide", "exposed_to_hide");
    case #"hash_4ddb655e251e06c8":
      return get_animation("cover_left_B_to_hide", "exposed_to_hide");
    case #"hash_175771022bc5e75d":
      return get_animation("cover_right_B_to_hide", "exposed_to_hide");
    case #"hash_e7aface284179b3b":
      return get_animation("cover_left_crouch_B_to_hide", "B_to_hide");
    case #"hash_c475427a998ee26c":
      return get_animation("cover_right_crouch_B_to_hide", "B_to_hide");
  }

  return undefined;
}

function get_arrival_anim(arrival_node, start_node, animset) {
  if(!isDefined(animset)) {
    animset = self.animset;
  }

  if(!isDefined(start_node)) {
    start_node = self;
  }

  state_name = animset + "_arrival";
  dir_val = get_direction_value(arrival_node.angles, arrival_node.origin, start_node.origin);

  switch (animset) {
    case #"hash_9d76c99eddd14433":
      if(dir_val == "9") {
        dir_val = "6";
      } else if(dir_val == "7" || dir_val == "8") {
        dir_val = "4";
      }

      break;
    case #"hash_f1676baca0ae608b":
      if(dir_val == "9") {
        dir_val = "6";
      } else if(dir_val == "7" || dir_val == "8") {
        dir_val = "4";
      }

      break;
    case #"hash_4ddb655e251e06c8":
      if(dir_val == "9") {
        dir_val = "8";
      }

      break;
    case #"hash_175771022bc5e75d":
      if(dir_val == "7") {
        dir_val = "8";
      }

      break;
    case #"hash_e7aface284179b3b":
      if(dir_val == "9") {
        dir_val = "8";
      }

      break;
    case #"hash_c475427a998ee26c":
      if(dir_val == "7") {
        dir_val = "8";
      }

      break;
    case #"hash_d44cb989edc40ab3":
      break;
    default:
      return undefined;
  }

  if(is_human()) {
    alias = "left" + dir_val;
  } else {
    alias = dir_val;
  }

  return get_animation(state_name, alias);
}

function get_exit_anim(target_pos, start_pos, start_angles, animset) {
  if(!isDefined(start_pos)) {
    start_pos = self.origin;
  }

  if(!isDefined(start_angles)) {
    start_angles = self.angles;
  }

  if(!isDefined(animset)) {
    animset = self.animset;
  }

  state_name = animset + "_exit";
  alias = get_direction_value(start_angles, start_pos, target_pos);

  switch (animset) {
    case #"hash_9d76c99eddd14433":
      if(alias == "9") {
        alias = "6";
      } else if(alias == "7" || alias == "8") {
        alias = "4";
      }

      return get_animation(state_name, alias);
    case #"hash_f1676baca0ae608b":
      if(alias == "9") {
        alias = "6";
      } else if(alias == "7" || alias == "8") {
        alias = "4";
      }

      return get_animation(state_name, alias);
    case #"hash_4ddb655e251e06c8":
      if(alias == "9") {
        alias = "8";
      }

      return get_animation(state_name, alias);
    case #"hash_175771022bc5e75d":
      if(alias == "7") {
        alias = "8";
      }

      return get_animation(state_name, alias);
    case #"hash_e7aface284179b3b":
      if(alias == "9") {
        alias = "8";
      }

      return get_animation(state_name, alias);
    case #"hash_c475427a998ee26c":
      if(alias == "7") {
        alias = "8";
      }

      return get_animation(state_name, alias);
    case #"hash_d44cb989edc40ab3":
      return get_animation(state_name, alias);
    default:
      return undefined;
  }
}

function get_reload_anim() {
  if(self.animset == "exposed") {
    return get_animation("Exposed_Reload", "rifle");
  }

  archetype = self.animset + "_reload";
  return get_animation(archetype, "reload");
}

function get_stance_change_anim() {
  switch (self.animset) {
    case #"hash_9d76c99eddd14433":
      return get_animation("exposed_stand_to_crouch", "stand_to_crouch");
    case #"hash_f1676baca0ae608b":
      return get_animation("exposed_crouch_to_stand", "crouch_to_stand");
    case #"hash_4ddb655e251e06c8":
      return get_animation("cover_left_crouch_to_stand", "crouch_to_stand");
    case #"hash_e7aface284179b3b":
      return get_animation("cover_left_stand_to_crouch", "stand_to_crouch");
    case #"hash_175771022bc5e75d":
      return get_animation("cover_right_crouch_to_stand", "crouch_to_stand");
    case #"hash_c475427a998ee26c":
      return get_animation("cover_right_stand_to_crouch", "stand_to_crouch");
  }

  return undefined;
}

function get_pain_anim() {
  if(is_moving()) {
    anim_type = ter_op(cointoss(), "short", "medium");
    return get_animation("pain_run_default", anim_type);
  }

  switch (self.animset) {
    case #"hash_9d76c99eddd14433":
      return get_animation("pain_cover_crouch_anim", "torso_md_f");
    case #"hash_f1676baca0ae608b":
      return get_animation("pain_cover_stand_anim", "torso_md_f");
    case #"hash_4ddb655e251e06c8":
      return get_animation("pain_cover_left_default", "stand");
    case #"hash_175771022bc5e75d":
      return get_animation("pain_cover_right_default", "stand");
    case #"hash_e7aface284179b3b":
      return get_animation("pain_cover_left_default", "crouch");
    case #"hash_c475427a998ee26c":
      return get_animation("pain_cover_right_default", "crouch");
    default:
      return get_animation("pain_exp_stand", "torso_md_f");
  }
}

function get_death_anim() {
  if(self.unittype != "civilian") {
    if(isDefined(self.last_damage_type) && self.last_damage_type == "MOD_EXPLOSIVE") {
      random_anim = random(["explosive_f", "explosive_l", "explosive_r"]);

      if(is_moving()) {
        return get_animation("death_moving_explosive", random_anim);
      } else {
        return get_animation("death_explosive", random_anim);
      }
    } else if(is_moving()) {
      if(cointoss()) {
        random_part = random(["head", "lowerbody_l", "lowerbody_r", "midbody"]);
        random_severity = "_md_";
        random_dir = random(["2", "4", "6", "8"]);
        random_anim = random_part + random_severity + random_dir;
        return get_animation("death_exp_stand", random_anim);
      } else {
        random_dir = random(["running_forward_2", "running_forward_4", "running_forward_6", "running_forward_8"]);
        return get_animation("death_moving_default", random_dir);
      }
    } else {
      switch (self.animset) {
        case #"hash_9d76c99eddd14433":
          return get_animation("death_cover_default", "crouch_default");
        case #"hash_f1676baca0ae608b":
          return get_animation("death_cover_default", "stand");
        case #"hash_4ddb655e251e06c8":
          return get_animation("death_cover_default", "left_stand");
        case #"hash_175771022bc5e75d":
          return get_animation("death_cover_default", "right_stand");
        case #"hash_e7aface284179b3b":
          return get_animation("death_cover_default", "left_crouch");
        case #"hash_c475427a998ee26c":
          return get_animation("death_cover_default", "right_crouch_default");
        default:
          random_part = random(["head", "lowerbody", "midbody"]);

          if(random_part == "lowerbody") {
            random_severity = ter_op(cointoss(), "_r_md_", "_l_md_");
          } else {
            random_severity = "_md_";
          }

          random_dir = random(["2", "4", "6", "8"]);
          random_anim = random_part + random_severity + random_dir;
          return get_animation("death_exp_stand", random_anim);
      }
    }

    return;
  }

  return get_animation("death_generic", "civ_death_generic");
}

function get_traverse_anim(animscript) {
  if(issubstr(animscript, "jumpdown")) {
    return get_animation(animscript, "jumpdown");
  }

  if(issubstr(animscript, "jumpover")) {
    return get_animation(animscript, "jumpover");
  }

  if(issubstr(animscript, "jumpup")) {
    return get_animation(animscript, "jumpup");
  }

  return get_animation(animscript, animscript);
}

function death_think() {
  self notify("death_think");
  self endon("death_think");
  self endon("entitydeleted");
  damage_think();

  if(!isDefined(self)) {
    return;
  }

  clear_node_path();

  if(isDefined(self.deathfunction)) {
    result = self[[self.deathfunction]]();

    if(!isDefined(result) || result) {
      return;
    }
  }

  death_anim = self.deathanim;

  if(!isDefined(death_anim)) {
    death_anim = get_death_anim();
  }

  self notify("death");
  cleanup_state_ents();
  drop_weapon();
  scripts\anim\face::saygenericdialogue("death");

  if(isDefined(self.noragdoll) && self.noragdoll) {
    if(!isDefined(self.skipdeathanim) || !self.skipdeathanim) {
      play_scripted_anim(death_anim, "deathplant");
    }
  }

  if(!(isDefined(self.skipdeathanim) && self.skipdeathanim)) {
    play_scripted_anim(death_anim, "deathplant");
  }

  self freeentitysentient();
  self startragdoll();
  self notsolid();

  if(isDefined(self) && isDefined(self.nocorpsedelete)) {
    return;
  }

  wait 10;

  while(isDefined(self)) {
    self delete();
    wait 5;
  }
}

function drop_weapon(limit) {
  if(!isDefined(limit)) {
    limit = 1;
  }

  if(istrue(self.nodrop)) {
    return;
  }

  if(isDefined(self.weapon)) {
    weapon = self.weapon;
    weapon_model = getweaponmodel(weapon);
  }

  if(isDefined(self.weapon_object) && (!isDefined(weapon_model) || weapon_model == "")) {
    weapon = self.weapon_object;
    weapon_model = getweaponmodel(weapon);
  }

  if(isDefined(weapon_model) && weapon_model != "") {
    gun_remove();

    if(!isDefined(self.nodrop)) {
      attachments = getweapondefaultattachments(weapon.basename);
      attachmentstring = "";

      foreach(attachment in attachments) {
        attachmentstring = attachmentstring + "+" + attachment;
      }

      gun = spawn("weapon_" + getcompleteweaponname(weapon) + attachmentstring, self gettagorigin("tag_weapon_right"));
      gun.angles = self gettagangles("tag_weapon_right");

      if(istrue(limit)) {
        limit_dropped_weapons(gun);
      }
    }
  }
}

function limit_dropped_weapons(newweapon) {
  if(!isDefined(level.fakeactor_droppedweapons)) {
    level.fakeactor_droppedweapons = [];
  }

  weaponarray = array_removeundefined(level.fakeactor_droppedweapons);
  num = weaponarray.size;

  if(weaponarray.size >= 4) {
    weaponarray = sortbydistance(weaponarray, level.player.origin);
    num -= 1;
    weaponarray[num] delete();
  }

  weaponarray[num] = newweapon;
  level.fakeactor_droppedweapons = weaponarray;
}

function damage_think() {
  self endon("entitydeleted");

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, point, type);
    self.last_damage_type = type;
    self.lastattacker = attacker;

    if(isDefined(attacker) && isPlayer(attacker)) {
      attacker setclientomnvar("damage_feedback_notify", gettime());
    }

    if(isDefined(self.damageshield) && self.damageshield) {
      self.health = 100000;
      continue;
    }

    if(self.health <= 0) {
      break;
    }

    scripts\anim\face::saygenericdialogue("pain");

    if(!was_recent_pain() && should_do_pain_anim()) {
      thread do_pain();
    }
  }
}

function do_pain() {
  self notify("change_state");
  self notify("stop_damage_pain_anim");
  self endon("stop_damage_pain_anim");
  self endon("death");
  set_recent_pain(1);
  delaythread(1.5, &set_recent_pain, 0);
  clear_node_path();
  play_scripted_anim(get_pain_anim());
  self.current_state = "";
  self.forced_node_path = fakeactor_node_get_path(self.current_node, self.origin, is_frantic(), 1);
}

function debug_draw() {
  self endon("<dev string:xff>");

  while(true) {
    if(getDvar(@ "debug_fakeactor") == "<dev string:x1c>") {
      color = (1, 0, 0);

      if(should_real_fire()) {
        color = (0, 1, 0);
      }

      draw_character_capsule(color, 1);
      draw_ent_axis();
      text_scale = 0.5;
      new_line = 11 * text_scale;
      cam_angles = level.player getplayerangles();
      cam_up = anglestoup(cam_angles);
      text_pos = self.origin;

      if(getDvar(@ "hash_ab259d9b09bad834") == "<dev string:x1c>") {
        if(isDefined(self.aim_target)) {
          get_accuracy(1);
        }
      } else {
        if(isDefined(self.current_state)) {
          print3d(text_pos - cam_up * new_line * -1, self.current_state, (1, 1, 1), 1, text_scale);
        }

        if(isDefined(self.current_node)) {
          draw_node(self.current_node.origin, self.current_node.angles, (1, 1, 0), 48);
        }

        if(isDefined(self.animset)) {
          text = self.animset;

          if(isDefined(self.last_anim)) {
            text += "<dev string:x105>" + self.last_anim;
          }

          print3d(text_pos - cam_up * new_line * 0, text, (1, 1, 1), 1, text_scale);
        }

        if(does_want_to_move()) {
          print3d(text_pos - cam_up * new_line * 1, "<dev string:x108>", (0, 1, 0), 1, text_scale);
        } else {
          print3d(text_pos - cam_up * new_line * 1, "<dev string:x119>", (1, 0, 0), 1, text_scale);
        }

        if(should_do_arrivals()) {
          print3d(text_pos - cam_up * new_line * 3, "<dev string:x12a>", (0, 1, 0), 1, text_scale);
        } else {
          print3d(text_pos - cam_up * new_line * 3, "<dev string:x139>", (1, 0, 0), 1, text_scale);
        }

        if(should_do_exits()) {
          print3d(text_pos - cam_up * new_line * 4, "<dev string:x148>", (0, 1, 0), 1, text_scale);
        } else {
          print3d(text_pos - cam_up * new_line * 4, "<dev string:x154>", (1, 0, 0), 1, text_scale);
        }

        if(should_real_fire()) {
          print3d(text_pos - cam_up * new_line * 5, "<dev string:x160>", (0, 1, 0), 1, text_scale);
        } else {
          print3d(text_pos - cam_up * new_line * 5, "<dev string:x16d>", (1, 0, 0), 1, text_scale);
        }
      }
    }

    wait 0.05;
  }
}

function array_handling(fakeactor) {
  team = fakeactor.team;
  structarray_add(level.fakeactors[team], fakeactor);
  fakeactor waittill("death");
  fakeactor cleanup_state_ents();

  if(isDefined(fakeactor) && isDefined(fakeactor.struct_array_index)) {
    structarray_remove_index(level.fakeactors[team], fakeactor.struct_array_index);
    return;
  }

  structarray_remove_undefined(level.fakeactors[team]);
}

function play_running_anim_internal(animation, rate) {
  if(!isDefined(rate)) {
    rate = randomfloatrange(0.85, 1.2);
  }

  if(isDefined(self.fakeactor_loop_override)) {
    self[[self.fakeactor_loop_override]](animation, rate);
    return;
  }

  self clearanim(self.anim_branch["body"], 0.2);
  self setflaggedanim("fakeactor_anim", animation, 1, 0.2, rate);
}

function play_scripted_anim(script_anim, deathplant, notetrackfunction, flagname, node, var_9e8a16d47a03007a) {
  if(isDefined(self.fakeactor_scripted_override)) {
    self[[self.fakeactor_scripted_override]](script_anim, deathplant);
    return;
  }

  self clearanim(self.anim_branch["body"], 0.2);
  self stopanimScripted();
  mode = "normal";

  if(isDefined(deathplant)) {
    mode = "deathplant";
  }

  org = self.origin;
  ang = self.angles;

  if(isDefined(node)) {
    org = node.origin;
    ang = node.angles;
  } else if(isDefined(self.var_98b372c0f9b463ba)) {
    org = self.var_98b372c0f9b463ba.origin;
    ang = self.var_98b372c0f9b463ba.angles;
  }

  if(!isDefined(var_9e8a16d47a03007a)) {
    var_9e8a16d47a03007a = 0.2;
  }

  self animScripted("fakeactor_anim", org, ang, script_anim, mode);

  if(isDefined(notetrackfunction)) {
    thread scripts\anim\notetracks::donotetracks(flagname, notetrackfunction);
  }

  endmarker = "end";

  if(animhasnotetrack(script_anim, "finish")) {
    endmarker = "finish";
  } else if(animhasnotetrack(script_anim, "stop anim")) {
    endmarker = "stop anim";
  }

  anim_len = getanimlength(script_anim) - var_9e8a16d47a03007a;

  if(var_9e8a16d47a03007a > 0 && anim_len > 0) {
    waittill_match_or_timeout("fakeactor_anim", endmarker, anim_len);
    return;
  }

  self waittillmatch("fakeactor_anim", endmarker);
}

function get_anim_data(this_anim) {
  anim_struct = spawnStruct();
  anim_struct.anim_time = getanimlength(this_anim);
  anim_delta = getmovedelta(this_anim, 0, 1);
  anim_dist = length(anim_delta);

  if(anim_struct.anim_time > 0 && anim_dist > 0) {
    anim_struct.run_speed = anim_dist / anim_struct.anim_time;
    anim_struct.anim_relative = 0;
  } else {
    anim_struct.run_speed = 170;
    anim_struct.anim_relative = 1;
  }

  return anim_struct;
}

function set_aim_target(aim_target, offset) {
  self.aim_target = aim_target;
  self.aim_target_offset = offset;
}

function get_aim_target() {
  return self.aim_target;
}

function watch_aim_target_think() {
  self endon("death");

  while(true) {
    if(isai(self.aim_target) && !isalive(self.aim_target)) {
      set_aim_target(undefined);
    }

    wait 0.05;
  }
}

function is_human() {
  return self.unittype == "C6i" || self.unittype == "soldier" || self.unittype == "civilian" || self.unittype == "juggernaut" || self.unittype == "suicidebomber";
}

function setup_animation() {
  assign_animtree_based_on_unittype();

  switch (self.unittype) {
    case #"hash_44aaeb0edd152195":
    case #"hash_e87767df2e5c3a68":
      setup_generic_human();
      break;
    default:
      assertmsg("The AI type you tried (" + self.unittype + ") to turn into a fakeactor is not currently supported!");
      break;
  }
}

#using_animtree("generic_human");

function setup_generic_human() {
  self.anim_branch["root"] = % root;
  self.anim_branch["body"] = % body;
  self.anim_branch["aim_2"] = % aim_2;
  self.anim_branch["aim_4"] = % aim_4;
  self.anim_branch["aim_6"] = % aim_6;
  self.anim_branch["aim_8"] = % aim_8;
}

function aim_weights(aim_2, aim_4, aim_6, aim_8, pitchdelta, yawdelta) {
  var_8af3957b3d71e65a = 0.1;
  anim_weight = 1;

  if(yawdelta < 0) {
    weight = yawdelta / self.rightaimlimit * anim_weight;
    self setanimlimited(aim_4, 0, var_8af3957b3d71e65a, 1, 1);
    self setanimlimited(aim_6, weight, var_8af3957b3d71e65a, 1, 1);
  } else if(yawdelta > 0) {
    weight = yawdelta / self.leftaimlimit * anim_weight;
    self setanimlimited(aim_4, weight, var_8af3957b3d71e65a, 1, 1);
    self setanimlimited(aim_6, 0, var_8af3957b3d71e65a, 1, 1);
  }

  if(pitchdelta < 0) {
    weight = pitchdelta / self.upaimlimit * anim_weight;
    self setanimlimited(aim_2, 0, var_8af3957b3d71e65a, 1, 1);
    self setanimlimited(aim_8, weight, var_8af3957b3d71e65a, 1, 1);
    return;
  }

  if(pitchdelta > 0) {
    weight = pitchdelta / self.downaimlimit * anim_weight;
    self setanimlimited(aim_2, weight, var_8af3957b3d71e65a, 1, 1);
    self setanimlimited(aim_8, 0, var_8af3957b3d71e65a, 1, 1);
  }
}

function set_animsets(animsets) {
  self.animsets = animsets;
  pick_random_animset();
}

function pick_random_animset() {
  random_cover = randomint(self.animsets.size);
  self.animset = self.animsets[random_cover];
}

function set_run_anim_override(run_anim) {
  self.run_anim_override = run_anim;
}

function clear_run_anim_override() {
  self.run_anim_override = undefined;
}

function set_idle_anim_override(idle_anim) {
  self.idle_anim_override = idle_anim;
}

function clear_idle_anim_override() {
  self.idle_anim_override = undefined;
}

function is_idle() {
  return self.current_state == "idle";
}

function is_moving() {
  return isDefined(self.current_state) && self.current_state == "move";
}

function is_controlled() {
  return self.flags & 256 || istrue(self.scriptmodelcap);
}

function set_controlled(controlled) {
  if(controlled) {
    self.flags |= 256;
    return;
  }

  self.flags &= -257;
}

function take_control() {
  self notify("change_state");
  self.prev_node = self.current_node;
  clear_node_path();
  self.node_path = undefined;
  set_controlled(1);
}

function release_control(next_node) {
  set_controlled(0);
  move_to_node = undefined;

  if(isDefined(next_node)) {
    move_to_node = next_node;
  } else if(isDefined(self.prev_node)) {
    move_to_node = self.prev_node;
    self.prev_node = undefined;
  } else if(isDefined(self.target)) {
    fakeactor_target = getStructArray(self.target, "targetname");
    fakeactor_target = random(fakeactor_target);

    if(isDefined(fakeactor_target) && fakeactor_target is_fakeactor_node()) {
      move_to_node = fakeactor_target;
    }
  }

  if(isDefined(move_to_node)) {
    set_current_node(move_to_node);
    set_wants_to_move(1);
  }

  self.current_state = undefined;
}

function set_do_arrivals(do_arrivals) {
  if(do_arrivals) {
    self.flags |= 8;
    return;
  }

  self.flags &= -9;
}

function should_do_arrivals() {
  return self.flags & 8;
}

function set_do_exits(do_exits) {
  if(do_exits) {
    self.flags |= 16;
    return;
  }

  self.flags &= -17;
}

function should_do_exits() {
  if(isDefined(self.previous_state)) {
    if(self.previous_state == "traverse" || self.previous_state == "turn") {
      return 0;
    }
  }

  return self.flags & 16;
}

function set_wants_to_move(wants_to_move) {
  if(wants_to_move) {
    self.flags |= 2;
    return;
  }

  self.flags &= -3;
}

function does_want_to_move() {
  return self.flags & 2;
}

function set_target_in_view(in_view) {
  if(in_view) {
    self.flags |= 1;
    return;
  }

  self.flags &= -2;
}

function is_target_in_view() {
  return self.flags & 1;
}

function set_real_fire(real_fire) {
  if(real_fire) {
    self.flags |= 32;
    return;
  }

  self.flags &= -33;
}

function should_real_fire() {
  return self.flags & 32;
}

function set_ignore_claimed(ignore) {
  if(ignore) {
    self.flags |= 64;
    return;
  }

  self.flags &= -65;
}

function is_ignore_claimed() {
  return self.flags & 64;
}

function obstacle_in_way(in_way) {
  if(in_way) {
    self.flags |= 128;
    return;
  }

  self.flags &= -129;
}

function is_obstacle_in_way() {
  return self.flags & 128;
}

function should_do_pain_anim() {
  return self.flags & 512;
}

function set_use_pain(use_pain) {
  if(use_pain) {
    self.flags |= 512;
    return;
  }

  self.flags &= -513;
}

function was_recent_pain() {
  return self.flags & 2048;
}

function set_recent_pain(recent_pain) {
  if(recent_pain) {
    self.flags |= 2048;
    return;
  }

  self.flags &= -2049;
}

function is_frantic() {
  return self.flags & 1024;
}

function set_frantic(frantic) {
  if(frantic) {
    self.flags |= 1024;
    return;
  }

  self.flags &= -1025;
}

function function_2fdfcaea9fdf106a() {
  return isDefined(self.flags) && (self.flags & 4096) != 0;
}

function trigger_fakeactor_move(trigger) {
  if(!isDefined(self.targetname)) {
    return;
  }

  fakeactor = getEnt("target", self.targetname);

  while(true) {
    trigger waittill("trigger", other);
    fakeactor set_wants_to_move(1);
  }
}

function trigger_fakeactor_node_disable(trigger) {
  if(!isDefined(trigger.targetname)) {
    return;
  }

  var_4a0043876b52e6e5 = getStructArray(trigger.targetname, "target");

  if(var_4a0043876b52e6e5.size == 0) {
    return;
  }

  while(true) {
    trigger waittill("trigger", other);

    foreach(struct in var_4a0043876b52e6e5) {
      struct fakeactor_node_set_disabled(1);
    }
  }
}

function trigger_fakeactor_node_enable(trigger) {
  if(!isDefined(trigger.targetname)) {
    return;
  }

  var_4a0043876b52e6e5 = getStructArray(trigger.targetname, "target");

  if(var_4a0043876b52e6e5.size == 0) {
    return;
  }

  while(true) {
    trigger waittill("trigger", other);

    foreach(struct in var_4a0043876b52e6e5) {
      struct fakeactor_node_set_disabled(0);
    }
  }
}

function trigger_fakeactor_node_enablegroup(trigger) {
  if(!isDefined(trigger.script_parameters)) {
    return;
  }

  while(true) {
    trigger waittill("trigger", other);
    fakeactor_node_group_set_disabled(trigger.script_parameters, 0);
  }
}

function trigger_fakeactor_node_disablegroup(trigger) {
  if(!isDefined(trigger.script_parameters)) {
    return;
  }

  while(true) {
    trigger waittill("trigger", other);
    fakeactor_node_group_set_disabled(trigger.script_parameters, 1);
  }
}

function trigger_fakeactor_node_passthrough(trigger) {
  if(!isDefined(trigger.targetname)) {
    return;
  }

  var_4a0043876b52e6e5 = getStructArray(trigger.targetname, "target");

  if(var_4a0043876b52e6e5.size == 0) {
    return;
  }

  while(true) {
    trigger waittill("trigger", other);

    foreach(struct in var_4a0043876b52e6e5) {
      struct fakeactor_node_set_passthrough();
    }
  }
}

function trigger_fakeactor_node_lock(trigger) {
  if(!isDefined(trigger.targetname)) {
    return;
  }

  var_4a0043876b52e6e5 = getStructArray(trigger.targetname, "target");

  if(var_4a0043876b52e6e5.size == 0) {
    return;
  }

  while(true) {
    trigger waittill("trigger", other);

    foreach(struct in var_4a0043876b52e6e5) {
      struct fakeactor_node_set_locked();
    }
  }
}

function is_higher_priority(item, key) {
  return item["priority"] < key["priority"];
}