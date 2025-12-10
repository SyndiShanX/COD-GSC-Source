/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\crafted_trap_robot.gsc
*********************************************/

init() {
  level.robot_trap_settings = [];
  var_00 = spawnStruct();
  var_00.var_39B = "zmb_robotprojectile_mp";
  var_00.modelbase = "cp_disco_rocket_robot";
  var_00.modelplacement = "cp_disco_rocket_robot";
  var_00.modelplacementfailed = "cp_disco_rocket_robot_bad";
  var_00.pow = &"COOP_CRAFTABLES_PICKUP";
  var_00.placestring = &"COOP_CRAFTABLES_PLACE";
  var_00.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_00.placecancelablestring = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_00.lifespan = 120;
  var_00.var_DDAC = 2;
  var_00.var_C228 = 12;
  var_00.var_6A03 = "cp_disco_rocket_ammo_tag";
  var_00.placementheighttolerance = 30;
  var_00.placementradius = 16;
  var_00.carriedtrapoffset = (0, 0, 15);
  var_00.carriedtrapangles = (0, 90, 0);
  level.robot_trap_settings["crafted_ims"] = var_00;
}

give_crafted_robot_trap(param_00, param_01) {
  param_01 thread watch_dpad();
  param_01 notify("new_power", "crafted_robot");
  param_01 setclientomnvar("zom_crafted_weapon", 12);
  param_01 thread scripts\cp\utility::usegrenadegesture(param_01, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_ims", ::give_crafted_robot_trap, param_01);
}

watch_dpad() {
  self endon("death");
  self endon("disconnect");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_ims", "+actionslot 3");
  for(;;) {
    self waittill("pullout_ims");
    if(scripts\engine\utility::istrue(self.iscarrying)) {
      continue;
    }

    if(scripts\engine\utility::istrue(self.linked_to_coaster)) {
      continue;
    }

    if(isDefined(self.allow_carry) && self.allow_carry == 0) {
      continue;
    }

    if(scripts\cp\utility::is_valid_player()) {
      break;
    }
  }

  thread give_robot_trap("crafted_ims");
}

give_robot_trap(param_00) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_01 = create_robot_trap_for_player(param_00, self);
  self.itemtype = var_01.name;
  scripts\cp\utility::remove_player_perks();
  self.carried_robot_trap = var_01;
  var_01.firstplacement = 1;
  var_02 = func_F684(var_01, 1);
  self.carried_robot_trap = undefined;
  thread scripts\cp\utility::restore_player_perk();
  return var_02;
}

func_F684(param_00, param_01, param_02) {
  self endon("disconnect");
  param_00 thread robot_trap_setcarried(self);
  scripts\engine\utility::allow_weapon(0);
  self notifyonplayercommand("place_ims", "+attack");
  self notifyonplayercommand("place_ims", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_ims", "+actionslot 3");
  if(!level.console) {
    self notifyonplayercommand("cancel_ims", "+actionslot 5");
    self notifyonplayercommand("cancel_ims", "+actionslot 6");
    self notifyonplayercommand("cancel_ims", "+actionslot 7");
  }

  for(;;) {
    var_03 = scripts\engine\utility::waittill_any_return("place_ims", "cancel_ims", "force_cancel_placement", "player_action_slot_restart");
    if(!isDefined(var_03)) {
      var_03 = "force_cancel_placement";
    }

    if(var_03 == "cancel_ims" || var_03 == "force_cancel_placement" || var_03 == "player_action_slot_restart") {
      if(!param_01 && var_03 == "cancel_ims") {
        continue;
      }

      param_00 robot_trap_setcancelled(var_03 == "force_cancel_placement" && !isDefined(param_00.firstplacement));
      if(var_03 != "force_cancel_placement") {
        thread watch_dpad();
      } else if(param_01) {
        scripts\cp\utility::remove_crafted_item_from_inventory(self);
      }

      return 0;
    }

    if(!param_00.canbeplaced) {
      continue;
    }

    if(param_01) {
      scripts\cp\utility::remove_crafted_item_from_inventory(self);
    }

    param_00 thread robot_trap_setplaced(param_02);
    self notify("IMS_placed");
    scripts\engine\utility::delaythread(0.5, ::scripts\engine\utility::allow_weapon, 1);
    return 1;
  }
}

create_robot_trap_for_player(param_00, param_01) {
  if(isDefined(param_01.iscarrying) && param_01.iscarrying) {
    return;
  }

  var_02 = spawnturret("misc_turret", param_01.origin + (0, 0, 25), "sentry_minigun_mp");
  var_02.angles = param_01.angles;
  var_02.robot_trap_type = param_00;
  var_02.triggerportableradarping = param_01;
  var_02.name = "crafted_ims";
  var_02.carried_robot_trap = spawn("script_model", var_02.origin);
  var_02.carried_robot_trap.angles = param_01.angles;
  var_02 getvalidattachments();
  var_02 setturretmodechangewait(1);
  var_02 give_player_session_tokens("sentry_offline");
  var_02 makeunusable();
  var_02 setsentryowner(param_01);
  return var_02;
}

create_robot_trap(param_00, param_01) {
  var_02 = param_00.triggerportableradarping;
  var_03 = param_00.robot_trap_type;
  var_04 = spawn("script_model", param_00.origin + (0, 0, 2));
  var_04 setModel(level.robot_trap_settings[var_03].modelbase);
  var_04.var_EB9C = 3;
  var_04.angles = (0, param_00.carried_robot_trap.angles[1], 0);
  var_04.robot_trap_type = var_03;
  var_04.triggerportableradarping = var_02;
  var_04 setotherent(var_02);
  var_04.team = var_02.team;
  var_04.name = "crafted_ims";
  var_04.shouldsplash = 0;
  var_04.hidden = 0;
  var_04.var_252E = 1;
  var_04.var_8BF0 = [];
  var_04.config = level.robot_trap_settings[var_03];
  var_04 thread robot_trap_handleuse();
  if(isDefined(param_01)) {
    var_04 thread scripts\cp\utility::item_timeout(param_01);
  } else {
    var_04 thread scripts\cp\utility::item_timeout(undefined, level.robot_trap_settings[self.robot_trap_type].lifespan);
  }

  return var_04;
}

func_936D(param_00) {
  self.var_933C = 1;
  self notify("death");
}

func_9367(param_00) {
  self endon("carried");
  self waittill("death");
  if(!isDefined(self)) {
    return;
  }

  robot_trap_setinactive();
  if(isDefined(self.inuseby)) {
    self.inuseby scripts\cp\utility::restore_player_perk();
    self notify("deleting");
    wait(1);
  }

  func_66A7();
  self delete();
}

func_66A7() {
  self setscriptablepartstate("main", "anim_death");
  wait(3);
  playsoundatpos(self.origin + (0, 0, 60), "disco_toy_robot_explo");
  wait(0.1);
  radiusdamage(self.origin + (0, 0, 40), 200, 500, 250, self, "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
  self hide();
  wait(0.65);
  physicsexplosionsphere(self.origin, 256, 256, 2);
}

robot_trap_handleuse() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("trigger", var_00);
    if(!var_00 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_00.iscarrying)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_00.kung_fu_mode)) {
      continue;
    }

    var_01 = create_robot_trap_for_player(self.robot_trap_type, var_00);
    if(!isDefined(var_01)) {
      continue;
    }

    robot_trap_setinactive();
    if(isDefined(self getlinkedparent())) {
      self unlink();
    }

    var_00 thread func_F684(var_01, 0, self.lifespan);
    self delete();
    break;
  }
}

robot_trap_setplaced(param_00) {
  self endon("death");
  level endon("game_ended");
  if(isDefined(self.carriedby)) {
    self.carriedby getrigindexfromarchetyperef();
  }

  self.carriedby = undefined;
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping.iscarrying = 0;
  }

  self.firstplacement = undefined;
  var_01 = create_robot_trap(self, param_00);
  var_01.isplaced = 1;
  var_01 thread func_9367(self.triggerportableradarping);
  self playSound("trap_boom_box_drop");
  self notify("placed");
  var_01 thread robot_trap_setactive();
  var_02 = spawnStruct();
  if(isDefined(self.moving_platform)) {
    var_02.linkparent = self.moving_platform;
  }

  var_02.endonstring = "carried";
  var_02.deathoverridecallback = ::func_936D;
  var_01 thread scripts\cp\cp_movers::handle_moving_platforms(var_02);
  self.carried_robot_trap delete();
  self delete();
}

robot_trap_setcancelled(param_00) {
  if(isDefined(self.carriedby)) {
    var_01 = self.carriedby;
    var_01 getrigindexfromarchetyperef();
    var_01.iscarrying = undefined;
    var_01.carrieditem = undefined;
    var_01 scripts\engine\utility::allow_weapon(1);
  }

  if(isDefined(param_00) && param_00) {
    func_66A7();
  }

  self.carried_robot_trap delete();
  self delete();
}

robot_trap_setcarried(param_00) {
  self setsentrycarrier(param_00);
  self setcontents(0);
  self setCanDamage(0);
  self.carriedby = param_00;
  param_00.iscarrying = 1;
  param_00 thread scripts\cp\utility::update_trap_placement_internal(self, self.carried_robot_trap, level.robot_trap_settings["crafted_ims"]);
  thread scripts\cp\utility::item_oncarrierdeath(param_00);
  thread func_936F(param_00);
  thread func_9371(param_00);
  if(isDefined(level.var_5CF2)) {
    self thread[[level.var_5CF2]](param_00);
  }

  self notify("carried");
}

func_936F(param_00) {
  self endon("placed");
  self endon("death");
  param_00 endon("last_stand");
  param_00 waittill("disconnect");
  robot_trap_setcancelled();
}

func_9371(param_00) {
  self endon("placed");
  self endon("death");
  param_00 endon("last_stand");
  level waittill("game_ended");
  robot_trap_setcancelled();
}

robot_trap_setactive() {
  self endon("death");
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.robot_trap_settings[self.robot_trap_type].pow);
  scripts\cp\utility::addtotraplist();
  var_00 = self.triggerportableradarping;
  var_00 getrigindexfromarchetyperef();
  self setusefov(120);
  self setuserange(96);
  wait(0.05);
  self.var_2514 = self gettagorigin("tag_rocket_tube_01") + (0, 0, 72);
  self.alt_attackheightpos = self.var_2514;
  var_01 = bulletTrace(self.var_2514, self.var_2514 + (0, 0, 500), 0, self);
  var_02 = var_01["position"] - (0, 0, 20) - self.origin;
  if(var_02[2] > 250) {
    self.var_2514 = self gettagorigin("tag_rocket_tube_01") + (0, 0, 250);
  }

  self.attacklaunchpos = [];
  self.attacklaunchpos[0] = self gettagorigin("tag_rocket_tube_01") + (0, 0, -10);
  self.attacklaunchpos[1] = self gettagorigin("tag_rocket_tube_02") + (0, 0, -10);
  var_03 = spawn("trigger_radius", self.origin, 0, 300, 100);
  self.var_2536 = var_03;
  self.var_2536 enablelinkto();
  self.var_2536 linkto(self);
  self.var_2528 = 0.72;
  wait(0.75);
  self setscriptablepartstate("main", "anim_idle");
  self setscriptablepartstate("head_coils", "on");
  self setscriptablepartstate("LED_Panel", "Idle");
  thread rotate_robot();
  if(isDefined(self.triggerportableradarping)) {
    thread robot_usability_monitor(self.triggerportableradarping);
  }

  thread robot_trap_attackzombies();
  thread scripts\cp\utility::item_handleownerdisconnect("robot_disconnect");
}

rotate_robot() {
  self endon("death");
  self playLoopSound("disco_toy_robot_mvmt_lp");
  for(;;) {
    self rotateyaw(15, 2);
    wait(2);
  }
}

robot_trap_setinactive() {
  self makeunusable();
  self stoploopsound();
  if(isDefined(self.var_2536)) {
    self.var_2536 delete();
  }

  if(isDefined(self.var_69F6)) {
    self.var_69F6 delete();
    self.var_69F6 = undefined;
  }

  scripts\cp\utility::removefromtraplist();
}

robot_usability_monitor(param_00) {
  self endon("death");
  param_00 endon("disconnect");
  for(;;) {
    foreach(var_02 in level.players) {
      if(var_02 == param_00) {
        if(scripts\engine\utility::istrue(param_00.kung_fu_mode)) {
          self makeunusable();
          self disableplayeruse(param_00);
        } else {
          self sethintstring(level.robot_trap_settings[self.robot_trap_type].pow);
          self setusefov(120);
          self setuserange(112);
          self makeusable();
          self enableplayeruse(param_00);
        }

        continue;
      }

      self disableplayeruse(var_02);
    }

    wait(1);
  }
}

robot_trap_attackzombies() {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("LED_Face", "Smile");
  for(;;) {
    if(!isDefined(self.var_2536)) {
      break;
    }

    self.var_2536 waittill("trigger", var_00);
    if(isplayer(var_00)) {
      continue;
    }

    if(!scripts\cp\utility::should_be_affected_by_trap(var_00, 0, 1)) {
      continue;
    }

    if(var_00.agent_type == "ratking") {
      continue;
    }

    if(isDefined(var_00.robot_target)) {
      continue;
    }

    if(distancesquared(var_00.origin, self.origin) < 9216) {
      var_00.robot_target = 1;
      self setscriptablepartstate("LED_Face", "Sad");
      self setscriptablepartstate("LED_Panel", "ZAP");
      thread robot_zap(var_00);
      wait(0.5);
      self setscriptablepartstate("LED_Face", "Smile");
      self setscriptablepartstate("LED_Panel", "Idle");
      continue;
    }

    var_01 = var_00.origin + (0, 0, 50);
    var_02 = 0;
    if(!sighttracepassed(self.var_2514, var_01, 0, self)) {
      if(!sighttracepassed(self.alt_attackheightpos, var_01, 0, self)) {
        continue;
      }

      var_02 = 1;
    }

    if(!isDefined(self.var_2536)) {
      break;
    }

    if(!isDefined(self.var_8BF0[self.var_252E])) {
      var_00.robot_target = 1;
      self.var_8BF0[self.var_252E] = 1;
      self.var_252E++;
      thread launch_rocket(var_00, self.var_252E, var_02);
    }

    if(self.var_252E % 2) {
      self waittill("firework_exploded");
    }

    wait(self.config.var_DDAC);
    if(!isDefined(self.triggerportableradarping)) {
      break;
    }

    if(self.var_252E >= level.robot_trap_settings["crafted_ims"].var_C228) {
      break;
    }
  }

  if(isDefined(self.carriedby) && isDefined(self.triggerportableradarping) && self.carriedby == self.triggerportableradarping) {
    return;
  }

  self notify("death");
}

robot_zap(param_00) {
  param_00.dontmutilate = 1;
  param_00.electrocuted = 1;
  thread electrocute_zombie(param_00);
  param_00 setscriptablepartstate("electrocuted", "on");
  if(isDefined(self.triggerportableradarping)) {
    var_01 = self.triggerportableradarping;
  } else {
    var_01 = undefined;
  }

  param_00 dodamage(param_00.health + 100, self.origin, var_01, self, "MOD_UNKNOWN", "iw7_robotzap_zm");
}

electrocute_zombie(param_00) {
  param_00 endon("death");
  var_01 = ["J_SpineLower", "J_Chest", "J_Head", "J_Neck", "J_Crotch"];
  var_02 = self gettagorigin("tag_fx_laser_dish");
  var_03 = scripts\engine\utility::random(var_01);
  var_04 = param_00 gettagorigin(var_03);
  playsoundatpos(self.origin, "trap_electric_shock");
  playfxbetweenpoints(level._effect["robot_zap"], var_02, vectortoangles(var_04 - var_02), var_04);
}

launch_rocket(param_00, param_01, param_02) {
  if(!isDefined(self.last_launch_tube)) {
    self.last_launch_tube = 0;
  }

  if(self.last_launch_tube == 0) {
    var_03 = self.attacklaunchpos[1];
    self setscriptablepartstate("right_launch", "launch");
  } else {
    self setscriptablepartstate("left_launch", "launch");
    var_03 = self.attacklaunchpos[0];
  }

  thread launch_anim();
  if(self.last_launch_tube == 0) {
    self.last_launch_tube = 1;
  } else {
    self.last_launch_tube = 0;
  }

  var_04 = spawn("script_model", var_03);
  var_04 setModel(self.config.var_6A03);
  var_04.angles = self.angles;
  var_05 = self.config.var_39B;
  var_06 = self.triggerportableradarping;
  var_07 = self.var_2514;
  if(param_02) {
    var_07 = self.alt_attackheightpos;
  }

  var_04 moveto(var_07, self.var_2528, self.var_2528 * 0.5, 0);
  wait(self.var_2528);
  var_04 setscriptablepartstate("rocket", "explode");
  if(isDefined(var_06)) {
    var_08 = magicbullet(var_05, var_04.origin, (param_00.origin[0], param_00.origin[1], var_04.origin[2] - 5), var_06);
  } else {
    var_08 = magicbullet(var_06, var_05.origin, param_01.origin, level.players[0]);
  }

  var_08 thread watch_for_death();
  wait(0.1);
  var_04 delete();
  var_08 missile_settargetent(param_00);
  wait(1.5);
  self notify("firework_exploded");
}

launch_anim() {
  self endon("death");
  self setscriptablepartstate("main", "anim_launch");
  self setscriptablepartstate("LED_Panel", "Boom");
  self setscriptablepartstate("LED_Face", "Sad");
  wait(1);
  if(self.var_252E % 2) {
    self setscriptablepartstate("main", "anim_headspin");
    wait(1);
  }

  self setscriptablepartstate("LED_Panel", "Idle");
  self setscriptablepartstate("LED_Face", "Smile");
  self setscriptablepartstate("main", "anim_idle");
}

watch_for_death() {
  self waittill("death");
  earthquake(0.35, 1, self.origin, 196);
  playrumbleonposition("artillery_rumble", self.origin);
}