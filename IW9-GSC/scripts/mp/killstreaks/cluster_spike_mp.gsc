/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\cluster_spike_mp.gsc
*******************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("cluster_spike", _id_10AD6174C8938599::_id_4D4DFA5C57455DF0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cluster_spike", "attachXRays", ::_id_D0F5E3C6E6080D5D);
}

_id_D0F5E3C6E6080D5D(_id_A051766A1EC54371) {
  _id_A051766A1EC54371 _meth_5226227BCE83EBE9(3, _id_A051766A1EC54371.team);
  return _id_A051766A1EC54371;
}