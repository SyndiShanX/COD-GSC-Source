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
  foreach(var_04, var_01 in level.outline_weapon_watch_list) {
    if(!isDefined(var_01)) {
      continue;
    }

    if(!isDefined(var_01.cost)) {
      continue;
    }

    var_02 = 1;
    var_03 = func_7D69(var_01);
    if(var_03 == 3) {
      enable_outline_for_player(var_01, self, get_hudoutline_item(var_01, var_02), 1, 0, "high");
    } else if(var_03 == 1) {
      enable_outline_for_player(var_01, self, 4, 1, 0, "high");
    } else {
      disable_outline_for_player(var_01, self);
    }

    if(var_04 & 0) {
      scripts\engine\utility::waitframe();
    }
  }
}

get_hudoutline_item(param_00, param_01) {
  var_02 = param_00.cost;
  if(isDefined(param_00.struct.var_394) && scripts\cp\cp_weapon::has_weapon_variation(param_00.struct.var_394)) {
    if(isDefined(level.get_weapon_level_func)) {
      var_03 = self[[level.get_weapon_level_func]](param_00.struct.var_394);
      if(var_03 > 1) {
        var_02 = 4500;
      } else {
        var_02 = param_00.cost * 0.5;
      }
    } else {
      var_02 = param_00.cost * 0.5;
    }
  }

  if(scripts\cp\cp_persistence::player_has_enough_currency(var_02) || scripts\engine\utility::istrue(param_00.enabled)) {
    return 3;
  }

  return 1;
}

func_7D69(param_00) {
  var_01 = distancesquared(self.origin, param_00.origin) < 1000000;
  if(!var_01) {
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
    foreach(var_01 in level.players) {
      if(self == var_01) {
        continue;
      }

      if(should_put_player_outline_on(var_01)) {
        enable_outline_for_player(var_01, self, get_hudoutline_for_player_health(var_01), 0, 0, "high");
        continue;
      }

      disable_outline_for_player(var_01, self);
    }

    wait(0.2);
  }
}

should_put_player_outline_on(param_00) {
  if(self.no_team_outlines) {
    return 0;
  }

  if(!isalive(param_00) || !isDefined(param_00.maxhealth) || !param_00.maxhealth || param_00.no_outline) {
    return 0;
  }

  if(isDefined(level.shouldplayeroutline)) {
    if(![
        [level.shouldplayeroutline]
      ](self, param_00)) {
      return 0;
    }
  }

  var_01 = distancesquared(self.origin, param_00.origin) > 2250000;
  if(var_01) {
    return 1;
  }

  var_02 = !bullettracepassed(self getEye(), param_00 getEye(), 0, self);
  return var_02;
}

get_hudoutline_for_player_health(param_00) {
  var_01 = param_00.health / 100;
  if(var_01 <= 0.33 || scripts\cp\cp_laststand::player_in_laststand(param_00)) {
    return 4;
  }

  if(var_01 <= 0.66) {
    return 5;
  }

  if(var_01 <= 1) {
    return 3;
  }

  return 0;
}

enable_outline_for_players(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 hudoutlineenableforclients(param_01, param_02, param_03, param_04);
}

enable_outline_for_player(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 hudoutlineenableforclient(param_01, param_02, param_03, param_04);
}

disable_outline_for_players(param_00, param_01) {
  param_00 hudoutlinedisableforclients(param_01);
}

disable_outline_for_player(param_00, param_01) {
  param_00 hudoutlinedisableforclient(param_01);
}

disable_outline(param_00) {
  param_00 hudoutlinedisable();
}

enable_outline(param_00, param_01, param_02, param_03) {
  param_00 hudoutlineenable(param_01, param_02, param_03);
}

set_outline(param_00, param_01, param_02) {
  level endon("game_ended");
  level endon("outline_disabled");
  if(!isDefined(param_00)) {
    param_00 = 4;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  for(;;) {
    foreach(var_04 in scripts\cp\cp_agent_utils::get_alive_enemies()) {
      if(isDefined(var_04.damaged_by_players)) {
        continue;
      }

      if(isDefined(var_04.marked_for_challenge)) {
        continue;
      }

      if(isDefined(var_04.feral_occludes)) {
        enable_outline_for_players(var_04, level.players, param_00, 1, param_02, "high");
        continue;
      }

      enable_outline_for_players(var_04, level.players, param_00, param_01, param_02, "high");
    }

    wait(0.5);
  }
}

set_outline_for_player(param_00, param_01, param_02) {
  level endon("game_ended");
  self endon("outline_disabled");
  if(!isDefined(param_00)) {
    param_00 = 4;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  for(;;) {
    foreach(var_04 in scripts\cp\cp_agent_utils::get_alive_enemies()) {
      if(isDefined(var_04.damaged_by_players)) {
        continue;
      }

      if(isDefined(var_04.marked_for_challenge)) {
        continue;
      }

      if(isDefined(var_04.feral_occludes)) {
        enable_outline_for_player(var_04, self, param_00, 1, param_02, "high");
        continue;
      }

      enable_outline_for_player(var_04, self, param_00, param_01, param_02, "high");
    }

    wait(0.5);
  }
}

unset_outline() {
  foreach(var_01 in scripts\cp\cp_agent_utils::get_alive_enemies()) {
    if(isDefined(var_01.damaged_by_players)) {
      continue;
    }

    if(isDefined(var_01.marked_for_challenge)) {
      continue;
    }

    disable_outline_for_players(var_01, level.players);
    level notify("outline_disabled");
  }
}

unset_outline_for_player() {
  foreach(var_01 in scripts\cp\cp_agent_utils::get_alive_enemies()) {
    if(isDefined(var_01.damaged_by_players)) {
      continue;
    }

    if(isDefined(var_01.marked_for_challenge)) {
      continue;
    }

    disable_outline_for_player(var_01, self);
    self notify("outline_disabled");
  }
}

save_outline_settings() {
  var_00 = ["r_hudoutlineFillColor0", "r_hudoutlineFillColor1", "r_hudoutlinewidth", "r_hudoutlineOccludedOutlineColor", "r_hudoutlineOccludedInlineColor", "r_hudoutlineOccludedInteriorColor", "r_hudOutlineOccludedColorFromFill", "cg_hud_outline_colors_0", "cg_hud_outline_colors_1", "cg_hud_outline_colors_2", "cg_hud_outline_colors_3", "cg_hud_outline_colors_4", "cg_hud_outline_colors_5", "cg_hud_outline_colors_6"];
  if(!isDefined(level.hudoutlinesettings)) {
    level.hudoutlinesettings = [];
  }

  foreach(var_02 in var_00) {
    level.hudoutlinesettings[var_02] = getdvar(var_02);
  }
}

restore_outline_settings() {
  var_00 = ["r_hudoutlineFillColor0", "r_hudoutlineFillColor1", "r_hudoutlinewidth", "r_hudoutlineOccludedOutlineColor", "r_hudoutlineOccludedInlineColor", "r_hudoutlineOccludedInteriorColor", "r_hudOutlineOccludedColorFromFill", "cg_hud_outline_colors_0", "cg_hud_outline_colors_1", "cg_hud_outline_colors_2", "cg_hud_outline_colors_3", "cg_hud_outline_colors_4", "cg_hud_outline_colors_5", "cg_hud_outline_colors_6"];
  if(!isDefined(level.hudoutlinesettings)) {
    return;
  }

  foreach(var_02 in var_00) {
    setdvar(var_02, level.hudoutlinesettings[var_02]);
  }
}