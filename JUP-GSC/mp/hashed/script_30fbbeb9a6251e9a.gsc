/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_30fbbeb9a6251e9a.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_6d2e67e0b5564054;

function function_c789cc0bd60384c2(start_pos, end_pos, open_height, var_ce8be7b4cdc21296, skydive_time, var_8330be2d492dad2) {
  self endon("death");
  thread function_377a053e8962309();
  function_dcd66ae47dd9c9fa(start_pos, end_pos, open_height, var_ce8be7b4cdc21296);
  agentparachuteskydive(skydive_time);
  function_45348b6cef309ef2();
  function_aa703fb26bb4f9fe(var_8330be2d492dad2);
  function_fb904ef821445698();
}

function function_dcd66ae47dd9c9fa(start_pos, end_pos, open_height, var_ce8be7b4cdc21296) {
  self allowedstances("stand");
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.scripted_mode = 1;
  self.playing_skit = 1;
  self.do_immediate_ragdoll = 1;
  self function_9f82c74eb1b7caf9(0);
  var_21e35e707d4d8613 = default_to(var_ce8be7b4cdc21296, 50);
  opendist = default_to(open_height, 1000);
  self asmsetstate(self.asmname, "parachute_freefall");
  self._blackboard.parachutestate = "freefall";
  self setOrigin(start_pos, 0);

  if(var_21e35e707d4d8613 == 0) {
    self.landing_spot = end_pos;
  } else {
    startorigin = end_pos + (randomfloatrange(var_21e35e707d4d8613 * -1, var_21e35e707d4d8613), randomfloatrange(var_21e35e707d4d8613 * -1, var_21e35e707d4d8613), 0);
    self.landing_spot = getclosestpointonnavmesh(getgroundposition(startorigin, 64, 15000, 15000));
  }

  dest = self.landing_spot;
  dir = dest - self.origin;
  dir = vectorNormalize(dir);
  opendist += randomfloatrange(-200, 200);
  self.skydive_dest = self.landing_spot - dir * opendist;
}

function agentparachuteskydive(skydive_time) {
  self endon("death");
  dest = self.landing_spot;
  dir = dest - self.origin;
  yaw = vectortoyaw(dir);
  self setplayerangles((self.angles[0], yaw, self.angles[2]));
  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = (0, self.angles[1], 0);
  self linkTo(self.anchor);
  rotatetime = 2;
  dist = distance(self.origin, self.skydive_dest);
  movetime = dist / 1000;
  self.anchor rotateTo((0, yaw, 0), rotatetime);
  self.anchor moveTo(self.skydive_dest, movetime);
  waittime = movetime;
  waittime -= 2;
  waittime = clamp(waittime, 0, movetime);
  wait waittime;
}

function function_45348b6cef309ef2() {
  chute = spawn("script_model", self gettagorigin("j_spine4"));
  chute.angles = self gettagangles("j_spine4");
  chute setModel("misc_wm_br_parachute");
  chute linkTo(self, "j_spine4", (0, 0, 0), (0, 0, 0));
  self.chute = chute;
  self.chute thread function_a0c4f5545fcc37e4(self);
  self.chute scriptmodelplayanim("sdr_com_parachute_pullcord");
  self playSound("exgm_parachute_open_npc");
  self playLoopSound("exgm_parachute_falling_npc");
  self._blackboard.parachutestate = "parachuting";
  self asmsetstate(self.asmname, "parachute_deploy");
  self endon("death");
  wait 1.7;
  self asmfireevent(self.asmname, "finish");
}

function function_aa703fb26bb4f9fe(var_8330be2d492dad2) {
  self endon("death");
  move_time = default_to(var_8330be2d492dad2, 5);
  move_time += randomfloatrange(-1, 1);
  decel_time = int(min(3, move_time * 0.5));
  accel_time = int(max(1, move_time - decel_time - 1));
  self.anchor moveTo(self.landing_spot, move_time, 0, decel_time);
  wait move_time - 1.5;
  self notify("parachute_prepare_to_land");
  self._blackboard.parachutestate = "landing";
  self.chute scriptmodelplayanim("sdr_com_parachute_prepare_for_landing");
  self playSound("exgm_parachute_detach_npc");
  thread function_775ca9e4c54166aa();
  wait 3;
  self.chute delete();
  self notify("parachute_detached");
}

function function_775ca9e4c54166aa() {
  wait 0.5;
  self stoploopsound("exgm_parachute_falling_npc");
}

function function_316b7ce518c834d3() {
  self endon("death");
  wait 1.5;
  self.chute scriptmodelplayanim("sdr_com_parachute_idle");
}

function function_fb904ef821445698() {
  self endon("death");
  self.anchor.origin = self.landing_spot;
  self setplayerangles((0, self.anchor.angles[1], 0));
  self unlink();
  self setplayerangles((0, self.anchor.angles[1], 0));

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  self allowedstances("prone", "stand", "crouch");
  self.playing_skit = undefined;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.scripted_mode = 0;
  self.combatmode = "cover";
  self.script_combatmode = "cover";
  self function_9f82c74eb1b7caf9(1);
  self notify("delete_chute");
  wait 1;
  self.do_immediate_ragdoll = undefined;
}

function function_377a053e8962309() {
  self endon("parachute_detached");
  self waittill("death");

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }
}

function function_a0c4f5545fcc37e4(ai) {
  self endon("death");
  ai endon("parachute_detached");
  ai waittill("death");
  self unlink();
  self movez(100, 2);
  wait 2;
  self delete();
}