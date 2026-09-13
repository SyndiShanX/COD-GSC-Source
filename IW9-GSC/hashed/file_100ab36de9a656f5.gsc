/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_100ab36de9a656f5.gsc
***********************************************/

main() {
  self.type = "human";
  self.unittype = "civilian";
  self.subclass = "regular";
  self.baseaccuracy = 0.2;
  self.accuracy = self.baseaccuracy;
  self.health = 100;
  self.maxhealth = 100;
  self.behaviortreeasset = "civilian_livingworld";
  self.asmasset = "civilian";
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
  _id_687325E5C597E4FB = undefined;
  characters = [];

  switch (scripts\code\character::get_random_character(0, _id_687325E5C597E4FB, characters, "actor_civilian_mp_dmz_base")) {}
}

precache() {
  agent_type = "actor_civilian_mp_dmz_base";

  if(!isDefined(level.agent_definition))
    level.agent_definition = [];

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "neutral";
    level.agent_definition[agent_type]["setup_func"] = ::main;
    level.agent_definition[agent_type]["setup_model_func"] = ::setup_model;
  }

  scripts\aitypes\bt_util::init();
  _id_51CD5517092185AD::registerbehaviortree();
  scripts\cp_mp\agents\agent_init::agent_init();
  scripts\aitypes\assets::civilian();
}