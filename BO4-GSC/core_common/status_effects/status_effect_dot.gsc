/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\status_effects\status_effect_dot.gsc
************************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;

#namespace status_effect_dot;

autoexec __init__system__() {
  system::register(#"status_effect_dot", &__init__, undefined, undefined);
}

__init__() {
  status_effect::register_status_effect_callback_apply(7, &dot_apply);
  status_effect::function_5bae5120(7, &dot_end);
  status_effect::function_6f4eaf88(getstatuseffect("dot"));
  clientfield::register("toplayer", "dot_splatter", 1, 1, "counter");
  clientfield::register("toplayer", "dot_no_splatter", 1, 1, "counter");
  callback::on_spawned(&on_player_spawned);
}

on_player_spawned() {}

dot_apply(var_756fda07, weapon, applicant) {
  self.var_7b465aaa = var_756fda07.var_7b465aaa;
  self.var_234d0133 = var_756fda07.var_234d0133;
  self.var_48b3f3eb = var_756fda07.var_48b3f3eb;
  self.var_dc45cd85 = var_756fda07.var_5cf129b8;
  self.var_cd9ab93d = var_756fda07.var_cd9ab93d;
  self.var_73c55eee = var_756fda07.dotdamage;
  self.var_4c4e9eb3 = var_756fda07.var_44ff1a4;
  self.var_5cf129b8 = self.var_dc45cd85;
  self.var_adb1692a = self.var_73c55eee;
  self.var_848a19e0 = var_756fda07.var_848a19e0;
  self.var_200f6b2b = 1 / self.var_5cf129b8 / 1000;
  self.weapon = weapon;
  self.var_8df76e2f = var_756fda07.var_8df76e2f;
  self.var_423e3c32 = var_756fda07.var_423e3c32;
  self.var_ddf59c36 = var_756fda07.var_ddf59c36;
  self.dotrumble = var_756fda07.dotrumble;

  if(!isDefined(self.var_45c9768)) {
    self.owner.var_213b4a61 = 1;
    self.var_45c9768 = gettime();
    self.var_82e80202 = 0;

    if(self.var_8df76e2f > 0) {
      self dot_report(applicant);
    }

    self thread function_5236325e(applicant, var_756fda07.killcament);
    self thread dot_rumble_loop();
  }
}

private dot_rumble_loop() {
  self notify(#"dot_rumble_loop");
  self endon(#"dot_rumble_loop", #"endstatuseffect");
  waitframe(1);

  if(!isplayer(self.owner)) {
    return;
  }

  rumble = isDefined(self.dotrumble) ? self.dotrumble : "status_effect_dot";

  while(isDefined(self) && isDefined(self.owner)) {
    self.owner playrumbleonentity(rumble);
    wait 0.1;
  }
}

dot_end() {
  self.owner.var_213b4a61 = undefined;
  self.owner stoprumble("status_effect_dot");
  self.owner.var_4dcf932b = undefined;
  self.owner.var_e8bb749a = undefined;
  self.var_45c9768 = undefined;
}

private function_3b694684(count) {
  if(!isplayer(self.owner)) {
    return;
  }

  if(!(self.var_ddf59c36 === 1)) {
    self.owner clientfield::increment_to_player("dot_no_splatter");
  }

  if(!isDefined(self.var_423e3c32)) {
    return;
  }

  if(count % self.var_423e3c32) {
    self.owner clientfield::increment_to_player("dot_no_splatter");
    return;
  }

  self.owner clientfield::increment_to_player("dot_splatter");
}

private function_5236325e(applicant, killcament) {
  self endon(#"endstatuseffect");
  var_6307def9 = 0;
  var_f3fdc692 = 0;

  while(true) {
    self function_1d5bd9af();
    var_85ef8797 = 5;
    mod = "MOD_DOT";
    function_3b694684(var_f3fdc692);
    var_f3fdc692++;

    if(isDefined(self.owner)) {
      resistance = 0;

      if(isplayer(self.owner)) {
        resistance = self.owner status_effect::function_3c54ae98(7);
      }

      var_d6bae87d = (1 - resistance) * self.var_adb1692a;

      if(isDefined(self.var_4b22e697) && self.owner === self.var_4b22e697) {
        var_d6bae87d *= self.owner status_effect::function_37683813();
      }

      var_6307def9 += var_d6bae87d;

      if(var_6307def9 >= 1) {
        var_4ba055ed = int(floor(var_6307def9));
        location = isDefined(self.location) ? self.location : self.owner.origin;

        if(isDefined(applicant) && isDefined(applicant.var_d44d1214)) {
          location = applicant.var_d44d1214.origin;
        }

        self.owner dodamage(var_4ba055ed, location, applicant, killcament, undefined, mod, var_85ef8797, self.weapon);
        var_6307def9 -= var_4ba055ed;
      }
    }

    wait self.var_5cf129b8 / 1000;
    self function_ae0405e2(applicant);
  }
}

private function_ae0405e2(applicant) {
  if(self.var_82e80202 == self.var_8df76e2f) {
    self.var_82e80202 = 0;
    self dot_report(applicant);
    return;
  }

  self.var_82e80202++;

  if(isDefined(self.owner)) {
    self.owner.var_dbffaa32 = undefined;
  }

  if(isDefined(applicant) && (!isDefined(self.owner) || self.owner != applicant)) {
    applicant.var_dbffaa32 = undefined;

    if(isDefined(applicant.owner) && isplayer(applicant.owner)) {
      applicant.owner.var_dbffaa32 = undefined;
    }
  }
}

private dot_report(applicant) {
  if(!isDefined(self.owner)) {
    return;
  }

  if(!isDefined(applicant)) {
    return;
  }

  self.owner.var_dbffaa32 = 1;

  if(isplayer(applicant)) {
    applicant.var_dbffaa32 = 1;
  } else if(isDefined(applicant.owner) && isplayer(applicant.owner)) {
    applicant.owner.var_dbffaa32 = 1;
  }

  location = isDefined(self.location) ? self.location : self.owner.origin;

  if(isDefined(applicant.var_d44d1214)) {
    location = applicant.var_d44d1214.origin;
  }

  dir = self.owner.origin - location;

  if(isplayer(self.owner) && !self.owner getinvulnerability()) {
    self.owner addtodamageindicator(self.var_adb1692a, dir);
  }
}

private function_1d5bd9af() {
  if(!self.var_7b465aaa) {
    return;
  }

  var_9002d607 = gettime() - (isDefined(self.var_45c9768) ? self.var_45c9768 : 0) + (isDefined(self.var_48b3f3eb) ? self.var_48b3f3eb : 0);

  if(var_9002d607 < 0) {
    return;
  }

  lerpval = var_9002d607 / self.var_234d0133;
  self.var_5cf129b8 = lerpfloat(self.var_dc45cd85, self.var_cd9ab93d, lerpval);
  self.var_adb1692a = int(lerpfloat(self.var_73c55eee, self.var_4c4e9eb3, lerpval));
}