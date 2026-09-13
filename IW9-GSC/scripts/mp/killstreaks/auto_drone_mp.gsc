/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\auto_drone_mp.gsc
****************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("auto_drone", _id_0B6E69AC53E6EE66::_id_987A0AB2646445E1);
  scripts\cp_mp\utility\script_utility::registersharedfunc("auto_drone", "attachXRays", ::_id_76DB348491610F8A);
}

_id_76DB348491610F8A(_id_A24A061A7076376C) {
  _id_A24A061A7076376C _meth_5226227BCE83EBE9(3, _id_A24A061A7076376C.team);
  return _id_A24A061A7076376C;
}