/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier_code_zodiac.gsc
****************************************/

#using_animtree("vehicles");

init_zodiacs() {
  level.vttype = "zodiac_iw6";
  level.vtmodel = "vehicle_zodiac_boat_fed_iw6";
  level.vtclassname = "script_vehicle_zodiac_iw6";
  maps\_vehicle::build_aianims(maps\carrier_anim::set_zodiac_override_anims, vehicle_scripts\_zodiac::set_vehicle_anims);
  maps\_vehicle::build_drive( % carrier_rappel_defend_zodiac_moving, % carrier_rappel_defend_zodiac_moving, 20);
  zodiac_aianimthread_setup();
  level.max_zodiacs = 30;
}

zodiac_aianimthread_setup() {
  level.vehicle_aianimthread["attack"] = ::rider_attack;
  level.vehicle_aianimcheck["attack"] = ::rider_attack_check;
}

run_corpse_cleanup() {
  level endon("knockdown_moment");

  for(;;) {
    foreach(var_1 in getcorpsearray()) {
      if(isDefined(var_1)) {
        var_2 = undefined;

        foreach(var_4 in level.corpse_entnums) {
          if(var_4 == var_1 getentitynumber()) {
            var_2 = var_4;
            break;
          }
        }

        if(!isDefined(var_1.removetime) && isDefined(var_2)) {
          level.corpse_entnums = common_scripts\utility::array_remove(level.corpse_entnums, var_2);
          var_1 setcorpseremovetimer(3);
          var_1.removetime = 3;
        }
      }
    }

    wait 0.05;
  }
}

clear_all_corpses() {
  level.corpse_entnums = [];
  clearallcorpses();
}

monitor_zodiac_count() {
  level endon("defend_zodiac_finished");

  for(;;) {
    level.zodiacs = maps\_utility::array_removedead(level.zodiacs);

    for(level.zodiacs = sortbydistance(level.zodiacs, level.player.origin); level.zodiacs.size > 30; level.zodiacs = common_scripts\utility::array_remove(level.zodiacs, var_0)) {
      var_0 = get_furthest_zodiac();
      maps\_utility::deleteent(var_0);
    }

    wait 0.5;
  }
}

get_furthest_zodiac() {
  return level.zodiacs[level.zodiacs.size - 1];
}

spawn_zodiacs(var_0, var_1, var_2, var_3, var_4) {
  foreach(var_6 in level.zodiacs) {
    if(isalive(var_6) && isDefined(var_6.saved_targetname) && var_6.saved_targetname == var_0)
      return;
  }

  if(maps\carrier_code::eval(var_1) && !maps\carrier_code::eval(var_4)) {
    var_8 = maps\_utility::getvehiclespawnerarray(var_0);
    var_9 = cos(getdvarfloat("cg_fov"));

    foreach(var_11 in var_8) {
      if(maps\_utility::within_fov_of_players(var_11.origin, var_9))
        return;
    }
  }

  level.zodiacs = maps\_utility::array_removedead(level.zodiacs);

  if(level.zodiacs.size > 30 && !maps\carrier_code::eval(var_4)) {
    return;
  }
  maps\_utility::array_spawn_function_targetname(var_0, ::zodiac_teleport_logic);
  maps\_utility::array_spawn_function_targetname(var_0, maps\carrier_code::setup_target_on_vehicle);
  maps\_utility::array_spawn_function_targetname(var_0, ::zodiac_setup);
  var_13 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive(var_0);

  foreach(var_6 in var_13) {
    var_6.saved_targetname = var_0;
    level.zodiacs = common_scripts\utility::array_add(level.zodiacs, var_6);
  }

  if(maps\carrier_code::eval(var_2))
    thread loop_zodiacs(var_0, var_13, var_3);

  return var_13;
}

loop_zodiacs(var_0, var_1, var_2) {
  level endon("defend_zodiac_finished");
  level endon(var_2);
  level.player endon(var_2);

  for(;;) {
    var_1 waittill_array_dead();
    wait 5;
    var_1 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive(var_0);

    foreach(var_4 in var_1) {
      var_4.saved_targetname = var_0;
      level.zodiacs = common_scripts\utility::array_add(level.zodiacs, var_4);
    }
  }
}

waittill_array_dead() {
  for(var_0 = self; var_0.size > 0; var_0 = maps\_utility::array_removedead(var_0))
    common_scripts\utility::waitframe();
}

zodiac_setup(var_0) {
  self endon("death");
  self.health = 55000;
  self.currenthealth = self.health;
  self.animname = "zodiac";
  maps\_anim::setanimtree();
  thread zodiac_waittill_death();
  thread zodiac_treadfx();
  thread zodiac_wait_for_attack();
  thread cleanup_zodiac_bodies();
  thread maps\carrier_fx::handle_zodiac_propeller();
  thread maps\carrier_code::do_notetracks(level.scr_anim["zodiac"]["carrier_rappel_defend_zodiac_moving"][0], "impact_front_both");
  common_scripts\utility::array_thread(self.riders, ::zodiac_rider_logic, var_0);
  maps\_utility::ent_flag_init("safe_remove");

  if(isDefined(self.script_parameters) && issubstr(self.script_parameters, "no_riders"))
    thread setup_fake_riders();

  if(!maps\carrier_code::eval(var_0))
    thread zodiac_safe_remove();

  var_1 = getanimlength( % carrier_rappel_defend_zodiac_moving);
  wait(randomfloat(var_1 - var_1 / 4));

  if(!maps\carrier_code::eval(self.is_rappelling))
    thread maps\_vehicle_code::animate_drive_idle();
}

zodiac_safe_remove() {
  self endon("death");

  if(!isalive(self)) {
    return;
  }
  common_scripts\utility::waittill_any("reached_dynamic_path_end", "safe_remove");
  var_0 = cos(65);
  var_1 = gettime() + randomintrange(2000, 4000);

  while(maps\_utility::either_player_looking_at(self.origin, var_0, 1) && gettime() < var_1)
    wait 0.05;

  if(!maps\_utility::either_player_looking_at(self.origin, var_0, 1))
    self delete();
  else {
    wait(randomfloatrange(0, 1));
    thread zodiac_death();
  }
}

setup_fake_riders() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("crr_zodiac_full");
  var_0.angles = self.angles;
  var_0 linkto(self, "tag_body", (0, 0, 0), (0, 0, 0));
  self waittill("death");
  var_0 delete();
}

convert_to_fake_riders() {
  if(isDefined(self.script_parameters))
    self.script_parameters = self.script_parameters + " no_riders";
  else
    self.script_parameters = " no_riders";

  maps\_utility::array_delete(self.riders);
  thread setup_fake_riders();
}

zodiac_wait_for_attack() {
  self endon("death");

  while(distance2dsquared(level.player.origin, self.origin) > 9000000)
    wait 0.5;

  maps\_vehicle::vehicle_ai_event("attack");
}

spawn_zodiac_rappel(var_0, var_1) {
  foreach(var_3 in level.zodiacs) {
    if(isalive(var_3) && isDefined(var_3.saved_targetname) && var_3.saved_targetname == var_0)
      return;
  }

  level.zodiacs = maps\_utility::array_removedead(level.zodiacs);

  if(level.zodiacs.size > 30) {
    return;
  }
  maps\_utility::array_spawn_function_targetname(var_0, ::zodiac_teleport_logic);
  maps\_utility::array_spawn_function_targetname(var_0, maps\carrier_code::setup_target_on_vehicle);
  maps\_utility::array_spawn_function_targetname(var_0, ::zodiac_setup, 1);
  maps\_utility::array_spawn_function_targetname(var_0, ::zodiac_rappel_logic, var_0, var_1);
  maps\_utility::array_spawn_function_targetname(var_0, ::setup_rope_coil);
  var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_0);
  var_3.saved_targetname = var_0;
  level.zodiacs = common_scripts\utility::array_add(level.zodiacs, var_3);
  return var_3;
}

setup_rope_coil() {
  var_0 = self.origin + vectornormalize(anglesToForward(self.angles)) * 16 + (0, 0, 13);
  var_1 = spawn("script_model", var_0);
  var_1 setModel("cnd_rope_rappel_coil_04");
  var_1.angles = self.angles + (0, 90, -5);
  var_1 linkto(self, "tag_body");
  self waittill("death");
  var_1 delete();
}

zodiac_teleport_logic() {
  self endon("death");

  if(!isDefined(self.script_noteworthy) || !issubstr(self.script_noteworthy, "zodiac_teleport")) {
    return;
  }
  level.player common_scripts\utility::waittill_any("using_depth_charge", "teleport_zodiacs");

  for(var_0 = self.attachedpath; isDefined(var_0); var_0 = getvehiclenode(var_0.target, "targetname")) {
    if(isDefined(var_0) && isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "teleport") {
      self vehicle_teleport(var_0.origin, var_0.angles);
      return;
    }
  }
}

zodiac_rappel_logic(var_0, var_1) {
  self waittill("reached_dynamic_path_end");

  if(!isDefined(self)) {
    return;
  }
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.angles = self.angles + (-90, 0, 0);
  var_2.origin = self.origin - (0, 0, 4);
  var_2 linkto(self, "tag_origin");
  self.fx_idle = var_2;
  playFXOnTag(level._effect["vfx_zodiac_splash_idle"], var_2, "tag_origin");
  thread kill_zodiac_fx_idle();
  self.is_rappelling = 1;
  self notify("suspend_drive_anims");
  common_scripts\utility::waitframe();
  self.idle_struct = spawnStruct();
  self.idle_struct.origin = self.origin;
  self.idle_struct.angles = self.angles;
  self.idle_struct thread maps\_anim::anim_loop_solo(self, "carrier_rappel_defend_zodiac_idle_a");

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  var_3 = common_scripts\utility::getstruct(var_0 + "_rappel", "targetname");
  var_4 = common_scripts\utility::getstruct(var_3.target, "targetname");
  self.ref_node = var_4;

  if(!isDefined(self.script_noteworthy) || !issubstr(self.script_noteworthy, "zodiac_vista"))
    level notify("zodiacs_rappelling");

  var_5 = setup_rope(var_4);
  thread cleanup_rope_on_zodiac_death(var_5);
  var_6 = [2, 1, 3, 0];

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    var_8 = get_rider_by_position(var_6[var_7]);

    if(isDefined(var_8) && isalive(var_8)) {
      if(!isDefined(var_5) || isDefined(var_5.iscutdown) && var_5.iscutdown) {
        continue;
      }
      if(!isalive(var_8) || maps\carrier_code::eval(var_8.dead)) {
        continue;
      }
      var_8 thread rappel(var_4, var_5, var_7, var_1);
      self.rappellers = common_scripts\utility::array_add(self.rappellers, var_8);
      var_5.rappellers = common_scripts\utility::array_add(var_5.rappellers, var_8);

      if(var_7 == var_6.size - 1) {
        break;
      }

      var_5 common_scripts\utility::waittill_any("next_rappeller", "cut");

      if((!isDefined(self) || !isalive(self)) && isDefined(var_5)) {
        var_5 notify("rappel_done");
        return;
      } else if(isDefined(var_5) && maps\carrier_code::eval(var_5.iscutdown)) {
        wait 3;
        thread zodiac_death();
      }
    }
  }
}

get_rider_by_position(var_0) {
  foreach(var_2 in self.riders) {
    if(var_2.vehicle_position == var_0)
      return var_2;
  }

  return undefined;
}

drone_init_zodiac() {
  if(level.drones[self.team].array.size >= level.max_drones[self.team]) {
    self delete();
    return;
  }

  thread maps\_drone::drone_array_handling(self);
  self setCanDamage(1);
  self startusingheroonlylighting();
  thread maps\_drone::drone_death_thread();
}

kill_zodiac_fx_idle() {
  var_0 = self.fx_idle;
  self waittill("death");
  stopFXOnTag(level._effect["vfx_zodiac_splash_idle"], var_0, "tag_origin");
  wait 2.0;

  if(isDefined(var_0))
    maps\_utility::deleteent(var_0);
}

cleanup_rope_on_zodiac_death(var_0) {
  self waittill("death");

  if(isDefined(var_0)) {
    if(isDefined(var_0.static))
      maps\_utility::deleteent(var_0.static);

    self.ref_node cut_rope_anim(var_0);
  }
}

spawn_fake_zodiacs(var_0, var_1) {
  if(var_1 == 0) {}

  var_2 = common_scripts\utility::getstructarray(var_0, "targetname");

  foreach(var_4 in var_2) {
    var_5 = spawn_fake_zodiac(var_4);
    var_5.speed = var_1;
    var_5 thread fake_zodiac_setup();
  }
}

spawn_fake_zodiac(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("vehicle_zodiac_boat_fed_iw6");
  var_1.angles = var_0.angles;
  var_1.dest = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_1.angles = vectortoangles(var_1.dest.origin - var_1.origin);
  return var_1;
}

fake_zodiac_setup() {
  var_0 = 17.6;
  self.fake = 1;
  level.fake_targets = common_scripts\utility::array_removeundefined(level.fake_targets);
  level.fake_targets = common_scripts\utility::array_add(level.fake_targets, self);
  var_1 = distance(self.origin, self.dest.origin);
  var_2 = var_1 / (self.speed * var_0);
  self moveto(self.dest.origin, var_2);
  self.animname = "zodiac";
  maps\_anim::setanimtree();
  thread fake_zodiac_move_anim();
  thread delete_fake_zodiac(var_2);
  thread setup_fake_riders();
  thread zodiac_treadfx();
  thread maps\carrier_fx::handle_zodiac_propeller();
  thread maps\carrier_code::do_notetracks(level.scr_anim["zodiac"]["carrier_rappel_defend_zodiac_moving"][0], "impact_front_both");
}

fake_zodiac_move_anim() {
  self setanim(level.scr_anim["zodiac"]["carrier_rappel_defend_zodiac_moving"][0], 1, 0.05, self.speed / 20);
  self setanimtime(level.scr_anim["zodiac"]["carrier_rappel_defend_zodiac_moving"][0], randomfloat(1));
}

delete_fake_zodiac(var_0) {
  wait(var_0);

  if(isDefined(self))
    self delete();
}

is_fake_zodiac() {
  return isDefined(self) && isDefined(self.fake);
}

zodiac_rider_logic(var_0) {
  self.allowdeath = 1;
  self.dropweapon = 0;
  self.nodrop = 1;
  self.grenadeammo = 0;
  self.health = int(self.health / 2);
  self.actual_health = self.health;
  self.health = self.health * 2;

  if(maps\carrier_code::is_drone()) {
    self.script = "drone";
    give_weaponsound();
    thread drone_init_zodiac();

    if(randomint(100) > 80)
      self.use_ak12 = 1;
  }

  thread zodiac_rider_death();

  if(isDefined(self.spawner) && isDefined(self.script_spawn_once))
    self.spawner delete();
}

give_weaponsound() {
  self.weaponsound = undefined;
  var_0 = randomintrange(1, 4);

  if(var_0 == 1)
    self.weaponsound = "drone_ak12_fire_npc";
  else if(var_0 == 2)
    self.weaponsound = "drone_cz805_fire_npc";

  if(var_0 == 3)
    self.weaponsound = "drone_cbjms_fire_npc";
}

rider_attack(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_0 endon("start_rappel");
  var_0 endon("fully_stop_firing");
  level endon("defend_zodiac_finished");

  if(!var_0 maps\carrier_code::is_drone() || isDefined(var_0.rope) || maps\carrier_code::eval(var_0.dontfire)) {
    return;
  }
  var_2 = maps\_vehicle_aianim::anim_pos(self, var_1);
  wait(var_1 * randomfloatrange(2, 4));

  for(;;) {
    maps\_vehicle_aianim::animontag(var_0, var_2.sittag, var_2.enter);

    if(issubstr(var_0.weapon, "panzerfaust"))
      var_0 thread zodiac_drone_fire_rpg();
    else
      var_0 thread zodiac_drone_fire();

    for(var_3 = 0; var_3 < randomintrange(1, 3); var_3++)
      maps\_vehicle_aianim::animontag(var_0, var_2.sittag, var_2.loop);

    var_0 notify("stop_firing");
    maps\_vehicle_aianim::animontag(var_0, var_2.sittag, var_2.exit);
    wait(randomfloatrange(3, 6));
  }
}

rider_attack_check(var_0, var_1) {
  return isDefined(maps\_vehicle_aianim::anim_pos(self, var_1).enter) && isDefined(maps\_vehicle_aianim::anim_pos(self, var_1).loop) && isDefined(maps\_vehicle_aianim::anim_pos(self, var_1).exit);
}

zodiac_drone_fire() {
  self endon("death");
  self endon("start_rappel");
  self endon("stop_firing");
  self endon("fully_stop_firing");
  level endon("defend_zodiac_finished");

  for(;;) {
    var_0 = randomintrange(20, 30);

    for(var_1 = 0; var_1 < var_0; var_1++) {
      drone_shoot();
      wait 0.1;
    }

    wait(randomfloatrange(2, 4));
  }
}

zodiac_drone_fire_rpg() {
  self endon("death");
  self endon("start_rappel");
  self endon("stop_firing");
  self endon("fully_stop_firing");
  level endon("defend_zodiac_finished");

  for(;;) {
    drone_shoot_rpg();
    wait(randomfloatrange(3, 5));
  }
}

drone_shoot() {
  self endon("start_rappel");
  level endon("defend_zodiac_finished");
  var_0 = 0;
  var_1 = level.difficultysettings["zodiac_rider_playerHitRatio"][maps\_gameskill::get_skill_from_index(level.gameskill)];

  if(isDefined(self.player_hit_ratio_override))
    var_1 = self.player_hit_ratio_override;

  var_2 = 10 - var_1;
  var_3 = self gettagorigin("tag_flash");

  if(randomfloat(100) < var_1 && !common_scripts\utility::flag("gunship_attack") && distance2dsquared(level.player.origin, self.origin) < 6250000) {
    var_4 = level.player getshootatpos();
    var_0 = 1;
    return;
  } else if(randomfloat(100) < var_2) {
    var_5 = level.player getplayerangles();
    var_6 = vectornormalize(anglestoright(var_5));
    var_7 = common_scripts\utility::randomvectorrange(50, 100);
    var_8 = var_6 * var_7;
    var_4 = level.player getshootatpos() + var_8;
    var_0 = 1;
  } else
    var_4 = var_3 + anglesToForward(self gettagangles("tag_flash")) * 5000;

  if(var_0) {
    if(!isDefined(self.weapon) || isDefined(self.use_ak12))
      magicbullet("ak12", var_3, var_4);
    else
      magicbullet(self.weapon, var_3, var_4);

    drone_shoot_fx();
  } else
    drone_shoot_fx(1);
}

drone_shoot_fx(var_0) {
  var_1 = common_scripts\utility::getfx("ak47_muzzleflash");

  if(maps\carrier_code::eval(var_0)) {
    var_2 = 10;

    if(randomint(100) < var_2)
      var_1 = common_scripts\utility::getfx("drone_tracer");
  }

  playFXOnTag(var_1, self, "tag_flash");
}

drone_shoot_rpg() {
  var_0 = anglesToForward(self gettagangles("tag_flash")) * 5000 + (0, 0, 1000);
  magicbullet("panzerfaust3_cheap", self gettagorigin("tag_flash") + (0, 0, 8), var_0);
}

zodiac_rider_death() {
  self endon("start_rappel");
  self endon("explode");
  self endon("rappel_death");

  if(!isDefined(self)) {
    return;
  }
  if(isai(self))
    self.a.nodeath = 1;

  self.deathanim = undefined;
  self.skipdeathanim = 1;
  self.damageshield = 1;

  for(var_0 = 0; isDefined(self) && self.actual_health > 0; self.actual_health = self.actual_health - var_1)
    self waittill("damage", var_1, var_2, var_3, var_4, var_5);

  if(!isDefined(self)) {
    return;
  }
  if(self.vehicle_position != 0)
    self.ridingvehicle.corpses = common_scripts\utility::array_add(self.ridingvehicle.corpses, self);

  self notify("fully_stop_firing");
  var_6 = get_rider_death_anim();
  thread maps\_anim::anim_generic(self, var_6);

  if(isDefined(self.ridingvehicle) && isDefined(self.ridingvehicle.riders))
    self.ridingvehicle.riders = common_scripts\utility::array_remove(self.ridingvehicle.riders, self);

  if(var_6 == "carrier_rappel_defend_death_zodiac_b") {
    self.animname = "generic";
    maps\_anim::anim_set_rate_single(self, "carrier_rappel_defend_death_zodiac_b", 1.5);
  }

  if(var_6 == "carrier_rappel_defend_death_zodiac_c") {
    self waittillmatch("single anim", "end");
    self.dead = 1;
    self.ridingvehicle waittill("death");

    if(isDefined(self))
      self delete();

    return;
  }

  level.corpse_entnums = common_scripts\utility::array_add(level.corpse_entnums, self getentitynumber());
  thread splash_on_hit_water();
  self.dead = 1;
  self waittillmatch("single anim", "end");

  if(isDefined(self)) {
    if(self.vehicle_position == 0) {
      wait 1;
      self delete();
    } else
      self kill();
  }
}

get_rider_death_anim() {
  var_0 = ["carrier_rappel_defend_death_zodiac_a", "carrier_rappel_defend_death_zodiac_b"];

  if(self.vehicle_position == 1 || self.vehicle_position == 3)
    var_0 = common_scripts\utility::array_add(var_0, "carrier_rappel_defend_death_zodiac_c");

  if(isDefined(self.ridingvehicle) && isDefined(self.ridingvehicle.is_rappelling)) {
    if(self.vehicle_position == 1 || self.vehicle_position == 3)
      return "carrier_rappel_defend_death_zodiac_c";

    return "carrier_rappel_defend_death_zodiac_b";
  } else
    return var_0[randomint(var_0.size)];
}

zodiac_waittill_death() {
  self endon("zodiac_exploded");
  self endon("zodiac_death");
  self.corpses = [];

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(isDefined(self.script_parameters) && issubstr(self.script_parameters, "no_riders")) {
      return;
    }
    if(self.riders.size == 0 && array_removedead_zodiac(self.rappellers).size == 0) {
      thread zodiac_death();
      return;
    }

    wait 0.1;
  }
}

array_removedead_zodiac(var_0) {
  if(!isDefined(var_0))
    return [];

  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3) || maps\carrier_code::eval(var_3.dead)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

zodiac_death() {
  self endon("zodiac_exploded");

  if(!isalive(self)) {
    return;
  }
  self notify("zodiac_death");

  if(randomint(100) > 40 && self vehicle_getspeed() >= 20) {
    thread zodiac_flipdeath();
    return;
  }

  if(isDefined(self.rappellers)) {
    thread zodiac_dockeddeath();
    return;
  }

  self notify("suspend_drive_anims");
  self setanimknoball(level.scr_anim["zodiac"]["carrier_rappel_defend_zodiac_death_parked"], % root);
  var_0 = 0.75;
  self setanimtime(level.scr_anim["zodiac"]["carrier_rappel_defend_zodiac_death_parked"], var_0);
  wait 0.2;
  playFXOnTag(common_scripts\utility::getfx("vfx_zodiac_splash_sink"), self, "tag_fx_rf");
  wait((1 - var_0) * getanimlength(level.scr_anim["zodiac"]["carrier_rappel_defend_zodiac_death_parked"]) - 0.15);

  if(isDefined(self)) {
    self kill();
    common_scripts\utility::waitframe();

    if(isDefined(self))
      self delete();
  }
}

zodiac_flipdeath() {
  self endon("zodiac_exploded");
  wait(randomfloatrange(0.2, 0.4));

  if(!isDefined(self)) {
    return;
  }
  self notify("suspend_drive_anims");
  self setanim(level.scr_anim["zodiac"]["carrier_rappel_defend_zodiac_death_flip"]);
  wait(getanimlength(level.scr_anim["zodiac"]["carrier_rappel_defend_zodiac_death_flip"]));

  if(isDefined(self)) {
    self kill();
    common_scripts\utility::waitframe();

    if(isDefined(self))
      self delete();
  }
}

zodiac_dockeddeath() {
  if(isDefined(self.rope))
    self.rope notify("rappel_done");

  wait(randomfloatrange(0.5, 2));

  if(!isDefined(self)) {
    return;
  }
  foreach(var_1 in self.corpses) {
    if(isDefined(var_1) && !var_1 isragdoll())
      var_1 linkto(self, "tag_body");
  }

  maps\_anim::anim_single_solo(self, "carrier_rappel_defend_zodiac_death_parked");

  if(isDefined(self)) {
    self kill();
    common_scripts\utility::waitframe();

    if(isDefined(self))
      self delete();
  }
}

explode_zodiacs(var_0, var_1, var_2) {
  level.zodiacs = maps\_utility::array_removedead(level.zodiacs);
  level.zodiacs = sortbydistance(level.zodiacs, var_0);
  var_3 = [];

  foreach(var_5 in level.zodiacs) {
    if(isDefined(var_5)) {
      var_6 = distance(var_5.origin, var_0);

      if(var_6 <= var_1) {
        var_3 = common_scripts\utility::array_add(var_3, var_5);
        var_5.dist = var_6;
      } else
        break;
    }
  }

  foreach(var_5 in var_3) {
    if(isDefined(var_5)) {
      level.osprey_hit_zodiacs++;
      level.osprey_total_hits++;
      var_6 = clamp(var_5.dist, var_2, var_1);
      var_9 = 1 - (var_6 - var_2) / (var_1 - var_2);
      var_5 thread explode_single_zodiac(var_9, var_0);
      wait 0.1;
    }
  }
}

explode_single_zodiac(var_0, var_1) {
  if(!isDefined(self) || maps\carrier_code::eval(self.is_exploding)) {
    return;
  }
  self.is_exploding = 1;

  if(isDefined(level.player.using_depth_charge) && level.player.using_depth_charge)
    level.player thread maps\carrier_depth_charge::depth_charge_weapon_hit();

  self notify("zodiac_exploded");
  thread launch_ragdolls_zodiac(var_0);
  cleanup_corpses_on_explode();
  thread common_scripts\utility::play_sound_in_space("scn_carr_sparrow_exp", var_1);
  var_2 = spawn("script_model", self.origin);
  var_2 setModel("vehicle_zodiac_boat_fed_iw6");
  var_2.angles = self.angles;

  if(isDefined(self))
    self delete();

  var_3 = 100;
  var_4 = 400;
  var_5 = var_3 + var_0 * (var_4 - var_3);
  var_6 = var_2.origin;
  var_7 = 4 * vectornormalize(var_6 - var_1);
  var_8 = 1.5 * (1 + var_0);
  var_8 = int(var_8 * 20) / 20;
  var_9 = var_6 + var_7 * var_5 - (0, 0, 200);
  var_2 maps\_utility::delaythread(var_8 / 2, ::splash_on_hit_water_zodiac);
  var_2 rotatevelocity(common_scripts\utility::randomvectorrange(100, 200), var_8, 0, var_8 / 2);
  var_2 move_arc_zodiac(var_6, var_9, var_6[2] + var_5, var_8);
  var_2 delete();
}

cleanup_corpses_on_explode() {
  if(!isDefined(self.corpses)) {
    return;
  }
  foreach(var_1 in self.corpses) {
    if(isDefined(var_1))
      var_1 delete();
  }
}

move_arc_zodiac(var_0, var_1, var_2, var_3) {
  self endon("deleted");
  var_4 = 5;
  var_5 = 0.2;
  var_6 = 0.7;
  var_7 = maps\carrier_code::calculate_arc(var_0, var_1, var_2, var_4);

  foreach(var_11, var_9 in var_7) {
    if(var_11 < 1) {
      continue;
    }
    var_10 = var_5 + var_11 / var_4 * (var_6 - var_5);
    self moveto(var_9, var_10);
    wait(var_10);
  }
}

splash_on_hit_water_zodiac() {
  while(isDefined(self) && self.origin[2] > level.water_level + 8)
    wait 0.05;

  if(isDefined(self)) {
    var_0 = self.origin;
    var_0 = (var_0[0], var_0[1], level.water_level);
    playFX(common_scripts\utility::getfx("vfx_zodiac_water_splash"), var_0);
  }
}

launch_ragdolls_zodiac(var_0) {
  var_1 = getspawnerteamarray("axis");
  var_2 = [];
  var_3 = 12;

  foreach(var_5 in var_1) {
    if(!maps\carrier_code::eval(var_5.script_drone)) {
      var_2[var_2.size] = var_5;

      if(var_2.size >= var_3) {
        break;
      }
    }
  }

  var_7 = self.origin + (0, 0, 32);
  var_8 = randomintrange(2, 3);

  if(maps\_vehicle::isvehicle()) {
    foreach(var_10 in self.riders) {
      var_10.noragdoll = 1;
      var_10 notify("explode");
      var_10 delete();
    }
  }

  var_12 = randomint(var_2.size);

  for(var_13 = 0; var_13 < var_8; var_13++) {
    var_14 = 60 * (randomfloatrange(50, 100) + 150 * var_0);
    var_15 = var_2[var_12];
    var_16 = var_15.count;

    if(var_16 <= 0)
      var_15.count = 1;

    var_17 = var_15 stalingradspawn();

    if(!isDefined(var_17)) {
      continue;
    }
    var_15.count = var_16;

    if(var_12 >= var_2.size - 1)
      var_12 = 0;
    else
      var_12++;

    var_17 forceteleport(var_7);
    var_18 = (randomfloatrange(-10000, 10000), randomfloatrange(-10000, 10000), var_14);
    var_17 kill();
    var_17 startragdollfromimpact("torso_lower", var_18);
    level.corpse_entnums = common_scripts\utility::array_add(level.corpse_entnums, var_17 getentitynumber());
  }
}

zodiac_treadfx() {
  self endon("death");
  var_0 = 0;
  var_1 = 4;

  for(;;) {
    if(maps\_vehicle::isvehicle())
      var_2 = self vehicle_getspeed();
    else
      var_2 = self.speed;

    if(var_2 < var_1 && var_0) {
      stopFXOnTag(common_scripts\utility::getfx("zodiac_wake_geotrail"), self, "tag_motor_fx");
      var_0 = 0;
    } else if(var_2 >= var_1 && !var_0) {
      playFXOnTag(common_scripts\utility::getfx("zodiac_wake_geotrail"), self, "tag_motor_fx");
      var_0 = 1;
    }

    wait 0.1;
  }
}

setup_rope(var_0) {
  var_1 = maps\_utility::spawn_anim_model("rope");
  self.rope = var_1;
  self.rappellers = [];
  var_1.rappellers = [];
  var_0 thread maps\_anim::anim_first_frame_solo(var_1, "carrier_rappel_defend_rope_shoot");
  var_1 hide();
  var_1.shot = 0;
  return var_1;
}

shoot_rope(var_0, var_1) {
  self endon("death");
  self endon("deleted");
  self.shot = 1;

  if(maps\carrier_code::eval(var_1)) {
    self show();
    var_0 thread maps\_anim::anim_last_frame_solo(self, "carrier_rappel_defend_rope_shoot");
  } else {
    self show();
    var_0 thread rope_sound();
    var_0 maps\_anim::anim_single_solo(self, "carrier_rappel_defend_rope_shoot");
  }

  self hide();
  self.static = spawn("script_model", var_0.origin);
  self.static setModel("crr_assault_rope_static");
  self.static.angles = var_0.angles;
  thread run_cut_rope(var_0);
  self waittill("rappel_done");

  if(isDefined(self) && !self.iscutdown)
    var_0 cut_rope_anim(self);
}

rope_sound() {
  thread common_scripts\utility::play_sound_in_space("scn_carr_boarding_hook", self.origin - (0, 0, 400));
}

cleanup_rope() {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  level.cut_ropes = common_scripts\utility::array_removeundefined(level.cut_ropes);

  if(level.cut_ropes.size > 3) {
    level.cut_ropes = sortbydistance(level.cut_ropes, level.player.origin);
    level.cut_ropes[level.cut_ropes.size - 1] delete();
  }

  maps\carrier_code::waittill_player_not_looking(1);
  self delete();
}

rappel(var_0, var_1, var_2, var_3) {
  self endon("rappel_enter_death");
  self.rope = var_1;
  self.ref_node = var_0;
  self notify("start_rappel");
  self.animname = "generic";
  self.health = self.health * 2;
  self.actual_health = self.actual_health * 2;
  thread rappel_enter_death();
  thread rappel_enter(var_0);

  if(!self.rope.shot && self.vehicle_position == 2) {
    self waittillmatch("single anim", "rope_spawn");

    if(!isDefined(self) || !isDefined(self.rope)) {
      return;
    }
    self.rope thread shoot_rope(var_0, var_3);
  }

  self waittillmatch("single anim", "gen_prop_start");

  if(!isDefined(self)) {
    return;
  }
  self.rope_prop = rope_prop_anim(var_0);

  if(!isalive(self)) {
    return;
  }
  self notify("rappel_enter_finished");
  thread rappel_idle(var_0);
  var_1 thread rope_cut_death(self, var_2);
  thread rappel_pain();
  thread rappel_death();
  var_4 = getanimlength(level.scr_anim["rope_prop"]["carrier_rappel_defend_ascend_prop"]);
  thread fire_from_rope_or_die(var_0, var_4);

  if(!isalive(self))
    return;
}

rappel_enter(var_0) {
  var_1 = "carrier_rappel_defend_ascend_enter_" + self.vehicle_position;
  var_2 = "carrier_rappel_defend_ascend_enter_2";
  self unlink();

  if(isDefined(self.ridingvehicle.riders))
    self.ridingvehicle.riders = common_scripts\utility::array_remove(self.ridingvehicle.riders, self);

  if(!self.rope.shot && self.vehicle_position == 2) {
    if(isDefined(self.ridingvehicle) && isalive(self.ridingvehicle.riders[1])) {
      self.ridingvehicle.riders[1].dontfire = 1;
      self.ridingvehicle.riders[1] notify("fully_stop_firing");
    }

    var_0 thread maps\_anim::anim_generic(self, var_2);
    self.launcher = maps\_utility::spawn_anim_model("launcher");
    thread cleanup_launcher();
    var_0 thread maps\_anim::anim_single_solo(self.launcher, "carrier_rappel_defend_ascend_enter_launcher");
    self waittillmatch("single anim", "delete_launcher");

    if(isalive(self) && isDefined(self.launcher))
      self.launcher delete();
  } else {
    var_3 = self.ridingvehicle;
    var_4 = var_3 vehicle_get_idle_pos(self.vehicle_position);
    var_4 thread maps\_anim::anim_generic(self, var_1);
  }
}

cleanup_launcher() {
  common_scripts\utility::waittill_any("death", "enter_death");

  if(isDefined(self.launcher))
    self.launcher delete();
}

vehicle_get_idle_pos(var_0) {
  var_1 = maps\_vehicle_aianim::anim_pos(self, var_0);
  var_2 = spawnStruct();
  var_3 = undefined;
  var_4 = undefined;
  var_5 = self gettagorigin(var_1.sittag);
  var_6 = self gettagangles(var_1.sittag);
  var_3 = getstartorigin(var_5, var_6, var_1.idle);
  var_4 = getstartangles(var_5, var_6, var_1.idle);
  var_2.origin = var_3;
  var_2.angles = var_4;
  var_2.vehicle_position = var_0;
  return var_2;
}

rope_prop_anim(var_0) {
  self endon("death");
  var_1 = maps\_utility::spawn_anim_model("rope_prop");
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  self.ascender = maps\_utility::spawn_anim_model("ascender");
  self.ascender hide();
  self.ascender linkto(var_1, "j_prop_1", (0, 0, 0), (0, 0, 0));
  thread drop_ascender();
  self.ascender common_scripts\utility::delaycall(0.2, ::show);
  var_0 thread maps\_anim::anim_single_solo(var_1, "carrier_rappel_defend_ascend_prop");
  var_2 = getanimlength(level.scr_anim["rope_prop"]["carrier_rappel_defend_ascend_prop"]);
  maps\_utility::delaythread(0.05, maps\_anim::anim_set_time, [var_1], "carrier_rappel_defend_ascend_prop", 0.5 / var_2);
  common_scripts\utility::waitframe();
  maps\_anim::anim_set_rate_single(var_1, "carrier_rappel_defend_ascend_prop", 0);
  common_scripts\utility::waitframe();
  var_1.attach_point = common_scripts\utility::spawn_tag_origin();
  var_1.attach_point.origin = self.origin;
  var_1.attach_point.angles = self.angles;
  self linkto(var_1.attach_point, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_1.attach_point moveto(var_1 gettagorigin("j_prop_2"), 0.4);
  wait 0.45;
  var_1.attach_point delete();
  maps\_anim::anim_set_rate_single(var_1, "carrier_rappel_defend_ascend_prop", 1);
  self linkto(var_1, "j_prop_2", (0, 0, 0), (0, 0, 0));
  return var_1;
}

debug_j_prop(var_0) {
  self endon("death");

  for(;;) {
    thread common_scripts\utility::draw_line_for_time(self gettagorigin("j_prop_2"), level.player.origin, 0, 0, 1, 0.05);
    thread common_scripts\utility::draw_line_for_time(var_0 gettagorigin("tag_origin"), level.player.origin, 1, 1, 0, 0.05);

    if(isDefined(self.attach_point))
      thread common_scripts\utility::draw_line_for_time(self.attach_point gettagorigin("tag_origin"), level.player.origin, 1, 0, 0, 0.05);

    wait 0.05;
  }
}

drop_ascender() {
  var_0 = self.ascender;
  var_0 endon("death");

  if(isDefined(self.rope) && !maps\carrier_code::eval(self.rope.iscutdown)) {
    var_1 = common_scripts\utility::waittill_any_return("death", "cut", "rappel_death", "land_on_zodiac_death", "rappel_enter_death");

    if(var_1 == "rappel_enter_death") {
      var_0 delete();
      return;
    } else if(var_1 == "cut" || !isDefined(self.rope) || maps\carrier_code::eval(self.rope.iscutdown)) {} else
      wait(randomfloatrange(1, 2));
  }

  var_0 unlink();
  var_0 rotatevelocity((randomfloatrange(-200, 200), randomfloatrange(-200, 200), randomfloatrange(-200, 200)), 2, 2);
  var_0 moveto(var_0.origin - (0, 0, 680), 2, 2);
  wait 2;
  var_0 delete();
}

rappel_idle(var_0) {
  if(isalive(self) && isDefined(self.rope)) {
    var_1 = ["carrier_rappel_defend_ascend_a", "carrier_rappel_defend_ascend_b"];
    thread maps\_anim::anim_loop_solo(self, var_1[randomint(var_1.size)], "stop_loop");
  }
}

fire_from_rope_or_die(var_0, var_1) {
  self endon("death");
  self endon("rappel_death");
  var_2 = 30;
  var_3 = 10;
  var_4 = 30;
  var_5 = 30;
  var_6 = randomint(100);
  var_7 = 3;
  var_8 = var_1 - 2;
  var_9 = 2;
  var_10 = randomfloatrange(var_7, var_8);
  wait(var_10);

  if(var_6 < var_2) {
    rappel_kill();
    return;
  }

  for(;;) {
    if(!isDefined(self) || !isDefined(self.rope_prop)) {
      return;
    }
    self notify("stop_loop");
    maps\_anim::anim_set_rate_single(self.rope_prop, "carrier_rappel_defend_ascend_prop", 0);
    var_11 = distance(level.player.origin, self.origin);
    var_11 = clamp(var_11, 200, 600);
    var_12 = 1 - (var_11 - 200) / 400;
    var_13 = level.difficultysettings["rappeler_playerHitRatio"][maps\_gameskill::get_skill_from_index(level.gameskill)];
    self.player_hit_ratio_override = var_13 + var_13 * var_12;

    if(var_6 < var_2 + var_3) {
      maps\_anim::anim_generic(self, "carrier_rappel_defend_ascend_fire_enter");
      thread maps\_anim::anim_generic_loop(self, "carrier_rappel_defend_ascend_fire_idle");
      wait(randomfloatrange(6, 8));
      self notify("stop_loop");
      maps\_anim::anim_generic(self, "carrier_rappel_defend_ascend_fire_exit");
    } else if(var_6 < var_2 + var_3 + var_4)
      maps\_anim::anim_generic(self, "carrier_rappel_defend_ascend_fire_a");
    else if(var_6 < var_2 + var_3 + var_4 + var_5)
      maps\_anim::anim_generic(self, "carrier_rappel_defend_ascend_fire_b");

    if(!isDefined(self.rope_prop)) {
      rappel_kill();
      return;
    }

    var_14 = self.rope_prop getanimtime(level.scr_anim["rope_prop"]["carrier_rappel_defend_ascend_prop"]);
    var_15 = var_14 * var_1;
    var_16 = max(var_8 - var_15, 0);
    var_10 = randomfloat(var_16);
    maps\_anim::anim_set_rate_single(self.rope_prop, "carrier_rappel_defend_ascend_prop", 1);
    thread rappel_idle(var_0);
    wait(var_10);
    rappel_kill();
  }
}

rappel_pain() {
  self endon("end_rappel");
  self endon("death");
  self endon("rappel_death");
  var_0 = ["carrier_rappel_defend_pain_rope_left", "carrier_rappel_defend_pain_rope_mid", "carrier_rappel_defend_pain_rope_right"];

  for(;;) {
    self waittill("rappel_pain");
    self stopanimscripted();
    thread maps\_anim::anim_generic(self, var_0[randomint(var_0.size)]);
  }
}

rappel_exit(var_0, var_1, var_2, var_3) {
  self notify("end_rappel");
  var_4 = ["carrier_rappel_defend_ascend_exit_straight", "carrier_rappel_defend_ascend_exit_left", "carrier_rappel_defend_ascend_exit_right"];
  self unlink();

  if(isDefined(var_1) && var_1 > 0) {
    if(isai(self))
      self animmode("nogravity");

    var_0 thread maps\_anim::anim_generic_first_frame(self, var_4[0]);
    wait(var_1);

    if(!isalive(self)) {
      return;
    }
    if(isai(self))
      self animmode("gravity");
  }

  var_0 thread maps\_anim::anim_generic(self, var_4[randomint(var_4.size)]);
  self waittillmatch("single anim", "end");

  if(!isalive(self)) {
    return;
  }
  if(maps\carrier_code::eval(var_3)) {
    return;
  }
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "enemy_defend_zodiac_vista")
    self kill();
  else if(isDefined(self)) {
    var_5 = self;

    if(maps\carrier_code::eval(self.script_drone))
      var_5 = safe_makerealai(self);

    var_5.health = 25;
    var_5.dropweapon = 0;
    var_5.nodrop = 1;
    var_5.grenadeammo = 0;
    var_5.deathanim = undefined;

    if(!isDefined(var_2))
      var_2 = 90;

    if(randomint(100) < var_2) {
      var_5 thread maps\ss_util::fake_death_bullet(0.1);
      return;
    }

    var_5 setgoalvolumeauto(getent("defend_zodiac_vol", "targetname"));
  }
}

safe_makerealai(var_0) {
  while(maps\carrier_code::eval(level.is_makerealai_active))
    common_scripts\utility::waitframe();

  level.is_makerealai_active = 1;
  var_1 = undefined;

  if(isDefined(var_0)) {
    var_2 = var_0.spawner;
    var_3 = var_0.spawner.count;

    if(var_3 == 0)
      var_2.count = 1;

    var_1 = maps\_utility::makerealai(var_0);

    if(var_3 == 0)
      var_2.count = 0;
  }

  level.is_makerealai_active = 0;
  return var_1;
}

rope_cut_death(var_0, var_1) {
  var_0 endon("explode");
  var_0 endon("death");
  var_0 endon("end_rappel");
  var_0 endon("rappel_death");
  var_0 endon("land_on_zodiac_death");

  if(maps\carrier_code::eval(self.iscutdown)) {} else {
    self waittill("cut");
    wait(0.2 * var_1);

    if(maps\carrier_code::eval(var_0.player_cut))
      level.player maps\_utility::player_giveachievement_wrapper("LEVEL_15A");
  }

  if(var_0 should_land_on_zodiac_death()) {
    var_0 rappel_kill();
    level.corpse_entnums = common_scripts\utility::array_add(level.corpse_entnums, var_0 getentitynumber());
    return;
  }

  if(isDefined(var_0.rope_prop))
    var_0.rope_prop delete();

  var_0 notify("stop_loop");
  var_0 thread maps\_anim::anim_generic(var_0, "carrier_rappel_defend_death_rope_cut");
  var_0 thread rappel_death_vo();
  level.corpse_entnums = common_scripts\utility::array_add(level.corpse_entnums, var_0 getentitynumber());
  thread finish_rope_cut_death(var_0);
}

finish_rope_cut_death(var_0) {
  var_0 splash_on_hit_water_ragdoll();
  wait 1;

  if(isDefined(var_0))
    var_0 delete();
}

rappel_enter_death(var_0) {
  self endon("rappel_enter_finished");
  self endon("explode");
  self endon("rappel_death");
  var_1 = self.rope;

  if(isDefined(var_1))
    var_1 endon("cut");

  while(self.vehicle_position == 2 && (isDefined(var_1) && !var_1.shot))
    common_scripts\utility::waitframe();

  if(isai(self))
    self.a.nodeath = 1;

  self.deathanim = undefined;
  self.skipdeathanim = 1;
  self.damageshield = 1;

  for(var_2 = 0; isDefined(self) && self.actual_health > 0 && isalive(self.ridingvehicle); self.actual_health = self.actual_health - var_3)
    self waittill("damage", var_3, var_4, var_5, var_6, var_7);

  if(!isDefined(self)) {
    return;
  }
  if(!isalive(self.ridingvehicle)) {
    self kill();
    return;
  }

  self notify("rappel_enter_death");
  self notify("stop_loop");

  if(isDefined(var_1))
    var_1 notify("next_rappeller");

  self linkto(self.ridingvehicle, "tag_body");
  self.ridingvehicle.corpses = common_scripts\utility::array_add(self.ridingvehicle.corpses, self);
  self notify("fully_stop_firing");
  self notify("enter_death");
  var_8 = "carrier_rappel_defend_death_zodiac_c";
  thread maps\_anim::anim_generic(self, "carrier_rappel_defend_death_zodiac_c");
  self waittillmatch("single anim", "end");
  self.dead = 1;
}

rappel_death() {
  self endon("end_rappel");
  self endon("death");
  self endon("land_on_zodiac_death");
  var_0 = self.rope;
  var_1 = self.rope_prop;
  var_2 = self.ref_node;

  if(isai(self))
    self.a.nodeath = 1;

  self.deathanim = undefined;
  self.skipdeathanim = 1;
  self.damageshield = 1;
  var_3 = 0;

  while(isDefined(self) && self.actual_health > 0) {
    self waittill("damage", var_4, var_5, var_6, var_7, var_8);
    self.actual_health = self.actual_health - var_4;

    if(should_pain_over_death() && self.actual_health <= 0) {
      self.health = self.health + var_4;
      self.actual_health = self.actual_health + var_4;
    }

    if(self.actual_health > 0)
      self notify("rappel_pain");
  }

  var_9 = ["carrier_rappel_defend_death_rope_a", "carrier_rappel_defend_death_rope_b"];

  if(isDefined(var_0))
    var_0 notify("next_rappeller");

  if(!isDefined(self)) {
    return;
  }
  if(!maps\carrier_code::is_drone() && !isalive(self)) {
    return;
  }
  var_2 notify("stop_loop");
  self stopanimscripted();
  self notify("stop_loop");
  self unlink();
  self notify("rappel_death");
  level.corpse_entnums = common_scripts\utility::array_add(level.corpse_entnums, self getentitynumber());
  thread splash_on_hit_water();
  thread rappel_death_vo();
  var_10 = var_9[randomint(var_9.size)];
  thread maps\_anim::anim_single_solo(self, var_10);
  maps\_anim::anim_set_rate_single(self, var_10, 1.25);
  thread land_on_zodiac_death();
  self waittillmatch("single anim", "end");
  self.dead = 1;

  if(isDefined(var_1))
    var_1 delete();

  if(isDefined(self))
    self delete();
}

should_pain_over_death() {
  if(!isDefined(self.rope_prop) || !isDefined(self.ridingvehicle))
    return 0;

  var_0 = 0.12;
  var_1 = 0.27;
  var_2 = self.rope_prop getanimtime(level.scr_anim["rope_prop"]["carrier_rappel_defend_ascend_prop"]);
  return var_2 > var_0 && var_2 <= var_1;
}

should_land_on_zodiac_death() {
  if(!isDefined(self.rope_prop) || !isDefined(self.ridingvehicle))
    return 0;

  var_0 = 0;
  var_1 = 0.12;
  var_2 = self.rope_prop getanimtime(level.scr_anim["rope_prop"]["carrier_rappel_defend_ascend_prop"]);
  return var_2 >= var_0 && var_2 <= var_1;
}

land_on_zodiac_death() {
  var_0 = self.rope;
  var_1 = self.rope_prop;

  if(!isDefined(var_1) || !isDefined(var_0))
    return 0;

  var_0 endon("death");
  var_0 endon("cut");
  var_1 endon("death");

  if(!should_land_on_zodiac_death())
    return 0;

  self notify("land_on_zodiac_death");
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = self.ridingvehicle.origin + anglesToForward(self.ridingvehicle.angles) * 64 + (0, 0, 10);
  var_2.angles = self.ridingvehicle.angles;
  var_2 linkto(self.ridingvehicle, "tag_body");
  var_3 = var_2.origin[2] + 32;

  while(self.origin[2] > var_3)
    common_scripts\utility::waitframe();

  self stopanimscripted();
  self.ridingvehicle.corpses = common_scripts\utility::array_add(self.ridingvehicle.corpses, self);
  self setanim(level.scr_anim["generic"]["carrier_rappel_defend_death_zodiac_c"], 1, 1);
  thread link_to_moving_target(var_2);
  wait(getanimlength(level.scr_anim["generic"]["carrier_rappel_defend_death_zodiac_c"]));
  self.dead = 1;
  return 1;
}

link_to_moving_target(var_0) {
  self endon("death");
  var_0 endon("death");
  var_1 = 15;
  var_2 = distance(self.origin, var_0.origin);
  var_3 = int(var_2 / var_1) * 0.1;
  self rotateto(var_0.angles, var_3);

  while(var_2 > 4 || self.origin[2] < var_0.origin[2]) {
    if(var_2 > var_1)
      var_4 = self.origin + vectornormalize(var_0.origin - self.origin) * var_1;
    else
      var_4 = var_0.origin;

    self moveto(var_4, 0.1);
    wait 0.1;
    var_2 = distance(self.origin, var_0.origin);
  }

  self linkto(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
}

splash_on_hit_water() {
  self endon("land_on_zodiac_death");

  while(isDefined(self) && self gettagorigin("j_mainroot")[2] > level.water_level + 8)
    wait 0.05;

  if(isDefined(self)) {
    var_0 = self gettagorigin("j_mainroot");
    var_0 = (var_0[0], var_0[1], level.water_level);
    playFX(common_scripts\utility::getfx("body_splash"), var_0);
  }
}

splash_on_hit_water_ragdoll(var_0) {
  if(isDefined(var_0))
    wait(var_0);
  else {
    self waittillmatch("single anim", "start_ragdoll");
    self unlink();
  }

  var_1 = self.origin[2] - level.water_level;

  if(var_1 <= 0) {
    return;
  }
  var_2 = var_1 / (1344 - level.water_level);
  var_3 = self.origin + (40 * var_2, 0, 0);
  var_4 = var_2 * 1.23;
  wait(var_4);
  var_5 = (var_3[0], var_3[1], level.water_level + 4);
  playFX(common_scripts\utility::getfx("body_splash"), var_5);
}

rappel_kill() {
  var_0 = [];
  var_0[0] = "j_hip_le";
  var_0[1] = "j_hip_ri";
  var_0[2] = "j_head";
  var_0[3] = "j_spine4";
  var_0[4] = "j_elbow_le";
  var_0[5] = "j_elbow_ri";
  var_0[6] = "j_clavicle_le";
  var_0[7] = "j_clavicle_ri";

  for(var_1 = 0; var_1 < 1 + randomint(2); var_1++) {
    var_2 = randomintrange(0, var_0.size);
    thread maps\ss_util::fake_death_bullet_fx(var_0[var_2], undefined);
    wait(randomfloat(0.05));
  }

  self notify("damage", self.actual_health, level.player, (0, 0, 0), (0, 0, 0), "MOD_RIFLE_BULLET");
}

rappel_death_vo() {
  var_0 = randomint(100);

  if(var_0 < 33)
    thread maps\_utility::play_sound_on_entity("generic_death_falling");
  else if(var_0 < 66)
    thread maps\_utility::play_sound_on_entity("generic_death_falling_scream");
  else {}
}

cleanup_zodiac_bodies() {
  var_0 = self.corpses;
  self waittill("death");

  if(isDefined(self))
    var_0 = self.corpses;

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }
}

setup_cut_rope_hint() {
  level.cut_rope_trigger sethintstring(&"CARRIER_CUT_ROPE_HINT");
  level.cut_rope_trigger.visible = 0;
  thread cut_rope_hint();
}

cut_rope_hint() {
  level endon("defend_zodiac_finished");

  for(;;) {
    if(maps\carrier_code::eval(level.player.can_cut) && !level.cut_rope_trigger.visible) {
      level.cut_rope_trigger maps\_utility::show_entity();
      level.cut_rope_trigger.visible = 1;
    } else if(!maps\carrier_code::eval(level.player.can_cut) && level.cut_rope_trigger.visible) {
      level.cut_rope_trigger maps\_utility::hide_entity();
      level.cut_rope_trigger.visible = 0;
    }

    common_scripts\utility::waitframe();
  }
}

run_cut_rope(var_0) {
  level endon("defend_zodiac_finished");
  self endon("deleted");
  self endon("death");
  self endon("cut");
  wait_for_cut_rope(var_0);
  thread cut_the_rope(var_0);
}

wait_for_cut_rope(var_0) {
  level endon("defend_zodiac_finished");
  self endon("deleted");
  self endon("death");
  self endon("cut");
  self.iscutdown = 0;
  self.can_cut = 0;
  level.player.can_cut = 0;
  thread monitor_can_cut_rope(var_0);
  level.player notifyonplayercommand("cut", "+melee");
  level.player notifyonplayercommand("cut", "+melee_breath");
  level.player notifyonplayercommand("cut", "+melee_zoom");

  for(;;) {
    level.player waittill("cut");

    if(self.can_cut)
      return;
  }
}

monitor_can_cut_rope(var_0) {
  level endon("defend_zodiac_finished");
  self endon("death");
  self endon("cut");
  self endon("rappel_death");

  for(;;) {
    childthread can_cut_rope(var_0);
    common_scripts\utility::waitframe();
  }
}

can_cut_rope(var_0) {
  if(isDefined(level.player.active_rope) && self != level.player.active_rope)
    return 0;

  if(maps\carrier_code::eval(level.player.using_depth_charge)) {
    self.can_cut = 0;
    level.player.can_cut = 0;
    return 0;
  }

  var_1 = self gettagorigin("j_lower_rig_cut_jnt");

  if(!level.player ismeleeing() && !level.player issprintsliding() && !level.player isthrowinggrenade() && !maps\carrier_code::eval(self.can_rope_melee) && maps\_utility::players_within_distance(50, var_1) && level.player maps\_utility::player_looking_at(var_1, 0.8, 1) && !enemy_too_close()) {
    level.player.active_rope = self;
    level.player allowmelee(0);
    self.can_cut = 1;
    level.player.can_cut = 1;
    return 1;
  }

  level.player.active_rope = undefined;
  self.can_cut = 0;
  level.player.can_cut = 0;
  level.player allowmelee(1);
  return 0;
}

enemy_too_close() {
  var_0 = 0;
  self.rappellers = maps\_utility::array_removedead(self.rappellers);
  var_1 = 22500;

  foreach(var_3 in self.rappellers) {
    if(distancesquared(var_3.origin, level.player.origin) <= var_1)
      return 1;
  }

  return 0;
}

cut_the_rope(var_0) {
  self.iscutdown = 1;
  level.player thread maps\carrier_depth_charge::depth_charge_remove_control(1);
  level.player setstance("stand");
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player disableweapons();
  level.player enableinvulnerability();
  level.player disableweaponswitch();
  level.player disableoffhandweapons();
  var_1 = maps\_utility::spawn_anim_model("player_rig", level.player.origin);
  var_1 hide();
  var_2 = spawn("script_model", (0, 0, 0));
  var_2 setModel("weapon_parabolic_knife");
  var_2 hide();
  var_2 dontcastshadows();
  var_2 linkto(var_1, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  var_0.rope = self;
  thread maps\carrier_audio::aud_carr_player_cuts_rope();
  var_3 = level.player.origin;
  var_0 thread maps\_anim::anim_first_frame_solo(var_1, "carrier_rappel_defend_player_knife");
  level.player playerlinktoblend(var_1, "tag_player", 0.4, 0.2, 0);
  var_0 thread maps\_anim::anim_single_solo(var_1, "carrier_rappel_defend_player_knife");
  var_4 = getanimlength(level.scr_anim["player_rig"]["carrier_rappel_defend_player_knife"]);
  wait 0.4;
  var_1 show();
  var_2 show();
  wait(var_4 - 0.8);
  var_5 = maps\_utility::set_z(var_0.origin - anglesToForward(var_0.angles) * 5, 1345);
  maps\carrier_code::lerp_player_to_position_accurate(var_5, 0.35);
  level.player.active_rope = undefined;
  level.player unlink();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player enableweapons();
  level.player allowmelee(1);
  level.player disableinvulnerability();
  level.player enableweaponswitch();
  level.player enableoffhandweapons();
  var_2 delete();
  var_1 delete();

  if(common_scripts\utility::flag("defend_osprey_online") && !maps\carrier_code::eval(level.player.osprey_control))
    level.player thread maps\carrier_depth_charge::depth_charge_give_control();
}

cut_the_rope_notetrack(var_0) {
  cut_rope_anim(self.rope, 1);
}

cut_rope_anim(var_0, var_1) {
  var_0.iscutdown = 1;
  level.player.can_cut = 0;
  var_0 notify("cut");
  level.player allowmelee(1);
  level.cut_ropes = common_scripts\utility::array_add(level.cut_ropes, var_0);

  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_3 in var_0.rappellers) {
    if(isalive(var_3) && !maps\carrier_code::eval(var_3.dead)) {
      var_3 notify("cut");
      var_3.player_cut = var_1;
    }
  }

  var_0 show();

  if(isDefined(var_0.static))
    var_0.static delete();

  maps\_anim::anim_single_solo(var_0, "carrier_rappel_defend_rope_cut");

  if(isDefined(var_0))
    var_0 moveto(var_0.origin - (0, 0, 500), 0.5, 0.5);

  var_0 thread cleanup_rope();
}