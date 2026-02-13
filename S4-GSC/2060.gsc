/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2060.gsc
*************************************************/

_id_A6DC(var_0, var_1) {}

_id_A6DA(var_0, var_1, var_2, var_3, var_4) {}

_id_40F7(var_0, var_1) {}

_id_40F6(var_0, var_1, var_2, var_3, var_4, var_5) {}

_id_40F5(var_0, var_1, var_2, var_3, var_4) {}

_id_A6DB(var_0, var_1, var_2, var_3, var_4) {}

_id_A6D9(var_0, var_1, var_2, var_3) {}

_id_8E42() {}

_id_8E43() {}

_id_FBF4() {
  foreach(var_1 in level.players) {
    var_1 notify("updateKillStreakMarker");
  }
}

_id_D542(var_0, var_1, var_2, var_3, var_4) {}

_id_A007(var_0, var_1, var_2, var_3) {}

_id_AB18(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {}

_id_97A4(var_0, var_1) {}

_id_4F43(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 * 20);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    wait 0.05;
  }
}

_id_265F(var_0, var_1, var_2, var_3) {
  return 1;
}

_id_6AF9() {}

_id_0B66(var_0, var_1, var_2, var_3, var_4, var_5) {}

_id_D4E1() {}

_id_40F4(var_0, var_1, var_2, var_3, var_4) {}

_id_D6E9(var_0) {}

_id_D557(var_0, var_1) {}

_id_DEF2(var_0, var_1, var_2, var_3) {}

_id_D6BF(var_0, var_1, var_2) {}

_id_9519(var_0, var_1, var_2, var_3) {
  self linkto(var_0, var_1, var_2, var_3);
}

_id_D5AC(var_0, var_1, var_2, var_3, var_4, var_5) {}

_id_E289(var_0, var_1) {
  var_2 = spawn(var_0, var_1);
  var_2 setModel("tag_origin");
  return var_2;
}

_id_86F0(var_0) {
  return istrue(var_0);
}

_id_8B1D() {
  return 0;
}

_id_89D7() {
  return 0;
}

_id_2D3B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  return scripts\engine\trace::_bullet_trace(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

_id_D485(var_0) {}

_id_994B(var_0, var_1, var_2, var_3, var_4, var_5) {
  return _func_0143(var_0, var_1, var_2, var_5);
}

_hasperk(var_0) {
  if(scripts\engine\utility::is_equal(var_0, "specialty_improvedstreaks")) {
    return 0;
  }

  return self _meth_81A3(var_0);
}

waittillhostmigrationdone() {
  return scripts\mp\hostmigration::waittillhostmigrationdone();
}

_id_5AE1(var_0, var_1) {
  return _id_0817::_id_5AE1(var_0, var_1);
}

_id_4787(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_2._id_82D5 = undefined;
    }
  }

  var_0 notify("death");
  var_0 delete();
  self._id_47E8 = undefined;
}

_id_FC01() {}

_id_1BC2(var_0, var_1) {
  if(!isDefined(var_1)) {
    return undefined;
  }

  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(isDefined(var_0)) {
      if(var_0 != var_4) {
        var_2[var_2.size] = var_4;
      }

      continue;
    }

    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_9137(var_0) {}

_id_108F6(var_0, var_1) {
  self endon(var_0);

  if(var_1 == 0) {
    return;
  }
  var_2 = gettime();
  var_3 = gettime() + var_1 * 1000;

  while(gettime() < var_3) {
    _id_10959((var_3 - gettime()) / 1000);

    if(isDefined(level._id_7AAE)) {
      var_4 = waittillhostmigrationdone();
      var_3 = var_3 + var_4;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var_2;
}

_id_10959(var_0) {
  if(isDefined(level._id_7AAE)) {
    return;
  }
  level endon("host_migration_begin");
  wait(var_0);
}

_id_9B29(var_0) {}

_id_8ABD(var_0, var_1) {
  var_2 = self.team;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  if(level.teambased && isDefined(level._id_EF69) && level._id_EF69[var_2] || !level.teambased && isDefined(level._id_3DA4) && level._id_3DA4 != self) {
    if(!isDefined(var_0) || var_0) {
      self iprintlnbold(&"KILLSTREAKS_COUNTER_RECON_ACTIVE");
    }

    return 1;
  }

  return 0;
}

_id_39E1() {}

_id_B76A() {
  if(isDefined(self._id_C707)) {
    if(self.team != "spectator") {
      self setplayerangles(self._id_C707);
    }

    self._id_C707 = undefined;
  }
}

setthirdpersondof(var_0) {}

_id_0CBE() {}

_id_D8D4(var_0) {}

_id_8ACE() {
  return 0;
}

_id_3990() {}

_id_D6C5(var_0) {}

_id_6A03(var_0, var_1) {
  var_2 = scripts\engine\utility::getstructarray(var_0, var_1);
  var_3 = getEntArray(var_0, var_1);

  if(var_3.size > 0) {
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  }

  return var_2;
}

_id_2D3C(var_0, var_1, var_2, var_3) {
  return scripts\engine\trace::_bullet_trace_passed(var_0, var_1, var_2, var_3);
}

isreallyalive(var_0) {
  return scripts\mp\utility\player::isreallyalive(var_0);
}

_id_1798(var_0, var_1, var_2) {
  return vectortoangles((0, 0, -1));
}

_id_C72F(var_0, var_1) {}

_id_8D84(var_0, var_1, var_2, var_3) {}

_id_94AD(var_0) {}

_id_6E71(var_0, var_1, var_2) {
  return 400;
}

_id_5F63(var_0, var_1) {
  scripts\mp\utility\player::_freezecontrols(var_0, var_1);
}

_id_B78D() {
  self._id_C707 = self getplayerangles();
}

_id_88F6(var_0) {
  return 0;
}

_id_827A(var_0, var_1, var_2, var_3) {
  if(var_0 == "s2_fritzx") {
    return "success";
  }

  return "fail";
}

_id_99A1(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level._id_279D) && isDefined(level._id_279D["bots_make_entity_sentient"])) {
    return self[[level._id_279D["bots_make_entity_sentient"]]](var_0, var_1, var_2, var_3, var_4);
  }
}