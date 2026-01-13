/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\crafted_trap_mindcontrol.gsc
***************************************************/

init() {
  level.mindcontrol_trap_settings = [];
  var_0 = spawnStruct();
  var_0.var_39B = "zmb_robotprojectile_mp";
  var_0.modelbase = "cp_town_mind_control_device";
  var_0.modelplacement = "cp_town_mind_control_device_good";
  var_0.modelplacementfailed = "cp_town_mind_control_device_bad";
  var_0.pow = &"COOP_CRAFTABLES_PICKUP";
  var_0.placestring = &"COOP_CRAFTABLES_PLACE";
  var_0.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_0.placecancelablestring = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_0.lifespan = 45;
  var_0.placementheighttolerance = 30;
  var_0.placementradius = 24;
  var_0.carriedtrapoffset = (0, 0, 0);
  var_0.carriedtrapangles = (0, 0, 0);
  level.mindcontrol_trap_settings["crafted_mindcontrol"] = var_0;
}

give_crafted_mindcontrol_trap(var_0, var_1) {
  var_1 thread watch_dpad();
  var_1 notify("new_power", "crafted_mindcontrol");
  var_1 setclientomnvar("zom_crafted_weapon", 15);
  scripts\cp\utility::set_crafted_inventory_item("crafted_mindcontrol", ::give_crafted_mindcontrol_trap, var_1);
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

  thread give_mindcontrol_trap("crafted_mindcontrol");
}

give_mindcontrol_trap(var_0) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_1 = create_mindcontrol_trap_for_player(var_0, self);
  self.itemtype = var_1.name;
  scripts\cp\utility::remove_player_perks();
  self.carried_mindcontrol_trap = var_1;
  var_1.firstplacement = 1;
  var_2 = set_carrying_mindcontrol(var_1, 1);
  self.carried_mindcontrol_trap = undefined;
  thread scripts\cp\utility::restore_player_perk();
  return var_2;
}

set_carrying_mindcontrol(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 thread mindcontrol_trap_setcarried(self);
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

      var_0 mindcontrol_trap_setcancelled(var_3 == "force_cancel_placement" && !isDefined(var_0.firstplacement));
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

    var_0 thread mindcontrol_trap_setplaced(var_2);
    self notify("IMS_placed");
    scripts\engine\utility::delaythread(0.5, ::scripts\engine\utility::allow_weapon, 1);
    return 1;
  }
}

create_mindcontrol_trap_for_player(var_0, var_1) {
  if(isDefined(var_1.iscarrying) && var_1.iscarrying) {
    return;
  }

  var_2 = spawnturret("misc_turret", var_1.origin + (0, 0, 25), "sentry_minigun_mp");
  var_2.angles = var_1.angles;
  var_2.mindcontrol_trap_type = var_0;
  var_2.triggerportableradarping = var_1;
  var_2.name = "crafted_mindcontrol";
  var_2.carried_mindcontrol_trap = spawn("script_model", var_2.origin);
  var_2.carried_mindcontrol_trap.angles = var_1.angles;
  var_2 getvalidattachments();
  var_2 setturretmodechangewait(1);
  var_2 give_player_session_tokens("sentry_offline");
  var_2 makeunusable();
  var_2 setsentryowner(var_1);
  return var_2;
}

create_mindcontrol_trap(var_0, var_1) {
  var_2 = var_0.triggerportableradarping;
  var_3 = var_0.mindcontrol_trap_type;
  var_4 = spawn("script_model", var_0.origin + (0, 0, 2));
  var_4 setModel(level.mindcontrol_trap_settings[var_3].modelbase);
  var_4.var_EB9C = 3;
  var_4.angles = (0, var_0.carried_mindcontrol_trap.angles[1], 0);
  var_4.mindcontrol_trap_type = var_3;
  var_4.triggerportableradarping = var_2;
  var_4 setotherent(var_2);
  var_4.team = var_2.team;
  var_4.name = "crafted_mindcontrol";
  var_4.shouldsplash = 0;
  var_4.hidden = 0;
  var_4.config = level.mindcontrol_trap_settings[var_3];
  var_4 thread mindcontrol_trap_handleuse();
  if(isDefined(var_1)) {
    var_4 thread scripts\cp\utility::item_timeout(var_1);
  } else {
    var_4 thread scripts\cp\utility::item_timeout(undefined, level.mindcontrol_trap_settings[self.mindcontrol_trap_type].lifespan);
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

  mindcontrol_trap_setinactive();
  if(isDefined(self.inuseby)) {
    self.inuseby scripts\cp\utility::restore_player_perk();
    self notify("deleting");
    wait(1);
  }

  func_66A7();
  self delete();
}

func_66A7() {
  self playSound("trap_boom_box_explode");
  playFX(level._effect["violet_light_explode"], self.origin);
  wait(0.1);
  radiusdamage(self.origin + (0, 0, 40), 200, 500, 250, self, "MOD_EXPLOSIVE", "iw7_electrictrap_zm");
  self hide();
  wait(0.65);
  physicsexplosionsphere(self.origin, 256, 256, 2);
}

mindcontrol_trap_handleuse() {
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

    var_1 = create_mindcontrol_trap_for_player(self.mindcontrol_trap_type, var_0);
    if(!isDefined(var_1)) {
      continue;
    }

    mindcontrol_trap_setinactive();
    if(isDefined(self getlinkedparent())) {
      self unlink();
    }

    var_0 thread set_carrying_mindcontrol(var_1, 0, self.lifespan);
    self delete();
    break;
  }
}

mindcontrol_trap_setplaced(var_0) {
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
  var_1 = create_mindcontrol_trap(self, var_0);
  var_1.isplaced = 1;
  var_1 thread func_9367(self.triggerportableradarping);
  self playSound("trap_boom_box_drop");
  self notify("placed");
  var_1 thread mindcontrol_trap_setactive();
  var_2 = spawnStruct();
  if(isDefined(self.moving_platform)) {
    var_2.linkparent = self.moving_platform;
  }

  var_2.endonstring = "carried";
  var_2.deathoverridecallback = ::func_936D;
  var_1 thread scripts\cp\cp_movers::handle_moving_platforms(var_2);
  self.carried_mindcontrol_trap delete();
  self delete();
}

mindcontrol_trap_setcancelled(var_0) {
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

  self.carried_mindcontrol_trap delete();
  self delete();
}

mindcontrol_trap_setcarried(var_0) {
  self setsentrycarrier(var_0);
  self setcontents(0);
  self setCanDamage(0);
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  var_0 thread scripts\cp\utility::update_trap_placement_internal(self, self.carried_mindcontrol_trap, level.mindcontrol_trap_settings["crafted_mindcontrol"]);
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
  mindcontrol_trap_setcancelled();
}

func_9371(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("last_stand");
  level waittill("game_ended");
  mindcontrol_trap_setcancelled();
}

mindcontrol_trap_setactive() {
  self endon("death");
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.mindcontrol_trap_settings[self.mindcontrol_trap_type].pow);
  scripts\cp\utility::addtotraplist();
  var_0 = self.triggerportableradarping;
  var_0 getrigindexfromarchetyperef();
  scripts\cp\utility::setselfusable(var_0);
  self setusefov(120);
  self setuserange(96);
  thread mindcontrol_trap_kill_zombies();
  thread scripts\cp\utility::item_handleownerdisconnect("mindcontrol_disconnect");
  if(!isDefined(var_0.next_trap_time)) {
    var_0.next_trap_time = gettime();
  }

  wait(1);
  if(isDefined(var_0)) {
    if(gettime() >= var_0.next_trap_time) {
      self setscriptablepartstate("mindcontrol", "on");
    } else {
      while(gettime() <= var_0.next_trap_time) {
        wait(0.05);
      }

      self setscriptablepartstate("mindcontrol", "on");
    }

    if(isDefined(var_0)) {
      var_0.next_trap_time = gettime() + 3000;
      return;
    }

    return;
  }

  self notify("death");
}

mindcontrol_trap_setinactive() {
  self makeunusable();
  self stoploopsound();
  self setscriptablepartstate("mindcontrol", "off");
  if(isDefined(self.dmg_trig)) {
    self.dmg_trig delete();
  }

  scripts\cp\utility::removefromtraplist();
}

mindcontrol_trap_kill_zombies() {
  self endon("death");
  self.dmg_trig = spawn("trigger_radius", self.origin, 0, 200, 64);
  for(;;) {
    var_0 = 0;
    self waittill("scriptableNotification");
    var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    foreach(var_3 in var_1) {
      if(!var_3 istouching(self.dmg_trig)) {
        continue;
      }

      if(!scripts\cp\utility::should_be_affected_by_trap(var_3) || scripts\engine\utility::istrue(var_3.controlled) || scripts\engine\utility::istrue(var_3.about_to_dance) || scripts\engine\utility::istrue(var_3.is_dancing)) {
        continue;
      }

      if(var_3.agent_type == "crab_mini" || var_3.agent_type == "crab_brute") {
        continue;
      }

      if(var_0 >= 3) {
        continue;
      }

      var_3 thread control_zombie(self);
      var_0++;
    }
  }
}

control_zombie(var_0) {
  self endon("death");
  self.controlled = 1;
  self.triggerportableradarping = var_0.triggerportableradarping;
  self.var_C384 = self.health;
  self.og_maxhealth = self.maxhealth;
  self.og_movemode = self.synctransients;
  self.goalradius_old = self.objective_playermask_showto;
  self.is_turned = 1;
  self.melee_damage_amt = int(scripts\cp\zombies\zombies_spawning::calculatezombiehealth("generic_zombie") * 0.5);
  self.synctransients = "sprint";
  self setscriptablepartstate("eyes", "turned_eyes");
  self.team = "allies";
  self.maxhealth = 1500;
  self.health = 1500;
  thread kill_intersecting_zombies(var_0);
  wait(60);
  self notify("end_control");
  self.maxhealth = self.og_maxhealth;
  self.health = self.var_C384;
  self.is_turned = undefined;
  self.melee_damage_amt = undefined;
  self.controlled = 0;
  self.team = "axis";
  self.synctransients = self.og_movemode;
  self.objective_playermask_showto = self.goalradius_old;
  self setscriptablepartstate("eyes", "yellow_eyes");
}

kill_intersecting_zombies(var_0) {
  self endon("death");
  self endon("end_control");
  var_1 = 576;
  for(;;) {
    var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    if(var_2.size == 0) {
      wait(0.05);
      continue;
    }

    var_3 = scripts\engine\utility::getclosest(self.origin, var_2);
    if(distancesquared(var_3.origin, self.origin) < var_1) {
      var_3.full_gib = 1;
      var_3.customdeath = 1;
      var_3 dodamage(var_3.health + 100, var_3.origin, self, self, "MOD_MELEE", "none");
      if(isDefined(var_0.triggerportableradarping)) {
        var_0.triggerportableradarping scripts\cp\cp_merits::processmerit("mt_dlc3_crafted_kills");
      }
    }

    wait(0.05);
  }
}