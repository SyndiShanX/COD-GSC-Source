/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_67f3a272b476be3b.gsc
***********************************************/

main() {
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "tier2";
  self.baseaccuracy = 0.2;
  self.accuracy = self.baseaccuracy;
  self.health = 300;
  self.maxhealth = 300;
  self.behaviortreeasset = "soldier_agent";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_ar_cp";
  self.enemyselector = "enemyselector_default";
  self _meth_E99626ADD202FE1A(0, "entity");
  self setengagementmindist(300.0, 200.0);
  self setengagementmaxdist(1350.0, 1500.0);
  self _meth_9215CE6FC83759B9(2600.0);

  switch (scripts\code\character::get_random_weapon(3)) {
    case 0:
      _id_FEA750D6814B803D = "iw9_ar_mike16, [ none, none, none, none, none, none ], none, none";
      self.weapon = level._id_67B54180A55F70E1[_id_FEA750D6814B803D];
      break;
    case 1:
      _id_FEA750D6814B803D = "iw9_ar_mike4, [ none, none, none, none, none, none ], none, none";
      self.weapon = level._id_67B54180A55F70E1[_id_FEA750D6814B803D];
      break;
    case 2:
      _id_FEA750D6814B803D = "iw9_ar_akilo105, [ none, none, none, none, none, none ], none, none";
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
  characters = ["character_iw9_cartel_tier2_1", "character_iw9_cartel_tier2_2"];

  switch (scripts\code\character::get_random_character(2, _id_687325E5C597E4FB, characters, "actor_enemy_mp_ar_tier2_cartel")) {
    case 0:
      _id_102F83EBAFEA84F1::_id_8EE09B8CB8661567();
      break;
    case 1:
      _id_0A9B82FB81EC31F8::_id_8EE09B8CB8661567();
      break;
  }
}

precache() {
  agent_type = "actor_enemy_mp_ar_tier2_cartel";

  if(!isDefined(level.agent_definition))
    level.agent_definition = [];

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = ::main;
    level.agent_definition[agent_type]["setup_model_func"] = ::setup_model;
    _id_102F83EBAFEA84F1::_id_8168FBF6282D398B();
    _id_0A9B82FB81EC31F8::_id_8168FBF6282D398B();
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

  _id_5576D3BE590A9A64 = "iw9_ar_mike16, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_5576D3BE590A9A64]))
    level._id_67B54180A55F70E1[_id_5576D3BE590A9A64] = scripts\mp\class::_id_E83615F8A92E4378("iw9_ar_mike16", ["none", "none", "none", "none", "none", "none"], "none", "none");

  _id_5576D6BE590AA0FD = "iw9_ar_mike4, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_5576D6BE590AA0FD]))
    level._id_67B54180A55F70E1[_id_5576D6BE590AA0FD] = scripts\mp\class::_id_E83615F8A92E4378("iw9_ar_mike4", ["none", "none", "none", "none", "none", "none"], "none", "none");

  _id_5576D5BE590A9ECA = "iw9_ar_akilo105, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_5576D5BE590A9ECA]))
    level._id_67B54180A55F70E1[_id_5576D5BE590A9ECA] = scripts\mp\class::_id_E83615F8A92E4378("iw9_ar_akilo105", ["none", "none", "none", "none", "none", "none"], "none", "none");

  _id_4F04B9C326EB7400 = "iw9_pi_papa220, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_4F04B9C326EB7400]))
    level._id_67B54180A55F70E1[_id_4F04B9C326EB7400] = scripts\mp\class::_id_E83615F8A92E4378("iw9_pi_papa220", ["none", "none", "none", "none", "none", "none"], "none", "none");

  _id_A68442EBADB66EB1 = "frag_grenade_mp";

  if(!isDefined(level._id_67B54180A55F70E1[_id_A68442EBADB66EB1]))
    level._id_67B54180A55F70E1[_id_A68442EBADB66EB1] = makeweapon("frag_grenade_mp");
}