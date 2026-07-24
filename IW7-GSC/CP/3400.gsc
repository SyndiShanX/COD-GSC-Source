/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3400.gsc
**************************************/

_id_97AF() {
  level._id_13F0F = [];
  _id_DEE1("space_helmet", 200, "head", "ref_space_helmet_02_zombie", "tag_eye", (-4, 0, -1), (0, 90, 12));
}

_id_DEE1(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.health = var_1;
  var_7.model = var_3;
  var_7.hitloc = var_2;
  var_7.tag = var_4;
  var_7._id_AEBA = var_5;
  var_7._id_1E79 = var_6;
  level._id_13F0F[var_0] = var_7;
}

_id_668D(var_0) {
  if(!_id_381A(var_0)) {
    return;
  }
  foreach(var_2 in _id_782B()) {
    _id_668C(var_0, var_2);
  }
}

_id_668C(var_0, var_1) {
  if(!isDefined(var_0._id_6691)) {
    var_0._id_6691 = [];
  }

  var_2 = level._id_13F0F[var_1];
  var_3 = var_0 gettagorigin(var_2.tag);
  var_4 = spawn("script_model", var_3);
  var_4 setModel(var_2.model);
  var_4.angles = var_0.angles;
  var_4.fake_health = var_2.health;
  var_4 linkTo(var_0, var_2.tag, var_2._id_AEBA, var_2._id_1E79);
  var_4 thread _id_217F(var_4, var_0);
  var_0._id_6691[var_2.hitloc] = var_4;
}

process_damage_to_armor(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\engine\utility::is_true(var_0.disable_armor)) {
    return var_2;
  }

  if(!isDefined(var_0._id_6691)) {
    return var_2;
  }

  var_5 = var_0._id_6691[var_3];

  if(!isDefined(var_5)) {
    return var_2;
  }

  if(var_5.fake_health <= 0) {
    return var_2;
  }

  var_5 notify("damage", var_2, var_1, var_4);
  return 0;
}

clean_up_zombie_armor(var_0) {
  if(!isDefined(var_0._id_6691)) {
    return;
  }
  foreach(var_2 in var_0._id_6691) {
    if(isDefined(var_2)) {
      var_2 notify("damage", var_2.fake_health);
    }
  }
}

_id_217F(var_0, var_1) {
  var_0 setCanDamage(1);
  var_0.health = 999999;
  var_2 = gettime();
  var_3 = undefined;

  for(;;) {
    var_0 waittill("damage", var_4, var_5, var_6);

    if(scripts\engine\utility::is_true(level.insta_kill)) {
      var_4 = var_0.fake_health;

      if(isDefined(var_1)) {
        var_1 dodamage(var_1.health, var_0.origin);
      }
    }

    var_7 = gettime();

    if(var_7 != var_2) {
      if(isPlayer(var_5)) {
        var_5 scripts\cp\cp_damage::updatedamagefeedback("hitalienarmor");
      }

      var_2 = var_7;
      var_3 = var_6;
      var_0.fake_health = var_0.fake_health - var_4;

      if(var_0.fake_health <= 0) {
        break;
      }
    }
  }

  var_0 thread _id_5386(var_0, var_3);
}

_id_5386(var_0, var_1) {
  var_1 = modify_apache_lifetime(var_1);

  if(isDefined(var_1)) {
    var_2 = spawn("script_model", var_0.origin);
    var_2 setModel(var_0.model);
    var_2.angles = var_0.angles;
    wait 0.1;
    var_0 delete();
    var_2 _meth_8224(var_2.origin, var_1);
    var_2 thread _id_50AF(var_2);
  } else
    var_0 thread _id_50AF(var_0);
}

modify_apache_lifetime(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_0 = vectorNormalize((var_0[0], var_0[1], 0));
  var_0 = var_0 + (0, 0, 1);
  return vectorNormalize(var_0) * 1250;
}

_id_50AF(var_0) {
  wait 5.0;
  var_0 delete();
}

_id_782B() {
  var_0 = 6000;

  if(level.wave_num >= var_0) {
    if(randomint(100) <= level.wave_num) {
      return ["space_helmet"];
    }
  }

  return [];
}

_id_381A(var_0) {
  if(var_0 scripts\asm\zombie\zombie::_id_9E0F()) {
    return 0;
  }

  return 1;
}