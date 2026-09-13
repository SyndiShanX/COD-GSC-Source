/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6ee1e91d981e522a.gsc
***********************************************/

main() {
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "tier3";
  self.baseaccuracy = 0.8;
  self.accuracy = self.baseaccuracy;
  self.health = 1000;
  self.maxhealth = 1000;
  self.behaviortreeasset = "soldier_agent";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_ar_cp";
  self.enemyselector = "enemyselector_default";
  self _meth_E99626ADD202FE1A(0, "entity");
  self setengagementmindist(300.0, 200.0);
  self setengagementmaxdist(1350.0, 1500.0);
  self _meth_9215CE6FC83759B9(2600.0);
  _id_FEA750D6814B803D = "iw9_sn_alpha50, [ lasercyl_hip03 ], none, none";
  self.weapon = level._id_67B54180A55F70E1[_id_FEA750D6814B803D];
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  _id_A68442EBADB66EB1 = "smoke_grenade_b";
  self.grenadeweapon = level._id_67B54180A55F70E1[_id_A68442EBADB66EB1];
  self.grenadeammo = 5;
}

setup_model(agent_type) {
  _id_42E4A32F2AE4B5C6::_id_8EE09B8CB8661567();
}

precache() {
  agent_type = "actor_enemy_mp_boss_sniper";

  if(!isDefined(level.agent_definition))
    level.agent_definition = [];

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = ::main;
    level.agent_definition[agent_type]["setup_model_func"] = ::setup_model;
    _id_42E4A32F2AE4B5C6::_id_8168FBF6282D398B();
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

  _id_FEA750D6814B803D = "iw9_sn_alpha50, [ lasercyl_hip03 ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_FEA750D6814B803D]))
    level._id_67B54180A55F70E1[_id_FEA750D6814B803D] = scripts\mp\class::_id_E83615F8A92E4378("iw9_sn_alpha50", ["lasercyl_hip03"], "none", "none");

  _id_A68442EBADB66EB1 = "smoke_grenade_b";

  if(!isDefined(level._id_67B54180A55F70E1[_id_A68442EBADB66EB1]))
    level._id_67B54180A55F70E1[_id_A68442EBADB66EB1] = makeweapon("smoke_grenade_b");
}