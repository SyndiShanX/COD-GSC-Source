/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\player\player_monitor.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\match_record;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\bb;
#using scripts\mp_common\gametypes\globallogic_utils;
#namespace player_monitor;

function private autoexec __init__system__() {
  system::register(#"player_monitor", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_player_killed(&on_player_killed);
  callback::on_end_game(&on_end_game);
}

function monitor() {
  if(sessionmodeismultiplayergame()) {
    if(!isbot(self) && getdvarint(#"hash_18b3343408da85f5", 0) == 1) {
      self thread breadcrumbs();
    }
  } else if(sessionmodeiswarzonegame()) {
    if(!isbot(self) && getdvarint(#"hash_6d5a49354d02940d", 0) == 1) {
      self thread breadcrumbs();
    }
  }

  self thread travel_dist();

  if(sessionmodeiswarzonegame()) {
    self function_654cd97();
    return;
  }

  self thread inactivity();
}

function function_d35f877a(player, weapon, statname, value = 0) {
  if(isDefined(weapon.var_3dc66299)) {
    if(statname == # "shots") {
      weapon.var_3dc66299.shots += value;
      return;
    }

    if(statname == # "hits") {
      weapon.var_3dc66299.hits += value;
      return;
    }

    if(statname == # "kills") {
      weapon.var_3dc66299.kills += value;
      return;
    }

    if(statname == # "deathsduringuse") {
      weapon.var_3dc66299.deathsduringuse += value;
      return;
    }

    if(statname == # "headshots") {
      weapon.var_3dc66299.headshots += value;
    }
  }
}

function function_36185795(params) {
  if(isalive(self)) {
    waittillframeend();
    self function_43e771ee();
  }
}

function private function_43e771ee(died = 0) {
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

      if(self.var_3dc66299.deathsduringuse > 0) {
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

function event_handler[weapon_change_complete] function_91abdff4(eventstruct) {
  if(!sessionmodeiswarzonegame()) {
    return;
  }

  if(game.state == # "playing") {
    if(isDefined(eventstruct.weapon)) {
      self function_43e771ee();

      if(!isDefined(self.var_3dc66299)) {
        self.var_3dc66299 = {};
      }

      self.var_3dc66299.currentweapon = eventstruct.weapon;
      self.var_3dc66299.starttime = function_f8d53445();
      self.var_3dc66299.shots = 0;
      self.var_3dc66299.hits = 0;
      self.var_3dc66299.kills = 0;
      self.var_3dc66299.deathsduringuse = 0;
      self.var_3dc66299.headshots = 0;
    }
  }
}

function on_player_killed(params) {
  self function_43e771ee(1);

  if(isDefined(self.lastswimmingstarttime) && self isplayerswimming()) {
    self function_9fabf258();
  }

  if(isDefined(self.lastwallrunstarttime) && self isplayerwallrunning()) {
    self function_83433c76();
  }
}

function private function_654cd97() {
  self.var_3dc66299 = {};
  self.var_3dc66299.starttime = -1;
  self.var_3dc66299.shots = 0;
  self.var_3dc66299.hits = 0;
  self.var_3dc66299.kills = 0;
  self.var_3dc66299.deathsduringuse = 0;
  self.var_3dc66299.headshots = 0;
  self.var_3dc66299.currentweapon = undefined;
}

function private breadcrumbs() {
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
      lifeindex = isDefined(self.pers[#"telemetry"].life.life_index) ? self.pers[#"telemetry"].life.life_index : -1;
      recordbreadcrumbdataforplayer(self, lifeindex);
    }

    wait waittime;
  }
}

function private travel_dist() {
  self notify("46c3d76bfbd558e8");
  self endon("46c3d76bfbd558e8");
  self.time_played_moving = self.pers[#"time_played_moving"];

  if(!isDefined(self.pers[#"movement_update_count"])) {
    self.pers[#"movement_update_count"] = 0;
  }

  prevpos = self.origin;
  positionptm = self.origin;
  var_aab0a48f = 0;
  var_601d5ffc = 0;
  var_ec704eef = 0;
  var_365f7ec5 = 0;
  var_7e8e90a4 = 0;
  var_87a9b1b1 = 0;

  while(true) {
    profilestart();

    if(!isDefined(self)) {
      profilestop();
      return;
    }

    is_alive = isalive(self);

    if(is_alive) {
      dist = distance(self.origin, prevpos);
      var_365f7ec5 += dist;

      if(dist > 0 && game.state == # "playing") {
        if(!self isinvehicle()) {
          groundent = self getgroundent();

          if(isDefined(groundent) && !isvehicle(groundent)) {
            var_7e8e90a4 += dist;

            if(is_true(self.outsidedeathcircle)) {
              var_87a9b1b1 += dist;
            }
          }
        }
      }

      var_601d5ffc++;
      prevpos = self.origin;

      if(dist >= 1.6) {
        var_aab0a48f += 1;
      }
    }

    if(var_601d5ffc % 5 == 0 || !is_alive || isDefined(self.usingremote)) {
      if(var_aab0a48f > 0) {
        distancemoved = distance(self.origin, positionptm);

        if(distancemoved > 16) {
          var_ec704eef += distancemoved;
          self.time_played_moving += var_aab0a48f;
        }
      }

      positionptm = self.origin;
      var_aab0a48f = 0;
    }

    profilestop();

    if(is_alive && isDefined(self.usingremote)) {
      self waittill(#"stopped_using_remote", #"death", #"disconnect", #"hash_44f09afc8f27cf23");

      if(isDefined(self)) {
        prevpos = self.origin;
        positionptm = self.origin;
        is_alive = isalive(self);
      }
    }

    if(isDefined(self) && (!is_alive || level.gameended === 1 || self.player_disconnected === 1)) {
      self stats::function_d40764f3(#"distance_traveled_foot", int(var_7e8e90a4));
      self stats::function_d40764f3(#"hash_630fffa7f053a2b7", int(var_87a9b1b1));
      self match_record::function_34800eec(#"hash_630fffa7f053a2b7", int(var_87a9b1b1));
      self.pers[#"total_distance_travelled"] += var_365f7ec5;
      self.pers[#"movement_update_count"] += var_601d5ffc;
      self.pers[#"hash_20464b40eeb9b465"] += var_ec704eef;
      self.pers[#"time_played_moving"] = self.time_played_moving;
      return;
    }

    self waittilltimeout(1, #"death", #"disconnect", #"hash_44f09afc8f27cf23");
  }
}

function on_end_game() {
  if(!isPlayer(self)) {
    return;
  }

  self notify(#"hash_44f09afc8f27cf23");
}

function event_handler[wallrun_begin] function_f69038ac(eventstruct) {
  self.lastwallrunstarttime = gettime();
}

function event_handler[wallrun_end] function_830b9d71(eventstruct) {
  self function_83433c76();
}

function function_83433c76() {
  if(!isDefined(self.timespentwallrunninginlife)) {
    self.timespentwallrunninginlife = 0;
  }

  self.timespentwallrunninginlife += gettime() - self.lastwallrunstarttime;
}

function event_handler[swimming_begin] function_d18b7e6e(eventstruct) {
  self.lastswimmingstarttime = gettime();
}

function event_handler[swimming_end] function_b3154405(eventstruct) {
  self function_9fabf258();
}

function function_9fabf258() {
  if(!isDefined(self.timespentswimminginlife)) {
    self.timespentswimminginlife = 0;
  }

  self.timespentswimminginlife += gettime() - self.lastswimmingstarttime;
}

function event_handler[slide_begin] function_86596790(eventstruct) {
  self.lastslidestarttime = gettime();

  if(!isDefined(self.numberofslidesinlife)) {
    self.numberofslidesinlife = 0;
  }

  self.numberofslidesinlife++;
}

function event_handler[doublejump_begin] function_2d820dd0(eventstruct) {
  self.lastdoublejumpstarttime = gettime();

  if(!isDefined(self.numberofdoublejumpsinlife)) {
    self.numberofdoublejumpsinlife = 0;
  }

  self.numberofdoublejumpsinlife++;
}

function private inactivity() {
  self endon(#"disconnect");
  self notify(#"player_monitor_inactivity");
  self endon(#"player_monitor_inactivity");
  wait 10;

  while(true) {
    if(isDefined(self)) {
      if(self isremotecontrolling() || self util::isusingremote() || is_true(level.inprematchperiod) || is_true(self.var_4c45f505)) {
        self resetinactivitytimer();
      }
    }

    wait 5;
  }
}