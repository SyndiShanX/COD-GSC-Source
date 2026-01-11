/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2773.gsc
***************************************/

init_agent(var_00) {
  level.agent_definition = [];
  level.agent_available_to_spawn_time = [];
  level.agent_recycle_interval = 500;
  var_01 = [];
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
  var_02 = 0;
  var_03 = 50;

  for(var_04 = var_02; var_04 <= var_03; var_4++) {
    var_05 = tablelookupbyrow(var_00, var_04, 2);

    if(var_05 == "") {
      break;
    }
    var_06 = [];

    foreach(var_11, var_08 in var_01) {
      var_09 = tablelookupbyrow(var_00, var_04, var_08);

      if(var_09 == "0") {
        var_09 = 0;
      }
      else if(int(var_09) != 0) {
        var_10 = var_09 + "";

        if(issubstr(var_10, ".")) {
          var_09 = float(var_09);
        }
        else {
          var_09 = int(var_09);
        }
      }

      var_6[var_11] = var_09;
    }

    level.agent_definition[var_05] = var_06;
  }

  level notify("scripted_agents_initialized");
}

func_F8ED() {
  var_00 = level.agent_definition[self.agent_type];

  if(!isDefined(var_0["behaviorTree"]) || var_0["behaviorTree"] == "") {
    return;
  }
  scripts\anim\notetracks_mp::func_197F(var_0["behaviorTree"], var_0["asm"]);
}

func_FAFA(var_00) {
  self.weapon = var_00;
  self giveweapon(var_00);
  self setspawnweapon(var_00);
  self.bulletsinclip = weaponclipsize(var_00);
  self.primaryweapon = var_00;
}

setup_spawn_struct(var_00) {
  self.spawner = var_00;
}

spawnnewagent(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = getfreeagent(var_00);

  if(isDefined(var_06)) {
    if(!isDefined(var_03)) {
      var_03 = (0, 0, 0);
    }

    var_6.connecttime = gettime();

    if(isDefined(var_05)) {
      var_06 setup_spawn_struct(var_05);
    }

    var_06 set_agent_model(var_06, var_00);
    var_06 set_agent_species(var_06, var_00);

    if(is_scripted_agent(var_00)) {
      var_06 = spawn_scripted_agent(var_06, var_00, var_02, var_03);
    }
    else {
      var_06 = spawn_regular_agent(var_06, var_02, var_03);
    }

    var_06 setup_agent(var_00);
    var_06 set_agent_team(var_01);
    var_06 set_agent_spawn_health(var_06, var_00);
    var_06 set_agent_traversal_unit_type(var_06, var_00);
    var_06 addtocharactersarray();

    if(isDefined(var_04)) {
      var_06 func_FAFA(var_04);
    }

    if(func_9CF8(var_00)) {
      var_06 func_F8ED();
    }

    var_06 activateagent();
  }

  return var_06;
}

set_agent_traversal_unit_type(var_00, var_01) {
  if(!can_set_traversal_unit_type(var_00)) {
    return;
  }
  var_00 _meth_828C(level.agent_definition[var_01]["traversal_unit_type"]);
}

can_set_traversal_unit_type(var_00) {
  if(is_agent_scripted(var_00)) {
    return 1;
  }

  return 0;
}

set_agent_model(var_00, var_01) {
  var_02 = level.agent_definition[var_01]["setup_model_func"];

  if(isDefined(var_02)) {
    var_00[[var_02]](var_01);
    return;
  }

  var_00 detachall();
  var_00 setModel(level.agent_definition[var_01]["body_model"]);
  var_00 show();
}

is_scripted_agent(var_00) {
  return level.agent_definition[var_00]["animclass"] != "";
}

func_9CF8(var_00) {
  if(!isDefined(level.agent_definition[var_00])) {
    return 0;
  }

  return level.agent_definition[var_00]["behaviorTree"] != "";
}

spawn_scripted_agent(var_00, var_01, var_02, var_03) {
  var_0.onenteranimstate = var_00 speciesfunc("on_enter_animstate");
  var_0.is_scripted_agent = 1;
  var_04 = level.agent_definition[var_01]["radius"];

  if(!isDefined(var_04)) {
    var_04 = 15;
  }

  var_05 = level.agent_definition[var_01]["height"];

  if(!isDefined(var_05)) {
    var_05 = 50;
  }

  var_00 spawnagent(var_02, var_03, level.agent_definition[var_01]["animclass"], var_04, var_05);
  var_0.func_18F4 = var_05;
  var_0.func_18F9 = var_04;
  return var_00;
}

spawn_regular_agent(var_00, var_01, var_02) {
  var_0.is_scripted_agent = 0;
  var_00 spawnagent(var_01, var_02);
  return var_00;
}

is_agent_scripted(var_00) {
  return var_0.is_scripted_agent;
}

agent_go_to_pos(var_00, var_01, var_02, var_03, var_04) {
  if(is_agent_scripted(self)) {
    self ghostskulls_complete_status(var_00);
  }
  else {
    self botsetscriptgoal(var_00, var_01, var_02, var_03, var_04);
  }
}

setup_agent(var_00) {
  var_01 = level.agent_definition[var_00];

  if(!isDefined(var_01)) {
    return;
  }
  var_02 = var_1["setup_func"];

  if(!isDefined(var_02)) {
    return;
  }
  self[[var_02]]();
}

set_agent_species(var_00, var_01) {
  if(!isDefined(level.agent_funcs[var_01])) {
    level.agent_funcs[var_01] = [];
  }

  var_0.species = level.agent_definition[var_01]["species"];

  if(!isDefined(level.species_funcs[var_0.species]) || !isDefined(level.species_funcs[var_0.species]["on_enter_animstate"])) {
    level.species_funcs[var_0.species] = [];
    level.species_funcs[var_0.species]["on_enter_animstate"] = ::func_5005;
  }

  assign_agent_func("spawn", ::default_spawn_func);
  assign_agent_func("on_damaged", ::default_on_damage);
  assign_agent_func("on_damaged_finished", ::default_on_damage_finished);
  assign_agent_func("on_killed", ::default_on_killed);
}

assign_agent_func(var_00, var_01) {
  var_02 = self.agent_type;

  if(!isDefined(level.agent_funcs[var_02][var_00])) {
    if(!isDefined(level.species_funcs[self.species]) || !isDefined(level.species_funcs[self.species][var_00])) {
      level.agent_funcs[var_02][var_00] = var_01;
    }
    else {
      level.agent_funcs[var_02][var_00] = level.species_funcs[self.species][var_00];
    }
  }
}

set_agent_spawn_health(var_00, var_01) {
  var_00 set_agent_health(level.agent_definition[var_01]["health"]);
}

get_agent_type(var_00) {
  return var_0.agent_type;
}

getfreeagentcount() {
  if(!isDefined(level.agentarray)) {
    return 0;
  }

  var_00 = gettime();
  var_01 = 0;

  foreach(var_03 in level.agentarray) {
    if(!isDefined(var_3.isactive) || !var_3.isactive) {
      if(isDefined(var_3.waitingtodeactivate) && var_3.waitingtodeactivate) {
        continue;
      }
      var_04 = var_03 getentitynumber();

      if(isDefined(level.agent_available_to_spawn_time) && isDefined(level.agent_available_to_spawn_time[var_04]) && var_00 < level.agent_available_to_spawn_time[var_04]) {
        continue;
      }
      var_1++;
    }
  }

  return var_01;
}

getfreeagent(var_00) {
  var_01 = undefined;
  var_02 = gettime();

  if(isDefined(level.agentarray)) {
    foreach(var_04 in level.agentarray) {
      if(!isDefined(var_4.isactive) || !var_4.isactive) {
        if(isDefined(var_4.waitingtodeactivate) && var_4.waitingtodeactivate) {
          continue;
        }
        var_05 = var_04 getentitynumber();

        if(isDefined(level.agent_available_to_spawn_time) && isDefined(level.agent_available_to_spawn_time[var_05]) && var_02 < level.agent_available_to_spawn_time[var_05]) {
          continue;
        }
        level.agent_available_to_spawn_time[var_05] = undefined;
        var_01 = var_04;
        var_1.agent_type = var_00;
        var_01 initagentscriptvariables();
        var_01 notify("agent_in_use");
        break;
      }
    }
  }

  return var_01;
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
  self.ignoreall = 0;
  self.ten_percent_of_max_health = undefined;
  self.command_given = undefined;
  self.current_icon = undefined;
  self.do_immediate_ragdoll = undefined;

  if(isDefined(level.func_768B)) {
    self[[level.func_768B]]();
  }
}

set_agent_team(var_00, var_01) {
  self.team = var_00;
  self.agentteam = var_00;
  self.pers["team"] = var_00;
  self.owner = var_01;
  self setotherent(var_01);
  self setentityowner(var_01);
}

addtocharactersarray() {
  for(var_00 = 0; var_00 < level.characters.size; var_0++) {
    if(level.characters[var_00] == self) {
      return;
    }
  }

  level.characters[level.characters.size] = self;
}

agentfunc(var_00) {
  return level.agent_funcs[self.agent_type][var_00];
}

speciesfunc(var_00) {
  return level.species_funcs[self.species][var_00];
}

validateattacker(var_00) {
  if(isagent(var_00) && (!isDefined(var_0.isactive) || !var_0.isactive)) {
    return undefined;
  }

  if(isagent(var_00) && !isDefined(var_0.classname)) {
    return undefined;
  }

  return var_00;
}

set_agent_health(var_00) {
  self.agenthealth = var_00;
  self.health = var_00;
  self.maxhealth = var_00;
}

default_spawn_func(var_00, var_01, var_02) {}

is_friendly_damage(var_00, var_01) {
  if(isDefined(var_01)) {
    if(isDefined(var_1.team) && var_1.team == var_0.team) {
      return 1;
    }

    if(isDefined(var_1.owner) && isDefined(var_1.owner.team) && var_1.owner.team == var_0.team) {
      return 1;
    }
  }

  return 0;
}

default_on_damage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  var_12 = self;
  var_13 = level.agent_funcs[self.agent_type]["gametype_on_damaged"];

  if(isDefined(var_13)) {
    [[var_13]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11);
  }

  if(is_friendly_damage(var_12, var_00)) {
    return;
  }
  var_12[[level.agent_funcs[var_12.agent_type]["on_damaged_finished"]]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, 0.0, var_10, var_11);
}

default_on_damage_finished(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12) {
  var_13 = self.health;

  if(isDefined(var_07)) {
    var_14 = vectortoyaw(var_07);
    var_15 = self.angles[1];
    self.damageyaw = angleclamp180(var_14 - var_15);
  } else
    self.damageyaw = 0;

  self.damagelocation = var_08;
  self.damagemod = var_04;
  self.damagedby = var_01;
  self.damagedir = var_07;
  self.damagetaken = var_02;
  self.damageweapon = var_05;
  self.func_4D62 = var_06;
  self finishagentdamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, 0.0, var_11, var_12);

  if(self.health > 0 && self.health < var_13) {
    self notify("pain");
  }

  if(isalive(self) && isDefined(self.agent_type)) {
    var_16 = level.agent_funcs[self.agent_type]["gametype_on_damage_finished"];

    if(isDefined(var_16)) {
      [[var_16]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12);
    }
  }
}

default_on_killed(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  if(isDefined(level.func_C4BD)) {
    self[[level.func_C4BD]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, 0);
  }
  else {
    on_humanoid_agent_killed_common(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, 0);
  }

  var_09 = level.agent_funcs[self.agent_type]["gametype_on_killed"];

  if(isDefined(var_09)) {
    [[var_09]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08);
  }

  deactivateagent();
}

func_5005(var_00, var_01) {
  self.aistate = var_01;

  switch (var_01) {
    case "traverse":
      self.do_immediate_ragdoll = 1;
      func_0F3C::func_5AC0();
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
  var_00 = self getentitynumber();
  level.agent_available_to_spawn_time[var_00] = gettime() + 500;
}

getnumactiveagents(var_00) {
  if(!isDefined(var_00)) {
    var_00 = "all";
  }

  var_01 = getactiveagentsoftype(var_00);
  return var_1.size;
}

getactiveagentsoftype(var_00) {
  var_01 = [];

  if(!isDefined(level.agentarray)) {
    return var_01;
  }

  foreach(var_03 in level.agentarray) {
    if(isDefined(var_3.isactive) && var_3.isactive) {
      if(var_00 == "all" || var_3.agent_type == var_00) {
        var_1[var_1.size] = var_03;
      }
    }
  }

  return var_01;
}

getaliveagentsofteam(var_00) {
  var_01 = [];

  foreach(var_03 in level.agentarray) {
    if(isalive(var_03) && isDefined(var_3.team) && var_3.team == var_00) {
      var_1[var_1.size] = var_03;
    }
  }

  return var_01;
}

getactiveagentsofspecies(var_00) {
  var_01 = [];

  if(!isDefined(level.agentarray)) {
    return var_01;
  }

  foreach(var_03 in level.agentarray) {
    if(isDefined(var_3.isactive) && var_3.isactive) {
      if(var_3.species == var_00) {
        var_1[var_1.size] = var_03;
      }
    }
  }

  return var_01;
}

getaliveagents() {
  var_00 = [];

  foreach(var_02 in level.agentarray) {
    if(isalive(var_02)) {
      var_0[var_0.size] = var_02;
    }
  }

  return var_00;
}

activateagent() {
  self.isactive = 1;
  self.spawn_time = gettime();
}

on_humanoid_agent_killed_common(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  var_10 = self.func_164D[self.asmname].func_4BC0;
  var_11 = anim.asm[self.asmname].states[var_10];

  if(scripts\asm\asm_mp::func_2382(self.asmname, var_11)) {
    scripts\asm\asm::func_231E(self.asmname, var_11, var_10);
  }

  if(isDefined(self.nocorpse)) {
    return;
  }
  var_12 = self;
  self.body = self cloneagent(var_08);

  if(should_do_immediate_ragdoll(self)) {
    do_immediate_ragdoll(self.body);
  }
  else {
    thread delaystartragdoll(self.body, var_06, var_05, var_04, var_00, var_03);
  }
}

should_do_immediate_ragdoll(var_00) {
  if(isDefined(var_0.do_immediate_ragdoll) && var_0.do_immediate_ragdoll) {
    return 1;
  }

  return 0;
}

do_immediate_ragdoll(var_00) {
  if(isDefined(var_00)) {
    var_00 startragdoll();
  }
}

delaystartragdoll(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(isDefined(var_00)) {
    var_06 = var_00 _meth_8112();

    if(animhasnotetrack(var_06, "ignore_ragdoll")) {
      return;
    }
  }

  if(isDefined(level.noragdollents) && level.noragdollents.size) {
    foreach(var_08 in level.noragdollents) {
      if(distancesquared(var_0.origin, var_8.origin) < 65536) {
        return;
      }
    }
  }

  wait 0.2;

  if(!isDefined(var_00)) {
    return;
  }
  if(var_00 _meth_81B7()) {
    return;
  }
  var_06 = var_00 _meth_8112();
  var_10 = 0.35;

  if(animhasnotetrack(var_06, "start_ragdoll")) {
    var_11 = getnotetracktimes(var_06, "start_ragdoll");

    if(isDefined(var_11)) {
      var_10 = var_11[0];
    }
  }

  var_12 = var_10 * getanimlength(var_06) - 0.2;

  if(var_12 > 0) {
    wait(var_12);
  }

  if(isDefined(var_00)) {
    if(isDefined(var_0.ragdollhitloc) && isDefined(var_0.ragdollimpactvector)) {
      var_00 giverankxp_regularmp(var_0.ragdollhitloc, var_0.ragdollimpactvector);
    }
    else {
      var_00 startragdoll();
    }
  }
}