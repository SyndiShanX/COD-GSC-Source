/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3395.gsc
************************/

purchase_laser_trap(param_00, param_01) {
  param_01.var_8B8B = 1;
  param_01.last_interaction_point = undefined;
  param_01 thread watch_dpad();
  param_01 notify("new_power", "crafted_windowtrap");
  param_01 setclientomnvar("zom_crafted_weapon", 8);
  param_01 thread scripts\cp\utility::usegrenadegesture(param_01, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_windowtrap", ::purchase_laser_trap, param_01);
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

    var_00 = func_9B93();
    if(var_00 == "has_trap") {
      scripts\cp\utility::setlowermessage("window", & "ZOMBIE_CRAFTING_SOUVENIRS_WINDOW_HAS_TRAP", 4);
      continue;
    } else if(var_00 == "not_window") {
      scripts\cp\utility::setlowermessage("not_window", & "ZOMBIE_CRAFTING_SOUVENIRS_NEAR_WINDOW", 4);
      continue;
    } else {
      break;
    }
  }

  var_01 = undefined;
  if(isDefined(self.last_interaction_point)) {
    var_01 = self.last_interaction_point;
  }

  if(isDefined(self.var_DDB0)) {
    var_01 = self.var_DDB0;
  }

  if(!isDefined(var_01)) {
    return;
  }

  level thread func_CC08(var_01, self);
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

func_CC08(param_00, param_01) {
  var_02 = scripts\engine\utility::getstruct(param_00.target, "targetname");
  var_03 = var_02.angles;
  level thread func_A86F(param_00, var_02, param_01);
  param_01 notify("window_trap_placed");
  if(!isDefined(param_01.var_1193D["crafted_windowtrap"])) {
    param_01.var_1193D["crafted_windowtrap"] = gettime();
  } else {
    param_01.var_1193D["crafted_windowtrap"] = param_01.var_1193D["crafted_windowtrap"] + gettime() - param_01.var_1193D["crafted_windowtrap"];
  }

  param_01.itemtype = "crafted_windowtrap";
  param_01.killswithitem["crafted_windowtrap"] = 0;
  param_00.has_trap = 1;
  param_01.last_interaction_point = undefined;
  scripts\cp\utility::remove_crafted_item_from_inventory(param_01);
}

func_A86F(param_00, param_01, param_02) {
  var_03 = spawn("trigger_radius", param_01.origin, 1, 8, 72);
  var_03 endon("death");
  playsoundatpos(param_01.origin, "trap_laser_activate");
  var_04 = param_01.angles;
  var_03.var_13D73 = spawnfx(level._effect["laser_window_trap"], param_01.origin + (0, 0, -10), anglesToForward(var_04), anglestoup(var_04));
  triggerfx(var_03.var_13D73);
  var_03.var_A86A = scripts\engine\utility::play_loopsound_in_space("trap_laser_lp", param_01.origin);
  var_03 thread func_A870(param_01, param_02, 1, param_00);
  for(;;) {
    var_03 waittill("trigger", var_05);
    if(isplayer(var_05)) {
      continue;
    }

    if(isalive(var_05) && !scripts\engine\utility::istrue(var_05.marked_for_death)) {
      var_05.marked_for_death = 1;
      var_05.trap_killed_by = param_02;
      var_05.is_burning = 1;
      var_05 playSound("trap_laser_damage");
      var_05 thread func_4CDE(param_02, undefined, undefined, var_03);
      var_05 thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(var_05);
    }
  }
}

func_A870(param_00, param_01, param_02, param_03) {
  self endon("death");
  self.triggerportableradarping = param_01;
  var_04 = gettime() + 300000;
  while(gettime() < var_04) {
    wait(1);
  }

  thread func_138EB(param_00, param_01, param_02, param_03);
}

func_138EB(param_00, param_01, param_02, param_03) {
  self playSound("trap_laser_warning");
  wait(1.45);
  self playSound("trap_laser_explode");
  param_03.has_trap = undefined;
  self.var_13D73 delete();
  self.var_A86A delete();
  self stoploopsound();
  self delete();
  var_04 = spawnfx(level.mine_explode, param_00.origin);
  triggerfx(var_04);
  var_04 thread scripts\cp\utility::delayentdelete(1);
  if(param_01 scripts\cp\utility::is_valid_player(1)) {
    radiusdamage(param_00.origin, 512, 100000, 100000, param_01, "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
  } else {
    radiusdamage(param_00.origin, 512, 100000, 100000, level.players[0], "MOD_EXPLOSIVE", "zmb_imsprojectile_mp");
  }

  param_00 thread scripts\cp\cp_weapon::grenade_earthquake();
}

func_4CDE(param_00, param_01, param_02, param_03) {
  self endon("death");
  param_03 endon("death");
  if(!isDefined(param_02)) {
    param_02 = min(self.health + 100, 10000);
  }

  if(!isDefined(param_01)) {
    param_01 = 2;
  }

  var_04 = 0;
  var_05 = 6;
  var_06 = param_01 / var_05;
  var_07 = param_02 / var_05;
  param_00.itemtype = "crafted_windowtrap";
  for(var_08 = 0; var_08 < var_05; var_08++) {
    wait(var_06);
    if(isalive(self)) {
      if(isDefined(param_03.triggerportableradarping) && param_03.triggerportableradarping scripts\cp\utility::is_valid_player(1)) {
        self dodamage(var_07, self.origin, level.players[0], level.players[0], "MOD_UNKNOWN", "zmb_imsprojectile_mp");
        continue;
      }

      self dodamage(var_07, self.origin, level.players[0], level.players[0], "MOD_UNKNOWN", "zmb_imsprojectile_mp");
    }
  }

  wait(2);
  self.is_burning = undefined;
}