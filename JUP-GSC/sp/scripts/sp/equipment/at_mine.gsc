/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\equipment\at_mine.gsc
***********************************************/

#using scripts\common\vehicle;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#namespace at_mine;

function precache(offhand) {
  level.offhands.atmine = spawnStruct();
  level.offhands.atmine.placedentities = [];
  registeroffhandfirefunc(offhand, &function_6ff21d428c0f908a);
}

function function_6ff21d428c0f908a(grenade, weapon) {
  if(!isDefined(grenade)) {
    return;
  }

  self notify("player_ATMinePlaced");
  thread atminewatchstuck(grenade, self, self.team, weapon);
}

function atminewatchstuck(grenade, mineowner, team, ownerweaponobj) {
  grenade endon("entitydeleted");
  grenade endon("death");
  flag_wait("scriptables_ready");
  grenade setscriptablepartstate("visibility", "show", 0);
  grenade setscriptablepartstate("floats", "hide", 0);
  level.offhands.atmine.placedentities = array_add(level.offhands.atmine.placedentities, grenade);

  if(isDefined(mineowner)) {
    grenade.team = default_to(mineowner.team, team);
    grenade setentityowner(mineowner);
    grenade setotherent(mineowner);
  } else {
    grenade.team = default_to(team, "axis");
  }

  grenade makeunusable();
  grenade.targetname = "offhand_car_grenade";
  grenade.in_water = 0;
  grenade childthread function_427845ab37c184cd();
  grenade waittill("missile_stuck");

  if(isDefined(grenade)) {
    grenade setscriptablepartstate("plant", "active", 0);
    grenade setCanDamage(1);

    if(isPlayer(mineowner)) {
      mineowner setscriptablepartstate("equipATMineFXView", "plant", 0);
    }

    wait 2;

    if(isDefined(grenade)) {
      grenade notify("missile_stuck_land");

      if(isPlayer(mineowner)) {
        mineowner thread function_6e5ce23490c6fea6(grenade, ownerweaponobj, &"EQUIPMENT/IMPROVISED_MINE_PICKUP");
      }

      grenade thread function_285754702166e469(mineowner);
      grenade childthread function_22846f2eee7f6a8d(mineowner);
    }
  }
}

function function_5d168aee5b11f8eb() {
  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 8), &"EQUIPMENT/IMPROVISED_MINE_PICKUP", 55, 100, 70, 0);
}

function function_427845ab37c184cd() {
  self endon("missile_stuck_land");
  self waittill("missile_water_impact");
  self setscriptablepartstate("floats", "show", 0);
  self.in_water = 1;
}

function function_f926047e96a9a040() {
  nearbyenemies = getaiarrayinradius(self.origin, 200, "axis");

  foreach(nearbyenemy in nearbyenemies) {
    if(!isDefined(nearbyenemy.stealth)) {
      continue;
    }

    nearbyenemy aieventlistenerevent("investigate", self, self.origin);
  }
}

function function_22846f2eee7f6a8d(mineowner) {
  self setscriptablepartstate("arm", "active", 0);
  var_2087e4030aa793b = undefined;

  while(isDefined(self)) {
    self waittill("trigger_grenade", var_2087e4030aa793b);

    if(!is_equal(var_2087e4030aa793b.team, self.team)) {
      if(istrue(self.in_water)) {
        break;
      }

      if(isDefined(var_2087e4030aa793b)) {
        dist = distancesquared(self.origin, var_2087e4030aa793b.origin);

        if(dist < 3025) {
          break;
        }
      }
    }
  }

  thread atmineexplode(default_to(mineowner, var_2087e4030aa793b));
}

function function_285754702166e469(mineowner) {
  self endon("death");
  self.health = 99999;

  while(true) {
    self waittill("damage", null, attacker, null, null, meansofdeath);

    if(isPlayer(mineowner) && !isPlayer(attacker)) {
      continue;
    }

    if(meansofdeath == "MOD_MELEE") {
      continue;
    }

    if(meansofdeath == "MOD_IMPACT" && is_equal(attacker.team, self.team)) {
      continue;
    }

    thread atmineexplode(attacker);
    break;
  }
}

function atmineexplode(attacker) {
  playsoundatpos(self.origin + (0, 0, 20), "minefield_click");
  wait 0.35;

  if(isDefined(self)) {
    scripts\sp\player\cursor_hint::remove_cursor_hint();
    self clearscriptabledamageowner();
    self setscriptablepartstate("arm", "neutral", 0);
    self setscriptablepartstate("hacked", "neutral", 0);
    self setscriptablepartstate("launch", "neutral", 0);
    self setscriptablepartstate("trigger", "neutral", 0);

    if(isDefined(attacker)) {
      if(attacker scripts\common\vehicle::isvehicle()) {
        self setscriptablepartstate("explode", "fromVehicle", 0);
      } else if(isPlayer(attacker)) {
        self setscriptablepartstate("explode", "fromPlayer", 0);
      } else {
        self setscriptablepartstate("explode", "fromDamage", 0);
      }
    } else {
      self setscriptablepartstate("explode", "fromDamage", 0);
    }

    wait 3;

    if(isDefined(self)) {
      self delete();
    }
  }
}

function function_c32ae958d66a887c() {
  level.offhands.atmine.placedentities = array_remove(level.offhands.atmine.placedentities, self);
}