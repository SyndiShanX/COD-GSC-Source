/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\infilexfil\blima_exfil.gsc
*************************************************/

player_exfil_think(_id_214DA032EEFDFE74, seat) {
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  thread scripts\cp\cp_infilexfil::infil_player_rig(seat, "viewhands_base_iw8");
  self.player_rig.weapon_state_func = scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  self.player_rig linkTo(_id_214DA032EEFDFE74, "body_animate_jnt", (0, 0, 0), (0, 0, 0));
  self lerpfovbypreset("80_instant");
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  _id_214DA032EEFDFE74 scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "exfil", "body_animate_jnt");
  _id_214DA032EEFDFE74 thread rideloop(self);
}

spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  initanims();

  if(!isDefined(self.actors))
    self.actors = [];

  self.actors[self.actors.size] = spawn_anim_model("pilot", "body_animate_jnt", "allied_pilot_fullbody_3");
}

spawn_anim_model(animname, _id_FDF479B1DBD3D797, body, head, weapon, hat) {
  guy = spawn("script_model", (0, 0, 0));
  guy setModel(body);

  if(isDefined(head)) {
    _id_F4246828592F1C0F = spawn("script_model", (0, 0, 0));
    _id_F4246828592F1C0F setModel(head);
    _id_F4246828592F1C0F linkTo(guy, "j_spine4", (0, 0, 0), (0, 0, 0));
    guy.head = _id_F4246828592F1C0F;
    guy thread scripts\engine\utility::delete_on_death(_id_F4246828592F1C0F);
  }

  if(isDefined(hat)) {
    _id_72AD02F2E286273E = spawn("script_model", (0, 0, 0));
    _id_72AD02F2E286273E setModel(hat);
    _id_72AD02F2E286273E linkTo(guy.head, "j_spine4", (0, 0, 0), (0, 0, 0));
    guy.hat = _id_72AD02F2E286273E;
    guy thread scripts\engine\utility::delete_on_death(_id_72AD02F2E286273E);
  }

  guy.animname = animname;
  guy scripts\common\anim::setanimtree();

  if(isDefined(_id_FDF479B1DBD3D797)) {
    thread scripts\engine\utility::delete_on_death(guy);
    guy linkTo(self, _id_FDF479B1DBD3D797, (0, 0, 0), (0, 0, 0));
  }

  return guy;
}

initanims(subtype) {
  script_model_anims();
  vehicle_anims();
}

#using_animtree("script_model");

script_model_anims() {
  level.scr_animtree["pilot"] = #animtree;
  level.scr_anim["pilot"]["exfil"] = % vh_blima_rappel_pilot;
  level.scr_animname["pilot"]["exfil"] = "vh_blima_rappel_pilot";
  level.scr_animtree["copilot"] = #animtree;
  level.scr_anim["copilot"]["exfil"] = % vh_blima_rappel_copilot;
  level.scr_animname["copilot"]["exfil"] = "vh_blima_rappel_copilot";
  level.scr_animtree["seat1"] = #animtree;
  level.scr_anim["seat1"]["exfil"] = % cp_exfil_blima_plr01_wm;
  level.scr_animname["seat1"]["exfil"] = "cp_exfil_blima_plr01_wm";
  level.scr_eventanim["seat1"]["exfil"] = "exfil_blima_exit_1";
  level.scr_anim["seat1"]["exfil_idle"] = % cp_exfil_blima_plr01_idle_wm;
  level.scr_animname["seat1"]["exfil_idle"] = "cp_exfil_blima_plr01_idle_wm";
  level.scr_eventanim["seat1"]["exfil_idle"] = "exfil_blima_exit_1_idle";
  level.scr_animtree["seat2"] = #animtree;
  level.scr_anim["seat2"]["exfil"] = % cp_exfil_blima_plr02_wm;
  level.scr_animname["seat2"]["exfil"] = "cp_exfil_blima_plr02_wm";
  level.scr_eventanim["seat2"]["exfil"] = "exfil_blima_exit_2";
  level.scr_anim["seat2"]["exfil_idle"] = % cp_exfil_blima_plr02_idle_wm;
  level.scr_animname["seat2"]["exfil_idle"] = "cp_exfil_blima_plr02_idle_wm";
  level.scr_eventanim["seat2"]["exfil_idle"] = "exfil_blima_exit_2_idle";
  level.scr_animtree["seat3"] = #animtree;
  level.scr_anim["seat3"]["exfil"] = % cp_exfil_blima_plr03_wm;
  level.scr_animname["seat3"]["exfil"] = "cp_exfil_blima_plr03_wm";
  level.scr_eventanim["seat3"]["exfil"] = "exfil_blima_exit_3";
  level.scr_anim["seat3"]["exfil_idle"] = % cp_exfil_blima_plr03_idle_wm;
  level.scr_animname["seat3"]["exfil_idle"] = "cp_exfil_blima_plr03_idle_wm";
  level.scr_eventanim["seat3"]["exfil_idle"] = "exfil_blima_exit_3_idle";
  level.scr_animtree["seat4"] = #animtree;
  level.scr_anim["seat4"]["exfil"] = % cp_exfil_blima_plr04_wm;
  level.scr_animname["seat4"]["exfil"] = "cp_exfil_blima_plr04_wm";
  level.scr_eventanim["seat4"]["exfil"] = "exfil_blima_exit_4_idle";
  level.scr_anim["seat4"]["exfil_idle"] = % cp_exfil_blima_plr04_idle_wm;
  level.scr_animname["seat4"]["exfil_idle"] = "cp_exfil_blima_plr04_idle_wm";
  level.scr_eventanim["seat4"]["exfil_idle"] = "exfil_blima_exit_4_idle";
}

#using_animtree("mp_vehicles_always_loaded");

vehicle_anims() {
  level.scr_animtree["exfil_chopper"] = #animtree;
}

exfil_players(_id_214DA032EEFDFE74, objnum, custompassengerwaitfunc) {
  exfil(_id_214DA032EEFDFE74, objnum, custompassengerwaitfunc);
  _id_214DA032EEFDFE74 thread leave_and_end_game();
}

_id_09149F78899F36B7(_id_214DA032EEFDFE74, objnum, custompassengerwaitfunc) {
  exfil(_id_214DA032EEFDFE74, objnum, custompassengerwaitfunc);
  _id_214DA032EEFDFE74 heli_leave(1, 1);

  if(isDefined(_id_214DA032EEFDFE74.headicon))
    deleteheadicon(_id_214DA032EEFDFE74.headicon);

  _id_214DA032EEFDFE74 notify("death");
  wait 0.1;

  if(isDefined(_id_214DA032EEFDFE74))
    _id_214DA032EEFDFE74 delete();
}

exfil(_id_214DA032EEFDFE74, objnum, custompassengerwaitfunc) {
  scripts\cp\vehicles\cp_heli_trip::initanims();
  level.heli_trip_vehicle = _id_214DA032EEFDFE74;

  if(isDefined(custompassengerwaitfunc) && isfunction(custompassengerwaitfunc))
    level.heli_trip_vehicle thread[[custompassengerwaitfunc]]();
  else
    level.heli_trip_vehicle thread scripts\cp\vehicles\cp_heli_trip::wait_for_passengers(0);

  objective_setlabel(objnum, &"COOP_GAME_PLAY/EXFIL");
  _id_214DA032EEFDFE74 notify("waiting_to_leave");
  level.heli_trip_vehicle scripts\engine\utility::waittill_any_2("all_players_on_board", "heli_trip_timed_out");
  level notify("ready_to_exfil");
  objective_delete(objnum);
}

spawn_vehicle_actors(vehicle) {
  vehicle.animname = "exfil_chopper";
  vehicle spawnactors();
  vehicle thread actorloopthink();
}

leave_and_end_game() {
  heli_leave();
  _id_891894BCD976CC89();
}

heli_leave(_id_28FB9CE9B6706E97, _id_4461656AB93D2FAA) {
  wait 1;
  self cleargoalyaw();
  self vehicle_setspeed(15, 10);
  org = self.origin + (0, 0, 1200);
  self setvehgoalpos(org, 1);
  wait 5;

  if(isDefined(self.exfil_speed))
    self vehicle_setspeed(self.exfil_speed, 20);
  else
    self vehicle_setspeed(60, 20);

  if(isDefined(self.exfil_struct) && isDefined(self.exfil_struct.target)) {
    _id_2325A77FB5939978 = scripts\engine\utility::getStructArray(self.exfil_struct.target, "targetname");
    _id_F1B25AD1D7CAA88E = _id_2325A77FB5939978[0];
    _id_F13E0951028D543F = (_id_F1B25AD1D7CAA88E.origin[0], _id_F1B25AD1D7CAA88E.origin[1], self.origin[2]);
    _id_1DC53A6F1393B456 = vectorNormalize(_id_F13E0951028D543F - self.origin);
    _id_1DC53A6F1393B456 = _id_1DC53A6F1393B456 * 20000;
    self setvehgoalpos(org + _id_1DC53A6F1393B456);
  } else
    self setvehgoalpos(org + (0, -20000, 0));

  if(istrue(_id_28FB9CE9B6706E97))
    self waittill("goal");

  if(!istrue(_id_4461656AB93D2FAA)) {
    if(scripts\engine\utility::flag_exist("endgame_delay"))
      scripts\engine\utility::flag_wait("endgame_delay");
    else
      wait 4;

    wait 3;
  }

  self notify("end_of_path");
}

_id_891894BCD976CC89() {
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

all_alive_players_in_chopper() {
  _id_44992E6B98F5EC99 = 0;
  _id_2D2ABB649737B34E = 0;
  _id_5EDC4B509D7B55F1 = [];
  _id_0A51C5139B9BFB6E = [];

  foreach(player in level.players) {
    if(player.team == "axis") {
      _id_5EDC4B509D7B55F1[_id_5EDC4B509D7B55F1.size] = player;
      continue;
    }

    _id_0A51C5139B9BFB6E[_id_0A51C5139B9BFB6E.size] = player;
  }

  foreach(player in _id_0A51C5139B9BFB6E) {
    if(_id_0AFB7E332AEE4BF2::player_in_laststand(player) || player isspectatingplayer())
      _id_2D2ABB649737B34E++;

    if(istrue(player.inchopper))
      _id_44992E6B98F5EC99++;
  }

  return _id_44992E6B98F5EC99 > 0 && _id_0A51C5139B9BFB6E.size == _id_44992E6B98F5EC99 + _id_2D2ABB649737B34E;
}

wait_for_all_players_ready() {
  for(;;) {
    if(all_alive_players_in_chopper()) {
      level notify("ready_to_exfil");
      return;
    }

    wait 0.1;
  }
}

actorloopthink() {
  thread actorloop(self.actors[0], "tag_seat_0");
}

actorloop(actor, tag) {
  self endon("unload");
  self endon("death");
  actor endon("death");
  scripts\common\anim::anim_single_solo(actor, "exfil", tag);
}

init_interactions() {
  fwd = anglesToForward(self.angles);
  _id_CDD53D78F51F6B97 = anglestoright(self.angles);
  _id_46EF3E042B2E6565 = anglestoleft(self.angles);
  org = self.origin + (0, 0, -110);
  _id_5CAA709F456AD8E3 = org + fwd * 20 + _id_46EF3E042B2E6565 * 45;
  _id_5CAA769F456AE615 = org + fwd * 20 + _id_CDD53D78F51F6B97 * 45;
  _id_5CAA759F456AE3E2 = org + fwd * -20 + _id_46EF3E042B2E6565 * 45;
  _id_5CAA739F456ADF7C = org + fwd * -20 + _id_CDD53D78F51F6B97 * 45;
  create_vehicle_interaction(_id_5CAA709F456AD8E3, &"CP_VEHICLE_TRAVEL/ENTER", "seat4", self);
  create_vehicle_interaction(_id_5CAA769F456AE615, &"CP_VEHICLE_TRAVEL/ENTER", "seat2", self);
  create_vehicle_interaction(_id_5CAA759F456AE3E2, &"CP_VEHICLE_TRAVEL/ENTER", "seat3", self);
  create_vehicle_interaction(_id_5CAA739F456ADF7C, &"CP_VEHICLE_TRAVEL/ENTER", "seat1", self);
}

create_vehicle_interaction(loc, hintstring, name, vehicle) {
  interaction = spawn("script_model", loc);
  interaction setModel("tag_origin");
  interaction setHintString(hintstring);
  interaction setCursorHint("HINT_BUTTON");
  interaction sethintdisplayrange(200);
  interaction sethintdisplayfov(90);
  interaction setuserange(72);
  interaction setusefov(90);
  interaction sethintonobstruction("hide");
  interaction setuseholdduration("duration_short");
  interaction thread use_think(vehicle, name);
}

use_think(vehicle, name) {
  self makeusable();

  for(;;) {
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(isDefined(level.nuclear_core)) {
      if(!isDefined(level.nuclear_core_carrier)) {
        iprintln(" PICK THE CORE UP BEFORE LEAVING! ");
        continue;
      }
    }

    self makeunusable();
    player scripts\cp\infilexfil\infilexfil::infil_player_allow_cp(0);
    waitframe();
    player thread scripts\cp\vehicles\cp_heli_trip::playerpassengerthink();
    player.inchopper = 1;
  }
}

allow_players_exfil() {
  foreach(player in level.players)
  player notify("allow_exfil");
}

player_listen_for_exfil() {
  self endon("disconnect");
  self waittill("allow_exfil");

  for(;;) {
    if(self useButtonPressed() && self getcurrentweapon().basename == "ks_remote_map_cp") {
      self iprintlnbold("EXFIL CALLED");
      level notify("call_exfil", self.origin);
      return;
    }

    if(self meleeButtonPressed()) {
      _id_0A0CBA5C6F46200E = 0;

      while(self meleeButtonPressed()) {
        _id_0A0CBA5C6F46200E++;
        wait 0.05;

        if(_id_0A0CBA5C6F46200E >= 60) {
          break;
        }
      }

      if(_id_0A0CBA5C6F46200E >= 60) {
        self iprintlnbold("EXFIL CALLED");
        level notify("call_exfil", self.origin);
        return;
      }
    }

    wait 0.1;
  }
}

_id_387B5E2E4B970437(_id_F94346053E3F63E5, _id_E1E1732F234CF593, _id_CF805CD60EF50D4F, custompassengerwaitfunc) {
  if(!isDefined(_id_F94346053E3F63E5))
    _id_F94346053E3F63E5 = "exfil_location";

  self notify("listen_for_exfil_" + _id_F94346053E3F63E5);
  self endon("listen_for_exfil_" + _id_F94346053E3F63E5);

  if(!isDefined(_id_E1E1732F234CF593))
    _id_E1E1732F234CF593 = "player_exfil";

  level waittill("call_exfil_" + _id_F94346053E3F63E5, pos, _id_37E32CD4230D5E54);
  _id_2F5BE15466F1811D = scripts\engine\utility::getStruct(_id_E1E1732F234CF593, "targetname");

  if(isDefined(level.player_exfil_struct))
    _id_2F5BE15466F1811D = level.player_exfil_struct;

  _id_2F5BE15466F1811D.vehicletype = "blima_cp";
  heli = _id_AA22AC000BB68A77(_id_2F5BE15466F1811D);
  heli thread _id_8E002FAA7893C07C(pos, _id_F94346053E3F63E5, _id_CF805CD60EF50D4F, custompassengerwaitfunc);

  if(istrue(_id_37E32CD4230D5E54)) {
    level.exfil_heli = heli;
    return heli;
  }
}

_id_8E002FAA7893C07C(pos, _id_F94346053E3F63E5, _id_CF805CD60EF50D4F, custompassengerwaitfunc) {
  heli = self;
  exfil_struct = scripts\engine\utility::getclosest(pos, scripts\engine\utility::getStructArray(_id_F94346053E3F63E5, "targetname"));

  if(isDefined(level.use_airdrop_fx))
    magicgrenademanual("deploy_airdrop_mp", getgroundposition(exfil_struct.origin, 16), (0, 90, 0), 0.01);
  else
    exfil_struct.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(exfil_struct.origin, 1);

  heli.exfil_struct = exfil_struct;
  objnum = _id_283C1BA04595D987(heli, exfil_struct);
  heli thread rumble_nearby_players();
  heli thread wait_while_exfil_arrives(objnum);
  heli waittill("wait_done");

  if(isDefined(_id_CF805CD60EF50D4F))
    heli go_to_exfil_location(exfil_struct, _id_CF805CD60EF50D4F);
  else
    heli go_to_exfil_location(exfil_struct, 1);

  heli _id_09149F78899F36B7(heli, objnum, custompassengerwaitfunc);
}

_id_AA22AC000BB68A77(_id_2F5BE15466F1811D) {
  heli = scripts\common\vehicle::vehicle_spawn(_id_2F5BE15466F1811D);
  heli thread damage_players_on_blades();
  heli.godmode = 1;
  heli.health = 100000;
  heli.maxhealth = 100000;
  heli.team = "allies";
  heli.script_team = "allies";
  heli setvehicleteam("allies");
  heli setCanDamage(0);
  thread spawn_vehicle_actors(heli);
  return heli;
}

_id_283C1BA04595D987(heli, exfil_struct) {
  objnum = scripts\cp\cp_objectives::requestworldid("exfil_loc", 10);
  objective_state(objnum, "current");
  objective_position(objnum, exfil_struct.origin - (0, 0, 100));
  objective_icon(objnum, "icon_waypoint_objective_general");
  objective_setminimapiconsize(objnum, "icon_regular");
  objective_setshowdistance(objnum, 1);
  objective_setplayintro(objnum, 1);
  heli.headicon = createheadicon(heli);
  setheadiconimage(heli.headicon, "hud_icon_head_equipment_friendly");
  setheadiconmaxdistance(heli.headicon, 12000);
  setheadiconnaturaldistance(heli.headicon, 1500);
  setheadiconzoffset(heli.headicon, 10);
  setheadiconsnaptoedges(heli.headicon, 1);
  heli.objnum = objnum;
  return objnum;
}

listen_for_exfil(_id_F94346053E3F63E5, _id_CF805CD60EF50D4F, custompassengerwaitfunc) {
  self notify("listen_for_exfil");
  self endon("listen_for_exfil");

  if(!isDefined(_id_F94346053E3F63E5))
    _id_F94346053E3F63E5 = "exfil_location";

  level waittill("call_exfil", pos, _id_37E32CD4230D5E54);
  _id_2F5BE15466F1811D = scripts\engine\utility::getStruct("player_exfil", "targetname");

  if(isDefined(level.player_exfil_struct))
    _id_2F5BE15466F1811D = level.player_exfil_struct;

  _id_2F5BE15466F1811D.vehicletype = "blima_cp";
  heli = scripts\common\vehicle::vehicle_spawn(_id_2F5BE15466F1811D);
  heli thread damage_players_on_blades();
  heli.godmode = 1;
  heli.health = 100000;
  heli.maxhealth = 100000;
  heli.team = "allies";
  heli.script_team = "allies";
  heli setvehicleteam("allies");
  heli setCanDamage(0);

  if(istrue(_id_37E32CD4230D5E54))
    level.exfil_heli = heli;

  exfil_struct = scripts\engine\utility::getclosest(pos, scripts\engine\utility::getStructArray(_id_F94346053E3F63E5, "targetname"));

  if(isDefined(level.use_airdrop_fx))
    magicgrenademanual("deploy_airdrop_mp", getgroundposition(exfil_struct.origin, 16), (0, 90, 0), 0.01);
  else
    exfil_struct.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(exfil_struct.origin, 1);

  heli.exfil_struct = exfil_struct;
  objnum = scripts\cp\cp_objectives::requestworldid("exfil_loc", 10);
  objective_state(objnum, "current");
  objective_position(objnum, exfil_struct.origin - (0, 0, 100));
  objective_icon(objnum, "icon_waypoint_objective_general");
  objective_setminimapiconsize(objnum, "icon_regular");
  objective_setshowdistance(objnum, 1);
  objective_setplayintro(objnum, 1);
  heli.headicon = createheadicon(heli);
  setheadiconimage(heli.headicon, "hud_icon_head_equipment_friendly");
  setheadiconmaxdistance(heli.headicon, 12000);
  setheadiconnaturaldistance(heli.headicon, 1500);
  setheadiconzoffset(heli.headicon, 10);
  setheadiconsnaptoedges(heli.headicon, 1);
  heli.objnum = objnum;
  spawn_vehicle_actors(heli);
  heli thread rumble_nearby_players();
  heli thread wait_while_exfil_arrives(objnum);
  heli waittill("wait_done");

  if(isDefined(_id_CF805CD60EF50D4F))
    heli go_to_exfil_location(exfil_struct, _id_CF805CD60EF50D4F);
  else
    heli go_to_exfil_location(exfil_struct, 1);

  heli exfil_players(heli, objnum, custompassengerwaitfunc);
}

go_to_exfil_location(exfil_struct, _id_32C0ED10586351AB, _id_EA300F7C7016466D) {
  if(!isDefined(exfil_struct.angles))
    exfil_struct.angles = (0, 0, 0);

  self.going_to_exfil = 1;

  if(!isDefined(_id_EA300F7C7016466D) || !istrue(_id_EA300F7C7016466D))
    self vehicleplayanim(%est_blima_doors_open);

  self vehicle_setspeed(90, 30);
  self setvehgoalpos(exfil_struct.origin + (0, 0, 1200), 1);
  self waittill("goal");
  self vehicle_setspeed(15, 10);
  arrive_at_exfil_location(self);
}

wait_while_exfil_arrives(objectiveindex) {
  objective_setlabel(objectiveindex, &"CP_BR_SYRK_OBJECTIVES/EXFIL_ENROUTE");
  level thread scripts\cp\utility::objective_update("exfil_enroute");
  objective_setshowprogress(objectiveindex, 1);
  objective_setprogress(objectiveindex, 0);
  objective_setbackground(objectiveindex, 1);
  time = 10;
  progress = 10;

  for(;;) {
    wait 1;
    progress--;
    objective_setprogress(objectiveindex, progress / time);

    if(progress <= 15)
      self notify("wait_done");

    if(progress <= 0)
      return;
  }
}

heli_cleanup_exfil_area(heli) {
  heli endon("death");
  level notify("starting_cleanup");
  heli.minigun setturretteam("allies");
  heli.minigun setmode("manual");
  nextfiretime = gettime();
  _id_D1CCB3CF97AD85F5 = 0;

  for(;;) {
    _id_EC80496532425417 = heli get_nearby_enemy(heli.exfil_struct.origin + (0, 0, -150));

    if(!isDefined(_id_EC80496532425417)) {
      heli.minigun cleartargetentity();
      wait 1;
      _id_D1CCB3CF97AD85F5++;

      if(_id_D1CCB3CF97AD85F5 >= 3)
        return;
    } else {
      _id_D1CCB3CF97AD85F5 = 0;
      _id_119D71E3F7006F18 = _id_EC80496532425417.origin + (0, 0, 1100);
      heli.minigun settargetentity(_id_EC80496532425417);

      if(distance(_id_119D71E3F7006F18, heli.origin) > 500)
        heli setvehgoalpos(_id_119D71E3F7006F18, 1);

      msg = heli.minigun scripts\engine\utility::waittill_notify_or_timeout_return("turret_on_target", 3);

      if(msg == "timeout") {
        heli.minigun cleartargetentity();
        continue;
      } else if(gettime() > nextfiretime) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 35; _id_AC0E594AC96AA3A8++) {
          heli.minigun shootturret();
          wait 0.1;
        }

        nextfiretime = gettime() + 1000;
      }
    }
  }
}

arrive_at_exfil_location(heli) {
  heli setvehgoalpos(heli.exfil_struct.origin + (0, 0, 1200), 1);
  heli waittill("goal");
  heli settargetyaw(heli.exfil_struct.angles[1]);
  heli setyawspeed(50, 25, 25, 0);
  wait 3;
  level notify("arrive_at_exfil_location", heli.origin);
  level.exfil_heli_landing = heli;
  heli thread keep_from_crushing_players();
  heli thread destroy_vehicles();
  heli.goalradius = 4;
  heli setvehgoalpos(heli.exfil_struct.origin, 1);
  heli waittill("goal");
  heli vehicle_setspeedimmediate(0);
  heli vehicle_cleardrivingstate();
  level notify("arrived_at_exfil_location");
  level.exfil_heli_landing = undefined;
}

destroy_vehicles() {
  self endon("goal");
  wait 4;

  if(!isDefined(level.vehicle)) {
    return;
  }
  if(!isDefined(level.vehicle.instances)) {
    return;
  }
  foreach(_id_C58342F14EFEE4CA in level.vehicle.instances) {
    foreach(vehicle in _id_C58342F14EFEE4CA) {
      if(!isDefined(vehicle) || !isDefined(vehicle.origin)) {
        continue;
      }
      if(vehicle == self) {
        continue;
      }
      if(distance2d(vehicle.origin, self.origin) < 512)
        vehicle dodamage(vehicle.health + 1000, self.origin);
    }
  }
}

keep_from_crushing_players() {
  self endon("goal");

  for(;;) {
    foreach(player in level.players) {
      if(player istouching(self))
        thread move_player_from_under_heli(player);

      thread kill_sentries(player);
      thread kill_tac_covers(player);
    }

    if(isDefined(level.hvtlist)) {
      foreach(_id_0BA89A03FF462799 in level.hvtlist) {
        if(isDefined(_id_0BA89A03FF462799) && !istrue(_id_0BA89A03FF462799.carried) && distance2d(self.origin, _id_0BA89A03FF462799.origin) <= 200)
          thread move_hvt_from_under_heli(_id_0BA89A03FF462799);
      }
    }

    waitframe();
  }
}

kill_tac_covers(player) {
  if(isDefined(player.taccovers) && isarray(player.taccovers) && player.taccovers.size > 0) {
    foreach(_id_E8A8B3A28BB94537 in player.taccovers) {
      if(isDefined(_id_E8A8B3A28BB94537) && isDefined(_id_E8A8B3A28BB94537.collision)) {
        if(_id_E8A8B3A28BB94537 istouching(self) || _id_E8A8B3A28BB94537.collision istouching(self))
          _id_E8A8B3A28BB94537 scripts\cp\powers\cp_tactical_cover::tac_cover_delete(0.05);
      }
    }
  }
}

kill_sentries(player) {
  if(isDefined(player.placedsentries)) {
    if(isDefined(player.placedsentries["sentry_turret"]) && isarray(player.placedsentries["sentry_turret"]) && player.placedsentries["sentry_turret"].size > 0) {
      foreach(turret in player.placedsentries["sentry_turret"]) {
        if(isDefined(turret)) {
          if(turret istouching(self))
            turret notify("kill_turret", 1, 0);
        }
      }
    }

    if(isDefined(player.placedsentries["manual_turret"]) && isarray(player.placedsentries["manual_turret"]) && player.placedsentries["manual_turret"].size > 0) {
      foreach(turret in player.placedsentries["manual_turret"]) {
        if(isDefined(turret)) {
          if(turret istouching(self))
            turret notify("kill_turret", 1, 0);
        }
      }
    }
  }
}

move_player_from_under_heli(player) {
  _id_06A3A1033FFC2699 = player.origin - self.origin;
  _id_06A3A1033FFC2699 = vectorNormalize(_id_06A3A1033FFC2699);
  _id_06A3A1033FFC2699 = _id_06A3A1033FFC2699 * 200;
  _id_06A3A1033FFC2699 = (_id_06A3A1033FFC2699[0], _id_06A3A1033FFC2699[1], 0);
  player setOrigin(player.origin + _id_06A3A1033FFC2699, 1);
}

move_hvt_from_under_heli(_id_0BA89A03FF462799) {
  _id_06A3A1033FFC2699 = _id_0BA89A03FF462799.origin - self.origin;
  _id_06A3A1033FFC2699 = vectorNormalize(_id_06A3A1033FFC2699);
  _id_06A3A1033FFC2699 = _id_06A3A1033FFC2699 * 200;
  _id_06A3A1033FFC2699 = (_id_06A3A1033FFC2699[0], _id_06A3A1033FFC2699[1], 0);
  _id_0BA89A03FF462799.origin = _id_0BA89A03FF462799.origin + _id_06A3A1033FFC2699;
  _id_0BA89A03FF462799 notify("displaced");
}

get_nearby_enemy(org, _id_465A06BAE1ABB77E) {
  if(!isDefined(_id_465A06BAE1ABB77E))
    _id_465A06BAE1ABB77E = 2250000;

  guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  guys = sortbydistance(guys, self.origin);

  foreach(guy in guys) {
    if(!isalive(guy)) {
      continue;
    }
    if(distancesquared(guy.origin, org) < _id_465A06BAE1ABB77E && scripts\engine\trace::ray_trace_passed(self.origin + (0, 0, -250), guy.origin + (0, 0, 100), guys))
      return guy;
  }

  return undefined;
}

heli_mg_create(_id_E686BAEE775AD49F, turret_weapon) {
  tag = "tag_flash";
  _id_1E2F2224127D2990 = (-64, 0, 0);
  origin = self gettagorigin(tag);

  if(!isDefined(turret_weapon))
    turret_weapon = "sentry_minigun_mp";

  self.minigun = spawnturret("misc_turret", origin, turret_weapon);
  self.minigun.angles = self gettagangles(tag);

  if(isDefined(_id_E686BAEE775AD49F))
    self.minigun setModel(_id_E686BAEE775AD49F);
  else
    self.minigun setModel("veh8_mil_air_ahotel64_turret_wm");

  self.minigun linkTo(self, tag, _id_1E2F2224127D2990, (0, 0, 0));
  self.minigun setturretteam("axis");
  self.minigun setmode("auto_nonai");
  self.minigun setdefaultdroppitch(0);
  self.minigun setleftarc(360);
  self.minigun setrightarc(360);
  self.minigun settoparc(180);
  self.minigun setbottomarc(180);
  self.minigun setconvergencetime(0.05, "yaw");
  self.minigun setconvergencetime(0.05, "pitch");
}

rumble_nearby_players() {
  self endon("death");

  for(;;) {
    playrumbleonposition("cp_chopper_rumble", self.origin);
    wait 0.2;
  }
}

rideloop(player) {
  level endon("game_ended");
  player endon("death");
  player endon("disconnect");

  for(;;)
    scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "exfil_idle", "body_animate_jnt");
}

damage_players_on_blades() {
  self endon("death");
  _id_ABD2EE0E56B7AFBC = spawn("trigger_radius", self.origin, 0, 350, 64);
  _id_ABD2EE0E56B7AFBC enablelinkTo();
  _id_ABD2EE0E56B7AFBC linkTo(self, "tag_origin");
  _id_C30D67B7A7E94F1C = spawn("trigger_radius", self gettagorigin("tail_rotor_jnt"), 0, 64, 64);
  _id_C30D67B7A7E94F1C enablelinkTo();
  _id_C30D67B7A7E94F1C linkTo(self, "tail_rotor_jnt");
  _id_ABD2EE0E56B7AFBC thread blade_trigger_think(self);
  _id_C30D67B7A7E94F1C thread blade_trigger_think(self);
}

blade_trigger_think(heli) {
  heli endon("death");

  for(;;) {
    self waittill("trigger", ent);

    if(!isPlayer(ent)) {
      continue;
    }
    if(istrue(ent.inlaststand)) {
      ent notify("force_bleed_out");
      continue;
    }

    if(istrue(ent.isjuggernaut))
      ent scripts\cp\cp_juggernaut::jugg_removejuggernaut();

    ent setvelocity((-500, 0, 500));
    ent.shouldskiplaststand = 1;
    ent dodamage(ent.health + 1000, self.origin);
  }
}

_id_A195B29BF788FBC7() {
  _id_71332A5B74214116::register_interaction("exfil_spot", "null", undefined, ::_id_1EF16B5BEAD75324, ::_id_F0E0473D6C709FDC, 0, 0, ::_id_B540A63F7D14E39F);
}

_id_053B91A8CA24AD84(active) {
  while(!isDefined(level._id_EC373B5131038E2D))
    wait 0.1;

  if(istrue(active)) {
    objnum = scripts\cp\cp_objectives::requestworldid("exfil_loc", 10);
    objective_state(objnum, "current");
    objective_icon(objnum, "icon_waypoint_objective_general");
    objective_setminimapiconsize(objnum, "icon_regular");
    objective_setshowdistance(objnum, 1);
    objective_setplayintro(objnum, 1);
    objective_setlabel(objnum, &"CP_STRIKE/CALL_EXFIL");

    foreach(_id_DF071553D0996FF9 in level._id_EC373B5131038E2D) {
      objective_position(objnum, _id_DF071553D0996FF9.origin);
      _id_71332A5B74214116::add_to_current_interaction_list(_id_DF071553D0996FF9);
    }
  } else {
    foreach(_id_DF071553D0996FF9 in level._id_EC373B5131038E2D)
    _id_71332A5B74214116::remove_from_current_interaction_list(_id_DF071553D0996FF9);
  }
}

_id_B540A63F7D14E39F(_id_6071184F8A3861B3) {
  level._id_EC373B5131038E2D = _id_6071184F8A3861B3;

  foreach(_id_DF071553D0996FF9 in _id_6071184F8A3861B3)
  _id_71332A5B74214116::add_to_current_interaction_list(_id_DF071553D0996FF9);
}

_id_1EF16B5BEAD75324(_id_DF071553D0996FF9, player) {
  return &"CP_STRIKE/CALL_EXFIL";
}

_id_F0E0473D6C709FDC(_id_DF071553D0996FF9, player) {
  player endon("disconnect");
  scripts\cp\cp_objectives::freeworldid("exfil_loc");
  level notify("call_exfil", player.origin, 1);
  _id_71332A5B74214116::remove_from_current_interaction_list(_id_DF071553D0996FF9);
  player _id_71332A5B74214116::refresh_interaction();
}