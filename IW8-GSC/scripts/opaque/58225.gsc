/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58225.gsc
***********************************************/

function ref_13134(var0, var1) {
  if(!isDefined(var0) || !isDefined(var1)) {
    return;
  }

  if(!isDefined(level.force_players_out_of_vehicle)) {
    level.force_players_out_of_vehicle = [];
  }

  var2 = !isDefined(level.force_players_out_of_vehicle[var0]) || level.force_players_out_of_vehicle[var0] != var1;
  level.force_players_out_of_vehicle[var0] = var1;

  if(var2) {
    setomnvar(var0, var1);
    return;
  }
}

function ref_13133(var0, var1) {
  if(!isDefined(self) || !isDefined(var0) || !isDefined(var1)) {
    return;
  }

  if(!isDefined(self.force_players_out_of_vehicle)) {
    self.force_players_out_of_vehicle = [];
  }

  var2 = !isDefined(self.force_players_out_of_vehicle[var0]) || self.force_players_out_of_vehicle[var0] != var1;
  self.force_players_out_of_vehicle[var0] = var1;

  if(var2) {
    self setclientomnvar(var0, var1);
    return;
  }
}

function ref_1313d(var0, var1) {
  self endon("disconnect");
  self notify("setOmvnar" + var0);
  self endon("setOmvnar" + var0);

  if(!isDefined(self.ref_12e61)) {
    self.ref_12e61 = spawnStruct();
    self.ref_12e61.ref_11fd0 = [];
    self.ref_12e61.watch_for_player_in_los = -1;
  }

  var2 = gettime();

  if(var2 > self.ref_12e61.watch_for_player_in_los) {
    self.ref_12e61.ref_11fd0 = [];
    self.ref_12e61.watch_for_player_in_los = var2;
  }

  if(isDefined(self.ref_12e61.ref_11fd0[var0])) {
    waitframe();
    thread ref_1313d(var0, var1);
    return;
  }

  self.ref_12e61.ref_11fd0[var0] = 1;
  self setclientomnvar(var0, var1);
}

function resetpetstats(var0, var1, var2) {
  var3 = (1 << var2) - 1 << var1;
  var4 = (var0 &var3) >> var1;
  return var4;
}

function repackomnvar(var0, var1, var2, var3) {
  var4 = int(pow(2, var1)) - 1;
  var5 = (var3 &var4) << var0;
  var6 = ~(var4 << var0);
  var7 = var2 &var6;
  var8 = var7 + var5;
  return var8;
}

function resetmlgobjectivestatusicon(var0, var1, var2) {
  var3 = getomnvar(var0);
  return resetpetstats(var3);
}

function relic_bang_and_boom(var0, var1, var2) {
  var3 = self calloutmarkerping_entityzoffset(var0);
  return resetpetstats(var3);
}

function ref_13191(var0, var1, var2, var3) {
  var4 = getomnvar(var0);
  var5 = repackomnvar(var1, var2, var4, var3);
  setomnvar(var0, var5);
}

function ref_1313e(var0, var1, var2, var3) {
  var4 = self calloutmarkerping_entityzoffset(var0);
  var5 = repackomnvar(var1, var2, var4, var3);

  if(var4 != var5) {
    self setclientomnvar(var0, var5);
    return;
  }
}