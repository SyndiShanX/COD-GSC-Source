/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_jammer_shared.csc
******************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;

#namespace jammer;

init_shared() {
  if(!isDefined(level.var_578f7c6d)) {
    level.var_578f7c6d = spawnStruct();
  }

  level.var_578f7c6d.weapon = getweapon(#"gadget_jammer");

  if(!isDefined(level.var_6d8e6535)) {
    level.var_6d8e6535 = [];
  }

  registerclientfields();
}

private registerclientfields() {
  clientfield::register("scriptmover", "isJammed", 9000, 1, "int", &function_43a5b68a, 0, 0);
  clientfield::register("missile", "isJammed", 9000, 1, "int", &function_43a5b68a, 0, 0);
  clientfield::register("vehicle", "isJammed", 9000, 1, "int", &function_43a5b68a, 0, 0);
  clientfield::register("toplayer", "isJammed", 9000, 1, "int", &player_isjammed, 0, 1);
  clientfield::register("missile", "jammer_active", 9000, 1, "int", &jammeractive, 0, 0);
  clientfield::register("toplayer", "jammedvehpostfx", 9000, 1, "int", &function_4a82368f, 0, 1);
}

jammeractive(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(!isDefined(self.worldfx)) {
      self.worldfx = util::playFXOnTag(localclientnum, "weapon/fx8_hero_sig_disrupt_active", self, "tag_sensor_animate");
    }

    setfxteam(localclientnum, self.worldfx, self.team);
  }
}

function_43a5b68a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.weapon) || !isDefined(self.weapon.var_96850284)) {
    return;
  }

  self util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  if(newval == 1) {
    self.var_4dc44ba4 = playtagfxset(localclientnum, self.weapon.var_96850284, self);
    return;
  }

  if(newval == 0 && oldval == 1 && isDefined(self.var_4dc44ba4)) {
    foreach(fx in self.var_4dc44ba4) {
      stopfx(localclientnum, fx);
    }
  }
}

player_isjammed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self) || !isplayer(self)) {
    return;
  }

  self util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  if(newval == 1) {
    self notify(#"stop_sounds");
    self postfx::playpostfxbundle(#"hash_3a2aaa69f5eeab6f");
    playSound(localclientnum, #"hash_4a43757dd4b02977");
    level.var_6d8e6535[localclientnum] = function_604c9983(localclientnum, #"hash_2be3b9789976a6b");
    self thread function_e9e14905(localclientnum);
    return;
  }

  if(newval == 0) {
    self postfx::stoppostfxbundle(#"hash_3a2aaa69f5eeab6f");

    if(isDefined(level.var_6d8e6535[localclientnum]) && !bwastimejump) {
      playSound(localclientnum, #"hash_112352517abf5b11");
    }

    self notify(#"stop_sounds");
  }
}

function_e9e14905(localclientnum) {
  self waittill(#"death", #"stop_sounds");

  if(isDefined(level.var_6d8e6535[localclientnum])) {
    function_d48752e(localclientnum, level.var_6d8e6535[localclientnum]);
    level.var_6d8e6535[localclientnum] = undefined;
  }
}

function_4a82368f(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self postfx::playpostfxbundle(#"hash_68b6dee9bf4fbfbe");
    return;
  }

  if(newval == 0) {
    self postfx::stoppostfxbundle(#"hash_68b6dee9bf4fbfbe");
  }
}