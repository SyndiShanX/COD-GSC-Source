/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\outline.gsc
***********************************************/



#using scripts\engine\utility;
#using scripts\sp\outline;
#namespace outline;

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

function hudoutline_enable_internal(channelname, hudoutlineasset) {
  if(!isDefined(channelname)) {
    channelname = "default";
  }

  if(!isDefined(level.hudoutlinechannels)) {
    hudoutline_channels_init();
  }

  if(hudoutline_is_ent_in_channel(channelname, self)) {
    hudoutline_update_entinfo(channelname, self, hudoutlineasset);
  } else {
    size = level.hudoutlinechannels[channelname].entinfos.size;
    level.hudoutlinechannels[channelname].entinfos[size] = hudoutline_create_entinfo(self, hudoutlineasset);
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
      _enable_hudoutline_on_ent(self, hudoutlineasset, channelname);
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
    _enable_hudoutline_on_ent(self, hudoutlineasset, parentchannelname);
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
        scripts\sp\outline::hudoutline_activate_best_channel();
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
      scripts\sp\outline::hudoutline_activate_best_channel();
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

function hudoutline_create_entinfo(ent, hudoutlineasset) {
  entinfo = spawnStruct();
  entinfo.ent = ent;
  entinfo.hudoutlineasset = hudoutlineasset;
  return entinfo;
}

function hudoutline_update_entinfo(channelname, ent, hudoutlineasset) {
  foreach(entinfo in level.hudoutlinechannels[channelname].entinfos) {
    if(entinfo.ent == ent) {
      entinfo.hudoutlineasset = hudoutlineasset;
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
      ent hudoutlineenable(entinfo.hudoutlineasset);
    }
  }
}

function _enable_hudoutline_on_ent(ent, hudoutlineasset, parentchannelname) {
  if(!isDefined(level.hudoutlinechannels[parentchannelname].childchannels) || level.hudoutlinechannels[parentchannelname].childchannels.size == 0) {
    ent hudoutlineenable(hudoutlineasset);
    return;
  }

  var_85db4751771acfdf = _get_sorted_list_of_channel_plus_child_channels(parentchannelname, 1);
  outlinedent = 0;

  for(i = 0; i < var_85db4751771acfdf.size; i++) {
    foreach(entinfo in level.hudoutlinechannels[var_85db4751771acfdf[i]].entinfos) {
      if(entinfo.ent == ent) {
        ent hudoutlineenable(entinfo.hudoutlineasset);
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
        ent hudoutlineenable(entinfo.hudoutlineasset);
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
    scripts\sp\outline::hudoutline_channels_init();
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
  scripts\engine\utility::waittill_any("death", "entitydeleted");
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

function outline_fade_alpha_for_index(index, alpha, time) {
  thread outline_fade_alpha_for_index_internal(index, alpha, time);
}

function outline_fade_alpha_for_index_internal(index, alpha, time) {
  level notify("hud_outline_alpha_fade_" + index);
  level endon("hud_outline_alpha_fade_" + index);
  index++;
  dvarstr = hashcat(@ "hash_1429c8e20321bbcd", index);
  var_4486ff9d1102f083 = getDvar(dvarstr);
  var_4486ff9d1102f083 = strtok(var_4486ff9d1102f083, " ");
  dvarvalprefix = var_4486ff9d1102f083[0] + " " + var_4486ff9d1102f083[1] + " " + var_4486ff9d1102f083[2] + " ";
  currentalpha = float(var_4486ff9d1102f083[3]);
  range = alpha - currentalpha;
  interval = 0.05;
  count = int(time / interval);

  if(count > 0) {
    delta = range / count;

    while(count) {
      currentalpha += delta;
      currentalpha = clamp(currentalpha, 0, 1);
      setsaveddvar(dvarstr, dvarvalprefix + currentalpha);
      wait interval;
      count--;
    }
  }

  setsaveddvar(dvarstr, dvarvalprefix + alpha);
}