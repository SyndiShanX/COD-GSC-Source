/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\empgrenade.csc
***********************************************/

#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#namespace empgrenade;

function private autoexec __init__system__() {
  system::register(#"empgrenade", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("toplayer", "empd", 1, 1, "int", &onempchanged, 0, 1);
  clientfield::register("toplayer", "empd_monitor_distance", 1, 1, "int", &onempmonitordistancechanged, 0, 0);
  callback::on_spawned(&on_player_spawned);
}

function onempchanged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  localplayer = function_5c10bd79(binitialsnap);

  if(bwastimejump == 1) {
    self startempeffects(localplayer);
    return;
  }

  already_distance_monitored = localplayer clientfield::get_to_player("empd_monitor_distance") == 1;

  if(!already_distance_monitored) {
    self stopempeffects(localplayer, fieldname);
  }
}

function startempeffects(localplayer, bwastimejump = 0) {
  if(!bwastimejump) {
    playSound(0, #"mpl_plr_emp_activate", (0, 0, 0));
  }

  audio::playloopat("mpl_plr_emp_looper", (0, 0, 0));
}

function stopempeffects(localplayer, oldval, bwastimejump = 0) {
  if(oldval != 0 && !bwastimejump) {
    playSound(0, #"mpl_plr_emp_deactivate", (0, 0, 0));
  }

  audio::stoploopat("mpl_plr_emp_looper", (0, 0, 0));
}

function on_player_spawned(localclientnum) {
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

function onempmonitordistancechanged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  localplayer = function_5c10bd79(bnewent);

  if(fieldname == 1) {
    startempeffects(localplayer, bwastimejump);
    localplayer monitordistance(bnewent);
    return;
  }

  stopempeffects(localplayer, binitialsnap, bwastimejump);
  localplayer notify(#"end_emp_monitor_distance");
}

function monitordistance(localclientnum) {
  localplayer = self;
  localplayer endon(#"death");
  localplayer endon(#"end_emp_monitor_distance");
  localplayer endon(#"team_changed");

  if(localplayer isempjammed() == 0) {
    return;
  }

  distance_to_closest_enemy_emp_ui_model = getuimodel(function_1df4c3b0(localclientnum, #"hud_items"), "distanceToClosestEnemyEmpKillstreak");
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

      wait 0.1;
    }
  }
}