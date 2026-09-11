/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_agent_utils.gsc
***********************************************/

function spawnnewagent(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getfreeagent(var_0);

  if(isDefined(var_5)) {
    var_5.connecttime = gettime();
    set_agent_model(var_5, var_5, var_0);
    set_agent_species(var_5, var_5, var_0);
    species_pre_spawn_init(var_5);

    if(is_scripted_agent(var_0)) {
      var_5 = spawn_scripted_agent(var_5, var_0, var_2, var_3);
    } else {
      var_5 = spawn_regular_agent(var_5, var_2, var_3);
    }

    setup_agent(var_5, var_0);
    set_agent_team(var_5, var_1);
    set_agent_spawn_health(var_5, var_5, var_0);
    set_agent_traversal_unit_type(var_5, var_5, var_0);
    addtocharactersarray(var_5);
    activateagent(var_5);
  }

  return var_5;
}

function set_agent_model(var_0, var_1) {
  var_0 detachall();

  if(isDefined(level.zombieattachfunction) && level.agent_definition[var_1]["traversal_unit_type"] == "zombie") {
    var_0[[level.zombieattachfunction]](var_1);
  } else {
    var_0 setModel(level.agent_definition[var_1]["body_model"]);
    var_2 = strtok(level.agent_definition[var_1]["other_body_parts"], " ");

    foreach(var_4 in var_2) {
      var_0 attach(var_4, "", 1);
    }
  }

  var_0 show();
}

function is_scripted_agent(var_0) {
  return level.agent_definition[var_0]["animclass"] != "";
}

function spawn_scripted_agent(var_0, var_1, var_2, var_3) {
  var_0.onenteranimstate = speciesfunc(var_0, "on_enter_animstate");
  var_0.is_scripted_agent = 1;
  var_0 spawnagent(var_2, var_3, level.agent_definition[var_1]["animclass"], 15, 60);
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

function is_alien_agent() {
  return isagent(self) && isDefined(self.species) && self.species == "alien";
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

function agent_go_to_pos(var_0, var_1, var_2, var_3, var_4) {
  if(is_agent_scripted(self)) {
    self setgoalpos(var_0);
    return;
  }

  self botsetscriptgoal(var_0, var_1, var_2, var_3, var_4);
}

function set_agent_species(var_0, var_1) {
  if(!isDefined(level.agent_funcs[var_1])) {
    level.agent_funcs[var_1] = [];
  }

  var_0.species = level.agent_definition[var_1]["species"];
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

function set_agent_traversal_unit_type(var_0, var_1) {
  if(!can_set_traversal_unit_type(var_0)) {
    return;
  }

  var_0 scragentsetunittype(level.agent_definition[var_1]["traversal_unit_type"]);
}

function can_set_traversal_unit_type(var_0) {
  if(is_agent_scripted(var_0)) {
    return true;
  }

  return false;
}

function species_pre_spawn_init() {
  if(isDefined(level.species_funcs[self.species]) && isDefined(level.species_funcs[self.species]["pre_spawn_init"])) {
    self[[level.species_funcs[self.species]["pre_spawn_init"]]]();
    return;
  }
}

function getfreeagent(var_0) {
  var_1 = undefined;

  if(isDefined(level.agentarray)) {
    foreach(var_3 in level.agentarray) {
      if(!isDefined(var_3.isactive) || !var_3.isactive) {
        if(isDefined(var_3.waitingtodeactivate) && var_3.waitingtodeactivate) {
          continue;
        }

        var_1 = var_3;
        var_1.agent_type = var_0;
        initagentscriptvariables(var_1);
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
  self.spawntime = 0;
  self.entity_number = self getentitynumber();
  self.agent_gameparticipant = 0;
  self detachall();
  initplayerscriptvariables();
}

function initplayerscriptvariables() {
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
  self.can_be_killed = 0;
  self.attack_spot = undefined;
  self.entered_playspace = 0;
  self.marked_for_death = undefined;
  self.trap_killed_by = undefined;
  self.hastraversed = 0;
  self.died_poorly = 0;
  self.isfrozen = undefined;
  self.flung = undefined;
  self.battleslid = undefined;
  self.should_play_transformation_anim = undefined;
  self.is_suicide_bomber = undefined;
  self.is_reserved = undefined;
  self.is_coaster_zombie = undefined;
}

function set_agent_team(var_0, var_1) {
  self.team = var_0;
  self.agentteam = var_0;
  self.pers["team"] = var_0;
  self.owner = var_1;
  self setotherent(var_1);
  self setentityowner(var_1);
}

function addtocharactersarray() {
  for(var_0 = 0; var_0 < level.characters.size; var_0++) {
    if(level.characters[var_0] == self) {
      return;
    }
  }

  level.characters[level.characters.size] = self;
}

function agentfunc(var_0) {
  if(isDefined(self.unittype) && isDefined(level.agent_funcs[self.unittype]) && isDefined(level.agent_funcs[self.unittype][var_0])) {
    return level.agent_funcs[self.unittype][var_0];
  }

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

function default_spawn_func(var_0, var_1, var_2) {
  var_3 = spawnnewagent("soldier", "axis", var_0, var_1);

  if(!isDefined(var_3)) {
    return undefined;
  }

  var_3 botsetscriptgoal(var_3.origin, 0, "hunt");
  var_3 botsetstance("stand");
  var_3 takeallweapons();

  if(isDefined(var_2)) {
    var_3 giveweapon(var_2);
  } else {
    var_3 giveweapon("iw6_dlcweap02_mp");
  }

  var_3 botsetdifficultysetting("maxInaccuracy", 4.5);
  var_3 botsetdifficultysetting("minInaccuracy", 2.25);
  return var_3;
}

function default_on_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self;

  if(scripts\cp\utility::is_friendly_damage(var_12, var_0)) {
    return;
  }

  if(isPlayer(var_1) && !scripts\cp\utility::is_trap(var_0, var_5)) {
    var_2 = scripts\cp\cp_damage::scale_alien_damage_by_perks(var_1, var_2, var_4, var_5);
    var_2 = scripts\cp\cp_damage::scale_alien_damage_by_weapon_type(var_1, var_2, var_4, var_5, var_8);
  }

  var_2 = riot_shield_damage_adjustment(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);
  var_2 = scripts\cp\cp_damage::scale_alien_damage_by_prestige(var_1, var_2);
  var_2 = int(var_2);
  process_damage_score(var_1, var_2, var_4);
  process_damage_rewards(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);
  scripts\cp\cp_damagefeedback::process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);
  var_12[[level.agent_funcs[var_12.agent_type]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_10, var_11);
}

function riot_shield_damage_adjustment(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_10.riotblock = undefined;

  if(var_8 == "shield") {
    var_10.riotblock = 1;
    var_2 = 0;
  }

  return var_2;
}

function process_damage_score(var_0, var_1, var_2) {
  if(isDefined(level.update_agent_damage_performance)) {
    [[level.update_agent_damage_performance]](var_0, var_1, var_2);
    return;
  }
}

function default_on_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  self finishagentdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  return true;
}

function default_on_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
  deactivateagent();
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
}

function on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(istrue(self.hasriotshieldequipped)) {
    scripts\cp\utility::launchshield(var_2, var_3);

    if(!var_9) {
      var_10 = self dropitem(self getcurrentweapon());

      if(isDefined(var_10)) {
        thread deletepickupafterawhile();
        var_10.owner = self;
        var_10.ownersattacker = var_1;
        var_10 makeunusable();
      }
    }
  }

  if(isDefined(self.nocorpse)) {
    return;
  }

  var_11 = self;
  self.body = self cloneagent(var_8);

  if(should_do_immediate_ragdoll(self)) {
    do_immediate_ragdoll(self.body);
  } else {
    thread delaystartragdoll(self.body, var_6, var_5, var_4, var_0, var_3);
  }

  process_kill_rewards(var_1, var_11, var_6, var_4, var_3);

  if(isDefined(level.update_humanoid_death_challenges)) {
    [[level.update_humanoid_death_challenges]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    return;
  }
}

function should_do_immediate_ragdoll(var_0) {
  return istrue(var_0.do_immediate_ragdoll);
}

function do_immediate_ragdoll(var_0) {
  if(isDefined(var_0)) {
    var_0 startragdoll();
    return;
  }
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

  wait 0.2;

  if(!isDefined(var_0)) {
    return;
  }

  if(var_0 isragdoll()) {
    return;
  }

  var_6 = var_0 getcorpseanim();
  var_10 = 0.35;

  if(animhasnotetrack(var_6, "start_ragdoll")) {
    var_11 = getnotetracktimes(var_6, "start_ragdoll");

    if(isDefined(var_11)) {
      var_10 = var_11[0];
    }
  }

  var_12 = var_10 * getanimlength(var_6);
  wait var_12;

  if(isDefined(var_0)) {
    var_0 startragdoll();
    return;
  }
}

function deletepickupafterawhile() {
  self endon("death");
  wait 60;

  if(!isDefined(self)) {
    return;
  }

  self delete();
}

function process_damage_rewards(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  scripts\cp\cp_damage::update_damage_score(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

function process_kill_rewards(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp\cp_reward::give_attacker_kill_rewards(var_0, var_2);
  var_5 = get_agent_type(var_1);
  var_6 = scripts\cp\utility::get_attacker_as_player(var_0);

  if(isDefined(var_6)) {
    scripts\cp\cp_persistence::record_player_kills(var_3, var_2, var_4, var_6);

    if(isDefined(level.loot_func) && isDefined(var_5)) {
      [[level.loot_func]](var_5, self.origin, var_0);
      return;
    }

    return;
  }
}

function getactiveenemyagents(var_0) {
  var_1 = [];

  if(!isDefined(level.agentarray)) {
    return var_1;
  }

  foreach(var_3 in level.agentarray) {
    if(!isDefined(var_3.team)) {
      continue;
    }

    if(isDefined(var_3.isactive) && var_3.isactive) {
      if(var_3.team != var_0) {
        var_1 = var_3;
      }
    }
  }

  return var_1;
}

function get_alive_enemies() {
  var_0 = getaliveagentsofteam("axis");
  var_1 = [];

  if(isDefined(level.dlc_get_non_agent_enemies)) {
    var_1 = [[level.dlc_get_non_agent_enemies]]();
  }

  var_0 = scripts\engine\utility::array_combine(var_0, var_1);
  return var_0;
}

function get_agent_type(var_0) {
  return var_0.agent_type;
}

function store_attacker_info(var_0, var_1) {
  var_0 = scripts\cp\utility::get_attacker_as_player(var_0);

  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(self.attacker_damage)) {
    self.attacker_damage = [];
  }

  foreach(var_3 in self.attacker_damage) {
    if(var_3.player == var_0) {
      var_3.damage += var_1;
      return;
    }
  }

  var_5 = spawnStruct();
  var_5.player = var_0;
  var_5.damage = var_1;
  self.attacker_damage[self.attacker_damage.size] = var_5;
}

function deactivateagent() {
  if(scripts\cp\utility::isgameparticipant(self)) {
    scripts\cp\utility::removefromparticipantsarray();
  }

  scripts\cp\utility::removefromcharactersarray();
  scripts\cp\utility::removefromspawnedgrouparray();
  self.isactive = 0;
  self.hasdied = 0;
  self.marked_by_hybrid = undefined;
  self.mortartarget = undefined;
  self.owner = undefined;
  self.connecttime = undefined;
  self.waitingtodeactivate = undefined;
  self.is_burning = undefined;
  self.is_electrified = undefined;
  self.stun_hit = undefined;
  self.targetname = undefined;
  self.script_noteworthy = undefined;
  self.script_linkname = undefined;
  self.script_linkto = undefined;
  self.target = undefined;
  self.mutations = undefined;

  foreach(var_1 in level.characters) {
    if(isDefined(var_1.attackers)) {
      foreach(var_3 in var_1.attackers) {
        if(var_3 == self) {
          var_1.attackers[var_4] = undefined;
        }
      }
    }
  }

  if(isDefined(self.headmodel)) {
    self.headmodel = undefined;
  }

  scripts\mp\mp_agent::deactivateagent();
  self notify("disconnect");
}

function init_agent_models_by_weapon() {
  level.agentmodeltabledata = [];

  if(!isDefined(level.agentmodeltable)) {
    return;
  }

  var_0 = level.agentmodeltable;

  for(var_1 = 0;; var_1++) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "") {
      break;
    }

    var_3 = spawnStruct();
    var_3.index = int(var_2);
    var_3.ref = tablelookup(var_0, 0, var_2, 1);
    var_3.bodymodel = tablelookup(var_0, 0, var_2, 2);
    var_3.headmodel = tablelookup(var_0, 0, var_2, 3);
    level.agentmodeltabledata[var_3.ref] = var_3;
  }
}