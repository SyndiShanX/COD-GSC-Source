/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\equipment\cp_thermite.gsc
***************************************************/

#using scripts\common\utility;
#using scripts\cp\cp_weapons;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#namespace cp_thermite;

function thermite_used(grenade, isgl, var_d4fbc5be3b7d6578) {
  if(isDefined(isgl)) {
    glgrenade = grenade;
    grenade = self launchgrenade("thermite_mp", glgrenade.origin, (0, 0, 0));
    grenade.glgrenade = glgrenade;
    grenade.angles = glgrenade.angles;
    grenade.owner = self;
    grenade.classname = "thermite_mp";
    grenade linkTo(glgrenade);
    grenade setscriptablepartstate("visibility", "hide", 0);
  }

  grenade.grenade_owner_name = self.name;
  grenade thread thermite_watchdisowned();
  grenade thread thermite_watchstuck(isgl, var_d4fbc5be3b7d6578);
}

function thermite_watchstuck(isgl, var_d4fbc5be3b7d6578) {
  self endon("death");
  self.ignore_fire_armor_check = 1;
  stuckto = undefined;

  if(istrue(isgl)) {
    glstuck = thermite_watchglstuck();

    if(!istrue(glstuck)) {
      thread thermite_delete();
      return;
    }

    if(isDefined(self.glgrenade)) {
      self.glgrenade delete();
    }
  } else {
    if(isDefined(self.owner)) {
      self.owner thread thermite_watchwater(self);
    }

    self waittill("missile_stuck", stuckto, stuckpart);

    if(istrue(var_d4fbc5be3b7d6578)) {
      thermite_linktostuck(stuckto, stuckpart);
    }
  }

  level notify("grenade_exploded_during_stealth", self, "thermite_mp", self.grenade_owner_name);

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  if(!istrue(isgl)) {
    if(isDefined(stuckto) && !isPlayer(stuckto)) {
      thread scripts\cp\weapon::function_4af015619e2534ba(stuckto, &thermite_destroy, 0);
    }
  }

  thread thermite_watchstucktoterrain();
  self setscriptablepartstate("effects", "impact", 0);
  self setscriptablepartstate("damage", "impact", 0);
  weaponobj = makeweapon("thermite_mp");
  thermite_doradiusdamage(weaponobj);
  wait 0.5;
  var_dcba62ab4b6154ed = makeweapon("thermite_av_mp");
  var_dcba5cab4b6147bb = makeweapon("thermite_ap_mp");
  ticks = 1;

  while(ticks <= 10) {
    curtick = ticks + 1;

    if(mod(curtick, 2) > 0) {
      thermite_doradiusdamage(var_dcba62ab4b6154ed);
    } else {
      thermite_doradiusdamage(var_dcba5cab4b6147bb);
    }

    ticks = curtick;
    wait 0.5;
  }

  thread thermite_destroy();
}

function thermite_doradiusdamage(weaponobj) {
  radius = 125;
  innerdamage = 25;
  outerdamage = 10;
  meansofdeath = "MOD_FIRE";

  if(weaponobj.basename == "thermite_mp") {
    radius = 125;
    innerdamage = 30;
    outerdamage = 30;
  }

  stuckto = self.stuckenemyentity;

  if(isDefined(stuckto)) {
    if(isPlayer(stuckto) && scripts\cp_mp\utility\player_utility::isreallyalive(stuckto)) {
      stuckto dodamage(innerdamage, self.origin, self.owner, self, meansofdeath, weaponobj, "torso_upper");
      stuckto scripts\cp_mp\utility\damage_utility::adddamagemodifier("thermiteStuck", 0, 0, &thermite_damagemodifierignorefunc);
    } else {
      stuckto = undefined;
    }
  }

  self radiusdamage(self.origin, radius, innerdamage, outerdamage, self.owner, meansofdeath, weaponobj);

  if(isDefined(stuckto)) {
    stuckto scripts\cp_mp\utility\damage_utility::removedamagemodifier("thermiteStuck", 0);
  }
}

function thermite_watchwater(grenade) {
  grenade endon("missile_stuck");
  thrownunderwater = 0;

  if(scripts\cp_mp\utility\player_utility::isswimmingunderwater()) {
    thrownunderwater = 1;
  }

  grenade waittill("missile_water_impact");

  if(!thrownunderwater) {
    grenade notify("missile_stuck");
  }
}

function thermite_damagemodifierignorefunc(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(!isDefined(inflictor)) {
    return true;
  }

  if(!isDefined(inflictor.weapon_name) || inflictor.weapon_name != "thermite_mp") {
    return true;
  }

  if(!isDefined(inflictor.stuckenemyentity) || inflictor.stuckenemyentity != victim) {
    return true;
  }

  return false;
}

function thermite_watchglstuck() {
  self.glgrenade endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  self.glgrenade waittill("missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal);
  thermite_linktostuck(stuckto, stuckpart);
  return true;
}

function thermite_watchstucktoterrain() {
  self endon("death");
  stuckto = self getlinkedparent();

  while(isDefined(stuckto)) {
    self waittill("missile_stuck", stuckto);
  }

  self.badplace = createnavbadplacebybounds(self.origin, (125, 125, 125), (0, 0, 0));
}

function thermite_linktostuck(stuckto, stuckpart) {
  if(isDefined(stuckto)) {
    if(isPlayer(stuckto) || isagent(stuckto)) {
      if(stuckto scripts\cp_mp\utility\player_utility::_isalive()) {
        if(isDefined(stuckpart)) {
          self linkTo(stuckto, stuckpart);
        } else {
          self linkTo(stuckto, "j_spine", (0, 0, 0));
        }

        if(isPlayer(stuckto)) {
          stuckto thread scripts\cp\cp_weapons::enableburnfxfortime(0.6);
        }
      }

      return;
    }

    if(isDefined(stuckpart)) {
      self linkTo(stuckto, stuckpart);
      return;
    }

    self linkTo(stuckto);
  }
}

function thermite_watchdisowned() {
  self endon("death");
  self.owner waittill_any_3("joined_team", "joined_spectators", "disconnect");
  thread thermite_destroy();
}

function thermite_destroy(isimmediate) {
  stuckto = self getlinkedparent();

  if(isDefined(stuckto) && isPlayer(stuckto)) {
    if(istrue(stuckto.inlaststand)) {
      stuckto thread thermite_laststand_effects();
    }
  }

  time = 5;

  if(istrue(isimmediate)) {
    time = 0;
  }

  thread thermite_delete(time);
  self setscriptablepartstate("effects", "burnEnd", 0);
}

function thermite_delete(deletiondelay) {
  self notify("death");
  self.exploding = 1;

  if(isDefined(self.badplace)) {
    destroynavobstacle(self.badplace);
    self.badplace = undefined;
  }

  self forcehidegrenadehudwarning(1);
  wait deletiondelay;
  self delete();
}

function thermite_onplayerdamaged(data) {
  if(data.meansofdeath == "MOD_IMPACT") {
    return true;
  }

  data.victim thread scripts\cp\cp_weapons::enableburnfxfortime(0.6);
  return true;
}

function thermite_laststand_effects() {
  self endon("disconnect");
  self notify("newBurnFXLaststand");
  self endon("newBurnFXLaststand");
  waitframe();
  thread scripts\cp\cp_weapons::enableburnfxfortime(4);
}