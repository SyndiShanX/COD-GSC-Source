/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2440f86f9cd325ac.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_3a8e4a3;

function function_98acc465() {
  self endon(#"death");
  self physicslaunch(self.origin, (0, 0, 10));
  self.health = 500 + level.doa.var_6c58d51 * 500;

  if(self.type === 33) {
    self.health += 1250;
  }

  self thread function_b968c4a9();
  self thread function_5160690e();
  self.team = "allies";
  wait 1;
  self makesentient();
  self.threatbias = 0;
  namespace_ec06fe4a::addpoi(self);
  self.nodelete = 1;
  self waittill(#"pickup_timeout");
  wait 1;
  self namespace_e32bb68::function_3a59ec34("zmb_egg_hatch");
  self namespace_83eb6304::function_3ecfde67("egg_hatch");

  if(isDefined(self.prize)) {
    prize = self.prize;
  } else {
    prize = namespace_dfc652ee::function_2c9923d7(function_137dd3d5(self.type));
  }

  origin = namespace_ec06fe4a::function_65ee50ba(self.origin, 10) + (0, 0, 12);

  if([[prize]] - > gettype() != 13) {
    prize = namespace_dfc652ee::itemspawn(prize, origin, undefined, 1, 1);
  } else {
    prize = namespace_dfc652ee::function_b8f6a8cd(level.doa.var_9a6327ee, origin, 1, 1, randomfloatrange(1, 3));
  }

  level notify(#"hash_1ebd993fc32acc25", {
    #prize: prize, #egg: self
  });
  util::wait_network_frame();
  self.pickup = undefined;
}

function function_137dd3d5(type) {
  if(type == 33) {
    return 16;
  }

  roll = randomint(100);

  if(roll < 2) {
    return 16;
  }

  if(roll < 6) {
    return 8;
  }

  if(roll < 16) {
    return 9;
  }

  if(roll <= 40) {
    return 15;
  }

  return 13;
}

function function_22c4e231(hop) {
  if(hop) {
    self physicslaunch(self.origin, (randomintrange(-5, 5), randomintrange(-5, 5), 15));
    self namespace_e32bb68::function_3a59ec34("zmb_egg_shake");
    self.var_860a34b9 = undefined;
  }
}

function function_b968c4a9() {
  self notify("e69adfe87a2f27d");
  self endon("e69adfe87a2f27d");
  self endon(#"death");
  result = level waittill(#"hash_c1cceae4479f2e5");
  var_831e477b = vectorscale(vectornormalize(self.origin - result.origin + (0, 0, 1000)), 80);
  self physicslaunch(self.origin, var_831e477b);
  self thread function_b968c4a9();
}

function function_5160690e() {
  self endon(#"death");

  while(true) {
    closezombies = array::get_all_closest(self.origin, getaiteamarray("axis"), undefined, 4, 48);

    for(i = 0; i < closezombies.size; i++) {
      zombie = closezombies[i];

      if(is_true(zombie.var_1c8b76d3)) {
        continue;
      }

      zombie setentitytarget(self);
      dir = vectornormalize(self.origin - zombie.origin) * 30;
      self physicslaunch(self.origin, (dir[0], dir[1], dir[2] + 10));
      self.health -= 40;

      if(self.health < 0) {
        self namespace_e32bb68::function_3a59ec34("zmb_explode");
        self namespace_83eb6304::function_3ecfde67("egg_explode");
        physicsexplosionsphere(self.origin, 200, 128, 2);
        self radiusdamage(self.origin, 72, 2000, 1000);
        playrumbleonposition("grenade_rumble", self.origin);
        waitframe(1);
        self.pickup = undefined;
        return;
      }
    }

    wait 1;
    self.var_9eba8716 = getclosestpointonnavmesh(self.origin, 64, 16);
  }
}