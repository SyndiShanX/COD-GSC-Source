/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\decon_station.gsc
*****************************************************/

#using script_2d9d24f7c63ac143;
#using scripts\common\ae_utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\damage;
#using scripts\mp\equipment\decon_station;
#using scripts\mp\equipment_interact;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\hud_util;
#using scripts\mp\perks\perk_equipmentping;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\supers;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\teams;
#using scripts\mp\weapons;
#namespace decon_station;

function autoexec main() {
  level thread scripts\mp\equipment\decon_station::function_1842bad814634447();
}

function function_1842bad814634447() {
  level endon("game_ended");
  function_a443e13b4a9bee87();
  level waittill("init_supers");
  scripts\engine\utility::registersharedfunc("decon_station", "grenadeUsed", &function_c06383227e374b98);
  registersharedfunc("super_decon_station", "getAmmo", &function_fe4d2e7bc5d4b7f7);
  registersharedfunc("super_decon_station", "setAmmo", &function_694daaec66c48da3);
  function_9748251d23375c78();
  level thread function_a04b98235b2cc5d6();
  level thread function_1625d782aa1489fa();
}

function function_a443e13b4a9bee87() {
  level._effect["vfx_br_decontamination_station_circle_aura"] = loadfx("vfx/iw8_br/island/equip/decon/vfx_br3_decon_aura");
}

function function_9748251d23375c78() {
  if(!isDefined(level.decon_station)) {
    level.decon_station = spawnStruct();
    level.decon_station.instances = [];
    level.decon_station.tracked_loot = [];
  }

  level.decon_station.max_lifetime = getdvarfloat(@ "hash_dcc4c6adcb09a2bb", 15);
  level.decon_station.min_lifetime = getdvarfloat(@ "hash_1a5d6dc2676025fa", 7.5);
  level.decon_station.lifetime = level.decon_station.max_lifetime;
  level.decon_station.pct = 100;
  level.decon_station.var_c413cb4751d8814c = getdvarfloat(@ "hash_2dfdd17871783bdd", 2);
  level.decon_station.var_1001d9fdfbdb1927 = getdvarfloat(@ "hash_e9c9b712bb876886", 1);
  level.decon_station.visibility_delay = getdvarfloat(@ "hash_22132f9a26c58f74", 0.1);
  level.decon_station.infinite_ammo = getdvarint(@ "hash_ca77644dc451154f", 0);
  level.decon_station.aura_enabled = getdvarint(@ "hash_ec721cc3212bbddd", 1);
  level.decon_station.radius_sq = 62500;
}

function function_1625d782aa1489fa() {
  level endon("game_ended");
  level waittill("br_pickups_init");
  level.decon_station.loot_id = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_offhand_deconstation");
  scripts\mp\gametypes\br_pickups::registerpickupcreatedcallback("brloot_offhand_deconstation", &function_e61a64964ffa423e, 1);
}

function update_dvars() {
  level endon("<dev string:x1c>");

  while(true) {
    function_9748251d23375c78();
    wait 1;
  }
}

function function_a04b98235b2cc5d6() {
  level endon("game_ended");
  utility::flag_wait("onStartGameTypeFinished");

  if(istrue(level.br_circle_disabled) || !isDefined(level.br_level.br_circleclosetimes)) {
    return;
  }

  num_circles = level.br_level.br_circleclosetimes.size;
  level.decon_station.var_a00b881d8f9acddd = num_circles - level.decon_station.var_c413cb4751d8814c;
  level.decon_station.var_7a6ea5da5bb808f8 = num_circles - level.decon_station.var_1001d9fdfbdb1927;
  diff = level.decon_station.var_7a6ea5da5bb808f8 - level.decon_station.var_a00b881d8f9acddd;

  for(;;) {
    level waittill("br_circle_set");

    if(level.br_circle.circleindex < level.decon_station.var_a00b881d8f9acddd) {
      continue;
    }

    current_circle = level.br_circle.circleindex + 1;
    t = clamp((current_circle - level.decon_station.var_a00b881d8f9acddd) / diff, 0, 1);
    level.decon_station.lifetime = math::lerp(level.decon_station.max_lifetime, level.decon_station.min_lifetime, t);
    level.decon_station.pct = int(level.decon_station.lifetime / level.decon_station.max_lifetime * 100);

    foreach(player in level.players) {
      player function_5662b53af19eebe4(level.decon_station.pct);
      super = player scripts\mp\supers::getcurrentsuper();

      if(isDefined(super) && super.staticdata.ref == "super_decon_station") {
        player scripts\mp\supers::function_60e9ab8c0ad6a01c(level.decon_station.pct, "all");
        player scripts\mp\gametypes\br_pickups::function_add28651639056b9();
      }
    }

    level.decon_station.tracked_loot = utility::array_removeundefined(level.decon_station.tracked_loot);

    foreach(loot in level.decon_station.tracked_loot) {
      scripts\mp\gametypes\br_pickups::loot_setitemcount(loot, level.decon_station.pct);
    }
  }
}

function function_5662b53af19eebe4(newhealth) {
  var_9793954ace7c0517 = [];
  var_9793954ace7c0517 = namespace_e50e624d9af51c8c::function_5915bdbc5f6302b6([level.decon_station.loot_id]);

  foreach(index in var_9793954ace7c0517) {
    namespace_e50e624d9af51c8c::function_e900e7e66383ad97(self, index, int(min(namespace_e50e624d9af51c8c::function_897b29adb37f06a7(index), newhealth)));
  }
}

function function_e61a64964ffa423e() {
  level.decon_station.tracked_loot[level.decon_station.tracked_loot.size] = self;
  scripts\mp\gametypes\br_pickups::loot_setitemcount(self, level.decon_station.pct);
}

function function_694daaec66c48da3(pct) {
  self.var_af191729ae32f538 = pct;
}

function function_fe4d2e7bc5d4b7f7() {
  return self.var_af191729ae32f538;
}

function function_b675a78bc2fc89cc() {
  function_ce125b637ef3e995(undefined, 0);
}

function function_8fe25bd617773044() {
  function_ce125b637ef3e995(undefined, 0);
}

function function_c06383227e374b98(instance) {
  level endon("game_ended");
  instance endon("death");
  self endon("disconnect");
  instance.owner = self;
  instance setotherent(instance.owner);
  instance setnodeploy(1);
  instance.issuper = isDefined(instance.owner.super) && instance.owner.super.staticdata.weapon == "decon_station_mp";
  instance.superid = level.superglobals.staticsuperdata["super_decon_station"].id;
  instance.usedcount = 0;
  instance.deploytime = gettime();
  instance.playersaffected = [];
  instance.kiosksaffected = [];
  instance scripts\cp_mp\ent_manager::registerspawn(2, &function_b675a78bc2fc89cc);
  instance thread function_e11ba21269ccd5aa();
  instance thread function_4755de31a950115();
  instance thread function_292eab686b6b2a43(instance.owner);
  thread function_dfe95384cf2267b0();
  instance waittill("missile_stuck", stuckto);

  if(istrue(level.gameended)) {
    instance thread function_ce125b637ef3e995(undefined, 0, 0);
    return;
  }

  instance.owner thread scripts\mp\weapons::monitordisownedgrenade(instance.owner, instance);
  printgameaction("trophy spawned", self);
  instance.owner onequipmentplanted(instance, "equip_decon_station", &function_8fe25bd617773044);
  instance thread monitordisownedequipment(instance.owner, instance);
  instance scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", instance.owner);
  instance.explosion = function_cf193b9f9be4558a();
  var_307667d0142f2035 = instance.owner _hasperk("specialty_rugged_eqp");

  if(var_307667d0142f2035) {
    instance.hasruggedeqp = 1;
  }

  maxhealth = ter_op(var_307667d0142f2035, 200, 100);
  damagefeedback = "hitequip";
  instance thread scripts\mp\damage::monitordamage(maxhealth, damagefeedback, &function_3787dffc5737dab7, &function_e216e49842f16c3e, 0);
  instance set_apply_emp_callback(&function_85e5fd047d8781ff);
  instance setscriptablepartstate("visibility", "show", 0);
  instance thread function_34f8be6e5619de8e();
  circle_index = isDefined(level.br_circle) ? utility::getintorzero(level.br_circle.circleindex) : -1;
  function_a033c27491518fb0(self, instance.origin, circle_index);
}

function function_dfe95384cf2267b0() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  while(self isthrowinggrenade()) {
    waitframe();
  }

  self.var_af191729ae32f538 = 0;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    self[[utility::getsharedfunc("player", "resetSuper")]]();
  }
}

function function_34f8be6e5619de8e() {
  self endon("death");
  self setscriptablepartstate("effects", "activeLand");
  thread function_9258952190753eb6();
  function_24da645ff5f35063();
  wait 0.2;
  self.owner scripts\cp_mp\challenges::function_d997435895422ecc("super_decon_station", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  thread outlineequipmentforowner(self);
  self.timestamp_start = gettime();
  self.timestamp_end = gettime() + level.decon_station.lifetime * 1000;
  level.decon_station.instances = array_add(level.decon_station.instances, self);
  trigger = spawn("trigger_radius", self.origin - (0, 0, 250), 19, 250, 500);
  trigger.instance = self;
  trigger enablelinkTo();
  trigger linkTo(self);
  self.registeredplayers = [];
  trigger thread function_128a4fee743da6b8();
  self.trigger = trigger;
  scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522("DeconStation_Br", self.origin, 250);
  scripts\cp_mp\utility\game_utility::function_6988310081de7b45();
  self.mapcircle linkTo(self);
  thread function_fd34b36b5287c008();
  thread function_af799b82948f975f(level.decon_station.lifetime, 5);
  thread function_9680f87ffa3dbd74();
  wait level.decon_station.lifetime;
  function_ce125b637ef3e995(undefined, 0);
  function_ee7db96b190a4b50();
  thread scripts\mp\equipment_interact::remoteinteractsetup(&function_ce125b637ef3e995, 1, 1);
  thread scripts\mp\perks\perk_equipmentping::runequipmentping();
}

function function_a51acf6aec4e93f6(instance) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("entered_decon_station_aura");
  self endon("entered_decon_station_aura");
  endon_key = "exit_decon_station_aura" + instance getentitynumber();
  self endon(endon_key);
  function_b200ebacdbaee4ad();
  function_1c39cb7e142659cb();

  if(arraycontains(teams::getteamdata(instance.owner.team, "players"), self) && self != instance.owner) {
    childthread function_8e816db9a263e987(instance);
  }

  self waittill("death");
  function_fd28f2264da9d3c7();
  function_9f9a669cc625c8fd();
}

function function_8e816db9a263e987(instance) {
  if(!isDefined(instance.var_b5c753b9312f9313)) {
    instance.var_b5c753b9312f9313 = [];
  }

  index = self getentitynumber();

  if(!isDefined(instance.var_b5c753b9312f9313[index])) {
    instance.var_b5c753b9312f9313[index] = 0;
  }

  while(isalive(self)) {
    wait 1;
    instance.var_b5c753b9312f9313[index] += 1;

    if(instance.var_b5c753b9312f9313[index] >= 7.5 && instance.var_b5c753b9312f9313[index] < 17 / 2) {
      instance.owner thread scripts\mp\utility\points::doscoreevent(#"hash_3d0adae7dedddf5b");
    }
  }
}

function function_6b5fe5bb09eb8d12(instance) {
  notify_key = "exit_decon_station_aura" + instance getentitynumber();
  self notify(notify_key);
  function_fd28f2264da9d3c7();
  function_9f9a669cc625c8fd();
}

function function_128a4fee743da6b8() {
  level endon("game_ended");
  self endon("death");
  instance = self.instance;

  while(true) {
    self waittill("trigger", ent);
    ent_id = ent getentitynumber();

    if(isDefined(instance.registeredplayers[ent_id]) && istrue(ent.inairpocket)) {
      continue;
    }

    if(!isPlayer(ent) && !ent scripts\common\vehicle::isvehicle()) {
      continue;
    }

    if(ent vehicle::isvehicle()) {
      occupants = vehicle_occupancy::vehicle_occupancy_getalloccupantsandreserving(ent);

      foreach(occupant in occupants) {
        if(isPlayer(occupant)) {
          occupant_id = occupant getentitynumber();

          if(isDefined(instance.registeredplayers[occupant_id]) && istrue(occupant.inairpocket)) {
            continue;
          }

          if(!instance function_8b9d56208d268672(occupant getEye())) {
            continue;
          }

          instance.registeredplayers[occupant_id] = occupant;
          occupant function_b200ebacdbaee4ad();
          occupant thread function_a51acf6aec4e93f6(instance);

          if(!istrue(ent.var_e79884673ac9666e) && scripts\cp_mp\gasmask::hasgasmask(ent)) {
            occupant scripts\mp\gametypes\br_pickups::function_8206bc54a1ed73cb("br_circle");
          }

          occupant thread function_100c065ef26d8383(instance);
        }
      }

      continue;
    }

    if(!instance function_8b9d56208d268672(ent getEye())) {
      continue;
    }

    instance.registeredplayers[ent_id] = ent;
    ent function_b200ebacdbaee4ad();
    ent thread function_a51acf6aec4e93f6(instance);

    if(!istrue(ent.var_e79884673ac9666e) && scripts\cp_mp\gasmask::hasgasmask(ent)) {
      ent scripts\mp\gametypes\br_pickups::function_8206bc54a1ed73cb("br_circle");
    }

    ent thread function_100c065ef26d8383(instance);
  }
}

function function_100c065ef26d8383(instance) {
  level endon("game_ended");
  instance endon("death");

  while(scripts\mp\utility\player::isreallyalive(self)) {
    if(!instance function_8b9d56208d268672(self getEye())) {
      break;
    }

    waitframe();
  }

  function_702dc1894784f5d6(instance);
}

function function_702dc1894784f5d6(instance) {
  instance.registeredplayers[self getentitynumber()] = undefined;

  if(function_5aac0a0b99e895e6(self)) {
    function_6b5fe5bb09eb8d12(instance);
  }
}

function function_5982c547b3946148(ent, trigger) {
  if(function_5aac0a0b99e895e6(ent) || isDefined(ent.vehicletype)) {
    return false;
  }

  return true;
}

function function_5aac0a0b99e895e6(ent) {
  return isPlayer(ent) || isagent(ent) || isbot(ent);
}

function function_24da645ff5f35063() {
  if(istrue(level.decon_station.aura_enabled)) {
    playFXOnTag(getfx("vfx_br_decontamination_station_circle_aura"), self, "tag_origin");
  }

  for(i = 1; i <= 6; i++) {
    partname = "canister" + string(i);
    self setscriptablepartstate(partname, "active");
  }

  self.var_8904bf911dce8250 = 6;
  thread function_6712a3a393684237();
}

function function_6712a3a393684237() {
  self endon("death");
  self endon("stop_canisters");
  level endon("game_ended");
  timeinterval = level.decon_station.lifetime / float(6);

  for(var_f32964e4d7f1f9d3 = 1; var_f32964e4d7f1f9d3 <= 6; var_f32964e4d7f1f9d3++) {
    partname = "canister" + string(var_f32964e4d7f1f9d3);
    wait timeinterval;
    self setscriptablepartstate(partname, "hidden");
    self.var_8904bf911dce8250--;
  }
}

function function_e05e6e05f45badd7() {
  self endon("death");
  level endon("game_ended");
  self notify("stop_canisters");

  if(isDefined(self.var_8904bf911dce8250) && self.var_8904bf911dce8250 > 0) {
    timeinterval = 0.1 / float(6);

    for(var_f32964e4d7f1f9d3 = 6 - self.var_8904bf911dce8250 + 1; var_f32964e4d7f1f9d3 <= 6; var_f32964e4d7f1f9d3++) {
      partname = "canister" + string(var_f32964e4d7f1f9d3);
      self setscriptablepartstate(partname, "hidden");
      self.var_8904bf911dce8250--;

      if(self.var_8904bf911dce8250 > 0) {
        wait timeinterval;
      }
    }
  }

  waitframe();
  self notify("canisters_popped");
}

function function_77b0e78777cab441() {
  if(istrue(level.decon_station.aura_enabled)) {
    killfxontag(getfx("vfx_br_decontamination_station_circle_aura"), self, "tag_origin");
  }
}

function function_9258952190753eb6() {
  self endon("death");
  self setscriptablepartstate("effects", "activeDeployStart");
  wait function_1a0e76814e6cd04e();
  self setscriptablepartstate("effects", "activeDeployEnd");
}

#using_animtree("scriptables");

function function_1a0e76814e6cd04e() {
  return getanimlength(%wm_decon_station_deploy_landing);
}

function function_85e5fd047d8781ff(data) {
  instance = data.victim;
  instance function_aa96f22f194adefa(data.attacker);
  instance function_ee7db96b190a4b50();
  instance thread function_ce125b637ef3e995(data.attacker, 1);
}

function function_1c39cb7e142659cb() {
  if(!isPlayer(self)) {
    return;
  }

  self.var_918acedcc9b7577e = 1;
  self setscriptablepartstate("decon_station_fx", "on");
}

function function_9f9a669cc625c8fd() {
  if(!istrue(self.var_918acedcc9b7577e)) {
    return;
  }

  self.var_918acedcc9b7577e = 0;
  self setscriptablepartstate("decon_station_fx", "off");
}

function function_e216e49842f16c3e(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  modifieddamage = damage;
  modifieddamage = scripts\mp\damage::handleapdamage(objweapon, type, modifieddamage);
  scripts\mp\weapons::equipmenthit(self.owner, attacker, objweapon, type);
  return modifieddamage;
}

function function_ee7db96b190a4b50() {
  if(isDefined(self.registeredplayers)) {
    foreach(player in self.registeredplayers) {
      player function_6b5fe5bb09eb8d12(self);
    }
  }

  function_77b0e78777cab441();
  level.decon_station.instances = array_remove(level.decon_station.instances, self);

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
  self notify("disperse");

  if(isDefined(self.armorykiosks)) {
    foreach(kiosk in self.armorykiosks) {
      kiosk function_f32b8dc9b65a1bd();
    }
  }

  if(isDefined(self.gasmasks)) {
    foreach(mask in self.gasmasks) {
      if(isDefined(mask)) {
        mask.inairpocket = 0;
      }
    }
  }
}

function function_3787dffc5737dab7(data) {
  attacker = data.attacker;
  function_aa96f22f194adefa(attacker);
  thread function_ce125b637ef3e995(attacker, 1);
}

function function_ce125b637ef3e995(attacker, wasdestroyed, delay) {
  level endon("game_ended");
  thread function_e05e6e05f45badd7();
  self waittill("canisters_popped");
  thread function_f828f503fe8f1ac8(0.1, wasdestroyed);
  self setscriptablepartstate("effects", "activeDestroyStart", 0);

  if(!isDefined(delay)) {
    delay = 0.1;
  }

  if(delay >= level.framedurationseconds) {
    wait delay;
  }

  if(isDefined(self.explosion)) {
    self.explosion delete();
  }

  if(isDefined(self)) {
    self setscriptablepartstate("effects", "activeDestroyEnd", 0);
  }

  var_9a6c1b85896a116e = {
    #kiosks_affected: self.kiosksaffected.size, #players_affected: self.playersaffected.size, #was_destroyed: wasdestroyed, #total_lifetime: gettime() - self.deploytime
  };
  function_62cfac8169ea6a74(var_9a6c1b85896a116e);
}

function function_f828f503fe8f1ac8(deletiondelay, wasdestroyed) {
  level endon("game_ended");
  self notify("disperse");
  self notify("death");
  self setscriptablepartstate("hack_usable", "off");

  if(scripts\engine\utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd")) {
    self.owner[[scripts\engine\utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]]("super_trophy", self.usedcount);
  }

  if(isDefined(self.maxhealth)) {
    dmg = int(isDefined(self.damagetaken) ? self.damagetaken : self.maxhealth);
    self.owner scripts\cp_mp\challenges::function_d997435895422ecc("super_decon_station", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"end"), dmg);
    scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(wasdestroyed));
  }

  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);

  if(!istrue(self.issuper)) {
    self makeunusable();
    makeexplosiveunusuabletag();
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.owner)) {
    self.owner notify("trophy_update", 0);
    self.owner removeequip(self);
  }

  function_ee7db96b190a4b50();
  self setscriptablepartstate("anims", "neutral", 0);
  self setscriptablepartstate("effects", "activeDestroyEnd", 0);

  if(isDefined(deletiondelay)) {
    wait deletiondelay;
  }

  scripts\cp_mp\ent_manager::deregisterspawn();
  thread utility::function_b4b04de87729a6f3(2.5);
}

function function_aa96f22f194adefa(attacker) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread giveunifiedpoints("destroyed_equipment");
    attacker thread scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }
}

function function_cf193b9f9be4558a() {
  explosion = spawn("script_model", self.origin);
  explosion.killcament = self;
  explosion.owner = self.owner;
  explosion.team = self.team;
  explosion.equipmentref = self.equipmentref;
  explosion.weapon_name = self.weapon_name;
  explosion setotherent(explosion.owner);
  explosion setentityowner(explosion.owner);
  explosion setModel("trophy_system_mp_explode");
  explosion.explode1available = 1;
  return explosion;
}

function function_e11ba21269ccd5aa() {
  self endon("death");
  self endon("missile_stuck");
  hideduration = getdvarfloat(@ "hash_64483ec1fd3d3c77", 0);
  self setscriptablepartstate("visibility", "hide", 0);
  wait hideduration;
  self setscriptablepartstate("visibility", "show", 0);
}

function function_4755de31a950115() {
  self endon("death");
  level waittill_any_2("game_ended", "br_ending_start");
  thread function_ce125b637ef3e995(undefined, 0, 0);
}

function function_292eab686b6b2a43(player) {
  self endon("death");
  self endon("missile_stuck");
  player endon("disconnect");
  msg = waittill_any_timeout_1(2, "touching_platform");

  if(msg == "timeout") {
    return;
  }

  groundentity = undefined;
  ignoreents = vehicle_getarrayinradius(self.origin, 500, 500);
  ignoreents[ignoreents.size] = self;
  tracecontents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1, 0, 1);
  tracestart = self.origin;
  var_3a7f0173b03f5767 = -2000;
  traceend = self.origin + (0, 0, var_3a7f0173b03f5767);
  traceresults = scripts\engine\trace::ray_trace(tracestart, traceend, ignoreents, tracecontents);

  if(traceresults["fraction"] < 1) {
    groundentity = traceresults["entity"];

    if(isDefined(groundentity)) {
      if(is_train_ent(groundentity)) {
        self.origin = player.origin;
      }
    }
  }
}

function function_fd34b36b5287c008() {
  self endon("disperse");
  self.armorykiosks = [];

  while(true) {
    function_4ab4129843b283fd();
    wait 0.5;
  }
}

function function_af799b82948f975f(time, offset) {
  self endon("death");
  self endon("disperse");
  wait time - offset;
  game_utility::function_6a52fd9d448df322("ExpiringDeconStation_Br");
}

function function_4ab4129843b283fd() {
  foreach(kiosk in self.armorykiosks) {
    if(!function_8b9d56208d268672(kiosk)) {
      kiosk function_f32b8dc9b65a1bd();
      self.armorykiosks[kiosk.index] = undefined;
    }
  }

  self.armorykiosks = array_removeundefined(self.armorykiosks);

  foreach(kiosk in level.br_armory_kiosk.scriptables) {
    if(!isDefined(kiosk) || isDefined(self.armorykiosks[kiosk.index])) {
      continue;
    }

    if(function_8b9d56208d268672(kiosk)) {
      if(istrue(kiosk.disabled)) {
        self.kiosksaffected[kiosk.index] = 1;
      }

      kiosk function_d5e3dcb372af63ff();
      self.armorykiosks[kiosk.index] = kiosk;
    }
  }
}

function function_d5e3dcb372af63ff() {
  self notify("decon_effect_applied");

  if(!isDefined(self.deconeffectcount)) {
    self.deconeffectcount = 0;

    if(istrue(self.disabled)) {
      scripts\mp\gametypes\br_armory_kiosk::function_d9a3848f71c7c63a(self);
      scripts\mp\gametypes\br_armory_kiosk::function_9bca399aafce0b41(self);
    }
  }

  self.deconeffectcount++;
}

function function_f32b8dc9b65a1bd() {
  self.deconeffectcount--;

  if(self.deconeffectcount == 0) {
    thread function_29e9926ce02e1444();
  }
}

function function_29e9926ce02e1444() {
  self endon("decon_effect_applied");
  wait 2;
  self.deconeffectcount = undefined;
}

function function_b200ebacdbaee4ad() {
  if(!istrue(self.inairpocket)) {
    self.inairpocket = 1;
    scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  }
}

function function_fd28f2264da9d3c7() {
  if(istrue(self.inairpocket)) {
    self.inairpocket = 0;
    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();
  }
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

function function_8b9d56208d268672(target) {
  if(isvector(target)) {
    return (distancesquared(target, self.origin) < level.decon_station.radius_sq);
  }

  return distancesquared(target.origin, self.origin) < level.decon_station.radius_sq;
}

function function_a033c27491518fb0(player, position, circle_index) {
  event_data = ["pos_x", position[0], "pos_y", position[1], "pos_z", position[2], "circle_index", circle_index];
  player dlog_recordplayerevent("dlog_event_br_decon_station_deployed", event_data);
}

function function_62cfac8169ea6a74(params) {
  event_data = ["total_lifetime", params.total_lifetime, "was_destroyed", params.was_destroyed, "players_affected", params.players_affected, "kiosks_affected", params.kiosks_affected];
  dlog_recordevent("dlog_event_br_decon_station_end", event_data);
}

function function_9680f87ffa3dbd74() {
  level endon("game_ended");
  self endon("disperse");
  self endon("death");

  while(true) {
    function_99d221b1b6568bf5();
    waitframe();
  }
}

function function_99d221b1b6568bf5() {
  self.gasmasks = [];

  foreach(gasmask in level.br_pickups.droppedgasmasks) {
    if(isDefined(gasmask)) {
      if(function_8b9d56208d268672(gasmask)) {
        if(gasmask getscriptablepartstate("damage_fx") == "active") {
          gasmask setscriptablepartstate("damage_fx", "inactive");
        }

        gasmask.inairpocket = 1;
        self.gasmasks[self.gasmasks.size] = gasmask;
        continue;
      }

      gasmask.inairpocket = 0;
    }
  }
}

function init_debug() {
  scripts\mp\gametypes\br_dev::registerhandlecommand(&function_c290f027b8bc76e1);
  level thread setup_devgui();
}

function setup_devgui() {
  level endon("<dev string:x1c>");

  while(!isDefined(level.player)) {
    waitframe();
  }

  adddebugcommand("<dev string:x2a>");
  adddebugcommand("<dev string:xb1>");
}

function function_c290f027b8bc76e1(command, args) {
  command_result = "<dev string:x13a>";

  switch (command) {
    case #"hash_d935a215264f7d83":
      level.allowsupers = 1;
      dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
      var_583079b4b2f185a2 = level.player.origin + anglesToForward(level.player.angles) * 300 + (0, 0, 25);
      dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, var_583079b4b2f185a2, level.player.angles, level.player);
      scripts\mp\gametypes\br_pickups::spawnpickup("<dev string:x165>", dropinfo);
      break;
    case #"hash_110b6dd8c0a49189":
      level.allowsupers = 1;
      level.player scripts\mp\supers::clearsuper(1);
      level.player scripts\mp\gametypes\br_pickups::forcegivesuper("<dev string:x1ac>");
      level.player scripts\mp\supers::givesuperpoints(level.player scripts\mp\supers::getsuperpointsneeded());
      break;
  }

  iprintln("<dev string:x1c3>" + command + ter_op(command_result != "<dev string:x13a>", "<dev string:x1d7>", "<dev string:x13a>") + command_result);
}

# /