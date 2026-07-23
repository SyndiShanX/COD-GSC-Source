/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1551.gsc
**************************************/

exchange_sort_by_handler(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    var_3 = 0;

    for(var_4 = var_2 + 1; var_4 < var_0.size; var_4++) {
      if(var_0[var_4][[var_1]]() < var_0[var_2][[var_1]]()) {
        var_5 = var_0[var_4];
        var_0[var_4] = var_0[var_2];
        var_0[var_2] = var_5;
      }
    }
  }

  return var_0;
}

on_player_trig_record_and_notify(var_0, var_1) {
  var_2 = getEnt(var_0, "script_noteworthy");

  for(;;) {
    var_2 waittill("trigger", var_3);

    if(isDefined(var_3) && var_3 == self) {
      self.stat_finish_time = gettime();

      if(isDefined(level.challenge_time_limit)) {
        self.stat_finish_time_remaining = max(level.challenge_time_limit - (self.stat_finish_time - level.challenge_start_time), 0);
      }
      if(!maps\_utility::is_coop() || isDefined(maps\_utility::get_other_player(self).stat_finish_time)) {
        common_scripts\utility::flag_set(var_1);
      }
      break;
    }
  }
}