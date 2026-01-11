/************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle.gsc
************************************************************************/

initkrakententacle() {
  level.agent_funcs["kraken_tentacle"] = [];
  level.agent_funcs["kraken_tentacle"]["spawn"] = ::alienkrakententaclespawn;
  level.agent_funcs["kraken_tentacle"]["on_killed"] = ::alienkrakententaclekilled;
  level.agent_funcs["kraken_tentacle"]["on_damaged"] = ::alienkrakententacledamaged;
  level.agent_funcs["kraken_tentacle"]["on_damaged_finished"] = ::alienkrakententacledamagefinished;
}

getcurrenttentaclelocationstruct(var_0, var_1) {
  var_2 = level.alien_types["kraken"].attributes[var_1]["ship_side"] + "_location";
  var_3 = level.alien_types["kraken"].attributes[var_0][var_2];
  var_4 = common_scripts\utility::getstruct(var_3, "targetname");
  return var_4;
}

alienkrakententaclespawn(var_0) {
  var_1 = maps\mp\agents\_agent_common::connectnewagent("kraken_tentacle", "axis");
  var_1.feral_occludes = 1;
  var_1 settentaclemodel();
  var_1.tentacle_name = var_0;
  var_1.extended = 0;
  var_1.onenteranimstate = ::onentertentaclestate;
  var_2 = getcurrenttentaclelocationstruct(var_0, level.kraken.stage);
  var_1 spawnagent(var_2.origin, var_2.angles, "alien_kraken_tentacle_animclass");
  var_1 assigntentacleattributes();
  var_1 settentaclescriptfields(var_2.origin);
  var_1 scragentsetclipmode("agent");
  var_1 scragentsetphysicsmode("noclip");
  var_1 takeallweapons();
  var_1.health = 100;
  var_1.maxhealth = 100;
  var_1.ignoreme = 1;
  var_1.alien_type = "tentacle";
  var_1 scragentusemodelcollisionbounds();
  self scragentsetgoalpos(self.origin);
  self scragentsetgoalradius(20000);
  return var_1;
}

enemychangemonitor() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("enemy");
    self.looktarget = self.enemy;
  }
}

isspawning() {
  return isDefined(self.spawning);
}

issmashing() {
  return isDefined(self.performing_melee);
}

isextended() {
  return self.extended;
}

teleportside(var_0) {
  var_1 = getcurrenttentaclelocationstruct(self.tentacle_name, var_0);
  self setorigin(var_1.origin, 0);
  self setplayerangles(var_1.angles);
  self scragentsetorientmode("face angle abs", var_1.angles, var_1.angles);
  self scragentsetgoalpos(var_1.origin);
  self scragentsetgoalradius(20000);
}

emerge(var_0) {
  self.melee_type = "emerge";
  performmeleeattack(self.enemy);
  self.extended = 1;
  self setscriptablepartstate("tentacle", "normal");
  maps\mp\alien\_utility::set_alien_emissive_default(0.2);
}

retract() {
  self.melee_type = "retract";
  self setscriptablepartstate("tentacle", "normal");
  maps\mp\alien\_utility::set_alien_emissive_default(0.2);
  performmeleeattack(self.enemy);
  self.extended = 0;
}

heat() {
  self.melee_type = "heat";
  thread play_tentacle_heatfx();
  performmeleeattack(self.enemy);
}

play_tentacle_heatfx() {
  thread end_tentacle_heat_fx();
  self endon("death");
  self endon("heat_complete");
  self setModel("alien_squid_tentacle_heat_phase");
  wait 17.0;
  maps\mp\alien\_utility::set_alien_emissive(4.0, 1.0);

  for(;;) {
    wait 1.4;
    self setscriptablepartstate("tentacle", "heat_discharge_fx_01");
    wait 1.4;
    self setscriptablepartstate("tentacle", "heat_discharge_fx_02");
  }

  self setscriptablepartstate("tentacle", "normal");
}

end_tentacle_heat_fx() {
  self endon("death");
  common_scripts\utility::waittill_any("heat_complete", "kraken_phase_interrupt");
  wait 0.1;
  self setscriptablepartstate("tentacle", "normal");
  maps\mp\alien\_utility::set_alien_emissive_default(1.0);
  self setModel("alien_squid_tentacle");
}

death() {
  self.melee_type = "death";
  performmeleeattack(self.enemy);
  self hide();
}

emp() {
  self endon("death");
  self.melee_type = "emp";
  performmeleeattack(self.enemy);
  self setscriptablepartstate("tentacle", "normal");
}

smash(var_0) {
  self.melee_type = "smash";
  self.smash_trigger = var_0;
  self.performing_melee = 1;
  maps\mp\alien\_utility::set_alien_emissive(0.2, 1.0);
  performmeleeattack(self.enemy);
  maps\mp\alien\_utility::set_alien_emissive_default(0.2);
  self.smash_trigger = undefined;
}

getsmashanimlength() {
  if(level.kraken.phase == "heat") {
    var_0 = "heat_smash";
  }
  else {
    var_0 = "smash";
  }

  return maps\mp\agents\alien\alien_kraken\_alien_tentacle_melee::getsmashanimlength(var_0);
}

heatsmash(var_0) {
  self.melee_type = "heat_smash";
  self.smash_trigger = var_0;
  self.performing_melee = 1;
  performmeleeattack(self.enemy);
  self.smash_trigger = undefined;
}

spawnattack(var_0) {
  self endon("death");
  self.melee_type = "spawn";
  self.spawning = 1;
  self.wave_name = var_0;
  performmeleeattack(self.enemy);
}

settentaclemodel() {
  var_0 = level.alien_types["kraken"].attributes["tentacle_model"];
  self setModel(var_0);
  self show();
  self motionblurhqenable();
}

assigntentacleattributes() {
  self.moveplaybackrate = 1.0;
  self.defaultmoveplaybackrate = self.moveplaybackrate;
  self.animplaybackrate = self.moveplaybackrate;
  self.xyanimscale = 0.0;
  self.defaultemissive = 0.0;
  self.maxemissive = level.alien_types["kraken"].attributes["max_emissive"];
  thread setinitialemissive();
  self scragentsetviewheight(level.alien_types["kraken"].attributes["view_height"]);
}

settentaclescriptfields(var_0) {
  self.species = "alien";
  self.enablestop = 1;
  maps\mp\agents\_agent_utility::activateagent();
  self.spawntime = gettime();
  self.attacking_player = 0;
  self.spawnorigin = var_0;
}

setinitialemissive() {
  self endon("death");
  wait 1;
  maps\mp\alien\_utility::set_alien_emissive_default(0.2);
}

performmeleeattack(var_0) {
  if(!isDefined(var_0)) {
    var_0 = maps\mp\agents\alien\alien_kraken\_alien_kraken::findanenemy();

    if(!isDefined(var_0)) {
      return;
    }
  }

  self scragentsetgoalpos(self.origin);
  self scragentsetgoalradius(64);
  self scragentbeginmelee(var_0);
  self waittill("melee_complete");
}

onentertentaclestate(var_0, var_1) {
  onexitanimstate(var_0, var_1);
  self.currentanimstate = var_1;

  switch (var_1) {
    case "idle":
      maps\mp\agents\alien\alien_kraken\_alien_tentacle_idle::main();
      break;
    case "melee":
      maps\mp\agents\alien\alien_kraken\_alien_tentacle_melee::main();
      break;
  }
}

onexitanimstate(var_0, var_1) {
  self notify("killanimscript");

  switch (var_0) {
    case "melee":
      maps\mp\agents\alien\alien_kraken\_alien_tentacle_melee::endscript();
      break;
  }
}

alienkrakententacledamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_2 = int(var_2 * level.alien_types["kraken"].attributes["tentacle_damage_multiplier"]);

  if(isDefined(level.kraken)) {
    level.kraken maps\mp\agents\alien\alien_kraken\_alien_kraken::alienkrakendamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }
  else {
    if(isDefined(var_1.owner) && isplayer(var_1.owner)) {
      var_1.owner thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("hitaliensoft");
    }
    else {
      var_1 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("hitaliensoft");
    }

    if(isDefined(level.miniboss.hp) && !common_scripts\utility::flag("boss_in_pain")) {
      level.miniboss.hp = level.miniboss.hp - var_2;
      level.miniboss notify("miniboss_damaged");
      return self[[maps\mp\agents\_agent_utility::agentfunc("on_damaged_finished")]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }
  }

  return 0;
}

alienkrakententacledamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self finishagentdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, 0);
}

alienkrakententaclekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

alienminibosstentaclespawn() {
  maps\mp\agents\alien\alien_kraken\_alien_kraken::loadkrakenattributes();
  var_0 = maps\mp\agents\_agent_common::connectnewagent("kraken_tentacle", "axis");
  var_0.feral_occludes = 1;
  var_0 setModel("Alien_squid_tentacle_scale60");
  var_0.tentacle_name = "miniboss";
  var_0.extended = 0;
  var_1 = spawn("script_origin", (-2250, 400, -2750));
  var_1.angles = (0, 0, 0);
  var_0 spawnagent(var_1.origin, var_1.angles, "alien_kraken_tentacle_animclass");
  var_0 assigntentacleattributes();
  var_0 settentaclescriptfields(var_1.origin);
  var_0 scragentsetclipmode("agent");
  var_0 scragentsetphysicsmode("noclip");
  var_0 scragentsetorientmode("face angle abs", var_0.angles);
  var_0 scragentsetanimmode("anim deltas");
  var_0 maps\mp\alien\_utility::enable_alien_scripted();
  var_0 scragentsetscripted(1);
  var_0 takeallweapons();
  var_0.health = 9999999;
  var_0.maxhealth = 9999999;
  var_0.ignoreme = 1;
  var_0 scragentusemodelcollisionbounds();
  return var_0;
}