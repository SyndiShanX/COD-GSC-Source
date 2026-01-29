/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\combat.gsc
**************************************/

main() {
  if(isDefined(self._id_10EF)) {
    return;
  }
  if(isDefined(self._id_0CB3)) {
    animscripts\snowmobile::main();
    return;
  }

  if(isDefined(self._id_10A5)) {
    if(isDefined(self._id_10A5["combat"])) {
      [[self._id_10A5["combat"]]]();
      return;
    }
  }

  self endon("killanimscript");
  [[self.defaultexception["exposed"]]]();
  animscripts\utility::_id_0D15("combat");
  self.a._id_10DF = undefined;

  if(isDefined(self.node) && self.node.type == "Ambush" && self nearnode(self.node)) {
    self._id_0CF1 = self.node;

  }
  _id_1107();
  _id_1105();
  animscripts\stop::_id_10F5();
  _id_1109();
  _id_111D();
  self notify("stop_deciding_how_to_shoot");
}

end_script() {
  self._id_0CF1 = undefined;
}

#using_animtree("generic_human");

_id_1105() {
  if(self.team != "allies") {
    return;
  }
  if(self ismovesuppressed() && self.prevscript == "move" && self.a._id_0D26 == "stand" && !isDefined(self._id_1106)) {
    if(isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) < squared(128)) {
      return;
    }
    self animmode("zonly_physics");
    self setflaggedanimknoballrestart("react", % surprise_stop_v1, % root, 1, 0.2, self._id_10F7);
    animscripts\shared::_id_0C51("react");
  }
}

_id_1107() {
  if(isDefined(self._id_10F6) || isDefined(self._id_0C89)) {
    return;
  }
  if(isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 262144) {
    return;
  }
  if(self.prevscript == "stop" && !animscripts\utility::_id_0C98() && self.a._id_0D26 == "stand") {
    self animmode("zonly_physics");
    self setflaggedanimknoballrestart("transition", % casual_stand_idle_trans_out, % root, 1, 0.2, 1.2 * self._id_10F7);
    animscripts\shared::_id_0C51("transition");
  }
}

_id_1108() {
  if(self.a._id_0D26 == "stand") {
    animscripts\animset::_id_0C94();
  } else if(self.a._id_0D26 == "crouch") {
    animscripts\animset::_id_0C99();
  } else if(self.a._id_0D26 == "prone") {
    animscripts\animset::_id_0C9C();
  } else {}
}

_id_1109() {
  if(animscripts\utility::_id_0C95() && self isstanceallowed("stand")) {
    _id_113F("stand");

  }
  _id_1108();
  _id_110E();
  thread _id_110D();
  self._id_110A = 0.0;
  self clearanim( % root, 0.2);
  animscripts\combat_utility::_id_110B(0.2);
  thread animscripts\combat_utility::_id_0F78();
  self.a._id_110C = "aim";
  _id_1142();
}

_id_110D() {
  self endon("killanimscript");
  wait 0.2;
  self.a._id_0D2B = "stop";
}

_id_110E() {
  self setdefaultaimlimits();

  if(self.a._id_0D26 == "stand") {
    self.upaimlimit = 60;
    self.downaimlimit = -60;
  }

  self._id_0F72 = self._id_110F;
}

_id_1110() {
  thread animscripts\track::_id_0CA9();
  thread _id_115E();
  thread animscripts\shoot_behavior::_id_0CD7("normal");
  thread _id_1128();
  _id_1127();

  if(isDefined(self.a._id_1111)) {
    animscripts\weaponlist::_id_0CD0();
    self.a._id_1111 = undefined;
  }

  self.a._id_1112 = gettime() + randomintrange(500, 1500);
}

_id_1113(var_0) {
  if(animscripts\utility::_id_0BB6() && (var_0 < 262144 || self.a.rockets < 1)) {
    if(self.a._id_0D26 != "stand" && self.a._id_0D26 != "crouch") {
      _id_113F("crouch");

    }
    if(self.a._id_0D26 == "stand") {
      animscripts\shared::_id_0F87( % rpg_stand_throw);
    } else {
      animscripts\shared::_id_0F87( % rpg_crouch_throw);

    }
    self clearanim( % root, 0.2);
    animscripts\combat_utility::_id_0F85();
    _id_1108();
    animscripts\combat_utility::_id_1114();
    return 1;
  }

  return 0;
}

_id_1115(var_0) {
  if(self.a._id_0D26 != "stand" && self isstanceallowed("stand")) {
    if(var_0 < 81225) {
      _id_113F("stand");
      return 1;
    }

    if(_id_1120()) {
      return 1;
    }
  }

  if(var_0 > 262144 && self.a._id_0D26 != "crouch" && self isstanceallowed("crouch") && !animscripts\utility::_id_0C95() && !isDefined(self._id_0C96) && gettime() >= self.a._id_1112 && lengthsquared(self._id_0D81) < 10000) {
    if(!isDefined(self._id_0CB1) || sighttracepassed(self.origin + (0, 0, 36), self._id_0CB1, 0, undefined)) {
      _id_113F("crouch");
      return 1;
    }
  }

  return 0;
}

_id_1116(var_0) {
  if(!animscripts\utility::_id_0C95()) {
    if(isDefined(self._id_1117) && self.a._id_0D26 == "stand") {
      if(_id_1150()) {
        return 1;
      }
    }

    if(animscripts\combat_utility::issniper() && var_0 < 167772.0) {
      if(_id_1150()) {
        return 1;
      }
    }
  }

  if(animscripts\combat_utility::_id_0F08(0)) {
    if(!animscripts\utility::_id_0C95() && common_scripts\utility::cointoss() && !animscripts\utility::_id_0BB6() && animscripts\utility::_id_1118() && var_0 < 167772.0 && self isstanceallowed("stand")) {
      if(self.a._id_0D26 != "stand") {
        _id_113F("stand");
        return 1;
      }

      if(_id_1150()) {
        return 1;
      }
    }

    if(_id_1144(0)) {
      return 1;
    }
  }

  return 0;
}

_id_1119(var_0) {
  if(animscripts\utility::_id_0C95() && self.a._id_0D26 == "stand" && !isDefined(self._id_1117)) {
    if(var_0 > 262144 || self.combatmode == "ambush_nodes_only" && (!isDefined(self.enemy) || !self cansee(self.enemy))) {
      _id_1159( % pistol_stand_switch);
    }
  }
}

_id_111A() {
  if(isDefined(self._id_0C96) && self nearclaimnodeandangle()) {
    self safeteleport(self.nodeoffsetpos, self.node.angles);
  }
}

_id_111B() {
  if(_id_1121()) {
    var_0 = 0.25;

    if(isDefined(self._id_0CAB) && !issentient(self._id_0CAB)) {
      var_0 = 1.5;

    }
    var_1 = animscripts\shared::_id_111C(var_0);

    if(_id_0F73(var_1)) {
      return 1;
    }
  }

  return 0;
}

_id_111D() {
  self endon("killanimscript");
  self endon("combat_restart");
  _id_1110();
  self animmode("zonly_physics", 0);
  self orientmode("face angle", self.angles[1]);

  for(;;) {
    if(animscripts\utility::_id_0BB6()) {
      self._id_0D45 = undefined;

    }
    animscripts\utility::_id_0A69();

    if(_id_1122()) {
      continue;
    }
    _id_1141();
    _id_111A();

    if(!isDefined(self._id_0CB1)) {
      _id_1123();

      if(!isDefined(self.enemy)) {
        var_0 = 1;

      }
      continue;
    }

    _id_1127();
    var_1 = lengthsquared(self.origin - self._id_0CB1);

    if(_id_1113(var_1)) {
      continue;
    }
    if(_id_111B()) {
      continue;
    }
    if(_id_10E7()) {
      continue;
    }
    if(_id_1116(var_1)) {
      continue;
    }
    if(animscripts\utility::_id_0BB6() && self.a._id_0D26 != "crouch" && randomfloat(1) > 0.65) {
      self._id_0D45 = ::_id_115D;

    }
    _id_1119(var_1);

    if(_id_1115(var_1)) {
      continue;
    }
    if(animscripts\combat_utility::_id_10E4()) {
      _id_1136();
      animscripts\combat_utility::_id_111E();
      continue;
    }

    _id_111F();
  }
}

_id_111F() {
  if(!isDefined(self.enemy) || !self cansee(self.enemy)) {
    self endon("enemy");
    self endon("shoot_behavior_change");
    wait(0.2 + randomfloat(0.1));
    self waittill("do_slow_things");
  } else {
    wait 0.05;
  }
}

_id_1120() {
  if(isDefined(self.enemy) && (!self cansee(self.enemy) || !self canshootenemy()) && sighttracepassed(self.origin + (0, 0, 64), self.enemy getshootatpos(), 0, undefined)) {
    self.a._id_1112 = gettime() + 3000;
    _id_113F("stand");
    return 1;
  }

  return 0;
}

_id_1121() {
  var_0 = self._id_0CB1;

  if(!isDefined(var_0)) {
    return 0;

  }
  var_1 = self.angles[1] - vectortoyaw(var_0 - self.origin);
  var_2 = distancesquared(self.origin, var_0);

  if(var_2 < 65536) {
    var_3 = sqrt(var_2);

    if(var_3 > 3) {
      var_1 = var_1 + asin(-3 / var_3);
    }
  }

  return animscripts\utility::_id_0D61(var_1) > self._id_0F72;
}

_id_1122() {
  var_0 = self.a._id_0D26;

  if(isDefined(self.a._id_0D29)) {
    wait 0.1;
    return 1;
  }

  if(var_0 == "stand" && isDefined(self._id_0C96)) {
    return 0;

  }
  if(!self isstanceallowed(var_0)) {
    var_1 = "crouch";

    if(var_0 == "crouch") {
      var_1 = "stand";

    }
    if(self isstanceallowed(var_1)) {
      if(var_0 == "stand" && animscripts\utility::_id_0C95()) {
        return 0;

      }
      _id_113F(var_1);
      return 1;
    }
  }

  return 0;
}

_id_1123() {
  if(self.a._id_0D26 != "stand" && self isstanceallowed("stand") && _id_1120()) {
    return 1;

  }
  var_0 = gettime();
  self.a._id_1112 = var_0 + 1500;

  if(isDefined(self._id_1124) && isDefined(self._id_1124.forward)) {
    var_1 = angleclamp180(self.angles[1] - vectortoyaw(self._id_1124.forward));

    if(_id_0F73(var_1)) {
      return 1;
    }
  }

  if(isDefined(self.node) && isDefined(anim._id_0CBD[self.node.type])) {
    var_1 = angleclamp180(self.angles[1] - self.node.angles[1]);

    if(_id_0F73(var_1)) {
      return 1;
    }
  } else if(isDefined(self.enemy) && self seerecently(self.enemy, 2) || var_0 > self.a._id_1019 + 1200) {
    var_1 = undefined;
    var_2 = self getanglestolikelyenemypath();

    if(isDefined(var_2)) {
      var_1 = angleclamp180(self.angles[1] - var_2[1]);
    } else if(isDefined(self.node)) {
      var_1 = angleclamp180(self.angles[1] - self.node.angles[1]);
    } else if(isDefined(self.enemy)) {
      var_2 = vectortoangles(self lastknownpos(self.enemy) - self.origin);
      var_1 = angleclamp180(self.angles[1] - var_2[1]);
    }

    if(isDefined(var_1) && _id_0F73(var_1)) {
      return 1;
    }
  } else if(isDefined(self._id_0C96) && self nearclaimnode()) {
    var_1 = angleclamp180(self.angles[1] - self.node.angles[1]);

    if(_id_0F73(var_1)) {
      return 1;
    }
  }

  if(_id_10E7()) {
    return 1;

  }
  var_3 = self.a._id_1125 < var_0;
  var_4 = 0;

  if(var_3) {
    var_4 = 0.99999;

  }
  if(_id_1144(var_4)) {
    return 1;

  }
  if(var_3 && animscripts\utility::_id_0C95()) {
    if(_id_1159( % pistol_stand_switch)) {
      return 1;
    }
  }

  _id_1126();
  return 1;
}

_id_1126() {
  self endon("shoot_behavior_change");
  wait(0.4 + randomfloat(0.4));
  self waittill("do_slow_things");
}

_id_1127() {
  self.a._id_1125 = gettime() + randomintrange(2000, 4000);
}

_id_0F73(var_0) {
  if(var_0 < 0 - self._id_0F72) {
    if(self.a._id_0D26 == "prone") {
      animscripts\cover_prone::_id_10B0("crouch");
      animscripts\animset::_id_0C99();
    }

    _id_112E("left", 0 - var_0);
    maps\_gameskill::_id_0F89();
    return 1;
  }

  if(var_0 > self._id_0F72) {
    if(self.a._id_0D26 == "prone") {
      animscripts\cover_prone::_id_10B0("crouch");
      animscripts\animset::_id_0C99();
    }

    _id_112E("right", var_0);
    maps\_gameskill::_id_0F89();
    return 1;
  }

  return 0;
}

_id_1128() {
  self endon("killanimscript");
  self._id_0D81 = (0, 0, 0);
  var_0 = undefined;
  var_1 = self.origin;
  var_2 = 0.15;

  for(;;) {
    if(isDefined(self._id_0CAB) && isDefined(var_0) && self._id_0CAB == var_0) {
      var_3 = self._id_0CAB.origin;
      self._id_0D81 = (var_3 - var_1) * (1 / var_2);
      var_1 = var_3;
    } else {
      if(isDefined(self._id_0CAB)) {
        var_1 = self._id_0CAB.origin;
      } else {
        var_1 = self.origin;

      }
      var_0 = self._id_0CAB;
      self._id_0D81 = (0, 0, 0);
    }

    wait(var_2);
  }
}

_id_1129() {
  return 0;
}

_id_112A(var_0) {
  self endon("killanimscript");
  animscripts\shared::_id_0C51(var_0);
}

_id_112B() {
  self endon("killanimscript");
  self notify("facing_enemy_immediately");
  self endon("facing_enemy_immediately");
  var_0 = 5;

  for(;;) {
    var_1 = 0 - animscripts\utility::_id_0D5C();

    if(abs(var_1) < 2) {
      break;
    }

    if(abs(var_1) > var_0) {
      var_1 = var_0 * common_scripts\utility::sign(var_1);

    }
    self orientmode("face angle", self.angles[1] + var_1);
    wait 0.05;
  }

  self orientmode("face current");
  self notify("can_stop_turning");
}

_id_112C(var_0) {
  var_1 = getmovedelta(var_0, 0, 1);
  var_2 = self localtoworldcoords(var_1);
  return self isingoal(var_2) && self maymovetopoint(var_2);
}

_id_112D(var_0) {
  var_1 = getmovedelta(var_0, 0, 1);
  var_2 = self localtoworldcoords(var_1);
  return self isingoal(var_2);
}

_id_112E(var_0, var_1) {
  var_2 = isDefined(self._id_0CB1);
  var_3 = 1;
  var_4 = 0.2;
  var_5 = isDefined(self.enemy) && !isDefined(self._id_0F3D) && self seerecently(self.enemy, 2) && distancesquared(self.enemy.origin, self.origin) < 262144;

  if(self.a._id_1019 + 500 > gettime()) {
    var_4 = 0.25;

    if(var_5) {
      thread _id_112B();
    }
  } else if(var_5) {
    var_6 = 1.0 - distance(self.enemy.origin, self.origin) / 512;
    var_3 = 1 + var_6 * 1;

    if(var_3 > 2) {
      var_4 = 0.05;
    } else if(var_3 > 1.3) {
      var_4 = 0.1;
    } else {
      var_4 = 0.15;
    }
  }

  var_7 = 0;

  if(var_1 > 157.5) {
    var_7 = 180;
  } else if(var_1 > 112.5) {
    var_7 = 135;
  } else if(var_1 > 67.5) {
    var_7 = 90;
  } else {
    var_7 = 45;

  }
  var_8 = "turn_" + var_0 + "_" + var_7;
  var_9 = animscripts\utility::_id_0D4D(var_8);

  if(isDefined(self._id_0F3D)) {
    self animmode("angle deltas", 0);
  } else if(isDefined(self.node) && isDefined(anim._id_112F[self.node.type]) && distancesquared(self.origin, self.node.origin) < 256) {
    self animmode("angle deltas", 0);
  } else if(_id_112D(var_9)) {
    self animmode("zonly_physics", 0);
  } else {
    self animmode("angle deltas", 0);

  }
  self setanimknoball( % exposed_aiming, % body, 1, var_4);

  if(!isDefined(self._id_0F3D)) {
    _id_1133(var_4);

  }
  self setanimlimited( % turn, 1, var_4);

  if(isDefined(self._id_0C96)) {
    var_3 = min(1.0, var_3);
  } else if(isDefined(self._id_0F3D)) {
    var_3 = max(1.5, var_3);

  }
  self setflaggedanimknoblimitedrestart("turn", var_9, 1, var_4, var_3);
  self notify("turning");

  if(var_2 && !isDefined(self._id_0F3D) && !isDefined(self._id_0C96)) {
    thread _id_1135();

  }
  _id_1131();
  self setanimlimited( % turn, 0, 0.2);

  if(!isDefined(self._id_0F3D)) {
    _id_1134(0.2);

  }
  if(!isDefined(self._id_0F3D)) {
    self clearanim( % turn, 0.2);
    self setanimknob( % exposed_aiming, 1, 0.2, 1);
  } else {
    self clearanim( % exposed_modern, 0.3);

  }
  if(isDefined(self._id_1130)) {
    self._id_1130 = undefined;
    thread _id_112B();
  }

  self animmode("zonly_physics", 0);
  self notify("done turning");
}

_id_1131() {
  self endon("can_stop_turning");
  animscripts\shared::_id_0C51("turn");
}

_id_1132() {
  self endon("killanimscript");
  self endon("done turning");
  var_0 = self.angles[1];
  wait 0.3;

  if(self.angles[1] == var_0) {
    self notify("turning_isnt_working");
    self._id_1130 = 1;
  }
}

_id_1133(var_0) {
  self setanimlimited(animscripts\utility::_id_0D4D("straight_level"), 0, var_0);
  self setanim( % add_idle, 0, var_0);

  if(!animscripts\utility::_id_0C97()) {
    self clearanim( % add_fire, 0.2);
  }
}

_id_1134(var_0) {
  self setanimlimited(animscripts\utility::_id_0D4D("straight_level"), 1, var_0);
  self setanim( % add_idle, 1, var_0);
}

_id_1135() {
  self endon("killanimscript");
  self endon("done turning");

  if(animscripts\utility::_id_0BB6()) {
    return;
  }
  animscripts\combat_utility::_id_0F06();
  self clearanim( % add_fire, 0.2);
}

_id_1136() {
  thread _id_1137();
  self endon("need_to_turn");
  thread _id_1140();
  animscripts\combat_utility::_id_0F06();
  self notify("stop_watching_for_need_to_turn");
  self notify("stop_trying_to_melee");
}

_id_1137() {
  self endon("killanimscript");
  self endon("stop_watching_for_need_to_turn");
  var_0 = gettime() + 4000 + randomint(2000);

  for(;;) {
    if(gettime() > var_0 || _id_1121()) {
      self notify("need_to_turn");
      break;
    }

    wait 0.1;
  }
}

_id_10E7() {
  if(!animscripts\combat_utility::_id_1138()) {
    return 0;

  }
  if(isDefined(anim._id_0F38) && isalive(level.player)) {
    if(_id_113B(level.player, 200)) {
      return 1;
    }
  }

  if(isDefined(self.enemy) && _id_113B(self.enemy, self._id_1139)) {
    return 1;

  }
  self.a._id_113A = gettime() + 500;
  return 0;
}

_id_113B(var_0, var_1) {
  var_2 = 0;

  if(isDefined(self._id_0F9F) || isDefined(var_0._id_0FA0)) {
    return 0;

  }
  if(!isDefined(self.a._id_0C6D["exposed_grenade"])) {
    return 0;

  }
  var_3 = var_0.origin;

  if(!self cansee(var_0)) {
    if(isDefined(self.enemy) && var_0 == self.enemy && isDefined(self._id_0CB1)) {
      var_3 = self._id_0CB1;
    }
  }

  if(!self cansee(var_0)) {
    var_1 = 100;

  }
  if(distancesquared(self.origin, var_3) > var_1 * var_1 && self.a._id_0D26 == self.a._id_113C) {
    animscripts\combat_utility::_id_1093(var_0);

    if(!animscripts\combat_utility::_id_113D(var_0)) {
      return 0;

    }
    var_4 = animscripts\utility::_id_113E(var_3);

    if(abs(var_4) < 60) {
      var_5 = [];

      foreach(var_7 in self.a._id_0C6D["exposed_grenade"]) {
        if(_id_112C(var_7)) {
          var_5[var_5.size] = var_7;
        }
      }

      if(var_5.size > 0) {
        self setanim( % exposed_aiming, 0, 0.1);
        self animmode("zonly_physics");
        animscripts\track::_id_0CC4(0, 0);
        var_2 = animscripts\combat_utility::_id_0FA1(var_0, var_5[randomint(var_5.size)]);
        self setanim( % exposed_aiming, 1, 0.1);

        if(var_2) {
          animscripts\track::_id_0CC4(1, 0.5);
        } else {
          animscripts\track::_id_0CC4(1, 0);
        }
      }
    }
  }

  if(var_2) {
    maps\_gameskill::_id_0F89();

  }
  return var_2;
}

_id_113F(var_0) {
  if(var_0 == self.a._id_0D26) {
    return;
  }
  var_1 = self.a._id_0D26 + "_2_" + var_0;

  if(!isDefined(self.a._id_0C6D)) {
    return;
  }
  var_2 = self.a._id_0C6D[var_1];

  if(!isDefined(var_2)) {
    return;
  }
  self clearanim( % root, 0.3);
  animscripts\combat_utility::_id_0F85();

  if(var_0 == "stand") {
    var_3 = 2;
  } else {
    var_3 = 1.5;

  }
  if(!animhasnotetrack(var_2, "anim_pose = \"" + var_0 + "\"")) {}

  self setflaggedanimknoballrestart("trans", var_2, % body, 1, 0.2, var_3);
  var_4 = getanimlength(var_2) / var_3;
  var_5 = var_4 - 0.3;

  if(var_5 < 0.2) {
    var_5 = 0.2;

  }
  animscripts\notetracks::_id_0D4F(var_5, "trans");
  self.a._id_0D26 = var_0;
  _id_1108();
  animscripts\combat_utility::_id_1114();
  maps\_gameskill::_id_0F89();
}

_id_1140() {
  self endon("killanimscript");
  self endon("stop_trying_to_melee");
  self endon("done turning");
  self endon("need_to_turn");
  self endon("shoot_behavior_change");

  for(;;) {
    wait(0.2 + randomfloat(0.3));

    if(isDefined(self.enemy)) {
      if(isplayer(self.enemy)) {
        var_0 = 40000;
      } else {
        var_0 = 10000;

      }
      if(distancesquared(self.enemy.origin, self.origin) < var_0) {
        _id_1141();
      }
    }
  }
}

_id_1141() {
  animscripts\melee::_id_1009();
}

_id_1142() {
  if(isDefined(self._id_1143)) {
    return;
  }
  if(isplayer(self.enemy)) {
    return;
  }
  animscripts\melee::_id_1021(self.enemy);
}

_id_1144(var_0) {
  if(animscripts\combat_utility::_id_0F08(var_0)) {
    self.a._id_1145 = 1;
    animscripts\combat_utility::_id_0F85();
    var_1 = undefined;

    if(isDefined(self._id_1146)) {
      var_1 = self[[self._id_1146]]();
      self.keepclaimednode = 1;
    } else {
      var_1 = animscripts\utility::_id_0CA8("reload");

      if(self.a._id_0D26 == "stand" && animscripts\utility::_id_0F8D("reload_crouchhide") && common_scripts\utility::cointoss()) {
        var_1 = animscripts\utility::_id_0CA8("reload_crouchhide");
      }
    }

    thread _id_1140();
    self._id_1147 = 0;

    if(weaponclass(self.weapon) == "pistol") {
      self orientmode("face default");

    }
    _id_1148(var_1, var_0 > 0.05);
    self notify("abort_reload");
    self orientmode("face current");

    if(self._id_1147) {
      animscripts\weaponlist::_id_0CD0();

    }
    self clearanim( % reload, 0.2);
    self.keepclaimednode = 0;
    self notify("stop_trying_to_melee");
    self.a._id_1145 = 0;
    self._id_1147 = undefined;
    maps\_gameskill::_id_0F89();
    animscripts\combat_utility::_id_1114();
    return 1;
  }

  return 0;
}

_id_1148(var_0, var_1) {
  self endon("abort_reload");

  if(var_1) {
    thread _id_1149();

  }
  var_2 = 1;

  if(!animscripts\utility::_id_0C95() && !animscripts\utility::_id_0CEA(self.weapon) && isDefined(self.enemy) && self cansee(self.enemy) && distancesquared(self.enemy.origin, self.origin) < 1048576) {
    var_2 = 1.2;

  }
  var_3 = "reload_" + animscripts\combat_utility::_id_0FF4();
  self clearanim( % root, 0.2);
  self setflaggedanimrestart(var_3, var_0, 1, 0.2, var_2);
  thread _id_114A("abort_reload", var_3);
  self endon("start_aim");
  animscripts\shared::_id_0C51(var_3);
  self._id_1147 = 1;
}

_id_1149() {
  self endon("abort_reload");
  self endon("killanimscript");

  for(;;) {
    if(isDefined(self._id_0CAB) && self cansee(self._id_0CAB)) {
      break;
    }

    wait 0.05;
  }

  self notify("abort_reload");
}

_id_114A(var_0, var_1) {
  self endon(var_0);
  self waittillmatch(var_1, "start_aim");
  self._id_1147 = 1;
  self notify("start_aim");
}

_id_10EB(var_0) {
  self endon("killanimscript");
  animscripts\shared::_id_0C51(var_0);
}

_id_114B() {
  maps\_mgturret::_id_114C();
  animscripts\weaponlist::_id_0CD0();
  self.a._id_114D = 0;
  self notify("dropped_gun");
  maps\_mgturret::_id_114E();
}

_id_114F() {
  _id_114B();
}

_id_1150() {
  if(isDefined(self.secondaryweapon) && animscripts\utility::_id_0CEA(self.secondaryweapon)) {
    return 0;

  }
  if(isDefined(self._id_1151)) {
    return 0;

  }
  self.a._id_0D26 = "stand";
  _id_1152( % pistol_stand_pullout);
  return 1;
}

_id_1152(var_0) {
  self endon("killanimscript");
  thread animscripts\combat_utility::_id_1153();
  animscripts\combat_utility::_id_0F85();
  self._id_1154 = var_0;
  self setflaggedanimknoballrestart("weapon swap", var_0, % body, 1, 0.2, animscripts\combat_utility::_id_0F7B());
  _id_1155("weapon swap", ::_id_1158, "end_weapon_swap");
  self clearanim(self._id_1154, 0.2);
  self notify("facing_enemy_immediately");
  self notify("switched_to_sidearm");
  maps\_gameskill::_id_0F89();
}

_id_1155(var_0, var_1, var_2) {
  self endon(var_2);
  animscripts\notetracks::_id_1156(var_0, var_1);
}

_id_1157(var_0) {
  self endon("killanimscript");
  wait(var_0);
  _id_112B();
}

_id_1158(var_0) {
  if(var_0 == "pistol_pickup") {
    self clearanim(animscripts\utility::_id_0D4D("straight_level"), 0);
    animscripts\animset::_id_0C94();
    thread _id_1157(0.25);
  } else if(var_0 == "start_aim") {
    animscripts\combat_utility::_id_1114();

    if(_id_1121()) {
      self notify("end_weapon_swap");
    }
  }
}

_id_1159(var_0, var_1) {
  self endon("killanimscript");

  if(animscripts\utility::_id_0CEA(self.primaryweapon) && (isDefined(self._id_0FFE) && !self._id_0FFE) && self._id_1005 == animscripts\utility::_id_115A()) {
    return 0;

  }
  animscripts\combat_utility::_id_0F85();
  self._id_1154 = var_0;
  self setflaggedanimknoballrestart("weapon swap", var_0, % body, 1, 0.1, 1);

  if(isDefined(var_1)) {
    _id_1155("weapon swap", ::_id_115C, "end_weapon_swap");
  } else {
    _id_1155("weapon swap", ::_id_115B, "end_weapon_swap");

  }
  self clearanim(self._id_1154, 0.2);
  self notify("switched_to_lastweapon");
  maps\_gameskill::_id_0F89();
  return 1;
}

_id_115B(var_0) {
  if(var_0 == "pistol_putaway") {
    self clearanim(animscripts\utility::_id_0D4D("straight_level"), 0);
    animscripts\animset::_id_0C94();
    thread animscripts\combat_utility::_id_1153();
  } else if(var_0 == "start_aim") {
    animscripts\combat_utility::_id_1114();

    if(_id_1121()) {
      self notify("end_weapon_swap");
    }
  }
}

_id_115C(var_0) {
  if(var_0 == "pistol_putaway") {
    thread animscripts\combat_utility::_id_1153();
  } else if(issubstr(var_0, "anim_gunhand")) {
    self notify("end_weapon_swap");
  }
}

_id_115D() {
  if(!animscripts\utility::_id_0BB6() || self._id_0CD1 == 0) {
    return 0;

  }
  if(randomfloat(1) > 0.5) {
    self setflaggedanimknoball("deathanim", % rpg_stand_death, % root, 1, 0.05, 1);
  } else {
    self setflaggedanimknoball("deathanim", % rpg_stand_death_stagger, % root, 1, 0.05, 1);

  }
  animscripts\shared::_id_0C51("deathanim");
  animscripts\shared::_id_0D73();
  return;
}

_id_115E() {
  self endon("killanimscript");
  self.a._id_1145 = 0;

  for(;;) {
    wait 0.2;

    if(isDefined(self.enemy) && !self seerecently(self.enemy, 2)) {
      if(self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only") {
        continue;
      }
    }

    _id_115F();
  }
}

_id_115F() {
  if(self.fixednode) {
    return;
  }
  if(!isDefined(self.enemy)) {
    self._id_1160 = 0;
    return;
  }

  if(gettime() < self.teammovewaittime) {
    self._id_1160 = 0;
    return;
  }

  if(isDefined(self._id_1161) && self._id_1161 != self.enemy) {
    self._id_1160 = 0;
    self._id_1161 = undefined;
    return;
  }

  self._id_1161 = self.enemy;

  if(self cansee(self.enemy) && self canshootenemy()) {
    self._id_1160 = 0;
    return;
  }

  if(isDefined(self._id_1147) && !self._id_1147) {
    self._id_1160 = 0;
    return;
  }

  if(!isDefined(self._id_4411) || !self._id_4411) {
    var_0 = vectornormalize(self.enemy.origin - self.origin);
    var_1 = anglesToForward(self.angles);

    if(vectordot(var_0, var_1) < 0.5) {
      self._id_1160 = 0;
      return;
    }
  }

  if(self.a._id_1145 && animscripts\combat_utility::_id_0F08(0.25) && self.enemy.health > self.enemy.maxhealth * 0.5) {
    self._id_1160 = 0;
    return;
  }

  if(animscripts\combat_utility::_id_0F34() && self._id_1160 < 3) {
    self._id_1160 = 3;

  }
  switch (self._id_1160) {
    case 0:
      if(self reacquirestep(32)) {
        return;
      }
      break;
    case 1:
      if(self reacquirestep(64)) {
        self._id_1160 = 0;
        return;
      }

      break;
    case 2:
      if(self reacquirestep(96)) {
        self._id_1160 = 0;
        return;
      }

      break;
    case 3:
      if(animscripts\combat_utility::_id_0F35(0)) {
        self._id_1160 = 0;
        return;
      }

      break;
    case 4:
      if(!self cansee(self.enemy) || !self canshootenemy()) {
        self flagenemyunattackable();

      }
      break;
    default:
      if(self._id_1160 > 15) {
        self._id_1160 = 0;
        return;
      }

      break;
  }

  self._id_1160++;
}