/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3395.gsc
************************/

purchase_laser_trap(var_0, var_1) {
  var_1.var_8B8B = 1;
  var_1.last_interaction_point = undefined;
  var_1 thread watch_dpad();
  var_1 notify("new_power", "crafted_windowtrap");
  var_1 setclientomnvar("zom_crafted_weapon", 8);
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_windowtrap", ::purchase_laser_trap, var_1);
}

watch_dpad() {
  self endon("disconnect");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self endon("death");
  self notifyonplayercommand("pullout_windowtrap", "+actionslot 3");
  for(;;) {
    self waittill("pullout_windowtrap");
    if(scripts\engine\utility::istrue(self.iscarrying)) {
      continue;
    }

    if(scripts\engine\utility::istrue(self.linked_to_coaster)) {
      continue;
    }

    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }

    var_0 = func_9B93();
    if(var_0 == "has_trap") {
      scripts\cp\utility::setlowermessage("window", &"ZOMBIE_CRAFTING_SOUVENIRS_WINDOW_HAS_TRAP", 4);
      continue;
    } else if(var_0 == "not_window") {
      scripts\cp\utility::setlowermessage("not_window", &"ZOMBIE_CRAFTING_SOUVENIRS_NEAR_WINDOW", 4);
      continue;
    } else {
      break;
    }
  }

  var_1 = undefined;
  if(isDefined(self.last_interaction_point)) {
    var_1 = self.last_interaction_point;
  }

  if(isDefined(self.var_DDB0)) {
    var_1 = self.var_DDB0;
  }

  if(!isDefined(var_1)) {
    return;
  }

  level thread func_CC08(var_1, self);
}

func_9B93() {
  if(isDefined(self.var_DDB0)) {
    return "valid";
  }

  if(!isDefined(self.last_interaction_point) && !isDefined(self.var_DDB0)) {
    return "not_window";
  }

  if(!scripts\cp\cp_interaction::interaction_is_window_entrance(self.last_interaction_point)) {
    return "not_window";
  }

  if(scripts\engine\utility::istrue(self.last_interaction_point.has_trap)) {
    return "has_trap";
  }

  return "valid";
}

func_CC08(var_0, var_1) {
  var_2 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_3 = var_2.angles;
  level thread func_A86F(var_0, var_2, var_1);
  var_1 notify("window_trap_placed");
  if(!isDefined(var_1.var_1193D["crafted_windowtrap"])) {
    var_1.var_1193D["crafted_windowtrap"] = gettime();
  } else {
    var_1.var_1193D["crafted_windowtrap"] = var_1.var_1193D["crafted_windowtrap"] + gettime() - var_1.var_1193D["crafted_windowtrap"];
  }

  var_1.itemtype = "crafted_windowtrap";
  var_1.killswithitem["crafted_windowtrap"] = 0;
  var_0.has_trap = 1;
  var_1.last_interaction_point = undefined;
  scripts\cp\utility::remove_crafted_item_from_inventory(var_1);
}

func_A86F(var_0, var_1, var_2) {
  var_3 = spawn("trigger_radius", var_1.origin, 1, 8, 72);
  var_3 endon("death");
  playsoundatpos(var_1.origin, "trap_laser_activate");
  var_4 = var_1.angles;
  var_3.var_13D73 = spawnfx(level._effect["laser_window_trap"], var_1.origin + (0, 0, -10), anglesToForward(var_4), anglestoup(var_4));
  triggerfx(var_3.var_13D73);
  var_3.var_A86A = scripts\engine\utility::play_loopsound_in_space("trap_laser_lp", var_1.origin);
  var_3 thread func_A870(var_1, var_2, 1, var_0);
  for(;;) {
    var_3 waittill("trigger", var_5);
    if(isplayer(var_5)) {
      continue;
    }

    if(isalive(var_5) && !scripts\engine\utility::istrue(var_5.marked_for_death)) {
      var_5.marked_for_death = 1;
      var_5.trap_killed_by = var_2;
      var_5.is_burning = 1;
      var_5 playSound("trap_laser_damage");
      var_5 thread func_4CDE(var_2, undefined, undefined, var_3);
      var_5 thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(var_5);
    }
  }
}

func_A870(var_0, var_1, var_2, var_3) {
  self endon("death");
  self.triggerportableradarping = var_1;
  var_4 = gettime() + 300000;
  while(gettime() < var_4) {
    wait(1);
  }

  thread func_138EB(var_0, var_1, var_2, var_3);
}

func_138EB(var_0, var_1, var_2, var_3) {
  self playSound("trap_laser_warning");
  wait(1.45);
  self playSound("trap_laser_explode");
  var_3.has_trap = undefined;
  self.var_13D73 delete();
  self.var_A86A delete();
  self stoploopsound();
  self delete();
  var_4 = spawnfx(level.mine_explode, var_0.origin);
  triggerfx(var_4);
  var_4 thread scripts\cp\utility::delayentdelete(1);
  if(var_1 scripts\cp\utility::is_valid_player(1)) {
    radiusdamage(var_0.origin, 512, 100000, 100000, var_1, "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
  } else {
    radiusdamage(var_0.origin, 512, 100000, 100000, level.players[0], "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
  }

  var_0 thread scripts\cp\cp_weapon::grenade_earthquake();
}

func_4CDE(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_3 endon("death");
  if(!isDefined(var_2)) {
    var_2 = min(self.health + 100, 10000);
  }

  if(!isDefined(var_1)) {
    var_1 = 2;
  }

  var_4 = 0;
  var_5 = 6;
  var_6 = var_1 / var_5;
  var_7 = var_2 / var_5;
  var_0.itemtype = "crafted_windowtrap";
  for(var_8 = 0; var_8 < var_5; var_8++) {
    wait(var_6);
    if(isalive(self)) {
      if(isDefined(var_3.triggerportableradarping) && var_3.triggerportableradarping scripts\cp\utility::is_valid_player(1)) {
        self dodamage(var_7, self.origin, level.players[0], level.players[0], "MOD_UNKNOWN", "zmb_imsprojectile_mp");
        continue;
      }

      self dodamage(var_7, self.origin, level.players[0], level.players[0], "MOD_UNKNOWN", "zmb_imsprojectile_mp");
    }
  }

  wait(2);
  self.is_burning = undefined;
}