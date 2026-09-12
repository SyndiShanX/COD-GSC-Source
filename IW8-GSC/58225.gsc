/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58225.gsc
***********************************************/

function ref_13134(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }

  if(!isDefined(level.force_players_out_of_vehicle)) {
    level.force_players_out_of_vehicle = [];
  }

  var_2 = !isDefined(level.force_players_out_of_vehicle[var_0]) || level.force_players_out_of_vehicle[var_0] != var_1;
  level.force_players_out_of_vehicle[var_0] = var_1;

  if(var_2) {
    setomnvar(var_0, var_1);
    return;
  }
}

function ref_13133(var_0, var_1) {
  if(!isDefined(self) || !isDefined(var_0) || !isDefined(var_1)) {
    return;
  }

  if(!isDefined(self.force_players_out_of_vehicle)) {
    self.force_players_out_of_vehicle = [];
  }

  var_2 = !isDefined(self.force_players_out_of_vehicle[var_0]) || self.force_players_out_of_vehicle[var_0] != var_1;
  self.force_players_out_of_vehicle[var_0] = var_1;

  if(var_2) {
    self setclientomnvar(var_0, var_1);
    return;
  }
}

function ref_1313d(var_0, var_1) {
  self endon("disconnect");
  self notify("setOmvnar" + var_0);
  self endon("setOmvnar" + var_0);

  if(!isDefined(self.ref_12e61)) {
    self.ref_12e61 = spawnStruct();
    self.ref_12e61.ref_11fd0 = [];
    self.ref_12e61.watch_for_player_in_los = -1;
  }

  var_2 = gettime();

  if(var_2 > self.ref_12e61.watch_for_player_in_los) {
    self.ref_12e61.ref_11fd0 = [];
    self.ref_12e61.watch_for_player_in_los = var_2;
  }

  if(isDefined(self.ref_12e61.ref_11fd0[var_0])) {
    waitframe();
    thread ref_1313d(var_0, var_1);
    return;
  }

  self.ref_12e61.ref_11fd0[var_0] = 1;
  self setclientomnvar(var_0, var_1);
}

function resetpetstats(var_0, var_1, var_2) {
  var_3 = (1 << var_2) - 1 << var_1;
  var_4 = (var_0 &var_3) >> var_1;
  return var_4;
}

function repackomnvar(var_0, var_1, var_2, var_3) {
  var_4 = int(pow(2, var_1)) - 1;
  var_5 = (var_3 &var_4) << var_0;
  var_6 = ~(var_4 << var_0);
  var_7 = var_2 &var_6;
  var_8 = var_7 + var_5;
  return var_8;
}

function resetmlgobjectivestatusicon(var_0, var_1, var_2) {
  var_3 = getomnvar(var_0);
  return resetpetstats(var_3);
}

function relic_bang_and_boom(var_0, var_1, var_2) {
  var_3 = self calloutmarkerping_entityzoffset(var_0);
  return resetpetstats(var_3);
}

function ref_13191(var_0, var_1, var_2, var_3) {
  var_4 = getomnvar(var_0);
  var_5 = repackomnvar(var_1, var_2, var_4, var_3);
  setomnvar(var_0, var_5);
}

function ref_1313e(var_0, var_1, var_2, var_3) {
  var_4 = self calloutmarkerping_entityzoffset(var_0);
  var_5 = repackomnvar(var_1, var_2, var_4, var_3);

  if(var_4 != var_5) {
    self setclientomnvar(var_0, var_5);
    return;
  }
}