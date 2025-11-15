/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2634.gsc
***************************************/

spawnnewagent(var_00, var_01, var_02, var_03, var_04) {
  var_05 = getfreeagent(var_00);

  if(isDefined(var_05)) {
    var_5.connecttime = gettime();
    var_05 set_agent_model(var_05, var_00);
    var_05 set_agent_species(var_05, var_00);
    var_05 species_pre_spawn_init();

    if(is_scripted_agent(var_00))
      var_05 = spawn_scripted_agent(var_05, var_00, var_02, var_03);
    else
      var_05 = spawn_regular_agent(var_05, var_02, var_03);

    var_05 setup_agent(var_00);
    var_05 set_agent_team(var_01);
    var_05 set_agent_spawn_health(var_05, var_00);
    var_05 set_agent_traversal_unit_type(var_05, var_00);
    var_05 addtocharactersarray();
    var_05 activateagent();
  }

  return var_05;
}

set_agent_model(var_00, var_01) {
  var_00 detachall();

  if(isDefined(level.zombieattachfunction) && level.agent_definition[var_01]["traversal_unit_type"] == "zombie")
    var_00[[level.zombieattachfunction]](var_01);
  else {
    var_00 setModel(level.agent_definition[var_01]["body_model"]);
    var_02 = strtok(level.agent_definition[var_01]["other_body_parts"], " ");

    foreach(var_04 in var_02)
    var_00 attach(var_04, "", 1);
  }

  var_00 show();
}

is_scripted_agent(var_00) {
  return level.agent_definition[var_00]["animclass"] != "";
}

spawn_scripted_agent(var_00, var_01, var_02, var_03) {
  var_0.onenteranimstate = var_00 speciesfunc("on_enter_animstate");
  var_0.is_scripted_agent = 1;
  var_00 spawnagent(var_02, var_03, level.agent_definition[var_01]["animclass"], 15, 60);
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

is_alien_agent() {
  return isagent(self) && isDefined(self.species) && self.species == "alien";
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

agent_go_to_pos(var_00, var_01, var_02, var_03, var_04) {
  if(is_agent_scripted(self))
    self ghostskulls_complete_status(var_00);
  else
    self botsetscriptgoal(var_00, var_01, var_02, var_03, var_04);
}

set_agent_species(var_00, var_01) {
  if(!isDefined(level.agent_funcs[var_01]))
    level.agent_funcs[var_01] = [];

  var_0.species = level.agent_definition[var_01]["species"];
  assign_agent_func("spawn", ::default_spawn_func);
  assign_agent_func("on_damaged", ::default_on_damage);
  assign_agent_func("on_damaged_finished", ::default_on_damage_finished);
  assign_agent_func("on_killed", ::default_on_killed);
}

assign_agent_func(var_00, var_01) {
  var_02 = self.agent_type;

  if(!isDefined(level.agent_funcs[var_02][var_00])) {
    if(!isDefined(level.species_funcs[self.species]) || !isDefined(level.species_funcs[self.species][var_00]))
      level.agent_funcs[var_02][var_00] = var_01;
    else
      level.agent_funcs[var_02][var_00] = level.species_funcs[self.species][var_00];
  }
}

set_agent_spawn_health(var_00, var_01) {
  var_00 set_agent_health(level.agent_definition[var_01]["health"]);
}

set_agent_traversal_unit_type(var_00, var_01) {
  if(!can_set_traversal_unit_type(var_00)) {
    return;
  }
  var_00 _meth_828C(level.agent_definition[var_01]["traversal_unit_type"]);
}

can_set_traversal_unit_type(var_00) {
  if(is_agent_scripted(var_00))
    return 1;

  return 0;
}

species_pre_spawn_init() {
  if(isDefined(level.species_funcs[self.species]) && isDefined(level.species_funcs[self.species]["pre_spawn_init"]))
    self[[level.species_funcs[self.species]["pre_spawn_init"]]]();
}

getfreeagent(var_00) {
  var_01 = undefined;

  if(isDefined(level.agentarray)) {
    foreach(var_03 in level.agentarray) {
      if(!isDefined(var_3.isactive) || !var_3.isactive) {
        if(isDefined(var_3.waitingtodeactivate) && var_3.waitingtodeactivate) {
          continue;
        }
        var_01 = var_03;
        var_1.agent_type = var_00;
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
    if(level.characters[var_00] == self)
      return;
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
  if(isagent(var_00) && (!isDefined(var_0.isactive) || !var_0.isactive))
    return undefined;

  if(isagent(var_00) && !isDefined(var_0.classname))
    return undefined;

  return var_00;
}

set_agent_health(var_00) {
  self.agenthealth = var_00;
  self.health = var_00;
  self.maxhealth = var_00;
}

default_spawn_func(var_00, var_01, var_02) {
  var_03 = spawnnewagent("soldier", "axis", var_00, var_01);

  if(!isDefined(var_03))
    return undefined;

  var_03 botsetscriptgoal(var_3.origin, 0, "hunt");
  var_03 botsetstance("stand");
  var_03 takeallweapons();

  if(isDefined(var_02))
    var_03 giveweapon(var_02);
  else
    var_03 giveweapon("iw6_dlcweap02_mp");

  var_03 botsetdifficultysetting("maxInaccuracy", 4.5);
  var_03 botsetdifficultysetting("minInaccuracy", 2.25);
  return var_03;
}

default_on_damage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  var_12 = self;

  if(is_friendly_damage(var_12, var_00)) {
    return;
  }
  var_02 = scripts\cp\cp_damage::func_F29B(var_04, var_05, var_02, var_01, var_03, var_06, var_07, var_08, var_09, var_00);

  if(isplayer(var_01) && !scripts\cp\utility::is_trap(var_00, var_05)) {
    var_02 = scripts\cp\cp_damage::scale_alien_damage_by_perks(var_01, var_02, var_04, var_05);
    var_02 = scripts\cp\cp_damage::scale_alien_damage_by_weapon_type(var_01, var_02, var_04, var_05, var_08);
  }

  var_02 = riot_shield_damage_adjustment(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_12);
  var_02 = scripts\cp\cp_damage::scale_alien_damage_by_prestige(var_01, var_02);
  var_02 = int(var_02);
  process_damage_score(var_01, var_02, var_04);
  process_damage_rewards(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_12);
  process_damage_feedback(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_12);
  var_12[[level.agent_funcs[var_12.agent_type]["on_damaged_finished"]]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, 0.0, var_10, var_11);
}

riot_shield_damage_adjustment(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10) {
  var_10.riotblock = undefined;

  if(var_08 == "shield") {
    var_10.riotblock = 1;
    var_02 = 0;
  }

  return var_02;
}

process_damage_score(var_00, var_01, var_02) {
  if(isDefined(level.update_agent_damage_performance))
    [[level.update_agent_damage_performance]](var_00, var_01, var_02);
}

default_on_damage_finished(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12) {
  self finishagentdamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12);
  var_13 = scripts\cp\utility::is_trap(var_00, var_05);

  if(isDefined(var_01)) {
    if(isplayer(var_01) || isDefined(var_1.owner) && isplayer(var_1.owner)) {
      if(!var_13)
        var_01 scripts\cp\cp_damage::check_for_special_damage(self, var_05, var_04);
    }
  }

  return 1;
}

is_friendly_damage(var_00, var_01) {
  if(isDefined(var_01)) {
    if(isDefined(var_1.team) && var_1.team == var_0.team)
      return 1;

    if(isDefined(var_1.owner) && isDefined(var_1.owner.team) && var_1.owner.team == var_0.team)
      return 1;
  }

  return 0;
}

default_on_killed(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  on_humanoid_agent_killed_common(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, 0);
  deactivateagent();
}

getnumactiveagents(var_00) {
  if(!isDefined(var_00))
    var_00 = "all";

  var_01 = getactiveagentsoftype(var_00);
  return var_1.size;
}

getactiveagentsoftype(var_00) {
  var_01 = [];

  if(!isDefined(level.agentarray))
    return var_01;

  foreach(var_03 in level.agentarray) {
    if(isDefined(var_3.isactive) && var_3.isactive) {
      if(var_00 == "all" || var_3.agent_type == var_00)
        var_1[var_1.size] = var_03;
    }
  }

  return var_01;
}

getaliveagentsofteam(var_00) {
  var_01 = [];

  foreach(var_03 in level.agentarray) {
    if(isalive(var_03) && isDefined(var_3.team) && var_3.team == var_00)
      var_1[var_1.size] = var_03;
  }

  return var_01;
}

getactiveagentsofspecies(var_00) {
  var_01 = [];

  if(!isDefined(level.agentarray))
    return var_01;

  foreach(var_03 in level.agentarray) {
    if(isDefined(var_3.isactive) && var_3.isactive) {
      if(var_3.species == var_00)
        var_1[var_1.size] = var_03;
    }
  }

  return var_01;
}

getaliveagents() {
  var_00 = [];

  foreach(var_02 in level.agentarray) {
    if(isalive(var_02))
      var_0[var_0.size] = var_02;
  }

  return var_00;
}

activateagent() {
  self.isactive = 1;
}

on_humanoid_agent_killed_common(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(scripts\engine\utility::is_true(self.hasriotshieldequipped)) {
    scripts\cp\utility::launchshield(var_02, var_03);

    if(!var_09) {
      var_10 = self dropitem(self getcurrentweapon());

      if(isDefined(var_10)) {
        var_10 thread deletepickupafterawhile();
        var_10.owner = self;
        var_10.ownersattacker = var_01;
        var_10 makeunusable();
      }
    }
  }

  if(isDefined(self.nocorpse)) {
    return;
  }
  var_11 = self;
  self.body = self cloneagent(var_08);

  if(should_do_immediate_ragdoll(self))
    do_immediate_ragdoll(self.body);
  else
    thread delaystartragdoll(self.body, var_06, var_05, var_04, var_00, var_03);

  process_kill_rewards(var_01, var_11, var_06, var_04, var_03);

  if(isDefined(level.update_humanoid_death_challenges))
    [[level.update_humanoid_death_challenges]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08);
}

should_do_immediate_ragdoll(var_00) {
  return scripts\engine\utility::is_true(var_0.do_immediate_ragdoll);
}

do_immediate_ragdoll(var_00) {
  if(isDefined(var_00))
    var_00 startragdoll();
}

delaystartragdoll(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(isDefined(var_00)) {
    var_06 = var_00 _meth_8112();

    if(animhasnotetrack(var_06, "ignore_ragdoll"))
      return;
  }

  if(isDefined(level.noragdollents) && level.noragdollents.size) {
    foreach(var_08 in level.noragdollents) {
      if(distancesquared(var_0.origin, var_8.origin) < 65536)
        return;
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

    if(isDefined(var_11))
      var_10 = var_11[0];
  }

  var_12 = var_10 * getanimlength(var_06);
  wait(var_12);

  if(isDefined(var_00))
    var_00 startragdoll();
}

deletepickupafterawhile() {
  self endon("death");
  wait 60;

  if(!isDefined(self)) {
    return;
  }
  self delete();
}

func_179E(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = func_E08D(var_03);
  var_07 = spawnnewagent(var_06, var_00, var_01, var_02);

  if(isDefined(var_07))
    var_07 thread[[var_07 speciesfunc("spawn")]](var_01, var_02, var_03, var_04, var_05);

  return var_07;
}

func_E08D(var_00) {
  var_01 = strtok(var_00, " ");

  if(isDefined(var_01) && var_1.size == 2)
    return var_1[1];
  else
    return var_00;
}

process_damage_rewards(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10) {
  scripts\cp\cp_damage::update_damage_score(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
}

process_damage_feedback(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10) {
  if(!scripts\engine\utility::isbulletdamage(var_04)) {
    if(scripts\cp\utility::is_trap(var_00, var_05)) {
      return;
    }
    var_11 = gettime();

    if(isDefined(var_1.nexthittime) && var_1.nexthittime > var_11)
      return;
    else
      var_1.nexthittime = var_11 + 250;
  }

  var_12 = "standard";
  var_13 = undefined;

  if(var_10.health <= var_02)
    var_13 = 1;

  var_14 = scripts\cp\utility::isheadshot(var_05, var_08, var_04, var_01);

  if(var_14)
    var_12 = "hitcritical";

  var_15 = scripts\engine\utility::isbulletdamage(var_04);
  var_16 = var_14 && var_01 scripts\cp\utility::is_consumable_active("sharp_shooter_upgrade");
  var_17 = var_15 && var_01 scripts\cp\utility::is_consumable_active("bonus_damage_on_last_bullets");
  var_18 = var_15 && var_01 scripts\cp\utility::is_consumable_active("damage_booster_upgrade");
  var_19 = scripts\engine\utility::is_true(var_1.inlaststand);
  var_20 = !var_19 && var_14 && var_15 && var_01 scripts\cp\utility::is_consumable_active("headshot_explosion");
  var_21 = !scripts\cp\utility::isreallyalive(var_10) || isagent(var_10) && var_02 >= var_10.health;
  var_22 = var_04 == "MOD_EXPLOSIVE_BULLET" || var_04 == "MOD_EXPLOSIVE" || var_04 == "MOD_GRENADE_SPLASH" || var_04 == "MOD_PROJECTILE" || var_04 == "MOD_PROJECTILE_SPLASH";
  var_23 = var_04 == "MOD_MELEE";

  if(scripts\cp\cp_damage::func_A010(var_05))
    var_12 = "special_weapon";
  else if(var_16 || var_17 || var_18 || var_20)
    var_12 = "card_boosted";
  else if(issubstr(var_05, "arkyellow") && var_04 == "MOD_EXPLOSIVE_BULLET" && var_08 == "none")
    var_12 = "yellow_arcane_cp";
  else if(isplayer(var_01) && var_01 scripts\cp\utility::has_zombie_perk("perk_machine_boom") && var_22)
    var_12 = "high_damage";
  else if(isplayer(var_01) && var_01 scripts\cp\utility::has_zombie_perk("perk_machine_smack") && var_23)
    var_12 = "high_damage";
  else if(isplayer(var_01) && var_01 scripts\cp\utility::has_zombie_perk("perk_machine_rat_a_tat") && var_15)
    var_12 = "high_damage";
  else if(isplayer(var_01) && scripts\engine\utility::is_true(var_1.deadeye_charge) && var_15)
    var_12 = "dewdrops_cp";
  else if(scripts\engine\utility::is_true(level.insta_kill))
    var_12 = "high_damage";
  else if(var_05 == "incendiary_ammo_mp")
    var_12 = "red_arcane_cp";
  else if(var_05 == "stun_ammo_mp")
    var_12 = "blue_arcane_cp";
  else if(var_05 == "slayer_ammo_mp")
    var_12 = "pink_arcane_cp";

  if(isDefined(var_01)) {
    if(isDefined(var_1.owner))
      var_1.owner thread scripts\cp\cp_damage::updatedamagefeedback(var_12, var_13, var_02, var_10.riotblock);
    else
      var_01 thread scripts\cp\cp_damage::updatedamagefeedback(var_12, var_13, var_02, var_10.riotblock);
  }
}

process_kill_rewards(var_00, var_01, var_02, var_03, var_04) {
  scripts\cp\cp_reward::give_attacker_kill_rewards(var_00, var_02);
  var_05 = get_agent_type(var_01);
  var_06 = scripts\cp\utility::get_attacker_as_player(var_00);

  if(isDefined(var_06)) {
    scripts\cp\cp_persistence::record_player_kills(var_03, var_02, var_04, var_06);

    if(isDefined(level.loot_func) && isDefined(var_05))
      [[level.loot_func]](var_05, self.origin, var_00);
  }
}

get_alive_enemies() {
  var_00 = getaliveagentsofteam("axis");
  var_01 = [];

  if(isDefined(level.dlc_get_non_agent_enemies))
    var_01 = [[level.dlc_get_non_agent_enemies]]();

  var_00 = scripts\engine\utility::array_combine(var_00, var_01);
  return var_00;
}

get_agent_type(var_00) {
  return var_0.agent_type;
}

store_attacker_info(var_00, var_01) {
  var_00 = scripts\cp\utility::get_attacker_as_player(var_00);

  if(!isDefined(var_00)) {
    return;
  }
  if(!isDefined(self.attacker_damage))
    self.attacker_damage = [];

  foreach(var_03 in self.attacker_damage) {
    if(var_3.player == var_00) {
      var_3.damage = var_3.damage + var_01;
      return;
    }
  }

  var_05 = spawnStruct();
  var_5.player = var_00;
  var_5.damage = var_01;
  self.attacker_damage[self.attacker_damage.size] = var_05;
}

deactivateagent() {
  if(scripts\cp\utility::isgameparticipant(self))
    scripts\cp\utility::removefromparticipantsarray();

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
  self.mutations = undefined;

  foreach(var_01 in level.characters) {
    if(isDefined(var_1.attackers)) {
      foreach(var_04, var_03 in var_1.attackers) {
        if(var_03 == self)
          var_1.attackers[var_04] = undefined;
      }
    }
  }

  if(isDefined(self.headmodel))
    self.headmodel = undefined;

  scripts\mp\mp_agent::deactivateagent();
  self notify("disconnect");
}