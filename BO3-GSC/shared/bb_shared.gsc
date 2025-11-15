/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\bb_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace bb;

function init_shared() {
  callback::on_start_gametype( & init);
}

function init() {
  callback::on_connect( & player_init);
  callback::on_spawned( & on_player_spawned);
}

function player_init() {
  self thread on_player_death();
}

function on_player_spawned() {
  self endon("disconnect");
  self._bbdata = [];
  self._bbdata["score"] = 0;
  self._bbdata["momentum"] = 0;
  self._bbdata["spawntime"] = gettime();
  self._bbdata["shots"] = 0;
  self._bbdata["hits"] = 0;
}

function on_player_disconnect() {
  for(;;) {
    self waittill("disconnect");
    self commit_spawn_data();
    break;
  }
}

function on_player_death() {
  self endon("disconnect");
  for(;;) {
    self waittill("death");
    self commit_spawn_data();
  }
}

function commit_spawn_data() {
  /
  #
  assert(isDefined(self._bbdata));
  if(!isDefined(self._bbdata)) {
    return;
  }
  bbprint("mpplayerlives", "gametime %d spawnid %d lifescore %d lifemomentum %d lifetime %d name %s", gettime(), getplayerspawnid(self), self._bbdata["score"], self._bbdata["momentum"], gettime() - self._bbdata["spawntime"], self.name);
}

function commit_weapon_data(spawnid, currentweapon, time0) {
  /
  #
  assert(isDefined(self._bbdata));
  if(!isDefined(self._bbdata)) {
    return;
  }
  time1 = gettime();
  blackboxeventname = "mpweapons";
  if(sessionmodeiscampaigngame()) {
    blackboxeventname = "cpweapons";
  } else if(sessionmodeiszombiesgame()) {
    blackboxeventname = "zmweapons";
  }
  bbprint(blackboxeventname, "spawnid %d name %s duration %d shots %d hits %d", spawnid, currentweapon.name, time1 - time0, self._bbdata["shots"], self._bbdata["hits"]);
  self._bbdata["shots"] = 0;
  self._bbdata["hits"] = 0;
}

function add_to_stat(statname, delta) {
  if(isDefined(self._bbdata) && isDefined(self._bbdata[statname])) {
    self._bbdata[statname] = self._bbdata[statname] + delta;
  }
}

function recordbbdataforplayer(breadcrumb_table) {
  if(isDefined(level.gametype) && level.gametype === "doa") {
    return;
  }
  playerlifeidx = self getmatchrecordlifeindex();
  if(playerlifeidx == -1) {
    return;
  }
  movementtype = "";
  stance = "";
  bbprint(breadcrumb_table, "gametime %d lifeIndex %d posx %d posy %d posz %d yaw %d pitch %d movetype %s stance %s", gettime(), playerlifeidx, self.origin, self.angles[0], self.angles[1], movementtype, stance);
}

function recordblackboxbreadcrumbdata(breadcrumb_table) {
  level endon("game_ended");
  if(!sessionmodeisonlinegame() || (isDefined(level.gametype) && level.gametype === "doa")) {
    return;
  }
  while(true) {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      if(isalive(player)) {
        player recordbbdataforplayer(breadcrumb_table);
      }
    }
    wait(2);
  }
}