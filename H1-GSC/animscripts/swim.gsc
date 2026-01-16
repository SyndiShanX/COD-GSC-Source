/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\swim.gsc
********************************/

moveswim() {
  self endon("movemode");
  self orientmode("face enemy or motion");

  if(animscripts\utility::isspaceai())
    self.turnrate = 0.16;
  else
    self.turnrate = 0.03;

  animscripts\utility::updateisincombattimer();

  if(animscripts\utility::isincombat(0))
    moveswim_combat();
  else
    moveswim_noncombat();
}

swim_begin() {
  self.swim = spawnstruct();
  self.swim.combatstate = "nostate";
  self.swim.movestate = "combat_stationary";
  self.swim.trackstate = "track_none";
  self.swim.statefns = [];
  self.swim.statefns["nostate"] = [::swim_null, ::swim_null];
  self.swim.statefns["noncombat"] = [::moveswim_noncombat_enter, ::moveswim_noncombat_exit];
  self.swim.statefns["combat"] = [::moveswim_combat_enter, ::moveswim_combat_exit];
  self.swim.statefns["combat_stationary"] = [::swim_null, ::swim_null];
  self.swim.statefns["combat_forward"] = [::moveswim_combat_forward_enter, ::moveswim_combat_forward_exit];
  self.swim.statefns["combat_strafe"] = [::moveswim_combat_strafe_enter, ::moveswim_combat_strafe_exit];
  self.swim.statefns["track_none"] = [::swim_null, ::swim_null];
  self.swim.statefns["track_forward"] = [::swim_track_forward_enter, ::swim_track_forward_exit];
  self.swim.statefns["track_strafe"] = [::swim_track_strafe_enter, ::swim_track_strafe_exit];
  self setanimlimited(getswimanim("aim_stand_D"));
  self setanimlimited(getswimanim("aim_stand_U"));
  self setanimlimited(getswimanim("aim_stand_L"));
  self setanimlimited(getswimanim("aim_stand_R"));
  self.custommovetransition = ::swim_movebegin;
  self.permanentcustommovetransition = 1;
  self.pathturnanimoverridefunc = ::swim_pathchange_getturnanim;
  self.pathturnanimblendtime = 0.2;
}

swim_end() {
  self.swim = undefined;

  if(animscripts\utility::isspaceai())
    self.turnrate = 0.16;
  else
    self.turnrate = 0.3;
}

swim_null() {}

swim_moveend() {
  moveswim_set("nostate");
  swim_clearleananims();

  if(isdefined(self.prevturnrate)) {
    self.turnrate = self.prevturnrate;
    self.prevturnrate = undefined;
  }
}

moveswim_noncombat() {
  if(self.swim.combatstate != "noncombat")
    moveswim_set("noncombat");

  var_0 = self.swim.move_noncombat_anim;
  var_1 = 0.4;

  if(animscripts\utility::isspaceai())
    var_1 = 0.2;

  self setflaggedanimknob("swimanim", var_0, 1, var_1, self.moveplaybackrate);
  swim_updateleananim();
  animscripts\notetracks::donotetracksfortime(0.2, "swimanim");
}

moveswim_combat() {
  if(self.swim.combatstate != "combat")
    moveswim_set("combat");

  if(isdefined(self.enemy)) {
    animscripts\run::setshootwhilemoving(1);

    if(!self.facemotion) {
      swim_dostrafe();
      return;
    } else {
      if(self.swim.movestate != "combat_forward")
        moveswim_combat_move_set("combat_forward");

      if(isdefined(self.bclearstrafeturnrate) && self.bclearstrafeturnrate && lengthsquared(self.velocity)) {
        var_0 = vectortoangles(self.velocity);

        if(abs(angleclamp180(var_0[1] - self.angles[1])) > 35) {
          self.turnrate = 0.18;

          if(animscripts\utility::isspaceai())
            self.turnrate = 0.2;
        } else {
          if(animscripts\utility::isspaceai())
            self.turnrate = 0.16;
          else
            self.turnrate = 0.03;

          self.bclearstrafeturnrate = undefined;
        }
      } else
        self.bclearstrafeturnrate = undefined;

      var_1 = getswimanim("forward_aim");
    }
  } else {
    if(self.swim.movestate != "combat_forward")
      moveswim_combat_move_set("combat_forward");

    animscripts\run::setshootwhilemoving(0);
    var_1 = getswimanim("forward_aim");
  }

  var_2 = 0.4;

  if(animscripts\utility::isspaceai())
    var_2 = 0.2;

  swim_updateleananim();
  self setflaggedanimknob("swimanim", var_1, 1, var_2, self.moveplaybackrate);
  animscripts\notetracks::donotetracksfortime(0.2, "swimanim");
}

moveswim_set(var_0) {
  if(var_0 == self.swim.combatstate) {
    return;
  }
  [[self.swim.statefns[self.swim.combatstate][1]]]();
  [[self.swim.statefns[var_0][0]]]();
  self.swim.combatstate = var_0;
}

moveswim_noncombat_enter() {
  if(self.swim.trackstate != "track_none")
    swim_track_set("track_none");

  swim_setleananims();
  thread moveswim_noncombat_twitchupdate();
}

moveswim_noncombat_exit() {
  self notify("end_MoveSwim_NonCombat_TwitchUpdate");
}

#using_animtree("generic_human");

moveswim_combat_enter() {
  self setanimknob( % combatrun, 1.0, 0.5, self.moveplaybackrate);

  if(self.swim.movestate != "combat_forward")
    moveswim_combat_move_set("combat_forward");
}

moveswim_combat_exit() {
  moveswim_combat_move_set("combat_stationary");
}

moveswim_combat_move_set(var_0) {
  if(var_0 == self.swim.movestate) {
    return;
  }
  [[self.swim.statefns[self.swim.movestate][1]]]();
  [[self.swim.statefns[var_0][0]]]();
  self.swim.movestate = var_0;
}

moveswim_combat_forward_enter() {
  if(self.swim.trackstate != "track_forward")
    swim_track_set("track_forward");

  swim_setleananims();
}

moveswim_combat_forward_exit() {}

moveswim_combat_strafe_enter() {
  self setanimknoblimited(getswimanim("strafe_B"), 1, 0.1, self.sidesteprate, 1);
  self setanimknoblimited(getswimanim("strafe_L"), 1, 0.1, self.sidesteprate, 1);
  self setanimknoblimited(getswimanim("strafe_R"), 1, 0.1, self.sidesteprate, 1);

  if(self.swim.trackstate != "track_strafe")
    swim_track_set("track_strafe");

  swim_clearleananims();

  if(animscripts\utility::isspaceai())
    self.turnrate = 0.25;
  else {
    self.turnrate = 0.18;
    self.jumping = 1;
  }
}

moveswim_combat_strafe_exit() {
  self clearanim( % combatrun_forward, 0.2);
  self clearanim( % combatrun_backward, 0.2);
  self clearanim( % combatrun_left, 0.2);
  self clearanim( % combatrun_right, 0.2);

  if(animscripts\utility::isspaceai())
    self.turnrate = 0.16;
  else {
    self.turnrate = 0.03;
    self.jumping = 0;
  }

  self.bclearstrafeturnrate = 1;
}

swim_track_set(var_0) {
  if(self.swim.trackstate == var_0) {
    return;
  }
  [[self.swim.statefns[self.swim.trackstate][1]]]();
  [[self.swim.statefns[var_0][0]]]();
  self.swim.trackstate = var_0;
}

swim_track_forward_enter() {
  self setanimlimited(getswimanim("aim_move_D"));
  self setanimlimited(getswimanim("aim_move_L"));
  self setanimlimited(getswimanim("aim_move_R"));
  self setanimlimited(getswimanim("aim_move_U"));
  thread moveswim_track_combat();
}

swim_track_forward_exit() {
  self clearanim( % aim_2, 0.2);
  self clearanim( % aim_4, 0.2);
  self clearanim( % aim_6, 0.2);
  self clearanim( % aim_8, 0.2);
}

swim_track_strafe_enter() {}

swim_track_strafe_exit() {
  self clearanim( % w_aim_4, 0.2);
  self clearanim( % w_aim_6, 0.2);
  self clearanim( % w_aim_8, 0.2);
  self clearanim( % w_aim_2, 0.2);
}

moveswim_track_combat() {
  self endon("killanimscript");
  self endon("end_face_enemy_tracking");

  if(!isdefined(self.aim_while_moving_thread)) {
    self.aim_while_moving_thread = 1;
    animscripts\combat::set_default_aim_limits();

    if(animscripts\utility::isspaceai()) {
      self.rightaimlimit = 90;
      self.leftaimlimit = -90;
    }

    animscripts\track::trackloop( % w_aim_2, % w_aim_4, % w_aim_6, % w_aim_8);
  }
}

getswimanim(var_0, var_1) {
  var_2 = animscripts\utility::lookupanim("swim", var_0);

  if(isdefined(var_1))
    return var_2[var_1];
  else
    return var_2;
}

moveswim_noncombat_twitchupdate() {
  var_0 = getswimanim("forward");
  self.swim.move_noncombat_anim = var_0;
}

swim_shoulddonodeexit() {
  if(isdefined(self.disableexits))
    return 0;

  if(!isdefined(self.pathgoalpos))
    return 0;

  var_0 = self.maxfaceenemydist;
  self.maxfaceenemydist = 128;

  if(!self shouldfacemotion()) {
    self.maxfaceenemydist = var_0;
    return 0;
  }

  self.maxfaceenemydist = var_0;
  var_1 = 10000;

  if(animscripts\utility::isspaceai())
    var_1 = 32400;

  if(distancesquared(self.origin, self.pathgoalpos) < var_1)
    return 0;

  if(self.a.movement != "stop")
    return 0;

  if(lengthsquared(self.prevanimdelta) > 1) {
    var_2 = vectortoangles(self.prevanimdelta);

    if(abs(angleclamp180(var_2[1] - self.angles[1])) < 90) {
      var_3 = vectortoangles(self.lookaheaddir);

      if(abs(angleclamp180(var_3[1] - self.angles[1])) < 90)
        return 0;
    }
  }

  return 1;
}

swim_movebegin() {
  self.a.pose = "stand";

  if(!swim_shoulddonodeexit()) {
    return;
  }
  var_0 = swim_choosestart();

  if(!isdefined(var_0)) {
    return;
  }
  var_1 = var_0.m_turnanim;
  var_2 = var_0.m_anim;
  var_3 = var_0.m_angledelta;
  var_4 = vectortoangles(self.lookaheaddir);
  var_5 = var_4 - var_3;
  var_6 = anglestoforward(var_5);
  var_7 = animscripts\exit_node::getexitnode();

  if(animscripts\utility::isspaceai() && isdefined(var_7)) {
    var_8 = swim_getapproachtype(var_7);

    if(var_8 != "exposed") {
      var_9 = getnodeforwardangles(var_7);
      var_6 = anglestoforward(var_9);
    } else
      var_6 = anglestoforward(self.angles);
  }

  self animmode("nogravity", 0);
  var_10 = randomfloatrange(0.9, 1.1);
  var_11 = 0.3;
  self orientmode("face angle 3d", self.angles);

  if(isdefined(var_1) && !animscripts\utility::isspaceai()) {
    self setflaggedanimknoballrestart("startturn", var_1, % body, 1, 0.3, var_10 * self.moveplaybackrate);
    animscripts\shared::donotetracks("startturn");
    var_11 = 0.5;
  } else if(isdefined(var_1) && animscripts\utility::isspaceai()) {
    if(isdefined(var_7))
      self orientmode("face direction", var_6);

    self.prevturnrate = 0.16;
    self.turnrate = 5.0;
    var_11 = 0.1;
    self setflaggedanimknoballrestart("startturn", var_1, % body, 1, var_11, var_10 * self.moveplaybackrate);
    animscripts\shared::donotetracks("startturn");
    var_11 = 0.5;
    self.turnrate = 0.16;
    self.prevturnrate = undefined;
    var_12 = getangledelta(var_1);
    var_7 = animscripts\exit_node::getexitnode();
    var_6 = anglestoforward(self.angles);

    if(isdefined(var_7)) {
      var_8 = swim_getapproachtype(var_7);

      if(var_8 != "exposed") {
        var_9 = getnodeforwardangles(var_7);
        var_9 = (var_9[0], var_9[1] - var_12, var_9[2]);
        var_6 = anglestoforward(var_9);
      }
    }
  }

  var_13 = var_4 - self.angles;
  var_14 = getanimlength(var_2);
  var_15 = 0.001 * abs(angleclamp180(var_13[1] - var_3[1])) / var_14;
  var_16 = 0.001 * abs(angleclamp180(var_13[0] - var_3[0])) / var_14;
  var_17 = max(var_15, var_16);

  if(var_17 < 0.01)
    var_17 = 0.01;

  if(animscripts\utility::isspaceai()) {
    var_11 = 0.05;
    self.turnrate = 0.16;
    var_17 = 5.0;
  }

  self.prevturnrate = self.turnrate;
  self.turnrate = var_17;
  self orientmode("face direction", var_6);
  self setflaggedanimknoballrestart("startmove", var_2, % body, 1, var_11, var_10 * self.moveplaybackrate);
  animscripts\shared::donotetracks("startmove");
  self.turnrate = self.prevturnrate;
  self.prevturnrate = undefined;
  self orientmode("face default");
  self animmode("none", 0);

  if(animscripts\utility::isspaceai()) {
    if(animhasnotetrack(var_2, "finish"))
      animscripts\shared::donotetracks("startmove");

    var_18 = 65536;
    var_19 = self.goalpos;

    if(isdefined(self.node))
      var_19 = self.node.origin;

    if(distance2dsquared(self.origin, var_19) > var_18)
      self notify("force_space_rotation_update", 0, 0, undefined, 1);
  }

  if(animscripts\utility::isspaceai())
    return 0.2;
  else
    return 0.4;
}

swim_setleananims() {
  self setanimlimited(getswimanim("turn_add_l"));
  self setanimlimited(getswimanim("turn_add_r"));
  self setanimlimited(getswimanim("turn_add_u"));
  self setanimlimited(getswimanim("turn_add_d"));
  self.prevleanfracyaw = 0;
  self.prevleanfracpitch = 0;
}

swim_clearleananims() {
  self clearanim( % add_turn_l, 0.2);
  self clearanim( % add_turn_r, 0.2);
  self clearanim( % add_turn_u, 0.2);
  self clearanim( % add_turn_d, 0.2);
  self.prevleanfracyaw = undefined;
  self.prevleanfracpitch = undefined;
}

swim_choosestart() {
  var_0 = animscripts\utility::isincombat();
  var_1 = animscripts\exit_node::getexitnode();
  var_2 = self.angles;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = vectortoangles(self.lookaheaddir);
  var_7 = animscripts\utility::gettruenodeangles(var_1);

  if(animscripts\utility::isspaceai() && var_7[2]) {
    if(var_7[2] != 0) {
      var_8 = anglestoforward(var_7);
      var_9 = self.goalpos;

      if(isdefined(self.node))
        var_9 = self.node.origin;

      var_10 = rotatepointaroundvector(var_8, var_9 - self.origin, var_7[2] * -1);
      var_11 = var_10 + self.origin;
      var_12 = var_11 - self.origin;
      var_12 = vectornormalize(var_12);
      var_6 = vectortoangles(var_12);
      var_5 = 1;
    }
  }

  var_13 = undefined;
  var_14 = undefined;

  if(isdefined(var_1) && isdefined(var_1.type)) {
    var_14 = swim_getapproachtype(var_1);

    if(var_14 != "exposed") {
      var_13 = "exit_" + var_14;
      var_2 = var_1.angles;

      if(animscripts\utility::isspaceai()) {
        var_2 = animscripts\utility::gettruenodeangles(var_1);

        if(var_5 == 1)
          var_2 = (var_2[0], var_2[1], 0);
      } else
        var_2 = var_1.angles;

      var_3 = 1;
    }
  }

  if(!isdefined(var_13)) {
    if(var_0)
      var_13 = "idle_ready_to_forward";
    else {
      var_13 = "idle_to_forward";
      var_4 = 1;
      var_3 = 1;
    }
  }

  var_15 = getswimanim(var_13);
  var_16 = angleclamp180(var_6[1] - var_2[1]);
  var_17 = angleclamp180(var_6[0] - var_2[0]);
  var_18 = undefined;

  if(animscripts\utility::isspaceai())
    var_18 = 3;

  var_19 = swim_getangleindex(var_16, var_18);
  var_20 = swim_getangleindex(var_17, var_18);
  var_21 = var_14;

  if(!isdefined(var_21) && isdefined(self.prevnode) && distance2dsquared(self.prevnode.origin, self.origin) < 36)
    var_21 = swim_getapproachtype(self.prevnode);

  if(var_19 == 4 && isdefined(var_21)) {
    var_22 = isdefined(var_14);

    if(var_21 == "cover_corner_l" && var_16 < -10 && (!var_22 || isdefined(var_15[2])))
      var_19 = 2;
    else if(var_21 == "cover_corner_r" && var_16 > 10 && (!var_22 || isdefined(var_15[6])))
      var_19 = 6;
  }

  if(!isdefined(var_15[var_19])) {
    var_13 = "idle_to_forward";
    var_15 = getswimanim(var_13);
    var_4 = 1;
  }

  var_23 = spawnstruct();

  if(var_4) {
    var_24 = getswimanim("idle_turn");

    if(!isdefined(var_24[var_19])) {
      var_25 = 0;

      for (var_26 = 8; !isdefined(var_15[var_25]) && var_25 < 8; var_25++) {

      }

      while (!isdefined(var_15[var_26]) && var_26 > 0)
        var_26--;

      if(var_19 < var_25)
        var_19 = var_25;
      else if(var_19 > var_26)
        var_19 = var_26;
    }

    var_23.m_turnanim = var_24[var_19];
    var_19 = 4;
  }

  if(isdefined(var_15[var_19]) && isdefined(var_15[var_19][var_20])) {
    var_23.m_anim = var_15[var_19][var_20];

    if(var_3) {
      var_15 = getswimanim(var_13 + "_angleDelta");
      var_23.m_angledelta = var_15[var_19][var_20];
    } else
      var_23.m_angledelta = (0, 0, 0);

    return var_23;
  }

  var_23 = undefined;
  return undefined;
}

swim_setupapproach() {
  self endon("killanimscript");
  self endon("swim_cancelapproach");
  thread swim_restartapproachlistener();

  if(isdefined(self.disablearrivals) && self.disablearrivals) {
    return;
  }
  self.swim.arrivalpathgoalpos = self.pathgoalpos;

  if(isdefined(self getnegotiationstartnode())) {
    return;
  }
  var_0 = animscripts\cover_arrival::getapproachent();

  if(isdefined(var_0) && swim_isapproachablenode(var_0))
    thread swim_approachnode();
  else
    thread swim_approachpos();
}

swim_restartapproachlistener() {
  self endon("killanimscript");
  self endon("swim_killrestartlistener");
  self waittill("path_set");
  var_0 = isdefined(self.pathgoalpos) && isdefined(self.swim.arrivalpathgoalpos) && distancesquared(self.pathgoalpos, self.swim.arrivalpathgoalpos) < 4;

  if(var_0) {
    thread swim_restartapproachlistener();
    return;
  }

  swim_cancelcurrentapproach();
  swim_setupapproach();
}

swim_cancelcurrentapproach() {
  self notify("swim_cancelapproach");
  self.stopanimdistsq = 0;
}

swim_waitforapproachpos(var_0, var_1) {
  self endon("swim_cancelwaitforapproachpos");
  var_2 = (var_1 + 60) * (var_1 + 60);
  var_3 = distancesquared(var_0, self.origin);

  if(var_3 <= var_2) {
    return;
  }
  self.stopanimdistsq = var_2;
  self waittill("stop_soon");
  self.stopanimdistsq = 0;
}

swim_approachpos() {
  self endon("killanimscript");
  self endon("swim_cancelapproach");
  self endon("move_interrupt");
  self endon("swim_killrestartlistener");

  if(!isdefined(self.pathgoalpos)) {
    return;
  }
  var_0 = swim_getmaxanimdist("arrival_exposed");
  swim_waitforapproachpos(self.pathgoalpos, var_0);
  swim_doposarrival();
}

swim_approachnode() {
  self endon("killanimscript");
  self endon("swim_cancelapproach");
  self endon("swim_killrestartlistener");
  var_0 = animscripts\cover_arrival::getapproachent();
  self.approachtype = swim_getapproachtype(var_0);
  self.requestarrivalnotify = 1;
  self waittill("cover_approach", var_1);
  var_0 = animscripts\cover_arrival::getapproachent();
  var_2 = swim_getapproachtype(var_0);

  if(var_2 == "exposed") {
    if(isdefined(var_0))
      var_3 = var_0.origin;
    else
      var_3 = self.pathgoalpos;

    var_4 = var_3 - self.origin;
    var_5 = vectortoangles(var_4);
    var_6 = (0, var_5[1], 0);
    var_7 = (0, var_5[1], 0);
  } else {
    var_3 = var_0.origin;
    var_6 = getnodeforwardangles(var_0);

    if(animscripts\utility::isspaceai())
      var_7 = animscripts\utility::gettruenodeangles(var_0);
    else
      var_7 = var_0.angles;
  }

  thread swim_dofinalarrival(var_2, var_3, var_1, var_7, var_6);
}

swim_doposarrival() {
  var_0 = animscripts\cover_arrival::getapproachent();
  var_1 = self.pathgoalpos;
  var_2 = (0, self.angles[1], self.angles[2]);

  if(isdefined(var_0) && var_0.type != "Path" && var_0.type != "Path 3D")
    var_2 = getnodeforwardangles(var_0);
  else if(animscripts\cover_arrival::faceenemyatendofapproach())
    var_2 = vectortoangles(self.enemy.origin - var_1);

  var_3 = vectornormalize(var_1 - self.origin);

  if(isdefined(var_0) && swim_isapproachablenode(var_0)) {
    var_4 = swim_getapproachtype(var_0);
    var_5 = getnodeforwardangles(var_0);
    var_2 = var_0.angles;

    if(animscripts\utility::isspaceai())
      var_2 = animscripts\utility::gettruenodeangles(var_0);

    thread swim_dofinalarrival(var_4, var_0.origin, var_3, var_2, var_5);
    return;
  }

  thread swim_dofinalarrival("exposed", var_1, var_3, var_2, var_2);
}

swim_determineapproachanim3d(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(animscripts\utility::isspaceai()) {
    var_6 = (0, 0, 0);
    var_7 = (0, 0, 0);
    var_8 = combineangles(invertangles(var_4), var_5);
    var_9 = rotatevectorinverted(vectornormalize(self.origin - var_2), var_4) * -1.0;
    var_10 = swim_determineapproachanim(var_0, var_1, var_6, var_9, var_7, var_8, 1, var_2, var_4);

    if(var_10)
      var_0.m_worldstartpos = rotatevector(var_0.m_worldstartpos, var_4) + var_2;

    return var_10;
  } else
    return swim_determineapproachanim(var_0, var_1, var_2, var_3, var_4, var_5, 0);
}

swim_dofinalarrival(var_0, var_1, var_2, var_3, var_4) {
  self endon("killanimscript");
  self endon("swim_cancelapproach");
  self.approachtype = var_0;
  var_5 = spawnstruct();

  if(!swim_determineapproachanim3d(var_5, var_0, var_1, var_2, var_3, var_4)) {
    return;
  }
  var_6 = anglestoforward(self.angles);
  var_7 = var_5.m_worldstartpos - self.origin;
  var_8 = length(var_7);
  var_7 = var_7 / var_8;

  if(animscripts\utility::isspaceai()) {
    var_9 = var_1 - var_5.m_worldstartpos;
    var_10 = length(var_9);
    var_11 = vectordot(var_7, var_6);

    if(var_8 > var_10 * 0.4 && vectordot(var_7, var_6) < 0.5) {
      self notify("force_space_rotation_update", 0, 0);
      return;
    }
  } else if(var_8 < 100 && vectordot(var_7, var_6) < 0.5) {
    return;
  }
  if(var_8 > 4) {
    if(var_8 < 12 || self.fixednode || !isdefined(self.node) || !animscripts\cover_arrival::isthreatenedbyenemy()) {
      self.swim.arrivalpathgoalpos = var_5.m_worldstartpos;
      self setruntopos(var_5.m_worldstartpos);

      if(animscripts\utility::isspaceai()) {
        var_12 = 16384;

        for (;;) {
          if(distancesquared(self.origin, var_5.m_worldstartpos) < var_12) {
            self.prevturnrate = self.turnrate;
            self.turnrate = 0.1;
            var_13 = calculatestartorientation(var_5.m_delta, var_5.m_angledelta, var_1, var_4);
            self notify("force_space_rotation_update", 0, 0, var_13[1]);
            break;
          }

          wait 0.1;
        }
      }

      self waittill("runto_arrived");
    }
  }

  self notify("swim_killrestartlistener");
  var_14 = vectornormalize(var_1 - self.origin);

  if(!swim_determineapproachanim3d(var_5, var_0, var_1, var_14, var_3, var_4)) {
    return;
  }
  self.swim.arrivalanim = var_5.m_anim;

  if(animscripts\utility::isspaceai())
    var_15 = self startcoverarrival(var_5.m_worldstartpos, var_4[1] - var_5.m_angledelta[1], var_4[0] - var_5.m_angledelta[0], var_4, var_5.m_angledelta);
  else
    self startcoverarrival(var_5.m_worldstartpos, var_4[1] - var_5.m_angledelta[1], var_4[0] - var_5.m_angledelta[0]);
}

swim_coverarrival_main() {
  self endon("killanimscript");
  self endon("abort_approach");
  var_0 = "arrival_" + self.approachtype;
  var_1 = self.swim.arrivalanim;

  if(!self.fixednode)
    thread animscripts\cover_arrival::abortapproachifthreatened();

  var_2 = 0.4;

  if(animscripts\utility::isspaceai()) {
    var_2 = 0.2;
    thread space_arrival_turnrate_delay();
  }

  self clearanim( % body, 0.2);
  self setflaggedanimrestart("coverArrival", var_1, 1, var_2, self.movetransitionrate);
  animscripts\shared::donotetracks("coverArrival", ::swim_handlestartcoveraim);

  if(!animhasnotetrack(var_1, "start_aim"))
    swim_startcoveraim();

  self.a.pose = "stand";
  self.a.movement = "stop";
  self.a.arrivaltype = self.approachtype;

  if(animscripts\utility::isspaceai()) {
    self.turnrate = 0.16;
    self.prevturnrate = undefined;
  }

  self clearanim( % animscript_root, 0.3);
  self.lastapproachaborttime = undefined;
  self.swim.arrivalanim = undefined;

  if(animscripts\utility::isspaceai() && self.approachtype == "exposed")
    self notify("force_space_rotation_update", 0, 0, undefined, 1);
}

space_arrival_turnrate_delay() {
  self endon("killanimscript");
  self endon("abort_approach");
  wait 0.22;
  self.prevturnrate = 0.16;
  self.turnrate = 5.0;
}

swim_getanimstartpos(var_0, var_1, var_2, var_3, var_4) {
  if(var_4) {
    var_5 = calculatestartorientation(var_2, var_3, var_0, var_1);
    return var_5[0];
  }

  var_6 = var_1 - var_3;
  var_7 = anglestoforward(var_6);
  var_8 = anglestoright(var_6);
  var_9 = anglestoup(var_6);
  var_10 = var_7 * var_2[0];
  var_11 = var_8 * var_2[1];
  var_12 = var_9 * var_2[2];
  return var_0 - var_10 + var_11 - var_12;
}

swim_maymovefrompointtopoint(var_0, var_1, var_2, var_3, var_4) {
  if(var_2) {
    var_1 = rotatevector(var_1, var_4) + var_3;
    return self maymovefrompointtopoint(var_3, var_1, 0, 1);
  }

  return self maymovefrompointtopoint(var_0, var_1, 0, 1);
}

swim_determineapproachanim(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(lengthsquared(var_3) < 0.003)
    return 0;

  var_9 = vectortoangles(var_3);

  if(var_1 == "exposed") {
    var_10 = 4;
    var_11 = 4;
  } else {
    var_12 = angleclamp180(var_4[1] - var_9[1]);
    var_10 = swim_getangleindex(var_12);
    var_11 = swim_getangleindex(var_12, 25);
  }

  var_13 = angleclamp180(var_4[0] - var_9[0]);
  var_14 = swim_getangleindex(var_13);
  var_15 = swim_getangleindex(var_13, 25);
  var_16 = "arrival_" + var_1;

  if(var_1 == "exposed" && !animscripts\utility::isincombat(0))
    var_16 = var_16 + "_noncombat";

  var_17 = getswimanim(var_16);

  if(!isdefined(var_17[var_10]) || !isdefined(var_17[var_10][var_14]))
    return 0;

  var_18 = (var_10 != var_11 || var_14 != var_15) && isdefined(var_17[var_11]) && isdefined(var_17[var_11][var_15]);
  var_19 = 0;
  var_20 = 0;
  var_21 = undefined;
  var_22 = var_17[var_10][var_14];

  if(var_18)
    var_21 = var_17[var_11][var_15];

  var_23 = var_16 + "_delta";
  var_17 = getswimanim(var_23);
  var_24 = var_17[var_10][var_14];

  if(var_18)
    var_19 = var_17[var_11][var_15];

  var_25 = var_16 + "_angleDelta";
  var_17 = getswimanim(var_25);
  var_26 = var_17[var_10][var_14];

  if(var_18)
    var_20 = var_17[var_11][var_15];

  var_27 = swim_getanimstartpos(var_2, var_5, var_24, var_26, var_6);

  if(!swim_maymovefrompointtopoint(var_2, var_27, var_6, var_7, var_8) && var_18 && !animscripts\utility::isspaceai()) {
    var_22 = var_21;
    var_24 = var_19;
    var_26 = var_20;
    var_27 = swim_getanimstartpos(var_2, var_5, var_24, var_26, var_6);

    if(!swim_maymovefrompointtopoint(var_2, var_27, var_6, var_7, var_8))
      return 0;
  }

  var_0.m_anim = var_22;
  var_0.m_delta = var_24;
  var_0.m_angledelta = var_26;
  var_0.m_worldstartpos = var_27;
  return 1;
}

swim_getangleindex(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = 10;

  if(var_0 < 0)
    return int(ceil((180 + var_0 - var_1) / 45));
  else
    return int(floor((180 + var_0 + var_1) / 45));
}

swim_getmaxanimdist(var_0) {
  var_1 = anim.archetypes["soldier"]["swim"][var_0]["maxDelta"];

  if(isdefined(self.animarchetype) && self.animarchetype != "soldier") {
    if(isdefined(anim.archetypes[self.animarchetype]["swim"]) && isdefined(anim.archetypes[self.animarchetype]["swim"][var_0])) {
      var_2 = anim.archetypes[self.animarchetype]["swim"][var_0]["maxDelta"];

      if(var_2 > var_1)
        var_1 = var_2;
    }
  }

  return var_1;
}

swim_startcoveraim() {
  animscripts\animset::set_animarray_standing();
  animscripts\combat::set_aim_and_turn_limits();
  self.previouspitchdelta = 0.0;
  animscripts\combat_utility::setupaim(0);
  thread animscripts\track::trackshootentorpos();
}

swim_handlestartcoveraim(var_0) {
  if(var_0 != "start_aim") {
    return;
  }
  swim_startcoveraim();
}

swim_getapproachtype(var_0) {
  if(!isdefined(var_0))
    return "exposed";

  var_1 = var_0.type;

  if(!isdefined(var_1))
    return "exposed";

  switch (var_1) {
    case "Cover Right 3D":
      return "cover_corner_r";
    case "Cover Left 3D":
      return "cover_corner_l";
    case "Cover Up 3D":
      return "cover_u";
    case "Path 3D":
    case "Exposed 3D":
      return "exposed";
    default:
  }
}

getnodeforwardangles(var_0) {
  if(getdvarint("player_spaceEnabled") == 1) {
    var_1 = animscripts\utility::gettruenodeangles(var_0);

    if(animscripts\utility::isnodecoverleft(var_0)) {
      var_2 = getswimanim("arrival_cover_corner_l_angleDelta");
      var_3 = var_2[4][4][1];
    } else if(animscripts\utility::isnodecoverright(var_0)) {
      var_2 = getswimanim("arrival_cover_corner_r_angleDelta");
      var_3 = var_2[4][4][1];
    } else
      var_3 = 0;

    var_1 = combineangles(var_1, (0, var_3, 0));
    return var_1;
  } else
    var_1 = var_0.angles;

  var_4 = var_1[1];

  if(animscripts\utility::isnodecoverleft(var_0)) {
    var_2 = getswimanim("arrival_cover_corner_l_angleDelta");
    var_4 = var_4 + var_2[4][4][1];
  } else if(animscripts\utility::isnodecoverright(var_0)) {
    var_2 = getswimanim("arrival_cover_corner_r_angleDelta");
    var_4 = var_4 + var_2[4][4][1];
  }

  var_1 = (var_1[0], var_4, var_1[2]);
  return var_1;
}

swim_dostrafe() {
  if(self.swim.movestate != "combat_strafe")
    moveswim_combat_move_set("combat_strafe");

  var_0 = getswimanim("forward_aim");
  self setflaggedanimknoblimited("swimanim", var_0, 1, 0.1, 1, 1);
  thread swim_updatestrafeanim();
  animscripts\notetracks::donotetracksfortime(0.2, "swimanim");
  self notify("end_swim_updatestrafeanim");
}

swim_updatestrafeanim() {
  self endon("killanimscript");
  self endon("move_interrupt");
  self endon("move_mode");
  self endon("move_loop_restart");
  self endon("end_swim_updatestrafeanim");
  var_0 = 0;

  for (;;) {
    if(self.facemotion) {
      if(!var_0) {
        swim_setstrafeweights(1.0, 0.0, 0.0, 0.0);
        swim_setstrafeaimweights(0, 0, 0, 0);
      }
    } else {
      if(self.relativedir == 1) {
        var_1 = [];
        var_1["front"] = 1;
        var_1["back"] = 0;
        var_1["left"] = 0;
        var_1["right"] = 0;
      } else
        var_1 = animscripts\utility::quadrantanimweights(self getmotionangle());

      if(isdefined(self.update_move_front_bias)) {
        var_1["back"] = 0.0;

        if(var_1["front"] < 0.2)
          var_1["front"] = 0.2;
      }

      var_2 = swim_setstrafeweights(var_1["front"], var_1["back"], var_1["left"], var_1["right"]);
      swim_setstrafeaimset(var_2);
      swim_updatestrafeaimanim();
    }

    var_0 = self.facemotion;
    wait 0.05;
    waittillframeend;
  }
}

swim_getstrafeblendtime() {
  if(animscripts\utility::isspaceai())
    return 0.5;
  else
    return 0.5;
}

swim_setstrafeweights(var_0, var_1, var_2, var_3) {
  var_4 = swim_getstrafeblendtime();
  self setanim( % combatrun_forward, var_0, var_4, 1, 1);
  self setanim( % combatrun_backward, var_1, var_4, 1, 1);
  self setanim( % combatrun_left, var_2, var_4, 1, 1);
  self setanim( % combatrun_right, var_3, var_4, 1, 1);

  if(var_0 > 0)
    return "front";
  else if(var_1 > 0)
    return "back";
  else if(var_2 > 0)
    return "left";
  else if(var_3 > 0)
    return "right";
}

swim_setstrafeaimset(var_0) {
  switch (var_0) {
    case "front":
      self setanimknoblimited(getswimanim("aim_move_U"), 1, 0.1);
      self setanimknoblimited(getswimanim("aim_move_D"), 1, 0.1);
      self setanimknoblimited(getswimanim("aim_move_L"), 1, 0.1);
      self setanimknoblimited(getswimanim("aim_move_R"), 1, 0.1);
      break;
    case "back":
      self setanimknoblimited(getswimanim("strafe_B_aim_U"), 1, 0.1);
      self setanimknoblimited(getswimanim("strafe_B_aim_D"), 1, 0.1);
      self setanimknoblimited(getswimanim("strafe_B_aim_L"), 1, 0.1);
      self setanimknoblimited(getswimanim("strafe_B_aim_R"), 1, 0.1);
      break;
    case "left":
      self setanimknoblimited(getswimanim("strafe_L_aim_U"), 1, 0.1);
      self setanimknoblimited(getswimanim("strafe_L_aim_D"), 1, 0.1);
      self setanimknoblimited(getswimanim("strafe_L_aim_L"), 1, 0.1);
      self setanimknoblimited(getswimanim("strafe_L_aim_R"), 1, 0.1);
      break;
    case "right":
      self setanimknoblimited(getswimanim("strafe_R_aim_U"), 1, 0.1);
      self setanimknoblimited(getswimanim("strafe_R_aim_D"), 1, 0.1);
      self setanimknoblimited(getswimanim("strafe_R_aim_L"), 1, 0.1);
      self setanimknoblimited(getswimanim("strafe_R_aim_R"), 1, 0.1);
      break;
    default:
  }
}

swim_updatestrafeaimanim() {
  var_0 = self.angles[1];
  var_1 = self.angles[0];
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 45;
  var_7 = 60;

  if(isdefined(self.enemy)) {
    var_8 = self.enemy.origin - self.origin;
    var_9 = vectortoangles(var_8);
    var_10 = angleclamp180(var_9[1] - var_0);
    var_11 = angleclamp180(var_9[0] - var_1);

    if(var_10 > 0)
      var_4 = clamp(1 - (var_6 - var_10) / var_6, 0, 1);
    else
      var_5 = clamp(1 - (var_6 + var_10) / var_6, 0, 1);

    if(var_11 > 0)
      var_3 = clamp(1 - (var_7 - var_11) / var_7, 0, 1);
    else
      var_2 = clamp(1 - (var_7 + var_11) / var_7, 0, 1);
  }

  swim_setstrafeaimweights(var_2, var_3, var_4, var_5);
}

swim_setstrafeaimweights(var_0, var_1, var_2, var_3) {
  self setanim( % w_aim_4, var_2, 0.2, 1, 1);
  self setanim( % w_aim_6, var_3, 0.2, 1, 1);
  self setanim( % w_aim_8, var_0, 0.2, 1, 1);
  self setanim( % w_aim_2, var_1, 0.2, 1, 1);
}

swim_pathchange_getturnanim(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = getswimanim("turn");
  var_5 = swim_getangleindex(var_0);
  var_6 = swim_getangleindex(var_1);

  if(isdefined(var_4[var_5]))
    var_2 = var_4[var_5][var_6];

  if(var_5 == 4) {
    if(var_6 > 4 && isdefined(var_4[4][var_6 + 1]))
      var_2 = var_4[4][var_6 + 1];
    else if(var_6 < 4 && var_6 > 0 && isdefined(var_4[4][var_6 - 1]))
      var_2 = var_4[4][var_6 - 1];
  }

  if(!isdefined(var_2))
    var_2 = var_4[var_5][4];

  if(isdefined(var_2)) {
    if(animscripts\move::pathchange_candoturnanim(var_2))
      return var_2;
  }

  return undefined;
}

swim_cleanupturnanim() {
  moveswim_set("nostate");
}

swim_updateleananim() {
  var_0 = clamp(self.leanamount / 20.0, -1, 1);

  if(var_0 > 0) {
    if(self.prevleanfracyaw <= 0 && var_0 < 0.075)
      var_0 = 0;

    self setanim( % add_turn_l, var_0, 0.2, 1, 1);
    self setanim( % add_turn_r, 0.0, 0.2, 1, 1);
  } else {
    if(self.prevleanfracyaw >= 0 && var_0 > -0.075)
      var_0 = 0;

    self setanim( % add_turn_l, 0, 0.2, 1, 1);
    self setanim( % add_turn_r, 0 - var_0, 0.2, 1, 1);
  }

  self.prevleanfracyaw = var_0;
  var_0 = clamp(self.pitchamount / 25.0, -1, 1);

  if(var_0 > 0) {
    if(self.prevleanfracpitch <= 0 && var_0 < 0.075)
      var_0 = 0;

    self setanim( % add_turn_d, var_0, 0.2, 1, 1);
    self setanim( % add_turn_u, 0.0, 0.2, 1, 1);
  } else {
    if(self.prevleanfracpitch >= 0 && var_0 > -0.075)
      var_0 = 0;

    self setanim( % add_turn_d, 0, 0.2, 1, 1);
    self setanim( % add_turn_u, 0 - var_0, 0.2, 1, 1);
  }

  self.prevleanfracpitch = var_0;
}

swim_isapproachablenode(var_0) {
  switch (var_0.type) {
    case "Exposed 3D":
    case "Cover Right 3D":
    case "Cover Left 3D":
    case "Cover Up 3D":
      return 1;
  }

  return 0;
}

space_getdefaultturnrate() {
  return 0.16;
}

space_getorientturnrate() {
  return 0.1;
}