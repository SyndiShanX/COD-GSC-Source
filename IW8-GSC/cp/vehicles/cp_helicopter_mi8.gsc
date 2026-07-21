/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\cp_helicopter_mi8.gsc
***********************************************/

_precache() {
  level._effect["_encstr_A9CD0D39F66CADCAE8D7336316E60D"] = loadfx("_encstr_AA233AEBBF50529B43DAFF8F93AE5158F6D7104866A0194E4B8F879BDFA22F20ABA8F0FBCF786109727741E74B5A665855436671F541C8B35E2BE591");
}

spawn_helicopter(var_0, var_1, var_2, var_3, var_4) {
  setdvarifuninitialized("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F", 1);
  var_5 = spawnVehicle("_encstr_979F1FA3917838C199FB9367D3B3DBAF88F85DAF8898B899E0A1BFAB47EED2CBD0", "_encstr_815D0E631F5A8D88A9C03EF07D96B031", "_encstr_A7660CD9AC1AAFADD2E6915A85C1", var_1, var_2);
  var_5.owner = var_0;
  var_5.spawn_pos = var_1;
  var_5.animname = "_encstr_88520840BAB5F918BF78";
  var_5.team = var_0.team;

  if(isDefined(var_3))
    var_5.team = var_3;

  var_5 setvehicleteam(var_5.team);
  var_5 setmaxpitchroll(20, 20);
  var_5 agent_init_anims();
  var_5 vehicle_init_anims();
  var_5 script_model_init_anims();

  if(istrue(var_4))
    var_5 heli_add_mg();

  return var_5;
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");

script_model_init_anims() {
  level.scr_anim["_encstr_A266062032BD7723"]["_encstr_A7C5056BD931D1"] = % _encstr_AFB4168310E1758238C1A77F8148DBB9A058BB41A8500C1A;
  level.scr_animname["_encstr_A266062032BD7723"]["_encstr_A7C5056BD931D1"] = "_encstr_AFB4168310E1758238C1A77F8148DBB9A058BB41A8500C1A";
  level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_A7C5056BD931D1"] = % _encstr_820D187B6B110BBA4EC7E8D972B9F1E22082828790F7A0444195;
  level.scr_animname["_encstr_9B7408BFEF17BA445893"]["_encstr_A7C5056BD931D1"] = "_encstr_820D187B6B110BBA4EC7E8D972B9F1E22082828790F7A0444195";
}

agent_init_anims() {
  var_0 = "_encstr_AB0B095BA59B912DB0837D";
  var_1 = "_encstr_83AE0686341410C5";
  var_2 = "_encstr_96D206F968DB6F43";
  self.loc_array = ["_encstr_A1850ACADB6008ABEF9297BE", "_encstr_A7850A999CBDE647F563FA19", "_encstr_AB850A99E4EDCD47EBC67D99", "_encstr_96850A9939BD738E7D93BE62", "_encstr_AA850A943A527D13C75B7112", "_encstr_81850AA35A65AA3B1743A717", "_encstr_936B0939B20B39AF1BD7C4", "_encstr_AB6B0956377A8D8E0C27C2", "_encstr_A76B09C9AC5839EBD8F5CC", "_encstr_886B096877366E171207BF", "_encstr_816B09A3BA6FDE194287B5", "_encstr_AA6B09638081C2415D100A"];
  self.agent_anims = [];

  foreach(var_4 in self.loc_array) {
    self.agent_anims[var_4] = spawnStruct();
    self.agent_anims[var_4].idle_anim = var_0 + var_4 + var_1;
    self.agent_anims[var_4].exit_anim = var_0 + var_4 + var_2;
  }

  self.vehicleanimalias = "_encstr_88520840BAB5F918BF78";
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

vehicle_init_anims() {
  level.scr_animtree["_encstr_88520840BAB5F918BF78"] = #animtree;
  add_veh_anim("_encstr_88520840BAB5F918BF78", "_encstr_A7C5056BD931D1", %_encstr_9B531546E1C96D9F08C9DA425AC8D327E84BF7D101B8B7, "_encstr_9B531546E1C96D9F08C9DA425AC8D327E84BF7D101B8B7");
  add_veh_anim("_encstr_88520840BAB5F918BF78", "_encstr_A52C097108A2FC06C7E1B3", %_encstr_AAA61A53C866FD0245ADFCF6AB7F4ABD68B87F97B07B213BB3B1493A, "_encstr_AAA61A53C866FD0245ADFCF6AB7F4ABD68B87F97B07B213BB3B1493A");
  add_veh_anim("_encstr_88520840BAB5F918BF78", "_encstr_84D3077AE8FB3B5F5B", %_encstr_88AF175043BF700B32D7730FB8597139E4DF9170AB51ABAFDF, "_encstr_88AF175043BF700B32D7730FB8597139E4DF9170AB51ABAFDF");
  add_veh_anim("_encstr_88520840BAB5F918BF78", "_encstr_A6D3072B3C5AD1EBA1", %_encstr_87AF17B3326163907BAC7B67D897F8CB158AD110CB04996E4A, "_encstr_87AF17B3326163907BAC7B67D897F8CB158AD110CB04996E4A");
  add_veh_anim("_encstr_88520840BAB5F918BF78", "_encstr_B4D307B2872D3AAF6C", %_encstr_82AF17A601298D7FE8697AE2FAA8B34748EB173D993093DFAC, "_encstr_82AF17A601298D7FE8697AE2FAA8B34748EB173D993093DFAC");
  add_veh_anim("_encstr_88520840BAB5F918BF78", "_encstr_A2D307E783138397CA", %_encstr_B6AF170D8809B0636B8AE89137D7ABB89D11D793306C80A01A, "_encstr_B6AF170D8809B0636B8AE89137D7ABB89D11D793306C80A01A");
}

add_veh_anim(var_0, var_1, var_2, var_3) {
  level.scr_anim[var_0][var_1] = var_2;
  level.scr_animname[var_0][var_1] = var_3;
}

play_vehicle_anim(var_0, var_1) {
  self animScripted("_encstr_B89B053163C20D", self.origin, self.angles, level.scr_anim[self.animname][var_0]);
  var_2 = getanimlength(level.scr_anim[self.animname][var_0]);
  wait(var_2);
}

agent_spawnai(var_0, var_1) {
  var_2 = [[level.mindia8_spawnaifunc]](self);

  if(isDefined(var_2)) {
    var_2 agent_put_on_heli(var_0, var_1, self);
    return var_2;
  }
}

agent_put_on_heli(var_0, var_1, var_2) {
  self.ignoreall = 1;
  self.heli_loc = var_0;

  if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F")) {
    self.scripted_mode = 1;
    scripts\asm\asm_mp::carepackage_get_dropped_entities();
  }

  var_3 = scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", var_2.agent_anims[var_0].idle_anim);
  var_4 = scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_3);
  var_5 = var_2 gettagorigin("_encstr_9AD01136187923E791B06F67D06B9509DD203B");
  var_6 = var_2 gettagangles("_encstr_9AD01136187923E791B06F67D06B9509DD203B");
  var_7 = getstartorigin(var_5, var_6, var_4);
  var_8 = getstartangles(var_5, var_6, var_4);
  self setplayerangles((0, var_2.angles[1], 0));
  self setOrigin(var_7, 0);

  if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F")) {
    self aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_3);
    self linkTo(var_2);
    self playerlinkedoffsetenable();
  } else {
    var_9 = spawnStruct();
    var_9.origin = var_7;
    var_9.angles = (0, var_2.angles[1], 0);
    var_9.vehicle_position = var_1;
    var_10 = spawnStruct();
    var_10.exittag = "_encstr_9AD01136187923E791B06F67D06B9509DD203B";
    scripts\vehicle\vehicle_common::requestentervehicle(var_2, 1, var_9, var_10);
  }
}

mindia8_unload(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9779117DFAA5458AA4574810BBB9EBF677EBD0");
  crew_spawn();
  self setneargoalnotifydist(250);

  if(isDefined(level.mindia8_unloadinterruptfunc))
    self thread[[level.mindia8_unloadinterruptfunc]](var_0);

  var_1 = var_0.origin + (0, 0, 527);
  self.goalradius = 4;
  self vehicle_setspeed(40, 25, 7);
  self setvehgoalpos(var_1, 1);
  self setyawspeed(40, 20, 20, 0.3);
  self waittill("_encstr_8B7205D9ED5958");
  self vehicle_setspeed(0, 1, 1);
  self setmaxpitchroll(5, 5);
  wait 1;
  self notify("_encstr_8E7C0C6E1D58E4E8AFA537992D63");
  self vehicle_cleardrivingstate();
  self vehicleplayanim(level.scr_anim[self.animname]["_encstr_A7C5056BD931D1"]);
  thread crew_unload();
  self waittill("_encstr_BD82096B5DA4B07F924F29");
  thread heli_depart();
}

heli_depart() {
  self endon("_encstr_AD75063D571AE108");
  self setmaxpitchroll(20, 20);

  if(should_use_exit_anim())
    use_exit_anim();
  else {
    var_0 = anglesToForward((0, self.angles[1], 0));
    var_1 = vec_multiply(var_0, 5000);
    self setmaxpitchroll(35, 35);
    self vehicle_setspeed(50, 30, 7);
    self setvehgoalpos(self.origin + var_1 + (0, 0, 400), 1);
    self waittill("_encstr_8B7205D9ED5958");
  }

  self.pilot delete();
  self.copilot delete();
  self delete();
}

should_use_exit_anim() {
  return 0;
}

use_exit_anim() {
  var_0 = 2;

  if(randomint(100) > 50) {
    var_0 = 4;

    if(randomint(100) > 50)
      var_0 = 6;

    if(randomint(100) > 50)
      var_0 = 8;
  }

  self vehicle_cleardrivingstate();
  play_vehicle_anim("_encstr_B41206B813CC7176" + var_0);
  var_1 = anglesToForward((0, self.angles[1], 0));
  var_2 = vec_multiply(var_1, 5000);
  self setmaxpitchroll(35, 35);
  self vehicle_setspeedimmediate(50, 50, 7);
  self setvehgoalpos(self.origin + var_2 + (0, 0, 200), 1);
  wait 10;
}

crew_spawn() {
  self.agents = [];

  foreach(var_2, var_1 in self.loc_array)
  self.agents[var_2] = agent_spawnai(var_1, var_2 + 2);

  spawn_pilots();
}

#using_animtree("_encstr_A5AD0EDA0198272AF00797B83388B643");

crew_unload() {
  if(isDefined(level.mindia8_customunloadfunc))
    [[level.mindia8_customunloadfunc]](self);

  foreach(var_1 in self.agents)
  var_1 thread agent_exit_heli(self);

  var_3 = % _encstr_9321192404E9C3387E9B48F012B7931BD22A08AE5147DFE14087A8;
  wait(getanimlength(var_3) + 3);
  self notify("_encstr_BD82096B5DA4B07F924F29");
}

agent_exit_heli(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(!getdvarint("_encstr_8A911B9DA60970AAEA07FCA9F26FCA40F1F7B8F4D143C303263FD1964F")) {
    self unlink();
    self.deathstate = "_encstr_84610D49100897C2DF809A03583BFF";
    self.deathalias = "_encstr_811817E1AF6F1329E7C13868711A16C9AF02693F718B983BFD";
    self.health = 1;
    scripts\asm\shared\mp\utility::burningpartlogic(var_0.agent_anims[self.heli_loc].exit_anim, var_0, "_encstr_9AD01136187923E791B06F67D06B9509DD203B");
    self.deathstate = undefined;
    self.deathalias = undefined;
    self.scripted_mode = 0;
    self.ignoreall = 0;
    self.deathstate = undefined;
    self.deathalias = undefined;
  } else {
    self.health = 1;
    scripts\vehicle\vehicle_common::exitvehicle();
    self.ignoreall = 0;
  }

  wait 5;
  self dodamage(self.health + 100, self.origin, level.players[0], level.players[0]);
}

spawn_pilots() {
  var_0 = self gettagorigin("_encstr_9AD01136187923E791B06F67D06B9509DD203B");
  var_1 = self gettagangles("_encstr_9AD01136187923E791B06F67D06B9509DD203B");
  var_2 = getstartorigin(var_0, var_1, level.scr_anim["_encstr_A266062032BD7723"]["_encstr_A7C5056BD931D1"]);
  var_3 = getstartangles(var_0, var_1, level.scr_anim["_encstr_A266062032BD7723"]["_encstr_A7C5056BD931D1"]);
  var_4 = getstartorigin(var_0, var_1, level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_A7C5056BD931D1"]);
  var_5 = getstartangles(var_0, var_1, level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_A7C5056BD931D1"]);
  self.pilot = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  self.pilot.angles = var_3;
  self.pilot setModel("_encstr_967D148517D7E02DC6DB1DEB665D1B8D4C7B8C97F5C4");
  self.copilot = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
  self.copilot.angles = var_5;
  self.copilot setModel("_encstr_887D1485B8BEC14B367B8EF566D5D8B113F68CCBAFC8");
  self.copilot linkTo(self);
  self.pilot linkTo(self);
  self.pilot scriptmodelplayanimdeltamotionfrompos(level.scr_animname["_encstr_A266062032BD7723"]["_encstr_A7C5056BD931D1"], var_0, var_1);
  self.copilot scriptmodelplayanimdeltamotionfrompos(level.scr_animname["_encstr_9B7408BFEF17BA445893"]["_encstr_A7C5056BD931D1"], var_0, var_1);
}

heli_add_mg() {
  var_0 = "_encstr_99FE0B2B19086F6B9DC5D387E1";
  var_1 = self gettagorigin(var_0);
  var_2 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_1, "_encstr_83680FAFC87E438509DB31BBAD264DD22B");
  var_2.angles = self gettagangles(var_0);
  var_2 setModel("_encstr_AB941C74699CD92047B045DF89932839900CE0D293E9DA7F34D38382FAB3");
  var_2 linkTo(self, var_0);
  var_2 setturretteam("_encstr_8E8405EA382B2A");
  var_2 setmode("_encstr_849007B268BD03DFD8");
  var_2 setdefaultdroppitch(0);
  var_2 setleftarc(360);
  var_2 setrightarc(360);
  var_2 settoparc(45);
  var_2 setbottomarc(90);
  var_2 setconvergencetime(0.05, "_encstr_AF1904C7E3A4");
  var_2 setconvergencetime(0.05, "_encstr_BD6506F36A2B46B0");
  var_2.heli = self;
  thread scripts\engine\utility::delete_on_death(var_2);
  self.mg = var_2;
}

vec_multiply(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}