/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58225.gsc
***********************************************/

_id_13134(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  if(!isDefined(level.force_players_out_of_vehicle))
    level.force_players_out_of_vehicle = [];

  var_2 = !isDefined(level.force_players_out_of_vehicle[var_0]) || level.force_players_out_of_vehicle[var_0] != var_1;
  level.force_players_out_of_vehicle[var_0] = var_1;

  if(var_2)
    setomnvar(var_0, var_1);
}

_id_13133(var_0, var_1) {
  if(!isDefined(self) || !isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  if(!isDefined(self.force_players_out_of_vehicle))
    self.force_players_out_of_vehicle = [];

  var_2 = !isDefined(self.force_players_out_of_vehicle[var_0]) || self.force_players_out_of_vehicle[var_0] != var_1;
  self.force_players_out_of_vehicle[var_0] = var_1;

  if(var_2)
    self setclientomnvar(var_0, var_1);
}

_id_1313D(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_96390ABEEA8DB5A1CBA8BB8B" + var_0);
  self endon("_encstr_96390ABEEA8DB5A1CBA8BB8B" + var_0);

  if(!isDefined(self._id_12E61)) {
    self._id_12E61 = spawnStruct();
    self._id_12E61._id_11FD0 = [];
    self._id_12E61.watch_for_player_in_los = -1;
  }

  var_2 = gettime();

  if(var_2 > self._id_12E61.watch_for_player_in_los) {
    self._id_12E61._id_11FD0 = [];
    self._id_12E61.watch_for_player_in_los = var_2;
  }

  if(isDefined(self._id_12E61._id_11FD0[var_0])) {
    waitframe();
    thread _id_1313D(var_0, var_1);
  } else {
    self._id_12E61._id_11FD0[var_0] = 1;
    self setclientomnvar(var_0, var_1);
  }
}

resetpetstats(var_0, var_1, var_2) {
  var_3 = (1 << var_2) - 1 << var_1;
  var_4 = (var_0 &var_3) >> var_1;
  return var_4;
}

_encstr_97E90D03E0C3B1E20F68BD75CCC32B(var_0, var_1, var_2, var_3) {
  var_4 = int(pow(2, var_1)) - 1;
  var_5 = (var_3 &var_4) << var_0;
  var_6 = ~(var_4 << var_0);
  var_7 = var_2 &var_6;
  var_8 = var_7 + var_5;
  return var_8;
}

resetmlgobjectivestatusicon(var_0, var_1, var_2) {
  var_3 = getomnvar(var_0);
  return resetpetstats(var_3);
}

relic_bang_and_boom(var_0, var_1, var_2) {
  var_3 = self calloutmarkerping_entityzoffset(var_0);
  return resetpetstats(var_3);
}

_id_13191(var_0, var_1, var_2, var_3) {
  var_4 = getomnvar(var_0);
  var_5 = _encstr_97E90D03E0C3B1E20F68BD75CCC32B(var_1, var_2, var_4, var_3);
  setomnvar(var_0, var_5);
}

_id_1313E(var_0, var_1, var_2, var_3) {
  var_4 = self calloutmarkerping_entityzoffset(var_0);
  var_5 = _encstr_97E90D03E0C3B1E20F68BD75CCC32B(var_1, var_2, var_4, var_3);

  if(var_4 != var_5)
    self setclientomnvar(var_0, var_5);
}