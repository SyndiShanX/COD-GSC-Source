/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\empgrenade.csc
***********************************************/

#include scripts\core_common\audio_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\filter_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;

#namespace empgrenade;

autoexec __init__system__() {
  system::register(#"empgrenade", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "empd", 1, 1, "int", &onempchanged, 0, 1);
  clientfield::register("toplayer", "empd_monitor_distance", 1, 1, "int", &onempmonitordistancechanged, 0, 0);
  callback::on_spawned(&on_player_spawned);
}

onempchanged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  localplayer = function_5c10bd79(localclientnum);

  if(newval == 1) {
    self startempeffects(localplayer);
    return;
  }

  already_distance_monitored = localplayer clientfield::get_to_player("empd_monitor_distance") == 1;

  if(!already_distance_monitored) {
    self stopempeffects(localplayer, oldval);
  }
}

startempeffects(localplayer, bwastimejump = 0) {
  filter::init_filter_tactical(localplayer);
  filter::enable_filter_tactical(localplayer, 2);
  filter::set_filter_tactical_amount(localplayer, 2, 1);

  if(!bwastimejump) {
    playSound(0, #"mpl_plr_emp_activate", (0, 0, 0));
  }

  audio::playloopat("mpl_plr_emp_looper", (0, 0, 0));
}

stopempeffects(localplayer, oldval, bwastimejump = 0) {
  filter::init_filter_tactical(localplayer);
  filter::disable_filter_tactical(localplayer, 2);

  if(oldval != 0 && !bwastimejump) {
    playSound(0, #"mpl_plr_emp_deactivate", (0, 0, 0));
  }

  audio::stoploopat("mpl_plr_emp_looper", (0, 0, 0));
}

on_player_spawned(localclientnum) {
  self endon(#"disconnect");
  localplayer = function_5c10bd79(localclientnum);

  if(localplayer != self) {
    return;
  }

  curval = localplayer clientfield::get_to_player("empd_monitor_distance");
  inkillcam = function_1cbf351b(localclientnum);

  if(curval > 0 && localplayer isempjammed()) {
    startempeffects(localplayer, inkillcam);
    localplayer monitordistance(localclientnum);
    return;
  }

  stopempeffects(localplayer, 0, 1);
  localplayer notify(#"end_emp_monitor_distance");
}

onempmonitordistancechanged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  localplayer = function_5c10bd79(localclientnum);

  if(newval == 1) {
    startempeffects(localplayer, bwastimejump);
    localplayer monitordistance(localclientnum);
    return;
  }

  stopempeffects(localplayer, oldval, bwastimejump);
  localplayer notify(#"end_emp_monitor_distance");
}

monitordistance(localclientnum) {
  localplayer = self;
  localplayer endon(#"death");
  localplayer endon(#"end_emp_monitor_distance");
  localplayer endon(#"team_changed");

  if(localplayer isempjammed() == 0) {
    return;
  }

  distance_to_closest_enemy_emp_ui_model = getuimodel(getuimodelforcontroller(localclientnum), "distanceToClosestEnemyEmpKillstreak");
  new_distance = 0;
  max_static_value = getdvarfloat(#"ks_emp_fullscreen_maxstaticvalue", 0);
  min_static_value = getdvarfloat(#"ks_emp_fullscreen_minstaticvalue", 0);
  min_radius_max_static = getdvarfloat(#"ks_emp_fullscreen_minradiusmaxstatic", 0);
  max_radius_min_static = getdvarfloat(#"ks_emp_fullscreen_maxradiusminstatic", 0);

  if(isDefined(distance_to_closest_enemy_emp_ui_model)) {
    while(true) {

      max_static_value = getdvarfloat(#"ks_emp_fullscreen_maxstaticvalue", 0);
      min_static_value = getdvarfloat(#"ks_emp_fullscreen_minstaticvalue", 0);
      min_radius_max_static = getdvarfloat(#"ks_emp_fullscreen_minradiusmaxstatic", 0);
      max_radius_min_static = getdvarfloat(#"ks_emp_fullscreen_maxradiusminstatic", 0);

        new_distance = getuimodelvalue(distance_to_closest_enemy_emp_ui_model);
      range = max_radius_min_static - min_radius_max_static;
      current_static_value = max_static_value - (range <= 0 ? max_static_value : (new_distance - min_radius_max_static) / range);
      current_static_value = math::clamp(current_static_value, min_static_value, max_static_value);
      emp_grenaded = localplayer clientfield::get_to_player("empd") == 1;

      if(emp_grenaded && current_static_value < 1) {
        current_static_value = 1;
      }

      filter::set_filter_tactical_amount(localplayer, 2, current_static_value);
      wait 0.1;
    }
  }
}