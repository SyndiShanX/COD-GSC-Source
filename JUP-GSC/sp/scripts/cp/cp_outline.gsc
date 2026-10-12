/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_outline.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\cp\cp_agent_utils;
#using scripts\cp\cp_outline;
#using scripts\cp\laststand;
#using scripts\cp\persistence;
#using scripts\cp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace cp_outline;

function outline_monitor_think() {
  self endon("disconnect");
  level endon("game_ended");
  wait 2;

  while(true) {
    item_outline_weapon_monitor();
    wait 0.05;
  }
}

function outline_init() {
  level.outline_weapon_watch_list = [];
}

function item_outline_weapon_monitor() {
  self endon("refresh_outline");

  foreach(item in level.outline_weapon_watch_list) {
    if(!isDefined(item)) {
      continue;
    }

    if(!isDefined(item.cost)) {
      continue;
    }

    weapon_flag = 1;
    in_close_proximity = distancesquared(self.origin, item.origin) < 1000000;

    if(in_close_proximity && !is_holding_deployable() && !has_special_weapon()) {
      scripts\cp\cp_outline::enable_outline_for_player(item, self, get_hudoutline_item(item, weapon_flag), "high");
    } else if(in_close_proximity && (is_holding_deployable() || has_special_weapon())) {
      scripts\cp\cp_outline::enable_outline_for_player(item, self, "outline_depth_orange", "high");
    } else {
      scripts\cp\cp_outline::disable_outline_for_player(item, self);
    }

    if(index & 0) {
      wait 0.05;
    }
  }
}

function get_hudoutline_item(item, weapon_flag) {
  cost = item.cost;

  if(isDefined(level.has_weapon_variation)) {
    if(isDefined(item.struct.weapon) && self[[level.has_weapon_variation]](item.struct.weapon)) {
      if(isDefined(level.get_weapon_level_func)) {
        var_ceb40e0d9504f27a = self[[level.get_weapon_level_func]](item.struct.weapon);

        if(var_ceb40e0d9504f27a > 1) {
          cost = 4500;
        } else {
          cost = item.cost * 0.5;
        }
      } else {
        cost = item.cost * 0.5;
      }
    }
  }

  if(scripts\cp\persistence::player_has_enough_currency(cost) || istrue(item.enabled)) {
    return "outline_depth_cyan";
  }

  return "outline_depth_red";
}

function playeroutlinemonitor() {
  self endon("disconnect");

  while(true) {
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

function should_put_player_outline_on(player) {
  if(istrue(self.no_team_outlines)) {
    return 0;
  }

  if(!isalive(player) || !isDefined(player.maxhealth) || !player.maxhealth || player.no_outline) {
    return 0;
  }

  var_a23e3656c612a7a7 = distancesquared(self.origin, player.origin) > 2250000;

  if(var_a23e3656c612a7a7) {
    return 1;
  }

  var_c3579bdec26ccb2d = !scripts\engine\trace::_bullet_trace_passed(self getEye(), player getEye(), 0, self);
  return var_c3579bdec26ccb2d;
}

function get_hudoutline_for_player_health(player) {
  health_ratio = player.health / 100;

  if(health_ratio <= 0.33 || scripts\cp\laststand::player_in_laststand(player)) {
    return "outline_nodepth_red";
  }

  if(health_ratio <= 0.66) {
    return "outline_nodepth_orange";
  }

  if(health_ratio <= 1) {
    return "outline_nodepth_cyan";
  }

  return "outline_nodepth_white";
}

function enable_outline_for_players(item, players, hudoutlineassetname, priority) {
  item hudoutlineenableforclients(players, hudoutlineassetname);
}

function enable_outline_for_player(item, player, hudoutlineassetname, priority) {
  item hudoutlineenableforclient(player, hudoutlineassetname);
}

function disable_outline_for_players(item, players) {
  item hudoutlinedisableforclients(players);
}

function disable_outline_for_player(item, player) {
  item hudoutlinedisableforclient(player);
}

function disable_outline(item) {
  item hudoutlinedisable();
}

function enable_outline(item, hudoutlineassetname) {
  item hudoutlineenable(hudoutlineassetname);
}

function set_outline(hudoutlineassetname) {
  level endon("game_ended");
  level endon("outline_disabled");

  if(!isDefined(hudoutlineassetname)) {
    hudoutlineassetname = "outline_nodepth_orange";
  }

  while(true) {
    ai_array = array_combine(level.agentarray, level.vehicle_ai_script_models);

    for(i = 0; i < ai_array.size; i++) {
      ai = ai_array[i];

      if(isDefined(ai.var_91a6849f0ee39fe7)) {
        continue;
      }

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

function unset_outline() {
  ai_array = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");
  ai_array = array_combine(ai_array, level.vehicle_ai_script_models);

  foreach(enemy in ai_array) {
    if(isDefined(enemy.var_91a6849f0ee39fe7)) {
      continue;
    }

    if(isDefined(enemy.damaged_by_players)) {
      continue;
    }

    if(isDefined(enemy.marked_for_challenge)) {
      continue;
    }

    scripts\cp\cp_outline::disable_outline_for_players(enemy, level.players);
    level notify("outline_disabled");
  }
}

function save_outline_settings() {
  var_90a7b8c1c3d338d2 = [@ "r_hudoutlineFillColor0", @ "r_hudoutlineFillColor1", @ "hash_3bb847d049003050", @ "r_hudoutlineOccludedOutlineColor", @ "r_hudoutlineOccludedInlineColor", @ "r_hudoutlineOccludedInteriorColor", @ "r_hudOutlineOccludedColorFromFill", @ "hash_79a0c60ce3306d67", @ "hash_79a0c50ce3306b34", @ "hash_79a0c80ce33071cd", @ "hash_79a0c70ce3306f9a", @ "hash_79a0c20ce330649b", @ "hash_79a0c10ce3306268", @ "hash_79a0c40ce3306901"];

  if(!isDefined(level.hudoutlinesettings)) {
    level.hudoutlinesettings = [];
  }

  foreach(hudstring in var_90a7b8c1c3d338d2) {
    level.hudoutlinesettings[hudstring] = getDvar(hudstring);
  }
}

function restore_outline_settings() {
  var_90a7b8c1c3d338d2 = [@ "r_hudoutlineFillColor0", @ "r_hudoutlineFillColor1", @ "hash_3bb847d049003050", @ "r_hudoutlineOccludedOutlineColor", @ "r_hudoutlineOccludedInlineColor", @ "r_hudoutlineOccludedInteriorColor", @ "r_hudOutlineOccludedColorFromFill", @ "hash_79a0c60ce3306d67", @ "hash_79a0c50ce3306b34", @ "hash_79a0c80ce33071cd", @ "hash_79a0c70ce3306f9a", @ "hash_79a0c20ce330649b", @ "hash_79a0c10ce3306268", @ "hash_79a0c40ce3306901"];

  if(!isDefined(level.hudoutlinesettings)) {
    return;
  }

  foreach(hudstring in var_90a7b8c1c3d338d2) {
    setDvar(hudstring, level.hudoutlinesettings[hudstring]);
  }
}

function hudoutline_enable(hudoutlineassetname, channelname) {
  hudoutline_enable_internal(channelname, hudoutlineassetname);
}

function hudoutline_disable(channelname) {
  hudoutline_disable_internal(channelname);
}

function hudoutline_channels_init() {
  if(!isDefined(level.fnhudoutlinedefaultsettings)) {
    level.fnhudoutlinedefaultsettings = &hudoutline_default_settings;
  }

  level.hudoutlinechannels = [];
  hudoutline_add_channel_internal("default", 0, level.fnhudoutlinedefaultsettings);
  setsaveddvar(@ "r_hudoutlineenable", 1);
  default_settings = [[level.fnhudoutlinedefaultsettings]]();

  for(i = 0; i < 8; i++) {
    dvarstr = hashcat(@ "hash_1429c8e20321bbcd", i);
    setsaveddvar(dvarstr, default_settings[dvarstr]);
  }
}

function hudoutline_enable_internal(channelname, hudoutlineassetname) {
  if(!isDefined(channelname)) {
    channelname = "default";
  }

  if(!isDefined(level.hudoutlinechannels)) {
    hudoutline_channels_init();
  }

  if(hudoutline_is_ent_in_channel(channelname, self)) {
    hudoutline_update_entinfo(channelname, self, hudoutlineassetname);
  } else {
    size = level.hudoutlinechannels[channelname].entinfos.size;
    level.hudoutlinechannels[channelname].entinfos[size] = hudoutline_create_entinfo(self, hudoutlineassetname);
    thread hudoutline_disable_on_death(channelname);
  }

  if(!isDefined(level.hudoutlinechannels[channelname].parentchannel)) {
    if(!isDefined(level.hudoutlinecurchannel)) {
      hudoutline_activate_channel(channelname);
    }

    curchannelpriority = level.hudoutlinechannels[level.hudoutlinecurchannel].priority;
    thischannelpriority = level.hudoutlinechannels[channelname].priority;

    if(level.hudoutlinecurchannel != channelname && curchannelpriority < thischannelpriority) {
      hudoutline_activate_channel(channelname);
    } else if(level.hudoutlinecurchannel == channelname) {
      _enable_hudoutline_on_ent(self, hudoutlineassetname, channelname);
    }

    return;
  }

  parentchannelname = level.hudoutlinechannels[channelname].parentchannel;

  if(!isDefined(level.hudoutlinecurchannel)) {
    hudoutline_activate_channel(parentchannelname);
  }

  curchannelpriority = level.hudoutlinechannels[level.hudoutlinecurchannel].priority;
  parentchannelpriority = level.hudoutlinechannels[parentchannelname].priority;

  if(level.hudoutlinecurchannel != parentchannelname && curchannelpriority < parentchannelpriority) {
    hudoutline_activate_channel(parentchannelname);
    return;
  }

  if(level.hudoutlinecurchannel == parentchannelname) {
    _enable_hudoutline_on_ent(self, hudoutlineassetname, parentchannelname);
  }
}

function hudoutline_disable_internal(channelname) {
  if(!isDefined(channelname)) {
    channelname = "default";
  }

  if(!isDefined(level.hudoutlinechannels)) {
    return;
  }

  if(isDefined(self)) {
    self notify(channelname + "hudoutline_disable");
  }

  index = undefined;

  foreach(i, entinfo in level.hudoutlinechannels[channelname].entinfos) {
    if(!isDefined(entinfo.ent)) {
      level.hudoutlinechannels[channelname].entinfos[i] = undefined;
      continue;
    }

    if(entinfo.ent == self) {
      index = i;
      level.hudoutlinechannels[channelname].entinfos[index] = undefined;
      break;
    }
  }

  newarray = [];

  foreach(item in level.hudoutlinechannels[channelname].entinfos) {
    if(!isDefined(item)) {
      continue;
    }

    newarray[newarray.size] = item;
  }

  level.hudoutlinechannels[channelname].entinfos = newarray;

  if(!isDefined(level.hudoutlinecurchannel)) {
    return;
  }

  if(level.hudoutlinecurchannel == channelname) {
    if(isDefined(index)) {
      _disable_hudoutline_on_ent(self, channelname);
    }

    if(level.hudoutlinechannels[channelname].entinfos.size == 0) {
      foundents = 0;

      if(isDefined(level.hudoutlinechannels[channelname].childchannels) && level.hudoutlinechannels[channelname].childchannels.size > 0) {
        foreach(childchannelname in level.hudoutlinechannels[channelname].childchannels) {
          if(level.hudoutlinechannels[childchannelname].entinfos.size > 0) {
            foundents = 1;
            break;
          }
        }
      }

      if(!foundents) {
        hudoutline_activate_best_channel();
      }
    }

    return;
  }

  if(isDefined(level.hudoutlinechannels[channelname].parentchannel) && level.hudoutlinecurchannel == level.hudoutlinechannels[channelname].parentchannel) {
    parentchannelname = level.hudoutlinechannels[channelname].parentchannel;

    if(isDefined(index)) {
      _disable_hudoutline_on_ent(self, parentchannelname);
    }

    if(level.hudoutlinechannels[channelname].entinfos.size == 0) {
      hudoutline_activate_best_channel();
    }
  }
}

function hudoutline_activate_best_channel() {
  bestpriority = undefined;
  bestchannel = undefined;

  if(isDefined(level.hudoutlineforcedchannels) && level.hudoutlineforcedchannels.size > 0) {
    foreach(channel in level.hudoutlineforcedchannels) {
      if(!isDefined(bestpriority) || level.hudoutlinechannels[channel].priority > bestpriority) {
        bestpriority = level.hudoutlinechannels[channel].priority;
        bestchannel = channel;
      }
    }
  } else {
    foreach(channel in level.hudoutlinechannels) {
      if(isDefined(channel.parentchannel)) {
        continue;
      }

      if(!isDefined(channel.childchannels) || channel.childchannels.size == 0) {
        if(channel.entinfos.size == 0) {
          continue;
        }
      } else {
        foundents = 0;

        if(channel.entinfos.size > 0) {
          foundents = 1;
        }

        foreach(childchannelname in channel.childchannels) {
          if(level.hudoutlinechannels[childchannelname].entinfos.size > 0) {
            foundents = 1;
          }
        }

        if(!foundents) {
          continue;
        }
      }

      if(!isDefined(bestpriority) || channel.priority > bestpriority) {
        bestpriority = channel.priority;
        bestchannel = channel.channelname;
      }
    }
  }

  if(isDefined(bestchannel)) {
    hudoutline_activate_channel(bestchannel);
    return;
  }

  level.hudoutlinecurchannel = undefined;
}

function hudoutline_create_entinfo(ent, hudoutlineassetname) {
  entinfo = spawnStruct();
  entinfo.ent = ent;
  entinfo.hudoutlineassetname = hudoutlineassetname;
  return entinfo;
}

function hudoutline_update_entinfo(channelname, ent, hudoutlineassetname) {
  foreach(entinfo in level.hudoutlinechannels[channelname].entinfos) {
    if(entinfo.ent == ent) {
      entinfo.hudoutlineassetname = hudoutlineassetname;
    }
  }
}

function hudoutline_activate_channel(channelname) {
  if(isDefined(level.hudoutlinecurchannel) && level.hudoutlinecurchannel != channelname) {
    hudoutline_deactivate_channel(level.hudoutlinecurchannel);

    if(isDefined(level.hudoutlinechannels[level.hudoutlinecurchannel].childchannels) && level.hudoutlinechannels[level.hudoutlinecurchannel].childchannels.size > 0) {
      foreach(childchannel in level.hudoutlinechannels[level.hudoutlinecurchannel].childchannels) {
        hudoutline_deactivate_channel(childchannel);
      }
    }
  }

  level.hudoutlinecurchannel = channelname;
  thread hudoutline_set_channel_settings_delayed(channelname);
  _enable_hudoutline_on_channel_ents(channelname);
}

function _enable_hudoutline_on_channel_ents(channelname) {
  var_bf39ce08d38cf891 = _get_sorted_list_of_channel_plus_child_channels(channelname);

  for(i = 0; i < var_bf39ce08d38cf891.size; i++) {
    foreach(entinfo in level.hudoutlinechannels[var_bf39ce08d38cf891[i]].entinfos) {
      ent = entinfo.ent;
      ent hudoutlineenable(entinfo.hudoutlineassetname);
    }
  }
}

function _enable_hudoutline_on_ent(ent, hudoutlineassetname, parentchannelname) {
  if(!isDefined(level.hudoutlinechannels[parentchannelname].childchannels) || level.hudoutlinechannels[parentchannelname].childchannels.size == 0) {
    ent hudoutlineenable(hudoutlineassetname);
    return;
  }

  var_85db4751771acfdf = _get_sorted_list_of_channel_plus_child_channels(parentchannelname, 1);
  outlinedent = 0;

  for(i = 0; i < var_85db4751771acfdf.size; i++) {
    foreach(entinfo in level.hudoutlinechannels[var_85db4751771acfdf[i]].entinfos) {
      if(entinfo.ent == ent) {
        ent hudoutlineenable(entinfo.hudoutlineassetname);
        outlinedent = 1;
        break;
      }
    }

    if(outlinedent) {
      break;
    }
  }
}

function _disable_hudoutline_on_ent(ent, parentchannelname) {
  if(!isDefined(level.hudoutlinechannels[parentchannelname].childchannels) || level.hudoutlinechannels[parentchannelname].childchannels.size == 0) {
    self hudoutlinedisable();
    return;
  }

  var_85db4751771acfdf = _get_sorted_list_of_channel_plus_child_channels(parentchannelname, 1);
  outlinedent = 0;

  for(i = 0; i < var_85db4751771acfdf.size; i++) {
    foreach(entinfo in level.hudoutlinechannels[var_85db4751771acfdf[i]].entinfos) {
      if(entinfo.ent == ent) {
        ent hudoutlineenable(entinfo.hudoutlineassetname);
        outlinedent = 1;
        break;
      }
    }

    if(outlinedent) {
      break;
    }
  }

  if(!outlinedent) {
    self hudoutlinedisable();
  }
}

function hudoutline_set_channel_settings_delayed(channelname) {
  level notify("hudoutline_new_channel_settings");
  level endon("hudoutline_new_channel_settings");
  wait 0.05;
  defaultsettings = [[level.fnhudoutlinedefaultsettings]]();
  newsettings = [[level.hudoutlinechannels[channelname].settingsfunc]]();
  assertex(isDefined(newsettings), "hudoutline channel '" + channelname + "' does not have a proper settings function! See scripts/sp/outline::hudoutline_default_settings() for an example.");

  foreach(key, value in defaultsettings) {
    if(isDefined(newsettings[key])) {
      setsaveddvar(key, newsettings[key]);
      continue;
    }

    setsaveddvar(key, value);
  }

  if(isDefined(level.hudoutlinechannels[channelname].loopingsettingsanimationfunc)) {
    play_animation_on_channel(channelname, level.hudoutlinechannels[channelname].loopingsettingsanimationfunc);
  }
}

function hudoutline_deactivate_channel(channelname) {
  foreach(entinfo in level.hudoutlinechannels[channelname].entinfos) {
    ent = entinfo.ent;
    ent hudoutlinedisable();
  }
}

function hudoutline_add_channel_internal(channelname, priority, settingsfunc) {
  if(!isDefined(settingsfunc)) {
    settingsfunc = level.fnhudoutlinedefaultsettings;
  }

  if(!isDefined(level.hudoutlinechannels)) {
    hudoutline_channels_init();
  }

  if(!isDefined(level.hudoutlinechannels[channelname])) {
    level.hudoutlinechannels[channelname] = spawnStruct();
    level.hudoutlinechannels[channelname].channelname = channelname;
    level.hudoutlinechannels[channelname].priority = priority;
    level.hudoutlinechannels[channelname].settingsfunc = settingsfunc;
    level.hudoutlinechannels[channelname].entinfos = [];
  }
}

function hudoutline_add_child_channel_internal(channelname, priority, parentchannelname) {
  assertex(isDefined(level.hudoutlinechannels), "Tried to create a child hudoutline channel before any other channels were created!");
  assertex(isDefined(level.hudoutlinechannels[parentchannelname]), "Tried to create a child hudoutline channel of a parent channel that doesn't exist!");
  assertex(!isDefined(level.hudoutlinechannels[channelname]), "Tried to create a child hudoutline channel with a name that is already a channel!");

  if(!isDefined(level.hudoutlinechannels[channelname])) {
    level.hudoutlinechannels[channelname] = spawnStruct();
    level.hudoutlinechannels[channelname].channelname = channelname;
    level.hudoutlinechannels[channelname].priority = priority;
    level.hudoutlinechannels[channelname].entinfos = [];
    level.hudoutlinechannels[channelname].parentchannel = parentchannelname;
  }

  if(!isDefined(level.hudoutlinechannels[parentchannelname].childchannels)) {
    level.hudoutlinechannels[parentchannelname].childchannels = [];
  }

  level.hudoutlinechannels[parentchannelname].childchannels[level.hudoutlinechannels[parentchannelname].childchannels.size] = channelname;
}

function hudoutline_override_channel_settingsfunc(channelname, settingsfunc) {
  level.hudoutlinechannels[channelname].settingsfunc = settingsfunc;

  if(isDefined(level.hudoutlinecurchannel) && level.hudoutlinecurchannel == channelname) {
    thread hudoutline_set_channel_settings_delayed(channelname);
  }
}

function hudoutline_is_ent_in_channel(channelname, ent) {
  foreach(entinfo in level.hudoutlinechannels[channelname].entinfos) {
    if(entinfo.ent == ent) {
      return true;
    }
  }

  return false;
}

function hudoutline_force_channel_internal(channelname, shouldforce) {
  if(!isDefined(level.hudoutlineforcedchannels)) {
    level.hudoutlineforcedchannels = [];
  }

  if(shouldforce) {
    foreach(channel in level.hudoutlineforcedchannels) {
      if(channel == channelname) {
        return;
      }
    }

    level.hudoutlineforcedchannels[level.hudoutlineforcedchannels.size] = channelname;
    hudoutline_activate_best_channel();
    return;
  }

  newchannels = [];

  foreach(channel in level.hudoutlineforcedchannels) {
    if(channel != channelname) {
      newchannels[newchannels.size] = channel;
    }
  }

  level.hudoutlineforcedchannels = newchannels;
  hudoutline_activate_best_channel();
}

function hudoutline_disable_on_death(channelname, endonmsg) {
  if(isDefined(endonmsg)) {
    self endon("endonMsg");
  }

  self endon(channelname + "hudoutline_disable");
  scripts\engine\utility::waittill_any_2("death", "entitydeleted");
  thread hudoutline_disable_internal(channelname);
}

function play_animation_on_channel(channelname, animationfunc) {
  if(!isDefined(level.hudoutlinecurchannel) || level.hudoutlinecurchannel != channelname) {
    return;
  }

  level notify("hudoutline_new_anim_on_channel_" + channelname);
  level endon("hudoutline_new_channel_settings");
  level endon("hudoutline_new_anim_on_channel_" + channelname);
  level[[animationfunc]]();
  thread hudoutline_set_channel_settings_delayed(channelname);
}

function play_animation_on_channel_loop(channelname, animationfunc) {
  level.hudoutlinechannels[channelname].loopingsettingsanimationfunc = animationfunc;

  if(!isDefined(level.hudoutlinecurchannel) || level.hudoutlinecurchannel != channelname) {
    return;
  }

  play_animation_on_channel(channelname, animationfunc);
}

function hudoutline_default_settings() {
  hudoutlinesettings = [];

  if(isDefined(level.player.ar_callout_ent)) {
    dist_value = length2d(level.player.origin - level.player.ar_callout_ent.origin);
    norm_value = clamp(dist_value / 1000, 1, 2);
    hudoutlinesettings[@ "hash_3bb847d049003050"] = norm_value;
  } else {
    hudoutlinesettings[@ "hash_3bb847d049003050"] = 1;
  }

  hudoutlinesettings[@ "r_hudoutlineFillColor0"] = "0.9 0.9 0.9 0.5";
  hudoutlinesettings[@ "r_hudoutlineFillColor1"] = "0.3 0.3 0.3 0.5";
  hudoutlinesettings[@ "r_hudoutlineOccludedOutlineColor"] = "1 1 1 1";
  hudoutlinesettings[@ "r_hudoutlineOccludedInlineColor"] = "1 1 1 0.45";
  hudoutlinesettings[@ "r_hudoutlineOccludedInteriorColor"] = ".7 .7 .7 0.25";
  hudoutlinesettings[@ "r_hudOutlineOccludedColorFromFill"] = 1;
  hudoutlinesettings[@ "hash_79a0c60ce3306d67"] = "0.000 0.000 0.000 0.000";
  hudoutlinesettings[@ "hash_79a0c50ce3306b34"] = "0.882 0.882 0.882 1.000";
  hudoutlinesettings[@ "hash_79a0c80ce33071cd"] = "0.945 0.384 0.247 1.000";
  hudoutlinesettings[@ "hash_79a0c70ce3306f9a"] = "0.431 0.745 0.235 1.000";
  hudoutlinesettings[@ "hash_79a0c20ce330649b"] = "0.157 0.784 0.784 1.000";
  hudoutlinesettings[@ "hash_79a0c10ce3306268"] = "0.886 0.600 0.000 1.000";
  hudoutlinesettings[@ "hash_79a0c40ce3306901"] = "0.000 0.000 0.000 1.000";
  hudoutlinesettings[@ "hash_79a0c30ce33066ce"] = "1.000 0.300 0.300 1.000";
  return hudoutlinesettings;
}

function _get_sorted_list_of_channel_plus_child_channels(channelname, invertorder) {
  if(!isDefined(invertorder)) {
    invertorder = 0;
  }

  var_778d8e547335493f = [];
  var_778d8e547335493f[0] = channelname;

  if(isDefined(level.hudoutlinechannels[channelname].childchannels) && level.hudoutlinechannels[channelname].childchannels.size > 0) {
    foreach(childchannel in level.hudoutlinechannels[channelname].childchannels) {
      if(level.hudoutlinechannels[childchannel].entinfos.size > 0) {
        for(i = 0; i < var_778d8e547335493f.size; i++) {
          if(!invertorder) {
            if(level.hudoutlinechannels[var_778d8e547335493f[i]].priority >= level.hudoutlinechannels[childchannel].priority) {
              var_778d8e547335493f = outline_array_insert(var_778d8e547335493f, childchannel, i);
              break;
            } else if(i + 1 == var_778d8e547335493f.size) {
              var_778d8e547335493f[i + 1] = childchannel;
              break;
            }

            continue;
          }

          if(level.hudoutlinechannels[var_778d8e547335493f[i]].priority < level.hudoutlinechannels[childchannel].priority) {
            var_778d8e547335493f = outline_array_insert(var_778d8e547335493f, childchannel, i);
            break;
          }

          if(i + 1 == var_778d8e547335493f.size) {
            var_778d8e547335493f[i + 1] = childchannel;
            break;
          }
        }
      }
    }
  }

  return var_778d8e547335493f;
}

function outline_array_insert(array, object, index) {
  if(index == array.size) {
    temp = array;
    temp[temp.size] = object;
    return temp;
  }

  temp = [];
  offset = 0;

  for(i = 0; i < array.size; i++) {
    if(i == index) {
      temp[i] = object;
      offset = 1;
    }

    temp[i + offset] = array[i];
  }

  return temp;
}