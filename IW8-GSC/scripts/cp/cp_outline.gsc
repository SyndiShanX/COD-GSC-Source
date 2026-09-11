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

  foreach(var1 in level.outline_weapon_watch_list) {
    if(!isDefined(var1)) {
      continue;
    }

    if(!isDefined(var1.cost)) {
      continue;
    }

    var2 = 1;
    var3 = distancesquared(self.origin, var1.origin) < 1000000;

    if(var3 && !scripts\cp\utility::is_holding_deployable() && !scripts\cp\utility::has_special_weapon()) {
      enable_outline_for_player(var1, self, get_hudoutline_item(var1, var2), "high");
    } else if(var3 && (scripts\cp\utility::is_holding_deployable() || scripts\cp\utility::has_special_weapon())) {
      enable_outline_for_player(var1, self, "outline_depth_orange", "high");
    } else {
      disable_outline_for_player(var1, self);
    }

    if(var4 & 0) {
      wait 0.05;
    }
  }
}

function get_hudoutline_item(var0, var1) {
  var2 = var0.cost;

  if(isDefined(level.has_weapon_variation)) {
    if(isDefined(var0.struct.weapon) && self[[level.has_weapon_variation]](var0.struct.weapon)) {
      if(isDefined(level.get_weapon_level_func)) {
        var3 = self[[level.get_weapon_level_func]](var0.struct.weapon);

        if(var3 > 1) {
          var2 = 4500;
        } else {
          var2 = var0.cost * 0.5;
        }
      } else {
        var2 = var0.cost * 0.5;
      }
    }
  }

  if(scripts\cp\cp_persistence::player_has_enough_currency(var2) || istrue(var0.enabled)) {
    return "outline_depth_cyan";
  }

  return "outline_depth_red";
}

function playeroutlinemonitor() {
  self endon("disconnect");

  for(;;) {
    foreach(var1 in level.players) {
      if(self == var1) {
        continue;
      }

      if(should_put_player_outline_on(var1)) {
        enable_outline_for_player(var1, self, get_hudoutline_for_player_health(var1), "high");
        continue;
      }

      disable_outline_for_player(var1, self);
    }

    wait 0.2;
  }
}

function should_put_player_outline_on(var0) {
  if(self.no_team_outlines) {
    return 0;
  }

  if(!isalive(var0) || !isDefined(var0.maxhealth) || !var0.maxhealth || var0.no_outline) {
    return 0;
  }

  var1 = distancesquared(self.origin, var0.origin) > 2250000;

  if(var1) {
    return 1;
  }

  var2 = !scripts\engine\trace::_bullet_trace_passed(self getEye(), var0 getEye(), 0, self);
  return var2;
}

function get_hudoutline_for_player_health(var0) {
  var1 = var0.health / 100;

  if(var1 <= 0.33 || scripts\cp\cp_laststand::player_in_laststand(var0)) {
    return "outline_nodepth_red";
  }

  if(var1 <= 0.66) {
    return "outline_nodepth_orange";
  }

  if(var1 <= 1) {
    return "outline_nodepth_cyan";
  }

  return "outline_nodepth_white";
}

function enable_outline_for_players(var0, var1, var2, var3) {
  var0 hudoutlineenableforclients(var1, var2);
}

function enable_outline_for_player(var0, var1, var2, var3) {
  var0 hudoutlineenableforclient(var1, var2);
}

function disable_outline_for_players(var0, var1) {
  var0 hudoutlinedisableforclients(var1);
}

function disable_outline_for_player(var0, var1) {
  var0 hudoutlinedisableforclient(var1);
}

function disable_outline(var0) {
  var0 hudoutlinedisable();
}

function enable_outline(var0, var1) {
  var0 hudoutlineenable(var1);
}

function set_outline(var0) {
  level endon("game_ended");
  level endon("outline_disabled");
  jumpiftrue(isDefined(var0)) LOC_0000001c;
  var0 = "outline_nodepth_orange";

  for(;;) {
    var1 = scripts\engine\utility::array_combine(level.agentarray, level.ref_14102);

    for(var2 = 0; var2 < var1.size; var2++) {
      var3 = var1[var2];

      if(!isDefined(var3)) {
        continue;
      }

      if(isagent(var3) && !isalive(var3)) {
        continue;
      }

      if(isDefined(var3.damaged_by_players)) {
        continue;
      }

      if(isDefined(var3.marked_for_challenge)) {
        continue;
      }

      if(isDefined(var3.team) && var3.team == "allies") {
        enable_outline_for_players(var3, level.players, "outline_nodepth_green", "high");
        continue;
      }

      enable_outline_for_players(var3, level.players, var0, "high");
    }

    wait 0.5;
  }
}

function set_outline_for_player(var0, var1, var2) {
  level endon("game_ended");
  self endon("outline_disabled");

  if(!isDefined(var0)) {
    var0 = 4;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  jumpiftrue(isDefined(var2)) LOC_0000002b;
  var2 = 0;

  for(;;) {
    foreach(var4 in scripts\cp\cp_agent_utils::get_alive_enemies()) {
      if(isDefined(var4.damaged_by_players)) {
        continue;
      }

      if(isDefined(var4.marked_for_challenge)) {
        continue;
      }

      if(isDefined(var4.feral_occludes)) {
        enable_outline_for_player(var4, self, var0, 1, var2, "high");
        continue;
      }

      enable_outline_for_player(var4, self, var0, var1, var2, "high");
    }

    wait 0.5;
  }
}

function unset_outline() {
  foreach(var1 in scripts\cp\cp_agent_utils::getactiveenemyagents("allies")) {
    if(isDefined(var1.damaged_by_players)) {
      continue;
    }

    if(isDefined(var1.marked_for_challenge)) {
      continue;
    }

    disable_outline_for_players(var1, level.players);
    level notify("outline_disabled");
  }
}

function unset_outline_for_player() {
  foreach(var1 in scripts\cp\cp_agent_utils::getactiveenemyagents("allies")) {
    if(isDefined(var1.damaged_by_players)) {
      continue;
    }

    if(isDefined(var1.marked_for_challenge)) {
      continue;
    }

    disable_outline_for_player(var1, self);
    self notify("outline_disabled");
  }
}

function save_outline_settings() {
  var0 = ["LRMPROLMKN", "NTOSKSTKQQ", "MKOQSSQKLL", "NSNOLMTLLL", "LSRTPRNOLS", "LNNOSQKRTP", "RKSQOKQNK", "cg_hud_outline_colors_0", "cg_hud_outline_colors_1", "cg_hud_outline_colors_2", "cg_hud_outline_colors_3", "cg_hud_outline_colors_4", "cg_hud_outline_colors_5", "cg_hud_outline_colors_6"];

  if(!isDefined(level.hudoutlinesettings)) {
    level.hudoutlinesettings = [];
  }

  foreach(var2 in var0) {
    level.hudoutlinesettings[var2] = getDvar(var2);
  }
}

function restore_outline_settings() {
  var0 = ["LRMPROLMKN", "NTOSKSTKQQ", "MKOQSSQKLL", "NSNOLMTLLL", "LSRTPRNOLS", "LNNOSQKRTP", "RKSQOKQNK", "cg_hud_outline_colors_0", "cg_hud_outline_colors_1", "cg_hud_outline_colors_2", "cg_hud_outline_colors_3", "cg_hud_outline_colors_4", "cg_hud_outline_colors_5", "cg_hud_outline_colors_6"];

  if(!isDefined(level.hudoutlinesettings)) {
    return;
  }

  foreach(var2 in var0) {
    setDvar(var2, level.hudoutlinesettings[var2]);
  }
}

function hudoutline_enable(var0, var1) {
  hudoutline_enable_internal(var1, var0);
}

function hudoutline_disable(var0) {
  hudoutline_disable_internal(var0);
}

function hudoutline_channels_init() {
  if(!isDefined(level.fnhudoutlinedefaultsettings)) {
    level.fnhudoutlinedefaultsettings = &hudoutline_default_settings;
  }

  level.hudoutlinechannels = [];
  hudoutline_add_channel_internal("default", 0, level.fnhudoutlinedefaultsettings);
  setsaveddvar("NMROQRRONQ", 1);
  var0 = [[level.fnhudoutlinedefaultsettings]]();

  for(var1 = 0; var1 < 8; var1++) {
    var2 = "cg_hud_outline_colors_" + var1;
    setsaveddvar(var2, var0[var2]);
  }
}

function hudoutline_enable_internal(var0, var1) {
  if(!isDefined(var0)) {
    var0 = "default";
  }

  if(!isDefined(level.hudoutlinechannels)) {
    hudoutline_channels_init();
  }

  if(hudoutline_is_ent_in_channel(var0, self)) {
    hudoutline_update_entinfo(var0, self, var1);
  } else {
    var2 = level.hudoutlinechannels[var0].entinfos.size;
    level.hudoutlinechannels[var0].entinfos[var2] = hudoutline_create_entinfo(self, var1);
    thread hudoutline_disable_on_death(var0);
  }

  jumpiftrue(isDefined(level.hudoutlinechannels[var0].parentchannel)) LOC_000000d9;

  if(!isDefined(level.hudoutlinecurchannel)) {
    hudoutline_activate_channel(var0);
  }

  var3 = level.hudoutlinechannels[level.hudoutlinecurchannel].priority;
  var4 = level.hudoutlinechannels[var0].priority;

  if(level.hudoutlinecurchannel != var0 && var3 < var4) {
    hudoutline_activate_channel(var0);
    return;
  }

  if(level.hudoutlinecurchannel == var0) {
    _enable_hudoutline_on_ent(self, var1, var0);
    return;
  }

  return;
}

function hudoutline_disable_internal(var0) {
  if(!isDefined(var0)) {
    var0 = "default";
  }

  if(!isDefined(level.hudoutlinechannels)) {
    return;
  }

  if(isDefined(self)) {
    self notify(var0 + "hudoutline_disable");
  }

  var1 = undefined;

  foreach(var4, var3 in level.hudoutlinechannels[var0].entinfos) {
    if(!isDefined(var3.ent)) {
      level.hudoutlinechannels[var0].entinfos[var4] = undefined;
      continue;
    }

    if(var3.ent == self) {
      var1 = var4;
      level.hudoutlinechannels[var0].entinfos[var1] = undefined;
      break;
    }
  }

  var5 = [];

  foreach(var7 in level.hudoutlinechannels[var0].entinfos) {
    if(!isDefined(var7)) {
      continue;
    }

    var5 = var7;
  }

  level.hudoutlinechannels[var0].entinfos = var5;

  if(!isDefined(level.hudoutlinecurchannel)) {
    return;
  }

  if(level.hudoutlinecurchannel == var0) {
    if(isDefined(var1)) {
      _disable_hudoutline_on_ent(self, var0);
    }

    if(level.hudoutlinechannels[var0].entinfos.size == 0) {
      var8 = 0;

      if(isDefined(level.hudoutlinechannels[var0].childchannels) && level.hudoutlinechannels[var0].childchannels.size > 0) {
        foreach(var10 in level.hudoutlinechannels[var0].childchannels) {
          if(level.hudoutlinechannels[var10].entinfos.size > 0) {
            var8 = 1;
            break;
          }
        }
      }

      if(!var8) {
        hudoutline_activate_best_channel();
        return;
      }

      return;
    }

    return;
  }

  if(isDefined(level.hudoutlinechannels[var1].parentchannel) && level.hudoutlinecurchannel == level.hudoutlinechannels[var1].parentchannel) {
    var12 = level.hudoutlinechannels[var1].parentchannel;

    if(isDefined(var2)) {
      _disable_hudoutline_on_ent(self, var12);
    }

    if(level.hudoutlinechannels[var1].entinfos.size == 0) {
      hudoutline_activate_best_channel();
      return;
    }

    return;
  }
}

function hudoutline_activate_best_channel() {
  var0 = undefined;
  var1 = undefined;
  jumpiffalse(isDefined(level.hudoutlineforcedchannels) && level.hudoutlineforcedchannels.size > 0) LOC_00000071;

  foreach(var3 in level.hudoutlineforcedchannels) {
    if(!isDefined(var0) || level.hudoutlinechannels[var3].priority > var0) {
      var0 = level.hudoutlinechannels[var3].priority;
      var1 = var3;
    }
  }

  goto LOC_00000161;
}

function hudoutline_create_entinfo(var0, var1) {
  var2 = spawnStruct();
  var2.ent = var0;
  var2.hudoutlineassetname = var1;
  return var2;
}

function hudoutline_update_entinfo(var0, var1, var2) {
  foreach(var4 in level.hudoutlinechannels[var0].entinfos) {
    if(var4.ent == var1) {
      var4.hudoutlineassetname = var2;
    }
  }
}

function hudoutline_activate_channel(var0) {
  if(isDefined(level.hudoutlinecurchannel) && level.hudoutlinecurchannel != var0) {
    hudoutline_deactivate_channel(level.hudoutlinecurchannel);

    if(isDefined(level.hudoutlinechannels[level.hudoutlinecurchannel].childchannels) && level.hudoutlinechannels[level.hudoutlinecurchannel].childchannels.size > 0) {
      foreach(var2 in level.hudoutlinechannels[level.hudoutlinecurchannel].childchannels) {
        hudoutline_deactivate_channel(var2);
      }
    }
  }

  level.hudoutlinecurchannel = var0;
  thread hudoutline_set_channel_settings_delayed(var0);
  _enable_hudoutline_on_channel_ents(var0);
}

function _enable_hudoutline_on_channel_ents(var0) {
  var1 = _get_sorted_list_of_channel_plus_child_channels(var0);

  for(var2 = 0; var2 < var1.size; var2++) {
    foreach(var4 in level.hudoutlinechannels[var1[var2]].entinfos) {
      var5 = var4.ent;
      var5 hudoutlineenable(var4.hudoutlineassetname);
    }
  }
}

function _enable_hudoutline_on_ent(var0, var1, var2) {
  if(!isDefined(level.hudoutlinechannels[var2].childchannels) || level.hudoutlinechannels[var2].childchannels.size == 0) {
    var0 hudoutlineenable(var1);
    return;
  }

  var3 = _get_sorted_list_of_channel_plus_child_channels(var2, 1);
  var4 = 0;

  for(var5 = 0; var5 < var3.size; var5++) {
    foreach(var7 in level.hudoutlinechannels[var3[var5]].entinfos) {
      if(var7.ent == var0) {
        var0 hudoutlineenable(var7.hudoutlineassetname);
        var4 = 1;
        break;
      }
    }

    if(var4) {
      break;
    }
  }
}

function _disable_hudoutline_on_ent(var0, var1) {
  if(!isDefined(level.hudoutlinechannels[var1].childchannels) || level.hudoutlinechannels[var1].childchannels.size == 0) {
    self hudoutlinedisable();
    return;
  }

  var2 = _get_sorted_list_of_channel_plus_child_channels(var1, 1);
  var3 = 0;

  for(var4 = 0; var4 < var2.size; var4++) {
    foreach(var6 in level.hudoutlinechannels[var2[var4]].entinfos) {
      if(var6.ent == var0) {
        var0 hudoutlineenable(var6.hudoutlineassetname);
        var3 = 1;
        break;
      }
    }

    if(var3) {
      break;
    }
  }

  if(!var3) {
    self hudoutlinedisable();
    return;
  }
}

function hudoutline_set_channel_settings_delayed(var0) {
  level notify("hudoutline_new_channel_settings");
  level endon("hudoutline_new_channel_settings");
  wait 0.05;
  var1 = [[level.fnhudoutlinedefaultsettings]]();
  var2 = [[level.hudoutlinechannels[var0].settingsfunc]]();

  foreach(var5, var4 in var1) {
    if(isDefined(var2[var5])) {
      setsaveddvar(var5, var2[var5]);
      continue;
    }

    setsaveddvar(var5, var4);
  }

  if(isDefined(level.hudoutlinechannels[var0].loopingsettingsanimationfunc)) {
    play_animation_on_channel(var0, level.hudoutlinechannels[var0].loopingsettingsanimationfunc);
    return;
  }
}

function hudoutline_deactivate_channel(var0) {
  foreach(var2 in level.hudoutlinechannels[var0].entinfos) {
    var3 = var2.ent;
    var3 hudoutlinedisable();
  }
}

function hudoutline_add_channel_internal(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = level.fnhudoutlinedefaultsettings;
  }

  if(!isDefined(level.hudoutlinechannels)) {
    hudoutline_channels_init();
  }

  if(!isDefined(level.hudoutlinechannels[var0])) {
    level.hudoutlinechannels[var0] = spawnStruct();
    level.hudoutlinechannels[var0].channelname = var0;
    level.hudoutlinechannels[var0].priority = var1;
    level.hudoutlinechannels[var0].settingsfunc = var2;
    level.hudoutlinechannels[var0].entinfos = [];
    return;
  }
}

function hudoutline_add_child_channel_internal(var0, var1, var2) {
  if(!isDefined(level.hudoutlinechannels[var0])) {
    level.hudoutlinechannels[var0] = spawnStruct();
    level.hudoutlinechannels[var0].channelname = var0;
    level.hudoutlinechannels[var0].priority = var1;
    level.hudoutlinechannels[var0].entinfos = [];
    level.hudoutlinechannels[var0].parentchannel = var2;
  }

  if(!isDefined(level.hudoutlinechannels[var2].childchannels)) {
    level.hudoutlinechannels[var2].childchannels = [];
  }

  level.hudoutlinechannels[var2].childchannels[level.hudoutlinechannels[var2].childchannels.size] = var0;
}

function hudoutline_override_channel_settingsfunc(var0, var1) {
  level.hudoutlinechannels[var0].settingsfunc = var1;

  if(isDefined(level.hudoutlinecurchannel) && level.hudoutlinecurchannel == var0) {
    thread hudoutline_set_channel_settings_delayed(var0);
    return;
  }
}

function hudoutline_is_ent_in_channel(var0, var1) {
  foreach(var3 in level.hudoutlinechannels[var0].entinfos) {
    if(var3.ent == var1) {
      return true;
    }
  }

  return false;
}

function hudoutline_force_channel_internal(var0, var1) {
  if(!isDefined(level.hudoutlineforcedchannels)) {
    level.hudoutlineforcedchannels = [];
  }

  jumpiffalse(var1) LOC_00000059;

  foreach(var3 in level.hudoutlineforcedchannels) {
    if(var3 == var0) {
      return;
    }
  }

  level.hudoutlineforcedchannels[level.hudoutlineforcedchannels.size] = var0;
  hudoutline_activate_best_channel();
  return;
}

function hudoutline_disable_on_death(var0, var1) {
  if(isDefined(var1)) {
    self endon("endonMsg");
  }

  self endon(var0 + "hudoutline_disable");
  scripts\engine\utility::ref_143a5("death", "entitydeleted");
  thread hudoutline_disable_internal(var0);
}

function play_animation_on_channel(var0, var1) {
  if(!isDefined(level.hudoutlinecurchannel) || level.hudoutlinecurchannel != var0) {
    return;
  }

  level notify("hudoutline_new_anim_on_channel_" + var0);
  level endon("hudoutline_new_channel_settings");
  level endon("hudoutline_new_anim_on_channel_" + var0);
  level[[var1]]();
  thread hudoutline_set_channel_settings_delayed(var0);
}

function play_animation_on_channel_loop(var0, var1) {
  level.hudoutlinechannels[var0].loopingsettingsanimationfunc = var1;

  if(!isDefined(level.hudoutlinecurchannel) || level.hudoutlinecurchannel != var0) {
    return;
  }

  play_animation_on_channel(var0, var1);
}

function hudoutline_default_settings() {
  var0 = [];

  if(isDefined(level.player.ar_callout_ent)) {
    var1 = length2d(level.player.origin - level.player.ar_callout_ent.origin);
    var2 = clamp(var1 / 1000, 1, 2);
    var0 = var2;
  } else {
    GscBinSkip0(0x2e, "MKOQSSQKLL", 1);
  }

  GscBinSkip0(0x2e, "LRMPROLMKN", "0.9 0.9 0.9 0.5");
}

function _get_sorted_list_of_channel_plus_child_channels(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  var2 = [];
  GscBinSkip0(0x2e, 0, var0);
}

function outline_array_insert(var0, var1, var2) {
  if(var2 == var0.size) {
    var3 = var0;
    GscBinSkip0(0x2e, var3.size, var1);
  }

  var3 = [];
  var4 = 0;

  for(var5 = 0; var5 < var1.size; var5++) {
    if(var5 == var3) {
      var3 = var2;
      var4 = 1;
    }

    var3 = var1[var5];
  }

  return var3;
}