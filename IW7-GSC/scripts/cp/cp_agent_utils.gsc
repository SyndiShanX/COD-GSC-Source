/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\cp_agent_utils.gsc
*****************************************/

spawnnewagent(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getfreeagent(var_0);
  if(isDefined(var_5)) {
    var_5.connecttime = gettime();
    var_5 set_agent_model(var_5, var_0);
    var_5 set_agent_species(var_5, var_0);
    var_5 species_pre_spawn_init();
    if(is_scripted_agent(var_0)) {
      var_5 = spawn_scripted_agent(var_5, var_0, var_2, var_3);
    } else {
      var_5 = spawn_regular_agent(var_5, var_2, var_3);
    }

    var_5 setup_agent(var_0);
    var_5 set_agent_team(var_1);
    var_5 set_agent_spawn_health(var_5, var_0);
    var_5 set_agent_traversal_unit_type(var_5, var_0);
    var_5 addtocharactersarray();
    var_5 activateagent();
  }

  return var_5;
}

set_agent_model(var_0, var_1) {
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

is_scripted_agent(var_0) {
  return level.agent_definition[var_0]["animclass"] != "";
}

spawn_scripted_agent(var_0, var_1, var_2, var_3) {
  var_0.onenteranimstate = var_0 speciesfunc("on_enter_animstate");
  var_0.is_scripted_agent = 1;
  var_0 giveplaceable(var_2, var_3, level.agent_definition[var_1]["animclass"], 15, 60);
  return var_0;
}

spawn_regular_agent(var_0, var_1, var_2) {
  var_0.is_scripted_agent = 0;
  var_0 giveplaceable(var_1, var_2);
  return var_0;
}

is_agent_scripted(var_0) {
  return var_0.is_scripted_agent;
}

is_alien_agent() {
  return isagent(self) && isDefined(self.species) && self.species == "alien";
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

agent_go_to_pos(var_0, var_1, var_2, var_3, var_4) {
  if(is_agent_scripted(self)) {
    self ghostskulls_complete_status(var_0);
    return;
  }

  self botsetscriptgoal(var_0, var_1, var_2, var_3, var_4);
}

set_agent_species(var_0, var_1) {
  if(!isDefined(level.agent_funcs[var_1])) {
    level.agent_funcs[var_1] = [];
  }

  var_0.species = level.agent_definition[var_1]["species"];
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

set_agent_traversal_unit_type(var_0, var_1) {
  if(!can_set_traversal_unit_type(var_0)) {
    return;
  }

  var_0 _meth_828C(level.agent_definition[var_1]["traversal_unit_type"]);
}

can_set_traversal_unit_type(var_0) {
  if(is_agent_scripted(var_0)) {
    return 1;
  }

  return 0;
}

species_pre_spawn_init() {
  if(isDefined(level.species_funcs[self.species]) && isDefined(level.species_funcs[self.species]["pre_spawn_init"])) {
    self[[level.species_funcs[self.species]["pre_spawn_init"]]]();
  }
}

getfreeagent(var_0) {
  var_1 = undefined;
  if(isDefined(level.agentarray)) {
    foreach(var_3 in level.agentarray) {
      if(!isDefined(var_3.isactive) || !var_3.isactive) {
        if(isDefined(var_3.waitingtodeactivate) && var_3.waitingtodeactivate) {
          continue;
        }

        var_1 = var_3;
        var_1.agent_type = var_0;
        var_1 initagentscriptvariables();
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

set_agent_team(var_0, var_1) {
  self.team = var_0;
  self.var_20 = var_0;
  self.pers["team"] = var_0;
  self.triggerportableradarping = var_1;
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

default_spawn_func(var_0, var_1, var_2) {
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

  var_3 getpassivestruct("maxInaccuracy", 4.5);
  var_3 getpassivestruct("minInaccuracy", 2.25);
  return var_3;
}

default_on_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B) {
  var_0C = self;
  if(is_friendly_damage(var_0C, var_0)) {
    return;
  }

  var_2 = scripts\cp\cp_damage::func_F29B(var_4, var_5, var_2, var_1, var_3, var_6, var_7, var_8, var_9, var_0);
  if(isplayer(var_1) && !scripts\cp\utility::is_trap(var_0, var_5, var_0C)) {
    var_2 = scripts\cp\cp_damage::scale_alien_damage_by_perks(var_1, var_2, var_4, var_5);
    var_2 = scripts\cp\cp_damage::scale_alien_damage_by_weapon_type(var_1, var_2, var_4, var_5, var_8);
  }

  var_2 = riot_shield_damage_adjustment(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0C);
  var_2 = scripts\cp\cp_damage::scale_alien_damage_by_prestige(var_1, var_2);
  var_2 = int(var_2);
  process_damage_score(var_1, var_2, var_4);
  process_damage_rewards(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0C);
  process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0C);
  var_0C[[level.agent_funcs[var_0C.agent_type]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0, var_0A, var_0B);
}

riot_shield_damage_adjustment(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A) {
  var_0A.riotblock = undefined;
  if(var_8 == "shield") {
    var_0A.riotblock = 1;
    var_2 = 0;
  }

  return var_2;
}

process_damage_score(var_0, var_1, var_2) {
  if(isDefined(level.update_agent_damage_performance)) {
    [[level.update_agent_damage_performance]](var_0, var_1, var_2);
  }
}

default_on_damage_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C) {
  self getrespawndelay(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C);
  var_0D = scripts\cp\utility::is_trap(var_0, var_5);
  if(isDefined(var_1)) {
    if(isplayer(var_1) || isDefined(var_1.triggerportableradarping) && isplayer(var_1.triggerportableradarping)) {
      if(!var_0D) {
        var_1 scripts\cp\cp_damage::check_for_special_damage(self, var_5, var_4);
      }
    }
  }

  return 1;
}

is_friendly_damage(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.team) && var_1.team == var_0.team) {
      return 1;
    }

    if(isDefined(var_1.triggerportableradarping) && isDefined(var_1.triggerportableradarping.team) && var_1.triggerportableradarping.team == var_0.team) {
      return 1;
    }
  }

  return 0;
}

default_on_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
  deactivateagent();
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
  var_1 = [];
  foreach(var_3 in level.agentarray) {
    if(isalive(var_3) && isDefined(var_3.team) && var_3.team == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
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
}

on_humanoid_agent_killed_common(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(scripts\engine\utility::istrue(self.hasriotshieldequipped)) {
    scripts\cp\utility::launchshield(var_2, var_3);
    if(!var_9) {
      var_0A = self dropitem(self getcurrentweapon());
      if(isDefined(var_0A)) {
        var_0A thread deletepickupafterawhile();
        var_0A.triggerportableradarping = self;
        var_0A.ownersattacker = var_1;
        var_0A makeunusable();
      }
    }
  }

  if(isDefined(self.nocorpse)) {
    return;
  }

  var_0B = self;
  self.body = self getplayerviewmodelfrombody(var_8);
  if(should_do_immediate_ragdoll(self)) {
    do_immediate_ragdoll(self.body);
  } else {
    thread delaystartragdoll(self.body, var_6, var_5, var_4, var_0, var_3);
  }

  process_kill_rewards(var_1, var_0B, var_6, var_4, var_3);
  if(isDefined(level.update_humanoid_death_challenges)) {
    [[level.update_humanoid_death_challenges]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }
}

should_do_immediate_ragdoll(var_0) {
  return scripts\engine\utility::istrue(var_0.do_immediate_ragdoll);
}

do_immediate_ragdoll(var_0) {
  if(isDefined(var_0)) {
    var_0 giverankxp();
  }
}

delaystartragdoll(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_0)) {
    var_6 = var_0 _meth_8112();
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

  if(var_0 _meth_81B7()) {
    return;
  }

  var_6 = var_0 _meth_8112();
  var_0A = 0.35;
  if(animhasnotetrack(var_6, "start_ragdoll")) {
    var_0B = getnotetracktimes(var_6, "start_ragdoll");
    if(isDefined(var_0B)) {
      var_0A = var_0B[0];
    }
  }

  var_0C = var_0A * getanimlength(var_6);
  wait(var_0C);
  if(isDefined(var_0)) {
    var_0 giverankxp();
  }
}

deletepickupafterawhile() {
  self endon("death");
  wait(60);
  if(!isDefined(self)) {
    return;
  }

  self delete();
}

func_179E(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = func_E08D(var_3);
  var_7 = spawnnewagent(var_6, var_0, var_1, var_2);
  if(isDefined(var_7)) {
    var_7 thread[[var_7 speciesfunc("spawn")]](var_1, var_2, var_3, var_4, var_5);
  }

  return var_7;
}

func_E08D(var_0) {
  var_1 = strtok(var_0, " ");
  if(isDefined(var_1) && var_1.size == 2) {
    return var_1[1];
  }

  return var_0;
}

process_damage_rewards(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A) {
  scripts\cp\cp_damage::update_damage_score(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A) {
  if(!scripts\engine\utility::isbulletdamage(var_4)) {
    if(scripts\cp\utility::is_trap(var_0, var_5)) {
      return;
    }

    var_0B = gettime();
    if(isDefined(var_1.nexthittime) && var_1.nexthittime > var_0B) {
      return;
    } else {
      var_1.nexthittime = var_0B + 250;
    }
  }

  var_0C = "standard";
  var_0D = undefined;
  if(var_0A.health <= var_2) {
    var_0D = 1;
  }

  var_0E = scripts\cp\utility::isheadshot(var_5, var_8, var_4, var_1);
  if(var_0E) {
    var_0C = "hitcritical";
  }

  var_0F = scripts\engine\utility::isbulletdamage(var_4);
  var_10 = var_0E && var_1 scripts\cp\utility::is_consumable_active("sharp_shooter_upgrade");
  var_11 = var_0F && var_1 scripts\cp\utility::is_consumable_active("bonus_damage_on_last_bullets");
  var_12 = var_0F && var_1 scripts\cp\utility::is_consumable_active("damage_booster_upgrade");
  var_13 = scripts\engine\utility::istrue(var_1.inlaststand);
  var_14 = !var_13 && var_0E && var_0F && var_1 scripts\cp\utility::is_consumable_active("headshot_explosion");
  var_15 = !scripts\cp\utility::isreallyalive(var_0A) || isagent(var_0A) && var_2 >= var_0A.health;
  var_16 = var_4 == "MOD_EXPLOSIVE_BULLET" || var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH";
  var_17 = var_4 == "MOD_MELEE";
  if(scripts\cp\cp_damage::func_A010(var_5)) {
    var_0C = "special_weapon";
  } else if(var_10 || var_11 || var_12 || var_14) {
    var_0C = "card_boosted";
  } else if(issubstr(var_5, "arkyellow") && var_4 == "MOD_EXPLOSIVE_BULLET" && var_8 == "none") {
    var_0C = "yellow_arcane_cp";
  } else if(isplayer(var_1) && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_boom") && var_16) {
    var_0C = "high_damage";
  } else if(isplayer(var_1) && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_smack") && var_17) {
    var_0C = "high_damage";
  } else if(isplayer(var_1) && var_1 scripts\cp\utility::has_zombie_perk("perk_machine_rat_a_tat") && var_0F) {
    var_0C = "high_damage";
  } else if(isplayer(var_1) && scripts\engine\utility::istrue(var_1.deadeye_charge) && var_0F) {
    var_0C = "dewdrops_cp";
  } else if(scripts\engine\utility::istrue(level.insta_kill)) {
    var_0C = "high_damage";
  } else if(var_5 == "incendiary_ammo_mp") {
    var_0C = "red_arcane_cp";
  } else if(var_5 == "stun_ammo_mp") {
    var_0C = "blue_arcane_cp";
  } else if(var_5 == "slayer_ammo_mp") {
    var_0C = "pink_arcane_cp";
  }

  if(isDefined(var_1)) {
    if(isDefined(var_1.triggerportableradarping)) {
      var_1.triggerportableradarping thread scripts\cp\cp_damage::updatedamagefeedback(var_0C, var_0D, var_2, var_0A.riotblock);
      return;
    }

    var_1 thread scripts\cp\cp_damage::updatedamagefeedback(var_0C, var_0D, var_2, var_0A.riotblock);
  }
}

process_kill_rewards(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp\cp_reward::give_attacker_kill_rewards(var_0, var_2);
  var_5 = get_agent_type(var_1);
  var_6 = scripts\cp\utility::get_attacker_as_player(var_0);
  if(isDefined(var_6)) {
    scripts\cp\cp_persistence::record_player_kills(var_3, var_2, var_4, var_6);
    if(isDefined(level.loot_func) && isDefined(var_5)) {
      [
        [level.loot_func]
      ](var_5, self.origin, var_0);
    }
  }
}

get_alive_enemies() {
  var_0 = getaliveagentsofteam("axis");
  var_1 = [];
  if(isDefined(level.dlc_get_non_agent_enemies)) {
    var_1 = [[level.dlc_get_non_agent_enemies]]();
  }

  var_0 = scripts\engine\utility::array_combine(var_0, var_1);
  return var_0;
}

get_agent_type(var_0) {
  return var_0.agent_type;
}

store_attacker_info(var_0, var_1) {
  var_0 = scripts\cp\utility::get_attacker_as_player(var_0);
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(self.attacker_damage)) {
    self.attacker_damage = [];
  }

  foreach(var_3 in self.attacker_damage) {
    if(var_3.player == var_0) {
      var_3.var_DA = var_3.var_DA + var_1;
      return;
    }
  }

  var_5 = spawnStruct();
  var_5.player = var_0;
  var_5.var_DA = var_1;
  self.attacker_damage[self.attacker_damage.size] = var_5;
}

deactivateagent() {
  if(scripts\cp\utility::isgameparticipant(self)) {
    scripts\cp\utility::removefromparticipantsarray();
  }

  scripts\cp\utility::removefromcharactersarray();
  scripts\cp\utility::removefromspawnedgrouparray();
  self.isactive = 0;
  self.hasdied = 0;
  self.marked_by_hybrid = undefined;
  self.mortartarget = undefined;
  self.triggerportableradarping = undefined;
  self.connecttime = undefined;
  self.waitingtodeactivate = undefined;
  self.is_burning = undefined;
  self.is_electrified = undefined;
  self.stun_hit = undefined;
  self.mutations = undefined;
  foreach(var_1 in level.characters) {
    if(isDefined(var_1.attackers)) {
      foreach(var_4, var_3 in var_1.attackers) {
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