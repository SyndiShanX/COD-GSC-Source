/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3413.gsc
*********************************************/

fast_travel_init() {
  func_95D9();
  level.fast_travel_spots = [];
  level.zipline_negotiation = getnode("zombie_zipline", "script_noteworthy");
  var_0 = getEntArray("zipline_trigger", "targetname");
  level.zipline_traversals = [];
  level.ziplines_achievement_trigger_list = [];
  level.ziplines_achievement_trigger_list = var_0;
  foreach(var_2 in var_0) {
    var_2 thread func_97AD();
  }

  level thread watch_for_zipline_achievement();
}

watch_for_zipline_achievement() {
  level endon("game_ended");
  level endon("zipline_achievement_done");
  while(level.ziplines_achievement_trigger_list.size > 0) {
    scripts\engine\utility::waitframe();
  }

  foreach(var_1 in level.players) {
    var_1 scripts\cp\zombies\achievement::update_achievement("RIDE_FOR_YOUR_LIFE", 4);
  }

  level notify("zipline_achievement_done");
}

func_95D9() {
  level.var_28C9 = loadfx("vfx\core\mp\core\vfx_battle_slide_camera");
}

func_97AD() {
  level endon("game_ended");
  self.var_19 = 0;
  self.var_13EFC = scripts\engine\utility::getstruct(self.target, "targetname");
  var_0 = scripts\engine\utility::getstruct(self.var_13EFC.target, "targetname");
  while(isDefined(var_0.target)) {
    var_0 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  }

  self.var_13EFB = var_0;
  scripts\engine\utility::flag_wait("init_spawn_volumes_done");
  self.var_164A = undefined;
  foreach(var_2 in level.spawn_volume_array) {
    if(ispointinvolume(self.var_13EFB.origin, var_2)) {
      self.var_164A = var_2;
      break;
    }
  }

  if(!isDefined(self.var_164A)) {
    return;
  }

  self.var_13EFC.var_62E4 = self.var_13EFB;
  self.var_13EFC.trigger = self;
  self.var_13EFB.var_10CBA = self.var_13EFC;
  self.var_13EFB.trigger = self;
  for(;;) {
    level waittill("volume_activated", var_4);
    if(var_4 == self.var_164A.basename) {
      activate_zipline();
      break;
    }
  }
}

activate_zipline() {
  self.var_19 = 1;
  thread func_AD5D();
  if(isDefined(level.zipline_negotiation)) {
    var_0 = scripts\engine\utility::drop_to_ground(self.var_13EFC.origin, 0, -512);
    var_1 = scripts\engine\utility::drop_to_ground(self.var_13EFB.origin, 0, -512);
    level.zipline_traversals[level.zipline_traversals.size] = self;
    self.traversal_start = var_0;
    self.traversal_end = var_1;
    createnavlink(self.target, var_0, var_1, level.zipline_negotiation, 64, 1);
  }
}

func_AD5D() {
  var_0 = 0.1;
  var_1 = gettime();
  var_2 = [];
  for(;;) {
    self waittill("trigger", var_3);
    if(isplayer(var_3)) {
      var_3 forceusehinton(&"CP_RAVE_USE_ZIPLINE");
      var_3 thread handle_zipline_hint(self);
      if(var_3 isjumping()) {
        if(!scripts\engine\utility::istrue(var_3.is_fast_traveling)) {
          scripts\engine\utility::trigger_off();
          var_3.is_fast_traveling = 1;
          thread player_zipline_travel(var_3, var_1);
          var_3 scripts\cp\cp_merits::processmerit("mt_dlc1_all_ziplines");
          if(scripts\engine\utility::array_contains(level.ziplines_achievement_trigger_list, self)) {
            level.ziplines_achievement_trigger_list = scripts\engine\utility::array_remove(level.ziplines_achievement_trigger_list, self);
          }

          var_1 = gettime() + 500;
          wait(1);
          scripts\engine\utility::trigger_on();
        }
      }
    }

    wait(var_0);
  }
}

handle_zipline_hint(var_0) {
  self endon("disconnect");
  if(isDefined(self.zipline_hint)) {
    return;
  }

  self.zipline_hint = 1;
  while(!scripts\cp\cp_laststand::player_in_laststand(self) && !scripts\engine\utility::istrue(self.is_fast_traveling) && self istouching(var_0)) {
    wait(0.05);
  }

  self.zipline_hint = undefined;
  self getrigindexfromarchetyperef();
}

disable_teleportation(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0.can_teleport = 0;
  var_0 waittill(var_2);
  wait(var_1);
  var_0.can_teleport = 1;
  var_0 notify("can_teleport");
}

player_zipline_travel(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("zipline_use", "rave_comment_vo");
  var_0 setseatedanimconditional("zipline", 1);
  var_0 scripts\engine\utility::allow_crouch(0);
  var_0 scripts\engine\utility::allow_prone(0);
  var_0 getquadrant();
  var_0.disable_consumables = 1;
  var_0 scripts\engine\utility::allow_ads(0);
  var_0 scripts\engine\utility::allow_jump(0);
  var_0 scripts\engine\utility::allow_melee(0);
  var_0 scripts\engine\utility::allow_reload(0);
  var_0 disableautoreload();
  var_0 scripts\engine\utility::allow_weapon_switch(0);
  var_0 func_857E(1);
  var_2 = player_zipline(var_0, var_1);
  var_0 lerpfovbypreset("zombiedefault");
  wait(0.1);
  var_0 scripts\engine\utility::allow_ads(1);
  var_0 scripts\engine\utility::allow_jump(1);
  var_0 scripts\engine\utility::allow_melee(1);
  var_0 scripts\engine\utility::allow_reload(1);
  var_0 scripts\engine\utility::allow_crouch(1);
  var_0 scripts\engine\utility::allow_prone(1);
  var_0 enableautoreload();
  var_0 scripts\engine\utility::allow_weapon_switch(1);
  var_0 func_857E(0);
  var_0 notify("fast_travel_complete");
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("zipline_exit", "rave_comment_vo");
}

delay_nearby_zombie_cleanup() {
  var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.enemy) && var_2.enemy == self && distancesquared(var_2.origin, self.origin) < 272144) {
      var_2.delay_cleanup_until = gettime() + 12000;
    }
  }
}

player_zipline(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 earthquakeforplayer(0.3, 0.2, var_0.origin, 200);
  var_0 playSound("rave_zipline_start");
  var_2 = self.var_13EFC;
  var_3 = self.var_13EFB;
  var_0 cancelmantle();
  var_4 = var_2.origin + (0, 0, -45);
  var_5 = var_3.origin + (0, 0, -45);
  var_0.zipline = self;
  var_0 delay_nearby_zombie_cleanup();
  var_0 setorigin(var_4 + (0, 0, -45));
  var_0 setplayerangles(var_2.angles);
  var_6 = spawn("script_model", var_4);
  var_6.angles = var_2.angles;
  var_6 setModel("tag_origin");
  var_7 = getent("zipline_cord", "targetname");
  if(isDefined(var_7)) {
    var_7 linkto(var_6);
  }

  var_8 = getent("zipline_handle", "targetname");
  if(isDefined(var_8)) {
    var_8 linkto(var_6);
  }

  var_0 playerlinkto(var_6, undefined, 0.5, 20, 10, 50, 40);
  var_6 playLoopSound("rave_zipline_lp");
  var_0 playlocalsound("rave_zipline_wind_lr");
  var_0 playerlinkedoffsetenable();
  var_0 playgestureviewmodel("ges_zipline");
  while(var_1 > gettime()) {
    wait(0.05);
  }

  wait(1);
  var_0 lerpfovbypreset("zombiearcade");
  var_9 = var_0 func_816D();
  var_0 givegoproattachments("viewmodel_arms_invisi");
  var_10 = var_2;
  var_11 = scripts\engine\utility::getstructarray(var_10.target, "targetname");
  var_12 = scripts\engine\utility::random(var_11);
  var_13 = distance(var_10.origin, var_5);
  var_1 = var_13 / 500;
  var_6 moveto(var_5, var_1);
  var_0 thread func_ECC7(var_1);
  wait(var_1);
  for(var_10 = var_12; isDefined(var_10.target); var_10 = var_12) {
    var_11 = scripts\engine\utility::getstructarray(var_10.target, "targetname");
    var_12 = scripts\engine\utility::random(var_11);
    var_5 = var_12.origin;
    var_13 = distance(var_10.origin, var_5);
    var_1 = var_13 / 500;
    var_6 moveto(var_5, var_1);
    var_0 thread func_ECC7(var_1);
    wait(var_1);
  }

  var_0 stopgestureviewmodel("ges_zipline", 0.1, 0);
  var_0 playSound("rave_zipline_stop");
  var_6 stoploopsound("rave_zipline_lp");
  var_0 givegoproattachments(var_9);
  var_0.is_fast_traveling = undefined;
  var_0.zipline = undefined;
  var_0 limitedmovement(1);
  var_0.var_13EFD = vectornormalize(anglesToForward(var_0.angles)) * 500 * 0.1;
  var_0 unlink();
  var_0 stoplocalsound("rave_zipline_wind_lr");
  var_0 stoplocalsound("rave_zipline_wind_lsrs");
  var_0 setseatedanimconditional("zipline", 0);
  var_0 setvelocity(var_0.var_13EFD);
  var_0.disable_consumables = undefined;
  var_0 enableoffhandweapons();
  var_6 notify("stop_sway");
  wait(0.5);
  var_6 delete();
  var_0 limitedmovement(0);
  var_0 thread clear_zipline_landing_area();
}

clear_zipline_landing_area() {
  self endon("disconnect");
  while(!self isonground()) {
    foreach(var_1 in level.players) {
      if(var_1 == self) {
        continue;
      }

      if(distance2d(var_1.origin, self.origin) < 24) {
        var_1 setvelocity((-50, -100, 0));
      }
    }

    wait(0.1);
  }
}

func_11325(var_0, var_1, var_2) {
  self endon("stop_sway");
  var_3 = 10;
  var_4 = 0.5;
  var_5 = self.angles;
  var_6 = int(var_0);
  var_7 = 1;
  for(var_8 = 0; var_8 < var_6; var_8++) {
    if(var_7) {
      var_7 = 0;
      self rotateyaw(var_3, var_4, 0.2, 0.2);
      wait(var_4);
      wait(0.1);
      self rotateyaw(var_3 * -1, var_4, 0.2, 0.2);
      wait(var_4);
      continue;
    }

    var_7 = 1;
    self rotateyaw(var_3 * -1, var_4, 0.2, 0.2);
    wait(var_4);
    wait(0.1);
    self rotateyaw(var_3, var_4, 0.2, 0.2);
    wait(var_4);
  }

  self rotateto(var_5, 1);
}

func_ECC7(var_0) {
  var_1 = gettime();
  var_2 = gettime() + var_0 * 1000;
  var_3 = spawnfxforclient(level.var_28C9, self getEye(), self);
  while(var_1 < var_2) {
    var_3.origin = self getEye();
    triggerfx(var_3);
    earthquake(0.2, 0.25, self.origin, 96);
    self playrumbleonentity("slide_loop");
    scripts\engine\utility::waitframe();
    var_1 = gettime();
  }

  if(isDefined(var_3)) {
    var_3 delete();
  }
}

teleport_to_safe_spot(var_0) {
  var_1 = undefined;
  while(!isDefined(var_1)) {
    foreach(var_3 in self.end_positions) {
      if(!positionwouldtelefrag(var_3.origin)) {
        var_1 = var_3;
      }
    }

    wait(0.1);
  }

  var_0 unlink();
  var_0 dontinterpolate();
  var_0 setorigin(var_1.origin);
  var_0 setplayerangles(var_1.angles);
  var_0.disable_consumables = undefined;
  var_0 enableoffhandweapons();
}