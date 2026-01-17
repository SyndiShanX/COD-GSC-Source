/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\doa\_doa_pickup_area_affect.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\doa\_doa_dev;
#using scripts\cp\doa\_doa_fx;
#using scripts\cp\doa\_doa_pickups;
#using scripts\cp\doa\_doa_player_utility;
#using scripts\cp\doa\_doa_score;
#using scripts\cp\doa\_doa_sfx;
#using scripts\cp\doa\_doa_utility;
#using scripts\shared\ai\zombie_vortex;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\util_shared;
#using_animtree("zombie_cymbal_monkey");
#namespace namespace_4f1562f7;

function function_be253d27(var_53e67bd3 = 0.6) {
  self endon("death");
  while(isDefined(self)) {
    self rotateto(self.angles + vectorscale((0, 1, 0), 180), var_53e67bd3);
    wait(var_53e67bd3);
  }
}

function function_c4e6a6fb(startscale, var_870d9a2 = 1, timems = 3000) {
  self endon("death");
  curscale = startscale;
  var_aa32d9f9 = (var_870d9a2 - startscale) / (timems / 50);
  endtime = gettime() + timems;
  while(isDefined(self) && gettime() < endtime) {
    curscale = curscale + var_aa32d9f9;
    self setscale(curscale);
    wait(0.05);
  }
}

function function_ca06d008(player, origin) {
  hitp = playerphysicstrace(origin + vectorscale((0, 0, 1), 72), origin + (vectorscale((0, 0, -1), 500)));
  origin = (origin[0], origin[1], hitp[2]);
  org = spawn("script_model", origin + vectorscale((0, 0, 1), 36));
  org setModel("tag_origin");
  coat = spawn("script_model", origin + vectorscale((0, 0, 1), 36));
  if(isDefined(coat)) {
    coat setscale(3);
    coat thread function_c4e6a6fb(3, 0.1);
    coat.angles = (0, 270, 75);
    coat thread function_be253d27();
    coat.targetname = "coat_of_arms";
    coat setModel(level.doa.coat_of_arms);
    coat thread namespace_1a381543::function_90118d8c("zmb_coat_of_arms");
  }
  trigger = spawn("trigger_radius", coat.origin, 9, level.doa.rules.var_942b8706, 60);
  trigger.targetname = "teamShifterUpdate";
  trigger enablelinkto();
  trigger.opentime = 2300;
  trigger.var_96ff2cda = gettime() + trigger.opentime;
  trigger.radiussq = level.doa.rules.var_942b8706 * level.doa.rules.var_942b8706;
  playFX("zombie/fx_exp_rpg_red_doa", coat.origin);
  org thread namespace_eaa992c::function_285a2999("teamShift");
  trigger thread function_963e13a0();
  wait(2);
  if(isDefined(org)) {
    org delete();
  }
  wait(1);
  if(isDefined(trigger)) {
    trigger delete();
  }
  if(isDefined(coat)) {
    coat delete();
  }
}

function private function_963e13a0() {
  self endon("death");
  while(true) {
    self waittill("trigger", guy);
    if(isDefined(guy.var_bfd5bf9d) && guy.var_bfd5bf9d) {
      continue;
    }
    if(isDefined(guy.boss) && guy.boss) {
      continue;
    }
    if(isvehicle(guy)) {
      continue;
    }
    if(guy isragdoll()) {
      continue;
    }
    if(!(isDefined(guy.var_96437a17) && guy.var_96437a17)) {
      continue;
    }
    if(!isalive(guy) || guy.health <= 0) {
      continue;
    }
    if(isDefined(self.var_96ff2cda)) {
      time = gettime();
      if(time < self.var_96ff2cda) {
        distsq = distancesquared(guy.origin, self.origin);
        frac = distsq / self.radiussq;
        diff = time - self.birthtime;
        var_d4857947 = diff / self.opentime;
        if(frac > var_d4857947) {
          continue;
        }
      }
    }
    guy thread function_770e1327(self);
    guy thread doa_utility::function_24245456(level, "exit_taken");
  }
}

function private function_770e1327(trigger) {
  self endon("death");
  self notify("hash_770e1327");
  self endon("hash_770e1327");
  self.var_bfd5bf9d = 1;
  self thread namespace_eaa992c::function_285a2999("teamShift_contact");
  self thread namespace_eaa992c::function_285a2999("zombie_angry");
  team = self.team;
  self.team = "allies";
  self.favoriteenemy = undefined;
  self clearenemy();
  wait(level.doa.rules.var_a29b8bda);
  self.team = team;
  self thread namespace_eaa992c::turnofffx("teamShift_contact");
  self thread namespace_eaa992c::turnofffx("zombie_angry");
  self.var_bfd5bf9d = undefined;
  self clearenemy();
  self.favoriteenemy = undefined;
}

function timeshifterupdate(player, origin) {
  hitp = playerphysicstrace(origin + vectorscale((0, 0, 1), 72), origin + (vectorscale((0, 0, -1), 500)));
  origin = (origin[0], origin[1], hitp[2]);
  mark = origin + vectorscale((0, 0, 1), 28);
  clock = spawn("script_model", origin);
  clock.targetname = "clock";
  clock setModel(level.doa.var_27f4032b);
  clock thread namespace_1a381543::function_90118d8c("zmb_pwup_clock_start");
  clock playLoopSound("zmb_pwup_clock_loop", 2);
  trigger = spawn("trigger_radius", clock.origin, 9, level.doa.rules.var_942b8706, 60);
  trigger.targetname = "timeShifterUpdate";
  trigger enablelinkto();
  trigger linkto(clock);
  trigger.opentime = 3000;
  trigger.var_96ff2cda = gettime() + trigger.opentime;
  trigger.radiussq = level.doa.rules.var_942b8706 * level.doa.rules.var_942b8706;
  timetowait = player doa_utility::function_1ded48e6(level.doa.rules.var_ecfc4359);
  clock thread namespace_eaa992c::function_285a2999("timeshift");
  trigger thread function_78d20ce0();
  level util::waittill_any_timeout(player doa_utility::function_1ded48e6(level.doa.rules.var_ecfc4359), "exit_taken");
  clock thread namespace_1a381543::function_90118d8c("zmb_pwup_clock_end");
  wait(1);
  if(isDefined(clock)) {
    clock delete();
  }
  if(isDefined(trigger)) {
    trigger delete();
  }
}

function private function_78d20ce0() {
  self endon("death");
  while(true) {
    self waittill("trigger", guy);
    if(isDefined(guy.var_dd70dacd) && guy.var_dd70dacd) {
      continue;
    }
    if(isDefined(guy.boss) && guy.boss) {
      continue;
    }
    if(isvehicle(guy)) {
      continue;
    }
    if(guy isragdoll()) {
      continue;
    }
    if(!isalive(guy) || guy.health <= 0) {
      continue;
    }
    if(isDefined(self.var_96ff2cda)) {
      time = gettime();
      if(time < self.var_96ff2cda) {
        distsq = distancesquared(guy.origin, self.origin);
        frac = distsq / self.radiussq;
        diff = time - self.birthtime;
        var_d4857947 = diff / self.opentime;
        if(frac > var_d4857947) {
          continue;
        }
      }
    }
    guy thread function_59a20c67(self);
  }
}

function private function_59a20c67(trigger) {
  self endon("death");
  self notify("hash_59a20c67");
  self endon("hash_59a20c67");
  self.var_dd70dacd = 1;
  self thread namespace_eaa992c::function_285a2999("timeshift_contact");
  self asmsetanimationrate(0.5);
  while(isalive(self) && isDefined(trigger) && self istouching(trigger)) {
    wait(0.5);
  }
  self thread namespace_eaa992c::turnofffx("timeshift_contact");
  wait(0.75);
  self asmsetanimationrate((isDefined(self.doa.anim_rate) ? self.doa.anim_rate : 1));
  self.var_dd70dacd = undefined;
}

function function_d171e15a(player, origin) {
  level thread zombie_vortex::start_timed_vortex(origin, 128, 9, 10, undefined, player, undefined, undefined, undefined, undefined, 2);
}

function function_159bb1dd(player, origin) {
  hitp = playerphysicstrace(origin + vectorscale((0, 0, 1), 72), origin + (vectorscale((0, 0, -1), 500)));
  origin = (origin[0], origin[1], hitp[2]);
  mark = origin + vectorscale((0, 0, 1), 12);
  monkey = spawn("script_model", origin);
  monkey.targetname = "monkeyUpdate";
  monkey setModel(level.doa.var_d6256e83);
  monkey thread namespace_eaa992c::function_285a2999(namespace_831a4a7c::function_e7e0aa7f(player.entnum));
  def = doa_pickups::function_bac08508(11);
  monkey useanimtree($zombie_cymbal_monkey);
  monkey animscripted("anim", monkey.origin, monkey.angles, % zombie_cymbal_monkey::o_monkey_bomb);
  monkey.angles = (0, randomint(360), 0);
  monkey makesentient();
  monkey.threatbias = 0;
  doa_utility::function_5fd5c3ea(monkey);
  monkey endon("death");
  level thread function_254f3480(monkey);
  monkey thread function_2271edf2(player);
  wait(player doa_utility::function_1ded48e6(level.doa.rules.monkey_fuse_time));
  monkey notify("hash_2271edf2");
}

function function_2271edf2(player) {
  self endon("death");
  self waittill("hash_2271edf2");
  doa_utility::function_3d81b494(self);
  self thread namespace_1a381543::function_90118d8c("zmb_monkey_explo");
  self thread namespace_eaa992c::function_285a2999("monkey_explode");
  if(isDefined(player)) {
    radiusdamage(self.origin, 200, 15000, 15000, player, "MOD_EXPLOSIVE");
  } else {
    radiusdamage(self.origin, 200, 15000, 15000);
  }
  physicsexplosionsphere(self.origin, 200, 128, 2);
  earthquake(0.3, 1, self.origin, 100);
  playrumbleonposition("artillery_rumble", self.origin);
  self waittill("hash_6a404ade");
  self delete();
}

function function_254f3480(monkey) {
  monkey endon("death");
  level waittill("exit_taken", exit_trigger);
  monkey notify("hash_2271edf2");
}