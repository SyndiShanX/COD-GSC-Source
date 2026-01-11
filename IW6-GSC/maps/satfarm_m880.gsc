/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm_m880.gsc
*****************************************************/

satfarm_m880_init(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_0);
  }
  else {
    var_3 = maps\_vehicle::spawn_vehicle_from_targetname(var_0);
  }

  level.air_strip_m880s = common_scripts\utility::array_add(level.air_strip_m880s, var_3);
  var_3 maps\_utility::ent_flag_init("launch_prep");
  var_3 maps\_utility::ent_flag_init("launch_done");
  var_3.animname = "m880";
  var_3 thread maps\satfarm_code::toggle_thermal_npc();
  var_3 enableaimassist();
  var_3.obj_index = level.air_strip_m880s.size;

  if(isDefined(var_2)) {
    objective_additionalentity(maps\_utility::obj(var_2), level.air_strip_m880s.size, var_3, (0, 0, 100));
    var_3 thread death_watcher();
  }

  var_3 thread maps\satfarm_code::target_settings();

  if(isDefined(var_1)) {
    var_3 thread launch_prep_drive();
  }
  else {
    var_3 thread launch_prep_static();
  }
}

death_watcher() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_4) && (isDefined(var_1) && (var_1 == level.playertank || var_1 == level.player))) {
      var_4 = tolower(var_4);

      if(var_4 == "mod_projectile") {
        objective_additionalposition(maps\_utility::obj("air_strip_defenses"), self.obj_index, (0, 0, 0));
        level.air_strip_m880s = common_scripts\utility::array_remove(level.air_strip_m880s, self);
        playFX(level._effect["vfx_big_880_explosion"], self.origin, anglestoup(self.angles));
        thread common_scripts\utility::play_sound_in_space("satf_turret_explosion", self.origin);
        maps\_vehicle::godoff();
        self kill();
        var_5 = spawn("script_model", self.origin);
        var_5 setModel("vehicle_m880_launcher_destroyed");
        var_5.angles = self.angles;
        level.air_strip_m880_corpses = common_scripts\utility::array_add(level.air_strip_m880_corpses, var_5);

        if(isDefined(self)) {
          self delete();
        }

        level.air_strip_m880_death_count++;
        return;
      }
    }

    wait 0.05;
  }
}

launch_prep_drive() {
  self endon("death");

  for(;;) {
    maps\_utility::ent_flag_wait("launch_prep");
    maps\_utility::ent_flag_clear("launch_prep");
    maps\_vehicle_code::suspend_drive_anims();
    thread m880_waits();
    maps\_anim::anim_single_solo(self, "launch_prep");
    wait 1.0;
    maps\_anim::anim_single_solo(self, "launch");
    thread maps\_vehicle_code::animate_drive_idle();
    maps\_utility::ent_flag_set("launch_done");
    wait 0.05;
    maps\_utility::ent_flag_clear("launch_done");
  }
}

launch_prep_static() {
  self endon("death");

  for(;;) {
    wait(randomfloatrange(3.0, 5.0));
    maps\_vehicle_code::suspend_drive_anims();
    thread m880_waits();
    maps\_anim::anim_single_solo(self, "launch_prep");
    wait 1.0;
    maps\_anim::anim_single_solo(self, "launch");
    thread maps\_vehicle_code::animate_drive_idle();
  }
}

m880_waits() {
  self endon("death");
  self endon("launch_done");
  self waittillmatch("single anim", "fire_missile_01");
  thread m880_missile("01");
  thread common_scripts\utility::play_sound_in_space("satf_m880_launch", self.origin);
  self waittillmatch("single anim", "fire_missile_02");
  thread m880_missile("02");
  thread common_scripts\utility::play_sound_in_space("satf_m880_launch", self.origin);
  self waittillmatch("single anim", "fire_missile_03");
  thread m880_missile("03");
  thread common_scripts\utility::play_sound_in_space("satf_m880_launch", self.origin);
  self waittillmatch("single anim", "fire_missile_04");
  thread m880_missile("04");
  thread common_scripts\utility::play_sound_in_space("satf_m880_launch", self.origin);
}

m880_missile(var_0, var_1) {
  self endon("death");
  self endon("launch_done");
  var_2 = "m880_missile_" + var_0;
  var_3 = maps\_utility::spawn_anim_model(var_2);

  if(!isDefined(var_1)) {
    thread fx_missile_launch(var_0);
  }

  var_4 = "m880_missile_" + var_0;
  var_3 thread m880_missile_trail_fx();
  thread maps\_anim::anim_single_solo(var_3, var_4);
}

m880_missile_trail_fx() {
  playFXOnTag(level._effect["vfx_missile_smoke_geotrail"], self, "tag_fx");
  wait 0.01;
  playFXOnTag(level._effect["m880_missile_begin"], self, "tag_fx");
  self waittillmatch("single anim", "end");
  stopFXOnTag(level._effect["vfx_missile_smoke_geotrail"], self, "tag_fx");
  stopFXOnTag(level._effect["m880_missile_begin"], self, "tag_fx");
  wait 0.05;
  self delete();
}

fx_missile_launch(var_0) {
  self endon("death");
  self endon("launch_done");
  var_1 = "rocket_cover_rear_" + var_0 + "_jnt";

  if(var_0 != "01") {
    wait 0.5;
  }

  playFXOnTag(level._effect["m880_afterburn_ignite"], self, var_1);
}

setup_ambient_missile_launches(var_0, var_1) {
  level endon(var_1);
  var_2 = getEntArray(var_0, "targetname");

  for(;;) {
    var_3 = common_scripts\utility::random(var_2);
    wait 0.2;
    var_3 playSound("satf_m880_launch");
    var_3 thread m880_missile("01", 1);
    wait 0.2;
    var_3 thread m880_missile("02", 1);
    wait 0.2;
    var_3 thread m880_missile("03", 1);
    wait 0.2;
    var_3 thread m880_missile("04", 1);
    wait(randomfloatrange(5.0, 10.0));
  }
}