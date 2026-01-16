/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\crafted_trap_lavalamp.gsc
************************************************/

init() {
  level.lavalamp_trap_settings = [];
  var_0 = spawnStruct();
  var_0.modelbase = "cp_disco_lava_lamp_bomb";
  var_0.modelplacement = "cp_disco_lava_lamp_bomb";
  var_0.modelplacementfailed = "cp_disco_lava_lamp_bomb_bad";
  var_0.hintstring = &"COOP_CRAFTABLES_PICKUP";
  var_0.placestring = &"COOP_CRAFTABLES_PLACE";
  var_0.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_0.placecancelablestring = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_0.lifespan = 120;
  var_0.var_DDAC = 2;
  var_0.func_8487 = 0.4;
  var_0.var_C228 = 12;
  var_0.placementheighttolerance = 30;
  var_0.placementradius = 16;
  var_0.carriedtrapoffset = (0, 0, 35);
  var_0.carriedtrapangles = (0, -90, 0);
  level.lavalamp_trap_settings["crafted_lavalamp"] = var_0;
}

give_crafted_lavalamp_trap(var_0, var_1) {
  var_1 thread watch_dpad();
  var_1 notify("new_power", "crafted_lavalamp");
  var_1 setclientomnvar("zom_crafted_weapon", 11);
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_lavalamp", ::give_crafted_lavalamp_trap, var_1);
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

  thread give_lavalamp_trap("crafted_lavalamp");
}

give_lavalamp_trap(var_0) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_1 = create_lavalamp_trap_for_player(var_0, self);
  self.itemtype = var_1.name;
  scripts\cp\utility::remove_player_perks();
  self.carried_lavalamp_trap = var_1;
  var_1.firstplacement = 1;
  var_2 = func_F684(var_1, 1);
  self.carried_lavalamp_trap = undefined;
  thread scripts\cp\utility::restore_player_perk();
  return var_2;
}

func_F684(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 thread lavalamp_trap_setcarried(self);
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

      var_0 lavalamp_trap_setcancelled(var_3 == "force_cancel_placement" && !isDefined(var_0.firstplacement));
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

    var_0 thread lavalamp_trap_setplaced(var_2);
    self notify("IMS_placed");
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

create_lavalamp_trap_for_player(var_0, var_1) {
  if(isDefined(var_1.iscarrying) && var_1.iscarrying) {
    return;
  }

  var_2 = spawnturret("misc_turret", var_1.origin + (0, 0, 25), "sentry_minigun_mp");
  var_2.angles = var_1.angles;
  var_2.lavalamp_trap_type = var_0;
  var_2.owner = var_1;
  var_2.name = "crafted_lavalamp";
  var_2.carried_lavalamp_trap = spawn("script_model", var_2.origin);
  var_2.carried_lavalamp_trap.angles = var_1.angles;
  var_2 getvalidattachments();
  var_2 setturretmodechangewait(1);
  var_2 give_player_session_tokens("sentry_offline");
  var_2 makeunusable();
  var_2 setsentryowner(var_1);
  return var_2;
}

create_lavalamp_trap(var_0, var_1) {
  var_2 = var_0.owner;
  var_3 = var_0.lavalamp_trap_type;
  var_4 = spawn("script_model", var_0.origin + (0, 0, 1));
  var_4 setModel(level.lavalamp_trap_settings[var_3].modelbase);
  var_4.var_EB9C = 3;
  var_4.angles = var_0.angles + (0, -90, 0);
  var_4.lavalamp_trap_type = var_3;
  var_4.owner = var_2;
  var_4 setotherent(var_2);
  var_4.team = var_2.team;
  var_4.name = "crafted_lavalamp";
  var_4.shouldsplash = 0;
  var_4.hidden = 0;
  var_4.var_252E = 1;
  var_4.var_8BF0 = [];
  var_4.config = level.lavalamp_trap_settings[var_3];
  var_4 thread lavalamp_trap_handleuse();
  if(isDefined(var_1)) {
    var_4 thread scripts\cp\utility::item_timeout(var_1);
  } else {
    var_4 thread scripts\cp\utility::item_timeout(undefined, level.lavalamp_trap_settings[self.lavalamp_trap_type].lifespan);
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

  lavalamp_trap_setinactive();
  if(isDefined(self.inuseby)) {
    self.inuseby scripts\cp\utility::restore_player_perk();
    self notify("deleting");
    wait(1);
  }

  func_66A7();
  self delete();
}

func_66A7() {
  self setscriptablepartstate("base", "explode");
  wait(0.5);
  radiusdamage(self.origin + (0, 0, 40), 200, 500, 250, self, "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
  wait(0.65);
}

lavalamp_trap_handleuse() {
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

    var_1 = create_lavalamp_trap_for_player(self.lavalamp_trap_type, var_0);
    if(!isDefined(var_1)) {
      continue;
    }

    lavalamp_trap_setinactive();
    if(isDefined(self getlinkedparent())) {
      self unlink();
    }

    var_0 thread func_F684(var_1, 0, self.lifespan);
    self delete();
    break;
  }
}

lavalamp_trap_setplaced(var_0) {
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
  var_1 = create_lavalamp_trap(self, var_0);
  var_1.isplaced = 1;
  var_1 thread func_9367(self.owner);
  self notify("placed");
  var_1 thread lavalamp_trap_setactive();
  var_2 = spawnStruct();
  if(isDefined(self.moving_platform)) {
    var_2.linkparent = self.moving_platform;
  }

  var_2.endonstring = "carried";
  var_2.deathoverridecallback = ::func_936D;
  var_1 thread scripts\cp\cp_movers::handle_moving_platforms(var_2);
  self.carried_lavalamp_trap delete();
  self delete();
}

lavalamp_trap_setcancelled(var_0) {
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

  self.carried_lavalamp_trap delete();
  self delete();
}

lavalamp_trap_setcarried(var_0) {
  self setsentrycarrier(var_0);
  self setcontents(0);
  self setCanDamage(0);
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  var_0 thread scripts\cp\utility::update_trap_placement_internal(self, self.carried_lavalamp_trap, level.lavalamp_trap_settings["crafted_lavalamp"]);
  thread scripts\cp\utility::item_oncarrierdeath(var_0);
  thread func_936F(var_0);
  thread func_9371(var_0);
  self notify("carried");
}

func_936F(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("last_stand");
  var_0 waittill("disconnect");
  lavalamp_trap_setcancelled();
}

func_9371(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("last_stand");
  level waittill("game_ended");
  lavalamp_trap_setcancelled();
}

lavalamp_trap_setactive() {
  self endon("death");
  self setcursorhint("HINT_NOICON");
  self makeunusable();
  scripts\cp\utility::addtotraplist();
  var_0 = self.owner;
  var_0 getrigindexfromarchetyperef();
  self.var_2536 = spawn("trigger_radius", self.origin, 0, 96, 96);
  thread scripts\cp\utility::item_handleownerdisconnect("fireworks_disconnect");
  earthquake(0.25, 5, self.origin, 128);
  self playSound("trap_lavalamp_place_tick");
  wait(3);
  self setModel("tag_origin_lavalamp");
  thread lavalamp_trap_attackzombies();
  wait(25);
  self playSound("trap_lavalamp_ground_bubble_end");
  wait(0.35);
  self stoploopsound();
  wait(1.65);
  self delete();
}

lavalamp_trap_setinactive() {
  self makeunusable();
  if(isDefined(self.var_2536)) {
    self.var_2536 delete();
  }

  if(isDefined(self.var_69F6)) {
    self.var_69F6 delete();
    self.var_69F6 = undefined;
  }

  scripts\cp\utility::removefromtraplist();
}

lavalamp_trap_attackzombies() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    if(!isDefined(self.var_2536)) {
      break;
    }

    self.var_2536 waittill("trigger", var_0);
    if(isplayer(var_0) && isalive(var_0) && !scripts\cp\cp_laststand::player_in_laststand(var_0) && !isDefined(var_0.padding_damage)) {
      var_0.padding_damage = 1;
      var_0 dodamage(20, var_0.origin);
      var_0 thread remove_padding_damage();
      continue;
    }

    if(!scripts\cp\utility::should_be_affected_by_trap(var_0, 0, 1)) {
      continue;
    }

    if(!isDefined(self.owner)) {
      break;
    }

    if(isDefined(var_0.pet) || isDefined(var_0.team) && var_0.team == "allies") {
      continue;
    }

    if(isDefined(var_0.marked_for_death)) {
      continue;
    }

    var_0.marked_for_death = 1;
    var_0.dontmutilate = 1;
    var_0 thread scripts\cp\utility::damage_over_time(var_0, self, 3, int(var_0.health + 1000), "MOD_EXPLOSIVE", "incendiary_ammo_mp", undefined, "burning");
  }

  if(isDefined(self.carriedby) && isDefined(self.owner) && self.carriedby == self.owner) {
    return;
  }

  self notify("death");
}

remove_padding_damage() {
  self endon("disconnect");
  wait(0.5);
  self.padding_damage = undefined;
}