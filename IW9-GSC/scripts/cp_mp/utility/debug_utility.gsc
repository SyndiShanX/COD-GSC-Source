/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\debug_utility.gsc
***************************************************/

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

drawcylinder(origin, radius, height, _id_7CADCF765F48D20B, color) {
  _id_F8A269392B9C9B15 = int(_id_7CADCF765F48D20B / level.framedurationseconds);

  for(frame = 0; frame < _id_F8A269392B9C9B15; frame++)
    waitframe();
}

drawboxfrompoints(_id_35A43F1D588A99BC, _id_2E27BD18DFE68565, _id_3034B10EE587F92E, _id_23F57BE14A18A221, _id_5DE23E0BAFEEEB6A, _id_F5245E120DE48DB3, _id_2FEBBCB4C37B3B64, _id_3A64B6F876A6B09F, _id_7CADCF765F48D20B, color) {
  thread drawline(_id_35A43F1D588A99BC, _id_2E27BD18DFE68565, _id_7CADCF765F48D20B, color);
  thread drawline(_id_35A43F1D588A99BC, _id_5DE23E0BAFEEEB6A, _id_7CADCF765F48D20B, color);
  thread drawline(_id_35A43F1D588A99BC, _id_3034B10EE587F92E, _id_7CADCF765F48D20B, color);
  thread drawline(_id_2E27BD18DFE68565, _id_23F57BE14A18A221, _id_7CADCF765F48D20B, color);
  thread drawline(_id_2E27BD18DFE68565, _id_F5245E120DE48DB3, _id_7CADCF765F48D20B, color);
  thread drawline(_id_3034B10EE587F92E, _id_2FEBBCB4C37B3B64, _id_7CADCF765F48D20B, color);
  thread drawline(_id_3034B10EE587F92E, _id_23F57BE14A18A221, _id_7CADCF765F48D20B, color);
  thread drawline(_id_23F57BE14A18A221, _id_3A64B6F876A6B09F, _id_7CADCF765F48D20B, color);
  thread drawline(_id_5DE23E0BAFEEEB6A, _id_F5245E120DE48DB3, _id_7CADCF765F48D20B, color);
  thread drawline(_id_5DE23E0BAFEEEB6A, _id_2FEBBCB4C37B3B64, _id_7CADCF765F48D20B, color);
  thread drawline(_id_F5245E120DE48DB3, _id_3A64B6F876A6B09F, _id_7CADCF765F48D20B, color);
  thread drawline(_id_3A64B6F876A6B09F, _id_2FEBBCB4C37B3B64, _id_7CADCF765F48D20B, color);
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