/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\stealth\manager.gsc
***********************************************/

init_reset_ai() {
  self.pathenemylookahead = 50;
  self.pathenemyfightdist = 192;

  if(isDefined(self.script_grenades))
    self.grenadeammo = self.script_grenades;

  if(isDefined(self.primaryweapon))
    self.noattackeraccuracymod = _encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isasniper();

  self.neversprintforvariation = 1;
}

_id_13098(var_0) {
  if(isDefined(var_0.script_radius)) {
    self.goalradius = var_0.script_radius;
    return;
  }

  if(isDefined(var_0.script_forcegoal)) {
    if(isnode(var_0) && isDefined(var_0.radius)) {
      self.goalradius = var_0.radius;
      return;
    }
  }

  if(!isDefined(self getgoalvolume())) {
    if(self.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79") {
      return;
    }
    self.goalradius = level.default_goalradius;
  }
}

_id_13097(var_0) {
  if(isDefined(var_0.script_goalheight))
    self.goalheight = var_0.script_goalheight;
  else
    self.goalheight = level.default_goalheight;
}

spawn_think(var_0) {
  self.walkdist = 16;
  init_reset_ai();
  scripts\common\gameskill::default_door_node_flashbang_frequency();
  scripts\common\gameskill::grenadeawareness();
  spawn_think_script_inits(var_0);
  [[level.team_specific_spawn_functions[self.team]]]();
  _id_13097(var_0);

  if(isDefined(var_0.script_combatbehavior)) {
    if(var_0.script_combatbehavior == "_encstr_931904C66102")
      scripts\common\utility::enable_cqbwalk();
  }

  if(isDefined(var_0.script_playerseek)) {
    self setgoalentity(level.player);
    return;
  }

  if(isDefined(var_0.script_delayed_playerseek)) {
    if(!isDefined(var_0.script_radius))
      self.goalradius = 800;

    self setgoalentity(level.player);
    level thread delayed_player_seek_think(self);
    return;
  }

  if(isDefined(var_0.script_moveoverride) && var_0.script_moveoverride == 1) {
    _id_13098(var_0);
    self setgoalpos(self.origin);
    return;
  }

  _id_13098(var_0);

  if(isDefined(var_0.target)) {
    self.target = var_0.target;
    thread scripts\cp\laser_traps\cp_laser_traps::go_to_node();
  }
}

show_bad_path() {}

spawn_think_script_inits(var_0) {
  if(isDefined(var_0.script_dontshootwhilemoving))
    self.dontshootwhilemoving = 1;

  if(isDefined(var_0.script_attackeraccuracy))
    self.attackeraccuracy = var_0.script_attackeraccuracy;

  if(isDefined(var_0.script_nosurprise))
    scripts\cp\laser_traps\cp_laser_traps::disable_surprise();

  if(isDefined(var_0.script_nobloodpool))
    self.skipbloodpool = 1;

  if(isDefined(var_0.script_animname))
    self.animname = var_0.script_animname;

  if(isDefined(var_0.script_faceenemydist))
    self.maxfaceenemydist = var_0.script_faceenemydist;

  if(isDefined(var_0.dontdropweapon))
    self.dropweapon = 0;

  if(isDefined(var_0.script_fixednode))
    self.fixednode = var_0.script_fixednode == 1;

  self.providecoveringfire = self.team == "_encstr_9A8507BA4040188D08" && self.fixednode;

  if(isDefined(var_0.script_goalvolume) && !(isDefined(var_0.script_moveoverride) && var_0.script_moveoverride == 1))
    thread scripts\cp\laser_traps\cp_laser_traps::set_goal_volume();

  if(isDefined(var_0.script_accuracy))
    self.baseaccuracy = var_0.script_accuracy;

  if(isDefined(var_0.script_ignoreme))
    self.ignoreme = 1;

  if(isDefined(var_0.script_ignore_suppression))
    self.ignoresuppression = 1;

  if(isDefined(var_0.script_ignoreall)) {
    self.ignoreall = 1;
    self clearenemy();
  }

  if(isDefined(var_0.script_sightrange))
    self.maxsightdistsqrd = var_0.script_sightrange;

  if(isDefined(var_0.script_fightdist))
    self.pathenemyfightdist = var_0.script_fightdist;

  if(isDefined(var_0.script_maxdist))
    self.pathenemylookahead = var_0.script_maxdist;

  if(isDefined(var_0.script_longdeath)) {
    if(var_0.script_longdeath == 0)
      scripts\cp\laser_traps\cp_laser_traps::disable_long_death();
    else if(var_0.script_longdeath == 1)
      scripts\cp\laser_traps\cp_laser_traps::enable_long_death();
    else {
      scripts\cp\laser_traps\cp_laser_traps::enable_long_death();
      self.forcelongdeath = var_0.script_longdeath;
    }
  }

  if(isDefined(var_0.script_diequietly))
    self.diequietly = 1;

  if(isDefined(var_0.script_noragdoll))
    self.noragdoll = 1;

  if(isDefined(var_0.script_pacifist))
    self.pacifist = 1;

  if(isDefined(var_0.script_bulletshield))
    scripts\common\ai::magic_bullet_shield();

  if(isDefined(var_0.script_startinghealth))
    self.health = var_0.script_startinghealth;

  if(isDefined(var_0.script_startingposition))
    self.script_startingposition = var_0.script_startingposition;

  if(isDefined(var_0.script_nodrop))
    self.nodrop = var_0.script_nodrop;

  if(isDefined(var_0.script_noloot))
    self.noloot = var_0.script_noloot;

  if(isDefined(var_0.script_demeanor) && var_0.script_demeanor != "_encstr_8B1608EC43B8D647A113")
    scripts\common\utility::demeanor_override(var_0.script_demeanor);

  if(isDefined(var_0.script_bombplayer)) {
    self.bombertarget = level.player;
    self getenemyinfo(level.player);
  }

  if(isDefined(var_0.script_forcegoal))
    self.script_forcegoal = var_0.script_forcegoal;
}

run_spawn_functions(var_0) {
  var_1 = scripts\engine\utility::ter_op(isDefined(level.vehicle.spawn_functions_enable) && level.vehicle.spawn_functions_enable && self.code_classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56", self.script_team, self.team);

  if(isDefined(level.spawn_funcs[var_1])) {
    var_2 = level.spawn_funcs[var_1];

    foreach(var_4 in var_2) {
      if(isDefined(var_4["_encstr_BDD707C10BC90BDAD4"])) {
        thread[[var_4["_encstr_B2BB0998FB35773B1FAFF0"]]](var_4["_encstr_81D7070E2C93B0D613"], var_4["_encstr_ADD707F0EB707381A5"], var_4["_encstr_97D707ABD1FAFFA582"], var_4["_encstr_87D70783C22716D60D"], var_4["_encstr_BDD707C10BC90BDAD4"]);
        continue;
      }

      if(isDefined(var_4["_encstr_87D70783C22716D60D"])) {
        thread[[var_4["_encstr_B2BB0998FB35773B1FAFF0"]]](var_4["_encstr_81D7070E2C93B0D613"], var_4["_encstr_ADD707F0EB707381A5"], var_4["_encstr_97D707ABD1FAFFA582"], var_4["_encstr_87D70783C22716D60D"]);
        continue;
      }

      if(isDefined(var_4["_encstr_97D707ABD1FAFFA582"])) {
        thread[[var_4["_encstr_B2BB0998FB35773B1FAFF0"]]](var_4["_encstr_81D7070E2C93B0D613"], var_4["_encstr_ADD707F0EB707381A5"], var_4["_encstr_97D707ABD1FAFFA582"]);
        continue;
      }

      if(isDefined(var_4["_encstr_ADD707F0EB707381A5"])) {
        thread[[var_4["_encstr_B2BB0998FB35773B1FAFF0"]]](var_4["_encstr_81D7070E2C93B0D613"], var_4["_encstr_ADD707F0EB707381A5"]);
        continue;
      }

      if(isDefined(var_4["_encstr_81D7070E2C93B0D613"])) {
        thread[[var_4["_encstr_B2BB0998FB35773B1FAFF0"]]](var_4["_encstr_81D7070E2C93B0D613"]);
        continue;
      }

      thread[[var_4["_encstr_B2BB0998FB35773B1FAFF0"]]]();
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_4 in var_0) {
    if(isDefined(var_4["_encstr_BDD707C10BC90BDAD4"])) {
      thread[[var_4["_encstr_B2BB0998FB35773B1FAFF0"]]](var_4["_encstr_81D7070E2C93B0D613"], var_4["_encstr_ADD707F0EB707381A5"], var_4["_encstr_97D707ABD1FAFFA582"], var_4["_encstr_87D70783C22716D60D"], var_4["_encstr_BDD707C10BC90BDAD4"]);
      continue;
    }

    if(isDefined(var_4["_encstr_87D70783C22716D60D"])) {
      thread[[var_4["_encstr_B2BB0998FB35773B1FAFF0"]]](var_4["_encstr_81D7070E2C93B0D613"], var_4["_encstr_ADD707F0EB707381A5"], var_4["_encstr_97D707ABD1FAFFA582"], var_4["_encstr_87D70783C22716D60D"]);
      continue;
    }

    if(isDefined(var_4["_encstr_97D707ABD1FAFFA582"])) {
      thread[[var_4["_encstr_B2BB0998FB35773B1FAFF0"]]](var_4["_encstr_81D7070E2C93B0D613"], var_4["_encstr_ADD707F0EB707381A5"], var_4["_encstr_97D707ABD1FAFFA582"]);
      continue;
    }

    if(isDefined(var_4["_encstr_ADD707F0EB707381A5"])) {
      thread[[var_4["_encstr_B2BB0998FB35773B1FAFF0"]]](var_4["_encstr_81D7070E2C93B0D613"], var_4["_encstr_ADD707F0EB707381A5"]);
      continue;
    }

    if(isDefined(var_4["_encstr_81D7070E2C93B0D613"])) {
      thread[[var_4["_encstr_B2BB0998FB35773B1FAFF0"]]](var_4["_encstr_81D7070E2C93B0D613"]);
      continue;
    }

    thread[[var_4["_encstr_B2BB0998FB35773B1FAFF0"]]]();
  }
}

is_target_goal_valid(var_0) {
  if(isspawner(var_0))
    return 0;

  switch (var_0.code_classname) {
    case "_encstr_B1F70D1B2D73B2A790FB797D5088ED":
    case "_encstr_A70911F16A4C28BC9F231658BB53ED80A2DC6B":
    case "_encstr_956B0F193B6244C0659AE65B464C78857B":
    case "_encstr_97710C6B2DCD1BAF3AD54E4E598E":
      return 0;
  }

  return 1;
}

delayed_player_seek_think(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  while(isalive(var_0)) {
    if(var_0.goalradius > 200)
      var_0.goalradius = var_0.goalradius - 200;

    wait 6;
  }
}

go_to_node_internal(var_0, var_1, var_2) {
  self notify("_encstr_AFF5136B4BEAA2CF4A38B86349D06B40CED5D004B0");
  self endon("_encstr_AFF5136B4BEAA2CF4A38B86349D06B40CED5D004B0");
  self endon("_encstr_AD75063D571AE108");

  if(!isarray(var_0))
    var_0 = [var_0];

  var_3 = var_0[0];
  thread go_to_node_end();
  var_4 = 0;
  var_5 = undefined;

  for(;;) {
    if(!var_4) {
      var_0 = scripts\cp\laser_traps\cp_laser_traps::get_least_used_from_array(var_0);
      var_5 = get_path_array(var_0, var_3);
      self.patharray = var_5;
      self.patharrayindex = -1;

      if(var_5.size > 1)
        var_4 = 1;
    }

    self.currentnode = var_0;

    if(var_4) {
      var_0 = var_5[var_5.size - 1];
      go_through_patharray(var_5, var_1, var_2);
      var_5 = undefined;
      var_4 = 0;
    } else {
      node_fields_pre_goal(var_0);
      go_to_node_set_goal(var_0);
      self waittill("_encstr_8B7205D9ED5958");
    }

    var_0 notify("_encstr_8F5C086405E70FBA4B4A", self);
    node_fields_after_goal(var_0, var_1);
    var_0 scripts\engine\utility::script_delay();

    if(isDefined(var_0.script_flag_wait))
      scripts\engine\utility::flag_wait(var_0.script_flag_wait);

    if(isDefined(var_0.script_ent_flag_wait))
      scripts\engine\utility::ent_flag_wait(var_0.script_ent_flag_wait);

    var_0 scripts\engine\utility::script_wait();
    node_fields_after_goal_and_wait(var_0, var_2);

    if(!isDefined(var_0.target)) {
      break;
    }

    var_6 = get_target_goals(var_0.target);

    if(!var_6.size) {
      break;
    }

    var_0 = var_6;
  }

  self notify("_encstr_8DFD1123C0C1937233CDD112A7C9AA67E920F3");

  if(isDefined(self.script_forcegoal)) {
    return;
  }
  var_7 = self getgoalvolume();

  if(isDefined(var_7))
    self setgoalvolumeauto(var_7, var_7 scripts\cp\laser_traps\cp_laser_traps::get_cover_volume_forward());
  else
    self.goalradius = level.default_goalradius;
}

go_through_patharray(var_0, var_1, var_2) {
  self setgoalpath(var_0);

  foreach(var_6, var_4 in var_0) {
    node_fields_pre_goal(var_4);
    var_5 = waittill_subgoal();
    self.patharrayindex = var_5;

    if(isDefined(self.patharray) && !isDefined(self.patharrayindex))
      self.patharrayindex = self.patharray.size - 1;

    if(var_6 == var_0.size - 1) {
      self waittill("_encstr_8B7205D9ED5958");
      break;
    }

    var_4 notify("_encstr_8F5C086405E70FBA4B4A", self);
    node_fields_after_goal(var_4, var_1);
    node_fields_after_goal_and_wait(var_4, var_2);
  }
}

get_target_goals(var_0) {
  var_1 = getnodearray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2)
  var_1[var_1.size] = var_4;

  var_2 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2) {
    if(!is_target_goal_valid(var_4)) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

go_to_node_set_goal(var_0) {
  if(isnode(var_0))
    go_to_node_set_goal_node(var_0);
  else if(isstruct(var_0))
    go_to_node_set_goal_pos(var_0);
  else if(isent(var_0))
    go_to_node_set_goal_ent(var_0);

  if(isstruct(var_0) || isnode(var_0))
    var_0.patrol_stop = go_to_node_should_stop(var_0);
}

go_to_node_set_goal_ent(var_0) {
  if(var_0.code_classname == "_encstr_AC790C38CB1680D7038561F51D6A") {
    self setgoalvolumeauto(var_0, var_0 scripts\cp\laser_traps\cp_laser_traps::get_cover_volume_forward());
    self notify("_encstr_8D7214B7EFB943C8A1B03501B07195B76F5909F8D91C");
    return;
  }

  go_to_node_set_goal_pos(var_0);
}

go_to_node_set_goal_pos(var_0) {
  scripts\cp\laser_traps\cp_laser_traps::set_goal_ent(var_0);
  self notify("_encstr_8D7214B7EFB943C8A1B03501B07195B76F5909F8D91C");
}

go_to_node_set_goal_node(var_0) {
  scripts\cp\laser_traps\cp_laser_traps::set_goal_node(var_0);
  self notify("_encstr_8D7214B7EFB943C8A1B03501B07195B76F5909F8D91C");
}

go_to_node_end() {
  self endon("_encstr_AD75063D571AE108");
  self.using_goto_node = 1;
  scripts\engine\utility::_id_143A5("_encstr_8DFD1123C0C1937233CDD112A7C9AA67E920F3", "_encstr_AFF5136B4BEAA2CF4A38B86349D06B40CED5D004B0");
  self.using_goto_node = undefined;
  self.patharray = undefined;
  self.patharrayindex = undefined;
}

waittill_subgoal() {
  self endon("_encstr_8B7205D9ED5958");
  self waittill("_encstr_ADE70897C7523FBFBA1A", var_0);
  return var_0;
}

get_path_array(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  for(;;) {
    var_2[var_2.size] = var_0;
    var_3++;

    if(var_3 == 16) {
      break;
    }

    if(scripts\engine\utility::is_equal(var_0.code_classname, "_encstr_AC790C38CB1680D7038561F51D6A")) {
      break;
    }

    if(go_to_node_should_stop(var_0)) {
      break;
    }

    if(!isDefined(var_0.target)) {
      break;
    }

    var_4 = get_target_goals(var_0.target);

    if(!var_4.size) {
      break;
    }

    var_0 = scripts\cp\laser_traps\cp_laser_traps::get_least_used_from_array(var_4);

    if(var_0 == var_1) {
      break;
    }
  }

  return var_2;
}

go_to_node_should_stop(var_0) {
  if(!isDefined(var_0))
    return 1;

  if(!isDefined(var_0.target))
    return 1;

  if(isDefined(var_0.script_delay))
    return 1;

  if(isDefined(var_0.script_delay_min))
    return 1;

  if(isDefined(var_0.script_delay_max))
    return 1;

  if(isDefined(var_0.script_wait))
    return 1;

  if(isDefined(var_0.script_wait_add))
    return 1;

  if(isDefined(var_0.script_wait_min))
    return 1;

  if(isDefined(var_0.script_wait_max))
    return 1;

  if(isDefined(var_0.script_flag_wait))
    return 1;

  if(isDefined(var_0.script_ent_flag_wait))
    return 1;

  if(isDefined(var_0.script_delay_post))
    return 1;

  if(isDefined(var_0.script_idle))
    return 1;

  if(isDefined(var_0.script_stopnode))
    return 1;

  return 0;
}

node_fields_pre_goal(var_0) {
  if(isDefined(var_0.radius))
    self.goalradius = var_0.radius;

  if(isDefined(var_0.height))
    self.goalheight = var_0.height;

  if(isDefined(var_0.script_demeanor))
    scripts\common\utility::demeanor_override(var_0.script_demeanor);

  if(isDefined(var_0.script_civilian_state))
    scripts\asm\asm_bb::bb_setcivilianstate(var_0.script_civilian_state);

  if(isDefined(var_0.script_pacifist))
    self.pacifist = var_0.script_pacifist;

  if(isDefined(var_0.script_ignoreall))
    self.ignoreall = var_0.script_ignoreall;

  if(isDefined(var_0.script_ignoreme))
    self.ignoreme = var_0.script_ignoreme;

  if(isDefined(var_0.script_moveplaybackrate))
    scripts\cp\laser_traps\cp_laser_traps::set_moveplaybackrate(var_0.script_moveplaybackrate, 0.25);

  if(isDefined(var_0.script_speed))
    scripts\engine\utility::set_movement_speed(var_0.script_speed);

  if(isDefined(var_0.script_gunpose))
    scripts\common\ai::set_gunpose(var_0.script_gunpose);

  if(isDefined(var_0.script_disable_arrivals)) {
    if(var_0.script_disable_arrivals)
      scripts\common\ai::disable_arrivals();
    else
      self.disablearrivals = 0;
  }

  if(isDefined(var_0.script_disable_exits)) {
    if(var_0.script_disable_exits)
      scripts\common\ai::disable_exits();
    else
      scripts\common\ai::enable_exits();
  }
}

node_fields_after_goal(var_0, var_1) {
  if(isDefined(var_1))
    [[var_1]](var_0);

  if(isDefined(var_0.script_flag_set))
    scripts\engine\utility::flag_set(var_0.script_flag_set);

  if(isDefined(var_0.script_ent_flag_set))
    scripts\engine\utility::ent_flag_set(var_0.script_ent_flag_set);

  if(isDefined(var_0.script_ent_flag_clear))
    scripts\engine\utility::ent_flag_clear(var_0.script_ent_flag_clear);

  if(isDefined(var_0.script_flag_clear))
    scripts\engine\utility::flag_clear(var_0.script_flag_clear);
}

node_fields_after_goal_and_wait(var_0, var_1) {
  if(isDefined(var_0.script_soundalias))
    self playSound(var_0.script_soundalias);

  if(isDefined(self.post_wait_func))
    [[self.post_wait_func]]();

  if(isDefined(var_0.script_delay_post))
    wait(var_0.script_delay_post);

  if(isDefined(var_0.script_demeanor_post))
    scripts\common\utility::demeanor_override(var_0.script_demeanor_post);

  if(isDefined(var_1))
    [[var_1]](var_0);

  if(istrue(var_0.script_delete))
    scripts\cp\laser_traps\cp_laser_traps::ks_pointstowin();
}