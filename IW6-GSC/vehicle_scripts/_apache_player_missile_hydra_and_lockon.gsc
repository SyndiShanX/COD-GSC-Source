/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_apache_player_missile_hydra_and_lockon.gsc
***********************************************************************/

_precache() {
  precacheitem("apache_hydra_missile");
  precacheitem("apache_lockon_missile");
  precacheitem("apache_lockon_missile_ai_enemy");
  precachemodel("projectile_javelin_missile");
  precacheshader("apache_targeting_circle");
  precacheshader("apache_missile_back");
  precacheshader("apache_missile_back_selected");
  precacheshader("apache_homing_missile_back");
  precacheshader("apache_homing_missile_back_selected");
  precacheshader("apache_ammo");
  precacheshader("apache_ammo_lock");
  precacheshader("apache_target_lock");
  precacheshader("apache_target_lock_01");
  precacheshader("apache_target_lock_02");
  precacheshader("apache_target_lock_03");
  precacherumble("smg_fire");
  _fx();
}

_fx() {
  common_scripts\utility::add_fx("FX_apache_missile_flash_view", "vfx/moments/oil_rocks/vfx_apache_player_rocket_flash");
}

_init(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.owner = var_0;
  var_3.type = "hydra_lockOn_missile";
  var_3.apache = var_1;
  var_3.masterhud = var_2;
  var_3.ammo = [];
  var_3.ammo["missile"] = 2;
  var_3.ammo["missile_straight"] = 4;
  var_3.targets = [];
  var_3.isactive = undefined;
  var_3.side_last = "left";
  var_3 hud_init();
  return var_3;
}

hud_init() {
  var_0 = self.owner;
  var_1 = self.masterhud;
  var_2 = [];
  var_2["missile_range"] = var_0 maps\_hud_util::createclienticon("apache_targeting_circle", 256, 256);
  var_2["missile_range"] maps\_hud_util::setpoint("CENTER", undefined, 0, 0);
  var_2["missile_range"].alpha = 0.0;
  var_3 = common_scripts\utility::ter_op(getdvarint("widescreen") == 1, 180, 90);
  var_2["missile_bg"] = var_0 maps\_hud_util::createclienticon("apache_missile_back", 64, 32);
  var_2["missile_bg"] maps\_hud_util::setpoint("CENTER", "CENTER", var_3, 76);
  var_2["missile_bg"].alpha = 0.05;
  var_2["missile_straight_bg"] = var_0 maps\_hud_util::createclienticon("apache_missile_back", 64, 32);
  var_2["missile_straight_bg"] maps\_hud_util::setpoint("CENTER", "CENTER", var_3, 41);
  var_2["missile_straight_bg"].alpha = 1.0;
  var_2["missile"] = [];

  for(var_4 = 0; var_4 < 2; var_4++) {
    var_5 = var_0 maps\_hud_util::createclienticon("apache_ammo", 16, 16);
    var_5 maps\_hud_util::setpoint("RIGHT", "CENTER", -5, -4 + var_4 * 8);
    var_5.alpha = 0.0;
    var_5.isavailable = 1;
    var_5.islockedontarget = 0;
    var_5 maps\_hud_util::setparent(var_2["missile_bg"]);
    var_2["missile"][var_4] = var_5;
  }

  for(var_4 = 0; var_4 < 4; var_4++) {
    var_6 = var_4 % 2;
    var_7 = common_scripts\utility::ter_op(var_4 < 2, -5, -11);
    var_5 = var_0 maps\_hud_util::createclienticon("apache_ammo", 8, 16);
    var_5 maps\_hud_util::setpoint("RIGHT", "CENTER", var_7, -4 + var_6 * 8);
    var_5.alpha = 0.0;
    var_5.isavailable = 1;
    var_5.islockedontarget = 0;
    var_5 maps\_hud_util::setparent(var_2["missile_straight_bg"]);
    var_2["missile_straight"][var_4] = var_5;
  }

  self.hud = var_2;
}

_start() {
  var_0 = self.owner;
  var_0 endon("LISTEN_end_hydra_lockOn_missile");
  level endon("missionfailed");
  hud_start();
  var_0 notifyonplayercommand("LISTEN_hydra_lockOn_missile_fire_press", "+frag");
  var_0 notifyonplayercommand("LISTEN_hydra_lockOn_missile_fire_release", "-frag");
  self.targets = [];
  childthread monitorreload();
  childthread monitorreload("missile_straight");
  childthread monitor_reload_empty();

  for(;;) {
    if(!isDefined(self.isactive)) {
      wait 0.05;
      continue;
    }

    if(!missile_check_ammo()) {
      wait 0.05;
      continue;
    }

    var_0 waittill("LISTEN_hydra_lockOn_missile_fire_press");
    childthread lockontargets();
    var_0 waittill("LISTEN_hydra_lockOn_missile_fire_release");
    _fire();
    lockontargets_stop();
  }
}

monitor_reload_empty() {
  var_0 = self.owner;

  for(;;) {
    var_0 waittill("LISTEN_hydra_lockOn_missile_fire_release");

    if(!missile_check_ammo()) {
      var_0 maps\_utility::play_sound_on_entity("apache_player_empty_click");
    }
  }
}

missile_check_ammo() {
  self.has_straight_missiles = has_ammo_for_missile("missile_straight");
  self.has_homing_missiles = has_ammo_for_missile("missile");

  if(!self.has_straight_missiles) {
    hud_highlight_no_missiles();
  } else {
    hud_highlight_straight_missile();
  }

  if(!self.has_straight_missiles && !self.has_homing_missiles) {
    return 0;
  }

  return 1;
}

has_ammo_for_missile(var_0) {
  return isDefined(self.ammo[var_0]) && self.ammo[var_0];
}

_fire() {
  var_0 = self.owner;
  self.targets = common_scripts\utility::array_removeundefined(self.targets);

  if(self.targets.size) {
    fire_lockon();
    hud_highlight_straight_missile();
  } else if(self.ammo["missile_straight"])
    fire_hydra(0);
}

get_side_next_missile() {
  if(!isDefined(self.side_last)) {
    self.side_last = "left";
  }

  self.side_last = common_scripts\utility::ter_op(self.side_last == "left", "right", "left");
  return self.side_last;
}

activate() {
  var_0 = self.hud;
  self.isactive = 1;

  foreach(var_2 in var_0["missile"]) {
    if(var_2.isavailable) {
      var_2.alpha = 1.0;
      continue;
    }

    var_2.alpha = 0;
  }

  foreach(var_2 in var_0["missile_straight"]) {
    if(var_2.isavailable) {
      var_2.alpha = 1.0;
      continue;
    }

    var_2.alpha = 0;
  }
}

deactivate() {
  var_0 = self.hud;
  self.isactive = undefined;

  foreach(var_2 in var_0["missile"]) {
    if(var_2.isavailable) {
      var_2.alpha = 0.2;
      continue;
    }

    var_2.alpha = 0;
  }

  foreach(var_2 in var_0["missile_straight"]) {
    if(var_2.isavailable) {
      var_2.alpha = 0.2;
      continue;
    }

    var_2.alpha = 0;
  }
}

monitorreload(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "missile";
  }

  var_1 = self.owner;

  for(;;) {
    var_2 = 0;

    foreach(var_4 in self.hud[var_0]) {
      if(!var_4.isavailable) {
        var_2 = 1;
        break;
      }
    }

    if(!var_2) {
      wait 0.05;
      continue;
    }

    wait 0.5;
    var_1 thread maps\_utility::play_sound_on_entity("apache_missile_reload");
    wait 1.5;

    for(var_6 = self.hud[var_0].size - 1; var_6 >= 0; var_6--) {
      var_4 = self.hud[var_0][var_6];

      if(!var_4.isavailable) {
        hud_markavailable_firstusedmissileicon(var_0);
        self.ammo[var_0]++;
        hud_highlight_straight_missile();
        break;
      }
    }
  }
}

hud_start() {
  var_0 = self.hud;

  foreach(var_2 in var_0["missile"]) {
    if(var_2.islockedontarget) {
      var_2 setshader("apache_ammo_lock", 16, 16);
    } else {
      var_2 setshader("apache_ammo", 16, 16);
    }

    if(var_2.isavailable) {
      var_2.alpha = common_scripts\utility::ter_op(isDefined(self.isactive), 1.0, 0.2);
      continue;
    }

    var_2.alpha = 0;
  }
}

lockontargets() {
  var_0 = self.owner;
  var_0 endon("LISTEN_hydra_lockOn_missile_fire_release");
  var_0 endon("LISTEN_pilot_weaponSwitch");
  self.targets = [];
  self.targets_tracking = [];
  wait 0.2;
  self.hud["missile_range"].alpha = 1.0;
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("apache_lockon_missile_locking");

  for(;;) {
    waittillframeend;
    var_1 = self.targets_tracking;

    foreach(var_3 in var_1) {
      if(isDefined(var_3) && !target_istarget(var_3)) {
        removetrackingtarget(var_3);
      }
    }

    var_5 = self.targets;

    foreach(var_3 in var_5) {
      if(isDefined(var_3) && !target_istarget(var_3)) {
        removelockedontarget(var_3);
      }
    }

    var_8 = target_getarray();

    foreach(var_3 in var_8) {
      if(!isDefined(var_3) || !isDefined(var_3.unique_id)) {
        continue;
      }
      if(isDefined(var_3.missiles_chasing) && var_3.missiles_chasing > 0) {
        continue;
      }
      var_10 = var_3 target_islockedon(var_0);
      var_11 = istrackingtarget(var_3);

      if(var_10 || var_11) {
        var_12 = undefined;

        if(var_0 maps\_utility::ent_flag("FLAG_apache_pilot_ADS")) {
          var_12 = vehicle_scripts\_apache_player_pilot::fov_get_ads();
        } else {
          var_12 = vehicle_scripts\_apache_player_pilot::fov_get_default();
        }

        if(!target_isincircle(var_3, var_0, var_12, 80) || !target_trace_to_owners_eyes(var_3, var_0) || !target_in_range_for_lock(var_3, var_0)) {
          if(var_10) {
            removelockedontarget(var_3);
          }

          if(var_11) {
            removetrackingtarget(var_3);
          }
        }
      }
    }

    if(hasammoforlockontarget()) {
      if(gettrackingtargetcount() > 0) {
        var_14 = undefined;

        foreach(var_3 in self.targets_tracking) {
          if(!isalive(var_3)) {
            continue;
          }
          var_14 = var_3;
          break;
        }

        if(isDefined(var_14) && gettime() - var_14.tracking_time_start >= 150.0) {
          removetrackingtarget(var_14, 0);
          addlockedontarget(var_14);
        }
      } else {
        var_17 = var_8;
        var_17 = common_scripts\utility::array_remove_array(var_17, self.targets);

        foreach(var_3 in var_8) {
          if(isDefined(var_3.missiles_chasing) && var_3.missiles_chasing > 0) {
            continue;
          }
          var_17[var_17.size] = var_3;
        }

        var_17 = targetsfilter(var_0, var_17);
        var_17 = targetssortbydot(var_17, var_0 getEye(), var_0 getplayerangles());

        if(isDefined(var_17[0])) {
          addtrackingtarget(var_17[0], 0.15);
        }
      }
    }

    if(self.targets.size) {
      hud_highlight_homing_missile();
    } else {
      hud_highlight_straight_missile();
    }

    wait 0.05;
  }
}

target_trace_to_owners_eyes(var_0, var_1) {
  if(!isDefined(var_0.target_trace_to_owners_eyes)) {
    var_0.target_trace_to_owners_eyes = gettime();
  }

  if(gettime() - var_0.target_trace_to_owners_eyes < 750) {
    return 1;
  }

  var_2 = var_1 getEye();
  var_3 = var_0 getcentroid();
  var_4 = vectornormalize(var_3 - var_2);
  var_4 = var_4 * 500;
  var_4 = var_4 + var_2;
  var_5 = bulletTrace(var_4, var_3, 0, var_1.riding_vehicle);
  var_6 = var_5["fraction"] == 1 || isDefined(var_5["entity"]) && var_5["entity"] == var_0;

  if(var_6) {
    var_0.target_trace_to_owners_eyes = gettime();
  }

  return var_6;
}

target_in_range_for_lock(var_0, var_1) {
  return distancesquared(var_1 getEye(), var_0 getcentroid()) < level.apache_player_difficulty.in_range_for_homing_missile_sqrd;
}

lockontargets_stop() {
  var_0 = self.owner;
  var_0 common_scripts\utility::stop_loop_sound_on_entity("apache_lockon_missile_locking");
  self.hud["missile_range"].alpha = 0;

  foreach(var_2 in self.targets) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(var_2 target_islockedon(var_0) && (!isDefined(var_2.missiles_chasing) || var_2.missiles_chasing <= 0)) {
      removelockedontarget(var_2);
    }
  }

  foreach(var_2 in self.targets_tracking) {
    if(!isDefined(var_2)) {
      continue;
    }
    removetrackingtarget(var_2);
  }

  self.targets = [];
  self.targets_tracking = [];
}

targetsfilter(var_0, var_1) {
  var_2 = [];
  var_3 = undefined;

  if(var_0 maps\_utility::ent_flag("FLAG_apache_pilot_ADS")) {
    var_3 = vehicle_scripts\_apache_player_pilot::fov_get_ads();
  } else {
    var_3 = vehicle_scripts\_apache_player_pilot::fov_get_default();
  }

  foreach(var_5 in var_1) {
    if(var_5 maps\_vehicle::isvehicle() && !onsameteam(var_0, var_5) && !var_5 target_islockedon(var_0) && target_isincircle(var_5, var_0, var_3, 48) && var_0 sillyboxtrace(var_0 getEye(), var_5)) {
      var_2[var_2.size] = var_5;
    }
  }

  return var_2;
}

sillyboxtrace(var_0, var_1) {
  var_2 = self getEye();

  if(sighttracepassed(var_2, var_1 getpointinbounds(0, 0, 1), 0, self.riding_heli)) {
    return 1;
  }

  if(sighttracepassed(var_2, var_1 getpointinbounds(0, 0, -1), 0, self.riding_heli)) {
    return 1;
  }

  if(sighttracepassed(var_2, var_1 getpointinbounds(0, 1, 0), 0, self.riding_heli)) {
    return 1;
  }

  if(sighttracepassed(var_2, var_1 getpointinbounds(0, -1, 0), 0, self.riding_heli)) {
    return 1;
  }

  if(sighttracepassed(var_2, var_1 getpointinbounds(1, 0, 0), 0, self.riding_heli)) {
    return 1;
  }

  if(sighttracepassed(var_2, var_1 getpointinbounds(-1, 0, 0), 0, self.riding_heli)) {
    return 1;
  }

  return 0;
}

onsameteam(var_0, var_1) {
  return var_0 getteam() == var_1 getteam();
}

getteam() {
  if(isturret(self) && isDefined(self.script_team)) {
    return self.script_team;
  }

  if(maps\_vehicle::isvehicle() && isDefined(self.script_team)) {
    return self.script_team;
  }

  if(isDefined(self.team)) {
    return self.team;
  }

  return "none";
}

isturret(var_0) {
  return isDefined(var_0) && isDefined(var_0.classname) && issubstr(var_0.classname, "turret");
}

onteam(var_0) {
  if(maps\_vehicle::isvehicle()) {
    return isDefined(self.script_team) && self.script_team == var_0;
  } else {
    return isDefined(self.team) && self.team == var_0;
  }

  return 0;
}

hud_flashalpha(var_0, var_1, var_2) {
  self.alpha = var_0;

  for(;;) {
    self fadeovertime(var_1);
    self.alpha = 0;
    wait(var_1);

    if(isDefined(var_2) && var_2 > 0) {
      wait(var_2);
    }

    self fadeovertime(var_1);
    self.alpha = var_0;
    wait(var_1);
  }
}

target_islockedon(var_0) {
  if(isDefined(self._target)) {
    return isDefined(self._target.weapon["lockOn_missile"].islockedon[var_0 getentitynumber()]);
  } else {
    return 0;
  }
}

islockedontarget(var_0) {
  return common_scripts\utility::array_contains(self.targets, var_0);
}

istrackingtarget(var_0) {
  return isDefined(self.targets_tracking) && isDefined(self.targets_tracking[var_0.unique_id]);
}

gettrackingtargetcount() {
  return common_scripts\utility::ter_op(isDefined(self.targets_tracking) && self.targets_tracking.size, self.targets_tracking.size, 0);
}

hasammoforlockontarget() {
  return min(2, self.ammo["missile"]) - self.targets.size > 0;
}

addlockedontarget(var_0) {
  var_1 = self.owner;
  self.targets = common_scripts\utility::array_add(self.targets, var_0);

  if(!isdummytarget(var_0)) {
    var_0 target_set_islockedon(var_1);

    if(target_istarget(var_0)) {
      vehicle_scripts\_apache_player::hud_set_target_locked(var_0);
    }
  }

  if(!isDefined(var_0.lock_dummy)) {
    if(!lock_dummy_add(var_0)) {
      return;
    }
  }

  thread addlockedontarget_update(var_0);
  hud_marklocked_firstavailablemissileicon("missile");

  if(!isdummytarget(var_0)) {
    var_1 thread maps\_utility::play_sound_on_entity("apache_lockon_missile_locked");
  }

  if(var_0 maps\_vehicle::isvehicle()) {
    var_0.request_move = 1;
    var_0 notify("request_move_update");
  }
}

addlockedontarget_update(var_0) {
  self.owner endon("LISTEN_end_hydra_lockOn_missile");
  var_0 endon("death");
  var_0 endon("lock_dummy_remove");
  target_setshader(var_0.lock_dummy, "apache_target_lock");
  target_drawsquare(var_0.lock_dummy, 200);
  target_setminsize(var_0.lock_dummy, 48, 0);
  target_setmaxsize(var_0.lock_dummy, 96);
  target_showtoplayer(var_0.lock_dummy, self.owner);

  for(;;) {
    target_showtoplayer(var_0.lock_dummy, self.owner);
    wait 0.1;
    target_hidefromplayer(var_0.lock_dummy, self.owner);
    wait 0.05;
  }
}

target_set_islockedon(var_0) {
  if(isDefined(self._target)) {
    self._target.weapon["lockOn_missile"].islockedon[var_0 getentitynumber()] = 1;
  }
}

isdummytarget(var_0) {
  return isDefined(var_0.isdummytarget);
}

removelockedontarget(var_0) {
  if(islockedontarget(var_0)) {
    self.targets = common_scripts\utility::array_remove(self.targets, var_0);
  }

  var_1 = self.owner;
  var_0 target_unset_islockedon(var_1);

  if(target_istarget(var_0)) {
    vehicle_scripts\_apache_player::hud_set_target_default(var_0);
  }

  lock_dummy_remove(var_0);
  hud_markunlocked_firstlockedmissileicon(0, "missile");
}

target_unset_islockedon(var_0) {
  if(isDefined(self._target)) {
    self._target.weapon["lockOn_missile"].islockedon[var_0 getentitynumber()] = undefined;
  }
}

hud_markunlocked_firstlockedmissileicon(var_0, var_1) {
  var_2 = 0;

  for(var_3 = self.hud[var_1].size - 1; var_3 >= 0; var_3--) {
    var_4 = self.hud[var_1][var_3];

    if(var_4.islockedontarget) {
      var_4 setshader("apache_ammo", 16, 16);
      var_4.islockedontarget = 0;

      if(isDefined(var_0) && var_0) {
        var_4.isavailable = 0;
        var_4.alpha = 0;
      }

      var_2 = 1;
      break;
    }
  }

  return var_2;
}

hud_marklocked_firstavailablemissileicon(var_0) {
  var_1 = 0;

  for(var_2 = self.hud[var_0].size - 1; var_2 >= 0; var_2--) {
    var_3 = self.hud[var_0][var_2];

    if(var_3.isavailable && !var_3.islockedontarget) {
      var_3 setshader("apache_ammo_lock", 16, 16);
      var_3.islockedontarget = 1;
      var_1 = 1;
      break;
    }
  }

  if(var_1) {
    hud_highlight_homing_missile();
  } else {
    hud_highlight_straight_missile();
  }

  return var_1;
}

hud_highlight_homing_missile() {
  self.hud["missile_straight_bg"] setshader("apache_missile_back", 64, 32);
  self.hud["missile_bg"] setshader("apache_homing_missile_back_selected", 64, 32);
}

hud_highlight_straight_missile() {
  if(!has_ammo_for_missile("missile_straight")) {
    return;
  }
  self.hud["missile_straight_bg"] setshader("apache_missile_back_selected", 64, 32);
  self.hud["missile_bg"] setshader("apache_homing_missile_back", 64, 32);
}

hud_highlight_no_missiles() {
  self.hud["missile_straight_bg"] setshader("apache_missile_back", 64, 32);
  self.hud["missile_bg"] setshader("apache_homing_missile_back", 64, 32);
}

hud_markused_firstavailablemissileicon(var_0) {
  for(var_1 = self.hud[var_0].size - 1; var_1 >= 0; var_1--) {
    var_2 = self.hud[var_0][var_1];

    if(var_2.isavailable) {
      var_2.isavailable = 0;
      var_2.alpha = 0;
      break;
    }
  }
}

hud_markavailable_firstusedmissileicon(var_0) {
  for(var_1 = self.hud[var_0].size - 1; var_1 >= 0; var_1--) {
    var_2 = self.hud[var_0][var_1];

    if(!var_2.isavailable) {
      var_3 = common_scripts\utility::ter_op(var_0 == "missile", 16, 8);
      var_2 setshader("apache_ammo", var_3, 16);
      var_2.alpha = common_scripts\utility::ter_op(isDefined(self.isactive), 1.0, 0.2);
      var_2.isavailable = 1;
      var_2.islockedontarget = 0;
      break;
    }
  }
}

addtrackingtarget(var_0, var_1) {
  var_0.tracking_time_start = gettime();
  self.targets_tracking[var_0.unique_id] = var_0;

  if(lock_dummy_add(var_0)) {
    thread addtrackingtarget_update(var_0, var_1);
    thread addtrackingtarget_ondeath(var_0);
  }
}

addtrackingtarget_update(var_0, var_1) {
  self.owner endon("LISTEN_end_hydra_lockOn_missile");
  var_0 endon("removeTrackingTarget");
  var_0 endon("death");
  wait 0.05;
  target_showtoplayer(var_0.lock_dummy, self.owner);
  var_2 = ["apache_target_lock_01", "apache_target_lock_02", "apache_target_lock_03"];
  var_3 = [128, 96, 64];
  var_4 = [192, 160, 128];

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    target_setshader(var_0.lock_dummy, var_2[var_5]);
    target_drawsquare(var_0.lock_dummy, 200);
    target_setminsize(var_0.lock_dummy, var_3[var_5], 0);
    target_setmaxsize(var_0.lock_dummy, var_4[var_5]);
    wait(var_1 / 3.0);
  }
}

addtrackingtarget_ondeath(var_0) {
  var_0 endon("removeTrackingTarget");
  self waittill("death");
  removetrackingtarget(var_0);
}

lock_dummy_add_ondeath(var_0) {
  var_0 endon("lock_dummy_remove");
  var_0 waittill("death");
  lock_dummy_remove(var_0);
}

lock_dummy_add(var_0) {
  var_1 = (0, 0, 64);

  if(var_0 maps\_vehicle::ishelicopter()) {
    var_1 = (0, 0, -72);
  }

  var_0.lock_dummy = var_0 common_scripts\utility::spawn_tag_origin();
  var_0.lock_dummy setModel("fx");
  var_0.lock_dummy linkto(var_0, "tag_origin", (0, 0, 0), var_0.angles);

  if(!vehicle_scripts\_apache_player_targeting::target_alloc_limit_fail_passed(var_0.lock_dummy, var_1)) {
    var_0.lock_dummy delete();
    var_0.lock_dummy = undefined;
    return 0;
  }

  target_setshader(var_0.lock_dummy, "apache_target_lock");
  target_setscaledrendermode(var_0.lock_dummy, 0);
  target_drawsingle(var_0.lock_dummy);
  target_flush(var_0.lock_dummy);
  target_showtoplayer(var_0.lock_dummy, self.owner);
  thread lock_dummy_add_ondeath(var_0);
  return 1;
}

lock_dummy_remove(var_0) {
  if(isDefined(var_0.lock_dummy)) {
    target_remove(var_0.lock_dummy);
    var_0.lock_dummy delete();
    var_0 notify("lock_dummy_remove");
  }
}

removetrackingtarget(var_0, var_1) {
  var_1 = common_scripts\utility::ter_op(isDefined(var_1), var_1, 1);

  if(istrackingtarget(var_0)) {
    var_0.tracking_time_start = undefined;
    self.targets_tracking[var_0.unique_id] = undefined;
    remove_targets_tracking_undefined();

    if(var_1) {
      lock_dummy_remove(var_0);
    }

    var_0 notify("removeTrackingTarget");
  }
}

remove_targets_tracking_undefined() {
  var_0 = [];

  foreach(var_3, var_2 in self.targets_tracking) {
    if(isDefined(var_2)) {
      var_0[var_3] = var_2;
    }
  }

  self.targets_tracking = var_0;
}

fire_lockon() {
  var_0 = self.owner;
  var_1 = self.apache;
  var_2 = 0;
  var_3 = int(min(min(2, self.ammo["missile"]), self.targets.size));
  var_4 = common_scripts\utility::getfx("FX_apache_missile_flash_view");

  while(var_3 > 0) {
    var_5 = self.targets[var_2];
    var_6 = var_0 getplayerangles();
    var_7 = get_side_next_missile();
    var_8 = common_scripts\utility::ter_op(var_7 == "right", 1, -1);
    var_9 = common_scripts\utility::ter_op(var_7 == "right", "tag_homing_rocket_right", "tag_homing_rocket_left");
    var_10 = common_scripts\utility::ter_op(var_7 == "right", "apache_hydra_missile_ignition_plr_right", "apache_hydra_missile_ignition_plr_left");
    var_11 = var_1 gettagorigin(var_9);
    var_12 = anglesToForward(var_6);
    var_13 = magicbullet("apache_lockon_missile", var_11 + 60 * var_12, var_11 + 120 * var_12, var_0);
    var_13.owner = var_0;
    var_13.type_missile = "guided";
    var_5 notify("LISTEN_missile_fire", var_13);
    level notify("LISTEN_apache_player_missile_fire", var_13);
    playFX(var_4, var_11 + var_12 * 120, var_12);
    var_14 = undefined;

    if(isDefined(var_5.missile_targetoffset)) {
      var_14 = var_5.missile_targetoffset;
    }

    var_13 maps\_utility::delaythread(0.1, ::passive_missile_settargetandflightmode, var_5, "direct", var_14);
    thread common_scripts\utility::play_sound_in_space(var_10, var_11);
    var_0 playrumbleonentity("heavygun_fire");
    earthquake(0.3, 0.6, var_0.origin, 5000);
    var_13 thread vehicle_scripts\_chopper_missile_defense_utility::missile_monitormisstarget(var_5, 0, undefined, "LISTEN_missile_missed_target", "LISTEN_missile_attached_to_flare");
    var_5 thread target_monitorfreelockedon(var_0, var_13);

    if(!hud_markunlocked_firstlockedmissileicon(1, "missile")) {
      hud_markused_firstavailablemissileicon("missile");
    }

    var_0.last_lockon_fire_time = gettime();
    self.ammo["missile"]--;
    var_3--;
    var_2++;

    if(var_2 >= self.targets.size) {
      var_2 = 0;
    }

    if(var_3 > 0) {
      wait 0.15;
    }
  }
}

passive_missile_settargetandflightmode(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  common_scripts\utility::missile_settargetandflightmode(var_0, var_1, var_2);
}

target_monitorfreelockedon(var_0, var_1) {
  self endon("death");

  if(!isDefined(self.missiles_chasing)) {
    self.missiles_chasing = 0;
  }

  self.missiles_chasing++;
  var_2 = var_0 getentitynumber();
  var_1 common_scripts\utility::waittill_any("death", "LISTEN_missile_attached_to_flare", "LISTEN_missile_missed_target");

  if(!isDefined(self)) {
    return;
  }
  self.missiles_chasing--;

  if(self.missiles_chasing <= 0) {
    if(isdummytarget(self)) {
      self delete();
      return;
    }

    if(isDefined(var_0)) {
      target_unset_islockedon(var_0);
    }

    if(isDefined(self.lock_dummy)) {
      lock_dummy_remove(self);

      if(target_istarget(self)) {
        vehicle_scripts\_apache_player::hud_set_target_default(self);
      }
    }
  }
}

ownerisinheli() {
  return isDefined(self.owner.heli);
}

firemissile(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawn("script_model", var_5);
  var_7.angles = vectortoangles(var_6 - var_5);
  var_7 setModel(var_0);
  playFXOnTag(common_scripts\utility::getfx(var_1), var_7, "tag_fx");
  var_7.life_time = var_4;
  var_7.speed = var_2;
  var_7.trace_length = var_3;
  var_7 thread missile_move_firemissile();
  return var_7;
}

missile_move_firemissile() {
  self endon("death");

  for(;;) {
    var_0 = anglesToForward(self.angles);
    var_1 = self.origin;

    if(!isDefined(self.homing)) {
      self moveto(var_1 + 0.1 * self.speed * var_0, 0.1);
    }

    var_2 = bullettracepassed(var_1, var_1 + self.trace_length * var_0, 1, self);

    if(self.life_time <= 0) {
      self delete();
      return;
    }

    if(!var_2) {
      var_3 = level;

      if(isDefined(self.owner)) {
        var_3 = self.owner;
      }

      radiusdamage(self.origin, 512, 4000, 1000, var_3, "MOD_EXPLOSIVE");
      self delete();
      return;
    }

    wait 0.05;
    self.life_time = self.life_time - 0.05;
  }
}

fire_hydra(var_0) {
  var_1 = self.owner;
  var_2 = self.apache;
  var_3 = self.hud;
  var_4 = 1;
  var_5 = common_scripts\utility::getfx("FX_apache_missile_flash_view");
  var_6 = var_1 getEye();
  var_7 = anglesToForward(var_1 getplayerangles());
  var_8 = bulletTrace(var_6 + var_7 * 360, var_6 + var_7 * 15000, 0, var_2);
  var_9 = max(1000, var_8["fraction"] * 15000);
  earthquake(0.15, var_4 * 0.1 + 0.5, var_1.origin, 5000);

  for(var_10 = 0; var_10 < var_4; var_10++) {
    var_11 = get_side_next_missile();
    var_12 = common_scripts\utility::ter_op(var_11 == "right", 1, -1);
    var_13 = common_scripts\utility::ter_op(var_11 == "right", "tag_straight_rocket_right", "tag_straight_rocket_left");
    var_14 = common_scripts\utility::ter_op(var_11 == "right", "apache_hydra_missile_ignition_plr_right", "apache_hydra_missile_ignition_plr_left");
    var_15 = var_1 getEye();
    var_16 = flat_angle_yaw(var_2.angles);
    var_17 = anglesToForward(var_16);
    var_18 = anglestoright(var_16);
    var_19 = anglestoup(var_16);
    var_20 = 0.0;

    if(1) {
      var_20 = randomfloatrange(-14, 14);
    }

    var_21 = 0.0;

    if(1) {
      var_21 = randomfloatrange(-14, 14);
    }

    var_22 = var_2 gettagorigin(var_13);
    var_23 = var_1 getplayerangles();
    var_24 = 0.0;

    if(0) {
      var_24 = randomfloatrange(-0.0, 0.0);
    }

    var_25 = 0.0;

    if(0) {
      var_25 = randomfloatrange(-0.0, 0.0);
    }

    var_23 = var_23 + (var_24, var_25, 0);
    var_26 = anglesToForward(var_23);
    var_27 = var_15 + var_12 * 48 * var_18 + var_9 * var_26;
    playFX(var_5, var_22 + var_26 * 120, var_26);
    thread common_scripts\utility::play_sound_in_space(var_14, var_22);
    var_28 = magicbullet("apache_hydra_missile", var_22 + var_26 * 60, var_27, var_1);
    var_28.type_missile = "straight";
    level notify("LISTEN_apache_player_missile_fire", var_28);
    var_1 playrumbleonentity("smg_fire");

    if(!var_0) {
      hud_markused_firstavailablemissileicon("missile_straight");
      self.ammo["missile_straight"]--;
    }

    if(var_10 + 1 < var_4) {
      wait 0.1;
    }
  }

  if(var_0) {
    hud_markused_firstavailablemissileicon("missile_straight");
    self.ammo["missile_straight"]--;
  }
}

_end() {
  var_0 = self.owner;
  var_0 notify("LISTEN_end_hydra_lockOn_missile");
  maps\_utility::deep_array_thread(self.hud, ::set_key, [0, "alpha"]);
  var_0 common_scripts\utility::stop_loop_sound_on_entity("apache_lockon_missile_locking");
}

_destroy() {
  _end();
  maps\_utility::deep_array_call(self.hud, ::destroy);
}

targetssortbydot(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_2);
  var_4 = [];
  var_5 = [];

  foreach(var_7 in var_0) {
    var_5[var_5.size] = vectordot(var_3, vectornormalize(var_7.origin - var_1));
  }

  return doublereversebubblesort(var_5, var_0);
}

doublereversebubblesort(var_0, var_1) {
  var_2 = var_0.size;

  for(var_3 = var_2 - 1; var_3 > 0; var_3--) {
    for(var_4 = 1; var_4 <= var_3; var_4++) {
      if(var_0[var_4 - 1] < var_0[var_4]) {
        var_5 = var_0[var_4];
        var_0[var_4] = var_0[var_4 - 1];
        var_0[var_4 - 1] = var_5;
        var_5 = var_1[var_4];
        var_1[var_4] = var_1[var_4 - 1];
        var_1[var_4 - 1] = var_5;
      }
    }
  }

  return var_1;
}

dsq_ents_lt(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2)) {
    return common_scripts\utility::ter_op(distancesquared(var_0.origin, var_1.origin) < squared(var_2), 1, 0);
  }

  return common_scripts\utility::ter_op(isDefined(var_3), var_3, 0);
}

are_opposite_sign(var_0, var_1) {
  if(var_0 < 0 && var_1 > 0 || var_0 > 0 && var_1 < 0 || var_0 == 0 && var_1 != 0 || var_0 != 0 && var_1 == 0) {
    return 1;
  }

  return 0;
}

get_sign(var_0) {
  if(var_0 == 0) {
    return 0;
  }

  if(var_0 < 0) {
    return -1;
  }

  if(var_0 > 0) {
    return 1;
  }
}

get_angle_delta(var_0, var_1) {
  var_2 = common_scripts\utility::ter_op(var_1 - var_0 > 0, 1, -1);
  var_3 = var_1 - var_0;
  return common_scripts\utility::ter_op(abs(var_3) > 180, -1 * var_2 * (360 - abs(var_3)), var_2 * abs(var_3));
}

set_key(var_0, var_1) {
  if(!isDefined(self) || !isDefined(var_1)) {
    return;
  }
  switch (var_1) {
    case "alpha":
      self.alpha = var_0;
      break;
  }
}

gt_op(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1)) {
    return common_scripts\utility::ter_op(var_0 > var_1, var_0, var_1);
  }

  if(isDefined(var_0) && !isDefined(var_1)) {
    return var_0;
  }

  if(!isDefined(var_0) && isDefined(var_1)) {
    return var_1;
  }

  return var_2;
}

flat_angle_yaw(var_0) {
  return (0, var_0[1], 0);
}