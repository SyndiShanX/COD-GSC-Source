/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\infection.gsc
***********************************************/

#include scripts\core_common\platoons;
#include scripts\core_common\player\player_role;
#include scripts\core_common\spectating;
#include scripts\core_common\system_shared;
#include scripts\core_common\teams;

#namespace infection;

autoexec __init__system__() {
  system::register(#"infection", &__init__, undefined, undefined);
}

__init__() {
  if(!isDefined(level.infection) && getgametypesetting("infectionMode", 0)) {
    initialize();
  }
}

initialize() {
  level.infection = {
    #perks: [], 
    #bodies: [], 
    #primary_weapon: undefined, 
    #offhand_weapon: undefined, 
    #team: #"none", 
    #platoon: #"invalid", 
    #var_c4b373ef: [], 
    #platoon_team: []
  };
}

function_74650d7() {
  if(isDefined(level.infection)) {
    return true;
  }

  return false;
}

is_infected() {
  return isDefined(self.infected) && self.infected;
}

function_a2d73bc3(team) {
  if(!function_74650d7()) {
    return;
  }

  level.infection.team = team;
}

function_fb163563(platoon) {
  if(!function_74650d7()) {
    return;
  }

  level.infection.platoon = platoon;
}

function_153000d0(male, female) {
  assert(isDefined(male));
  assert(isDefined(female));
  male_index = player_role::function_97d19493(male);
  female_index = player_role::function_97d19493(female);
  function_e8cc8373(male_index, female_index);
}

private function_e8cc8373(male, female) {
  assert(isDefined(male));
  assert(isDefined(female));

  if(!function_74650d7()) {
    return;
  }

  level.infection.bodies[0] = male;
  level.infection.bodies[1] = female;
}

function_db5ddd5f(perk) {
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

function_ff357d24() {
  if(!function_74650d7()) {
    return;
  }

  foreach(perk in level.infection.perks) {
    if(!self hasperk(perk)) {
      self setperk(perk);
    }
  }
}

give_loadout() {
  self cleartalents();
  self clearperks();
  self function_ff357d24();
}

reset_character() {
  if(!isplayer(self)) {
    assert(0);
    return;
  }

  self setcharacteroutfit(0);
  self setcharacterwarpaintoutfit(0);
  self function_ab96a9b5("head", 0);
  self function_ab96a9b5("headgear", 0);
  self function_ab96a9b5("arms", 0);
  self function_ab96a9b5("torso", 0);
  self function_ab96a9b5("legs", 0);
  self function_ab96a9b5("palette", 0);
  self function_ab96a9b5("warpaint", 0);
  self function_ab96a9b5("decal", 0);
}

give_body() {
  if(self hasdobj() && self haspart("j_spine4")) {
    self playsoundontag(#"hash_3407b7c42e8075c9", "j_spine4");
  }

  self thread function_da08f4d0();
  current_role = self player_role::get();

  foreach(body in level.infection.bodies) {
    if(current_role == body) {
      self reset_character();
      return;
    }
  }

  body_index = self getplayergendertype() == "male" ? 0 : 1;
  self player_role::set(level.infection.bodies[body_index], 1);
  self reset_character();
}

function_da08f4d0() {
  self endon(#"death");
  wait randomintrange(2, 4);

  while(true) {
    str_alias = #"hash_61fc4fa3eeafcf07";
    n_wait_min = 2;
    n_wait_max = 5;

    if(self issprinting()) {
      str_alias = #"hash_64441bbb83e130e9";
      n_wait_min = 4;
      n_wait_max = 7;
    }

    if(self hasdobj() && self haspart("j_spine4")) {
      self playsoundontag(str_alias, "j_spine4");
    }

    wait randomintrange(n_wait_min, n_wait_max);
  }
}

function_882350c() {
  xuid = self getxuid();
  level.infection.var_c4b373ef[xuid] = 1;
}

function_687661ea() {
  xuid = self getxuid();

  if(isDefined(level.infection.var_c4b373ef[xuid]) && level.infection.var_c4b373ef[xuid]) {
    return true;
  }

  return false;
}

private get_infected_team() {
  if(level.infection.platoon != #"invalid") {
    if(self is_infected()) {
      return self.team;
    }

    if(isDefined(level.infection.platoon_team[self.team])) {
      return level.infection.platoon_team[self.team];
    }

    team = self.team;

    if(team != #"spectator") {
      players_on_team = getplayers(team);

      if(players_on_team.size <= 1) {
        return team;
      }
    }

    team = teams::function_959bac94();
    return team;
  }

  return level.infection.team;
}

function_76601b7d() {
  return level.infection.platoon;
}

function_d3da95cf() {
  team = self get_infected_team();
  platoon = function_76601b7d();

  if(platoon != #"invalid") {
    level.infection.platoon_team[self.team] = team;
    platoons::function_334c4bec(team, platoon);
  }

  if(!isDefined(level.everexisted[team])) {
    level.everexisted[team] = gettime();
  }

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