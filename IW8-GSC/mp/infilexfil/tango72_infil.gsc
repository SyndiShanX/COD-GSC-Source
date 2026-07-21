/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\infilexfil\tango72_infil.gsc
***********************************************/

tango72_init(var_0) {
  initanims(var_0);
  var_1 = [];
  var_1[0] = [2, 3];
  var_1[1] = [4, 5];
  var_1[2] = [0, 1];
  thread scripts\mp\infilexfil\infilexfil::infil_add("_encstr_99520E44D02871D2A0E187433F50AFE2", var_0, 6, 4, var_1, ::tango72_spawn, ::tango72_get_length, ::player_tango72_infil_think);
}

tango72_spawn(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_4.origin);
  var_5.angles = var_4.angles;
  var_5.scene_node = var_4;

  if(var_2 == "_encstr_BDBB0616C6C186C2")
    var_5.origin = var_5.origin + (0, 0, 10);

  var_5 thread infilthink(var_0, var_2);
  return var_5;
}

tango72_get_length(var_0) {
  var_1 = getanimlength(level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_964A0FF93160F93F9BA381397DA1832977" + var_0 + "_encstr_9592073E93409903BA"]);
  var_1 = var_1 + getanimlength(level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_964A0FF93160F93F9BA381397DA1832977" + var_0 + "_encstr_96D206F968DB6F43"]);
  return var_1;
}

player_tango72_infil_think(var_0, var_1) {
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  thread _id_13A3C(var_0);
  thread player_infil_end();
  var_2 = var_0.linktoent gettagorigin("_encstr_9AD01136187923E791B06F67D06B9509DD203B");
  var_3 = var_0.linktoent gettagangles("_encstr_9AD01136187923E791B06F67D06B9509DD203B");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("_encstr_AC6B06F0DA2281E1" + var_1, var_2, var_3);
  self.player_rig linkTo(var_0.linktoent, "_encstr_9AD01136187923E791B06F67D06B9509DD203B", (0, 0, 0), (0, 0, 0));

  if(!isai(self)) {
    if(var_1 != 5)
      self.player_rig scripts\mp\utility\infilexfil::handleweaponstatenotetrack("_encstr_84660547ED28E0");

    self lerpviewangleclamp(1, 0.25, 0.25, 10, 20, 40, 10);
  }

  self setdemeanorviewmodel("_encstr_B418059B8533CA", "_encstr_828D1AD82BC0014C52C7AFD1B7FA85483E85239652C18075292BCBFD");
  self.player_rig.weapon_state_func = scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  thread scripts\mp\infilexfil\infilexfil::infil_scene_fade_in(0.0, 0.55);
  thread player_van_disconnect();
  level waittill("_encstr_B2600CF8759933D3EE634E77CB7A");

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

  if(isDefined(self.animname) && !isai(self)) {
    var_8 = "_encstr_A516166A066549A908F8776B196399E2DFA8F922798581B8";

    if(isDefined(var_0.subtype)) {
      if(var_0.subtype == "_encstr_BDBB0616C6C186C2") {
        switch (self.animname) {
          case "_encstr_A2FF07DB605823217A":
            var_8 = "_encstr_A516166A066549A908F8776B196399E2DFA8F922798581B8";
            break;
          case "_encstr_95FF079B8D7B1DFA4C":
            var_8 = "_encstr_8616163BA962BFDB386393C491BB7185FFEAD7C092060EF2";
            break;
          case "_encstr_BAFF07CD367B1DD791":
            var_8 = "_encstr_8D1616208A257FE873B663E9B723D1D5CFD2C9C092FAC7AB";
            break;
          case "_encstr_B1FF077B0D77B8B017":
            var_8 = "_encstr_9B1616E28E9DB1218060FFD391FBE16A571061DAE10D0924";
            break;
          case "_encstr_A6FF0747907B08963F":
            var_8 = "_encstr_8B1616FB4FF85937A051326A5E854F4DD82F5F60F9A09192";
            break;
          case "_encstr_B2FF07CB61C0A3BF5D":
            var_8 = "_encstr_83161663403807A3584FD88AC75D399E783DF17358554E2B";
            break;
          default:
            var_8 = "_encstr_A516166A066549A908F8776B196399E2DFA8F922798581B8";
            break;
        }
      } else {
        switch (self.animname) {
          case "_encstr_A2FF07DB605823217A":
            var_8 = "_encstr_8616163BA962BFDB386393C491BB7185FFEAD7C092060EF2";
            break;
          case "_encstr_95FF079B8D7B1DFA4C":
            var_8 = "_encstr_A516166A066549A908F8776B196399E2DFA8F922798581B8";
            break;
          case "_encstr_BAFF07CD367B1DD791":
            var_8 = "_encstr_8D1616208A257FE873B663E9B723D1D5CFD2C9C092FAC7AB";
            break;
          case "_encstr_B1FF077B0D77B8B017":
            var_8 = "_encstr_9B1616E28E9DB1218060FFD391FBE16A571061DAE10D0924";
            break;
          case "_encstr_A6FF0747907B08963F":
            var_8 = "_encstr_8B1616FB4FF85937A051326A5E854F4DD82F5F60F9A09192";
            break;
          case "_encstr_B2FF07CB61C0A3BF5D":
            var_8 = "_encstr_83161663403807A3584FD88AC75D399E783DF17358554E2B";
            break;
          default:
            var_8 = "_encstr_A516166A066549A908F8776B196399E2DFA8F922798581B8";
            break;
        }
      }
    }

    self playlocalsound(var_8);

    if(var_0.subtype == "_encstr_BDBB0616C6C186C2")
      self playlocalsound("_encstr_B2B71FF8BA20D91C3EA9DA2DEF780E5D778D21096A028A81B07717912B3FB092CB");
    else
      self playlocalsound("_encstr_86BA1E9BAA051F8813D603899703F1352FF2E98022DD8F8633FD9CFDBF3B98D5");
  }

  self setcinematicmotionoverride("_encstr_921D09D9D9C0090D7275B4");
  self lerpfovscalefactor(0, 0);
  var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "_encstr_964A0FF93160F93F9BA381397DA1832977" + var_0.subtype + "_encstr_9592073E93409903BA", "_encstr_9AD01136187923E791B06F67D06B9509DD203B");

  if(isDefined(level.scr_viewmodelanim[self.animname]) && isDefined(level.scr_viewmodelanim[self.animname]["_encstr_964A0FF93160F93F9BA381397DA1832977" + var_0.subtype + "_encstr_9592073E93409903BA"]))
    setDvar("_encstr_856D0B9C3562D3969C6AA435A5", 0);

  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  thread clear_infil_ambient_zone();
  self lerpfovscalefactor(1, 0.75);
  var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "_encstr_964A0FF93160F93F9BA381397DA1832977" + var_0.subtype + "_encstr_96D206F968DB6F43", "_encstr_9AD01136187923E791B06F67D06B9509DD203B");

  if(isDefined(self.player_rig) && self.player_rig islinked())
    self.player_rig unlink();

  self visionsetnakedforplayer("_encstr_B40101", 0.75);
  self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
  self clearcinematicmotionoverride();
}

clear_infil_ambient_zone() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait 3;
  self clearclienttriggeraudiozone(2);
  self clearallsoundsubmixes();
}

player_infil_end() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  self clearclienttriggeraudiozone(1.0);
  scripts\mp\utility\player::setdof_default();
  setDvar("_encstr_856D0B9C3562D3969C6AA435A5", 0);
}

_id_13A3C(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isPlayer(self)) {
    self setclienttriggeraudiozonepartialwithfade("_encstr_961512FB91885F1D72B5878935C0A4BBB888A2C3", 0.05, "_encstr_AB1904853B28");
    wait 0.5;
    self playlocalsound("_encstr_B2841EABDFC519CBA39FEB39CFE9B3D3087BE943E14072189F8D354ED329BEB1");
    level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
    wait 1;
    self stoplocalsound("_encstr_B2841EABDFC519CBA39FEB39CFE9B3D3087BE943E14072189F8D354ED329BEB1");
  }
}

player_van_disconnect() {
  level endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(self)) {
    self visionsetnakedforplayer("_encstr_B40101");
    self clearclienttriggeraudiozone(0.0);
    self lerpfovbypreset("_encstr_8B1608EC43B8D647A113");
    self setviewmodeldepthoffield(0, 0, 18);
    scripts\mp\utility\player::setdof_default();
  }
}

spawnactors(var_0, var_1, var_2) {
  if(!isDefined(self.actors))
    self.actors = [];

  self.actors[self.actors.size] = self.linktoent spawn_anim_model("_encstr_8B190AC730E03D42856D3FF2", "_encstr_9AD01136187923E791B06F67D06B9509DD203B", "_encstr_97D01482D869C0E7B9B9D7F1C7E3E74D8BC13FE90B1D", "_encstr_996214AB202174E1FFAEF1B7839DFA3DE8E85307E878");
  self.crushcar = spawn_anim_model("_encstr_990709387D6BA87B4FE753", undefined, "_encstr_AFC51D1B0B8B3FE7A8803B4918F8E481DC9BFBA3EBB8328270ABB4CE31632D");

  foreach(var_4 in self.actors)
  var_4.infil = self;

  self.actors[0].anim_playsound_func = ::commander_play_sound_func;
}

infilthink(var_0, var_1) {
  foreach(var_3 in getEntArray("_encstr_AACF0DD2B9CC4B1BFA19AC1BACD12B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"))
  var_3 delete();

  thread vehiclethink(var_0, self.scene_node, var_1);
  thread actorthink(var_0, self.scene_node, var_1);
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  setDvar("_encstr_A3D50AA2986AA6D30A35D4A5", 1);
  level notify("_encstr_B2600CF8759933D3EE634E77CB7A");
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  setDvar("_encstr_A3D50AA2986AA6D30A35D4A5", 0);

  while(isDefined(self.actors))
    waitframe();

  level.stop_station_closed_vo--;
  self delete();
}

vehiclethink(var_0, var_1, var_2, var_3) {
  var_4 = spawntango72(var_1, var_0, var_2);

  if(!isDefined(self.path))
    scripts\common\anim::anim_first_frame_solo(var_4, "_encstr_964A0FF93160F93F9BA381397DA1832977" + var_2 + "_encstr_9592073E93409903BA");

  var_4 vehicle_turnengineoff();
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  var_4 setscriptablepartstate("_encstr_A3E10929B2E7B0857FC8AE", "_encstr_A7A408B9CA5D1D4E2C63");
  var_4 setscriptablepartstate("_encstr_8ECD0A02885967AF4B89550B", "_encstr_A7A408B9CA5D1D4E2C63");

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    var_4 setscriptablepartstate("_encstr_85E50DA0FAF753C089348387282BB0", "_encstr_AB0703DBB9");

  if(isDefined(self.path))
    self.linktoent thread vehiclefollowpath(self.path);
  else
    thread scripts\common\anim::anim_single_solo(var_4, "_encstr_964A0FF93160F93F9BA381397DA1832977" + var_2 + "_encstr_9592073E93409903BA");

  var_4 thread scripts\common\anim::anim_single_solo(var_4.turret, "_encstr_964A0FF93160F93F9BA381397DA1832977" + var_2 + "_encstr_9592073E93409903BA", "_encstr_99FE0B2B19086F6B9DC5D387E1");

  if(var_2 == "_encstr_BDBB0616C6C186C2")
    var_4 playsoundonmovingent("_encstr_BE951B5B01580F2C084DE1FC27A3F603743811B3292087E9C0BBE7F059");
  else
    var_4 playsoundonmovingent("_encstr_88D61A6E3637F5D29BCCB48DEB3AC29B9DDBFA3A0B37B5FAC6B2993A");

  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  var_5 = getEnt("_encstr_8A69111DCD91F537E0B0DDE6AC32BE8DB15A0E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_5)) {
    var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
    var_6.angles = var_4.angles;
    var_6 clonebrushmodeltoscriptmodel(var_5);
    var_6 disconnectPaths();
  }

  var_4 vehphys_deactivate();
  var_4 makecorpse();
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][self.type][var_2]["_encstr_A5D81207599C375A9B3A9573D195AC0DB41B3695"] = ::spawnpersistentvehicle;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][self.type][var_2]["_encstr_91260B40A2EC2B91B36DA82E47"] = self.linktoent.origin;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][self.type][var_2]["_encstr_AF260B886A249329FB35F7680F"] = self.linktoent.angles;
}

spawnpersistentvehicle(var_0, var_1) {
  var_2 = game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_91260B40A2EC2B91B36DA82E47"];
  var_3 = game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_AF260B886A249329FB35F7680F"];
  var_4 = spawnVehicle("_encstr_856A27BBF009D8AF6073ACE799680B5969788222385F92779B6EA9DE3870E7DBF750198B38433ED373", "_encstr_AC540D92105BA5B3D95D1C12ED21EF", "_encstr_A7150F8B7858071BA350B7ADE4ED61CDA3", var_2, var_3);
  var_4 vehphys_forcekeyframedmotion();
  var_4.animname = "_encstr_ADDB08B139CD68F89667";
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_5.angles = var_3;
  var_5 setModel("_encstr_8E9121A4EDEBE026DF02C90F756A4907198A58A9AA3E6AAFBE87AFD867F0175810C72C");
  var_5 linkTo(var_4, "_encstr_99FE0B2B19086F6B9DC5D387E1", (0, 0, 0), (0, 0, 0));
  var_4.turret = var_5;
  var_4.turret.animname = "_encstr_82BD0F6BBE86D0588732BFE1C73B1E1834";
  var_4.turret scripts\common\anim::setanimtree();
  var_4 vehphys_deactivate();
  var_4 makecorpse();
  var_6 = getEnt("_encstr_8A69111DCD91F537E0B0DDE6AC32BE8DB15A0E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_6)) {
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
    var_7.angles = var_3;
    var_7 clonebrushmodeltoscriptmodel(var_6);
    var_7 disconnectPaths();
  }
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
  self.crushcar = spawn_anim_model("_encstr_990709387D6BA87B4FE753", undefined, "_encstr_AFC51D1B0B8B3FE7A8803B4918F8E481DC9BFBA3EBB8328270ABB4CE31632D");
  scripts\common\anim::anim_first_frame_solo(self.crushcar, "_encstr_964A0FF93160F93F9BA381397DA1832977" + var_2);
  scripts\mp\utility\infilexfil::hideactors();
  level waittill("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  scripts\mp\utility\infilexfil::showactors();
  scripts\common\anim::anim_single_solo(self.crushcar, "_encstr_964A0FF93160F93F9BA381397DA1832977" + var_2);

  if(isDefined(self.crushcar)) {
    self.crushcar delete();
    self.crushcar = undefined;
  }
}

spawn_anim_model(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1;

  if(scripts\engine\utility::cointoss())
    var_5 = 0;

  if(var_2 == "_encstr_A31207CBF788523281") {
    if(var_5) {
      var_6 = randomint(3);

      if(var_6 == 0)
        var_2 = "_encstr_832F17997FC2A8AB797BEB0FA0308FA957D9EE6119331833CA";
      else if(var_6 == 1)
        var_2 = "_encstr_BACA1C8025F8ABC978408857AE9E75EF69F7209CA783BFDF779686B7FFEB";
      else if(var_6 == 2)
        var_2 = "_encstr_929214A948241FF1E84E013760382830114B393FAE32";
    } else if(scripts\engine\utility::cointoss())
      var_2 = "_encstr_9699169827F696A182F555E8CDB98D99459F68D097E92ED9";
    else
      var_2 = "_encstr_857C15EF9909010BCF4F245E2055F2DD91A84F9752E616";
  }

  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_7 setModel(var_2);

  if(isDefined(var_3)) {
    if(var_3 == "_encstr_A31207CBF788523281") {
      if(var_5) {
        if(scripts\engine\utility::cointoss())
          var_3 = "_encstr_B6CC2C86B22C46FA89CED7ECB09C7D86B20B91EB313BFA5B2CC62BBEC0E4BE43B20BC8D7E6B1D7D685C695F54C1A";
        else
          var_3 = "_encstr_AA472C9AB1AFB3F138FF67368BC089CBC5A9D25118776BB7F9DD531701F241137DC14AD940DD5B6D21CF4924A730";
      } else if(scripts\engine\utility::cointoss())
        var_3 = "_encstr_BAFA30D02B1646F589B3FA9D16E47DA12B8532EB99CAD60BB156FA8936FA6089BE0D2B0B467D37B1D79995AD2C3656F56218";
      else
        var_3 = "_encstr_818B3034952C91F54CD9F5B3B027BE0DCAB08CD79B8DFACCB2D6B0B195FA18D0F543CAB0C8FA99565BC21B95D74C1BBE608C";
    }

    var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_8 setModel(var_3);
    var_8 linkTo(var_7, "_encstr_8EEC09159F6238030BFA23", (0, 0, 0), (0, 0, 0));
    var_7.head = var_8;
    var_7 thread scripts\engine\utility::delete_on_death(var_8);
  }

  if(isDefined(var_4)) {
    var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_9 setModel(var_4);
    var_9 linkTo(var_7, "_encstr_8107069A17A718C5", (0, 0, 0), (0, 0, 0));
    var_7 thread scripts\engine\utility::delete_on_death(var_9);
    var_7.weapon = var_9;
  }

  var_7.animname = var_0;
  var_7 scripts\common\anim::setanimtree();

  if(isDefined(var_1)) {
    thread scripts\engine\utility::delete_on_death(var_7);
    var_7 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  }

  return var_7;
}

initanims(var_0) {
  script_model_alpha_anims(var_0);
  vehicles_alpha_anims(var_0);

  switch (var_0) {
    case "_encstr_BDBB0616C6C186C2":
      scripts\common\anim::addnotetrack_customfunction("_encstr_8B190AC730E03D42856D3FF2", "_encstr_A5E10D1DBA72E3916B6F48287F86CA", ::treadsheavy, "_encstr_9AB214FDA973210F1BFF19A01267DB985F51097708F7");
      scripts\common\anim::addnotetrack_customfunction("_encstr_8B190AC730E03D42856D3FF2", "_encstr_971B0EE5BE92F280A00702A035635789", ::treadsnormal, "_encstr_9AB214FDA973210F1BFF19A01267DB985F51097708F7");
      scripts\common\anim::addnotetrack_customfunction("_encstr_8B190AC730E03D42856D3FF2", "_encstr_AD320FA393AC1619CDBE3795AB479CB063", ::treadsneutral, "_encstr_9AB214FDA973210F1BFF19A01267DB985F51097708F7");
      scripts\common\anim::addnotetrack_customfunction("_encstr_990709387D6BA87B4FE753", "_encstr_B69F0663E5A8DAAB", ::crushcar, "_encstr_9AB214FDA973210F1BFF19A01267DB985F51097708F7");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_BAB80C1F90AEA85D97D2937BFB63", ::cam_shake_crush, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_BAB80C1F90AEA85D97D2937BFB63", ::cam_shake_crush, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_BAB80C1F90AEA85D97D2937BFB63", ::cam_shake_crush, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_BAB80C1F90AEA85D97D2937BFB63", ::cam_shake_crush, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_BAB80C1F90AEA85D97D2937BFB63", ::cam_shake_crush, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_BAB80C1F90AEA85D97D2937BFB63", ::cam_shake_crush, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A79E0D1B9381A0DA5E371360CBA508", ::cam_shake_ground, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A79E0D1B9381A0DA5E371360CBA508", ::cam_shake_ground, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A79E0D1B9381A0DA5E371360CBA508", ::cam_shake_ground, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A79E0D1B9381A0DA5E371360CBA508", ::cam_shake_ground, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A79E0D1B9381A0DA5E371360CBA508", ::cam_shake_ground, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A79E0D1B9381A0DA5E371360CBA508", ::cam_shake_ground, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_84BF1640EA455FC8539643C957C331F5EFB2A910735E27AB", ::_id_12EF4, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_8ABF16EB69BD3FC3B008F0ACF70BF2FB8F97E7251B77E807", ::_id_12EF7, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_B2BF16309A350F9803A673F98733C125DFE2D940438ED75B", ::_id_12EF5, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_97BF16B93673D7A59B995A8DFA47B09B76BDD7CD8336AF68", ::_id_12EF8, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_85BF165B70B5B1C79064392490BBAF85DF78010250077952", ::_id_12EF6, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_ADBF1620CBE07FE9C5AE201851B35BDAC1300750C8EA9195", ::_id_12EF9, "_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B");
      break;
    case "_encstr_871D0613938567B7":
      scripts\common\anim::addnotetrack_customfunction("_encstr_8B190AC730E03D42856D3FF2", "_encstr_A5E10D1DBA72E3916B6F48287F86CA", ::treadsheavy, "_encstr_AC6414280FE6695F0FFAC0D3C5329BB06FAB80082B8F");
      scripts\common\anim::addnotetrack_customfunction("_encstr_8B190AC730E03D42856D3FF2", "_encstr_971B0EE5BE92F280A00702A035635789", ::treadsnormal, "_encstr_AC6414280FE6695F0FFAC0D3C5329BB06FAB80082B8F");
      scripts\common\anim::addnotetrack_customfunction("_encstr_8B190AC730E03D42856D3FF2", "_encstr_AD320FA393AC1619CDBE3795AB479CB063", ::treadsneutral, "_encstr_AC6414280FE6695F0FFAC0D3C5329BB06FAB80082B8F");
      scripts\common\anim::addnotetrack_customfunction("_encstr_990709387D6BA87B4FE753", "_encstr_B69F0663E5A8DAAB", ::crushcar, "_encstr_AC6414280FE6695F0FFAC0D3C5329BB06FAB80082B8F");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_low, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_BAB80C1F90AEA85D97D2937BFB63", ::cam_shake_crush, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_BAB80C1F90AEA85D97D2937BFB63", ::cam_shake_crush, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_BAB80C1F90AEA85D97D2937BFB63", ::cam_shake_crush, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_BAB80C1F90AEA85D97D2937BFB63", ::cam_shake_crush, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_BAB80C1F90AEA85D97D2937BFB63", ::cam_shake_crush, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_BAB80C1F90AEA85D97D2937BFB63", ::cam_shake_crush, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_87940AB943C2AD95BE7BCCCC", scripts\mp\utility\infilexfil::cam_shake_off, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A79E0D1B9381A0DA5E371360CBA508", ::cam_shake_ground, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A79E0D1B9381A0DA5E371360CBA508", ::cam_shake_ground, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A79E0D1B9381A0DA5E371360CBA508", ::cam_shake_ground, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A79E0D1B9381A0DA5E371360CBA508", ::cam_shake_ground, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A79E0D1B9381A0DA5E371360CBA508", ::cam_shake_ground, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A79E0D1B9381A0DA5E371360CBA508", ::cam_shake_ground, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_8ABF16EB69BD3FC3B008F0ACF70BF2FB8F97E7251B77E807", ::_id_12EF7, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_84BF1640EA455FC8539643C957C331F5EFB2A910735E27AB", ::_id_12EF4, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_B2BF16309A350F9803A673F98733C125DFE2D940438ED75B", ::_id_12EF5, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_97BF16B93673D7A59B995A8DFA47B09B76BDD7CD8336AF68", ::_id_12EF8, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_85BF165B70B5B1C79064392490BBAF85DF78010250077952", ::_id_12EF6, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
      scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_ADBF1620CBE07FE9C5AE201851B35BDAC1300750C8EA9195", ::_id_12EF9, "_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3");
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

script_model_alpha_anims(var_0) {
  switch (var_0) {
    case "_encstr_BDBB0616C6C186C2":
      level.scr_animtree["_encstr_990709387D6BA87B4FE753"] = #animtree;
      level.scr_anim["_encstr_990709387D6BA87B4FE753"]["_encstr_9AB214FDA973210F1BFF19A01267DB985F51097708F7"] = % _encstr_886B229032B9E32606DF11F7A301EDD04FB7777727E863297377FBB5A6E34774FDC81B3A;
      level.scr_animname["_encstr_990709387D6BA87B4FE753"]["_encstr_9AB214FDA973210F1BFF19A01267DB985F51097708F7"] = "_encstr_886B229032B9E32606DF11F7A301EDD04FB7777727E863297377FBB5A6E34774FDC81B3A";
      level.scr_animtree["_encstr_82BD0F6BBE86D0588732BFE1C73B1E1834"] = #animtree;
      level.scr_anim["_encstr_82BD0F6BBE86D0588732BFE1C73B1E1834"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = % _encstr_A24A20B317AF6F803DFF987EE328E59C2DBB7A16F819D3A30BCA39CB07AC754C85AF;
      level.scr_animname["_encstr_82BD0F6BBE86D0588732BFE1C73B1E1834"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = "_encstr_A24A20B317AF6F803DFF987EE328E59C2DBB7A16F819D3A30BCA39CB07AC754C85AF";
      level.scr_animtree["_encstr_A2FF07DB605823217A"] = #animtree;
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = % _encstr_BA1221A81A57403872BFF997E32A70680FA33B66C6EFF86D7BC6A7E3F32346E0E70B58;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = "_encstr_BA1221A81A57403872BFF997E32A70680FA33B66C6EFF86D7BC6A7E3F32346E0E70B58";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = "_encstr_A65F18EA08B52CC3865D0136FCA8E6A29F58E2B3700F692F7EE7";
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = % _encstr_9A3A20FB4F7E0AC5FF5CA220EC1F38CF3FC73F4651A0D0E3D25FE8197327D321C7AF;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = "_encstr_9A3A20FB4F7E0AC5FF5CA220EC1F38CF3FC73F4651A0D0E3D25FE8197327D321C7AF";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = "_encstr_BD4F17FC90653ADC5E184773E830DFD7BFBD1E7405EF7227AB";
      level.scr_animtree["_encstr_95FF079B8D7B1DFA4C"] = #animtree;
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = % _encstr_8B3621DD8B79E99A44A3DB1FB1FFA25F50FB8229C121AFE323ED0FFF9D1D2B9F295BCD;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = "_encstr_8B3621DD8B79E99A44A3DB1FB1FFA25F50FB8229C121AFE323ED0FFF9D1D2B9F295BCD";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = "_encstr_B25F18F0580A028D8F14DF7A5C1F2292AFF8B65B93D2E6068972";
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = % _encstr_B2C120B8138FE015A2E481AFBB8A4D6917B6CAB1BF77F9EB7B5A101590E2B1D657B7;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = "_encstr_B2C120B8138FE015A2E481AFBB8A4D6917B6CAB1BF77F9EB7B5A101590E2B1D657B7";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = "_encstr_824F1783255BE7F0909B59C5A060D733E0C1587F19C8E907F2";
      level.scr_animtree["_encstr_BAFF07CD367B1DD791"] = #animtree;
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = % _encstr_A78A21ADC1EB4B9B665A8DF5D116E69DEDCDC8D7C2D776AECB337D2DCD8E277BF5EEDA;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = "_encstr_A78A21ADC1EB4B9B665A8DF5D116E69DEDCDC8D7C2D776AECB337D2DCD8E277BF5EEDA";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = "_encstr_845F182DB5567801C9938B8DC792F4EAD7CC683B5AB7114FE1E6";
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = % _encstr_8E942029F870B4CDF302C90F739A08E72FEF76AE4A9F3F07BB2757B92918133138C5;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = "_encstr_8E942029F870B4CDF302C90F739A08E72FEF76AE4A9F3F07BB2757B92918133138C5";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = "_encstr_924F17D2E6665A8D7DD12CE676F6B9C8BEB2F096D1D70BF566";
      level.scr_animtree["_encstr_B1FF077B0D77B8B017"] = #animtree;
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = % _encstr_8EB1217A2817FC1B5123FCD74559D3878FFA17D118BF370FEAB5C7E950C3FBCD47606A;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = "_encstr_8EB1217A2817FC1B5123FCD74559D3878FFA17D118BF370FEAB5C7E950C3FBCD47606A";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = "_encstr_B15F18C97D90FC1BAF3BAA2221603E6201DB765CDD3089F7281B";
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = % _encstr_9B7A20B5D74F62963148BB6FB8095E4A97CCEAA13727DAB5FA4A7F8FF0601C714F09;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = "_encstr_9B7A20B5D74F62963148BB6FB8095E4A97CCEAA13727DAB5FA4A7F8FF0601C714F09";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = "_encstr_BE4F17CA0509BB05DFE0F765FF8FB7A33051D188609F4117E7";
      level.scr_animtree["_encstr_A6FF0747907B08963F"] = #animtree;
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = % _encstr_B85C215B83D72DB9992D63F53AC29BB3BD6E19EB58EB9DABCBD4AF2DDC1D93DEFABBD6;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = "_encstr_B85C215B83D72DB9992D63F53AC29BB3BD6E19EB58EB9DABCBD4AF2DDC1D93DEFABBD6";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = "_encstr_A25F1878D2AFEBB03F3CFF6007D793E5590AD818EB054F296705";
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = % _encstr_97CE2072201FC423593BE4DF4D41DB8F97820FE90B473F07923DCF1D6368FBD91FB8;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = "_encstr_97CE2072201FC423593BE4DF4D41DB8F97820FE90B473F07923DCF1D6368FBD91FB8";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = "_encstr_8E4F17A988711FAD0F08B27AA857B3BA8EE530511DFE8739B3";
      level.scr_animtree["_encstr_B2FF07CB61C0A3BF5D"] = #animtree;
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = % _encstr_97AC2187B298EBDDAEE440A953E7252AD2AB1A404F31FC436255316CA003409D105F69;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = "_encstr_97AC2187B298EBDDAEE440A953E7252AD2AB1A404F31FC436255316CA003409D105F69";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = "_encstr_955F18A2F8049F25B9A13136AF10BB4A20B04AFB83688F5EE15D";
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = % _encstr_835620DAC1FA96CDCC96B17D1DC2739DDB9B64FA58F5D9AE978DD7CA3CA5A3AFDDB5;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = "_encstr_835620DAC1FA96CDCC96B17D1DC2739DDB9B64FA58F5D9AE978DD7CA3CA5A3AFDDB5";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_BEFF1921A95DF808669746887A0B3318B90189A15846F145035A3B"] = "_encstr_B84F176A30CCA71DF1F9794EE748F382F8C9F3121B083F1952";
      break;
    case "_encstr_871D0613938567B7":
      level.scr_animtree["_encstr_990709387D6BA87B4FE753"] = #animtree;
      level.scr_anim["_encstr_990709387D6BA87B4FE753"]["_encstr_AC6414280FE6695F0FFAC0D3C5329BB06FAB80082B8F"] = % _encstr_AFD7223DBFA7C11B921B5B7F13C020BFC022720F4641A621EDD6E8CB2BDABF13A8D9738F;
      level.scr_animname["_encstr_990709387D6BA87B4FE753"]["_encstr_AC6414280FE6695F0FFAC0D3C5329BB06FAB80082B8F"] = "_encstr_AFD7223DBFA7C11B921B5B7F13C020BFC022720F4641A621EDD6E8CB2BDABF13A8D9738F";
      level.scr_animtree["_encstr_82BD0F6BBE86D0588732BFE1C73B1E1834"] = #animtree;
      level.scr_anim["_encstr_82BD0F6BBE86D0588732BFE1C73B1E1834"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = % _encstr_A70C20BDF17E70953957D0705B5AB2A480EE6AC1B0EFD335C36315C37109BA9BC337;
      level.scr_animname["_encstr_82BD0F6BBE86D0588732BFE1C73B1E1834"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = "_encstr_A70C20BDF17E70953957D0705B5AB2A480EE6AC1B0EFD335C36315C37109BA9BC337";
      level.scr_animtree["_encstr_A2FF07DB605823217A"] = #animtree;
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = % _encstr_81D621AD0EFAB4E666A563D7A3B0CD9DB7DC91FA98D73BBA974CEB969BD14EEDEBBBDA;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = "_encstr_81D621AD0EFAB4E666A563D7A3B0CD9DB7DC91FA98D73BBA974CEB969BD14EEDEBBBDA";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = "_encstr_955F18A2F8049F25B9A13136AF10BB4A20B04AFB83688F9EE153";
      level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = % _encstr_8D5F20D60ED7B4CD33961BFA3A2CCDCEDBDC91EB13F53BAB9713BE2B875AE8EBEE5B;
      level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = "_encstr_8D5F20D60ED7B4CD33961BFA3A2CCDCEDBDC91EB13F53BAB9713BE2B875AE8EBEE5B";
      level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = "_encstr_B64F174C581762D0AF60A1F5EF08C7CA77021B6B03B1CADF93";
      level.scr_animtree["_encstr_95FF079B8D7B1DFA4C"] = #animtree;
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = % _encstr_B6F72172201FC423593BE4DF4D41DB8F97820FE918473F0792BECF1168CBE3D54F6862;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = "_encstr_B6F72172201FC423593BE4DF4D41DB8F97820FE918473F0792BECF1168CBE3D54F6862";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = "_encstr_A25F1878D2AFEBB03F3CFF6007D793E5590AD818EB054F496702";
      level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = % _encstr_AD7020B61CF54BE6CCD2B1AFA3C29BB3F6DC237D89FAB3BA2F64EB2B3C5AD1D7EEAD;
      level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = "_encstr_AD7020B61CF54BE6CCD2B1AFA3C29BB3F6DC237D89FAB3BA2F64EB2B3C5AD1D7EEAD";
      level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = "_encstr_B44F178C18E0B90A68293F0B6728E7BA81C14014B3D17AF1F6";
      level.scr_animtree["_encstr_BAFF07CD367B1DD791"] = #animtree;
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = % _encstr_ABFC218DDB29B92AF4130BCF412F72EF7B8BD29971D17F5353BFBF0F4D4D7B2FD9EBBD;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = "_encstr_ABFC218DDB29B92AF4130BCF412F72EF7B8BD29971D17F5353BFBF0F4D4D7B2FD9EBBD";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = "_encstr_B15F18C97D90FC1BAF3BAA2221603E6201DB765CDD3089FB28FB";
      level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = % _encstr_9B80206BE0EB96DC332DD8EBD12C73B3BDDC23EB89D7ECAEF2CCFACA3C4B47F5BBDA;
      level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = "_encstr_9B80206BE0EB96DC332DD8EBD12C73B3BDDC23EB89D7ECAEF2CCFACA3C4B47F5BBDA";
      level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = "_encstr_954F174218E47FC519019196CF70DBEA8091CBCAE3D01B7122";
      level.scr_animtree["_encstr_B1FF077B0D77B8B017"] = #animtree;
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = % _encstr_8C0621159981243BB4A052692B1F031FA88FC25FD5D9EF9FE3F3793270ED3BD5D1A705;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = "_encstr_8C0621159981243BB4A052692B1F031FA88FC25FD5D9EF9FE3F3793270ED3BD5D1A705";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = "_encstr_845F182DB5567801C9938B8DC792F4EAD7CC683B5AB711CEE1FA";
      level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = % _encstr_BAD42070DBA763A057A11907C4FEE83C3F0723BE624FACA0A8D4777BE024C0E8F7DA;
      level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = "_encstr_BAD42070DBA763A057A11907C4FEE83C3F0723BE624FACA0A8D4777BE024C0E8F7DA";
      level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = "_encstr_A24F17F78D7CDA24B9B36EB5C960272758233B6F5108B2DFCA";
      level.scr_animtree["_encstr_A6FF0747907B08963F"] = #animtree;
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = % _encstr_99D9216DE1F95CB33C38DAD1A387FB9720074AD75D5167075B5BE1BA8865B34D493F9D;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = "_encstr_99D9216DE1F95CB33C38DAD1A387FB9720074AD75D5167075B5BE1BA8865B34D493F9D";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = "_encstr_B25F18F0580A028D8F14DF7A5C1F2292AFF8B65B93D2E6C6896E";
      level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = % _encstr_851F2012407FE403791BC4FFADA13BAFB7E26FC938A7DF27F25DEFFD43489BF9FF98;
      level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = "_encstr_851F2012407FE403791BC4FFADA13BAFB7E26FC938A7DF27F25DEFFD43489BF9FF98";
      level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = "_encstr_B14F174F35D4728C215B965D51C89FBF204B93C7B9900A47AA";
      level.scr_animtree["_encstr_B2FF07CB61C0A3BF5D"] = #animtree;
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = % _encstr_B84E212AF350A79D38C3747FC138A5D7E0835771D908279328954F419DF8EA2FAF233A;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = "_encstr_B84E212AF350A79D38C3747FC138A5D7E0835771D908279328954F419DF8EA2FAF233A";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = "_encstr_A65F18EA08B52CC3865D0136FCA8E6A29F58E2B3700F69237E64";
      level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = % _encstr_934620D2DF1F2A5DE88C1DF13CD2FD2F77521F5016F14CBBF832A19851DBB331CBF1;
      level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = "_encstr_934620D2DF1F2A5DE88C1DF13CD2FD2F77521F5016F14CBBF832A19851DBB331CBF1";
      level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_8B9E196BB070A732A7D60184D03D6A64FE30FBC7E08827DA5103D3"] = "_encstr_BA4F17DCB0451AFC7E3827138850FFF75F5DE054258F6207AB";
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
      level.scr_animtree["_encstr_ADDB08B139CD68F89667"] = #animtree;
      level.scr_anim["_encstr_ADDB08B139CD68F89667"]["_encstr_AC581AC3885DA7C7937637096081E72D9710CAFBA81B111750BD0237"] = % _encstr_8BE21DC74BCE600B9CE359367CBA05C74503228F07BE4CB2882F20A0C90BD8;
      break;
    case "_encstr_871D0613938567B7":
      level.scr_animtree["_encstr_ADDB08B139CD68F89667"] = #animtree;
      level.scr_anim["_encstr_ADDB08B139CD68F89667"]["_encstr_85441AD463D07F1734F34952CDE447F501CD6A49D53089D7B013933A"] = % _encstr_84091D421B60DFF0F1F485D78B11D529978F32A70AEF5372385F224AFC45DF;
      break;
  }
}

spawntango72(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = var_0.angles;

  if(isDefined(self.path)) {
    var_3 = self.path.origin;
    var_4 = self.path.angles;
  }

  var_5 = spawnVehicle("_encstr_856A27BBF009D8AF6073ACE799680B5969788222385F92779B6EA9DE3870E7DBF750198B38433ED373", "_encstr_AC540D92105BA5B3D95D1C12ED21EF", "_encstr_A7150F8B7858071BA350B7ADE4ED61CDA3", var_3, var_4);
  var_5 setvehicleteam(var_1);
  var_5 vehphys_forcekeyframedmotion();
  var_5.animname = "_encstr_ADDB08B139CD68F89667";
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_6.angles = var_0.angles;
  var_6 setModel("_encstr_8E9121A4EDEBE026DF02C90F756A4907198A58A9AA3E6AAFBE87AFD867F0175810C72C");
  var_6 linkTo(var_5, "_encstr_99FE0B2B19086F6B9DC5D387E1", (0, 0, 0), (0, 0, 0));
  var_5.turret = var_6;
  var_5.turret.animname = "_encstr_82BD0F6BBE86D0588732BFE1C73B1E1834";
  var_5.turret scripts\common\anim::setanimtree();
  self.linktoent = var_5;
  var_5.infil = self;
  var_5 setCanDamage(0);
  return var_5;
}

commander_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players)
  self playsoundtoplayer(var_0, var_4);
}

treadsheavy(var_0) {
  var_1 = var_0.infil.linktoent;
  var_1 setscriptablepartstate("_encstr_A3E10929B2E7B0857FC8AE", "_encstr_B846067B175AA56A");
  var_1 setscriptablepartstate("_encstr_8ECD0A02885967AF4B89550B", "_encstr_930B07BB1B6B3854FF");
}

treadsnormal(var_0) {
  var_1 = var_0.infil.linktoent;
  var_1 setscriptablepartstate("_encstr_A3E10929B2E7B0857FC8AE", "_encstr_820E07FAE8780B3A4C");
  var_1 setscriptablepartstate("_encstr_8ECD0A02885967AF4B89550B", "_encstr_930B07BB1B6B3854FF");
}

treadsneutral(var_0) {
  var_1 = var_0.infil.linktoent;
  var_1 setscriptablepartstate("_encstr_A3E10929B2E7B0857FC8AE", "_encstr_A7A408B9CA5D1D4E2C63");
  var_1 setscriptablepartstate("_encstr_8ECD0A02885967AF4B89550B", "_encstr_A7A408B9CA5D1D4E2C63");

  if(scripts\cp_mp\utility\game_utility::isnightmap())
    var_1 setscriptablepartstate("_encstr_85E50DA0FAF753C089348387282BB0", "_encstr_BA19049F4B2D");
}

cam_shake_crush(var_0) {
  var_1 = var_0.player;
  var_1 scripts\mp\utility\infilexfil::updateshakeonplayer(0.145, 0.16, 2, var_1.origin, 8000, "_encstr_BD9D0CF353BB8D8702EF7030ABE0", 0.05, 0.15);
}

cam_shake_ground(var_0) {
  var_1 = var_0.player;
  var_1 notify("_encstr_BA690F0390EF325749AF754FBEF0773C13");
  var_1 playrumbleonpositionforclient("_encstr_AA9A12B327DBAB73237D07F6EACD23BE6358E646", var_1.origin);
}

crushcar(var_0) {
  if(isDefined(var_0._lastanime) && var_0._lastanime == "_encstr_AC6414280FE6695F0FFAC0D3C5329BB06FAB80082B8F")
    var_0 playSound("_encstr_82241FE686BAE7783ED308584F5C31CD722D48669E931FE10AB7D070676C4905EB");
  else
    var_0 playSound("_encstr_823120E61B73FA96DC994BB1BE1D58739DB7F56CC2C9FA8DC957E6A1AF4EB43BD01D");

  var_0 setscriptablepartstate("_encstr_AF1904AFE326", "_encstr_B69F0663E5A8DAAB", 0);
}

_id_12EF4(var_0) {
  var_0 playsoundonmovingent("_encstr_84BF1640EA455FC8539643C957C331F5EFB2A910735E27AB");
}

_id_12EF5(var_0) {
  var_0 playsoundonmovingent("_encstr_B2BF16309A350F9803A673F98733C125DFE2D940438ED75B");
}

_id_12EF6(var_0) {
  var_0 playsoundonmovingent("_encstr_85BF165B70B5B1C79064392490BBAF85DF78010250077952");
}

_id_12EF7(var_0) {
  var_0 playsoundonmovingent("_encstr_8ABF16EB69BD3FC3B008F0ACF70BF2FB8F97E7251B77E807");
}

_id_12EF8(var_0) {
  var_0 playsoundonmovingent("_encstr_97BF16B93673D7A59B995A8DFA47B09B76BDD7CD8336AF68");
}

_id_12EF9(var_0) {
  var_0 playsoundonmovingent("_encstr_ADBF1620CBE07FE9C5AE201851B35BDAC1300750C8EA9195");
}