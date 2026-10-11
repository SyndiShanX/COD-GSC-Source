/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_a7e2df121c70d22.gsc
************************************************/

#using script_4919201dc1ccf0af;
#using script_60145ee124b1cbd1;
#using script_7bebd3732896bc0c;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\cap;
#using scripts\common\create_script_utility;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_build;
#using scripts\common\vehicle_paths;
#using scripts\engine\math;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\ai;
#using scripts\sp\anim;
#using scripts\sp\friendlyfire;
#using scripts\sp\maps\sp_jup_gunship\sp_jup_gunship_create_script;
#using scripts\sp\player_death;
#using scripts\sp\spawner;
#using scripts\sp\starts;
#using scripts\sp\utility;
#using scripts\vehicle\vehicle_common;
#namespace namespace_6393a86f2fcda776;

function precache() {
  precachemodel("jup_urz_military_airstrip_suniform25_jet_01_air");
  precachemodel("veh9_mil_air_halfa_turret");
  precachemodel("veh9_mil_air_heli_medium_weapon_platform");
  precacheshader("icon_waypoint_overlay_marker_friendly_small");
  precacheshader("icon_waypoint_overlay_marker_special");
  precacheshader("icon_waypoint_overlay_marker_enemy_small");
  precacheshader("icon_waypoint_overlay_marker_neutral_small");

  if(!utility::flag("testMap") && !utility::flag("cineMap")) {
    precachemodel("veh9_mil_lnd_tank_cougar_turret_dst");
    precachemodel("veh9_mil_lnd_tank_cougar_turret_gun_dst");
    precachemodel("veh9_mil_lnd_tank_cougar_x_vehphys_hsk_sp");
    precachemodel("misc_wm_mortar_shell");
    precachemodel("box_wooden_grenade_01");
    precachemodel("misc_wm_mortar");
    initvehicles();
  }

  utility::post_load_precache(&function_f85e8d251873f51);
  utility::add_hint_string("tower_ammo", &"SP_JUP_GUNSHIP/TOWER_AMMO", &function_3a86f5e46cc2115f);
}

function function_3a86f5e46cc2115f() {
  return namespace_fd9c6daa1372e62b::function_f0d33fba32bd4dc2();
}

function function_67d9968de909c242() {
  level.dopickyautosavechecks = 0;
  function_80e1f4a3b2dcbb5a();
  level.special_autosavecondition = &function_ca33c88307187819;
  setsaveddvar(@ "waypointtweaky", -6);
  level.var_2825cd44d4091ad3 = &function_4d1676e7b981b219;
  thread function_8cc4525cfcf7b932();
  thread function_3f6146304bdf60cf();
  thread function_f72e5af3b962706c();
  level.player lerpfovscalefactor(0, 0);
  namespace_fd9c6daa1372e62b::function_7368a9e3c4ab6a56();

  if(!utility::flag("testMap")) {
    setup_create_script();
  }

  if(!utility::flag("cineMap")) {
    thread function_394c6ac7fb7ea4b2();
  }

  if(!utility::flag("cineMap") && !utility::flag("testMap")) {
    function_537ac7b4892d3375();
  }

  function_5adb5b792f577e57();
  function_45d4a9b3b8bad917();

  if(!utility::flag("cineMap") && !utility::flag("testMap")) {
    function_180d216b6eb33966();
  }

  level.is_dark = 0;
  level.nightmap = 0;
  level.player.ignoreme = 1;
  level.contents_override = trace::create_contents(0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0);
  level.var_7d8d2c98080e2463 = trace::create_contents(0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0);
  level.var_d549c7ee95210689 = trace::create_contents(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  level.var_7355e8d4cd2e6b00 = trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
  level.var_2470353b1ec44c3b = trace::create_contents(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  level.var_a11927e751b21f00["gunship_40mm_jup_sp"] = squared(300);
  level.var_a11927e751b21f00["gunship_25mm_jup_sp"] = squared(150);
  level.var_a11927e751b21f00["gunship_hellfire_jup_sp"] = squared(500);
  level.var_a11927e751b21f00["gunship_hellfire_jup_sp"] = squared(500);
  var_c11475a64e25b066 = getEnt("hangar_1_doorClip", "targetname");

  if(isDefined(var_c11475a64e25b066)) {
    var_c11475a64e25b066 connectpaths();
  }

  var_c11474a64e25ae33 = getEnt("hangar_2_doorClip", "targetname");

  if(isDefined(var_c11474a64e25ae33) && !starts::is_after_start("hangar")) {
    var_c11474a64e25ae33 connectpaths();
  }

  function_b0372a5e9425d484();
  rig = getEnt("gunship_ambush_rig", "targetname");

  if(isDefined(rig)) {
    rig hide();
  }

  thread function_ba5d6178a029ed06();
}

function function_492423719e930fd3() {
  level endon("stopPlayerAdsForMarkers");

  for(;;) {
    ads = self playerads();

    if(ads == 0) {
      if(getdvarint(@ "waypointtweaky", -17) != -6) {
        function_a4f7ba625ec909ed(-7);
      }
    } else if(getdvarint(@ "waypointtweaky", -17) != -12) {
      function_a4f7ba625ec909ed(-12);
    }

    waitframe();
  }
}

function function_a4f7ba625ec909ed(value) {
  self endon("ads_pressed");
  self endon("ads_released");
  lerp_saveddvar(@ "waypointtweaky", value, 0.3);
}

function function_180d216b6eb33966() {
  level.var_3d46d336a141ee7 = [];
  volume1 = getEnt("runway_1_volume", "targetname");
  volume2 = getEnt("runway_2_volume", "targetname");

  if(isDefined(volume1) && isDefined(volume2)) {
    thread function_b05047ef7de716c1(volume1, volume2);
  }
}

function function_b05047ef7de716c1(volume1, volume2) {
  for(;;) {
    ents = array_combine(level.var_3d46d336a141ee7, level.vehicle.husks);
    ents = array_removeundefined(ents);

    foreach(ent in ents) {
      if(!istrue(ent.var_db9d635cd4ffb9e2) && (ent istouching(volume1) || ent istouching(volume2))) {
        ent childthread function_3082ef5ef6982618(volume1, volume2);
      }
    }

    wait 1;
  }
}

function function_3082ef5ef6982618(volume1, volume2) {
  self.var_db9d635cd4ffb9e2 = 1;
  self endon("death");
  self endon("entitydeleted");
  self notify("clearRunwayThread");
  self endon("clearRunwayThread");

  if(vehicle::isvehicle()) {
    while(self vehicle_getspeed() > 1) {
      waitframe();
    }
  }

  while(function_62b8bb40735c58a2(ter_op(level.player utility::isads(), 0.992546, 0.965926), self.origin + (0, 0, 100), [self])) {
    wait 0.1;
  }

  if(self istouching(volume1) || self istouching(volume2)) {
    self notify("runwayDelete");
    self delete();
  }
}

function function_80e1f4a3b2dcbb5a() {
  ents = getEntArray("boss_crash_site", "targetname");

  if(isDefined(ents)) {
    ents = array_sort_by_script_index(ents);

    foreach(ent in ents) {
      ent hide();
    }

    level.var_51bc360da2215ba8 = ents;
  }
}

function private function_537ac7b4892d3375() {
  sam_base = getEnt("sam_site_base", "targetname");
  sam_top = getEnt("sam_site_top", "targetname");
  sam_base thread delete_on_death(sam_top);
  sam_top.sam_missiles = getEntArray("sam_site_missiles", "targetname");
  sam_top.sam_missiles = array_sort_by_script_index(sam_top.sam_missiles);

  foreach(missile in sam_top.sam_missiles) {
    missile.script_origin = getEnt(missile.target, "targetname");
    missile.script_origin linkTo(sam_top);
    sam_base thread delete_on_death(missile.script_origin);
    missile linkTo(sam_top);
    sam_base thread delete_on_death(missile);
    missile notsolid();
  }

  level.sam_site = sam_base;
  thread function_7da467e440b7da32(sam_base, sam_top);
}

function function_7da467e440b7da32(sam_base, sam_top) {
  if(!starts::is_after_start("push_1")) {
    sam_base.health = 99999;
    sam_base setCanDamage(1);
    sam_base setCanRadiusDamage(1);
    i = 0;

    for(;;) {
      sam_base waittill("damage", damage, attacker, direction_vec, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin);
      sam_base.health += damage;
      i++;

      if(!isPlayer(attacker) || function_fc4d7033e4b94c37(objweapon)) {
        if(flag("sam_site_start") && (i == 1 || i == 15)) {
          thread utility::display_hint("tower_ammo", 10, 0.2);
        }
      } else {
        playFX(utility::getfx("vfx_sam_exp"), sam_base.origin);
        break;
      }

      waitframe();
    }
  }

  utility::flag_set("sam_site_dead");
  wait 0.2;
  function_e57fc58ce189fa88(3);
  sam_base delete();
}

function function_fc4d7033e4b94c37(objweapon) {
  return !isDefined(objweapon) || !isDefined(objweapon.basename) || objweapon.basename == "gunship_40mm_jup_sp" || objweapon.basename == "gunship_25mm_jup_sp";
}

function function_9094567c9547a9cc(var_3bfd0b4cf2b734f5, rotatetime, lockon, postdelay) {
  while(isDefined(level.cruise_missile)) {
    waitframe();
  }

  target = level.gunship.model_ent;
  starttime = gettime();
  timeout = 20 + rotatetime;

  while(!utility::time_has_passed(starttime, timeout)) {
    targetangles = vectortoangles(target.origin - self.origin);
    self rotateTo((self.angles[0], targetangles[1], targetangles[2]), rotatetime);
    self waittill("rotatedone");

    if(isDefined(level.cruise_missile)) {
      continue;
    }

    start = var_3bfd0b4cf2b734f5.script_origin.origin;
    end = target.origin;
    end = trace::ray_trace_detail(start, end, [self, var_3bfd0b4cf2b734f5, var_3bfd0b4cf2b734f5.script_origin, target], level.var_7355e8d4cd2e6b00)["position"];
    dist = distance(start, end);

    if(dist >= 3000) {
      break;
    }

    wait 1;
  }

  wait 0.1;

  if(utility::flag("sam_site_dead")) {
    return;
  }

  self notsolid();
  missile = magicbullet("sp_jup_sidewinder_gs_fast", var_3bfd0b4cf2b734f5.script_origin.origin, target.origin);
  missile missile_settargetEnt(target);
  delaycall(0.5, &solid);
  level.var_d6d3568761e946c5 = missile;

  if(soundexists("weap_missile_launch_radio")) {
    level.player playSound("weap_missile_launch_radio");
  }

  if(istrue(lockon)) {
    missile.var_f09c10bf5b551381 = 1;
  }

  var_3bfd0b4cf2b734f5 hide();
  var_3bfd0b4cf2b734f5 childthread function_6a980191d318d9a8(lockon, missile, target);

  if(isDefined(postdelay)) {
    wait postdelay;
  }
}

function function_6a980191d318d9a8(lockon, missile, target) {
  if(lockon) {
    while(isDefined(missile)) {
      dist = distance(missile.origin, target.origin);

      if(dist <= 1000) {
        break;
      }

      waitframe();
    }

    if(!utility::flag("alreadyFailing") || !utility::flag("sam_site_dead")) {
      thread function_136da4be4ea59ef8(missile);
    }

    return;
  }

  function_25eadd19d87ff8f3(missile);
}

function private function_136da4be4ea59ef8(missile) {
  level.var_e2dedfef1129cd21 = undefined;
  level.gunship.model_ent thread namespace_fd9c6daa1372e62b::gunship_playfakebodyexplosion();

  if(soundexists("scn_gshp_missile_death_exp_lr")) {
    level.player utility::delaycall(0.3, &playsound, "scn_gshp_missile_death_exp_lr");
  } else if(soundexists("exp_gunship_hellfire_dist")) {
    level.player playSound("exp_gunship_hellfire_dist");
  }

  if(isDefined(missile)) {
    playFX(utility::getfx("jup_urz_military_airstrip_suniform25_jet_01_air_moving_death"), missile.origin);

    if(isvalidmissile(missile)) {
      missile detonate();
    }
  } else {
    playFX(utility::getfx("jup_urz_military_airstrip_suniform25_jet_01_air_moving_death"), level.gunship.model_ent.origin);
  }

  if(isDefined(missile)) {
    level.stinger_missiles = array_remove(level.stinger_missiles, missile);
    missile ent_flag("missile_pairedWithFlare");
  }

  wait 0.4;
  level.gunship.model_ent thread namespace_fd9c6daa1372e62b::gunship_crash(15, level.player);
  wait 1.5;
  player_death::clear_custom_death_quote();
  player_death::set_custom_death_quote(264);
  utility::missionfailedwrapper();
}

function function_de8d223394c3f136() {
  level.var_1250917a0280ae9 = array_removeundefined(level.var_1250917a0280ae9);
  return level.var_1250917a0280ae9;
}

function function_ca33c88307187819() {
  while(true) {
    good_checks = 0;

    for(i = 0; i < 5; i++) {
      projectile_array = function_de8d223394c3f136();

      if(projectile_array.size > 0 || good_checks >= 4) {
        break;
      }

      good_checks++;
      wait 0.2;
    }

    if(good_checks >= 4) {
      break;
    }

    waitframe();
  }

  return true;
}

function function_f72e5af3b962706c() {
  level waittill("missionfailed");
  level.player setclientomnvar("ui_hide_hud", 0);
  setomnvar("ui_out_of_bounds_countdown", 0);
  dialogue::function_54d3bd59bff7e908(1, 1);
  dialogue::function_a583984eb78c6c32();
  guys = getaiarray();

  foreach(guy in guys) {
    guy.vo_disable = 1;
  }

  level.player.vo_disable = 1;
}

function bunkerbuster() {
  return level.player fragButtonPressed();
}

function private function_f85e8d251873f51() {
  setdvarifuninitialized(@ "hash_f8011de88f9b444b", 0);
  setsaveddvar(@ "g_friendlynamedist", 50000);
  setsaveddvar(@ "hash_22867972949cadc9", 0);
  setsaveddvar(@ "hash_ac13115d967e741", 0);
  setsaveddvar(@ "hash_c7e8da906e7ee817", 0);
  setsaveddvar(@ "hash_9adfbedc4fb180eb", 0);
  setsaveddvar(@ "hash_2477e6b4b4709f83", 1);

  setdvarifuninitialized(@ "hash_b66bf35ec28c6c4c", 0);
  setdvarifuninitialized(@ "hash_ecfaff72ee0ed2b2", 0);

  setsaveddvar(@ "hash_dd65810f07ee369a", 1);
  setsaveddvar(@ "hash_b0b0387cc823f3e0", 0.939693);
  setsaveddvar(@ "hash_2d2615c35aabcb2b", 0.999391);
  noself_delaycall(0.15, &setsaveddvar, @ "hash_8fef9b7e4f880571", 0);
  delaythread(0.15, &utility::motion_blur_disable, 0);
}

function private setup_create_script() {
  utility::registersharedfunc("createScript", "typeCast", &function_d00366533b5a6ba7);
  level.starttimeutcseconds = gettime();
  create_script_utility::initialize_create_script();
  create_script_utility::init_create_script_for_level();
  create_script_utility::register_create_script_arrays("sp_jup_gunship_create_script", "sp_jup_gunship_create_script", level.scripted_spawner_func.size, &sp_jup_gunship_create_script::main);
  create_script_utility::initialize_registered_create_script_files();
}

function private function_d00366533b5a6ba7() {
  self.script_unload = function_26414a457247de63(self.script_unload, "int");
  self.script_wait_min = function_26414a457247de63(self.script_wait_min, "float");
  self.script_wait_max = function_26414a457247de63(self.script_wait_max, "float");
  self.script_wait_add = function_26414a457247de63(self.script_wait_add, "float");
  self.script_brake = function_26414a457247de63(self.script_brake, "float");
  self.var_9e5f6ca242b92628 = function_26414a457247de63(self.var_9e5f6ca242b92628, "int");
  self.lookahead = function_26414a457247de63(self.lookahead, "int");
  self.speed = function_26414a457247de63(self.speed, "int");
  self.var_3f0312e6382c878f = function_26414a457247de63(self.var_3f0312e6382c878f, "int");
  self.dont_enter_combat = function_26414a457247de63(self.dont_enter_combat, "int");
  self.script_goalradius = function_26414a457247de63(self.script_goalradius, "int");
  self.script_accel = function_26414a457247de63(self.script_accel, "int");
  self.script_decel = function_26414a457247de63(self.script_decel, "int");
  self.script_speed = function_26414a457247de63(self.script_speed, "float");
  self.script_goal_threshold = function_26414a457247de63(self.script_goal_threshold, "float");
  self.var_3efdd073323b953c = function_26414a457247de63(self.var_3efdd073323b953c, "int");
  self.script_goalyaw = function_26414a457247de63(self.script_goalyaw, "int");
  self.script_anglevehicle = function_26414a457247de63(self.script_anglevehicle, "int");
  self.script_delay = function_26414a457247de63(self.script_delay, "float");
  self.script_delay_min = function_26414a457247de63(self.script_delay_min, "float");
  self.script_delay_max = function_26414a457247de63(self.script_delay_max, "float");
  self.script_delay_post = function_26414a457247de63(self.script_delay_post, "float");
  self.script_ignoreme = function_26414a457247de63(self.script_ignoreme, "int");
  self.script_ignoreall = function_26414a457247de63(self.script_ignoreall, "int");
  self.script_death = function_26414a457247de63(self.script_death, "int");
  self.script_wait = function_26414a457247de63(self.script_wait, "float");
  self.script_forcespawn = function_26414a457247de63(self.script_forcespawn, "int");
  self.script_timer = function_26414a457247de63(self.script_timer, "int");
  self.script_count = function_26414a457247de63(self.script_count, "int");
  self.script_radius = function_26414a457247de63(self.script_radius, "int");
  self.script_escalation_level = function_26414a457247de63(self.script_escalation_level, "int");
  self.script_goalheight = function_26414a457247de63(self.script_goalheight, "int");
  self.script_timeout = function_26414a457247de63(self.script_timeout, "float");
  self.script_pacifist = function_26414a457247de63(self.script_pacifist, "int");
  self.dontkilloff = function_26414a457247de63(self.dontkilloff, "int");
  self.script_dot = function_26414a457247de63(self.script_dot, "int");
  self.script_stopnode = function_26414a457247de63(self.script_stopnode, "int");
  self.script_faceangles = function_26414a457247de63(self.script_faceangles, "int");
  self.script_cleanexit = function_26414a457247de63(self.script_cleanexit, "int");
  self.script_startinghealth = function_26414a457247de63(self.script_startinghealth, "int");
  self.script_suspend = function_26414a457247de63(self.script_suspend, "int");
  self.script_dist_only = function_26414a457247de63(self.script_dist_only, "int");
  self.script_delete = function_26414a457247de63(self.script_delete, "int");
  self.script_index = function_26414a457247de63(self.script_index, "int");
  return true;
}

function private function_26414a457247de63(value, type) {
  if(!isDefined(value) || !isstring(value)) {
    return value;
  }

  switch (type) {
    case #"hash_4730906c2f53f03e":
    case #"hash_7e95f72ed09f139d":
      if(value == "true") {
        return 1;
      }

      return int(value);
    case #"hash_3e4a6f464c850b65":
      return float(value);
    default:
      return value;
  }
}

function entcleanup(name) {
  ents = getEntArray(name, "targetname");
  utility::array_delete(ents);
  ents = getEntArray(name, "script_noteworthy");
  utility::array_delete(ents);
}

function function_a1c469a6498aa1a2(var_7013418f31f4f051, damagemodel) {
  assets = getscriptablearray(var_7013418f31f4f051, "script_noteworthy");

  foreach(asset in assets) {
    asset.damagemodel = damagemodel;
  }
}

function function_317cfc9477fa9f88(var_7013418f31f4f051, customsetupfunction, var_80dd8e31e981cdc7, customdeathfunction, damageenabled, hasdoors) {
  utility::flag_wait("scriptables_ready");

  setdvarifuninitialized(@ "hash_e2f4e022d2ad1821", 0);

  assets = getscriptablearray(var_7013418f31f4f051, "script_noteworthy");

  foreach(asset in assets) {
    if(!isDefined(asset.targetname)) {
      println("<dev string:x1c>" + asset.model + "<dev string:x24>" + asset.origin + "<dev string:x2e>");
    }

    part_count = asset getscriptablepartcount();

    if(getdvarint(@ "hash_e2f4e022d2ad1821") == 1) {
      print3d(asset.origin + (0, 0, 200), asset.model + "<dev string:xb4>", undefined, undefined, undefined, 600);
    }

    if(part_count <= 1) {
      if(getdvarint(@ "hash_e2f4e022d2ad1821") == 1) {
        thread utility::draw_line_for_time(asset.origin, asset.origin + (0, 0, 500), 1, 0, 0, 30);
      }

      continue;
    }

    asset function_6b125200ae456cb1(part_count);
    asset.asset_info.damage_enabled = utility::default_to(damageenabled, 1);
    asset.asset_info.hasdoors = utility::default_to(hasdoors, 0);
    asset.asset_info.deathents = asset utility::get_linked_ents();

    if(isDefined(asset.asset_info.deathents) && asset.asset_info.deathents.size > 0) {
      asset.asset_info.building_clips = [];

      foreach(ent in asset.asset_info.deathents) {
        switch (ent.code_classname) {
          case #"hash_6318af6067faf262":
            if(ent.spawnflags != 0) {
              ent connectpaths();
            }

            ent.doorclips = ent utility::get_linked_ents();

            foreach(clip in ent.doorclips) {
              if(clip.spawnflags != 0) {
                clip connectpaths();
              }
            }

            asset.asset_info.building_clips[asset.asset_info.building_clips.size] = ent;
            break;
          case #"hash_3f216538c5e17ed0":
            asset.asset_info.building_volume = ent;
            break;
          default:
            break;
        }
      }
    }

    if(isDefined(customsetupfunction)) {
      asset[[customsetupfunction]]();
    }

    if(isDefined(customdeathfunction)) {
      asset.asset_info.var_c2a0dfbe04ae4b0c = customdeathfunction;
    }

    if(isDefined(var_80dd8e31e981cdc7)) {
      asset.asset_info.var_ba74b92aecdc75f3 = var_80dd8e31e981cdc7;
    }

    if(asset.asset_info.part_count > 1) {
      if(istrue(asset.asset_info.var_74b54244023fb696)) {
        if(getdvarint(@ "hash_e2f4e022d2ad1821") == 1) {
          thread utility::draw_line_for_time(asset.origin, asset.origin + (0, 0, 500), 1, 0, 1, 30);
        }

        asset thread doscriptablecleanup();
        continue;
      }

      if(getdvarint(@ "hash_e2f4e022d2ad1821") == 1) {
        thread utility::draw_line_for_time(asset.origin, asset.origin + (0, 0, 500), 0, 1, 0, 30);
      }

      asset thread scriptabledamagewatcher();
      continue;
    }

    if(getdvarint(@ "hash_e2f4e022d2ad1821") == 1) {
      thread utility::draw_line_for_time(asset.origin, asset.origin + (0, 0, 500), 1, 0, 0, 30);
    }
  }
}

function private function_6b125200ae456cb1(part_count) {
  self.asset_info = spawnStruct();

  if(isDefined(self.damagemodel)) {
    self.pristinemodel = self.model;
    self setModel(self.damagemodel);
  }

  self.asset_info.partnames = function_f8af58c361a605da();
  self.asset_info.parts_damaged = 0;
  self.asset_info.clip_range = 200;
  self.asset_info.value_package["damaged_amount"] = 0;
  self.asset_info.value_package["boneCount_hellfire"] = 8;
  self.asset_info.value_package["boneCount_40mm"] = 3;
  self.asset_info.value_package["boneCount_25mm"] = 2;
  self.asset_info.value_package["boneCount_rpg"] = 4;
  self.asset_info.value_package["boneCount_env"] = 2;
  self.asset_info.value_package["boneCount_turret"] = 2;
  self.asset_info.value_package["damageRange_hellfire"] = 800;
  self.asset_info.value_package["damageRange_40mm"] = 400;
  self.asset_info.value_package["damageRange_25mm"] = 200;
  self.asset_info.value_package["damageRange_rpg"] = 400;
  self.asset_info.value_package["damageRange_env"] = 500;
  self.asset_info.value_package["damageRange_turret"] = 400;
  self.asset_info.value_package["bulletMin_hellfire"] = 0;
  self.asset_info.value_package["bulletMin_40mm"] = 0;
  self.asset_info.value_package["bulletMin_25mm"] = 15;
  self.asset_info.value_package["bulletMin_rpg"] = 0;
  self.asset_info.value_package["bulletMin_env"] = 0;
  self.asset_info.value_package["bulletMin_turret"] = 0;
  self.asset_info.var_70865f2cdc241312 = 1;
  setup_parts = 0;

  foreach(part_name in self.asset_info.partnames) {
    if(!issubstr(part_name, "tag_")) {
      tag_name = "tag_" + part_name;
    } else {
      tag_name = part_name;
    }

    if(!self tagexists(tag_name)) {
      if(!issubstr(tag_name, "<dev string:xd1>")) {
        println("<dev string:x1c>" + self.model + "<dev string:x24>" + self.origin + "<dev string:xd6>" + tag_name + "<dev string:xfc>");
      }

      continue;
    }

    if(!self getscriptablehaspart(part_name)) {
      println("<dev string:x1c>" + self.model + "<dev string:x24>" + self.origin + "<dev string:x133>" + part_name + "<dev string:x14f>");
      continue;
    }

    if(!self getscriptableparthasstate(part_name, "dead")) {
      if(!issubstr(tag_name, "<dev string:x187>")) {
        println("<dev string:x1c>" + self.model + "<dev string:x24>" + self.origin + "<dev string:x133>" + part_name + "<dev string:x18e>");
      }

      continue;
    }

    setup_parts++;
    self.asset_info.part_objects[part_name] = spawnStruct();
    self.asset_info.part_objects[part_name].name = part_name;
    self.asset_info.part_objects[part_name].tag_name = tag_name;
    self.asset_info.part_objects[part_name].origin = self gettagorigin(tag_name);
    self.asset_info.part_objects[part_name].angles = self gettagangles(tag_name);
    self.asset_info.part_objects[part_name].state = "pristine";
    self.asset_info.part_objects[part_name].health = 0;
    self.asset_info.part_objects[part_name].var_75f6977603250653 = 0;
    self.asset_info.part_objects[part_name].var_17d2a2a24229dc42 = 0;
    self.asset_info.part_objects[part_name].hits_hellfire = 0;
    self.asset_info.part_objects[part_name].hits_rpg = 0;
  }

  if(isDefined(self.damagemodel)) {
    self setModel(self.pristinemodel);
  }

  self.asset_info.part_count = setup_parts;
}

function private function_f8af58c361a605da() {
  partnames = self function_90069777043e7833();
  namearray = [];

  foreach(partname in partnames) {
    if(!self getscriptableparthasstate(partname, "pristine") || !self getscriptableparthasstate(partname, "dead")) {
      if(getdvarint(@ "hash_e2f4e022d2ad1821") == 1) {
        println("<dev string:x1cf>" + self.model + "<dev string:x1d6>" + partname + "<dev string:x1de>");
      }

      continue;
    }

    namearray[namearray.size] = partname;
  }

  return namearray;
}

function private scriptabledamagewatcher() {
  self endon("kill_damage_thread");

  while(isDefined(self) && self.asset_info.value_package["damaged_amount"] < self.asset_info.part_count) {
    self waittill("damage", nill, attacker, nill, point, nill, nill, nill, nill, nill, objweapon);

    if(utility::flag("igc_start")) {
      continue;
    }

    if(isDefined(self.asset_info.var_ba74b92aecdc75f3)) {
      result = self[[self.asset_info.var_ba74b92aecdc75f3]](attacker, point, objweapon);

      if(istrue(result)) {
        continue;
      }
    }

    if(scriptabledamagefiltering(objweapon, attacker)) {
      continue;
    }

    function_1e00690d6a432ada(objweapon, point, attacker);
  }

  thread doscriptablecleanup();
}

function private scriptabledamagefiltering(objweapon, attacker) {
  if(!isDefined(objweapon)) {
    return false;
  }

  if(!istrue(self.asset_info.damage_enabled)) {
    return true;
  }

  if(utility::is_equal(attacker, self)) {
    return true;
  }

  if(attacker vehicle::isvehicle() && !istrue(attacker.bossheli)) {
    return true;
  }

  if(!istrue(self.asset_info.damager_any) && isai(attacker)) {
    return true;
  }

  return false;
}

function private function_1e00690d6a432ada(objweapon, point, attacker) {
  if(istrue(self.asset_info.forcedeath)) {
    thread doscriptablecleanup();
    return;
  }

  weaponname = "gunship_40mm_jup_sp";
  var_2bb85ce2f32a6931 = self.asset_info.value_package["boneCount_env"];
  weapon_range = self.asset_info.value_package["damageRange_env"];

  if(isDefined(objweapon) && isDefined(attacker) && !utility::is_equal(attacker.code_classname, "worldspawn")) {
    weaponname = objweapon.basename;

    if(utility::is_equal(weaponname, function_4f215795148a8c6d(1))) {
      var_2bb85ce2f32a6931 = self.asset_info.value_package["boneCount_40mm"];
      weapon_range = self.asset_info.value_package["damageRange_40mm"];
    } else if(utility::is_equal(weaponname, function_4f215795148a8c6d(2))) {
      var_2bb85ce2f32a6931 = self.asset_info.value_package["boneCount_25mm"];
      weapon_range = self.asset_info.value_package["damageRange_25mm"];
    } else if(utility::is_equal(weaponname, function_4f215795148a8c6d(3))) {
      var_2bb85ce2f32a6931 = self.asset_info.value_package["boneCount_hellfire"];
      weapon_range = self.asset_info.value_package["damageRange_hellfire"];
    } else if(utility::is_equal(weaponname, "sp_jup_sidewinder_gs_medium")) {
      var_2bb85ce2f32a6931 = self.asset_info.value_package["boneCount_rpg"];
      weapon_range = self.asset_info.value_package["damageRange_rpg"];
    } else if(attacker.code_classname == "misc_turret") {
      var_2bb85ce2f32a6931 = self.asset_info.value_package["boneCount_turret"];
      weapon_range = self.asset_info.value_package["damageRange_turret"];
    } else {
      var_2bb85ce2f32a6931 = self.asset_info.value_package["boneCount_40mm"];
      weapon_range = self.asset_info.value_package["damageRange_40mm"];
    }
  }

  max_range = weapon_range * 2;
  i = 0;
  part_objects = sortbydistancecullbyradius(self.asset_info.part_objects, point, max_range);

  foreach(part in part_objects) {
    if(!isPlayer(attacker) && !istrue(self.var_a0efcfe66ece0479)) {
      if(isDefined(self.var_18feb83b16a03c3a) && self.asset_info.parts_damaged >= self.var_18feb83b16a03c3a) {
        return;
      }
    }

    if(self getscriptableparthasstate(part.name, "disable") && utility::is_equal(self getscriptablepartstate(part.name, 1), "disable")) {
      if(istrue(self.asset_info.var_70865f2cdc241312)) {
        function_a695d5e29aada096("base", "dead", point);
      }

      self notify("kill_damage_thread");
      return;
    }

    dist = distance(part.origin, point);

    if(i >= var_2bb85ce2f32a6931) {
      if(getdvarint(@ "hash_e2f4e022d2ad1821") == 1) {
        thread utility::draw_line_for_time(point, part.origin, 1, 0, 0, 3);
      }

      break;
    }

    result = 0;

    if(isDefined(self.asset_info.var_6bbb9c25c7fa3634)) {
      result = self[[self.asset_info.var_6bbb9c25c7fa3634]](attacker, point, objweapon, part);
    }

    if(part.state == "pristine" && dist <= weapon_range) {
      if(utility::is_equal(weaponname, function_4f215795148a8c6d(1))) {
        if(part.var_17d2a2a24229dc42 < self.asset_info.value_package["bulletMin_40mm"]) {
          part.var_17d2a2a24229dc42++;
          continue;
        }
      } else if(utility::is_equal(weaponname, function_4f215795148a8c6d(2))) {
        if(part.var_75f6977603250653 < self.asset_info.value_package["bulletMin_25mm"]) {
          part.var_75f6977603250653++;
          continue;
        }
      } else if(utility::is_equal(weaponname, "sp_jup_sidewinder_gs_medium")) {
        if(part.hits_rpg < self.asset_info.value_package["bulletMin_rpg"]) {
          part.hits_rpg++;
          continue;
        }
      } else if(part.hits_hellfire < self.asset_info.value_package["bulletMin_hellfire"]) {
        part.hits_hellfire++;
        continue;
      }

      self.asset_info.parts_damaged++;
      self.asset_info notify("part_damaged", objweapon);

      if(istrue(result)) {
        continue;
      }

      if(isDefined(self.asset_info.building_volume)) {
        guys = self.asset_info.building_volume utility::get_ai_touching_volume("axis");
        guys = utility::array_removedead_or_dying(guys);

        foreach(guy in guys) {
          guy kill();
        }

        waitframe();
      }

      if(isDefined(self.asset_info.building_clips)) {
        self.asset_info.building_clips = utility::array_removeundefined(self.asset_info.building_clips);

        foreach(clip in self.asset_info.building_clips) {
          if(getdvarint(@ "hash_e2f4e022d2ad1821") == 1) {
            thread utility::draw_line_for_time(point, clip.origin, 0, 1, 1, 3);
          }

          if(isDefined(clip.doorclips)) {
            foreach(doorclip in clip.doorclips) {
              if(getdvarint(@ "hash_e2f4e022d2ad1821") == 1) {
                thread utility::draw_line_for_time(point, doorclip.origin, 0, 1, 1, 3);
              }

              if(doorclip.spawnflags != 0) {
                doorclip disconnectPaths();
                doorclip notsolid();
                continue;
              }

              doorclip delete();
            }
          }

          if(clip.spawnflags != 0) {
            clip disconnectPaths();
            clip notsolid();
            continue;
          }

          clip delete();
        }

        self.asset_info.building_clips = utility::array_removeundefined(self.asset_info.building_clips);
      }

      if(istrue(self.asset_info.var_70865f2cdc241312)) {
        function_a695d5e29aada096("base", "dead", point);
      }

      if(isDefined(self.asset_info.var_c2a0dfbe04ae4b0c)) {
        self[[self.asset_info.var_c2a0dfbe04ae4b0c]](objweapon, point, part, weapon_range);
      }

      part.state = "dead";
      self.asset_info.value_package["damaged_amount"]++;
      function_a695d5e29aada096(part.name, "dead", point);

      if(istrue(self.asset_info.hasdoors)) {
        doors = getentarrayinradius("interactive_door", "script_noteworthy", part.origin, max_range, 1);

        foreach(door in doors) {
          door hide();
        }
      }

      i++;
      continue;
    }

    if(getdvarint(@ "hash_e2f4e022d2ad1821") == 1) {
      thread utility::draw_line_for_time(point, part.origin, 1, 0, 0, 3);
    }
  }
}

function private function_4f215795148a8c6d(weaponindex) {
  if(isDefined(level.gunship)) {
    switch (weaponindex) {
      case 1:
        return level.gunship.var_d6604d5e3d0ba184;
      case 2:
        return level.gunship.var_d660505e3d0ba81d;
      case 3:
        return level.gunship.var_d6604f5e3d0ba5ea;
      default:
        return level.gunship.var_d6604f5e3d0ba5ea;
    }

    return;
  }

  switch (weaponindex) {
    case 1:
      return "gunship_40mm_jup_sp";
    case 2:
      return "gunship_25mm_jup_sp";
    case 3:
      return "gunship_hellfire_jup_sp";
    default:
      return "gunship_hellfire_jup_sp";
  }
}

function doscriptablecleanup() {
  self notify("kill_damage_thread");
  function_a695d5e29aada096("base", "dead");

  foreach(object in self.asset_info.part_objects) {
    function_a695d5e29aada096(object.name, "dead");
  }
}

function private function_a695d5e29aada096(part_name, state_name, point) {
  if(isDefined(self.asset_info.part_objects[part_name]) && self getscriptablehaspart(part_name)) {
    if(self getscriptableparthasstate(part_name, state_name) && !utility::is_equal(self getscriptablepartstate(part_name, 1), state_name)) {
      if(getdvarint(@ "hash_e2f4e022d2ad1821") == 1 && isDefined(point)) {
        thread utility::draw_line_for_time(point, self.asset_info.part_objects[part_name].origin, 0, 1, 0, 3);
      }

      self setscriptablepartstate(part_name, state_name, 0);
    }

    return;
  }

  if(part_name == "base") {
    if(self getscriptableparthasstate(part_name, state_name) && !utility::is_equal(self getscriptablepartstate(part_name, 1), state_name)) {
      if(getdvarint(@ "hash_e2f4e022d2ad1821") == 1 && isDefined(point)) {
        thread utility::draw_line_for_time(point, self.origin, 0, 1, 0, 3);
      }

      self setscriptablepartstate(part_name, state_name, 0);
    }
  }
}

function private function_9901f3939c71d9c8(var_dccea0b17b790aea, var_80dd8e31e981cdc7) {
  utility::flag_wait("scriptables_ready");
  structs = getStructArray(var_dccea0b17b790aea, "script_noteworthy");

  foreach(struct in structs) {
    towers = getscriptablearray(struct.target, "targetname");
    ents = getEntArray(struct.target, "targetname");
    clips = utility::array_remove_array(ents, towers);

    foreach(tower in towers) {
      if(isDefined(clips) && clips.size > 0) {
        if(clips.size > 1) {
          clips = sortbydistance(clips, tower.origin);
        }

        tower.clip = clips[0];

        if(isDefined(tower.clip)) {
          if(tower.clip.spawnflags != 0) {
            tower.clip connectpaths();
          }

          tower.volume = getEnt(tower.clip.target, "targetname");
        }
      }

      if(isDefined(tower.clip)) {
        tower.nodes = tower.clip get_linked_nodes();
      }

      if(isDefined(var_80dd8e31e981cdc7)) {
        tower thread[[var_80dd8e31e981cdc7]]();
      }

      tower thread notetrack::function_e2bc0c9e826cf659();
      level.var_93f83b8e1a186966[var_dccea0b17b790aea] = tower;
    }
  }
}

function private function_394c6ac7fb7ea4b2() {
  level.var_e50bf9931f8581ca = [];
  utility::flag_wait("scriptables_ready");
  buildings_a = getscriptablearray("airstrip_buildings", "script_noteworthy");
  buildings_b = getscriptablearray("airstrip_atc_side", "script_noteworthy");
  buildings_c = getscriptablearray("office_buildings", "script_noteworthy");
  buildings_d = getscriptablearray("airstrip_tents", "script_noteworthy");
  level.var_d4192818d4cd16df = array_combine(buildings_a, buildings_b, buildings_c, buildings_d);
  function_b626123719379d81();
  function_a1c469a6498aa1a2("airstrip_atc", "jup_urz_military_gns_airstrip_watchtower_01_air_destr");
  function_a1c469a6498aa1a2("small_gasStation_awnings", "yellow::mx_structural_gas_pump_awning_01_rig");
  function_a1c469a6498aa1a2("large_gasStation_awnings", "yellow::mx_structural_gas_pump_awning_02_rig");
  thread function_f87b74e208935d0b();
  thread function_317cfc9477fa9f88("airstrip_buildings");
  thread function_317cfc9477fa9f88("airstrip_atc", &function_b7d430329c89f441);
  thread function_317cfc9477fa9f88("airstrip_atc_side", &function_c7f1cee43f06b400);
  thread function_317cfc9477fa9f88("airstrip_hangar_a", &function_522079097d42a4f9, &function_1c4f3fc2db418b23);
  thread function_317cfc9477fa9f88("airstrip_hangar_b", &function_522076097d429e60, &function_1c4f3fc2db418b23);
  thread function_317cfc9477fa9f88("office_buildings", &function_2a7dd87fc9666fe7);
  thread function_317cfc9477fa9f88("airstrip_containers", &function_8967c0e8b9e68ba);
  thread function_317cfc9477fa9f88("airstrip_walls", &function_cfb650a27f6484cf);
  thread function_317cfc9477fa9f88("airstrip_barricades", &function_856c9261acdbf0de);
  thread function_317cfc9477fa9f88("airstrip_fences", &function_44cb81b5fc4de77c);
  thread function_317cfc9477fa9f88("airstrip_hescos", &function_d27abf062acfa085);
  thread function_317cfc9477fa9f88("tank_1", &function_e078b4e73efe9a2f);
  thread function_317cfc9477fa9f88("tank_2", &function_e078b4e73efe9a2f);
  thread function_317cfc9477fa9f88("tank_3", &function_e078b4e73efe9a2f);
  thread function_317cfc9477fa9f88("tank_4", &function_e078b4e73efe9a2f);
  thread function_317cfc9477fa9f88("tank_5", &function_e078b4e73efe9a2f);
  thread function_9901f3939c71d9c8("airstrip_watertower", &function_5c3cdf7e6b63837f);

  if(!utility::flag("testMap")) {
    function_6b3535ac942de8b7();
    thread function_42f54321b8fe61af();
    ents = getEntArray("dyn_building_clips", "targetname");

    foreach(ent in ents) {
      if(ent.spawnflags != 0) {
        ent connectpaths();
      }
    }

    function_a90742c2279ef869("tents_tower_01");
    function_a90742c2279ef869("tents_tower_02");
    function_a90742c2279ef869("tents_tower_03");
    function_a90742c2279ef869("tents_tower_04");
    function_a90742c2279ef869("barracks_tower_01");
    function_a90742c2279ef869("barracks_tower_02");
    function_a90742c2279ef869("barracks_tower_03");
    function_a90742c2279ef869("barracks_tower_04");
    function_a90742c2279ef869("radio_hill_tower_01");
    function_a90742c2279ef869("section04_tower_01");
    function_25b014f6197a4e3a("tank_1");
    function_25b014f6197a4e3a("tank_2");
    function_25b014f6197a4e3a("tank_3");
    function_25b014f6197a4e3a("tank_4");
    function_25b014f6197a4e3a("tank_5");
    function_c6fee7eef5310532();
    function_a40c4abc284db2df();
  }
}

function function_c6fee7eef5310532() {
  scriptables = getscriptablearray("small_fuelTanks", "script_noteworthy");

  foreach(scriptable in scriptables) {
    scriptable thread function_28212259894ecbc0();
  }
}

function function_a40c4abc284db2df() {
  var_33587e61d0b3329f = getscriptablearray("small_antenna_towers", "script_noteworthy");
  var_33587f61d0b334d2 = getentitylessscriptablearray("small_antenna_towers", "script_noteworthy");
  scriptables = array_combine(var_33587e61d0b3329f, var_33587f61d0b334d2);
  scriptables = array_remove_duplicates(scriptables);

  foreach(scriptable in scriptables) {
    scriptable thread function_28212259894ecbc0(undefined, !isent(scriptable), "scn_jup_gunship_radio_antenna_destroyed");
  }
}

function function_b626123719379d81() {
  var_bb834dee763f214f = getscriptablearray("not_rockable", "script_noteworthy");
  var_bb834eee763f2382 = getscriptablearray("placed_vehicles", "targetname");
  assets = array_combine(var_bb834dee763f214f, var_bb834eee763f2382);
  assets = array_remove_duplicates(assets);

  foreach(asset in assets) {
    asset thread function_d715162674451d17();
  }
}

function function_d715162674451d17() {
  function_81abb534cd1848bf();
  allies = getaiarray("allies");
  allies = sortbydistance(allies, self.origin);

  if(allies.size > 0) {
    dist = distance(self.origin, allies[0].origin);

    if(dist <= 10000) {
      if(dist <= 4000) {
        self playSound("evt_gshp_car_explo_close");
      }

      self playSound("scn_jup_gunship_radio_generic_destroyed");
    }
  }
}

function function_81abb534cd1848bf() {
  self endon("death");

  for(;;) {
    self waittill("damage", nill, attacker);

    if(!isai(attacker)) {
      break;
    }
  }
}

function function_f87b74e208935d0b() {
  aliases = [];
  aliases[aliases.size] = [level.price, "dx_sp_jsgs_psh2_pric_checkfireonthehangar"];
  aliases[aliases.size] = [level.price, "dx_sp_jsgs_psh2_pric_donotfireonthetarget"];
  aliases[aliases.size] = [level.price, "dx_sp_jsgs_psh2_pric_dontfireonthefucking"];
  aliases[aliases.size] = [level.player, "dx_sp_jsgs_psh2_grav_gunnerkeepyourfireof"];
  aliases[aliases.size] = [level.player, "dx_sp_jsgs_psh2_grav_donothitthehangars"];
  aliases[aliases.size] = [level.player, "dx_sp_jsgs_psh2_grav_howaboutyoudontblowu"];
  aliases[aliases.size] = [level.player, "dx_sp_jsgs_psh2_shep_shadow1keepfireoffof"];
  aliases[aliases.size] = [level.player, "dx_sp_jsgs_psh2_shep_shadow1donothitthech"];
  level.var_ffd7c570b9fcaa89 = utility::create_deck(aliases);
}

function function_a90742c2279ef869(noteworthy) {
  structs = getStructArray(noteworthy, "script_noteworthy");

  foreach(struct in structs) {
    towers = getscriptablearray(struct.target, "targetname");
    ents = getEntArray(struct.target, "targetname");
    clips = utility::array_remove_array(ents, towers);

    foreach(tower in towers) {
      level.var_ce37247e494d0064[noteworthy] = tower;

      if(isDefined(clips) && clips.size > 0) {
        if(clips.size > 1) {
          clips = sortbydistance(clips, tower.origin);
        }

        tower.clip = clips[0];

        if(isDefined(tower.clip)) {
          if(tower.clip.spawnflags != 0) {
            tower.clip connectpaths();
          }

          tower.volume = getEnt(tower.clip.target, "targetname");
        }
      }

      if(isDefined(tower.clip)) {
        tower.nodes = tower.clip get_linked_nodes();
      }

      tower thread function_e896455437572903();
      tower thread function_28212259894ecbc0();
    }
  }
}

function function_e896455437572903() {
  function_e26bc59e7cae56();

  if(isDefined(self.clip)) {
    if(self.clip.spawnflags != 0) {
      self.clip disconnectPaths();
    }

    self.clip delete();
  }

  if(isDefined(self.nodes)) {
    foreach(node in self.nodes) {
      destroynavlink(node);
    }
  }

  waitframe();

  if(isDefined(self.volume)) {
    guys = self.volume get_ai_touching_volume("axis");

    foreach(guy in guys) {
      guy kill();
    }
  }

  if(isDefined(self.guys)) {
    guys = array_removedead_or_dying(self.guys);

    foreach(guy in guys) {
      if(isDefined(guy.var_6308088457db06da)) {
        guy thread spawner::go_to_node(guy.var_6308088457db06da);
      }
    }
  }
}

function function_e26bc59e7cae56() {
  if(self getscriptablepartstate("base", 1) != "pristine" && self getscriptablepartstate("base", 1) != "damaged") {
    return;
  }

  for(;;) {
    state = self getscriptablepartstate("base", 1);

    if(utility::is_equal(state, "death") || utility::is_equal(state, "dead")) {
      break;
    }

    wait 1;
  }
}

function function_25b014f6197a4e3a(noteworthy) {
  structs = getStructArray(noteworthy, "script_noteworthy");

  foreach(struct in structs) {
    tanks = getscriptablearray(struct.target, "targetname");
    ents = getEntArray(struct.target, "targetname");
    ai_nodes = getnodearray(struct.target, "targetname");
    clips = utility::array_remove_array(ents, tanks);

    foreach(tank in tanks) {
      level.fueltanks[noteworthy] = tank;

      if(isDefined(clips) && clips.size > 0) {
        if(clips.size > 1) {
          clips = sortbydistance(clips, tank.origin);
        }

        tank.clip = clips[0];

        if(isDefined(tank.clip)) {
          if(tank.clip.spawnflags != 0) {
            tank.clip connectpaths();
          }

          tank.volume = getEnt(tank.clip.target, "targetname");
        }
      }

      if(isDefined(tank.clip)) {
        tank.var_9bcd877ec20f0871 = tank.clip get_linked_nodes();
      }

      if(isDefined(ai_nodes)) {
        tank.ai_nodes = ai_nodes;
      }

      tank thread function_a65b1de390672d95();
      tank thread function_28212259894ecbc0(15000);
    }
  }
}

function function_a65b1de390672d95() {
  function_2405c046d718feac();

  if(isDefined(self.clip)) {
    if(self.clip.spawnflags != 0) {
      self.clip disconnectPaths();
    }

    self.clip delete();
  }

  if(isDefined(self.var_9bcd877ec20f0871)) {
    foreach(node in self.var_9bcd877ec20f0871) {
      destroynavlink(node);
    }
  }

  if(isDefined(self.ai_nodes)) {
    foreach(node in self.ai_nodes) {
      node disconnectnode();
    }
  }

  waitframe();

  if(isDefined(self.volume)) {
    guys = self.volume get_ai_touching_volume("axis");

    foreach(guy in guys) {
      guy kill();
    }
  }

  if(isDefined(self.guys)) {
    guys = array_removedead_or_dying(self.guys);

    foreach(guy in guys) {
      if(isDefined(guy.var_6308088457db06da)) {
        guy thread spawner::go_to_node(guy.var_6308088457db06da);
      }
    }
  }
}

function function_2405c046d718feac() {
  if(self getscriptablepartstate("base", 1) != "pristine") {
    return;
  }

  for(;;) {
    if(self getscriptablepartstate("base", 1) != "pristine") {
      break;
    }

    wait 1;
  }
}

function function_9bbf5c7554cc4842() {
  self.var_f6351e8070d8ce78 = -10000;
  self.asset_info.var_70865f2cdc241312 = 0;
  self.asset_info.value_package["boneCount_hellfire"] = 4;
  self.asset_info.value_package["boneCount_40mm"] = 1;
  self.asset_info.value_package["boneCount_25mm"] = 1;
  self.asset_info.value_package["boneCount_turret"] = 1;
  self.asset_info.value_package["damageRange_hellfire"] = 680;
  self.asset_info.value_package["damageRange_40mm"] = 300;
  self.asset_info.value_package["damageRange_25mm"] = 250;
  self.asset_info.value_package["damageRange_turret"] = 400;
  self.asset_info.value_package["bulletMin_hellfire"] = 0;
  self.asset_info.value_package["bulletMin_40mm"] = 0;
  self.asset_info.value_package["bulletMin_25mm"] = 2;
  self.asset_info.value_package["bulletMin_turret"] = 0;
  self.var_7b56b46b03bda38f = 0;
  self.var_17d44a80590b170e = 0;
  self.var_a5e26da0f100a758 = 0;
  self.var_ce21b1d67cefec45["gunship_40mm_jup_sp"] = 10;
  self.var_ce21b1d67cefec45["gunship_25mm_jup_sp"] = 30;
  self.var_ce21b1d67cefec45["gunship_hellfire_jup_sp"] = 0;
  self.var_ce21b1d67cefec45["gunship_hellfire_jup_sp"] = 0;
  self.var_812756778885f531["gunship_40mm_jup_sp"] = 2;
  self.var_812756778885f531["gunship_25mm_jup_sp"] = 20;
  self.var_812756778885f531["gunship_hellfire_jup_sp"] = 0;
  self.var_812756778885f531["gunship_hellfire_jup_sp"] = 0;
  self.var_e1862ee5816b6215["gunship_40mm_jup_sp"] = 2;
  self.var_e1862ee5816b6215["gunship_25mm_jup_sp"] = 6;
  self.var_e1862ee5816b6215["gunship_hellfire_jup_sp"] = 1;
  self.var_e1862ee5816b6215["gunship_hellfire_jup_sp"] = 1;

  if(issubstr(self.model, "_top")) {
    level.var_e50bf9931f8581ca[level.var_e50bf9931f8581ca.size] = self;
    self.var_a0efcfe66ece0479 = 0;
    self.var_18feb83b16a03c3a = 2;
    self.asset_info.value_package["boneCount_env"] = 1;
    self.asset_info.value_package["damageRange_env"] = 300;
    self.asset_info.value_package["bulletMin_env"] = 0;
    self.asset_info.value_package["boneCount_rpg"] = 1;
    self.asset_info.value_package["damageRange_rpg"] = 300;
    self.asset_info.value_package["bulletMin_rpg"] = 0;
  } else {
    self.asset_info.value_package["boneCount_hellfire"] = 6;
    self.asset_info.value_package["boneCount_40mm"] = 3;
    self.asset_info.value_package["boneCount_turret"] = 2;
    self.asset_info.value_package["boneCount_env"] = 2;
    self.asset_info.value_package["boneCount_rpg"] = 2;
  }

  thread function_28212259894ecbc0(15000);
}

function function_277990754d304280(origin) {
  hangar = sortbydistance(level.var_e50bf9931f8581ca, origin)[0];

  if(hangar getscriptableparthasstate("base", "dead") && !utility::is_equal(hangar getscriptablepartstate("base", 1), "dead")) {
    hangar setscriptablepartstate("base", "dead");
  }
}

function function_89470cfc7215663d() {
  self.var_f6351e8070d8ce78 = -10000;
  self.asset_info.var_70865f2cdc241312 = 0;
  self.asset_info.value_package["boneCount_hellfire"] = 5;
  self.asset_info.value_package["boneCount_40mm"] = 2;
  self.asset_info.value_package["boneCount_25mm"] = 1;
  self.asset_info.value_package["damageRange_hellfire"] = 1000;
  self.asset_info.value_package["damageRange_40mm"] = 300;
  self.asset_info.value_package["damageRange_25mm"] = 300;
  self.asset_info.value_package["bulletMin_hellfire"] = 0;
  self.asset_info.value_package["bulletMin_40mm"] = 0;
  self.asset_info.value_package["bulletMin_25mm"] = 0;
  self.var_a0efcfe66ece0479 = 1;
}

function function_b7d430329c89f441() {
  self.asset_info.var_70865f2cdc241312 = 0;
  self.asset_info.value_package["boneCount_hellfire"] = 5;
  self.asset_info.value_package["boneCount_40mm"] = 2;
  self.asset_info.value_package["boneCount_25mm"] = 1;
  self.asset_info.value_package["damageRange_hellfire"] = 1200;
  self.asset_info.value_package["damageRange_40mm"] = 300;
  self.asset_info.value_package["damageRange_25mm"] = 100;
  self.asset_info.value_package["bulletMin_hellfire"] = 0;
  self.asset_info.value_package["bulletMin_40mm"] = 0;
  self.asset_info.value_package["bulletMin_25mm"] = 15;
  thread function_28212259894ecbc0();
}

function function_28212259894ecbc0(range, var_a015f78a1fda44ba, sound) {
  if(istrue(var_a015f78a1fda44ba) && !self getscriptableparthasstate("base", "dead")) {
    if(getdvarint(@ "hash_e2f4e022d2ad1821") == 1) {
      thread draw_line_for_time(self.origin, self.origin + (0, 0, 1000), 1, 0, 0, 30);
    }

    return;
  }

  if(getdvarint(@ "hash_e2f4e022d2ad1821") == 1) {
    thread draw_line_for_time(self.origin, self.origin + (0, 0, 1000), 1, default_to(var_a015f78a1fda44ba, 0), 1, 30);
  }

  if(istrue(var_a015f78a1fda44ba)) {
    function_da5e36cbb2eebee6();
  } else {
    self waittill("scriptableNotification", sound);
  }

  if(getdvarint(@ "hash_e2f4e022d2ad1821") == 1) {
    thread draw_line_for_time(self.origin, self.origin + (0, 0, 1000), 0, 1, 0, 10);
  }

  allies = getaiarray("allies");
  allies = sortbydistance(allies, self.origin);

  if(allies.size > 0) {
    dist = distance(self.origin, allies[0].origin);

    if(dist <= utility::default_to(range, 10000)) {
      if(istrue(var_a015f78a1fda44ba)) {
        playsoundatpos(self.origin, sound);
        return;
      }

      self playSound(sound);
    }
  }
}

function function_da5e36cbb2eebee6() {
  for(;;) {
    if(self getscriptableparthasstate("base", "dead") && utility::is_equal(self getscriptablepartstate("base", 1), "dead")) {
      break;
    }

    waitframe();
  }
}

function function_c7f1cee43f06b400() {
  self.asset_info.value_package["boneCount_hellfire"] = 4;
  self.asset_info.value_package["boneCount_40mm"] = 2;
  self.asset_info.value_package["boneCount_25mm"] = 1;
  self.asset_info.value_package["damageRange_hellfire"] = 500;
  self.asset_info.value_package["damageRange_40mm"] = 100;
  self.asset_info.value_package["damageRange_25mm"] = 50;
  self.asset_info.value_package["bulletMin_hellfire"] = 0;
  self.asset_info.value_package["bulletMin_40mm"] = 0;
  self.asset_info.value_package["bulletMin_25mm"] = 10;
}

function function_522079097d42a4f9() {
  function_9bbf5c7554cc4842();
  self.var_35716480029d5ae4 = getEnt("hangar_a_warning", "targetname");
  self.var_becda408ae77b32e = getEnt("hangar_a_fail", "targetname");
  self.asset_info.var_6bbb9c25c7fa3634 = &function_eadbfb6d0294eee1;
}

function function_522076097d429e60() {
  self.asset_info.var_6bbb9c25c7fa3634 = &function_5a438cab39bcdc04;
  function_9bbf5c7554cc4842();

  if(!isDefined(level.hangar_b)) {
    level.hangar_b = [];
  }

  self.var_35716480029d5ae4 = getEnt("hangar_b_warning", "targetname");
  self.var_becda408ae77b32e = getEnt("hangar_b_fail", "targetname");
  level.hangar_b[level.hangar_b.size] = self;
  thread function_274ae6b56829365e();
  thread function_8ebb85568fb7f5a9();
}

function function_8ebb85568fb7f5a9() {
  while(true) {
    self waittill("scriptableNotification", notifystring);

    if(notifystring == "explosion") {
      radiusdamage(self.origin, 800, 600, 600, self, undefined, undefined, 0, 0);
      break;
    }
  }
}

function function_274ae6b56829365e() {
  if(starts::is_after_start("heli_boss")) {
    return;
  }

  level endon("stop_hangarB_evn_fail");

  for(;;) {
    state = self getscriptablepartstate("base", 1);

    if(state == "collapsed") {
      break;
    }

    waitframe();
  }

  function_cb1aabd6be7ad2c7();
}

function function_1c4f3fc2db418b23(attacker, point, objweapon) {
  if(!isDefined(objweapon)) {
    return;
  }

  if(point[2] >= 800 && (objweapon.basename == "gunship_40mm_jup_sp" || objweapon.basename == "gunship_25mm_jup_sp" || objweapon.basename == "iw9_la_rpapa7_sp_ai")) {
    if(time_has_passed(self.var_f6351e8070d8ce78, 2)) {
      allies = getaiarray("allies");
      allies = sortbydistance(allies, self.origin);

      if(allies.size > 0) {
        dist = distance(self.origin, allies[0].origin);

        if(dist <= 10000) {
          self.var_f6351e8070d8ce78 = gettime();
          self playSound("scn_jup_gunship_radio_hangar_roof_hits");
        }
      }
    }
  }
}

function function_eadbfb6d0294eee1(attacker, point, objweapon, part) {
  if(utility::flag("hangar_a_clear")) {
    return;
  }

  function_2bb7adafa042a3dc(attacker, point, objweapon, part);
}

function function_5a438cab39bcdc04(attacker, point, objweapon, part) {
  if(utility::flag("hangar_b_clear_enough")) {
    return;
  }

  if(starts::is_after_start("<dev string:x221>")) {
    return;
  }

  function_2bb7adafa042a3dc(attacker, point, objweapon, part);
}

function function_2bb7adafa042a3dc(attacker, point, objweapon, part) {
  if(isPlayer(attacker) && isDefined(objweapon) && isDefined(point)) {
    var_31f283ff43c7b0a6 = ispointinvolume(point, self.var_35716480029d5ae4);
    var_8399035e3d54af56 = ispointinvolume(point, self.var_becda408ae77b32e);

    if(!var_31f283ff43c7b0a6 && !var_8399035e3d54af56) {
      return;
    }

    if(var_31f283ff43c7b0a6 && !var_8399035e3d54af56) {
      if(part function_444a8e7082bd8b59(objweapon.basename) >= self.var_ce21b1d67cefec45[objweapon.basename] || self.var_17d44a80590b170e > self.var_e1862ee5816b6215[objweapon.basename]) {
        function_cb1aabd6be7ad2c7();
        return 0;
      } else if(utility::time_has_passed(self.var_7b56b46b03bda38f, 2)) {
        self.var_17d44a80590b170e++;
        self.var_7b56b46b03bda38f = gettime();
        vo_pair = level.var_ffd7c570b9fcaa89 utility::deck_draw();
        vo_pair[0] thread dialogue(vo_pair[1], 0.2);
      }

      return;
    }

    if(var_8399035e3d54af56) {
      if(part function_444a8e7082bd8b59(objweapon.basename) < self.var_812756778885f531[objweapon.basename] && self.var_a5e26da0f100a758 < self.var_e1862ee5816b6215[objweapon.basename]) {
        if(utility::time_has_passed(self.var_7b56b46b03bda38f, 2)) {
          self.var_a5e26da0f100a758++;
          self.var_7b56b46b03bda38f = gettime();
          vo_pair = level.var_ffd7c570b9fcaa89 utility::deck_draw();

          if(isDefined(vo_pair) && isDefined(vo_pair[0]) && isDefined(vo_pair[1])) {
            vo_pair[0] thread dialogue(vo_pair[1], 0.2);
          }
        }
      }

      function_cb1aabd6be7ad2c7();
      return 0;
    }
  }
}

function function_cb1aabd6be7ad2c7() {
  player_death::clear_custom_death_quote();

  if(flag("hangar_b_end")) {
    player_death::set_custom_death_quote(242);
  } else {
    player_death::set_custom_death_quote(252);
  }

  thread utility::missionfailedwrapper();
}

function private function_444a8e7082bd8b59(weaponname) {
  if(weaponname == level.gunship.var_d6604d5e3d0ba184) {
    return self.var_17d2a2a24229dc42;
  } else if(weaponname == level.gunship.var_d660505e3d0ba81d) {
    return self.var_75f6977603250653;
  } else if(weaponname == "sp_jup_sidewinder_gs_medium") {
    return self.hits_rpg;
  }

  return self.hits_hellfire;
}

function function_2a7dd87fc9666fe7() {
  self.asset_info.value_package["boneCount_hellfire"] = 7;
  self.asset_info.value_package["boneCount_40mm"] = 2;
  self.asset_info.value_package["boneCount_25mm"] = 1;
  self.asset_info.value_package["damageRange_hellfire"] = 600;
  self.asset_info.value_package["damageRange_40mm"] = 400;
  self.asset_info.value_package["damageRange_25mm"] = 200;
  self.asset_info.value_package["bulletMin_hellfire"] = 0;
  self.asset_info.value_package["bulletMin_40mm"] = 0;
  self.asset_info.value_package["bulletMin_25mm"] = 10;
}

function function_8967c0e8b9e68ba() {
  self.asset_info.var_70865f2cdc241312 = 0;
  self.asset_info.value_package["boneCount_hellfire"] = 10;
  self.asset_info.value_package["boneCount_40mm"] = 1;
  self.asset_info.value_package["boneCount_25mm"] = 1;
  self.asset_info.value_package["damageRange_hellfire"] = 600;
  self.asset_info.value_package["damageRange_40mm"] = 100;
  self.asset_info.value_package["damageRange_25mm"] = 50;
  self.asset_info.value_package["bulletMin_hellfire"] = 0;
  self.asset_info.value_package["bulletMin_40mm"] = 0;
  self.asset_info.value_package["bulletMin_25mm"] = 5;
  thread function_c2379619b48d1589();
}

function function_c2379619b48d1589(range) {
  while(true) {
    self waittill("scriptableNotification", sound);
    allies = getaiarray("allies");
    allies = sortbydistance(allies, self.origin);

    if(allies.size > 0) {
      dist = distance(self.origin, allies[0].origin);

      if(dist <= utility::default_to(range, 10000)) {
        self playSound(sound);
      }
    }
  }
}

function function_cfb650a27f6484cf() {
  self.asset_info.value_package["boneCount_hellfire"] = 2;
  self.asset_info.value_package["boneCount_40mm"] = 1;
  self.asset_info.value_package["boneCount_25mm"] = 1;
  self.asset_info.value_package["damageRange_hellfire"] = 600;
  self.asset_info.value_package["damageRange_40mm"] = 400;
  self.asset_info.value_package["damageRange_25mm"] = 200;
  self.asset_info.value_package["bulletMin_hellfire"] = 0;
  self.asset_info.value_package["bulletMin_40mm"] = 0;
  self.asset_info.value_package["bulletMin_25mm"] = 0;
}

function function_856c9261acdbf0de() {
  self.asset_info.value_package["boneCount_hellfire"] = 2;
  self.asset_info.value_package["boneCount_40mm"] = 1;
  self.asset_info.value_package["boneCount_25mm"] = 1;
  self.asset_info.value_package["damageRange_hellfire"] = 600;
  self.asset_info.value_package["damageRange_40mm"] = 400;
  self.asset_info.value_package["damageRange_25mm"] = 200;
  self.asset_info.value_package["bulletMin_hellfire"] = 0;
  self.asset_info.value_package["bulletMin_40mm"] = 0;
  self.asset_info.value_package["bulletMin_25mm"] = 0;
}

function function_44cb81b5fc4de77c() {
  self.asset_info.value_package["boneCount_hellfire"] = 2;
  self.asset_info.value_package["boneCount_40mm"] = 1;
  self.asset_info.value_package["boneCount_25mm"] = 1;
  self.asset_info.value_package["damageRange_hellfire"] = 600;
  self.asset_info.value_package["damageRange_40mm"] = 400;
  self.asset_info.value_package["damageRange_25mm"] = 200;
  self.asset_info.value_package["bulletMin_hellfire"] = 0;
  self.asset_info.value_package["bulletMin_40mm"] = 0;
  self.asset_info.value_package["bulletMin_25mm"] = 0;
}

function function_d27abf062acfa085() {
  self.asset_info.value_package["boneCount_hellfire"] = 2;
  self.asset_info.value_package["boneCount_40mm"] = 1;
  self.asset_info.value_package["boneCount_25mm"] = 1;
  self.asset_info.value_package["damageRange_hellfire"] = 600;
  self.asset_info.value_package["damageRange_40mm"] = 400;
  self.asset_info.value_package["damageRange_25mm"] = 200;
  self.asset_info.value_package["bulletMin_hellfire"] = 0;
  self.asset_info.value_package["bulletMin_40mm"] = 0;
  self.asset_info.value_package["bulletMin_25mm"] = 15;
}

function function_ea8648feaf6b3a05() {
  self.asset_info.var_70865f2cdc241312 = 0;
  self.asset_info.value_package["boneCount_hellfire"] = 10;
  self.asset_info.value_package["boneCount_40mm"] = 3;
  self.asset_info.value_package["boneCount_25mm"] = 1;
  self.asset_info.value_package["damageRange_hellfire"] = 600;
  self.asset_info.value_package["damageRange_40mm"] = 150;
  self.asset_info.value_package["damageRange_25mm"] = 50;
  self.asset_info.value_package["bulletMin_hellfire"] = 0;
  self.asset_info.value_package["bulletMin_40mm"] = 0;
  self.asset_info.value_package["bulletMin_25mm"] = 1;
}

function function_6e43652386a692cd() {
  self.asset_info.var_70865f2cdc241312 = 0;
  self.asset_info.value_package["boneCount_hellfire"] = 10;
  self.asset_info.value_package["boneCount_40mm"] = 3;
  self.asset_info.value_package["boneCount_25mm"] = 1;
  self.asset_info.value_package["damageRange_hellfire"] = 600;
  self.asset_info.value_package["damageRange_40mm"] = 150;
  self.asset_info.value_package["damageRange_25mm"] = 50;
  self.asset_info.value_package["bulletMin_hellfire"] = 0;
  self.asset_info.value_package["bulletMin_40mm"] = 0;
  self.asset_info.value_package["bulletMin_25mm"] = 2;
}

function function_98d1511ff726f228() {
  self.asset_info.var_70865f2cdc241312 = 0;
  self.asset_info.value_package["boneCount_hellfire"] = 10;
  self.asset_info.value_package["boneCount_40mm"] = 1;
  self.asset_info.value_package["boneCount_25mm"] = 1;
  self.asset_info.value_package["damageRange_hellfire"] = 600;
  self.asset_info.value_package["damageRange_40mm"] = 300;
  self.asset_info.value_package["damageRange_25mm"] = 50;
  self.asset_info.value_package["bulletMin_hellfire"] = 0;
  self.asset_info.value_package["bulletMin_40mm"] = 0;
  self.asset_info.value_package["bulletMin_25mm"] = 5;
}

function function_e078b4e73efe9a2f() {
  self.asset_info.value_package["boneCount_hellfire"] = 1;
  self.asset_info.value_package["boneCount_40mm"] = 1;
  self.asset_info.value_package["boneCount_25mm"] = 1;
  self.asset_info.value_package["damageRange_hellfire"] = 600;
  self.asset_info.value_package["damageRange_40mm"] = 500;
  self.asset_info.value_package["damageRange_25mm"] = 350;
  self.asset_info.value_package["bulletMin_hellfire"] = 0;
  self.asset_info.value_package["bulletMin_40mm"] = 0;
  self.asset_info.value_package["bulletMin_25mm"] = 5;
}

function function_b4a28558bb65d79d() {
  utility::flag_wait("scriptables_ready");
  partlist = [];
  partlist[partlist.size] = "tag_origin";
  partlist[partlist.size] = "tag_body";
  partlist[partlist.size] = "tag_wheel_center_back_left";
  partlist[partlist.size] = "tag_wheel_center_back_right";
  partlist[partlist.size] = "tag_wheel_center_front_left";
  partlist[partlist.size] = "tag_wheel_center_front_right";
  partlist[partlist.size] = "tag_door_front_left";
  partlist[partlist.size] = "tag_door_front_right";
  partlist[partlist.size] = "tag_door_back_left";
  partlist[partlist.size] = "tag_door_back_right";
  partlist[partlist.size] = "tag_hood";
  partlist[partlist.size] = "tag_trunk";
  assets = getscriptablearray("not_rockable", "script_noteworthy");

  foreach(asset in assets) {
    asset function_3b0f548face4361e(partlist);
  }

  var_bb834eee763f2382 = getscriptablearray("placed_trucks", "targetname");

  if(isDefined(var_bb834eee763f2382)) {
    foreach(asset in var_bb834eee763f2382) {
      asset function_3b0f548face4361e(partlist);
    }
  }
}

function private function_5c3cdf7e6b63837f(noteworthy) {
  self endon("kill_death_thread");
  height_offset = 400;
  top_height = self.origin[2] + height_offset;
  fx_name = "vfx_gs_wt_tank_broken_water_flow";
  var_cdfeb705354a58da = 0;
  var_d1b2ac60be37f957 = 7;

  while(isDefined(self)) {
    self waittill("damage", nill, attacker, nill, point, nill, nill, nill, nill, nill, objweapon);

    if(isai(attacker) || !isDefined(objweapon) || !isDefined(objweapon.basename)) {
      continue;
    }

    if(getdvarint(@ "hash_326bd63875e3311e") == 1) {
      thread utility::draw_line_for_time(self.origin, point, 1, 0, 1, 10);
    }

    if(objweapon.basename == level.gunship.var_d660505e3d0ba81d && var_cdfeb705354a58da < var_d1b2ac60be37f957) {
      var_cdfeb705354a58da++;
      continue;
    }

    if(point[2] > top_height) {
      if(self getscriptablepartstate("base") != "top_destroy") {
        if(getdvarint(@ "hash_326bd63875e3311e") == 1) {
          iprintlnbold("<dev string:x22b>");
        }

        self setscriptablepartstate("base", "top_destroy", 1);

        if(utility::fxexists(fx_name)) {
          if(!isDefined(self.vfx_ent)) {
            self.vfx_ent = utility::spawn_tag_origin(self.origin, self.angles);
          }

          playFXOnTag(utility::getfx(fx_name), self.vfx_ent, "tag_origin");
        }
      } else {
        self setscriptablepartstate("base", "topbottom_destroy", 1);
        break;
      }

      continue;
    }

    if(self getscriptablepartstate("base") != "top_destroy") {
      self setscriptablepartstate("base", "bottom_destroy", 1);
    } else {
      self setscriptablepartstate("base", "topbottom_destroy", 1);
    }

    break;
  }

  if(isDefined(self.vfx_ent)) {
    if(utility::fxexists(fx_name)) {
      stopFXOnTag(utility::getfx(fx_name), self.vfx_ent, "tag_origin");
    }

    self.vfx_ent delete();
  }

  utility::flag_set("tower_destroyed");
  level.player playSound("scn_gunship_compound_water_tower_fall");

  if(isDefined(self.clip)) {
    if(self.clip.spawnflags != 0) {
      self.clip disconnectPaths();
    }

    self.clip delete();
  }

  if(isDefined(self.nodes)) {
    foreach(node in self.nodes) {
      destroynavlink(node);
    }
  }

  waitframe();

  if(isDefined(self.volume)) {
    guys = self.volume get_ai_touching_volume("axis");

    foreach(guy in guys) {
      guy kill();
    }
  }

  if(isDefined(self.guys)) {
    guys = array_removedead_or_dying(self.guys);

    foreach(guy in guys) {
      if(isDefined(guy.var_6308088457db06da)) {
        guy thread spawner::go_to_node(guy.var_6308088457db06da);
      }
    }
  }

  if(getdvarint(@ "hash_326bd63875e3311e") == 1) {
    iprintlnbold("<dev string:x237>");
  }
}

function private function_42f54321b8fe61af() {
  utility::flag_wait("scriptables_ready");
  tower_clip = getEnt("radio_tower_clip", "targetname");

  if(isDefined(tower_clip)) {
    tower = getscriptablearray("radio_tower", "targetname")[0];
    tower_clip thread function_4cada3beb03048f0(tower);
  }
}

function function_c70423de2fd6d621() {
  utility::flag_set("sam_site_start");
  utility::flag_set("radio_tower_start");
  utility::flag_set("radio_tower_fall");
  utility::flag_wait("scriptables_ready");

  if(utility::flag("<dev string:x246>") || utility::flag("<dev string:x24e>") || starts::is_after_start("<dev string:x256>")) {
    return;
  }

  tower_clip = getEnt("radio_tower_clip", "targetname");
  tower_clip delete();
  tower = getscriptablearray("radio_tower", "targetname")[0];
  tower setscriptablepartstate("base", "dead");
}

function function_4cada3beb03048f0(tower) {
  self endon("entitydeleted");
  self.health = 99999;
  self setCanDamage(1);
  self setCanRadiusDamage(1);
  tower thread function_d8ac3f13e0eacda8();
  i = 0;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin);

    if(!isPlayer(attacker)) {} else if(utility::is_equal(objweapon.basename, "gunship_hellfire_jup_sp")) {
      break;
    } else {
      i++;

      if(i == 5) {
        level thread dialogue::say_team("dx_sp_jsgs_veha_grav_dropamissileonthatfu");
        thread utility::display_hint("weapon_swap", 10, 1);
      } else if(i == 20) {
        thread utility::display_hint("tower_ammo", 10, 0.2);
        i = 0;
      }
    }

    waitframe();
  }

  utility::flag_set("radio_tower_fall");
  tower setscriptablepartstate("base", "anim");
  self delete();
}

function function_d8ac3f13e0eacda8() {
  for(;;) {
    self waittill("scriptableNotification", arg1, arg2, arg3);

    if(arg1 == "start_mayhem") {
      self playSound("scn_jup_gunship_radio_antenna_destroyed");
      spawnmayhem("radioTowerMayhem", "vfx_shadowbase_radiotower", self.origin, self.angles);
      playmayhem("radioTowerMayhem");
    } else if(arg1 == "stop_mayhem") {
      killmayhem("radioTowerMayhem");
      break;
    }

    waitframe();
  }

  radiusdamage((-23264, 7936, 1024), 200, 1000, 1000, level.player, "MOD_EXPLOSIVE", "gunship_40mm_jup_sp", 1, 0);
}

function private function_b0372a5e9425d484() {
  setdvarifuninitialized(@ "hash_57db27d991ee39f7", 0);
  setdvarifuninitialized(@ "hash_77c9581a1f270e09", 0);

  setdvarifuninitialized(@ "hash_94c408c5514d7615", 0);

  function_de3acba0646ec589();
  var_3abc21bd19b66fba = "overlaytargetmarkerfriendly";
  var_25343b3f86ac5c93 = "overlaytargetmarkerenemy";
  var_4910af7f9c89b936 = "overlaytargetmarkerenemy";
  var_831feea324d5da37 = "overlaytargetmarkerenemy";
  vehiclegroup = "overlaytargetmarkerenemy";

  if(getdvarint(@ "hash_57db27d991ee39f7") == 1) {
    level.var_9ed7da1529f3e23f = createtargetmarkergroup(var_3abc21bd19b66fba);
    level.enemytargetmarkergroup = createtargetmarkergroup(var_25343b3f86ac5c93);
    level.var_5b1cef5abf070295 = createtargetmarkergroup(var_4910af7f9c89b936);
    level.var_e9a68b2ce6f0ac94 = createtargetmarkergroup(var_831feea324d5da37);
    level.var_d491f25f77c56185 = createtargetmarkergroup(vehiclegroup);
    level.markergroups = spawnStruct();
    level.markergroups.group_id[level.var_9ed7da1529f3e23f] = level.var_9ed7da1529f3e23f;
    level.markergroups.group_id[level.enemytargetmarkergroup] = level.enemytargetmarkergroup;
    level.markergroups.group_id[level.var_5b1cef5abf070295] = level.var_5b1cef5abf070295;
    level.markergroups.group_id[level.var_e9a68b2ce6f0ac94] = level.var_e9a68b2ce6f0ac94;
    level.markergroups.group_id[level.var_d491f25f77c56185] = level.var_d491f25f77c56185;

    foreach(id in level.markergroups.group_id) {
      level.markergroups.group_size[id] = 0;
      level.markergroups.var_18388a46fff7463a[id] = [];
    }
  }

  setdvarifuninitialized(@ "hash_5db9993d6668bf59", 0);

  thread function_bf0a7de77e684a6f();
  level.custom_friendly_fire_message = 242;
  level.var_d0ea3453d1a6769c = 0;
  level.var_50e02e22bb103b5d = 1;
  utility::battlechatter_off();
  utility::battlechatter_off("axis");
  utility::battlechatter_off("allies");
  level.var_e8e0eac736110e84 = &namespace_5bf3bd82da62657f::function_56909bc02dcec30d;
  namespace_5bf3bd82da62657f::function_f5102a91e43f54c();
  utility::registersharedfunc("aiReact", "combatHot", &function_ec4f790251acb44d);
  level.friendly_fire_fail_check = &function_9de44d948bbdcb69;
  utility::fail_on_friendly_fire();
  utility::add_global_spawn_function("axis", &function_bfb10eefc1238d1c);
}

function function_de3acba0646ec589() {
  aliases = [];
  aliases[aliases.size] = "dx_sp_jsgs_hngr_fara_graveshitthatrpg";
  aliases[aliases.size] = "dx_sp_jsgs_hngr_grav_letsgogunnerfocusfir";
  aliases[aliases.size] = "dx_sp_jsgs_hngr_pric_weretakingrpgfire";
  level.var_23aa7dd19bb34f63 = create_deck(aliases, 1, 1);
}

function function_acb3956c35ede288(node) {
  self endon("death");
  self endon("entitydeleted");
  self notify("customColorNodeWatcher");
  self endon("customColorNodeWatcher");
  thread function_4813924346874734(node);
  spawner::node_fields_pre_goal(node);
  function_abd3bb43c25ffaf6();
  self notify("customColorNodeEndWatcher");
  spawner::node_fields_after_goal(node);
  node script_delay();

  if(isDefined(node.script_flag_wait)) {
    flag_wait(node.script_flag_wait);
  }

  if(isDefined(node.script_flag_waitopen)) {
    flag_waitopen(node.script_flag_waitopen);
  }

  if(isDefined(node.script_ent_flag_wait)) {
    ent_flag_wait(node.script_ent_flag_wait);
  }

  if(isDefined(node.var_43add43a57978cd)) {
    ent_flag_waitopen(node.var_43add43a57978cd);
  }

  node script_wait();
  spawner::node_fields_after_goal_and_wait(node);
}

function function_4813924346874734(node) {
  self endon("death");
  self endon("entitydeleted");
  self endon("customColorNodeEndWatcher");
  self waittill("customColorNodeWatcher");
  spawner::node_fields_after_goal(node);
}

function function_abd3bb43c25ffaf6(time) {
  self endon("death");
  self endon("long_death");
  self endon("entitydeleted");
  self endon("thermal_laser_kill");
  self endon("new_color_being_set");

  if(isDefined(time)) {
    thread utility::notify_delay("timeoutNodeCheck", time);
  }

  start = gettime();

  for(;;) {
    if(!utility::is_equal(self.movemode, "stop") || utility::time_has_passed(start, 1)) {
      break;
    }

    waitframe();
  }

  if(!utility::is_equal(self.movemode, "stop")) {
    utility::waittill_any_8("cover_left", "cover_right", "cover_stand", "cover_crouch", "cover_crouch_window", "cover_exposed", "cover_conceal", "timeoutNodeCheck");
  }

  return true;
}

function function_ec4f790251acb44d() {
  if(vehicle::isvehicle()) {
    return;
  }

  self.ignoreall = 0;
  self.ignoreme = 0;
}

function function_686b79a5ab9b4807(var_bc3d44ee72010f02) {
  if(vehicle::isvehicle()) {
    return;
  }

  self endon("death");
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.maystumble = 1;
  utility::demeanor_override("sprint");
  self.health = 20;

  if(level.gameskill > 1) {
    self.attackeraccuracy = 0.2;
  } else {
    self.attackeraccuracy = 0.5;
  }

  utility::set_maxvisibledist(20000);
  utility::set_maxfaceenemydist(20000);
  self.ignoresuppression = 1;
  self.dontshootwhilemoving = 0;
  self.forcesuppressai = 1;
  self.forcesuppression = 1;
  self function_95d5375059c2a022("extremerange_jup_gunship", 1);

  if(isDefined(self.var_6308088457db06da) && self.var_6308088457db06da.size > 0) {
    thread spawner::go_to_node(self.var_6308088457db06da);
  }

  thread function_d400c1564e2bdaa7(var_bc3d44ee72010f02);
}

function function_d400c1564e2bdaa7(var_bc3d44ee72010f02) {
  if(!istrue(level.var_9e1ae3102c095174)) {
    return;
  }

  if(isDefined(self.marker)) {
    return;
  }

  if(!istrue(var_bc3d44ee72010f02)) {
    self endon("death");
    wait 0.1;

    if(self islinked()) {
      return;
    }
  }

  marker = ter_op(istrue(self.var_1051fda886374828), "icon_waypoint_overlay_marker_special", "icon_waypoint_overlay_marker_enemy_small");
  thread function_91fff8ef1083babf((0, 0, 0), istrue(var_bc3d44ee72010f02), 1, 0, marker, 0);
}

function function_bfb10eefc1238d1c() {
  if(vehicle::isvehicle()) {
    return;
  }

  self.dontshootwhilemoving = 0;
  self.forcesuppressai = 1;
  thread function_911ed95e504f2cbc();
  self.cornercheckenabled = 0;
  self.dropweapon = 0;
  self endon("death");
  self endon("entitydeleted");
  waitframe();

  if(vehicle_common::hasvehicle()) {
    childthread function_c83ceb6e70942f51();
  } else {
    self.ragdoll_immediate = 1;
    ai::function_82a45e8aef44ce3f(&function_326136a64ea53234);
  }

  utility::ent_flag_init("script_delete");
  childthread function_b11640f76ee959f();
  childthread function_d5e60857dfeaa1d2();
}

function function_b11640f76ee959f() {
  if(!istrue(self.var_3e727fdba847810e)) {
    return;
  }

  if(!isDefined(level.var_d4192818d4cd16df)) {
    return;
  }

  buildings = sortbydistancecullbyradius(level.var_d4192818d4cd16df, self.origin, 400);

  if(isDefined(buildings) && buildings.size > 0) {
    building = sortbydistance(buildings, self.origin)[0];

    if(building getscriptableparthasstate("base", "pristine") && !utility::is_equal(building getscriptablepartstate("base", 1), "pristine")) {
      var_1ee1da6bb5d47caa = getStructArray("backup_spawns", "targetname");
      var_1ee1da6bb5d47caa = array_sort_by_script_index(var_1ee1da6bb5d47caa);

      if(!flag("tank_b_door_ready")) {
        var_1ee1da6bb5d47caa = array_remove_index(var_1ee1da6bb5d47caa, 2, 1);
      }

      var_1ee1da6bb5d47caa = sortbydistance(var_1ee1da6bb5d47caa, self.origin);

      if(istrue(self.var_aabd96fec70616d7)) {
        if(getdvarint(@ "hash_77c9581a1f270e09") == 1) {
          utility::draw_line_for_time(self.origin, self.origin + (0, 0, 500), 1, 0, 0, 0.1);
          iprintln("<dev string:x25c>");
        }

        if(istrue(self.magic_bullet_shield)) {
          scripts\common\ai::stop_magic_bullet_shield();
        }

        self kill();
        return;
      } else {
        self forceteleport(var_1ee1da6bb5d47caa[0].origin, self.angles, 1);
      }

      if(getdvarint(@ "hash_77c9581a1f270e09") == 1) {
        utility::draw_line_for_time(self.origin, self.origin + (0, 0, 500), 1, 0, 0, 0.1);
        iprintln("<dev string:x281>");
      }
    }
  }
}

function function_d5e60857dfeaa1d2() {
  utility::ent_flag_wait("script_delete");
  buildings = getscriptablearrayinradius("airstrip_buildings", "script_noteworthy", self.origin, 400);

  if(isDefined(buildings) && buildings.size > 0) {
    building = sortbydistance(buildings, self.origin)[0];

    if(building getscriptableparthasstate("base", "pristine") && building getscriptablepartstate("base", 1) != "pristine") {
      structs = utility::getStructArray("final_fallback", "targetname");
      structs = sortbydistance(structs, self.origin);
      thread spawner::go_to_node(structs[0]);
      waittill_any_timeout(10, "death", "reached_path_end");
    }
  }

  self setgoalpos(self.origin);
  self.goalradius = 100;
  start = gettime();

  for(;;) {
    playerpos = level.player getvieworigin();
    playerangles = level.player getplayerangles();

    if(!utility::within_fov(playerpos, playerangles, self.origin, utility::ter_op(level.player utility::isads(), 0.996195, 0.939693)) || utility::time_has_passed(start, 20)) {
      break;
    }

    if(getdvarint(@ "hash_77c9581a1f270e09") == 1) {
      utility::draw_line_for_time(self.origin, self.origin + (0, 0, 500), 1, 0, 0, 0.1);
      iprintln("<dev string:x2b7>");
    }

    wait 0.1;
  }

  if(istrue(self.magic_bullet_shield)) {
    ai::stop_magic_bullet_shield();
  }

  if(getdvarint(@ "hash_77c9581a1f270e09") == 1) {
    utility::draw_line_for_time(self.origin, self.origin + (0, 0, 500), 0, 0, 1, 3);
    iprintln("<dev string:x2d3>");
  }

  self delete();
}

function function_c83ceb6e70942f51() {
  self waittill("get_out_vehicle_finished");
  self.ragdoll_immediate = 1;
  ai::function_82a45e8aef44ce3f(&function_326136a64ea53234);
}

function private function_911ed95e504f2cbc() {
  self endon("entitydeleted");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  origin = self.origin;
  var_ed9401d46fc31e89 = self getentitynumber();
  self waittill("become_corpse");
  corpses = getcorpsearrayinradius(origin, 300);

  foreach(corpse in corpses) {
    var_edd3f70dc543e18b = corpse getentitynumber();

    if(var_ed9401d46fc31e89 == var_edd3f70dc543e18b) {
      corpse setcorpseremovetimer(10);
      break;
    }
  }
}

function private function_326136a64ea53234() {
  waittillframeend();

  if(function_7fd0d9faed5cefc4()) {
    self.ragdoll_immediate = 0;
    self.var_1447d8fee27482b0 = (0, 0, 0);

    if(vehicle_common::hasvehicle() || isDefined(self._blackboard) && istrue(self._blackboard.invehicle)) {
      self hide();
    }

    return false;
  }

  if(isDefined(self.origin)) {
    playFX(level._effect["vfx_gunship_gib_kill_lrg"], self.origin);
  }

  if(isDefined(self.damagemod)) {
    switch (self.damagemod) {
      case #"hash_3c20f39c73a1422b":
      case #"hash_571e46e17a3cf2e3":
      case #"hash_a911a1880d996edb":
        break;
      default:
        self.ragdoll_immediate = 0;
        self.var_1447d8fee27482b0 = (0, 0, 0);
        return false;
    }

    if(isDefined(self.damagedir)) {
      direction = self.damagedir;
    } else {
      direction = vectorNormalize(self.origin - level.player.origin);
    }

    weapon_name = getweaponbasename(self.damageweapon);

    if(utility::is_equal(weapon_name, "none")) {
      if(isDefined(self.var_ff9fac4f6da9c827)) {
        weapon_name = self.var_ff9fac4f6da9c827.basename;
      }
    }

    if(utility::is_equal(weapon_name, level.gunship.var_d6604e5e3d0ba3b7) || utility::is_equal(weapon_name, level.gunship.var_d6604f5e3d0ba5ea)) {
      direction += (max(direction[0], 0.2), max(direction[1], 0.2), max(direction[2], 0.6));
      self.var_1447d8fee27482b0 = direction * randomintrange(6000, 8000);
    } else if(utility::is_equal(weapon_name, level.gunship.var_d6604d5e3d0ba184)) {
      direction += (max(direction[0], 0.2), max(direction[1], 0.2), max(direction[2], 0.4));
      self.var_1447d8fee27482b0 = direction * randomintrange(4500, 5500);
    } else if(utility::is_equal(weapon_name, level.gunship.var_d660505e3d0ba81d)) {
      direction += (max(direction[0], 0.2), max(direction[1], 0.2), 0);
      self.var_1447d8fee27482b0 = direction * randomintrange(2000, 2500);
    } else if(istrue(self.scripted_ragdoll)) {
      direction += (max(direction[0], 0.2), max(direction[1], 0.2), 0);
      self.var_1447d8fee27482b0 = direction * randomintrange(2000, 2500);
    } else {
      self.ragdoll_immediate = 0;
      self.var_1447d8fee27482b0 = (0, 0, 0);
      return false;
    }

    self.var_9deba7456a84f2cb = 1;
    return false;
  }

  return false;
}

function private function_7fd0d9faed5cefc4() {
  if(utility::doinglongdeath()) {
    return true;
  }

  if(vehicle_common::hasvehicle() || isDefined(self._blackboard) && istrue(self._blackboard.invehicle)) {
    return true;
  }

  if(self islinked()) {
    return true;
  }

  if(istrue(self.scripted_ragdoll)) {
    return false;
  }

  if(!utility::is_equal(self.attacker, level.player)) {
    return true;
  }

  if(utility::is_equal(self.model, "fullbody_dog_c")) {
    return true;
  }

  return false;
}

function private function_9de44d948bbdcb69(entity, damage, attacker, direction, point, method, weaponname) {
  if(!isDefined(entity)) {
    return;
  }

  if(!isDefined(point) || !istrue(level.failonfriendlyfire)) {
    friendlyfire::friendly_fire_checkpoints(entity friendlyfire::iscivilian());
    return;
  } else if(!isDefined(entity.damageweapon) || !isDefined(entity.damageweapon.basename) || !isDefined(level.var_a11927e751b21f00[entity.damageweapon.basename])) {
    friendlyfire::friendly_fire_checkpoints(entity friendlyfire::iscivilian());
    return;
  }

  dist = distancesquared(point, entity.origin);
  weaponrange = level.var_a11927e751b21f00[entity.damageweapon.basename];

  if(dist <= weaponrange || isDefined(level.building_center) && function_994370580218d390(point, weaponrange)) {
    level thread friendlyfire::missionfail(entity friendlyfire::iscivilian());
  }
}

function private function_994370580218d390(point, weaponrange) {
  return distancesquared(level.building_center, point) <= weaponrange;
}

function spawnallies(var_c4b2f8e2d1f1aaa4) {
  utility::add_global_spawn_function("allies", &function_ecd0955780c27ad6);
  level.var_2641282ffbf1363d = utility::array_spawn_targetname("team_price", 1);
  level.var_7ea643c0d786d48 = utility::array_spawn_targetname("team_farah", 1);
  utility::array_thread(level.var_7ea643c0d786d48, &utility::name_hide);
  utility::array_thread(level.var_2641282ffbf1363d, &utility::name_hide);
  level.gaz = utility::get_noteworthy_ent("hero_gaz");
  level.farah = utility::get_noteworthy_ent("hero_farah");
  level.price = utility::get_noteworthy_ent("hero_price");
  level.alex = utility::get_noteworthy_ent("hero_alex");
  level.gaz.og_name = "Gaz";
  level.gaz name_show();
  level.farah.og_name = "Farah";
  level.farah name_show();
  level.price.og_name = "Price";
  level.price name_show();
  level.alex.og_name = "Alex";
  level.alex name_show();

  if(!isDefined(level.alex.animname)) {
    level.alex.animname = "alex";
  }

  foreach(guy in [level.farah, level.price]) {
    guy.colornode_func = &function_acb3956c35ede288;
  }

  level.leaders = function_d1b3af1ddf531832();
  level.heros = [level.price, level.gaz, level.farah, level.alex];

  foreach(hero in level.heros) {
    function_b25a44a5635e5ec3(level.location_strings, hero);

    if(!istrue(var_c4b2f8e2d1f1aaa4)) {
      hero thread function_91fff8ef1083babf((0, 0, 0), 1, 1, 0, "icon_waypoint_overlay_marker_friendly_small", 0, 1);
    }
  }

  if(starts::is_after_start("hangar")) {
    foreach(ally in getaiarray("allies")) {
      ally.accuracy = 0;
      ally.baseaccuracy = 0;
    }
  }
}

function function_93adc12f2e2e2314() {
  if(vehicle::isvehicle()) {
    return;
  }

  self.ignoreall = 0;
  self.ignoreme = 0;
  self.dontshootwhilemoving = 0;
}

function function_ecd0955780c27ad6() {
  if(vehicle::isvehicle()) {
    return;
  }

  self.fixednode = 1;
  utility::enable_ai_color();
  self enableavoidance(0, 0);
  self function_95d5375059c2a022("extremerange_jup_gunship", 1);
  self.cornercheckenabled = 0;
  self.var_cbd87a0bc497b778 = 1;
  self function_523285babab34e5b("shallow", 0);
  self function_523285babab34e5b("wide_slice", 0);
  self.var_7811134668469758 = 1;
  self.var_e169a98f19389f0d = 1;
  self function_e99626add202fe1a(1, "script");
  self function_e99626add202fe1a(1, "entity");
  self function_b11b5190b03c861c("none");
  utility::set_maxvisibledist(20000);
  utility::set_maxfaceenemydist(20000);
  utility::demeanor_override("sprint");
  self.ignoresuppression = 1;
  self.dontshootwhilemoving = 0;
  self.forcesuppressai = 1;
  self.forcesuppression = 1;
  thread function_902422951392a8d0();
}

function function_bf0a7de77e684a6f() {
  level endon("mission_failed");

  while(!isDefined(level.gunship)) {
    waitframe();
  }

  weapon_range[level.gunship.var_d660505e3d0ba81d] = 600;
  weapon_range[level.gunship.var_d6604d5e3d0ba184] = 1000;
  weapon_range[level.gunship.var_d6604e5e3d0ba3b7] = 1600;
  weapon_range[level.gunship.var_d6604f5e3d0ba5ea] = 1600;
  function_e35bef1700e801c7();
  var_e22f2381620867a6 = 7;
  var_422270b1854fbbcd = 5;
  civ_starttime = gettime();
  friendly_starttime = gettime();

  for(;;) {
    level waittill("gunship_weapon_impact", position, weaponname);

    if(istrue(level.var_a94a30a9834279af)) {} else if(!isDefined(position) || !isDefined(weaponname) || !isDefined(weapon_range[weaponname])) {} else {
      friendlies = getaiarrayinradius(position, weapon_range[weaponname], "allies");

      if(friendlies.size > 0 && utility::time_has_passed(friendly_starttime, var_422270b1854fbbcd)) {
        if(getdvarint(@ "hash_d66700486b384ffd", 0) == 1) {
          thread function_51bd35a827263b5a(friendlies, weapon_range[weaponname]);
        }

        vo_pair = level.var_20b74ca07d00eef9 utility::deck_draw();
        vo_response = level.var_e1b7a9406902445 utility::deck_draw();
        speaker = vo_pair[0];
        alias = vo_pair[1];

        if(!isDefined(speaker)) {
          iprintln("<dev string:x2dd>" + alias + "<dev string:x2fe>");
        } else {
          speaker dialogue::say(alias, 0, 0);
          level dialogue::say_team(vo_response, 0, 0);
          friendly_starttime = gettime();
        }
      }
    }

    waitframe();
  }
}

function private function_e35bef1700e801c7() {
  aliases = [];
  aliases[aliases.size] = [level.price, "dx_sp_jsgs_psh1_pric_blueblue"];
  aliases[aliases.size] = [level.price, "dx_sp_jsgs_psh1_pric_checkfirecheckfire"];
  aliases[aliases.size] = [level.price, "dx_sp_jsgs_psh1_pric_shadow1calldangerclo"];
  aliases[aliases.size] = [level.alex, "dx_sp_jsgs_psh1_alex_blueblueblue"];
  aliases[aliases.size] = [level.alex, "dx_sp_jsgs_psh1_alex_checkfirewhatthefuck"];
  aliases[aliases.size] = [level.alex, "dx_sp_jsgs_psh1_alex_shadow1checkfire"];
  aliases[aliases.size] = [level.gaz, "dx_sp_jsgs_psh1_gazz_checkyourbloodyfire"];
  aliases[aliases.size] = [level.gaz, "dx_sp_jsgs_psh1_gazz_shadow1checkfire"];
  aliases[aliases.size] = [level.gaz, "dx_sp_jsgs_psh1_gazz_watchyourfire"];
  aliases[aliases.size] = [level.farah, "dx_sp_jsgs_psh1_fara_blueblue"];
  aliases[aliases.size] = [level.farah, "dx_sp_jsgs_psh1_fara_checkyourfire"];
  aliases[aliases.size] = [level.farah, "dx_sp_jsgs_psh1_fara_shadow1tellyourmanto"];
  level.var_20b74ca07d00eef9 = utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_gunnercheckfire";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_thatsdangerfuckinclo";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_checkyourshotsyouref";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_gunnerdonotfireonthe";
  level.var_e1b7a9406902445 = utility::create_deck(aliases);
}

function private function_51bd35a827263b5a(guys, range) {
  starttime = gettime();

  while(!utility::time_has_passed(starttime, 15)) {
    guys = utility::array_removeundefined(guys);

    if(guys.size < 1) {
      break;
    }

    foreach(guy in guys) {
      thread utility::draw_circle(guy.origin, range, (0, 1, 1), 1, 0, 5);
    }

    wait 0.25;
  }
}

function function_221bd87d1124cb33(tname, teamarray) {
  teamarray = utility::array_remove(teamarray, self);
  utility::set_movement_speed(240);

  foreach(guy in teamarray) {
    if(isDefined(level.leaders[guy.script_noteworthy])) {
      guy followtheleader(level.leaders[guy.script_noteworthy]);
    }
  }
}

function private function_d1b3af1ddf531832() {
  leaders["hero_gaz"] = level.price;
  leaders["price_reds"] = level.price;
  leaders["hero_alex"] = level.farah;
  leaders["farah_reds"] = level.farah;

  foreach(leader in leaders) {
    if(leader != level.gaz && leader != level.alex) {
      leader utility::set_movement_speed(200);
    }
  }

  return leaders;
}

function private followtheleader(leader) {
  minspeed = 200;
  midspeed = 220;
  maxspeed = 240;
  self.follow_ent = leader;
  thread utility::enable_dynamic_run_speed(self.follow_ent, midspeed, midspeed, maxspeed, -200, -400, -600);
}

function function_5953613468fbd36d(var_35846d3fa02e97a3, leader, teamarray) {
  struct = utility::getStruct(var_35846d3fa02e97a3, "targetname");

  foreach(guy in teamarray) {
    guy forceteleport(struct.origin, utility::default_to(struct.angles, (0, 0, 0)), 1, 1);
  }

  leader thread function_221bd87d1124cb33(var_35846d3fa02e97a3, teamarray);
}

function function_ed81e1e22cdebb(targetname, forcespawn, perfectenemyinfo, var_75c15e716113c51b, origin, angles) {
  struct = utility::getStruct(targetname, "targetname");
  return struct function_b6b63adfa858c0e8(struct.script_aitype, forcespawn, perfectenemyinfo, var_75c15e716113c51b, origin, angles);
}

function function_de001f4d27208780(targetname, forcespawn, perfectenemyinfo, var_75c15e716113c51b, origin, angles) {
  structs = utility::getStructArray(targetname, "targetname");
  guys = [];

  foreach(struct in structs) {
    guys[guys.size] = struct function_b6b63adfa858c0e8(struct.script_aitype, forcespawn, perfectenemyinfo, var_75c15e716113c51b, origin, angles);
  }

  return utility::array_removeundefined(guys);
}

function private function_b6b63adfa858c0e8(aitype, forcespawn, perfectenemyinfo, var_75c15e716113c51b, origin, angles) {
  assert(isDefined(aitype));
  println(aitype);
  origin = utility::default_to(origin, utility::default_to(self.origin, (0, 0, 0)));
  angles = utility::default_to(angles, utility::default_to(self.angles, (0, 0, 0)));
  forcespawn = utility::default_to(forcespawn, 0);
  perfectenemyinfo = utility::default_to(perfectenemyinfo, 1);
  var_75c15e716113c51b = utility::default_to(var_75c15e716113c51b, 0);
  var_31ec807024c58aa3 = getaicount("all");
  lightweight = getaicount("all", "all", "lightweight");
  var_31ec807024c58aa3 -= lightweight;

  if(var_31ec807024c58aa3 > 48) {
    if(!istrue(self.script_suspend)) {
      iprintln("<dev string:x312>" + aitype + "<dev string:x33a>" + origin);

      return;
    }

    for(;;) {
      var_31ec807024c58aa3 = getaicount("all");

      if(var_31ec807024c58aa3 < 46) {}

      wait 0.1;
    }
  }

  guy = utility::spawn_aitype(aitype, origin, angles, forcespawn, perfectenemyinfo, var_75c15e716113c51b, self.targetname);

  if(!isDefined(guy)) {
    iprintln("<dev string:x343>" + aitype + "<dev string:x33a>" + origin + "<dev string:x34d>");

    return;
  }

  guy.var_3e727fdba847810e = 1;

  if(isDefined(self.script_noteworthy)) {
    guy.script_noteworthy = self.script_noteworthy;
  }

  if(isDefined(self.script_animname)) {
    guy.script_animname = self.script_animname;
    guy.animname = guy.script_animname;
  } else if(isDefined(self.animname)) {
    guy.animname = self.animname;
  }

  if(isDefined(self.script_ignoreall)) {
    guy.ignoreall = self.script_ignoreall;
  }

  if(isDefined(self.script_ignoreme)) {
    guy.ignoreme = self.script_ignoreme;
  }

  if(isDefined(self.script_startinghealth)) {
    guy.script_startinghealth = self.script_startinghealth;
    guy.health = self.script_startinghealth;
  }

  if(isDefined(self.script_demeanor)) {
    guy utility::demeanor_override(self.script_demeanor);
  }

  if(isDefined(self.target)) {
    node = utility::getent_or_struct(self.target, "targetname");
    guy thread spawner::go_to_node(node);
  }

  guy.var_6308088457db06da = utility::get_linked_structs();

  if(!isDefined(guy.var_6308088457db06da) || guy.var_6308088457db06da.size < 1) {
    guy.var_6308088457db06da = utility::get_linked_ents();
  }

  return guy;
}

function private function_902422951392a8d0() {
  self.beacon_ent = utility::spawn_tag_origin();
  tag = "j_shouldertwist_le";
  offest = (0, 0, 3);
  self.beacon_ent.origin = self gettagorigin(tag) + offest;
  self.beacon_ent linkTo(self, tag);
  thread utility::delete_on_death(self.beacon_ent);
  self endon("death");
  wait 0.1 + randomfloat(0.5);
  playFXOnTag(utility::getfx("vfx_thermal_beacon_ai"), self.beacon_ent, "tag_origin");
}

function function_a44e35e2dc63be50(team, amount, timeout, ender, delay_post, struct, radius, ignore) {
  assert(isDefined(amount));

  if(isDefined(ender)) {
    if(utility::flag_exist(ender) && utility::flag(ender)) {
      return;
    }

    level endon(ender);
  }

  start_time = undefined;

  if(isDefined(timeout)) {
    start_time = gettime();
  }

  for(;;) {
    if(isDefined(radius)) {
      guys = getaiarrayinradius(struct.origin, radius, team);
    } else if(isarray(team)) {
      guys = team;
    } else {
      guys = getaiarray(team);
    }

    if(isDefined(ignore)) {
      guys = utility::array_remove_array(guys, ignore);
    }

    guys = utility::array_removedead_or_dying(guys);

    if(guys.size <= amount) {
      break;
    }

    if(isDefined(timeout)) {
      if(utility::time_has_passed(start_time, timeout)) {
        break;
      }
    }

    waitframe();
  }

  wait utility::default_to(delay_post, 0);
}

function function_92b79f29b8902c80(var_c69d515dbd91831, target, time, ender, var_adc84358e78019fa) {
  if(!istrue(var_adc84358e78019fa)) {
    waitframe();
    result = var_c69d515dbd91831 function_abd3bb43c25ffaf6(time);

    if(!istrue(result)) {
      return;
    }
  }

  if(isstring(target)) {
    struct = getStruct(target, "targetname");
    target = getStruct(struct.target, "targetname");
  }

  target.is_override = 1;
  flag_clear("thermal_laser_kill");
  target_obj = spawn_tag_origin(target.origin);
  target_obj thread function_5226628d0f36b9c7(var_c69d515dbd91831, target, ender);
  var_c69d515dbd91831.ignoreme = 1;
  var_c69d515dbd91831.var_6cd45c851740a435 = target_obj;
  var_c69d515dbd91831.green_beam = 1;
  var_c69d515dbd91831.var_4f088434309b2333 = "iw8_laser_painter_ac130_lasso_thermal";
  starttime = undefined;
  var_c69d515dbd91831 scripts\common\cap::cap_start("cap_green_beam", "cap_green_beam", 0);
  waitframe();
  var_c69d515dbd91831 function_372c614657bc4ec1(target_obj, time, target, ender);

  if(isDefined(target)) {
    target.is_override = 0;
  }

  level notify("stop_lasso_mover");

  if(isDefined(var_c69d515dbd91831)) {
    var_c69d515dbd91831.green_beam = 0;
    var_c69d515dbd91831.ignoreme = 0;
    var_c69d515dbd91831.var_4f088434309b2333 = undefined;
  }

  if(isDefined(target_obj)) {
    target_obj delete();
  }
}

function private function_372c614657bc4ec1(target_obj, time, target_guy, ender) {
  self endon("death");
  self endon("long_death");
  self endon("entitydeleted");
  self endon("thermal_laser_kill");
  self endon("new_color_being_set");
  target_guy endon("death");
  target_guy endon("long_death");
  target_guy endon("entitydeleted");
  target_obj endon("death");
  target_obj endon("entitydeleted");

  if(isDefined(ender)) {
    level endon(ender);
  }

  level endon("thermal_laser_kill");

  if(isDefined(time)) {
    childthread flag_set_delayed("thermal_laser_kill", time);
  }

  flag_wait("thermal_laser_kill");
}

function private function_5226628d0f36b9c7(var_c69d515dbd91831, target_guy, ender) {
  level endon("stop_lasso_mover");
  var_c69d515dbd91831 endon("death");
  target_guy endon("death");

  if(isDefined(ender)) {
    level endon(ender);
  }

  radius = randomintrange(40, 50);
  speed = 35;
  i = 360;

  while(true) {
    if(!isDefined(var_c69d515dbd91831) || !isDefined(target_guy)) {
      break;
    }

    if(i < 0) {
      i = 360;
    }

    if(isai(target_guy)) {
      self unlink();
    }

    up = anglestoup(target_guy.angles);
    forward = (0, 1, 0);
    self.origin = target_guy.origin + rotatepointaroundvector(up, forward, i) * radius;
    speed += randomfloatrange(-2, 2);
    speed = clamp(speed, 30, 40);
    i -= speed;

    if(isai(target_guy)) {
      self linkTo(var_c69d515dbd91831);
    }

    waitframe();
  }
}

function private initvehicles() {
  function_26b13117f5d461e1();
  level.vehicle.templates.unloadgroups["script_vehicle_iw9_mil_air_heli_medium"]["driver_group"] = [0];
  level.vehicle.templates.unloadgroups["script_vehicle_iw9_mil_air_heli_medium"]["ground_group"] = [1, 2, 4, 5, 6, 7];
  level.vehicle.templates.unloadgroups["script_vehicle_iw9_mil_air_heli_medium"]["rpg_group"] = [3];
  level.vehicle.templates.surface_effects["script_vehicle_iw9_mil_air_heli_medium"]["default"] = level._effect["vfx_gns_treadfx_heli_wash_01"];
  level.vehicle.spawn_callback_thread = &function_4ac00f34fd2b8e67;
}

function private function_26b13117f5d461e1() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") == 1) {
    return;
  }

  effect = "vfx/jup/prop/scriptables/jup_urz_military_airstrip_heli_medium_01_air.vfx";
  tag = "tag_origin";
  sound = "veh_lbravo_explode";
  var_8c20807be5f063b3 = "script_vehicle_iw9_mil_air_heli_medium";

  if(!isDefined(level.vehicle.templates.vehicle_death_fx[var_8c20807be5f063b3])) {
    level.vehicle.templates.vehicle_death_fx[var_8c20807be5f063b3] = [];
  }

  level.vehicle.templates.vehicle_rocket_death_fx[var_8c20807be5f063b3][level.vehicle.templates.vehicle_death_fx[var_8c20807be5f063b3].size] = scripts\common\vehicle_build::build_fx(effect, tag, sound, undefined, undefined, 0, 0, 0, undefined, undefined, undefined);
}

function private function_4ac00f34fd2b8e67(vehicle) {
  vehicle.customattackfunc = &emptyfunc;
  waitframe();

  if(vehicle.script_team != "allies") {
    vehicle function_fc413af8a41f5a8f();
    vehicle thread function_3efe19a5f3668974();
  }

  if(isplatformxb3() || isplatformps4()) {
    if(!istrue(vehicle.istank) && !vehicle vehicle::ishelicopter()) {
      var_cd0bc29e189d66d9 = [];
      var_cd0bc29e189d66d9[var_cd0bc29e189d66d9.size] = "tag_origin";
      var_cd0bc29e189d66d9[var_cd0bc29e189d66d9.size] = "tag_body";
      var_cd0bc29e189d66d9[var_cd0bc29e189d66d9.size] = "tag_wheel_center_back_left";
      var_cd0bc29e189d66d9[var_cd0bc29e189d66d9.size] = "tag_wheel_center_back_right";
      var_cd0bc29e189d66d9[var_cd0bc29e189d66d9.size] = "tag_wheel_center_front_left";
      var_cd0bc29e189d66d9[var_cd0bc29e189d66d9.size] = "tag_wheel_center_front_right";
      var_cd0bc29e189d66d9[var_cd0bc29e189d66d9.size] = "tag_door_front_left";
      var_cd0bc29e189d66d9[var_cd0bc29e189d66d9.size] = "tag_door_front_right";
      var_cd0bc29e189d66d9[var_cd0bc29e189d66d9.size] = "tag_door_back_left";
      var_cd0bc29e189d66d9[var_cd0bc29e189d66d9.size] = "tag_door_back_right";
      var_cd0bc29e189d66d9[var_cd0bc29e189d66d9.size] = "tag_hood";
      var_cd0bc29e189d66d9[var_cd0bc29e189d66d9.size] = "tag_trunk";
      var_cd0bc29e189d66d9[var_cd0bc29e189d66d9.size] = "tag_windshield_front";
      vehicle function_3b0f548face4361e(var_cd0bc29e189d66d9);
    }
  }
}

function private emptyfunc() {}

function function_9c79eba669b9f05a() {
  self endon("death");
  self.intro_targets = getStructArray(self.targetname + "_intro_targets", "targetname");
  self.targets = getStructArray(self.targetname + "_targets", "targetname");
  self.intro_targets = utility::array_sort_by_script_index(self.intro_targets);
  self.targets = utility::array_sort_by_script_index(self.targets);
  self.target_ent = self.intro_targets[0] spawn_tag_origin();
  self.mainturret delete();
  self.mainturret = spawnturret("misc_turret", self gettagorigin("tag_turret"), "jup_tur_cougar_sp_gs", 0);
  self.mainturret linkTo(self, "tag_turret", (0, 0, 0), (0, 0, 0));
  self.mainturret setModel("veh9_mil_lnd_tank_cougar_turret");
  self.mainturret setmode("manual");
  self.mainturret makeunusable();
  self.mainturret setdefaultdroppitch(0);
  self.mainturret setturretmodechangewait(1);
  self.mainturret.angles = self.angles;
  self.mainturret.vehicle = self;
  self.mainturret.maxhealth = 999999;
  self.mainturret.health = self.mainturret.maxhealth;
  self.mainturret setCanDamage(0);
  self.mainturret settargetentity(self.target_ent);
  self.mgturret[0] delete();
  self.mgturret[0] = spawnturret("misc_turret", self gettagorigin("tag_turret"), "jup_mg_cougar_sp_gs", 0);
  self.mgturret[0] linkTo(self, "tag_turret", (-20, 0, 32), (0, 0, 0));
  self.mgturret[0] setModel("veh9_mil_lnd_tank_cougar_turret_gun");
  self.mgturret[0] setmode("manual");
  self.mgturret[0] makeunusable();
  self.mgturret[0].angles = self.angles;
  self.mgturret[0].vehicle = self;
  self.mgturret[0].maxhealth = 999999;
  self.mgturret[0].health = self.mgturret[0].maxhealth;
  self.mgturret[0] setCanDamage(0);
  self.mgturret[0] settargetentity(level.player);
  self.mgturret[0] setdefaultdroppitch(0);
  self.mgturret[0] setleftarc(360);
  self.mgturret[0] setrightarc(360);
  self.mgturret[0] settoparc(360);
  self.mgturret[0] setbottomarc(360);
  childthread function_664faad52a23eec7();
  childthread function_9a211ca8b0ae2d43();
  self.mgturret[0] function_8bd5f380528bf432(60000);
}

function function_664faad52a23eec7() {
  childthread function_8af9f274b3b81d36();
  flag_wait(self.targetname + "_start_shooting");
  var_c17be7c497bd4834 = self.targets.size - 3;

  if(var_c17be7c497bd4834 > self.targets.size) {
    var_c17be7c497bd4834 = self.targets.size;
  }

  target = undefined;

  if(level.gameskill > 1) {
    self.targets = array_remove_index(self.targets, 0, 1);
  }

  foreach(target in self.targets) {
    if(i == var_c17be7c497bd4834) {
      utility::flag_set(self.targetname + "_move_up");
    }

    function_a62103d58f38fb1c(target);
  }

  self.mainturret thread notify_delay("impactTimeout", 5);
  self.mainturret waittill_any_2("projectile_impact", "impactTimeout");
  wait 0.2;
  function_277990754d304280(target.origin);
  wait 1;
  player_death::clear_custom_death_quote();
  player_death::set_custom_death_quote(253);
  thread utility::missionfailedwrapper();
}

function function_243e92b9d0688f39(target) {
  self waittill("missile_fire", missile);
  missile waittill("explode", origin, hitnormal, velocity, entity);
  thread function_62f93285d84dded3(origin);
  radius = default_to(target.radius, 100);
  weapon = "gunship_hellfire_jup_sp";

  if(isDefined(entity) && isDefined(entity.model) && issubstr(entity.model, "hangar")) {
    weapon = "gunship_40mm_jup_sp";
  }

  self radiusdamage(origin, radius, 250, 250, self, "MOD_EXPLOSIVE", weapon, 1, 0);

  if(getdvarint(@ "hash_478938d2ae5d86", 0) == 1) {
    utility::draw_circle(origin, radius, (0, 0, 1), 1, 0, 50);
  }
}

function function_8af9f274b3b81d36() {
  self endon("reached_end_node");
  level endon(self.targetname + "_start_shooting");
  utility::flag_wait(self.targetname + "_intro_shots");

  foreach(target in self.intro_targets) {
    function_a62103d58f38fb1c(target);

    if(i >= 5) {
      utility::flag_set(self.targetname + "_intro_move");
    }
  }
}

function function_a62103d58f38fb1c(target) {
  delay = default_to(target.script_delay, 2);
  self.target_ent.origin = target.origin;
  self.mainturret waittill("turret_on_target");
  wait delay;

  if(getdvarint(@ "hash_478938d2ae5d86", 0) == 1) {
    childthread draw_line_for_time(self.mainturret.origin, target.origin, 1, 0, 0, delay);
  }

  self.mainturret childthread function_243e92b9d0688f39(target);
  thread function_f7ee9448704d5a66();
  projectile = self.mainturret shootturret("tag_flash", 0);
}

function function_9a211ca8b0ae2d43() {
  self.mgturret[0] startbarrelspin();
  self.mgturret[0] childthread function_d2a80b47d23b9bdd();

  if(self.targetname == "bunker_tank") {
    utility::flag_wait(self.targetname + "_intro_shots");
    wait 4;
    function_652f8a23200f8dc8(10, self.targetname + "_start_shooting");
    utility::flag_wait(self.targetname + "_start_shooting");
    function_652f8a23200f8dc8(8);
    return;
  }

  utility::flag_wait(self.targetname + "_intro_move");
  wait 15;
  function_652f8a23200f8dc8(12, self.targetname + "_start_shooting");
  utility::flag_wait(self.targetname + "_start_shooting");
  wait 14;
  function_652f8a23200f8dc8(10);
}

function function_d2a80b47d23b9bdd() {
  for(;;) {
    self waittill("missile_fire", projectile_object);

    if(isDefined(projectile_object)) {
      function_25eadd19d87ff8f3(projectile_object);
    }
  }
}

function function_652f8a23200f8dc8(delay, ender) {
  if(isDefined(ender)) {
    level endon(ender);
  }

  for(i = 0; i < 2; i++) {
    self.mgturret[0] shootturret();
    level.player playSound("weap_missile_launch_radio");

    if(getdvarint(@ "hash_478938d2ae5d86", 0) == 1) {
      childthread draw_line_for_time(self.mgturret[0].origin, self.target_ent.origin, 0, 1, 1, 0.1);
    }

    wait delay - level.gameskill;
  }
}

function function_36137bad614b6ea6() {
  flag_clear("stop_shooting");
  self endon("death");
  self endon("stop_shooting");
  var_2e39c070bc714f3f = 5;
  var_35adf33372612664 = 10;
  var_be7d22bc5c5fffd8 = 0.25;

  if(isDefined(self.mainturret)) {
    turret = self.mainturret;
  } else {
    turret = self.mgturret[0];
  }

  gunner = undefined;

  foreach(guy in self.attachedguys) {
    if(is_equal(guy.script_startingposition, 4)) {
      gunner = guy;
      break;
    }
  }

  if(isDefined(gunner)) {
    self.gunner = gunner;
    gunner endon("death");
    gunner endon("stop_shooting");
    teams = ["axis", "allies", "team3", "neutral"];
    teams = array_remove(teams, default_to(self.team, gunner.team));

    for(;;) {
      foreach(team in teams) {
        foreach(guy in getaiarray(team)) {
          gunner getenemyinfo(guy);
        }
      }

      if(!gunner iscurrentenemyvalid()) {} else {
        while(!gunner aimedataimtarget()) {
          waitframe();
        }

        var_ae62bfa8f34628a5 = gettime() + var_35adf33372612664 * 1000;
        var_f56a71c89cdee7a6 = 0;

        while(var_ae62bfa8f34628a5 > gettime()) {
          flag_waitopen("stop_shooting");
          var_f56a71c89cdee7a6 = 1;
          turret shootturret();
          wait var_be7d22bc5c5fffd8;
          waitframe();
        }

        if(istrue(var_f56a71c89cdee7a6)) {
          wait var_2e39c070bc714f3f;
        }
      }

      waitframe();
    }

    return;
  }

  turret startfiring();
}

function private function_75e9f8f2202d3546() {
  self endon("vehicle_hints_25mm_done");

  while(self.var_ec323ebd56883aa4 < 2) {
    self waittill("damage", dmg, attacker, dir, point, meansofdamage, model, tag, part, idflag, objweapon);

    if(scripts\engine\utility::ent_flag("unloaded")) {
      break;
    }

    var_3e5265936058aaec = level.gameskill > 1;
    timeout = utility::ter_op(var_3e5265936058aaec, 20, 10);

    if(isDefined(objweapon) && issubstr(objweapon.basename, "_25mm") && utility::time_has_passed(self.var_6e779d6cc9a06738, timeout)) {
      self.var_ec323ebd56883aa4++;
      self.var_6e779d6cc9a06738 = gettime();

      if(!utility::flag("disable_vehicle_hints")) {
        displaytime = utility::ter_op(var_3e5265936058aaec, 5, 10);
        thread utility::display_hint("vehicle_ammo", displaytime, 0.2);
      }

      wait timeout;
    }
  }

  self notify("vehicle_hints_25mm_done");
}

function private function_fc413af8a41f5a8f() {
  self.istank = 0;

  if(vehicle::ishelicopter()) {
    thread pilotinit();
    self.crash_speed = 200;
    self.heli_crash_indirect_zoff = 100;
    self.vehicle_skipdeathcrash = 1;
    self.unload_land_offset = 160;
    self.unload_hover_land_height = 160;
    self.unload_hover_offset_max = 160;

    if(istrue(self.bossheli)) {
      self.preferred_crash_style = 4;
      self.script_allow_driver_death = 0;
    } else {
      self.preferred_crash_style = 3;
    }
  }

  if(self.targetname == "bunker_tank" || self.targetname == "tower_tank") {
    self.istank = 1;
    function_9c79eba669b9f05a();
  }

  foreach(guy in self.attachedguys) {
    if(istrue(self.bossheli)) {
      guy.ignoreme = 1;
      guy utility::set_attackeraccuracy(0);
    }

    guy.canshootinvehicle = 1;
    guy.var_c7845d939c783cef = 1;
    guy.ignoreall = 0;
    guy getenemyinfo(level.price);
    guy.health = 20;

    if(is_equal(guy.script_startingposition, 0)) {
      driver = guy;
      break;
    }
  }

  vehicle::godon();
  self endon("death");
  self endon("kill_vehicle_damage_thread");
  function_7eb9641bd821ee21();
  childthread vehicledamage();
}

function private pilotinit() {
  self endon("death");

  while(!isDefined(self.riders[0])) {
    waitframe();
  }

  pilot = undefined;
  wait 0.1;

  foreach(guy in self.riders) {
    if(utility::is_equal(guy.script_startingposition, 0)) {
      pilot = guy;
    }
  }

  if(!isDefined(pilot)) {
    return;
  }

  self.script_allow_driver_death = 0;
  pilot.allowdeath = 0;
  pilot.script_allowdeath = 0;
  pilot.ignoreme = 1;
  pilot utility::set_attackeraccuracy(0);
  pilot.health = 99999;
  pilot visiblenotsolid();
  pilot thread function_b0c2e83fe3977b15(self);
}

function private function_b0c2e83fe3977b15(heli) {
  self waittill("death", attacker, meansofdeath, weaponobject, damagelocation);

  if(isDefined(heli) && isalive(heli)) {
    if(isDefined(self)) {
      self delete();
    }

    if(heli vehicle::vehicle_is_crashing() || !isPlayer(attacker)) {
      return;
    }

    heli.pilot_killed = 1;
  }
}

function private vehicledamage() {
  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin);

    if(!isPlayer(attacker) || !isDefined(objweapon) || !isDefined(objweapon.basename)) {} else {
      function_2f1d92650ff34b41(objweapon, damagelocation);

      if(function_cd45f8d22327f81(objweapon)) {
        break;
      }
    }

    waitframe();
  }

  thread vehicledeath(origin, attacker, meansofdeath, objweapon, damagelocation);
}

function function_f49a8d417f7a820b() {
  self endon("death");
  utility::waittill_any_3("unloading", "unloaded", "get_out_vehicle_finished");

  if(istrue(self.magic_bullet_shield)) {
    stop_magic_bullet_shield();
  }

  self.health = 20;

  if(isDefined(self.script_startinghealth)) {
    self.script_startinghealth = self.health;
  }
}

function function_7eb9641bd821ee21() {
  self.var_17d2a2a24229dc42 = 0;
  self.var_75f6977603250653 = 0;
  self.hits_missile = 0;
  self.var_ec323ebd56883aa4 = 0;
  self.var_6e779d6cc9a06738 = 0;
  self.var_c4ae4d099152961b = 0;

  if(istrue(self.istank)) {
    self.var_60896e97a711519b["ground"] = 10;
    self.var_30cbca2521d5ec76["ground"] = 45;
    self.var_333b6898f00b6a3b["ground"] = 1;
    self.var_60896e97a711519b["ground_vet"] = 20;
    self.var_30cbca2521d5ec76["ground_vet"] = 90;
    self.var_333b6898f00b6a3b["ground_vet"] = 1;
    return;
  }

  if(istrue(self.var_f0f5c5926c19b569)) {
    self.var_60896e97a711519b["ground"] = 10;
    self.var_30cbca2521d5ec76["ground"] = 60;
    self.var_333b6898f00b6a3b["ground"] = 1;
    self.var_60896e97a711519b["ground_vet"] = 15;
    self.var_30cbca2521d5ec76["ground_vet"] = 90;
    self.var_333b6898f00b6a3b["ground_vet"] = 1;
    return;
  }

  if(istrue(self.bossheli)) {
    self.var_60896e97a711519b["air"] = 1;
    self.var_30cbca2521d5ec76["air"] = 6;
    self.var_333b6898f00b6a3b["air"] = 0.5;
    self.var_60896e97a711519b["air_vet"] = 1;
    self.var_30cbca2521d5ec76["air_vet"] = 12;
    self.var_333b6898f00b6a3b["air_vet"] = 1;
    return;
  }

  self.var_60896e97a711519b["air"] = 1;
  self.var_30cbca2521d5ec76["air"] = 4;
  self.var_333b6898f00b6a3b["air"] = 0.5;
  self.var_60896e97a711519b["ground"] = 2;
  self.var_30cbca2521d5ec76["ground"] = 10;
  self.var_333b6898f00b6a3b["ground"] = 1;
  self.var_60896e97a711519b["air_vet"] = 1;
  self.var_30cbca2521d5ec76["air_vet"] = 8;
  self.var_333b6898f00b6a3b["air_vet"] = 1;
  self.var_60896e97a711519b["ground_vet"] = 4;
  self.var_30cbca2521d5ec76["ground_vet"] = 15;
  self.var_333b6898f00b6a3b["ground_vet"] = 1;
}

function function_2f1d92650ff34b41(objweapon, origin) {
  dist = distance(self.origin, origin);
  damagepart = "damageHeavy";
  var_be2712579c61088f = 3;

  if(objweapon.basename == level.gunship.var_d6604d5e3d0ba184) {
    if(dist < 200) {
      self.var_17d2a2a24229dc42 += 1;
    } else if(dist > 200 && dist < 400) {
      self.var_17d2a2a24229dc42 += 0.5;
    }

    if(self.var_17d2a2a24229dc42 < 1) {
      damagepart = "damageMedium";
      var_be2712579c61088f = 2;
    }
  } else if(objweapon.basename == level.gunship.var_d660505e3d0ba81d) {
    if(dist < 100) {
      self.var_75f6977603250653 += 1;
    } else if(dist > 100 && dist < 200) {
      self.var_75f6977603250653 += 0.5;
    }

    damagepart = "damageLight";
    var_be2712579c61088f = 1;

    if(self.var_75f6977603250653 >= 4) {
      damagepart = "damageHeavy";
      var_be2712579c61088f = 3;
    } else if(self.var_75f6977603250653 >= 2) {
      damagepart = "damageMedium";
      var_be2712579c61088f = 2;
    }
  } else {
    if(dist < 1000) {
      self.hits_missile += 1;
    } else if(dist > 1000 && dist < 2000) {
      self.hits_missile += 0.5;
    }

    if(self.hits_missile < 1) {
      damagepart = "damageMedium";
      var_be2712579c61088f = 2;
    }
  }

  if(self isscriptable() && function_6f655d0052a59180(var_be2712579c61088f)) {
    if(istrue(self.istank)) {
      if(self getscriptableparthasstate("husk_constant_fire", "on")) {
        state = self getscriptablepartstate("husk_constant_fire", 1);

        if(!utility::is_equal(state, "on")) {
          self setscriptablepartstate("husk_constant_fire", "on", 1);
        }
      }

      if(self getscriptableparthasstate("damageHeavy", "on")) {
        state = self getscriptablepartstate("damageHeavy", 1);

        if(!utility::is_equal(state, "on")) {
          self setscriptablepartstate("damageHeavy", "on", 1);
        }
      }

      if(self getscriptableparthasstate("damageEngine", "explode")) {
        state = self getscriptablepartstate("damageEngine", 1);

        if(!utility::is_equal(state, "explode")) {
          self setscriptablepartstate("damageEngine", "explode", 1);
        }
      }

      if(self getscriptableparthasstate("tag_reactive_armor_body_left1", "death")) {
        state = self getscriptablepartstate("tag_reactive_armor_body_left1", 1);

        if(!utility::is_equal(state, "death")) {
          self setscriptablepartstate("tag_reactive_armor_body_left1", "death", 1);
        }
      }

      if(self getscriptableparthasstate("tag_reactive_armor_body_right2", "death")) {
        state = self getscriptablepartstate("tag_reactive_armor_body_right2", 1);

        if(!utility::is_equal(state, "death")) {
          self setscriptablepartstate("tag_reactive_armor_body_right2", "death", 1);
        }
      }

      return;
    }

    if(function_6f655d0052a59180(var_be2712579c61088f) && self getscriptableparthasstate(damagepart, "highSpeed")) {
      state = self getscriptablepartstate(damagepart, 1);

      if(!utility::is_equal(state, "highSpeed")) {
        self.var_c4ae4d099152961b = var_be2712579c61088f;
        self setscriptablepartstate(damagepart, "highSpeed", 1);
      }
    }
  }
}

function function_6f655d0052a59180(var_be2712579c61088f) {
  if(var_be2712579c61088f > self.var_c4ae4d099152961b) {
    return true;
  }

  return false;
}

function function_cd45f8d22327f81(objweapon) {
  indexstring = function_23a993131600d3db();

  if(self.var_17d2a2a24229dc42 >= self.var_60896e97a711519b[indexstring]) {
    return true;
  }

  if(self.var_75f6977603250653 >= self.var_30cbca2521d5ec76[indexstring]) {
    return true;
  }

  if(self.hits_missile >= self.var_333b6898f00b6a3b[indexstring]) {
    return true;
  }

  return false;
}

function function_23a993131600d3db() {
  var_3e5265936058aaec = level.gameskill > 1;
  isair = vehicle::ishelicopter();

  if(isair && !var_3e5265936058aaec) {
    return "air";
  }

  if(!isair && !var_3e5265936058aaec) {
    return "ground";
  }

  if(isair && var_3e5265936058aaec) {
    return "air_vet";
  }

  if(!isair && var_3e5265936058aaec) {
    return "ground_vet";
  }
}

function vehicledeath(istank, origin, attacker, meansofdeath, objweapon, damagelocation) {
  if(istrue(self.bossheli)) {
    if(isDefined(self.riders) && self.riders.size > 0) {
      riders = utility::array_removedead_or_dying(self.riders);

      foreach(rider in riders) {
        if(istrue(rider.magic_bullet_shield)) {
          rider ai::stop_magic_bullet_shield();
        }

        rider kill();
      }
    }

    function_2a445bdbafbe25b0();
    return;
  }

  vehicle::godoff();

  if(isDefined(self)) {
    if(isDefined(self.riders) && self.riders.size > 0) {
      riders = utility::array_removedead_or_dying(self.riders);

      if(isDefined(riders) && riders.size > 0) {
        if(istrue(self.var_5f27140991d90c2d) && !istrue(self.is_unloaded)) {
          thread vehicle::vehicle_unload();
          self.is_unloaded = 1;
        } else {
          foreach(rider in riders) {
            if(istrue(rider.magic_bullet_shield)) {
              rider ai::stop_magic_bullet_shield();
            }

            rider kill();
          }
        }
      }
    }

    if(istrue(self.istank)) {
      utility::autosave_by_name(self.targetname + "_dead");
      origin = self.origin;
      angles = self.angles;
      self.mainturret setModel("veh9_mil_lnd_tank_cougar_turret_dst");
      self.mgturret[0] setModel("veh9_mil_lnd_tank_cougar_turret_gun_dst");

      if(isDefined(self.marker)) {
        thread function_af35587070d32e44(0.5);
      }

      thread utility::flag_set_delayed(self.targetname + "_dead", 2);
      fake_husk = spawn_tag_origin(origin, angles);
      fake_husk setModel("veh9_mil_lnd_tank_cougar_x_vehphys_hsk_sp");
      fake_husk thread delete_on_death(self.mgturret[0]);
    }

    if(vehicle::ishelicopter()) {
      self.healthstarting = 100000;
      playFX(utility::getfx("jup_urz_military_airstrip_heli_medium_01_air"), self.origin);
      level notify("heli_killed");
    }

    if(isDefined(self.marker)) {
      thread function_af35587070d32e44(1);
    }

    waitframe();

    if(isDefined(self)) {
      vehicle::vehicle_kill(level.player);
      self endon("runwayDelete");
    }

    if(vehicle::ishelicopter()) {
      if(isDefined(self)) {
        self delete();
      }

      return;
    }

    if(isDefined(fake_husk)) {
      fake_husk notsolid();

      if(isDefined(self)) {
        self delete();
      }

      fake_husk show();

      if(fake_husk getscriptableparthasstate("husk_constant_fire", "on")) {
        state = fake_husk getscriptablepartstate("husk_constant_fire", 1);

        if(!utility::is_equal(state, "on")) {
          fake_husk setscriptablepartstate("husk_constant_fire", "on", 1);
        }
      }

      if(fake_husk getscriptableparthasstate("damageHeavy", "on")) {
        state = fake_husk getscriptablepartstate("damageHeavy", 1);

        if(!utility::is_equal(state, "on")) {
          fake_husk setscriptablepartstate("damageHeavy", "on", 1);
        }
      }

      if(fake_husk getscriptableparthasstate("damageEngine", "explode")) {
        state = fake_husk getscriptablepartstate("damageEngine", 1);

        if(!utility::is_equal(state, "explode")) {
          fake_husk setscriptablepartstate("damageEngine", "explode", 1);
        }
      }

      if(fake_husk getscriptableparthasstate("tag_reactive_armor_body_left1", "death")) {
        state = fake_husk getscriptablepartstate("tag_reactive_armor_body_left1", 1);

        if(!utility::is_equal(state, "death")) {
          fake_husk setscriptablepartstate("tag_reactive_armor_body_left1", "death", 1);
        }
      }

      if(fake_husk getscriptableparthasstate("tag_reactive_armor_body_right2", "death")) {
        state = fake_husk getscriptablepartstate("tag_reactive_armor_body_right2", 1);

        if(!utility::is_equal(state, "death")) {
          fake_husk setscriptablepartstate("tag_reactive_armor_body_right2", "death", 1);
        }
      }

      fake_husk endon("runwayDelete");
      level.var_3d46d336a141ee7 = array_removeundefined(level.var_3d46d336a141ee7);
      level.var_3d46d336a141ee7[level.var_3d46d336a141ee7.size] = fake_husk;
    }
  }
}

function function_2a445bdbafbe25b0() {
  level thread dialogue("dx_sp_jsgs_hbss_ssig_enemyheloscomingdown", 0.5);
  thread function_bed71d4f6a0ef231();
  self playSound("scn_gunship_heliboss_hit");
  self playLoopSound("scn_gunship_heliboss_spin");
  self notify("crashing");
  self.vehiclecrashing = 1;
  self notify("nav_new_path");
  waitframe();
  self setneargoalnotifydist(10);
  self vehicle_setspeed(120);
  var_bad99e2603f2c99c = level.var_51bc360da2215ba8[0];
  self setvehgoalpos((var_bad99e2603f2c99c.origin[0], var_bad99e2603f2c99c.origin[1], 700), 0);
  self waittill("goal");
  self notify("flavor_done");
  thread function_9dbbb3815e4e993();
}

function function_bed71d4f6a0ef231() {
  self endon("vehicle_crashDone");
  self clearlookatent();
  self setmaxpitchroll(60, 90);
  self setyawspeed(700, 200, 200);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    irand = randomintrange(140, 170);
    self settargetyaw(self.angles[1] + irand);
    wait 0.5;
  }
}

function function_9dbbb3815e4e993() {
  self notify("vehicle_crashDone");
  self notify("in_air_explosion");

  if(isDefined(self.marker)) {
    thread function_af35587070d32e44(0.2);
  }

  if(isDefined(self.markers)) {
    foreach(marker in self.markers) {
      if(isDefined(marker) && !isint(marker)) {
        marker destroy();
      }
    }
  }

  origin = level.var_51bc360da2215ba8[0].origin;
  playFX(utility::getfx("heli_boss_death"), self.origin);
  self stoploopsound();
  thread play_sound_in_space("scn_gunship_heliboss_expl", origin);
  self delete();

  foreach(asset in level.var_51bc360da2215ba8) {
    asset show();
  }
}

function private function_3efe19a5f3668974() {
  if(istrue(self.bossheli)) {
    return;
  }

  thread function_74b00c65a787223d();
  self endon("death");
  self endon("vehicle_crashDone");

  if(self.istank) {
    wait 0.5;
  } else {
    wait 4;
  }

  riders = self.riders;

  if(istrue(self.istank)) {
    utility::wait_for_flag_or_timeout(self.targetname + "_intro_shots", 20);

    if(self.targetname == "tower_tank") {
      wait 8;
    } else {
      wait 5;
    }
  }

  self.marker = thread function_91fff8ef1083babf((0, 0, -50), 1, 1, istrue(self.istank), "icon_waypoint_overlay_marker_special", !istrue(self.istank));

  if(riders.size < 1) {
    return;
  }

  utility::waittill_any_2("unloading", "newpath");

  if(isDefined(self.marker)) {
    thread function_af35587070d32e44(1);
  }

  if(!istrue(level.var_9e1ae3102c095174)) {
    return;
  }

  riders = utility::array_removedead_or_dying(riders);

  foreach(rider in riders) {
    if(rider.health > 150) {
      rider.health = 150;
    }

    rider thread function_91fff8ef1083babf((0, 0, 0), 1, 1, 0, "icon_waypoint_overlay_marker_enemy_small", 0);
  }
}

function private function_74b00c65a787223d() {
  utility::waittill_any_2("death", "driver dead");

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.marker)) {
    if(isDefined(self.marker.markerent)) {
      self.marker.markerent thread function_2286d02ec60e2602(self);
    }

    thread function_af35587070d32e44(0.5);
  }
}

function function_2286d02ec60e2602(veh) {
  self endon("death");
  veh waittill("vehicle_huskCreation", husk);

  if(isDefined(husk)) {
    self linkTo(husk);
  }
}

function private function_5adb5b792f577e57() {
  vehicle_types = ["script_vehicle", "script_vehicle_jup_mil_lnd_cargo_truck_cover_physics_gunship", "script_vehicle_jup_pickup_fullsize_2014_physics_gunship", "script_vehicle_jup_jltv_physics_gunship", "script_vehicle_iw9_mil_lnd_tank_cougar_physics"];

  foreach(type in vehicle_types) {
    level.vehicle.templates.surface_effects[type]["dirt"] = level._effect["vfx_gunship_treadfx_truck"];
    level.vehicle.templates.surface_effects[type]["rock"] = level._effect["vfx_gunship_treadfx_truck"];
    level.vehicle.templates.surface_effects[type]["sand"] = level._effect["vfx_gunship_treadfx_truck"];
    level.vehicle.templates.surface_effects[type]["default"] = level._effect["vfx_gunship_treadfx_truck_half"];
  }
}

function function_9bfb47aea09eb2bb(teleport_vehicle) {
  self endon("death");
  function_b61f675503083701();
  function_32b8c2252d5ec952(teleport_vehicle);
}

function private function_3b0f548face4361e(var_cd0bc29e189d66d9) {
  all_tags = utility::get_tag_list(self.model);

  foreach(tag in all_tags) {
    if(utility::array_contains(var_cd0bc29e189d66d9, tag)) {
      continue;
    }

    self hidepart(tag);
  }
}

function private function_b61f675503083701() {
  if(!self hascomponent("p2p")) {
    self addcomponent("p2p");
  }

  if(!self hascomponent("path")) {
    self addcomponent("path");
  }

  if(!self hascomponent("animator")) {
    self addcomponent("animator");
  }

  self setconfigvalue("p2p", "brakeAtGoal", 1);
  self setconfigvalue("p2p", "automaticFast", 1);
  self setconfigvalue("p2p", "brakeOnGoalGasbrake", 1);
  self setconfigvalue("p2p", "goalThreshold", 200);
  self setconfigvalue("p2p", "throttleSpeedThreshold", 0.1);
  self setconfigvalue("p2p", "automaticFastTopspeedFraction", 1);
  self setconfigvalue("p2p", "throttleSpeedFarBelow", 7);
  self setconfigvalue("p2p", "throttleSpeedFarAbove", 7);
  self setconfigvalue("p2p", "throttleSpeedClose", 1);
  self setconfigvalue("p2p", "gasToStopMovement", 1);
  self setconfigvalue("p2p", "steeringMultiplier", 100);
}

function private function_32b8c2252d5ec952(teleport_vehicle) {
  goalnode = getvehiclenode(self.target, "targetname");

  if(istrue(teleport_vehicle)) {
    waitframe();
    self vehicle_teleport(goalnode.origin, goalnode.angles);
  }

  get_func = vehicle_paths::get_path_getfunc(goalnode);
  lastpoint = undefined;

  for(nodenum = 0; isDefined(self); nodenum++) {
    self.currentnode = goalnode;

    if(isDefined(goalnode.script_flag_wait)) {
      utility::flag_wait(goalnode.script_flag_wait);
    }

    if(isDefined(goalnode.speed)) {
      function_843572119225957e("p2p", goalnode.speed);
    }

    self setconfigvalue("p2p", "goalPoint", goalnode.origin);
    self setconfigvalue("p2p", "goalAngles", goalnode.angles);
    self waittill("near_goal");

    if(nodenum > 20) {
      if(!function_c4951a4784954657(self, 0.984808)) {
        break;
      }
    }

    vehicle_paths::trigger_process_node(goalnode);

    if(vehicle_paths::vehicle_should_unload(&vehicle_paths::node_wait, goalnode)) {
      thread vehicle_paths::unload_node(goalnode);
    }

    if(isDefined(goalnode.script_delete) && goalnode.script_delete == 1) {
      while(function_c4951a4784954657(self, 0.984808)) {
        wait 0.1;
      }

      self delete();
      break;
    }

    if(!isDefined(goalnode.target)) {
      break;
    }

    goalnode = getvehiclenode(goalnode.target, "targetname");
  }
}

function private function_1399c3c8b823ef08(var_993917db9815ee43, mph) {
  mph = utility::default_to(mph, 30);

  if(mph < 0) {
    mph = 0;
  }

  var_76401ace2b3f590a = utility::mph_to_ips(mph);
  function_843572119225957e(var_993917db9815ee43, var_76401ace2b3f590a);
}

function private function_843572119225957e(var_993917db9815ee43, var_76401ace2b3f590a) {
  self setconfigvalue(var_993917db9815ee43, "manualSpeed", var_76401ace2b3f590a);
  self.basespeed = var_76401ace2b3f590a;
}

function function_16c7809d73f2a8c6(doors, jet, var_dcd7ef48218c479e) {
  thread opendoors(doors, var_dcd7ef48218c479e);
  jet.soundent = jet spawn_tag_origin();
  jet.soundent linkTo(jet);
  jet.soundent playSound("scn_jup_gunship_radio_jet_takeoff_sequence");

  if(isDefined(jet)) {
    jet endon("death");

    if(isDefined(level.marker_locations["location_airstrip"]) && isDefined(level.marker_locations["location_airstrip"].marker_ent)) {
      level.marker_locations["location_airstrip"].marker_ent.origin = jet.origin;
      level.marker_locations["location_airstrip"].marker_ent linkTo(jet);
    }

    doors[0] waittill("movedone");
    wait 0.3;
    jet function_66051f7c776fbda5();
  }
}

function opendoors(doors, var_dcd7ef48218c479e, flagstring) {
  doors[0] moveTo(doors[0].var_ea0acb97ce270747, utility::default_to(var_dcd7ef48218c479e, 6), 0.5, 0.5);
  doors[1] moveTo(doors[1].var_ea0acb97ce270747, utility::default_to(var_dcd7ef48218c479e, 6), 0.5, 0.5);
  doors[0] waittill("movedone");
  doors[0].clip connectpaths();
  doors[1].clip connectpaths();

  if(isDefined(flagstring)) {
    utility::flag_set(flagstring);
  }
}

function function_df5cd54ba46346ff(var_f099e85f86e0f894) {
  setDvar(@ "hash_2e188ff1bdf11145", 0);

  setdvarifuninitialized(@ "hash_4f9bb1735456045d", 0);

  if(istrue(var_f099e85f86e0f894)) {
    var_12d881c056599b01 = utility::getStruct("runway_01", "targetname");
    level.jet_01 = var_12d881c056599b01 function_389b42e955128855("jet_1_dead");
    return;
  }

  var_12d881c056599b01 = utility::getStruct("runway_02", "targetname");
  level.jet_02 = var_12d881c056599b01 function_389b42e955128855("jet_2_dead");
}

function private function_6b3535ac942de8b7() {
  var_9792640b164cdeb1 = [];
  var_9792640b164cdeb1[var_9792640b164cdeb1.size] = utility::getStruct("jetbunker_01_door_right", "script_noteworthy");
  var_9792640b164cdeb1[var_9792640b164cdeb1.size] = utility::getStruct("jetbunker_01_door_left", "script_noteworthy");
  var_9792640b164cdeb1[var_9792640b164cdeb1.size] = utility::getStruct("jetbunker_02_door_right", "script_noteworthy");
  var_9792640b164cdeb1[var_9792640b164cdeb1.size] = utility::getStruct("jetbunker_02_door_left", "script_noteworthy");
  var_9792640b164cdeb1[var_9792640b164cdeb1.size] = utility::getStruct("vehicle_a_door_01_right", "script_noteworthy");
  var_9792640b164cdeb1[var_9792640b164cdeb1.size] = utility::getStruct("vehicle_a_door_01_left", "script_noteworthy");
  var_9792640b164cdeb1[var_9792640b164cdeb1.size] = utility::getStruct("vehicle_a_door_02_right", "script_noteworthy");
  var_9792640b164cdeb1[var_9792640b164cdeb1.size] = utility::getStruct("vehicle_a_door_02_left", "script_noteworthy");
  var_9792640b164cdeb1[var_9792640b164cdeb1.size] = utility::getStruct("vehicle_b_door_01_right", "script_noteworthy");
  var_9792640b164cdeb1[var_9792640b164cdeb1.size] = utility::getStruct("vehicle_b_door_01_left", "script_noteworthy");
  var_9792640b164cdeb1[var_9792640b164cdeb1.size] = utility::getStruct("vehicle_b_door_02_right", "script_noteworthy");
  var_9792640b164cdeb1[var_9792640b164cdeb1.size] = utility::getStruct("vehicle_b_door_02_left", "script_noteworthy");
  var_9792640b164cdeb1[var_9792640b164cdeb1.size] = utility::getStruct("vehicle_b_door_03_right", "script_noteworthy");
  var_9792640b164cdeb1[var_9792640b164cdeb1.size] = utility::getStruct("vehicle_b_door_03_left", "script_noteworthy");
  var_9792640b164cdeb1[var_9792640b164cdeb1.size] = utility::getStruct("tank_b_door_01_right", "script_noteworthy");
  var_9792640b164cdeb1[var_9792640b164cdeb1.size] = utility::getStruct("tank_b_door_01_left", "script_noteworthy");

  foreach(doorstruct in var_9792640b164cdeb1) {
    door = getEnt(doorstruct.target, "targetname");
    level.bunker_doors[i] = door;
    doorstruct.door = door;
    door.var_ea0acb97ce270747 = door.origin;
    var_1ab5f4114717c053 = getEntArray(door.target, "targetname");

    foreach(doorent in var_1ab5f4114717c053) {
      if(utility::is_equal(doorent.script_parameters, "closedPos")) {
        door.var_f0d03165c1438c13 = doorent.origin;
        doorent delete();
        continue;
      }

      if(utility::is_equal(doorent.script_parameters, "doorClip")) {
        door.clip = doorent;
        door.clip linkTo(door);
        door.clip connectpaths();
      }
    }

    if(isDefined(door.var_f0d03165c1438c13)) {
      door.origin = door.var_f0d03165c1438c13;

      if(isDefined(door.clip)) {
        door.clip delaycall(0.05, &disconnectpaths);
      }
    }
  }
}

function private function_389b42e955128855(deathflag) {
  jet = utility::spawn_tag_origin();
  jet setModel("jup_urz_military_airstrip_suniform25_jet_01_air");
  jet show();
  jet dontinterpolate();
  jet.health = 999999;
  jet setCanDamage(1);
  jet setCanRadiusDamage(1);
  jet.var_e632849f70a9992a = 0;
  jet childthread function_78c97b8676438fc9(deathflag);
  jet.var_12d881c056599b01 = self;
  jet scriptmoverthermal();
  level.jet = jet;
  return jet;
}

function function_66051f7c776fbda5() {
  self endon("entitydeleted");
  currentstruct = self.var_12d881c056599b01;
  self.var_554943009ff80d26 = 1;
  self.targetmarker = thread function_91fff8ef1083babf((0, 0, 0), 0, 1, 1, "icon_waypoint_overlay_marker_special");

  if(isDefined(self.targetmarker)) {
    thread function_ce89aa942643344f(self.targetmarker, 0, 1, 4 + level.gameskill, 4, 0);
  }

  utility::flag_set("disable_autosaves");
  utility::flag_clear("jet_shot");
  utility::flag_clear("jet_fail");

  for(i = 0; isDefined(currentstruct.target); i++) {
    speed = utility::default_to(currentstruct.script_speed, utility::default_to(currentstruct.speed, 80));
    newstruct = utility::getStruct(currentstruct.target, "targetname");
    dist = distance2d(self.origin, newstruct.origin);
    traveltime = utility::default_to(currentstruct.script_timer, utility::mph_travel_time(speed, dist));
    traveltime = clamp(traveltime, 0, 20);

    if(i == 0) {
      accel = utility::default_to(currentstruct.script_accel, traveltime / 1.1);
      decel = utility::default_to(currentstruct.script_decel, 0);
    } else {
      accel = utility::default_to(currentstruct.script_accel, 0);
      decel = utility::default_to(currentstruct.script_decel, 0);
    }

    if(i == 1) {
      self.var_e632849f70a9992a = 1;
      playFXOnTag(utility::getfx("vfx_jet_thruster"), self, "tag_origin");
      thread function_e307e805612459a1();
    }

    if(accel > 0 || decel > 0) {
      self moveTo(newstruct.origin, traveltime, accel, decel);
    } else {
      self moveTo(newstruct.origin, traveltime);
    }

    if(isDefined(currentstruct.script_faceangles)) {
      self rotateTo(newstruct.angles, traveltime);
    }

    if(utility::is_equal(currentstruct.script_noteworthy, "shoot")) {
      thread function_75789ba1d33735ec();
    }

    if(isDefined(newstruct.script_delay)) {
      traveltime += newstruct.script_delay;
    }

    if(getdvarint(@ "hash_4f9bb1735456045d", 0) == 1) {
      thread utility::draw_line_for_time(newstruct.origin, newstruct.origin + (0, 0, 1000), 0, 0, 1, traveltime);
      thread utility::draw_line_for_time(currentstruct.origin, newstruct.origin, 1, 0, 0, traveltime);

      if(traveltime < accel + decel) {
        iprintln("<dev string:x35f>");
        iprintln("<dev string:x382>" + traveltime);
      }
    }

    if(traveltime > 0.4) {
      wait traveltime - 0.4;
    } else {
      wait traveltime - 0.1;
    }

    currentstruct = newstruct;
  }
}

function private function_e307e805612459a1() {
  self endon("entitydeleted");
  level endon("missionfailed");

  while(isDefined(self)) {
    level waittill("hellfire_missile_launched", missile, target);
    function_7798017cc6174082(missile, target);
    waitframe();
  }
}

function private function_7798017cc6174082(missile, target) {
  missile endon("death");
  target endon("death");

  for(;;) {
    newtarget = target;

    if(function_62b8bb40735c58a2(0.996195, self.origin, [self])) {
      newtarget = self;

      if(getdvarint(@ "hash_4f9bb1735456045d", 0) == 1) {
        thread utility::draw_line_from_ent_to_ent_for_time(missile, newtarget, 0, 1, 0, 0.05);
      }
    } else {
      if(getdvarint(@ "hash_4f9bb1735456045d", 0) == 1) {
        thread utility::draw_line_from_ent_to_ent_for_time(missile, newtarget, 1, 0, 0, 0.05);
      }
    }

    if(isvalidmissile(missile)) {
      missile missile_settargetEnt(newtarget);
    }

    waitframe();
  }
}

function function_9575be8001e71d95(missile, target) {
  waittill_any_ents_array([missile, target], "death");

  if(isDefined(self) && !isstring(self) && !isint(self)) {
    self destroy();
  }
}

function private function_75789ba1d33735ec() {
  self endon("entitydeleted");

  if(self tagexists("tag_engine_left")) {
    origin = self gettagorigin("tag_engine_left") + anglesToForward(self gettagangles("tag_engine_left")) * 50;
  } else {
    origin = self.origin + anglestoleft(self.angles) * 100 + anglesToForward(self.angles) * 450;
  }

  utility::flag_set("jet_shot");
  missile = magicbullet("gunship_hellfire_jup_sp", origin, level.player.origin);
  missile missile_settargetEnt(level.gunship.model_ent.weapon_small);
  level.var_e2dedfef1129cd21 = 80000;
  level.stinger_missiles[level.stinger_missiles.size] = missile;
  thread function_8d1c8d5005f61c7c(missile);
  thread function_a1835188e95c21fb(missile, level.gunship.model_ent.weapon_small);
  wait 0.5;

  if(self tagexists("tag_engine_right")) {
    origin = self gettagorigin("tag_engine_right") + anglesToForward(self gettagangles("tag_engine_right")) * 50;
  } else {
    origin = self.origin + anglestoright(self.angles) * 100 + anglesToForward(self.angles) * 450;
  }

  missile = magicbullet("gunship_hellfire_jup_sp", origin, level.player.origin);
  missile missile_settargetEnt(level.gunship.model_ent.weapon_small);
  thread function_8d1c8d5005f61c7c(missile);
  thread function_a1835188e95c21fb(missile, level.gunship.model_ent.weapon_small);
}

function private function_8d1c8d5005f61c7c(missile) {
  missile endon("death");
  level endon("missionfailed");
  self waittill("death");
  utility::flag_clear("disable_autosaves");
  missile missile_cleartarget();
  level.var_e2dedfef1129cd21 = undefined;
}

function private function_a1835188e95c21fb(missile, target) {
  self endon("entitydeleted");
  level endon("missionfailed");

  while(isDefined(missile)) {
    dist = distance(missile.origin, target.origin);

    if(dist <= 1000) {
      break;
    }

    waitframe();
  }

  utility::flag_set("jet_fail");

  if(!utility::flag("alreadyFailing")) {
    utility::flag_set("alreadyFailing");
    index = 248;

    if(istrue(getdvarint(@ "hash_2e188ff1bdf11145", 0))) {
      index = 249;
    }

    setDvar(@ "hash_2e188ff1bdf11145", 1);
    player_death::clear_custom_death_quote();
    level.gunship.model_ent thread namespace_fd9c6daa1372e62b::gunship_playfakebodyexplosion();

    if(soundexists("scn_gshp_missile_death_exp_lr")) {
      level.player utility::delaycall(0.3, &playsound, "scn_gshp_missile_death_exp_lr");
    } else if(soundexists("exp_gunship_hellfire_dist")) {
      level.player playSound("exp_gunship_hellfire_dist");
    }

    if(isDefined(missile)) {
      playFX(utility::getfx("jup_urz_military_airstrip_suniform25_jet_01_air_moving_death"), missile.origin);

      if(isvalidmissile(missile)) {
        missile detonate();
      }
    } else {
      playFX(utility::getfx("jup_urz_military_airstrip_suniform25_jet_01_air_moving_death"), level.gunship.model_ent.origin);
    }

    wait 0.4;
    level.gunship.model_ent thread namespace_fd9c6daa1372e62b::gunship_crash(15, level.player);
    wait 1.5;
    player_death::set_custom_death_quote(index);
    thread utility::missionfailedwrapper();
  }
}

function private function_78c97b8676438fc9(deathflag) {
  if(isDefined(deathflag)) {
    thread utility::flag_on_death(deathflag);
  }

  self.var_17d2a2a24229dc42 = 0;
  self.var_75f6977603250653 = 0;
  self.hits_missile = 0;
  self.var_60896e97a711519b["ground"] = 2;
  self.var_30cbca2521d5ec76["ground"] = 5;
  self.var_333b6898f00b6a3b["ground"] = 1;
  self.var_60896e97a711519b["ground_vet"] = 3;
  self.var_30cbca2521d5ec76["ground_vet"] = 10;
  self.var_333b6898f00b6a3b["ground_vet"] = 1;
  self.var_60896e97a711519b["ground_takeoff"] = 0.5;
  self.var_30cbca2521d5ec76["ground_takeoff"] = 1;
  self.var_333b6898f00b6a3b["ground_takeoff"] = 0.5;
  self.var_60896e97a711519b["ground_vet_takeoff"] = 0.5;
  self.var_30cbca2521d5ec76["ground_vet_takeoff"] = 2;
  self.var_333b6898f00b6a3b["ground_vet_takeoff"] = 0.5;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin);

    if(!isPlayer(attacker) || !isDefined(objweapon) || !isDefined(objweapon.basename)) {} else {
      function_2f1d92650ff34b41(objweapon, damagelocation);

      if(function_f28f5705633d93f8(objweapon)) {
        break;
      }
    }

    waitframe();
  }

  utility::flag_clear("disable_autosaves");
  level.var_e2dedfef1129cd21 = undefined;
  allies = getaiarray("allies");
  allies = sortbydistance(allies, self.origin);

  if(isDefined(self.soundent)) {
    self.soundent thread sound_fade_and_delete(0.1);
  }

  if(allies.size > 0) {
    dist = distance(self.origin, allies[0].origin);

    if(dist <= 10000) {
      playsoundatpos(self.origin, "scn_jup_gunship_radio_jet_destroyed");
    }
  }

  playFX(utility::getfx("jup_urz_military_airstrip_suniform25_jet_01_air_moving_death"), self.origin);

  if(isDefined(self)) {
    if(isDefined(self.targetmarker) && !isint(self.targetmarker)) {
      self.targetmarker destroy();
    }

    if(isDefined(self.markers)) {
      foreach(marker in self.markers) {
        if(isDefined(marker) && !isint(marker)) {
          marker destroy();
        }
      }
    }

    self delete();
  }
}

function function_f28f5705633d93f8(objweapon) {
  indexstring = function_a4b1e0968259e78a();

  if(self.var_17d2a2a24229dc42 >= self.var_60896e97a711519b[indexstring]) {
    return true;
  }

  if(self.var_75f6977603250653 >= self.var_30cbca2521d5ec76[indexstring]) {
    return true;
  }

  if(self.hits_missile >= self.var_333b6898f00b6a3b[indexstring]) {
    return true;
  }

  return false;
}

function function_a4b1e0968259e78a() {
  var_3e5265936058aaec = level.gameskill > 1;
  var_e632849f70a9992a = self.var_e632849f70a9992a;

  if(!var_e632849f70a9992a && !var_3e5265936058aaec) {
    return "ground";
  }

  if(!var_e632849f70a9992a && var_3e5265936058aaec) {
    return "ground_vet";
  }

  if(var_e632849f70a9992a && !var_3e5265936058aaec) {
    return "ground_takeoff";
  }

  if(var_e632849f70a9992a && var_3e5265936058aaec) {
    return "ground_vet_takeoff";
  }
}

function function_62b8bb40735c58a2(cosnum, target_origin, ignore) {
  playerpos = level.player getvieworigin();
  playerangles = level.player getplayerangles();

  if(!isDefined(ignore) && isDefined(level.gunship_ents)) {
    ignore = getentarrayinradius(undefined, undefined, level.player.origin, 1000);
  }

  within_fov = utility::within_fov(playerpos, playerangles, target_origin, cosnum);

  if(istrue(level.var_6906aa4d708551de)) {
    if(within_fov) {
      if(getdvarint(@ "hash_ecfaff72ee0ed2b2", 0) == 1) {
        thread draw_line_for_time(playerpos, target_origin, 0, 1, 0, 0.5);
      }

      return true;
    }
  } else {
    ray_trace_passed = trace::ray_trace_passed(playerpos, target_origin, ignore, level.contents_override);

    if(within_fov && ray_trace_passed) {
      if(getdvarint(@ "hash_ecfaff72ee0ed2b2", 0) == 1) {
        thread draw_line_for_time(playerpos, target_origin, 0, 1, 0, 0.5);
      }

      return true;
    }
  }

  if(getdvarint(@ "hash_ecfaff72ee0ed2b2", 0) == 1) {
    thread draw_line_for_time(playerpos, target_origin, 1, 0, 0, 0.5);
  }

  return false;
}

function function_c4951a4784954657(targets, cosnum, var_5a93fbe7df03a223) {
  cosnum = utility::default_to(cosnum, 0.996195);
  var_5a93fbe7df03a223 = utility::default_to(var_5a93fbe7df03a223, 30);

  if(!isarray(targets)) {
    targets = [targets];
  }

  array = [];

  foreach(target in targets) {
    if(isDefined(target)) {
      array[array.size] = target;
    }
  }

  targets = array;
  ignore = [];

  foreach(target in targets) {
    if(isent(target)) {
      ignore[ignore.size] = target;
    }
  }

  foreach(target in targets) {
    if(function_62b8bb40735c58a2(cosnum, target.origin + (0, 0, var_5a93fbe7df03a223), ignore)) {
      return true;
    }
  }

  return false;
}

function function_65d3632dd282d98a(targets, cosnum, var_5a93fbe7df03a223, invert, ender) {
  if(isDefined(ender)) {
    level endon(ender);
  }

  invert = utility::default_to(invert, 0);

  while(function_c4951a4784954657(targets, cosnum, var_5a93fbe7df03a223) == invert) {
    waitframe();
  }
}

function function_b8739f7855404a3b(targets, cosnum, var_5a93fbe7df03a223, dont_hint, var_63383c2f3e78f05c) {
  i = 0;

  while(true) {
    function_65d3632dd282d98a(targets, cosnum, var_5a93fbe7df03a223);

    if(!istrue(dont_hint) && istrue(var_63383c2f3e78f05c) && !flag("thermal_mode")) {
      utility::display_hint("vision_thermal", undefined, 0.05, level, "thermal_mode");
      level notify("start_thermal_hint");

      while(!flag("thermal_mode")) {
        waitframe();
      }
    }

    if(istrue(var_63383c2f3e78f05c)) {
      if(level.player utility::isads() && flag("thermal_mode")) {
        break;
      }
    } else if(level.player utility::isads()) {
      break;
    }

    if(i == 0 && !istrue(dont_hint)) {
      if(!istrue(dont_hint)) {
        if(level.player usinggamepad()) {
          if(level.player getlocalplayerprofiledata("toggleADSEnabledGamepad") == 1) {
            utility::display_hint("weapon_ads", undefined, 0.05, level, "stop_ads_hint");
          } else {
            utility::display_hint("weapon_ads_hold", undefined, 0.05, level, "stop_ads_hint");
          }
        } else if(level.player getlocalplayerprofiledata("toggleADSEnabledKeyboard") == 1) {
          utility::display_hint("weapon_ads", undefined, 0.05, level, "stop_ads_hint");
        } else {
          utility::display_hint("weapon_ads_hold", undefined, 0.05, level, "stop_ads_hint");
        }
      }

      i++;
    }

    level notify("start_ads_hint");

    while(!level.player utility::isads() && function_c4951a4784954657(targets, cosnum, var_5a93fbe7df03a223)) {
      if(istrue(var_63383c2f3e78f05c) && !flag("thermal_mode")) {
        break;
      }

      waitframe();
    }

    level notify("stop_ads_hint");
    waitframe();
  }

  level notify("stop_ads_hint");
}

function setup_gunship(var_8945c22a67231e20, height, radius, speed, var_f1acd9be11d8efe5, var_259a7e2e6fa2cbe6) {
  level.var_c944986665da028e = !getdvarint(@ "hash_f8011de88f9b444b", 0);
  level.var_f1acd9be11d8efe5 = utility::default_to(var_f1acd9be11d8efe5, 1);
  level.var_259a7e2e6fa2cbe6 = utility::default_to(var_259a7e2e6fa2cbe6, 1);
  level.var_18a73555b2329261 = [50, 100, 20, 50];
  level.var_8349b3cc90ef4fa5 = var_8945c22a67231e20;
  level.var_ad9a00890a627c58 = height;
  level.var_c9432be18d145ed5 = radius;
  level.gunship_speed["rotate"] = speed;
  level.var_abebd3ab98699051 = level.gunship_speed["rotate"];
  level.var_ac0ee5ab988fff9f = level.gunship_speed["rotate"];
  level.var_1ced22cd06ca90ed = level.gunship_speed["rotate"];
  level.var_5a3f504f0ddbd74f = 1;

  if(!isDefined(level.var_dc44706239201a43)) {
    focus_struct = utility::getStruct("gunship_focus_3", "targetname");
    level.var_dc44706239201a43 = focus_struct.origin;
  }

  setdvarifuninitialized(@ "hash_d8d71cbe1098260e", 1);
}

function spawn_gunship(string) {
  waitframe();

  if(!isDefined(level.var_18a73555b2329261)) {
    level.var_18a73555b2329261 = [85, 85, 40, 85];
  }

  if(!isDefined(level.var_8349b3cc90ef4fa5)) {
    level.var_8349b3cc90ef4fa5 = 10;
  }

  if(!isDefined(level.var_259a7e2e6fa2cbe6)) {
    level.var_259a7e2e6fa2cbe6 = 1;
  }

  if(!isDefined(level.var_67f5d508f1c46e99)) {
    level.var_67f5d508f1c46e99 = 1;
  }

  if(!isDefined(level.var_f1acd9be11d8efe5)) {
    level.var_f1acd9be11d8efe5 = 1;
  }

  if(!isDefined(level.var_c9432be18d145ed5)) {
    level.var_c9432be18d145ed5 = 6000;
  }

  if(!isDefined(level.var_ad9a00890a627c58)) {
    level.var_ad9a00890a627c58 = 9900;
  }

  if(!isDefined(level.gunship_speed["rotate"])) {
    level.gunship_speed["rotate"] = 600;
  }

  if(!isDefined(level.var_abebd3ab98699051)) {
    level.var_abebd3ab98699051 = level.gunship_speed["rotate"];
  }

  if(!isDefined(level.var_ac0ee5ab988fff9f)) {
    level.var_ac0ee5ab988fff9f = level.gunship_speed["rotate"];
  }

  if(!isDefined(string)) {
    string = "gunship_intro";
  }

  var_792dbbd6b1645d22 = utility::getStruct("gunship_airstrip", "targetname");
  var_792dbbd6b1645d22 namespace_fd9c6daa1372e62b::function_6be6c5dc66f4a52c();
}

function function_c2ace64053c30140(threats, flagstring, ender) {
  if(isDefined(ender)) {
    level endon(ender);
  }

  if(isDefined(flagstring)) {
    utility::flag_wait(flagstring);
  }

  threats = utility::default_to(threats, getaiarray("axis"));
  threats = utility::array_removedead_or_dying(threats);

  foreach(threat in threats) {
    threat thread function_91fff8ef1083babf((0, 0, 0), 1, 1, 0, "icon_waypoint_overlay_marker_enemy_small", 0);
  }
}

function function_91fff8ef1083babf(offset, var_111ea319762ba97e, var_656bf60f6fe55b5d, constantsize, shader, var_b69423020f5f460f, var_dd069de09f7f0c85, var_1c472581bff40df0) {
  assert(isent(self));

  if(isDefined(self.marker) && !istrue(var_1c472581bff40df0)) {
    return self.marker;
  }

  if(!istrue(var_dd069de09f7f0c85) && isai(self)) {
    self endon("death");

    for(;;) {
      playerpos = level.player getvieworigin();

      if(trace::ray_trace_passed(playerpos, self.origin + (0, 0, 50), [self], level.var_7d8d2c98080e2463)) {
        break;
      }

      wait 0.5;
    }
  }

  if(getdvarint(@ "hash_57db27d991ee39f7") == 1) {
    var_6ebdd49f99804b3e = 0;
    marker = level.enemytargetmarkergroup;

    if(isDefined(self.team) && self.team == "allies") {
      marker = level.var_9ed7da1529f3e23f;
    }

    if(istrue(self.var_554943009ff80d26)) {
      marker = level.var_e9a68b2ce6f0ac94;
      var_6ebdd49f99804b3e = function_474a3363f5485846(marker, offset, var_111ea319762ba97e, var_656bf60f6fe55b5d);
      targetmarkergroupsetextrastate(marker, self, 1);
      function_89b112677566b3de(marker, 1);
    } else if(!isai(self)) {
      marker = level.var_d491f25f77c56185;

      if(istrue(self.istank) && isDefined(self.mainturret)) {
        marker = level.var_e9a68b2ce6f0ac94;
        var_6ebdd49f99804b3e = self.mainturret function_474a3363f5485846(marker, offset, var_111ea319762ba97e, var_656bf60f6fe55b5d);
        targetmarkergroupsetextrastate(marker, self.mainturret, 1);
        function_89b112677566b3de(marker, 1);
      } else {
        var_6ebdd49f99804b3e = function_474a3363f5485846(marker, offset, var_111ea319762ba97e, var_656bf60f6fe55b5d);
        targetmarkergroupsetextrastate(marker, self, 1);
      }
    } else {
      if(level.markergroups.group_size[marker] >= 20) {
        marker = level.var_5b1cef5abf070295;
      }

      var_6ebdd49f99804b3e = function_474a3363f5485846(marker, offset, var_111ea319762ba97e, var_656bf60f6fe55b5d);
    }

    if(!var_6ebdd49f99804b3e) {
      return;
    }

    if(istrue(var_656bf60f6fe55b5d)) {
      thread function_c0517fd2b952aa9b(marker, 0);
    }

    thread function_19c0a71dd84d90a2(marker);
  } else {
    markedent = self;
    var_c94fd825b104c702 = 0;

    if(vehicle::isvehicle()) {
      markedent = spawn_tag_origin();
      markedent linkTo(self);
      var_c94fd825b104c702 = 1;
    }

    shader = utility::default_to(shader, "icon_waypoint_overlay_marker_enemy_small");
    marker = newhudelem();
    marker setshader(shader, 128, 128);
    marker setwaypoint(utility::default_to(constantsize, 0), utility::default_to(var_b69423020f5f460f, 1), 1, 0);
    marker linkwaypointtotargetwithoffset(markedent, utility::default_to(offset, (0, 0, 0)));
    marker.maxalpha = ter_op(default_to(self.team, "axis") == "allies", 0.8, 0.8);
    marker.alpha = marker.maxalpha;
    marker.hidewheninmenu = 1;
    marker.hidewhendead = 1;

    if(istrue(var_1c472581bff40df0)) {
      if(!isDefined(markedent.markers)) {
        markedent.markers = [];
      }

      markedent.markers[markedent.markers.size] = marker;
    } else {
      markedent.marker = marker;
    }

    if(var_c94fd825b104c702) {
      marker.markerent = markedent;
    }

    if(istrue(var_111ea319762ba97e)) {
      thread function_ce89aa942643344f(marker);
    }

    if(istrue(var_656bf60f6fe55b5d) && !var_c94fd825b104c702) {
      markedent thread function_c0517fd2b952aa9b(marker, 1);
    }

    markedent thread function_19c0a71dd84d90a2(marker, 1);
  }

  return marker;
}

function function_474a3363f5485846(marker_id, offset, var_111ea319762ba97e, var_656bf60f6fe55b5d) {
  if(level.markergroups.group_size[marker_id] >= 20) {
    function_74cf5349fdc3d7b4(marker_id);
    thread function_afe1f46030a83331(marker_id, offset, var_111ea319762ba97e, var_656bf60f6fe55b5d);
    return 0;
  }

  level.markergroups.group_size[marker_id]++;
  targetmarkergroupaddentity(marker_id, self);
  return 1;
}

function function_ef58191d6a42152d(marker_id) {
  if(!isDefined(marker_id)) {
    return;
  }

  level.markergroups.group_size[marker_id]--;

  if(isDefined(self)) {
    targetmarkergroupremoveentity(marker_id, self);
  }
}

function function_74cf5349fdc3d7b4(marker_id) {
  level.markergroups.var_18388a46fff7463a[marker_id] = array_removeundefined(level.markergroups.var_18388a46fff7463a[marker_id]);

  if(isDefined(self)) {
    level.markergroups.var_18388a46fff7463a[marker_id] = utility::array_add(level.markergroups.var_18388a46fff7463a[marker_id], self);
  }
}

function function_afe1f46030a83331(marker_id, offset, var_111ea319762ba97e, var_656bf60f6fe55b5d) {
  while(level.markergroups.group_size[marker_id]) {
    waitframe();
  }

  function_cca904ab5f04907c(marker_id);

  if(isDefined(self)) {
    function_91fff8ef1083babf(offset, var_111ea319762ba97e, var_656bf60f6fe55b5d);
  }
}

function function_cca904ab5f04907c(marker_id) {
  level.markergroups.var_18388a46fff7463a[marker_id] = array_removeundefined(level.markergroups.var_18388a46fff7463a[marker_id]);

  if(isDefined(self)) {
    level.markergroups.var_18388a46fff7463a[marker_id] = utility::array_remove(level.markergroups.var_18388a46fff7463a[marker_id], self);
  }
}

function function_c0517fd2b952aa9b(marker, var_e2e361cbb1140c1d) {
  if(istrue(var_e2e361cbb1140c1d)) {
    marker endon("entitydeleted");
    marker endon("death");
  }

  utility::waittill_any_2("death", "entitydeleted");

  if(isDefined(marker)) {
    if(istrue(var_e2e361cbb1140c1d) && !isint(marker)) {
      marker destroy();
      return;
    }

    if(isint(marker)) {
      function_ef58191d6a42152d(marker);
    }
  }
}

function function_19c0a71dd84d90a2(marker, var_e2e361cbb1140c1d) {
  if(istrue(var_e2e361cbb1140c1d)) {
    marker endon("entitydeleted");
    marker endon("death");
  }

  self endon("death");
  level waittill("missionfailed");

  if(isDefined(marker)) {
    if(istrue(var_e2e361cbb1140c1d) && !isint(marker)) {
      marker destroy();
      return;
    }

    if(isint(marker)) {
      function_ef58191d6a42152d(marker);
    }
  }
}

function function_ce89aa942643344f(marker, var_147959548993ef3d, var_600132dc01445884, waittime, fadetime, var_9a1af21585b78246) {
  if(isint(marker)) {
    function_311f6b4dfc2e67a0(marker, waittime, var_9a1af21585b78246);
    return;
  }

  marker function_c5c6e44567956852(var_147959548993ef3d, var_600132dc01445884, waittime, fadetime, var_9a1af21585b78246);
}

function function_c5c6e44567956852(var_147959548993ef3d, var_600132dc01445884, waittime, fadetime, var_9a1af21585b78246) {
  self endon("entitydeleted");
  self endon("death");

  if(isDefined(level.player)) {
    level.player endon("death");
  }

  self.alpha = utility::default_to(var_147959548993ef3d, 0.1);
  var_600132dc01445884 = utility::default_to(var_600132dc01445884, self.maxalpha);
  fadetime = utility::default_to(fadetime, 2);
  wait utility::default_to(waittime, 2);

  if(!isDefined(level.player)) {
    return;
  }

  self fadeovertime(fadetime);
  self.alpha = var_600132dc01445884;

  if(istrue(var_9a1af21585b78246)) {
    function_97e40a8235263f3b(var_600132dc01445884);
    return;
  }

  function_88c50890f34f2ec9(var_600132dc01445884);
}

function function_311f6b4dfc2e67a0(marker, waittime, var_9a1af21585b78246) {
  hidetargetmarkergroupfromplayersinmask(marker);
  wait utility::default_to(waittime, 2);
  showtargetmarkergrouptoplayersinmask(marker);

  if(istrue(var_9a1af21585b78246)) {
    function_6567228cf4a513b1(marker);
  }
}

function function_af35587070d32e44(timer) {
  if(isDefined(self.marker)) {
    if(!isint(self.marker)) {
      self.marker thread function_fe1f4a93cc6e4b3b(timer);
      return;
    }

    thread function_ee33232bff918411(timer);
  }
}

function function_fe1f4a93cc6e4b3b(timer) {
  if(!isDefined(self)) {
    return;
  }

  wait timer;

  if(!isDefined(self)) {
    return;
  }

  self fadeovertime(timer);
  self.alpha = 0;
  wait timer;

  if(!isDefined(self)) {
    return;
  }

  self destroy();

  if(istrue(self.var_c94fd825b104c702)) {
    self delete();
  }
}

function function_ee33232bff918411(timer) {
  self endon("entitydeleted");
  wait timer;
  function_ef58191d6a42152d(self.marker);
}

function function_97e40a8235263f3b(var_600132dc01445884) {
  while(true) {
    while(!level.player utility::isads()) {
      wait 0.2;
    }

    self.alpha = 0;

    while(level.player utility::isads()) {
      wait 0.2;
    }

    self.alpha = var_600132dc01445884;
  }
}

function function_6567228cf4a513b1(marker) {
  while(true) {
    while(!level.player utility::isads()) {
      wait 0.2;
    }

    hidetargetmarkergroupfromplayersinmask(marker);

    while(level.player utility::isads()) {
      wait 0.2;
    }

    showtargetmarkergrouptoplayersinmask(marker);
  }
}

function function_88c50890f34f2ec9(var_600132dc01445884) {
  while(true) {
    while(!level.player utility::isads()) {
      wait 0.2;
    }

    self.alpha = 1;

    while(level.player utility::isads()) {
      wait 0.2;
    }

    self.alpha = var_600132dc01445884;
  }
}

function function_64c1adb77a60445c(tname, movetime, view_clamp) {
  waitframe();

  while(true) {
    if(isDefined(level.gunship) && isDefined(level.gunship.model_ent)) {
      break;
    }

    waitframe();
  }

  struct = utility::getStruct(tname, "targetname");
  new_pos = (struct.origin[0], struct.origin[1], level.gunship.origin[2]);

  if(isDefined(movetime)) {
    namespace_fd9c6daa1372e62b::moveplane(new_pos, movetime, movetime / 3, movetime / 3, 0);
  } else {
    level.gunship.origin = new_pos;
  }

  level.gunship.model_ent namespace_fd9c6daa1372e62b::function_ff5b3dbacd9c0cdd(level.player, view_clamp);
  waitframe();
}

function function_621018eac1ae9012(objname, objstate, objpos, var_b242d5e759cebea7, offset) {
  if(objectives::objective_exists(objname)) {
    objectives::objective_update(objname, objstate, objpos, var_b242d5e759cebea7, undefined, offset, 0);
  } else {
    objectives::objective_add(objname, objstate, objpos, var_b242d5e759cebea7, undefined, undefined, offset, 0, undefined, 1);
  }

  waitframe();
}

function function_9b7e8d9669747c9f(objname) {
  if(objectives::objective_exists(objname)) {
    objectives::objective_remove(objname);
    waitframe();
  }
}

function dialogue(string, delay, ender, priority, timeout, overlap, scope) {
  self endon("death");
  level endon("missionfailed");

  if(isDefined(ender)) {
    self endon(ender);
    level endon(ender);
  }

  wait utility::default_to(delay, 0);
  dialogue::say_team(string, default_to(priority, 0), default_to(timeout, [self, "death"]), overlap);
}

function marklocation(location, slot, dont_clear, clear_time) {
  level notify("ui_gunship_target_marker_ent_" + slot);
  level endon("ui_gunship_target_marker_ent_" + slot);
  dont_clear = default_to(dont_clear, 1);
  setomnvar("ui_gunship_target_marker_visible_" + slot, 1);
  setomnvar("ui_gunship_target_marker_ent_" + slot, location.marker_ent);
  setomnvar("ui_gunship_target_marker_name_" + slot, location.string);
  level.player playSound("scn_jup_gunship_poi_in");

  if(isDefined(clear_time)) {
    childthread function_59ec6dc327b669e6(clear_time, slot);
    level.player playSound("scn_jup_gunship_poi_out");
  }

  if(!dont_clear) {
    function_dd2e83051a1ccb36(location);
    function_e57fc58ce189fa88(slot);
    level.player playSound("scn_jup_gunship_poi_out");
  }
}

function function_dc116d9569c8f46b(vehicles, locationstring, ender, slot, var_910769df2052b888) {
  if(!isarray(vehicles)) {
    vehicles = [vehicles];
  }

  vehicles = array_removeundefined(vehicles);
  slot = default_to(slot, 1);

  if(isstring(var_910769df2052b888)) {
    utility::flag_wait(var_910769df2052b888);
  } else {
    wait default_to(var_910769df2052b888, 0);
  }

  foreach(vehicle in vehicles) {
    if(!isDefined(vehicle) || vehicle.damagestate != "damagePristine" || vehicle scripts\engine\utility::ent_flag("unloaded")) {
      continue;
    }

    function_b25a44a5635e5ec3(level.location_strings, vehicle);
    function_a0c8c1ef427bbe93(1 + level.gameskill, ender, level.marker_locations[locationstring], slot);
    vehicle function_3c8901fa4d56f4d8(slot);
  }

  if(isDefined(level.marker_locations[locationstring])) {
    level.marker_locations[locationstring].var_caa61c143b86da98 = 1;
  }

  function_e57fc58ce189fa88(slot);
}

function private function_3c8901fa4d56f4d8(slot) {
  utility::waittill_any_5("death", "entitydeleted", "vehicle_inBurndown", "driver dead", "unloaded");
  function_e57fc58ce189fa88(slot);
}

function function_53b36d5d0e930e1d(stinger, locationstring, ender, slot) {
  if(!isDefined(stinger)) {
    function_e57fc58ce189fa88(slot);
    return;
  }

  stinger endon("death");
  stinger endon("entitydeleted");
  assert(isDefined(stinger.shotsfired));
  slot = default_to(slot, 1);
  function_b25a44a5635e5ec3(level.location_strings, stinger);

  while(isalive(stinger)) {
    amount = utility::ter_op(level.gameskill > 1, 5, 3);

    if(stinger.shotsfired > amount) {
      break;
    }

    waitframe();
  }

  if(!isalive(stinger)) {
    return;
  }

  function_a0c8c1ef427bbe93(15 + level.gameskill, ender, level.marker_locations[locationstring], slot);
  stinger thread function_87af8b691a3a65a(slot);
}

function private function_87af8b691a3a65a(slot) {
  utility::waittill_any_2("death", "entitydeleted");
  function_e57fc58ce189fa88(slot);
}

function function_a0c8c1ef427bbe93(delay, ender, location, slot, dont_clear, clear_time) {
  level endon(ender);
  self endon(ender);
  location endon(ender);
  location endon("death");
  level endon("missionfailed");
  wait delay;
  thread marklocation(location, slot, dont_clear, clear_time);
}

function function_e57fc58ce189fa88(slot) {
  setomnvar("ui_gunship_target_marker_visible_" + slot, 0);
  setomnvar("ui_gunship_target_marker_name_" + slot, "none");
  setomnvar("ui_gunship_target_marker_ent_" + slot, undefined);
  level notify("ui_gunship_target_marker_ent_" + slot);
}

function function_59ec6dc327b669e6(time, slot) {
  level notify("marker_clear_delay_stop_" + slot);
  level endon("marker_clear_delay_stop_" + slot);
  wait time;
  function_e57fc58ce189fa88(slot);
}

function private function_45d4a9b3b8bad917() {
  setdvarifuninitialized(@ "hash_27fc8f5297aa897c", 0);

  level.current_location = undefined;
  setomnvar("ui_gunship_target_current_location_name", "none");
  setomnvar("ui_gunship_target_marker_name_1", "none");
  setomnvar("ui_gunship_target_marker_name_2", "none");
  setomnvar("ui_gunship_target_marker_name_3", "none");
  setomnvar("ui_gunship_target_marker_hide_on_focus", 0);
  level.marker_priority[1] = 3;
  level.marker_priority[2] = 2;
  level.marker_priority[3] = 1;
  location_strings["location_radioTower"] = &"SP_JUP_GUNSHIP/RADIOTOWER";
  location_strings["location_atc"] = &"SP_JUP_GUNSHIP/ATC";
  location_strings["location_airstrip"] = &"SP_JUP_GUNSHIP/AIRSTRIP";
  location_strings["location_tarmac"] = &"SP_JUP_GUNSHIP/TARMAC";
  location_strings["location_hangar_a"] = &"SP_JUP_GUNSHIP/HANGAR_A";
  location_strings["location_hangar_b"] = &"SP_JUP_GUNSHIP/HANGAR_B";
  location_strings["location_barracks"] = &"SP_JUP_GUNSHIP/BARRACKS";
  location_strings["location_tents"] = &"SP_JUP_GUNSHIP/TENTS";
  location_strings["location_parking"] = &"SP_JUP_GUNSHIP/PARKING";
  location_strings["location_fueldepot"] = &"SP_JUP_GUNSHIP/FUELDEPOT";
  location_strings["location_bunkers"] = &"SP_JUP_GUNSHIP/BUNKERS";
  location_strings["location_heli_pad"] = &"SP_JUP_GUNSHIP/HELI_PAD";
  location_strings["location_boneyard"] = &"SP_JUP_GUNSHIP/BONEYARD";
  location_strings["hero_gaz"] = &"SP_JUP_GUNSHIP/ALLIES";
  location_strings["hero_alex"] = &"SP_JUP_GUNSHIP/ALLIES";
  location_strings["hero_alex"] = &"SP_JUP_GUNSHIP/ALLIES";
  location_strings["hero_price"] = &"SP_JUP_GUNSHIP/ALLIES";
  location_strings["stingers_a"] = &"SP_JUP_GUNSHIP/MISSILE_THREAT";
  location_strings["stingers_b"] = &"SP_JUP_GUNSHIP/MISSILE_THREAT";
  location_strings["mortar_a"] = &"SP_JUP_GUNSHIP/MORTAR_THREAT";
  location_strings["vehicles_a"] = &"SP_JUP_GUNSHIP/VEHICLE_THREAT";
  location_strings["vehicles_b"] = &"SP_JUP_GUNSHIP/VEHICLE_THREAT";
  level.location_strings = location_strings;
  locations = utility::function_a5079b5837467402("location_markers", "targetname");
  level.marker_locations = [];

  foreach(location in locations) {
    function_b25a44a5635e5ec3(location_strings, location);
  }

  thread function_f98db7974d98df69();
}

function private function_b25a44a5635e5ec3(location_strings, location) {
  if(isDefined(location.script_linkto) && !isai(location)) {
    startinglocation = location;
    location = location get_linked_ent();
    location.startinglocation = startinglocation;
  }

  if(!isDefined(location_strings[location.script_noteworthy])) {
    return;
  }

  location.string = location_strings[location.script_noteworthy];
  location.marker_ent = location;

  if(location.code_classname == "info_volume") {
    location.marker_ent = location.startinglocation utility::spawn_tag_origin();
  } else if(isstruct(location)) {
    location.marker_ent = location utility::spawn_tag_origin();
  }

  level.marker_locations[location.script_noteworthy] = location;
}

function private function_f98db7974d98df69() {
  level.player endon("death");

  while(true) {
    level.current_location = undefined;
    setomnvar("ui_gunship_target_current_location_name", "none");
    sightpos = level.player function_ab0b1a180a262377();
    locations = array_removeundefined(level.marker_locations);
    locations = sortbydistance(locations, sightpos);

    foreach(location in locations) {
      if(isDefined(location) && !istrue(location.var_caa61c143b86da98)) {
        checklocation(location, sightpos);
      }
    }

    wait 0.5;
  }
}

function private checklocation(location, sightpos) {
  if(isai(location) && function_828d4b7ee9640882(location.origin)) {
    function_33eb37d8049856d4(location);
    return;
  }

  if(location.code_classname == "info_volume" && function_5e41cca93d4be774(location, sightpos)) {
    function_3e0b0e44bd4f0cc6(location);
    return;
  }

  if(function_828d4b7ee9640882(location.origin)) {
    function_33eb37d8049856d4(location);
  }
}

function private function_5e41cca93d4be774(location, sightpos) {
  if(ispointinvolume(sightpos, location)) {
    if(getdvarint(@ "hash_27fc8f5297aa897c", 0) == 1) {
      drawentitybounds(location, (0, 1, 0), 0, 2);
      thread draw_line_for_time(location.origin, sightpos, 0, 1, 0, 0.1);
    }

    return true;
  }

  if(getdvarint(@ "hash_27fc8f5297aa897c", 0) == 1) {
    drawentitybounds(location, (1, 0, 0), 0, 2);
    thread draw_line_for_time(location.origin, sightpos, 1, 0, 0, 0.1);
  }

  return false;
}

function private function_3e0b0e44bd4f0cc6(location) {
  function_e5523f33cce17934(location);

  for(;;) {
    if(!ispointinvolume(location function_ab0b1a180a262377(), location)) {
      return;
    }

    var_b11bf04012ba6ffd = location ai::function_359a5497e23b8f79(utility::default_to(level.heros, getaiarray("allies")));

    foreach(ally in var_b11bf04012ba6ffd) {
      if(function_828d4b7ee9640882(ally.origin, 1)) {
        return;
      }
    }

    wait 0.1;
  }
}

function private function_ab0b1a180a262377() {
  if(isDefined(level.gunship) && isDefined(level.gunship.model_ent) && isDefined(level.gunship.model_ent.camera) && isDefined(level.gunship.model_ent.camera.focus_ent)) {
    return level.gunship.model_ent.camera.focus_ent.origin;
  }

  return function_6b7ff0cd994a7fe(level.player)["position"];
}

function private function_33eb37d8049856d4(location) {
  function_e5523f33cce17934(location);

  for(;;) {
    if(!function_828d4b7ee9640882(location.origin)) {
      break;
    }

    wait 0.1;
  }
}

function private function_e5523f33cce17934(location) {
  level.current_location = location.script_noteworthy;
  setomnvar("ui_gunship_target_current_location_name", location.string);
}

function private function_828d4b7ee9640882(origin, fov) {
  if(!isDefined(origin)) {
    return false;
  }

  var_bee9a5f5cd7edd74 = level.player worldpointtoscreenpos(origin, 3);

  if(isDefined(var_bee9a5f5cd7edd74)) {
    return true;
  }

  return false;
}

function private function_dd2e83051a1ccb36(location) {
  while(true) {
    if(utility::is_equal(level.current_location, location.script_noteworthy)) {
      break;
    }

    waitframe();
  }
}

function function_ccf479c366a9220a(var_9621e5eb73de8698, var_71f425ad6588dc8, callouts, guys) {
  guy = function_68a2b6a81f5b1304(var_9621e5eb73de8698, guys);

  if(isDefined(guy)) {
    guy thread function_95ef53cadf8c857(var_71f425ad6588dc8, callouts);
  }

  return guy;
}

function private function_68a2b6a81f5b1304(guy, guys) {
  if(isstring(guy)) {
    guy = function_ed81e1e22cdebb(guy, 1, 1, 1);
  }

  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guys)) {
    self.guys = guys;
    guy thread function_648388325203f8ec(guys);
  }

  function_917ff1f8ceb91fa(guy);
  return guy;
}

function function_648388325203f8ec(guys) {
  self waittill("death");
  guys = array_removedead_or_dying(guys);

  if(isDefined(guys) && guys.size > 0) {
    structs = utility::getStructArray("final_fallback", "targetname");

    foreach(guy in guys) {
      structs = sortbydistance(structs, guy.origin);
      guy thread spawner::go_to_node(structs[0]);
    }
  }
}

function private function_95ef53cadf8c857(var_71f425ad6588dc8, callouts) {
  self endon("entitydeleted");
  self endon("death");
  self endon("long_death");
  self endon("stop_stinger_system");
  thread function_adf323b3088dbe60();
  msg = utility::waittill_any_timeout_3(40, "goal", "goal_reached", "bt_goal");
  wait utility::default_to(var_71f425ad6588dc8, 5);

  for(i = 0;; i++) {
    projectile_object = function_9d330dcaa65d6128();

    if(isDefined(callouts) && isDefined(callouts[i])) {
      level thread function_c9a09b3ba9c68f8d(0.2, callouts[i]);
    }

    function_eb2c289b4425ede7(projectile_object);
    self.shotsfired++;
    level.player playSound("weap_missile_launch_radio");

    if(level.gameskill > 1) {
      if(i <= 3) {
        wait 7 - i;
      } else {
        wait 3;
      }

      continue;
    }

    if(i <= 3) {
      wait 10 - i;
      continue;
    }

    wait 6;
  }
}

function function_adf323b3088dbe60() {
  self endon("entitydeleted");
  self endon("death");
  self endon("long_death");
  self waittill("stop_stinger_system");
  enable_dontevershoot();
}

function function_1ae98071adc3e599(var_9621e5eb73de8698, vehicle, tag, playvo, var_71f425ad6588dc8) {
  guy = function_c660e914556e2e93(var_9621e5eb73de8698, vehicle, tag);
  guy thread function_6a412750ca91484e(playvo, var_71f425ad6588dc8);
}

function private function_c660e914556e2e93(guy, vehicle, tag) {
  if(isstring(guy)) {
    tag = utility::default_to(tag, "tag_seat_6");
    origin = vehicle gettagorigin(tag);
    angles = vehicle gettagangles(tag);
    guy = function_ed81e1e22cdebb(guy, 1, 1, 1, origin, angles);
    guy teleport(origin, angles);
    guy linkTo(vehicle, tag);
  }

  function_917ff1f8ceb91fa(guy);
  return guy;
}

function function_6a412750ca91484e(playvo, var_71f425ad6588dc8) {
  self endon("entitydeleted");
  self endon("death");
  self endon("long_death");
  self endon("stop_stinger_system");
  wait utility::default_to(var_71f425ad6588dc8, 5);

  for(i = 0;; i++) {
    projectile_object = function_9d330dcaa65d6128();
    function_eb2c289b4425ede7(projectile_object);

    if(i < 3) {
      wait 10 - i;
      continue;
    }

    wait 6;
  }
}

function private function_917ff1f8ceb91fa(guy) {
  guy.stinger_weapon = makeweapon("sp_jup_sidewinder_gs_fast");
  guy.var_104340e1ec56a51b = makeweapon("sp_jup_sidewinder_gs_medium");
  guy shared::forceuseweapon("iw9_la_gromeo_sp_ai_gunship", "primary");
  guy allowedstances("stand");
  guy utility::enable_dontevershoot();
  guy utility::set_ignoresuppression(1);
  guy utility::set_maxvisibledist(80000);
  guy utility::set_maxsightdistsquared(2025000000);
  guy utility::set_maxfaceenemydist(80000);
  guy.ignoreme = 1;
  guy.shotsfired = 0;
  guy.var_1051fda886374828 = 1;
  guy.accuracy = 10;
  guy.baseaccuracy = 10;
  guy.var_7811134668469758 = 1;
  guy.var_e169a98f19389f0d = 1;
  guy ai::enable_turnanims();
  guy ai::enable_exits();
  guy thread function_a4f511debe05be3b();

  if(isDefined(self.guys)) {
    self.guys = array_removedead_or_dying(self.guys);

    foreach(guy in self.guys) {
      guy thread function_a4f511debe05be3b();
    }
  }

  return guy;
}

function function_a4f511debe05be3b() {
  self.aiment = createaiment("allies");
  thread delete_on_death(self.aiment);
  self.aiment dontinterpolate();
  self getenemyinfo(self.aiment);
  set_favoriteenemy(self.aiment);
  self endon("death");
  self.aiment endon("death");

  for(;;) {
    var_8f6ac0f5b1cf4391 = self.origin;
    playerpos = level.player.origin;
    var_799f9baa8717f283 = var_8f6ac0f5b1cf4391 - playerpos;
    direction = vectorNormalize(var_799f9baa8717f283);
    self.aiment.origin = var_8f6ac0f5b1cf4391 - direction * 4000;
    waitframe();
  }
}

function private function_9d330dcaa65d6128() {
  utility::disable_dontevershoot();
  utility::set_favoriteenemy(self.aiment);
  self getenemyinfo(self.aiment);
  self.lastenemysightpos = self.aiment.origin;

  if(isDefined(self.guys)) {
    self.guys = array_removedead_or_dying(self.guys);

    foreach(guy in self.guys) {
      guy utility::set_favoriteenemy(guy.aiment);
      guy getenemyinfo(guy.aiment);
      guy.lastenemysightpos = guy.aiment.origin;
    }
  }

  ai::enable_turnanims();
  ai::enable_exits();
  childthread utility::notify_delay("kill_missile_fire_wait_thread", 4);
  projectile_object = function_9df9ebf09ac1dfb6();
  utility::enable_dontevershoot();
  return projectile_object;
}

function private function_9df9ebf09ac1dfb6() {
  self endon("kill_missile_fire_wait_thread");
  self waittill("missile_fire", projectile_object);
  return projectile_object;
}

function private function_eb2c289b4425ede7(projectile_object) {
  if(isDefined(projectile_object)) {
    if(isvalidmissile(projectile_object)) {
      start = projectile_object.origin;
      projectile_object delete();
    } else if(projectile_object tagexists("tag_rocket")) {
      start = projectile_object gettagorigin("tag_rocket") + anglesToForward(projectile_object.angles) * 10;
    } else {
      start = projectile_object.origin;
    }
  } else {
    start = self gettagorigin("tag_flash") + anglesToForward(self.angles) * 10;
  }

  end = level.gunship.model_ent.origin;

  if(distance(self.origin, end) < 30000) {
    missile = magicbullet(self.var_104340e1ec56a51b, start, end);
    missile.weapon_name = self.var_104340e1ec56a51b.basename;
  } else {
    missile = magicbullet(self.stinger_weapon, start, end);
    missile.weapon_name = self.stinger_weapon.basename;
  }

  function_25eadd19d87ff8f3(missile);
}

function function_25eadd19d87ff8f3(missile) {
  if(!isDefined(level.gunship) || !isDefined(level.gunship.model_ent)) {
    return;
  }

  missile missile_settargetEnt(level.gunship.model_ent);
  missile missile_setflightmodedirect();
  missile missileoutline();
  missile missilethermal();
  missile.owner = self;

  if(!missile utility::ent_flag_exist("missile_pairedWithBadFlare")) {
    missile utility::ent_flag_init("missile_pairedWithBadFlare");
  }

  if(!missile utility::ent_flag_exist("missile_pairedWithFlare")) {
    missile utility::ent_flag_init("missile_pairedWithFlare");
  }

  if(!missile utility::ent_flag_exist("missile_FlareToSoon")) {
    missile utility::ent_flag_init("missile_FlareToSoon");
  }

  missile thread function_5207b76e808099aa();
  missile thread function_c88f0ba9aac8ce06(level.gunship.model_ent);
  level.stinger_missiles = utility::array_add(level.stinger_missiles, missile);
  level.var_1250917a0280ae9 = utility::array_add(level.var_1250917a0280ae9, missile);
  missile utility::waittill_any_2("death", "detonate");
  level.stinger_missiles = utility::array_removeundefined(level.stinger_missiles);
}

function private function_5207b76e808099aa() {
  if(!isDefined(level.gunship) || !isDefined(level.gunship.model_ent)) {
    return;
  }

  self endon("missile_pairedWithFlare");
  level.gunship endon("entitydeleted");
  level.gunship.model_ent endon("entitydeleted");
  var_c74e2e565ee3fe18 = self.origin;

  for(;;) {
    if(isDefined(self)) {
      var_c74e2e565ee3fe18 = self.origin;
    }

    if(utility::flag("missile_pairedWithBadFlare") || distance(var_c74e2e565ee3fe18, level.gunship.model_ent.origin) <= 2000) {
      start = gettime();

      while(!utility::time_has_passed(start, 1.5)) {
        if(isDefined(self)) {
          var_c74e2e565ee3fe18 = self.origin;
        }

        if(utility::flag("missile_pairedWithBadFlare") || distance(var_c74e2e565ee3fe18, level.gunship.model_ent.origin) <= 300) {
          break;
        }

        waitframe();
      }

      thread function_7b390017a5eae85c();

      if(isDefined(self)) {
        level.var_1250917a0280ae9 = utility::array_remove(level.var_1250917a0280ae9, self);

        if(isvalidmissile(self)) {
          self detonate();
        }
      }

      break;
    }

    waitframe();
    waitframe();
  }
}

function private function_7b390017a5eae85c() {
  level.gunship endon("entitydeleted");
  level.gunship.model_ent endon("entitydeleted");
  utility::flag_set("disable_autosaves");
  level.gunship.model_ent thread namespace_fd9c6daa1372e62b::gunship_playfakebodyexplosion();
  level.player utility::delaycall(0.3, &playsound, "scn_gshp_missile_death_exp_lr");
  wait 0.4;
  level.gunship.model_ent thread namespace_fd9c6daa1372e62b::gunship_crash(15, level.player);
  wait 1;
  player_death::clear_custom_death_quote();
  player_death::set_custom_death_quote(224);
  thread utility::missionfailedwrapper();
}

function private function_c88f0ba9aac8ce06(target) {
  self endon("death");
  self endon("detonate");

  while(isDefined(target) && distance(self.origin, target.origin) > level.var_5a3ea76578f68c94) {
    waitframe();
  }

  level.player thread utility::display_hint("use_flares", 5, undefined, self, "hint_function_cancel");

  while(isDefined(target) && distance(self.origin, target.origin) > level.var_5a1b956578d01d46) {
    waitframe();
  }

  self notify("hint_function_cancel");
}

function function_e2dda65613b9fe4f(tname, var_d44ffaf3bb93db6d) {
  var_35716480029d5ae4 = getEnt(tname, "targetname");
  var_f37e1dfdd520e065 = [];
  var_f37e1dfdd520e065[var_f37e1dfdd520e065.size] = "dx_sp_jsgs_hngr_grav_keepemoutofthehangar";
  var_f37e1dfdd520e065[var_f37e1dfdd520e065.size] = "dx_sp_jsgs_hngr_grav_gunnerpushkonnibackf";
  var_f37e1dfdd520e065[var_f37e1dfdd520e065.size] = "dx_sp_jsgs_hngr_fara_shadow1coverthehanga";
  var_f37e1dfdd520e065[var_f37e1dfdd520e065.size] = "dx_sp_jsgs_hngr_shep_shadow1keeptheground";
  var_f37e1dfdd520e065[var_f37e1dfdd520e065.size] = "dx_sp_jsgs_veha_fara_graveskeepthemoffus";

  if(isDefined(var_d44ffaf3bb93db6d)) {
    var_f37e1dfdd520e065 = array_combine(var_d44ffaf3bb93db6d, var_f37e1dfdd520e065);
  }

  var_35716480029d5ae4 thread threatwarningwatcher(var_f37e1dfdd520e065);
}

function threatwarningwatcher(var_f37e1dfdd520e065) {
  level notify("stop_threatWarningWatcher");
  level endon("stop_threatWarningWatcher");
  level endon("missionfailed");
  utility::flag_clear("main_hangar_warning_vo");
  i = 0;
  var_16721ba1db2dd4c9 = -10000;

  for(;;) {
    threats = utility::get_ai_touching_volume("axis");
    threats = array_removedead_or_dying(threats);

    if(threats.size >= 3 && !flag("main_hangar_warning_vo") && time_has_passed(var_16721ba1db2dd4c9, 5)) {
      if(i >= var_f37e1dfdd520e065.size) {
        i = 0;
      }

      said_line = level scripts\anim\dialogue::say_global(var_f37e1dfdd520e065[i], 0, 1);

      if(isDefined(said_line) && said_line) {
        var_16721ba1db2dd4c9 = gettime();
        i++;
      }
    }

    wait 1;
  }
}

function function_d8fbd5fda6bc8171(tname) {
  var_46c7b282b1b58c27 = getEnt(tname, "targetname");
  var_46c7b282b1b58c27 thread threatfailwatcher();
}

function threatfailwatcher() {
  level notify("stop_threatFailWatcher");
  level endon("stop_threatFailWatcher");
  level endon("missionfailed");
  lastcount = 0;
  threats = undefined;

  for(;;) {
    threats = utility::get_ai_touching_volume("axis");
    threats = array_removedead_or_dying(threats);

    if(getdvarint(@ "hash_5db9993d6668bf59") == 1 && lastcount != threats.size) {
      iprintln("<dev string:x3b0>" + threats.size + "<dev string:x3e0>" + 3);
    }

    lastcount = threats.size;

    if(threats.size > 3) {
      break;
    }

    foreach(i, threat in threats) {
      if(isDefined(threat) && !istrue(threat.var_e2382ae8457f89d4)) {
        threat thread function_2bfe5fbc3b459709(3 + i);
      }
    }

    wait 1;
  }

  threats = utility::get_ai_touching_volume("axis");
  threats = array_removedead_or_dying(threats);

  foreach(threat in threats) {
    if(isDefined(threat) && !istrue(threat.var_e2382ae8457f89d4)) {
      threat thread function_2bfe5fbc3b459709(i);
    }
  }

  while(isDefined(level.jet_01) || isDefined(level.jet_02)) {
    waitframe();
  }

  utility::flag_set("main_hangar_warning_vo");
  level dialogue("dx_sp_jsgs_vehb_grav_cleanemupshadowskeep", 1);
  wait 6;
  utility::flag_clear("main_hangar_warning_vo");
  threats = utility::get_ai_touching_volume("axis");

  foreach(threat in threats) {
    threat kill();
  }

  waitframe();

  for(;;) {
    threats = utility::get_ai_touching_volume("axis");
    threats = array_removedead_or_dying(threats);

    if(getdvarint(@ "hash_5db9993d6668bf59") == 1 && lastcount != threats.size) {
      iprintln("<dev string:x3f5>" + threats.size + "<dev string:x3e0>" + 3);
    }

    lastcount = threats.size;

    if(threats.size > 3) {
      break;
    }

    wait 1;
  }

  player_death::clear_custom_death_quote();
  player_death::set_custom_death_quote(263);
  thread utility::missionfailedwrapper();
}

function function_2bfe5fbc3b459709(delay) {
  self endon("death");
  self.var_e2382ae8457f89d4 = 1;
  wait delay;
  self kill();
}

function function_d7b6d94ded0800b6() {
  level.boss_heli = vehicle::spawn_vehicle_from_targetname("boss_heli");
  level.boss_heli setvehicleteam("axis");
  level.boss_heli.script_team = "axis";
  level.boss_heli.bossheli = 1;
  level.boss_heli.forced_target = level.price;
  level.boss_heli.lastattackplayertime = 0;
  level.boss_heli.clip = getEnt("heli_boss_clip", "targetname");

  if(isDefined(level.boss_heli.clip)) {
    level.boss_heli.clip linkTo(level.boss_heli);
    level.boss_heli thread utility::delete_on_death(level.boss_heli.clip);
  }

  level.boss_heli hidepart("tag_light_belly");
  level.boss_heli hidepart("tag_light_2");
  level.boss_heli hidepart("tag_personnel_platform");
  level.boss_heli hidepart("tag_window_cockpit_left1");
  level.boss_heli hidepart("tag_window_cockpit_left2");
  level.boss_heli hidepart("tag_window_cockpit_left3");
  level.boss_heli hidepart("tag_window_cockpit_right1");
  level.boss_heli hidepart("tag_window_cockpit_right2");
  level.boss_heli hidepart("tag_window_cockpit_right3");
  level.boss_heli hidepart("tag_window_left");
  level.boss_heli hidepart("tag_window_right");
  level.boss_heli hidepart("tag_engine_left");
  level.boss_heli hidepart("tag_engine_right");
  level.boss_heli hidepart("tag_exhaust");
  level.boss_heli hidepart("tag_passenger1");
  level.boss_heli hidepart("tag_passenger2");
  level.boss_heli hidepart("tag_passenger3");
  level.boss_heli hidepart("tag_passenger4");
  level.boss_heli hidepart("tag_passenger5");
  level.boss_heli hidepart("tag_passenger6");
  level.boss_heli hidepart("tag_pedal_l_rot");
  level.boss_heli hidepart("tag_pedal_r_rot");
  level.boss_heli hidepart("tag_pilot1");
  level.boss_heli hidepart("tag_pilot2");
  level.boss_heli hidepart("tag_seat_1");
  level.boss_heli hidepart("tag_seat_2");
  level.boss_heli hidepart("tag_seat_3");
  level.boss_heli hidepart("tag_seat_4");
  level.boss_heli hidepart("tag_seat_5");
  level.boss_heli hidepart("tag_seat_6");
  level.boss_heli hidepart("tag_seat_7");
  level.boss_heli hidepart("tag_stick_l_rot");
  level.boss_heli hidepart("tag_stick_r_rot");
  level.boss_heli hidepart("tag_turret_left");
  level.boss_heli hidepart("tag_turret_right");
  level.boss_heli hidepart("tag_weapon_platform");
  level.boss_heli function_1cc521c17684b8af();
  level.boss_heli thread function_d11c71aac7720c04();
  level.boss_heli waittill("death");
  utility::autosave_by_name("heli_dead");
  last_origin = level.boss_heli.origin;
  start = gettime();

  while(isDefined(level.boss_heli) && level.boss_heli vehicle::vehicle_is_crashing()) {
    last_origin = level.boss_heli.origin;

    if(utility::time_has_passed(start, 30)) {
      break;
    }

    waitframe();
  }

  utility::flag_set("heli_dead");
}

function private heli_mg_create() {
  tag = "tag_light_1";
  origin = self gettagorigin(tag);
  originoffset = (-13, 0, 0);
  anglesoffset = (-35, 0, 0);
  self.minigun = spawnturret("misc_turret", origin, "jup_mg_heli_sp_gunship");
  self.minigun dontinterpolate();
  self.minigun setModel("veh9_mil_air_halfa_turret");
  self.minigun linkTo(self, tag, originoffset, anglesoffset);
  self.minigun makeunusable();
  self.minigun setmode("manual");
  self.minigun setdefaultdroppitch(0);
  self.minigun setleftarc(180);
  self.minigun setrightarc(180);
  self.minigun settoparc(180);
  self.minigun setbottomarc(180);
  self.minigun hidepart("tag_pivot");
  self.minigun.target_ent = utility::spawn_tag_origin();
  self.minigun.chopper = self;
  self.mg_z_offset = self.origin[2] - self.minigun gettagorigin("tag_flash")[2];
  thread utility::delete_on_death(self.minigun.target_ent);
  thread utility::delete_on_death(self.minigun);

  if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
    thread utility::draw_line_from_ent_to_ent_for_time(self, self.minigun, 1, 0, 0, 20);
  }
}

function private function_1cc521c17684b8af() {
  self.var_ce0f99d5c8a83033 = utility::spawn_tag_origin(self gettagorigin("tag_weapon_platform"), self gettagangles("tag_weapon_platform"));
  self.var_ce0f99d5c8a83033 setModel("veh9_mil_air_heli_medium_weapon_platform");
  self.var_ce0f99d5c8a83033 show();
  self.var_ce0f99d5c8a83033 notsolid();
  self.var_ce0f99d5c8a83033 linkTo(self);
  thread utility::delete_on_death(self.var_ce0f99d5c8a83033);

  if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
    thread utility::draw_line_from_ent_to_ent_for_time(self, self.var_ce0f99d5c8a83033, 1, 0, 0, 20);
    function_972002956f96b719("<dev string:x41d>");
    function_972002956f96b719("<dev string:x422>");
  }
}

function private function_972002956f96b719(side) {
  tag = "tag_turret_right";

  if(isDefined(side) && side == "left") {
    tag = "tag_turret_left";
  }

  origin = self gettagorigin(tag) + anglesToForward(self.angles) * 10;

  if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
    thread utility::draw_line_from_ent_for_time(self, origin, 1, 0, 1, 5);
  }

  return origin;
}

function private function_d11c71aac7720c04() {
  self endon("death");
  self endon("crashing");
  childthread function_7a74e5451a6d5475();
  self.heli_fight_start = gettime();
  self setneargoalnotifydist(2000);
  self setyawspeed(200, 100);
  self notsolid();

  if(isDefined(self.clip)) {
    self.clip notsolid();
  }

  setdvarifuninitialized(@ "hash_9235e8c1a6ed9479", 0);

  if(isDefined(self.forced_target)) {
    self setlookatent(self.forced_target);
  }

  self.left_lanes = utility::getStructArray("left_heli_lane", "targetname");
  self.right_lanes = utility::getStructArray("right_heli_lane", "targetname");
  self.lanes = utility::getStructArray("heli_lanes", "script_noteworthy");
  self.lanes = utility::array_sort_by_script_index(self.lanes);
  self.intro_targets = getStructArray("heli_intro_targets", "targetname");
  self.intro_targets = utility::array_sort_by_script_index(self.intro_targets);
  self.targets = getStructArray("heli_targets", "targetname");
  self.targets = utility::array_sort_by_script_index(self.targets);
  toggle = 1;
  dir = 0;
  self.var_c109ad9a9d2b200b = self.lanes.size - 1;
  self.laneindex = self.var_c109ad9a9d2b200b;
  var_46162a9cd6df4156 = 1;
  totaltargets = self.targets.size - 1;
  targetent = self.targets[0] spawn_tag_origin();
  shotindex = 0;
  var_55dd861ef3d0be95 = totaltargets;
  targetent dontinterpolate();
  lastshottime = gettime();
  startingpos = utility::getStruct("heli_boss_start", "targetname").origin;
  var_1ebfceae93b225fc = self.lanes[self.laneindex].origin;
  nav_gotopos(self.origin + (0, 0, 3000), 120, 1);
  thread function_4c563c7ff55013ea();
  nav_gotopos(startingpos, 180, 1);
  self solid();

  if(isDefined(self.clip)) {
    self.clip solid();
  }

  level.gunship.var_f81a604f04ca7c67 = 1;
  level.gunship.var_3878f8cac277eba = 1;
  level.gunship.var_fe8115e13e88cccd = 400;
  utility::autosave_by_name("heliStart");
  utility::flag_set("heliStart");

  if(isDefined(self.minigun)) {
    childthread function_5a4818e7fa4a5e15();
  }

  level notify("stop_intro_shots");
  nav_gotopos(var_1ebfceae93b225fc, 180, 1);
  self setneargoalnotifydist(1000);
  childthread function_1ecce45acde23871();
  targetent.origin = self.targets[shotindex].origin;
  missile = magicbullet("sp_jup_sidewinder_gs_medium", function_972002956f96b719(), self.targets[shotindex].origin, self, self);
  thread function_3ca8381194a24dd3(missile, targetent);
  level.gaz thread dialogue::say_team("dx_sp_jsgs_hbss_gazz_helostryintotakeoutt");

  if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
    iprintln("<dev string:x428>");
  }

  for(;;) {
    self notify("new_goal");

    if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
      iprintlnbold("<dev string:x43b>" + self.laneindex);
    }

    var_2f6d705ee137c791 = self.lanes[self.laneindex];
    var_4e366f9a49733fb0 = utility::getStruct(var_2f6d705ee137c791.target, "targetname");
    dir = function_7121fd43cf625550(dir);

    if(dir) {
      self.laneindex++;
    } else {
      self.laneindex--;
    }

    var_7370793860a8134b = pointonsegmentnearesttopoint(var_2f6d705ee137c791.origin, var_4e366f9a49733fb0.origin, var_4e366f9a49733fb0.origin);
    desiredz = getgroundposition(var_7370793860a8134b, 60, 2000)[2] + randomintrange(0, 500);
    var_f6d78c5bef7a368b = (var_7370793860a8134b[0], var_7370793860a8134b[1], desiredz);
    heli_movetopos_and_idle(var_f6d78c5bef7a368b, !function_c01b5f0ab32eb8b6());

    if(utility::time_has_passed(lastshottime, utility::ter_op(level.gameskill > 1, 2, 3))) {
      thread function_f669c2358dc40578(shotindex);

      if(shotindex < totaltargets) {
        shotindex++;
      }

      targetent.origin = self.targets[shotindex].origin;
      missile = magicbullet("sp_jup_sidewinder_gs_medium", function_972002956f96b719(), self.targets[shotindex].origin, self, self);
      missile missile_settargetEnt(targetent);
      level.var_1250917a0280ae9[level.var_1250917a0280ae9.size] = missile;
      thread function_3ca8381194a24dd3(missile, targetent);
      lastshottime = gettime();

      if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
        iprintlnbold("<dev string:x449>" + shotindex);
      }
    }

    if(shotindex == var_55dd861ef3d0be95) {
      if(isDefined(missile)) {
        missile utility::waittill_any_3("death", "detonate", "explode");
      }

      if(vehicle::vehicle_is_crashing()) {
        break;
      }

      thread function_75904bd709ff0101(targetent);
    }

    if(shotindex > totaltargets) {
      shotindex = 0;
    }

    waitframe();
  }
}

function function_75904bd709ff0101(targetent) {
  function_277990754d304280(targetent.origin);
  wait 1;
  player_death::clear_custom_death_quote();
  player_death::set_custom_death_quote(randomintrange(250, 251));
  thread utility::missionfailedwrapper();
}

function function_7a74e5451a6d5475() {
  utility::flag_wait("heli_boss_marked");
  self.marker = thread function_91fff8ef1083babf((0, 0, -150), 1, 1, 1, "icon_waypoint_overlay_marker_special");
}

function function_f669c2358dc40578(shotindex) {
  if(!isDefined(self)) {
    return;
  }

  self endon("death");

  while(istrue(self.var_1967db094be8f570)) {
    wait 0.1;
  }

  shotindex = default_to(shotindex, 7);
  self.var_1967db094be8f570 = 1;

  switch (shotindex) {
    case 0:
      if(isDefined(level.farah)) {
        level.farah dialogue::say_team("dx_sp_jsgs_hbss_fara_gravesshoothimdowndo");
      }

      break;
    case 1:
      if(isDefined(level.alex)) {
        level.alex dialogue::say_team("dx_sp_jsgs_hbss_alex_weretakingfirefromth");
      }

      break;
    case 2:
      if(isDefined(level.price)) {
        level.price dialogue::say_team("dx_sp_jsgs_hbss_pric_groundteamstakingfir");
      }

      break;
    case 3:
      if(isDefined(level.price)) {
        level.price dialogue::say_team("dx_sp_jsgs_hbss_pric_contactenemyhelo");
      }

      break;
    case 4:
      if(isDefined(level.farah)) {
        level.farah dialogue::say_team("dx_sp_jsgs_hbss_fara_helosattackingthehan");
      }

      break;
    case 5:
      if(isDefined(level.price)) {
        level.price dialogue::say_team("dx_sp_jsgs_hbss_pric_helosfiringonthehang");
      }

      break;
    case 6:
      level dialogue::say_team("dx_sp_jsgs_hbss_ssig_helosattackingthehan");
      break;
    case 7:
      level dialogue::say_team("dx_sp_jsgs_hbss_ssig_helosfiringonthehang");
      break;
  }

  self.var_1967db094be8f570 = 0;
}

function private function_4c563c7ff55013ea() {
  level endon("stop_intro_shots");

  foreach(target in self.intro_targets) {
    wait default_to(target.script_delay, 2);
    missile = magicbullet("sp_jup_sidewinder_gs_medium", function_972002956f96b719(), target.origin, self, self);
    thread function_b5396647fe8565f(missile, target, 1);
  }
}

function private function_b5396647fe8565f(missile, target, var_e759bcacfdc989c4) {
  targetent = spawn_tag_origin(target.origin);
  missile missile_settargetEnt(targetent);
  missile utility::waittill_any_3("death", "detonate", "explode");

  if(isDefined(missile)) {
    playFX(utility::getfx("vfx_heli_missile"), missile.origin);

    if(isDefined(target.radius)) {
      radiusdamage(missile.origin, target.radius, 1000, 1000, self, "MOD_EXPLOSIVE", "gunship_hellfire_jup_sp", 1, 0);

      if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
        utility::draw_circle(missile.origin, target.radius, (1, 0, 0), 1, 0, 50);
      }
    }
  } else if(!istrue(var_e759bcacfdc989c4)) {
    playFX(utility::getfx("vfx_heli_missile"), target.origin);

    if(isDefined(target.radius)) {
      radiusdamage(target.origin, target.radius, 1000, 1000, self, "MOD_EXPLOSIVE", "gunship_hellfire_jup_sp", 1, 0);

      if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
        utility::draw_circle(target.origin, target.radius, (1, 0, 0), 1, 0, 50);
      }
    }
  }

  if(isDefined(targetent)) {
    targetent delete();
  }
}

function private function_1ecce45acde23871() {
  while(isDefined(self)) {
    level waittill("hellfire_missile_launched", missile, target);
    function_678199a40c666212(missile, target);
    waitframe();
  }
}

function private function_678199a40c666212(missile, target) {
  missile endon("death");
  target endon("death");

  for(;;) {
    newtarget = target;

    if(function_62b8bb40735c58a2(0.999848, self.origin, [self])) {
      newtarget = self;

      if(getdvarint(@ "hash_4f9bb1735456045d", 0) == 1) {
        thread utility::draw_line_from_ent_to_ent_for_time(missile, newtarget, 0, 1, 0, 0.05);
      }
    } else {
      if(getdvarint(@ "hash_4f9bb1735456045d", 0) == 1) {
        thread utility::draw_line_from_ent_to_ent_for_time(missile, newtarget, 1, 0, 0, 0.05);
      }
    }

    if(isvalidmissile(missile)) {
      missile missile_settargetEnt(newtarget);
    }

    waitframe();
  }
}

function private function_3ca8381194a24dd3(missile, target) {
  missile waittill("explode", origin, hitnormal, velocity, entity);
  thread function_f4edab1c90569f7c(origin);
  radius = default_to(target.radius, 100);
  weapon = "gunship_hellfire_jup_sp";

  if(isDefined(entity) && isDefined(entity.model) && issubstr(entity.model, "hangar")) {
    weapon = "gunship_40mm_jup_sp";
  }

  playFX(utility::getfx("vfx_heli_missile"), origin);

  if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
    utility::draw_circle(origin, radius, (0, 0, 1), 1, 0, 50);
  }
}

function private function_7121fd43cf625550(upward) {
  if(self.laneindex >= self.var_c109ad9a9d2b200b) {
    upward = 0;
  } else if(self.laneindex <= 0) {
    upward = 1;
  }

  return upward;
}

function private function_ba20c6ffc750d926(left_side) {
  array = self.right_lanes;

  if(left_side) {
    array = self.left_lanes;
  }

  return array;
}

function private nav_gotopos(pos, speed, var_b2143013b5e8bd6) {
  self notify("nav_new_path");
  self endon("nav_new_path");
  path = findpath3d(self.origin, pos);

  if(!isDefined(path)) {
    if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
      iprintlnbold("<dev string:x457>");
    }

    return;
  }

  shouldstop = 0;

  if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
    thread draw_3d_path(path);
  }

  speed = utility::default_to(speed, utility::ter_op(function_c01b5f0ab32eb8b6(), 180, 120));
  self vehicle_setspeed(speed);

  foreach(spot in path) {
    if(!istrue(var_b2143013b5e8bd6) && i == path.size - 1 && !function_c01b5f0ab32eb8b6()) {
      shouldstop = 1;
    }

    self setvehgoalpos(spot, shouldstop);
    utility::waittill_any("near_goal", "goal");
  }

  self notify("nav_goal");
}

function private heli_movetopos_and_idle(spot, var_6f1016bcebbf4ba0) {
  nav_gotopos(spot, undefined, var_6f1016bcebbf4ba0);

  if(var_6f1016bcebbf4ba0) {
    stoptime = 5 + randomint(2);
    start = gettime();

    while(!utility::time_has_passed(start, stoptime)) {
      if(function_c01b5f0ab32eb8b6()) {
        wait 1;
        return;
      }

      waitframe();
    }
  }
}

function private function_c01b5f0ab32eb8b6() {
  result = level.player attackButtonPressed() && function_62b8bb40735c58a2(0.99863, self.origin, [self]);

  if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1 && result) {
    iprintln("<dev string:x48f>");
  }

  return result;
}

function private draw_3d_path(array) {
  start = self.origin;

  foreach(spot in array) {
    line(start, spot, (1, 1, 1), 1, 0, 100);

    start = spot;
    wait 0.05;
  }
}

function private function_5a4818e7fa4a5e15() {
  utility::set_attackeraccuracy(0);
  self.minigun.target_ent.origin = level.price.origin;
  self.minigun settargetentity(self.minigun.target_ent);
  self.minigun startbarrelspin();
  wait 1;

  for(;;) {
    self.minigun shootturret();
    magicbullet("iw9_ar_kilo53_sp_gunship", self.minigun gettagorigin("tag_flash"), self.minigun.target_ent.origin, undefined, undefined, 200);
    wait 0.1;
  }
}

function private get_heli_target(contentoverride) {
  var_738d1a13e2331013 = gettime() - self.lastattackplayertime;

  if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
    iprintlnbold(var_738d1a13e2331013 / 1000 + "<dev string:x4a2>");
  }

  if(var_738d1a13e2331013 >= 2000) {
    if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
      iprintlnbold("<dev string:x4be>");
    }

    self.lastattackplayertime = gettime();
    return level.player;
  }

  if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
    iprintlnbold("<dev string:x4cf>");
  }

  target = undefined;
  targets = [];

  if(!utility::flag("in_safe_trigger") && isDefined(level.var_bbd08829eaa1ab76)) {
    targets = sortbydistancecullbyradius(level.var_bbd08829eaa1ab76, level.player.origin, 1000);
  } else {
    foreach(g in getaiarray("allies")) {
      if(!isDefined(g.magic_bullet_shield)) {
        targets[targets.size] = g;
      }
    }

    targets = sortbydistance(targets, level.player.origin);
  }

  target = targets[targets.size - 1];
  return target;
}

function private heli_fov_check(contentoverride) {
  playerpos = level.player getEye() + (0, 0, 10);
  helipos = self.minigun gettagorigin("tag_flash");
  allies = utility::array_removeundefined(level.heroes);
  ignore = utility::array_add(allies, self);

  if(trace::ray_trace_passed(helipos, playerpos, ignore, contentoverride)) {
    if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
      thread utility::draw_line_for_time(helipos, playerpos, 0, 1, 0, 2);
    }

    return 1;
  }

  if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
    thread utility::draw_line_for_time(helipos, playerpos, 1, 0, 0, 2);
  }

  return 0;
}

function private should_kill_player() {
  var_9ce10f91f815115 = 10;
  var_78b8332fff7b192f = 15;
  var_9ce10f91f815115 *= 1000;

  if(!isDefined(self.last_kill_attempt_time) && gettime() - self.heli_fight_start >= var_78b8332fff7b192f) {
    return true;
  }

  if(isDefined(self.last_kill_attempt_time) && gettime() - self.last_kill_attempt_time >= var_9ce10f91f815115) {
    return true;
  }

  return false;
}

function private shoottokill(target, contentoverride) {
  if(istrue(self.noshooting) || istrue(target.magic_bullet_shield)) {
    return;
  }

  self endon("death");
  target endon("death");
  self endon("stop_shooting");
  self.last_kill_attempt_time = gettime();
  self.minigun startbarrelspin();
  self.is_shooting = 1;
  burstsize = 60;
  wait 0.5;

  if(isPlayer(target)) {
    dist = 375;
    self.minigun.target_ent.origin = target.origin + anglesToForward(target.angles) * dist;

    while(true) {
      if(isDefined(self.forced_target)) {
        target = self.forced_target;
      }

      dist -= 10;
      self.minigun.target_ent.origin = target.origin + anglesToForward(target.angles) * dist;

      if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
        line(self.minigun.target_ent.origin, self.minigun.origin, (1, 0, 0), 1, 0, 1);
      }

      self.minigun shootturret();
      wait 0.05;

      if(distance(target.origin, self.minigun.target_ent.origin) < 50) {
        break;
      }
    }
  }

  for(i = 0; i < burstsize; i++) {
    if(isDefined(self.forced_target)) {
      target = self.forced_target;
    }

    if(isPlayer(target) && target issprinting()) {
      self.minigun settargetentity(target, utility::randomvector(50));
    } else {
      self.minigun settargetentity(target, (15, 15, 20));
    }

    if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
      thread utility::draw_line_for_time(self.minigun gettagorigin("<dev string:x4df>"), target.origin, 0, 1, 0, 0.5);
    }

    self.minigun shootturret();

    if(isDefined(target) && target.health <= 0) {
      if(isPlayer(target) && !trace::ray_trace_detail_passed(self.minigun.origin, target getEye(), [self.minigun, level.player, self])) {
        return;
      }

      target kill();
      return;
    }

    if(i == burstsize * 0.5) {
      wait 0.3;
      continue;
    }

    wait 0.05;
  }

  wait 0.5;
  self.minigun stopbarrelspin();
  self.is_shooting = 0;
}

function private hurttarget(target) {
  if(istrue(self.noshooting) || istrue(target.magic_bullet_shield)) {
    return;
  }

  self endon("death");
  self endon("stop_shooting");
  target endon("death");
  self.minigun startbarrelspin();
  self.is_shooting = 1;

  if(level.gameskill < 2) {
    var_4dc328e60cd0f41e = 30;
    vector = 60;
  } else {
    var_4dc328e60cd0f41e = 1;
    vector = 30;
  }

  wait 0.5;
  dist = 450;
  self.minigun.target_ent.origin = target.origin + anglesToForward(target.angles) * dist;

  while(true) {
    dist -= 10;

    if(isDefined(self.forced_target)) {
      target = self.forced_target;
    }

    self.minigun.target_ent.origin = target.origin + anglesToForward(target.angles) * dist;

    if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
      line(self.minigun.target_ent.origin, self.minigun.origin, (1, 0, 0), 1, 0, 1);
    }

    self.minigun shootturret();
    wait 0.05;

    if(distance(target.origin, self.minigun.target_ent.origin) < 50) {
      break;
    }
  }

  burstsize = 60;
  starthealth = target.health;
  hits = 0;

  for(i = 0; i < burstsize; i++) {
    if(isDefined(self.forced_target)) {
      target = self.forced_target;
    }

    if(target.health <= var_4dc328e60cd0f41e) {
      break;
    }

    if(isPlayer(target)) {
      self.minigun settargetentity(target, utility::randomvector(vector));
    } else {
      self.minigun settargetentity(target, (24, -24, 40));
    }

    self.minigun shootturret();
    wait 0.05;

    if(target.health != starthealth) {
      starthealth = target.health;
    }
  }

  wait 0.5;
  self.minigun stopbarrelspin();
  self.is_shooting = 0;
}

function private canshoottargetfrompos(pos, target) {
  if(istrue(self.noshooting)) {
    return 0;
  }

  if(isPlayer(target) || isai(target)) {
    spot = target getEye();
  } else {
    spot = target.origin;
  }

  bool = sighttracepassed(pos - (0, 0, self.mg_z_offset), spot, 0, self);

  if(bool) {
    color = (0, 1, 0);
  } else {
    color = (1, 0, 0);
  }

  if(getdvarint(@ "hash_9235e8c1a6ed9479", 0) == 1) {
    line(pos, spot, color, 1, 0, 60);
  }

  return bool;
}

function function_b8133e9adfa151db(toggle) {
  level.var_71c1d077a88bb377 = istrue(toggle);
  level.var_9683ea2462b2baa = istrue(toggle);
}

function private function_8cc4525cfcf7b932() {
  aliases = [];
  aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_gunsgunsguns";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_firing";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_onthetrigger";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_goinghot";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_goinghot25";
  firing_rounds = utility::create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_engaging";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_roundsaway";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_roundsout";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_goinghotonthe40";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_goinghot40mikemike";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_shotsout";
  var_95ad20e9f19bdd1d = utility::create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_missileout";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_missilesaway";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_launchingmissile";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_missileloose";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_sendinit";
  firing_missile = utility::create_deck(aliases, 1, 1);
  var_bb051c58570fc5b = 0;
  last_fire_time = 0;
  var_be698f2d1b4118d7 = 0;
  var_1cb6d69302e8ba77 = 0;

  while(true) {
    level.player waittill("gunship_fired", current_weapon_name);
    var_1cb6d69302e8ba77 = var_be698f2d1b4118d7;
    var_be698f2d1b4118d7 = last_fire_time;
    last_fire_time = gettime();

    if(istrue(level.var_9683ea2462b2baa)) {
      continue;
    }

    if(!utility::time_has_passed(var_bb051c58570fc5b, 20) && !istrue(level.var_c46a8341e774dd87)) {
      continue;
    }

    if(current_weapon_name == level.gunship.var_d660505e3d0ba81d) {
      if(!utility::time_has_passed(var_1cb6d69302e8ba77, 10)) {
        continue;
      }

      if(utility::time_has_passed(var_be698f2d1b4118d7, 2)) {
        continue;
      }

      if(utility::percent_chance(35)) {
        continue;
      }

      alias = firing_rounds utility::deck_draw();
      level dialogue::say_global(alias, 0, 0.4);
    } else if(current_weapon_name == level.gunship.var_d6604d5e3d0ba184) {
      if(!utility::time_has_passed(var_1cb6d69302e8ba77, 10)) {
        continue;
      }

      if(utility::time_has_passed(var_be698f2d1b4118d7, 2)) {
        continue;
      }

      if(utility::percent_chance(40)) {
        continue;
      }

      alias = var_95ad20e9f19bdd1d utility::deck_draw();
      level dialogue::say_global(alias, 0, 0.4);
    } else {
      if(utility::percent_chance(35) && !istrue(level.var_c46a8341e774dd87)) {
        continue;
      }

      alias = firing_missile utility::deck_draw();
      level dialogue::say_global(alias, 0, 0.4);
    }

    var_bb051c58570fc5b = gettime();
  }
}

function private function_3f6146304bdf60cf() {
  aliases = [];
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_wreckedhim";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_nice";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_goodshot";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_goodeffect";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_goodattack";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_direct";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_direct_01";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_goodimpact";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_thatguysdone";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_thatdudessmoked";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_hesnotgoinanywhere";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_hellyeah";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_boombaby";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_thingabeauty";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_kaboom";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_goodimpact_01";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_getsome";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_getsome_01";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_yupyup";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_welcometourzikstan";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_ssig_thatonegotsomeair";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_ssig_thatdudehadsomehangt";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_ssig_ekia";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_ssig_onedown";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_ssig_minusone";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_ssig_gotem";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_nice";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_goodshot";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_goodeffect";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_goodattack";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_direct";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_direct_01";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_goodimpact";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_goodshots";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_nice_01";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_wrecked";
  var_7df6e036103b0fe1 = utility::create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_thatswhatimtalkinabo";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_lookatemtheydonteven";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_youcanrunbutyoulljus";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_theyredone";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_canthidefromtheeyein";
  aliases[aliases.size] = "dx_sp_jsgs_psh1_grav_theythoughttheyweret";
  var_8f4a6efdca48458d = utility::create_deck(aliases, 0, 1);
  level.var_27f210525d1d7704 = var_8f4a6efdca48458d;
  aliases = [];
  aliases[aliases.size] = "dx_sp_gscp_gnht_sh1f_impactwithinthearea";
  aliases[aliases.size] = "dx_sp_gscp_gnht_sh1f_roundsinthearea";
  aliases[aliases.size] = "dx_sp_gscp_gnht_sh1f_missedem";
  aliases[aliases.size] = "dx_sp_gscp_gnht_sh1f_thatguysstillmoving";
  var_81ee21d4ec6abab7 = utility::create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_sp_gscp_gnht_sh1t_aggravatedgruntcmon";
  aliases[aliases.size] = "dx_sp_gscp_gnht_sh1t_aggravatedgrunt";
  aliases[aliases.size] = "dx_sp_gscp_gnht_sh1t_imgonnagethim";
  var_c5ce0d0fbdebe983 = utility::create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_sp_gscp_gnht_grav_checkfirecheckfire";
  aliases[aliases.size] = "dx_sp_gscp_gnht_grav_watchyourroundscivil";
  aliases[aliases.size] = "dx_sp_gscp_gnht_grav_donotfireoncivilians";
  var_d90251277f4325fe = utility::create_deck(aliases, 1, 0);
  aliases = [];
  aliases[aliases.size] = "dx_sp_gscp_gnht_grav_checkfirecheckfire";
  aliases[aliases.size] = "dx_sp_gscp_gnht_grav_watchyourroundscivil";
  aliases[aliases.size] = "dx_sp_gscp_gnht_grav_donotfireoncivilians";
  var_19363906ed71037 = utility::create_deck(aliases, 1, 0);

  while(true) {
    level waittill("gunship_killcount", var_daaf09f261ee4325, nearmisses, weapon);
    alias = undefined;
    wait 0.4;

    if(var_daaf09f261ee4325["neutral"] > 0 && !flag("dont_do_civ_death_lines")) {
      if(var_daaf09f261ee4325["axis"] > 0) {
        alias = var_19363906ed71037 utility::deck_draw();
      } else {
        alias = var_d90251277f4325fe utility::deck_draw();
      }

      level dialogue::function_8c12d3c7fd8bc4ff([0.2, 0.6], alias, 0, 3);
      continue;
    }

    if(istrue(level.var_71c1d077a88bb377)) {
      continue;
    }

    if(var_daaf09f261ee4325["axis"] > 4 || var_daaf09f261ee4325["axis"] > 0 && var_daaf09f261ee4325["vehicles"] > 0) {
      alias = var_8f4a6efdca48458d utility::deck_draw();
    } else if(var_daaf09f261ee4325["axis"] > 0) {
      if(utility::percent_chance(35)) {
        continue;
      }

      alias = var_7df6e036103b0fe1 utility::deck_draw();
    }

    if(!isDefined(alias)) {
      continue;
    }

    level dialogue::function_8c12d3c7fd8bc4ff([0.2, 0.6], alias, 0, 1.5);
  }
}

function function_ba5d6178a029ed06() {
  for(;;) {
    level waittill("gunship_killcount", var_daaf09f261ee4325, nearmisses, weapon);

    if(isDefined(weapon) && weapon.basename == "gunship_hellfire_jup_sp" && var_daaf09f261ee4325["axis"] == 1 && var_daaf09f261ee4325["vehicles"] == 0) {
      level.player thread utility::giveachievement_wrapper("jup_sp_yourtaxdollarsatwork");
      break;
    }
  }
}

function private function_4d1676e7b981b219(weapon) {
  level endon("gunship_killcount");
  level endon("igc_start");
  ent = spawnStruct();
  ent.var_daaf09f261ee4325 = [];
  ent.var_daaf09f261ee4325["axis"] = 0;
  ent.var_daaf09f261ee4325["allies"] = 0;
  ent.var_daaf09f261ee4325["neutral"] = 0;
  ent.var_daaf09f261ee4325["vehicles"] = 0;
  ent childthread function_39c3479907623a04();
  self waittill("explode", position);

  if(utility::flag("igc_start")) {
    return;
  }

  waitframe();
  nearmisses = [];
  nearmisses["axis"] = 0;
  nearmisses["allies"] = 0;
  nearmisses["neutral"] = 0;

  if(isDefined(weapon)) {
    radii = [];
    radii[level.gunship.var_d6604f5e3d0ba5ea] = 800;
    radii[level.gunship.var_d6604d5e3d0ba184] = 450;
    radii[level.gunship.var_d660505e3d0ba81d] = 100;
    near_guys = getaiarrayinradius(position, radii[weapon.basename]);

    foreach(guy in near_guys) {
      if(utility::is_dead_or_dying(guy) || !isDefined(guy.team)) {
        continue;
      }

      if(isDefined(nearmisses[guy.team])) {
        nearmisses[guy.team]++;
      }
    }
  }

  level notify("gunship_killcount", ent.var_daaf09f261ee4325, nearmisses, weapon);
}

function private function_39c3479907623a04() {
  foreach(vehicle in vehicle_getarray()) {
    childthread function_ca5d24b37b933f56(vehicle);
  }

  while(true) {
    level waittill("ai_killed", guy, attacker, cause, weapon);

    if(!utility::is_equal(attacker, level.player) || !isDefined(guy.team)) {
      continue;
    }

    if(isDefined(self.var_daaf09f261ee4325[guy.team])) {
      self.var_daaf09f261ee4325[guy.team]++;
    }
  }
}

function private function_de6e56207be36d87(weapon) {
  if(!isDefined(weapon)) {
    return 0;
  }

  result = 0;

  if(!isstring(weapon)) {
    weapon = weapon.basename;
  }

  if(utility::is_equal(weapon, level.gunship.var_d6604e5e3d0ba3b7)) {
    result = 1;
  } else if(utility::is_equal(weapon, level.gunship.var_d6604d5e3d0ba184)) {
    result = 1;
  } else if(utility::is_equal(weapon, level.gunship.var_d660505e3d0ba81d)) {
    result = 1;
  } else if(utility::is_equal(weapon, level.gunship.var_d6604f5e3d0ba5ea)) {
    result = 1;
  }

  return result;
}

function private function_ca5d24b37b933f56(vehicle) {
  while(true) {
    vehicle waittill("death", attacker, null, weaponobject);

    if(!isDefined(attacker) || attacker != level.player || !isDefined(vehicle)) {
      continue;
    }

    self.var_daaf09f261ee4325["vehicles"]++;
  }
}

function function_e363bada0311c902(var_9b7c4313af2c48ab, locationstring, ender, slot) {
  var_9b7c4313af2c48ab endon("death");
  var_9b7c4313af2c48ab endon("entitydeleted");
  assert(isDefined(level.mortar_impacts));
  slot = default_to(slot, 1);
  function_b25a44a5635e5ec3(level.location_strings, var_9b7c4313af2c48ab);

  while(isalive(var_9b7c4313af2c48ab)) {
    amount = utility::ter_op(level.gameskill > 1, 2, 1);

    if(level.mortar_impacts >= amount) {
      break;
    }

    waitframe();
  }

  if(!isalive(var_9b7c4313af2c48ab)) {
    return;
  }

  function_a0c8c1ef427bbe93(16 + level.gameskill, ender, level.marker_locations[locationstring], slot);
  var_9b7c4313af2c48ab thread function_ea7fe287eb2c0ac1(slot);
}

function private function_ea7fe287eb2c0ac1(slot) {
  utility::waittill_any_2("death", "entitydeleted");
  function_e57fc58ce189fa88(slot);
}

function function_14a55d42fe182d62(tname, animname) {
  level.mortar_impacts = 0;
  var_6d94a08867efcbe7 = utility::getStruct(tname, "targetname");
  mortar_launcher = var_6d94a08867efcbe7 utility::spawn_tag_origin();
  mortar_launcher.radius = var_6d94a08867efcbe7.radius;
  mortar_launcher.script_animname = var_6d94a08867efcbe7.script_animname;
  mortar_launcher.script_noteworthy = var_6d94a08867efcbe7.script_noteworthy;
  mortar_launcher.targetname = var_6d94a08867efcbe7.targetname;
  mortar_launcher.target = var_6d94a08867efcbe7.target;
  mortar_launcher show();
  mortar_launcher setModel("misc_wm_mortar");
  mortar_launcher dontinterpolate();
  mortar_launcher notsolid();

  if(isDefined(level.scr_animtree[mortar_launcher.script_animname])) {
    mortar_launcher utility::assign_animtree(mortar_launcher.script_animname);
  }

  mortar_launcher.time = 4;
  mortar_launcher.time_dist = 4000;
  mortar_launcher.targets = utility::getStructArray(mortar_launcher.target, "targetname");
  mortar_launcher.targets = utility::array_index_by_script_index(mortar_launcher.targets);
  mortar_launcher.last_target = mortar_launcher.targets.size;
  mortar_launcher.weapon = makeweapon("mortar");
  mortar_launcher hidepart("j_mortar_shell");
  return mortar_launcher;
}

function function_b94de176af0d64ee(guys, mortar_launcher) {
  level endon("mortar_guys_run");
  level endon("mortar_guy_breakout_watcher");

  if(isDefined(level.var_40711a2674d29a0a)) {
    level.var_40711a2674d29a0a = utility::array_add(level.var_40711a2674d29a0a, guys[0]);
  }

  mortar_launcher.start = mortar_launcher gettagorigin("j_shaft_top");
  level.mortar_launcher = mortar_launcher;
  mortar_launcher endon("mortar_guy_breakout");
  level endon("mortar_guy_breakout");

  foreach(i, guy in guys) {
    guy.animname = "mortar_guy_0" + i + 1;
    guy set_allowdeath(1);
    guy endon("death");
    guy endon("mortar_guy_breakout");
    guy thread function_ce0103a065bad3ad(mortar_launcher);
  }

  crate = utility::spawn_anim_model("m1_crate_01");
  animation::anim_last_frame_solo(crate, "mortar_runintro");
  shell = utility::spawn_anim_model("m1_shell_02");
  shell dontinterpolate();
  animation::anim_first_frame_solo(shell, "mortar_fire");
  anim_sp::anim_reach(guys, "mortar_fire");
  guys = utility::array_removedead_or_dying(guys);

  if(guys.size > 2) {
    return;
  }

  self.anim_props = [crate, shell];

  if(isDefined(self.anim_props)) {
    thread function_76606a6c5955139c(guys, self.anim_props);
  }

  for(i = 0; i < level.mortar_launcher.last_target; i++) {
    thread animation::anim_loop_solo(shell, "mortar_idle", "stop_idle");
    thread animation::anim_loop_solo(guys[0], "mortar_idle", "stop_idle");
    thread animation::anim_loop_solo(guys[1], "mortar_idle", "stop_idle");

    if(!isDefined(level.mortar_launcher.targets[i])) {
      break;
    }

    wait utility::default_to(level.mortar_launcher.targets[i].script_delay, 0);
    self notify("stop_idle");
    level.mortar_launcher.end = level.mortar_launcher.targets[i].origin;
    level.mortar_launcher.end += utility::randomvector(utility::default_to(level.mortar_launcher.targets[i].script_radius, 10));
    childthread animation::anim_single_solo(guys[1], "mortar_fire");
    childthread animation::anim_single_solo(guys[0], "mortar_fire");
    childthread animation::anim_single_solo(shell, "mortar_fire");
    animation::anim_single_solo(guys[0], "mortar_fire");
  }

  while(level.mortar_impacts < level.mortar_launcher.last_target) {
    waitframe();
  }

  wait 0.5;
  player_death::clear_custom_death_quote();
  player_death::set_custom_death_quote(254);
  thread utility::missionfailedwrapper();
  level waittill("hell_freezes_over");
}

function function_ce0103a065bad3ad(mortar_launcher) {
  self waittill("death", attacker);

  if(!isDefined(level.var_4a1c8314993c5a31)) {
    level.var_4a1c8314993c5a31 = 0;
  }

  if(isDefined(attacker) && isPlayer(attacker)) {
    if(gettime() - level.var_4a1c8314993c5a31 > 7000 && !utility::flag("mortar_down_vo_played")) {
      level.var_4a1c8314993c5a31 = gettime();
      utility::flag_set("mortar_down_vo_played");
    }
  }

  level notify("mortar_guy_breakout");
  mortar_launcher notify("collapse_mortar");
}

function function_76606a6c5955139c(guys, props, ignore_props, ender) {
  if(isDefined(ender)) {
    level endon(ender);
  }

  utility::waittill_any_ents_array(guys, "death", "mortar_guy_breakout", "damage");

  foreach(prop in props) {
    if(isDefined(prop)) {
      prop stopanimScripted();
      ground_pos = trace::ray_trace(prop.origin, prop.origin + (0, 0, -12000), ignore_props)["position"];
      prop.origin = ground_pos;
    }
  }
}

function function_fd7de9398f529402(tname, var_f37e1dfdd520e065, ender, death_vo) {
  level.var_509d84ca83efb432 = 0;
  level.var_d230190a60b941dd = 0;
  level.var_2c375c602225c955 = -10000;
  utility::flag_clear("first_rocket_vo_started");
  utility::flag_clear("first_rocket_vo_played");
  guy = self.guys[0];
  guy function_55a8de121a874f3c(tname, var_f37e1dfdd520e065, ender, death_vo, self);
}

function function_55a8de121a874f3c(tname, var_f37e1dfdd520e065, ender, death_vo, tower) {
  self.var_aabd96fec70616d7 = 1;
  utility::flag_clear("tower_rpg_dead");
  thread utility::flag_on_death("tower_rpg_dead");
  self endon("death");
  self endon("entitydeleted");
  self endon("long_death");

  if(isDefined(ender)) {
    level endon(ender);
  }

  targets = getStructArray(tname, "targetname");
  targets = array_sort_by_script_index(targets);
  self.currenttarget = utility::createaiment("allies", targets[0].origin, targets[0].angles);
  set_favoriteenemy(self.currenttarget);
  enable_dontevershoot();
  self.accuracy = 10;
  self.baseaccuracy = 10;
  self.var_7811134668469758 = 1;
  self.var_e169a98f19389f0d = 1;
  utility::flag_clear("first_rocket_impact");
  utility::flag_clear("first_rocket_vo_started");
  utility::flag_clear("first_rocket_vo_played");
  utility::flag_clear("first_rocket_vo_finished");
  utility::waittill_any_timeout_3(15, "goal", "goal_reached", "bt_goal");

  if(isDefined(tower) && tower getscriptablepartstate("base", 1) == "dead") {
    return;
  }

  self allowedstances("stand");
  thread function_33fce7ce9d9d42ab(death_vo);
  i = 0;

  while(true) {
    self getenemyinfo(self.currenttarget);

    if(isDefined(targets[i])) {
      self.currenttarget.origin = targets[i].origin;
    }

    wait clamp(5 - level.gameskill, 2, 5);
    disable_dontevershoot();
    self waittill("missile_fire", projectile_object);

    if(!utility::flag("first_rocket_impact")) {
      utility::flag_set("first_rocket_impact");
    }

    projectile_object missile_settargetEnt(self.currenttarget);
    projectile_object thread function_3ceae34df99e2ef9();
    childthread function_80ffb02025084670(var_f37e1dfdd520e065);
    level.var_d230190a60b941dd++;

    if(isDefined(projectile_object) && function_3ecf0090b29b082d(targets)) {
      projectile_object function_cb9e85764e199c5b(self.currenttarget);
    } else {
      projectile_object function_9e48aa068c47e581(self.currenttarget);
    }

    i++;
    enable_dontevershoot();
  }
}

function function_33fce7ce9d9d42ab(var_77e528628b838630) {
  if(!isDefined(var_77e528628b838630)) {
    return;
  }

  self endon("entitydeleted");
  self waittill("death");
  thread function_4126410d8abe3f0f(var_77e528628b838630);
}

function function_4126410d8abe3f0f(var_77e528628b838630) {
  level.var_71c1d077a88bb377 = 1;
  wait 0.5;
  level say_global(var_77e528628b838630, 0, 0);
  level.var_71c1d077a88bb377 = 0;
}

function function_80ffb02025084670(var_f37e1dfdd520e065) {
  if(!utility::flag("hanagr1_main_vo_done")) {
    return;
  }

  if(level.var_d230190a60b941dd == 0 && !utility::flag("first_rocket_vo_played") && !utility::flag("first_rocket_vo_started")) {
    utility::flag_set("first_rocket_vo_started");

    if(isDefined(var_f37e1dfdd520e065)) {
      foreach(voline in var_f37e1dfdd520e065) {
        wait 1;
        level say_global(voline, 0, [ &function_d16ad752549c398f, self, 2]);
      }

      utility::flag_set("first_rocket_vo_finished");
    }
  } else if(flag("first_rocket_vo_finished") && level.var_d230190a60b941dd > 0 && time_has_passed(level.var_2c375c602225c955, 2)) {
    if(!istrue(level.var_46ac380a08a9c5d)) {
      level.var_2c375c602225c955 = gettime();
      line_picked = level.var_23aa7dd19bb34f63 deck_draw();
      level.player thread say_global(line_picked, 0, [ &function_d16ad752549c398f, self, 2]);
    }
  }

  utility::flag_set("first_rocket_vo_played");
}

function function_d16ad752549c398f(guy, time) {
  guy endon("death");
  wait time;
}

function function_3ecf0090b29b082d(targets) {
  failcount = targets.size;
  currentcount = level.var_d230190a60b941dd;

  if(currentcount >= failcount) {
    return true;
  }

  return false;
}

function function_cb9e85764e199c5b(target) {
  self endon("missile_timedout");
  thread notify_delay("missile_timedout", 10);
  self waittill("explode", impact_pos);
  radiusdamage(impact_pos, 400, 1000, 1000, undefined, "MOD_EXPLOSIVE", "gunship_hellfire_jup_sp", 1, 0);
  scripts\sp\player_death::clear_custom_death_quote();
  scripts\sp\player_death::set_custom_death_quote(225);
  function_277990754d304280(impact_pos);
  wait 0.3;
  scripts\sp\utility::missionfailedwrapper();
}

function function_9e48aa068c47e581(target) {
  self endon("missile_timedout");
  thread notify_delay("missile_timedout", 6);
  self waittill("explode", impact_pos);
  radiusdamage(impact_pos, 150, 1000, 1000, undefined, "MOD_EXPLOSIVE", "gunship_40mm_jup_sp", 1, 1);
}

function function_3ceae34df99e2ef9() {
  level.player playSound("weap_rpg_fire_radio");
  var_1060354d0d90695 = "null";
  var_7965f3906b55049a = 0;
  var_256b40591aa1085c = 0;
  heros = sortbydistance(level.heros, self.origin);

  if(isDefined(heros[0])) {
    var_256b40591aa1085c = distancesquared(self.origin, heros[0].origin);
    var_7965f3906b55049a = 3000000;
    var_1060354d0d90695 = "weap_rpg_incoming_radio";
  }

  projectile_sfx = spawn("script_origin", self.origin);
  projectile_sfx dontinterpolate();
  projectile_sfx linkTo(self);

  if(var_7965f3906b55049a > 0) {
    thread function_1e0569c7db8a209(var_7965f3906b55049a, var_1060354d0d90695, projectile_sfx, heros[0]);
  }

  utility::waittill_any_2("explode", "death");
  var_7c2c2a9ae1434824 = 900;
  close_dist = 5000;
  far_dist = 10000;

  if(isDefined(projectile_sfx) && isDefined(heros[0])) {
    var_256b40591aa1085c = distance2d(projectile_sfx.origin, heros[0].origin);
    explosion_sound = "weap_rpg_exp_radio_distant";

    if(var_256b40591aa1085c < var_7c2c2a9ae1434824) {
      explosion_sound = "weap_rpg_exp_radio_close";
    } else if(var_256b40591aa1085c < close_dist) {
      explosion_sound = "weap_rpg_exp_radio_med";
    }

    if(soundexists(explosion_sound)) {
      level.player playSound(explosion_sound);
    }
  }

  wait 0.05;

  if(isDefined(projectile_sfx)) {
    projectile_sfx stopsounds();
  }

  wait 0.1;

  if(isDefined(projectile_sfx)) {
    projectile_sfx delete();
  }
}

function function_1e0569c7db8a209(var_7965f3906b55049a, var_1060354d0d90695, projectile_sfx, actor) {
  self endon("explode");
  self endon("death");
  actor endon("death");
  var_256b40591aa1085c = distancesquared(self.origin, actor.origin);

  while(isDefined(self) && var_256b40591aa1085c > var_7965f3906b55049a) {
    var_256b40591aa1085c = distancesquared(self.origin, actor.origin);
    wait 0.1;
  }

  projectile_sfx playSound(var_1060354d0d90695);
}

function function_371eab79c78ad557(guy, height) {
  if(!isDefined(self)) {
    return;
  }

  start = utility::default_to(self.start, self gettagorigin("j_shaft_top"));
  end = self.end;
  utility::flag_set("enemy_mortar_launched");
  thread utility::flag_clear_delayed("enemy_mortar_launched", 3);
  var_fb9b59a47d4eaf88 = self.var_fb9b59a47d4eaf88;
  time = self.time;
  trace = trace::ray_trace(end + (0, 0, 600), end);
  end = trace["position"];
  mortar = utility::spawn_tag_origin(start, (0, 0, 0));
  playFXOnTag(utility::getfx("vfx_mortar_trail_01"), mortar, "tag_origin");
  mortar.var_5b0c55b0e562a42e = 1;
  mortar thread function_24eab8f6c330319b();

  if(getdvarint(@ "hash_7a0d2f4714304d2b")) {
    dist = distance(start, end);
    time = dist / var_fb9b59a47d4eaf88 * time;
  }

  level notify("mortar_launch", start);
  movemortar(mortar, start, end, time, height);
  level notify("mortar_impact", end, mortar);
  radiusdamage(end, default_to(self.weaponrange, 300), default_to(self.weapondamage, 300), default_to(self.weapondamage, 300), undefined, undefined, default_to(self.weaponname, "gunship_40mm_jup_sp"), 0, 0);
  level.mortar_impacts++;

  if(level.mortar_impacts == 2) {
    delaythread(0.4, &function_277990754d304280, end);
  }

  earthquake(0.4, 1.5, end, 2000);
  playFX(utility::getfx("vfx_mortar_exp_01"), end);
  mortar delete();
}

function function_24eab8f6c330319b() {
  level.player playSound("weap_mortar_fire_radio");
  var_1060354d0d90695 = "null";
  var_7965f3906b55049a = 0;
  var_256b40591aa1085c = 0;
  heros = sortbydistance(level.heros, self.origin);

  if(isDefined(heros[0])) {
    var_256b40591aa1085c = distancesquared(self.origin, heros[0].origin);
    var_7965f3906b55049a = 30000000;
    var_1060354d0d90695 = "weap_mortar_incoming_radio";
  }

  projectile_sfx = spawn("script_origin", self.origin);
  projectile_sfx linkTo(self);

  if(var_7965f3906b55049a > 0 && isDefined(heros[0])) {
    thread function_ff5403c459e6dd0d(var_7965f3906b55049a, var_1060354d0d90695, projectile_sfx, heros[0]);
  }

  utility::waittill_any_2("explode", "death");
  var_7c2c2a9ae1434824 = 900;
  close_dist = 5000;
  far_dist = 10000;

  if(isDefined(projectile_sfx) && isDefined(heros[0])) {
    var_256b40591aa1085c = distance(projectile_sfx.origin, heros[0].origin);
    explosion_sound = "weap_mortar_exp_radio_distant";

    if(var_256b40591aa1085c < var_7c2c2a9ae1434824) {
      explosion_sound = "weap_mortar_exp_radio_close";
    } else if(var_256b40591aa1085c < close_dist) {
      explosion_sound = "weap_mortar_exp_radio_med";
    }

    if(soundexists(explosion_sound)) {
      level.player playSound(explosion_sound);
    }
  }

  wait 0.05;

  if(isDefined(projectile_sfx)) {
    projectile_sfx stopsounds();
  }

  wait 0.1;

  if(isDefined(projectile_sfx)) {
    projectile_sfx delete();
  }
}

function function_ff5403c459e6dd0d(var_7965f3906b55049a, var_1060354d0d90695, projectile_sfx, actor) {
  if(!isDefined(level.price)) {
    return;
  }

  actor endon("death");
  self endon("explode");
  self endon("death");
  var_256b40591aa1085c = distancesquared(self.origin, actor.origin);

  while(isDefined(self) && var_256b40591aa1085c > var_7965f3906b55049a) {
    if(isDefined(actor)) {
      var_256b40591aa1085c = distancesquared(self.origin, actor.origin);
    }

    wait 0.1;
  }

  projectile_sfx playSound(var_1060354d0d90695);
}

function movemortar(model, start, end, time, height) {
  setdvarifuninitialized(@ "hash_7a0d2f4714304d2b", "0");

  if(getdvarint(@ "hash_7a0d2f4714304d2b")) {
    model.origin = start;
    gravity = getdvarint(@ "bg_gravity");
    dist = distance(start, end);
    delta = end - start;
    drop = 0.5 * gravity * squared(time) * -1;
    vel = (delta[0] / time, delta[1] / time, (delta[2] - drop) / time);
    model movegravity(vel, time);
    endtime = gettime() + time * 1000;

    while(gettime() < endtime) {
      model anglemortar();
      waitframe();
    }

    return;
  }

  apex = 1200;

  if(isDefined(height)) {
    apex = height;
  }

  framefrac = 1 / time / 0.05;
  frac = 0;

  while(frac < 1) {
    model.origin = math::get_point_on_parabola(start, end, apex, frac);
    model anglemortar();
    frac += framefrac;
    wait 0.05;
  }

  model.origin = end;
}

function anglemortar() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}