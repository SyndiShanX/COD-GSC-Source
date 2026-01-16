/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\microwave_turret_shared.gsc
***************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\damage;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\util_shared;
#include scripts\weapons\weaponobjects;

#namespace microwave_turret;

init_shared() {
  clientfield::register("vehicle", "turret_microwave_open", 1, 1, "int");
  clientfield::register("scriptmover", "turret_microwave_init", 1, 1, "int");
  clientfield::register("scriptmover", "turret_microwave_close", 1, 1, "int");
  callback::on_spawned(&on_player_spawned);
  callback::on_vehicle_spawned(&on_vehicle_spawned);
}

on_player_spawned() {
  self reset_being_microwaved();
}

on_vehicle_spawned() {
  self reset_being_microwaved();
}

reset_being_microwaved() {
  self.lastmicrowavedby = undefined;
  self.beingmicrowavedby = undefined;
}

startmicrowave() {
  turret = self;

  if(isDefined(turret.trigger)) {
    turret.trigger delete();
  }

  turret.trigger = spawn("trigger_radius", turret.origin + (0, 0, 750 * -1), 4096 | 16384 | level.aitriggerspawnflags | level.vehicletriggerspawnflags, 750, 750 * 2);
  turret thread turretthink();

  turret thread turretdebugwatch();
}

stopmicrowave() {
  turret = self;

  if(isDefined(turret)) {
    turret playSound(#"mpl_microwave_beam_off");

    if(isDefined(turret.trigger)) {
      turret.trigger delete();
    }

    turret notify(#"stop_turret_debug");

  }
}

turretdebugwatch() {
  turret = self;
  turret endon(#"stop_turret_debug");

  for(;;) {
    if(getdvarint(#"scr_microwave_turret_debug", 0) != 0) {
      turret turretdebug();
      waitframe(1);
      continue;
    }

    wait 1;
  }
}

turretdebug() {
  turret = self;
  angles = turret gettagangles("<dev string:x38>");
  origin = turret gettagorigin("<dev string:x38>");
  cone_apex = origin;
  forward = anglesToForward(angles);
  dome_apex = cone_apex + vectorscale(forward, 750);

  util::debug_spherical_cone(cone_apex, dome_apex, 15, 16, (0.95, 0.1, 0.1), 0.3, 1, 3);
}

turretthink() {
  turret = self;
  turret endon(#"microwave_turret_shutdown", #"death");
  turret.trigger endon(#"death", #"delete");
  turret.turret_vehicle_entnum = turret getentitynumber();

  while(true) {
    waitresult = turret.trigger waittill(#"trigger");
    ent = waitresult.activator;

    if(ent == turret) {
      continue;
    }

    if(!isDefined(ent.beingmicrowavedby)) {
      ent.beingmicrowavedby = [];
    }

    if(!isDefined(ent.beingmicrowavedby[turret.turret_vehicle_entnum])) {
      turret thread microwaveentity(ent);
    }
  }
}

microwaveentitypostshutdowncleanup(entity) {
  entity endon(#"disconnect", #"end_microwaveentitypostshutdowncleanup");
  turret = self;
  turret_vehicle_entnum = turret.turret_vehicle_entnum;
  turret waittill(#"microwave_turret_shutdown");

  if(isDefined(entity)) {
    if(isDefined(entity.beingmicrowavedby) && isDefined(entity.beingmicrowavedby[turret_vehicle_entnum])) {
      entity.beingmicrowavedby[turret_vehicle_entnum] = undefined;
    }
  }
}

microwaveentity(entity) {
  turret = self;
  turret endon(#"microwave_turret_shutdown", #"death");
  entity endon(#"disconnect", #"death");

  if(isplayer(entity)) {
    entity endon(#"joined_team", #"joined_spectators");
  }

  turret thread microwaveentitypostshutdowncleanup(entity);
  entity.beingmicrowavedby[turret.turret_vehicle_entnum] = turret.owner;
  entity.microwavedamageinitialdelay = 1;
  entity.microwaveeffect = 0;
  shellshockscalar = 1;
  viewkickscalar = 1;
  damagescalar = 1;

  if(isplayer(entity) && entity hasperk(#"specialty_microwaveprotection")) {
    shellshockscalar = getdvarfloat(#"specialty_microwaveprotection_shellshock_scalar", 0.5);
    viewkickscalar = getdvarfloat(#"specialty_microwaveprotection_viewkick_scalar", 0.5);
    damagescalar = getdvarfloat(#"specialty_microwaveprotection_damage_scalar", 0.5);
  }

  turretweapon = getweapon(#"microwave_turret");

  while(true) {
    if(!isDefined(turret) || !turret microwaveturretaffectsentity(entity) || !isDefined(turret.trigger)) {
      if(!isDefined(entity)) {
        return;
      }

      entity.beingmicrowavedby[turret.turret_vehicle_entnum] = undefined;

      if(isDefined(entity.microwavepoisoning) && entity.microwavepoisoning) {
        entity.microwavepoisoning = 0;
      }

      entity notify(#"end_microwaveentitypostshutdowncleanup");
      return;
    }

    damage = 15 * damagescalar;

    if(level.hardcoremode) {
      damage /= 2;
    }

    if(!isai(entity) && entity util::mayapplyscreeneffect()) {
      if(!isDefined(entity.microwavepoisoning) || !entity.microwavepoisoning) {
        entity.microwavepoisoning = 1;
        entity.microwaveeffect = 0;
      }
    }

    if(isDefined(entity.microwavedamageinitialdelay)) {
      wait randomfloatrange(0.1, 0.3);
      entity.microwavedamageinitialdelay = undefined;
    }

    entity dodamage(damage, turret.origin, turret.owner, turret, 0, "MOD_TRIGGER_HURT", 0, turretweapon);
    entity.microwaveeffect++;
    entity.lastmicrowavedby = turret.owner;
    time = gettime();

    if(isplayer(entity) && !entity isremotecontrolling()) {
      if(time - (isDefined(entity.microwaveshellshockandviewkicktime) ? entity.microwaveshellshockandviewkicktime : 0) > 950) {
        if(entity.microwaveeffect % 2 == 1) {
          if(distancesquared(entity.origin, turret.origin) > 750 * 2 / 3 * 750 * 2 / 3) {
            entity shellshock(#"mp_radiation_low", 1.5 * shellshockscalar);
            entity viewkick(int(25 * viewkickscalar), turret.origin);
          } else if(distancesquared(entity.origin, turret.origin) > 750 * 1 / 3 * 750 * 1 / 3) {
            entity shellshock(#"mp_radiation_med", 1.5 * shellshockscalar);
            entity viewkick(int(50 * viewkickscalar), turret.origin);
          } else {
            entity shellshock(#"mp_radiation_high", 1.5 * shellshockscalar);
            entity viewkick(int(75 * viewkickscalar), turret.origin);
          }

          entity.microwaveshellshockandviewkicktime = time;
        }
      }
    }

    if(isplayer(entity) && entity.microwaveeffect % 3 == 2) {
      scoreevents::processscoreevent(#"hpm_suppress", turret.owner, entity, turretweapon);
    }

    wait 0.5;
  }
}

microwaveturretaffectsentity(entity) {
  turret = self;

  if(!isalive(entity)) {
    return false;
  }

  if(!isplayer(entity) && !isai(entity)) {
    return false;
  }

  if(entity.ignoreme === 1) {
    return false;
  }

  if(isDefined(turret.carried) && turret.carried) {
    return false;
  }

  if(turret weaponobjects::isstunned()) {
    return false;
  }

  if(isDefined(turret.owner) && entity == turret.owner) {
    return false;
  }

  if(!damage::friendlyfirecheck(turret.owner, entity, 0)) {
    return false;
  }

  if(distancesquared(entity.origin, turret.origin) > 750 * 750) {
    return false;
  }

  angles = turret gettagangles("tag_flash");
  origin = turret gettagorigin("tag_flash");
  shoot_at_pos = entity getshootatpos(turret);
  entdirection = vectornormalize(shoot_at_pos - origin);
  forward = anglesToForward(angles);
  dot = vectordot(entdirection, forward);

  if(dot < cos(15)) {
    return false;
  }

  if(entity damageconetrace(origin, turret, forward) <= 0) {
    return false;
  }

  return true;
}