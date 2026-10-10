/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2cd303a32758e76c.gsc
*************************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\radiation;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace ob_redeploy_drone;

function main() {
  level thread function_deee3b97bf9c0945();
}

function function_deee3b97bf9c0945() {
  waitframe();

  if(!getdvarint(@ "redeploy_ascenders_enabled", 0)) {
    return;
  }

  init();
}

function init() {
  level thread debug_init();

  initvariables();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("redeploy_drone_interact", &function_f0567cda220a6f7d);
  function_f1aed36ab4598ea("mp_jup_ob_redeploy_drone");
  level thread function_23f7acaab482446();
}

#using_animtree("scriptables");

function initvariables() {
  level.var_fc4bb27a820f54dd = spawnStruct();
  level.var_fc4bb27a820f54dd.i_count = getdvarint(@ "scr_redeploy_drone_count", 4);
  level.var_fc4bb27a820f54dd.var_43c609d0bf76cedc = getdvarint(@ "hash_fc06cf8b2e6ff7c8", 100);
  level.var_fc4bb27a820f54dd.var_3bc74411a49ef743 = getdvarint(@ "hash_4d3f3ddcf9c9ae8f", 2000);
  level.var_fc4bb27a820f54dd.var_94ca860762f3c07b = getdvarint(@ "hash_2044315c6a32e0cf", 512);
  level.var_fc4bb27a820f54dd.var_f94808af4addfa87 = getdvarint(@ "hash_3d4c3c323e772733", 10);
  level.var_fc4bb27a820f54dd.var_f96af6af4b041aa9 = getdvarint(@ "hash_3d7052323e9fd24d", 50);
  level.var_fc4bb27a820f54dd.var_73610df6cb8260e6 = getdvarint(@ "scr_redeploy_drone_despawn_index", 3);
  level.var_fc4bb27a820f54dd.var_4b2cdacf483dccc4 = getdvarfloat(@ "hash_590a91e3623c94d", 4);
  level.var_fc4bb27a820f54dd.var_ab77bcfbf6ec9587 = getdvarint(@ "hash_3cd8f7500c4cffcb", 15);
  level.var_fc4bb27a820f54dd.var_7e1e2deb54381dce = getdvarint(@ "hash_7a6046af43f645a", 5);
  level.var_fc4bb27a820f54dd.var_b09e88ff96d15c04 = getdvarint(@ "hash_67144a280e505eb0", 10);
  level.var_fc4bb27a820f54dd.var_73e374ce21fb4fb5 = getdvarint(@ "hash_e0052f554fb1d69", 50);
  var_e375f6bd7e1961c9 = getdvarint(@ "hash_9bd3724f70106775", 30000);
  level.var_fc4bb27a820f54dd.var_d1343ed4c5b69716 = squared(var_e375f6bd7e1961c9);
  var_d961317263b789a2 = getdvarint(@ "hash_59c137234dad4ad6", 8000);
  level.var_fc4bb27a820f54dd.var_8a13be89e30d617 = squared(var_d961317263b789a2);
  level.var_fc4bb27a820f54dd.var_f06709293dd563e6 = getmatchrulesdata("commonOption", "parachuteOverheadWarningRadius");
  level.var_fc4bb27a820f54dd.var_9a279e924352be3b = getmatchrulesdata("commonOption", "parachuteOverheadWarningHeight");
  level.var_fc4bb27a820f54dd.var_b24b7a96d6c8e3c8 = getmatchrulesdata("commonOption", "parachuteOverheadWarningTimeoutMs");
  level.var_fc4bb27a820f54dd.var_2eb08138d7d6ee45 = getanimlength(%veh9_mil_air_drone_redeploy_extend_hook_01);
  level.var_fc4bb27a820f54dd.var_8a066943bb13715f = getanimlength(%veh9_mil_air_drone_redeploy_retract_hook_01);
  level.var_fc4bb27a820f54dd.var_1c9f02381dcb3a4c = [];
  level.var_fc4bb27a820f54dd.var_5715be6ca445d02e = getentitylessscriptablearray("scriptable_ob_redeploy_drone", "classname");
  level notify("ob_drones_setup");
  level.var_fc4bb27a820f54dd.var_8dfc726e5b63525b = [];
}

function function_23f7acaab482446() {
  waitframe();
  function_aa6c956fa42c8dfd();
  function_4255350c89e0fecb();

  foreach(scriptable in level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c) {
    scriptable spawn_redeploy_drone();
  }
}

function function_4255350c89e0fecb() {
  redeploy_spawns = scripts\engine\utility::array_randomize(level.var_fc4bb27a820f54dd.var_5715be6ca445d02e);
  level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c = [];
  i_spawned = 0;

  foreach(scriptable in redeploy_spawns) {
    if(i_spawned >= level.var_fc4bb27a820f54dd.i_count) {
      scriptable thread function_ef3ab989669b4682();

      continue;
    }

    if(scriptable function_e745a94784401dfb()) {
      scriptable thread function_ef3ab989669b4682();

      continue;
    }

    var_7c6a1a7581e76afc = 1;

    foreach(other in redeploy_spawns) {
      if(!array_contains(level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c, other)) {
        continue;
      }

      if(distance2dsquared(scriptable.origin, other.origin) > level.var_fc4bb27a820f54dd.var_d1343ed4c5b69716) {
        continue;
      }

      var_7c6a1a7581e76afc = 0;

      scriptable thread function_ef3ab989669b4682();

      break;
    }

    if(var_7c6a1a7581e76afc) {
      level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c[i_spawned] = scriptable;
      i_spawned++;
    }
  }
}

function function_e745a94784401dfb() {
  ingas = 0;

  foreach(circle in level.radiation.instances) {
    ingas = circle scripts\cp_mp\radiation::function_1b4f63fa623de69a(self.origin);
  }

  return ingas;
}

function spawn_redeploy_drone() {
  function_ca6ea48c877cd367();
  self setscriptablepartstate("redeploy_drone_sfx", "engine_idle_sfx");
  self setscriptablepartstate("redeploy_drone_vfx", "enabled");
  self setscriptablepartstate("redeploy_drone_interact", "available");
  thread function_8a47414d4d7859df();

  if(getdvarint(@ "hash_94cc2e00dc85444b", 1) && !isDefined(self.temp)) {
    drone = spawn("script_model", self.origin);
    drone setModel("jup_ob_mil_air_drone_redeploy_relocate_lights");
    drone.angles = self.angles;
    drone.speed = 0;
    drone forcenetfieldhighlod(1);
    drone notsolid();
    self.temp = drone;
  }

  callback::callback("on_spawn_redeploy_drone");
}

function function_105f0caaa61e873() {
  wait 23;
  var_bcef23e599e4cc3c = vectordot(anglestoright(level.br_ac130.angles), vectorNormalize(self.origin - level.br_ac130.origin));
  v_spawn = level.br_ac130.origin + anglesToForward(level.br_ac130.angles) * -1 * (distance(level.br_ac130.origin, self.origin) - 45000) + anglestoright(level.br_ac130.angles) * 15000 * var_bcef23e599e4cc3c;
  var_57318a9f25cee67d = 100;
  var_570e949f25a8b4c3 = scripts\cp_mp\parachute::getc130height() - 4000;
  var_5731809f25ced07f = var_57318a9f25cee67d + var_570e949f25a8b4c3 / 2;
  var_fe7278bc3929329e = (var_570e949f25a8b4c3 - var_57318a9f25cee67d) / 2;
  var_3b7468ecd13ad07b = vectordot(anglesToForward(level.br_ac130.angles), vectorNormalize(v_spawn - level.br_ac130.origin));
  var_bfff077aec6dc176 = var_5731809f25ced07f + var_fe7278bc3929329e * var_3b7468ecd13ad07b;
  v_spawn += (0, 0, -1 * var_bfff077aec6dc176);
  drone = spawn("script_model", v_spawn);
  drone setModel("jup_ob_mil_air_drone_redeploy_relocate_lights");
  drone.angles = vectortoangles(self.origin - drone.origin);
  drone.speed = level.var_fc4bb27a820f54dd.var_73e374ce21fb4fb5 * 4 * level.var_fc4bb27a820f54dd.var_ccd62f7f63fb25b3;
  drone forcenetfieldhighlod(1);

  drone thread debug_sphere(undefined, 25, (1, 0, 0));

  drone thread debug_orientation((1, 0, 0));

  drone thread function_6d9358d777958a1b(self);
  drone thread function_53a07930f4fc0e08(self);
  drone thread function_314cdfb5c5633b1();

  while(!isDefined(drone.var_3b4fee20d214bd9b) || !isDefined(drone.var_f44262daab1a384a)) {
    wait 0.05;
  }

  drone notify("relocation_complete");
  drone delete();
  cable_deploy();

  if(self getscriptablepartstate("redeploy_drone") == "unavailable") {
    return;
  }

  function_ca6ea48c877cd367();
  thread function_8a47414d4d7859df();
}

function function_aa6c956fa42c8dfd() {
  collisioncontents = physics_createcontents(["physicscontents_aiclip", "physicscontents_water"]);

  foreach(scriptable in level.var_fc4bb27a820f54dd.var_5715be6ca445d02e) {
    trace = scripts\engine\trace::ray_trace(scriptable.origin, scriptable.origin + (0, 0, -3000), undefined, collisioncontents, 1, 1, 0);
    scriptable.var_e02f90c16d8ae6d5 = trace["surfacetype"];
    scriptable.var_7a6430ba88c4d983 = trace["position"];
  }
}

function function_ca6ea48c877cd367() {
  self setscriptablepartstate("redeploy_drone", "available");
  self.b_occupied = 1;
  self.b_used = 1;

  function_5d3b11328dcb5023();

  if(!isDefined(self.var_7a6430ba88c4d983)) {
    self.var_7a6430ba88c4d983 = self.origin - (0, 0, 2727);
  }

  var_f252b4de7806249 = spawnscriptable("ob_redeploy_drone_anchor_impact", self.var_7a6430ba88c4d983);
  waitframe();

  if(!isDefined(self.var_e02f90c16d8ae6d5)) {
    self.var_e02f90c16d8ae6d5 = "<dev string:x1c>";
  }

  if(isDefined(self.var_e02f90c16d8ae6d5)) {
    switch (self.var_e02f90c16d8ae6d5) {
      case #"hash_296fec58e16e327":
      case #"hash_2fa4167540164873":
      case #"hash_588c5c47805606eb":
      case #"hash_5f33d5485b7f33ed":
      case #"hash_6dc36f3e31f59c8b":
        var_f252b4de7806249 setscriptablepartstate("redeploy_drone_anchor_impact", "impact_concrete");
        break;
      case #"hash_126fff7ad2aa45":
      case #"hash_5ff12d0a2c109d2c":
      case #"hash_d4e7d6c49368be7f":
        var_f252b4de7806249 setscriptablepartstate("redeploy_drone_anchor_impact", "impact_dirt");
        break;
      case #"hash_2dc2bd39328def65":
      case #"hash_3990683480267242":
        var_f252b4de7806249 setscriptablepartstate("redeploy_drone_anchor_impact", "impact_water");
        break;
    }
  }

  waitframe();
  var_f252b4de7806249 freescriptable();
}

function function_7fa5478ed150d979() {
  self setscriptablepartstate("redeploy_drone", "unavailable");
  self.b_occupied = 0;

  function_b286b55f5ce15dd5();

  if(getdvarint(@ "hash_94cc2e00dc85444b", 1) && isDefined(self.temp)) {
    if(isDefined(self.temp)) {
      self.temp delete();
    }
  }
}

function cable_deploy() {
  thread deploy_icon();

  if(getdvarint(@ "hash_94cc2e00dc85444b", 1) && !isDefined(self.temp)) {
    drone = spawn("script_model", self.origin);
    drone setModel("jup_ob_mil_air_drone_redeploy_relocate_lights");
    drone.angles = self.angles;
    drone.speed = 0;
    drone forcenetfieldhighlod(1);
    drone notsolid();
    self.temp = drone;
  }

  self setscriptablepartstate("redeploy_drone", "deploy");

  function_95d6afd76d60638b();

  wait level.var_fc4bb27a820f54dd.var_2eb08138d7d6ee45;
}

function deploy_icon() {
  deploy_icon = spawnscriptable("ob_redeploy_drone_deploy", self.origin - (0, 0, 2727));
  wait 0.8;
  deploy_icon freescriptable();
}

function cable_retract() {
  self setscriptablepartstate("redeploy_drone", "retract");

  function_95d6afd76d60638b();

  wait level.var_fc4bb27a820f54dd.var_8a066943bb13715f - 0.7;
  self setscriptablepartstate("redeploy_drone_cable_sfx", "retract_stop");
  wait 0.7;
}

function redeploy_drone_destroyed(eattacker, modelname) {
  if(getdvarint(@ "hash_94cc2e00dc85444b", 1) && isDefined(self.temp)) {
    self.temp delete();
  }

  self setscriptablepartstate("redeploy_drone", "unavailable");
  self setscriptablepartstate("redeploy_drone_sfx", "disabled");
  self setscriptablepartstate("redeploy_drone_cable_sfx", "disabled");
  self setscriptablepartstate("redeploy_drone_anchor_sfx", "disabled");

  function_20998d024463786f();

  self.b_occupied = 0;
  drone = spawn("script_model", self.origin);
  drone setModel("jup_ob_mil_air_drone_redeploy_relocate_lights");
  drone.angles = self.angles;
  drone.speed = 0;
  self notify("redeploy_drone_destroyed");

  if(isDefined(modelname) && modelname == "ks_airstrike_target_br_ch3") {
    eattacker.var_3efdaabc0f66846d++;
  }

  drone function_e47fae0ab5c70a88();
}

function function_e47fae0ab5c70a88() {
  level endon("game_ended");
  waitframe();
  self setscriptablepartstate("redeploy_drone_relocation_smoke_vfx", "enabled");
  self physics_registerforcollisioncallback();
  thread function_26aacbd66ab5c92();
  self waittill("collision");
  redeploy_drone_explosion();
  wait 0.2;
  self delete();
}

function function_26aacbd66ab5c92() {
  level endon("game_ended");
  self endon("collision");
  v_movement = (0, 0, 0);

  if(isDefined(self.v_destination)) {
    v_movement = vectorNormalize(self.v_destination - self.origin);
  }

  self physics_takecontrol(1, self.origin, v_movement * self.speed * 1500);
  i = level.var_fc4bb27a820f54dd.var_43c609d0bf76cedc;
  x = randomfloatrange(i / 2, i);
  x = ter_op(cointoss(), x, x * -1);
  y = randomfloatrange(i / 2, i);
  y = ter_op(cointoss(), y, y * -1);
  z = randomfloatrange(i / 10, i / 5);
  z = ter_op(cointoss(), z, z * -1);
  self physics_applyimpulse(self.origin + (randomintrange(-50, 51), randomintrange(-50, 51), randomintrange(-50, 51)), (x, y, z));

  while(true) {
    var_d5cdf67a50a74a7a = anglesToForward(self.angles) * randomfloatrange(-1 * level.var_fc4bb27a820f54dd.var_3bc74411a49ef743, level.var_fc4bb27a820f54dd.var_3bc74411a49ef743);
    var_983148e6d0c8d005 = anglestoright(self.angles) * randomfloatrange(-1 * level.var_fc4bb27a820f54dd.var_3bc74411a49ef743, level.var_fc4bb27a820f54dd.var_3bc74411a49ef743);
    var_9a1f339b9a782980 = anglestoup(self.angles) * randomfloat(level.var_fc4bb27a820f54dd.var_3bc74411a49ef743);
    self physics_applyimpulse(self.origin + (randomintrange(-50, 51), randomintrange(-50, 51), randomintrange(-50, 51)), var_d5cdf67a50a74a7a + var_983148e6d0c8d005 + var_9a1f339b9a782980);
    wait 0.05;
  }
}

function redeploy_drone_explosion() {
  vfx = spawnscriptable("ob_redeploy_drone_explosion", self.origin);
  waitframe();
  radiusdamage(self.origin, level.var_fc4bb27a820f54dd.var_94ca860762f3c07b, level.var_fc4bb27a820f54dd.var_f96af6af4b041aa9, level.var_fc4bb27a820f54dd.var_f94808af4addfa87, undefined, "MOD_EXPLOSIVE");
  vfx freescriptable();
}

function function_f0567cda220a6f7d(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  player thread function_ea7ddf2defb7947a(instance);
  player thread function_1b9a6266f1942fac(instance);
}

function function_ea7ddf2defb7947a(instance) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  instance endon("death");
  threshold_sq = squared(19);

  while(distance2dsquared(self.origin, instance.origin) > threshold_sq) {
    waitframe();
  }

  while(distance2dsquared(self.origin, instance.origin) < threshold_sq) {
    waitframe();
  }

  self notify("redeploy_drone_launch");
  thread function_b4d6206c99452cac();
  thread function_d52ae9fc3100cecf();
  self waittill("ascender_detached");

  if(instance.origin[2] - self.origin[2] < 300) {
    self playsoundevent("sndevent_redeploydrone_launch_player");
  }
}

function function_b4d6206c99452cac() {
  level endon("game_ended");
}

function function_d52ae9fc3100cecf() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  while(!self isonground()) {
    nearbyplayers = utility::playersincylinder(self.origin, level.var_fc4bb27a820f54dd.var_f06709293dd563e6, undefined, level.var_fc4bb27a820f54dd.var_9a279e924352be3b);
    teamcompare = self.team;

    foreach(targetplayer in nearbyplayers) {
      sameteam = teamcompare == targetplayer.team;

      if(sameteam) {
        continue;
      }

      var_cda71aec07aab082 = !scripts\mp\utility\player::isreallyalive(targetplayer) || istrue(targetplayer.inlaststand);

      if(var_cda71aec07aab082) {
        continue;
      }

      var_744496cccbbfcb78 = targetplayer isparachuting() || targetplayer isinfreefall();

      if(var_744496cccbbfcb78) {
        continue;
      }

      time = gettime();
      var_8edff54c680323 = isDefined(targetplayer.heardparachuteoverheadtime) && time - targetplayer.heardparachuteoverheadtime < level.var_fc4bb27a820f54dd.var_b24b7a96d6c8e3c8;

      if(var_8edff54c680323) {
        continue;
      }

      targetplayer.heardparachuteoverheadtime = time;
      operatorteam = scripts\mp\utility\teams::getteamdata(self.targetplayer.team, "players");
      var_7570afa45d86040f = game["voice"][operatorteam];
      targetplayer queuedialogforplayer(level.activeparachutersfactionvo[var_7570afa45d86040f], "respawning_enemy_in_area", 2);
    }

    waitframe();
  }
}

function function_1b9a6266f1942fac(instance) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("redeploy_drone_launch");
  instance waittill("redeploy_drone_destroyed");
  self function_61195b9ee307ad14();
}

function function_c4f705b1e3e908de() {
  level endon("game_ended");
  level waittill("br_circle_set");

  while(level.br_circle.circleindex != level.var_fc4bb27a820f54dd.var_73610df6cb8260e6) {
    wait level.var_fc4bb27a820f54dd.var_b09e88ff96d15c04;
  }

  foreach(scriptable in level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c) {
    if(scriptable getscriptablepartstate("redeploy_drone") == "available" || scriptable getscriptablepartstate("redeploy_drone") == "deploy" || scriptable getscriptablepartstate("redeploy_drone") == "retract") {
      scriptable thread function_bfa2960787851ba9();
      wait randomintrange(5, 10);
    }
  }
}

function function_2ad170b9d70c7062() {}

function function_8a47414d4d7859df() {
  if(getdvarint(@ "hash_20d28f147758431b", 0) && level.mapname == "<dev string:x2d>") {
    return;
  }

  level endon("game_ended");
  ingas = 0;

  while(!ingas) {
    foreach(circle in level.radiation.instances) {
      ingas = circle scripts\cp_mp\radiation::function_1b4f63fa623de69a(self.origin);
    }

    wait 1;
  }

  thread redeploy_drone_relocate();
}

function redeploy_drone_relocate() {
  level endon("game_ended");
  level notify("forced_kill_callout_" + self.origin);
  scripts\cp_mp\calloutmarkerping::function_6bc4f6b579285f79();
  var_42de8ecd1b474886 = 0;
  i_wait = level.var_fc4bb27a820f54dd.var_ab77bcfbf6ec9587 - level.var_fc4bb27a820f54dd.var_7e1e2deb54381dce * var_42de8ecd1b474886;

  if(i_wait < level.var_fc4bb27a820f54dd.var_b09e88ff96d15c04) {
    i_wait = level.var_fc4bb27a820f54dd.var_b09e88ff96d15c04;
  }

  wait i_wait;

  if(self getscriptablepartstate("redeploy_drone") == "unavailable") {
    return;
  }

  var_daad7d20d7a17c02 = undefined;
  var_9225dfdb20269b5a = undefined;

  foreach(scriptable in level.var_fc4bb27a820f54dd.var_5715be6ca445d02e) {
    if(istrue(scriptable.b_occupied)) {
      continue;
    }

    if(scriptable getscriptablepartstate("redeploy_drone") == "available" || scriptable getscriptablepartstate("redeploy_drone") == "deploy" || scriptable getscriptablepartstate("redeploy_drone") == "retract") {
      continue;
    }

    if(isDefined(level.aether_storm) && isDefined(level.aether_storm.radiation) && level.aether_storm.radiation scripts\cp_mp\radiation::function_1b4f63fa623de69a(scriptable.origin)) {
      continue;
    }

    var_a1b92276657285b7 = distance(scriptable.origin, self.origin) / 489.7;
    var_a1b92276657285b7 += 3;

    if(isDefined(level.aether_storm) && isDefined(level.aether_storm.radiation)) {
      var_2f7cdde7f272c34c = level.aether_storm.radiation scripts\cp_mp\radiation::function_fde05749af14d99c(scriptable.origin);

      if(var_2f7cdde7f272c34c <= var_a1b92276657285b7) {
        continue;
      }
    }

    if(scriptable function_77e61741cc59c806()) {
      scriptable function_ef3ab989669b4682();

      continue;
    }

    distance_sq = distance2dsquared(self.origin, scriptable.origin);

    if(!isDefined(var_9225dfdb20269b5a) || distance_sq < var_9225dfdb20269b5a) {
      var_9225dfdb20269b5a = distance_sq;
      var_daad7d20d7a17c02 = scriptable;
    }
  }

  if(!isDefined(var_daad7d20d7a17c02)) {
    self setscriptablepartstate("redeploy_drone_interact", "disabled");
    cable_retract();
    thread function_f0ab4e5f3c9004e5();
    return;
  }

  var_daad7d20d7a17c02.b_occupied = 1;
  var_daad7d20d7a17c02.b_used = 1;
  cable_retract();

  if(self getscriptablepartstate("redeploy_drone") == "unavailable") {
    return;
  }

  self setscriptablepartstate("redeploy_drone_cable_sfx", "retract_stop");
  function_7fa5478ed150d979();
  drone = spawn("script_model", self.origin);
  drone setModel("jup_ob_mil_air_drone_redeploy_relocate_lights");
  drone.angles = self.angles;
  drone.speed = 0;
  drone setCanDamage(1);
  drone forcenetfieldhighlod(1);

  drone thread debug_sphere(undefined, 25, (1, 0, 0));

  drone thread debug_orientation((1, 0, 0));

  drone thread function_6d9358d777958a1b(var_daad7d20d7a17c02);
  drone thread function_53a07930f4fc0e08(var_daad7d20d7a17c02);
  drone thread function_314cdfb5c5633b1(self, var_daad7d20d7a17c02);

  while(!isDefined(drone.var_3b4fee20d214bd9b) || !isDefined(drone.var_f44262daab1a384a)) {
    wait 0.05;
  }

  drone notify("relocation_complete");
  drone callback::callback("on_redeploy_drone_relocated");
  drone delete();
  var_daad7d20d7a17c02 cable_deploy();

  if(var_daad7d20d7a17c02 getscriptablepartstate("redeploy_drone") == "unavailable") {
    return;
  }

  var_daad7d20d7a17c02 function_ca6ea48c877cd367();
  var_daad7d20d7a17c02 thread function_8a47414d4d7859df();
}

function function_f0ab4e5f3c9004e5() {
  level notify("forced_kill_callout_" + self.origin);
  scripts\cp_mp\calloutmarkerping::function_6bc4f6b579285f79();

  if(getdvarint(@ "hash_94cc2e00dc85444b", 1) && isDefined(self.temp)) {
    self.temp delete();
  }

  self setscriptablepartstate("redeploy_drone", "unavailable");
  self setscriptablepartstate("redeploy_drone_sfx", "disabled");
  self setscriptablepartstate("redeploy_drone_cable_sfx", "disabled");
  self setscriptablepartstate("redeploy_drone_anchor_sfx", "disabled");

  function_20998d024463786f();

  self.b_occupied = 0;
  drone = spawn("script_model", self.origin);
  drone setModel("jup_ob_mil_air_drone_redeploy_relocate_lights");
  drone.angles = self.angles;
  drone.speed = 0;
  self notify("redeploy_drone_destroyed");
  drone function_e47fae0ab5c70a88();
}

function function_bfa2960787851ba9() {
  level endon("game_ended");
  var_42de8ecd1b474886 = 0;
  i_wait = level.var_fc4bb27a820f54dd.var_ab77bcfbf6ec9587 - level.var_fc4bb27a820f54dd.var_7e1e2deb54381dce * var_42de8ecd1b474886;

  if(i_wait < level.var_fc4bb27a820f54dd.var_b09e88ff96d15c04) {
    i_wait = level.var_fc4bb27a820f54dd.var_b09e88ff96d15c04;
  }

  wait i_wait;

  if(self getscriptablepartstate("redeploy_drone") == "unavailable") {
    return;
  }

  s_despawn = spawnStruct();
  var_9602b340166dcdd7 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  s_despawn.origin = self.origin + vectorNormalize(self.origin - (var_9602b340166dcdd7[0], var_9602b340166dcdd7[1], self.origin[2])) * 20000;
  s_despawn.angles = vectortoangles(self.origin - (var_9602b340166dcdd7[0], var_9602b340166dcdd7[1], self.origin[2]));
  cable_retract();

  if(self getscriptablepartstate("redeploy_drone") == "unavailable") {
    return;
  }

  function_7fa5478ed150d979();
  drone = spawn("script_model", self.origin);
  drone setModel("jup_ob_mil_air_drone_redeploy_relocate_lights");
  drone.angles = self.angles;
  drone.speed = 0;
  drone forcenetfieldhighlod(1);

  drone thread debug_sphere(undefined, 25, (1, 0, 0));

  drone thread debug_orientation((1, 0, 0));

  drone thread function_6d9358d777958a1b(s_despawn);
  drone thread function_53a07930f4fc0e08(s_despawn);
  drone thread function_314cdfb5c5633b1(self);

  while(!isDefined(drone.var_3b4fee20d214bd9b) || !isDefined(drone.var_f44262daab1a384a)) {
    wait 0.05;
  }

  drone notify("relocation_complete");
  drone delete();
}

function function_d0250169e6dfa8e4(eattacker, modelname) {
  if(isDefined(modelname) && modelname == "ks_airstrike_target_br_ch3") {
    eattacker.var_3efdaabc0f66846d++;
  }

  self.owner = eattacker;
  function_e47fae0ab5c70a88();
}

function function_77e61741cc59c806() {
  foreach(scriptable in level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c) {
    if(scriptable == self) {
      continue;
    }

    if(istrue(scriptable.b_occupied)) {
      if(distance2dsquared(self.origin, scriptable.origin) < level.var_fc4bb27a820f54dd.var_8a13be89e30d617) {
        return true;
      }
    }
  }

  return false;
}

function function_6d9358d777958a1b(var_daad7d20d7a17c02) {
  level endon("game_ended");
  self endon("entitydeleted");
  self.v_destination = var_daad7d20d7a17c02.origin;

  thread function_b29b629016747e8c(var_daad7d20d7a17c02);

  while(self.speed < level.var_fc4bb27a820f54dd.var_73e374ce21fb4fb5) {
    self.speed += 1;

    if(self.speed > level.var_fc4bb27a820f54dd.var_73e374ce21fb4fb5) {
      self.speed = level.var_fc4bb27a820f54dd.var_73e374ce21fb4fb5;
    }

    self moveTo(self.origin + self.speed * vectorNormalize(self.v_destination - self.origin), 0.05, 0, 0);
    wait 0.05;
  }

  if(self.speed > level.var_fc4bb27a820f54dd.var_73e374ce21fb4fb5) {
    while(distance2dsquared(self.origin, self.v_destination) > squared(self.speed * 20 * level.var_fc4bb27a820f54dd.var_ccd62f7f63fb25b3)) {
      self moveTo(self.origin + self.speed * vectorNormalize(self.v_destination - self.origin), 0.05, 0, 0);
      wait 0.05;
    }

    self notify("redeploy_drone_arrive");

    while(distance2dsquared(self.origin, self.v_destination) > 0.01) {
      self moveTo(self.origin + (self.v_destination - self.origin) * 0.05 / level.var_fc4bb27a820f54dd.var_ccd62f7f63fb25b3, 0.05, 0, 0);
      self.speed *= 0.95;
      wait 0.05;
    }
  } else {
    while(distance2dsquared(self.origin, self.v_destination) > 500 * 500) {
      self moveTo(self.origin + self.speed * vectorNormalize(self.v_destination - self.origin), 0.05, 0, 0);
      wait 0.05;
    }

    self notify("redeploy_drone_arrive");

    while(distance2dsquared(self.origin, self.v_destination) > 0.01) {
      self moveTo(self.origin + (self.v_destination - self.origin) * 0.1, 0.05, 0, 0);
      self.speed *= 0.9;
      wait 0.05;
    }
  }

  self moveTo(self.v_destination, 0.05, 0, 0);
  wait 0.05;
  self.speed = 0;
  self.v_destination = undefined;
  self.var_3b4fee20d214bd9b = 1;
}

function function_53a07930f4fc0e08(var_daad7d20d7a17c02) {
  level endon("game_ended");
  self endon("entitydeleted");
  v_diff = vectorNormalize(var_daad7d20d7a17c02.origin - self.origin);
  var_da83f385e7e33e1 = vectortoangles(v_diff)[1] - self.angles[1];

  if(var_da83f385e7e33e1 < -180) {
    var_da83f385e7e33e1 += 360;
  }

  if(var_da83f385e7e33e1 > 180) {
    var_da83f385e7e33e1 -= 360;
  }

  var_3b7468ecd13ad07b = vectordot(v_diff, anglesToForward(self.angles));
  var_bcef23e599e4cc3c = vectordot(v_diff, anglestoright(self.angles));
  f_frames = abs(var_da83f385e7e33e1);
  var_be553a9ce54d449 = f_frames - 90;

  if(var_be553a9ce54d449 > 0) {
    var_39fb5d4ca8578c6 = var_be553a9ce54d449 / f_frames;
    self rotateby((30 * var_3b7468ecd13ad07b + 15, var_da83f385e7e33e1 * var_39fb5d4ca8578c6, 30 * var_bcef23e599e4cc3c), var_be553a9ce54d449 * 0.025, var_be553a9ce54d449 / 2 * 0.025, 0);
    wait var_be553a9ce54d449 * 0.025;
    var_452972b9d736dfd6 = f_frames - var_be553a9ce54d449;
    self rotateTo((30, vectortoangles(v_diff)[1], 0), var_452972b9d736dfd6 * 0.025, 0, var_452972b9d736dfd6 / 2 * 0.025);
    wait var_452972b9d736dfd6 * 0.025;
  } else {
    f_halftime = f_frames / 2 * 0.025;

    if(f_halftime < 1) {
      f_halftime = 1;
    }

    self rotateby((15 * var_3b7468ecd13ad07b, var_da83f385e7e33e1 / 2, 15 * var_bcef23e599e4cc3c), f_halftime, f_halftime / 2, 0);
    wait f_halftime;
    self rotateTo((30, vectortoangles(v_diff)[1], 0), f_halftime, 0, f_halftime / 2);
    wait f_halftime;
  }

  self waittill("redeploy_drone_arrive");
  var_da83f385e7e33e1 = var_daad7d20d7a17c02.angles[1] - self.angles[1];

  if(var_da83f385e7e33e1 < -180) {
    var_da83f385e7e33e1 += 360;
  }

  if(var_da83f385e7e33e1 > 180) {
    var_da83f385e7e33e1 -= 360;
  }

  var_3b7468ecd13ad07b = vectordot(anglesToForward(self.angles), anglesToForward(var_daad7d20d7a17c02.angles));
  var_bcef23e599e4cc3c = vectordot(anglestoright(self.angles), anglesToForward(var_daad7d20d7a17c02.angles));
  f_halftime = 1;
  self rotateby((-30 * var_3b7468ecd13ad07b - 30, var_da83f385e7e33e1 / 2, 30 * var_bcef23e599e4cc3c), f_halftime, f_halftime / 2, 0);
  wait f_halftime;
  self rotateTo((0, var_daad7d20d7a17c02.angles[1], 0), f_halftime, 0, f_halftime / 2);
  wait f_halftime;
  self.var_f44262daab1a384a = 1;
}

function function_314cdfb5c5633b1(var_76bfd75ccab42a13, var_359e64e7a629dd94) {
  self endon("entitydeleted");
  wait 1;
  self setscriptablepartstate("redeploy_drone_relocation_sfx", "relocation_loop");

  if(isDefined(var_76bfd75ccab42a13)) {
    var_76bfd75ccab42a13 setscriptablepartstate("redeploy_drone_sfx", "disabled");
  }

  self waittill("redeploy_drone_arrive");

  if(isDefined(var_359e64e7a629dd94)) {
    var_359e64e7a629dd94 setscriptablepartstate("redeploy_drone_sfx", "relocation_sfx_end");
    wait 0.5;
    var_359e64e7a629dd94 setscriptablepartstate("redeploy_drone_sfx", "engine_idle_sfx");
  }

  self setscriptablepartstate("redeploy_drone_relocation_sfx", "relocation_end");
}

function function_b1eab7c7fda1fb57() {}

function debug_init() {
  level waittill("<dev string:x40>");
  level thread function_db5c75f2a84ff03d();
  function_dee4eb3645627eea(@ "hash_20d28f147758431b", &function_3b88aadd61acb2f7);
  function_dee4eb3645627eea(@ "hash_1b823e69b7bcb477", &function_ae4ed007ee115b61);
  function_dee4eb3645627eea(@ "hash_7206433d469d7d0a", &function_f17472706da6eab0);
  function_dee4eb3645627eea(@ "hash_44c9b804cfee044b", &function_12bab4323f6ad87d);
  function_dee4eb3645627eea(@ "hash_61419e769e38b201", &function_f2d4069ca59a8db6);
}

function function_db5c75f2a84ff03d() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x52>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x68>", "<dev string:x71>", &function_b1ad7f49e2d9a2c1);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x8a>", "<dev string:xa3>", &function_bb29c4b9f489b197);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:xcc>", "<dev string:xea>", &function_79db3fe8077d4858);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x118>", "<dev string:x12b>", &function_6f727cad8b163563);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x14e>", "<dev string:x160>", &function_a093df9d6f259949);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x17a>", "<dev string:x18d>", &function_185952854ebaec16);
  scripts\common\devgui::function_fe953f000498048f();
}

function function_dee4eb3645627eea(dvar, func) {
  if(getdvarint(dvar, 0)) {
    [[func]]();
  }
}

function function_b1ad7f49e2d9a2c1() {
  if(!getdvarint(@ "hash_d7987b5db214b981", 0)) {
    function_d8b0e8ca68b581f3();
    return;
  }

  function_42b57a2447545237();
}

function function_d8b0e8ca68b581f3() {
  setDvar(@ "hash_d7987b5db214b981", 1);
  iprintlnbold("<dev string:x1a8>");
}

function function_42b57a2447545237() {
  setDvar(@ "hash_d7987b5db214b981", 0);
  iprintlnbold("<dev string:x1d5>");
}

function function_bb29c4b9f489b197() {
  if(!getdvarint(@ "hash_1b823e69b7bcb477", 0)) {
    function_ae4ed007ee115b61();
    return;
  }

  function_688b987090050bdd();
}

function function_ae4ed007ee115b61() {
  setDvar(@ "hash_1b823e69b7bcb477", 1);
  iprintlnbold("<dev string:x203>");
  level thread function_29896330c83a80fa();
}

function function_29896330c83a80fa(v_position, i_radius) {
  level endon("<dev string:x240>");
  level endon("<dev string:x24e>");
  var_271f7ba625d29bdd = getdvarint(@ "hash_9bd3724f70106775", 30000);

  while(true) {
    var_7e3573e6ecff532d = -1;
    scr_closest = undefined;

    foreach(scriptable in level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c) {
      v_player = anglesToForward(level.players[0] getplayerangles());
      var_d9b55f33c875d95d = vectorNormalize(scriptable.origin - level.players[0] getEye());
      f_dot = vectordot(v_player, var_d9b55f33c875d95d);

      if(f_dot >= var_7e3573e6ecff532d) {
        var_7e3573e6ecff532d = f_dot;
        scr_closest = scriptable;
      }
    }

    foreach(scriptable in level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c) {
      if(scriptable == scr_closest) {
        sphere(scriptable.origin, 200, (1, 1, 1), 0, 2);
        cylinder(scriptable.origin - (0, 0, 10), scriptable.origin + (0, 0, 10), var_271f7ba625d29bdd, (0, 0, 1), 0, 2);
        continue;
      }

      cylinder(scriptable.origin - (0, 0, 10), scriptable.origin + (0, 0, 10), var_271f7ba625d29bdd, (0.5, 0.5, 0.5), 0, 2);
    }

    waitframe();
  }
}

function function_688b987090050bdd() {
  setDvar(@ "hash_1b823e69b7bcb477", 0);
  iprintlnbold("<dev string:x289>");
  level notify("<dev string:x24e>");
}

function function_79db3fe8077d4858() {
  if(!getdvarint(@ "hash_7206433d469d7d0a", 0)) {
    function_f17472706da6eab0();
    return;
  }

  function_aa257341263c992a();
}

function function_f17472706da6eab0() {
  setDvar(@ "hash_7206433d469d7d0a", 1);
  iprintlnbold("<dev string:x2c7>");
  level thread function_7269acc313c13ac3();
}

function function_7269acc313c13ac3(v_position, i_radius) {
  level endon("<dev string:x240>");
  level endon("<dev string:x309>");
  var_53f65fa15502d74e = getdvarint(@ "hash_59c137234dad4ad6", 8000);

  while(true) {
    var_7e3573e6ecff532d = -1;
    scr_closest = undefined;

    foreach(scriptable in level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c) {
      v_player = anglesToForward(level.players[0] getplayerangles());
      var_d9b55f33c875d95d = vectorNormalize(scriptable.origin - level.players[0] getEye());
      f_dot = vectordot(v_player, var_d9b55f33c875d95d);

      if(f_dot >= var_7e3573e6ecff532d) {
        var_7e3573e6ecff532d = f_dot;
        scr_closest = scriptable;
      }
    }

    foreach(scriptable in level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c) {
      if(scriptable == scr_closest) {
        sphere(scriptable.origin, 200, (1, 1, 1), 0, 2);
        cylinder(scriptable.origin - (0, 0, 10), scriptable.origin + (0, 0, 10), var_53f65fa15502d74e, (1, 1, 0), 0, 2);
        continue;
      }

      cylinder(scriptable.origin - (0, 0, 10), scriptable.origin + (0, 0, 10), var_53f65fa15502d74e, (0.5, 0.5, 0.5), 0, 2);
    }

    waitframe();
  }
}

function function_aa257341263c992a() {
  setDvar(@ "hash_7206433d469d7d0a", 0);
  iprintlnbold("<dev string:x349>");
  level notify("<dev string:x309>");
}

function function_6f727cad8b163563() {
  if(!getdvarint(@ "hash_44c9b804cfee044b", 0)) {
    function_12bab4323f6ad87d();
    return;
  }

  function_9b4f358177d29219();
}

function function_12bab4323f6ad87d() {
  setDvar(@ "hash_44c9b804cfee044b", 1);
  iprintlnbold("<dev string:x38c>");

  foreach(scriptable in level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c) {
    scriptable thread function_ae07af550fa417d9();
  }
}

function function_ae07af550fa417d9() {
  level endon("<dev string:x240>");
  level endon("<dev string:x3c3>");

  while(true) {
    switch (self.var_e02f90c16d8ae6d5) {
      case #"hash_126fff7ad2aa45":
      case #"hash_296fec58e16e327":
      case #"hash_2dc2bd39328def65":
      case #"hash_2fa4167540164873":
      case #"hash_3990683480267242":
      case #"hash_588c5c47805606eb":
      case #"hash_5f33d5485b7f33ed":
      case #"hash_5ff12d0a2c109d2c":
      case #"hash_6dc36f3e31f59c8b":
      case #"hash_d4e7d6c49368be7f":
        print3d(self.var_7a6430ba88c4d983 + (0, 0, 200), self.var_e02f90c16d8ae6d5, (1, 1, 1), 1, 10, 2, 1);
        sphere(self.var_7a6430ba88c4d983, 20, (1, 1, 1), 0, 2);
        break;
      default:
        print3d(self.var_7a6430ba88c4d983 + (0, 0, 200), self.var_e02f90c16d8ae6d5, (1, 0, 0), 1, 10, 2, 1);
        sphere(self.var_7a6430ba88c4d983, 20, (1, 0, 0), 0, 2);
        break;
    }

    waitframe();
  }
}

function function_9b4f358177d29219() {
  setDvar(@ "hash_d7987b5db214b981", 0);
  iprintlnbold("<dev string:x1d5>");
  level notify("<dev string:x3c3>");
}

function function_a093df9d6f259949() {
  foreach(scriptable in level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c) {
    scriptable thread function_73d6b1775a971305();
  }
}

function function_73d6b1775a971305() {
  cable_deploy();
  function_ca6ea48c877cd367();
}

function function_185952854ebaec16() {
  foreach(scriptable in level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c) {
    scriptable thread cable_retract();
  }
}

function function_3b88aadd61acb2f7() {
  if(level.mapname != "<dev string:x2d>") {
    return;
  }

  level notify("<dev string:x4b9>");
  level endon("<dev string:x4b9>");
  scr_static = spawnscriptable("<dev string:x4e3>", (0, 0, 2740));
  var_730315a2d2560fad = spawnscriptable("<dev string:x4e3>", (0, 0, 0));
  var_730312a2d2560914 = spawnscriptable("<dev string:x4e3>", (0, 0, 0));
  level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c[level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c.size] = scr_static;
  level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c[level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c.size] = var_730315a2d2560fad;
  level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c[level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c.size] = var_730312a2d2560914;
  var_730315a2d2560fad.i_random = randomint(360);
  var_730315a2d2560fad.origin = scr_static.origin + 5500 * anglesToForward((0, var_730315a2d2560fad.i_random, 0));
  var_730312a2d2560914.i_random = var_730315a2d2560fad.i_random + randomintrange(90, 270);

  if(var_730312a2d2560914.i_random >= 360) {
    var_730312a2d2560914.i_random -= 360;
  }

  var_730312a2d2560914.origin = scr_static.origin + 5500 * anglesToForward((0, var_730312a2d2560914.i_random, 0));
  scr_static function_ca6ea48c877cd367();
  scr_static setscriptablepartstate("<dev string:x4f8>", "<dev string:x50e>");
  scr_static setscriptablepartstate("<dev string:x521>", "<dev string:x537>");
  var_730315a2d2560fad function_f5c0566b1aa605fb();
  var_730312a2d2560914 function_ca6ea48c877cd367();
  var_730312a2d2560914 setscriptablepartstate("<dev string:x4f8>", "<dev string:x50e>");
  var_730312a2d2560914 setscriptablepartstate("<dev string:x521>", "<dev string:x537>");

  while(true) {
    scr_static thread redeploy_drone_relocate();
    wait 6;
    var_730312a2d2560914 redeploy_drone_relocate();
    wait 6;
    var_730312a2d2560914.i_random = var_730315a2d2560fad.i_random + randomintrange(90, 270);

    if(var_730312a2d2560914.i_random >= 360) {
      var_730312a2d2560914.i_random -= 360;
    }

    var_730312a2d2560914.origin = scr_static.origin + 5500 * anglesToForward((0, var_730312a2d2560914.i_random, 0));
    var_730312a2d2560914 function_f5c0566b1aa605fb();
    var_730312a2d2560914 setscriptablepartstate("<dev string:x4f8>", "<dev string:x542>");
    scr_static thread redeploy_drone_relocate();
    wait 6;
    var_730315a2d2560fad redeploy_drone_relocate();
    wait 6;
    var_730315a2d2560fad.i_random = var_730312a2d2560914.i_random + randomintrange(90, 270);

    if(var_730315a2d2560fad.i_random >= 360) {
      var_730315a2d2560fad.i_random -= 360;
    }

    var_730315a2d2560fad.origin = scr_static.origin + 5500 * anglesToForward((0, var_730315a2d2560fad.i_random, 0));
    var_730315a2d2560fad function_f5c0566b1aa605fb();
    var_730315a2d2560fad setscriptablepartstate("<dev string:x4f8>", "<dev string:x542>");
  }
}

function function_f868abadfcd3f180(instance, time) {
  wait time;
  instance redeploy_drone_destroyed();
}

function function_f5c0566b1aa605fb() {
  self setscriptablepartstate("<dev string:x54e>", "<dev string:x560>");
  self setscriptablepartstate("<dev string:x56f>", "<dev string:x542>");
  self setscriptablepartstate("<dev string:x58b>", "<dev string:x542>");
  self.b_occupied = 0;
  function_20998d024463786f();
}

function function_5d3b11328dcb5023() {
  function_a615190cb6a4e817((0, 1, 0));
}

function function_20998d024463786f() {
  function_a615190cb6a4e817((1, 1, 0));
}

function function_763b92766c8f0070() {
  function_a615190cb6a4e817((0, 1, 1));
}

function function_ef3ab989669b4682() {
  function_a615190cb6a4e817((0, 0, 1));
}

function function_b286b55f5ce15dd5() {
  function_a615190cb6a4e817((1, 0, 0));
}

function function_95d6afd76d60638b() {
  function_a615190cb6a4e817((1, 0.5, 0));
}

function function_a615190cb6a4e817(v_rgb) {
  self notify("<dev string:x5a8>");
  thread debug_sphere(self.origin, 100, v_rgb);
  thread debug_line(self.origin, self.origin - (0, 0, 2700), v_rgb);
}

function debug_line(var_b668cc19c2cf6623, var_b668cd19c2cf6856, v_rgb) {
  self endon("<dev string:x5a8>");

  while(isDefined(self)) {
    if(getdvarint(@ "hash_d7987b5db214b981", 0)) {
      line(var_b668cc19c2cf6623, var_b668cd19c2cf6856, v_rgb, 1, 0, 2);
    }

    waitframe();
  }
}

function debug_sphere(v_pos, i_radius, v_rgb) {
  self endon("<dev string:x5a8>");

  while(isDefined(self)) {
    if(getdvarint(@ "hash_d7987b5db214b981", 0)) {
      if(isDefined(v_pos)) {
        sphere(v_pos, i_radius, v_rgb, 0, 2);
      } else {
        sphere(self.origin, i_radius, v_rgb, 0, 2);
      }
    }

    waitframe();
  }
}

function function_b29b629016747e8c(var_daad7d20d7a17c02) {
  self endon("<dev string:x5c4>");

  while(isDefined(self)) {
    if(getdvarint(@ "hash_d7987b5db214b981", 0)) {
      line(self.origin, var_daad7d20d7a17c02.origin, (1, 1, 0), 1, 0, 2);
    }

    waitframe();
  }
}

function debug_orientation(v_rgb) {
  if(!getdvarint(@ "hash_d7987b5db214b981", 0)) {
    return;
  }

  while(isDefined(self)) {
    if(getdvarint(@ "hash_d7987b5db214b981", 0)) {
      line(self.origin, self.origin + anglesToForward(self.angles) * 100, v_rgb, 1, 0, 2);
      line(self.origin - anglestoright(self.angles) * 75, self.origin + anglestoright(self.angles) * 75, v_rgb, 1, 0, 2);
    }

    waitframe();
  }
}

function function_f2d4069ca59a8db6() {
  if(!getdvarint(@ "hash_d7987b5db214b981", 0)) {
    return;
  }

  foreach(scriptable in level.var_fc4bb27a820f54dd.var_5715be6ca445d02e) {
    scriptable spawn_redeploy_drone();
  }

  foreach(scriptable in level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c) {
    scriptable cable_deploy();
    scriptable function_ca6ea48c877cd367();
  }
}

# /