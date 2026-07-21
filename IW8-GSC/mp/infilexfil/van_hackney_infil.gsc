/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\infilexfil\van_hackney_infil.gsc
***********************************************/

van_hackney_init(var_0) {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9B8F06A38D72C380", "_encstr_928513BB833F4F0D196BDAC36B58D34FD07B6102E8", ::spawnpersistentvehicle);
  initanims(var_0);
  var_1 = [];
  var_1[0] = [5, 4];
  var_1[1] = [3, 2];
  var_1[2] = [1, 0];
  thread scripts\mp\infilexfil\infilexfil::infil_add("_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2", var_0, 6, 4, var_1, ::van_hackney_spawn, ::van_hackney_get_length, ::player_van_hackney_infil_think);
}

van_hackney_spawn(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _id_12802(var_4, var_0, var_2, var_3);
  var_5 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_4.origin);
  var_5.angles = var_4.angles;
  var_5.scene_node = var_4;
  var_5 thread infilthink(var_0, var_2);
  return var_5;
}

_id_12802(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp_mp\utility\game_utility::getmapname();

  switch (var_4) {
    case "_encstr_82670A6D9FF7A9AAD022B0CA":
      var_0.origin = var_0.origin + anglesToForward(var_0.angles) * -50;
      var_5 = getentarrayinradius("_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C", "_encstr_AC110A7F14873B5B3D073009", (1250, -2150, 75), 300);

      if(isDefined(var_5))
        var_5[0].origin = var_5[0].origin + anglesToForward(var_0.angles) * -50;

      break;
  }
}

van_hackney_get_length(var_0) {
  var_1 = 0.0;

  if(istrue(level.interactiveinfil))
    var_1 = level.interactivecombatduration;
  else
    var_1 = getanimlength(level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_9697133007EE96A962B6D2680FDBFF184683409897" + var_0]);

  return var_1;
}

player_van_hackney_infil_think(var_0, var_1) {
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  thread van_infil_radio_idle(var_0);
  thread player_infil_end();
  var_2 = var_0.linktoent gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3 = var_0.linktoent gettagangles("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("_encstr_AC6B06F0DA2281E1" + var_1, var_2, var_3);
  self setdemeanorviewmodel("_encstr_B418059B8533CA", "_encstr_828D1AD82BC0014C52C7AFD1B7FA85483E85239652C18075292BCBFD");
  self.player_rig.weapon_state_func = scripts\mp\utility\infilexfil::handleweaponstatenotetrack;

  if(var_1 == 0)
    self lerpfovbypreset("_encstr_82300B7081FA4BE6E6D10BB9E8");

  self.player_rig linkTo(var_0.linktoent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_0.linktoent scripts\common\anim::anim_first_frame_solo(self.player_rig, "_encstr_9697133007EE96A962B6D2680FDBFF184683409897" + var_0.subtype);
  thread scripts\mp\infilexfil\infilexfil::infil_scene_fade_in(0.0, 0.55);
  thread player_van_disconnect();
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");

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

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("_encstr_AFE912431636D6E6CACBFA4BB933D2B1D73B169B", 0.1);
    self playlocalsound("_encstr_9740167BB6C87FA519096AF2C0075D2F8230E6E158B6FBAA");
  }

  if(isDefined(self.animname) && isPlayer(self)) {
    var_8 = "_encstr_9B221B3E4E4A48C4988353187780612B24709777DF138260C79989D2EA";

    if(isDefined(var_0.subtype)) {
      if(var_0.subtype == "_encstr_BDBB0616C6C186C2") {
        switch (self.animname) {
          case "_encstr_A2FF07DB605823217A":
            var_8 = "_encstr_8B221B83A652D678C85983187118933B789D80AA2F8C49F05F2A3C36AF";
            break;
          case "_encstr_95FF079B8D7B1DFA4C":
            var_8 = "_encstr_86221BBFAF15E128C039FA71971842EE27153B39AE7BA9381850E9FBCB";
            break;
          case "_encstr_BAFF07CD367B1DD791":
            var_8 = "_encstr_9B221B3E4E4A48C4988353187780612B24709777DF138260C79989D2EA";
            break;
          case "_encstr_B1FF077B0D77B8B017":
            var_8 = "_encstr_9A221BB98D37F54BCD33A58DF5430B8DD637955ED7CE0B73FAE0364EB1";
            break;
          case "_encstr_A6FF0747907B08963F":
            var_8 = "_encstr_A5221BCF51A01133B8617BB5D9EA176667E38B4A09C5C15686C3C953A2";
            break;
          case "_encstr_B2FF07CB61C0A3BF5D":
            var_8 = "_encstr_8D221B237920674450E55954FF080EEFDAB0DA0B4684577D01F1443231";
            break;
          default:
            var_8 = "_encstr_8B221B83A652D678C85983187118933B789D80AA2F8C49F05F2A3C36AF";
            break;
        }
      } else {
        switch (self.animname) {
          case "_encstr_A2FF07DB605823217A":
            var_8 = "_encstr_8B221B83A652D678C85983187118933B789D80AA2F8C49F05F2A3C36AF";
            break;
          case "_encstr_95FF079B8D7B1DFA4C":
            var_8 = "_encstr_86221BBFAF15E128C039FA71971842EE27153B39AE7BA9381850E9FBCB";
            break;
          case "_encstr_BAFF07CD367B1DD791":
            var_8 = "_encstr_9B221B3E4E4A48C4988353187780612B24709777DF138260C79989D2EA";
            break;
          case "_encstr_B1FF077B0D77B8B017":
            var_8 = "_encstr_9A221BB98D37F54BCD33A58DF5430B8DD637955ED7CE0B73FAE0364EB1";
            break;
          case "_encstr_A6FF0747907B08963F":
            var_8 = "_encstr_A5221BCF51A01133B8617BB5D9EA176667E38B4A09C5C15686C3C953A2";
            break;
          case "_encstr_B2FF07CB61C0A3BF5D":
            var_8 = "_encstr_8D221B237920674450E55954FF080EEFDAB0DA0B4684577D01F1443231";
            break;
          default:
            var_8 = "_encstr_8B221B83A652D678C85983187118933B789D80AA2F8C49F05F2A3C36AF";
            break;
        }
      }
    }

    self playlocalsound(var_8);
  }

  self setcinematicmotionoverride("_encstr_921D09D9D9C0090D7275B4");
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 30, 30);
  var_0.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "_encstr_9697133007EE96A962B6D2680FDBFF184683409897" + var_0.subtype, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  thread clear_infil_ambient_zone();

  if(isDefined(self.player_rig) && self.player_rig islinked())
    self.player_rig unlink();

  self visionsetnakedforplayer("_encstr_B40101", 0.75);
  self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
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
  self clearclienttriggeraudiozone(1.0);
  scripts\mp\utility\player::setdof_default();
}

van_infil_radio_idle(var_0) {
  if(isPlayer(self)) {
    self setclienttriggeraudiozone("_encstr_A9AB18A8FECBF098E25F7F1B6BBA53905F9331E0E939104DAB1F", 1);
    var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
    var_1 showonlytoplayer(self);

    if(isDefined(self.team)) {
      var_2 = scripts\mp\utility\teams::getteamvoiceinfix(self.team);
      var_3 = "_encstr_84690847F92EFD1AD01F" + var_2 + "_encstr_A19F1655B72FD2EA70D03FCF9869B19B39461C4E1DD11A12";
    } else
      var_3 = "_encstr_BAD81F70790955381FE60302588397F4CB12C85F7712BA1FD8096A7AC0EBE36043";

    if(soundexists(var_3))
      var_1 playLoopSound(var_3);
    else
      var_1 playLoopSound("_encstr_BAD81F70790955381FE60302588397F4CB12C85F7712BA1FD8096A7AC0EBE36043");

    scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
    wait 4;
    var_1 stoploopsound(var_3);
    var_1 delete();
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

  var_3 = getcommanderassets(var_0);
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("_encstr_8B190AC730E03D42856D3FF2", "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_3.body, var_3.head);
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("_encstr_9AE307B956E345D0AB", "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_3.body, var_3.head);

  foreach(var_5 in self.actors)
  var_5.infil = self;

  self.actors[0].anim_playsound_func = ::commander_play_sound_func;
  self.actors[1].anim_playsound_func = ::driver_play_sound_func;

  if(var_0 == "_encstr_9A8507BA4040188D08")
    self.actors[0] hidepart("_encstr_85590E23373E42E90899B97A70E0277B");
}

blima_chief_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.blima.players)
  var_4 playsoundtoplayer(var_0, var_4);
}

infilthink(var_0, var_1) {
  var_2 = getdvarfloat("_encstr_8EED0A5D8D6D291F8FE9CFF4", 0.2);

  foreach(var_4 in getEntArray("_encstr_AACF0DD2B9CC4B1BFA19AC1BACD12B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"))
  var_4 delete();

  thread vehiclethink(var_0, self.scene_node, var_1);
  thread actorthink(var_0, self.scene_node, var_1);
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  var_6 = getEntArray("_encstr_969F1396E633D263EBF60ECCB7271B567DB3583AAC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_6)
  var_4 hide();

  setDvar("_encstr_A3D50AA2986AA6D30A35D4A5", 1);
  setDvar("_encstr_8EED0A5D8D6D291F8FE9CFF4", 1.0);
  level notify("_encstr_B2600CF8759933D3EE634E77CB7A");
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");

  foreach(var_4 in var_6)
  var_4 show();

  setDvar("_encstr_A3D50AA2986AA6D30A35D4A5", 0);
  setDvar("_encstr_8EED0A5D8D6D291F8FE9CFF4", var_2);
  var_11 = getEntArray("_encstr_8B4B1ECEB0E6EB865836ADB956CBF596B966B4B1EB85D8C18616EB079CB72695", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_12 = getEntArray("_encstr_B41C0AB38573BE83C9DB1395", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_13 = getEntArray("_encstr_927113BCDE623F730ACF7848273669E1EA86BF4E34", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_14 = scripts\engine\utility::array_combine(var_11, var_12, var_13);

  if(isDefined(var_14) && var_14.size > 0) {
    foreach(var_16 in var_14)
    var_16 hide();
  }

  while(isDefined(self.actors))
    waitframe();

  level.stop_station_closed_vo--;
  self delete();
}

vehiclethink(var_0, var_1, var_2, var_3) {
  var_4 = spawnvan(var_1, var_0, var_2);
  scripts\common\anim::anim_first_frame_solo(var_4, "_encstr_9697133007EE96A962B6D2680FDBFF184683409897" + var_2);
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  var_5 = getEnt("_encstr_B64E0B0AB99592B8AFD8AC34F8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_5)) {
    var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
    var_6.angles = var_4.angles;
    var_6 clonebrushmodeltoscriptmodel(var_5);
  }

  var_4 setscriptablepartstate("_encstr_86D00D5048E3DA5929B8B1F772D18F", "_encstr_AB0703DBB9", 0);
  var_4 setscriptablepartstate("_encstr_860E08326A53EF33E891", "_encstr_AB0703DBB9", 0);
  thread van_interior_sfx(var_2);
  scripts\common\anim::anim_single_solo(var_4, "_encstr_9697133007EE96A962B6D2680FDBFF184683409897" + var_2 + "_encstr_9592073E93409903BA");
  scripts\common\anim::anim_single_solo(var_4, "_encstr_9697133007EE96A962B6D2680FDBFF184683409897" + var_2);
  scripts\common\anim::anim_single_solo(var_4, "_encstr_9697133007EE96A962B6D2680FDBFF184683409897" + var_2 + "_encstr_96D206F968DB6F43");
  var_4 setscriptablepartstate("_encstr_86D00D5048E3DA5929B8B1F772D18F", "_encstr_BA19049F4B2D", 0);
  var_4 setscriptablepartstate("_encstr_860E08326A53EF33E891", "_encstr_BA19049F4B2D", 0);
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][self.type][var_2]["_encstr_A5D81207599C375A9B3A9573D195AC0DB41B3695"] = ::spawnpersistentvehicle;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][self.type][var_2]["_encstr_91260B40A2EC2B91B36DA82E47"] = self.linktoent.origin;
  game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][self.type][var_2]["_encstr_AF260B886A249329FB35F7680F"] = self.linktoent.angles;
}

spawnpersistentvehicle(var_0, var_1) {
  var_2 = game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_91260B40A2EC2B91B36DA82E47"];
  var_3 = game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"][var_0][var_1]["_encstr_AF260B886A249329FB35F7680F"];
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_4.angles = var_3;
  var_5 = "_encstr_86DC213BACD083FA36D2D9AFB1DC32D783C2D8CCB0D7E44323F5BBB28EEBD2CD66A5B1";

  if(scripts\cp_mp\utility\game_utility::getmapname() == "_encstr_AB5D0960CBB77E40E7D955" || scripts\cp_mp\utility\game_utility::getmapname() == "_encstr_8E940C29F87032C3FF82F50F725A" || scripts\cp_mp\utility\game_utility::getmapname() == "_encstr_82670A6D9FF7A9AAD022B0CA")
    var_5 = "_encstr_B6751D6C3DFB5ADFBEFAC0814215514E73A1F9EC917F5BF927A120F0FAEC09";

  var_4 setModel(var_5);
  var_4.animname = "_encstr_911904464232";
  var_4 scripts\common\anim::setanimtree();
  var_6 = getEnt("_encstr_B64E0B0AB99592B8AFD8AC34F8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_6)) {
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
    var_7.angles = var_3;
    var_7 clonebrushmodeltoscriptmodel(var_6);
  }
}

van_interior_sfx(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.linktoent.origin);
  var_1 linkTo(self.linktoent, "_encstr_A32F13D3C34C099C88ED7A0999C0A30208411FE381");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.linktoent.origin);
  var_2 linkTo(self.linktoent, "_encstr_994D096B20E7F183F0A074");
  wait 0.1;
  var_1 playsoundonmovingent("_encstr_8FC51FBB0FB81977E011722A1ECB8FCE78ED2529DFC0DE23AFE83AB3E61ED706E8");
  var_2 playsoundonmovingent("_encstr_AF0420C8DF3EA69BA2A78319F19AD3699353F0CBC7DEB95D990C081DD9923D50CE53");
  wait 7.75;
  var_1 playsoundonmovingent("_encstr_AB722043F735798C6E23AB914774C8531273E203E1ED2AD6912B7D207B873D57ED06");
  wait 8;
  var_1 playsoundonmovingent("_encstr_ADF121908766EED31A6F5BD109520BD1DB1BB8480F1661E5D11740685A5957F837F730");
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  var_2 delete();
  var_1 delete();
}

van_infil_sfx_npc1(var_0) {
  var_0 playsoundonmovingent("_encstr_8FCE1BCDB1CDF5B4B999A536D734C28DADE656F2D7EC1673FA371CD833");
}

van_infil_sfx_npc2(var_0) {
  var_0 playsoundonmovingent("_encstr_91CE1BB346CDF9DA733419900F719ADEBC70610B47D3162EB9759AAF72");
}

van_infil_sfx_npc3(var_0) {
  var_0 playsoundonmovingent("_encstr_ACCE1B9B1BE6AF2D9B332DC6F5430B8DD6E6B25EAF3B2C9BAF37C1C689");
}

van_infil_sfx_npc4(var_0) {
  var_0 playsoundonmovingent("_encstr_A1CE1BDCC6E67D2D37CC4B36FA0DB0B1B6CD59F2FA3BC237BE371CB1D8");
}

van_infil_sfx_npc5(var_0) {
  var_0 playsoundonmovingent("_encstr_93CE1BFF7B8DE9BBB362D078194367D064DE6B63DFF350704FFA0B8187");
}

van_infil_sfx_npc6(var_0) {
  var_0 playsoundonmovingent("_encstr_A3CE1BF720F01FD2957C0C45C8A16AEBF8D02727292B99EA9F3752BE65");
}

_id_140E5(var_0) {
  var_0 playsoundonmovingent("_encstr_95EF206EC9638F78BDB5CB29A8D027012F6850E7E1B3E290DECF278D2046A047F553");
}

actorthink(var_0, var_1, var_2, var_3) {
  thread spawnactors(var_0, var_2, var_3);
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "_encstr_9697133007EE96A962B6D2680FDBFF184683409897" + var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  scripts\mp\flags::gameflagwait("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "_encstr_9697133007EE96A962B6D2680FDBFF184683409897" + var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["_encstr_9697133007EE96A962B6D2680FDBFF184683409897" + var_2]);
  var_4 = getanimlength(level.scr_anim["_encstr_8B190AC730E03D42856D3FF2"]["_encstr_9697133007EE96A962B6D2680FDBFF184683409897" + var_2]);
  wait(var_4);

  foreach(var_6 in self.actors)
  var_6 delete();

  self.actors = undefined;
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
  script_model_alpha_anims();
  vehicles_alpha_anims();
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_878109A44DF32F4BBBFFEA", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_B2590EDC1A58DAAC7D39AE379B5AE676", scripts\mp\utility\infilexfil::cam_shake_running, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A3ED0A5D8F9B973297507B62", scripts\mp\utility\infilexfil::player_equip_nvg, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_8E250DDC1AC25BCAAF071693AD9532", scripts\mp\utility\infilexfil::cam_shake_parked, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_8E250DDC1AC25BCAAF071693AD9532", scripts\mp\utility\infilexfil::cam_shake_parked, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_8E250DDC1AC25BCAAF071693AD9532", scripts\mp\utility\infilexfil::cam_shake_parked, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_8E250DDC1AC25BCAAF071693AD9532", scripts\mp\utility\infilexfil::cam_shake_parked, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_8E250DDC1AC25BCAAF071693AD9532", scripts\mp\utility\infilexfil::cam_shake_parked, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_8E250DDC1AC25BCAAF071693AD9532", scripts\mp\utility\infilexfil::cam_shake_parked, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_87940AB943C2AD95BE7BCCCC", ::customground, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A91A0A0DB2E79018035A48F0", scripts\mp\utility\infilexfil::player_free_look, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_9A06139D0BCDFA96E633B48DFADC991EEBDC1C8D62", ::van_infil_sfx_npc1);
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_AF0613FB6E56C18BA2D383811F5B4440CF05A3D142", ::van_infil_sfx_npc2);
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_8D0613CE85B9EB2DE6CCB436FACDCC3CFAE61C36CC", ::van_infil_sfx_npc3);
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A206138CD90356135DAA98B81132350A6F4E178E64", ::van_infil_sfx_npc4);
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_B106130B274569C96898170B39A3BE634FC812C6B5", ::van_infil_sfx_npc5);
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_BA061313A1F8D71248B5D7DBDFEE2A38C9E80ADE33", ::van_infil_sfx_npc6);
  scripts\common\anim::addnotetrack_customfunction("_encstr_A2FF07DB605823217A", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_95FF079B8D7B1DFA4C", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_BAFF07CD367B1DD791", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B1FF077B0D77B8B017", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_A6FF0747907B08963F", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
  scripts\common\anim::addnotetrack_customfunction("_encstr_B2FF07CB61C0A3BF5D", "_encstr_A97E1A48D9082743D3486527CB7A9EEB7D0824B65A97E38D69107802", scripts\mp\utility\infilexfil::player_lock_look_1_second, "_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB");
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

script_model_alpha_anims() {
  level.scr_animtree["_encstr_9AE307B956E345D0AB"] = #animtree;
  level.scr_anim["_encstr_9AE307B956E345D0AB"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = % _encstr_881F199BB54AFBA87FA79038BF8A812B215B079041C295703EA788;
  level.scr_animname["_encstr_9AE307B956E345D0AB"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = "_encstr_881F199BB54AFBA87FA79038BF8A812B215B079041C295703EA788";
  level.scr_animtree["_encstr_8B190AC730E03D42856D3FF2"] = #animtree;
  level.scr_anim["_encstr_8B190AC730E03D42856D3FF2"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = % _encstr_977F18B4CDCCB463BEF6C133F693D8B27DD9589BEBD8434BCA99;
  level.scr_animname["_encstr_8B190AC730E03D42856D3FF2"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = "_encstr_977F18B4CDCCB463BEF6C133F693D8B27DD9589BEBD8434BCA99";
  scripts\common\anim::addnotetrack_customfunction("_encstr_8B190AC730E03D42856D3FF2", "_encstr_AD3920FB01F3AF8CA82D819C4740569792F812C38E4C0F05490F8F95CB20DDF3CDD3", ::_id_140E5);
  level.scr_animtree["_encstr_911904464232"] = #animtree;

  switch (getDvar("_encstr_9570084B1793A090CDFF")) {
    case "_encstr_AB5D0960CBB77E40E7D955":
      level.scr_anim["_encstr_911904464232"]["_encstr_92311E938B70B1283059F4BDB1D8576AD82D77730F2F4A082061E144C848A242"] = % _encstr_8F481DB01B87F80DAA9C891833B24566F6E720A9E75E93ED02097E97CF6A85;
      level.scr_animname["_encstr_911904464232"]["_encstr_92311E938B70B1283059F4BDB1D8576AD82D77730F2F4A082061E144C848A242"] = "_encstr_8F481DB01B87F80DAA9C891833B24566F6E720A9E75E93ED02097E97CF6A85";
      break;
    case "_encstr_82670A6D9FF7A9AAD022B0CA":
      level.scr_anim["_encstr_911904464232"]["_encstr_92311E938B70B1283059F4BDB1D8576AD82D77730F2F4A082061E144C848A242"] = % _encstr_B60E2C78CD3E106991D791B53FAB2688EF23E110396818968AEBA373E7E2F8486DBAAEABDEC6315913B7854B7F5A;
      level.scr_animname["_encstr_911904464232"]["_encstr_92311E938B70B1283059F4BDB1D8576AD82D77730F2F4A082061E144C848A242"] = "_encstr_B60E2C78CD3E106991D791B53FAB2688EF23E110396818968AEBA373E7E2F8486DBAAEABDEC6315913B7854B7F5A";
      break;
    default:
      level.scr_anim["_encstr_911904464232"]["_encstr_92311E938B70B1283059F4BDB1D8576AD82D77730F2F4A082061E144C848A242"] = % _encstr_953A2460408C3939EE3FE3C03543885956AB769E36BA020FC895CB0BB91D82FBF175275C835D;
      level.scr_animname["_encstr_911904464232"]["_encstr_92311E938B70B1283059F4BDB1D8576AD82D77730F2F4A082061E144C848A242"] = "_encstr_953A2460408C3939EE3FE3C03543885956AB769E36BA020FC895CB0BB91D82FBF175275C835D";
      break;
  }

  level.scr_anim["_encstr_911904464232"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = % _encstr_994416F06D6D9039E908582D30303EE5011D2090AF93777A;
  level.scr_animname["_encstr_911904464232"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = "_encstr_994416F06D6D9039E908582D30303EE5011D2090AF93777A";
  level.scr_anim["_encstr_911904464232"]["_encstr_AD8B1DBE9A2061D82FC75A48B373098965ACB8C399CBF4D7C4074F5D6BA3D5"] = % _encstr_AA06232D37335AD8AF7B0E66F6C98DACF53B5837FA34C2C6D6E6562FBE593C5A8EEB3BC2DC;
  level.scr_animname["_encstr_911904464232"]["_encstr_AD8B1DBE9A2061D82FC75A48B373098965ACB8C399CBF4D7C4074F5D6BA3D5"] = "_encstr_AA06232D37335AD8AF7B0E66F6C98DACF53B5837FA34C2C6D6E6562FBE593C5A8EEB3BC2DC";
  level.scr_animtree["_encstr_A2FF07DB605823217A"] = #animtree;
  level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = % _encstr_8F4F144BE6CCD2D8F5DB0E997B9C6C59BE9D2CCDAF89;
  level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = "_encstr_8F4F144BE6CCD2D8F5DB0E997B9C6C59BE9D2CCDAF89";
  level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = "_encstr_BD421AB4E6CCA58DBE67C2737D1A85B1B69BB22F7DB0B1C1A185AFC4";
  level.scr_animtree["_encstr_95FF079B8D7B1DFA4C"] = #animtree;
  level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = % _encstr_914F14021EB3735597FFCBE3186B3BFA775087B34666;
  level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = "_encstr_914F14021EB3735597FFCBE3186B3BFA775087B34666";
  level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = "_encstr_BE421A397881EF5DFF8822CAD9C9568F98D0BDB118892362B958C907";
  level.scr_animtree["_encstr_BAFF07CD367B1DD791"] = #animtree;
  level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = % _encstr_AC4F144A10EC47FD112F8866D780C6BF988B42829E1E;
  level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = "_encstr_AC4F144A10EC47FD112F8866D780C6BF988B42829E1E";
  level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = "_encstr_92421AF34E8750216F6B2930014B6FC81CD6636BD72E63779B32E693";
  level.scr_animtree["_encstr_B1FF077B0D77B8B017"] = #animtree;
  level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = % _encstr_B84F146A30CCA71DF1CF6846F7A0E6DFF8AB62627EBD;
  level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = "_encstr_B84F146A30CCA71DF1CF6846F7A0E6DFF8AB62627EBD";
  level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = "_encstr_88421A43FE17C0B1FF1B59A091FBFF58EC46D3FBA7BEB0870B8296E3";
  level.scr_animtree["_encstr_A6FF0747907B08963F"] = #animtree;
  level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = % _encstr_8E4F14A988711FAD0FD0A3FAE86DA6E78E6C295688B3;
  level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = "_encstr_8E4F14A988711FAD0FD0A3FAE86DA6E78E6C295688B3";
  level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = "_encstr_81421A290D4D503009EBEBDB41A861EA6A3D3D5B0FC29CCB210F4F93";
  level.scr_animtree["_encstr_B2FF07CB61C0A3BF5D"] = #animtree;
  level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = % _encstr_BE4F14CA0509BB05DF387F75EF92F2493033E3B039F6;
  level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = "_encstr_BE4F14CA0509BB05DF387F75EF92F2493033E3B039F6";
  level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_883918D37930CEF05B2FF026E3AB3E846022C1F3EFCA34ABD8BB"] = "_encstr_87421A2C8223E0A8368312DA813896683295CF43FF403CC3A3877F6A";
}

vehicles_alpha_anims() {}

spawnvan(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_3.angles = var_0.angles;
  var_4 = "_encstr_86DC213BACD083FA36D2D9AFB1DC32D783C2D8CCB0D7E44323F5BBB28EEBD2CD66A5B1";

  if(scripts\cp_mp\utility\game_utility::getmapname() == "_encstr_AB5D0960CBB77E40E7D955" || scripts\cp_mp\utility\game_utility::getmapname() == "_encstr_8E940C29F87032C3FF82F50F725A")
    var_4 = "_encstr_B6751D6C3DFB5ADFBEFAC0814215514E73A1F9EC917F5BF927A120F0FAEC09";

  var_3 setModel(var_4);
  var_3.animname = "_encstr_911904464232";
  var_3 scripts\common\anim::setanimtree();
  var_3 setCanDamage(0);
  self.linktoent = var_3;
  var_3.infil = self;
  var_5 = getEntArray("_encstr_8B4B1ECEB0E6EB865836ADB956CBF596B966B4B1EB85D8C18616EB079CB72695", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = getEntArray("_encstr_B41C0AB38573BE83C9DB1395", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_7 = getEntArray("_encstr_927113BCDE623F730ACF7848273669E1EA86BF4E34", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_8 = scripts\engine\utility::array_combine(var_5, var_6, var_7);
  var_9 = undefined;

  foreach(var_11 in var_8) {
    if(isDefined(var_11._id_140E3)) {
      continue;
    }
    var_9 = var_11;
    break;
  }

  if(isDefined(var_9)) {
    var_3.probe = var_9;
    var_9._id_140E3 = var_3;
    var_3.probe.origin = var_3.origin;
    var_3.probe linkTo(var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (-42, 0, 56.5), (0, 0, 0));

    switch (level.mapname) {
      case "_encstr_AB5D0960CBB77E40E7D955":
      case "_encstr_B4870E0751AFABC1B8F1CE97A8181CF3":
      case "_encstr_86570E71DA311191DB1FD8887FCFA9A3":
      case "_encstr_82670A6D9FF7A9AAD022B0CA":
      case "_encstr_8E940C29F87032C3FF82F50F725A":
      case "_encstr_994B10FAA8973CA771A27E6D431E0F8635E0":
        var_3.probe hide();
        break;
    }
  }

  return var_3;
}

commander_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players)
  self playsoundtoplayer(var_0, var_4);
}

driver_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.infil.players)
  self playsoundtoplayer(var_0, var_4);
}

getcommanderassets(var_0) {
  var_1 = spawnStruct();

  if(var_0 == "_encstr_8E8405EA382B2A") {
    var_1.body = "_encstr_A1FF2A137B232FAFB5387DB2859B8E2B9C37FA999627CAD12BC26BEB561637477D9BECF5377BEBDCD896B976";
    var_1.head = "_encstr_83B02360371150D8AA43375B1F939590BA4D0E395C6A2B0502EF5B2727DA5EA07F66139693";
  } else {
    var_1.body = "_encstr_BEBE2621B514B8D8AA43377F0F939590BA4D0E395C6A2B0502EF5B276F9A5EA07FE2F09149F1199F";
    var_1.head = "_encstr_81192660AF6F53472F4FFE4B51BB53739682AE154B8B9D2BFDC3979640B2607B3F26BBE137D50712";
  }

  return var_1;
}

customground(var_0) {
  scripts\mp\utility\infilexfil::cam_shake_off(var_0);

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.player))
    var_1 = var_0.player;
  else
    var_1 = var_0;
}