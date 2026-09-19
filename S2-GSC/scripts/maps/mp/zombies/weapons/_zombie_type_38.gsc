/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombie_type_38.gsc
***************************************************************/

init() {
  while(!isDefined(level._id_0A50) || !isDefined(level._id_0A50["zombie_generic"]))
    waitframe();

  level.zmb_type_38_dmg = int(maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), 35));
  common_scripts\utility::_id_092C("tesla_gun_explosion", "vfx/explosion/tesla_gun_explosion");
  _id_0547::_id_7BA9(::type_38_killtracking);
}

type_38_killtracking(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!issubstr(_id_0547::_id_AAF9(var_4, 1), "arisaka_pap_zm") && !issubstr(_id_0547::_id_AAF9(var_4, 1), "lad_pap_zm") && !issubstr(_id_0547::_id_AAF9(var_4, 1), "austen_pap_zm") && !issubstr(_id_0547::_id_AAF9(var_4, 1), "m712_pap_zm")) {
    return;
  }
  if(_id_0547::_id_5565(var_3, "MOD_ENERGY")) {
    return;
  }
  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
  var_1 add_one_type_38_kill(self.origin, issubstr(_id_0547::_id_AAF9(var_4, 1), "m712_pap_zm"), issubstr(_id_0547::_id_AAF9(var_4, 1), "lad_pap_zm"));
}

add_one_type_38_kill(var_0, var_1, var_2) {
  if(!isDefined(self.type38kills))
    set_type_38_data();

  self.type38kills++;

  if(common_scripts\utility::_id_562E(var_2))
    self.type38kills++;

  if(self.type38kills >= self.type38goal) {
    set_type_38_data();
    thread spawn_electro_blast(var_0, var_1);
  }
}

spawn_electro_blast(var_0, var_1) {
  self endon("disconnect");
  playFX(common_scripts\utility::_id_44F5("tesla_gun_explosion"), var_0);
  playsoundatpos(var_0, "zmb_wonder_weapon_proj_impact");
  waitframe();

  if(common_scripts\utility::_id_562E(var_1)) {
    foreach(var_3 in _id_0547::_id_408F())
    var_3 attempt_to_stun(self, var_0);
  } else
    self radiusdamage(var_0, 175, level.zmb_type_38_dmg, int(level.zmb_type_38_dmg * 0.8), self, "MOD_ENERGY", "none");
}

set_type_38_data() {
  self.type38kills = 0;
  self.type38goal = get_type_38_goal();
}

get_type_38_goal() {
  return _randomintrange(8, 12);
}

attempt_to_stun(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2) || !isDefined(var_2._id_0A4B) || !common_scripts\utility::_id_0F79(level.giest_bubble_voulnerable_zombies, var_2._id_0A4B)) {
    return;
  }
  if(distance(var_1, var_2.origin) > 165) {
    return;
  }
  if(common_scripts\utility::_id_562E(var_2._id_98EF)) {
    return;
  }
  var_2.geistshieldattacker = var_0;
  var_2.giest_shield_origin = var_1;
  var_3 = 4;

  if(randomint(10) == 1)
    var_3 = 180;

  var_4 = shield_tesla_shock_params_create(var_2.origin, var_0, undefined, var_3);
  var_2 thread _id_0547::_id_7D1A("tesla_shock", [var_4], 2);
  var_2 thread loop_spark_fx();
}

loop_spark_fx() {
  self endon("death");
  self notify("new_loop_spark_fx");
  self endon("new_loop_spark_fx");

  while(!common_scripts\utility::_id_562E(self._id_98EF))
    waitframe();

  while(common_scripts\utility::_id_562E(self._id_98EF)) {
    play_shield_zombie_shock_vfx();
    wait(_randomfloat(1.7) + 0.8);
  }
}

play_shield_zombie_shock_vfx() {
  _playfxontag(common_scripts\utility::_id_44F5("tesla blood shock"), self, "j_spine4");
}

shield_tesla_shock_params_create(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_29A8 = var_0;
  var_4.player = var_1;
  var_4._id_6AA0 = var_2;
  var_4._id_8365 = var_3;
  return var_4;
}