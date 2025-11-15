/*************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\craftables\_fireworks_trap.gsc
*************************************************************/

init() {
  level.var_6DA3 = [];
  var_00 = spawnStruct();
  var_00.var_39B = "zmb_fireworksprojectile_mp";
  var_00.modelbase = "park_fireworks_trap";
  var_00.modelplacement = "park_fireworks_trap_good";
  var_00.modelplacementfailed = "park_fireworks_trap_bad";
  var_00.pow = & "COOP_CRAFTABLES_PICKUP";
  var_00.placestring = & "COOP_CRAFTABLES_PLACE";
  var_00.cannotplacestring = & "COOP_CRAFTABLES_CANNOT_PLACE";
  var_00.placecancelablestring = & "COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_00.lifespan = 120;
  var_00.var_DDAC = 2;
  var_00._meth_8487 = 0.4;
  var_00.var_C228 = 12;
  var_00.var_6A03 = "park_fireworks_trap_rocket";
  var_00.placementheighttolerance = 30;
  var_00.placementradius = 16;
  var_00.carriedtrapoffset = (0, 0, 35);
  var_00.carriedtrapangles = (0, 0, 0);
  level.var_6DA3["crafted_ims"] = var_00;
}

give_crafted_fireworks_trap(param_00, param_01) {
  param_01 thread watch_dpad();
  param_01 notify("new_power", "crafted_ims");
  param_01 setclientomnvar("zom_crafted_weapon", 2);
  param_01 thread scripts\cp\utility::usegrenadegesture(param_01, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_ims", ::give_crafted_fireworks_trap, param_01);
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

  thread _meth_82CA("crafted_ims");
}

_meth_82CA(param_00) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_01 = func_48EB(param_00, self);
  self.itemtype = var_01.name;
  scripts\cp\utility::remove_player_perks();
  self.carried_fireworks_trap = var_01;
  var_01.firstplacement = 1;
  var_02 = func_F684(var_01, 1);
  self.carried_fireworks_trap = undefined;
  thread scripts\cp\utility::restore_player_perk();
  return var_02;
}

func_F684(param_00, param_01, param_02) {
  self endon("disconnect");
  param_00 thread func_6DA0(self);
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

      param_00 func_6D9F(var_03 == "force_cancel_placement" && !isDefined(param_00.firstplacement));
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

    param_00 thread func_6DA2(param_02);
    self notify("IMS_placed");
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

func_48EB(param_00, param_01) {
  if(isDefined(param_01.iscarrying) && param_01.iscarrying) {
    return;
  }

  var_02 = spawnturret("misc_turret", param_01.origin + (0, 0, 25), "sentry_minigun_mp");
  var_02.angles = param_01.angles;
  var_02.var_6DA4 = param_00;
  var_02.triggerportableradarping = param_01;
  var_02.name = "crafted_ims";
  var_02.carried_fireworks_trap = spawn("script_model", var_02.origin);
  var_02.carried_fireworks_trap.angles = param_01.angles;
  var_02 getvalidattachments();
  var_02 setturretmodechangewait(1);
  var_02 give_player_session_tokens("sentry_offline");
  var_02 makeunusable();
  var_02 setsentryowner(param_01);
  return var_02;
}

func_48EA(param_00, param_01) {
  var_02 = param_00.triggerportableradarping;
  var_03 = param_00.var_6DA4;
  var_04 = spawn("script_model", param_00.origin + (0, 0, 1));
  var_04 setModel(level.var_6DA3[var_03].modelbase);
  var_04.var_EB9C = 3;
  var_04.angles = param_00.angles;
  var_04.var_6DA4 = var_03;
  var_04.triggerportableradarping = var_02;
  var_04 setotherent(var_02);
  var_04.team = var_02.team;
  var_04.name = "crafted_ims";
  var_04.shouldsplash = 0;
  var_04.hidden = 0;
  var_04.var_252E = 1;
  var_04.var_8BF0 = [];
  var_04.config = level.var_6DA3[var_03];
  var_04 thread func_6D9D();
  if(isDefined(param_01)) {
    var_04 thread scripts\cp\utility::item_timeout(param_01);
  } else {
    var_04 thread scripts\cp\utility::item_timeout(undefined, level.var_6DA3[self.var_6DA4].lifespan);
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

  func_6DA1();
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

func_6D9D() {
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

    var_01 = func_48EB(self.var_6DA4, var_00);
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

func_6DA2(param_00) {
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
  var_01 = func_48EA(self, param_00);
  var_01.isplaced = 1;
  var_01 thread func_9367(self.triggerportableradarping);
  self playSound("ims_plant");
  self notify("placed");
  var_01 thread func_6D9E();
  var_02 = spawnStruct();
  if(isDefined(self.moving_platform)) {
    var_02.linkparent = self.moving_platform;
  }

  var_02.endonstring = "carried";
  var_02.deathoverridecallback = ::func_936D;
  var_01 thread scripts\cp\cp_movers::handle_moving_platforms(var_02);
  self.carried_fireworks_trap delete();
  self delete();
}

func_6D9F(param_00) {
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

  self.carried_fireworks_trap delete();
  self delete();
}

func_6DA0(param_00) {
  self setsentrycarrier(param_00);
  self setcontents(0);
  self setCanDamage(0);
  self.carriedby = param_00;
  param_00.iscarrying = 1;
  param_00 thread scripts\cp\utility::update_trap_placement_internal(self, self.carried_fireworks_trap, level.var_6DA3["crafted_ims"]);
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
  func_6D9F();
}

func_9371(param_00) {
  self endon("placed");
  self endon("death");
  param_00 endon("last_stand");
  level waittill("game_ended");
  func_6D9F();
}

func_6D9E() {
  self endon("death");
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.var_6DA3[self.var_6DA4].pow);
  scripts\cp\utility::addtotraplist();
  var_00 = self.triggerportableradarping;
  var_00 getrigindexfromarchetyperef();
  self makeusable();
  self setusefov(120);
  self setuserange(96);
  wait(0.05);
  var_01 = (0, 0, 27);
  var_02 = (0, 0, 500) - var_01;
  var_03 = self.origin;
  var_04 = self.origin + var_01;
  var_05 = bulletTrace(var_04, var_04 + var_02, 0, self);
  var_06 = var_05;
  self.var_2514 = var_06["position"] - (0, 0, 20) - self.origin;
  if(self.var_2514[2] < 250) {
    self.var_AA7B = "launch_low";
  } else if(self.var_2514[2] < 450) {
    self.var_AA7B = "launch_med";
  } else {
    self.var_AA7B = "launch_high";
  }

  var_07 = spawn("trigger_radius", self.origin, 0, 256, 100);
  self.var_2536 = var_07;
  self.var_2536 enablelinkto();
  self.var_2536 linkto(self);
  self.var_2528 = length(self.var_2514) / 400;
  wait(0.75);
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

    self.var_2536 waittill("trigger", var_00);
    if(isplayer(var_00) || isDefined(var_00.pet) || isDefined(var_00.agent_type) && var_00.agent_type == "the_hoff") {
      continue;
    }

    var_01 = var_00.origin + (0, 0, 50);
    if(!sighttracepassed(self.var_2514 + self.origin, var_01, 0, self)) {
      continue;
    }

    if(!isDefined(self.var_2536)) {
      break;
    }

    if(!isDefined(self.var_8BF0[self.var_252E])) {
      self.var_8BF0[self.var_252E] = 1;
      thread func_AA75(var_00, self.var_252E);
      self.var_252E++;
    }

    if(self.var_252E > self.config.var_C228) {
      self setscriptablepartstate("firework", "off");
      break;
    }

    self waittill("firework_exploded");
    self setscriptablepartstate("firework", "off");
    wait(self.config.var_DDAC);
    if(!isDefined(self.triggerportableradarping)) {
      break;
    }
  }

  if(isDefined(self.carriedby) && isDefined(self.triggerportableradarping) && self.carriedby == self.triggerportableradarping) {
    return;
  }

  self notify("death");
}

func_AA75(param_00, param_01) {
  self setscriptablepartstate("firework", self.var_AA7B);
  var_02 = spawn("script_model", self.origin);
  var_02 setModel(self.config.var_6A03);
  var_02.angles = self.angles;
  var_02 setscriptablepartstate("rocket", "launch");
  var_03 = self.config.var_39B;
  var_04 = self.triggerportableradarping;
  var_02 moveto(self.var_2514 + self.origin, self.var_2528, self.var_2528 * 0.5, 0);
  var_02 waittill("movedone");
  var_02 setscriptablepartstate("rocket", "explode");
  wait(0.1);
  if(isDefined(var_04)) {
    magicbullet(var_03, var_02.origin, param_00.origin, var_04);
  } else {
    magicbullet(var_03, var_02.origin, param_00.origin, level.players[0]);
  }

  var_02 delete();
  self notify("firework_exploded");
}