/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\fakeactor.gsc
***********************************************/

function fakeactor_spawner_init() {
  setdvarifuninitialized("debug_fakeactor", 0);
  setdvarifuninitialized("debug_fakeactor_accuracy", 0);
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
    level.fakeactors["allies"] = scripts\engine\sp\utility::struct_arrayspawn();
  }

  if(!isDefined(level.fakeactors["axis"])) {
    level.fakeactors["axis"] = scripts\engine\sp\utility::struct_arrayspawn();
  }

  if(!isDefined(level.fakeactors["team3"])) {
    level.fakeactors["team3"] = scripts\engine\sp\utility::struct_arrayspawn();
  }

  if(!isDefined(level.fakeactors["neutral"])) {
    level.fakeactors["neutral"] = scripts\engine\sp\utility::struct_arrayspawn();
  }

  if(!isDefined(level.fa_state_machines)) {
    add_state("default", "anim", &play_anim_think, &play_anim_check, 30);
    add_state("default", "move", &move_think, &move_check, 10);
    add_state("default", "traverse", &traverse_think, &traverse_check, 20);
    add_state("default", "idle", &idle_think, &idle_check, 40);
  }

  level.fakeactor_spawn_func = &fakeactor_init;

  if(!isDefined(anim.fa_nodeyaws)) {
    var0 = [];
    GscBinSkip0(0x2e, "Cover Left", 0);
  }
}

function get_fakeactors(var0) {
  return level.fakeactors[var0].array;
}

function is_fakeactor() {
  return isDefined(self.script_fakeactor) && self.script_fakeactor;
}

function fakeactor_init() {
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

  fakeactor_give_soul();
  self hide();
  scripts\engine\utility::delaycall(0.05, &show);

  if(self.team == "axis" && !isDefined(self.script_ignoreme)) {
    self enableaimassist();
  }

  self setCanDamage(1);
  self.health = 150;

  if(self.team == "neutral") {
    self.team = "allies";
  }

  self makeentitysentient(self.team);
  thread fakeactor_thinks();
}

function create_state_machine(var0) {
  if(!isDefined(level.fa_state_machines)) {
    level.fa_state_machines = [];
  }

  level.fa_state_machines[var0] = [];
}

function get_state_machine(var0) {
  return level.fa_state_machines[var0];
}

function add_state(var0, var1, var2, var3, var4) {
  if(!isDefined(level.fa_state_machines)) {
    level.fa_state_machines = [];
  }

  if(!isDefined(level.fa_state_machines[var0])) {
    create_state_machine(var0);
  }

  var5 = level.fa_state_machines[var0].size;
  level.fa_state_machines[var0][var5] = [];
  level.fa_state_machines[var0][var5]["priority"] = var4;
  level.fa_state_machines[var0][var5]["stateName"] = var1;
  level.fa_state_machines[var0][var5]["thinkFunc"] = var2;
  level.fa_state_machines[var0][var5]["changeFunc"] = var3;
  level.fa_state_machines[var0] = scripts\engine\utility::array_sort_with_func(level.fa_state_machines[var0], &is_higher_priority);
}

function remove_state(var0, var1) {
  if(!isDefined(level.fa_state_machines[var0])) {
    return;
  }

  var2 = [];

  foreach(var4 in level.fa_state_machines[var0]) {
    if(var4["stateName"] != var1) {
      var2 = var4;
    }
  }

  level.fa_state_machines[var0] = var2;
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
    var0 = scripts\engine\utility::getStructArray(self.target, "targetname");
    var0 = scripts\engine\utility::random(var0);

    if(isDefined(var0) && var0 scripts\sp\fakeactor_node::is_fakeactor_node()) {
      set_current_node(var0);
      return;
    }

    return;
  }
}

function fakeactor_thinks() {
  waittillframeend();
  thread update_state_machine();
  thread move_message_think();
  thread watch_aim_target_think();
  thread make_real_ai_think();
  thread death_think();
}

function make_real_ai_think() {
  self endon("death");
  thread real_ai_distance_check();
  self waittill("make_real_ai");
  scripts\common\ai::stop_magic_bullet_shield();
  var0 = self.weapon;
  var1 = "";

  if(isDefined(self.current_node) && isDefined(self.current_node.target)) {
    var1 = self.current_node.target;
  }

  var2 = scripts\sp\spawner::spawner_makerealai(self, var1);
  var2 scripts\anim\shared::placeweaponon(var0, "right");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function watch_for_obstacles_think() {
  self endon("death");
  self endon("goal");
  var0 = squared(128);

  for(;;) {
    if(distancesquared(level.player getorigin(), self.origin) < var0) {
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

  for(;;) {
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

  return self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_claimed_by(self);
}

function change_state(var0) {
  self.previous_state = self.current_state;
  self notify("change_state");
  cleanup_state_ents();
  self.current_state = var0["stateName"];
  self thread[[var0["thinkFunc"]]]();
}

function add_state_ent(var0) {
  if(!isDefined(self.current_state_ents)) {
    self.current_state_ents = [];
  }

  self.current_state_ents[self.current_state_ents.size] = var0;
}

function cleanup_state_ents() {
  if(isDefined(self.current_state_ents)) {
    foreach(var1 in self.current_state_ents) {
      if(isDefined(var1)) {
        var1 delete();
      }
    }

    return;
  }
}

function update_state_machine() {
  self endon("death");
  self endon("make_real_ai");
  self.previous_state = "";
  var0 = "default";
  jumpiffalse(isDefined(self.state_machine)) LOC_0000002f;
  var0 = self.state_machine;

  for(;;) {
    wait 0.05;

    if(is_controlled()) {
      continue;
    }

    foreach(var2 in get_state_machine(var0)) {
      if(isDefined(self.current_state) && self.current_state == var2["stateName"]) {
        continue;
      }

      if([[var2["changeFunc"]]]()) {
        change_state(var2);
        break;
      }
    }
  }
}

function idle_check() {
  if(!isDefined(self.current_state)) {
    return true;
  }

  if(self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_claimed_by(self)) {
    return true;
  }

  return false;
}

function idle_think() {
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
      GscBinSkip4(0x35);
    }

    GscBinSkip4(0x35);
  }
}

function fight_think() {
  self endon("death");
  self endon("change_state");

  if(!isDefined(self.ignoreall)) {
    if(isDefined(self.current_node)) {
      var0 = self.current_node scripts\engine\utility::get_linked_ents();
      var0 = scripts\engine\utility::array_combine(var0, self.current_node scripts\engine\utility::get_linked_structs());

      if(var0.size) {
        var1 = scripts\engine\utility::random(var0);
        var2 = (0, 0, 0);

        if(isDefined(var1.radius)) {
          var3 = randomfloatrange(var1.radius * -1, var1.radius);
          var4 = randomfloatrange(var1.radius * -1, var1.radius);
          var2 = (var3, var4, 0);
        }

        set_aim_target(var1, var2);
      }
    }

    var5 = get_hide_to_aim_anim();
    var6 = get_aim_to_hide_anim();
    var7 = self.origin;

    if(isDefined(var5) && isDefined(var6)) {
      play_scripted_anim(var5);
    }

    self notify("start_aim");
    fire_weapon(get_shoot_anim());
    self notify("end_aim");

    if(isDefined(var5) && isDefined(var6)) {
      play_scripted_anim(var6);
    }

    if(should_fire()) {
      var8 = get_reload_anim();

      if(isDefined(var8)) {
        play_scripted_anim(var8);
      }
    }

    if(scripts\engine\utility::cointoss()) {
      var9 = self.animset;
      pick_random_animset();

      if(self.animset != var9) {
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
  if(isDefined(self.current_node) && self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_claimed_by(self) && self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_traverse()) {
    return true;
  }

  return false;
}

function traverse_think() {
  self endon("death");
  set_controlled(1);
  var0 = do_traverse_anim(self.current_node.traverse_animscript);
  set_controlled(0);
  set_wants_to_move(1);
}

function turn_check() {
  if(self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_claimed_by(self) && self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_turn()) {
    return true;
  }

  return false;
}

function turn_think() {
  self endon("death");
  set_controlled(1);
  var0 = self.current_node scripts\sp\fakeactor_node::fakeactor_node_get_next();
  play_scripted_anim(get_turn_anim(self.angles, self.origin, var0.origin));
  set_controlled(0);
  set_wants_to_move(1);
}

function play_anim_check() {
  if(isDefined(self.current_node) && self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_claimed_by(self) && self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_animation()) {
    if(!isDefined(self.current_node.last_actor) || self.current_node.last_actor != self) {
      return true;
    }
  }

  return false;
}

function play_anim_think() {
  self endon("death");
  set_controlled(1);
  self.current_node.anim_node scripts\common\anim::anim_generic_run(self, self.current_node.animation);
  self.current_node.last_actor = self;
  set_controlled(0);
  set_wants_to_move(1);
  self notify("played_anim");
}

function do_traverse_anim(var0) {
  var1 = get_traverse_anim(var0);
  play_scripted_anim(var1, undefined, &scripts\anim\traverse\shared::handletraversenotetracks, "traverseAnim", self.current_node);
}

function move_message_think() {
  self endon("death");
  self endon("make_real_ai");

  for(;;) {
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

  var0 = does_want_to_move();
  var1 = undefined;

  if(!isDefined(self.current_state) && isDefined(self.current_node)) {
    var1 = scripts\sp\fakeactor_node::fakeactor_node_get_path(self.current_node, self.origin, is_frantic(), var0);
  }

  if(self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_claimed_by(self) && !self.current_node scripts\sp\fakeactor_node::fakeactor_node_is_end_path(var0)) {
    var2 = self.current_node scripts\sp\fakeactor_node::fakeactor_node_get_next();
    var1 = scripts\sp\fakeactor_node::fakeactor_node_get_path(var2, self.origin, is_frantic(), var0);
  }

  if(isDefined(var1)) {
    foreach(var4 in var1) {
      if(var4["dist"] > 0) {
        self.node_path = var1;
        return true;
      }
    }
  }

  return false;
}

function play_running_anim() {
  self endon("death");
  self endon("change_state");
  self notify("stop_running_anim");
  self endon("stop_running_anim");
  var0 = 1;
  jumpiffalse(isDefined(self.run_rate_min) && isDefined(self.run_rate_max)) LOC_00000043;
  var0 = randomfloatrange(self.run_rate_min, self.run_rate_max);

  for(;;) {
    var1 = get_movement_anim();
    var2 = get_anim_data(var1);
    var3 = var2.run_speed;
    var4 = var2.anim_relative;
    play_running_anim_internal(var1, var0);
    wait getanimlength(var1);
  }
}

function move_think() {
  self endon("death");
  self endon("change_state");
  self notify("exit_node");
  var0 = self.origin;
  var1 = does_want_to_move();

  if(self.node_path.size == 0) {}

  self.current_node scripts\sp\fakeactor_node::fakeactor_node_remove_claimed(self);
  var2 = get_movement_anim();
  var3 = get_anim_data(var2);
  var4 = var3.run_speed;
  var5 = var3.anim_relative;

  if(!var5) {
    GscBinSkip4(0x35, var4);
  }

  var6 = self.node_path[self.node_path.size - 1];

  if(self.node_path[0]["total_dist"] < 64) {
    thread play_scripted_anim(get_idle_anim());
    var7 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
    add_state_ent(var7);
    self linkTo(var7);
    var8 = 0.2;
    var7 moveTo(var6["origin"], var8);
    var7 rotateTo(var6["angles"], var8);
    scripts\engine\utility::waittill_notify_or_timeout("death", var8);
    self unlink();
    var7 delete();

    if(self.current_node != var6["node"]) {
      self.current_node = var6["node"];
    }

    self.current_node scripts\sp\fakeactor_node::fakeactor_node_set_claimed(self);
    fakeactor_check_node(self.current_node);
    set_wants_to_move(0);
    self notify("arrive_node");
    return;
  }

  var9 = 0;
  var10 = undefined;

  if(should_do_exits()) {
    var11 = 0;

    foreach(var13 in self.node_path) {
      if(var11) {
        var10 = var13["origin"];
        break;
      }

      if(var13["dist"] > 0) {
        var11 = 1;
      }
    }

    if(isDefined(var10)) {
      var15 = get_exit_anim(var10);
      play_scripted_anim(var15);
    }
  }

  var16 = undefined;
  var17 = scripts\engine\utility::random(var8["node"] scripts\sp\fakeactor_node::fakeactor_node_get_cover_list());

  if(should_do_arrivals() && !var8["node"] scripts\sp\fakeactor_node::fakeactor_node_is_traverse() && !var8["node"] scripts\sp\fakeactor_node::fakeactor_node_is_turn() && var8["node"] scripts\sp\fakeactor_node::fakeactor_node_allow_arrivals()) {
    var18 = self;

    if(isDefined(self.node_path[self.node_path.size - 2]["node"])) {
      var18 = self.node_path[self.node_path.size - 2]["node"];
    }

    var16 = get_arrival_anim(var8["node"], var18, var17);

    if(isDefined(var16)) {
      var19 = getmovedelta(var16, 0, 1);
      var20 = getangledelta3d(var16, 0, 1);
      var21 = invertangles(var20);
      var22 = combineangles(var8["angles"], var21);
      var23 = var8["origin"] - rotatevector(var19, var22);
      var8 = scripts\engine\utility::spawn_script_origin(var23, var22);
      add_state_ent(var8["anim_node"]);
      var8 = var23;
      var8 = var22;
    }
  }

  thread play_running_anim();
  thread watch_for_obstacles_think();
  self.current_node = self.node_path[var9 + 1]["node"];
  var24 = 1;
  jumpiffalse(isDefined(self.move_scale)) LOC_000002c9;
  var24 = self.move_scale;
  var25 = self.node_path[var9]["to_next_node"];
  var26 = self.origin - self.node_path[var9]["origin"];
  var27 = vectordot(var25, var26);

  if(var9 == self.node_path.size) {} else {
    var28 = var27 + self.look_ahead_value;

    while(var28 > self.node_path[var9]["dist"]) {
      var28 -= self.node_path[var9]["dist"];
      var9++;

      if(var9 == self.node_path.size) {
        if(self.current_node != var8["node"]) {
          self.current_node = var8["node"];
        }

        var8 = 0;
        var29 = (0, 0, 0);
        var30 = (0, 0, 0);
        var31 = (0, 0, 0);
        var32 = var8["origin"] - self.origin;
        var29 = vectortoangles(var32);
        var33 = length(var32);
        var8 = var33 / var6 * var24;

        if(var8 > 0) {
          if(var7) {
            self moveTo(var8["origin"], var8);
            self rotateTo(var29, var8 * 0.25);
            wait var8;
          } else {
            var7 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
            add_state_ent(var7);
            self linkTo(var7);
            var7 moveTo(var8["origin"], var8);
            var7 rotateTo(var29, var8 * 0.25);
            scripts\engine\utility::waittill_notify_or_timeout("death", var8);
            self unlink();
            var7 delete();
          }
        }

        if(isDefined(var16)) {
          self notify("stop_running_anim");
          play_scripted_anim(var16, undefined, undefined, undefined, var8["anim_node"], 0);
          var8["anim_node"] delete();
          set_animsets([var17]);
        } else {
          self.angles = var8["angles"];
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
      }

      if(self.current_node != self.node_path[var26]["node"]) {
        self.current_node = self.node_path[var26]["node"];
        set_animsets(self.current_node scripts\sp\fakeactor_node::fakeactor_node_get_cover_list());
        fakeactor_check_node(self.current_node);
      }
    }

    var31 = self.node_path[var26]["to_next_node"] * var30;
    var31 += self.node_path[var26]["origin"];
    var32 = var31;

    if(!var24) {
      self.look_ahead_point = var32;
    }

    var33 = vectortoangles(var32 - self.origin);
    GscBinSkip4(0x35, var33, self.loop_time);
  }

  self.node_path = undefined;
  set_wants_to_move(0);
  self notify("arrive_node");
  self notify("reached_path_end");
  self notify("goal");
}

function fakeactor_rotate_to(var0, var1) {
  var2 = anglesToForward(self.angles);
  var3 = anglesToForward(var0);
  var4 = 0;
  var5 = 1 / var1;

  for(;;) {
    var6 = var4 * var5;
    var7 = vectorlerp(var2, var3, var6);
    self.angles = vectortoangles(var7);
    var4 += 0.05;
    wait 0.05;

    if(var4 >= var1) {
      break;
    }
  }

  self.angles = var0;
}

function fakeactor_check_delete() {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.script_noteworthy)) {
    return;
  }

  switch (self.script_noteworthy) {
    case "delete_on_goal":
      if(isDefined(self.magic_bullet_shield)) {
        scripts\common\ai::stop_magic_bullet_shield();
      }

      self delete();
      break;
    case "die_on_goal":
      self kill();
      break;
  }
}

function fakeactor_check_node(var0) {
  if(isDefined(var0.script_noteworthy)) {
    switch (var0.script_noteworthy) {
      case "delete_on_goal":
        if(isDefined(self.magic_bullet_shield)) {
          scripts\common\ai::stop_magic_bullet_shield();
        }

        self delete();
        break;
      case "die_on_goal":
        self kill();
        break;
    }
  }

  if(isDefined(var0.script_flag_set)) {
    scripts\engine\utility::flag_set(var0.script_flag_set);
  }

  if(isDefined(var0.script_flag_clear)) {
    scripts\engine\utility::flag_clear(var0.script_flag_clear);
  }

  if(isDefined(var0.script_ent_flag_set)) {
    scripts\engine\utility::ent_flag_set(var0.script_ent_flag_set);
  }

  if(isDefined(self.script_ent_flag_clear)) {
    scripts\engine\utility::ent_flag_set(var0.script_ent_flag_clear);
  }

  if(isDefined(var0.script_demeanor)) {
    if(var0.script_demeanor == "frantic") {
      set_frantic(1);
    }
  }

  if(isDefined(var0.script_do_arrival)) {
    set_do_arrivals(var0.script_do_arrival);
  }

  if(isDefined(var0.script_do_exits)) {
    set_do_exits(var0.script_do_exits);
  }

  if(isDefined(var0.script_use_real_fire)) {
    set_real_fire(var0.script_use_real_fire);
  }

  if(isDefined(var0.script_use_pain)) {
    set_use_pain(var0.script_use_pain);
    return;
  }
}

function lock_to_ground(var0) {
  self endon("death");
  self endon("change_state");
  self notify("drone_move_z");
  self endon("drone_move_z");
  var1 = 0.05;

  for(;;) {
    if(isDefined(self.look_ahead_point) && var0 > 0) {
      var2 = self.look_ahead_point[2] - self.origin[2];
      var3 = distance2d(self.look_ahead_point, self.origin);
      var4 = var3 / var0;

      if(var4 > 0 && var2 != 0) {
        var5 = abs(var2) / var4;
        var6 = var5 * var1;

        if(var2 >= var5) {
          self.origin = (self.origin[0], self.origin[1], self.origin[2] + var6);
        } else if(var2 <= var5 * -1) {
          self.origin = (self.origin[0], self.origin[1], self.origin[2] - var6);
        }
      }
    }

    wait var1;
  }
}

function set_current_node(var0) {
  if(isDefined(self.current_node)) {
    self.current_node scripts\sp\fakeactor_node::fakeactor_node_remove_claimed(self);
  }

  self.forced_node_path = undefined;
  self.current_node = var0;
  set_animsets(self.current_node scripts\sp\fakeactor_node::fakeactor_node_get_cover_list());
}

function teleport_to_node(var0) {
  set_current_node(var0);
  self.current_node scripts\sp\fakeactor_node::fakeactor_node_set_claimed(self);
  fakeactor_check_node(self.current_node);
  self dontinterpolate();
  self.origin = self.current_node.origin;
  self.angles = self.current_node scripts\sp\fakeactor_node::fakeactor_node_get_angles(is_frantic());
}

function clear_node_path() {
  if(isDefined(self.node_path)) {
    foreach(var1 in self.node_path) {
      if(isDefined(var1["node"])) {
        var1["node"] scripts\sp\fakeactor_node::fakeactor_node_remove_claimed(self);
      }
    }

    return;
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

function fire_weapon(var0) {
  self endon("death");
  GscBinSkip4(0x35);
}

function get_accuracy(var0) {
  var1 = self.baseaccuracy;
  var2 = 1;

  if(isDefined(self.aim_target) && isDefined(self.aim_target.attackeraccuracy)) {
    var2 = self.aim_target.attackeraccuracy;
  }

  var3 = distance(self.origin, self.aim_target.origin);
  var4 = getaccuracyfraction(self.weapon, var3, isPlayer(self.aim_target));
  var5 = "stand";

  if(isPlayer(self.aim_target)) {
    var5 = self.aim_target getstance();
  } else if(isai(self.aim_target)) {
    var5 = self.aim_target.currentpose;
  }

  var6 = 1;

  if(var5 == "crouch") {
    var6 = 0.75;
  } else if(var5 == "prone") {
    var6 = 0.5;
  }

  var7 = 1;

  if(isPlayer(self.aim_target)) {
    var8 = level.player getnormalizedmovement();
    var7 = 1 - length(var8) * 0.3;
  } else if(isai(self.aim_target)) {}

  var9 = 0.75;
  var10 = var1 * var2 * var4 * var6 * var7 * var9;
  return var10;
}

function fake_bullet(var0, var1, var2, var3) {
  bullettracer(var1, var2, var0);
  playFXOnTag(scripts\engine\utility::getfx("fakeactor_muzflash"), self, "tag_flash");

  if(!isDefined(var3) || !var3) {
    return;
  }
}

function get_target_point(var0) {
  if(isPlayer(var0)) {
    if(is_human()) {
      var1 = 50;
    } else {
      var1 = 50;
    }

    var2 = var1 getplayerangles();
    var3 = var1 getorigin() + anglestoup(var2) * var1;
    return var3;
  }

  if(isai(var3)) {
    return var3 gettagorigin("j_SpineUpper");
  }

  var3 = var3.origin;

  if(isDefined(self.aim_target_offset)) {
    var3 += self.aim_target_offset;
  }

  return var3;
}

function aim_think() {
  self endon("end_aim");
  var0 = 0.2;
  var1 = get_aim_anim("aim_5");

  if(isDefined(var1)) {
    self setanimknoball(var1, self.anim_branch["body"], 1, var0);
  }

  self setanimlimited(get_aim_anim("aim_2"), 1, var0);
  self setanimlimited(get_aim_anim("aim_4"), 1, var0);
  self setanimlimited(get_aim_anim("aim_6"), 1, var0);
  self setanimlimited(get_aim_anim("aim_8"), 1, var0);
  var2 = 10;
  var3 = 0;
  var4 = 0;
  var5 = 1;

  while(isDefined(self.aim_target)) {
    var6 = self gettagorigin("tag_flash");
    var7 = get_target_point(self.aim_target);
    var8 = scripts\engine\sp\utility::worldtolocalcoords(var7) - scripts\engine\sp\utility::worldtolocalcoords(var6);
    var9 = vectortoangles(var8);
    var10 = angleclamp180(var9[0]);
    var11 = angleclamp180(var9[1]);

    if(var10 < self.upaimlimit || var10 > self.downaimlimit || var11 < self.rightaimlimit || var11 > self.leftaimlimit) {
      set_target_in_view(0);
      var10 = 0;
      var11 = 0;
    } else {
      set_target_in_view(1);
    }

    if(getDvar("debug_fakeactor") == "1") {
      var12 = self gettagangles("tag_origin");
      scripts\engine\utility::draw_angles(var12, self gettagorigin("tag_origin"));
    }

    if(!var5) {
      var13 = var11 - var3;

      if(abs(var13) > var2) {
        var11 = var3 + clamp(var13, -1 * var2, var2);
      }

      var14 = var10 - var4;

      if(abs(var14) > var2) {
        var10 = var4 + clamp(var14, -1 * var2, var2);
      }
    }

    var10 = clamp(var10, self.upaimlimit, self.downaimlimit);
    var11 = clamp(var11, self.rightaimlimit, self.leftaimlimit);
    var5 = 0;
    var3 = var11;
    var4 = var10;
    aim_weights(self.anim_branch["aim_2"], self.anim_branch["aim_4"], self.anim_branch["aim_6"], self.anim_branch["aim_8"], var10, var11);
    wait 0.05;
  }
}

function get_animation_from_alias(var0, var1, var2, var3) {
  var4 = archetypegetalias(var0, var1, var2, var3);

  if(isDefined(var4)) {
    if(isarray(var4.anims)) {
      if(isDefined(var4.weights)) {
        var5 = randomfloat(1);
        var6 = 0;

        for(var7 = 0; var7 < var4.anims.size; var7++) {
          var6 += var4.weights[var7];

          if(var6 >= var5) {
            return var4.anims[var7];
          }
        }

        return;
      }

      var5 = randomint(var7.anims.size);
      return var7.anims[var5];
    }

    return var5.anims;
  }
}

function get_animation(var0, var1) {
  var2 = get_animation_from_alias(self.animationarchetype, var0, var1, is_frantic());

  if(isarray(var2)) {
    var2 = scripts\engine\utility::random(var2);
  }

  return var2;
}

function get_idle_anim() {
  if(isDefined(self.idle_anim_override)) {
    return self.idle_anim_override;
  }

  if(self.unittype != "civilian") {
    if(scripts\engine\utility::cointoss()) {
      if(self.animset == "exposed") {
        return get_animation("noncombat_stand_idle", "noncombat_stand_idle");
      }

      return get_animation(self.animset, "hide_loop");
    }

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

    return;
  }

  switch (self.animset) {
    case "exposed":
      return get_animation("stand_idle", "civ0" + randomintrange(1, 7));
  }
}

function get_movement_anim() {
  if(isDefined(self.run_anim_override)) {
    return self.run_anim_override;
  }

  var0 = "default";

  if(isDefined(self.run_anim_alias)) {
    var0 = self.run_anim_alias;
  }

  return get_animation("stand_run_loop", var0);
}

function get_turn_anim(var0, var1, var2) {
  var3 = vectortoangles(var2 - var1);
  var4 = var0[1] - var3[1];
  var4 += 360;
  var4 = int(var4) % 360;
  var5 = "";

  if(var4 > 315 || var4 < 45) {
    return undefined;
  } else if(var4 >= 150 && var4 <= 210) {
    var5 = "2";
  } else if(var4 < 90) {
    var5 = "9";
  } else if(var4 > 270) {
    var5 = "7";
  } else if(var4 < 135) {
    var5 = "6";
  } else if(var4 > 225) {
    var5 = "4";
  } else if(var4 < 150) {
    var5 = "3";
  } else if(var4 > 210) {
    var5 = "1";
  }

  return get_animation("run_turn", "left" + var5);
}

function get_shoot_anim() {
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

function get_aim_anim(var0) {
  switch (self.animset) {
    case "cover_crouch":
      return get_animation("cover_crouch_aim", "rifle_" + var0);
    case "cover_left_crouch":
      if(var0 == "aim_5") {
        return undefined;
      }

      return get_animation("cover_crouch_exposed_left", "rifle_" + var0);
    case "cover_right_crouch":
      if(var0 == "aim_5") {
        return undefined;
      }

      return get_animation("cover_crouch_exposed_right", "rifle_" + var0);
    case "cover_stand":
      return get_animation("cover_stand_exposed", "rifle_" + var0);
    case "cover_left":
      if(var0 == "aim_5") {
        return undefined;
      }

      return get_animation("cover_left_exposed_B", "rifle_" + var0);
    case "cover_right":
      if(var0 == "aim_5") {
        return undefined;
      }

      return get_animation("cover_right_exposed_B", "rifle_" + var0);
    case "exposed":
      return get_animation("exposed_idle", "rifle_" + var0);
  }
}

function get_hide_to_aim_anim() {
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

function get_aim_to_hide_anim() {
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

function get_arrival_anim(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = self.animset;
  }

  if(!isDefined(var1)) {
    var1 = self;
  }

  var3 = var2 + "_arrival";
  var4 = scripts\engine\sp\utility::get_direction_value(var0.angles, var0.origin, var1.origin);

  switch (var2) {
    case "cover_crouch":
      if(var4 == "9") {
        var4 = "6";
      } else if(var4 == "7" || var4 == "8") {
        var4 = "4";
      }

      break;
    case "cover_stand":
      if(var4 == "9") {
        var4 = "6";
      } else if(var4 == "7" || var4 == "8") {
        var4 = "4";
      }

      break;
    case "cover_left":
      if(var4 == "9") {
        var4 = "8";
      }

      break;
    case "cover_right":
      if(var4 == "7") {
        var4 = "8";
      }

      break;
    case "cover_left_crouch":
      if(var4 == "9") {
        var4 = "8";
      }

      break;
    case "cover_right_crouch":
      if(var4 == "7") {
        var4 = "8";
      }

      break;
    case "exposed":
      break;
    default:
      return undefined;
  }

  if(is_human()) {
    var5 = "left" + var4;
  } else {
    var5 = var5;
  }

  return get_animation(var4, var5);
}

function get_exit_anim(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = self.origin;
  }

  if(!isDefined(var2)) {
    var2 = self.angles;
  }

  if(!isDefined(var3)) {
    var3 = self.animset;
  }

  var4 = var3 + "_exit";
  var5 = scripts\engine\sp\utility::get_direction_value(var2, var1, var0);

  switch (var3) {
    case "cover_crouch":
      if(var5 == "9") {
        var5 = "6";
      } else if(var5 == "7" || var5 == "8") {
        var5 = "4";
      }

      return get_animation(var4, var5);
    case "cover_stand":
      if(var5 == "9") {
        var5 = "6";
      } else if(var5 == "7" || var5 == "8") {
        var5 = "4";
      }

      return get_animation(var4, var5);
    case "cover_left":
      if(var5 == "9") {
        var5 = "8";
      }

      return get_animation(var4, var5);
    case "cover_right":
      if(var5 == "7") {
        var5 = "8";
      }

      return get_animation(var4, var5);
    case "cover_left_crouch":
      if(var5 == "9") {
        var5 = "8";
      }

      return get_animation(var4, var5);
    case "cover_right_crouch":
      if(var5 == "7") {
        var5 = "8";
      }

      return get_animation(var4, var5);
    case "exposed":
      return get_animation(var4, var5);
    default:
      return undefined;
  }
}

function get_reload_anim() {
  if(self.animset == "exposed") {
    return get_animation("Exposed_Reload", "rifle");
  }

  var0 = self.animset + "_reload";
  return get_animation(var0, "reload");
}

function get_stance_change_anim() {
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

function get_pain_anim() {
  if(is_moving()) {
    var0 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "short", "medium");
    return get_animation("pain_run_default", var0);
  }

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

function get_death_anim() {
  if(self.unittype != "civilian") {
    if(isDefined(self.last_damage_type) && self.last_damage_type == "MOD_EXPLOSIVE") {
      var0 = scripts\engine\utility::random(["explosive_f", "explosive_l", "explosive_r"]);

      if(is_moving()) {
        return get_animation("death_moving_explosive", var0);
      }

      return get_animation("death_explosive", var0);
    }

    if(is_moving()) {
      if(scripts\engine\utility::cointoss()) {
        var1 = scripts\engine\utility::random(["head", "lowerbody_l", "lowerbody_r", "midbody"]);
        var2 = "_md_";
        var3 = scripts\engine\utility::random(["2", "4", "6", "8"]);
        var0 = var1 + var2 + var3;
        return get_animation("death_exp_stand", var0);
      }

      var3 = scripts\engine\utility::random(["running_forward_2", "running_forward_4", "running_forward_6", "running_forward_8"]);
      return get_animation("death_moving_default", var3);
    }

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
        var1 = scripts\engine\utility::random(["head", "lowerbody", "midbody"]);
        var2 = "_md_";
        var3 = scripts\engine\utility::random(["2", "4", "6", "8"]);
        var0 = var1 + var2 + var3;
        return get_animation("death_exp_stand", var0);
    }

    return;
  }

  return get_animation("death_generic", "civ_death_generic");
}

function get_traverse_anim(var0) {
  if(issubstr(var0, "jumpdown")) {
    return get_animation(var0, "jumpdown");
  }

  if(issubstr(var0, "jumpover")) {
    return get_animation(var0, "jumpover");
  }

  if(issubstr(var0, "jumpup")) {
    return get_animation(var0, "jumpup");
  }

  return get_animation(var0, var0);
}

function death_think() {
  self endon("entitydeleted");
  damage_think();

  if(!isDefined(self)) {
    return;
  }

  clear_node_path();

  if(isDefined(self.deathfunction)) {
    var0 = self[[self.deathfunction]]();

    if(!isDefined(var0) || var0) {
      return;
    }
  }

  var1 = self.deathanim;

  if(!isDefined(var1)) {
    var1 = get_death_anim();
  }

  self notify("death");
  cleanup_state_ents();
  drop_weapon();
  scripts\anim\face::saygenericdialogue("death");

  if(isDefined(self.noragdoll) && self.noragdoll) {
    if(!isDefined(self.skipdeathanim) || !self.skipdeathanim) {
      play_scripted_anim(var1, "deathplant");
    }
  }

  if(!(isDefined(self.skipdeathanim) && self.skipdeathanim)) {
    play_scripted_anim(var1, "deathplant");
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

function drop_weapon(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  var1 = self.weapon;
  var2 = getweaponmodel(var1);

  if(isDefined(self.weapon_object) && (!isDefined(var2) || var2 == "")) {
    var1 = self.weapon_object;
    var2 = getweaponmodel(var1);
  }

  if(isDefined(var2) && var2 != "") {
    scripts\common\ai::gun_remove();

    if(!isDefined(self.nodrop)) {
      var3 = scripts\sp\utility::getweapondefaults(var1.basename);
      var4 = "";

      foreach(var6 in var3) {
        var4 = var4 + "+" + var6;
      }

      var8 = spawn("weapon_" + createheadicon(var1) + var4, self gettagorigin("tag_weapon_right"));
      var8.angles = self gettagangles("tag_weapon_right");

      if(istrue(var0)) {
        limit_dropped_weapons(var8);
        return;
      }

      return;
    }

    return;
  }
}

function limit_dropped_weapons(var0) {
  if(!isDefined(level.fakeactor_droppedweapons)) {
    level.fakeactor_droppedweapons = [];
  }

  var1 = scripts\engine\utility::array_removeundefined(level.fakeactor_droppedweapons);
  var2 = var1.size;

  if(var1.size >= 4) {
    var1 = sortbydistance(var1, level.player.origin);
    var2 -= 1;
    var1[var2] delete();
  }

  var1 = var0;
  level.fakeactor_droppedweapons = var1;
}

function damage_think() {
  self endon("entitydeleted");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4);
    self.last_damage_type = var4;
    self.lastattacker = var1;

    if(isDefined(var1) && isPlayer(var1)) {
      var1 setclientomnvar("damage_feedback_notify", gettime());
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
  scripts\engine\utility::delaythread(1.5, &set_recent_pain, 0);
  clear_node_path();
  play_scripted_anim(get_pain_anim());
  self.current_state = "";
  self.forced_node_path = scripts\sp\fakeactor_node::fakeactor_node_get_path(self.current_node, self.origin, is_frantic(), 1);
}

function debug_draw() {}

function array_handling(var0) {
  var1 = var0.team;
  scripts\engine\sp\utility::structarray_add(level.fakeactors[var1], var0);
  var0 waittill("death");
  cleanup_state_ents(var0);

  if(isDefined(var0) && isDefined(var0.struct_array_index)) {
    scripts\engine\sp\utility::structarray_remove_index(level.fakeactors[var1], var0.struct_array_index);
    return;
  }

  scripts\engine\sp\utility::structarray_remove_undefined(level.fakeactors[var1]);
}

function play_running_anim_internal(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(isDefined(self.fakeactor_loop_override)) {
    self[[self.fakeactor_loop_override]](var0, var1);
    return;
  }

  self clearanim(self.anim_branch["body"], 0.2);
  self setflaggedanim("fakeactor_anim", var0, 1, 0.2, var1);
}

function play_scripted_anim(var0, var1, var2, var3, var4, var5) {
  if(isDefined(self.fakeactor_scripted_override)) {
    self[[self.fakeactor_scripted_override]](var0, var1);
    return;
  }

  self clearanim(self.anim_branch["body"], 0.2);
  self stopanimScripted();
  var6 = "normal";

  if(isDefined(var1)) {
    var6 = "deathplant";
  }

  var7 = self.origin;
  var8 = self.angles;

  if(isDefined(var4)) {
    var7 = var4.origin;
    var8 = var4.angles;
  }

  if(!isDefined(var5)) {
    var5 = 0.2;
  }

  self animScripted("fakeactor_anim", var7, var8, var0, var6);

  if(isDefined(var2)) {
    thread scripts\anim\notetracks::donotetracks(var3, var2);
  }

  var9 = "end";

  if(animhasnotetrack(var0, "finish")) {
    var9 = "finish";
  } else if(animhasnotetrack(var0, "stop anim")) {
    var9 = "stop anim";
  }

  var10 = getanimlength(var0) - var5;

  if(var5 > 0 && var10 > 0) {
    scripts\engine\utility::waittill_match_or_timeout("fakeactor_anim", var9, var10);
    return;
  }

  self waittillmatch("fakeactor_anim", var9);
}

function get_anim_data(var0) {
  var1 = spawnStruct();
  var1.anim_time = getanimlength(var0);
  var2 = getmovedelta(var0, 0, 1);
  var3 = length(var2);

  if(var1.anim_time > 0 && var3 > 0) {
    var1.run_speed = var3 / var1.anim_time;
    var1.anim_relative = 0;
  } else {
    var1.run_speed = 170;
    var1.anim_relative = 1;
  }

  return var1;
}

function set_aim_target(var0, var1) {
  self.aim_target = var0;
  self.aim_target_offset = var1;
}

function get_aim_target() {
  return self.aim_target;
}

function watch_aim_target_think() {
  self endon("death");

  for(;;) {
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

#using_animtree("");

function setup_generic_human() {
  self.anim_branch["root"] = % root;
  self.anim_branch["body"] = $body;
  self.anim_branch["aim_2"] = % aim_2;
  self.anim_branch["aim_4"] = % aim_4;
  self.anim_branch["aim_6"] = % aim_6;
  self.anim_branch["aim_8"] = % aim_8;
}

function setup_c6() {
  self.anim_branch["root"] = % root;
  self.anim_branch["body"] = $body;
  self.anim_branch["aim_2"] = % aim_2;
  self.anim_branch["aim_4"] = % aim_4;
  self.anim_branch["aim_6"] = % aim_6;
  self.anim_branch["aim_8"] = % aim_8;
}

function setup_c8() {
  self.anim_branch["root"] = % root;
  self.anim_branch["body"] = $body;
  self.anim_branch["aim_2"] = % aim_2;
  self.anim_branch["aim_4"] = % aim_4;
  self.anim_branch["aim_6"] = % aim_6;
  self.anim_branch["aim_8"] = % aim_8;
}

function aim_weights(var0, var1, var2, var3, var4, var5) {
  var6 = 0.1;
  var7 = 1;

  if(var5 < 0) {
    var8 = var5 / self.rightaimlimit * var7;
    self setanimlimited(var1, 0, var6, 1, 1);
    self setanimlimited(var2, var8, var6, 1, 1);
  } else if(var5 > 0) {
    var8 = var5 / self.leftaimlimit * var7;
    self setanimlimited(var1, var8, var6, 1, 1);
    self setanimlimited(var2, 0, var6, 1, 1);
  }

  if(var4 < 0) {
    var8 = var4 / self.upaimlimit * var7;
    self setanimlimited(var0, 0, var6, 1, 1);
    self setanimlimited(var3, var8, var6, 1, 1);
    return;
  }

  if(var4 > 0) {
    var8 = var4 / self.downaimlimit * var7;
    self setanimlimited(var0, var8, var6, 1, 1);
    self setanimlimited(var3, 0, var6, 1, 1);
    return;
  }
}

function set_animsets(var0) {
  self.animsets = var0;
  pick_random_animset();
}

function pick_random_animset() {
  var0 = randomint(self.animsets.size);
  self.animset = self.animsets[var0];
}

function set_run_anim_override(var0) {
  self.run_anim_override = var0;
}

function clear_run_anim_override() {
  self.run_anim_override = undefined;
}

function set_idle_anim_override(var0) {
  self.idle_anim_override = var0;
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
  return self.flags & 256;
}

function set_controlled(var0) {
  if(var0) {
    self.flags |= 256;
    return;
  }

  self.flags &= ~256;
}

function take_control() {
  self notify("change_state");
  self.prev_node = self.current_node;
  clear_node_path();
  self.node_path = undefined;
  set_controlled(1);
}

function release_control(var0) {
  set_controlled(0);
  var1 = undefined;

  if(isDefined(var0)) {
    var1 = var0;
  } else if(isDefined(self.prev_node)) {
    var1 = self.prev_node;
    self.prev_node = undefined;
  } else if(isDefined(self.target)) {
    var2 = scripts\engine\utility::getStructArray(self.target, "targetname");
    var2 = scripts\engine\utility::random(var2);

    if(isDefined(var2) && var2 scripts\sp\fakeactor_node::is_fakeactor_node()) {
      var1 = var2;
    }
  }

  if(isDefined(var1)) {
    set_current_node(var1);
    set_wants_to_move(1);
  }

  self.current_state = undefined;
}

function set_do_arrivals(var0) {
  if(var0) {
    self.flags |= 8;
    return;
  }

  self.flags &= ~8;
}

function should_do_arrivals() {
  return self.flags & 8;
}

function set_do_exits(var0) {
  if(var0) {
    self.flags |= 16;
    return;
  }

  self.flags &= ~16;
}

function should_do_exits() {
  if(isDefined(self.previous_state)) {
    if(self.previous_state == "traverse" || self.previous_state == "turn") {
      return 0;
    }
  }

  return self.flags & 16;
}

function set_wants_to_move(var0) {
  if(var0) {
    self.flags |= 2;
    return;
  }

  self.flags &= ~2;
}

function does_want_to_move() {
  return self.flags & 2;
}

function set_target_in_view(var0) {
  if(var0) {
    self.flags |= 1;
    return;
  }

  self.flags &= ~1;
}

function is_target_in_view() {
  return self.flags & 1;
}

function set_real_fire(var0) {
  if(var0) {
    self.flags |= 32;
    return;
  }

  self.flags &= ~32;
}

function should_real_fire() {
  return self.flags & 32;
}

function set_ignore_claimed(var0) {
  if(var0) {
    self.flags |= 64;
    return;
  }

  self.flags &= ~64;
}

function is_ignore_claimed() {
  return self.flags & 64;
}

function obstacle_in_way(var0) {
  if(var0) {
    self.flags |= 128;
    return;
  }

  self.flags &= ~128;
}

function is_obstacle_in_way() {
  return self.flags & 128;
}

function should_do_pain_anim() {
  return self.flags & 512;
}

function set_use_pain(var0) {
  if(var0) {
    self.flags |= 512;
    return;
  }

  self.flags &= ~512;
}

function was_recent_pain() {
  return self.flags & 2048;
}

function set_recent_pain(var0) {
  if(var0) {
    self.flags |= 2048;
    return;
  }

  self.flags &= ~2048;
}

function is_frantic() {
  return self.flags & 1024;
}

function set_frantic(var0) {
  if(var0) {
    self.flags |= 1024;
    return;
  }

  self.flags &= ~1024;
}

function trigger_fakeactor_move(var0) {
  if(!isDefined(self.targetname)) {
    return;
  }

  var1 = getEnt("target", self.targetname);

  for(;;) {
    var0 waittill("trigger", var2);
    set_wants_to_move(var1, 1);
  }
}

function trigger_fakeactor_node_disable(var0) {
  if(!isDefined(var0.targetname)) {
    return;
  }

  var1 = scripts\engine\utility::getStructArray(var0.targetname, "target");
  jumpiffalse(var1.size == 0) LOC_0000002a;
  return;
}

function trigger_fakeactor_node_enable(var0) {
  if(!isDefined(var0.targetname)) {
    return;
  }

  var1 = scripts\engine\utility::getStructArray(var0.targetname, "target");
  jumpiffalse(var1.size == 0) LOC_0000002a;
  return;
}

function trigger_fakeactor_node_enablegroup(var0) {
  jumpiftrue(isDefined(var0.script_parameters)) LOC_0000000f;
  return;
}

function trigger_fakeactor_node_disablegroup(var0) {
  jumpiftrue(isDefined(var0.script_parameters)) LOC_0000000f;
  return;
}

function trigger_fakeactor_node_passthrough(var0) {
  if(!isDefined(var0.targetname)) {
    return;
  }

  var1 = scripts\engine\utility::getStructArray(var0.targetname, "target");
  jumpiffalse(var1.size == 0) LOC_0000002a;
  return;
}

function trigger_fakeactor_node_lock(var0) {
  if(!isDefined(var0.targetname)) {
    return;
  }

  var1 = scripts\engine\utility::getStructArray(var0.targetname, "target");
  jumpiffalse(var1.size == 0) LOC_0000002a;
  return;
}

function is_higher_priority(var0, var1) {
  return var0["priority"] < var1["priority"];
}