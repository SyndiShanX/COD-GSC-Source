/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\debug.gsc
***********************************************/

drawent(ent, radius, _id_F614DCDAFD466705, _id_7CADCF765F48D20B, color) {
  _id_F8A269392B9C9B15 = int(_id_7CADCF765F48D20B / level.framedurationseconds);

  for(frame = 0; frame < _id_F8A269392B9C9B15; frame++)
    waitframe();
}

drawline(start, end, _id_7CADCF765F48D20B, color) {
  _id_F8A269392B9C9B15 = int(_id_7CADCF765F48D20B / level.framedurationseconds);

  for(frame = 0; frame < _id_F8A269392B9C9B15; frame++)
    waitframe();
}

drawsphere(origin, radius, _id_7CADCF765F48D20B, color) {
  _id_F8A269392B9C9B15 = int(_id_7CADCF765F48D20B / level.framedurationseconds);

  for(frame = 0; frame < _id_F8A269392B9C9B15; frame++)
    waitframe();
}

_id_0C577C013F8789A8(origin, text, _id_7CADCF765F48D20B, color) {
  _id_F8A269392B9C9B15 = int(_id_7CADCF765F48D20B / level.framedurationseconds);

  for(frame = 0; frame < _id_F8A269392B9C9B15; frame++)
    waitframe();
}

drawangles(origin, angles, _id_3E6845817408F87E, _id_B79930868F410231) {
  if(!isDefined(_id_B79930868F410231))
    _id_B79930868F410231 = 1;

  _id_F8A269392B9C9B15 = int(_id_3E6845817408F87E / level.framedurationseconds);

  for(frame = 0; frame < _id_F8A269392B9C9B15; frame++) {
    fwd = anglesToForward(angles);
    right = anglestoright(angles);
    up = anglestoup(angles);
    waitframe();
  }
}