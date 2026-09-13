/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\concussion_grenade.gsc
*******************************************************/

onexplode(owner, position) {
  if(!isDefined(owner) || !isDefined(position)) {
    return;
  }
  foreach(mine in level.mines) {
    if(!isDefined(mine.equipmentref) || mine.equipmentref != "equip_claymore") {
      continue;
    }
    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(owner, mine.owner))) {
      continue;
    }
    if(distancesquared(position, mine.origin) < 262144)
      mine thread scripts\mp\equipment\claymore::claymore_stunned(owner);
  }

  entities = getentarrayinradius(undefined, undefined, position, 512);

  foreach(guy in entities) {
    if(isagent(guy))
      guy notify("flashbang", guy.origin, 1, 1, owner, "axis");
  }
}

onplayerdamaged(data) {
  victim = data.victim;
  attacker = data.attacker;
  point = data.point;

  if(data.meansofdeath == "MOD_IMPACT")
    return 1;

  if(attacker == victim && distancesquared(point, victim.origin) > 65536)
    return 0;

  if(!isDefined(data.inflictor))
    return 0;

  data.inflictor._id_D442547D75DFFD09 = scripts\mp\equipment::_id_2113B6F7CB462692(data.inflictor.weapon_name);
  victim thread applyconcussion(data.inflictor, attacker);

  if(isPlayer(attacker)) {
    attacker scripts\mp\damage::combatrecordtacticalstat("equip_concussion");
    attacker scripts\mp\utility\stats::incpersstat("stunHits", 1);
  }

  return 1;
}

applyconcussion(einflictor, eattacker) {
  if(scripts\mp\utility\player::isusingremote()) {
    return;
  }
  if(istrue(self.concussionimmune)) {
    return;
  }
  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("stunned")) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "arena" || scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && eattacker _id_2CEDCC356F1B9FC8::isplayeringulag()) {
    _id_73DC87C72D7F6C03 = level.tacticaltimemod;
    _id_0636C8BE8A25F3A8 = level.tacticaltimemod;
  } else {
    _id_73DC87C72D7F6C03 = scripts\engine\utility::_id_53C4C53197386572(einflictor._id_D442547D75DFFD09._id_F2FB099C7B7B0A1F, 1.5);
    _id_0636C8BE8A25F3A8 = scripts\engine\utility::_id_53C4C53197386572(einflictor._id_D442547D75DFFD09._id_C5A6A953A99CEA74, 1.5);
  }

  _id_8907F741F3A7B3F7 = self == eattacker;

  if(_id_8907F741F3A7B3F7) {
    if(scripts\mp\utility\game::getgametype() == "arena" || scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && eattacker _id_2CEDCC356F1B9FC8::isplayeringulag()) {
      _id_73DC87C72D7F6C03 = max(level.tacticaltimemod - 1, 0.5);
      _id_0636C8BE8A25F3A8 = max(level.tacticaltimemod - 1, 0.5);
    } else {
      _id_73DC87C72D7F6C03 = scripts\engine\utility::_id_53C4C53197386572(einflictor._id_D442547D75DFFD09._id_C57F50A067E13927, 2);
      _id_0636C8BE8A25F3A8 = scripts\engine\utility::_id_53C4C53197386572(einflictor._id_D442547D75DFFD09._id_FF2DB6BBA9101658, 2);
    }
  }

  scale = 1 - distance(self.origin, einflictor.origin) / 512;

  if(scale < 0)
    scale = 0;

  if(scripts\mp\utility\game::getgametype() == "arena")
    time = _id_73DC87C72D7F6C03;
  else
    time = _id_73DC87C72D7F6C03 + _id_0636C8BE8A25F3A8 * scale;

  time = scripts\mp\perks\perkfunctions::applystunresistence(eattacker, self, time);
  scripts\cp_mp\challenges::_id_B0F754C8A379154E("equip_concussion", eattacker, undefined, 1);
  thread scripts\mp\gamescore::trackdebuffassistfortime(eattacker, self, "concussion_grenade_mp", time);
  eattacker notify("stun_hit");
  self notify("concussed", eattacker);
  scripts\mp\weapons::setplayerstunned();
  thread scripts\mp\weapons::cleanupconcussionstun(time);
  scripts\cp_mp\utility\shellshock_utility::_shellshock("concussion_grenade_mp", "stun", time, 1);
  scripts\mp\utility\player::_id_8B23D28B1D38CB39("stun", time);

  if(!_id_8907F741F3A7B3F7)
    eattacker _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(0, "concussionGrenadeHit");
}

calculateinterruptdelay(duration) {
  return max(0, duration - 2.6) * 1000;
}