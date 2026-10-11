/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_kidnapper.gsc
***********************************************/

#using scripts\asm\asm;
#using scripts\asm\shared\mp\utility;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_anim;
#using scripts\cp\cp_objectives;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp_mp\anim_scene;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#namespace cp_kidnapper;

function init_kidnapper_combat_loop() {
  thread createdevguientryforkidnapper();
  level thread debug_activation(@ "hash_4b911ff6041153fb", &kidnapperdebug);
}

function kidnapper_monitor() {
  wait 30;

  while(true) {
    if(!istrue(level.cp_kidnappers_active) || getdvarint(@ "hash_678f5a69faec918c", 0) > 0) {
      wait 1;
      continue;
    }

    target_players = getvulnerableplayersinteam("allies");

    if(isDefined(target_players) && target_players.size > 0) {
      var_8850d9f771525016 = target_players[randomint(target_players.size)];
      level thread spawn_kidnapper_for_player(var_8850d9f771525016);
    }

    level waittill_notify_or_timeout("cp_kidnappers_reset", 40);
    wait randomfloatrange(20, 40);
    wait 1;
  }
}

function registerkidnapperspawnmod() {
  flag_wait("interactions_initialized");
  func = &scripts\cp\spawning::registerambientgroup;
  [[func]]("cp_kidnapper", 1, 1, 1, 0.5, undefined, &getspawnerstructbehindcurplayer, undefined, undefined, undefined);
  scripts\cp\spawning::register_module_ai_spawn_func("cp_kidnapper", &kidnapper_after_spawn_func);
}

function getspawnerstructbehindcurplayer(group) {
  if(isDefined(level.curplayertohavekidnapperspawned)) {
    target_player = level.curplayertohavekidnapperspawned;
  } else {
    return undefined;
  }

  var_900321667a59c6e9 = createspawnerstructbehindplayer(target_player);
  var_900321667a59c6e9.script_forcespawn = 1;
  return var_900321667a59c6e9;
}

function kidnapper_after_spawn_func(group) {
  waitframe();
  level notify("cp_kidnapper_spawned", self);
}

function spawn_kidnapper_for_player(target_player) {
  level endon("game_ended");
  level.curplayertohavekidnapperspawned = target_player;
  scripts\cp\spawning::run_spawn_module("cp_kidnapper");
  level waittill("cp_kidnapper_spawned", vip);
  soldier = vip;

  if(!isDefined(soldier)) {
    return;
  }

  target_player playsoundtoplayer("melee_takedown_knife_stab_release_short", target_player);
  soldier.drawoncompass = 1;
  target_player.being_hunted_by_kidnapper = 1;
  soldier.maxfaceenemydist = 768;
  soldier.dontevershoot = 1;
  soldier.ignoreall = 1;
  soldier.maxhealth = 250;
  soldier.health = soldier.maxhealth;
  soldier.wearing_armor = 1;
  soldier scripts\engine\utility::set_movement_speed(200);
  soldier getenemyinfo(target_player);
  soldier scripts\cp\spawning::set_character_models("body_al_qatala_1_ar", "head_al_qatala_ar");
  soldier.allowlongdeath = 0;
  soldier.is_kidnapping_player = 1;
  soldier thread get_to_target_player(soldier, target_player);
  soldier thread watch_for_kidnapper_death(soldier, target_player);
  soldier thread watch_for_player_death(soldier, target_player);
  soldier thread player_see_me_monitor(soldier, target_player);
  soldier thread kidnapper_toggle_monitor(soldier, target_player);
  level notify("cp_kidnapper_spawned_for_player");
}

function get_to_target_player(soldier, target_player) {
  soldier endon("death");
  soldier.goalradius = 40;

  while(1 && isDefined(target_player) && isalive(target_player)) {
    soldier.disablearrivals = 1;
    soldier setgoalpos(target_player.origin);

    if(distancesquared(soldier.origin, target_player.origin) <= 2500) {
      break;
    }

    waitframe();
  }

  if(ishuntedplayerabletobekidnapped(target_player) || getdvarint(@ "hash_edc081d42f6c46aa", 0) > 0) {
    soldier thread dokidnapsequence(soldier, target_player);
    return;
  }

  turnkidnappertonormalai(soldier);

  if(isDefined(target_player)) {
    target_player.being_hunted_by_kidnapper = 0;
  }
}

function dokidnapsequence(soldier, target_player) {
  soldier endon("death");
  soldier endon("kidnapper_turned_to_normal_ai");
  target_player val::set("kidnap", "freezecontrols", 1);
  target_player val::set("kidnap", "usability", 0);
  target_player val::set("kidnap", "crouch", 0);
  target_player.lasttimekidnapped = gettime();
  soldier scripts\engine\utility::set_movement_speed(0);
  soldier.health = 99999;
  soldier thread release_player_on_damage(soldier, target_player, 100);
  soldier thread release_player_on_death(soldier, target_player);
  soldier.restoreweapon = soldier.pistolweapon;
  soldier takeweapon(soldier.weapon);
  soldier thread spawnfakepistol(soldier);

  if(getdvarint(@ "hash_e1991209443871c9", 0) >= 1) {
    soldier thread debug_test_kill_kidnapper(soldier);
  }

  screen_fade_to_black(target_player);
  target_player cameraset("camera_custom_orbit_2_cp");
  soldier thread do_kidnapping_anims(soldier, target_player);
  soldier notify("subduing_player");
  target_player notify("being_subdued");
  wait 1;
  screen_fade_back_to_normal(target_player);
  createobjectiveicon(target_player);

  if(!isDefined(target_player.times_kidnapped)) {
    target_player.times_kidnapped = 1;
  } else {
    target_player.times_kidnapped++;
  }

  scripts\cp\cp_analytics::logevent_kidnapevent(target_player, 1.8);
  soldier waittill("kidnap_sequence_complete");

  if(isDefined(target_player.restoreweapon)) {
    target_player switchtoweapon(target_player.restoreweapon);
  }

  killkidnappedplayer(target_player, soldier);

  if(isDefined(soldier.scriptednode)) {
    soldier.scriptednode delete();
  }

  target_player notify("remove_rig");
  target_player enableusability();
  target_player allowcrouch(1);
  target_player cameradefault();

  if(isDefined(soldier.restoreweapon)) {
    soldier giveweapon(soldier.restoreweapon);
  }

  level notify("cp_kidnappers_reset");
  thread turnkidnappertonormalai(soldier);
}

function turnkidnappertonormalai(soldier) {
  soldier.dontevershoot = 0;
  soldier.ignoreall = 0;
  soldier scripts\engine\utility::set_movement_speed(300);
  soldier.scripted_mode = 0;
  soldier scripts\asm\shared\mp\utility::animscripted_clear();
  soldier.health = 100;
  soldier.is_kidnapping_player = 0;
  soldier notify("kidnapper_turned_to_normal_ai");
}

function rotateplayer(kidnapper, player) {
  linkent = player.player_rig;
  linkent rotateTo(kidnapper.angles, 0.2);
  wait 0.2;
  player dontinterpolate();
  player setplayerangles(kidnapper.angles);
}

function release_player_on_damage(soldier, target_player, var_8d2503ebcbbfd4a1) {
  soldier endon("kidnap_kill_started");
  soldier endon("death");
  damagetaken = 0;

  while(damagetaken < var_8d2503ebcbbfd4a1) {
    soldier waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor, eventid);
    damagetaken += damage;
  }

  soldier do_player_rescued_anim(target_player, soldier);
}

function release_player_on_death(soldier, target_player) {
  soldier endon("kidnap_kill_started");
  soldier waittill("death");
  break_player_out_of_anim(target_player);
}

function killkidnappedplayer(target_player, soldier) {
  soldier notify("kidnap_kill_started");
  deleteobjectiveicon(target_player);
  target_player.shouldskiplaststand = 1;
  target_player.shouldskipdeathsshield = 1;
  target_player.islockedinkidnapanim = 0;
  target_player.being_hunted_by_kidnapper = 0;
  screen_fade_to_black(target_player);
  wait 1;
  target_player dodamage(target_player.maxhealth + 1000, target_player.origin);
  screen_fade_back_to_normal(target_player);
}

function screen_fade_to_black(player) {
  if(!isDefined(player.kidnap_black_screen)) {
    player.kidnap_black_screen = newclienthudelem(player);
    player.kidnap_black_screen.x = 0;
    player.kidnap_black_screen.y = 0;
    player.kidnap_black_screen setshader("black", 640, 480);
    player.kidnap_black_screen.alignx = "left";
    player.kidnap_black_screen.aligny = "top";
    player.kidnap_black_screen.sort = 1;
    player.kidnap_black_screen.horzalign = "fullscreen";
    player.kidnap_black_screen.vertalign = "fullscreen";
    player.kidnap_black_screen.foreground = 1;
  }

  player.kidnap_black_screen.alpha = 0;
  player.kidnap_black_screen fadeovertime(1);
  player.kidnap_black_screen.alpha = 1;
}

function screen_fade_back_to_normal(player) {
  if(isDefined(player.kidnap_black_screen)) {
    player.kidnap_black_screen fadeovertime(1);
    player.kidnap_black_screen.alpha = 0;
    player.kidnap_black_screen destroy();
    player.kidnap_black_screen = undefined;
  }
}

function player_see_me_monitor(soldier, target_player) {
  soldier endon("death");
  soldier endon("subduing_player");
  target_player endon("death");

  while(1 && isalive(target_player)) {
    if(target_player worldpointinreticle_circle(soldier getEye(), 65, 300) && sighttracepassed(soldier getEye(), target_player getEye(), 0, soldier)) {
      break;
    }

    waitframe();
  }

  soldier scripts\engine\utility::set_movement_speed(300);
  target_player.lasttimesawkidnapper = gettime();
  soldier notify("target_player_saw_me");
}

function kidnapper_toggle_monitor(soldier, target_player) {
  soldier endon("death");
  soldier endon("subduing_player");
  level waittill("cp_kidnappers_off");
  target_player.being_hunted_by_kidnapper = 0;
  thread break_player_out_of_anim(target_player);
  soldier turnkidnappertonormalai();
}

function watch_for_kidnapper_death(soldier, target_player) {
  level endon("game_ended");
  soldier waittill("death");
  level notify("cp_kidnappers_reset");

  if(isDefined(target_player) && target_player is_valid_player()) {
    target_player.being_hunted_by_kidnapper = 0;
    deleteobjectiveicon(target_player);
  }
}

function watch_for_player_death(soldier, target_player) {
  level endon("game_ended");
  soldier endon("death");
  target_player waittill_any_2("death", "disconnect");
  turnkidnappertonormalai(soldier);
}

function sort_players_based_on_previous_kidnap_attempt_time() {
  current_time = gettime();

  foreach(player in level.players) {
    if(!isDefined(player.previous_kidnap_attempt_time)) {
      player.previous_kidnap_attempt_time = 0;
    }
  }

  player_sorted = level.players;
  var_3852d4eb6b004d93 = player_sorted.size;

  if(var_3852d4eb6b004d93 > 1) {
    while(true) {
      swapped = 0;

      for(i = 1; i <= var_3852d4eb6b004d93 - 1; i++) {
        player_in_front = player_sorted[i - 1];
        player_in_back = player_sorted[i];

        if(player_in_back.previous_kidnap_attempt_time < player_in_front.previous_kidnap_attempt_time) {
          player_sorted[i - 1] = player_in_back;
          player_sorted[i] = player_in_front;
          swapped = 1;
        }
      }

      if(swapped == 0) {
        break;
      }
    }
  }

  return player_sorted;
}

function createspawnerstructbehindplayer(targetplayer) {
  var_4ea8d754feba7e51 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(targetplayer, (-1000, 0, 0)));
  spawner = spawnStruct();
  spawner.origin = var_4ea8d754feba7e51;
  spawner.angles = ter_op(isDefined(targetplayer.angles), targetplayer.angles, (0, 0, 0));
  return spawner;
}

function getrandomplayersinteam(teamname) {
  players = getplayersinteam(teamname);

  if(players.size <= 1) {
    if(getdvarint(@ "hash_9b411c0a7b61d61a", 0) <= 0) {
      return undefined;
    } else {
      player = players[0];

      if(isDefined(player.lasttimekidnapped) && gettime() - player.lasttimekidnapped <= 60000 || istrue(player.being_hunted_by_kidnapper)) {
        return undefined;
      } else {
        return players;
      }
    }
  }

  var_df0ff573dbfc4f2c = [];

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!isalive(player) || player.inlaststand || istrue(player.being_hunted_by_kidnapper)) {
      continue;
    }

    if(isDefined(player.lasttimekidnapped) && gettime() - player.lasttimekidnapped <= 60000) {
      continue;
    }

    if(randomint(2) > 0) {
      var_df0ff573dbfc4f2c[var_df0ff573dbfc4f2c.size] = player;
    }
  }

  return var_df0ff573dbfc4f2c;
}

function getvulnerableplayersinteam(teamname) {
  level endon("game_ended");
  players = getplayersinteam(teamname);

  if(players.size <= 1) {
    if(getdvarint(@ "hash_9b411c0a7b61d61a", 0) <= 0) {
      return undefined;
    } else {
      player = players[0];

      if(isplayerabletobekidnapped(player)) {
        return players;
      }
    }
  }

  sortedplayers = [];
  var_b3cccf940e74749 = [];

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(isplayerabletobekidnapped(player)) {
      sortedplayers = sortbydistance(players, player.origin);
      sortedplayers = array_remove(sortedplayers, player);

      if(distance(player.origin, sortedplayers[0].origin) > 6000) {
        var_b3cccf940e74749[var_b3cccf940e74749.size] = player;
      }
    }
  }

  return var_b3cccf940e74749;
}

function setimmunetokidnapper(toggle) {
  if(!isPlayer(self)) {
    error("ToggleImmuneToKidnapper called on a non player ent");
    return;
  }

  self.immunetokidnapper = toggle;
}

function ishuntedplayerabletobekidnapped(player) {
  if(!isDefined(player) || !isalive(player) || isDefined(player.lasttimekidnapped) && gettime() - player.lasttimekidnapped <= 60000 || istrue(player.inlaststand) || istrue(player.fauxdead) || istrue(player.binvehicle) || istrue(player.immunetokidnapper) || istrue(isplayerusingtablet(player))) {
    return 0;
  }

  return 1;
}

function isplayerabletobekidnapped(player) {
  if(!isDefined(player) || !isalive(player) || isDefined(player.lasttimekidnapped) && gettime() - player.lasttimekidnapped <= 60000 || istrue(player.being_hunted_by_kidnapper) || istrue(player.inlaststand) || istrue(player.fauxdead) || istrue(player.binvehicle) || istrue(player.immunetokidnapper) || istrue(player.usinggunship) || istrue(isplayerusingtablet(player))) {
    return 0;
  }

  return 1;
}

function isplayerusingtablet(player) {
  if(!isDefined(player) || !isDefined(player.currentweapon)) {
    return false;
  }

  weapon = player.currentweapon;
  return weapon.basename == "ks_remote_device_mp";
}

function togglekidnappers(toggle) {
  if(toggle) {
    level notify("cp_kidnappers_on");
  } else {
    level notify("cp_kidnappers_off");
  }

  level.cp_kidnappers_active = toggle;
}

function takeplayerweaponaway(player) {
  player.restoreweapon = player getcurrentweapon();
  gunless = makeweapon("iw8_gunless");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  player.gunlessweapon = gunless;
  player val::set("kidnap", "weapon_switch", 0);
}

function spawnfakepistol(soldier) {
  pistol = spawn("script_model", soldier.origin);
  pistol setModel("attachment_wm_pi_golf21_receiver");
  pistol linkTo(soldier, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  pistolslide = spawn("script_model", soldier.origin);
  pistolslide setModel("attachment_wm_pi_golf21_slide");
  pistolslide linkTo(pistol);
  soldier.pistol = pistol;
  soldier.pistolslide = pistolslide;
  soldier waittill_any_2("death", "kidnap_kill_started");
  pistol delete();
  pistolslide delete();
}

#using_animtree("script_model");

function do_kidnapping_anims(soldier, player) {
  level endon("game_ended");
  soldier endon("death");
  soldier endon("kidnap_kill_started");
  player setstance("stand");
  player.islockedinkidnapanim = 1;
  soldier.scripted_mode = 1;
  soldier.ignoreall = 1;
  player thread create_player_rig(player, "player_victim");
  player anim_first_frame_solo(player.player_rig, "kidnapper_grab");
  player.player_rig hide();
  link_player_to_rig(player, 0.2);
  rotateplayer(soldier, player);
  animindex = soldier scripts\asm\asm::asm_lookupanimfromalias("animscripted", "cp_kidnapper_melee_attack");
  xanim = soldier scripts\asm\asm::asm_getxanim("animscripted", animindex);
  anim_length = getanimlength(%cp_hostagetaker_grab_attacker);
  scriptednode = spawn("script_origin", player.origin);
  scriptednode.origin = player.origin;
  scriptednode.angles = player.angles;
  soldier.scriptednode = scriptednode;
  var_ecccd607f41e3c91 = getstartorigin(scriptednode.origin, scriptednode.angles, xanim);
  var_46d5f28d2724bf1f = getstartangles(scriptednode.origin, scriptednode.angles, xanim);
  player dontinterpolate();
  player setplayerangles(var_46d5f28d2724bf1f);
  player setOrigin(var_ecccd607f41e3c91);
  scriptednode thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "kidnapper_grab");
  soldier scripts\asm\shared\mp\utility::animscripted_single_relative("cp_kidnapper_melee_attack", scriptednode, undefined, 1);
  wait anim_length / 2;
  thread takeplayerweaponaway(player);
  wait anim_length / 2;
  animindex = soldier scripts\asm\asm::asm_lookupanimfromalias("animscripted", "cp_kidnapper_subduing");
  xanim = soldier scripts\asm\asm::asm_getxanim("animscripted", animindex);
  anim_length = getanimlength(%cp_hostagetaker_idle_victim);
  var_ecccd607f41e3c91 = getstartorigin(scriptednode.origin, scriptednode.angles, xanim);
  var_46d5f28d2724bf1f = getstartangles(scriptednode.origin, scriptednode.angles, xanim);
  soldier forceteleport(var_ecccd607f41e3c91, var_46d5f28d2724bf1f);
  player setplayerangles(var_46d5f28d2724bf1f);
  player setOrigin(var_ecccd607f41e3c91);
  scriptednode anim_first_frame_solo(player.player_rig, "kidnapper_subduing");
  endtime = gettime() + 15000;

  while(gettime() < endtime) {
    player dontinterpolate();
    player setplayerangles(var_46d5f28d2724bf1f);
    player setOrigin(var_ecccd607f41e3c91);
    scriptednode thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "kidnapper_subduing");
    soldier scripts\asm\shared\mp\utility::animscripted_single_relative("cp_kidnapper_subduing", scriptednode, undefined, 1);
    wait anim_length;
  }

  animindex = soldier scripts\asm\asm::asm_lookupanimfromalias("animscripted", "cp_kidnapper_execute");
  xanim = soldier scripts\asm\asm::asm_getxanim("animscripted", animindex);
  anim_length = getanimlength(%cp_hostagetaker_rescue_attacker);
  var_ecccd607f41e3c91 = getstartorigin(scriptednode.origin, scriptednode.angles, xanim);
  var_46d5f28d2724bf1f = getstartangles(scriptednode.origin, scriptednode.angles, xanim);
  player dontinterpolate();
  player setplayerangles(var_46d5f28d2724bf1f);
  player setOrigin(var_ecccd607f41e3c91);
  scriptednode thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "kidnapper_execution");
  soldier scripts\asm\shared\mp\utility::animscripted_single_relative("cp_kidnapper_execute", scriptednode, undefined, 1);
  wait anim_length;
  scriptednode delete();

  if(isDefined(player.gunless)) {
    player scripts\cp_mp\utility\inventory_utility::_takeweapon(player.gunless);
  }

  soldier notify("kidnap_sequence_complete");
}

function do_player_rescued_anim(player, soldier) {
  level endon("game_ended");
  soldier.scripted_mode = 1;
  soldier.ignoreall = 1;
  animindex = soldier scripts\asm\asm::asm_lookupanimfromalias("animscripted", "cp_kidnapper_death");
  xanim = soldier scripts\asm\asm::asm_getxanim("animscripted", animindex);
  anim_length = getanimlength(%cp_hostagetaker_death_attacker);
  scriptednode = soldier.scriptednode;
  scriptednode.origin = player.origin;
  scriptednode.angles = player.angles;
  soldier.scriptednode = scriptednode;
  var_ecccd607f41e3c91 = getstartorigin(scriptednode.origin, scriptednode.angles, xanim);
  var_46d5f28d2724bf1f = getstartangles(scriptednode.origin, scriptednode.angles, xanim);
  player dontinterpolate();
  player setplayerangles(var_46d5f28d2724bf1f);
  player setOrigin(var_ecccd607f41e3c91);
  scriptednode thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "kidnapper_death");
  soldier scripts\asm\shared\mp\utility::animscripted_single_relative("cp_kidnapper_death", scriptednode, undefined, 1);
  wait anim_length;
  soldier suicide();
  scriptednode delete();
  break_player_out_of_anim();
}

function break_player_out_of_anim(target_player) {
  if(istrue(target_player.islockedinkidnapanim)) {
    target_player cameradefault();
    target_player notify("remove_rig");
    target_player stopanimscriptsceneevent();
    target_player.islockedinkidnapanim = 0;

    if(isDefined(target_player.gunless)) {
      target_player scripts\cp_mp\utility\inventory_utility::_takeweapon(target_player.gunless);
    }

    if(isDefined(target_player.restoreweapon)) {
      target_player switchtoweapon(target_player.restoreweapon);
    }
  }

  screen_fade_back_to_normal(target_player);
}

function create_player_rig(player, animname, rig_model) {
  if(!isDefined(player) || isDefined(player.player_rig)) {
    return;
  }

  player.animname = animname;

  if(!isDefined(rig_model)) {
    rig_model = "viewhands_base_iw8";
  }

  player function_b88c89bb7cd1ab8e(player.origin);
  player_rig = spawn("script_arms", player.origin, 0, 0, player);
  player_rig.player = player;
  player.player_rig = player_rig;
  player.player_rig hide();
  player.player_rig.animname = animname;
  player.player_rig useanimtree(#animtree);
  player.player_rig.angles = ter_op(isDefined(player.angles), player.angles, (0, 0, 0));
  player watch_remove_rig();
  remove_player_rig(player);
}

function watch_remove_rig(struct) {
  waittill_any_3("remove_rig", "death", "disconnect");
}

function remove_player_rig(player) {
  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }

  player unlink();
  droppos = player getdroptofloorposition(player.origin);

  if(isDefined(droppos)) {
    player setOrigin(droppos);
  } else {
    player setOrigin(player.origin + (0, 0, 100));
  }

  player.player_rig delete();
  player.player_rig = undefined;
}

function link_player_to_rig(player, blendtime) {
  player endon("death");
  player endon("disconnect");

  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }

  if(!isDefined(blendtime)) {
    blendtime = 0.2;
  }

  player playerlinktoblend(player.player_rig, "tag_player", blendtime, 0.25, 0.25);
  wait blendtime;
  player playerlinktodelta(player.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1);
}

function createobjectiveicon(player) {
  player.kidnap_wid = scripts\cp\cp_objectives::requestworldid(player.name + "_kidnapper");
  objective_setplayintro(player.kidnap_wid, 0);
  objective_setplayoutro(player.kidnap_wid, 0);
  objective_state(player.kidnap_wid, "current");
  objective_icon(player.kidnap_wid, "icon_waypoint_objective_general");
  objective_setbackground(player.kidnap_wid, 1);
  objective_onentity(player.kidnap_wid, player);
  objective_setlabel(player.kidnap_wid, &"CP_OBJECTIVES/KIDNAPPED");
}

function deleteobjectiveicon(player) {
  if(!isDefined(player.kidnap_wid)) {
    return;
  }

  objective_delete(player.kidnap_wid);
  scripts\cp\cp_objectives::freeworldid(player.name + "_kidnapper");
  player.kidnap_wid = undefined;
}

function enteredvehicle(vehicle, player) {
  player setimmunetokidnapper(1);
}

function exitedvehicle(vehicle, player) {
  player setimmunetokidnapper(0);
}

function createdevguientryforkidnapper() {
  cmd = "devgui_cmd \"CP Debug:2 / Kidnapper / SpawnKidnapper" + "\" \"set start_kidnapper_debug spawn - kidnapper\" \n";
  addentrytodevgui(cmd);
}

function kidnapperdebug(itemref) {
  items = strtok(itemref, "_");
  player = level.players[0];

  switch (items[0]) {
    case #"hash_819aac6f5ae2fb78":
    default:
      spawn_kidnapper_for_player(player);
      break;
  }

  waitframe();
  setDvar(@ "hash_4b911ff6041153fb", "");
}

function debug_test_kill_kidnapper(soldier) {
  wait 7;
  soldier dodamage(200, soldier.origin, soldier, soldier, "MOD_SUICIDE");
}

function init_anims() {
  level.scr_animtree["player_victim"] = #animtree;
  level.scr_anim["player_victim"]["kidnapper_subduing"] = % cp_hostagetaker_idle_victim;
  level.scr_eventanim["player_victim"]["kidnapper_subduing"] = % "kidnapper_subduing";
  level.scr_anim["player_victim"]["kidnapper_grab"] = % cp_hostagetaker_grab_victim;
  level.scr_eventanim["player_victim"]["kidnapper_grab"] = % "hash_601f3a6cde0b413f";
  level.scr_anim["player_victim"]["kidnapper_execution"] = % cp_hostagetaker_rescue_victim;
  level.scr_eventanim["player_victim"]["kidnapper_execution"] = % "hash_7b751b18aa0d5b33";
  level.scr_anim["player_victim"]["kidnapper_death"] = % cp_hostagetaker_death_victim;
  level.scr_eventanim["player_victim"]["kidnapper_death"] = % "cp_kidnapper_death";
}