/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: aitype\enemy_base_zombie_sumpf_cp.gsc
*************************************************/

main() {
  self._id_10D2 = "";
  self._id_EAB8 = "regular";
  self._id_0159 = "cover_default_cp";
  self._id_0196 = "enemyselector_default_zombie";
  self._id_04B9 = "zombie";
  self _meth_8310(128.0, 0.0);
  self _meth_830F(256.0, 1024.0);
  self _meth_8311(0.0);
  self._id_001D = 0.01;
  self._id_04F6 = _func_0375();
  self._id_020A = _func_0375();
  self._id_0206 = 0;
}

_id_D7EB(var_0) {
  character\character_zombie_ai_sumpf::_id_9967();
}

_id_0340() {
  var_0 = "actor_enemy_base_zombie_sumpf_cp";

  if(!isDefined(level._id_11ED)) {
    level._id_11ED = [];
  }

  if(!isDefined(level._id_11ED[var_0])) {
    level._id_11ED[var_0] = [];
    level._id_11ED[var_0]["species"] = "human";
    level._id_11ED[var_0]["traversal_unit_type"] = "zombie";
    level._id_11ED[var_0]["health"] = 100;
    level._id_11ED[var_0]["xp"] = 50;
    level._id_11ED[var_0]["reward"] = 300;
    level._id_11ED[var_0]["asm"] = "zombie";
    level._id_11ED[var_0]["radius"] = 15;
    level._id_11ED[var_0]["height"] = 70;
    level._id_11ED[var_0]["behaviorTree"] = "zombie_cp";
    level._id_11ED[var_0]["team"] = "axis";
    level._id_11ED[var_0]["setup_func"] = ::main;
    level._id_11ED[var_0]["setup_model_func"] = ::_id_D7EB;
    character\character_zombie_ai_sumpf::_id_BB60(var_0);
  }

  _id_0008::init();
  _id_0531::_id_C241();
  _id_0525::_id_1C99();
  _id_09A6::_id_11F4();

  if(!isDefined(level._id_E3D9)) {
    level._id_E3D9 = [];
  }

  if(!isDefined(level._id_E3D9["human"])) {
    level._id_E3D9["human"] = [];
  }

  _id_06A8::_id_11016();
}