/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\stealth\manager.gsc
***********************************************/

function init_reset_ai() {
  self.pathenemylookahead = 50;
  self.pathenemyfightdist = 192;

  if(isDefined(self.script_grenades)) {
    self.grenadeammo = self.script_grenades;
  }

  if(isDefined(self.primaryweapon)) {
    self.noattackeraccuracymod = scripts\anim\utility_common::isasniper();
  }

  self.neversprintforvariation = 1;
}

function ref_13098(var0) {
  if(isDefined(var0.script_radius)) {
    self.goalradius = var0.script_radius;
    return;
  }

  if(isDefined(var0.script_forcegoal)) {
    if(isnode(var0) && isDefined(var0.radius)) {
      self.goalradius = var0.radius;
      return;
    }
  }

  if(!isDefined(self getgoalvolume())) {
    if(self.unittype == "juggernaut") {
      return;
    }

    self.goalradius = level.default_goalradius;
    return;
  }
}

function ref_13097(var0) {
  if(isDefined(var0.script_goalheight)) {
    self.goalheight = var0.script_goalheight;
    return;
  }

  self.goalheight = level.default_goalheight;
}

function spawn_think(var0) {
  self.walkdist = 16;
  init_reset_ai();
  scripts\common\gameskill::default_door_node_flashbang_frequency();
  scripts\common\gameskill::grenadeawareness();
  spawn_think_script_inits(var0);
  [[level.team_specific_spawn_functions[self.team]]]();
  ref_13097(var0);

  if(isDefined(var0.script_combatbehavior)) {
    if(var0.script_combatbehavior == "cqb") {
      scripts\common\utility::enable_cqbwalk();
    }
  }

  if(isDefined(var0.script_playerseek)) {
    self setgoalentity(level.player);
    return;
  }

  if(isDefined(var0.script_delayed_playerseek)) {
    if(!isDefined(var0.script_radius)) {
      self.goalradius = 800;
    }

    self setgoalentity(level.player);
    thread delayed_player_seek_think(level);
    return;
  }

  if(isDefined(var0.script_moveoverride) && var0.script_moveoverride == 1) {
    ref_13098(var0);
    self setgoalpos(self.origin);
    return;
  }

  ref_13098(var0);

  if(isDefined(var0.target)) {
    self.target = var0.target;
    thread scripts\cp\laser_traps\cp_laser_traps::go_to_node();
    return;
  }
}

function show_bad_path() {}

function spawn_think_script_inits(var0) {
  if(isDefined(var0.script_dontshootwhilemoving)) {
    self.dontshootwhilemoving = 1;
  }

  if(isDefined(var0.script_attackeraccuracy)) {
    self.attackeraccuracy = var0.script_attackeraccuracy;
  }

  if(isDefined(var0.script_nosurprise)) {
    scripts\cp\laser_traps\cp_laser_traps::disable_surprise();
  }

  if(isDefined(var0.script_nobloodpool)) {
    self.skipbloodpool = 1;
  }

  if(isDefined(var0.script_animname)) {
    self.animname = var0.script_animname;
  }

  if(isDefined(var0.script_faceenemydist)) {
    self.maxfaceenemydist = var0.script_faceenemydist;
  }

  if(isDefined(var0.dontdropweapon)) {
    self.dropweapon = 0;
  }

  if(isDefined(var0.script_fixednode)) {
    self.fixednode = var0.script_fixednode == 1;
  }

  self.providecoveringfire = self.team == "allies" && self.fixednode;

  if(isDefined(var0.script_goalvolume) && !(isDefined(var0.script_moveoverride) && var0.script_moveoverride == 1)) {
    thread scripts\cp\laser_traps\cp_laser_traps::set_goal_volume();
  }

  if(isDefined(var0.script_accuracy)) {
    self.baseaccuracy = var0.script_accuracy;
  }

  if(isDefined(var0.script_ignoreme)) {
    self.ignoreme = 1;
  }

  if(isDefined(var0.script_ignore_suppression)) {
    self.ignoresuppression = 1;
  }

  if(isDefined(var0.script_ignoreall)) {
    self.ignoreall = 1;
    self clearenemy();
  }

  if(isDefined(var0.script_sightrange)) {
    self.maxsightdistsqrd = var0.script_sightrange;
  }

  if(isDefined(var0.script_fightdist)) {
    self.pathenemyfightdist = var0.script_fightdist;
  }

  if(isDefined(var0.script_maxdist)) {
    self.pathenemylookahead = var0.script_maxdist;
  }

  if(isDefined(var0.script_longdeath)) {
    if(var0.script_longdeath == 0) {
      scripts\cp\laser_traps\cp_laser_traps::disable_long_death();
    } else if(var0.script_longdeath == 1) {
      scripts\cp\laser_traps\cp_laser_traps::enable_long_death();
    } else {
      scripts\cp\laser_traps\cp_laser_traps::enable_long_death();
      self.forcelongdeath = var0.script_longdeath;
    }
  }

  if(isDefined(var0.script_diequietly)) {
    self.diequietly = 1;
  }

  if(isDefined(var0.script_noragdoll)) {
    self.noragdoll = 1;
  }

  if(isDefined(var0.script_pacifist)) {
    self.pacifist = 1;
  }

  if(isDefined(var0.script_bulletshield)) {
    scripts\common\ai::magic_bullet_shield();
  }

  if(isDefined(var0.script_startinghealth)) {
    self.health = var0.script_startinghealth;
  }

  if(isDefined(var0.script_startingposition)) {
    self.script_startingposition = var0.script_startingposition;
  }

  if(isDefined(var0.script_nodrop)) {
    self.nodrop = var0.script_nodrop;
  }

  if(isDefined(var0.script_noloot)) {
    self.noloot = var0.script_noloot;
  }

  if(isDefined(var0.script_demeanor) && var0.script_demeanor != "default") {
    scripts\common\utility::demeanor_override(var0.script_demeanor);
  }

  if(isDefined(var0.script_bombplayer)) {
    self.bombertarget = level.player;
    self getenemyinfo(level.player);
  }

  if(isDefined(var0.script_forcegoal)) {
    self.script_forcegoal = var0.script_forcegoal;
    return;
  }
}

function run_spawn_functions(var0) {
  var1 = scripts\engine\utility::ter_op(isDefined(level.vehicle.spawn_functions_enable) && level.vehicle.spawn_functions_enable && self.code_classname == "script_vehicle", self.script_team, self.team);

  if(isDefined(level.spawn_funcs[var1])) {
    var2 = level.spawn_funcs[var1];
    var3 = var2;
    var5 = getfirstarraykey(var3);

    if(isDefined(var5)) {
      var4 = var3[var5];

      if(isDefined(var4["param5"])) {
        GscBinSkip1(0x74, var4["function"], var4["param1"], var4["param2"], var4["param3"], var4["param4"], var4["param5"]);
      }

      if(isDefined(var4["param4"])) {
        GscBinSkip1(0x74, var4["function"], var4["param1"], var4["param2"], var4["param3"], var4["param4"]);
      }

      if(isDefined(var4["param3"])) {
        GscBinSkip1(0x74, var4["function"], var4["param1"], var4["param2"], var4["param3"]);
      }

      if(isDefined(var4["param2"])) {
        GscBinSkip1(0x74, var4["function"], var4["param1"], var4["param2"]);
      }

      if(isDefined(var4["param1"])) {
        GscBinSkip1(0x74, var4["function"], var4["param1"]);
      }

      GscBinSkip1(0x74, var4["function"]);
    }

    var3 = undefined;
    var5 = undefined;
  }

  if(!isDefined(var0)) {
    return;
  }

  var6 = var0;
  var7 = getfirstarraykey(var6);

  if(isDefined(var7)) {
    var4 = var6[var7];

    if(isDefined(var4["param5"])) {
      GscBinSkip1(0x74, var4["function"], var4["param1"], var4["param2"], var4["param3"], var4["param4"], var4["param5"]);
    }

    if(isDefined(var4["param4"])) {
      GscBinSkip1(0x74, var4["function"], var4["param1"], var4["param2"], var4["param3"], var4["param4"]);
    }

    if(isDefined(var4["param3"])) {
      GscBinSkip1(0x74, var4["function"], var4["param1"], var4["param2"], var4["param3"]);
    }

    if(isDefined(var4["param2"])) {
      GscBinSkip1(0x74, var4["function"], var4["param1"], var4["param2"]);
    }

    if(isDefined(var4["param1"])) {
      GscBinSkip1(0x74, var4["function"], var4["param1"]);
    }

    GscBinSkip1(0x74, var4["function"]);
  }

  var6 = undefined;
  var7 = undefined;
}

function is_target_goal_valid(var0) {
  if(isspawner(var0)) {
    return false;
  }

  switch (var0.code_classname) {
    case "trigger_once":
    case "trigger_multiple":
    case "trigger_radius":
    case "misc_turret":
      return false;
  }

  return true;
}

function delayed_player_seek_think(var0) {
  var0 endon("death");

  while(isalive(var0)) {
    if(var0.goalradius > 200) {
      var0.goalradius -= 200;
    }

    wait 6;
  }
}

function go_to_node_internal(var0, var1, var2) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("death");

  if(!isarray(var0)) {
    var0 = [var0];
  }

  var3 = var0[0];
  thread go_to_node_end();
  var4 = 0;
  var5 = undefined;

  for(;;) {
    if(!var4) {
      var0 = scripts\cp\laser_traps\cp_laser_traps::get_least_used_from_array(var0);
      var5 = get_path_array(var0, var3);
      self.patharray = var5;
      self.patharrayindex = -1;

      if(var5.size > 1) {
        var4 = 1;
      }
    }

    self.currentnode = var0;

    if(var4) {
      var0 = var5[var5.size - 1];
      go_through_patharray(var5, var1, var2);
      var5 = undefined;
      var4 = 0;
    } else {
      node_fields_pre_goal(var0);
      go_to_node_set_goal(var0);
      self waittill("goal");
    }

    var0 notify("trigger", self);
    node_fields_after_goal(var0, var1);
    var0 scripts\engine\utility::script_delay();

    if(isDefined(var0.script_flag_wait)) {
      scripts\engine\utility::flag_wait(var0.script_flag_wait);
    }

    if(isDefined(var0.script_ent_flag_wait)) {
      scripts\engine\utility::ent_flag_wait(var0.script_ent_flag_wait);
    }

    var0 scripts\engine\utility::script_wait();
    node_fields_after_goal_and_wait(var0, var2);

    if(!isDefined(var0.target)) {
      break;
    }

    var6 = get_target_goals(var0.target);

    if(!var6.size) {
      break;
    }

    var0 = var6;
  }

  self notify("reached_path_end");

  if(isDefined(self.script_forcegoal)) {
    return;
  }

  var7 = self getgoalvolume();

  if(isDefined(var7)) {
    self setgoalvolumeauto(var7, var7 scripts\cp\laser_traps\cp_laser_traps::get_cover_volume_forward());
    return;
  }

  self.goalradius = level.default_goalradius;
}

function go_through_patharray(var0, var1, var2) {
  self setgoalpath(var0);

  foreach(var4 in var0) {
    node_fields_pre_goal(var4);
    var5 = waittill_subgoal();
    self.patharrayindex = var5;

    if(isDefined(self.patharray) && !isDefined(self.patharrayindex)) {
      self.patharrayindex = self.patharray.size - 1;
    }

    if(var6 == var0.size - 1) {
      self waittill("goal");
      break;
    }

    var4 notify("trigger", self);
    node_fields_after_goal(var4, var1);
    node_fields_after_goal_and_wait(var4, var2);
  }
}

function get_target_goals(var0) {
  var1 = getnodearray(var0, "targetname");
  var2 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var4 in var2) {
    var1 = var4;
  }

  var2 = getEntArray(var0, "targetname");

  foreach(var4 in var2) {
    if(!is_target_goal_valid(var4)) {
      continue;
    }

    var1 = var4;
  }

  return var1;
}

function go_to_node_set_goal(var0) {
  if(isnode(var0)) {
    go_to_node_set_goal_node(var0);
  } else if(isstruct(var0)) {
    go_to_node_set_goal_pos(var0);
  } else if(isent(var0)) {
    go_to_node_set_goal_ent(var0);
  }

  if(isstruct(var0) || isnode(var0)) {
    var0.patrol_stop = go_to_node_should_stop(var0);
    return;
  }
}

function go_to_node_set_goal_ent(var0) {
  if(var0.code_classname == "info_volume") {
    self setgoalvolumeauto(var0, var0 scripts\cp\laser_traps\cp_laser_traps::get_cover_volume_forward());
    self notify("go_to_node_new_goal");
    return;
  }

  go_to_node_set_goal_pos(var0);
}

function go_to_node_set_goal_pos(var0) {
  scripts\cp\laser_traps\cp_laser_traps::set_goal_ent(var0);
  self notify("go_to_node_new_goal");
}

function go_to_node_set_goal_node(var0) {
  scripts\cp\laser_traps\cp_laser_traps::set_goal_node(var0);
  self notify("go_to_node_new_goal");
}

function go_to_node_end() {
  self endon("death");
  self.using_goto_node = 1;
  scripts\engine\utility::ref_143a5("reached_path_end", "stop_going_to_node");
  self.using_goto_node = undefined;
  self.patharray = undefined;
  self.patharrayindex = undefined;
}

function waittill_subgoal() {
  self endon("goal");
  self waittill("subgoal", var0);
  return var0;
}

function get_path_array(var0, var1) {
  var2 = [];
  var3 = 0;

  for(;;) {
    var2 = var0;
    var3++;

    if(var3 == 16) {
      break;
    }

    if(scripts\engine\utility::is_equal(var0.code_classname, "info_volume")) {
      break;
    }

    if(go_to_node_should_stop(var0)) {
      break;
    }

    if(!isDefined(var0.target)) {
      break;
    }

    var4 = get_target_goals(var0.target);

    if(!var4.size) {
      break;
    }

    var0 = scripts\cp\laser_traps\cp_laser_traps::get_least_used_from_array(var4);

    if(var0 == var1) {
      break;
    }
  }

  return var2;
}

function go_to_node_should_stop(var0) {
  if(!isDefined(var0)) {
    return true;
  }

  if(!isDefined(var0.target)) {
    return true;
  }

  if(isDefined(var0.script_delay)) {
    return true;
  }

  if(isDefined(var0.script_delay_min)) {
    return true;
  }

  if(isDefined(var0.script_delay_max)) {
    return true;
  }

  if(isDefined(var0.script_wait)) {
    return true;
  }

  if(isDefined(var0.script_wait_add)) {
    return true;
  }

  if(isDefined(var0.script_wait_min)) {
    return true;
  }

  if(isDefined(var0.script_wait_max)) {
    return true;
  }

  if(isDefined(var0.script_flag_wait)) {
    return true;
  }

  if(isDefined(var0.script_ent_flag_wait)) {
    return true;
  }

  if(isDefined(var0.script_delay_post)) {
    return true;
  }

  if(isDefined(var0.script_idle)) {
    return true;
  }

  if(isDefined(var0.script_stopnode)) {
    return true;
  }

  return false;
}

function node_fields_pre_goal(var0) {
  if(isDefined(var0.radius)) {
    self.goalradius = var0.radius;
  }

  if(isDefined(var0.height)) {
    self.goalheight = var0.height;
  }

  if(isDefined(var0.script_demeanor)) {
    scripts\common\utility::demeanor_override(var0.script_demeanor);
  }

  if(isDefined(var0.script_civilian_state)) {
    scripts\asm\asm_bb::bb_setcivilianstate(var0.script_civilian_state);
  }

  if(isDefined(var0.script_pacifist)) {
    self.pacifist = var0.script_pacifist;
  }

  if(isDefined(var0.script_ignoreall)) {
    self.ignoreall = var0.script_ignoreall;
  }

  if(isDefined(var0.script_ignoreme)) {
    self.ignoreme = var0.script_ignoreme;
  }

  if(isDefined(var0.script_moveplaybackrate)) {
    scripts\cp\laser_traps\cp_laser_traps::set_moveplaybackrate(var0.script_moveplaybackrate, 0.25);
  }

  if(isDefined(var0.script_speed)) {
    scripts\engine\utility::set_movement_speed(var0.script_speed);
  }

  if(isDefined(var0.script_gunpose)) {
    scripts\common\ai::set_gunpose(var0.script_gunpose);
  }

  if(isDefined(var0.script_disable_arrivals)) {
    if(var0.script_disable_arrivals) {
      scripts\common\ai::disable_arrivals();
    } else {
      self.disablearrivals = 0;
    }
  }

  if(isDefined(var0.script_disable_exits)) {
    if(var0.script_disable_exits) {
      scripts\common\ai::disable_exits();
      return;
    }

    scripts\common\ai::enable_exits();
    return;
  }
}

function node_fields_after_goal(var0, var1) {
  if(isDefined(var1)) {
    [[var1]](var0);
  }

  if(isDefined(var0.script_flag_set)) {
    scripts\engine\utility::flag_set(var0.script_flag_set);
  }

  if(isDefined(var0.script_ent_flag_set)) {
    scripts\engine\utility::ent_flag_set(var0.script_ent_flag_set);
  }

  if(isDefined(var0.script_ent_flag_clear)) {
    scripts\engine\utility::ent_flag_clear(var0.script_ent_flag_clear);
  }

  if(isDefined(var0.script_flag_clear)) {
    scripts\engine\utility::flag_clear(var0.script_flag_clear);
    return;
  }
}

function node_fields_after_goal_and_wait(var0, var1) {
  if(isDefined(var0.script_soundalias)) {
    self playSound(var0.script_soundalias);
  }

  if(isDefined(self.post_wait_func)) {
    [[self.post_wait_func]]();
  }

  if(isDefined(var0.script_delay_post)) {
    wait var0.script_delay_post;
  }

  if(isDefined(var0.script_demeanor_post)) {
    scripts\common\utility::demeanor_override(var0.script_demeanor_post);
  }

  if(isDefined(var1)) {
    [[var1]](var0);
  }

  if(istrue(var0.script_delete)) {
    scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
    return;
  }
}