/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\crafted_trap_robot.gsc
*********************************************/

init() {
  level.robot_trap_settings = [];
  var_0 = spawnStruct();
  var_0.weaponinfo = "zmb_robotprojectile_mp";
  var_0.modelbase = "cp_disco_rocket_robot";
  var_0.modelplacement = "cp_disco_rocket_robot";
  var_0.modelplacementfailed = "cp_disco_rocket_robot_bad";
  var_0.hintstring = &"COOP_CRAFTABLES_PICKUP";
  var_0.placestring = &"COOP_CRAFTABLES_PLACE";
  var_0.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_0.placecancelablestring = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_0.lifespan = 120;
  var_0.var_DDAC = 2;
  var_0.var_C228 = 12;
  var_0.var_6A03 = "cp_disco_rocket_ammo_tag";
  var_0.placementheighttolerance = 30;
  var_0.placementradius = 16;
  var_0.carriedtrapoffset = (0, 0, 15);
  var_0.carriedtrapangles = (0, 90, 0);
  level.robot_trap_settings["crafted_ims"] = var_0;
}

give_crafted_robot_trap(var_0, var_1) {
  var_1 thread watch_dpad();
  var_1 notify("new_power", "crafted_robot");
  var_1 setclientomnvar("zom_crafted_weapon", 12);
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_ims", ::give_crafted_robot_trap, var_1);
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

give_robot_trap(var_0) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_1 = create_robot_trap_for_player(var_0, self);
  self.itemtype = var_1.name;
  scripts\cp\utility::remove_player_perks();
  self.carried_robot_trap = var_1;
  var_1.firstplacement = 1;
  var_2 = func_F684(var_1, 1);
  self.carried_robot_trap = undefined;
  thread scripts\cp\utility::restore_player_perk();
  return var_2;
}

func_F684(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 thread robot_trap_setcarried(self);
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
    var_3 = scripts\engine\utility::waittill_any_return("place_ims", "cancel_ims", "force_cancel_placement", "player_action_slot_restart");
    if(!isDefined(var_3)) {
      var_3 = "force_cancel_placement";
    }

    if(var_3 == "cancel_ims" || var_3 == "force_cancel_placement" || var_3 == "player_action_slot_restart") {
      if(!var_1 && var_3 == "cancel_ims") {
        continue;
      }

      var_0 robot_trap_setcancelled(var_3 == "force_cancel_placement" && !isDefined(var_0.firstplacement));
      if(var_3 != "force_cancel_placement") {
        thread watch_dpad();
      } else if(var_1) {
        scripts\cp\utility::remove_crafted_item_from_inventory(self);
      }

      return 0;
    }

    if(!var_0.canbeplaced) {
      continue;
    }

    if(var_1) {
      scripts\cp\utility::remove_crafted_item_from_inventory(self);
    }

    var_0 thread robot_trap_setplaced(var_2);
    self notify("IMS_placed");
    scripts\engine\utility::delaythread(0.5, scripts\engine\utility::allow_weapon, 1);
    return 1;
  }
}

create_robot_trap_for_player(var_0, var_1) {
  if(isDefined(var_1.iscarrying) && var_1.iscarrying) {
    return;
  }

  var_2 = spawnturret("misc_turret", var_1.origin + (0, 0, 25), "sentry_minigun_mp");
  var_2.angles = var_1.angles;
  var_2.robot_trap_type = var_0;
  var_2.owner = var_1;
  var_2.name = "crafted_ims";
  var_2.carried_robot_trap = spawn("script_model", var_2.origin);
  var_2.carried_robot_trap.angles = var_1.angles;
  var_2 getvalidattachments();
  var_2 setturretmodechangewait(1);
  var_2 give_player_session_tokens("sentry_offline");
  var_2 makeunusable();
  var_2 setsentryowner(var_1);
  return var_2;
}

create_robot_trap(var_0, var_1) {
  var_2 = var_0.owner;
  var_3 = var_0.robot_trap_type;
  var_4 = spawn("script_model", var_0.origin + (0, 0, 2));
  var_4 setModel(level.robot_trap_settings[var_3].modelbase);
  var_4.var_EB9C = 3;
  var_4.angles = (0, var_0.carried_robot_trap.angles[1], 0);
  var_4.robot_trap_type = var_3;
  var_4.owner = var_2;
  var_4 setotherent(var_2);
  var_4.team = var_2.team;
  var_4.name = "crafted_ims";
  var_4.shouldsplash = 0;
  var_4.hidden = 0;
  var_4.var_252E = 1;
  var_4.var_8BF0 = [];
  var_4.config = level.robot_trap_settings[var_3];
  var_4 thread robot_trap_handleuse();
  if(isDefined(var_1)) {
    var_4 thread scripts\cp\utility::item_timeout(var_1);
  } else {
    var_4 thread scripts\cp\utility::item_timeout(undefined, level.robot_trap_settings[self.robot_trap_type].lifespan);
  }

  return var_4;
}

func_936D(var_0) {
  self.var_933C = 1;
  self notify("death");
}

func_9367(var_0) {
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
    self waittill("trigger", var_0);
    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_0.iscarrying)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_0.kung_fu_mode)) {
      continue;
    }

    var_1 = create_robot_trap_for_player(self.robot_trap_type, var_0);
    if(!isDefined(var_1)) {
      continue;
    }

    robot_trap_setinactive();
    if(isDefined(self getlinkedparent())) {
      self unlink();
    }

    var_0 thread func_F684(var_1, 0, self.lifespan);
    self delete();
    break;
  }
}

robot_trap_setplaced(var_0) {
  self endon("death");
  level endon("game_ended");
  if(isDefined(self.carriedby)) {
    self.carriedby getrigindexfromarchetyperef();
  }

  self.carriedby = undefined;
  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;
  }

  self.firstplacement = undefined;
  var_1 = create_robot_trap(self, var_0);
  var_1.isplaced = 1;
  var_1 thread func_9367(self.owner);
  self playSound("trap_boom_box_drop");
  self notify("placed");
  var_1 thread robot_trap_setactive();
  var_2 = spawnStruct();
  if(isDefined(self.moving_platform)) {
    var_2.linkparent = self.moving_platform;
  }

  var_2.endonstring = "carried";
  var_2.deathoverridecallback = ::func_936D;
  var_1 thread scripts\cp\cp_movers::handle_moving_platforms(var_2);
  self.carried_robot_trap delete();
  self delete();
}

robot_trap_setcancelled(var_0) {
  if(isDefined(self.carriedby)) {
    var_1 = self.carriedby;
    var_1 getrigindexfromarchetyperef();
    var_1.iscarrying = undefined;
    var_1.carrieditem = undefined;
    var_1 scripts\engine\utility::allow_weapon(1);
  }

  if(isDefined(var_0) && var_0) {
    func_66A7();
  }

  self.carried_robot_trap delete();
  self delete();
}

robot_trap_setcarried(var_0) {
  self setsentrycarrier(var_0);
  self setcontents(0);
  self setCanDamage(0);
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  var_0 thread scripts\cp\utility::update_trap_placement_internal(self, self.carried_robot_trap, level.robot_trap_settings["crafted_ims"]);
  thread scripts\cp\utility::item_oncarrierdeath(var_0);
  thread func_936F(var_0);
  thread func_9371(var_0);
  if(isDefined(level.var_5CF2)) {
    self thread[[level.var_5CF2]](var_0);
  }

  self notify("carried");
}

func_936F(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("last_stand");
  var_0 waittill("disconnect");
  robot_trap_setcancelled();
}

func_9371(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("last_stand");
  level waittill("game_ended");
  robot_trap_setcancelled();
}

robot_trap_setactive() {
  self endon("death");
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.robot_trap_settings[self.robot_trap_type].hintstring);
  scripts\cp\utility::addtotraplist();
  var_0 = self.owner;
  var_0 getrigindexfromarchetyperef();
  self setusefov(120);
  self setuserange(96);
  wait(0.05);
  self.var_2514 = self gettagorigin("tag_rocket_tube_01") + (0, 0, 72);
  self.alt_attackheightpos = self.var_2514;
  var_1 = bulletTrace(self.var_2514, self.var_2514 + (0, 0, 500), 0, self);
  var_2 = var_1["position"] - (0, 0, 20) - self.origin;
  if(var_2[2] > 250) {
    self.var_2514 = self gettagorigin("tag_rocket_tube_01") + (0, 0, 250);
  }

  self.attacklaunchpos = [];
  self.attacklaunchpos[0] = self gettagorigin("tag_rocket_tube_01") + (0, 0, -10);
  self.attacklaunchpos[1] = self gettagorigin("tag_rocket_tube_02") + (0, 0, -10);
  var_3 = spawn("trigger_radius", self.origin, 0, 300, 100);
  self.var_2536 = var_3;
  self.var_2536 enablelinkto();
  self.var_2536 linkto(self);
  self.var_2528 = 0.72;
  wait(0.75);
  self setscriptablepartstate("main", "anim_idle");
  self setscriptablepartstate("head_coils", "on");
  self setscriptablepartstate("LED_Panel", "Idle");
  thread rotate_robot();
  if(isDefined(self.owner)) {
    thread robot_usability_monitor(self.owner);
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

robot_usability_monitor(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2 == var_0) {
        if(scripts\engine\utility::istrue(var_0.kung_fu_mode)) {
          self makeunusable();
          self disableplayeruse(var_0);
        } else {
          self sethintstring(level.robot_trap_settings[self.robot_trap_type].hintstring);
          self setusefov(120);
          self setuserange(112);
          self makeusable();
          self enableplayeruse(var_0);
        }

        continue;
      }

      self disableplayeruse(var_2);
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

    self.var_2536 waittill("trigger", var_0);
    if(isplayer(var_0)) {
      continue;
    }

    if(!scripts\cp\utility::should_be_affected_by_trap(var_0, 0, 1)) {
      continue;
    }

    if(var_0.agent_type == "ratking") {
      continue;
    }

    if(isDefined(var_0.robot_target)) {
      continue;
    }

    if(distancesquared(var_0.origin, self.origin) < 9216) {
      var_0.robot_target = 1;
      self setscriptablepartstate("LED_Face", "Sad");
      self setscriptablepartstate("LED_Panel", "ZAP");
      thread robot_zap(var_0);
      wait(0.5);
      self setscriptablepartstate("LED_Face", "Smile");
      self setscriptablepartstate("LED_Panel", "Idle");
      continue;
    }

    var_1 = var_0.origin + (0, 0, 50);
    var_2 = 0;
    if(!sighttracepassed(self.var_2514, var_1, 0, self)) {
      if(!sighttracepassed(self.alt_attackheightpos, var_1, 0, self)) {
        continue;
      }

      var_2 = 1;
    }

    if(!isDefined(self.var_2536)) {
      break;
    }

    if(!isDefined(self.var_8BF0[self.var_252E])) {
      var_0.robot_target = 1;
      self.var_8BF0[self.var_252E] = 1;
      self.var_252E++;
      thread launch_rocket(var_0, self.var_252E, var_2);
    }

    if(self.var_252E % 2) {
      self waittill("firework_exploded");
    }

    wait(self.config.var_DDAC);
    if(!isDefined(self.owner)) {
      break;
    }

    if(self.var_252E >= level.robot_trap_settings["crafted_ims"].var_C228) {
      break;
    }
  }

  if(isDefined(self.carriedby) && isDefined(self.owner) && self.carriedby == self.owner) {
    return;
  }

  self notify("death");
}

robot_zap(var_0) {
  var_0.dontmutilate = 1;
  var_0.electrocuted = 1;
  thread electrocute_zombie(var_0);
  var_0 setscriptablepartstate("electrocuted", "on");
  if(isDefined(self.owner)) {
    var_1 = self.owner;
  } else {
    var_1 = undefined;
  }

  var_0 dodamage(var_0.health + 100, self.origin, var_1, self, "MOD_UNKNOWN", "iw7_robotzap_zm");
}

electrocute_zombie(var_0) {
  var_0 endon("death");
  var_1 = ["J_SpineLower", "J_Chest", "J_Head", "J_Neck", "J_Crotch"];
  var_2 = self gettagorigin("tag_fx_laser_dish");
  var_3 = scripts\engine\utility::random(var_1);
  var_4 = var_0 gettagorigin(var_3);
  playsoundatpos(self.origin, "trap_electric_shock");
  playfxbetweenpoints(level._effect["robot_zap"], var_2, vectortoangles(var_4 - var_2), var_4);
}

launch_rocket(var_0, var_1, var_2) {
  if(!isDefined(self.last_launch_tube)) {
    self.last_launch_tube = 0;
  }

  if(self.last_launch_tube == 0) {
    var_3 = self.attacklaunchpos[1];
    self setscriptablepartstate("right_launch", "launch");
  } else {
    self setscriptablepartstate("left_launch", "launch");
    var_3 = self.attacklaunchpos[0];
  }

  thread launch_anim();
  if(self.last_launch_tube == 0) {
    self.last_launch_tube = 1;
  } else {
    self.last_launch_tube = 0;
  }

  var_4 = spawn("script_model", var_3);
  var_4 setModel(self.config.var_6A03);
  var_4.angles = self.angles;
  var_5 = self.config.weaponinfo;
  var_6 = self.owner;
  var_7 = self.var_2514;
  if(var_2) {
    var_7 = self.alt_attackheightpos;
  }

  var_4 moveto(var_7, self.var_2528, self.var_2528 * 0.5, 0);
  wait(self.var_2528);
  var_4 setscriptablepartstate("rocket", "explode");
  if(isDefined(var_6)) {
    var_8 = magicbullet(var_5, var_4.origin, (var_0.origin[0], var_0.origin[1], var_4.origin[2] - 5), var_6);
  } else {
    var_8 = magicbullet(var_6, var_5.origin, var_1.origin, level.players[0]);
  }

  var_8 thread watch_for_death();
  wait(0.1);
  var_4 delete();
  var_8 missile_settargetent(var_0);
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