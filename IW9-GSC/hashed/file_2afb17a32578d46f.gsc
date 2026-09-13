/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2afb17a32578d46f.gsc
***********************************************/

main() {
  self.type = "human";
  self.unittype = "zombie";
  self.subclass = "regular";
  self.baseaccuracy = 0.01;
  self.accuracy = self.baseaccuracy;
  self.health = 120;
  self.maxhealth = 120;
  self.behaviortreeasset = "zombie";
  self.asmasset = "zombie_lw_br";
  self.defaultcoverselector = "cover_default_cp";
  self.enemyselector = "enemyselector_default_zombie";
  self _meth_E99626ADD202FE1A(0, "entity");
  self setengagementmindist(128.0, 0.0);
  self setengagementmaxdist(256.0, 1024.0);
  self _meth_9215CE6FC83759B9(0.0);
  self.weapon = nullweapon();
  self.grenadeweapon = nullweapon();
  self.grenadeammo = 0;
}

setup_model(agent_type) {
  _id_50A229C9F6049DF3::_id_8EE09B8CB8661567();
}

precache() {
  agent_type = "actor_enemy_lw_zombie_default";

  if(!isDefined(level.agent_definition))
    level.agent_definition = [];

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = ::main;
    level.agent_definition[agent_type]["setup_model_func"] = ::setup_model;
    _id_50A229C9F6049DF3::_id_8168FBF6282D398B();
  }

  scripts\aitypes\bt_util::init();
  _id_243677330BC33D66::registerbehaviortree();
  scripts\cp_mp\agents\agent_init::agent_init();
  scripts\aitypes\assets::zombie();
}