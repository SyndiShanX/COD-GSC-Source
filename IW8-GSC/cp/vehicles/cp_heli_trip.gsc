/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\cp_heli_trip.gsc
***********************************************/

start_heli_trip_sequence(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  initanims();
  level.heli_trip_vehicle = spawn_chopper(var_0, var_1);
  level.heli_trip_vehicle scripts\cp\infilexfil\blima_exfil::go_to_exfil_location(level.heli_trip_vehicle.exfil_struct, 1);
  level.heli_trip_vehicle thread wait_for_passengers(var_3);
  level.heli_trip_vehicle scripts\engine\utility::_id_143A5("_encstr_84B715C263D8BE38B158E5CAE4B9EB7B377D89F6C23991", "_encstr_829314BC09C0C969AD752F43C755F23560B1F9C5A358");

  if(isDefined(level.heli_trip_vehicle))
    destroynavobstacle(level.heli_trip_vehicle.navobstacle);

  level notify("_encstr_99D81368CB605C77355B8A23C60DFF955BD717EE55");
  level.heli_trip_vehicle notify("_encstr_AD0E1041F595C028536A184082C7E038AF4E");
  level.heli_trip_vehicle scripts\common\vehicle_paths::vehicle_paths_helicopter(var_2);
  level.heli_trip_vehicle notify("_encstr_81A8077D3088BFA631");
  level notify("_encstr_8EEB0F11A5A5F018638B889361374458FA");
  wait 2;
  level.heli_trip_vehicle thread exit_map();
  level.helitrip_next_rig_num = undefined;
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

playerpassengerthink(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  var_1 = "_encstr_A30D0B30D3708180E951D37165";

  switch (var_0) {
    case "_encstr_8D30066E2BB0D113":
      var_1 = "_encstr_A30D0B30D3708180E951D37165";
      break;
    case "_encstr_AF3006C31D817B2A":
      var_1 = "_encstr_930D0BB31F7F41CB11C81BAF42";
      break;
    case "_encstr_9A30069BCAC649C3":
      var_1 = "_encstr_910D0BD951F7D19EB70A9BE647";
      break;
    case "_encstr_8C3006B9ACC21D0D":
      var_1 = "_encstr_8F0D0BA3C2D9FA6EB216D1D7D4";
      break;
  }

  self disableusability();
  self allowmelee(0);
  self disableoffhandweapons();
  self.try_to_punish_with_jugg = 1;
  raid_seq4_objectives_func();

  if(scripts\cp\utility::riotshield_hasweapon())
    self.clearsixthsense = 1;

  scripts\cp\cp_weapons::_id_13A3A(self);
  thread scripts\cp\cp_outofbounds::enableoobimmunity(self);
  thread create_player_rig(self, "_encstr_8BB007E03658CBCAE4");
  scripts\common\anim::anim_first_frame_solo(self.player_rig, "_encstr_A3F80CBD34249D581E0F056B1773");
  link_player_to_rig(self, 0.4);
  self.player_rig.weapon_state_func = scripts\cp\cp_infilexfil::handleweaponstatenotetrackcp;
  level.heli_trip_vehicle thread scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "_encstr_A3F80CBD34249D581E0F056B1773", var_1);
  wait(getanimlength(%_encstr_A9801F50C990BF4FF348E333C039F8D33A0F63B0C1CF82898B089AB1E7D2B3C8E0));
  self.player_rig linkTo(level.heli_trip_vehicle, "_encstr_9AD01136187923E791B06F67D06B9509DD203B", (0, 0, 0), (0, 0, 0));
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 30, 30);
  self.inchopper = 1;
  level notify("_encstr_8D8D174803C98FFDF972B780F3FF207BF2310FBDA1C3B4F0AF");
  level.heli_trip_vehicle notify("_encstr_935A14831B165EAC9CFA31ED2C9C91CA91AF342B1B5A");
  thread _id_144C2();
  thread rideloop(var_1);
  level.heli_trip_vehicle waittill("_encstr_81A8077D3088BFA631");
  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  self stopanimscriptsceneevent();
  self notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
  self stopviewmodelanim();
  self enableusability();
  self allowmelee(1);
  self enableoffhandweapons();
  self.try_to_punish_with_jugg = 0;
  thread scripts\cp\cp_outofbounds::disableoobimmunity(self);
  scripts\cp\cp_infilexfil::takegunlesscp();

  if(istrue(self.clearsixthsense)) {
    var_2 = getcompleteweaponname("_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1");
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2, undefined, undefined, 1);
    scripts\cp\cp_weapon::riotshieldonweaponchange();
    self.clearsixthsense = undefined;
  }

  self.inchopper = undefined;
}

raid_seq4_objectives_func() {
  if(scripts\cp\cp_weapon::_id_124AD(self)) {
    scripts\cp\cp_weapon::minigamefinishcount(self);
    var_0 = undefined;
    var_1 = self getweaponslistprimaries();

    foreach(var_3 in var_1) {
      if(nullweapon(var_3)) {
        continue;
      }
      if(scripts\cp\utility::isriotshield(var_3))
        continue;
      else if(!isDefined(var_0)) {
        var_4 = var_3 getnoaltweapon();

        if(var_4.inventorytype != "_encstr_BA7F0830B3A7859B60B0") {
          continue;
        }
        var_0 = var_3;
      }
    }

    if(isDefined(var_0))
      childthread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var_0);
  }
}

#using_animtree("_encstr_B40101");

create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }
  var_0.animname = var_1;

  if(!isDefined(var_2))
    var_2 = "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A";

  var_0 predictstreampos(var_0.origin);
  var_3 = spawn("_encstr_BEFE0C2FAB5A88876B4181EB4A5F", var_0.origin, 0, 0, var_0);
  var_3.player = var_0;
  var_0.player_rig = var_3;
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0.player_rig.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  var_0 watch_remove_rig();
  remove_player_rig(var_0);
}

watch_remove_rig(var_0) {
  scripts\engine\utility::_id_143A6("_encstr_BE840BF2FFD8B0A4DB6EE31FA1", "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");
}

remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }
  var_0 unlink();
  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

link_player_to_rig(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0.2;

  var_0 playerlinktoblend(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", var_1, 0.25, 0.25);
  wait(var_1);
  var_0 playerlinktodelta(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 1, 1, 1);
}

rideloop(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  level.heli_trip_vehicle endon("_encstr_81A8077D3088BFA631");

  for(;;)
    level.heli_trip_vehicle scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "_encstr_AFB50B8690507502A0DB934B3B", var_0);
}

_id_144C2() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level.heli_trip_vehicle endon("_encstr_AD0E1041F595C028536A184082C7E038AF4E");

  for(;;) {
    wait 10;
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "_encstr_BD720EA70D981947EB11722A1EC88FCF");
  }
}

get_player_rig() {
  if(!isDefined(level.next_rig_num))
    level.helitrip_next_rig_num = 0;

  level.helitrip_next_rig_num++;
  level.helitrip_next_rig_num = clamp(level.helitrip_next_rig_num, 1, 4);
  return "_encstr_82180596773AC1" + level.helitrip_next_rig_num;
}

load_hvt(var_0) {
  scripts\cp\cp_pickup_hostage::init_anims();
  var_1 = self;
  var_1.vip = var_0.hostagecarried;

  if(!isDefined(var_1.spawnintermissionatplayer))
    var_1.spawnintermissionatplayer = "_encstr_A5AD056A019C63";

  scripts\cp\cp_pickup_hostage::load_hvt(var_0, var_1, var_1.spawnintermissionatplayer);
  level thread loscheckpassed(var_0);
}

loscheckpassed(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(istrue(level.validatealivecount))
    wait 1;

  wait(level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_8A930C97AA68995BEA3B7D4B225B"));
  level notify("_encstr_992621097A3728DDB2DF3F615B0A9F49AF5690062275388D6BF7B12F733270D877ADF9");
}

all_alive_players_in_chopper() {
  var_0 = 0;
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_3))
      var_1++;

    if(istrue(var_3.inchopper))
      var_0++;
  }

  return var_0 > 0 && level.players.size == var_0 + var_1;
}

isvalidplayer(var_0) {
  if(!isPlayer(self))
    return 0;

  if(!isDefined(self))
    return 0;

  if(!isDefined(var_0) && scripts\cp\cp_laststand::player_in_laststand(self))
    return 0;

  if(!isalive(self))
    return 0;

  if(self.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    return 0;

  return 1;
}

wait_for_all_players_ready() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.heli_trip_vehicle endon("_encstr_84B715C263D8BE38B158E5CAE4B9EB7B377D89F6C23991");
  level.heli_trip_vehicle endon("_encstr_829314BC09C0C969AD752F43C755F23560B1F9C5A358");

  for(;;) {
    if(all_alive_players_in_chopper()) {
      level.heli_trip_vehicle notify("_encstr_84B715C263D8BE38B158E5CAE4B9EB7B377D89F6C23991");
      return;
    }

    wait 0.1;
  }
}

spawn_chopper(var_0, var_1) {
  var_2 = scripts\common\vehicle::vehicle_spawn(var_0);
  var_2.vehicle_skipdeathmodel = 1;
  var_2.script_disconnectpaths = 0;
  var_2.death_fx_on_self = 1;
  var_2.exfil_struct = var_1;
  var_1.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(var_1.origin, 1);
  scripts\cp\infilexfil\blima_exfil::spawn_vehicle_actors(var_2);
  var_2.godmode = 1;
  var_2.health = 10000;
  var_2.maxhealth = 10000;
  var_2.team = "_encstr_9A8507BA4040188D08";
  var_2.script_team = "_encstr_9A8507BA4040188D08";
  var_2 setvehicleteam("_encstr_9A8507BA4040188D08");
  var_2 setCanDamage(0);
  var_2 spawnhelihvtexfilactors();

  if(isDefined(var_2.wmexfilally)) {
    if(!isDefined(var_2.actors))
      var_2.actors = [];

    var_2.actors[var_2.actors.size] = var_2.wmexfilally;
  }

  var_2.headicon = deleteheadicon(var_2);
  setheadiconfriendlyimage(var_2.headicon, "_encstr_A62C214CED91A9090910CB07C021F9E20F0D92835BE1C24DF0F0171B0898B50AC11118");
  setheadiconsnaptoedges(var_2.headicon, 12000);
  setheadiconmaxdistance(var_2.headicon, 1500);
  addclienttoheadiconmask(var_2.headicon, 10);
  setheadicondrawthroughgeo(var_2.headicon, 1);
  return var_2;
}

spawnhelihvtexfilactors(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = "_encstr_96F32AA6F70BB21FFDAB49BB921231493B6EA02C598BF9812782C039ABAFF7A33709BE08F9972B8F4D8A8042";

  if(!isDefined(var_1))
    var_1 = "_encstr_929517C8C9AF69680841E357B8AEC930103FB63BAE085B5988";

  var_2 = self;
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_3 setModel("_encstr_9AC718AB8029F13F41290B6854A584408CC3C15D3EEFBBEB8F02");
  var_3 useanimtree(level.scr_animtree["_encstr_B6F40B8D18B3B74D9970991A8A"]);
  var_3.animname = "_encstr_B6F40B8D18B3B74D9970991A8A";
  var_4 = getstartorigin(var_2.origin, var_2.angles, level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_852E15EA4C97655A0F384EBF5AAF0CA7B21520B50F738E"]);
  var_5 = getstartangles(var_2.origin, var_2.angles, level.scr_anim["_encstr_B6F40B8D18B3B74D9970991A8A"]["_encstr_852E15EA4C97655A0F384EBF5AAF0CA7B21520B50F738E"]);
  var_3.origin = var_4;
  var_3.angles = var_5;
  var_3 linkTo(var_2);
  var_2.wmexfilally = var_3;
  var_2 thread idle_exfilally_loop(var_3);
}

idle_exfilally_loop(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8EC80FCDD17B387DA5918D56EB16CD4BDA");

  for(;;)
    scripts\common\anim::anim_single_solo(var_0, "_encstr_852E15EA4C97655A0F384EBF5AAF0CA7B21520B50F738E", "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

wait_for_passengers(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self solid();
  self.navobstacle = createnavobstaclebybounds(self.origin, (350, 350, 350), (0, 0, 0), "_encstr_8E8405EA382B2A");

  if(istrue(var_0)) {
    heli_rpg_enemy_think(self);
    waitforhvtonboard();
    level.heli_trip_vehicle _id_1212D(level.heli_trip_vehicle);
  }

  startplayerboarding();
}

_id_13BC7(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_121FB)) {
    var_1._id_121FB = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin - (0, 0, 100));
    var_1._id_121FB.angles = scripts\engine\utility::ter_op(isDefined(var_1.angles), var_1.angles, (0, 0, 0));
    var_1._id_121FB hide();
    var_1._id_121FB setModel(var_1.model);
  }

  if(var_0) {
    var_1._id_121FB connectpaths();
    var_1._id_121FB delete();
    var_1._id_121FB = undefined;
  } else
    var_1._id_121FB disconnectPaths();
}

init_interactions(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = anglestoright(self.angles);
  var_3 = anglestoleft(self.angles);
  var_4 = self.origin + (0, 0, -110);
  var_5 = var_4 + var_1 * 20 + var_3 * 45;
  var_6 = var_4 + var_1 * 20 + var_2 * 45;
  var_7 = var_4 + var_1 * -20 + var_3 * 45;
  var_8 = var_4 + var_1 * -20 + var_2 * 45;
  create_vehicle_interaction(var_8, &"_encstr_AC5B188F21D0193D3144B64DFDB1141187B51FCBB77520E4B1CF", "_encstr_8C3006B9ACC21D0D", self, var_0);
  create_vehicle_interaction(var_6, &"_encstr_AC5B188F21D0193D3144B64DFDB1141187B51FCBB77520E4B1CF", "_encstr_9A30069BCAC649C3", self, var_0);
  create_vehicle_interaction(var_7, &"_encstr_AC5B188F21D0193D3144B64DFDB1141187B51FCBB77520E4B1CF", "_encstr_AF3006C31D817B2A", self, var_0);
  create_vehicle_interaction(var_5, &"_encstr_AC5B188F21D0193D3144B64DFDB1141187B51FCBB77520E4B1CF", "_encstr_8D30066E2BB0D113", self, var_0);
}

create_vehicle_interaction(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_5 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_5 setHintString(var_1);
  var_5 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_5 sethintdisplayrange(200);
  var_5 sethintdisplayfov(90);
  var_5 setuserange(72);
  var_5 setusefov(90);
  var_5 sethintonobstruction("_encstr_BECC055CF3811A");
  var_5 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");

  if(isDefined(var_4) && isbuiltinfunction(var_4))
    var_5 thread[[var_4]](var_3, var_2);
  else
    var_5 thread interaction_use_think(var_3, var_2);

  var_5 thread interaction_disable_on_exit(var_3);
}

interaction_use_think(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD0E1041F595C028536A184082C7E038AF4E");
  self makeusable();

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    self makeunusable();
    var_2 thread playerpassengerthink(var_1);
    break;
  }
}

interaction_disable_on_exit(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 waittill("_encstr_AD0E1041F595C028536A184082C7E038AF4E");
  self makeunusable();
}

_id_144BA() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B407112577DF45279BFD9CC8C7A4F90EB0324F");
  var_0 = anglesToForward(self.angles);
  var_1 = anglestoright(self.angles);
  var_2 = anglestoleft(self.angles);
  var_3 = self.origin + (0, 0, -110);
  var_4 = var_3 + var_0 * 20 + var_2 * 45;
  var_5 = var_3 + var_0 * 20 + var_1 * 45;
  var_6 = self.wmexfilally;

  if(!isDefined(var_6)) {
    return;
  }
  var_7 = undefined;

  foreach(var_9 in level.players) {
    if(isDefined(var_9.hostagecarried)) {
      var_7 = var_9.hostagecarried;
      break;
    }
  }

  if(!isDefined(var_7)) {
    level waittill("_encstr_835F199B4D57EB83E3D1826F521A25E306405BFF386FE2236FB7AB", var_9);
    var_7 = var_9.hostagecarried;
  }

  var_11 = "_encstr_A5AD056A019C63";
  var_12 = "_encstr_A5AD056A019C63";

  for(;;) {
    var_13 = distance2dsquared(var_7.origin, var_5);
    var_14 = distance2dsquared(var_7.origin, var_4);

    if(var_13 > var_14)
      var_12 = "_encstr_A5AD056A019C63";
    else
      var_12 = "_encstr_8253060E2B5FE330";

    if(var_11 != var_12) {
      self.onjointeamnospectatorcallbacks = 1;
      var_11 = var_12;
      var_6 _id_13E58(self, var_11);
      self.spawnintermissionatplayer = var_11;
      self.onjointeamnospectatorcallbacks = 0;
    }

    wait 0.5;
  }
}

_id_13E58(var_0, var_1) {
  self notify("_encstr_8EC80FCDD17B387DA5918D56EB16CD4BDA");
  var_2 = scripts\engine\utility::ter_op(var_1 == "_encstr_A5AD056A019C63", "_encstr_BA1D0A8407054D36417ADB5B", "_encstr_963F0B118D6A8040237231D88B");
  var_3 = scripts\engine\utility::ter_op(var_1 == "_encstr_A5AD056A019C63", "_encstr_852E15EA4C97655A0F384EBF5AAF0CA7B21520B50F738E", "_encstr_86CD150808DF9A4329B9AAF5F3878DE73127420A603370");
  var_0 scripts\common\anim::anim_single_solo(self, var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 thread make_chopper_boss_look_at_ent(self, var_3);
}

make_chopper_boss_look_at_ent(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8EC80FCDD17B387DA5918D56EB16CD4BDA");

  for(;;)
    scripts\common\anim::anim_single_solo(var_0, var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

waitforhvtonboard() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self;
  var_0.animname = "_encstr_BD9E0EA7DBEA038131D343F0A34890C0";
  var_1 = anglesToForward(var_0.angles);
  var_2 = anglestoleft(var_0.angles);
  var_3 = anglestoright(var_0.angles);
  var_4 = var_0.origin + var_1 * 10 + var_2 * 64 + (0, 0, -110);
  var_5 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_4 + (0, 0, -200), 0, 64, 500);
  var_0.spawnintermissionatplayer = "_encstr_A5AD056A019C63";
  var_0 thread _id_14371(var_5, "_encstr_A5AD056A019C63", "_encstr_BD0E14A47318E7F3967B3F075BBE2A14991B1CEF28B0");
  var_0 waittill("_encstr_B407112577DF45279BFD9CC8C7A4F90EB0324F");
  var_5 delete();
}

_id_14371(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon(var_2);
  var_3 = 0;

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_4);

    if(!var_4 isvalidplayer() && isDefined(var_4.inchopper)) {
      continue;
    }
    if(isDefined(var_4.hostagecarried) && !istrue(var_4.trigger_water_fx) && !istrue(var_3) && !isDefined(self.vip) && !istrue(self.onjointeamnospectatorcallbacks)) {
      self notify("_encstr_B407112577DF45279BFD9CC8C7A4F90EB0324F");
      level notify("_encstr_B4390F43EC3AEB1DC9A53BEC59E49519D7" + var_1);
      load_hvt(var_4);
      var_3 = 1;
      level notify("_encstr_95E2130DECA3D7D8DBC2322B46F5BD9BBE8656B14B");
      break;
    }

    wait 0.2;
  }
}

startplayerboarding() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(level.heli_trip_vehicle)) {
    return;
  }
  level.heli_trip_vehicle notify("_encstr_8B4611FB437F1BCBF029B7922708928B93F832");
  level thread wait_for_all_players_ready();
  thread watchforhelitriptimeout();
  var_0 = self;
  var_0.animname = "_encstr_BD9E0EA7DBEA038131D343F0A34890C0";
  var_0 init_interactions();
}

watchforhelitriptimeout() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_84B715C263D8BE38B158E5CAE4B9EB7B377D89F6C23991");
  self waittill("_encstr_935A14831B165EAC9CFA31ED2C9C91CA91AF342B1B5A");
  var_0 = gettime() + 45000;

  while(gettime() <= var_0)
    wait 3;

  self notify("_encstr_829314BC09C0C969AD752F43C755F23560B1F9C5A358");
}

go_to_landing_destination(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = [];
  var_1[0] = var_0.origin;

  for(var_2 = var_0; isDefined(var_2.target); var_2 = var_3) {
    var_3 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_1[var_1.size] = var_3.origin;
  }

  var_4 = var_1.size;
  self notify("_encstr_AD0E1041F595C028536A184082C7E038AF4E");
  var_5 = self;
  var_5 disconnectPaths();
  var_5 vehicle_setspeed(5, 10);
  var_5 cleartargetyaw();
  var_5 setvehgoalpos(var_5.origin + (0, 0, 1200), 1);
  wait 2;
  level notify("_encstr_99D81368CB605C77355B8A23C60DFF955BD717EE55");
  var_5 vehicle_setspeed(90, 10);
  var_5 waittill("_encstr_8B7205D9ED5958");

  if(var_4 > 1) {
    var_5 vehicle_setspeed(80, 250, 250);

    for(var_6 = 0; var_6 < var_4 - 1; var_6++) {
      var_5 setvehgoalpos(var_1[var_6], 0);
      var_5 setneargoalnotifydist(200);
      var_5 waittill("_encstr_B4D10ADC950BE4EB76DE8536");
    }
  }

  var_5 vehicle_setspeed(90, 10);
  var_5 setvehgoalpos(var_1[var_1.size - 1] + (0, 0, 1200), 1);
  var_5 waittill("_encstr_8B7205D9ED5958");
  var_5 settargetyaw(var_5.exfil_struct.angles[1]);
  var_5 setyawspeed(50, 25, 25, 0);
  wait 3;
  var_5.goalradius = 4;
  var_5 setvehgoalpos(var_1[var_1.size - 1], 1);
  var_5 waittill("_encstr_8B7205D9ED5958");
  var_5 vehicle_setspeedimmediate(0);
  var_5 vehicle_cleardrivingstate();
}

exit_map() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self;
  var_0 vehicle_setspeed(5, 10);
  var_0 cleartargetyaw();
  var_0 setvehgoalpos(var_0.origin + (0, 0, 1200), 1);
  wait 2;
  var_0 vehicle_setspeed(90, 10);
  var_0 waittill("_encstr_8B7205D9ED5958");
  var_0 setvehgoalpos(var_0.origin + (10000, 10000, 500));
  wait 15;

  if(isDefined(var_0.vip))
    var_0.vip scripts\cp\cp_pickup_hostage::deletepickuphostage();

  if(isDefined(var_0.minigun))
    var_0.minigun delete();

  foreach(var_2 in var_0.actors) {
    if(isDefined(var_2.head))
      var_2.head delete();

    var_2 delete();
  }

  if(isDefined(var_0.headicon))
    setheadiconimage(var_0.headicon);

  var_0 delete();
  level.heli_trip_vehicle = undefined;
  level notify("_encstr_8568125AF0018CAF43FEA9C8AF290F954BD03212");
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");

_id_1212D(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 notify("_encstr_8B5B13DB1CB2732DDC3BBEC95ACE0D8E7DC8B7B79C");
  var_0 vehicleplayanim(%_encstr_A3422F86248BAE8F52A118185B6B43610FF785FEB72B10DDBFC9400812C57B3E3B4F1DF81F5B5E07E2723889BADD23B0CF);
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

vehicle_register_on_level(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8B5B13DB1CB2732DDC3BBEC95ACE0D8E7DC8B7B79C");
  var_0 endon("_encstr_84B613C663DEE6B4B9D97DE4D2B30DA3AF91BDF6E4");

  for(;;) {
    var_0 vehicleplayanim(%_encstr_85BF355B488DB1EF53F8382786BBAFC7DBF9B2C3A821750349C03A2C93A077015D613AAA40FD215F2030135DA0C82B95ABC92212E8AB66);
    wait(getanimlength(%_encstr_85BF355B488DB1EF53F8382786BBAFC7DBF9B2C3A821750349C03A2C93A077015D613AAA40FD215F2030135DA0C82B95ABC92212E8AB66));
  }
}

#using_animtree("_encstr_B40101");

heli_rpg_enemy_think(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 notify("_encstr_84B613C663DEE6B4B9D97DE4D2B30DA3AF91BDF6E4");
  var_0 vehicleplayanim(%_encstr_B65130CA191201A89739A8B5FB85A29F9FA1155DC5431A3B7957D2FC4B653659D5210F77C042D62FD9A88307316232D09381);
}

initanims(var_0) {
  script_model_alpha_anims();
  vehicles_alpha_anims();
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

script_model_alpha_anims() {
  level.scr_animtree["_encstr_B1190448CD80"] = #animtree;
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_9A1C0F43AC365AC8F6BB9BAFCAE1994B63"] = % _encstr_B22D1A3823F1E322AB5109E832EB48AB2679D818FB19393977480C75;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_9A1C0F43AC365AC8F6BB9BAFCAE1994B63"] = "_encstr_B22D1A3823F1E322AB5109E832EB48AB2679D818FB19393977480C75";
  level.scr_anim["_encstr_B1190448CD80"]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"] = % _encstr_88D81FD8039F1149D2F491300E4A53D809270888FB47883D29DC94ADA9F281A075;
  level.scr_animname["_encstr_B1190448CD80"]["_encstr_970F1451174233A8FF4B504EF7C0F07B1A972BC1AB7A"] = "_encstr_88D81FD8039F1149D2F491300E4A53D809270888FB47883D29DC94ADA9F281A075";
  level.scr_animtree["_encstr_8BB007E03658CBCAE4"] = #animtree;
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_A3F80CBD34249D581E0F056B1773"] = % _encstr_A9801F50C990BF4FF348E333C039F8D33A0F63B0C1CF82898B089AB1E7D2B3C8E0;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_A3F80CBD34249D581E0F056B1773"] = "_encstr_A9801F50C990BF4FF348E333C039F8D33A0F63B0C1CF82898B089AB1E7D2B3C8E0";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_A3F80CBD34249D581E0F056B1773"] = "_encstr_A9CE0FB107EB89D8D25BB0FA76CA8E9673";
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_AFB50B8690507502A0DB934B3B"] = % _encstr_A3011E4F3B8BAFA8C8690B61CCBF88C62397CDEF3F63D570E471FB3EB46C408D;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_AFB50B8690507502A0DB934B3B"] = "_encstr_A3011E4F3B8BAFA8C8690B61CCBF88C62397CDEF3F63D570E471FB3EB46C408D";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_AFB50B8690507502A0DB934B3B"] = "_encstr_96490ED713F8593950480E0F73E1013B";
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");

vehicles_alpha_anims() {
  level.scr_animtree["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"] = #animtree;
}