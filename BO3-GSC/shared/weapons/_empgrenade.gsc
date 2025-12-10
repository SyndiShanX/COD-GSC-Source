/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_empgrenade.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace empgrenade;

function autoexec __init__sytem__() {
  system::register("empgrenade", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "empd", 1, 1, "int");
  clientfield::register("toplayer", "empd_monitor_distance", 1, 1, "int");
  callback::on_spawned(&on_player_spawned);
}

function on_player_spawned() {
  self endon("disconnect");
  self thread monitorempgrenade();
  self thread begin_other_grenade_tracking();
}

function monitorempgrenade() {
  self endon("disconnect");
  self endon("death");
  self endon("killempmonitor");
  self.empendtime = 0;
  while(true) {
    self waittill("emp_grenaded", attacker, explosionpoint);
    if(!isalive(self) || self hasperk("specialty_immuneemp")) {
      continue;
    }
    hurtvictim = 1;
    hurtattacker = 0;
    assert(isDefined(self.team));
    if(level.teambased && isDefined(attacker) && isDefined(attacker.team) && attacker.team == self.team && attacker != self) {
      friendlyfire = [
        [level.figure_out_friendly_fire]
      ](self);
      if(friendlyfire == 0) {
        continue;
      } else {
        if(friendlyfire == 1) {
          hurtattacker = 0;
          hurtvictim = 1;
        } else {
          if(friendlyfire == 2) {
            hurtvictim = 0;
            hurtattacker = 1;
          } else if(friendlyfire == 3) {
            hurtattacker = 1;
            hurtvictim = 1;
          }
        }
      }
    }
    if(hurtvictim && isDefined(self)) {
      self thread applyemp(attacker, explosionpoint);
    }
    if(hurtattacker && isDefined(attacker)) {
      attacker thread applyemp(attacker, explosionpoint);
    }
  }
}

function applyemp(attacker, explosionpoint) {
  self notify("applyemp");
  self endon("applyemp");
  self endon("disconnect");
  self endon("death");
  wait(0.05);
  if(!(isDefined(self) && isalive(self))) {
    return;
  }
  if(self == attacker) {
    currentempduration = 1;
  } else {
    distancetoexplosion = distance(self.origin, explosionpoint);
    ratio = 1 - (distancetoexplosion / 425);
    currentempduration = 3 + (3 * ratio);
  }
  if(isDefined(self.empendtime)) {
    emp_time_left_ms = self.empendtime - gettime();
    if(emp_time_left_ms > (currentempduration * 1000)) {
      self.empduration = emp_time_left_ms / 1000;
    } else {
      self.empduration = currentempduration;
    }
  } else {
    self.empduration = currentempduration;
  }
  self.empgrenaded = 1;
  self shellshock("emp_shock", 1);
  self clientfield::set_to_player("empd", 1);
  self.empstarttime = gettime();
  self.empendtime = self.empstarttime + (self.empduration * 1000);
  self.empedby = attacker;
  shutdownemprebootindicatormenu();
  emprebootmenu = self openluimenu("EmpRebootIndicator");
  self setluimenudata(emprebootmenu, "endTime", int(self.empendtime));
  self setluimenudata(emprebootmenu, "startTime", int(self.empstarttime));
  self thread emprumbleloop(0.75);
  self setempjammed(1);
  self thread empgrenadedeathwaiter();
  self thread empgrenadecleansewaiter();
  if(self.empduration > 0) {
    wait(self.empduration);
  }
  if(isDefined(self)) {
    self notify("empgrenadetimedout");
    self checktoturnoffemp();
  }
}

function empgrenadedeathwaiter() {
  self notify("empgrenadedeathwaiter");
  self endon("empgrenadedeathwaiter");
  self endon("empgrenadetimedout");
  self waittill("death");
  if(isDefined(self)) {
    self checktoturnoffemp();
  }
}

function empgrenadecleansewaiter() {
  self notify("empgrenadecleansewaiter");
  self endon("empgrenadecleansewaiter");
  self endon("empgrenadetimedout");
  self waittill("gadget_cleanse_on");
  if(isDefined(self)) {
    self checktoturnoffemp();
  }
}

function checktoturnoffemp() {
  if(isDefined(self)) {
    self.empgrenaded = 0;
    shutdownemprebootindicatormenu();
    if(self killstreaks::emp_isempd()) {
      return;
    }
    self setempjammed(0);
    self clientfield::set_to_player("empd", 0);
  }
}

function shutdownemprebootindicatormenu() {
  emprebootmenu = self getluimenu("EmpRebootIndicator");
  if(isDefined(emprebootmenu)) {
    self closeluimenu(emprebootmenu);
  }
}

function emprumbleloop(duration) {
  self endon("emp_rumble_loop");
  self notify("emp_rumble_loop");
  goaltime = gettime() + (duration * 1000);
  while(gettime() < goaltime) {
    self playrumbleonentity("damage_heavy");
    wait(0.05);
  }
}

function watchempexplosion(owner, weapon) {
  owner endon("disconnect");
  owner endon("team_changed");
  self endon("trophy_destroyed");
  owner addweaponstat(weapon, "used", 1);
  self waittill("explode", origin, surface);
  level empexplosiondamageents(owner, weapon, origin, 425, 1);
}

function empexplosiondamageents(owner, weapon, origin, radius, damageplayers) {
  ents = getdamageableentarray(origin, radius);
  if(!isDefined(damageplayers)) {
    damageplayers = 1;
  }
  foreach(ent in ents) {
    if(!damageplayers && isplayer(ent)) {
      continue;
    }
    ent dodamage(1, origin, owner, owner, "none", "MOD_GRENADE_SPLASH", 0, weapon);
  }
}

function begin_other_grenade_tracking() {
  self endon("death");
  self endon("disconnect");
  self notify("emptrackingstart");
  self endon("emptrackingstart");
  for(;;) {
    self waittill("grenade_fire", grenade, weapon, cooktime);
    if(grenade util::ishacked()) {
      continue;
    }
    if(weapon.isemp) {
      grenade thread watchempexplosion(self, weapon);
    }
  }
}