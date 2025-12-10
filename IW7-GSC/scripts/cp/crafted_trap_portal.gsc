/**********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\crafted_trap_portal.gsc
**********************************************/

init() {
  var_00 = spawnStruct();
  var_00.timeout = 300;
  var_00.modelbase = "cp_town_teleporter_device";
  var_00.modelplacement = "cp_town_teleporter_device_good";
  var_00.modelplacementfailed = "cp_town_teleporter_device_bad";
  var_00.placedmodel = "cp_town_teleporter_device";
  var_00.pow = &"COOP_CRAFTABLES_PICKUP";
  var_00.placestring = &"COOP_CRAFTABLES_PLACE";
  var_00.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_00.placecancelablestring = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_00.placementheighttolerance = 30;
  var_00.placementradius = 24;
  var_00.carriedtrapoffset = (0, 0, 25);
  var_00.carriedtrapangles = (0, 0, 0);
  level.crafted_portal_settings = [];
  level.crafted_portal_settings["crafted_portal"] = var_00;
}

give_crafted_portal(param_00, param_01) {
  param_01 thread watch_dpad();
  param_01 notify("new_power", "crafted_portal");
  param_01 setclientomnvar("zom_crafted_weapon", 6);
  scripts\cp\utility::set_crafted_inventory_item("crafted_portal", ::give_crafted_portal, param_01);
  if(isDefined(param_01.placed_portals) && param_01.placed_portals.size == 2) {
    foreach(var_03 in param_01.placed_portals) {
      var_03 notify("death");
    }
  }
}

watch_dpad() {
  self endon("disconnect");
  self endon("death");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_portal", "+actionslot 3");
  for(;;) {
    self waittill("pullout_portal");
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

  thread give_portal(1);
}

give_portal(param_00, param_01, param_02) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_03 = createportalforplayer(self, param_02);
  self.itemtype = var_03.name;
  removeperks();
  self.carriedsentry = var_03;
  if(param_00) {
    var_03.firstplacement = 1;
  }

  var_04 = setcarryingportal(var_03, param_00, param_01);
  self.carriedsentry = undefined;
  thread waitrestoreperks();
  self.iscarrying = 0;
  if(isDefined(var_03)) {
    return 1;
  }

  return 0;
}

setcarryingportal(param_00, param_01, param_02) {
  self endon("disconnect");
  param_00 portal_setcarried(self, param_01);
  scripts\engine\utility::allow_weapon(0);
  self notifyonplayercommand("place_portal", "+attack");
  self notifyonplayercommand("place_portal", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_portal", "+actionslot 3");
  if(!level.console) {
    self notifyonplayercommand("cancel_portal", "+actionslot 5");
    self notifyonplayercommand("cancel_portal", "+actionslot 6");
    self notifyonplayercommand("cancel_portal", "+actionslot 7");
  }

  for(;;) {
    var_03 = scripts\engine\utility::waittill_any_return("place_portal", "cancel_portal", "force_cancel_placement");
    if(!isDefined(param_00)) {
      scripts\engine\utility::allow_weapon(1);
      return 1;
    }

    if(!isDefined(var_03)) {
      var_03 = "force_cancel_placement";
    }

    if(var_03 == "cancel_portal" || var_03 == "force_cancel_placement") {
      if(!param_01 && var_03 == "cancel_portal") {
        continue;
      }

      scripts\engine\utility::allow_weapon(1);
      param_00 portal_setcancelled();
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

    param_00 portal_setplaced(param_02, self);
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

removeperks() {
  if(scripts\cp\utility::_hasperk("specialty_explosivebullets")) {
    self.restoreperk = "specialty_explosivebullets";
    scripts\cp\utility::_unsetperk("specialty_explosivebullets");
  }
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

createportalforplayer(param_00, param_01) {
  var_02 = spawnturret("misc_turret", param_00.origin + (0, 0, 25), "sentry_minigun_mp");
  var_02.angles = param_00.angles;
  var_02.triggerportableradarping = param_00;
  var_02.name = "crafted_portal";
  var_02.carriedportal = spawn("script_model", var_02.origin);
  var_02.carriedportal.angles = param_00.angles;
  var_02 getvalidattachments();
  var_02 setturretmodechangewait(1);
  var_02 give_player_session_tokens("sentry_offline");
  var_02 makeunusable();
  var_02 setsentryowner(param_00);
  if(!isDefined(param_01)) {
    var_02.var_130D2 = 1;
  } else {
    var_02.var_130D2 = param_01;
  }

  var_02 portal_initportal(param_00);
  return var_02;
}

portal_initportal(param_00) {
  self.canbeplaced = 1;
  portal_setinactive();
}

portal_handledeath(param_00) {
  self waittill("death");
  if(!isDefined(self)) {
    return;
  }

  portal_setinactive();
  param_00.placed_portals = scripts\engine\utility::array_remove(param_00.placed_portals, self);
  scripts\cp\utility::removefromtraplist();
  if(isDefined(self)) {
    self delete();
  }
}

portal_setplaced(param_00, param_01) {
  var_02 = spawn("script_model", self.origin + (0, 0, 1));
  var_02.angles = self.angles;
  if(isDefined(level.secretpapstructs) && level.secretpapstructs.size > 0 && !isDefined(level.portal_opened)) {
    var_03 = scripts\engine\utility::getclosest(self.origin, level.secretpapstructs);
    if(distance(var_03.origin, self.origin) <= 128) {
      var_02.papredirect = 1;
    }
  }

  var_02 solid();
  var_02 setModel(level.crafted_portal_settings["crafted_portal"].placedmodel);
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  param_01.iscarrying = 0;
  var_02.triggerportableradarping = param_01;
  var_02.var_130D2 = self.var_130D2;
  var_02.name = "crafted_portal";
  var_02 thread portal_setactive(param_00);
  var_02 thread portal_wait_for_player();
  self notify("placed");
  self.carriedportal delete();
  self delete();
  var_02 hudoutlineenableforclient(param_01, 2, 0, 1, 0);
  if(!isDefined(param_01.placed_portals)) {
    param_01.placed_portals = [];
  }

  param_01.placed_portals[param_01.placed_portals.size] = var_02;
  if(param_01.placed_portals.size == 1) {
    param_01 thread watch_dpad();
    param_01 setclientomnvar("zom_crafted_weapon", 6);
    scripts\cp\utility::set_crafted_inventory_item("crafted_portal", ::give_crafted_portal, param_01);
  }

  if(param_01.placed_portals.size == 3) {
    param_01.placed_portals[param_01.placed_portals.size - 1] notify("death");
  }
}

portal_setcancelled() {
  self.carriedby getrigindexfromarchetyperef();
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping.iscarrying = 0;
  }

  self.carriedportal delete();
  self delete();
}

portal_setcarried(param_00, param_01) {
  self setModel(level.crafted_portal_settings["crafted_portal"].modelplacement);
  self hide();
  self setsentrycarrier(param_00);
  self setCanDamage(0);
  self.carriedby = param_00;
  param_00.iscarrying = 1;
  param_00 thread scripts\cp\utility::update_trap_placement_internal(self, self.carriedportal, level.crafted_portal_settings["crafted_portal"]);
  thread scripts\cp\utility::item_oncarrierdeath(param_00);
  thread scripts\cp\utility::item_oncarrierdisconnect(param_00);
  thread scripts\cp\utility::item_ongameended(param_00);
  portal_setinactive();
  self notify("carried");
}

portal_setactive(param_00) {
  self endon("death");
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.crafted_portal_settings["crafted_portal"].pow);
  self makeusable();
  self _meth_84A7("tag_fx");
  self setusefov(120);
  self setuserange(96);
  thread portal_handledeath(self.triggerportableradarping);
  thread scripts\cp\utility::item_handleownerdisconnect("elecportal_handleOwner");
  thread scripts\cp\utility::item_timeout(param_00, level.crafted_portal_settings["crafted_portal"].timeout);
  thread portal_handleuse();
  scripts\cp\utility::addtotraplist();
  wait(1);
  if(!scripts\engine\utility::istrue(self.papredirect)) {
    self setscriptablepartstate("portal", "on");
    return;
  }

  iprintlnbold("PAP PORTAL ACTIVE");
  self.triggerportableradarping notify("craft_dpad_watcher");
  self.triggerportableradarping setclientomnvar("zom_crafted_weapon", 0);
  self.triggerportableradarping.current_crafted_inventory = undefined;
  level.portal_opened = 1;
  activate_pap_portals(self.origin);
  foreach(var_02 in self.triggerportableradarping.placed_portals) {
    var_02 notify("death");
  }
}

activate_pap_portals(param_00) {
  var_01 = scripts\engine\utility::getclosest(param_00, level.secretpapstructs);
  var_01.model setscriptablepartstate("portal", "on");
  var_01.var_19 = 1;
  var_01.revealed = 1;
  level.active_pap_portal = var_01;
}

portal_handleuse() {
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

    self playSound("zmb_item_pickup");
    var_00 thread give_portal(0, self.lifespan, self.var_130D2);
    var_00.placed_portals = scripts\engine\utility::array_remove(var_00.placed_portals, self);
    scripts\cp\utility::removefromtraplist();
    self delete();
  }
}

portal_setinactive() {
  self makeunusable();
  scripts\cp\utility::removefromtraplist();
}

portal_wait_for_player() {
  self.triggerportableradarping endon("death");
  self.triggerportableradarping endon("disconnect");
  self endon("death");
  for(;;) {
    if(scripts\engine\utility::istrue(self.triggerportableradarping.teleporting)) {
      while(distancesquared(self.triggerportableradarping.origin, self.origin) < 576) {
        wait(0.1);
      }

      self.triggerportableradarping.teleporting = undefined;
    }

    if(distancesquared(self.triggerportableradarping.origin, self.origin) < 576) {
      self.triggerportableradarping.teleporting = 1;
      self.triggerportableradarping thread teleport_owner(self);
      wait(5);
    }

    wait(0.1);
  }
}

teleport_owner(param_00) {
  var_01 = self.placed_portals;
  foreach(var_03 in self.placed_portals) {
    if(var_03 == param_00) {
      continue;
    } else {
      self playlocalsound("zmb_portal_travel_lr");
      scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
      thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.5);
      playFX(level._effect["portal_player_world"], param_00.origin + (0, 0, 10));
      self setorigin(var_03.origin + (0, 0, 1));
    }
  }
}