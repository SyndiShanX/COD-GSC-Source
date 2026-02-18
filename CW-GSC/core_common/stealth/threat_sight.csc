/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\stealth\threat_sight.csc
************************************************/

#using script_1ff59bb2b15dfb4d;
#using scripts\core_common\class_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace threat_sight;

function scalevolume(ent, vol) {}

#namespace stealth_threat_sight;

function private autoexec __init__system__() {
  system::register(#"stealth_threat_sight", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  register_clientfields();
  level.stealth_threat_sight = new class_d0a0a887();
  [[level.stealth_threat_sight]] - > init(8);

  function_5ac4dc99("<dev string:x38>", 0);
}

function private register_clientfields() {
  clientfield::register("actor", "threat_sight", 1, 6, "int", &function_5010aab6, 0, 0);
  clientfield::register("actor", "threat_state", 1, 2, "int", &function_5010aab6, 0, 0);
}

function private function_ac3d4bc() {
  return float(self.threat_sight.var_97c4563c) + self.threat_sight.sight;
}

function private function_8991ddb4(localclientnum) {
  assert(!isDefined(self.threat_sight.elem));
  self.threat_sight.var_1911547e = [[level.stealth_threat_sight]] - > function_65cdd2df(self);

  if(!isDefined(self.threat_sight.var_1911547e)) {
    myscore = self function_ac3d4bc();
    lowest = undefined;
    var_5b9574e0 = undefined;

    foreach(guy in [[level.stealth_threat_sight]] - > function_85a5add5()) {
      assert(isDefined(guy.threat_sight));
      score = guy function_ac3d4bc();

      if(!isDefined(lowest) || score < lowest) {
        assert(guy !== self);
        lowest = score;
        var_5b9574e0 = guy;
      }
    }

    if(isDefined(lowest) && lowest < myscore) {
      var_5b9574e0 function_a2d377b5(localclientnum);
      self.threat_sight.var_1911547e = [[level.stealth_threat_sight]] - > function_65cdd2df(self);
    }
  }

  if(isDefined(self.threat_sight.var_1911547e)) {
    self.threat_sight.elem = stealth_meter_display::register_clientside();

    if(!self.threat_sight.elem stealth_meter_display::is_open(localclientnum)) {
      self.threat_sight.elem stealth_meter_display::open(localclientnum);
    }

    if(!isDefined(self.threat_sight.var_b4185011) && self hasdobj(localclientnum) && self haspart(localclientnum, "j_head")) {
      self.threat_sight.var_b4185011 = spawn(localclientnum, self gettagorigin("j_head"), "script_origin");
      self.threat_sight.var_b4185011 linkto(self, "j_head");
    }

    entnum = self getentitynumber();

    if(isDefined(self.threat_sight.var_b4185011)) {
      entnum = self.threat_sight.var_b4185011 getentitynumber();
    }

    self.threat_sight.elem stealth_meter_display::set_entnum(localclientnum, entnum);
  }

  return self.threat_sight.elem;
}

function private function_5010aab6(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  sight = float(self clientfield::get("threat_sight")) / float((1 << 6) - 1);

  if(!isDefined(self.threat_sight)) {
    self.threat_sight = spawnStruct();
  }

  now = self getclienttime();

  if((isDefined(self.threat_sight.time) ? self.threat_sight.time : -1) == now) {
    return;
  }

  self.threat_sight.time = now;
  self.threat_sight.sight = sight;
  self.threat_sight.var_97c4563c = self clientfield::get("threat_state");

  if(!isDefined(self.threat_sight.elem)) {
    if(!getdvarint(#"hash_7bf40e4b6a830d11", 1)) {
      return;
    }

    self.threat_sight.elem = self function_8991ddb4(wasdemojump);

    if(isDefined(self.threat_sight.elem)) {
      self thread function_d4ae86f5(wasdemojump);
    }
  }

  if(isDefined(self.threat_sight.elem)) {
    var_fdd79624 = "<dev string:x53>";

    if(!getdvarint(#"hash_7bf40e4b6a830d11", 1)) {
      var_fdd79624 = "<dev string:x57>";
    }

    self thread function_ccfdbd44(wasdemojump, "<dev string:x53>" + self.threat_sight.var_1911547e + "<dev string:x66>" + self.threat_sight.var_97c4563c + "<dev string:x6c>" + self.threat_sight.sight + "<dev string:x71>" + var_fdd79624);

    if(!self.threat_sight.elem stealth_meter_display::is_open(wasdemojump)) {
      self.threat_sight.elem stealth_meter_display::open(wasdemojump);
      entnum = self getentitynumber();

      if(isDefined(self.threat_sight.var_b4185011)) {
        entnum = self.threat_sight.var_b4185011 getentitynumber();
      }

      self.threat_sight.elem stealth_meter_display::set_entnum(wasdemojump, entnum);
    }

    if(getdvarint(#"hash_7bf40e4b6a830d11", 1)) {
      self.threat_sight.elem stealth_meter_display::function_4d628707(wasdemojump, self.threat_sight.var_97c4563c);
      self.threat_sight.elem stealth_meter_display::function_7425637b(wasdemojump, self.threat_sight.sight);
      self.threat_sight.elem stealth_meter_display::function_fae2a569(wasdemojump, 1);
      return;
    }

    self.threat_sight.elem stealth_meter_display::function_4d628707(wasdemojump, 0);
    self.threat_sight.elem stealth_meter_display::function_7425637b(wasdemojump, 0);
    self.threat_sight.elem stealth_meter_display::function_fae2a569(wasdemojump, 0);
  }
}

function private function_ccfdbd44(localclientnum, msg) {
  self notify("<dev string:x76>");
  self endon("<dev string:x76>");
  self endon(#"death");

  while(getdvarint(#"hash_40034352c4930dca") && isDefined(self.threat_sight)) {
    print3d(self.origin + (0, 0, 40), msg, (1, 1, 1), 1, 0.75, 1, 0);
    waitframe(1);
  }
}

function private function_d4ae86f5(localclientnum) {
  self notify(#"hash_433e3a44df358be9");
  self endon(#"hash_433e3a44df358be9");
  self waittill(#"death", #"entitydeleted");
  self thread function_a2d377b5(localclientnum);
}

function private function_a2d377b5(localclientnum) {
  if(isDefined(self.threat_sight.var_1911547e)) {
    [[level.stealth_threat_sight]] - > function_271aec18(self.threat_sight.var_1911547e);

    if(self.threat_sight.elem stealth_meter_display::is_open(localclientnum)) {
      self.threat_sight.elem stealth_meter_display::close(localclientnum);
    }

    if(isDefined(self.threat_sight.var_b4185011)) {
      self.threat_sight.var_b4185011 delete();
    }

    self.threat_sight = undefined;
  }

  self notify(#"hash_433e3a44df358be9");
}