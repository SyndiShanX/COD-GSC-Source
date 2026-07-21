/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\infilexfil\blima_exfil.gsc
***********************************************/

player_exfil_think(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  thread scripts\cp\cp_infilexfil::infil_player_rig(var_1, "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A");
  self.player_rig.weapon_state_func = scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  self.player_rig linkTo(var_0, "_encstr_9AD01136187923E791B06F67D06B9509DD203B", (0, 0, 0), (0, 0, 0));
  self lerpfovbypreset("_encstr_82300B7081FA4BE6E6D10BB9E8");
  self setdemeanorviewmodel("_encstr_B418059B8533CA", "_encstr_AA1A1B967707FAECCA37F519596BCA0BCDB79CBE9B16CCCAAFA1ACD84B");
  var_0 scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "_encstr_8A12060D5BA9C745", "_encstr_9AD01136187923E791B06F67D06B9509DD203B");
  var_0 thread rideloop(self);
}

spawnactors(var_0, var_1, var_2) {
  initanims();

  if(!isDefined(self.actors))
    self.actors = [];

  self.actors[self.actors.size] = spawn_anim_model("_encstr_A266062032BD7723", "_encstr_9AD01136187923E791B06F67D06B9509DD203B", "_encstr_9AC718AB8029F13F41290B6854A584408CC3C15D3EEFBBEB8F02");
}

spawn_anim_model(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_6 setModel(var_2);

  if(isDefined(var_3)) {
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_7 setModel(var_3);
    var_7 linkTo(var_6, "_encstr_8EEC09159F6238030BFA23", (0, 0, 0), (0, 0, 0));
    var_6.head = var_7;
    var_6 thread scripts\engine\utility::delete_on_death(var_7);
  }

  if(isDefined(var_5)) {
    var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_8 setModel(var_5);
    var_8 linkTo(var_6.head, "_encstr_8EEC09159F6238030BFA23", (0, 0, 0), (0, 0, 0));
    var_6.hat = var_8;
    var_6 thread scripts\engine\utility::delete_on_death(var_8);
  }

  var_6.animname = var_0;
  var_6 scripts\common\anim::setanimtree();

  if(isDefined(var_1)) {
    thread scripts\engine\utility::delete_on_death(var_6);
    var_6 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  }

  return var_6;
}

initanims(var_0) {
  script_model_anims();
  vehicle_anims();
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

script_model_anims() {
  level.scr_animtree["_encstr_A266062032BD7723"] = #animtree;
  level.scr_anim["_encstr_A266062032BD7723"]["_encstr_8A12060D5BA9C745"] = % _encstr_B84A1673790882CCD038D6513378185BFD994FE3C3C91AAC;
  level.scr_animname["_encstr_A266062032BD7723"]["_encstr_8A12060D5BA9C745"] = "_encstr_B84A1673790882CCD038D6513378185BFD994FE3C3C91AAC";
  level.scr_animtree["_encstr_9B7408BFEF17BA445893"] = #animtree;
  level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_8A12060D5BA9C745"] = % _encstr_A242183BA17D133696DA2CAF3958E0E059D8AF1BDB1CD2D8F61D;
  level.scr_animname["_encstr_9B7408BFEF17BA445893"]["_encstr_8A12060D5BA9C745"] = "_encstr_A242183BA17D133696DA2CAF3958E0E059D8AF1BDB1CD2D8F61D";
  level.scr_animtree["_encstr_8D30066E2BB0D113"] = #animtree;
  level.scr_anim["_encstr_8D30066E2BB0D113"]["_encstr_8A12060D5BA9C745"] = % _encstr_96C8188FF9A03DE13124FC49961DDC6ACB19C0F81220ABA907BB;
  level.scr_animname["_encstr_8D30066E2BB0D113"]["_encstr_8A12060D5BA9C745"] = "_encstr_96C8188FF9A03DE13124FC49961DDC6ACB19C0F81220ABA907BB";
  level.scr_eventanim["_encstr_8D30066E2BB0D113"]["_encstr_8A12060D5BA9C745"] = "_encstr_8D7413B5B3F70449A1B6F5A0F080D9B760E86B7989";
  level.scr_anim["_encstr_8D30066E2BB0D113"]["_encstr_B1360B93BB3AEB633734F9F0DF"] = % _encstr_AD641DC387C1527BC6504C77AD81EC4DEB291ADD551282C0E8D1785868BB18;
  level.scr_animname["_encstr_8D30066E2BB0D113"]["_encstr_B1360B93BB3AEB633734F9F0DF"] = "_encstr_AD641DC387C1527BC6504C77AD81EC4DEB291ADD551282C0E8D1785868BB18";
  level.scr_eventanim["_encstr_8D30066E2BB0D113"]["_encstr_B1360B93BB3AEB633734F9F0DF"] = "_encstr_A1DE182B3816BFAB09C881D8789169370B345C7782C64120F887";
  level.scr_animtree["_encstr_AF3006C31D817B2A"] = #animtree;
  level.scr_anim["_encstr_AF3006C31D817B2A"]["_encstr_8A12060D5BA9C745"] = % _encstr_96CF188D83AF59C399A5C6AF26D85A6B167D07B19C0391D7BB6B;
  level.scr_animname["_encstr_AF3006C31D817B2A"]["_encstr_8A12060D5BA9C745"] = "_encstr_96CF188D83AF59C399A5C6AF26D85A6B167D07B19C0391D7BB6B";
  level.scr_eventanim["_encstr_AF3006C31D817B2A"]["_encstr_8A12060D5BA9C745"] = "_encstr_8C741367320851F280ED93BFCBB7099520F8DB61E3";
  level.scr_anim["_encstr_AF3006C31D817B2A"]["_encstr_B1360B93BB3AEB633734F9F0DF"] = % _encstr_B8B91D1BE0BEAC0FCC4B1BAFC4B12DDA16AF1C8D2706C8FA4B19D856EBDDB5;
  level.scr_animname["_encstr_AF3006C31D817B2A"]["_encstr_B1360B93BB3AEB633734F9F0DF"] = "_encstr_B8B91D1BE0BEAC0FCC4B1BAFC4B12DDA16AF1C8D2706C8FA4B19D856EBDDB5";
  level.scr_eventanim["_encstr_AF3006C31D817B2A"]["_encstr_B1360B93BB3AEB633734F9F0DF"] = "_encstr_A28218075059F15A1F96B5EC090B2185E2B0DB67BAD63922A13D";
  level.scr_animtree["_encstr_9A30069BCAC649C3"] = #animtree;
  level.scr_anim["_encstr_9A30069BCAC649C3"]["_encstr_8A12060D5BA9C745"] = % _encstr_BDD918EA8AD7EA1BEEF8F4F9EE624B9AEF97E0A11ECB8BD16BA5;
  level.scr_animname["_encstr_9A30069BCAC649C3"]["_encstr_8A12060D5BA9C745"] = "_encstr_BDD918EA8AD7EA1BEEF8F4F9EE624B9AEF97E0A11ECB8BD16BA5";
  level.scr_eventanim["_encstr_9A30069BCAC649C3"]["_encstr_8A12060D5BA9C745"] = "_encstr_9A7413B21E995AB1AF13B196D6C2BE593C4B1D7D99";
  level.scr_anim["_encstr_9A30069BCAC649C3"]["_encstr_B1360B93BB3AEB633734F9F0DF"] = % _encstr_A5871D924BA79FF8D064D9570E9958587030F3A84227734FE05DAB52273F20;
  level.scr_animname["_encstr_9A30069BCAC649C3"]["_encstr_B1360B93BB3AEB633734F9F0DF"] = "_encstr_A5871D924BA79FF8D064D9570E9958587030F3A84227734FE05DAB52273F20";
  level.scr_eventanim["_encstr_9A30069BCAC649C3"]["_encstr_B1360B93BB3AEB633734F9F0DF"] = "_encstr_8D9E18951E66A5B1BE31C6D2B52CFA95C3D23AEB66BED2321B59";
  level.scr_animtree["_encstr_8C3006B9ACC21D0D"] = #animtree;
  level.scr_anim["_encstr_8C3006B9ACC21D0D"]["_encstr_8A12060D5BA9C745"] = % _encstr_B89F18D807D7591E332D1BFA3163A5B52CBE1CB1E40C86F5DDAD;
  level.scr_animname["_encstr_8C3006B9ACC21D0D"]["_encstr_8A12060D5BA9C745"] = "_encstr_B89F18D807D7591E332D1BFA3163A5B52CBE1CB1E40C86F5DDAD";
  level.scr_eventanim["_encstr_8C3006B9ACC21D0D"]["_encstr_8A12060D5BA9C745"] = "_encstr_B1021897C2F8A102107D030F7B2779E5B0484B91B3D979BAD11B";
  level.scr_anim["_encstr_8C3006B9ACC21D0D"]["_encstr_B1360B93BB3AEB633734F9F0DF"] = % _encstr_AD121DD8E0F52BE1335A8DF513C64BD658AFE036E40668FAA5911B957DBBB5;
  level.scr_animname["_encstr_8C3006B9ACC21D0D"]["_encstr_B1360B93BB3AEB633734F9F0DF"] = "_encstr_AD121DD8E0F52BE1335A8DF513C64BD658AFE036E40668FAA5911B957DBBB5";
  level.scr_eventanim["_encstr_8C3006B9ACC21D0D"]["_encstr_B1360B93BB3AEB633734F9F0DF"] = "_encstr_B1021897C2F8A102107D030F7B2779E5B0484B91B3D979BAD11B";
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");

vehicle_anims() {
  level.scr_animtree["_encstr_BD9E0EA7DBEA038131D343F0A34890C0"] = #animtree;
}

exfil_players(var_0, var_1, var_2) {
  scripts\cp\vehicles\cp_heli_trip::initanims();
  level.heli_trip_vehicle = var_0;

  if(isDefined(var_2) && isbuiltinfunction(var_2))
    level.heli_trip_vehicle thread[[var_2]]();
  else
    level.heli_trip_vehicle thread scripts\cp\vehicles\cp_heli_trip::wait_for_passengers(0);

  objective_setlabel(var_1, &"_encstr_B12B15A1486D612ED791717DB7B3748B40D619813034E1");
  level.heli_trip_vehicle scripts\engine\utility::_id_143A5("_encstr_84B715C263D8BE38B158E5CAE4B9EB7B377D89F6C23991", "_encstr_829314BC09C0C969AD752F43C755F23560B1F9C5A358");
  level notify("_encstr_969F0F27560BC8CBEB47EDEBB2873396B1");
  objective_delete(var_1);
  var_0 thread leave_and_end_game();
}

spawn_vehicle_actors(var_0) {
  var_0.animname = "_encstr_BD9E0EA7DBEA038131D343F0A34890C0";
  var_0 spawnactors();
  var_0 thread actorloopthink();
}

leave_and_end_game() {
  wait 1;
  self cleargoalyaw();
  self vehicle_setspeed(15, 10);
  var_0 = self.origin + (0, 0, 1200);
  self setvehgoalpos(var_0, 1);
  wait 5;

  if(isDefined(self.onexitfunc))
    self vehicle_setspeed(self.onexitfunc, 20);
  else
    self vehicle_setspeed(60, 20);

  if(isDefined(self.exfil_struct) && isDefined(self.exfil_struct.target)) {
    var_1 = scripts\engine\utility::getStructArray(self.exfil_struct.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = var_1[0];
    var_3 = (var_2.origin[0], var_2.origin[1], self.origin[2]);
    var_4 = vectorNormalize(var_3 - self.origin);
    var_4 = var_4 * 20000;
    self setvehgoalpos(var_0 + var_4);
  } else
    self setvehgoalpos(var_0 + (0, -20000, 0));

  if(scripts\engine\utility::flag_exist("_encstr_93D00ED3760F28BFBF521679BA5367CB"))
    scripts\engine\utility::flag_wait("_encstr_93D00ED3760F28BFBF521679BA5367CB");
  else
    wait 4;

  wait 3;
  level thread[[level.endgame]]("_encstr_9A8507BA4040188D08", level.end_game_string_index["_encstr_91190447C232"]);
}

all_alive_players_in_chopper() {
  var_0 = 0;
  var_1 = 0;
  var_2 = [];
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5.team == "_encstr_8E8405EA382B2A") {
      var_2[var_2.size] = var_5;
      continue;
    }

    var_3[var_3.size] = var_5;
  }

  foreach(var_5 in var_3) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_5) || var_5 isspectatingplayer())
      var_1++;

    if(istrue(var_5.inchopper))
      var_0++;
  }

  return var_0 > 0 && var_3.size == var_0 + var_1;
}

wait_for_all_players_ready() {
  for(;;) {
    if(all_alive_players_in_chopper()) {
      level notify("_encstr_969F0F27560BC8CBEB47EDEBB2873396B1");
      return;
    }

    wait 0.1;
  }
}

actorloopthink() {
  thread actorloop(self.actors[0], "_encstr_AB680B55361AD76B09EB28E886");
}

actorloop(var_0, var_1) {
  self endon("_encstr_81A8077D3088BFA631");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  scripts\common\anim::anim_single_solo(var_0, "_encstr_8A12060D5BA9C745", var_1);
}

init_interactions() {
  var_0 = anglesToForward(self.angles);
  var_1 = anglestoright(self.angles);
  var_2 = anglestoleft(self.angles);
  var_3 = self.origin + (0, 0, -110);
  var_4 = var_3 + var_0 * 20 + var_2 * 45;
  var_5 = var_3 + var_0 * 20 + var_1 * 45;
  var_6 = var_3 + var_0 * -20 + var_2 * 45;
  var_7 = var_3 + var_0 * -20 + var_1 * 45;
  create_vehicle_interaction(var_4, &"_encstr_AC5B188F21D0193D3144B64DFDB1141187B51FCBB77520E4B1CF", "_encstr_8C3006B9ACC21D0D", self);
  create_vehicle_interaction(var_5, &"_encstr_AC5B188F21D0193D3144B64DFDB1141187B51FCBB77520E4B1CF", "_encstr_AF3006C31D817B2A", self);
  create_vehicle_interaction(var_6, &"_encstr_AC5B188F21D0193D3144B64DFDB1141187B51FCBB77520E4B1CF", "_encstr_9A30069BCAC649C3", self);
  create_vehicle_interaction(var_7, &"_encstr_AC5B188F21D0193D3144B64DFDB1141187B51FCBB77520E4B1CF", "_encstr_8D30066E2BB0D113", self);
}

create_vehicle_interaction(var_0, var_1, var_2, var_3) {
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_4 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_4 setHintString(var_1);
  var_4 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_4 sethintdisplayrange(200);
  var_4 sethintdisplayfov(90);
  var_4 setuserange(72);
  var_4 setusefov(90);
  var_4 sethintonobstruction("_encstr_BECC055CF3811A");
  var_4 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_4 thread use_think(var_3, var_2);
}

use_think(var_0, var_1) {
  self makeusable();

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(isDefined(level.nuclear_core)) {
      if(!isDefined(level.nuclear_core_carrier)) {
        iprintln("_encstr_8CFE239011F96697AF4F4880D946CF6A21597D6809493F9B30E790DE7CAD2FD3291DE7E1A1");
        continue;
      }
    }

    self makeunusable();
    var_2 scripts\cp\infilexfil\infilexfil::infil_player_allow_cp(0);
    waitframe();
    var_2 thread scripts\cp\vehicles\cp_heli_trip::playerpassengerthink();
    var_2.inchopper = 1;
  }
}

do_fadeout() {
  self.endgame_overlay = newclienthudelem(self);
  self.endgame_overlay.x = 0;
  self.endgame_overlay.y = 0;
  self.endgame_overlay setshader("_encstr_83AB065EE1391A7B", 640, 480);
  self.endgame_overlay.alignx = "_encstr_A5AD056A019C63";
  self.endgame_overlay.aligny = "_encstr_AC190479FF92";
  self.endgame_overlay.sort = 1;
  self.endgame_overlay.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.endgame_overlay.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.endgame_overlay.alpha = 0;
  self.endgame_overlay.foreground = 1;
  self.endgame_overlay fadeovertime(3);
  self.endgame_overlay.alpha = 1;
}

allow_players_exfil() {
  foreach(var_1 in level.players)
  var_1 notify("_encstr_BDA00CB7D14AB7B731D580D1C7A8");
}

player_listen_for_exfil() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_BDA00CB7D14AB7B731D580D1C7A8");

  for(;;) {
    if(self useButtonPressed() && self getcurrentweapon().basename == "_encstr_9A2011B5CDAF272BADB7D1ACF56B0BC1BEB1C1") {
      self iprintlnbold("_encstr_B13C0D4DB9395C23077530E8BC9D5B");
      level notify("_encstr_91750BE60B41C076B37326D770", self.origin);
      return;
    }

    if(self meleeButtonPressed()) {
      var_0 = 0;

      while(self meleeButtonPressed()) {
        var_0++;
        wait 0.05;

        if(var_0 >= 60) {
          break;
        }
      }

      if(var_0 >= 60) {
        self iprintlnbold("_encstr_B13C0D4DB9395C23077530E8BC9D5B");
        level notify("_encstr_91750BE60B41C076B37326D770", self.origin);
        return;
      }
    }

    wait 0.1;
  }
}

listen_for_exfil(var_0, var_1, var_2) {
  self notify("_encstr_B20911ECCB13AB2FAD9102AAC0F767D3E9A364");
  self endon("_encstr_B20911ECCB13AB2FAD9102AAC0F767D3E9A364");

  if(!isDefined(var_0))
    var_0 = "_encstr_9BB70F0F8BCB0B0251591AA0FF639968ED";

  level waittill("_encstr_91750BE60B41C076B37326D770", var_3, var_4);
  var_5 = scripts\engine\utility::getStruct("_encstr_8A1A0DABC86BF837D338F5F04C58DB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(level._id_1248F))
    var_5 = level._id_1248F;

  var_5.vehicletype = "_encstr_8DD90913C62DB585D7D81C";
  var_6 = scripts\common\vehicle::vehicle_spawn(var_5);
  var_6 thread is_dead();
  var_6.godmode = 1;
  var_6.health = 100000;
  var_6.maxhealth = 100000;
  var_6.team = "_encstr_9A8507BA4040188D08";
  var_6.script_team = "_encstr_9A8507BA4040188D08";
  var_6 setvehicleteam("_encstr_9A8507BA4040188D08");
  var_6 setCanDamage(0);

  if(istrue(var_4))
    level.exfil_heli = var_6;

  var_7 = scripts\engine\utility::getclosest(var_3, scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));

  if(isDefined(level._id_14049))
    magicgrenademanual("_encstr_A9AF1246CAC1367B2FAF0B969CC8C9DB07AFD683", getgroundposition(var_7.origin, 16), (0, 90, 0), 0.01);
  else
    var_7.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(var_7.origin, 1);

  var_6.exfil_struct = var_7;
  var_8 = scripts\cp\cp_objectives::requestworldid("_encstr_B2A70AE543B1DF6DCF08926A", 10);
  objective_state(var_8, "_encstr_AF5A081BBAC993AC73A3");
  objective_position(var_8, var_7.origin - (0, 0, 100));
  objective_icon(var_8, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setminimapiconsize(var_8, "_encstr_8A9C0D3F5F2072CF1829A72BE0682A");
  objective_setshowdistance(var_8, 1);
  objective_setplayintro(var_8, 1);
  var_6.headicon = deleteheadicon(var_6);
  setheadiconfriendlyimage(var_6.headicon, "_encstr_A62C214CED91A9090910CB07C021F9E20F0D92835BE1C24DF0F0171B0898B50AC11118");
  setheadiconsnaptoedges(var_6.headicon, 12000);
  setheadiconmaxdistance(var_6.headicon, 1500);
  addclienttoheadiconmask(var_6.headicon, 10);
  setheadicondrawthroughgeo(var_6.headicon, 1);
  var_6.objnum = var_8;
  spawn_vehicle_actors(var_6);
  var_6 thread rumble_nearby_players();
  var_6 thread wait_while_exfil_arrives(var_8);
  var_6 waittill("_encstr_97350A37A1D974F7D4FA600F");

  if(isDefined(var_1))
    var_6 go_to_exfil_location(var_7, var_1);
  else
    var_6 go_to_exfil_location(var_7, 1);

  var_6 exfil_players(var_6, var_8, var_2);
}

#using_animtree("_encstr_B40101");

go_to_exfil_location(var_0, var_1, var_2) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  self.going_to_exfil = 1;

  if(!isDefined(var_2) || !istrue(var_2))
    self vehicleplayanim(%_encstr_BEEC15FD7F38492B918062AA2EFD673D60E74F4FD168CD);

  self vehicle_setspeed(90, 30);
  self setvehgoalpos(var_0.origin + (0, 0, 1200), 1);
  self waittill("_encstr_8B7205D9ED5958");
  self vehicle_setspeed(15, 10);
  arrive_at_exfil_location(self);
}

wait_while_exfil_arrives(var_0) {
  objective_setlabel(var_0, &"_encstr_AB7F2490AF08A33A491F999A472135FBDAA52869146477A2F22BE0967B61C92F703F60E15F55");
  level thread scripts\cp\utility::objective_update("_encstr_BA2E0E59C3994B8DAFACCD397BBA1D95");
  objective_setshowprogress(var_0, 1);
  objective_setprogress(var_0, 0);
  objective_setbackground(var_0, 1);
  var_1 = 10;
  var_2 = 10;

  for(;;) {
    wait 1;
    var_2--;
    objective_setprogress(var_0, var_2 / var_1);

    if(var_2 <= 15)
      self notify("_encstr_97350A37A1D974F7D4FA600F");

    if(var_2 <= 0)
      return;
  }
}

heli_cleanup_exfil_area(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  level notify("_encstr_ADDC11BF2C0EC075EFA2D1DE1A93A50B658501");
  var_0.minigun setturretteam("_encstr_9A8507BA4040188D08");
  var_0.minigun setmode("_encstr_849007B268BD03DFD8");
  var_1 = gettime();
  var_2 = 0;

  for(;;) {
    var_3 = var_0 get_nearby_enemy(var_0.exfil_struct.origin + (0, 0, -150));

    if(!isDefined(var_3)) {
      var_0.minigun cleartargetentity();
      wait 1;
      var_2++;

      if(var_2 >= 3)
        return;
    } else {
      var_2 = 0;
      var_4 = var_3.origin + (0, 0, 1100);
      var_0.minigun settargetentity(var_3);

      if(distance(var_4, var_0.origin) > 500)
        var_0 setvehgoalpos(var_4, 1);

      var_5 = var_0.minigun scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_97881123FB639E8883C74F55DF6B6066CF12BB", 3);

      if(var_5 == "_encstr_995408F398012F656821") {
        var_0.minigun cleartargetentity();
        continue;
      } else if(gettime() > var_1) {
        for(var_6 = 0; var_6 < 35; var_6++) {
          var_0.minigun shootturret();
          wait 0.1;
        }

        var_1 = gettime() + 1000;
      }
    }
  }
}

arrive_at_exfil_location(var_0) {
  var_0 setvehgoalpos(var_0.exfil_struct.origin + (0, 0, 1200), 1);
  var_0 waittill("_encstr_8B7205D9ED5958");
  var_0 settargetyaw(var_0.exfil_struct.angles[1]);
  var_0 setyawspeed(50, 25, 25, 0);
  wait 3;
  level notify("_encstr_AF0119589B2260A512E98715F14AE1C9915B21A807CBB969FA8D08", var_0.origin);
  level.oldkey = var_0;
  var_0 thread keep_from_crushing_players();
  var_0 thread lb_mg_dmg_factor_fuselage();
  var_0.goalradius = 4;
  var_0 setvehgoalpos(var_0.exfil_struct.origin, 1);
  var_0 waittill("_encstr_8B7205D9ED5958");
  var_0 vehicle_setspeedimmediate(0);
  var_0 vehicle_cleardrivingstate();
  level notify("_encstr_9B071A8593C95AB3B2C8D785E87DCA87335AB17D36DED8588ED2F6DC");
  level.oldkey = undefined;
}

lb_mg_dmg_factor_fuselage() {
  self endon("_encstr_8B7205D9ED5958");
  wait 4;

  if(!isDefined(level.vehicle)) {
    return;
  }
  if(!isDefined(level.vehicle.instances)) {
    return;
  }
  foreach(var_1 in level.vehicle.instances) {
    foreach(var_3 in var_1) {
      if(!isDefined(var_3) || !isDefined(var_3.origin)) {
        continue;
      }
      if(var_3 == self) {
        continue;
      }
      if(distance2d(var_3.origin, self.origin) < 512)
        var_3 dodamage(var_3.health + 1000, self.origin);
    }
  }
}

keep_from_crushing_players() {
  self endon("_encstr_8B7205D9ED5958");

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 istouching(self))
        thread move_player_from_under_heli(var_1);

      thread vfx_htown_stab_blink_ak(var_1);
      thread vfx_special_height(var_1);
    }

    if(isDefined(level.spawnjuggernautcrateatposition)) {
      foreach(var_4 in level.spawnjuggernautcrateatposition) {
        if(isDefined(var_4) && !istrue(var_4.carried) && distance2d(self.origin, var_4.origin) <= 200)
          thread _id_11D86(var_4);
      }
    }

    waitframe();
  }
}

vfx_special_height(var_0) {
  if(isDefined(var_0.taccovers) && isarray(var_0.taccovers) && var_0.taccovers.size > 0) {
    foreach(var_2 in var_0.taccovers) {
      if(isDefined(var_2) && isDefined(var_2.collision)) {
        if(var_2 istouching(self) || var_2.collision istouching(self))
          var_2 scripts\cp\powers\cp_tactical_cover::tac_cover_delete(0.05);
      }
    }
  }
}

vfx_htown_stab_blink_ak(var_0) {
  if(isDefined(var_0.placedsentries)) {
    if(isDefined(var_0.placedsentries["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"]) && isarray(var_0.placedsentries["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"]) && var_0.placedsentries["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"].size > 0) {
      foreach(var_2 in var_0.placedsentries["_encstr_AB8E0E73E9709BD298E7141D95E8DF43"]) {
        if(isDefined(var_2)) {
          if(var_2 istouching(self))
            var_2 notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 1, 0);
        }
      }
    }

    if(isDefined(var_0.placedsentries["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"]) && isarray(var_0.placedsentries["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"]) && var_0.placedsentries["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"].size > 0) {
      foreach(var_2 in var_0.placedsentries["_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4"]) {
        if(isDefined(var_2)) {
          if(var_2 istouching(self))
            var_2 notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 1, 0);
        }
      }
    }
  }
}

move_player_from_under_heli(var_0) {
  var_1 = var_0.origin - self.origin;
  var_1 = vectorNormalize(var_1);
  var_1 = var_1 * 200;
  var_1 = (var_1[0], var_1[1], 0);
  var_0 setOrigin(var_0.origin + var_1, 1);
}

_id_11D86(var_0) {
  var_1 = var_0.origin - self.origin;
  var_1 = vectorNormalize(var_1);
  var_1 = var_1 * 200;
  var_1 = (var_1[0], var_1[1], 0);
  var_0.origin = var_0.origin + var_1;
  var_0 notify("_encstr_97F80A91B46E8363C21BCA23");
}

get_nearby_enemy(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 2250000;

  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
  var_2 = sortbydistance(var_2, self.origin);

  foreach(var_4 in var_2) {
    if(!isalive(var_4)) {
      continue;
    }
    if(distancesquared(var_4.origin, var_0) < var_1 && scripts\engine\trace::ray_trace_passed(self.origin + (0, 0, -250), var_4.origin + (0, 0, 100), var_2))
      return var_4;
  }

  return undefined;
}

heli_mg_create(var_0, var_1) {
  var_2 = "_encstr_A14F0AE336178944BA076F41";
  var_3 = (-64, 0, 0);
  var_4 = self gettagorigin(var_2);

  if(!isDefined(var_1))
    var_1 = "_encstr_ACA312FBB97D1B1EFB17451B90AB4F05ED9FD043";

  self.minigun = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_4, var_1);
  self.minigun.angles = self gettagangles(var_2);

  if(isDefined(var_0))
    self.minigun setModel(var_0);
  else
    self.minigun setModel("_encstr_82BC202BBF802A40225FD9B7978A1EC92154B0E327FC12AD393313F5E3126581EFED");

  self.minigun linkTo(self, var_2, var_3, (0, 0, 0));
  self.minigun setturretteam("_encstr_8E8405EA382B2A");
  self.minigun setmode("_encstr_97910BA3154320F8EBBA8811A2");
  self.minigun setdefaultdroppitch(0);
  self.minigun setleftarc(360);
  self.minigun setrightarc(360);
  self.minigun settoparc(180);
  self.minigun setbottomarc(180);
  self.minigun setconvergencetime(0.05, "_encstr_AF1904C7E3A4");
  self.minigun setconvergencetime(0.05, "_encstr_BD6506F36A2B46B0");
}

rumble_nearby_players() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    playrumbleonposition("_encstr_97011287E9A8326880FBF2BF9329BAEB19652317", self.origin);
    wait 0.2;
  }
}

rideloop(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;)
    scripts\cp\cp_anim::anim_player_solo(var_0, var_0.player_rig, "_encstr_B1360B93BB3AEB633734F9F0DF", "_encstr_9AD01136187923E791B06F67D06B9509DD203B");
}

is_dead() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", self.origin, 0, 350, 64);
  var_0 enablelinkTo();
  var_0 linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", self gettagorigin("_encstr_A25B0F90226CE1D68B2775E01217385D93"), 0, 64, 64);
  var_1 enablelinkTo();
  var_1 linkTo(self, "_encstr_A25B0F90226CE1D68B2775E01217385D93");
  var_0 thread complete_trap_room(self);
  var_1 thread complete_trap_room(self);
}

complete_trap_room(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(istrue(var_1.inlaststand)) {
      var_1 notify("_encstr_966410CE10EB2FC727804AD250B9B1E7E305");
      continue;
    }

    if(istrue(var_1.isjuggernaut))
      var_1 scripts\cp\cp_juggernaut::jugg_removejuggernaut();

    var_1 setvelocity((-500, 0, 500));
    var_1.shouldskiplaststand = 1;
    var_1 dodamage(var_1.health + 1000, self.origin);
  }
}