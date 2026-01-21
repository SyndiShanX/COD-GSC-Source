/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\mp_agent.gsc
*********************************************/

init_agent(var_0) {
  level.agent_definition = [];
  level.agent_available_to_spawn_time = [];
  level.agent_recycle_interval = 500;
  var_1 = [];
  var_1["species"] = 3;
  var_1["traversal_unit_type"] = 4;
  var_1["body_model"] = 5;
  var_1["animclass"] = 6;
  var_1["health"] = 7;
  var_1["xp"] = 8;
  var_1["reward"] = 9;
  var_1["behaviorTree"] = 10;
  var_1["asm"] = 11;
  var_1["radius"] = 12;
  var_1["height"] = 13;
  var_2 = 0;
  var_3 = 50;
  for(var_4 = var_2; var_4 <= var_3; var_4++) {
    var_5 = tablelookupbyrow(var_0, var_4, 2);
    if(var_5 == "") {
      break;
    }

    var_6 = [];
    foreach(var_11, var_8 in var_1) {
      var_9 = tablelookupbyrow(var_0, var_4, var_8);
      if(var_9 == "0") {
        var_9 = 0;
      } else if(int(var_9) != 0) {
        var_10 = var_9 + "";
        if(issubstr(var_10, ".")) {
          var_9 = float(var_9);
        } else {
          var_9 = int(var_9);
        }
      }

      var_6[var_11] = var_9;
    }

    level.agent_definition[var_5] = var_6;
  }

  level notify("scripted_agents_initialized");
}

func_F8ED() {
  var_0 = level.agent_definition[self.agent_type];
  if(!isDefined(var_0["behaviorTree"]) || var_0["behaviorTree"] == "") {
    return;
  }

  scripts\mp\agents\_scriptedagents::func_197F(var_0["behaviorTree"], var_0["asm"]);
}

func_FAFA(var_0) {
  self.weapon = var_0;
  self giveweapon(var_0);
  self setspawnweapon(var_0);
  self.bulletsinclip = weaponclipsize(var_0);
  self.primaryweapon = var_0;
}

setup_spawn_struct(var_0) {
  self.spawner = var_0;
}

spawnnewagent(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getfreeagent(var_0);
  if(isDefined(var_6)) {
    if(!isDefined(var_3)) {
      var_3 = (0, 0, 0);
    }

    var_6.connecttime = gettime();
    if(isDefined(var_5)) {
      var_6 setup_spawn_struct(var_5);
    }

    var_6 set_agent_model(var_6, var_0);
    var_6 set_agent_species(var_6, var_0);
    if(is_scripted_agent(var_0)) {
      var_6 = spawn_scripted_agent(var_6, var_0, var_2, var_3);
    } else {
      var_6 = spawn_regular_agent(var_6, var_2, var_3);
    }

    var_6 setup_agent(var_0);
    var_6 set_agent_team(var_1);
    var_6 set_agent_spawn_health(var_6, var_0);
    var_6 set_agent_traversal_unit_type(var_6, var_0);
    var_6 addtocharactersarray();
    if(isDefined(var_4)) {
      var_6 func_FAFA(var_4);
    }

    if(func_9CF8(var_0)) {
      var_6 func_F8ED();
    }

    var_6 activateagent();
  }

  return var_6;
}

set_agent_traversal_unit_type(var_0, var_1) {
  if(!can_set_traversal_unit_type(var_0)) {
    return;
  }

  var_0 func_828C(level.agent_definition[var_1]["traversal_unit_type"]);
}

can_set_traversal_unit_type(var_0) {
  if(is_agent_scripted(var_0)) {
    return 1;
  }

  return 0;
}

set_agent_model(var_0, var_1) {
  var_2 = level.agent_definition[var_1]["setup_model_func"];
  if(isDefined(var_2)) {
    var_0[[var_2]](var_1);
    return;
  }

  var_0 detachall();
  var_0 setModel(level.agent_definition[var_1]["body_model"]);
  var_0 show();
}

is_scripted_agent(var_0) {
  return level.agent_definition[var_0]["animclass"] != "";
}

func_9CF8(var_0) {
  if(!isDefined(level.agent_definition[var_0])) {
    return 0;
  }

  return level.agent_definition[var_0]["behaviorTree"] != "";
}

spawn_scripted_agent(var_0, var_1, var_2, var_3) {
  var_0.onenteranimstate = var_0 speciesfunc("on_enter_animstate");
  var_0.is_scripted_agent = 1;
  var_4 = level.agent_definition[var_1]["radius"];
  if(!isDefined(var_4)) {
    var_4 = 15;
  }

  var_5 = level.agent_definition[var_1]["height"];
  if(!isDefined(var_5)) {
    var_5 = 50;
  }

  var_0 spawnagent(var_2, var_3, level.agent_definition[var_1]["animclass"], var_4, var_5);
  var_0.var_18F4 = var_5;
  var_0.var_18F9 = var_4;
  return var_0;
}

spawn_regular_agent(var_0, var_1, var_2) {
  var_0.is_scripted_agent = 0;
  var_0 spawnagent(var_1, var_2);
  return var_0;
}

is_agent_scripted(var_0) {
  return var_0.is_scripted_agent;
}

agent_go_to_pos(var_0, var_1, var_2, var_3, var_4) {
  if(is_agent_scripted(self)) {
    self ghostskulls_complete_status(var_0);
    return;
  }

  self botsetscriptgoal(var_0, var_1, var_2, var_3, var_4);
}

setup_agent(var_0) {
  var_1 = level.agent_definition[var_0];
  if(!isDefined(var_1)) {
    return;
  }

  var_2 = var_1["setup_func"];
  if(!isDefined(var_2)) {
    return;
  }

  self[[var_2]]();
}

set_agent_species(var_0, var_1) {
  if(!isDefined(level.agent_funcs[var_1])) {
    level.agent_funcs[var_1] = [];
  }

  var_0.species = level.agent_definition[var_1]["species"];
  if(!isDefined(level.species_funcs[var_0.species]) || !isDefined(level.species_funcs[var_0.species]["on_enter_animstate"])) {
    level.species_funcs[var_0.species] = [];
    level.species_funcs[var_0.species]["on_enter_animstate"] = ::func_5005;
  }

  assign_agent_func("spawn", ::default_spawn_func);
  assign_agent_func("on_damaged", ::default_on_damage);
  assign_agent_func("on_damaged_finished", ::default_on_damage_finished);
  assign_agent_func("on_killed", ::default_on_killed);
}

assign_agent_func(var_0, var_1) {
  var_2 = self.agent_type;
  if(!isDefined(level.agent_funcs[var_2][var_0])) {
    if(!isDefined(level.species_funcs[self.species]) || !isDefined(level.species_funcs[self.species][var_0])) {
      level.agent_funcs[var_2][var_0] = var_1;
      return;
    }

    level.agent_funcs[var_2][var_0] = level.species_funcs[self.species][var_0];
  }
}

set_agent_spawn_health(var_0, var_1) {
  var_0 set_agent_health(level.agent_definition[var_1]["health"]);
}

get_agent_type(var_0) {
  return var_0.agent_type;
}

getfreeagentcount() {
  if(!isDefined(level.agentarray)) {
    return 0;
  }

  var_0 = gettime();
  var_1 = 0;
  foreach(var_3 in level.agentarray) {
    if(!isDefined(var_3.isactive) || !var_3.isactive) {
      if(isDefined(var_3.waitingtodeactivate) && var_3.waitingtodeactivate) {
        continue;
      }

      var_4 = var_3 getentitynumber();
      if(isDefined(level.agent_available_to_spawn_time) && isDefined(level.agent_available_to_spawn_time[var_4]) && var_0 < level.agent_available_to_spawn_time[var_4]) {
        continue;
      }

      var_1++;
    }
  }

  return var_1;
}

getfreeagent(var_0) {
  var_1 = undefined;
  var_2 = gettime();
  if(isDefined(level.agentarray)) {
    foreach(var_4 in level.agentarray) {
      if(!isDefined(var_4.isactive) || !var_4.isactive) {
        if(isDefined(var_4.waitingtodeactivate) && var_4.waitingtodeactivate) {
          continue;
        }

        var_5 = var_4 getentitynumber();
        if(isDefined(level.agent_available_to_spawn_time) && isDefined(level.agent_available_to_spawn_time[var_5]) && var_2 < level.agent_available_to_spawn_time[var_5]) {
          continue;
        }

        level.agent_available_to_spawn_time[var_5] = undefined;
        var_1 = var_4;
        var_1.agent_type = var_0;
        var_1 initagentscriptvariables();
        var_1 notify("agent_in_use");
        break;
      }
    }
  }

  return var_1;
}

initagentscriptvariables() {
  self.pers = [];
  self.hasdied = 0;
  self.isactive = 0;
  self.spawntime = 0;
  self.entity_number = self getentitynumber();
  self.agent_gameparticipant = 0;
  self detachall();
  initplayerscriptvariables();
}

initplayerscriptvariables() {
  self.class = undefined;
  self.movespeedscaler = undefined;
  self.avoidkillstreakonspawntimer = undefined;
  self.guid = undefined;
  self.name = undefined;
  self.saved_actionslotdata = undefined;
  self.perks = undefined;
  self.weaponlist = undefined;
  self.objectivescaler = undefined;
  self.sessionteam = undefined;
  self.sessionstate = undefined;
  self.disabledweapon = undefined;
  self.disabledweaponswitch = undefined;
  self.disabledoffhandweapons = undefined;
  self.disabledusability = 1;
  self.nocorpse = undefined;
  self.ignoreme = 0;
  self.precacheleaderboards = 0;
  self.ten_percent_of_max_health = undefined;
  self.command_given = undefined;
  self.current_icon = undefined;
  self.do_immediate_ragdoll = undefined;
  if(isDefined(level.var_768B)) {
    self[[level.var_768B]]();
  }
}

set_agent_team(var_0, var_1) {
  self.team = var_0;
  self.var_20 = var_0;
  self.pers["team"] = var_0;
  self.owner = var_1;
  self setotherent(var_1);
  self setentityowner(var_1);
}

addtocharactersarray() {
  for(var_0 = 0; var_0 < level.characters.size; var_0++) {
    if(level.characters[var_0] == self) {
      return;
    }
  }

  level.characters[level.characters.size] = self;
}

agentfunc(var_0) {
  return level.agent_funcs[self.agent_type][var_0];
}

speciesfunc(var_0) {
  return level.species_funcs[self.species][var_0];
}

validateattacker(var_0) {
  if(isagent(var_0) && !isDefined(var_0.isactive) || !var_0.isactive) {
    return undefined;
  }

  if(isagent(var_0) && !isDefined(var_0.classname)) {
    return undefined;
  }

  return var_0;
}

set_agent_health(var_0) {
  self.var_1E = var_0;
  self.health = var_0;
  self.maxhealth = var_0;
}

default_spawn_func(var_0, var_1, var_2) {}

is_friendly_damage(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.team) && var_1.team == var_0.team) {
      return 1;
    }

    if(isDefined(var_1.owner) && isDefined(var_1.owner.team) && var_1.owner.team == var_0.team) {
      return 1;
    }
  }

  return 0;
}

default_on_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self;
  var_13 = level.agent_funcs[self.agent_type]["gametype_on_damaged"];
  if(isDefined(var_13)) {
    [[var_13]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }

  if(is_friendly_damage(var_12, var_0)) {
    return;
  }

  var_12[[level.agent_funcs[var_12.agent_type]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_10, var_11);
}

default_on_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self.health;
  if(isDefined(var_7)) {
    var_14 = vectortoyaw(var_7);
    var_15 = self.angles[1];
    self.var_E3 = angleclamp180(var_14 - var_15);
  } else {
    self.var_E3 = 0;
  }

  self.var_DD = var_8;
  self.var_DE = var_4;
  self.damagedby = var_1;
  self.var_DC = var_7;
  self.var_E1 = var_2;
  self.var_E2 = var_5;
  self.var_4D62 = var_6;
  self getrespawndelay(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_11, var_12);
  if(self.health > 0 && self.health < var_13) {
    self notify("pain");
  }

  if(isalive(self) && isDefined(self.agent_type)) {
    var_10 = level.agent_funcs[self.agent_type]["gametype_on_damage_finished"];
    if(isDefined(var_10)) {
      [[var_10]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    }
  }
}

default_on_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(level.var_C4BD)) {
    self[[level.var_C4BD]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
  } else {
    on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
  }

  var_9 = level.agent_funcs[self.agent_type]["gametype_on_killed"];
  if(isDefined(var_9)) {
    [[var_9]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  deactivateagent();
}

func_5005(var_0, var_1) {
  self.aistate = var_1;
  switch (var_1) {
    case "traverse":
      self.do_immediate_ragdoll = 1;
      lib_0F3C::func_5AC0();
      self.do_immediate_ragdoll = 0;
      break;

    default:
      break;
  }

  cleardamagehistory();
}

cleardamagehistory() {
  self.recentdamages = [];
  self.damagelistindex = 0;
}

deactivateagent() {
  var_0 = self getentitynumber();
  level.agent_available_to_spawn_time[var_0] = gettime() + 500;
}

getnumactiveagents(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  var_1 = getactiveagentsoftype(var_0);
  return var_1.size;
}

getactiveagentsoftype(var_0) {
  var_1 = [];
  if(!isDefined(level.agentarray)) {
    return var_1;
  }

  foreach(var_3 in level.agentarray) {
    if(isDefined(var_3.isactive) && var_3.isactive) {
      if(var_0 == "all" || var_3.agent_type == var_0) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

getaliveagentsofteam(var_0) {
  returnAgent = [];
  foreach(agent in level.agentarray) {
    if(isalive(agent) && isDefined(agent.team) && agent.team == var_0) {
      returnAgent[returnAgent.size] = agent;
    }
  }

  return returnAgent;
}

getactiveagentsofspecies(var_0) {
  var_1 = [];
  if(!isDefined(level.agentarray)) {
    return var_1;
  }

  foreach(var_3 in level.agentarray) {
    if(isDefined(var_3.isactive) && var_3.isactive) {
      if(var_3.species == var_0) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

getaliveagents() {
  var_0 = [];
  foreach(var_2 in level.agentarray) {
    if(isalive(var_2)) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

activateagent() {
  self.isactive = 1;
  self.spawn_time = gettime();
}

on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = self.var_164D[self.asmname].var_4BC0;
  var_11 = level.asm[self.asmname].states[var_10];
  if(scripts\asm\asm_mp::func_2382(self.asmname, var_11)) {
    scripts\asm\asm::func_231E(self.asmname, var_11, var_10);
  }

  if(isDefined(self.nocorpse)) {
    return;
  }

  var_12 = self;
  self.body = self getplayerviewmodelfrombody(var_8);
  if(should_do_immediate_ragdoll(self)) {
    do_immediate_ragdoll(self.body);
    return;
  }

  thread delaystartragdoll(self.body, var_6, var_5, var_4, var_0, var_3);
}

should_do_immediate_ragdoll(var_0) {
  if(isDefined(var_0.do_immediate_ragdoll) && var_0.do_immediate_ragdoll) {
    return 1;
  }

  return 0;
}

do_immediate_ragdoll(var_0) {
  if(isDefined(var_0)) {
    var_0 giverankxp();
  }
}

delaystartragdoll(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_0)) {
    var_6 = var_0 func_8112();
    if(animhasnotetrack(var_6, "ignore_ragdoll")) {
      return;
    }
  }

  if(isDefined(level.noragdollents) && level.noragdollents.size) {
    foreach(var_8 in level.noragdollents) {
      if(distancesquared(var_0.origin, var_8.origin) < 65536) {
        return;
      }
    }
  }

  wait(0.2);
  if(!isDefined(var_0)) {
    return;
  }

  if(var_0 func_81B7()) {
    return;
  }

  var_6 = var_0 func_8112();
  var_10 = 0.35;
  if(animhasnotetrack(var_6, "start_ragdoll")) {
    var_11 = getnotetracktimes(var_6, "start_ragdoll");
    if(isDefined(var_11)) {
      var_10 = var_11[0];
    }
  }

  var_12 = var_10 * getanimlength(var_6) - 0.2;
  if(var_12 > 0) {
    wait(var_12);
  }

  if(isDefined(var_0)) {
    if(isDefined(var_0.ragdollhitloc) && isDefined(var_0.ragdollimpactvector)) {
      var_0 giverankxp_regularmp(var_0.ragdollhitloc, var_0.ragdollimpactvector);
      return;
    }

    var_0 giverankxp();
  }
}