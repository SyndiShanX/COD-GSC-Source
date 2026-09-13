/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_678995a97c5561fd.gsc
***********************************************/

main() {
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.baseaccuracy = 0.2;
  self.accuracy = self.baseaccuracy;
  self.health = 1000;
  self.maxhealth = 1000;
  self.behaviortreeasset = "soldier_agent";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_aggressive";
  self.enemyselector = "enemyselector_default";
  self _meth_E99626ADD202FE1A(0, "entity");
  self setengagementmindist(500.0, 240.0);
  self setengagementmaxdist(1000.0, 1200.0);
  self _meth_9215CE6FC83759B9(1800.0);
  _id_FEA750D6814B803D = "iw9_la_mike32biolab, [ none, none, none, none, none, none ], none, none";
  self.weapon = level._id_67B54180A55F70E1[_id_FEA750D6814B803D];
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
  _id_7DF2CA72197142AA::_id_8EE09B8CB8661567();
}

precache() {
  agent_type = "actor_enemy_mp_boss_velikan";

  if(!isDefined(level.agent_definition))
    level.agent_definition = [];

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = ::main;
    level.agent_definition[agent_type]["setup_model_func"] = ::setup_model;
    _id_7DF2CA72197142AA::_id_8168FBF6282D398B();
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

  _id_FEA750D6814B803D = "iw9_la_mike32biolab, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_FEA750D6814B803D]))
    level._id_67B54180A55F70E1[_id_FEA750D6814B803D] = scripts\mp\class::_id_E83615F8A92E4378("iw9_la_mike32biolab", ["none", "none", "none", "none", "none", "none"], "none", "none");

  _id_4F04B9C326EB7400 = "iw9_pi_papa220, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_4F04B9C326EB7400]))
    level._id_67B54180A55F70E1[_id_4F04B9C326EB7400] = scripts\mp\class::_id_E83615F8A92E4378("iw9_pi_papa220", ["none", "none", "none", "none", "none", "none"], "none", "none");

  _id_A68442EBADB66EB1 = "frag_grenade_mp";

  if(!isDefined(level._id_67B54180A55F70E1[_id_A68442EBADB66EB1]))
    level._id_67B54180A55F70E1[_id_A68442EBADB66EB1] = makeweapon("frag_grenade_mp");
}