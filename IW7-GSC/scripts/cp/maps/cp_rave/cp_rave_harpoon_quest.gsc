/*************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\cp_rave_harpoon_quest.gsc
*************************************************************/

harpoon_quest_init() {
  scripts\engine\utility::flag_init("harpoon_unlocked");
  scripts\engine\utility::flag_init("chains_unlocked");
  level._effect["deer_head_explosion"] = loadfx("vfx\iw7\core\expl\weap\chargeshot\vfx_expl_chargeshot.vfx");
  level._effect["harpoon_symbol_1"] = loadfx("vfx\iw7\levels\cp_rave\vfx_rave_harpoon_symbol_1_facing.vfx");
  level._effect["harpoon_symbol_2"] = loadfx("vfx\iw7\levels\cp_rave\vfx_rave_harpoon_symbol_2_facing.vfx");
  level._effect["harpoon_symbol_3"] = loadfx("vfx\iw7\levels\cp_rave\vfx_rave_harpoon_symbol_3_facing.vfx");
  level._effect["chain_dissolve"] = loadfx("vfx\iw7\levels\cp_rave\vfx_rave_chain_dissolve.vfx");
  level.harpoon_locks = 0;
  level thread break_the_chains();
  level thread collect_bait();
  level thread init_bait_heads();
}

collect_bait() {
  var_0 = scripts\engine\utility::getstruct("bait_loc", "targetname");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  var_1 makeusable();
  var_1 sethintstring(&"CP_RAVE_PICK_UP_BAIT");
  level.bait_model = getent("bait_pickup", "targetname");
  for(;;) {
    var_1 waittill("trigger", var_2);
    var_2.has_bait = 1;
    var_2 thread scripts\cp\utility::usegrenadegesture(var_2, "iw7_pickup_zm");
    var_2 thread scripts\cp\powers\coop_powers::givepower("power_bait", "secondary", undefined, undefined, undefined, 1, 1);
    wait(0.1);
    level.bait_model hidefromplayer(var_2);
  }
}

init_bait_heads() {
  var_0 = getEntArray("bait_head", "targetname");
  foreach(var_2 in var_0) {
    var_2 thread wait_to_be_fed();
  }
}

wait_to_be_fed() {
  thread play_signal_if_bait_nearby();
  thread fly_off_the_handle();
}

turn_on_fx(var_0) {
  wait(var_0);
  self setscriptablepartstate("symbol", "on");
}

play_signal_if_bait_nearby() {
  self endon("stop_attacking_player");
  var_0 = 160000;
  while(!isDefined(level.players)) {
    wait(0.1);
  }

  while(level.players.size < 1) {
    wait(0.1);
  }

  for(;;) {
    var_1 = 0;
    foreach(var_3 in level.players) {
      if(var_3 scripts\cp\powers\coop_powers::hasequipment("power_bait")) {
        if(distancesquared(var_3.origin, self.origin) < var_0) {
          self setscriptablepartstate("bait", "active");
          var_1 = 1;
          break;
        }
      }
    }

    if(!var_1) {
      self setscriptablepartstate("bait", "inactive");
    }

    wait(1);
  }
}

fly_off_the_handle() {
  wait(5);
  thread listen_for_damage();
  head_logic();
  self setscriptablepartstate("head", "explode");
  wait(0.1);
  self setModel("tag_origin");
  playFXOnTag(level._effect["harpoon_symbol_1"], self, "tag_origin");
  var_0 = scripts\engine\utility::getstructarray("bait_head_end_spot", "targetname");
  var_1 = scripts\engine\utility::getclosest(self.origin, var_0, 500);
  self moveto(var_1.origin, 2);
  self waittill("movedone");
  self makeusable();
  self ghost_killed_update_func((100000, 100000, 0), 10000);
  self waittill("trigger", var_2);
  var_2.symbol_picked_up = 1;
  level.harpoon_locks++;
  var_2 playSound("part_pickup");
  switch (level.harpoon_locks) {
    case 1:
      level scripts\cp\utility::set_quest_icon(1);
      remove_rave_lock();
      break;

    case 2:
      level scripts\cp\utility::set_quest_icon(3);
      remove_rave_lock();
      break;

    case 3:
      level scripts\cp\utility::set_quest_icon(4);
      remove_rave_lock();
      break;
  }

  wait_for_key_pickup();
  self delete();
}

remove_rave_lock() {
  foreach(var_1 in level.lock_spots) {
    if(isDefined(var_1)) {
      var_1 delete();
      break;
    }
  }
}

face_enemy(var_0) {
  for(;;) {
    if(!self.head isenemyinfrontofme(var_0, 0.9, (0, 90, 0))) {
      if(self.head isenemyrightofme(var_0, (0, 115, 0))) {
        self rotateyaw(self.angles[2] + 10, 0.15, 0.05, 0.05);
      } else {
        self rotateyaw(self.angles[2] - 10, 0.15, 0.05, 0.05);
      }
    } else {
      break;
    }

    wait(0.15);
  }
}

isenemyinfrontofme(var_0, var_1, var_2) {
  var_3 = vectornormalize(var_0.origin - self.origin * (1, 1, 0));
  var_4 = anglestoright(self.angles + var_2);
  var_5 = vectordot(var_3, var_4);
  return var_5 > var_1;
}

isenemyrightofme(var_0, var_1) {
  var_2 = vectornormalize(var_0.origin - self.origin * (1, 1, 0));
  var_3 = anglesToForward(self.angles + var_1);
  var_4 = vectordot(var_2, var_3);
  return var_4 > 0;
}

listen_for_bait_throw() {
  self endon("disconnect");
  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    if(isDefined(var_0) && isDefined(var_1)) {
      var_0 thread wait_for_impact(var_1, self);
    }
  }
}

wait_for_impact(var_0, var_1) {
  if(!isDefined(self.weapon_name) || self.weapon_name != "iw7_bait_zm") {
    return;
  }

  self waittill("explode", var_2);
  var_3 = getEntArray("bait_head", "targetname");
  var_4 = scripts\engine\utility::getclosest(var_2, var_3, 500);
  if(isDefined(var_4)) {
    if(isDefined(var_4.bait)) {
      var_4.bait delete();
    }

    var_4.anchor.bait = spawn("script_origin", var_2);
    var_4.anchor.bait_time = gettime();
  }
}

head_logic() {
  self endon("stop_attacking_player");
  self.wall_spot = self.origin;
  self.wall_angles = self.angles;
  self.move_spots = scripts\engine\utility::getstructarray("bait_head_move_spot", "targetname");
  self.bait_spot = undefined;
  self.bait = undefined;
  self.on_wall = 1;
  for(;;) {
    self setscriptablepartstate("audio", "off");
    self waittill("hit_with_bait");
    if(self.on_wall) {
      self setscriptablepartstate("symbol", "on");
      self setscriptablepartstate("bait", "inactive");
      self setscriptablepartstate("audio", "leaving_wall");
      self moveto(self.origin + (10, 0, 0), 0.1);
      wait(0.1);
      self moveto(self.origin + (-20, 0, 0), 0.1);
      wait(0.1);
      self moveto(self.origin + (10, 0, 10), 0.1);
      wait(0.1);
      self moveto(self.origin + (-10, 0, -20), 0.1);
      wait(0.1);
      self.on_wall = 0;
      self setscriptablepartstate("head", "active");
    }

    var_0 = self.bait.origin;
    var_1 = scripts\engine\utility::getclosest(var_0, self.move_spots, 1000);
    self.bait_spot = var_1;
    move_along_path();
    move_back_to_wall();
    self.on_wall = 1;
    self setscriptablepartstate("head", "inactive");
    self setscriptablepartstate("audio", "off");
    wait(0.1);
  }
}

move_to_bait_spot() {
  self moveto(self.bait_spot.origin, 1, 0.25, 0.25);
  self waittill("movedone");
}

move_along_path() {
  self setscriptablepartstate("audio", "flying");
  self moveto(self.bait_spot.origin, 0.5, 0.1, 0.1);
  self waittill("movedone");
  for(var_0 = self.bait_spot; isDefined(var_0.target); var_0 = var_1) {
    var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    self ghost_killed_update_func((0, 720, 0), 2, 0.1, 0.1);
    self moveto(var_1.origin, 2, 0.25, 0.25);
    self waittill("movedone");
  }
}

move_back_to_wall() {
  self setscriptablepartstate("audio", "returning_to_wall");
  self rotateto(self.wall_angles, 0.5);
  self waittill("rotatedone");
  self moveto(self.wall_spot, 1, 0.25, 0.25);
  self waittill("movedone");
  if(isDefined(self.bait)) {
    self.bait delete();
  }
}

get_move_spot() {
  var_0 = scripts\engine\utility::getstructarray("bait_head_move_spot", "targetname");
  var_1 = [];
  foreach(var_3 in var_0) {
    if(!isenemyinfrontofme(var_3, 0.25, (0, 45, 0))) {
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  if(var_1.size > 0) {
    var_5 = scripts\engine\utility::getclosest(self.origin, var_1);
  } else {
    var_5 = scripts\engine\utility::getclosest(self.origin, var_1);
  }

  return var_5.origin;
}

listen_for_damage() {
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    if(!scripts\engine\utility::istrue(var_1.rave_mode)) {
      continue;
    }

    if(var_9 == "iw7_bait_zm") {
      if(self.on_wall) {
        self notify("hit_with_bait");
      }

      wait(0.1);
      continue;
    }

    if(self.on_wall) {
      wait(0.1);
      continue;
    }

    if(!isenemyinfrontofme(var_1, 0.9, (0, 90, 0))) {
      break;
    }
  }

  self notify("stop_attacking_player");
}

listen_for_symbol_press() {}

wait_for_key_pickup() {
  if(level.harpoon_locks > 2) {
    scripts\engine\utility::flag_set("chains_unlocked");
  }
}

spawn_chain_locks() {
  level.lock_spots = [];
  var_0 = scripts\engine\utility::getstructarray("chain_lock", "targetname");
  var_1 = 1;
  foreach(var_3 in var_0) {
    var_4 = spawn("script_model", var_3.origin);
    wait(0.1);
    var_4.angles = var_3.angles + (0, 0, 90);
    wait(0.1);
    var_4 setModel("tag_origin_harpoon_quest_symbol_" + var_1);
    level.lock_spots[level.lock_spots.size] = var_4;
    var_1++;
  }
}

show_hide_symbols() {
  level endon("chains_unlocked");
  while(!isDefined(level.players)) {
    wait(0.1);
  }

  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = scripts\engine\utility::istrue(var_1.rave_mode);
      foreach(var_4 in level.lock_spots) {
        if(var_2) {
          var_4 show();
          continue;
        }

        var_4 hide();
      }
    }

    wait(0.1);
  }
}

break_the_chains() {
  level thread spawn_chain_locks();
  var_0 = getEntArray("harpoon_gun_quest_chains", "targetname");
  scripts\engine\utility::flag_wait("chains_unlocked");
  var_1 = (-332, -1435, 310);
  var_2 = spawn("script_origin", var_1);
  wait(0.1);
  var_2 makeusable();
  var_2 sethintstring(&"CP_RAVE_BREAK_LOCK");
  var_2 waittill("trigger");
  var_3 = spawn("script_model", var_0[0].origin);
  var_3 setModel("tag_origin");
  var_3.angles = var_0[0].angles + (0, 0, 0);
  var_3 playSound("harpoon_cabinet_unlock");
  wait(1);
  playFXOnTag(level._effect["chain_dissolve"], var_3, "tag_origin");
  var_0[0] hide();
  var_2 delete();
  scripts\engine\utility::flag_set("harpoon_unlocked");
}

take_harpoon_weapon() {
  var_0 = getent("harpoon_gun_quest", "targetname");
  var_1 = getent("harpoon_gun_quest_activation_spot", "targetname");
  scripts\engine\utility::flag_wait("harpoon_unlocked");
  var_1 makeusable();
  var_1 sethintstring(&"CP_RAVE_PICKUP_ITEM");
  var_1 waittill("trigger", var_2);
  var_2 giveweapon("iw7_harpoon_zm");
  var_2 switchtoweapon("iw7_harpoon_zm");
  var_0 hide();
}