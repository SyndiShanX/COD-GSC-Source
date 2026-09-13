/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3ccec83c961cd8f5.gsc
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
  _id_FEA750D6814B803D = "iw9_sm_aviktor_mp, [ stockno_sm_p04_aviktor ], none, none";
  self.weapon = level._id_67B54180A55F70E1[_id_FEA750D6814B803D];
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  _id_4F04B9C326EB7400 = "iw9_pi_papa220_mp, [ none, none, none, none, none, none ], none, none";
  self.sidearm = level._id_67B54180A55F70E1[_id_4F04B9C326EB7400];
  _id_A68442EBADB66EB1 = "frag_grenade_mp";
  self.grenadeweapon = level._id_67B54180A55F70E1[_id_A68442EBADB66EB1];
  self.grenadeammo = 2;
}

setup_model(agent_type) {
  _id_687325E5C597E4FB = undefined;
  characters = ["character_iw9_enemy_aq_ar_2_white", "character_iw9_enemy_aq_ar_2_red", "character_iw9_enemy_aq_ar_2_black", "character_iw9_enemy_aq_ar_2_cp", "character_iw9_aq_lmg_1_white", "character_iw9_aq_shotgun_1_white", "character_iw9_aq_smg_1_white"];

  switch (scripts\code\character::get_random_character(7, _id_687325E5C597E4FB, characters, "actor_enemy_cp_smg_tier1_aq")) {
    case 0:
      _id_284FC5A019AF67CF::_id_8EE09B8CB8661567();
      break;
    case 1:
      _id_0C84FFA580391B85::_id_8EE09B8CB8661567();
      break;
    case 2:
      _id_7352677AC13F0C05::_id_8EE09B8CB8661567();
      break;
    case 3:
      _id_52C81658AC296E9F::_id_8EE09B8CB8661567();
      break;
    case 4:
      _id_7127030C38E56CDC::_id_8EE09B8CB8661567();
      break;
    case 5:
      _id_5BCE0AE957CFA0AE::_id_8EE09B8CB8661567();
      break;
    case 6:
      _id_7EA0C36EC1CB6141::_id_8EE09B8CB8661567();
      break;
  }
}

precache() {
  agent_type = "actor_enemy_cp_smg_tier1_aq";

  if(!isDefined(level.agent_definition))
    level.agent_definition = [];

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = ::main;
    level.agent_definition[agent_type]["setup_model_func"] = ::setup_model;
    _id_284FC5A019AF67CF::_id_8168FBF6282D398B();
    _id_0C84FFA580391B85::_id_8168FBF6282D398B();
    _id_7352677AC13F0C05::_id_8168FBF6282D398B();
    _id_52C81658AC296E9F::_id_8168FBF6282D398B();
    _id_7127030C38E56CDC::_id_8168FBF6282D398B();
    _id_5BCE0AE957CFA0AE::_id_8168FBF6282D398B();
    _id_7EA0C36EC1CB6141::_id_8168FBF6282D398B();
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

  _id_FEA750D6814B803D = "iw9_sm_aviktor_mp, [ stockno_sm_p04_aviktor ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_FEA750D6814B803D]))
    level._id_67B54180A55F70E1[_id_FEA750D6814B803D] = scripts\cp\cp_weapon::_id_E83615F8A92E4378("iw9_sm_aviktor_mp", ["stockno_sm_p04_aviktor"], "none", "none");

  _id_4F04B9C326EB7400 = "iw9_pi_papa220_mp, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_4F04B9C326EB7400]))
    level._id_67B54180A55F70E1[_id_4F04B9C326EB7400] = scripts\cp\cp_weapon::_id_E83615F8A92E4378("iw9_pi_papa220_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");

  _id_A68442EBADB66EB1 = "frag_grenade_mp";

  if(!isDefined(level._id_67B54180A55F70E1[_id_A68442EBADB66EB1]))
    level._id_67B54180A55F70E1[_id_A68442EBADB66EB1] = makeweapon("frag_grenade_mp");
}