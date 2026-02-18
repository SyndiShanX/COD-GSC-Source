/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3b2abb7986f4ae7c.gsc
***********************************************/

#using script_176597095ddfaa17;
#using script_34ab99a4ca1a43d;
#using script_36f4be19da8eb6d0;
#using script_3a88f428c6d8ef90;
#using script_437ce686d29bb81b;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\content_manager;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_supply_drop;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\zm_common\gametypes\hostmigration;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#namespace helicopter_escape;

function private autoexec __init__system__() {
  system::register(#"helicopter_escape", &preinit, undefined, undefined, #"content_manager");
}

function private preinit() {
  if(!zm_utility::is_survival()) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_7732e7b9e5c4e0e")) && !getdvarint(#"hash_730311c63805303a", 0)) {
    return;
  }

  clientfield::register("scriptmover", "supply_drop_parachute_rob", 1, 1, "int");
  zm::register_vehicle_damage_callback(&function_be51796c);
  scene::add_scene_func(#"p9_fxanim_wz_parachute_supplydrop_01_harness_bundle", &function_4bf116ab, "init");
  scene::add_scene_func(#"p9_fxanim_wz_parachute_supplydrop_01_harness_bundle", &function_2842c984, "done");
  scene::add_scene_func(#"p9_fxanim_wz_parachute_supplydrop_01_harness_bundle", &function_2842c984, "stop");
  scene::add_scene_func(#"p9_fxanim_wz_parachute_supplydrop_01_bundle", &function_76b49bd8, "open");
  content_manager::register_script(#"helicopter_escape", &function_685a8288);
}

function function_95c09591(destination) {
  if(!is_true(getgametypesetting(#"hash_7732e7b9e5c4e0e")) && !getdvarint(#"hash_730311c63805303a", 0)) {
    return;
  }

  level.var_e1011305 = namespace_cf6efd05::function_21d402f4(#"hash_3d1c462f6d4757c2");
  level flag::wait_till(#"start_zombie_round_logic");

  if(!getdvarint(#"hash_730311c63805303a", 0)) {
    if(!math::cointoss(30)) {
      return;
    }

    if(isDefined(level.var_e1011305) && isDefined(level.var_b48509f9) && level.var_e1011305 > 0 && level.var_b48509f9 - level.var_e1011305 <= 2) {
      return;
    }
  }

  var_4a91da6d = [];

  foreach(location in destination.locations) {
    instance = location.instances[# "helicopter_escape"];

    if(isDefined(instance)) {
      if(!isDefined(level.var_fcb2823)) {
        level.var_fcb2823 = [];
      } else if(!isarray(level.var_fcb2823)) {
        level.var_fcb2823 = array(level.var_fcb2823);
      }

      if(!isinarray(level.var_fcb2823, instance)) {
        level.var_fcb2823[level.var_fcb2823.size] = instance;
      }

      var_e7f5b3e0 = 1;

      if(isDefined(instance.var_501bc8c9)) {
        var_2685dd6d = strtok(instance.var_501bc8c9, ", ");

        foreach(var_a2593226 in var_2685dd6d) {
          if(level.contentmanager.var_1fcbdf50 === var_a2593226) {
            var_e7f5b3e0 = 0;
            break;
          }
        }
      }

      if(var_e7f5b3e0) {
        if(!isDefined(var_4a91da6d)) {
          var_4a91da6d = [];
        } else if(!isarray(var_4a91da6d)) {
          var_4a91da6d = array(var_4a91da6d);
        }

        var_4a91da6d[var_4a91da6d.size] = instance;
      }
    }
  }

  if(getdvarint(#"hash_730311c63805303a", 0)) {
    if(isDefined(level.var_fcb2823)) {
      foreach(instance in level.var_fcb2823) {
        if(isDefined(instance)) {
          content_manager::spawn_instance(instance);
        }
      }
    }

    return;
  }

  instance = array::random(var_4a91da6d);

  if(isDefined(instance)) {
    content_manager::spawn_instance(instance);
  }
}

function function_685a8288(instance) {
  level endon(#"end_game");
  instance.var_422ae63e = # "p9_fxanim_mp_care_package_bundle";
  var_28bf3706 = instance.contentgroups[# "heli_spawn"][0];
  assert(isDefined(var_28bf3706.target), "<dev string:x38>");
  nd_start = getvehiclenode(var_28bf3706.target, "targetname");

  do {
    vh_heli = vehicle::spawn(undefined, "helicopter_escape_heli", #"hash_669d01ea5db4e10c", nd_start.origin, nd_start.angles);
    waitframe(1);
  }
  while(!isDefined(vh_heli));

  vh_heli setteam(level.zombie_team);
  vh_heli.health = function_a0861762(2500, 150000);
  vh_heli.maxhealth = vh_heli.health;
  vh_heli setmaxhealth(vh_heli.maxhealth);
  vh_heli callback::function_d8abfc3d(#"on_vehicle_killed", &function_36564c7c);
  vh_heli callback::function_d8abfc3d(#"on_vehicle_damage", &function_2a05a8c6);
  vh_heli thread function_90bceefd();
  vh_heli makevehicleunusable();
  vh_heli setrotorspeed(1);
  vh_heli setdrawinfrared(1);
  vh_heli setseatoccupied(0, 1);
  target_set(vh_heli);
  vh_heli setforcenocull();
  vh_heli vehicle::toggle_tread_fx(1);
  vh_heli vehicle::toggle_sounds(1);
  vh_heli.b_ignore_fow_damage = 1;
  vh_heli.var_1b9f096d = 1;
  vh_heli.var_ac1388df = 1;

  if(!issentient(vh_heli)) {
    vh_heli makesentient();
  }

  if(util::get_map_name() === # "wz_sanatorium") {
    vh_heli vehicle::toggle_lights_group(3, 1);
    vh_heli turretsettargetangles(0, (0, 0, 0));
  }

  level.var_e1011305 = level.var_b48509f9;
  namespace_cf6efd05::function_c484a9be(#"hash_3d1c462f6d4757c2", level.var_e1011305);
  level thread helicopter::function_eca18f00(vh_heli, #"hash_5793213ec26a2aa5");
  vh_heli.instance = instance;

  if(instance.targetname === "helicopter_escape_dune_instance_3") {
    var_28bf3706.radius = 2500;
  }

  if(isDefined(var_28bf3706.radius) && var_28bf3706.radius > 0) {
    var_deaf3fc0 = var_28bf3706.origin;
    var_6fb21416 = var_28bf3706.radius;
  } else {
    var_deaf3fc0 = vh_heli getcentroid();
    var_6fb21416 = 4000;
  }

  while(true) {
    var_be19a72a = 0;

    foreach(player in function_a1ef346b()) {
      if(isDefined(player) && isDefined(vh_heli) && isDefined(var_deaf3fc0) && (vh_heli.health < vh_heli.maxhealth || distance(player.origin, var_deaf3fc0) <= var_6fb21416)) {
        var_be19a72a = 1;
        break;
      }
    }

    if(level.contentmanager.activeobjective.content_script_name === "holdout") {
      wait 0.5;
      continue;
    }

    if(var_be19a72a) {
      break;
    }

    wait 0.5;
  }

  if(!isDefined(vh_heli)) {
    return;
  }

  if(!isDefined(vh_heli.e_crate)) {
    vh_heli.e_crate = function_974be700(vh_heli.origin, vh_heli.angles, instance);
  }

  if(vh_heli.e_crate clientfield::is_registered("perk_death_perception_item_marked_for_rob")) {
    vh_heli.e_crate clientfield::set("perk_death_perception_item_marked_for_rob", 1);
  }

  if(!isalive(vh_heli)) {
    return;
  }

  level thread zm_vo::function_7622cb70(#"hash_37d8017a04a1565d", 2);
  vh_heli thread scene::play(#"p9_fxanim_wz_parachute_supplydrop_01_harness_bundle", "fly_in");
  vh_heli vehicle::get_on_and_go_path(nd_start);
  waitframe(1);

  if(isalive(vh_heli)) {
    vh_heli function_71b5509(1);
  }
}

function function_90bceefd() {
  if(!is_true(level.var_53bc31ad)) {
    return;
  }

  self endon(#"death");

  while(true) {
    level waittill(#"hash_6a805bca389d1daf");
    var_b212a8a9 = self.health / self.maxhealth;
    var_c835c552 = function_a0861762(2500, 150000);

    if(isDefined(var_c835c552) && var_c835c552 > self.maxhealth) {
      self.maxhealth = int(var_c835c552);
      self setmaxhealth(self.maxhealth);
      self setnormalhealth(var_b212a8a9);
    }
  }
}

function function_a0861762(n_health_min, n_health_max) {
  var_6499d1fb = zm_utility::function_e3025ca5();

  if(var_6499d1fb < 1) {
    var_6499d1fb = 1;
  } else if(var_6499d1fb > 10) {
    var_6499d1fb = 10;
  }

  n_percent = 1 - (10 - var_6499d1fb) / 9;

  if(n_percent < 0) {
    n_percent = 0;
  } else if(n_percent > 1) {
    n_percent = 1;
  }

  n_players = getplayers().size;

  if(n_players < 1) {
    n_players = 1;
  } else if(n_players > 4) {
    n_players = 4;
  }

  var_1bb081d7 = 1 + (n_players - 1) * 0.5;

  if(n_health_min < n_health_max) {
    var_c835c552 = int(lerpfloat(n_health_min, n_health_max, n_percent) * var_1bb081d7);
  } else {
    var_c835c552 = int(n_health_min * var_1bb081d7);
  }

  return var_c835c552;
}

function function_36564c7c(params) {
  self function_71b5509(0);

  if(namespace_d0ab5955::function_3824d2dc(self.origin)) {
    foreach(player in getplayers()) {
      player zm_stats::increment_challenge_stat(#"hash_46e6329f4b3c275d");
    }

    level thread zm_vo::function_7622cb70(#"hash_447deedfb079840a", 2);
    self drop_crate(self.instance);
    return;
  }

  if(isDefined(self.e_crate)) {
    self.e_crate delete();
  }
}

function function_be51796c(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  damage = vpoint;

  if(is_true(self.var_ac1388df)) {
    if(isDefined(vdamageorigin) && isPlayer(var_fd90b0bb) && shitloc !== "MOD_AAT") {
      if(vdamageorigin.offhandslot === "Tactical grenade" || vdamageorigin.offhandslot === "Lethal grenade" || vdamageorigin.offhandslot === "Special" || killstreaks::is_killstreak_weapon(vdamageorigin)) {
        if(!zm_equipment::function_4f51b6ea(vdamageorigin, shitloc) && !is_true(self.var_88bc9ca8) && shitloc !== "MOD_MELEE") {
          damage = zm_equipment::function_739fbb72(damage, vdamageorigin, #"elite", self.maxhealth);
        }

        if(killstreaks::is_killstreak_weapon(vdamageorigin)) {
          damage *= 0.5;

          if(vdamageorigin.firetype === "Minigun") {
            damage *= 0.75;
          }
        } else {
          damage *= 0.1;
        }
      }

      item = var_fd90b0bb item_inventory::function_230ceec4(vdamageorigin);

      if(isDefined(item)) {
        var_528363fd = self namespace_b61a349a::function_b3496fde(weapon, var_fd90b0bb, damage, vdir, shitloc, vdamageorigin, damagefromunderneath, modelindex, partname, vsurfacenormal);
        damage += var_528363fd;

        if(shitloc != "MOD_MELEE") {
          var_4d1602de = zm_weapons::function_d85e6c3a(item.itementry);
          damage *= var_4d1602de;

          if(isDefined(item.paplv)) {
            var_645b8bb = zm_weapons::function_896671d5(item.itementry.weapon, item.paplv);
            damage *= var_645b8bb;
          }
        }
      } else {
        var_fd72ea28 = self namespace_b61a349a::function_b3496fde(weapon, var_fd90b0bb, damage, vdir, shitloc, vdamageorigin, damagefromunderneath, modelindex, partname, vsurfacenormal);
        damage += var_fd72ea28;
      }

      if(zm_weapons::is_wonder_weapon(vdamageorigin)) {
        if(shitloc === "MOD_PROJECTILE_SPLASH") {
          damage = 0;
        } else {
          if(vdamageorigin.name === # "ww_ieu_plasma_t9" || vdamageorigin.name === # "ww_ieu_plasma_t9_upgraded") {
            damage = self namespace_b376a999::function_fd195372(weapon, var_fd90b0bb, damage, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
          } else if(vdamageorigin.name === # "ww_ieu_gas_t9" || vdamageorigin.name === # "ww_ieu_gas_t9_upgraded") {
            damage *= 0.1;
          }

          damage *= 0.3;
        }
      }
    }
  }

  return int(damage);
}

function function_71b5509(b_delete = 0) {
  self setrotorspeed(0);
  self scene::stop(1);

  if(isDefined(self.n_obj_id)) {
    self.n_obj_id = zm_utility::function_bc5a54a8(self.n_obj_id);
    self.n_obj_id = undefined;
  }

  self vehicle::get_off_path();
  self helicopter::function_711c140b();

  if(b_delete) {
    if(isDefined(self.e_crate)) {
      self.e_crate delete();
    }

    self thread zm_utility::function_78e620d();
    return;
  }

  self thread util::delay(2.7, "death", &delete);
}

function function_2a05a8c6(params) {
  if(isPlayer(params.eattacker) && isDefined(params.vpoint) && isDefined(params.idamage)) {
    if(params.idamage > 0) {
      hud::function_c9800094(params.eattacker, params.vpoint, params.idamage, 1);
      return;
    }

    hud::function_c9800094(params.eattacker, params.vpoint, 0, 4);
  }
}

function function_974be700(v_origin, v_angles, instance) {
  crate = content_manager::spawn_script_model(instance, #"wpn_t9_streak_care_package_friendly_world", 1, 1);
  crate dontinterpolate();
  crate.origin = v_origin;
  crate.angles = v_angles;
  instance.scriptmodel = crate;
  crate.weapon = getweapon(#"supplydrop_zm");
  crate setweapon(crate.weapon);
  crate function_619a5c20();
  return crate;
}

function drop_crate(instance, var_f9972216, var_f16f4b37) {
  var_a53bb2cc = isDefined(var_f9972216) ? var_f9972216 : self.origin;
  var_55ab02db = isDefined(var_f16f4b37) ? var_f16f4b37 : self.angles;

  if(!isDefined(self.e_crate)) {
    self.e_crate = function_974be700(var_a53bb2cc, var_55ab02db, instance);
  }

  self playSound(#"veh_supply_drop");
  mask = 1 | 4;
  radius = 30;
  trace = physicstrace(self.e_crate.origin + (0, 0, -100), self.e_crate.origin + (0, 0, -10000), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);
  v_target_location = trace[# "position"];
  var_3a68f655 = distance(self.e_crate.origin, v_target_location);
  n_drop_time = mapfloat(0, 1000, 1, 10, var_3a68f655);

  if(getdvarint(#"hash_6f70975791322a26", 0)) {
    self.e_crate.n_obj_id = zm_utility::function_f5a222a8(#"hash_550113857d521cf0", self.e_crate);
  }

  self.e_crate thread cratecontrolleddrop(instance, v_target_location, n_drop_time);
}

function cratecontrolleddrop(instance, v_target_location, n_drop_time = 10, var_72886e11) {
  crate = self;
  crate endon(#"death");
  params = spawnStruct();

  if(!isDefined(params.ksthrustersoffheight)) {
    params.ksthrustersoffheight = 100;
  }

  params.kstotaldroptime = isDefined(n_drop_time) ? n_drop_time : 10;

  if(!isDefined(params.ksacceltimepercentage)) {
    params.ksacceltimepercentage = 0.65;
  }

  if(!isDefined(params.var_827e3209)) {
    params.var_827e3209 = # "hash_3aa3ac8dc366dcf1";
  }

  crate thread watchforcratekill(v_target_location[2] + 200);
  crate thread update_crate_velocity();
  var_ae4c0bf9 = isDefined(level.var_947cc86b) ? level.var_947cc86b : params.ksthrustersoffheight;
  target = (v_target_location[0], v_target_location[1], v_target_location[2] + var_ae4c0bf9);
  var_c65d6e50 = 1;

  if(isDefined(var_72886e11) && var_72886e11 >= target[2]) {
    var_c65d6e50 = 0;
  }

  if(!is_true(level.var_2e93cff2) && var_c65d6e50) {
    var_cc6645da = params.ksacceltimepercentage;
    acceltime = params.kstotaldroptime * var_cc6645da;
    deceltime = is_true(params.var_f03a1094) ? params.kstotaldroptime - acceltime : 0;
    hostmigration::waittillhostmigrationdone();
    crate moveto(target, params.kstotaldroptime, acceltime, deceltime);
    crate thread function_2defd397();
    wait acceltime;

    if(!is_true(crate.pop_parachute)) {
      crate waittill(#"movedone", #"pop_parachute");
    }

    hostmigration::waittillhostmigrationdone();
  }

  crate thread cratephysics(instance);
  failsafetime = gettime() + 3000;

  while(distancesquared(crate.origin, v_target_location) > 100) {
    waitframe(1);

    if(gettime() >= failsafetime) {
      break;
    }
  }

  if(isDefined(params.var_827e3209)) {
    trace = groundtrace(crate.origin + (0, 0, 70), crate.origin + (0, 0, -100), 0, crate);
    var_2122d2eb = crate getfxfromsurfacetable(params.var_827e3209, trace[# "surfacetype"]);

    if(isDefined(var_2122d2eb)) {
      fxforward = trace[# "normal"];

      if(fxforward == (0, 0, 0)) {
        fxforward = (0, 0, 1);
      }

      playFX(var_2122d2eb, trace[# "position"], fxforward);
      self playSound(#"phy_impact_supply");
    }
  }
}

function update_crate_velocity() {
  self endon(#"death", #"stationary");
  self.velocity = (0, 0, 0);
  self.old_origin = self.origin;

  while(isDefined(self)) {
    self.velocity = self.origin - self.old_origin;
    self.old_origin = self.origin;
    waitframe(1);
  }
}

function cratephysics(instance) {
  self endon(#"death");
  self physicslaunch(self.origin, (0, 0, -1));
  self thread timeoutcratewaiter();
  self waittill(#"stationary");
  self.trigger = content_manager::spawn_interact(instance, &function_f7155f4f, #"hash_b1847d899d481cd", undefined, 96);
  self.trigger.origin = self.origin;
  self.trigger.angles = self.angles;
  self.trigger.struct = instance;
  self.trigger.var_cc1fb2d0 = # "sr_helicopter_escape_resource_list";
  self function_d2d0a813();
}

function function_f7155f4f(params) {
  e_crate = self.struct.scriptmodel;
  e_crate.var_11428995 = (0, 90, 0);
  self namespace_58949729::function_8665f666(params);
  e_crate thread function_960ea519(params.activator);
}

function function_960ea519(owner) {
  if(isDefined(self.var_46e0d8c8)) {
    playsoundatposition(self.var_46e0d8c8, self.origin);
  }

  bundle = getscriptbundle(#"killstreak_supply_drop_zm");
  detonationdelay = bundle.var_18d14afd;
  self thread function_71c8970c(0.84);
  wait detonationdelay;

  if(isDefined(self)) {
    self function_345ada65(owner);
  }

  if(isDefined(self.n_obj_id)) {
    self.n_obj_id = zm_utility::function_bc5a54a8(self.n_obj_id);
    self.n_obj_id = undefined;
  }

  if(isDefined(self)) {
    self cratedelete(1);
  }
}

function function_345ada65(attacker) {
  bundle = getscriptbundle(#"killstreak_supply_drop_zm");

  if(isDefined(bundle.var_b768b86b)) {
    trace = groundtrace(self.origin + (0, 0, 10), self.origin + (0, 0, -10), 0, self);
    explosionfx = self getfxfromsurfacetable(bundle.var_b768b86b, trace[# "surfacetype"]);

    if(isDefined(explosionfx)) {
      playFX(explosionfx, self.origin, anglestoup(self.angles), anglestoright(self.angles));
    }
  }

  if(isDefined(self.var_f2f6db96)) {
    playFX(self.var_f2f6db96, self.origin, anglestoup(self.angles), anglestoright(self.angles));
  }

  if(isDefined(self.var_30dd81f6)) {
    playsoundatposition(self.var_30dd81f6, self.origin);
  }

  if(isDefined(bundle.var_3f41a92c)) {
    playrumbleonposition(bundle.var_3f41a92c, self.origin);
  }

  playsoundatposition(#"wpn_frag_explode", self.origin);

  if(isPlayer(attacker)) {
    a_enemies = attacker getenemiesinradius(self.origin, 256);

    foreach(ai in a_enemies) {
      if(isalive(ai)) {
        ai dodamage(200, self.origin, attacker, undefined, "none", "MOD_EXPLOSIVE", 0, getweapon(#"supplydrop"));
      }
    }
  }
}

function function_71c8970c(interval) {
  self endon(#"death");

  if(isDefined(self.var_d3256432)) {
    playsoundatposition(self.var_d3256432, self.origin);
  }

  while(true) {
    if(!isDefined(self.var_d3256432)) {
      playsoundatposition("wpn_semtex_alert", self.origin);
    }

    playFXOnTag(#"hash_73dda66347b73ddd", self, "tag_fx_01");
    playFXOnTag(#"hash_73dda66347b73ddd", self, "tag_fx_02");
    playFXOnTag(#"hash_73dda66347b73ddd", self, "tag_fx_03");
    playFXOnTag(#"hash_73dda66347b73ddd", self, "tag_fx_04");
    playFXOnTag(#"hash_3e6e2a2df9fd889", self, "tag_body");
    wait interval;
    interval /= 1.2;

    if(interval < 0.08) {
      break;
    }
  }
}

function timeoutcratewaiter() {
  self endon(#"death", #"stationary");
  wait 20;
  self cratedelete(1);
}

function cratedelete(drop_all_to_ground = 1) {
  if(!isDefined(self)) {
    return;
  }

  if(drop_all_to_ground) {}

  if(isDefined(self.parachute)) {
    self.parachute delete();
  }

  self function_9813d292();
  self deletedelay();
}

function function_d2d0a813() {
  var_3b0688ef = "supply_drop_badplace" + self getentitynumber();
  origin = self.origin + self getboundsmidpoint();
  halfsize = self getboundshalfsize();
  var_921c5821 = max(halfsize[0], halfsize[1]) + 4;
  halfsize = (var_921c5821, var_921c5821, halfsize[2] + 4);
  badplace_box(var_3b0688ef, 0, origin, halfsize, "all");
}

function private function_9813d292() {
  if(isDefined(self)) {
    badplace_delete("supply_drop_badplace" + self getentitynumber());
  }
}

function function_4bf116ab(ents) {
  if(isDefined(self.e_crate)) {
    self.e_crate linkto(ents[# "harness"], "tag_care_package", (0, 0, 0), (0, 0, 0));
  }
}

function function_2842c984(ents) {
  if(isDefined(self.crate)) {
    self.crate delete();
  }
}

function function_76b49bd8(ents) {
  ents[# "parachute"] clientfield::set("supply_drop_parachute_rob", 1);
  self.parachute = ents[# "parachute"];
}

function function_2defd397() {
  self endon(#"death");
  self scene::play(#"p9_fxanim_wz_parachute_supplydrop_01_bundle", "open");
  self thread scene::play(#"p9_fxanim_wz_parachute_supplydrop_01_bundle", "idle");
  self waittill(#"movedone");
  self scene::stop(#"p9_fxanim_wz_parachute_supplydrop_01_bundle");
  self.parachute thread scene::play(#"p9_fxanim_wz_parachute_supplydrop_01_bundle", "detach", self.parachute);
  wait 1;

  if(isDefined(self.parachute)) {
    self.parachute clientfield::set("supply_drop_parachute_rob", 0);
  }
}

function watchforcratekill(start_kill_watch_z_threshold) {
  crate = self;
  crate endon(#"death", #"stationary");

  while(crate.origin[2] > start_kill_watch_z_threshold) {
    waitframe(1);
  }

  stationarythreshold = 1;
  killthreshold = 0.2;
  maxframestillstationary = 10;
  numframesstationary = 0;

  while(true) {
    vel = 0;

    if(isDefined(self.velocity)) {
      vel = abs(self.velocity[2]);
    }

    if(vel > killthreshold) {
      crate is_touching_crate();
      crate is_clone_touching_crate();
    }

    if(vel < stationarythreshold) {
      numframesstationary++;
    } else {
      numframesstationary = 0;
    }

    if(numframesstationary >= maxframestillstationary) {
      break;
    }

    waitframe(1);
  }
}

function is_touching_crate() {
  if(!isDefined(self)) {
    return;
  }

  crate = self;
  players = getplayers();
  crate_bottom_point = self.origin;

  foreach(player in level.players) {
    if(!isentity(player)) {
      continue;
    }

    if(isDefined(player) && isalive(player)) {
      stance = player getstance();
      stance_z_offset = stance == "crouch" ? 55 : stance == "stand" ? 75 : 15;
      player_test_point = player.origin + (0, 0, stance_z_offset);
      var_f6f95bb5 = distance2dsquared(player_test_point, self.origin);
      zvel = self.velocity[2];

      if(var_f6f95bb5 < 2500 && player_test_point[2] > crate_bottom_point[2]) {
        attacker = isDefined(self.owner) ? self.owner : self;
        player dodamage(player.health + 1, player.origin, attacker, self, "none", "MOD_HIT_BY_OBJECT", 0, getweapon(#"supplydrop"));
        player playSound(#"mpl_supply_crush");
        player playSound(#"phy_impact_supply");
      }
    }
  }

  self is_equipment_touching_crate();
  vehicles = getEntArray("script_vehicle", "classname");

  foreach(vehicle in vehicles) {
    if(isvehicle(vehicle)) {
      if(isDefined(vehicle.archetype) && vehicle.archetype == "wasp") {
        if(crate istouching(vehicle, (2, 2, 2))) {
          vehicle notify(#"sentinel_shutdown");
        }
      }
    }
  }
}

function is_clone_touching_crate() {
  if(!isDefined(self)) {
    return;
  }

  extraboundary = (10, 10, 10);
  actors = getactorarray();

  for(i = 0; i < actors.size; i++) {
    if(isDefined(actors[i]) && isDefined(actors[i].isaiclone) && isalive(actors[i]) && actors[i].origin[2] < self.origin[2] && self istouching(actors[i], extraboundary)) {
      attacker = isDefined(self.owner) ? self.owner : self;
      actors[i] dodamage(actors[i].health + 1, actors[i].origin, attacker, self, "none", "MOD_HIT_BY_OBJECT", 0, getweapon(#"supplydrop"));
      actors[i] playSound(#"mpl_supply_crush");
      actors[i] playSound(#"phy_impact_supply");
    }
  }
}

function is_equipment_touching_crate() {
  entities = getdamageableentarray(self.origin, 100);

  foreach(entity in entities) {
    if(!isentity(entity)) {
      continue;
    }

    if(isPlayer(entity)) {
      continue;
    }

    if(!isalive(entity)) {
      continue;
    }

    if(!entity istouching(self, (10, 10, 10))) {
      continue;
    }

    if(isDefined(entity.detonated)) {
      damage = 100;
    } else {
      damage = entity.health * 2;
    }

    entity dodamage(damage, self.origin, self.owner, self, 0, "MOD_UNKNOWN", 0, getweapon(#"supplydrop"));
  }
}