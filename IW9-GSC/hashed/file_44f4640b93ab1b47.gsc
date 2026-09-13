/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_44f4640b93ab1b47.gsc
***********************************************/

_id_0360128EC8C9D243() {
  level._id_34EACC4BA5C409A7 = [];
  level thread _id_8371656CAC31E3E5();
  level thread _id_EE39A757E5AB8FBE();
}

_id_8371656CAC31E3E5() {
  level endon("game_ended");

  for(;;) {
    level waittill("uav_started", _id_CDC9BEE1ECFE4526);

    if(!isDefined(_id_CDC9BEE1ECFE4526) || isbot(_id_CDC9BEE1ECFE4526)) {
      continue;
    }
    level._id_34EACC4BA5C409A7[_id_CDC9BEE1ECFE4526 getentitynumber()] = _id_CDC9BEE1ECFE4526;
  }
}

_id_EE39A757E5AB8FBE() {
  level endon("game_ended");

  for(;;) {
    level waittill("uav_finished", _id_CDC9BEE1ECFE4526);

    if(isbot(_id_CDC9BEE1ECFE4526)) {
      continue;
    }
    if(isDefined(_id_CDC9BEE1ECFE4526))
      level._id_34EACC4BA5C409A7[_id_CDC9BEE1ECFE4526 getentitynumber()] = undefined;

    level._id_34EACC4BA5C409A7 = scripts\engine\utility::array_removeundefined(level._id_34EACC4BA5C409A7);
  }
}

_id_0296623D26E11725() {
  return level._id_34EACC4BA5C409A7.size > 0;
}