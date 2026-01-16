/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\crafted_trap_portal.gsc
**********************************************/

init() {
  var_0 = spawnStruct();
  var_0.timeout = 300;
  var_0.modelbase = "cp_town_teleporter_device";
  var_0.modelplacement = "cp_town_teleporter_device_good";
  var_0.modelplacementfailed = "cp_town_teleporter_device_bad";
  var_0.placedmodel = "cp_town_teleporter_device";
  var_0.hintstring = &"COOP_CRAFTABLES_PICKUP";
  var_0.placestring = &"COOP_CRAFTABLES_PLACE";
  var_0.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_0.placecancelablestring = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_0.placementheighttolerance = 30;
  var_0.placementradius = 24;
  var_0.carriedtrapoffset = (0, 0, 25);
  var_0.carriedtrapangles = (0, 0, 0);
  level.crafted_portal_settings = [];
  level.crafted_portal_settings["crafted_portal"] = var_0;
}

give_crafted_portal(var_0, var_1) {
  var_1 thread watch_dpad();
  var_1 notify("new_power", "crafted_portal");
  var_1 setclientomnvar("zom_crafted_weapon", 6);
  scripts\cp\utility::set_crafted_inventory_item("crafted_portal", ::give_crafted_portal, var_1);
  if(isDefined(var_1.placed_portals) && var_1.placed_portals.size == 2) {
    foreach(var_3 in var_1.placed_portals) {
      var_3 notify("death");
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

give_portal(var_0, var_1, var_2) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_3 = createportalforplayer(self, var_2);
  self.itemtype = var_3.name;
  removeperks();
  self.carriedsentry = var_3;
  if(var_0) {
    var_3.firstplacement = 1;
  }

  var_4 = setcarryingportal(var_3, var_0, var_1);
  self.carriedsentry = undefined;
  thread waitrestoreperks();
  self.iscarrying = 0;
  if(isDefined(var_3)) {
    return 1;
  }

  return 0;
}

setcarryingportal(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 portal_setcarried(self, var_1);
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
    var_3 = scripts\engine\utility::waittill_any_return("place_portal", "cancel_portal", "force_cancel_placement");
    if(!isDefined(var_0)) {
      scripts\engine\utility::allow_weapon(1);
      return 1;
    }

    if(!isDefined(var_3)) {
      var_3 = "force_cancel_placement";
    }

    if(var_3 == "cancel_portal" || var_3 == "force_cancel_placement") {
      if(!var_1 && var_3 == "cancel_portal") {
        continue;
      }

      scripts\engine\utility::allow_weapon(1);
      var_0 portal_setcancelled();
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

    var_0 portal_setplaced(var_2, self);
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

createportalforplayer(var_0, var_1) {
  var_2 = spawnturret("misc_turret", var_0.origin + (0, 0, 25), "sentry_minigun_mp");
  var_2.angles = var_0.angles;
  var_2.owner = var_0;
  var_2.name = "crafted_portal";
  var_2.carriedportal = spawn("script_model", var_2.origin);
  var_2.carriedportal.angles = var_0.angles;
  var_2 getvalidattachments();
  var_2 setturretmodechangewait(1);
  var_2 give_player_session_tokens("sentry_offline");
  var_2 makeunusable();
  var_2 setsentryowner(var_0);
  if(!isDefined(var_1)) {
    var_2.var_130D2 = 1;
  } else {
    var_2.var_130D2 = var_1;
  }

  var_2 portal_initportal(var_0);
  return var_2;
}

portal_initportal(var_0) {
  self.canbeplaced = 1;
  portal_setinactive();
}

portal_handledeath(var_0) {
  self waittill("death");
  if(!isDefined(self)) {
    return;
  }

  portal_setinactive();
  var_0.placed_portals = scripts\engine\utility::array_remove(var_0.placed_portals, self);
  scripts\cp\utility::removefromtraplist();
  if(isDefined(self)) {
    self delete();
  }
}

portal_setplaced(var_0, var_1) {
  var_2 = spawn("script_model", self.origin + (0, 0, 1));
  var_2.angles = self.angles;
  if(isDefined(level.secretpapstructs) && level.secretpapstructs.size > 0 && !isDefined(level.portal_opened)) {
    var_3 = scripts\engine\utility::getclosest(self.origin, level.secretpapstructs);
    if(distance(var_3.origin, self.origin) <= 128) {
      var_2.papredirect = 1;
    }
  }

  var_2 solid();
  var_2 setModel(level.crafted_portal_settings["crafted_portal"].placedmodel);
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  var_1.iscarrying = 0;
  var_2.owner = var_1;
  var_2.var_130D2 = self.var_130D2;
  var_2.name = "crafted_portal";
  var_2 thread portal_setactive(var_0);
  var_2 thread portal_wait_for_player();
  self notify("placed");
  self.carriedportal delete();
  self delete();
  var_2 hudoutlineenableforclient(var_1, 2, 0, 1, 0);
  if(!isDefined(var_1.placed_portals)) {
    var_1.placed_portals = [];
  }

  var_1.placed_portals[var_1.placed_portals.size] = var_2;
  if(var_1.placed_portals.size == 1) {
    var_1 thread watch_dpad();
    var_1 setclientomnvar("zom_crafted_weapon", 6);
    scripts\cp\utility::set_crafted_inventory_item("crafted_portal", ::give_crafted_portal, var_1);
  }

  if(var_1.placed_portals.size == 3) {
    var_1.placed_portals[var_1.placed_portals.size - 1] notify("death");
  }
}

portal_setcancelled() {
  self.carriedby getrigindexfromarchetyperef();
  if(isDefined(self.owner)) {
    self.owner.iscarrying = 0;
  }

  self.carriedportal delete();
  self delete();
}

portal_setcarried(var_0, var_1) {
  self setModel(level.crafted_portal_settings["crafted_portal"].modelplacement);
  self hide();
  self setsentrycarrier(var_0);
  self setCanDamage(0);
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  var_0 thread scripts\cp\utility::update_trap_placement_internal(self, self.carriedportal, level.crafted_portal_settings["crafted_portal"]);
  thread scripts\cp\utility::item_oncarrierdeath(var_0);
  thread scripts\cp\utility::item_oncarrierdisconnect(var_0);
  thread scripts\cp\utility::item_ongameended(var_0);
  portal_setinactive();
  self notify("carried");
}

portal_setactive(var_0) {
  self endon("death");
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.crafted_portal_settings["crafted_portal"].hintstring);
  self makeusable();
  self func_84A7("tag_fx");
  self setusefov(120);
  self setuserange(96);
  thread portal_handledeath(self.owner);
  thread scripts\cp\utility::item_handleownerdisconnect("elecportal_handleOwner");
  thread scripts\cp\utility::item_timeout(var_0, level.crafted_portal_settings["crafted_portal"].timeout);
  thread portal_handleuse();
  scripts\cp\utility::addtotraplist();
  wait(1);
  if(!scripts\engine\utility::istrue(self.papredirect)) {
    self setscriptablepartstate("portal", "on");
    return;
  }

  iprintlnbold("PAP PORTAL ACTIVE");
  self.owner notify("craft_dpad_watcher");
  self.owner setclientomnvar("zom_crafted_weapon", 0);
  self.owner.current_crafted_inventory = undefined;
  level.portal_opened = 1;
  activate_pap_portals(self.origin);
  foreach(var_2 in self.owner.placed_portals) {
    var_2 notify("death");
  }
}

activate_pap_portals(var_0) {
  var_1 = scripts\engine\utility::getclosest(var_0, level.secretpapstructs);
  var_1.model setscriptablepartstate("portal", "on");
  var_1.var_19 = 1;
  var_1.revealed = 1;
  level.active_pap_portal = var_1;
}

portal_handleuse() {
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

    self playSound("zmb_item_pickup");
    var_0 thread give_portal(0, self.lifespan, self.var_130D2);
    var_0.placed_portals = scripts\engine\utility::array_remove(var_0.placed_portals, self);
    scripts\cp\utility::removefromtraplist();
    self delete();
  }
}

portal_setinactive() {
  self makeunusable();
  scripts\cp\utility::removefromtraplist();
}

portal_wait_for_player() {
  self.owner endon("death");
  self.owner endon("disconnect");
  self endon("death");
  for(;;) {
    if(scripts\engine\utility::istrue(self.owner.teleporting)) {
      while(distancesquared(self.owner.origin, self.origin) < 576) {
        wait(0.1);
      }

      self.owner.teleporting = undefined;
    }

    if(distancesquared(self.owner.origin, self.origin) < 576) {
      self.owner.teleporting = 1;
      self.owner thread teleport_owner(self);
      wait(5);
    }

    wait(0.1);
  }
}

teleport_owner(var_0) {
  var_1 = self.placed_portals;
  foreach(var_3 in self.placed_portals) {
    if(var_3 == var_0) {
      continue;
    } else {
      self playlocalsound("zmb_portal_travel_lr");
      scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
      thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.5);
      playFX(level._effect["portal_player_world"], var_0.origin + (0, 0, 10));
      self setorigin(var_3.origin + (0, 0, 1));
    }
  }
}