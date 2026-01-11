/********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\alien_kraken\_alien_kraken_idle.gsc
********************************************************************/

main() {
  self endon("killanimscript");
  init_alien_idle();

  if(!isDefined(level.fx_water_loop_running)) {
    level.fx_water_loop_running = 1;
    thread play_water_fx_loop();
  }

  for(;;) {
    if(!isDefined(self.stage) || self.posturing || self.smashing) {
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
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_0, undefined, "idle", "end");
}

play_water_fx_loop() {
  self endon("death");
  var_0 = ["water_fx1", "water_fx2", "water_fx3", "water_fx4"];

  for(;;) {
    wait 0.01;

    if(common_scripts\utility::flag("fx_kraken_water")) {
      wait(randomfloatrange(0.8, 3.3));
      self setscriptablepartstate("body", "normal");
      wait 0.1;
      var_1 = common_scripts\utility::random(var_0);
      self setscriptablepartstate("body", var_1);
    }
  }

  if(common_scripts\utility::flag("fx_kraken_water")) {
    self setscriptablepartstate("body", "normal");
  }
}

end_water_fx_loop() {
  self waittill("heat");
  wait 0.1;
  self setscriptablepartstate("tentacle", "normal");
}

selectidleanimstate() {
  var_0 = "idle_";

  if(isDefined(self.anim_state_modifier)) {
    var_0 = var_0 + (self.anim_state_modifier + "_");
  }

  var_1 = var_0 + level.alien_types["kraken"].attributes[self.stage]["ship_side"];
  return var_1;
}