/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_agent_utils.gsc
***********************************************/

function spawnnewagent(var0, var1, var2, var3, var4) {
  var5 = getfreeagent(var0);

  if(isDefined(var5)) {
    var5.connecttime = gettime();
    set_agent_model(var5, var5, var0);
    set_agent_species(var5, var5, var0);
    species_pre_spawn_init(var5);

    if(is_scripted_agent(var0)) {
      var5 = spawn_scripted_agent(var5, var0, var2, var3);
    } else {
      var5 = spawn_regular_agent(var5, var2, var3);
    }

    setup_agent(var5, var0);
    set_agent_team(var5, var1);
    set_agent_spawn_health(var5, var5, var0);
    set_agent_traversal_unit_type(var5, var5, var0);
    addtocharactersarray(var5);
    activateagent(var5);
  }

  return var5;
}

function set_agent_model(var0, var1) {
  var0 detachall();

  if(isDefined(level.zombieattachfunction) && level.agent_definition[var1]["traversal_unit_type"] == "zombie") {
    var0[[level.zombieattachfunction]](var1);
  } else {
    var0 setModel(level.agent_definition[var1]["body_model"]);
    var2 = strtok(level.agent_definition[var1]["other_body_parts"], " ");

    foreach(var4 in var2) {
      var0 attach(var4, "", 1);
    }
  }

  var0 show();
}

function is_scripted_agent(var0) {
  return level.agent_definition[var0]["animclass"] != "";
}

function spawn_scripted_agent(var0, var1, var2, var3) {
  var0.onenteranimstate = speciesfunc(var0, "on_enter_animstate");
  var0.is_scripted_agent = 1;
  var0 spawnagent(var2, var3, level.agent_definition[var1]["animclass"], 15, 60);
  return var0;
}

function spawn_regular_agent(var0, var1, var2) {
  var0.is_scripted_agent = 0;
  var0 spawnagent(var1, var2);
  return var0;
}

function is_agent_scripted(var0) {
  return var0.is_scripted_agent;
}

function is_alien_agent() {
  return isagent(self) && isDefined(self.species) && self.species == "alien";
}

function setup_agent(var0) {
  var1 = level.agent_definition[var0];

  if(!isDefined(var1)) {
    return;
  }

  var2 = var1["setup_func"];

  if(!isDefined(var2)) {
    return;
  }

  self[[var2]]();
}

function agent_go_to_pos(var0, var1, var2, var3, var4) {
  if(is_agent_scripted(self)) {
    self setgoalpos(var0);
    return;
  }

  self botsetscriptgoal(var0, var1, var2, var3, var4);
}

function set_agent_species(var0, var1) {
  if(!isDefined(level.agent_funcs[var1])) {
    level.agent_funcs[var1] = [];
  }

  var0.species = level.agent_definition[var1]["species"];
  assign_agent_func("spawn", &default_spawn_func);
  assign_agent_func("on_damaged", &default_on_damage);
  assign_agent_func("on_damaged_finished", &default_on_damage_finished);
  assign_agent_func("on_killed", &default_on_killed);
}

function assign_agent_func(var0, var1) {
  var2 = self.agent_type;

  if(!isDefined(level.agent_funcs[var2][var0])) {
    if(!isDefined(level.species_funcs[self.species]) || !isDefined(level.species_funcs[self.species][var0])) {
      level.agent_funcs[var2][var0] = var1;
      return;
    }

    level.agent_funcs[var2][var0] = level.species_funcs[self.species][var0];
    return;
  }
}

function set_agent_spawn_health(var0, var1) {
  set_agent_health(var0, level.agent_definition[var1]["health"]);
}

function set_agent_traversal_unit_type(var0, var1) {
  if(!can_set_traversal_unit_type(var0)) {
    return;
  }

  var0 scragentsetunittype(level.agent_definition[var1]["traversal_unit_type"]);
}

function can_set_traversal_unit_type(var0) {
  if(is_agent_scripted(var0)) {
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

function getfreeagent(var0) {
  var1 = undefined;

  if(isDefined(level.agentarray)) {
    foreach(var3 in level.agentarray) {
      if(!isDefined(var3.isactive) || !var3.isactive) {
        if(isDefined(var3.waitingtodeactivate) && var3.waitingtodeactivate) {
          continue;
        }

        var1 = var3;
        var1.agent_type = var0;
        initagentscriptvariables(var1);
        break;
      }
    }
  }

  return var1;
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

function set_agent_team(var0, var1) {
  self.team = var0;
  self.agentteam = var0;
  self.pers["team"] = var0;
  self.owner = var1;
  self setotherent(var1);
  self setentityowner(var1);
}

function addtocharactersarray() {
  for(var0 = 0; var0 < level.characters.size; var0++) {
    if(level.characters[var0] == self) {
      return;
    }
  }

  level.characters[level.characters.size] = self;
}

function agentfunc(var0) {
  if(isDefined(self.unittype) && isDefined(level.agent_funcs[self.unittype]) && isDefined(level.agent_funcs[self.unittype][var0])) {
    return level.agent_funcs[self.unittype][var0];
  }

  return level.agent_funcs[self.agent_type][var0];
}

function speciesfunc(var0) {
  return level.species_funcs[self.species][var0];
}

function validateattacker(var0) {
  if(isagent(var0) && (!isDefined(var0.isactive) || !var0.isactive)) {
    return undefined;
  }

  if(isagent(var0) && !isDefined(var0.classname)) {
    return undefined;
  }

  return var0;
}

function set_agent_health(var0) {
  self.agenthealth = var0;
  self.health = var0;
  self.maxhealth = var0;
}

function default_spawn_func(var0, var1, var2) {
  var3 = spawnnewagent("soldier", "axis", var0, var1);

  if(!isDefined(var3)) {
    return undefined;
  }

  var3 botsetscriptgoal(var3.origin, 0, "hunt");
  var3 botsetstance("stand");
  var3 takeallweapons();

  if(isDefined(var2)) {
    var3 giveweapon(var2);
  } else {
    var3 giveweapon("iw6_dlcweap02_mp");
  }

  var3 botsetdifficultysetting("maxInaccuracy", 4.5);
  var3 botsetdifficultysetting("minInaccuracy", 2.25);
  return var3;
}

function default_on_damage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  var12 = self;

  if(scripts\cp\utility::is_friendly_damage(var12, var0)) {
    return;
  }

  if(isPlayer(var1) && !scripts\cp\utility::is_trap(var0, var5)) {
    var2 = scripts\cp\cp_damage::scale_alien_damage_by_perks(var1, var2, var4, var5);
    var2 = scripts\cp\cp_damage::scale_alien_damage_by_weapon_type(var1, var2, var4, var5, var8);
  }

  var2 = riot_shield_damage_adjustment(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var12);
  var2 = scripts\cp\cp_damage::scale_alien_damage_by_prestige(var1, var2);
  var2 = int(var2);
  process_damage_score(var1, var2, var4);
  process_damage_rewards(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var12);
  scripts\cp\cp_damagefeedback::process_damage_feedback(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var12);
  var12[[level.agent_funcs[var12.agent_type]["on_damaged_finished"]]](var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, 0, var10, var11);
}

function riot_shield_damage_adjustment(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  var10.riotblock = undefined;

  if(var8 == "shield") {
    var10.riotblock = 1;
    var2 = 0;
  }

  return var2;
}

function process_damage_score(var0, var1, var2) {
  if(isDefined(level.update_agent_damage_performance)) {
    [[level.update_agent_damage_performance]](var0, var1, var2);
    return;
  }
}

function default_on_damage_finished(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  self finishagentdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12);
  return true;
}

function default_on_killed(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  on_humanoid_agent_killed_common(var0, var1, var2, var3, var4, var5, var6, var7, var8, 0);
  deactivateagent();
}

function getnumactiveagents(var0) {
  if(!isDefined(var0)) {
    var0 = "all";
  }

  var1 = getactiveagentsoftype(var0);
  return var1.size;
}

function getactiveagentsoftype(var0) {
  var1 = [];

  if(!isDefined(level.agentarray)) {
    return var1;
  }

  foreach(var3 in level.agentarray) {
    if(isDefined(var3.isactive) && var3.isactive) {
      if(var0 == "all" || var3.agent_type == var0) {
        var1 = var3;
      }
    }
  }

  return var1;
}

function getaliveagentsofteam(var0) {
  var1 = [];

  foreach(var3 in level.agentarray) {
    if(isalive(var3) && isDefined(var3.team) && var3.team == var0) {
      var1 = var3;
    }
  }

  return var1;
}

function getactiveagentsofspecies(var0) {
  var1 = [];

  if(!isDefined(level.agentarray)) {
    return var1;
  }

  foreach(var3 in level.agentarray) {
    if(isDefined(var3.isactive) && var3.isactive) {
      if(var3.species == var0) {
        var1 = var3;
      }
    }
  }

  return var1;
}

function getaliveagents() {
  var0 = [];

  foreach(var2 in level.agentarray) {
    if(isalive(var2)) {
      var0 = var2;
    }
  }

  return var0;
}

function activateagent() {
  self.isactive = 1;
}

function on_humanoid_agent_killed_common(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(istrue(self.hasriotshieldequipped)) {
    scripts\cp\utility::launchshield(var2, var3);

    if(!var9) {
      var10 = self dropitem(self getcurrentweapon());

      if(isDefined(var10)) {
        thread deletepickupafterawhile();
        var10.owner = self;
        var10.ownersattacker = var1;
        var10 makeunusable();
      }
    }
  }

  if(isDefined(self.nocorpse)) {
    return;
  }

  var11 = self;
  self.body = self cloneagent(var8);

  if(should_do_immediate_ragdoll(self)) {
    do_immediate_ragdoll(self.body);
  } else {
    thread delaystartragdoll(self.body, var6, var5, var4, var0, var3);
  }

  process_kill_rewards(var1, var11, var6, var4, var3);

  if(isDefined(level.update_humanoid_death_challenges)) {
    [[level.update_humanoid_death_challenges]](var0, var1, var2, var3, var4, var5, var6, var7, var8);
    return;
  }
}

function should_do_immediate_ragdoll(var0) {
  return istrue(var0.do_immediate_ragdoll);
}

function do_immediate_ragdoll(var0) {
  if(isDefined(var0)) {
    var0 startragdoll();
    return;
  }
}

function delaystartragdoll(var0, var1, var2, var3, var4, var5) {
  if(isDefined(var0)) {
    var6 = var0 getcorpseanim();

    if(animhasnotetrack(var6, "ignore_ragdoll")) {
      return;
    }
  }

  if(isDefined(level.noragdollents) && level.noragdollents.size) {
    foreach(var8 in level.noragdollents) {
      if(distancesquared(var0.origin, var8.origin) < 65536) {
        return;
      }
    }
  }

  wait 0.2;

  if(!isDefined(var0)) {
    return;
  }

  if(var0 isragdoll()) {
    return;
  }

  var6 = var0 getcorpseanim();
  var10 = 0.35;

  if(animhasnotetrack(var6, "start_ragdoll")) {
    var11 = getnotetracktimes(var6, "start_ragdoll");

    if(isDefined(var11)) {
      var10 = var11[0];
    }
  }

  var12 = var10 * getanimlength(var6);
  wait var12;

  if(isDefined(var0)) {
    var0 startragdoll();
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

function process_damage_rewards(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  scripts\cp\cp_damage::update_damage_score(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
}

function process_kill_rewards(var0, var1, var2, var3, var4) {
  scripts\cp\cp_reward::give_attacker_kill_rewards(var0, var2);
  var5 = get_agent_type(var1);
  var6 = scripts\cp\utility::get_attacker_as_player(var0);

  if(isDefined(var6)) {
    scripts\cp\cp_persistence::record_player_kills(var3, var2, var4, var6);

    if(isDefined(level.loot_func) && isDefined(var5)) {
      [[level.loot_func]](var5, self.origin, var0);
      return;
    }

    return;
  }
}

function getactiveenemyagents(var0) {
  var1 = [];

  if(!isDefined(level.agentarray)) {
    return var1;
  }

  foreach(var3 in level.agentarray) {
    if(!isDefined(var3.team)) {
      continue;
    }

    if(isDefined(var3.isactive) && var3.isactive) {
      if(var3.team != var0) {
        var1 = var3;
      }
    }
  }

  return var1;
}

function get_alive_enemies() {
  var0 = getaliveagentsofteam("axis");
  var1 = [];

  if(isDefined(level.dlc_get_non_agent_enemies)) {
    var1 = [[level.dlc_get_non_agent_enemies]]();
  }

  var0 = scripts\engine\utility::array_combine(var0, var1);
  return var0;
}

function get_agent_type(var0) {
  return var0.agent_type;
}

function store_attacker_info(var0, var1) {
  var0 = scripts\cp\utility::get_attacker_as_player(var0);

  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(self.attacker_damage)) {
    self.attacker_damage = [];
  }

  foreach(var3 in self.attacker_damage) {
    if(var3.player == var0) {
      var3.damage += var1;
      return;
    }
  }

  var5 = spawnStruct();
  var5.player = var0;
  var5.damage = var1;
  self.attacker_damage[self.attacker_damage.size] = var5;
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

  foreach(var1 in level.characters) {
    if(isDefined(var1.attackers)) {
      foreach(var3 in var1.attackers) {
        if(var3 == self) {
          var1.attackers[var4] = undefined;
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

  var0 = level.agentmodeltable;

  for(var1 = 0;; var1++) {
    var2 = tablelookupbyrow(var0, var1, 0);

    if(var2 == "") {
      break;
    }

    var3 = spawnStruct();
    var3.index = int(var2);
    var3.ref = tablelookup(var0, 0, var2, 1);
    var3.bodymodel = tablelookup(var0, 0, var2, 2);
    var3.headmodel = tablelookup(var0, 0, var2, 3);
    level.agentmodeltabledata[var3.ref] = var3;
  }
}