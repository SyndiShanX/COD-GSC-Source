/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\cp_agent_utils.gsc
*****************************************/

spawnnewagent(param_00, param_01, param_02, param_03, param_04) {
  var_05 = getfreeagent(param_00);
  if(isDefined(var_05)) {
    var_05.connecttime = gettime();
    var_05 set_agent_model(var_05, param_00);
    var_05 set_agent_species(var_05, param_00);
    var_05 species_pre_spawn_init();
    if(is_scripted_agent(param_00)) {
      var_05 = spawn_scripted_agent(var_05, param_00, param_02, param_03);
    } else {
      var_05 = spawn_regular_agent(var_05, param_02, param_03);
    }

    var_05 setup_agent(param_00);
    var_05 set_agent_team(param_01);
    var_05 set_agent_spawn_health(var_05, param_00);
    var_05 set_agent_traversal_unit_type(var_05, param_00);
    var_05 addtocharactersarray();
    var_05 activateagent();
  }

  return var_05;
}

set_agent_model(param_00, param_01) {
  param_00 detachall();
  if(isDefined(level.zombieattachfunction) && level.agent_definition[param_01]["traversal_unit_type"] == "zombie") {
    param_00[[level.zombieattachfunction]](param_01);
  } else {
    param_00 setModel(level.agent_definition[param_01]["body_model"]);
    var_02 = strtok(level.agent_definition[param_01]["other_body_parts"], " ");
    foreach(var_04 in var_02) {
      param_00 attach(var_04, "", 1);
    }
  }

  param_00 show();
}

is_scripted_agent(param_00) {
  return level.agent_definition[param_00]["animclass"] != "";
}

spawn_scripted_agent(param_00, param_01, param_02, param_03) {
  param_00.onenteranimstate = param_00 speciesfunc("on_enter_animstate");
  param_00.is_scripted_agent = 1;
  param_00 giveplaceable(param_02, param_03, level.agent_definition[param_01]["animclass"], 15, 60);
  return param_00;
}

spawn_regular_agent(param_00, param_01, param_02) {
  param_00.is_scripted_agent = 0;
  param_00 giveplaceable(param_01, param_02);
  return param_00;
}

is_agent_scripted(param_00) {
  return param_00.is_scripted_agent;
}

is_alien_agent() {
  return isagent(self) && isDefined(self.species) && self.species == "alien";
}

setup_agent(param_00) {
  var_01 = level.agent_definition[param_00];
  if(!isDefined(var_01)) {
    return;
  }

  var_02 = var_01["setup_func"];
  if(!isDefined(var_02)) {
    return;
  }

  self[[var_02]]();
}

agent_go_to_pos(param_00, param_01, param_02, param_03, param_04) {
  if(is_agent_scripted(self)) {
    self ghostskulls_complete_status(param_00);
    return;
  }

  self botsetscriptgoal(param_00, param_01, param_02, param_03, param_04);
}

set_agent_species(param_00, param_01) {
  if(!isDefined(level.agent_funcs[param_01])) {
    level.agent_funcs[param_01] = [];
  }

  param_00.species = level.agent_definition[param_01]["species"];
  assign_agent_func("spawn", ::default_spawn_func);
  assign_agent_func("on_damaged", ::default_on_damage);
  assign_agent_func("on_damaged_finished", ::default_on_damage_finished);
  assign_agent_func("on_killed", ::default_on_killed);
}

assign_agent_func(param_00, param_01) {
  var_02 = self.agent_type;
  if(!isDefined(level.agent_funcs[var_02][param_00])) {
    if(!isDefined(level.species_funcs[self.species]) || !isDefined(level.species_funcs[self.species][param_00])) {
      level.agent_funcs[var_02][param_00] = param_01;
      return;
    }

    level.agent_funcs[var_02][param_00] = level.species_funcs[self.species][param_00];
  }
}

set_agent_spawn_health(param_00, param_01) {
  param_00 set_agent_health(level.agent_definition[param_01]["health"]);
}

set_agent_traversal_unit_type(param_00, param_01) {
  if(!can_set_traversal_unit_type(param_00)) {
    return;
  }

  param_00 _meth_828C(level.agent_definition[param_01]["traversal_unit_type"]);
}

can_set_traversal_unit_type(param_00) {
  if(is_agent_scripted(param_00)) {
    return 1;
  }

  return 0;
}

species_pre_spawn_init() {
  if(isDefined(level.species_funcs[self.species]) && isDefined(level.species_funcs[self.species]["pre_spawn_init"])) {
    self[[level.species_funcs[self.species]["pre_spawn_init"]]]();
  }
}

getfreeagent(param_00) {
  var_01 = undefined;
  if(isDefined(level.agentarray)) {
    foreach(var_03 in level.agentarray) {
      if(!isDefined(var_03.isactive) || !var_03.isactive) {
        if(isDefined(var_03.waitingtodeactivate) && var_03.waitingtodeactivate) {
          continue;
        }

        var_01 = var_03;
        var_01.agent_type = param_00;
        var_01 initagentscriptvariables();
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

set_agent_team(param_00, param_01) {
  self.team = param_00;
  self.var_20 = param_00;
  self.pers["team"] = param_00;
  self.triggerportableradarping = param_01;
  self setotherent(param_01);
  self setentityowner(param_01);
}

addtocharactersarray() {
  for(var_00 = 0; var_00 < level.characters.size; var_00++) {
    if(level.characters[var_00] == self) {
      return;
    }
  }

  level.characters[level.characters.size] = self;
}

agentfunc(param_00) {
  return level.agent_funcs[self.agent_type][param_00];
}

speciesfunc(param_00) {
  return level.species_funcs[self.species][param_00];
}

validateattacker(param_00) {
  if(isagent(param_00) && !isDefined(param_00.isactive) || !param_00.isactive) {
    return undefined;
  }

  if(isagent(param_00) && !isDefined(param_00.classname)) {
    return undefined;
  }

  return param_00;
}

set_agent_health(param_00) {
  self.var_1E = param_00;
  self.health = param_00;
  self.maxhealth = param_00;
}

default_spawn_func(param_00, param_01, param_02) {
  var_03 = spawnnewagent("soldier", "axis", param_00, param_01);
  if(!isDefined(var_03)) {
    return undefined;
  }

  var_03 botsetscriptgoal(var_03.origin, 0, "hunt");
  var_03 botsetstance("stand");
  var_03 takeallweapons();
  if(isDefined(param_02)) {
    var_03 giveweapon(param_02);
  } else {
    var_03 giveweapon("iw6_dlcweap02_mp");
  }

  var_03 getpassivestruct("maxInaccuracy", 4.5);
  var_03 getpassivestruct("minInaccuracy", 2.25);
  return var_03;
}

default_on_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = self;
  if(is_friendly_damage(var_0C, param_00)) {
    return;
  }

  param_02 = scripts\cp\cp_damage::func_F29B(param_04, param_05, param_02, param_01, param_03, param_06, param_07, param_08, param_09, param_00);
  if(isplayer(param_01) && !scripts\cp\utility::is_trap(param_00, param_05, var_0C)) {
    param_02 = scripts\cp\cp_damage::scale_alien_damage_by_perks(param_01, param_02, param_04, param_05);
    param_02 = scripts\cp\cp_damage::scale_alien_damage_by_weapon_type(param_01, param_02, param_04, param_05, param_08);
  }

  param_02 = riot_shield_damage_adjustment(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, var_0C);
  param_02 = scripts\cp\cp_damage::scale_alien_damage_by_prestige(param_01, param_02);
  param_02 = int(param_02);
  process_damage_score(param_01, param_02, param_04);
  process_damage_rewards(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, var_0C);
  process_damage_feedback(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, var_0C);
  var_0C[[level.agent_funcs[var_0C.agent_type]["on_damaged_finished"]]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, 0, param_0A, param_0B);
}

riot_shield_damage_adjustment(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  param_0A.riotblock = undefined;
  if(param_08 == "shield") {
    param_0A.riotblock = 1;
    param_02 = 0;
  }

  return param_02;
}

process_damage_score(param_00, param_01, param_02) {
  if(isDefined(level.update_agent_damage_performance)) {
    [[level.update_agent_damage_performance]](param_00, param_01, param_02);
  }
}

default_on_damage_finished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C) {
  self getrespawndelay(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B, param_0C);
  var_0D = scripts\cp\utility::is_trap(param_00, param_05);
  if(isDefined(param_01)) {
    if(isplayer(param_01) || isDefined(param_01.triggerportableradarping) && isplayer(param_01.triggerportableradarping)) {
      if(!var_0D) {
        param_01 scripts\cp\cp_damage::check_for_special_damage(self, param_05, param_04);
      }
    }
  }

  return 1;
}

is_friendly_damage(param_00, param_01) {
  if(isDefined(param_01)) {
    if(isDefined(param_01.team) && param_01.team == param_00.team) {
      return 1;
    }

    if(isDefined(param_01.triggerportableradarping) && isDefined(param_01.triggerportableradarping.team) && param_01.triggerportableradarping.team == param_00.team) {
      return 1;
    }
  }

  return 0;
}

default_on_killed(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  on_humanoid_agent_killed_common(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, 0);
  deactivateagent();
}

getnumactiveagents(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "all";
  }

  var_01 = getactiveagentsoftype(param_00);
  return var_01.size;
}

getactiveagentsoftype(param_00) {
  var_01 = [];
  if(!isDefined(level.agentarray)) {
    return var_01;
  }

  foreach(var_03 in level.agentarray) {
    if(isDefined(var_03.isactive) && var_03.isactive) {
      if(param_00 == "all" || var_03.agent_type == param_00) {
        var_01[var_01.size] = var_03;
      }
    }
  }

  return var_01;
}

getaliveagentsofteam(param_00) {
  var_01 = [];
  foreach(var_03 in level.agentarray) {
    if(isalive(var_03) && isDefined(var_03.team) && var_03.team == param_00) {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

getactiveagentsofspecies(param_00) {
  var_01 = [];
  if(!isDefined(level.agentarray)) {
    return var_01;
  }

  foreach(var_03 in level.agentarray) {
    if(isDefined(var_03.isactive) && var_03.isactive) {
      if(var_03.species == param_00) {
        var_01[var_01.size] = var_03;
      }
    }
  }

  return var_01;
}

getaliveagents() {
  var_00 = [];
  foreach(var_02 in level.agentarray) {
    if(isalive(var_02)) {
      var_00[var_00.size] = var_02;
    }
  }

  return var_00;
}

activateagent() {
  self.isactive = 1;
}

on_humanoid_agent_killed_common(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(scripts\engine\utility::istrue(self.hasriotshieldequipped)) {
    scripts\cp\utility::launchshield(param_02, param_03);
    if(!param_09) {
      var_0A = self dropitem(self getcurrentweapon());
      if(isDefined(var_0A)) {
        var_0A thread deletepickupafterawhile();
        var_0A.triggerportableradarping = self;
        var_0A.ownersattacker = param_01;
        var_0A makeunusable();
      }
    }
  }

  if(isDefined(self.nocorpse)) {
    return;
  }

  var_0B = self;
  self.body = self getplayerviewmodelfrombody(param_08);
  if(should_do_immediate_ragdoll(self)) {
    do_immediate_ragdoll(self.body);
  } else {
    thread delaystartragdoll(self.body, param_06, param_05, param_04, param_00, param_03);
  }

  process_kill_rewards(param_01, var_0B, param_06, param_04, param_03);
  if(isDefined(level.update_humanoid_death_challenges)) {
    [[level.update_humanoid_death_challenges]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
  }
}

should_do_immediate_ragdoll(param_00) {
  return scripts\engine\utility::istrue(param_00.do_immediate_ragdoll);
}

do_immediate_ragdoll(param_00) {
  if(isDefined(param_00)) {
    param_00 giverankxp();
  }
}

delaystartragdoll(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isDefined(param_00)) {
    var_06 = param_00 _meth_8112();
    if(animhasnotetrack(var_06, "ignore_ragdoll")) {
      return;
    }
  }

  if(isDefined(level.noragdollents) && level.noragdollents.size) {
    foreach(var_08 in level.noragdollents) {
      if(distancesquared(param_00.origin, var_08.origin) < 65536) {
        return;
      }
    }
  }

  wait(0.2);
  if(!isDefined(param_00)) {
    return;
  }

  if(param_00 _meth_81B7()) {
    return;
  }

  var_06 = param_00 _meth_8112();
  var_0A = 0.35;
  if(animhasnotetrack(var_06, "start_ragdoll")) {
    var_0B = getnotetracktimes(var_06, "start_ragdoll");
    if(isDefined(var_0B)) {
      var_0A = var_0B[0];
    }
  }

  var_0C = var_0A * getanimlength(var_06);
  wait(var_0C);
  if(isDefined(param_00)) {
    param_00 giverankxp();
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

func_179E(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = func_E08D(param_03);
  var_07 = spawnnewagent(var_06, param_00, param_01, param_02);
  if(isDefined(var_07)) {
    var_07 thread[[var_07 speciesfunc("spawn")]](param_01, param_02, param_03, param_04, param_05);
  }

  return var_07;
}

func_E08D(param_00) {
  var_01 = strtok(param_00, " ");
  if(isDefined(var_01) && var_01.size == 2) {
    return var_01[1];
  }

  return param_00;
}

process_damage_rewards(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  scripts\cp\cp_damage::update_damage_score(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
}

process_damage_feedback(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(!scripts\engine\utility::isbulletdamage(param_04)) {
    if(scripts\cp\utility::is_trap(param_00, param_05)) {
      return;
    }

    var_0B = gettime();
    if(isDefined(param_01.nexthittime) && param_01.nexthittime > var_0B) {
      return;
    } else {
      param_01.nexthittime = var_0B + 250;
    }
  }

  var_0C = "standard";
  var_0D = undefined;
  if(param_0A.health <= param_02) {
    var_0D = 1;
  }

  var_0E = scripts\cp\utility::isheadshot(param_05, param_08, param_04, param_01);
  if(var_0E) {
    var_0C = "hitcritical";
  }

  var_0F = scripts\engine\utility::isbulletdamage(param_04);
  var_10 = var_0E && param_01 scripts\cp\utility::is_consumable_active("sharp_shooter_upgrade");
  var_11 = var_0F && param_01 scripts\cp\utility::is_consumable_active("bonus_damage_on_last_bullets");
  var_12 = var_0F && param_01 scripts\cp\utility::is_consumable_active("damage_booster_upgrade");
  var_13 = scripts\engine\utility::istrue(param_01.inlaststand);
  var_14 = !var_13 && var_0E && var_0F && param_01 scripts\cp\utility::is_consumable_active("headshot_explosion");
  var_15 = !scripts\cp\utility::isreallyalive(param_0A) || isagent(param_0A) && param_02 >= param_0A.health;
  var_16 = param_04 == "MOD_EXPLOSIVE_BULLET" || param_04 == "MOD_EXPLOSIVE" || param_04 == "MOD_GRENADE_SPLASH" || param_04 == "MOD_PROJECTILE" || param_04 == "MOD_PROJECTILE_SPLASH";
  var_17 = param_04 == "MOD_MELEE";
  if(scripts\cp\cp_damage::func_A010(param_05)) {
    var_0C = "special_weapon";
  } else if(var_10 || var_11 || var_12 || var_14) {
    var_0C = "card_boosted";
  } else if(issubstr(param_05, "arkyellow") && param_04 == "MOD_EXPLOSIVE_BULLET" && param_08 == "none") {
    var_0C = "yellow_arcane_cp";
  } else if(isplayer(param_01) && param_01 scripts\cp\utility::has_zombie_perk("perk_machine_boom") && var_16) {
    var_0C = "high_damage";
  } else if(isplayer(param_01) && param_01 scripts\cp\utility::has_zombie_perk("perk_machine_smack") && var_17) {
    var_0C = "high_damage";
  } else if(isplayer(param_01) && param_01 scripts\cp\utility::has_zombie_perk("perk_machine_rat_a_tat") && var_0F) {
    var_0C = "high_damage";
  } else if(isplayer(param_01) && scripts\engine\utility::istrue(param_01.deadeye_charge) && var_0F) {
    var_0C = "dewdrops_cp";
  } else if(scripts\engine\utility::istrue(level.insta_kill)) {
    var_0C = "high_damage";
  } else if(param_05 == "incendiary_ammo_mp") {
    var_0C = "red_arcane_cp";
  } else if(param_05 == "stun_ammo_mp") {
    var_0C = "blue_arcane_cp";
  } else if(param_05 == "slayer_ammo_mp") {
    var_0C = "pink_arcane_cp";
  }

  if(isDefined(param_01)) {
    if(isDefined(param_01.triggerportableradarping)) {
      param_01.triggerportableradarping thread scripts\cp\cp_damage::updatedamagefeedback(var_0C, var_0D, param_02, param_0A.riotblock);
      return;
    }

    param_01 thread scripts\cp\cp_damage::updatedamagefeedback(var_0C, var_0D, param_02, param_0A.riotblock);
  }
}

process_kill_rewards(param_00, param_01, param_02, param_03, param_04) {
  scripts\cp\cp_reward::give_attacker_kill_rewards(param_00, param_02);
  var_05 = get_agent_type(param_01);
  var_06 = scripts\cp\utility::get_attacker_as_player(param_00);
  if(isDefined(var_06)) {
    scripts\cp\cp_persistence::record_player_kills(param_03, param_02, param_04, var_06);
    if(isDefined(level.loot_func) && isDefined(var_05)) {
      [
        [level.loot_func]
      ](var_05, self.origin, param_00);
    }
  }
}

get_alive_enemies() {
  var_00 = getaliveagentsofteam("axis");
  var_01 = [];
  if(isDefined(level.dlc_get_non_agent_enemies)) {
    var_01 = [[level.dlc_get_non_agent_enemies]]();
  }

  var_00 = scripts\engine\utility::array_combine(var_00, var_01);
  return var_00;
}

get_agent_type(param_00) {
  return param_00.agent_type;
}

store_attacker_info(param_00, param_01) {
  param_00 = scripts\cp\utility::get_attacker_as_player(param_00);
  if(!isDefined(param_00)) {
    return;
  }

  if(!isDefined(self.attacker_damage)) {
    self.attacker_damage = [];
  }

  foreach(var_03 in self.attacker_damage) {
    if(var_03.player == param_00) {
      var_03.var_DA = var_03.var_DA + param_01;
      return;
    }
  }

  var_05 = spawnStruct();
  var_05.player = param_00;
  var_05.var_DA = param_01;
  self.attacker_damage[self.attacker_damage.size] = var_05;
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
  foreach(var_01 in level.characters) {
    if(isDefined(var_01.attackers)) {
      foreach(var_04, var_03 in var_01.attackers) {
        if(var_03 == self) {
          var_01.attackers[var_04] = undefined;
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