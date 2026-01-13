/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2673.gsc
**************************************/

init() {
  level._effect["boombox_c4light"] = loadfx("vfx\iw7\_requests\coop\vfx_boombox_blink");
  level._effect["boombox_explode"] = loadfx("vfx\iw7\_requests\coop\vfx_ghetto_blast.vfx");
  var_0 = spawnStruct();
  var_0.timeout = 18.0;
  var_0.modelbase = "boom_box_c4_wm";
  var_0.modelplacement = "boom_box_c4_wm";
  var_0.modelplacementfailed = "boom_box_c4_wm_bad";
  var_0.placedmodel = "boom_box_c4_wm";
  var_0.placestring = &"COOP_CRAFTABLES_PLACE";
  var_0.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_0.placecancelablestring = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_0.placementheighttolerance = 30.0;
  var_0.placementradius = 16.0;
  var_0.carriedtrapoffset = (0, 0, 35);
  var_0.carriedtrapangles = (0, 180, 0);
  level.crafted_boombox_settings = [];
  level.crafted_boombox_settings["crafted_boombox"] = var_0;
}

give_crafted_boombox(var_0, var_1) {
  var_1 thread watch_dpad();
  var_1 notify("new_power", "crafted_boombox");
  var_1 setclientomnvar("zom_crafted_weapon", 5);
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_boombox", ::give_crafted_boombox, var_1);
}

watch_dpad() {
  self endon("disconnect");
  self endon("death");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_boombox", "+actionslot 3");

  for(;;) {
    self waittill("pullout_boombox");

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

  thread give_boombox(1);
}

give_boombox(var_0, var_1) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_2 = createboomboxforplayer(self);
  self.itemtype = var_2.name;
  removeperks();
  var_2 = createboomboxforplayer(self);
  self.carriedsentry = var_2;
  var_2.firstplacement = 1;
  var_3 = setcarryingboombox(var_2, var_0, var_1);
  self.carriedsentry = undefined;
  thread waitrestoreperks();
  self.iscarrying = 0;

  if(isDefined(var_2)) {
    return 1;
  } else {
    return 0;
  }
}

setcarryingboombox(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 boombox_setcarried(self, var_1);
  scripts\engine\utility::allow_weapon(0);
  self notifyonplayercommand("place_boombox", "+attack");
  self notifyonplayercommand("place_boombox", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_boombox", "+actionslot 3");

  if(!level.console) {
    self notifyonplayercommand("cancel_boombox", "+actionslot 5");
    self notifyonplayercommand("cancel_boombox", "+actionslot 6");
    self notifyonplayercommand("cancel_boombox", "+actionslot 7");
  }

  for(;;) {
    var_3 = scripts\engine\utility::waittill_any_return("place_boombox", "cancel_boombox", "force_cancel_placement");

    if(!isDefined(var_0)) {
      scripts\engine\utility::allow_weapon(1);
      return 1;
    }

    if(!isDefined(var_3)) {
      var_3 = "force_cancel_placement";
    }

    if(var_3 == "cancel_boombox" || var_3 == "force_cancel_placement") {
      if(!var_1 && var_3 == "cancel_boombox") {
        continue;
      }
      scripts\engine\utility::allow_weapon(1);
      var_0 boombox_setcancelled();

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

    var_0 boombox_setplaced(var_2, self);
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

removeweapons() {
  if(self.hasriotshield) {
    var_0 = scripts\cp\utility::riotshieldname();
    self.restoreweapon = var_0;
    self.riotshieldammo = self getammocount(var_0);
    self giveuponsuppressiontime(var_0);
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
  wait 0.05;
  restoreperks();
}

createboomboxforplayer(var_0) {
  var_1 = spawnturret("misc_turret", var_0.origin + (0, 0, 25), "sentry_minigun_mp");
  var_1.angles = var_0.angles;
  var_1.owner = var_0;
  var_1.name = "crafted_boombox";
  var_1.carriedboombox = spawn("script_model", var_1.origin);
  var_1.carriedboombox.angles = var_0.angles;
  var_1 maketurretinoperable();
  var_1 setturretmodechangewait(1);
  var_1 give_player_session_tokens("sentry_offline");
  var_1 makeunusable();
  var_1 setsentryowner(var_0);
  var_1 boombox_initboombox(var_0);
  return var_1;
}

boombox_initboombox(var_0) {
  self.canbeplaced = 1;
  boombox_setinactive();
}

boombox_handledeath(var_0) {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  boombox_setinactive();
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

boombox_setplaced(var_0, var_1) {
  var_2 = getgroundposition(self.carriedboombox.origin, 4);
  var_3 = spawn("script_model", self.carriedboombox.origin);
  var_3.angles = self.carriedboombox.angles;
  var_3 solid();
  var_3 setModel(level.crafted_boombox_settings["crafted_boombox"].placedmodel);
  var_3 physicslaunchserver(var_3.origin, (0, 0, 1));
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  var_1.iscarrying = 0;
  self.carriedboombox delete();
  self delete();
  var_3 moveto(var_2, 0.5);
  wait 0.6;
  var_4 = spawn("script_model", var_3.origin);
  var_4.angles = var_3.angles;
  var_4.owner = var_1;
  var_4.team = "allies";
  var_4 setModel(level.crafted_boombox_settings["crafted_boombox"].placedmodel);
  var_4.name = "crafted_boombox";
  var_3 delete();
  var_4.lastkilltime = gettime();
  var_4.lastmultikilltime = gettime();
  var_4 thread boombox_setactive(var_0);
  var_4 playSound("trap_boom_box_drop");
  self notify("placed");
}

boombox_setcancelled() {
  self.carriedby getrigindexfromarchetyperef();

  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;
  }

  self.carriedboombox delete();
  self delete();
}

boombox_setcarried(var_0, var_1) {
  if(isDefined(self.originalowner)) {}

  self setModel(level.crafted_boombox_settings["crafted_boombox"].modelplacement);
  self hide();
  self setsentrycarrier(var_0);
  self setCanDamage(0);
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  var_0 thread scripts\cp\utility::update_trap_placement_internal(self, self.carriedboombox, level.crafted_boombox_settings["crafted_boombox"], 1);
  thread scripts\cp\utility::item_oncarrierdeath(var_0);
  thread scripts\cp\utility::item_oncarrierdisconnect(var_0);
  thread scripts\cp\utility::item_ongameended(var_0);
  boombox_setinactive();
  self notify("carried");
}

boombox_setactive(var_0) {
  create_attract_positions((1, 1, 0), 0, 10, 48);
  thread boombox_handledeath(self.owner);
  thread scripts\cp\utility::item_handleownerdisconnect("elecboombox_handleOwner");
  thread scripts\cp\utility::item_timeout(var_0, level.crafted_boombox_settings["crafted_boombox"].timeout, "explode");
  thread boombox_trap_enemies();
  thread boombox_explode();
  scripts\cp\utility::addtotraplist();
  wait 1;
  playFXOnTag(level._effect["boombox_c4light"], self, "c4_fx_tag");
}

boombox_setinactive() {
  scripts\cp\utility::removefromtraplist();
}

boombox_trap_enemies() {
  self endon("death");
  self endon("boombox_explode");
  self.dancers = [];
  self playLoopSound("mus_zombies_boombox");
  var_0 = 262144;

  for(;;) {
    var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_1 = scripts\engine\utility::get_array_of_closest(self.origin, var_1);

    foreach(var_3 in var_1) {
      if(!scripts\cp\utility::should_be_affected_by_trap(var_3) || var_3.about_to_dance) {
        continue;
      }
      if(scripts\engine\utility::is_true(self.is_suicide_bomber)) {
        continue;
      }
      if(distancesquared(self.origin, var_3.origin) < var_0) {
        var_4 = get_closest_attract_position(self, var_3);
        var_3 thread go_to_radio_and_dance(self, var_4);
        var_3 thread release_zombie_on_radio_death(self);
        scripts\engine\utility::waitframe();
      }
    }

    wait 0.1;
  }
}

go_to_radio_and_dance(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("boombox_explode");
  self endon("death");
  self endon("turned");
  self.about_to_dance = 1;
  self.scripted_mode = 1;
  self.og_goalradius = self.goalradius;
  self.goalradius = 32;
  var_2 = var_0.origin - var_1.origin;
  var_3 = vectortoangles(var_2);
  self.desired_dance_angles = (0, var_3[1], 0);
  self give_mp_super_weapon(var_1.origin);
  scripts\engine\utility::waittill_any("goal", "goal_reached");
  self.is_dancing = 1;
  var_0.dancers[var_0.dancers.size] = self;
}

release_zombie_on_radio_death(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_any("boombox_explode", "death");

  if(isDefined(self.og_goalradius)) {
    self.goalradius = self.og_goalradius;
  }

  self.og_goalradius = undefined;
  self.about_to_dance = 0;
  self.scripted_mode = 0;
}

boombox_explode() {
  self waittill("explode");
  self playSound("mus_zombies_boombox_slow_down");
  self stoploopsound();
  self playSound("trap_boombox_warning");
  self notify("boombox_explode");
  wait(lookupsoundlength("mus_zombies_boombox_slow_down") / 1000);
  self playSound("trap_boom_box_explode");
  playFX(level._effect["boombox_explode"], self.origin);
  physicsexplosionsphere(self.origin, 256, 256, 2);
  var_0 = self.dancers;
  var_1 = 0;
  var_2 = 65536;

  foreach(var_4 in var_0) {
    if(var_1 > 5) {
      var_4.nocorpse = 1;
      var_4.full_gib = 1;
      var_4.deathmethod = "boombox";
      var_4 getrandomarmkillstreak(var_4.health + 100, self.origin, self, self, "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
      continue;
    }

    var_4 giveflagcapturexp(vectornormalize(var_4.origin - self.origin) * 400 + (0, 0, 200));
    var_4.do_immediate_ragdoll = 1;
    var_4.customdeath = 1;
    var_4 thread boombox_delayed_death(self);
    var_1++;
  }

  scripts\engine\utility::waitframe();
  radiusdamage(self.origin + (0, 0, 40), 350, 1000000, 1000000, self, "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
  self hide();
  wait 3;
  self notify("death");
}

boombox_delayed_death(var_0) {
  self endon("death");
  wait 0.1;
  self getrandomarmkillstreak(self.health + 100, self.origin, var_0, var_0, "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
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
  var_4 = 38416;
  var_5 = 0;
  var_6 = 360 / var_2;
  self.attract_positions = [];
  self.occupied_positions = 0;
  self.discotrap_disabled = 0;

  for(var_7 = var_1; var_7 < 360 + var_1; var_7 = var_7 + var_6) {
    var_8 = var_0 * var_3;
    var_9 = (cos(var_7) * var_8[0] - sin(var_7) * var_8[1], sin(var_7) * var_8[0] + cos(var_7) * var_8[1], var_8[2]);
    var_10 = getclosestpointonnavmesh(self.origin + var_9 + (0, 0, 10));

    if(!scripts\cp\loot::is_in_active_volume(var_10)) {
      continue;
    }
    if(isDefined(var_10) && distancesquared(var_10, self.origin) > var_4) {
      continue;
    } else {
      if(abs(var_10[2] - self.origin[2]) < 60) {
        if(level.script != "cp_disco") {
          if(ispointinvolume(var_10, level.dance_floor_volume)) {
            if(isDefined(level.discotrap_active)) {
              continue;
            } else if(!self.discotrap_disabled) {
              self.discotrap_disabled = 1;
              var_11 = scripts\engine\utility::getstructarray("interaction_discoballtrap", "script_noteworthy");
              level thread scripts\cp\cp_interaction::interaction_cooldown(var_11[0], 30);
            }
          }
        }

        var_12 = spawnStruct();
        var_12.origin = var_10;
        var_12.occupied = 0;
        self.attract_positions[self.attract_positions.size] = var_12;
        continue;
      }

      var_5++;
    }
  }

  for(var_7 = var_1; var_7 < 360 + var_1; var_7 = var_7 + var_6) {
    var_8 = var_0 * (var_3 + 56);
    var_9 = (cos(var_7) * var_8[0] - sin(var_7) * var_8[1], sin(var_7) * var_8[0] + cos(var_7) * var_8[1], var_8[2]);
    var_10 = getclosestpointonnavmesh(self.origin + var_9 + (0, 0, 10));

    if(!scripts\cp\loot::is_in_active_volume(var_10)) {
      continue;
    }
    if(isDefined(var_10) && distancesquared(var_10, self.origin) > var_4) {
      continue;
    } else {
      if(abs(var_10[2] - self.origin[2]) < 60) {
        var_12 = spawnStruct();
        var_12.origin = var_10;
        var_12.occupied = 0;
        self.attract_positions[self.attract_positions.size] = var_12;
        continue;
      }

      var_5++;
    }
  }

  return var_5;
}