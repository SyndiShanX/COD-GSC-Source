/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_338ec7e04fb9a896.gsc
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
  self.defaultcoverselector = "cover_ar_cp";
  self.enemyselector = "enemyselector_default";
  self _meth_E99626ADD202FE1A(0, "entity");
  self setengagementmindist(300.0, 200.0);
  self setengagementmaxdist(1350.0, 1500.0);
  self _meth_9215CE6FC83759B9(2600.0);

  switch (scripts\code\character::get_random_weapon(5)) {
    case 0:
      _id_FEA750D6814B803D = "iw9_ar_akilo105_mp, [ none, none, none, none, none, none ], none, none";
      self.weapon = level._id_67B54180A55F70E1[_id_FEA750D6814B803D];
      break;
    case 1:
      _id_FEA750D6814B803D = "iw9_ar_akilo105_mp, [ bar_ar_hvyshort_p04_akilo105, reflex03_tall, stock_ar_tactical_p04_akilo105 ], none, none";
      self.weapon = level._id_67B54180A55F70E1[_id_FEA750D6814B803D];
      break;
    case 2:
      _id_FEA750D6814B803D = "iw9_ar_akilo105_mp, [ holo01 ], none, none";
      self.weapon = level._id_67B54180A55F70E1[_id_FEA750D6814B803D];
      break;
    case 3:
      _id_FEA750D6814B803D = "iw9_ar_mike4_mp, [ iw9_minireddot04_tall, stock_ar_p01_mike4 ], none, none";
      self.weapon = level._id_67B54180A55F70E1[_id_FEA750D6814B803D];
      break;
    case 4:
      _id_FEA750D6814B803D = "iw9_ar_mike4_mp, [ bar_ar_light_p01_mike4, fourx02, stock_ar_tactical_p01_mike4 ], none, none";
      self.weapon = level._id_67B54180A55F70E1[_id_FEA750D6814B803D];
      break;
  }

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
  characters = ["character_iw9_cartel_tier1_1", "character_iw9_cartel_tier1_2", "character_iw9_cartel_tier1_3", "character_iw9_cartel_tier1_4"];

  switch (scripts\code\character::get_random_character(4, _id_687325E5C597E4FB, characters, "actor_enemy_cp_ar_tier1_cartel")) {
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
  agent_type = "actor_enemy_cp_ar_tier1_cartel";

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

  _id_5576D3BE590A9A64 = "iw9_ar_akilo105_mp, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_5576D3BE590A9A64]))
    level._id_67B54180A55F70E1[_id_5576D3BE590A9A64] = scripts\cp\cp_weapon::_id_E83615F8A92E4378("iw9_ar_akilo105_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");

  _id_5576D6BE590AA0FD = "iw9_ar_akilo105_mp, [ bar_ar_hvyshort_p04_akilo105, reflex03_tall, stock_ar_tactical_p04_akilo105 ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_5576D6BE590AA0FD]))
    level._id_67B54180A55F70E1[_id_5576D6BE590AA0FD] = scripts\cp\cp_weapon::_id_E83615F8A92E4378("iw9_ar_akilo105_mp", ["bar_ar_hvyshort_p04_akilo105", "reflex03_tall", "stock_ar_tactical_p04_akilo105"], "none", "none");

  _id_5576D5BE590A9ECA = "iw9_ar_akilo105_mp, [ holo01 ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_5576D5BE590A9ECA]))
    level._id_67B54180A55F70E1[_id_5576D5BE590A9ECA] = scripts\cp\cp_weapon::_id_E83615F8A92E4378("iw9_ar_akilo105_mp", ["holo01"], "none", "none");

  _id_5576D0BE590A93CB = "iw9_ar_mike4_mp, [ iw9_minireddot04_tall, stock_ar_p01_mike4 ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_5576D0BE590A93CB]))
    level._id_67B54180A55F70E1[_id_5576D0BE590A93CB] = scripts\cp\cp_weapon::_id_E83615F8A92E4378("iw9_ar_mike4_mp", ["iw9_minireddot04_tall", "stock_ar_p01_mike4"], "none", "none");

  _id_5576CFBE590A9198 = "iw9_ar_mike4_mp, [ bar_ar_light_p01_mike4, fourx02, stock_ar_tactical_p01_mike4 ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_5576CFBE590A9198]))
    level._id_67B54180A55F70E1[_id_5576CFBE590A9198] = scripts\cp\cp_weapon::_id_E83615F8A92E4378("iw9_ar_mike4_mp", ["bar_ar_light_p01_mike4", "fourx02", "stock_ar_tactical_p01_mike4"], "none", "none");

  _id_4F04B9C326EB7400 = "iw9_pi_papa220_mp, [ none, none, none, none, none, none ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_4F04B9C326EB7400]))
    level._id_67B54180A55F70E1[_id_4F04B9C326EB7400] = scripts\cp\cp_weapon::_id_E83615F8A92E4378("iw9_pi_papa220_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");

  _id_A68442EBADB66EB1 = "frag_grenade_mp";

  if(!isDefined(level._id_67B54180A55F70E1[_id_A68442EBADB66EB1]))
    level._id_67B54180A55F70E1[_id_A68442EBADB66EB1] = makeweapon("frag_grenade_mp");
}