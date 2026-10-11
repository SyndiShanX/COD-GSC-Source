/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\equipment\geiger_counter.gsc
*********************************************************/

#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#namespace geiger_counter;

function function_58bf160252f94e21() {
  if(isDefined(level.var_216a5e72460de468)) {
    return;
  }

  level.var_216a5e72460de468 = 1;
  level.var_bcb3e1f6f7cd3cb7 = spawnStruct();
  level.var_bcb3e1f6f7cd3cb7.partition = create_partition([], 4000);
  level.var_bcb3e1f6f7cd3cb7.radiationmaxdist = getdvarint(@ "hash_e4a881a4b29b1041", 1000);
  level.var_bcb3e1f6f7cd3cb7.radiationradius = getdvarint(@ "hash_37124040df88eccb", 4000);
}

function function_60cba38635fd35cb(equipmentref, equipmentslot, variantid) {
  if(equipmentref != "equip_geigercounter" && equipmentref != "equip_rfid") {
    return;
  }

  function_58bf160252f94e21();
  var_14edd9c1de4aaf82 = ter_op(equipmentref == "equip_rfid", 1, 0);
  self setclientomnvar("ui_geigercounter_type", var_14edd9c1de4aaf82);
  self notifyonplayercommand("pullout_gc", "+smoke");
  self notify("geigercounter_take");
  thread geigercounter_watchfordevicepullout();
  function_c8b79f6694c62ee8(-1);
}

function function_bdd02627bcafe359(equipmentref, equipmentslot) {
  if(equipmentref != "equip_geigercounter" && equipmentref != "equip_rfid") {
    return;
  }

  self notifyonplayercommandremove("pullout_gc", "+smoke");
  self notify("geigercounter_take");
  function_c8b79f6694c62ee8(-1);
}

function function_3d5c1674387c936e(grenade) {
  waitframe();

  if(isDefined(grenade)) {
    grenade delete();
  }

  self notify("geigercounter_putaway");
  function_ce0fef2f2c7f1717();
}

function geigercounter_watchfordevicepullout() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("geigercounter_watchForDevicePullout");
  self endon("geigercounter_watchForDevicePullout");
  raceresult = spawnStruct();
  childthread function_9b3c029182bf2647(raceresult);
  childthread function_f668eed31b686b60(raceresult);

  while(true) {
    death = istrue(raceresult.death);
    take = istrue(raceresult.take);
    pulledout = istrue(raceresult.pulledout);

    if(death || take) {
      self notify("geigercounter_watchRaceEnd");
      return;
    }

    if(istrue(self.inlaststand)) {
      waitframe();
      continue;
    }

    if(!isDefined(self.var_bcb3e1f6f7cd3cb7)) {
      self.var_bcb3e1f6f7cd3cb7 = spawnStruct();
    }

    outofrange = 1;
    self.var_bcb3e1f6f7cd3cb7.var_e91c9347e638750d = function_eff6d6db587f143d();

    if(isDefined(self.var_bcb3e1f6f7cd3cb7.var_e91c9347e638750d)) {
      var_1e331291fa3bd60 = function_296cad0fb60ab083(self.var_bcb3e1f6f7cd3cb7.var_e91c9347e638750d);

      if(function_4385c3a2905eef3b(self, var_1e331291fa3bd60)) {
        outofrange = 0;
        function_bcbff1c1b64843b6(var_1e331291fa3bd60);
      } else {
        outofrange = function_f6ae22a0ef39407b();
      }
    } else {
      outofrange = function_f6ae22a0ef39407b();
    }

    if(istrue(outofrange)) {
      function_c8b79f6694c62ee8(-1);
    }

    waitframe();
  }
}

function function_f6ae22a0ef39407b() {
  if(issharedfuncdefined("radiation", "radiation_isInit") && issharedfuncdefined("radiation", "radiation_signedDistanceFromRadiationCircle")) {
    if([[scripts\engine\utility::getsharedfunc("radiation", "radiation_isInit")]]()) {
      var_7541c0ea78d6cdaf = [[scripts\engine\utility::getsharedfunc("radiation", "radiation_signedDistanceFromRadiationCircle")]](self.origin);

      if(var_7541c0ea78d6cdaf < level.var_bcb3e1f6f7cd3cb7.radiationmaxdist) {
        function_bcbff1c1b64843b6(99999999999);
        return false;
      }
    }
  }

  return true;
}

function function_bcbff1c1b64843b6(dist) {
  if(getweaponbasename(self getheldoffhand()) == "geiger_counter_mp") {
    self.var_bcb3e1f6f7cd3cb7.pulledout = 1;
    self.var_bcb3e1f6f7cd3cb7.var_5b02e3a063eb58b1 = gettime();
    self.var_bcb3e1f6f7cd3cb7.var_f458338f4188859e = _geigercounter_calculategeigercounterpulserate(dist, self.var_bcb3e1f6f7cd3cb7.var_e91c9347e638750d);

    if(!isDefined(self.var_bcb3e1f6f7cd3cb7.timesincetick)) {
      self.var_bcb3e1f6f7cd3cb7.timesincetick = 0;
    }

    if(isDefined(self.var_bcb3e1f6f7cd3cb7.var_e91c9347e638750d)) {
      object = self.var_bcb3e1f6f7cd3cb7.var_e91c9347e638750d;

      if(isDefined(object.var_9d4873a013fb19ab) && isDefined(self.team) && !array_contains(object.var_f967e4de0363ea83, self.team)) {
        minvalue = object.var_44c91f16317bb5c2;

        if(!isDefined(minvalue) || isDefined(minvalue) && minvalue <= 1.4 - self.var_bcb3e1f6f7cd3cb7.var_f458338f4188859e) {
          scripts\cp_mp\challenges::function_8359cadd253f9604(self, object.var_9d4873a013fb19ab, 1);
          object.var_f967e4de0363ea83[object.var_f967e4de0363ea83.size] = self.team;
        }
      }
    }

    function_c8b79f6694c62ee8(clamp(1.4 - self.var_bcb3e1f6f7cd3cb7.var_f458338f4188859e, 0, 1.4));

    if(self.var_bcb3e1f6f7cd3cb7.timesincetick >= self.var_bcb3e1f6f7cd3cb7.var_f458338f4188859e) {
      function_18ad59d3abd30f4();
      self.var_bcb3e1f6f7cd3cb7.timesincetick = 0;
    }

    self.var_bcb3e1f6f7cd3cb7.timesincetick += level.framedurationseconds;
    return;
  }

  function_c8b79f6694c62ee8(-0.25);
}

function function_a9d03825299dd6bf() {
  if(getweaponbasename(self getheldoffhand()) == "geiger_counter_mp") {
    return true;
  }

  return false;
}

function function_9b3c029182bf2647(raceresult) {
  self endon("geigercounter_watchRaceEnd");
  self waittill("death");
  raceresult.death = 1;
  self notify("geigercounter_watchRaceStart");
}

function function_f668eed31b686b60(raceresult) {
  self endon("geigercounter_watchRaceEnd");
  self waittill("geigercounter_take");
  raceresult.take = 1;
  self notify("geigercounter_watchRaceStart");
}

function function_841d127cb52727a9(raceresult) {
  self endon("geigercounter_watchRaceEnd");
  self waittill("pullout_gc", weapon);

  while(true) {
    if(getweaponbasename(self getheldoffhand()) == "geiger_counter_mp") {
      break;
    }
  }

  raceresult.pulledout = 1;
  self notify("geigercounter_watchRaceStart");
}

function function_b33a67426542b0c5(raceresult) {
  self endon("geigercounter_watchRaceEnd");

  while(true) {
    if(getweaponbasename(self getheldoffhand()) == "geiger_counter_mp") {
      break;
    }
  }

  raceresult.putaway = 1;
  self notify("geigercounter_watchRaceEnd");
}

function function_ce0fef2f2c7f1717() {
  self notify("geigercounter_putaway");

  if(isDefined(self.var_bcb3e1f6f7cd3cb7)) {
    self.var_bcb3e1f6f7cd3cb7.pulledout = undefined;
    self.var_bcb3e1f6f7cd3cb7 = undefined;
    function_5600972de1b79706();
    function_c5211deb59bc819a();
  }
}

function function_27b913c5a2199f7f() {
  return isDefined(self.var_bcb3e1f6f7cd3cb7) && istrue(self.var_bcb3e1f6f7cd3cb7.pulledout);
}

function function_c5211deb59bc819a() {
  self setclientomnvar("ui_geigercounter_meter", 0);
}

function function_7842c49c4d21bd5b(data) {
  self setclientomnvar("ui_geigercounter_meter", data);
}

function function_18ad59d3abd30f4() {
  var_506ef0d96798eae = self getclientomnvar("ui_geigercounter_type");

  if(var_506ef0d96798eae == 1) {
    self playlocalsound("rfid_tick");
    return;
  }

  self playlocalsound("iw9_geiger_counter_tick");
}

function function_5600972de1b79706() {
  var_506ef0d96798eae = self getclientomnvar("ui_geigercounter_type");

  if(var_506ef0d96798eae == 1) {
    self stoplocalsound("rfid_tick");
    return;
  }

  self stoplocalsound("iw9_geiger_counter_tick");
}

function function_c8b79f6694c62ee8(overridevalue) {
  if(isDefined(overridevalue)) {
    function_7842c49c4d21bd5b(overridevalue);
    return;
  }

  function_7842c49c4d21bd5b(self.var_bcb3e1f6f7cd3cb7.var_f458338f4188859e);
}

function function_f0d61e14dfde9ccd(object) {
  level.var_bcb3e1f6f7cd3cb7.partition function_24bbefb4beda630d(object);
}

function function_a67007b5af86ff0b(object) {
  level.var_bcb3e1f6f7cd3cb7.partition function_9cd3f5f067afea37(object);
}

function function_38c53210a5291d71(object) {
  if(!isDefined(object) || isstruct(object)) {
    return false;
  }

  has_parts = isent(object) && object isscriptable() || !isent(object) && object isscriptableinstance();
  return has_parts && object isscriptableinstance() && object getscriptablehaspart("brloot_valuable_fuelrods") && object getscriptablepartstate("brloot_valuable_fuelrods", 1) == "hidden";
}

function function_eff6d6db587f143d() {
  object = level.var_bcb3e1f6f7cd3cb7.partition function_60dbe20f8385f1b0(self.origin);

  while(function_38c53210a5291d71(object)) {
    function_a67007b5af86ff0b(object);
    object = level.var_bcb3e1f6f7cd3cb7.partition function_60dbe20f8385f1b0(self.origin);

    if(!isDefined(object)) {
      return undefined;
    }
  }

  return object;
}

function function_296cad0fb60ab083(var_476ba0cad41d3b92) {
  radiationpos = var_476ba0cad41d3b92.origin;
  var_1e331291fa3bd60 = distancesquared(radiationpos, self.origin);
  return var_1e331291fa3bd60;
}

function function_4385c3a2905eef3b(player, var_1e331291fa3bd60) {
  return var_1e331291fa3bd60 < level.var_bcb3e1f6f7cd3cb7.radiationradius * level.var_bcb3e1f6f7cd3cb7.radiationradius;
}

function _geigercounter_calculategeigercounterpulserate(var_1e331291fa3bd60, object) {
  self notify("_geigercounter_calculateGeigerCounterPulseRate");
  self endon("_geigercounter_calculateGeigerCounterPulseRate");
  self endon("disconnect");
  var_506ef0d96798eae = self getclientomnvar("ui_geigercounter_type");
  var_9068cb3a62d2ccd4 = 0.1;
  var_e3125b80ae68f4b1 = ter_op(var_506ef0d96798eae == 0, "iw9_geiger_counter_tick", "rfid_tick");
  minwait = lookupsoundlength(var_e3125b80ae68f4b1) / 1000;
  maxwait = 1.4;
  mindist = 0;
  maxdist = level.var_bcb3e1f6f7cd3cb7.radiationradius;
  dist = sqrt(var_1e331291fa3bd60);
  waittime = minwait;
  waittime_lookat = minwait;
  waittime_dist = minwait;
  total_factor = 0;
  dist_factor = clamp(-1 * (dist - mindist) / (maxdist - mindist) + 1, 0, 1);
  radiation_factor = 0;

  if(issharedfuncdefined("radiation", "radiation_isInit") && issharedfuncdefined("radiation", "radiation_signedDistanceFromRadiationCircle")) {
    if([[scripts\engine\utility::getsharedfunc("radiation", "radiation_isInit")]]()) {
      var_7541c0ea78d6cdaf = [[scripts\engine\utility::getsharedfunc("radiation", "radiation_signedDistanceFromRadiationCircle")]](self.origin);
      in_radiation = var_7541c0ea78d6cdaf <= 0;

      if(in_radiation) {
        radiation_factor = 1;
      } else {
        radiation_factor = clamp(-1 * var_7541c0ea78d6cdaf / level.var_bcb3e1f6f7cd3cb7.radiationmaxdist + 1, 0, 1);
      }
    }
  }

  angle_factor = 0;

  if(isDefined(object)) {
    player_forward = anglesToForward(self getplayerangles());
    var_4712089f9a28931d = vectorNormalize(object.origin - self.origin);
    dot_vec = vectordot(player_forward, var_4712089f9a28931d);
    angle_factor = clamp(20 * dist_factor, 0, 1) * (dot_vec + 1) / 2;
  }

  total_factor = clamp(dist_factor * 0.8 + angle_factor * 0.2 + radiation_factor * 1, 0, 1);

  if(isDefined(object) && isDefined(object.var_71a737239e0ee274)) {
    total_factor *= object.var_71a737239e0ee274;
  }

  waittime = (-1 * total_factor + 1) * maxwait;
  return waittime;
}

function function_a8a342d8f1a62582() {
  if(function_27b913c5a2199f7f()) {
    return (clamp(1.4 - self.var_bcb3e1f6f7cd3cb7.var_f458338f4188859e, 0, 1.4) / 1.4 * 10);
  }

  return 0;
}