/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_29f84a3ea81b5529.gsc
***********************************************/

main() {
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "tier2";
  self.baseaccuracy = 0.2;
  self.accuracy = self.baseaccuracy;
  self.health = 300;
  self.maxhealth = 300;
  self.behaviortreeasset = "riotshield_cp";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_default_cp";
  self.enemyselector = "enemyselector_default";
  self _meth_E99626ADD202FE1A(0, "entity");
  self setengagementmindist(128.0, 0.0);
  self setengagementmaxdist(512.0, 768.0);
  self _meth_9215CE6FC83759B9(1800.0);
  _id_FEA750D6814B803D = "iw9_sm_aviktor_mp, [ stockno_sm_p04_aviktor ], none, none";
  self.weapon = level._id_67B54180A55F70E1[_id_FEA750D6814B803D];
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  _id_A68442EBADB66EB1 = "frag_grenade_mp";
  self.grenadeweapon = level._id_67B54180A55F70E1[_id_A68442EBADB66EB1];
  self.grenadeammo = 2;
}

setup_model(agent_type) {
  _id_687325E5C597E4FB = undefined;
  characters = ["character_iw9_cartel_tier2_1_rs", "character_iw9_cartel_tier2_2_rs"];

  switch (scripts\code\character::get_random_character(2, _id_687325E5C597E4FB, characters, "actor_enemy_cp_riotshield_tier2_cartel")) {
    case 0:
      _id_16DC000513F0EC83::_id_8EE09B8CB8661567();
      break;
    case 1:
      _id_1D6D495BA120BFD8::_id_8EE09B8CB8661567();
      break;
  }
}

precache() {
  agent_type = "actor_enemy_cp_riotshield_tier2_cartel";

  if(!isDefined(level.agent_definition))
    level.agent_definition = [];

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = ::main;
    level.agent_definition[agent_type]["setup_model_func"] = ::setup_model;
    _id_16DC000513F0EC83::_id_8168FBF6282D398B();
    _id_1D6D495BA120BFD8::_id_8168FBF6282D398B();
  }

  scripts\aitypes\bt_util::init();
  behaviortree\riotshield_cp::registerbehaviortree();
  scripts\cp_mp\agents\agent_init::agent_init();
  scripts\aitypes\assets::soldier();
  thread _id_E8CF870298E36BDC();
}

_id_E8CF870298E36BDC() {
  while(!isDefined(level.weaponmapdata))
    waitframe();

  if(!isDefined(level._id_67B54180A55F70E1))
    level._id_67B54180A55F70E1 = [];

  _id_FEA750D6814B803D = "iw9_sm_aviktor_mp, [ stockno_sm_p04_aviktor ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_FEA750D6814B803D]))
    level._id_67B54180A55F70E1[_id_FEA750D6814B803D] = scripts\cp\cp_weapon::_id_E83615F8A92E4378("iw9_sm_aviktor_mp", ["stockno_sm_p04_aviktor"], "none", "none");

  _id_A68442EBADB66EB1 = "frag_grenade_mp";

  if(!isDefined(level._id_67B54180A55F70E1[_id_A68442EBADB66EB1]))
    level._id_67B54180A55F70E1[_id_A68442EBADB66EB1] = makeweapon("frag_grenade_mp");
}