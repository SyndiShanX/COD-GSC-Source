/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\fakeactor.gsc
***********************************************/

fakeactor_spawner_init() {
  setdvarifuninitialized("debug_fakeactor", 0);
  setdvarifuninitialized("debug_fakeactor_accuracy", 0);
  level._effect["fakeactor_muzflash"] = loadfx("vfx/core/muzflash/ak47_flash_wv");

  if(!isDefined(level.max_fakeactors))
    level.max_fakeactors = [];

  if(!isDefined(level.max_fakeactors["allies"]))
    level.max_fakeactors["allies"] = 9999;

  if(!isDefined(level.max_fakeactors["axis"]))
    level.max_fakeactors["axis"] = 9999;

  if(!isDefined(level.max_fakeactors["team3"]))
    level.max_fakeactors["team3"] = 9999;

  if(!isDefined(level.max_fakeactors["neutral"]))
    level.max_fakeactors["neutral"] = 9999;

  if(!isDefined(level.fakeactors))
    level.fakeactors = [];

  if(!isDefined(level.fakeactors["allies"]))
    level.fakeactors["allies"] = scripts\engine\sp\utility::struct_arrayspawn();

  if(!isDefined(level.fakeactors["axis"]))
    level.fakeactors["axis"] = scripts\engine\sp\utility::struct_arrayspawn();

  if(!isDefined(level.fakeactors["team3"]))
    level.fakeactors["team3"] = scripts\engine\sp\utility::struct_arrayspawn();

  if(!isDefined(level.fakeactors["neutral"]))
    level.fakeactors["neutral"] = scripts\engine\sp\utility::struct_arrayspawn();

  if(!isDefined(level.fa_state_machines)) {
    add_state("default", "anim", ::play_anim_think, ::play_anim_check, 30);
    add_state("default", "move", ::move_think, ::move_check, 10);
    add_state("default", "traverse", ::traverse_think, ::traverse_check, 20);
    add_state("default", "idle", ::idle_think, ::idle_check, 40);
  }

  level.fakeactor_spawn_func = ::fakeactor_init;

  if(!isDefined(anim.fa_nodeyaws)) {
    var_0 = [];
    var_0["Cover Left"] = 0;
    var_0["Cover Right"] = -90;
    var_0["Cover Crouch"] = -90;
    var_0["Cover Stand"] = -90;
    var_0["Cover Stand 3D"] = -90;
    anim.fa_nodeyaws = var_0;
    var_0 = [];
    var_0["Cover Left"] = 180;
    var_0["Cover Left Crouch"] = 0;
    var_0["Cover Right"] = 180;
    var_0["Cover Crouch"] = 180;
    var_0["Cover Stand"] = 180;
    anim.fa_franticnodeyaws = var_0;
  }
}

get_fakeactors(var_0) {
  return level.fakeactors[var_0].array;
}

is_fakeactor() {
  return isDefined(self.script_fakeactor) && self.script_fakeactor;
}

fakeactor_init() {
  if(level.fakeactors[self.team].array.size >= level.max_fakeactors[self.team]) {
    self delete();
    return;
  }

  thread array_handling(self);
  level notify("new_fakeactor");
  self.script_forcespawn = undefined;
  self.flags = 0;
  self.upaimlimit = -45;
  self.downaimlimit = 45;
  self.rightaimlimit = -45;
  self.leftaimlimit = 45;
  self.baseaccuracy = 1;
  self.look_ahead_value = 200;
  self.loop_time = 0.5;
  set_animsets(["exposed"]);

  if(isDefined(self.script_demeanor)) {
    if(self.script_demeanor == "frantic")
      set_frantic(1);

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

  fakeactor_give_soul();
  self hide();
  scripts\engine\utility::delaycall(0.05, ::show);

  if(self.team == "axis" && !isDefined(self.script_ignoreme))
    self enableaimassist();

  self setCanDamage(1);
  self.health = 150;

  if(self.team == "neutral")
    self.team = "allies";

  self makeentitysentient(self.team);
  thread fakeactor_thinks();
}

create_state_machine(var_0) {
  if(!isDefined(level.fa_state_machines))
    level.fa_state_machines = [];

  level.fa_state_machines[var_0] = [];
}

get_state_machine(var_0) {
  return level.fa_state_machines[var_0];
}

add_state(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.fa_state_machines))
    level.fa_state_machines = [];

  if(!isDefined(level.fa_state_machines[var_0]))
    create_state_machine(var_0);

  var_5 = level.fa_state_machines[var_0].size;
  level.fa_state_machines[var_0][var_5] = [];
  level.fa_state_machines[var_0][var_5]["priority"] = var_4;
  level.fa_state_machines[var_0][var_5]["stateName"] = var_1;
  level.fa_state_machines[var_0][var_5]["thinkFunc"] = var_2;
  level.fa_state_machines[var_0][var_5]["changeFunc"] = var_3;
  level.fa_state_machines[var_0] = scripts\engine\utility::array_sort_with_func(level.fa_state_machines[var_0], ::is_higher_priority);
}

remove_state(var_0, var_1) {
  if(!isDefined(level.fa_state_machines[var_0])) {
    return;
  }
  var_2 = [];

  foreach(var_4 in level.fa_state_machines[var_0]) {
    if(var_4["stateName"] != var_1)
      var_2[var_2.size] = var_4;
  }

  level.fa_state_machines[var_0] = var_2;
}

fakeactor_give_soul() {
  setup_animation();

  if(self.team == "allies" && isDefined(self.name)) {
    scripts\sp\names::get_name();
    self setlookattext(self.name, &"");
  } else if(self.team == "axis")
    self setlookattext("enemy", &"");

  if(isDefined(self.script_moveplaybackrate))
    self.moveplaybackrate = self.script_moveplaybackrate;
  else
    self.moveplaybackrate = 1;

  if(!isDefined(self.script_friendly_fire_disable) || !self.script_friendly_fire_disable)
    level thread scripts\sp\friendlyfire::friendly_fire_think(self);

  self startusingheroonlylighting();

  if(isDefined(self.target)) {
    var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");
    var_0 = scripts\engine\utility::random(var_0);

    if(isDefined(var_0) && var_0 scripts\sp\fakeactor_node::is_fakeactor_node())
      set_current_node(var_0);
  }
}

fakeactor_thinks() {
  waittillframeend;
  thread update_state_machine();
  thread move_message_think();
  thread watch_aim_target_think();
  thread make_real_ai_think();
  thread death_think();
}

make_real_ai_think() {
  self endon("death");
  thread real_ai_distance_check();
  self waittill("make_real_ai");
  scripts\common\ai::stop_magic_bullet_shield();
  var_0 = self.weapon;
  var_1 = "";

  if(isDefined(self.current_node) && isDefined(self.current_node.target))
    var_1 = self.current_node.target;

  var_2 = scripts\sp\spawner::spawner_makerealai(self, var_1);
  var_2 scripts\anim\shared.gsc::placeweaponon(var_0, "right");

  if(isDefined(self))
    self delete();
}

watch_for_obstacles_think() {
  self endon("death");
  self endon("goal");
  var_0 = squared(128);

  for(;;) {
    if(distancesquared(level.player getorigin(), self.origin) < var_0)
      obstacle_in_way(1);
    else
      obstacle_in_way(0);

    wait 0.05;
  }
}

real_ai_distance_check() {
  self endon("death");
  self endon("make_real_ai");

  if(!isDefined(self.radius) || self.radius <= 0) {
    return;
  }
  for(;;) {
    if(distancesquared(level.player getEye(), self.origin) < squared(self.radius)) {
      self notify("make_real_ai");
      return;
    }

    wait 0.05;
  }
}

check_node_is_claimed() {
  if(is_ignore_claimed())
    return 0;

  return self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_claimed_by(self);
}

change_state(var_0) {
  self.previous_state = self.current_state;
  self notify("change_state");
  cleanup_state_ents();
  self.current_state = var_0["stateName"];
  self thread[[var_0["thinkFunc"]]]();
}

add_state_ent(var_0) {
  if(!isDefined(self.current_state_ents))
    self.current_state_ents = [];

  self.current_state_ents[self.current_state_ents.size] = var_0;
}

cleanup_state_ents() {
  if(isDefined(self.current_state_ents)) {
    foreach(var_1 in self.current_state_ents) {
      if(isDefined(var_1))
        var_1 delete();
    }
  }
}

update_state_machine() {
  self endon("death");
  self endon("make_real_ai");
  self.previous_state = "";
  var_0 = "default";

  if(isDefined(self.state_machine))
    var_0 = self.state_machine;

  for(;;) {
    wait 0.05;

    if(is_controlled()) {
      continue;
    }
    foreach(var_2 in get_state_machine(var_0)) {
      if(isDefined(self.current_state) && self.current_state == var_2["stateName"]) {
        continue;
      }
      if([[var_2["changeFunc"]]]()) {
        change_state(var_2);
        break;
      }
    }
  }
}

idle_check() {
  if(!isDefined(self.current_state))
    return 1;

  if(self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_claimed_by(self))
    return 1;

  return 0;
}

idle_think() {
  self endon("death");
  self endon("change_state");
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

fight_think() {
  self endon("death");
  self endon("change_state");

  if(!isDefined(self.ignoreall)) {
    if(isDefined(self.current_node)) {
      var_0 = self.current_node scripts\engine\utility::get_linked_ents();
      var_0 = scripts\engine\utility::array_combine(var_0, self.current_node scripts\engine\utility::get_linked_structs());

      if(var_0.size) {
        var_1 = scripts\engine\utility::random(var_0);
        var_2 = (0, 0, 0);

        if(isDefined(var_1.radius)) {
          var_3 = randomfloatrange(var_1.radius * -1, var_1.radius);
          var_4 = randomfloatrange(var_1.radius * -1, var_1.radius);
          var_2 = (var_3, var_4, 0);
        }

        set_aim_target(var_1, var_2);
      }
    }

    var_5 = get_hide_to_aim_anim();
    var_6 = get_aim_to_hide_anim();
    var_7 = self.origin;

    if(isDefined(var_5) && isDefined(var_6))
      play_scripted_anim(var_5);

    self notify("start_aim");
    fire_weapon(get_shoot_anim());
    self notify("end_aim");

    if(isDefined(var_5) && isDefined(var_6))
      play_scripted_anim(var_6);

    if(should_fire()) {
      var_8 = get_reload_anim();

      if(isDefined(var_8))
        play_scripted_anim(var_8);
    }

    if(scripts\engine\utility::cointoss()) {
      var_9 = self.animset;
      pick_random_animset();

      if(self.animset != var_9)
        play_scripted_anim(get_stance_change_anim());
    }
  }

  play_scripted_anim(get_idle_anim());
  set_wants_to_move(1);
  self notify("start_next_fight");
}

civ_think() {
  play_scripted_anim(get_idle_anim());
  self notify("start_next_fight");
}

traverse_check() {
  if(isDefined(self.current_node) && self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_claimed_by(self) && self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_traverse())
    return 1;

  return 0;
}

traverse_think() {
  self endon("death");
  set_controlled(1);
  var_0 = do_traverse_anim(self.current_node.traverse_animscript);
  set_controlled(0);
  set_wants_to_move(1);
}

turn_check() {
  if(self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_claimed_by(self) && self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_turn())
    return 1;

  return 0;
}

turn_think() {
  self endon("death");
  set_controlled(1);
  var_0 = self.current_node scripts\sp\fakeactor_node::fakeactor_node_get_next();
  play_scripted_anim(get_turn_anim(self.angles, self.origin, var_0.origin));
  set_controlled(0);
  set_wants_to_move(1);
}

play_anim_check() {
  if(isDefined(self.current_node) && self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_claimed_by(self) && self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_animation()) {
    if(!isDefined(self.current_node.last_actor) || self.current_node.last_actor != self)
      return 1;
  }

  return 0;
}

play_anim_think() {
  self endon("death");
  set_controlled(1);
  self.current_node.anim_node scripts\common\anim::anim_generic_run(self, self.current_node.animation);
  self.current_node.last_actor = self;
  set_controlled(0);
  set_wants_to_move(1);
  self notify("played_anim");
}

do_traverse_anim(var_0) {
  var_1 = get_traverse_anim(var_0);
  play_scripted_anim(var_1, undefined, scripts\anim\traverse\shared.gsc::handletraversenotetracks, "traverseAnim", self.current_node);
}

move_message_think() {
  self endon("death");
  self endon("make_real_ai");

  for(;;) {
    self waittill("move");
    set_wants_to_move(1);
  }
}

move_check() {
  if(isDefined(self.forced_node_path)) {
    self.node_path = self.forced_node_path;
    self.forced_node_path = undefined;
    return 1;
  }

  if(!isDefined(self.current_node))
    return 0;

  var_0 = does_want_to_move();
  var_1 = undefined;

  if(!isDefined(self.current_state) && isDefined(self.current_node))
    var_1 = scripts\sp\fakeactor_node::fakeactor_node_get_path(self.current_node, self.origin, is_frantic(), var_0);

  if(self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_claimed_by(self) && !self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_end_path(var_0)) {
    var_2 = self.current_node scripts\sp\fakeactor_node::fakeactor_node_get_next();
    var_1 = scripts\sp\fakeactor_node::fakeactor_node_get_path(var_2, self.origin, is_frantic(), var_0);
  }

  if(isDefined(var_1)) {
    foreach(var_4 in var_1) {
      if(var_4["dist"] > 0) {
        self.node_path = var_1;
        return 1;
      }
    }
  }

  return 0;
}

play_running_anim() {
  self endon("death");
  self endon("change_state");
  self notify("stop_running_anim");
  self endon("stop_running_anim");
  var_0 = 1;

  if(isDefined(self.run_rate_min) && isDefined(self.run_rate_max))
    var_0 = randomfloatrange(self.run_rate_min, self.run_rate_max);

  for(;;) {
    var_1 = get_movement_anim();
    var_2 = get_anim_data(var_1);
    var_3 = var_2.run_speed;
    var_4 = var_2.anim_relative;
    play_running_anim_internal(var_1, var_0);
    wait(getanimlength(var_1));
  }
}

move_think() {
  self endon("death");
  self endon("change_state");
  self notify("exit_node");
  var_0 = self.origin;
  var_1 = does_want_to_move();

  if(self.node_path.size == 0) {}

  self.current_node scripts\sp\fakeactor_node::fakeactor_node_remove_claimed(self);
  var_2 = get_movement_anim();
  var_3 = get_anim_data(var_2);
  var_4 = var_3.run_speed;
  var_5 = var_3.anim_relative;

  if(!var_5)
    childthread lock_to_ground(var_4);

  var_6 = self.node_path[self.node_path.size - 1];

  if(self.node_path[0]["total_dist"] < 64) {
    thread play_scripted_anim(get_idle_anim());
    var_7 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
    add_state_ent(var_7);
    self linkTo(var_7);
    var_8 = 0.2;
    var_7 moveTo(var_6["origin"], var_8);
    var_7 rotateTo(var_6["angles"], var_8);
    scripts\engine\utility::waittill_notify_or_timeout("death", var_8);
    self unlink();
    var_7 delete();

    if(self.current_node != var_6["node"])
      self.current_node = var_6["node"];

    self.current_node scripts\sp\fakeactor_node::fakeactor_node_set_claimed(self);
    fakeactor_check_node(self.current_node);
    set_wants_to_move(0);
    self notify("arrive_node");
    return;
  }

  var_9 = 0;
  var_10 = undefined;

  if(should_do_exits()) {
    var_11 = 0;

    foreach(var_13 in self.node_path) {
      if(var_11) {
        var_10 = var_13["origin"];
        break;
      }

      if(var_13["dist"] > 0)
        var_11 = 1;
    }

    if(isDefined(var_10)) {
      var_15 = get_exit_anim(var_10);
      play_scripted_anim(var_15);
    }
  }

  var_16 = undefined;
  var_17 = scripts\engine\utility::random(var_6["node"] scripts\sp\fakeactor_node::fakeactor_node_get_cover_list());

  if(should_do_arrivals() && !var_6["node"] scripts\sp\fakeactor_node::fakeactor_node_is_traverse() && !var_6["node"] scripts\sp\fakeactor_node::fakeactor_node_is_turn() && var_6["node"] scripts\sp\fakeactor_node::fakeactor_node_allow_arrivals()) {
    var_18 = self;

    if(isDefined(self.node_path[self.node_path.size - 2]["node"]))
      var_18 = self.node_path[self.node_path.size - 2]["node"];

    var_16 = get_arrival_anim(var_6["node"], var_18, var_17);

    if(isDefined(var_16)) {
      var_19 = getmovedelta(var_16, 0, 1);
      var_20 = getangledelta3d(var_16, 0, 1);
      var_21 = invertangles(var_20);
      var_22 = combineangles(var_6["angles"], var_21);
      var_23 = var_6["origin"] - rotatevector(var_19, var_22);
      var_6["anim_node"] = scripts\engine\utility::spawn_script_origin(var_23, var_22);
      add_state_ent(var_6["anim_node"]);
      var_6["origin"] = var_23;
      var_6["angles"] = var_22;
    }
  }

  thread play_running_anim();
  thread watch_for_obstacles_think();
  self.current_node = self.node_path[var_9 + 1]["node"];
  var_24 = 1;

  if(isDefined(self.move_scale))
    var_24 = self.move_scale;

  for(;;) {
    var_25 = self.node_path[var_9]["to_next_node"];
    var_26 = self.origin - self.node_path[var_9]["origin"];
    var_27 = vectordot(var_25, var_26);

    if(var_9 == self.node_path.size) {
      break;
    }

    var_28 = var_27 + self.look_ahead_value;

    while(var_28 > self.node_path[var_9]["dist"]) {
      var_28 = var_28 - self.node_path[var_9]["dist"];
      var_9++;

      if(var_9 == self.node_path.size) {
        if(self.current_node != var_6["node"])
          self.current_node = var_6["node"];

        var_8 = 0;
        var_29 = (0, 0, 0);
        var_30 = (0, 0, 0);
        var_31 = (0, 0, 0);
        var_32 = var_6["origin"] - self.origin;
        var_29 = vectortoangles(var_32);
        var_33 = length(var_32);
        var_8 = var_33 / (var_4 * var_24);

        if(var_8 > 0) {
          if(var_5) {
            self moveTo(var_6["origin"], var_8);
            self rotateTo(var_29, var_8 * 0.25);
            wait(var_8);
          } else {
            var_7 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
            add_state_ent(var_7);
            self linkTo(var_7);
            var_7 moveTo(var_6["origin"], var_8);
            var_7 rotateTo(var_29, var_8 * 0.25);
            scripts\engine\utility::waittill_notify_or_timeout("death", var_8);
            self unlink();
            var_7 delete();
          }
        }

        if(isDefined(var_16)) {
          self notify("stop_running_anim");
          play_scripted_anim(var_16, undefined, undefined, undefined, var_6["anim_node"], 0);
          var_6["anim_node"] delete();
          set_animsets([var_17]);
        } else {
          self.angles = var_6["angles"];
          set_animsets(self.current_node scripts\sp\fakeactor_node::fakeactor_node_get_cover_list());
        }

        self.current_node scripts\sp\fakeactor_node::fakeactor_node_set_claimed(self);
        fakeactor_check_node(self.current_node);
        self notify("stop_running_anim");
        set_wants_to_move(0);
        self notify("arrive_node");
        self notify("reached_path_end");
        self notify("goal");
        return;
      } else if(self.current_node != self.node_path[var_9]["node"]) {
        self.current_node = self.node_path[var_9]["node"];
        set_animsets(self.current_node scripts\sp\fakeactor_node::fakeactor_node_get_cover_list());
        fakeactor_check_node(self.current_node);
      }
    }

    var_34 = self.node_path[var_9]["to_next_node"] * var_28;
    var_34 = var_34 + self.node_path[var_9]["origin"];
    var_35 = var_34;

    if(!var_5)
      self.look_ahead_point = var_35;

    var_22 = vectortoangles(var_35 - self.origin);
    childthread fakeactor_rotate_to(var_22, self.loop_time);

    if(var_5) {
      var_36 = var_4 * self.loop_time * var_24;
      var_37 = vectorNormalize(var_35 - self.origin);
      var_34 = var_37 * var_36;
      var_34 = var_34 + self.origin;
      self moveTo(var_34, self.loop_time);
    }

    if(getDvar("debug_fakeactor") == "1") {}

    wait(self.loop_time);
  }

  self.node_path = undefined;
  set_wants_to_move(0);
  self notify("arrive_node");
  self notify("reached_path_end");
  self notify("goal");
}

fakeactor_rotate_to(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = anglesToForward(var_0);
  var_4 = 0;
  var_5 = 1 / var_1;

  for(;;) {
    var_6 = var_4 * var_5;
    var_7 = vectorlerp(var_2, var_3, var_6);
    self.angles = vectortoangles(var_7);
    var_4 = var_4 + 0.05;
    wait 0.05;

    if(var_4 >= var_1) {
      break;
    }
  }

  self.angles = var_0;
}

fakeactor_check_delete() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.script_noteworthy)) {
    return;
  }
  switch (self.script_noteworthy) {
    case "delete_on_goal":
      if(isDefined(self.magic_bullet_shield))
        scripts\common\ai::stop_magic_bullet_shield();

      self delete();
      break;
    case "die_on_goal":
      self kill();
      break;
  }
}

fakeactor_check_node(var_0) {
  if(isDefined(var_0.script_noteworthy)) {
    switch (var_0.script_noteworthy) {
      case "delete_on_goal":
        if(isDefined(self.magic_bullet_shield))
          scripts\common\ai::stop_magic_bullet_shield();

        self delete();
        break;
      case "die_on_goal":
        self kill();
        break;
    }
  }

  if(isDefined(var_0.script_flag_set))
    scripts\engine\utility::flag_set(var_0.script_flag_set);

  if(isDefined(var_0.script_flag_clear))
    scripts\engine\utility::flag_clear(var_0.script_flag_clear);

  if(isDefined(var_0.script_ent_flag_set))
    scripts\engine\utility::ent_flag_set(var_0.script_ent_flag_set);

  if(isDefined(self.script_ent_flag_clear))
    scripts\engine\utility::ent_flag_set(var_0.script_ent_flag_clear);

  if(isDefined(var_0.script_demeanor)) {
    if(var_0.script_demeanor == "frantic")
      set_frantic(1);
  }

  if(isDefined(var_0.script_do_arrival))
    set_do_arrivals(var_0.script_do_arrival);

  if(isDefined(var_0.script_do_exits))
    set_do_exits(var_0.script_do_exits);

  if(isDefined(var_0.script_use_real_fire))
    set_real_fire(var_0.script_use_real_fire);

  if(isDefined(var_0.script_use_pain))
    set_use_pain(var_0.script_use_pain);
}

lock_to_ground(var_0) {
  self endon("death");
  self endon("change_state");
  self notify("drone_move_z");
  self endon("drone_move_z");
  var_1 = 0.05;

  for(;;) {
    if(isDefined(self.look_ahead_point) && var_0 > 0) {
      var_2 = self.look_ahead_point[2] - self.origin[2];
      var_3 = distance2d(self.look_ahead_point, self.origin);
      var_4 = var_3 / var_0;

      if(var_4 > 0 && var_2 != 0) {
        var_5 = abs(var_2) / var_4;
        var_6 = var_5 * var_1;

        if(var_2 >= var_5)
          self.origin = (self.origin[0], self.origin[1], self.origin[2] + var_6);
        else if(var_2 <= var_5 * -1)
          self.origin = (self.origin[0], self.origin[1], self.origin[2] - var_6);
      }
    }

    wait(var_1);
  }
}

set_current_node(var_0) {
  if(isDefined(self.current_node))
    self.current_node scripts\sp\fakeactor_node::fakeactor_node_remove_claimed(self);

  self.forced_node_path = undefined;
  self.current_node = var_0;
  set_animsets(self.current_node scripts\sp\fakeactor_node::fakeactor_node_get_cover_list());
}

teleport_to_node(var_0) {
  set_current_node(var_0);
  self.current_node scripts\sp\fakeactor_node::fakeactor_node_set_claimed(self);
  fakeactor_check_node(self.current_node);
  self dontinterpolate();
  self.origin = self.current_node.origin;
  self.angles = self.current_node scripts\sp\fakeactor_node::fakeactor_node_get_angles(is_frantic());
}

clear_node_path() {
  if(isDefined(self.node_path)) {
    foreach(var_1 in self.node_path) {
      if(isDefined(var_1["node"]))
        var_1["node"] scripts\sp\fakeactor_node::fakeactor_node_remove_claimed(self);
    }
  }
}

should_fire() {
  if(self.animset == "exposed")
    return 0;

  if(isDefined(self.aim_target))
    return is_target_in_view();

  return 1;
}

fire_weapon(var_0) {
  self endon("death");
  childthread aim_think();
  wait 0.25;
  var_1 = weaponclipsize(self.weapon);
  var_2 = weaponfiretime(self.weapon);
  var_3 = weaponburstcount(self.weapon);
  var_4 = weaponclass(self.weapon);
  var_5 = var_1;

  if(var_4 == "sniper")
    var_5 = 5;
  else if(var_3 > 0)
    var_5 = var_3;

  while(var_5 > 0) {
    if(should_fire()) {
      var_6 = self gettagorigin("tag_flash");
      var_7 = self gettagangles("tag_flash");
      var_8 = anglesToForward(var_7);
      var_9 = var_6 + var_8 * 1000;

      if(isDefined(self.aim_target)) {
        var_10 = scripts\engine\trace::ray_trace(var_6, var_9, self);

        if(isDefined(var_10["entity"]) && var_10["entity"] == self.aim_target) {
          var_11 = get_accuracy();

          if(randomfloat(1) > var_11) {
            var_12 = self.aim_target physics_getcharactercollisioncapsule();
            var_13 = anglestoup(self.aim_target.angles);
            var_14 = randomfloatrange(0, var_12["half_height"] * 2);
            var_15 = anglestoright(self.aim_target.angles);
            var_16 = var_12["radius"] * randomfloatrange(1, 2);

            if(scripts\engine\utility::cointoss())
              var_16 = var_16 * -1;

            var_17 = self.aim_target.origin + var_13 * var_14 + var_15 * var_16;
            var_8 = vectorNormalize(var_17 - var_6);
            var_9 = var_6 + var_8 * 1000;
          }
        }
      }

      if(should_real_fire())
        magicbullet(self.weapon, var_6, var_9);
      else
        fake_bullet(self.weapon, var_6, var_9, self.no_weapon_sound);

      self setanimknobrestart(var_0, 1, 0.2, 1.0);
      scripts\engine\utility::delaycall(0.15, ::clearanim, var_0, 0);
    }

    var_5--;
    wait(max(var_2, 0.1));
  }
}

get_accuracy(var_0) {
  var_1 = self.baseaccuracy;
  var_2 = 1.0;

  if(isDefined(self.aim_target) && isDefined(self.aim_target.attackeraccuracy))
    var_2 = self.aim_target.attackeraccuracy;

  var_3 = distance(self.origin, self.aim_target.origin);
  var_4 = getaccuracyfraction(self.weapon, var_3, isPlayer(self.aim_target));
  var_5 = "stand";

  if(isPlayer(self.aim_target))
    var_5 = self.aim_target getstance();
  else if(isai(self.aim_target))
    var_5 = self.aim_target.currentpose;

  var_6 = 1;

  if(var_5 == "crouch")
    var_6 = 0.75;
  else if(var_5 == "prone")
    var_6 = 0.5;

  var_7 = 1;

  if(isPlayer(self.aim_target)) {
    var_8 = level.player getnormalizedmovement();
    var_7 = 1 - length(var_8) * 0.3;
  } else if(isai(self.aim_target)) {}

  var_9 = 0.75;
  var_10 = var_1 * var_2 * var_4 * var_6 * var_7 * var_9;
  return var_10;
}

fake_bullet(var_0, var_1, var_2, var_3) {
  bullettracer(var_1, var_2, var_0);
  playFXOnTag(scripts\engine\utility::getfx("fakeactor_muzflash"), self, "tag_flash");

  if(!isDefined(var_3) || !var_3)
    return;
}

get_target_point(var_0) {
  if(isPlayer(var_0)) {
    if(is_human())
      var_1 = 50;
    else
      var_1 = 50;

    var_2 = var_0 getplayerangles();
    var_3 = var_0 getorigin() + anglestoup(var_2) * var_1;
    return var_3;
  } else if(isai(var_0))
    return var_0 gettagorigin("j_SpineUpper");
  else {
    var_3 = var_0.origin;

    if(isDefined(self.aim_target_offset))
      var_3 = var_3 + self.aim_target_offset;

    return var_3;
  }
}

aim_think() {
  self endon("end_aim");
  var_0 = 0.2;
  var_1 = get_aim_anim("aim_5");

  if(isDefined(var_1))
    self setanimknoball(var_1, self.anim_branch["body"], 1, var_0);

  self setanimlimited(get_aim_anim("aim_2"), 1, var_0);
  self setanimlimited(get_aim_anim("aim_4"), 1, var_0);
  self setanimlimited(get_aim_anim("aim_6"), 1, var_0);
  self setanimlimited(get_aim_anim("aim_8"), 1, var_0);
  var_2 = 10;
  var_3 = 0;
  var_4 = 0;
  var_5 = 1;

  while(isDefined(self.aim_target)) {
    var_6 = self gettagorigin("tag_flash");
    var_7 = get_target_point(self.aim_target);
    var_8 = scripts\engine\sp\utility::worldtolocalcoords(var_7) - scripts\engine\sp\utility::worldtolocalcoords(var_6);
    var_9 = vectortoangles(var_8);
    var_10 = angleclamp180(var_9[0]);
    var_11 = angleclamp180(var_9[1]);

    if(var_10 < self.upaimlimit || var_10 > self.downaimlimit || var_11 < self.rightaimlimit || var_11 > self.leftaimlimit) {
      set_target_in_view(0);
      var_10 = 0;
      var_11 = 0;
    } else
      set_target_in_view(1);

    if(getDvar("debug_fakeactor") == "1") {
      var_12 = self gettagangles("tag_origin");
      scripts\engine\utility::draw_angles(var_12, self gettagorigin("tag_origin"));
    }

    if(!var_5) {
      var_13 = var_11 - var_3;

      if(abs(var_13) > var_2)
        var_11 = var_3 + clamp(var_13, -1 * var_2, var_2);

      var_14 = var_10 - var_4;

      if(abs(var_14) > var_2)
        var_10 = var_4 + clamp(var_14, -1 * var_2, var_2);
    }

    var_10 = clamp(var_10, self.upaimlimit, self.downaimlimit);
    var_11 = clamp(var_11, self.rightaimlimit, self.leftaimlimit);
    var_5 = 0;
    var_3 = var_11;
    var_4 = var_10;
    aim_weights(self.anim_branch["aim_2"], self.anim_branch["aim_4"], self.anim_branch["aim_6"], self.anim_branch["aim_8"], var_10, var_11);
    wait 0.05;
  }
}

get_animation_from_alias(var_0, var_1, var_2, var_3) {
  var_4 = archetypegetalias(var_0, var_1, var_2, var_3);

  if(isDefined(var_4)) {
    if(isarray(var_4.anims)) {
      if(isDefined(var_4.weights)) {
        var_5 = randomfloat(1);
        var_6 = 0;

        for(var_7 = 0; var_7 < var_4.anims.size; var_7++) {
          var_6 = var_6 + var_4.weights[var_7];

          if(var_6 >= var_5)
            return var_4.anims[var_7];
        }

        return;
      }

      var_5 = randomint(var_4.anims.size);
      return var_4.anims[var_5];
      return;
      return;
    }

    return var_4.anims;
    return;
  } else {}
}

get_animation(var_0, var_1) {
  var_2 = get_animation_from_alias(self.animationarchetype, var_0, var_1, is_frantic());

  if(isarray(var_2))
    var_2 = scripts\engine\utility::random(var_2);

  return var_2;
}

get_idle_anim() {
  if(isDefined(self.idle_anim_override))
    return self.idle_anim_override;

  if(self.unittype != "civilian") {
    if(scripts\engine\utility::cointoss()) {
      if(self.animset == "exposed")
        return get_animation("noncombat_stand_idle", "noncombat_stand_idle");
      else
        return get_animation(self.animset, "hide_loop");
    } else {
      switch (self.animset) {
        case "cover_right_crouch":
        case "cover_left":
        case "cover_right":
          return get_animation(self.animset, "hide_loop");
        case "exposed":
          return get_animation("noncombat_stand_idle", "noncombat_stand_idle_twitch");
        case "cover_crouch":
        case "cover_stand":
        case "cover_left_crouch":
          return get_animation(self.animset + "_peek", "peek");
      }
    }
  } else {
    switch (self.animset) {
      case "exposed":
        return get_animation("stand_idle", "civ0" + randomintrange(1, 7));
    }
  }
}

get_movement_anim() {
  if(isDefined(self.run_anim_override))
    return self.run_anim_override;

  var_0 = "default";

  if(isDefined(self.run_anim_alias))
    var_0 = self.run_anim_alias;

  return get_animation("stand_run_loop", var_0);
}

get_turn_anim(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_1);
  var_4 = var_0[1] - var_3[1];
  var_4 = var_4 + 360;
  var_4 = int(var_4) % 360;
  var_5 = "";

  if(var_4 > 315 || var_4 < 45)
    return undefined;
  else if(var_4 >= 150 && var_4 <= 210)
    var_5 = "2";
  else if(var_4 < 90)
    var_5 = "9";
  else if(var_4 > 270)
    var_5 = "7";
  else if(var_4 < 135)
    var_5 = "6";
  else if(var_4 > 225)
    var_5 = "4";
  else if(var_4 < 150)
    var_5 = "3";
  else if(var_4 > 210)
    var_5 = "1";

  return get_animation("run_turn", "left" + var_5);
}

get_shoot_anim() {
  switch (self.animset) {
    case "cover_crouch":
    case "cover_right_crouch":
    case "cover_left_crouch":
      return get_animation("crouch_shoot_full", "fire");
    case "cover_stand":
    case "cover_left":
    case "cover_right":
      return get_animation("shoot_full", "fire");
    case "exposed":
      return get_animation("shoot_full", "fire");
  }
}

get_aim_anim(var_0) {
  switch (self.animset) {
    case "cover_crouch":
      return get_animation("cover_crouch_aim", "rifle_" + var_0);
    case "cover_left_crouch":
      if(var_0 == "aim_5")
        return undefined;

      return get_animation("cover_crouch_exposed_left", "rifle_" + var_0);
    case "cover_right_crouch":
      if(var_0 == "aim_5")
        return undefined;

      return get_animation("cover_crouch_exposed_right", "rifle_" + var_0);
    case "cover_stand":
      return get_animation("cover_stand_exposed", "rifle_" + var_0);
    case "cover_left":
      if(var_0 == "aim_5")
        return undefined;

      return get_animation("cover_left_exposed_B", "rifle_" + var_0);
    case "cover_right":
      if(var_0 == "aim_5")
        return undefined;

      return get_animation("cover_right_exposed_B", "rifle_" + var_0);
    case "exposed":
      return get_animation("exposed_idle", "rifle_" + var_0);
  }
}

get_hide_to_aim_anim() {
  switch (self.animset) {
    case "cover_crouch":
      return get_animation("cover_crouch_hide_to_aim", "hide_to_aim");
    case "cover_stand":
      return get_animation("cover_stand_hide_to_exposed", "hide_to_exposed");
    case "cover_left":
      return get_animation("cover_left_hide_to_B", "hide_to_exposed");
    case "cover_right":
      return get_animation("cover_right_hide_to_B", "hide_to_exposed");
    case "cover_left_crouch":
      return get_animation("cover_left_crouch_hide_to_B", "hide_to_B");
    case "cover_right_crouch":
      return get_animation("cover_right_crouch_hide_to_B", "hide_to_B");
  }

  return undefined;
}

get_aim_to_hide_anim() {
  switch (self.animset) {
    case "cover_crouch":
      return get_animation("cover_crouch_aim_to_hide", "aim_to_hide");
    case "cover_stand":
      return get_animation("cover_stand_exposed_to_hide", "exposed_to_hide");
    case "cover_left":
      return get_animation("cover_left_B_to_hide", "exposed_to_hide");
    case "cover_right":
      return get_animation("cover_right_B_to_hide", "exposed_to_hide");
    case "cover_left_crouch":
      return get_animation("cover_left_crouch_B_to_hide", "B_to_hide");
    case "cover_right_crouch":
      return get_animation("cover_right_crouch_B_to_hide", "B_to_hide");
  }

  return undefined;
}

get_arrival_anim(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = self.animset;

  if(!isDefined(var_1))
    var_1 = self;

  var_3 = var_2 + "_arrival";
  var_4 = scripts\engine\sp\utility::get_direction_value(var_0.angles, var_0.origin, var_1.origin);

  switch (var_2) {
    case "cover_crouch":
      if(var_4 == "9")
        var_4 = "6";
      else if(var_4 == "7" || var_4 == "8")
        var_4 = "4";

      break;
    case "cover_stand":
      if(var_4 == "9")
        var_4 = "6";
      else if(var_4 == "7" || var_4 == "8")
        var_4 = "4";

      break;
    case "cover_left":
      if(var_4 == "9")
        var_4 = "8";

      break;
    case "cover_right":
      if(var_4 == "7")
        var_4 = "8";

      break;
    case "cover_left_crouch":
      if(var_4 == "9")
        var_4 = "8";

      break;
    case "cover_right_crouch":
      if(var_4 == "7")
        var_4 = "8";

      break;
    case "exposed":
      break;
    default:
      return undefined;
  }

  if(is_human())
    var_5 = "left" + var_4;
  else
    var_5 = var_4;

  return get_animation(var_3, var_5);
}

get_exit_anim(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = self.origin;

  if(!isDefined(var_2))
    var_2 = self.angles;

  if(!isDefined(var_3))
    var_3 = self.animset;

  var_4 = var_3 + "_exit";
  var_5 = scripts\engine\sp\utility::get_direction_value(var_2, var_1, var_0);

  switch (var_3) {
    case "cover_crouch":
      if(var_5 == "9")
        var_5 = "6";
      else if(var_5 == "7" || var_5 == "8")
        var_5 = "4";

      return get_animation(var_4, var_5);
    case "cover_stand":
      if(var_5 == "9")
        var_5 = "6";
      else if(var_5 == "7" || var_5 == "8")
        var_5 = "4";

      return get_animation(var_4, var_5);
    case "cover_left":
      if(var_5 == "9")
        var_5 = "8";

      return get_animation(var_4, var_5);
    case "cover_right":
      if(var_5 == "7")
        var_5 = "8";

      return get_animation(var_4, var_5);
    case "cover_left_crouch":
      if(var_5 == "9")
        var_5 = "8";

      return get_animation(var_4, var_5);
    case "cover_right_crouch":
      if(var_5 == "7")
        var_5 = "8";

      return get_animation(var_4, var_5);
    case "exposed":
      return get_animation(var_4, var_5);
    default:
      return undefined;
  }
}

get_reload_anim() {
  if(self.animset == "exposed")
    return get_animation("Exposed_Reload", "rifle");
  else {
    var_0 = self.animset + "_reload";
    return get_animation(var_0, "reload");
  }
}

get_stance_change_anim() {
  switch (self.animset) {
    case "cover_crouch":
      return get_animation("exposed_stand_to_crouch", "stand_to_crouch");
    case "cover_stand":
      return get_animation("exposed_crouch_to_stand", "crouch_to_stand");
    case "cover_left":
      return get_animation("cover_left_crouch_to_stand", "crouch_to_stand");
    case "cover_left_crouch":
      return get_animation("cover_left_stand_to_crouch", "stand_to_crouch");
    case "cover_right":
      return get_animation("cover_right_crouch_to_stand", "crouch_to_stand");
    case "cover_right_crouch":
      return get_animation("cover_right_stand_to_crouch", "stand_to_crouch");
  }

  return undefined;
}

get_pain_anim() {
  if(is_moving()) {
    var_0 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "short", "medium");
    return get_animation("pain_run_default", var_0);
  } else {
    switch (self.animset) {
      case "cover_crouch":
        return get_animation("pain_cover_crouch_anim", "torso_md_f");
      case "cover_stand":
        return get_animation("pain_cover_stand_anim", "torso_md_f");
      case "cover_left":
        return get_animation("pain_cover_left_default", "stand");
      case "cover_right":
        return get_animation("pain_cover_right_default", "stand");
      case "cover_left_crouch":
        return get_animation("pain_cover_left_default", "crouch");
      case "cover_right_crouch":
        return get_animation("pain_cover_right_default", "crouch");
      default:
        return get_animation("pain_exp_stand", "torso_md_f");
    }
  }
}

get_death_anim() {
  if(self.unittype != "civilian") {
    if(isDefined(self.last_damage_type) && self.last_damage_type == "MOD_EXPLOSIVE") {
      var_0 = scripts\engine\utility::random(["explosive_f", "explosive_l", "explosive_r"]);

      if(is_moving()) {
        return get_animation("death_moving_explosive", var_0);
        return;
      }

      return get_animation("death_explosive", var_0);
      return;
    } else if(is_moving()) {
      if(scripts\engine\utility::cointoss()) {
        var_1 = scripts\engine\utility::random(["head", "lowerbody_l", "lowerbody_r", "midbody"]);
        var_2 = "_md_";
        var_3 = scripts\engine\utility::random(["2", "4", "6", "8"]);
        var_0 = var_1 + var_2 + var_3;
        return get_animation("death_exp_stand", var_0);
      } else {
        var_3 = scripts\engine\utility::random(["running_forward_2", "running_forward_4", "running_forward_6", "running_forward_8"]);
        return get_animation("death_moving_default", var_3);
      }
    } else {
      switch (self.animset) {
        case "cover_crouch":
          return get_animation("death_cover_default", "crouch_default");
        case "cover_stand":
          return get_animation("death_cover_default", "stand");
        case "cover_left":
          return get_animation("death_cover_default", "left_stand");
        case "cover_right":
          return get_animation("death_cover_default", "right_stand");
        case "cover_left_crouch":
          return get_animation("death_cover_default", "left_crouch");
        case "cover_right_crouch":
          return get_animation("death_cover_default", "right_crouch_default");
        default:
          var_1 = scripts\engine\utility::random(["head", "lowerbody", "midbody"]);
          var_2 = "_md_";
          var_3 = scripts\engine\utility::random(["2", "4", "6", "8"]);
          var_0 = var_1 + var_2 + var_3;
          return get_animation("death_exp_stand", var_0);
      }
    }
  } else
    return get_animation("death_generic", "civ_death_generic");
}

get_traverse_anim(var_0) {
  if(issubstr(var_0, "jumpdown"))
    return get_animation(var_0, "jumpdown");
  else if(issubstr(var_0, "jumpover"))
    return get_animation(var_0, "jumpover");
  else if(issubstr(var_0, "jumpup"))
    return get_animation(var_0, "jumpup");
  else
    return get_animation(var_0, var_0);
}

death_think() {
  self endon("entitydeleted");
  damage_think();

  if(!isDefined(self)) {
    return;
  }
  clear_node_path();

  if(isDefined(self.deathfunction)) {
    var_0 = self[[self.deathfunction]]();

    if(!isDefined(var_0) || var_0)
      return;
  }

  var_1 = self.deathanim;

  if(!isDefined(var_1))
    var_1 = get_death_anim();

  self notify("death");
  cleanup_state_ents();
  drop_weapon();
  scripts\anim\face.gsc::saygenericdialogue("death");

  if(isDefined(self.noragdoll) && self.noragdoll) {
    if(!isDefined(self.skipdeathanim) || !self.skipdeathanim)
      play_scripted_anim(var_1, "deathplant");
  }

  if(!(isDefined(self.skipdeathanim) && self.skipdeathanim))
    play_scripted_anim(var_1, "deathplant");

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

drop_weapon(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  var_1 = self.weapon;
  var_2 = getweaponmodel(var_1);

  if(isDefined(self.weapon_object) && (!isDefined(var_2) || var_2 == "")) {
    var_1 = self.weapon_object;
    var_2 = getweaponmodel(var_1);
  }

  if(isDefined(var_2) && var_2 != "") {
    scripts\common\ai::gun_remove();

    if(!isDefined(self.nodrop)) {
      var_3 = scripts\sp\utility::getweapondefaults(var_1.basename);
      var_4 = "";

      foreach(var_6 in var_3)
      var_4 = var_4 + "+" + var_6;

      var_8 = spawn("weapon_" + createheadicon(var_1) + var_4, self gettagorigin("tag_weapon_right"));
      var_8.angles = self gettagangles("tag_weapon_right");

      if(istrue(var_0))
        limit_dropped_weapons(var_8);
    }
  }
}

limit_dropped_weapons(var_0) {
  if(!isDefined(level.fakeactor_droppedweapons))
    level.fakeactor_droppedweapons = [];

  var_1 = scripts\engine\utility::array_removeundefined(level.fakeactor_droppedweapons);
  var_2 = var_1.size;

  if(var_1.size >= 4) {
    var_1 = sortbydistance(var_1, level.player.origin);
    var_2 = var_2 - 1;
    var_1[var_2] delete();
  }

  var_1[var_2] = var_0;
  level.fakeactor_droppedweapons = var_1;
}

damage_think() {
  self endon("entitydeleted");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);
    self.last_damage_type = var_4;
    self.lastattacker = var_1;

    if(isDefined(var_1) && isPlayer(var_1))
      var_1 setclientomnvar("damage_feedback_notify", gettime());

    if(isDefined(self.damageshield) && self.damageshield) {
      self.health = 100000;
      continue;
    }

    if(self.health <= 0) {
      break;
    }

    scripts\anim\face.gsc::saygenericdialogue("pain");

    if(!was_recent_pain() && should_do_pain_anim())
      thread do_pain();
  }
}

do_pain() {
  self notify("change_state");
  self notify("stop_damage_pain_anim");
  self endon("stop_damage_pain_anim");
  self endon("death");
  set_recent_pain(1);
  scripts\engine\utility::delaythread(1.5, ::set_recent_pain, 0);
  clear_node_path();
  play_scripted_anim(get_pain_anim());
  self.current_state = "";
  self.forced_node_path = scripts\sp\fakeactor_node::fakeactor_node_get_path(self.current_node, self.origin, is_frantic(), 1);
}

debug_draw() {}

array_handling(var_0) {
  var_1 = var_0.team;
  scripts\engine\sp\utility::structarray_add(level.fakeactors[var_1], var_0);
  var_0 waittill("death");
  var_0 cleanup_state_ents();

  if(isDefined(var_0) && isDefined(var_0.struct_array_index))
    scripts\engine\sp\utility::structarray_remove_index(level.fakeactors[var_1], var_0.struct_array_index);
  else
    scripts\engine\sp\utility::structarray_remove_undefined(level.fakeactors[var_1]);
}

play_running_anim_internal(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(isDefined(self.fakeactor_loop_override))
    self[[self.fakeactor_loop_override]](var_0, var_1);
  else {
    self clearanim(self.anim_branch["body"], 0.2);
    self setflaggedanim("fakeactor_anim", var_0, 1, 0.2, var_1);
  }
}

play_scripted_anim(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(self.fakeactor_scripted_override))
    self[[self.fakeactor_scripted_override]](var_0, var_1);
  else {
    self clearanim(self.anim_branch["body"], 0.2);
    self stopanimScripted();
    var_6 = "normal";

    if(isDefined(var_1))
      var_6 = "deathplant";

    var_7 = self.origin;
    var_8 = self.angles;

    if(isDefined(var_4)) {
      var_7 = var_4.origin;
      var_8 = var_4.angles;
    }

    if(!isDefined(var_5))
      var_5 = 0.2;

    self animScripted("fakeactor_anim", var_7, var_8, var_0, var_6);

    if(isDefined(var_2))
      thread scripts\anim\notetracks.gsc::donotetracks(var_3, var_2);

    var_9 = "end";

    if(animhasnotetrack(var_0, "finish"))
      var_9 = "finish";
    else if(animhasnotetrack(var_0, "stop anim"))
      var_9 = "stop anim";

    var_10 = getanimlength(var_0) - var_5;

    if(var_5 > 0 && var_10 > 0)
      scripts\engine\utility::waittill_match_or_timeout("fakeactor_anim", var_9, var_10);
    else
      self waittillmatch("fakeactor_anim", var_9);
  }
}

get_anim_data(var_0) {
  var_1 = spawnStruct();
  var_1.anim_time = getanimlength(var_0);
  var_2 = getmovedelta(var_0, 0, 1);
  var_3 = length(var_2);

  if(var_1.anim_time > 0 && var_3 > 0) {
    var_1.run_speed = var_3 / var_1.anim_time;
    var_1.anim_relative = 0;
  } else {
    var_1.run_speed = 170;
    var_1.anim_relative = 1;
  }

  return var_1;
}

set_aim_target(var_0, var_1) {
  self.aim_target = var_0;
  self.aim_target_offset = var_1;
}

get_aim_target() {
  return self.aim_target;
}

watch_aim_target_think() {
  self endon("death");

  for(;;) {
    if(isai(self.aim_target) && !isalive(self.aim_target))
      set_aim_target(undefined);

    wait 0.05;
  }
}

is_human() {
  return self.unittype == "C6i" || self.unittype == "soldier" || self.unittype == "civilian" || self.unittype == "juggernaut" || self.unittype == "suicidebomber";
}

setup_animation() {
  scripts\sp\utility::assign_animtree_based_on_unittype();

  switch (self.unittype) {
    case "C6":
      setup_c6();
      break;
    case "C8":
      setup_c8();
      break;
    case "C6i":
    case "civilian":
    case "soldier":
      setup_generic_human();
      break;
    case "C12":
      break;
    default:
      break;
  }
}

#using_animtree("generic_human");

setup_generic_human() {
  self.anim_branch["root"] = % root;
  self.anim_branch["body"] = % body;
  self.anim_branch["aim_2"] = % aim_2;
  self.anim_branch["aim_4"] = % aim_4;
  self.anim_branch["aim_6"] = % aim_6;
  self.anim_branch["aim_8"] = % aim_8;
}

#using_animtree("c6");

setup_c6() {
  self.anim_branch["root"] = % root;
  self.anim_branch["body"] = % body;
  self.anim_branch["aim_2"] = % aim_2;
  self.anim_branch["aim_4"] = % aim_4;
  self.anim_branch["aim_6"] = % aim_6;
  self.anim_branch["aim_8"] = % aim_8;
}

#using_animtree("c8");

setup_c8() {
  self.anim_branch["root"] = % root;
  self.anim_branch["body"] = % body;
  self.anim_branch["aim_2"] = % aim_2;
  self.anim_branch["aim_4"] = % aim_4;
  self.anim_branch["aim_6"] = % aim_6;
  self.anim_branch["aim_8"] = % aim_8;
}

aim_weights(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0.1;
  var_7 = 1;

  if(var_5 < 0) {
    var_8 = var_5 / self.rightaimlimit * var_7;
    self setanimlimited(var_1, 0, var_6, 1, 1);
    self setanimlimited(var_2, var_8, var_6, 1, 1);
  } else if(var_5 > 0) {
    var_8 = var_5 / self.leftaimlimit * var_7;
    self setanimlimited(var_1, var_8, var_6, 1, 1);
    self setanimlimited(var_2, 0, var_6, 1, 1);
  }

  if(var_4 < 0) {
    var_8 = var_4 / self.upaimlimit * var_7;
    self setanimlimited(var_0, 0, var_6, 1, 1);
    self setanimlimited(var_3, var_8, var_6, 1, 1);
  } else if(var_4 > 0) {
    var_8 = var_4 / self.downaimlimit * var_7;
    self setanimlimited(var_0, var_8, var_6, 1, 1);
    self setanimlimited(var_3, 0, var_6, 1, 1);
  }
}

set_animsets(var_0) {
  self.animsets = var_0;
  pick_random_animset();
}

pick_random_animset() {
  var_0 = randomint(self.animsets.size);
  self.animset = self.animsets[var_0];
}

set_run_anim_override(var_0) {
  self.run_anim_override = var_0;
}

clear_run_anim_override() {
  self.run_anim_override = undefined;
}

set_idle_anim_override(var_0) {
  self.idle_anim_override = var_0;
}

clear_idle_anim_override() {
  self.idle_anim_override = undefined;
}

is_idle() {
  return self.current_state == "idle";
}

is_moving() {
  return isDefined(self.current_state) && self.current_state == "move";
}

is_controlled() {
  return self.flags & 256;
}

set_controlled(var_0) {
  if(var_0)
    self.flags = self.flags | 256;
  else
    self.flags = self.flags &~256;
}

take_control() {
  self notify("change_state");
  self.prev_node = self.current_node;
  clear_node_path();
  self.node_path = undefined;
  set_controlled(1);
}

release_control(var_0) {
  set_controlled(0);
  var_1 = undefined;

  if(isDefined(var_0))
    var_1 = var_0;
  else if(isDefined(self.prev_node)) {
    var_1 = self.prev_node;
    self.prev_node = undefined;
  } else if(isDefined(self.target)) {
    var_2 = scripts\engine\utility::getStructArray(self.target, "targetname");
    var_2 = scripts\engine\utility::random(var_2);

    if(isDefined(var_2) && var_2 scripts\sp\fakeactor_node::is_fakeactor_node())
      var_1 = var_2;
  }

  if(isDefined(var_1)) {
    set_current_node(var_1);
    set_wants_to_move(1);
  }

  self.current_state = undefined;
}

set_do_arrivals(var_0) {
  if(var_0)
    self.flags = self.flags | 8;
  else
    self.flags = self.flags &~8;
}

should_do_arrivals() {
  return self.flags & 8;
}

set_do_exits(var_0) {
  if(var_0)
    self.flags = self.flags | 16;
  else
    self.flags = self.flags &~16;
}

should_do_exits() {
  if(isDefined(self.previous_state)) {
    if(self.previous_state == "traverse" || self.previous_state == "turn")
      return 0;
  }

  return self.flags & 16;
}

set_wants_to_move(var_0) {
  if(var_0)
    self.flags = self.flags | 2;
  else
    self.flags = self.flags &~2;
}

does_want_to_move() {
  return self.flags & 2;
}

set_target_in_view(var_0) {
  if(var_0)
    self.flags = self.flags | 1;
  else
    self.flags = self.flags &~1;
}

is_target_in_view() {
  return self.flags & 1;
}

set_real_fire(var_0) {
  if(var_0)
    self.flags = self.flags | 32;
  else
    self.flags = self.flags &~32;
}

should_real_fire() {
  return self.flags & 32;
}

set_ignore_claimed(var_0) {
  if(var_0)
    self.flags = self.flags | 64;
  else
    self.flags = self.flags &~64;
}

is_ignore_claimed() {
  return self.flags & 64;
}

obstacle_in_way(var_0) {
  if(var_0)
    self.flags = self.flags | 128;
  else
    self.flags = self.flags &~128;
}

is_obstacle_in_way() {
  return self.flags & 128;
}

should_do_pain_anim() {
  return self.flags & 512;
}

set_use_pain(var_0) {
  if(var_0)
    self.flags = self.flags | 512;
  else
    self.flags = self.flags &~512;
}

was_recent_pain() {
  return self.flags & 2048;
}

set_recent_pain(var_0) {
  if(var_0)
    self.flags = self.flags | 2048;
  else
    self.flags = self.flags &~2048;
}

is_frantic() {
  return self.flags & 1024;
}

set_frantic(var_0) {
  if(var_0)
    self.flags = self.flags | 1024;
  else
    self.flags = self.flags &~1024;
}

trigger_fakeactor_move(var_0) {
  if(!isDefined(self.targetname)) {
    return;
  }
  var_1 = getEnt("target", self.targetname);

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_1 set_wants_to_move(1);
  }
}

trigger_fakeactor_node_disable(var_0) {
  if(!isDefined(var_0.targetname)) {
    return;
  }
  var_1 = scripts\engine\utility::getStructArray(var_0.targetname, "target");

  if(var_1.size == 0) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_2);

    foreach(var_4 in var_1)
    var_4 scripts\sp\fakeactor_node::fakeactor_node_set_disabled(1);
  }
}

trigger_fakeactor_node_enable(var_0) {
  if(!isDefined(var_0.targetname)) {
    return;
  }
  var_1 = scripts\engine\utility::getStructArray(var_0.targetname, "target");

  if(var_1.size == 0) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_2);

    foreach(var_4 in var_1)
    var_4 scripts\sp\fakeactor_node::fakeactor_node_set_disabled(0);
  }
}

trigger_fakeactor_node_enablegroup(var_0) {
  if(!isDefined(var_0.script_parameters)) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_1);
    scripts\sp\fakeactor_node::fakeactor_node_group_set_disabled(var_0.script_parameters, 0);
  }
}

trigger_fakeactor_node_disablegroup(var_0) {
  if(!isDefined(var_0.script_parameters)) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_1);
    scripts\sp\fakeactor_node::fakeactor_node_group_set_disabled(var_0.script_parameters, 1);
  }
}

trigger_fakeactor_node_passthrough(var_0) {
  if(!isDefined(var_0.targetname)) {
    return;
  }
  var_1 = scripts\engine\utility::getStructArray(var_0.targetname, "target");

  if(var_1.size == 0) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_2);

    foreach(var_4 in var_1)
    var_4 scripts\sp\fakeactor_node::fakeactor_node_set_passthrough();
  }
}

trigger_fakeactor_node_lock(var_0) {
  if(!isDefined(var_0.targetname)) {
    return;
  }
  var_1 = scripts\engine\utility::getStructArray(var_0.targetname, "target");

  if(var_1.size == 0) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_2);

    foreach(var_4 in var_1)
    var_4 scripts\sp\fakeactor_node::fakeactor_node_set_locked();
  }
}

is_higher_priority(var_0, var_1) {
  return var_0["priority"] < var_1["priority"];
}