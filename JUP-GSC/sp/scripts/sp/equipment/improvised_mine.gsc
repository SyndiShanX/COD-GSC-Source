/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\equipment\improvised_mine.gsc
*******************************************************/

#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#namespace improvised_mine;

function precache(offhand) {
  level.offhands.var_e1d317c7329ac2d2 = spawnStruct();
  level.offhands.var_e1d317c7329ac2d2.placedentities = [];
  registeroffhandfirefunc(offhand, &function_8a9f51e377f0e1af);
}

function function_8a9f51e377f0e1af(grenade, weapon) {
  if(!isDefined(grenade)) {
    return;
  }

  self notify("player_improvisedMinePlaced");
  thread function_f5964c57cc8da167(grenade, self, self.team, weapon);
}

function function_f5964c57cc8da167(grenade, mineowner, team, var_4fa68e590a2bcf6) {
  grenade endon("entitydeleted");
  grenade endon("death");
  mineowner endon("death");
  level.offhands.var_e1d317c7329ac2d2.placedentities = array_add(level.offhands.var_e1d317c7329ac2d2.placedentities, grenade);
  grenade.team = default_to(mineowner.team, team);
  grenade setentityowner(mineowner);
  grenade setotherent(mineowner);
  grenade makeunusable();
  grenade.targetname = "offhand_car_grenade";
  grenade waittill("missile_stuck");
  grenade setCanDamage(1);
  thread function_6e5ce23490c6fea6(grenade, var_4fa68e590a2bcf6, &"EQUIPMENT/IMPROVISED_MINE_PICKUP");
  grenade childthread function_d5b93c92c3f30a80(mineowner);
  grenade thread function_57abe555dd7dd3b8(mineowner);
}

function function_180c6f276018e945() {
  nearbyenemies = getaiarrayinradius(self.origin, 200, "axis");

  foreach(nearbyenemy in nearbyenemies) {
    if(!isDefined(nearbyenemy.stealth)) {
      continue;
    }

    nearbyenemy aieventlistenerevent("investigate", self, self.origin);
  }
}

function function_fc5ca7252f44256a(mineowner, var_ff882f75755f7367) {
  mineowner endon("death");
  mineowner endon("detonate");

  while(true) {
    scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 5), &"EQUIPMENT/IMPROVISED_MINE_PICKUP", 55, 100, 70, 0);
    childthread function_bb7d0fd0262d852d(&"EQUIPMENT/IMPROVISED_MINE_PICKUP", var_ff882f75755f7367);
    self waittill("trigger");
    pickedup = function_e2c7f0ed80637008(var_ff882f75755f7367);

    if(!pickedup) {
      continue;
    }

    if(isDefined(self)) {
      if(isDefined(self.trigger)) {
        self.trigger delete();
      }
    }

    self delete();
    return;
  }
}

function function_d5b93c92c3f30a80(mineowner) {
  self endon("entitydeleted");
  self.trigger = spawn("trigger_radius", self.origin, 23, 55, 72);
  wait 2;

  while(true) {
    self.trigger waittill("trigger", var_2087e4030aa793b);

    if(!is_equal(var_2087e4030aa793b.team, self.team)) {
      break;
    }

    if(!isDefined(var_2087e4030aa793b.velocity)) {
      continue;
    }

    if(!length(var_2087e4030aa793b.velocity)) {
      continue;
    }
  }

  thread function_5a73691d0868ca47(mineowner);
}

function function_57abe555dd7dd3b8(mineowner) {
  self endon("entitydeleted");
  mineowner endon("death");

  while(true) {
    self waittill("damage", null, attacker, null, null, meansofdeath);

    if(!isPlayer(attacker)) {
      continue;
    }

    if(meansofdeath == "MOD_MELEE") {
      continue;
    }

    if(meansofdeath == "MOD_IMPACT" && is_equal(attacker.team, self.team)) {
      continue;
    }

    thread function_5a73691d0868ca47(attacker);
    break;
  }
}

function function_5a73691d0868ca47(attacker) {
  earthquake(0.25, 0.35, self.origin, 1000);
  playrumbleonposition("grenade_rumble", self.origin);

  if(scripts\engine\trace::ray_trace_passed(self.origin, level.player getEye(), self, scripts\engine\trace::create_world_contents())) {
    playerdistancesquared = distancesquared(level.player.origin, self.origin);

    if(playerdistancesquared <= 10000) {
      level.player do_damage(99999, self.origin, attacker, self, "MOD_EXPLOSIVE");
    } else if(playerdistancesquared <= 16900) {
      level.player shellshock("default_nosound", 2);
    }
  }

  enemies = getaiarrayinradius(self.origin, 350);

  foreach(enemy in enemies) {
    enemy do_damage(2000, self.origin, attacker, self, "MOD_EXPLOSIVE");
  }

  if(isDefined(self)) {
    if(isDefined(self.trigger)) {
      self.trigger delete();
    }

    function_dc31ef5a2d33be25();
    scripts\sp\player\cursor_hint::remove_cursor_hint();
    self detonate();
  }

  broadcaststealthevent(attacker, "explosion");
}

function function_dc31ef5a2d33be25() {
  level.offhands.var_e1d317c7329ac2d2.placedentities = array_remove(level.offhands.var_e1d317c7329ac2d2.placedentities, self);
}