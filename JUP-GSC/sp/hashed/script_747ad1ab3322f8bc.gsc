/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_747ad1ab3322f8bc.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_72f3711d95f0e465;

function function_35669831b02dc8fa(spawnorigin, targetorigin, var_44eb7c4eafc2e56e) {
  assert(isDefined(spawnorigin), "para_ac130SpawnAndFlyToDropoff: No spawnOrigin specified");
  assert(isDefined(targetorigin), "para_ac130SpawnAndFlyToDropoff: No dropOffOrigin specified");
  ac130 = spawn("script_model", spawnorigin);
  ac130 setModel("veh9_mil_air_cargo_plane_wm_dmz");
  ac130.angles = vectortoangles(targetorigin - spawnorigin);
  ac130.spawnorigin = spawnorigin;
  ac130 playLoopSound("iw8_bradley_drop_c130");
  ac130 setscriptablepartstate("lights2", "on", 0);
  ac130 setscriptablepartstate("contrails", "on", 0);

  if(!isDefined(level.ac130_paratrooper_veh)) {
    level.ac130_paratrooper_veh = [];
  }

  level.ac130_paratrooper_veh[level.ac130_paratrooper_veh.size] = ac130;
  forwarddist = ter_op(isDefined(var_44eb7c4eafc2e56e), var_44eb7c4eafc2e56e, 4500);
  droporigin = targetorigin + anglesToForward(ac130.angles) * forwarddist;
  var_5aa0d059a6ed7c56 = distance2d(spawnorigin, droporigin);
  time = var_5aa0d059a6ed7c56 / 2000;
  ac130 moveTo(droporigin, time);
  wait time;
  return ac130;
}

function function_16dfd690940ae271(exitorigin) {
  ac130 = self;
  finalloc = ac130.origin + anglesToForward(ac130.angles) * 64500;

  if(isDefined(exitorigin)) {
    var_a211bd3ffa8e8b6e = exitorigin;
    finalx = finalloc[0];
    finaly = finalloc[1];
    startx = ac130.spawnorigin[0];
    starty = ac130.spawnorigin[1];
    endx = var_a211bd3ffa8e8b6e[0];
    endy = var_a211bd3ffa8e8b6e[1];

    if(finalx > endx) {
      if(finalx > startx) {
        finalx = endx;
      }
    } else if(finalx < endx) {
      if(finalx < startx) {
        finalx = endx;
      }
    }

    if(finaly > endy) {
      if(finaly > starty) {
        finaly = endy;
      }
    } else if(finaly < endy) {
      if(finaly < starty) {
        finaly = endy;
      }
    }

    finalloc = (finalx, finaly, finalloc[2]);
  }

  var_5aa0d059a6ed7c56 = distance2d(ac130.origin, finalloc);
  time = var_5aa0d059a6ed7c56 / 2000;
  ac130 moveTo(finalloc, time);
  wait time;
  level.ac130_paratrooper_veh = array_remove(level.ac130_paratrooper_veh, ac130);
  ac130 stoploopsound();
  ac130 setscriptablepartstate("lights2", "off", 0);
  ac130 setscriptablepartstate("contrails", "off", 0);
  ac130 delete();
  println("<dev string:x1c>");
}

function create_paratrooper(falldelay, var_4f200828059689db) {
  self endon("death");
  thread watch_for_death();
  parachute_set_spawn_values();
  parachute_get_path(0, undefined);
  parachute_skydive();

  if(isDefined(self.var_48713689eb4db4b4)) {
    [[self.var_48713689eb4db4b4]]();
  }

  parachute_idle();
}

function parachute_set_spawn_values() {
  self allowedstances("stand");
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.scripted_mode = 1;
  self.playing_skit = 1;
  self.do_immediate_ragdoll = 1;
  var_d57de274b5c1d827 = 128;
  ac130 = undefined;

  if(isDefined(level.ac130_paratrooper_veh)) {
    foreach(veh in level.ac130_paratrooper_veh) {
      if(veh.spawngroup != self.enemy_group) {
        continue;
      }

      if(isDefined(self.ac130) && veh != self.ac130) {
        continue;
      }

      ac130 = veh;
    }
  }

  self asmsetstate(self.asmname, "parachute_freefall");
  self._blackboard.parachutestate = "freefall";

  if(isDefined(ac130)) {
    self.ac130 = ac130;
    var_5856c0b118701a9f = (randomfloatrange(var_d57de274b5c1d827 * -1, var_d57de274b5c1d827), randomfloatrange(var_d57de274b5c1d827 * -1, var_d57de274b5c1d827), 0);
    self setOrigin(ac130.origin + (0, 0, 50) + var_5856c0b118701a9f, 0);
  }
}

function parachute_get_path(var_c225e4dd6095fdcd, var_c201cedd606d52b3, var_7dc1df4ff378a6f4) {
  self endon("death");

  if(!isDefined(var_c225e4dd6095fdcd)) {
    var_c225e4dd6095fdcd = 100;
  }

  if(!isDefined(var_c201cedd606d52b3)) {
    var_c201cedd606d52b3 = 500;
  }

  vectornormalized = rotatepointaroundvector((0, 0, 1), (1, 0, 0), randomfloatrange(0, 359));
  startorigin = self.spawnpoint.parachute_land_origin + vectornormalized * randomfloatrange(var_c225e4dd6095fdcd, var_c201cedd606d52b3);
  landing_spot = getclosestpointonnavmesh(getgroundposition(startorigin, 64, 15000, 15000) + (0, 0, 32));
  contents = scripts\engine\trace::create_solid_ai_contents(1);
  ignoreents = [self];

  if(isDefined(self.ac130) && self.ac130 != self) {
    ignoreents[ignoreents.size] = self.ac130;
  }

  trace = scripts\engine\trace::sphere_trace(self.origin, landing_spot + (0, 0, 128), 64, ignoreents, contents);

  if(trace["fraction"] < 1) {
    landing_spot = getclosestpointonnavmesh(trace["position"]);
    trace = scripts\engine\trace::sphere_trace(self.origin, landing_spot + (0, 0, 128), 64, ignoreents, contents);

    if(trace["fraction"] < 1) {
      nodes = getnodesinradiussorted(landing_spot, 1024, 0, 2048, "Exposed");
      foundnode = 0;

      if(isDefined(nodes) && nodes.size > 0) {
        var_7898211d070bae3c = 2;

        foreach(node in nodes) {
          if(index >= var_7898211d070bae3c) {
            break;
          }

          if(!isDefined(self.var_b767444b528bf22)) {
            self.var_b767444b528bf22 = [];
          }

          if(array_contains(self.var_b767444b528bf22, node)) {
            continue;
          }

          trace = scripts\engine\trace::sphere_trace(self.origin, node.origin + (0, 0, 128), 64, ignoreents, contents);

          if(trace["fraction"] == 1) {
            landing_spot = node.origin;
            foundnode = 1;
            break;
          }

          self.var_b767444b528bf22[self.var_b767444b528bf22.size] = node;
        }
      }

      if(foundnode) {
        function_f69c1c88941df67a(landing_spot);
        return;
      } else if(var_c201cedd606d52b3 < 2000) {
        parachute_get_path(var_c201cedd606d52b3, var_c201cedd606d52b3 * 2);
      } else {
        function_f69c1c88941df67a(landing_spot);
      }
    }
  }

  function_f69c1c88941df67a(landing_spot);
}

function function_f69c1c88941df67a(landing_spot) {
  if(istrue(self.var_faeb5e8cc0f1400a)) {
    return;
  }

  self.var_b767444b528bf22 = undefined;
  self.landing_spot = landing_spot;
  self.var_faeb5e8cc0f1400a = 1;
  offset = (0, 0, 0);

  if(isDefined(self.spawnpoint.allow_momentum)) {
    fwd = vectortoangles(self.origin - self.landing_spot);
    offset = anglesToForward(fwd) * 3500;
  }

  self.skydive_dest = self.landing_spot + (0, 0, 1200) + (offset[0], offset[1], 0);
}

function parachute_skydive(falldelay) {
  self endon("death");

  if(isDefined(self.ac130)) {
    dest = self.spawnpoint.parachute_land_origin;
    dir = dest - self.origin;
    yaw = vectortoyaw(dir);
    self.angles = (self.angles[0], yaw, self.angles[2]);
    self.anchor = spawn("script_origin", self.origin);
    self.anchor.angles = (0, self.angles[1], 0);
    self linkTo(self.anchor);
    movetime = 9;
    movetime += randomfloatrange(-1, 1);
    rotatetime = 2;
    self.anchor rotateTo((0, yaw, 0), rotatetime);
    self.anchor moveTo(self.skydive_dest, movetime);
    wait movetime - 3;
    parachute_spawn();
    parachute_deploy();
    wait 2;
    return;
  }

  self.nocorpse = 1;
  self dodamage(self.health + 100, self.origin);
}

function parachute_spawn() {
  chute = spawn("script_model", self gettagorigin("j_spine4"));
  chute.angles = self gettagangles("j_spine4");
  chute setModel("misc_wm_br_parachute");
  chute linkTo(self, "j_spine4", (0, 0, 0), (0, 0, 0));
  self.chute = chute;
  chute thread unlink_on_ai_death(self);
}

function parachute_deploy() {
  self.chute scriptmodelplayanim("sdr_com_parachute_pullcord");
  self._blackboard.parachutestate = "parachuting";
  self asmsetstate(self.asmname, "parachute_deploy");
  thread delayeventfired();
}

function delayeventfired() {
  self endon("death");
  wait 2.5;
  self asmfireevent(self.asmname, "finish");
}

function parachute_idle() {
  thread parachute_move();
  thread parachute_idle_internal();
}

function parachute_idle_internal() {
  self endon("death");
  wait 1.5;
  self.chute scriptmodelplayanim("sdr_com_parachute_idle");
}

function parachute_move() {
  self endon("death");
  move_time = 6;

  if(isDefined(self.spawnpoint.allow_momentum)) {
    move_time = 9;
  }

  move_time += randomfloatrange(-1, 1);
  decel_time = 1.5;
  self.anchor moveTo(self.landing_spot, move_time, 0.1, 1.5);
  point1 = (self.origin[0], self.origin[1], 0);
  waitframe();
  point2 = (self.origin[0], self.origin[1], 0);
  self.anchor rotateTo(vectortoangles(point2 - point1), 3, 1, 1);
  wait move_time - 1.5;
  self._blackboard.parachutestate = "landing";
  self.chute scriptmodelplayanim("sdr_com_parachute_prepare_for_landing");
  wait 1;
  self.chute.parachute_landed = 1;
  wait 2.4;
  self.chute delete();
  self.chute notify("parachute_detached");
  thread do_landing();
}

function do_landing() {
  self endon("death");
  self.anchor.origin = self.landing_spot;
  self.angles = (0, self.anchor.angles[1], 0);
  self motionwarpcancel();
  self unlink();
  self.angles = (0, self.anchor.angles[1], 0);

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  self allowedstances("prone", "stand", "crouch");
  self.playing_skit = undefined;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.scripted_mode = 0;
  self.ac130 = undefined;

  if(isDefined(self.var_55ddeb59df2dee74)) {
    [[self.var_55ddeb59df2dee74]]();
  }

  if(isDefined(level.var_6d98a0934d4e3ca9)) {
    [[level.var_6d98a0934d4e3ca9]]();
  }

  self notify("delete_chute");
  wait 1;
  self.do_immediate_ragdoll = undefined;
}

function watch_for_death() {
  self endon("parachute_detached");
  self waittill("death");

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }
}

function unlink_on_ai_death(ai) {
  self endon("death");
  ai endon("parachute_detached");
  ai waittill("death");
  self unlink();

  if(!istrue(self.parachute_landed)) {
    self movez(100, 2);
    wait 2;
  }

  self delete();
}