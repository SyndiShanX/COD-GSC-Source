/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2675.gsc
**************************************/

init() {
  level.var_6DA3 = [];
  var_0 = spawnStruct();
  var_0.weaponinfo = "zmb_fireworksprojectile_mp";
  var_0.modelbase = "park_fireworks_trap";
  var_0.modelplacement = "park_fireworks_trap_good";
  var_0.modelplacementfailed = "park_fireworks_trap_bad";
  var_0.hintstring = &"COOP_CRAFTABLES_PICKUP";
  var_0.placestring = &"COOP_CRAFTABLES_PLACE";
  var_0.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_0.placecancelablestring = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_0.lifespan = 120.0;
  var_0.var_DDAC = 2;
  var_0.func_8487 = 0.4;
  var_0.var_C228 = 12;
  var_0.var_6A03 = "park_fireworks_trap_rocket";
  var_0.placementheighttolerance = 30.0;
  var_0.placementradius = 16.0;
  var_0.carriedtrapoffset = (0, 0, 35);
  var_0.carriedtrapangles = (0, 0, 0);
  level.var_6DA3["crafted_ims"] = var_0;
}

give_crafted_fireworks_trap(var_0, var_1) {
  var_1 thread watch_dpad();
  var_1 notify("new_power", "crafted_ims");
  var_1 setclientomnvar("zom_crafted_weapon", 2);
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_ims", ::give_crafted_fireworks_trap, var_1);
}

watch_dpad() {
  self endon("death");
  self endon("disconnect");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_ims", "+actionslot 3");

  for(;;) {
    self waittill("pullout_ims");

    if(scripts\engine\utility::is_true(self.iscarrying)) {
      continue;
    }
    if(scripts\engine\utility::is_true(self.linked_to_coaster)) {
      continue;
    }
    if(isDefined(self.allow_carry) && self.allow_carry == 0) {
      continue;
    }
    if(scripts\cp\utility::is_valid_player()) {
      break;
    }
  }

  thread func_82CA("crafted_ims");
}

func_82CA(var_0) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_1 = func_48EB(var_0, self);
  self.itemtype = var_1.name;
  scripts\cp\utility::remove_player_perks();
  self.carried_fireworks_trap = var_1;
  var_1.firstplacement = 1;
  var_2 = func_F684(var_1, 1);
  self.carried_fireworks_trap = undefined;
  thread scripts\cp\utility::restore_player_perk();
  return var_2;
}

func_F684(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 thread func_6DA0(self);
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
      var_0 func_6D9F(var_3 == "force_cancel_placement" && !isDefined(var_0.firstplacement));

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

    var_0 thread func_6DA2(var_2);
    self notify("IMS_placed");
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

func_48EB(var_0, var_1) {
  if(isDefined(var_1.iscarrying) && var_1.iscarrying) {
    return;
  }
  var_2 = spawnturret("misc_turret", var_1.origin + (0, 0, 25), "sentry_minigun_mp");
  var_2.angles = var_1.angles;
  var_2.var_6DA4 = var_0;
  var_2.owner = var_1;
  var_2.name = "crafted_ims";
  var_2.carried_fireworks_trap = spawn("script_model", var_2.origin);
  var_2.carried_fireworks_trap.angles = var_1.angles;
  var_2 maketurretinoperable();
  var_2 setturretmodechangewait(1);
  var_2 give_player_session_tokens("sentry_offline");
  var_2 makeunusable();
  var_2 setsentryowner(var_1);
  return var_2;
}

func_48EA(var_0, var_1) {
  var_2 = var_0.owner;
  var_3 = var_0.var_6DA4;
  var_4 = spawn("script_model", var_0.origin + (0, 0, 1));
  var_4 setModel(level.var_6DA3[var_3].modelbase);
  var_4.var_EB9C = 3;
  var_4.angles = var_0.angles;
  var_4.var_6DA4 = var_3;
  var_4.owner = var_2;
  var_4 setotherent(var_2);
  var_4.team = var_2.team;
  var_4.name = "crafted_ims";
  var_4.shouldsplash = 0;
  var_4.hidden = 0;
  var_4.var_252E = 1;
  var_4.var_8BF0 = [];
  var_4.config = level.var_6DA3[var_3];
  var_4 thread func_6D9D();

  if(isDefined(var_1)) {
    var_4 thread scripts\cp\utility::item_timeout(var_1);
  } else {
    var_4 thread scripts\cp\utility::item_timeout(undefined, level.var_6DA3[self.var_6DA4].lifespan);
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
  func_6DA1();

  if(isDefined(self.inuseby)) {
    self.inuseby scripts\cp\utility::restore_player_perk();
    self notify("deleting");
    wait 1.0;
  }

  func_66A7();
  self delete();
}

func_66A7() {
  self setscriptablepartstate("base", "explode");
  wait 0.5;
  radiusdamage(self.origin + (0, 0, 40), 200, 500, 250, self, "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
  wait 0.65;
}

func_6D9D() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(scripts\engine\utility::is_true(var_0.iscarrying)) {
      continue;
    }
    var_1 = func_48EB(self.var_6DA4, var_0);

    if(!isDefined(var_1)) {
      continue;
    }
    func_6DA1();

    if(isDefined(self getlinkedparent())) {
      self unlink();
    }

    var_0 thread func_F684(var_1, 0, self.lifespan);
    self delete();
    break;
  }
}

func_6DA2(var_0) {
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
  var_1 = func_48EA(self, var_0);
  var_1.isplaced = 1;
  var_1 thread func_9367(self.owner);
  self playSound("ims_plant");
  self notify("placed");
  var_1 thread func_6D9E();
  var_2 = spawnStruct();

  if(isDefined(self.moving_platform)) {
    var_2.linkparent = self.moving_platform;
  }

  var_2.endonstring = "carried";
  var_2.deathoverridecallback = ::func_936D;
  var_1 thread scripts\cp\cp_movers::handle_moving_platforms(var_2);
  self.carried_fireworks_trap delete();
  self delete();
}

func_6D9F(var_0) {
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

  self.carried_fireworks_trap delete();
  self delete();
}

func_6DA0(var_0) {
  self setsentrycarrier(var_0);
  self setcontents(0);
  self setCanDamage(0);
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  var_0 thread scripts\cp\utility::update_trap_placement_internal(self, self.carried_fireworks_trap, level.var_6DA3["crafted_ims"]);
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
  func_6D9F();
}

func_9371(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("last_stand");
  level waittill("game_ended");
  func_6D9F();
}

func_6D9E() {
  self endon("death");
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.var_6DA3[self.var_6DA4].hintstring);
  scripts\cp\utility::addtotraplist();
  var_0 = self.owner;
  var_0 getrigindexfromarchetyperef();
  self makeusable();
  self setusefov(120);
  self setuserange(96);
  wait 0.05;
  var_1 = (0, 0, 27);
  var_2 = (0, 0, 500) - var_1;
  var_3 = self.origin;
  var_4 = self.origin + var_1;
  var_5 = bulletTrace(var_4, var_4 + var_2, 0, self);
  var_6 = var_5;
  self.var_2514 = var_6["position"] - (0, 0, 20) - self.origin;

  if(self.var_2514[2] < 250) {
    self.var_AA7B = "launch_low";
  } else if(self.var_2514[2] < 450) {
    self.var_AA7B = "launch_med";
  } else {
    self.var_AA7B = "launch_high";
  }

  var_7 = spawn("trigger_radius", self.origin, 0, 256, 100);
  self.var_2536 = var_7;
  self.var_2536 getrankxp();
  self.var_2536 linkto(self);
  self.var_2528 = length(self.var_2514) / 400;
  wait 0.75;
  self setscriptablepartstate("base", "on");
  thread func_6D9C();
  thread scripts\cp\utility::item_handleownerdisconnect("fireworks_disconnect");
}

func_6DA1() {
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

func_6D9C() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self.var_2536)) {
      break;
    }
    self.var_2536 waittill("trigger", var_0);

    if(isPlayer(var_0) || isDefined(var_0.pet) || isDefined(var_0.agent_type) && var_0.agent_type == "the_hoff") {
      continue;
    }
    var_1 = var_0.origin + (0, 0, 50);

    if(!sighttracepassed(self.var_2514 + self.origin, var_1, 0, self)) {
      continue;
    }
    if(!isDefined(self.var_2536)) {
      break;
    }
    if(!isDefined(self.var_8BF0[self.var_252E])) {
      self.var_8BF0[self.var_252E] = 1;
      thread func_AA75(var_0, self.var_252E);
      self.var_252E++;
    }

    if(self.var_252E > self.config.var_C228) {
      self setscriptablepartstate("firework", "off");
      break;
    }

    self waittill("firework_exploded");
    self setscriptablepartstate("firework", "off");
    wait(self.config.var_DDAC);

    if(!isDefined(self.owner)) {
      break;
    }
  }

  if(isDefined(self.carriedby) && isDefined(self.owner) && self.carriedby == self.owner) {
    return;
  }
  self notify("death");
}

func_AA75(var_0, var_1) {
  self setscriptablepartstate("firework", self.var_AA7B);
  var_2 = spawn("script_model", self.origin);
  var_2 setModel(self.config.var_6A03);
  var_2.angles = self.angles;
  var_2 setscriptablepartstate("rocket", "launch");
  var_3 = self.config.weaponinfo;
  var_4 = self.owner;
  var_2 moveto(self.var_2514 + self.origin, self.var_2528, self.var_2528 * 0.5, 0);
  var_2 waittill("movedone");
  var_2 setscriptablepartstate("rocket", "explode");
  wait 0.1;

  if(isDefined(var_4)) {
    magicbullet(var_3, var_2.origin, var_0.origin, var_4);
  } else {
    magicbullet(var_3, var_2.origin, var_0.origin, level.players[0]);
  }

  var_2 delete();
  self notify("firework_exploded");
}