/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\playerhealth.gsc
***********************************************/

init() {
  healthregendelay = scripts\mp\utility\dvars::getoverridedvarfloatexceptmatchrulesvalues(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_healthregentime"), "scr_player_healthregentime");
  scripts\mp\tweakables::settweakablevalue("player", "healthregentime", healthregendelay);
  scripts\mp\tweakables::settweakablelastvalue("player", "healthregentime", healthregendelay);
  level.healthregendelay = scripts\mp\tweakables::gettweakablevalue("player", "healthregentime");
  level.healthregendisabled = level.healthregendelay <= 0;
  level.playerhealth_regularregendelay = level.healthregendelay;

  if(!isDefined(level._id_FDD1AF3C4C6CBE86))
    level._id_FDD1AF3C4C6CBE86 = 0.7;

  if(!isDefined(level._id_BE39D6B46044F344))
    level._id_BE39D6B46044F344 = 40;

  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
}

onplayerspawned() {
  thread _id_0372301AF73968CB::manageplayerregen();
  self visionsetthermalforplayer(game["thermal_vision"]);
  _id_6A5D3BF7A5B7064A::_id_9BC46D4B8891A740();
}

onfullhealth(_id_4A2AE12522AD9D95, _id_823CA369FAFD4A36, _id_7F86CF029BEF696D) {
  _id_E394E626CA540132 = self.health - _id_4A2AE12522AD9D95;

  if(_id_7F86CF029BEF696D) {
    scripts\mp\damage::combatrecordtacticalstat("equip_adrenaline", _id_E394E626CA540132);
    scripts\mp\utility\stats::incpersstat("stimDamageHealed", _id_E394E626CA540132);
    scripts\mp\analyticslog::logevent_playerhealed(self, _id_E394E626CA540132, self);
  } else if(!isai(self))
    scripts\mp\analyticslog::logevent_playerregen(self, _id_E394E626CA540132);

  if(isDefined(self.pers["damageHealed"])) {
    _id_E394E626CA540132 = self.health - _id_4A2AE12522AD9D95;
    scripts\mp\utility\stats::incpersstat("damageHealed", _id_E394E626CA540132);
  }

  if(_id_823CA369FAFD4A36)
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_122E9B7F62BDB160");
}

_id_4A583E8FE08859DB() {
  if(scripts\cp_mp\utility\game_utility::_id_244067E915C0EABE())
    _id_881FB15F4D296741 = level.playermaxhealth / 100;
  else
    _id_881FB15F4D296741 = 1;

  _id_89E7B92573A50713 = level._id_BE39D6B46044F344 * 0.05 * _id_881FB15F4D296741;

  if(istrue(self._id_808D06DDFC93A4E4)) {
    _id_194458C6687C5A07 = _id_19FD5B5D73D44C18::_id_7FA9C564C245F4E3() * 0.05 * _id_881FB15F4D296741;
    _id_89E7B92573A50713 = max(_id_194458C6687C5A07, _id_89E7B92573A50713);
  }

  if(istrue(self.adrenalinepoweractive)) {
    _id_194458C6687C5A07 = scripts\mp\equipment\adrenaline::gethealthpersec() * 0.05 * _id_881FB15F4D296741;
    _id_89E7B92573A50713 = max(_id_194458C6687C5A07, _id_89E7B92573A50713);
  } else if(istrue(self.laststandhealisactive)) {
    _id_194458C6687C5A07 = scripts\mp\supers\laststand_heal::laststandheal_gethealthperframe();
    _id_89E7B92573A50713 = max(_id_194458C6687C5A07, _id_89E7B92573A50713);
  } else if(scripts\mp\utility\perk::_hasperk("specialty_regenfaster"))
    _id_89E7B92573A50713 = _id_89E7B92573A50713 * level.regenfasterhealthmod;

  if(isDefined(level.regenhealthaddfunc))
    _id_89E7B92573A50713 = [[level.regenhealthaddfunc]](_id_89E7B92573A50713);

  return _id_89E7B92573A50713;
}