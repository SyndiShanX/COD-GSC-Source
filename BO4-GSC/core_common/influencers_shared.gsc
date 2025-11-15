/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\influencers_shared.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace influencers;

autoexec __init__system__() {
  system::register(#"influencers_shared", &__init__, undefined, undefined);
}

__init__() {
  if(!isDefined(level.var_3d984b4c)) {
    level.var_3d984b4c = 1;
  }

  if(level.var_3d984b4c) {
    callback::on_connecting(&onplayerconnect);
    callback::on_joined_team(&on_joined_team);
    callback::on_spawned(&onplayerspawned);
  }
}

onplayerspawned() {
  removeallinfluencersfromentity(self);
  self create_player_influencers();
}

onplayerconnect() {
  level endon(#"game_ended");
  self callback::on_grenade_fired(&on_grenade_fired);
  self callback::on_death(&on_player_death);
}

on_player_death(params) {
  if(game.state != "playing") {
    return;
  }

  level create_friendly_influencer("friend_dead", self.origin, self.team);
}

on_joined_team(params) {
  self.lastspawnpoint = undefined;
}

on_grenade_fired(params) {
  grenade = params.projectile;
  weapon = params.weapon;
  level thread create_grenade_influencers(self.pers[#"team"], weapon, grenade);
}

get_friendly_team_mask(team) {
  if(level.teambased) {
    team_mask = util::getteammask(team);
  } else {
    team_mask = level.spawnsystem.ispawn_teammask_free;
  }

  return team_mask;
}

get_enemy_team_mask(team) {
  if(level.teambased) {
    team_mask = util::getotherteamsmask(team);
  } else {
    team_mask = level.spawnsystem.ispawn_teammask_free;
  }

  return team_mask;
}

private add_influencer_tracker(influencer, name) {
  if(!isDefined(self.influencers)) {
    self.influencers = [];
  }

  if(!isDefined(self.influencers[name])) {
    self.influencers[name] = [];
  }

  if(!isDefined(self.influencers[name])) {
    self.influencers[name] = [];
  } else if(!isarray(self.influencers[name])) {
    self.influencers[name] = array(self.influencers[name]);
  }

  self.influencers[name][self.influencers[name].size] = influencer;
}

create_influencer_generic(str_name, origin_or_entity, str_team, is_for_enemy = 0) {
  if(str_team === #"any") {
    team_mask = level.spawnsystem.ispawn_teammask[#"all"];
  } else if(is_for_enemy) {
    team_mask = self get_enemy_team_mask(str_team);
  } else {
    team_mask = self get_friendly_team_mask(str_team);
  }

  if(isentity(origin_or_entity)) {
    influencer = addentityinfluencer(str_name, origin_or_entity, team_mask);
  } else if(isvec(origin_or_entity)) {
    influencer = addinfluencer(str_name, origin_or_entity, team_mask);
  }

  if(!isentity(origin_or_entity)) {
    self add_influencer_tracker(influencer, str_name);
  }

  return influencer;
}

create_influencer(name, origin, team_mask) {
  return addinfluencer(name, origin, team_mask);
}

create_friendly_influencer(name, origin, team) {
  team_mask = self get_friendly_team_mask(team);
  influencer = create_influencer(name, origin, team_mask);
  return influencer;
}

create_enemy_influencer(name, origin, team) {
  team_mask = self get_enemy_team_mask(team);
  influencer = create_influencer(name, origin, team_mask);
  return influencer;
}

create_entity_influencer(name, team_mask) {
  return addentityinfluencer(name, self, team_mask);
}

function_f15009ad(name, origin, var_f317c70c) {
  return function_a116c91b(name, origin, var_f317c70c);
}

create_entity_friendly_influencer(name, team) {
  team_mask = self get_friendly_team_mask(team);
  return self create_entity_influencer(name, team_mask);
}

create_entity_enemy_influencer(name, team) {
  team_mask = self get_enemy_team_mask(team);
  return self create_entity_influencer(name, team_mask);
}

create_player_influencers() {
  if(!isDefined(self.pers[#"team"]) || self.pers[#"team"] == #"spectator") {
    return;
  }

  if(self.influencers_created === 0) {
    return;
  }

  if(!level.teambased) {
    team_mask = level.spawnsystem.ispawn_teammask_free;
    enemy_teams_mask = level.spawnsystem.ispawn_teammask_free;
  } else if(isDefined(self.pers[#"team"])) {
    team = self.pers[#"team"];
    team_mask = util::getteammask(team);
    enemy_teams_mask = util::getotherteamsmask(team);
  } else {
    team_mask = 0;
    enemy_teams_mask = 0;
  }

  angles = self.angles;
  origin = self.origin;
  up = (0, 0, 1);
  forward = (1, 0, 0);
  self create_entity_influencer("enemy", enemy_teams_mask);

  if(level.teambased) {
    self create_entity_influencer("friend", team_mask);
  }

  self.influencers_created = 1;
}

create_player_spawn_influencers(spawn_origin) {
  level create_enemy_influencer("enemy_spawn", spawn_origin, self.pers[#"team"]);
  level create_friendly_influencer("friendly_spawn", spawn_origin, self.pers[#"team"]);
}

private remove_influencer_tracking(to_be_removed) {
  if(isDefined(self.influencers)) {
    foreach(influencer_name_array in self.influencers) {
      arrayremovevalue(influencer_name_array, to_be_removed);
    }
  }
}

private is_influencer_tracked(influencer) {
  if(isDefined(self.influencers)) {
    foreach(influencer_name_array in self.influencers) {
      if(isinarray(influencer_name_array, influencer)) {
        return true;
      }
    }
  }

  return false;
}

remove_influencer(to_be_removed) {
  if(is_influencer_tracked(to_be_removed)) {
    self remove_influencer_tracking(to_be_removed);
  }

  removeinfluencer(to_be_removed);
}

remove_influencers() {
  if(!isDefined(self)) {
    return;
  }

  if(isentity(self)) {
    removeallinfluencersfromentity(self);
  } else if(isDefined(self.influencers)) {
    foreach(influencer_name_array in self.influencers) {
      foreach(influencer in influencer_name_array) {
        self remove_influencer_tracking(influencer);
        removeinfluencer(influencer);
      }
    }
  }

  self.influencers = [];
}

create_grenade_influencers(parent_team, weapon, grenade) {
  pixbeginevent(#"create_grenade_influencers");
  spawn_influencer = weapon.spawninfluencer;

  if(isDefined(grenade.origin) && spawn_influencer != "" && isDefined(level.spawnsystem)) {
    if(!level.teambased || !isDefined(parent_team)) {
      weapon_team_mask = level.spawnsystem.ispawn_teammask_free;
    } else {
      weapon_team_mask = util::getotherteamsmask(parent_team);

      if(level.friendlyfire) {
        weapon_team_mask |= util::getteammask(parent_team);
      }
    }

    grenade create_entity_influencer(spawn_influencer, weapon_team_mask);
  }

  pixendevent();
}

create_map_placed_influencers() {
  staticinfluencerents = getEntArray("mp_uspawn_influencer", "classname");

  for(i = 0; i < staticinfluencerents.size; i++) {
    staticinfluencerent = staticinfluencerents[i];
    create_map_placed_influencer(staticinfluencerent);
  }
}

create_map_placed_influencer(influencer_entity) {
  influencer_id = -1;

  if(isDefined(influencer_entity.script_noteworty)) {
    team_mask = util::getteammask(influencer_entity.script_team);
    level create_enemy_influencer(influencer_entity.script_noteworty, influencer_entity.origin, team_mask);
  } else {
    assertmsg("<dev string:x38>");
  }

  return influencer_id;
}

create_turret_influencer(name) {
  turret = self;
  preset = getinfluencerpreset(name);

  if(!isDefined(preset)) {
    return;
  }

  projected_point = turret.origin + vectorscale(anglesToForward(turret.angles), preset[#"radius"] * 0.7);
  return create_enemy_influencer(name, turret.origin, turret.team);
}