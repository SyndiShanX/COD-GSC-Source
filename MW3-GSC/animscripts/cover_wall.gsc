/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_wall.gsc
**************************************/

#using_animtree("generic_human");

_id_0F76(var_0) {
  self endon("killanimscript");
  self._id_0CAF = self.node;
  self._id_0F77 = var_0;

  if(!isDefined(self.node._id_0A50)) {
    animscripts\cover_behavior::_id_0F71(0);

  }
  if(var_0 == "crouch") {
    _id_0F81("unknown");
    self._id_0CAF _id_0F7F();
  } else {
    _id_0F82("unknown");

  }
  self.a._id_0F78 = undefined;
  self orientmode("face angle", self._id_0CAF.angles[1]);

  if(isDefined(self.weapon) && animscripts\utility::_id_0F79() && isDefined(self.node) && isDefined(self.node._id_0F7A) && canspawnturret()) {
    if(var_0 == "crouch") {
      if(_id_0F7E(self.weapon)) {
        var_1 = "rpd_bipod_crouch";
      } else {
        var_1 = "saw_bipod_crouch";
      }
    } else if(_id_0F7E(self.weapon)) {
      var_1 = "rpd_bipod_stand";
    } else {
      var_1 = "saw_bipod_stand";

    }
    if(_id_0F7E(self.weapon)) {
      var_2 = "weapon_rpd_MG_Setup";
    } else {
      var_2 = "weapon_saw_MG_Setup";

    }
    _id_0FA5(var_1, var_2);
  } else if(isDefined(self.node) && isDefined(self.node._id_0A50)) {
    _id_0FA7();

  }
  self animmode("normal");

  if(var_0 == "crouch" && self.a._id_0D26 == "stand") {
    var_3 = animscripts\utility::_id_0D4D("stand_2_hide");
    var_4 = getanimlength(var_3);
    self setanimknoballrestart(var_3, % body, 1, 0.2, animscripts\combat_utility::_id_0F7B());
    thread animscripts\shared::_id_0F7C(self._id_0CAF.origin, var_4);
    wait(var_4);
    self.a._id_0CF8 = "hide";
  } else {
    _id_0FB2(0.4);

    if(distancesquared(self.origin, self._id_0CAF.origin) > 1) {
      thread animscripts\shared::_id_0F7C(self._id_0CAF.origin, 0.4);
      wait 0.2;

      if(var_0 == "crouch") {
        self.a._id_0D26 = "crouch";

      }
      wait 0.2;
    } else {
      wait 0.1;
    }
  }

  self animmode("zonly_physics");

  if(var_0 == "crouch") {
    if(self.a._id_0D26 == "prone") {
      animscripts\utility::_id_0F7D(1);

    }
    self.a._id_0D26 = "crouch";
  }

  if(self._id_0F77 == "stand") {
    self.a._id_0D19 = "cover_stand";
  } else {
    self.a._id_0D19 = "cover_crouch";

  }
  var_5 = spawnStruct();

  if(!self.fixednode) {
    var_5._id_0F37 = animscripts\cover_behavior::_id_0F37;

  }
  var_5._id_0F54 = ::_id_0F52;
  var_5._id_0F55 = ::_id_0F83;
  var_5.look = ::look;
  var_5._id_0F57 = ::_id_0F57;
  var_5._id_0F59 = ::_id_0F59;
  var_5._id_0F5B = ::_id_0F5B;
  var_5.grenade = ::_id_0F61;
  var_5._id_0F63 = ::_id_0F9E;
  var_5._id_0F64 = ::_id_0F64;
  animscripts\cover_behavior::main(var_5);
}

_id_0F7E(var_0) {
  return getsubstr(var_0, 0, 3) == "rpd" && (var_0.size == 3 || var_0[3] == "_");
}

_id_0F7F() {
  if(isDefined(self._id_0F80)) {
    return;
  }
  var_0 = (0, 0, 42);
  var_1 = anglesToForward(self.angles);
  self._id_0F80 = sighttracepassed(self.origin + var_0, self.origin + var_0 + var_1 * 64, 0, undefined);
}

_id_0F81(var_0) {
  self setdefaultaimlimits(self._id_0CAF);
  _id_0FA9(var_0);
}

_id_0F82(var_0) {
  self setdefaultaimlimits(self._id_0CAF);
  _id_0FAE(var_0);
}

_id_0F52() {
  animscripts\combat_utility::_id_0F54(2.0, animscripts\utility::_id_0D4D("reload"));
  return 1;
}

_id_0F83() {
  self.keepclaimednodeifvalid = 1;

  if(isDefined(self._id_0F84) && randomfloat(1) < self._id_0F84) {
    if(_id_0F8B()) {
      return 1;
    }
  }

  if(!_id_0F98()) {
    return 0;

  }
  _id_0F88();
  animscripts\combat_utility::_id_0F85();

  if(isDefined(self._id_0CB1)) {
    var_0 = lengthsquared(self.origin - self._id_0CB1);

    if(animscripts\utility::_id_0BB6() && (var_0 < squared(512) || self.a.rockets < 1)) {
      if(self.a._id_0D26 == "stand") {
        animscripts\shared::_id_0F87( % rpg_stand_throw);
      } else {
        animscripts\shared::_id_0F87( % rpg_crouch_throw);
      }
    }
  }

  _id_0F9C();
  self._id_0CAC = undefined;
  self.keepclaimednodeifvalid = 0;
  return 1;
}

_id_0F88() {
  self endon("return_to_cover");
  maps\_gameskill::_id_0F89();

  for(;;) {
    if(isDefined(self._id_0CDC)) {
      break;
    }

    if(!isDefined(self._id_0CB1)) {
      self waittill("do_slow_things");
      waittillframeend;

      if(isDefined(self._id_0CB1)) {
        continue;
      }
      break;
    }

    if(!self._id_0CD1) {
      break;
    }

    if(self._id_0F77 == "crouch" && _id_0FB4()) {
      break;
    }

    _id_0F8A();
    self clearanim( % add_fire, 0.2);
  }
}

_id_0F8A() {
  if(self._id_0F77 == "crouch") {
    thread _id_0FB3();

  }
  thread animscripts\combat_utility::_id_0F78();
  animscripts\combat_utility::_id_0F06();
}

_id_0F8B() {
  if(!animscripts\utility::_id_0F8C()) {
    return 0;

  }
  var_0 = "rambo";

  if(randomint(10) < 2) {
    var_0 = "rambo_fail";

  }
  if(!animscripts\utility::_id_0F8D(var_0)) {
    return 0;

  }
  if(self._id_0F77 == "crouch" && !self._id_0CAF._id_0F80) {
    return 0;

  }
  var_1 = _id_0FB7(self._id_0CAF.origin + animscripts\utility::_id_0F8E(self._id_0CAF));

  if(var_1 > 15) {
    return 0;

  }
  var_2 = anglesToForward(self.angles);
  var_3 = self.origin + var_2 * -16;

  if(!self maymovetopoint(var_3)) {
    return 0;

  }
  self._id_0CFD = gettime();
  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  self._id_0F8F = 1;
  self.a._id_0F3E = "rambo";
  self._id_0CDD = 1;
  thread animscripts\shared::_id_0F90(0);
  var_4 = animscripts\utility::_id_0CA8(var_0);
  self setflaggedanimknoballrestart("rambo", var_4, % body, 1, 0.2, 1);
  animscripts\shared::_id_0C51("rambo");
  self notify("rambo_aim_end");
  self._id_0CDD = 0;
  self.keepclaimednodeifvalid = 0;
  self._id_0F91 = gettime();
  self._id_0CDD = 0;
  self._id_0F8F = undefined;
  return 1;
}

_id_0F59() {
  self endon("end_idle");

  for(;;) {
    var_0 = randomint(2) == 0 && animscripts\utility::_id_0F8D("hide_idle_twitch");

    if(var_0) {
      var_1 = animscripts\utility::_id_0CA8("hide_idle_twitch");
    } else {
      var_1 = animscripts\utility::_id_0D4D("hide_idle");

    }
    _id_0F92(var_1, var_0);
  }
}

_id_0F5B() {
  if(!animscripts\utility::_id_0F8D("hide_idle_flinch")) {
    return 0;

  }
  var_0 = anglesToForward(self.angles);
  var_1 = self.origin + var_0 * -16;

  if(!self maymovetopoint(var_1)) {
    return 0;

  }
  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  var_2 = animscripts\utility::_id_0CA8("hide_idle_flinch");
  _id_0F92(var_2, 1);
  self.keepclaimednodeifvalid = 0;
  return 1;
}

_id_0F92(var_0, var_1) {
  if(var_1) {
    self setflaggedanimknoballrestart("idle", var_0, % body, 1, 0.25, 1);
  } else {
    self setflaggedanimknoball("idle", var_0, % body, 1, 0.25, 1);

  }
  self.a._id_0CF8 = "hide";
  animscripts\shared::_id_0C51("idle");
}

look(var_0) {
  if(!isDefined(self.a._id_0C6D["hide_to_look"])) {
    return 0;

  }
  if(!_id_0F94()) {
    return 0;

  }
  animscripts\shared::_id_0F93(animscripts\utility::_id_0D4D("look_idle"), var_0);
  var_1 = undefined;

  if(animscripts\utility::_id_0F4C()) {
    var_1 = animscripts\utility::_id_0D4D("look_to_hide_fast");
  } else {
    var_1 = animscripts\utility::_id_0D4D("look_to_hide");

  }
  self setflaggedanimknoballrestart("looking_end", var_1, % body, 1, 0.1);
  animscripts\shared::_id_0C51("looking_end");
  return 1;
}

_id_0F94() {
  if(isDefined(self._id_0CAF._id_0F95)) {
    return 0;

  }
  self setflaggedanimknoball("looking_start", animscripts\utility::_id_0D4D("hide_to_look"), % body, 1, 0.2);
  animscripts\shared::_id_0C51("looking_start");
  return 1;
}

_id_0F57() {
  self setflaggedanimknoballrestart("look", animscripts\utility::_id_0CA8("look"), % body, 1, 0.1);
  animscripts\shared::_id_0C51("look");
  return 1;
}

_id_0F96() {
  if(self.a._id_0CF8 == "left" || self.a._id_0CF8 == "right" || self.a._id_0CF8 == "over") {
    return 1;

  }
  return animscripts\combat_utility::_id_0F97();
}

_id_0F98() {
  var_0 = _id_0FB5();
  var_1 = 0.1;
  var_2 = animscripts\utility::_id_0D4D("hide_2_" + var_0);

  if(!self maymovetopoint(animscripts\utility::_id_0F99(var_2))) {
    return 0;

  }
  if(self.script == "cover_crouch" && var_0 == "lean") {
    self._id_0CAC = 1;

  }
  if(self._id_0F77 == "crouch") {
    _id_0F81(var_0);
  } else {
    _id_0F82(var_0);

  }
  self.a._id_0D19 = "none";
  self._id_0D4B = undefined;

  if(self._id_0F77 == "stand") {
    self.a._id_0D19 = "cover_stand_aim";
  } else {
    self.a._id_0D19 = "cover_crouch_aim";

  }
  self._id_0CDD = 1;
  self notify("done_changing_cover_pos");
  self animmode("zonly_physics");
  var_3 = _id_0F96();
  self setflaggedanimknoballrestart("pop_up", var_2, % body, 1, 0.1, var_3);
  thread _id_0F9A("pop_up");

  if(animhasnotetrack(var_2, "start_aim")) {
    self waittillmatch("pop_up", "start_aim");
    var_1 = getanimlength(var_2) / var_3 * (1 - self getanimtime(var_2));
  } else {
    self waittillmatch("pop_up", "end");
    var_1 = 0.1;
  }

  self clearanim(var_2, var_1 + 0.05);
  self.a._id_0CF8 = var_0;
  self.a._id_0F3E = var_0;
  _id_0F9B(var_1);
  thread animscripts\track::_id_0CA9();
  wait(var_1);

  if(animscripts\combat_utility::issniper()) {
    thread animscripts\shoot_behavior::_id_0D0C();

  }
  self._id_0CDD = 0;
  self._id_0CFD = gettime();
  self notify("stop_popup_donotetracks");
  return 1;
}

_id_0F9A(var_0) {
  self endon("killanimscript");
  self endon("stop_popup_donotetracks");
  animscripts\shared::_id_0C51(var_0);
}

_id_0F9B(var_0) {
  if(self.a._id_0CF8 == "left" || self.a._id_0CF8 == "right") {
    var_1 = "crouch";
  } else {
    var_1 = self.a._id_0CF8;

  }
  self setanimknoball(animscripts\utility::_id_0D4D(var_1 + "_aim"), % body, 1, var_0);

  if(var_1 == "crouch") {
    self setanimlimited( % covercrouch_aim2_add, 1, 0);
    self setanimlimited( % covercrouch_aim4_add, 1, 0);
    self setanimlimited( % covercrouch_aim6_add, 1, 0);
    self setanimlimited( % covercrouch_aim8_add, 1, 0);
  } else if(var_1 == "stand") {
    self setanimlimited( % exposed_aim_2, 1, 0);
    self setanimlimited( % exposed_aim_4, 1, 0);
    self setanimlimited( % exposed_aim_6, 1, 0);
    self setanimlimited( % exposed_aim_8, 1, 0);
  } else if(var_1 == "lean") {
    self setanimlimited( % exposed_aim_2, 1, 0);
    self setanimlimited( % exposed_aim_4, 1, 0);
    self setanimlimited( % exposed_aim_6, 1, 0);
    self setanimlimited( % exposed_aim_8, 1, 0);
  } else if(var_1 == "over") {
    self setanimlimited( % coverstandaim_aim2_add, 1, 0);
    self setanimlimited( % coverstandaim_aim4_add, 1, 0);
    self setanimlimited( % coverstandaim_aim6_add, 1, 0);
    self setanimlimited( % coverstandaim_aim8_add, 1, 0);
  }
}

_id_0F9C() {
  self notify("return_to_cover");
  self._id_0CDD = 1;
  self notify("done_changing_cover_pos");
  animscripts\combat_utility::_id_0F9D();
  var_0 = _id_0F96();
  self setflaggedanimknoball("go_to_hide", animscripts\utility::_id_0D4D(self.a._id_0CF8 + "_2_hide"), % body, 1, 0.2, var_0);
  self clearanim( % exposed_modern, 0.2);
  animscripts\shared::_id_0C51("go_to_hide");
  self.a._id_0CF8 = "hide";

  if(self._id_0F77 == "stand") {
    self.a._id_0D19 = "cover_stand";
  } else {
    self.a._id_0D19 = "cover_crouch";

  }
  self._id_0CDD = 0;
}

_id_0F9E(var_0) {
  return _id_0F61(var_0, 1);
}

_id_0F61(var_0, var_1) {
  if(isDefined(self._id_0F9F) || isDefined(var_0._id_0FA0)) {
    return 0;

  }
  var_2 = undefined;

  if(isDefined(self._id_0F84) && randomfloat(1.0) < self._id_0F84) {
    var_2 = animscripts\utility::_id_0CA8("grenade_rambo");
  } else if(isDefined(var_1) && var_1) {
    var_2 = animscripts\utility::_id_0CA8("grenade_safe");
  } else {
    var_2 = animscripts\utility::_id_0CA8("grenade_exposed");

  }
  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  var_3 = animscripts\combat_utility::_id_0FA1(var_0, var_2);
  self.keepclaimednodeifvalid = 0;
  return var_3;
}

_id_0F64() {
  if(!animscripts\utility::_id_0F8D("blind_fire")) {
    return 0;

  }
  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  self setflaggedanimknoballrestart("blindfire", animscripts\utility::_id_0CA8("blind_fire"), % body, 1, 0.2, 1);
  animscripts\shared::_id_0C51("blindfire");
  self.keepclaimednodeifvalid = 0;
  return 1;
}

_id_0FA2(var_0, var_1, var_2) {
  var_3 = spawnturret("misc_turret", var_0.origin, var_1);
  var_3.angles = var_0.angles;
  var_3._id_0FA3 = self;
  var_3 setModel(var_2);
  var_3 makeusable();
  var_3 setdefaultdroppitch(0);

  if(isDefined(var_0.leftarc)) {
    var_3.leftarc = var_0.leftarc;

  }
  if(isDefined(var_0.rightarc)) {
    var_3.rightarc = var_0.rightarc;

  }
  if(isDefined(var_0.toparc)) {
    var_3.toparc = var_0.toparc;

  }
  if(isDefined(var_0.bottomarc)) {
    var_3.bottomarc = var_0.bottomarc;

  }
  return var_3;
}

_id_0FA4(var_0) {
  self endon("death");
  self endon("being_used");
  wait 0.1;

  if(isDefined(var_0)) {
    var_0 notify("turret_use_failed");

  }
  self delete();
}

_id_0FA5(var_0, var_1) {
  var_2 = _id_0FA2(self.node._id_0F7A, var_0, var_1);

  if(self useturret(var_2)) {
    var_2 thread _id_0FA4(self);

    if(isDefined(self._id_0FA6)) {
      thread[[self._id_0FA6]](var_2);

    }
    self waittill("turret_use_failed");
  } else {
    var_2 delete();
  }
}

_id_0FA7() {
  var_0 = self.node._id_0A50;

  if(!var_0._id_0FA8) {
    return;
  }
  thread maps\_mg_penetration::_id_0A47(var_0);
  self waittill("continue_cover_script");
}

_id_0FA9(var_0) {
  var_1 = [];
  var_1["hide_idle"] = % covercrouch_hide_idle;
  var_1["hide_idle_twitch"] = animscripts\utility::_id_0C6D( % covercrouch_twitch_1, % covercrouch_twitch_2, % covercrouch_twitch_3, % covercrouch_twitch_4);
  var_1["hide_idle_flinch"] = animscripts\utility::_id_0C6D();
  var_1["hide_2_crouch"] = % covercrouch_hide_2_aim;
  var_1["hide_2_stand"] = % covercrouch_hide_2_stand;
  var_1["hide_2_lean"] = % covercrouch_hide_2_lean;
  var_1["hide_2_right"] = % covercrouch_hide_2_right;
  var_1["hide_2_left"] = % covercrouch_hide_2_left;
  var_1["crouch_2_hide"] = % covercrouch_aim_2_hide;
  var_1["stand_2_hide"] = % covercrouch_stand_2_hide;
  var_1["lean_2_hide"] = % covercrouch_lean_2_hide;
  var_1["right_2_hide"] = % covercrouch_right_2_hide;
  var_1["left_2_hide"] = % covercrouch_left_2_hide;
  var_1["crouch_aim"] = % covercrouch_aim5;
  var_1["stand_aim"] = % exposed_aim_5;
  var_1["lean_aim"] = % covercrouch_lean_aim5;
  var_1["fire"] = % exposed_shoot_auto_v2;
  var_1["semi2"] = % exposed_shoot_semi2;
  var_1["semi3"] = % exposed_shoot_semi3;
  var_1["semi4"] = % exposed_shoot_semi4;
  var_1["semi5"] = % exposed_shoot_semi5;

  if(animscripts\utility::_id_0C97()) {
    if(var_0 == "lean" || var_0 == "stand") {
      var_1["single"] = animscripts\utility::_id_0C6D( % shotgun_stand_fire_1a);
    } else {
      var_1["single"] = animscripts\utility::_id_0C6D( % shotgun_crouch_fire);
    }
  } else {
    var_1["single"] = animscripts\utility::_id_0C6D( % exposed_shoot_semi1);

  }
  var_1["burst2"] = % exposed_shoot_burst3;
  var_1["burst3"] = % exposed_shoot_burst3;
  var_1["burst4"] = % exposed_shoot_burst4;
  var_1["burst5"] = % exposed_shoot_burst5;
  var_1["burst6"] = % exposed_shoot_burst6;
  var_1["blind_fire"] = animscripts\utility::_id_0C6D( % covercrouch_blindfire_1, % covercrouch_blindfire_2, % covercrouch_blindfire_3, % covercrouch_blindfire_4);
  var_1["reload"] = % covercrouch_reload_hide;
  var_1["grenade_safe"] = animscripts\utility::_id_0C6D( % covercrouch_grenadea, % covercrouch_grenadeb);
  var_1["grenade_exposed"] = animscripts\utility::_id_0C6D( % covercrouch_grenadea, % covercrouch_grenadeb);
  var_1["exposed_idle"] = animscripts\utility::_id_0C6D( % exposed_idle_alert_v1, % exposed_idle_alert_v2, % exposed_idle_alert_v3);
  var_1["look"] = animscripts\utility::_id_0C6D( % covercrouch_hide_look);

  if(isDefined(anim._id_0FAA)) {
    var_1["rambo"] = anim._id_0FAA._id_0FAB;
    var_1["rambo_fail"] = anim._id_0FAA._id_0FAC;
    var_1["grenade_rambo"] = anim._id_0FAA._id_0FAD;
  }

  self.a._id_0C6D = var_1;
}

_id_0FAE(var_0) {
  var_1 = [];
  var_1["hide_idle"] = % coverstand_hide_idle;
  var_1["hide_idle_twitch"] = animscripts\utility::_id_0C6D( % coverstand_hide_idle_twitch01, % coverstand_hide_idle_twitch02, % coverstand_hide_idle_twitch03, % coverstand_hide_idle_twitch04, % coverstand_hide_idle_twitch05);
  var_1["hide_idle_flinch"] = animscripts\utility::_id_0C6D( % coverstand_react01, % coverstand_react02, % coverstand_react03, % coverstand_react04);
  var_1["hide_2_stand"] = % coverstand_hide_2_aim;
  var_1["stand_2_hide"] = % coverstand_aim_2_hide;
  var_1["hide_2_over"] = % coverstand_2_coverstandaim;
  var_1["over_2_hide"] = % coverstandaim_2_coverstand;

  if(var_0 == "over") {
    var_1["over_aim"] = % coverstandaim_aim5;
    var_1["fire"] = % coverstandaim_autofire;
    var_1["semi2"] = % coverstandaim_fire;
    var_1["semi3"] = % coverstandaim_fire;
    var_1["semi4"] = % coverstandaim_fire;
    var_1["semi5"] = % coverstandaim_fire;
    var_1["single"] = animscripts\utility::_id_0C6D( % coverstandaim_fire);
    var_1["burst2"] = % coverstandaim_autofire;
    var_1["burst3"] = % coverstandaim_autofire;
    var_1["burst4"] = % coverstandaim_autofire;
    var_1["burst5"] = % coverstandaim_autofire;
    var_1["burst6"] = % coverstandaim_autofire;
  } else {
    var_1["stand_aim"] = % exposed_aim_5;
    var_1["fire"] = % exposed_shoot_auto_v2;
    var_1["semi2"] = % exposed_shoot_semi2;
    var_1["semi3"] = % exposed_shoot_semi3;
    var_1["semi4"] = % exposed_shoot_semi4;
    var_1["semi5"] = % exposed_shoot_semi5;

    if(animscripts\utility::_id_0C97()) {
      var_1["single"] = animscripts\utility::_id_0C6D( % shotgun_stand_fire_1a);
    } else {
      var_1["single"] = animscripts\utility::_id_0C6D( % exposed_shoot_semi1);

    }
    var_1["burst2"] = % exposed_shoot_burst3;
    var_1["burst3"] = % exposed_shoot_burst3;
    var_1["burst4"] = % exposed_shoot_burst4;
    var_1["burst5"] = % exposed_shoot_burst5;
    var_1["burst6"] = % exposed_shoot_burst6;
  }

  var_1["blind_fire"] = animscripts\utility::_id_0C6D( % coverstand_blindfire_1, % coverstand_blindfire_2);
  var_1["reload"] = % coverstand_reloada;
  var_1["look"] = animscripts\utility::_id_0C6D( % coverstand_look_quick, % coverstand_look_quick_v2);
  var_1["grenade_safe"] = animscripts\utility::_id_0C6D( % coverstand_grenadea, % coverstand_grenadeb);
  var_1["grenade_exposed"] = animscripts\utility::_id_0C6D( % coverstand_grenadea, % coverstand_grenadeb);
  var_1["exposed_idle"] = animscripts\utility::_id_0C6D( % exposed_idle_alert_v1, % exposed_idle_alert_v2, % exposed_idle_alert_v3);
  var_1["hide_to_look"] = % coverstand_look_moveup;
  var_1["look_idle"] = % coverstand_look_idle;
  var_1["look_to_hide"] = % coverstand_look_movedown;
  var_1["look_to_hide_fast"] = % coverstand_look_movedown_fast;

  if(isDefined(anim._id_0FAA)) {
    var_1["rambo"] = anim._id_0FAA._id_0FAF;
    var_1["rambo_fail"] = anim._id_0FAA._id_0FB0;
    var_1["grenade_rambo"] = anim._id_0FAA._id_0FB1;
  }

  self.a._id_0C6D = var_1;
}

_id_0FB2(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0.1;

  }
  self setanimknoballrestart(animscripts\utility::_id_0D4D("hide_idle"), % body, 1, var_0);
  self.a._id_0CF8 = "hide";
}

_id_0FB3() {
  self endon("killanimscript");
  self notify("newAngleRangeCheck");
  self endon("newAngleRangeCheck");
  self endon("return_to_cover");

  for(;;) {
    if(_id_0FB4()) {
      break;
    }

    wait 0.1;
  }

  self notify("stopShooting");
}

_id_0FB4() {
  if(self._id_0F77 != "crouch") {
    return 0;

  }
  var_0 = _id_0FB7(self getEye());

  if(self.a._id_0CF8 == "lean") {
    return var_0 < 10;
  } else {
    return var_0 > 45;
  }
}

_id_0FB5() {
  var_0 = [];

  if(self._id_0F77 == "stand") {
    var_0 = self._id_0CAF getvalidcoverpeekouts();
    var_0[var_0.size] = "stand";
  } else {
    var_1 = _id_0FB7(self._id_0CAF.origin + animscripts\utility::_id_0F8E(self._id_0CAF));

    if(var_1 > 30) {
      return "lean";

    }
    if(var_1 > 15 || !self._id_0CAF._id_0F80) {
      return "stand";

    }
    var_0 = self._id_0CAF getvalidcoverpeekouts();
    var_0[var_0.size] = "crouch";
  }

  return animscripts\combat_utility::_id_0FB6(var_0);
}

_id_0FB7(var_0) {
  var_1 = animscripts\utility::_id_0FB8();
  return angleclamp180(vectortoangles(var_1 - var_0)[0]);
}