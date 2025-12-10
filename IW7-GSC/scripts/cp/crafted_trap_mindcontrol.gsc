/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\crafted_trap_mindcontrol.gsc
***************************************************/

init() {
  level.mindcontrol_trap_settings = [];
  var_00 = spawnStruct();
  var_00.var_39B = "zmb_robotprojectile_mp";
  var_00.modelbase = "cp_town_mind_control_device";
  var_00.modelplacement = "cp_town_mind_control_device_good";
  var_00.modelplacementfailed = "cp_town_mind_control_device_bad";
  var_00.pow = &"COOP_CRAFTABLES_PICKUP";
  var_00.placestring = &"COOP_CRAFTABLES_PLACE";
  var_00.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_00.placecancelablestring = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_00.lifespan = 45;
  var_00.placementheighttolerance = 30;
  var_00.placementradius = 24;
  var_00.carriedtrapoffset = (0, 0, 0);
  var_00.carriedtrapangles = (0, 0, 0);
  level.mindcontrol_trap_settings["crafted_mindcontrol"] = var_00;
}

give_crafted_mindcontrol_trap(param_00, param_01) {
  param_01 thread watch_dpad();
  param_01 notify("new_power", "crafted_mindcontrol");
  param_01 setclientomnvar("zom_crafted_weapon", 15);
  scripts\cp\utility::set_crafted_inventory_item("crafted_mindcontrol", ::give_crafted_mindcontrol_trap, param_01);
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

give_mindcontrol_trap(param_00) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_01 = create_mindcontrol_trap_for_player(param_00, self);
  self.itemtype = var_01.name;
  scripts\cp\utility::remove_player_perks();
  self.carried_mindcontrol_trap = var_01;
  var_01.firstplacement = 1;
  var_02 = set_carrying_mindcontrol(var_01, 1);
  self.carried_mindcontrol_trap = undefined;
  thread scripts\cp\utility::restore_player_perk();
  return var_02;
}

set_carrying_mindcontrol(param_00, param_01, param_02) {
  self endon("disconnect");
  param_00 thread mindcontrol_trap_setcarried(self);
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

      param_00 mindcontrol_trap_setcancelled(var_03 == "force_cancel_placement" && !isDefined(param_00.firstplacement));
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

    param_00 thread mindcontrol_trap_setplaced(param_02);
    self notify("IMS_placed");
    scripts\engine\utility::delaythread(0.5, ::scripts\engine\utility::allow_weapon, 1);
    return 1;
  }
}

create_mindcontrol_trap_for_player(param_00, param_01) {
  if(isDefined(param_01.iscarrying) && param_01.iscarrying) {
    return;
  }

  var_02 = spawnturret("misc_turret", param_01.origin + (0, 0, 25), "sentry_minigun_mp");
  var_02.angles = param_01.angles;
  var_02.mindcontrol_trap_type = param_00;
  var_02.triggerportableradarping = param_01;
  var_02.name = "crafted_mindcontrol";
  var_02.carried_mindcontrol_trap = spawn("script_model", var_02.origin);
  var_02.carried_mindcontrol_trap.angles = param_01.angles;
  var_02 getvalidattachments();
  var_02 setturretmodechangewait(1);
  var_02 give_player_session_tokens("sentry_offline");
  var_02 makeunusable();
  var_02 setsentryowner(param_01);
  return var_02;
}

create_mindcontrol_trap(param_00, param_01) {
  var_02 = param_00.triggerportableradarping;
  var_03 = param_00.mindcontrol_trap_type;
  var_04 = spawn("script_model", param_00.origin + (0, 0, 2));
  var_04 setModel(level.mindcontrol_trap_settings[var_03].modelbase);
  var_04.var_EB9C = 3;
  var_04.angles = (0, param_00.carried_mindcontrol_trap.angles[1], 0);
  var_04.mindcontrol_trap_type = var_03;
  var_04.triggerportableradarping = var_02;
  var_04 setotherent(var_02);
  var_04.team = var_02.team;
  var_04.name = "crafted_mindcontrol";
  var_04.shouldsplash = 0;
  var_04.hidden = 0;
  var_04.config = level.mindcontrol_trap_settings[var_03];
  var_04 thread mindcontrol_trap_handleuse();
  if(isDefined(param_01)) {
    var_04 thread scripts\cp\utility::item_timeout(param_01);
  } else {
    var_04 thread scripts\cp\utility::item_timeout(undefined, level.mindcontrol_trap_settings[self.mindcontrol_trap_type].lifespan);
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

    var_01 = create_mindcontrol_trap_for_player(self.mindcontrol_trap_type, var_00);
    if(!isDefined(var_01)) {
      continue;
    }

    mindcontrol_trap_setinactive();
    if(isDefined(self getlinkedparent())) {
      self unlink();
    }

    var_00 thread set_carrying_mindcontrol(var_01, 0, self.lifespan);
    self delete();
    break;
  }
}

mindcontrol_trap_setplaced(param_00) {
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
  var_01 = create_mindcontrol_trap(self, param_00);
  var_01.isplaced = 1;
  var_01 thread func_9367(self.triggerportableradarping);
  self playSound("trap_boom_box_drop");
  self notify("placed");
  var_01 thread mindcontrol_trap_setactive();
  var_02 = spawnStruct();
  if(isDefined(self.moving_platform)) {
    var_02.linkparent = self.moving_platform;
  }

  var_02.endonstring = "carried";
  var_02.deathoverridecallback = ::func_936D;
  var_01 thread scripts\cp\cp_movers::handle_moving_platforms(var_02);
  self.carried_mindcontrol_trap delete();
  self delete();
}

mindcontrol_trap_setcancelled(param_00) {
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

  self.carried_mindcontrol_trap delete();
  self delete();
}

mindcontrol_trap_setcarried(param_00) {
  self setsentrycarrier(param_00);
  self setcontents(0);
  self setCanDamage(0);
  self.carriedby = param_00;
  param_00.iscarrying = 1;
  param_00 thread scripts\cp\utility::update_trap_placement_internal(self, self.carried_mindcontrol_trap, level.mindcontrol_trap_settings["crafted_mindcontrol"]);
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
  mindcontrol_trap_setcancelled();
}

func_9371(param_00) {
  self endon("placed");
  self endon("death");
  param_00 endon("last_stand");
  level waittill("game_ended");
  mindcontrol_trap_setcancelled();
}

mindcontrol_trap_setactive() {
  self endon("death");
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.mindcontrol_trap_settings[self.mindcontrol_trap_type].pow);
  scripts\cp\utility::addtotraplist();
  var_00 = self.triggerportableradarping;
  var_00 getrigindexfromarchetyperef();
  scripts\cp\utility::setselfusable(var_00);
  self setusefov(120);
  self setuserange(96);
  thread mindcontrol_trap_kill_zombies();
  thread scripts\cp\utility::item_handleownerdisconnect("mindcontrol_disconnect");
  if(!isDefined(var_00.next_trap_time)) {
    var_00.next_trap_time = gettime();
  }

  wait(1);
  if(isDefined(var_00)) {
    if(gettime() >= var_00.next_trap_time) {
      self setscriptablepartstate("mindcontrol", "on");
    } else {
      while(gettime() <= var_00.next_trap_time) {
        wait(0.05);
      }

      self setscriptablepartstate("mindcontrol", "on");
    }

    if(isDefined(var_00)) {
      var_00.next_trap_time = gettime() + 3000;
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
    var_00 = 0;
    self waittill("scriptableNotification");
    var_01 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    foreach(var_03 in var_01) {
      if(!var_03 istouching(self.dmg_trig)) {
        continue;
      }

      if(!scripts\cp\utility::should_be_affected_by_trap(var_03) || scripts\engine\utility::istrue(var_03.controlled) || scripts\engine\utility::istrue(var_03.about_to_dance) || scripts\engine\utility::istrue(var_03.is_dancing)) {
        continue;
      }

      if(var_03.agent_type == "crab_mini" || var_03.agent_type == "crab_brute") {
        continue;
      }

      if(var_00 >= 3) {
        continue;
      }

      var_03 thread control_zombie(self);
      var_00++;
    }
  }
}

control_zombie(param_00) {
  self endon("death");
  self.controlled = 1;
  self.triggerportableradarping = param_00.triggerportableradarping;
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
  thread kill_intersecting_zombies(param_00);
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

kill_intersecting_zombies(param_00) {
  self endon("death");
  self endon("end_control");
  var_01 = 576;
  for(;;) {
    var_02 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    if(var_02.size == 0) {
      wait(0.05);
      continue;
    }

    var_03 = scripts\engine\utility::getclosest(self.origin, var_02);
    if(distancesquared(var_03.origin, self.origin) < var_01) {
      var_03.full_gib = 1;
      var_03.customdeath = 1;
      var_03 dodamage(var_03.health + 100, var_03.origin, self, self, "MOD_MELEE", "none");
      if(isDefined(param_00.triggerportableradarping)) {
        param_00.triggerportableradarping scripts\cp\cp_merits::processmerit("mt_dlc3_crafted_kills");
      }
    }

    wait(0.05);
  }
}