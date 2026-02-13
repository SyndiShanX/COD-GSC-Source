/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\anim\face.gsc
*************************************************/

_id_CB6D(var_0) {
  if(self._id_04B9 != "soldier" && self._id_04B9 != "civilian" && self._id_04B9 != "juggernaut" && self._id_04B9 != "suicidebomber") {
    return;
  }
  var_1 = undefined;

  switch (var_0) {
    case "meleeattack":
    case "meleecharge":
      var_2 = 0.5;
      break;
    case "flashbang":
      var_2 = 0.7;
      var_1 = 50;
      break;
    case "pain":
      var_2 = 0.9;
      var_1 = 98;
      break;
    case "seekerattack":
    case "explodeath":
    case "incendeath":
    case "falldeath":
    case "flamedeath":
    case "death":
      var_2 = 1.0;
      break;
    default:
      var_2 = 0.3;
      break;
  }

  if(isDefined(var_1) && randomint(100) > var_1) {
    return;
  }
  var_3 = undefined;
  var_4 = "generic_";
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(self._id_2359) && isDefined(self._id_2359._id_A6D6)) {
    switch (self._id_2359._id_A6D6) {
      case "ksh":
      case "eth":
      case "slt":
      case "brk":
      case "omr":
      case "adm":
      case "mac":
        var_5 = self._id_2359._id_A6D6;
        var_4 = "hero_";
        var_6 = 1;
        break;
    }
  }

  if(!isDefined(var_5)) {
    switch (self._id_10691) {
      case "sas":
      case "unitednationshelmet":
      case "unitednations":
      case "unitedstates":
      case "fsa":
        var_5 = "friendly";
        var_6 = anim._id_A785;
        break;
      case "unitedstatesfemale":
      case "russianfemale":
      case "unitednationsfemale":
      case "alqatalafemale":
      case "sasfemale":
      case "fsafemale":
        var_5 = "friendly";
        var_4 = "woman_";
        var_6 = anim._id_A784;
        break;
      case "c6":
        var_5 = "c6";
        var_6 = 1;
        break;
      default:
        var_5 = "enemy";
        var_6 = anim._id_A77D;
    }
  }

  var_3 = 1 + self getentitynumber() % var_6;
  var_5 = var_5 + "_" + var_3;
  var_7 = undefined;

  if(!isDefined(var_7)) {
    if(isDefined(self._id_62A4)) {
      var_7 = self._id_62A4 + "_" + var_0 + "_" + var_5;
    } else {
      var_7 = var_4 + var_0 + "_" + var_5;
    }

    if(!_func_0205(var_7)) {
      var_7 = "generic_" + var_0 + "_" + var_5;
    }
  }

  if(getdvarint("#x39cb63f850cbec3e8", 1)) {}

  thread _id_B833(var_7, undefined);
}

_id_CB6F(var_0, var_1) {
  thread _id_B833(var_0, var_1);
}

saybattlechatterdialogue(var_0) {
  if(self._id_04B9 != "soldier" && self._id_04B9 != "civilian" && self._id_04B9 != "juggernaut" && self._id_04B9 != "suicidebomber") {
    return;
  }
  if(!isDefined(self._id_10691) || !isDefined(self._id_2359._id_3DA9)) {
    return;
  }
  var_1 = getexerttype(var_0);
  var_2 = getexertalias(var_1);
  thread _id_B833(var_2);

  if(istrue(self._id_237A)) {
    self._id_2359._id_3DA9 = undefined;
    self._id_2359._id_A6D6 = undefined;
  }
}

_id_B833(var_0, var_1) {
  if(isai(self)) {
    self._id_0DDF._id_588D = 1;
    self._id_0DDF._id_5890 = 1;
  }

  if(isDefined(var_1)) {
    if(isDefined(var_0)) {
      _id_B832(var_0, "animscript facesound" + var_1, 1);
      thread _id_10803(var_1);
    }
  } else
    _id_B832(var_0);
}

_id_B832(var_0, var_1, var_2) {
  if(isai(self)) {
    self[[anim._id_2F52["PlaySoundAtViewHeight"]]](var_0, var_1, var_2);
  } else if(isDefined(var_1) && isDefined(var_2)) {
    self playSound(var_0, var_1, var_2);
  } else if(isDefined(var_1)) {
    self playSound(var_0, var_1);
  } else {
    self playSound(var_0);
  }
}

_id_10803(var_0) {
  self endon("death");
  self waittill("animscript facesound" + var_0);
  self notify(var_0);
}

_id_820D() {
  anim._id_A77D = 7;
  anim._id_A785 = 7;
  anim._id_A784 = 3;
  _id_8190();
}

_id_8190() {
  anim._id_5889 = [];
}

_id_18AA(var_0) {
  return _func_0011(var_0, "facial_override");
}

#using_animtree("generic_human");

_id_B834(var_0, var_1, var_2) {
  if(isDefined(self._id_2463) && self._id_2463) {
    self _meth_85EF(%head, 0.2);
  } else {
    if(isDefined(var_0) && _id_18AA(var_0)) {
      self _meth_85EF(%head, 0.2);
      return;
    }

    if(!isDefined(anim._id_5889[var_1])) {
      return;
    }
    if(isDefined(var_2) && var_2 >= 0 && var_2 < anim._id_5889[var_1].size) {
      var_3 = var_2;
    } else {
      var_3 = randomint(anim._id_5889[var_1].size);
    }

    var_4 = anim._id_5889[var_1][var_3];
    self _meth_82DB(var_4);
  }
}

getexerttype(var_0) {
  var_1 = "";

  switch (var_0) {
    case "death_generic":
      var_1 = "death_short";
      break;
    case "death_melee":
      var_1 = "death_short";
      break;
    case "death_explode":
      var_1 = scripts\engine\utility::random(["death_short", "death_med"]);
      break;
    case "death_fall":
      var_1 = scripts\engine\utility::random(["death_short", "death_med"]);
      break;
    case "death_incendiary":
      var_1 = scripts\engine\utility::random(["death_long", "death_fire"]);
      break;
    case "melee_attack":
      var_1 = "thrust";
      break;
    case "melee_charge":
      var_1 = scripts\engine\utility::random(["bayonet_charge", "lunge"]);
      break;
    default:
      var_1 = var_0;
      break;
  }

  var_1 = "exert_" + var_1;
  return var_1;
}

getexertalias(var_0) {
  var_1 = "";
  var_2 = undefined;

  switch (var_0) {
    case "exert_pain":
      var_2 = "agon";
      break;
    case "exert_death_short":
      var_2 = "dsrt";
      break;
    case "exert_death_med":
      var_2 = "dmed";
      break;
    case "exert_death_long":
      var_2 = "dlon";
      break;
    case "exert_lunge":
      var_2 = "lung";
      break;
    case "exert_death_fire":
      var_2 = "dfre";
      break;
    case "exert_grapple":
      var_2 = "grap";
      break;
    case "exert_death_knife":
      var_2 = "ktht";
      break;
    case "exert_death_lung":
      var_2 = "lwbl";
      break;
    case "exert_bayonet_charge":
      var_2 = "barc";
      break;
    case "exert_scurry":
      var_2 = "swbl";
      break;
    case "exert_thrust":
      var_2 = "ssth";
      break;
    default:
      break;
  }

  if(isDefined(var_2)) {
    var_3 = "";

    if(isDefined(self._id_2359._id_A6D6)) {
      var_3 = self._id_2359._id_A6D6;
    }

    var_1 = "sp_spbc_gbbc_" + self._id_2359._id_3DA9 + var_3 + "_" + var_2;

    if(getdvarint("#x39cb63f850cbec3e8", 1)) {}
  }

  return var_1;
}