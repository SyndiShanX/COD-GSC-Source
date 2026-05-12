/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_type_38.gsc
*******************************************************/

func_00D5() {
  while(!isDefined(level.var_0A50) || !isDefined(level.var_0A50["zombie_generic"])) {
    wait 0.05;
  }

  level.zmb_type_38_dmg = int(maps\mp\gametypes\zombies::func_1E59(lib_0547::func_0A51("zombie_generic"), 35));
  common_scripts\utility::func_092C("tesla_gun_explosion", "vfx/explosion/tesla_gun_explosion");
  lib_0547::func_7BA9(::type_38_killtracking);
}

type_38_killtracking(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!issubstr(lib_0547::func_AAF9(param_04, 1), "arisaka_pap_zm") && !issubstr(lib_0547::func_AAF9(param_04, 1), "lad_pap_zm") && !issubstr(lib_0547::func_AAF9(param_04, 1), "austen_pap_zm") && !issubstr(lib_0547::func_AAF9(param_04, 1), "m712_pap_zm")) {
    return;
  }

  if(lib_0547::func_5565(param_03, "MOD_ENERGY")) {
    return;
  }

  if(!isDefined(param_01) || !isPlayer(param_01)) {
    return;
  }

  param_01 add_one_type_38_kill(self.var_0116, issubstr(lib_0547::func_AAF9(param_04, 1), "m712_pap_zm"), issubstr(lib_0547::func_AAF9(param_04, 1), "lad_pap_zm"));
}

add_one_type_38_kill(param_00, param_01, param_02) {
  if(!isDefined(self.type38kills)) {
    set_type_38_data();
  }

  self.type38kills++;
  if(common_scripts\utility::func_562E(param_02)) {
    self.type38kills++;
  }

  if(self.type38kills >= self.type38goal) {
    set_type_38_data();
    thread spawn_electro_blast(param_00, param_01);
  }
}

spawn_electro_blast(param_00, param_01) {
  self endon("disconnect");
  playFX(common_scripts\utility::func_44F5("tesla_gun_explosion"), param_00);
  playsoundatpos(param_00, "zmb_wonder_weapon_proj_impact");
  wait 0.05;
  if(common_scripts\utility::func_562E(param_01)) {
    foreach(var_03 in lib_0547::func_408F()) {
      var_03 attempt_to_stun(self, param_00);
    }

    return;
  }

  self entityradiusdamage(param_00, 175, level.zmb_type_38_dmg, int(level.zmb_type_38_dmg * 0.8), self, "MOD_ENERGY", "none");
}

set_type_38_data() {
  self.type38kills = 0;
  self.type38goal = get_type_38_goal();
}

get_type_38_goal() {
  return randomintrange(8, 12);
}

attempt_to_stun(param_00, param_01) {
  var_02 = self;
  if(!isDefined(var_02) || !isDefined(var_02.var_0A4B) || !common_scripts\utility::func_0F79(level.giest_bubble_voulnerable_zombies, var_02.var_0A4B)) {
    return;
  }

  if(distance(param_01, var_02.var_0116) > 165) {
    return;
  }

  if(common_scripts\utility::func_562E(var_02.var_98EF)) {
    return;
  }

  var_02.geistshieldattacker = param_00;
  var_02.giest_shield_origin = param_01;
  var_03 = 4;
  if(randomint(10) == 1) {
    var_03 = 180;
  }

  var_04 = shield_tesla_shock_params_create(var_02.var_0116, param_00, undefined, var_03);
  var_02 thread lib_0547::func_7D1A("tesla_shock", [var_04], 2);
  var_02 thread loop_spark_fx();
}

loop_spark_fx() {
  self endon("death");
  self notify("new_loop_spark_fx");
  self endon("new_loop_spark_fx");
  while(!common_scripts\utility::func_562E(self.var_98EF)) {
    wait 0.05;
  }

  while(common_scripts\utility::func_562E(self.var_98EF)) {
    play_shield_zombie_shock_vfx();
    wait(randomfloat(1.7) + 0.8);
  }
}

play_shield_zombie_shock_vfx() {
  playFXOnTag(common_scripts\utility::func_44F5("tesla blood shock"), self, "j_spine4");
}

shield_tesla_shock_params_create(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.var_29A8 = param_00;
  var_04.var_721C = param_01;
  var_04.var_6AA0 = param_02;
  var_04.var_8365 = param_03;
  return var_04;
}