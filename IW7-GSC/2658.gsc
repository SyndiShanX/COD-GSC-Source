/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2658.gsc
***************************************/

outline_monitor_think() {
  self endon("disconnect");
  level endon("game_ended");
  wait 2;

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
    if(!isDefined(var_1.cost)) {
      continue;
    }
    var_02 = 1;
    var_03 = func_7D69(var_01);

    if(var_03 == 3)
      enable_outline_for_player(var_01, self, get_hudoutline_item(var_01, var_02), 1, 0, "high");
    else if(var_03 == 1)
      enable_outline_for_player(var_01, self, 4, 1, 0, "high");
    else
      disable_outline_for_player(var_01, self);

    if(var_04 & 0)
      scripts\engine\utility::waitframe();
  }
}

get_hudoutline_item(var_00, var_01) {
  var_02 = var_0.cost;

  if(isDefined(var_0.struct.weapon) && scripts\cp\cp_weapon::has_weapon_variation(var_0.struct.weapon)) {
    if(isDefined(level.get_weapon_level_func)) {
      var_03 = self[[level.get_weapon_level_func]](var_0.struct.weapon);

      if(var_03 > 1)
        var_02 = 4500;
      else
        var_02 = var_0.cost * 0.5;
    } else
      var_02 = var_0.cost * 0.5;
  }

  if(scripts\cp\cp_persistence::player_has_enough_currency(var_02) || scripts\engine\utility::is_true(var_0.enabled))
    return 3;
  else
    return 1;
}

func_7D69(var_00) {
  var_01 = distancesquared(self.origin, var_0.origin) < 1000000;

  if(!var_01)
    return 0;

  if(scripts\cp\utility::is_holding_deployable())
    return 1;

  if(scripts\cp\utility::has_special_weapon())
    return 1;

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

    wait 0.2;
  }
}

should_put_player_outline_on(var_00) {
  if(self.no_team_outlines)
    return 0;

  if(!isalive(var_00) || !isDefined(var_0.maxhealth) || !var_0.maxhealth || var_0.no_outline)
    return 0;

  var_01 = distancesquared(self.origin, var_0.origin) > 2250000;

  if(var_01)
    return 1;

  var_02 = !bullettracepassed(self getEye(), var_00 getEye(), 0, self);
  return var_02;
}

get_hudoutline_for_player_health(var_00) {
  var_01 = var_0.health / 100;

  if(var_01 <= 0.33 || scripts\cp\cp_laststand::player_in_laststand(var_00))
    return 4;
  else if(var_01 <= 0.66)
    return 5;
  else if(var_01 <= 1.0)
    return 3;
  else
    return 0;
}

enable_outline_for_players(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_00 hudoutlineenableforclients(var_01, var_02, var_03, var_04);
}

enable_outline_for_player(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_00 hudoutlineenableforclient(var_01, var_02, var_03, var_04);
}

disable_outline_for_players(var_00, var_01) {
  var_00 hudoutlinedisableforclients(var_01);
}

disable_outline_for_player(var_00, var_01) {
  var_00 hudoutlinedisableforclient(var_01);
}

disable_outline(var_00) {
  var_00 hudoutlinedisable();
}

enable_outline(var_00, var_01, var_02, var_03) {
  var_00 hudoutlineenable(var_01, var_02, var_03);
}

set_outline(var_00, var_01, var_02) {
  level endon("game_ended");
  level endon("outline_disabled");

  if(!isDefined(var_00))
    var_00 = 4;

  if(!isDefined(var_01))
    var_01 = 0;

  if(!isDefined(var_02))
    var_02 = 0;

  for(;;) {
    foreach(var_04 in scripts\cp\cp_agent_utils::get_alive_enemies()) {
      if(isDefined(var_4.damaged_by_players)) {
        continue;
      }
      if(isDefined(var_4.marked_for_challenge)) {
        continue;
      }
      if(isDefined(var_4.feral_occludes)) {
        enable_outline_for_players(var_04, level.players, var_00, 1, var_02, "high");
        continue;
      }

      enable_outline_for_players(var_04, level.players, var_00, var_01, var_02, "high");
    }

    wait 0.5;
  }
}

set_outline_for_player(var_00, var_01, var_02) {
  level endon("game_ended");
  self endon("outline_disabled");

  if(!isDefined(var_00))
    var_00 = 4;

  if(!isDefined(var_01))
    var_01 = 0;

  if(!isDefined(var_02))
    var_02 = 0;

  for(;;) {
    foreach(var_04 in scripts\cp\cp_agent_utils::get_alive_enemies()) {
      if(isDefined(var_4.damaged_by_players)) {
        continue;
      }
      if(isDefined(var_4.marked_for_challenge)) {
        continue;
      }
      if(isDefined(var_4.feral_occludes)) {
        enable_outline_for_player(var_04, self, var_00, 1, var_02, "high");
        continue;
      }

      enable_outline_for_player(var_04, self, var_00, var_01, var_02, "high");
    }

    wait 0.5;
  }
}

unset_outline() {
  foreach(var_01 in scripts\cp\cp_agent_utils::get_alive_enemies()) {
    if(isDefined(var_1.damaged_by_players)) {
      continue;
    }
    if(isDefined(var_1.marked_for_challenge)) {
      continue;
    }
    disable_outline_for_players(var_01, level.players);
    level notify("outline_disabled");
  }
}

unset_outline_for_player() {
  foreach(var_01 in scripts\cp\cp_agent_utils::get_alive_enemies()) {
    if(isDefined(var_1.damaged_by_players)) {
      continue;
    }
    if(isDefined(var_1.marked_for_challenge)) {
      continue;
    }
    disable_outline_for_player(var_01, self);
    self notify("outline_disabled");
  }
}

save_outline_settings() {
  var_00 = ["r_hudoutlineFillColor0", "r_hudoutlineFillColor1", "r_hudoutlinewidth", "r_hudoutlineOccludedOutlineColor", "r_hudoutlineOccludedInlineColor", "r_hudoutlineOccludedInteriorColor", "r_hudOutlineOccludedColorFromFill", "cg_hud_outline_colors_0", "cg_hud_outline_colors_1", "cg_hud_outline_colors_2", "cg_hud_outline_colors_3", "cg_hud_outline_colors_4", "cg_hud_outline_colors_5", "cg_hud_outline_colors_6"];

  if(!isDefined(level.hudoutlinesettings))
    level.hudoutlinesettings = [];

  foreach(var_02 in var_00)
  level.hudoutlinesettings[var_02] = getdvar(var_02);
}

restore_outline_settings() {
  var_00 = ["r_hudoutlineFillColor0", "r_hudoutlineFillColor1", "r_hudoutlinewidth", "r_hudoutlineOccludedOutlineColor", "r_hudoutlineOccludedInlineColor", "r_hudoutlineOccludedInteriorColor", "r_hudOutlineOccludedColorFromFill", "cg_hud_outline_colors_0", "cg_hud_outline_colors_1", "cg_hud_outline_colors_2", "cg_hud_outline_colors_3", "cg_hud_outline_colors_4", "cg_hud_outline_colors_5", "cg_hud_outline_colors_6"];

  if(!isDefined(level.hudoutlinesettings)) {
    return;
  }
  foreach(var_02 in var_00)
  setdvar(var_02, level.hudoutlinesettings[var_02]);
}