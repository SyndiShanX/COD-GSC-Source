/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5546615ad77d0c3b.gsc
***********************************************/

main() {
  self.type = "human";
  self.unittype = "civilian";
  self.subclass = "regular";
  self.baseaccuracy = 0.2;
  self.accuracy = self.baseaccuracy;
  self.health = 100;
  self.maxhealth = 100;
  self.behaviortreeasset = "civilian";
  self.asmasset = "cap_hostage";
  self.defaultcoverselector = "cover_default_cp";
  self.enemyselector = "enemyselector_default";
  self _meth_E99626ADD202FE1A(0, "entity");
  self setengagementmindist(64.0, 0.0);
  self setengagementmaxdist(768.0, 1024.0);
  self _meth_9215CE6FC83759B9(0.0);
  self.weapon = nullweapon();
  self.grenadeweapon = nullweapon();
  self.grenadeammo = 0;
}

setup_model(agent_type) {
  _id_63A4F2E36C6C60B9::_id_8EE09B8CB8661567();
}

precache() {
  agent_type = "actor_civilian_mp_dmz_hostage";

  if(!isDefined(level.agent_definition))
    level.agent_definition = [];

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "neutral";
    level.agent_definition[agent_type]["setup_func"] = ::main;
    level.agent_definition[agent_type]["setup_model_func"] = ::setup_model;
    _id_63A4F2E36C6C60B9::_id_8168FBF6282D398B();
  }

  scripts\aitypes\bt_util::init();
  behaviortree\civilian::registerbehaviortree();
  scripts\cp_mp\agents\agent_init::agent_init();
  scripts\aitypes\assets::civilian();
}