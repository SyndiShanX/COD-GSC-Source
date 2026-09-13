/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_530002ccbaa5e3b.gsc
***********************************************/

_id_54DFCA3641C2C1AB(_id_D8BFB2D96BC7F634) {
  if(!isDefined(level._id_87766FB0B0A03A87))
    level._id_87766FB0B0A03A87 = [];

  _id_1FC5E3C207DBB9F4 = _id_113AE197E6C38CB8(_id_D8BFB2D96BC7F634);

  if(!isDefined(_id_1FC5E3C207DBB9F4)) {
    _id_1FC5E3C207DBB9F4 = _id_A22FC988697BB76D(_id_D8BFB2D96BC7F634);

    if(_id_1FC5E3C207DBB9F4)
      _id_B6D1131BBF38FD70(_id_D8BFB2D96BC7F634, _id_1FC5E3C207DBB9F4);
  }

  return _id_1FC5E3C207DBB9F4;
}

_id_B6D1131BBF38FD70(_id_615B735DDA2A4C94, _id_1FC5E3C207DBB9F4) {
  if(_id_1FC5E3C207DBB9F4) {
    _id_DAE5B56FEF5253A7 = spawnStruct();
    _id_DAE5B56FEF5253A7.id = _id_615B735DDA2A4C94;
    _id_DAE5B56FEF5253A7.object = _id_1FC5E3C207DBB9F4;
    level._id_87766FB0B0A03A87[level._id_87766FB0B0A03A87.size] = _id_DAE5B56FEF5253A7;
    return 1;
  }

  return 0;
}

_id_113AE197E6C38CB8(_id_9344C8C712054A49) {
  foreach(_id_B643A4A42D8B8DBF in level._id_87766FB0B0A03A87) {
    if(_id_B643A4A42D8B8DBF.id == _id_9344C8C712054A49)
      return _id_B643A4A42D8B8DBF.object;
  }

  return undefined;
}

_id_A22FC988697BB76D(_id_9344C8C712054A49) {
  while(istrue(level._id_6FF7B075BAD15E1B))
    waitframe();

  if(_func_A5EDA2D3293E9225(_id_9344C8C712054A49)) {
    level._id_6FF7B075BAD15E1B = 1;
    _id_615B735DDA2A4C94 = "";
    _id_1FC5E3C207DBB9F4 = undefined;
    _id_BB9730F6CE13F387 = 0;

    while(_id_615B735DDA2A4C94 != _id_9344C8C712054A49)
      level waittill("publisher_download_completed", _id_BB9730F6CE13F387, _id_615B735DDA2A4C94);

    if(_id_BB9730F6CE13F387)
      _id_1FC5E3C207DBB9F4 = _func_E7F8033F0614EB44();

    level._id_6FF7B075BAD15E1B = 0;
    return _id_1FC5E3C207DBB9F4;
  }

  return undefined;
}