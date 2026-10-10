/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_41abe5ab9dd2b8fa.gsc
*************************************************/

#using script_102d83a437e2b29f;
#using script_24e4405cf93f20ed;
#using script_3a8f9ace195c9da9;
#using script_3cb1beed718e7650;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_spawning_util;
#using scripts\cp\gestures_cp;
#using scripts\cp\player_death;
#using scripts\cp\utility;
#using scripts\cp\utility\reinforcement_util;
#using scripts\cp_mp\anim_scene;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_b740eee99a5cea41;

function function_e3cbe8af73859214(var_b9eb7e4c2ca286c1) {
  var_63d655f59713c15b = spawnStruct();

  if(var_b9eb7e4c2ca286c1 == "dock_crane") {
    var_63d655f59713c15b.var_cf0a5829ae4a3fb8 = getdvarfloat(@ "hash_33a12a21f4c62bd6", 1);
    var_63d655f59713c15b.var_33517458a1086486 = getdvarfloat(@ "hash_e8f37e81fb49ce20", 1);
    var_63d655f59713c15b.var_2624127f8494114a = getdvarfloat(@ "hash_2d6249612a70444c", 1);
  } else if(var_b9eb7e4c2ca286c1 == "dock_crane2") {
    var_63d655f59713c15b.var_cf0a5829ae4a3fb8 = getdvarfloat(@ "hash_19dbbea8919dab2b", 1);
    var_63d655f59713c15b.var_33517458a1086486 = getdvarfloat(@ "hash_b5638033d14d7e4b", 1);
    var_63d655f59713c15b.var_2624127f8494114a = getdvarfloat(@ "hash_256e8ca13add5559", 1);
  } else if(var_b9eb7e4c2ca286c1 == "dock_crane3") {
    var_63d655f59713c15b.var_cf0a5829ae4a3fb8 = getdvarfloat(@ "hash_9dfe916a04248c38", 1);
    var_63d655f59713c15b.var_33517458a1086486 = getdvarfloat(@ "hash_d884c1cb59013e06", 1);
    var_63d655f59713c15b.var_2624127f8494114a = getdvarfloat(@ "hash_f5184bbfda6e5dca", 1);
  }

  return var_63d655f59713c15b;
}

function function_a3f235cc3f0a3f51() {
  if(isDefined(self) && isDefined(self.rack) && isDefined(self.rack.base)) {
    var_6be21d50b377ebfc = self.rack.base getlinkedchildren();

    foreach(ent in var_6be21d50b377ebfc) {
      if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == "crane_container") {
        return ent;
      }
    }
  }

  return undefined;
}

function function_7d45a562b65a00b0(var_1af108b88a0db0e3) {
  level endon("game_ended");
  flag_wait("shipping_container_system_initialized");
  var_81af7b4905ee618e = getdvarfloat(@ "hash_dbc6044cc0317a75", 220);
  var_b22a58322cb28083 = getdvarfloat(@ "hash_85b54782b384f33a", 2);
  var_8bb3b58774b122bb = self.origin + self getboundsmidpoint() - var_1af108b88a0db0e3.var_4e4816b43188dd92.base.origin;

  while(true) {
    self waittill("trigger", player);

    if(!(isPlayer(player) || isagent(player) || isscriptedagent(player))) {
      continue;
    }

    var_3fe00b92cf58fa59 = var_1af108b88a0db0e3.base.origin;
    var_a53dc2ff8014d511 = var_1af108b88a0db0e3.var_4e4816b43188dd92.base.origin;
    waitframe();
    var_7e78e24caeae3b61 = var_1af108b88a0db0e3.base.origin - var_3fe00b92cf58fa59;
    var_223cf2f2d3ce5a39 = var_1af108b88a0db0e3.var_4e4816b43188dd92.base.origin - var_a53dc2ff8014d511 - var_7e78e24caeae3b61;
    var_3fe00b92cf58fa59 = var_1af108b88a0db0e3.base.origin;
    var_a53dc2ff8014d511 = var_1af108b88a0db0e3.var_4e4816b43188dd92.base.origin;
    var_e5e3b941670a1126 = length2dsquared(var_223cf2f2d3ce5a39);

    if(var_e5e3b941670a1126 < var_b22a58322cb28083) {
      continue;
    }

    triggerorigin = var_1af108b88a0db0e3.var_4e4816b43188dd92.base.origin + var_8bb3b58774b122bb;
    playerdir = player.origin - triggerorigin;
    ground = player getgroundentity();

    if(vectordot2(var_223cf2f2d3ce5a39, playerdir) > 0) {
      if(isDefined(ground) && isDefined(ground.targetname) && ground.targetname == var_1af108b88a0db0e3.var_4e4816b43188dd92.brush.targetname) {
        continue;
      }

      var_f377add88fa23233 = vectorNormalize(vectorcross((0, 0, 1), var_223cf2f2d3ce5a39));
      var_b2fe49411d202266 = vectordot2(var_f377add88fa23233, player.origin - triggerorigin);
      var_4a9240494ce340f = vectornormalize2(var_223cf2f2d3ce5a39);
      var_2d4f06ffc3217fd0 = sign(var_b2fe49411d202266) * var_f377add88fa23233 + var_4a9240494ce340f;
      player knockback(var_2d4f06ffc3217fd0, var_81af7b4905ee618e);
    }
  }
}

function function_3491be5eb03f1f3c(var_1af108b88a0db0e3) {
  level endon("game_ended");
  flag_wait("shipping_container_system_initialized");
  var_1af108b88a0db0e3 endon("stop_crane");
  var_8bb3b58774b122bb = self.origin + self getboundsmidpoint() - var_1af108b88a0db0e3.base.origin;
  var_8e8cb29e5b624052 = self getboundshalfsize();
  var_81af7b4905ee618e = getdvarfloat(@ "hash_5f96a7ff4a65754f", 280);
  maxspeed = getdvarfloat(@ "hash_df537ab66b996f08", 100);
  mindamage = getdvarfloat(@ "hash_99a1940189e1be34", 15);
  maxdamage = getdvarfloat(@ "hash_d96d888c82fb66b2", 80);
  var_b22a58322cb28083 = getdvarfloat(@ "hash_55fd7aa4509a8630", 5);

  while(true) {
    self waittill("trigger", player);

    if(!(isPlayer(player) || isagent(player) || isscriptedagent(player))) {
      continue;
    }

    var_3fe00b92cf58fa59 = var_1af108b88a0db0e3.base.origin;
    waitframe();
    var_7e78e24caeae3b61 = var_1af108b88a0db0e3.base.origin - var_3fe00b92cf58fa59;
    var_3fe00b92cf58fa59 = var_1af108b88a0db0e3.base.origin;
    var_fb07f03444fd68ce = length2dsquared(var_7e78e24caeae3b61);

    if(var_fb07f03444fd68ce < var_b22a58322cb28083) {
      continue;
    }

    triggerorigin = var_1af108b88a0db0e3.base.origin + var_8bb3b58774b122bb;
    var_1f9d54c8a386977 = vectornormalize2(var_7e78e24caeae3b61);
    var_d65f9888cd64e8de = abs(var_7e78e24caeae3b61[1]) > 0;
    var_a64c1e93213b1dee = abs(triggerorigin[var_d65f9888cd64e8de] - player.origin[var_d65f9888cd64e8de]);

    if(var_a64c1e93213b1dee - var_8e8cb29e5b624052[var_d65f9888cd64e8de] > 40) {
      continue;
    }

    playerdir = player.origin - triggerorigin;

    if(vectordot2(var_1f9d54c8a386977, playerdir) > 0) {
      var_211b101b8ebcfc71 = vectorNormalize(vectorcross((0, 0, 1), var_7e78e24caeae3b61));
      playervelocity = player getvelocity();

      if(length2d(playervelocity) < 0.01) {
        playervelocity = playerdir;
      }

      var_7d0d4ad63902cc5e = vectordot2(var_211b101b8ebcfc71, playervelocity);
      var_2d4f06ffc3217fd0 = sign(var_7d0d4ad63902cc5e) * var_211b101b8ebcfc71 + var_1f9d54c8a386977;
      player knockback(var_2d4f06ffc3217fd0, var_81af7b4905ee618e);

      if(isDefined(player.var_a78281b11a19c76) && player.var_a78281b11a19c76 > gettime()) {
        continue;
      }

      playerheight = player getplayerviewheight();

      if(playerheight <= 30) {
        player.shouldskipdeathsshield = 1;
        damage = player.health + 1000;
      } else {
        speed = min(var_fb07f03444fd68ce, maxspeed);
        var_39a3db0be64d9885 = 0;

        if(playerheight <= 50) {
          var_39a3db0be64d9885 = maxdamage * (getdvarfloat(@ "hash_ac5ec69c903c9c94", 1.5) - 1);
        }

        damage = mindamage + (maxdamage + var_39a3db0be64d9885 - mindamage) * speed / maxspeed;
      }

      if(damage > 0) {
        player dodamage(damage, player.origin, var_1af108b88a0db0e3.brush, var_1af108b88a0db0e3.brush, "MOD_IMPACT");
        player childthread function_14168abeafb7dc7a(0.5);
      }
    }
  }
}

function function_cff199526f7a7d98(crane) {
  level endon("game_ended");
  flag_wait("shipping_container_system_initialized");

  while(true) {
    wait 0.2;
    var_3fe00b92cf58fa59 = crane.base.origin;
    waitframe();
    var_3eacb3a877bf0e7f = vectorNormalize(crane.base.origin - var_3fe00b92cf58fa59);

    if(length2dsquared(crane.base.origin - var_3fe00b92cf58fa59) < 0.1) {
      continue;
    }

    start = self.origin;
    end = start + var_3eacb3a877bf0e7f * 35;
    vehiclecontents = create_vehicle_contents();
    trace = sphere_trace(start, end, 15, self, vehiclecontents);

    if(isDefined(trace["entity"])) {
      if(trace["entity"] scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        iprintln("<dev string:x1c>");

        playsoundatpos(self.origin, "sfx_port_crane_blocked_beep");
        stop_crane(crane);
        return;
      }
    }
  }
}

function function_86c80cdb44f43097(crane, container) {
  level endon("game_ended");
  self endon("container_placed");
  flag_wait("shipping_container_system_initialized");

  while(true) {
    wait 0.2;
    start = container.base.origin;
    direction = (0, 0, -10);
    end = start + direction;
    vehiclecontents = create_vehicle_contents();
    trace = sphere_trace(start, end, 15, container.base, vehiclecontents);

    if(isDefined(trace["entity"])) {
      if(trace["entity"] scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        iprintln("<dev string:x1c>");

        playsoundatpos(container.base.origin, "sfx_port_crane_blocked_beep");
        stop_crane(crane);
        return;
      }
    }
  }
}

function function_36fcc7b9945e2c34(crane, container) {
  level endon("game_ended");
  self endon("container_placed");
  flag_wait("shipping_container_system_initialized");

  while(true) {
    wait 0.2;
    start = container.base.origin;
    direction = (0, 0, -10);
    end = start + direction;
    trace = sphere_trace(start, end, 15, container.base);

    if(isDefined(trace["entity"])) {
      if(isPlayer(trace["entity"])) {
        if(trace["entity"] isusingremote()) {
          iprintln("<dev string:x2d>");

          playsoundatpos(container.base.origin, "sfx_port_crane_blocked_beep");
          stop_crane(crane);
          return;
        }
      }
    }
  }
}

function stop_crane(crane) {
  crane notify("stop_crane");
  crane notify("crane_base_stopped_moving");
  crane.base moveTo(crane.base.origin, 0.1);
  crane.var_4e4816b43188dd92.base moveTo(crane.var_4e4816b43188dd92.base.origin, 0.1);
  crane.rack.base moveTo(crane.rack.base.origin, 0.1);
  crane.var_c8d662d9a01e77b0 moveTo(crane.var_c8d662d9a01e77b0.origin, 0.1);

  foreach(wheel in crane.wheels) {
    wheel moveTo(wheel.origin, 0.1);
    wheel rotateby((0, 0, 0), 0.1);
  }
}

function function_14168abeafb7dc7a(cooldownseconds) {
  flag_wait("shipping_container_system_initialized");
  cooldowntime = gettime() + cooldownseconds * 1000;
  self.var_a78281b11a19c76 = cooldowntime;
  wait cooldownseconds;

  if(!isDefined(self.var_a78281b11a19c76) || self.var_a78281b11a19c76 != cooldowntime) {
    return;
  }

  self.var_a78281b11a19c76 = undefined;
}

function function_a03b8306b5246018() {
  level endon("game_ended");
  flag_wait("shipping_container_system_initialized");
  var_f768e613a61e7039 = undefined;

  while(true) {
    container = function_a3f235cc3f0a3f51();

    if(!isDefined(container)) {
      var_f768e613a61e7039 = undefined;
    } else {
      if(isDefined(var_f768e613a61e7039)) {
        var_5dd66ec2eeb790f = container.origin - var_f768e613a61e7039;

        if(var_5dd66ec2eeb790f[2] < 0) {
          var_8dbb13500a4c0362 = utility::playersnear(container.origin, 256);

          foreach(player in var_8dbb13500a4c0362) {
            if(player isjumping()) {
              continue;
            }

            dmgorigin = player.origin + (0, 0, player getplayerviewheight());

            if(isalive(player) && ispointinvolume(dmgorigin, container)) {
              player.shouldskipdeathsshield = 1;
              player dodamage(player.health + 1000, dmgorigin, container, container, "MOD_CRUSH");
            }
          }
        }
      }

      var_f768e613a61e7039 = container.origin;
    }

    waitframe();
  }
}

function function_4d344453627f42b4() {
  level endon("game_ended");
  flag_wait("shipping_container_system_initialized");
  var_f768e613a61e7039 = undefined;

  while(true) {
    rack = self.rack.base;

    if(!isDefined(rack)) {
      var_f768e613a61e7039 = undefined;
    } else {
      if(isDefined(var_f768e613a61e7039)) {
        var_147ef48ae65440bd = rack.origin - var_f768e613a61e7039;

        if(var_147ef48ae65440bd[2] < 0) {
          var_86d023b1977d5a70 = utility::playersnear(rack.origin, 500);

          foreach(player in var_86d023b1977d5a70) {
            if(player isjumping()) {
              continue;
            }

            dmgorigin = player.origin + (0, 0, player getplayerviewheight());

            if(isalive(player) && ispointinvolume(dmgorigin, rack)) {
              player.shouldskipdeathsshield = 1;
              player dodamage(player.health + 1000, dmgorigin, rack, rack, "MOD_CRUSH");
            }
          }
        }
      }

      var_f768e613a61e7039 = rack.origin;
    }

    waitframe();
  }
}

function function_dd9a8518ef3f14bb(objpoint) {
  var_e256d44437269626 = self;
  level.player scripts\cp\gestures_cp::player_gesture_force("jup_ges_vm_offhand_1h_tracker");
  wait 0.5;
  viewpos = level.player getvieworigin();
  endpos = viewpos + anglesToForward(level.player getplayerangles()) * 200;
  endpos += anglestoleft(level.player getplayerangles()) * 50;
  cast = [];
  cast = ray_trace(viewpos, endpos);
  endpos = cast["position"];
  var_568548a6e9a3eeef = endpos - objpoint.origin;
  var_c09de7eab37a770c = rotatevectorinverted(var_568548a6e9a3eeef, objpoint.angles) + (1.5, 0, 0);

  if(var_c09de7eab37a770c[1] < 4 && var_c09de7eab37a770c[1] > -4 && var_c09de7eab37a770c[2] < 4 && var_c09de7eab37a770c[2] > -10) {
    var_c09de7eab37a770c -= (7, 0, 0);
  } else if(var_c09de7eab37a770c[1] < 2 && var_c09de7eab37a770c[1] > -5 && var_c09de7eab37a770c[2] < 12 && var_c09de7eab37a770c[2] > 6) {
    var_c09de7eab37a770c -= (1.75, 0, 0);
  } else if(var_c09de7eab37a770c[1] < 2.75 && var_c09de7eab37a770c[1] > -5.5) {
    var_c09de7eab37a770c -= (0.75, 0, 0);
  } else if(var_c09de7eab37a770c[1] < -27) {
    depth = var_c09de7eab37a770c[0];

    if(depth > 0) {
      depth = -3.15;
    }

    var_c09de7eab37a770c = (depth, -27, var_c09de7eab37a770c[2]);
  } else if(var_c09de7eab37a770c[1] > 25) {
    depth = var_c09de7eab37a770c[0];

    if(depth > 0) {
      depth = -3.15;
    }

    var_c09de7eab37a770c = (depth, 25, var_c09de7eab37a770c[2]);
  } else if(var_c09de7eab37a770c[1] > -10 && var_c09de7eab37a770c[1] < -8 || var_c09de7eab37a770c[1] > 5.5 && var_c09de7eab37a770c[1] < 7.5) {
    var_c09de7eab37a770c -= (3, 0, 0);
  }

  var_e256d44437269626.origin = objpoint.origin + rotatevector(var_c09de7eab37a770c, objpoint.angles);
  var_e256d44437269626 show();
  var_e256d44437269626 setscriptablepartstate("light_part", "on");
}

function function_b7e9fd4b614b133(fxname, var_65faac79c6f02742, centeroffset, rotationoffset) {
  if(!isDefined(fxname) || !isstring(fxname)) {
    assertex(0, "PlaceLinkedVFX does not have a VFX to place.");
    return;
  }

  if(!isDefined(self) || !isent(self)) {
    assertex(0, fxname + " does not have an entity to link to.");
    return;
  }

  if(!isDefined(var_65faac79c6f02742) || !isarray(var_65faac79c6f02742)) {
    assertex(0, fxname + " does not have an array of positions for placement.");
    return;
  }

  if(!isDefined(rotationoffset) || !isvector(rotationoffset)) {
    rotationoffset = (0, 0, 0);
  }

  if(!isDefined(centeroffset) || !isvector(centeroffset)) {
    centeroffset = (0, 0, 0);
  }

  var_f892d9f8a4ff0eb2 = [];

  foreach(position in var_65faac79c6f02742) {
    if(!isvector(position)) {
      continue;
    }

    var_d6106a8cf23278f5 = spawn_tag_origin(position + centeroffset, rotationoffset);
    var_d6106a8cf23278f5 linkTo(self, "tag_origin", position + centeroffset, rotationoffset);
    var_d6106a8cf23278f5 show();
    waitframe();
    waitframe();
    playFXOnTag(getfx(fxname), var_d6106a8cf23278f5, "tag_origin");
    var_f892d9f8a4ff0eb2[var_f892d9f8a4ff0eb2.size] = var_d6106a8cf23278f5;
  }

  return var_f892d9f8a4ff0eb2;
}

function function_9e23991ff6710abf(var_e8fda99be77028d9) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(var_e8fda99be77028d9)) {
    var_e8fda99be77028d9 = 15;
  }

  self.forced_speed = var_e8fda99be77028d9;
  thread function_a415024439379f6f(self);
  thread function_18b9ef0283c0c553(self);

  if(isDefined(self.riders)) {
    foreach(rider in self.riders) {
      rider thread function_a415024439379f6f(self);
    }
  }

  self waittill("jltv_stop_patrol");
  self notify("newpath");
  self notify("reached_dynamic_path_end");
  self.forced_speed = 0;
  self notify("path_updated");
  self function_77320e794d35465a("p2p", "brakeAtGoal", 1);
  self function_77320e794d35465a("p2p", "goalPoint", self.origin);
  self stoppath();
  self vehicle_setspeedimmediate(0, 1, 1);
  self vehicle_cleardrivingstate();
  waitframe();

  if(!self hascomponent("p2p")) {
    println("<dev string:x48>");
    return;
  }

  if(getdvarint(@ "hash_957b41c68f110ce9", 0) != 0) {
    return;
  }

  function_ecbcec373d227be(0, "default", 1);
  self function_65aa053c077c003a(1);
  self vehicle_turnengineoff();
  namespace_cbe993018617a21d::function_1686ecaabfdc542d();
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self, "neutral");

  if(isDefined(level.vehicle.var_9442d439c225c3fe)) {
    if([[level.vehicle.var_9442d439c225c3fe]](self)) {
      return 1;
    }
  }
}

function function_a415024439379f6f(jltv) {
  level endon("game_ended");
  jltv endon("jltv_stop_patrol");
  waittill_any_4("damage", "death", "unloaded", "unloading");
  jltv notify("jltv_stop_patrol");
}

function function_18b9ef0283c0c553(jltv) {
  var_3c027088d770a8be = 1;
  var_1cb6ac45c3d24bf2 = 1000;
  var_6f2fc503dc7592f5 = 3;
  level endon("game_ended");
  jltv endon("jltv_stop_patrol");

  while(true) {
    wait var_3c027088d770a8be;
    dist = distance(level.player.origin, jltv.origin);
    var_cd8e09b03ba656bb = dist <= var_1cb6ac45c3d24bf2;

    if(!var_cd8e09b03ba656bb) {
      continue;
    }

    var_29ca62597a43a1d7 = function_155f16ed1b7f00cd(jltv.riders, var_6f2fc503dc7592f5);

    if(!var_29ca62597a43a1d7) {
      continue;
    }

    jltv notify("jltv_stop_patrol");
    return;
  }
}

function function_4fb6c81d40937664() {
  level endon("game_ended");
  flag_init("ai_combat_active");

  while(true) {
    wait 3;
    enemies = getaiarray("bad_guys");
    enemies = array_removedead_or_dying(enemies, 1);
    incombat = 0;

    foreach(ai in enemies) {
      if(ai.alertlevel == "combat") {
        incombat++;

        if(incombat > 3) {
          break;
        }
      }
    }

    if(incombat > 3) {
      flag_set("ai_combat_active");
      continue;
    }

    flag_clear("ai_combat_active");
  }
}

function function_7203bd13c19d8bd3(targetname) {
  ents = getEntArray(targetname, "targetname");

  foreach(ent in ents) {
    ent hide();
  }
}

function function_9abe9350cc74539e(spawner_name, var_f692565186a11dfc, force_spawn) {
  veh_spawner = getStruct(spawner_name, "targetname");

  if(!isDefined(veh_spawner)) {
    assertmsg("Vehicle spawner: " + spawner_name + " does not exist.");
    return;
  }

  if(!isDefined(var_f692565186a11dfc)) {
    assertmsg("Vehicle spawner: " + spawner_name + " does not have an ai_think()!");
    return;
  }

  var_2080297e17b86673 = veh_spawner.script_vehiclegroup;

  if(!isDefined(var_2080297e17b86673)) {
    assertmsg("Vehicle spawner: " + spawner_name + " does not have a script_vehiclegroup to spawn enemies.");
    return;
  }

  veh_spawner.script_vehiclegroup = undefined;
  vehicle = level namespace_ba155a12c323dc5a::function_136d8a6a5c016d7e(veh_spawner, undefined, "p2p", undefined, 1);
  spawners = getStructArray(var_2080297e17b86673, "targetname");
  starting_pos = 0;

  foreach(spawner in spawners) {
    if(istrue(force_spawn)) {
      spawner.script_count = 1;
      spawner.script_forcespawn = 1;
    }

    spawner.veh = vehicle;

    if(!isDefined(spawner.script_startingposition)) {
      assertmsg(var_2080297e17b86673 + " needs script_startingposition's for vehicle. ");
      spawner.script_startingposition = starting_pos;
      starting_pos += 1;
    }
  }

  ai_spawn = namespace_a0852b262a68d01::function_6149b301ce19988b(var_2080297e17b86673, var_f692565186a11dfc);
  vehicle thread namespace_ba155a12c323dc5a::resume_path();
  return vehicle;
}

function tacmap_tutorial_hint() {
  level.player notify("tacmap_tutorial_hint");
  level.player endon("tacmap_tutorial_hint");
  level.player endon("disconnect");
  wait 2;
  reason = "interrupt_tutorial_print";

  while(reason == "interrupt_tutorial_print") {
    function_5aa52e5b551ac22d(&"CP_JUP_PORT/TACMAPGEAR", 40, 255);
    level.player thread function_fc3e652931efc2e2();
    reason = waittill_any_timeout_2(40, "tacmap_button_pressed", "interrupt_tutorial_print");

    if(reason == "interrupt_tutorial_print") {
      level.player notify("end_tacmap_waitForButtonPressed");
      wait 5;
    }
  }

  level.player notify("end_tacmap_waitForButtonPressed");
  level.player notify("tacmap_tutorial_hint");
}

function function_fc3e652931efc2e2() {
  level.player endon("disconnect");
  level.player endon("end_tacmap_waitForButtonPressed");

  while(level.player istacmapactive() == 0) {
    waitframe();
  }

  level notify("tacmap_button_pressed");
}

function function_84e9b95ad30666e1() {
  level.player endon("disconnect");
  level endon("game_ended");
  var_9cf91c8b4e25fc62 = 0;

  while(var_9cf91c8b4e25fc62 == 0) {
    while(function_910a912f327b8d34(level.player) == 0) {
      wait 1;
    }

    var_9cf91c8b4e25fc62 = function_5aa52e5b551ac22d(&"CP_JUP_PORT/DETECTED", 12, 0);

    if(!var_9cf91c8b4e25fc62) {
      continue;
    }

    wait 3;
    flag_wait("stealth_spotted");
    function_5aa52e5b551ac22d(&"CP_JUP_PORT/INCOMBAT", 12, 0);
  }
}

function function_137fc90d1f21350c() {
  flag_wait("flag_dungeon_intro_complete");
  level.player waittill("killed_player", attacker, meansofdeath, objweapon, inflictor);
  attacker = default_to(attacker, level.player.attacker);
  attacker_weapon = isDefined(level.player.laststanddowneddata) && isDefined(level.player.laststanddowneddata.weaponfullstring) ? level.player.laststanddowneddata.weaponfullstring : undefined;
  deathBy = "generic";
  deathquote = undefined;

  if(is_equal(meansofdeath, "MOD_FALLING")) {
    deathquote = 538;
  } else if(is_equal(meansofdeath, "MOD_CRUSH")) {
    if(isDefined(inflictor) && inflictor scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      deathBy = "hitnRun";
      deathquote = undefined;
    } else {
      deathBy = "gantrySquish";
      deathquote = 539;
    }
  } else if(is_equal(meansofdeath, "MOD_IMPACT")) {
    deathBy = "gantryHitnRun";
    deathquote = 537;
  } else if(is_equal(meansofdeath, "MOD_SUICIDE") && is_equal(attacker_weapon, "iw9_drown_mp")) {
    deathBy = "drown";
    deathquote = 153;
  } else if(isDefined(attacker)) {}

  namespace_96731f4d002634f6::function_2311740fe797906a("deathBy", deathBy);

  if(isDefined(deathquote)) {
    scripts\cp\player_death::set_custom_death_quote(deathquote, 1);
  }
}

function private function_e4683a40f716b4c4() {
  if(!isDefined(level.tutorialprint)) {
    level.tutorialprint = spawnStruct();
    level.tutorialprint.lastprinttime = 0;
    level.tutorialprint.queue = [];
    thread function_69990cbfa2818fdb();
  }
}

function function_5aa52e5b551ac22d(msg, time, priority) {
  function_e4683a40f716b4c4();

  if(level.tutorialprint.queue.size > 0 && priority <= level.tutorialprint.queue[0].priority) {
    currentduration = gettime() - level.tutorialprint.lastprinttime;

    if(level.tutorialprint.queue[0].time - currentduration > 3) {
      return false;
    }
  }

  newnode = spawnStruct();
  newnode.msg = msg;
  newnode.time = time;
  newnode.priority = priority;

  if(level.tutorialprint.queue.size > 0 && priority > level.tutorialprint.queue[0].priority) {
    level.tutorialprint.queue = array_insert(level.tutorialprint.queue, newnode, 1);
    level notify("interrupt_tutorial_print");
  } else {
    level.tutorialprint.queue = array_add(level.tutorialprint.queue, newnode);
  }

  return true;
}

function function_bd5efc673107e1fe(msg) {
  if(level.tutorialprint.queue.size) {
    if(level.tutorialprint.queue[0].msg == msg) {
      level notify("interrupt_tutorial_print");
      return;
    }

    for(i = 1; i < level.tutorialprint.queue.size; i++) {
      if(level.tutorialprint.queue[i].msg == msg) {
        array_remove_index(level.tutorialprint.queue, i);
        break;
      }
    }
  }
}

function private function_69990cbfa2818fdb() {
  level.player endon("disconnect");
  level endon("game_ended");

  while(true) {
    while(level.tutorialprint.queue.size == 0) {
      wait 0.1;
    }

    flag_waitopen_all_array(["objective_splash_onscreen", "other_splash_onscreen"]);
    msg = level.tutorialprint.queue[0].msg;
    time = level.tutorialprint.queue[0].time;
    level.player thread scripts\cp\cp_hud_message::tutorialprint(msg, time);
    level.tutorialprint.lastprinttime = gettime();
    reason = waittill_any_timeout_1(time + 2, "interrupt_tutorial_print");

    if(reason == "interrupt_tutorial_print") {
      level.player clearhudtutorialmessage();
    }

    level.tutorialprint.queue = array_remove_index(level.tutorialprint.queue, 0);
  }
}