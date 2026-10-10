/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\overseer.gsc
***********************************************/

#using scripts\anim\battlechatter;
#using scripts\anim\dialogue;
#using scripts\common\utility;
#using scripts\cp_mp\entityheadicons;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\pmc_missions;
#using scripts\mp\poi;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#namespace overseer;

function function_495dec0762963abd() {
  waitframe();

  if(!function_47d356083884f913()) {
    return;
  }

  level.overseer = spawnStruct();
  function_72a66b9a0e0bc9c1();
  setdvarifuninitialized(@ "hash_451b4b1e40b7b2ae", 2);
  setdvarifuninitialized(@ "hash_c32b050cf4dbed9c", 5);
  function_5b8657687ecb9e05();
  level waittill("matchStartTimer_done");
  waitframe();
  function_61672dee45f8a3a4();
  level thread function_bdc80d6cbbc555b();
  level thread function_279f529842440558();
  function_368fb9a36d82922c();
}

function function_72a66b9a0e0bc9c1() {
  level.overseer.poi = [];

  foreach(poiname, poi in level.poi) {
    level.overseer.poi[poiname] = spawnStruct();
    level.overseer.poi[poiname].var_5c3a2c7e48245ec9 = 0;
    level.overseer.poi[poiname].name = poiname;
    level.overseer.poi[poiname].var_4f0d82757e9e4e91 = [];
    level.overseer.poi[poiname].var_96766b0a5b7abb48 = 0;
    level.overseer.poi[poiname].var_86e45dbd699cc9fa = [];
    level.overseer.poi[poiname].var_560a32af852a939a = [];
    level.overseer.poi[poiname].eventwaittime = 0;
  }
}

function function_5b8657687ecb9e05() {
  level.eventgraph = [];

  foreach(poiname, poi in level.poi) {
    function_f06ad65298f474d6(poiname, 0, 1, 5, undefined);
    function_f06ad65298f474d6(poiname, 0, 2, 10, &function_6035acab211520a8);
    function_f06ad65298f474d6(poiname, 0, 4, 0, &function_5e713676ffab769b);
    function_f06ad65298f474d6(poiname, 0, 3, 0, &function_b9b723d97e9a9a7d);
    function_f06ad65298f474d6(poiname, 0, 5, 0, &function_ab3cc3354d465ba9);
    function_f06ad65298f474d6(poiname, 2, 1, 5, undefined);
    function_f06ad65298f474d6(poiname, 2, 2, 10, &function_6035acab211520a8);
    function_f06ad65298f474d6(poiname, 2, 4, 0, &function_5e713676ffab769b);
    function_f06ad65298f474d6(poiname, 2, 3, 0, &function_b9b723d97e9a9a7d);
    function_f06ad65298f474d6(poiname, 2, 5, 0, &function_ab3cc3354d465ba9);
    function_f06ad65298f474d6(poiname, 3, 1, 5, undefined);
    function_f06ad65298f474d6(poiname, 3, 2, 10, &function_6035acab211520a8);
    function_f06ad65298f474d6(poiname, 3, 5, 0, &function_ab3cc3354d465ba9);
  }
}

function function_368fb9a36d82922c() {
  foreach(var_dc1bfdf5c034420e in level.overseer.poi) {
    var_dc1bfdf5c034420e thread function_2f4609f4ec521515();
  }
}

function function_61672dee45f8a3a4() {
  foreach(player in level.players) {
    if(isbot(player)) {
      continue;
    }

    player.var_b17bf051e1d12378 = [];

    foreach(poiname, poi in level.poi) {
      player.var_b17bf051e1d12378[poiname] = spawnStruct();
      player.var_b17bf051e1d12378[poiname].var_9cc5be111b6fa65c = [];
      player.var_b17bf051e1d12378[poiname].var_4f0d82757e9e4e91 = [];
      player.var_b17bf051e1d12378[poiname].eventcooldowns = [];
    }
  }
}

function function_f06ad65298f474d6(poiname, stateindex, eventindex, weight, eventcallback) {
  if(!isDefined(poiname) || !isDefined(stateindex) || !isDefined(eventindex) || !isDefined(weight)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  if(!isDefined(level.eventgraph[poiname])) {
    level.eventgraph[poiname] = [];
  }

  if(!isDefined(level.eventgraph[poiname][stateindex])) {
    level.eventgraph[poiname][stateindex] = [];
  }

  level.eventgraph[poiname][stateindex][eventindex] = spawnStruct();
  level.eventgraph[poiname][stateindex][eventindex].weight = weight;
  level.eventgraph[poiname][stateindex][eventindex].event = eventcallback;

  if(!isDefined(level.eventgraph[poiname][stateindex][0])) {
    level.eventgraph[poiname][stateindex][0] = 0;
  }

  level.eventgraph[poiname][stateindex][0] += weight;
}

function function_a009c03abf1d0190(newweight, poiname, stateindex, eventindex) {
  if(!isDefined(poiname) || !isDefined(stateindex) || !isDefined(eventindex) || !isDefined(newweight)) {
    assertmsg("<dev string:x5e>");
    return;
  }

  if(!function_25e955b1fbb05fd2(poiname, stateindex, eventindex)) {
    assertmsg("<dev string:xa2>");
    return;
  }

  statearray = stateindex;

  if(!isarray(statearray)) {
    statearray = [];
    statearray[statearray.size] = stateindex;
  }

  foreach(state in statearray) {
    if(!isDefined(level.eventgraph[poiname][state])) {
      continue;
    }

    weightdifference = newweight - level.eventgraph[poiname][state][eventindex].weight;
    level.eventgraph[poiname][state][0] += weightdifference;
    level.eventgraph[poiname][state][eventindex].weight = newweight;
  }
}

function function_25e955b1fbb05fd2(poiname, stateindex, eventindex) {
  if(!isDefined(level.eventgraph[poiname])) {
    return false;
  }

  statearray = stateindex;

  if(!isarray(statearray)) {
    statearray = [];
    statearray[statearray.size] = stateindex;
  }

  foreach(state in statearray) {
    if(isDefined(level.eventgraph[poiname][state]) && isDefined(level.eventgraph[poiname][state][eventindex])) {
      return true;
    }
  }

  return false;
}

function function_df475631e402735a() {
  return isDefined(level.overseer);
}

function function_17a6fd602315c59b(cooldownname, poiname) {
  if(!isDefined(self.var_b17bf051e1d12378[poiname].eventcooldowns[cooldownname])) {
    return false;
  }

  if(self.var_b17bf051e1d12378[poiname].eventcooldowns[cooldownname] <= gettime()) {
    return false;
  }

  return true;
}

function function_edb852b69ff7126(eventname) {
  switch (eventname) {
    case #"hash_5df1a64e881789c7":
      return 1;
    case #"hash_86f811bb481e7344":
      return (self.var_fe5ebefa740c7106 != 3 && self.var_fe5ebefa740c7106 != 2);
    default:
      return 1;
  }
}

function function_d566bf9405d7d49a(cooldownname) {
  if(!isDefined(self.var_60a5413e150f62fd)) {
    return false;
  }

  if(!isDefined(cooldownname)) {
    return false;
  }

  if(!isDefined(self.var_60a5413e150f62fd[cooldownname])) {
    return false;
  }

  return self.var_60a5413e150f62fd[cooldownname] >= gettime();
}

function function_dbae416bd663b441(cooldownname, cooldowntime) {
  if(!isDefined(self.var_60a5413e150f62fd)) {
    self.var_60a5413e150f62fd = [];
  }

  self.var_60a5413e150f62fd[cooldownname] = gettime() + cooldowntime * 1000;
}

function function_ba07b47fa2bc7c1e(var_646389193279e8ec, origin) {
  if(!isDefined(self.entitynumber)) {
    return false;
  }

  if(isDefined(var_646389193279e8ec[self.entitynumber])) {
    return false;
  }

  if(isDefined(self.var_b600c3754eb17f27) && self.var_b600c3754eb17f27 + 120000 <= gettime()) {
    return false;
  }

  if(!isDefined(self.origin) || !isDefined(origin)) {
    return false;
  }

  if(distancesquared(origin, self.origin) > 2250000) {
    return false;
  }

  return true;
}

function function_251a5fbcd306ba20(origin, radius, var_646389193279e8ec, poiname) {
  var_7e07bdbda1b67800 = getplayersinradius(origin, radius, "team_hundred_ninety_five");
  var_7e07bdbda1b67800 = array_randomize(var_7e07bdbda1b67800);
  var_2a325306f9ebdd9d = getplayersinradius(origin, 2000, "team_hundred_ninety_five", var_7e07bdbda1b67800);
  var_2a325306f9ebdd9d = array_randomize(var_2a325306f9ebdd9d);
  var_4f0d82757e9e4e91 = [];

  foreach(agent in level.overseer.poi[poiname].var_4f0d82757e9e4e91) {
    if(agent function_ba07b47fa2bc7c1e(var_646389193279e8ec, origin)) {
      var_4f0d82757e9e4e91[agent.entitynumber] = agent;
    }
  }

  var_4f0d82757e9e4e91 = array_randomize(var_4f0d82757e9e4e91);
  splitindex = var_7e07bdbda1b67800.size;
  var_9cc5be111b6fa65c = array_combine(var_7e07bdbda1b67800, var_2a325306f9ebdd9d);
  return [var_9cc5be111b6fa65c, var_4f0d82757e9e4e91, splitindex];
}

function function_63f2ed030151aa07(speakerorigin, cooldownname, cooldowntime, poiname) {
  players = getplayersinradius(speakerorigin, level.var_587de0e7b537210a);

  if(!isDefined(players)) {
    return;
  }

  if(!isarray(players) && !isai(players)) {
    players = [players];
  }

  foreach(player in players) {
    if(isai(player) || isbot(player) || !isDefined(player.var_b17bf051e1d12378) || !isDefined(player.var_b17bf051e1d12378[poiname])) {
      continue;
    }

    player.var_b17bf051e1d12378[poiname].eventcooldowns[cooldownname] = gettime() + cooldowntime * 1000;
  }
}

function function_3aacea8b6bb13d1a(poiname, newstate) {
  switch (newstate) {
    case 0:
    case 1:
      thread function_2f4609f4ec521515();
      break;
    case 2:
    case 3:
      thread function_1682cb99475b8428();
      break;
    case 4:
    default:
      break;
  }
}

function function_32226d6944572ebd(poiname) {
  return level.overseer.poi[poiname].var_5c3a2c7e48245ec9;
}

function function_b39e752ef737042b(poiname) {
  return level.overseer.poi[poiname].agentstates.var_fe5ebefa740c7106;
}

function function_acaf43595c74730b(state, var_cb7d9ed4fde5cb25, agentspeaker, faraway) {
  assertex(isDefined(state), "<dev string:xe8>");

  if(!isDefined(state)) {
    return undefined;
  }

  if(faraway) {
    sequence = function_c5a3e4813279af45();
  }

  sequence = undefined;

  switch (state) {
    case 0:
    case 4:
      sequence = function_5175a8d4ab6f95f9(agentspeaker, var_cb7d9ed4fde5cb25);
      break;
    case 1:
    case 2:
      sequence = function_d65f7ec4946cb258();
      break;
    case 3:
      sequence = function_5533255fd4fbf6e3();
      break;
    default:
      break;
  }

  return sequence;
}

function function_a79b8410bfcb03a(poiname, agentstate, eventname) {
  if(!isDefined(poiname) || !isDefined(agentstate) || !isDefined(eventname)) {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(isbot(self)) {
    return 0;
  }

  if(!isDefined(self.var_b17bf051e1d12378)) {
    return 0;
  }

  if(!isDefined(self.var_b17bf051e1d12378[poiname])) {
    return 0;
  }

  switch (agentstate) {
    case #"hash_343f075aa0daffe6":
      if(!isDefined(self.var_b17bf051e1d12378[poiname].var_9cc5be111b6fa65c)) {
        return 0;
      }

      if(self.var_b17bf051e1d12378[poiname].var_9cc5be111b6fa65c.size == 0) {
        return 0;
      }

      foreach(agent in self.var_b17bf051e1d12378[poiname].var_9cc5be111b6fa65c) {
        if(agent function_edb852b69ff7126(eventname) && !agent function_d566bf9405d7d49a(eventname)) {
          return 1;
        }
      }

      return 0;
    case #"hash_cf14c509efeb3c87":
      return (isDefined(self.var_b17bf051e1d12378[poiname].var_4f0d82757e9e4e91) && self.var_b17bf051e1d12378[poiname].var_4f0d82757e9e4e91.size != 0);
    case #"hash_28fac2aca8cae4a5":
      return (isDefined(level.overseer.poi[poiname].var_86e45dbd699cc9fa) && level.overseer.poi[poiname].var_86e45dbd699cc9fa.size != 0);
    default:
      return 0;
  }
}

function function_555a2cdf4916950d(agentstate, poiname, eventname) {
  assertex(isDefined(agentstate), "<dev string:x13b>");

  if(!isDefined(agentstate)) {
    return [undefined, 0];
  }

  agentarray = [];

  switch (agentstate) {
    case #"hash_343f075aa0daffe6":
      agentarray = self.var_b17bf051e1d12378[poiname].var_9cc5be111b6fa65c;
      break;
    case #"hash_cf14c509efeb3c87":
      agentarray = self.var_b17bf051e1d12378[poiname].var_4f0d82757e9e4e91;
    default:
      break;
  }

  foreach(index, agent in agentarray) {
    if(!agent function_d566bf9405d7d49a(eventname)) {
      if(agentstate == "alive" && !isalive(agent)) {
        continue;
      }

      if(index < self.var_b17bf051e1d12378[poiname].distanceindex) {
        return [agent, 0];
      }

      return [agent, 1];
    }
  }

  return [undefined, 0];
}

function function_f65532fc657a4301(agentradio) {
  level.overseer.poi[agentradio.poi].var_4f0d82757e9e4e91[agentradio.entitynumber] = agentradio;
  level.overseer.poi[agentradio.poi].var_96766b0a5b7abb48++;
}

function function_30c7ac6784554174(sequence, waittime, priority) {
  self notify("oversser_chatter_quedued");
  self endon("oversser_chatter_quedued");
  self endon("death");
  wait waittime;
  scripts\anim\battlechatter::function_d54e84a9513b0e45("investigate", sequence, priority);
}

function function_1f276ca53768bfa9(event_string, variant) {
  char = "aqs" + string(variant) + "_";
  countryid = "aqs";
  segs = strtok(event_string, "_");
  alias = "";

  switch (segs.size) {
    case 3:
      alias = "dx_bc_" + tolower(countryid) + segs[0] + "_" + segs[1] + "_" + char + segs[2];
      break;
    case 2:
      alias = "dx_bc_" + tolower(countryid) + segs[0] + "_" + char + segs[1];
      break;
    case 1:
      alias = "dx_bc_" + tolower(countryid) + "_" + char + segs[0];
      break;
    default:
      assertmsg("<dev string:x186>" + event_string + "<dev string:x1a7>");
      break;
  }

  return alias;
}

function function_67e64472be618168(event_string, variant) {
  char = "aqs1_";
  countryid = "aqld";
  segs = strtok(event_string, "_");
  alias = "";

  switch (segs.size) {
    case 3:
      alias = "dx_bc_" + tolower(countryid) + segs[0] + "_" + segs[1] + "_" + char + segs[2];
      break;
    case 2:
      alias = "dx_bc_" + tolower(countryid) + segs[0] + "_" + char + segs[1];
      break;
    case 1:
      alias = "dx_bc_" + tolower(countryid) + "_" + char + segs[0];
      break;
    default:
      assertmsg("<dev string:x186>" + event_string + "<dev string:x1a7>");
      break;
  }

  alias = scripts\anim\dialogue::get_radio_alias(alias);
  return alias;
}

function function_92bacb96846cba62(alias, variant) {
  self playsoundonmovingent(alias);
  return undefined;
}

function function_ea67555d03337205(alias, variant) {
  self stopsounds();
  return undefined;
}

function function_c26b1e049db4d841(sequence) {
  self notify("overseer_chatter");
  self endon("overseer_chatter");
  self endon("death");
  currentalias = undefined;
  variant = randomintrange(1, 4);

  foreach(index, item in sequence) {
    if(isDefined(currentalias)) {
      self thread[[level.var_9a62261b5b534b06]](currentalias);
      currentalias = undefined;
      waitframe();
      self waittill("dialogue_done");
    }

    if(isnumber(item)) {
      wait item;
    }

    if(isfunction(item)) {
      currentalias = self[[item]](sequence[index + 1], variant);
    }
  }
}

function function_2f4609f4ec521515() {
  self notify("changed_state");
  level endon("game_ended");
  self endon("changed_state");
  self.var_5c3a2c7e48245ec9 = 0;

  while(true) {
    totalweight = level.eventgraph[self.name][0][0];
    probability = randomint(totalweight) + 1;
    func = undefined;
    runningweight = 0;

    foreach(eventindex, data in level.eventgraph[self.name][0]) {
      if(eventindex == 0) {
        continue;
      }

      runningweight += data.weight;

      if(runningweight >= probability) {
        func = data.event;
        break;
      }
    }

    if(isDefined(func) && isfunction(func)) {
      self[[func]](self.name);
    }

    wait self.eventwaittime + randomintrange(getdvarint(@ "hash_451b4b1e40b7b2ae"), getdvarint(@ "hash_c32b050cf4dbed9c"));
  }
}

function function_1682cb99475b8428() {
  self notify("changed_state");
  level endon("game_ended");
  self endon("changed_state");
  self.var_5c3a2c7e48245ec9 = 2;

  while(true) {
    totalweight = level.eventgraph[self.name][2][0];
    probability = randomint(totalweight) + 1;
    func = undefined;
    runningweight = 0;

    foreach(eventindex, data in level.eventgraph[self.name][2]) {
      if(eventindex == 0) {
        continue;
      }

      runningweight += data.weight;

      if(runningweight >= probability) {
        func = data.event;
        break;
      }
    }

    if(isDefined(func) && isfunction(func)) {
      self[[func]](self.name);
    }

    wait self.eventwaittime + randomintrange(getdvarint(@ "hash_451b4b1e40b7b2ae"), getdvarint(@ "hash_c32b050cf4dbed9c"));
  }
}

function function_6035acab211520a8(poiname) {
  if(!isDefined(level.poi[poiname]["players"]) || level.poi[poiname]["players"].size == 0) {
    return;
  }

  playedevent = 0;

  foreach(player in level.poi[poiname]["players"]) {
    if(!player function_a79b8410bfcb03a(poiname, "alive", "check_in") || player function_17a6fd602315c59b("check_in", poiname)) {
      continue;
    }

    [agentspeaker, faraway] = player function_555a2cdf4916950d("alive", poiname, "check_in");

    if(!isDefined(agentspeaker) || !isDefined(faraway)) {
      continue;
    }

    playedevent = 1;
    sequence = function_acaf43595c74730b(self.var_5c3a2c7e48245ec9, undefined, agentspeaker, faraway);

    if(faraway) {
      radiosound = function_ef9999b04345f5d4();
      agentspeaker playsoundonmovingent(radiosound);
    } else {
      agentspeaker thread function_c26b1e049db4d841(sequence);
    }

    function_63f2ed030151aa07(agentspeaker.origin, "check_in", 30, poiname);
    agentspeaker function_dbae416bd663b441("check_in", 120);
  }

  if(playedevent) {
    self.eventwaittime = 10;
  }
}

function function_b9b723d97e9a9a7d(poiname) {
  if(!isDefined(level.poi[poiname]["players"]) || level.poi[poiname]["players"].size == 0) {
    return;
  }

  playedevent = 0;
  agentignored = 1;
  var_ced51c14e5171ec4 = [];

  foreach(player in level.poi[poiname]["players"]) {
    if(!player function_a79b8410bfcb03a(poiname, "dead") || player function_17a6fd602315c59b("dead_agent_contacted", poiname)) {
      continue;
    }

    [agentspeaker, faraway] = player function_555a2cdf4916950d("dead", poiname, "check_in");

    if(!isDefined(agentspeaker)) {
      continue;
    }

    playedevent = 1;
    probability = min(100, level.overseer.poi[poiname].var_96766b0a5b7abb48 * 10);
    ignore = percent_chance(probability);
    agentspeaker notify("radio_spam");
    var_ced51c14e5171ec4[var_ced51c14e5171ec4.size] = agentspeaker;

    if(!ignore) {
      level.overseer.poi[poiname].var_86e45dbd699cc9fa[agentspeaker.entitynumber] = undefined;
      function_3daefb936272829f(poiname, agentspeaker.origin);
      sequence = function_b19e15d68738642b();
      agentignored = 0;
    } else {
      sequence = function_e8391f9bf6b9aed();
    }

    agentspeaker thread function_c26b1e049db4d841(sequence);
    function_63f2ed030151aa07(agentspeaker.origin, "dead_agent_contacted", 120, poiname);
    agentspeaker function_dbae416bd663b441("check_in", 120);
  }

  if(playedevent) {
    if(!agentignored) {
      function_a009c03abf1d0190(0, poiname, [0, 2], 3);
      function_a009c03abf1d0190(10, poiname, [2], 4);
    }

    self.eventwaittime = 0;
    wait 20;

    foreach(agent in var_ced51c14e5171ec4) {
      thread function_fc9a15646315764c(agent);
    }

    if(!agentignored) {
      function_3aacea8b6bb13d1a(poiname, 2);
    }
  }
}

function function_5e713676ffab769b(poiname) {
  if(!isDefined(level.poi[poiname]["players"]) || level.poi[poiname]["players"].size == 0) {
    return;
  }

  var_17fdc82450aab9e3 = [];
  playedevent = 0;

  foreach(player in level.poi[poiname]["players"]) {
    if(!player function_a79b8410bfcb03a(poiname, "alive", "reinforce_agent") || !player function_a79b8410bfcb03a(poiname, "dead_contacted") || player function_17a6fd602315c59b("reinforce_agent", poiname)) {
      continue;
    }

    [agentspeaker, faraway] = player function_555a2cdf4916950d("alive", poiname, "reinforce_agent");

    if(!isDefined(agentspeaker)) {
      continue;
    }

    playedevent = 1;
    sequence = function_e84132896f105965(agentspeaker, undefined);
    agentspeaker thread function_c26b1e049db4d841(sequence);
    var_17fdc82450aab9e3[agentspeaker getentitynumber()] = spawnStruct();
    var_17fdc82450aab9e3[agentspeaker getentitynumber()].deadagent = random(level.overseer.poi[poiname].var_86e45dbd699cc9fa);
    var_17fdc82450aab9e3[agentspeaker getentitynumber()].agent = agentspeaker;
    function_63f2ed030151aa07(agentspeaker.origin, "reinforce_agent", 120, poiname);
  }

  if(playedevent) {
    function_a009c03abf1d0190(0, poiname, 2, 4);
    self.eventwaittime = 0;
    wait 10;

    foreach(movedata in var_17fdc82450aab9e3) {
      origin = getclosestpointonnavmesh(movedata.deadagent.origin + (randomfloatrange(-256, 256), randomfloatrange(-256, 256), 0));
      movedata.agent thread scripts\mp\ai_behavior::function_a5117518725da028(movedata.agent, origin);
      level.overseer.poi[poiname].agentstates = movedata.agent;
      level.overseer.poi[poiname].var_86e45dbd699cc9fa[movedata.deadagent.entitynumber] = undefined;
      level.overseer.poi[poiname].var_96766b0a5b7abb48 = 0;
      level.overseer.poi[poiname].var_560a32af852a939a[movedata.deadagent.entitynumber] = movedata.deadagent;
    }
  }
}

function function_ab3cc3354d465ba9(poiname) {
  if(!isDefined(level.poi[poiname]["players"]) || level.poi[poiname]["players"].size == 0) {
    return;
  }

  playedevent = 0;

  foreach(player in level.poi[poiname]["players"]) {
    if(!player function_a79b8410bfcb03a(poiname, "alive", "outside_reinforce") || player function_17a6fd602315c59b("outside_reinforce", poiname)) {
      continue;
    }

    [agentspeaker, faraway] = player function_555a2cdf4916950d("alive", poiname, "outside_reinforce");

    if(!isDefined(agentspeaker)) {
      continue;
    }

    playedevent = 1;
    sequence = function_1000f4a1c18a2766(agentspeaker);
    agentspeaker thread function_c26b1e049db4d841(sequence);
    function_63f2ed030151aa07(agentspeaker.origin, "outside_reinforce", 120, poiname);
    agentspeaker function_dbae416bd663b441("outside_reinforce", 120);
  }

  if(playedevent) {
    function_a009c03abf1d0190(0, poiname, [0, 2], 4);
    self.eventwaittime = 10;
  }
}

function function_bdc80d6cbbc555b() {
  level endon("game_ended");

  while(true) {
    foreach(poiname, poi in level.poi) {
      if(!isDefined(level.poi[poiname]["players"])) {
        continue;
      }

      foreach(player in level.poi[poiname]["players"]) {
        if(!isDefined(player.var_b17bf051e1d12378) || !isalive(player) || !isDefined(player.origin) || isbot(player)) {
          continue;
        }

        var_646389193279e8ec = level.overseer.poi[poiname].var_560a32af852a939a;
        [var_9cc5be111b6fa65c, var_4f0d82757e9e4e91, distanceindex] = function_251a5fbcd306ba20(player.origin, 1500, var_646389193279e8ec, poiname);
        player.var_b17bf051e1d12378[poiname].var_9cc5be111b6fa65c = var_9cc5be111b6fa65c;
        player.var_b17bf051e1d12378[poiname].distanceindex = distanceindex;
        player.var_b17bf051e1d12378[poiname].var_4f0d82757e9e4e91 = var_4f0d82757e9e4e91;

        if(player function_a79b8410bfcb03a(poiname, "dead")) {
          function_a009c03abf1d0190(level.overseer.poi[poiname].var_96766b0a5b7abb48, poiname, [0, 2], 3);
        }
      }
    }

    wait 5;
  }
}

function function_279f529842440558() {
  level endon("game_ended");

  while(true) {
    foreach(var_dc1bfdf5c034420e in level.overseer.poi) {
      if(!isDefined(var_dc1bfdf5c034420e.agentstates)) {
        continue;
      }

      agentstate = function_b39e752ef737042b(var_dc1bfdf5c034420e.name);

      if(function_32226d6944572ebd(var_dc1bfdf5c034420e.name) != agentstate && agentstate != 4) {
        var_dc1bfdf5c034420e function_3aacea8b6bb13d1a(var_dc1bfdf5c034420e.name, agentstate);
      }
    }

    wait 1;
  }
}

function function_d2c0773f378a239a() {
  alias = [];
  alias[alias.size] = "s_idnm_safi";
  alias[alias.size] = "s_idnm_abbasi";
  alias[alias.size] = "s_idnm_kinan";
  alias[alias.size] = "s_idnm_hamed";
  alias[alias.size] = "s_idnm_hadi";
  alias[alias.size] = "s_idnm_waseem";
  alias[alias.size] = "s_idnm_abuelbaz";
  alias[alias.size] = "s_idnm_beshara";
  alias[alias.size] = "s_idnm_kamal";
  alias[alias.size] = "s_idnm_abujamil";
  alias[alias.size] = "s_idnm_jabour";
  alias[alias.size] = "s_idnm_yaser";
  alias[alias.size] = "s_idnm_fayad";
  alias[alias.size] = "s_idnm_daoud";
  alias[alias.size] = "s_idnm_laham";
  alias[alias.size] = "s_idnm_abunazar";
  alias[alias.size] = "s_idnm_abuodeh";
  alias[alias.size] = "s_idnm_amran";
  alias[alias.size] = "s_idnm_basr";
  alias[alias.size] = "s_idnm_karam";
  alias[alias.size] = "s_idnm_brother";
  return random(alias);
}

function function_f2f1a8b4044ef6e9() {
  alias = [];
  alias[alias.size] = "s_idrr_nothinghere";
  alias[alias.size] = "s_idrr_allclear";
  alias[alias.size] = "s_idrr_weregoodbrother";
  alias[alias.size] = "s_idrr_goodhere";
  alias[alias.size] = "s_idrr_quietherebrother";
  return random(alias);
}

function function_473352d13a0abbd9() {
  alias = [];
  alias[alias.size] = "s_idlc_roger";
  alias[alias.size] = "s_idlc_copy";
  alias[alias.size] = "s_idlc_copythat";
  return random(alias);
}

function function_5175a8d4ab6f95f9(agentspeaker, var_cb7d9ed4fde5cb25) {
  firstline = function_d2c0773f378a239a();
  secondline = function_f2f1a8b4044ef6e9();
  lastline = function_473352d13a0abbd9();
  sequence = [ &function_67e64472be618168, firstline, 2, &function_1f276ca53768bfa9, secondline, 2, &function_67e64472be618168, lastline];
  return sequence;
}

function function_6cab75076ec4334e() {
  alias = [];
  alias[alias.size] = "s_idli_areyouokaybrother";
  alias[alias.size] = "s_idli_areyouthere";
  alias[alias.size] = "s_idli_wheredyougo";
  alias[alias.size] = "s_idli_canyouhearme";
  return random(alias);
}

function function_8ee10b8e4567c2a1() {
  alias = [];
  alias[alias.size] = "s_comm_ret0";
  alias[alias.size] = "s_comm_reo0";
  return random(alias);
}

function function_7eb00c3f02c593d0() {
  alias = [];
  alias[alias.size] = "s_misc_con0";
  alias[alias.size] = "s_misc_con2";
  return random(alias);
}

function function_b19e15d68738642b() {
  firstline = function_d2c0773f378a239a();
  secondline = function_6cab75076ec4334e();
  lastline = function_8ee10b8e4567c2a1();
  sequence = [ &function_67e64472be618168, firstline, 4, &function_67e64472be618168, secondline, 4, &function_67e64472be618168, lastline];
  return sequence;
}

function function_e8391f9bf6b9aed() {
  firstline = function_d2c0773f378a239a();
  secondline = function_6cab75076ec4334e();
  lastline = function_7eb00c3f02c593d0();
  sequence = [ &function_67e64472be618168, firstline, 4, &function_67e64472be618168, secondline, 4, &function_67e64472be618168, lastline];
  return sequence;
}

function function_23dd8208f1ba025b() {
  alias = [];
  alias[alias.size] = "s_comm_rhy0";
  alias[alias.size] = "s_conf_cop0";
  return random(alias);
}

function function_ce3abe01c9d8b928() {
  alias = [];
  alias[alias.size] = "s_seor_oft0";
  alias[alias.size] = "s_invt_ori0";
  alias[alias.size] = "s_geno_ocl1";
  return random(alias);
}

function function_e84132896f105965(agentspeaker, var_cb7d9ed4fde5cb25) {
  firstline = function_d2c0773f378a239a();
  secondline = function_23dd8208f1ba025b();
  thirdline = "s_comm_alu0";
  fourthline = function_ce3abe01c9d8b928();
  sequence = [ &function_67e64472be618168, firstline, 2, &function_1f276ca53768bfa9, secondline, 2, &function_67e64472be618168, thirdline, &function_67e64472be618168, fourthline];
  return sequence;
}

function function_6b75c6c72cd1d5a8() {
  alias = [];
  alias[alias.size] = "s_seor_orb1";
  alias[alias.size] = "s_seor_orb0";
  alias[alias.size] = "s_seor_osa1";
  alias[alias.size] = "s_seor_osa1";
  return random(alias);
}

function function_d65f7ec4946cb258() {
  firstline = function_d2c0773f378a239a();
  secondline = function_6b75c6c72cd1d5a8();
  sequence = [ &function_67e64472be618168, firstline, 2, &function_67e64472be618168, secondline];
  return sequence;
}

function function_5533255fd4fbf6e3() {
  firstline = function_d2c0773f378a239a();
  secondline = function_6b75c6c72cd1d5a8();
  sequence = [ &function_67e64472be618168, firstline, 2, &function_67e64472be618168, secondline];
  return sequence;
}

function function_b35d0c3a9e1070e9() {
  alias = [];
  alias[alias.size] = "s_moac_moa0";
  alias[alias.size] = "s_moac_mot0";
  return random(alias);
}

function function_1000f4a1c18a2766(agentspeaker) {
  firstline = "s_comm_neb0";
  secondline = function_b35d0c3a9e1070e9();
  sequence = [ &function_67e64472be618168, firstline, 2, &function_67e64472be618168, secondline];
  return sequence;
}

function function_ef9999b04345f5d4() {
  alias = [];
  alias[alias.size] = "st_radioburst_10";
  alias[alias.size] = "st_radioburst_11";
  alias[alias.size] = "st_radioburst_12";
  alias[alias.size] = "st_radioburst_13";
  alias[alias.size] = "st_radioburst_14";
  alias[alias.size] = "st_radioburst_15";
  alias[alias.size] = "st_radioburst_16";
  alias[alias.size] = "st_radioburst_17";
  alias[alias.size] = "st_radioburst_18";
  alias[alias.size] = "st_radioburst_19";
  alias[alias.size] = "st_radioburst_20";
  alias[alias.size] = "st_radioburst_21";
  alias[alias.size] = "st_radioburst_22";
  alias[alias.size] = "st_radioburst_23";
  alias[alias.size] = "st_radioburst_24";
  alias[alias.size] = "st_radioburst_25";
  alias[alias.size] = "st_radioburst_26";
  return random(alias);
}

function function_c5a3e4813279af45() {
  firstline = function_ef9999b04345f5d4();
  secondline = function_ef9999b04345f5d4();
  sequence = [ &function_92bacb96846cba62, firstline, 4, &function_92bacb96846cba62, secondline];
  return sequence;
}

function waitstopsounds(waittime) {
  self notify("radio_marked");
  self endon("death");
  self endon("radio_marked");
  wait waittime;
  self stopsounds();
}

function function_7289a8868bc4bc3a(agents, players) {
  level endon("game_ended");

  foreach(agent in agents) {
    if(isalive(agent)) {
      agent playsoundonmovingent("mp_dmz_overseer_radio_tag");
      agent thread waitstopsounds(0.75);

      if(isDefined(agent.var_665888749d290fdb)) {
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon(agent.var_665888749d290fdb);
      }

      icon = agent thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(players, "hud_icon_head_marked", 8, 1);
      agent.var_665888749d290fdb = icon;
      agent thread function_4ebc27baa42965cd(icon);
      agent thread function_b9b06db9105db58f(icon, getdvarfloat(@ "hash_bb001ed900888502", 10));
      wait randomfloatrange(0.25, 0.4);
    }
  }
}

function function_cd4716d7459f4e90(players, origin, team, agentteam) {
  level endon("game_ended");
  var_17b71f62deaf8f29 = 0;

  if(issharedfuncdefined("player", "showMiniMap")) {
    foreach(player in players) {
      player[[getsharedfunc("player", "showMiniMap")]]();

      if(issharedfuncdefined("perk", "hasPerk")) {
        if(player[[getsharedfunc("perk", "hasPerk")]]("specialty_pc_comms")) {
          var_17b71f62deaf8f29 = 1;
        }
      }
    }
  }

  var_dd9afc233a67e2c = scripts\mp\utility\entity::function_d9ce8fb00f0e5fa1(origin, 2000, agentteam);
  var_dd9afc233a67e2c = sortbydistance(var_dd9afc233a67e2c, origin);
  level thread function_7289a8868bc4bc3a(var_dd9afc233a67e2c, players);
  thread function_3e61541e7c85f0dd(players, origin, 2000, 12);
  sweepcount = 0;
  var_9639f9fcaed0faf6 = 3 + ter_op(var_17b71f62deaf8f29, getdvarint(@ "hash_1f416fc1d07d0b07", 2), 0);

  while(sweepcount < var_9639f9fcaed0faf6) {
    triggerportableradarpingteam(origin, team, 2000, int(2000));
    sweepcount++;
    wait 2;
  }

  if(issharedfuncdefined("player", "hideMiniMap")) {
    foreach(player in players) {
      if(isDefined(player)) {
        player[[getsharedfunc("player", "hideMiniMap")]]();
      }
    }
  }
}

function function_3e61541e7c85f0dd(players, origin, radius, time) {
  struct = spawnStruct();
  struct.players = players;
  struct.origin = origin;
  struct.radius = radius;

  if(!isDefined(level.var_a68dcd3b5a82712d)) {
    level.var_a68dcd3b5a82712d = [];
  }

  level.var_a68dcd3b5a82712d[level.var_a68dcd3b5a82712d.size] = struct;
  wait time;
  level.var_a68dcd3b5a82712d = array_remove(level.var_a68dcd3b5a82712d, struct);
}

function function_4ebc27baa42965cd(icon) {
  self notify("headicon_death_watch");
  self endon("overseer_headicon_deleted");
  self endon("headicon_death_watch");
  level endon("game_ended");
  self waittill("death");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);
  self.var_665888749d290fdb = undefined;
  self notify("overseer_headicon_deleted");
}

function function_b9b06db9105db58f(icon, waittime) {
  self notify("headicon_timeout");
  self endon("overseer_headicon_deleted");
  self endon("headicon_timeout");
  level endon("game_ended");
  wait waittime;
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(icon);
  self.var_665888749d290fdb = undefined;
  self notify("overseer_headicon_deleted");
}

function function_4cc3562c55625e70(instance) {
  self notify("radio_activated");
  instance notify("radio_spam");
  level endon("game_ended");
  self endon("death");
  self endon("radio_activated");
  poiname = instance.poi;
  radiopos = instance.origin;
  instance setscriptablepartstate("brloot_dead_agent_radio", "pulse");
  playsoundatpos(radiopos, "mp_dmz_overseer_radio_sweep");
  players = scripts\mp\utility\teams::getteamdata(self.team, "players");
  thread scripts\mp\utility\points::doscoreevent(#"hash_b029caf23fe6242c");
  scripts\mp\pmc_missions::function_3d12fce128d424b1(self, instance);

  if(!isDefined(players)) {
    return;
  }

  agentteam = level.var_4b195d3dd0024b9c;

  if(isDefined(instance.droppedteam)) {
    agentteam = instance.droppedteam;
  }

  level thread function_cd4716d7459f4e90(players, radiopos, self.team, agentteam);
  wait 2;
  scripts\mp\gametypes\br_pickups::loothide(instance);
}

function function_fc9a15646315764c(agentradio) {
  if(!isDefined(agentradio)) {
    return;
  }

  agentradio notify("radio_spam");
  agentradio endon("radio_spam");
  wait 3;

  while(isDefined(agentradio) && isDefined(agentradio.origin)) {
    alias = function_ef9999b04345f5d4();
    playsoundatpos(agentradio.origin, alias);
    wait 4;
  }
}