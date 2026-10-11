/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\equipment\gas_trap.gsc
************************************************/

#using scripts\anim\face;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#namespace gas_trap;

function precache(offhand) {
  level.offhands.gastrap = spawnStruct();
  level.offhands.gastrap.placedentities = [];
  registeroffhandfirefunc(offhand, &function_6d77cb0b51cbbb04);
}

function function_6d77cb0b51cbbb04(grenade, weapon) {
  if(!isDefined(grenade)) {
    return;
  }

  self notify("player_gasTrapPlaced");
  thread function_d66e2c658314e5ac(grenade, self, self.team, weapon);
}

function function_d66e2c658314e5ac(grenade, mineowner, team, ownerweaponobj) {
  grenade endon("entitydeleted");
  grenade endon("death");
  grenade setentityowner(mineowner);
  grenade setotherent(mineowner);
  grenade makeunusable();
  grenade.targetname = "offhand_car_grenade";
  var_ce3e248b427582f1 = grenade.model;
  grenade waittill("missile_stuck", stuckto, var_75ac1fbce3945650, surfacetype, velocity, position, hitnormal);
  thread function_6e5ce23490c6fea6(grenade, ownerweaponobj, &"EQUIPMENT/IMPROVISED_MINE_PICKUP");
  childthread function_c79a9033e727667f(grenade, mineowner, team);
  childthread function_1e004fb8a230e0b(grenade);
  level.offhands.gastrap.placedentities = array_add(level.offhands.gastrap.placedentities, grenade);
}

function function_601bfa752385fed2(grenade, mineowner) {
  nearbyenemies = getaiarrayinradius(grenade.origin, 200, "axis");

  foreach(nearbyenemy in nearbyenemies) {
    if(!isDefined(nearbyenemy.stealth)) {
      continue;
    }

    nearbyenemy aieventlistenerevent("investigate", grenade, grenade.origin);
  }
}

function function_5f0f344f30a1f4b(grenade, mineowner, var_ff882f75755f7367) {
  mineowner endon("death");

  while(true) {
    interact = spawnStruct();
    interact.origin = grenade.origin + (0, 0, 5);
    interact scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"EQUIPMENT/IMPROVISED_MINE_PICKUP", 55, 100, 70, 0);
    thread function_922f5f6ae49a1314(grenade, interact);
    event = function_7b9e0e7ca4b3b940(grenade, "entitydeleted", interact, "trigger");

    if(event == "trigger") {
      if(isDefined(level.offhands.getammooverridefunctions["gas_trap"])) {
        currentammo = [[level.offhands.getammooverridefunctions["gas_trap"]]]("gas_trap");
      } else {
        currentammo = level.player getweaponammoclip(var_ff882f75755f7367);
      }

      if(currentammo < 4) {
        level.player thread play_sound_on_entity("weap_pickup");
        level.player notify("player_gasTrapPickedUp");
        level.player give_offhand(var_ff882f75755f7367.basename, currentammo + 1);
        function_d05d967e8630a32a(grenade);
        grenade delete();
        break;
      }

      continue;
    }

    interact notify("entitydeleted");
    break;
  }
}

function function_922f5f6ae49a1314(grenade, interact) {
  grenade endon("entitydeleted");
  interact endon("trigger");

  if(isDefined(level.offhands.getammooverridefunctions["gas_trap"])) {
    currentammo = [[level.offhands.getammooverridefunctions["gas_trap"]]]("gas_trap");
  } else {
    currentammo = level.player getweaponammoclip("gas_trap");
  }

  previousammo = currentammo;

  if(currentammo >= 4) {
    interact.cursor_hint_ent setHintString(&"EQUIPMENT/FULL");
  } else {
    interact.cursor_hint_ent setHintString(&"EQUIPMENT/IMPROVISED_MINE_PICKUP");
  }

  while(true) {
    if(isDefined(level.offhands.getammooverridefunctions["gas_trap"])) {
      currentammo = [[level.offhands.getammooverridefunctions["gas_trap"]]]("gas_trap");
    } else {
      currentammo = level.player getweaponammoclip("gas_trap");
    }

    if(currentammo != previousammo) {
      if(currentammo >= 4) {
        interact.cursor_hint_ent setHintString(&"EQUIPMENT/FULL");
      } else {
        interact.cursor_hint_ent setHintString(&"EQUIPMENT/IMPROVISED_MINE_PICKUP");
      }
    }

    previousammo = currentammo;
    waitframe();
  }
}

function function_c79a9033e727667f(grenade, mineowner, team) {
  grenade endon("entitydeleted");
  grenade.trigger = spawn("trigger_radius", grenade.origin, 15, 55, 72);
  wait 2;
  var_2087e4030aa793b = undefined;

  while(true) {
    grenade.trigger waittill("trigger", var_2087e4030aa793b);

    if(!is_equal(var_2087e4030aa793b.team, team)) {
      break;
    }

    if(!isDefined(var_2087e4030aa793b.velocity)) {
      continue;
    }

    if(!length(var_2087e4030aa793b.velocity)) {
      continue;
    }
  }

  grenade.trigger delete();
  thread function_d27019e6b9fd97be(grenade, mineowner);
}

function function_1e004fb8a230e0b(grenade) {
  grenade endon("entitydeleted");
  scriptmodel = spawn("script_model", grenade.origin);
  scriptmodel.angles = grenade.angles;
  scriptmodel setModel(grenade.model);
  scriptmodel setCanDamage(1);
  scriptmodel.maxhealth = 100000;
  scriptmodel.health = scriptmodel.maxhealth;
  thread function_b0930d0f316c2785(grenade, scriptmodel);

  while(true) {
    scriptmodel waittill("damage", null, attacker, null, null, meansofdeath);

    if(!isPlayer(attacker)) {
      continue;
    }

    if(meansofdeath == "MOD_MELEE") {
      continue;
    }

    thread function_d27019e6b9fd97be(grenade, attacker);
    break;
  }
}

function function_b0930d0f316c2785(grenade, scriptmodel) {
  grenade waittill("entitydeleted");
  scriptmodel delete();
}

function function_d27019e6b9fd97be(grenade, mineowner) {
  earthquake(0.25, 0.35, grenade.origin, 1000);
  playrumbleonposition("grenade_rumble", grenade.origin);
  playerdistancesquared = distancesquared(level.player.origin, grenade.origin);

  if(playerdistancesquared <= 22500) {
    thread function_14dd7fe1d23f9dc3("iw9_ges_gas_cough_long", grenade.origin, "gas_trap", 150);
  }

  enemies = getaiarrayinradius(grenade.origin, 350, "axis");

  foreach(enemy in enemies) {
    enemy notify("flashbang", grenade.origin, 1, 1, mineowner, "allies", 9);
    enemy thread function_955e0e9b64ac2b2f(mineowner);
  }

  if(isDefined(grenade.trigger)) {
    grenade.trigger delete();
  }

  function_d05d967e8630a32a(grenade);
  grenade detonate();
}

function function_d05d967e8630a32a(gastrap) {
  level.offhands.gastrap.placedentities = array_remove(level.offhands.gastrap.placedentities, gastrap);
}

function function_955e0e9b64ac2b2f(mineowner) {
  self notify("stop_gasTrapEffects");
  self endon("stop_gasTrapEffects");
  self endon("death");
  scripts\anim\face::saygenericdialogue("cough_fit");
  self.var_d7a3873a03947a34 = gettime();

  while(true) {
    waitframe();

    if(self isinscriptedstate()) {
      continue;
    }

    if(isflashed()) {
      self.var_d7a3873a03947a34 = gettime();
      continue;
    }

    if(time_has_passed(self.var_d7a3873a03947a34, 15)) {
      self notify("flashbang", self.origin, 1, 1, mineowner, "allies", 3);
      scripts\anim\face::saygenericdialogue("cough_fit");
      self.var_d7a3873a03947a34 = gettime();
    }
  }
}