/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\agents\dog\dog_agent.gsc
*************************************************/

_id_C2AF() {
  _id_0008::init();
  _id_09A6::_id_11F4();

  if(!isDefined(level._id_E3D9)) {
    level._id_E3D9 = [];
  }

  if(!isDefined(level._id_E3D9["dog"])) {
    level._id_E3D9["dog"] = [];
  }

  level._id_11ED["actor_enemy_cp_dog"]["setup_func"] = ::_id_D843;
  level._id_11ED["actor_enemy_cp_dog"]["setup_model_func"] = ::_id_D88F;
}

_id_D843() {
  self._id_189C = "dog";
  self._id_0159 = "cover_default";
  self._id_10691 = "russian";
  self._id_04B9 = "dog";
  self _meth_8310(256.0, 0.0);
  self _meth_830F(768.0, 1024.0);
}

_id_D88F(var_0, var_1) {
  self._id_7612 = undefined;
  self setModel("test_character_dog_mp");
}