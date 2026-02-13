/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2486.gsc
*************************************************/

init() {
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "init")]]();
  level thread scripts\cp_mp\killstreaks\airdrop::init();
  level thread _id_09AB::init();
  level thread _id_09B8::init();
  level thread _id_09BC::init();
  level thread _id_09BD::init();
  level thread _id_09B5::init();
  level thread _id_09BA::init();
  level thread _id_09B1::init();
  level thread _id_09B2::init();
  _id_828A();

  if(level.gametype != "br") {
    level thread _id_09B3::init();
    level thread _id_09BB::init();
    level thread _id_09BE::init();
    level thread _id_09AC::init();
    level thread _id_09AD::init();
    level thread _id_09AE::init();
    level thread _id_09B0::init();
    level thread _id_09B2::init();
  }
}

_id_828A() {
  var_0 = _id_09CA::_id_10365("killstreak", 1);
  var_0._id_109E9["missileLocking"] = 2;
}