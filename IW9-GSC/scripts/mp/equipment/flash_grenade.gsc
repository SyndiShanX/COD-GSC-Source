/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\flash_grenade.gsc
**************************************************/

onplayerdamaged(data) {
  if(data.meansofdeath == "MOD_IMPACT")
    return 1;

  data.inflictor._id_D442547D75DFFD09 = scripts\mp\equipment::_id_2113B6F7CB462692(data.inflictor.weapon_name);
  weight = 0;
  _id_457471485336C961 = undefined;
  dist = undefined;
  _id_6D39EBA1D284EBF4 = undefined;

  if(data.attacker == data.victim && !istrue(_id_6D39EBA1D284EBF4)) {
    _id_457471485336C961 = distancesquared(data.victim.origin, data.point);

    if(_id_457471485336C961 > 65536)
      return 0;
    else if(_id_457471485336C961 <= 0)
      dist = 0;
    else
      dist = sqrt(_id_457471485336C961);
  } else
    dist = distance(data.victim.origin, data.point);

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("flashed")) {
    return;
  }
  if(data.victim scripts\mp\utility\perk::_hasperk("specialty_stun_resistance") && data.attacker != data.victim) {
    data.attacker _id_5762AC2F22202BA2::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);

    if(scripts\cp_mp\utility\player_utility::playersareenemies(data.attacker, data.victim))
      data.victim scripts\cp_mp\challenges::resistedstun(data.attacker);

    data.victim scripts\mp\perks\perks::_id_5A3FEF8CB39336B8("specialty_tac_resist");
    data.victim thread applyflash(data.attacker, 2.5);
  } else {
    dist = clamp(dist, 0, 540);
    _id_AE3412F7B9B48D44 = 1 - (dist - 0) / 540;
    weight = weight + floor(_id_AE3412F7B9B48D44 * 65);

    if(scripts\engine\utility::within_fov(data.victim.origin, data.victim getplayerangles(), data.point, 0.5))
      weight = weight + 35;

    if(!scripts\cp_mp\utility\player_utility::playersareenemies(data.attacker, data.victim)) {
      if(!istrue(_id_6D39EBA1D284EBF4)) {
        if(data.attacker == data.victim)
          weight = weight + -30;
        else
          weight = weight + -30;
      }
    }

    weight = max(0, weight);
    _id_453227E7B36F0B24 = weight / 100;
    _id_5F651E1139EF776F = scripts\engine\utility::_id_53C4C53197386572(data.inflictor._id_D442547D75DFFD09._id_2C74F60C630718A3, 2.25);
    _id_6B7054210E5DF55D = scripts\engine\utility::_id_53C4C53197386572(data.inflictor._id_D442547D75DFFD09._id_BD11A6EC2CACBBCD, 3.75);
    duration = _id_5F651E1139EF776F + (_id_6B7054210E5DF55D - _id_5F651E1139EF776F) * _id_453227E7B36F0B24;
    data.victim thread applyflash(data.attacker, duration);

    if(isPlayer(data.attacker)) {
      data.attacker scripts\mp\damage::combatrecordtacticalstat("equip_flash");
      data.attacker scripts\mp\utility\stats::incpersstat("flashbangHits", 1);
    }
  }
}

applyflash(attacker, duration) {
  self endon("disconnect");

  if(scripts\mp\utility\player::isusingremote()) {
    return;
  }
  if(attacker != self)
    attacker _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(0, "flashGrenadeHit");

  _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "player_blinded");
  _id_189B67B2735B981D::_id_55B08D6D71B41402(attacker, "enemy_blinded");

  if(scripts\mp\utility\game::getgametype() == "arena" || scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && attacker _id_2CEDCC356F1B9FC8::isplayeringulag())
    duration = min(scripts\engine\utility::ter_op(level.tacticaltimemod <= 3, level.tacticaltimemod + 1.5, level.tacticaltimemod), duration);

  clearflash();
  self endon("applyFlash");

  if(!istrue(self.flashbanged)) {
    self.flashbanged = 1;

    if(!self _meth_C6CB3E654225077A())
      scripts\mp\utility\player::hidehudenable();
  }

  scripts\cp_mp\utility\shellshock_utility::_shellshock("flash_grenade_mp", "flash", duration, 1);
  scripts\mp\utility\player::_id_8B23D28B1D38CB39("flash", duration);

  if(scripts\cp_mp\utility\player_utility::playersareenemies(self, attacker)) {
    scripts\cp_mp\challenges::_id_B0F754C8A379154E("equip_flash", attacker, undefined, 1);
    thread scripts\mp\gamescore::trackdebuffassistfortime(attacker, self, "flash_grenade_mp", duration);
  }

  if(scripts\mp\utility\game::getgametype() == "arena")
    duration = max(0, duration);
  else
    duration = max(0, duration - 0.5);

  scripts\engine\utility::waittill_notify_or_timeout("death", duration);
  thread clearflash(!scripts\mp\utility\player::isreallyalive(self));
}

clearflash(_id_FCEF8D217A441961) {
  self notify("applyFlash");

  if(istrue(self.flashbanged)) {
    if(!istrue(_id_FCEF8D217A441961)) {
      if(!self _meth_C6CB3E654225077A())
        scripts\mp\utility\player::hidehuddisable();
    }
  }

  self.flashbanged = undefined;
}

calculateinterruptdelay(duration) {
  return max(0, duration - 1.5) * 1000;
}