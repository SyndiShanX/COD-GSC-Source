/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3056.gsc
************************/

main(param_00, param_01, param_02) {
  scripts\sp\vehicle_build::func_31C5("support_drone", param_00, param_01, param_02);
  scripts\sp\vehicle_build::func_31A6(::init_location);
  scripts\sp\vehicle_build::func_3186(param_00);
  scripts\sp\vehicle_build::func_3187(0.3, 1.6, 2048);
  scripts\sp\vehicle_build::func_31A3(1500);
  scripts\sp\vehicle_build::func_31C4("allies");
  var_03 = randomfloatrange(0, 1);
  scripts\sp\vehicle_build::func_31C8("pocket_drone_turret", "tag_turret", "veh_mil_air_un_pocketdrone_gun", undefined, "manual", undefined, 0);
  level._effect["_mini_drone_spark"] = loadfx("vfx\core\expl\generator_sparks_a.vfx");
  level._effect["_mini_drone_smoke"] = loadfx("vfx\core\smktrail\smoke_trail_black_heli.vfx");
  level._effect["_support_drone_spawn"] = loadfx("vfx\core\expl\grenade_flash.vfx");
  level._effect["drone_damage_sparks"] = loadfx("vfx\core\expl\generator_sparks_a.vfx");
  scripts\sp\vehicle_build::func_31A0();
}

init_location() {
  self endon("death");
  self.var_ED12 = 0;
  self.var_5958 = 1;
  self.var_1D63 = 1;
  self.var_627C = 1;
  thread scripts\sp\vehicle::func_1320C("running");
  waittillframeend;
  self makeentitysentient(self.script_team);
}

func_B786() {
  self endon("death");
  var_00 = level.var_13203[self.classname];
  for(;;) {
    self waittill("damage");
    playFXOnTag(level._effect["_mini_drone_smoke"], self, "tag_engine");
    if(self.health - self.var_8CB6 <= var_00 * 0.5) {
      while(isalive(self)) {
        playFXOnTag(level._effect["_mini_drone_smoke"], self, "tag_engine");
        playFXOnTag(level._effect["_mini_drone_spark"], self, "tag_engine");
        wait(randomfloatrange(1, 2));
      }
    }
  }
}