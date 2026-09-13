/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_727ef75eb9ead242.gsc
***********************************************/

main() {
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "tier1";
  self.baseaccuracy = 0.2;
  self.accuracy = self.baseaccuracy;
  self.health = 180;
  self.maxhealth = 180;
  self.behaviortreeasset = "soldier_agent";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_smg_cp";
  self.enemyselector = "enemyselector_default";
  self _meth_E99626ADD202FE1A(0, "entity");
  self setengagementmindist(128.0, 0.0);
  self setengagementmaxdist(512.0, 768.0);
  self _meth_9215CE6FC83759B9(1800.0);

  switch (scripts\code\character::get_random_weapon(2)) {
    case 0:
      _id_FEA750D6814B803D = "iw9_sm_beta, [ none, none, none, none, none, none ], none, none";
      self.weapon = level._id_67B54180A55F70E1[_id_FEA750D6814B803D];
      break;
    case 1:
      _id_FEA750D6814B803D = "iw9_sm_aviktor, [ stockno_sm_p04_aviktor ], none, none";
      self.weapon = level._id_67B54180A55F70E1[_id_FEA750D6814B803D];
      break;
  }

  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  _id_4F04B9C326EB7400 = "iw9_pi_papa220, [ none, none, none, none, none, none ], none, none";
  self.sidearm = level._id_67B54180A55F70E1[_id_4F04B9C326EB7400];
  _id_A68442EBADB66EB1 = "frag_grenade_mp";
  self.grenadeweapon = level._id_67B54180A55F70E1[_id_A68442EBADB66EB1];
  self.grenadeammo = 2;
}

setup_model(agent_type) {
  _id_687325E5C597E4FB = undefined;
  characters = ["character_iw9_cartel_tier1_1", "character_iw9_cartel_tier1_2", "character_iw9_cartel_tier1_3", "character_iw9_cartel_tier1_4"];

  switch (scripts\code\character::get_random_character(4, _id_687325E5C597E4FB, characters, "actor_enemy_mp_smg_tier1_cartel")) {
    case 0:
      _id_08E5215C0DF04594::_id_8EE09B8CB8661567();
      break;
    case 1:
      _id_6CE694648C3A3B9D::_id_8EE09B8CB8661567();
      break;
    case 2:
      _id_76FF9D81D2C6B83E::_id_8EE09B8CB8661567();
      break;
    case 3:
      _id_159EE153EEBF11B7::_id_8EE09B8CB8661567();
      break;
  }
}

precache() {
  agent_type = "actor_enemy_mp_smg_tier1_cartel";

  if(!isDefined(level.agent_definition))
    level.agent_definition = [];

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = ::main;
    level.agent_definition[agent_type]["setup_model_func"] = ::setup_model;
    _id_08E5215C0DF04594::_id_8168FBF6282D398B();
    _id_6CE694648C3A3B9D::_id_8168FBF6282D398B();
    _id_76FF9D81D2C6B83E::_id_8168FBF6282D398B();
    _id_159EE153EEBF11B7::_id_8168FBF6282D398B();
  }

  scripts\aitypes\bt_util::init();
  behaviortree\soldier_agent::registerbehaviortree();
  scripts\cp_mp\agents\agent_init::agent_init();
  scripts\aitypes\assets::soldier();
  thread _id_E8CF870298E36BDC();
}

_id_E8CF870298E36BDC() {
  while(!isDefined(level.weaponmapdata))
    waitframe();

  if(!isDefined(level._id_67B54180A55F70E1))
    level._id_67B54180A55F70E1 = [];

  _id_5576D3BE590A9A64 = "iw9_sm_beta, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_5576D3BE590A9A64]))
    level._id_67B54180A55F70E1[_id_5576D3BE590A9A64] = scripts\mp\class::_id_E83615F8A92E4378("iw9_sm_beta", ["none", "none", "none", "none", "none", "none"], "none", "none");

  _id_5576D6BE590AA0FD = "iw9_sm_aviktor, [ stockno_sm_p04_aviktor ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_5576D6BE590AA0FD]))
    level._id_67B54180A55F70E1[_id_5576D6BE590AA0FD] = scripts\mp\class::_id_E83615F8A92E4378("iw9_sm_aviktor", ["stockno_sm_p04_aviktor"], "none", "none");

  _id_4F04B9C326EB7400 = "iw9_pi_papa220, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_4F04B9C326EB7400]))
    level._id_67B54180A55F70E1[_id_4F04B9C326EB7400] = scripts\mp\class::_id_E83615F8A92E4378("iw9_pi_papa220", ["none", "none", "none", "none", "none", "none"], "none", "none");

  _id_A68442EBADB66EB1 = "frag_grenade_mp";

  if(!isDefined(level._id_67B54180A55F70E1[_id_A68442EBADB66EB1]))
    level._id_67B54180A55F70E1[_id_A68442EBADB66EB1] = makeweapon("frag_grenade_mp");
}