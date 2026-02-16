/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42955.gsc
**************************************/

init() {
  level.orbitalsupportoverrides = spawnStruct();
  level.orbitalsupportoverrides.spawnorigin = undefined;
  level.orbitalsupportoverrides.spawnangle = undefined;
  level.orbitalsupportoverrides.spawnanglemax = undefined;
  level.orbitalsupportoverrides.spawnanglemin = undefined;
  level.orbitalsupportoverrides.spawnradius = undefined;
  level.orbitalsupportoverrides.spawnheight = undefined;
  level.orbitalsupportoverrides.speed = undefined;
  level.orbitalsupportoverrides.turretpitch = undefined;
  level.orbitalsupportoverrides.leftarc = undefined;
  level.orbitalsupportoverrides.rightarc = undefined;
  level.orbitalsupportoverrides.toparc = undefined;
  level.orbitalsupportoverrides.bottomarc = undefined;

  if(isDefined(level.orbitalsupportoverridefunc)) {
    [[level.orbitalsupportoverridefunc]]();
  }

  level.orbitalsupport_use_duration = 40;
  level.orbitalsupport_speed = 123;

  if(isDefined(level.orbitalsupportoverrides.speed)) {
    level.orbitalsupport_speed = level.orbitalsupportoverrides.speed;
  }

  var_0 = getEntArray("minimap_corner", "targetname");
  var_1 = (0, 0, 0);

  if(var_0.size) {
    var_1 = maps\mp\gametypes\_spawnlogic::findboxcenter(var_0[0].origin, var_0[1].origin);
  }

  if(isDefined(level.orbitalsupportoverrides.spawnorigin)) {
    var_1 = level.orbitalsupportoverrides.spawnorigin;
  }

  level.osprig = spawn("script_model", var_1);
  level.osprig setModel("c130_zoomrig");
  level.osprig.angles = (0, 115, 0);
  level.osprig hide();
  thread rotateplane(level.orbitalsupport_speed);
  level._effect["orbitalsupport_cloud"] = loadfx("vfx/cloud/orbitalsupport_cloud");
  level._effect["orbitalsupport_rocket_explode_player"] = loadfx("vfx/explosion/rocket_explosion_distant");
  level._effect["orbitalsupport_entry"] = loadfx("vfx/vehicle/vehicle_osp_enter_clouds_parent");
  level._effect["orbitalsupport_entry_complete"] = loadfx("vfx/vehicle/vehicle_osp_enter_shock");
  level._effect["vehicle_osp_jet"] = loadfx("vfx/vehicle/vehicle_osp_jet");
  level._effect["vehicle_osp_jet_lg"] = loadfx("vfx/vehicle/vehicle_osp_jet_lg");
  level._effect["vehicle_osp_rocket_marker"] = loadfx("vfx/unique/vfx_marker_killstreak_guide");
  level._effect["vehicle_osp_jet_lg_trl"] = loadfx("vfx/vehicle/vehicle_osp_jet_lg_trl");
  level._effect["orbitalsupport_entry_flash"] = loadfx("vfx/vehicle/vehicle_osp_enter_flash");
  level._effect["orbitalsupport_explosion"] = loadfx("vfx/explosion/vehicle_mil_blimp_explosion");
  level._effect["orbitalsupport_explosion_jet"] = loadfx("vfx/explosion/vehicle_mil_blimp_explosion_jet");
  level._effect["orbitalsupport_light"] = loadfx("vfx/lights/vehicle_osp_light");
  level.physicssphereradius["orbitalsupport_40mm_mp"] = 600;
  level.physicssphereradius["orbitalsupport_40mmbuddy_mp"] = 600;
  level.physicssphereradius["orbitalsupport_105mm_mp"] = 1000;
  level.physicssphereforce["orbitalsupport_40mm_mp"] = 3.0;
  level.physicssphereforce["orbitalsupport_40mmbuddy_mp"] = 3.0;
  level.physicssphereforce["orbitalsupport_105mm_mp"] = 6.0;
  level.orbitalsupportinuse = 0;
  level thread onorbitalsupportplayerconnect();
  level.killstreakfuncs["orbitalsupport"] = ::tryuseorbitalsupport;
  level.killstreakwieldweapons["orbitalsupport_105mm_mp"] = "orbitalsupport";
  level.killstreakwieldweapons["orbitalsupport_40mm_mp"] = "orbitalsupport";
  level.killstreakwieldweapons["orbitalsupport_40mmbuddy_mp"] = "orbitalsupport";
  level.killstreakwieldweapons["orbitalsupport_big_turret_mp"] = "orbitalsupport";
  level.killstreakwieldweapons["orbitalsupport_missile_mp"] = "orbitalsupport";
  level.orbitalsupport_chatter_timer = 0;
  level.orbitalsupport_buddy_chatter_timer = 0;
  game["dialog"]["assist_mp_paladin"] = "ks_paladin_joinreq";
  game["dialog"]["pilot_sup_mp_paladin"] = "pilot_sup_mp_paladin";
  game["dialog"]["pilot_aslt_mp_paladin"] = "pilot_aslt_mp_paladin";
  game["dialog"]["copilot_sup_mp_paladin"] = "copilot_sup_mp_paladin";
  game["dialog"]["copilot_aslt_mp_paladin"] = "copilot_aslt_mp_paladin";
  game["dialog"]["copilot_enemykill_mp_paladin"] = "copilot_enemykill_mp_paladin";
  game["dialog"]["copilot_marked_mp_paladin"] = "copilot_marked_mp_paladin";
}

tryuseorbitalsupport(var_0, var_1) {
  if(isDefined(level.orbitalsupport_player) || level.orbitalsupportinuse) {
    self iprintlnbold(&"MP_ORBITALSUPPORT_IN_USE");
    return 0;
  }

  level.orbitalsupportinuse = 1;
  thread playerclearorbitalsupportonteamchange();
  var_2 = maps\mp\killstreaks\_killstreaks::initridekillstreak("paladin", 0, undefined, 3.0);

  if(var_2 != "success") {
    level.orbitalsupportinuse = 0;
    return 0;
  }

  maps\mp\_utility::setusingremote("orbitalsupport");
  thread setorbitalsupportplayer(self, var_1);
  maps\mp\_matchdata::logkillstreakevent("orbitalsupport", self.origin);
  level.orbitalsupport_planemodel.crashed = undefined;
  return 1;
}

playerclearorbitalsupportonteamchange() {
  self endon("rideKillstreakBlack");
  self waittill("joined_team");
  level.orbitalsupportinuse = 0;
}

setorbitalsupportplayer(var_0, var_1) {
  self endon("orbitalsupport_player_removed");
  self endon("disconnect");
  level.orbitalsupport_player = var_0;
  var_0 maps\mp\_utility::playersaveangles();
  var_0 orbitalsupport_spawn();
  level.orbitalsupport_planemodel.incomingmissile = 0;
  level.orbitalsupport_planemodel.vehicletype = "paladin";
  level.orbitalsupport_planemodel thread maps\mp\gametypes\_damage::setentitydamagecallback(3000, undefined, ::crashplane, maps\mp\killstreaks\_aerial_utility::heli_modifydamage, 1);
  level.orbitalsupport_planemodel.modules = var_1;
  level.orbitalsupport_planemodel.hasrockets = common_scripts\utility::array_contains(var_1, "orbitalsupport_rockets");
  level.orbitalsupport_planemodel.hasturret = common_scripts\utility::array_contains(var_1, "orbitalsupport_turret");
  level.orbitalsupport_planemodel.coopoffensive = common_scripts\utility::array_contains(var_1, "orbitalsupport_coop_offensive");
  level.orbitalsupport_planemodel.extraflare = common_scripts\utility::array_contains(var_1, "orbitalsupport_flares");
  level.orbitalsupport_planemodel.ammofeeder = common_scripts\utility::array_contains(var_1, "orbitalsupport_ammo");
  level.orbitalsupport_planemodel.player = var_0;

  if(level.orbitalsupport_planemodel.extraflare) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  level.orbitalsupport_planemodel.helitype = "osp";
  level.orbitalsupport_planemodel thread maps\mp\killstreaks\_aerial_utility::heli_flares_monitor(var_2);
  thread maps\mp\_utility::teamplayercardsplash("used_orbitalsupport", var_0);
  var_0 startac130();
  var_0 maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();
  var_0 maps\mp\killstreaks\_killstreaks::playerwaittillridekillstreakcomplete();
  var_0 thread waitsetthermal(1.0);
  var_0 thread waitdisableshadows(1.0);
  var_0 thread setospvisionandlightsetpermap(1.25);
  var_0 thread clouds();

  if(getdvarint("camera_thirdPerson")) {
    var_0 maps\mp\_utility::setthirdpersondof(0);
  }

  var_0 playerswitchtoturret(level.orbitalsupport_big_turret);
  var_0.controlled_orbitalsupport_turret = "medium";
  var_0.reloading_big_orbitalsupport_gun = 0;
  var_0.reloading_medium_orbitalsupport_gun = 0;
  var_0.reloading_rocket_orbitalsupport_gun = 0;
  var_0.reloading_buddy_medium_orbitalsupport_gun = 0;
  var_0.medium_orbitalsupport_ammo = 8;
  var_0 thread removeorbitalsupportplayerondisconnect();
  var_0 thread removeorbitalsupportplayeronchangeteams();
  var_0 thread removeorbitalsupportplayeronspectate();
  var_0 thread removeorbitalsupportplayeroncrash();
  var_0 thread removeorbitalsupportplayerongamecleanup();
  wait 1;
  maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
  var_0 playersetavailableweaponshud();
  var_0 setclientomnvar("ui_osp_weapon", 1);
  var_0 setclientomnvar("ui_osp_toggle", 1);
  var_0 thread waitsetstatic(0.1);
  var_0 thread pulseorbitalsupportreloadtext();
  var_3 = level.orbitalsupport_use_duration;

  if(common_scripts\utility::array_contains(var_1, "orbitalsupport_time")) {
    var_3 = var_3 + 15;
  }

  var_0.orbitalsupport_endtime = gettime() + var_3 * 1000;
  var_0 setclientomnvar("ui_warbird_countdown", var_0.orbitalsupport_endtime);
  self notifyonplayercommand("orbitalsupport_fire", "+attack");
  self notifyonplayercommand("orbitalsupport_fire", "+attack_akimbo_accessible");
  var_0 thread changeweapons();
  var_0 thread firebigorbitalsupportgun();
  var_0 thread firemediumorbitalsupportgun();
  var_0 thread firerocketorbitalsupportgun();
  var_0 thread showaerialmarker();
  var_0 thread removeorbitalsupportplayeraftertime(var_3);
  var_0 thread removeorbitalsupportplayeroncommand();

  if(level.teambased) {
    level thread handlecoopjoining(var_0);
  }

  level thread setupplayersduringstreak();
}

waitsetstatic(var_0) {
  self endon("orbitalsupport_player_removed");
  self endon("disconnect");
  wait(var_0);
  maps\mp\killstreaks\_aerial_utility::playerenablestreakstatic();
}

waitsetthermal(var_0) {
  self endon("disconnect");
  level endon("orbitalsupport_player_removed");
  self endon("orbitalsupport_player_removed");
  wait(var_0);
  self thermalvisionfofoverlayon();
  var_1 = 9275;

  if(isDefined(level.orbitalsupportoverrides.spawnheight)) {
    var_1 = level.orbitalsupportoverrides.spawnheight - level.mapcenter[2];
  }

  var_2 = 0.3;
  var_3 = var_1;
  var_4 = 0.3;
  var_5 = var_1 * 0.75;
  var_6 = 20;
  var_7 = 30;
  thread maps\mp\killstreaks\_aerial_utility::thermalvision("orbitalsupport_player_removed", var_2, var_3, var_4, var_5, var_6, var_7);
}

waitdisableshadows(var_0) {
  self endon("disconnect");
  level endon("orbitalsupport_player_removed");
  self endon("orbitalsupport_player_removed");
  wait(var_0);
  self setshadowrendering(0);
}

setospvisionandlightsetpermap(var_0) {
  self endon("disconnect");
  level endon("orbitalsupport_player_removed");
  wait(var_0);

  if(isDefined(level.ospvisionset)) {
    self setclienttriggervisionset(level.ospvisionset, 0);
  }

  if(isDefined(level.osplightset)) {
    self lightsetforplayer(level.osplightset);
  }

  maps\mp\killstreaks\_aerial_utility::handle_player_starting_aerial_view();
}

removeospvisionandlightsetpermap(var_0) {
  self setclienttriggervisionset("", var_0);
  self lightsetforplayer("");
  maps\mp\killstreaks\_aerial_utility::handle_player_ending_aerial_view();
}

removeorbitalsupportplayeroncommand() {
  self endon("orbitalsupport_player_removed");
  var_0 = 0;

  for(;;) {
    if(self useButtonPressed()) {
      var_0 = var_0 + 0.05;

      if(var_0 > 1.0) {
        if(isDefined(level.orbitalsupport_buddy) && level.orbitalsupport_buddy.joined == 1 || !isDefined(level.orbitalsupport_buddy)) {
          level thread removeorbitalsupportplayer(self, 0);
          return;
        }
      }
    } else {
      var_0 = 0;
    }

    wait 0.05;
  }
}

removeorbitalsupportplayerongamecleanup() {
  self endon("orbitalsupport_player_removed");
  level waittill("game_ended");
  level thread removeorbitalsupportplayer(self, 0);
}

removeorbitalsupportplayeroncrash() {
  self endon("orbitalsupport_player_removed");
  level.orbitalsupport_planemodel waittill("crashing");
  level thread removeorbitalsupportplayer(self, 0);
}

removeorbitalsupportplayerondisconnect() {
  self endon("orbitalsupport_player_removed");
  self waittill("disconnect");
  level thread removeorbitalsupportplayer(self, 1);
}

removeorbitalsupportplayeronchangeteams() {
  self endon("orbitalsupport_player_removed");
  self waittill("joined_team");
  level thread removeorbitalsupportplayer(self, 0);
}

removeorbitalsupportplayeronspectate() {
  self endon("orbitalsupport_player_removed");
  common_scripts\utility::waittill_any("joined_spectators", "spawned");
  level thread removeorbitalsupportplayer(self, 0);
}

removeorbitalsupportplayeraftertime(var_0) {
  self endon("orbitalsupport_player_removed");

  if(maps\mp\_utility::_hasperk("specialty_blackbox") && isDefined(self.specialty_blackbox_bonus)) {
    var_0 = var_0 * self.specialty_blackbox_bonus;
  }

  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);

  if(isDefined(level.orbitalsupport_buddy)) {
    maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(7);
  }

  level thread removeorbitalsupportplayer(self, 0);
}

removeorbitalsupportplayer(var_0, var_1) {
  var_0 notify("orbitalsupport_player_removed");
  level notify("orbitalsupport_player_removed");
  waittillframeend;
  level.orbitalsupport_planemodel.player = undefined;

  if(isDefined(level.orbitalsupport_buddy)) {
    level.orbitalsupport_buddy thread removeorbitalsupportbuddy(0);
  }

  if(!var_1) {
    var_0 playerresetospomnvars();
    var_0 notifyonplayercommandremove("orbitalsupport_fire", "+attack");
    var_0 notifyonplayercommandremove("orbitalsupport_fire", "+attack_akimbo_accessible");

    if(!isbot(var_0) && (level.orbitalsupport_planemodel.hasrockets || level.orbitalsupport_planemodel.hasturret)) {
      var_0 notifyonplayercommandremove("switch_orbitalsupport_turret", "weapnext");
    }

    var_0 remotecontrolturretoff(level.orbitalsupport_big_turret);
    level.orbitalsupport_big_turret hide();
    var_0 unlink();
    var_2 = maps\mp\_utility::getkillstreakweapon("orbitalsupport");
    var_0 takeweapon(var_2);

    if(var_0 maps\mp\_utility::isusingremote()) {
      var_0 maps\mp\_utility::clearusingremote();
    }

    maps\mp\killstreaks\_aerial_utility::disableorbitalthermal(var_0);
    var_0 setshadowrendering(1);
    var_0 thermalvisionfofoverlayoff();
    var_0 setblurforplayer(0, 0);
    var_0 removeospvisionandlightsetpermap(1.5);
    var_0 stopac130();

    if(getdvarint("camera_thirdPerson")) {
      var_0 maps\mp\_utility::setthirdpersondof(1);
    }

    if(isDefined(var_0.darkscreenoverlay)) {
      var_0.darkscreenoverlay destroy();
    }

    var_0.reloading_big_orbitalsupport_gun = undefined;
    var_0.reloading_medium_orbitalsupport_gun = undefined;
    var_0.reloading_rocket_orbitalsupport_gun = undefined;
    var_0.reloading_buddy_medium_orbitalsupport_gun = undefined;
    var_0 maps\mp\_utility::playerrestoreangles();
  }

  if(isDefined(level.orbitalsupport_planemodel.crashed)) {
    level.orbitalsupport_player = undefined;
    return;
  }

  level.orbitalsupport_player = undefined;
  level.orbitalsupport_planemodel stoploopsound();
  level.orbitalsupport_planemodel playSound("paladin_orbit_return");
  level.orbitalsupport_planemodel orbitalsupportexit();
}

cleanupospents() {
  level.orbitalsupport_planemodel stoploopsound();

  if(isDefined(level.orbitalsupport_targetent)) {
    stopFXOnTag(common_scripts\utility::getfx("vehicle_osp_rocket_marker"), level.orbitalsupport_targetent, "tag_origin");
    level.orbitalsupport_targetent delete();
  }

  level.orbitalsupport_buddy_turret turretdeletesoundent();
  level.orbitalsupport_buddy_turret delete();

  if(isDefined(level.orbitalsupport_planemodel.farflightsound)) {
    level.orbitalsupport_planemodel.farflightsound stoploopsound();
    level.orbitalsupport_planemodel.farflightsound delete();
  }

  if(isDefined(level.orbitalsupport_planemodel.closeflightsound)) {
    level.orbitalsupport_planemodel.closeflightsound stoploopsound();
    level.orbitalsupport_planemodel.closeflightsound delete();
  }

  if(isDefined(level.orbitalsupport_planemodel.minimapicon)) {
    level.orbitalsupport_planemodel.minimapicon delete();
  }
}

orbitalsupport_spawn() {
  var_0 = getEntArray("minimap_corner", "targetname");
  var_1 = (0, 0, 0);

  if(var_0.size) {
    var_1 = maps\mp\gametypes\_spawnlogic::findboxcenter(var_0[0].origin, var_0[1].origin);
    var_1 = (var_1[0], var_1[1], 0);
  }

  if(isDefined(level.orbitalsupportoverrides.spawnorigin)) {
    var_1 = level.orbitalsupportoverrides.spawnorigin;
    var_1 = (var_1[0], var_1[1], 0);
  }

  level.orbitalsupport_planemodel = spawn("script_model", var_1);
  level.orbitalsupport_planemodel.angles = (0, 0, 0);
  level.orbitalsupport_planemodel setModel("vehicle_mil_blimp_orbital_platform_ai");
  level.orbitalsupport_planemodel.owner = self;
  level.orbitalsupport_planemodel common_scripts\utility::make_entity_sentient_mp(self.team);
  level.orbitalsupport_planemodel.minimapicon = spawnplane(self, "script_model", var_1, "compass_objpoint_ac130_friendly", "compass_objpoint_ac130_enemy");
  level.orbitalsupport_planemodel.minimapicon setModel("tag_origin");
  level.orbitalsupport_planemodel.minimapicon linktosynchronizedparent(level.orbitalsupport_planemodel, "tag_origin", (0, 0, 0), (0, 0, 0));
  level.orbitalsupport_planemodel setCanDamage(1);
  level.orbitalsupport_planemodel setCanRadiusDamage(1);
  level.orbitalsupport_planemodel.maxhealth = 2000;
  level.orbitalsupport_planemodel.health = level.orbitalsupport_planemodel.maxhealth;
  level.orbitalsupport_planemodel.showthreatmarker = 0;
  level.orbitalsupport_planemodel setrandomorbitalsupportstartposition();
  level.orbitalsupport_big_turret = spawnorbitalsupportturret("orbitalsupport_big_turret_mp", "orbitalsupport_big_turret", "tag_orbitalsupport_biggun", 0);
  level.orbitalsupport_buddy_turret = spawnorbitalsupportturret("orbitalsupport_buddy_turret_mp", "orbitalsupport_small_turret", "tag_orbitalsupport_mediumgun2", 1);
  level.orbitalsupport_planemodel thread moveorbitalsupporttodestination();
}

spawnorbitalsupportturret(var_0, var_1, var_2, var_3) {
  var_4 = spawnturret("misc_turret", level.orbitalsupport_planemodel gettagorigin(var_2), var_0, 0);
  var_4.angles = level.orbitalsupport_planemodel gettagangles(var_2);
  var_4 setModel(var_1);
  var_4 setdefaultdroppitch(45);
  var_4 linkto(level.orbitalsupport_planemodel, var_2, (0, 0, 0), (0, 0, 0));
  var_4.owner = undefined;
  var_4.health = 99999;
  var_4.maxhealth = 1000;
  var_4.damagetaken = 0;
  var_4.stunned = 0;
  var_4.stunnedtime = 0.0;
  var_4 setCanDamage(0);
  var_4 setCanRadiusDamage(0);
  var_4 turretfiredisable();

  if(var_3) {
    var_4 thread turretspawnsoundent(var_2);
  }

  return var_4;
}

turretspawnsoundent(var_0) {
  waitframe();
  self.soundent = spawn("script_model", self.origin);
  self.soundent setModel("tag_origin");
  self.soundent linkto(level.orbitalsupport_planemodel, var_0, (0, 0, 0), (0, 0, 0));
}

pulseorbitalsupportreloadtext() {
  level endon("orbitalsupport_player_removed");
  self endon("orbitalsupport_player_removed");
  self endon("switch_orbitalsupport_turret");
  self setclientomnvar("ui_osp_reload_bitfield", 0);
  var_0 = 1;
  var_1 = 2;
  var_2 = 4;

  for(;;) {
    var_3 = 0;

    if(self.reloading_big_orbitalsupport_gun) {
      var_3 = var_3 + var_0;
    }

    if(self.reloading_medium_orbitalsupport_gun || self.reloading_buddy_medium_orbitalsupport_gun) {
      var_3 = var_3 + var_1;
    }

    if(self.reloading_rocket_orbitalsupport_gun) {
      var_3 = var_3 + var_2;
    }

    self setclientomnvar("ui_osp_reload_bitfield", var_3);
    wait 0.05;
  }
}

changeweapons() {
  self endon("orbitalsupport_player_removed");

  if(isbot(self)) {
    return;
  }
  var_0 = level.orbitalsupport_planemodel.hasrockets;
  var_1 = level.orbitalsupport_planemodel.hasturret;

  if(!var_0 && !var_1) {
    return;
  }
  self notifyonplayercommand("switch_orbitalsupport_turret", "weapnext");
  wait 0.05;
  self setclientomnvar("ui_osp_weapon", 1);

  for(;;) {
    self waittill("switch_orbitalsupport_turret");

    if(self.controlled_orbitalsupport_turret == "medium") {
      if(var_0) {
        playerswitchtorocketturret();
      } else {
        playerswitchtobigturret();
      }
    } else if(self.controlled_orbitalsupport_turret == "rocket") {
      if(var_1) {
        playerswitchtobigturret();
      } else {
        playerswitchtomediumturret();
      }
    } else if(self.controlled_orbitalsupport_turret == "big") {
      playerswitchtomediumturret();
    }

    self playlocalsound("paladin_weapon_cycle_plr");
  }
}

playersetavailableweaponshud() {
  var_0 = level.orbitalsupport_planemodel.hasrockets;
  var_1 = level.orbitalsupport_planemodel.hasturret;
  var_2 = 1;

  if(var_1) {
    var_2 = var_2 + 2;
  }

  if(var_0) {
    var_2 = var_2 + 4;
  }

  self setclientomnvar("ui_osp_avail_weapons", var_2);
}

playerswitchtoturret(var_0) {
  self unlink();
  level thread handleturretsoundent(var_0);
  var_1 = 25;
  var_2 = 25;
  var_3 = -25;
  var_4 = 60;

  if(isDefined(level.orbitalsupportoverrides.rightarc)) {
    var_1 = level.orbitalsupportoverrides.rightarc;
  }

  if(isDefined(level.orbitalsupportoverrides.leftarc)) {
    var_2 = level.orbitalsupportoverrides.leftarc;
  }

  if(isDefined(level.orbitalsupportoverrides.toparc)) {
    var_3 = level.orbitalsupportoverrides.toparc;
  }

  if(isDefined(level.orbitalsupportoverrides.bottomarc)) {
    var_4 = level.orbitalsupportoverrides.bottomarc;
  }

  self playerlinkweaponviewtodelta(var_0, "tag_player", 0, var_1, var_2, var_3, var_4, 1);
  self playerlinkedsetusebaseangleforviewclamp(1);
  var_5 = 45;

  if(isDefined(level.orbitalsupportoverrides.turretpitch)) {
    var_5 = level.orbitalsupportoverrides.turretpitch;
  }

  self remotecontrolturret(var_0, var_5);
}

handleturretsoundent(var_0) {
  var_0 endon("death");
  var_0 notify("startHandleSoundEnt");
  var_0 endon("startHandleSoundEnt");

  if(isDefined(var_0.soundent)) {
    var_0.soundent hide();
  }

  foreach(var_2 in level.players) {
    if(isDefined(var_0.owner) && var_0.owner != var_2) {
      if(isDefined(var_0.soundent)) {
        var_0.soundent showtoplayer(var_2);
      }
    }
  }

  for(;;) {
    level waittill("connected", var_2);

    if(isDefined(var_0.soundent)) {
      var_0.soundent showtoplayer(var_2);
    }
  }
}

playerswitchtobigturret() {
  self.controlled_orbitalsupport_turret = "big";
  self setclientomnvar("ui_osp_weapon", 0);
  thread pulseorbitalsupportreloadtext();

  if(isDefined(level.orbitalsupport_targetent)) {
    stopFXOnTag(common_scripts\utility::getfx("vehicle_osp_rocket_marker"), level.orbitalsupport_targetent, "tag_origin");
  }
}

playerswitchtorocketturret() {
  self.controlled_orbitalsupport_turret = "rocket";
  self setclientomnvar("ui_osp_weapon", 3);
  thread pulseorbitalsupportreloadtext();

  if(isDefined(level.orbitalsupport_targetent)) {
    playFXOnTag(common_scripts\utility::getfx("vehicle_osp_rocket_marker"), level.orbitalsupport_targetent, "tag_origin");
  }
}

playerswitchtomediumturret() {
  self.controlled_orbitalsupport_turret = "medium";
  self setclientomnvar("ui_osp_weapon", 1);
  thread pulseorbitalsupportreloadtext();

  if(isDefined(level.orbitalsupport_targetent)) {
    stopFXOnTag(common_scripts\utility::getfx("vehicle_osp_rocket_marker"), level.orbitalsupport_targetent, "tag_origin");
  }
}

playergetturretendpoint(var_0) {
  if(!isDefined(var_0) || !var_0) {
    return level.orbitalsupport_big_turret gettagorigin("tag_player") + anglesToForward(level.orbitalsupport_big_turret gettagangles("tag_player")) * 20000;
  } else {
    return level.orbitalsupport_buddy_turret gettagorigin("tag_player") + anglesToForward(level.orbitalsupport_buddy_turret gettagangles("tag_player")) * 20000;
  }
}

firebigorbitalsupportgun() {
  self endon("orbitalsupport_player_removed");

  if(!level.orbitalsupport_planemodel.ammofeeder) {
    var_0 = 6;
  } else {
    var_0 = 4;
  }

  while(!isDefined(level.orbitalsupport_planemodel.paladinflying)) {
    waitframe();
  }

  for(;;) {
    self.reloading_big_orbitalsupport_gun = 0;
    self waittill("orbitalsupport_fire");

    if(isDefined(level.hostmigrationtimer)) {
      continue;
    }
    if(self.controlled_orbitalsupport_turret == "big") {
      var_1 = playergetturretendpoint();
      var_2 = level.orbitalsupport_big_turret gettagorigin("tag_missile1");
      var_3 = magicbullet("orbitalsupport_105mm_mp", var_2, var_1, self, 1);
      var_3.vehicle_fired_from = level.orbitalsupport_planemodel;
      level.orbitalsupport_planemodel playSound("paladin_cannon_snap");
      var_3 playSound("orbitalsupport_105mm_proj_travel");
      self playrumbleonentity("ac130_105mm_fire");
      self playlocalsound("paladin_cannon_reload");
      earthquake(0.3, 1, level.orbitalsupport_planemodel.origin, 1000, self);
      self.reloading_big_orbitalsupport_gun = 1;
      wait(var_0);
    }
  }
}

firemediumorbitalsupportgun() {
  self endon("orbitalsupport_player_removed");

  while(!isDefined(level.orbitalsupport_planemodel.paladinflying)) {
    waitframe();
  }

  for(;;) {
    self.reloading_medium_orbitalsupport_gun = 0;

    if(!level.orbitalsupport_planemodel.ammofeeder) {
      var_0 = 3;
    } else {
      var_0 = 2;
    }

    if(self.controlled_orbitalsupport_turret == "medium" && self attackButtonPressed() && !isDefined(level.hostmigrationtimer)) {
      var_1 = level.orbitalsupport_big_turret gettagorigin("tag_missile1");
      var_2 = playergetturretendpoint();
      level.orbitalsupport_planemodel playSound("paladin_mgun_burst_plr");
      var_3 = magicbullet("orbitalsupport_40mm_mp", var_1, var_2, self, 1);
      var_3.vehicle_fired_from = level.orbitalsupport_planemodel;
      var_4 = bulletTrace(var_1, var_2, 0);
      wait 0.05;
      earthquake(0.1, 0.5, level.orbitalsupport_planemodel.origin, 1000, self);
      firemediumorbitalsupportvolley(var_4["position"], "orbitalsupport_40mm_mp");
      firemediumorbitalsupportvolley(var_4["position"], "orbitalsupport_40mm_mp");
      firemediumorbitalsupportvolley(var_4["position"], "orbitalsupport_40mm_mp");
      self.medium_orbitalsupport_ammo--;

      if(self.medium_orbitalsupport_ammo <= 0) {
        self.reloading_medium_orbitalsupport_gun = 1;
        wait(var_0);
        self.medium_orbitalsupport_ammo = 8;
      }
    }

    wait 0.05;
  }
}

firebuddythreatgrenades() {
  self endon("orbitalsupport_player_removed");

  for(;;) {
    self waittill("orbitalsupport_fire");
    maps\mp\killstreaks\_aerial_utility::playerfakeshootpaintmissile(level.orbitalsupport_buddy_turret.soundent);
    wait 2;
  }
}

firebuddymediumorbitalsupportgun() {
  self endon("orbitalsupport_player_removed");
  var_0 = 6;
  self.reloading_buddy_medium_orbitalsupport_gun = 0;
  self.controlled_orbitalsupport_turret = "buddy";
  thread pulseorbitalsupportreloadtext();

  for(;;) {
    self.reloading_buddy_medium_orbitalsupport_gun = 0;

    if(!level.orbitalsupport_planemodel.ammofeeder) {
      var_1 = 5;
    } else {
      var_1 = 3;
    }

    if(self attackButtonPressed()) {
      var_2 = level.orbitalsupport_buddy_turret gettagorigin("tag_missile1");
      var_3 = playergetturretendpoint(1);
      level.orbitalsupport_planemodel playSound("paladin_mgun_burst_plr");
      var_4 = magicbullet("orbitalsupport_40mmbuddy_mp", var_2, var_3, self);
      var_4.vehicle_fired_from = level.orbitalsupport_planemodel;
      var_5 = bulletTrace(var_2, var_3, 0);
      waitframe();
      earthquake(0.1, 0.5, level.orbitalsupport_planemodel.origin, 1000, self);
      firemediumorbitalsupportvolley(var_5["position"], "orbitalsupport_40mmbuddy_mp");
      firemediumorbitalsupportvolley(var_5["position"], "orbitalsupport_40mmbuddy_mp");
      firemediumorbitalsupportvolley(var_5["position"], "orbitalsupport_40mmbuddy_mp");
      var_0--;

      if(var_0 <= 0) {
        self.reloading_buddy_medium_orbitalsupport_gun = 1;
        wait(var_1);
        var_0 = 6;
      }
    }

    wait 0.05;
  }
}

firemediumorbitalsupportvolley(var_0, var_1) {
  var_2 = level.orbitalsupport_planemodel gettagorigin("tag_orbitalsupport_mediumgun1");
  var_3 = randomfloat(400) - 200;
  var_4 = randomfloat(400) - 200;
  var_5 = magicbullet(var_1, var_2, (var_0[0] + var_3, var_0[1] + var_4, var_0[2]), self, 1);
  var_5.vehicle_fired_from = level.orbitalsupport_planemodel;
  self playrumbleonentity("ac130_25mm_fire");
  wait 0.05;
  var_2 = level.orbitalsupport_planemodel gettagorigin("tag_orbitalsupport_mediumgun0");
  var_3 = randomfloat(400) - 200;
  var_4 = randomfloat(400) - 200;
  var_5 = magicbullet(var_1, var_2, (var_0[0] + var_3, var_0[1] + var_4, var_0[2]), self, 1);
  var_5.vehicle_fired_from = level.orbitalsupport_planemodel;
  self playrumbleonentity("ac130_25mm_fire");
  wait 0.05;
  var_2 = level.orbitalsupport_planemodel gettagorigin("tag_orbitalsupport_mediumgun3");
  var_3 = randomfloat(400) - 200;
  var_4 = randomfloat(400) - 200;
  var_5 = magicbullet(var_1, var_2, (var_0[0] + var_3, var_0[1] + var_4, var_0[2]), self, 1);
  var_5.vehicle_fired_from = level.orbitalsupport_planemodel;
  self playrumbleonentity("ac130_25mm_fire");
  wait 0.05;
}

random_vector(var_0) {
  return (randomfloat(var_0) - var_0 * 0.5, randomfloat(var_0) - var_0 * 0.5, randomfloat(var_0) - var_0 * 0.5);
}

firerocketorbitalsupportgun() {
  self endon("orbitalsupport_player_removed");
  var_0 = 3;
  var_1 = var_0;
  self setclientomnvar("ui_osp_rockets", var_1);

  if(!level.orbitalsupport_planemodel.ammofeeder) {
    var_2 = 6;
  } else {
    var_2 = 4;
  }

  thread updateshootinglocation();

  while(!isDefined(level.orbitalsupport_planemodel.paladinflying)) {
    waitframe();
  }

  for(;;) {
    self.reloading_rocket_orbitalsupport_gun = 0;

    if(self.controlled_orbitalsupport_turret == "rocket" && self attackButtonPressed() && !isDefined(level.hostmigrationtimer)) {
      earthquake(0.3, 1, level.orbitalsupport_planemodel.origin, 1000, self);
      var_3 = level.orbitalsupport_big_turret gettagorigin("tag_missile1");
      var_4 = vectornormalize(anglesToForward(self getangles()));
      var_5 = vectornormalize(anglesToForward(level.orbitalsupport_planemodel gettagangles("tag_origin")));

      for(var_6 = 0; var_6 < 3; var_6++) {
        var_7 = var_4 + (0, 0, 0.4) + random_vector(1);
        var_8 = magicbullet("orbitalsupport_missile_mp", var_3, var_3 + var_7, self);
        var_8.vehicle_fired_from = level.orbitalsupport_planemodel;
        self playlocalsound("paladin_missile_shot_2d");
        self playrumbleonentity("ac130_40mm_fire");
        var_8 missile_settargetent(level.orbitalsupport_targetent);
        var_8 missile_setflightmodedirect();
        wait 0.1;
      }

      var_1--;
      self setclientomnvar("ui_osp_rockets", var_1);

      if(var_1 == 0) {
        self.reloading_rocket_orbitalsupport_gun = 1;
        thread rocketreloadsound(var_2);
        wait(var_2);
        var_1 = var_0;
        self setclientomnvar("ui_osp_rockets", var_1);
        self notify("rocketReloadComplete");
        continue;
      } else {
        wait 1.3;
      }
    }

    waitframe();
  }
}

updateshootinglocation() {
  self endon("orbitalsupport_player_removed");
  level.orbitalsupport_targetent = spawn("script_model", (0, 0, 0));
  level.orbitalsupport_targetent setModel("tag_origin");
  level.orbitalsupport_big_turret turretsetgroundaimentity(level.orbitalsupport_targetent);

  for(;;) {
    var_0 = level.orbitalsupport_big_turret gettagorigin("tag_player");
    var_1 = level.orbitalsupport_big_turret gettagorigin("tag_player") + anglesToForward(level.orbitalsupport_big_turret gettagangles("tag_player")) * 20000;
    var_2 = bulletTrace(var_0, var_1, 0, level.orbitalsupport_big_turret);
    var_3 = var_2["position"];
    level.orbitalsupport_targetent.origin = var_3;
    waitframe();
  }
}

rocketreloadsound(var_0) {
  self endon("rocketReloadComplete");
  self endon("orbitalsupport_player_removed");
  var_1 = 3;
  self playlocalsound("warbird_missile_reload_bed");
  wait 0.5;

  for(;;) {
    self playlocalsound("warbird_missile_reload");
    wait(var_0 / var_1);
  }
}

showaerialmarker() {
  level.orbitalsupport_planemodel endon("death");

  while(!isDefined(level.orbitalsupport_planemodel.paladinflying)) {
    waitframe();
  }

  level.orbitalsupport_planemodel.showthreatmarker = 1;
  level.orbitalsupport_planemodel thread maps\mp\killstreaks\_killstreaks::updateaerialkillstreakmarker();
  level.orbitalsupport_planemodel common_scripts\utility::waittill_either("crashing", "leaving");
  level.orbitalsupport_planemodel.showthreatmarker = 0;
  level.orbitalsupport_planemodel thread maps\mp\killstreaks\_killstreaks::updateaerialkillstreakmarker();
}

clouds() {
  self endon("orbitalsupport_player_removed");
  wait 6;
  clouds_create();

  for(;;) {
    wait(randomfloatrange(40, 80));
    clouds_create();
  }
}

clouds_create() {
  if(isDefined(level.playerweapon) && issubstr(tolower(level.playerweapon), "25")) {
    return;
  }
  playfxontagforclients(level._effect["orbitalsupport_cloud"], level.orbitalsupport_planemodel, "tag_player", level.orbitalsupport_player);
}

crashplane(var_0, var_1, var_2, var_3) {
  level.orbitalsupport_planemodel notify("crashing");
  level.orbitalsupport_planemodel.crashed = 1;
  level.orbitalsupport_planemodel maps\mp\gametypes\_damage::onkillstreakkilled(var_0, var_1, var_2, var_3, "paladin_destroyed", undefined, "callout_destroyed_orbitalsupport", 1);
  thread crashfx();
  level.orbitalsupport_planemodel stopsounds();
  playsoundatpos(level.orbitalsupport_planemodel.origin, "paladin_ground_death");
  waitframe();
  cleanupospents();
  level.orbitalsupport_planemodel delete();
  level.orbitalsupportinuse = 0;
}

crashfx() {
  var_0 = getosptaginfo("TAG_FX_ENGINE_B");
  var_1 = getosptaginfo("tag_origin");
  var_2 = getosptaginfo("tag_light_belly");
  var_3 = getosptaginfo("TAG_FX_ENGINE_L_1");
  var_4 = getosptaginfo("TAG_FX_ENGINE_L_2");
  var_5 = getosptaginfo("TAG_FX_ENGINE_R_1");
  var_6 = getosptaginfo("TAG_FX_ENGINE_R_2");
  playFX(common_scripts\utility::getfx("orbitalsupport_explosion"), var_1.origin, var_2.dir);
  playFX(common_scripts\utility::getfx("orbitalsupport_explosion_jet"), var_3.origin, var_3.dir);
  playFX(common_scripts\utility::getfx("orbitalsupport_explosion_jet"), var_4.origin, var_4.dir);
  wait 0.05;
  playFX(common_scripts\utility::getfx("orbitalsupport_explosion_jet"), var_5.origin, var_5.dir);
  playFX(common_scripts\utility::getfx("orbitalsupport_explosion_jet"), var_6.origin, var_6.dir);
}

getosptaginfo(var_0) {
  var_1 = spawnStruct();
  var_1.origin = level.orbitalsupport_planemodel gettagorigin(var_0);
  var_1.dir = anglesToForward(level.orbitalsupport_planemodel gettagangles(var_0));
  return var_1;
}

handlecoopjoining(var_0) {
  var_1 = "orbitalsupport_coop_defensive";
  var_2 = &"MP_JOIN_ORBITALSUPPORT_DEF";
  var_3 = "pilot_sup_mp_paladin";
  var_4 = "copilot_sup_mp_paladin";

  if(level.orbitalsupport_planemodel.coopoffensive) {
    var_1 = "orbitalsupport_coop_offensive";
    var_2 = &"MP_JOIN_ORBITALSUPPORT_OFF";
    var_3 = "pilot_aslt_mp_paladin";
    var_4 = "copilot_aslt_mp_paladin";
  }

  for(;;) {
    var_5 = maps\mp\killstreaks\_coop_util::promptforstreaksupport(var_0.team, var_2, var_1, "assist_mp_paladin", var_3, var_0, var_4);
    level thread watchforjoin(var_5, var_0);
    var_6 = waittillpromptcomplete("orbitalsupport_buddy_added");
    maps\mp\killstreaks\_coop_util::stoppromptforstreaksupport(var_5);

    if(!isDefined(var_6)) {
      return;
    }
    var_6 = waittillpromptcomplete("orbitalsupport_buddy_removed");

    if(!isDefined(var_6)) {
      return;
    }
    waittillframeend;
  }
}

waittillpromptcomplete(var_0) {
  level endon("orbitalsupport_player_removed");
  level waittill(var_0);
  return 1;
}

watchforjoin(var_0, var_1) {
  level endon("orbitalsupport_player_removed");
  var_2 = maps\mp\killstreaks\_coop_util::waittillbuddyjoinedstreak(var_0);
  var_2 thread setorbitalsupportbuddy(var_1);
}

onorbitalsupportplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0.orbitalsupport_hold_time = 0;
  }
}

setorbitalsupportbuddy(var_0) {
  self endon("orbitalsupport_player_removed");
  level.orbitalsupport_buddy = self;
  level.orbitalsupport_buddy.joined = 0;
  level.orbitalsupport_buddy_chatter_timer = 0;
  level notify("orbitalsupport_buddy_added");
  var_0 maps\mp\_utility::playersaveangles();
  setupflightsounds();
  level thread maps\mp\_utility::teamplayercardsplash("joined_orbitalsupport", self);

  if(getdvarint("camera_thirdPerson")) {
    maps\mp\_utility::setthirdpersondof(0);
  }

  thread playerdoridekillstreak();
  self waittill("initRideKillstreak_complete", var_1);

  if(!var_1) {
    return;
  }
  maps\mp\_utility::setusingremote("orbitalsupport");
  self startac130();
  maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();
  playerswitchtoturret(level.orbitalsupport_buddy_turret);
  thread waitsetstatic(0.1);
  thread waitsetthermal(1.0);
  thread waitdisableshadows(1.0);
  thread setospvisionandlightsetpermap(1.25);
  thread clouds();
  self.reloading_big_orbitalsupport_gun = 0;
  self.reloading_medium_orbitalsupport_gun = 0;
  self.reloading_rocket_orbitalsupport_gun = 0;
  self.reloading_buddy_medium_orbitalsupport_gun = 0;

  if(isDefined(level.orbitalsupport_planemodel) && level.orbitalsupport_planemodel.coopoffensive) {
    self setclientomnvar("ui_osp_avail_weapons", 1);
    self setclientomnvar("ui_osp_weapon", 1);
    thread firebuddymediumorbitalsupportgun();
  } else {
    self notifyonplayercommand("orbitalsupport_fire", "+attack");
    self notifyonplayercommand("orbitalsupport_fire", "+attack_akimbo_accessible");
    self setclientomnvar("ui_osp_weapon", 4);
    thread firebuddythreatgrenades();
  }

  thread removeorbitalsupportbuddyondisconnect();
  thread removeorbitalsupportbuddyonchangeteams();
  thread removeorbitalsupportbuddyonspectate();

  if(!isbot(self)) {
    thread removeorbitalsupportbuddyoncommand();
  }

  wait 0.5;
  level.orbitalsupport_buddy.joined = 1;
  self setclientomnvar("ui_osp_toggle", 2);
  self setclientomnvar("ui_warbird_countdown", var_0.orbitalsupport_endtime);
  var_2 = var_0 getentitynumber();
  self setclientomnvar("ui_coop_primary_num", var_2);
}

playerdoridekillstreak() {
  var_0 = maps\mp\killstreaks\_killstreaks::initridekillstreak("coop");

  if(var_0 != "success") {
    removeorbitalsupportbuddy(var_0 == "disconnect");
    self notify("initRideKillstreak_complete", 0);
    return;
  }

  self notify("initRideKillstreak_complete", 1);
}

removeorbitalsupportbuddy(var_0) {
  self notify("orbitalsupport_player_removed");
  level notify("orbitalsupport_buddy_removed");

  if(!var_0) {
    playerresetospomnvars();
    thread removeospvisionandlightsetpermap(0.5);
    maps\mp\_utility::revertvisionsetforplayer(0);
    self notifyonplayercommandremove("ExitButtonDown", "+activate");
    self notifyonplayercommandremove("ExitButtonUp", "-activate");
    self notifyonplayercommandremove("ExitButtonDown", "+usereload");
    self notifyonplayercommandremove("ExitButtonUp", "-usereload");

    if(!isDefined(level.orbitalsupport_planemodel) || !level.orbitalsupport_planemodel.coopoffensive) {
      self notifyonplayercommandremove("orbitalsupport_fire", "+attack");
      self notifyonplayercommandremove("orbitalsupport_fire", "+attack_akimbo_accessible");
    }

    self remotecontrolturretoff(level.orbitalsupport_buddy_turret);
    self unlink();
    level.orbitalsupport_buddy_turret hide();
    maps\mp\killstreaks\_aerial_utility::disableorbitalthermal(self);
    self setshadowrendering(1);
    self thermalvisionfofoverlayoff();
    self setblurforplayer(0, 0);
    maps\mp\killstreaks\_aerial_utility::handle_player_ending_aerial_view();
    self stopac130();

    if(getdvarint("camera_thirdPerson")) {
      maps\mp\_utility::setthirdpersondof(1);
    }

    if(isDefined(self.darkscreenoverlay)) {
      self.darkscreenoverlay destroy();
    }

    if(maps\mp\_utility::isusingremote()) {
      maps\mp\_utility::clearusingremote();
    }

    self.reloading_big_orbitalsupport_gun = undefined;
    self.reloading_medium_orbitalsupport_gun = undefined;
    self.reloading_rocket_orbitalsupport_gun = undefined;
    self.reloading_buddy_medium_orbitalsupport_gun = undefined;
    maps\mp\_utility::playerrestoreangles();
    maps\mp\killstreaks\_coop_util::playerresetaftercoopstreak();
    maps\mp\_utility::playerremotekillstreakshowhud();
  }

  level.orbitalsupport_buddy = undefined;
  setupflightsounds();
}

removeorbitalsupportbuddyondisconnect() {
  self endon("orbitalsupport_player_removed");
  self waittill("disconnect");
  thread removeorbitalsupportbuddy(1);
}

removeorbitalsupportbuddyonchangeteams() {
  self endon("orbitalsupport_player_removed");
  self waittill("joined_team");
  thread removeorbitalsupportbuddy(0);
}

removeorbitalsupportbuddyonspectate() {
  self endon("orbitalsupport_player_removed");
  common_scripts\utility::waittill_any("joined_spectators", "spawned");
  thread removeorbitalsupportbuddy(0);
}

removeorbitalsupportbuddyoncommand() {
  self endon("orbitalsupport_player_removed");
  self notifyonplayercommand("ExitButtonDown", "+activate");
  self notifyonplayercommand("ExitButtonUp", "-activate");
  self notifyonplayercommand("ExitButtonDown", "+usereload");
  self notifyonplayercommand("ExitButtonUp", "-usereload");

  for(;;) {
    self waittill("ExitButtonDown");
    thread startospbuddyexitcommand();
    thread cancelospbuddyexitcommand();
  }
}

startospbuddyexitcommand() {
  self endon("orbitalsupport_player_removed");
  self endon("ExitButtonUp");
  self.osp_buddy_exit = 1;
  wait 0.5;

  if(self.osp_buddy_exit == 1) {
    thread removeorbitalsupportbuddy(0);
  }
}

cancelospbuddyexitcommand() {
  self endon("orbitalsupport_player_removed");
  self waittill("ExitButtonUp");
  self.osp_buddy_exit = 0;
}

setrandomorbitalsupportstartposition() {
  var_0 = level.mapcenter[2] + 9275;
  var_1 = 8000;
  var_2 = (0, randomint(360), 0);

  if(isDefined(level.orbitalsupportoverrides.spawnangle)) {
    var_2 = (0, level.orbitalsupportoverrides.spawnangle, 0);
  } else if(isDefined(level.orbitalsupportoverrides.spawnanglemin) && isDefined(level.orbitalsupportoverrides.spawnanglemax)) {
    var_2 = (0, randomintrange(level.orbitalsupportoverrides.spawnanglemin, level.orbitalsupportoverrides.spawnanglemax), 0);
  }

  if(isDefined(level.orbitalsupportoverrides.spawnradius)) {
    var_1 = level.orbitalsupportoverrides.spawnradius;
  }

  if(isDefined(level.orbitalsupportoverrides.spawnheight)) {
    var_0 = level.orbitalsupportoverrides.spawnheight;
  }

  level.orbitalsupport_planemodel.angles = var_2;
  level.orbitalsupport_planemodel.origin = level.orbitalsupport_planemodel.origin - vectornormalize(-1 * anglestoright(level.orbitalsupport_planemodel gettagangles("tag_origin"))) * var_1;
  level.orbitalsupport_planemodel.origin = level.orbitalsupport_planemodel.origin + (0, 0, var_0);
  level.orbitalsupport_planemodel.destination2 = spawnStruct();
  level.orbitalsupport_planemodel.destination2.origin = level.orbitalsupport_planemodel.origin;
  level.orbitalsupport_planemodel.destination2.angles = level.orbitalsupport_planemodel.angles;
  level.orbitalsupport_planemodel.origin = level.orbitalsupport_planemodel.origin + (0, 0, 65000);
}

moveorbitalsupporttodestination(var_0) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  level endon("orbitalsupport_player_removed");

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  thread rotateplane(1, "off");
  level.orbitalsupport_planemodel thread playjetfx();
  thread playentrysounddelayed();
  level.orbitalsupport_planemodel scriptmodelplayanimdeltamotion("paladin_ks_callin", "paladin_notetrack");

  if(isDefined(level.orbitalsupport_planemodel.owner)) {
    level.orbitalsupport_planemodel.owner thread playerdelayrumble(1.5);
  }

  level.orbitalsupport_planemodel waittillmatch("paladin_notetrack", "engines_full");
  level.orbitalsupport_planemodel waittillmatch("paladin_notetrack", "downward_stop");

  if(isDefined(level.orbitalsupport_planemodel.owner)) {
    level.orbitalsupport_planemodel.owner stoprumble("orbital_laser_charge");
    level.orbitalsupport_planemodel.owner playrumbleonentity("ac130_105mm_fire");
    earthquake(0.2, 2, level.orbitalsupport_planemodel.destination2.origin, 1000);
  }

  level.orbitalsupport_planemodel waittillmatch("paladin_notetrack", "engines_idle");

  if(var_0) {
    level.orbitalsupport_planemodel linktosynchronizedparent(level.osprig, "tag_player");
    thread rotateplane(level.orbitalsupport_speed);
  }

  level.orbitalsupport_planemodel waittillmatch("paladin_notetrack", "end");
  level.orbitalsupport_planemodel scriptmodelclearanim();
  level.orbitalsupport_planemodel scriptmodelplayanim("paladin_ks_loop", "paladin_notetrack");

  if(isDefined(level.orbitalsupport_planemodel.owner)) {
    level.orbitalsupport_planemodel.closeflightsound = spawn("script_origin", (0, 0, 0));
    level.orbitalsupport_planemodel.closeflightsound linktosynchronizedparent(level.orbitalsupport_planemodel, "tag_origin", (0, 0, 0), (0, 0, 0));
    level.orbitalsupport_planemodel.closeflightsound playLoopSound("paladin_flight_loop_near");
  }

  level.orbitalsupport_planemodel.farflightsound = spawn("script_origin", (0, 0, 0));
  level.orbitalsupport_planemodel.farflightsound linktosynchronizedparent(level.orbitalsupport_planemodel, "tag_origin", (0, 0, 0), (0, 0, 0));
  level.orbitalsupport_planemodel.farflightsound playLoopSound("paladin_flight_loop_dist");
  setupflightsounds();
  level.orbitalsupport_planemodel.paladinflying = 1;
}

setupflightsounds() {
  if(isDefined(level.orbitalsupport_planemodel.closeflightsound)) {
    level.orbitalsupport_planemodel.closeflightsound hide();

    if(isDefined(level.orbitalsupport_planemodel.owner)) {
      level.orbitalsupport_planemodel.closeflightsound showtoplayer(level.orbitalsupport_planemodel.owner);
    }

    if(isDefined(level.orbitalsupport_buddy) && !level.splitscreen && !bothplayerssplitscreen(level.orbitalsupport_planemodel.owner, level.orbitalsupport_buddy)) {
      level.orbitalsupport_planemodel.closeflightsound showtoplayer(level.orbitalsupport_buddy);
    }
  }

  if(isDefined(level.orbitalsupport_planemodel.farflightsound)) {
    level.orbitalsupport_planemodel.farflightsound hide();

    foreach(var_1 in level.players) {
      if(level.splitscreen || isDefined(level.orbitalsupport_planemodel.owner) && bothplayerssplitscreen(level.orbitalsupport_planemodel.owner, var_1)) {
        continue;
      }
      if(isDefined(level.orbitalsupport_planemodel.owner) && var_1 != level.orbitalsupport_planemodel.owner) {
        level.orbitalsupport_planemodel.farflightsound showtoplayer(var_1);
      }
    }
  }
}

bothplayerssplitscreen(var_0, var_1) {
  return var_0 issplitscreenplayer() && var_1 issplitscreenplayer();
}

playerdelayrumble(var_0) {
  self endon("disconnect");
  self endon("orbitalsupport_player_removed");
  wait(var_0);
  self playrumbleonentity("orbital_laser_charge");
}

playjetfx() {
  level.orbitalsupport_planemodel endon("death");
  level.orbitalsupport_planemodel endon("crashing");
  level endon("game_ended");
  level endon("orbitalsupport_player_removed");
  level.orbitalsupport_planemodel endon("stopEffects");
  playFXOnTag(common_scripts\utility::getfx("orbitalsupport_entry"), level.orbitalsupport_planemodel, "tag_origin");
  waitframe();
  playFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1");
  playFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2");
  playFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1");
  playFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2");
  waitframe();
  playFX(common_scripts\utility::getfx("orbitalsupport_entry_flash"), level.orbitalsupport_planemodel.destination2.origin);
  level.orbitalsupport_planemodel waittillmatch("paladin_notetrack", "engines_full");
  playFXOnTag(common_scripts\utility::getfx("orbitalsupport_light"), level.orbitalsupport_planemodel, "tag_light_tail");
  playFXOnTag(common_scripts\utility::getfx("orbitalsupport_entry_complete"), level.orbitalsupport_planemodel, "tag_light_belly");
  waitframe();
  stopFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1");
  stopFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1");
  playFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet_lg"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1");
  playFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet_lg"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2");
  waitframe();
  stopFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2");
  stopFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2");
  playFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet_lg"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1");
  playFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet_lg"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2");
  level.orbitalsupport_planemodel waittillmatch("paladin_notetrack", "engines_idle");
  stopFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet_lg"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1");
  stopFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet_lg"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1");
  playFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1");
  playFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1");
  waitframe();
  stopFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet_lg"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2");
  stopFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet_lg"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2");
  playFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2");
  playFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2");
  waitframe();
  stopFXOnTag(common_scripts\utility::getfx("orbitalsupport_entry"), level.orbitalsupport_planemodel, "tag_origin");
}

playentrysounddelayed() {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  level endon("orbitalsupport_player_removed");
  wait 1;
  playsoundatpos(level.orbitalsupport_planemodel.destination2.origin, "paladin_orbit_drop");
}

orbitalsupportexit() {
  level.orbitalsupport_planemodel endon("crashing");
  level.orbitalsupport_planemodel notify("leaving");
  level.orbitalsupport_planemodel unlink();
  level.orbitalsupport_planemodel scriptmodelplayanimdeltamotion("paladin_ks_exit", "paladin_notetrack");
  stopFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1");
  stopFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2");
  stopFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1");
  stopFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2");
  waitframe();
  playFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet_lg_trl"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_1");
  playFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet_lg_trl"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_L_2");
  playFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet_lg_trl"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_1");
  playFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet_lg_trl"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_R_2");
  waitframe();
  playFXOnTag(common_scripts\utility::getfx("vehicle_osp_jet_lg_trl"), level.orbitalsupport_planemodel, "TAG_FX_ENGINE_B");
  wait 4.8;
  cleanupospents();
  level.orbitalsupport_planemodel delete();
  level.orbitalsupportinuse = 0;
}

setupplayersduringstreak() {
  level.orbitalsupport_chatter_timer = 0;

  foreach(var_1 in level.players) {
    if(isDefined(var_1.team) && level.orbitalsupport_planemodel.owner.team == var_1.team) {
      continue;
    } else if(!isDefined(var_1.team)) {
      var_1 onplayerspawnedduringstreak();
      continue;
    }

    var_1 thread playermonitordeath();
    var_1 thread playermonitormarkedtarget();
  }

  level thread onplayerconnectduringstreak();
}

onplayerconnectduringstreak() {
  level endon("game_ended");
  level.orbitalsupport_planemodel.owner endon("orbitalsupport_player_removed");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawnedduringstreak();
  }
}

onplayerspawnedduringstreak() {
  self waittill("spawned_player");
  thread playermonitordeath();
  thread playermonitormarkedtarget();
  setupflightsounds();
}

playermonitormarkedtarget() {
  self endon("disconnect");
  level.orbitalsupport_planemodel.owner endon("orbitalsupport_player_removed");
  var_0 = level.orbitalsupport_planemodel.owner.team;

  for(;;) {
    self waittill("paint_marked_target", var_1);

    if(self.team == var_0 || !isDefined(var_1)) {
      continue;
    }
    if(isDefined(level.orbitalsupport_buddy) && var_1 == level.orbitalsupport_buddy && gettime() > level.orbitalsupport_buddy_chatter_timer) {
      level.orbitalsupport_buddy_chatter_timer = gettime() + 10000;

      if(!level.orbitalsupport_planemodel.coopoffensive) {
        var_1 maps\mp\_utility::leaderdialogonplayer("copilot_marked_mp_paladin");
      }
    }
  }
}

playermonitordeath() {
  self endon("disconnect");
  level.orbitalsupport_planemodel.owner endon("orbitalsupport_player_removed");
  var_0 = level.orbitalsupport_planemodel.owner.team;

  for(;;) {
    self waittill("death", var_1, var_2, var_3);

    if(self.team == var_0 || !isDefined(var_1)) {
      continue;
    }
    if(var_1 == level.orbitalsupport_planemodel.owner && gettime() > level.orbitalsupport_chatter_timer) {
      level.orbitalsupport_chatter_timer = gettime() + 10000;
      var_1 maps\mp\_utility::leaderdialogonplayer("copilot_enemykill_mp_paladin");
    }

    if(isDefined(level.orbitalsupport_buddy) && var_1 == level.orbitalsupport_buddy && gettime() > level.orbitalsupport_buddy_chatter_timer) {
      level.orbitalsupport_buddy_chatter_timer = gettime() + 10000;

      if(level.orbitalsupport_planemodel.coopoffensive) {
        var_1 maps\mp\_utility::leaderdialogonplayer("copilot_enemykill_mp_paladin");
      }
    }
  }
}

turretdeletesoundent() {
  if(isDefined(self.soundent)) {
    self.soundent delete();
  }
}

playerresetospomnvars() {
  self setclientomnvar("ui_killstreak_optic", 0);
  self setclientomnvar("ui_osp_rockets", 0);
  self setclientomnvar("ui_osp_avail_weapons", 0);
  self setclientomnvar("ui_osp_weapon", 0);
  self setclientomnvar("ui_osp_reload_bitfield", 0);
  self setclientomnvar("ui_osp_toggle", 0);
  self setclientomnvar("ui_coop_primary_num", 0);
  maps\mp\killstreaks\_aerial_utility::playerdisablestreakstatic();
}

rotateplane(var_0, var_1) {
  level notify("stop_rotatePlane_thread");
  level endon("stop_rotatePlane_thread");

  if(!isDefined(var_1)) {
    var_1 = "on";
  }

  if(var_1 == "on") {
    level.osprig rotateyaw(360, var_0, 0.5);
    wait(var_0);

    for(;;) {
      level.osprig rotateyaw(360, var_0);
      wait(var_0);
    }
  } else if(var_1 == "off") {
    var_2 = 10;
    var_3 = var_0 / 360 * var_2;
    level.osprig rotateyaw(level.osprig.angles[2] + var_2, var_3, 0, var_3);
  }
}

spawnmuzzleflashent(var_0, var_1, var_2) {
  var_3 = spawn("script_model", (0, 0, 0));
  var_3 setModel("tag_origin");
  var_3 linkto(var_0, var_1, (0, 0, 0), (0, 0, 0));
  var_3 hide();

  foreach(var_5 in level.players) {
    if(var_5 != var_2) {
      var_3 showtoplayer(var_5);
    }
  }

  thread onplayerconnectmuzzleflashent(var_3);
  return var_3;
}

onplayerconnectmuzzleflashent(var_0) {
  var_0 endon("death");

  for(;;) {
    level waittill("connected", var_1);
    thread onplayerspawnedmuzzleflashent(var_0, var_1);
  }
}

onplayerspawnedmuzzleflashent(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("disconnect");
  var_1 waittill("spawned_player");
  var_0 showtoplayer(var_1);
}