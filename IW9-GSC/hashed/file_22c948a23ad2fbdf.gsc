/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_22c948a23ad2fbdf.gsc
***********************************************/

_id_CE55987060167D4A() {
  if(getdvarint("dvar_3DEF865B1007AA0A", 0) <= 0) {
    return;
  }
  level thread _id_42FE8C75207B05B3();
}

_id_42FE8C75207B05B3() {
  level endon("game_ended");
  ai_spawned = [];
  _id_C7054A3E2319DF68 = 0;
  setdvarifuninitialized("dvar_644B3F4397FA5D18", 10);
  setdvarifuninitialized("dvar_D01329968E8441BF", 500);

  for(;;) {
    if(getdvarint("dvar_3DEF865B1007AA0A", 0) <= 0) {
      foreach(ai in ai_spawned) {
        if(isalive(ai))
          ai kill();
      }

      return;
    }

    _id_C7CEBF8A7DEB73E3 = getdvarint("dvar_644B3F4397FA5D18");
    _id_C7CEBF8A7DEB73E3 = int(clamp(_id_C7CEBF8A7DEB73E3, 0, 1000));
    setDvar("dvar_644B3F4397FA5D18", _id_C7CEBF8A7DEB73E3);
    radius = getdvarint("dvar_D01329968E8441BF");
    radius = int(clamp(radius, 100, 1000));
    setDvar("dvar_D01329968E8441BF", radius);
    _id_B837203C7887F6D1 = [];

    foreach(ai in ai_spawned) {
      if(isalive(ai))
        _id_B837203C7887F6D1 = scripts\engine\utility::array_add(_id_B837203C7887F6D1, ai);
    }

    ai_spawned = _id_B837203C7887F6D1;

    if(ai_spawned.size > _id_C7CEBF8A7DEB73E3 && ai_spawned.size > 0) {
      for(_id_97CCE0DC6B073D08 = _id_C7CEBF8A7DEB73E3; _id_97CCE0DC6B073D08 < ai_spawned.size; _id_97CCE0DC6B073D08++) {
        if(isalive(ai_spawned[_id_97CCE0DC6B073D08]))
          ai_spawned[_id_97CCE0DC6B073D08] kill();
      }
    } else if(ai_spawned.size < _id_C7CEBF8A7DEB73E3) {
      _id_C7054A3E2319DF68++;

      if(isDefined(level.players) && level.players.size > 0) {
        target_player = level.players[_id_C7054A3E2319DF68 % level.players.size];

        if(isDefined(target_player) && isalive(target_player)) {
          radius = getdvarint("dvar_D01329968E8441BF");
          spawn_point = getrandomnavpoint(target_player.origin, radius);

          if(isDefined(spawn_point))
            spawn_point = getgroundposition(spawn_point, 8);

          if(isDefined(spawn_point)) {
            aitype = getDvar("dvar_07C41690A3FF1013", "none");

            if(aitype != "none") {
              team = scripts\engine\utility::get_enemy_team(target_player.team);
              _id_532E00D11C821535 = getDvar("dvar_0FA5440523090320", "none");

              if(_id_532E00D11C821535 != "none")
                team = _id_532E00D11C821535;

              agent = scripts\mp\mp_agent::spawnnewagentaitype(aitype, spawn_point, (0, 0, 0), team);

              if(isDefined(agent))
                ai_spawned[ai_spawned.size] = agent;
            }
          }
        }
      }
    }

    waitframe();
  }
}