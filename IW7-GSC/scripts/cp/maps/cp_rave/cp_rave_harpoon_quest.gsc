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
  var_00 = scripts\engine\utility::getstruct("bait_loc", "targetname");
  var_01 = spawn("script_model", var_00.origin);
  var_01 setModel("tag_origin");
  var_01 makeusable();
  var_01 sethintstring( & "CP_RAVE_PICK_UP_BAIT");
  level.bait_model = getent("bait_pickup", "targetname");
  for(;;) {
    var_01 waittill("trigger", var_02);
    var_02.has_bait = 1;
    var_02 thread scripts\cp\utility::usegrenadegesture(var_02, "iw7_pickup_zm");
    var_02 thread scripts\cp\powers\coop_powers::givepower("power_bait", "secondary", undefined, undefined, undefined, 1, 1);
    wait(0.1);
    level.bait_model hidefromplayer(var_02);
  }
}

init_bait_heads() {
  var_00 = getEntArray("bait_head", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread wait_to_be_fed();
  }
}

wait_to_be_fed() {
  thread play_signal_if_bait_nearby();
  thread fly_off_the_handle();
}

turn_on_fx(param_00) {
  wait(param_00);
  self setscriptablepartstate("symbol", "on");
}

play_signal_if_bait_nearby() {
  self endon("stop_attacking_player");
  var_00 = 160000;
  while(!isDefined(level.players)) {
    wait(0.1);
  }

  while(level.players.size < 1) {
    wait(0.1);
  }

  for(;;) {
    var_01 = 0;
    foreach(var_03 in level.players) {
      if(var_03 scripts\cp\powers\coop_powers::hasequipment("power_bait")) {
        if(distancesquared(var_03.origin, self.origin) < var_00) {
          self setscriptablepartstate("bait", "active");
          var_01 = 1;
          break;
        }
      }
    }

    if(!var_01) {
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
  var_00 = scripts\engine\utility::getstructarray("bait_head_end_spot", "targetname");
  var_01 = scripts\engine\utility::getclosest(self.origin, var_00, 500);
  self moveto(var_01.origin, 2);
  self waittill("movedone");
  self makeusable();
  self ghost_killed_update_func((100000, 100000, 0), 10000);
  self waittill("trigger", var_02);
  var_02.symbol_picked_up = 1;
  level.harpoon_locks++;
  var_02 playSound("part_pickup");
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
  foreach(var_01 in level.lock_spots) {
    if(isDefined(var_01)) {
      var_01 delete();
      break;
    }
  }
}

face_enemy(param_00) {
  for(;;) {
    if(!self.head isenemyinfrontofme(param_00, 0.9, (0, 90, 0))) {
      if(self.head isenemyrightofme(param_00, (0, 115, 0))) {
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

isenemyinfrontofme(param_00, param_01, param_02) {
  var_03 = vectornormalize(param_00.origin - self.origin * (1, 1, 0));
  var_04 = anglestoright(self.angles + param_02);
  var_05 = vectordot(var_03, var_04);
  return var_05 > param_01;
}

isenemyrightofme(param_00, param_01) {
  var_02 = vectornormalize(param_00.origin - self.origin * (1, 1, 0));
  var_03 = anglesToForward(self.angles + param_01);
  var_04 = vectordot(var_02, var_03);
  return var_04 > 0;
}

listen_for_bait_throw() {
  self endon("disconnect");
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    if(isDefined(var_00) && isDefined(var_01)) {
      var_00 thread wait_for_impact(var_01, self);
    }
  }
}

wait_for_impact(param_00, param_01) {
  if(!isDefined(self.weapon_name) || self.weapon_name != "iw7_bait_zm") {
    return;
  }

  self waittill("explode", var_02);
  var_03 = getEntArray("bait_head", "targetname");
  var_04 = scripts\engine\utility::getclosest(var_02, var_03, 500);
  if(isDefined(var_04)) {
    if(isDefined(var_04.bait)) {
      var_04.bait delete();
    }

    var_04.anchor.bait = spawn("script_origin", var_02);
    var_04.anchor.bait_time = gettime();
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

    var_00 = self.bait.origin;
    var_01 = scripts\engine\utility::getclosest(var_00, self.move_spots, 1000);
    self.bait_spot = var_01;
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
  for(var_00 = self.bait_spot; isDefined(var_00.target); var_00 = var_01) {
    var_01 = scripts\engine\utility::getstruct(var_00.target, "targetname");
    self ghost_killed_update_func((0, 720, 0), 2, 0.1, 0.1);
    self moveto(var_01.origin, 2, 0.25, 0.25);
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
  var_00 = scripts\engine\utility::getstructarray("bait_head_move_spot", "targetname");
  var_01 = [];
  foreach(var_03 in var_00) {
    if(!isenemyinfrontofme(var_03, 0.25, (0, 45, 0))) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  if(var_01.size > 0) {
    var_05 = scripts\engine\utility::getclosest(self.origin, var_01);
  } else {
    var_05 = scripts\engine\utility::getclosest(self.origin, var_01);
  }

  return var_05.origin;
}

listen_for_damage() {
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(!scripts\engine\utility::istrue(var_01.rave_mode)) {
      continue;
    }

    if(var_09 == "iw7_bait_zm") {
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

    if(!isenemyinfrontofme(var_01, 0.9, (0, 90, 0))) {
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
  var_00 = scripts\engine\utility::getstructarray("chain_lock", "targetname");
  var_01 = 1;
  foreach(var_03 in var_00) {
    var_04 = spawn("script_model", var_03.origin);
    wait(0.1);
    var_04.angles = var_03.angles + (0, 0, 90);
    wait(0.1);
    var_04 setModel("tag_origin_harpoon_quest_symbol_" + var_01);
    level.lock_spots[level.lock_spots.size] = var_04;
    var_01++;
  }
}

show_hide_symbols() {
  level endon("chains_unlocked");
  while(!isDefined(level.players)) {
    wait(0.1);
  }

  for(;;) {
    foreach(var_01 in level.players) {
      var_02 = scripts\engine\utility::istrue(var_01.rave_mode);
      foreach(var_04 in level.lock_spots) {
        if(var_02) {
          var_04 show();
          continue;
        }

        var_04 hide();
      }
    }

    wait(0.1);
  }
}

break_the_chains() {
  level thread spawn_chain_locks();
  var_00 = getEntArray("harpoon_gun_quest_chains", "targetname");
  scripts\engine\utility::flag_wait("chains_unlocked");
  var_01 = (-332, -1435, 310);
  var_02 = spawn("script_origin", var_01);
  wait(0.1);
  var_02 makeusable();
  var_02 sethintstring( & "CP_RAVE_BREAK_LOCK");
  var_02 waittill("trigger");
  var_03 = spawn("script_model", var_00[0].origin);
  var_03 setModel("tag_origin");
  var_03.angles = var_00[0].angles + (0, 0, 0);
  var_03 playSound("harpoon_cabinet_unlock");
  wait(1);
  playFXOnTag(level._effect["chain_dissolve"], var_03, "tag_origin");
  var_00[0] hide();
  var_02 delete();
  scripts\engine\utility::flag_set("harpoon_unlocked");
}

take_harpoon_weapon() {
  var_00 = getent("harpoon_gun_quest", "targetname");
  var_01 = getent("harpoon_gun_quest_activation_spot", "targetname");
  scripts\engine\utility::flag_wait("harpoon_unlocked");
  var_01 makeusable();
  var_01 sethintstring( & "CP_RAVE_PICKUP_ITEM");
  var_01 waittill("trigger", var_02);
  var_02 giveweapon("iw7_harpoon_zm");
  var_02 switchtoweapon("iw7_harpoon_zm");
  var_00 hide();
}