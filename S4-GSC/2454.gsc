/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2454.gsc
*************************************************/

_id_811E() {
  level._id_11018 = [];
  _id_C237("space_helmet", 200, "head", "ref_space_helmet_02_zombie", "tag_eye", (-4, 0, -1), (0, 90, 12));
}

_id_C237(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.health = var_1;
  var_7.model = var_3;
  var_7._id_79A8 = var_2;
  var_7._id_0427 = var_4;
  var_7._id_96BE = var_5;
  var_7._id_1787 = var_6;
  level._id_11018[var_0] = var_7;
}

_id_5548(var_0) {
  if(!_id_30C3(var_0)) {
    return;
  }
  foreach(var_2 in _id_6368()) {
    _id_5547(var_0, var_2);
  }
}

_id_5547(var_0, var_1) {
  if(!isDefined(var_0._id_554D)) {
    var_0._id_554D = [];
  }

  var_2 = level._id_11018[var_1];
  var_3 = var_0 gettagorigin(var_2._id_0427);
  var_4 = spawn("script_model", var_3);
  var_4 setModel(var_2.model);
  var_4.angles = var_0.angles;
  var_4._id_58FA = var_2.health;
  var_4 linkto(var_0, var_2._id_0427, var_2._id_96BE, var_2._id_1787);
  var_4 thread _id_1B35(var_4, var_0);
  var_0._id_554D[var_2._id_79A8] = var_4;
}

_id_BD4A(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_0._id_49D8)) {
    return var_2;
  }

  if(!isDefined(var_0._id_554D)) {
    return var_2;
  }

  var_5 = var_0._id_554D[var_3];

  if(!isDefined(var_5)) {
    return var_2;
  }

  if(var_5._id_58FA <= 0) {
    return var_2;
  }

  var_5 notify("damage", var_2, var_1, var_4);
  return 0;
}

_id_383D(var_0) {
  if(!isDefined(var_0._id_554D)) {
    return;
  }
  foreach(var_2 in var_0._id_554D) {
    if(isDefined(var_2)) {
      var_2 notify("damage", var_2._id_58FA);
    }
  }
}

_id_1B35(var_0, var_1) {
  var_0 setCanDamage(1);
  var_0.health = 999999;
  var_2 = gettime();
  var_3 = undefined;

  for(;;) {
    var_0 waittill("damage", var_4, var_5, var_6);

    if(istrue(level._id_82F4)) {
      var_4 = var_0._id_58FA;

      if(isDefined(var_1)) {
        var_1 dodamage(var_1.health, var_0.origin);
      }
    }

    var_7 = gettime();

    if(var_7 != var_2) {
      if(isPlayer(var_5)) {
        var_5 _id_071B::_id_FC47("hitalienarmor");
      }

      var_2 = var_7;
      var_3 = var_6;
      var_0._id_58FA = var_0._id_58FA - var_4;

      if(var_0._id_58FA <= 0) {
        break;
      }
    }
  }

  var_0 thread _id_4882(var_0, var_3);
}

_id_4882(var_0, var_1) {
  var_1 = _id_9FFE(var_1);

  if(isDefined(var_1)) {
    var_2 = spawn("script_model", var_0.origin);
    var_2 setModel(var_0.model);
    var_2.angles = var_0.angles;
    wait 0.1;
    var_0 delete();
    var_2 _meth_8254(var_2.origin, var_1);
    var_2 thread _id_464F(var_2);
  } else
    var_0 thread _id_464F(var_0);
}

_id_9FFE(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_0 = vectornormalize((var_0[0], var_0[1], 0));
  var_0 = var_0 + (0, 0, 1);
  return vectornormalize(var_0) * 1250;
}

_id_464F(var_0) {
  wait 5.0;
  var_0 delete();
}

_id_6368() {
  var_0 = 6000;

  if(level._id_10C9F >= var_0) {
    if(randomint(100) <= level._id_10C9F) {
      return ["space_helmet"];
    }
  }

  return [];
}

_id_30C3(var_0) {
  if(var_0 _id_0909::_id_887B()) {
    return 0;
  }

  return 1;
}