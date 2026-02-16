/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_boss_oz_stage1.gsc
*****************************************************/

#using_animtree("zombie_boss_oz_stage1_mp");

init() {
  level.runwavefunc["zombie_boss_oz_stage1"] = ::bossozstage1runwave;
  level.roundspawndelayfunc["zombie_boss_oz_stage1"] = ::bossozgetzombiespawndelay;
  level._effect["oz_room_destroyed_explode"] = loadfx("vfx/explosion/ambient_explosion_fireball");
  level._effect["oz_room_destroyed_fire"] = loadfx("vfx/fire/fire_lp_m_dim");
  level._effect["oz_teleport"] = loadfx("vfx/unique/dlc_teleport_soldier_bad");
  maps\mp\zombies\zombie_boss_oz_stage1_traps::init_traps();
  level.animnametoasset["zom_boss_st1_exposed_pain_left"] = % zom_boss_st1_exposed_pain_left;
  level.animnametoasset["zom_boss_st1_exposed_pain_right"] = % zom_boss_st1_exposed_pain_right;
  level.animnametoasset["zom_boss_st1_exposed_pain_head"] = % zom_boss_st1_exposed_pain_head;
  level.animnametoasset["zom_boss_st1_teleport_in"] = % zom_boss_st1_teleport_in;
  level.animnametoasset["zom_boss_st1_teleport_out"] = % zom_boss_st1_teleport_out;
  level.animnametoasset["zom_boss_st1_trap_mid"] = % zom_boss_st1_trap_mid;
  level.animnametoasset["zom_boss_st1_trap_right"] = % zom_boss_st1_trap_right;
  level.animnametoasset["zom_boss_st1_trap_left"] = % zom_boss_st1_trap_left;
  level.animnametoasset["zom_boss_st1_exposed_react"] = % zom_boss_st1_exposed_react;
  level.animnametoasset["zom_boss_st1_taunt_01"] = % zom_boss_st1_taunt_01;
  level.animnametoasset["zom_boss_st1_taunt_02"] = % zom_boss_st1_taunt_02;
  level.animnametoasset["zom_boss_st1_exposed_to_normal"] = % zom_boss_st1_exposed_to_normal;
}

bossozgetzombiespawndelay(var_0, var_1) {
  var_2 = 28.0;
  var_3 = [1.0, 0.78, 0.56, 0.34];
  var_4 = int(clamp(maps\mp\zombies\_util::getnumplayers() - 1, 0, 3));
  var_5 = var_3[var_4];
  var_6 = level.bossozrooms.size / level.totalnumbossozrooms;
  var_7 = var_2 * var_5 * var_6;
  return var_7;
}

setmaxpickups() {
  level endon("game_ended");
  var_0 = level.maxpickupsperround;
  var_1 = level.trappickupdisabled;
  level.maxpickupsperround = 99999;
  level.trappickupdisabled = 1;
  common_scripts\utility::waittill_any("zombie_wave_interrupt", "zombie_boss_wave_ended");
  level.maxpickupsperround = var_0;
  level.trappickupdisabled = var_1;
}

setwaverunningandspawnoz() {
  level.zombie_wave_running = 1;
  spawnoz();
  common_scripts\utility::waittill_any("zombie_wave_interrupt", "zombie_boss_wave_ended");
  maps\mp\zombies\zombie_boss_oz::zmbaudioresetozvoent();
  level.bossozstage1 delete();
  level.zombie_wave_running = 0;
}

spawnoz() {
  level.bossozstage1 = spawn("script_model", (0, 0, 0));
  level.bossozstage1.team = "axis";
  level.bossozstage1 setModel("zom_oz_boss_stage1");
  level.bossozstage1 maps\mp\zombies\_util::zombie_set_eyes("zombie_eye_host_janitor");
  level.bossozstage1.health = 999999;
  level.bossozstage1.maxhealth = 999999;
  level.bossozstage1 thermaldrawenable();

  foreach(var_1 in level.players) {
    level.bossozstage1 threatdetectedtoplayer(var_1);
  }
}

initozrooms() {
  level.bossozrooms = common_scripts\utility::getStructArray("boss_oz_spot", "targetname");

  foreach(var_1 in level.bossozrooms) {
    var_1.explosion_locations = [];
    var_1.fire_locations = [];
    var_2 = common_scripts\utility::array_combine(getEntArray(var_1.target, "targetname"), common_scripts\utility::getStructArray(var_1.target, "targetname"));

    foreach(var_4 in var_2) {
      if(var_4.script_noteworthy == "door") {
        var_1.doorbrushmodel = var_4;
        continue;
      }

      if(var_4.script_noteworthy == "explosion_origin") {
        var_1.explosion_locations[var_1.explosion_locations.size] = var_4;
        continue;
      }

      if(var_4.script_noteworthy == "fire_origin") {
        var_1.fire_locations[var_1.fire_locations.size] = var_4;
      }
    }

    if(isDefined(var_1.doorbrushmodel.startorigin)) {
      var_1.doorbrushmodel.origin = var_1.doorbrushmodel.startorigin;
    } else {
      var_1.doorbrushmodel.startorigin = var_1.doorbrushmodel.origin;
    }

    if(level.nextgen) {
      var_6 = getscriptablearray("scriptable_boss_oz_room", "targetname");
      var_1.scriptablelight = common_scripts\utility::get_array_of_closest(var_1.origin, var_6)[0];
      var_1.scriptablelight setscriptablepartstate(0, 6);
    }

    foreach(var_8 in var_1.fire_locations) {
      if(isDefined(var_8.fx)) {
        var_8.fx delete();
      }
    }
  }

  level.totalnumbossozrooms = level.bossozrooms.size;
}

bossozstage1runwave(var_0) {
  level endon("game_ended");
  thread maps\mp\mp_zombie_h2o_aud::sndbossozstartstage1();
  runwave(var_0);
  level notify("zombie_stop_spawning");

  if(isDefined(level.bossozstage1.lastattacker)) {
    var_1 = level.bossozstage1.lastattacker.origin;
  } else {
    var_1 = common_scripts\utility::random(level.players).origin;
  }

  maps\mp\gametypes\zombies::createpickup("nuke", var_1, "Boss Oz Wave 1 Complete - Nuke");
  maps\mp\gametypes\zombies::createpickup("ammo", var_1, "Boss Oz Wave 1 Complete - Max Ammo");
  givebossozstage1achievement();
  level notify("zombie_boss_wave_ended");
  level waittill("zombie_wave_ended");
}

moveoztoroom(var_0) {
  playFX(common_scripts\utility::getfx("oz_teleport"), level.bossozstage1.origin, (1, 0, 0), (0, 0, 1));
  level.bossozstage1 notify("teleport");
  level.bossozstage1.origin = var_0.origin;
  level.bossozstage1.angles = var_0.angles;
  level.bossozstage1.animnode = var_0;
  level.bossozstage1 thread ozplayanimthenidle("zom_boss_st1_teleport_in");
  level.bossozstage1.damagetaken = 0;
  level.bossozstage1.inpainanim = 0;
  playFX(common_scripts\utility::getfx("oz_teleport"), level.bossozstage1.origin, (1, 0, 0), (0, 0, 1));

  if(level.nextgen) {
    var_0.scriptablelight setscriptablepartstate(0, 0);
  }
}

taunttoolongtodamage() {
  level endon("game_ended");
  level endon("zombie_boss_wave_ended");
  level endon("zombie_wave_interrupt");
  level.bossozstage1 endon("damage_taken");
  wait 20;
  var_0 = 3;

  for(;;) {
    var_1 = maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("toolong", 1);

    if(var_1) {
      var_0--;

      if(var_0 <= 0) {
        return;
      } else {
        wait 15;
      }

      continue;
    }

    wait 1;
  }
}

doshieldupvo(var_0) {
  level endon("end_spawn_wait");
  wait 1;
  maps\mp\zombies\zombie_boss_oz::zmbaudioangplayvo("stage1_shield", 1);
  maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("shieldup", 1, var_0);
  maps\mp\zombies\zombie_boss_oz::zmbaudioplayervo("shieldup", 1);
}

runwave(var_0) {
  level endon("zombie_wave_interrupt");
  thread setmaxpickups();
  thread setwaverunningandspawnoz();
  initozrooms();
  maps\mp\zombies\zombie_boss_oz_stage1_traps::begin_round_init_traps();
  var_1 = [99999, 20, 15, 10];
  var_2 = 2.5;
  level.totalaispawned = 0;
  level.maxenemycount = maps\mp\zombies\zombies_spawn_manager::getmaxenemycount();
  var_3 = common_scripts\utility::random(level.bossozrooms);
  moveoztoroom(var_3);
  wait 1.5;
  maps\mp\zombies\zombie_boss_oz::zmbaudioangplayvo("stage1_start", 1);
  maps\mp\zombies\zombie_boss_oz::zmbaudiochangeozvotoplayonent(level.bossozstage1);
  maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("tele2", 1);
  maps\mp\zombies\zombie_boss_oz::zmbaudioplayervo("ozsee", 1);
  wait 1.0;
  maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("intro", 1);
  var_4 = 0;
  var_5 = 0;

  while(level.bossozrooms.size > 0) {
    var_6 = getstage1phase();

    if(var_6 > 0) {
      if(!var_5) {
        var_5 = 1;
        level notify("activate_terminals");
      }

      if(!var_4) {
        var_4 = 1;
        maps\mp\zombies\zombie_boss_oz::startinfinitezombiespawning();
      }

      var_3 = common_scripts\utility::random(level.bossozrooms);
      moveoztoroom(var_3);
      wait 5;
    }

    var_7 = 1;
    var_8 = var_6;

    while(var_7) {
      var_9 = var_6 > 0;

      if(var_9) {
        maps\mp\zombies\zombie_boss_oz_stage1_traps::run_trap_sequence(var_8);
      }

      maps\mp\zombies\_util::waittillzombiegameunpaused();
      var_10 = undefined;

      if(var_6 == 0) {
        var_10 = 1;
      }

      level thread doshieldupvo(var_10);
      playsoundatpos(var_3.origin, "oz_s1_location_open");
      level.bossozstage1 thread ozplayanimthenidle("zom_boss_st1_exposed_react", "zom_boss_st1_exposed_idle");
      var_3 oz_room_open_door(1, var_2);
      make_oz_damageable(1);

      if(var_6 == 0) {
        level thread taunttoolongtodamage();
      }

      var_11 = level.bossozstage1 common_scripts\utility::waittill_any_timeout(var_1[var_6] + var_2, "oz_phase_defeated");
      make_oz_damageable(0);

      if(var_11 == "timeout") {
        playsoundatpos(var_3.origin, "oz_s1_location_close");
        var_3 oz_room_open_door(0, 0.5);
        level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("shielddown", 0);
        var_8 = 1;
        level.bossozstage1 thread ozplayanimthenidle("zom_boss_st1_exposed_to_normal");
        wait 3.0;
        continue;
      }

      var_7 = 0;
      level.bossozrooms = common_scripts\utility::array_remove(level.bossozrooms, var_3);
      level notify("end_spawn_wait");
      level.bossozstage1 ozplayanimuntilnotetrack("zom_boss_st1_teleport_out", "teleport");

      foreach(var_13 in var_3.explosion_locations) {
        playFX(common_scripts\utility::getfx("oz_room_destroyed_explode"), var_13.origin, anglesToForward(var_13.angles), (0, 0, 1));
      }

      foreach(var_13 in var_3.fire_locations) {
        var_13.fx = spawnfx(common_scripts\utility::getfx("oz_room_destroyed_fire"), var_13.origin, anglesToForward(var_13.angles), (0, 0, 1));
        thread maps\mp\mp_zombie_h2o_aud::sndbossozfire(var_13.origin);
        triggerfx(var_13.fx);
      }

      earthquake(0.5, 1.0, var_3.origin, 10000);
      playsoundatpos(var_3.origin, "oz_s1_location_destroyed");

      if(level.nextgen) {
        var_3.scriptablelight setscriptablepartstate(0, 7);
      }

      if(var_6 != 3) {
        level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("progress", 0, undefined, 2);
      }

      var_17 = int(clamp(var_6 + 1, 1, 4));
      var_18 = "zm_boss_phase" + var_17;

      foreach(var_20 in level.players) {
        var_20 thread maps\mp\_matchdata::loggameevent(var_18, var_20.origin);
      }
    }
  }
}

givebossozstage1achievement() {
  foreach(var_1 in level.players) {
    var_1 maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_DEFEATBOSS1");
  }
}

getstage1phase() {
  var_0 = level.totalnumbossozrooms - level.bossozrooms.size;
  return var_0;
}

oz_room_open_door(var_0, var_1) {
  if(var_0) {
    self.doorbrushmodel moveto(self.doorbrushmodel.startorigin + (0, 0, 160), var_1);
  } else {
    self.doorbrushmodel moveto(self.doorbrushmodel.startorigin, var_1);
  }
}

make_oz_damageable(var_0) {
  if(var_0) {
    level.bossozstage1 setCanDamage(1);
    level.bossozstage1 setdamagecallbackon(1);
    level.bossozstage1.damagecallback = ::ozhandledamagecallback;
  } else {
    level.bossozstage1 setCanDamage(0);
    level.bossozstage1 setdamagecallbackon(0);
    level.bossozstage1.damagecallback = undefined;
  }
}

ozgetbaseweaponname(var_0) {
  var_1 = getweaponbasename(var_0);

  if(!isDefined(var_1)) {
    var_1 = "none";
  }

  if(isDefined(level.damageweapontoweapon[var_1])) {
    var_1 = level.damageweapontoweapon[var_1];
  }

  return var_1;
}

ozmodifydamage(var_0, var_1, var_2, var_3, var_4) {
  if(var_1.team == self.team) {
    return 0;
  }

  var_5 = ozscaledamageforkillstreakorweaponlevel(var_0, var_1, var_2, var_3, var_4);
  var_2 = ozgetbaseweaponname(var_2);

  if(var_2 == "iw5_fusionzm_mp") {
    var_5 = int(var_5 * 0.7);
  }

  if(var_2 == "iw5_rhinozm_mp") {
    var_5 = int(var_5 * 0.7);
  }

  if(var_2 == "iw5_linegunzm_mp") {
    var_5 = int(var_5 * 0.7);
  }

  if(var_2 == "iw5_tridentzm_mp") {
    var_5 = int(var_5 * 0.7);
  }

  return var_5;
}

ozscaledamageforkillstreakorweaponlevel(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_4;
  var_6 = maps\mp\zombies\killstreaks\_zombie_killstreaks::modifydamagekillstreak(var_0, var_1, var_4, var_2, var_3);

  if(var_6 != var_5) {
    var_5 = int(var_6 * 0.25);
  }

  var_7 = ozgetbaseweaponname(var_2);

  if(maps\mp\zombies\_util::haszombieweaponstate(var_1, var_7)) {
    var_8 = 0.2;

    if(isDefined(var_1.weaponstate[var_7]["weapon_level_increase"])) {
      var_8 = var_1.weaponstate[var_7]["weapon_level_increase"];
    }

    var_5 = int(var_5 + var_5 * var_8 * (var_1.weaponstate[var_7]["level"] - 1));
  }

  return var_5;
}

ozhurtvo() {
  level.bossozstage1 endon("death");

  if(maps\mp\zombies\zombie_boss_oz::anyplayersspeaking() || maps\mp\zombies\_zombies_audio_announcer::isanyannouncerspeaking()) {
    return;
  }
  if(!maps\mp\zombies\_util::is_true(level.bossozstage1.playedfirsthurtvo)) {
    level.bossozstage1.playedfirsthurtvo = maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("hurt", 0, 2, undefined, undefined, 1);
  } else {
    maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("hurt", 0, undefined, undefined, undefined, 1);
  }
}

ozhandledamagecallback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = ozmodifydamage(var_0, var_1, var_5, var_4, var_2);
  level.bossozstage1.damagetaken = level.bossozstage1.damagetaken + var_12;
  level.bossozstage1 notify("damage_taken");
  level thread ozhurtvo();

  if(var_12 > 0) {
    var_1 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("boss_oz_trigger");
    var_1 maps\mp\gametypes\zombies::givepointsfordamage(self, var_2, var_4, var_5, var_6, var_7, var_8, 0);
    self.lastattacker = var_1;

    if(!self.inpainanim) {
      thread ozplaypainanim();
    }
  }

  if(level.bossozstage1.damagetaken >= int(4900 * maps\mp\zombies\_util::getnumplayers())) {
    self notify("oz_phase_defeated", var_1);
  }
}

ozplaypainanim() {
  self endon("death");
  var_0 = common_scripts\utility::random(["zom_boss_st1_exposed_pain_head", "zom_boss_st1_exposed_pain_left", "zom_boss_st1_exposed_pain_right"]);
  self.inpainanim = 1;
  ozplayanimthenidle(var_0, "zom_boss_st1_exposed_idle");
  self.inpainanim = 0;
}

ozplaytrapanim(var_0) {
  level.bossozstage1 endon("death");
  var_1 = common_scripts\utility::random(["zom_boss_st1_trap_mid", "zom_boss_st1_trap_right", "zom_boss_st1_trap_left"]);
  level.bossozstage1 ozplayanimthenidle(var_1);
  level.bossozstage1.trapfinishedanimtime = gettime() + int(var_0 * 1000.0);
}

ozplayanim(var_0) {
  self scriptmodelplayanimdeltamotionfrompos(var_0, self.animnode.origin, self.animnode.angles, undefined, 1);
  self notify("playAnim");
}

ozplayanimthenidle(var_0, var_1) {
  self endon("death");
  var_2 = level.animnametoasset[var_0];
  var_3 = getanimlength(var_2);
  ozplayanim(var_0);
  self endon("playAnim");
  wait(var_3);

  if(isDefined(var_1)) {
    ozplayanim(var_1);
  } else {
    thread ozplaydefaultidle();
  }
}

ozplayanimuntilnotetrack(var_0, var_1) {
  var_2 = level.animnametoasset[var_0];
  var_3 = getnotetracktimes(var_2, var_1)[0];
  ozplayanim(var_0);
  wait(var_3);
  self scriptmodelclearanim();
}

ozplaydefaultidle() {
  self endon("death");
  ozplayanim("zom_boss_st1_idle");
  self endon("playAnim");
  wait(randomfloatrange(5.0, 10.0));

  if(!isDefined(self.trapfinishedanimtime) || level.bossozstage1.trapfinishedanimtime - gettime() > 10000) {
    thread ozplayanimthenidle(common_scripts\utility::random(["zom_boss_st1_taunt_01", "zom_boss_st1_taunt_02"]));
  }
}