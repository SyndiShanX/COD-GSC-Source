/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_30c27d65d748cfc3.gsc
***********************************************/

main() {
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "tier3";
  self.baseaccuracy = 0.2;
  self.accuracy = self.baseaccuracy;
  self.health = 666;
  self.maxhealth = 666;
  self.behaviortreeasset = "riotshield_cp";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_default_cp";
  self.enemyselector = "enemyselector_default";
  self _meth_E99626ADD202FE1A(0, "entity");
  self setengagementmindist(750.0, 500.0);
  self setengagementmaxdist(1250.0, 1500.0);
  self _meth_9215CE6FC83759B9(1500.0);
  _id_FEA750D6814B803D = "iw9_sh_vecho_mp, [ ammo_12g_db_vecho, stock_sh_tactical_p04_vecho, bar_sh_hvyshort_p04 ], none, none";
  self.weapon = level._id_67B54180A55F70E1[_id_FEA750D6814B803D];
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  _id_A68442EBADB66EB1 = "molotov_mp";
  self.grenadeweapon = level._id_67B54180A55F70E1[_id_A68442EBADB66EB1];
  self.grenadeammo = 4;
}

setup_model(agent_type) {
  _id_59CC3E60C3F3C8CE::_id_8EE09B8CB8661567();
}

precache() {
  agent_type = "actor_enemy_cp_boss_pyro";

  if(!isDefined(level.agent_definition))
    level.agent_definition = [];

  if(!isDefined(level.agent_definition[agent_type])) {
    level.agent_definition[agent_type] = [];
    level.agent_definition[agent_type]["team"] = "axis";
    level.agent_definition[agent_type]["setup_func"] = ::main;
    level.agent_definition[agent_type]["setup_model_func"] = ::setup_model;
    _id_59CC3E60C3F3C8CE::_id_8168FBF6282D398B();
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

  _id_FEA750D6814B803D = "iw9_sh_vecho_mp, [ ammo_12g_db_vecho, stock_sh_tactical_p04_vecho, bar_sh_hvyshort_p04 ], none, none";

  if(!isDefined(level._id_67B54180A55F70E1[_id_FEA750D6814B803D]))
    level._id_67B54180A55F70E1[_id_FEA750D6814B803D] = scripts\cp\cp_weapon::_id_E83615F8A92E4378("iw9_sh_vecho_mp", ["ammo_12g_db_vecho", "stock_sh_tactical_p04_vecho", "bar_sh_hvyshort_p04"], "none", "none");

  _id_A68442EBADB66EB1 = "molotov_mp";

  if(!isDefined(level._id_67B54180A55F70E1[_id_A68442EBADB66EB1]))
    level._id_67B54180A55F70E1[_id_A68442EBADB66EB1] = makeweapon("molotov_mp");
}