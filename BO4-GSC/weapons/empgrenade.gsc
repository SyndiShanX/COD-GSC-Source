/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\empgrenade.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace empgrenade;

autoexec __init__system__() {
  system::register(#"empgrenade", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "empd", 1, 1, "int");
  clientfield::register("toplayer", "empd_monitor_distance", 1, 1, "int");
  callback::on_spawned(&on_player_spawned);
}

on_player_spawned() {
  self endon(#"disconnect");
  self thread monitorempgrenade();
}

monitorempgrenade() {
  self endon(#"disconnect", #"death", #"killempmonitor");
  self.empendtime = 0;

  while(true) {
    waitresult = self waittill(#"emp_grenaded");
    attacker = waitresult.attacker;
    explosionpoint = waitresult.position;

    if(!isalive(self) || self hasperk(#"specialty_immuneemp")) {
      continue;
    }

    hurtvictim = 1;
    hurtattacker = 0;
    assert(isDefined(self.team));

    if(level.teambased && isDefined(attacker) && isDefined(attacker.team) && !util::function_fbce7263(attacker.team, self.team) && attacker != self) {
      friendlyfire = [
        [level.figure_out_friendly_fire]
      ](self, attacker);

      if(friendlyfire == 0) {
        continue;
      } else if(friendlyfire == 1) {
        hurtattacker = 0;
        hurtvictim = 1;
      } else if(friendlyfire == 2) {
        hurtvictim = 0;
        hurtattacker = 1;
      } else if(friendlyfire == 3) {
        hurtattacker = 1;
        hurtvictim = 1;
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

applyemp(attacker, explosionpoint) {
  self notify(#"applyemp");
  self endon(#"applyemp", #"disconnect", #"death");
  waitframe(1);

  if(!(isDefined(self) && isalive(self))) {
    return;
  }

  if(self == attacker) {
    currentempduration = 1;
  } else {
    distancetoexplosion = distance(self.origin, explosionpoint);
    ratio = 1 - distancetoexplosion / 425;
    currentempduration = 3 + 3 * ratio;
  }

  if(isDefined(self.empendtime)) {
    emp_time_left_ms = self.empendtime - gettime();

    if(emp_time_left_ms > int(currentempduration * 1000)) {
      self.empduration = float(emp_time_left_ms) / 1000;
    } else {
      self.empduration = currentempduration;
    }
  } else {
    self.empduration = currentempduration;
  }

  self.empgrenaded = 1;
  self shellshock(#"emp_shock", 1);
  self clientfield::set_to_player("empd", 1);
  self.empstarttime = gettime();
  self.empendtime = self.empstarttime + int(self.empduration * 1000);
  self.empedby = attacker;
  shutdownemprebootindicatormenu();
  emprebootmenu = self openluimenu("EmpRebootIndicator");
  self setluimenudata(emprebootmenu, #"endtime", int(self.empendtime));
  self setluimenudata(emprebootmenu, #"starttime", int(self.empstarttime));
  self thread emprumbleloop(0.75);
  self setempjammed(1);
  self thread empgrenadedeathwaiter();

  if(self.empduration > 0) {
    wait self.empduration;
  }

  if(isDefined(self)) {
    self notify(#"empgrenadetimedout");
    self checktoturnoffemp();
  }
}

empgrenadedeathwaiter() {
  self notify(#"empgrenadedeathwaiter");
  self endon(#"empgrenadedeathwaiter", #"empgrenadetimedout");
  self waittill(#"death", #"hash_3ffb993d40af48ca");

  if(isDefined(self)) {
    self checktoturnoffemp();
  }
}

checktoturnoffemp() {
  if(isDefined(self)) {
    self.empgrenaded = 0;
    shutdownemprebootindicatormenu();

    if(isDefined(level.emp_shared.enemyempactivefunc)) {
      if(self[[level.emp_shared.enemyempactivefunc]]()) {
        return;
      }
    }

    self setempjammed(0);
    self clientfield::set_to_player("empd", 0);
  }
}

shutdownemprebootindicatormenu() {
  emprebootmenu = self getluimenu("EmpRebootIndicator");

  if(isDefined(emprebootmenu)) {
    self closeluimenu(emprebootmenu);
  }
}

emprumbleloop(duration) {
  self endon(#"emp_rumble_loop");
  self notify(#"emp_rumble_loop");
  goaltime = gettime() + int(duration * 1000);

  while(gettime() < goaltime) {
    self playrumbleonentity("damage_heavy");
    waitframe(1);
  }
}

watchempexplosion(owner, weapon) {
  owner endon(#"disconnect", #"team_changed");
  self endon(#"trophy_destroyed");
  owner stats::function_e24eec31(weapon, #"used", 1);
  waitresult = self waittill(#"explode", #"death");

  if(waitresult._notify == "explode") {
    level empexplosiondamageents(owner, weapon, waitresult.position, 425, 1);
  }
}

empexplosiondamageents(owner, weapon, origin, radius, damageplayers) {
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

event_handler[grenade_fire] function_b18444ea(eventstruct) {
  if(!isplayer(self)) {
    return;
  }

  grenade = eventstruct.projectile;
  weapon = eventstruct.weapon;

  if(grenade util::ishacked()) {
    return;
  }

  if(weapon.isemp) {
    grenade thread watchempexplosion(self, weapon);
  }
}