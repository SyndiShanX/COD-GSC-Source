/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_empgrenade.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

init() {
  precacheshellshock("flashbang");
  precachestring(&"hud_flicker");
}

monitorempgrenade() {
  self endon("disconnect");
  self endon("death");

  while(true) {
    self waittill("emp_grenaded", attacker);

    if(!isalive(self)) {
      continue;
    }
    self thread applyemp();
  }
}

emphudflickeron() {
  luinotifyevent(&"hud_flicker", 1, 4500);
}

emphudflickeroff() {
  luinotifyevent(&"hud_flicker", 1, -1);
}

applyemp() {
  self notify("applyEmp");
  self endon("applyEmp");
  self endon("disconnect");
  self endon("death");
  wait 0.05;
  self.empgrenaded = 1;
  self shellshock("flashbang", 1);
  self thread emprumbleloop(0.75);
  self setempjammed(1);
  rpc("clientscripts/_empgrenade", "emp_filter_over_time", 5);
  emphudflickeron();
  setsaveddvar("cg_drawCrosshair", 0);
  self thread empgrenadedeathwaiter();
  self thread checktoturnoffemp();
}

empgrenadedeathwaiter() {
  self notify("empGrenadeDeathWaiter");
  self endon("empGrenadeDeathWaiter");
  self endon("empGrenadeTimedOut");
  self waittill("death");
  self checktoturnoffemp();
}

checktoturnoffemp() {
  self endon("disconnect");
  self endon("death");
  self waittill_notify_or_timeout("empGrenadeShutOff", 5);
  emphudflickeroff();
  self notify("empGrenadeTimedOut");
  self.empgrenaded = 0;
  self setempjammed(0);
  rpc("clientscripts/_empgrenade", "emp_filter_off");
  setsaveddvar("cg_drawCrosshair", 1);
}

emprumbleloop(duration) {
  self endon("emp_rumble_loop");
  self notify("emp_rumble_loop");
  goaltime = gettime() + duration * 1000;

  while(gettime() < goaltime) {
    self playrumbleonentity("damage_heavy");
    wait 0.05;
  }
}