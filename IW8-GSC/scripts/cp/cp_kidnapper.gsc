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

    var0 = getvulnerableplayersinteam("allies");

    if(isDefined(var0) && var0.size > 0) {
      var1 = var0[randomint(var0.size)];
      thread spawn_kidnapper_for_player(level);
    }

    level scripts\engine\utility::waittill_notify_or_timeout("cp_kidnappers_reset", 40);
    wait randomfloatrange(20, 40);
    wait 1;
  }
}

function registerkidnapperspawnmod() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  var0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var0]]("cp_kidnapper", 1, 1, 1, 0.5, undefined, &getspawnerstructbehindcurplayer, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("cp_kidnapper", &kidnapper_after_spawn_func);
}

function getspawnerstructbehindcurplayer(var0) {
  if(isDefined(level.curplayertohavekidnapperspawned)) {
    var1 = level.curplayertohavekidnapperspawned;
  } else {
    return undefined;
  }

  var2 = createspawnerstructbehindplayer(var1);
  var2.script_forcespawn = 1;
  return var2;
}

function kidnapper_after_spawn_func(var0) {
  waitframe();
  level notify("cp_kidnapper_spawned", self);
}

function spawn_kidnapper_for_player(var0) {
  level endon("game_ended");
  level.curplayertohavekidnapperspawned = var0;
  scripts\cp\cp_modular_spawning::run_spawn_module("cp_kidnapper");
  level waittill("cp_kidnapper_spawned", var1);
  var2 = var1;

  if(!isDefined(var2)) {
    return;
  }

  var0 playsoundtoplayer("melee_takedown_knife_stab_release_short", var0);
  var2.drawoncompass = 1;
  var0.being_hunted_by_kidnapper = 1;
  var2.maxfaceenemydist = 768;
  var2.dontevershoot = 1;
  var2.ignoreall = 1;
  var2.maxhealth = 250;
  var2.health = var2.maxhealth;
  var2.wearing_armor = 1;
  var2 scripts\engine\utility::set_movement_speed(200);
  var2 getenemyinfo(var0);
  var2 scripts\cp\cp_modular_spawning::set_character_models("body_al_qatala_1_ar", "head_al_qatala_ar");
  var2.a.disablelongdeath = 1;
  var2.tripledefenderkill = 1;
  thread get_to_target_player(var2, var2);
  thread watch_for_kidnapper_death(var2, var2);
  thread ref_14464(var2, var2);
  thread player_see_me_monitor(var2, var2);
  thread kidnapper_toggle_monitor(var2, var2);
  level notify("cp_kidnapper_spawned_for_player");
}

function get_to_target_player(var0, var1) {
  var0 endon("death");
  var0.goalradius = 40;

  while(1 && isDefined(var1) && isalive(var1)) {
    var0.disablearrivals = 1;
    var0 setgoalpos(var1.origin);

    if(distancesquared(var0.origin, var1.origin) <= 2500) {
      break;
    }

    waitframe();
  }

  if(ishuntedplayerabletobekidnapped(var1) || getdvarint("scr_test_kidnapper_anim", 0) > 0) {
    thread manageminigunpickup(var0, var0);
    return;
  }

  turnkidnappertonormalai(var0);

  if(isDefined(var1)) {
    var1.being_hunted_by_kidnapper = 0;
    return;
  }
}

function manageminigunpickup(var0, var1) {
  var0 endon("death");
  var0 endon("kidnapper_turned_to_normal_ai");
  var1 disableusability();
  var1 allowcrouch(0);
  var1.lasttimekidnapped = gettime();
  var0 scripts\engine\utility::set_movement_speed(0);
  var0.health = 99999;
  thread ref_12b51(var0, var0, var1);
  thread release_player_on_death(var0, var0);
  var0.restoreweapon = var0.ref_1237e;
  var0 takeweapon(var0.weapon);
  thread ref_13650(var0);

  if(getdvarint("scr_test_kill_kidnapper", 0) >= 1) {
    thread issameteamagent(var0);
  }

  screen_fade_to_black(var1);
  var1 cameraset("camera_custom_orbit_2_cp");
  thread lootleaderoneperteam(var0, var0);
  var0 notify("subduing_player");
  var1 notify("being_subdued");
  wait 1;
  screen_fade_back_to_normal(var1);
  createobjectiveicon(var1);

  if(!isDefined(var1.times_kidnapped)) {
    var1.times_kidnapped = 1;
  } else {
    var1.times_kidnapped++;
  }

  scripts\cp\cp_analytics::ref_119b4(var1, 1.8);
  var0 waittill("kidnap_sequence_complete");

  if(isDefined(var1.restoreweapon)) {
    var1 switchtoweapon(var1.restoreweapon);
  }

  killkidnappedplayer(var1, var0);

  if(isDefined(var0.ref_12f89)) {
    var0.ref_12f89 delete();
  }

  var1 notify("remove_rig");
  var1 enableusability();
  var1 allowcrouch(1);
  var1 cameradefault();

  if(isDefined(var0.restoreweapon)) {
    var0 giveweapon(var0.restoreweapon);
  }

  level notify("cp_kidnappers_reset");
  thread turnkidnappertonormalai(var0);
}

function turnkidnappertonormalai(var0) {
  var0.dontevershoot = 0;
  var0.ignoreall = 0;
  var0 scripts\engine\utility::set_movement_speed(300);
  var0.scripted_mode = 0;
  var0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var0.health = 100;
  var0.tripledefenderkill = 0;
  var0 notify("kidnapper_turned_to_normal_ai");
}

function ref_12d9c(var0, var1) {
  var2 = var1.player_rig;
  var2 rotateTo(var0.angles, 0.2);
  wait 0.2;
  var1 dontinterpolate();
  var1 setplayerangles(var0.angles);
}

function ref_12b51(var0, var1, var2) {
  var0 endon("kidnap_kill_started");
  var0 endon("death");
  var3 = 0;

  while(var3 < var2) {
    var0 waittill("damage", var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15, var16, var17, var18);
    var3 += var4;
  }

  lootspawnitemlist(var0, var1, var0);
}

function release_player_on_death(var0, var1) {
  var0 endon("kidnap_kill_started");
  var0 waittill("death");
  break_player_out_of_anim(var1);
}

function killkidnappedplayer(var0, var1) {
  var1 notify("kidnap_kill_started");
  deleteobjectiveicon(var0);
  var0.shouldskiplaststand = 1;
  var0.shouldskipdeathsshield = 1;
  var0.islockedinkidnapanim = 0;
  var0.being_hunted_by_kidnapper = 0;
  screen_fade_to_black(var0);
  wait 1;
  var0 dodamage(var0.maxhealth + 1000, var0.origin);
  screen_fade_back_to_normal(var0);
}

function screen_fade_to_black(var0) {
  if(!isDefined(var0.kidnap_black_screen)) {
    var0.kidnap_black_screen = newclienthudelem(var0);
    var0.kidnap_black_screen.x = 0;
    var0.kidnap_black_screen.y = 0;
    var0.kidnap_black_screen setshader("black", 640, 480);
    var0.kidnap_black_screen.alignx = "left";
    var0.kidnap_black_screen.aligny = "top";
    var0.kidnap_black_screen.sort = 1;
    var0.kidnap_black_screen.horzalign = "fullscreen";
    var0.kidnap_black_screen.vertalign = "fullscreen";
    var0.kidnap_black_screen.foreground = 1;
  }

  var0.kidnap_black_screen.alpha = 0;
  var0.kidnap_black_screen fadeovertime(1);
  var0.kidnap_black_screen.alpha = 1;
}

function screen_fade_back_to_normal(var0) {
  if(isDefined(var0.kidnap_black_screen)) {
    var0.kidnap_black_screen fadeovertime(1);
    var0.kidnap_black_screen.alpha = 0;
    var0.kidnap_black_screen destroy();
    var0.kidnap_black_screen = undefined;
    return;
  }
}

function player_see_me_monitor(var0, var1) {
  var0 endon("death");
  var0 endon("subduing_player");
  var1 endon("death");

  while(1 && isalive(var1)) {
    if(var1 worldpointinreticle_circle(var0 getEye(), 65, 300) && sighttracepassed(var0 getEye(), var1 getEye(), 0, var0)) {
      break;
    }

    waitframe();
  }

  var0 scripts\engine\utility::set_movement_speed(300);
  var1.lasttimesawkidnapper = gettime();
  var0 notify("target_player_saw_me");
}

function kidnapper_toggle_monitor(var0, var1) {
  var0 endon("death");
  var0 endon("subduing_player");
  level waittill("cp_kidnappers_off");
  var1.being_hunted_by_kidnapper = 0;
  thread break_player_out_of_anim(var1);
  turnkidnappertonormalai(var0);
}

function watch_for_kidnapper_death(var0, var1) {
  level endon("game_ended");
  var0 waittill("death");
  level notify("cp_kidnappers_reset");

  if(isDefined(var1) && var1 scripts\cp\utility::is_valid_player()) {
    var1.being_hunted_by_kidnapper = 0;
    deleteobjectiveicon(var1);
    return;
  }
}

function ref_14464(var0, var1) {
  level endon("game_ended");
  var0 endon("death");
  var1 scripts\engine\utility::ref_143a5("death", "disconnect");
  turnkidnappertonormalai(var0);
}

function sort_players_based_on_previous_kidnap_attempt_time() {
  var0 = gettime();

  foreach(var2 in level.players) {
    if(!isDefined(var2.previous_kidnap_attempt_time)) {
      var2.previous_kidnap_attempt_time = 0;
    }
  }

  var4 = level.players;
  var5 = var4.size;

  if(var5 > 1) {
    for(;;) {
      var6 = 0;

      for(var7 = 1; var7 <= var5 - 1; var7++) {
        var8 = var4[var7 - 1];
        var9 = var4[var7];

        if(var9.previous_kidnap_attempt_time < var8.previous_kidnap_attempt_time) {
          var4 = var9;
          var4 = var8;
          var6 = 1;
        }
      }

      if(var6 == 0) {
        break;
      }
    }
  }

  return var4;
}

function createspawnerstructbehindplayer(var0) {
  var1 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(var0, (-1000, 0, 0)));
  var2 = spawnStruct();
  var2.origin = var1;
  var2.angles = scripts\engine\utility::ter_op(isDefined(var0.angles), var0.angles, (0, 0, 0));
  return var2;
}

function getrandomplayersinteam(var0) {
  var1 = scripts\cp\utility::getplayersinteam(var0);

  if(var1.size <= 1) {
    if(getdvarint("scr_kidnap_on_solo", 0) <= 0) {
      return undefined;
    } else {
      var2 = var1[0];

      if(isDefined(var2.lasttimekidnapped) && gettime() - var2.lasttimekidnapped <= 60000 || istrue(var2.being_hunted_by_kidnapper)) {
        return undefined;
      } else {
        return var1;
      }
    }
  }

  var3 = [];

  for(var4 = 0; var4 < var1.size; var4++) {
    var2 = var1[var4];

    if(!isalive(var2) || var2.inlaststand || istrue(var2.being_hunted_by_kidnapper)) {
      continue;
    }

    if(isDefined(var2.lasttimekidnapped) && gettime() - var2.lasttimekidnapped <= 60000) {
      continue;
    }

    if(randomint(2) > 0) {
      var3 = var2;
    }
  }

  return var3;
}

function getvulnerableplayersinteam(var0) {
  level endon("game_ended");
  var1 = scripts\cp\utility::getplayersinteam(var0);

  if(var1.size <= 1) {
    if(getdvarint("scr_kidnap_on_solo", 0) <= 0) {
      return undefined;
    } else {
      var2 = var1[0];

      if(isplayerabletobekidnapped(var2)) {
        return var1;
      }
    }
  }

  var3 = [];
  var4 = [];

  for(var5 = 0; var5 < var1.size; var5++) {
    var2 = var1[var5];

    if(isplayerabletobekidnapped(var2)) {
      var3 = sortbydistance(var1, var2.origin);
      var3 = scripts\engine\utility::array_remove(var3, var2);

      if(distance(var2.origin, var3[0].origin) > 6000) {
        var4 = var2;
      }
    }
  }

  return var4;
}

function setimmunetokidnapper(var0) {
  if(!isPlayer(self)) {
    scripts\engine\utility::error("ToggleImmuneToKidnapper called on a non player ent");
    return;
  }

  self.immunetokidnapper = var0;
}

function ishuntedplayerabletobekidnapped(var0) {
  if(!isDefined(var0) || !isalive(var0) || isDefined(var0.lasttimekidnapped) && gettime() - var0.lasttimekidnapped <= 60000 || istrue(var0.inlaststand) || istrue(var0.fauxdead) || istrue(var0.binvehicle) || istrue(var0.immunetokidnapper) || istrue(updateparachutestreamhint(var0))) {
    return 0;
  }

  return 1;
}

function isplayerabletobekidnapped(var0) {
  if(!isDefined(var0) || !isalive(var0) || isDefined(var0.lasttimekidnapped) && gettime() - var0.lasttimekidnapped <= 60000 || istrue(var0.being_hunted_by_kidnapper) || istrue(var0.inlaststand) || istrue(var0.fauxdead) || istrue(var0.binvehicle) || istrue(var0.immunetokidnapper) || istrue(var0.usinggunship) || istrue(updateparachutestreamhint(var0))) {
    return 0;
  }

  return 1;
}

function updateparachutestreamhint(var0) {
  if(!isDefined(var0) || !isDefined(var0.currentweapon)) {
    return false;
  }

  var1 = var0.currentweapon;
  return var1.basename == "ks_remote_device_mp";
}

function togglekidnappers(var0) {
  if(var0) {
    level notify("cp_kidnappers_on");
  } else {
    level notify("cp_kidnappers_off");
  }

  level.cp_kidnappers_active = var0;
}

function ref_13a37(var0) {
  var0.restoreweapon = var0 getcurrentweapon();
  var1 = getcompleteweaponname("iw8_gunless");
  var0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var1, undefined, undefined, 1);
  var2 = var0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var1, 0);
  var0.gunlessweapon = var1;
  var0 scripts\common\utility::allow_weapon_switch(0);
}

function ref_13650(var0) {
  var1 = spawn("script_model", var0.origin);
  var1 setModel("attachment_wm_pi_golf21_receiver");
  var1 linkTo(var0, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  var2 = spawn("script_model", var0.origin);
  var2 setModel("attachment_wm_pi_golf21_slide");
  var2 linkTo(var1);
  var0.pistol = var1;
  var0.ref_1237d = var2;
  var0 scripts\engine\utility::ref_143a5("death", "kidnap_kill_started");
  var1 delete();
  var2 delete();
}

#using_animtree("");

function lootleaderoneperteam(var0, var1) {
  level endon("game_ended");
  var0 endon("death");
  var0 endon("kidnap_kill_started");
  var1 setstance("stand");
  var1.islockedinkidnapanim = 1;
  var0.scripted_mode = 1;
  var0.ignoreall = 1;
  thread create_player_rig(var1, var1);
  var1 scripts\common\anim::anim_first_frame_solo(var1.player_rig, "kidnapper_grab");
  var1.player_rig hide();
  link_player_to_rig(var1, 0.2);
  ref_12d9c(var0, var1);
  var2 = var0 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "cp_kidnapper_melee_attack");
  var3 = var0 scripts\asm\asm::asm_getxanim("animscripted", var2);
  var4 = getanimlength(%cp_hostagetaker_grab_attacker);
  var5 = spawn("script_origin", var1.origin);
  var5.origin = var1.origin;
  var5.angles = var1.angles;
  var0.ref_12f89 = var5;
  var6 = getstartorigin(var5.origin, var5.angles, var3);
  var7 = getstartangles(var5.origin, var5.angles, var3);
  var1 dontinterpolate();
  var1 setplayerangles(var7);
  var1 setOrigin(var6);
  var5 thread scripts\cp\cp_anim::anim_player_solo(var1, var1.player_rig, "kidnapper_grab");
  var0 scripts\asm\shared\mp\utility::burningpartlogic("cp_kidnapper_melee_attack", var5, undefined, 1);
  wait var4 / 2;
  thread ref_13a37(var1);
  wait var4 / 2;
  var2 = var0 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "cp_kidnapper_subduing");
  var3 = var0 scripts\asm\asm::asm_getxanim("animscripted", var2);
  var4 = getanimlength($cp_hostagetaker_idle_victim);
  var6 = getstartorigin(var5.origin, var5.angles, var3);
  var7 = getstartangles(var5.origin, var5.angles, var3);
  var0 forceteleport(var6, var7);
  var1 setplayerangles(var7);
  var1 setOrigin(var6);
  var5 scripts\common\anim::anim_first_frame_solo(var1.player_rig, "kidnapper_subduing");
  var8 = gettime() + 15000;

  while(gettime() < var8) {
    var1 dontinterpolate();
    var1 setplayerangles(var7);
    var1 setOrigin(var6);
    var5 thread scripts\cp\cp_anim::anim_player_solo(var1, var1.player_rig, "kidnapper_subduing");
    var0 scripts\asm\shared\mp\utility::burningpartlogic("cp_kidnapper_subduing", var5, undefined, 1);
    wait var4;
  }

  var2 = var0 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "cp_kidnapper_execute");
  var3 = var0 scripts\asm\asm::asm_getxanim("animscripted", var2);
  var4 = getanimlength(%cp_hostagetaker_rescue_attacker);
  var6 = getstartorigin(var5.origin, var5.angles, var3);
  var7 = getstartangles(var5.origin, var5.angles, var3);
  var1 dontinterpolate();
  var1 setplayerangles(var7);
  var1 setOrigin(var6);
  var5 thread scripts\cp\cp_anim::anim_player_solo(var1, var1.player_rig, "kidnapper_execution");
  var0 scripts\asm\shared\mp\utility::burningpartlogic("cp_kidnapper_execute", var5, undefined, 1);
  wait var4;
  var5 delete();

  if(isDefined(var1.set_tank_target_player)) {
    var1 scripts\cp\cp_weapons::_takeweapon(var1.set_tank_target_player);
  }

  var0 notify("kidnap_sequence_complete");
}

function lootspawnitemlist(var0, var1) {
  level endon("game_ended");
  var1.scripted_mode = 1;
  var1.ignoreall = 1;
  var2 = var1 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "cp_kidnapper_death");
  var3 = var1 scripts\asm\asm::asm_getxanim("animscripted", var2);
  var4 = getanimlength(%cp_hostagetaker_death_attacker);
  var5 = var1.ref_12f89;
  var5.origin = var0.origin;
  var5.angles = var0.angles;
  var1.ref_12f89 = var5;
  var6 = getstartorigin(var5.origin, var5.angles, var3);
  var7 = getstartangles(var5.origin, var5.angles, var3);
  var0 dontinterpolate();
  var0 setplayerangles(var7);
  var0 setOrigin(var6);
  var5 thread scripts\cp\cp_anim::anim_player_solo(var0, var0.player_rig, "kidnapper_death");
  var1 scripts\asm\shared\mp\utility::burningpartlogic("cp_kidnapper_death", var5, undefined, 1);
  wait var4;
  var1 suicide();
  var5 delete();
  break_player_out_of_anim();
}

function break_player_out_of_anim(var0) {
  if(istrue(var0.islockedinkidnapanim)) {
    var0 freezecontrols(0);
    var0 enableusability();
    var0 allowcrouch(1);
    var0 cameradefault();
    var0 notify("remove_rig");
    var0 stopanimscriptsceneevent();
    var0.islockedinkidnapanim = 0;

    if(isDefined(var0.set_tank_target_player)) {
      var0 scripts\cp\cp_weapons::_takeweapon(var0.set_tank_target_player);
    }

    if(isDefined(var0.restoreweapon)) {
      var0 switchtoweapon(var0.restoreweapon);
    }
  }

  screen_fade_back_to_normal(var0);
}

function create_player_rig(var0, var1, var2) {
  if(!isDefined(var0) || isDefined(var0.player_rig)) {
    return;
  }

  var0.animname = var1;

  if(!isDefined(var2)) {
    var2 = "viewhands_base_iw8";
  }

  var0 predictstreampos(var0.origin);
  var3 = spawn("script_arms", var0.origin, 0, 0, var0);
  var3.player = var0;
  var0.player_rig = var3;
  var0.player_rig hide();
  var0.player_rig.animname = var1;
  var0.player_rig useanimtree(#animtree);
  var0.player_rig.angles = scripts\engine\utility::ter_op(isDefined(var0.angles), var0.angles, (0, 0, 0));
  watch_remove_rig(var0);
  remove_player_rig(var0);
}

function watch_remove_rig(var0) {
  scripts\engine\utility::ref_143a6("remove_rig", "death", "disconnect");
}

function remove_player_rig(var0) {
  if(!isDefined(var0) || !isDefined(var0.player_rig)) {
    return;
  }

  var0 unlink();
  var1 = var0 getdroptofloorposition(var0.origin);

  if(isDefined(var1)) {
    var0 setOrigin(var1);
  } else {
    var0 setOrigin(var0.origin + (0, 0, 100));
  }

  var0.player_rig delete();
  var0.player_rig = undefined;
}

function link_player_to_rig(var0, var1) {
  var0 endon("death");
  var0 endon("disconnect");

  if(!isDefined(var0) || !isDefined(var0.player_rig)) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 0.2;
  }

  var0 playerlinktoblend(var0.player_rig, "tag_player", var1, 0.25, 0.25);
  wait var1;
  var0 playerlinktodelta(var0.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1);
}

function createobjectiveicon(var0) {
  var0.kidnap_wid = scripts\cp\cp_objectives::requestworldid(var0.name + "_kidnapper");
  objective_setplayintro(var0.kidnap_wid, 0);
  objective_setplayoutro(var0.kidnap_wid, 0);
  objective_state(var0.kidnap_wid, "current");
  objective_icon(var0.kidnap_wid, "icon_waypoint_objective_general");
  objective_setbackground(var0.kidnap_wid, 1);
  objective_onentity(var0.kidnap_wid, var0);
  objective_setlabel(var0.kidnap_wid, &"CP_OBJECTIVES/KIDNAPPED");
}

function deleteobjectiveicon(var0) {
  if(!isDefined(var0.kidnap_wid)) {
    return;
  }

  objective_delete(var0.kidnap_wid);
  scripts\cp\cp_objectives::freeworldid(var0.name + "_kidnapper");
  var0.kidnap_wid = undefined;
}

function enteredvehicle(var0, var1) {
  setimmunetokidnapper(var1, 1);
}

function exitedvehicle(var0, var1) {
  setimmunetokidnapper(var1, 0);
}

function init_relic_martyrdom() {
  var0 = "devgui_cmd \"CP Debug:2 / Kidnapper / SpawnKidnapper\" \"set start_kidnapper_debug spawn - kidnapper\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
}

function vehomn_showcontrols(var0) {
  var1 = strtok(var0, "_");
  var2 = level.players[0];

  switch (var1[0]) {
    case "spawn":
    default:
      spawn_kidnapper_for_player(var2);
      break;
  }

  waitframe();
  setDvar("start_kidnapper_debug", "");
}

function issameteamagent(var0) {
  wait 7;
  var0 dodamage(200, var0.origin, var0, var0, "MOD_SUICIDE");
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