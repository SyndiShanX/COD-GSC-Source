/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_cic_turret.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_statemachine;
#include maps\_vehicle_death;

init() {
  precachestring(&"hud_cic_weapon_heat");
  vehicle_add_main_callback("turret_cic", ::cic_turret_think);
  vehicle_add_main_callback("turret_cic_world", ::cic_turret_think);
  vehicle_add_main_callback("turret_sentry", ::cic_turret_think);
  vehicle_add_main_callback("turret_sentry_world", ::cic_turret_think);
  vehicle_add_main_callback("turret_sentry_rts", ::cic_turret_think);
  level._effect["cic_turret_damage01"] = loadfx("destructibles/fx_cic_turret_damagestate01");
  level._effect["cic_turret_damage02"] = loadfx("destructibles/fx_cic_turret_damagestate02");
  level._effect["sentry_turret_damage01"] = loadfx("destructibles/fx_sentry_turret_damagestate01");
  level._effect["sentry_turret_damage02"] = loadfx("destructibles/fx_sentry_turret_damagestate02");
  level._effect["cic_turret_stun"] = loadfx("electrical/fx_elec_sp_emp_stun_cic_turret");
  level._effect["sentry_turret_stun"] = loadfx("electrical/fx_elec_sp_emp_stun_sentry_turret");
  level._effect["cic_turret_lens_flare"] = loadfx("lens_flares/fx_lf_commandcenter_cic");
}

cic_turret_think() {
  self enableaimassist();

  if(issubstr(self.vehicletype, "turret_sentry")) {
    self.scanning_arc = 60;
    self.default_pitch = 0;
    self setvehicleavoidance(1, 22);
  } else {
    self.scanning_arc = 60;
    self.default_pitch = 15;
  }

  self.state_machine = create_state_machine("brain", self);
  main = self.state_machine add_state("main", undefined, undefined, ::cic_turret_main, undefined, undefined);
  scripted = self.state_machine add_state("scripted", undefined, undefined, ::cic_turret_scripted, undefined, undefined);
  main add_connection_by_type("scripted", 1, 4, undefined, "enter_vehicle");
  main add_connection_by_type("scripted", 1, 4, undefined, "scripted");
  scripted add_connection_by_type("main", 1, 4, undefined, "exit_vehicle");
  scripted add_connection_by_type("main", 1, 4, undefined, "scripted_done");
  self thread cic_turret_death();
  self thread cic_turret_damage();
  self thread cic_turret_lens_flare();
  self.overridevehicledamage = ::cicturretcallback_vehicledamage;

  if(isDefined(self.script_startstate)) {
    if(self.script_startstate == "off")
      self cic_turret_off(self.angles);
    else
      self.state_machine set_state(self.script_startstate);
  } else
    cic_turret_start_ai();

  self laseron();
  self.state_machine update_state_machine(0.3);
}

cic_turret_start_scripted() {
  self.state_machine set_state("scripted");
}

cic_turret_start_ai() {
  self.goalpos = self.origin;
  self.state_machine set_state("main");
}

cic_turret_main() {
  if(isalive(self)) {
    self enableaimassist();
    self thread cic_turret_fireupdate();
  }
}

cic_turret_off(angles) {
  self.state_machine set_state("scripted");
  self lights_off();
  self laseroff();
  self vehicle_toggle_sounds(0);
  self veh_toggle_exhaust_fx(0);

  if(!isDefined(angles))
    angles = self gettagangles("tag_flash");

  target_vec = self.origin + anglestoforward((0, angles[1], 0)) * 1000;
  target_vec = target_vec + vectorscale((0, 0, -1), 1700.0);
  self settargetorigin(target_vec);
  self.off = 1;

  if(!isDefined(self.emped))
    self disableaimassist();
}

cic_turret_on() {
  self playsound("veh_cic_turret_boot");
  self lights_on();
  self enableaimassist();
  self vehicle_toggle_sounds(1);
  self bootup();
  self veh_toggle_exhaust_fx(1);
  self.off = undefined;
  self laseron();
  cic_turret_start_ai();
}

bootup() {
  for(i = 0; i < 6; i++) {
    wait 0.1;
    lights_off();
    wait 0.1;
    lights_on();
  }

  if(!isDefined(self.player)) {
    angles = self gettagangles("tag_flash");
    target_vec = self.origin + anglestoforward((self.default_pitch, angles[1], 0)) * 1000;
    self.turretrotscale = 0.3;
    self settargetorigin(target_vec);
    wait 1;
    self.turretrotscale = 1;
  }
}

cic_turret_on_target_thread() {
  self endon("death");
  self endon("change_state");
  self.turret_on_target = 0;

  while(true) {
    self waittill("turret_on_target");
    self.turret_on_target = 1;
  }
}

cic_turret_fireupdate() {
  self endon("death");
  self endon("change_state");
  cant_see_enemy_count = 0;
  wait 0.2;
  origin = self gettagorigin("tag_barrel");
  left_look_at_pt = origin + anglestoforward(self.angles + (self.default_pitch, self.scanning_arc, 0)) * 1000;
  right_look_at_pt = origin + anglestoforward(self.angles + (self.default_pitch, self.scanning_arc * -1, 0)) * 1000;
  self thread cic_turret_on_target_thread();

  while(true) {
    if(isDefined(self.enemy) && self vehcansee(self.enemy)) {
      self.turretrotscale = 1;

      if(cant_see_enemy_count > 0 && isplayer(self.enemy)) {
        cic_turret_alert_sound();
        wait 0.5;
      }

      cant_see_enemy_count = 0;

      for(i = 0; i < 3; i++) {
        if(isDefined(self.enemy) && isalive(self.enemy) && self vehcansee(self.enemy)) {
          self setturrettargetent(self.enemy);
          wait 0.1;
          self cic_turret_fire_for_time(randomfloatrange(0.4, 1.5));
        } else
          self cleartargetentity();

        if(isDefined(self.enemy) && isplayer(self.enemy)) {
          wait(randomfloatrange(0.3, 0.6));
          continue;
        }

        wait(randomfloatrange(0.3, 0.6) * 2);
      }

      if(isDefined(self.enemy) && isalive(self.enemy) && self vehcansee(self.enemy)) {
        if(isplayer(self.enemy))
          wait(randomfloatrange(0.5, 1.3));
        else
          wait(randomfloatrange(0.5, 1.3) * 2);
      }
    } else {
      self.turretrotscale = 0.25;
      cant_see_enemy_count++;
      wait 1;

      if(cant_see_enemy_count > 1) {
        self.turret_state = 0;

        while(!isDefined(self.enemy) || !self vehcansee(self.enemy)) {
          if(self.turret_on_target) {
            self.turret_on_target = 0;
            self.turret_state++;

            if(self.turret_state > 1)
              self.turret_state = 0;
          }

          if(self.turret_state == 0)
            self setturrettargetvec(left_look_at_pt);
          else
            self setturrettargetvec(right_look_at_pt);

          wait 0.5;
        }
      } else
        self cleartargetentity();
    }

    wait 0.5;
  }
}

cic_turret_scripted() {
  driver = self getseatoccupant(0);

  if(isDefined(driver)) {
    self.turretrotscale = 1;
    self disableaimassist();

    if(driver == level.player) {
      self thread maps\_vehicle_death::vehicle_damage_filter("firestorm_turret");
      level.player thread cic_overheat_hud(self);
    }
  }

  self cleartargetentity();
}

cic_turret_get_damage_effect(health_pct) {
  if(issubstr(self.vehicletype, "turret_sentry")) {
    if(health_pct < 0.6)
      return level._effect["sentry_turret_damage02"];
    else
      return level._effect["sentry_turret_damage01"];
  } else if(health_pct < 0.6)
    return level._effect["cic_turret_damage02"];
  else
    return level._effect["cic_turret_damage01"];
}

cic_turret_play_single_fx_on_tag(effect, tag) {
  if(isDefined(self.damage_fx_ent)) {
    if(self.damage_fx_ent.effect == effect) {
      return;
    }
    self.damage_fx_ent delete();
  }

  if(!isDefined(self gettagangles(tag))) {
    return;
  }
  ent = spawn("script_model", (0, 0, 0));
  ent setmodel("tag_origin");
  ent.origin = self gettagorigin(tag);
  ent.angles = self gettagangles(tag);
  ent notsolid();
  ent hide();
  ent linkto(self, tag);
  ent.effect = effect;
  playfxontag(effect, ent, "tag_origin");
  ent playsound("veh_cic_turret_sparks");
  self.damage_fx_ent = ent;
}

cic_turret_lens_flare() {
  self endon("death");

  while(true) {
    if(isDefined(self.turret_on_target) && self.turret_on_target && isplayer(self.enemy)) {
      level.player waittill_player_looking_at(self gettagorigin("TAG_LASER"), 90);
      self play_fx("cic_turret_lens_flare", undefined, undefined, "stop_flare", 1, "TAG_FX");
      level.player waittill_player_not_looking_at(self gettagorigin("TAG_LASER"));
      self notify("stop_flare");
    }

    wait 0.1;
  }
}

cic_turret_damage() {
  self endon("crash_done");

  while(isDefined(self)) {
    self waittill("damage");

    if(self.health > 0) {
      effect = self cic_turret_get_damage_effect(self.health / self.healthdefault);
      tag = "tag_fx";
      cic_turret_play_single_fx_on_tag(effect, tag);
    }

    wait 0.3;
  }
}

cic_turret_death() {
  wait 0.1;
  self notify("nodeath_thread");
  self waittill("death", attacker, damagefromunderneath, weaponname, point, dir);

  if(isDefined(self.delete_on_death)) {
    if(isDefined(self.damage_fx_ent))
      self.damage_fx_ent delete();

    self delete();
    return;
  }

  if(!isDefined(self)) {
    return;
  }
  self maps\_vehicle_death::death_cleanup_level_variables();
  self disableaimassist();
  self cleartargetentity();
  self lights_off();
  self laseroff();
  self setturretspinning(0);
  self death_fx();
  self thread maps\_vehicle_death::death_radius_damage();
  self thread maps\_vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
  self vehicle_toggle_sounds(0);
  self thread cic_turret_death_movement(attacker, dir);

  if(isDefined(self.damage_fx_ent))
    self.damage_fx_ent delete();

  self.ignoreme = 1;
  self waittill("crash_done");
  self freevehicle();
}

death_fx() {
  playfxontag(self.deathfx, self, self.deathfxtag);
  self playsound("veh_cic_turret_sparks");
  fire_ent = spawn("script_origin", self.origin);
  fire_ent playloopsound("veh_cic_turret_dmg_fire_loop", 0.5);
}

cic_turret_death_movement(attacker, hitdir) {
  self endon("crash_done");
  self endon("death");
  self playsound("veh_cic_turret_dmg_hit");
  wait 0.1;
  self.turretrotscale = 0.5;
  tag_angles = self gettagangles("tag_flash");
  target_pos = self.origin + anglestoforward((0, tag_angles[1], 0)) * 1000 + vectorscale((0, 0, -1), 1800.0);
  self setturrettargetvec(target_pos);
  wait 4;
  self notify("crash_done");
}

cic_turret_fire_for_time(totalfiretime) {
  self endon("crash_done");
  self endon("death");
  cic_turret_alert_sound();
  wait 0.1;
  weaponname = self seatgetweapon(0);
  firetime = weaponfiretime(weaponname);
  time = 0;
  is_minigun = 0;

  if(issubstr(weaponname, "minigun")) {
    is_minigun = 1;
    self setturretspinning(1);
    wait 0.5;
  }

  firechance = 2;

  if(isDefined(self.enemy) && isplayer(self.enemy))
    firechance = 1;

  firecount = 1;

  while(time < totalfiretime) {
    if(isDefined(self.enemy) && isDefined(self.enemy.attackeraccuracy) && self.enemy.attackeraccuracy == 0)
      self fireweapon(undefined, undefined, 1);
    else if(firechance > 1)
      self fireweapon(undefined, undefined, firecount % firechance);
    else
      self fireweapon();

    firecount++;
    wait(firetime);
    time = time + firetime;
  }

  if(is_minigun)
    self setturretspinning(0);
}

cic_turret_alert_sound() {
  self playsound("veh_turret_alert");
}

cic_turret_set_team(team) {
  self.vteam = team;

  if(!isDefined(self.off))
    cic_turret_blink_lights();
}

cic_turret_blink_lights() {
  self endon("death");
  self lights_off();
  wait 0.1;
  self lights_on();
}

cic_turret_emped() {
  self endon("death");
  self notify("emped");
  self endon("emped");
  self.emped = 1;
  playsoundatposition("veh_cic_turret_emp_down", self.origin);
  self.turretrotscale = 0.2;
  self cic_turret_off();

  if(!isDefined(self.stun_fx)) {
    self.stun_fx = spawn("script_model", self.origin);
    self.stun_fx setmodel("tag_origin");
    self.stun_fx linkto(self, "tag_fx", (0, 0, 0), (0, 0, 0));

    if(issubstr(self.vehicletype, "turret_sentry"))
      playfxontag(level._effect["sentry_turret_stun"], self.stun_fx, "tag_origin");
    else
      playfxontag(level._effect["cic_turret_stun"], self.stun_fx, "tag_origin");
  }

  wait(randomfloatrange(6, 10));
  self.stun_fx delete();
  self.emped = undefined;
  self cic_turret_on();
}

cicturretcallback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(sweapon == "emp_grenade_sp" && smeansofdeath != "MOD_IMPACT") {
    driver = self getseatoccupant(0);

    if(!isDefined(driver))
      self thread cic_turret_emped();
  }

  if(sweapon == "titus_explosive_dart_sp" && idamage > 50 && self.vteam == "axis")
    idamage = int(idamage * 10);

  if(!isplayer(eattacker))
    idamage = int(idamage / 4);

  return idamage;
}

cic_overheat_hud(turret) {
  self endon("exit_vehicle");
  turret endon("turret_exited");
  level endon("player_using_turret");
  heat = 0;
  overheat = 0;

  while(true) {
    if(isDefined(self.viewlockedentity)) {
      old_heat = heat;
      heat = self.viewlockedentity getturretheatvalue(0);
      old_overheat = overheat;
      overheat = self.viewlockedentity isvehicleturretoverheating(0);

      if(old_heat != heat || old_overheat != overheat)
        luinotifyevent(&"hud_cic_weapon_heat", 2, int(heat), overheat);
    }

    wait 0.05;
  }
}