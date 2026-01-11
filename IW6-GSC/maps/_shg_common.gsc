/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_shg_common.gsc
*****************************************************/

move_player_to_start(var_0) {
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");
  level.player setorigin(var_1.origin);
  var_2 = undefined;

  if(isDefined(var_1.target)) {
    var_2 = getent(var_1.target, "targetname");
  }

  if(isDefined(var_2)) {
    level.player setplayerangles(vectortoangles(var_2.origin - var_1.origin));
  } else {
    level.player setplayerangles(var_1.angles);
  }
}

tank_fire_at_enemies(var_0) {
  self endon("death");
  self endon("stop_random_tank_fire");
  var_1 = undefined;

  for(;;) {
    if(isDefined(var_1) && var_1.health > 0) {
      self setturrettargetent(var_1, (randomintrange(-64, 64), randomintrange(-64, 64), randomintrange(-16, 100)));

      if(sighttracepassed(self.origin + (0, 0, 100), var_1.origin + (0, 0, 40), 0, self)) {
        self.tank_think_fire_count++;
        self fireweapon();

        if(self.tank_think_fire_count >= 3) {
          if((!isDefined(var_1.damageshield) || var_1.damageshield == 0) && (!isDefined(var_1.magic_bullet_shield) || var_1.magic_bullet_shield == 0)) {
            var_1 notify("death");
          }
        }

        wait(randomintrange(4, 10));
      } else {
        var_1 = undefined;
        wait 1;
      }
    } else {
      if(!isalive(self)) {
        break;
      }

      var_1 = get_tank_target_by_script_noteworthy(var_0);
      self.tank_think_fire_count = 0;
      wait 1;
    }

    wait(randomfloatrange(0.05, 0.5));
  }
}

get_tank_target_by_script_noteworthy(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");

  if(isDefined(var_1)) {
    var_2 = common_scripts\utility::random(var_1);

    if(isDefined(var_2) && !isspawner(var_2) && var_2.health > 0) {
      var_3 = var_2;
      self notify("new_target");
      return var_3;
    } else
      return undefined;
  }

  return undefined;
}

spawn_friendlies(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_4 = getEntArray(var_1, "script_noteworthy");
  var_5 = [];
  var_6 = 0;
  var_7 = [];

  foreach(var_9 in var_4) {
    if(isspawner(var_9)) {
      var_5[var_5.size] = var_9;
    }
  }

  var_11 = common_scripts\utility::getstruct(var_0, "targetname");
  var_12 = 0;

  foreach(var_14 in var_5) {
    var_15 = var_14 maps\_utility::spawn_ai(1);

    if(var_2) {
      var_15 thread maps\_utility::replace_on_death();
    }

    var_15 forceteleport(var_11.origin, var_11.angles);
    var_15 setgoalpos(var_15.origin);
    var_7 = common_scripts\utility::array_add(var_7, var_15);
    var_12++;

    if(isDefined(var_3) && var_12 >= var_3) {
      return var_7;
    }
  }

  return var_7;
}

setupplayerforanimations() {
  if(level.player isthrowinggrenade()) {
    wait 1.2;
  }

  level.player allowmelee(0);
  level.player disableoffhandweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowsprint(0);

  if(level.player getstance() != "stand") {
    level.player setstance("stand");
    wait 0.4;
  }
}

setupplayerforgameplay() {
  level.player allowsprint(1);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player enableoffhandweapons();
  level.player allowmelee(1);
}

forceplayerweapon_start(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  level.old_force_weapon = level.player getcurrentweapon();
  level.player giveweapon(level.force_weapon);
  level.player givemaxammo(level.force_weapon);
  level.player switchtoweaponimmediate(level.force_weapon);

  if(var_0) {
    level.player enableweapons();
  }

  level.player disableweaponswitch();
}

forceplayerweapon_end(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  level.player takeweapon(level.force_weapon);

  if(isDefined(level.old_force_weapon)) {
    level.player switchtoweapon(level.old_force_weapon);
  }

  if(var_0) {
    level.player enableweapons();
    level.player enableweaponswitch();
  }

  level.old_force_weapon = undefined;
}

monitorscopechange() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1.sniper_zoom_hint_hud)) {
      var_1.sniper_zoom_hint_hud = var_1 maps\_hud_util::createclientfontstring("default", 1.75);
      var_1.sniper_zoom_hint_hud.horzalign = "center";
      var_1.sniper_zoom_hint_hud.vertalign = "top";
      var_1.sniper_zoom_hint_hud.alignx = "center";
      var_1.sniper_zoom_hint_hud.aligny = "top";
      var_1.sniper_zoom_hint_hud.x = 0;
      var_1.sniper_zoom_hint_hud.y = 20;
      var_1.sniper_zoom_hint_hud settext(&"VARIABLE_SCOPE_SNIPER_ZOOM");
      var_1.sniper_zoom_hint_hud.alpha = 0;
      var_1.sniper_zoom_hint_hud.sort = 0.5;
      var_1.sniper_zoom_hint_hud.foreground = 1;
    }

    var_1.fov_snipe = 1;
  }

  var_3 = 0;
  level.players[0].sniper_dvar = "cg_playerFovScale0";

  if(level.players.size == 2) {
    level.players[1].sniper_dvar = "cg_playerFovScale1";
  }

  foreach(var_1 in level.players) {
    var_1 thread monitormagcycle();
    var_1 thread disablevariablescopehudondeath();
  }

  if(!isDefined(level.variable_scope_weapons)) {
    level.variable_scope_weapons = [];
  }

  var_6 = undefined;
  var_7 = undefined;

  for(;;) {
    var_8 = 0;
    var_7 = var_6;
    var_6 = undefined;

    foreach(var_10 in level.variable_scope_weapons) {
      foreach(var_1 in level.players) {
        if(var_1 getcurrentweapon() == var_10 && isalive(var_1)) {
          var_8 = 1;
          var_6 = var_1;
          break;
        }
      }

      if(var_8) {
        break;
      }
    }

    if(var_8 && !var_6 isreloading() && !var_6 isswitchingweapon()) {
      if(var_6 maps\_utility::isads() && var_6 adsbuttonpressed()) {
        var_6 turnonvariablescopehud(var_3);
        var_3 = 1;

        if(isDefined(level.variable_scope_shadow_center)) {
          var_14 = undefined;
          var_15 = undefined;
          var_16 = anglesToForward(var_6 getplayerangles());
          var_17 = var_6.origin;

          foreach(var_19 in level.variable_scope_shadow_center) {
            var_20 = anglesToForward(vectortoangles(var_19 - var_17));
            var_21 = vectordot(var_16, var_20);

            if(!isDefined(var_14) || var_21 > var_15) {
              var_14 = var_19;
              var_15 = var_21;
            }
          }

          if(isDefined(var_14)) {
            setsaveddvar("sm_sunShadowCenter", var_14);
          }
        }
      } else if(var_3) {
        var_3 = 0;

        if(isDefined(var_6)) {
          var_6 turnoffvariablescopehud();
        }

        setsaveddvar("sm_sunShadowCenter", "0 0 0");
      }
    } else if(var_3) {
      var_3 = 0;

      if(isDefined(var_7)) {
        var_7 turnoffvariablescopehud();
      }

      setsaveddvar("sm_sunShadowCenter", "0 0 0");
    }

    wait 0.05;
  }
}

turnonvariablescopehud(var_0) {
  self disableoffhandweapons();
  setsaveddvar(self.sniper_dvar, self.fov_snipe);
  self.sniper_zoom_hint_hud.alpha = 1;

  if(!var_0) {
    level notify("variable_sniper_hud_enter");
  }
}

turnoffvariablescopehud() {
  level notify("variable_sniper_hud_exit");
  self enableoffhandweapons();
  setsaveddvar(self.sniper_dvar, 1);
  self.sniper_zoom_hint_hud.alpha = 0;
}

monitormagcycle() {
  notifyoncommand("mag_cycle", "+melee_zoom");
  notifyoncommand("mag_cycle", "+sprint_zoom");

  for(;;) {
    self waittill("mag_cycle");

    if(self.sniper_zoom_hint_hud.alpha) {
      if(self.fov_snipe == 0.5) {
        self.fov_snipe = 1;
        continue;
      }

      self.fov_snipe = 0.5;
    }
  }
}

disablevariablescopehudondeath() {
  self waittill("death");
  turnoffvariablescopehud();
}

convert_fov_string(var_0) {
  if(var_0 == 0.5) {
    return 10;
  }

  if(var_0 == 1) {
    return 5;
  }

  return 5;
}

createdebugtexthud(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 2.0;

  if(isDefined(var_5)) {
    var_6 = var_5;
  }

  var_7 = level.player maps\_hud_util::createclientfontstring("default", var_6);
  var_7.x = var_1;
  var_7.y = var_2;
  var_7.sort = 1;
  var_7.horzalign = "fullscreen";
  var_7.vertalign = "fullscreen";
  var_7.alpha = 1.0;

  if(!isDefined(var_3)) {
    var_3 = (1, 1, 1);
  }

  var_7.color = var_3;

  if(isDefined(var_4)) {
    var_7.label = var_4;
  }

  level.debug_text_hud[var_0] = var_7;
}

printdebugtexthud(var_0, var_1) {
  level.debug_text_hud[var_0] setvalue(var_1);
}

printdebugtextstringhud(var_0, var_1) {
  level.debug_text_hud[var_0] settext(var_1);
}

changedebugtexthudcolor(var_0, var_1) {
  level.debug_text_hud[var_0].color = var_1;
}

deletedebugtexthud(var_0) {
  level.debug_text_hud[var_0] destroy();
  level.debug_text_hud[var_0] = undefined;
}

dialogue_reminder(var_0, var_1, var_2, var_3, var_4) {
  level endon("stop_reminders");
  level endon("missionfailed");
  var_5 = undefined;

  if(!isDefined(var_3)) {
    var_3 = 10;
  }

  if(!isDefined(var_4)) {
    var_4 = 20;
  }

  while(!common_scripts\utility::flag(var_1)) {
    var_6 = randomfloatrange(var_3, var_4);
    var_7 = common_scripts\utility::random(var_2);

    if(isDefined(var_5) && var_7 == var_5) {
      continue;
    } else {
      var_5 = var_7;
      wait(var_6);

      if(!common_scripts\utility::flag(var_1)) {
        if(isstring(var_0) && var_0 == "radio") {
          conversation_start();
          maps\_utility::radio_dialogue(var_7);
          conversation_stop();
          continue;
        }

        conversation_start();
        var_0 maps\_utility::dialogue_queue(var_7);
        conversation_stop();
      }
    }
  }
}

conversation_start() {
  if(!common_scripts\utility::flag_exist("flag_conversation_in_progress")) {
    common_scripts\utility::flag_init("flag_conversation_in_progress");
  }

  common_scripts\utility::flag_waitopen("flag_conversation_in_progress");
  common_scripts\utility::flag_set("flag_conversation_in_progress");
}

conversation_stop() {
  common_scripts\utility::flag_clear("flag_conversation_in_progress");
}

array_combine_unique(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isDefined(common_scripts\utility::array_find(var_2, var_4))) {
      var_2[var_2.size] = var_4;
    }
  }

  foreach(var_4 in var_1) {
    if(!isDefined(common_scripts\utility::array_find(var_2, var_4))) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

laser_targeting_device(var_0) {
  var_0 endon("remove_laser_targeting_device");
  var_0.lastusedweapon = undefined;
  var_0.laserforceon = 0;
  var_0 setweaponhudiconoverride("actionslot4", "dpad_laser_designator");
  var_0 thread cleanuplasertargetingdevice();
  var_0 notifyonplayercommand("use_laser", "+actionslot 4");
  var_0 notifyonplayercommand("fired_laser", "+attack");
  var_0 notifyonplayercommand("fired_laser", "+attack_akimbo_accessible");
  var_0.laserallowed = 1;
  var_0.lasercooldownafterhit = 20;
  var_0 childthread monitorlaseroff();

  for(;;) {
    var_0 waittill("use_laser");

    if(var_0.laserforceon || !var_0.laserallowed || var_0 shouldforcedisablelaser()) {
      var_0 notify("cancel_laser");
      var_0 laserforceoff();
      var_0.laserforceon = 0;
      var_0 allowads(1);
      wait 0.2;
      var_0 allowfire(1);
      continue;
    }

    var_0 laserforceon();
    var_0 allowfire(0);
    var_0.laserforceon = 1;
    var_0 allowads(0);
    var_0 thread laser_designate_target();
  }
}

shouldforcedisablelaser() {
  var_0 = self getcurrentweapon();

  if(var_0 == "rpg") {
    return 1;
  }

  if(common_scripts\utility::string_starts_with(var_0, "gl")) {
    return 1;
  }

  if(isDefined(level.laser_designator_disable_list) && isarray(level.laser_designator_disable_list)) {
    foreach(var_2 in level.laser_designator_disable_list) {
      if(var_0 == var_2) {
        return 1;
      }
    }
  }

  if(self isreloading()) {
    return 1;
  }

  if(self isthrowinggrenade()) {
    return 1;
  }

  return 0;
}

cleanuplasertargetingdevice() {
  self waittill("remove_laser_targeting_device");
  self setweaponhudiconoverride("actionslot4", "none");
  self notify("cancel_laser");
  self laserforceoff();
  self.laserforceon = undefined;
  self allowfire(1);
  self allowads(1);
}

monitorlaseroff() {
  for(;;) {
    if(shouldforcedisablelaser() && isDefined(self.laserforceon) && self.laserforceon) {
      self notify("use_laser");
      wait 2.0;
    }

    wait 0.05;
  }
}

laser_designate_target() {
  self endon("cancel_laser");

  for(;;) {
    self waittill("fired_laser");
    var_0 = get_laser_designated_trace();
    var_1 = var_0["position"];
    var_2 = var_0["entity"];
    level notify("laser_coordinates_received");
    var_3 = undefined;

    if(isDefined(level.laser_targets) && isDefined(var_2) && common_scripts\utility::array_contains(level.laser_targets, var_2)) {
      var_3 = var_2;
      level.laser_targets = common_scripts\utility::array_remove(level.laser_targets, var_2);
    } else
      var_3 = gettargettriggerhit(var_1);

    if(isDefined(var_3)) {
      thread laser_artillery(var_3);
      level notify("laser_target_painted");
      wait 0.5;
      self notify("use_laser");
    }
  }
}

gettargettriggerhit(var_0) {
  if(!isDefined(level.laser_triggers) || level.laser_triggers.size == 0) {
    return undefined;
  }

  foreach(var_2 in level.laser_triggers) {
    var_3 = distance2d(var_0, var_2.origin);
    var_4 = var_0[2] - var_2.origin[2];

    if(!isDefined(var_2.radius)) {
      continue;
    }
    if(!isDefined(var_2.height)) {
      continue;
    }
    if(var_3 <= var_2.radius && var_4 <= var_2.height && var_4 >= 0) {
      level.laser_triggers = common_scripts\utility::array_remove(level.laser_triggers, var_2);
      return getent(var_2.target, "script_noteworthy");
    }
  }

  return undefined;
}

get_laser_designated_trace() {
  var_0 = self getEye();
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = var_0 + var_2 * 7000;
  var_4 = bulletTrace(var_0, var_3, 1, self);
  var_5 = var_4["entity"];

  if(isDefined(var_5)) {
    var_4["position"] = var_5.origin;
  }

  return var_4;
}

laser_artillery(var_0) {
  level.player endon("remove_laser_targeting_device");
  level.player.laserallowed = 0;
  self setweaponhudiconoverride("actionslot4", "dpad_killstreak_hellfire_missile_inactive");
  maps\_utility::flavorbursts_off("allies");
  var_1 = level.player;
  wait 2.5;

  if(!isDefined(var_0.script_index)) {
    var_0.script_index = 99;
  }

  wait 1;

  if(isDefined(var_0.script_group)) {
    var_2 = get_geo_group("geo_before", var_0.script_group);

    if(var_2.size > 0) {
      common_scripts\utility::array_call(var_2, ::hide);
    }

    var_3 = get_geo_group("geo_after", var_0.script_group);

    if(var_3.size > 0) {
      common_scripts\utility::array_call(var_3, ::show);
    }
  }

  wait(level.player.lasercooldownafterhit);
  level.player.laserallowed = 1;
  self setweaponhudiconoverride("actionslot4", "dpad_laser_designator");
}

get_geo_group(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(isDefined(var_5.script_group) && var_5.script_group == var_1) {
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

vision_change_multiple_init() {
  var_0 = getEntArray("shg_vision_multiple_trigger", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread vision_change_multiple_internal();
  }
}

vision_change_multiple_internal() {
  var_0 = common_scripts\utility::getstructarray(self.target, "targetname");

  foreach(var_2 in var_0) {
    var_3 = vectornormalize(self.origin - var_2.origin);
    var_2.forward_for_vision_change = var_3;
  }

  for(;;) {
    self waittill("trigger", var_5);

    if(isplayer(var_5)) {
      var_6 = anglesToForward(var_5 getplayerangles());
      var_7 = undefined;
      var_8 = 0;

      foreach(var_2 in var_0) {
        var_10 = vectordot(var_6, var_2.forward_for_vision_change);

        if(!isDefined(var_7) || var_10 < var_8) {
          var_7 = var_2;
          var_8 = var_10;
        }
      }

      var_12 = 1;

      if(isDefined(var_7.script_duration)) {
        var_12 = var_7.script_duration;
      }

      var_7 maps\_lights::set_sun_shadow_params(var_12);
      wait(var_12);
    }
  }
}

change_character_model(var_0) {
  self setModel(var_0);
  update_weapon_tag_visibility(self.weapon);
}

update_weapon_tag_visibility(var_0, var_1) {
  if(isDefined(var_0) && var_0 != "none") {
    var_2 = getweaponhidetags(var_0);
    var_3 = 0;
    var_4 = getweaponmodel(var_0, var_3);

    if(isDefined(var_1)) {
      var_4 = var_1;
    }

    for(var_5 = 0; var_5 < var_2.size; var_5++) {
      self hidepart(var_2[var_5], var_4);
    }
  }
}

multiple_dialogue_queue(var_0) {
  maps\_utility::bcs_scripted_dialogue_start();

  if(isDefined(self.last_queue_time)) {
    maps\_utility::wait_for_buffer_time_to_pass(self.last_queue_time, 0.5);
  }

  var_1 = [];
  var_1[0] = [self, 0];
  maps\_utility::function_stack(::anim_single_end_early, var_1, var_0);

  if(isalive(self)) {
    self.last_queue_time = gettime();
  }
}

anim_single_end_early(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = [];

  foreach(var_7, var_6 in var_0) {
    var_4[var_7] = var_6[0];
  }

  foreach(var_9 in var_4) {
    if(!isDefined(var_9)) {
      continue;
    }
    if(!isDefined(var_9._animactive)) {
      var_9._animactive = 0;
    }

    var_9._animactive++;
  }

  var_11 = maps\_anim::get_anim_position(var_2);
  var_12 = var_11["origin"];
  var_13 = var_11["angles"];
  var_14 = "single anim";
  var_15 = spawnStruct();
  var_16 = 0;

  foreach(var_7, var_9 in var_4) {
    var_18 = 0;
    var_19 = 0;
    var_20 = 0;
    var_21 = 0;
    var_22 = undefined;
    var_23 = undefined;
    var_24 = var_9.animname;

    if(isDefined(level.scr_face[var_24]) && isDefined(level.scr_face[var_24][var_1])) {
      var_18 = 1;
      var_23 = level.scr_face[var_24][var_1];
    }

    if(isDefined(level.scr_sound[var_24]) && isDefined(level.scr_sound[var_24][var_1])) {
      var_19 = 1;
      var_22 = level.scr_sound[var_24][var_1];
    }

    if(isDefined(level.scr_anim[var_24]) && isDefined(level.scr_anim[var_24][var_1]) && (!isai(var_9) || !var_9 maps\_utility::doinglongdeath())) {
      var_20 = 1;
    }

    if(isDefined(level.scr_animsound[var_24]) && isDefined(level.scr_animsound[var_24][var_1])) {
      var_9 playSound(level.scr_animsound[var_24][var_1]);
    }

    if(var_20) {
      var_9 maps\_anim::last_anim_time_check();

      if(isplayer(var_9)) {
        var_25 = level.scr_anim[var_24]["root"];
        var_9 setanim(var_25, 0, 0.2);
        var_26 = level.scr_anim[var_24][var_1];
        var_9 setflaggedanim(var_14, var_26, 1, 0.2);
      } else if(var_9.code_classname == "misc_turret") {
        var_26 = level.scr_anim[var_24][var_1];
        var_9 setflaggedanim(var_14, var_26, 1, 0.2);
      } else
        var_9 animscripted(var_14, var_12, var_13, level.scr_anim[var_24][var_1]);

      thread maps\_anim::start_notetrack_wait(var_9, var_14, var_1, var_24);
      thread maps\_anim::animscriptdonotetracksthread(var_9, var_14, var_1);
    }

    if(var_18 || var_19) {
      if(var_18) {
        if(var_19) {
          var_9 thread dofacialdialogue(var_1, var_18, var_22, level.scr_face[var_24][var_1]);
        }

        thread maps\_anim::anim_facialanim(var_9, var_1, level.scr_face[var_24][var_1]);
      } else if(isai(var_9)) {
        if(var_20) {
          var_9 animscripts\face::sayspecificdialogue(var_23, var_22, 1.0);
        } else {
          var_9 thread maps\_anim::anim_facialfiller("single dialogue");
          var_9 animscripts\face::sayspecificdialogue(var_23, var_22, 1.0, "single dialogue");
        }
      } else
        var_9 thread maps\_utility::play_sound_on_entity(var_22, "single dialogue");
    }

    if(var_20) {
      var_27 = getanimlength(level.scr_anim[var_24][var_1]);
      var_15 thread anim_end_early_deathnotify(var_9, var_1);
      var_15 thread anim_end_early_animationendnotify(var_9, var_1, var_27, var_0[var_7][1]);
      var_16++;
      continue;
    }

    if(var_18) {
      var_15 thread anim_end_early_deathnotify(var_9, var_1);
      var_15 thread anim_end_early_facialendnotify(var_9, var_1, var_23);
      var_16++;
      continue;
    }

    if(var_19) {
      var_15 thread anim_end_early_deathnotify(var_9, var_1);
      var_15 thread anim_end_early_dialogueendnotify(var_9, var_1);
      var_16++;
    }
  }

  while(var_16 > 0) {
    var_15 waittill(var_1, var_9);
    var_16--;

    if(!isDefined(var_9)) {
      continue;
    }
    if(isplayer(var_9)) {
      var_24 = var_9.animname;

      if(isDefined(level.scr_anim[var_24][var_1])) {
        var_25 = level.scr_anim[var_24]["root"];
        var_9 setanim(var_25, 1, 0.2);
        var_26 = level.scr_anim[var_24][var_1];
        var_9 clearanim(var_26, 0.2);
      }
    }

    var_9._animactive--;
    var_9._lastanimtime = gettime();
  }

  self notify(var_1);
}

anim_end_early_deathnotify(var_0, var_1) {
  var_0 endon("kill_anim_end_notify_" + var_1);
  var_0 waittill("death");
  self notify(var_1, var_0);
  var_0 notify("kill_anim_end_notify_" + var_1);
}

anim_end_early_facialendnotify(var_0, var_1, var_2) {
  var_0 endon("kill_anim_end_notify_" + var_1);
  var_3 = getanimlength(var_2);
  wait(var_3);
  self notify(var_1, var_0);
  var_0 notify("kill_anim_end_notify_" + var_1);
}

anim_end_early_dialogueendnotify(var_0, var_1) {
  var_0 endon("kill_anim_end_notify_" + var_1);
  var_0 waittill("single dialogue");
  self notify(var_1, var_0);
  var_0 notify("kill_anim_end_notify_" + var_1);
}

anim_end_early_animationendnotify(var_0, var_1, var_2, var_3) {
  var_0 endon("kill_anim_end_notify_" + var_1);
  var_2 = var_2 - var_3;

  if(var_3 > 0 && var_2 > 0) {
    var_0 maps\_utility::waittill_match_or_timeout("single anim", "end", var_2);
    var_0 stopanimscripted();
  } else
    var_0 waittillmatch("single anim", "end");

  var_0 notify("anim_ended");
  self notify(var_1, var_0);
  var_0 notify("kill_anim_end_notify_" + var_1);
}

dofacialdialogue(var_0, var_1, var_2, var_3) {
  if(var_1) {
    thread notify_facial_anim_end(var_0);
    thread warn_facial_dialogue_unspoken(var_0);
    thread warn_facial_dialogue_too_many(var_0);
    var_4 = [];

    if(!isarray(var_2)) {
      var_4[0] = var_2;
    } else {
      var_4 = var_2;
    }

    foreach(var_6 in var_4) {
      self waittillmatch("face_done_" + var_0, "dialogue_line");
      animscripts\face::sayspecificdialogue(undefined, var_6, 1.0);
    }

    self notify("all_facial_lines_done");
  } else
    animscripts\face::sayspecificdialogue(undefined, var_2, 1.0, "single dialogue");
}

notify_facial_anim_end(var_0) {
  self endon("death");
  self waittillmatch("face_done_" + var_0, "end");
  self notify("facial_anim_end_" + var_0);
}

warn_facial_dialogue_unspoken(var_0) {
  self endon("death");
  self endon("all_facial_lines_done");
  self waittill("facial_anim_end_" + var_0);
}

warn_facial_dialogue_too_many(var_0) {
  self endon("death");
  self endon("facial_anim_end_" + var_0);
  self waittill("all_facial_lines_done");
  self waittillmatch("face_done_" + var_0, "dialogue_line");
}