/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombie_armor.gsc
***********************************************/

func_97AF() {
  level.var_13F0F = [];
  func_DEE1("space_helmet", 200, "head", "ref_space_helmet_02_zombie", "tag_eye", (-4, 0, -1), (0, 90, 12));
}

func_DEE1(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = spawnStruct();
  var_07.health = param_01;
  var_07.model = param_03;
  var_07.hitloc = param_02;
  var_07.physics_setgravitydynentscalar = param_04;
  var_07.var_AEBA = param_05;
  var_07.var_1E79 = param_06;
  level.var_13F0F[param_00] = var_07;
}

func_668D(param_00) {
  if(!func_381A(param_00)) {
    return;
  }

  foreach(var_02 in func_782B()) {
    func_668C(param_00, var_02);
  }
}

func_668C(param_00, param_01) {
  if(!isDefined(param_00.var_6691)) {
    param_00.var_6691 = [];
  }

  var_02 = level.var_13F0F[param_01];
  var_03 = param_00 gettagorigin(var_02.physics_setgravitydynentscalar);
  var_04 = spawn("script_model", var_03);
  var_04 setModel(var_02.model);
  var_04.angles = param_00.angles;
  var_04.fake_health = var_02.health;
  var_04 linkto(param_00, var_02.physics_setgravitydynentscalar, var_02.var_AEBA, var_02.var_1E79);
  var_04 thread func_217F(var_04, param_00);
  param_00.var_6691[var_02.hitloc] = var_04;
}

process_damage_to_armor(param_00, param_01, param_02, param_03, param_04) {
  if(scripts\engine\utility::istrue(param_00.disable_armor)) {
    return param_02;
  }

  if(!isDefined(param_00.var_6691)) {
    return param_02;
  }

  var_05 = param_00.var_6691[param_03];
  if(!isDefined(var_05)) {
    return param_02;
  }

  if(var_05.fake_health <= 0) {
    return param_02;
  }

  var_05 notify("damage", param_02, param_01, param_04);
  return 0;
}

clean_up_zombie_armor(param_00) {
  if(!isDefined(param_00.var_6691)) {
    return;
  }

  foreach(var_02 in param_00.var_6691) {
    if(isDefined(var_02)) {
      var_02 notify("damage", var_02.fake_health);
    }
  }
}

func_217F(param_00, param_01) {
  param_00 setCanDamage(1);
  param_00.health = 999999;
  var_02 = gettime();
  var_03 = undefined;
  for(;;) {
    param_00 waittill("damage", var_04, var_05, var_06);
    if(scripts\engine\utility::istrue(level.insta_kill)) {
      var_04 = param_00.fake_health;
      if(isDefined(param_01)) {
        param_01 dodamage(param_01.health, param_00.origin);
      }
    }

    var_07 = gettime();
    if(var_07 != var_02) {
      if(isplayer(var_05)) {
        var_05 scripts\cp\cp_damage::updatedamagefeedback("hitalienarmor");
      }

      var_02 = var_07;
      var_03 = var_06;
      param_00.fake_health = param_00.fake_health - var_04;
      if(param_00.fake_health <= 0) {
        break;
      }
    }
  }

  param_00 thread func_5386(param_00, var_03);
}

func_5386(param_00, param_01) {
  param_01 = modify_apache_lifetime(param_01);
  if(isDefined(param_01)) {
    var_02 = spawn("script_model", param_00.origin);
    var_02 setModel(param_00.model);
    var_02.angles = param_00.angles;
    wait(0.1);
    param_00 delete();
    var_02 physicslaunchclient(var_02.origin, param_01);
    var_02 thread func_50AF(var_02);
    return;
  }

  param_00 thread func_50AF(param_00);
}

modify_apache_lifetime(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  param_00 = vectornormalize((param_00[0], param_00[1], 0));
  param_00 = param_00 + (0, 0, 1);
  return vectornormalize(param_00) * 1250;
}

func_50AF(param_00) {
  wait(5);
  param_00 delete();
}

func_782B() {
  var_00 = 6000;
  if(level.wave_num >= var_00) {
    if(randomint(100) <= level.wave_num) {
      return ["space_helmet"];
    }
  }

  return [];
}

func_381A(param_00) {
  if(param_00 scripts\asm\zombie\zombie::func_9E0F()) {
    return 0;
  }

  return 1;
}