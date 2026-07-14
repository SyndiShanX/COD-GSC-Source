/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_2e61bcf54eaedd23.gsc
*****************************************************/

#namespace namespace_cd46d422f152c4f5;

function function_a8996b6bad9cbfb7(start_pos, end_pos, open_height, land_variance, skydive_time, glide_time) {
  self endon("\x1e\xfd\xd1\xa2\a");
  thread function_f6fa0d40c1c025e8();
  function_f8b5ef993920a8a3(start_pos, end_pos, open_height, land_variance);
  agentparachuteskydive(skydive_time);
  function_1a4f065f8b439807();
  function_739cbf1f6ce9113f(glide_time);
  function_67ccc4216fe27939();
}

function function_f8b5ef993920a8a3(start_pos, end_pos, open_height, land_variance) {
  self allowedstances("\x8b\x90\xb5\xc4W");
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.scripted_mode = 1;
  self.playing_skit = 1;
  self.do_immediate_ragdoll = 1;
  self setcanusecover(0);
  landvariance = land_variance ?? 50;
  opendist = open_height ?? 1000;
  self asmsetstate(self.asmname, "xf\xf6\xec\xa8\xaf+\a\xd5Y\xb4\x91g}Wr\xb7\x0e");
  self._blackboard.parachutestate = "\xa3(\x05[\x99Y\"3";
  self[[level.var_c86c001407ea856d]](start_pos, self.angles, 1);

  if(landvariance == 0) {
    self.landing_spot = end_pos;
  } else {
    startorigin = end_pos + (randomfloatrange(landvariance * -1, landvariance), randomfloatrange(landvariance * -1, landvariance), 0);
    self.landing_spot = getclosestpointonnavmesh(getgroundposition(startorigin, 64, 15000, 15000));
  }

  dest = self.landing_spot;
  dir = dest - self.origin;
  dir = vectorNormalize(dir);
  opendist += randomfloatrange(-200, 200);
  self.skydive_dest = self.landing_spot - dir * opendist;
}

function agentparachuteskydive(skydive_time) {
  self endon("\x1e\xfd\xd1\xa2\a");
  dest = self.landing_spot;
  dir = dest - self.origin;
  yaw = vectortoyaw(dir);
  self[[level.var_c86c001407ea856d]](self.origin, (self.angles[0], yaw, self.angles[2]), 0);
  self.anchor = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", self.origin);
  self.anchor.targetname = "A\xb7\x16\xfb\xde\x9c\xc8&\xba\x10\xc1r\x97\x8a\xd9\xd1%X\x18\x1e\xc6";
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

function function_1a4f065f8b439807() {
  chute = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", self gettagorigin("\x13'$\xc4\xf8l\x16\xdf"));
  chute.angles = self gettagangles("\x13'$\xc4\xf8l\x16\xdf");
  chute setModel("\xbd\x91~\xbff[p\x92X\xe3\xc7\x91hC\x9d\xe1\x8e\x84\x96z");
  chute linkTo(self, "\x13'$\xc4\xf8l\x16\xdf", (0, 0, 0), (0, 0, 0));
  self.chute = chute;
  self.chute thread function_5e9236419878b0d5(self);
  self.chute[[level.var_845574670b5617b7]]("\xc4\xf58k\xbe\xc3\xefd\xf6\xbf\xf5\xcc=\xb6\xdd\xa2\x81G\xa5\xd8/\xfed\x90,{");
  self._blackboard.parachutestate = "\xf6\xc5\x148\x9d\x04\xaf\xcb\x966\xd6";
  self asmsetstate(self.asmname, "=\xd4$\x0f\xaa\xd8\xb5\x8f\a\xe4\xa8\x94\x88\xdb\x98\r");
  self endon("\x1e\xfd\xd1\xa2\a");
  wait 1.7;
  self asmfireevent(self.asmname, "\xd7\xca\xae\xca\xff\xdb");
}

function function_739cbf1f6ce9113f(glide_time) {
  self endon("\x1e\xfd\xd1\xa2\a");
  move_time = glide_time ?? 5;
  move_time += randomfloatrange(-1, 1);
  decel_time = int(min(3, move_time * 0.5));
  accel_time = int(max(1, move_time - decel_time - 1));
  self.anchor moveTo(self.landing_spot, move_time, 0, decel_time);
  wait move_time - 1.5;
  self notify("\xff\x10\x94c<\xda\x1fvB\x88\t\x85}=\r}7B\xf3\x98\x9ebJ Y");
  self._blackboard.parachutestate = "b6v*\xcd\b3";
  self.chute[[level.var_845574670b5617b7]]("5i\xa6\xb3\x9d\xf9\x06\x1f\xf7\x8fhh\xf5\x19C\xcd\xbf\x05\xde\xea\\;\x14\xb2\x8a\x90C\xf5\xd0C^*\xf3\xbb\x1c\xc4}");
  thread function_84869de51e86a4af();
  wait 3;
  self.chute delete();
  self notify("\xfd7&\xc7'\x9f\xee\x05C>\xe2\xd3\xba\xdbF\xed\xf6\xa0");
}

function function_84869de51e86a4af() {
  wait 0.5;
  self stoploopsound("\xbe\xd9>\xb6\xe9\xd8\x80_}\x14`z&u0\xcf\xadSKI\xd6\x80\xe7\x1d\xe7\n");
}

function function_cb84fead932ad1c2() {
  self endon("\x1e\xfd\xd1\xa2\a");
  wait 1.5;
  self.chute[[level.var_845574670b5617b7]]("sF9\xfa\xd8\xb7k\xaf\a\x16'X\x8d\xd0\xba\xe8+\xeb\xb4\x91\x8d\xb2");
}

function function_67ccc4216fe27939() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self.anchor.origin = self.landing_spot;
  self[[level.var_c86c001407ea856d]](self.origin, (0, self.anchor.angles[1], 0), 0);
  self unlink();
  self[[level.var_c86c001407ea856d]](self.origin, (0, self.anchor.angles[1], 0), 0);

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  self allowedstances("GX\xa9]\x82", "\x8b\x90\xb5\xc4W", "1x\xc5\xb4\xabx");
  self.playing_skit = undefined;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.scripted_mode = 0;
  self.combatmode = ":\xc9\x93\xe1?";
  self.script_combatmode = ":\xc9\x93\xe1?";
  self setcanusecover(1);
  self notify("\x8b\xd3!Bd \xee&\xecC@\xbd");
  wait 1;
  self.do_immediate_ragdoll = undefined;
}

function function_f6fa0d40c1c025e8() {
  self endon("\xfd7&\xc7'\x9f\xee\x05C>\xe2\xd3\xba\xdbF\xed\xf6\xa0");
  self waittill("\x1e\xfd\xd1\xa2\a");

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }
}

function function_5e9236419878b0d5(ai) {
  self endon("\x1e\xfd\xd1\xa2\a");
  ai endon("\xfd7&\xc7'\x9f\xee\x05C>\xe2\xd3\xba\xdbF\xed\xf6\xa0");
  ai waittill("\x1e\xfd\xd1\xa2\a");
  self unlink();
  self movez(100, 2);
  wait 2;
  self delete();
}