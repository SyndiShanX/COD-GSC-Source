/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\cinematic_replays\cinematic_replays.gsc
**************************************************************/

listenforcinematicreplaydumpcmd() {
  level endon("game_ended");
  level.cinematic_replay_recording = 1;
  level.cinematicreplaystrings = [];
  level.cinematicreplaystringsconcat = [];
  level thread onplayerspawned();
  level thread recordplayerlogs();
  level thread dumplogsloop();
}

dumplogsloop() {
  level endon("game_ended");

  for(;;) {
    wait 1;
    cinematicreplayrecording_scriptdata_dump();
    level.cinematicreplaystringsconcat = [];
  }
}

recordplayerlogs() {
  level endon("game_ended");
  _id_A062DEAE533A847B = 0;

  for(;;) {
    waitframe();
    logplayers(_id_A062DEAE533A847B);
    _id_A062DEAE533A847B++;
  }
}

cinematicreplay_scriptdata_openfilewrite() {}

cinematicreplayrecording_scriptdata_dump() {}

onplayerspawned() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    player.shotrecord = [];
    player.hitrecord = [];
    player thread watchweaponusage();
  }
}

watchweaponusage(_id_E9A9DC280D811788) {
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_fired", objweapon);
    s = spawnStruct();
    s.vpoint = self.origin;
    s.vdir = self getgunangles();
    self.shotrecord[self.shotrecord.size] = s;
  }
}

logplayers(_id_A062DEAE533A847B) {
  players = level.players;
  _id_DF1A8324A4E896EA = [];
  time = gettime();
  _id_56D86A222955B3B9 = "";

  if(players.size == 0) {
    return;
  }
  _id_2320C6B8B9EA77A3 = int(4);
  _id_FD4B2CD204C0386C = int(ceil(players.size / _id_2320C6B8B9EA77A3));
  _id_44795E4D2A9411B4 = int(_id_A062DEAE533A847B % _id_FD4B2CD204C0386C);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2320C6B8B9EA77A3; _id_AC0E594AC96AA3A8++) {
    index = _id_44795E4D2A9411B4 * _id_2320C6B8B9EA77A3 + _id_AC0E594AC96AA3A8;

    if(index >= players.size) {
      break;
    }

    player = players[index];

    if(isDefined(player) && scripts\mp\utility\player::isreallyalive(player)) {
      _id_56D86A222955B3B9 = _id_56D86A222955B3B9 + ("T " + player getentitynumber() + " " + player.team + " ");
      pos = int(player.origin[0]) + "," + int(player.origin[1]) + "," + int(player.origin[2]);
      angle = int(player.angles[0]) + "," + int(player.angles[1]) + "," + int(player.angles[2]);
      _id_DF1A8324A4E896EA[_id_DF1A8324A4E896EA.size] = "P " + time + " " + player getentitynumber() + " " + pos + " " + angle + " ";

      if(isDefined(player.hitrecord)) {
        foreach(hitrecord in player.hitrecord) {
          _id_7D075B312DFD80C5 = int(hitrecord.vpoint[0]) + "," + int(hitrecord.vpoint[1]) + "," + int(hitrecord.vpoint[2]);
          _id_DEB4F36CEAEA595C = int(hitrecord.vdir[0]) + "," + int(hitrecord.vdir[1]) + "," + int(hitrecord.vdir[2]);
          _id_DF1A8324A4E896EA[_id_DF1A8324A4E896EA.size - 1] = _id_DF1A8324A4E896EA[_id_DF1A8324A4E896EA.size - 1] + ("H " + time + " " + player getentitynumber() + " " + hitrecord.victim getentitynumber() + " " + _id_7D075B312DFD80C5 + " " + _id_DEB4F36CEAEA595C + " " + hitrecord.kill + " ");
        }

        player.hitrecord = [];
      }

      if(isDefined(player.shotrecord)) {
        foreach(shotrecord in player.shotrecord) {
          _id_7D075B312DFD80C5 = int(shotrecord.vpoint[0]) + "," + int(shotrecord.vpoint[1]) + "," + int(shotrecord.vpoint[2]);
          _id_DEB4F36CEAEA595C = int(shotrecord.vdir[0]) + "," + int(shotrecord.vdir[1]) + "," + int(shotrecord.vdir[2]);
          _id_DF1A8324A4E896EA[_id_DF1A8324A4E896EA.size - 1] = _id_DF1A8324A4E896EA[_id_DF1A8324A4E896EA.size - 1] + ("S " + time + " " + player getentitynumber() + " " + _id_7D075B312DFD80C5 + " " + _id_DEB4F36CEAEA595C + " ");
        }

        player.shotrecord = [];
      }

      _id_DF1A8324A4E896EA[_id_DF1A8324A4E896EA.size - 1] = _id_DF1A8324A4E896EA[_id_DF1A8324A4E896EA.size - 1] + "\n";
      level.cinematicreplaystrings[level.cinematicreplaystrings.size] = _id_DF1A8324A4E896EA[_id_DF1A8324A4E896EA.size - 1];
    }
  }

  if(level.cinematicreplaystrings.size > 50) {
    _id_8B2444D1A63048CC = _id_56D86A222955B3B9;

    foreach(s in level.cinematicreplaystrings)
    _id_8B2444D1A63048CC = _id_8B2444D1A63048CC + s;

    level.cinematicreplaystrings = [];
    level.cinematicreplaystringsconcat[level.cinematicreplaystringsconcat.size] = _id_8B2444D1A63048CC;
  }
}