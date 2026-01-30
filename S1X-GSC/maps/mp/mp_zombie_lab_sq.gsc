/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_lab_sq.gsc
****************************************/

init_sidequest() {
  maps\mp\zombies\_zombies_sidequests::declare_sidequest("main", ::init_main_sidequest, ::sidequest_logic, ::complete_sidequest, ::generic_stage_start, ::generic_stage_complete);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage1", ::stage1_init, ::stage1_logic, ::stage1_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage2", ::stage2_init, ::stage2_logic, ::stage2_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage3", ::stage3_init, ::stage3_logic, ::stage3_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage4", ::stage4_init, ::stage4_logic, ::stage4_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage5", ::stage5_init, ::stage5_logic, ::stage5_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage6", ::stage6_init, ::stage6_logic, ::stage6_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage7", ::stage7_init, ::stage7_logic, ::stage7_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage8", ::stage8_init, ::stage8_logic, ::stage8_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage9", ::stage9_init, ::stage9_logic, ::stage9_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage10", ::stage10_init, ::stage10_logic, ::stage10_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("main", "stage11", ::stage11_init, ::stage11_logic, ::stage11_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest("song", ::init_song_sidequest, ::sidequest_logic_song);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song", "stage1", ::songstage1_init, ::songstage1_logic, ::songstage1_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song", "stage2", ::songstage2_init, ::songstage2_logic, ::songstage2_end);
  maps\mp\zombies\_zombies_sidequests::declare_sidequest_stage("song", "stage3", ::songstage3_init, ::songstage3_logic, ::songstage3_end);
  thread maps\mp\killstreaks\_aerial_utility::init();
  level._effect["sq_light"] = loadfx("vfx/lights/aircraft_light_wingtip_green");
  level._effect["incinerator_ash"] = loadfx("vfx/weaponimpact/dlc_ash_ee_impact");
  level._effect["dlc_prop_biometric_lock_fail"] = loadfx("vfx/props/dlc_prop_biometric_lock_fail");
  level._effect["dlc_prop_biometric_lock_on"] = loadfx("vfx/props/dlc_prop_biometric_lock_on");
  level._effect["dlc_prop_biometric_lock_pass"] = loadfx("vfx/props/dlc_prop_biometric_lock_pass");
  level._effect["dlc_prop_scanner_door_lock_fail"] = loadfx("vfx/props/dlc_prop_scanner_door_lock_fail");
  level._effect["dlc_prop_scanner_door_lock_on"] = loadfx("vfx/props/dlc_prop_scanner_door_lock_on");
  level._effect["dlc_prop_scanner_door_lock_pass"] = loadfx("vfx/props/dlc_prop_scanner_door_lock_pass");
  level.chopper_fx["light"]["warbird"] = loadfx("vfx/lights/air_light_wingtip_red");
  level.chopper_fx["engine"]["warbird"] = loadfx("vfx/distortion/distortion_warbird_mp");
  maps\mp\killstreaks\_aerial_utility::makehelitype("warbird", "vfx/explosion/vehicle_warbird_explosion_midair", maps\mp\killstreaks\_warbird::warbirdlightfx);
  maps\mp\killstreaks\_aerial_utility::addairexplosion("warbird", "vfx/explosion/vehicle_warbird_explosion_midair");
  level thread start_lab_sidequest();
  level thread init_vo();
  level thread side_quest_end();
  level thread onplayerconnected();
  level thread onanyplayerspawned();
}

start_lab_sidequest() {
  wait 3;
  level thread setupweaponstationblocker();
  thread maps\mp\zombies\_zombies_sidequests::sidequest_start("main");
  thread maps\mp\zombies\_zombies_sidequests::sidequest_start("song");
}

setupweaponstationblocker() {
  var_0 = getent("weapon_upgrade_blocker_model", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.target)) {
    var_1 = getent(var_0.target, "targetname");

    if(isDefined(var_1)) {
      var_1 linktosynchronizedparent(var_0);
    }
  }

  waitframe();
  var_0.offsetmove = 76;
  var_0.origin = var_0.origin + (0, 0, -1 * var_0.offsetmove);
}

init_vo() {
  waitframe();
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player", "sq", "sq", "easter_egg", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "global_priority", "sq", "sq", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer", "sq", "sq", "sq", undefined);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer3", "sq", "sq", "easter_egg", undefined);
}

init_main_sidequest() {}

sidequest_logic() {
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage1");
  level waittill("main_stage1_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage2");
  level waittill("main_stage2_over");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage3");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage4");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage5");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage6");

  while(!var_0 || !var_1 || !var_2 || !var_3) {
    var_4 = level common_scripts\utility::waittill_any_return_no_endon_death("main_stage3_over", "main_stage4_over", "main_stage5_over", "main_stage6_over");

    if(var_4 == "main_stage3_over") {
      var_0 = 1;
      continue;
    }

    if(var_4 == "main_stage4_over") {
      var_1 = 1;
      continue;
    }

    if(var_4 == "main_stage5_over") {
      var_2 = 1;
      continue;
    }

    if(var_4 == "main_stage6_over") {
      var_3 = 1;
    }
  }

  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("All badges collected, need to upgrade them.");
  level notify("main_stage3456_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage7");
  level waittill("main_stage7_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage8");
  level waittill("main_stage8_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage9");
  level waittill("main_stage9_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage10");
  level waittill("main_stage10_over");
  maps\mp\zombies\_zombies_sidequests::stage_start("main", "stage11");
  level waittill("main_stage11_over");
  givesidequestachievement();
}

givesidequestachievement() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1.joinedround1) || !var_1.joinedround1) {
      continue;
    }
    var_1 maps\mp\gametypes\zombies::givezombieachievement("DLC1_ZOMBIE_GAMEOVERMAN");
  }
}

generic_stage_start() {
  level._stage_active = 1;
}

generic_stage_complete() {
  level._stage_active = 0;
}

complete_sidequest() {}

onanyplayerspawned() {
  for(;;) {
    level waittill("player_spawned", var_0);

    if(isDefined(var_0) && isDefined(var_0.badgeupgradecount)) {
      var_0 setclientomnvar("ui_zm_ee_int", var_0.badgeupgradecount);
    }
  }
}

onplayerconnected() {
  for(;;) {
    level waittill("connected", var_0);
    thread monitorplayer(var_0);
  }
}

monitorplayer(var_0) {
  var_0 waittill("begin_last_stand");
  level.wenttolaststand = 1;
}

stage1_init() {
  var_0 = getent("blackbox2", "targetname");

  if(isDefined(var_0)) {
    var_0 hide();
  }
}

stage1_logic() {
  var_0 = common_scripts\utility::getstruct("blackbox1Use", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 playLoopSound("ee_black_box_loop");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", undefined, undefined, "main_stage1_over");
  var_0 waittill("activated", var_2);
  var_2 playergivebox();
  var_2 playlocalsound("ee_grab_black_box");
  var_1 stoploopsound();
  var_2 thread playerplaysqvo(1, 1);
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage1");
  waitframe();
  var_1 delete();
}

stage1_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("This looks encrypted.");
  var_1 = getent("blackbox1", "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_1 delete();
}

playerplaysqvo(var_0, var_1) {
  self endon("disconnect");
  self endon("death");

  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  if(maps\mp\zombies\_util::is_true(self.speaking)) {
    self waittill("done_speaking");
  }

  thread maps\mp\zombies\_zombies_audio::create_and_play_dialog("sq", "sq", undefined, var_0);
}

waittilldonespeaking(var_0) {
  var_0 endon("disconnect");

  if(maps\mp\zombies\_util::is_true(var_0.isspeaking)) {
    var_0 waittill("done_speaking");
  }
}

playsqvowaittilldone(var_0, var_1, var_2) {
  var_3 = maps\mp\zombies\_zombies_audio::getcharacterbyindex(var_0);

  if(isDefined(var_3)) {
    var_3 playerplaysqvo(var_1, 0);
    waitframe();
    waittilldonespeaking(var_3);

    if(isDefined(var_2)) {
      wait(var_2);
    }
  }
}

announcerinworldplaysqvo(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2 > 0) {
    wait(var_2);
  }

  maps\mp\zombies\_zombies_audio_announcer::waittillannouncerdonespeaking();
  maps\mp\zombies\_zombies_audio_announcer::announcerinworlddialog("sq", "sq", var_1, undefined, var_0, 1, undefined, level.players);
}

announcerinworldplaysqvowaittilldone(var_0, var_1, var_2) {
  announcerinworldplaysqvo(var_0, var_1, var_2);
  maps\mp\zombies\_zombies_audio_announcer::waittillannouncerdonespeaking();
}

announcerglobalplaysqvo(var_0, var_1) {
  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }

  maps\mp\zombies\_zombies_audio_announcer::waittillannouncerdonespeaking();
  maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialog("global_priority", "sq", undefined, var_0, 1, undefined, level.players);
}

announcerglobalplaysqvowaittilldone(var_0, var_1) {
  announcerglobalplaysqvo(var_0, var_1);
  maps\mp\zombies\_zombies_audio_announcer::waittillannouncerdonespeaking();
}

doblackboxhint(var_0, var_1) {
  level endon(var_1);
  var_2 = common_scripts\utility::getstruct("blackbox2Use", "targetname");

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = 0;
  var_4 = 0;

  for(;;) {
    var_2 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", undefined, undefined, var_1);
    var_2 waittill("activated", var_5);
    playsoundatpos(var_2.origin, "ui_button_error");

    if(gettime() > var_3) {
      announcerinworldplaysqvowaittilldone(var_0, var_2.origin, 0.5);

      if(!var_4) {
        doblackboxhintresponse(var_5, var_0);
        var_4 = 1;
      }

      var_3 = gettime() + 20000;
    }

    wait 1;
  }
}

doblackboxhintresponse(var_0, var_1) {
  var_2 = -1;

  if(var_1 == 2) {
    switch (var_0.characterindex) {
      case 0:
        var_2 = 16;
        break;
      case 1:
        var_2 = 13;
        break;
      case 2:
        var_2 = 13;
        break;
      case 3:
        var_2 = 14;
        break;
      default:
        break;
    }
  } else if(var_1 == 3) {
    switch (var_0.characterindex) {
      case 0:
        var_3 = maps\mp\zombies\_zombies_audio::getcharacterbyindex(2);
        var_4 = maps\mp\zombies\_zombies_audio::getcharacterbyindex(1);

        if(isDefined(var_4)) {
          var_2 = 13;
        } else if(isDefined(var_3)) {
          var_2 = 14;
        } else {
          var_2 = 15;
        }

        break;
      case 1:
        var_3 = maps\mp\zombies\_zombies_audio::getcharacterbyindex(2);

        if(isDefined(var_3)) {
          var_2 = randomintrange(10, 13);
        } else {
          var_2 = 11;
        }

        break;
      case 2:
        var_2 = randomintrange(10, 13);
        break;
      case 3:
        var_2 = randomintrange(11, 14);
        break;
      default:
        break;
    }
  }

  if(var_2 != -1) {
    var_0 playerplaysqvo(var_2);
  }
}

stage2_init() {}

stage2_logic() {
  var_0 = common_scripts\utility::getstruct("blackbox2Use", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", ::playerhasbox, undefined, "main_stage2_over");
  var_0 waittill("activated", var_1);
  var_1 playertakebox();
  var_1 playlocalsound("ee_computer_negative");
  var_2 = getent("blackbox2", "targetname");

  if(isDefined(var_2)) {
    var_2 show();
  }

  announcerinworldplaysqvowaittilldone(1, var_0.origin, 0.5);
  var_1 thread playerplaysqvo(2, 1);
  thread doblackboxhint(2, "main_stage3456_over");
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage2");
}

stage2_end(var_0) {
  var_1 = getent("blackbox2", "targetname");

  if(isDefined(var_1)) {
    var_1 show();
  }

  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Blackbox placed, need all ID badges");
}

playerhasbox() {
  return maps\mp\zombies\_util::is_true(self.hasbox);
}

playergivebox() {
  setomnvar("ui_zm_ee_player_index", self getentitynumber());
  self.hasbox = 1;
  thread playertakeboxondisconnect();
}

playertakeboxondisconnect() {
  self endon("playerTakeBox");
  self waittill("disconnect");
  setomnvar("ui_zm_ee_player_index", -1);
}

playertakebox() {
  if(!isDefined(self.hasbox)) {
    return;
  }
  setomnvar("ui_zm_ee_player_index", -1);
  self.hasbox = undefined;
  self notify("playerTakeBox");
}

stage3_init() {
  var_4 = getEntArray("cage1", "targetname");

  if(var_4.size > 0) {
    level.sq_cage1 = var_4[0];

    for(var_5 = 1; var_5 < var_4.size; var_5++) {
      var_4[var_5] linktosynchronizedparent(level.sq_cage1);
    }
  }

  var_6 = getEntArray("cage2", "targetname");

  if(var_6.size > 0) {
    level.sq_cage2 = var_6[0];

    for(var_5 = 1; var_5 < var_6.size; var_5++) {
      var_6[var_5] linktosynchronizedparent(level.sq_cage2);
    }
  }

  var_7 = getent("badge_s3", "targetname");

  if(isDefined(var_7)) {
    var_7 linktosynchronizedparent(level.sq_cage2);
  }
}

stage3_logic() {
  var_0 = getEntArray("cage1", "targetname");

  if(var_0.size == 0) {
    return;
  }
  var_1 = getEntArray("cage2", "targetname");

  if(var_1.size == 0) {
    return;
  }
  var_2 = getent("cageWedge", "targetname");

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = getent("badge_s3", "targetname");

  if(!isDefined(var_3)) {
    return;
  }
  foreach(var_5 in level.players) {
    var_5 thread playermonitorgroundslam(var_0);
  }

  cagewedgelogic(var_2);
  thread cagewigglelogic();
  thread cagelogic(var_3);
}

stage3_end(var_0) {
  var_1 = getent("cageWedge", "targetname");

  if(isDefined(var_1)) {
    var_1 delete();
  }

  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Badge 1 collected.");
}

cagewedgelogic(var_0) {
  level endon("main_stage3_over");
  var_1 = 50 * level.players.size;
  var_2 = (-1442, 2098, 12);
  var_3 = var_2 - var_0.origin;
  var_4 = var_3[0] / var_1;
  var_5 = var_3[1] / var_1;
  var_6 = var_3[2] / var_1;
  var_0.health = 9999;
  var_0 setCanDamage(1);

  for(var_7 = 0; var_7 < var_1; var_7++) {
    var_0 waittill("damage");
    var_0.health = 9999;
    var_0.origin = var_0.origin + (var_4, var_5, var_6);
    var_0 thread wedgewiggle();
  }

  var_0 moveto(var_0.origin + (0, 0, -100), 1);
  var_0 playsoundonmovingent("ee_wedge_wiggle_done");
  wait 1;
  level notify("cage_wedge_complete");
}

wedgewiggle() {
  if(maps\mp\zombies\_util::is_true(self.iswiggling)) {
    return;
  }
  self.iswiggling = 1;
  self playsoundonmovingent("ee_wedge_wiggle");
  var_0 = randomint(10);
  self rotatepitch(var_0, 0.1);
  wait 0.15;
  self rotatepitch(-1 * var_0, 0.1);
  wait 0.15;
  self.iswiggling = 0;
}

cagewigglelogic() {
  level endon("main_stage3_over");

  for(;;) {
    level.sq_cage1 waittill("cage1_hit_hard");
    waittillframeend;

    if(maps\mp\zombies\_util::is_true(level.sq_cage1.ismoving)) {
      continue;
    }
    level wigglecage();
  }
}

wigglecage() {
  level.sq_cage1 endon("move_start");
  var_0 = level.sq_cage1.origin;
  var_1 = var_0 + (0, 0, -20);
  level.sq_cage1 playsoundonmovingent("ee_lift_down_blocked");
  level.sq_cage1.iswiggling = 1;
  level.sq_cage1 moveto(var_1, 0.5, 0, 0.1);
  wait 0.6;
  level.sq_cage1 moveto(var_0, 0.5, 0.2, 0.1);
  wait 0.6;
  level.sq_cage1.iswiggling = undefined;
  level notify("cage_wiggle_complete");
}

cagelogic(var_0) {
  level endon("main_stage3_over");
  var_1 = 0.5;
  level.sq_cage1.upposition = level.sq_cage1.origin;
  level.sq_cage1.downposition = level.sq_cage1.upposition + (0, 0, -154);
  level.sq_cage2.downposition = level.sq_cage2.origin;
  level.sq_cage2.upposition = level.sq_cage2.downposition + (0, 0, 154);

  for(;;) {
    level.sq_cage1 waittill("cage1_hit_hard");

    if(maps\mp\zombies\_util::is_true(level.sq_cage1.iswiggling)) {
      level.sq_cage1.hitcount = 0;
      continue;
    }

    var_2 = gettime() + var_1 * 1000;

    while(gettime() < var_2 && level.sq_cage1.hitcount < level.players.size) {
      waitframe();
    }

    if(level.sq_cage1.hitcount == level.players.size) {
      level thread movecages(var_0);
      level waittill("cage_move_complete");
    }

    level.sq_cage1.hitcount = 0;
  }
}

movecages(var_0) {
  level.sq_cage1 notify("move_start");
  level.sq_cage2 notify("move_start");
  level.sq_cage1.ismoving = 1;
  level.sq_cage2.ismoving = 1;
  level.sq_cage1 moveto(level.sq_cage1.downposition, 1, 0, 0.1);
  level.sq_cage2 moveto(level.sq_cage2.upposition, 1, 0, 0.1);
  level.sq_cage1 playsoundonmovingent("ee_lift_down");
  wait 1.1;
  level thread collectbadgestage3(var_0);
  wait 5;
  level.sq_cage2 playsoundonmovingent("ee_lift_up");
  level notify("cage2_reset");
  level.sq_cage1 moveto(level.sq_cage1.upposition, 2, 0.3, 0.5);
  level.sq_cage2 moveto(level.sq_cage2.downposition, 2, 0.3, 0.5);
  wait 2.1;
  level.sq_cage1.ismoving = 0;
  level.sq_cage2.ismoving = 0;
  level notify("cage_move_complete");
}

collectbadgestage3(var_0) {
  level endon("main_stage3_over");
  level endon("cage2_reset");
  var_1 = 3;
  var_2 = var_0 maps\mp\zombies\_zombies_sidequests::fake_use("activated", ::playercancollectstagebadge, var_1, "main_stage3_over");
  var_2 playlocalsound("ee_badge_collected");
  var_2 playerincrementbadge();

  if(var_2.characterindex == var_1) {
    var_2 thread playerplaysqvo(3, 0.5);
  }

  var_0 delete();
  thread maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage3");
}

playermonitorgroundslam(var_0) {
  level endon("main_stage3_over");

  for(;;) {
    self waittill("ground_slam", var_1);

    if(!maps\mp\zombies\_zombies_zone_manager::isplayerinzone("military")) {
      continue;
    }
    var_2 = self getEye();
    var_3 = var_2 + (0, 0, -100);
    var_4 = bulletTrace(var_2, var_3, 0, self);
    var_5 = var_4["entity"];

    if(!isDefined(var_5)) {
      continue;
    }
    if(!common_scripts\utility::array_contains(var_0, var_5)) {
      continue;
    }
    if(!isDefined(level.sq_cage1.hitcount)) {
      level.sq_cage1.hitcount = 1;
    } else {
      level.sq_cage1.hitcount++;
    }

    level.sq_cage1 notify("cage1_hit_hard");
  }
}

stage4_init() {}

stage4_logic() {
  var_0 = common_scripts\utility::getstruct("incinerator_teleport", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = spawnStruct();
  var_1 thread maps\mp\zombies\_teleport::teleport_add_location(var_0);
  level.incinerator_active = 0;

  for(;;) {
    level waittill("teleportUse", var_2);

    if(level.incinerator_active) {
      continue;
    }
    if(var_2 stage4_is_incinerator_teleporter()) {
      continue;
    }
    if(level.players.size == 1) {
      var_2 stage4_second_teleport_solo_wait(var_1.locations);
      continue;
    }

    var_2 stage4_second_teleport_wait(var_1.locations);
  }
}

stage4_is_incinerator_teleporter() {
  return isDefined(self.script_noteworthy) && self.script_noteworthy == "incinerator";
}

stage4_second_teleport_solo_wait(var_0) {
  self endon("teleport_solo_wait");
  thread stage4_second_teleport_solo_timer(5);

  for(;;) {
    level waittill("teleportUse", var_1);

    if(var_1 stage4_is_incinerator_teleporter()) {
      continue;
    }
    var_1 thread stage4_override_teleport_loc(var_0);
    break;
  }

  level thread stage4_run_incinerator();
  self notify("teleport_solo_timer_end");
}

stage4_second_teleport_solo_timer(var_0) {
  self endon("teleport_solo_timer_end");
  wait(var_0);
  self notify("teleport_solo_wait");
}

stage4_second_teleport_wait(var_0) {
  self endon("teleportPlayers");

  for(;;) {
    level waittill("teleportUse", var_1);

    if(var_1 stage4_is_incinerator_teleporter()) {
      continue;
    }
    var_1 thread stage4_override_teleport_loc(var_0);
    break;
  }

  thread stage4_override_teleport_loc(var_0);
  level thread stage4_run_incinerator();
}

stage4_override_teleport_loc(var_0) {
  self.overridelocations = var_0;
}

stage4_run_incinerator() {
  var_0 = 30;
  level.incinerator_active = 1;
  level notify("incinerator_start");
  level thread stage4_incinerator_ground();
  wait 3;
  level thread stage4_incinerator_pusher(var_0);
  wait(var_0);
  stage4_activate_all_teleporters();
  wait 1;
  stage4_double_check_players_out();
  level.incinerator_active = 0;
  level notify("incinerator_end");
}

stage4_activate_all_teleporters() {
  foreach(var_1 in level.zombieteleporters) {
    if(var_1 stage4_is_incinerator_teleporter()) {
      var_1 thread stage4_trigger_teleporter();
    }
  }
}

stage4_double_check_players_out() {
  var_0 = stage4_get_players_in_incinerator();
  stage4_force_players_out(var_0);
}

stage4_get_players_in_incinerator() {
  var_0 = [];
  var_1 = getent("incinerator_volume", "targetname");

  if(isDefined(var_1)) {
    foreach(var_3 in level.players) {
      if(var_3 istouching(var_1)) {
        var_0[var_0.size] = var_3;
      }
    }
  }

  return var_0;
}

stage4_force_players_out(var_0) {
  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  if(!var_0.size) {
    return;
  }
  var_1 = [];

  foreach(var_3 in level.zombieteleporters) {
    if(var_3 stage4_is_incinerator_teleporter()) {
      var_1[var_1.size] = var_3;
    }
  }

  var_5 = common_scripts\utility::random(var_1);
  var_5 thread maps\mp\zombies\_teleport::teleport_players(var_0);
}

stage4_trigger_teleporter() {
  while(self.inuse) {
    waitframe();
  }

  self.start notify("trigger");
}

stage4_incinerator_pusher(var_0) {
  var_1 = getent("incinerator_mover", "targetname");
  var_1.start = var_1.origin;
  var_1.end = common_scripts\utility::getstruct(var_1.target, "targetname").origin;
  var_1.unresolved_collision_func = ::stage4_force_players_out;
  var_1 moveto(var_1.end, var_0);
  var_1 playLoopSound("incinerator_room_machine_loop");
  wait(var_0);
  var_1 stoploopsound();
  wait 3;
  var_1.origin = var_1.start;
}

stage4_incinerator_ground() {
  var_0 = getEntArray("incinerator_ground", "targetname");

  if(!isDefined(level.incinerator_key)) {
    var_1 = common_scripts\utility::random(var_0);
    var_2 = common_scripts\utility::getstructarray(var_1.target, "targetname");
    var_3 = (max(var_2[0].origin[0], var_2[1].origin[0]), max(var_2[0].origin[1], var_2[1].origin[1]), 0);
    var_4 = (min(var_2[0].origin[0], var_2[1].origin[0]), min(var_2[0].origin[1], var_2[1].origin[1]), 0);
    var_5 = (randomfloatrange(var_4[0], var_3[0]), randomfloatrange(var_4[1], var_3[1]), 0);
    var_6 = spawn("script_model", var_5 + (0, 0, 1));
    var_6 setModel("dlc_badge_decker");
    var_6.hidden = 1;
    var_6 hide();
    var_7 = 0;
    var_6 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", ::stage4_can_collect_badge, var_7, "main_stage4_over", 80);
    var_6 thread stage4_key_pickup();
    level.incinerator_key = var_6;
  }

  common_scripts\utility::array_thread(var_0, ::stage4_incinerator_ground_run);
}

stage4_can_collect_badge(var_0) {
  if(!isDefined(level.incinerator_key) || level.incinerator_key.hidden) {
    return 0;
  }

  return playercancollectstagebadge(var_0);
}

stage4_incinerator_ground_run() {
  level endon("incinerator_end");
  var_0 = 20.0;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5);

    if(!isDefined(var_2) && isplayer(var_2)) {
      continue;
    }
    var_6 = var_2 getEye();
    var_7 = var_6 + anglesToForward(var_2 getangles()) * 5000;
    var_8 = bulletTrace(var_6, var_7, 0);
    var_4 = var_8["position"];
    playFX(common_scripts\utility::getfx("incinerator_ash"), var_4);

    if(isDefined(level.incinerator_key) && level.incinerator_key.hidden) {
      var_9 = distance2d(level.incinerator_key.origin, var_4);

      if(var_9 < var_0) {
        level thread stage4_key_show();
      }
    }
  }
}

stage4_key_show() {
  var_0 = level.incinerator_key;
  var_0 endon("death");
  var_0.hidden = 0;
  var_0 show();
  var_1 = 50;
  var_2 = 0.6;
  var_3 = 5;
  var_0 moveto(var_0.origin + (0, 0, var_1), var_2, 0, var_2);
  var_4 = 360 * var_3 / (var_2 * 2);
  var_0 rotatevelocity((var_4, var_4, 0), var_2 * 2);
  wait(var_2);
  var_0 moveto(var_0.origin - (0, 0, var_1), var_2, var_2, 0);
}

stage4_key_pickup() {
  self waittill("activated", var_0);
  self delete();
  var_0 playlocalsound("ee_badge_collected");
  var_1 = 0;

  if(var_0.characterindex == var_1) {
    var_0 thread playerplaysqvo(3, 0.5);
  }

  var_0 playerincrementbadge();
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage4");
}

stage4_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Badge 2 collected.");
}

stage5_init() {}

stage5_logic() {
  var_0 = getEntArray("execKeypadModel", "targetname");

  if(var_0.size == 0) {
    return;
  }
  var_1 = getent("securityWindow", "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = getent("badge_s5", "targetname");

  if(!isDefined(var_2)) {
    return;
  }
  var_1 show();
  var_2 show();
  var_0 = common_scripts\utility::array_randomize(var_0);

  foreach(var_4 in var_0) {
    level thread keypadlogic(var_4);
  }

  foreach(var_7 in level.players) {
    var_7 thread playermonitorcure();
  }

  var_9 = 0;

  while(var_9 < 4) {
    var_10 = level common_scripts\utility::waittill_any_return_no_endon_death("keyPadUsed", "cureStationUsed");

    if(var_10 == "cureStationUsed") {
      var_9 = 0;

      foreach(var_7 in level.players) {
        var_7.keypaduses = undefined;
      }

      continue;
    }

    var_9++;
  }

  level notify("main_stage4_ending");
  var_1 moveto(var_1.origin + (0, 40, 0), 3);
  wait 3.5;
  var_13 = 1;
  var_2 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", ::playercancollectstagebadge, var_13, "main_stage5_over", 80);
  var_2 waittill("activated", var_7);
  var_2 delete();
  var_7 playlocalsound("ee_badge_collected");

  if(var_7.characterindex == var_13) {
    var_7 thread playerplaysqvo(3, 0.5);
  }

  var_7 playerincrementbadge();
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage5");
}

stage5_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Badge 3 collected.");

  foreach(var_3 in level.players) {
    var_3.keypaduses = undefined;
  }
}

keypadlogic(var_0) {
  level endon("main_stage5_over");
  var_1 = 0;

  for(;;) {
    if(var_1) {
      maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_pass"), var_0, "tag_origin");
    }

    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_on"), var_0, "tag_origin");
    var_0 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", ::playercanactivatekeypad, var_0, "main_stage5_over");
    var_1 = 0;
    var_0 waittill("activated", var_2);
    var_2 playlocalsound("ee_pad_activated");
    level notify("keyPadUsed");
    var_1 = 1;
    maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_on"), var_0, "tag_origin");
    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_pass"), var_0, "tag_origin");
    var_3 = level common_scripts\utility::waittill_any_return_no_endon_death("cureStationUsed", "main_stage4_ending");

    if(var_3 == "main_stage4_ending") {
      return;
    }
  }
}

playercanactivatekeypad(var_0) {
  var_1 = maps\mp\zombies\_util::isplayerinfected(self);

  if(var_1) {
    if(!isDefined(self.keypaduses)) {
      self.keypaduses = 1;
    } else if(level.players.size == 2 && self.keypaduses >= 2) {
      var_1 = 0;
    } else if(level.players.size == 3) {
      var_2 = 0;

      foreach(var_4 in level.players) {
        if(isDefined(var_4.keypaduses) && var_4.keypaduses >= 2) {
          var_2 = 1;
          var_1 = 0;
          break;
        }
      }
    } else if(level.players.size == 4 && self.keypaduses >= 1) {
      var_1 = 0;
    } else {
      self.keypaduses++;
    }
  }

  if(!var_1) {
    thread playfailfxkeypad(var_0);
  }

  return var_1;
}

playfailfxkeypad(var_0) {
  if(maps\mp\zombies\_util::is_true(var_0.failfxon)) {
    return;
  }
  var_0.failfxon = 1;
  var_0 endon("activated");
  maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_on"), var_0, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("dlc_prop_biometric_lock_fail"), var_0, "tag_origin");
  var_0 playsoundonmovingent("ui_button_error");
  wait 1;
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_biometric_lock_on"), var_0, "tag_origin");
  var_0.failfxon = undefined;
}

playermonitorcure() {
  level endon("main_stage5_over");

  for(;;) {
    self waittill("cured");
    level notify("cureStationUsed");
  }
}

playercancollectstagebadge(var_0) {
  if(self.characterindex == var_0) {
    return 1;
  } else {
    foreach(var_2 in level.players) {
      if(var_2.characterindex == var_0) {
        return 0;
      }
    }
  }

  return 1;
}

stage6_init() {}

stage6_logic() {
  for(;;) {
    level waittill("magicBoxUse", var_0);
    thread stage6_magicbox(var_0);
  }
}

stage6_magicbox(var_0) {
  level endon("main_stage6_over");
  var_0 endon("pickupReady");

  if(!isDefined(var_0.modelent)) {
    return;
  }
  var_0.modelent setCanDamage(1);

  for(;;) {
    var_0.modelent waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(!isDefined(var_2) || !isDefined(var_10)) {
      continue;
    }
    var_11 = maps\mp\_utility::getbaseweaponname(var_10);

    if(var_11 != "iw5_em1zm") {
      continue;
    }
    break;
  }

  var_12 = 2;
  var_13 = undefined;

  foreach(var_15 in level.players) {
    if(var_15.characterindex == var_12) {
      var_13 = var_15;
      break;
    }
  }

  if(isDefined(var_13)) {
    var_13 clientclaimtrigger(var_0);
  } else {
    var_0 releaseclaimedtrigger();
  }

  var_0.weaponmodel setModel("dlc_badge_lilith");
  var_0.magicboxgivefunc = ::stage6_magicbox_give_badge;
  var_0.magicboxpickupstrfunc = ::stage6_magicbox_pickup_str;
  var_0.magicboxcanpickupfunc = ::stage6_magicbox_can_pickup;
  var_0 thread stage6_magicbox_func_cleanup();
}

stage6_magicbox_pickup_str() {
  return &"ZOMBIES_EMPTY_STRING";
}

stage6_magicbox_can_pickup(var_0) {
  return 1;
}

stage6_magicbox_give_badge(var_0, var_1) {
  if(var_0 == "trigger") {
    var_1 playlocalsound("ee_badge_collected");
    var_2 = 2;

    if(var_1.characterindex == var_2) {
      var_1 thread playerplaysqvo(3, 1);
    }

    var_1 playerincrementbadge();
    maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage6");
  }
}

stage6_magicbox_func_cleanup() {
  self waittill("magicBoxUseEnd");
  self.magicboxgivefunc = undefined;
  self.magicboxpickupstrfunc = undefined;
  self.magicboxpickupmodel = undefined;
  self.magicboxcanpickupfunc = undefined;
}

stage6_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Badge 4 collected.");
}

stage7_init() {
  level.processenemykilledfunc = ::processenemykilled;
  level.sq_droppedbadges = [];
  thread doblackboxhint(3, "main_stage7_over");

  foreach(var_1 in level.players) {
    if(var_1 playergetbadgecount() <= 0) {
      var_1 playerincrementbadge(1);
    }
  }
}

stage7_logic() {
  for(;;) {
    var_0 = 1;

    foreach(var_2 in level.players) {
      if(!var_2 playerisbadgeupgradedstage7()) {
        var_0 = 0;
        break;
      }
    }

    if(var_0) {
      break;
    }

    waitframe();
  }

  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage7");
}

stage7_end(var_0) {
  level.processenemykilledfunc = undefined;

  foreach(var_2 in level.sq_droppedbadges) {
    level thread removebadge(var_2, 1);
  }

  level.sq_droppedbadges = undefined;
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Badge fully upgraded.");
}

processenemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!maps\mp\zombies\_zombies_zone_manager::iszombieinanyzone(self)) {
    return;
  }
  if(isDefined(var_3) && var_3 == "MOD_SUICIDE") {
    return;
  }
  if(maps\mp\zombies\_util::istrapweapon(var_4)) {
    return;
  }
  if(isDefined(var_1) && isplayer(var_1) && maps\mp\_utility::ismeleemod(var_3) && !var_1 playerisbadgeupgradedstage7()) {
    var_1 playlocalsound("orbital_pkg_use");
    var_1 playerincrementbadge();
    return;
  }

  if(level.sq_droppedbadges.size >= 5) {
    return;
  }
  var_9 = randomfloat(1);

  if(var_9 < 0.5) {
    level thread dropbadge(self.origin);
  }
}

dropbadge(var_0) {
  var_0 = var_0 + (0, 0, 16);
  var_1 = spawn("script_model", var_0);
  var_1.angles = (0, 0, 0);
  var_1 setModel("dlc_badge_generic_anim");
  var_1 notsolid();
  var_2 = spawn("trigger_radius", var_0, 0, 32, 32);
  var_1.trigger = var_2;
  level.sq_droppedbadges[level.sq_droppedbadges.size] = var_1;
  var_1 thread badgepickup();
  var_1 thread badgetimer();
  var_1 thread badgeshowtoplayers();
  var_1 thread badgebounce();
}

badgeshowtoplayers() {
  self hide();
  self.trigger hide();

  foreach(var_1 in level.players) {
    if(!var_1 playerisbadgeupgradedstage7()) {
      self showtoplayer(var_1);
      self.trigger hide();
    }
  }
}

badgebounce() {
  self scriptmodelplayanimdeltamotion("mp_dogtag_spin", "badge");
}

badgepickup() {
  self endon("deleted");
  var_0 = self.origin;

  for(;;) {
    self.trigger waittill("trigger", var_1);

    if(isplayer(var_1) && !var_1 playerisbadgeupgradedstage7()) {
      var_1 playerincrementbadge();
      var_1 playlocalsound("ee_badge_collected_zombies");
      level.pickedupbadges = 1;
      thread removebadge(self);
      return;
    }
  }
}

badgetimer() {
  self endon("deleted");
  wait 15;
  thread badgestartflashing();
  wait 8;
  level thread removebadge(self);
}

badgestartflashing() {
  self endon("deleted");

  for(;;) {
    self ghost();
    wait 0.25;
    self show();
    wait 0.25;
  }
}

removebadge(var_0, var_1) {
  var_0 notify("deleted");
  waitframe();

  if(isDefined(var_0.trigger)) {
    var_0.trigger delete();
  }

  var_0 delete();

  if(!maps\mp\zombies\_util::is_true(var_1)) {
    level.sq_droppedbadges = common_scripts\utility::array_removeundefined(level.sq_droppedbadges);
  }
}

playerisbadgeupgradedstage7() {
  return playergetbadgecount() >= 49;
}

playergetbadgecount() {
  if(!isDefined(self.badgeupgradecount)) {
    return 0;
  }

  return self.badgeupgradecount;
}

playerincrementbadge(var_0) {
  if(!isDefined(var_0)) {
    if(!isDefined(self.badgeupgradecount)) {
      self.badgeupgradecount = 0;
    }

    self.badgeupgradecount++;
  } else {
    self.badgeupgradecount = var_0;
  }

  self setclientomnvar("ui_zm_ee_int", self.badgeupgradecount);
}

stage8_init() {
  foreach(var_1 in level.players) {
    if(!var_1 playerisbadgeupgradedstage7()) {
      var_1 playerincrementbadge(49);
    }
  }

  thread doblackboxhint(4, "main_stage8_over");
}

stage8_logic() {
  var_0 = common_scripts\utility::getstructarray("cardReader", "targetname");

  if(var_0.size == 0) {
    return;
  }
  foreach(var_2 in var_0) {
    level thread cardreaderlogic(var_2);
  }

  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    level waittill("cardReaderUsed");
  }

  wait 2;
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage8");
}

stage8_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("All badges used in card readers.");
}

cardreaderlogic(var_0) {
  level endon("main_stage8_over");
  var_1 = int(var_0.script_noteworthy);
  var_2 = undefined;

  if(isDefined(var_0.target)) {
    var_2 = getent(var_0.target, "targetname");
  }

  var_2.characterindex = var_1;
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_scanner_door_lock_on"), var_2, "tag_origin");
  var_0 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", ::playermatchescardreader, var_2, "main_stage8_over");
  var_0 waittill("activated", var_3);
  var_2 notify("activated");
  var_3 playlocalsound("ee_pad_activated");
  var_3 playerincrementbadge();
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_scanner_door_lock_pass"), var_2, "tag_origin");
  maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_scanner_door_lock_on"), var_2, "tag_origin");
  var_4 = 11;

  switch (maps\mp\zombies\_util::get_player_index(var_3)) {
    case 0:
      var_4 = 9;
      break;
    case 1:
      var_4 = 8;
      break;
    case 2:
      var_4 = 10;
      break;
    case 3:
    default:
      var_4 = 11;
      break;
  }

  announcerinworldplaysqvowaittilldone(var_4, var_0.origin, 0.5);

  if(var_3.characterindex == var_1) {
    var_3 thread playerplaysqvo(4, 0.5);
  }

  level notify("cardReaderUsed");
}

playermatchescardreader(var_0) {
  var_1 = isDefined(var_0.characterindex) && self.characterindex == var_0.characterindex;

  if(!var_1) {
    thread cardreaderfailfx(var_0);
  }

  return var_1;
}

cardreaderfailfx(var_0) {
  if(maps\mp\zombies\_util::is_true(var_0.failfxon)) {
    return;
  }
  var_0.failfxon = 1;
  var_0 endon("activated");
  maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_scanner_door_lock_on"), var_0, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("dlc_prop_scanner_door_lock_fail"), var_0, "tag_origin");
  var_0 playsoundonmovingent("ui_button_error");
  wait 1;
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_scanner_door_lock_on"), var_0, "tag_origin");
  var_0.failfxon = undefined;
}

stage9_init() {
  foreach(var_1 in level.players) {
    if(!var_1 playerisbadgeupgradedstage8()) {
      var_1 playerincrementbadge(50);
    }
  }
}

stage9_logic() {
  var_0 = common_scripts\utility::getstruct("blackbox2Use", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", undefined, undefined, "main_stage9_over");
  var_0 waittill("activated", var_1);
  announcerinworldplaysqvowaittilldone(5, var_0.origin, 0.5);
  thread playblackboxvo(var_0.origin);
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage9");
}

stage9_end(var_0) {
  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Black box tells you secrets.");
}

playblackboxvo(var_0) {
  level.mysteryguyent2 = spawn("script_model", var_0);
  level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer3", "mystery_", level.mysteryguyent2, 0);
  wait 0.5;
  var_1 = level.mysteryguyent2 maps\mp\zombies\_zombies_audio::create_and_play_dialog("sq", "sq", undefined, 1, 1, undefined, level.players);

  if(!isDefined(var_1) || !var_1) {
    return;
  } else {
    level.mysteryguyent2 waittill("done_speaking");
    wait 0.5;
    announcerinworldplaysqvowaittilldone(12, var_0);
    wait 0.5;
  }

  if(level.players.size < 4) {
    return;
  }
  playsqvowaittilldone(0, 17, 0.5);
  playsqvowaittilldone(1, 14, 1);
  playsqvowaittilldone(2, 14, 0.75);
  playsqvowaittilldone(3, 15);
}

playerisbadgeupgradedstage8() {
  return playergetbadgecount() >= 50;
}

stage10_init() {}

stage10_logic() {
  var_0 = getEntArray("exo_terminal", "targetname");

  if(var_0.size == 0) {
    return;
  }
  foreach(var_2 in var_0) {
    level thread exoterminallogic(var_2);
  }

  waittillexoterminalsused();
  maps\mp\zombies\_teleport::teleporter_disable_all();
  thread playrewardvo();
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage10");
}

stage10_end(var_0) {
  level notify("special_weapon_box_unlocked");

  foreach(var_2 in level.players) {
    var_2.usedexoterminalsq = undefined;
  }

  var_4 = getent("weapon_upgrade_blocker_model", "targetname");

  if(isDefined(var_4)) {
    var_5 = var_4.origin + (0, 0, var_4.offsetmove);
    var_4 moveto(var_5, 2, 0.5, 0.5);
  }

  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("Super weapon upgrade station unlocked.");
}

waittillexoterminalsused() {
  var_0 = 0.5;

  for(;;) {
    level waittill("sq_terminal_triggered");
    var_1 = gettime() + var_0 * 1000;

    while(gettime() < var_1 && getterminalusecount() < level.players.size) {
      waitframe();
    }

    if(getterminalusecount() == level.players.size) {
      break;
    }

    foreach(var_3 in level.players) {
      var_3.usedexoterminalsq = undefined;
    }
  }
}

getterminalusecount() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(maps\mp\zombies\_util::is_true(var_2.usedexoterminalsq)) {
      var_0++;
    }
  }

  return var_0;
}

exoterminallogic(var_0) {
  level endon("main_stage10_over");

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_1.usedexoterminalsq = 1;
    level notify("sq_terminal_triggered");
  }
}

playrewardvo() {
  announcerglobalplaysqvowaittilldone(6);
  announcerglobalplaysqvowaittilldone(7, 1);
  wait 1;
  thread song_play();

  if(level.players.size < 4) {
    return;
  }
  playsqvowaittilldone(2, 5, 0.5);
  playsqvowaittilldone(1, 5, 0.5);
  playsqvowaittilldone(0, 5, 1);
  playsqvowaittilldone(3, 5, 2);
  playsqvowaittilldone(2, 6, 1);
  playsqvowaittilldone(1, 6, 0.5);
  playsqvowaittilldone(0, 6, 1);
  playsqvowaittilldone(3, 6, 0.5);
  playsqvowaittilldone(0, 7, 1);
  playsqvowaittilldone(2, 7);
}

stage11_init() {
  level.heli_crash_nodes = common_scripts\utility::getstructarray("heli_crash_node", "targetname");
}

stage11_logic() {
  var_0 = common_scripts\utility::getstruct("heliStart", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = common_scripts\utility::getstruct("carepackageEnd", "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = common_scripts\utility::getstruct("heliEnd1", "targetname");

  if(!isDefined(var_2)) {
    return;
  }
  level.warbird = spawnhelicopter(level.players[0], var_0.origin, (0, 0, 0), "warbird_player_mp", "vehicle_xh9_warbird_low_cloaked_in_out_mp_cloak");
  level.warbird.team = "allies";
  level.warbird.heli_type = "warbird";
  var_3 = 40;
  level.warbird vehicle_setspeed(var_3, var_3 / 4, var_3 / 4);
  level.warbird setneargoalnotifydist(100);
  level.warbird setCanDamage(1);
  level.warbird.health = 9999;
  maps\mp\_utility::incrementfauxvehiclecount();
  level.warbird thread warbirdtravellogic(var_0);
  level.warbird thread warbirdmonitorhealth(var_1);
  var_4 = monitorplayerslogic();
  level.warbird warbirdwaitlogic(var_0, var_4);
  level.warbird warbirdtraveltoend(var_1, var_2);
  maps\mp\zombies\_teleport::teleporter_enable_all();
  maps\mp\zombies\_zombies_sidequests::stage_completed("main", "stage11");
}

warbirdtravellogic(var_0) {
  level endon("main_stage10_over");
  self endon("stopLoop");
  var_1 = var_0;

  for(;;) {
    var_2 = common_scripts\utility::getstruct(var_1.target, "targetname");

    if(!isDefined(var_2)) {
      return;
    }
    self setvehgoalpos(var_2.origin, 0);
    self waittill("near_goal");
  }
}

warbirdmonitorhealth(var_0) {
  level endon("main_stage10_over");
  level endon("warbird_crash_abort");

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(var_10 == level.ocp_weap_name) {
      self setCanDamage(0);
      thread maps\mp\killstreaks\_aerial_utility::heli_crash();
      thread orbital_package_heli_crash_sound();
      var_0.indoors = 1;
      var_0.start = var_4;
      maps\mp\zombies\killstreaks\_zombie_killstreaks::dropcarepackage(var_0);
      return;
    }

    self.health = 9999;
  }
}

orbital_package_heli_crash_sound() {
  wait 0.75;
  playsoundatpos((433, -306, 91), "orbital_pkg_pod_impact");
}

monitorplayerslogic() {
  level endon("main_stage10_over");
  var_0 = undefined;

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2 maps\mp\zombies\_zombies_zone_manager::isplayerinzone("courtyard")) {
        var_0 = var_2;
        break;
      }
    }

    if(isDefined(var_0)) {
      return var_0;
    }

    waitframe();
  }
}

playhelicopterseevo() {
  if(level.players.size < 4) {
    return;
  }
  playsqvowaittilldone(3, 7, 0.5);
  playsqvowaittilldone(2, 8, 0.5);
  playsqvowaittilldone(1, 8);
}

playhelicopterend1vo() {
  if(level.players.size < 4) {
    return;
  }
  playsqvowaittilldone(0, 8, 0.1);
  playsqvowaittilldone(3, 8, 1);
  playsqvowaittilldone(0, 9, 0.75);
  playsqvowaittilldone(3, 9, 0.1);
  playsqvowaittilldone(0, 10, 1);
  playsqvowaittilldone(1, 8);
}

playhelicopterend2vo() {
  if(level.players.size < 4) {
    return;
  }
  playsqvowaittilldone(2, 9, 0.3);
  playsqvowaittilldone(0, 11, 0.2);
  playsqvowaittilldone(1, 9, 0.5);
  playsqvowaittilldone(0, 12, 1);
  playsqvowaittilldone(3, 10);
}

warbirdwaitlogic(var_0, var_1) {
  self notify("stopLoop");
  self setvehgoalpos(var_0.origin, 1);
  self setlookatent(var_1);
  common_scripts\utility::waittill_notify_or_timeout("near_goal", 10);

  for(;;) {
    var_2 = 1;

    foreach(var_1 in level.players) {
      if(!var_1 maps\mp\zombies\_zombies_zone_manager::isplayerinzone("courtyard")) {
        var_2 = 0;
        break;
      }
    }

    if(var_2) {
      break;
    }

    waitframe();
  }
}

side_quest_end() {
  level.side_quest_end = 0;

  while(!maps\mp\zombies\_util::is_true(level.pickedupbadges) && !maps\mp\zombies\_util::is_true(level.wenttolaststand) && !maps\mp\zombies\_util::is_true(level.cheated)) {
    waitframe();
  }

  setomnvar("ui_zm_ee_bool", 1);
  level.side_quest_end = 1;
}

warbirdtraveltoend(var_0, var_1) {
  if(!level.side_quest_end) {
    var_0 = undefined;
    var_2 = common_scripts\utility::getstruct("heliEnd2", "targetname");

    if(isDefined(var_2)) {
      var_1 = var_2;
    }
  }

  self setvehgoalpos(var_1.origin, 1);
  self clearlookatent();

  if(isDefined(var_0)) {
    var_0.indoors = 0;
    level.zmkillstreakcrateprevo = 0;
    maps\mp\zombies\killstreaks\_zombie_killstreaks::dropcarepackage(var_0);
    var_3 = common_scripts\utility::waittill_any_timeout_no_endon_death(6, "crashing", "death");

    if(isDefined(var_3) && var_3 == "timeout" && !maps\mp\zombies\_util::is_true(level.warbird.iscrashing)) {
      level notify("warbird_crash_abort");
      self setCanDamage(0);
      thread maps\mp\killstreaks\_aerial_utility::heli_crash();
    }

    level thread playhelicopterend1vo();
    song_stop();
    set_side_quest_coop_data(0);
    self waittill("death");
  } else {
    level thread playhelicopterend2vo();
    thread[[level.pickup["nuke"]["func"]]](level.players[0]);
    level.zombiegamepaused = 1;
    wait 6;

    foreach(var_5 in level.players) {
      var_5 setclientomnvar("ui_killstreak_remote", 1);
      var_5 setclientomnvar("ui_killstreak_blackout", 1);
      var_5 setclientomnvar("ui_killstreak_blackout_fade_end", gettime() + 3000);
    }

    wait 6;
    set_side_quest_coop_data(1);
    level thread maps\mp\gametypes\_gamelogic::endgame(level.playerteam, game["end_reason"]["zombies_completed"]);
  }
}

set_side_quest_coop_data(var_0) {
  foreach(var_2 in level.players) {
    if(!isDefined(var_2.joinedround1) || !var_2.joinedround1) {
      continue;
    }
    var_3 = var_2 getcoopplayerdatareservedint("eggData");

    if(var_0) {
      var_3 = var_3 | 3;
      var_2.sidequest = 2;
    } else {
      var_3 = var_3 | 1;
      var_2.sidequest = 1;
    }

    var_2 setcoopplayerdatareservedint("eggData", var_3);
    setmatchdata("players", var_2.clientid, "startPrestige", var_2.sidequest);
  }
}

stage11_end(var_0) {
  if(isDefined(level.warbird) && !maps\mp\zombies\_util::is_true(level.warbird.iscrashing)) {
    level.warbird delete();
    maps\mp\_utility::decrementfauxvehiclecount();
  }

  maps\mp\zombies\_zombies_sidequests::sidequest_iprintlnbold("The End.");
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

  var_1 = "zmb_mus_ee_01";

  if(!isDefined(var_0) || var_0 <= 0) {
    var_0 = musiclength("zmb_mus_ee_01");
  } else {
    var_1 = "zmb_mus_ee_01_prvw";
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

song_fake_use(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3 thread maps\mp\zombies\_zombies_sidequests::fake_use("activated", undefined, undefined, "song_stage" + var_1 + "_over", var_2);
  var_3 waittill("activated", var_4);
  return var_4;
}

songstage1_init() {}

songstage1_logic() {
  var_0 = song_fake_use((1690, 1401, 122), 1);
  maps\mp\zombies\_zombies_sidequests::stage_completed("song", "stage1");
}

songstage1_end(var_0) {}

songstage2_init() {}

songstage2_logic() {
  var_0 = song_fake_use((-508, 2318, 104), 2);
  maps\mp\zombies\_zombies_sidequests::stage_completed("song", "stage2");
}

songstage2_end(var_0) {}

songstage3_init() {}

songstage3_logic() {
  var_0 = song_fake_use((238, 4044, 92), 3, 100);
  maps\mp\zombies\_zombies_sidequests::stage_completed("song", "stage3");
}

songstage3_end(var_0) {}

musiclength(var_0) {
  var_1 = tablelookup("mp/sound/soundlength_zm_mp.csv", 0, var_0, 1);

  if(!isDefined(var_1) || var_1 == "") {
    return 2;
  }

  var_1 = int(var_1);
  var_1 = var_1 * 0.001;
  return var_1;
}