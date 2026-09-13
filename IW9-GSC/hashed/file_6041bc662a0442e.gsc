/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6041bc662a0442e.gsc
***********************************************/

_id_F383491974A17B9A() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("airdrop_escort", _id_07E994E91383C7BA::_id_45378F51950E7D1F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop_escort", "attachXRays", ::_id_1F3181D1053887E6);
}

_id_1F3181D1053887E6(escortheli) {
  escortheli _meth_5226227BCE83EBE9(3, escortheli.team);
  return escortheli;
}