/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\teleport_shared.gsc
***********************************************/

#include scripts\core_common\animation_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicle_shared;

#namespace teleport;

team(kvp, var_dad37549, var_b095575e = 0) {
  level function_1d2a3300();
  var_bac46abd = self function_166effac(kvp, var_dad37549);

  if(!isDefined(var_bac46abd)) {
    return 0;
  }

  if(var_bac46abd.a_s_players.size < level.players.size) {
    assertmsg("<dev string:x38>");
    return undefined;
  }

  foreach(e_player in level.players) {
    foreach(s_teleport in var_bac46abd.a_s_players) {
      if(!(isDefined(s_teleport.b_used) && s_teleport.b_used)) {
        e_player function_29305761(s_teleport, var_bac46abd.var_dad37549, var_b095575e);
        break;
      }
    }
  }

  if(isDefined(level.heroes)) {
    foreach(ai_hero in level.heroes) {
      foreach(s_teleport in var_bac46abd.a_s_heroes) {
        if(isDefined(s_teleport.script_hero_name) && s_teleport.script_hero_name != ai_hero.targetname) {
          continue;
        }

        if(!(isDefined(s_teleport.b_used) && s_teleport.b_used)) {
          ai_hero function_df1911b9(s_teleport, var_bac46abd.var_dad37549);
          break;
        }
      }
    }
  }

  function_ff8a7a3(kvp);
  return 1;
}

player(e_player, kvp, var_dad37549, var_b095575e = 0) {
  if(!isalive(e_player)) {
    return;
  }

  level function_1d2a3300();
  var_20212d26 = self function_e6615993(kvp, var_dad37549);
  str_key = var_20212d26.str_key;
  str_value = var_20212d26.str_value;

  foreach(s_teleport in level.a_s_teleport_players) {
    if(s_teleport.(str_key) === str_value && !(isDefined(s_teleport.b_used) && s_teleport.b_used)) {
      e_player function_29305761(s_teleport, var_20212d26.var_dad37549, var_b095575e);
      return 1;
    }
  }

  return 0;
}

hero(ai_hero, kvp, var_dad37549) {
  level function_1d2a3300();
  var_20212d26 = self function_e6615993(kvp, var_dad37549);
  str_key = var_20212d26.str_key;
  str_value = var_20212d26.str_value;

  foreach(s_teleport in level.var_c89d2304) {
    if(isDefined(s_teleport.script_hero_name) && s_teleport.script_hero_name != ai_hero.targetname) {
      continue;
    }

    if(s_teleport.(str_key) === str_value && !(isDefined(s_teleport.b_used) && s_teleport.b_used)) {
      ai_hero function_df1911b9(s_teleport, var_20212d26.var_dad37549);
      return true;
    }
  }

  return false;
}

function_ff8a7a3(kvp) {
  var_20212d26 = self function_e6615993(kvp);

  foreach(s_teleport in struct::get_array(var_20212d26.str_value, var_20212d26.str_key)) {
    s_teleport.b_used = undefined;
  }
}

private function_1d2a3300() {
  if(!isDefined(level.a_s_teleport_players)) {
    if(!isDefined(level.a_s_teleport_players)) {
      level.a_s_teleport_players = struct::get_array("teleport_player", "variantname");
    }

    if(!isDefined(level.var_c89d2304)) {
      level.var_c89d2304 = struct::get_array("teleport_hero", "variantname");
    }
  }
}

private function_e6615993(kvp, var_dad37549) {
  if(isDefined(self.script_teleport_location)) {
    str_value = self.script_teleport_location;
    str_key = "script_teleport_location";

    if(!isDefined(var_dad37549) && isDefined(self.script_regroup_distance)) {
      var_dad37549 = self.script_regroup_distance;
    }
  } else if(isDefined(kvp) && isarray(kvp)) {
    str_value = kvp[0];
    str_key = kvp[1];
  } else {
    str_value = kvp;
    str_key = "script_teleport_location";
  }

  if(!isDefined(var_dad37549)) {
    var_dad37549 = 0;
  }

  if(!isDefined(str_value) || !isDefined(str_key)) {
    assertmsg("<dev string:x6c>");
    return undefined;
  }

  return {
    #str_value: str_value, 
    #str_key: str_key, 
    #var_dad37549: var_dad37549
  };
}

private function_166effac(kvp, var_dad37549) {
  var_20212d26 = self function_e6615993(kvp, var_dad37549);

  if(!isDefined(var_20212d26)) {
    return undefined;
  }

  str_key = var_20212d26.str_key;
  str_value = var_20212d26.str_value;
  a_s_players = [];

  foreach(s_teleport_player in level.a_s_teleport_players) {
    if(s_teleport_player.(str_key) === str_value) {
      if(!isDefined(a_s_players)) {
        a_s_players = [];
      } else if(!isarray(a_s_players)) {
        a_s_players = array(a_s_players);
      }

      if(!isinarray(a_s_players, s_teleport_player)) {
        a_s_players[a_s_players.size] = s_teleport_player;
      }
    }
  }

  a_s_heroes = [];

  if(isDefined(level.heroes)) {
    foreach(s_teleport_hero in level.var_c89d2304) {
      if(s_teleport_hero.(str_key) === str_value) {
        if(!isDefined(a_s_heroes)) {
          a_s_heroes = [];
        } else if(!isarray(a_s_heroes)) {
          a_s_heroes = array(a_s_heroes);
        }

        if(!isinarray(a_s_heroes, s_teleport_hero)) {
          a_s_heroes[a_s_heroes.size] = s_teleport_hero;
        }
      }
    }

    if(a_s_heroes.size < level.heroes.size) {
      assertmsg("<dev string:xa3>");
      return undefined;
    }
  }

  return {
    #a_s_players: a_s_players, 
    #a_s_heroes: a_s_heroes, 
    #var_dad37549: var_20212d26.var_dad37549
  };
}

private function_29305761(s_teleport, var_dad37549, var_b095575e = 0) {
  self endon(#"death");

  if(distancesquared(s_teleport.origin, self.origin) < var_dad37549 * var_dad37549) {
    return;
  }

  s_teleport.b_used = 1;

  if(!var_b095575e) {
    self thread lui::screen_flash(0, 0.3, 0.3);
  }

  if(self isinvehicle()) {
    vehicle = self getvehicleoccupied();

    if(isDefined(s_teleport.script_allow_vehicle) && s_teleport.script_allow_vehicle) {
      vehicle.origin = s_teleport.origin;
      vehicle.angles = s_teleport.angles;
      self notify(#"teleported");
      vehicle notify(#"teleported");
      return;
    }

    vehicle makevehicleunusable();
  }

  if(isDefined(self._scene_object)) {
    [[self._scene_object]] - > stop();
  } else if(self isplayinganimscripted()) {
    self animation::stop();
  }

  self setorigin(s_teleport.origin);
  self setplayerangles(s_teleport.angles);

  if(isDefined(vehicle)) {
    vehicle thread util::auto_delete();
  }

  self notify(#"teleported");
}

function_df1911b9(s_teleport, var_dad37549) {
  if(distancesquared(s_teleport.origin, self.origin) < var_dad37549 * var_dad37549) {
    return;
  }

  s_teleport.b_used = 1;
  self forceteleport(s_teleport.origin, s_teleport.angles);

  if(isDefined(s_teleport.target)) {
    node = getnode(s_teleport.target, "targetname");
  }

  if(isDefined(node)) {
    self setgoal(node);
  } else {
    self setgoal(s_teleport.origin);
  }

  self notify(#"teleported");
}