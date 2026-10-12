/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\lightarmor.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\heavyarmor;
#using scripts\mp\utility\weapon;
#namespace lightarmor;

function haslightarmor(player) {
  return getlightarmorvalue(player) > 0;
}

function getlightarmorvalue(player) {
  if(isDefined(player.lightarmorhp)) {
    return player.lightarmorhp;
  }

  return 0;
}

function setlightarmorvalue(player, value, overridegreater, playvfx) {
  if(!isDefined(overridegreater)) {
    overridegreater = 1;
  }

  if(!isDefined(playvfx)) {
    playvfx = 1;
  }

  if(lightarmor_lightarmor_disabled(player)) {
    value = 0;
    overridegreater = 1;
  }

  oldvalue = getlightarmorvalue(player);

  if(!overridegreater && oldvalue > value) {
    value = oldvalue;
  }

  if(oldvalue <= 0 && value > 0) {
    lightarmor_set(player, value, playvfx);
    return;
  }

  if(oldvalue > 0 && value <= 0) {
    lightarmor_unset(player);
    return;
  }

  player.lightarmorhp = value;

  if(isPlayer(player) && oldvalue <= value && value > 0 && playvfx == 1) {
    thread lightarmor_setfx(player);
  }

  if(isPlayer(player)) {
    lightarmor_updatehud(player);
  }
}

function init() {}

function lightarmor_set(player, value, playvfx) {
  assertex(isDefined(value), "<dev string:x1c>");
  player notify("lightArmor_set");
  player.lightarmorhp = value;
  lightarmor_updatehud(player);
  thread lightarmor_monitordeath(player);

  if(isPlayer(player) && playvfx == 1) {
    thread lightarmor_setfx(player);
  }
}

function lightarmor_unset(player) {
  player notify("lightArmor_unset");
  player.lightarmorhp = undefined;
  lightarmor_updatehud(player);

  if(isPlayer(player)) {}

  player notify("remove_light_armor");
}

function lightarmor_modifydamage(victim, attacker, damage, damageadd, smeansofdeath, sweapon, impactpoint, impactdir, shitloc, inflictor, query) {
  var_eb9b8cdc328659b0 = 0;
  damageblocked = 0;
  lightarmorhpmodified = victim.lightarmorhp;

  if(!isDefined(query)) {
    query = 1;
  }

  if(!var_eb9b8cdc328659b0) {
    if(smeansofdeath == "MOD_FALLING") {
      var_eb9b8cdc328659b0 = 1;
    }
  }

  if(!var_eb9b8cdc328659b0) {
    if(isexplosivedamagemod(smeansofdeath)) {
      if(isDefined(inflictor) && isDefined(inflictor.stuckenemyentity) && inflictor.stuckenemyentity == victim) {
        var_eb9b8cdc328659b0 = 1;
      }
    }
  }

  if(!var_eb9b8cdc328659b0) {
    if(scripts\mp\utility\weapon::issuperdamagesource(sweapon)) {
      var_eb9b8cdc328659b0 = 1;
    }
  }

  if(!var_eb9b8cdc328659b0) {
    damageblocked = min(damage + damageadd, victim.lightarmorhp);
    lightarmorhpmodified -= damage + damageadd;

    if(!query) {
      victim.lightarmorhp -= damage + damageadd;
    }

    damage = 0;
    damageadd = 0;

    if(lightarmorhpmodified <= 0) {
      damage = abs(lightarmorhpmodified);
      damageadd = 0;

      if(!query) {
        lightarmor_unset(victim);
      }
    }
  }

  if(!query) {
    lightarmor_updatehud(self);
  }

  if(damageblocked > 0 && damage == 0) {
    damage = 1;
  }

  return [damageblocked, damage, damageadd];
}

function lightarmor_lightarmor_disabled(player) {
  if(player scripts\mp\heavyarmor::hasheavyarmor()) {
    return true;
  }

  return false;
}

function lightarmor_monitordeath(player) {
  player endon("disconnect");
  player endon("lightArmor_set");
  player endon("lightArmor_unset");
  player waittill("death");
  thread lightarmor_unset(player);
}

function lightarmor_updatehud(player) {
  if(!isPlayer(player)) {
    return;
  }
}

function lightarmor_setfx(player) {}