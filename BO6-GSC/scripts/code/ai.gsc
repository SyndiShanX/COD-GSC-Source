/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\code\ai.gsc
**************************************/

#namespace ai;

function free_expendable() {
  if(!(isDefined(self.spawner) && isDefined(self.script_suspend))) {
    return;
  }

  spawner = self.spawner;
  struct = spawnStruct();
  struct.origin = self.origin;
  struct.angles = self.angles;
  struct.suspendtime = gettime();

  if(isDefined(self.suspendvars)) {
    struct.suspendvars = self.suspendvars;
  } else {
    struct.suspendvars = spawnStruct();
  }

  if(isDefined(self.stealth)) {
    struct.stealth = spawnStruct();
    struct.stealth.bsmstate = self.stealth_bsmstate;

    if(isDefined(self.var_d52986426f8538e6)) {
      struct.stealth.investigateevent = self[[self.var_d52986426f8538e6]]();
    }
  }

  if(isDefined(self.node)) {
    if(isDefined(self.using_goto_node)) {
      if(isDefined(self.node.targetname)) {
        struct.target = self.node.targetname;
      }

      struct.node = self.node;
    }

    struct.target = self.node.targetname;
  }

  spawner.suspended_ai = struct;

  if(isDefined(self.script_suspend_group) && !isDefined(self.script_free)) {
    free_groupname(self.script_suspend_group);
  }

  spawner thread function_23a4c78a328bc92d();
}

function free_groupname(groupname) {
  if(!isDefined(level.processfreegroupname)) {
    level.processfreegroupname = [];
  }

  if(isDefined(level.processfreegroupname[groupname])) {
    return;
  }

  level.processfreegroupname[groupname] = 1;
  aiarray = getaiarray();

  foreach(ai in aiarray) {
    if(ai == self) {
      continue;
    }

    if(!isDefined(ai.script_suspend_group)) {
      continue;
    }

    if(ai.script_suspend_group != groupname) {
      continue;
    }

    ai.script_free = 1;
    ai free_expendable();
    println("<dev string:x24>" + groupname + "<dev string:x39>" + ai.origin);
    ai delete();
  }

  level.processfreegroupname[groupname] = undefined;
}

function function_23a4c78a328bc92d(spawner) {
  self endon("<dev string:x46>");

  if(!isDefined(level.func)) {
    return;
  }

  if(!isDefined(level.func["<dev string:x4f>"])) {
    return;
  }

  while(true) {
    waitframe();

    if(!isDefined(self.suspended_ai)) {
      return;
    }

    if(getdvarint(@ "hash_6efeeea168f0a561") == 0) {
      continue;
    }

    [[level.func["<dev string:x4f>"]]](self.suspended_ai.origin, self.suspended_ai.angles, (1, 0.5, 0.25));
  }
}

function create_weapon_in_script(weaponarray, weaponposition) {
  if(!isDefined(level.fnscriptedweaponassignment)) {
    self.usescriptedweapon = undefined;

    if(!isDefined(weaponarray)) {
      weapon = nullweapon();
    } else if(!isarray(weaponarray) && weaponarray == "") {
      weapon = nullweapon();
    } else if(isarray(weaponarray)) {
      weapon = makeweapon(weaponarray[randomint(weaponarray.size)]);
    } else {
      weapon = makeweapon(weaponarray);
    }

    if(!isnullweapon(weapon)) {
      self.scriptedweaponfailed = 1;

      if(weaponposition == "sidearm") {
        self.scriptedweaponfailed_sidearmarray = weaponarray;
      } else {
        self.scriptedweaponfailed_primaryarray = weaponarray;
      }
    }

    println("<dev string:x5f>" + self getentitynumber() + "<dev string:x99>" + getweaponbasename(weapon));
    return weapon;
  }

  return [[level.fnscriptedweaponassignment]](weaponarray, weaponposition);
}

function stealth_callback(callbackname, ai, ...) {
  result = undefined;

  if(isDefined(level.stealth.var_8ef6173c91320106)) {
    result = ai[[level.stealth.var_8ef6173c91320106]](callbackname, flat_args(vararg, varargcount));
  }

  return istrue(result);
}

function event_handler[dormant_spawn] dormant_spawn_callback(charactertype, position, dormantindex, var_8735f083fb8a8924, isdemotion) {
  if(isDefined(level.var_5aededa530361e29)) {
    agent = [[level.var_5aededa530361e29]](charactertype, position, dormantindex, var_8735f083fb8a8924, isdemotion);

    if(getdvarint(@ "hash_c69456bc853363e0", 0) == 1) {
      if(isDefined(agent)) {
        if(var_8735f083fb8a8924) {
          function_9bd6c02089deac2a(dormantindex, agent);
        } else {
          function_aa71022c6ed6ce2f(dormantindex, agent);
        }

        return;
      }

      cleardormantaientry(dormantindex);
    }
  }
}

function event_handler[dormant_array] dormant_array_callback(dormantentries) {
  profilestart();

  foreach(entry in dormantentries) {
    dormant_callback(entry.agent, entry.var_6d63bc1fea0a37c2, entry.islw);
  }

  profilestop();
}

function event_handler[dormant] dormant_callback(ent, dormantindex, var_c2d1b1f57897b6ae) {
  profilestart();

  if(isDefined(level.var_da105458e50be04c)) {
    [[level.var_da105458e50be04c]](ent, dormantindex, var_c2d1b1f57897b6ae);
  }

  profilestop();
}

function function_b4580f2653b85d4a(dormantindex) {
  if(isDefined(level.var_124dbfaa01a4f18e)) {
    return [[level.var_124dbfaa01a4f18e]](dormantindex);
  }

  return 1;
}

function event_handler[lw_removed] function_e488df2f9197cf6e(lwid, killed) {
  if(isDefined(level.var_757a3c22b0e39a5a)) {
    [[level.var_757a3c22b0e39a5a]](lwid, killed);
  }
}

function function_fc89b37ddfe790d4(callbackname, requestid, data) {
  if(isDefined(level.var_b9c398f695ae40e2)) {
    return [[level.var_b9c398f695ae40e2]](callbackname, requestid, data);
  }
}

function event_handler[ai_vox] ai_vox_callback(ent, state) {
  if(isDefined(ent.var_b2ad1e9d78432fca)) {
    ent thread[[ent.var_b2ad1e9d78432fca]](state);
  }
}

function event_handler[savegame_loaded] function_6c45d91e0bcf28de() {
  function_e06b11e360a8cb9a();
}

function function_e06b11e360a8cb9a() {
  addaidatabaseentry("component", {
    #dummy: 1
  }, "script_components_begin", "script_components_begin");
  ai_cornercheck_behaviors_default = spawnStruct();
  ai_cornercheck_behaviors_default.m_specs[0] = spawnStruct();
  spec_default = ai_cornercheck_behaviors_default.m_specs[0];
  spec_default.name = "default";
  spec_default.query = spawnStruct();
  obj = spec_default.query;
  obj.sources = "cover, path";
  obj.var_5fc88b891007966a[0] = 64;
  obj.var_9a7e8752181545f = 300;
  obj.var_b75bd666b750d506 = 130;
  obj.var_3a8798f124412ab2 = 400;
  obj.var_a9533759c786cef7 = 300;
  spec_default.combined[0] = spawnStruct();
  obj = spec_default.combined[0];
  obj.types = "aim_only";
  obj.decelwindow = spawnStruct();
  obj.decelwindow.speed = 80;
  obj.decelwindow.types = "aim_only";
  obj.action = spawnStruct();
  obj.action.var_2694523c47f8cbd1 = 24;
  obj.action.var_9b8cc820dabefca4 = 90;
  obj.action.var_2f02497f06fa98ef = 90;
  obj.action.var_8ec4afa3bcfca724 = 32;
  obj.action.var_c3853dab8b90925e = 0.5;
  obj.validation = spawnStruct();
  obj.validation.var_63ab8914f23b2577 = 170;
  obj.validation.var_9b8cc820dabefca4 = 70;
  obj.validation.var_2f02497f06fa98ef = 70;
  obj.validation.var_8ec4afa3bcfca724 = 32;
  obj.validation.var_8737eca3e3b99ec = 60;
  obj.validation.var_bda46812fe9267d5 = 300;
  obj.validation.var_1fef55a1e386d44b = 200;
  spec_default.combined[1] = spawnStruct();
  obj = spec_default.combined[1];
  obj.types = "strafe_only";
  obj.decelwindow = spawnStruct();
  obj.decelwindow.speed = 60;
  obj.decelwindow.types = "strafe_only";
  obj.action = spawnStruct();
  obj.action.var_2694523c47f8cbd1 = 24;
  obj.action.var_9b8cc820dabefca4 = 180;
  obj.action.var_2f02497f06fa98ef = 120;
  obj.action.var_8ec4afa3bcfca724 = 32;
  obj.action.var_c3853dab8b90925e = 0;
  obj.validation = spawnStruct();
  obj.validation.var_63ab8914f23b2577 = 170;
  obj.validation.var_9b8cc820dabefca4 = 90;
  obj.validation.var_2f02497f06fa98ef = 90;
  obj.validation.var_8ec4afa3bcfca724 = 32;
  obj.validation.var_8737eca3e3b99ec = 60;
  obj.validation.var_bda46812fe9267d5 = 200;
  obj.validation.var_1fef55a1e386d44b = 200;
  obj.visibility = spawnStruct();
  obj.visibility.var_ac4746b229ea1b53 = 0;
  obj.visibility.var_427f1fd1a61c6e6e = 0;
  obj.visibility.var_15ae0e1b5ce70b68 = 0;
  obj.visibility.var_c70a00d0a48020cc = 1;
  obj.visibility.var_b2258f948f524ad7 = 1;
  obj.visibility.var_e4ddf62ce11d3bd7 = 1;
  spec_default.combined[2] = spawnStruct();
  obj = spec_default.combined[2];
  obj.types = "shallow";
  obj.decelwindow = spawnStruct();
  obj.decelwindow.speed = 49;
  obj.decelwindow.maxspeedvalid = 75;
  obj.decelwindow.types = "shallow";
  obj.action = spawnStruct();
  obj.action.var_2694523c47f8cbd1 = 24;
  obj.action.var_8ec4afa3bcfca724 = 32;
  obj.action.var_c3853dab8b90925e = 0;
  obj.animtest = spawnStruct();
  obj.animtest.planedistance_max = 48;
  obj.animtest.var_aad1fb6704dd3e74 = 1;
  obj.validation = spawnStruct();
  obj.validation.var_46ca1db72a9f8c11 = 75;
  obj.validation.var_63ab8914f23b2577 = 135;
  obj.validation.maxspeed = 50;
  obj.validation.asmstatename = "cautious_shallow_corner_check";
  obj.validation.var_8ec4afa3bcfca724 = 32;
  obj.validation.var_1fef55a1e386d44b = 80;
  spec_default.decelwindows[0] = spawnStruct();
  spec_default.decelwindows[0].types = "shallow";
  spec_default.decelwindows[0].speed = 80;
  spec_default.decelwindows[0].minspeedvalid = 75;
  spec_default.validations[0] = spawnStruct();
  obj = spec_default.validations[0];
  obj.types = "shallow";
  obj.asmstatename = "cornercheck_shallow_fast";
  obj.maxspeed = 90;
  obj.minspeed = 75;
  obj.var_46ca1db72a9f8c11 = 75;
  obj.var_63ab8914f23b2577 = 135;
  spec_default.var_f2728b4c1a5b5508 = 6;
  spec_counterattack_start = structcopy(spec_default, 1);
  ai_cornercheck_behaviors_default.m_specs[ai_cornercheck_behaviors_default.m_specs.size] = spec_counterattack_start;
  spec_counterattack_start.name = "counterattack_start";
  spec_counterattack_start.allowedtypes = "shallow";
  spec_counterattack_start.combined[1].visibility = spawnStruct();
  spec_counterattack_start.combined[1].visibility.types = "strafe_only";
  spec_counterattack_start.combined[1].visibility.var_ac4746b229ea1b53 = 0.3;
  spec_counterattack_start.combined[1].visibility.var_15ae0e1b5ce70b68 = 0.3;
  spec_counterattack_start.combined[1].decelwindow = spawnStruct();
  spec_counterattack_start.combined[1].decelwindow.speed = 90;
  spec_counterattack_start.combined[1].decelwindow.types = "strafe_only";
  spec_counterattack_start.combined[2].decelwindow = spawnStruct();
  spec_counterattack_start.combined[2].decelwindow.speed = 100;
  spec_counterattack_start.combined[2].decelwindow.maxspeedvalid = 120;
  spec_counterattack_start.combined[2].decelwindow.types = "shallow";
  spec_counterattack_start.combined[2].visibility = spawnStruct();
  spec_counterattack_start.combined[2].visibility.types = "shallow";
  spec_counterattack_start.combined[2].visibility.var_ac4746b229ea1b53 = 0.5;
  spec_counterattack_start.combined[2].visibility.var_15ae0e1b5ce70b68 = 0.5;
  spec_counterattack_start.combined[2].visibility.var_c70a00d0a48020cc = 1;
  spec_counterattack_start.combined[2].visibility.var_e4ddf62ce11d3bd7 = 1;
  spec = structcopy(spec_default, 1);
  ai_cornercheck_behaviors_default.m_specs[ai_cornercheck_behaviors_default.m_specs.size] = spec;
  spec.name = "soldier_paranoid";
  obj = spec.query;
  obj.var_5fc88b891007966a[0] = 64;
  obj.var_5fc88b891007966a[1] = 164;
  obj.var_9a7e8752181545f = 300;
  obj.var_b75bd666b750d506 = 130;
  obj.var_3a8798f124412ab2 = 200;
  obj.var_a9533759c786cef7 = 200;
  obj = spec.combined[0];
  obj.validation.var_63ab8914f23b2577 = 170;
  obj.validation.var_9b8cc820dabefca4 = 70;
  obj.validation.var_2f02497f06fa98ef = 70;
  obj.validation.var_8ec4afa3bcfca724 = 32;
  obj.validation.var_8737eca3e3b99ec = 60;
  obj.validation.var_bda46812fe9267d5 = 300;
  obj = spec.combined[1];
  obj.validation.var_63ab8914f23b2577 = 170;
  obj.validation.var_9b8cc820dabefca4 = 90;
  obj.validation.var_2f02497f06fa98ef = 90;
  obj.validation.var_8ec4afa3bcfca724 = 32;
  obj.validation.var_8737eca3e3b99ec = 60;
  obj.validation.var_bda46812fe9267d5 = 200;
  spec = structcopy(spec_default, 1);
  ai_cornercheck_behaviors_default.m_specs[ai_cornercheck_behaviors_default.m_specs.size] = spec;
  spec.name = "combat_default";
  obj = spec.combined[0];
  obj.decelwindow.types = "";
  obj = spec.combined[1];
  obj.decelwindow.types = "";
  obj = spec.combined[2];
  obj.decelwindow.types = "";
  spec = structcopy(spec_default, 1);
  ai_cornercheck_behaviors_default.m_specs[ai_cornercheck_behaviors_default.m_specs.size] = spec;
  spec.name = "check_doorways";
  spec.allowedtypes = "strafe_only";
  obj = spec.query;
  obj.var_b75bd666b750d506 = 180;
  obj.sources = "path";
  obj = spec.combined[1];
  obj.validation.var_8737eca3e3b99ec = 180;
  obj.validation.var_1fef55a1e386d44b = 300;
  obj.validation.var_919ee88d1cac77f2 = 9999;
  obj.validation.var_bda46812fe9267d5 = 9999;
  obj.visibility = spawnStruct();
  obj.visibility.var_ac4746b229ea1b53 = 0;
  obj.visibility.var_427f1fd1a61c6e6e = 0;
  obj.visibility.var_15ae0e1b5ce70b68 = 0;
  obj.visibility.var_c70a00d0a48020cc = 0;
  obj.visibility.var_b2258f948f524ad7 = 0;
  obj.visibility.var_e4ddf62ce11d3bd7 = 0;
  spec.actions[0] = spawnStruct();
  action = spec.actions[0];
  action.types = "strafe_only";
  action.var_2694523c47f8cbd1 = 8;
  action.var_cb8989ca1cda2f69 = 2;
  action.var_9b8cc820dabefca4 = 180;
  action.var_2f02497f06fa98ef = 120;
  action.var_8ec4afa3bcfca724 = 0;
  action.var_c3853dab8b90925e = 0;
  spec.var_9b57de8479d1fafa[0] = spawnStruct();
  visibility = spec.var_9b57de8479d1fafa[0];
  visibility.types = "strafe_only";
  visibility.var_ac4746b229ea1b53 = 0;
  visibility.var_427f1fd1a61c6e6e = 0;
  visibility.var_15ae0e1b5ce70b68 = 0;
  visibility.var_c70a00d0a48020cc = 0;
  visibility.var_b2258f948f524ad7 = 0;
  visibility.var_e4ddf62ce11d3bd7 = 0;
  spec.query.mindisttogoal = 0;
  spec.query.var_152a7ed8b562e525 = 0;
  spec = structcopy(spec_default, 1);
  ai_cornercheck_behaviors_default.m_specs[ai_cornercheck_behaviors_default.m_specs.size] = spec;
  spec.name = "elevator_exit";
  spec.allowedtypes = "shallow";
  obj = spec.query;
  obj.var_b75bd666b750d506 = 180;
  obj.sources = "cover";
  obj = spec.combined[2];
  obj.validation.var_8737eca3e3b99ec = 180;
  obj.validation.var_1fef55a1e386d44b = 300;
  obj.validation.var_919ee88d1cac77f2 = 9999;
  obj.validation.var_8ec4afa3bcfca724 = 0;
  obj.validation.var_46ca1db72a9f8c11 = 0;
  obj.validation.var_63ab8914f23b2577 = 180;
  obj.validation.maxspeed = 200;
  obj.action.var_8ec4afa3bcfca724 = 0;
  obj.visibility = spawnStruct();
  obj.visibility.var_ac4746b229ea1b53 = 0;
  obj.visibility.var_427f1fd1a61c6e6e = 0;
  obj.visibility.var_15ae0e1b5ce70b68 = 0;
  obj.visibility.var_c70a00d0a48020cc = 0;
  obj.visibility.var_b2258f948f524ad7 = 0;
  obj.visibility.var_e4ddf62ce11d3bd7 = 0;
  spec.var_9b57de8479d1fafa[0] = spawnStruct();
  visibility = spec.var_9b57de8479d1fafa[0];
  visibility.types = "shallow";
  visibility.var_ac4746b229ea1b53 = 0;
  visibility.var_427f1fd1a61c6e6e = 0;
  visibility.var_15ae0e1b5ce70b68 = 0;
  visibility.var_c70a00d0a48020cc = 0;
  visibility.var_b2258f948f524ad7 = 0;
  visibility.var_e4ddf62ce11d3bd7 = 0;
  spec.var_f2728b4c1a5b5508 = 0;
  spec.query.mindisttogoal = 0;
  spec.query.var_152a7ed8b562e525 = 0;
  spec = structcopy(spec_default, 1);
  ai_cornercheck_behaviors_default.m_specs[ai_cornercheck_behaviors_default.m_specs.size] = spec;
  spec.name = "elevator_exit_strafe";
  spec.allowedtypes = "strafe_only";
  obj = spec.query;
  obj.var_b75bd666b750d506 = 180;
  obj.sources = "cover";
  obj = spec.combined[1];
  obj.validation.var_8737eca3e3b99ec = 180;
  obj.validation.var_1fef55a1e386d44b = 300;
  obj.validation.var_919ee88d1cac77f2 = 9999;
  obj.visibility = spawnStruct();
  obj.visibility.var_ac4746b229ea1b53 = 0;
  obj.visibility.var_427f1fd1a61c6e6e = 0;
  obj.visibility.var_15ae0e1b5ce70b68 = 0;
  obj.visibility.var_c70a00d0a48020cc = 0;
  obj.visibility.var_b2258f948f524ad7 = 0;
  obj.visibility.var_e4ddf62ce11d3bd7 = 0;
  obj.decelwindow.speed = 90;
  spec.actions[0] = spawnStruct();
  action = spec.actions[0];
  action.types = "strafe_only";
  action.var_2694523c47f8cbd1 = 8;
  action.var_cb8989ca1cda2f69 = 2;
  action.var_9b8cc820dabefca4 = 180;
  action.var_2f02497f06fa98ef = 120;
  action.var_8ec4afa3bcfca724 = 0;
  action.var_c3853dab8b90925e = 0;
  spec.var_f2728b4c1a5b5508 = 0;
  spec.query.mindisttogoal = 0;
  spec.query.var_152a7ed8b562e525 = 0;
  spec = spawnStruct();
  ai_cornercheck_behaviors_default.m_specs[ai_cornercheck_behaviors_default.m_specs.size] = spec;
  spec.name = "test_everything";
  spec.query = spawnStruct();
  obj = spec.query;
  obj.sources = "cover, path";
  obj.var_5fc88b891007966a[0] = 64;
  obj.var_5fc88b891007966a[1] = 128;
  obj.var_5fc88b891007966a[3] = 200;
  obj.var_9a7e8752181545f = 300;
  obj.var_b75bd666b750d506 = 130;
  obj.var_3a8798f124412ab2 = 400;
  obj.var_a9533759c786cef7 = 300;
  spec.combined[0] = spawnStruct();
  obj = spec.combined[0];
  obj.types = "aim_only";
  obj.decelwindow = spawnStruct();
  obj.decelwindow.speed = 80;
  obj.decelwindow.types = "aim_only";
  obj.action = spawnStruct();
  obj.action.var_2694523c47f8cbd1 = 24;
  obj.action.var_9b8cc820dabefca4 = 90;
  obj.action.var_2f02497f06fa98ef = 90;
  obj.action.var_8ec4afa3bcfca724 = 32;
  obj.action.var_c3853dab8b90925e = 0.5;
  obj.validation = spawnStruct();
  obj.validation.var_63ab8914f23b2577 = 170;
  obj.validation.var_9b8cc820dabefca4 = 70;
  obj.validation.var_2f02497f06fa98ef = 70;
  obj.validation.var_8ec4afa3bcfca724 = 32;
  obj.validation.var_8737eca3e3b99ec = 180;
  obj.validation.var_bda46812fe9267d5 = 9999;
  obj.validation.var_919ee88d1cac77f2 = 9999;
  obj.validation.var_1fef55a1e386d44b = 500;
  spec.combined[1] = spawnStruct();
  obj = spec.combined[1];
  obj.types = "strafe_only";
  obj.decelwindow = spawnStruct();
  obj.decelwindow.speed = 60;
  obj.decelwindow.types = "strafe_only";
  obj.action = spawnStruct();
  obj.action.var_2694523c47f8cbd1 = 24;
  obj.action.var_9b8cc820dabefca4 = 180;
  obj.action.var_2f02497f06fa98ef = 120;
  obj.action.var_8ec4afa3bcfca724 = 32;
  obj.action.var_c3853dab8b90925e = 0;
  obj.validation = spawnStruct();
  obj.validation.var_63ab8914f23b2577 = 170;
  obj.validation.var_9b8cc820dabefca4 = 90;
  obj.validation.var_2f02497f06fa98ef = 90;
  obj.validation.var_8ec4afa3bcfca724 = 32;
  obj.validation.var_8737eca3e3b99ec = 180;
  obj.validation.var_bda46812fe9267d5 = 9999;
  obj.validation.var_919ee88d1cac77f2 = 9999;
  obj.validation.var_1fef55a1e386d44b = 500;
  obj.visibility = spawnStruct();
  obj.visibility.var_ac4746b229ea1b53 = 0;
  obj.visibility.var_427f1fd1a61c6e6e = 0;
  obj.visibility.var_15ae0e1b5ce70b68 = 0;
  obj.visibility.var_c70a00d0a48020cc = 1;
  obj.visibility.var_b2258f948f524ad7 = 1;
  obj.visibility.var_e4ddf62ce11d3bd7 = 1;
  spec.combined[2] = spawnStruct();
  obj = spec.combined[2];
  obj.types = "shallow";
  obj.decelwindow = spawnStruct();
  obj.decelwindow.speed = 49;
  obj.decelwindow.maxspeedvalid = 200;
  obj.decelwindow.types = "shallow";
  obj.action = spawnStruct();
  obj.action.var_2694523c47f8cbd1 = 24;
  obj.action.var_8ec4afa3bcfca724 = 32;
  obj.action.var_c3853dab8b90925e = 0;
  obj.animtest = spawnStruct();
  obj.animtest.planedistance_max = 48;
  obj.animtest.var_aad1fb6704dd3e74 = 1;
  obj.validation = spawnStruct();
  obj.validation.var_46ca1db72a9f8c11 = 75;
  obj.validation.var_63ab8914f23b2577 = 135;
  obj.validation.maxspeed = 50;
  obj.validation.var_8737eca3e3b99ec = 180;
  obj.validation.var_bda46812fe9267d5 = 9999;
  obj.validation.var_919ee88d1cac77f2 = 9999;
  obj.validation.asmstatename = "cautious_shallow_corner_check";
  obj.validation.var_8ec4afa3bcfca724 = 32;
  obj.validation.var_1fef55a1e386d44b = 500;
  spec.validations[0] = spawnStruct();
  obj = spec.validations[0];
  obj.types = "shallow";
  obj.asmstatename = "cornercheck_shallow_fast";
  obj.maxspeed = 90;
  obj.minspeed = 75;
  obj.var_46ca1db72a9f8c11 = 75;
  obj.var_63ab8914f23b2577 = 135;
  spec.var_f2728b4c1a5b5508 = 0;
  addaidatabaseentry("component", ai_cornercheck_behaviors_default, "ai_cornercheck_behaviors", "ai_cornercheck_behaviors_default_script");

  if(true) {
    defaultlookatspec = spawnStruct();
    obj = defaultlookatspec;

    if(true) {
      defaultlookatspec.var_775ace9931915a9a = "advanced_default";
      obj.limit_left = 120;
      obj.limit_right = 120;
      obj.limit_up = 80;
      obj.limit_down = 80;
    } else {
      defaultlookatspec.var_775ace9931915a9a = "simple";
      obj.limit_left = 60;
      obj.limit_right = 60;
      obj.limit_up = 45;
      obj.limit_down = 45;
    }

    ai_lookat_behaviors_default = spawnStruct();
    lookat_specs = [];
    obj = structcopy(defaultlookatspec, 1);
    lookat_specs[0] = obj;
    obj.name = "cover_right";
    obj.limit_left = 15;
    obj.limit_right = 30;
    obj.limit_up = 20;
    obj.limit_down = 30;
    obj = structcopy(defaultlookatspec, 1);
    lookat_specs[lookat_specs.size] = obj;
    obj.name = "cover_left";
    obj.limit_left = 60;
    obj.limit_right = 15;
    obj.limit_up = 20;
    obj.limit_down = 30;
    obj = structcopy(defaultlookatspec, 1);
    lookat_specs[lookat_specs.size] = obj;
    obj.name = "cover_crouch";
    obj.limit_left = 15;
    obj.limit_right = 45;
    obj.limit_up = 20;
    obj.limit_down = 30;
    obj = structcopy(defaultlookatspec, 1);
    lookat_specs[lookat_specs.size] = obj;
    obj.name = "exposed";
    obj = structcopy(defaultlookatspec, 1);
    lookat_specs[lookat_specs.size] = obj;
    obj.name = "default";
    obj = structcopy(lookat_specs[lookat_specs.size - 1], 1);
    lookat_specs[lookat_specs.size] = obj;
    obj.name = "advanced_default";
    obj.var_775ace9931915a9a = "advanced_default";
    obj = structcopy(defaultlookatspec, 1);
    lookat_specs[lookat_specs.size] = obj;
    obj.name = "exposed_aim";
    obj.limit_left = 20;
    obj.limit_right = 20;
    obj.limit_up = 30;
    obj.limit_down = 10;
    obj = structcopy(defaultlookatspec, 1);
    lookat_specs[lookat_specs.size] = obj;
    obj.name = "tight_with_player";
    obj.overridepercent = 100;
    obj.var_4eed6ae684e30035 = 0;
    obj = structcopy(defaultlookatspec, 1);
    lookat_specs[lookat_specs.size] = obj;
    obj.name = "default_no_spine";
    obj.limit_left = 60;
    obj.limit_right = 60;
    obj.limit_up = 45;
    obj.limit_down = 45;
    obj.var_420c8d665106cd91 = 1;
    obj = structcopy(defaultlookatspec, 1);
    lookat_specs[lookat_specs.size] = obj;
    obj.name = "animscripted_with_player";
    obj.limit_left = 90;
    obj.limit_right = 90;
    obj.limit_up = 45;
    obj.limit_down = 45;
    obj.var_222a59deee717cc9 = 1;
    obj.var_13d962ab5eece76e = 1;
    obj.autoclear = 1;
    obj.var_5cf36c6975d05ff9 = 1;
    obj.var_fead0eda3970133d = 1;
    obj = structcopy(defaultlookatspec, 1);
    lookat_specs[lookat_specs.size] = obj;
    obj.name = "full";
    obj.var_222a59deee717cc9 = 1;
    obj.var_13d962ab5eece76e = 1;
    obj.var_f692cded758c292d = 1;
    obj = structcopy(defaultlookatspec, 1);
    lookat_specs[lookat_specs.size] = obj;
    obj.name = "animscripted_with_player_eyes_only";
    obj.limit_left = 90;
    obj.limit_right = 90;
    obj.limit_up = 45;
    obj.limit_down = 45;
    obj.var_222a59deee717cc9 = 1;
    obj.var_13d962ab5eece76e = 1;
    obj.eyesonly = 1;
    obj.autoclear = 1;
    obj.var_5cf36c6975d05ff9 = 1;
    obj = structcopy(defaultlookatspec, 1);
    lookat_specs[lookat_specs.size] = obj;
    obj.name = "safehouse_1_woods";
    obj.limit_left = 90;
    obj.limit_right = 90;
    obj.limit_up = 90;
    obj.limit_down = 90;
    obj.var_222a59deee717cc9 = 1;
    obj.var_13d962ab5eece76e = 0;
    obj.autoclear = 1;
    obj.var_5cf36c6975d05ff9 = 1;
    obj.var_fead0eda3970133d = 1;
    obj.overridespeed = "casual_planned";
    obj.overridepercent = 100;
    obj = structcopy(defaultlookatspec, 1);
    lookat_specs[lookat_specs.size] = obj;
    obj.name = "safehouse_1_marshall";
    obj.limit_left = 90;
    obj.limit_right = 90;
    obj.limit_up = 90;
    obj.limit_down = 90;
    obj.var_222a59deee717cc9 = 1;
    obj.var_13d962ab5eece76e = 0;
    obj.autoclear = 1;
    obj.var_5cf36c6975d05ff9 = 1;
    obj.var_fead0eda3970133d = 1;
    obj.overridespeed = "casual_planned";
    obj = structcopy(defaultlookatspec, 1);
    lookat_specs[lookat_specs.size] = obj;
    obj.name = "animscripted_with_player_eyes_animated";
    obj.limit_left = 90;
    obj.limit_right = 90;
    obj.limit_up = 45;
    obj.limit_down = 45;
    obj.var_222a59deee717cc9 = 1;
    obj.var_13d962ab5eece76e = 1;
    obj.autoclear = 1;
    obj.var_5cf36c6975d05ff9 = 1;
    obj.var_fead0eda3970133d = 1;
    obj.eyesanimated = 1;
    ai_lookat_behaviors_default.m_specs = lookat_specs;
    addaidatabaseentry("component", ai_lookat_behaviors_default, "ai_lookat_behaviors", "ai_lookat_behaviors_default_script");
  }

  if(true) {
    ai_lookat_anim_mappings_default = spawnStruct();
    ai_lookat_anim_mappings_default.var_6e4d1957ea521616[0] = spawnStruct();
    ai_lookat_anim_mappings_default.var_6e4d1957ea521616[0].mappedname = "cover_right";
    ai_lookat_anim_mappings_default.var_6e4d1957ea521616[0].m_animnames[0] = "cover_right_crouch";
    ai_lookat_anim_mappings_default.var_6e4d1957ea521616[0].m_animnames[1] = "cover_right";
    ai_lookat_anim_mappings_default.var_6e4d1957ea521616[1] = spawnStruct();
    ai_lookat_anim_mappings_default.var_6e4d1957ea521616[1].mappedname = "cover_left";
    ai_lookat_anim_mappings_default.var_6e4d1957ea521616[1].m_animnames[0] = "cover_left_crouch";
    ai_lookat_anim_mappings_default.var_6e4d1957ea521616[1].m_animnames[1] = "cover_left";
    ai_lookat_anim_mappings_default.var_6e4d1957ea521616[2] = spawnStruct();
    ai_lookat_anim_mappings_default.var_6e4d1957ea521616[2].mappedname = "cover_crouch";
    ai_lookat_anim_mappings_default.var_6e4d1957ea521616[2].m_animnames[0] = "cover_crouch";
    ai_lookat_anim_mappings_default.var_6e4d1957ea521616[3] = spawnStruct();
    ai_lookat_anim_mappings_default.var_6e4d1957ea521616[3].mappedname = "exposed";
    arr[0] = "cover_right_crouch_stand";
    arr[arr.size] = "cover_right_crouch_exposed_left";
    arr[arr.size] = "cover_right_crouch_exposed_right";
    arr[arr.size] = "cover_left_crouch_stand";
    arr[arr.size] = "cover_left_crouch_exposed_left";
    arr[arr.size] = "cover_left_crouch_exposed_right";
    arr[arr.size] = "cover_left_crouch_exposed_a";
    arr[arr.size] = "cover_left_crouch_exposed_b";
    arr[arr.size] = "cover_right_crouch_exposed_a";
    arr[arr.size] = "cover_right_crouch_exposed_b";
    arr[arr.size] = "cover_left_exposed_a";
    arr[arr.size] = "cover_left_exposed_b";
    arr[arr.size] = "cover_right_exposed_a";
    arr[arr.size] = "cover_right_exposed_b";
    arr[arr.size] = "exposed_idle";
    arr[arr.size] = "cover_stand";
    ai_lookat_anim_mappings_default.var_6e4d1957ea521616[3].m_animnames = arr;
    addaidatabaseentry("component", ai_lookat_anim_mappings_default, "ai_lookat_anim_mappings", "ai_lookat_anim_mappings_default_script");
  }

  if(true) {
    ai_jailer_settings_default = spawnStruct();
    ai_jailer_settings_default.m_settings[0] = spawnStruct();
    ai_jailer_settings_default.m_settings[0].name = "default";
    ai_jailer_settings_default.m_settings[0].minaccuracy = getdvarfloat(@ "hash_f8240d5c0c37ac7e", 0.4);
    ai_jailer_settings_default.m_settings[0].maxaccuracy = getdvarfloat(@ "hash_960bb94e318db890", 1.2);
    ai_jailer_settings_default.m_settings[0].walkspeed = 55;
    ai_jailer_settings_default.m_settings[0].jogspeed = 120;
    ai_jailer_settings_default.m_settings[0].runspeed = 200;
    ai_jailer_settings_default.m_settings[0].acceleration = 300;
    ai_jailer_settings_default.m_settings[0].deceleration = -300;
    ai_jailer_settings_default.m_settings[0].var_7ac9618fa0bf86b8 = 200;
    ai_jailer_settings_default.m_settings[0].var_9d14831499775508 = 300;
    ai_jailer_settings_default.m_settings[0].var_e5f7cbdc7e792e1d = 550;
    ai_jailer_settings_default.m_settings[0].var_14a722ed4c89f92d = 700;
    ai_jailer_settings_default.m_settings[0].var_f459dc50245e93bc = 1000;
    ai_jailer_settings_default.m_settings[0].var_80393534016e3fb6 = 0;
    ai_jailer_settings_default.m_settings[0].stopdistance = 20;
    ai_jailer_settings_default.m_settings[0].jogduration = 1500;
    ai_jailer_settings_default.m_settings[0].var_978e4934529f64aa = 1000;
    ai_jailer_settings_default.m_settings[0].chargecooldown = 3000;
    ai_jailer_settings_default.m_settings[0].var_5499a0de2fb80a0 = 4000;
    ai_jailer_settings_default.m_settings[0].var_813c16d5eb2cd957 = 2000;
    ai_jailer_settings_default.m_settings[0].var_2b3502ecc115853e = 100;
    ai_jailer_settings_default.m_settings[0].maxsweepduration = 4000;
    ai_jailer_settings_default.m_settings[0].sweepcooldownduration = 10000;
    ai_jailer_settings_default.m_settings[0].clustermaxdist = 512;
    ai_jailer_settings_default.m_settings[0].var_153356639ec09d1d = 0.86;
    ai_jailer_settings_default.m_settings[0].var_b3a0a7c2bdb357bb = 200;
    ai_jailer_settings_default.m_settings[0].var_1c5682f4b66f9133 = 2500;
    ai_jailer_settings_default.m_settings[0].var_a34e380be655389c = 7000;
    ai_jailer_settings_default.m_settings[0].maxburstduration = 8000;
    ai_jailer_settings_default.m_settings[0].var_b158a8d552aeb04a = 1000;
    ai_jailer_settings_default.m_settings[0].var_d23543a959fb9f3c = 1250;
    ai_jailer_settings_default.m_settings[0].var_518f333adf467a66 = 200;
    ai_jailer_settings_default.m_settings[0].var_3c8dddd71a53cf04 = 300;
    ai_jailer_settings_default.m_settings[0].var_e08e9b87efbd54b7 = 600;
    ai_jailer_settings_default.m_settings[0].var_18197933592c0539 = 50;
    ai_jailer_settings_default.m_settings[0].var_8606f04a8bd6e983 = 100;
    ai_jailer_settings_default.m_settings[0].var_d34dd3584ba5c948 = 200;
    ai_jailer_settings_default.m_settings[0].var_3594af9c655eeade = 300;
    addaidatabaseentry("component", ai_jailer_settings_default, "ai_jailer_settings", "ai_jailer_settings_default_script");
  }

  if(true) {
    ai_focus_behaviors_default = spawnStruct();
    ai_focus_behaviors_default.var_9723a93a909635f4[0] = spawnStruct();
    behaviorspec = ai_focus_behaviors_default.var_9723a93a909635f4[0];
    behaviorspec.name = "default";
    fsm_specs = [];
    obj = spawnStruct();
    fsm_specs[0] = obj;
    obj.name = "default";
    obj.var_a9738dc1e507e297 = "look_glance";
    obj.var_fcbef6a0c1f197a2 = "aim_default";
    obj.var_20dc26e551c0ec57 = "default";
    obj.var_f6288273555aa089 = "default";
    obj.var_2d173ab4f5f3b320 = "default";
    obj.var_596905515e289c7a = "default";
    obj.var_3ae418154213104e = "default";
    obj = spawnStruct();
    fsm_specs[fsm_specs.size] = obj;
    obj.name = "panic";
    obj.var_a9738dc1e507e297 = "look_glance";
    obj.var_fcbef6a0c1f197a2 = "aim_default";
    obj.var_20dc26e551c0ec57 = "default";
    obj.var_f6288273555aa089 = "default";
    obj.var_2d173ab4f5f3b320 = "default";
    obj.var_596905515e289c7a = "default";
    obj.var_3ae418154213104e = "default";
    obj = spawnStruct();
    fsm_specs[fsm_specs.size] = obj;
    obj.name = "civ_default";
    obj.var_a9738dc1e507e297 = "look_glance";
    obj.var_fcbef6a0c1f197a2 = "aim_default";
    obj.var_20dc26e551c0ec57 = "default";
    obj.var_f6288273555aa089 = "civ_default";
    obj.var_2d173ab4f5f3b320 = "no_aim";
    obj.var_596905515e289c7a = "civ_default";
    obj.var_3ae418154213104e = "busy_with_others";
    obj = spawnStruct();
    fsm_specs[fsm_specs.size] = obj;
    obj.name = "zombie_default";
    obj.var_a9738dc1e507e297 = "look_glance";
    obj.var_fcbef6a0c1f197a2 = "aim_default";
    obj.var_20dc26e551c0ec57 = "default";
    obj.var_f6288273555aa089 = "default";
    obj.var_2d173ab4f5f3b320 = "zombie_default";
    obj.var_596905515e289c7a = "zombie_default";
    obj.var_3ae418154213104e = "default";
    obj = spawnStruct();
    fsm_specs[fsm_specs.size] = obj;
    obj.name = "ally_default";
    obj.var_a9738dc1e507e297 = "look_glance";
    obj.var_fcbef6a0c1f197a2 = "aim_default";
    obj.var_20dc26e551c0ec57 = "default";
    obj.var_f6288273555aa089 = "default";
    obj.var_2d173ab4f5f3b320 = "ally_default";
    obj.var_596905515e289c7a = "ally_default";
    obj.var_3ae418154213104e = "default";
    obj = spawnStruct();
    fsm_specs[fsm_specs.size] = obj;
    obj.name = "no_focus";
    obj.var_a9738dc1e507e297 = "look_glance";
    obj.var_fcbef6a0c1f197a2 = "aim_default";
    obj.var_20dc26e551c0ec57 = "default";
    obj.var_f6288273555aa089 = "default";
    obj.var_2d173ab4f5f3b320 = "no_aim";
    obj.var_596905515e289c7a = "no_look";
    obj.var_3ae418154213104e = "default";
    obj = spawnStruct();
    fsm_specs[fsm_specs.size] = obj;
    obj.name = "safehouse_1_woods";
    obj.var_a9738dc1e507e297 = "look_glance";
    obj.var_fcbef6a0c1f197a2 = "aim_default";
    obj.var_20dc26e551c0ec57 = "default";
    obj.var_f6288273555aa089 = "civ_default";
    obj.var_2d173ab4f5f3b320 = "no_aim";
    obj.var_596905515e289c7a = "safehouse_1_woods";
    obj.var_3ae418154213104e = "safehouse_1_woods";
    obj = spawnStruct();
    fsm_specs[fsm_specs.size] = obj;
    obj.name = "smoker";
    obj.var_a9738dc1e507e297 = "look_glance";
    obj.var_fcbef6a0c1f197a2 = "aim_default";
    obj.var_20dc26e551c0ec57 = "default";
    obj.var_f6288273555aa089 = "civ_default";
    obj.var_2d173ab4f5f3b320 = "no_aim";
    obj.var_596905515e289c7a = "smoker";
    obj.var_3ae418154213104e = "smoker";
    obj = spawnStruct();
    fsm_specs[fsm_specs.size] = obj;
    obj.name = "guard";
    obj.var_a9738dc1e507e297 = "look_glance";
    obj.var_fcbef6a0c1f197a2 = "aim_default";
    obj.var_20dc26e551c0ec57 = "default";
    obj.var_f6288273555aa089 = "civ_default";
    obj.var_2d173ab4f5f3b320 = "no_aim";
    obj.var_596905515e289c7a = "civ_no_poi_no_intelligent";
    obj.var_3ae418154213104e = "busy_with_others";
    behaviorspec.var_9b4720619fa13794 = fsm_specs;
    behaviorspec.var_c8665d2c41ba6d0d = [];
    obj = spawnStruct();
    behaviorspec.var_c8665d2c41ba6d0d[behaviorspec.var_c8665d2c41ba6d0d.size] = obj;
    obj.name = "default";
    obj.glanceinterval_min = -1;
    obj.glanceinterval_max = -1;
    obj.var_92551cc131a00a56 = 1000;
    obj.var_92780ec131c63344 = 2000;
    obj.var_c56807129a8654f5 = 1500;
    obj.var_c58af1129aac6c4b = 3000;
    obj.var_4c16d364e2aade43 = 1000;
    obj.var_a76931740e64f015 = 4000;
    obj.var_744746a8516c5620 = 1500;
    obj = spawnStruct();
    behaviorspec.var_c8665d2c41ba6d0d[behaviorspec.var_c8665d2c41ba6d0d.size] = obj;
    obj.name = "no_aim";
    obj.allowedsources = "none";
    obj.optimizationdistance = 500;
    obj = spawnStruct();
    behaviorspec.var_c8665d2c41ba6d0d[behaviorspec.var_c8665d2c41ba6d0d.size] = obj;
    obj.name = "zombie_default";
    obj.allowedsources = "enemy, path, script_explicit, code_explicit";
    obj = spawnStruct();
    behaviorspec.var_c8665d2c41ba6d0d[behaviorspec.var_c8665d2c41ba6d0d.size] = obj;
    obj.name = "ally_default";
    obj.allowedsources = "script_explicit, code_explicit, enemy, path";
    behaviorspec.var_14d47e6af75951af = [];
    var_871b9ed7c1de4d1d = spawnStruct();
    obj = var_871b9ed7c1de4d1d;
    obj.name = "default";
    obj.glanceinterval_min = 1500;
    obj.glanceinterval_max = 3000;
    obj.var_92551cc131a00a56 = 1000;
    obj.var_92780ec131c63344 = 2000;
    obj.var_c56807129a8654f5 = 1500;
    obj.var_c58af1129aac6c4b = 3000;
    obj.var_4c16d364e2aade43 = 500;
    obj.var_a76931740e64f015 = 500;
    obj.var_744746a8516c5620 = 1500;
    behaviorspec.var_14d47e6af75951af[behaviorspec.var_14d47e6af75951af.size] = var_871b9ed7c1de4d1d;
    obj = structcopy(var_871b9ed7c1de4d1d, 1);
    behaviorspec.var_14d47e6af75951af[behaviorspec.var_14d47e6af75951af.size] = obj;
    obj.name = "no_look";
    obj.allowedsources = "none";
    obj.optimizationdistance = 500;
    obj = structcopy(var_871b9ed7c1de4d1d, 1);
    behaviorspec.var_14d47e6af75951af[behaviorspec.var_14d47e6af75951af.size] = obj;
    obj.name = "no_focus";
    obj.allowedsources = "none";
    obj.optimizationdistance = 500;
    obj = structcopy(var_871b9ed7c1de4d1d, 1);
    behaviorspec.var_14d47e6af75951af[behaviorspec.var_14d47e6af75951af.size] = obj;
    obj.name = "zombie_default";
    obj.allowedsources = "enemy, path, script_explicit, code_explicit";
    obj = structcopy(var_871b9ed7c1de4d1d, 1);
    behaviorspec.var_14d47e6af75951af[behaviorspec.var_14d47e6af75951af.size] = obj;
    obj.name = "civ_default";
    obj.allowedsources = "poi_npc, player, enemy, path, script_explicit, code_explicit, intelligent_anim, civilian_manager";
    obj.requestedsources = "poi_npc, player, intelligent_anim";
    obj.glanceinterval_min = 0;
    obj.glanceinterval_max = 0;
    obj.var_92551cc131a00a56 = 1000;
    obj.var_92780ec131c63344 = 2000;
    obj.var_c56807129a8654f5 = 1500;
    obj.var_c58af1129aac6c4b = 3000;
    obj.var_f76a7b0786ddb394 = "intelligent_anim";
    obj.var_20dc26e551c0ec57 = "intelligent_anim";
    obj.optimizationdistance = 500;
    obj = structcopy(var_871b9ed7c1de4d1d, 1);
    behaviorspec.var_14d47e6af75951af[behaviorspec.var_14d47e6af75951af.size] = obj;
    obj.name = "ai_default";
    obj = structcopy(var_871b9ed7c1de4d1d, 1);
    behaviorspec.var_14d47e6af75951af[behaviorspec.var_14d47e6af75951af.size] = obj;
    obj.name = "explicit_only";
    obj.allowedsources = "script_explicit, code_explicit";
    obj.requestedsources = "none";
    obj = structcopy(var_871b9ed7c1de4d1d, 1);
    behaviorspec.var_14d47e6af75951af[behaviorspec.var_14d47e6af75951af.size] = obj;
    obj.name = "civ_no_poi";
    obj.allowedsources = "player, script_explicit, code_explicit, intelligent_anim";
    obj.requestedsources = "player, intelligent_anim";
    obj.optimizationdistance = 500;
    obj = structcopy(var_871b9ed7c1de4d1d, 1);
    behaviorspec.var_14d47e6af75951af[behaviorspec.var_14d47e6af75951af.size] = obj;
    obj.name = "civ_no_intelligent";
    obj.allowedsources = "poi_npc, player, enemy, path, script_explicit, code_explicit";
    obj.requestedsources = "poi_npc, player";
    obj.glanceinterval_min = 0;
    obj.glanceinterval_max = 0;
    obj.var_92551cc131a00a56 = 1000;
    obj.var_92780ec131c63344 = 2000;
    obj.var_c56807129a8654f5 = 1500;
    obj.var_c58af1129aac6c4b = 3000;
    obj.var_f76a7b0786ddb394 = "intelligent_anim";
    obj.var_20dc26e551c0ec57 = "intelligent_anim";
    obj.optimizationdistance = 500;
    obj = structcopy(var_871b9ed7c1de4d1d, 1);
    behaviorspec.var_14d47e6af75951af[behaviorspec.var_14d47e6af75951af.size] = obj;
    obj.name = "civ_no_poi_no_intelligent";
    obj.allowedsources = "player, script_explicit, code_explicit";
    obj.requestedsources = "player";
    obj.optimizationdistance = 500;
    obj = structcopy(var_871b9ed7c1de4d1d, 1);
    behaviorspec.var_14d47e6af75951af[behaviorspec.var_14d47e6af75951af.size] = obj;
    obj.name = "smoker";
    obj.allowedsources = "poi_npc, player, enemy, path, script_explicit, code_explicit";
    obj.requestedsources = "poi_npc, player";
    obj.optimizationdistance = 500;
    obj = structcopy(var_871b9ed7c1de4d1d, 1);
    behaviorspec.var_14d47e6af75951af[behaviorspec.var_14d47e6af75951af.size] = obj;
    obj.name = "safehouse_1_woods";
    obj.allowedsources = "player, script_explicit, code_explicit, intelligent_anim";
    obj.requestedsources = "player, intelligent_anim";
    obj = structcopy(var_871b9ed7c1de4d1d, 1);
    behaviorspec.var_14d47e6af75951af[behaviorspec.var_14d47e6af75951af.size] = obj;
    obj.name = "ally_default";
    obj.requestedsources = "player, random_directions";
    obj.var_fcd421f973216745 = "player, random_directions";
    obj = structcopy(var_871b9ed7c1de4d1d, 1);
    behaviorspec.var_14d47e6af75951af[behaviorspec.var_14d47e6af75951af.size] = obj;
    obj.name = "ally_animscripted_with_random";
    obj.allowedsources = "player, random_directions, script_explicit, code_explicit, intelligent_anim";
    obj.requestedsources = "player, random_directions";
    obj = structcopy(var_871b9ed7c1de4d1d, 1);
    behaviorspec.var_14d47e6af75951af[behaviorspec.var_14d47e6af75951af.size] = obj;
    obj.name = "ally_animscripted";
    obj.allowedsources = "player, script_explicit, code_explicit, intelligent_anim";
    obj.requestedsources = "player, intelligent_anim";
    var_b3d4f9f6c558123b = spawnStruct();
    angleranges = var_b3d4f9f6c558123b;
    angleranges.entity_relative = spawnStruct();
    angleranges.focus_relative = spawnStruct();
    angleranges.entity_relative.yaw_min = -90;
    angleranges.entity_relative.yaw_max = 90;
    angleranges.entity_relative.pitch_min = -2;
    angleranges.entity_relative.pitch_max = 2;
    angleranges.focus_relative.yaw_min = -90;
    angleranges.focus_relative.yaw_max = 90;
    angleranges.focus_relative.pitch_min = -45;
    angleranges.focus_relative.pitch_max = 45;
    behaviorspec.var_db8993aa517b6e64 = [];
    obj = spawnStruct();
    behaviorspec.var_db8993aa517b6e64[behaviorspec.var_db8993aa517b6e64.size] = obj;
    obj.name = "look_glance";
    obj.allowedsources = "all";
    obj.var_e5983fcd809cad8 = 60;
    obj.var_e7c99fcd83042f2 = 90;
    obj.angleranges = structcopy(var_b3d4f9f6c558123b, 1);
    obj.anglebias = 10;
    obj.var_e516e6c5456e8ba9 = 60;
    obj.maxyaw = 90;
    obj.mindistance = 0;
    obj.maxdistance = 9999;
    obj = spawnStruct();
    behaviorspec.var_db8993aa517b6e64[behaviorspec.var_db8993aa517b6e64.size] = obj;
    obj.name = "aim_default";
    obj.allowedsources = "all";
    obj.var_e5983fcd809cad8 = 0;
    obj.var_e7c99fcd83042f2 = 90;
    obj.angleranges = structcopy(var_b3d4f9f6c558123b, 1);
    obj.anglebias = 10;
    obj.var_e516e6c5456e8ba9 = 60;
    obj.maxyaw = 90;
    obj.mindistance = 0;
    obj.maxdistance = 9999;
    obj = spawnStruct();
    behaviorspec.var_db8993aa517b6e64[behaviorspec.var_db8993aa517b6e64.size] = obj;
    obj.name = "intelligent_anim";
    obj.allowedsources = "all";
    obj.var_e5983fcd809cad8 = 60;
    obj.var_e7c99fcd83042f2 = 90;
    obj.angleranges = structcopy(var_b3d4f9f6c558123b, 1);
    obj.angleranges.entity_relative.yaw_min = -179;
    obj.angleranges.entity_relative.yaw_max = 179;
    obj.angleranges.entity_relative.pitch_min = -90;
    obj.angleranges.entity_relative.pitch_max = 90;
    obj.angleranges.focus_relative.yaw_min = -45;
    obj.angleranges.focus_relative.yaw_max = 45;
    obj.angleranges.focus_relative.pitch_min = -45;
    obj.angleranges.focus_relative.pitch_max = 45;
    obj.anglebias = 10;
    obj.var_e516e6c5456e8ba9 = 60;
    obj.maxyaw = 90;
    obj.mindistance = 0;
    obj.maxdistance = 9999;
    behaviorspec.var_806f60d761d83dd5 = [];
    obj = spawnStruct();
    behaviorspec.var_806f60d761d83dd5[behaviorspec.var_806f60d761d83dd5.size] = obj;
    obj.name = "default";
    obj.allowedsources = "all";
    obj.angleranges = structcopy(var_b3d4f9f6c558123b, 1);
    obj.mindistance = 0;
    obj.maxdistance = 9999;
    behaviorspec.var_806f60d761d83dd5[1] = spawnStruct();
    obj = spawnStruct();
    behaviorspec.var_806f60d761d83dd5[behaviorspec.var_806f60d761d83dd5.size] = obj;
    obj.name = "intelligent_anim";
    obj.allowedsources = "all";
    obj.angleranges = structcopy(var_b3d4f9f6c558123b, 1);
    obj.angleranges.entity_relative.yaw_min = -179;
    obj.angleranges.entity_relative.yaw_max = 179;
    obj.angleranges.entity_relative.pitch_min = -90;
    obj.angleranges.entity_relative.pitch_max = 90;
    obj.angleranges.focus_relative.yaw_min = -60;
    obj.angleranges.focus_relative.yaw_max = 60;
    obj.angleranges.focus_relative.pitch_min = -60;
    obj.angleranges.focus_relative.pitch_max = 60;
    obj.mindistance = 0;
    obj.maxdistance = 9999;
    var_600e637b1281ab8b = spawnStruct();
    obj1 = var_600e637b1281ab8b;
    obj1.name = "default";
    obj1.sourcespecs[0] = spawnStruct();
    obj2 = obj1.sourcespecs[0];
    obj2.sources = "all";
    obj2.mindistance = 0;
    obj2.maxdistance = 512;
    obj2.minangle = -90;
    obj2.maxangle = 90;
    obj2.angleranges = structcopy(var_b3d4f9f6c558123b, 1);
    obj2.var_60daad6c127cd630 = "default";
    behaviorspec.var_12b12272535b65fb[0] = var_600e637b1281ab8b;
    behaviorspec.var_12b12272535b65fb[1] = spawnStruct();
    obj1 = behaviorspec.var_12b12272535b65fb[1];
    obj1.name = "civ_default";
    obj1.sourcespecs[0] = spawnStruct();
    obj2 = obj1.sourcespecs[0];
    obj2.sources = "poi_npc";
    obj2.mindistance = 0;
    obj2.maxdistance = 200;
    obj2.minangle = -90;
    obj2.maxangle = 90;
    obj2.angleranges = structcopy(var_b3d4f9f6c558123b, 1);
    obj2.var_60daad6c127cd630 = "default";
    obj1.sourcespecs[1] = spawnStruct();
    obj2 = obj1.sourcespecs[1];
    obj2.sources = "poi_ai_coordinator, poi_script, poi_nodes, poi_random_directions";
    obj2.mindistance = 0;
    obj2.maxdistance = 512;
    obj2.minangle = -90;
    obj2.maxangle = 90;
    obj2.angleranges = structcopy(var_b3d4f9f6c558123b, 1);
    obj2.var_60daad6c127cd630 = "default";
    behaviorspec.var_d14dfcb9d8d50144[0] = spawnStruct();
    obj = behaviorspec.var_d14dfcb9d8d50144[0];
    obj.name = "default";
    obj.startinginterest = 0;
    obj.var_6d13e1a7e963e2f1 = 700;
    obj.var_6d36f3a7e98a523f = 1400;
    obj.var_64092bd17f542fe0 = 2000;
    obj.var_63e641d17f2e188a = 3000;
    obj.timeout = 5000;
    obj.priority = "background";
    var_132b74fba26ac003 = spawnStruct();
    obj = var_132b74fba26ac003;
    obj.name = "default";
    var_a85797b80ab064f = spawnStruct();
    obj = var_a85797b80ab064f;
    obj.name = "default";
    obj.interval_min = 1000;
    obj.interval_max = 3000;
    obj.duration_combat = 1000;
    obj.duration_min = 1000;
    obj.duration_max = 3000;
    obj.var_c92646c27f488b6e = 0;
    obj.distance_max = 300;
    obj.var_461e24ede8caea40 = 60;
    obj.var_c1ad0e423bbd3a70 = 90;
    behaviorspec.var_9e640ced17b53082 = [];
    obj = structcopy(var_132b74fba26ac003, 1);
    behaviorspec.var_9e640ced17b53082[behaviorspec.var_9e640ced17b53082.size] = obj;
    obj.glancedefinitions = [];
    def = structcopy(var_a85797b80ab064f, 1);
    obj.glancedefinitions[obj.glancedefinitions.size] = def;
    obj = structcopy(var_132b74fba26ac003, 1);
    behaviorspec.var_9e640ced17b53082[behaviorspec.var_9e640ced17b53082.size] = obj;
    obj.name = "busy_with_others";
    obj.glancedefinitions = [];
    def = structcopy(var_a85797b80ab064f, 1);
    obj.glancedefinitions[obj.glancedefinitions.size] = def;
    def.name = "direct";
    def.interval_min = 1000;
    def.interval_max = 2000;
    def.duration_min = 750;
    def.duration_max = 1500;
    def.var_c92646c27f488b6e = 0;
    def.var_d6aff69033ef7be1 = 300;
    def.distance_max = 150;
    def.var_461e24ede8caea40 = 60;
    def.var_c1ad0e423bbd3a70 = 180;
    def.var_d6cd1c7ab7fbd38e = 60;
    def = structcopy(var_a85797b80ab064f, 1);
    obj.glancedefinitions[obj.glancedefinitions.size] = def;
    def.interval_min = 2000;
    def.interval_max = 4000;
    def.duration_min = 750;
    def.duration_max = 1500;
    def.var_c92646c27f488b6e = 0;
    def.distance_max = 200;
    def.var_461e24ede8caea40 = 60;
    def.var_c1ad0e423bbd3a70 = 90;
    obj = structcopy(var_132b74fba26ac003, 1);
    behaviorspec.var_9e640ced17b53082[behaviorspec.var_9e640ced17b53082.size] = obj;
    obj.name = "safehouse_1_woods";
    obj.glancedefinitions = [];
    def = structcopy(var_a85797b80ab064f, 1);
    obj.glancedefinitions[obj.glancedefinitions.size] = def;
    def.interval_min = 2000;
    def.interval_max = 4000;
    def.duration_min = 1000;
    def.duration_max = 2000;
    def.var_c92646c27f488b6e = 1000;
    def.distance_max = 200;
    def.var_461e24ede8caea40 = 60;
    def.var_c1ad0e423bbd3a70 = 180;
    def.var_d6cd1c7ab7fbd38e = 60;
    obj = structcopy(var_132b74fba26ac003, 1);
    behaviorspec.var_9e640ced17b53082[behaviorspec.var_9e640ced17b53082.size] = obj;
    obj.name = "safehouse_1_marshall";
    obj.glancedefinitions = [];
    def = structcopy(var_a85797b80ab064f, 1);
    obj.glancedefinitions[obj.glancedefinitions.size] = def;
    def.interval_min = 1500;
    def.interval_max = 3000;
    def.duration_min = 500;
    def.duration_max = 1000;
    def.var_c92646c27f488b6e = 500;
    def.distance_max = 200;
    def.var_461e24ede8caea40 = 60;
    def.var_c1ad0e423bbd3a70 = 180;
    def.var_d6cd1c7ab7fbd38e = 90;
    obj = structcopy(var_132b74fba26ac003, 1);
    behaviorspec.var_9e640ced17b53082[behaviorspec.var_9e640ced17b53082.size] = obj;
    obj.name = "smoker";
    obj.glancedefinitions = [];
    def = structcopy(var_a85797b80ab064f, 1);
    obj.glancedefinitions[obj.glancedefinitions.size] = def;
    def.interval_min = 1500;
    def.interval_max = 3000;
    def.duration_min = 750;
    def.duration_max = 1500;
    def.var_c92646c27f488b6e = 500;
    def.distance_max = 300;
    def.var_461e24ede8caea40 = 60;
    def.var_c1ad0e423bbd3a70 = 120;
    def.var_d6cd1c7ab7fbd38e = 60;
    addaidatabaseentry("component", ai_focus_behaviors_default, "ai_focus_behaviors", "ai_focus_behaviors_default_script");
  }

  if(false) {
    layout = spawnStruct();
    layout.fsm = {
      #variant_object: "default", #variant_type: "AIActionFSM"};
    states[0] = {
      #variant_object: {
        #name: "move_default"}, #variant_type: "AIMoveState_Default"};
    transitions[0] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_FindCornerCheckPos"}, #to_state: "corner_approach", #from_state: "move_default"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_ShouldStartApproachTraversal"}, #to_state: "traversal_approach", #from_state: "move_default"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_ASMStartedStrafe"}, #to_state: "strafe_engage_then_turn", #from_state: "move_default"};
    states[states.size] = {
      #variant_object: {
        #name: "animscripted"}, #variant_type: "AIMoveState_Animscripted"};
    states[states.size] = {
      #variant_object: {
        #name: "corner_approach"}, #variant_type: "AIMoveState_Corner_Approach"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_HasTargetVisibility"}, #to_state: "corner_to_combat", #from_state: "corner_approach"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_AbandonCornerCheck"}, #to_state: "move_default", #from_state: "corner_approach"};
    states[states.size] = {
      #variant_object: {
        #name: "corner_aim_only"}, #variant_type: "AIMoveState_Corner_AimOnly"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_HasTargetVisibility"}, #to_state: "corner_to_combat", #from_state: "corner_aim_only"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_AbandonCornerCheck"}, #to_state: "move_default", #from_state: "corner_aim_only"};
    states[states.size] = {
      #variant_object: {
        #name: "corner_strafe_only"}, #variant_type: "AIMoveState_Corner_StrafeOnly"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_HasTargetVisibility"}, #to_state: "corner_to_combat", #from_state: "corner_strafe_only"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_AbandonCornerCheck"}, #to_state: "move_default", #from_state: "corner_strafe_only"};
    states[states.size] = {
      #variant_object: {
        #name: "corner_slowing"}, #variant_type: "AIMoveState_Corner_Slowing"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_HasTargetVisibility"}, #to_state: "corner_to_combat", #from_state: "corner_slowing"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_FindCornerCheckPos"}, #to_state: "corner_approach", #from_state: "corner_slowing"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_AbandonCornerCheck"}, #to_state: "move_default", #from_state: "corner_slowing"};
    states[states.size] = {
      #variant_object: {
        #name: "corner_rounding_1"}, #variant_type: "AIMoveState_Corner_Rounding_1"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_HasTargetVisibility"}, #to_state: "corner_to_combat", #from_state: "corner_rounding_1"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_AbandonCornerCheck"}, #to_state: "move_default", #from_state: "corner_rounding_1"};
    states[states.size] = {
      #variant_object: {
        #name: "corner_rounding_2"}, #variant_type: "AIMoveState_Corner_Rounding_2"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_HasTargetVisibility"}, #to_state: "corner_to_combat", #from_state: "corner_rounding_2"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_AbandonCornerCheck"}, #to_state: "move_default", #from_state: "corner_rounding_2"};
    states[states.size] = {
      #variant_object: {
        #name: "corner_holding"}, #variant_type: "AIMoveState_Corner_Holding"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_HasTargetVisibility"}, #to_state: "corner_to_combat", #from_state: "corner_holding"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_AbandonCornerCheck"}, #to_state: "move_default", #from_state: "corner_holding"};
    states[states.size] = {
      #variant_object: {
        #name: "corner_asm"}, #variant_type: "AIMoveState_Corner_ASM"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_HasTargetVisibility"}, #to_state: "corner_to_combat", #from_state: "corner_asm"};
    states[states.size] = {
      #variant_object: {
        #name: "corner_to_combat"}, #variant_type: "AIMoveState_Corner_ToCombat"};
    states[states.size] = {
      #variant_object: {
        #name: "traversal_approach"}, #variant_type: "AIMoveState_Traversal_Approach"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_AbandonApproachTraversal"}, #to_state: "move_default", #from_state: "traversal_approach"};
    states[states.size] = {
      #variant_object: {
        #name: "strafe_engage_then_turn"}, #variant_type: "AIMoveState_Strafe_EngageThenTurn"};
    transitions[transitions.size] = {
      #transition: {
        #variant_object: "default", #variant_type: "AIMoveTransition_ShouldStartApproachTraversal"}, #to_state: "traversal_approach", #from_state: "strafe_engage_then_turn"};
    states[states.size] = {
      #variant_object: {
        #name: "strafe_short_path"}, #variant_type: "AIMoveState_Strafe_ShortPath"};
    states[states.size] = {
      #variant_object: {
        #name: "strafe_approach"}, #variant_type: "AIMoveState_Strafe_Approach"};
    states[states.size] = {
      #variant_object: {
        #name: "strafe_prepare_transition"}, #variant_type: "AIMoveState_Strafe_PrepareTransition"};
    states[states.size] = {
      #variant_object: {
        #name: "strafe_near_target"}, #variant_type: "AIMoveState_Strafe_Near_Target"};
    states[states.size] = {
      #variant_object: {
        #name: "strafe_forced"}, #variant_type: "AIMoveState_Strafe_Forced"};
    layout.states = states;
    layout.transitions = transitions;
    layout_component = {
      #script_layout: layout
    };
    addaidatabaseentry("component", layout_component, "fsm", "ai_action_fsm_script");
  }

  addaidatabaseentry("component", {
    #dummy: 1
  }, "script_components_finished", "script_components_finished");
}