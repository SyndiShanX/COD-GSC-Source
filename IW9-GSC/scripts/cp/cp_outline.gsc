/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_outline.gsc
***********************************************/

outline_monitor_think() {
  self endon("disconnect");
  level endon("game_ended");
  wait 2;

  for(;;) {
    item_outline_weapon_monitor();
    wait 0.05;
  }
}

outline_init() {
  level.outline_weapon_watch_list = [];
}

item_outline_weapon_monitor() {
  self endon("refresh_outline");

  foreach(index, item in level.outline_weapon_watch_list) {
    if(!isDefined(item)) {
      continue;
    }
    if(!isDefined(item.cost)) {
      continue;
    }
    _id_5BEC50A12CB1D7F8 = 1;
    _id_48DCE39BCA6C36F3 = distancesquared(self.origin, item.origin) < 1000000;

    if(_id_48DCE39BCA6C36F3 && !scripts\cp\utility::is_holding_deployable() && !scripts\cp\utility::has_special_weapon())
      enable_outline_for_player(item, self, get_hudoutline_item(item, _id_5BEC50A12CB1D7F8), "high");
    else if(_id_48DCE39BCA6C36F3 && (scripts\cp\utility::is_holding_deployable() || scripts\cp\utility::has_special_weapon()))
      enable_outline_for_player(item, self, "outline_depth_orange", "high");
    else
      disable_outline_for_player(item, self);

    if(index & 0)
      wait 0.05;
  }
}

get_hudoutline_item(item, _id_5BEC50A12CB1D7F8) {
  cost = item.cost;

  if(isDefined(level.has_weapon_variation)) {
    if(isDefined(item.struct.weapon) && self[[level.has_weapon_variation]](item.struct.weapon)) {
      if(isDefined(level.get_weapon_level_func)) {
        _id_CEB40E0D9504F27A = self[[level.get_weapon_level_func]](item.struct.weapon);

        if(_id_CEB40E0D9504F27A > 1)
          cost = 4500;
        else
          cost = item.cost * 0.5;
      } else
        cost = item.cost * 0.5;
    }
  }

  if(scripts\cp\cp_persistence::player_has_enough_currency(cost) || istrue(item.enabled))
    return "outline_depth_cyan";
  else
    return "outline_depth_red";
}

playeroutlinemonitor() {
  self endon("disconnect");

  for(;;) {
    foreach(player in level.players) {
      if(self == player) {
        continue;
      }
      if(should_put_player_outline_on(player)) {
        enable_outline_for_player(player, self, get_hudoutline_for_player_health(player), "high");
        continue;
      }

      disable_outline_for_player(player, self);
    }

    wait 0.2;
  }
}

should_put_player_outline_on(player) {
  if(self.no_team_outlines)
    return 0;

  if(!isalive(player) || !isDefined(player.maxhealth) || !player.maxhealth || player.no_outline)
    return 0;

  _id_A23E3656C612A7A7 = distancesquared(self.origin, player.origin) > 2250000;

  if(_id_A23E3656C612A7A7)
    return 1;

  _id_C3579BDEC26CCB2D = !scripts\engine\trace::_bullet_trace_passed(self getEye(), player getEye(), 0, self);
  return _id_C3579BDEC26CCB2D;
}

get_hudoutline_for_player_health(player) {
  _id_9E6EE1F61A6E0CBF = player.health / 100;

  if(_id_9E6EE1F61A6E0CBF <= 0.33 || _id_0AFB7E332AEE4BF2::player_in_laststand(player))
    return "outline_nodepth_red";
  else if(_id_9E6EE1F61A6E0CBF <= 0.66)
    return "outline_nodepth_orange";
  else if(_id_9E6EE1F61A6E0CBF <= 1.0)
    return "outline_nodepth_cyan";
  else
    return "outline_nodepth_white";
}

enable_outline_for_players(item, players, hudoutlineassetname, priority) {
  item hudoutlineenableforclients(players, hudoutlineassetname);
}

enable_outline_for_player(item, player, hudoutlineassetname, priority) {
  item hudoutlineenableforclient(player, hudoutlineassetname);
}

disable_outline_for_players(item, players) {
  item hudoutlinedisableforclients(players);
}

disable_outline_for_player(item, player) {
  item hudoutlinedisableforclient(player);
}

disable_outline(item) {
  item hudoutlinedisable();
}

enable_outline(item, hudoutlineassetname) {
  item hudoutlineenable(hudoutlineassetname);
}

set_outline(hudoutlineassetname) {
  level endon("game_ended");
  level endon("outline_disabled");

  if(!isDefined(hudoutlineassetname))
    hudoutlineassetname = "outline_nodepth_orange";

  for(;;) {
    ai_array = scripts\engine\utility::array_combine(level.agentarray, level.vehicle_ai_script_models);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < ai_array.size; _id_AC0E594AC96AA3A8++) {
      ai = ai_array[_id_AC0E594AC96AA3A8];

      if(!isDefined(ai)) {
        continue;
      }
      if(isagent(ai) && !isalive(ai)) {
        continue;
      }
      if(isDefined(ai.damaged_by_players)) {
        continue;
      }
      if(isDefined(ai.marked_for_challenge)) {
        continue;
      }
      if(isDefined(ai.team) && ai.team == "allies") {
        enable_outline_for_players(ai, level.players, "outline_nodepth_green", "high");
        continue;
      }

      enable_outline_for_players(ai, level.players, hudoutlineassetname, "high");
    }

    wait 0.5;
  }
}

set_outline_for_player(color, _id_F18855300B4A6330, _id_65DBFA99D91B6BCC) {
  level endon("game_ended");
  self endon("outline_disabled");

  if(!isDefined(color))
    color = 4;

  if(!isDefined(_id_F18855300B4A6330))
    _id_F18855300B4A6330 = 0;

  if(!isDefined(_id_65DBFA99D91B6BCC))
    _id_65DBFA99D91B6BCC = 0;

  for(;;) {
    foreach(enemy in scripts\cp\cp_agent_utils::get_alive_enemies()) {
      if(isDefined(enemy.damaged_by_players)) {
        continue;
      }
      if(isDefined(enemy.marked_for_challenge)) {
        continue;
      }
      if(isDefined(enemy.feral_occludes)) {
        enable_outline_for_player(enemy, self, color, 1, _id_65DBFA99D91B6BCC, "high");
        continue;
      }

      enable_outline_for_player(enemy, self, color, _id_F18855300B4A6330, _id_65DBFA99D91B6BCC, "high");
    }

    wait 0.5;
  }
}

unset_outline() {
  ai_array = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");
  ai_array = scripts\engine\utility::array_combine(ai_array, level.vehicle_ai_script_models);

  foreach(enemy in ai_array) {
    if(isDefined(enemy.damaged_by_players)) {
      continue;
    }
    if(isDefined(enemy.marked_for_challenge)) {
      continue;
    }
    disable_outline_for_players(enemy, level.players);
    level notify("outline_disabled");
  }
}

unset_outline_for_player() {
  ai_array = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");
  ai_array = scripts\engine\utility::array_combine(ai_array, level.vehicle_ai_script_models);

  foreach(enemy in ai_array) {
    if(isDefined(enemy.damaged_by_players)) {
      continue;
    }
    if(isDefined(enemy.marked_for_challenge)) {
      continue;
    }
    disable_outline_for_player(enemy, self);
    self notify("outline_disabled");
  }
}

save_outline_settings() {
  _id_90A7B8C1C3D338D2 = ["r_hudOutlineFillColor0", "r_hudOutlineFillColor1", "r_hudOutlineWidth", "r_hudOutlineOccludedOutlineColor", "r_hudOutlineOccludedInlineColor", "r_hudOutlineOccludedInteriorColor", "r_hudOutlineOccludedColorFromFill", "cg_hud_outline_colors_0", "cg_hud_outline_colors_1", "cg_hud_outline_colors_2", "cg_hud_outline_colors_3", "cg_hud_outline_colors_4", "cg_hud_outline_colors_5", "cg_hud_outline_colors_6"];

  if(!isDefined(level.hudoutlinesettings))
    level.hudoutlinesettings = [];

  foreach(_id_885448F843AA6AA3 in _id_90A7B8C1C3D338D2)
  level.hudoutlinesettings[_id_885448F843AA6AA3] = getDvar(_id_885448F843AA6AA3);
}

restore_outline_settings() {
  _id_90A7B8C1C3D338D2 = ["r_hudOutlineFillColor0", "r_hudOutlineFillColor1", "r_hudOutlineWidth", "r_hudOutlineOccludedOutlineColor", "r_hudOutlineOccludedInlineColor", "r_hudOutlineOccludedInteriorColor", "r_hudOutlineOccludedColorFromFill", "cg_hud_outline_colors_0", "cg_hud_outline_colors_1", "cg_hud_outline_colors_2", "cg_hud_outline_colors_3", "cg_hud_outline_colors_4", "cg_hud_outline_colors_5", "cg_hud_outline_colors_6"];

  if(!isDefined(level.hudoutlinesettings)) {
    return;
  }
  foreach(_id_885448F843AA6AA3 in _id_90A7B8C1C3D338D2)
  setDvar(_id_885448F843AA6AA3, level.hudoutlinesettings[_id_885448F843AA6AA3]);
}

hudoutline_enable(hudoutlineassetname, channelname) {
  hudoutline_enable_internal(channelname, hudoutlineassetname);
}

hudoutline_disable(channelname) {
  hudoutline_disable_internal(channelname);
}

hudoutline_channels_init() {
  if(!isDefined(level.fnhudoutlinedefaultsettings))
    level.fnhudoutlinedefaultsettings = ::hudoutline_default_settings;

  level.hudoutlinechannels = [];
  hudoutline_add_channel_internal("default", 0, level.fnhudoutlinedefaultsettings);
  setsaveddvar("r_hudOutlineEnable", 1);
  _id_2FBECF4CB1ADFF1A = [[level.fnhudoutlinedefaultsettings]]();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 8; _id_AC0E594AC96AA3A8++) {
    _id_B98E2BDB3119A0E3 = _func_2EF675C13CA1C4AF("dvar_1429C8E20321BBCD", _id_AC0E594AC96AA3A8);
    setsaveddvar(_id_B98E2BDB3119A0E3, _id_2FBECF4CB1ADFF1A[_id_B98E2BDB3119A0E3]);
  }
}

hudoutline_enable_internal(channelname, hudoutlineassetname) {
  if(!isDefined(channelname))
    channelname = "default";

  if(!isDefined(level.hudoutlinechannels))
    hudoutline_channels_init();

  if(hudoutline_is_ent_in_channel(channelname, self))
    hudoutline_update_entinfo(channelname, self, hudoutlineassetname);
  else {
    _id_A61C75B156FC1EE0 = level.hudoutlinechannels[channelname].entinfos.size;
    level.hudoutlinechannels[channelname].entinfos[_id_A61C75B156FC1EE0] = hudoutline_create_entinfo(self, hudoutlineassetname);
    thread hudoutline_disable_on_death(channelname);
  }

  if(!isDefined(level.hudoutlinechannels[channelname].parentchannel)) {
    if(!isDefined(level.hudoutlinecurchannel))
      hudoutline_activate_channel(channelname);

    _id_A948959983E82F10 = level.hudoutlinechannels[level.hudoutlinecurchannel].priority;
    _id_C8446D6318008D2C = level.hudoutlinechannels[channelname].priority;

    if(level.hudoutlinecurchannel != channelname && _id_A948959983E82F10 < _id_C8446D6318008D2C) {
      hudoutline_activate_channel(channelname);
      return;
    }

    if(level.hudoutlinecurchannel == channelname) {
      _enable_hudoutline_on_ent(self, hudoutlineassetname, channelname);
      return;
    }

    return;
  } else {
    _id_F264487EE10B8AFB = level.hudoutlinechannels[channelname].parentchannel;

    if(!isDefined(level.hudoutlinecurchannel))
      hudoutline_activate_channel(_id_F264487EE10B8AFB);

    _id_A948959983E82F10 = level.hudoutlinechannels[level.hudoutlinecurchannel].priority;
    _id_6E14EF69641C92F0 = level.hudoutlinechannels[_id_F264487EE10B8AFB].priority;

    if(level.hudoutlinecurchannel != _id_F264487EE10B8AFB && _id_A948959983E82F10 < _id_6E14EF69641C92F0)
      hudoutline_activate_channel(_id_F264487EE10B8AFB);
    else if(level.hudoutlinecurchannel == _id_F264487EE10B8AFB)
      _enable_hudoutline_on_ent(self, hudoutlineassetname, _id_F264487EE10B8AFB);
  }
}

hudoutline_disable_internal(channelname) {
  if(!isDefined(channelname))
    channelname = "default";

  if(!isDefined(level.hudoutlinechannels)) {
    return;
  }
  if(isDefined(self))
    self notify(channelname + "hudoutline_disable");

  index = undefined;

  foreach(_id_AC0E594AC96AA3A8, _id_BC910FD8949150F6 in level.hudoutlinechannels[channelname].entinfos) {
    if(!isDefined(_id_BC910FD8949150F6.ent)) {
      level.hudoutlinechannels[channelname].entinfos[_id_AC0E594AC96AA3A8] = undefined;
      continue;
    }

    if(_id_BC910FD8949150F6.ent == self) {
      index = _id_AC0E594AC96AA3A8;
      level.hudoutlinechannels[channelname].entinfos[index] = undefined;
      break;
    }
  }

  _id_BFC65A378A6D8EFE = [];

  foreach(_id_AC0E594AC96AA3A8, item in level.hudoutlinechannels[channelname].entinfos) {
    if(!isDefined(item)) {
      continue;
    }
    _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = item;
  }

  level.hudoutlinechannels[channelname].entinfos = _id_BFC65A378A6D8EFE;

  if(!isDefined(level.hudoutlinecurchannel)) {
    return;
  }
  if(level.hudoutlinecurchannel == channelname) {
    if(isDefined(index))
      _disable_hudoutline_on_ent(self, channelname);

    if(level.hudoutlinechannels[channelname].entinfos.size == 0) {
      _id_CC5203B08ECA3491 = 0;

      if(isDefined(level.hudoutlinechannels[channelname].childchannels) && level.hudoutlinechannels[channelname].childchannels.size > 0) {
        foreach(_id_60DF37833E14382B in level.hudoutlinechannels[channelname].childchannels) {
          if(level.hudoutlinechannels[_id_60DF37833E14382B].entinfos.size > 0) {
            _id_CC5203B08ECA3491 = 1;
            break;
          }
        }
      }

      if(!_id_CC5203B08ECA3491)
        hudoutline_activate_best_channel();
    }
  } else if(isDefined(level.hudoutlinechannels[channelname].parentchannel) && level.hudoutlinecurchannel == level.hudoutlinechannels[channelname].parentchannel) {
    _id_F264487EE10B8AFB = level.hudoutlinechannels[channelname].parentchannel;

    if(isDefined(index))
      _disable_hudoutline_on_ent(self, _id_F264487EE10B8AFB);

    if(level.hudoutlinechannels[channelname].entinfos.size == 0)
      hudoutline_activate_best_channel();
  }
}

hudoutline_activate_best_channel() {
  _id_5C49327452EF41BB = undefined;
  _id_D5B1A99D32C8445A = undefined;

  if(isDefined(level.hudoutlineforcedchannels) && level.hudoutlineforcedchannels.size > 0) {
    foreach(_id_7148C1A6F25491F8 in level.hudoutlineforcedchannels) {
      if(!isDefined(_id_5C49327452EF41BB) || level.hudoutlinechannels[_id_7148C1A6F25491F8].priority > _id_5C49327452EF41BB) {
        _id_5C49327452EF41BB = level.hudoutlinechannels[_id_7148C1A6F25491F8].priority;
        _id_D5B1A99D32C8445A = _id_7148C1A6F25491F8;
      }
    }
  } else {
    foreach(_id_7148C1A6F25491F8 in level.hudoutlinechannels) {
      if(isDefined(_id_7148C1A6F25491F8.parentchannel)) {
        continue;
      }
      if(!isDefined(_id_7148C1A6F25491F8.childchannels) || _id_7148C1A6F25491F8.childchannels.size == 0) {
        if(_id_7148C1A6F25491F8.entinfos.size == 0)
          continue;
      } else {
        _id_CC5203B08ECA3491 = 0;

        if(_id_7148C1A6F25491F8.entinfos.size > 0)
          _id_CC5203B08ECA3491 = 1;

        foreach(_id_60DF37833E14382B in _id_7148C1A6F25491F8.childchannels) {
          if(level.hudoutlinechannels[_id_60DF37833E14382B].entinfos.size > 0)
            _id_CC5203B08ECA3491 = 1;
        }

        if(!_id_CC5203B08ECA3491)
          continue;
      }

      if(!isDefined(_id_5C49327452EF41BB) || _id_7148C1A6F25491F8.priority > _id_5C49327452EF41BB) {
        _id_5C49327452EF41BB = _id_7148C1A6F25491F8.priority;
        _id_D5B1A99D32C8445A = _id_7148C1A6F25491F8.channelname;
      }
    }
  }

  if(isDefined(_id_D5B1A99D32C8445A))
    hudoutline_activate_channel(_id_D5B1A99D32C8445A);
  else
    level.hudoutlinecurchannel = undefined;
}

hudoutline_create_entinfo(ent, hudoutlineassetname) {
  _id_BC910FD8949150F6 = spawnStruct();
  _id_BC910FD8949150F6.ent = ent;
  _id_BC910FD8949150F6.hudoutlineassetname = hudoutlineassetname;
  return _id_BC910FD8949150F6;
}

hudoutline_update_entinfo(channelname, ent, hudoutlineassetname) {
  foreach(_id_BC910FD8949150F6 in level.hudoutlinechannels[channelname].entinfos) {
    if(_id_BC910FD8949150F6.ent == ent)
      _id_BC910FD8949150F6.hudoutlineassetname = hudoutlineassetname;
  }
}

hudoutline_activate_channel(channelname) {
  if(isDefined(level.hudoutlinecurchannel) && level.hudoutlinecurchannel != channelname) {
    hudoutline_deactivate_channel(level.hudoutlinecurchannel);

    if(isDefined(level.hudoutlinechannels[level.hudoutlinecurchannel].childchannels) && level.hudoutlinechannels[level.hudoutlinecurchannel].childchannels.size > 0) {
      foreach(_id_7A7097CCD9821DC8 in level.hudoutlinechannels[level.hudoutlinecurchannel].childchannels)
      hudoutline_deactivate_channel(_id_7A7097CCD9821DC8);
    }
  }

  level.hudoutlinecurchannel = channelname;
  thread hudoutline_set_channel_settings_delayed(channelname);
  _enable_hudoutline_on_channel_ents(channelname);
}

_enable_hudoutline_on_channel_ents(channelname) {
  _id_BF39CE08D38CF891 = _get_sorted_list_of_channel_plus_child_channels(channelname);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_BF39CE08D38CF891.size; _id_AC0E594AC96AA3A8++) {
    foreach(_id_BC910FD8949150F6 in level.hudoutlinechannels[_id_BF39CE08D38CF891[_id_AC0E594AC96AA3A8]].entinfos) {
      ent = _id_BC910FD8949150F6.ent;
      ent hudoutlineenable(_id_BC910FD8949150F6.hudoutlineassetname);
    }
  }
}

_enable_hudoutline_on_ent(ent, hudoutlineassetname, _id_F264487EE10B8AFB) {
  if(!isDefined(level.hudoutlinechannels[_id_F264487EE10B8AFB].childchannels) || level.hudoutlinechannels[_id_F264487EE10B8AFB].childchannels.size == 0)
    ent hudoutlineenable(hudoutlineassetname);
  else {
    _id_85DB4751771ACFDF = _get_sorted_list_of_channel_plus_child_channels(_id_F264487EE10B8AFB, 1);
    outlinedent = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_85DB4751771ACFDF.size; _id_AC0E594AC96AA3A8++) {
      foreach(_id_BC910FD8949150F6 in level.hudoutlinechannels[_id_85DB4751771ACFDF[_id_AC0E594AC96AA3A8]].entinfos) {
        if(_id_BC910FD8949150F6.ent == ent) {
          ent hudoutlineenable(_id_BC910FD8949150F6.hudoutlineassetname);
          outlinedent = 1;
          break;
        }
      }

      if(outlinedent) {
        break;
      }
    }
  }
}

_disable_hudoutline_on_ent(ent, _id_F264487EE10B8AFB) {
  if(!isDefined(level.hudoutlinechannels[_id_F264487EE10B8AFB].childchannels) || level.hudoutlinechannels[_id_F264487EE10B8AFB].childchannels.size == 0)
    self hudoutlinedisable();
  else {
    _id_85DB4751771ACFDF = _get_sorted_list_of_channel_plus_child_channels(_id_F264487EE10B8AFB, 1);
    outlinedent = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_85DB4751771ACFDF.size; _id_AC0E594AC96AA3A8++) {
      foreach(_id_BC910FD8949150F6 in level.hudoutlinechannels[_id_85DB4751771ACFDF[_id_AC0E594AC96AA3A8]].entinfos) {
        if(_id_BC910FD8949150F6.ent == ent) {
          ent hudoutlineenable(_id_BC910FD8949150F6.hudoutlineassetname);
          outlinedent = 1;
          break;
        }
      }

      if(outlinedent) {
        break;
      }
    }

    if(!outlinedent)
      self hudoutlinedisable();
  }
}

hudoutline_set_channel_settings_delayed(channelname) {
  level notify("hudoutline_new_channel_settings");
  level endon("hudoutline_new_channel_settings");
  wait 0.05;
  _id_07D9521DCC3A9727 = [[level.fnhudoutlinedefaultsettings]]();
  _id_790824F4CF462560 = [[level.hudoutlinechannels[channelname].settingsfunc]]();

  foreach(key, value in _id_07D9521DCC3A9727) {
    if(isDefined(_id_790824F4CF462560[key])) {
      setsaveddvar(key, _id_790824F4CF462560[key]);
      continue;
    }

    setsaveddvar(key, value);
  }

  if(isDefined(level.hudoutlinechannels[channelname].loopingsettingsanimationfunc))
    play_animation_on_channel(channelname, level.hudoutlinechannels[channelname].loopingsettingsanimationfunc);
}

hudoutline_deactivate_channel(channelname) {
  foreach(_id_BC910FD8949150F6 in level.hudoutlinechannels[channelname].entinfos) {
    ent = _id_BC910FD8949150F6.ent;
    ent hudoutlinedisable();
  }
}

hudoutline_add_channel_internal(channelname, priority, settingsfunc) {
  if(!isDefined(settingsfunc))
    settingsfunc = level.fnhudoutlinedefaultsettings;

  if(!isDefined(level.hudoutlinechannels))
    hudoutline_channels_init();

  if(!isDefined(level.hudoutlinechannels[channelname])) {
    level.hudoutlinechannels[channelname] = spawnStruct();
    level.hudoutlinechannels[channelname].channelname = channelname;
    level.hudoutlinechannels[channelname].priority = priority;
    level.hudoutlinechannels[channelname].settingsfunc = settingsfunc;
    level.hudoutlinechannels[channelname].entinfos = [];
  }
}

hudoutline_add_child_channel_internal(channelname, priority, _id_F264487EE10B8AFB) {
  if(!isDefined(level.hudoutlinechannels[channelname])) {
    level.hudoutlinechannels[channelname] = spawnStruct();
    level.hudoutlinechannels[channelname].channelname = channelname;
    level.hudoutlinechannels[channelname].priority = priority;
    level.hudoutlinechannels[channelname].entinfos = [];
    level.hudoutlinechannels[channelname].parentchannel = _id_F264487EE10B8AFB;
  }

  if(!isDefined(level.hudoutlinechannels[_id_F264487EE10B8AFB].childchannels))
    level.hudoutlinechannels[_id_F264487EE10B8AFB].childchannels = [];

  level.hudoutlinechannels[_id_F264487EE10B8AFB].childchannels[level.hudoutlinechannels[_id_F264487EE10B8AFB].childchannels.size] = channelname;
}

hudoutline_override_channel_settingsfunc(channelname, settingsfunc) {
  level.hudoutlinechannels[channelname].settingsfunc = settingsfunc;

  if(isDefined(level.hudoutlinecurchannel) && level.hudoutlinecurchannel == channelname)
    thread hudoutline_set_channel_settings_delayed(channelname);
}

hudoutline_is_ent_in_channel(channelname, ent) {
  foreach(_id_BC910FD8949150F6 in level.hudoutlinechannels[channelname].entinfos) {
    if(_id_BC910FD8949150F6.ent == ent)
      return 1;
  }

  return 0;
}

hudoutline_force_channel_internal(channelname, _id_C3F2838383281C9D) {
  if(!isDefined(level.hudoutlineforcedchannels))
    level.hudoutlineforcedchannels = [];

  if(_id_C3F2838383281C9D) {
    foreach(_id_7148C1A6F25491F8 in level.hudoutlineforcedchannels) {
      if(_id_7148C1A6F25491F8 == channelname)
        return;
    }

    level.hudoutlineforcedchannels[level.hudoutlineforcedchannels.size] = channelname;
    hudoutline_activate_best_channel();
  } else {
    _id_371D23793A6FC9ED = [];

    foreach(_id_7148C1A6F25491F8 in level.hudoutlineforcedchannels) {
      if(_id_7148C1A6F25491F8 != channelname)
        _id_371D23793A6FC9ED[_id_371D23793A6FC9ED.size] = _id_7148C1A6F25491F8;
    }

    level.hudoutlineforcedchannels = _id_371D23793A6FC9ED;
    hudoutline_activate_best_channel();
  }
}

hudoutline_disable_on_death(channelname, _id_30DD9F6DDD87B138) {
  if(isDefined(_id_30DD9F6DDD87B138))
    self endon("endonMsg");

  self endon(channelname + "hudoutline_disable");
  scripts\engine\utility::waittill_any_2("death", "entitydeleted");
  thread hudoutline_disable_internal(channelname);
}

play_animation_on_channel(channelname, _id_4706652761DE8D03) {
  if(!isDefined(level.hudoutlinecurchannel) || level.hudoutlinecurchannel != channelname) {
    return;
  }
  level notify("hudoutline_new_anim_on_channel_" + channelname);
  level endon("hudoutline_new_channel_settings");
  level endon("hudoutline_new_anim_on_channel_" + channelname);
  level[[_id_4706652761DE8D03]]();
  thread hudoutline_set_channel_settings_delayed(channelname);
}

play_animation_on_channel_loop(channelname, _id_4706652761DE8D03) {
  level.hudoutlinechannels[channelname].loopingsettingsanimationfunc = _id_4706652761DE8D03;

  if(!isDefined(level.hudoutlinecurchannel) || level.hudoutlinecurchannel != channelname) {
    return;
  }
  play_animation_on_channel(channelname, _id_4706652761DE8D03);
}

hudoutline_default_settings() {
  hudoutlinesettings = [];

  if(isDefined(level.player.ar_callout_ent)) {
    _id_5B660A4C678BD6AF = length2d(level.player.origin - level.player.ar_callout_ent.origin);
    _id_7803CCE2B397156D = clamp(_id_5B660A4C678BD6AF / 1000, 1, 2);
    hudoutlinesettings["r_hudOutlineWidth"] = _id_7803CCE2B397156D;
  } else
    hudoutlinesettings["r_hudOutlineWidth"] = 1;

  hudoutlinesettings["r_hudOutlineFillColor0"] = "0.9 0.9 0.9 0.5";
  hudoutlinesettings["r_hudOutlineFillColor1"] = "0.3 0.3 0.3 0.5";
  hudoutlinesettings["r_hudOutlineOccludedOutlineColor"] = "1 1 1 1";
  hudoutlinesettings["r_hudOutlineOccludedInlineColor"] = "1 1 1 0.45";
  hudoutlinesettings["r_hudOutlineOccludedInteriorColor"] = ".7 .7 .7 0.25";
  hudoutlinesettings["r_hudOutlineOccludedColorFromFill"] = 1;
  hudoutlinesettings["cg_hud_outline_colors_0"] = "0.000 0.000 0.000 0.000";
  hudoutlinesettings["cg_hud_outline_colors_1"] = "0.882 0.882 0.882 1.000";
  hudoutlinesettings["cg_hud_outline_colors_2"] = "0.945 0.384 0.247 1.000";
  hudoutlinesettings["cg_hud_outline_colors_3"] = "0.431 0.745 0.235 1.000";
  hudoutlinesettings["cg_hud_outline_colors_4"] = "0.157 0.784 0.784 1.000";
  hudoutlinesettings["cg_hud_outline_colors_5"] = "0.886 0.600 0.000 1.000";
  hudoutlinesettings["cg_hud_outline_colors_6"] = "0.000 0.000 0.000 1.000";
  hudoutlinesettings["cg_hud_outline_colors_7"] = "1.000 0.300 0.300 1.000";
  return hudoutlinesettings;
}

_get_sorted_list_of_channel_plus_child_channels(channelname, _id_3193FE90FA9F2E6F) {
  if(!isDefined(_id_3193FE90FA9F2E6F))
    _id_3193FE90FA9F2E6F = 0;

  _id_778D8E547335493F = [];
  _id_778D8E547335493F[0] = channelname;

  if(isDefined(level.hudoutlinechannels[channelname].childchannels) && level.hudoutlinechannels[channelname].childchannels.size > 0) {
    foreach(_id_7A7097CCD9821DC8 in level.hudoutlinechannels[channelname].childchannels) {
      if(level.hudoutlinechannels[_id_7A7097CCD9821DC8].entinfos.size > 0) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_778D8E547335493F.size; _id_AC0E594AC96AA3A8++) {
          if(!_id_3193FE90FA9F2E6F) {
            if(level.hudoutlinechannels[_id_778D8E547335493F[_id_AC0E594AC96AA3A8]].priority >= level.hudoutlinechannels[_id_7A7097CCD9821DC8].priority) {
              _id_778D8E547335493F = outline_array_insert(_id_778D8E547335493F, _id_7A7097CCD9821DC8, _id_AC0E594AC96AA3A8);
              break;
            } else if(_id_AC0E594AC96AA3A8 + 1 == _id_778D8E547335493F.size) {
              _id_778D8E547335493F[_id_AC0E594AC96AA3A8 + 1] = _id_7A7097CCD9821DC8;
              break;
            }
          } else if(level.hudoutlinechannels[_id_778D8E547335493F[_id_AC0E594AC96AA3A8]].priority < level.hudoutlinechannels[_id_7A7097CCD9821DC8].priority) {
            _id_778D8E547335493F = outline_array_insert(_id_778D8E547335493F, _id_7A7097CCD9821DC8, _id_AC0E594AC96AA3A8);
            break;
          } else if(_id_AC0E594AC96AA3A8 + 1 == _id_778D8E547335493F.size) {
            _id_778D8E547335493F[_id_AC0E594AC96AA3A8 + 1] = _id_7A7097CCD9821DC8;
            break;
          }
        }
      }
    }
  }

  return _id_778D8E547335493F;
}

outline_array_insert(array, object, index) {
  if(index == array.size) {
    temp = array;
    temp[temp.size] = object;
    return temp;
  }

  temp = [];
  offset = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    if(_id_AC0E594AC96AA3A8 == index) {
      temp[_id_AC0E594AC96AA3A8] = object;
      offset = 1;
    }

    temp[_id_AC0E594AC96AA3A8 + offset] = array[_id_AC0E594AC96AA3A8];
  }

  return temp;
}