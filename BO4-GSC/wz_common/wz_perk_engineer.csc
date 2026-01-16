/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_perk_engineer.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\renderoverridebundle;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\weapons\weaponobjects;

#namespace wz_perk_engineer;

autoexec __init__system__() {
  system::register(#"wz_perk_engineer", &__init__, undefined, undefined);
}

__init__() {
  renderoverridebundle::function_f72f089c(#"hash_f5de00feee70c13", sessionmodeiscampaigngame() ? #"rob_sonar_set_friendlyequip_cp" : #"rob_sonar_set_friendlyequip_mp", &function_8550d243);
  renderoverridebundle::function_f72f089c(#"hash_77f7418d2f2a7890", #"rob_sonar_set_enemyequip", &function_62888a11);
  renderoverridebundle::function_f72f089c(#"hash_61c696df3d5a1765", #"hash_44adc567f9f60d61", &function_b52a94e5);
  callback::on_localplayer_spawned(&on_localplayer_spawned);
}

private on_localplayer_spawned(localclientnum) {
  if(self function_21c0fa55()) {
    self thread function_7800b9c2(localclientnum);
  }
}

function_e446e567(notifyhash) {
  if(!isDefined(self.var_100abb43) || !isarray(self.var_100abb43)) {
    return;
  }

  foreach(item in self.var_100abb43) {
    if(isDefined(item)) {
      item.var_f19b4afd = undefined;
    }
  }
}

private function_7800b9c2(localclientnum) {
  level endon(#"game_ended");
  self endoncallback(&function_e446e567, #"death");

  if(!isDefined(self.var_100abb43)) {
    self.var_100abb43 = [];
  }

  while(true) {
    var_94c264dd = self hasperk(localclientnum, #"specialty_showenemyequipment");

    if(!var_94c264dd && isDefined(self.var_53204996)) {
      var_94c264dd |= self[[self.var_53204996]](localclientnum);
    }

    if(!var_94c264dd && self.var_100abb43.size == 0) {
      wait 0.2;
      continue;
    }

    var_5ef114b0 = [];

    if(var_94c264dd) {
      var_7c16c290 = array::filter(level.enemyequip, 0, &function_5118c0a3);
      items = arraycombine(level.allvehicles, var_7c16c290, 0, 0);
      arrayremovevalue(items, undefined, 0);
      var_5ef114b0 = arraysortclosest(items, self.origin, 5, 0, 7200);
    }

    foreach(item in self.var_100abb43) {
      if(isDefined(item)) {
        item.var_f19b4afd = undefined;
      }
    }

    foreach(item in var_5ef114b0) {
      item.var_f19b4afd = 1;
    }

    var_2e2e2808 = arraycombine(self.var_100abb43, var_5ef114b0, 0, 0);

    foreach(item in var_2e2e2808) {
      if(isDefined(item)) {
        if(isDefined(item.vehicletype)) {
          item function_c34cebb1(localclientnum);
        } else {
          item weaponobjects::updateenemyequipment(localclientnum, undefined);
        }
      }

      waitframe(1);
    }

    self.var_100abb43 = var_5ef114b0;
    wait 0.2;
  }
}

private function_5118c0a3(item) {
  return isDefined(item) && !item function_ca024039();
}

private function_c34cebb1(localclientnum) {
  self renderoverridebundle::function_c8d97b8e(localclientnum, #"friendly", #"hash_f5de00feee70c13");
  self renderoverridebundle::function_c8d97b8e(localclientnum, #"enemy", #"hash_77f7418d2f2a7890");
  self renderoverridebundle::function_c8d97b8e(localclientnum, #"neutral", #"hash_61c696df3d5a1765");
}

private function_76a0624a() {
  if(!isDefined(self.owner) || !isDefined(self.owner.team)) {
    return 0;
  }

  if(self.owner.team == #"neutral") {
    return 0;
  }

  return self.owner function_83973173();
}

private function_da8108ae() {
  if(!isDefined(self.owner) || !isDefined(self.owner.team)) {
    return false;
  }

  if(self.owner.team == #"neutral") {
    return false;
  }

  return !self.owner function_83973173();
}

private function_8550d243(localclientnum, bundle) {
  if(function_9d295a8c(localclientnum)) {
    return false;
  }

  if(self.type === "vehicle" && isinvehicle(localclientnum, self)) {
    return false;
  }

  if(self.type === "vehicle_corpse") {
    return false;
  }

  if(self function_76a0624a() && isDefined(self.var_f19b4afd) && self.var_f19b4afd) {
    return true;
  }

  return false;
}

private function_62888a11(localclientnum, bundle) {
  if(function_9d295a8c(localclientnum)) {
    return false;
  }

  if(self.type === "vehicle" && isinvehicle(localclientnum, self)) {
    return false;
  }

  if(self.type === "vehicle_corpse") {
    return false;
  }

  if(self function_da8108ae() && isDefined(self.var_f19b4afd) && self.var_f19b4afd) {
    return true;
  }

  return false;
}

private function_b52a94e5(localclientnum, bundle) {
  if(function_9d295a8c(localclientnum)) {
    return false;
  }

  if(self.type === "vehicle" && isinvehicle(localclientnum, self)) {
    return false;
  }

  if(self.type === "vehicle_corpse") {
    return false;
  }

  if(!self function_76a0624a() && !self function_da8108ae() && isDefined(self.var_f19b4afd) && self.var_f19b4afd) {
    return true;
  }

  return false;
}