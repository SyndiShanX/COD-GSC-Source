/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2675.gsc
***************************************/

init() {
  level.func_6DA3 = [];
  var_00 = spawnStruct();
  var_0.weaponinfo = "zmb_fireworksprojectile_mp";
  var_0.modelbase = "park_fireworks_trap";
  var_0.modelplacement = "park_fireworks_trap_good";
  var_0.modelplacementfailed = "park_fireworks_trap_bad";
  var_0.hintstring = &"COOP_CRAFTABLES_PICKUP";
  var_0.placestring = &"COOP_CRAFTABLES_PLACE";
  var_0.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_0.placecancelablestring = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_0.lifespan = 120.0;
  var_0.func_DDAC = 2;
  var_0._meth_8487 = 0.4;
  var_0.func_C228 = 12;
  var_0.func_6A03 = "park_fireworks_trap_rocket";
  var_0.placementheighttolerance = 30.0;
  var_0.placementradius = 16.0;
  var_0.carriedtrapoffset = (0, 0, 35);
  var_0.carriedtrapangles = (0, 0, 0);
  level.func_6DA3["crafted_ims"] = var_00;
}

give_crafted_fireworks_trap(var_00, var_01) {
  var_01 thread watch_dpad();
  var_01 notify("new_power", "crafted_ims");
  var_01 setclientomnvar("zom_crafted_weapon", 2);
  var_01 thread scripts\cp\utility::usegrenadegesture(var_01, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_ims", ::give_crafted_fireworks_trap, var_01);
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

  thread _meth_82CA("crafted_ims");
}

_meth_82CA(var_00) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_01 = func_48EB(var_00, self);
  self.itemtype = var_1.name;
  scripts\cp\utility::remove_player_perks();
  self.carried_fireworks_trap = var_01;
  var_1.firstplacement = 1;
  var_02 = func_F684(var_01, 1);
  self.carried_fireworks_trap = undefined;
  thread scripts\cp\utility::restore_player_perk();
  return var_02;
}

func_F684(var_00, var_01, var_02) {
  self endon("disconnect");
  var_00 thread func_6DA0(self);
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
      if(!var_01 && var_03 == "cancel_ims") {
        continue;
      }
      var_00 func_6D9F(var_03 == "force_cancel_placement" && !isDefined(var_0.firstplacement));

      if(var_03 != "force_cancel_placement") {
        thread watch_dpad();
      }
      else if(var_01) {
        scripts\cp\utility::remove_crafted_item_from_inventory(self);
      }

      return 0;
    }

    if(!var_0.canbeplaced) {
      continue;
    }
    if(var_01) {
      scripts\cp\utility::remove_crafted_item_from_inventory(self);
    }

    var_00 thread func_6DA2(var_02);
    self notify("IMS_placed");
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

func_48EB(var_00, var_01) {
  if(isDefined(var_1.iscarrying) && var_1.iscarrying) {
    return;
  }
  var_02 = spawnturret("misc_turret", var_1.origin + (0, 0, 25), "sentry_minigun_mp");
  var_2.angles = var_1.angles;
  var_2.func_6DA4 = var_00;
  var_2.owner = var_01;
  var_2.name = "crafted_ims";
  var_2.carried_fireworks_trap = spawn("script_model", var_2.origin);
  var_2.carried_fireworks_trap.angles = var_1.angles;
  var_02 maketurretinoperable();
  var_02 setturretmodechangewait(1);
  var_02 give_player_session_tokens("sentry_offline");
  var_02 makeunusable();
  var_02 setsentryowner(var_01);
  return var_02;
}

func_48EA(var_00, var_01) {
  var_02 = var_0.owner;
  var_03 = var_0.func_6DA4;
  var_04 = spawn("script_model", var_0.origin + (0, 0, 1));
  var_04 setModel(level.func_6DA3[var_03].modelbase);
  var_4.func_EB9C = 3;
  var_4.angles = var_0.angles;
  var_4.func_6DA4 = var_03;
  var_4.owner = var_02;
  var_04 setotherent(var_02);
  var_4.team = var_2.team;
  var_4.name = "crafted_ims";
  var_4.shouldsplash = 0;
  var_4.hidden = 0;
  var_4.func_252E = 1;
  var_4.func_8BF0 = [];
  var_4.config = level.func_6DA3[var_03];
  var_04 thread func_6D9D();

  if(isDefined(var_01)) {
    var_04 thread scripts\cp\utility::item_timeout(var_01);
  }
  else {
    var_04 thread scripts\cp\utility::item_timeout(undefined, level.func_6DA3[self.func_6DA4].lifespan);
  }

  return var_04;
}

func_936D(var_00) {
  self.func_933C = 1;
  self notify("death");
}

func_9367(var_00) {
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
    self waittill("trigger", var_00);

    if(!var_00 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(scripts\engine\utility::is_true(var_0.iscarrying)) {
      continue;
    }
    var_01 = func_48EB(self.func_6DA4, var_00);

    if(!isDefined(var_01)) {
      continue;
    }
    func_6DA1();

    if(isDefined(self getlinkedparent())) {
      self unlink();
    }

    var_00 thread func_F684(var_01, 0, self.lifespan);
    self delete();
    break;
  }
}

func_6DA2(var_00) {
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
  var_01 = func_48EA(self, var_00);
  var_1.isplaced = 1;
  var_01 thread func_9367(self.owner);
  self playSound("ims_plant");
  self notify("placed");
  var_01 thread func_6D9E();
  var_02 = spawnStruct();

  if(isDefined(self.moving_platform)) {
    var_2.linkparent = self.moving_platform;
  }

  var_2.endonstring = "carried";
  var_2.deathoverridecallback = ::func_936D;
  var_01 thread scripts\cp\cp_movers::handle_moving_platforms(var_02);
  self.carried_fireworks_trap delete();
  self delete();
}

func_6D9F(var_00) {
  if(isDefined(self.carriedby)) {
    var_01 = self.carriedby;
    var_01 getrigindexfromarchetyperef();
    var_1.iscarrying = undefined;
    var_1.carrieditem = undefined;
    var_01 scripts\engine\utility::allow_weapon(1);
  }

  if(isDefined(var_00) && var_00) {
    func_66A7();
  }

  self.carried_fireworks_trap delete();
  self delete();
}

func_6DA0(var_00) {
  self setsentrycarrier(var_00);
  self setcontents(0);
  self setCanDamage(0);
  self.carriedby = var_00;
  var_0.iscarrying = 1;
  var_00 thread scripts\cp\utility::update_trap_placement_internal(self, self.carried_fireworks_trap, level.func_6DA3["crafted_ims"]);
  thread scripts\cp\utility::item_oncarrierdeath(var_00);
  thread func_936F(var_00);
  thread func_9371(var_00);

  if(isDefined(level.func_5CF2)) {
    self thread[[level.func_5CF2]](var_00);
  }

  self notify("carried");
}

func_936F(var_00) {
  self endon("placed");
  self endon("death");
  var_00 endon("last_stand");
  var_00 waittill("disconnect");
  func_6D9F();
}

func_9371(var_00) {
  self endon("placed");
  self endon("death");
  var_00 endon("last_stand");
  level waittill("game_ended");
  func_6D9F();
}

func_6D9E() {
  self endon("death");
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.func_6DA3[self.func_6DA4].hintstring);
  scripts\cp\utility::addtotraplist();
  var_00 = self.owner;
  var_00 getrigindexfromarchetyperef();
  self makeusable();
  self setusefov(120);
  self setuserange(96);
  wait 0.05;
  var_01 = (0, 0, 27);
  var_02 = (0, 0, 500) - var_01;
  var_03 = self.origin;
  var_04 = self.origin + var_01;
  var_05 = bulletTrace(var_04, var_04 + var_02, 0, self);
  var_06 = var_05;
  self.func_2514 = var_6["position"] - (0, 0, 20) - self.origin;

  if(self.func_2514[2] < 250) {
    self.func_AA7B = "launch_low";
  }
  else if(self.func_2514[2] < 450) {
    self.func_AA7B = "launch_med";
  }
  else {
    self.func_AA7B = "launch_high";
  }

  var_07 = spawn("trigger_radius", self.origin, 0, 256, 100);
  self.func_2536 = var_07;
  self.func_2536 getrankxp();
  self.func_2536 linkto(self);
  self.func_2528 = length(self.func_2514) / 400;
  wait 0.75;
  self setscriptablepartstate("base", "on");
  thread func_6D9C();
  thread scripts\cp\utility::item_handleownerdisconnect("fireworks_disconnect");
}

func_6DA1() {
  self makeunusable();

  if(isDefined(self.func_2536)) {
    self.func_2536 delete();
  }

  if(isDefined(self.func_69F6)) {
    self.func_69F6 delete();
    self.func_69F6 = undefined;
  }

  scripts\cp\utility::removefromtraplist();
}

func_6D9C() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self.func_2536)) {
      break;
    }
    self.func_2536 waittill("trigger", var_00);

    if(isplayer(var_00) || isDefined(var_0.pet) || isDefined(var_0.agent_type) && var_0.agent_type == "the_hoff") {
      continue;
    }
    var_01 = var_0.origin + (0, 0, 50);

    if(!sighttracepassed(self.func_2514 + self.origin, var_01, 0, self)) {
      continue;
    }
    if(!isDefined(self.func_2536)) {
      break;
    }
    if(!isDefined(self.func_8BF0[self.func_252E])) {
      self.func_8BF0[self.func_252E] = 1;
      thread func_AA75(var_00, self.func_252E);
      self.func_252E++;
    }

    if(self.func_252E > self.config.func_C228) {
      self setscriptablepartstate("firework", "off");
      break;
    }

    self waittill("firework_exploded");
    self setscriptablepartstate("firework", "off");
    wait(self.config.func_DDAC);

    if(!isDefined(self.owner)) {
      break;
    }
  }

  if(isDefined(self.carriedby) && isDefined(self.owner) && self.carriedby == self.owner) {
    return;
  }
  self notify("death");
}

func_AA75(var_00, var_01) {
  self setscriptablepartstate("firework", self.func_AA7B);
  var_02 = spawn("script_model", self.origin);
  var_02 setModel(self.config.func_6A03);
  var_2.angles = self.angles;
  var_02 setscriptablepartstate("rocket", "launch");
  var_03 = self.config.weaponinfo;
  var_04 = self.owner;
  var_02 moveto(self.func_2514 + self.origin, self.func_2528, self.func_2528 * 0.5, 0);
  var_02 waittill("movedone");
  var_02 setscriptablepartstate("rocket", "explode");
  wait 0.1;

  if(isDefined(var_04)) {
    magicbullet(var_03, var_2.origin, var_0.origin, var_04);
  }
  else {
    magicbullet(var_03, var_2.origin, var_0.origin, level.players[0]);
  }

  var_02 delete();
  self notify("firework_exploded");
}