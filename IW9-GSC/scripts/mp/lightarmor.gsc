/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\lightarmor.gsc
***********************************************/

haslightarmor(player) {
  return getlightarmorvalue(player) > 0;
}

getlightarmorvalue(player) {
  if(isDefined(player.lightarmorhp))
    return player.lightarmorhp;

  return 0;
}

setlightarmorvalue(player, value, _id_5321C8DB6557919D, playvfx) {
  if(!isDefined(_id_5321C8DB6557919D))
    _id_5321C8DB6557919D = 1;

  if(!isDefined(playvfx))
    playvfx = 1;

  if(lightarmor_lightarmor_disabled(player)) {
    value = 0;
    _id_5321C8DB6557919D = 1;
  }

  _id_7ABB90C7E07FF11B = getlightarmorvalue(player);

  if(!_id_5321C8DB6557919D && _id_7ABB90C7E07FF11B > value)
    value = _id_7ABB90C7E07FF11B;

  if(_id_7ABB90C7E07FF11B <= 0 && value > 0) {
    lightarmor_set(player, value, playvfx);
    return;
  }

  if(_id_7ABB90C7E07FF11B > 0 && value <= 0) {
    lightarmor_unset(player);
    return;
  }

  player.lightarmorhp = value;

  if(isPlayer(player) && _id_7ABB90C7E07FF11B <= value && value > 0 && playvfx == 1)
    thread lightarmor_setfx(player);

  if(isPlayer(player))
    lightarmor_updatehud(player);
}

init() {}

lightarmor_set(player, value, playvfx) {
  player notify("lightArmor_set");
  player.lightarmorhp = value;
  lightarmor_updatehud(player);
  thread lightarmor_monitordeath(player);

  if(isPlayer(player) && playvfx == 1)
    thread lightarmor_setfx(player);
}

lightarmor_unset(player) {
  player notify("lightArmor_unset");
  player.lightarmorhp = undefined;
  lightarmor_updatehud(player);

  if(isPlayer(player)) {}

  player notify("remove_light_armor");
}

lightarmor_modifydamage(victim, attacker, damage, _id_6CAC94B6632AA667, smeansofdeath, sweapon, _id_96586EEC2364C35B, _id_483B72BBC1109AB2, shitloc, inflictor, _id_124225617CFE6887) {
  _id_EB9B8CDC328659B0 = 0;
  _id_0D2D73EA74D3309C = 0;
  _id_75EF43071EAABCC9 = victim.lightarmorhp;

  if(!isDefined(_id_124225617CFE6887))
    _id_124225617CFE6887 = 1;

  if(!_id_EB9B8CDC328659B0) {
    if(smeansofdeath == "MOD_FALLING")
      _id_EB9B8CDC328659B0 = 1;
  }

  if(!_id_EB9B8CDC328659B0) {
    if(isexplosivedamagemod(smeansofdeath)) {
      if(isDefined(inflictor) && isDefined(inflictor.stuckenemyentity) && inflictor.stuckenemyentity == victim)
        _id_EB9B8CDC328659B0 = 1;
    }
  }

  if(!_id_EB9B8CDC328659B0) {
    if(scripts\mp\utility\weapon::issuperdamagesource(sweapon))
      _id_EB9B8CDC328659B0 = 1;
  }

  if(!_id_EB9B8CDC328659B0) {
    _id_0D2D73EA74D3309C = min(damage + _id_6CAC94B6632AA667, victim.lightarmorhp);
    _id_75EF43071EAABCC9 = _id_75EF43071EAABCC9 - (damage + _id_6CAC94B6632AA667);

    if(!_id_124225617CFE6887)
      victim.lightarmorhp = victim.lightarmorhp - (damage + _id_6CAC94B6632AA667);

    damage = 0;
    _id_6CAC94B6632AA667 = 0;

    if(_id_75EF43071EAABCC9 <= 0) {
      damage = abs(_id_75EF43071EAABCC9);
      _id_6CAC94B6632AA667 = 0;

      if(!_id_124225617CFE6887)
        lightarmor_unset(victim);
    }
  }

  if(!_id_124225617CFE6887)
    lightarmor_updatehud(self);

  if(_id_0D2D73EA74D3309C > 0 && damage == 0)
    damage = 1;

  return [_id_0D2D73EA74D3309C, damage, _id_6CAC94B6632AA667];
}

lightarmor_lightarmor_disabled(player) {
  if(player scripts\mp\heavyarmor::hasheavyarmor())
    return 1;

  return 0;
}

lightarmor_monitordeath(player) {
  player endon("disconnect");
  player endon("lightArmor_set");
  player endon("lightArmor_unset");
  player waittill("death");
  thread lightarmor_unset(player);
}

lightarmor_updatehud(player) {
  if(!isPlayer(player))
    return;
}

lightarmor_setfx(player) {}