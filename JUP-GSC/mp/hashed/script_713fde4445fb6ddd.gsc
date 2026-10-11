/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_713fde4445fb6ddd.gsc
*************************************************/

#using script_64acb6ce534155b7;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\outofbounds;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#using scripts\mp\vehicles\damage;
#using scripts\mp\weapons;
#namespace namespace_334ec991babd91b6;

function autoexec main() {
  scripts\engine\utility::registersharedfunc("spy_drones", "get_contract_data", &get_contract_data);
}

function get_contract_data(data) {
  data.funcs["onInit"] = &on_init;
  data.funcs["onTeamAssigned"] = &function_af6a5c04fc885a4d;
  data.funcs["onTimerExpired"] = &function_5863139a72088b70;
  data.funcs["onCancel"] = &on_cancel;
  data.funcs["onPlayerDisconnect"] = &on_player_disconnect;
  data.funcs["onPlayerKilled"] = &on_player_killed;
  data.funcs["onMarkPlayerAsEliminated"] = &function_6dc61b7571555571;
  data.funcs["circleTick"] = &function_a78f24ba9aac3cd5;
  data.funcs["onFinishContract"] = &function_ee646c1d9d674584;
  level.spydrones = spawnStruct();
  level.spydrones.vehiclename = "spy_drone";
  level.spydrones.contracttime = getdvarint(@ "hash_97a0696c063a004c", 0);
  level.spydrones.spawnaltitude = getdvarint(@ "hash_c73da0a654de8430", 6500);
  level.spydrones.despawnaltitude = getdvarint(@ "hash_e359f8d9f40f5fb7", 16000);
  level.spydrones.idlealtitude = getdvarint(@ "hash_af022b1ef968cc83", 450);
  level.spydrones.droptime = getdvarint(@ "hash_1ed93fcd383baa41", 10);
  level.spydrones.scanwaittime = getdvarint(@ "hash_223b6de7453982e3", 30);
  level.spydrones.var_7e11f30ecaba3c2c = getdvarint(@ "hash_c1f4605f4d534d4a", 12);
  level.spydrones.var_8d64c1e526cb3c9e = getdvarint(@ "hash_2cc7dbc9d32728d", 7);
  level.spydrones.var_3d741ef8d5214272 = getdvarint(@ "hash_afd77622d1b63c7b", 300);
  level.spydrones.var_9724cd8c777a6103 = getdvarint(@ "hash_7ca35f006d8580b3", 1500);
  level.spydrones.speed = getdvarfloat(@ "hash_d182cb7ada456cc", 45);
  level.spydrones.var_5416ef1fdf377938 = getdvarfloat(@ "hash_cd1616eed5dd4409", 30);
  level.spydrones.accel = getdvarfloat(@ "hash_d692997169c00a97", 25);
  level.spydrones.var_5b48dcda7b72fc1b = getdvarfloat(@ "hash_48d3c6a2e7403cea", 15);
  level.spydrones.inactivetime = getdvarfloat(@ "hash_577bbbed4c20a3a8", 120);
  level.spydrones.var_eb3c475f74f5d11b = getdvarint(@ "hash_88cf6935eb16f1b3", 1);
  level.spydrones.hoverradius = getdvarint(@ "hash_85c6dce18c60610", 45);
  level.spydrones.var_4e9df5e4d1c7d66f = getdvarint(@ "hash_517aee82eddb5494", 1);
  level.spydrones.var_37143a4776fd671a = getdvarint(@ "hash_e271d94d2c80cc71", 5);
  level.spydrones.var_f0b6500ab0c9ccd4 = getdvarint(@ "hash_2972f454837e984d", 750);
  level.spydrones.swarmrotation = getdvarint(@ "hash_a9135dada6cbfc45", 1);
  level.spydrones.var_c90aee48e8bbef34 = getdvarint(@ "hash_bab89af7e7ed3335", 1);
  level.spydrones.swarmtranslation = getdvarint(@ "hash_e562667a19968b4a", 1);
  level.spydrones.var_b2e7d09f60c71a95 = getdvarint(@ "hash_a1dae6220b47dfba", 240);
  level.spydrones.var_b4c111452c8a17c7 = getdvarint(@ "hash_6421db0b97efb51d", 0);
  level.spydrones.var_2acf733fef4b661d = getdvarfloat(@ "hash_b6fdcff9878ebb74", 5);
  level.spydrones.var_656b373748c79d2b = getdvarfloat(@ "hash_77bd3b2d0835a1a", 8);
  level.spydrones.var_eaee16945de09051 = getdvarint(@ "hash_efc819376ad05131", 10);
  level.spydrones.var_5941676f3b051afb = getdvarint(@ "hash_9d71c588ce0a129f", 2);
  level.spydrones.var_79deb552a64787b8 = getdvarint(@ "hash_3e423a1e80e07bd7", 3);
  level.spydrones.combotime = getdvarfloat(@ "hash_1ded6da45aaa9b60", 5);
  level.spydrones.comboevents = [#"hash_336289015889ab4f", #"hash_da1a4a4971ee6567", #"hash_da1a494971ee63b4", #"hash_105b9440e7c3705e"];
  level.spydrones.var_3ee437c870237781 = getdvarfloat(@ "hash_a3411010080554fa", 0.25);

  if(level.spydrones.contracttime > 0) {
    data.basetime = level.spydrones.contracttime;
  } else {
    data.basetime = namespace_1eb3c4e0e28fac71::function_ea591c2a379e3424("spy_drones");
  }

  init_dialogue();

  level thread debug_init();

  return true;
}

function on_init() {
  return true;
}

function init_dialogue() {
  game["dialog"]["spyd_grav_msns"] = "spyd_grav_msns";
  game["dialog"]["spyd_grav_enac"] = "spyd_grav_enac";
  game["dialog"]["spyd_grav_enco"] = "spyd_grav_enco";
  game["dialog"]["spyd_grav_remi"] = "spyd_grav_remi";
  game["dialog"]["spyd_grav_msnc"] = "spyd_grav_msnc";
  game["dialog"]["spyd_grav_retr"] = "spyd_grav_retr";
  game["dialog"]["spyd_grav_mifa"] = "spyd_grav_mifa";
}

function function_a3e7d456c9513ece() {
  return #"ping_objective_go_generic";
}

function function_af6a5c04fc885a4d() {
  self.category = "spy_drones";

  if(!isDefined(self.var_d154ac2657c5f44)) {
    return;
  }

  time = level.spydrones.contracttime > 0 ? level.spydrones.contracttime : namespace_1eb3c4e0e28fac71::function_ea591c2a379e3424(self.category);
  time = function_9b6275085fbcb8f4(time);
  namespace_1eb3c4e0e28fac71::function_5a15174d34f0670c(time, 0);
  radius = randomintrange(2500, 3500);
  angle = randomfloat(360);
  self.var_10c5be9ea8f4c46e = self.var_d154ac2657c5f44 getorigin();
  safecircleradius = scripts\mp\gametypes\br_circle::getsafecircleradius();
  safecircleorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  spawnpoint = function_e969d8de0451b131(angle, radius);
  step = 0;

  while(step < 360) {
    if(!function_e23523569a77acd5(spawnpoint, level.br_level.br_mapcenter, &scripts\mp\outofbounds::ispointinoutofbounds) && !function_e23523569a77acd5(spawnpoint, safecircleorigin, &function_ef4bf1bc5b6710e4)) {
      break;
    }

    angle -= 45;
    spawnpoint = function_e969d8de0451b131(angle, radius);
    step += 45;
  }

  if(function_e23523569a77acd5(spawnpoint, safecircleorigin, &function_ef4bf1bc5b6710e4) || function_e23523569a77acd5(spawnpoint, level.br_level.br_mapcenter, &scripts\mp\outofbounds::ispointinoutofbounds)) {
    if(safecircleradius <= level.spydrones.var_9724cd8c777a6103) {
      spawnpoint = scripts\mp\gametypes\br_circle::getrandompointinsafecircle();
    } else {
      arearadius = min(radius + level.spydrones.var_9724cd8c777a6103, safecircleradius);
      areacenter = function_89a8eac2c864a128(self.var_10c5be9ea8f4c46e, safecircleorigin, safecircleradius, arearadius);
      arearadius -= level.spydrones.var_9724cd8c777a6103;
      assert(arearadius > 0);
      spawnpoint = scripts\common\utility::function_c62375923163b86c(areacenter, arearadius);
    }
  }

  scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522("SpyDrones_Br", spawnpoint, level.spydrones.var_9724cd8c777a6103);

  if(getdvarint(@ "hash_cf71a0cb04519608", 0) == 1) {
    scripts\cp_mp\utility\game_utility::function_6988310081de7b45();
  } else {
    teamplayers = scripts\mp\utility\teams::getteamdata(self.teams[0], "players");

    foreach(player in teamplayers) {
      scripts\cp_mp\utility\game_utility::function_cfd53c8f6878014f(player);
    }
  }

  splashref = function_4bcd7c36b22b9bec("br_spy_drones_quest_start_team");
  namespace_1eb3c4e0e28fac71::displayteamsplash(self.teams[0], splashref);
  namespace_1eb3c4e0e28fac71::displaysquadmessagetoteam(self.teams[0], self.var_d154ac2657c5f44, 6, namespace_1eb3c4e0e28fac71::getquestindex("spy_drones"));
  self.drones = [];
  spawn_drones();
  self.var_f1ca51112a318561 = level.spydrones.var_eaee16945de09051;
  self.var_9dd4c2b54544f5f3 = level.spydrones.var_79deb552a64787b8;
  self.var_a8b35ed9bf00396c = 0;
  self.var_9b08ab39d372b35d = 1;
  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("spyd_grav_msns", self.teams[0], 1, 0, undefined, undefined);
  thread function_acad5b6746ae352e();
  namespace_1eb3c4e0e28fac71::function_e2aa45e2c6b5dec1(level.spydrones.var_8d64c1e526cb3c9e - self.drones.size);
  thread function_1b8fe45856358d18();
}

function function_e969d8de0451b131(angle, radius) {
  offset = (radius * cos(angle), radius * sin(angle), 0);
  spawnpoint = self.var_10c5be9ea8f4c46e + offset;
  spawnpoint = (spawnpoint[0], spawnpoint[1], 0);
  return spawnpoint;
}

function function_ef4bf1bc5b6710e4(spawnpoint) {
  return scripts\mp\gametypes\br_circle_util::gettimetilldangerforpoint(spawnpoint) < 40;
}

function function_e23523569a77acd5(spawnpoint, destinationpoint, validationfunction) {
  if([[validationfunction]](spawnpoint)) {
    return true;
  }

  directionvector = vectornormalize2(spawnpoint - destinationpoint);
  offset = (level.spydrones.var_9724cd8c777a6103 * directionvector[0], level.spydrones.var_9724cd8c777a6103 * directionvector[1], 0);

  if([[validationfunction]](spawnpoint + offset)) {
    return true;
  }

  return false;
}

function function_89a8eac2c864a128(referenceposition, var_dd92012e24bc0731, safecircleradius, arearadius) {
  directionvector = vectornormalize2(referenceposition - var_dd92012e24bc0731);
  var_6e4e364dd66c73e2 = safecircleradius - arearadius;
  assert(var_6e4e364dd66c73e2 > 0);
  var_f5f06d1d20d64a08 = var_dd92012e24bc0731 + directionvector * var_6e4e364dd66c73e2;
  return var_f5f06d1d20d64a08;
}

function drone_handledeathdamage(data) {
  self notify("death", data);
}

function function_f16989f55836eb5f(drone) {
  level endon("game_ended");
  drone endon("entitydeleted");
  killer = undefined;
  drone waittill("death", data);
  killer = data.attacker;
  self.drones = arrayremove(self.drones, drone);
  namespace_1eb3c4e0e28fac71::function_e2aa45e2c6b5dec1(level.spydrones.var_8d64c1e526cb3c9e - self.drones.size);
  scripts\mp\weapons::function_1a33bd42949ccbda(drone);
  drone setscriptablepartstate("scan", "off");
  drone setscriptablepartstate("blink", "off");
  drone setscriptablepartstate("exit", "on");
  var_7087d9795dffce4d = isDefined(killer) && isDefined(killer.team) && isDefined(level.contractmanager.var_b6fae9c9655c73bf[killer.team]) && level.contractmanager.var_b6fae9c9655c73bf[killer.team] == self;

  if(!var_7087d9795dffce4d && !istrue(self.var_a8b35ed9bf00396c) && self.drones.size > 0) {
    self.var_a8b35ed9bf00396c = 1;
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam("spyd_grav_enac", self.teams[0], 1, 0, undefined, undefined);
  }

  if(var_7087d9795dffce4d) {
    self.var_9b08ab39d372b35d = 0;
  }

  thread award_xp(killer);
  items = [];

  if(self.var_f1ca51112a318561 > 0) {
    var_8b26223da6a3ae38 = int(min(self.var_f1ca51112a318561, randomint(level.spydrones.var_5941676f3b051afb) + 1));

    for(i = 0; i < var_8b26223da6a3ae38; i++) {
      items[items.size] = "brloot_armor_plate";
    }

    self.var_f1ca51112a318561 -= var_8b26223da6a3ae38;
  }

  if(self.var_9dd4c2b54544f5f3 > 0) {
    var_211417dbf8a951b2 = self.drones.size == 0 ? self.var_9dd4c2b54544f5f3 : self.var_9dd4c2b54544f5f3 / self.drones.size;

    if(var_211417dbf8a951b2 < 1) {
      var_211417dbf8a951b2 = randomfloat(1) < var_211417dbf8a951b2 ? 1 : 0;
    } else {
      var_211417dbf8a951b2 = floor(var_211417dbf8a951b2);
    }

    for(i = 0; i < var_211417dbf8a951b2; i++) {
      items[items.size] = "brloot_super_personal_redeploy_drone";
    }

    self.var_9dd4c2b54544f5f3 -= var_211417dbf8a951b2;
  }

  if(self.drones.size == 0) {
    rewardsposition = spawnStruct();
    rewardsposition.origin = drone.origin;
    rewardsposition.angles = drone.angles;
    on_end(var_7087d9795dffce4d, rewardsposition, killer, items);
  } else {
    drone drop_items(items);
  }

  if(isDefined(drone)) {
    if(isDefined(data.inflictor) && data.inflictor.classname == "rocket") {
      data.inflictor waittill_any_return_1("explode");
    }

    waitframe();
    scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(drone);
  }
}

function on_end(var_7087d9795dffce4d, rewardsposition, var_13dc3b5519c135bd, var_d544c62ea2bc64b) {
  level endon("game_ended");
  endstate = "fail";
  var_5e671fc71e72d5e8 = undefined;

  if(istrue(self.ended)) {
    return;
  }

  self.ended = 1;

  if(isDefined(var_13dc3b5519c135bd)) {
    var_5e671fc71e72d5e8 = var_13dc3b5519c135bd.team;
    var_5cf607a8b578aacf = isDefined(rewardsposition);

    if(var_5cf607a8b578aacf) {
      items = getscriptcachecontents("br_quest_spdr", 0);

      if(isDefined(var_d544c62ea2bc64b) && var_d544c62ea2bc64b.size > 0) {
        items = scripts\engine\utility::array_combine(items, var_d544c62ea2bc64b);
      }

      scripts\mp\gametypes\br_quest_util::questrewarddropitems(var_5e671fc71e72d5e8, items, rewardsposition.origin, rewardsposition.angles, 0, undefined, undefined);

      if(getdvarint(@ "redeploy_ascenders_enabled", 0)) {}
    }

    splashref = function_4bcd7c36b22b9bec("br_spy_drones_quest_complete_team");

    if(var_7087d9795dffce4d) {
      endstate = "success";
      namespace_1eb3c4e0e28fac71::displaysquadmessagetoteam(var_5e671fc71e72d5e8, var_13dc3b5519c135bd, 8, namespace_1eb3c4e0e28fac71::getquestindex("spy_drones"));
      level thread scripts\mp\gametypes\br_public::brleaderdialogteam("spyd_grav_msnc", self.teams[0], 1, 0, undefined, undefined);
    } else {
      endstate = "poached";
      splashref = "br_spy_drones_quest_poached_team";

      if(var_5cf607a8b578aacf) {
        namespace_1eb3c4e0e28fac71::function_6ddd1eecbe562acf("spy_drones_poached", self.teams[0], rewardsposition);
      }

      level thread scripts\mp\gametypes\br_public::brleaderdialogteam("spyd_grav_enco", self.teams[0], 1, 0, undefined, undefined);
    }

    namespace_1eb3c4e0e28fac71::displayteamsplash(self.teams[0], splashref);

    if(!isDefined(rewardsposition)) {
      rewardsposition = var_13dc3b5519c135bd;
    }

    namespace_1eb3c4e0e28fac71::function_d212a5e7a40d7c8d("spy_drones", var_5e671fc71e72d5e8, rewardsposition, self);
  }

  self.var_50b1df2d20db660c = undefined;
  namespace_1eb3c4e0e28fac71::endcontract(ter_op(endstate == "success", self.teams[0], undefined), undefined, undefined, endstate);
  thread delete_circle();
  self notify("task_ended");
}

function on_player_disconnect(player) {
  on_player_removed(player);
}

function on_player_killed(attacker, victim) {
  on_player_removed(victim);
}

function function_6dc61b7571555571(player) {
  on_player_removed(player);
}

function on_player_removed(player) {
  if(player.team == self.teams[0]) {
    filter = namespace_1eb3c4e0e28fac71::function_94a8dc26f5353759(player, level.contractmanager.defaultfilter);

    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(self.teams[0], filter)) {
      function_5863139a72088b70(1);
    }
  }
}

function delete_circle() {
  if(!scripts\mp\flags::levelflag("game_over")) {
    wait 1;
  }

  scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
}

function spawn_drones() {
  var_2c48f74fe5c701df = scripts\cp_mp\utility\game_utility::function_d9583306c5a171e4();
  assertex(level.spydrones.var_9724cd8c777a6103 > level.spydrones.var_3d741ef8d5214272, "<dev string:x1c>");
  var_391c13efd58f5e76 = scripts\common\utility::function_c62375923163b86c(var_2c48f74fe5c701df, level.spydrones.var_9724cd8c777a6103 - level.spydrones.var_3d741ef8d5214272);

  if(level.spydrones.var_eb3c475f74f5d11b == 1) {
    var_391c13efd58f5e76 = var_2c48f74fe5c701df;
  }

  groundposition = function_65b4f543fd133009(var_391c13efd58f5e76);
  self.var_391c13efd58f5e76 = (var_391c13efd58f5e76[0], var_391c13efd58f5e76[1], level.spydrones.idlealtitude + groundposition[2]);
  positionangle = 0;
  var_aef2ed11d202fab7 = 360 / level.spydrones.var_8d64c1e526cb3c9e;
  radius = level.spydrones.var_3d741ef8d5214272;
  spawnpointz = groundposition[2] + level.spydrones.spawnaltitude;

  for(i = 0; i < level.spydrones.var_8d64c1e526cb3c9e; i++) {
    spawnpointx = radius * cos(positionangle) + var_391c13efd58f5e76[0];
    spawnpointy = radius * sin(positionangle) + var_391c13efd58f5e76[1];
    spawnpoint = (spawnpointx, spawnpointy, spawnpointz);
    spawnangles = vectortoangles(spawnpoint - var_391c13efd58f5e76);
    drone = spawn_drone(spawnpoint, spawnangles);

    if(isDefined(drone)) {
      thread drone_drop(drone, level.spydrones.idlealtitude, groundposition[2]);
      thread function_f16989f55836eb5f(drone);
      thread drone_monitorcollision(drone);
      drone.positionangle = positionangle;
      positionangle += var_aef2ed11d202fab7;
      self.drones[self.drones.size] = drone;
    }
  }

  thread function_d47839ee3ce653dc();
}

function function_d47839ee3ce653dc() {
  self endon("task_ended");
  self endon("flee");
  justdropped = 1;

  while(true) {
    if(!istrue(self.var_50b1df2d20db660c)) {
      wait 1;
      continue;
    }

    if(istrue(justdropped)) {
      justdropped = 0;
      waittime = randomfloatrange(level.spydrones.var_2acf733fef4b661d, level.spydrones.var_656b373748c79d2b);
      thread function_489eaaeafa77dbde(waittime);
      wait waittime;
    }

    function_9610fe687f77b1f();
    translationoffset = undefined;
    waittime = 0.05;
    var_3b4e7ab7e6a61a55 = randomintrange(1, 4);

    if(getdvarint(@ "hash_3f60762c6d72f8e8", 0) == 1) {
      var_3b4e7ab7e6a61a55 = getdvarint(@ "hash_9fa6c5a4c0e40c8c", 1);
    }

    if(var_3b4e7ab7e6a61a55 == 1 || var_3b4e7ab7e6a61a55 == 3) {
      if(level.spydrones.swarmrotation) {
        clockwise = randomint(2) == 0;
        function_dd9bdd215fe08636(clockwise);
      }
    }

    if(var_3b4e7ab7e6a61a55 == 2 || var_3b4e7ab7e6a61a55 == 3) {
      if(level.spydrones.swarmtranslation) {
        direction = randomintrange(1, 3);

        if(getdvarint(@ "hash_3be38535e2f1992b", 0) == 1) {
          direction = getdvarint(@ "hash_be73562595947f97", 2);
        }

        translationoffset = function_e9b50da39c7991a5(direction);
      }
    }

    if(!function_d70e70300ee6ea8c(translationoffset) && function_ce1465f6e226d2ea()) {
      waittime = randomfloatrange(level.spydrones.var_2acf733fef4b661d, level.spydrones.var_656b373748c79d2b);
      function_e6f301e018da281f();

      if(isDefined(translationoffset)) {
        self.var_391c13efd58f5e76 += translationoffset;
      }

      if(!istrue(self.var_50b1df2d20db660c)) {
        self waittill("manoeuvre_ready");
      }

      thread function_489eaaeafa77dbde(waittime);
    }

    wait waittime;
  }
}

function function_dd9bdd215fe08636(clockwise) {
  var_aef2ed11d202fab7 = 360 / level.spydrones.var_8d64c1e526cb3c9e;

  if(!istrue(clockwise)) {
    var_aef2ed11d202fab7 *= -1;
  }

  if(level.spydrones.var_c90aee48e8bbef34) {
    max = int(level.spydrones.var_8d64c1e526cb3c9e / 2) - 1;

    if(level.spydrones.var_8d64c1e526cb3c9e > 2 && max > 1) {
      var_aef2ed11d202fab7 *= randomintrange(1, max);
    }
  }

  radius = level.spydrones.var_3d741ef8d5214272;

  foreach(drone in self.drones) {
    positionangle = drone.positionangle + var_aef2ed11d202fab7;
    drone.positionangle = positionangle;
    destinationx = radius * cos(positionangle) + self.var_391c13efd58f5e76[0];
    destinationy = radius * sin(positionangle) + self.var_391c13efd58f5e76[1];
    destination = (destinationx, destinationy, drone.origin[2]);
    drone.destination = destination;
  }
}

function function_e9b50da39c7991a5(direction) {
  offsetx = 0;
  offsety = 0;
  offsetz = 0;

  if(direction == 2 || direction == 3) {
    up = randomint(2) == 0;
    offsetz = up ? level.spydrones.var_b2e7d09f60c71a95 : level.spydrones.var_b2e7d09f60c71a95 * -1;
  }

  if(direction == 3 || direction == 1) {
    angle = randomfloat(360);
    offsetx = level.spydrones.var_b2e7d09f60c71a95 * cos(angle);
    offsety = level.spydrones.var_b2e7d09f60c71a95 * sin(angle);
  }

  offset = (offsetx, offsety, offsetz);

  foreach(drone in self.drones) {
    if(isDefined(drone.destination)) {
      drone.destination += offset;
      continue;
    }

    drone.destination = drone.origin + offset;
  }

  return offset;
}

function function_ce1465f6e226d2ea() {
  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight"]);
  ignorelist = self.drones;

  foreach(drone in self.drones) {
    if(!isDefined(drone) || !isDefined(drone.origin)) {
      continue;
    }

    if(!isDefined(drone.destination)) {
      return false;
    }

    if(scripts\engine\utility::ispointinwater(drone.destination) || scripts\mp\outofbounds::ispointinoutofbounds((drone.destination[0], drone.destination[1], 0))) {
      return false;
    }

    hits = physics_spherecast(drone.destination, drone.origin, 50 + level.spydrones.hoverradius, contents, ignorelist, "physicsquery_closest");

    if(level.spydrones.var_b4c111452c8a17c7) {
      for(i = 0; i < 10; i++) {
        physics_spherecast(drone.destination, drone.origin, 50 + level.spydrones.hoverradius, contents, ignorelist, "<dev string:x78>");
        waitframe();
      }
    }

    if(isDefined(hits) && hits.size > 0) {
      return false;
    }
  }

  return true;
}

function function_d70e70300ee6ea8c(translationoffset) {
  if(!isDefined(translationoffset) || translationoffset[2] == 0) {
    return false;
  }

  drone = self.drones[0];
  radius = level.spydrones.var_3d741ef8d5214272;
  positionangle = drone.positionangle;
  self.var_391c13efd58f5e76 = (drone.origin[0] - radius * cos(positionangle), drone.origin[1] - radius * sin(positionangle), self.var_391c13efd58f5e76[2]);
  var_98df157cbb48db26 = self.var_391c13efd58f5e76 + translationoffset;
  groundposition = function_65b4f543fd133009(var_98df157cbb48db26);

  if(var_98df157cbb48db26[2] > groundposition[2] + level.spydrones.idlealtitude + level.spydrones.var_b2e7d09f60c71a95 && translationoffset[2] > 0) {
    return true;
  } else if(var_98df157cbb48db26[2] < groundposition[2] + level.spydrones.idlealtitude && translationoffset[2] < 0) {
    return true;
  }

  return false;
}

function function_e6f301e018da281f() {
  self.var_50b1df2d20db660c = undefined;

  foreach(drone in self.drones) {
    if(isDefined(drone) && isDefined(drone.destination)) {
      thread move_drone(drone, drone.destination);
    }
  }
}

function spawn_drone(spawnpoint, spawnangles) {
  spawndata = spawnStruct();
  spawndata.origin = spawnpoint;
  spawndata.angles = spawnangles;
  spawndata.modelname = "veh9_mil_air_drone_spy_large_mp_02";
  spawndata.vehicletype = "veh_spy_drone_br";
  spawndata.targetname = "spy_drone";
  spawndata.cannotbesuspended = 1;
  faildata = spawnStruct();
  drone = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata, faildata);

  if(!isDefined(drone)) {
    return undefined;
  }

  drone.vehiclename = level.spydrones.vehiclename;
  drone.var_aa6fe6af4cbbdd47 = &function_b19606cac271f026;
  drone.var_51427fea41863faa = &function_a3e7d456c9513ece;
  drone.var_a56f03607bdf0735 = 1;
  drone.team = self.teams[0] + "_spy_drones";
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(drone);
  drone.health = 20;
  drone.maxhealth = 20;
  drone setCanDamage(1);
  scripts\mp\vehicles\damage::set_death_callback(drone.vehiclename, &drone_handledeathdamage);
  drone vehicle_setspeed(level.spydrones.speed, level.spydrones.accel);
  drone setmaxpitchroll(30, 30);
  drone sethoverparams(level.spydrones.hoverradius, 20, 20);
  drone setturningability(0.5);
  drone setyawspeed(level.spydrones.speed * 4, level.spydrones.accel * 4);
  drone setneargoalnotifydist(60);
  scripts\mp\weapons::function_e00b77a9cb4d8322(drone);

  if(level.spydrones.var_4e9df5e4d1c7d66f == 1) {
    drone scripts\cp_mp\emp_debuff::set_apply_emp_callback(&function_78b6097e094c44ce);

    if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
      drone[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_78b6097e094c44ce);
    }
  }

  return drone;
}

function drone_monitorcollision(drone) {
  level endon("game_ended");
  self endon("task_ended");
  drone endon("entitydeleted");

  while(true) {
    drone waittill("touch", ent);

    if(!isDefined(ent)) {
      continue;
    }

    vehicle = undefined;

    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      vehicle = ent;
    } else if(ent scripts\cp_mp\utility\player_utility::isinvehicle()) {
      vehicle = ent.vehicle;
    }

    if(!isDefined(vehicle)) {
      continue;
    }

    driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(vehicle);
    lastowner = vehicle.lastowner;

    if(!isDefined(driver)) {
      driver = lastowner;
    }

    attacker = driver;
    inflictor = vehicle;
    drone dodamage(drone.maxhealth, vehicle.origin, attacker, inflictor, "MOD_CRUSH");
  }
}

function function_87e92a820b75042a(drone) {
  level endon("game_ended");
  self endon("task_ended");
  drone endon("entitydeleted");
  drone waittill("near_goal");
  drone.goalreached = 1;

  foreach(spy in self.drones) {
    if(!istrue(spy.goalreached)) {
      return;
    }
  }

  self.var_50b1df2d20db660c = 1;
  self notify("manoeuvre_ready");
}

function move_drone(drone, destination) {
  level endon("game_ended");
  drone endon("entitydeleted");
  self endon("flee");
  delay = randomfloat(1);
  wait delay;
  drone.goalreached = undefined;
  thread function_87e92a820b75042a(drone);
  drone setvehgoalpos(destination, 1);
  drone setgoalyaw(drone.positionangle - 180);
}

function drone_drop(drone, destinationaltitude, var_911ec5f317af0665) {
  destination = (drone.origin[0], drone.origin[1], var_911ec5f317af0665 + destinationaltitude);
  thread move_drone(drone, destination);
}

function function_489eaaeafa77dbde(totalidletime) {
  level endon("game_ended");
  self endon("task_ended");
  waittime = totalidletime - 3.2;

  if(waittime > 0) {
    waittimemin = waittime * 0.33;
    waittimemax = waittime * 0.66;
  }

  delay = 0;

  foreach(drone in self.drones) {
    if(randomfloat(1) < level.spydrones.var_3ee437c870237781) {
      if(waittime > 0) {
        delay = randomfloatrange(waittimemin, waittimemax);
      }

      drone thread drone_scan(delay);
    }
  }
}

function drone_scan(delay) {
  level endon("game_ended");
  self endon("entitydeleted");
  wait delay;
  self setscriptablepartstate("scan", "on");
  wait 3.2;
  self setscriptablepartstate("scan", "off");
}

function function_537fcb1037d3612b() {
  foreach(drone in self.drones) {
    if(isDefined(drone)) {
      scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(drone);
    }
  }
}

function function_5863139a72088b70(forceexpired) {
  function_537fcb1037d3612b();
  namespace_1eb3c4e0e28fac71::displayteamsplash(self.teams[0], "br_spy_drones_quest_expired_team");

  if(istrue(forceexpired)) {
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_obj_circle_fail", self.teams[0], 1, 0, undefined, undefined);
  } else {
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam("spyd_grav_mifa", self.teams[0], 1, 0, undefined, undefined);
  }

  on_end();
}

function function_acad5b6746ae352e() {
  level endon("game_ended");
  self endon("task_ended");
  self endon("task_oob");
  contracttime = level.spydrones.contracttime > 0 ? level.spydrones.contracttime : namespace_1eb3c4e0e28fac71::function_ea591c2a379e3424(self.category);
  wait contracttime - level.spydrones.var_7e11f30ecaba3c2c;
  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("spyd_grav_retr", self.teams[0], 1, 0, undefined, undefined);
  thread function_293c5f2996b20987();
}

function function_293c5f2996b20987() {
  self notify("flee");

  foreach(drone in self.drones) {
    if(isDefined(drone)) {
      drone notify("stop_scan");
      destination = (drone.origin[0], drone.origin[1], level.spydrones.despawnaltitude + drone.origin[2]);
      drone vehicle_setspeed(level.spydrones.var_5416ef1fdf377938, level.spydrones.var_5b48dcda7b72fc1b);
      thread move_drone(drone, destination);
    }
  }
}

function function_9610fe687f77b1f() {
  foreach(drone in self.drones) {
    if(isDefined(drone)) {
      drone.destination = undefined;
    }
  }
}

function drop_items(items) {
  if(items.size > 0) {
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    dropinfo = spawnStruct();
    dropinfo.origin = self.origin;
    dropinfo.angles = self.angles;
    dropinfo.itemsdropped = 0;
    dropinfo scripts\mp\gametypes\br_lootcache::lootspawnitemlist(dropstruct, items, 0, undefined, undefined, undefined);
    return dropinfo.itemsdropped;
  }

  return 0;
}

function award_xp(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player notify("stop_spy_drone_timer");
  waitframe();

  if(!isDefined(self.combotimer)) {
    self.combotimer = [];
  }

  playerentitynumber = player getentitynumber();
  self.combotimer[playerentitynumber] = isDefined(self.combotimer[playerentitynumber]) ? self.combotimer[playerentitynumber] + 1 : 0;
  player scripts\mp\utility\points::doscoreevent(self.combotimer[playerentitynumber] > level.spydrones.comboevents.size - 1 ? level.spydrones.comboevents[level.spydrones.comboevents.size - 1] : level.spydrones.comboevents[self.combotimer[playerentitynumber]]);
  player thread start_timer(self);
}

function start_timer(contract) {
  level endon("game_ended");
  contract endon("task_ended");
  self endon("stop_spy_drone_timer");
  self endon("death_or_disconnect");
  wait level.spydrones.combotime;
  playerentitynumber = self getentitynumber();
  contract.combotimer[playerentitynumber] = undefined;
}

function function_65b4f543fd133009(position) {
  tracecontents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0);
  groundposition = scripts\engine\trace::sphere_trace(position + (0, 0, 5000), position + (0, 0, -20000), level.spydrones.var_3d741ef8d5214272 + 50 + level.spydrones.hoverradius, self.drones, tracecontents)["position"];
  waterheight = getwaterheightatlocation(groundposition);

  if(isDefined(waterheight) && groundposition[2] < waterheight) {
    groundposition = (groundposition[0], groundposition[1], waterheight);
  }

  return groundposition;
}

function function_b19606cac271f026(haywiredata) {
  level endon("game_ended");
  self endon("death");
  victim = haywiredata.victim;
  attacker = haywiredata.attacker;
  objweapon = haywiredata.objweapon;
  inflictor = haywiredata.inflictor;
  self dodamage(self.health, self.origin, attacker, inflictor, "MOD_ELEMENTAL_ELEC", objweapon);
}

function function_1b8fe45856358d18() {
  level endon("game_ended");
  self endon("task_ended");
  wait level.spydrones.inactivetime;

  if(istrue(self.var_9b08ab39d372b35d)) {
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam("spyd_grav_remi", self.teams[0], 1, 0, undefined, undefined);
  }
}

function function_78b6097e094c44ce(data) {
  self dodamage(self.health, self.origin, data.attacker, data.inflictor, "MOD_ELEMENTAL_ELEC", data.objweapon);
}

function function_a78f24ba9aac3cd5(dangercircleorigin, var_52d59c928eb97c81) {
  level endon("game_ended");
  self endon("task_ended");

  if(istrue(self.var_df2a5e89c3bba966)) {
    return;
  }

  if(!scripts\mp\gametypes\br_circle_util::ispointindangercircle(self.var_391c13efd58f5e76, level.spydrones.var_f0b6500ab0c9ccd4)) {
    if(!isDefined(self.var_ecab0c87adbf2d21)) {
      self.var_ecab0c87adbf2d21 = gettime() + function_a5b14435e3229bed(level.spydrones.var_37143a4776fd671a);
    }

    if(gettime() >= self.var_ecab0c87adbf2d21) {
      thread function_4a9600443da06ce();
      return;
    }
  }
}

function function_4a9600443da06ce() {
  level endon("game_ended");
  self endon("task_ended");
  self.var_df2a5e89c3bba966 = 1;
  self notify("task_oob");
  thread function_293c5f2996b20987();
  wait 5;
  function_5863139a72088b70(1);
}

function on_cancel(team) {
  function_5863139a72088b70(1);
}

function function_ee646c1d9d674584(contract, instance, team) {
  contract thread function_5f2cebb59cfad8f4(5);
  var_6b68ae780c4e4ebe = instance;

  if(!isDefined(var_6b68ae780c4e4ebe)) {
    var_6b68ae780c4e4ebe = function_6992f8b04542bb0f(team);
  }

  contract on_end(1, undefined, var_6b68ae780c4e4ebe);
}

function function_6992f8b04542bb0f(team) {
  validplayer = undefined;
  aliveplayers = scripts\mp\utility\teams::getteamdata(team, "alivePlayers");
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  players = array_combine_unique(aliveplayers, players);
  validplayer = function_6b8f0b7f0578b450(players);
  return validplayer;
}

function function_6b8f0b7f0578b450(player_list) {
  foreach(player in player_list) {
    if(isDefined(player)) {
      return player;
    }
  }

  return undefined;
}

function function_5f2cebb59cfad8f4(var_bd2ff1792216d885) {
  thread function_293c5f2996b20987();
  wait var_bd2ff1792216d885;
  function_537fcb1037d3612b();
}

function debug_init() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x90>");
  add_devgui_command("<dev string:xae>", "<dev string:xbb>");
  scripts\common\devgui::function_fe953f000498048f();
  scripts\engine\utility::registersharedfunc("<dev string:xf8>", "<dev string:x100>", &function_f1406ad583f64a73);
}

function function_f1406ad583f64a73(args) {
  if(args.size == 0) {
    return;
  }

  command = args[0];
  host = scripts\mp\gamelogic::gethostplayer();

  foreach(team in level.teamswithplayers) {
    if(team != host.team) {
      enemyplayer = scripts\mp\utility\teams::getteamdata(team, "<dev string:x112>")[0];
      break;
    }
  }

  switch (command) {
    case #"hash_bd35a08e196ab228":
      level thread function_b38f29311fcfe0c0(host, enemyplayer);
      break;
    case #"hash_36839a6c261ac073":
      level thread function_29dd01d8eecaab0b(host);
      break;
  }
}

function function_b38f29311fcfe0c0(host, enemyplayer) {
  hostcontract = level.contractmanager.var_b6fae9c9655c73bf[host.team];
  assert(isDefined(hostcontract), "<dev string:x12d>");

  if(hostcontract.category == "<dev string:x14a>") {
    if(isDefined(enemyplayer)) {
      foreach(drone in hostcontract.drones) {
        drone dodamage(drone.maxhealth, drone.origin, enemyplayer, undefined, "<dev string:x158>");
        wait 0.25;
      }
    }
  }
}

function function_29dd01d8eecaab0b(host) {
  hostcontract = level.contractmanager.var_b6fae9c9655c73bf[host.team];
  level endon("<dev string:x169>");
  hostcontract endon("<dev string:x177>");

  if(hostcontract.category == "<dev string:x14a>") {
    hostcontract thread function_4a9600443da06ce();
  }
}

# /