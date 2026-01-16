/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_headtracking.gsc
********************************/

player_head_tracking() {
  self endon("head_tracking_end");
  self endon("death");
  self.player_head_tracking = 1;
  self.head_track_debug = self.name;

  for (;;) {
    wait 0.2;

    if(distance(self.origin, level.player.origin) <= 200 && maps\_utility::player_looking_at(self.origin)) {
      self _meth_81BA(60, 60, randomfloatrange(0.5, 2.0));
      self setlookatentity(level.player, 1, randomint(5) == 0);
      maps\_utility::waitspread(5, 7);
      self setlookatyawlimits(1);
      maps\_utility::waitspread(5, 7);
    }
  }
}

head_tracking_end(var_0, var_1) {
  self notify("head_tracking_end");
  self.player_head_tracking = 0;
  var_2 = isdefined(var_1) && var_1;

  if(isdefined(var_0) && var_0)
    self setlookatentity();
  else
    self setlookatyawlimits(1, var_2);
}