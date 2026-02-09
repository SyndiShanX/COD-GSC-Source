/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3117.gsc
*********************************************/

initzombieghost(var_0) {
  self.bisghost = 1;
  self.animplaybackrate = 1;
  self.currentanimstate = undefined;
  self.currentanimindex = undefined;
  self gib_fx_override("noclip");
  self ghostskulls_total_waves(99999999);
  self scragentsetscripted(1);
  setghostnavmode("hover");
  thread scripts\asm\zombie_ghost\zombie_ghost_asm::zombieghost_constantanglesadjust();
  return level.success;
}

ghostlaunched(var_0) {
  if(getghostnavmode() == "launched") {
    if(ghostshouldexplode(self)) {
      ghostexplode(self, self.player_entangled_by, getghostdetonateexplosionrange());
    }

    return level.running;
  }

  return level.failure;
}

ghostentangled(var_0) {
  if(getghostnavmode() == "entangled") {
    if(isDefined(self.player_entangled_by) && !scripts\cp\cp_laststand::player_in_laststand(self.player_entangled_by) && self.player_entangled_by attackbuttonpressed()) {
      var_1 = self.player_entangled_by;
      var_2 = anglesToForward(self.player_entangled_by getplayerangles());
      var_3 = var_1.origin + (0, 0, 5);
      var_4 = var_3 + var_2 * get_ghost_entangled_dist_from_player();
      var_5 = bulletTrace(var_3, var_4, 0, var_1)["position"];
      if(distancesquared(self.origin, var_5) < 360000) {
        var_6 = var_5;
      } else {
        var_7 = vectornormalize(var_6 - self.origin);
        var_6 = self.origin + var_7 * 600;
      }

      self setorigin(var_6, 0);
      self.ghost_target_position = var_1.origin;
      scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::update_entangler_progress(var_1, self);
      return level.success;
    } else {
      launchedawayfromplayer(self);
      return level.running;
    }
  }

  return level.failure;
}

get_ghost_entangled_dist_from_player() {
  return 175;
}

ghosthover(var_0) {
  if(getghostnavmode() == "hover") {
    clearhidenode();
    scripts\asm\asm_bb::bb_requestmovetype("fly");
    if(!isDefined(self.ghost_hover_node)) {
      self.ghost_hover_node = scripts\engine\utility::getclosest(self.origin, level.zombie_ghost_hover_nodes);
      self.ghost_target_position = self.ghost_hover_node.origin;
      return level.success;
    }

    if(distancesquared(self.ghost_hover_node.origin, self.origin) < 4096) {
      self notify("ghost_reached_hover_node");
      var_1 = scripts\engine\utility::array_remove(level.zombie_ghost_hover_nodes, self.ghost_hover_node);
      var_2 = getaliveenemies();
      if(var_2.size > 0) {
        var_3 = scripts\engine\utility::random(var_2).origin;
      } else {
        var_3 = self.origin;
      }

      self.ghost_hover_node = getrandomhovernodesaroundtargetpos(var_3, var_1);
      self.ghost_target_position = self.ghost_hover_node.origin;
    }

    return level.success;
  }

  return level.failure;
}

ghosthide(var_0) {
  if(getghostnavmode() == "hide") {
    clearhovernode();
    scripts\asm\asm_bb::bb_requestmovetype("fly");
    if(!isDefined(self.ghost_hide_node)) {
      self.ghost_hide_node = scripts\engine\utility::getclosest(self.origin, level.zombie_ghost_hide_nodes);
      self.ghost_target_position = self.ghost_hide_node.origin;
      return level.success;
    }

    if(distancesquared(self.ghost_hide_node.origin, self.origin) < 1024) {
      self notify("ghost_reached_hide_node");
      self.ghost_hide_node = scripts\engine\utility::getstruct(self.ghost_hide_node.target, "targetname");
      self.ghost_target_position = self.ghost_hide_node.origin;
    }

    return level.success;
  }

  return level.failure;
}

checkattack(var_0) {
  scripts\asm\asm_bb::bb_clearmeleerequest();
  if(!getghostnavmode() == "attack") {
    return level.failure;
  }

  if(self.precacheleaderboards) {
    return level.failure;
  }

  if(!isDefined(self.zombie_ghost_target)) {
    return level.failure;
  }

  if(!scripts\cp\utility::isreallyalive(self.zombie_ghost_target)) {
    return level.failure;
  }

  if(isDefined(self.zombie_ghost_target.ignoreme) && self.zombie_ghost_target.ignoreme == 1) {
    return level.failure;
  }

  if(self.aistate == "melee" || scripts\mp\agents\_scriptedagents::isstatelocked()) {
    return level.failure;
  }

  if(distancesquared(self.zombie_ghost_target.origin, self.origin) > 9216) {
    return level.failure;
  }

  scripts\asm\asm_bb::bb_requestmelee(self.zombie_ghost_target);
  return level.failure;
}

chaseenemy(var_0) {
  if(!getghostnavmode() == "attack") {
    return level.failure;
  }

  if(self.precacheleaderboards) {
    self.curmeleetarget = undefined;
    return level.failure;
  }

  if(!isDefined(self.zombie_ghost_target)) {
    return level.failure;
  }

  if(distancesquared(self.zombie_ghost_target.origin, self.origin) > 147456) {
    return level.failure;
  }

  self.ghost_target_position = self.zombie_ghost_target.origin;
  try_request_fly_type();
  return level.success;
}

seekenemy(var_0) {
  if(!getghostnavmode() == "attack") {
    return level.failure;
  }

  if(isDefined(self.dontseekenemies)) {
    return level.failure;
  }

  if(!isDefined(self.zombie_ghost_target)) {
    return level.failure;
  }

  self.ghost_target_position = self.zombie_ghost_target.origin;
  try_request_fly_type(1024);
  return level.failure;
}

ghostattack(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("ghost_stop_attack");
  level endon("game_ended");
  var_1 ghostattack_internal(var_0);
  var_2 = get_min_num_of_attacks();
  var_3 = get_max_num_of_attacks();
  var_4 = randomintrange(get_min_num_of_attacks(), get_max_num_of_attacks() + 1);
  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_1 waittill("ghost_played_melee_anim");
  }

  if(isDefined(var_0)) {
    var_0.num_of_ghosts_attacking_me--;
  }

  var_1 scripts\asm\asm_bb::bb_clearmeleerequest();
  var_1 clearhovernode();
  var_1 setghostnavmode("hover");
  var_1 waittill("ghost_reached_hover_node");
  var_1 updateghostanimplaybackrate(1);
}

get_min_num_of_attacks() {
  return 1;
}

get_max_num_of_attacks() {
  return 1;
}

ghostattack_internal(var_0) {
  setghosttarget(var_0);
  setghostnavmode("attack");
  updateghostanimplaybackrate(2.5);
}

setghosttarget(var_0) {
  self.zombie_ghost_target = var_0;
  self.ghost_target_position = var_0.origin;
}

getaliveenemies() {
  var_0 = [];
  foreach(var_2 in level.players) {
    if(var_2.ignoreme || isDefined(var_2.owner) && var_2.owner.ignoreme) {
      continue;
    }

    if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_2)) {
      continue;
    }

    if(!isalive(var_2)) {
      continue;
    }

    var_0[var_0.size] = var_2;
  }

  return var_0;
}

try_request_fly_type(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(isDefined(self.ghost_target_position) && distancesquared(self.ghost_target_position, self.origin) > var_0) {
    scripts\asm\asm_bb::bb_requestmovetype("fly");
    return;
  }

  scripts\asm\asm_bb::bb_requestmovetype("");
}

entangleghost(var_0, var_1) {
  var_0 notify("ghost_stop_attack");
  var_1.ghost_in_entanglement = var_0;
  var_0.player_entangled_by = var_1;
  var_0 setisentangled(var_0, 1);
  var_0 setghostnavmode("entangled");
  var_0 clearhidenode();
  var_0 clearhovernode();
  var_0 updateghostanimplaybackrate(1);
  var_0 scripts\asm\asm_bb::bb_requestmovetype("entangled");
  var_0 scripts\asm\asm_bb::bb_clearmeleerequest();
  var_0 setmisttrailscriptable("off", var_0);
  if(isDefined(level.fbd) && isDefined(level.fbd.fightstarted) && level.fbd.fightstarted) {
    var_0 setscriptablepartstate("soul", "captured");
  }
}

escapefromentanglement(var_0) {
  var_0 updateghostanimplaybackrate(1);
  var_0 setisentangled(var_0, 0);
  var_0 setghostnavmode("hover");
  var_0 scripts\asm\asm_bb::bb_requestmovetype("fly");
  var_0 setbeingentangledscriptable("off", var_0);
  var_0 setmisttrailscriptable("active", var_0);
}

launchedawayfromplayer(var_0) {
  level thread launchfakeghost(var_0.origin, var_0.angles, var_0.color, var_0.player_entangled_by);
  var_0.nocorpse = 1;
  var_0 suicide();
}

launchfakeghost(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_3 endon("disconnect");
  var_3.ghost_in_entanglement = undefined;
  var_4 = spawn("script_model", var_0);
  var_4.angles = vectortoangles(var_1);
  var_4.color = get_fake_ghost_color(var_2);
  var_4 setModel(get_fake_ghost_model(var_4.color));
  var_4 setscriptablepartstate("animation", "on");
  if(isDefined(var_3)) {
    var_5 = anglesToForward(var_3 getplayerangles());
  } else {
    var_5 = (0, 0, 1);
  }

  var_5 = var_5 * 9000;
  var_4 physicslaunchserver(var_4.origin, var_5);
  var_4 physics_registerforcollisioncallback();
  if(isDefined(level.fbd) && isDefined(level.fbd.fightstarted) && level.fbd.fightstarted) {
    thread[[level.fbd.soulprojectilemonitorfunc]](var_4, var_3);
    thread[[level.fbd.soulprojectiledeathfunc]](var_4);
  }

  var_4 thread physics_callback_monitor(var_4, var_3);
}

get_fake_ghost_color(var_0) {
  return var_0;
}

get_fake_ghost_model(var_0) {
  if(isDefined(level.get_fake_ghost_model_func)) {
    return [[level.get_fake_ghost_model_func]](var_0);
  }

  return "fake_zombie_ghost_" + var_0;
}

physics_callback_monitor(var_0, var_1) {
  var_0 endon("death");
  var_0 waittill("collision", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  if(isDefined(level.fbd) && isDefined(level.fbd.fightstarted) && level.fbd.fightstarted) {
    var_10 = var_0 gettagorigin("j_spine4");
    playFX(level._effect["flying_soul_hit_fail"], var_10, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  }

  fake_ghost_explode(var_0, var_1, getghostimpactexplosionrange());
}

fake_ghost_explode(var_0, var_1, var_2) {
  if(isDefined(level.fbd) && isDefined(level.fbd.fightstarted) && level.fbd.fightstarted) {
    var_0 delete();
    return;
  }

  ghostexplosionradiusdamage(var_0, var_1, var_2);
  playFX(level._effect["ghost_explosion_death_" + get_exp_vfx_color(var_0.color)], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  var_0 setscriptablepartstate("animation", "off");
  var_0 delete();
}

get_exp_vfx_color(var_0) {
  if(issubstr(var_0, "bomb")) {
    return strtok(var_0, "_")[0];
  }

  return var_0;
}

ghostshouldexplode(var_0) {
  if(isDefined(var_0.player_entangled_by) && var_0.player_entangled_by secondaryoffhandbuttonpressed()) {
    return 1;
  }

  if(gettime() - var_0.start_being_launched > 5000) {
    return 1;
  }

  return 0;
}

ghostexplode(var_0, var_1, var_2) {
  playghostexplosionvfx(var_0);
  ghostexplosionradiusdamage(var_0, var_1, var_2);
  var_0.nocorpse = 1;
  var_0 suicide();
}

ghostexplosionradiusdamage(var_0, var_1, var_2) {
  var_3 = getclosestactivemovingtargetwithinrange(var_0, var_2);
  if(isPlayer(var_1)) {
    if(isDefined(var_3)) {
      var_1 thread scripts\cp\cp_damage::updatedamagefeedback("hitcritical");
      if([[level.should_moving_target_explode]](var_0, var_3)) {
        if(isDefined(level.process_player_gns_combo_func)) {
          [[level.process_player_gns_combo_func]](var_1, var_3);
        }

        process_moving_target_hit(var_3, var_1, var_0);
        return;
      }

      if(isDefined(level.hit_wrong_moving_target_func)) {
        [[level.hit_wrong_moving_target_func]](var_1, var_3, var_0);
        return;
      }

      return;
    }

    if(isDefined(level.process_player_gns_combo_func)) {
      [[level.process_player_gns_combo_func]](var_1, var_3);
      return;
    }
  }
}

process_moving_target_hit(var_0, var_1, var_2) {
  if(isDefined(level.process_moving_target_hit_func)) {
    [[level.process_moving_target_hit_func]](var_0, var_1, var_2);
    return;
  }

  remove_moving_target_default(var_0, var_1);
}

remove_moving_target_default(var_0, var_1) {
  remove_moving_target(var_0, var_1);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::increment_alien_head_destroyed_count(var_1);
}

remove_moving_target(var_0, var_1) {
  var_0 setscriptablepartstate("skull_vfx", "off");
  var_0 delete();
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("killfirm_ghost", "zmb_comment_vo", "highest", 10, 0, 0, 1, 10);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::purge_undefined_from_moving_target_array();
}

getclosestactivemovingtargetwithinrange(var_0, var_1) {
  if(!isDefined(level.moving_target_groups)) {
    return undefined;
  }

  var_2 = [];
  foreach(var_4 in level.moving_target_groups) {
    foreach(var_6 in var_4) {
      if(!isDefined(var_6)) {
        continue;
      }

      if(distancesquared(var_0.origin, var_6.origin) < var_1) {
        var_2[var_2.size] = var_6;
      }
    }
  }

  var_9 = sortbydistance(var_2, var_0.origin);
  return var_9[0];
}

getactiveghostswithinrange(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in level.zombie_ghosts) {
    if(var_4 == var_0) {
      continue;
    }

    if(isentangled(var_4)) {
      continue;
    }

    if(distancesquared(var_0.origin, var_4.origin) < var_1) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

getghostdetonateexplosionrange() {
  return -25536;
}

getghostimpactexplosionrange() {
  return 7225;
}

setisentangled(var_0, var_1) {
  var_0.is_entangled = var_1;
}

isentangled(var_0) {
  return scripts\engine\utility::istrue(var_0.is_entangled);
}

notargetfound(var_0) {
  return level.failure;
}

setghostnavmode(var_0) {
  self.ghost_nav_mode = var_0;
}

getghostnavmode() {
  return self.ghost_nav_mode;
}

clearhidenode() {
  self.ghost_hide_node = undefined;
}

clearhovernode() {
  self.ghost_hover_node = undefined;
}

updateghostanimplaybackrate(var_0) {
  if(!isDefined(self.currentanimstate)) {
    return;
  }

  if(!isDefined(self.currentanimindex)) {
    return;
  }

  self.animplaybackrate = var_0;
  self setanimstate(self.currentanimstate, self.currentanimindex, self.animplaybackrate);
}

setbeingentangledscriptable(var_0, var_1) {
  var_1 setscriptablepartstate("being_entangled", var_0);
}

setmisttrailscriptable(var_0, var_1) {
  var_1 setscriptablepartstate("mist_trail", var_0);
}

getrandomhovernodesaroundtargetpos(var_0, var_1) {
  var_2 = 4;
  var_3 = sortbydistance(var_1, var_0);
  var_4 = scripts\engine\utility::ter_op(var_3.size > var_2, var_2, var_3.size);
  var_5 = randomint(var_4);
  return var_3[var_5];
}

playghostexplosionvfx(var_0) {
  var_1 = vectornormalize(var_0.var_381);
  if(var_1 == (0, 0, 0)) {
    var_1 = (0, 0, 1);
  }

  var_2 = vectortoangles(var_1);
  playFX(level._effect["ghost_explosion_death"], var_0.origin, var_1, anglestoup(var_2));
}