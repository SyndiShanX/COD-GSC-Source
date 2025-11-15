/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\player\player_monitor.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\gamestate;
#include scripts\core_common\match_record;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\util_shared;
#include scripts\mp_common\bb;
#include scripts\mp_common\gametypes\globallogic_utils;

#namespace player_monitor;

monitor() {
  if(sessionmodeismultiplayergame()) {
    if(!isbot(self) && getdvarint(#"hash_18b3343408da85f5", 0) == 1) {
      self thread breadcrumbs();
    }
  } else if(sessionmodeiswarzonegame()) {
    if(!isbot(self) && getdvarint(#"hash_6d5a49354d02940d", 0) == 1) {
      self thread breadcrumbs();
    }
  }

  if(sessionmodeiswarzonegame()) {
    self thread function_fa444840();
    self thread travel_dist();
    return;
  }

  self thread travel_dist();
  self thread wall_run();
  self thread swimming();
  self thread slide();
  self thread doublejump();
  self thread inactivity();
}

function_d35f877a(player, weapon, statname, value = 0) {
  if(isDefined(player.var_3dc66299)) {
    if(statname == #"shots") {
      player.var_3dc66299.shots += value;
      return;
    }

    if(statname == #"hits") {
      player.var_3dc66299.hits += value;
      return;
    }

    if(statname == #"kills") {
      player.var_3dc66299.kills += value;
      return;
    }

    if(statname == #"deathsduringuse") {
      player.var_3dc66299.deathsduringuse += value;
      return;
    }

    if(statname == #"headshots") {
      player.var_3dc66299.headshots += value;
    }
  }
}

function_36185795(params) {
  if(isalive(self)) {
    waittillframeend();
    self function_43e771ee(#"game_ended");
  }
}

private function_43e771ee(reason) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"disconnect");

  if(isDefined(self.var_3dc66299.currentweapon)) {
    timeused = function_f8d53445() - self.var_3dc66299.starttime;

    if(self.var_3dc66299.shots > 0 || timeused >= 2000) {
      longesthitdist = 0;
      currentlifeindex = self match_record::get_player_stat(#"hash_ec4aea1a8bbd82");

      if(isDefined(currentlifeindex)) {
        longesthitdist = self match_record::get_stat(#"lives", currentlifeindex, "longest_hit_distance");
        self match_record::set_stat(#"lives", currentlifeindex, "longest_hit_distance", 0);
      }

      died = 0;

      if(reason == #"death" || self.var_3dc66299.deathsduringuse > 0) {
        died = 1;
      }

      var_27047881 = int(timeused / 1000);
      attachments = bb::function_285f8efd(self.var_3dc66299.currentweapon);
      reticle = hash(self getweaponoptic(self.var_3dc66299.currentweapon));
      var_178db383 = spawnStruct();
      var_178db383.shots = self.var_3dc66299.shots;
      var_178db383.hits = self.var_3dc66299.hits;
      var_178db383.kills = self.var_3dc66299.kills;
      var_178db383.headshots = self.var_3dc66299.headshots;
      var_178db383.died = died;
      var_178db383.time_used_s = var_27047881;
      var_178db383.longest_hit_distance = longesthitdist;
      var_178db383.attachment1 = attachments.attachment0;
      var_178db383.attachment2 = attachments.attachment1;
      var_178db383.attachment3 = attachments.attachment2;
      var_178db383.attachment4 = attachments.attachment3;
      var_178db383.attachment5 = attachments.attachment4;
      var_178db383.attachment6 = attachments.attachment5;
      var_178db383.attachment7 = attachments.attachment6;
      var_178db383.reticle = reticle;
      var_178db383.weapon = self.var_3dc66299.currentweapon.name;
      function_92d1707f(#"hash_618e6178a21f0b3d", var_178db383);
      self.var_3dc66299.currentweapon = undefined;
    }
  }
}

private function_fa444840() {
  self endon(#"disconnect");
  level endon(#"game_ended");
  self.var_3dc66299 = {};
  self.var_3dc66299.starttime = -1;
  self.var_3dc66299.shots = 0;
  self.var_3dc66299.hits = 0;
  self.var_3dc66299.kills = 0;
  self.var_3dc66299.deathsduringuse = 0;
  self.var_3dc66299.headshots = 0;
  self.var_3dc66299.currentweapon = undefined;
  level waittill(#"game_playing");

  while(true) {
    result = self waittill(#"weapon_change_complete", #"death");

    if(result._notify == #"death") {
      self function_43e771ee(result._notify);
      break;
    }

    self function_43e771ee(result._notify);

    if(isDefined(result.weapon)) {
      self.var_3dc66299.currentweapon = result.weapon;
      self.var_3dc66299.starttime = function_f8d53445();
      self.var_3dc66299.shots = 0;
      self.var_3dc66299.hits = 0;
      self.var_3dc66299.kills = 0;
      self.var_3dc66299.deathsduringuse = 0;
      self.var_3dc66299.headshots = 0;
    }
  }
}

private breadcrumbs() {
  self endon(#"death", #"disconnect");
  level endon(#"game_ended");
  waittime = 10;

  if(sessionmodeismultiplayergame()) {
    while(level.inprematchperiod) {
      waitframe(1);
    }

    waittime = getdvarfloat(#"hash_78606296733432c4", 2);
  } else if(sessionmodeiswarzonegame()) {
    level waittill(#"game_playing");
    waittime = getdvarfloat(#"hash_2872d2b12241500c", 4);
  }

  while(true) {
    if(isalive(self)) {
      recordbreadcrumbdataforplayer(self);
    }

    wait waittime;
  }
}

private travel_dist() {
  self endon(#"death", #"disconnect");
  waittime = 1;
  minimummovedistance = 16;
  wait 4;

  if(!isDefined(self.pers[#"movement_update_count"])) {
    self.pers[#"movement_update_count"] = 0;
  }

  prevpos = self.origin;
  positionptm = self.origin;

  while(true) {
    wait waittime;

    if(self util::isusingremote()) {
      self waittill(#"stopped_using_remote");
      prevpos = self.origin;
      positionptm = self.origin;
      continue;
    }

    distance = distance(self.origin, prevpos);
    self.pers[#"total_distance_travelled"] += distance;

    if(gamestate::is_state("playing") && distance > 0) {
      if(!self isinvehicle()) {
        groundent = self getgroundent();

        if(isDefined(groundent) && !isvehicle(groundent)) {
          self stats::function_d40764f3(#"distance_traveled_foot", int(distance));

          if(isDefined(self.outsidedeathcircle) && self.outsidedeathcircle) {
            self stats::function_d40764f3(#"hash_630fffa7f053a2b7", int(distance));
            self match_record::function_34800eec(#"hash_630fffa7f053a2b7", int(distance));
          }
        }
      }
    }

    self.pers[#"movement_update_count"]++;
    prevpos = self.origin;

    if(self.pers[#"movement_update_count"] % 5 == 0) {
      distancemoving = distance(self.origin, positionptm);
      positionptm = self.origin;

      if(distancemoving > minimummovedistance) {
        self.pers[#"num_speeds_when_moving_entries"]++;
        self.pers[#"total_speeds_when_moving"] += distancemoving / waittime;
        self.pers[#"time_played_moving"] += waittime;
      }
    }
  }
}

private wall_run() {
  self endon(#"disconnect");
  self notify(#"stop_player_monitor_wall_run");
  self endon(#"stop_player_monitor_wall_run");
  self.lastwallrunstarttime = 0;
  self.timespentwallrunninginlife = 0;

  while(true) {
    notification = self waittill(#"wallrun_begin", #"death", #"disconnect", #"stop_player_monitor_wall_run");

    if(notification._notify == "death") {
      break;
    }

    self.lastwallrunstarttime = gettime();
    notification = self waittill(#"wallrun_end", #"death", #"disconnect", #"stop_player_monitor_wall_run");
    self.timespentwallrunninginlife += gettime() - self.lastwallrunstarttime;

    if(notification._notify == "death") {
      break;
    }
  }
}

private swimming() {
  self endon(#"disconnect");
  self notify(#"stop_player_monitor_swimming");
  self endon(#"stop_player_monitor_swimming");
  self.lastswimmingstarttime = 0;
  self.timespentswimminginlife = 0;

  while(true) {
    notification = self waittill(#"swimming_begin", #"death", #"disconnect", #"stop_player_monitor_swimming");

    if(notification._notify == "death") {
      break;
    }

    self.lastswimmingstarttime = gettime();
    notification = self waittill(#"swimming_end", #"death", #"disconnect", #"stop_player_monitor_swimming");
    self.timespentswimminginlife += gettime() - self.lastswimmingstarttime;

    if(notification._notify == "death") {
      break;
    }
  }
}

private slide() {
  self endon(#"disconnect");
  self notify(#"stop_player_monitor_slide");
  self endon(#"stop_player_monitor_slide");
  self.lastslidestarttime = 0;
  self.numberofslidesinlife = 0;

  while(true) {
    notification = self waittill(#"slide_begin", #"death", #"disconnect", #"stop_player_monitor_slide");

    if(notification._notify == "death") {
      break;
    }

    self.lastslidestarttime = gettime();
    self.numberofslidesinlife++;
    notification = self waittill(#"slide_end", #"death", #"disconnect", #"stop_player_monitor_slide");

    if(notification._notify == "death") {
      break;
    }
  }
}

private doublejump() {
  self endon(#"disconnect");
  self notify(#"stop_player_monitor_doublejump");
  self endon(#"stop_player_monitor_doublejump");
  self.lastdoublejumpstarttime = 0;
  self.numberofdoublejumpsinlife = 0;

  while(true) {
    notification = self waittill(#"doublejump_begin", #"death", #"disconnect", #"stop_player_monitor_doublejump");

    if(notification._notify == "death") {
      break;
    }

    self.lastdoublejumpstarttime = gettime();
    self.numberofdoublejumpsinlife++;
    notification = self waittill(#"doublejump_end", #"death", #"disconnect", #"stop_player_monitor_doublejump");

    if(notification._notify == "death") {
      break;
    }
  }
}

private inactivity() {
  self endon(#"disconnect");
  self notify(#"player_monitor_inactivity");
  self endon(#"player_monitor_inactivity");
  wait 10;

  while(true) {
    if(isDefined(self)) {
      if(self isremotecontrolling() || self util::isusingremote() || isDefined(level.inprematchperiod) && level.inprematchperiod || isDefined(self.var_4c45f505) && self.var_4c45f505) {
        self resetinactivitytimer();
      }
    }

    wait 5;
  }
}