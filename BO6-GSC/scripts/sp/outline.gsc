/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\outline.gsc
**************************************/

#using scripts\engine\utility;
#namespace outline;

function hudoutline_channels_init() {
  if(!isDefined(level.fnhudoutlinedefaultsettings)) {
    level.fnhudoutlinedefaultsettings = &hudoutline_default_settings;
  }

  level.hudoutlinechannels = [];
  hudoutline_add_channel_internal("\x91\xca\xcc\v\xab\xd8:", 0, level.fnhudoutlinedefaultsettings);
  setsaveddvar(@ "r_hudoutlineenable", 1);
  default_settings = [[level.fnhudoutlinedefaultsettings]]();

  for(i = 0; i < 8; i++) {
    dvarstr = hashcat(@ "hash_1429c8e20321bbcd", i);
    setsaveddvar(dvarstr, default_settings[dvarstr]);
  }
}

function hudoutline_enable_internal(channelname, hudoutlineasset) {
  if(!isDefined(channelname)) {
    channelname = "\x91\xca\xcc\v\xab\xd8:";
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
    channelname = "\x91\xca\xcc\v\xab\xd8:";
  }

  if(!isDefined(level.hudoutlinechannels)) {
    return;
  }

  if(isDefined(self)) {
    self notify(channelname + "\x1a\xba\xc8\xdb\xd5\xd1c\x96\xcd\x95_\x8c\x96\xcd\xc2\x89c\xb2");
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
  var_42ba5cf1ac666e54 = _get_sorted_list_of_channel_plus_child_channels(channelname);

  for(i = 0; i < var_42ba5cf1ac666e54.size; i++) {
    foreach(entinfo in level.hudoutlinechannels[var_42ba5cf1ac666e54[i]].entinfos) {
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

  var_95a7ba105b9dc40a = _get_sorted_list_of_channel_plus_child_channels(parentchannelname, 1);
  outlinedent = 0;

  for(i = 0; i < var_95a7ba105b9dc40a.size; i++) {
    foreach(entinfo in level.hudoutlinechannels[var_95a7ba105b9dc40a[i]].entinfos) {
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

  var_95a7ba105b9dc40a = _get_sorted_list_of_channel_plus_child_channels(parentchannelname, 1);
  outlinedent = 0;

  for(i = 0; i < var_95a7ba105b9dc40a.size; i++) {
    foreach(entinfo in level.hudoutlinechannels[var_95a7ba105b9dc40a[i]].entinfos) {
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
  level notify("\x11\x88\xaf=\x92jQ\xaa\x9e\xbf\xebt\xee+\x1ch%\xe9V(\xd3q\x8f\xa7\x8c\xcfW\xc1\xcb\t\xa1");
  level endon("\x11\x88\xaf=\x92jQ\xaa\x9e\xbf\xebt\xee+\x1ch%\xe9V(\xd3q\x8f\xa7\x8c\xcfW\xc1\xcb\t\xa1");
  wait 0.05;
  defaultsettings = [[level.fnhudoutlinedefaultsettings]]();
  newsettings = [[level.hudoutlinechannels[channelname].settingsfunc]]();
  assert(isDefined(newsettings), "<dev string:x24>" + channelname + "<dev string:x3c>");

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
  assert(isDefined(level.hudoutlinechannels), "<dev string:xb1>");
  assert(isDefined(level.hudoutlinechannels[parentchannelname]), "<dev string:x107>");
  assert(!isDefined(level.hudoutlinechannels[channelname]), "<dev string:x15d>");

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
    self endon("\xca\xcd\xc8\xf6\xcdS\xb9\xec");
  }

  self endon(channelname + "\x1a\xba\xc8\xdb\xd5\xd1c\x96\xcd\x95_\x8c\x96\xcd\xc2\x89c\xb2");
  utility::waittill_any("\x1e\xfd\xd1\xa2\a", "\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  thread hudoutline_disable_internal(channelname);
}

function play_animation_on_channel(channelname, animationfunc) {
  if(!isDefined(level.hudoutlinecurchannel) || level.hudoutlinecurchannel != channelname) {
    return;
  }

  level notify("JX\x884\xf3\xfa\xc1M\x9b\x94h\xf7\xb5\x8aE\x1f\xa8\t\x1e\xaa\x90\x82@\xad\aR\xe5z\xc9,g" + channelname);
  level endon("\x11\x88\xaf=\x92jQ\xaa\x9e\xbf\xebt\xee+\x1ch%\xe9V(\xd3q\x8f\xa7\x8c\xcfW\xc1\xcb\t\xa1");
  level endon("JX\x884\xf3\xfa\xc1M\x9b\x94h\xf7\xb5\x8aE\x1f\xa8\t\x1e\xaa\x90\x82@\xad\aR\xe5z\xc9,g" + channelname);
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

  hudoutlinesettings[@ "r_hudoutlinefillcolor0"] = "\x03\xe2\x9c\x10\x18\x8b\x93\x020\xb8N\x10\x06\xb8M";
  hudoutlinesettings[@ "r_hudoutlinefillcolor1"] = "\xc8\xdb\x11W\xff\xa5\xfd\x8e\xf2\x89\xd9\x7f\x88G\xb7";
  hudoutlinesettings[@ "r_hudoutlineoccludedoutlinecolor"] = "X\xa2dH\x06\xf8\xf4";
  hudoutlinesettings[@ "r_hudoutlineoccludedinlinecolor"] = "w\xd2#Q~]9/S<";
  hudoutlinesettings[@ "r_hudoutlineoccludedinteriorcolor"] = "\x14AcK\x9f\x03h\x18\xbd\x8f\xad\xbe\x9a";
  hudoutlinesettings[@ "r_hudoutlineoccludedcolorfromfill"] = 1;
  hudoutlinesettings[@ "hash_79a0c60ce3306d67"] = "\xe6\xbf\x90}\xce\r%n\xf3\xc4}=!\x7f\xa5\xbe\xdf\x06\x80\t\xaf\xeb\xca";
  hudoutlinesettings[@ "hash_79a0c50ce3306b34"] = "\x18\xc5\a\a\x8c@\x81\xb8p\x1cF\x10\x06\x8b\x0e\a\x8c\x10\x98\x17\xc00\x03";
  hudoutlinesettings[@ "hash_79a0c80ce33071cd"] = "<\xf4\x19\xbb\xf5_\xfb\x11\xc0\xf9\x0f\xd0\xbfE\xf3|Lw9\xa1\xc0\x1f\xfb";
  hudoutlinesettings[@ "hash_79a0c70ce3306f9a"] = "(,\xa6\xbd\x13\xf6\xd2\xfa\xa0\xfcm\x1a\xf1\xcfa\x04\x1f\xcb\\\x94`d/";
  hudoutlinesettings[@ "hash_79a0c20ce330649b"] = "+\xb7\xcb\b\x9bP\xb9.\xeai\xee\xdf\xe0U\xef\x91\xb8\x05\"\xf1^\x12\xb4";
  hudoutlinesettings[@ "hash_79a0c10ce3306268"] = "\xb8\xc02\xd1J\xcd\xbe*3=\xec\a\x93p_\xb8\x98+h\xf2\x16l8";
  hudoutlinesettings[@ "hash_79a0c40ce3306901"] = "0\xfd\x19\xc0\xbe]{\xe1\x9c{]\xac\xd0i{0\xb0x\x19\xee\xbe\x1dk";
  hudoutlinesettings[@ "hash_79a0c30ce33066ce"] = "H\x17X\x8d\xe9-h<\xd9d,H\xcb[\x1c\vK3\x8eW7\xe4\x8f";
  return hudoutlinesettings;
}

function _get_sorted_list_of_channel_plus_child_channels(channelname, invertorder) {
  if(!isDefined(invertorder)) {
    invertorder = 0;
  }

  var_5c43aaff759a636a = [];
  var_5c43aaff759a636a[0] = channelname;

  if(isDefined(level.hudoutlinechannels[channelname].childchannels) && level.hudoutlinechannels[channelname].childchannels.size > 0) {
    foreach(childchannel in level.hudoutlinechannels[channelname].childchannels) {
      if(level.hudoutlinechannels[childchannel].entinfos.size > 0) {
        for(i = 0; i < var_5c43aaff759a636a.size; i++) {
          if(!invertorder) {
            if(level.hudoutlinechannels[var_5c43aaff759a636a[i]].priority >= level.hudoutlinechannels[childchannel].priority) {
              var_5c43aaff759a636a = outline_array_insert(var_5c43aaff759a636a, childchannel, i);
              break;
            } else if(i + 1 == var_5c43aaff759a636a.size) {
              var_5c43aaff759a636a[i + 1] = childchannel;
              break;
            }

            continue;
          }

          if(level.hudoutlinechannels[var_5c43aaff759a636a[i]].priority < level.hudoutlinechannels[childchannel].priority) {
            var_5c43aaff759a636a = outline_array_insert(var_5c43aaff759a636a, childchannel, i);
            break;
          }

          if(i + 1 == var_5c43aaff759a636a.size) {
            var_5c43aaff759a636a[i + 1] = childchannel;
            break;
          }
        }
      }
    }
  }

  return var_5c43aaff759a636a;
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
  level notify("\x98[O\xc0\x131\x1a\\H\x8cn\x13\xdc\xdeC\xa4nU\xe7\x11\xf8\x12\x9d" + index);
  level endon("\x98[O\xc0\x131\x1a\\H\x8cn\x13\xdc\xdeC\xa4nU\xe7\x11\xf8\x12\x9d" + index);
  index++;
  dvarstr = hashcat(@ "hash_1429c8e20321bbcd", index);
  var_c5a4c0ad3e174a4a = getDvar(dvarstr);
  var_c5a4c0ad3e174a4a = strtok(var_c5a4c0ad3e174a4a, "\xda");
  dvarvalprefix = var_c5a4c0ad3e174a4a[0] + "\xda" + var_c5a4c0ad3e174a4a[1] + "\xda" + var_c5a4c0ad3e174a4a[2] + "\xda";
  currentalpha = float(var_c5a4c0ad3e174a4a[3]);
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