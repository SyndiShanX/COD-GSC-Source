/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_701901f066137326.gsc
*************************************************/

#using script_2047cdbf5176ba0;
#using script_208955cb4d2c8fb3;
#using script_21862d4e3ad68db8;
#using script_24fbedba9a7a1ef4;
#using script_42adcce5878f583;
#using script_5753ba9c28794a65;
#using script_743e6c2d23e7f91f;
#using script_7e41e37180e554f;
#using script_b26e8f519926066;
#using script_edb8e725d068ac9;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\throttle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\ob;
#using scripts\mp\killstreaks\remotetank;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\outofbounds;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\weapon;
#namespace namespace_28488a8b5ddf6dbc;

function autoexec main() {
  namespace_ad1f398af6f48cb1::setup_data("Maestro", "WARLORD_MAESTRO");
  namespace_ad1f398af6f48cb1::function_56e8f78ce1511d35("Maestro", &oninitialization);
  namespace_ad1f398af6f48cb1::function_dbfada6bda9049b3("Maestro", &function_325892ecd89575e1);
  scripts\engine\utility::registersharedfunc("warlords", "tile_g_warlord_registration", &function_3185a43162bd15e2);
  level.ob.warlordparameters["Maestro"].goalvolume = function_f159c10d5cf8f0b4("goalVolume", "script_noteworthy");
  var_da47572a9821e77d = function_f159c10d5cf8f0b4("goalSubVolume", "script_noteworthy");
  level.ob.warlordparameters["Maestro"].var_da47572a9821e77d = array_sort_by_script_index(var_da47572a9821e77d);

  foreach(volume in level.ob.warlordparameters["Maestro"].goalvolume) {
    if(volume.targetname == "warlord_maestro_encounter") {
      level.ob.warlordparameters["Maestro"].goalvolume = volume;
      break;
    }
  }

  registersharedfunc("warlord_maestro", "bombDeathMonitor", &function_dfda2e2f7083463b);
  level._effect["drone_turret_explode"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_lrg_dest_exp.vfx");
  level.var_86b4835c1806d690 = [];

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  level.ob.warlordparameters["Maestro"].escapepaths = [];
  level.ob.warlordparameters["Maestro"].escapepaths[0] = scripts\engine\utility::getStructArray("maestro_path_one_point", "script_noteworthy");
  level.ob.warlordparameters["Maestro"].escapepaths[1] = scripts\engine\utility::getStructArray("maestro_path_two_point", "script_noteworthy");
  level.ob.warlordparameters["Maestro"].liftpoints = scripts\engine\utility::getStructArray("maestro_lift_point", "script_noteworthy");
  level.ob.warlordparameters["Maestro"].killzones = scripts\engine\utility::getStructArray("no_drone_safety_zone", "script_noteworthy");

  if(isDefined(level.struct_class_names["script_noteworthy"]["maestro_wheelson_spawn"])) {
    level.ob.warlordparameters["Maestro"].wheelsonspawn = level.struct_class_names["script_noteworthy"]["maestro_wheelson_spawn"];
    node = level.ob.warlordparameters["Maestro"].wheelsonspawn[0];
    patrolpath = namespace_adc82618e9ef9897::function_45d2e44c40437351(node, "maestro_wheelson_path_primary", "maestro_wheelson_path_secondary");
    level.ob.warlordparameters["Maestro"].wheelsonpath = patrolpath;
    level._effect["vfx_dmz_Wheelson_flashlight"] = loadfx("vfx/iw9/level/mp_dmz_bio_lab/vfx_dmz_wheelson_spotlight.vfx");
  }

  if(isDefined(level.struct_class_names["script_noteworthy"]["maestro_drone_spawner"])) {
    level.ob.warlordparameters["Maestro"].dronespawns = level.struct_class_names["script_noteworthy"]["maestro_drone_spawner"];
    level.ob.warlordparameters["Maestro"].var_5a0e8d4bcd8ac4c2 = level.struct_class_names["script_noteworthy"]["maestro_drone_restock_path"];
    level.ob.warlordparameters["Maestro"].var_926ec82bd8dad665 = level.struct_class_names["script_noteworthy"]["maestro_drone_restocking_chokepoint"];
    level.ob.warlordparameters["Maestro"].var_784a9ecb89bdd253 = level.struct_class_names["script_noteworthy"]["maestro_drone_ephemeral_chokepoint"];
    level.ob.warlordparameters["Maestro"].var_88abc4fb2383bef5 = level.struct_class_names["script_noteworthy"]["maestro_jump_point"];
    level.ob.warlordparameters["Maestro"].var_7a60a759219496c8 = level.struct_class_names["script_noteworthy"]["maestro_land_point"];
    level.ob.warlordparameters["Maestro"].var_7a60a759219496c8 = array_sort_by_script_index(level.ob.warlordparameters["Maestro"].var_7a60a759219496c8);
    level.ob.warlordparameters["Maestro"].var_e1c44cca3778fd45 = level.struct_class_names["script_noteworthy"]["maestro_high_point"];
  }
}

function private function_3185a43162bd15e2() {
  if(!istrue(scripts\engine\utility::function_f3bb4f4911a1beb2("warlords", "warlordIsDisabled", "WARLORD_MAESTRO"))) {
    namespace_609d2ee77dae3d8c::function_447c6ab4bea16b52("objective", "REV_OB_WARLORD", &namespace_75b9b66caa533c31::function_8abadf3d8f19384a, &namespace_bb6f88126dc368e8::function_fd69cf02ba4d90a2);
  }
}

function oninitialization(agent, data) {
  warlordparameters = namespace_ad1f398af6f48cb1::function_9acf953fd6bf2e46("Maestro");
  level.ob.warlordparameters["Maestro"].requestid = agent.var_ad46aadd4e3290d7;
  function_3c85fe57dbc02e4e(agent.var_ad46aadd4e3290d7, &function_a0c7cc505f1c5675, agent);
  function_5b9ffa6991e4d730(agent.var_ad46aadd4e3290d7, &function_a2fef9d268c4b5c2, agent);
  requestdata = function_9a39e23c3c52c2af(agent.var_ad46aadd4e3290d7);
  agent.var_47e0dccd1b8b6d95 = spawn_request("ai_flood_fill_encounter:enc_ob_activity_flood_warlord_maestro", requestdata.origin, requestdata.radius, 1, 1, 0);
  function_c67c7b9e7cbf3821(agent.var_47e0dccd1b8b6d95, &function_20076ce5ca820299, agent);
  function_c6942df117004b8(agent.var_47e0dccd1b8b6d95, &function_6fe30a922ca26cb0, agent);
  function_5b9ffa6991e4d730(agent.var_47e0dccd1b8b6d95, &function_a2fef9d268c4b5c2, agent);
  agent.ob.requestreinforcements = 0;
  agent.ob.reinforcementindex = 0;
  function_79bb0c9010db500f(agent, warlordparameters);
}

function function_325892ecd89575e1(agent, data) {
  self.grenadeammo = 0;
  self.var_5323a94889eff1de = 1;

  if(agent.subclass == "ob_shielded") {
    agent.var_c833409fb72d15fb = 1;
    agent setgoalpos(agent.origin, 256);
    return;
  }

  volumes = level.ob.warlordparameters["Maestro"].var_da47572a9821e77d;

  foreach(goal in volumes) {
    if(ispointinvolume(agent.origin, goal)) {
      agent setgoalvolumeauto(goal, goal.angles);
    }
  }
}

function function_e6b424a8da46b2f0(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  outdamage = idamage;

  if(isDefined(einflictor) && isDefined(einflictor.maestrodrone)) {
    outdamage = 0;
  }

  params = level.ob.warlordparameters["Maestro"];

  if(function_961d0587afa83609(params)) {
    if(isDefined(sweapon) && is_equal(getweaponrootstring(sweapon), "blackhole_bomb")) {
      outdamage = 0;
    }
  }

  outdamage = namespace_99e3b18d3c0c359a::soldier_damage(einflictor, eattacker, outdamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
  function_6385032960fc51b1(1);

  if(isDefined(self.escaping) && self.escaping) {
    outdamage = idamage * (1 - getdvarfloat(@ "hash_cac25c7fa5bc3cc1", params.var_10822a7e7ccbd521));
  }

  return int(outdamage);
}

function function_79bb0c9010db500f(warlord, params) {
  warlord.var_5323a94889eff1de = 1;
  warlord.suppressionduration = 10;
  warlord.suppressionthreshold = 0.01;
  warlord.suppressiondecrement = 0.25;
  warlord.var_7cea08b66b2ad878 = 0;
  warlord.var_cbd87a0bc497b778 = 1;
  warlord.var_8e3405ac46c40e0f = 0;
  warlord.var_d5e499e7fe2c490b = 0;
  warlord.var_9aa77ab756fdca82 = 10000;
  warlord.var_43e2ad424676b8d4 = 1000;
  warlord.var_7562828a4ad55ff7 = 1;
  warlord.damagephase = 0;
  warlord.var_b8a5d15fbaa9387d = getdvarint(@ "hash_312502a35e1237e2", 10000);
  warlord function_f3bb4f4911a1beb2(#"emp", #"hash_a865e3770eb96298", warlord, &function_45294eab84bd3fc4);
  warlord.var_970170ffd4b081ac = &function_e6b424a8da46b2f0;
  warlord.var_d935d530a63e48ba = 0;
  warlord.var_c557ad4f44477f11 = 1;
  warlord.escaping = 0;
  warlord.escape_successful = 0;
  warlord.var_5e9eeedc4f37723b = 0;
  warlord.var_d5d75e1d5341e872 = (0, 0, 0);

  if(isDefined(params.wheelsonpath)) {
    wheelson = warlord thread wheelson_spawn(params.wheelsonpath.path[0].origin, params.wheelsonpath, undefined, undefined, undefined, undefined, warlord);
    wheelson.damagecallback = &function_168280faef14cbf8;
    wheelson.deathcallback = &function_120b1e4e62e7695c;
    wheelson.var_1e0eb63ecb3f1e2 = 1;
    wheelson.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_wheelson_healthbar");
    wheelson.var_534e788bc498be9f = getscriptbundle(%"hash_6647d2ce83e8c20a");
    wheelson.subclass = wheelson.var_534e788bc498be9f.name;
    wheelson.var_52dcdba485e7ceeb = "tag_body";
    wheelson.var_af81370570c04ca = 8;
    wheelson.var_7cfe1b189bcf3cad = getdvarint(@ "hash_8e928149711b5a66", 10);
    wheelson.var_d04bb72230a5a308 = getdvarint(@ "hash_cf673abea9981f79", 3);
  }

  warlord thread function_e39419538782659e(params);
  params.trackers.wheelsons[params.trackers.wheelsons.size] = wheelson;
  warlord.callbackdamaged = &function_fea10e99d08599d7;
  triggers = function_f159c10d5cf8f0b4("reinforcement_trigger", "targetname");

  foreach(trigger in triggers) {
    trigger thread function_4b8b0afabc972cf8(warlord);
  }

  warlord.alreadydroppedweapon = 1;
}

function private function_961d0587afa83609(params) {
  if(isDefined(params.trackers.var_647a70845738f8bc)) {
    foreach(drone in params.trackers.var_647a70845738f8bc) {
      var_65d5104e6f0ea258 = istrue(drone.vehicle_drone) && isDefined(drone.behavior) && drone.behavior == "protect";

      if(var_65d5104e6f0ea258 && istrue(drone.var_2a6024dda5bc8738)) {
        return true;
      }
    }
  }

  return false;
}

function private function_99fedeb298e8b70(params, damagephase) {
  var_74e97d68ac1bdeb5 = getdvarint(@ "hash_4d77d6ac9d9d5dbc", default_to(params.var_59eca32f21910808, 7));
  var_e281e480d5e23a85 = getdvarint(@ "hash_4fcee75eefec8505", default_to(params.var_50ca1e6d9f2ca345, 2));
  phasemult = default_to(damagephase, 0);
  return var_74e97d68ac1bdeb5 + phasemult * var_e281e480d5e23a85;
}

function private function_c4a3b2f8fe65e727(params, damagephase) {
  var_74e97d68ac1bdeb5 = getdvarint(@ "hash_86078143dd7cb314", default_to(params.var_affa9b1c7dd6d033, 2));
  var_e281e480d5e23a85 = getdvarint(@ "hash_c3935eeeece426cb", default_to(params.var_be95333ad2001a2f, 1));
  phasemult = default_to(damagephase, 0);
  return var_74e97d68ac1bdeb5 + phasemult * var_e281e480d5e23a85;
}

function private function_e39419538782659e(params) {
  self endon("death");
  params.trackers = spawnStruct();
  params.trackers.var_647a70845738f8bc = [];
  params.trackers.wheelsons = [];
  params.trackers.var_3aef66aa7812fab4 = [];
  params.trackers.var_dd72808b849e4d52 = [];
  params.trackers.var_d5dc746b4c149b00 = [];
  params.trackers.var_f6b4651f19aa358 = 0;
  params.trackers.var_dffa579e39f9bdd5 = 0;
  params.trackers.var_47ed3bc2d55c6fce = 0;
  params.trackers.var_d220d4746b1774d5 = 0;
  params.trackers.var_d6f06f378d054276 = 0;
  params.trackers.deployinprogress = 0;

  thread function_289bc4e107d9c7e1(params);

  thread function_1d511f730cc98a07(params);
  thread function_62883a99c01a4108(params);
  thread function_5bb38d64c886e080(params);

  while(!self.bisincombat) {
    wait 2;
  }

  volume = level.ob.warlordparameters["Maestro"].var_da47572a9821e77d[4];
  self setgoalvolumeauto(volume);
  thread function_4f3833106786643e(params);
  level thread function_7dbd5a71beaa0999(self, params.trackers);
}

function private function_5bb38d64c886e080(params) {
  self endon("death");
  level endon("game_ended");
  hasapproached = 0;

  while(true) {
    if(self.ob.instancedata.var_6c29f2fdb0054bbe.size > 0) {
      foreach(player in self.ob.instancedata.var_6c29f2fdb0054bbe) {
        if(isinlaststand(player) || istrue(player.notarget) || istrue(player.ignoreme)) {
          continue;
        }

        if(distance2d(player.origin, self.origin) < getdvarint(@ "hash_b7d76b505ece49e4", 4500) && abs(player.origin[2] - self.origin[2]) < getdvarint(@ "hash_21f5a00d1f82e4cc", 1000)) {
          if(!istrue(hasapproached)) {
            foreach(var_53a758d6af3aa4af in params.trackers.var_d5dc746b4c149b00) {
              foreach(drone in var_53a758d6af3aa4af) {
                if(!istrue(drone.isephemeral)) {
                  drone drone_die(1, drone.var_1a00611a25c12747);
                }
              }
            }

            self notify("end_patrolling_drones");
            hasapproached = 1;
          }

          if(isent(player) && isalive(player) && !isinlaststand(player)) {
            player scripts\mp\gametypes\ob::function_6109bfd0330e0b8f("warlord_maestro", 1);
          }

          continue;
        }

        if(isent(player) && isalive(player) && !isinlaststand(player)) {
          player scripts\mp\gametypes\ob::function_6109bfd0330e0b8f("warlord_maestro", 0);
        }
      }
    }

    wait 1;
  }
}

function private function_289bc4e107d9c7e1(params) {
  self endon("death");
  childthread function_fd5be33a0fc04ec4();
  setdvarifuninitialized(@ "hash_584aaa9da0bcc0d", 0);
  setdvarifuninitialized(@ "hash_8da2e3f75d2bf514", 0);
  setdvarifuninitialized(@ "hash_dc1dd1f827d551d3", 0);
  setdvarifuninitialized(@ "hash_663fcb5399f02f8b", 0);
  setdvarifuninitialized(@ "hash_1a7bfc56667f5bae", 0);
  childthread function_404b2f21d0e54fb1();
  childthread function_76b01f56cccfc5ec(params);
  childthread function_da32a56c837da15a();
}

function private function_fd5be33a0fc04ec4() {
  params = level.ob.warlordparameters["<dev string:x1c>"];
  var_272a4532c1306b5b = ["<dev string:x27>", "<dev string:x3e>", "<dev string:x5c>"];

  while(true) {
    x = 320;
    y = 80;

    if(isDefined(params.trackers.var_647a70845738f8bc) && function_99fedeb298e8b70(params, self.damagephase) > 0) {
      printtoscreen2d(x, y, "<dev string:x68>" + string(params.trackers.var_647a70845738f8bc.size) + "<dev string:x7f>" + string(function_99fedeb298e8b70(params, self.damagephase)));
      y += 18;
    }

    if(isDefined(params.trackers.var_dffa579e39f9bdd5)) {
      curtime = gettime();
      curcooldown = clamp(params.trackers.var_dffa579e39f9bdd5 - curtime, 0, (params.var_db9991611a26b0c1 - params.var_cfc9c46afa203cf6 * self.damagephase) * 1000);
      printtoscreen2d(x, y, "<dev string:x84>" + string(curcooldown));
      y += 18;
    }

    if(isDefined(params.trackers.var_dd72808b849e4d52)) {
      printtoscreen2d(x, y, "<dev string:xb0>" + string(params.trackers.var_dd72808b849e4d52.size));
      y += 18;
    }

    if(isDefined(params.trackers.var_f6b4651f19aa358)) {
      printtoscreen2d(x, y, "<dev string:xc9>" + string(params.trackers.var_f6b4651f19aa358));
      y += 18;
    }

    if(isDefined(params.trackers.var_dffa579e39f9bdd5)) {
      var_f52279cebc2d0ac = max(params.trackers.var_47ed3bc2d55c6fce - gettime(), 0);
      printtoscreen2d(x, y, "<dev string:xf5>" + string(var_f52279cebc2d0ac));
      y += 18;
    }

    if(isDefined(params.trackers.var_d220d4746b1774d5)) {
      var_c311379b07d1700a = max(params.trackers.var_d220d4746b1774d5 - gettime(), 0);
      printtoscreen2d(x, y, "<dev string:x127>" + string(var_c311379b07d1700a));
      y += 18;
    }

    if(isDefined(self.scriptgoalpos)) {
      printtoscreen2d(x, y, "<dev string:x164>" + string(self.scriptgoalpos));
      y += 18;
    }

    if(isDefined(self.player_engaged)) {
      printtoscreen2d(x, y, "<dev string:x179>" + string(self.player_engaged));
      y += 18;
    }

    if(isDefined(self.damagephase)) {
      printtoscreen2d(x, y, "<dev string:x192>" + string(self.damagephase));
      y += 18;
    }

    if(isDefined(self.escaping)) {
      printtoscreen2d(x, y, "<dev string:x1ab>" + string(self.escaping));
      y += 18;
    }

    if(isDefined(self.reinforcementindex) && isDefined(self.requestreinforcements)) {
      printtoscreen2d(x, y, "<dev string:x1bc>" + string(self.reinforcementindex) + "<dev string:x1ee>" + string(self.requestreinforcements));
      y += 18;
    }

    waitframe();
  }
}

function function_da32a56c837da15a() {
  volumes = level.ob.warlordparameters["Maestro"].var_da47572a9821e77d;

  while(true) {
    if(getdvarint(@ "hash_dc1dd1f827d551d3", 0)) {
      foreach(volume in volumes) {
        sphere(volume.origin, 128, (160, 25, 120));

        if(isDefined(volume.script_index)) {
          print3d(volume.origin + (0, 0, 90), string(volume.script_index), (160, 25, 120), 1, 3);
        }
      }
    }

    waitframe();
  }
}

function private function_45294eab84bd3fc4(data) {
  if(!isDefined(self)) {
    return;
  }

  params = namespace_ad1f398af6f48cb1::function_9acf953fd6bf2e46("Maestro");
  params.trackers.var_d6f06f378d054276 = gettime();
}

function function_ecc8e68beaa407af(params) {
  self endon("death");

  while(true) {
    if(self.var_5e9eeedc4f37723b == -1) {
      wait 1.5;
      contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 0, 1);
      ignore = [self];

      for(i = 0; i < params.trackers.var_647a70845738f8bc.size; i++) {
        ignore[ignore.size] = params.trackers.var_647a70845738f8bc[i];
        ignore[ignore.size] = params.trackers.var_647a70845738f8bc[i].clip;
      }

      for(i = 0; i < params.trackers.var_dd72808b849e4d52.size; i++) {
        ignore[ignore.size] = params.trackers.var_dd72808b849e4d52[i];
      }

      tracepoints = [(-70, 0, 0), (70, 0, 0), (0, -70, 0), (0, 70, 0), (50, 50, 0), (50, -50, 0), (-50, -50, 0), (-50, 50, 0)];
      var_2f9e9febf2f3ad33 = [(-33, 0, 0), (33, 0, 0), (0, -33, 0), (0, 33, 0), (33, 33, 0), (33, -33, 0), (-33, -33, 0), (-33, 33, 0)];
      var_64c95698ed1716f5 = [(0, 10, 10), (0, -10, 10), (-10, 0, 10), (10, 0, 10), (7, -7, 10), (-7, -7, 10), (-7, 7, 10), (7, 7, 0)];
      tracepassed = [0, 0, 0, 0, 0, 0, 0, 0];
      var_6a9c098959579f9 = 0;

      for(i = 0; i < tracepoints.size; i++) {
        var_65a2111dc1e5790c = scripts\engine\trace::ray_trace_passed(self.origin + (0, 0, 35), self.origin + (0, 0, 35) + tracepoints[i], ignore, contents);

        if(var_65a2111dc1e5790c) {
          tracepassed[i] = var_65a2111dc1e5790c;
          var_6a9c098959579f9++;
        }
      }

      if(var_6a9c098959579f9 == 0 || var_6a9c098959579f9 == 8) {
        self.var_5e9eeedc4f37723b = 0;
        self.var_d5d75e1d5341e872 = (0, 0, 0);
      } else {
        self.var_5e9eeedc4f37723b = var_6a9c098959579f9;
        self.var_8a8bfb7e19f13a33 = [];
        self.var_b8914dd33e1c911d = [];

        for(i = 0; i < tracepoints.size; i++) {
          if(tracepassed[i]) {
            self.var_8a8bfb7e19f13a33[self.var_8a8bfb7e19f13a33.size] = var_2f9e9febf2f3ad33[i] + (0, 0, 45);
            self.var_b8914dd33e1c911d[self.var_b8914dd33e1c911d.size] = var_64c95698ed1716f5[i];
          }
        }
      }
    }

    waitframe();
  }
}

function function_53c7f9e18848bc61(targetpos, priority) {
  self endon("death");
  self endon("cancel_reposition");

  if(priority > self.var_d935d530a63e48ba) {
    self.var_5e9eeedc4f37723b = 0;
    self.var_d935d530a63e48ba = priority;
    self setgoalpos(self getclosestreachablepointonnavmesh(targetpos), 32);
    self waittill("goal");

    if(isDefined(self) && priority == self.var_d935d530a63e48ba) {
      if(priority >= 2) {
        self.escape_successful = 1;
        self notify("reposition_complete");
      }

      self.var_d935d530a63e48ba = 0;
      self.var_5e9eeedc4f37723b = -1;
    }
  }
}

function function_b74a844cdfa3d876(escapepoint, ignorelist) {
  contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 0, 1);

  if(false) {
    var_6c28ac76727d0025 = 12;
    tracestart = self.origin + (0, 0, 12);

    if(getdvarint(@ "hash_1a7bfc56667f5bae", 0)) {
      sphere(tracestart, var_6c28ac76727d0025, game["<dev string:x1f5>"]["<dev string:x1ff>"], 0, 240);
      sphere(escapepoint, var_6c28ac76727d0025, game["<dev string:x1f5>"]["<dev string:x1ff>"], 0, 240);
      line(tracestart, escapepoint, game["<dev string:x1f5>"]["<dev string:x1ff>"], 1, 0, 240);
    }

    return sphere_trace_passed(tracestart, escapepoint, var_6c28ac76727d0025, ignorelist, contents);
  }

  var_fa92b761401c0d98 = [];
  warlordforward = anglesToForward(self.angles);
  warlordforward = vectorNormalize(warlordforward);
  numtraces = 1;
  var_88b83b0d7a43ea72 = 360 / numtraces;

  for(i = 0; i < numtraces; i++) {
    var_fa92b761401c0d98[i] = self.origin + warlordforward * 6;
    warlordforward = rotatevector(warlordforward, (0, var_88b83b0d7a43ea72, 0));
  }

  foreach(raytraceposition in var_fa92b761401c0d98) {
    if(getdvarint(@ "hash_1a7bfc56667f5bae", 0)) {
      sphere(raytraceposition, 2, game["<dev string:x1f5>"]["<dev string:x1ff>"], 0, 240);
      line(raytraceposition, escapepoint, game["<dev string:x1f5>"]["<dev string:x1ff>"], 1, 0, 240);
    }

    if(!scripts\engine\trace::ray_trace_passed(raytraceposition, escapepoint, ignorelist, contents)) {
      return 0;
    }
  }

  return 1;
}

function maestro_escape(index, params) {
  self endon("death");
  self endon("maestro_escape_forced_end");

  if(istrue(self.neverescape)) {
    return;
  }

  if(!istrue(self.escaping)) {
    if(!isDefined(self.escapetime)) {
      self.escapetime = 1;
    } else {
      self.escapetime += 1;
    }

    escapepoints = level.ob.warlordparameters["Maestro"].escapepaths[self.escapetime - 1];
    liftpoints = level.ob.warlordparameters["Maestro"].liftpoints;
    targetstruct = level.ob.warlordparameters["Maestro"].var_7a60a759219496c8[index];
    targetpos = targetstruct.origin;
    self.escaping = 1;
    self.exitcap = 0;
    self.var_c557ad4f44477f11 = 0;
    self.var_f89e16252aec0396 = 1;
    scripts\common\cap::cap_start("cap_maestro_drone_escape", "caps/maestro/cap_maestro_escape");

    while(self.asmname != "cap_maestro_drone_escape" && !self function_e3dadb2823f1da8a(self.asmname)) {
      waitframe();
    }

    dronelift = spawn("script_model", self gettagorigin("TAG_ACCESSORY_LEFT"));
    dronelift setModel("misc_vm_pers_redeploy_drone_ob");
    dronelift setscriptablepartstate("maestro_prd", "deploy_start", 0);
    dronelift.angles = (0, self.angles[1], 0);
    dronelift linkTo(self, "TAG_ACCESSORY_LEFT");
    self.var_d1e81d5b45120e8d = dronelift;

    while(!istrue(self asmeventfired(self.asmname, "linkdrone"))) {
      waitframe();
    }

    headloc = self gettagorigin("j_head");
    drone = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(undefined, headloc, self.angles, "veh_maestro_bomb_drone_ob", "veh8_mil_air_tuniform_c4_ob");
    drone.owner = self;
    drone.team = "team_hundred_ninety_five";
    drone.health = 999999;
    drone vehicle_setspeedimmediate(20, 200, 200);
    drone vehicleshowonminimap(0);
    drone hide();
    self.var_2cc3a24d5bdf4a35 = drone;
    headoffset = self.origin - headloc;
    droneoffset = drone.origin - drone gettagorigin("j_body");
    self linktomoveoffset(drone, "j_body", headoffset + droneoffset, (0, 0, 0));
    self playerlinkedoffsetenable();
    self fixlinktointerpolationbug(1);

    while(!istrue(self asmeventfired(self.asmname, "mount_finished"))) {
      waitframe();
    }

    self.isflying = 1;
    thread namespace_dc53a27a8db8e6bf::function_29b3cd72300804be();
    dronelift setscriptablepartstate("maestro_prd", "move_loop", 0);
    forward = anglesToForward(self.angles);
    var_9e9d8f097b724a11 = vectornormalize2(forward);
    ignore = [self, dronelift, drone];

    for(i = 0; i < params.trackers.var_647a70845738f8bc.size; i++) {
      ignore[ignore.size] = params.trackers.var_647a70845738f8bc[i];
      ignore[ignore.size] = params.trackers.var_647a70845738f8bc[i].clip;
    }

    for(i = 0; i < params.trackers.var_dd72808b849e4d52.size; i++) {
      ignore[ignore.size] = params.trackers.var_dd72808b849e4d52[i];
    }

    tracestart = self.origin;
    traceend = self.origin + (0, 0, 200);
    contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 0, 1);
    firstgoal = scripts\engine\trace::ray_trace(tracestart, traceend, ignore, contents)["position"];
    firstgoal += (0, 0, -12);

    if(getdvarint(@ "hash_1a7bfc56667f5bae", 0)) {
      sphere(tracestart, 2, game["<dev string:x1f5>"]["<dev string:x1ff>"], 0, 240);
      sphere(traceend, 2, game["<dev string:x1f5>"]["<dev string:x1ff>"], 0, 240);
      line(tracestart, traceend, game["<dev string:x1f5>"]["<dev string:x1ff>"], 1, 0, 240);
      sphere(firstgoal, 2, game["<dev string:x1f5>"]["<dev string:x208>"], 0, 240);
    }

    drone setvehgoalpos(firstgoal, 1);

    while(distancesquared(drone.origin, firstgoal) > 625) {
      waitframe();
    }

    var_9224baea88b1a44b = 0;

    foreach(point in escapepoints) {
      if(point.targetname == "start") {
        startpoint = point;
        break;
      }
    }

    if(isDefined(startpoint) && function_b74a844cdfa3d876(startpoint.origin, ignore)) {
      var_9224baea88b1a44b = 1;
      drone function_6c6b4c655a108706(escapepoints);
    } else {
      var_4f53baa7aedac49b = [];

      foreach(liftpoint in liftpoints) {
        if(function_b74a844cdfa3d876(liftpoint.origin, ignore)) {
          var_4f53baa7aedac49b[var_4f53baa7aedac49b.size] = liftpoint;
        }
      }

      if(var_4f53baa7aedac49b.size > 0) {
        mindist = 9999;
        var_71e5df71ee48dee8 = undefined;

        foreach(liftpoint in var_4f53baa7aedac49b) {
          disttopoint = distance2d(liftpoint.origin, self.origin);

          if(disttopoint < mindist) {
            mindist = disttopoint;
            var_71e5df71ee48dee8 = liftpoint;
          }
        }

        if(isDefined(var_71e5df71ee48dee8)) {
          var_9224baea88b1a44b = 1;
          drone function_6c6b4c655a108706(escapepoints, var_71e5df71ee48dee8);
        }
      }
    }

    if(!istrue(var_9224baea88b1a44b)) {
      self.escapetime--;
    }

    self unlink();
    dronelift unlink();
    dronelift childthread function_df749830a4e50701();
    self.exitcap = 1;
    self.var_c557ad4f44477f11 = 1;
    self.var_f89e16252aec0396 = 0;
    self.isflying = 0;
    self.var_d1e81d5b45120e8d = undefined;
    self.var_2cc3a24d5bdf4a35 = undefined;

    if(index == 0) {
      volume = level.ob.warlordparameters["Maestro"].var_da47572a9821e77d[2];
      self setgoalvolumeauto(volume);
    } else if(index == 1) {
      volume = level.ob.warlordparameters["Maestro"].var_da47572a9821e77d[0];
      self setgoalvolumeauto(volume);
    }

    drone thread function_a4c9f0c88ae3d01e();
    self.var_d935d530a63e48ba = 0;
    self.escaping = 0;
  }
}

function function_c804500b8ed30f0b() {
  self.neverescape = 1;
  self notify("maestro_escape_forced_end");
  self unlink();
  self.var_d935d530a63e48ba = 0;
  self.escaping = 0;

  if(isDefined(self.var_d1e81d5b45120e8d)) {
    self.var_d1e81d5b45120e8d unlink();
    self.var_d1e81d5b45120e8d function_df749830a4e50701();
    self.exitcap = 1;
    self.isflying = 0;
    self.var_d1e81d5b45120e8d = undefined;
  }

  if(isDefined(self.var_2cc3a24d5bdf4a35)) {
    self.var_2cc3a24d5bdf4a35 function_a4c9f0c88ae3d01e();
  }
}

function function_6c6b4c655a108706(path, liftpoint) {
  if(isDefined(liftpoint)) {
    self setvehgoalpos(liftpoint.origin, 0);
    lookangle = vectortoangles(liftpoint.origin - self.origin);
    self settargetyaw(lookangle[1]);
    self setyawspeed(400, 300, 270, 0.3);

    while(distancesquared(self.origin, liftpoint.origin) > 625) {
      waitframe();
    }
  }

  lookangle = vectortoangles(path[0].origin - self.origin);
  self settargetyaw(lookangle[1]);
  self setyawspeed(150, 150, 130, 0.3);

  for(pointindex = 0; pointindex < path.size; pointindex++) {
    point = path[pointindex];

    if(pointindex == path.size - 1) {
      self setvehgoalpos(point.origin, 1);
    } else {
      self setvehgoalpos(point.origin, 0);
    }

    setdesiredyaw = 0;

    while(distancesquared(self.origin, point.origin) > 625) {
      if(pointindex < path.size - 1 && distancesquared(self.origin, point.origin) <= 40000 && !setdesiredyaw) {
        setdesiredyaw = 1;
        lookangle = vectortoangles(path[pointindex + 1].origin - path[pointindex].origin);
        self settargetyaw(lookangle[1]);
      }

      waitframe();
    }
  }
}

function function_df749830a4e50701() {
  self setscriptablepartstate("maestro_prd", "deploy_end", 0);
  wait 1;
  self notify("death");

  if(isDefined(self)) {
    self delete();
  }
}

function function_a4c9f0c88ae3d01e() {
  self setscriptablepartstate("Spawn_Reveal", "Reveal_Off", 0);
  wait 6;
  self delete();
}

function function_fea10e99d08599d7(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  params = level.ob.warlordparameters["Maestro"];

  if(self.damagephase == 0 && self.armorhealth <= self.maxarmorhealth * 0.9 && self.ob.reinforcementindex < 2) {
    self.ob.requestreinforcements = 1;
    self.ob.reinforcementindex = 2;
  }

  if(self.damagephase == 0 && (self.armorhealth <= self.maxarmorhealth * 0.5 || self.helmethealth <= self.var_cfc69e5588a5bed6 * 0.75 || self.health < self.maxhealth)) {
    self.var_5a856697dd2dab5c = gettime() + self.var_b8a5d15fbaa9387d;
    thread maestro_escape(self.damagephase, params);
    self.damagephase = 1;
  }

  if(self.damagephase == 1 && self.armorhealth <= self.maxarmorhealth * 0.4 && !self.ob.requestreinforcements && self.ob.reinforcementindex < 3) {
    self.ob.requestreinforcements = 1;
    self.ob.reinforcementindex = 3;
  }

  if(self.damagephase == 1 && (self.armorhealth <= 0 || self.helmethealth <= self.var_cfc69e5588a5bed6 * 0.45 || self.health < self.maxhealth * 0.7 && self.health > self.maxhealth * 0.2)) {
    self.var_5a856697dd2dab5c = gettime() + self.var_b8a5d15fbaa9387d;
    thread maestro_escape(self.damagephase, params);
    self.damagephase = 2;
  }

  params.trackers.var_dffa579e39f9bdd5 = gettime() + (params.var_db9991611a26b0c1 - params.var_cfc9c46afa203cf6 * self.damagephase) * 1000;

  if(!istrue(self.var_f89e16252aec0396)) {
    params.trackers.deployinprogress = 0;
  }

  idamage = namespace_ad1f398af6f48cb1::function_395c3a00db83ba6(idamage, smeansofdeath, objweapon);
  headshot = scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, eattacker);
  potentialhealth = self.health;

  if(istrue(headshot)) {
    if(self.helmethealth <= 0) {
      potentialhealth = self.health - idamage;
    }
  } else if(self.armorhealth <= 0) {
    potentialhealth = self.health - idamage;
  }

  if(potentialhealth < self.maxhealth * 0.05 && istrue(self.escaping)) {
    function_c804500b8ed30f0b();
  }

  namespace_daa149ca485fd50a::function_dffac413ed66bcd0(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

function function_35a2d548eaf273dd(point, params, var_a4ca108d5180304, var_4c12c9b285fba0f5) {
  startpos = point;
  startang = (0, 0, 0);
  vehicleinfo = "veh_maestro_bomb_drone_ob";

  if(var_a4ca108d5180304) {
    drone = spawnVehicle("veh8_mil_air_tuniform_c4_ob", "drone_turret", vehicleinfo, startpos, startang);
    drone setvehicleteam(self.team);
  } else {
    drone = spawn("script_model", startpos);
    drone setModel("veh8_mil_air_tuniform_c4_ob");
  }

  drone_team = "team_hundred_ninety_five";

  if(isDefined(self)) {
    drone.owner = self;
    drone_team = self.team;
  }

  drone.var_52dcdba485e7ceeb = "j_body";
  drone.team = drone_team;
  drone.death_queued = 0;
  drone.var_2a6024dda5bc8738 = 0;
  drone.maxspeed = float(params.dronespeed);
  drone.divedist = params.var_a7cdb2a8ec572747;
  drone.sightdistance = params.dronesightdistance;
  drone.exploding = 0;
  drone.var_176f2563dbfd1669 = params.var_176f2563dbfd1669;
  drone.forcestop = 0;
  drone.health = 999999;
  drone.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_bombdrone_healthbar");
  drone.var_534e788bc498be9f = getscriptbundle(%"hash_781de85130f2625a");
  drone.subclass = drone.var_534e788bc498be9f.name;
  drone.var_1e0eb63ecb3f1e2 = 1;
  drone.var_4919d15787f01154 = 1;
  drone.max_fake_health = params.dronehealth;
  drone.fake_health = params.dronehealth;
  drone.maestrodrone = 1;
  drone.killzones = params.killzones;
  drone thread drone_damagewatcher(params);
  drone setCanDamage(1);
  drone enableaimassist();
  drone.var_aa6fe6af4cbbdd47 = &function_aeaae75fa8cfd4cb;
  drone setscriptabledamageowner(drone.owner);
  drone utility::function_3ab9164ef76940fd("Spawn_Reveal", "Spawn_Reveal");

  if(var_a4ca108d5180304) {
    level.var_86b4835c1806d690[level.var_86b4835c1806d690.size] = drone;
    drone.repath_now = 0;
    drone.vehicle_drone = 1;
    drone thread function_19477228c9b4907b();
    drone thread function_2395aa8d473eb61f();

    if(var_4c12c9b285fba0f5) {
      drone.behavior = "idle";
      drone setscriptablepartstate("lights", "chase", 0);
    } else {
      drone.behavior = "protect";

      for(var_578509d14431fd20 = 0; var_578509d14431fd20 < function_99fedeb298e8b70(params, 0); var_578509d14431fd20++) {
        var_cffb6eae3fe146bb = 1;

        foreach(activedrone in params.trackers.var_647a70845738f8bc) {
          if(isDefined(activedrone.protectindex) && activedrone.protectindex == var_578509d14431fd20) {
            var_cffb6eae3fe146bb = 0;
            break;
          }
        }

        if(var_cffb6eae3fe146bb == 1) {
          drone.protectindex = var_578509d14431fd20;
          break;
        }
      }

      params.trackers.var_647a70845738f8bc[params.trackers.var_647a70845738f8bc.size] = drone;
    }

    drone thread function_dfda2e2f7083463b(params);
    drone vehicle_breakglass(1);
    drone thread function_9d8b7e5c2ee17132(params);
  } else {
    drone.vehicle_drone = 0;
    drone thread function_d2eaa684b4981192(params);
    drone setscriptablepartstate("lights", "chase", 0);
    drone setscriptablepartstate("engine_sound", "low", 0);
  }

  drone thread function_31bd1c2dc85b7b5c();
  drone thread drone_watchfordeath();
  drone thread function_3e42dda71c258e8a();
  drone function_f3bb4f4911a1beb2(#"emp", #"hash_a865e3770eb96298", drone, &function_7c3b5beb399db271);
  return drone;
}

function function_aeaae75fa8cfd4cb(var_91beb5c3a5ab6910) {
  level endon("game_ended");
  self endon("death");
  victim = var_91beb5c3a5ab6910.victim;
  attacker = var_91beb5c3a5ab6910.attacker;
  objweapon = var_91beb5c3a5ab6910.objweapon;
  inflictor = var_91beb5c3a5ab6910.inflictor;

  if(isstruct(inflictor)) {
    inflictor = attacker;
  }

  if(self.fake_health > 0) {
    if(!isDefined(level.var_7402bdfcb0d55974)) {
      level.var_7402bdfcb0d55974 = throttle_initialize("shockStick_haywireDrone", 1, level.framedurationseconds);
    }

    self.ishaywire = 1;
    function_f632348cbb773537(level.var_7402bdfcb0d55974, self);
    self dodamage(getdvarint(@ "hash_ab6ef41d9efbecdf", 15), self.origin, attacker, inflictor, "MOD_ELEMENTAL_ELEC", objweapon, self.var_52dcdba485e7ceeb);
    self notify("drop_shield");

    if(self.fake_health <= getdvarint(@ "hash_b70124ef26c0ca73", 0.25) * self.max_fake_health) {
      drone_bombexplode();
    }
  }
}

function function_2395aa8d473eb61f() {
  self endon("death");

  while(true) {
    foreach(player in level.players) {
      showonminimap = 0;
      distancesqtoplayer = distancesquared(self.origin, player.origin);

      if(distancesqtoplayer <= squared(10000)) {
        heightdifference = abs(self.origin[2] - player.origin[2]);

        if(heightdifference <= 500) {
          showonminimap = 1;
        }
      }

      self vehicleshowonminimapforclient(player, showonminimap);
    }

    wait 2;
  }
}

function function_19d48dfe8f3cbc84(shield_on, drone, params) {
  drone notify("brush_swap");

  if(shield_on) {
    drone.var_2a6024dda5bc8738 = 1;

    if(isDefined(drone.clip)) {
      drone.clip notify("death");
      drone.clip delete();
    }

    brushmodel = getEnt("shield_drone_clip", "targetname");
    drone.clip = spawn("script_model", brushmodel.origin);
    drone.clip.angles = brushmodel.angles;
    drone.clip clonebrushmodeltoscriptmodel(brushmodel);
    drone.clip.origin = drone.origin;
    drone.clip.angles = drone.angles;
    drone.clip.parent = drone;
    drone.clip linkTo(drone, "j_body");
    drone.clip enableaimassist();
    drone.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_bombdrone_healthbar");
    drone.var_534e788bc498be9f = getscriptbundle(%"hash_781de85130f2625a");
    drone.subclass = drone.var_534e788bc498be9f.name;
    drone.clip.health = 999999;
    drone.clip.var_1e0eb63ecb3f1e2 = 1;
    drone.clip.var_4919d15787f01154 = 1;
    drone.clip.max_fake_health = drone.max_fake_health;
    drone.clip.fake_health = drone.fake_health;
    drone.clip setCanDamage(1);
    drone thread function_bd97b7f184ae69b2(params);
    return;
  }

  if(isDefined(drone.clip)) {
    drone.clip notify("death");
    drone.clip delete();
  }

  drone.var_2a6024dda5bc8738 = 0;
}

function drone_remove() {
  level.var_86b4835c1806d690 = array_remove(level.var_86b4835c1806d690, self);
  self notify("death");

  if(isDefined(self.dangericonent)) {
    self.dangericonent delete();
  }

  if(isDefined(self.clip)) {
    self.clip notify("death");
    self.clip delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

function drone_die(exploded, var_1a00611a25c12747) {
  if(isDefined(self) && !istrue(self.death_queued)) {
    self.death_queued = 1;

    if(exploded == 0) {
      playFX(getfx("drone_turret_explode"), self.origin);
      self playSound("jup_maestro_drone_destroyed");
    }

    if(!istrue(var_1a00611a25c12747)) {
      level.var_86b4835c1806d690 = array_remove(level.var_86b4835c1806d690, self);
    }

    if(isDefined(self.dangericonent)) {
      self.dangericonent delete();
    }

    waitframe();
    self notify("death");

    if(isDefined(self.clip)) {
      self.clip notify("death");
      self.clip delete();
    }

    if(isDefined(self)) {
      self delete();
    }
  }
}

function drone_bombexplode() {
  self.exploding = 1;

  if(self.vehicle_drone == 1) {
    self.forcestop = 1;
    self.repath_now = 1;
    self setscriptablepartstate("lights", "chase", 0);
    self vehicle_setspeedimmediate(0, 15, 15);
  } else {
    self moveTo(self.origin, 0.1);
  }

  wait self.var_176f2563dbfd1669;

  if(getdvarint(@ "hash_663fcb5399f02f8b", 0)) {
    sphere(self.origin, 50, (1, 0, 1), 0, 120);
  }

  if(isDefined(self)) {
    self setscriptablepartstate("explode", "on", 0);

    if(isDefined(self.dangericonent)) {
      self.dangericonent delete();
    }

    thread drone_die(1, istrue(self.var_1a00611a25c12747));
  }
}

function function_7c3b5beb399db271(data) {
  if(isDefined(self)) {
    thread drone_die(0, istrue(self.var_1a00611a25c12747));
  }
}

function function_3e42dda71c258e8a() {
  self endon("death");
  self waittill("shockStick_haywireApplied");

  if(isDefined(self)) {
    self notify("drop_shield");
  }
}

function function_31bd1c2dc85b7b5c() {
  self endon("death");

  while(true) {
    self waittill("pause_move");
    self.var_75a825774aafb097 = 1;
    self vehicle_setspeedimmediate(0, 15, 15);
    wait 0.5;
    self.var_75a825774aafb097 = 0;
    self vehicle_setspeed(self.maxspeed, self.maxspeed);
  }
}

function drone_canseetarget(target, offset) {
  icansee = 0;
  contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);
  ignore = [];

  if(isent(self)) {
    ignore[ignore.size] = self;
  }

  tracepoints = [];

  if(isPlayer(target)) {
    tracepoints = [target gettagorigin("j_head"), target gettagorigin("j_mainroot"), target gettagorigin("tag_origin")];
    vehicleent = target scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(vehicleent)) {
      ignore[ignore.size] = vehicleent;
    }

    if(istrue(target.disguised)) {
      ignore[ignore.size] = target;
    }
  } else {
    tracepoints[tracepoints.size] = target.origin + (0, 0, 35);
  }

  for(i = 0; i < tracepoints.size; i++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin + offset, tracepoints[i], ignore, contents)) {
      continue;
    }

    icansee = 1;
    break;
  }

  return icansee;
}

function function_7dbd5a71beaa0999(maestro, trackers) {
  maestro waittill("death");

  if(isDefined(trackers.var_647a70845738f8bc)) {
    foreach(drone in trackers.var_647a70845738f8bc) {
      drone thread drone_die(0);
    }

    trackers.var_647a70845738f8bc = [];
  }

  if(isDefined(trackers.var_dd72808b849e4d52)) {
    foreach(drone in trackers.var_dd72808b849e4d52) {
      drone thread drone_die(0);
    }

    trackers.var_dd72808b849e4d52 = [];
  }

  if(isDefined(trackers.var_d5dc746b4c149b00)) {
    foreach(chokepoint in trackers.var_d5dc746b4c149b00) {
      foreach(drone in chokepoint) {
        if(isDefined(drone)) {
          drone thread drone_die(0);
        }
      }

      chokepoint = [];
    }
  }

  if(isDefined(trackers.var_3aef66aa7812fab4)) {
    foreach(drone in trackers.var_3aef66aa7812fab4) {
      drone thread drone_die(0);
    }

    trackers.var_3aef66aa7812fab4 = [];
  }

  if(isDefined(trackers.wheelsons)) {
    foreach(wheelson in trackers.wheelsons) {
      if(isDefined(wheelson) && isDefined(wheelson.owner) && wheelson.owner == maestro) {
        wheelson.owner = undefined;
        wheelson setentityowner(undefined);
      }
    }
  }
}

function private function_404b2f21d0e54fb1() {
  while(true) {
    x = 800;
    y = 300;

    if(getdvarint(@ "hash_584aaa9da0bcc0d")) {
      foreach(drone in level.var_86b4835c1806d690) {
        print3d(drone.origin + (0, 0, 20), "<dev string:x20f>" + string(drone.fake_health), (0, 1, 0));

        if(isDefined(drone.next_node)) {
          line(drone.origin, drone.next_node.origin, (0.5, 0, 1));
          draw_circle(drone.next_node.origin, 5, (0, 1, 0.25), 1, 0, 1);
        }
      }
    }

    waitframe();
  }
}

function drone_watchfordeath() {
  self endon("death");
  radiuskill = 0;
  isdying = 0;

  while(true) {
    if(!istrue(isdying)) {
      if(isDefined(self.killzones)) {
        foreach(killzone in self.killzones) {
          distsq = distancesquared(self.origin, killzone.origin);

          if(distsq < killzone.radius * killzone.radius) {
            radiuskill = 1;
          }
        }
      }

      if(self.fake_health <= 0 || radiuskill) {
        isdying = 1;
        thread drone_die(0, istrue(self.var_1a00611a25c12747));
      }
    }

    wait 0.1;
  }
}

function drone_damagewatcher(params) {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(isDefined(self) && self.var_2a6024dda5bc8738 == 0 && isDefined(attacker) && (isPlayer(attacker) || isDefined(attacker.owner) && isPlayer(attacker.owner))) {
      player = attacker;

      if(isPlayer(attacker.owner)) {
        player = attacker.owner;
      }

      if(isPlayer(attacker) && damage > 0 && (!isDefined(partname) || partname != "shield")) {
        attacker scripts\cp_mp\damagefeedback::updatedamagefeedback("standard", damage >= self.health);
      }

      if(self.vehicle_drone == 0 && !isDefined(self.divetarget) && drone_canseetarget(player, (0, 0, 0))) {
        if(isinlaststand(player) || istrue(player.notarget) || istrue(player.ignoreme)) {
          self playSound("jup_maestro_drone_damaged");
          self.fake_health = int(max(0, self.fake_health - damage));
          continue;
        }

        if(isDefined(self.chokepoint)) {
          if(array_contains(self.chokepoint.attackingplayers, player)) {
            player.var_68cea97f9e78379d = gettime();
            self playSound("jup_maestro_drone_damaged");
            self.fake_health = int(max(0, self.fake_health - damage));
            continue;
          }

          self.chokepoint thread function_d66f206de2a2b7d1(player, self, self.owner, params);
        }

        self.divetarget = player;
        self notify("target_found");
      } else if(self.vehicle_drone == 0 && isDefined(self.divetarget) && drone_canseetarget(player, (0, 0, 0))) {
        if(isDefined(self.chokepoint) && array_contains(self.chokepoint.attackingplayers, player)) {
          player.var_68cea97f9e78379d = gettime();
          self playSound("jup_maestro_drone_damaged");
          self.fake_health = int(max(0, self.fake_health - damage));
          continue;
        }
      }

      self playSound("jup_maestro_drone_damaged");
      self.fake_health = int(max(0, self.fake_health - damage));
    }
  }
}

function function_bd97b7f184ae69b2(params) {
  self endon("death");
  self endon("brush_swap");
  level endon("game_ended");
  childthread function_e09cd5df1632b200();

  while(true) {
    self.clip waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(isDefined(self) && isDefined(attacker) && (isPlayer(attacker) || isDefined(attacker.owner) && isPlayer(attacker.owner))) {
      realdamage = damage;

      if(self.var_2a6024dda5bc8738) {
        realdamage = int(damage * params.shielddamagemultiplier);
      }

      if(isDefined(objweapon) && is_equal(getweaponrootstring(objweapon), "blackhole_bomb") && meansofdeath == "MOD_EXPLOSIVE") {
        realdamage = self.max_fake_health * 0.6;
      }

      player = attacker;

      if(isPlayer(attacker.owner)) {
        player = attacker.owner;
      }

      if(isPlayer(attacker) && realdamage > 0 && (!isDefined(partname) || partname != "shield")) {
        attacker scripts\cp_mp\damagefeedback::updatedamagefeedback("standard", realdamage >= self.health);
      }

      self playSound("jup_maestro_drone_damaged");

      if(isDefined(self.owner) && self.owner.isactive) {
        params.trackers.var_dffa579e39f9bdd5 = gettime() + (params.var_db9991611a26b0c1 - params.var_cfc9c46afa203cf6 * self.owner.damagephase) * 1000;

        if(!istrue(self.owner.var_f89e16252aec0396)) {
          params.trackers.deployinprogress = 0;
        }
      }

      self.fake_health = int(max(0, self.fake_health - realdamage));
      self.clip.fake_health = self.fake_health;
    }
  }
}

function function_e09cd5df1632b200() {
  self endon("attacking");

  while(true) {
    self waittill("drop_shield");
    self setscriptablepartstate("ddos", "disabled");
    wait 1;
    self.var_2a6024dda5bc8738 = 0;
    wait 3;
    self setscriptablepartstate("ddos", "neutral");
    self setscriptablepartstate("shield", "on");
    self.var_2a6024dda5bc8738 = 1;
  }
}

function function_19477228c9b4907b() {
  self endon("death");
  var_65d5104e6f0ea258 = istrue(self.vehicle_drone) && isDefined(self.behavior) && self.behavior == "protect";
  params = level.ob.warlordparameters["Maestro"];
  proximitydist = params.proximitydistance;

  if(var_65d5104e6f0ea258) {
    var_477db86aaf01fdb7 = params.var_7ce9f91c0bd1c384;
  }

  while(true) {
    if(!isDefined(self)) {
      break;
    }

    nearby_players = scripts\mp\utility\player::getplayersinradius(self.origin, proximitydist);

    foreach(player in nearby_players) {
      if(isaliveandnotinlaststand(player) && player.origin[2] < self.origin[2] + 50) {
        if(isDefined(self.owner) && self.owner.isactive) {
          params.trackers.var_dffa579e39f9bdd5 = gettime() + (params.var_db9991611a26b0c1 - params.var_cfc9c46afa203cf6 * self.owner.damagephase) * 1000;

          if(!istrue(self.owner.var_f89e16252aec0396)) {
            params.trackers.deployinprogress = 0;
          }
        }

        drone_bombexplode();
        wait 100;
      }
    }

    wait 0.1;
  }
}

function function_4f013c722a300e5b(params) {
  self endon("death");
  thread namespace_dc53a27a8db8e6bf::function_d01822693171d7c1();

  for(i = 0; i < params.dronecap; i++) {
    dronecap = function_99fedeb298e8b70(params, self.damagephase);

    if(params.trackers.var_647a70845738f8bc.size >= dronecap || params.trackers.var_d6f06f378d054276 + params.var_380bac03870b68ea * 1000 >= gettime() || !istrue(params.trackers.deployinprogress)) {
      break;
    }

    offsets = [(-60, -60, 100), (-60, 0, 100), (-60, 60, 100), (0, -60, 100), (0, 0, 100), (0, 60, 100), (60, -60, 100), (60, 0, 100), (60, 60, 100)];
    point = self.origin + random(offsets);

    if(istrue(self.var_f89e16252aec0396)) {
      waitframe();
    } else {
      randomizer = randomfloatrange(0.5, 1);
      wait randomizer;
    }

    self playSound("jup_maestro_drone_activate_launch");
    drone = function_35a2d548eaf273dd(point, params, 1, 0);
  }

  params.trackers.deployinprogress = 0;
}

function function_2961b32bea91aa54(params, drones, swarm_target, var_858b56231d6570cb) {
  var_2658c11fc0ea9a0c = swarm_target scripts\mp\agents\agent_utility::function_2e1b23386b967c10();
  curr_time = gettime();
  drones[0].var_e111e406f2e7a626 = var_858b56231d6570cb;
  drones[0].targeted_enemy = swarm_target;
  drones[0].var_3aec9a4ec140655a = var_2658c11fc0ea9a0c;
  drones[0].var_87babc8a58bc3639 = curr_time;
  drones[0].behavior = "bomb_attack_leader";
  drones[0].repath_now = 1;
  drones[0].explosion_timeout = curr_time + params.var_21b55f9053ab09db * 1000;
  params.trackers.var_dd72808b849e4d52[params.trackers.var_dd72808b849e4d52.size] = drones[0];
  drones[0] setscriptablepartstate("warning_beep", "on", 0);
  drones[0] notify("attacking");
  swarmsize = function_c4a3b2f8fe65e727(params, self.damagephase);

  for(i = 1; i < swarmsize; i++) {
    if(isDefined(drones[i])) {
      drones[i].var_e111e406f2e7a626 = var_858b56231d6570cb;
      drones[i].targeted_enemy = swarm_target;
      drones[i].behavior = "bomb_attack_follower";
      drones[i].bomb_attack_leader = drones[0];
      drones[i].repath_now = 1;
      drones[i].explosion_timeout = curr_time + params.var_21b55f9053ab09db * 1000;
      params.trackers.var_dd72808b849e4d52[params.trackers.var_dd72808b849e4d52.size] = drones[i];
      drones[i] setscriptablepartstate("warning_beep", "on", 0);
      drones[i] notify("attacking");
    }
  }

  params.trackers.var_f6b4651f19aa358++;
}

function function_52131076d4d3fe44(params, maestro) {
  maestro endon("death");
  self endon("death");

  while(true) {
    self waittill("trigger", player);

    if(istrue(player.notarget) || istrue(player.ignoreme)) {
      continue;
    }

    if(isDefined(maestro) && getdvarint(@ "hash_771e174bc8bdaeea", 0)) {
      if(isPlayer(player) && isaliveandnotinlaststand(player) && params.var_d824ae1f19006400 > params.trackers.var_f6b4651f19aa358) {
        point = maestro.origin + (0, 0, 80);
        var_feefcb2762265368 = [];

        for(i = 0; i < function_c4a3b2f8fe65e727(params, 0); i++) {
          var_feefcb2762265368[i] = maestro function_35a2d548eaf273dd(point, params, 1, 1);
        }

        function_2961b32bea91aa54(params, var_feefcb2762265368, player, 1);
        break;
      }

      continue;
    }

    break;
  }
}

function function_4f3833106786643e(params) {
  self endon("death");
  thread function_ecc8e68beaa407af(params);
  previoustime = gettime();
  params.trackers.spin_theta = 0;
  params.trackers.var_67ecec14024015ca = 0;
  params.trackers.spin_sin = 0;
  function_6385032960fc51b1(0);
  var_4e427fadfa92de91 = 0;
  var_9b67eaff05a41947 = 5000;
  engage_distance = 800;

  while(true) {
    new_time = gettime();
    var_39a3088671665a14 = params.var_d824ae1f19006400;

    if(self.damagephase > 1) {
      var_39a3088671665a14++;
    }

    if((new_time > params.trackers.var_47ed3bc2d55c6fce || new_time > params.trackers.var_d220d4746b1774d5) && function_c4a3b2f8fe65e727(params, self.damagephase) > 0 && var_39a3088671665a14 > params.trackers.var_f6b4651f19aa358) {
      var_d68140ac3f3b837b = [];
      var_858b56231d6570cb = 0;

      if(self.var_c557ad4f44477f11 == 1) {
        if(new_time > params.trackers.var_d220d4746b1774d5) {
          nearby_players = scripts\mp\utility\player::getplayersinradius(self.origin, params.var_f78dccad86bc937a);

          foreach(player in nearby_players) {
            if(isinlaststand(player) || istrue(player.notarget) || istrue(player.ignoreme)) {
              continue;
            }

            var_d68140ac3f3b837b[var_d68140ac3f3b837b.size] = player;
          }

          var_858b56231d6570cb = 1;
        } else {
          nearby_players = scripts\mp\utility\player::getplayersinradius(self.origin, params.var_ab5d8fc6026bb639);

          foreach(player in nearby_players) {
            if(isinlaststand(player) || istrue(player.notarget) || istrue(player.ignoreme)) {
              continue;
            }

            if(self cansee(player)) {
              var_d68140ac3f3b837b[var_d68140ac3f3b837b.size] = player;
            }
          }
        }
      }

      if(var_d68140ac3f3b837b.size > 0) {
        swarm_target = random(var_d68140ac3f3b837b);
        var_b27493f0dde36018 = [];
        offsets = [(-30, -75, 180), (-30, 0, 180), (-30, 75, 180), (0, -75, 180), (0, 0, 180), (0, 75, 180), (30, -75, 180), (30, 0, 180), (30, 75, 180)];

        for(i = 0; i < function_c4a3b2f8fe65e727(params, self.damagephase); i++) {
          point = self.origin + random(offsets);
          var_b27493f0dde36018[i] = function_35a2d548eaf273dd(point, params, 1, 1);
        }

        function_2961b32bea91aa54(params, var_b27493f0dde36018, swarm_target, var_858b56231d6570cb);

        if(var_858b56231d6570cb == 0) {
          thread namespace_dc53a27a8db8e6bf::function_85d8080b6082da5f();
        }
      }

      phasereduction = self.damagephase * 150;
      interval = params.var_482220154ebed932 * (1000 - phasereduction);
      params.trackers.var_47ed3bc2d55c6fce = new_time + interval;

      if(var_858b56231d6570cb) {
        params.trackers.var_d220d4746b1774d5 = new_time + params.var_40ed8a6dd8f0e6c5 * 1000;
      }
    }

    if(function_17ae7d764ad366a9()) {
      if((new_time >= params.trackers.var_dffa579e39f9bdd5 && params.trackers.var_d6f06f378d054276 + params.var_380bac03870b68ea * 1000 < new_time || istrue(self.var_f89e16252aec0396)) && params.trackers.var_647a70845738f8bc.size < function_99fedeb298e8b70(params, self.damagephase) && params.trackers.deployinprogress == 0) {
        params.trackers.deployinprogress = 1;
        thread function_4f013c722a300e5b(params);
      }
    } else if(new_time > var_4e427fadfa92de91) {
      var_d68140ac3f3b837b = scripts\mp\utility\player::getplayersinradius(self.origin, engage_distance);
      var_984bece0413ef6bb = [];

      foreach(target in var_d68140ac3f3b837b) {
        if(target hastacvis(self, 0, engage_distance)) {
          var_984bece0413ef6bb = array_add_safe(var_984bece0413ef6bb, target);
        }
      }

      if(var_984bece0413ef6bb.size > 0) {
        function_6385032960fc51b1(1);
        params.trackers.var_d220d4746b1774d5 = new_time + params.var_40ed8a6dd8f0e6c5 * 1000;
      } else {
        var_4e427fadfa92de91 = new_time + var_9b67eaff05a41947;
      }
    }

    theta_change = (new_time - previoustime) * 0.05;
    previoustime = new_time;
    params.trackers.spin_theta += theta_change;

    if(params.trackers.spin_theta >= 360) {
      params.trackers.spin_theta -= 360;
    }

    params.trackers.var_67ecec14024015ca = cos(params.trackers.spin_theta);
    params.trackers.spin_sin = sin(params.trackers.spin_theta);
    waitframe();
  }
}

function private function_6385032960fc51b1(value) {
  self.player_engaged = value;

  if(istrue(value)) {
    ent_flag_set("warlord_start_combat_chatter");
  }
}

function private function_17ae7d764ad366a9() {
  return istrue(self.player_engaged);
}

function private function_62883a99c01a4108(params) {
  self endon("death");

  while(true) {
    if(istrue(self.player_engaged)) {
      self.var_f89e16252aec0396 = 1;
      break;
    }

    wait 0.1;
  }

  while(true) {
    if(params.trackers.var_647a70845738f8bc.size >= function_99fedeb298e8b70(params, self.damagephase)) {
      self.var_f89e16252aec0396 = 0;
      break;
    }

    wait 0.1;
  }
}

function private function_dfda2e2f7083463b(params) {
  self notify("droneBombMonitor");
  self endon("droneBombMonitor");
  self waittill("death");
  params.trackers.var_647a70845738f8bc = array_remove(params.trackers.var_647a70845738f8bc, self);
  params.trackers.var_dd72808b849e4d52 = array_remove(params.trackers.var_dd72808b849e4d52, self);

  if(self.behavior == "bomb_attack_leader") {
    newleader = undefined;

    foreach(drone in params.trackers.var_dd72808b849e4d52) {
      if(drone.behavior == "bomb_attack_follower" && drone.bomb_attack_leader == self) {
        if(isDefined(newleader)) {
          drone.bomb_attack_leader = newleader;
          continue;
        }

        drone.targeted_enemy = self.targeted_enemy;
        drone.var_3aec9a4ec140655a = self.var_3aec9a4ec140655a;
        drone.var_87babc8a58bc3639 = gettime();
        drone.behavior = "bomb_attack_leader";
        drone.repath_now = 1;
        newleader = drone;
      }
    }

    if(!isDefined(newleader)) {
      params.trackers.var_f6b4651f19aa358--;
    }
  }
}

function private function_3145d0fdef5009b9() {
  if(isDefined(self.explosion_timeout) && self.explosion_timeout < gettime()) {
    thread drone_die(0);
  }
}

function private function_9d8b7e5c2ee17132(params) {
  self endon("death");

  while(true) {
    function_3145d0fdef5009b9();
    target = undefined;
    self.repath_now = 0;

    if(self.behavior == "idle" || self.forcestop == 1) {
      wait 0.1;
    } else {
      if(self.behavior == "protect") {
        self.var_b6610da05df6cc67 = self.owner.origin;
        self setscriptablepartstate("lights", "chase", 0);
        self setscriptablepartstate("shield", "on", 0);
        function_19d48dfe8f3cbc84(1, self, params);

        while(self.behavior == "protect" && isDefined(self.owner)) {
          if(isDefined(self.owner.var_5e9eeedc4f37723b)) {
            if(self.owner.var_5e9eeedc4f37723b <= 0) {
              protection_points = [(1, 1, 45), (1, 1, 25), (-1, -1, 45), (-1, -1, 25), (1, 1, 65), (-1, -1, 65), (1.3, 1.3, 35), (-1.3, -1.3, 35), (1.3, 1.3, 55), (-1.3, -1.3, 55)];
              var_b14c3da34a99e4cc = 33;

              if(!isDefined(self.protectindex)) {
                self.protectindex = randomintrange(0, 8);
              }

              vec = (protection_points[self.protectindex][0] * params.trackers.var_67ecec14024015ca * var_b14c3da34a99e4cc, protection_points[self.protectindex][1] * params.trackers.spin_sin * var_b14c3da34a99e4cc, protection_points[self.protectindex][2]);

              if(self.protectindex == 0 || self.protectindex == 2) {
                vec = (protection_points[self.protectindex][1] * params.trackers.spin_sin * var_b14c3da34a99e4cc, protection_points[self.protectindex][0] * params.trackers.var_67ecec14024015ca * var_b14c3da34a99e4cc, protection_points[self.protectindex][2]);
              }
            } else {
              protection_points = [(1, 1, 1.5), (1, 1, -1.5), (-1, -1, 1.5), (-1, -1, -1.5), (1.5, 1.5, 2), (1.5, 1.5, -2), (-1.5, -1.5, 2), (-1.5, -1.5, -2)];
              var_7bb72bedac0fd101 = int(self.protectindex / self.owner.var_5e9eeedc4f37723b);
              sideindex = self.protectindex % self.owner.var_5e9eeedc4f37723b;
              var_8170fee5aa3b28dd = self.owner.var_8a8bfb7e19f13a33[sideindex];
              var_5fbe54f9c6f5babf = self.owner.var_b8914dd33e1c911d[sideindex];
              vec = var_8170fee5aa3b28dd + (var_5fbe54f9c6f5babf[0] * protection_points[self.protectindex][0] * params.trackers.var_67ecec14024015ca, var_5fbe54f9c6f5babf[1] * protection_points[self.protectindex][1] * params.trackers.var_67ecec14024015ca, var_5fbe54f9c6f5babf[2] * protection_points[self.protectindex][2] * params.trackers.spin_sin);
            }

            self vehicle_setspeed(100, 100);

            if(istrue(self.owner.isflying)) {
              self setvehgoalpos(self.var_b6610da05df6cc67 + vec, 0);
            } else {
              self setvehgoalpos(self.var_b6610da05df6cc67 + vec, 1);
            }

            self.var_b6610da05df6cc67 = self.owner.origin;
          }

          waitframe();
        }

        function_19d48dfe8f3cbc84(0, self, params);
        self setscriptablepartstate("shield", "off", 0);
        self setscriptablepartstate("lights", "chase", 0);
      }

      if(self.behavior == "bomb_attack_leader") {
        swarm_target = function_a94ff7ec9c071dc3();

        if(!isDefined(swarm_target)) {
          nearby_players = scripts\mp\utility\player::getplayersinradius(self.origin, self.sightdistance);

          foreach(player in nearby_players) {
            if(isaliveandnotinlaststand(player) && drone_canseetarget(player, (0, 0, 0))) {
              swarm_target = player scripts\mp\agents\agent_utility::function_2e1b23386b967c10();
              self.targeted_enemy = player;
              self.var_3aec9a4ec140655a = swarm_target;
              self.var_87babc8a58bc3639 = gettime();
              break;
            }
          }

          if(!isDefined(swarm_target)) {
            self.targeted_enemy = undefined;
            thread drone_die(0);
            wait 10;
          }
        }

        if(isDefined(swarm_target)) {
          target = swarm_target;

          if(issharedfuncdefined("weapons", "_launchGrenade")) {
            if(!isDefined(self.dangericonent)) {
              dangericonent = self[[getsharedfunc("weapons", "_launchGrenade")]]("assault_drone_danger_mp", self.origin, (0, 0, 0), 100, 1);
              dangericonent linkTo(self);
              self.dangericonent = dangericonent;
            }
          }

          self.repath_time = 9000;
        }
      }

      if(self.behavior == "bomb_attack_follower") {
        if(isDefined(self.bomb_attack_leader)) {
          var_872d0fddcd37a140 = self.bomb_attack_leader.origin;

          if(isDefined(self.bomb_attack_leader.var_3aec9a4ec140655a)) {
            var_872d0fddcd37a140 = self.bomb_attack_leader.var_3aec9a4ec140655a;
          }

          points = getnodesinradius(var_872d0fddcd37a140, 200, 50, 75, "Path 3D");

          if(points.size > 0) {
            point = random(points);
            target = point.origin;
          } else {
            wait randomfloatrange(1, 3);
            target = var_872d0fddcd37a140;
          }

          self.repath_time = 3000;
        } else {
          assertmsg("<dev string:x21b>");
        }
      }
    }

    if(isDefined(target)) {
      childthread function_b737854d4e6433e9(self.origin, target);
      self waittill("goal");
      continue;
    }

    wait 0.1;
  }
}

function function_b737854d4e6433e9(startpoint, endpoint) {
  self endon("death");
  points = function_be2d74bb3a32175(startpoint, endpoint);
  self vehicle_setspeed(self.maxspeed, self.maxspeed);
  var_c8ad2ec7b6c85d3d = gettime() + self.repath_time;
  nearbydist = getdvarint(@ "hash_37752ee8659d9a34", 25);

  if(isDefined(points)) {
    for(i = 0; i < points.size; i++) {
      if(istrue(self.exploding)) {
        return;
      }

      while(istrue(self.var_75a825774aafb097) || self getgoalspeedmph() == 0) {
        wait 0.5;
      }

      self setvehgoalpos(points[i].origin, 1);

      while(distance2dsquared(self.origin, points[i].origin) > nearbydist * nearbydist) {
        if(self.repath_now || gettime() > var_c8ad2ec7b6c85d3d) {
          self notify("goal");
          return;
        }

        function_3145d0fdef5009b9();
        waitframe();
      }
    }
  } else {
    collisioncontents = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
    ignore = [self];
    passed = scripts\engine\trace::sphere_trace_passed(startpoint, endpoint, 8, ignore, collisioncontents);

    if(istrue(passed)) {
      if(istrue(self.exploding)) {
        return;
      }

      while(istrue(self.var_75a825774aafb097) || self getgoalspeedmph() == 0) {
        wait 0.5;
      }

      self setvehgoalpos(endpoint, 1);

      while(distance2dsquared(self.origin, endpoint) > nearbydist * nearbydist) {
        if(self.repath_now || gettime() > var_c8ad2ec7b6c85d3d) {
          self notify("goal");
          return;
        }

        function_3145d0fdef5009b9();
        waitframe();
      }
    } else {
      self.explosion_timeout = 0;
      function_3145d0fdef5009b9();
      return;
    }
  }

  self notify("goal");
}

function function_a94ff7ec9c071dc3() {
  if(isDefined(self.targeted_enemy) && isPlayer(self.targeted_enemy) && isaliveandnotinlaststand(self.targeted_enemy) && (self.var_e111e406f2e7a626 || distancesquared(self.origin, self.targeted_enemy.origin) < self.sightdistance * self.sightdistance)) {
    if(self.var_e111e406f2e7a626 || drone_canseetarget(self.targeted_enemy, (0, 0, 0))) {
      outval = self.targeted_enemy scripts\mp\agents\agent_utility::function_2e1b23386b967c10();
      self.var_3aec9a4ec140655a = outval;
      self.var_87babc8a58bc3639 = gettime();
      return outval;
    }

    if(isDefined(self.var_3aec9a4ec140655a)) {
      if(self.var_87babc8a58bc3639 + 10000 < gettime()) {
        self.var_3aec9a4ec140655a = undefined;
      } else {
        return self.var_3aec9a4ec140655a;
      }
    }
  }

  return undefined;
}

function function_3a06a5b74de0e429(destination, max_speed, var_39ec3953ca2743f4, var_8b42b0dbf3d7fc33) {
  var_3e4c94befd846398 = max_speed * 17.6;
  dist = distance(self.origin, destination);
  var_8bd1bdc3bfb8d76 = 0.5;

  if(istrue(var_8b42b0dbf3d7fc33)) {
    var_ed3df9bc8bfd7ad4 = max(0.1, dist / var_3e4c94befd846398);
    self moveTo(destination, var_ed3df9bc8bfd7ad4, var_ed3df9bc8bfd7ad4 * var_8bd1bdc3bfb8d76, 0);
  } else if(istrue(var_39ec3953ca2743f4)) {
    var_ed3df9bc8bfd7ad4 = max(0.1, dist / var_3e4c94befd846398 * var_8bd1bdc3bfb8d76);
    self moveTo(destination, var_ed3df9bc8bfd7ad4, 0, var_ed3df9bc8bfd7ad4 * var_8bd1bdc3bfb8d76);
  } else if(istrue(var_39ec3953ca2743f4) && istrue(var_8b42b0dbf3d7fc33)) {
    var_ed3df9bc8bfd7ad4 = max(0.1, dist / var_3e4c94befd846398);
    self moveTo(destination, var_ed3df9bc8bfd7ad4, 0, 0);
  } else {
    var_ed3df9bc8bfd7ad4 = max(0.1, dist / var_3e4c94befd846398 * (1 + var_8bd1bdc3bfb8d76));
    self moveTo(destination, var_ed3df9bc8bfd7ad4, var_ed3df9bc8bfd7ad4 * var_8bd1bdc3bfb8d76, var_ed3df9bc8bfd7ad4 * var_8bd1bdc3bfb8d76);
  }

  return var_ed3df9bc8bfd7ad4;
}

function function_c810b23729e64272(copydrone, target) {
  params = level.ob.warlordparameters["Maestro"];
  startpos = copydrone.origin;
  startang = copydrone.angles;
  vehicleinfo = "veh_maestro_bomb_drone_ob";
  drone = spawnVehicle("veh8_mil_air_tuniform_c4_ob", "drone_turret", vehicleinfo, startpos, startang);
  drone.var_52dcdba485e7ceeb = "j_body";
  drone.team = self.team;
  drone.death_queued = 0;
  drone.var_2a6024dda5bc8738 = 0;
  drone.maxspeed = float(params.dronespeed);
  drone.divedist = params.var_a7cdb2a8ec572747;
  drone.sightdistance = params.dronesightdistance;
  drone.exploding = 0;
  drone.var_176f2563dbfd1669 = params.var_176f2563dbfd1669;
  drone.forcestop = 0;
  drone.health = 999999;
  drone.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_bombdrone_healthbar");
  drone.var_534e788bc498be9f = getscriptbundle(%"hash_781de85130f2625a");
  drone.subclass = drone.var_534e788bc498be9f.name;
  drone.var_1e0eb63ecb3f1e2 = 1;
  drone.var_4919d15787f01154 = 1;
  drone.max_fake_health = params.dronehealth;
  drone.fake_health = copydrone.fake_health;
  drone.maestrodrone = 1;
  drone.killzones = params.killzones;
  drone.divetarget = target;
  drone.owner = copydrone.owner;
  drone.vehicle_drone = 0;
  drone.var_1a00611a25c12747 = 1;
  drone.chokepoint = copydrone.chokepoint;
  drone.var_aa6fe6af4cbbdd47 = &function_aeaae75fa8cfd4cb;
  drone thread drone_damagewatcher(params);
  drone setCanDamage(1);
  drone enableaimassist();
  drone thread drone_watchfordeath();
  drone thread function_3e42dda71c258e8a();
  drone thread function_2395aa8d473eb61f();
  drone function_f3bb4f4911a1beb2(#"emp", #"hash_a865e3770eb96298", drone, &function_7c3b5beb399db271);
  drone setscriptablepartstate("Spawn_Reveal", "Reveal_Instant", 0);
  return drone;
}

function function_617427d0e4d6b667() {
  self endon("death");
  detect_position = self.origin;
  var_202265225c2b02b8 = self.divetarget.origin + (0, 0, 50);
  self.move_speed = self.maxspeed;
  self vehicle_setspeed(self.maxspeed, self.maxspeed * 10, self.maxspeed * 10);
  self setscriptablepartstate("warning_beep", "on", 0);
  self setscriptablepartstate("engine_sound", "high", 0);
  self setscriptablepartstate("lights", "chase", 0);

  if(issharedfuncdefined("weapons", "_launchGrenade")) {
    dangericonent = self[[getsharedfunc("weapons", "_launchGrenade")]]("assault_drone_danger_mp", self.origin, (0, 0, 0), 100, 1);
    dangericonent linkTo(self);
    self.dangericonent = dangericonent;
  }

  thread function_19477228c9b4907b();
  points = function_be2d74bb3a32175(detect_position, var_202265225c2b02b8);
  ignore = [self];
  collisioncontents = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  passed = scripts\engine\trace::sphere_trace_passed(detect_position, self.divetarget.origin + (0, 0, 50), 8, ignore, collisioncontents);

  if(getdvarint(@ "hash_663fcb5399f02f8b", 0)) {
    line(detect_position, var_202265225c2b02b8, (1, 0, 1), 1, 0, 100);
  }

  if(!istrue(passed) && isDefined(points)) {
    for(i = 0; i < points.size; i++) {
      islastpoint = i == points.size - 1;

      if(islastpoint) {
        self setvehgoalpos(points[i].origin, 1);
        var_81203b77e0f72dd = 400;
      } else {
        self setvehgoalpos(points[i].origin, 0);
        var_81203b77e0f72dd = 900;
      }

      if(getdvarint(@ "hash_663fcb5399f02f8b", 0)) {
        line(self.origin, points[i].origin, (0, 1, 1), 1, 0, 100);
        print3d(self.origin, "<dev string:x255>", (0, 1, 1), 1, 1, 60);
      }

      while(distance2dsquared(self.origin, points[i].origin) > var_81203b77e0f72dd) {
        waitframe();
      }

      canseetarget = scripts\engine\trace::sphere_trace_passed(self.origin, self.divetarget.origin + (0, 0, 50), 8, ignore, collisioncontents);

      if(canseetarget) {
        self setvehgoalpos(self.divetarget.origin + (0, 0, 50), 1);

        if(getdvarint(@ "hash_663fcb5399f02f8b", 0)) {
          line(self.origin, self.divetarget.origin + (0, 0, 50), (1, 0, 1), 1, 0, 100);
          print3d(self.origin, "<dev string:x26f>", (1, 0, 1), 1, 1, 60);
        }

        if(!islastpoint) {
          while(distance2dsquared(self.origin, var_202265225c2b02b8) > 400) {
            waitframe();
          }

          break;
        }
      }
    }
  } else {
    if(!isDefined(points)) {
      if(getdvarint(@ "hash_62d49f4d2d6a1f23", 1)) {
        if(getdvarint(@ "hash_663fcb5399f02f8b", 0)) {
          print3d(self.origin, "<dev string:x28b>", (1, 1, 0), 1, 1, 100);
        }

        drone_bombexplode();
        return;
      } else {
        if(getdvarint(@ "hash_663fcb5399f02f8b", 0)) {
          print3d(self.origin, "<dev string:x2a7>", (1, 1, 0), 1, 1, 100);
        }
      }
    } else {
      if(getdvarint(@ "hash_663fcb5399f02f8b", 0)) {
        line(self.origin, var_202265225c2b02b8, (1, 1, 0), 1, 0, 100);
        print3d(self.origin, "<dev string:x2d1>", (1, 1, 0), 1, 1, 60);
      }
    }

    self setvehgoalpos(var_202265225c2b02b8, 1);

    while(distance2dsquared(self.origin, var_202265225c2b02b8) > 400) {
      waitframe();
    }
  }

  if(self.exploding == 0) {
    drone_bombexplode();
  }
}

function function_727d5c4c176aebb0(restock_path, patrol_center, patrol_radius, patrol_height, params) {
  self endon("death");

  for(i = 1; i < restock_path.size; i++) {
    wait_time = function_3a06a5b74de0e429(restock_path[i], self.maxspeed);
    waittill_any_timeout_1(wait_time, "target_found");

    if(isDefined(self.divetarget)) {
      break;
    }
  }

  if(isDefined(self.divetarget)) {
    vehicledrone = self.owner function_c810b23729e64272(self, self.divetarget);

    if(!isDefined(params.trackers.var_3aef66aa7812fab4)) {
      params.trackers.var_3aef66aa7812fab4 = [];
    } else {
      params.trackers.var_3aef66aa7812fab4 = array_removeundefined(params.trackers.var_3aef66aa7812fab4);
    }

    params.trackers.var_3aef66aa7812fab4[params.trackers.var_3aef66aa7812fab4.size] = vehicledrone;
    vehicledrone thread function_617427d0e4d6b667();

    if(isDefined(self.chokepoint) && isDefined(self.chokepoint.attackingdrone) && self.chokepoint.attackingdrone == self) {
      self.chokepoint.attackingdrone = vehicledrone;
    }

    thread drone_remove();
    return;
  }

  thread function_91e1b29969538cd3(patrol_center, patrol_radius, patrol_height, params);
}

function function_5cbe39f2741ec0b0(chokepointindex, restock_path, patrol_center, patrol_radius, patrol_height, patrol_count, params) {
  self endon("death");
  self endon("end_patrolling_drones");
  chokepoint = spawnStruct();
  chokepoint.chokepointindex = chokepointindex;
  chokepoint.attackingplayers = [];
  chokepoint.owner = self;
  chokepoint.targetplayertimer = params.targetplayertimer;
  params.chokepoints[chokepointindex] = chokepoint;

  for(dronecount = 0; dronecount < patrol_count; dronecount++) {
    drone = function_35a2d548eaf273dd(patrol_center, params, 0, 0);
    var_610c9bf70691838c = params.trackers.var_d5dc746b4c149b00[chokepointindex].size;
    params.trackers.var_d5dc746b4c149b00[chokepointindex][var_610c9bf70691838c] = drone;
    drone.chokepoint = chokepoint;
    drone thread function_91e1b29969538cd3(patrol_center, patrol_radius, patrol_height, params);
  }

  while(true) {
    areplayersnear = 0;

    if(self.ob.instancedata.var_6c29f2fdb0054bbe.size > 0) {
      foreach(player in self.ob.instancedata.var_6c29f2fdb0054bbe) {
        if(distance(player.origin, patrol_center) < 4000) {
          areplayersnear = 1;
          break;
        }
      }
    }

    params.trackers.var_d5dc746b4c149b00[chokepointindex] = array_removeundefined(params.trackers.var_d5dc746b4c149b00[chokepointindex]);

    if(areplayersnear && params.trackers.var_d5dc746b4c149b00[chokepointindex].size < patrol_count) {
      wait params.var_8ff0d62ff823d63f;
      params.trackers.var_d5dc746b4c149b00[chokepointindex] = array_removeundefined(params.trackers.var_d5dc746b4c149b00[chokepointindex]);

      while(params.trackers.var_d5dc746b4c149b00[chokepointindex].size < patrol_count) {
        drone = function_35a2d548eaf273dd(restock_path[0], params, 0, 0);
        var_610c9bf70691838c = params.trackers.var_d5dc746b4c149b00[chokepointindex].size;
        params.trackers.var_d5dc746b4c149b00[chokepointindex][var_610c9bf70691838c] = drone;
        drone.chokepoint = chokepoint;
        drone thread function_727d5c4c176aebb0(restock_path, patrol_center, patrol_radius, patrol_height, params);
        wait 0.2;
      }

      continue;
    }

    waitframe();
  }
}

function function_d66f206de2a2b7d1(target, var_e2ebc6c792eb1a5f, warlord, params) {
  self.owner endon("death");
  self.attackingplayers[self.attackingplayers.size] = target;
  target.var_68cea97f9e78379d = gettime();
  self.attackingdrone = var_e2ebc6c792eb1a5f;

  while(gettime() - target.var_68cea97f9e78379d < self.targetplayertimer) {
    if(isDefined(self.attackingdrone)) {
      waitframe();
    } else {
      foreach(drone in params.trackers.var_d5dc746b4c149b00[self.chokepointindex]) {
        if(isDefined(drone) && !isDefined(drone.divetarget)) {
          drone.divetarget = target;
          self.attackingdrone = drone;
          drone notify("target_found");
          break;
        }
      }
    }

    wait 0.2;
  }

  self.attackingplayers = array_remove(self.attackingplayers, target);
}

function function_1d511f730cc98a07(params) {
  self endon("death");
  params.chokepoints = [];

  if(isDefined(level.ob.warlordparameters["Maestro"].dronespawns)) {
    spawners = array_randomize(level.ob.warlordparameters["Maestro"].dronespawns);
    var_aced406793c2161 = level.ob.warlordparameters["Maestro"].var_5a0e8d4bcd8ac4c2;
    var_d1800a4c39d15e76 = level.ob.warlordparameters["Maestro"].var_926ec82bd8dad665;
    params.chokepoints = var_d1800a4c39d15e76;
    var_3d8706c40d78204b = getdvarint(@ "hash_33ab4ca7c0b34970", 100);
    chokepointindex = 0;

    foreach(point in spawners) {
      restock_path = [];
      path_complete = 0;
      patrol_center = undefined;
      patrol_radius = undefined;
      patrol_count = undefined;
      restock_path[restock_path.size] = point.origin;
      path_target = point.target;
      var_6a3a803356796c71 = 1;

      while(true) {
        if(var_6a3a803356796c71) {
          foreach(chokepoint in var_d1800a4c39d15e76) {
            if(path_target == chokepoint.targetname) {
              restock_path[restock_path.size] = chokepoint.origin;
              patrol_center = chokepoint.origin;
              patrol_radius = chokepoint.radius;
              patrol_height = chokepoint.height;
              patrol_count = chokepoint.script_count;
              path_complete = 1;
              break;
            }
          }
        } else {
          assertmsg("<dev string:x2fb>" + path_target);
          break;
        }

        if(path_complete) {
          break;
        }

        var_6a3a803356796c71 = 0;

        foreach(pathpoint in var_aced406793c2161) {
          if(path_target == pathpoint.targetname) {
            restock_path[restock_path.size] = pathpoint.origin;
            path_target = pathpoint.target;
            var_6a3a803356796c71 = 1;
            break;
          }
        }
      }

      if(path_complete && var_3d8706c40d78204b > 0) {
        if(patrol_count > var_3d8706c40d78204b) {
          patrol_count = var_3d8706c40d78204b;
          var_3d8706c40d78204b = 0;
        } else {
          var_3d8706c40d78204b -= patrol_count;
        }

        if(!isDefined(params.trackers.var_d5dc746b4c149b00[chokepointindex])) {
          params.trackers.var_d5dc746b4c149b00[chokepointindex] = [];
        } else {
          params.trackers.var_d5dc746b4c149b00[chokepointindex] = function_fdc9d5557c53078e(params.trackers.var_d5dc746b4c149b00[chokepointindex]);
        }

        thread function_5cbe39f2741ec0b0(chokepointindex, restock_path, patrol_center, patrol_radius, patrol_height, patrol_count, params);
        chokepointindex += 1;
      }
    }

    if(var_3d8706c40d78204b > 0) {
      var_4d8542dfe820fdd4 = array_randomize(level.ob.warlordparameters["Maestro"].var_784a9ecb89bdd253);
      params.chokepoints = function_ef4b3df86351aa00(params.chokepoints, var_4d8542dfe820fdd4, params.chokepoints.size);

      foreach(point in var_4d8542dfe820fdd4) {
        if(var_3d8706c40d78204b == 0) {
          break;
        }

        count = min(point.script_count, var_3d8706c40d78204b);

        if(!isDefined(params.trackers.var_d5dc746b4c149b00[chokepointindex])) {
          params.trackers.var_d5dc746b4c149b00[chokepointindex] = [];
        } else {
          params.trackers.var_d5dc746b4c149b00[chokepointindex] = function_fdc9d5557c53078e(params.trackers.var_d5dc746b4c149b00[chokepointindex]);
        }

        var_3d8706c40d78204b -= count;
        chokepoint = spawnStruct();
        chokepoint.chokepointindex = chokepointindex;
        chokepoint.attackingplayers = [];
        chokepoint.owner = self;
        chokepoint.targetplayertimer = params.targetplayertimer;
        params.chokepoints[chokepointindex] = chokepoint;

        for(i = 0; i < count; i++) {
          angle = randomfloatrange(0, 360);
          cosin = cos(angle);
          sine = sin(angle);
          vec = (cosin * point.radius, sine * point.radius, randomfloatrange(0, point.height)) + point.origin;
          drone = function_35a2d548eaf273dd(vec, params, 0, 0);

          if(isDefined(drone)) {
            drone thread function_91e1b29969538cd3(point.origin, point.radius, point.height, params);
          }

          var_446798ea3be5bbfb = params.trackers.var_d5dc746b4c149b00[chokepointindex].size;
          params.trackers.var_d5dc746b4c149b00[chokepointindex][var_446798ea3be5bbfb] = drone;
          drone.chokepoint = chokepoint;
          drone.isephemeral = 1;
          wait 0.2;
        }

        chokepointindex += 1;
      }
    }
  }
}

function function_d2eaa684b4981192(params) {
  self endon("death");

  while(isDefined(self) && !isDefined(self.divetarget)) {
    nearby_guys = scripts\mp\utility\entity::function_d9ce8fb00f0e5fa1(self.origin, self.divedist, undefined, self.owner);
    threats = [];

    foreach(guy in nearby_guys) {
      if(!isDefined(self.owner) || !isDefined(self.owner.team) || !isDefined(guy.team) || guy.team != self.owner.team) {
        if(isPlayer(guy) && (isinlaststand(guy) || istrue(guy.notarget) || istrue(guy.ignoreme) || istrue(guy.disguised))) {
          continue;
        }

        threats[threats.size] = guy;
      }
    }

    targetsvisible = [];

    if(threats.size > 0) {
      foreach(target in threats) {
        if(target.origin[2] < self.origin[2] + 20 && isalive(target) && drone_canseetarget(target, (0, 0, 0))) {
          targetsvisible[targetsvisible.size] = target;
        }
      }
    }

    mindist = 100000;

    foreach(target in targetsvisible) {
      disttotarget = distance2d(target.origin, self.origin);

      if(disttotarget < mindist) {
        targetfound = target;
        mindist = disttotarget;
        continue;
      }

      if(isDefined(targetfound) && isagent(targetfound) && isPlayer(target)) {
        targetfound = target;
      }
    }

    if(isagent(targetfound) && isDefined(self.chokepoint)) {
      foreach(var_4ba8d721b2c362b0 in params.trackers.var_d5dc746b4c149b00[self.chokepoint.chokepointindex]) {
        if(isDefined(var_4ba8d721b2c362b0) && isDefined(var_4ba8d721b2c362b0.divetarget) && var_4ba8d721b2c362b0.divetarget == targetfound) {
          targetfound = undefined;
          break;
        }
      }
    }

    if(isDefined(targetfound)) {
      self.divetarget = targetfound;
      self notify("target_found");
      break;
    }

    wait 0.2;
  }
}

function function_91e1b29969538cd3(patrol_center, patrol_radius, patrol_height, params) {
  self endon("death");

  while(!isDefined(self.divetarget)) {
    angle = randomfloatrange(0, 360);
    cosin = cos(angle);
    sine = sin(angle);
    vec = (cosin * patrol_radius, sine * patrol_radius, randomfloatrange(0, patrol_height)) + patrol_center;
    wait_time = function_3a06a5b74de0e429(vec, 8);
    rot_angle = randomfloatrange(-360, 360);
    self rotateYaw(rot_angle, 3);

    if(isDefined(self.divetarget)) {
      break;
    }

    waittill_any_timeout_1(wait_time, "target_found");
  }

  vehicledrone = self.owner function_c810b23729e64272(self, self.divetarget);

  if(!isDefined(params.trackers.var_3aef66aa7812fab4)) {
    params.trackers.var_3aef66aa7812fab4 = [];
  } else {
    params.trackers.var_3aef66aa7812fab4 = array_removeundefined(params.trackers.var_3aef66aa7812fab4);
  }

  params.trackers.var_3aef66aa7812fab4[params.trackers.var_3aef66aa7812fab4.size] = vehicledrone;
  vehicledrone thread function_617427d0e4d6b667();

  if(isDefined(self.chokepoint) && isDefined(self.chokepoint.attackingdrone) && self.chokepoint.attackingdrone == self) {
    self.chokepoint.attackingdrone = vehicledrone;
  }

  thread drone_remove();
}

function wheelson_spawn(pos, patrolstruct, vehicle, model, patrolradius, name, owneroverride) {
  if(!isDefined(owneroverride)) {
    assertmsg("<dev string:x33f>");
    return;
  }

  spawndata = spawnStruct();
  spawndata.origin = pos;
  spawndata.angles = (0, 0, 0);
  spawndata.spawntype = "veh_pac_sentry_amphibious_mp_biolab";
  spawndata.owner = undefined;
  spawndata.team = owneroverride.team;
  spawndata.modelname = "veh9_mil_lnd_whotel_v2_composite_ob";
  spawndata.vehicletype = "veh_pac_sentry_amphibious_mp_biolab";
  spawndata.targetname = "remote_tank";
  spawndata.cancapture = 0;
  spawndata.cancaptureimmediately = 0;
  spawndata.activateimmediately = 1;
  remotetank = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata);
  remotetank.owner = owneroverride;
  remotetank setentityowner(owneroverride);
  remotetank scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", owneroverride.team);
  remotetank.team = owneroverride.team;
  remotetank.tanktype = "remote_tank";
  remotetank.maxhealth = 6000;
  remotetank.health = 6000;
  remotetank.currenthealth = 6000;
  remotetank.pathstruct = patrolstruct;
  remotetank.patrolstruct = patrolstruct;
  remotetank.vehiclename = "pac_sentry";
  remotetank.zombiedamagemultiplier = 10;
  remotetank.skippathdistance = 150;
  remotetank.spinuptime = 1;
  remotetank laseron();
  remotetank addcomponent("p2p");
  remotetank function_77320e794d35465a("p2p", "reverseGasNormal", 1.5);
  remotetank function_77320e794d35465a("p2p", "steeringMultiplier", 20);
  remotetank function_77320e794d35465a("p2p", "manualSpeed", 10);
  remotetank function_77320e794d35465a("p2p", "reverseForBehindGoal", 1);
  remotetank function_77320e794d35465a("p2p", "stuckTime", 4);
  remotetank function_77320e794d35465a("p2p", "goalThreshold", 50);
  remotetank scripts\cp_mp\emp_debuff::set_start_emp_callback(&empstarted);
  remotetank scripts\cp_mp\emp_debuff::set_clear_emp_callback(&empcleared);
  remotetank scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_f149e9383f183cf0);
  remotetank scripts\cp_mp\equipment\haywire::function_aa823a31304ed981(&function_5c67fa91fe5b79);
  remotetank.var_8ffa366ec68f0c8b = 3600;
  remotetank scripts\mp\killstreaks\remotetank::function_89445073f3e86e5c(remotetank.vehiclename);
  function_45c8ebe59275b96e(remotetank.vehiclename);
  playFXOnTag(getfx("vfx_dmz_Wheelson_flashlight"), remotetank, "tag_flash");
  remotetank.currentstate = 0;
  remotetank vehicleshowonminimap(0);
  remotetank.damagecallback = &namespace_adc82618e9ef9897::vehicle_damagecallback;
  remotetank.ignoredteams = [];
  remotetank thread vehicle_patrol(patrolstruct);
  remotetank thread function_42bc36af24a342e();
  remotetank thread function_93dccf3096384da0();
  remotetank.damagestate = 0;
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(remotetank, remotetank.owner, remotetank.owner.team, 1);
  return remotetank;
}

function function_168280faef14cbf8(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid) {
  if(!isDefined(self.destroyed) || self.destroyed == 0) {
    if(isDefined(attacker) && (isPlayer(attacker) || isPlayer(attacker.owner))) {
      player = attacker;

      if(isPlayer(attacker.owner)) {
        player = attacker.owner;
      }

      if(isPlayer(attacker) && damage > 0 && (!isDefined(hitloc) || hitloc != "shield")) {
        attacker scripts\cp_mp\damagefeedback::updatedamagefeedback("standard", damage >= self.health);
      }
    }

    namespace_adc82618e9ef9897::vehicle_damagecallback(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid);
  }
}

function function_120b1e4e62e7695c(inflictor, attacker, damage, idflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname) {
  if(istrue(self.destroyed)) {
    return;
  } else {
    self.destroyed = 1;
  }

  self notify("death");
  self.health = 1;
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  scripts\cp_mp\emp_debuff::clear_emp(1);
  scripts\cp_mp\emp_debuff::allow_emp(0);
  scripts\mp\outofbounds::clearoob(self, 1);
  scripts\mp\killstreaks\remotetank::function_6add0f629e59f222();
  self setscriptablepartstate("body_damage_heavy", "on", 0);
  self setscriptablepartstate("turret_damage", "on", 0);
  turretdir = anglesToForward(self gettagangles("tag_flash"));
  self setturrettargetvec(turretdir * 500 + (0, -800, 0));
  wait 0.3;
  self function_77320e794d35465a("p2p", "pause", 1);
  wait 1.2;
  self playSound("veh_ks_wheelson_explode");
  self setscriptablepartstate("explode", "on", 0);
  wait 0.35;
  self.health = 0;

  if(isDefined(attacker)) {
    attackowner = ter_op(isDefined(attacker.owner), attacker.owner, attacker);

    if(isPlayer(attackowner)) {
      eventinfo = spawnStruct();
      eventinfo.isdestroyedkillstreak = 1;
      attackowner thread scripts\mp\utility\points::doscoreevent(#"hash_2b5885666af24123", objweapon, undefined, undefined, self, undefined, undefined, 0, eventinfo, 1);
    }
  }

  if(isDefined(self)) {
    scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
  }
}

function private function_76b01f56cccfc5ec(params) {
  if(!isDefined(params.wheelsonpath)) {
    return;
  }

  while(true) {
    if(getdvarint(@ "hash_8da2e3f75d2bf514", 0)) {
      for(i = 0; i < params.wheelsonpath.path.size; i++) {
        point = params.wheelsonpath.path[i];

        if(isDefined(params.wheelsonpath.path[i + 1])) {
          nextpoint = params.wheelsonpath.path[i + 1];
        }

        point draw_ent_axis(point.origin, 0.5, 5);

        if(isDefined(point) && isDefined(nextpoint)) {
          line(point.origin, nextpoint.origin, (1, 0, 1), 1, 0, 0.5);
          vec = vectorNormalize(nextpoint.origin - point.origin);
          midpoint = (nextpoint.origin + point.origin) / 2;
          a_start = midpoint + -1 * vec * 64;
          a_end = midpoint + vec * 64;
          draw_arrow_time(a_start, a_end, (1, 0.5, 0.5), 0.5);
        }
      }
    }

    wait 0.5;
  }
}

function function_4b8b0afabc972cf8(maestro) {
  maestro endon("reinforcement_triggered");
  maestro endon("death");

  while(true) {
    self waittill("trigger", player);

    if(isPlayer(player)) {
      maestro.ob.requestreinforcements = 1;
      maestro.ob.reinforcementindex = 1;
      maestro notify("reinforcement_triggered");
    }

    wait 1;
  }
}

function function_a0c7cc505f1c5675(requestid, maestro, waveindex) {
  if(isDefined(maestro) && isDefined(maestro.ob) && istrue(maestro.ob.requestreinforcements)) {
    maestro.ob.requestreinforcements = 0;
    return 1;
  }

  return 0;
}

function function_20076ce5ca820299(requestid, maestro) {
  if(isDefined(maestro) && istrue(maestro.player_engaged)) {
    function_df930eed75d4f74f(requestid, maestro.origin, 800);
    return true;
  }

  return false;
}

function function_6fe30a922ca26cb0(requestid, maestro) {
  if(!isDefined(maestro) || !isalive(maestro)) {
    return true;
  }

  return false;
}

function function_cb3106863907299c(requestid, maestro, agent) {
  self endon("death");
  maestro endon("death");
  volume = level.ob.warlordparameters["Maestro"].goalvolume;
  self function_398d3434e12ab1d1(volume);
  self setgoalvolumeauto(volume);
  self.aggressivemode = 1;
}

function function_a2fef9d268c4b5c2(requestid, maestro, agent) {
  if(agent == maestro) {
    return;
  }

  agent.var_5323a94889eff1de = 1;
  agent.var_4ebe755e0a0a430e = 1;
  agent thread function_cb3106863907299c(requestid, agent, maestro);
}

function function_b983c2159ac7d649(note) {
  if(note == "linkDrone") {
    return;
  }

  if(note == "unlinkDrone") {
    return;
  }
}