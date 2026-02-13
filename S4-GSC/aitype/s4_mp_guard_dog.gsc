/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: aitype\s4_mp_guard_dog.gsc
*************************************************/

main() {
  self._id_10D2 = "";
  self._id_EAB8 = "regular";
  self._id_0159 = "cover_default";
  self._id_0196 = "enemyselector_default";
  self._id_04B9 = "dog";
  self _meth_8310(256.0, 0.0);
  self _meth_830F(768.0, 1024.0);
  self _meth_8311(0.0);
  self._id_001D = 0.2;
  self._id_04F6 = _func_0375();
  self._id_020A = _func_0375();
  self._id_0206 = 0;
}

_id_D7EB(var_0) {
  var_1 = undefined;
  var_2 = ["c_s4_guard_dog_enemy", "c_s4_guard_dog_friendly"];

  switch (_id_06C4::_id_66D6(2, var_1, var_2, "actor_s4_mp_guard_dog")) {
    case 0:
      _id_0537::_id_9967();
      break;
    case 1:
      _id_0538::_id_9967();
      break;
  }
}

_id_0340() {
  var_0 = "actor_s4_mp_guard_dog";

  if(!isDefined(level._id_11ED)) {
    level._id_11ED = [];
  }

  if(!isDefined(level._id_11ED[var_0])) {
    level._id_11ED[var_0] = [];
    level._id_11ED[var_0]["species"] = "human";
    level._id_11ED[var_0]["traversal_unit_type"] = "dog";
    level._id_11ED[var_0]["health"] = 150;
    level._id_11ED[var_0]["xp"] = 50;
    level._id_11ED[var_0]["reward"] = 50;
    level._id_11ED[var_0]["asm"] = "dog";
    level._id_11ED[var_0]["radius"] = 15;
    level._id_11ED[var_0]["height"] = 70;
    level._id_11ED[var_0]["behaviorTree"] = "dog_agent";
    level._id_11ED[var_0]["team"] = "axis";
    level._id_11ED[var_0]["setup_func"] = ::main;
    level._id_11ED[var_0]["setup_model_func"] = ::_id_D7EB;
    _id_0537::_id_BB60(var_0);
    _id_0538::_id_BB60(var_0);
  }

  _id_0008::init();
  _id_052A::_id_C241();
  _id_0515::_id_1C99();
  _id_09A6::_id_11F4();

  if(!isDefined(level._id_E3D9)) {
    level._id_E3D9 = [];
  }

  if(!isDefined(level._id_E3D9["human"])) {
    level._id_E3D9["human"] = [];
  }

  _id_06A8::_id_0179();
}