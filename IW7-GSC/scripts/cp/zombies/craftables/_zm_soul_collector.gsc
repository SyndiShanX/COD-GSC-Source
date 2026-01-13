/****************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\craftables\_zm_soul_collector.gsc
****************************************************************/

init() {
  level._effect["medusa_death"] = loadfx("vfx\core\base\vfx_alien_soul_fly.vfx");
  level._effect["medusa_crawler_death"] = loadfx("vfx\iw7\core\zombie\vfx_alien_soul_fly_crawler.vfx");
  level._effect["medusa_blast_lg"] = loadfx("vfx\core\base\vfx_alien_cortex_blast_01.vfx");
  level.var_B548 = [];
  var_0 = spawnStruct();
  var_0.timeout = 300;
  var_0.modelbase = "zmb_medusa_energy_collector_01_empty";
  var_0.modelplacement = "zmb_medusa_energy_collector_01_empty";
  var_0.modelplacementfailed = "zmb_medusa_energy_collector_bad";
  var_0.pow = &"COOP_CRAFTABLES_PICKUP";
  var_0.placestring = &"COOP_CRAFTABLES_PLACE";
  var_0.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_0.placecancelablestring = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_0.var_74BF = &"ZOMBIE_CRAFTING_SOUVENIRS_DETONATE";
  var_0.var_9F43 = 0;
  var_0.placementheighttolerance = 30;
  var_0.placementradius = 16;
  var_0.carriedtrapoffset = (0, 0, 25);
  var_0.carriedtrapangles = (0, 0, 0);
  level.medusa_check_func = ::func_65F5;
  level.medusa_killed_func = ::func_A630;
  level.var_B549 = [];
  level.var_B549["crafted_medusa"] = var_0;
}

func_65F5(var_0) {
  var_1 = 262144;
  if(level.var_B548.size < 1) {
    return undefined;
  }

  var_2 = [];
  foreach(var_4 in level.var_B548) {
    if(!isDefined(var_4) || var_4.fully_charged) {
      continue;
    }

    if(distancesquared(var_4.origin, var_0.origin) < var_1) {
      var_2[var_2.size] = var_4;
    }
  }

  if(var_2.size == 0) {
    return undefined;
  }

  var_6 = sortbydistance(var_2, var_0.origin);
  return var_6[0];
}

func_A630(var_0, var_1, var_2) {
  if(var_2) {
    var_3 = level._effect["medusa_crawler_death"];
    playFX(var_3, var_0);
  } else {
    var_3 = level._effect["medusa_death"];
    playFX(var_3, var_0 + (0, 0, 5));
  }

  scripts\engine\utility::waitframe();
  var_4 = spawn("script_model", var_0 + (0, 0, 40));
  var_4 setModel("tag_origin_soultrail");
  if(!isDefined(var_1)) {
    var_4 delete();
    return;
  }

  var_5 = var_1.origin;
  var_6 = distance(var_0 + (0, 0, 40), var_5 + (0, 0, 75));
  var_7 = 350;
  var_8 = var_6 / var_7;
  if(var_8 < 0.05) {
    var_8 = 0.05;
  }

  var_4 moveto(var_1 gettagorigin("tag_fx"), var_8);
  var_4 waittill("movedone");
  var_4 setscriptablepartstate("tag", "collect");
  wait(0.5);
  var_4 delete();
  if(isDefined(var_1)) {
    var_1 notify("soul_collected");
  }
}

give_crafted_medusa(var_0, var_1) {
  var_1.itemtype = "crafted_medusa";
  var_1 thread watch_dpad();
  var_1 notify("new_power", "crafted_medusa");
  var_1 setclientomnvar("zom_crafted_weapon", 3);
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_medusa", ::give_crafted_medusa, var_1);
}

watch_dpad() {
  self endon("disconnect");
  self endon("death");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_medusa", "+actionslot 3");
  for(;;) {
    self waittill("pullout_medusa");
    if(scripts\engine\utility::istrue(self.iscarrying)) {
      continue;
    }

    if(scripts\engine\utility::istrue(self.linked_to_coaster)) {
      continue;
    }

    if(scripts\cp\utility::is_valid_player()) {
      break;
    }
  }

  thread shootturret(1);
}

shootturret(var_0, var_1, var_2) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_3 = func_49E8(self);
  scripts\cp\utility::remove_player_perks();
  self.carriedsentry = var_3;
  var_4 = setcarryingims(var_3, var_0, var_1, var_2);
  self.carriedsentry = undefined;
  thread scripts\cp\utility::wait_restore_player_perk();
  self.iscarrying = 0;
  if(isDefined(var_3)) {
    return 1;
  }

  return 0;
}

setcarryingims(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  var_0 func_B543(self, var_1);
  scripts\engine\utility::allow_weapon(0);
  self notifyonplayercommand("place_medusa", "+attack");
  self notifyonplayercommand("place_medusa", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_medusa", "+actionslot 3");
  if(!level.console) {
    self notifyonplayercommand("cancel_medusa", "+actionslot 5");
    self notifyonplayercommand("cancel_medusa", "+actionslot 6");
    self notifyonplayercommand("cancel_medusa", "+actionslot 7");
  }

  for(;;) {
    var_4 = scripts\engine\utility::waittill_any_return("place_medusa", "cancel_medusa", "force_cancel_placement");
    if(!isDefined(var_0)) {
      scripts\engine\utility::allow_weapon(1);
      return 1;
    }

    if(!isDefined(var_4)) {
      var_4 = "force_cancel_placement";
    }

    if(var_4 == "cancel_medusa" || var_4 == "force_cancel_placement") {
      if(!var_1 && var_4 == "cancel_medusa") {
        continue;
      }

      scripts\engine\utility::allow_weapon(1);
      var_0 func_B542();
      if(var_4 != "force_cancel_placement") {
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

    var_0 func_B545(var_2, var_3, self);
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

func_49E8(var_0) {
  var_1 = spawnturret("misc_turret", var_0.origin + (0, 0, 25), "sentry_minigun_mp");
  var_1.angles = var_0.angles;
  var_1.triggerportableradarping = var_0;
  var_1.name = "crafted_medusa";
  var_1 hide();
  var_1.carriedmedusa = spawn("script_model", var_1.origin + (0, 0, 25));
  var_1.carriedmedusa setModel(level.var_B549["crafted_medusa"].modelbase);
  var_1 getvalidattachments();
  var_1 setturretmodechangewait(1);
  var_1 give_player_session_tokens("sentry_offline");
  var_1 makeunusable();
  var_1 setsentryowner(var_0);
  var_1 func_B53F(var_0);
  return var_1;
}

func_B53F(var_0) {
  self.canbeplaced = 1;
  func_B544();
}

func_B53C(var_0) {
  self waittill("death");
  if(!isDefined(self)) {
    return;
  }

  func_B544();
  self playSound("sentry_explode");
  if(isDefined(self.charge_fx)) {
    self.charge_fx delete();
  }

  func_E11F();
  if(isDefined(self)) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_origin");
    self playSound("sentry_explode_smoke");
    wait(0.1);
    if(isDefined(self)) {
      self delete();
    }
  }
}

func_B53D() {
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

    if(self.fully_charged) {
      level thread func_B53B(self.origin, var_0);
      wait(0.6);
    } else {
      var_0 thread shootturret(0, self.lifespan, self.var_3CC3);
      self playSound("trap_medusa_pickup");
    }

    if(isDefined(self.charge_fx)) {
      self.charge_fx delete();
    }

    func_E11F();
    self delete();
  }
}

func_B53B(var_0, var_1) {
  playsoundatpos(var_0, "trap_medusa_explo");
  playFX(level._effect["medusa_blast_lg"], var_0);
  var_1.itemtype = "crafted_medusa";
  wait(0.5);
  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_2 = sortbydistance(var_2, var_0);
  foreach(var_4 in var_2) {
    if(!isDefined(var_4) || !isDefined(var_4.agent_type)) {
      continue;
    }

    if(var_4.agent_type == "zombie_grey" || var_4.agent_type == "zombie_ghost" || var_4.agent_type == "zombie_brute") {
      continue;
    }

    var_4 dodamage(var_4.health + 1000, var_4.origin);
    wait(0.1);
  }
}

func_B545(var_0, var_1, var_2) {
  var_3 = spawn("script_model", self.origin + (0, 0, 0));
  var_3.angles = self.angles;
  var_3.name = "crafted_medusa";
  self.carriedmedusa delete();
  var_3 solid();
  if(!isDefined(var_2.var_B546)) {
    var_2 iprintlnbold(&"ZOMBIE_CRAFTING_SOUVENIRS_KILL_NEAR_MEDUSA");
    var_2.var_B546 = 1;
  }

  var_4 = "zmb_medusa_energy_collector_01_empty";
  if(!isDefined(var_1)) {
    var_4 = "zmb_medusa_energy_collector_01_empty";
  } else {
    if(var_1 > 3) {
      var_4 = "zmb_medusa_energy_collector_01_1";
    }

    if(var_1 > 5) {
      var_4 = "zmb_medusa_energy_collector_01_2";
    }

    if(var_1 > 7) {
      var_4 = "zmb_medusa_energy_collector_01_3";
    }

    if(var_1 > 9) {
      var_4 = "zmb_medusa_energy_collector_01";
    }
  }

  var_3 setModel(var_4);
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  var_2.iscarrying = 0;
  var_3.triggerportableradarping = var_2;
  var_3 thread func_B541(var_0, var_1);
  self notify("placed");
  self delete();
}

func_B542() {
  self.carriedby getrigindexfromarchetyperef();
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping.iscarrying = 0;
  }

  self.carriedmedusa delete();
  self delete();
}

func_B543(var_0, var_1) {
  self setModel(level.var_B549["crafted_medusa"].modelplacement);
  self setsentrycarrier(var_0);
  self setCanDamage(0);
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  if(var_1) {
    self.firstplacement = 1;
  }

  var_0 thread scripts\cp\utility::update_trap_placement_internal(self, self.carriedmedusa, level.var_B549["crafted_medusa"]);
  thread scripts\cp\utility::item_oncarrierdeath(var_0);
  thread scripts\cp\utility::item_oncarrierdisconnect(var_0);
  thread scripts\cp\utility::item_ongameended(var_0);
  func_B544();
  self notify("carried");
}

func_B541(var_0, var_1) {
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.var_B549["crafted_medusa"].pow);
  self makeusable();
  self _meth_84A7("tag_fx");
  self setusefov(120);
  self setuserange(96);
  thread func_B53C(self.triggerportableradarping);
  thread scripts\cp\utility::item_handleownerdisconnect("medusa_handleOwner");
  thread scripts\cp\utility::item_timeout(var_0, level.var_B549["crafted_medusa"].timeout);
  thread func_B53D();
  thread func_B547();
  self.var_3CC3 = 0;
  self.fully_charged = 0;
  if(isDefined(var_1)) {
    self.var_3CC3 = var_1;
  }

  if(self.var_3CC3 >= 10) {
    self.fully_charged = 1;
    self sethintstring(level.var_B549["crafted_medusa"].var_74BF);
  }

  func_1862();
  if(!self.fully_charged) {
    self setscriptablepartstate("base", "charge_level_1");
    return;
  }

  self setscriptablepartstate("base", "charge_level_2");
}

func_B547() {
  self endon("death");
  for(;;) {
    self waittill("soul_collected");
    self.var_3CC3++;
    var_0 = "zmb_medusa_energy_collector_01_empty";
    if(self.var_3CC3 >= 3) {
      var_0 = "zmb_medusa_energy_collector_01_1";
    }

    if(self.var_3CC3 > 5) {
      var_0 = "zmb_medusa_energy_collector_01_2";
    }

    if(self.var_3CC3 > 7) {
      var_0 = "zmb_medusa_energy_collector_01_3";
    }

    if(self.var_3CC3 > 9) {
      var_0 = "zmb_medusa_energy_collector_01";
    }

    if(self.model != var_0) {
      self setModel(var_0);
      if(self.var_3CC3 != 10) {
        self setscriptablepartstate("base", "charge_level_1");
      } else {
        self sethintstring(level.var_B549["crafted_medusa"].var_74BF);
        self.fully_charged = 1;
        self setscriptablepartstate("base", "charge_level_2");
      }

      self makeusable();
      self _meth_84A7("tag_fx");
      self setusefov(120);
      self setuserange(96);
    }
  }
}

func_B544() {
  self makeunusable();
  func_E11F();
}

func_1862(var_0) {
  level.var_B548 = scripts\engine\utility::array_add_safe(level.var_B548, self);
  scripts\cp\utility::addtotraplist();
}

func_E11F(var_0) {
  level.var_B548 = scripts\engine\utility::array_remove(level.var_B548, self);
  scripts\cp\utility::removefromtraplist();
}

func_B539() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    wait(3);
    if(!isDefined(self.carriedby)) {
      self playSound("sentry_gun_beep");
    }
  }
}