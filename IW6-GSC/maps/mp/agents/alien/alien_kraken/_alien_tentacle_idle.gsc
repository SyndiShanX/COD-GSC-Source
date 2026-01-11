/**********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\alien_kraken\_alien_tentacle_idle.gsc
**********************************************************************/

main() {
  self endon("killanimscript");
  init_alien_idle();

  for(;;) {
    if(!self.extended || !isDefined(level.kraken) || !isDefined(level.kraken.stage)) {
      wait 0.05;
      continue;
    }

    play_idle();
  }
}

init_alien_idle() {
  self.idle_anim_counter = 0;
}

play_idle() {
  var_0 = selectidleanimstate();
  var_1 = level.alien_types["kraken"].attributes[self.tentacle_name]["anim_index"];
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_0, var_1, "idle", "end");

  if(!isheatedphaseactive()) {
    self setscriptablepartstate("tentacle", "normal");
  }
}

selectidleanimstate() {
  if(isheatedphaseactive()) {
    var_0 = "heat_";
  } else {
    var_0 = "idle_";
  }

  if(isDefined(level.kraken.anim_state_modifier)) {
    var_0 = var_0 + (level.kraken.anim_state_modifier + "_");
  }

  var_1 = var_0 + level.alien_types["kraken"].attributes[level.kraken.stage]["ship_side"];
  return var_1;
}

isheatedphaseactive() {
  return level.kraken.phase == "heat";
}