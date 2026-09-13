/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5ae78957deadf9eb.gsc
***********************************************/

_id_4A755326CD53D3B3() {
  _id_AED74300DAF62896 = spawnStruct();
  _id_AED74300DAF62896.armor = getdvarfloat("dvar_60A6F859CC67B71B", 5000);
  _id_AED74300DAF62896.maxdamage = getdvarint("dvar_C35DE7777481DF06", 100);
  _id_AED74300DAF62896.name = "pyro";
  _id_AED74300DAF62896._id_C8CDA7EEE067D67C = "MP_INGAME_ONLY/OBJ_NEMESIS_CAPS";
  _id_AED74300DAF62896._id_EC2EC5F083DF61CD = ::_id_9A5C6E540A2F3340;
  _id_AED74300DAF62896.spawnfunc = ::_id_4108074415ABC816;
  _id_AED74300DAF62896._id_E68429B39C75B6EE = ::_id_4108074415ABC816;
  _id_AED74300DAF62896._id_4EA49A8926593523 = ::_id_B08878702405E6B8;
  _id_2636152C566D6C64::_id_613E13E7416BFAA5(_id_AED74300DAF62896);
}

_id_9A5C6E540A2F3340(_id_AED74300DAF62896) {}

_id_4108074415ABC816(node) {
  _id_E2958F412A7425C0 = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF("enemy_mp_boss_pyro", node.origin, node.angles, "absolute", "elites", "pyroBoss", undefined, undefined, undefined, undefined, 1, 0, 0);

  if(!isDefined(_id_E2958F412A7425C0)) {
    return;
  }
  _id_FB62BCEF7FAB15FB(_id_E2958F412A7425C0);
  return _id_E2958F412A7425C0;
}

_id_FB62BCEF7FAB15FB(agent) {
  if(!isDefined(agent)) {
    return;
  }
  _id_A664AAD02EE98BD2 = "molotov_mp";
  grenadeammo = getdvarint("dvar_537FA443CE212A8A", 12);
  armor = 3000;
  helmet = 1;
  agent.baseaccuracy = getdvarfloat("dvar_298D4EA8B0934E31", 1.2);
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(undefined, undefined, undefined, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet);
  agent _id_2636152C566D6C64::_id_720C3B7ABF4BAAC8("pyro");
  agent thread _id_371B4C2AB5861E62::_id_0036613FFB5EBE56(agent);
  agent thread _id_120270BD0A747A35::_id_C7307D56A1A61172(agent);
}

_id_B08878702405E6B8() {
  level endon("game_ended");
  _id_2636152C566D6C64::_id_C0D4FDA4400B5A08("pyro");
}