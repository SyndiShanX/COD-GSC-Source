/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\helicopter_pilot.gsc
***********************************************/

init() {
  level.heli_pilot = [];
  level.helipilotsettings = [];
  level.helipilotsettings["_encstr_9B100BD059D8A5D7C1B4C6B7D1"] = spawnStruct();
  level.helipilotsettings["_encstr_9B100BD059D8A5D7C1B4C6B7D1"].timeout = 60.0;
  level.helipilotsettings["_encstr_9B100BD059D8A5D7C1B4C6B7D1"].maxhealth = 2000;
  level.helipilotsettings["_encstr_9B100BD059D8A5D7C1B4C6B7D1"].streakname = "_encstr_9B100BD059D8A5D7C1B4C6B7D1";
  level.helipilotsettings["_encstr_9B100BD059D8A5D7C1B4C6B7D1"].vehicleinfo = "_encstr_91080E2195F5A048234A582083C71920";
  level.helipilotsettings["_encstr_9B100BD059D8A5D7C1B4C6B7D1"].modelbase = "_encstr_B2441BF339A33F46C063EFD90350013EF6F2F9AA2D09E3BAD875CDA10F";
  level.helipilotsettings["_encstr_9B100BD059D8A5D7C1B4C6B7D1"].teamsplash = "_encstr_A6AA1043D7CFCBC092270A4F897B24700A59";
  helipilot_setairstartnodes();
  level.heli_pilot_mesh = scripts\cp_mp\utility\game_utility::getlocaleent("_encstr_8A8E10B1F7A2D391702CF06893C7C81D8B6B");

  if(!isDefined(level.heli_pilot_mesh)) {} else
    level.heli_pilot_mesh.origin = level.heli_pilot_mesh.origin + scripts\mp\utility\killstreak::gethelipilotmeshoffset();

  var_0 = spawnStruct();
  var_0.scorepopup = "_encstr_9BA1150B532ED3E2F0AA276F86203D8A888FE3B7D9589B";
  var_0.vodestroyed = undefined;
  var_0.callout = "_encstr_91441DFFD75A09B2753359A9535783FD7F73FDC951681B914260888BF8C769";
  var_0.samdamagescale = 0.09;
  var_0.enginevfxtag = "_encstr_A32511E37AF7C848C53F839525E1B8AB8F827B";
  level.heliconfigs["_encstr_9B100BD059D8A5D7C1B4C6B7D1"] = var_0;
}

tryusehelipilot(var_0, var_1) {
  var_2 = "_encstr_9B100BD059D8A5D7C1B4C6B7D1";
  var_3 = 1;

  if(isDefined(self.underwater) && self.underwater)
    return 0;
  else if(exceededmaxhelipilots(self.team)) {
    self iprintlnbold(&"_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");
    return 0;
  } else if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + var_3 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    self iprintlnbold(&"_encstr_8E8B1E17AB11F063896F4F466499D7A9784FBF8723A8E937E195345C9DB98591");
    return 0;
  }

  scripts\mp\utility\killstreak::incrementfauxvehiclecount();
  var_4 = createhelipilot(var_2);

  if(!isDefined(var_4)) {
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();
    return 0;
  }

  level.heli_pilot[self.team] = var_4;
  var_5 = starthelipilot(var_4);

  if(!isDefined(var_5))
    var_5 = 0;

  return var_5;
}

exceededmaxhelipilots(var_0) {
  if(scripts\mp\utility\game::getgametype() == "_encstr_9707038CB6") {
    if(isDefined(level.heli_pilot[var_0]) || isDefined(level.heli_pilot[scripts\mp\utility\game::getotherteam(var_0)[0]]))
      return 1;
    else
      return 0;
  } else if(isDefined(level.heli_pilot[var_0]))
    return 1;
  else
    return 0;
}

watchhostmigrationfinishedinit(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    level waittill("_encstr_85A51314B8F75347B068B7FB30CB39AAB5D8DF0D95");
    var_0 setclientomnvar("_encstr_976B0EE5091F68A375E281831A8D7F23", 1);
  }
}

createhelipilot(var_0) {
  var_1 = helipilot_getcloseststartnode(self.origin);
  var_2 = helipilot_getlinkedstruct(var_1);
  var_3 = vectortoangles(var_2.origin - var_1.origin);
  var_4 = anglesToForward(self.angles);
  var_5 = var_2.origin + var_4 * -100;
  var_6 = var_1.origin;
  var_7 = spawnhelicopter(self, var_6, var_3, level.helipilotsettings[var_0].vehicleinfo, level.helipilotsettings[var_0].modelbase);

  if(!isDefined(var_7)) {
    return;
  }
  var_7 makevehiclesolidcapsule(18, -9, 18);
  var_7 scripts\mp\utility\killstreak::addtolittlebirdlist(var_7 getentitynumber());
  var_7 thread scripts\mp\utility\killstreak::removefromlittlebirdlistondeath(var_7 getentitynumber());
  var_7.maxhealth = level.helipilotsettings[var_0].maxhealth;
  var_7.speed = 40;
  var_7.owner = self;
  var_7 setotherent(self);
  var_7.team = self.team;
  var_7.helitype = "_encstr_A3780B731385FBD498E1FC0219";
  var_7.helipilottype = "_encstr_9B100BD059D8A5D7C1B4C6B7D1";
  var_7 setmaxpitchroll(45, 45);
  var_7 vehicle_setspeed(var_7.speed, 40, 40);
  var_7 setyawspeed(120, 60);
  var_7 setneargoalnotifydist(32);
  var_7 sethoverparams(100, 100, 100);
  var_7 scripts\mp\sentientpoolmanager::registersentient("_encstr_81860F1741A58ADBBB43D3B36C79AF3083", self);
  var_7.targetpos = var_5;
  var_7.currentnode = var_2;
  var_7.attract_strength = 10000;
  var_7.attract_range = 150;
  var_7.attractor = missile_createattractorent(var_7, var_7.attract_strength, var_7.attract_range);
  var_7 thread scripts\mp\killstreaks\helicopter::heli_damage_monitor("_encstr_9B100BD059D8A5D7C1B4C6B7D1");
  var_7 thread helipilot_lightfx();
  var_7 thread helipilot_watchtimeout();
  var_7 thread helipilot_watchownerloss();
  var_7 thread helipilot_watchroundend();
  var_7 thread helipilot_watchobjectivecam();
  var_7 thread helipilot_watchdeath();
  var_7 thread watchhostmigrationfinishedinit(self);
  var_7.owner scripts\common\utility::_id_13E0A(level._id_11B2A, level.helipilotsettings[var_7.helipilottype].streakname, var_7.targetpos);
  return var_7;
}

helipilot_lightfx() {
  playFXOnTag(level.chopper_fx["_encstr_8FA906CC80677438"]["_encstr_A5AD056A019C63"], self, "_encstr_92790F8B9BE4A13C4BA9242BC650773B4D");
  wait 0.05;
  playFXOnTag(level.chopper_fx["_encstr_8FA906CC80677438"]["_encstr_915E0613420DC132"], self, "_encstr_ABC910472CD9FAC6D2CE34D17D982B36B1F2");
  wait 0.05;
  playFXOnTag(level.chopper_fx["_encstr_8FA906CC80677438"]["_encstr_B1EF0591524C08"], self, "_encstr_8D8410AB57CF1FE02114D8C091712F487C06");
  wait 0.05;
  playFXOnTag(level.chopper_fx["_encstr_8FA906CC80677438"]["_encstr_B1EF0591524C08"], self, "_encstr_A58410E35A9F77FDA8E7D101909518781886");
}

starthelipilot(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  scripts\mp\utility\player::setusingremote(var_0.helipilottype);

  if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    scripts\mp\utility\player::setthirdpersondof(0);

  self.restoreangles = self.angles;
  var_0 thread scripts\mp\killstreaks\flares::ks_setup_manual_flares(2, "_encstr_8E5F0795E6AD7BAD2B", "_encstr_BA6019ED237E33D751C8897320B98D9BD61C4C71C641A79E6BF072", "_encstr_A2DA13AED27D3495B196D71CB48DBDE8FAEEB0399B");
  thread watchintrocleared(var_0);
  scripts\mp\utility\player::_freezecontrols(1);
  var_1 = scripts\mp\killstreaks\killstreaks::initridekillstreak(var_0.helipilottype);

  if(var_1 != "_encstr_88E30897BDF1B71F7823") {
    if(!scripts\common\utility::is_weapon_allowed())
      scripts\common\utility::allow_weapon(1);

    var_0 notify("_encstr_AD75063D571AE108");
    return 0;
  }

  scripts\mp\utility\player::_freezecontrols(0);
  var_2 = scripts\mp\utility\killstreak::gethelipilottraceoffset();
  var_3 = var_0.currentnode.origin + (scripts\mp\utility\killstreak::gethelipilotmeshoffset() + var_2);
  var_4 = var_0.currentnode.origin + (scripts\mp\utility\killstreak::gethelipilotmeshoffset() - var_2);
  var_5 = scripts\engine\trace::_bullet_trace(var_3, var_4, 0, undefined, 0, 0, 1);

  if(!isDefined(var_5["_encstr_850E077B0BF30318B9"])) {}

  var_6 = var_5["_encstr_BD260953AA97E3F014279D"] - scripts\mp\utility\killstreak::gethelipilotmeshoffset() + (0, 0, 250);
  var_7 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_6);
  self remotecontrolvehicle(var_0);
  var_0 thread heligotostartposition(var_7);
  var_0 thread helipilot_watchads();
  level thread scripts\mp\hud_util::teamplayercardsplash(level.helipilotsettings[var_0.helipilottype].teamsplash, self);
  var_0.killcament = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self getvieworigin());
  return 1;
}

heligotostartposition(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self remotecontrolvehicletarget(var_0);
  self waittill("_encstr_A3130D9AF069D2310E87C1D9C03A82");
  self remotecontrolvehicletargetoff();
  var_0 delete();
}

watchintrocleared(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_BEFD0E1BA6DB5008C78220098A5B3558");
  self setclientomnvar("_encstr_976B0EE5091F68A375E281831A8D7F23", 1);
  var_1 = scripts\mp\utility\outline::outlineenableforplayer(self, self, "_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190", "_encstr_85CE0B9770B02C73A1760F06D2");
  removeoutline(var_1, var_0);

  foreach(var_3 in level.participants) {
    if(!scripts\mp\utility\player::isreallyalive(var_3) || var_3.sessionstate != "_encstr_877508C1D8C22F2DDC3B") {
      continue;
    }
    if(scripts\mp\utility\player::isenemy(var_3)) {
      if(!var_3 scripts\mp\utility\perk::_hasperk("_encstr_B14C19CD07B28DB42C1BD1BCFADCDBC16385CBB29C8E2CC9EC561D")) {
        var_1 = scripts\mp\utility\outline::outlineenableforplayer(var_3, self, "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", "_encstr_85CE0B9770B02C73A1760F06D2");
        var_3 removeoutline(var_1, var_0);
        continue;
      }

      var_3 thread watchforperkremoval(var_0);
    }
  }

  var_0 thread watchplayersspawning();
  thread watchearlyexit(var_0);
}

watchforperkremoval(var_0) {
  self notify("_encstr_8C7614E311985BB20CF7EB5BDB3E4AA2C8781D2B89F0");
  self endon("_encstr_8C7614E311985BB20CF7EB5BDB3E4AA2C8781D2B89F0");
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_870B21627D7AF78BE98C81A6CF9DF6B1178D68DBAFBE17F88199589D7A63694B10AAA4");
  var_1 = scripts\mp\utility\outline::outlineenableforplayer(self, var_0.owner, "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", "_encstr_85CE0B9770B02C73A1760F06D2");
  removeoutline(var_1, var_0);
}

watchplayersspawning() {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_0);

    if(var_0.sessionstate == "_encstr_877508C1D8C22F2DDC3B" && self.owner scripts\mp\utility\player::isenemy(var_0))
      var_0 thread watchforperkremoval(self);
  }
}

removeoutline(var_0, var_1) {
  thread heliremoveoutline(var_0, var_1);
  thread playerremoveoutline(var_0, var_1);
}

heliremoveoutline(var_0, var_1) {
  self notify("_encstr_922512C12D3D59320D4F0FC4652FF7C825FB28C8");
  self endon("_encstr_922512C12D3D59320D4F0FC4652FF7C825FB28C8");
  self endon("_encstr_A1421008E3FB6198DE3F590807E5909D324F");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = ["_encstr_BA2D081B2B58B32D37EC", "_encstr_AD75063D571AE108"];
  var_1 scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_2);

  if(isDefined(self)) {
    scripts\mp\utility\outline::outlinedisable(var_0, self);
    self notify("_encstr_A1421008E3FB6198DE3F590807E5909D324F");
  }
}

playerremoveoutline(var_0, var_1) {
  self notify("_encstr_9BE9145B389B08C7036E255598EB8FDDEB502242B07B");
  self endon("_encstr_9BE9145B389B08C7036E255598EB8FDDEB502242B07B");
  self endon("_encstr_A1421008E3FB6198DE3F590807E5909D324F");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = ["_encstr_AD75063D571AE108"];
  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_2);
  scripts\mp\utility\outline::outlinedisable(var_0, self);
  self notify("_encstr_A1421008E3FB6198DE3F590807E5909D324F");
}

helipilot_watchdeath() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8772059DDEDCAC");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.owner))
    self.owner helipilot_endride(self);

  if(isDefined(self.killcament))
    self.killcament delete();

  thread scripts\mp\killstreaks\helicopter::lbonkilled();
}

helipilot_watchobjectivecam() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8772059DDEDCAC");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  level waittill("_encstr_BE2B0E376618C796A1085B62D1E74EBF");
  thread scripts\mp\killstreaks\helicopter::lbonkilled();

  if(isDefined(self.owner))
    self.owner helipilot_endride(self);
}

helipilot_watchtimeout() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  var_0 = level.helipilotsettings[self.helipilottype].timeout;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  thread helipilot_leave();
}

helipilot_watchownerloss() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self.owner scripts\engine\utility::_id_143A6("_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  thread helipilot_leave();
}

helipilot_watchroundend() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self.owner endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  level scripts\engine\utility::_id_143A5("_encstr_85571343573D62E481D9F57FB66021DA9BC7B39739", "_encstr_9B1D0BC7932875276230426AA1");
  thread helipilot_leave();
}

helipilot_leave() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_BA2D081B2B58B32D37EC");

  if(isDefined(self.owner))
    self.owner helipilot_endride(self);

  var_0 = self.origin + (0, 0, 850);
  self vehicle_setspeed(140, 60);
  self setmaxpitchroll(45, 180);
  self setvehgoalpos(var_0);
  self waittill("_encstr_8B7205D9ED5958");
  var_0 = var_0 + anglesToForward(self.angles) * 15000;
  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0);

  if(isDefined(var_1)) {
    self setlookatent(var_1);
    var_1 thread wait_and_delete(3.0);
  }

  self setvehgoalpos(var_0);
  self waittill("_encstr_8B7205D9ED5958");
  self notify("_encstr_8772059DDEDCAC");
  scripts\mp\killstreaks\helicopter::removelittlebird();
}

wait_and_delete(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_0);
  self delete();
}

helipilot_endride(var_0) {
  if(isDefined(var_0)) {
    self setclientomnvar("_encstr_976B0EE5091F68A375E281831A8D7F23", 0);
    var_0 notify("_encstr_920E0BE7880931BA61B86733C0");

    if(scripts\mp\utility\player::isusingremote())
      scripts\mp\utility\player::clearusingremote();

    if(getdvarint("_encstr_82570B397A4D3192935192A562"))
      scripts\mp\utility\player::setthirdpersondof(1);

    self remotecontrolvehicleoff(var_0);
    self setplayerangles(self.restoreangles);
    thread helipilot_freezebuffer();
  }
}

helipilot_freezebuffer() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\utility\player::_freezecontrols(1);
  wait 0.5;
  scripts\mp\utility\player::_freezecontrols(0);
}

helipilot_watchads() {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0;

  for(;;) {
    if(isDefined(self.owner)) {
      if(self.owner adsButtonPressed()) {
        if(!var_0) {
          self.owner setclientomnvar("_encstr_976B0EE5091F68A375E281831A8D7F23", 2);
          var_0 = 1;
        }
      } else if(var_0) {
        self.owner setclientomnvar("_encstr_976B0EE5091F68A375E281831A8D7F23", 1);
        var_0 = 0;
      }
    }

    wait 0.1;
  }
}

helipilot_setairstartnodes() {
  level.air_start_nodes = scripts\engine\utility::getStructArray("_encstr_8CEF181FB00D50F75FE356F95A6F2E71621189811FF2B8B73B9B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

helipilot_getlinkedstruct(var_0) {
  if(isDefined(var_0.script_linkto)) {
    var_1 = var_0 scripts\engine\utility::get_links();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = scripts\engine\utility::getStruct(var_1[var_2], "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2");

      if(isDefined(var_3))
        return var_3;
    }
  }

  return undefined;
}

helipilot_getcloseststartnode(var_0) {
  var_1 = undefined;
  var_2 = 999999;

  foreach(var_4 in level.air_start_nodes) {
    var_5 = distance(var_4.origin, var_0);

    if(var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

watchearlyexit(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_0 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  var_0 waittill("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");
  var_0 thread helipilot_leave();
}