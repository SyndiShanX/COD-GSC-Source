/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_22866136994f3612.gsc
***********************************************/

main() {
  self.type = "human";
  self.unittype = "suicidebomber";
  self.subclass = "regular";
  self.baseaccuracy = 0.2;
  self.accuracy = self.baseaccuracy;
  self.health = 180;
  self.maxhealth = 180;
  self.behaviortreeasset = "suicidebomber_agent";
  self.asmasset = "suicidebomber";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";
  self _meth_E99626ADD202FE1A(0, "entity");
  self setengagementmindist(750.0, 500.0);
  self setengagementmaxdist(1250.0, 1500.0);
  self _meth_9215CE6FC83759B9(0.0);
  self.weapon = nullweapon();
  _id_4F04B9C326EB7400 = "iw9_pi_papa220_mp, [ none, none, none, none, none, none ], none, none";
  self.sidearm = level._id_67B54180A55F70E1[_id_4F04B9C326EB7400];
  _id_A68442EBADB66EB1 = "suicide_vest";
  self.grenadeweapon = level._id_67B54180A55F70E1[_id_A68442EBADB66EB1];
  self.grenadeammo = 2;
}

setup_model(agent_type) {
  _id_678C235C76D4A159::_id_8EE09B8CB8661567();
}

precache() {
  agent_type = "actor_enemy_cp_bomber";

  if(!isDefined(level.agent_definition))
    level.agent_definition = [];

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = ::main;
    level.agent_definition[agent_type]["setup_model_func"] = ::setup_model;
    _id_678C235C76D4A159::_id_8168FBF6282D398B();
  }

  scripts\aitypes\bt_util::init();
  behaviortree\suicidebomber_agent::registerbehaviortree();
  scripts\cp_mp\agents\agent_init::agent_init();
  scripts\aitypes\assets::suicidebomber();
  thread _id_E8CF870298E36BDC();
}

_id_E8CF870298E36BDC() {
  while(!isDefined(level.weaponmapdata))
    waitframe();

  if(!isDefined(level._id_67B54180A55F70E1))
    level._id_67B54180A55F70E1 = [];

  _id_4F04B9C326EB7400 = "iw9_pi_papa220_mp, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_4F04B9C326EB7400]))
    level._id_67B54180A55F70E1[_id_4F04B9C326EB7400] = scripts\cp\cp_weapon::_id_E83615F8A92E4378("iw9_pi_papa220_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");

  _id_A68442EBADB66EB1 = "suicide_vest";

  if(!isDefined(level._id_67B54180A55F70E1[_id_A68442EBADB66EB1]))
    level._id_67B54180A55F70E1[_id_A68442EBADB66EB1] = makeweapon("suicide_vest");
}