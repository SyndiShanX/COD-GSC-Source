/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\infection.gsc
***********************************************/

#using script_3d703ef87a841fe4;
#using scripts\core_common\player\player_role;
#using scripts\core_common\spectating;
#using scripts\core_common\system_shared;
#namespace infection;

function private autoexec __init__system__() {
  system::register(#"infection", &__init__, undefined, undefined, undefined);
}

function __init__() {
  if(!isDefined(level.infection) && getgametypesetting("infectionMode", 0)) {
    initialize();
  }
}

function initialize() {
  level.infection = {
    #perks: [], #bodies: [], #primary_weapon: undefined, #offhand_weapon: undefined, #team: # "none", #var_c4b373ef: []
  };
}

function function_74650d7() {
  if(isDefined(level.infection)) {
    return true;
  }

  return false;
}

function is_infected() {
  return is_true(self.infected);
}

function function_a2d73bc3(team) {
  if(!function_74650d7()) {
    return;
  }

  level.infection.team = team;
}

function function_153000d0(male, female) {
  assert(isDefined(male));
  assert(isDefined(female));
  male_index = player_role::function_97d19493(male);
  female_index = player_role::function_97d19493(female);
  function_e8cc8373(male_index, female_index);
}

function private function_e8cc8373(male, female) {
  assert(isDefined(male));
  assert(isDefined(female));

  if(!function_74650d7()) {
    return;
  }

  level.infection.bodies[0] = male;
  level.infection.bodies[1] = female;
}

function function_db5ddd5f(perk) {
  assert(isDefined(perk));

  if(!function_74650d7()) {
    return;
  }

  if(!isDefined(level.infection.perks)) {
    level.infection.perks = [];
  } else if(!isarray(level.infection.perks)) {
    level.infection.perks = array(level.infection.perks);
  }

  level.infection.perks[level.infection.perks.size] = perk;
}

function function_ff357d24() {
  if(!function_74650d7()) {
    return;
  }

  foreach(perk in level.infection.perks) {
    if(!self hasperk(perk)) {
      self setperk(perk);
    }
  }
}

function give_loadout() {
  self cleartalents();
  self clearperks();
  self function_ff357d24();
}

function give_body() {
  current_role = self player_role::get();

  foreach(body in level.infection.bodies) {
    if(current_role == body) {
      return;
    }
  }

  body_index = self getplayergendertype() == "male" ? 0 : 1;
  self player_role::set(level.infection.bodies[body_index], 1);
  self thread function_da08f4d0();
}

function function_da08f4d0() {
  self endon(#"death");

  while(true) {
    wait randomintrange(3, 5);
    self playSound(#"hash_4325dee8081cb1b3");
  }
}

function function_882350c() {
  xuid = self getxuid();
  level.infection.var_c4b373ef[xuid] = 1;
}

function function_687661ea() {
  xuid = self getxuid();

  if(is_true(level.infection.var_c4b373ef[xuid])) {
    return true;
  }

  return false;
}

function get_infected_team() {
  return level.infection.team;
}

function function_d3da95cf() {
  team = self get_infected_team();

  if(self.sessionstate != "dead") {
    self.switching_teams = 1;
    self.switchedteamsresetgadgets = 1;
    self.joining_team = team;
    self.leaving_team = self.pers[#"team"];
  }

  self teams::function_dc7eaabd(team);
  self.pers[#"weapon"] = undefined;
  self.pers[#"spawnweapon"] = undefined;
  self.pers[#"savedmodel"] = undefined;
  self.pers[#"teamtime"] = undefined;
  self.infected = 1;
  self spectating::set_permissions();
}