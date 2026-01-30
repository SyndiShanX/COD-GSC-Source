/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_exo_repulsor.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_snd_common_mp;

EXO_REPULSOR_RADIUS = 385;
EXO_REPULSOR_REPEL_VEL = 800;

exo_repulsor_think() {
  self notify("exo_repulsor_taken");

  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_repulsor_taken");

  if(!self HasWeapon("exorepulsor_equipment_mp")) {
    return;
  }

  exoRepulsorInit();

  self thread MonitorPlayerDeath();
  self thread wait_for_game_end();

  while(1) {
    self waittill("exo_ability_activate", weapname);

    if(weapname == "exorepulsor_equipment_mp") {
      self thread tryUseRepulsor();
    }
  }
}

exoRepulsorInit() {
  self.repulsorActive = false;

  self BatterySetDischargeScale("exorepulsor_equipment_mp", 1.0);
  full_energy = self BatteryGetSize("exorepulsor_equipment_mp");
  self.projectilesStopped = 0;

  if(self GetTacticalWeapon() == "exorepulsor_equipment_mp") {
    self SetClientOmnvar("exo_ability_nrg_req0", 0);
    self SetClientOmnvar("exo_ability_nrg_total0", full_energy);
    self SetClientOmnvar("ui_exo_battery_level0", full_energy);
  } else if(self GetLethalWeapon() == "exorepulsor_equipment_mp") {
    self SetClientOmnvar("exo_ability_nrg_req1", 0);
    self SetClientOmnvar("exo_ability_nrg_total1", full_energy);
    self SetClientOmnvar("ui_exo_battery_level1", full_energy);
  }

  if(!isDefined(level.exo_repulsor_impact)) {
    level.exo_repulsor_impact = LoadFX("vfx/explosion/exo_repulsor_impact");
  }
  if(!isDefined(level.exo_repulsor_activate_vfx)) {
    level.exo_repulsor_activate_vfx = LoadFX("vfx/unique/repulsor_bubble");
  }
  if(!isDefined(level.exo_repulsor_deactivate_vfx)) {
    level.exo_repulsor_deactivate_vfx = LoadFX("vfx/unique/repulsor_bubble_deactivate");
  }
  if(!isDefined(level.exo_repulsor_player_vfx_active)) {
    level.exo_repulsor_player_vfx_active = LoadFX("vfx/unique/exo_repulsor_emitter");
  }
  if(!isDefined(level.exo_repulsor_player_vfx_inactive)) {
    level.exo_repulsor_player_vfx_inactive = LoadFX("vfx/unique/exo_repulsor_inactive");
  }

  wait(0.05);

  if(!inVirtualLobby()) {
    playFXOnTag(level.exo_repulsor_player_vfx_inactive, self, "TAG_JETPACK");
  }
}

tryUseRepulsor(duration) {
  self endon("exo_repulsor_taken");

  if(self.repulsorActive == true) {
    self thread stop_repulsor(true);
  } else {
    self thread start_repulsor();
  }
}

killRepulsorFx() {
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

  self.repulsorActive = true;

  self thread do_exo_repulsor();

  self BatteryDischargeBegin("exorepulsor_equipment_mp");

  self maps\mp\_exo_battery::set_exo_ability_hud_omnvar("exorepulsor_equipment_mp", "ui_exo_battery_toggle", 1);

  self thread maps\mp\_exo_battery::update_exo_battery_hud("exorepulsor_equipment_mp");

  self snd_message("mp_exo_repulsor_activate");

  killRepulsorFx();

  if(!isDefined(self.exo_cloak_on) || self.exo_cloak_on == false) {
    self.repulsor_fx = SpawnLinkedFx(level.exo_repulsor_player_vfx_active, self, "TAG_JETPACK");
    TriggerFX(self.repulsor_fx);
  }

  wait(0.05);

  if(!self.repulsorActive) {
    return;
  }

  if(isDefined(level.exo_repulsor_activate_vfx)) {
    PlayFXOnTagForClients(level.exo_repulsor_activate_vfx, self, "j_head", self);
  }
}

stop_repulsor(should_play_fx) {
  if(!isDefined(self.repulsorActive) || !self.repulsorActive) {
    return;
  }

  if(!isDefined(should_play_fx)) {
    should_play_fx = true;
  }

  self notify("stop_exo_repulsor");

  self.repulsorActive = false;

  self BatteryDischargeEnd("exorepulsor_equipment_mp");

  self maps\mp\_exo_battery::set_exo_ability_hud_omnvar("exorepulsor_equipment_mp", "ui_exo_battery_toggle", 0);

  killRepulsorFx();

  if(should_play_fx == true) {
    self snd_message("mp_exo_repulsor_deactivate");

    if(!isDefined(self.exo_cloak_on) || self.exo_cloak_on == false) {
      self.repulsor_fx = SpawnLinkedFx(level.exo_repulsor_player_vfx_inactive, self, "TAG_JETPACK");
      TriggerFX(self.repulsor_fx);
    }

    wait(0.05);

    if(isDefined(level.exo_repulsor_deactivate_vfx)) {
      PlayFXOnTagForClients(level.exo_repulsor_deactivate_vfx, self, "j_head", self);
    }
  }
}

MonitorPlayerDeath() {
  level endon("game_ended");
  self endon("disconnect");

  self waittill_any("death", "joined_team", "faux_spawn", "exo_repulsor_taken");

  self.projectilesStopped = 0;

  self thread stop_repulsor(false);
}

update_exo_battery_hud() {
  battery_energy = self BatteryGetCharge("exorepulsor_equipment_mp");

  self maps\mp\_exo_battery::set_exo_ability_hud_omnvar("exorepulsor_equipment_mp", "ui_exo_battery_level", battery_energy);
}

do_exo_repulsor() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("stop_exo_repulsor");
  self endon("exo_repulsor_taken");

  while(self BatteryGetCharge("exorepulsor_equipment_mp") > 0) {
    for(i = 0; i < level.grenades.size; i++) {
      grenade = level.grenades[i];

      if(!isDefined(grenade.weaponName)) {
        continue;
      }

      if(isDefined(grenade.weaponName) && is_exo_ability_weapon(grenade.weaponName)) {
        continue;
      }

      if(!isDefined(grenade.owner)) {
        continue;
      }

      if(isDefined(grenade.owner) && grenade.owner == self) {
        continue;
      }

      if(level.teamBased && isDefined(grenade.owner.team) && grenade.owner.team == self.team) {
        continue;
      }

      player_to_grenade_dist = Distance(grenade.origin, self.origin);

      if(player_to_grenade_dist < EXO_REPULSOR_RADIUS) {
        if(SightTracePassed(self getEye(), grenade.origin, false, self)) {
          player_to_grenade_vector = grenade.origin - self.origin;
          player_to_grenade_angles = VectorToAngles(player_to_grenade_vector);
          player_to_grenade_up = AnglesToUp(player_to_grenade_angles);
          player_to_grenade_forward = anglesToForward(player_to_grenade_angles);
          player_to_grenade_forward_norm = VectorNormalize(player_to_grenade_forward);
          fx_origin = grenade.origin - (0.2 * player_to_grenade_dist * player_to_grenade_forward_norm);
          playFX(level.exo_repulsor_impact, fx_origin, player_to_grenade_forward_norm, player_to_grenade_up);

          grenade snd_message("mp_exo_repulsor_repel");

          if(grenade.weaponname == "explosive_drone_mp") {
            grenade notify("mp_exo_repulsor_repel");

            grenade thread maps\mp\_explosive_drone::explosiveGrenadeDeath();
          } else {
            grenade delete();
          }
          self.projectilesStopped++;

          self maps\mp\gametypes\_missions::processChallenge("ch_exoability_repulser");

          self BatteryDischargeOnce("exorepulsor_equipment_mp", int(self BatteryGetSize("exorepulsor_equipment_mp") / 2));
          self update_exo_battery_hud();
        }
      }
    }

    for(i = 0; i < level.missiles.size; i++) {
      rocket = level.missiles[i];

      if(!isDefined(rocket.owner)) {
        continue;
      }

      if(isDefined(rocket.owner) && rocket.owner == self) {
        continue;
      }

      if(level.teamBased && isDefined(rocket.owner.team) && rocket.owner.team == self.team) {
        continue;
      }

      player_to_rocket_dist = Distance(rocket.origin, self.origin);

      if(player_to_rocket_dist < EXO_REPULSOR_RADIUS) {
        if(SightTracePassed(self getEye(), rocket.origin, false, self)) {
          player_to_rocket_vector = rocket.origin - self.origin;
          player_to_rocket_angles = VectorToAngles(player_to_rocket_vector);
          player_to_rocket_up = AnglesToUp(player_to_rocket_angles);
          player_to_rocket_forward = anglesToForward(player_to_rocket_angles);
          player_to_rocket_forward_norm = VectorNormalize(player_to_rocket_forward);
          fx_origin = rocket.origin - (0.2 * player_to_rocket_dist * player_to_rocket_forward_norm);
          playFX(level.exo_repulsor_impact, fx_origin, player_to_rocket_forward_norm, player_to_rocket_up);

          rocket snd_message("mp_exo_repulsor_repel");

          if(isDefined(rocket.weaponname) && rocket.weaponname == "iw5_exocrossbow_mp") {
            stopFXOnTag(getfx("exocrossbow_sticky_blinking"), rocket.fx_origin, "tag_origin");
          }

          rocket delete();
          self.projectilesStopped++;

          self maps\mp\gametypes\_missions::processChallenge("ch_exoability_repulser");

          self BatteryDischargeOnce("exorepulsor_equipment_mp", int(self BatteryGetSize("exorepulsor_equipment_mp") / 2));
          self update_exo_battery_hud();
        }
      }
    }

    for(i = 0; i < level.explosivedrones.size; i++) {
      explosiveDrone = level.explosivedrones[i];

      if(isDefined(explosiveDrone)) {
        if(!isDefined(explosiveDrone.owner)) {
          continue;
        }

        if(isDefined(explosiveDrone.owner) && explosiveDrone.owner == self) {
          continue;
        }

        if(level.teamBased && isDefined(explosiveDrone.owner.team) && explosiveDrone.owner.team == self.team) {
          continue;
        }

        player_to_explosiveDrone_dist = Distance(explosiveDrone.origin, self.origin);

        if(player_to_explosiveDrone_dist < EXO_REPULSOR_RADIUS) {
          if(SightTracePassed(self getEye(), explosiveDrone.origin, false, self)) {
            player_to_explosiveDrone_vector = explosiveDrone.origin - self.origin;
            player_to_explosiveDrone_angles = VectorToAngles(player_to_explosiveDrone_vector);
            player_to_explosiveDrone_up = AnglesToUp(player_to_explosiveDrone_angles);
            player_to_explosiveDrone_forward = anglesToForward(player_to_explosiveDrone_angles);
            player_to_explosiveDrone_forward_norm = VectorNormalize(player_to_explosiveDrone_forward);
            fx_origin = explosiveDrone.origin - (0.2 * player_to_explosiveDrone_dist * player_to_explosiveDrone_forward_norm);
            playFX(level.exo_repulsor_impact, fx_origin, player_to_explosiveDrone_forward_norm, player_to_explosiveDrone_up);

            explosiveDrone snd_message("mp_exo_repulsor_repel");

            if(isDefined(explosiveDrone.explosiveDrone)) {
              explosiveDrone.explosiveDrone delete();
            }

            explosiveDrone delete();
            self.projectilesStopped++;

            self maps\mp\gametypes\_missions::processChallenge("ch_exoability_repulser");

            self BatteryDischargeOnce("exorepulsor_equipment_mp", int(self BatteryGetSize("exorepulsor_equipment_mp") / 2));
            self update_exo_battery_hud();
          }
        }
      }
    }

    foreach(tdrone in level.trackingDrones) {
      if(!isDefined(tdrone.owner)) {
        continue;
      }

      if(isDefined(tdrone.owner) && tdrone.owner == self) {
        continue;
      }

      if(level.teamBased && isDefined(tdrone.owner.team) && tdrone.owner.team == self.team) {
        continue;
      }

      player_to_tdrone_dist = Distance(tdrone.origin, self.origin);

      if(player_to_tdrone_dist < EXO_REPULSOR_RADIUS) {
        if(SightTracePassed(self getEye(), tdrone.origin, false, self)) {
          player_to_tdrone_vector = tdrone.origin - self.origin;
          player_to_tdrone_angles = VectorToAngles(player_to_tdrone_vector);
          player_to_tdrone_up = AnglesToUp(player_to_tdrone_angles);
          player_to_tdrone_forward = anglesToForward(player_to_tdrone_angles);
          player_to_tdrone_forward_norm = VectorNormalize(player_to_tdrone_forward);
          fx_origin = tdrone.origin - (0.2 * player_to_tdrone_dist * player_to_tdrone_forward_norm);
          playFX(level.exo_repulsor_impact, fx_origin, player_to_tdrone_forward_norm, player_to_tdrone_up);

          tdrone snd_message("mp_exo_repulsor_repel");

          if(!IsRemovedEntity(tdrone) && isDefined(tdrone)) {
            tdrone notify("death");
            decrementFauxVehicleCount();
          }

          self.projectilesStopped++;

          self maps\mp\gametypes\_missions::processChallenge("ch_exoability_repulser");

          self BatteryDischargeOnce("exorepulsor_equipment_mp", int(self BatteryGetSize("exorepulsor_equipment_mp") / 2));
          self update_exo_battery_hud();
        }
      }
    }

    if(self.projectilesStopped >= 2) {
      if(!isDefined(level.isHorde)) {
        self thread maps\mp\_events::fourPlayEvent();
      }
      self.projectilesStopped -= 2;
    }

    wait 0.05;
  }

  self thread stop_repulsor(true);
}

take_exo_repulsor() {
  self notify("kill_battery");
  self notify("exo_repulsor_taken");
  self takeWeapon("exorepulsor_equipment_mp");
}

give_exo_repulsor() {
  self giveWeapon("exorepulsor_equipment_mp");
  self thread exo_repulsor_think();
}

wait_for_game_end() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_repulsor_taken");

  level waittill("game_ended");

  self thread stop_repulsor(false);
}