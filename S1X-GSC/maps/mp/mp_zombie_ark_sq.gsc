/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_ark_sq.gsc
****************************************/

init_sidequest() {
  maps\mp\zombies\_zombies_sidequests::declare_sidequest("main", ::init_main_sidequest, ::sidequest_logic, ::complete_sidequest, ::generic_stage_start, ::generic_stage_complete);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage1", ::stage1_init, ::stage1_logic, ::stage1_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage2", ::stage2_init, ::stage2_logic, ::stage2_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest("fishing", ::init_fishing_sidequest, ::sidequest_fishing_logic, ::complete_sidequest, ::generic_stage_start, ::generic_stage_complete);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("fishing", "stage1", ::fishing_stage1_init, ::fishing_stage1_logic, ::fishing_stage1_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest("code1", ::init_code1_sidequest, ::sidequest_code1_logic, ::complete_sidequest, ::generic_stage_start, ::generic_stage_complete, "code3");
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code1", "stage1", ::code1_stage1_init, ::code1_stage1_logic, ::code1_stage1_end, "code3");
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code1", "stage2", ::code1_stage2_init, ::code1_stage2_logic, ::code1_stage2_end, "code3");
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code1", "stage3", ::code1_stage3_init, ::code1_stage3_logic, ::code1_stage3_end, "code3");
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code1", "stage4", ::code1_stage4_init, ::code1_stage4_logic, ::code1_stage4_end, "code3");
  maps\mp\zombies\_zombies_sidequests::declare_sidequest("code2", ::init_code2_sidequest, ::sidequest_code2_logic, ::complete_sidequest, ::generic_stage_start, ::generic_stage_complete, "code2");
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code2", "stage1", ::code2_stage1_init, ::code2_stage1_logic, ::code2_stage1_end, "code2");
  maps\mp\zombies\_zombies_sidequests::declare_sidequest("code3", ::init_code3_sidequest, ::sidequest_code3_logic, ::complete_sidequest, ::generic_stage_start, ::generic_stage_complete, "code4");
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code3", "stage1", ::code3_stage1_init, ::code3_stage1_logic, ::code3_stage1_end, "code4");
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code3", "stage2", ::code3_stage2_init, ::code3_stage2_logic, ::code3_stage2_end, "code4");
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code3", "stage3", ::code3_stage3_init, ::code3_stage3_logic, ::code3_stage3_end, "code4");
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code3", "stage4", ::code3_stage4_init, ::code3_stage4_logic, ::code3_stage4_end, "code4");
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code3", "stage5", ::code3_stage5_init, ::code3_stage5_logic, ::code3_stage5_end, "code4");
  maps\mp\zombies\_zombies_sidequests::declare_sidequest("code4", ::init_code4_sidequest, ::sidequest_code4_logic, ::complete_sidequest, ::generic_stage_start, ::generic_stage_complete, "code1");
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("code4", "stage1", ::code4_stage1_init, ::code4_stage1_logic, ::code4_stage1_end, "code1");
  maps\mp\zombies\_zombies_sidequests::declare_sidequest("song", ::init_song_sidequest, ::sidequest_logic_song);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song", "stage1", ::songstage1_init, ::songstage1_logic, ::songstage1_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song", "stage2", ::songstage2_init, ::songstage2_logic, ::songstage2_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song", "stage3", ::songstage3_init, ::songstage3_logic, ::songstage3_end);
  common_scripts\utility::flag_init("sq_plinko");
  level._effect["sq_island_timer"] = loadfx("vfx/unique/dlc_island_timer");
  level._effect["sq_dirt_dig"] = loadfx("vfx/gameplay/mp/zombie/dlc_sand_dig");
  level._effect["sq_fishing_splash"] = loadfx("vfx/water/dlc/water_fishing_splash");
  level._effect["sq_chum"] = loadfx("vfx/blood/dlc_zombie_blood_drip_chum");
  level._effect["sq_door_light_green"] = loadfx("vfx/gameplay/mp/zombie/dlc_engroom_light_green");
  level._effect["sq_door_light_red"] = loadfx("vfx/gameplay/mp/zombie/dlc_engroom_light_red");
  level._effect["dlc_prop_biometric_lock_on"] = loadfx("vfx/props/dlc_prop_biometric_lock_on");
  level._effect["dlc_prop_biometric_lock_pass"] = loadfx("vfx/props/dlc_prop_biometric_lock_pass");
  level._sidequest_counter_base_x = 110;
  level._sidequest_counter_base_y = -70;
  level.shouldignoreplayercallback = ::arkshouldignoreplayer;
  level thread onanyplayerspawned();
  level thread startarksidequest();
  level thread initvo();
  level thread weapondisposallogic();
  level thread runozextras();
}

createfxhidesidquestents() {
  if(getDvar("createfx") != "" || getDvar("r_reflectionProbeGenerate") == "1") {
    var_0 = getEntArray("sqSecurityField", "targetname");

    foreach(var_2 in var_0) {
      if(var_2.classname == "script_brushmodel") {
        var_2 hide();
      }
    }
  }
}

onanyplayerspawned() {
  for(;;) {
    level waittill("player_spawned", var_0);

    if(isDefined(var_0) && var_0 playerhasanyitem()) {
      var_1 = inventoryitemgetid(var_0.inventoryitem);
      var_0 setclientomnvar("ui_zm_ee_int", var_1);
    }
  }
}

startarksidequest() {
  var_0 = common_scripts\utility::getstructarray("power_switch", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_flag) && var_2.script_flag == "zomboni_room") {
      var_2.noattract = 1;
    }
  }

  var_4 = getEntArray("sqSecurityField", "targetname");
  level.sqsecurityfieldbrushes = [];
  level.sqsecurityfieldtriggers = [];

  foreach(var_6 in var_4) {
    if(var_6.classname == "script_brushmodel") {
      level.sqsecurityfieldbrushes[level.sqsecurityfieldbrushes.size] = var_6;
      var_6 notsolid();
      var_6 hide();
      continue;
    }

    if(var_6.classname == "trigger_multiple") {
      level.sqsecurityfieldtriggers[level.sqsecurityfieldtriggers.size] = var_6;
    }
  }

  var_8 = getent("sqCageSwitch", "targetname");

  if(isDefined(var_8)) {
    var_8 hide();
  }

  var_9 = getent("sqPoolClip", "targetname");

  if(isDefined(var_9)) {
    var_9.origin = var_9.origin + (0, 0, -1000);
  }

  var_10 = getent("sqPoolDoor1", "targetname");

  if(isDefined(var_10)) {
    var_10.unresolved_collision_func = maps\mp\_movers::unresolved_collision_void;
  }

  var_11 = getent("sqPoolDoor2", "targetname");

  if(isDefined(var_11)) {
    var_11.unresolved_collision_func = maps\mp\_movers::unresolved_collision_void;
  }

  var_12 = getent("sqArm", "targetname");

  if(isDefined(var_12)) {
    var_12 hide();
  }

  var_13 = getent("sqIslandCrate2", "targetname");

  if(isDefined(var_13)) {
    var_13 hide();
  }

  var_14 = getent("sqCode2", "targetname");

  if(isDefined(var_14)) {
    var_14 hide();
  }

  var_14 = getent("sqCode3", "targetname");

  if(isDefined(var_14)) {
    var_14 hide();
  }

  var_15 = getent("sqTeleporterLights", "targetname");

  if(isDefined(var_15)) {
    level thread setupteleportlightmodel(var_15, 0);
  }

  var_16 = getEntArray("sqTeleportLight", "targetname");

  foreach(var_18 in var_16) {
    level thread setupteleportlight(var_18, 0);
  }

  level.waterplayerhandledamagefunc = ::playerhandlewaterdamageark;
  level.gamemodeonunderwater = ::playerunderwater;
  level thread chumwaters();
  level thread setupsharkcage();
  wait 1;
  thread maps\mp\zombies\_zombies_sidequests::sidequest_start("main");
  thread maps\mp\zombies\_zombies_sidequests::sidequest_start("song");
}

setupsharkcage() {
  var_0 = common_scripts\utility::getstruct("shark_anim_node", "targetname");
  var_1 = getent("sqCageModel", "targetname");
  var_2 = getent("sqCrane", "targetname");
  var_3 = getent("sqCage", "targetname");
  var_4 = getent("sqCageDoorClip", "targetname");
  var_5 = getent("sqCageDoorBottomClip", "targetname");
  var_6 = getent("sqCageVolume", "targetname");

  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2) || !isDefined(var_3) || !isDefined(var_4) || !isDefined(var_5) || !isDefined(var_6)) {
    return;
  }
  var_6 enablelinkto();
  var_6 linktosynchronizedparent(var_1);
  var_4 linktosynchronizedparent(var_1);
  var_5 linktosynchronizedparent(var_1);
  var_3 linktosynchronizedparent(var_1);

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  waitframe();
  var_2 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_start_idle_crane", var_0.origin, var_0.angles, "cageSequence");
  var_1 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_start_idle_cage", var_0.origin, var_0.angles, "cageSequence");
  waitframe();
  var_7 = getnodesinradius(var_1.origin, 300, 0);
  var_3.unresolved_collision_nodes = var_7;
  var_4.unresolved_collision_nodes = var_7;
  var_5.unresolved_collision_nodes = var_7;
}

initvo() {
  waitframe();
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "sq", "sq", "dlc3_easter", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "sq", "sq_dlc3", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "machine_all_players", "weap_dis", "weap_dis", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "machine_all_players", "weap_dis_prize", "weap_dis_prize", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "machine_all_players", "weap_dis_cred", "weap_dis_cred", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "global_priority", "sq", "dlc3_easter", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "machine_all_players", "sq", "dlc3_easter", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "machine_all_players", "weap_dis", "weap_dis", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_oz", "machine_all_players", "weap_dis_cred", "weap_dis_cred", undefined);

  if(!isDefined(level.sqarm)) {
    level.sqarm = getent("sqArm", "targetname");
  }

  level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer_zom", "zombie_", level.sqarm, 0);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_zom", "machine_all_players", "gimme", "gimme", undefined, 60);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_zom", "machine_all_players", "take", "take", undefined, 50);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_zom", "machine_all_players", "credits", "credits", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_zom", "machine_all_players", "item", "item", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_zom", "machine_all_players", "pain", "pain", undefined, 40);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer_zom", "machine_all_players", "noise", "noise", undefined, 40);
}

arkshouldignoreplayer(var_0) {
  if(isDefined(level.zmplayerinzomboniroom) && level.zmplayerinzomboniroom == var_0) {
    return 1;
  } else if(isDefined(level.sqplayersteleporting) && level.sqplayersteleporting.size > 0 && common_scripts\utility::array_contains(level.sqplayersteleporting, var_0)) {
    return 1;
  } else if(isDefined(var_0.onisland) && var_0.onisland) {
    return 1;
  } else if(var_0 playerisincage()) {
    return 1;
  }

  return 0;
}

playerintoxicate(var_0, var_1) {
  if(maps\mp\zombies\_util::isplayerinfected(self) || maps\mp\zombies\_util::isplayerinlaststand(self)) {
    return;
  }
  self endon("disconnect");
  self notify("playerIntoxicate");
  self endon("playerIntoxicate");

  if(isDefined(var_0)) {
    wait(var_0);
  }

  if(!isDefined(var_1)) {
    var_1 = 60;
  }

  thread maps\mp\mp_zombie_ark_aud::drink_rum();
  self.intoxicated = 1;
  self notify("update_ground_ref_ent");
  self setclientomnvar("ui_zm_ee_bool2", 1);
  thread playerintoxicatedhandlemovement(var_1);
  thread playerintoxicatedrotateground(var_1);
  thread playerintoxicatedhandlescreen(var_1);
  thread playerintoxicatedhandlelaststand();
  updateintoxicatedentities();
  common_scripts\utility::waittill_notify_or_timeout("death", var_1);
  playerintoxicatefinish();
  self notify("playerIntociateComplete");
}

playerintoxicatefinish() {
  self setclientomnvar("ui_zm_ee_bool2", 0);
  self.intoxicated = undefined;
  thread maps\mp\mp_zombie_ark_aud::rum_wears_off(self);
  updateintoxicatedentities();

  if(playerhasitem("rum")) {
    playertakeitem("rum");
  }
}

playerintoxicatedhandlelaststand() {
  self endon("playerIntociateComplete");
  self endon("death");
  self endon("disconnect");
  var_0 = common_scripts\utility::waittill_any_return_no_endon_death("player_infected", "enter_last_stand");
  self notify("playerIntoxicate");
  thread playerintoxicatedhandlemovement(3);
  thread playerintoxicatedrotateground(3);

  if(var_0 == "enter_last_stand") {
    thread playerintoxicatedhandlescreen(3);
  }

  wait 3;
  playerintoxicatefinish();
}

playerstopintoxication() {
  if(maps\mp\zombies\_util::is_true(self.intoxicated)) {
    thread playerintoxicate(undefined, 3);
    thread maps\mp\mp_zombie_ark_aud::rum_wears_off(self);
  }
}

stopallplayersintoxication() {
  foreach(var_1 in level.players) {
    var_1 playerstopintoxication();
  }
}

resetallplayersintoxication() {
  foreach(var_1 in level.players) {
    var_1 playergiveitem("rum");
  }
}

playerisintoxicated() {
  return maps\mp\zombies\_util::is_true(self.intoxicated);
}

playerintoxicatedhandlescreen(var_0) {
  self endon("disconnect");
  self endon("player_infected");
  self notify("playerIntoxicatedHandleScreen");
  self endon("playerIntoxicatedHandleScreen");
  self visionsetpostapplyforplayer("mp_zombie_ark_intoxicated", 1);
  self lightsetoverrideenableforplayer("mp_zombie_ark_intoxicated", 1);
  common_scripts\utility::waittill_notify_or_timeout("death", var_0);
  self visionsetpostapplyforplayer("", 1);
  self lightsetoverrideenableforplayer(1);
}

playerintoxicatedhandlemovement(var_0) {
  self endon("disconnect");
  self notify("playerIntoxicatedHandleMovement");
  self endon("playerIntoxicatedHandleMovement");

  if(!isDefined(self.exomovementoff)) {
    maps\mp\zombies\_util::playerallowextendedsprint(0, "intoxicated");
    maps\mp\zombies\_util::playerallowlightweight(0, "intoxicated");
    maps\mp\_utility::playerallowdodge(0, "intoxicated");
    self.exomovementoff = 1;
    self.oldmovescaler = self.movespeedscaler;
    self.movespeedscaler = 0.75;
    maps\mp\gametypes\_weapons::updatemovespeedscale();
  }

  var_1 = gettime() + var_0 * 1000;
  var_2 = 5000;

  while(gettime() < var_1) {
    if(!isDefined(self.intoxicatedcanexotime) && (self ishighjumping() || self isdodging() || self ispowersliding())) {
      maps\mp\_utility::playerallowpowerslide(0, "intoxicated");
      self.intoxicatedcanexotime = gettime() + var_2;
    } else if(isDefined(self.intoxicatedcanexotime) && gettime() > self.intoxicatedcanexotime) {
      maps\mp\_utility::playerallowpowerslide(1, "intoxicated");
      self.intoxicatedcanexotime = undefined;
    }

    waitframe();
  }

  maps\mp\zombies\_util::playerallowextendedsprint(1, "intoxicated");
  maps\mp\zombies\_util::playerallowlightweight(1, "intoxicated");
  maps\mp\_utility::playerallowdodge(1, "intoxicated");

  if(isDefined(self.intoxicatedcanexotime)) {
    maps\mp\_utility::playerallowhighjump(1, "intoxicated");
    maps\mp\_utility::playerallowpowerslide(1, "intoxicated");
    self.intoxicatedcanexotime = undefined;
  }

  self.movespeedscaler = self.oldmovescaler;
  maps\mp\gametypes\_weapons::updatemovespeedscale();
  self.oldmovescaler = undefined;
  self.exomovementoff = undefined;
}

playerintoxicatedrotateground(var_0) {
  self endon("disconnect");
  self notify("playerIntoxicatedRotateGround");
  self endon("playerIntoxicatedRotateGround");

  if(!isDefined(self.groundref)) {
    self.groundref = spawn("script_model", (0, 0, 0));
  }

  self playersetgroundreferenceent(self.groundref);
  var_1 = 20;
  var_2 = 30;
  var_3 = 25;
  var_4 = 3.0;

  for(var_5 = int(var_0 / var_4); var_5 > 0; var_5--) {
    var_6 = randomfloatrange(-1 * var_1, var_1);
    var_7 = randomfloatrange(-1 * var_2, var_2);
    var_8 = randomfloatrange(-1 * var_3, var_3);
    var_9 = (var_6, var_7, var_8);
    var_10 = randomfloat(var_4 / 2.0);
    var_11 = randomfloat(var_4 / 2.0);

    if(var_5 == 1 || self getstance() == "prone") {
      var_9 = (0, 0, 0);
    }

    self.groundref rotateto(var_9, var_4, var_10, var_11);
    wait(var_4);
  }

  self playersetgroundreferenceent(undefined);
  self notify("update_ground_ref_ent");
  self.groundref.angles = (0, 0, 0);
}

playerintoxicatedhudcountdown(var_0) {
  self endon("disconnect");
  self notify("playerIntoxicatedHudCountdown");
  self endon("playerIntoxicatedHudCountdown");

  if(!isDefined(self.intoxicatedtimer)) {
    self.intoxicatedtimer = maps\mp\gametypes\_hud_util::createfontstring("hudbig", 1.5);
    self.intoxicatedtimer maps\mp\gametypes\_hud_util::setpoint("CENTER TOP", undefined, 0, 20);
    self.intoxicatedtimer.sort = 3;
    self.intoxicatedtimer.label = &"ZOMBIES_INFECTED_TIMER";
  }

  if(var_0 > 0) {
    self.intoxicatedtimer settimer(var_0);
  }

  common_scripts\utility::waittill_notify_or_timeout("death", var_0);

  if(isDefined(self.intoxicatedtimer)) {
    self.intoxicatedtimer destroy();
  }

  self.intoxicatedtimer = undefined;
}

entitysetintoxicatedvisiononly(var_0) {
  if(!isDefined(level.sqintoxicatedents)) {
    level.sqintoxicatedents = [];
  }

  if(var_0) {
    level.sqintoxicatedents[level.sqintoxicatedents.size] = self;
  } else {
    level.sqintoxicatedents = common_scripts\utility::array_remove(level.sqintoxicatedents, self);
  }

  updateintoxicatedentities();
}

updateintoxicatedentities() {
  if(!isDefined(level.sqintoxicatedents)) {
    level.sqintoxicatedents = [];
  }

  foreach(var_1 in level.sqintoxicatedents) {
    if(!isDefined(var_1)) {
      continue;
    }
    var_1 hide();

    if(isDefined(level.players)) {
      foreach(var_3 in level.players) {
        if(var_3 playerisintoxicated()) {
          var_1 showtoplayer(var_3);
        }
      }
    }
  }
}

weapondisposallogic() {
  var_0 = getent("weaponDisposalUse", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = getent("sqWeaponDisposalSign", "targetname");

  if(isDefined(var_1)) {
    var_1 hide();
  }

  level waittill("main_stage1_over");

  if(isDefined(var_1)) {
    var_1 show();
  }

  var_0.angles = (0, 0, 0);
  setupweapontoitemmapping();

  if(!isDefined(level.sqarm)) {
    level.sqarm = getent("sqArm", "targetname");

    if(!isDefined(level.sqarm)) {
      return;
    }
  }

  setuparmstates();
  level thread handlearm(var_0);

  for(;;) {
    for(var_2 = undefined; !isDefined(var_2); var_2 = waittillmachineused(var_0)) {
      waittillarmready();
      wait 0.5;
    }

    var_3 = var_2 maps\mp\zombies\_wall_buys::getweaponslistprimariesminusalts();

    if(var_2 playerhasvalidweapon() && var_3.size > 1) {
      var_4 = var_2 getcurrentprimaryweapon();
      var_2 takeweapon(var_4);
      var_3 = var_2 maps\mp\zombies\_wall_buys::getweaponslistprimariesminusalts();

      foreach(var_6 in var_3) {
        if(var_6 != "" && var_6 != "none") {
          var_2 switchtoweapon(var_6);
        }
      }

      var_8 = getweaponbasename(var_4);
      var_9 = addweapontodisposallist(var_8);
      var_10 = maps\mp\zombies\_wall_buys::findholomodel(var_8);
      var_11 = spawn("script_model", (0, 0, 0));
      var_11 setModel(var_10);
      var_11 linktosynchronizedparent(level.sqarm, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
      level thread changearmstate("take", var_0);
      level.sqarm waittillmatch("arm_notetrack", "item_swap");
      var_12 = getmodelforitem(var_9);

      if(isDefined(var_12)) {
        var_11 setModel(var_12);
        var_13 = getoriginoffsetforitem(var_9);
        var_14 = getanglesoffsetforitem(var_9);
        var_11 linktosynchronizedparent(level.sqarm, "tag_weapon_right", var_13, var_14);
        var_15 = zombiearmplaysqvo("item");
      } else {
        var_15 = zombiearmplaysqvo("credits");
        var_11 delete();
      }

      level.sqarm waittillmatch("arm_notetrack", "end");
      var_15 = 0;

      if(isDefined(var_12)) {
        var_15 = zombiearmplaysqvo("item");
      } else {
        var_15 = zombiearmplaysqvo("credits");
      }

      if(isDefined(var_9) && var_9 == "rum_bottle") {
        level thread launchrumbottle(var_11);
      } else if(isDefined(var_12)) {
        var_11 delete();
      }

      if(isDefined(var_2)) {
        var_2 thread playergiveweapondisposalprize(var_9, !var_15);
      }
    }

    wait 1;
  }
}

setuparmstates() {
  level.const_sq_arm_idle = 0;
  level.const_sq_arm_thrash_enter = 1;
  level.const_sq_arm_thrash_exit = 2;
  level.const_sq_arm_thrash_loop = 3;
  level.const_sq_arm_thrash_to_gimme = 4;
  level.const_sq_arm_gimme_to_thrash = 5;
  level.const_sq_arm_pain = 6;
  level.const_sq_arm_pain_retreat = 7;
  level.const_sq_arm_gimme_loop = 8;
  level.const_sq_arm_take_weapon = 9;
  level.const_sq_arm_give_loop = 10;
  level.const_sq_arm_give_finish = 11;
  setarmtoidle();
}

handlearm(var_0) {
  var_1 = 1000;
  var_2 = 5;
  level.sqarm setModel("zom_civ_ruban_male_r_arm_slice_scripted");
  level.sqarm setCanDamage(1);
  level.sqarm setdamagecallbackon(1);
  level.sqarm.damagecallback = ::armdamaged;
  level.sqarm.health = 9999;
  level.sqarm.maxhealth = level.sqarm.health;
  level.sqarm.currentdamage = 0;
  level.sqarm thread armhandlehappiness();

  for(;;) {
    var_3 = level.sqarm common_scripts\utility::waittill_any_return_no_endon_death("handlePain", "handleThrash", "handleGimme", "handleEnter", "handleExit");
    var_4 = getarmstate();

    if(var_3 == "handlePain" && armstateislooping(var_4)) {
      if(level.sqarm.currentdamage >= var_1) {
        changearmstate("painLeave", var_0);
        wait(var_2);
        changearmstate("enter", var_0);
        level.sqarm.currentdamage = 0;
      } else {
        changearmstate("pain", var_0);
      }

      continue;
    }

    if(var_3 == "handleEnter") {
      level.sqarm show();
      changearmstate("enter", var_0);
      continue;
    }

    if(var_3 == "handleExit") {
      changearmstate("exit", var_0);
      level.sqarm ghost();
      level.sqarm.currentdamage = 0;
      continue;
    }

    if(var_3 == "handleGimme") {
      changearmstate("gimme", var_0);
      continue;
    }

    if(var_3 == "handleThrash") {
      changearmstate("thrash", var_0);
    }
  }
}

armdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_1) && isPlayer(var_1)) {
    self.currentdamage = self.currentdamage + var_2;
    self notify("handlePain");
  }
}

armhandlehappiness() {
  var_0 = 360000;
  var_1 = 22500;

  for(;;) {
    var_2 = getarmstate();

    if(armisidle(var_2)) {
      foreach(var_4 in level.players) {
        if(maps\mp\zombies\_util::isplayerinlaststand(var_4) || !isalive(var_4)) {
          continue;
        }
        var_5 = distancesquared(level.sqarm.origin, var_4.origin);

        if(var_5 <= var_0) {
          level.sqarm notify("handleEnter");
          break;
        }
      }
    } else if(armisthrashing(var_2)) {
      doarmnoise();
      var_7 = 1;

      foreach(var_4 in level.players) {
        if(maps\mp\zombies\_util::isplayerinlaststand(var_4) || !isalive(var_4)) {
          continue;
        }
        var_5 = distancesquared(level.sqarm.origin, var_4.origin);

        if(var_5 <= var_1) {
          level.sqarm notify("handleGimme");
          level thread doarmfirstseenvo(var_4);
          var_7 = 0;
          break;
        } else if(var_5 <= var_0) {
          var_7 = 0;
        }
      }

      if(var_7) {
        level.sqarm notify("handleExit");
      }
    } else if(armstateisready(var_2)) {
      doarmnoise();
      var_7 = 1;

      foreach(var_4 in level.players) {
        if(maps\mp\zombies\_util::isplayerinlaststand(var_4) || !isalive(var_4)) {
          continue;
        }
        var_5 = distancesquared(level.sqarm.origin, var_4.origin);

        if(var_5 <= var_1) {
          var_7 = 0;
          break;
        }
      }

      if(var_7) {
        level.sqarm notify("handleThrash");
      }
    }

    wait 1;
  }
}

doarmnoise() {
  if(!isDefined(level.sqarmfirstseenplayed)) {
    return;
  }
  if(maps\mp\zombies\_zombies_audio_dlc3::anyplayersspeaking()) {
    return;
  }
  if(!isDefined(level.sqarm.noisedebouncevo)) {
    level.sqarm.noisedebouncevo = 0;
  }

  if(level.sqarm.noisedebouncevo < gettime()) {
    level.sqarm.noisedebouncevo = gettime() + randomfloatrange(10, 20) * 1000;
    zombiearmplaysqvo("noise");
  }
}

doarmfirstseenvo(var_0) {
  var_0 endon("disconnect");

  if(!isDefined(level.sqarmfirstseenplayed) && var_0 playerplaysqvo(14)) {
    level.sqarmfirstseenplayed = 1;
    waitframe();
    waittilldonespeaking(var_0);
    zombiearmplaysqvo("gimme");
  }
}

waittillmachineused(var_0) {
  level.sqarm endon("pain");
  level.sqarm endon("thrash");
  var_1 = var_0 maps\mp\zombies\_zombies_sidequests::fake_use("arm_used", undefined, undefined, undefined, 70, 1);
  return var_1;
}

waittillarmready() {
  if(!armstateisready(level.sqarm.state)) {
    level.sqarm waittill("gimme");
  }
}

changearmstate(var_0, var_1) {
  if(var_0 == "enter") {
    doarmanim(var_1, "zom_weap_arm_thrash_enter", level.const_sq_arm_thrash_enter, 1);
    doarmanim(var_1, "zom_weap_arm_thrash_loop", level.const_sq_arm_thrash_loop, 0);
  } else if(var_0 == "exit") {
    doarmanim(var_1, "zom_weap_arm_thrash_exit", level.const_sq_arm_thrash_exit, 1);
    setarmtoidle();
  } else if(var_0 == "gimme") {
    doarmanim(var_1, "zom_weap_arm_thrash_to_gimme", level.const_sq_arm_thrash_to_gimme, 1);
    doarmanim(var_1, "zom_weap_arm_gimme_loop", level.const_sq_arm_gimme_loop, 0);
    level.sqarm notify("gimme");
    zombiearmplaysqvo("gimme");
  } else if(var_0 == "thrash") {
    level.sqarm notify("thrash");
    doarmanim(var_1, "zom_weap_arm_gimme_to_thrash", level.const_sq_arm_gimme_to_thrash, 1);
    doarmanim(var_1, "zom_weap_arm_thrash_loop", level.const_sq_arm_thrash_loop, 0);
  } else if(var_0 == "pain") {
    var_2 = getarmstate();
    var_3 = getarmanimref();
    level.sqarm notify("pain");
    var_4 = randomintrange(1, 3);
    zombiearmplaysqvo("pain");
    doarmanim(var_1, "zom_weap_arm_pain_0" + var_4, level.const_sq_arm_pain, 1);

    if(armstateisready(var_2)) {
      doarmanim(var_1, "zom_weap_arm_thrash_to_gimme", level.const_sq_arm_thrash_to_gimme, 1);
    }

    doarmanim(var_1, var_3, var_2, 0);

    if(armstateisready(var_2)) {
      level.sqarm notify("gimme");
      return;
    }
  } else if(var_0 == "painLeave") {
    var_2 = getarmstate();
    level.sqarm notify("pain");
    var_4 = randomintrange(1, 3);
    doarmanim(var_1, "zom_weap_arm_pain_retreat_0" + var_4, level.const_sq_arm_pain_retreat, 1);
    setarmtoidle();
  } else if(var_0 == "take") {
    zombiearmplaysqvo("take");
    doarmanim(var_1, "zom_weap_arm_take_weapon", level.const_sq_arm_take_weapon, 1);
    var_4 = randomintrange(1, 5);
    doarmanim(var_1, "zom_weap_arm_give_finish_0" + var_4, level.const_sq_arm_give_finish, 1);
    doarmanim(var_1, "zom_weap_arm_gimme_loop", level.const_sq_arm_gimme_loop, 0);
    level.sqarm notify("gimme");
  }
}

armstateislooping(var_0) {
  return var_0 == level.const_sq_arm_gimme_loop || var_0 == level.const_sq_arm_thrash_loop;
}

armisidle(var_0) {
  return var_0 == level.const_sq_arm_idle;
}

armisthrashing(var_0) {
  return var_0 == level.const_sq_arm_thrash_loop;
}

armstateisready(var_0) {
  return var_0 == level.const_sq_arm_gimme_loop;
}

getarmstate() {
  return level.sqarm.state;
}

getarmanimref() {
  return level.sqarm.animref;
}

setarmtoidle() {
  level.sqarm.state = level.const_sq_arm_idle;
  level.sqarm.animref = "";
}

doarmanim(var_0, var_1, var_2, var_3) {
  level.sqarm.state = var_2;
  level.sqarm.animref = var_1;
  level.sqarm scriptmodelplayanimdeltamotionfrompos(var_1, var_0.origin, var_0.angles, "arm_notetrack");

  if(var_3) {
    level.sqarm waittillmatch("arm_notetrack", "end");
  }
}

getmodelforitem(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "rum_bottle":
      return "zark_bottle_01";
    case "hook":
      return "zark_fishing_hook_01";
    case "line":
      return "zark_fishing_line_01";
    case "reel":
      return "zark_fishing_reel_01";
    case "c4":
      return "weapon_c4_mp";
  }
}

getoriginoffsetforitem(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "rum_bottle":
      return (5, -1, 0);
    case "hook":
      return (2, 0, 5);
    case "line":
      return (5, -2, 1);
    case "reel":
      return (5, -2, 1);
    case "c4":
      return (5, 0, 4);
  }
}

getanglesoffsetforitem(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "rum_bottle":
      return (0, 0, 0);
    case "hook":
      return (0, 0, 90);
    case "line":
      return (0, 0, 0);
    case "reel":
      return (0, 0, 0);
    case "c4":
      return (0, 0, 90);
  }
}

launchrumbottle(var_0) {
  setitemascomplete("rum_bottle");
  thread maps\mp\mp_zombie_ark_aud::throw_rum_bottle(var_0);
  var_0 unlink();
  var_1 = (500, 0, 0);
  var_0 physicslaunchserver(var_0.origin, var_1);
  var_0 common_scripts\utility::waittill_notify_or_timeout("physics_finished", 5);
  var_0 physicsstop();

  for(;;) {
    var_2 = var_0 maps\mp\zombies\_zombies_sidequests::fake_use("rum_used", undefined, undefined, undefined, 40, 1);
    var_2 playergiveitem("rum");
    wait 0.5;
  }
}

playergiveweapondisposalprize(var_0, var_1) {
  level notify("playerGiveWeaponDisposalPrize");
  level endon("playerGiveWeaponDisposalPrize");

  if(!isDefined(var_0)) {
    maps\mp\gametypes\zombies::givepointsforevent("weapon_disposal", 200, 1);

    if(var_1) {
      announcerinworldplaysqvowaittilldone("weap_dis");
      announcerinworldplaysqvowaittilldone("weap_dis_cred");
    }
  } else {
    if(var_0 != "rum_bottle") {
      playergiveitem(var_0);
      thread maps\mp\mp_zombie_ark_aud::get_weapon_disposal_item(var_0);
    }

    if(var_1) {
      announcerinworldplaysqvowaittilldone("weap_dis");
      announcerinworldplaysqvowaittilldone("weap_dis_prize");
    }
  }
}

addweapontodisposallist(var_0) {
  var_1 = 2;

  if(!common_scripts\utility::array_contains(level.sqweaponsdisposed, var_0)) {
    level.sqweaponsdisposed[level.sqweaponsdisposed.size] = var_0;

    if(level.sqweaponsdisposed.size % var_1 == 0) {
      return getnextweapondisposalitem();
    }
  }
}

getnextweapondisposalitem() {
  for(var_0 = 0; var_0 < level.sqweapondisposalitems.size; var_0++) {
    var_1 = level.sqweapondisposalitems[var_0];

    if(!isitemcomplete(var_1) && !anyplayerhasitem(var_1)) {
      return var_1;
    }
  }
}

isitemcomplete(var_0) {
  return common_scripts\utility::array_contains(level.sqitemscomplete, var_0);
}

setitemascomplete(var_0) {
  level.sqitemscomplete[level.sqitemscomplete.size] = var_0;
}

setupweapontoitemmapping() {
  level.sqweaponsdisposed = [];
  level.sqweapondisposalitems = [];
  level.sqweapondisposalitems[level.sqweapondisposalitems.size] = "rum_bottle";
  level.sqweapondisposalitems[level.sqweapondisposalitems.size] = "reel";
  level.sqweapondisposalitems[level.sqweapondisposalitems.size] = "line";
  level.sqweapondisposalitems[level.sqweapondisposalitems.size] = "hook";
  level.sqweapondisposalitems[level.sqweapondisposalitems.size] = "c4";
  level.sqitemscomplete = [];
}

playerhasvalidweapon() {
  var_0 = self getcurrentprimaryweapon();
  return weaponisvalid(var_0);
}

weaponisvalid(var_0) {
  return var_0 != "" && var_0 != "none" && !maps\mp\zombies\_util::iszombiekillstreakweapon(var_0) && !maps\mp\zombies\_util::isrippedturretweapon(var_0) && !maps\mp\zombies\_util::iszombieequipment(var_0);
}

playergiveitem(var_0) {
  if(var_0 == "rum") {
    if(!maps\mp\zombies\_util::isplayerinfected(self) && !maps\mp\zombies\_util::isplayerinlaststand(self)) {
      thread playerintoxicate(0.5);
    }

    return;
  }

  if(!isDefined(self.sqplayedfoundfirstcode) && var_0 == "code" && playerplaysqvo(15)) {
    self.sqplayedfoundfirstcode = 1;
  }

  if(isDefined(self.inventoryitem)) {
    if(self.inventoryitem == "code") {
      return;
    }
    playertakeitem(self.inventoryitem);
  }

  self.inventoryitem = var_0;
  var_1 = inventoryitemgetid(var_0);
  self setclientomnvar("ui_zm_ee_int", var_1);
}

playerhasitem(var_0) {
  return isDefined(self.inventoryitem) && self.inventoryitem == var_0;
}

playerhasanyitem() {
  return isDefined(self.inventoryitem);
}

playertakeitem(var_0) {
  if(isDefined(self.inventoryitem) && self.inventoryitem == var_0) {
    self.inventoryitem = undefined;
    self setclientomnvar("ui_zm_ee_int", 0);
  }
}

inventoryitemgetid(var_0) {
  switch (var_0) {
    case "code":
      return 1;
    case "shovel":
      return 2;
    case "c4":
      return 3;
    case "reel":
      return 4;
    case "hook":
      return 5;
    case "line":
      return 6;
    case "teleportEquipment":
      return 7;
    case "eye":
      return 8;
    case "fish":
      return 9;
    case "switch":
    default:
      return 10;
  }
}

init_fishing_sidequest() {
  setupfishingitems();
}

sidequest_fishing_logic() {
  maps\mp\zombies\_zombies_sidequests::stage_start("fishing", "stage1");
  level waittill("fishing_stage1_over");
  var_0 = getent("sqPole2", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 setcursorhint("HINT_NOICON");

  for(;;) {
    var_0 sethintstring(&"ZOMBIE_ARK_SQ_FISH");
    var_0 setsecondaryhintstring(&"ZOMBIES_COST_100");
    var_0 makeusable();
    var_0 waittill("trigger", var_1);
    var_0 makeunusable();

    if(!var_1 maps\mp\gametypes\zombies::attempttobuy(100)) {
      wait 1;
      continue;
    }

    var_1 thread maps\mp\mp_zombie_ark_aud::fishing_cast_line();
    var_0 scriptmodelplayanim("zark_fishing_pose_fish", "fishing_notetrack");
    var_0 waittillmatch("fishing_notetrack", "attach_item");
    var_1 thread maps\mp\mp_zombie_ark_aud::fishing_retrieve_line();
    level thread fishonsounds(var_1);
    var_2 = getrandomfishingitem();
    var_3 = putitemonhook(var_2, var_0);
    var_0 waittillmatch("fishing_notetrack", "item_reachable");

    if(isDefined(var_1)) {
      var_0 sethintstring(&"ZOMBIE_ARK_SQ_FISH_GRAB");
      var_0 setsecondaryhintstring("");
      var_0 makeusable();
      var_0.owner = var_1;
      var_0 sethintstringvisibleonlytoowner(1);
    }

    var_4 = waittillpickedupordonewiggling(var_0);
    var_0 scriptmodelplayanim("zark_fishing_pose_finish", "fishing_notetrack");
    var_0 makeunusable();
    var_0 sethintstringvisibleonlytoowner(0);
    var_0.owner = undefined;

    if(!isDefined(var_4) && isDefined(var_1) && var_2.type != "junk") {
      if(var_2.type == "inventory") {
        var_1 playergiveitem(var_2.item);
        var_1 thread maps\mp\mp_zombie_ark_aud::fishing_grab_item(var_2.item);
      } else if(var_2.type == "credits") {
        var_1 maps\mp\gametypes\zombies::givepointsforevent("fishing", var_2.value, 1);
        var_1 playlocalsound("interact_credit_machine");
      } else if(var_2.type == "ammo") {
        var_1 playergiveammo();
        var_1 thread maps\mp\mp_zombie_ark_aud::fishing_grab_item(var_2.item);
      }

      var_3 delete();
    } else {
      level thread launchanddelete(var_3, var_2, var_0);
      var_1 thread maps\mp\mp_zombie_ark_aud::fishing_drop_item();
    }

    var_0 waittillmatch("fishing_notetrack", "end");
    var_0 scriptmodelplayanim("zark_fishing_pose_idle", "fishing_notetrack");
    waitframe();
  }
}

fishinghint() {
  level endon("code1_stage2_over");
  level waittill("code1_stage1_over");
  var_0 = getent("sqPole2", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = 90000;

  for(;;) {
    foreach(var_3 in level.players) {
      var_4 = distancesquared(var_0.origin, var_3.origin);

      if(var_4 < var_1) {
        if(announcerozglobalplaysq(13)) {
          break;
        }
      }
    }

    wait 0.1;
  }
}

fishonsounds(var_0) {
  var_1 = common_scripts\utility::getstruct("sqFishingSplash", "targetname");

  if(isDefined(var_0) && !isDefined(var_0.sqfishinggotoneplayed)) {
    var_0 playerplaysqvo(13, undefined, 1);

    if(isDefined(var_0)) {
      var_0.sqfishinggotoneplayed = 1;
    }
  } else {
    wait 1.5;
  }

  if(isDefined(var_1)) {
    playFX(common_scripts\utility::getfx("sq_fishing_splash"), var_1.origin);
  }
}

putitemonhook(var_0, var_1) {
  var_2 = var_1 gettagorigin("tag_attach");
  var_3 = spawn("script_model", var_2);
  var_3 setModel(var_0.model);
  var_3 linkto(var_1, "tag_attach", var_0.offset, var_0.angles);

  if(var_0.item == "fish") {
    var_3 thread fishwiggle();
  }

  return var_3;
}

fishwiggle() {
  waitframe();
  self scriptmodelplayanim("zark_red_herring_wiggle", "wiggle_notetrack");
}

playergiveammo() {
  self endon("death");
  self endon("disconnect");
  var_0 = self getcurrentprimaryweapon();

  if(!weaponisvalid(var_0)) {
    var_0 = undefined;
    var_1 = self getweaponslistprimaries();

    foreach(var_3 in var_1) {
      if(weaponisvalid(var_3)) {
        var_0 = var_3;
        break;
      }
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  if(issubstr(var_0, "em1")) {
    waittillframeend;
    var_5 = maps\mp\zombies\_util::playergetem1ammo();
    var_6 = maps\mp\gametypes\zombies::getem1maxammo();

    if(var_5 >= var_6) {
      return;
    }
    var_5 = getnewammoamount(var_5, var_6);
    maps\mp\zombies\_util::playerrecordem1ammo(var_5);
    maps\mp\gametypes\zombies::playerupdateem1omnvar();
  } else {
    var_5 = self getweaponammostock(var_0);
    var_6 = weaponmaxammo(var_0);

    if(var_5 < var_6) {
      var_5 = getnewammoamount(var_5, var_6);
      self setweaponammostock(var_0, var_5);
      return;
    }

    var_5 = self getweaponammoclip(var_0, "right");
    var_6 = weaponclipsize(var_0);

    if(var_5 < var_6) {
      var_5 = getnewammoamount(var_5, var_6);
      self setweaponammoclip(var_0, var_5, "right");
    }

    if(issubstr(var_0, "akimbo")) {
      var_5 = self getweaponammoclip(var_0, "left");

      if(var_5 < var_6) {
        var_5 = getnewammoamount(var_5, var_6);
        self setweaponammoclip(var_0, var_5, "left");
      }
    }
  }
}

getnewammoamount(var_0, var_1) {
  var_2 = 0.1;
  var_3 = int(max(1, var_1 * var_2));

  if(var_0 + var_3 <= var_1) {
    var_0 = var_0 + var_3;
  } else if(var_0 < var_1) {
    var_0 = var_1;
  }

  return var_0;
}

launchanddelete(var_0, var_1, var_2) {
  var_0 unlink();
  var_3 = vectornormalize(var_0.origin - var_2.origin) * var_1.impulse;
  var_0 physicslaunchclient(var_2.origin, var_3);
  wait 2;
  var_0 delete();
}

waittillpickedupordonewiggling(var_0) {
  var_0 endon("trigger");
  var_0 waittillmatch("fishing_notetrack", "end");
  return 1;
}

setupfishingitems() {
  level.sqfishingitem = [];
  level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("shovel", "zark_tool_shovel_01", "inventory", undefined, 20, (-10, 45, -60), (-2, 5, -10.2), 12);
  level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("fish", "zark_fish_red_herring_01_anim", "inventory", undefined, 20, (0, 0, 0), (0, 0, 0), 9);
  level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("boot", "zark_rubber_boot_01", "junk", undefined, 5, (-20, 90, 0), (1, 1, -14), 7);
  level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("arm", "zom_civ_ruban_male_r_arm_phys", "junk", undefined, 200, (-90, 0, 0), (0, 1, 2), 7);
  level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("leg", "zom_civ_ruban_male_r_leg_phys", "junk", undefined, 200, (-90, 0, 0), (0, 0, 7), 7);
  level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("head", "zom_civ_urban_male_head_phys", "junk", undefined, 200, (-105, -105, 0), (4, 1, -5.3), 7);
  level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("vest", "zark_life_vest_01", "junk", undefined, 1000, (0, -87, 85), (2, 0, -15), 7);
  level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("buoy", "zark_buoy_01", "junk", undefined, 1000, (0, 0, 0), (2.2, 0, -1.5), 7);
  level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("ammo", "zark_grenadebag_01", "ammo", undefined, 20, (180, 0, 90), (0, 2, -9), 10);
  level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("credits1", "zark_money_01", "credits", 50, 1000, (0, 30, -20), (-2, 0, -6.3), 20);
  level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("credits2", "zark_money_01", "credits", 200, 1000, (0, 30, -20), (-2, 0, -6.3), 5);
  level.sqfishingitem[level.sqfishingitem.size] = addnewfishingitem("credits3", "zark_money_01", "credits", 500, 1000, (0, 30, -20), (-2, 0, -6.3), 2);
}

addnewfishingitem(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(level.sqfishingitemsmaxweight)) {
    level.sqfishingitemsmaxweight = 0;
  }

  var_8 = level.sqfishingitemsmaxweight;
  level.sqfishingitemsmaxweight = level.sqfishingitemsmaxweight + var_7;
  var_9 = level.sqfishingitemsmaxweight;
  var_10 = spawnStruct();
  var_10.item = var_0;
  var_10.model = var_1;
  var_10.type = var_2;
  var_10.startweight = var_8;
  var_10.endweight = var_9;
  var_10.value = var_3;
  var_10.impulse = var_4;
  var_10.angles = var_5;
  var_10.offset = var_6;
  return var_10;
}

getrandomfishingitem() {
  var_0 = randomfloat(level.sqfishingitemsmaxweight);

  foreach(var_2 in level.sqfishingitem) {
    if(var_0 >= var_2.startweight && var_0 < var_2.endweight) {
      return var_2;
    }
  }

  return level.sqfishingitem[randomint(level.sqfishingitem.size)];
}

fishing_stage1_init() {}

fishing_stage1_logic() {
  var_0 = getent("sqPole2", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  while(!var_1 || !var_2 || !var_3) {
    var_5 = var_0 maps\mp\zombies\_zombies_sidequests::fake_use("poleUse");
    var_6 = 0;

    if(!var_2 && var_5 playerhasitem("reel")) {
      var_6 = 1;
      var_5 playertakeitem("reel");
      setitemascomplete("reel");
      var_5 thread maps\mp\mp_zombie_ark_aud::use_fishing_item("reel");
      var_2 = 1;
      var_0 setModel("zark_fishing_pole_reel_01");
    }

    if(var_2 && !var_1 && var_5 playerhasitem("line")) {
      var_6 = 1;
      var_5 playertakeitem("line");
      setitemascomplete("line");
      var_5 thread maps\mp\mp_zombie_ark_aud::use_fishing_item("line");
      var_1 = 1;
      var_0 setModel("zark_fishing_pole_reel_line_01");
    }

    if(var_2 && var_1 && !var_3 && var_5 playerhasitem("hook")) {
      var_6 = 1;
      var_5 playertakeitem("hook");
      setitemascomplete("hook");
      var_5 thread maps\mp\mp_zombie_ark_aud::use_fishing_item("hook");
      var_3 = 1;
      var_0 setModel("zark_fishing_gear_complete_01");
      var_0 scriptmodelplayanim("zark_fishing_pose_idle", "fishing_notetrack");
    }

    if(var_6) {
      if(var_3 && var_2 && var_1) {
        var_5 playerplaysqvo(12);
      }

      var_4 = 1;
    } else if(!var_4) {
      var_5 playerplaysqvo(11);
      var_4 = 1;
    }

    wait 1;
  }

  maps\mp\zombies\_zombies_sidequests::stage_completed("fishing", "stage1");
}

fishing_stage1_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Fishing Pole Assembled");
}

init_main_sidequest() {}

sidequest_logic() {
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage1");
  level waittill("main_stage1_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage2");
  thread maps\mp\zombies\_zombies_sidequests::sidequest_start("fishing");
  thread maps\mp\zombies\_zombies_sidequests::sidequest_start("code4");
  level waittill("sidequest_code4_complete");
  thread maps\mp\zombies\_zombies_sidequests::sidequest_start("code2");
  level waittill("sidequest_code2_complete");
  thread maps\mp\zombies\_zombies_sidequests::sidequest_start("code1");
  level waittill("sidequest_code1_complete");
  thread maps\mp\zombies\_zombies_sidequests::sidequest_start("code3");
  level waittill("sidequest_code3_complete");
  level waittill("main_stage2_over");
}

generic_stage_start() {}

generic_stage_complete() {}

complete_sidequest() {}

stage1_init() {}

stage1_logic() {
  level.zmplayeraltteleport = ::zmplayeraltteleport;
  common_scripts\utility::flag_wait("zomboni_room");
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage1");
}

zmplayeraltteleport(var_0, var_1, var_2) {
  if(maps\mp\zombies\_util::is_true(level.zmbsqobstaclecourserunning)) {
    level notify("securityFieldTouched");
  }

  var_3 = getent("zomboni_room_volume", "targetname");
  var_4 = getent("sqCageVolume", "targetname");
  var_5 = 0;
  var_6 = 2;

  if(isDefined(level.zmplayerinzomboniroom) && self == level.zmplayerinzomboniroom) {
    return 1;
  } else if(isDefined(var_3) && ispointinvolume(var_0, var_3)) {
    if(!common_scripts\utility::flag("zomboni_room") && !isDefined(level.zmplayerinzomboniroom)) {
      var_7 = common_scripts\utility::getstructarray("zomboni_room_teleport", "targetname");

      foreach(var_9 in var_7) {
        if(capsuletracepassed(var_9.origin + (0, 0, 5), 15, 60, self, 1)) {
          thread playerinzomboniroom(var_9);
          break;
        }

        var_5++;

        if(var_5 >= var_6) {
          waitframe();
          var_5 = 0;
        }
      }
    }

    return 1;
  } else if(isDefined(var_4) && ispointinvolume(var_0 + (0, 0, 10), var_4)) {
    return 1;
  }

  return 0;
}

playerinzomboniroom(var_0) {
  level.zmplayerinzomboniroom = self;
  self setorigin(var_0.origin, 1);
  self setangles(var_0.angles);
  level thread announcerzomboniroom(self);
  wait 5;

  if(isDefined(self)) {
    var_1 = common_scripts\utility::getstructarray("zomboni_teleport_out", "targetname");
    var_2 = [];

    foreach(var_4 in var_1) {
      if(maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_4.script_noteworthy)) {
        var_2[var_2.size] = var_4;
      }
    }

    maps\mp\zombies\_teleport::teleport_players_through_chute([self], 0);
    thread maps\mp\zombies\_teleport::reset_teleport_flag_after_time([self], 0.75);
    playerteleporttoastructwait(var_2, 1);
    playFX(common_scripts\utility::getfx("teleport_post_fx"), self.origin, anglesToForward(self.angles));
  }

  level.zmplayerinzomboniroom = undefined;
}

announcerzomboniroom(var_0) {
  announcerglobalplaysqvowaittilldone(1, undefined, [var_0]);
  wait 1;
  announcerglobalplaysqvowaittilldone(2, undefined, [var_0]);
}

playerteleporttoastructwait(var_0, var_1) {
  self endon("disconnect");
  var_2 = 2;
  var_3 = 0;
  var_4 = 0;
  var_5 = var_0[0];

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  for(;;) {
    foreach(var_7 in var_0) {
      if(playertryteleporttostruct(var_7)) {
        return;
      }
      var_3++;

      if(var_3 >= var_2) {
        waitframe();
        var_3 = 0;
      }
    }

    if(isDefined(var_5) && var_1) {
      var_0 = getnodesinradiussorted(var_5.origin, 200, 0);
      var_5 = undefined;
    }
  }
}

playertryteleporttostruct(var_0) {
  if(capsuletracepassed(var_0.origin + (0, 0, 5), 15, 60, self)) {
    self setorigin(var_0.origin, 1);

    if(isDefined(var_0.angles)) {
      self setangles(var_0.angles);
    }

    thread maps\mp\zombies\killstreaks\_zombie_camouflage::playercamouflagemode(5);
    return 1;
  }

  return 0;
}

stage1_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Zomboni room power on");
}

stage2_init() {}

stage2_logic() {
  var_0 = common_scripts\utility::getstruct("sqEngineRoomDoor", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  alldoorlights();
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;

  for(;;) {
    wait 1;
    var_9 = var_0 maps\mp\zombies\_zombies_sidequests::fake_use("door_activated", undefined, undefined, "main_stage2_over", 85);

    if(!var_2) {
      announcerozglobalplaysqwaittilldone(1);
      level thread announcerozglobalplaysq(6, randomintrange(10, 15));
      var_2 = 1;
      continue;
    } else if(var_9 playerhasitem("code")) {
      var_9 playertakeitem("code");
      var_1++;
      var_10 = var_1 + 1;
      var_11 = common_scripts\utility::getstructarray("sqEngineRoomDoorFx" + var_10, "targetname");

      foreach(var_13 in var_11) {
        level thread turnondoorfx(var_13);
      }

      var_9 thread maps\mp\mp_zombie_ark_aud::code_accepted();
      wait 0.5;
      var_15 = var_1 + 1;
      announcerozglobalplaysqwaittilldone(var_15);

      if(var_1 == 3) {
        wait 1;
        level thread unlockspecialweaponupgrade();
        announcerglobalplaysqvowaittilldone(3);
      }

      if(var_15 == 2) {
        level thread announcerozglobalplaysq(16, randomintrange(10, 15));
      }

      if(var_15 == 3) {
        level thread announcerozglobalplaysq(19, randomintrange(10, 15));
      }

      if(var_15 == 4) {
        level thread announcerozglobalplaysq(11, randomintrange(10, 15));
      }

      continue;
    } else if(var_1 == 4 && var_9 playerhasitem("c4")) {
      var_9 playertakeitem("c4");
      break;
    }

    playsoundatpos(var_0.origin, "ee_engine_door_locked");

    if(!var_3 || !var_4) {
      if(!var_3) {
        var_9 playerplaysqvo(1, 0.5, 1);
        var_3 = 1;
      } else if(!var_4) {
        var_9 playerplaysqvo(3, 0.5, 1);
        var_4 = 1;
      }

      continue;
    }

    if(var_1 == 1) {
      if(!var_5) {
        var_9 playerplaysqvo(4, 0.5, 1);
        var_5 = 1;
      }

      continue;
    }

    if(var_1 == 2) {
      if(!var_6) {
        var_9 playerplaysqvo(5, 0.5, 1);
        var_6 = 1;
      }

      continue;
    }

    if(var_1 == 3) {
      if(!var_7) {
        var_9 playerplaysqvo(6, 0.5, 1);
        var_7 = 1;
      }

      continue;
    }

    if(var_1 == 4) {
      if(!var_8) {
        var_9 playerplaysqvo(7, 0.5, 1);
        var_8 = 1;
      }

      continue;
    }
  }

  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage2");
}

unlockspecialweaponupgrade() {
  level notify("special_weapon_box_unlocked");
  var_0 = getent("sqUpgradeStationTop", "targetname");

  if(isDefined(var_0)) {
    var_1 = var_0.origin + (0, 0, 30);
    var_0 moveto(var_1, 2, 0.5, 0.5);
  }

  var_2 = getent("sqUpgradeStationBottom", "targetname");

  if(isDefined(var_2)) {
    var_1 = var_2.origin + (0, 0, -30);
    var_2 moveto(var_1, 2, 0.5, 0.5);
  }
}

alldoorlights() {
  level.sqdoorfx = [];

  for(var_0 = 1; var_0 <= 5; var_0++) {
    var_1 = common_scripts\utility::getstructarray("sqEngineRoomDoorFx" + var_0, "targetname");

    foreach(var_3 in var_1) {
      var_3.fx = spawn("script_model", var_3.origin);
      var_3.fx setModel("tag_origin");

      if(!isDefined(var_3.angles)) {
        var_3.angles = (0, 0, 0);
      }

      var_3.fx.angles = var_3.angles;
      var_4 = "sq_door_light_red";

      if(var_0 == 1) {
        var_4 = "sq_door_light_green";
      }

      maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx(var_4), var_3.fx, "tag_origin");
    }
  }
}

turnondoorfx(var_0) {
  maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("sq_door_light_red"), var_0.fx, "tag_origin");
  maps\mp\zombies\_util::waitnetworkframe();
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("sq_door_light_green"), var_0.fx, "tag_origin");
}

stage2_end(var_0) {
  level.endgamewaitfunc = ::endgamewaitcinematic;
  level thread maps\mp\gametypes\_gamelogic::endgame(level.playerteam, game["end_reason"]["zombies_completed"]);
  maps\mp\zombies\_zombies_music::changezombiemusic("victory");
  givesidequestachievement();
  set_side_quest_coop_data_ark();
  maps\mp\zombies\_util::writezombiestats();
}

endgamewaitcinematic(var_0, var_1, var_2, var_3) {
  addsoundsubmix("bink_mix");
  level.zombiegamepaused = 1;

  foreach(var_5 in level.players) {
    var_5 maps\mp\_utility::freezecontrolswrapper(1);
  }

  playcinematicforall("zombies_bg_dlc3_outro", 1);
  wait 60;
}

givesidequestachievement() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1.joinedround1) || !var_1.joinedround1) {
      continue;
    }
    var_1 maps\mp\gametypes\zombies::givezombieachievement("DLC3_ZOMBIE_EASTEREGG");
  }
}

init_code1_sidequest() {}

sidequest_code1_logic() {
  maps\mp\zombies\_zombies_sidequests::stage_start("code1", "stage1");
  level waittill("code1_stage1_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("code1", "stage2");
  level waittill("code1_stage2_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("code1", "stage3");
  level waittill("code1_stage3_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("code1", "stage4");
  level waittill("code1_stage4_over");
}

code1_stage1_init() {
  level.processenemykilledcodefunc = ::processenemykilledcode1;
  level.sqdroppedteleportequip = [];
}

code1_stage1_logic() {
  var_0 = common_scripts\utility::getstruct("sqTeleportMachineUse", "targetname");
  var_1 = getent("sqTeleporterLights", "targetname");
  var_2 = getEntArray("sqTeleportLight", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  level.const_sq_teleporter_status_off = 0;
  level.const_sq_teleporter_status_broken = 1;
  level.const_sq_teleporter_status_repair = 2;
  level.const_sq_teleporter_status_on = 3;
  level.const_sq_teleporter_status_cooldown = 4;

  if(isDefined(var_1)) {
    level thread setupteleportlightmodel(var_1, level.const_sq_teleporter_status_broken);
  }

  foreach(var_4 in var_2) {
    level thread setupteleportlight(var_4, level.const_sq_teleporter_status_broken);
  }

  level thread teleportmachinehint(var_0);
  var_6 = 20;
  var_7 = 0;

  while(var_7 < var_6) {
    var_8 = var_0 maps\mp\zombies\_zombies_sidequests::fake_use("machine_piece_placed", ::playerhasteleportequipment);
    var_8 thread maps\mp\mp_zombie_ark_aud::teleporter_place_parts(var_7 + 1);
    var_8 playertakeitem("teleportEquipment");
    var_7++;

    if(isDefined(var_1)) {
      if(var_7 < var_6) {
        setupteleportlightmodel(var_1, level.const_sq_teleporter_status_repair);

        foreach(var_4 in var_2) {
          level thread setupteleportlight(var_4, level.const_sq_teleporter_status_repair);
        }
      }
    } else {
      var_11 = int(var_7 / var_6 * 100);
      iprintlnbold("Teleport machine " + var_11 + " percent repaired.");
      wait 0.5;
    }

    waitframe();
  }

  thread maps\mp\mp_zombie_ark_aud::teleporter_repaired();
  maps\mp\zombies\_zombies_sidequests::stage_completed("code1", "stage1");
}

processenemykilledcode1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!maps\mp\zombies\_zombies_zone_manager::iszombieinanyzone(self)) {
    return;
  }
  if(!maps\mp\zombies\_util::checkactivemutator("teleport")) {
    return;
  }
  if(isDefined(var_3) && var_3 == "MOD_SUICIDE") {
    return;
  }
  if(maps\mp\zombies\_util::istrapweapon(var_4)) {
    return;
  }
  if(level.sqdroppedteleportequip.size >= 5) {
    return;
  }
  level thread dropteleportequip(self.origin);
}

dropteleportequip(var_0) {
  var_0 = var_0 + (0, 0, 10);
  var_1 = spawn("script_model", var_0);
  var_1.angles = (0, 0, 0);
  var_1 setModel("dlc3_teleport_equipment");
  var_1 notsolid();
  var_2 = spawn("trigger_radius", var_0, 0, 32, 32);
  var_1.trigger = var_2;
  level.sqdroppedteleportequip[level.sqdroppedteleportequip.size] = var_1;
  var_1 thread teleportequippickup();
  var_1 thread teleportequiptimer();
  var_1 scriptmodelplayanim("mp_dogtag_spin");
}

teleportequippickup() {
  self endon("deleted");
  var_0 = self.origin;

  for(;;) {
    self.trigger waittill("trigger", var_1);

    if(isPlayer(var_1) && var_1 playercanpickupteleportequipment()) {
      var_1 playergiveitem("teleportEquipment");
      var_1 thread playerdoteleportpickupsound();
      thread removeteleportequip(self);
      return;
    }
  }
}

playerdoteleportpickupsound() {
  self playlocalsound("ee_teleport_pickup");

  if(!isDefined(level.sqplayedteleportequippickup) && playerplaysqvo(9, 0.5)) {
    level.sqplayedteleportequippickup = 1;
  }
}

playercanpickupteleportequipment() {
  if(playerhasitem("line") || playerhasitem("hook") || playerhasitem("reel") || playerhasitem("code") || playerhasitem("eye") || playerhasitem("teleportEquipment")) {
    return 0;
  } else if(playerhasitem("shovel") && isDefined(level.sqtreasurefound)) {
    return 0;
  } else {
    return 1;
  }
}

teleportequiptimer() {
  self endon("deleted");
  wait 15;
  thread teleportequipstartflashing();
  wait 8;
  level thread removeteleportequip(self);
}

teleportequipstartflashing() {
  self endon("deleted");

  for(;;) {
    self ghost();
    wait 0.25;
    self show();
    wait 0.25;
  }
}

removeteleportequip(var_0, var_1) {
  var_0 notify("deleted");
  waitframe();

  if(isDefined(var_0.trigger)) {
    var_0.trigger delete();
  }

  var_0 delete();

  if(!maps\mp\zombies\_util::is_true(var_1)) {
    level.sqdroppedteleportequip = common_scripts\utility::array_removeundefined(level.sqdroppedteleportequip);
  }
}

playerhasteleportequipment() {
  return playerhasitem("teleportEquipment");
}

teleportmachinehint(var_0) {
  level endon("code1_stage1_over");
  var_1 = var_0 maps\mp\zombies\_zombies_sidequests::fake_use("machine_used");

  if(var_1 playerhasitem("teleportEquipment")) {
    return;
  }
  var_1 thread maps\mp\mp_zombie_ark_aud::teleporter_parts_missing();
  wait 2;
  var_1 playerplaysqvo(8);
}

code1_stage1_end(var_0) {
  level.processenemykilledcodefunc = undefined;

  foreach(var_2 in level.sqdroppedteleportequip) {
    level thread removeteleportequip(var_2, 1);
  }

  level.sqdroppedteleportequip = undefined;
  level thread runteleportmachine();
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Repaired Teleport Machine");
}

runteleportmachine() {
  level.sqtreasurefound = 0;
  level.sqtreasurepickedup = 0;
  var_0 = common_scripts\utility::getstructarray("sqIslandTeleport", "script_noteworthy");
  var_1 = common_scripts\utility::getstruct("sqTeleportMachineUse", "targetname");
  level.zmbsqteleportbackspots = common_scripts\utility::getstructarray("sqTeleportBack", "targetname");
  var_2 = getent("sqTeleporterLights", "targetname");
  var_3 = getEntArray("sqTeleportLight", "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(level.sqtreasure)) {
    var_4 = common_scripts\utility::getstructarray("sqIslandDigPos", "targetname");
    level.sqtreasure = var_4[randomint(var_4.size)];
    var_5 = bulletTrace(level.sqtreasure.origin + (0, 0, 200), level.sqtreasure.origin + (0, 0, -200), 0);
    level.sqtreasure.origin = var_5["position"];
  }

  var_6 = [ &"ZOMBIES_COST_100", &"ZOMBIES_COST_500", &"ZOMBIES_COST_1000"];
  var_7 = [100, 500, 1000];
  level.sqcostindex = 0;

  if(isDefined(var_2)) {
    level thread setupteleportlightmodel(var_2, level.const_sq_teleporter_status_on);
  }

  foreach(var_9 in var_3) {
    level thread setupteleportlight(var_9, level.const_sq_teleporter_status_on);
  }

  wait 1;
  var_11 = spawn("script_model", var_1.origin);
  var_11 setModel("tag_origin");
  var_11 setcursorhint("HINT_NOICON");
  var_11 makeusable();
  level thread doozislandtaunt();

  while(!level.sqtreasurefound || !level.sqtreasurepickedup) {
    level.sqcoststring = var_6[level.sqcostindex];
    level.sqcost = var_7[level.sqcostindex];
    var_11 sethintstring(&"ZOMBIE_ARK_SQ_TELEPORT");
    var_11 setsecondaryhintstring(level.sqcoststring);
    var_11.cooldown = 0;

    if(isDefined(var_2)) {
      level thread setupteleportlightmodel(var_2, level.const_sq_teleporter_status_on);
    }

    foreach(var_9 in var_3) {
      level thread setupteleportlight(var_9, level.const_sq_teleporter_status_on);
    }

    level thread resetcostonroundtransition(var_11, var_6, var_7);

    for(;;) {
      var_11 waittill("trigger", var_14);

      if(var_14 maps\mp\gametypes\zombies::attempttobuy(level.sqcost)) {
        break;
      }

      wait 0.5;
    }

    if(isDefined(var_2)) {
      playFXOnTag(common_scripts\utility::getfx("dlc_teleport_in"), var_2, "tag_fx");
      level thread setupteleportlightmodel(var_2, level.const_sq_teleporter_status_cooldown, 1.5);

      foreach(var_9 in var_3) {
        level thread setupteleportlight(var_9, level.const_sq_teleporter_status_cooldown, 1.5);
      }

      wait 0.3;
    }

    var_11.cooldown = 1;
    var_11 sethintstring(&"ZOMBIES_CURE_COOLDOWN_HINT");
    var_11 setsecondaryhintstring("");

    if(level.sqcostindex + 1 < var_6.size) {
      level.sqcostindex++;
    }

    level.sqplayersteleporting = getplayersteleporting();
    maps\mp\zombies\_teleport::teleport_players_through_chute(level.sqplayersteleporting, 0);
    thread maps\mp\zombies\_teleport::reset_teleport_flag_after_time(level.sqplayersteleporting, 0.75);

    for(var_17 = 0; var_17 < level.sqplayersteleporting.size; var_17++) {
      level.sqplayersteleporting[var_17] playerteleporttoisland(var_0[var_17]);
    }

    level.zmbsqteleportbackindex = 0;

    if(!level.sqtreasurefound) {
      foreach(var_14 in level.sqplayersteleporting) {
        var_14 thread playerdig();
      }
    }

    var_20 = level.sqplayersteleporting[0].origin;
    var_21 = common_scripts\utility::getstruct("sqIslandCenter", "targetname");

    if(isDefined(var_21)) {
      var_20 = var_21.origin;
    }

    level thread dotimereffect(var_20);
    wait 25;
    level notify("teleportBackFromIsland");

    foreach(var_14 in level.sqplayersteleporting) {
      if(isDefined(var_14.digprompt)) {
        var_14.digprompt makeglobalunusable();
      }
    }

    maps\mp\zombies\_teleport::teleport_players_through_chute(level.sqplayersteleporting, 0);
    thread maps\mp\zombies\_teleport::reset_teleport_flag_after_time(level.sqplayersteleporting, 0.75);

    for(var_17 = 0; var_17 < level.sqplayersteleporting.size; var_17++) {
      var_14 = level.sqplayersteleporting[var_17];

      if(!isDefined(var_14) || !isalive(var_14)) {
        continue;
      }
      var_14 thread playerteleportfromisland(level.zmbsqteleportbackspots[level.zmbsqteleportbackindex]);
      level.zmbsqteleportbackindex++;
    }

    level thread doozislandtaunt2();
    level.sqplayersteleporting = undefined;
    wait 30;
    waitframe();
  }

  foreach(var_14 in level.players) {
    if(isDefined(var_14.digprompt)) {
      var_14.digprompt delete();
    }
  }

  var_11 delete();
}

doozislandtaunt2() {
  if(!maps\mp\zombies\_util::is_true(level.zmbaudioplayedislandback)) {
    if(announcerozglobalplaysq(14, 1)) {
      level.zmbaudioplayedislandback = 1;
    }
  }
}

doozislandtaunt() {
  var_0 = getent("sqTeleportTrigger", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1 playerhasitem("shovel")) {
      var_2 = 24;

      if(common_scripts\utility::cointoss()) {
        var_2 = 25;
      }

      if(announcerozglobalplaysq(var_2)) {
        return;
      }
    }
  }
}

playerunderwater(var_0) {
  if(maps\mp\zombies\_util::is_true(self.onisland)) {
    thread playerwaterteleportbackinternal();
  }
}

playerwaterteleportbackinternal() {
  if(isDefined(level.sqplayersteleporting) && common_scripts\utility::array_contains(level.sqplayersteleporting, self)) {
    self stopsound("ee_island_timer");
    level.sqplayersteleporting = common_scripts\utility::array_remove(level.sqplayersteleporting, self);
    maps\mp\zombies\_teleport::teleport_players_through_chute([self], 0);
    thread maps\mp\zombies\_teleport::reset_teleport_flag_after_time([self], 0.75);
    thread playerteleportfromisland(level.zmbsqteleportbackspots[level.zmbsqteleportbackindex]);
    level.zmbsqteleportbackindex++;
  }
}

dotimereffect(var_0) {
  wait 5;
  playFX(common_scripts\utility::getfx("sq_island_timer"), var_0);
}

resetcostonroundtransition(var_0, var_1, var_2) {
  var_0 notify("resetCostOnRoundTransition");
  var_0 endon("resetCostOnRoundTransition");
  var_0 endon("death");
  level waittill("zombie_wave_started");

  if(!isDefined(var_0)) {
    return;
  }
  level.sqcostindex = 0;
  level.sqcost = var_2[level.sqcostindex];
  level.sqcoststring = var_1[level.sqcostindex];

  if(!var_0.cooldown) {
    var_0 setsecondaryhintstring(level.sqcoststring);
  }
}

setupteleportlightmodel(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    wait(var_2);
  }

  switch (var_1) {
    case 0:
      var_0 hidepart("TAG_FX_ON");
      var_0 showpart("TAG_FX_OFF");
      var_0 hidepart("TAG_FX_GLOW");
      break;
    case 4:
      maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_on"), var_0, "tag_origin");
    case 1:
      var_0 hidepart("TAG_FX_ON");
      var_0 hidepart("TAG_FX_OFF");
      var_0 showpart("TAG_FX_GLOW");
      maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_off"), var_0, "tag_origin", 0);
      break;
    case 2:
      var_0 showpart("TAG_FX_ON");
      var_0 hidepart("TAG_FX_OFF");
      var_0 hidepart("TAG_FX_GLOW");
      maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_off"), var_0, "tag_origin");
      maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_on"), var_0, "tag_origin", 0);
      wait 0.5;
      var_0 hidepart("TAG_FX_ON");
      var_0 hidepart("TAG_FX_OFF");
      var_0 showpart("TAG_FX_GLOW");
      maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_on"), var_0, "tag_origin");
      maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_off"), var_0, "tag_origin", 0);
      break;
    case 3:
      maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_off"), var_0, "tag_origin");
      maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_on"), var_0, "tag_origin", 0);
      var_0 showpart("TAG_FX_ON");
      var_0 hidepart("TAG_FX_OFF");
      var_0 hidepart("TAG_FX_GLOW");
      break;
  }
}

setupteleportlight(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    wait(var_2);
  }

  switch (var_1) {
    case 0:
      var_0 setlightcolor(maps\mp\mp_zombie_ark::getteleporterlightcoloroff());
      var_0 setlightintensity(maps\mp\mp_zombie_ark::getteleporterlightintensityoff());
      break;
    case 4:
    case 1:
      var_0 setlightcolor(maps\mp\mp_zombie_ark::getteleporterlightcolorstandby());
      var_0 setlightintensity(maps\mp\mp_zombie_ark::getteleporterlightintensitystandby());
      break;
    case 2:
      var_0 setlightcolor(maps\mp\mp_zombie_ark::getteleporterlightcoloron());
      var_0 setlightintensity(maps\mp\mp_zombie_ark::getteleporterlightintensityon());
      wait 0.5;
      var_0 setlightcolor(maps\mp\mp_zombie_ark::getteleporterlightcolorstandby());
      var_0 setlightintensity(maps\mp\mp_zombie_ark::getteleporterlightintensitystandby());
      break;
    case 3:
      var_0 setlightcolor(maps\mp\mp_zombie_ark::getteleporterlightcoloron());
      var_0 setlightintensity(maps\mp\mp_zombie_ark::getteleporterlightintensityon());
      break;
  }
}

runteleporterlight(var_0) {
  var_0 setlightcolor((1, 0, 0));
  self waittill("teleportReady");
  var_0 setlightcolor((0.501, 1, 1));
}

playerteleporttoisland(var_0) {
  self setorigin(var_0.origin, 1);

  if(isDefined(var_0.angles)) {
    self setangles(var_0.angles);
  }

  self.onisland = 1;
  self _meth_856B(0);
  self notify("update_ground_ref_ent");
  playFX(common_scripts\utility::getfx("teleport_post_fx"), self.origin, anglesToForward(self.angles));
  thread maps\mp\mp_zombie_ark_aud::island_timer_start();
}

playerteleportfromisland(var_0) {
  self.onisland = undefined;
  self _meth_856B(1);
  self notify("update_ground_ref_ent");

  if(!playertryteleporttostruct(var_0)) {
    var_1 = getnodesinradiussorted(var_0.origin, 200, 0);
    playerteleporttoastructwait(var_1, 0);
  }

  playFX(common_scripts\utility::getfx("teleport_post_fx"), self.origin, anglesToForward(self.angles));
}

playerdig() {
  level endon("teleportBackFromIsland");
  level endon("treasureFound");

  if(!maps\mp\zombies\_util::is_true(level.sqshovelhint)) {
    level.sqshovelhint = 1;
    wait 2;
    playerplaysqvo(10);
  }

  if(!playerhasitem("shovel")) {
    return;
  }
  if(!isDefined(self.digprompt)) {
    self.digprompt = spawn("script_model", self.origin);
    self.digprompt hide();
    self.digprompt showtoplayer(self);
    self.digprompt setcursorhint("HINT_NOICON");
    self.digprompt sethintstring(&"ZOMBIE_ARK_SQ_DIG");
  }

  for(;;) {
    var_0 = self getEye();
    var_1 = anglesToForward(self getangles());
    var_2 = var_0 + var_1 * 70;
    var_3 = bulletTrace(var_0, var_2, 0, self);

    if(var_3["fraction"] == 1 || !isDefined(var_3["surfacetype"]) || var_3["surfacetype"] != "sand") {
      if(maps\mp\zombies\_util::is_true(self.digprompt.usable)) {
        self.digprompt makeglobalunusable();
        self.digprompt.usable = 0;
      }
    } else {
      if(!maps\mp\zombies\_util::is_true(self.digprompt.usable)) {
        self.digprompt makeglobalusable(-100, self);
        self.digprompt.usable = 1;
      }

      if(self usebuttonpressed()) {
        self.digprompt makeglobalunusable();
        self.digprompt.usable = 0;
        var_4 = var_3["position"];
        playFX(common_scripts\utility::getfx("sq_dirt_dig"), var_4);
        var_5 = distance2dsquared(var_4, level.sqtreasure.origin);
        thread maps\mp\mp_zombie_ark_aud::dig();

        if(var_5 < 1024) {
          level.sqtreasure.origin = var_4;
          level notify("treasureFound", self);
          return;
        }

        wait 1;
        self.digprompt makeglobalusable(-100, self);
        self.digprompt.usable = 1;
      }
    }

    waitframe();
  }
}

findtreasure(var_0) {
  level endon("code1_stage4_over");
  level.sqtreasurefound = 1;
  var_1 = getent("sqIslandCrate2", "targetname");
  var_2 = getent("sqCode3", "targetname");
  var_3 = var_0.origin - level.sqtreasure.origin;
  var_4 = (0, vectortoyaw(var_3), 0);
  var_5 = level.sqtreasure.origin + (0, 0, -10);

  if(!isDefined(var_1)) {
    var_1 = spawn("script_model", var_5);
    var_1 setModel("zark_tablet_chest_anim");
    var_1.targetname = "sqIslandCrate2";
    var_1.angles = var_4;

    if(isDefined(var_2)) {
      var_2 show();
      var_2.origin = var_1.origin + (0.5, 0, 2);
      var_2.angles = var_1.angles;
      var_2 linktosynchronizedparent(var_1);
    }
  } else {
    var_1 show();
    var_1 thread maps\mp\mp_zombie_ark_aud::treasure_found();

    if(isDefined(var_2)) {
      var_2 show();
      var_2 linktosynchronizedparent(var_1);
    }

    var_1 dontinterpolate();
    var_1.origin = var_5;
    var_1.angles = var_4;
  }

  waitframe();
  var_1 scriptmodelplayanim("zark_tablet_chest_closed_loop", "chest_notetrack");
  var_6 = playerphysicstraceinfo(var_1.origin + (0, 0, 20), var_1.origin, var_0);
  var_7 = var_1.origin + (0, 0, 20);

  if(var_6["fraction"] > 0) {
    var_7 = (var_1.origin[0], var_1.origin[1], var_6["position"][2] + 1);
  }

  waitframe();
  var_1 moveto(var_7, 0.2, 0.1, 0.1);
  wait 0.2;
  var_1 physicslaunchserver(var_1.origin, (0, 0, -1));
  var_1 common_scripts\utility::waittill_notify_or_timeout("physics_finished", 0.5);
  var_1 physicsstop();
  var_1 scriptmodelplayanim("zark_tablet_chest_closed_loop", "chest_notetrack");
  wait 1;
  var_0 = var_1 maps\mp\zombies\_zombies_sidequests::fake_use("chest_opened");
  var_0 thread maps\mp\mp_zombie_ark_aud::treasure_opened();
  var_1 scriptmodelplayanim("zark_tablet_chest_open", "chest_notetrack");
  var_1 waittillmatch("chest_notetrack", "end");
  var_1 scriptmodelplayanim("zark_tablet_chest_open_loop", "chest_notetrack");

  if(isDefined(var_2)) {
    wait 1.5;
    var_0 = var_2 maps\mp\zombies\_zombies_sidequests::fake_use("got_code", ::playernotholdingcode);
    var_2 hide();
  }

  var_0 playergiveitem("code");
  var_0 thread maps\mp\mp_zombie_ark_aud::got_code();

  foreach(var_0 in level.players) {
    var_0 maps\mp\gametypes\zombies::givepointsforevent("sq_code1", 2000, 1);
  }

  level.sqtreasurepickedup = 1;
}

getplayersteleporting() {
  var_0 = [];
  var_1 = getent("sqTeleportTrigger", "targetname");

  if(isDefined(var_1)) {
    foreach(var_3 in level.players) {
      if(var_3 istouching(var_1) && !var_3 isjumping() && !var_3 ishighjumping() && !var_3 ishighjumping()) {
        var_0[var_0.size] = var_3;
      }
    }
  } else {
    var_0 = level.players;
  }

  return common_scripts\utility::array_randomize(var_0);
}

code1_stage2_init() {}

code1_stage2_logic() {
  while(!anyplayerhasshovel()) {
    waitframe();
  }

  wait 1;
  maps\mp\zombies\_zombies_sidequests::stage_completed("code1", "stage2");
}

anyplayerhasitem(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 playerhasitem(var_0)) {
      return 1;
    }
  }

  return 0;
}

anyplayerhasshovel() {
  return anyplayerhasitem("shovel");
}

code1_stage2_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Found the shovel");
}

code1_stage3_init() {}

code1_stage3_logic() {
  level waittill("treasureFound", var_0);
  level thread findtreasure(var_0);
  maps\mp\zombies\_zombies_sidequests::stage_completed("code1", "stage3");
}

code1_stage3_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Found the treasure");
}

code1_stage4_init() {}

code1_stage4_logic() {
  while(!level.sqtreasurepickedup) {
    waitframe();
  }

  maps\mp\zombies\_zombies_sidequests::stage_completed("code1", "stage4");
}

code1_stage4_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Retreived code from the chest");
}

init_code2_sidequest() {}

sidequest_code2_logic() {
  maps\mp\zombies\_zombies_sidequests::stage_start("code2", "stage1");
  level waittill("code2_stage1_over");
}

code2_stage1_init() {}

code2_stage1_logic() {
  var_0 = getent("sqSecurityButton", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  level thread runobstaclecourse();
  var_0 waittill("courseCompleted");
  maps\mp\zombies\_zombies_sidequests::stage_completed("code2", "stage1");
}

runobstaclecourse() {
  var_0 = getent("sqSecurityButton", "targetname");
  var_1 = getent("sqCode2", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_on"), var_0, "tag_origin");
  wait 1;
  var_3 = 120;

  if(level.players.size > 1) {
    var_3 = var_3 * 2;
  }

  for(;;) {
    for(;;) {
      var_0 maps\mp\zombies\_zombies_sidequests::fake_use("button_pressed", undefined, undefined, "sqCourseStart");
      var_4 = allplayersinzone("biomed");

      if(var_4) {
        setomnvar("ui_zm_ee_bool", 0);
        level thread maps\mp\gametypes\zombies::setendtimeomnvarwithhostmigration("ui_zm_ee_int2", gettime() + var_3 * 1000);

        foreach(var_6 in level.players) {
          if(var_6 playerisintoxicated()) {
            var_6 thread playerintoxicate(undefined, var_3);
          }

          var_6 playlocalsound("ee_obstacle_course_on");
        }

        thread maps\mp\mp_zombie_ark_aud::start_obstacle_course();
        level thread maps\mp\zombies\_teleport::teleporter_disable_all();
        break;
      } else {
        setomnvar("ui_zm_ee_int2", 0);
        level notify("ui_zm_ee_int2_cancel");
        thread maps\mp\mp_zombie_ark_aud::stop_obstacle_course();
      }

      wait 1;
    }

    foreach(var_9 in level.sqsecurityfieldbrushes) {
      var_9 entitysetintoxicatedvisiononly(1);
    }

    var_0 thread securitybuttonswitchfxon();

    if(isDefined(var_1)) {
      var_1 show();
    }

    level thread doobstaclecoursevo();
    var_11 = securityfieldlogic(var_1, var_3);
    level thread delayenableteleporters();

    foreach(var_9 in level.sqsecurityfieldbrushes) {
      var_9 entitysetintoxicatedvisiononly(0);
      var_9 hide();
    }

    if(var_11) {
      var_0 notify("courseCompleted");
      stopallplayersintoxication();
      thread maps\mp\mp_zombie_ark_aud::obstacle_course_complete();
    } else {
      foreach(var_6 in level.players) {
        var_6 playlocalsound("ee_obstacle_course_fail");
      }

      thread maps\mp\mp_zombie_ark_aud::stop_obstacle_course();
    }

    var_0 thread securitybuttonswitchfxoff();
    wait 1;
  }
}

doobstaclecoursevo() {
  level thread doobstaclecourselavavo();
  level thread doobstaclecoursecrouchvo();
  level thread doobstaclecoursemazevo();
}

doobstaclecourselavavo() {
  level endon("sq_obstacle_course_complete");

  if(maps\mp\zombies\_util::is_true(level.zmbsqplayedlavavo)) {
    return;
  }
  var_0 = getent("sqTriggerEnterCargo", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isPlayer(var_1) || !var_1 playerisintoxicated()) {
      continue;
    }
    if(var_1 playerplaysqvo(17) || var_1 playerplaysqvo(18)) {
      level.zmbsqplayedlavavo = 1;
      var_0 delete();
      return;
    }
  }
}

doobstaclecoursecrouchvo() {
  level endon("sq_obstacle_course_complete");

  if(maps\mp\zombies\_util::is_true(level.zmbsqplayedcrouchvo)) {
    return;
  }
  var_0 = getent("sqTriggerEnterLift", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isPlayer(var_1) || !var_1 playerisintoxicated()) {
      continue;
    }
    if(var_1 playerplaysqvo(20)) {
      level.zmbsqplayedcrouchvo = 1;
      var_0 delete();
      return;
    }
  }
}

doobstaclecoursemazevo() {
  level endon("sq_obstacle_course_complete");

  if(maps\mp\zombies\_util::is_true(level.zmbsqplayedmazevo)) {
    return;
  }
  var_0 = getent("sqTriggerEnterPool", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isPlayer(var_1) || !var_1 playerisintoxicated()) {
      continue;
    }
    if(var_1 playerplaysqvo(21)) {
      level.zmbsqplayedmazevo = 1;
      var_0 delete();
      return;
    }
  }
}

delayenableteleporters() {
  wait 1;
  maps\mp\zombies\_teleport::teleporter_enable_all();
}

allplayersinzone(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(isalive(var_3)) {
      var_1++;
    }
  }

  return maps\mp\zombies\_zombies_zone_manager::getnumberofplayersinzone(var_0) == var_1;
}

securityfielddetecttouched() {
  level endon("code2_stage1_over");
  level endon("sq_obstacle_course_complete");
  waittillframeend;

  for(;;) {
    foreach(var_1 in level.players) {
      foreach(var_3 in level.sqsecurityfieldtriggers) {
        if(var_1 istouching(var_3)) {
          level notify("securityFieldTouched");
          return;
        }
      }
    }

    waitframe();
  }
}

securityfieldlogic(var_0, var_1) {
  var_2 = gettime();
  level.zmbsqobstaclecourserunning = 1;
  level thread securityfielddetecttouched();
  level thread coursetimer(var_1);
  var_3 = waittillcoursecomplete(var_0);
  level notify("sq_obstacle_course_complete");
  level.zmbsqobstaclecourserunning = undefined;
  var_0 hide();
  var_4 = gettime();
  var_5 = var_4 - var_2;
  level thread doobstaclecoursetime(var_3, var_5);

  if(isDefined(var_3)) {
    if(!maps\mp\zombies\_util::is_true(level.sqgotobstaclecoursecode)) {
      var_3 playergiveitem("code");
      var_3 thread maps\mp\mp_zombie_ark_aud::got_code();
      level.sqgotobstaclecoursecode = 1;
    }

    return 1;
  } else {
    playFX(common_scripts\utility::getfx("teleport_equipment"), var_0.origin);
    return 0;
  }
}

coursetimer(var_0) {
  level endon("code2_stage1_over");
  level endon("sq_obstacle_course_complete");
  wait(var_0);
  level notify("sq_obstacle_course_time");
}

doobstaclecoursetime(var_0, var_1) {
  if(isDefined(var_0)) {
    setomnvar("ui_zm_ee_bool", 1);
    setomnvar("ui_zm_ee_int2", var_1);

    if(var_0 playerhasitem("fish")) {
      level thread dorewardsplash(var_1, var_0);
    }

    wait 5;
  }

  setomnvar("ui_zm_ee_int2", 0);
}

dorewardsplash(var_0, var_1) {
  var_2 = var_0 / 1000;

  if(var_2 < 60) {
    maps\mp\gametypes\zombies::showteamsplashzombies("zombie_ark_course_gold");
    var_3 = var_1 getcoopplayerdatareservedint("eggData");
    var_3 = var_3 | 16;
    var_1 setcoopplayerdatareservedint("eggData", var_3);
  } else if(var_2 < 75) {
    maps\mp\gametypes\zombies::showteamsplashzombies("zombie_ark_course_silver");
  } else if(var_2 < 90) {
    maps\mp\gametypes\zombies::showteamsplashzombies("zombie_ark_course_bronze");
  }
}

playernotholdingcode() {
  return !playerhasitem("code");
}

waittillcoursecomplete(var_0) {
  level endon("securityFieldTouched");
  level endon("sq_obstacle_course_time");
  var_1 = var_0 maps\mp\zombies\_zombies_sidequests::fake_use("got_code", ::playernotholdingcode, undefined, "securityFieldTouched");
  return var_1;
}

securitybuttonswitchfxon() {
  maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_on"), self, "tag_origin");
  wait 1;
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_pass"), self, "tag_origin");
}

securitybuttonswitchfxoff() {
  maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_pass"), self, "tag_origin");
  wait 1;
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_on"), self, "tag_origin");
}

code2_stage1_end(var_0) {
  setitemascomplete("rum");
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Completed the obstacle course &got code.");
}

init_code3_sidequest() {}

sidequest_code3_logic() {
  maps\mp\zombies\_zombies_sidequests::stage_start("code3", "stage1");
  level waittill("code3_stage1_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("code3", "stage2");
  level waittill("code3_stage2_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("code3", "stage3");
  level waittill("code3_stage3_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("code3", "stage4");
  level waittill("code3_stage4_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("code3", "stage5");
  level waittill("code3_stage5_over");
}

code3_stage1_init() {}

code3_stage1_logic() {
  var_0 = getent("sqLocker1", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = spawnStruct();
  var_1.origin = (65, -496, 1023);
  var_2 = var_1 maps\mp\zombies\_zombies_sidequests::fake_use("doorUsed", undefined, undefined, "code3_stage1_over", 80);
  playsoundatpos(var_1.origin, "ee_locker_locked");
  var_2 playerplaysqvo(22, 0.5);
  maps\mp\zombies\_zombies_sidequests::stage_completed("code3", "stage1");
}

code3_stage1_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Found locker.");
}

code3_stage2_init() {
  level thread dosharkhint();
}

dosharkhint() {
  level endon("code3_stage3_over");
  var_0 = getent("sqLocker1", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = spawnStruct();
  var_1.origin = (65, -496, 1023);
  var_2 = var_1 maps\mp\zombies\_zombies_sidequests::fake_use("doorUsed", undefined, undefined, "code3_stage1_over", 80);
  playsoundatpos(var_1.origin, "ee_locker_locked");
  var_2 playerplaysqvo(23, 0.5);
  level thread announcerozglobalplaysq(12, randomintrange(10, 15));
}

code3_stage2_logic() {
  for(;;) {
    level waittill("zombie_ammo_drone_spawn", var_0, var_1, var_2);
    level thread waitspawnsqdrone(var_0, var_1, var_2);
  }
}

waitspawnsqdrone(var_0, var_1, var_2) {
  var_3 = getsqdronestartnode(var_1, var_2);

  if(!isDefined(var_3)) {
    return;
  }
  maps\mp\_utility::incrementfauxvehiclecount();
  level.ammodrone2 = maps\mp\zombies\zombie_ammo_drone::spawnammodrone(var_3.origin, (0, 0, 0));

  if(!isDefined(level.ammodrone2)) {
    maps\mp\_utility::decrementfauxvehiclecount();
    return;
  }

  level.ammodrone2.startzone = var_1;
  level.ammodrone2.linegunignore = 1;
  level thread maps\mp\zombies\zombie_ammo_drone::waittillactivate(level.ammodrone2, var_1);
  level waittill("zombie_ammo_drone_activate", var_0, var_4, var_5);
  var_6 = maps\mp\zombies\zombie_ammo_drone::getdestinationzone(var_1, var_4);
  var_7 = maps\mp\zombies\zombie_ammo_drone::getdestinationnode(var_6, var_3);
  level.ammodrone2.endnode = var_7;
  level.ammodrone2.endzone = var_6;
  level thread maps\mp\zombies\zombie_ammo_drone::droneactivate(level.ammodrone2, var_6, var_7, 0);
  var_8 = level.ammodrone2 dronewaittilldropswitch();
  level.ammodrone2 = undefined;

  if(isDefined(var_8)) {
    var_8 scriptmodelplayanim("zark_electricpanel_switch_pickup_spin", "switch_notetrack");
    var_8 thread switchpickup();
  }
}

dronewaittilldropswitch() {
  self endon("explode");
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("zark_electricpanel_switch_01_anim");
  var_0 hudoutlineenable(2, 0);
  var_0 linkto(self, "tag_origin", (0, 0, 20), (0, 0, 0));
  thread dronesqcleanupswitch(var_0);
  self waittill("disabled", var_1);

  if(isDefined(self.lastgroundposition)) {
    var_1 = self.lastgroundposition;
  }

  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  var_0 unlink();
  var_0.origin = var_1;
  return var_0;
}

switchpickup() {
  self endon("deleted");
  self.trigger = spawn("trigger_radius", self.origin, 0, 32, 32);

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(isPlayer(var_0)) {
      var_0 playergiveitem("switch");
      var_0 thread maps\mp\mp_zombie_ark_aud::switch_pickup();
      maps\mp\zombies\_zombies_sidequests::stage_completed("code3", "stage2");
      level thread removeswitch(self);
      return;
    }
  }
}

removeswitch(var_0) {
  var_0 notify("deleted");
  waitframe();

  if(isDefined(var_0.trigger)) {
    var_0.trigger delete();
  }

  var_0 delete();
}

dronesqcleanupswitch(var_0) {
  self endon("disabled");
  self waittill("explode");
  var_0 delete();
}

getsqdronestartnode(var_0, var_1) {
  var_2 = getlinkednodes(var_1, 1);

  if(var_2.size > 0) {
    return var_2[randomint(var_2.size)];
  }

  var_3 = common_scripts\utility::array_randomize(var_0.ammodronespawnnodes);

  foreach(var_5 in var_3) {
    if(var_5 != var_1) {
      return var_5;
    }
  }
}

waittillsqdroneactivate(var_0, var_1) {
  level.ammodrone endon("droneDamaged");
  var_0 endon("droneDamaged");

  for(;;) {
    waitframe();

    if(!maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_1.zone_name)) {
      continue;
    }
    var_2 = maps\mp\zombies\_zombies_zone_manager::getplayersinzone(var_1.zone_name, 1);

    if(var_2.size == 0) {
      continue;
    }
    var_3 = maps\mp\zombies\zombie_ammo_drone::getplayerclosetodrone(var_0, var_2);

    if(isDefined(var_3)) {
      break;
    }

    var_3 = maps\mp\zombies\zombie_ammo_drone::getplayerlookingatdronetoolong(var_0, var_2);

    if(isDefined(var_3)) {
      break;
    }
  }

  level notify("activateAmmoDrone");
}

code3_stage2_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Got the switch from the treasure drone.");
}

code3_stage3_init() {}

code3_stage3_logic() {
  var_0 = getent("sqCageSwitch", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0 maps\mp\zombies\_zombies_sidequests::fake_use("used", ::playerhasitem, "switch", "code3_stage3_over");
  var_1 playertakeitem("switch");
  var_1 thread maps\mp\mp_zombie_ark_aud::switch_place_in_socket();
  wait 1;
  maps\mp\zombies\_zombies_sidequests::stage_completed("code3", "stage3");
}

code3_stage3_end(var_0) {
  var_4 = getent("sqCageSwitch", "targetname");

  if(isDefined(var_4)) {
    var_4 show();
    var_4 scriptmodelplayanim("zark_electricpanel_switch_up_idle", "switch_notetrack");
  }

  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Placed switch by moon pool.");
}

chumwaters() {
  level.sqchumvolume = getent("sqChumWater", "targetname");

  if(!isDefined(level.sqchumvolume)) {
    return;
  }
  level.zmbwaterchummed = 0;
  level.processenemykilledfunc = ::processenemykilled;
  var_1 = 5;
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    level waittill("sq_chum_water", var_4, var_5);

    if(maps\mp\zombies\_util::is_true(level.zmbsqcagemoving)) {
      continue;
    }
    playFX(common_scripts\utility::getfx("sq_chum"), var_4);

    if(!level.zmbwaterchummed) {
      if(isDefined(level.zmbshark) && maps\mp\zombies\_util::is_true(level.zmbshark.circling)) {
        continue;
      }
      var_6 = gettime() - var_3;

      if(var_6 > 10000) {
        var_2 = 0;
      }

      var_3 = gettime();
      var_2++;

      if(var_2 >= var_1) {
        level.zmbwaterchummed = 1;
        level thread doshark();

        if(isDefined(var_5) && isPlayer(var_5)) {
          var_5 thread playerplaychumwatervo();
        }

        maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Water chummed");
        var_2 = 0;
        var_3 = 0;
        level thread resetchumtime(30);
      }

      continue;
    }

    var_2++;
    var_7 = 30 - var_2;
    level thread resetchumtime(var_7);
  }
}

playerplaychumwatervo() {
  self endon("disconnect");
  wait 1;
  maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "chum_water");
}

resetchumtime(var_0) {
  level notify("resetChumTime");
  level endon("resetChumTime");

  if(var_0 > 0) {
    wait(var_0);
  }

  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Water not chummed");
  level.zmbwaterchummed = 0;
}

doshark() {
  var_0 = common_scripts\utility::getstruct("shark_anim_node", "targetname");

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.origin = (0, 0, 0);
  }

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  if(!isDefined(level.zmbshark)) {
    level.zmbshark = spawn("script_model", var_0.origin);
    level.zmbshark setModel("zark_shark_01");
    level.zmbeyeball = spawn("script_model", var_0.origin);
    level.zmbeyeball setModel("zark_zom_eye_01");
    level.zmbeyeball linktosynchronizedparent(level.zmbshark, "j_helmet", (0, 0, 0), (0, 0, 0));
  }

  level.zmbsharktriggeractive = 0;
  level.zmbshark show();
  level.zmbshark.circling = 1;
  level.zmbshark scriptmodelplayanimdeltamotionfrompos("zom_shark_circle_enter", var_0.origin, var_0.angles, "shark_notetrack");
  thread maps\mp\mp_zombie_ark_aud::shark_enters();
  level.zmbshark waittillmatch("shark_notetrack", "end");

  if(!maps\mp\zombies\_util::is_true(level.zmbaudioplayedsharkhint)) {
    if(announcerozglobalplaysq(15)) {
      level.zmbaudioplayedsharkhint = 1;
    }
  }

  if(level.zmbwaterchummed) {
    level.zmbsharktriggeractive = 1;
    level.zmbshark scriptmodelplayanimdeltamotionfrompos("zom_shark_circle_loop", var_0.origin, var_0.angles, "shark_notetrack");
    thread maps\mp\mp_zombie_ark_aud::shark_loop();

    while(level.zmbwaterchummed && !maps\mp\zombies\_util::is_true(level.zmbsqcagemoving)) {
      waitframe();
    }
  }

  level.zmbsharktriggeractive = 0;
  level.zmbshark scriptmodelplayanimdeltamotion("zom_shark_circle_exit", "shark_notetrack");
  thread maps\mp\mp_zombie_ark_aud::shark_leaves();
  level.zmbshark waittillmatch("shark_notetrack", "end");
  level.zmbshark.circling = undefined;
  level.zmbshark hide();
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Shark leaving");
}

processenemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(level.processenemykilledcodefunc)) {
    self thread[[level.processenemykilledcodefunc]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  if(!level.zmbwaterchummed && ispointinvolume(self.origin + (0, 0, 10), level.sqchumvolume)) {
    level notify("sq_chum_water", self.origin, var_1);
  }
}

code3_stage4_init() {}

code3_stage4_logic() {
  cageoperation();
  maps\mp\zombies\_zombies_sidequests::stage_completed("code3", "stage4");
}

code3_stage4_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Retrieved eye from pool");
}

cageoperation() {
  var_0 = common_scripts\utility::getstruct("shark_anim_node", "targetname");
  var_1 = getent("sqCrane", "targetname");
  var_2 = getent("sqCageModel", "targetname");
  var_3 = getent("sqCageDoorClip", "targetname");
  var_4 = getent("sqCageDoorBottomClip", "targetname");
  var_5 = getent("sqCageSwitch", "targetname");
  var_6 = getent("sqCageTrigger", "targetname");
  var_7 = getent("sqCageVolume", "targetname");
  var_8 = getent("sqPoolDoor1", "targetname");
  var_9 = getent("sqPoolDoor2", "targetname");
  var_10 = getent("sqChumWater", "targetname");
  var_11 = getent("sqPoolTrigger", "targetname");
  var_12 = getent("sqPoolClip", "targetname");
  var_13 = var_5;

  if(isDefined(var_6)) {
    var_13 = var_6;
  } else {
    var_5.origin = (var_5.origin[0], 596, var_5.origin[2]);
  }

  var_13 makeusable();
  var_13 setcursorhint("HINT_NOICON");
  level.zmbsqcagemoving = 0;

  for(;;) {
    var_13 sethintstring(&"ZOMBIE_ARK_SQ_CAGE");
    var_13 setsecondaryhintstring(&"ZOMBIES_COST_1000");

    for(;;) {
      var_13 waittill("trigger", var_14);

      if(var_14 maps\mp\gametypes\zombies::attempttobuy(1000)) {
        break;
      }

      wait 0.5;
    }

    var_13 sethintstring(&"ZOMBIES_CURE_COOLDOWN_HINT");
    var_13 setsecondaryhintstring("");
    var_5 thread maps\mp\mp_zombie_ark_aud::cage_switch();
    var_5 scriptmodelplayanim("zark_electricpanel_switch_move_down", "switch_notetrack");
    var_5 waittillmatch("switch_notetrack", "end");
    var_5 scriptmodelplayanim("zark_electricpanel_switch_down_idle", "switch_notetrack");
    var_1 thread maps\mp\mp_zombie_ark_aud::cage_down();
    level.zmbsqcagemoving = 1;
    var_12 poolclipon();
    docageanimation(var_0, var_2, var_1, var_3, var_4, var_7, var_8, var_9, var_11);
    var_12 poolclipoff();
    level.zmbsqcagemoving = 0;

    if(isDefined(var_2.playerinside) && var_2.playerinside playerhasitem("eye")) {
      break;
    }

    wait 30;
    var_5 scriptmodelplayanim("zark_electricpanel_switch_move_up", "switch_notetrack");
    var_5 waittillmatch("switch_notetrack", "end");
    var_5 scriptmodelplayanim("zark_electricpanel_switch_up_idle", "switch_notetrack");
  }

  var_13 makeunusable();
}

docageanimation(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = var_6.origin;
  var_10 = var_9 + (0, -60, 0);
  var_11 = var_7.origin;
  var_12 = var_11 + (0, 40, 0);
  var_13 = isDefined(level.zmbshark) && maps\mp\zombies\_util::is_true(level.zmbshark.circling);
  var_2 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_lower_crane", var_0.origin, var_0.angles, "cageSequence");
  var_1 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_lower_cage", var_0.origin, var_0.angles, "cageSequence");
  var_6 moveto(var_10, 3, 1, 1);
  var_7 moveto(var_12, 3, 1, 1);

  if(var_13) {
    level thread dosharkcageoztaunt();
  }

  var_1 waittillmatch("cageSequence", "end");
  var_2 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_getin_loop_crane", var_0.origin, var_0.angles, "cageSequence");
  var_1 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_getin_loop_cage", var_0.origin, var_0.angles, "cageSequence");
  level thread setclipwhenplayerjumpsin(var_1, var_3, var_5);
  var_3 cagedoorclipopen();
  var_1 common_scripts\utility::waittill_notify_or_timeout("playerJumpedIn", 4);
  var_3 notify("timeout");

  if(maps\mp\zombies\_util::is_true(var_3.open)) {
    var_3 cagedoorclipclose();
  }

  waittillsharkready();
  var_1 waittillmatch("cageSequence", "getin_loop_point");
  level notify("removeExtraPlayersStop");

  if(var_13 && isDefined(var_1.playerinside)) {
    level.zmbshark show();
    thread maps\mp\mp_zombie_ark_aud::shark_attack(var_1.playerinside);
    level.zmbshark scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_attack_shark", var_0.origin, var_0.angles, "cageSequence");
    var_2 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_attack_crane", var_0.origin, var_0.angles, "cageSequence");
    var_1 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_attack_cage", var_0.origin, var_0.angles, "cageSequence");
    level thread handleeyeball(var_1);
    var_1 waittillmatch("cageSequence", "start_raise");
    thread maps\mp\mp_zombie_ark_aud::cage_up();
  } else {
    thread maps\mp\mp_zombie_ark_aud::cage_up();
    var_2 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_raise_crane", var_0.origin, var_0.angles, "cageSequence");
    var_1 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_raise_cage", var_0.origin, var_0.angles, "cageSequence");
  }

  var_1 waittillmatch("cageSequence", "close_pool");
  level thread closepooldoors(var_6, var_7, var_9, var_11, var_8);
  var_1 waittillmatch("cageSequence", "cage_dropout");

  if(isDefined(var_1.playerinside)) {
    var_1.playerinside unlink();
  }

  var_4 thread cagedoorbottomdropplayer(var_1, var_5);
  var_1 waittillmatch("cageSequence", "end");

  if(var_13) {
    level.zmbshark hide();
  }

  var_2 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_start_idle_crane", var_0.origin, var_0.angles, "cageSequence");
  var_1 scriptmodelplayanimdeltamotionfrompos("zark_sharkcage_start_idle_cage", var_0.origin, var_0.angles, "cageSequence");
  level notify("removeExtraPlayersStop");
}

dosharkcageoztaunt() {
  if(!maps\mp\zombies\_util::is_true(level.zmbaudioplayedsharkcage)) {
    wait 1;
    var_0 = 22;

    if(common_scripts\utility::cointoss()) {
      var_0 = 23;
    }

    if(announcerozglobalplaysq(var_0)) {
      level.zmbaudioplayedsharkcage = 1;
    }
  }
}

handleeyeball(var_0) {
  level endon("sqEyeballGrabDone");
  level thread handleeyeballend(var_0);
  level.zmbeyeball hudoutlineenableforclient(var_0.playerinside, 3, 0);
  var_0 waittillmatch("cageSequence", "get_eyeball_start");
  var_1 = level.zmbeyeball maps\mp\zombies\_zombies_sidequests::fake_use("grabbedEyeball", ::playerisincage, undefined, "sqEyeballGrabDone", 100);
  level.zmbeyeball delete();
  var_0.playerinside playergiveitem("eye");
  var_0.playerinside thread maps\mp\mp_zombie_ark_aud::grab_eyeball();
}

handleeyeballend(var_0) {
  var_0 waittillmatch("cageSequence", "get_eyeball_end");
  level notify("sqEyeballGrabDone");

  if(isDefined(level.zmbeyeball)) {
    level.zmbeyeball hudoutlinedisable();
  }
}

playerisincage() {
  return maps\mp\zombies\_util::is_true(self.insidecage);
}

waittillsharkready() {
  while(isDefined(level.zmbshark) && maps\mp\zombies\_util::is_true(level.zmbshark.circling)) {
    waitframe();
  }
}

closepooldoors(var_0, var_1, var_2, var_3, var_4) {
  var_0 moveto(var_2, 2, 1, 1);
  var_1 moveto(var_3, 2, 1, 1);
  var_0.unresolved_collision_func = undefined;
  var_1.unresolved_collision_func = undefined;
  wait 2.1;
  var_0.unresolved_collision_func = maps\mp\_movers::unresolved_collision_void;
  var_1.unresolved_collision_func = maps\mp\_movers::unresolved_collision_void;
}

poolclipon() {
  self dontinterpolate();
  self.origin = self.origin + (0, 0, 1000);
  self disconnectpaths();
}

poolclipoff() {
  self connectpaths();
  waitframe();
  self dontinterpolate();
  self.origin = self.origin + (0, 0, -1000);
}

cagedoorbottomdropplayer(var_0, var_1) {
  if(isDefined(var_0.playerinside)) {
    level thread cagefixplayerifwatersucks(var_0.playerinside);
  }

  self notsolid();
  wait 1.5;
  self solid();

  if(isDefined(var_0.playerinside)) {
    var_0.playerinside.insidecage = undefined;
  }

  level thread removeextraplayers(var_0, var_1);
}

cagefixplayerifwatersucks(var_0) {
  if(isDefined(var_0.disabledweaponswitch) && var_0.disabledweaponswitch > 0 && isDefined(var_0.disabledoffhandweapons) && var_0.disabledoffhandweapons > 0) {
    var_0 enableweaponpickup();
    var_0 common_scripts\utility::_enableweaponswitch();
    var_0 common_scripts\utility::_enableoffhandweapons();
  }

  var_1 = var_0 getcurrentprimaryweapon();

  if(issubstr(var_1, "combatknife")) {
    var_0 takeweapon(var_1);
    var_2 = var_0 getweaponslistprimaries();

    if(var_2.size > 0) {
      var_0 switchtoweapon(var_2[0]);
    }
  }

  var_0 notify("above_water");
  var_0 notify("out_of_water");
  var_0 notify("end_swimming");

  if(maps\mp\zombies\_util::is_true(var_0.isshocked)) {
    var_0 stopshellshock();
    var_0.isshocked = undefined;
  }

  if(!var_0 ishighjumpallowed() && maps\mp\zombies\_util::is_true(var_0.exosuitonline)) {
    var_0 maps\mp\_utility::playerallowhighjump(1);
    var_0 maps\mp\_utility::playerallowhighjumpdrop(1);
    var_0 maps\mp\_utility::playerallowboostjump(1);
    var_0 maps\mp\_utility::playerallowpowerslide(1);
    var_0 maps\mp\_utility::playerallowdodge(1);
  }
}

cagedoorclipopen() {
  self notsolid();
  self.open = 1;
}

cagedoorclipclose() {
  self solid();
  self.open = 0;
}

setclipwhenplayerjumpsin(var_0, var_1, var_2) {
  var_1 endon("timeout");
  var_0.playerinside = undefined;

  for(;;) {
    foreach(var_4 in level.players) {
      if(var_4 istouching(var_2)) {
        var_0.playerinside = var_4;
        var_4 playlocalsound("underwater_enter");
        var_4.insidecage = 1;
        level thread removeextraplayers(var_0, var_2);
        var_4 thread playerlinktocage(var_0);
        var_1 cagedoorclipclose();
        var_0 notify("playerJumpedIn");
        return;
      }
    }

    waitframe();
  }
}

removeextraplayers(var_0, var_1) {
  level endon("removeExtraPlayersStop");

  for(;;) {
    foreach(var_3 in level.players) {
      if(var_3 istouching(var_1) && !maps\mp\zombies\_util::is_true(var_3.insidecage)) {
        var_3 thread playerteleportoutofcage(var_1);
      }
    }

    waitframe();
  }
}

playerteleportoutofcage(var_0) {
  maps\mp\_movers::unresolved_collision_nearest_node(self, 1);
  wait 1;

  if(isalive(self) && !self istouching(var_0)) {
    level thread cagefixplayerifwatersucks(self);
  }
}

playerlinktocage(var_0) {
  self endon("disconnect");
  wait 0.5;
  self playerlinktodelta(var_0, "tag_origin", 1, 180, 180, 180, 180, 1);
}

playerhandlewaterdamageark() {
  level endon("game_ended");
  self endon("death");
  self endon("stopped_using_remote");
  self endon("disconnect");
  self endon("above_water");
  thread maps\mp\_water::onplayerdeath();
  wait 13;

  for(;;) {
    if((!isDefined(self.isjuggernaut) || self.isjuggernaut == 0) && !maps\mp\zombies\_util::is_true(self.insidecage)) {
      radiusdamage(self.origin + anglesToForward(self.angles) * 5, 1, 20, 20, undefined, "MOD_TRIGGER_HURT");
    }

    wait 1;
  }
}

code3_stage5_init() {}

code3_stage5_logic() {
  var_0 = getent("sqLocker1", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = spawnStruct();
  var_1.origin = (65, -496, 1023);
  var_2 = var_1 maps\mp\zombies\_zombies_sidequests::fake_use("doorUsed", ::playerhasitem, "eye", "code3_stage1_over", 80);
  var_2 playertakeitem("eye");
  thread maps\mp\mp_zombie_ark_aud::open_locker(var_1);
  var_0 rotateyaw(-80, 2, 0.5, 1);
  wait 2;
  var_3 = getent("sqCode4", "targetname");

  if(isDefined(var_3)) {
    var_3 show();
    var_2 = var_3 maps\mp\zombies\_zombies_sidequests::fake_use("got_code", ::playernotholdingcode);
    var_3 delete();
  }

  var_2 playergiveitem("code");
  var_2 thread maps\mp\mp_zombie_ark_aud::got_code();
  maps\mp\zombies\_zombies_sidequests::stage_completed("code3", "stage5");
}

code3_stage5_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Opened locker and retrieved code.");
}

init_code4_sidequest() {
  common_scripts\utility::flag_init("sq_plinko_a");
  common_scripts\utility::flag_init("sq_plinko_b");
  common_scripts\utility::flag_init("sq_plinko_c");
}

sidequest_code4_logic() {
  common_scripts\utility::flag_set("sq_plinko");
  maps\mp\zombies\_zombies_sidequests::stage_start("code4", "stage1");
  level waittill("code4_stage1_over");
  common_scripts\utility::flag_clear("sq_plinko");
}

code4_stage1_init() {
  level thread findsqplinkohint();
}

findsqplinkohint() {
  level.zmbfindgamblecustomvo = ::doplayerfoundplinkosq;
  var_0 = common_scripts\utility::getstructarray("plinko", "targetname");

  foreach(var_2 in var_0) {
    level thread maps\mp\zombies\_gambling::discoverplinkologic(var_2);
  }
}

doplayerfoundplinkosq(var_0, var_1) {
  var_2 = 24;

  if(common_scripts\utility::cointoss()) {
    var_2 = 25;
  }

  if(var_0 playerplaysqvo(var_2)) {
    level notify("discoverPlinkoLogic");
    return 1;
  }

  return 0;
}

code4_stage1_logic() {
  level thread doplinkooztaunt();

  for(;;) {
    var_0 = waituntilplinkocomplete();

    if(maps\mp\zombies\_util::is_true(var_0)) {
      break;
    }

    waitframe();
  }

  maps\mp\zombies\_zombies_sidequests::stage_completed("code4", "stage1");
}

doplinkooztaunt() {
  level common_scripts\utility::waittill_any("sq_plinko_a", "sq_plinko_b", "sq_plinko_c");
  var_0 = 26;

  if(common_scripts\utility::cointoss()) {
    var_0 = 27;
  }

  announcerozglobalplaysq(var_0);
}

waituntilplinkocomplete() {
  level endon("playerCountUpdate");
  common_scripts\utility::flag_wait("sq_plinko_a");
  common_scripts\utility::flag_wait("sq_plinko_b");
  var_0 = common_scripts\utility::flag_wait("sq_plinko_c");
  var_1 = getent("sqCode1", "targetname");

  if(isDefined(var_1)) {
    var_1 moveto((-124, 696, 998), 1.5, 0.1, 0.5);
    var_0 = var_1 maps\mp\zombies\_zombies_sidequests::fake_use("got_code", ::playernotholdingcode);
    var_1 delete();
  }

  if(isDefined(var_0)) {
    var_0 playergiveitem("code");
    var_0 thread maps\mp\mp_zombie_ark_aud::got_code();
  }

  return 1;
}

code4_stage1_end(var_0) {
  level.zmbfindgamblecustomvo = undefined;
  level notify("discoverPlinkoLogic");
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Retreived the passcode from the machine");
}

init_song_sidequest() {
  level.sq_song_ent = getent("sq_song", "targetname");

  if(!isDefined(level.sq_song_ent)) {
    level.sq_song_ent = spawn("script_model", (0, 0, 0));
  }
}

sidequest_logic_song() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  maps\mp\zombies\_zombies_sidequests::stage_start("song", "stage1");
  maps\mp\zombies\_zombies_sidequests::stage_start("song", "stage2");
  maps\mp\zombies\_zombies_sidequests::stage_start("song", "stage3");
  var_3 = 0;

  for(;;) {
    var_4 = level common_scripts\utility::waittill_any_return_no_endon_death("song_stage1_over", "song_stage2_over", "song_stage3_over");
    var_3++;

    if(var_3 < 3) {
      thread song_play(var_3);
      continue;
    }

    song_play(2);
    thread song_play();
    break;
  }
}

song_play(var_0) {
  level notify("sq_song_play");
  level endon("sq_song_play");
  level endon("sq_song_stop");

  if(maps\mp\zombies\_util::is_true(level.sq_song_ent.playing)) {
    level.sq_song_ent stopsounds();
    level.sq_song_ent.playing = 0;
    wait 0.2;
  }

  var_1 = "zmb_mus_ee_04";

  if(!isDefined(var_0) || var_0 <= 0) {
    var_0 = musiclength("zmb_mus_ee_04");
  } else {
    var_1 = "zmb_mus_ee_04_prvw";
  }

  level.sq_song_ent playsoundonmovingent(var_1);
  level.sq_song_ent.playing = 1;
  wait(var_0);
  level.sq_song_ent stopsounds();
  level.sq_song_ent.playing = 0;
}

song_stop() {
  level.sq_song_ent stopsounds();
  level.sq_song_ent.playing = 0;
  level notify("sq_song_stop");
}

song_fake_use(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_0;
  var_4 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", undefined, undefined, "song_stage" + var_1 + "_over", var_2, var_3);
  var_4 waittill("activated", var_5);
  return var_5;
}

songstage1_init() {}

songstage1_logic() {
  var_0 = song_fake_use((70, -502, 1079.5), 1, 120, 1);
  maps\mp\zombies\_zombies_sidequests::stage_completed("song", "stage1");
}

songstage1_end(var_0) {}

songstage2_init() {}

songstage2_logic() {
  var_0 = song_fake_use((966, 1958, 1074), 2, undefined, 1);
  maps\mp\zombies\_zombies_sidequests::stage_completed("song", "stage2");
}

songstage2_end(var_0) {}

songstage3_init() {}

songstage3_logic() {
  var_0 = song_fake_use((-923, -2166, 972), 3, 80, 1);
  maps\mp\zombies\_zombies_sidequests::stage_completed("song", "stage3");
}

songstage3_end(var_0) {}

musiclength(var_0) {
  var_1 = tablelookup("mp/sound/soundlength_zm_mp_dlc3.csv", 0, var_0, 1);

  if(!isDefined(var_1) || var_1 == "") {
    return 2;
  }

  var_1 = int(var_1);
  var_1 = var_1 * 0.001;
  return var_1;
}

playerplaysqvo(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("death");

  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  if(maps\mp\zombies\_util::is_true(self.speaking)) {
    self waittill("done_speaking");
  }

  var_3 = maps\mp\zombies\_zombies_audio::create_and_play_dialog("sq", "sq", undefined, var_0);

  if(maps\mp\zombies\_util::is_true(var_2)) {
    waitframe();
    waittilldonespeaking(self);
  }

  return var_3;
}

waittilldonespeaking(var_0) {
  var_0 endon("disconnect");

  if(maps\mp\zombies\_util::is_true(var_0.isspeaking)) {
    var_0 waittill("done_speaking");
  }
}

playsqvowaittilldone(var_0, var_1, var_2, var_3) {
  var_4 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix(var_0);

  if(isDefined(var_4)) {
    var_5 = var_4 playerplaysqvo(var_1, var_2, 1);

    if(isDefined(var_3)) {
      wait(var_3);
    }

    return var_5;
  }

  return 0;
}

announcerinworldplaysqvowaittilldone(var_0, var_1, var_2) {
  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  if(!isDefined(var_2)) {
    var_2 = level.players;
  }

  maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
  maps\mp\zombies\_zombies_audio_announcer::announcerinworlddialog("machine_all_players", var_0, level.sqarm.origin, undefined, undefined, undefined, undefined, var_2);
  maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
}

announcerglobalplaysqvo(var_0, var_1, var_2) {
  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  if(!isDefined(var_2)) {
    var_2 = level.players;
  }

  maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
  maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialog("global_priority", "sq", undefined, var_0, 1, undefined, var_2);
}

announcerglobalplaysqvowaittilldone(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = level.players;
  }

  announcerglobalplaysqvo(var_0, var_1, var_2);
  maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
}

announcerozglobalplaysqwaittilldone(var_0) {
  announcerozglobalplaysq(var_0);
  waittillannouncerozdonespeaking();
}

announcerozglobalplaysq(var_0, var_1) {
  if(isDefined(var_1)) {
    wait(var_1);
  }

  var_2 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
  return var_2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority", "sq", undefined, var_0, 1, undefined, level.players);
}

announcerozinworldplaysq(var_0, var_1, var_2) {
  var_3 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
  var_3.origin = var_0;
  waitframe();

  if(isDefined(var_2)) {
    var_2 = common_scripts\utility::array_removeundefined(var_2);
  }

  return var_3 maps\mp\zombies\_zombies_audio::create_and_play_dialog("machine_all_players", "sq", undefined, var_1, 1, undefined, var_2);
}

waittillannouncerozdonespeaking(var_0) {
  if(!isDefined(var_0)) {
    var_0 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
  }

  if(maps\mp\zombies\_util::is_true(var_0.isspeaking)) {
    var_0 waittill("done_speaking");
  }
}

zombiearmplaysqvo(var_0) {
  return level.sqarm maps\mp\zombies\_zombies_audio::create_and_play_dialog("machine_all_players", var_0);
}

set_side_quest_coop_data_ark() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1.joinedround1) || !var_1.joinedround1) {
      continue;
    }
    var_2 = var_1 getcoopplayerdatareservedint("eggData");
    var_2 = var_2 | 8;
    var_1.sidequest = 1;
    var_1 setcoopplayerdatareservedint("eggData", var_2);
    setmatchdata("players", var_1.clientid, "startPrestige", var_1.sidequest);
  }
}

runozextras() {
  level thread ozdoor();
}

ozphone() {
  var_0 = spawnStruct();
  var_0.origin = (-1644, 1083, 800);

  for(;;) {
    var_1 = var_0 maps\mp\zombies\_zombies_sidequests::fake_use("phone", undefined, undefined, undefined, 75, 1);
    var_2 = bulletTrace(var_1 getEye(), var_0.origin, 0, var_1, 0, 0, 0, 0, 0, 0, 0);

    if(var_2["fraction"] == 1) {
      if(announcerozglobalplaysq(21)) {
        return;
      }
    }

    wait 1;
  }
}

ozdoor() {
  var_0 = 62500;
  var_1 = common_scripts\utility::getstruct("sqEngineRoomDoor", "targetname");
  var_2 = [7, 8, 9, 10, 17, 18, 20];
  var_2 = common_scripts\utility::array_randomize(var_2);
  var_3 = 0;

  for(;;) {
    wait(randomintrange(240, 360));
    var_4 = [];

    foreach(var_6 in level.players) {
      if(var_6.origin[2] < 950) {
        continue;
      }
      var_7 = distance2dsquared(var_6.origin, var_1.origin);

      if(var_7 > var_0) {
        continue;
      }
      var_8 = vectornormalize((var_6.origin[0], var_6.origin[1], 0) - (var_1.origin[0], var_1.origin[1], 0));
      var_9 = anglesToForward(var_1.angles);
      var_10 = vectordot(var_8, var_9);

      if(var_10 > 0) {
        var_4[var_4.size] = var_6;
      }
    }

    if(var_4.size > 0) {
      announcerozinworldplaysq(var_1.origin, var_2[var_3], var_4);
      var_3++;

      if(var_3 >= var_2.size) {
        return;
      }
    }
  }
}