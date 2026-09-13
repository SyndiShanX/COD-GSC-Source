/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_kidnapper.gsc
***********************************************/

init_kidnapper_combat_loop() {
  return;
  init_anims();
  registerkidnapperspawnmod();
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(getdvarint("dvar_EFCF33F4277063DA", 0) <= 0)
    wait(randomfloatrange(20, 40));

  level.cp_kidnappers_active = 1;
  level thread kidnapper_monitor();
}

kidnapper_monitor() {
  wait 30;

  for(;;) {
    if(!istrue(level.cp_kidnappers_active) || getdvarint("dvar_678F5A69FAEC918C", 0) > 0) {
      wait 1;
      continue;
    }

    _id_6145A1C97DF45EED = getvulnerableplayersinteam("allies");

    if(isDefined(_id_6145A1C97DF45EED) && _id_6145A1C97DF45EED.size > 0) {
      _id_8850D9F771525016 = _id_6145A1C97DF45EED[randomint(_id_6145A1C97DF45EED.size)];
      level thread spawn_kidnapper_for_player(_id_8850D9F771525016);
    }

    level scripts\engine\utility::waittill_notify_or_timeout("cp_kidnappers_reset", 40);
    wait(randomfloatrange(20, 40));
    wait 1;
  }
}

registerkidnapperspawnmod() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  func = _id_18A73A64992DD07D::registerambientgroup;
  [[func]]("cp_kidnapper", 1, 1, 1, 0.5, undefined, ::getspawnerstructbehindcurplayer, undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("cp_kidnapper", ::kidnapper_after_spawn_func);
}

getspawnerstructbehindcurplayer(group) {
  if(isDefined(level.curplayertohavekidnapperspawned))
    target_player = level.curplayertohavekidnapperspawned;
  else
    return undefined;

  _id_900321667A59C6E9 = createspawnerstructbehindplayer(target_player);
  _id_900321667A59C6E9.script_forcespawn = 1;
  return _id_900321667A59C6E9;
}

kidnapper_after_spawn_func(group) {
  waitframe();
  level notify("cp_kidnapper_spawned", self);
}

spawn_kidnapper_for_player(target_player) {
  level endon("game_ended");
  level.curplayertohavekidnapperspawned = target_player;
  _id_18A73A64992DD07D::run_spawn_module("cp_kidnapper");
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
  soldier _id_18A73A64992DD07D::set_character_models("body_al_qatala_1_ar", "head_al_qatala_ar");
  soldier._id_98ADD129A7ECB962 = 0;
  soldier.is_kidnapping_player = 1;
  soldier thread get_to_target_player(soldier, target_player);
  soldier thread watch_for_kidnapper_death(soldier, target_player);
  soldier thread watch_for_player_death(soldier, target_player);
  soldier thread player_see_me_monitor(soldier, target_player);
  soldier thread kidnapper_toggle_monitor(soldier, target_player);
  level notify("cp_kidnapper_spawned_for_player");
}

get_to_target_player(soldier, target_player) {
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

  if(ishuntedplayerabletobekidnapped(target_player) || getdvarint("dvar_EDC081D42F6C46AA", 0) > 0)
    soldier thread dokidnapsequence(soldier, target_player);
  else {
    turnkidnappertonormalai(soldier);

    if(isDefined(target_player))
      target_player.being_hunted_by_kidnapper = 0;
  }
}

dokidnapsequence(soldier, target_player) {
  soldier endon("death");
  soldier endon("kidnapper_turned_to_normal_ai");
  target_player _id_3B64EB40368C1450::set("kidnap", "freezecontrols", 1);
  target_player _id_3B64EB40368C1450::set("kidnap", "usability", 0);
  target_player _id_3B64EB40368C1450::set("kidnap", "crouch", 0);
  target_player.lasttimekidnapped = gettime();
  soldier scripts\engine\utility::set_movement_speed(0);
  soldier.health = 99999;
  soldier thread release_player_on_damage(soldier, target_player, 100);
  soldier thread release_player_on_death(soldier, target_player);
  soldier.restoreweapon = soldier.pistolweapon;
  soldier takeweapon(soldier.weapon);
  soldier thread spawnfakepistol(soldier);

  if(getdvarint("dvar_E1991209443871C9", 0) >= 1)
    soldier thread debug_test_kill_kidnapper(soldier);

  screen_fade_to_black(target_player);
  target_player cameraset("camera_custom_orbit_2_cp");
  soldier thread do_kidnapping_anims(soldier, target_player);
  soldier notify("subduing_player");
  target_player notify("being_subdued");
  wait 1;
  screen_fade_back_to_normal(target_player);
  createobjectiveicon(target_player);

  if(!isDefined(target_player.times_kidnapped))
    target_player.times_kidnapped = 1;
  else
    target_player.times_kidnapped++;

  scripts\cp\cp_analytics::logevent_kidnapevent(target_player, 1.8);
  soldier waittill("kidnap_sequence_complete");

  if(isDefined(target_player.restoreweapon))
    target_player switchtoweapon(target_player.restoreweapon);

  killkidnappedplayer(target_player, soldier);

  if(isDefined(soldier.scriptednode))
    soldier.scriptednode delete();

  target_player notify("remove_rig");
  target_player enableusability();
  target_player allowcrouch(1);
  target_player cameradefault();

  if(isDefined(soldier.restoreweapon))
    soldier giveweapon(soldier.restoreweapon);

  level notify("cp_kidnappers_reset");
  thread turnkidnappertonormalai(soldier);
}

turnkidnappertonormalai(soldier) {
  soldier.dontevershoot = 0;
  soldier.ignoreall = 0;
  soldier scripts\engine\utility::set_movement_speed(300);
  soldier.scripted_mode = 0;
  soldier scripts\asm\shared\mp\utility::animscripted_clear();
  soldier.health = 100;
  soldier.is_kidnapping_player = 0;
  soldier notify("kidnapper_turned_to_normal_ai");
}

rotateplayer(kidnapper, player) {
  _id_599217E02A6DA3FA = player.player_rig;
  _id_599217E02A6DA3FA rotateTo(kidnapper.angles, 0.2);
  wait 0.2;
  player dontinterpolate();
  player setplayerangles(kidnapper.angles);
}

release_player_on_damage(soldier, target_player, _id_8D2503EBCBBFD4A1) {
  soldier endon("kidnap_kill_started");
  soldier endon("death");

  for(damagetaken = 0; damagetaken < _id_8D2503EBCBBFD4A1; damagetaken = damagetaken + damage)
    soldier waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor, eventid);

  soldier do_player_rescued_anim(target_player, soldier);
}

release_player_on_death(soldier, target_player) {
  soldier endon("kidnap_kill_started");
  soldier waittill("death");
  break_player_out_of_anim(target_player);
}

killkidnappedplayer(target_player, soldier) {
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

screen_fade_to_black(player) {
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

screen_fade_back_to_normal(player) {
  if(isDefined(player.kidnap_black_screen)) {
    player.kidnap_black_screen fadeovertime(1);
    player.kidnap_black_screen.alpha = 0;
    player.kidnap_black_screen destroy();
    player.kidnap_black_screen = undefined;
  }
}

player_see_me_monitor(soldier, target_player) {
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

kidnapper_toggle_monitor(soldier, target_player) {
  soldier endon("death");
  soldier endon("subduing_player");
  level waittill("cp_kidnappers_off");
  target_player.being_hunted_by_kidnapper = 0;
  thread break_player_out_of_anim(target_player);
  soldier turnkidnappertonormalai();
}

watch_for_kidnapper_death(soldier, target_player) {
  level endon("game_ended");
  soldier waittill("death");
  level notify("cp_kidnappers_reset");

  if(isDefined(target_player) && target_player scripts\cp\utility::is_valid_player()) {
    target_player.being_hunted_by_kidnapper = 0;
    deleteobjectiveicon(target_player);
  }
}

watch_for_player_death(soldier, target_player) {
  level endon("game_ended");
  soldier endon("death");
  target_player scripts\engine\utility::waittill_any_2("death", "disconnect");
  turnkidnappertonormalai(soldier);
}

sort_players_based_on_previous_kidnap_attempt_time() {
  current_time = gettime();

  foreach(player in level.players) {
    if(!isDefined(player.previous_kidnap_attempt_time))
      player.previous_kidnap_attempt_time = 0;
  }

  _id_1C11567DBF9C329C = level.players;
  _id_3852D4EB6B004D93 = _id_1C11567DBF9C329C.size;

  if(_id_3852D4EB6B004D93 > 1) {
    for(;;) {
      _id_FCB8575B464D3877 = 0;

      for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= _id_3852D4EB6B004D93 - 1; _id_AC0E594AC96AA3A8++) {
        _id_97D28DC646322D36 = _id_1C11567DBF9C329C[_id_AC0E594AC96AA3A8 - 1];
        _id_A3B583DB23B50298 = _id_1C11567DBF9C329C[_id_AC0E594AC96AA3A8];

        if(_id_A3B583DB23B50298.previous_kidnap_attempt_time < _id_97D28DC646322D36.previous_kidnap_attempt_time) {
          _id_1C11567DBF9C329C[_id_AC0E594AC96AA3A8 - 1] = _id_A3B583DB23B50298;
          _id_1C11567DBF9C329C[_id_AC0E594AC96AA3A8] = _id_97D28DC646322D36;
          _id_FCB8575B464D3877 = 1;
        }
      }

      if(_id_FCB8575B464D3877 == 0) {
        break;
      }
    }
  }

  return _id_1C11567DBF9C329C;
}

createspawnerstructbehindplayer(targetplayer) {
  _id_4EA8D754FEBA7E51 = getclosestpointonnavmesh(scripts\cp\utility::get_point_in_local_ent_space(targetplayer, (-1000, 0, 0)));
  spawner = spawnStruct();
  spawner.origin = _id_4EA8D754FEBA7E51;
  spawner.angles = scripts\engine\utility::ter_op(isDefined(targetplayer.angles), targetplayer.angles, (0, 0, 0));
  return spawner;
}

getrandomplayersinteam(_id_FABF84450735DD93) {
  players = scripts\cp\utility::getplayersinteam(_id_FABF84450735DD93);

  if(players.size <= 1) {
    if(getdvarint("dvar_9B411C0A7B61D61A", 0) <= 0)
      return undefined;
    else {
      player = players[0];

      if(isDefined(player.lasttimekidnapped) && gettime() - player.lasttimekidnapped <= 60000 || istrue(player.being_hunted_by_kidnapper))
        return undefined;
      else
        return players;
    }
  }

  _id_DF0FF573DBFC4F2C = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    player = players[_id_AC0E594AC96AA3A8];

    if(!isalive(player) || player.inlaststand || istrue(player.being_hunted_by_kidnapper)) {
      continue;
    }
    if(isDefined(player.lasttimekidnapped) && gettime() - player.lasttimekidnapped <= 60000) {
      continue;
    }
    if(randomint(2) > 0)
      _id_DF0FF573DBFC4F2C[_id_DF0FF573DBFC4F2C.size] = player;
  }

  return _id_DF0FF573DBFC4F2C;
}

getvulnerableplayersinteam(_id_FABF84450735DD93) {
  level endon("game_ended");
  players = scripts\cp\utility::getplayersinteam(_id_FABF84450735DD93);

  if(players.size <= 1) {
    if(getdvarint("dvar_9B411C0A7B61D61A", 0) <= 0)
      return undefined;
    else {
      player = players[0];

      if(isplayerabletobekidnapped(player))
        return players;
    }
  }

  _id_D0A837FCF948CC7E = [];
  _id_0B3CCCF940E74749 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    player = players[_id_AC0E594AC96AA3A8];

    if(isplayerabletobekidnapped(player)) {
      _id_D0A837FCF948CC7E = sortbydistance(players, player.origin);
      _id_D0A837FCF948CC7E = scripts\engine\utility::array_remove(_id_D0A837FCF948CC7E, player);

      if(distance(player.origin, _id_D0A837FCF948CC7E[0].origin) > 6000)
        _id_0B3CCCF940E74749[_id_0B3CCCF940E74749.size] = player;
    }
  }

  return _id_0B3CCCF940E74749;
}

setimmunetokidnapper(_id_41D8BF229CF29051) {
  if(!isPlayer(self)) {
    scripts\engine\utility::error("ToggleImmuneToKidnapper called on a non player ent");
    return;
  }

  self.immunetokidnapper = _id_41D8BF229CF29051;
}

ishuntedplayerabletobekidnapped(player) {
  if(!isDefined(player) || !isalive(player) || isDefined(player.lasttimekidnapped) && gettime() - player.lasttimekidnapped <= 60000 || istrue(player.inlaststand) || istrue(player.fauxdead) || istrue(player.binvehicle) || istrue(player.immunetokidnapper) || istrue(isplayerusingtablet(player)))
    return 0;
  else
    return 1;
}

isplayerabletobekidnapped(player) {
  if(!isDefined(player) || !isalive(player) || isDefined(player.lasttimekidnapped) && gettime() - player.lasttimekidnapped <= 60000 || istrue(player.being_hunted_by_kidnapper) || istrue(player.inlaststand) || istrue(player.fauxdead) || istrue(player.binvehicle) || istrue(player.immunetokidnapper) || istrue(player.usinggunship) || istrue(isplayerusingtablet(player)))
    return 0;
  else
    return 1;
}

isplayerusingtablet(player) {
  if(!isDefined(player) || !isDefined(player.currentweapon))
    return 0;

  weapon = player.currentweapon;
  return weapon.basename == "ks_remote_device_mp";
}

togglekidnappers(_id_41D8BF229CF29051) {
  if(_id_41D8BF229CF29051)
    level notify("cp_kidnappers_on");
  else
    level notify("cp_kidnappers_off");

  level.cp_kidnappers_active = _id_41D8BF229CF29051;
}

takeplayerweaponaway(player) {
  player.restoreweapon = player getcurrentweapon();
  gunless = makeweapon("iw8_gunless");
  player scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);
  success = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 0);
  player.gunlessweapon = gunless;
  player _id_3B64EB40368C1450::set("kidnap", "weapon_switch", 0);
}

spawnfakepistol(soldier) {
  pistol = spawn("script_model", soldier.origin);
  pistol setModel("attachment_wm_pi_golf21_receiver");
  pistol linkTo(soldier, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  pistolslide = spawn("script_model", soldier.origin);
  pistolslide setModel("attachment_wm_pi_golf21_slide");
  pistolslide linkTo(pistol);
  soldier.pistol = pistol;
  soldier.pistolslide = pistolslide;
  soldier scripts\engine\utility::waittill_any_2("death", "kidnap_kill_started");
  pistol delete();
  pistolslide delete();
}

#using_animtree("script_model");

do_kidnapping_anims(soldier, player) {
  level endon("game_ended");
  soldier endon("death");
  soldier endon("kidnap_kill_started");
  player setstance("stand");
  player.islockedinkidnapanim = 1;
  soldier.scripted_mode = 1;
  soldier.ignoreall = 1;
  player thread create_player_rig(player, "player_victim");
  player scripts\common\anim::anim_first_frame_solo(player.player_rig, "kidnapper_grab");
  player.player_rig hide();
  link_player_to_rig(player, 0.2);
  rotateplayer(soldier, player);
  animindex = soldier scripts\asm\asm::asm_lookupanimfromalias("animscripted", "cp_kidnapper_melee_attack");
  xanim = soldier scripts\asm\asm::asm_getxanim("animscripted", animindex);
  _id_228C1F2F3A2D92F1 = getanimlength(%cp_hostagetaker_grab_attacker);
  scriptednode = spawn("script_origin", player.origin);
  scriptednode.origin = player.origin;
  scriptednode.angles = player.angles;
  soldier.scriptednode = scriptednode;
  _id_ECCCD607F41E3C91 = getstartorigin(scriptednode.origin, scriptednode.angles, xanim);
  _id_46D5F28D2724BF1F = getstartangles(scriptednode.origin, scriptednode.angles, xanim);
  player dontinterpolate();
  player setplayerangles(_id_46D5F28D2724BF1F);
  player setOrigin(_id_ECCCD607F41E3C91);
  scriptednode thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "kidnapper_grab");
  soldier scripts\asm\shared\mp\utility::animscripted_single_relative("cp_kidnapper_melee_attack", scriptednode, undefined, 1);
  wait(_id_228C1F2F3A2D92F1 / 2);
  thread takeplayerweaponaway(player);
  wait(_id_228C1F2F3A2D92F1 / 2);
  animindex = soldier scripts\asm\asm::asm_lookupanimfromalias("animscripted", "cp_kidnapper_subduing");
  xanim = soldier scripts\asm\asm::asm_getxanim("animscripted", animindex);
  _id_228C1F2F3A2D92F1 = getanimlength(%cp_hostagetaker_idle_victim);
  _id_ECCCD607F41E3C91 = getstartorigin(scriptednode.origin, scriptednode.angles, xanim);
  _id_46D5F28D2724BF1F = getstartangles(scriptednode.origin, scriptednode.angles, xanim);
  soldier forceteleport(_id_ECCCD607F41E3C91, _id_46D5F28D2724BF1F);
  player setplayerangles(_id_46D5F28D2724BF1F);
  player setOrigin(_id_ECCCD607F41E3C91);
  scriptednode scripts\common\anim::anim_first_frame_solo(player.player_rig, "kidnapper_subduing");
  endtime = gettime() + 15000;

  while(gettime() < endtime) {
    player dontinterpolate();
    player setplayerangles(_id_46D5F28D2724BF1F);
    player setOrigin(_id_ECCCD607F41E3C91);
    scriptednode thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "kidnapper_subduing");
    soldier scripts\asm\shared\mp\utility::animscripted_single_relative("cp_kidnapper_subduing", scriptednode, undefined, 1);
    wait(_id_228C1F2F3A2D92F1);
  }

  animindex = soldier scripts\asm\asm::asm_lookupanimfromalias("animscripted", "cp_kidnapper_execute");
  xanim = soldier scripts\asm\asm::asm_getxanim("animscripted", animindex);
  _id_228C1F2F3A2D92F1 = getanimlength(%cp_hostagetaker_rescue_attacker);
  _id_ECCCD607F41E3C91 = getstartorigin(scriptednode.origin, scriptednode.angles, xanim);
  _id_46D5F28D2724BF1F = getstartangles(scriptednode.origin, scriptednode.angles, xanim);
  player dontinterpolate();
  player setplayerangles(_id_46D5F28D2724BF1F);
  player setOrigin(_id_ECCCD607F41E3C91);
  scriptednode thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "kidnapper_execution");
  soldier scripts\asm\shared\mp\utility::animscripted_single_relative("cp_kidnapper_execute", scriptednode, undefined, 1);
  wait(_id_228C1F2F3A2D92F1);
  scriptednode delete();

  if(isDefined(player.gunless))
    player scripts\cp_mp\utility\inventory_utility::_takeweapon(player.gunless);

  soldier notify("kidnap_sequence_complete");
}

do_player_rescued_anim(player, soldier) {
  level endon("game_ended");
  soldier.scripted_mode = 1;
  soldier.ignoreall = 1;
  animindex = soldier scripts\asm\asm::asm_lookupanimfromalias("animscripted", "cp_kidnapper_death");
  xanim = soldier scripts\asm\asm::asm_getxanim("animscripted", animindex);
  _id_228C1F2F3A2D92F1 = getanimlength(%cp_hostagetaker_death_attacker);
  scriptednode = soldier.scriptednode;
  scriptednode.origin = player.origin;
  scriptednode.angles = player.angles;
  soldier.scriptednode = scriptednode;
  _id_ECCCD607F41E3C91 = getstartorigin(scriptednode.origin, scriptednode.angles, xanim);
  _id_46D5F28D2724BF1F = getstartangles(scriptednode.origin, scriptednode.angles, xanim);
  player dontinterpolate();
  player setplayerangles(_id_46D5F28D2724BF1F);
  player setOrigin(_id_ECCCD607F41E3C91);
  scriptednode thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "kidnapper_death");
  soldier scripts\asm\shared\mp\utility::animscripted_single_relative("cp_kidnapper_death", scriptednode, undefined, 1);
  wait(_id_228C1F2F3A2D92F1);
  soldier suicide();
  scriptednode delete();
  break_player_out_of_anim();
}

break_player_out_of_anim(target_player) {
  if(istrue(target_player.islockedinkidnapanim)) {
    target_player cameradefault();
    target_player notify("remove_rig");
    target_player stopanimscriptsceneevent();
    target_player.islockedinkidnapanim = 0;

    if(isDefined(target_player.gunless))
      target_player scripts\cp_mp\utility\inventory_utility::_takeweapon(target_player.gunless);

    if(isDefined(target_player.restoreweapon))
      target_player switchtoweapon(target_player.restoreweapon);
  }

  screen_fade_back_to_normal(target_player);
}

create_player_rig(player, animname, _id_486DB5FA512A3B6B) {
  if(!isDefined(player) || isDefined(player.player_rig)) {
    return;
  }
  player.animname = animname;

  if(!isDefined(_id_486DB5FA512A3B6B))
    _id_486DB5FA512A3B6B = "viewhands_base_iw8";

  player _meth_B88C89BB7CD1AB8E(player.origin);
  player_rig = spawn("script_arms", player.origin, 0, 0, player);
  player_rig.player = player;
  player.player_rig = player_rig;
  player.player_rig hide();
  player.player_rig.animname = animname;
  player.player_rig useanimtree(#animtree);
  player.player_rig.angles = scripts\engine\utility::ter_op(isDefined(player.angles), player.angles, (0, 0, 0));
  player watch_remove_rig();
  remove_player_rig(player);
}

watch_remove_rig(struct) {
  scripts\engine\utility::waittill_any_3("remove_rig", "death", "disconnect");
}

remove_player_rig(player) {
  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }
  player unlink();
  _id_5BF3E22BDB650432 = player getdroptofloorposition(player.origin);

  if(isDefined(_id_5BF3E22BDB650432))
    player setOrigin(_id_5BF3E22BDB650432);
  else
    player setOrigin(player.origin + (0, 0, 100));

  player.player_rig delete();
  player.player_rig = undefined;
}

link_player_to_rig(player, _id_D180B535A33B044D) {
  player endon("death");
  player endon("disconnect");

  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }
  if(!isDefined(_id_D180B535A33B044D))
    _id_D180B535A33B044D = 0.2;

  player playerlinktoblend(player.player_rig, "tag_player", _id_D180B535A33B044D, 0.25, 0.25);
  wait(_id_D180B535A33B044D);
  player playerlinktodelta(player.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1);
}

createobjectiveicon(player) {
  player.kidnap_wid = scripts\cp\cp_objectives::requestworldid(player.name + "_kidnapper");
  objective_setplayintro(player.kidnap_wid, 0);
  objective_setplayoutro(player.kidnap_wid, 0);
  objective_state(player.kidnap_wid, "current");
  objective_icon(player.kidnap_wid, "icon_waypoint_objective_general");
  objective_setbackground(player.kidnap_wid, 1);
  objective_onentity(player.kidnap_wid, player);
  objective_setlabel(player.kidnap_wid, &"CP_OBJECTIVES/KIDNAPPED");
}

deleteobjectiveicon(player) {
  if(!isDefined(player.kidnap_wid)) {
    return;
  }
  objective_delete(player.kidnap_wid);
  scripts\cp\cp_objectives::freeworldid(player.name + "_kidnapper");
  player.kidnap_wid = undefined;
}

enteredvehicle(vehicle, player) {
  player setimmunetokidnapper(1);
}

exitedvehicle(vehicle, player) {
  player setimmunetokidnapper(0);
}

createdevguientryforkidnapper() {
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Kidnapper / SpawnKidnapper\" \"set start_kidnapper_debug spawn - kidnapper\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
}

kidnapperdebug(_id_CB325DDB4A764623) {
  items = strtok(_id_CB325DDB4A764623, "_");
  player = level.players[0];

  switch (items[0]) {
    case "spawn":
    default:
      spawn_kidnapper_for_player(player);
      break;
  }

  waitframe();
  setDvar("dvar_4B911FF6041153FB", "");
}

debug_test_kill_kidnapper(soldier) {
  wait 7;
  soldier dodamage(200, soldier.origin, soldier, soldier, "MOD_SUICIDE");
}

init_anims() {
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