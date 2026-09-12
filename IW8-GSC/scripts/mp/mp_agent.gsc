/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\mp_agent.gsc
***********************************************/

function init_agent(var_0) {
  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  init_spawn_times();
  var_1 = [];
  GscBinSkip0(0x2e, "species", 3);
}

function init_spawn_times() {
  level.agent_available_to_spawn_time = [];
  level.agent_recycle_interval = 500;
}

function setup_bt_and_asm() {
  var_0 = level.agent_definition[self.agent_type];

  if(!isDefined(var_0["behaviorTree"]) || var_0["behaviorTree"] == "") {
    return;
  }

  scripts\mp\agents\scriptedagents::ai_init(var_0["behaviorTree"], var_0["asm"]);
}

function setupweapon(var_0) {
  self.weapon = var_0;
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.grenadeweapon = isundefinedweapon();
  self.grenadeammo = 0;
}

function ref_131fd() {
  if(!isDefined(level.gameskill)) {
    level.gameskill = 0;
    level.difficultytype[0] = "mp";
    level.difficultysettings["sniper_converge_scale"][level.difficultytype[level.gameskill]] = 1.3;
    level.difficultysettings["sniperAccuDiffScale"][level.difficultytype[level.gameskill]] = 1;
    return;
  }
}

function setup_spawn_struct(var_0) {
  self.spawner = var_0;
}

function spawnnewagentaitype(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::string_starts_with(var_0, "actor_")) {
    var_0 = "actor_" + var_0;
  }

  if(!isDefined(level.agent_definition[var_0])) {
    return undefined;
  }

  var_4 = spawnnewagent(var_0, level.agent_definition[var_0]["team"], var_1, var_2);
  return var_4;
}

function spawnnewagent(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getfreeagent(var_0);

  if(isDefined(var_6)) {
    if(!isDefined(var_3)) {
      var_3 = (0, 0, 0);
    }

    var_6.connecttime = gettime();

    if(isDefined(var_5)) {
      setup_spawn_struct(var_6, var_5);
    }

    if(!isDefined(var_1)) {
      var_1 = "axis";
    }

    set_agent_team(var_6, var_1);
    set_agent_model(var_6, var_6, var_0);
    set_agent_species(var_6, var_6, var_0);

    if(is_scripted_agent(var_0)) {
      var_6 = spawn_scripted_agent(var_6, var_0, var_2, var_3);
    } else {
      var_6 = spawn_regular_agent(var_6, var_2, var_3);
    }

    set_agent_team(var_6, var_1);
    setup_agent(var_6, var_0);
    set_agent_spawn_health(var_6, var_6, var_0);
    set_agent_traversal_unit_type(var_6, var_6, var_0);
    add_to_characters_array(var_6);
    ref_131fd(var_6);

    if(is_using_behaviortree(var_0)) {
      setup_bt_and_asm(var_6);
    }

    if(isDefined(var_4)) {
      if(issameweapon(var_4)) {
        setupweapon(var_6, var_4);
      } else {
        return undefined;
      }
    }

    activateagent(var_6);
    var_6 scripts\engine\utility::set_ai_number();
  }

  return var_6;
}

function watch_for_team_undefined() {
  self endon("death");

  for(;;) {
    if(!isDefined(self.team)) {
      level notify("agent_missing_team");
    }

    waitframe();
  }
}

function set_agent_traversal_unit_type(var_0, var_1) {
  if(!can_set_traversal_unit_type(var_0)) {
    return;
  }

  if(!isDefined(anim.animselector)) {
    scripts\anim\animselector::init();
  }

  var_0.unittype = level.agent_definition[var_1]["traversal_unit_type"];
}

function can_set_traversal_unit_type(var_0) {
  if(is_agent_scripted(var_0)) {
    return true;
  }

  return false;
}

function set_agent_model(var_0, var_1) {
  var_2 = level.agent_definition[var_1]["setup_model_func"];

  if(isDefined(var_2)) {
    var_0[[var_2]](var_1);
    return;
  }

  var_0 detachall();
  var_0 setModel(level.agent_definition[var_1]["body_model"]);
  var_0 show();
}

function is_scripted_agent(var_0) {
  return level.agent_definition[var_0]["animclass"] != "";
}

function is_using_behaviortree(var_0) {
  if(!isDefined(level.agent_definition[var_0])) {
    return false;
  }

  return level.agent_definition[var_0]["behaviorTree"] != "";
}

function spawn_scripted_agent(var_0, var_1, var_2, var_3) {
  var_0.onenteranimstate = speciesfunc(var_0, "on_enter_animstate");
  var_0.is_scripted_agent = 1;
  var_4 = level.agent_definition[var_1]["radius"];

  if(!isDefined(var_4)) {
    var_4 = 15;
  }

  var_5 = level.agent_definition[var_1]["height"];

  if(!isDefined(var_5)) {
    var_5 = 50;
  }

  var_6 = level.agent_definition[var_1]["legacy"];

  if(!isDefined(var_6) || isstring(var_6)) {
    var_6 = 0;
  }

  var_0 spawnagent(var_2, var_3, level.agent_definition[var_1]["animclass"], var_4, var_5, undefined, var_6);
  var_0.agent_height = var_5;
  var_0.agent_radius = var_4;
  var_0.legacy = spawnStruct();
  return var_0;
}

function spawn_regular_agent(var_0, var_1, var_2) {
  var_0.is_scripted_agent = 0;
  var_0 spawnagent(var_1, var_2);
  return var_0;
}

function is_agent_scripted(var_0) {
  return var_0.is_scripted_agent;
}

function agent_go_to_pos(var_0, var_1, var_2, var_3, var_4) {
  if(is_agent_scripted(self)) {
    self setgoalpos(var_0);
    return;
  }

  self botsetscriptgoal(var_0, var_1, var_2, var_3, var_4);
}

function setup_agent(var_0) {
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

function set_agent_species(var_0, var_1) {
  if(!isDefined(level.agent_funcs[var_1])) {
    level.agent_funcs[var_1] = [];
  }

  var_0.species = level.agent_definition[var_1]["species"];

  if(isDefined(var_0.species) && !isDefined(level.species_funcs[var_0.species]) || !isDefined(level.species_funcs[var_0.species]["on_enter_animstate"])) {
    level.species_funcs[var_0.species] = [];
    level.species_funcs[var_0.species]["on_enter_animstate"] = &default_on_enter_animstate;
  }

  assign_agent_func("spawn", &default_spawn_func);
  assign_agent_func("on_damaged", &default_on_damage);
  assign_agent_func("on_damaged_finished", &default_on_damage_finished);
  assign_agent_func("on_killed", &default_on_killed);
}

function assign_agent_func(var_0, var_1) {
  var_2 = self.agent_type;

  if(!isDefined(level.agent_funcs[var_2][var_0])) {
    if(!isDefined(level.species_funcs[self.species]) || !isDefined(level.species_funcs[self.species][var_0])) {
      level.agent_funcs[var_2][var_0] = var_1;
      return;
    }

    level.agent_funcs[var_2][var_0] = level.species_funcs[self.species][var_0];
    return;
  }
}

function set_agent_spawn_health(var_0, var_1) {
  set_agent_health(var_0, level.agent_definition[var_1]["health"]);
}

function get_agent_type(var_0) {
  return var_0.agent_type;
}

function getfreeagentcount() {
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

function getfreeagent(var_0) {
  var_1 = undefined;
  var_2 = gettime();

  if(isDefined(level.agentarray)) {
    foreach(var_4 in level.agentarray) {
      if(!isDefined(var_4.isactive) || !var_4.isactive) {
        if(isDefined(var_4.waitingtodeactivate) && var_4.waitingtodeactivate) {
          continue;
        }

        var_5 = var_4 getentitynumber();

        if(isDefined(level.agent_available_to_spawn_time)) {
          if(isDefined(level.agent_available_to_spawn_time[var_5]) && var_2 < level.agent_available_to_spawn_time[var_5]) {
            continue;
          }

          level.agent_available_to_spawn_time[var_5] = undefined;
        }

        var_1 = var_4;
        var_1.agent_type = var_0;
        initagentscriptvariables(var_1);
        var_1 notify("agent_in_use");
        break;
      }
    }
  }

  return var_1;
}

function initagentscriptvariables() {
  self.pers = [];
  self.hasdied = 0;
  self.isactive = 0;
  self.isagent = 1;
  self.spawntime = 0;
  self.entity_number = self getentitynumber();
  self.agent_teamparticipant = 0;
  self.agent_gameparticipant = 0;
  self.agentname = undefined;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self detachall();
  initplayerscriptvariables();
}

function initplayerscriptvariables() {
  self.class = undefined;
  self.movespeedscaler = undefined;
  self.avoidkillstreakonspawntimer = undefined;
  self.guid = undefined;
  self.name = undefined;
  self.perks = undefined;
  self.weaponlist = undefined;
  self.objectivescaler = undefined;
  self.sessionteam = undefined;
  self.sessionstate = undefined;
  scripts\common\input_allow::clear_allow_info("weapon");
  scripts\common\input_allow::clear_allow_info("weaponSwitch");
  scripts\common\input_allow::clear_allow_info("offhandWeaps");
  scripts\common\input_allow::clear_allow_info("usability");
  self.nocorpse = undefined;
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.ten_percent_of_max_health = undefined;
  self.command_given = undefined;
  self.current_icon = undefined;
  self.do_immediate_ragdoll = undefined;

  if(isDefined(level.gametype_agent_init)) {
    self[[level.gametype_agent_init]]();
    return;
  }
}

function set_agent_team(var_0, var_1) {
  self.team = var_0;
  self.agentteam = var_0;
  self.pers["team"] = var_0;
  self.owner = var_1;
  self setotherent(var_1);
  self setentityowner(var_1);
}

function add_to_characters_array() {
  for(var_0 = 0; var_0 < level.characters.size; var_0++) {
    if(level.characters[var_0] == self) {
      return;
    }
  }

  level.characters[level.characters.size] = self;
}

function agentfunc(var_0) {
  return level.agent_funcs[self.agent_type][var_0];
}

function speciesfunc(var_0) {
  return level.species_funcs[self.species][var_0];
}

function validateattacker(var_0) {
  if(isagent(var_0) && (!isDefined(var_0.isactive) || !var_0.isactive)) {
    return undefined;
  }

  if(isagent(var_0) && !isDefined(var_0.classname)) {
    return undefined;
  }

  return var_0;
}

function set_agent_health(var_0) {
  self.agenthealth = var_0;
  self.health = var_0;
  self.maxhealth = var_0;
}

function default_spawn_func(var_0, var_1, var_2) {}

function is_friendly_damage(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.team) && var_1.team == var_0.team) {
      return true;
    }

    if(isDefined(var_1.owner) && isDefined(var_1.owner.team) && var_1.owner.team == var_0.team) {
      return true;
    }
  }

  return false;
}

function default_on_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self;
  var_14 = undefined;

  if(istrue(self.is_playing_spawn_performance)) {
    var_2 = int(var_2 * 0);
  }

  if(istrue(self.reduce_incoming_melee_damage) && var_4 == "MOD_MELEE") {
    var_2 = int(var_2 * 0.1);
  }

  if(isDefined(self.unittype) && isDefined(level.agent_funcs[self.unittype])) {
    var_14 = level.agent_funcs[self.unittype]["gametype_on_damaged"];
  }

  if(isDefined(var_14)) {
    var_15 = [[var_14]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(isDefined(var_15)) {
      return var_15;
    }
  } else {
    var_14 = level.agent_funcs[self.agent_type]["gametype_on_damaged"];

    if(isDefined(var_14)) {
      [[var_14]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    }
  }

  if(is_friendly_damage(var_13, var_0)) {
    return;
  }

  if(istrue(var_13.agentdamagefeedback)) {
    var_16 = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
      var_16 = isDefined(var_12) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "isKillstreakWeapon")]](var_12.basename);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "handleDamageFeedback")) {
        var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "handleDamageFeedback")]](var_0, var_1, var_13, var_2, var_4, var_12, var_8, var_3, 0, 0, var_16);
      }
    }
  }

  if(istrue(self.use_updated_damage_modifiers)) {
    self[[level.agent_funcs[var_13.unittype]["on_damaged"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_10, var_11);
  }

  if(isDefined(level.binoculars_runadslogic)) {
    var_13[[level.binoculars_runadslogic]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_10, var_11);
    return;
  }

  if(isDefined(var_13.unittype) && isDefined(level.agent_funcs[var_13.unittype]) && isDefined(level.agent_funcs[var_13.unittype]["on_damaged_finished"])) {
    var_13[[level.agent_funcs[var_13.unittype]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_10, var_11);
    return;
  }

  var_13[[level.agent_funcs[var_13.agent_type]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_10, var_11);
}

function default_on_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = self.health;
  var_16 = var_5;
  self.damagedby = var_1;
  self.damagepoint = var_6;
  self finishagentdamage(var_0, var_1, var_2, var_3, var_4, var_16, var_6, var_7, var_8, var_9, 0, var_11, var_12);

  if(self.health > 0 && self.health < var_15) {
    self notify("pain");
    scripts\asm\asm_mp::ref_12e1d();
  }

  if(isalive(self)) {
    if(isDefined(self.unittype) && isDefined(level.agent_funcs[self.unittype]) && isDefined(level.agent_funcs[self.unittype]["gametype_on_damage_finished"])) {
      var_17 = level.agent_funcs[self.unittype]["gametype_on_damage_finished"];

      if(isDefined(var_17)) {
        [[var_17]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
        return;
      }

      return;
    }

    if(isDefined(self.agent_type)) {
      var_17 = level.agent_funcs[self.agent_type]["gametype_on_damage_finished"];

      if(isDefined(var_17)) {
        [[var_17]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
        return;
      }

      return;
    }

    return;
  }
}

function default_on_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(self.on_zombie_agent_killed_common)) {
    self[[self.on_zombie_agent_killed_common]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
  } else {
    on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
  }

  if(isDefined(self.unittype) && isDefined(level.agent_funcs[self.unittype]) && isDefined(level.agent_funcs[self.unittype]["gametype_on_killed"])) {
    var_9 = level.agent_funcs[self.unittype]["gametype_on_killed"];

    if(isDefined(var_9)) {
      [[var_9]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }
  } else {
    var_9 = level.agent_funcs[self.agent_type]["gametype_on_killed"];

    if(isDefined(var_9)) {
      [[var_9]](var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }
  }

  deactivateagent();
}

function default_on_enter_animstate(var_0, var_1) {
  self.aistate = var_1;

  switch (var_1) {
    case "traverse":
      self.do_immediate_ragdoll = 1;
      scripts\asm\shared\mp\utility::dotraversal();
      self.do_immediate_ragdoll = 0;
      break;
    default:
      break;
  }

  cleardamagehistory();
}

function cleardamagehistory() {
  self.recentdamages = [];
  self.damagelistindex = 0;
}

function deactivateagent() {
  var_0 = self getentitynumber();
  level.agent_available_to_spawn_time[var_0] = gettime() + 500;
}

function getnumactiveagents(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  var_1 = getactiveagentsoftype(var_0);
  return var_1.size;
}

function getactiveagentsoftype(var_0) {
  var_1 = [];

  if(!isDefined(level.agentarray)) {
    return var_1;
  }

  foreach(var_3 in level.agentarray) {
    if(isDefined(var_3.isactive) && var_3.isactive) {
      if(var_0 == "all" || var_3.agent_type == var_0) {
        var_1 = var_3;
      }
    }
  }

  return var_1;
}

function getaliveagentsofteam(var_0) {
  var_1 = [];

  foreach(var_3 in level.agentarray) {
    if(isalive(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
      var_1 = var_3;
    }
  }

  return var_1;
}

function getactiveagentsofspecies(var_0) {
  var_1 = [];

  if(!isDefined(level.agentarray)) {
    return var_1;
  }

  foreach(var_3 in level.agentarray) {
    if(isDefined(var_3.isactive) && var_3.isactive) {
      if(var_3.species == var_0) {
        var_1 = var_3;
      }
    }
  }

  return var_1;
}

function getaliveagents() {
  var_0 = [];

  foreach(var_2 in level.agentarray) {
    if(isalive(var_2)) {
      var_0 = var_2;
    }
  }

  return var_0;
}

function activateagent() {
  self.isactive = 1;
  self.spawn_time = gettime();
}

function bot_choose_attack_role(var_0, var_1) {
  if(var_0 != "MOD_CRUSH") {
    return false;
  }

  if(!isDefined(var_1)) {
    return false;
  }

  if(!var_1 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    return false;
  }

  return true;
}

function on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = bot_choose_attack_role(var_3, var_0);
  self asmdodeathtransition(self.asmname);

  if(isDefined(self.deathanimduration)) {
    var_8 = self.deathanimduration;
  } else if(var_8 == 0) {
    var_8 = 500;
  }

  if(isDefined(self.fncleanupbt)) {
    self[[self.fncleanupbt]]();
  }

  if(isDefined(self.nocorpse)) {
    return;
  }

  var_11 = self;
  self.body = self cloneagent(var_8);

  if(isDefined(self._blackboard.currentvehicle)) {
    if(isDefined(var_3) && var_3 == "MOD_FIRE") {
      self.ragdoll_directionscale = 0;
    }

    if(!istrue(self._blackboard.invehicle) || istrue(self._blackboard.chosenvehicleanimpos.vehicle_death_ragdoll)) {
      if(var_10) {
        self.body isbnetigrplayer(var_0);
        return;
      }

      if(should_do_immediate_ragdoll(self)) {
        if(isDefined(self.ragdollhitloc) && isDefined(self.ragdollimpactvector)) {
          self.body startragdollfromimpact(self.ragdollhitloc, self.ragdollimpactvector);
          return;
        }

        do_immediate_ragdoll(self.body);
        return;
      }

      thread delaystartragdoll(self.body, var_6, var_5, var_4, var_0, var_3);
      return;
    }

    self.body enablelinkTo();

    if(istrue(self._blackboard.chosenvehicleanimpos.linktoblend)) {
      self.body linktoblendtotag(self._blackboard.currentvehicle, self._blackboard.chosenvehicleanimpos.sittag, 0);
    } else {
      self.body linktomoveoffset(self._blackboard.currentvehicle, self._blackboard.chosenvehicleanimpos.sittag);
    }

    if(isDefined(self._blackboard.vehicledeathwait)) {
      thread delaystartragdoll(self.body, var_6, var_4, var_0, var_3);
      return;
    }

    thread ref_129e6(self.body);
    return;
  }

  if(istrue(self.burningtodeath)) {
    if(self isscriptable()) {
      var_12 = self getscriptablepartstate("burn_to_death_by_molotov", 1);

      if(isDefined(var_12) && var_12 == "active") {
        self.body setscriptablepartstate("burn_to_death_by_molotov", "active");
        thread ref_13fc8(self.body);
        thread delaystartragdoll(self.body, var_6, var_5, var_4, var_0, var_3);
        return;
      }

      return;
    }

    return;
  }

  if(var_11) {
    self.body isbnetigrplayer(var_1);
    return;
  }

  if(should_do_immediate_ragdoll(self)) {
    if(isDefined(self.ragdollhitloc) && isDefined(self.ragdollimpactvector)) {
      self.body startragdollfromimpact(self.ragdollhitloc, self.ragdollimpactvector);
      return;
    }

    do_immediate_ragdoll(self.body);
    return;
  }

  thread delaystartragdoll(self.body, var_7, var_6, var_5, var_1, var_4);
}

function ref_129e6(var_0) {
  self endon("entitydeleted");

  if(self isragdoll()) {
    return;
  }

  if(isDefined(var_0)) {
    for(;;) {
      if(!isDefined(self)) {
        return;
      }

      if(!isDefined(var_0) || var_0 scripts\common\vehicle_code::vehicle_iscorpse()) {
        self unlink();
        self startragdoll();
        return;
      }

      waitframe();
    }

    return;
  }
}

function should_do_immediate_ragdoll(var_0) {
  if(istrue(var_0.do_immediate_ragdoll)) {
    return true;
  }

  if(istrue(var_0.forceragdollimmediate)) {
    return true;
  }

  return false;
}

function do_immediate_ragdoll(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_0.ragdollhitloc) && isDefined(var_0.ragdollimpactvector)) {
    var_0 startragdollfromimpact(var_0.ragdollhitloc, var_0.ragdollimpactvector);
    return;
  }

  var_1 = 10;
  var_2 = scripts\common\utility::getdamagetype(self.damagemod);

  if(isDefined(self.attacker) && isPlayer(self.attacker) && var_2 == "melee") {
    var_1 = 5;
  }

  var_3 = self.damagetaken;

  if(var_2 == "bullet" || isDefined(self.damagemod) && self.damagemod == "MOD_FIRE") {
    var_3 = min(var_3, 300);
  }

  var_4 = var_1 * var_3;
  var_5 = max(0.3, self.damagedir[2]);
  var_6 = (self.damagedir[0], self.damagedir[1], var_5);

  if(isDefined(self.ragdoll_directionscale)) {
    var_6 *= self.ragdoll_directionscale;
  } else {
    var_6 *= var_4;
  }

  if(self.forceragdollimmediate) {
    var_6 += self.prevanimdelta * 20 * 10;
  }

  if(isDefined(self.ragdoll_start_vel)) {
    var_6 += self.ragdoll_start_vel * 10;
  }

  var_7 = self.damagelocation;

  if(isDefined(self.ragdoll_damagelocation_none) && var_7 == "none") {
    var_7 = self.ragdoll_damagelocation_none;
  }

  var_0 startragdollfromimpact(var_7, var_6);
}

function delaystartragdoll(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_0)) {
    var_6 = var_0 getcorpseanim();

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

  waitframe();

  if(!isDefined(var_0)) {
    return;
  }

  if(var_0 isragdoll()) {
    return;
  }

  var_6 = var_0 getcorpseanim();

  if(animisleaf(var_6)) {
    var_10 = 0.35;
    var_11 = getnotetracktimes(var_6, "start_ragdoll");

    if(isDefined(var_11) && var_11.size > 0) {
      var_10 = var_11[0];
    } else {
      var_11 = getnotetracktimes(var_6, "vehicle_death_ragdoll");

      if(isDefined(var_11) && var_11.size > 0) {
        var_10 = var_11[0];
      }
    }

    var_12 = var_10 * getanimlength(var_6) - level.frameduration / 1000;

    if(var_12 > 0) {
      wait var_12;
    }
  }

  self unlink();

  if(isDefined(var_0)) {
    if(isDefined(var_0.ragdollhitloc) && isDefined(var_0.ragdollimpactvector)) {
      var_0 startragdollfromimpact(var_0.ragdollhitloc, var_0.ragdollimpactvector);
      return;
    }

    var_0 startragdoll();
    return;
  }
}

function ref_13fc8(var_0) {
  var_1 = self.asm.archetype == "soldier_lw_br";

  if(!var_1) {
    wait 0.7;
  }

  if(!isDefined(var_0)) {
    return;
  }

  var_0 getwartrackpassengerenabled("burntbody_male_cp", 1);

  if(!var_1) {
    var_0 dontinterpolate();
  }

  wait 0.95;

  if(!isDefined(var_0)) {
    return;
  }

  var_0 setscriptablepartstate("burn_to_death_by_molotov", "inactive");
}