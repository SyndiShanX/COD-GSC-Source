/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5460cd6692149701.gsc
***********************************************/

main(spawnpoints) {
  level thread _id_B44747CB0CD4EEC0();

  if(!isDefined(level._id_7D37A4F92843AFD2))
    level._id_7D37A4F92843AFD2 = [];

  level._id_5A11797125800495 = [];
  spawnpoints = scripts\engine\utility::getStructArray("incur_wave_spawner", "script_noteworthy");

  foreach(point in spawnpoints) {
    if(isDefined(point.script_area)) {
      if(!isDefined(level._id_7D37A4F92843AFD2[point.script_area]))
        level._id_7D37A4F92843AFD2[point.script_area] = [];

      level._id_7D37A4F92843AFD2[point.script_area][level._id_7D37A4F92843AFD2[point.script_area].size] = point;
    }

    if(isDefined(point.script_flag)) {
      _id_9CF84EC973EE6F67(point);
      continue;
    }

    level._id_5A11797125800495[level._id_5A11797125800495.size] = point;
  }
}

_id_9CF84EC973EE6F67(spawnpoint) {
  level._id_F582A12CB1E46357[level._id_F582A12CB1E46357.size] = spawnpoint;
}

_id_B44747CB0CD4EEC0() {
  level endon("game_ended ");
  level._id_F582A12CB1E46357 = [];

  for(;;) {
    level waittill("spawnpoint_flag", flagname);
    _id_27754596431F547A = [];

    foreach(point in level._id_F582A12CB1E46357) {
      if(point.script_flag == flagname)
        _id_27754596431F547A[_id_27754596431F547A.size] = point;
    }

    level._id_5A11797125800495 = scripts\engine\utility::array_combine(_id_27754596431F547A, level._id_5A11797125800495);
    level._id_F582A12CB1E46357 = scripts\engine\utility::array_remove_array(level._id_F582A12CB1E46357, _id_27754596431F547A);
  }
}

_id_9581045871F15252(struct, maxdist, _id_636C8575D7A7768B, _id_A25052287D3B6768) {
  for(;;) {
    spawnpoint = _id_3B28DEADADA9E76E(struct, maxdist, _id_636C8575D7A7768B, _id_A25052287D3B6768);

    if(isDefined(spawnpoint))
      return spawnpoint;

    wait 0.1;
  }
}

_id_3B28DEADADA9E76E(struct, maxdist, _id_636C8575D7A7768B, _id_A25052287D3B6768) {
  if(!isDefined(maxdist))
    maxdist = 3000;

  if(!isDefined(_id_636C8575D7A7768B))
    _id_636C8575D7A7768B = 1000;

  _id_C00448D30DF1BEA6 = _id_173F238005CB70B9::_id_C1DC7A1D01595216();

  if(isDefined(_id_C00448D30DF1BEA6)) {
    maxdist = 3000;
    _id_636C8575D7A7768B = 250;

    if(isDefined(level._id_21D6479FA8291E5D))
      maxdist = level._id_21D6479FA8291E5D;

    if(isDefined(level._id_2A5522483FDCBA47))
      _id_636C8575D7A7768B = level._id_2A5522483FDCBA47;
  }

  _id_C6736586AE30F7EA = scripts\engine\utility::get_array_of_closest(struct.origin, level._id_5A11797125800495, undefined, undefined, maxdist, _id_636C8575D7A7768B);

  if(!_id_C6736586AE30F7EA.size) {
    iprintln("Incursion Spawning: Failed to find spawnpoint for area near: " + struct.origin);
    _id_C6736586AE30F7EA = getnodesinradius(struct.origin, maxdist, _id_636C8575D7A7768B, 512, "cover");
  }

  _id_2AAD46D2DF2BCE53 = [];

  foreach(node in _id_C6736586AE30F7EA) {
    if(istrue(_id_A25052287D3B6768) && isDefined(node._id_47167C56230449E1)) {
      continue;
    }
    _id_05956C54E54EBF3D = 1;

    foreach(player in level.players) {
      if(distancesquared(player.origin, node.origin) < squared(500)) {
        _id_05956C54E54EBF3D = 0;
        continue;
      }

      if(distancesquared(player.origin, node.origin) > squared(maxdist)) {
        _id_05956C54E54EBF3D = 0;
        continue;
      }

      if(sighttracepassed(player getEye(), node.origin + (0, 0, 40), 1, player, 0)) {
        _id_05956C54E54EBF3D = 0;
        continue;
      }
    }

    if(_id_05956C54E54EBF3D)
      _id_2AAD46D2DF2BCE53[_id_2AAD46D2DF2BCE53.size] = node;
  }

  selected_node = undefined;

  if(isDefined(_id_C00448D30DF1BEA6))
    selected_node = scripts\engine\utility::random_weight_sorted(_id_2AAD46D2DF2BCE53);
  else
    selected_node = scripts\engine\utility::random(_id_2AAD46D2DF2BCE53);

  return selected_node;
}