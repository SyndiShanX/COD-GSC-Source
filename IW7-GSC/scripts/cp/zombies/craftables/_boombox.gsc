/******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\craftables\_boombox.gsc
******************************************************/

init() {
  level._effect["boombox_c4light"] = loadfx("vfx\iw7\_requests\coop\vfx_boombox_blink");
  level._effect["boombox_explode"] = loadfx("vfx\iw7\_requests\coop\vfx_ghetto_blast.vfx");
  var_00 = spawnStruct();
  var_00.timeout = 18;
  var_00.modelbase = "boom_box_c4_wm";
  var_00.modelplacement = "boom_box_c4_wm";
  var_00.modelplacementfailed = "boom_box_c4_wm_bad";
  var_00.placedmodel = "boom_box_c4_wm";
  var_00.placestring = & "COOP_CRAFTABLES_PLACE";
  var_00.cannotplacestring = & "COOP_CRAFTABLES_CANNOT_PLACE";
  var_00.placecancelablestring = & "COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_00.placementheighttolerance = 30;
  var_00.placementradius = 16;
  var_00.carriedtrapoffset = (0, 0, 35);
  var_00.carriedtrapangles = (0, 180, 0);
  level.crafted_boombox_settings = [];
  level.crafted_boombox_settings["crafted_boombox"] = var_00;
}

give_crafted_boombox(param_00, param_01) {
  param_01 thread watch_dpad();
  param_01 notify("new_power", "crafted_boombox");
  param_01 setclientomnvar("zom_crafted_weapon", 5);
  param_01 thread scripts\cp\utility::usegrenadegesture(param_01, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_boombox", ::give_crafted_boombox, param_01);
}

watch_dpad() {
  self endon("disconnect");
  self endon("death");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_boombox", "+actionslot 3");
  for(;;) {
    self waittill("pullout_boombox");
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

  thread give_boombox(1);
}

give_boombox(param_00, param_01) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_02 = createboomboxforplayer(self);
  self.itemtype = var_02.name;
  removeperks();
  var_02 = createboomboxforplayer(self);
  self.carriedsentry = var_02;
  var_02.firstplacement = 1;
  var_03 = setcarryingboombox(var_02, param_00, param_01);
  self.carriedsentry = undefined;
  thread waitrestoreperks();
  self.iscarrying = 0;
  if(isDefined(var_02)) {
    return 1;
  }

  return 0;
}

setcarryingboombox(param_00, param_01, param_02) {
  self endon("disconnect");
  param_00 boombox_setcarried(self, param_01);
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
    var_03 = scripts\engine\utility::waittill_any_return("place_boombox", "cancel_boombox", "force_cancel_placement");
    if(!isDefined(param_00)) {
      scripts\engine\utility::allow_weapon(1);
      return 1;
    }

    if(!isDefined(var_03)) {
      var_03 = "force_cancel_placement";
    }

    if(var_03 == "cancel_boombox" || var_03 == "force_cancel_placement") {
      if(!param_01 && var_03 == "cancel_boombox") {
        continue;
      }

      scripts\engine\utility::allow_weapon(1);
      param_00 boombox_setcancelled();
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

    param_00 boombox_setplaced(param_02, self);
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

removeweapons() {
  if(self.hasriotshield) {
    var_00 = scripts\cp\utility::riotshieldname();
    self.restoreweapon = var_00;
    self.riotshieldammo = self getrunningforwardpainanim(var_00);
    self takeweapon(var_00);
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
      var_00 = scripts\cp\utility::riotshieldname();
      self setweaponammoclip(var_00, self.riotshieldammo);
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

createboomboxforplayer(param_00) {
  var_01 = spawnturret("misc_turret", param_00.origin + (0, 0, 25), "sentry_minigun_mp");
  var_01.angles = param_00.angles;
  var_01.triggerportableradarping = param_00;
  var_01.name = "crafted_boombox";
  var_01.carriedboombox = spawn("script_model", var_01.origin);
  var_01.carriedboombox.angles = param_00.angles;
  var_01 getvalidattachments();
  var_01 setturretmodechangewait(1);
  var_01 give_player_session_tokens("sentry_offline");
  var_01 makeunusable();
  var_01 setsentryowner(param_00);
  var_01 boombox_initboombox(param_00);
  return var_01;
}

boombox_initboombox(param_00) {
  self.canbeplaced = 1;
  boombox_setinactive();
}

boombox_handledeath(param_00) {
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

boombox_setplaced(param_00, param_01) {
  var_02 = getgroundposition(self.carriedboombox.origin, 4);
  var_03 = spawn("script_model", self.carriedboombox.origin);
  var_03.angles = self.carriedboombox.angles;
  var_03 solid();
  var_03 setModel(level.crafted_boombox_settings["crafted_boombox"].placedmodel);
  var_03 physicslaunchserver(var_03.origin, (0, 0, 1));
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  param_01.iscarrying = 0;
  self.carriedboombox delete();
  self delete();
  var_03 moveto(var_02, 0.5);
  wait(0.6);
  var_04 = spawn("script_model", var_03.origin);
  var_04.angles = var_03.angles;
  var_04.triggerportableradarping = param_01;
  var_04.team = "allies";
  var_04 setModel(level.crafted_boombox_settings["crafted_boombox"].placedmodel);
  var_04.name = "crafted_boombox";
  var_03 delete();
  var_04.lastkilltime = gettime();
  var_04.lastmultikilltime = gettime();
  var_04 thread boombox_setactive(param_00);
  var_04 playSound("trap_boom_box_drop");
  self notify("placed");
}

boombox_setcancelled() {
  self.carriedby getrigindexfromarchetyperef();
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping.iscarrying = 0;
  }

  self.carriedboombox delete();
  self delete();
}

boombox_setcarried(param_00, param_01) {
  if(isDefined(self.originalowner)) {} else {}

  self setModel(level.crafted_boombox_settings["crafted_boombox"].modelplacement);
  self hide();
  self setsentrycarrier(param_00);
  self setCanDamage(0);
  self.carriedby = param_00;
  param_00.iscarrying = 1;
  param_00 thread scripts\cp\utility::update_trap_placement_internal(self, self.carriedboombox, level.crafted_boombox_settings["crafted_boombox"], 1);
  thread scripts\cp\utility::item_oncarrierdeath(param_00);
  thread scripts\cp\utility::item_oncarrierdisconnect(param_00);
  thread scripts\cp\utility::item_ongameended(param_00);
  boombox_setinactive();
  self notify("carried");
}

boombox_setactive(param_00) {
  create_attract_positions((1, 1, 0), 0, 10, 48);
  thread boombox_handledeath(self.triggerportableradarping);
  thread scripts\cp\utility::item_handleownerdisconnect("elecboombox_handleOwner");
  thread scripts\cp\utility::item_timeout(param_00, level.crafted_boombox_settings["crafted_boombox"].timeout, "explode");
  thread boombox_trap_enemies();
  thread boombox_explode();
  scripts\cp\utility::addtotraplist();
  wait(1);
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
  var_00 = 262144;
  for(;;) {
    var_01 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_01 = scripts\engine\utility::get_array_of_closest(self.origin, var_01);
    foreach(var_03 in var_01) {
      if(!scripts\cp\utility::should_be_affected_by_trap(var_03) || var_03.about_to_dance) {
        continue;
      }

      if(scripts\engine\utility::istrue(self.is_suicide_bomber)) {
        continue;
      }

      if(distancesquared(self.origin, var_03.origin) < var_00) {
        var_04 = get_closest_attract_position(self, var_03);
        var_03 thread go_to_radio_and_dance(self, var_04);
        var_03 thread release_zombie_on_radio_death(self);
        scripts\engine\utility::waitframe();
      }
    }

    wait(0.1);
  }
}

go_to_radio_and_dance(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("boombox_explode");
  self endon("death");
  self endon("turned");
  self.about_to_dance = 1;
  self.scripted_mode = 1;
  self.og_goalradius = self.objective_playermask_showto;
  self.objective_playermask_showto = 32;
  var_02 = param_00.origin - param_01.origin;
  var_03 = vectortoangles(var_02);
  self.desired_dance_angles = (0, var_03[1], 0);
  self give_mp_super_weapon(param_01.origin);
  scripts\engine\utility::waittill_any_3("goal", "goal_reached");
  self.is_dancing = 1;
  param_00.dancers[param_00.dancers.size] = self;
}

release_zombie_on_radio_death(param_00) {
  self endon("death");
  param_00 scripts\engine\utility::waittill_any_3("boombox_explode", "death");
  if(isDefined(self.og_goalradius)) {
    self.objective_playermask_showto = self.og_goalradius;
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
  var_00 = self.dancers;
  var_01 = 0;
  var_02 = 65536;
  foreach(var_04 in var_00) {
    if(var_01 > 5) {
      var_04.nocorpse = 1;
      var_04.full_gib = 1;
      var_04.deathmethod = "boombox";
      var_04 dodamage(var_04.health + 100, self.origin, self, self, "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
      continue;
    }

    var_04 setvelocity(vectornormalize(var_04.origin - self.origin) * 400 + (0, 0, 200));
    var_04.do_immediate_ragdoll = 1;
    var_04.customdeath = 1;
    var_04 thread boombox_delayed_death(self);
    var_01++;
  }

  scripts\engine\utility::waitframe();
  radiusdamage(self.origin + (0, 0, 40), 350, 1000000, 1000000, self, "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
  self hide();
  wait(3);
  self notify("death");
}

boombox_delayed_death(param_00) {
  self endon("death");
  wait(0.1);
  self dodamage(self.health + 100, self.origin, param_00, param_00, "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
}

get_closest_attract_position(param_00, param_01) {
  var_02 = sortbydistance(param_00.attract_positions, param_01.origin);
  foreach(var_04 in var_02) {
    if(!var_04.occupied) {
      var_04.occupied = 1;
      return var_04;
    }
  }

  return var_02[0];
}

create_attract_positions(param_00, param_01, param_02, param_03) {
  self endon("death");
  var_04 = -27120;
  var_05 = 0;
  var_06 = 360 / param_02;
  self.attract_positions = [];
  self.occupied_positions = 0;
  self.discotrap_disabled = 0;
  for(var_07 = param_01; var_07 < 360 + param_01; var_07 = var_07 + var_06) {
    var_08 = param_00 * param_03;
    var_09 = (cos(var_07) * var_08[0] - sin(var_07) * var_08[1], sin(var_07) * var_08[0] + cos(var_07) * var_08[1], var_08[2]);
    var_0A = getclosestpointonnavmesh(self.origin + var_09 + (0, 0, 10));
    if(!scripts\cp\loot::is_in_active_volume(var_0A)) {
      continue;
    }

    if(isDefined(var_0A) && distancesquared(var_0A, self.origin) > var_04) {
      continue;
    } else {
      if(abs(var_0A[2] - self.origin[2]) < 60) {
        if(level.script != "cp_disco") {
          if(ispointinvolume(var_0A, level.dance_floor_volume)) {
            if(isDefined(level.discotrap_active)) {
              continue;
            } else if(!self.discotrap_disabled) {
              self.discotrap_disabled = 1;
              var_0B = scripts\engine\utility::getstructarray("interaction_discoballtrap", "script_noteworthy");
              level thread scripts\cp\cp_interaction::interaction_cooldown(var_0B[0], 30);
            }
          }
        }

        var_0C = spawnStruct();
        var_0C.origin = var_0A;
        var_0C.occupied = 0;
        self.attract_positions[self.attract_positions.size] = var_0C;
        continue;
      }

      var_05++;
    }
  }

  for(var_07 = param_01; var_07 < 360 + param_01; var_07 = var_07 + var_06) {
    var_08 = param_00 * param_03 + 56;
    var_09 = (cos(var_07) * var_08[0] - sin(var_07) * var_08[1], sin(var_07) * var_08[0] + cos(var_07) * var_08[1], var_08[2]);
    var_0A = getclosestpointonnavmesh(self.origin + var_09 + (0, 0, 10));
    if(!scripts\cp\loot::is_in_active_volume(var_0A)) {
      continue;
    }

    if(isDefined(var_0A) && distancesquared(var_0A, self.origin) > var_04) {
      continue;
    } else {
      if(abs(var_0A[2] - self.origin[2]) < 60) {
        var_0C = spawnStruct();
        var_0C.origin = var_0A;
        var_0C.occupied = 0;
        self.attract_positions[self.attract_positions.size] = var_0C;
        continue;
      }

      var_05++;
    }
  }

  return var_05;
}