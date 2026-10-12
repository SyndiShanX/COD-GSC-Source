/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_jugg_common.gsc
***************************************************/

#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_c130airdrop;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_jugg_common;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\hud_util;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#namespace br_jugg_common;

function init() {
  assert(isDefined(level.c130deliveriesinprogress));
  level.addjuggsettings = &setconfig;
  level.addjuggfunctionality = &addjuggfunctionality;
  level.clearbrinventory = &dropallunusableitems;
  registersharedfunc("br_juggernaut", "onCrateActivate", &oncrateactivate);
  registersharedfunc("br_juggernaut", "onCrateUse", &oncrateuse);
  registersharedfunc("br_juggernaut", "onCrateDestroy", &oncratedestroy);
  level thread scripts\mp\gametypes\br_c130airdrop::init();
  level.activejuggernauts = [];
  level.brjuggsettings = [];

  setdevdvarifuninitialized(@ "scr_br_jugg_num_drops", 3);
  setdevdvarifuninitialized(@ "hash_fca632f39743dfa8", 0);
  setdevdvarifuninitialized(@ "hash_7ed2e5c3764afc91", 20000);
  setdevdvarifuninitialized(@ "hash_4c96c13074cf77e5", 5);
  setdevdvarifuninitialized(@ "hash_4b258e12bbf733e3", 300);
  setdevdvarifuninitialized(@ "hash_14531681ab16f185", 30);
  setdevdvarifuninitialized(@ "hash_656b5e056fdbf096", 0);
  setdevdvarifuninitialized(@ "hash_3372053939d80fa4", 0);
  setdevdvarifuninitialized(@ "hash_d4b2c13dead25aac", 0);
  setdevdvarifuninitialized(@ "hash_5b4c172bb66d3381", 1);
  setdevdvarifuninitialized(@ "hash_f2ddabb9926dca3b", 5);
  setdevdvarifuninitialized(@ "hash_27f2654d9fc3696d", 0);
  setdevdvarifuninitialized(@ "hash_90fb266842b5bc2a", 1);
  setdevdvarifuninitialized(@ "hash_5da0d73409690e9c", 7);
  setdevdvarifuninitialized(@ "hash_a9e8e75fb57047aa", 1.25);
  setdevdvarifuninitialized(@ "hash_95386e0fedd3f69a", 2000);
  level thread function_59ed9e94de8f9c42();
  level thread function_fdcc5bb7ff13a7d1();

  thread initpostmain();
}

function initpostmain() {
  waittillframeend();
  initdroplocations();
  level.numactivejuggdrops = 0;
}

function setconfig() {
  self.overheatlimit = 100;
  self.overheatcooldown = 3;
  self.overheatreductiontime = 1;
  self.overheatreductionrate = 0.5;
  self.overheatreductionamount = 5;
  self.infiniteammo = 0;
  self.maxhealth = getdvarint(@ "hash_95386e0fedd3f69a", 2000);
  self.startinghealth = getdvarint(@ "hash_95386e0fedd3f69a", 2000);
  self.vehiclecankillhealth = int(self.maxhealth / self.maxvehicledamagedivisor);
  useweaponpickups = getdvarint(@ "hash_27f2654d9fc3696d", 0);
  self.useweaponpickups = useweaponpickups;
  usereload = getdvarint(@ "hash_5b4c172bb66d3381", 1);

  if(usereload) {
    self.classstruct.loadoutprimary = "iw9_minigunksjugg_reload_mp";
    self.usereload = usereload;
  }

  self.allows["reload"] = undefined;
}

function modifybrgasdamage(originaldamage) {
  gasdamagescale = getdvarfloat(@ "hash_5da0d73409690e9c", 7);
  modifieddamage = originaldamage * gasdamagescale;
  return int(modifieddamage);
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  if(isDefined(attacker) && isPlayer(attacker) && attacker isjuggernaut()) {
    var_10824d931642fd85 = attacker.health;
    var_10ed24d9931af0ca = int(attacker.maxhealth / 6);
    newhealth = var_10824d931642fd85 + var_10ed24d9931af0ca;

    if(newhealth > attacker.maxhealth) {
      newhealth = attacker.maxhealth;
    }

    attacker.health = newhealth;
    attacker notify("jugg_health_regen");
  }

  if(isDefined(self) && isjuggernaut()) {
    self.ignoredeathsdoor = undefined;
  }
}

function addjuggfunctionality() {
  juggconfig = self.juggcontext.juggconfig;
  useoverheat = getdvarint(@ "hash_fca632f39743dfa8", 0);

  if(useoverheat) {
    thread watchoverheat(juggconfig);
    thread watchheatreduction(juggconfig);
  }

  thread mangagedeathsdoor(juggconfig);
}

function dropallunusableitems() {
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  scripts\mp\gametypes\br_pickups::dropbrammoboxes(dropstruct);
  scripts\mp\gametypes\br_pickups::dropbrprimaryweapons(dropstruct);
  scripts\mp\gametypes\br_pickups::dropbrequipment(dropstruct);
  scripts\mp\gametypes\br_pickups::dropbrhealthpack(dropstruct);
  scripts\mp\gametypes\br_pickups::dropbrkillstreak(dropstruct);
  scripts\mp\gametypes\br_pickups::dropbrsuper(dropstruct);
  thread scripts\mp\gametypes\br_pickups::dropbrgasmask(dropstruct);
  scripts\mp\gametypes\br_pickups::dropbrselfrevivetoken(dropstruct);
}

function initdroplocations() {
  if(!isDefined(level.calloutglobals.namelocations) || level.calloutglobals.namelocations.size == 0) {
    print("<dev string:x1c>");

    return;
  }

  level.juggdroplocations = [];

  foreach(index, loc in level.calloutglobals.namelocations) {
    newlocationstruct = spawnStruct();
    newlocationstruct.id = index;
    newlocationstruct.origin = loc.origin;
    newlocationstruct.occupied = 0;
    level.juggdroplocations[level.juggdroplocations.size] = newlocationstruct;
  }
}

function getdroplocationnearcurrentcircle(radiusbuffer) {
  location = undefined;

  if(isDefined(level.juggdroplocations) && level.juggdroplocations.size > 0) {
    foreach(locinfo in level.juggdroplocations) {
      if(!ispointnearcurrentsafecircle(locinfo, radiusbuffer)) {
        continue;
      }

      if(istrue(locinfo.occupied)) {
        continue;
      }

      if(isnearajuggdrop(locinfo.origin)) {
        continue;
      }

      if(isnearactivejugg(locinfo.origin)) {
        continue;
      }

      location = locinfo;
      locinfo.occupied = 1;
      break;
    }

    if(!isDefined(location)) {
      iprintlnbold("<dev string:xb1>");

      location = createjuggdroplocation();
    }
  } else {
    locationoverride = undefined;

    iprintlnbold("<dev string:x11c>");

    if(level.mapname == "<dev string:x195>") {
      foreach(player in level.players) {
        if(isDefined(player)) {
          locationoverride = scripts\mp\gametypes\br_circle::getrandompointinboundscircle(player.origin, 1000);
          break;
        }
      }
    }

    location = createjuggdroplocation(locationoverride);
  }

  return location;
}

function ispointnearcurrentsafecircle(locinfo, radiusbuffer) {
  if(level.br_circle_disabled || !isDefined(level.br_circle) || level.br_circle.circleindex < 0) {
    return true;
  }

  safecircleorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  safecircleradius = scripts\mp\gametypes\br_circle::getsafecircleradius();
  mindist = safecircleradius + radiusbuffer;
  mindistsq = mindist * mindist;

  if(distance2dsquared(locinfo.origin, safecircleorigin) <= mindistsq) {
    return true;
  }

  return false;
}

function isnearajuggdrop(droplocation) {
  mindist = getdvarint(@ "hash_7ed2e5c3764afc91", 20000);

  if(level.mapname == "<dev string:x195>") {
    mindist = 1000;
  }

  mindistsq = mindist * mindist;

  foreach(drop in level.c130successfulairdrops) {
    if(distance2dsquared(droplocation, drop.origin) < mindistsq) {
      return true;
    }
  }

  return false;
}

function isnearactivejugg(droplocation) {
  var_f05a4ee85b3f1451 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  mindistance = int(var_f05a4ee85b3f1451 - var_f05a4ee85b3f1451 / 3);
  mindistancesq = mindistance * mindistance;

  foreach(jugg in level.activejuggernauts) {
    if(isDefined(jugg) && distance2dsquared(droplocation, jugg.origin) < mindistancesq) {
      return true;
    }
  }

  return false;
}

function createjuggdroplocation(locationoverride) {
  newlocation = spawnStruct();

  if(isDefined(locationoverride)) {
    newlocation.origin = locationoverride;
  } else {
    numtries = 10;

    while(!isDefined(newlocation.origin)) {
      potentiallocation = scripts\mp\gametypes\br_circle::getrandompointinboundssafecircle();

      if(isDefined(level.activejuggernauts) && level.activejuggernauts.size > 0) {
        if(!isnearactivejugg(potentiallocation)) {
          newlocation.origin = potentiallocation;
        }
      } else {
        newlocation.origin = potentiallocation;
      }

      numtries--;

      if(numtries == 0 && !isDefined(newlocation.origin)) {
        newlocation.origin = potentiallocation;
      }

      waitframe();
    }
  }

  return newlocation;
}

function showdroplocations(var_fdfc755d4aa965c6, initialdrop) {
  level endon("game_ended");
  radiusbuffer = 50000;

  if(istrue(initialdrop)) {
    if(!istrue(level.br_circle_disabled)) {
      level waittill("br_circle_set");
    }
  } else {
    radiusbuffer = 0;
  }

  droplocations = [];

  for(i = 0; i < var_fdfc755d4aa965c6; i++) {
    dropcircle = scripts\mp\gametypes\br_jugg_common::getdroplocationnearcurrentcircle(radiusbuffer);
    dropcircle.beacon = spawn("script_model", dropcircle.origin);
    dropcircle.beacon setModel("ks_airdrop_crate_br");
    dropcircle.beacon setscriptablepartstate("jugg_drop_beacon", "on", 0);
    dropcircle function_6b6b6273f8180522("Juggernaut_Br", dropcircle.origin, 5000);
    dropcircle function_6988310081de7b45();
    droplocations[droplocations.size] = dropcircle;
  }

  return droplocations;
}

function startdeliveries(droplocations, source) {
  level endon("game_ended");

  if(level.mapname == "<dev string:x195>") {
    setDvar(@ "hash_d313f3ed75dbff0f", 100);
  }

  showsplashtoall("br_juggdrop_incoming");

  foreach(dropcircle in droplocations) {
    level thread dropdeliveryatpos(dropcircle, source);
    wait randomfloatrange(5, 10);
  }
}

function dropdeliveryatpos(dropcircle, source) {
  level endon("game_ended");

  if(!isDefined(dropcircle.dropradius)) {
    dropcircle.dropradius = 5000;
  }

  droppoint = scripts\mp\gametypes\br_circle::getrandompointinboundscircle(dropcircle.origin, dropcircle.dropradius);
  pathstruct = scripts\mp\gametypes\br_c130airdrop::c130airdrop_createpath(undefined, droppoint, 1);
  dist = distance(pathstruct.startpt, pathstruct.endpt);
  travelspeed = scripts\mp\gametypes\br_c130::getc130speed();
  time = dist / travelspeed;
  c130airdrop = scripts\mp\gametypes\br_c130airdrop::c130airdrop_spawn(pathstruct, dist, travelspeed, time);
  c130airdrop.dropfunc = &dropfunc;
  c130airdrop.source = source;
  c130airdrop scripts\mp\gametypes\br_c130airdrop::c130airdrop_startdelivery(1, "battle_royale_juggernaut", "jugg_world", dropcircle);
}

function dropfunc(var_5ee94ae126526f2f, var_958bbdfed6f2e9ef, var_fe41be11a71dc1b4, dropcircle) {
  var_bd34ecac3ada85b = self.startpt;
  droppoint = self.centerpt;
  planespeed = self.speed;
  dropwaittime = distance2d(var_bd34ecac3ada85b, droppoint) / planespeed;
  numcrates = 0;
  var_71cac1d48ab1c488 = 0;
  level.numactivejuggdrops += var_5ee94ae126526f2f;

  while(numcrates < var_5ee94ae126526f2f) {
    wait dropwaittime;
    droplocation = scripts\mp\gametypes\br_c130airdrop::c130airdrop_findvaliddroplocation(self.origin, 1);
    crate = scripts\cp_mp\killstreaks\airdrop::dropbrc130airdropcrate(droplocation + (0, 0, level.c130airdrop_heightoverride - 100), droplocation, self.angles, var_958bbdfed6f2e9ef, var_fe41be11a71dc1b4, dropcircle.nodropanim);
    numcrates++;
    crate.dropcircle = dropcircle;
    crate.source = self.source;
    level.c130successfulairdrops[level.c130successfulairdrops.size] = crate;
    triggerobject = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(crate);
    triggerobject.usetimeoverride = getcrateusetime();
  }
}

function watchoverheat(juggconfig) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  heatlimit = juggconfig.overheatlimit;
  heatcooldown = juggconfig.overheatcooldown;
  juggconfig.heatcounter = 0;

  while(true) {
    self waittill("weapon_fired");
    juggconfig.heatcounter++;
    juggconfig.lastheatupdate = gettime();

    if(juggconfig.heatcounter >= heatlimit) {
      iprintlnbold("OVERHEAT");
      val::set("overheat_cooldown", "fire", 0);
      wait heatcooldown;
      iprintlnbold("COOLDOWN");
      val::reset_all("overheat_cooldown");
    }
  }
}

function watchheatreduction(juggconfig) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  heatreductiontime = juggconfig.overheatreductiontime;
  heatreductionrate = juggconfig.overheatreductionrate;
  heatreductionamount = juggconfig.overheatreductionamount;

  while(true) {
    if(juggconfig.heatcounter > 0 && gettime() - juggconfig.lastheatupdate >= heatreductiontime * 1000) {
      var_f8f916a03affa77b = juggconfig.heatcounter - heatreductionrate;

      if(var_f8f916a03affa77b < 0) {
        var_f8f916a03affa77b = 0;
      }

      juggconfig.heatcounter = int(var_f8f916a03affa77b);
    }

    wait 0.05;
  }
}

function mangagedeathsdoor(juggconfig) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  var_37329a37ef4dd878 = 5;

  while(true) {
    result = waittill_any_return_2("deaths_door_enter", "jugg_health_regen");
    healed = 1;

    if(result == "deaths_door_enter") {
      healed = 0;
      self.ignoredeathsdoor = 1;
      wait var_37329a37ef4dd878;
    } else if(result == "jugg_health_regen") {
      healthratio = self.health / self.maxhealth;

      if(healthratio >= 0.75) {
        if(istrue(self.ignoredeathsdoor)) {
          self.ignoredeathsdoor = undefined;
        }
      }
    }

    scripts\common\damage_effects::onexitdeathsdoor(healed);
  }
}

function droponplayerdeath(dropstruct) {
  scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onJuggDropOnDeath", dropstruct);
  level.numactivejuggdrops--;
}

function dropjuggbox() {
  contentoverride = create_contents(0, 1, 1, 1, 0, 0, 1, 1, 1);
  groundtrace = ray_trace(self.origin + (0, 0, 40), self.origin - (0, 0, 10000), self, contentoverride);
  dropposition = self.origin;

  if(isDefined(groundtrace) && isDefined(groundtrace["hittype"]) && groundtrace["hittype"] != "hittype_none") {
    dropposition = groundtrace["position"];
  }

  crate = scripts\cp_mp\killstreaks\airdrop::dropbrc130airdropcrate(self.origin + (0, 0, 10), dropposition, self.angles, "battle_royale_juggernaut", "jugg_world");

  if(isDefined(crate)) {
    triggerobject = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(crate);
    triggerobject.usetimeoverride = getcrateusetime();
  }
}

function oncrateactivate(var_d9bc1b05d016a86f) {
  scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onJuggCrateActivate", var_d9bc1b05d016a86f);

  if(istrue(var_d9bc1b05d016a86f)) {
    thread watchcratetimeout();
    thread watchcrategastimeout();
  }
}

function watchcratetimeout() {
  self endon("death");
  cratetimeout = getdvarint(@ "hash_4b258e12bbf733e3", 300);
  wait cratetimeout;
  scripts\cp_mp\killstreaks\airdrop::destroycrate();
}

function watchcrategastimeout() {
  self endon("death");

  if(istrue(level.br_circle_disabled)) {
    return;
  }

  crategastimeout = getdvarint(@ "hash_14531681ab16f185", 30);

  while(true) {
    wait 0.05;

    if(!isDefined(level.br_circle) || level.br_circle.circleindex < 0) {
      continue;
    }

    dangercircleorigin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    dangercircleradius = scripts\mp\gametypes\br_circle::getdangercircleradius();

    if(distance2dsquared(dangercircleorigin, self.origin) > dangercircleradius * dangercircleradius) {
      break;
    }
  }

  wait crategastimeout;
  scripts\cp_mp\killstreaks\airdrop::destroycrate();
}

function oncrateuse(player) {
  player.jugg_source = self.source;
  scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onJuggCrateUse", player);
  notifycapturetoplayers(player);
  cratecleanup();
}

function notifycapturetoplayers(owner) {
  notifyorigin = self.origin;
  notifyrange = 5000;
  playersinrange = utility::playersincylinder(notifyorigin, notifyrange);

  foreach(player in playersinrange) {
    if(isDefined(player) && isreallyalive(player) && player != owner) {
      soundtoplay = "br_jugg_capture_positive";

      if(player.team != owner.team) {
        soundtoplay = "br_jugg_capture_negative";
      }

      player playlocalsound(soundtoplay);
    }
  }
}

function oncratedestroy(immediate) {
  scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onJuggCrateDestroy", immediate);
  level.numactivejuggdrops--;
  cratecleanup();
}

function cratecleanup() {
  if(isDefined(self.dropcircle)) {
    self.dropcircle.occupied = 0;
    self.dropcircle function_af5604ce591768e1();

    if(isDefined(self.dropcircle.beacon)) {
      self.dropcircle.beacon setscriptablepartstate("jugg_drop_beacon", "off");
      self.dropcircle.beacon delete();
    }
  }

  if(isDefined(level.c130successfulairdrops)) {
    level.c130successfulairdrops = array_remove(level.c130successfulairdrops, self);
  }
}

function init_br_jugg_setting(name, value, source) {
  if(!isDefined(source)) {
    source = "default";
  }

  if(!isDefined(level.brjuggsettings[source])) {
    level.brjuggsettings[source] = [];
  }

  assert(!isDefined(level.brjuggsettings[source][name]));
  level.brjuggsettings[source][name] = value;
}

function get_br_jugg_setting(name, source) {
  value = undefined;

  if(isDefined(source)) {
    if(isDefined(level.brjuggsettings[source])) {
      value = level.brjuggsettings[source][name];
    }
  }

  if(!isDefined(value)) {
    value = level.brjuggsettings["default"][name];
  }

  assert(isDefined(value));
  return value;
}

function getcrateusetime() {
  return getdvarfloat(@ "hash_4c96c13074cf77e5", 5);
}

function getnumdrops() {
  return getdvarint(@ "scr_br_jugg_num_drops", 3);
}

function getjuggdamagescale() {
  return getdvarfloat(@ "hash_90fb266842b5bc2a", 1);
}

function getminigundamagescale() {
  return getdvarfloat(@ "hash_a9e8e75fb57047aa", 1.25);
}

function function_59ed9e94de8f9c42() {
  level endon("<dev string:x1a8>");

  while(true) {
    var_eccdd5494d666edf = getdvarint(@ "hash_656b5e056fdbf096", 0);

    if(!var_eccdd5494d666edf) {
      waitframe();
      continue;
    }

    var_fdfc755d4aa965c6 = getnumdrops();

    if(level.mapname == "<dev string:x195>") {
      var_fdfc755d4aa965c6 = 1;
    }

    dropcircles = showdroplocations(var_fdfc755d4aa965c6);
    showsplashtoall("<dev string:x1b6>");

    foreach(drop in dropcircles) {
      level thread dropdeliveryatpos(drop);
      wait randomfloatrange(5, 10);
    }

    setDvar(@ "hash_656b5e056fdbf096", 0);
  }
}

function function_fdcc5bb7ff13a7d1() {
  level endon("<dev string:x1a8>");

  while(true) {
    var_eccdd5494d666edf = getdvarint(@ "hash_3372053939d80fa4", 0);

    if(!var_eccdd5494d666edf) {
      waitframe();
      continue;
    }

    firstplayer = undefined;

    foreach(player in level.players) {
      if(isreallyalive(player)) {
        firstplayer = player;
        break;
      }
    }

    dropcircle = undefined;
    starttrace = firstplayer.origin + (0, 0, 10000);
    endtrace = firstplayer.origin - (0, 0, 20000);
    contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 1, 1);
    trace = scripts\engine\trace::ray_trace(starttrace, endtrace, firstplayer, contents);

    if(isDefined(trace) && trace["<dev string:x1ce>"] != "<dev string:x1d9>") {
      dropcircle = scripts\mp\gametypes\br_jugg_common::createjuggdroplocation(trace["<dev string:x1e9>"]);
      dropcircle.beacon = spawn("<dev string:x1f5>", dropcircle.origin);
      dropcircle.beacon setModel("<dev string:x205>");
      dropcircle.beacon setscriptablepartstate("<dev string:x21c>", "<dev string:x230>", 0);
      dropcircle function_6b6b6273f8180522("<dev string:x236>", dropcircle.origin, 5000);
      dropcircle function_6988310081de7b45();
    }

    if(isDefined(dropcircle)) {
      crate = scripts\cp_mp\killstreaks\airdrop::dropbrc130airdropcrate(dropcircle.origin + (0, 0, 5000), dropcircle.origin, (0, 0, 0), "<dev string:x247>", "<dev string:x263>");

      if(isDefined(crate)) {
        crate.dropcircle = dropcircle;
        level.c130successfulairdrops[level.c130successfulairdrops.size] = crate;
        triggerobject = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(crate);
        triggerobject.usetimeoverride = scripts\mp\gametypes\br_jugg_common::getcrateusetime();
      }
    } else {
      iprintlnbold("<dev string:x271>");
    }

    setDvar(@ "hash_3372053939d80fa4", 0);
  }
}

function function_3f3aa9ee24737fd3(player) {
  level endon("<dev string:x1a8>");
  usingparachute = 0;

  while(true) {
    toggleparachute = getdvarint(@ "hash_d4b2c13dead25aac", 0);

    if(!toggleparachute) {
      waitframe();
      continue;
    }

    if(!istrue(usingparachute)) {
      usingparachute = 1;
    } else {
      usingparachute = 0;
    }

    player skydive_setdeploymentstatus(usingparachute);
    player skydive_setbasejumpingstatus(usingparachute);
    setDvar(@ "hash_d4b2c13dead25aac", 0);
  }
}

# /