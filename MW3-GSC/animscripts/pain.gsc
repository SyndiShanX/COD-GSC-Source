/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\pain.gsc
**************************************/

main() {
  if(isDefined(self._id_0D0F)) {
    self waittill("killanimscript");
    return;
  }

  if([[anim._id_0D10]]()) {
    return;
  }
  if(self.a._id_0D11) {
    return;
  }
  self notify("kill_long_death");

  if(isDefined(self.a._id_0B29)) {
    self.a._id_0D12 = self.a._id_0B29;
  } else {
    self.a._id_0D12 = 0;

  }
  self.a._id_0B29 = gettime();

  if(self.stairsstate != "none") {
    self.a._id_0D13 = 1;
  } else {
    self.a._id_0D13 = undefined;

  }
  if(self.a._id_0D14) {
    self.health = 1;

  }
  var_0 = 0;
  var_1 = 0;
  var_2 = self.health / self.maxhealth;
  self notify("anim entered pain");
  self endon("killanimscript");
  animscripts\utility::_id_0D15("pain");
  self animmode("gravity");

  if(!isDefined(self._id_0D16)) {
    animscripts\face::_id_0C41("pain");

  }
  if(self.damagelocation == "helmet") {
    animscripts\death::_id_0D17();
  } else if(_id_0D1F() && randomint(2) == 0) {
    animscripts\death::_id_0D17();

  }
  if(isDefined(self._id_0D18)) {
    self[[self._id_0D18]]();
    return;
  }

  if(_id_0D3F()) {
    return;
  }
  if(_id_0D38(self.a._id_0D19)) {
    return;
  }
  var_3 = _id_0D27();
  _id_0D35(var_3);
}

_id_0D1A() {
  level._effect["crawling_death_blood_smear"] = loadfx("impacts/blood_smear_decal");
}

end_script() {
  if(isDefined(self._id_0D1B)) {
    self._id_0D1C = undefined;
    self._id_0D1B = undefined;
    self.allowpain = 1;

    if(!isDefined(self._id_0D1D)) {
      self.ignoreme = 0;

    }
    self._id_0D1D = undefined;
  }

  if(isDefined(self._id_0D1E)) {
    self._id_0D1E = undefined;
    self.allowpain = 1;
  }
}

_id_0D1F() {
  if(isexplosivedamagemod(self.damagemod)) {
    return 1;

  }
  if(gettime() - anim.lastcarexplosiontime <= 50) {
    var_0 = anim.lastcarexplosionrange * anim.lastcarexplosionrange * 1.2 * 1.2;

    if(distancesquared(self.origin, anim.lastcarexplosiondamagelocation) < var_0) {
      var_1 = var_0 * 0.5 * 0.5;
      self._id_0D24 = distancesquared(self.origin, anim.lastcarexplosionlocation) < var_1;
      return 1;
    }
  }

  return 0;
}

#using_animtree("generic_human");

_id_0D25() {
  if(self.a._id_0D26 == "prone") {
    return;
  }
  if(isDefined(self.lastattacker) && isDefined(self.lastattacker.team) && self.lastattacker.team == self.team) {
    return;
  }
  if(!isDefined(self._id_0D1C) || gettime() - self.a._id_0D12 > 1500) {
    self._id_0D1C = randomintrange(2, 3);

  }
  if(isDefined(self.lastattacker) && distancesquared(self.origin, self.lastattacker.origin) < squared(512)) {
    self._id_0D1C = 0;

  }
  if(self._id_0D1C > 0) {
    self._id_0D1C--;
  } else {
    self._id_0D1B = 1;
    self.allowpain = 0;

    if(self.ignoreme) {
      self._id_0D1D = 1;
    } else {
      self.ignoreme = 1;

    }
    if(animscripts\utility::_id_0C95()) {
      animscripts\shared::_id_0C9B(self.primaryweapon, "right");

    }
    if(self.a._id_0D26 == "crouch") {
      return % exposed_crouch_extendedpaina;

    }
    var_0 = animscripts\utility::_id_0C6D( % stand_exposed_extendedpain_chest, % stand_exposed_extendedpain_head_2_crouch, % stand_exposed_extendedpain_hip_2_crouch);
  }
}

_id_0D27() {
  if(self.damageshield && !isDefined(self._id_0D28)) {
    var_0 = _id_0D25();

    if(isDefined(var_0)) {
      return var_0;
    }
  }

  if(isDefined(self.a._id_0D29)) {
    if(self.a._id_0D26 == "crouch") {
      return % back_pain;
    } else {
      animscripts\notetracks::_id_0D2A();
    }
  }

  if(self.a._id_0D26 == "stand") {
    var_1 = isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 4096;

    if(!var_1 && self.a._id_0D2B == "run" && abs(self getmotionangle()) < 60) {
      return _id_0D2C();

    }
    self.a._id_0D2B = "stop";
    return _id_0D30();
  } else if(self.a._id_0D26 == "crouch") {
    self.a._id_0D2B = "stop";
    return _id_0D33();
  } else if(self.a._id_0D26 == "prone") {
    self.a._id_0D2B = "stop";
    return _id_0D34();
  }
}

_id_0D2C() {
  var_0 = [];
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  if(self maymovetopoint(self localtoworldcoords((300, 0, 0)))) {
    var_2 = 1;
    var_1 = 1;
  } else if(self maymovetopoint(self localtoworldcoords((200, 0, 0)))) {
    var_1 = 1;

  }
  if(isDefined(self.a._id_0D2D)) {
    var_2 = 0;
    var_1 = 0;
  }

  if(var_2) {
    var_0[var_0.size] = % run_pain_leg;
    var_0[var_0.size] = % run_pain_shoulder;
    var_0[var_0.size] = % run_pain_stomach_stumble;
    var_0[var_0.size] = % run_pain_head;
  }

  if(var_1) {
    var_0[var_0.size] = % run_pain_fallonknee_02;
    var_0[var_0.size] = % run_pain_stomach;
    var_0[var_0.size] = % run_pain_stumble;
    var_0[var_0.size] = % run_pain_stomach_fast;
    var_0[var_0.size] = % run_pain_leg_fast;
    var_0[var_0.size] = % run_pain_fall;
  } else if(self maymovetopoint(self localtoworldcoords((120, 0, 0)))) {
    var_0[var_0.size] = % run_pain_fallonknee;
    var_0[var_0.size] = % run_pain_fallonknee_03;
  }

  if(!var_0.size) {
    self.a._id_0D2B = "stop";
    return _id_0D30();
  }

  return var_0[randomint(var_0.size)];
}

_id_0D2E() {
  var_0 = [];

  if(animscripts\utility::_id_0D2F("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck")) {
    var_0[var_0.size] = % pistol_stand_pain_chest;

  }
  if(animscripts\utility::_id_0D2F("torso_lower", "left_leg_upper", "right_leg_upper")) {
    var_0[var_0.size] = % pistol_stand_pain_groin;

  }
  if(animscripts\utility::_id_0D2F("head", "neck")) {
    var_0[var_0.size] = % pistol_stand_pain_head;

  }
  if(animscripts\utility::_id_0D2F("left_arm_lower", "left_arm_upper", "torso_upper")) {
    var_0[var_0.size] = % pistol_stand_pain_leftshoulder;

  }
  if(animscripts\utility::_id_0D2F("right_arm_lower", "right_arm_upper", "torso_upper")) {
    var_0[var_0.size] = % pistol_stand_pain_rightshoulder;

  }
  if(var_0.size < 2) {
    var_0[var_0.size] = % pistol_stand_pain_chest;

  }
  if(var_0.size < 2) {
    var_0[var_0.size] = % pistol_stand_pain_groin;

  }
  return var_0[randomint(var_0.size)];
}

_id_0D30() {
  if(animscripts\utility::_id_0C95()) {
    return _id_0D2E();

  }
  var_0 = [];
  var_1 = [];

  if(animscripts\utility::_id_0D2F("torso_upper", "torso_lower")) {
    var_1[var_1.size] = % stand_exposed_extendedpain_gut;
    var_1[var_1.size] = % stand_exposed_extendedpain_stomach;
  }

  if(animscripts\utility::_id_0D2F("torso_upper", "head", "helmet", "neck")) {
    var_0[var_0.size] = % exposed_pain_face;
    var_0[var_0.size] = % stand_exposed_extendedpain_neck;
    var_1[var_1.size] = % stand_exposed_extendedpain_head_2_crouch;
  }

  if(animscripts\utility::_id_0D2F("right_arm_upper", "right_arm_lower")) {
    var_0[var_0.size] = % exposed_pain_right_arm;

  }
  if(animscripts\utility::_id_0D2F("left_arm_lower", "left_arm_upper")) {
    var_0[var_0.size] = % stand_exposed_extendedpain_shoulderswing;
    var_1[var_1.size] = % stand_exposed_extendedpain_shoulder_2_crouch;
  }

  if(animscripts\utility::_id_0D2F("torso_lower", "left_leg_upper", "right_leg_upper")) {
    var_0[var_0.size] = % exposed_pain_groin;
    var_0[var_0.size] = % stand_exposed_extendedpain_hip;
    var_1[var_1.size] = % stand_exposed_extendedpain_hip_2_crouch;
    var_1[var_1.size] = % stand_exposed_extendedpain_feet_2_crouch;
    var_1[var_1.size] = % stand_exposed_extendedpain_stomach;
  }

  if(animscripts\utility::_id_0D2F("left_foot", "right_foot", "left_leg_lower", "right_leg_lower")) {
    var_0[var_0.size] = % stand_exposed_extendedpain_thigh;
    var_1[var_1.size] = % stand_exposed_extendedpain_feet_2_crouch;
  }

  if(var_0.size < 2) {
    if(!self.a._id_0D31) {
      var_0[var_0.size] = % exposed_pain_2_crouch;
      var_0[var_0.size] = % stand_extendedpainb;
    } else {
      var_0[var_0.size] = % exposed_pain_right_arm;
      var_0[var_0.size] = % exposed_pain_face;
      var_0[var_0.size] = % exposed_pain_groin;
    }
  }

  if(var_1.size < 2) {
    var_1[var_1.size] = % stand_extendedpainc;
    var_1[var_1.size] = % stand_exposed_extendedpain_chest;
  }

  if(!self.damageshield && !self.a._id_0D31) {
    var_2 = randomint(var_0.size + var_1.size);

    if(var_2 < var_0.size) {
      return var_0[var_2];
    } else {
      return var_1[var_2 - var_0.size];
    }
  }

  return var_0[randomint(var_0.size)];
}

_id_0D32(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_4 = 1;

    if(animhasnotetrack(var_3, "code_move")) {
      var_4 = getnotetracktimes(var_3, "code_move")[0];

    }
    var_5 = getmovedelta(var_3, 0, var_4);
    var_6 = self localtoworldcoords(var_5);

    if(self maymovetopoint(var_6, 1, 1)) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_0D33() {
  var_0 = [];

  if(!self.damageshield && !self.a._id_0D31) {
    var_0[var_0.size] = % exposed_crouch_extendedpaina;

  }
  var_0[var_0.size] = % exposed_crouch_pain_chest;
  var_0[var_0.size] = % exposed_crouch_pain_headsnap;
  var_0[var_0.size] = % exposed_crouch_pain_flinch;

  if(animscripts\utility::_id_0D2F("left_hand", "left_arm_lower", "left_arm_upper")) {
    var_0[var_0.size] = % exposed_crouch_pain_left_arm;

  }
  if(animscripts\utility::_id_0D2F("right_hand", "right_arm_lower", "right_arm_upper")) {
    var_0[var_0.size] = % exposed_crouch_pain_right_arm;

  }
  return var_0[randomint(var_0.size)];
}

_id_0D34() {
  if(randomint(2) == 0) {
    return % prone_reaction_a;
  } else {
    return % prone_reaction_b;
  }
}

_id_0D35(var_0) {
  var_1 = 1;
  self setflaggedanimknoballrestart("painanim", var_0, % body, 1, 0.1, var_1);

  if(self.a._id_0D26 == "prone") {
    self updateprone( % prone_legs_up, % prone_legs_down, 1, 0.1, 1);

  }
  if(animhasnotetrack(var_0, "start_aim")) {
    thread _id_0D36("painanim");
    self endon("start_aim");
  }

  if(animhasnotetrack(var_0, "code_move")) {
    animscripts\shared::_id_0C51("painanim");

  }
  animscripts\shared::_id_0C51("painanim");
}

_id_0D36(var_0) {
  self endon("killanimscript");
  self waittillmatch(var_0, "start_aim");
  self notify("start_aim");
}

_id_0D37() {
  self endon("killanimscript");
  self._id_0D1E = 1;
  self.allowpain = 0;
  wait 0.5;
  self._id_0D1E = undefined;
  self.allowpain = 1;
}

_id_0D38(var_0) {
  if(var_0 == "none") {
    return 0;

  }
  self.a._id_0D19 = "none";
  thread _id_0D37();

  switch (var_0) {
    case "cover_left":
      if(self.a._id_0D26 == "stand") {
        var_1 = [];
        var_1[var_1.size] = % corner_standl_painb;
        var_1[var_1.size] = % corner_standl_painc;
        var_1[var_1.size] = % corner_standl_paind;
        var_1[var_1.size] = % corner_standl_paine;
        _id_0D3A(var_1);
        var_2 = 1;
      } else if(self.a._id_0D26 == "crouch") {
        var_1 = [];
        var_1[var_1.size] = % cornercrl_painb;
        _id_0D3A(var_1);
        var_2 = 1;
      } else {
        var_2 = 0;

      }
      break;
    case "cover_right":
      if(self.a._id_0D26 == "stand") {
        var_1 = [];
        var_1[0] = % corner_standr_pain;
        var_1[1] = % corner_standr_painb;
        var_1[2] = % corner_standr_painc;
        _id_0D3A(var_1);
        var_2 = 1;
      } else if(self.a._id_0D26 == "crouch") {
        var_1 = [];
        var_1[var_1.size] = % cornercrr_alert_paina;
        var_1[var_1.size] = % cornercrr_alert_painc;
        _id_0D3A(var_1);
        var_2 = 1;
      } else {
        var_2 = 0;

      }
      break;
    case "cover_right_stand_A":
      var_2 = 0;
      break;
    case "cover_right_stand_B":
      _id_0D3B( % corner_standr_pain_b_2_alert);
      var_2 = 1;
      break;
    case "cover_left_stand_A":
      _id_0D3B( % corner_standl_pain_a_2_alert);
      var_2 = 1;
      break;
    case "cover_left_stand_B":
      _id_0D3B( % corner_standl_pain_b_2_alert);
      var_2 = 1;
      break;
    case "cover_crouch":
      var_1 = [];
      var_1[var_1.size] = % covercrouch_pain_right;
      var_1[var_1.size] = % covercrouch_pain_front;
      var_1[var_1.size] = % covercrouch_pain_left_3;
      _id_0D3A(var_1);
      var_2 = 1;
      break;
    case "cover_stand":
      var_1 = [];
      var_1[var_1.size] = % coverstand_pain_groin;
      var_1[var_1.size] = % coverstand_pain_leg;
      _id_0D3A(var_1);
      var_2 = 1;
      break;
    case "cover_stand_aim":
      var_1 = [];
      var_1[var_1.size] = % coverstand_pain_aim_2_hide_01;
      var_1[var_1.size] = % coverstand_pain_aim_2_hide_02;
      _id_0D3A(var_1);
      var_2 = 1;
      break;
    case "cover_crouch_aim":
      _id_0D3B( % covercrouch_pain_aim_2_hide_01);
      var_2 = 1;
      break;
    case "saw":
      if(self.a._id_0D26 == "stand") {
        var_3 = % saw_gunner_pain;
      } else if(self.a._id_0D26 == "crouch") {
        var_3 = % saw_gunner_lowwall_pain_02;
      } else {
        var_3 = % saw_gunner_prone_pain;

      }
      self setflaggedanimknob("painanim", var_3, 1, 0.3, 1);
      animscripts\shared::_id_0C51("painanim");
      var_2 = 1;
      break;
    case "mg42":
      _id_0D3C(self.a._id_0D26);
      var_2 = 1;
      break;
    case "minigun":
      var_2 = 0;
      break;
    case "corner_right_martyrdom":
      var_2 = _id_0D70();
      break;
    case "rambo":
    case "rambo_right":
    case "rambo_left":
    case "dying_crawl":
      var_2 = 0;
      break;
    default:
      var_2 = 0;
  }

  return var_2;
}

_id_0D39() {
  self endon("death");
  wait 0.05;
  self notify("pain_death");
}

_id_0D3A(var_0) {
  var_1 = var_0[randomint(var_0.size)];
  self setflaggedanimknob("painanim", var_1, 1, 0.3, 1);
  animscripts\shared::_id_0C51("painanim");
}

_id_0D3B(var_0) {
  self setflaggedanimknob("painanim", var_0, 1, 0.3, 1);
  animscripts\shared::_id_0C51("painanim");
}

_id_0D3C(var_0) {
  self setflaggedanimknob("painanim", level._id_0D3D["pain_" + var_0], 1, 0.1, 1);
  animscripts\shared::_id_0C51("painanim");
}

_id_0D3E(var_0, var_1) {
  self endon("killanimscript");
  self endon("death");

  if(isDefined(var_1)) {
    self endon(var_1);

  }
  wait(var_0);
  self.a._id_0D2B = "stop";
}

_id_0D3F() {
  if(self.a._id_0D31 || self.diequietly || self.damageshield) {
    return 0;

  }
  if(self.stairsstate != "none") {
    return 0;

  }
  if(isDefined(self.a._id_0D29)) {
    return 0;

  }
  var_0["prone"] = animscripts\utility::_id_0C6D( % dying_crawl_2_back);
  var_0["stand"] = animscripts\utility::_id_0C6D( % dying_stand_2_back_v1, % dying_stand_2_back_v2);
  var_0["crouch"] = animscripts\utility::_id_0C6D( % dying_crouch_2_back);
  self.a._id_0D40 = var_0[self.a._id_0D26][randomint(var_0[self.a._id_0D26].size)];

  if(isDefined(self._id_0D41)) {
    self.health = 10;
    thread _id_0D4A();
    self waittill("killanimscript");
    return 1;
  }

  if(!_id_0D46(self.a._id_0D40)) {
    return 0;

  }
  if(self.health > 100) {
    return 0;

  }
  var_1 = animscripts\utility::_id_0D2F("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot");

  if(var_1 && self.health < self.maxhealth * 0.4) {
    if(gettime() < anim._id_0D42) {
      return 0;
    }
  } else {
    if(anim._id_0D43 > 0) {
      return 0;

    }
    if(gettime() < anim._id_0D44) {
      return 0;
    }
  }

  if(isDefined(self._id_0D45)) {
    return 0;

  }
  foreach(var_3 in level.players) {
    if(distance(self.origin, var_3.origin) < 175) {
      return 0;
    }
  }

  if(animscripts\utility::_id_0D2F("head", "helmet", "gun", "right_hand", "left_hand")) {
    return 0;

  }
  if(animscripts\utility::_id_0C95()) {
    return 0;

  }
  anim._id_0D44 = gettime() + 3000;
  anim._id_0D42 = gettime() + 3000;
  thread _id_0D4A();
  self waittill("killanimscript");
  return 1;
}

_id_0D46(var_0) {
  if(isDefined(self.a._id_0D47)) {
    return 1;

  }
  var_1 = getmovedelta(var_0, 0, 1);
  var_2 = self localtoworldcoords(var_1);
  return self maymovetopoint(var_2);
}

_id_0D48() {
  self.a._id_0C6D = [];
  self.a._id_0C6D["stand_2_crawl"] = animscripts\utility::_id_0C6D( % dying_stand_2_crawl_v1, % dying_stand_2_crawl_v2, % dying_stand_2_crawl_v3);
  self.a._id_0C6D["crouch_2_crawl"] = animscripts\utility::_id_0C6D( % dying_crouch_2_crawl);
  self.a._id_0C6D["crawl"] = % dying_crawl;
  self.a._id_0C6D["death"] = animscripts\utility::_id_0C6D( % dying_crawl_death_v1, % dying_crawl_death_v2);
  self.a._id_0C6D["back_idle"] = % dying_back_idle;
  self.a._id_0C6D["back_idle_twitch"] = animscripts\utility::_id_0C6D( % dying_back_twitch_a, % dying_back_twitch_b);
  self.a._id_0C6D["back_crawl"] = % dying_crawl_back;
  self.a._id_0C6D["back_fire"] = % dying_back_fire;
  self.a._id_0C6D["back_death"] = animscripts\utility::_id_0C6D( % dying_back_death_v1, % dying_back_death_v2, % dying_back_death_v3);

  if(isDefined(self._id_0D49)) {
    [[self._id_0D49]]();
  }
}

_id_0D4A() {
  self endon("kill_long_death");
  self endon("death");
  _id_0D48();
  thread _id_0D67("crawling");
  self.a._id_0D19 = "none";
  self._id_0D4B = undefined;
  thread _id_0D39();
  level notify("ai_crawling", self);
  thread _id_0D51();
  self setanimknoball( % dying, % body, 1, 0.1, 1);

  if(!_id_0D53()) {
    return;
  }
  self setflaggedanimknob("transition", self.a._id_0D40, 1, 0.5, 1);
  animscripts\notetracks::_id_0D4C("transition", ::_id_0D5E);
  self.a._id_0D19 = "dying_crawl";
  thread _id_0D5A();

  if(isDefined(self.enemy)) {
    self setlookatentity(self.enemy);

  }
  _id_0D6D();

  while(_id_0D6F()) {
    var_0 = animscripts\utility::_id_0D4D("back_crawl");

    if(!_id_0D46(var_0)) {
      break;
    }

    self setflaggedanimknobrestart("back_crawl", var_0, 1, 0.1, 1.0);
    animscripts\notetracks::_id_0D4C("back_crawl", ::_id_0D5E);
  }

  self._id_0D4E = gettime() + randomintrange(4000, 20000);

  while(_id_0D52()) {
    if(animscripts\utility::_id_0CE3() && _id_0D60()) {
      var_1 = animscripts\utility::_id_0D4D("back_fire");
      self setflaggedanimknobrestart("back_idle_or_fire", var_1, 1, 0.2, 1.0);
      animscripts\shared::_id_0C51("back_idle_or_fire");
      continue;
    }

    var_1 = animscripts\utility::_id_0D4D("back_idle");

    if(randomfloat(1) < 0.4) {
      var_1 = animscripts\utility::_id_0CA8("back_idle_twitch");

    }
    self setflaggedanimknobrestart("back_idle_or_fire", var_1, 1, 0.1, 1.0);
    var_2 = getanimlength(var_1);

    while(var_2 > 0) {
      if(animscripts\utility::_id_0CE3() && _id_0D60()) {
        break;
      }

      var_3 = 0.5;

      if(var_3 > var_2) {
        var_3 = var_2;
        var_2 = 0;
      } else {
        var_2 = var_2 - var_3;

      }
      animscripts\notetracks::_id_0D4F(var_3, "back_idle_or_fire");
    }
  }

  self notify("end_dying_crawl_back_aim");
  self clearanim( % dying_back_aim_4_wrapper, 0.3);
  self clearanim( % dying_back_aim_6_wrapper, 0.3);
  self._id_0D50 = animscripts\utility::_id_0CA8("back_death");
  _id_0D79();
  self.a._id_0D19 = "none";
  self._id_0D4B = undefined;
}

_id_0D51() {
  if(self.team == "allies") {
    return;
  }
  self endon("end_dying_crawl_back_aim");
  self waittill("death", var_0, var_1);

  if(!isDefined(self) || !isDefined(var_0) || !isplayer(var_0)) {
    return;
  }
}

_id_0D52() {
  if(!_id_0D66(anglesToForward(self.angles))) {
    return 0;

  }
  return gettime() < self._id_0D4E;
}

_id_0D53() {
  if(!isDefined(self._id_0D41)) {
    if(self.a._id_0D26 == "prone") {
      return 1;

    }
    if(self.a._id_0D2B == "stop") {
      if(randomfloat(1) < 0.4) {
        if(randomfloat(1) < 0.5) {
          return 1;
        }
      } else if(abs(self.damageyaw) > 90) {
        return 1;
      }
    } else if(abs(self getmotionangle()) > 90) {
      return 1;
    }
  }

  if(self.a._id_0D26 != "prone") {
    var_0 = animscripts\utility::_id_0CA8(self.a._id_0D26 + "_2_crawl");

    if(!_id_0D46(var_0)) {
      return 1;

    }
    thread _id_0D57();
    self setflaggedanimknob("falling", var_0, 1, 0.5, 1);
    animscripts\shared::_id_0C51("falling");
  } else {
    thread _id_0D57();

  }
  self.a._id_0D40 = % dying_crawl_2_back;
  self.a._id_0D19 = "dying_crawl";
  _id_0D6D();

  while(_id_0D6F()) {
    var_1 = animscripts\utility::_id_0D4D("crawl");

    if(!_id_0D46(var_1)) {
      return 1;

    }
    if(isDefined(self._id_0D54)) {
      self playSound(self._id_0D54);

    }
    self setflaggedanimknobrestart("crawling", var_1, 1, 0.1, 1.0);
    animscripts\shared::_id_0C51("crawling");
  }

  self notify("done_crawling");

  if(!isDefined(self._id_0D41) && _id_0D66(anglesToForward(self.angles) * -1)) {
    return 1;

  }
  var_2 = animscripts\utility::_id_0CA8("death");

  if(var_2 != % dying_crawl_death_v2) {
    self.a._id_0D55 = 1;

  }
  animscripts\death::_id_0D56(var_2);
  _id_0D79();
  self.a._id_0D19 = "none";
  self._id_0D4B = undefined;
  return 0;
}

_id_0D57() {
  self endon("death");

  if(self.a._id_0D26 != "prone") {
    for(;;) {
      self waittill("falling", var_0);

      if(issubstr(var_0, "bodyfall")) {
        break;
      }
    }
  }

  var_1 = "J_SpineLower";
  var_2 = "tag_origin";
  var_3 = 0.25;
  var_4 = level._effect["crawling_death_blood_smear"];

  if(isDefined(self.a._id_0D58)) {
    var_3 = self.a._id_0D58;

  }
  if(isDefined(self.a._id_0D59)) {
    var_4 = level._effect[self.a._id_0D59];

  }
  while(var_3) {
    var_5 = self gettagorigin(var_1);
    var_6 = self gettagangles(var_2);
    var_7 = anglestoright(var_6);
    var_8 = anglesToForward((270, 0, 0));
    playFX(var_4, var_5, var_8, var_7);
    wait(var_3);
  }
}

_id_0D5A() {
  self endon("kill_long_death");
  self endon("death");
  self endon("end_dying_crawl_back_aim");

  if(isDefined(self._id_0D5B)) {
    return;
  }
  self._id_0D5B = 1;
  self setanimlimited( % dying_back_aim_4, 1, 0);
  self setanimlimited( % dying_back_aim_6, 1, 0);
  var_0 = 0;

  for(;;) {
    var_1 = animscripts\utility::_id_0D5C();
    var_2 = angleclamp180(var_1 - var_0);

    if(abs(var_2) > 3) {
      var_2 = common_scripts\utility::sign(var_2) * 3;

    }
    var_1 = angleclamp180(var_0 + var_2);

    if(var_1 < 0) {
      if(var_1 < -45.0) {
        var_1 = -45.0;

      }
      var_3 = var_1 / -45.0;
      self setanim( % dying_back_aim_4_wrapper, var_3, 0.05);
      self setanim( % dying_back_aim_6_wrapper, 0, 0.05);
    } else {
      if(var_1 > 45.0) {
        var_1 = 45.0;

      }
      var_3 = var_1 / 45.0;
      self setanim( % dying_back_aim_6_wrapper, var_3, 0.05);
      self setanim( % dying_back_aim_4_wrapper, 0, 0.05);
    }

    var_0 = var_1;
    wait 0.05;
  }
}

_id_0D5D() {
  self endon("kill_long_death");
  self endon("death");
  wait 0.5;
  thread _id_0D5A();
}

_id_0D5E(var_0) {
  if(var_0 == "fire_spray") {
    if(!animscripts\utility::_id_0CE3()) {
      return 1;

    }
    if(!_id_0D60()) {
      return 1;

    }
    animscripts\utility::_id_0D5F();
    return 1;
  } else if(var_0 == "pistol_pickup") {
    thread _id_0D5D();
    return 0;
  }

  return 0;
}

_id_0D60() {
  var_0 = self.enemy getshootatpos();
  var_1 = self getmuzzleangle();
  var_2 = vectortoangles(var_0 - self getmuzzlepos());
  var_3 = animscripts\utility::_id_0D61(var_1[1] - var_2[1]);

  if(var_3 > anim._id_0D62) {
    if(distancesquared(self getEye(), var_0) > anim._id_0D63 || var_3 > anim._id_0D64) {
      return 0;
    }
  }

  return animscripts\utility::_id_0D61(var_1[0] - var_2[0]) <= anim._id_0D65;
}

_id_0D66(var_0) {
  if(!isDefined(self.enemy)) {
    return 0;

  }
  var_1 = vectornormalize(self.enemy getshootatpos() - self getEye());
  return vectordot(var_1, var_0) > 0.5;
}

_id_0D67(var_0) {
  self endon("kill_long_death");
  self endon("death");
  self._id_0D68 = 1;
  self._id_0D0F = 1;
  self.a._id_0D69 = 1;
  self notify("long_death");
  self.health = 10000;
  self.threatbias = self.threatbias - 2000;
  wait 0.75;

  if(self.health > 1) {
    self.health = 1;

  }
  wait 0.05;
  self._id_0D0F = undefined;
  self.a._id_0D6A = 1;

  if(var_0 == "crawling") {
    wait 1.0;

    if(isDefined(level.player) && distancesquared(self.origin, level.player.origin) < 1048576) {
      anim._id_0D43 = randomintrange(10, 30);
      anim._id_0D44 = gettime() + randomintrange(15000, 60000);
    } else {
      anim._id_0D43 = randomintrange(5, 12);
      anim._id_0D44 = gettime() + randomintrange(5000, 25000);
    }

    anim._id_0D42 = gettime() + randomintrange(7000, 13000);
  } else if(var_0 == "corner_grenade") {
    wait 1.0;

    if(isDefined(level.player) && distancesquared(self.origin, level.player.origin) < 490000) {
      anim._id_0D6B = randomintrange(10, 30);
      anim._id_0D6C = gettime() + randomintrange(15000, 60000);
    } else {
      anim._id_0D6B = randomintrange(5, 12);
      anim._id_0D6C = gettime() + randomintrange(5000, 25000);
    }
  }
}

_id_0D6D() {
  if(isDefined(self.a._id_0D47)) {
    self.a._id_0D6E = self.a._id_0D47;
  } else {
    self.a._id_0D6E = randomintrange(1, 5);
  }
}

_id_0D6F() {
  if(!self.a._id_0D6E) {
    self.a._id_0D6E = undefined;
    return 0;
  }

  self.a._id_0D6E--;
  return 1;
}

_id_0D70() {
  if(anim._id_0D6B > 0) {
    return 0;

  }
  if(gettime() < anim._id_0D6C) {
    return 0;

  }
  if(self.a._id_0D31 || self.diequietly || self.damageshield) {
    return 0;

  }
  if(isDefined(self._id_0D45)) {
    return 0;

  }
  if(distance(self.origin, level.player.origin) < 175) {
    return 0;

  }
  anim._id_0D6C = gettime() + 3000;
  thread _id_0D71();
  self waittill("killanimscript");
  return 1;
}

_id_0D71() {
  self endon("kill_long_death");
  self endon("death");
  thread _id_0D39();
  thread _id_0D67("corner_grenade");
  thread maps\_utility::_id_0D72(0);
  self.threatbias = -1000;
  self setflaggedanimknoballrestart("corner_grenade_pain", % corner_standr_death_grenade_hit, % body, 1, 0.1);
  self waittillmatch("corner_grenade_pain", "dropgun");
  animscripts\shared::_id_0D73();
  self waittillmatch("corner_grenade_pain", "anim_pose = \"back\"");
  animscripts\notetracks::_id_0D74();
  self waittillmatch("corner_grenade_pain", "grenade_left");
  var_0 = getweaponmodel("fraggrenade");
  self attach(var_0, "tag_inhand");
  self._id_0D45 = ::_id_0D7D;
  self waittillmatch("corner_grenade_pain", "end");
  var_1 = gettime() + randomintrange(25000, 60000);
  self setflaggedanimknoballrestart("corner_grenade_idle", % corner_standr_death_grenade_idle, % body, 1, 0.2);
  thread _id_0D80();

  while(!_id_0D7B()) {
    if(gettime() >= var_1) {
      break;
    }

    animscripts\notetracks::_id_0D4F(0.1, "corner_grenade_idle");
  }

  var_2 = % corner_standr_death_grenade_slump;
  self setflaggedanimknoballrestart("corner_grenade_release", var_2, % body, 1, 0.2);
  var_3 = getnotetracktimes(var_2, "grenade_drop");
  var_4 = var_3[0] * getanimlength(var_2);
  wait(var_4 - 1.0);
  animscripts\death::playdeathsound();
  wait 0.7;
  self._id_0D45 = ::_id_0D7F;
  var_5 = (0, 0, 30) - anglestoright(self.angles) * 70;
  _id_0D76(var_5, randomfloatrange(2.0, 3.0));
  wait 0.05;
  self detach(var_0, "tag_inhand");
  thread _id_0D78();
}

_id_0D76(var_0, var_1) {
  var_2 = self gettagorigin("tag_inhand");
  var_3 = var_2 + (0, 0, 20);
  var_4 = var_2 - (0, 0, 20);
  var_5 = bulletTrace(var_3, var_4, 0, undefined);

  if(var_5["fraction"] < 0.5) {
    var_2 = var_5["position"];

  }
  var_6 = "default";

  if(var_5["surfacetype"] != "none") {
    var_6 = var_5["surfacetype"];

  }
  thread _id_0D77("grenade_bounce_" + var_6, var_2);
  self.grenadeweapon = "fraggrenade";
  self magicgrenademanual(var_2, var_0, var_1);
}

_id_0D77(var_0, var_1) {
  var_2 = spawn("script_origin", var_1);
  var_2 playSound(var_0, "sounddone");
  var_2 waittill("sounddone");
  var_2 delete();
}

_id_0D78() {
  self.a._id_0D55 = 1;
  _id_0D79();
  self startragdoll();
  wait 0.1;
  self notify("grenade_drop_done");
}

_id_0D79() {
  if(isDefined(self._id_0D7A)) {
    self kill(self.origin, self._id_0D7A);
  } else {
    self kill();
  }
}

_id_0D7B() {
  if(!isDefined(self.enemy)) {
    return 0;

  }
  if(distancesquared(self.origin, self.enemy.origin) > 147456) {
    return 0;

  }
  if(distancesquared(self.origin, self.enemy.origin) < 16384) {
    return 1;

  }
  var_0 = self.enemy.origin + self._id_0D7C * 3.0;
  var_1 = self.enemy.origin;

  if(self.enemy.origin != var_0) {
    var_1 = pointonsegmentnearesttopoint(self.enemy.origin, var_0, self.origin);

  }
  if(distancesquared(self.origin, var_1) < 16384) {
    return 1;

  }
  return 0;
}

_id_0D7D() {
  var_0 = animscripts\utility::_id_0C6D( % dying_back_death_v1, % dying_back_death_v2, % dying_back_death_v3, % dying_back_death_v4);
  var_1 = var_0[randomint(var_0.size)];
  animscripts\death::playdeathsound();
  self setflaggedanimknoballrestart("corner_grenade_die", var_1, % body, 1, 0.2);
  var_2 = animscripts\combat_utility::_id_0D7E();
  _id_0D76(var_2, 3.0);
  var_3 = getweaponmodel("fraggrenade");
  self detach(var_3, "tag_inhand");
  wait 0.05;
  self startragdoll();
  self waittillmatch("corner_grenade_die", "end");
}

_id_0D7F() {
  self waittill("grenade_drop_done");
}

_id_0D80() {
  self endon("kill_long_death");
  self endon("death");
  self._id_0D7C = (0, 0, 0);
  var_0 = undefined;
  var_1 = self.origin;
  var_2 = 0.15;

  for(;;) {
    if(isDefined(self.enemy) && isDefined(var_0) && self.enemy == var_0) {
      var_3 = self.enemy.origin;
      self._id_0D7C = (var_3 - var_1) * (1 / var_2);
      var_1 = var_3;
    } else {
      if(isDefined(self.enemy)) {
        var_1 = self.enemy.origin;
      } else {
        var_1 = self.origin;

      }
      var_0 = self.enemy;
      self._id_0D81 = (0, 0, 0);
    }

    wait(var_2);
  }
}

_id_0D82(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_0D83)) {
    return;
  }
  if(var_0 < self.minpaindamage) {
    return;
  }
  self._id_0D83 = 1;
  var_7 = animscripts\utility::_id_0C6D( % pain_add_standing_belly, % pain_add_standing_left_arm, % pain_add_standing_right_arm);
  var_8 = % pain_add_standing_belly;

  if(animscripts\utility::_id_0D2F("left_arm_lower", "left_arm_upper", "left_hand")) {
    var_8 = % pain_add_standing_left_arm;

  }
  if(animscripts\utility::_id_0D2F("right_arm_lower", "right_arm_upper", "right_hand")) {
    var_8 = % pain_add_standing_right_arm;
  } else if(animscripts\utility::_id_0D2F("left_leg_upper", "left_leg_lower", "left_foot")) {
    var_8 = % pain_add_standing_left_leg;
  } else if(animscripts\utility::_id_0D2F("right_leg_upper", "right_leg_lower", "right_foot")) {
    var_8 = % pain_add_standing_right_leg;
  } else {
    var_8 = var_7[randomint(var_7.size)];

  }
  self setanimlimited( % add_pain, 1, 0.1, 1);
  self setanimlimited(var_8, 1, 0, 1);
  wait 0.4;
  self clearanim(var_8, 0.2);
  self clearanim( % add_pain, 0.2);
  self._id_0D83 = undefined;
}