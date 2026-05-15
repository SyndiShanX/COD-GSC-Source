/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\_alien_human.gsc
*************************************************/

inithuman(var_0) {
  level.agent_funcs["alienHuman"] = [];
  level.agent_funcs["alienHuman"]["spawn"] = ::alienhumanspawn;
  level.agent_funcs["alienHuman"]["on_killed"] = ::alienhumankilled;
  level.agent_funcs["alienHuman"]["on_damaged"] = ::alienhumandamaged;
  level.agent_funcs["alienHuman"]["on_damaged_finished"] = ::alienhumandamagefinished;
  level.human_agent_anim_class = var_0;
}

alienhumanspawn(var_0, var_1, var_2, var_3, var_4) {
  var_5 = maps\mp\agents\_agent_common::connectnewagent("alienHuman", "allies");

  if(!isDefined(var_0) || !isDefined(var_1)) {
    var_6 = var_5[[level.getspawnpoint]]();
    var_0 = var_6.origin;
    var_1 = var_6.angles;
  }

  var_5 setModel(var_2);
  var_5 show();
  var_5 spawnagent(var_0, var_1, level.human_agent_anim_class);
  var_5 scragentsetphysicsmode("noclip");
  var_5 attach(var_3, "J_spine4");
  var_5.moveplaybackrate = 1.0;
  var_5.defaultmoveplaybackrate = 1.0;
  var_5.xyanimscale = 1.0;
  var_5 maps\mp\agents\_agent_utility::activateagent();
  var_5.spawntime = gettime();
  var_5.spawn_origin = var_0;
  var_5 scragentsetclipmode("agent");
  var_5.maxhealth = 100;
  var_5.health = 100;
  var_5.ignoreme = !isDefined(var_4) || !var_4;
  return var_5;
}

checklocation() {
  var_0 = self.origin;

  for(;;) {
    var_1 = self.origin;
    var_2 = undefined;
    var_3 = 0.0;

    if(isDefined(self.startanimtime) && length(var_1 - var_0) > 0.1) {
      var_2 = self getanimentryname();
      var_3 = (gettime() - self.startanimtime) / 1000.0;
    }

    wait 0.05;
    var_0 = var_1;
  }
}

playanimation(var_0, var_1, var_2, var_3) {
  self.startanimtime = gettime();

  if(!isDefined(var_2)) {
    var_2 = "end";
  }

  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_0, var_1, var_0, var_2, var_3);
}

alienhumandamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return self[[maps\mp\agents\_agent_utility::agentfunc("on_damaged_finished")]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

alienhumandamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self finishagentdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, 0);
}

alienhumankilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}