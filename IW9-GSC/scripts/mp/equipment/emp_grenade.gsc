/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\emp_grenade.gsc
************************************************/

_id_16E153EA7C832F71(data) {
  thread _id_5CF7C7316E024552(data);
}

emp_grenade_used(grenade) {
  self endon("disconnect");
  grenade endon("explode_end");
  grenade thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  grenade waittill("explode", position);
  ents = scripts\cp_mp\emp_debuff::get_emp_ents();
  objweapon = makeweapon("emp_grenade_mp");

  foreach(ent in ents) {
    entowner = ent.owner;

    if(isDefined(entowner)) {
      if(entowner != self && !scripts\cp_mp\utility\player_utility::playersareenemies(self, entowner))
        continue;
    }

    _id_457471485336C961 = distancesquared(position, ent.origin);

    if(_id_457471485336C961 > 262144) {
      continue;
    }
    data = scripts\cp_mp\utility\damage_utility::packdamagedata(self, ent, 1, objweapon, "MOD_EXPLOSIVE", grenade, position);
    thread emp_grenade_apply_non_player(data);
  }

  players = scripts\mp\utility\player::getplayersinradius(position, 512);

  foreach(player in players) {
    if(!player scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }
    if(player != self && !scripts\cp_mp\utility\player_utility::playersareenemies(self, player)) {
      continue;
    }
    data = scripts\cp_mp\utility\damage_utility::packdamagedata(self, player, 1, objweapon, "MOD_EXPLOSIVE", grenade, position);
    thread emp_grenade_apply_player(data);
  }
}

emp_grenade_apply_non_player(data) {
  if(data.attacker != data.victim)
    _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(0, "emp_grenade");

  scripts\cp_mp\emp_debuff::apply_emp_struct(data);
  emp_grenade_end_early(data, 6);

  if(isDefined(data.victim))
    data.victim scripts\cp_mp\emp_debuff::remove_emp();
}

emp_grenade_apply_player(data) {
  if(data.attacker != data.victim)
    _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(0, "emp_grenade");

  scripts\cp_mp\emp_debuff::apply_emp_struct(data);
  scripts\mp\gamescore::trackdebuffassist(data.attacker, data.victim, data.objweapon.basename);
  _id_75C03204F5AF9809 = scripts\engine\utility::ter_op(data.attacker == data.victim, 2, 6);
  emp_grenade_end_early(data, _id_75C03204F5AF9809);

  if(isDefined(data.victim)) {
    data.victim scripts\cp_mp\emp_debuff::remove_emp();

    if(isDefined(data.attacker) && scripts\mp\utility\player::isreallyalive(data.attacker))
      scripts\mp\gamescore::untrackdebuffassist(data.attacker, data.victim, data.objweapon.basename);
  }
}

_id_5CF7C7316E024552(data) {
  attacker = data.attacker;
  victim = data.victim;
  _id_632C8E583FC9AEA9 = data.point;

  if(victim scripts\mp\utility\player::isusingremote()) {
    return;
  }
  if(istrue(victim.concussionimmune)) {
    return;
  }
  _id_8907F741F3A7B3F7 = victim == attacker;
  duration = 2.0;

  if(_id_8907F741F3A7B3F7)
    duration = 0.8;

  scale = 1 - distance(_id_632C8E583FC9AEA9, victim.origin) / 512;

  if(scale < 0)
    scale = 0;

  duration = duration * scale;
  duration = scripts\mp\perks\perkfunctions::applystunresistence(attacker, victim, duration);
  victim scripts\mp\weapons::setplayerstunned();
  victim thread scripts\mp\weapons::cleanupconcussionstun(duration);
  victim scripts\cp_mp\utility\shellshock_utility::_shellshock("emp", "stun", duration, 1);
}

emp_grenade_end_early(data, duration) {
  data.victim endon("death_or_disconnect");
  level endon("game_ended");
  result = scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", duration);
}