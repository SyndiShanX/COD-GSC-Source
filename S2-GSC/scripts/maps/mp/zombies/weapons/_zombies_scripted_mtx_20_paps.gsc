/*****************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombies_scripted_mtx_20_paps.gsc
*****************************************************************************/

init() {
  _id_0547::_id_7BA9(::scripted_mtx20_on_death);
  common_scripts\utility::_id_092C("zmi_m2hyde_acid_dot", "vfx/zombie/prototype_fx/zombie_eye_glow_green");
  common_scripts\utility::_id_092C("zmi_m2hyde_acid_expl", "vfx/zombie/prototype_fx/mtx20/zmi_m2hyde_acid_expl");
  common_scripts\utility::_id_092C("zmi_warsaw_sparks", "vfx/zombie/prototype_fx/mtx20/zmi_warsaw_sparks");
  common_scripts\utility::_id_092C("zmi_paper_burst", "vfx/zombie/prototype_fx/mtx20/zmi_paper_burst");
  common_scripts\utility::_id_092C("zmb_green_zmb_stun", "vfx/zombie/abilities_perks/zmb_green_zmb_stun");
  common_scripts\utility::_id_092C("zmb_dp28_green_impact_lrg", "vfx/zombie/zmb_dp28_green_impact_lrg");
  level.zmb_minibosstypes = ["zombie_heavy", "zombie_fireman", "zombie_assassin", "zombie_exploder", "zombie_dlc4"];
  level.green_death_dmg = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), 10);
  level thread maps\mp\_utility::_id_6F74(::kgm21_on_reload_empty);
}

required_weapon(var_0) {
  var_1 = self;
  var_2 = var_1 getcurrentweapon();

  if(_id_0569::_id_55D4(var_2)) {
    var_2 = var_1 maps\mp\_events_z::set_last_checked_weapon(var_2);

    if(!_id_0547::_id_5565(var_2, var_0))
      return 0;
  } else
    return 0;

  return 1;
}

scripted_mtx20_on_death(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_4)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!isPlayer(var_1)) {
    return;
  }
  var_9 = self;

  if(common_scripts\utility::_id_562E(var_9.bouttoblow)) {
    playFX(common_scripts\utility::_id_44F5("zmb_dp28_green_impact"), var_9 getEye());
    level thread _id_0380::_id_2889("zmb_wpn_crossbow_cricket_explo", undefined, var_9 getEye());
  }

  if(issubstr(var_4, "m2hyde") && issubstr(var_4, "_pap_zm") && common_scripts\utility::_id_0F79(level.zmb_minibosstypes, var_9._id_0A4B)) {
    playFX(common_scripts\utility::_id_44F5("zmb_dp28_green_impact_lrg"), var_9.origin);
    level thread _id_0380::_id_2889("zmb_wpn_crossbow_cricket_explo", undefined, var_9 getEye());

    foreach(var_9 in _id_0547::_id_408F()) {
      if(common_scripts\utility::_id_0F79(level.zmb_minibosstypes, var_9._id_0A4B)) {
        continue;
      }
      if(!common_scripts\utility::_id_0F79(["zombie_generic", "zombie_berserker", "zombie_sizzler"], var_9._id_0A4B)) {
        continue;
      }
      if(common_scripts\utility::_id_562E(var_9.bouttoblow)) {
        continue;
      }
      if(_id_0547::_id_5565(self, var_9)) {
        continue;
      }
      if(distance(var_9.origin, self.origin) > 400) {
        continue;
      }
      var_9 thread green_splode(var_1);
    }
  }
}

green_splode(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_0 endon("disconnect");
  var_1.bouttoblow = 1;
  waitframe();
  _playfxontag(common_scripts\utility::_id_44F5("zmi_m2hyde_acid_dot"), var_1, "tag_eye");
  var_1 childthread loop_green_fx();
  wait(_randomfloat(3));

  for(;;) {
    wait 2;
    wait(_randomfloat(3));
    var_1 dodamage(level.green_death_dmg, var_1.origin, var_0, var_0, "MOD_RIFLE_BULLET", "m2hyde_pap_zm", "head");
  }
}

loop_green_fx() {
  var_0 = self;

  for(;;) {
    _playfxontag(common_scripts\utility::_id_44F5("zmb_green_zmb_stun"), var_0, "j_spine4");
    wait 0.75;
  }
}

kgm21_on_reload_empty() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("reload");
    var_0 attempt_reload_action(::randomize_clip_size, "kgm21_zm");
  }
}

randomize_clip_size() {
  var_0 = self;
  var_1 = _weaponclipsize(var_0.weapontoadjust, var_0);

  if(isDefined(var_0.weapontoadjust)) {
    if(randomint(3) <= 1)
      var_2 = _randomintrange(15, 20);
    else
      var_2 = _randomintrange(30, var_1);

    if(randomint(100) <= 2)
      var_2 = _randomintrange(4, 9);

    self setweaponammoclip(var_0.weapontoadjust, var_2);
    self givemaxammo(var_0.weapontoadjust);
  }
}

attempt_reload_action(var_0, var_1) {
  var_2 = self;
  var_2 endon("disconnect");

  if(!var_2 required_weapon(var_1))
    return;
  else
    var_2.weapontoadjust = var_2 getcurrentweapon();

  var_2 childthread[[var_0]]();

  while(weapon_clip_empty(var_1))
    waitframe();
}

weapon_clip_empty(var_0) {
  var_1 = self;

  if(!_id_0547::_id_5565(var_0, _id_0547::_id_AAF9(var_1 getcurrentweapon())))
    return 1;

  return var_1 getcurrentweaponclipammo() == 0;
}

sqrd_dist_between_segments(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = 0.000001;
  var_6 = var_3 - var_2;
  var_7 = var_1 - var_0;
  var_8 = var_0 - var_2;
  var_9 = vectordot(var_6, var_6);
  var_10 = vectordot(var_7, var_7);
  var_11 = vectordot(var_7, var_6);
  var_12 = vectordot(var_6, var_8);
  var_13 = vectordot(var_7, var_8);
  var_14 = var_9 * var_10 - var_11 * var_11;
  var_15 = 0;
  var_16 = 0;

  if(var_14 <= var_5) {
    if(var_11 > var_9)
      var_15 = var_13 / var_11;
    else
      var_15 = var_12 / var_9;
  } else {
    var_15 = (var_12 * var_10 - var_11 * var_13) / var_14;
    var_16 = (var_11 * var_12 - var_13 * var_9) / var_14;
  }

  var_15 = clamp(var_15, 0.0, 1.0);
  var_16 = clamp(var_16, 0.0, 1.0);
  var_17 = var_2 + var_6 * var_15;
  var_18 = var_0 + var_7 * var_16;
  var_19 = var_18 - var_17;
  var_20 = vectordot(var_19, var_19);
  var_4[1] = var_18;
  var_4[2] = var_17;
  var_4[0] = var_20;
  return var_4;
}