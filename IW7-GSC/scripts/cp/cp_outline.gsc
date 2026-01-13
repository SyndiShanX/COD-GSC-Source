/*************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\cp_outline.gsc
*************************************/

outline_monitor_think() {
  self endon("disconnect");
  level endon("game_ended");
  wait(2);
  for(;;) {
    item_outline_weapon_monitor();
    scripts\engine\utility::waitframe();
  }
}

outline_init() {
  level.outline_weapon_watch_list = [];
}

item_outline_weapon_monitor() {
  self endon("refresh_outline");
  foreach(var_4, var_1 in level.outline_weapon_watch_list) {
    if(!isDefined(var_1)) {
      continue;
    }

    if(!isDefined(var_1.cost)) {
      continue;
    }

    var_2 = 1;
    var_3 = func_7D69(var_1);
    if(var_3 == 3) {
      enable_outline_for_player(var_1, self, get_hudoutline_item(var_1, var_2), 1, 0, "high");
    } else if(var_3 == 1) {
      enable_outline_for_player(var_1, self, 4, 1, 0, "high");
    } else {
      disable_outline_for_player(var_1, self);
    }

    if(var_4 & 0) {
      scripts\engine\utility::waitframe();
    }
  }
}

get_hudoutline_item(var_0, var_1) {
  var_2 = var_0.cost;
  if(isDefined(var_0.struct.var_394) && scripts\cp\cp_weapon::has_weapon_variation(var_0.struct.var_394)) {
    if(isDefined(level.get_weapon_level_func)) {
      var_3 = self[[level.get_weapon_level_func]](var_0.struct.var_394);
      if(var_3 > 1) {
        var_2 = 4500;
      } else {
        var_2 = var_0.cost * 0.5;
      }
    } else {
      var_2 = var_0.cost * 0.5;
    }
  }

  if(scripts\cp\cp_persistence::player_has_enough_currency(var_2) || scripts\engine\utility::istrue(var_0.enabled)) {
    return 3;
  }

  return 1;
}

func_7D69(var_0) {
  var_1 = distancesquared(self.origin, var_0.origin) < 1000000;
  if(!var_1) {
    return 0;
  }

  if(scripts\cp\utility::is_holding_deployable()) {
    return 1;
  }

  if(scripts\cp\utility::has_special_weapon()) {
    return 1;
  }

  return 3;
}

playeroutlinemonitor() {
  self endon("disconnect");
  for(;;) {
    foreach(var_1 in level.players) {
      if(self == var_1) {
        continue;
      }

      if(should_put_player_outline_on(var_1)) {
        enable_outline_for_player(var_1, self, get_hudoutline_for_player_health(var_1), 0, 0, "high");
        continue;
      }

      disable_outline_for_player(var_1, self);
    }

    wait(0.2);
  }
}

should_put_player_outline_on(var_0) {
  if(self.no_team_outlines) {
    return 0;
  }

  if(!isalive(var_0) || !isDefined(var_0.maxhealth) || !var_0.maxhealth || var_0.no_outline) {
    return 0;
  }

  if(isDefined(level.shouldplayeroutline)) {
    if(![
        [level.shouldplayeroutline]
      ](self, var_0)) {
      return 0;
    }
  }

  var_1 = distancesquared(self.origin, var_0.origin) > 2250000;
  if(var_1) {
    return 1;
  }

  var_2 = !bullettracepassed(self getEye(), var_0 getEye(), 0, self);
  return var_2;
}

get_hudoutline_for_player_health(var_0) {
  var_1 = var_0.health / 100;
  if(var_1 <= 0.33 || scripts\cp\cp_laststand::player_in_laststand(var_0)) {
    return 4;
  }

  if(var_1 <= 0.66) {
    return 5;
  }

  if(var_1 <= 1) {
    return 3;
  }

  return 0;
}

enable_outline_for_players(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 hudoutlineenableforclients(var_1, var_2, var_3, var_4);
}

enable_outline_for_player(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 hudoutlineenableforclient(var_1, var_2, var_3, var_4);
}

disable_outline_for_players(var_0, var_1) {
  var_0 hudoutlinedisableforclients(var_1);
}

disable_outline_for_player(var_0, var_1) {
  var_0 hudoutlinedisableforclient(var_1);
}

disable_outline(var_0) {
  var_0 hudoutlinedisable();
}

enable_outline(var_0, var_1, var_2, var_3) {
  var_0 hudoutlineenable(var_1, var_2, var_3);
}

set_outline(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("outline_disabled");
  if(!isDefined(var_0)) {
    var_0 = 4;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  for(;;) {
    foreach(var_4 in scripts\cp\cp_agent_utils::get_alive_enemies()) {
      if(isDefined(var_4.damaged_by_players)) {
        continue;
      }

      if(isDefined(var_4.marked_for_challenge)) {
        continue;
      }

      if(isDefined(var_4.feral_occludes)) {
        enable_outline_for_players(var_4, level.players, var_0, 1, var_2, "high");
        continue;
      }

      enable_outline_for_players(var_4, level.players, var_0, var_1, var_2, "high");
    }

    wait(0.5);
  }
}

set_outline_for_player(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("outline_disabled");
  if(!isDefined(var_0)) {
    var_0 = 4;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  for(;;) {
    foreach(var_4 in scripts\cp\cp_agent_utils::get_alive_enemies()) {
      if(isDefined(var_4.damaged_by_players)) {
        continue;
      }

      if(isDefined(var_4.marked_for_challenge)) {
        continue;
      }

      if(isDefined(var_4.feral_occludes)) {
        enable_outline_for_player(var_4, self, var_0, 1, var_2, "high");
        continue;
      }

      enable_outline_for_player(var_4, self, var_0, var_1, var_2, "high");
    }

    wait(0.5);
  }
}

unset_outline() {
  foreach(var_1 in scripts\cp\cp_agent_utils::get_alive_enemies()) {
    if(isDefined(var_1.damaged_by_players)) {
      continue;
    }

    if(isDefined(var_1.marked_for_challenge)) {
      continue;
    }

    disable_outline_for_players(var_1, level.players);
    level notify("outline_disabled");
  }
}

unset_outline_for_player() {
  foreach(var_1 in scripts\cp\cp_agent_utils::get_alive_enemies()) {
    if(isDefined(var_1.damaged_by_players)) {
      continue;
    }

    if(isDefined(var_1.marked_for_challenge)) {
      continue;
    }

    disable_outline_for_player(var_1, self);
    self notify("outline_disabled");
  }
}

save_outline_settings() {
  var_0 = ["r_hudoutlineFillColor0", "r_hudoutlineFillColor1", "r_hudoutlinewidth", "r_hudoutlineOccludedOutlineColor", "r_hudoutlineOccludedInlineColor", "r_hudoutlineOccludedInteriorColor", "r_hudOutlineOccludedColorFromFill", "cg_hud_outline_colors_0", "cg_hud_outline_colors_1", "cg_hud_outline_colors_2", "cg_hud_outline_colors_3", "cg_hud_outline_colors_4", "cg_hud_outline_colors_5", "cg_hud_outline_colors_6"];
  if(!isDefined(level.hudoutlinesettings)) {
    level.hudoutlinesettings = [];
  }

  foreach(var_2 in var_0) {
    level.hudoutlinesettings[var_2] = getdvar(var_2);
  }
}

restore_outline_settings() {
  var_0 = ["r_hudoutlineFillColor0", "r_hudoutlineFillColor1", "r_hudoutlinewidth", "r_hudoutlineOccludedOutlineColor", "r_hudoutlineOccludedInlineColor", "r_hudoutlineOccludedInteriorColor", "r_hudOutlineOccludedColorFromFill", "cg_hud_outline_colors_0", "cg_hud_outline_colors_1", "cg_hud_outline_colors_2", "cg_hud_outline_colors_3", "cg_hud_outline_colors_4", "cg_hud_outline_colors_5", "cg_hud_outline_colors_6"];
  if(!isDefined(level.hudoutlinesettings)) {
    return;
  }

  foreach(var_2 in var_0) {
    setdvar(var_2, level.hudoutlinesettings[var_2]);
  }
}