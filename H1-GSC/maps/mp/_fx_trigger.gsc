/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_fx_trigger.gsc
********************************/

main() {
  level.fx_trigger_info = [];
  var_0 = getentarray("fx_trigger", "targetname");
  var_1 = getentarray("fx_trigger_reverse", "targetname");
  var_2 = common_scripts\utility::array_combine(var_0, var_1);

  foreach(var_4 in var_2) {
    var_5 = var_4.script_noteworthy;

    if(!isdefined(var_5)) {
      continue;
    }
    if(!isdefined(level._effect[var_5])) {
      continue;
    }
    var_6 = var_4.targetname == "fx_trigger_reverse";

    if(!isdefined(level.fx_trigger_info[var_5])) {
      var_7 = spawnstruct();
      var_7.players = [];
      var_7.reverse = var_6;
      var_7.fxent = spawnfx(level._effect[var_5], (0, 0, 0));
      var_7.fxent hide();
      triggerfx(var_7.fxent, 1);
      level.fx_trigger_info[var_5] = var_7;
      var_7.fxent thread fx_trigger_fx_ent_think(var_5);
    } else if(level.fx_trigger_info[var_5].reverse != var_6) {
      continue;
    }
    var_4 thread fx_trigger_think(var_5);
  }
}

fx_trigger_fx_ent_think(var_0) {
  for (;;) {
    level.fx_trigger_info[var_0].players = [];
    waitframe();
    waittillframeend;
    self hide();

    if(level.fx_trigger_info[var_0].reverse) {
      foreach(var_2 in level.players) {
        if(!isdefined(common_scripts\utility::array_find(level.fx_trigger_info[var_0].players, var_2)))
          self showtoplayer(var_2);
      }

      continue;
    }

    foreach(var_2 in level.fx_trigger_info[var_0].players)
    self showtoplayer(var_2);
  }
}

fx_trigger_think(var_0) {
  for (;;) {
    self waittill("trigger", var_1);
    var_2 = level.fx_trigger_info[var_0].players.size;
    level.fx_trigger_info[var_0].players[var_2] = var_1;
  }
}