/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\cp_heli_trip.gsc
************************************************/

start_heli_trip_sequence(_id_EA5A0CA0515A7B2A, _id_AFE93DCE3222D6C1, _id_A5C195715679676E, _id_85BDAE40D5E5AFED, _id_CC7B5C3D58EDAEE5) {
  level endon("game_ended");
  initanims();
  level.heli_trip_vehicle = spawn_chopper(_id_EA5A0CA0515A7B2A, _id_AFE93DCE3222D6C1);
  level.heli_trip_vehicle scripts\cp\infilexfil\blima_exfil::go_to_exfil_location(level.heli_trip_vehicle.exfil_struct, 1);
  level.heli_trip_vehicle thread wait_for_passengers(_id_85BDAE40D5E5AFED);
  level.heli_trip_vehicle scripts\engine\utility::waittill_any_2("all_players_on_board", "heli_trip_timed_out");

  if(isDefined(_id_CC7B5C3D58EDAEE5) && scripts\engine\utility::flag_exist(_id_CC7B5C3D58EDAEE5))
    scripts\engine\utility::flag_wait(_id_CC7B5C3D58EDAEE5);

  if(isDefined(level.heli_trip_vehicle) && isDefined(level.heli_trip_vehicle.navobstacle))
    destroynavobstacle(level.heli_trip_vehicle.navobstacle);

  level notify("heli_trip_took_off");
  level.heli_trip_vehicle notify("heli_taking_off");
  level.heli_trip_vehicle scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_A5C195715679676E);
  level.heli_trip_vehicle notify("unload");
  level notify("heli_trip_over");
  wait 2;
  level.heli_trip_vehicle thread exit_map();
  level.helitrip_next_rig_num = undefined;
}

#using_animtree("script_model");

playerpassengerthink(_id_7EE36C8F63D5BE05) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  _id_967AEB4D5A42EBC5 = "tag_seat_2";

  switch (_id_7EE36C8F63D5BE05) {
    case "seat1":
      _id_967AEB4D5A42EBC5 = "tag_seat_2";
      break;
    case "seat2":
      _id_967AEB4D5A42EBC5 = "tag_seat_3";
      break;
    case "seat3":
      _id_967AEB4D5A42EBC5 = "tag_seat_4";
      break;
    case "seat4":
      _id_967AEB4D5A42EBC5 = "tag_seat_5";
      break;
  }

  self disableusability();
  self allowmelee(0);
  self disableoffhandweapons();
  self.is_riding_heli = 1;
  get_rid_of_minigun();

  if(scripts\cp\utility::riotshield_hasweapon())
    self.bhadriotshield = 1;

  scripts\cp\cp_weapons::takeriotshield(self);
  thread scripts\cp\cp_outofbounds::enableoobimmunity(self);
  thread create_player_rig(self, "player");
  scripts\common\anim::anim_first_frame_solo(self.player_rig, "blima_getin");
  link_player_to_rig(self, 0.4);
  self.player_rig.weapon_state_func = scripts\cp\cp_infilexfil::handleweaponstatenotetrackcp;
  level.heli_trip_vehicle thread scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "blima_getin", _id_967AEB4D5A42EBC5);
  wait(getanimlength(%sdr_cp_veh_lbravo_seat_2_getin));
  self.player_rig linkTo(level.heli_trip_vehicle, "body_animate_jnt", (0, 0, 0), (0, 0, 0));
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 30, 30);
  self.inchopper = 1;
  level notify("exfil_sequence_started");
  level.heli_trip_vehicle notify("player_boarded_heli");
  thread watchfornagstootherplayers();
  thread rideloop(_id_967AEB4D5A42EBC5);
  level.heli_trip_vehicle waittill("unload");
  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  self stopanimscriptsceneevent();
  self notify("remove_rig");
  self setdemeanorviewmodel("normal");
  self stopviewmodelanim();
  self enableusability();
  self allowmelee(1);
  self enableoffhandweapons();
  self.is_riding_heli = 0;
  thread scripts\cp\cp_outofbounds::disableoobimmunity(self);
  scripts\cp\cp_infilexfil::takegunlesscp();

  if(istrue(self.bhadriotshield)) {
    shield = makeweapon("iw9_me_riotshield_mp");
    scripts\cp_mp\utility\inventory_utility::_giveweapon(shield, undefined, undefined, 1);
    _id_74502A9E0EF1F19C::riotshieldonweaponchange();
    self.bhadriotshield = undefined;
  }

  self.inchopper = undefined;
}

get_rid_of_minigun() {
  if(_id_74502A9E0EF1F19C::player_has_minigun(self)) {
    _id_74502A9E0EF1F19C::drop_minigun(self);
    _id_102D661B1CAA8BC1 = undefined;
    primaryweapons = self getweaponslistprimaries();

    foreach(weapon in primaryweapons) {
      if(isnullweapon(weapon)) {
        continue;
      }
      if(scripts\cp_mp\utility\weapon_utility::isriotshield(weapon))
        continue;
      else if(!isDefined(_id_102D661B1CAA8BC1)) {
        _id_DD9181EB18C4DB69 = weapon getnoaltweapon();

        if(_id_DD9181EB18C4DB69.inventorytype != "primary") {
          continue;
        }
        _id_102D661B1CAA8BC1 = weapon;
      }
    }

    if(isDefined(_id_102D661B1CAA8BC1))
      childthread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(_id_102D661B1CAA8BC1);
  }
}

create_player_rig(player, animname, _id_486DB5FA512A3B6B) {
  if(!isDefined(player) || isDefined(player.player_rig)) {
    return;
  }
  player.animname = animname;

  if(!isDefined(_id_486DB5FA512A3B6B))
    _id_486DB5FA512A3B6B = "viewhands_base_iw8";

  player _meth_B88C89BB7CD1AB8E(player.origin);
  player_rig = spawn("script_arms", player.origin, 0, 0, player);
  player_rig.player = player;
  player.player_rig = player_rig;
  player.player_rig hide();
  player.player_rig.animname = animname;
  player.player_rig useanimtree(#animtree);
  player.player_rig.angles = scripts\engine\utility::ter_op(isDefined(player.angles), player.angles, (0, 0, 0));
  player watch_remove_rig();
  remove_player_rig(player);
}

watch_remove_rig(struct) {
  scripts\engine\utility::waittill_any_3("remove_rig", "death", "disconnect");
}

remove_player_rig(player) {
  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }
  player unlink();
  player.player_rig delete();
  player.player_rig = undefined;
}

link_player_to_rig(player, _id_D180B535A33B044D) {
  player endon("death");
  player endon("disconnect");

  if(!isDefined(player) || !isDefined(player.player_rig)) {
    return;
  }
  if(!isDefined(_id_D180B535A33B044D))
    _id_D180B535A33B044D = 0.2;

  player playerlinktoblend(player.player_rig, "tag_player", _id_D180B535A33B044D, 0.25, 0.25);
  wait(_id_D180B535A33B044D);
  player playerlinktodelta(player.player_rig, "tag_player", 1, 0, 0, 0, 0, 1, 1, 1);
}

rideloop(tag) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  level.heli_trip_vehicle endon("unload");

  for(;;)
    level.heli_trip_vehicle scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "blima_idle", tag);
}

watchfornagstootherplayers() {
  self endon("death");
  self endon("disconnect");
  level.heli_trip_vehicle endon("heli_taking_off");

  for(;;)
    wait 10;
}

get_player_rig() {
  if(!isDefined(level.next_rig_num))
    level.helitrip_next_rig_num = 0;

  level.helitrip_next_rig_num++;
  level.helitrip_next_rig_num = clamp(level.helitrip_next_rig_num, 1, 4);
  return "seat" + level.helitrip_next_rig_num;
}

load_hvt(player) {
  scripts\cp\cp_pickup_hostage::init_anims();
  heli = self;
  heli.vip = player.hostagecarried;

  if(!isDefined(heli.hvtboardingside))
    heli.hvtboardingside = "left";

  scripts\cp\cp_pickup_hostage::load_hvt(player, heli, heli.hvtboardingside);
  level thread do_secured_player_vo(player);
}

do_secured_player_vo(player) {
  level endon("game_ended");

  while(istrue(level.isteamvoplaying))
    wait 1;

  level notify("cp_heli_trip_obj_secured_vo_done");
}

all_alive_players_in_chopper() {
  _id_44992E6B98F5EC99 = 0;
  _id_2D2ABB649737B34E = 0;
  _id_9C59D410D0F1B202 = 0;

  foreach(player in level.players) {
    if(_id_0AFB7E332AEE4BF2::player_in_laststand(player))
      _id_2D2ABB649737B34E++;

    if(istrue(player.inchopper))
      _id_44992E6B98F5EC99++;

    if(istrue(player._id_250796613B419E6B))
      _id_9C59D410D0F1B202++;
  }

  return _id_44992E6B98F5EC99 > 0 && level.players.size == _id_44992E6B98F5EC99 + _id_2D2ABB649737B34E + _id_9C59D410D0F1B202;
}

isvalidplayer(_id_873769D3E3EC0986) {
  if(!isPlayer(self))
    return 0;

  if(!isDefined(self))
    return 0;

  if(!isDefined(_id_873769D3E3EC0986) && _id_0AFB7E332AEE4BF2::player_in_laststand(self))
    return 0;

  if(!isalive(self))
    return 0;

  if(self.sessionstate == "spectator")
    return 0;

  return 1;
}

wait_for_all_players_ready() {
  level endon("game_ended");
  level.heli_trip_vehicle endon("all_players_on_board");
  level.heli_trip_vehicle endon("heli_trip_timed_out");

  for(;;) {
    if(all_alive_players_in_chopper()) {
      level.heli_trip_vehicle notify("all_players_on_board");
      return;
    }

    wait 0.1;
  }
}

spawn_chopper(_id_96B1084652B648A8, exfil_struct) {
  heli = scripts\common\vehicle::vehicle_spawn(_id_96B1084652B648A8);
  heli.vehicle_skipdeathmodel = 1;
  heli.script_disconnectpaths = 0;
  heli.death_fx_on_self = 1;
  heli.exfil_struct = exfil_struct;
  exfil_struct.smoke_canister = smoke_canister_spawn(exfil_struct.origin, 1);
  scripts\cp\infilexfil\blima_exfil::spawn_vehicle_actors(heli);
  heli.godmode = 1;
  heli.health = 10000;
  heli.maxhealth = 10000;
  heli.team = "allies";
  heli.script_team = "allies";
  heli setvehicleteam("allies");
  heli setCanDamage(0);
  heli spawnhelihvtexfilactors();

  if(isDefined(heli.wmexfilally)) {
    if(!isDefined(heli.actors))
      heli.actors = [];

    heli.actors[heli.actors.size] = heli.wmexfilally;
  }

  heli.headicon = createheadicon(heli);
  setheadiconimage(heli.headicon, "hud_icon_head_equipment_friendly");
  setheadiconmaxdistance(heli.headicon, 12000);
  setheadiconnaturaldistance(heli.headicon, 1500);
  setheadiconzoffset(heli.headicon, 10);
  setheadiconsnaptoedges(heli.headicon, 1);
  return heli;
}

spawnhelihvtexfilactors(_id_F97DD5B98052176A, _id_91E906DDD7521A40) {
  if(!isDefined(_id_F97DD5B98052176A))
    _id_F97DD5B98052176A = "body_mp_western_fireteam_west_ar_1_1_lod1";

  if(!isDefined(_id_91E906DDD7521A40))
    _id_91E906DDD7521A40 = "head_sas_urban_ar_rain";

  _id_C7D12EECEE25E41D = self;
  wmexfilally = spawn("script_model", _id_C7D12EECEE25E41D.origin);
  wmexfilally setModel("allied_pilot_fullbody_3");
  wmexfilally useanimtree(level.scr_animtree["exfil_ally"]);
  wmexfilally.animname = "exfil_ally";
  startpos = getstartorigin(_id_C7D12EECEE25E41D.origin, _id_C7D12EECEE25E41D.angles, level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"]);
  startangles = getstartangles(_id_C7D12EECEE25E41D.origin, _id_C7D12EECEE25E41D.angles, level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"]);
  wmexfilally.origin = startpos + (0, 0, 210);
  wmexfilally.angles = startangles;
  wmexfilally linkTo(_id_C7D12EECEE25E41D);
  _id_C7D12EECEE25E41D.wmexfilally = wmexfilally;
  _id_8CAB70160B4F7FF4 = spawn("script_model", startpos + (0, 0, 210));
  _id_8CAB70160B4F7FF4 setModel("tag_origin");
  _id_8CAB70160B4F7FF4 linkTo(_id_C7D12EECEE25E41D);
  _id_C7D12EECEE25E41D thread idle_exfilally_loop(wmexfilally, _id_8CAB70160B4F7FF4);
}

idle_exfilally_loop(_id_A8CE42E766F71385, _id_8CAB70160B4F7FF4) {
  self endon("death");
  _id_A8CE42E766F71385 endon("stop_idle_anim");

  for(;;)
    _id_8CAB70160B4F7FF4 scripts\common\anim::anim_single_solo(_id_A8CE42E766F71385, "blima_drop_l_idle_in", "tag_origin");
}

wait_for_passengers(_id_85BDAE40D5E5AFED) {
  level endon("game_ended");
  self solid();

  if(istrue(_id_85BDAE40D5E5AFED)) {
    closerightblimadoor(self);
    waitforhvtonboard();
    level.heli_trip_vehicle openrightblimadoor(level.heli_trip_vehicle);
  }

  startplayerboarding();
}

toggleconnectpaths(_id_41D8BF229CF29051) {
  heli = self;

  if(!isDefined(heli.pathblocker)) {
    heli.pathblocker = spawn("script_model", heli.origin - (0, 0, 100));
    heli.pathblocker.angles = scripts\engine\utility::ter_op(isDefined(heli.angles), heli.angles, (0, 0, 0));
    heli.pathblocker hide();
    heli.pathblocker setModel(heli.model);
  }

  if(_id_41D8BF229CF29051) {
    heli.pathblocker connectpaths();
    heli.pathblocker delete();
    heli.pathblocker = undefined;
  } else
    heli.pathblocker disconnectPaths();
}

init_interactions(usefuncoverride) {
  fwd = anglesToForward(self.angles);
  _id_CDD53D78F51F6B97 = anglestoright(self.angles);
  _id_46EF3E042B2E6565 = anglestoleft(self.angles);
  org = self.origin + (0, 0, -60);
  _id_5CAA709F456AD8E3 = org + fwd * 20 + _id_46EF3E042B2E6565 * 45;
  _id_5CAA769F456AE615 = org + fwd * 20 + _id_CDD53D78F51F6B97 * 45;
  _id_5CAA759F456AE3E2 = org + fwd * -20 + _id_46EF3E042B2E6565 * 45;
  _id_5CAA739F456ADF7C = org + fwd * -20 + _id_CDD53D78F51F6B97 * 45;
  create_vehicle_interaction(_id_5CAA739F456ADF7C, &"CP_VEHICLE_TRAVEL/ENTER", "seat4", self, usefuncoverride);
  create_vehicle_interaction(_id_5CAA769F456AE615, &"CP_VEHICLE_TRAVEL/ENTER", "seat3", self, usefuncoverride);
  create_vehicle_interaction(_id_5CAA759F456AE3E2, &"CP_VEHICLE_TRAVEL/ENTER", "seat2", self, usefuncoverride);
  create_vehicle_interaction(_id_5CAA709F456AD8E3, &"CP_VEHICLE_TRAVEL/ENTER", "seat1", self, usefuncoverride);
}

create_vehicle_interaction(loc, hintstring, _id_D079963B8D1FF3AF, vehicle, usefuncoverride) {
  interaction = spawn("script_model", loc);
  interaction setModel("tag_origin");
  interaction makeusable();
  interaction setHintString(hintstring);
  interaction setCursorHint("HINT_BUTTON");
  interaction sethintdisplayrange(200);
  interaction sethintdisplayfov(90);
  interaction setuserange(72);
  interaction setusefov(90);
  interaction sethintonobstruction("hide");
  interaction setuseholdduration("duration_short");

  if(isDefined(usefuncoverride) && isfunction(usefuncoverride))
    interaction thread[[usefuncoverride]](vehicle, _id_D079963B8D1FF3AF);
  else
    interaction thread interaction_use_think(vehicle, _id_D079963B8D1FF3AF);

  level thread scripts\engine\utility::draw_circle(loc, 128, (0, 0, 1), 1, 0, 3000);
  interaction thread _id_01522105805BB751(vehicle, _id_D079963B8D1FF3AF);
}

interaction_use_think(vehicle, _id_D079963B8D1FF3AF) {
  level endon("game_ended");
  vehicle endon("heli_taking_off");
  self _meth_DFB78B3E724AD620(1);

  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    self _meth_DFB78B3E724AD620(0);
    player thread playerpassengerthink(_id_D079963B8D1FF3AF);
    break;
  }
}

_id_01522105805BB751(vehicle, _id_D079963B8D1FF3AF) {
  level endon("game_ended");
  vehicle scripts\engine\utility::waittill_any_2("heli_taking_off", "disable_" + _id_D079963B8D1FF3AF);
  self _meth_DFB78B3E724AD620(0);
}

watchforexfilallyturntoside() {
  level endon("game_ended");
  self endon("death");
  self endon("load_hvt_started");
  fwd = anglesToForward(self.angles);
  _id_CDD53D78F51F6B97 = anglestoright(self.angles);
  _id_46EF3E042B2E6565 = anglestoleft(self.angles);
  org = self.origin + (0, 0, -110);
  _id_1A8097F1A065C786 = org + fwd * 20 + _id_46EF3E042B2E6565 * 45;
  _id_1A2A7C570678A79D = org + fwd * 20 + _id_CDD53D78F51F6B97 * 45;
  _id_A8CE42E766F71385 = self.wmexfilally;

  if(!isDefined(_id_A8CE42E766F71385)) {
    return;
  }
  _id_0BA89A03FF462799 = undefined;

  foreach(player in level.players) {
    if(isDefined(player.hostagecarried)) {
      _id_0BA89A03FF462799 = player.hostagecarried;
      break;
    }
  }

  if(!isDefined(_id_0BA89A03FF462799)) {
    level waittill("player_picked_up_hostage", player);
    _id_0BA89A03FF462799 = player.hostagecarried;
  }

  _id_BD5E53637FC4F840 = "left";
  _id_BF7E8C22B315BF07 = "left";

  for(;;) {
    _id_7AB1343BCC5BCD5E = distance2dsquared(_id_0BA89A03FF462799.origin, _id_1A2A7C570678A79D);
    _id_59C930FA00B280C5 = distance2dsquared(_id_0BA89A03FF462799.origin, _id_1A8097F1A065C786);

    if(_id_7AB1343BCC5BCD5E > _id_59C930FA00B280C5)
      _id_BF7E8C22B315BF07 = "left";
    else
      _id_BF7E8C22B315BF07 = "right";

    if(_id_BD5E53637FC4F840 != _id_BF7E8C22B315BF07) {
      self.exfilallyturning = 1;
      _id_BD5E53637FC4F840 = _id_BF7E8C22B315BF07;
      _id_A8CE42E766F71385 turnexfiltoside(self, _id_BD5E53637FC4F840);
      self.hvtboardingside = _id_BD5E53637FC4F840;
      self.exfilallyturning = 0;
    }

    wait 0.5;
  }
}

turnexfiltoside(heli, _id_9D142161A92F87D3) {
  self notify("stop_idle_anim");
  turnanim = scripts\engine\utility::ter_op(_id_9D142161A92F87D3 == "left", "turn_left", "turn_right");
  idleanim = scripts\engine\utility::ter_op(_id_9D142161A92F87D3 == "left", "blima_drop_l_idle_in", "blima_drop_r_idle_in");
  heli scripts\common\anim::anim_single_solo(self, turnanim, "tag_origin");
  heli thread doexfilallyidle(self, idleanim);
}

doexfilallyidle(_id_A8CE42E766F71385, idleanim) {
  self endon("death");
  _id_A8CE42E766F71385 endon("stop_idle_anim");

  for(;;)
    scripts\common\anim::anim_single_solo(_id_A8CE42E766F71385, idleanim, "tag_origin");
}

waitforhvtonboard() {
  level endon("game_ended");
  _id_214DA032EEFDFE74 = self;
  _id_214DA032EEFDFE74.animname = "exfil_chopper";
  fwd = anglesToForward(_id_214DA032EEFDFE74.angles);
  _id_46EF3E042B2E6565 = anglestoleft(_id_214DA032EEFDFE74.angles);
  _id_CBAC2203146AE84A = anglestoright(_id_214DA032EEFDFE74.angles);
  _id_5CAA739F456ADF7C = _id_214DA032EEFDFE74.origin + fwd * 10 + _id_46EF3E042B2E6565 * 64 + (0, 0, -110);
  _id_AA573402A27CA636 = spawn("trigger_radius", _id_5CAA739F456ADF7C + (0, 0, -200), 0, 64, 500);
  _id_214DA032EEFDFE74.hvtboardingside = "left";
  _id_214DA032EEFDFE74 thread waitforhvttrigger(_id_AA573402A27CA636, "left", "hvt_triggered_right");
  _id_214DA032EEFDFE74 waittill("load_hvt_started");
  _id_AA573402A27CA636 delete();
}

waitforhvttrigger(trig, _id_A66BA9B157533F5A, endonstring) {
  level endon("game_ended");
  level endon(endonstring);
  _id_F33AD00F7E48889A = 0;

  for(;;) {
    trig waittill("trigger", ent);

    if(!ent isvalidplayer() && isDefined(ent.inchopper)) {
      continue;
    }
    if(isDefined(ent.hostagecarried) && !istrue(ent.is_dropping_hostage) && !istrue(_id_F33AD00F7E48889A) && !isDefined(self.vip) && !istrue(self.exfilallyturning)) {
      self notify("load_hvt_started");
      level notify("hvt_triggered_" + _id_A66BA9B157533F5A);
      load_hvt(ent);
      _id_F33AD00F7E48889A = 1;
      level notify("hvt_loaded_on_heli");
      break;
    }

    wait 0.2;
  }
}

startplayerboarding() {
  level endon("game_ended");

  if(!isDefined(level.heli_trip_vehicle)) {
    return;
  }
  level.heli_trip_vehicle notify("started_boarding");
  level thread wait_for_all_players_ready();
  thread watchforhelitriptimeout();
  _id_214DA032EEFDFE74 = self;
  _id_214DA032EEFDFE74.animname = "exfil_chopper";
  _id_214DA032EEFDFE74 init_interactions();
}

watchforhelitriptimeout() {
  level endon("game_ended");
  self endon("all_players_on_board");
  self waittill("player_boarded_heli");
  endtime = gettime() + 45000;

  while(gettime() <= endtime)
    wait 3;

  self notify("heli_trip_timed_out");
}

go_to_landing_destination(_id_818B6EAACE794492) {
  level endon("game_ended");
  _id_F8BA776FF60EDD65 = [];
  _id_F8BA776FF60EDD65[0] = _id_818B6EAACE794492.origin;

  for(_id_AAFCE2B1BBDD60B3 = _id_818B6EAACE794492; isDefined(_id_AAFCE2B1BBDD60B3.target); _id_AAFCE2B1BBDD60B3 = _id_BF0747570224990A) {
    _id_BF0747570224990A = scripts\engine\utility::getStruct(_id_AAFCE2B1BBDD60B3.target, "targetname");
    _id_F8BA776FF60EDD65[_id_F8BA776FF60EDD65.size] = _id_BF0747570224990A.origin;
  }

  _id_32968D58D8099EF5 = _id_F8BA776FF60EDD65.size;
  self notify("heli_taking_off");
  heli = self;
  heli disconnectPaths();
  heli vehicle_setspeed(5, 10);
  heli cleartargetyaw();
  heli setvehgoalpos(heli.origin + (0, 0, 1200), 1);
  wait 2;
  level notify("heli_trip_took_off");
  heli vehicle_setspeed(90, 10);
  heli waittill("goal");

  if(_id_32968D58D8099EF5 > 1) {
    heli vehicle_setspeed(80, 250, 250);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_32968D58D8099EF5 - 1; _id_AC0E594AC96AA3A8++) {
      heli setvehgoalpos(_id_F8BA776FF60EDD65[_id_AC0E594AC96AA3A8], 0);
      heli setneargoalnotifydist(200);
      heli waittill("near_goal");
    }
  }

  heli vehicle_setspeed(90, 10);
  heli setvehgoalpos(_id_F8BA776FF60EDD65[_id_F8BA776FF60EDD65.size - 1] + (0, 0, 1200), 1);
  heli waittill("goal");
  heli settargetyaw(heli.exfil_struct.angles[1]);
  heli setyawspeed(50, 25, 25, 0);
  wait 3;
  heli.goalradius = 4;
  heli setvehgoalpos(_id_F8BA776FF60EDD65[_id_F8BA776FF60EDD65.size - 1], 1);
  heli waittill("goal");
  heli vehicle_setspeedimmediate(0);
  heli vehicle_cleardrivingstate();
}

exit_map() {
  level endon("game_ended");
  heli = self;
  heli vehicle_setspeed(5, 10);
  heli cleartargetyaw();
  heli setvehgoalpos(heli.origin + (0, 0, 1200), 1);
  wait 2;
  heli vehicle_setspeed(90, 10);
  heli waittill("goal");
  heli setvehgoalpos(heli.origin + (10000, 10000, 500));
  wait 15;

  if(isDefined(heli.vip))
    heli.vip scripts\cp\cp_pickup_hostage::deletepickuphostage();

  if(isDefined(heli.minigun))
    heli.minigun delete();

  foreach(actor in heli.actors) {
    if(isDefined(actor.head))
      actor.head delete();

    actor delete();
  }

  if(isDefined(heli.headicon))
    deleteheadicon(heli.headicon);

  heli delete();
  level.heli_trip_vehicle = undefined;
  level notify("heli_trip_deleted");
}

#using_animtree("mp_vehicles_always_loaded");

openrightblimadoor(heli) {
  level endon("game_ended");
  heli endon("death");
  heli notify("opening_right_door");
  heli vehicleplayanim(%sdr_cp_hostage_dropoff_blima_r_door_open_blima);
}

keeprightdooropen(heli) {
  level endon("game_ended");
  heli endon("death");
  heli endon("opening_right_door");
  heli endon("closing_right_door");

  for(;;) {
    heli vehicleplayanim(%sdr_cp_hostage_dropoff_blima_r_door_close_idle_blima);
    wait(getanimlength(%sdr_cp_hostage_dropoff_blima_r_door_close_idle_blima));
  }
}

closerightblimadoor(heli) {
  level endon("game_ended");
  heli endon("death");
  heli notify("closing_right_door");
  heli vehicleplayanim(%sdr_cp_hostage_dropoff_blima_r_door_close_blima);
}

initanims(subtype) {
  script_model_alpha_anims();
  vehicles_alpha_anims();
}

#using_animtree("script_model");

script_model_alpha_anims() {
  level.scr_animtree["hvt"] = #animtree;
  level.scr_anim["hvt"]["helidown_exfil"] = % cp_exfil_blima_hvt_lf_hvt;
  level.scr_animname["hvt"]["helidown_exfil"] = "cp_exfil_blima_hvt_lf_hvt";
  level.scr_anim["hvt"]["helidown_exfil_idle"] = % cp_exfil_blima_hvt_lf_hvt_idle;
  level.scr_animname["hvt"]["helidown_exfil_idle"] = "cp_exfil_blima_hvt_lf_hvt_idle";
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["blima_getin"] = % sdr_cp_veh_lbravo_seat_2_getin;
  level.scr_animname["player"]["blima_getin"] = "sdr_cp_veh_lbravo_seat_2_getin";
  level.scr_eventanim["player"]["blima_getin"] = "cp_blima_getin";
  level.scr_anim["player"]["blima_idle"] = % sdr_cp_veh_lbravo_seat_2_idle;
  level.scr_animname["player"]["blima_idle"] = "sdr_cp_veh_lbravo_seat_2_idle";
  level.scr_eventanim["player"]["blima_idle"] = "cp_blima_idle";
  level.scr_animtree["exfil_ally"] = #animtree;
  level.scr_anim["exfil_ally"]["blima_drop_l"] = % sdr_cp_hostage_dropoff_blima_l_ally;
  level.scr_animname["exfil_ally"]["blima_drop_l"] = "sdr_cp_hostage_dropoff_blima_L_ally";
  level.scr_anim["exfil_ally"]["blima_drop_l_idle_in"] = % sdr_cp_hostage_dropoff_blima_l_idle_intro_ally;
  level.scr_animname["exfil_ally"]["blima_drop_l_idle_in"] = "sdr_cp_hostage_dropoff_blima_L_idle_intro_ally";
  level.scr_anim["exfil_ally"]["blima_drop_l_idle_out"] = % sdr_cp_hostage_dropoff_blima_l_idle_outro_ally;
  level.scr_animname["exfil_ally"]["blima_drop_l_idle_out"] = "sdr_cp_hostage_dropoff_blima_L_idle_outro_ally";
}

smoke_canister_spawn(location, _id_EE8BBB848A851FDD) {
  spawnpos = scripts\engine\utility::drop_to_ground(location, 50, -200, (0, 0, 1));
  spawnpos = spawnpos + (0, 0, 1);
  magicgrenademanual("deploy_airdrop_mp", spawnpos, (0, randomint(360), 0), 0.01);
}

#using_animtree("mp_vehicles_always_loaded");

vehicles_alpha_anims() {
  level.scr_animtree["exfil_chopper"] = #animtree;
}