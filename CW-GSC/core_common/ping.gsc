/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ping.gsc
***********************************************/

#using script_45fdb6cec5580007;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\ping_shared;
#using scripts\core_common\popups_shared;
#using scripts\core_common\system_shared;
#namespace ping;

function private autoexec __init__system__() {
  system::register(#"ping", undefined, &postinit, undefined, undefined);
}

function private postinit() {
  setDvar(#"hash_1d7aa0dce875f0eb", 1);

  if(!getdvarint(#"hash_449fa75f87a4b5b4", 0)) {
    return;
  }

  level.ping = {
    #players: [], #count: 0, #pings: [], #durations: [60, 60, 10, 15, 20, 30, 15, 15, 25, 25, level.var_142ecedc, 15, 15]
  };
  assert(level.ping.durations.size == 13);
  callback::on_ping(&on_ping);
  callback::on_disconnect(&on_disconnect);
  callback::on_joined_team(&on_joined_team);
  callback::on_spawned(&on_player_spawn);
  callback::on_death(&function_d58bf295);
  callback::on_end_game(&on_end_game);
  callback::function_dd017b2e(&function_dd017b2e);
  level thread update();
}

function function_dd017b2e(params) {
  self function_b56144ae(self function_9c9adcf1(), 17, 0, (0, 0, 0), undefined, undefined, params.title);
}

function private function_77d2f4f5() {
  return level.ping.players[self getentitynumber()];
}

function private function_76fbd527() {
  level.ping.players[self getentitynumber()] = [];
}

function private function_9c9adcf1() {
  if(isDefined(level.var_75bb902f)) {
    return [[level.var_75bb902f]]();
  }

  pingplayers = undefined;

  if(squads::function_a9758423() && isDefined(self.squad)) {
    pingplayers = function_c65231e2(self.squad);
  } else if(isDefined(self.team)) {
    pingplayers = getfriendlyplayers(self.team);
  }

  if(!isDefined(pingplayers)) {
    pingplayers = [];
  } else if(!isarray(pingplayers)) {
    pingplayers = array(pingplayers);
  }

  return pingplayers;
}

function private function_68ee7643() {
  pings = self function_77d2f4f5();
  entnum = self getentitynumber();

  if(isDefined(pings)) {
    foreach(ping in level.ping.pings) {
      if(entnum == ping.playerentnum) {
        function_aa50d3e4(ping);
      }
    }

    self function_b56144ae(self function_9c9adcf1(), 15, 1, (0, 0, 0));
    level.ping.players[self getentitynumber()] = undefined;
  }
}

function private clear_all_pings() {
  foreach(ping in level.ping.pings) {
    ping.player function_b56144ae(ping.player function_9c9adcf1(), ping.eventtype, 1, ping.location, ping.param, ping.id);
    function_aa50d3e4(ping);
  }
}

function on_player_spawn() {
  pings = self function_77d2f4f5();

  if(!isDefined(pings)) {
    self function_76fbd527();
  }
}

function on_joined_team(params) {
  self function_68ee7643();
  self function_76fbd527();
}

function on_disconnect() {
  self function_68ee7643();
}

function on_end_game() {
  clear_all_pings();
}

function function_d58bf295(params) {
  entnum = isentity(self) ? self getentitynumber() : -1;

  foreach(ping in level.ping.pings) {
    if(ping.eventtype != 2 && ping.eventtype != 3 && ping.eventtype != 10) {
      continue;
    }

    if(ping.param != entnum) {
      continue;
    }

    if(!isDefined(ping.player) || !isPlayer(ping.player)) {
      continue;
    }

    ping.player function_b56144ae(ping.player function_9c9adcf1(), ping.eventtype, 1, ping.location, ping.param, ping.id);
    function_aa50d3e4(ping);
  }
}

function function_9455917d(entity) {
  if(!isDefined(level.ping.pings)) {
    return;
  }

  entnum = isentity(entity) ? entity getentitynumber() : -1;

  foreach(ping in level.ping.pings) {
    if(ping.eventtype != 2 && ping.eventtype != 3 && ping.eventtype != 10 && ping.eventtype != 8) {
      continue;
    }

    if(ping.param != entnum) {
      continue;
    }

    ping.player function_b56144ae(ping.player function_9c9adcf1(), ping.eventtype, 1, ping.location, ping.param, ping.id);
    function_aa50d3e4(ping);
  }
}

function private function_c5f0d88f(player, eventtype, location, param) {
  pool = function_5947d757(eventtype);
  ping = spawnStruct();
  ping.player = player;
  ping.playerentnum = player getentitynumber();
  ping.eventtype = eventtype;
  ping.pooltype = pool;
  ping.location = location;
  ping.param = param;
  assert(isDefined(level.ping.durations[eventtype]));
  duration = level.ping.durations[eventtype];

  if(isfunctionptr(duration)) {
    duration = [[duration]](param);
  }

  if(duration >= 0) {
    ping.expiration = gettime() + int(duration * 1000);
  }

  ping.id = level.ping.count;
  var_6e071234 = player function_77d2f4f5();
  assert(isDefined(var_6e071234));

  if(isDefined(var_6e071234[pool]) && var_6e071234[pool].size >= function_44806bba(eventtype)) {
    function_aa50d3e4(var_6e071234[pool][0]);
  }

  assert(!isDefined(level.ping.pings[ping.id]));

  if(isDefined(level.ping.pings[ping.id])) {
    function_aa50d3e4(level.ping.pings[ping.id]);
  }

  level.ping.pings[ping.id] = ping;
  level.ping.count++;

  if(level.ping.count >= 16384) {
    level.ping.count = 0;
  }

  if(!isDefined(var_6e071234[pool])) {
    var_6e071234[pool] = [];
  } else if(!isarray(var_6e071234[pool])) {
    var_6e071234[pool] = array(var_6e071234[pool]);
  }

  var_6e071234[pool][var_6e071234[pool].size] = ping;
  return ping;
}

function function_bbe2694a(networkid) {
  if(!isDefined(level.ping.pings)) {
    return;
  }

  foreach(ping in level.ping.pings) {
    if(ping.pooltype == 4 && ping.param == networkid) {
      if(isPlayer(ping.player)) {
        ping.player function_b56144ae(ping.player function_9c9adcf1(), ping.eventtype, 1, ping.location, ping.param, ping.id);
      }

      function_aa50d3e4(ping);
      break;
    }
  }
}

function private function_aa50d3e4(ping) {
  assert(isDefined(level.ping.pings[ping.id]));
  level.ping.pings[ping.id] = undefined;
  assert(isDefined(level.ping.players[ping.playerentnum][ping.pooltype]));
  var_2d64756e = level.ping.players[ping.playerentnum][ping.pooltype];

  if(!isDefined(var_2d64756e)) {
    return;
  }

  index = array::find(var_2d64756e, ping);
  assert(isDefined(index));

  if(var_2d64756e.size == 1) {
    level.ping.players[ping.playerentnum][ping.pooltype] = undefined;
    return;
  }

  if(isDefined(index)) {
    array::pop(var_2d64756e, index, 0);
  }
}

function private function_220a4754(ping, param) {
  return ping.param === param;
}

function private function_cff0c866(player, event_type, param) {
  var_6e071234 = player function_77d2f4f5();
  pool = function_5947d757(event_type);
  assert(isDefined(var_6e071234));

  if(isDefined(var_6e071234[pool])) {
    index = array::find(var_6e071234[pool], param, &function_220a4754);

    if(isDefined(index)) {
      ping = var_6e071234[pool][index];
      function_aa50d3e4(ping);
    }
  }

  return ping;
}

function private on_ping(params) {
  player = params.player;
  eventtype = params.type;
  remove = params.remove;
  param = params.param;
  location = params.location;
  assert(isDefined(eventtype));
  targets = player function_9c9adcf1();

  if(eventtype < 13) {
    if(remove) {
      ping = function_cff0c866(player, eventtype, param);
    } else {
      ping = function_c5f0d88f(player, eventtype, location, param);
    }

    id = ping.id;

    if(isDefined(id)) {
      player function_b56144ae(targets, eventtype, remove, location, param, id);
    }

    return;
  }

  player function_b56144ae(targets, eventtype, remove, location, param);
}

function private update() {
  while(true) {
    time = gettime();

    foreach(ping in level.ping.pings) {
      if(isDefined(ping.expiration) && ping.expiration < time) {
        targets = ping.player function_9c9adcf1();

        if(isDefined(level.var_75bb902f)) {
          targets = [[level.var_75bb902f]]();
        }

        ping.player function_b56144ae(targets, ping.eventtype, 1, ping.location, ping.param, ping.id);
        function_aa50d3e4(ping);
      }
    }

    wait 1;
  }
}