/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\supers\gas_trap.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\supers\supers;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\engine\utility;
#using scripts\mp\equipment_interact;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\movers;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\supers;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\equipment;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\script;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace gas_trap;

function function_d8b2df497e0b97f() {
  gasbundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_gas_trap");
  level.var_3ad99a60ec62068f = spawnStruct();
  level.var_3ad99a60ec62068f.maxtime = 7;
  level.var_3ad99a60ec62068f.dot_damage = 250;
  level.var_3ad99a60ec62068f.dot_interval = 0.1;
  level.var_3ad99a60ec62068f.var_605bc8d3bfb20d0d = 10;
  level.var_3ad99a60ec62068f.var_3340b02ebf8649d5 = 6;

  if(isDefined(gasbundle)) {
    level.var_3ad99a60ec62068f.maxtime = default_to(gasbundle.var_889e00d6ac48d183, 7);
    level.var_3ad99a60ec62068f.dot_damage = default_to(gasbundle.var_bfb71d4446e67684, 250);
    level.var_3ad99a60ec62068f.dot_interval = default_to(gasbundle.var_c5d3380c0a1b7004, 0.1);
    level.var_3ad99a60ec62068f.var_605bc8d3bfb20d0d = default_to(gasbundle.var_232365acb42a921d, 10);
    level.var_3ad99a60ec62068f.var_3340b02ebf8649d5 = default_to(gasbundle.var_e7563888658cad65, 6);
  }
}

function function_9eb2b20f81d7c464(grenade) {
  self endon("disconnect");
  grenade endon("death");

  if(issharedfuncdefined(#"hash_d8976e21a6adafba", #"hash_ca0042e3cac99672")) {
    grenade[[getsharedfunc(#"hash_d8976e21a6adafba", #"hash_ca0042e3cac99672")]](grenade);
  }

  if(_hasperk("specialty_rugged_eqp")) {
    grenade.hasruggedeqp = 1;
  }

  grenade.issuper = 1;
  grenade.bundle = scripts\mp\supers::function_83a68723acc3296d(grenade.weapon_name);
  grenade scripts\cp_mp\ent_manager::registerspawn(2, &function_ba58a20b3013d0e8);
  thread scripts\mp\weapons::monitordisownedgrenade(self, grenade);
  grenade thread function_c1abefb71b068a39();
  data = spawnStruct();
  data.endonstring = "mine_destroyed";
  data.skipdeath = 1;
  grenade thread scripts\mp\movers::handle_moving_platform_touch(data);
  grenade waittill("missile_stuck", stuckto, hitent, surfacetype, velocity, position, normal);

  if(isDefined(stuckto)) {
    if(isent(stuckto) && is_train_ent(stuckto)) {
      grenade.origin += (0, 0, 1.6);
    }

    grenade linkTo(stuckto);
  }

  thread function_28f1150ddecc322e(grenade, surfacetype);
}

function function_a9ef871da48567b1() {
  if(istrue(level.dangerzoneskipequipment)) {
    return;
  }

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
  }

  traptriggerradius = default_to(self.bundle.var_9ece98992bdf7d1e, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize());
  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(self.origin, traptriggerradius, 72, self.owner.team, undefined, self.owner, 0, self, 1);
}

function function_28f1150ddecc322e(grenade, surfacetype) {
  grenade endon("mine_destroyed");
  grenade endon("death");
  grenade setotherent(self);
  grenade setentityowner(self);
  grenade missilethermal();
  grenade missileoutline();
  grenade setnodeploy(1);
  onequipmentplanted(grenade, "equip_gas_trap_plantable", &function_293cb1a08a85b8b6);
  thread monitordisownedequipment(self, grenade);
  grenade scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", grenade.owner, 1);
  maxhits = default_to(grenade.bundle.var_8e44dea5fb0fd8c1, 1);
  grenade thread minedamagemonitor(maxhits);
  grenade thread function_49d67701924d486d();
  grenade function_641996b5e113c5c6(grenade, &function_12130c6112bc91e);
  grenade thread scripts\mp\equipment_interact::remoteinteractsetup(&function_583dd854dcee63c9, 0, 1);
  grenade function_a9ef871da48567b1();
  wait 0.75;

  if(istrue(grenade.touchedmovingplatform)) {
    grenade thread function_c313265bf3cab1e0();
  }

  wait 0.75;
  grenade thread function_e4221c03bb28d13f();

  if(getdvarint(@ "hash_656462250876637a", 0)) {
    grenade thread function_f539d5d6dc0cc4a7();
  }

  thread scripts\mp\weapons::outlineequipmentforowner(grenade);
  grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 2, undefined, undefined, undefined, 0.1, 1);
}

function function_7250c5a8ae9c2d87(vehicle) {
  var_9030149b0a44a43a = scripts\mp\supers::function_eb25267ee439cabe("super_gas_trap");
  gas_trap_weapon = makeweapon(var_9030149b0a44a43a);
  vehicle dodamage(25, self.origin, self.owner, self, "MOD_EXPLOSIVE", gas_trap_weapon);
  ignoredamageid = vehicle scripts\mp\utility\damage::non_player_add_ignore_damage_signature(self.owner, gas_trap_weapon, self, "MOD_EXPLOSIVE");
  thread function_42b544f5fa77cee9();
  waitframe();

  if(isDefined(vehicle)) {
    vehicle scripts\mp\utility\damage::non_player_remove_ignore_damage_signature(ignoredamageid);
  }
}

function function_42b544f5fa77cee9() {
  thread function_293cb1a08a85b8b6(2);
  self setentityowner(self.owner);
  self clearscriptabledamageowner();
}

function function_e015ee383cd188f5(attacker) {
  thread function_293cb1a08a85b8b6(2);
  self setentityowner(attacker);
  self clearscriptabledamageowner();
}

function function_583dd854dcee63c9(attacker) {
  thread function_293cb1a08a85b8b6(2);
}

function function_293cb1a08a85b8b6(deletiondelay) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setscriptablepartstate("destroy", "active", 0);
  self setCanDamage(0);
  makeexplosiveunusuabletag();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
    self.dangerzone = undefined;
  }

  if(isDefined(self.owner)) {
    self.owner removeequip(self);
  }

  if(isDefined(self.launchedmine)) {
    self.launchedmine delete();
  }

  if(issharedfuncdefined(#"hash_d8976e21a6adafba", #"hash_c33ceb91d0ca7a9d")) {
    self[[getsharedfunc(#"hash_d8976e21a6adafba", #"hash_c33ceb91d0ca7a9d")]](self);
  }

  function_83cebe0ae5318a7f(self);

  if(isDefined(deletiondelay)) {
    wait deletiondelay;
  }

  scripts\cp_mp\ent_manager::deregisterspawn();

  if(isDefined(self)) {
    self delete();
  }
}

function function_c313265bf3cab1e0() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.attachedvelocity = (0, 0, 0);
  update_interval = 0.2;

  while(true) {
    old_origin = self.origin;
    wait update_interval;
    self.attachedvelocity = 1 / update_interval * (self.origin - old_origin);
  }
}

function function_71e843b2ae312076(mine) {
  return isDefined(mine) && isDefined(mine.attachedvelocity) && length2dsquared(mine.attachedvelocity) > 0.01;
}

function function_e4221c03bb28d13f() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");

  while(true) {
    self waittill("trigger_grenade", entarr);
    assert(isDefined(entarr));

    if(istrue(self.isdisabled) || istrue(self.isjammed)) {
      continue;
    }

    foreach(ent in entarr) {
      if(ent.classname == "script_vehicle") {
        if(ent scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_isfriendlytomine(self)) {
          continue;
        }

        if(!scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_shouldvehicletriggermine(ent, self)) {
          continue;
        }

        scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_minetrigger(ent, self);
        break;
      }

      if(isagent(ent) || isPlayer(ent)) {
        if(isDefined(ent.vehicle)) {
          continue;
        }

        if(!isreallyalive(ent)) {
          continue;
        }

        thread function_e7eb101b2882a52f(ent);
        break;
      }
    }
  }
}

function function_f539d5d6dc0cc4a7() {
  self endon("<dev string:x1c>");
  self endon("<dev string:x2e>");
  self endon("<dev string:x40>");

  if(isDefined(self.debug_trig)) {
    self.debug_trig delete();
  }

  self.debug_trig = spawn("<dev string:x49>", self.origin, 0, 48, 48);
  self.debug_trig enablelinkTo();
  self.debug_trig linkTo(self);
  cylinder(self.origin, self.origin + (0, 0, 48), 48, (1, 1, 0), 0, 100);

  while(true) {
    self.debug_trig waittill("<dev string:x5b>", ent);
    assert(isDefined(ent));
    self notify("<dev string:x66>", [ent]);
    print3d(self.origin, "<dev string:x79>", (1, 1, 0), 1, 0.5, 100, 1);
  }
}

function function_e7eb101b2882a52f(ent) {
  self endon("mine_destroyed");
  self endon("death");
  self notify("mine_triggered");
  self.triggeredbyplayer = 1;
  makeexplosiveunusuabletag();
  self setscriptablepartstate("effects", "active", 0);
  position = self.origin + (0, 0, 10);
  self.allowhack = 1;
  thread function_b6591a59ba8c122a(position, self.owner, self.team);
}

function function_9a40b84c61fcf698(vehicle, mine) {
  mine endon("mine_destroyed");
  mine endon("death");
  mine.owner endon("disconnect");
  mine notify("mine_triggered");
  mine makeexplosiveunusuabletag();
  wait 0.2;
  mine thread function_7250c5a8ae9c2d87(vehicle);
}

function function_12130c6112bc91e(data) {
  attacker = data.attacker;
  self notify("enemy_destroyed_equipment", attacker);

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  if(isPlayer(attacker)) {
    attacker updatedamagefeedback("");
  }

  thread function_583dd854dcee63c9(attacker);
}

function function_49d67701924d486d() {
  self endon("death");
  self waittill("detonateExplosive", attacker);

  if(isDefined(attacker)) {
    thread function_e015ee383cd188f5(attacker);
    return;
  }

  if(isDefined(self.owner)) {
    thread function_e015ee383cd188f5(self.owner);
    return;
  }

  thread function_583dd854dcee63c9();
}

function function_c1abefb71b068a39() {
  self endon("mine_destroyed");
  self endon("death");
  level waittill_any_2("game_ended", "bro_shot_start");
  thread function_583dd854dcee63c9();
}

function function_62a347ed3920d124(launchedmine) {
  launchedmine endon("death");
  self waittill("death");
  launchedmine delete();
}

function function_c80f2e10e46fac9f(attacker) {
  self endon("death");
  attacker thread scripts\mp\utility\points::doscoreevent(#"hash_4af2232e0f83610b");
  self.isdisabled = 1;
  wait 6;
  self.isdisabled = 0;
}

function function_b6591a59ba8c122a(position, owner, team, duration, scale) {
  self setCanDamage(0);

  if(!isDefined(duration)) {
    duration = default_to(self.bundle.var_9d2049d108bea937, 2);
  }

  if(!isDefined(scale)) {
    scale = 1;
  }

  triggermaxsize = ter_op(isDefined(self.bundle.var_86263e241d6d10b1), int(self.bundle.var_86263e241d6d10b1), int(256 * scale));
  trigger = spawn("trigger_radius", position + (0, 0, int(-57.75 * scale)), 0, triggermaxsize, int(175 * scale));
  trigger scripts\cp_mp\ent_manager::registerspawn(1, &sweepgas);
  trigger endon("death");
  trigger.owner = owner;
  trigger.team = team;
  trigger.trap = self;
  trigger.playersintrigger = [];
  trigger thread function_24b91e463e75891f();
  trigger thread function_cdf66f292a6d921b();
  wait duration;
  thread function_583dd854dcee63c9();
  trigger thread function_673266358e778a6c();
}

function sweepgas() {
  thread function_673266358e778a6c();
}

function function_673266358e778a6c() {
  foreach(player in self.playersintrigger) {
    if(!isDefined(player)) {
      continue;
    }

    player thread function_779cd9adc64d02e9(self getentitynumber());
  }

  scripts\cp_mp\ent_manager::deregisterspawn();
  self delete();
}

function function_e58fc6a1208d483d(trigger) {
  if(!isDefined(self.gastriggerstouching)) {
    self.gastriggerstouching = [];
  }

  entnum = trigger getentitynumber();
  self.gastriggerstouching[entnum] = trigger;
  self.lastgastouchtime = gettime();

  if(!isDefined(self.var_a8005043799ca23)) {
    thread function_e527fb1c56a67ed2(trigger);
  } else {
    self.var_a8005043799ca23 = level.var_3ad99a60ec62068f.maxtime;
  }

  return entnum;
}

function function_779cd9adc64d02e9(triggerid) {
  assertex(isDefined(triggerid), "<dev string:x87>");
  self.gastriggerstouching[triggerid] = undefined;
  self.lastgastouchtime = gettime();
}

function function_24b91e463e75891f() {
  self endon("death");

  while(true) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }

    if(player scripts\mp\utility\killstreak::isjuggernaut()) {
      continue;
    }

    if(function_da8a31143b88e833(player)) {
      continue;
    }

    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(isDefined(self.playersintrigger[player getentitynumber()])) {
      continue;
    }

    if(level.teambased) {
      if(isDefined(self.owner) && isalive(self.owner)) {
        if(player != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(player, self.owner)) {
          continue;
        }
      } else if(scripts\cp_mp\utility\player_utility::isfriendly(self.team, player)) {
        continue;
      }
    }

    if(player == self.owner) {
      continue;
    }

    self.playersintrigger[player getentitynumber()] = player;
    player thread function_e58fc6a1208d483d(self);

    if(istrue(self.trap.allowhack)) {
      self.trap.allowhack = 0;
      self.trap setscriptablepartstate("hack_usable", "off");
    }
  }
}

function function_cdf66f292a6d921b() {
  self endon("death");

  while(true) {
    foreach(id, player in self.playersintrigger) {
      if(!isDefined(player)) {
        self.playersintrigger[id] = undefined;
        continue;
      }

      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(player istouching(self) && !function_da8a31143b88e833(player)) {
        continue;
      }

      self.playersintrigger[player getentitynumber()] = undefined;
      player thread function_779cd9adc64d02e9(self getentitynumber());
    }

    waitframe();
  }
}

function function_c0aa33366b33ddfa() {
  self waittill("death_or_disconnect");
  function_3d115d834192a21f(1);
}

function function_e527fb1c56a67ed2(trigger) {
  thread function_c0aa33366b33ddfa();
  self endon("death_or_disconnect");
  gasbundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_gas_trap");

  if(_hasperk("specialty_hallucination_immunity")) {
    return;
  }

  self.var_a8005043799ca23 = level.var_3ad99a60ec62068f.maxtime;
  attacker = trigger.owner;
  var_a2d4da59b401c41f = getdvarint(@ "hash_65b2a1e4bfb18c81", 0) == 0;

  if(isDefined(gasbundle)) {
    while(self.var_a8005043799ca23 > 0) {
      wait level.var_3ad99a60ec62068f.dot_interval;
      self.var_a8005043799ca23 -= level.var_3ad99a60ec62068f.dot_interval;

      if(isDefined(trigger) && isDefined(trigger.playersintrigger[self getentitynumber()])) {
        self dodamage(level.var_3ad99a60ec62068f.dot_damage, trigger.origin, attacker, trigger.trap);
      }

      if(self.gastriggerstouching.size >= 1) {
        self.var_a8005043799ca23 = level.var_3ad99a60ec62068f.maxtime;
      }

      if(!istrue(self.var_72a699992f3bb880)) {
        function_c0545824b502e347(0);
        childthread function_bfc451da8aefa61f(attacker);
      }

      if(var_a2d4da59b401c41f) {
        childthread function_ac8305738ed64f77();
      }

      if(!istrue(self.gascoughinprogress)) {
        function_cb203bea4d439b8b(0);

        if(istrue(gasbundle.var_809cef87d94991dd)) {
          childthread function_223c69b4c52f810(attacker, 0);
          scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudio();
        }
      }
    }

    function_3d115d834192a21f(0);
  }
}

function function_c0545824b502e347(fromdeath) {
  self notify("gas_trap_play_gunfire");
  self.var_72a699992f3bb880 = undefined;
}

function function_bfc451da8aefa61f(attacker) {
  self notify("gas_trap_play_gunfire");
  self endon("gas_trap_play_gunfire");
  var_e38a0e40421d2365 = ["ar", "smg", "sn"];
  var_e51767e71f37fdba = spawn("script_model", self.origin);
  self.var_72a699992f3bb880 = 1;
  pinglocationenemyteams(self.origin, attacker.team, self, level.var_3ad99a60ec62068f.var_3340b02ebf8649d5, level.var_3ad99a60ec62068f.var_605bc8d3bfb20d0d, self);
  gunfirex = randomfloatrange(-1000, 1000);
  gunfirey = randomfloatrange(-1000, 1000);
  var_e51767e71f37fdba.origin = self.origin + (gunfirex, gunfirey, 0);
  firetype = var_e38a0e40421d2365[randomint(var_e38a0e40421d2365.size)];
  soundtoplay = "iw8_decoy_grenade_" + firetype + "_fire";
  self playsoundtoplayer(soundtoplay, self, var_e51767e71f37fdba);
  wait 0.1;
  self playsoundtoplayer(soundtoplay, self, var_e51767e71f37fdba);
  wait 0.1;
  self playsoundtoplayer(soundtoplay, self, var_e51767e71f37fdba);
  wait randomfloatrange(0.5, 2);
  self.var_72a699992f3bb880 = 0;
  var_e51767e71f37fdba delete();
}

function function_ac8305738ed64f77() {
  self endon("death_or_disconnect");
  self notify("gas_trap_modify_blur");
  self endon("gas_trap_modify_blur");
  self visionsetnakedforplayer("cer_gas_mp");
  shockfile = "cer_gas_trap_heavy_mp";

  if(scripts\mp\utility\perk::_hasperk("specialty_gas_trap_resist")) {
    shockfile = "cer_gas_trap_light_mp";
  } else if(isDefined(self.gastriggerstouching)) {
    foreach(trigger in self.gastriggerstouching) {
      if(isDefined(trigger) && isDefined(trigger.owner) && trigger.owner == self) {
        if(getdvarint(@ "hash_6c7fd12a611ca1e8", 0) == 1) {
          break;
        }

        shockfile = "cer_gas_trap_light_mp";
      }
    }
  }

  while(true) {
    _shellshock(shockfile, "gas", 0.5, 0);
    wait 0.2;
  }
}

function function_142d2f94dd33931a(fromdeath) {
  self notify("gas_trap_modify_blur");
  self visionsetnakedforplayer("");

  if(!istrue(fromdeath)) {
    _stopshellshock();
  }
}

function function_223c69b4c52f810(attacker, fromimpact) {
  var_a15ffac7e41222a2 = scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist");
  var_8907f741f3a7b3f7 = isDefined(attacker) && self == attacker;

  if(!var_8907f741f3a7b3f7 && var_a15ffac7e41222a2) {
    return;
  }

  isheavy = 0;

  if(istrue(fromimpact)) {
    isheavy = 1;

    if(var_8907f741f3a7b3f7) {
      isheavy = 0;

      if(getdvarint(@ "hash_6c7fd12a611ca1e8", 0) == 1) {
        isheavy = 1;
      }
    }
  }

  if(!istrue(self.gascoughinprogress) || istrue(fromimpact)) {
    thread function_6c75b9d6b11459c5(isheavy);
  }
}

function function_6c75b9d6b11459c5(isheavy) {
  self endon("death_or_disconnect");
  self endon("gas_trap_clear_cough");
  self endon("gas_trap_exited");
  self notify("gas_trap_queue_cough");
  self endon("gas_trap_queue_cough");
  var_fff525b27a42fc40 = gettime() + 1000;

  while(function_b1c95073710796b8()) {
    waitframe();
  }

  if(isheavy && gettime() > var_fff525b27a42fc40) {
    isheavy = 0;
  }

  var_81b4070b5858078d = getdvarint(@ "hash_827901421ad0679", 1) == 1;

  if(var_81b4070b5858078d) {
    thread function_d96f17418ee81a89(isheavy);
    return;
  }

  self endon("gas_trap_begin_coughing");
  self.gascoughinprogress = 1;

  if(isheavy) {
    self playgestureviewmodel("iw9_ges_gas_cough_long");
    wait 3.33;
  } else {
    self playgestureviewmodel("iw9_ges_gas_cough");
    wait 1.833;
  }

  self.gascoughinprogress = undefined;
}

function function_d96f17418ee81a89(isheavy) {
  self endon("death_or_disconnect");
  self endon("gas_trap_clear_cough");
  self notify("gas_trap_begin_coughing");
  self endon("gas_trap_begin_coughing");
  self.gascoughinprogress = 1;

  if(self hasweapon(makeweapon("gas_cough_light_mp"))) {
    _takeweapon("gas_cough_light_mp");
  }

  if(self hasweapon(makeweapon("gas_cough_heavy_mp"))) {
    _takeweapon("gas_cough_heavy_mp");
  }

  weaponobj = ter_op(istrue(isheavy), makeweapon("gas_cough_heavy_mp"), makeweapon("gas_cough_light_mp"));
  duration = ter_op(istrue(isheavy), 3.33, 1.833);
  self giveandfireoffhand(weaponobj);
  childthread function_7003ab18f0d40f9e(weaponobj);
  childthread function_cd8cb96396c7e7bd(weaponobj);
  childthread function_3b420f49c5a08c56(duration);
  waittill_any_3("gas_trap_coughWeaponFired", "gas_trap_coughWeaponTaken", "gas_trap_coughDuration");

  if(self hasweapon(weaponobj)) {
    _takeweapon(weaponobj);
  }

  self.gascoughinprogress = undefined;
}

function function_e320f43bc3d01434(fromdeath) {
  self notify("gas_trap_queue_cough");
  self notify("gas_trap_begin_coughing");
  self.gascoughinprogress = undefined;
}

function function_cb203bea4d439b8b(fromdeath) {
  self notify("gas_trap");
  self notify("gas_trap_begin_coughing");
  self.gascoughinprogress = undefined;
  scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudio();

  if(!istrue(fromdeath)) {
    var_81b4070b5858078d = getdvarint(@ "hash_827901421ad0679", 1) == 1;

    if(var_81b4070b5858078d) {
      if(self hasweapon(makeweapon("gas_cough_light_mp"))) {
        _takeweapon("gas_cough_light_mp");
      }

      if(self hasweapon(makeweapon("gas_cough_heavy_mp"))) {
        _takeweapon("gas_cough_heavy_mp");
      }

      return;
    }

    self stopgestureviewmodel("iw9_ges_gas_cough");
    self stopgestureviewmodel("iw9_ges_gas_cough_long");
  }
}

function function_7003ab18f0d40f9e(var_33f644489e4f15ae) {
  self endon("gas_trap_coughWeaponTaken");
  self endon("gas_trap_coughDuration");

  while(true) {
    self waittill("offhand_fired", weaponobj);

    if(issameweapon(weaponobj, var_33f644489e4f15ae)) {
      break;
    }
  }

  self notify("gas_trap_coughWeaponFired");
}

function function_cd8cb96396c7e7bd(var_33f644489e4f15ae) {
  self endon("gas_trap_coughWeaponFired");
  self endon("gas_trap_coughDuration");

  while(self hasweapon(var_33f644489e4f15ae)) {
    waitframe();
  }

  self notify("gas_trap_coughWeaponTaken");
}

function function_3b420f49c5a08c56(coughduration) {
  self endon("gas_trap_coughWeaponTaken");
  self endon("gas_trap_coughWeaponFired");
  wait coughduration;
  self notify("gas_trap_coughDuration");
}

function function_b1c95073710796b8() {
  if(!val::get("cough_gesture")) {
    return true;
  }

  if(!val::get("offhand_weapons")) {
    return true;
  }

  return false;
}

function function_3d115d834192a21f(fromdeath) {
  self.var_a8005043799ca23 = undefined;
  function_142d2f94dd33931a(fromdeath);
  function_cb203bea4d439b8b(fromdeath);
  function_c0545824b502e347(fromdeath);

  if(isDefined(self.gastriggerstouching)) {
    foreach(trigger in self.gastriggerstouching) {
      if(!isDefined(trigger)) {
        continue;
      }

      trigger.playersintrigger[self getentitynumber()] = undefined;
    }
  }

  self.gastriggerstouching = undefined;
}

function function_da8a31143b88e833(player) {
  if(player function_7ee20cf3c0390e21()) {
    return true;
  }

  return false;
}

function is_train_ent(hitent) {
  if(isDefined(level.wztrain_info)) {
    foreach(ent in level.wztrain_info.train_array) {
      if(ent == hitent) {
        return true;
      }

      if(isDefined(ent.linked_model) && ent.linked_model == hitent) {
        return true;
      }
    }
  }

  return false;
}

function function_ba58a20b3013d0e8() {
  function_293cb1a08a85b8b6(0);
}