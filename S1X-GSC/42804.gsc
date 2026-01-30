/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42804.gsc
**************************************/

exo_repulsor_think() {
  self notify("exo_repulsor_taken");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_repulsor_taken");

  if(!self hasweapon("exorepulsor_equipment_mp")) {
    return;
  }
  exorepulsorinit();
  thread monitorplayerdeath();
  thread wait_for_game_end();

  for(;;) {
    self waittill("exo_ability_activate", var_0);

    if(var_0 == "exorepulsor_equipment_mp") {
      thread tryuserepulsor();
    }
  }
}

exorepulsorinit() {
  self.repulsoractive = 0;
  self batterysetdischargescale("exorepulsor_equipment_mp", 1.0);
  var_0 = self batterygetsize("exorepulsor_equipment_mp");
  self.projectilesstopped = 0;

  if(self gettacticalweapon() == "exorepulsor_equipment_mp") {
    self setclientomnvar("exo_ability_nrg_req0", 0);
    self setclientomnvar("exo_ability_nrg_total0", var_0);
    self setclientomnvar("ui_exo_battery_level0", var_0);
  } else if(self getlethalweapon() == "exorepulsor_equipment_mp") {
    self setclientomnvar("exo_ability_nrg_req1", 0);
    self setclientomnvar("exo_ability_nrg_total1", var_0);
    self setclientomnvar("ui_exo_battery_level1", var_0);
  }

  if(!isDefined(level.exo_repulsor_impact)) {
    level.exo_repulsor_impact = loadfx("vfx/explosion/exo_repulsor_impact");
  }

  if(!isDefined(level.exo_repulsor_activate_vfx)) {
    level.exo_repulsor_activate_vfx = loadfx("vfx/unique/repulsor_bubble");
  }

  if(!isDefined(level.exo_repulsor_deactivate_vfx)) {
    level.exo_repulsor_deactivate_vfx = loadfx("vfx/unique/repulsor_bubble_deactivate");
  }

  if(!isDefined(level.exo_repulsor_player_vfx_active)) {
    level.exo_repulsor_player_vfx_active = loadfx("vfx/unique/exo_repulsor_emitter");
  }

  if(!isDefined(level.exo_repulsor_player_vfx_inactive)) {
    level.exo_repulsor_player_vfx_inactive = loadfx("vfx/unique/exo_repulsor_inactive");
  }

  wait 0.05;

  if(!maps\mp\_utility::invirtuallobby()) {
    playFXOnTag(level.exo_repulsor_player_vfx_inactive, self, getrepulsortag());
  }
}

getrepulsortag() {
  if(isDefined(level.getrepulsortagfunc)) {
    return self[[level.getrepulsortagfunc]]();
  } else {
    return "TAG_JETPACK";
  }
}

tryuserepulsor(var_0) {
  self endon("exo_repulsor_taken");

  if(self.repulsoractive == 1) {
    thread stop_repulsor(1);
  } else {
    thread start_repulsor();
  }
}

killrepulsorfx() {
  if(isDefined(self.repulsor_fx)) {
    self.repulsor_fx delete();
    self.repulsor_fx = undefined;
  }
}

start_repulsor() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("stop_exo_repulsor");
  self endon("exo_repulsor_taken");
  self.repulsoractive = 1;
  thread do_exo_repulsor();
  self batterydischargebegin("exorepulsor_equipment_mp");
  maps\mp\_exo_battery::set_exo_ability_hud_omnvar("exorepulsor_equipment_mp", "ui_exo_battery_toggle", 1);
  thread maps\mp\_exo_battery::update_exo_battery_hud("exorepulsor_equipment_mp");
  maps\mp\_snd_common_mp::snd_message("mp_exo_repulsor_activate");
  killrepulsorfx();

  if(!isDefined(self.exo_cloak_on) || self.exo_cloak_on == 0) {
    self.repulsor_fx = spawnlinkedfx(level.exo_repulsor_player_vfx_active, self, getrepulsortag());
    triggerfx(self.repulsor_fx);
  }

  wait 0.05;

  if(!self.repulsoractive) {
    return;
  }
  if(isDefined(level.exo_repulsor_activate_vfx)) {
    playfxontagforclients(level.exo_repulsor_activate_vfx, self, "j_head", self);
  }
}

stop_repulsor(var_0) {
  if(!isDefined(self.repulsoractive) || !self.repulsoractive) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self notify("stop_exo_repulsor");
  self.repulsoractive = 0;
  self batterydischargeend("exorepulsor_equipment_mp");
  maps\mp\_exo_battery::set_exo_ability_hud_omnvar("exorepulsor_equipment_mp", "ui_exo_battery_toggle", 0);
  killrepulsorfx();

  if(var_0 == 1) {
    maps\mp\_snd_common_mp::snd_message("mp_exo_repulsor_deactivate");

    if(!isDefined(self.exo_cloak_on) || self.exo_cloak_on == 0) {
      self.repulsor_fx = spawnlinkedfx(level.exo_repulsor_player_vfx_inactive, self, getrepulsortag());
      triggerfx(self.repulsor_fx);
    }

    wait 0.05;

    if(isDefined(level.exo_repulsor_deactivate_vfx)) {
      playfxontagforclients(level.exo_repulsor_deactivate_vfx, self, "j_head", self);
    }
  }
}

monitorplayerdeath() {
  level endon("game_ended");
  self endon("disconnect");
  common_scripts\utility::waittill_any("death", "joined_team", "faux_spawn", "exo_repulsor_taken");
  self.projectilesstopped = 0;
  thread stop_repulsor(0);
}

update_exo_battery_hud() {
  var_0 = self batterygetcharge("exorepulsor_equipment_mp");
  maps\mp\_exo_battery::set_exo_ability_hud_omnvar("exorepulsor_equipment_mp", "ui_exo_battery_level", var_0);
}

do_exo_repulsor() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("stop_exo_repulsor");
  self endon("exo_repulsor_taken");

  while(self batterygetcharge("exorepulsor_equipment_mp") > 0) {
    for(var_0 = 0; var_0 < level.grenades.size; var_0++) {
      var_1 = level.grenades[var_0];

      if(!isDefined(var_1.weaponname)) {
        continue;
      }
      if(isDefined(var_1.weaponname) && maps\mp\_utility::is_exo_ability_weapon(var_1.weaponname)) {
        continue;
      }
      if(!isDefined(var_1.owner)) {
        continue;
      }
      if(isDefined(var_1.owner) && var_1.owner == self) {
        continue;
      }
      if(level.teambased && isDefined(var_1.owner.team) && var_1.owner.team == self.team) {
        continue;
      }
      var_2 = distance(var_1.origin, self.origin);

      if(var_2 < 385) {
        if(sighttracepassed(self getEye(), var_1.origin, 0, self)) {
          var_3 = var_1.origin - self.origin;
          var_4 = vectortoangles(var_3);
          var_5 = anglestoup(var_4);
          var_6 = anglesToForward(var_4);
          var_7 = vectornormalize(var_6);
          var_8 = var_1.origin - 0.2 * var_2 * var_7;
          playFX(level.exo_repulsor_impact, var_8, var_7, var_5);
          var_1 maps\mp\_snd_common_mp::snd_message("mp_exo_repulsor_repel");

          if(var_1.weaponname == "explosive_drone_mp") {
            var_1 notify("mp_exo_repulsor_repel");
            var_1 thread maps\mp\_explosive_drone::explosivegrenadedeath();
          } else {
            if(isDefined(level.iszombiegame) && level.iszombiegame) {
              var_1 notify("repulsor_repel");
            }

            var_1 delete();
          }

          self.projectilesstopped++;
          maps\mp\gametypes\_missions::processchallenge("ch_exoability_repulser");
          self batterydischargeonce("exorepulsor_equipment_mp", int(self batterygetsize("exorepulsor_equipment_mp") / 2));
          update_exo_battery_hud();
        }
      }
    }

    for(var_0 = 0; var_0 < level.missiles.size; var_0++) {
      var_9 = level.missiles[var_0];

      if(!isDefined(var_9.owner)) {
        continue;
      }
      if(isDefined(var_9.owner) && var_9.owner == self) {
        continue;
      }
      if(level.teambased && isDefined(var_9.owner.team) && var_9.owner.team == self.team) {
        continue;
      }
      var_10 = distance(var_9.origin, self.origin);

      if(var_10 < 385) {
        if(sighttracepassed(self getEye(), var_9.origin, 0, self)) {
          var_11 = var_9.origin - self.origin;
          var_12 = vectortoangles(var_11);
          var_13 = anglestoup(var_12);
          var_14 = anglesToForward(var_12);
          var_15 = vectornormalize(var_14);
          var_8 = var_9.origin - 0.2 * var_10 * var_15;
          playFX(level.exo_repulsor_impact, var_8, var_15, var_13);
          var_9 maps\mp\_snd_common_mp::snd_message("mp_exo_repulsor_repel");

          if(isDefined(var_9.weaponname) && var_9.weaponname == "iw5_exocrossbow_mp") {
            stopFXOnTag(common_scripts\utility::getfx("exocrossbow_sticky_blinking"), var_9.fx_origin, "tag_origin");
          }

          var_9 delete();
          self.projectilesstopped++;
          maps\mp\gametypes\_missions::processchallenge("ch_exoability_repulser");
          self batterydischargeonce("exorepulsor_equipment_mp", int(self batterygetsize("exorepulsor_equipment_mp") / 2));
          update_exo_battery_hud();
        }
      }
    }

    for(var_0 = 0; var_0 < level.explosivedrones.size; var_0++) {
      var_16 = level.explosivedrones[var_0];

      if(isDefined(var_16)) {
        if(!isDefined(var_16.owner)) {
          continue;
        }
        if(isDefined(var_16.owner) && var_16.owner == self) {
          continue;
        }
        if(level.teambased && isDefined(var_16.owner.team) && var_16.owner.team == self.team) {
          continue;
        }
        var_17 = distance(var_16.origin, self.origin);

        if(var_17 < 385) {
          if(sighttracepassed(self getEye(), var_16.origin, 0, self)) {
            var_18 = var_16.origin - self.origin;
            var_19 = vectortoangles(var_18);
            var_20 = anglestoup(var_19);
            var_21 = anglesToForward(var_19);
            var_22 = vectornormalize(var_21);
            var_8 = var_16.origin - 0.2 * var_17 * var_22;
            playFX(level.exo_repulsor_impact, var_8, var_22, var_20);
            var_16 maps\mp\_snd_common_mp::snd_message("mp_exo_repulsor_repel");

            if(isDefined(var_16.explosivedrone)) {
              var_16.explosivedrone delete();
            }

            var_16 delete();
            self.projectilesstopped++;
            maps\mp\gametypes\_missions::processchallenge("ch_exoability_repulser");
            self batterydischargeonce("exorepulsor_equipment_mp", int(self batterygetsize("exorepulsor_equipment_mp") / 2));
            update_exo_battery_hud();
          }
        }
      }
    }

    foreach(var_24 in level.trackingdrones) {
      if(!isDefined(var_24.owner)) {
        continue;
      }
      if(isDefined(var_24.owner) && var_24.owner == self) {
        continue;
      }
      if(level.teambased && isDefined(var_24.owner.team) && var_24.owner.team == self.team) {
        continue;
      }
      var_25 = distance(var_24.origin, self.origin);

      if(var_25 < 385) {
        if(sighttracepassed(self getEye(), var_24.origin, 0, self)) {
          var_26 = var_24.origin - self.origin;
          var_27 = vectortoangles(var_26);
          var_28 = anglestoup(var_27);
          var_29 = anglesToForward(var_27);
          var_30 = vectornormalize(var_29);
          var_8 = var_24.origin - 0.2 * var_25 * var_30;
          playFX(level.exo_repulsor_impact, var_8, var_30, var_28);
          var_24 maps\mp\_snd_common_mp::snd_message("mp_exo_repulsor_repel");

          if(!isremovedentity(var_24) && isDefined(var_24)) {
            var_24 notify("death");
            maps\mp\_utility::decrementfauxvehiclecount();
          }

          self.projectilesstopped++;
          maps\mp\gametypes\_missions::processchallenge("ch_exoability_repulser");
          self batterydischargeonce("exorepulsor_equipment_mp", int(self batterygetsize("exorepulsor_equipment_mp") / 2));
          update_exo_battery_hud();
        }
      }
    }

    if(self.projectilesstopped >= 2) {
      if(!isDefined(level.ishorde)) {
        thread maps\mp\_events::fourplayevent();
      }

      self.projectilesstopped = self.projectilesstopped - 2;
    }

    wait 0.05;
  }

  thread stop_repulsor(1);
}

take_exo_repulsor() {
  self notify("kill_battery");
  self notify("exo_repulsor_taken");
  self takeweapon("exorepulsor_equipment_mp");
}

give_exo_repulsor() {
  self giveweapon("exorepulsor_equipment_mp");
  thread exo_repulsor_think();
}

wait_for_game_end() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_repulsor_taken");
  level waittill("game_ended");
  thread stop_repulsor(0);
}