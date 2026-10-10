/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5295a2c10229ffef.gsc
*************************************************/

#using script_42adcce5878f583;
#using script_5295a2c10229ffef;
#using scripts\common\utility;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\utility\debug;
#namespace namespace_3fa2391f9077d907;

function function_841c25eb1c7438b(var_f03196013d5cd011, spawntriggers) {
  if(!isDefined(var_f03196013d5cd011.position) || !isDefined(var_f03196013d5cd011.angles)) {
    assertex(0, "<dev string:x1c>");
    return;
  }

  if(!isDefined(spawntriggers) || spawntriggers.size == 0) {
    return;
  }

  var_23551dada6d5703b = function_f62593b78a116dcd(var_f03196013d5cd011);
  thread function_65f85fe2042cabbc(var_23551dada6d5703b, spawntriggers);
}

function function_6c904abfe5e38110(var_f03196013d5cd011) {
  if(!isDefined(var_f03196013d5cd011.position) || !isDefined(var_f03196013d5cd011.angles)) {
    assertex(0, "<dev string:x1c>");
    return;
  }

  var_23551dada6d5703b = function_f62593b78a116dcd(var_f03196013d5cd011);
  function_9fa669f5949de66(var_23551dada6d5703b);
  return var_23551dada6d5703b;
}

function private function_65f85fe2042cabbc(var_23551dada6d5703b, spawntriggers) {
  level endon("game_ended");
  var_23551dada6d5703b endon("death");

  foreach(spawntrigger in spawntriggers) {
    thread function_6d4da2c34dcd635f(var_23551dada6d5703b, spawntrigger);
  }

  var_23551dada6d5703b waittill("spawnTriggered", var_f74f1f9c1f566746);

  if(isDefined(var_f74f1f9c1f566746)) {
    var_e69d72ccd1884415 = var_f74f1f9c1f566746.origin - var_23551dada6d5703b.origin;
    var_e69d72ccd1884415 = utility::flatten_vector(var_e69d72ccd1884415);
    var_23551dada6d5703b.angles = vectortoangles(var_e69d72ccd1884415);
  }

  function_9fa669f5949de66(var_23551dada6d5703b);
}

function private function_6d4da2c34dcd635f(var_23551dada6d5703b, trigger) {
  level endon("game_ended");

  if(isDefined(trigger)) {
    trigger waittill("trigger", var_f74f1f9c1f566746);

    if(isDefined(var_23551dada6d5703b)) {
      var_23551dada6d5703b notify("spawnTriggered", var_f74f1f9c1f566746);
    }
  }
}

function private function_234f1442e280f1fd(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(isDefined(instance.health)) {
    instance.health -= idamage;

    if(instance.health < 0) {
      instance setscriptablepartstate("main", "iw9_mp_decoymine_pop", 0);
      instance setscriptablepartstate("health", "ignore_damage", 0);
      instance notify("inflatable_destroyed");
      return;
    }

    instance thread namespace_c569d26b8efc6f63::function_a3ba34f65c02912a(vdir);
  }
}

function private function_f62593b78a116dcd(var_f03196013d5cd011) {
  var_23551dada6d5703b = spawnscriptable("jup_ob_inflatable_dummy", var_f03196013d5cd011.position, var_f03196013d5cd011.angles);
  var_23551dada6d5703b setscriptablepartstate("main", "neutral", 0);
  var_23551dada6d5703b setscriptablepartstate("health", "ignore_damage", 0);
  var_23551dada6d5703b.team = default_to(var_f03196013d5cd011.team, "team_hundred_ninety");
  var_23551dada6d5703b.angles = var_f03196013d5cd011.angles;
  var_23551dada6d5703b.health = default_to(var_f03196013d5cd011.health, 150);
  var_23551dada6d5703b.activity = var_f03196013d5cd011.activity;
  var_23551dada6d5703b.navobstacleid = createnavobstaclebybounds(var_23551dada6d5703b.origin, (16, 16, 45), var_23551dada6d5703b.angles);
  var_23551dada6d5703b.var_2f53a6b82c6bd61b = default_to(var_f03196013d5cd011.var_2f53a6b82c6bd61b, 0.5);
  var_23551dada6d5703b.var_2f2f9cb82c434565 = default_to(var_f03196013d5cd011.var_2f2f9cb82c434565, 3);
  var_23551dada6d5703b.lifetime = default_to(var_f03196013d5cd011.lifetime, 0);

  if(isDefined(var_f03196013d5cd011.deathcallback)) {
    var_23551dada6d5703b.deathcallback = var_f03196013d5cd011.deathcallback;
  }

  var_23551dada6d5703b thread function_3b91f075feeb9315();
  return var_23551dada6d5703b;
}

function private function_9fa669f5949de66(var_23551dada6d5703b) {
  var_23551dada6d5703b thread function_bdca389bf7863d86();
  var_23551dada6d5703b thread function_22bf381d4d467316(var_23551dada6d5703b.lifetime);
  var_23551dada6d5703b thread function_87e78a3564c3df84(var_23551dada6d5703b.var_2f53a6b82c6bd61b, var_23551dada6d5703b.var_2f2f9cb82c434565);
}

#using_animtree("scriptables");

function private function_bdca389bf7863d86() {
  level endon("game_ended");
  self endon("death");
  self setscriptablepartstate("main", "iw9_mp_decoymine_inflate", 0);
  wait getanimlength(%iw9_mp_decoymine_inflate);
  function_bcb2363beb52563d();
}

function function_22bf381d4d467316(lifetime) {
  level endon("game_ended");
  self endon("death");

  if(lifetime <= 0) {
    return;
  }

  wait lifetime;
}

function private function_87e78a3564c3df84(var_2f53a6b82c6bd61b, var_2f2f9cb82c434565) {
  level endon("game_ended");
  self endon("death");
  self endon("afo_dummy_destroyed");
  self.activity endon("activity_ended");

  while(!isDefined(self.activity.warlord_agent)) {
    wait 2;
  }

  while(isDefined(self.activity.warlord_agent)) {
    pinglocationenemyteams(self.origin, self.team, self.activity.warlord_agent);
    firetype = utility::ter_op(randomint(2), "smgFire", "arFire");
    self setscriptablepartstate("weaponSounds", firetype, 1);

    if(!isDefined(var_2f53a6b82c6bd61b) || !isDefined(var_2f2f9cb82c434565)) {
      return;
    }

    var_1b2cb028ec97bdf8 = randomfloatrange(var_2f53a6b82c6bd61b, var_2f2f9cb82c434565);
    wait var_1b2cb028ec97bdf8;
  }
}

function private function_7a5475b2d852cbe3(data) {
  thread function_a3ba34f65c02912a(data.direction_vec);
  return damage::modifydamage(data);
}

function private function_a3ba34f65c02912a(damagedirection) {
  level endon("game_ended");
  self endon("death");
  self endon("damage");
  self endon("inflatable_destroyed");

  if(!isDefined(damagedirection)) {
    return;
  }

  self setscriptablepartstate("hitreact", "neutral", 0);
  waitframe();
  damagedirection = vectorNormalize(damagedirection);
  forwarddir = anglesToForward(self.angles);
  forwarddir = vectorNormalize(forwarddir);
  rightdir = anglestoright(self.angles);
  rightdir = vectorNormalize(rightdir);

  if(vectordot(forwarddir, damagedirection) > 0.70711) {
    self setscriptablepartstate("hitreact", "iw9_mp_decoymine_hitreac_back", 0);
    wait getanimlength(%iw9_mp_decoymine_hitreac_back);
  } else if(vectordot(forwarddir * -1, damagedirection) > 0.70711) {
    self setscriptablepartstate("hitreact", "iw9_mp_decoymine_hitreac_front", 0);
    wait getanimlength(%iw9_mp_decoymine_hitreac_front);
  } else if(vectordot(rightdir, damagedirection) > 0.70711) {
    self setscriptablepartstate("hitreact", "iw9_mp_decoymine_hitreac_left", 0);
    wait getanimlength(%iw9_mp_decoymine_hitreac_left);
  } else if(vectordot(rightdir * -1, damagedirection) > 0.70711) {
    self setscriptablepartstate("hitreact", "iw9_mp_decoymine_hitreac_right", 0);
    wait getanimlength(%iw9_mp_decoymine_hitreac_right);
  }

  function_bcb2363beb52563d();
}

function private function_3b91f075feeb9315() {
  level endon("game_ended");
  self waittill("afo_dummy_destroyed");

  if(isDefined(self.activity) && isDefined(self.activity.warlord_agent)) {
    var_211e69a014146049 = self.origin + (0, 0, 65);
    var_bcf224bf37277a85 = utility::playersincylinder(var_211e69a014146049, 512, undefined, 100);
    flashbangweapon = makeweapon("jup_flash_grenade_ob");
    waitframe();

    if(getdvarint(@ "hash_a8862c6361d1024a", 0)) {
      thread scripts\cp_mp\utility\debug_utility::drawcylinder(var_211e69a014146049, 512, 100, 20, (0, 1, 0));
      thread scripts\cp_mp\utility\debug_utility::drawcylinder(var_211e69a014146049 - (0, 0, 100), 512, 100, 20, (0, 1, 0));
      thread scripts\mp\utility\debug::drawsphere(var_211e69a014146049, 5, 10, (1, 0, 0));
    }

    inflictor = self.activity.warlord_agent;

    foreach(flashedplayer in var_bcf224bf37277a85) {
      directray = scripts\engine\trace::ray_trace_passed(flashedplayer getEye(), var_211e69a014146049, flashedplayer);

      if(directray) {
        flashedplayer dodamage(1, var_211e69a014146049, inflictor, inflictor, "MOD_EXPLOSIVE", flashbangweapon);
      }
    }

    self.activity.warlord_agent namespace_dc53a27a8db8e6bf::function_a15f7af910d7f1b6();
  }

  if(isDefined(self.navobstacleid)) {
    destroynavobstacle(self.navobstacleid);
  }

  if(isDefined(self.deathcallback)) {
    self thread[[self.deathcallback]]();
  }
}

function private function_bcb2363beb52563d() {
  level endon("game_ended");
  self endon("death");
  self setscriptablepartstate("main", "idleHealth", 0);
  self setscriptablepartstate("health", "damage_detect", 0);
}