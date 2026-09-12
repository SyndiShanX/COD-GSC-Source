/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_kidnapper.gsc
***********************************************/

function init_kidnapper_combat_loop() {}

function kidnapper_monitor() {
  wait 30;

  for(;;) {
    if(!istrue(level.cp_kidnappers_active) || getdvarint("scr_disable_kidnapper", 0) > 0) {
      wait 1;
      continue;
    }

    var_0 = getvulnerableplayersinteam("allies");

    if(isDefined(var_0) && var_0.size > 0) {
      var_1 = var_0[randomint(var_0.size)];
      thread spawn_kidnapper_for_player(level);
    }

    level scripts\engine\utility::waittill_notify_or_timeout("cp_kidnappers_reset", 40);
    wait randomfloatrange(20, 40);
    wait 1;
  }
}

function registerkidnapperspawnmod() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var_0]]("cp_kidnapper", 1, 1, 1, 0.5, undefined, &getspawnerstructbehindcurplayer, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("cp_kidnapper", &kidnapper_after_spawn_func);
}

function getspawnerstructbehindcurplayer(var_0) {
  if(isDefined(level.curplayertohavekidnapperspawned)) {
    var_1 = level.curplayertohavekidnapperspawned;
  } else {
    return undefined;
  }

  var_2 = createspawnerstructbehindplayer(var_1);
  var_2.script_forcespawn = 1;
  return var_2;
}

function kidnapper_after_spawn_func(var_0) {
  waitframe();
  level notify("cp_kidnapper_spawned", self);
}

function spawn_kidnapper_for_player(var_0) {
  level endon("game_ended");
  level.curplayertohavekidnapperspawned = var_0;
  scripts\cp\cp_modular_spawning::run_spawn_module("cp_kidnapper");
  level waittill("cp_kidnapper_spawned", var_1);
  var_2 = var_1;

  if(!isDefined(var_2)) {
    return;
  }

  var_0 playsoundtoplayer("melee_takedown_knife_stab_release_short", var_0);
  var_2.drawoncompass = 1;
  var_0.being_hunted_by_kidnapper = 1;
  var_2.maxfaceenemydist = 768;
  var_2.dontevershoot = 1;
  var_2.ignoreall = 1;
  var_2.maxhealth = 250;
  var_2.health = var_2.maxhealth;
  var_2.wearing_armor = 1;
  var_2 scripts\engine\utility::set_movement_speed(200);
  var_2 getenemyinfo(var_0);
  var_2 scripts\cp\cp_modular_spawning::set_character_models("body_al_qatala_1_ar", "head_al_qatala_ar");
  var_2.a.disablelongdeath = 1;
  var_2.tripledefenderkill = 1;
  thread get_to_target_player(var_2, var_2);
  thread watch_for_kidnapper_death(var_2, var_2);
  thread ref_14464(var_2, var_2);
  thread player_see_me_monitor(var_2, var_2);
  thread kidnapper_toggle_monitor(var_2, var_2);
  level notify("cp_kidnapper_spawned_for_player");
}

function get_to_target_player(var_0, var_1) {
  var_0 endon("death");
  var_0.goalradius = 40;

  while(1 && isDefined(var_1) && isalive(var_1)) {
    var_0.disablearrivals = 1;
    var_0 setgoalpos(var_1.origin);

    if(distancesquared(var_0.origin, var_1.origin) <= 2500) {
      break;
    }

    waitframe();
  }

  if(ishuntedplayerabletobekidnapped(var_1) || getdvarint("scr_test_kidnapper_anim", 0) > 0) {
    thread manageminigunpickup(var_0, var_0);
    return;
  }

  turnkidnappertonormalai(var_0);

  if(isDefined(var_1)) {
    var_1.being_hunted_by_kidnapper = 0;
    return;
  }
}

function manageminigunpickup(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("kidnapper_turned_to_normal_ai");
  var_1 disableusability();
  var_1 allowcrouch(0);
  var_1.lasttimekidnapped = gettime();
  var_0 scripts\engine\utility::set_movement_speed(0);
  var_0.health = 99999;
  thread ref_12B51(var_0, var_0, var_1);
  thread release_player_on_death(var_0, var_0);
  var_0.restoreweapon = var_0.ref_1237E;
  var_0 takeweapon(var_0.weapon);
  thread ref_13650(var_0);

  if(getdvarint("scr_test_kill_kidnapper", 0) >= 1) {
    thread issameteamagent(var_0);
  }

  screen_fade_to_black(var_1);
  var_1 cameraset("camera_custom_orbit_2_cp");
  thread lootleaderoneperteam(var_0, var_0);
  var_0 notify("subduing_player");
  var_1 notify("being_subdued");
  wait 1;
  screen_fade_back_to_normal(var_1);
  createobjectiveicon(var_1);

  if(!isDefined(var_1.times_kidnapped)) {
    var_1.times_kidnapped = 1;
  } else {
    var_1.times_kidnapped++;
  }

  scripts\cp\cp_analytics::ref_119B4(var_1, 1.8);
  var_0 waittill("kidnap_sequence_complete");

  if(isDefined(var_1.restoreweapon)) {
    var_1 switchtoweapon(var_1.restoreweapon);
  }

  killkidnappedplayer(var_1, var_0);

  if(isDefined(var_0.ref_12F89)) {
    var_0.ref_12F89 delete();
  }

  var_1 notify("remove_rig");
  var_1 enableusability();
  var_1 allowcrouch(1);
  var_1 cameradefault();

  if(isDefined(var_0.restoreweapon)) {
    var_0 giveweapon(var_0.restoreweapon);
  }

  level notify("cp_kidnappers_reset");
  thread turnkidnappertonormalai(var_0);
}

function turnkidnappertonormalai(var_0) {
  var_0.dontevershoot = 0;
  var_0.ignoreall = 0;
  var_0 scripts\engine\utility::set_movement_speed(300);
  var_0.scripted_mode = 0;
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var_0.health = 100;
  var_0.tripledefenderkill = 0;
  var_0 notify("kidnapper_turned_to_normal_ai");
}

function ref_12D9C(var_0, var_1) {
  var_2 = var_1.player_rig;
  var_2 rotateTo(var_0.angles, 0.2);
  wait 0.2;
  var_1 dontinterpolate();
  var_1 setplayerangles(var_0.angles);
}

function ref_12B51(var_0, var_1, var_2) {
  var_0 endon("kidnap_kill_started");
  var_0 endon("death");
  var_3 = 0;

  while(var_3 < var_2) {
    var_0 waittill("damage", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18);
    var_3 += var_4;
  }

  lootspawnitemlist(var_0, var_1, var_0);
}

function release_player_on_death(var_0, var_1) {
  var_0 endon("kidnap_kill_started");
  var_0 waittill("death");
  break_player_out_of_anim(var_1);
}

function killkidnappedplayer(var_0, var_1) {
  var_1 notify("kidnap_kill_started");
  deleteobjectiveicon(var_0);
  var_0.shouldskiplaststand = 1;
  var_0.shouldskipdeathsshield = 1;
  var_0.islockedinkidnapanim = 0;
  var_0.being_hunted_by_kidnapper = 0;
  screen_fade_to_black(var_0);
  wait 1;
  var_0 dodamage(var_0.maxhealth + 1000, var_0.origin);
  screen_fade_back_to_normal(var_0);
}

function screen_fade_to_black(var_0) {
  if(!isDefined(var_0.kidnap_black_screen)) {
    var_0.kidnap_black_screen = newclienthudelem(var_0);
    var_0.kidnap_black_screen.x = 0;
    var_0.kidnap_black_screen.y = 0;
    var_0.kidnap_black_screen setshader("black", 640, 480);
    var_0.kidnap_black_screen.alignx = "left";
    var_0.kidnap_black_screen.aligny = "top";
    var_0.kidnap_black_screen.sort = 1;
    var_0.kidnap_black_screen.horzalign = "fullscreen";
    var_0.kidnap_black_screen.vertalign = "fullscreen";
    var_0.kidnap_black_screen.foreground = 1;
  }

  var_0.kidnap_black_screen.alpha = 0;
  var_0.kidnap_black_screen fadeovertime(1);
  var_0.kidnap_black_screen.alpha = 1;
}

function screen_fade_back_to_normal(var_0) {
  if(isDefined(var_0.kidnap_black_screen)) {
    var_0.kidnap_black_screen fadeovertime(1);
    var_0.kidnap_black_screen.alpha = 0;
    var_0.kidnap_black_screen destroy();
    var_0.kidnap_black_screen = undefined;
    return;
  }
}

function player_see_me_monitor(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("subduing_player");
  var_1 endon("death");

  while(1 && isalive(var_1)) {
    if(var_1 worldpointinreticle_circle(var_0 getEye(), 65, 300) && sighttracepassed(var_0 getEye(), var_1 getEye(), 0, var_0)) {
      break;
    }

    waitframe();
  }

  var_0 scripts\engine\utility::set_movement_speed(300);
  var_1.lasttimesawkidnapper = gettime();
  var_0 notify("target_player_saw_me");
}

function kidnapper_toggle_monitor(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("subduing_player");
  level waittill("cp_kidnappers_off");
  var_1.being_hunted_by_kidnapper = 0;
  thread break_player_out_of_anim(var_1);
  turnkidnappertonormalai(var_0);
}

function watch_for_kidnapper_death(var_0, var_1) {
  level endon("game_ended");
  var_0 waittill("death");
  level notify("cp_kidnappers_reset");

  if(isDefined(var_1) && var_1 scripts\cp\utility::is_valid_player()) {
    var_1.being_hunted_by_kidnapper = 0;
    deleteobjectiveicon(var_1);
    return;
  }
}

function ref_14464(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");
  var_1 scripts\engine\utility::ref_143A5("death", "disconnect");
  turnkidnappertonormalai(var_0);
}

function sort_players_based_on_previous_kidnap_attempt_time() {
  var_0 = gettime();

  foreach(var_2 in level.players) {
    if(!isDefined(var_2.previous_kidnap_attempt_time)) {
      var_2.previous_kidnap_attempt_time = 0;
    }
  }

  var_4 = level.players;
  var_5 = var_4.size;

  if(var_5 > 1) {
    for(;;) {
      var_6 = 0;

      for(var_7 = 1; var_7 <= var_5 - 1; var_7++) {
        var_8 = var_4[var_7 - 1];
        var_9 = var_4[var_7];

        if(var_9.previous_kidnap_attempt_time < var_8.previous_kidnap_attempt_time) {
          var_4 = var_9;
          var_4 = var_8;
          var_6 = 1;
        }
      }

      if(var_6 == 0) {
        break;
      }
    }
  }

  return var_4;
}

function createspawnerstructbehindplayer(var_0) {
  var_1 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(var_0, (-1000, 0, 0)));
  var_2 = spawnStruct();
  var_2.origin = var_1;
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  return var_2;
}

function getrandomplayersinteam(var_0) {
  var_1 = scripts\cp\utility::getplayersinteam(var_0);

  if(var_1.size <= 1) {
    if(getdvarint("scr_kidnap_on_solo", 0) <= 0) {
      return undefined;
    } else {
      var_2 = var_1[0];

      if(isDefined(var_2.lasttimekidnapped) && gettime() - var_2.lasttimekidnapped <= 60000 || istrue(var_2.being_hunted_by_kidnapper)) {
        return undefined;
      } else {
        return var_1;
      }
    }
  }

  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_2 = var_1[var_4];

    if(!isalive(var_2) || var_2.inlaststand || istrue(var_2.being_hunted_by_kidnapper)) {
      continue;
    }

    if(isDefined(var_2.lasttimekidnapped) && gettime() - var_2.lasttimekidnapped <= 60000) {
      continue;
    }

    if(randomint(2) > 0) {
      var_3 = var_2;
    }
  }

  return var_3;
}

function getvulnerableplayersinteam(var_0) {
  level endon("game_ended");
  var_1 = scripts\cp\utility::getplayersinteam(var_0);

  if(var_1.size <= 1) {
    if(getdvarint("scr_kidnap_on_solo", 0) <= 0) {
      return undefined;
    } else {
      var_2 = var_1[0];

      if(isplayerabletobekidnapped(var_2)) {
        return var_1;
      }
    }
  }

  var_3 = [];
  var_4 = [];

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_2 = var_1[var_5];

    if(isplayerabletobekidnapped(var_2)) {
      var_3 = sortbydistance(var_1, var_2.origin);
      var_3 = scripts\engine\utility::array_remove(var_3, var_2);

      if(distance(var_2.origin, var_3[0].origin) > 6000) {
        var_4 = var_2;
      }
    }
  }

  return var_4;
}

function setimmunetokidnapper(var_0) {
  if(!isPlayer(self)) {
    scripts\engine\utility::error("ToggleImmuneToKidnapper called on a non player ent");
    return;
  }

  self.immunetokidnapper = var_0;
}

function ishuntedplayerabletobekidnapped(var_0) {
  if(!isDefined(var_0) || !isalive(var_0) || isDefined(var_0.lasttimekidnapped) && gettime() - var_0.lasttimekidnapped <= 60000 || istrue(var_0.inlaststand) || istrue(var_0.fauxdead) || istrue(var_0.binvehicle) || istrue(var_0.immunetokidnapper) || istrue(updateparachutestreamhint(var_0))) {
    return 0;
  }

  return 1;
}

function isplayerabletobekidnapped(var_0) {
  if(!isDefined(var_0) || !isalive(var_0) || isDefined(var_0.lasttimekidnapped) && gettime() - var_0.lasttimekidnapped <= 60000 || istrue(var_0.being_hunted_by_kidnapper) || istrue(var_0.inlaststand) || istrue(var_0.fauxdead) || istrue(var_0.binvehicle) || istrue(var_0.immunetokidnapper) || istrue(var_0.usinggunship) || istrue(updateparachutestreamhint(var_0))) {
    return 0;
  }

  return 1;
}

function updateparachutestreamhint(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.currentweapon)) {
    return false;
  }

  var_1 = var_0.currentweapon;
  return var_1.basename == "ks_remote_device_mp";
}

function togglekidnappers(var_0) {
  if(var_0) {
    level notify("cp_kidnappers_on");
  } else {
    level notify("cp_kidnappers_off");
  }

  level.cp_kidnappers_active = var_0;
}

function ref_13A37(var_0) {
  var_0.restoreweapon = var_0 getcurrentweapon();
  var_1 = getcompleteweaponname("iw8_gunless");
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);
  var_2 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1, 0);
  var_0.gunlessweapon = var_1;
  var_0 scripts\common\utility::allow_weapon_switch(0);
}

function ref_13650(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("attachment_wm_pi_golf21_receiver");
  var_1 linkTo(var_0, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("attachment_wm_pi_golf21_slide");
  var_2 linkTo(var_1);
  var_0.pistol = var_1;
  var_0.ref_1237D = var_2;
  var_0 scripts\engine\utility::ref_143A5("death", "kidnap_kill_started");
  var_1 delete();
  var_2 delete();
}

#using_animtree("");

function lootleaderoneperteam(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("kidnap_kill_started");
  var_1 setstance("stand");
  var_1.islockedinkidnapanim = 1;
  var_0.scripted_mode = 1;
  var_0.ignoreall = 1;
  thread create_player_rig(var_1, var_1);
  var_1 scripts\common\anim::anim_first_frame_solo(var_1.player_rig, "kidnapper_grab");
  var_1.player_rig hide();
  link_player_to_rig(var_1, 0.2);
  ref_12D9C(var_0, var_1);
  var_2 = var_0 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "cp_kidnapper_melee_attack");
  var_3 = var_0 scripts\asm\asm::asm_getxanim("animscripted", var_2);
  var_4 = getanimlength(%cp_hostagetaker_grab_attacker);
  var_5 = spawn("script_origin", var_1.origin);
  var_5.origin = var_1.origin;
  var_5.angles = var_1.angles;
  var_0.ref_12F89 = var_5;
  var_6 = getstartorigin(var_5.origin, var_5.angles, var_3);
  var_7 = getstartangles(var_5.origin, var_5.angles, var_3);
  var_1 dontinterpolate();
  var_1 setplayerangles(var_7);
  var_1 setOrigin(var_6);
  var_5 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "kidnapper_grab");
  var_0 scripts\asm\shared\mp\utility::burningpartlogic("cp_kidnapper_melee_attack", var_5, undefined, 1);
  wait var_4 / 2;
  thread ref_13A37(var_1);
  wait var_4 / 2;
  var_2 = var_0 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "cp_kidnapper_subduing");
  var_3 = var_0 scripts\asm\asm::asm_getxanim("animscripted", var_2);
  var_4 = getanimlength($cp_hostagetaker_idle_victim);
  var_6 = getstartorigin(var_5.origin, var_5.angles, var_3);
  var_7 = getstartangles(var_5.origin, var_5.angles, var_3);
  var_0 forceteleport(var_6, var_7);
  var_1 setplayerangles(var_7);
  var_1 setOrigin(var_6);
  var_5 scripts\common\anim::anim_first_frame_solo(var_1.player_rig, "kidnapper_subduing");
  var_8 = gettime() + 15000;

  while(gettime() < var_8) {
    var_1 dontinterpolate();
    var_1 setplayerangles(var_7);
    var_1 setOrigin(var_6);
    var_5 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "kidnapper_subduing");
    var_0 scripts\asm\shared\mp\utility::burningpartlogic("cp_kidnapper_subduing", var_5, undefined, 1);
    wait var_4;
  }

  var_2 = var_0 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "cp_kidnapper_execute");
  var_3 = var_0 scripts\asm\asm::asm_getxanim("animscripted", var_2);
  var_4 = getanimlength(%cp_hostagetaker_rescue_attacker);
  var_6 = getstartorigin(var_5.origin, var_5.angles, var_3);
  var_7 = getstartangles(var_5.origin, var_5.angles, var_3);
  var_1 dontinterpolate();
  var_1 setplayerangles(var_7);
  var_1 setOrigin(var_6);
  var_5 thread scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "kidnapper_execution");
  var_0 scripts\asm\shared\mp\utility::burningpartlogic("cp_kidnapper_execute", var_5, undefined, 1);
  wait var_4;
  var_5 delete();

  if(isDefined(var_1.set_tank_target_player)) {
    var_1 scripts\cp\cp_weapons::_takeweapon(var_1.set_tank_target_player);
  }

  var_0 notify("kidnap_sequence_complete");
}

function lootspawnitemlist(var_0, var_1) {
  level endon("game_ended");
  var_1.scripted_mode = 1;
  var_1.ignoreall = 1;
  var_2 = var_1 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "cp_kidnapper_death");
  var_3 = var_1 scripts\asm\asm::asm_getxanim("animscripted", var_2);
  var_4 = getanimlength(%cp_hostagetaker_death_attacker);
  var_5 = var_1.ref_12F89;
  var_5.origin = var_0.origin;
  var_5.angles = var_0.angles;
  var_1.ref_12F89 = var_5;
  var_6 = getstartorigin(var_5.origin, var_5.angles, var_3);
  var_7 = getstartangles(var_5.origin, var_5.angles, var_3);
  var_0 dontinterpolate();
  var_0 setplayerangles(var_7);
  var_0 setOrigin(var_6);
  var_5 thread scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "kidnapper_death");
  var_1 scripts\asm\shared\mp\utility::burningpartlogic("cp_kidnapper_death", var_5, undefined, 1);
  wait var_4;
  var_1 suicide();
  var_5 delete();
  break_player_out_of_anim();
}

function break_player_out_of_anim(var_0) {
  if(istrue(var_0.islockedinkidnapanim)) {
    var_0 freezecontrols(0);
    var_0 enableusability();
    var_0 allowcrouch(1);
    var_0 cameradefault();
    var_0 notify("remove_rig");
    var_0 stopanimscriptsceneevent();
    var_0.islockedinkidnapanim = 0;

    if(isDefined(var_0.set_tank_target_player)) {
      var_0 scripts\cp\cp_weapons::_takeweapon(var_0.set_tank_target_player);
    }

    if(isDefined(var_0.restoreweapon)) {
      var_0 switchtoweapon(var_0.restoreweapon);
    }
  }

  screen_fade_back_to_normal(var_0);
}

function create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }

  var_0.animname = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  var_0 predictstreampos(var_0.origin);
  var_3 = spawn("script_arms", var_0.origin, 0, 0, var_0);
  var_3.player = var_0;
  var_0.player_rig = var_3;
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0.player_rig.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  watch_remove_rig(var_0);
  remove_player_rig(var_0);
}

function watch_remove_rig(var_0) {
  scripts\engine\utility::ref_143A6("remove_rig", "death", "disconnect");
}

function remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }

  var_0 unlink();
  var_1 = var_0 getdroptofloorposition(var_0.origin);

  if(isDefined(var_1)) {
    var_0 setOrigin(var_1);
  } else {
    var_0 setOrigin(var_0.origin + (0, 0, 100));
  }

  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

function link_player_to_rig(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");

  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.2;
  }

  var_0 playerlinktoblend(var_0.player_rig, "tag_player", var_1, 0.25, 0.25);
  wait var_1;
  var_0 playerlinktodelta(var_0.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1);
}

function createobjectiveicon(var_0) {
  var_0.kidnap_wid = scripts\cp\cp_objectives::requestworldid(var_0.name + "_kidnapper");
  objective_setplayintro(var_0.kidnap_wid, 0);
  objective_setplayoutro(var_0.kidnap_wid, 0);
  objective_state(var_0.kidnap_wid, "current");
  objective_icon(var_0.kidnap_wid, "icon_waypoint_objective_general");
  objective_setbackground(var_0.kidnap_wid, 1);
  objective_onentity(var_0.kidnap_wid, var_0);
  objective_setlabel(var_0.kidnap_wid, &"CP_OBJECTIVES/KIDNAPPED");
}

function deleteobjectiveicon(var_0) {
  if(!isDefined(var_0.kidnap_wid)) {
    return;
  }

  objective_delete(var_0.kidnap_wid);
  scripts\cp\cp_objectives::freeworldid(var_0.name + "_kidnapper");
  var_0.kidnap_wid = undefined;
}

function enteredvehicle(var_0, var_1) {
  setimmunetokidnapper(var_1, 1);
}

function exitedvehicle(var_0, var_1) {
  setimmunetokidnapper(var_1, 0);
}

function init_relic_martyrdom() {
  var_0 = "devgui_cmd \"CP Debug:2 / Kidnapper / SpawnKidnapper\" \"set start_kidnapper_debug spawn - kidnapper\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
}

function vehomn_showcontrols(var_0) {
  var_1 = strtok(var_0, "_");
  var_2 = level.players[0];

  switch (var_1[0]) {
    case "spawn":
    default:
      spawn_kidnapper_for_player(var_2);
      break;
  }

  waitframe();
  setDvar("start_kidnapper_debug", "");
}

function issameteamagent(var_0) {
  wait 7;
  var_0 dodamage(200, var_0.origin, var_0, var_0, "MOD_SUICIDE");
}

function init_anims() {
  level.scr_animtree["player_victim"] = #animtree;
  level.scr_anim["player_victim"]["kidnapper_subduing"] = % cp_hostagetaker_idle_victim;
  level.scr_animname["player_victim"]["kidnapper_subduing"] = "cp_hostagetaker_idle_victim";
  level.scr_eventanim["player_victim"]["kidnapper_subduing"] = "kidnapper_subduing";
  level.scr_anim["player_victim"]["kidnapper_grab"] = % cp_hostagetaker_grab_victim;
  level.scr_animname["player_victim"]["kidnapper_grab"] = "cp_hostagetaker_grab_victim";
  level.scr_eventanim["player_victim"]["kidnapper_grab"] = "cp_kidnapper_grab";
  level.scr_anim["player_victim"]["kidnapper_execution"] = % cp_hostagetaker_rescue_victim;
  level.scr_animname["player_victim"]["kidnapper_execution"] = "cp_hostagetaker_rescue_victim";
  level.scr_eventanim["player_victim"]["kidnapper_execution"] = "cp_kidnapper_executing";
  level.scr_anim["player_victim"]["kidnapper_death"] = % cp_hostagetaker_death_victim;
  level.scr_animname["player_victim"]["kidnapper_death"] = "cp_hostagetaker_death_victim";
  level.scr_eventanim["player_victim"]["kidnapper_death"] = "cp_kidnapper_death";
}