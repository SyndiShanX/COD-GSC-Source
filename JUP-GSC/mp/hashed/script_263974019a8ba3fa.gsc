/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_263974019a8ba3fa.gsc
*************************************************/

#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#namespace exclusion_zones;

function function_39e1cd8a0fce827a(position, dimensions, rot, shape, inverted) {
  if(isDefined(level.br_multi_circle) && level.br_multi_circle.circlecount > 1) {
    assertmsg("<dev string:x1c>");
    return;
  }

  if(!isDefined(shape)) {
    shape = 2;
  }

  if(!isDefined(rot)) {
    rot = (0, 0, 0);
  }

  if(!isDefined(inverted)) {
    inverted = 0;
  }

  for(i = 0; i < 3; i++) {
    if(!isDefined(level.exclusionzones) || !isDefined(level.exclusionzones[i])) {
      level.exclusionzones[i] = function_7d635301465bbed1(position, dimensions, rot, shape, inverted);
      return i;
    }
  }

  assertmsg("<dev string:x59>" + 3);
}

function function_de57b9616f575a63(position, var_72759fb8bd38aa1e, var_584ecd81b5529ed2) {
  if(!isvector(position)) {
    assertmsg("<dev string:x8d>" + position);
  }

  if(!isDefined(level.exclusionzones)) {
    return -1;
  }

  if(!isDefined(var_584ecd81b5529ed2)) {
    var_584ecd81b5529ed2 = 0;
  }

  for(i = 0; i < 3; i++) {
    if(isDefined(level.exclusionzones[i]) && var_584ecd81b5529ed2 == function_704a7fe0058bba45(level.exclusionzones[i])) {
      if(level.exclusionzones[i] function_91bf6ad362e62084(position, var_72759fb8bd38aa1e, var_584ecd81b5529ed2)) {
        return i;
      }
    }
  }

  return -1;
}

function function_91bf6ad362e62084(position, var_72759fb8bd38aa1e, var_584ecd81b5529ed2) {
  if(!isvector(position)) {
    assertmsg("<dev string:x8d>" + position);
  }

  var_d315d8a84c73470 = function_92b7f40b735f689f(self, position);
  return istrue(var_72759fb8bd38aa1e) ? var_d315d8a84c73470 && function_24c5a8d31ae262f(position) : var_d315d8a84c73470;
}

function function_781b540fbee7109a(zone) {
  assert(isDefined(level.exclusionzones));
  assert(isDefined(zone));
  level.exclusionzones = utility::array_remove(level.exclusionzones, zone);
  zone delete();
}

function function_7f267ef8e2210d1d(var_de595808b3e6a948, duration) {
  assert(isDefined(self));

  if(duration == 0) {
    self function_7b19792f59d0889d(self.origin, var_de595808b3e6a948, self.angles);
    return;
  }

  assertex(duration >= 0, "<dev string:xab>");
  thread function_a4b442ebe4020bb(var_de595808b3e6a948, duration);
}

function private function_a4b442ebe4020bb(var_5f6228d3e1d47c7f, duration) {
  starttime = gettime();
  duration *= 1000;
  var_8007d36a029de440 = self function_d4828ad77ce1566f();

  while(isDefined(self) && gettime() < starttime + duration) {
    var_de595808b3e6a948 = vectorlerp(var_8007d36a029de440, var_5f6228d3e1d47c7f, (gettime() - starttime) / duration);
    self function_7b19792f59d0889d(self.origin, var_de595808b3e6a948);
    waitframe();
  }
}

function function_ca194605b904c777(var_de595808b3e6a948, rate, linear) {
  assert(isDefined(self));
  assertex(isDefined(rate), "<dev string:xf0>");

  if(rate == 0) {
    self function_7b19792f59d0889d(self.origin, var_de595808b3e6a948);
    return;
  }

  thread function_a4547a6f54ebab99(var_de595808b3e6a948, rate, linear);
}

function private function_a4547a6f54ebab99(var_5f6228d3e1d47c7f, rate, linear) {
  var_8007d36a029de440 = self function_d4828ad77ce1566f();
  var_de595808b3e6a948 = var_8007d36a029de440;
  var_e046a46d224708ed = (var_5f6228d3e1d47c7f - var_de595808b3e6a948) * rate;
  initialsign = vectorsign(var_5f6228d3e1d47c7f - var_de595808b3e6a948);

  while(isDefined(self) && !is_equal(var_8007d36a029de440, var_5f6228d3e1d47c7f)) {
    if(!linear) {
      var_de595808b3e6a948 += (var_5f6228d3e1d47c7f - var_de595808b3e6a948) * rate;

      for(i = 0; i < 3; i++) {
        if(abs(var_5f6228d3e1d47c7f[i] - var_de595808b3e6a948[i]) < abs(var_e046a46d224708ed[i])) {
          var_de595808b3e6a948 = var_5f6228d3e1d47c7f;
        }
      }
    } else {
      var_de595808b3e6a948 += rate;
    }

    for(i = 0; i < 3; i++) {
      if(sign(var_5f6228d3e1d47c7f[i] - var_de595808b3e6a948[i]) != initialsign[i]) {
        self function_7b19792f59d0889d(self.origin, var_5f6228d3e1d47c7f, self.angles, level.framedurationseconds);
        return;
      }
    }

    self function_7b19792f59d0889d(self.origin, var_de595808b3e6a948, self.angles, level.framedurationseconds);
    wait level.framedurationseconds;

    if(isDefined(self)) {
      var_8007d36a029de440 = self function_d4828ad77ce1566f();
    }
  }
}

function function_b1eab7c7fda1fb57() {}

function function_14767b88f55e26e0() {
  foreach(zone in level.exclusionzones) {
    function_781b540fbee7109a(zone);
    return;
  }
}

function function_7176642fe2ed10cd(var_72759fb8bd38aa1e) {
  in_exclusion_zone(var_72759fb8bd38aa1e);
}

function function_afa41ee45eb3172f() {
  position = (4000, 0, 0);
  dimensions = (50000, 5000, 10000);
  rot = (0, 45, 0);
  shape = 1;
  function_39e1cd8a0fce827a(position, dimensions, rot, 2, 1);
  dimensions = (3000, 3000, 2000);
  position = (700, -5500, 0);
  function_39e1cd8a0fce827a(position, dimensions, rot, 2, 1);
  position = (10000, -7000, 0);
  dimensions = (5000, 5000, 1500);
  function_39e1cd8a0fce827a(position, dimensions, rot, shape);
  level.var_ec780726787e2557 = 1;
}

function in_exclusion_zone(var_72759fb8bd38aa1e) {
  if(!isDefined(level.exclusionzones)) {
    iprintlnbold("<dev string:x12e>");
    return;
  }

  position = level.players[0].origin;
  string = "<dev string:x144>";

  for(i = 0; i < 3; i++) {
    if(isDefined(level.exclusionzones[i])) {
      string = string + i + "<dev string:x15d>" + (level.exclusionzones[i] function_91bf6ad362e62084(position, var_72759fb8bd38aa1e) ? "<dev string:x163>" : "<dev string:x16e>");
    }
  }

  string = string + "<dev string:x17a>" + function_de57b9616f575a63(position, var_72759fb8bd38aa1e);
  string = string + "<dev string:x18a>" + function_de57b9616f575a63(position, var_72759fb8bd38aa1e, 1);
  iprintlnbold(string);
}

function lerp_exclusion_zone() {
  if(istrue(level.var_ec780726787e2557)) {
    position = (4000, 0, 3000);
    dimensions = (10000, 10000, 4000);
    rot = (0, 0, 0);
    level.exclusionzones[0] function_7b19792f59d0889d(position, dimensions, rot, 30);
    position = (5000, 0, 2500);
    dimensions = (4000, 50000, 1000);
    level.exclusionzones[1] function_7b19792f59d0889d(position, dimensions, rot, 10);
    position = (-5000, 0, 1500);
    dimensions = (1500, 50000, 1000);
    level.exclusionzones[2] function_7b19792f59d0889d(position);
    level.var_ec780726787e2557 = 0;
    return;
  }

  position = (4000, 0, 3000);
  dimensions = (10000, 10000, 4000);
  rot = (0, 0, 0);
  level.exclusionzones[0] function_7b19792f59d0889d(position, dimensions, rot, 30);
  dimensions = (1000, 6000, 4000);
  position = (5000, 0, 1500);
  level.exclusionzones[1] function_7b19792f59d0889d(position, dimensions, rot, 10);
  position = (-2667, -5561, 1500);
  dimensions = (4000, 4000, 4000);
  level.exclusionzones[2] function_7b19792f59d0889d(position, dimensions, rot, 15);
  level.var_ec780726787e2557 = 1;
}

# /