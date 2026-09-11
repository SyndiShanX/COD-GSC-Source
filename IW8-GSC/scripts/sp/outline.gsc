/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\outline.gsc
***********************************************/

function hudoutline_channels_init() {
  if(!isDefined(level.fnhudoutlinedefaultsettings)) {
    level.fnhudoutlinedefaultsettings = &hudoutline_default_settings;
  }

  level.hudoutlinechannels = [];
  hudoutline_add_channel_internal("default", 0, level.fnhudoutlinedefaultsettings);
  setsaveddvar("NMROQRRONQ", 1);
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
  var_2.hudoutlineasset = var_1;
  return var_2;
}

function hudoutline_update_entinfo(var_0, var_1, var_2) {
  foreach(var_4 in level.hudoutlinechannels[var_0].entinfos) {
    if(var_4.ent == var_1) {
      var_4.hudoutlineasset = var_2;
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
      var_5 hudoutlineenable(var_4.hudoutlineasset);
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
        var_0 hudoutlineenable(var_7.hudoutlineasset);
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
        var_0 hudoutlineenable(var_6.hudoutlineasset);
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
  scripts\engine\utility::waittill_any("death", "entitydeleted");
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
    GscBinSkip0(0x2e, "MKOQSSQKLL", 1);
  }

  GscBinSkip0(0x2e, "LRMPROLMKN", "0.9 0.9 0.9 0.5");
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

function outline_fade_alpha_for_index(var_0, var_1, var_2) {
  thread outline_fade_alpha_for_index_internal(var_0, var_1, var_2);
}

function outline_fade_alpha_for_index_internal(var_0, var_1, var_2) {
  level notify("hud_outline_alpha_fade_" + var_0);
  level endon("hud_outline_alpha_fade_" + var_0);
  var_0++;
  var_3 = "cg_hud_outline_colors_" + var_0;
  var_4 = getDvar(var_3);
  var_4 = strtok(var_4, " ");
  var_5 = var_4[0] + " " + var_4[1] + " " + var_4[2] + " ";
  var_6 = float(var_4[3]);
  var_7 = var_1 - var_6;
  var_8 = 0.05;
  var_9 = int(var_2 / var_8);

  if(var_9 > 0) {
    var_10 = var_7 / var_9;

    while(var_9) {
      var_6 += var_10;
      var_6 = clamp(var_6, 0, 1);
      setsaveddvar(var_3, var_5 + var_6);
      wait var_8;
      var_9--;
    }
  }

  setsaveddvar(var_3, var_5 + var_1);
}