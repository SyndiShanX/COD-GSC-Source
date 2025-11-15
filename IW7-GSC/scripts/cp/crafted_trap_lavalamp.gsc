/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\crafted_trap_lavalamp.gsc
************************************************/

init() {
  level.lavalamp_trap_settings = [];
  var_00 = spawnStruct();
  var_00.modelbase = "cp_disco_lava_lamp_bomb";
  var_00.modelplacement = "cp_disco_lava_lamp_bomb";
  var_00.modelplacementfailed = "cp_disco_lava_lamp_bomb_bad";
  var_00.pow = & "COOP_CRAFTABLES_PICKUP";
  var_00.placestring = & "COOP_CRAFTABLES_PLACE";
  var_00.cannotplacestring = & "COOP_CRAFTABLES_CANNOT_PLACE";
  var_00.placecancelablestring = & "COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_00.lifespan = 120;
  var_00.var_DDAC = 2;
  var_00._meth_8487 = 0.4;
  var_00.var_C228 = 12;
  var_00.placementheighttolerance = 30;
  var_00.placementradius = 16;
  var_00.carriedtrapoffset = (0, 0, 35);
  var_00.carriedtrapangles = (0, -90, 0);
  level.lavalamp_trap_settings["crafted_lavalamp"] = var_00;
}

give_crafted_lavalamp_trap(param_00, param_01) {
  param_01 thread watch_dpad();
  param_01 notify("new_power", "crafted_lavalamp");
  param_01 setclientomnvar("zom_crafted_weapon", 11);
  param_01 thread scripts\cp\utility::usegrenadegesture(param_01, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_lavalamp", ::give_crafted_lavalamp_trap, param_01);
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

give_lavalamp_trap(param_00) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_01 = create_lavalamp_trap_for_player(param_00, self);
  self.itemtype = var_01.name;
  scripts\cp\utility::remove_player_perks();
  self.carried_lavalamp_trap = var_01;
  var_01.firstplacement = 1;
  var_02 = func_F684(var_01, 1);
  self.carried_lavalamp_trap = undefined;
  thread scripts\cp\utility::restore_player_perk();
  return var_02;
}

func_F684(param_00, param_01, param_02) {
  self endon("disconnect");
  param_00 thread lavalamp_trap_setcarried(self);
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

      param_00 lavalamp_trap_setcancelled(var_03 == "force_cancel_placement" && !isDefined(param_00.firstplacement));
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

    param_00 thread lavalamp_trap_setplaced(param_02);
    self notify("IMS_placed");
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

create_lavalamp_trap_for_player(param_00, param_01) {
  if(isDefined(param_01.iscarrying) && param_01.iscarrying) {
    return;
  }

  var_02 = spawnturret("misc_turret", param_01.origin + (0, 0, 25), "sentry_minigun_mp");
  var_02.angles = param_01.angles;
  var_02.lavalamp_trap_type = param_00;
  var_02.triggerportableradarping = param_01;
  var_02.name = "crafted_lavalamp";
  var_02.carried_lavalamp_trap = spawn("script_model", var_02.origin);
  var_02.carried_lavalamp_trap.angles = param_01.angles;
  var_02 getvalidattachments();
  var_02 setturretmodechangewait(1);
  var_02 give_player_session_tokens("sentry_offline");
  var_02 makeunusable();
  var_02 setsentryowner(param_01);
  return var_02;
}

create_lavalamp_trap(param_00, param_01) {
  var_02 = param_00.triggerportableradarping;
  var_03 = param_00.lavalamp_trap_type;
  var_04 = spawn("script_model", param_00.origin + (0, 0, 1));
  var_04 setModel(level.lavalamp_trap_settings[var_03].modelbase);
  var_04.var_EB9C = 3;
  var_04.angles = param_00.angles + (0, -90, 0);
  var_04.lavalamp_trap_type = var_03;
  var_04.triggerportableradarping = var_02;
  var_04 setotherent(var_02);
  var_04.team = var_02.team;
  var_04.name = "crafted_lavalamp";
  var_04.shouldsplash = 0;
  var_04.hidden = 0;
  var_04.var_252E = 1;
  var_04.var_8BF0 = [];
  var_04.config = level.lavalamp_trap_settings[var_03];
  var_04 thread lavalamp_trap_handleuse();
  if(isDefined(param_01)) {
    var_04 thread scripts\cp\utility::item_timeout(param_01);
  } else {
    var_04 thread scripts\cp\utility::item_timeout(undefined, level.lavalamp_trap_settings[self.lavalamp_trap_type].lifespan);
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
    self waittill("trigger", var_00);
    if(!var_00 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_00.iscarrying)) {
      continue;
    }

    var_01 = create_lavalamp_trap_for_player(self.lavalamp_trap_type, var_00);
    if(!isDefined(var_01)) {
      continue;
    }

    lavalamp_trap_setinactive();
    if(isDefined(self getlinkedparent())) {
      self unlink();
    }

    var_00 thread func_F684(var_01, 0, self.lifespan);
    self delete();
    break;
  }
}

lavalamp_trap_setplaced(param_00) {
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
  var_01 = create_lavalamp_trap(self, param_00);
  var_01.isplaced = 1;
  var_01 thread func_9367(self.triggerportableradarping);
  self notify("placed");
  var_01 thread lavalamp_trap_setactive();
  var_02 = spawnStruct();
  if(isDefined(self.moving_platform)) {
    var_02.linkparent = self.moving_platform;
  }

  var_02.endonstring = "carried";
  var_02.deathoverridecallback = ::func_936D;
  var_01 thread scripts\cp\cp_movers::handle_moving_platforms(var_02);
  self.carried_lavalamp_trap delete();
  self delete();
}

lavalamp_trap_setcancelled(param_00) {
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

  self.carried_lavalamp_trap delete();
  self delete();
}

lavalamp_trap_setcarried(param_00) {
  self setsentrycarrier(param_00);
  self setcontents(0);
  self setCanDamage(0);
  self.carriedby = param_00;
  param_00.iscarrying = 1;
  param_00 thread scripts\cp\utility::update_trap_placement_internal(self, self.carried_lavalamp_trap, level.lavalamp_trap_settings["crafted_lavalamp"]);
  thread scripts\cp\utility::item_oncarrierdeath(param_00);
  thread func_936F(param_00);
  thread func_9371(param_00);
  self notify("carried");
}

func_936F(param_00) {
  self endon("placed");
  self endon("death");
  param_00 endon("last_stand");
  param_00 waittill("disconnect");
  lavalamp_trap_setcancelled();
}

func_9371(param_00) {
  self endon("placed");
  self endon("death");
  param_00 endon("last_stand");
  level waittill("game_ended");
  lavalamp_trap_setcancelled();
}

lavalamp_trap_setactive() {
  self endon("death");
  self setcursorhint("HINT_NOICON");
  self makeunusable();
  scripts\cp\utility::addtotraplist();
  var_00 = self.triggerportableradarping;
  var_00 getrigindexfromarchetyperef();
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

    self.var_2536 waittill("trigger", var_00);
    if(isplayer(var_00) && isalive(var_00) && !scripts\cp\cp_laststand::player_in_laststand(var_00) && !isDefined(var_00.padding_damage)) {
      var_00.padding_damage = 1;
      var_00 dodamage(20, var_00.origin);
      var_00 thread remove_padding_damage();
      continue;
    }

    if(!scripts\cp\utility::should_be_affected_by_trap(var_00, 0, 1)) {
      continue;
    }

    if(!isDefined(self.triggerportableradarping)) {
      break;
    }

    if(isDefined(var_00.pet) || isDefined(var_00.team) && var_00.team == "allies") {
      continue;
    }

    if(isDefined(var_00.marked_for_death)) {
      continue;
    }

    var_00.marked_for_death = 1;
    var_00.dontmutilate = 1;
    var_00 thread scripts\cp\utility::damage_over_time(var_00, self, 3, int(var_00.health + 1000), "MOD_EXPLOSIVE", "incendiary_ammo_mp", undefined, "burning");
  }

  if(isDefined(self.carriedby) && isDefined(self.triggerportableradarping) && self.carriedby == self.triggerportableradarping) {
    return;
  }

  self notify("death");
}

remove_padding_damage() {
  self endon("disconnect");
  wait(0.5);
  self.padding_damage = undefined;
}