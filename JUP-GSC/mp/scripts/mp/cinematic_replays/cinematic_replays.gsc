/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\cinematic_replays\cinematic_replays.gsc
**************************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\matchdata;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#namespace cinematic_replays;

function listenforcinematicreplaydumpcmd() {
  level endon("game_ended");

  setdevdvarifuninitialized(@ "hash_357d41892beace43", 0);

  level.cinematic_replay_recording = 1;
  level.cinematicreplaystrings = [];
  level.cinematicreplaystringsconcat = [];
  level thread onplayerspawned();
  level thread recordplayerlogs();
  level thread dumplogsloop();
}

function dumplogsloop() {
  level endon("game_ended");

  while(true) {
    wait 1;
    cinematicreplayrecording_scriptdata_dump();
    level.cinematicreplaystringsconcat = [];
  }
}

function recordplayerlogs() {
  level endon("game_ended");

  for(logcounter = 0; true; logcounter++) {
    waitframe();
    logplayers(logcounter);
  }
}

function cinematicreplay_scriptdata_openfilewrite() {
  assertex(!isDefined(level.var_ac13a3f4ca2c6c83), "<dev string:x1c>");
  level.var_bf3c698ca4fc6620 = "<dev string:x73>" + level.script + "<dev string:x9a>" + getgametype() + "<dev string:x9a>" + scripts\mp\matchdata::getmatchstarttimeutc() + "<dev string:x9f>";
  fileid = openfile(level.var_bf3c698ca4fc6620, "<dev string:xa7>");

  if(fileid == -1) {
    assertmsg("<dev string:xb1>" + level.var_bf3c698ca4fc6620);
  }

  return fileid;
}

function cinematicreplayrecording_scriptdata_dump() {
  fileid = -1;
  var_9d2bd5edd00cbee2 = 3;
  var_6433283c218b01f1 = 4;
  fileid = cinematicreplay_scriptdata_openfilewrite();

  if(fileid == -1) {
    return;
  }

  foreach(s in level.cinematicreplaystringsconcat) {
    fprintln(fileid, s);
  }

  fileid = closefile(fileid);

  if(fileid == -1) {
    assertmsg("<dev string:xf6>" + level.var_bf3c698ca4fc6620);
  }
}

function onplayerspawned() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    player.shotrecord = [];
    player.hitrecord = [];
    player thread watchweaponusage();
  }
}

function watchweaponusage(weaponhand) {
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

function logplayers(logcounter) {
  players = level.players;
  playerstrings = [];
  time = gettime();
  teamstring = "";

  if(players.size == 0) {
    return;
  }

  var_2320c6b8b9ea77a3 = int(4);
  logsteps = int(ceil(players.size / var_2320c6b8b9ea77a3));
  playerset = int(logcounter % logsteps);

  for(i = 0; i < var_2320c6b8b9ea77a3; i++) {
    index = playerset * var_2320c6b8b9ea77a3 + i;

    if(index >= players.size) {
      break;
    }

    player = players[index];

    if(isDefined(player) && scripts\mp\utility\player::isreallyalive(player)) {
      teamstring += "T " + player getentitynumber() + " " + player.team + " ";
      pos = int(player.origin[0]) + "," + int(player.origin[1]) + "," + int(player.origin[2]);
      angle = int(player.angles[0]) + "," + int(player.angles[1]) + "," + int(player.angles[2]);
      playerstrings[playerstrings.size] = "P " + time + " " + player getentitynumber() + " " + pos + " " + angle + " ";

      if(isDefined(player.hitrecord)) {
        foreach(hitrecord in player.hitrecord) {
          shotpos = int(hitrecord.vpoint[0]) + "," + int(hitrecord.vpoint[1]) + "," + int(hitrecord.vpoint[2]);
          var_deb4f36ceaea595c = int(hitrecord.vdir[0]) + "," + int(hitrecord.vdir[1]) + "," + int(hitrecord.vdir[2]);
          playerstrings[playerstrings.size - 1] += "H " + time + " " + player getentitynumber() + " " + hitrecord.victim getentitynumber() + " " + shotpos + " " + var_deb4f36ceaea595c + " " + hitrecord.kill + " ";
        }

        player.hitrecord = [];
      }

      if(isDefined(player.shotrecord)) {
        foreach(shotrecord in player.shotrecord) {
          shotpos = int(shotrecord.vpoint[0]) + "," + int(shotrecord.vpoint[1]) + "," + int(shotrecord.vpoint[2]);
          var_deb4f36ceaea595c = int(shotrecord.vdir[0]) + "," + int(shotrecord.vdir[1]) + "," + int(shotrecord.vdir[2]);
          playerstrings[playerstrings.size - 1] += "S " + time + " " + player getentitynumber() + " " + shotpos + " " + var_deb4f36ceaea595c + " ";
        }

        player.shotrecord = [];
      }

      playerstrings[playerstrings.size - 1] += "\n";
      level.cinematicreplaystrings[level.cinematicreplaystrings.size] = playerstrings[playerstrings.size - 1];
    }
  }

  if(level.cinematicreplaystrings.size > 50) {
    var_8b2444d1a63048cc = teamstring;

    foreach(s in level.cinematicreplaystrings) {
      var_8b2444d1a63048cc += s;
    }

    level.cinematicreplaystrings = [];
    level.cinematicreplaystringsconcat[level.cinematicreplaystringsconcat.size] = var_8b2444d1a63048cc;
  }
}