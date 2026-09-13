/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_jugg_common.gsc
***************************************************/

init() {
  level.addjuggsettings = ::setconfig;
  level.addjuggfunctionality = ::addjuggfunctionality;
  level.clearbrinventory = ::dropallunusableitems;
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_juggernaut", "onCrateActivate", ::oncrateactivate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_juggernaut", "onCrateUse", ::oncrateuse);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_juggernaut", "onCrateDestroy", ::oncratedestroy);
  level thread _id_2E385BC294259245::init();
  level.activejuggernauts = [];
  level.brjuggsettings = [];
  thread initpostmain();
}

initpostmain() {
  waittillframeend;
  initdroplocations();
  level.numactivejuggdrops = 0;
}

setconfig() {
  self.overheatlimit = 100;
  self.overheatcooldown = 3.0;
  self.overheatreductiontime = 1.0;
  self.overheatreductionrate = 0.5;
  self.overheatreductionamount = 5;
  self.infiniteammo = 0;
  self.maxhealth = getdvarint("dvar_95386E0FEDD3F69A", 2000);
  self.startinghealth = getdvarint("dvar_95386E0FEDD3F69A", 2000);
  self.vehiclecankillhealth = int(self.maxhealth / self.maxvehicledamagedivisor);
  useweaponpickups = getdvarint("dvar_27F2654D9FC3696D", 0);
  self.useweaponpickups = useweaponpickups;
  usereload = getdvarint("dvar_5B4C172BB66D3381", 1);

  if(usereload) {
    self.classstruct.loadoutprimary = "iw9_minigunksjugg_reload_mp";
    self.usereload = usereload;
  }

  self.allows["reload"] = undefined;
}

modifybrgasdamage(_id_F2C6D9B76591B40B) {
  _id_27ED1E4B52687C23 = getdvarfloat("dvar_5DA0D73409690E9C", 7.0);
  _id_702BFC08FABD86CB = _id_F2C6D9B76591B40B * _id_27ED1E4B52687C23;
  return int(_id_702BFC08FABD86CB);
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  if(isDefined(attacker) && isPlayer(attacker) && attacker scripts\mp\utility\killstreak::isjuggernaut()) {
    _id_10824D931642FD85 = attacker.health;
    _id_10ED24D9931AF0CA = int(attacker.maxhealth / 6);
    _id_EDF34A99C4635317 = _id_10824D931642FD85 + _id_10ED24D9931AF0CA;

    if(_id_EDF34A99C4635317 > attacker.maxhealth)
      _id_EDF34A99C4635317 = attacker.maxhealth;

    attacker.health = _id_EDF34A99C4635317;
    attacker notify("jugg_health_regen");
  }

  if(isDefined(self) && scripts\mp\utility\killstreak::isjuggernaut())
    self.ignoredeathsdoor = undefined;
}

addjuggfunctionality() {
  juggconfig = self.juggcontext.juggconfig;
  _id_B25818830EDA394C = getdvarint("dvar_FCA632F39743DFA8", 0);

  if(_id_B25818830EDA394C) {
    thread watchoverheat(juggconfig);
    thread watchheatreduction(juggconfig);
  }

  thread mangagedeathsdoor(juggconfig);
}

dropallunusableitems() {
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_7E52B56769FA7774::dropbrammoboxes(dropstruct);
  _id_7E52B56769FA7774::dropbrprimaryweapons(dropstruct);
  _id_7E52B56769FA7774::dropbrequipment(dropstruct);
  _id_7E52B56769FA7774::dropbrhealthpack(dropstruct);
  _id_7E52B56769FA7774::dropbrkillstreak(dropstruct);
  _id_7E52B56769FA7774::dropbrsuper(dropstruct);
  _id_7E52B56769FA7774::dropbrgasmask(dropstruct);
  _id_7E52B56769FA7774::dropbrselfrevivetoken(dropstruct);
  _id_7E52B56769FA7774::dropspecialistbonus(dropstruct);
}

initdroplocations() {
  if(!isDefined(level.calloutglobals.namelocations) || level.calloutglobals.namelocations.size == 0) {
    return;
  }
  level.juggdroplocations = [];

  foreach(index, loc in level.calloutglobals.namelocations) {
    _id_DDB0F9BE7A29DF9B = spawnStruct();
    _id_DDB0F9BE7A29DF9B.id = index;
    _id_DDB0F9BE7A29DF9B.origin = loc.origin;
    _id_DDB0F9BE7A29DF9B.occupied = 0;
    level.juggdroplocations[level.juggdroplocations.size] = _id_DDB0F9BE7A29DF9B;
  }
}

getdroplocationnearcurrentcircle(_id_198A39D814FF0CC5) {
  location = undefined;

  if(isDefined(level.juggdroplocations) && level.juggdroplocations.size > 0) {
    foreach(_id_D1B5CD146DFE2EF9 in level.juggdroplocations) {
      if(!ispointnearcurrentsafecircle(_id_D1B5CD146DFE2EF9, _id_198A39D814FF0CC5)) {
        continue;
      }
      if(istrue(_id_D1B5CD146DFE2EF9.occupied)) {
        continue;
      }
      if(isnearajuggdrop(_id_D1B5CD146DFE2EF9.origin)) {
        continue;
      }
      if(isnearactivejugg(_id_D1B5CD146DFE2EF9.origin)) {
        continue;
      }
      location = _id_D1B5CD146DFE2EF9;
      _id_D1B5CD146DFE2EF9.occupied = 1;
      break;
    }

    if(!isDefined(location))
      location = createjuggdroplocation();
  } else {
    _id_6A30A32F2C392DC2 = undefined;
    location = createjuggdroplocation(_id_6A30A32F2C392DC2);
  }

  return location;
}

ispointnearcurrentsafecircle(_id_D1B5CD146DFE2EF9, _id_198A39D814FF0CC5) {
  if(level.br_circle_disabled || !isDefined(level.br_circle) || level.br_circle.circleindex < 0)
    return 1;

  _id_ADD4FD7502A75A8A = _id_2695A20D4011076D::getsafecircleorigin();
  _id_77E882DA07E78CFE = _id_2695A20D4011076D::getsafecircleradius();
  _id_636C8575D7A7768B = _id_77E882DA07E78CFE + _id_198A39D814FF0CC5;
  _id_4F0FC1C36324AFFB = _id_636C8575D7A7768B * _id_636C8575D7A7768B;

  if(distance2dsquared(_id_D1B5CD146DFE2EF9.origin, _id_ADD4FD7502A75A8A) <= _id_4F0FC1C36324AFFB)
    return 1;

  return 0;
}

isnearajuggdrop(_id_76A22C18960F72AF) {
  _id_636C8575D7A7768B = getdvarint("dvar_7ED2E5C3764AFC91", 20000);
  _id_4F0FC1C36324AFFB = _id_636C8575D7A7768B * _id_636C8575D7A7768B;

  foreach(_id_920F4173513EB6B8 in level.c130successfulairdrops) {
    if(distance2dsquared(_id_76A22C18960F72AF, _id_920F4173513EB6B8.origin) < _id_4F0FC1C36324AFFB)
      return 1;
  }

  return 0;
}

isnearactivejugg(_id_76A22C18960F72AF) {
  _id_F05A4EE85B3F1451 = _id_2695A20D4011076D::getsafecircleradius();
  mindistance = int(_id_F05A4EE85B3F1451 - _id_F05A4EE85B3F1451 / 3);
  mindistancesq = mindistance * mindistance;

  foreach(_id_E21279FA90BDF012 in level.activejuggernauts) {
    if(isDefined(_id_E21279FA90BDF012) && distance2dsquared(_id_76A22C18960F72AF, _id_E21279FA90BDF012.origin) < mindistancesq)
      return 1;
  }

  return 0;
}

createjuggdroplocation(_id_6A30A32F2C392DC2) {
  _id_565CDE9E77EA668E = spawnStruct();

  if(isDefined(_id_6A30A32F2C392DC2))
    _id_565CDE9E77EA668E.origin = _id_6A30A32F2C392DC2;
  else {
    _id_029EB8E710B40174 = 10;

    while(!isDefined(_id_565CDE9E77EA668E.origin)) {
      _id_42C3DDAAE2ED9962 = _id_2695A20D4011076D::getrandompointinboundssafecircle();

      if(isDefined(level.activejuggernauts) && level.activejuggernauts.size > 0) {
        if(!isnearactivejugg(_id_42C3DDAAE2ED9962))
          _id_565CDE9E77EA668E.origin = _id_42C3DDAAE2ED9962;
      } else
        _id_565CDE9E77EA668E.origin = _id_42C3DDAAE2ED9962;

      _id_029EB8E710B40174--;

      if(_id_029EB8E710B40174 == 0 && !isDefined(_id_565CDE9E77EA668E.origin))
        _id_565CDE9E77EA668E.origin = _id_42C3DDAAE2ED9962;

      waitframe();
    }
  }

  return _id_565CDE9E77EA668E;
}

showdroplocations(_id_FDFC755D4AA965C6, _id_535E20B358BFDD66) {
  level endon("game_ended");
  _id_198A39D814FF0CC5 = 50000;

  if(istrue(_id_535E20B358BFDD66)) {
    if(!istrue(level.br_circle_disabled))
      level waittill("br_circle_set");
  } else
    _id_198A39D814FF0CC5 = 0;

  droplocations = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FDFC755D4AA965C6; _id_AC0E594AC96AA3A8++) {
    dropcircle = getdroplocationnearcurrentcircle(_id_198A39D814FF0CC5);
    dropcircle.beacon = spawn("script_model", dropcircle.origin);
    dropcircle.beacon setModel("ks_airdrop_crate_br");
    dropcircle.beacon setscriptablepartstate("jugg_drop_beacon", "on", 0);
    dropcircle scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Juggernaut_Br", dropcircle.origin, 5000);
    dropcircle scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
    droplocations[droplocations.size] = dropcircle;
  }

  return droplocations;
}

startdeliveries(droplocations, source) {
  level endon("game_ended");
  scripts\mp\hud_util::showsplashtoall("br_juggdrop_incoming");

  foreach(index, dropcircle in droplocations) {
    level thread dropdeliveryatpos(dropcircle, source);
    wait(randomfloatrange(5.0, 10.0));
  }
}

dropdeliveryatpos(dropcircle, source) {
  level endon("game_ended");

  if(!isDefined(dropcircle.dropradius))
    dropcircle.dropradius = 5000;

  droppoint = _id_2695A20D4011076D::getrandompointinboundscircle(dropcircle.origin, dropcircle.dropradius);
  pathstruct = _id_2E385BC294259245::c130airdrop_createpath(undefined, droppoint, 1);
  dist = distance(pathstruct.startpt, pathstruct.endpt);
  travelspeed = _id_45B2B4A889E633FA::getc130speed();
  time = dist / travelspeed;
  _id_184D0A0CE31A2B27 = _id_2E385BC294259245::c130airdrop_spawn(pathstruct, dist, travelspeed, time);
  _id_184D0A0CE31A2B27.dropfunc = ::dropfunc;
  _id_184D0A0CE31A2B27.source = source;
  _id_184D0A0CE31A2B27 _id_2E385BC294259245::c130airdrop_startdelivery(1, "battle_royale_juggernaut", "jugg_world", dropcircle);
}

dropfunc(_id_5EE94AE126526F2F, _id_958BBDFED6F2E9EF, _id_FE41BE11A71DC1B4, dropcircle) {
  _id_0BD34ECAC3ADA85B = self.startpt;
  droppoint = self.centerpt;
  _id_5D55352ED330471C = self.speed;
  _id_800DF1B7C6E3AA60 = distance2d(_id_0BD34ECAC3ADA85B, droppoint) / _id_5D55352ED330471C;
  numcrates = 0;
  _id_71CAC1D48AB1C488 = 0;

  for(level.numactivejuggdrops = level.numactivejuggdrops + _id_5EE94AE126526F2F; numcrates < _id_5EE94AE126526F2F; _id_EF5D5141FDB51174.usetimeoverride = getcrateusetime()) {
    wait(_id_800DF1B7C6E3AA60);
    _id_76A22C18960F72AF = _id_2E385BC294259245::c130airdrop_findvaliddroplocation(self.origin, 1);
    crate = scripts\cp_mp\killstreaks\airdrop::dropbrc130airdropcrate(_id_76A22C18960F72AF + (0, 0, level.c130airdrop_heightoverride - 100), _id_76A22C18960F72AF, self.angles, _id_958BBDFED6F2E9EF, _id_FE41BE11A71DC1B4, dropcircle.nodropanim);
    numcrates++;
    crate.dropcircle = dropcircle;
    crate.source = self.source;
    level.c130successfulairdrops[level.c130successfulairdrops.size] = crate;
    _id_EF5D5141FDB51174 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(crate);
  }
}

watchoverheat(juggconfig) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  _id_0BDB24132E9115BA = juggconfig.overheatlimit;
  _id_E5DB17EE1E28C03A = juggconfig.overheatcooldown;
  juggconfig.heatcounter = 0;

  for(;;) {
    self waittill("weapon_fired");
    juggconfig.heatcounter++;
    juggconfig.lastheatupdate = gettime();

    if(juggconfig.heatcounter >= _id_0BDB24132E9115BA) {
      iprintlnbold("OVERHEAT");
      _id_3B64EB40368C1450::set("overheat_cooldown", "fire", 0);
      wait(_id_E5DB17EE1E28C03A);
      iprintlnbold("COOLDOWN");
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("overheat_cooldown");
    }
  }
}

watchheatreduction(juggconfig) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  _id_0259C36B6504EA39 = juggconfig.overheatreductiontime;
  _id_BDCE3F3A4859B442 = juggconfig.overheatreductionrate;
  _id_D04FF08506EDE63C = juggconfig.overheatreductionamount;

  for(;;) {
    if(juggconfig.heatcounter > 0 && gettime() - juggconfig.lastheatupdate >= _id_0259C36B6504EA39 * 1000) {
      _id_F8F916A03AFFA77B = juggconfig.heatcounter - _id_BDCE3F3A4859B442;

      if(_id_F8F916A03AFFA77B < 0)
        _id_F8F916A03AFFA77B = 0;

      juggconfig.heatcounter = int(_id_F8F916A03AFFA77B);
    }

    wait 0.05;
  }
}

mangagedeathsdoor(juggconfig) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  _id_37329A37EF4DD878 = 5;

  for(;;) {
    result = scripts\engine\utility::waittill_any_return_2("deaths_door_enter", "jugg_health_regen");
    _id_6DCFCE39980A28B6 = 1;

    if(result == "deaths_door_enter") {
      _id_6DCFCE39980A28B6 = 0;
      self.ignoredeathsdoor = 1;
      wait(_id_37329A37EF4DD878);
    } else if(result == "jugg_health_regen") {
      healthratio = self.health / self.maxhealth;

      if(healthratio >= 0.75) {
        if(istrue(self.ignoredeathsdoor))
          self.ignoredeathsdoor = undefined;
      }
    }

    _id_6A5D3BF7A5B7064A::onexitdeathsdoor(_id_6DCFCE39980A28B6);
  }
}

droponplayerdeath(dropstruct) {
  _id_362C58E8BB39BCDA::runbrgametypefunc("onJuggDropOnDeath", dropstruct);
  level.numactivejuggdrops--;
}

dropjuggbox() {
  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 1, 1);
  _id_0DB1541018D7BADF = scripts\engine\trace::ray_trace(self.origin + (0, 0, 40), self.origin - (0, 0, 10000), self, contentoverride);
  dropposition = self.origin;

  if(isDefined(_id_0DB1541018D7BADF) && isDefined(_id_0DB1541018D7BADF["hittype"]) && _id_0DB1541018D7BADF["hittype"] != "hittype_none")
    dropposition = _id_0DB1541018D7BADF["position"];

  crate = scripts\cp_mp\killstreaks\airdrop::dropbrc130airdropcrate(self.origin + (0, 0, 10), dropposition, self.angles, "battle_royale_juggernaut", "jugg_world");

  if(isDefined(crate)) {
    _id_EF5D5141FDB51174 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(crate);
    _id_EF5D5141FDB51174.usetimeoverride = getcrateusetime();
  }
}

oncrateactivate(_id_D9BC1B05D016A86F) {
  _id_362C58E8BB39BCDA::runbrgametypefunc("onJuggCrateActivate", _id_D9BC1B05D016A86F);

  if(istrue(_id_D9BC1B05D016A86F)) {
    thread watchcratetimeout();
    thread watchcrategastimeout();
  }
}

watchcratetimeout() {
  self endon("death");
  _id_38D091F0777ED28F = getdvarint("dvar_4B258E12BBF733E3", 300);
  wait(_id_38D091F0777ED28F);
  scripts\cp_mp\killstreaks\airdrop::destroycrate();
}

watchcrategastimeout() {
  self endon("death");

  if(istrue(level.br_circle_disabled)) {
    return;
  }
  _id_798752CAFEB221EC = getdvarint("dvar_14531681AB16F185", 30);

  for(;;) {
    wait 0.05;

    if(!isDefined(level.br_circle) || level.br_circle.circleindex < 0) {
      continue;
    }
    _id_819EDACDACB810E4 = _id_2695A20D4011076D::getdangercircleorigin();
    _id_E86632D645C137D0 = _id_2695A20D4011076D::getdangercircleradius();

    if(distance2dsquared(_id_819EDACDACB810E4, self.origin) > _id_E86632D645C137D0 * _id_E86632D645C137D0) {
      break;
    }
  }

  wait(_id_798752CAFEB221EC);
  scripts\cp_mp\killstreaks\airdrop::destroycrate();
}

oncrateuse(player) {
  player.jugg_source = self.source;
  _id_362C58E8BB39BCDA::runbrgametypefunc("onJuggCrateUse", player);
  notifycapturetoplayers(player);
  cratecleanup();
}

notifycapturetoplayers(owner) {
  notifyorigin = self.origin;
  _id_89C35EB8C5FACCED = 5000;
  playersinrange = scripts\common\utility::playersincylinder(notifyorigin, _id_89C35EB8C5FACCED);

  foreach(player in playersinrange) {
    if(isDefined(player) && scripts\mp\utility\player::isreallyalive(player) && player != owner) {
      _id_90E6BC3A37537C77 = "br_jugg_capture_positive";

      if(player.team != owner.team)
        _id_90E6BC3A37537C77 = "br_jugg_capture_negative";

      player playlocalsound(_id_90E6BC3A37537C77);
    }
  }
}

oncratedestroy(immediate) {
  _id_362C58E8BB39BCDA::runbrgametypefunc("onJuggCrateDestroy", immediate);
  level.numactivejuggdrops--;
  cratecleanup();
}

cratecleanup() {
  if(isDefined(self.dropcircle)) {
    self.dropcircle.occupied = 0;
    self.dropcircle scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();

    if(isDefined(self.dropcircle.beacon)) {
      self.dropcircle.beacon setscriptablepartstate("jugg_drop_beacon", "off");
      self.dropcircle.beacon delete();
    }
  }

  if(isDefined(level.c130successfulairdrops))
    level.c130successfulairdrops = scripts\engine\utility::array_remove(level.c130successfulairdrops, self);
}

init_br_jugg_setting(name, value, source) {
  if(!isDefined(source))
    source = "default";

  if(!isDefined(level.brjuggsettings[source]))
    level.brjuggsettings[source] = [];

  level.brjuggsettings[source][name] = value;
}

get_br_jugg_setting(name, source) {
  value = undefined;

  if(isDefined(source)) {
    if(isDefined(level.brjuggsettings[source]))
      value = level.brjuggsettings[source][name];
  }

  if(!isDefined(value))
    value = level.brjuggsettings["default"][name];

  return value;
}

getcrateusetime() {
  return getdvarfloat("dvar_4C96C13074CF77E5", 5);
}

getnumdrops() {
  return getdvarint("scr_br_jugg_num_drops", 3);
}

getjuggdamagescale() {
  return getdvarfloat("dvar_90FB266842B5BC2A", 1.0);
}

getminigundamagescale() {
  return getdvarfloat("dvar_A9E8E75FB57047AA", 1.25);
}