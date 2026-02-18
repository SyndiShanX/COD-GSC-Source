/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_748019ae8f2fdb1a.gsc
***********************************************/

#using script_3411bb48d41bd3b;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace namespace_3983f538;

function autoexec main() {
  level endon(#"end_game");
  function_e8fa58f2();
  clientfield::register("world", "" + # "hash_2e92282adde859ff", 1, 1, "int");
  callback::on_connect(&function_94b08ecc);
  callback::on_spawned(&function_cfbece05);
  callback::on_ai_damage(&on_ai_damage);
  callback::on_ai_spawned(&on_ai_spawned);
  callback::add_callback(#"hash_5ca3a1f306039e1e", &on_vehicle_spawned);
  callback::add_callback(#"hash_473c82ed6a4bc96c", &function_891899a5);
  level thread function_19c4a6dc();
  level.var_eeb66e64 = &function_929727c5;
  level.var_d1a2ae79 = &function_f5c78778;
  level.var_83869c31 = &function_ebba8a0;
  level.var_cd14f384 = &function_64b9e51c;
  level.var_177b14f8 = 300;
  level.var_506300cc = 5000;
  level.var_3d487019 = 0;
  level waittill(#"playing");
  level thread function_77056849();
  level thread function_4167db58();
  level thread function_ab9b7039();
  level thread function_2b0c8f12();
  level thread function_9c0ef20d();
  mapname = "mp_black_sea";

  adddebugcommand("<dev string:x38>" + mapname + "<dev string:x49>");
  level thread function_b218294b();
  level thread function_9fb424f8();
}

function function_e8fa58f2() {
  hidemiscmodels("sv_holdout_aetherfungus");
  hidemiscmodels("defend_corpses_1");
  hidemiscmodels("defend_corpses_2");
  hidemiscmodels("defend_corpses_3");
  hidemiscmodels("hvt_mechz_corpses");
  hidemiscmodels("hvt_mimic_corpses");
  hidemiscmodels("hvt_raz_corpses");
  hidemiscmodels("hvt_steiner_corpses");
  hidemiscmodels("payload_teleport_corpses");
  hidemiscmodels("payload_noteleport_corpses");
  hidemiscmodels("retrieval_corpses");
  hidemiscmodels("secure_corpses");
  hidemiscmodels("hordehunt_corpses_1");
  hidemiscmodels("hordehunt_corpses_2");
  hidemiscmodels("hordehunt_corpses_3");
  hidemiscmodels("fishing_setup");
}

function function_2b0c8f12() {
  level flag::wait_till(#"item_world_reset");
  wait 0.1;
  var_94c44cac = getdynentarray("spy_special_weapon_stash");
  var_de285f77 = getdynentarray("spy_ammo_stash");
  var_ffd6a2d3 = getdynentarray("spy_equipment_stash");
  var_3c1644b6 = arraycombine(var_94c44cac, var_de285f77);
  var_3c1644b6 = arraycombine(var_3c1644b6, var_ffd6a2d3);

  foreach(dynent in var_3c1644b6) {
    setdynentstate(dynent, 3);
  }
}

function function_9c0ef20d() {
  var_83369a0c = ["spawner_bo5_zombie_sr_omega_soldier"];
  var_adc4b89b = ["spawner_bo5_zombie_sr_american_soldier"];
  var_3dbbc101 = ["spawner_bo5_zombie_sr_american_soldier", "spawner_bo5_zombie_sr_omega_soldier"];
  namespace_85745671::function_c85e46e9("location_upperdeck", #"zombie", var_83369a0c);
  namespace_85745671::function_c85e46e9("location_stern", #"zombie", var_3dbbc101);
  namespace_85745671::function_c85e46e9("location_starboard", #"zombie", var_3dbbc101);
  namespace_85745671::function_c85e46e9("location_sinkingship", #"zombie", var_83369a0c);
  namespace_85745671::function_c85e46e9("location_launchbay", #"zombie", var_83369a0c);
  namespace_85745671::function_c85e46e9("location_rearstern", #"zombie", var_83369a0c);
  namespace_85745671::function_c85e46e9("location_portside", #"zombie", var_3dbbc101);
  namespace_85745671::function_c85e46e9("location_patrol", #"zombie", var_83369a0c);
  namespace_85745671::function_c85e46e9("location_mainhall", #"zombie", var_83369a0c);
  namespace_85745671::function_c85e46e9("location_machineshop", #"zombie", var_83369a0c);
  namespace_85745671::function_c85e46e9("location_lowerdeck", #"zombie", var_83369a0c);
  namespace_85745671::function_c85e46e9("location_helideck", #"zombie", var_3dbbc101);
  namespace_85745671::function_c85e46e9("location_hanger", #"zombie", var_3dbbc101);
  namespace_85745671::function_c85e46e9("location_gunboat", #"zombie", var_adc4b89b);
  namespace_85745671::function_c85e46e9("location_galley", #"zombie", var_83369a0c);
  namespace_85745671::function_c85e46e9("location_frontbow", #"zombie", var_83369a0c);
  namespace_85745671::function_c85e46e9("location_crewquarters", #"zombie", var_83369a0c);
  namespace_85745671::function_c85e46e9("location_controlroom", #"zombie", var_83369a0c);
  namespace_85745671::function_c85e46e9("location_capsized", #"zombie", var_adc4b89b);
  namespace_85745671::function_c85e46e9("location_bridge", #"zombie", var_3dbbc101);
  namespace_85745671::function_c85e46e9("location_bow", #"zombie", var_3dbbc101);
  namespace_85745671::function_c85e46e9("location_auxbridge", #"zombie", var_83369a0c);
  namespace_85745671::function_c85e46e9("location_sub", #"zombie", var_83369a0c);
  namespace_85745671::function_c85e46e9("location_maintenance", #"zombie", var_83369a0c);
  namespace_85745671::function_c85e46e9("location_davy", #"zombie", var_3dbbc101);
}

function function_7243fef2(vehicle) {
  var_562ae86f = 45;
  return abs(vehicle.origin[2] - getwaterheight(vehicle.origin)) < var_562ae86f;
}

function function_77056849() {
  level endon(#"end_game");

  while(true) {
    zombies = getaiarchetypearray(#"zombie");

    foreach(zombie in zombies) {
      if(isDefined(zombie) && !is_true(zombie.var_afbb6d07) && zombie.awarenesslevelcurrent !== "unaware") {
        if(isPlayer(zombie.enemy) && zombie.enemy isinvehicle()) {
          vehicle = zombie.enemy getvehicleoccupied();

          if(function_7243fef2(vehicle) && zombie cansee(vehicle) && (zombie.enemy.origin[2] < zombie.origin[2] || zombie getgroundent() === vehicle)) {
            var_32a2ed89 = getdvarfloat(#"hash_23ca127b17dd46ef", 200);
            var_56e6b9ca = vehicle.origin + anglesToForward(vehicle.angles) * var_32a2ed89;
            var_7798f40b = arraygetclosest(zombie.origin, [vehicle.origin, var_56e6b9ca]);
            dist_check = getdvarfloat(#"hash_46028ad3d0eb1c7e", 600);

            if(is_true(vehicle.var_4efd1a01)) {
              dist_check *= 3;
            }

            if(isDefined(var_7798f40b) && isDefined(zombie.origin) && distance2dsquared(var_7798f40b, zombie.origin) < sqr(dist_check)) {
              var_53b2da60 = zombie_utility::function_d446de65(zombie, zombie.origin + anglesToForward(zombie.angles) * 100, 100);

              if(!isDefined(var_53b2da60)) {
                function_59dbd2b(zombie, var_7798f40b);
                wait randomfloatrange(0.4, getdvarfloat(#"hash_477d3fea18818caa", 1.5));
              }
            }
          }
        }
      }

      if(isDefined(zombie.origin)) {
        if(zombie.origin[2] < -100) {
          if(isalive(zombie)) {
            zombie.allowdeath = 1;
            zombie kill();
          }
        }
      }

      waitframe(1);
    }

    waitframe(1);
  }
}

function function_4167db58() {
  level.var_ef784546 = 1;
  level endon(#"end_game");

  while(true) {
    zombies = getaiteamarray(level.zombie_team);

    foreach(zombie in zombies) {
      if(isDefined(zombie) && !is_true(zombie.var_df972d6)) {
        if(zombie.origin[2] < -100) {
          var_8d9b91de = undefined;

          if(is_true(zombie.var_c588eb)) {
            var_d193654b = struct::get_array("kill_hvt", "content_script_name");
            var_8d9b91de = arraygetclosest(zombie.origin, var_d193654b);
            level thread function_42fbf5d9(zombie, var_8d9b91de);
          }

          if(isalive(zombie) && !isDefined(var_8d9b91de)) {
            zombie.var_a54d6082 = 1;
            zombie.allowdeath = 1;
            zombie kill();
          }
        }
      }

      waitframe(1);
    }

    waitframe(1);
  }
}

function function_59dbd2b(entity, target_pos) {
  if(entity isragdoll()) {
    return;
  }

  var_dd6010e8 = (0, 0, 0);
  var_dd6010e8 -= (0, 0, 30);
  var_dd6010e8 += anglesToForward(entity.angles) * 20;
  entity.var_cc6f2563 = var_dd6010e8;
  anim = # "hash_15c778c08ce4f907";
  anim_angles = entity.angles;

  if(isDefined(target_pos)) {
    yaw = vectortoyaw(target_pos - entity.origin);
    anim_angles = (anim_angles[0], yaw, anim_angles[2]);
  }

  entity.var_afbb6d07 = 1;
  entity animscripted(anim, entity.origin, anim_angles, anim, "normal");
}

function function_ab9b7039() {
  level endon(#"end_game");
  var_49b5ae04 = struct::get_array("black_sea_ai_hide_spot", "targetname");

  if(!isDefined(level.var_6f400b17)) {
    level.var_6f400b17 = [];
  }

  foreach(spot in var_49b5ae04) {
    var_a404d227 = getnavfaceregion(spot.origin, 100);

    if(isDefined(var_a404d227)) {
      if(!isDefined(level.var_6f400b17[var_a404d227])) {
        level.var_6f400b17[var_a404d227] = [];
      }

      array::add(level.var_6f400b17[var_a404d227], spot.origin);
    } else {
      println("<dev string:x83>" + spot.origin);
    }

    waitframe(1);
  }
}

function function_f5c78778(entity, var_213c85d7) {
  var_a694f08d = [# "hash_7c0d83ac1e845ac2", #"zombie_dog", #"soa", #"mimic"];

  if(isinarray(var_a694f08d, var_213c85d7.archetype)) {
    var_7c27952f = [# "hash_7c0d83ac1e845ac2", #"mimic"];

    if(isinarray(var_7c27952f, var_213c85d7.archetype)) {
      if(isPlayer(var_213c85d7.enemy) && var_213c85d7.enemy isinvehicle()) {
        vehicle = var_213c85d7.enemy getvehicleoccupied();

        if(function_7243fef2(vehicle)) {
          return undefined;
        }
      }
    }

    var_a404d227 = getnavfaceregion(var_213c85d7.origin, 100);

    if(isDefined(var_213c85d7.enemy)) {
      if(var_a404d227 === getnavfaceregion(var_213c85d7.enemy.origin, 100)) {
        return undefined;
      }
    }

    if(isDefined(var_a404d227) && isDefined(level.var_6f400b17[var_a404d227])) {
      var_82ae862c = arraygetclosest(var_213c85d7.origin, level.var_6f400b17[var_a404d227]);

      if(isDefined(var_213c85d7.origin) && isDefined(var_82ae862c) && distancesquared(var_213c85d7.origin, var_82ae862c) < sqr(100)) {
        return var_213c85d7.origin;
      }

      return var_82ae862c;
    }
  }

  return undefined;
}

function private function_ebba8a0(entity, enemy, target_pos) {
  if(!(isDefined(entity) && isDefined(enemy))) {
    return target_pos;
  }

  var_a404d227 = getnavfaceregion(entity.origin, 100);
  var_23bae5af = getnavfaceregion(enemy.origin, 100);

  if(!(isDefined(var_a404d227) && isDefined(var_23bae5af)) || var_a404d227 === var_23bae5af) {
    return target_pos;
  }

  var_3ad825ba = distance2d(entity.origin, target_pos);
  var_fbdba5d1 = target_pos + (randomfloatrange(-1 * var_3ad825ba / 10 * 0.5, var_3ad825ba / 10 * 0.5), randomfloatrange(-1 * var_3ad825ba / 10 * 0.5, var_3ad825ba / 10 * 0.5), 0);
  return var_fbdba5d1;
}

function private function_929727c5(entity) {
  var_1cea0f62 = entity.origin + anglesToForward(entity.angles) * 50;
  var_53b2da60 = zombie_utility::function_d446de65(entity, var_1cea0f62, 10);

  if(!isDefined(var_53b2da60)) {
    return false;
  }

  return true;
}

function private function_64b9e51c(entity, investigate_point) {
  var_a404d227 = getnavfaceregion(entity.origin, 100);
  var_23bae5af = getnavfaceregion(investigate_point, 100);

  if(isDefined(var_a404d227) && isDefined(var_23bae5af) && var_a404d227 !== var_23bae5af) {
    return false;
  }

  return true;
}

function private on_ai_spawned(params) {
  if(self.subarchetype === # "hash_12fa854f3a7721b9" || self.subarchetype === # "hash_3498fb1fbfcd0cf" || self.subarchetype === # "hash_5653bbc44a034094" || self.subarchetype === # "hash_70162f4bc795092") {
    self.meleeweapon = getweapon(#"hash_78e63e8be5fcdb27");
    self.var_f7f0128b = 45;
  }

  if(is_true(self.var_c588eb)) {
    self thread function_725ddc56();
  }
}

function function_725ddc56() {
  self endon(#"death");

  while(true) {
    wait 0.1;
    ground_ent = self getgroundent();

    if(isvehicle(ground_ent) && function_7243fef2(ground_ent) && !is_true(self.var_df972d6)) {
      var_d193654b = struct::get_array("kill_hvt", "content_script_name");
      var_8d9b91de = arraygetclosest(self.origin, var_d193654b);
      level thread function_42fbf5d9(self, var_8d9b91de);
    }
  }
}

function private on_ai_damage(params) {
  if(self.archetype === # "raz" || self.archetype === # "soa") {
    if(isPlayer(params.eattacker) && distance2dsquared(params.eattacker.origin, self.origin) > sqr(500)) {
      var_987c2c82 = getnavfaceregion(params.eattacker.origin, 100);
      var_a404d227 = getnavfaceregion(self.origin, 100);

      if(isDefined(var_987c2c82) && isDefined(var_a404d227) && var_987c2c82 !== var_a404d227) {
        if(!isDefined(self.var_1a06330f)) {
          self.var_1a06330f = 0;
        }

        self.var_1a06330f += params.idamage;

        if(self.var_1a06330f > self.maxhealth * 0.1) {
          self.var_1a06330f = 0;

          if(self.archetype === # "raz") {
            var_8d9b91de = getrandomnavpoint(params.eattacker.origin, 200, self getpathfindingradius() * 1.2);

            if(isDefined(var_8d9b91de)) {
              to_player = params.eattacker.origin - var_8d9b91de;
              var_78d08958 = vectortoyaw(to_player);

              if(self clientfield::is_registered("zombie_teleport")) {
                self clientfield::increment("zombie_teleport", 1);
              }

              util::delay_network_frames(1, #"death", &function_5095f2ff, var_8d9b91de, (0, var_78d08958, 0));
            }
          }

          if(self.archetype === # "soa") {
            if(isDefined(self.var_11b65fa)) {
              [[self.var_11b65fa]](self, params.eattacker.origin);
            }

            if(isDefined(self.var_55d2eb17)) {
              [[self.var_55d2eb17]](self);
            }
          }
        }
      }
    }
  }
}

function function_5095f2ff(var_8d9b91de, teleport_angles) {
  self dontinterpolate();
  self forceteleport(var_8d9b91de, teleport_angles);

  if(isDefined(self.var_b0f20cfe)) {
    self thread[[self.var_b0f20cfe]]();
  }
}

function private function_b218294b() {
  while(true) {
    if(getdvarint(#"hash_575c0dd0c77025b6", 0) > 0) {
      setDvar(#"hash_575c0dd0c77025b6", 0);
      ais = getactorarray();

      foreach(ai in ais) {
        if(ai.archetype == # "zombie") {
          function_59dbd2b(ai);
        }
      }

      wait 0.5;
    }

    waitframe(1);
  }
}

function private function_9fb424f8() {
  while(true) {
    if(isDefined(level.var_6f400b17) && getdvarint(#"hash_3f43f125b004428f", 1) > 0) {
      foreach(region, spots in level.var_6f400b17) {
        foreach(spot in spots) {
          record3dtext("<dev string:xa9>" + region, spot + (0, 0, 10), (1, 0, 0));
          recordsphere(spot, 10, (1, 0, 0));
        }
      }
    }

    waitframe(1);
  }
}

function function_94b08ecc(params) {
  level clientfield::set("" + # "hash_2e92282adde859ff", 1);
}

function function_cfbece05(params) {
  exploder::exploder("exp_lgt_12v12");
  exploder::exploder("fxexp_main_ship_oil_fire_level");
}

function function_19c4a6dc() {
  level.var_b8c0d7a2 = 3500;
  level.var_e6b49685 = 3000;
  hidemiscmodels("hide_chopper_01");
  level flag::wait_till("gameplay_started");
  exploder::exploder("fxexp_zm_fog");
  exploder::exploder("fxexp_zm_fog_a");
  exploder::exploder("fxexp_zm_fog_b");
  exploder::exploder("fxexp_zm_fog_c");
  var_ed2cd411 = getEntArray("hide_chopper_01", "targetname");

  foreach(ent in var_ed2cd411) {
    ent connectpaths();
    ent notsolid();
    ent hide();
  }
}

function private on_vehicle_spawned() {
  self function_d733412a(1);
}

function private function_891899a5(params) {
  if(isDefined(params.vehicle) && isDefined(params.vehicle.health) && params.vehicle.health > 0) {
    var_3f366540 = (0, 0, 0) - params.vehicle.origin;
    var_3f366540 = (var_3f366540[0], var_3f366540[1], 0);
    params.vehicle launchvehicle(vectornormalize(var_3f366540) * 200, vectornormalize(var_3f366540) * -1 * 100, 0, 0);
  }
}

function function_42fbf5d9(var_956ca580, s_dest) {
  var_956ca580 endon(#"death");
  var_956ca580.var_df972d6 = 1;
  var_956ca580 flag::set("kill_hvt_teleporting");

  if(var_956ca580.archetype === # "hash_7c0d83ac1e845ac2") {
    level endon(#"hash_2f3cb0b1b50d517a");
  }

  teleport_ent = util::spawn_model(#"tag_origin", var_956ca580.origin, var_956ca580.angles);

  if(!isDefined(teleport_ent)) {
    return;
  }

  var_956ca580 linkto(teleport_ent);

  if(teleport_ent clientfield::is_registered("" + # "hash_6d05bbcab1912e5a")) {
    teleport_ent clientfield::set("" + # "hash_6d05bbcab1912e5a", 1);
  }

  wait 1;
  v_target_pos = s_dest.origin;

  if(!isDefined(v_target_pos)) {
    v_target_pos = array::random(function_a1ef346b()).origin;
  }

  if(isDefined(teleport_ent)) {
    n_dist = distance(teleport_ent.origin, v_target_pos);
    n_time = n_dist / 1000;
    var_7fd007f9 = distance2d(teleport_ent.origin, v_target_pos) * 0.5;
    n_inc = int(n_dist);
    teleport_ent movez(100, 2);
    teleport_ent waittill(#"movedone");
  }

  if(isDefined(teleport_ent)) {
    teleport_ent playSound(#"hash_292cc4273f4c0161");
  }

  while(true) {
    if(isDefined(teleport_ent)) {
      var_ed0c1ff8 = distance2d(teleport_ent.origin, v_target_pos);

      if(var_ed0c1ff8 <= 100) {
        break;
      }

      v_dest = v_target_pos + (0, 0, n_inc);
      n_inc -= 50;

      if(v_dest[2] <= v_target_pos[2]) {
        break;
      }

      teleport_ent moveto(v_dest, n_time);
    }

    waitframe(1);
  }

  if(isDefined(teleport_ent)) {
    n_dist = distance(teleport_ent.origin, v_target_pos);
    n_time = n_dist / 1000;
    teleport_ent moveto(v_target_pos, n_time);
    teleport_ent waittill(#"movedone");
  }

  if(isDefined(teleport_ent)) {
    teleport_ent playSound(#"hash_2758a7e5c0fac58b");
    teleport_ent stoploopsound();
  }

  if(var_956ca580 clientfield::is_registered("" + # "hash_3049a409503be8a0")) {
    var_956ca580 clientfield::set("" + # "hash_3049a409503be8a0", 1);
  }

  var_956ca580 unlink();
  wait 0.1;
  var_956ca580 forceteleport(v_target_pos);
  util::wait_network_frame();

  if(isDefined(teleport_ent)) {
    teleport_ent thread function_313a13db();
  }

  var_956ca580 notify(#"teleported");

  if(var_956ca580 clientfield::is_registered("" + # "hash_3049a409503be8a0")) {
    var_956ca580 clientfield::set("" + # "hash_3049a409503be8a0", 0);
  }

  var_956ca580.var_df972d6 = undefined;
  var_956ca580 flag::clear("kill_hvt_teleporting");
}

function function_313a13db() {
  wait 1;

  if(isDefined(self)) {
    if(self clientfield::is_registered("" + # "hash_6d05bbcab1912e5a")) {
      self clientfield::set("" + # "hash_6d05bbcab1912e5a", 0);
    }

    self delete();
  }
}