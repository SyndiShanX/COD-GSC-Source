/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\crafted_trap_violetray.gsc
*************************************************/

init() {
  level.violetray_trap_settings = [];
  var_0 = spawnStruct();
  var_0.var_39B = "zmb_robotprojectile_mp";
  var_0.modelbase = "cp_town_violet_xray_device";
  var_0.modelplacement = "cp_town_violet_xray_device_good";
  var_0.modelplacementfailed = "cp_town_violet_xray_device_bad";
  var_0.pow = &"COOP_CRAFTABLES_PICKUP";
  var_0.placestring = &"COOP_CRAFTABLES_PLACE";
  var_0.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_0.placecancelablestring = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_0.lifespan = 30;
  var_0.placementheighttolerance = 30;
  var_0.placementradius = 24;
  var_0.carriedtrapoffset = (0, 0, 0);
  var_0.carriedtrapangles = (0, 0, 0);
  level.violetray_trap_settings["crafted_violetray"] = var_0;
}

give_crafted_violetray_trap(var_0, var_1) {
  var_1 thread watch_dpad();
  var_1 notify("new_power", "crafted_violetray");
  var_1 setclientomnvar("zom_crafted_weapon", 18);
  scripts\cp\utility::set_crafted_inventory_item("crafted_violetray", ::give_crafted_violetray_trap, var_1);
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

  thread give_violetray_trap("crafted_violetray");
}

give_violetray_trap(var_0) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_1 = create_violetray_trap_for_player(var_0, self);
  self.itemtype = var_1.name;
  scripts\cp\utility::remove_player_perks();
  self.carried_violetray_trap = var_1;
  var_1.firstplacement = 1;
  var_2 = set_carrying_violetray(var_1, 1);
  self.carried_violetray_trap = undefined;
  thread scripts\cp\utility::restore_player_perk();
  return var_2;
}

set_carrying_violetray(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 thread violetray_trap_setcarried(self);
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

      var_0 violetray_trap_setcancelled(var_3 == "force_cancel_placement" && !isDefined(var_0.firstplacement));
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

    var_0 thread violetray_trap_setplaced(var_2);
    self notify("IMS_placed");
    scripts\engine\utility::delaythread(0.5, ::scripts\engine\utility::allow_weapon, 1);
    return 1;
  }
}

create_violetray_trap_for_player(var_0, var_1) {
  if(isDefined(var_1.iscarrying) && var_1.iscarrying) {
    return;
  }

  var_2 = spawnturret("misc_turret", var_1.origin + (0, 0, 25), "sentry_minigun_mp");
  var_2.angles = var_1.angles;
  var_2.violetray_trap_type = var_0;
  var_2.triggerportableradarping = var_1;
  var_2.name = "crafted_violetray";
  var_2.carried_violetray_trap = spawn("script_model", var_2.origin);
  var_2.carried_violetray_trap.angles = var_1.angles;
  var_2 getvalidattachments();
  var_2 setturretmodechangewait(1);
  var_2 give_player_session_tokens("sentry_offline");
  var_2 makeunusable();
  var_2 setsentryowner(var_1);
  return var_2;
}

create_violetray_trap(var_0, var_1) {
  var_2 = var_0.triggerportableradarping;
  var_3 = var_0.violetray_trap_type;
  var_4 = spawn("script_model", var_0.origin + (0, 0, 2));
  var_4 setModel(level.violetray_trap_settings[var_3].modelbase);
  var_4.var_EB9C = 3;
  var_4.angles = (0, var_0.carried_violetray_trap.angles[1], 0);
  var_4.violetray_trap_type = var_3;
  var_4.triggerportableradarping = var_2;
  var_4 setotherent(var_2);
  var_4.team = var_2.team;
  var_4.name = "crafted_violetray";
  var_4.shouldsplash = 0;
  var_4.hidden = 0;
  var_4.var_252E = 1;
  var_4.var_8BF0 = [];
  var_4.config = level.violetray_trap_settings[var_3];
  var_4 thread violetray_trap_handleuse();
  if(isDefined(var_1)) {
    var_4 thread scripts\cp\utility::item_timeout(var_1);
  } else {
    var_4 thread scripts\cp\utility::item_timeout(undefined, level.violetray_trap_settings[self.violetray_trap_type].lifespan);
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

  violetray_trap_setinactive();
  if(isDefined(self.inuseby)) {
    self.inuseby scripts\cp\utility::restore_player_perk();
    self notify("deleting");
    wait(1);
  }

  func_66A7();
  self delete();
}

func_66A7() {
  self playSound("town_xray_explode_away");
  self playSound("town_xray_deactivate");
  playFX(level._effect["violet_light_explode"], self.origin);
}

violetray_trap_handleuse() {
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

    var_1 = create_violetray_trap_for_player(self.violetray_trap_type, var_0);
    if(!isDefined(var_1)) {
      continue;
    }

    violetray_trap_setinactive();
    if(isDefined(self getlinkedparent())) {
      self unlink();
    }

    var_0 thread set_carrying_violetray(var_1, 0, self.lifespan);
    self delete();
    break;
  }
}

violetray_trap_setplaced(var_0) {
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
  var_1 = create_violetray_trap(self, var_0);
  var_1.isplaced = 1;
  var_1 thread func_9367(self.triggerportableradarping);
  self playSound("trap_boom_box_drop");
  self playSound("town_xray_activate");
  self notify("placed");
  var_1 thread violetray_trap_setactive();
  var_2 = spawnStruct();
  if(isDefined(self.moving_platform)) {
    var_2.linkparent = self.moving_platform;
  }

  var_2.endonstring = "carried";
  var_2.deathoverridecallback = ::func_936D;
  var_1 thread scripts\cp\cp_movers::handle_moving_platforms(var_2);
  self.carried_violetray_trap delete();
  self delete();
}

violetray_trap_setcancelled(var_0) {
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

  self.carried_violetray_trap delete();
  self delete();
}

violetray_trap_setcarried(var_0) {
  self setsentrycarrier(var_0);
  self setcontents(0);
  self setCanDamage(0);
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  var_0 thread scripts\cp\utility::update_trap_placement_internal(self, self.carried_violetray_trap, level.violetray_trap_settings["crafted_violetray"]);
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
  violetray_trap_setcancelled();
}

func_9371(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("last_stand");
  level waittill("game_ended");
  violetray_trap_setcancelled();
}

violetray_trap_setactive() {
  self endon("death");
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.violetray_trap_settings[self.violetray_trap_type].pow);
  scripts\cp\utility::addtotraplist();
  var_0 = self.triggerportableradarping;
  var_0 getrigindexfromarchetyperef();
  scripts\cp\utility::setselfusable(var_0);
  self setusefov(120);
  self setuserange(96);
  self setscriptablepartstate("violetray", "on");
  thread violetray_trap_attack_zombies();
  thread scripts\cp\utility::item_handleownerdisconnect("violetray_disconnect");
}

violetray_trap_setinactive() {
  self makeunusable();
  self stoploopsound();
  self setscriptablepartstate("violetray", "off");
  if(isDefined(self.var_2536)) {
    self.var_2536 delete();
  }

  if(isDefined(self.var_69F6)) {
    self.var_69F6 delete();
    self.var_69F6 = undefined;
  }

  scripts\cp\utility::removefromtraplist();
}

violetray_trap_attack_zombies() {
  self endon("death");
  for(;;) {
    var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    foreach(var_2 in var_0) {
      if(!scripts\cp\utility::should_be_affected_by_trap(var_2, 0, 1)) {
        continue;
      }

      if(var_2.agent_type == "crab_mini" || var_2.agent_type == "crab_brute") {
        continue;
      }

      if(!bullettracepassed(self.origin + (0, 0, 40), var_2.origin + (0, 0, 40), 0, self)) {
        continue;
      }

      if(isDefined(var_2.desired_death_angles)) {
        continue;
      }

      if(distancesquared(self.origin, var_2.origin) > 75625) {
        continue;
      } else if(scripts\engine\utility::within_fov(self.origin + (0, 0, 40), self.angles, var_2.origin + (0, 0, 40), level.cosine["15"])) {
        var_3 = self.origin - var_2.origin;
        var_4 = vectortoangles(var_3);
        var_2.desired_death_angles = (0, var_4[1], 0);
        if(isDefined(self.triggerportableradarping)) {
          var_2.var_CF80 = self.triggerportableradarping;
        } else {
          var_2.var_CF80 = undefined;
        }

        var_2 scripts\asm\asm::asm_setstate("violetraydeath");
        thread scripts\engine\utility::play_sound_in_space("town_xray_burn_zombie", var_2.origin);
        wait(0.05);
        if(isDefined(self.triggerportableradarping)) {
          self.triggerportableradarping scripts\cp\cp_merits::processmerit("mt_dlc3_crafted_kills");
        }
      }
    }

    wait(0.05);
  }
}