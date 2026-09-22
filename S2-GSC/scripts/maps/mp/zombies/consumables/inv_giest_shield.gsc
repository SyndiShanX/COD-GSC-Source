/********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\consumables\inv_giest_shield.gsc
********************************************************************/

_id_52A4() {
  _id_0561::initconsumablesfromtable("power_shield", ::useshieldconsumable, ::canuseshieldconsumable, ::getshieldconsumablecharges);
  common_scripts\utility::_id_092C("tesla blood shock", "vfx/zombie/abilities_perks/zmb_blood_zmb_stun");
  common_scripts\utility::_id_092C("tesla blood shock", "vfx/zombie/abilities_perks/zmb_blood_zmb_stun");
  level.giest_bubble_voulnerable_zombies = ["zombie_generic", "zombie_berserker", "zombie_heavy", "zombie_exploder", "zombie_sizzler", "zombie_assassin"];

  if(!(maps\mp\_utility::_id_4571() == "mp_zombie_island")) {
    level thread maps\mp\zombies\weapons\_zombie_aoe_grenade::init_pommel_aud();
  }

  common_scripts\utility::_id_092C("zmb_player_consumable_bubble", "vfx/zombie/zmb_csm_player_bubble");
}

canuseshieldconsumable(var_0) {
  if(!_id_0561::_id_1F7B()) {
    return 0;
  }

  return 1;
}

useshieldconsumable(var_0) {
  var_1 = self;
  var_1 thread spawn_a_giest_bubble_shield(var_1.origin);
}

shield_tesla_shock_params_create(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_29A8 = var_0;
  var_4.player = var_1;
  var_4._id_6AA0 = var_2;
  var_4._id_8365 = var_3;
  return var_4;
}

spawn_a_giest_bubble_shield(var_0, var_1) {
  var_2 = self;
  var_2 endon("disconnect");
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_4 = _id_0547::_id_8FBA(var_3, "zmb_player_consumable_bubble");
  _triggerfx(var_4);
  _id_0378::_id_8D74("zmb_pomel_grenade_detonate", var_3.origin);
  _id_0378::_id_8D74("zmb_pomel_grenade_force_field", var_3.origin);
  var_5 = gettime();
  var_6 = 15;

  if(isDefined(var_1)) {
    var_6 = var_1;
  }

  if(!isDefined(var_1)) {
    var_2 thread _id_057A::_id_259E("consumable_zm_weapon_shield", var_6);
  }

  while(int(gettime() - var_5) / 1000 < var_6) {
    foreach(var_8 in _id_0547::_id_408F()) {
      if(!isDefined(var_8._id_0A4B) || !common_scripts\utility::_id_0F79(level.giest_bubble_voulnerable_zombies, var_8._id_0A4B)) {
        continue;
      }
      if(distance(var_3.origin, var_8.origin) > 120) {
        continue;
      }
      if(common_scripts\utility::_id_562E(var_8._id_98EF)) {
        continue;
      }
      var_8.geistshieldattacker = var_3;
      var_8.giest_shield_origin = var_3.origin;
      var_9 = shield_tesla_shock_params_create(var_8.origin, var_2);
      var_9._id_6AA0 = ::death_shock_launch;
      var_8 thread _id_0547::_id_7D1A("tesla_shock", [var_9], 2);
      var_8 thread loop_spark_fx();
    }

    foreach(var_12 in level.players) {
      if(distance(var_3.origin, var_12.origin) > 120 && !common_scripts\utility::_id_562E(var_12.isgiestshieldaffected)) {
        var_12.isgiestshieldaffected = 1;
        var_12 _id_0378::_id_8D74("aud_strt_asn_camo_blur");
        continue;
      }

      if(common_scripts\utility::_id_562E(var_12.isgiestshieldaffected)) {
        var_12.isgiestshieldaffected = 1;
        var_12 _id_0378::_id_8D74("aud_stp_asn_camo_blur");
      }
    }

    waitframe();
  }

  foreach(var_15 in _id_0547::_id_408F()) {
    if(!isDefined(var_15._id_0A4B) || !common_scripts\utility::_id_0F79(level.giest_bubble_voulnerable_zombies, var_15._id_0A4B)) {
      continue;
    }
    if(_id_0547::_id_5565(var_15.geistshieldattacker, var_3)) {
      var_15 thread death_shock_launch();
    }
  }

  var_4 delete();
  playFX(level._effect["force_zombie_bubble_pop"], var_3.origin);
  _id_0378::_id_8D74("zmb_pomel_grenade_final_explosion", var_3.origin);
}

loop_spark_fx() {
  self endon("death");
  self notify("new_loop_spark_fx");
  self endon("new_loop_spark_fx");

  while(!common_scripts\utility::_id_562E(self._id_98EF)) {
    waitframe();
  }

  while(common_scripts\utility::_id_562E(self._id_98EF)) {
    play_shield_zombie_shock_vfx();
    wait(_randomfloat(1.7) + 0.8);
  }
}

play_shield_zombie_shock_vfx() {
  _playFXOnTag(common_scripts\utility::_id_44F5("tesla blood shock"), self, "j_spine4");
}

death_shock_launch(var_0) {
  var_1 = 10000;
  var_2 = self;
  var_3 = var_2.giest_shield_origin - var_2.origin;
  var_3 = (var_3[0], var_3[1], 0);
  var_3 = var_1 * vectorNormalize(var_3) + (0, 0, var_1);
  var_4 = var_2.giest_shield_origin;

  if(isDefined(var_2.geistshieldattacker)) {
    if(!isDefined(var_2.geistshieldattacker.lastexplodetime)) {
      var_2.geistshieldattacker.lastexplodetime = gettime();
    }

    if(gettime() - var_2.geistshieldattacker.lastexplodetime > 100) {
      var_2.geistshieldattacker.lastexplodetime = gettime();
      playFX(common_scripts\utility::_id_44F5("tesla_blood_explosion"), var_2.giest_shield_origin);
      var_2 _id_0378::_id_8D74("aud_ww_blood_explode");
    }
  }

  if(isDefined(var_0) && isDefined(var_0.player)) {
    self dodamage(level.heavy_giest_dmg, self.origin, var_0.player);
  } else {
    self dodamage(level.heavy_giest_dmg, self.origin);
  }

  level thread run_explosion_sphere(var_4);
}

run_explosion_sphere(var_0) {
  waitframe();
  _physicsexplosionsphere(var_0, 250, 150, 2.7);
}

getshieldconsumablecharges(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "";
  }

  switch (var_0) {
    case "epic":
      return 4;
    case "legendary":
      return 3;
    case "rare":
      return 2;
    case "common":
      return 1;
    default:
      return 0;
  }
}