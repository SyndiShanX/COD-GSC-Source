/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_pickups_dlc3.gsc
*********************************************/

init() {
  level._effect["pickup_inf_ammo"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_inf_ammo");
  level._effect["pickup_overcharge"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_overcharge");
  level._effect["dlc_orbiter"] = loadfx("vfx/gameplay/mp/zombie/dlc_orbiter");
  level._effect["dlc3_orbiter_screen"] = loadfx("vfx/ui/dlc/dlc3_orbiter_screen");
  level.pickup["unlimited_ammo"]["func"] = ::unlimitedammopickup;
  level.pickup["unlimited_ammo"]["fx"] = "pickup_inf_ammo";
  level.pickup["explosive_touch"]["func"] = ::explosivetouchpickup;
  level.pickup["explosive_touch"]["fx"] = "pickup_overcharge";
  level.pickup["insta_kill"] = undefined;
  maps\mp\gametypes\zombies::randomizepickuplist();
  maps\mp\_utility::gameflaginit("explosive_touch", 0);
  maps\mp\_utility::gameflaginit("unlimited_ammo", 0);
}

canspawnpickup(var_0, var_1, var_2, var_3) {
  if(maps\mp\_utility::gameflag("explosive_touch")) {
    return 0;
  }

  return 1;
}

unlimitedammopickup(var_0) {
  showteamsplashzombies("zombie_infinite_ammo");
  var_0 playlocalsound("powerup_overcharge_start");
  level thread activateunlimitedammo();
  maps\mp\zombies\_zombies_audio_announcer::announcerpickupdialog("open_fire", var_0);
  level thread maps\mp\gametypes\zombies::removepickup(self);
}

activateunlimitedammo() {
  level notify("unlimited_ammo_start");
  level endon("unlimited_ammo_start");
  level thread maps\mp\gametypes\zombies::setendtimeomnvarwithhostmigration("ui_zm_infinite_ammo", gettime() + 20000);
  maps\mp\_utility::gameflagset("unlimited_ammo");
  setupammoforplayers();

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("zm_unlimited_ammo", 1);
  }

  level thread onplayerspawnedunlimitedammo();
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(20);
  maps\mp\_utility::gameflagclear("unlimited_ammo");

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("zm_unlimited_ammo", 0);
    var_1 playlocalsound("powerup_overcharge_end");
  }

  level notify("unlimited_ammo_end");
}

onplayerspawnedunlimitedammo() {
  level endon("unlimited_ammo_start");
  level endon("unlimited_ammo_end");

  while(maps\mp\_utility::gameflag("unlimited_ammo")) {
    level waittill("player_spawned", var_0);
    var_0 setclientomnvar("zm_unlimited_ammo", 1);
  }
}

setupammoforplayers() {
  foreach(var_1 in level.players) {
    if(isalive(var_1)) {
      var_1 thread playergiveoneinclip();
    }
  }
}

playergiveoneinclip() {
  self endon("death");
  self endon("disconnect");
  var_0 = self getweaponslistprimaries();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(issubstr(var_3, "em1")) {
      waittillframeend;
      var_4 = maps\mp\zombies\_util::playergetem1ammo();

      if(var_4 == 0) {
        maps\mp\zombies\_util::playerrecordem1ammo(1);
        maps\mp\zombies\_util::playerallowfire(1, "em1");
        var_1[var_1.size] = var_3;
      }

      continue;
    }

    var_5 = 0;
    var_4 = self getweaponammoclip(var_3, "right");

    if(var_4 == 0) {
      self setweaponammoclip(var_3, 1, "right");
      var_1[var_1.size] = var_3;
      var_5 = 1;
    }

    if(issubstr(var_3, "akimbo")) {
      var_4 = self getweaponammoclip(var_3, "left");

      if(var_4 == 0) {
        self setweaponammoclip(var_3, 1, "left");

        if(!var_5) {
          var_1[var_1.size] = var_3;
        }
      }
    }
  }

  if(var_1.size == 0) {
    return;
  }
  level waittill("unlimited_ammo_end");

  foreach(var_3 in var_1) {
    if(!self hasweapon(var_3)) {
      continue;
    }
    if(issubstr(var_3, "em1")) {
      waittillframeend;
      var_4 = maps\mp\zombies\_util::playergetem1ammo();

      if(var_4 == 1) {
        maps\mp\zombies\_util::playerrecordem1ammo(0);
        var_8 = self getcurrentprimaryweapon();

        if(issubstr(var_8, "em1")) {
          maps\mp\zombies\_util::playerallowfire(0, "em1");
        }
      }

      continue;
    }

    var_4 = self getweaponammoclip(var_3, "right");

    if(var_4 == 1) {
      self setweaponammoclip(var_3, 0, "right");
    }

    if(issubstr(var_3, "akimbo")) {
      var_4 = self getweaponammoclip(var_3, "left");

      if(var_4 == 1) {
        self setweaponammoclip(var_3, 0, "left");
      }
    }
  }
}

explosivetouchpickup(var_0) {
  showteamsplashzombies("zombie_overcharge");
  var_0 playlocalsound("zmb_pickup_general");
  level thread activateexplosivetouch();
  maps\mp\zombies\_zombies_audio_announcer::announcerpickupdialog("ex_touch", var_0);
  level thread maps\mp\gametypes\zombies::removepickup(self);
}

activateexplosivetouch() {
  level notify("explosive_touch_start");
  level endon("explosive_touch_start");
  level thread maps\mp\gametypes\zombies::setendtimeomnvarwithhostmigration("ui_zm_overcharge", gettime() + 20000);
  level thread cleanupgodmode();
  maps\mp\_utility::gameflagset("explosive_touch");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1.crategodmode)) {
      var_1.crategodmode = 0;
    }

    var_1.crategodmode++;
    var_1 thread playerdoexplosivetouch();
    var_1 playlocalsound("powerup_explosive_touch");
  }

  if(!isDefined(level.zmbexplosivetouchfp)) {
    level.zmbexplosivetouchfp = spawnfx(common_scripts\utility::getfx("dlc3_orbiter_screen"), (0, 0, 0));
    triggerfx(level.zmbexplosivetouchfp);
  }

  explosivetouchwait();

  if(isDefined(level.zmbexplosivetouchfp)) {
    level.zmbexplosivetouchfp delete();
  }

  level notify("explosive_touch_complete");
  maps\mp\_utility::gameflagclear("explosive_touch");
}

explosivetouchwait() {
  level endon("game_ended");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(20);
}

cleanupgodmode() {
  waitframe();
  level common_scripts\utility::waittill_any("explosive_touch_start", "explosive_touch_complete");

  foreach(var_1 in level.players) {
    if(isDefined(var_1.crategodmode)) {
      var_1.crategodmode--;
    }
  }
}

playerplayexplosivetoucheffect() {
  level endon("explosive_touch_start");
  self endon("disconnect");

  if(!isDefined(self.explosivetouchent)) {
    thread playerthirdpersonexplosivetoucheffects();
    thread playerhandleeffectsdeath();
    thread playerhandleeffectshostmigration();
    thread playerhandleeffectsdisconnect();
  }

  level waittill("explosive_touch_complete");
  maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"), self.explosivetouchent, "j_prop_1");
  maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"), self.explosivetouchent, "j_prop_2");
  maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"), self.explosivetouchent, "j_prop_3");
  maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"), self.explosivetouchent, "j_prop_4");
  self.explosivetouchent thread delaydeleteent(1);
  self.explosivetouchent = undefined;
}

playerthirdpersonexplosivetoucheffects() {
  self endon("disconnect");

  if(!isDefined(self.explosivetouchent)) {
    self.explosivetouchent = spawn("script_model", (0, 0, 0));
    self.explosivetouchent setModel("genericprop_x5");
    waitframe();
    self.explosivetouchent linktosynchronizedparent(self, "tag_origin", (0, 0, 0), (0, 0, 0));
    waitframe();
    self.explosivetouchent scriptmodelplayanim("dlc3_explosive_touch_prop_anim", "explosive_touch");
    self.explosivetouchent deleteonhostmigration();
    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"), self.explosivetouchent, "j_prop_1");
    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"), self.explosivetouchent, "j_prop_2");
    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"), self.explosivetouchent, "j_prop_3");
    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"), self.explosivetouchent, "j_prop_4");
  }
}

playerhandleeffectsdisconnect() {
  level endon("explosive_touch_complete");
  var_0 = self.explosivetouchent;
  self waittill("disconnect");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("death");
  maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"), var_0, "j_prop_1");
  maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"), var_0, "j_prop_2");
  maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"), var_0, "j_prop_3");
  maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("dlc_orbiter"), var_0, "j_prop_4");
  var_0 thread delaydeleteent(1);
}

playerhandleeffectshostmigration() {
  level endon("explosive_touch_complete");
  self endon("disconnect");

  for(;;) {
    level waittill("host_migration_end");
    thread playerthirdpersonexplosivetoucheffects();
  }
}

delaydeleteent(var_0) {
  self endon("death");
  wait(var_0);
  self delete();
}

playerhandleeffectsdeath() {
  level endon("explosive_touch_complete");
  self endon("disconnect");
  self waittill("death");
  self.explosivetouchent hide();
  updatefirstpersonfx();
  self waittill("spawned_player");
  self.explosivetouchent show();
  self.explosivetouchent linktosynchronizedparent(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  updatefirstpersonfx();
}

updatefirstpersonfx() {
  if(!isDefined(level.zmbexplosivetouchfp)) {
    return;
  }
  level.zmbexplosivetouchfp hide();

  foreach(var_1 in level.players) {
    if(isalive(var_1)) {
      level.zmbexplosivetouchfp showtoplayer(var_1);
    }
  }
}

playerdoexplosivetouch() {
  self endon("disconnect");
  level endon("explosive_touch_start");
  level endon("explosive_touch_complete");
  var_0 = 3600;
  self.overchargekills = 0;
  thread playerplayexplosivetoucheffect();

  for(;;) {
    if(!isalive(self)) {
      waitframe();
      continue;
    }

    var_1 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

    foreach(var_3 in var_1) {
      if(var_3.team != level.enemyteam) {
        continue;
      }
      if(!isalive(var_3)) {
        continue;
      }
      if(var_3 maps\mp\zombies\_util::instakillimmune()) {
        continue;
      }
      var_4 = distancesquared(self.origin, var_3.origin);

      if(var_4 < var_0) {
        var_3 dodamage(var_3.health, var_3.origin, self, undefined, "MOD_EXPLOSIVE", "explosive_touch_zombies_mp", "torso_upper");
        earthquake(randomfloatrange(0.35, 0.55), 1, self.origin, 200, self);
        self playrumbleonentity("damage_heavy");
        self _meth_8569();
        self.overchargekills++;

        if(self.overchargekills == 20) {
          maps\mp\gametypes\zombies::givezombieachievement("DLC3_ZOMBIE_OVERCHARGE");
        }
      }
    }

    waitframe();
  }
}

gettimedpickupstring(var_0, var_1, var_2) {
  var_3 = 20;
  var_4 = level.pickuphuds[var_2];

  if(!isDefined(var_4)) {
    var_4 = maps\mp\gametypes\_hud_util::createserverfontstring("hudbig", 1.0);
    var_4 maps\mp\gametypes\_hud_util::setpoint("BOTTOM", undefined, 0, -70 - var_3 * level.pickuphuds.size);
    var_4.label = var_0;

    foreach(var_6 in level.pickuphuds) {
      var_4 thread updatetimedpickuphudpos(var_6, var_3);
    }

    level.pickuphuds[var_2] = var_4;
  }

  var_4.color = (1, 1, 1);
  var_4 settimer(var_1);
  return var_4;
}

updatetimedpickuphudpos(var_0, var_1) {
  self endon("death");
  var_0 waittill("death");
  self.y = self.y + var_1;
}

timedpickuphud(var_0, var_1, var_2) {
  level notify("pickupHud_" + var_2);
  level endon("pickupHud_" + var_2);

  if(!isDefined(level.pickuphuds)) {
    level.pickuphuds = [];
  }

  var_3 = 3;
  var_4 = gettimedpickupstring(var_0, var_1, var_2);

  if(var_1 > var_3) {
    wait(var_1 - var_3);
  }

  var_4.color = (1, 0, 0);
  wait(var_3);
  var_4 destroy();
  level.pickuphuds[var_2] = undefined;
}

showteamsplashzombies(var_0) {
  foreach(var_2 in level.players) {
    if(maps\mp\zombies\_util::isonhumanteam(var_2) && maps\mp\_utility::isreallyalive(var_2)) {
      var_2 thread maps\mp\gametypes\_hud_message::splashnotify(var_0);
    }
  }
}