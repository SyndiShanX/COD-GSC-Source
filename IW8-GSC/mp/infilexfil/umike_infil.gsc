/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\infilexfil\umike_infil.gsc
***********************************************/

umike_init(var_0) {
  initanims(var_0);
  var_1 = [];
  var_1[0] = [0, 1, 2, 3, 4, 5];
  thread scripts\mp\infilexfil\infilexfil::infil_add("_encstr_BEFD0C1BA65F8889C7E3AD882A07", var_0, 6, 4, var_1, ::umike_spawn, ::umike_get_length, ::player_umike_infil_think);
}

umike_spawn(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_4.origin);
  var_5.angles = var_4.angles;
  var_5.scene_node = var_4;

  if(isDefined(var_4.target))
    var_5.path = getvehiclenode(var_4.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  var_5 thread infilthink(var_0, var_2);
  return var_5;
}

umike_get_length(var_0) {
  var_1 = getanimlength(level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_A29F0D576B96DA59F59637665A1B7D" + var_0]);
  var_1 = var_1 + getanimlength(level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_A29F0D576B96DA59F59637665A1B7D" + var_0 + "_encstr_96D206F968DB6F43"]);
  return var_1;
}

player_umike_infil_think(var_0, var_1) {
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");

  if(isPlayer(self))
    self setsoundsubmix("_encstr_A3460F89303F6895D7C238993B2D53E00F", 0);

  thread player_infil_end();
  var_2 = var_0.linktoent gettagorigin("_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  var_3 = var_0.linktoent gettagangles("_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("_encstr_AC6B06F0DA2281E1" + var_1, var_2, var_3);
  self.player_rig.weapon_state_func = scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  self.player_rig linkTo(var_0.linktoent, "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118", (0, 0, 0), (0, 0, 0));

  if(istrue(level.interactiveinfil) && !isai(self))
    giveinteractiveinfilweapon();
  else
    self setdemeanorviewmodel("_encstr_B418059B8533CA", "_encstr_828D1AD82BC0014C52C7AFD1B7FA85483E85239652C18075292BCBFD");

  thread scripts\mp\infilexfil\infilexfil::infil_scene_fade_in(0.0, 0.55);
  thread player_van_disconnect();
  self.manualoverridewindmaterial = 1;
  self setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_AA07038618", 0);
  level waittill("_encstr_B2600CF8759933D3EE634E77CB7A");
  self clearsoundsubmix("_encstr_A3460F89303F6895D7C238993B2D53E00F", 2);

  if(isDefined(self.team) && self.team != "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    var_4 = [];
    var_4[var_4.size] = "_encstr_B2B718088BB854DD36488AE1279048117D0BE3334A626A629037";
    var_4[var_4.size] = "_encstr_8C4318B51C7D2DE6995A63AF6BA587F5DAD56EB4D8D84B3B1A3A";
    var_4[var_4.size] = "_encstr_AA9114AD38BE5A73CCB4D87D5B5A87FA9BBDE45BC21B";
    var_5 = var_4.size;
    var_6 = randomint(var_5);

    if(self.team == "_encstr_9A8507BA4040188D08") {
      var_7 = game["_encstr_813F06832D8A18FE"]["_encstr_9B9714B70B58DBB77F184A32C1CD9717E1FB562E8B08"].size;
      level.cur_infil_track = randomint(var_7);
      self setsoundsubmix(var_4[var_6]);
      self setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_9B9714B70B58DBB77F184A32C1CD9717E1FB562E8B08"][level.cur_infil_track]);
      self._id_12463 = 1;
    } else {
      var_7 = game["_encstr_813F06832D8A18FE"]["_encstr_ABF814AC859B3ABE0BE6A5B50BE856C8BEA5CD99961B"].size;
      level.cur_infil_track = randomint(var_7);
      self setsoundsubmix(var_4[var_6]);
      self setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_ABF814AC859B3ABE0BE6A5B50BE856C8BEA5CD99961B"][level.cur_infil_track]);
      self._id_12463 = 1;
    }
  }

  if(istrue(level.interactiveinfil) && !isai(self))
    thread allowinteractivecombat();

  self setcinematicmotionoverride("_encstr_921D09D9D9C0090D7275B4");
  self lerpviewangleclamp(1, 0.25, 0.25, 120, 120, 60, 10);
  var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "_encstr_A29F0D576B96DA59F59637665A1B7D" + var_0.subtype, "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "_encstr_A29F0D576B96DA59F59637665A1B7D" + var_0.subtype + "_encstr_96D206F968DB6F43", "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  thread clear_infil_ambient_zone();

  if(isDefined(self.player_rig) && self.player_rig islinked())
    self.player_rig unlink();

  self visionsetnakedforplayer("_encstr_B40101", 0.75);
  self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
  self.manualoverridewindmaterial = 0;
}

clear_infil_ambient_zone() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait 1;
  self clearallsoundsubmixes();
  self clearclienttriggeraudiozone(2);
}

player_infil_end() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  self clearallsoundsubmixes();
  self clearclienttriggeraudiozone(1.0);
  scripts\mp\utility\player::setdof_default();
}

player_van_disconnect() {
  level endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(self)) {
    self visionsetnakedforplayer("_encstr_B40101");
    self clearallsoundsubmixes();
    self clearclienttriggeraudiozone(0.0);
    self lerpfovbypreset("_encstr_8B1608EC43B8D647A113");
    self setviewmodeldepthoffield(0, 0, 18);
    scripts\mp\utility\player::setdof_default();
  }
}

infilthink(var_0, var_1) {
  var_2 = getdvarfloat("_encstr_8EED0A5D8D6D291F8FE9CFF4", 0.2);

  foreach(var_4 in getEntArray("_encstr_AACF0DD2B9CC4B1BFA19AC1BACD12B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"))
  var_4 delete();

  thread vehiclethink(var_0, self.scene_node, var_1);
  thread actorthink(var_0, self.scene_node, var_1);
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  setDvar("_encstr_A3D50AA2986AA6D30A35D4A5", 1);
  setDvar("_encstr_8EED0A5D8D6D291F8FE9CFF4", 1.0);
  level notify("_encstr_B2600CF8759933D3EE634E77CB7A");

  if(istrue(level.interactiveinfil))
    level thread interactiveinfilthink(var_0);

  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  waitframe();
  setDvar("_encstr_A3D50AA2986AA6D30A35D4A5", 0);
  setDvar("_encstr_8EED0A5D8D6D291F8FE9CFF4", var_2);

  while(isDefined(self.actors))
    waitframe();

  if(isDefined(self.cleanupents)) {
    foreach(var_4 in self.cleanupents)
    var_4 delete();
  }

  level.stop_station_closed_vo--;
  self delete();
}

vehiclethink(var_0, var_1, var_2, var_3) {
  self.linktoent = spawninfilvehicle(var_1, var_0, var_2);

  if(isDefined(self.path))
    thread vehiclethinkpath(var_0, var_1, var_2, var_3);
  else
    thread vehiclethinkmodel(var_0, var_1, var_2, var_3);

  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  var_4 = getEnt("_encstr_ACE60B9B02D06AB81820285818", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_4)) {
    var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.linktoent.origin);
    var_5.angles = self.linktoent.angles;
    var_5 clonebrushmodeltoscriptmodel(var_4);
    var_5 disconnectPaths();
  }

  if(istrue(self.linktoent.shouldfree))
    self.linktoent makecorpse();

  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][self.type][var_2]["_encstr_A5D81207599C375A9B3A9573D195AC0DB41B3695"] = ::spawnpersistentvehicle;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][self.type][var_2]["_encstr_91260B40A2EC2B91B36DA82E47"] = self.linktoent.origin;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][self.type][var_2]["_encstr_AF260B886A249329FB35F7680F"] = self.linktoent.angles;
}

spawnpersistentvehicle(var_0, var_1) {
  var_2 = game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_91260B40A2EC2B91B36DA82E47"];
  var_3 = game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_AF260B886A249329FB35F7680F"];
  var_4 = spawnVehicle("_encstr_846B19C3C3C8A8D1D17369A7EA808CB793B8FC3B5807E360CDEBC4", "_encstr_844706EBB792B220", "_encstr_844706EBB792B220", var_2, var_3);
  var_4.animname = "_encstr_A2AD09AED6B4D6AC95AC1A";
  var_4 vehicle_turnengineoff();
  var_5 = getEnt("_encstr_ACE60B9B02D06AB81820285818", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_5)) {
    var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
    var_6.angles = var_3;
    var_6 clonebrushmodeltoscriptmodel(var_5);
  }
}

vehiclethinkpath(var_0, var_1, var_2, var_3) {
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  self.linktoent thread vehiclefollowpath(self.path);
  thread scripts\common\anim::anim_single_solo(self.linktoent, "_encstr_A29F0D576B96DA59F59637665A1B7D" + var_2 + "_encstr_B16E06A973700CF2");
  self.linktoent thread play_tailgate_sfx();
  self.linktoent setscriptablepartstate("_encstr_82EF0784E5AE31F0A1", "_encstr_820E07FAE8780B3A4C");
  self.linktoent setscriptablepartstate("_encstr_8ECD0A02885967AF4B89550B", "_encstr_930B07BB1B6B3854FF");
  self.linktoent setscriptablepartstate("_encstr_B4D5123696EC343AE6EB1B7B73D14EBD63D8CA93", "_encstr_AB0703DBB9");
  self.linktoent setscriptablepartstate("_encstr_86D00D5048E3DA5929B8B1F772D18F", "_encstr_AB0703DBB9");
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self.linktoent setscriptablepartstate("_encstr_82EF0784E5AE31F0A1", "_encstr_A7A408B9CA5D1D4E2C63");
  self.linktoent setscriptablepartstate("_encstr_8ECD0A02885967AF4B89550B", "_encstr_A7A408B9CA5D1D4E2C63");
  self.linktoent setscriptablepartstate("_encstr_B4D5123696EC343AE6EB1B7B73D14EBD63D8CA93", "_encstr_BA19049F4B2D");
  self.linktoent setscriptablepartstate("_encstr_86D00D5048E3DA5929B8B1F772D18F", "_encstr_BA19049F4B2D");

  if(isDefined(self.linktoent.clip)) {
    self.linktoent.clip show();
    self.linktoent.clip.angles = self.linktoent.angles;
    self.linktoent.clip.origin = self.linktoent.origin;
    self.linktoent.clip disconnectPaths();
  }
}

vehiclethinkmodel(var_0, var_1, var_2, var_3) {
  scripts\common\anim::anim_first_frame_solo(self.linktoent, "_encstr_A29F0D576B96DA59F59637665A1B7D" + var_2);
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  thread scripts\common\anim::anim_single_solo(self.linktoent, "_encstr_A29F0D576B96DA59F59637665A1B7D" + var_2);
  self.linktoent thread play_tailgate_sfx();
  self.linktoent setscriptablepartstate("_encstr_82EF0784E5AE31F0A1", "_encstr_820E07FAE8780B3A4C");
  self.linktoent setscriptablepartstate("_encstr_8ECD0A02885967AF4B89550B", "_encstr_930B07BB1B6B3854FF");
  self.linktoent setscriptablepartstate("_encstr_B4D5123696EC343AE6EB1B7B73D14EBD63D8CA93", "_encstr_AB0703DBB9");
  self.linktoent setscriptablepartstate("_encstr_86D00D5048E3DA5929B8B1F772D18F", "_encstr_AB0703DBB9");
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self.linktoent setscriptablepartstate("_encstr_82EF0784E5AE31F0A1", "_encstr_A7A408B9CA5D1D4E2C63");
  self.linktoent setscriptablepartstate("_encstr_8ECD0A02885967AF4B89550B", "_encstr_A7A408B9CA5D1D4E2C63");
  self.linktoent setscriptablepartstate("_encstr_B4D5123696EC343AE6EB1B7B73D14EBD63D8CA93", "_encstr_BA19049F4B2D");
  self.linktoent setscriptablepartstate("_encstr_86D00D5048E3DA5929B8B1F772D18F", "_encstr_BA19049F4B2D");

  if(isDefined(self.linktoent.clip)) {
    self.linktoent.clip show();
    self.linktoent.clip.angles = self.linktoent.angles;
    self.linktoent.clip.origin = self.linktoent.origin;
    self.linktoent.clip disconnectPaths();
  }
}

play_tailgate_sfx() {
  var_0 = self gettagorigin("_encstr_A6D70CA3B0D97DACC3A12CABCD1D");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_1 linkTo(self, "_encstr_A6D70CA3B0D97DACC3A12CABCD1D");
  wait 6.5;
  var_1 playsoundonmovingent("_encstr_B85D1D5B83D72DB9992D63F5BADA5AB595BEB20F5A8E7DA30BA536ECC21D2B");
  wait 20;
  var_1 delete();
}

flapsthink(var_0, var_1, var_2, var_3) {
  self.linktoent scripts\common\anim::anim_first_frame_solo(self.linktoent.flaps, "_encstr_A29F0D576B96DA59F59637665A1B7D" + var_2, "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  self.linktoent thread scripts\common\anim::anim_single_solo(self.linktoent.flaps, "_encstr_A29F0D576B96DA59F59637665A1B7D" + var_2, "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
}

spawninfilvehicle(var_0, var_1, var_2) {
  if(isDefined(self.path)) {
    var_3 = self.path.origin;
    var_4 = self.path.angles;
    var_5 = spawnVehicle(scripts\engine\utility::ter_op(var_1 == "_encstr_9A8507BA4040188D08", "_encstr_AD5920DBC10B790E77E2487148AE0D46F3BDAF57A2FF4F31D00CDDD17624D349908C", "_encstr_846B19C3C3C8A8D1D17369A7EA808CB793B8FC3B5807E360CDEBC4"), "_encstr_844706EBB792B220", "_encstr_844706EBB792B220", var_3, var_4);
    var_5.animname = "_encstr_A2AD09AED6B4D6AC95AC1A";
    var_5.shouldfree = 1;
  } else {
    var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_5.angles = var_0.angles;
    var_5 setModel("_encstr_846B19C3C3C8A8D1D17369A7EA808CB793B8FC3B5807E360CDEBC4");
    var_5.animname = "_encstr_844706EBB792B220";
    var_5 scripts\common\anim::setanimtree();
  }

  var_5.infil = self;
  var_5 setCanDamage(0);
  var_5 thread vehicleplaysounds();
  return var_5;
}

vehicleplaysounds() {
  var_0 = self;
  var_0 vehicle_turnengineoff();
  var_1 = var_0 gettagorigin("_encstr_BA6B157338FFF99B08AC7064A8313B3D0568496AB0456B");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_2 linkTo(var_0, "_encstr_BA6B157338FFF99B08AC7064A8313B3D0568496AB0456B");
  var_3 = var_0 gettagorigin("_encstr_A6D70CA3B0D97DACC3A12CABCD1D");
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
  var_4 linkTo(var_0, "_encstr_A6D70CA3B0D97DACC3A12CABCD1D");
  var_2 playLoopSound("_encstr_85091F8FD998A25E180805C1A368915A6D6F570B6F3B9A0DA9F1BAD538789F62BF");
  var_4 playLoopSound("_encstr_BE651E1FB94043EB08DA9D27EB78DCB3B0A61DE8D767A86D7F8B8877ABF9593F");
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  wait 2.5;
  var_2 playsoundonmovingent("_encstr_A96A215B38F52D37992D8DEB5D6BA5B656EBCAB9D9D2E62BD7CD47F638EB999CEDDC3A");
  var_4 playsoundonmovingent("_encstr_818A20B6C1EBA5E6CC5AC6FABAD6D26DCAAFAC9B3BA573CAAF373ABDC1FA39951693");
  wait 1;
  var_2 stoploopsound();
  var_4 stoploopsound();
  wait 2;
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  wait 5;
  var_2 delete();
  var_4 delete();
}

vehiclefollowpath(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
  self startpath(var_0);

  for(var_1 = getvehiclenode(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"); isDefined(var_1); var_1 = getvehiclenode(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF")) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A");

    if(isDefined(var_1.script_unload)) {
      self vehicle_setspeedimmediate(0, 30, 30);

      for(var_2 = self vehicle_getspeed(); var_2 > 1; var_2 = self vehicle_getspeed())
        wait 0.1;

      self notify("_encstr_AB850C5DDC8DED168CF59DBA5EDC");

      while(self.riders.size > 0)
        wait 0.1;

      if(isDefined(var_1.target))
        self resumespeed(10);
    }

    if(!isDefined(var_1.target)) {
      break;
    }
  }

  self vehicle_setspeedimmediate(0, 30, 30);

  for(var_2 = self vehicle_getspeed(); var_2 > 1; var_2 = self vehicle_getspeed())
    wait 0.1;
}

actorthink(var_0, var_1, var_2, var_3) {
  thread spawnactors(var_0, var_2, var_3);
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "_encstr_A29F0D576B96DA59F59637665A1B7D" + var_2, "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "_encstr_A29F0D576B96DA59F59637665A1B7D" + var_2, "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["_encstr_A29F0D576B96DA59F59637665A1B7D" + var_2]);
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");

  foreach(var_5 in self.actors) {
    if(isDefined(var_5))
      var_5 delete();
  }

  self.actors = undefined;
}

spawnactors(var_0, var_1, var_2) {
  if(!isDefined(self.actors))
    self.actors = [];

  var_3 = getdriverassets(var_0);
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("_encstr_9AE307B956E345D0AB", "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118", var_3.body, var_3.head);

  foreach(var_5 in self.actors)
  var_5.infil = self;
}

spawn_anim_model(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_5 setModel(var_2);

  if(isDefined(var_3)) {
    var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_6 setModel(var_3);
    var_6 linkTo(var_5, "_encstr_8EEC09159F6238030BFA23", (0, 0, 0), (0, 0, 0));
    var_5.head = var_6;
    var_5 thread scripts\engine\utility::delete_on_death(var_6);
  }

  if(isDefined(var_4)) {
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_7 setModel(var_4);
    var_7 linkTo(var_5, "_encstr_8107069A17A718C5", (0, 0, 0), (0, 0, 0));
    var_5 thread scripts\engine\utility::delete_on_death(var_7);
    var_5.weapon = var_7;
  }

  var_5.animname = var_0;
  var_5 scripts\common\anim::setanimtree();

  if(isDefined(var_1)) {
    thread scripts\engine\utility::delete_on_death(var_5);
    var_5 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  }

  return var_5;
}

initanims(var_0) {
  script_model_alpha_anims(var_0);
  vehicles_alpha_anims(var_0);

  switch (var_0) {
    case "_encstr_BDBB0616C6C186C2":
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_818E1A38B12CE5564ED7C67BB1B6BE8DDEB76DD7917D9BCAB1F63791", scripts\mp\utility\infilexfil::player_lock_look_2_second, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_818E1A38B12CE5564ED7C67BB1B6BE8DDEB76DD7917D9BCAB1F63791", scripts\mp\utility\infilexfil::player_lock_look_2_second, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_818E1A38B12CE5564ED7C67BB1B6BE8DDEB76DD7917D9BCAB1F63791", scripts\mp\utility\infilexfil::player_lock_look_2_second, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_818E1A38B12CE5564ED7C67BB1B6BE8DDEB76DD7917D9BCAB1F63791", scripts\mp\utility\infilexfil::player_lock_look_2_second, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_818E1A38B12CE5564ED7C67BB1B6BE8DDEB76DD7917D9BCAB1F63791", scripts\mp\utility\infilexfil::player_lock_look_2_second, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_818E1A38B12CE5564ED7C67BB1B6BE8DDEB76DD7917D9BCAB1F63791", scripts\mp\utility\infilexfil::player_lock_look_2_second, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_87940AB943C2AD95BE7BCCCC", ::umike_cam_shake_ground, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_87940AB943C2AD95BE7BCCCC", ::umike_cam_shake_ground, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_87940AB943C2AD95BE7BCCCC", ::umike_cam_shake_ground, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_87940AB943C2AD95BE7BCCCC", ::umike_cam_shake_ground, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_87940AB943C2AD95BE7BCCCC", ::umike_cam_shake_ground, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_87940AB943C2AD95BE7BCCCC", ::umike_cam_shake_ground, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_84AC0CD330915512E380EB647099", ::reducewind, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_84AC0CD330915512E380EB647099", ::reducewind, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_84AC0CD330915512E380EB647099", ::reducewind, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_84AC0CD330915512E380EB647099", ::reducewind, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_84AC0CD330915512E380EB647099", ::reducewind, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_84AC0CD330915512E380EB647099", ::reducewind, "_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_928F1E3B2311539896AC70EE5375689A6A379399DFCB30E0BD85FBE63D212845", ::mp_infil_umike_exit_jump_land_sfx, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_928F1E3B2311539896AC70EE5375689A6A379399DFCB30E0BD85FBE63D212845", ::mp_infil_umike_exit_jump_land_sfx, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_928F1E3B2311539896AC70EE5375689A6A379399DFCB30E0BD85FBE63D212845", ::mp_infil_umike_exit_jump_land_sfx, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_928F1E3B2311539896AC70EE5375689A6A379399DFCB30E0BD85FBE63D212845", ::mp_infil_umike_exit_jump_land_sfx, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_928F1E3B2311539896AC70EE5375689A6A379399DFCB30E0BD85FBE63D212845", ::mp_infil_umike_exit_jump_land_sfx, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_928F1E3B2311539896AC70EE5375689A6A379399DFCB30E0BD85FBE63D212845", ::mp_infil_umike_exit_jump_land_sfx, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_B8761D41EA0123208E47B8291FAD987FCA59CD53040B87E86077195063FD73", ::mp_infil_umike_exit_npc_step_sfx, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_B8761D41EA0123208E47B8291FAD987FCA59CD53040B87E86077195063FD73", ::mp_infil_umike_exit_npc_step_sfx, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_B8761D41EA0123208E47B8291FAD987FCA59CD53040B87E86077195063FD73", ::mp_infil_umike_exit_npc_step_sfx, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_B8761D41EA0123208E47B8291FAD987FCA59CD53040B87E86077195063FD73", ::mp_infil_umike_exit_npc_step_sfx, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_B8761D41EA0123208E47B8291FAD987FCA59CD53040B87E86077195063FD73", ::mp_infil_umike_exit_npc_step_sfx, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_B8761D41EA0123208E47B8291FAD987FCA59CD53040B87E86077195063FD73", ::mp_infil_umike_exit_npc_step_sfx, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_AFD125B6E07DD2E6992D1B7DBADA965BB27D56872D8E7DE6AE6E07AC9BE6A5F6DCD7D8C9AC85AD", ::mp_infil_umike_exit_suspension_creak, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_AFD125B6E07DD2E6992D1B7DBADA965BB27D56872D8E7DE6AE6E07AC9BE6A5F6DCD7D8C9AC85AD", ::mp_infil_umike_exit_suspension_creak, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_AFD125B6E07DD2E6992D1B7DBADA965BB27D56872D8E7DE6AE6E07AC9BE6A5F6DCD7D8C9AC85AD", ::mp_infil_umike_exit_suspension_creak, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_AFD125B6E07DD2E6992D1B7DBADA965BB27D56872D8E7DE6AE6E07AC9BE6A5F6DCD7D8C9AC85AD", ::mp_infil_umike_exit_suspension_creak, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_AFD125B6E07DD2E6992D1B7DBADA965BB27D56872D8E7DE6AE6E07AC9BE6A5F6DCD7D8C9AC85AD", ::mp_infil_umike_exit_suspension_creak, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_AFD125B6E07DD2E6992D1B7DBADA965BB27D56872D8E7DE6AE6E07AC9BE6A5F6DCD7D8C9AC85AD", ::mp_infil_umike_exit_suspension_creak, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      break;
    case "_encstr_871D0613938567B7":
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_82300B7081FA4BE6E6D10BB9E8", scripts\mp\utility\infilexfil::player_fov_80_instant, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_818E1A38B12CE5564ED7C67BB1B6BE8DDEB76DD7917D9BCAB1F63791", scripts\mp\utility\infilexfil::player_lock_look_2_second, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_818E1A38B12CE5564ED7C67BB1B6BE8DDEB76DD7917D9BCAB1F63791", scripts\mp\utility\infilexfil::player_lock_look_2_second, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_818E1A38B12CE5564ED7C67BB1B6BE8DDEB76DD7917D9BCAB1F63791", scripts\mp\utility\infilexfil::player_lock_look_2_second, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_818E1A38B12CE5564ED7C67BB1B6BE8DDEB76DD7917D9BCAB1F63791", scripts\mp\utility\infilexfil::player_lock_look_2_second, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_818E1A38B12CE5564ED7C67BB1B6BE8DDEB76DD7917D9BCAB1F63791", scripts\mp\utility\infilexfil::player_lock_look_2_second, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_818E1A38B12CE5564ED7C67BB1B6BE8DDEB76DD7917D9BCAB1F63791", scripts\mp\utility\infilexfil::player_lock_look_2_second, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_AB35095713A202909F1DCD", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_87940AB943C2AD95BE7BCCCC", ::umike_cam_shake_ground, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_87940AB943C2AD95BE7BCCCC", ::umike_cam_shake_ground, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_87940AB943C2AD95BE7BCCCC", ::umike_cam_shake_ground, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_87940AB943C2AD95BE7BCCCC", ::umike_cam_shake_ground, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_87940AB943C2AD95BE7BCCCC", ::umike_cam_shake_ground, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_87940AB943C2AD95BE7BCCCC", ::umike_cam_shake_ground, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_84AC0CD330915512E380EB647099", ::reducewind, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_84AC0CD330915512E380EB647099", ::reducewind, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_84AC0CD330915512E380EB647099", ::reducewind, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_84AC0CD330915512E380EB647099", ::reducewind, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_84AC0CD330915512E380EB647099", ::reducewind, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_84AC0CD330915512E380EB647099", ::reducewind, "_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_928F1E3B2311539896AC70EE5375689A6A379399DFCB30E0BD85FBE63D212845", ::mp_infil_umike_exit_jump_land_sfx, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_928F1E3B2311539896AC70EE5375689A6A379399DFCB30E0BD85FBE63D212845", ::mp_infil_umike_exit_jump_land_sfx, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_928F1E3B2311539896AC70EE5375689A6A379399DFCB30E0BD85FBE63D212845", ::mp_infil_umike_exit_jump_land_sfx, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_928F1E3B2311539896AC70EE5375689A6A379399DFCB30E0BD85FBE63D212845", ::mp_infil_umike_exit_jump_land_sfx, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_928F1E3B2311539896AC70EE5375689A6A379399DFCB30E0BD85FBE63D212845", ::mp_infil_umike_exit_jump_land_sfx, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_928F1E3B2311539896AC70EE5375689A6A379399DFCB30E0BD85FBE63D212845", ::mp_infil_umike_exit_jump_land_sfx, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_B8761D41EA0123208E47B8291FAD987FCA59CD53040B87E86077195063FD73", ::mp_infil_umike_exit_npc_step_sfx, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_B8761D41EA0123208E47B8291FAD987FCA59CD53040B87E86077195063FD73", ::mp_infil_umike_exit_npc_step_sfx, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_B8761D41EA0123208E47B8291FAD987FCA59CD53040B87E86077195063FD73", ::mp_infil_umike_exit_npc_step_sfx, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_B8761D41EA0123208E47B8291FAD987FCA59CD53040B87E86077195063FD73", ::mp_infil_umike_exit_npc_step_sfx, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_B8761D41EA0123208E47B8291FAD987FCA59CD53040B87E86077195063FD73", ::mp_infil_umike_exit_npc_step_sfx, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_B8761D41EA0123208E47B8291FAD987FCA59CD53040B87E86077195063FD73", ::mp_infil_umike_exit_npc_step_sfx, "_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_AFD125B6E07DD2E6992D1B7DBADA965BB27D56872D8E7DE6AE6E07AC9BE6A5F6DCD7D8C9AC85AD", ::mp_infil_umike_exit_suspension_creak, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_AFD125B6E07DD2E6992D1B7DBADA965BB27D56872D8E7DE6AE6E07AC9BE6A5F6DCD7D8C9AC85AD", ::mp_infil_umike_exit_suspension_creak, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_AFD125B6E07DD2E6992D1B7DBADA965BB27D56872D8E7DE6AE6E07AC9BE6A5F6DCD7D8C9AC85AD", ::mp_infil_umike_exit_suspension_creak, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_AFD125B6E07DD2E6992D1B7DBADA965BB27D56872D8E7DE6AE6E07AC9BE6A5F6DCD7D8C9AC85AD", ::mp_infil_umike_exit_suspension_creak, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_AFD125B6E07DD2E6992D1B7DBADA965BB27D56872D8E7DE6AE6E07AC9BE6A5F6DCD7D8C9AC85AD", ::mp_infil_umike_exit_suspension_creak, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_AFD125B6E07DD2E6992D1B7DBADA965BB27D56872D8E7DE6AE6E07AC9BE6A5F6DCD7D8C9AC85AD", ::mp_infil_umike_exit_suspension_creak, "_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190");
      break;
  }
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

script_model_alpha_anims(var_0) {
  switch (var_0) {
    case "_encstr_BDBB0616C6C186C2":
      level.scr_animtree["_encstr_9AE307B956E345D0AB"] = #animtree;
      level.scr_anim["_encstr_9AE307B956E345D0AB"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = % _encstr_9B1A16CDB16E73E352D0C2C9835F92C2ED31C095470495BB;
      level.scr_animname["_encstr_9AE307B956E345D0AB"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = "_encstr_9B1A16CDB16E73E352D0C2C9835F92C2ED31C095470495BB";
      level.scr_animtree["_encstr_844706EBB792B220"] = #animtree;
      level.scr_anim["_encstr_844706EBB792B220"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = % _encstr_B1B2176BC079E0903B0A1866D3CFDB380F17D5E3705CE8E95F;
      level.scr_animname["_encstr_844706EBB792B220"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = "_encstr_B1B2176BC079E0903B0A1866D3CFDB380F17D5E3705CE8E95F";
      level.scr_animtree["_encstr_A2FF07DB605823217A"] = #animtree;
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = % _encstr_9AE317AB578F7B88EAA348A9D388A0C717B7B78B81B93174E5;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = "_encstr_9AE317AB578F7B88EAA348A9D388A0C717B7B78B81B93174E5";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = "_encstr_968D0EA5CD995AD8EB5DB65AB656F54C";
      level.scr_animtree["_encstr_A2FF07DB605823217A"] = #animtree;
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = % _encstr_86B31C80EB392338636931A06D972DEF1FA158D8139A17113381C5B847FF;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = "_encstr_86B31C80EB392338636931A06D972DEF1FA158D8139A17113381C5B847FF";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = "_encstr_87A81361D53854A3B8B3F2BA588D370FA0A3F4CFC3";
      level.scr_animtree["_encstr_95FF079B8D7B1DFA4C"] = #animtree;
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = % _encstr_8BDC171543B121A20CEB8357CBA19A6BD80E0F9B9A2ACF0BD1;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = "_encstr_8BDC171543B121A20CEB8357CBA19A6BD80E0F9B9A2ACF0BD1";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = "_encstr_878D0E4F35D4728C217B959CD098F7BF";
      level.scr_animtree["_encstr_95FF079B8D7B1DFA4C"] = #animtree;
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = % _encstr_933A1C5B0EFA4B73CCB4C6AF575B5A6DACBE3BBABC26FA5687A51DEBBBB5;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = "_encstr_933A1C5B0EFA4B73CCB4C6AF575B5A6DACBE3BBABC26FA5687A51DEBBBB5";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = "_encstr_92A81363F0B6D7785F6D4D3C7857FF0DA3C82B7052";
      level.scr_animtree["_encstr_BAFF07CD367B1DD791"] = #animtree;
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = % _encstr_8FD017B538EB963799A5B1AF5DB6D2AD95F576EA5E64F5BB6B;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = "_encstr_8FD017B538EB963799A5B1AF5DB6D2AD95F576EA5E64F5BB6B";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = "_encstr_BD8D0E84E82D728406584FA750B97F1F";
      level.scr_animtree["_encstr_BAFF07CD367B1DD791"] = #animtree;
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = % _encstr_84F41C9058A9DBCAD1082910637B7852F5E73A2587C29922D96F65D8EBF8;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = "_encstr_84F41C9058A9DBCAD1082910637B7852F5E73A2587C29922D96F65D8EBF8";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = "_encstr_82A8130490683192E0A3F79FE795E975C0D8FB01A3";
      level.scr_animtree["_encstr_B1FF077B0D77B8B017"] = #animtree;
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = % _encstr_A1CB176533C151D21CFB9367FBB16A9BC83E1FEB8A0ADF1BE1;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = "_encstr_A1CB176533C151D21CFB9367FBB16A9BC83E1FEB8A0ADF1BE1";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = "_encstr_AD8D0EA16A60ECDC309F3A70AF4B09D4";
      level.scr_animtree["_encstr_B1FF077B0D77B8B017"] = #animtree;
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = % _encstr_9A331CF09B49736833D98110BD67F03FAFF12888A38AE7C163F19568974F;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = "_encstr_9A331CF09B49736833D98110BD67F03FAFF12888A38AE7C163F19568974F";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = "_encstr_8EA813EB56AF78195773B038BA9758C0C0B9290F94";
      level.scr_animtree["_encstr_A6FF0747907B08963F"] = #animtree;
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = % _encstr_91C01798F3212B309B6139B8559F189717A950D01B930F2B6F;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = "_encstr_91C01798F3212B309B6139B8559F189717A950D01B930F2B6F";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = "_encstr_978D0EBA58E57C93F6AD7D614A599793";
      level.scr_animtree["_encstr_A6FF0747907B08963F"] = #animtree;
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = % _encstr_8E2B1CDA88B75CBB31439CB765786F647B59E2D3B80999AF2ABB8CBF7CAD;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = "_encstr_8E2B1CDA88B75CBB31439CB765786F647B59E2D3B80999AF2ABB8CBF7CAD";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = "_encstr_BEA813D8883B4FB81FADBF3FCF51313580A07D112D";
      level.scr_animtree["_encstr_B2FF07CB61C0A3BF5D"] = #animtree;
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = % _encstr_8BBA1799404F18E5A7D228A90B3DA3101FC7140DB10E06EF4D;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = "_encstr_8BBA1799404F18E5A7D228A90B3DA3101FC7140DB10E06EF4D";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A38D1263E0C04B52EFA093284B1487AF79D75497"] = "_encstr_AA8D0E83AD52E3A077F77058A7651E85";
      level.scr_animtree["_encstr_B2FF07CB61C0A3BF5D"] = #animtree;
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = % _encstr_99571C62BB181F25F01BBC870B80ACAFBDF65A6B62C50FDF5863BCBF1778;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = "_encstr_99571C62BB181F25F01BBC870B80ACAFBDF65A6B62C50FDF5863BCBF1778";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_848817CFC3A3A275F128656FC08087DA895103173FDDDB2190"] = "_encstr_ACA813FB43F8376C9E03B8D3B46D2F63EBFBD5060F";
      break;
    case "_encstr_871D0613938567B7":
      level.scr_animtree["_encstr_9AE307B956E345D0AB"] = #animtree;
      level.scr_anim["_encstr_9AE307B956E345D0AB"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = % _encstr_9B1A16CDB16E73E352D0C2C9835F92C2ED31C095470495BB;
      level.scr_animname["_encstr_9AE307B956E345D0AB"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = "_encstr_9B1A16CDB16E73E352D0C2C9835F92C2ED31C095470495BB";
      level.scr_animtree["_encstr_844706EBB792B220"] = #animtree;
      level.scr_anim["_encstr_844706EBB792B220"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = % _encstr_B1B2176BC079E0903B0A1866D3CFDB380F17D5E3705CE8E95F;
      level.scr_animname["_encstr_844706EBB792B220"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = "_encstr_B1B2176BC079E0903B0A1866D3CFDB380F17D5E3705CE8E95F";
      level.scr_animtree["_encstr_A2FF07DB605823217A"] = #animtree;
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = % _encstr_9AE317AB578F7B88EAA348A9D388A0C717B7B78B81B93174E5;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = "_encstr_9AE317AB578F7B88EAA348A9D388A0C717B7B78B81B93174E5";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = "_encstr_968D0EA5CD995AD8EB5DB65AB656F54C";
      level.scr_animtree["_encstr_A2FF07DB605823217A"] = #animtree;
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = % _encstr_86B31C80EB392338636931A06D972DEF1FA158D8139A17113381C5B847FF;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = "_encstr_86B31C80EB392338636931A06D972DEF1FA158D8139A17113381C5B847FF";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = "_encstr_87A81361D53854A3B8B3F2BA588D370FA0A3F4CFC3";
      level.scr_animtree["_encstr_95FF079B8D7B1DFA4C"] = #animtree;
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = % _encstr_8BDC171543B121A20CEB8357CBA19A6BD80E0F9B9A2ACF0BD1;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = "_encstr_8BDC171543B121A20CEB8357CBA19A6BD80E0F9B9A2ACF0BD1";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = "_encstr_878D0E4F35D4728C217B959CD098F7BF";
      level.scr_animtree["_encstr_95FF079B8D7B1DFA4C"] = #animtree;
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = % _encstr_933A1C5B0EFA4B73CCB4C6AF575B5A6DACBE3BBABC26FA5687A51DEBBBB5;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = "_encstr_933A1C5B0EFA4B73CCB4C6AF575B5A6DACBE3BBABC26FA5687A51DEBBBB5";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = "_encstr_92A81363F0B6D7785F6D4D3C7857FF0DA3C82B7052";
      level.scr_animtree["_encstr_BAFF07CD367B1DD791"] = #animtree;
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = % _encstr_8FD017B538EB963799A5B1AF5DB6D2AD95F576EA5E64F5BB6B;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = "_encstr_8FD017B538EB963799A5B1AF5DB6D2AD95F576EA5E64F5BB6B";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = "_encstr_BD8D0E84E82D728406584FA750B97F1F";
      level.scr_animtree["_encstr_BAFF07CD367B1DD791"] = #animtree;
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = % _encstr_84F41C9058A9DBCAD1082910637B7852F5E73A2587C29922D96F65D8EBF8;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = "_encstr_84F41C9058A9DBCAD1082910637B7852F5E73A2587C29922D96F65D8EBF8";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = "_encstr_82A8130490683192E0A3F79FE795E975C0D8FB01A3";
      level.scr_animtree["_encstr_B1FF077B0D77B8B017"] = #animtree;
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = % _encstr_A1CB176533C151D21CFB9367FBB16A9BC83E1FEB8A0ADF1BE1;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = "_encstr_A1CB176533C151D21CFB9367FBB16A9BC83E1FEB8A0ADF1BE1";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = "_encstr_AD8D0EA16A60ECDC309F3A70AF4B09D4";
      level.scr_animtree["_encstr_B1FF077B0D77B8B017"] = #animtree;
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = % _encstr_9A331CF09B49736833D98110BD67F03FAFF12888A38AE7C163F19568974F;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = "_encstr_9A331CF09B49736833D98110BD67F03FAFF12888A38AE7C163F19568974F";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = "_encstr_8EA813EB56AF78195773B038BA9758C0C0B9290F94";
      level.scr_animtree["_encstr_A6FF0747907B08963F"] = #animtree;
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = % _encstr_91C01798F3212B309B6139B8559F189717A950D01B930F2B6F;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = "_encstr_91C01798F3212B309B6139B8559F189717A950D01B930F2B6F";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = "_encstr_978D0EBA58E57C93F6AD7D614A599793";
      level.scr_animtree["_encstr_A6FF0747907B08963F"] = #animtree;
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = % _encstr_8E2B1CDA88B75CBB31439CB765786F647B59E2D3B80999AF2ABB8CBF7CAD;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = "_encstr_8E2B1CDA88B75CBB31439CB765786F647B59E2D3B80999AF2ABB8CBF7CAD";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = "_encstr_BEA813D8883B4FB81FADBF3FCF51313580A07D112D";
      level.scr_animtree["_encstr_B2FF07CB61C0A3BF5D"] = #animtree;
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = % _encstr_8BBA1799404F18E5A7D228A90B3DA3101FC7140DB10E06EF4D;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = "_encstr_8BBA1799404F18E5A7D228A90B3DA3101FC7140DB10E06EF4D";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_AFDE12EA6B4B6DCABE5ADC3396637D269C2C9DDB"] = "_encstr_AA8D0E83AD52E3A077F77058A7651E85";
      level.scr_animtree["_encstr_B2FF07CB61C0A3BF5D"] = #animtree;
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = % _encstr_99571C62BB181F25F01BBC870B80ACAFBDF65A6B62C50FDF5863BCBF1778;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = "_encstr_99571C62BB181F25F01BBC870B80ACAFBDF65A6B62C50FDF5863BCBF1778";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8BF9172B88E0EFD8C780733E02F1D165C8C7BCA8273AC3BBD3"] = "_encstr_ACA813FB43F8376C9E03B8D3B46D2F63EBFBD5060F";
      break;
  }
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

vehicles_alpha_anims(var_0) {
  switch (var_0) {
    case "_encstr_BDBB0616C6C186C2":
      level.scr_animtree["_encstr_A2AD09AED6B4D6AC95AC1A"] = #animtree;
      level.scr_anim["_encstr_A2AD09AED6B4D6AC95AC1A"]["_encstr_BA2F175D6B5A5BACAF2DCD334B36D785630E0D85BE3858E80D"] = % _encstr_9561205B38EB2DB9662DC6FABAB6D2B6CAAFEC561A5A8D1BB2F51D165AC6CE0BA395;
      break;
    case "_encstr_871D0613938567B7":
      level.scr_animtree["_encstr_A2AD09AED6B4D6AC95AC1A"] = #animtree;
      level.scr_anim["_encstr_A2AD09AED6B4D6AC95AC1A"]["_encstr_8DA717BAD6B45B56BE9637CCA5D8AF4C4EC2CEDBD707853A0D"] = % _encstr_9561205B38EB2DB9662DC6FABAB6D2B6CAAFEC561A5A8D1BB2F51D165AC6CE0BA395;
      break;
  }
}

commander_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players)
  self playsoundtoplayer(var_0, var_4);
}

mp_infil_umike_exit_jump_land_sfx(var_0) {
  var_0 playsoundonmovingent("_encstr_928F1E3B2311539896AC70EE5375689A6A379399DFCB30E0BD85FBE63D212845");
}

mp_infil_umike_exit_npc_step_sfx(var_0) {
  if(isPlayer(var_0))
    var_0 playlocalsound("_encstr_A32E1DB7E1506A96C0C0FD097BA0A90215271F9BBB6DB140784B390A3388F8");
  else
    var_0 playsoundonmovingent("_encstr_B8761D41EA0123208E47B8291FAD987FCA59CD53040B87E86077195063FD73");
}

mp_infil_umike_exit_suspension_creak(var_0) {
  if(isDefined(var_0.animname))
    var_1 = "_encstr_BEF1269D809EDC4E88AB10C9A3380760A2700229DF8BA9BB0DAAFB880E2B2D1F400F50539DD768A7" + var_0.animname;
  else
    var_1 = "_encstr_83EE2C87D180BA4610300DD9AB90995265772F4B4BBD8113E05B025F2048D16A48DFCFEBCB6F0AC7E8C0FDE33E2A";

  var_0 playsoundonmovingent(var_1);
}

umike_cam_shake_ground(var_0) {
  var_1 = var_0.player;
  var_1 notify("_encstr_BA690F0390EF325749AF754FBEF0773C13");
  var_1 playrumbleonpositionforclient("_encstr_AA9A12B327DBAB73237D07F6EACD23BE6358E646", var_1.origin);
  var_1 setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_934C0218", 0);
}

giveinteractiveinfilweapon() {
  var_0 = getcompleteweaponname("_encstr_936F17D2DD1CF5B9DCF5588D0E1A856A184BE6992DB17D6BE0", ["_encstr_8B210CA32782D679D89B8170D7DA", "_encstr_911E0E079317F02187A84A707A7F3BEA", "_encstr_93610D39B387B277C7E91F88A9C288", "_encstr_ACE80C9DC211299881B808595D9A", "_encstr_A6A60D2CB17B3BBE0B630E86C29AC0", "_encstr_B18B0E549D53E33B6A4AF90B52C2C33B"]);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  scripts\common\utility::allow_weapon_switch(1);
  var_1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 0);

  if(var_1) {
    self.infilweapon = var_0;
    scripts\common\utility::allow_weapon_switch(0);
    scripts\mp\utility\weapon::setrecoilscale(0.0, 50);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  return var_1;
}

allowinteractivecombat(var_0) {
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  thread ineractivecombatmessaging();
  wait(level.interactiveinfilstart);
  self.interactivecombat = 1;
  scripts\common\utility::allow_fire(1);
  scripts\common\utility::allow_ads(1);
  scripts\common\utility::allow_reload(1);
  self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
  self lerpfovbypreset("_encstr_BA79117D172A8BEB2CEBC9BAEF7D61DF12FF6E");
  wait(level.interactiveinfilwindow);
  self.interactivecombat = 0;
  scripts\common\utility::allow_fire(0);
  scripts\common\utility::allow_ads(0);
  scripts\common\utility::allow_reload(0);
  scripts\mp\utility\weapon::setrecoilscale();
  self setdemeanorviewmodel("_encstr_B418059B8533CA", "_encstr_9731172721C35FCCD5DA011FC0206B58BF788667D763D760C9");
}

ineractivecombatmessaging() {
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  wait 0.25;
  self iprintlnbold("_encstr_925A166040FB75CF21A67B7FBD733FEE3F484AEB38436FE6");
  wait 1.25;

  switch (self.animname) {
    case "_encstr_A2FF07DB605823217A":
      self iprintlnbold("_encstr_BE331B799F694B41BBEC5DF742422511C2269291E70860E562064D668E");
      break;
    case "_encstr_95FF079B8D7B1DFA4C":
      self iprintlnbold("_encstr_8B041B3CC5CB1869DB3A6FBFB0B82AD3D621B28D0F9A1730AB5A0D93BE");
      break;
    default:
      break;
  }

  wait 1.25;
  self iprintlnbold("_encstr_A2B01F8A0BE43B958E3708A92CC9DA2B469008A82CAD56803A86B25B10DEEAD184");
}

interactiveinfilthink(var_0) {
  level thread manageinteractivecombattargets(var_0);
}

manageinteractivecombattargets(var_0) {
  while(!isDefined(level.infiltargets))
    waitframe();

  foreach(var_2 in level.infiltargets["_encstr_8E8405EA382B2A"]) {
    var_2 thread targetdamagethink(var_0);
    var_2 thread deleteoninfilcomplete();
  }
}

targetdamagethink(var_0) {
  level endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");

  if(istrue(self.isbonus))
    self.health = 220;
  else
    self.health = 100;

  wait(level.interactiveinfilstart);
  var_1 = scripts\mp\utility\outline::outlineenableforteam(self, var_0, scripts\engine\utility::ter_op(istrue(self.isbonus), "_encstr_9B0F12DE5DE8B15AB9B2F53295834734F54E59C8", "_encstr_96AE15674513800375C947242F6863285787EB2916E22F"), "_encstr_AC760D7A6AE6A9501F43EF73238A0C");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_2 >= self.health) {
      scripts\mp\utility\outline::outlinedisable(var_1, self);

      if(istrue(self.isbonus)) {
        var_3 thread scripts\mp\rank::giverankxp("_encstr_A2C60C4B9BCC2DD8FA89F69BBA37", 1000);
        var_3 thread scripts\mp\rank::scoreeventpopup("_encstr_A2C60C4B9BCC2DD8FA89F69BBA37");
      }

      break;
    }
  }
}

deleteoninfilcomplete() {
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");

  if(!isDefined(self)) {
    return;
  }
  if(istrue(self.isbonus))
    self setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_BECC055CF3811A");
  else
    self suicide();
}

getcommanderassets(var_0) {
  var_1 = spawnStruct();
  var_1.body = "_encstr_8CB81826ED465EEB6BC1D71A2B63D21BB7388E59C9BE8D4E2BEE";
  var_1.head = "_encstr_A9AB18A8FFC988AF627B7F19471A53E86F129381A20F784EDA7F";

  switch (level.mapname) {
    case "_encstr_A3890850E25F90B79A83":
      if(var_0 == "_encstr_9A8507BA4040188D08") {
        var_1.body = "_encstr_A32D198BDFCD6BA7B0417A053E48B2221653F7A7B7E0025C10C8F7";
        var_1.head = "_encstr_93691034B20B32AFDCD87DADAFCEC99556E6";
      } else {
        var_1.body = "_encstr_9A6012C698982FBF07C3F0C1F3A541F0C1EED86B";
        var_1.head = "_encstr_A699137822F75D91BA03E78B17664015D3FA93EDBB";
      }

      break;
    case "_encstr_99020BB0027F38974BA78783FF":
    case "_encstr_BDFF088922C9FF1946BF":
      if(var_0 == "_encstr_9A8507BA4040188D08") {
        var_1.body = "_encstr_8AE0158A70B90777888F1D584FDBB193537FD78FBBD102";
        var_1.head = "_encstr_8D6F1520DDAFDDC1CACA0787874C376B44D947780AF7AE";
      } else {
        var_1.body = "_encstr_8C9819267B3297D70BC6D7E2C28E581BC2FA23CAE6CA9347BE60C6";
        var_1.head = "_encstr_87370F3C892844E9AED777B7475F22B980";
      }

      break;
  }

  return var_1;
}

getdriverassets(var_0) {
  var_1 = spawnStruct();
  var_1.body = "_encstr_BEBE2621B514B8D8AA43377F0F939590BA4D0E395C6A2B0502EF5B276F9A5EA07FE2F09149F1199F";
  var_1.head = "_encstr_81192660AF6F53472F4FFE4B51BB53739682AE154B8B9D2BFDC3979640B2607B3F26BBE137D50712";

  switch (level.mapname) {
    default:
      if(var_0 == "_encstr_9A8507BA4040188D08") {
        var_1.body = "_encstr_BEBE2621B514B8D8AA43377F0F939590BA4D0E395C6A2B0502EF5B276F9A5EA07FE2F09149F1199F";
        var_1.head = "_encstr_81192660AF6F53472F4FFE4B51BB53739682AE154B8B9D2BFDC3979640B2607B3F26BBE137D50712";
      } else {
        var_1.body = "_encstr_A1FF2A137B232FAFB5387DB2859B8E2B9C37FA999627CAD12BC26BEB561637477D9BECF5377BEBDCD896B976";
        var_1.head = "_encstr_936B2434B20B32AF5B597DACB0E6D19527E6AF334BE45647ACC2B6EB9558B9D1BE6E6B76BE99";
      }

      break;
  }

  return var_1;
}

reducewind(var_0) {
  var_1 = var_0.player;
  var_1 setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_AF0703133A", 0);
}