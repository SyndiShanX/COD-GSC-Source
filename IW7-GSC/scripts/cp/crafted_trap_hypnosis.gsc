/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\crafted_trap_hypnosis.gsc
************************************************/

init() {
  level._effect["boombox_explode"] = loadfx("vfx\iw7\_requests\coop\vfx_ghetto_blast.vfx");
  var_0 = spawnStruct();
  var_0.timeout = 18;
  var_0.modelplacement = "cp_town_hypnosis_device_good";
  var_0.modelplacementfailed = "cp_town_hypnosis_device_bad";
  var_0.placedmodel = "cp_town_hypnosis_device";
  var_0.placestring = &"COOP_CRAFTABLES_PLACE";
  var_0.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_0.placecancelablestring = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_0.placementheighttolerance = 30;
  var_0.placementradius = 16;
  var_0.carriedtrapoffset = (0, 0, 35);
  var_0.carriedtrapangles = (0, -90, 0);
  level.crafted_hypnosis_settings = [];
  level.crafted_hypnosis_settings["crafted_hypnosis"] = var_0;
}

give_crafted_hypnosis(var_0, var_1) {
  var_1 thread watch_dpad();
  var_1 notify("new_power", "crafted_hypnosis");
  var_1 setclientomnvar("zom_crafted_weapon", 14);
  scripts\cp\utility::set_crafted_inventory_item("crafted_hypnosis", ::give_crafted_hypnosis, var_1);
}

watch_dpad() {
  self endon("disconnect");
  self endon("death");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_hypnosis", "+actionslot 3");
  for(;;) {
    self waittill("pullout_hypnosis");
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

  thread give_hypnosis(1);
}

give_hypnosis(var_0, var_1) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_2 = createhypnosisforplayer(self);
  self.itemtype = var_2.name;
  removeperks();
  var_2 = createhypnosisforplayer(self);
  self.carriedsentry = var_2;
  var_2.firstplacement = 1;
  var_3 = setcarryinghypnosis(var_2, var_0, var_1);
  self.carriedsentry = undefined;
  thread waitrestoreperks();
  self.iscarrying = 0;
  if(isDefined(var_2)) {
    return 1;
  }

  return 0;
}

setcarryinghypnosis(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 hypnosis_setcarried(self, var_1);
  scripts\engine\utility::allow_weapon(0);
  self notifyonplayercommand("place_hypnosis", "+attack");
  self notifyonplayercommand("place_hypnosis", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_hypnosis", "+actionslot 3");
  if(!level.console) {
    self notifyonplayercommand("cancel_hypnosis", "+actionslot 5");
    self notifyonplayercommand("cancel_hypnosis", "+actionslot 6");
    self notifyonplayercommand("cancel_hypnosis", "+actionslot 7");
  }

  for(;;) {
    var_3 = scripts\engine\utility::waittill_any_return("place_hypnosis", "cancel_hypnosis", "force_cancel_placement");
    if(!isDefined(var_0)) {
      scripts\engine\utility::allow_weapon(1);
      return 1;
    }

    if(!isDefined(var_3)) {
      var_3 = "force_cancel_placement";
    }

    if(var_3 == "cancel_hypnosis" || var_3 == "force_cancel_placement") {
      if(!var_1 && var_3 == "cancel_hypnosis") {
        continue;
      }

      scripts\engine\utility::allow_weapon(1);
      var_0 hypnosis_setcancelled();
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

    var_0 hypnosis_setplaced(var_2, self);
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

removeweapons() {
  if(self.hasriotshield) {
    var_0 = scripts\cp\utility::riotshieldname();
    self.restoreweapon = var_0;
    self.riotshieldammo = self getrunningforwardpainanim(var_0);
    self takeweapon(var_0);
  }
}

removeperks() {
  if(scripts\cp\utility::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\cp\utility::_unsetperk("specialty_explosivebullets");
  }
}

restoreweapons() {
  if(isDefined(self.restoreweapon)) {
    scripts\cp\utility::_giveweapon(self.restoreweapon);
    if(self.hasriotshield) {
      var_0 = scripts\cp\utility::riotshieldname();
      self setweaponammoclip(var_0, self.riotshieldammo);
    }
  }

  self.restoreweapon = undefined;
}

restoreperks() {
  if(isDefined(self.restoreperk)) {
    scripts\cp\utility::giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

waitrestoreperks() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(0.05);
  restoreperks();
}

createhypnosisforplayer(var_0) {
  var_1 = spawnturret("misc_turret", var_0.origin + (0, 0, 25), "sentry_minigun_mp");
  var_1.angles = var_0.angles;
  var_1.triggerportableradarping = var_0;
  var_1.name = "crafted_hypnosis";
  var_1.carriedhypnosis = spawn("script_model", var_1.origin);
  var_1.carriedhypnosis.angles = var_0.angles;
  var_1 getvalidattachments();
  var_1 setturretmodechangewait(1);
  var_1 give_player_session_tokens("sentry_offline");
  var_1 makeunusable();
  var_1 setsentryowner(var_0);
  var_1 hypnosis_inithypnosis(var_0);
  return var_1;
}

hypnosis_inithypnosis(var_0) {
  self.canbeplaced = 1;
  hypnosis_setinactive();
}

hypnosis_handledeath(var_0) {
  self waittill("death");
  if(!isDefined(self)) {
    return;
  }

  hypnosis_setinactive();
  self playSound("sentry_explode");
  if(isDefined(self.charge_fx)) {
    self.charge_fx delete();
  }

  if(isDefined(self.zap_model)) {
    self.zap_model delete();
  }

  scripts\cp\utility::removefromtraplist();
  if(isDefined(self)) {
    self delete();
  }
}

hypnosis_setplaced(var_0, var_1) {
  var_2 = self.carriedhypnosis.origin - (0, 0, 35);
  var_3 = self.carriedhypnosis.angles;
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  var_1.iscarrying = 0;
  self.carriedhypnosis delete();
  self delete();
  var_4 = spawn("script_model", var_2);
  var_4.angles = var_3;
  var_4.triggerportableradarping = var_1;
  var_4.team = "allies";
  var_4 setModel(level.crafted_hypnosis_settings["crafted_hypnosis"].placedmodel);
  var_4.name = "crafted_hypnosis";
  var_4.lastkilltime = gettime();
  var_4.lastmultikilltime = gettime();
  var_4 thread hypnosis_setactive(var_0);
  var_4 playSound("trap_boom_box_drop");
  self notify("placed");
}

hypnosis_setcancelled() {
  self.carriedby getrigindexfromarchetyperef();
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping.iscarrying = 0;
  }

  self.carriedhypnosis delete();
  self delete();
}

hypnosis_setcarried(var_0, var_1) {
  if(isDefined(self.originalowner)) {}

  self setModel(level.crafted_hypnosis_settings["crafted_hypnosis"].modelplacement);
  self hide();
  self setsentrycarrier(var_0);
  self setCanDamage(0);
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  var_0 thread scripts\cp\utility::update_trap_placement_internal(self, self.carriedhypnosis, level.crafted_hypnosis_settings["crafted_hypnosis"], 1);
  thread scripts\cp\utility::item_oncarrierdeath(var_0);
  thread scripts\cp\utility::item_oncarrierdisconnect(var_0);
  thread scripts\cp\utility::item_ongameended(var_0);
  hypnosis_setinactive();
  self notify("carried");
}

hypnosis_setactive(var_0) {
  wait(0.5);
  playFXOnTag(level._effect["hypnosis_active"], self, "tag_origin");
  create_attract_positions((1, 1, 0), 0, 15, 36);
  thread hypnosis_handledeath(self.triggerportableradarping);
  thread scripts\cp\utility::item_handleownerdisconnect("elechypnosis_handleOwner");
  thread scripts\cp\utility::item_timeout(var_0, level.crafted_hypnosis_settings["crafted_hypnosis"].timeout, "explode");
  thread hypnosis_trap_enemies();
  thread hypnosis_sfx();
  thread hypnosis_explode();
  scripts\cp\utility::addtotraplist();
}

hypnosis_setinactive() {
  self stoploopsound("trap_medusa_charging_lp");
  scripts\cp\utility::removefromtraplist();
}

hypnosis_trap_enemies() {
  self endon("death");
  self endon("explode");
  self.dancers = [];
  var_0 = 262144;
  for(;;) {
    var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_1 = scripts\engine\utility::get_array_of_closest(self.origin, var_1);
    foreach(var_3 in var_1) {
      if(!scripts\cp\utility::should_be_affected_by_trap(var_3) || scripts\engine\utility::istrue(var_3.about_to_dance) || scripts\engine\utility::istrue(var_3.controlled)) {
        continue;
      }

      if(var_3.agent_type == "crab_mini" || var_3.agent_type == "crab_brute") {
        continue;
      }

      if(distancesquared(self.origin, var_3.origin) < var_0) {
        var_4 = get_closest_attract_position(self, var_3);
        var_3 thread go_to_radio_and_dance(self, var_4);
        var_3 thread release_zombie_on_radio_death(self);
        scripts\engine\utility::waitframe();
      }
    }

    wait(0.1);
  }
}

hypnosis_sfx() {
  self playLoopSound("town_hypnosis_tone_lp");
  self waittill("explode");
  self playSound("town_hypnosis_build_up_to_explode");
  wait(0.25);
  self playLoopSound("town_hypnosis_tone_head_crush_lp");
  wait(1.15);
  if(isDefined(self)) {
    self stoploopsound();
  }

  thread func_66A7();
}

go_to_radio_and_dance(var_0, var_1) {
  var_0 endon("death");
  self endon("death");
  self endon("turned");
  var_0 endon("explode");
  self.about_to_dance = 1;
  self.scripted_mode = 1;
  self.og_goalradius = self.objective_playermask_showto;
  self.objective_playermask_showto = 32;
  self.og_movemode = self.synctransients;
  self.synctransients = "sprint";
  var_2 = var_0.origin - var_1.origin;
  var_3 = vectortoangles(var_2);
  self.desired_dance_angles = (0, var_3[1], 0);
  self give_mp_super_weapon(var_1.origin);
  scripts\engine\utility::waittill_any_3("goal", "goal_reached");
  self setscriptablepartstate("eyes", "hypnotized");
  self.var_CF80 = var_0.triggerportableradarping;
  self.is_dancing = 1;
  var_0.dancers[var_0.dancers.size] = self;
}

release_zombie_on_radio_death(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_any_3("death", "explode");
  if(isDefined(self.og_goalradius)) {
    self.objective_playermask_showto = self.og_goalradius;
  }

  self.synctransients = self.og_movemode;
  self.og_goalradius = undefined;
  self.about_to_dance = 0;
  self.scripted_mode = 0;
}

hypnosis_explode() {
  self waittill("explode");
  var_0 = self.dancers;
  foreach(var_3, var_2 in var_0) {
    var_2 thread hypnosis_delayed_death(var_3, self);
    if(isDefined(self.triggerportableradarping)) {
      self.triggerportableradarping scripts\cp\cp_merits::processmerit("mt_dlc3_crafted_kills");
    }
  }
}

func_66A7() {
  self playSound("trap_boom_box_explode");
  playFX(level._effect["violet_light_explode"], self.origin);
  wait(0.1);
  radiusdamage(self.origin + (0, 0, 40), 200, 500, 250, self, "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
  self hide();
  wait(0.65);
  physicsexplosionsphere(self.origin, 256, 256, 2);
  wait(0.1);
  self delete();
}

hypnosis_delayed_death(var_0, var_1) {
  self endon("death");
  wait(var_0 * 0.05);
  self.deathmethod = "hypnosis";
  if(!scripts\engine\utility::istrue(self.is_crawler)) {
    scripts\asm\asm::asm_setstate("hypnosisdeath");
    return;
  }

  scripts\asm\asm::asm_setstate("hypnosisdeathcrawling");
}

get_closest_attract_position(var_0, var_1) {
  var_2 = sortbydistance(var_0.attract_positions, var_1.origin);
  foreach(var_4 in var_2) {
    if(!var_4.occupied) {
      var_4.occupied = 1;
      return var_4;
    }
  }

  return var_2[0];
}

create_attract_positions(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = -27120;
  var_5 = 0;
  var_6 = 360 / var_2;
  self.attract_positions = [];
  for(var_7 = var_1; var_7 < 360 + var_1; var_7 = var_7 + var_6) {
    var_8 = var_0 * var_3;
    var_9 = (cos(var_7) * var_8[0] - sin(var_7) * var_8[1], sin(var_7) * var_8[0] + cos(var_7) * var_8[1], var_8[2]);
    var_0A = getclosestpointonnavmesh(self.origin + var_9 + (0, 0, 10));
    if(!scripts\cp\loot::is_in_active_volume(var_0A)) {
      continue;
    }

    if(isDefined(var_0A) && distancesquared(var_0A, self.origin) > var_4) {
      continue;
    } else {
      if(abs(var_0A[2] - self.origin[2]) < 60) {
        var_0B = spawnStruct();
        var_0B.origin = var_0A;
        var_0B.occupied = 0;
        self.attract_positions[self.attract_positions.size] = var_0B;
        continue;
      }

      var_5++;
    }
  }

  for(var_7 = var_1; var_7 < 360 + var_1; var_7 = var_7 + var_6) {
    var_8 = var_0 * var_3 + 56;
    var_9 = (cos(var_7) * var_8[0] - sin(var_7) * var_8[1], sin(var_7) * var_8[0] + cos(var_7) * var_8[1], var_8[2]);
    var_0A = getclosestpointonnavmesh(self.origin + var_9 + (0, 0, 10));
    if(!scripts\cp\loot::is_in_active_volume(var_0A)) {
      continue;
    }

    if(isDefined(var_0A) && distancesquared(var_0A, self.origin) > var_4) {
      continue;
    } else {
      if(abs(var_0A[2] - self.origin[2]) < 60) {
        var_0B = spawnStruct();
        var_0B.origin = var_0A;
        var_0B.occupied = 0;
        self.attract_positions[self.attract_positions.size] = var_0B;
        continue;
      }

      var_5++;
    }
  }

  return var_5;
}