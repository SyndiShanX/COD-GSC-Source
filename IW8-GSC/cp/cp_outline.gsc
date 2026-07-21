/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_outline.gsc
***********************************************/

outline_monitor_think() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
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
  self endon("_encstr_972A10395633C92BE6D0FAB75D8E632DB9B2");

  foreach(var_4, var_1 in level.outline_weapon_watch_list) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(!isDefined(var_1.cost)) {
      continue;
    }
    var_2 = 1;
    var_3 = distancesquared(self.origin, var_1.origin) < 1000000;

    if(var_3 && !scripts\cp\utility::is_holding_deployable() && !scripts\cp\utility::has_special_weapon())
      enable_outline_for_player(var_1, self, get_hudoutline_item(var_1, var_2), "_encstr_9ACC05B41B7F32");
    else if(var_3 && (scripts\cp\utility::is_holding_deployable() || scripts\cp\utility::has_special_weapon()))
      enable_outline_for_player(var_1, self, "_encstr_96AE15674513800375C947242F6863285787EB2916E22F", "_encstr_9ACC05B41B7F32");
    else
      disable_outline_for_player(var_1, self);

    if(var_4 & 0)
      wait 0.05;
  }
}

get_hudoutline_item(var_0, var_1) {
  var_2 = var_0.cost;

  if(isDefined(level.has_weapon_variation)) {
    if(isDefined(var_0.struct.weapon) && self[[level.has_weapon_variation]](var_0.struct.weapon)) {
      if(isDefined(level.get_weapon_level_func)) {
        var_3 = self[[level.get_weapon_level_func]](var_0.struct.weapon);

        if(var_3 > 1)
          var_2 = 4500;
        else
          var_2 = var_0.cost * 0.5;
      } else
        var_2 = var_0.cost * 0.5;
    }
  }

  if(scripts\cp\cp_persistence::player_has_enough_currency(var_2) || istrue(var_0.enabled))
    return "_encstr_9B9D132773AD52F9F829A96FC1E02CCA90F7C797DD";
  else
    return "_encstr_9B0F12DE5DE8B15AB9B2F53295834734F54E59C8";
}

playeroutlinemonitor() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    foreach(var_1 in level.players) {
      if(self == var_1) {
        continue;
      }
      if(should_put_player_outline_on(var_1)) {
        enable_outline_for_player(var_1, self, get_hudoutline_for_player_health(var_1), "_encstr_9ACC05B41B7F32");
        continue;
      }

      disable_outline_for_player(var_1, self);
    }

    wait 0.2;
  }
}

should_put_player_outline_on(var_0) {
  if(self.no_team_outlines)
    return 0;

  if(!isalive(var_0) || !isDefined(var_0.maxhealth) || !var_0.maxhealth || var_0.no_outline)
    return 0;

  var_1 = distancesquared(self.origin, var_0.origin) > 2250000;

  if(var_1)
    return 1;

  var_2 = !scripts\engine\trace::_bullet_trace_passed(self getEye(), var_0 getEye(), 0, self);
  return var_2;
}

get_hudoutline_for_player_health(var_0) {
  var_1 = var_0.health / 100;

  if(var_1 <= 0.33 || scripts\cp\cp_laststand::player_in_laststand(var_0))
    return "_encstr_B89614B7ABE88DD2DC59AF73F623AC833AA1BE27B246";
  else if(var_1 <= 0.66)
    return "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA";
  else if(var_1 <= 1.0)
    return "_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190";
  else
    return "_encstr_AF5716DF75E398434BBA0E10225B0D30BBF03797680CE09D";
}

enable_outline_for_players(var_0, var_1, var_2, var_3) {
  var_0 hudoutlineenableforclients(var_1, var_2);
}

enable_outline_for_player(var_0, var_1, var_2, var_3) {
  var_0 hudoutlineenableforclient(var_1, var_2);
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

enable_outline(var_0, var_1) {
  var_0 hudoutlineenable(var_1);
}

set_outline(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_BD4611B7578EB12DDC56BE23A5DC8531C65932");

  if(!isDefined(var_0))
    var_0 = "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA";

  for(;;) {
    var_1 = scripts\engine\utility::array_combine(level.agentarray, level._id_14102);

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
      if(isDefined(var_3.team) && var_3.team == "_encstr_9A8507BA4040188D08") {
        enable_outline_for_players(var_3, level.players, "_encstr_A90116BFB72351201E2F964855FC8897FB6B6727335AAD40", "_encstr_9ACC05B41B7F32");
        continue;
      }

      enable_outline_for_players(var_3, level.players, var_0, "_encstr_9ACC05B41B7F32");
    }

    wait 0.5;
  }
}

set_outline_for_player(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_BD4611B7578EB12DDC56BE23A5DC8531C65932");

  if(!isDefined(var_0))
    var_0 = 4;

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
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
        enable_outline_for_player(var_4, self, var_0, 1, var_2, "_encstr_9ACC05B41B7F32");
        continue;
      }

      enable_outline_for_player(var_4, self, var_0, var_1, var_2, "_encstr_9ACC05B41B7F32");
    }

    wait 0.5;
  }
}

unset_outline() {
  foreach(var_1 in scripts\cp\cp_agent_utils::getactiveenemyagents("_encstr_9A8507BA4040188D08")) {
    if(isDefined(var_1.damaged_by_players)) {
      continue;
    }
    if(isDefined(var_1.marked_for_challenge)) {
      continue;
    }
    disable_outline_for_players(var_1, level.players);
    level notify("_encstr_BD4611B7578EB12DDC56BE23A5DC8531C65932");
  }
}

unset_outline_for_player() {
  foreach(var_1 in scripts\cp\cp_agent_utils::getactiveenemyagents("_encstr_9A8507BA4040188D08")) {
    if(isDefined(var_1.damaged_by_players)) {
      continue;
    }
    if(isDefined(var_1.marked_for_challenge)) {
      continue;
    }
    disable_outline_for_player(var_1, self);
    self notify("_encstr_BD4611B7578EB12DDC56BE23A5DC8531C65932");
  }
}

save_outline_settings() {
  var_0 = ["_encstr_845C0BA4BA7DB11EC873D3C763", "_encstr_8CE50B39519E6AD29A45A5A8A8", "_encstr_8A820BA9D1D8EB5F6307818131", "_encstr_A7170B6BC99C1798FB4D7D6559", "_encstr_85630B8D92BA65507A8DEF74F7", "_encstr_9A280B9872E4F46A5469251528", "_encstr_BDB00A2596358A7A2D54C95A", "_encstr_96E71896FFD1F1B37C6F70A82B9CC8059A691E28958A8D3B1FEA", "_encstr_87E71836CEFAA15D32BEDEEAE8C65A7395BE1BBDD8BD39DCEB62", "_encstr_81E7182352E7A947F8AF2F93609BFBA54D97C74F504A42AE97C5", "_encstr_88E71881B20E60FF33B06528A36A02439B1158E080C85BF3914F", "_encstr_97E71847F026B88311703DB3CDD99A7689C9CFEF6398FAAB0FDD", "_encstr_AAE718B8D271790323E7087DA46BC82DA7F91B50FA95851BF795", "_encstr_85E718011A1753C847078FA3342D602887F19908127F969B5146"];

  if(!isDefined(level.hudoutlinesettings))
    level.hudoutlinesettings = [];

  foreach(var_2 in var_0)
  level.hudoutlinesettings[var_2] = getDvar(var_2);
}

restore_outline_settings() {
  var_0 = ["_encstr_845C0BA4BA7DB11EC873D3C763", "_encstr_8CE50B39519E6AD29A45A5A8A8", "_encstr_8A820BA9D1D8EB5F6307818131", "_encstr_A7170B6BC99C1798FB4D7D6559", "_encstr_85630B8D92BA65507A8DEF74F7", "_encstr_9A280B9872E4F46A5469251528", "_encstr_BDB00A2596358A7A2D54C95A", "_encstr_96E71896FFD1F1B37C6F70A82B9CC8059A691E28958A8D3B1FEA", "_encstr_87E71836CEFAA15D32BEDEEAE8C65A7395BE1BBDD8BD39DCEB62", "_encstr_81E7182352E7A947F8AF2F93609BFBA54D97C74F504A42AE97C5", "_encstr_88E71881B20E60FF33B06528A36A02439B1158E080C85BF3914F", "_encstr_97E71847F026B88311703DB3CDD99A7689C9CFEF6398FAAB0FDD", "_encstr_AAE718B8D271790323E7087DA46BC82DA7F91B50FA95851BF795", "_encstr_85E718011A1753C847078FA3342D602887F19908127F969B5146"];

  if(!isDefined(level.hudoutlinesettings)) {
    return;
  }
  foreach(var_2 in var_0)
  setDvar(var_2, level.hudoutlinesettings[var_2]);
}

hudoutline_enable(var_0, var_1) {
  hudoutline_enable_internal(var_1, var_0);
}

hudoutline_disable(var_0) {
  hudoutline_disable_internal(var_0);
}

hudoutline_channels_init() {
  if(!isDefined(level.fnhudoutlinedefaultsettings))
    level.fnhudoutlinedefaultsettings = ::hudoutline_default_settings;

  level.hudoutlinechannels = [];
  hudoutline_add_channel_internal("_encstr_8B1608EC43B8D647A113", 0, level.fnhudoutlinedefaultsettings);
  setsaveddvar("_encstr_84310B988D8B2C6B5AF1A191F9", 1);
  var_0 = [[level.fnhudoutlinedefaultsettings]]();

  for(var_1 = 0; var_1 < 8; var_1++) {
    var_2 = "_encstr_AC0B17772F418310A411207BC384B8C85A67EFE7FBAA5618C7" + var_1;
    setsaveddvar(var_2, var_0[var_2]);
  }
}

hudoutline_enable_internal(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = "_encstr_8B1608EC43B8D647A113";

  if(!isDefined(level.hudoutlinechannels))
    hudoutline_channels_init();

  if(hudoutline_is_ent_in_channel(var_0, self))
    hudoutline_update_entinfo(var_0, self, var_1);
  else {
    var_2 = level.hudoutlinechannels[var_0].entinfos.size;
    level.hudoutlinechannels[var_0].entinfos[var_2] = hudoutline_create_entinfo(self, var_1);
    thread hudoutline_disable_on_death(var_0);
  }

  if(!isDefined(level.hudoutlinechannels[var_0].parentchannel)) {
    if(!isDefined(level.hudoutlinecurchannel))
      hudoutline_activate_channel(var_0);

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
  } else {
    var_5 = level.hudoutlinechannels[var_0].parentchannel;

    if(!isDefined(level.hudoutlinecurchannel))
      hudoutline_activate_channel(var_5);

    var_3 = level.hudoutlinechannels[level.hudoutlinecurchannel].priority;
    var_6 = level.hudoutlinechannels[var_5].priority;

    if(level.hudoutlinecurchannel != var_5 && var_3 < var_6)
      hudoutline_activate_channel(var_5);
    else if(level.hudoutlinecurchannel == var_5)
      _enable_hudoutline_on_ent(self, var_1, var_5);
  }
}

hudoutline_disable_internal(var_0) {
  if(!isDefined(var_0))
    var_0 = "_encstr_8B1608EC43B8D647A113";

  if(!isDefined(level.hudoutlinechannels)) {
    return;
  }
  if(isDefined(self))
    self notify(var_0 + "_encstr_85C5135803C3F8E05B2CEBED4DC930B337FA9140EA");

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

  foreach(var_4, var_7 in level.hudoutlinechannels[var_0].entinfos) {
    if(!isDefined(var_7)) {
      continue;
    }
    var_5[var_5.size] = var_7;
  }

  level.hudoutlinechannels[var_0].entinfos = var_5;

  if(!isDefined(level.hudoutlinecurchannel)) {
    return;
  }
  if(level.hudoutlinecurchannel == var_0) {
    if(isDefined(var_1))
      _disable_hudoutline_on_ent(self, var_0);

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

      if(!var_8)
        hudoutline_activate_best_channel();
    }
  } else if(isDefined(level.hudoutlinechannels[var_0].parentchannel) && level.hudoutlinecurchannel == level.hudoutlinechannels[var_0].parentchannel) {
    var_12 = level.hudoutlinechannels[var_0].parentchannel;

    if(isDefined(var_1))
      _disable_hudoutline_on_ent(self, var_12);

    if(level.hudoutlinechannels[var_0].entinfos.size == 0)
      hudoutline_activate_best_channel();
  }
}

hudoutline_activate_best_channel() {
  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(level.hudoutlineforcedchannels) && level.hudoutlineforcedchannels.size > 0) {
    foreach(var_3 in level.hudoutlineforcedchannels) {
      if(!isDefined(var_0) || level.hudoutlinechannels[var_3].priority > var_0) {
        var_0 = level.hudoutlinechannels[var_3].priority;
        var_1 = var_3;
      }
    }
  } else {
    foreach(var_3 in level.hudoutlinechannels) {
      if(isDefined(var_3.parentchannel)) {
        continue;
      }
      if(!isDefined(var_3.childchannels) || var_3.childchannels.size == 0) {
        if(var_3.entinfos.size == 0)
          continue;
      } else {
        var_6 = 0;

        if(var_3.entinfos.size > 0)
          var_6 = 1;

        foreach(var_8 in var_3.childchannels) {
          if(level.hudoutlinechannels[var_8].entinfos.size > 0)
            var_6 = 1;
        }

        if(!var_6)
          continue;
      }

      if(!isDefined(var_0) || var_3.priority > var_0) {
        var_0 = var_3.priority;
        var_1 = var_3.channelname;
      }
    }
  }

  if(isDefined(var_1))
    hudoutline_activate_channel(var_1);
  else
    level.hudoutlinecurchannel = undefined;
}

hudoutline_create_entinfo(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.ent = var_0;
  var_2.hudoutlineassetname = var_1;
  return var_2;
}

hudoutline_update_entinfo(var_0, var_1, var_2) {
  foreach(var_4 in level.hudoutlinechannels[var_0].entinfos) {
    if(var_4.ent == var_1)
      var_4.hudoutlineassetname = var_2;
  }
}

hudoutline_activate_channel(var_0) {
  if(isDefined(level.hudoutlinecurchannel) && level.hudoutlinecurchannel != var_0) {
    hudoutline_deactivate_channel(level.hudoutlinecurchannel);

    if(isDefined(level.hudoutlinechannels[level.hudoutlinecurchannel].childchannels) && level.hudoutlinechannels[level.hudoutlinecurchannel].childchannels.size > 0) {
      foreach(var_2 in level.hudoutlinechannels[level.hudoutlinecurchannel].childchannels)
      hudoutline_deactivate_channel(var_2);
    }
  }

  level.hudoutlinecurchannel = var_0;
  thread hudoutline_set_channel_settings_delayed(var_0);
  _enable_hudoutline_on_channel_ents(var_0);
}

_enable_hudoutline_on_channel_ents(var_0) {
  var_1 = _get_sorted_list_of_channel_plus_child_channels(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    foreach(var_4 in level.hudoutlinechannels[var_1[var_2]].entinfos) {
      var_5 = var_4.ent;
      var_5 hudoutlineenable(var_4.hudoutlineassetname);
    }
  }
}

_enable_hudoutline_on_ent(var_0, var_1, var_2) {
  if(!isDefined(level.hudoutlinechannels[var_2].childchannels) || level.hudoutlinechannels[var_2].childchannels.size == 0)
    var_0 hudoutlineenable(var_1);
  else {
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
}

_disable_hudoutline_on_ent(var_0, var_1) {
  if(!isDefined(level.hudoutlinechannels[var_1].childchannels) || level.hudoutlinechannels[var_1].childchannels.size == 0)
    self hudoutlinedisable();
  else {
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

    if(!var_3)
      self hudoutlinedisable();
  }
}

hudoutline_set_channel_settings_delayed(var_0) {
  level notify("_encstr_A72C2034D546EDBA478DB473597D9BACEE7DD84358CD7356B1F5375647A34B73B3E6");
  level endon("_encstr_A72C2034D546EDBA478DB473597D9BACEE7DD84358CD7356B1F5375647A34B73B3E6");
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

  if(isDefined(level.hudoutlinechannels[var_0].loopingsettingsanimationfunc))
    play_animation_on_channel(var_0, level.hudoutlinechannels[var_0].loopingsettingsanimationfunc);
}

hudoutline_deactivate_channel(var_0) {
  foreach(var_2 in level.hudoutlinechannels[var_0].entinfos) {
    var_3 = var_2.ent;
    var_3 hudoutlinedisable();
  }
}

hudoutline_add_channel_internal(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = level.fnhudoutlinedefaultsettings;

  if(!isDefined(level.hudoutlinechannels))
    hudoutline_channels_init();

  if(!isDefined(level.hudoutlinechannels[var_0])) {
    level.hudoutlinechannels[var_0] = spawnStruct();
    level.hudoutlinechannels[var_0].channelname = var_0;
    level.hudoutlinechannels[var_0].priority = var_1;
    level.hudoutlinechannels[var_0].settingsfunc = var_2;
    level.hudoutlinechannels[var_0].entinfos = [];
  }
}

hudoutline_add_child_channel_internal(var_0, var_1, var_2) {
  if(!isDefined(level.hudoutlinechannels[var_0])) {
    level.hudoutlinechannels[var_0] = spawnStruct();
    level.hudoutlinechannels[var_0].channelname = var_0;
    level.hudoutlinechannels[var_0].priority = var_1;
    level.hudoutlinechannels[var_0].entinfos = [];
    level.hudoutlinechannels[var_0].parentchannel = var_2;
  }

  if(!isDefined(level.hudoutlinechannels[var_2].childchannels))
    level.hudoutlinechannels[var_2].childchannels = [];

  level.hudoutlinechannels[var_2].childchannels[level.hudoutlinechannels[var_2].childchannels.size] = var_0;
}

hudoutline_override_channel_settingsfunc(var_0, var_1) {
  level.hudoutlinechannels[var_0].settingsfunc = var_1;

  if(isDefined(level.hudoutlinecurchannel) && level.hudoutlinecurchannel == var_0)
    thread hudoutline_set_channel_settings_delayed(var_0);
}

hudoutline_is_ent_in_channel(var_0, var_1) {
  foreach(var_3 in level.hudoutlinechannels[var_0].entinfos) {
    if(var_3.ent == var_1)
      return 1;
  }

  return 0;
}

hudoutline_force_channel_internal(var_0, var_1) {
  if(!isDefined(level.hudoutlineforcedchannels))
    level.hudoutlineforcedchannels = [];

  if(var_1) {
    foreach(var_3 in level.hudoutlineforcedchannels) {
      if(var_3 == var_0)
        return;
    }

    level.hudoutlineforcedchannels[level.hudoutlineforcedchannels.size] = var_0;
    hudoutline_activate_best_channel();
  } else {
    var_5 = [];

    foreach(var_3 in level.hudoutlineforcedchannels) {
      if(var_3 != var_0)
        var_5[var_5.size] = var_3;
    }

    level.hudoutlineforcedchannels = var_5;
    hudoutline_activate_best_channel();
  }
}

hudoutline_disable_on_death(var_0, var_1) {
  if(isDefined(var_1))
    self endon("_encstr_A95E0959378CEDDCD49BD9");

  self endon(var_0 + "_encstr_85C5135803C3F8E05B2CEBED4DC930B337FA9140EA");
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8A490E5973475A8EE546CA63B23ACA46");
  thread hudoutline_disable_internal(var_0);
}

play_animation_on_channel(var_0, var_1) {
  if(!isDefined(level.hudoutlinecurchannel) || level.hudoutlinecurchannel != var_0) {
    return;
  }
  level notify("_encstr_917B2043BAC8B7ABE8B1D29B59F5B9B2DDAF0BDCB4ADD7DB37EB6C4316B9DC95D8D7" + var_0);
  level endon("_encstr_A72C2034D546EDBA478DB473597D9BACEE7DD84358CD7356B1F5375647A34B73B3E6");
  level endon("_encstr_917B2043BAC8B7ABE8B1D29B59F5B9B2DDAF0BDCB4ADD7DB37EB6C4316B9DC95D8D7" + var_0);
  level[[var_1]]();
  thread hudoutline_set_channel_settings_delayed(var_0);
}

play_animation_on_channel_loop(var_0, var_1) {
  level.hudoutlinechannels[var_0].loopingsettingsanimationfunc = var_1;

  if(!isDefined(level.hudoutlinecurchannel) || level.hudoutlinecurchannel != var_0) {
    return;
  }
  play_animation_on_channel(var_0, var_1);
}

hudoutline_default_settings() {
  var_0 = [];

  if(isDefined(level.player.ar_callout_ent)) {
    var_1 = length2d(level.player.origin - level.player.ar_callout_ent.origin);
    var_2 = clamp(var_1 / 1000, 1, 2);
    var_0["_encstr_8A820BA9D1D8EB5F6307818131"] = var_2;
  } else
    var_0["_encstr_8A820BA9D1D8EB5F6307818131"] = 1;

  var_0["_encstr_845C0BA4BA7DB11EC873D3C763"] = "_encstr_BE451060586ACA4A1DF2362F526B06C2307D";
  var_0["_encstr_8CE50B39519E6AD29A45A5A8A8"] = "_encstr_9AAB1060C53302C07133400C1766048117A9";
  var_0["_encstr_A7170B6BC99C1798FB4D7D6559"] = "_encstr_B865089AD15AF0DFD7A3";
  var_0["_encstr_85630B8D92BA65507A8DEF74F7"] = "_encstr_BE3B0B2601131089040C1743A9";
  var_0["_encstr_9A280B9872E4F46A5469251528"] = "_encstr_96D70EA5FAF7722BE74627B2F1F50A8E";
  var_0["_encstr_BDB00A2596358A7A2D54C95A"] = 1;
  var_0["_encstr_96E71896FFD1F1B37C6F70A82B9CC8059A691E28958A8D3B1FEA"] = "_encstr_A52318C2F86BE79FCAABF5A2026FB7B2ED9A2163FE498E086BC7";
  var_0["_encstr_87E71836CEFAA15D32BEDEEAE8C65A7395BE1BBDD8BD39DCEB62"] = "_encstr_A179186A0EE081B37A30101320EA2959CDD7A2E286DAF5BB12D8";
  var_0["_encstr_81E7182352E7A947F8AF2F93609BFBA54D97C74F504A42AE97C5"] = "_encstr_8866187AA5204D7D40BA309B6754716ACDB217A787DF2E787AD1";
  var_0["_encstr_88E71881B20E60FF33B06528A36A02439B1158E080C85BF3914F"] = "_encstr_B87418EF7DB797CBC822AA6A1AF5B1C97E02E6F5565F6523203A";
  var_0["_encstr_97E71847F026B88311703DB3CDD99A7689C9CFEF6398FAAB0FDD"] = "_encstr_9B6618DFE58FC36B12FF6AFF29B7A1D8B6BFB3E157970EA2A99F";
  var_0["_encstr_AAE718B8D271790323E7087DA46BC82DA7F91B50FA95851BF795"] = "_encstr_AB571827B5BF49F310EA52AAD238F99106DADFAFAE87DD6B6882";
  var_0["_encstr_85E718011A1753C847078FA3342D602887F19908127F969B5146"] = "_encstr_B21B18605C0C06180803E20C810C02C08B18030C40625CC00381";
  var_0["_encstr_ADE718B78F6F21A5EA29F85BDBBCABC53BA14B878AA0BBAB174C"] = "_encstr_950A18265C60C018010C1799C00C04605C33180C804CB8180C18";
  return var_0;
}

_get_sorted_list_of_channel_plus_child_channels(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = [];
  var_2[0] = var_0;

  if(isDefined(level.hudoutlinechannels[var_0].childchannels) && level.hudoutlinechannels[var_0].childchannels.size > 0) {
    foreach(var_4 in level.hudoutlinechannels[var_0].childchannels) {
      if(level.hudoutlinechannels[var_4].entinfos.size > 0) {
        for(var_5 = 0; var_5 < var_2.size; var_5++) {
          if(!var_1) {
            if(level.hudoutlinechannels[var_2[var_5]].priority >= level.hudoutlinechannels[var_4].priority) {
              var_2 = outline_array_insert(var_2, var_4, var_5);
              break;
            } else if(var_5 + 1 == var_2.size) {
              var_2[var_5 + 1] = var_4;
              break;
            }
          } else if(level.hudoutlinechannels[var_2[var_5]].priority < level.hudoutlinechannels[var_4].priority) {
            var_2 = outline_array_insert(var_2, var_4, var_5);
            break;
          } else if(var_5 + 1 == var_2.size) {
            var_2[var_5 + 1] = var_4;
            break;
          }
        }
      }
    }
  }

  return var_2;
}

outline_array_insert(var_0, var_1, var_2) {
  if(var_2 == var_0.size) {
    var_3 = var_0;
    var_3[var_3.size] = var_1;
    return var_3;
  }

  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    if(var_5 == var_2) {
      var_3[var_5] = var_1;
      var_4 = 1;
    }

    var_3[var_5 + var_4] = var_0[var_5];
  }

  return var_3;
}