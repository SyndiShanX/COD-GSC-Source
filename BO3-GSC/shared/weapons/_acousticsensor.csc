/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_acousticsensor.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace acousticsensor;

function init_shared() {
  level._effect["acousticsensor_enemy_light"] = "_t6/misc/fx_equip_light_red";
  level._effect["acousticsensor_friendly_light"] = "_t6/misc/fx_equip_light_green";
  if(!isDefined(level.acousticsensors)) {
    level.acousticsensors = [];
  }
  if(!isDefined(level.acousticsensorhandle)) {
    level.acousticsensorhandle = 0;
  }
  callback::on_localclient_connect(&on_player_connect);
  callback::add_weapon_type("acoustic_sensor", &spawned);
}

function on_player_connect(localclientnum) {
  setlocalradarenabled(localclientnum, 0);
  if(localclientnum == 0) {
    level thread updateacousticsensors();
  }
}

function addacousticsensor(handle, sensorent, owner) {
  acousticsensor = spawnStruct();
  acousticsensor.handle = handle;
  acousticsensor.sensorent = sensorent;
  acousticsensor.owner = owner;
  size = level.acousticsensors.size;
  level.acousticsensors[size] = acousticsensor;
}

function removeacousticsensor(acousticsensorhandle) {
  for(i = 0; i < level.acousticsensors.size; i++) {
    last = level.acousticsensors.size - 1;
    if(level.acousticsensors[i].handle == acousticsensorhandle) {
      level.acousticsensors[i].handle = level.acousticsensors[last].handle;
      level.acousticsensors[i].sensorent = level.acousticsensors[last].sensorent;
      level.acousticsensors[i].owner = level.acousticsensors[last].owner;
      level.acousticsensors[last] = undefined;
      return;
    }
  }
}

function spawned(localclientnum) {
  handle = level.acousticsensorhandle;
  level.acousticsensorhandle++;
  self thread watchshutdown(handle);
  owner = self getowner(localclientnum);
  addacousticsensor(handle, self, owner);
  util::local_players_entity_thread(self, &spawnedperclient);
}

function spawnedperclient(localclientnum) {
  self endon("entityshutdown");
  self thread fx::blinky_light(localclientnum, "tag_light", level._effect["acousticsensor_friendly_light"], level._effect["acousticsensor_enemy_light"]);
}

function watchshutdown(handle) {
  self waittill("entityshutdown");
  removeacousticsensor(handle);
}

function updateacousticsensors() {
  self endon("entityshutdown");
  localradarenabled = [];
  previousacousticsensorcount = -1;
  util::waitforclient(0);
  while(true) {
    localplayers = level.localplayers;
    if(previousacousticsensorcount != 0 || level.acousticsensors.size != 0) {
      for(i = 0; i < localplayers.size; i++) {
        localradarenabled[i] = 0;
      }
      for(i = 0; i < level.acousticsensors.size; i++) {
        if(isDefined(level.acousticsensors[i].sensorent.stunned) && level.acousticsensors[i].sensorent.stunned) {
          continue;
        }
        for(j = 0; j < localplayers.size; j++) {
          if(localplayers[j] == level.acousticsensors[i].sensorent getowner(j)) {
            localradarenabled[j] = 1;
            setlocalradarposition(j, level.acousticsensors[i].sensorent.origin);
          }
        }
      }
      for(i = 0; i < localplayers.size; i++) {
        setlocalradarenabled(i, localradarenabled[i]);
      }
    }
    previousacousticsensorcount = level.acousticsensors.size;
    wait(0.1);
  }
}