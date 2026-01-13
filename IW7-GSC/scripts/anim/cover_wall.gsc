/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\cover_wall.gsc
*********************************************/

func_950B() {}

func_470E(var_0) {
  self endon("killanimscript");
  self.covernode = self.target_getindexoftarget;
  self.var_4757 = var_0;
  if(!isDefined(self.target_getindexoftarget.turret)) {
    scripts\anim\cover_behavior::func_129B4(0);
  }

  if(var_0 == "crouch") {
    func_F923("unknown");
    self.covernode func_97F0();
  } else {
    func_F925("unknown");
  }

  self.a.var_1A3E = undefined;
  self orientmode("face angle", self.covernode.angles[1]);
  if(isDefined(self.target_getindexoftarget) && isDefined(self.target_getindexoftarget.turret)) {
    func_130DF();
  }

  self animmode("normal");
  if(var_0 == "crouch" && self.a.pose == "stand") {
    var_1 = scripts\anim\utility::func_1F64("stand_2_hide");
    var_2 = getanimlength(var_1);
    self give_boombox(var_1, % body, 1, 0.2, scripts\anim\combat_utility::func_6B9A());
    thread scripts\anim\shared::func_BD1D(self.covernode, var_2);
    wait(var_2);
    self.a.var_4727 = "hide";
  } else {
    func_B05A(0.4);
    if(distancesquared(self.origin, self.covernode.origin) > 1) {
      thread scripts\anim\shared::func_BD1D(self.covernode, 0.4);
      wait(0.2);
      if(var_0 == "crouch") {
        self.a.pose = "crouch";
      }

      wait(0.2);
    } else {
      wait(0.1);
    }
  }

  func_F6C0();
  if(var_0 == "crouch") {
    if(self.a.pose == "prone") {
      scripts\anim\utility::exitpronewrapper(1);
    }

    self.a.pose = "crouch";
  }

  if(self.var_4757 == "stand") {
    self.a.var_10930 = "cover_stand";
  } else {
    self.a.var_10930 = "cover_crouch";
  }

  var_3 = spawnStruct();
  if(!self.logstring) {
    var_3.var_BD1C = ::scripts\anim\cover_behavior::func_BD1C;
  }

  var_3.openfile = ::func_4742;
  var_3.var_AB2D = ::func_D66A;
  var_3.setnojipscore = ::look;
  var_3.var_6B9B = ::func_6B9B;
  var_3.var_92CC = ::func_92CC;
  var_3.var_6F27 = ::func_6F27;
  var_3.objective_position = ::func_128AF;
  var_3._meth_85BF = ::func_128B0;
  var_3.var_2B99 = ::func_2B99;
  scripts\anim\cover_behavior::main(var_3);
}

func_9F33(var_0) {
  return getsubstr(var_0, 0, 3) == "rpd" && var_0.size == 3 || var_0[3] == "_";
}

func_97F0() {
  if(isDefined(self.var_4A9D)) {
    return;
  }

  var_0 = (0, 0, 42);
  var_1 = anglesToForward(self.angles);
  self.var_4A9D = sighttracepassed(self.origin + var_0, self.origin + var_0 + var_1 * 64, 0, undefined);
}

func_F923(var_0) {
  scripts\anim\combat::func_F337(self.covernode);
  func_F92B(var_0);
}

func_F925(var_0) {
  scripts\anim\combat::func_F337(self.covernode);
  func_FA52(var_0);
}

func_4742() {
  var_0 = scripts\anim\combat_utility::openfile(2, scripts\anim\utility::func_1F64("reload"));
  if(isDefined(var_0) && var_0) {
    return 1;
  }

  return 0;
}

func_D66A() {
  self.sendmatchdata = 1;
  if(isDefined(self.var_DC5C) && randomfloat(1) < self.var_DC5C) {
    if(func_DC57()) {
      return 1;
    }
  }

  if(!func_D65B()) {
    return 0;
  }

  shootastold();
  scripts\anim\combat_utility::func_631A();
  if(isDefined(self.var_FECF)) {
    var_0 = lengthsquared(self.origin - self.var_FECF);
    if(scripts\anim\utility_common::usingrocketlauncher() && scripts\anim\utility::func_10000(var_0)) {
      if(self.a.pose == "stand") {
        scripts\anim\shared::func_1180E(scripts\anim\utility::func_B027("combat", "drop_rpg_stand"));
      } else {
        scripts\anim\shared::func_1180E(scripts\anim\utility::func_B027("combat", "drop_rpg_crouch"));
      }
    }
  }

  _meth_8405();
  self.var_4716 = undefined;
  self.sendmatchdata = 0;
  return 1;
}

shootastold() {
  self endon("return_to_cover");
  scripts\sp\gameskill::func_54C4();
  for(;;) {
    if(isDefined(self.var_1006D)) {
      break;
    }

    if(!isDefined(self.var_FECF)) {
      self waittill("do_slow_things");
      waittillframeend;
      if(isDefined(self.var_FECF)) {
        continue;
      }

      break;
    }

    if(!self.bulletsinclip) {
      break;
    }

    if(self.var_4757 == "crouch" && func_BE9D()) {
      break;
    }

    func_FEE1();
    self clearanim( % add_fire, 0.2);
  }
}

func_FEE1() {
  if(self.var_4757 == "crouch") {
    thread func_1E82();
  }

  thread scripts\anim\combat_utility::func_1A3E();
  scripts\anim\combat_utility::func_FEDF();
}

func_DC57() {
  if(!scripts\anim\utility::func_8BED()) {
    return 0;
  }

  var_0 = "rambo";
  if(randomint(10) < 2) {
    var_0 = "rambo_fail";
  }

  if(!scripts\anim\utility::func_1F65(var_0)) {
    return 0;
  }

  if(self.var_4757 == "crouch" && !self.covernode.var_4A9D) {
    return 0;
  }

  var_1 = _meth_811F(self.covernode.origin + scripts\anim\utility_common::getnodeoffset(self.covernode));
  if(var_1 > 15) {
    return 0;
  }

  var_2 = anglesToForward(self.angles);
  var_3 = self.origin + var_2 * -16;
  if(!self maymovetopoint(var_3)) {
    return 0;
  }

  self.var_4740 = gettime();
  func_F6C0();
  self.sendmatchdata = 1;
  self.var_9F15 = 1;
  self.a.var_D892 = "rambo";
  self.var_3C60 = 1;
  thread scripts\anim\shared::func_DC59(0);
  var_4 = scripts\anim\utility::func_1F67(var_0);
  self _meth_82E4("rambo", var_4, % body, 1, 0.2, 1);
  func_470A(var_4);
  scripts\anim\shared::donotetracks("rambo");
  self notify("rambo_aim_end");
  self.var_3C60 = 0;
  self.sendmatchdata = 0;
  self.var_A9D8 = gettime();
  self.var_3C60 = 0;
  self.var_9F15 = undefined;
  return 1;
}

func_92CC() {
  self endon("end_idle");
  for(;;) {
    var_0 = randomint(2) == 0 && scripts\anim\utility::func_1F65("hide_idle_twitch");
    if(var_0) {
      var_1 = scripts\anim\utility::func_1F67("hide_idle_twitch");
    } else {
      var_1 = scripts\anim\utility::func_1F64("hide_idle");
    }

    func_D49E(var_1, var_0);
  }
}

func_6F27() {
  if(!scripts\anim\utility::func_1F65("hide_idle_flinch")) {
    return 0;
  }

  var_0 = anglesToForward(self.angles);
  var_1 = self.origin + var_0 * -16;
  if(!self maymovetopoint(var_1, !scripts\engine\utility::actor_is3d())) {
    return 0;
  }

  func_F6C0();
  self.sendmatchdata = 1;
  var_2 = scripts\anim\utility::func_1F67("hide_idle_flinch");
  func_D49E(var_2, 1);
  self.sendmatchdata = 0;
  return 1;
}

func_D49E(var_0, var_1) {
  if(var_1) {
    self _meth_82E4("idle", var_0, % body, 1, 0.25, 1);
  } else {
    self _meth_82E3("idle", var_0, % body, 1, 0.25, 1);
  }

  func_470A(var_0);
  self.a.var_4727 = "hide";
  scripts\anim\shared::donotetracks("idle");
}

look(var_0) {
  if(!isDefined(self.a.var_2274["hide_to_look"])) {
    return 0;
  }

  if(!func_C9FC()) {
    return 0;
  }

  scripts\anim\shared::func_D4C2(scripts\anim\utility::func_1F64("look_idle"), var_0);
  var_1 = undefined;
  if(scripts\anim\utility_common::issuppressedwrapper()) {
    var_1 = scripts\anim\utility::func_1F64("look_to_hide_fast");
  } else {
    var_1 = scripts\anim\utility::func_1F64("look_to_hide");
  }

  self _meth_82E4("looking_end", var_1, % body, 1, 0.1);
  func_470A(var_1);
  scripts\anim\shared::donotetracks("looking_end");
  return 1;
}

func_C9FC() {
  if(isDefined(self.covernode.var_ED6A)) {
    return 0;
  }

  var_0 = scripts\anim\utility::func_1F64("hide_to_look");
  self _meth_82E3("looking_start", var_0, % body, 1, 0.2);
  func_470A(var_0);
  scripts\anim\shared::donotetracks("looking_start");
  return 1;
}

func_6B9B() {
  var_0 = scripts\anim\utility::func_1F67("look");
  self _meth_82E4("look", var_0, % body, 1, 0.1);
  func_470A(var_0);
  scripts\anim\shared::donotetracks("look");
  return 1;
}

func_D65C() {
  if(self.a.var_4727 == "left" || self.a.var_4727 == "right" || self.a.var_4727 == "over") {
    return 1;
  }

  return scripts\anim\combat_utility::func_DCAD();
}

func_D65B() {
  var_0 = func_7DFA();
  var_1 = 0.1;
  var_2 = scripts\anim\utility::func_1F64("hide_2_" + var_0);
  var_3 = !scripts\engine\utility::actor_is3d();
  if(!self maymovetopoint(scripts\anim\utility::func_7DC6(var_2), var_3)) {
    return 0;
  }

  if(self.script == "cover_crouch" && var_0 == "lean") {
    self.var_4716 = 1;
  }

  if(self.var_4757 == "crouch") {
    func_F923(var_0);
  } else {
    func_F925(var_0);
  }

  self.a.var_10930 = "none";
  self.var_10957 = undefined;
  if(self.var_4757 == "stand") {
    self.a.var_10930 = "cover_stand_aim";
  } else {
    self.a.var_10930 = "cover_crouch_aim";
  }

  self.var_3C60 = 1;
  self notify("done_changing_cover_pos");
  func_F6C0();
  var_4 = func_D65C();
  self _meth_82E4("pop_up", var_2, % body, 1, 0.1, var_4);
  thread donotetracksforpopup("pop_up");
  if(animhasnotetrack(var_2, "start_aim")) {
    self waittillmatch("start_aim", "pop_up");
    var_1 = getanimlength(var_2) / var_4 * 1 - self getscoreinfocategory(var_2);
  } else {
    self waittillmatch("end", "pop_up");
    var_1 = 0.1;
  }

  self clearanim(var_2, var_1 + 0.05);
  self.a.var_4727 = var_0;
  self.a.var_D892 = var_0;
  func_F8A6(var_1);
  thread scripts\anim\track::func_11B07();
  wait(var_1);
  if(scripts\anim\utility_common::isasniper()) {
    thread scripts\anim\shoot_behavior::func_103A7();
  }

  self.var_3C60 = 0;
  self.var_4740 = gettime();
  self notify("stop_popup_donotetracks");
  return 1;
}

donotetracksforpopup(var_0) {
  self endon("killanimscript");
  self endon("stop_popup_donotetracks");
  scripts\anim\shared::donotetracks(var_0);
}

func_F8A6(var_0) {
  if(self.a.var_4727 == "left" || self.a.var_4727 == "right") {
    var_1 = "crouch";
  } else {
    var_1 = self.a.var_4727;
  }

  self _meth_82A5(scripts\anim\utility::func_1F64(var_1 + "_aim"), % body, 1, var_0);
  if(var_1 == "crouch") {
    self _meth_82AC(scripts\anim\utility::func_B027("cover_crouch", "add_aim_down"), 1, 0);
    self _meth_82AC(scripts\anim\utility::func_B027("cover_crouch", "add_aim_left"), 1, 0);
    self _meth_82AC(scripts\anim\utility::func_B027("cover_crouch", "add_aim_up"), 1, 0);
    self _meth_82AC(scripts\anim\utility::func_B027("cover_crouch", "add_aim_right"), 1, 0);
    return;
  }

  if(var_1 == "stand") {
    self _meth_82AC(scripts\anim\utility::func_B027("default_stand", "add_aim_down"), 1, 0);
    self _meth_82AC(scripts\anim\utility::func_B027("default_stand", "add_aim_left"), 1, 0);
    self _meth_82AC(scripts\anim\utility::func_B027("default_stand", "add_aim_up"), 1, 0);
    self _meth_82AC(scripts\anim\utility::func_B027("default_stand", "add_aim_right"), 1, 0);
    return;
  }

  if(var_1 == "lean") {
    self _meth_82AC(scripts\anim\utility::func_B027("default_stand", "add_aim_down"), 1, 0);
    self _meth_82AC(scripts\anim\utility::func_B027("default_stand", "add_aim_left"), 1, 0);
    self _meth_82AC(scripts\anim\utility::func_B027("default_stand", "add_aim_up"), 1, 0);
    self _meth_82AC(scripts\anim\utility::func_B027("default_stand", "add_aim_right"), 1, 0);
    return;
  }

  if(var_1 == "over") {
    self _meth_82AC(scripts\anim\utility::func_B027("cover_stand", "add_aim_down"), 1, 0);
    self _meth_82AC(scripts\anim\utility::func_B027("cover_stand", "add_aim_left"), 1, 0);
    self _meth_82AC(scripts\anim\utility::func_B027("cover_stand", "add_aim_up"), 1, 0);
    self _meth_82AC(scripts\anim\utility::func_B027("cover_stand", "add_aim_right"), 1, 0);
    return;
  }
}

_meth_8405() {
  self notify("return_to_cover");
  self.var_3C60 = 1;
  self notify("done_changing_cover_pos");
  scripts\anim\combat_utility::func_6309();
  var_0 = func_D65C();
  self _meth_82E3("go_to_hide", scripts\anim\utility::func_1F64(self.a.var_4727 + "_2_hide"), % body, 1, 0.2, var_0);
  self clearanim( % exposed_modern, 0.2);
  scripts\anim\shared::donotetracks("go_to_hide");
  self.a.var_4727 = "hide";
  if(self.var_4757 == "stand") {
    self.a.var_10930 = "cover_stand";
  } else {
    self.a.var_10930 = "cover_crouch";
  }

  self.var_3C60 = 0;
}

func_128B0(var_0) {
  return func_128AF(var_0, 1);
}

func_128AF(var_0, var_1) {
  if(isDefined(self.dontevershoot) || isDefined(var_0.var_5951)) {
    return 0;
  }

  var_2 = undefined;
  if(isDefined(self.var_DC5C) && randomfloat(1) < self.var_DC5C) {
    var_2 = scripts\anim\utility::func_1F67("grenade_rambo");
  } else if(isDefined(var_1) && var_1) {
    var_2 = scripts\anim\utility::func_1F67("grenade_safe");
  } else {
    var_2 = scripts\anim\utility::func_1F67("grenade_exposed");
  }

  func_F6C0();
  self.sendmatchdata = 1;
  var_3 = scripts\anim\combat_utility::func_128A0(var_0, var_2);
  self.sendmatchdata = 0;
  return var_3;
}

func_2B99() {
  if(!scripts\anim\utility::func_1F65("blind_fire")) {
    return 0;
  }

  func_F6C0();
  self.sendmatchdata = 1;
  self _meth_82E4("blindfire", scripts\anim\utility::func_1F67("blind_fire"), % body, 1, 0.2, 1);
  scripts\anim\shared::donotetracks("blindfire");
  self.sendmatchdata = 0;
  return 1;
}

func_4A2B(var_0, var_1, var_2) {
  var_3 = spawnturret("misc_turret", var_0.origin, var_1);
  var_3.angles = var_0.angles;
  var_3.var_1A56 = self;
  var_3 setModel(var_2);
  var_3 makeusable();
  var_3 setdefaultdroppitch(0);
  if(isDefined(var_0.setmatchdataid)) {
    var_3.setmatchdataid = var_0.setmatchdataid;
  }

  if(isDefined(var_0.setdevdvarifuninitialized)) {
    var_3.setdevdvarifuninitialized = var_0.setdevdvarifuninitialized;
  }

  if(isDefined(var_0.var_349)) {
    var_3.var_349 = var_0.var_349;
  }

  if(isDefined(var_0.opcode::OP_ScriptLocalMethodThreadCall)) {
    var_3.opcode::OP_ScriptLocalMethodThreadCall = var_0.opcode::OP_ScriptLocalMethodThreadCall;
  }

  return var_3;
}

func_51B9(var_0) {
  self endon("death");
  self endon("being_used");
  wait(0.1);
  if(isDefined(var_0)) {
    var_0 notify("turret_use_failed");
  }

  self delete();
}

func_130DF() {
  var_0 = self.target_getindexoftarget.turret;
  if(!var_0.var_9F46) {
    return;
  }

  thread scripts\sp\mg_penetration::func_8715(var_0);
  self waittill("continue_cover_script");
}

func_F92B(var_0) {
  self.a.var_2274 = scripts\anim\utility::func_B028("cover_crouch");
  if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    if(var_0 == "lean" || var_0 == "stand") {
      self.a.var_2274["single"] = ::scripts\anim\utility::func_B027("shotgun_stand", "single");
    } else {
      self.a.var_2274["single"] = ::scripts\anim\utility::func_B027("shotgun_crouch", "single");
    }
  }

  if(isDefined(level.var_DC5B)) {
    self.a.var_2274["rambo"] = level.var_DC5B.var_4713;
    self.a.var_2274["rambo_fail"] = level.var_DC5B.var_4714;
    self.a.var_2274["grenade_rambo"] = level.var_DC5B.var_4715;
  }
}

func_FA52(var_0) {
  self.a.var_2274 = scripts\anim\utility::func_B028("cover_stand");
  if(var_0 != "over") {
    var_1 = scripts\anim\utility::func_B028("default_stand");
    self.a.var_2274["stand_aim"] = var_1["straight_level"];
    self.a.var_2274["fire"] = var_1["fire_corner"];
    self.a.var_2274["semi2"] = var_1["semi2"];
    self.a.var_2274["semi3"] = var_1["semi3"];
    self.a.var_2274["semi4"] = var_1["semi4"];
    self.a.var_2274["semi5"] = var_1["semi5"];
    if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
      self.a.var_2274["single"] = ::scripts\anim\utility::func_B027("shotgun_stand", "single");
    } else {
      self.a.var_2274["single"] = var_1["single"];
    }

    self.a.var_2274["burst2"] = var_1["burst2"];
    self.a.var_2274["burst3"] = var_1["burst3"];
    self.a.var_2274["burst4"] = var_1["burst4"];
    self.a.var_2274["burst5"] = var_1["burst5"];
    self.a.var_2274["burst6"] = var_1["burst6"];
  }

  if(isDefined(level.var_DC5B)) {
    self.a.var_2274["rambo"] = level.var_DC5B.var_474A;
    self.a.var_2274["rambo_fail"] = level.var_DC5B.var_474B;
    self.a.var_2274["grenade_rambo"] = level.var_DC5B.var_474C;
  }
}

func_B05A(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0.1;
  }

  self give_boombox(scripts\anim\utility::func_1F64("hide_idle"), % body, 1, var_0);
  self.a.var_4727 = "hide";
}

func_1E82() {
  self endon("killanimscript");
  self notify("newAngleRangeCheck");
  self endon("newAngleRangeCheck");
  self endon("return_to_cover");
  for(;;) {
    if(func_BE9D()) {
      break;
    }

    wait(0.1);
  }

  self notify("stopShooting");
}

func_BE9D() {
  if(self.var_4757 != "crouch") {
    return 0;
  }

  var_0 = _meth_811F(self getEye());
  if(self.a.var_4727 == "lean") {
    return var_0 < 10;
  }

  return var_0 > 45;
}

func_7DFA() {
  var_0 = [];
  if(self.var_4757 == "stand") {
    var_0 = self.covernode _meth_8169();
    var_0[var_0.size] = "stand";
  } else {
    var_1 = _meth_811F(self.covernode.origin + scripts\anim\utility_common::getnodeoffset(self.covernode));
    if(var_1 > 30) {
      return "lean";
    }

    if(var_1 > 15 || !self.covernode.var_4A9D) {
      return "stand";
    }

    var_0 = self.covernode _meth_8169();
    var_0[var_0.size] = "crouch";
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!isDefined(self.a.var_2274["hide_2_" + var_0[var_2]])) {
      var_0[var_2] = var_0[var_0.size - 1];
      var_0[var_0.size - 1] = undefined;
      continue;
    }
  }

  return scripts\anim\combat_utility::dospawn(var_0);
}

_meth_811F(var_0) {
  var_1 = scripts\anim\utility_common::getenemyeyepos();
  return angleclamp180(vectortoangles(var_1 - var_0)[0]);
}

func_F6C0() {
  if(scripts\engine\utility::actor_is3d()) {
    self animmode("nogravity");
    return;
  }

  self animmode("zonly_physics");
}

func_470A(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "run";
  }

  self.facialidx = scripts\anim\face::playfacialanim(var_0, var_1, self.facialidx);
}

func_4701() {
  self.facialidx = undefined;
  self clearanim( % head, 0.2);
}