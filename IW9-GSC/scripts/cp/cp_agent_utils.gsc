/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_agent_utils.gsc
***********************************************/

spawnnewagent(agent_type, team, position, angles, primaryweapon) {
  agent = getfreeagent(agent_type);

  if(isDefined(agent)) {
    agent.connecttime = gettime();
    agent set_agent_model(agent, agent_type);
    agent set_agent_species(agent, agent_type);
    agent species_pre_spawn_init();

    if(is_scripted_agent(agent_type))
      agent = spawn_scripted_agent(agent, agent_type, position, angles);
    else
      agent = spawn_regular_agent(agent, position, angles);

    agent setup_agent(agent_type);
    agent set_agent_team(team);
    agent set_agent_spawn_health(agent, agent_type);
    agent scripts\cp_mp\utility\game_utility::addtocharactersarray();
    agent activateagent();
  }

  return agent;
}

set_agent_model(agent, agent_type) {
  agent detachall();

  if(isDefined(level.zombieattachfunction) && level.agent_definition[agent_type]["traversal_unit_type"] == "zombie")
    agent[[level.zombieattachfunction]](agent_type);
  else {
    agent setModel(level.agent_definition[agent_type]["body_model"]);
    _id_0737BD25C41FEB57 = strtok(level.agent_definition[agent_type]["other_body_parts"], " ");

    foreach(_id_FEF578040E80F6DB in _id_0737BD25C41FEB57)
    agent attach(_id_FEF578040E80F6DB, "", 1);
  }

  agent show();
}

is_scripted_agent(agent_type) {
  return level.agent_definition[agent_type]["animclass"] != "";
}

spawn_scripted_agent(agent, agent_type, position, angles) {
  agent.onenteranimstate = agent speciesfunc("on_enter_animstate");
  agent.is_scripted_agent = 1;
  agent spawnagent(position, angles, level.agent_definition[agent_type]["animclass"], 15, 60);
  return agent;
}

spawn_regular_agent(agent, position, angles) {
  agent.is_scripted_agent = 0;
  agent spawnagent(position, angles);
  return agent;
}

is_agent_scripted(agent) {
  return agent.is_scripted_agent;
}

is_alien_agent() {
  return isagent(self) && isDefined(self.species) && self.species == "alien";
}

setup_agent(agent_type) {
  agent_definition = level.agent_definition[agent_type];

  if(!isDefined(agent_definition)) {
    return;
  }
  _id_D0E49134703DA0D5 = agent_definition["setup_func"];

  if(!isDefined(_id_D0E49134703DA0D5)) {
    return;
  }
  self[[_id_D0E49134703DA0D5]]();
}

agent_go_to_pos(pos, radius, type, yaw, objective_radius) {
  if(is_agent_scripted(self))
    self setgoalpos(pos);
  else
    self botsetscriptgoal(pos, radius, type, yaw, objective_radius);
}

set_agent_species(agent, agent_type) {
  if(!isDefined(level.agent_funcs[agent_type]))
    level.agent_funcs[agent_type] = [];

  agent.species = level.agent_definition[agent_type]["species"];
  assign_agent_func("spawn", ::default_spawn_func);
  assign_agent_func("on_damaged", ::default_on_damage);
  assign_agent_func("on_damaged_finished", ::default_on_damage_finished);
  assign_agent_func("on_killed", ::default_on_killed);
}

assign_agent_func(_id_AD662D6A990F6FCC, _id_428D899920A93A15) {
  agent_type = self.agent_type;

  if(!isDefined(level.agent_funcs[agent_type][_id_AD662D6A990F6FCC])) {
    if(!isDefined(level.species_funcs[self.species]) || !isDefined(level.species_funcs[self.species][_id_AD662D6A990F6FCC]))
      level.agent_funcs[agent_type][_id_AD662D6A990F6FCC] = _id_428D899920A93A15;
    else
      level.agent_funcs[agent_type][_id_AD662D6A990F6FCC] = level.species_funcs[self.species][_id_AD662D6A990F6FCC];
  }
}

set_agent_spawn_health(agent, agent_type) {
  agent set_agent_health(level.agent_definition[agent_type]["health"]);
}

species_pre_spawn_init() {
  if(isDefined(level.species_funcs[self.species]) && isDefined(level.species_funcs[self.species]["pre_spawn_init"]))
    self[[level.species_funcs[self.species]["pre_spawn_init"]]]();
}

getfreeagent(agent_type) {
  _id_7818398CDD97FE84 = undefined;

  if(isDefined(level.agentarray)) {
    _id_7818398CDD97FE84 = _func_76B285B4BAE7356C();

    if(isDefined(_id_7818398CDD97FE84)) {
      _id_7818398CDD97FE84.agent_type = agent_type;
      _id_7818398CDD97FE84 initagentscriptvariables();
    }
  }

  return _id_7818398CDD97FE84;
}

initagentscriptvariables() {
  self.pers = [];
  self.hasdied = 0;
  self.isactive = 0;
  self.spawntime = 0;
  self.entity_number = self getentitynumber();
  self.agent_gameparticipant = 0;
  self.agentname = undefined;
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
  _id_3B64EB40368C1450::nuke("weapon");
  _id_3B64EB40368C1450::nuke("weapon_switch");
  _id_3B64EB40368C1450::nuke("offhand_weapons");
  _id_3B64EB40368C1450::nuke("usability");
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

set_agent_team(team, _id_123F05CF9530A069) {
  self.team = team;
  self.agentteam = team;
  self.pers["team"] = team;
  self.owner = _id_123F05CF9530A069;
  self setotherent(_id_123F05CF9530A069);
  self setentityowner(_id_123F05CF9530A069);
}

agentfunc(_id_4E90A313EA35F4B7) {
  if(isDefined(self.unittype) && isDefined(level.agent_funcs[self.unittype]) && isDefined(level.agent_funcs[self.unittype][_id_4E90A313EA35F4B7]))
    return level.agent_funcs[self.unittype][_id_4E90A313EA35F4B7];
  else
    return level.agent_funcs[self.agent_type][_id_4E90A313EA35F4B7];
}

speciesfunc(_id_4E90A313EA35F4B7) {
  return level.species_funcs[self.species][_id_4E90A313EA35F4B7];
}

validateattacker(eattacker) {
  if(isagent(eattacker) && (!isDefined(eattacker.isactive) || !eattacker.isactive))
    return undefined;

  if(isagent(eattacker) && !isDefined(eattacker.classname))
    return undefined;

  return eattacker;
}

set_agent_health(health) {
  self.health = health;
  self.maxhealth = health;
}

default_spawn_func(_id_E0CBA2B0A5510D09, _id_0FD901B0C91A0D1F, _id_017F7F54AA3EF276) {
  agent = spawnnewagent("soldier", "axis", _id_E0CBA2B0A5510D09, _id_0FD901B0C91A0D1F);

  if(!isDefined(agent))
    return undefined;

  agent botsetscriptgoal(agent.origin, 0, "hunt");
  agent botsetstance("stand");
  agent takeallweapons();

  if(isDefined(_id_017F7F54AA3EF276))
    agent giveweapon(_id_017F7F54AA3EF276);
  else
    agent giveweapon("iw6_dlcweap02_mp");

  agent botsetdifficultysetting("maxInaccuracy", 4.5);
  agent botsetdifficultysetting("minInaccuracy", 2.25);
  return agent;
}

default_on_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname) {
  victim = self;

  if(scripts\cp\utility::is_friendly_damage(victim, einflictor)) {
    return;
  }
  if(isPlayer(eattacker) && !scripts\cp\utility::is_trap(einflictor, sweapon)) {
    idamage = _id_25845ACA699D038D::scale_alien_damage_by_perks(eattacker, idamage, smeansofdeath, sweapon);
    idamage = _id_25845ACA699D038D::scale_alien_damage_by_weapon_type(eattacker, idamage, smeansofdeath, sweapon, shitloc);
  }

  idamage = riot_shield_damage_adjustment(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, victim);
  idamage = _id_25845ACA699D038D::scale_alien_damage_by_prestige(eattacker, idamage);
  idamage = int(idamage);
  process_damage_score(eattacker, idamage, smeansofdeath);
  process_damage_rewards(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, victim);
  _id_354C862768CFE202::process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, victim);
  victim[[level.agent_funcs[victim.agent_type]["on_damaged_finished"]]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0.0, modelindex, partname);
}

riot_shield_damage_adjustment(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, victim) {
  victim.riotblock = undefined;

  if(shitloc == "shield") {
    victim.riotblock = 1;
    idamage = 0;
  }

  return idamage;
}

process_damage_score(eattacker, idamage, smeansofdeath) {
  if(isDefined(level.update_agent_damage_performance))
    [[level.update_agent_damage_performance]](eattacker, idamage, smeansofdeath);
}

default_on_damage_finished(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname) {
  self finishagentdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname);
  return 1;
}

default_on_killed(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration) {
  on_humanoid_agent_killed_common(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration, 0);
  deactivateagent();
}

getnumactiveagents(type) {
  if(!isDefined(type))
    type = "all";

  agents = getactiveagentsoftype(type);
  return agents.size;
}

getactiveagentsoftype(type) {
  agents = [];

  if(!isDefined(level.agentarray))
    return agents;

  foreach(agent in level.agentarray) {
    if(isDefined(agent.isactive) && agent.isactive) {
      if(type == "all" || agent.agent_type == type)
        agents[agents.size] = agent;
    }
  }

  return agents;
}

getaliveagentsofteam(team) {
  _id_C5C35CC6C0816DE1 = [];

  foreach(agent in level.agentarray) {
    if(isalive(agent) && isDefined(agent.team) && agent.team == team)
      _id_C5C35CC6C0816DE1[_id_C5C35CC6C0816DE1.size] = agent;
  }

  return _id_C5C35CC6C0816DE1;
}

getactiveagentsofspecies(species) {
  agents = [];

  if(!isDefined(level.agentarray))
    return agents;

  foreach(agent in level.agentarray) {
    if(isDefined(agent.isactive) && agent.isactive) {
      if(agent.species == species)
        agents[agents.size] = agent;
    }
  }

  return agents;
}

getaliveagents() {
  _id_7EBF5A4DE31246FD = [];

  foreach(agent in level.agentarray) {
    if(isalive(agent))
      _id_7EBF5A4DE31246FD[_id_7EBF5A4DE31246FD.size] = agent;
  }

  return _id_7EBF5A4DE31246FD;
}

activateagent() {
  self.isactive = 1;
}

on_humanoid_agent_killed_common(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration, _id_6F593AD6C6267D6D) {
  if(istrue(self.hasriotshieldequipped)) {
    scripts\cp\utility::launchshield(idamage, smeansofdeath);

    if(!_id_6F593AD6C6267D6D) {
      item = self dropitem(self getcurrentweapon());

      if(isDefined(item)) {
        item thread deletepickupafterawhile();
        item.owner = self;
        item.ownersattacker = eattacker;
        item makeunusable();
      }
    }
  }

  if(isDefined(self.nocorpse)) {
    return;
  }
  victim = self;
  self.body = self cloneagent(deathanimduration);

  if(_id_0CBB0697DE4C5728::_id_BBEE2E46AB15A720(eattacker, sweapon, smeansofdeath, shitloc, einflictor)) {
    return;
  }
  if(should_do_immediate_ragdoll(self))
    do_immediate_ragdoll(self.body);
  else
    thread delaystartragdoll(self.body, shitloc, vdir, sweapon, einflictor, smeansofdeath);

  process_kill_rewards(eattacker, victim, shitloc, sweapon, smeansofdeath);

  if(isDefined(level.update_humanoid_death_challenges))
    [[level.update_humanoid_death_challenges]](einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration);
}

should_do_immediate_ragdoll(agent) {
  return istrue(agent.do_immediate_ragdoll);
}

do_immediate_ragdoll(_id_9EBD9BA17CF84487) {
  if(isDefined(_id_9EBD9BA17CF84487))
    _id_9EBD9BA17CF84487 startragdoll();
}

delaystartragdoll(ent, shitloc, vdir, sweapon, einflictor, smeansofdeath) {
  if(isDefined(ent)) {
    deathanim = ent getcorpseanim();

    if(animhasnotetrack(deathanim, "ignore_ragdoll"))
      return;
  }

  if(isDefined(level.noragdollents) && level.noragdollents.size) {
    foreach(_id_672C0CCE467A1C00 in level.noragdollents) {
      if(distancesquared(ent.origin, _id_672C0CCE467A1C00.origin) < 65536)
        return;
    }
  }

  wait 0.2;

  if(!isDefined(ent)) {
    return;
  }
  if(ent isragdoll()) {
    return;
  }
  deathanim = ent getcorpseanim();
  _id_E53A7053733AF173 = 0.35;

  if(animhasnotetrack(deathanim, "start_ragdoll")) {
    times = getnotetracktimes(deathanim, "start_ragdoll");

    if(isDefined(times))
      _id_E53A7053733AF173 = times[0];
  }

  waittime = _id_E53A7053733AF173 * getanimlength(deathanim);
  wait(waittime);

  if(isDefined(ent))
    ent startragdoll();
}

deletepickupafterawhile() {
  self endon("death");
  wait 60;

  if(!isDefined(self)) {
    return;
  }
  self delete();
}

process_damage_rewards(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, victim) {
  _id_25845ACA699D038D::update_damage_score(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset);
}

process_kill_rewards(attacker, victim, shitloc, sweapon, smeansofdeath) {
  scripts\cp\cp_reward::give_attacker_kill_rewards(attacker, shitloc);
  type = get_agent_type(victim);
  _id_FE62B570456AEFB9 = scripts\cp\utility::get_attacker_as_player(attacker);

  if(isDefined(_id_FE62B570456AEFB9)) {
    scripts\cp\cp_persistence::record_player_kills(sweapon, shitloc, smeansofdeath, _id_FE62B570456AEFB9);

    if(isDefined(level.loot_func) && isDefined(type))
      [[level.loot_func]](type, self.origin, attacker);
  }
}

getactiveenemyagents(_id_118C0E3106155C71) {
  agents = [];

  if(!isDefined(level.agentarray))
    return agents;

  foreach(agent in level.agentarray) {
    if(!isDefined(agent.team)) {
      continue;
    }
    if(isDefined(agent.isactive) && agent.isactive) {
      if(agent.team != _id_118C0E3106155C71)
        agents[agents.size] = agent;
    }
  }

  return agents;
}

get_alive_enemies() {
  _id_CCC9F9C05ABCFDE9 = getaliveagentsofteam("axis");
  _id_2B2CFE014A9942D1 = [];

  if(isDefined(level.dlc_get_non_agent_enemies))
    _id_2B2CFE014A9942D1 = [[level.dlc_get_non_agent_enemies]]();

  _id_CCC9F9C05ABCFDE9 = scripts\engine\utility::array_combine(_id_CCC9F9C05ABCFDE9, _id_2B2CFE014A9942D1);
  return _id_CCC9F9C05ABCFDE9;
}

get_agent_type(agent) {
  return agent.agent_type;
}

store_attacker_info(attacker, damage) {
  attacker = scripts\cp\utility::get_attacker_as_player(attacker);

  if(!isDefined(attacker)) {
    return;
  }
  if(!isDefined(self.attacker_damage))
    self.attacker_damage = [];

  foreach(_id_9AE6BE01E200A866 in self.attacker_damage) {
    if(_id_9AE6BE01E200A866.player == attacker) {
      _id_9AE6BE01E200A866.damage = _id_9AE6BE01E200A866.damage + damage;
      return;
    }
  }

  _id_90A492B93432B5BB = spawnStruct();
  _id_90A492B93432B5BB.player = attacker;
  _id_90A492B93432B5BB.damage = damage;
  self.attacker_damage[self.attacker_damage.size] = _id_90A492B93432B5BB;
}

deactivateagent() {
  if(scripts\cp_mp\utility\game_utility::isgameparticipant(self))
    scripts\cp_mp\utility\game_utility::removefromparticipantsarray();

  scripts\cp_mp\utility\game_utility::removefromcharactersarray();
  scripts\cp\utility::removefromspawnedgrouparray();
  self.isactive = 0;
  self.hasdied = 0;
  self.marked_by_hybrid = undefined;
  self.mortartarget = undefined;
  self.owner = undefined;
  self.connecttime = undefined;
  self.is_burning = undefined;
  self.is_electrified = undefined;
  self.stun_hit = undefined;
  self.targetname = undefined;
  self.script_noteworthy = undefined;
  self.script_linkname = undefined;
  self.script_linkto = undefined;
  self.target = undefined;
  self.mutations = undefined;

  foreach(_id_7DC3241E7F3C6B24 in level.characters) {
    if(isDefined(_id_7DC3241E7F3C6B24.attackers)) {
      foreach(index, attacker in _id_7DC3241E7F3C6B24.attackers) {
        if(attacker == self)
          _id_7DC3241E7F3C6B24.attackers[index] = undefined;
      }
    }
  }

  if(isDefined(self.headmodel))
    self.headmodel = undefined;

  self notify("disconnect");
}

init_agent_models_by_weapon() {
  level.agentmodeltabledata = [];

  if(!isDefined(level.agentmodeltable)) {
    return;
  }
  table = level.agentmodeltable;
  _id_CB89110314447B2F = 0;

  for(;;) {
    index = tablelookupbyrow(table, _id_CB89110314447B2F, 0);

    if(index == "") {
      break;
    }

    _id_40CD685D4868DA71 = spawnStruct();
    _id_40CD685D4868DA71.index = int(index);
    _id_40CD685D4868DA71.ref = tablelookup(table, 0, index, 1);
    _id_40CD685D4868DA71.bodymodel = tablelookup(table, 0, index, 2);
    _id_40CD685D4868DA71.headmodel = tablelookup(table, 0, index, 3);
    level.agentmodeltabledata[_id_40CD685D4868DA71.ref] = _id_40CD685D4868DA71;
    _id_CB89110314447B2F++;
  }
}