/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_smokegrenade.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_tacticalinsertion;
#using scripts\shared\weapons\_weaponobjects;
#namespace smokegrenade;

function init_shared() {
  level.willypetedamageradius = 300;
  level.willypetedamageheight = 128;
  level.smokegrenadeduration = 8;
  level.smokegrenadedissipation = 4;
  level.smokegrenadetotaltime = level.smokegrenadeduration + level.smokegrenadedissipation;
  level.fx_smokegrenade_single = "smoke_center";
  level.smoke_grenade_triggers = [];
  callback::on_spawned( & on_player_spawned);
}

function watchsmokegrenadedetonation(owner, statweapon, grenadeweaponname, duration, totaltime) {
  self endon("trophy_destroyed");
  owner addweaponstat(statweapon, "used", 1);
  self waittill("explode", position, surface);
  onefoot = vectorscale((0, 0, 1), 12);
  startpos = position + onefoot;
  smokeweapon = getweapon(grenadeweaponname);
  smokedetonate(owner, statweapon, smokeweapon, position, 128, totaltime, duration);
  damageeffectarea(owner, startpos, smokeweapon.explosionradius, level.willypetedamageheight, undefined);
}

function smokedetonate(owner, statweapon, smokeweapon, position, radius, effectlifetime, smokeblockduration) {
  dir_up = (0, 0, 1);
  ent = spawntimedfx(smokeweapon, position, dir_up, effectlifetime);
  ent setteam(owner.team);
  ent setowner(owner);
  ent thread smokeblocksight(radius);
  ent thread spawnsmokegrenadetrigger(smokeblockduration);
  if(isDefined(owner)) {
    owner.smokegrenadetime = gettime();
    owner.smokegrenadeposition = position;
  }
  thread playsmokesound(position, smokeblockduration, statweapon.projsmokestartsound, statweapon.projsmokeendsound, statweapon.projsmokeloopsound);
  return ent;
}

function damageeffectarea(owner, position, radius, height, killcament) {
  effectarea = spawn("trigger_radius", position, 0, radius, height);
  if(isDefined(level.dogsonflashdogs)) {
    owner thread[[level.dogsonflashdogs]](effectarea);
  }
  effectarea delete();
}

function smokeblocksight(radius) {
  self endon("death");
  while(true) {
    fxblocksight(self, radius);
    if(getdvarint("", 0)) {
      sphere(self.origin, 128, (1, 0, 0), 0.25, 0, 10, 15);
    }
    wait(0.75);
  }
}

function spawnsmokegrenadetrigger(duration) {
  team = self.team;
  trigger = spawn("trigger_radius", self.origin, 0, 128, 128);
  if(!isDefined(level.smoke_grenade_triggers)) {
    level.smoke_grenade_triggers = [];
  } else if(!isarray(level.smoke_grenade_triggers)) {
    level.smoke_grenade_triggers = array(level.smoke_grenade_triggers);
  }
  level.smoke_grenade_triggers[level.smoke_grenade_triggers.size] = trigger;
  self util::waittill_any_timeout(duration, "death");
  arrayremovevalue(level.smoke_grenade_triggers, trigger);
  trigger delete();
}

function isinsmokegrenade() {
  foreach(trigger in level.smoke_grenade_triggers) {
    if(self istouching(trigger)) {
      return true;
    }
  }
  return false;
}

function on_player_spawned() {
  self endon("disconnect");
  self thread begin_other_grenade_tracking();
}

function begin_other_grenade_tracking() {
  self endon("death");
  self endon("disconnect");
  self notify("smoketrackingstart");
  self endon("smoketrackingstart");
  weapon_smoke = getweapon("willy_pete");
  for(;;) {
    self waittill("grenade_fire", grenade, weapon, cooktime);
    if(grenade util::ishacked()) {
      continue;
    }
    if(weapon.rootweapon == weapon_smoke) {
      grenade thread watchsmokegrenadedetonation(self, weapon_smoke, level.fx_smokegrenade_single, level.smokegrenadeduration, level.smokegrenadetotaltime);
    }
  }
}

function playsmokesound(position, duration, startsound, stopsound, loopsound) {
  smokesound = spawn("script_origin", (0, 0, 1));
  smokesound.origin = position;
  if(isDefined(startsound)) {
    smokesound playSound(startsound);
  }
  if(isDefined(loopsound)) {
    smokesound playLoopSound(loopsound);
  }
  if(duration > 0.5) {
    wait(duration - 0.5);
  }
  if(isDefined(stopsound)) {
    thread sound::play_in_space(stopsound, position);
  }
  smokesound stoploopsound(0.5);
  wait(0.5);
  smokesound delete();
}