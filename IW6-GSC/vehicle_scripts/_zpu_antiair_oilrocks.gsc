/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_zpu_antiair_oilrocks.gsc
*****************************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("zpu_antiair", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_localoilrocks);
  maps\_vehicle::build_deathmodel("vehicle_zpu4_low", "vehicle_zpu4_burn");
  maps\_vehicle::build_deathfx("vfx/gameplay/explosions/vfx_exp_minigun_dest", undefined, "exp_armor_vehicle", undefined, undefined, undefined, 0);
  maps\_vehicle::build_mainturret("tag_flash", "tag_flash2", "tag_flash1", "tag_flash3");
  maps\_vehicle::build_radiusdamage((0, 0, 53), 512, 300, 20, 0);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_aianims(vehicle_scripts\_zpu_antiair::setanims, vehicle_scripts\_zpu_antiair::set_vehicle_anims);
  precacheitem("zpu_turret_oilrocks");
  common_scripts\utility::add_fx("oilrocks_flak", "vfx/_requests/oilrocks/zpu_tracer");
  common_scripts\utility::create_lock("zpu_targeting");
  common_scripts\utility::create_lock("zpu_can_target_while_fireing");
}

init_localoilrocks() {
  self.script_explosive_bullet_shield = 1;
  thread feelgoodapachegundeath();
  vehicle_scripts\_zpu_antiair::init_local();
  self setvehweapon("zpu_turret_oilrocks");
  thread vehicle_zpu_think();
}

feelgoodapachegundeath() {
  self endon("death");
  var_0 = 0;

  while(var_0 < level.apache_difficulty.zpu_magic_bullets) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(var_5 == "MOD_EXPLOSIVE_BULLET") {
      var_0++;
    }

    if(var_2 == level.player) {
      break;
    }
  }

  maps\_vehicle::force_kill();
}

vehicle_zpu_think() {
  self endon("death");
  self.fxid = common_scripts\utility::getfx("FX_oilrocks_turret_flash_zpu");
  self.flakfxid = common_scripts\utility::getfx("oilrocks_flak");

  for(;;) {
    common_scripts\utility::lock("zpu_targeting");
    var_0 = vehicle_zpu_get_target();
    common_scripts\utility::unlock("zpu_targeting");

    if(isDefined(var_0)) {
      thread vehicle_zpu_register_target(var_0);
      vehicle_zpu_shoot_target(var_0);
      self notify("LISTEN_zpu_finished_targeting");
      wait 0.9;
      continue;
    }

    wait(randomfloatrange(0.4, 0.6));
  }
}

vehicle_zpu_get_target() {
  var_0 = maps\oilrocks_apache_code::get_apache_player();

  if(vehicle_zpu_can_target(var_0, 3)) {
    var_1 = var_0;
  }
  else {
    var_2 = maps\oilrocks_apache_code::get_apaches_ally_and_player();
    var_2 = sortbydistance(var_2, self.origin);
    var_1 = undefined;

    for(var_3 = 1; var_3 <= 3; var_3++) {
      foreach(var_5 in var_2) {
        if(vehicle_zpu_can_target(var_5, var_3)) {
          var_1 = var_5;
          break;
        }
      }
    }
  }

  return var_1;
}

vehicle_zpu_can_target(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(var_0.zpus_targeting) && var_0.zpus_targeting >= var_1) {
    return 0;
  }

  if(distancesquared(self.origin, var_0.origin) > level.apache_difficulty.zpu_range_squared) {
    return 0;
  }

  if(!sighttracepassed(self.origin, var_0.origin, 0, self, var_0)) {
    return 0;
  }

  return 1;
}

vehicle_zpu_register_target(var_0) {
  if(!isDefined(var_0.zpus_targeting)) {
    var_0.zpus_targeting = 1;
  }
  else {
    var_0.zpus_targeting++;
  }

  common_scripts\utility::waittill_either("death", "LISTEN_zpu_finished_targeting");

  if(!isDefined(var_0)) {
    return;
  }
  var_0.zpus_targeting--;

  if(var_0.zpus_targeting <= 0) {
    var_0.zpus_targeting = undefined;
  }
}

vehicle_zpu_shoot_target(var_0) {
  var_0 endon("death");
  self setturrettargetent(var_0, (0, 0, -96));
  var_0.request_move = 1;
  var_0 notify("request_move_update");
  var_1 = 0;
  var_2 = 0.05;
  var_3 = maps\oilrocks_apache_code::get_apache_player();

  if(isDefined(var_3) && var_3 != var_0) {
    var_1 = 1;
  }

  if(var_1) {
    var_4 = randomintrange(25, 35);
    var_2 = 0.15;
  } else
    var_4 = 55;

  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_0.request_move = 1;
    var_0 notify("request_move_update");

    if(var_5 % 3 == 0) {
      playFXOnTag(self.flakfxid, self, "tag_flash");
    }

    if(var_1) {
      playFXOnTag(self.fxid, self, "tag_flash");
    }

    self fireweapon();
    wait(var_2);

    if(var_5 % 10 == 0) {
      common_scripts\utility::lock("zpu_can_target_while_fireing");
      var_6 = vehicle_zpu_can_target(var_0, 3);
      common_scripts\utility::unlock("zpu_can_target_while_fireing");
    } else
      var_6 = 1;

    if(!var_6) {
      break;
    }
  }
}