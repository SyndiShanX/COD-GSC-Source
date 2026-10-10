/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6981400abfcd765c.gsc
*************************************************/

#using scripts\engine\utility;
#namespace namespace_493bf119b3b0c251;

function function_94b952789d039abb() {
  if(getdvarint(@ "hash_c68acbd0f58df6b0", 0) != 0) {
    return true;
  }

  if(getdvarint(@ "hash_6f29400118ddd39b", 0) != 0) {
    return false;
  }

  return getdvarint(@ "ftue_ingame_enabled", 0) != 0;
}

function function_2195503b0dcc12c0() {
  if(function_a226c96f1ba59cd0()) {
    level.var_98bbc6461bb67f0b = spawnStruct();
    level.var_98bbc6461bb67f0b.var_f8f7108d5f8686c9 = [];
    level.var_98bbc6461bb67f0b.var_4faacf7795179c8f = 1;
  }
}

function private function_a226c96f1ba59cd0() {
  return istrue(getdvarint(@ "hash_9615d7fb7cf74e4c", 0));
}

function function_83fc92d8ce12ec9e(progressid) {
  assert(isPlayer(self));
  assert(!isbot(self));
  savedprogress = function_8e931d2f54036d6d("ftueProgress", progressid, "completed");
  return savedprogress > 0;
}

function private function_8951a5e5929491bb(progressid) {
  assert(isPlayer(self));
  assert(!isbot(self));
  return true;
}

function function_e05669c955312c22(progressid, value) {
  assert(isPlayer(self));
  assert(!isbot(self));
  progressversion = function_8951a5e5929491bb(progressid);
  function_ef834a530f602e31("ftueProgress", progressid, "completed", value);
  function_ef834a530f602e31("ftueProgress", progressid, "completedVersion", progressversion);
}

function function_f3c2d9fe39c96c53(progressid) {
  assert(isPlayer(self));
  assert(!isbot(self));
  version = function_8e931d2f54036d6d("ftueProgress", progressid, "completedVersion");
  return version;
}

function function_a220dac697d2ea35() {
  assert(isPlayer(self));
  assert(!isbot(self));
  return function_70e4a8c54777f552("brMatchPlayTime");
}

function function_2f80e3ca1b2374a(playtime) {
  assert(isPlayer(self));
  assert(!isbot(self));
  savedtime = function_a220dac697d2ea35() + playtime;
  function_9c70c77ccecb444e("brMatchPlayTime", savedtime);
}

function function_da8cf8dbdb763ae() {
  assert(isPlayer(self));
  assert(!isbot(self));
  return function_70e4a8c54777f552("matchesCompleted");
}

function function_312e1babffbdf863() {
  assert(isPlayer(self));
  assert(!isbot(self));
  savedmatches = function_da8cf8dbdb763ae() + 1;
  function_9c70c77ccecb444e("matchesCompleted", savedmatches);
  return savedmatches;
}

function function_663fcc46a62ebe2b(params) {
  assert(isDefined(params));
  assert(isDefined(params.var_31c4c1d952b9e73d));
  currentmatches = function_da8cf8dbdb763ae();

  if(currentmatches >= params.var_31c4c1d952b9e73d) {
    return true;
  }

  return false;
}

function function_a25d14ecf8dcb49e(index) {
  assert(isPlayer(self));
  assert(!isbot(self));
  var_1abb1cf7d64b28f4 = floor(index / 32);
  index %= 32;
  tooltipscompleted = function_1e6d534caef3039f(var_1abb1cf7d64b28f4);
  mask = 1 << index;
  tooltipscompleted |= mask;
  function_e35c082c18ff343b(tooltipscompleted, var_1abb1cf7d64b28f4);
}

function function_5f50ae7bff599e0a(index) {
  assert(isPlayer(self));
  assert(!isbot(self));
  var_1abb1cf7d64b28f4 = floor(index / 32);
  index %= 32;
  tooltipscompleted = function_1e6d534caef3039f(var_1abb1cf7d64b28f4);
  mask = 1 << index;
  return istrue(tooltipscompleted &mask);
}

function function_7fbc76f1aefc8fc5() {
  assert(isPlayer(self));
  assert(!isbot(self));

  if(function_a226c96f1ba59cd0()) {
    return level.var_98bbc6461bb67f0b.var_4faacf7795179c8f;
  }

  return function_70e4a8c54777f552("playerExpertiseOption");
}

function function_3fa91b90ba5753e7() {
  assert(isPlayer(self));
  assert(!isbot(self));
  disabled = function_70e4a8c54777f552("tooltipsDisabled");
  return !disabled;
}

function private function_70e4a8c54777f552(data) {
  return function_1e8137aca9687477(level.var_114256fded8103cd, data);
}

function private function_9c70c77ccecb444e(data, value) {
  function_7a70551396a38f2b(level.var_114256fded8103cd, data, value);
}

function private function_8e931d2f54036d6d(arrayname, index, data) {
  return function_2fb0985cf3162e78(level.var_114256fded8103cd, arrayname, index, data);
}

function private function_ef834a530f602e31(arrayname, index, data, value) {
  function_24615288bde909b4(level.var_114256fded8103cd, arrayname, index, data, value);
}

function private function_1e8137aca9687477(key, data) {
  assert(isPlayer(self));
  assert(!isbot(self));
  playerdata = self getplayerdata("mp", key, data);
  return playerdata;
}

function private function_2fb0985cf3162e78(key, arrayname, index, data) {
  assert(isPlayer(self));
  assert(!isbot(self));
  playerdata = self getplayerdata("mp", key, arrayname, index, data);
  return playerdata;
}

function private function_7a70551396a38f2b(key, data, value) {
  assert(isPlayer(self));
  assert(!isbot(self));
  self setplayerdata("mp", key, data, value);
}

function private function_24615288bde909b4(key, arrayname, index, data, value) {
  assert(isPlayer(self));
  assert(!isbot(self));
  self setplayerdata("mp", key, arrayname, index, data, value);
}

function private function_1e6d534caef3039f(var_1abb1cf7d64b28f4) {
  var_a35f31a4e9dc0da9 = function_de90bd48a2a5276(var_1abb1cf7d64b28f4);
  tooltipscompleted = 0;

  if(function_a226c96f1ba59cd0()) {
    tooltipscompleted = function_892873a4b3c135ef(self);
  } else {
    tooltipscompleted = function_70e4a8c54777f552(var_a35f31a4e9dc0da9);
  }

  return tooltipscompleted;
}

function private function_e35c082c18ff343b(tooltipscompleted, var_1abb1cf7d64b28f4) {
  var_a35f31a4e9dc0da9 = function_de90bd48a2a5276(var_1abb1cf7d64b28f4);

  if(function_a226c96f1ba59cd0()) {
    function_c79da86a5696572b(self, tooltipscompleted);
    return;
  }

  function_9c70c77ccecb444e(var_a35f31a4e9dc0da9, tooltipscompleted);
}

function private function_892873a4b3c135ef(player) {
  function_aa20cca13a2cc9cd(player);

  foreach(entry in level.var_98bbc6461bb67f0b.var_f8f7108d5f8686c9) {
    if(isDefined(entry) && entry.player == player) {
      return entry.var_efc2b352015e6b82;
    }
  }
}

function private function_c79da86a5696572b(player, value) {
  function_aa20cca13a2cc9cd(player);

  foreach(entry in level.var_98bbc6461bb67f0b.var_f8f7108d5f8686c9) {
    if(isDefined(entry) && entry.player == player) {
      entry.var_efc2b352015e6b82 = value;
      break;
    }
  }
}

function private function_aa20cca13a2cc9cd(player) {
  foreach(entry in level.var_98bbc6461bb67f0b.var_f8f7108d5f8686c9) {
    if(isDefined(entry) && entry.player == player) {
      return;
    }
  }

  entry = spawnStruct();
  entry.player = player;
  entry.var_efc2b352015e6b82 = getdvarint(@ "hash_92e4360591ae4baf", 0);
  level.var_98bbc6461bb67f0b.var_f8f7108d5f8686c9 = array_add_safe(level.var_98bbc6461bb67f0b.var_f8f7108d5f8686c9, entry);
}

function private function_de90bd48a2a5276(var_1abb1cf7d64b28f4) {
  var_a35f31a4e9dc0da9 = "tooltipsCompleted_01";

  if(var_1abb1cf7d64b28f4 == 1) {
    var_a35f31a4e9dc0da9 = "tooltipsCompleted_02";
  }

  return var_a35f31a4e9dc0da9;
}