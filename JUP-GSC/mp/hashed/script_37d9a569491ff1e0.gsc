/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_37d9a569491ff1e0.gsc
*************************************************/

#using script_26ccbfe3954cacf4;
#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\game;
#namespace nearby_targets;

function createevent(radius) {
  event = function_c74368899713e7e6();
  event.radius = radius;
  event.radiussquared = radius * radius;
  event.result = [];

  if(getsubgametype() == "ob" || getdvarint(@ "hash_484a3169a5caef10", 0)) {
    event.searchtypes = 4294967295;
  } else {
    event.searchtypes = 1 | 2;
  }

  eventstream = self.mind.eventstream;
  eventstream.nearbytargets = event;
  eventstream.events[eventstream.events.size] = event;
}

function getevent(searchtypes) {
  event = self.mind.eventstream.nearbytargets;

  if(!event.evaluated) {
    if(event.result.size > 0) {
      event.result = [];
    }

    searchtypes = default_to(searchtypes, event.searchtypes);

    if(searchtypes &(1 | 2)) {
      foreach(player in level.players) {
        if(self == player || !isDefined(player) || distancesquared(self.origin, player.origin) > event.radiussquared || !isaliveplayer(player) || player namespace_95d8d8ec67e3e074::isuibot() || player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
          continue;
        }

        typebit = ter_op(isbot(player), 2, 1);

        if((typebit &searchtypes) == 0) {
          continue;
        }

        event.result[event.result.size] = player;
      }
    }

    if(searchtypes & 4 && isDefined(level.agentarray)) {
      foreach(agent in level.agentarray) {
        if(function_f309740bc6350c0e(agent) && distancesquared(self.origin, agent.origin) <= event.radiussquared) {
          event.result[event.result.size] = agent;
        }
      }
    }

    if(event.result.size > 1) {
      event.result = sortbydistance(event.result, self.origin);
    }

    event.origin = self.origin;
    event.evaluated = 1;
  }

  filter = spawnStruct();
  filter.event = event;
  filter.result = event.result;
  return filter;
}

function indistance(distance) {
  assert(distance <= self.event.radius);
  distsq = squared(distance);
  result = [];

  for(i = 0; i < self.result.size; i++) {
    target = self.result[i];

    if(distancesquared(target.origin, self.event.origin) > distsq) {
      break;
    }

    result[result.size] = target;
  }

  self.result = result;
}

function function_12203d401cb8332a(var_180f6abe6571c69f, var_4951c8537d45134f) {
  result = [];

  for(i = 0; i < self.result.size; i++) {
    target = self.result[i];
    isallied = isalliedsentient(var_180f6abe6571c69f, target);

    if(var_4951c8537d45134f == isallied) {
      result[result.size] = target;
    }
  }

  self.result = result;
}

function keepenemies(target) {
  function_12203d401cb8332a(target, 0);
}

function function_3e53d600c1f31122(target) {
  function_12203d401cb8332a(target, 1);
}

function getradius() {
  event = self.mind.eventstream.nearbytargets;
  return event.radius;
}