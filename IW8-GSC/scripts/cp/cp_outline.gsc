/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_outline.gsc
***********************************************/

function outline_monitor_think() {
  self endon("disconnect");
  level endon("game_ended");
  wait 2;

  for(;;) {
    item_outline_weapon_monitor();
    wait 0.05;
  }
}

function outline_init() {
  level.outline_weapon_watch_list = [];
}

function item_outline_weapon_monitor() {
  self endon("refresh_outline");

  foreach(var_1 in level.outline_weapon_watch_list) {
    if(!isDefined(var_1)) {
      continue;
    }

    if(!isDefined(var_1.cost)) {
      continue;
    }

    var_2 = 1;
    var_3 = distancesquared(self.origin, var_1.origin) < 1000000;

    if(var_3 && !scripts\cp\utility::is_holding_deployable() && !scripts\cp\utility::has_special_weapon()) {
      enable_outline_for_player(var_1, self, get_hudoutline_item(var_1, var_2), "high");
    } else if(var_3 && (scripts\cp\utility::is_holding_deployable() || scripts\cp\utility::has_special_weapon())) {
      enable_outline_for_player(var_1, self, "outline_depth_orange", "high");
    } else {
      disable_outline_for_player(var_1, self);
    }

    if(var_4 & 0) {
      wait 0.05;
    }
  }
}

function get_hudoutline_item(var_0, var_1) {
  var_2 = var_0.cost;

  if(isDefined(level.has_weapon_variation)) {
    if(isDefined(var_0.struct.weapon) && self[[level.has_weapon_variation]](var_0.struct.weapon)) {
      if(isDefined(level.get_weapon_level_func)) {
        var_3 = self[[level.get_weapon_level_func]](var_0.struct.weapon);

        if(var_3 > 1) {
          var_2 = 4500;
        } else {
          var_2 = var_0.cost * 0.5;
        }
      } else {
        var_2 = var_0.cost * 0.5;
      }
    }
  }

  if(scripts\cp\cp_persistence::player_has_enough_currency(var_2) || istrue(var_0.enabled)) {
    return "outline_depth_cyan";
  }

  return "outline_depth_red";
}

function playeroutlinemonitor() {
  self endon("disconnect");

  for(;;) {
    foreach(var_1 in level.players) {
      if(self == var_1) {
        continue;
      }

      if(should_put_player_outline_on(var_1)) {
        enable_outline_for_player(var_1, self, get_hudoutline_for_player_health(var_1), "high");
        continue;
      }

      disable_outline_for_player(var_1, self);
    }

    wait 0.2;
  }
}

function should_put_player_outline_on(var_0) {
  if(self.no_team_outlines) {
    return 0;
  }

  if(!isalive(var_0) || !isDefined(var_0.maxhealth) || !var_0.maxhealth || var_0.no_outline) {
    return 0;
  }

  var_1 = distancesquared(self.origin, var_0.origin) > 2250000;

  if(var_1) {
    return 1;
  }

  var_2 = !scripts\engine\trace::_bullet_trace_passed(self getEye(), var_0 getEye(), 0, self);
  return var_2;
}

function get_hudoutline_for_player_health(var_0) {
  var_1 = var_0.health / 100;

  if(var_1 <= 0.33 || scripts\cp\cp_laststand::player_in_laststand(var_0)) {
    return "outline_nodepth_red";
  }

  if(var_1 <= 0.66) {
    return "outline_nodepth_orange";
  }

  if(var_1 <= 1) {
    return "outline_nodepth_cyan";
  }

  return "outline_nodepth_white";
}

function enable_outline_for_players(var_0, var_1, var_2, var_3) {
  var_0 hudoutlineenableforclients(var_1, var_2);
}

function enable_outline_for_player(var_0, var_1, var_2, var_3) {
  var_0 hudoutlineenableforclient(var_1, var_2);
}

function disable_outline_for_players(var_0, var_1) {
  var_0 hudoutlinedisableforclients(var_1);
}

function disable_outline_for_player(var_0, var_1) {
  var_0 hudoutlinedisableforclient(var_1);
}

function disable_outline(var_0) {
  var_0 hudoutlinedisable();
}

function enable_outline(var_0, var_1) {
  var_0 hudoutlineenable(var_1);
}

function set_outline(var_0) {
  level endon("game_ended");
  level endon("outline_disabled");
  jumpiftrue(isDefined(var_0)) LOC_0000001c;
  var_0 = "outline_nodepth_orange";

  for(;;) {
    var_1 = scripts\engine\utility::array_combine(level.agentarray, level.ref_14102);

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];

      if(!isDefined(var_3)) {
        continue;
      }

      if(isagent(var_3) && !isalive(var_3)) {
        continue;
      }

      if(isDefined(var_3.damaged_by_players)) {
        continue;
      }

      if(isDefined(var_3.marked_for_challenge)) {
        continue;
      }

      if(isDefined(var_3.team) && var_3.team == "allies") {
        enable_outline_for_players(var_3, level.players, "outline_nodepth_green", "high");
        continue;
      }

      enable_outline_for_players(var_3, level.players, var_0, "high");
    }

    wait 0.5;
  }
}

function set_outline_for_player(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("outline_disabled");

  if(!isDefined(var_0)) {
    var_0 = 4;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  jumpiftrue(isDefined(var_2)) LOC_0000002b;
  var_2 = 0;

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

    wait 0.5;
  }
}

function unset_outline() {
  foreach(var_1 in scripts\cp\cp_agent_utils::getactiveenemyagents("allies")) {
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

function unset_outline_for_player() {
  foreach(var_1 in scripts\cp\cp_agent_utils::getactiveenemyagents("allies")) {
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

function save_outline_settings() {
  var_0 = ["r_hudOutlineFillColor0", "r_hudOutlineFillColor1", "r_hudOutlineWidth", "r_hudOutlineOccludedOutlineColor", "r_hudOutlineOccludedInlineColor", "r_hudOutlineOccludedInteriorColor", "r_hudOutlineOccludedColorFromFill", "cg_hud_outline_colors_0", "cg_hud_outline_colors_1", "cg_hud_outline_colors_2", "cg_hud_outline_colors_3", "cg_hud_outline_colors_4", "cg_hud_outline_colors_5", "cg_hud_outline_colors_6"];

  if(!isDefined(level.hudoutlinesettings)) {
    level.hudoutlinesettings = [];
  }

  foreach(var_2 in var_0) {
    level.hudoutlinesettings[var_2] = getDvar(var_2);
  }
}

function restore_outline_settings() {
  var_0 = ["r_hudOutlineFillColor0", "r_hudOutlineFillColor1", "r_hudOutlineWidth", "r_hudOutlineOccludedOutlineColor", "r_hudOutlineOccludedInlineColor", "r_hudOutlineOccludedInteriorColor", "r_hudOutlineOccludedColorFromFill", "cg_hud_outline_colors_0", "cg_hud_outline_colors_1", "cg_hud_outline_colors_2", "cg_hud_outline_colors_3", "cg_hud_outline_colors_4", "cg_hud_outline_colors_5", "cg_hud_outline_colors_6"];

  if(!isDefined(level.hudoutlinesettings)) {
    return;
  }

  foreach(var_2 in var_0) {
    setDvar(var_2, level.hudoutlinesettings[var_2]);
  }
}

function hudoutline_enable(var_0, var_1) {
  hudoutline_enable_internal(var_1, var_0);
}

function hudoutline_disable(var_0) {
  hudoutline_disable_internal(var_0);
}

function hudoutline_channels_init() {
  if(!isDefined(level.fnhudoutlinedefaultsettings)) {
    level.fnhudoutlinedefaultsettings = &hudoutline_default_settings;
  }

  level.hudoutlinechannels = [];
  hudoutline_add_channel_internal("default", 0, level.fnhudoutlinedefaultsettings);
  setsaveddvar("r_hudOutlineEnable", 1);
  var_0 = [[level.fnhudoutlinedefaultsettings]]();

  for(var_1 = 0; var_1 < 8; var_1++) {
    var_2 = "cg_hud_outline_colors_" + var_1;
    setsaveddvar(var_2, var_0[var_2]);
  }
}

function hudoutline_enable_internal(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "default";
  }

  if(!isDefined(level.hudoutlinechannels)) {
    hudoutline_channels_init();
  }

  if(hudoutline_is_ent_in_channel(var_0, self)) {
    hudoutline_update_entinfo(var_0, self, var_1);
  } else {
    var_2 = level.hudoutlinechannels[var_0].entinfos.size;
    level.hudoutlinechannels[var_0].entinfos[var_2] = hudoutline_create_entinfo(self, var_1);
    thread hudoutline_disable_on_death(var_0);
  }

  jumpiftrue(isDefined(level.hudoutlinechannels[var_0].parentchannel)) LOC_000000d9;

  if(!isDefined(level.hudoutlinecurchannel)) {
    hudoutline_activate_channel(var_0);
  }

  var_3 = level.hudoutlinechannels[level.hudoutlinecurchannel].priority;
  var_4 = level.hudoutlinechannels[var_0].priority;

  if(level.hudoutlinecurchannel != var_0 && var_3 < var_4) {
    hudoutline_activate_channel(var_0);
    return;
  }

  if(level.hudoutlinecurchannel == var_0) {
    _enable_hudoutline_on_ent(self, var_1, var_0);
    return;
  }

  return;
}

function hudoutline_disable_internal(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "default";
  }

  if(!isDefined(level.hudoutlinechannels)) {
    return;
  }

  if(isDefined(self)) {
    self notify(var_0 + "hudoutline_disable");
  }

  var_1 = undefined;

  foreach(var_4, var_3 in level.hudoutlinechannels[var_0].entinfos) {
    if(!isDefined(var_3.ent)) {
      level.hudoutlinechannels[var_0].entinfos[var_4] = undefined;
      continue;
    }

    if(var_3.ent == self) {
      var_1 = var_4;
      level.hudoutlinechannels[var_0].entinfos[var_1] = undefined;
      break;
    }
  }

  var_5 = [];

  foreach(var_7 in level.hudoutlinechannels[var_0].entinfos) {
    if(!isDefined(var_7)) {
      continue;
    }

    var_5 = var_7;
  }

  level.hudoutlinechannels[var_0].entinfos = var_5;

  if(!isDefined(level.hudoutlinecurchannel)) {
    return;
  }

  if(level.hudoutlinecurchannel == var_0) {
    if(isDefined(var_1)) {
      _disable_hudoutline_on_ent(self, var_0);
    }

    if(level.hudoutlinechannels[var_0].entinfos.size == 0) {
      var_8 = 0;

      if(isDefined(level.hudoutlinechannels[var_0].childchannels) && level.hudoutlinechannels[var_0].childchannels.size > 0) {
        foreach(var_10 in level.hudoutlinechannels[var_0].childchannels) {
          if(level.hudoutlinechannels[var_10].entinfos.size > 0) {
            var_8 = 1;
            break;
          }
        }
      }

      if(!var_8) {
        hudoutline_activate_best_channel();
        return;
      }

      return;
    }

    return;
  }

  if(isDefined(level.hudoutlinechannels[var_1].parentchannel) && level.hudoutlinecurchannel == level.hudoutlinechannels[var_1].parentchannel) {
    var_12 = level.hudoutlinechannels[var_1].parentchannel;

    if(isDefined(var_2)) {
      _disable_hudoutline_on_ent(self, var_12);
    }

    if(level.hudoutlinechannels[var_1].entinfos.size == 0) {
      hudoutline_activate_best_channel();
      return;
    }

    return;
  }
}

function hudoutline_activate_best_channel() {
  var_0 = undefined;
  var_1 = undefined;
  jumpiffalse(isDefined(level.hudoutlineforcedchannels) && level.hudoutlineforcedchannels.size > 0) LOC_00000071;

  foreach(var_3 in level.hudoutlineforcedchannels) {
    if(!isDefined(var_0) || level.hudoutlinechannels[var_3].priority > var_0) {
      var_0 = level.hudoutlinechannels[var_3].priority;
      var_1 = var_3;
    }
  }

  goto LOC_00000161;
}

function hudoutline_create_entinfo(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.ent = var_0;
  var_2.hudoutlineassetname = var_1;
  return var_2;
}

function hudoutline_update_entinfo(var_0, var_1, var_2) {
  foreach(var_4 in level.hudoutlinechannels[var_0].entinfos) {
    if(var_4.ent == var_1) {
      var_4.hudoutlineassetname = var_2;
    }
  }
}

function hudoutline_activate_channel(var_0) {
  if(isDefined(level.hudoutlinecurchannel) && level.hudoutlinecurchannel != var_0) {
    hudoutline_deactivate_channel(level.hudoutlinecurchannel);

    if(isDefined(level.hudoutlinechannels[level.hudoutlinecurchannel].childchannels) && level.hudoutlinechannels[level.hudoutlinecurchannel].childchannels.size > 0) {
      foreach(var_2 in level.hudoutlinechannels[level.hudoutlinecurchannel].childchannels) {
        hudoutline_deactivate_channel(var_2);
      }
    }
  }

  level.hudoutlinecurchannel = var_0;
  thread hudoutline_set_channel_settings_delayed(var_0);
  _enable_hudoutline_on_channel_ents(var_0);
}

function _enable_hudoutline_on_channel_ents(var_0) {
  var_1 = _get_sorted_list_of_channel_plus_child_channels(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    foreach(var_4 in level.hudoutlinechannels[var_1[var_2]].entinfos) {
      var_5 = var_4.ent;
      var_5 hudoutlineenable(var_4.hudoutlineassetname);
    }
  }
}

function _enable_hudoutline_on_ent(var_0, var_1, var_2) {
  if(!isDefined(level.hudoutlinechannels[var_2].childchannels) || level.hudoutlinechannels[var_2].childchannels.size == 0) {
    var_0 hudoutlineenable(var_1);
    return;
  }

  var_3 = _get_sorted_list_of_channel_plus_child_channels(var_2, 1);
  var_4 = 0;

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    foreach(var_7 in level.hudoutlinechannels[var_3[var_5]].entinfos) {
      if(var_7.ent == var_0) {
        var_0 hudoutlineenable(var_7.hudoutlineassetname);
        var_4 = 1;
        break;
      }
    }

    if(var_4) {
      break;
    }
  }
}

function _disable_hudoutline_on_ent(var_0, var_1) {
  if(!isDefined(level.hudoutlinechannels[var_1].childchannels) || level.hudoutlinechannels[var_1].childchannels.size == 0) {
    self hudoutlinedisable();
    return;
  }

  var_2 = _get_sorted_list_of_channel_plus_child_channels(var_1, 1);
  var_3 = 0;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    foreach(var_6 in level.hudoutlinechannels[var_2[var_4]].entinfos) {
      if(var_6.ent == var_0) {
        var_0 hudoutlineenable(var_6.hudoutlineassetname);
        var_3 = 1;
        break;
      }
    }

    if(var_3) {
      break;
    }
  }

  if(!var_3) {
    self hudoutlinedisable();
    return;
  }
}

function hudoutline_set_channel_settings_delayed(var_0) {
  level notify("hudoutline_new_channel_settings");
  level endon("hudoutline_new_channel_settings");
  wait 0.05;
  var_1 = [[level.fnhudoutlinedefaultsettings]]();
  var_2 = [[level.hudoutlinechannels[var_0].settingsfunc]]();

  foreach(var_5, var_4 in var_1) {
    if(isDefined(var_2[var_5])) {
      setsaveddvar(var_5, var_2[var_5]);
      continue;
    }

    setsaveddvar(var_5, var_4);
  }

  if(isDefined(level.hudoutlinechannels[var_0].loopingsettingsanimationfunc)) {
    play_animation_on_channel(var_0, level.hudoutlinechannels[var_0].loopingsettingsanimationfunc);
    return;
  }
}

function hudoutline_deactivate_channel(var_0) {
  foreach(var_2 in level.hudoutlinechannels[var_0].entinfos) {
    var_3 = var_2.ent;
    var_3 hudoutlinedisable();
  }
}

function hudoutline_add_channel_internal(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = level.fnhudoutlinedefaultsettings;
  }

  if(!isDefined(level.hudoutlinechannels)) {
    hudoutline_channels_init();
  }

  if(!isDefined(level.hudoutlinechannels[var_0])) {
    level.hudoutlinechannels[var_0] = spawnStruct();
    level.hudoutlinechannels[var_0].channelname = var_0;
    level.hudoutlinechannels[var_0].priority = var_1;
    level.hudoutlinechannels[var_0].settingsfunc = var_2;
    level.hudoutlinechannels[var_0].entinfos = [];
    return;
  }
}

function hudoutline_add_child_channel_internal(var_0, var_1, var_2) {
  if(!isDefined(level.hudoutlinechannels[var_0])) {
    level.hudoutlinechannels[var_0] = spawnStruct();
    level.hudoutlinechannels[var_0].channelname = var_0;
    level.hudoutlinechannels[var_0].priority = var_1;
    level.hudoutlinechannels[var_0].entinfos = [];
    level.hudoutlinechannels[var_0].parentchannel = var_2;
  }

  if(!isDefined(level.hudoutlinechannels[var_2].childchannels)) {
    level.hudoutlinechannels[var_2].childchannels = [];
  }

  level.hudoutlinechannels[var_2].childchannels[level.hudoutlinechannels[var_2].childchannels.size] = var_0;
}

function hudoutline_override_channel_settingsfunc(var_0, var_1) {
  level.hudoutlinechannels[var_0].settingsfunc = var_1;

  if(isDefined(level.hudoutlinecurchannel) && level.hudoutlinecurchannel == var_0) {
    thread hudoutline_set_channel_settings_delayed(var_0);
    return;
  }
}

function hudoutline_is_ent_in_channel(var_0, var_1) {
  foreach(var_3 in level.hudoutlinechannels[var_0].entinfos) {
    if(var_3.ent == var_1) {
      return true;
    }
  }

  return false;
}

function hudoutline_force_channel_internal(var_0, var_1) {
  if(!isDefined(level.hudoutlineforcedchannels)) {
    level.hudoutlineforcedchannels = [];
  }

  jumpiffalse(var_1) LOC_00000059;

  foreach(var_3 in level.hudoutlineforcedchannels) {
    if(var_3 == var_0) {
      return;
    }
  }

  level.hudoutlineforcedchannels[level.hudoutlineforcedchannels.size] = var_0;
  hudoutline_activate_best_channel();
  return;
}

function hudoutline_disable_on_death(var_0, var_1) {
  if(isDefined(var_1)) {
    self endon("endonMsg");
  }

  self endon(var_0 + "hudoutline_disable");
  scripts\engine\utility::ref_143A5("death", "entitydeleted");
  thread hudoutline_disable_internal(var_0);
}

function play_animation_on_channel(var_0, var_1) {
  if(!isDefined(level.hudoutlinecurchannel) || level.hudoutlinecurchannel != var_0) {
    return;
  }

  level notify("hudoutline_new_anim_on_channel_" + var_0);
  level endon("hudoutline_new_channel_settings");
  level endon("hudoutline_new_anim_on_channel_" + var_0);
  level[[var_1]]();
  thread hudoutline_set_channel_settings_delayed(var_0);
}

function play_animation_on_channel_loop(var_0, var_1) {
  level.hudoutlinechannels[var_0].loopingsettingsanimationfunc = var_1;

  if(!isDefined(level.hudoutlinecurchannel) || level.hudoutlinecurchannel != var_0) {
    return;
  }

  play_animation_on_channel(var_0, var_1);
}

function hudoutline_default_settings() {
  var_0 = [];

  if(isDefined(level.player.ar_callout_ent)) {
    var_1 = length2d(level.player.origin - level.player.ar_callout_ent.origin);
    var_2 = clamp(var_1 / 1000, 1, 2);
    var_0 = var_2;
  } else {
    GscBinSkip0(0x2e, "r_hudOutlineWidth", 1);
  }

  GscBinSkip0(0x2e, "r_hudOutlineFillColor0", "0.9 0.9 0.9 0.5");
}

function _get_sorted_list_of_channel_plus_child_channels(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = [];
  GscBinSkip0(0x2e, 0, var_0);
}

function outline_array_insert(var_0, var_1, var_2) {
  if(var_2 == var_0.size) {
    var_3 = var_0;
    GscBinSkip0(0x2e, var_3.size, var_1);
  }

  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    if(var_5 == var_3) {
      var_3 = var_2;
      var_4 = 1;
    }

    var_3 = var_1[var_5];
  }

  return var_3;
}