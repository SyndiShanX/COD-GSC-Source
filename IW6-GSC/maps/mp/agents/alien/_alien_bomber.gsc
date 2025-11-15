/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\_alien_bomber.gsc
**************************************************/

bomber_level_init() {
  if(!isDefined(level.alien_funcs))
    level.alien_funcs = [];

  level.alien_funcs["bomber"]["approach"] = ::blank_script;
  level.alien_funcs["bomber"]["combat"] = ::blank_script;
  level.alien_funcs["bomber"]["badpath"] = maps\mp\agents\alien\_alien_think::handle_badpath;
  load_bomber_fx();
}

load_bomber_fx() {
  level._effect["alien_bomber_explode"] = loadfx("vfx/gameplay/alien/vfx_alien_bomber_explode");
}

blank_script() {}

bomber_init() {
  maps\mp\alien\_utility::enable_alien_scripted();
  self scragentsetscripted(1);
  self scragentsetgoalradius(20000.0);
  var_0 = (0, 0, -100);
  var_1 = (0, 0, -3000);
  var_2 = bulletTrace(self.origin + var_0, self.origin + var_1, 0);
  self.ground_origin = var_2["position"];
  self.pain_registered = 1;
  self setthreatbiasgroup("dontattackdrill");
  self playSound("divebomber_spawn_sfx");
  thread bomber_idle_vo();
  thread bomber_think();
}

bomber_think() {
  self endon("death");
  self endon("game_ended");
  self scragentsetphysicsmode("noclip");
  self scragentsetorientmode("face angle abs", self.angles);
  thread animate_ceiling_idle();
  wait_for_divebomb();
  var_0 = wait_for_enemy_before_attack();
  self.divebomborigin = get_divebomb_origin(var_0);
  bomber_attack("divebomb", var_0);

  if(!maps\mp\_utility::isreallyalive(var_0))
    var_0 = acquire_enemy_before_charge();

  bomber_attack("kamikaze", var_0);
}

wait_for_divebomb() {
  var_0 = 0.3;
  wait(randomfloatrange(1.0 - var_0, 1.0 + var_0));
}

get_divebomb_origin(var_0) {
  var_1 = getnodesinradius(var_0.origin, 1024.0, 256.0, 2000, "jump");
  var_1 = get_flyable_nodes(var_1);
  var_2 = get_divebomb_node_rated(var_0, var_1);

  if(isDefined(var_2))
    return var_2.origin + (0, 0, 256);

  return level.players[0].origin + (0, 0, 256);
}

get_flyable_nodes(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "flyable")
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

get_divebomb_node_rated(var_0, var_1) {
  var_2 = [];
  var_2["direction"] = "player_front";
  var_2["direction_weight"] = 1.5;
  var_2["min_height"] = 64.0;
  var_2["max_height"] = 256.0;
  var_2["height_weight"] = 2.0;
  var_2["enemy_los"] = 1;
  var_2["enemy_los_weight"] = 4.0;
  var_2["min_dist_from_enemy"] = 400.0;
  var_2["max_dist_from_enemy"] = 1000.0;
  var_2["desired_dist_from_enemy"] = 600.0;
  var_2["dist_from_enemy_weight"] = 2.0;
  var_2["min_dist_from_all_enemies"] = 200.0;
  var_2["min_dist_from_all_enemies_weight"] = 1.0;
  var_2["not_recently_used_weight"] = 4.0;
  var_2["random_weight"] = 1.0;
  var_2["test_offset"] = (0, 0, 256);
  return maps\mp\agents\alien\_alien_think::get_retreat_node_rated(var_0, var_2, var_1);
}

wait_for_enemy_before_attack() {
  self endon("death");
  var_0 = undefined;

  for(;;) {
    var_1 = maps\mp\alien\_utility::get_closest_living_player();
    var_2 = get_closest_living_vanguard();

    if(isDefined(var_1) && !player_controlling_vanguard(var_1, var_2))
      return var_1;

    if(isDefined(var_2))
      return var_2;

    wait 0.05;
  }
}

player_controlling_vanguard(var_0, var_1) {
  if(!isDefined(var_1) || !isDefined(var_1.owner))
    return 0;

  return var_1.owner == var_0;
}

get_closest_living_vanguard() {
  if(isDefined(level.alien_vanguard))
    return level.alien_vanguard;

  return undefined;
}

acquire_enemy_before_charge() {
  if(isDefined(self.enemy))
    return self.enemy;

  return wait_for_enemy_before_attack();
}

bomber_attack(var_0, var_1) {
  self.melee_type = var_0;
  level notify("dlc_vo_notify", "bomber_attack", self);
  self notify(var_0);
  self scragentbeginmelee(var_1);
  self scragentsetgoalentity(var_1);
  self scragentsetgoalradius(20000.0);
  self waittill("melee_complete");
}

divebomb(var_0) {
  var_1 = self.origin;
  var_2 = self.divebomborigin;
  var_3 = distance(var_1, var_2);
  var_4 = vectortoangles(var_2 - var_1);
  self scragentsetorientmode("face angle abs", var_4);
  var_5 = self getanimentry("fly", 0);
  var_6 = self getanimentry("glide", 0);
  var_7 = self getanimentry("glide", 2);
  var_8 = self getanimentry("fly", 2);
  var_9 = length(getmovedelta(var_5));
  var_10 = length(getmovedelta(var_6));
  var_11 = length(getmovedelta(var_7));
  var_12 = length(getmovedelta(var_8));
  var_13 = getanimlength(var_5) / 1.0;
  var_14 = getanimlength(var_6) / 1.0;
  var_15 = getanimlength(var_7) / 1.0;
  var_16 = getanimlength(var_8) / 1.0;

  if(var_3 > var_9 + var_10 + var_11 + var_12) {
    self setanimstate("fly", 0, 1.0);
    wait(var_13);
    var_3 = distance(self.origin, var_2);
  }

  if(var_3 > var_10 + var_11 + var_12) {
    self setanimstate("glide", 0, 1.0);
    wait(var_14);
    var_3 = distance(self.origin, var_2);
  }

  if(var_3 > var_11 + var_12) {
    self setanimstate("glide", 1, 1.0);
    var_17 = var_11 + var_12;
    var_17 = var_17 * var_17;

    while(distancesquared(self.origin, var_2) > var_17)
      wait 0.05;

    var_3 = var_11 + var_12;
  }

  if(var_3 >= var_11 + var_12) {
    self setanimstate("glide", 2, 1.0);
    wait(var_15);
    var_3 = distance(self.origin, var_2);
  }

  self setanimstate("fly", 2, 1.0);
  wait(var_16);
  self scragentsetorientmode("face enemy");
  self setanimstate("idle_fly");
  var_18 = 0.3;
  wait(randomfloatrange(1.0 - var_18, 1.0 + var_18));
}

kamikaze(var_0) {
  thread track_enemy(var_0);
  var_1 = distance(self.origin, var_0.origin);
  var_2 = getanimlength(self getanimentry("fly", 0)) / 1.0;
  var_3 = getanimlength(self getanimentry("glide", 0)) / 1.0;
  self setanimstate("fly", 0, 1.0);
  wait(var_2);
  self playSound("divebomber_atk_sfx");
  self setanimstate("glide", 0, 1.0);
  wait(var_3);
  self setanimstate("glide", 1);
  wait 5.0;
  self suicide();
}

track_enemy(var_0) {
  self endon("death");
  var_0 endon("death");
  var_1 = 25.0;
  self scragentsetanimmode("anim deltas");

  for(;;) {
    wait 0.05;
    var_2 = self.origin;
    var_3 = var_0.origin + (0, 0, 30);
    var_4 = distancesquared(var_2, var_3);

    if(var_4 < 576.0) {
      self suicide();
      return;
    }

    var_5 = vectornormalize(var_3 - var_2);
    var_6 = vectortoangles(var_5);
    var_7 = bulletTrace(var_2, var_2 + var_1 * var_5, 1, self);

    if(var_7["fraction"] < 1.0) {
      self suicide();
      return;
    }

    self scragentsetorientmode("face angle abs", var_6);
  }
}

bomber_animate() {
  self endon("death");

  for(;;) {
    switch (self.bomberanimstate) {
      case "ceiling_idle":
        thread animate_ceiling_idle();
        break;
      case "float_idle":
        break;
    }
  }
}

animate_ceiling_idle() {
  self endon("death");
  self endon("divebomb");
  self setanimstate("idle", 0);
}

bomber_idle_vo() {
  self endon("death");

  for(;;) {
    wait(randomfloatrange(2, 5));
    self playSound("divebomber_idle_sfx");
  }
}

bomber_death(var_0) {
  wait 0.05;
  playFX(level._effect["alien_bomber_explode"], var_0 + (0, 0, 32));
  playsoundatpos(var_0, "alien_bomber_explode");
  radiusdamage(var_0, 150, level.alien_types["bomber"].attributes["explode_max_damage"], level.alien_types["minion"].attributes["explode_min_damage"], undefined, "MOD_EXPLOSIVE", "alien_minion_explosion");
}