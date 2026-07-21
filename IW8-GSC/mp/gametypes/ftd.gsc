/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\ftd.gsc
***********************************************/

init() {
  level._effect["_encstr_85DC17E349BBF71693FFFFDC7BD89F1368A3BBF97399FF8C40"] = loadfx("_encstr_9BB5324384B387525BF119A8B3D699886DE7F2C9664756E99382C947781FB5CF18BF93F33A078BA8819F33355B84F7CBF007ABF2");
  var_0 = getdvarint("_encstr_BE440F23FE0337DFA988C17A50DB96B359", 0);

  if(var_0) {
    teammarkedfor();
    var_1 = 1;
    thread _id_13245(var_1);
  } else
    move_platform(1);
}

teammarkedfor() {
  scripts\engine\scriptable::_id_12F5B("_encstr_AA030A585FAA5B6F8A1D088E", ::petrograd_interaction_think);
  throwing_knife_cp_trytopickup();
  level.petobjectivefilter = [];
}

_id_13245(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = getentitylessscriptablearrayinradius("_encstr_BDCC1FB98DE4D20E1D16133659FA3193FA3385CD47FA1D3985ECCAC6EB197BBD4E", "_encstr_AC110A7F14873B5B3D073009");
  var_2 = getentitylessscriptablearrayinradius("_encstr_8D6920E66CE4D2838E85898DB27D8993BE662C6E3AF5E89C0B9D5963D7634B76343A", "_encstr_AC110A7F14873B5B3D073009");
  var_3 = scripts\engine\utility::getStructArray("_encstr_A1C622E251A8513315EBABABDBA8DA8219199E6A2B69F44BE7ADBFA3476FE3DAC0A31635", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_4 = getEntArray("_encstr_9B760CABD914D95CB030CFD7A968", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_5 = 0;

  foreach(var_7 in var_1) {
    var_8 = var_7.script_noteworthy;

    if(isDefined(var_8)) {
      var_9 = [];

      foreach(var_11 in var_2) {
        if(var_11.script_noteworthy == var_8)
          var_9 = scripts\engine\utility::array_add(var_9, var_11);
      }

      foreach(var_14 in var_3) {
        if(var_14.targetname == var_8) {
          foreach(var_16 in var_4) {
            if(var_16.targetname == var_8) {
              throwingknife_fire_begin_fx(var_7, var_9, var_14, var_16);
              var_5++;
              break;
            }
          }
        }
      }
    }
  }

  if(var_5 != var_1.size) {}

  if(var_5 > 0) {
    if(var_0)
      level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

    thread _id_12126();
    thread atv_initcollision();

    foreach(var_7 in level.petobjectivefilter)
    attackerinitammo(var_7);
  }
}

throwingknife_fire_begin_fx(var_0, var_1, var_2, var_3) {
  var_0.usable = 1;
  var_0._id_13AEB = randomint(4);
  var_0._encstr_8695106ECBC23963BB73F0880BD4185B4B73 = var_1;
  var_0.destination = var_2;
  var_0.ph = var_3;
  var_0.ph._id_121D7 = var_0;
  scripts\mp\utility\trigger::makeenterexittrigger(var_0.ph, ::petrograd_interaction_delayed, undefined);
  level.petobjectivefilter[level.petobjectivefilter.size] = var_0;
}

petrograd_interaction_think(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_AA030A585FAA5B6F8A1D088E" && _encstr_85E617405BFBD018C22B97AD292A88AF9BC25989127F16B09F(var_2)) {
    if(istrue(var_0.usable) && !istrue(var_0.cankeepusingbomb))
      var_0 thread _id_12125(var_3);
  }
}

_encstr_A913149778F05372E198EDA2FE977B017B20172BD069() {
  var_0 = "_encstr_A2E6081AA098FF6F18FF" + self.script_noteworthy;
  self setscriptablepartstate("_encstr_AA030A585FAA5B6F8A1D088E", var_0);
}

_encstr_85E617405BFBD018C22B97AD292A88AF9BC25989127F16B09F(var_0) {
  if(var_0 == "_encstr_8882099673858D1D4B6756" || var_0 == "_encstr_ADB405071B8AE8" || var_0 == "_encstr_921D09D9D9C0090D7275B4")
    return 0;
  else
    return 1;
}

attackerinitammo(var_0) {
  var_0 _encstr_A913149778F05372E198EDA2FE977B017B20172BD069();
  var_0 _id_13145("_encstr_8882099673858D1D4B6756");
  var_0.cankeepusingbomb = 0;
  var_0 thread _id_11D04();
}

_id_12125(var_0) {
  var_1 = self;
  var_2 = var_0.origin - var_1.origin;

  if(vectordot(var_2, anglesToForward(var_1.angles)) <= 0) {
    return;
  }
  if(istrue(var_1.cankeepusingbomb)) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_91C90A998E32EB1B8DDEDCB2");
  var_1._id_1269A = [];
  var_1 setscriptablepartstate("_encstr_AA030A585FAA5B6F8A1D088E", "_encstr_ADB405071B8AE8");
  var_1 notify("_encstr_B85C0999A319EBBDC1AC73");
  var_1 thread _id_13C4E();
  var_1 thread petrograd_lead_model();
}

petrograd_interaction_delayed(var_0, var_1) {
  var_2 = var_1._id_121D7;

  if(var_0 isinexecutionvictim() || var_0 isinexecutionattack()) {
    return;
  }
  var_0 thread _id_1386A(var_0 registerdonetsksubmap(var_2, 0), var_2, "_encstr_91131CB50EEB77F47D8DA1CCD7AD2DE6B2DCF5660B3747AFE89C2C3BAC36");
}

_encstr_B1040E176168BBC30D7F632F4920ABF3() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(var_2 isspectatingplayer()) {
      if(self == var_2 getspectatingplayer())
        var_0 = scripts\engine\utility::array_add(var_0, var_2);
    }
  }

  return var_0;
}

_id_1386A(var_0, var_1, var_2) {
  var_3 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 endon("_encstr_AD75063D571AE108");
  var_3 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_3 thread _id_126D0(var_1);
  var_4 = _encstr_B1040E176168BBC30D7F632F4920ABF3();

  foreach(var_6 in var_4) {
    var_6 _id_12853(var_2);
    var_6 _id_1277C(var_2);
  }

  var_3 _id_12853(var_2);
  var_3 _id_1277C(var_2);
  var_3 setsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 0.5);
  wait 0.1;
  var_1 battle_tracks_updateexternallisteningzone(var_3);
  var_3 setOrigin(var_0);
  var_8 = var_1.angles;
  var_9 = (0, (var_8[1] + 180) % 360, 0);
  var_3 setplayerangles(var_9);
  wait 4.0;
  var_3._id_12A49 = 1;
}

_id_13C4E() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_91C90A998E32EB1B8DDEDCB2");
  var_0._id_13B81 = gettime();
  var_0._id_13B7C = undefined;

  for(;;) {
    if(isDefined(var_0._id_13B7C) && (gettime() - var_0._id_13B7C) / 1000 >= getdvarint("_encstr_8A4C18DC1B27D74CC9F5CCA332AF92E60BB13AD2CECA15D2DAB2", 10)) {
      var_0 thread heli_land_logic(0);
      return;
    }

    if((gettime() - var_0._id_13B81) / 1000 >= getdvarint("_encstr_916E17FB4F18591BAE76C2EB3910FF8E206F7075FD911CEFDD", 20)) {
      var_0 thread heli_land_logic(0);
      return;
    }

    wait 1;
  }
}

petrograd_lead_model() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_979B0EDD6598695BFD4121CB4B5D2F5F");

  if(!isDefined(var_0.petrograd_interactions_init))
    var_0.petrograd_interactions_init = [];

  for(;;) {
    waitframe();

    if(!isDefined(var_0.petrograd_interactions_init) || var_0.petrograd_interactions_init.size <= 0) {
      var_0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
      continue;
    }

    var_0.tv_station_fastrope_one_infil_rider_start_targetname = 1;
    var_1 = var_0.petrograd_interactions_init[0];

    if(!isDefined(var_1) || !isalive(var_1)) {
      var_0.petrograd_interactions_init = var_0 _id_12C1A(var_1);
      var_0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
      var_1 notify("_encstr_B4CB1A4D53C23F20F5CB314EB3CAC8F48A5B47CFA7FA07300D633921");
      continue;
    }

    var_1 thread play_vo_or_timeout(var_0, var_1 registerdonetsksubmap(var_0, 1));
    var_1 scripts\engine\utility::_id_143A5("_encstr_8B5B141C1BB0CBACE4FAC8BD9BCAEBEE85E438B49B9D", "_encstr_AD75063D571AE108");
    var_0.petrograd_interactions_init = var_0 _id_12C1A(var_1);
    var_0.tv_station_fastrope_one_infil_rider_start_targetname = 0;
    var_1 notify("_encstr_B4CB1A4D53C23F20F5CB314EB3CAC8F48A5B47CFA7FA07300D633921");
  }
}

battle_tracks_updateexternallisteningzone(var_0) {
  var_1 = self;

  if(!isDefined(var_0) || !isPlayer(var_0)) {
    return;
  }
  if(!isDefined(var_1.petrograd_interactions_init))
    var_1.petrograd_interactions_init = [];

  if(scripts\engine\utility::array_contains(var_1.petrograd_interactions_init, var_0)) {
    return;
  }
  var_1._id_13B7C = gettime();
  var_1.petrograd_interactions_init[var_1.petrograd_interactions_init.size] = var_0;
}

_id_12C1A(var_0) {
  var_1 = self;
  var_2 = scripts\engine\utility::array_remove(var_1.petrograd_interactions_init, var_0);
  return var_2;
}

_id_12853(var_0) {
  var_1 = self;
  var_1 skydive_cutparachuteon(var_0);
  var_1 setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 10);
}

_id_1277C(var_0) {
  var_1 = self;
  var_1 preloadcinematicforplayer(var_0);
}

_id_138F8() {
  var_0 = self;
  var_0 setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 5);
  wait 0.5;
  var_0 setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 0);
  var_0 skydive_cutparachuteoff();
}

_id_126D0(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 playerhide();
  var_1 freezecontrols(1);
  var_1 vehiclepinonminimap(1);
  var_1.validateboltent = 1;

  if(isDefined(var_0))
    var_0._id_1269A[var_1.guid] = var_1;

  var_2 = 8.5;
  var_3 = scripts\engine\utility::_id_143BD(var_2, "_encstr_8B5B141C1BB0CBACE4FAC8BD9BCAEBEE85E438B49B9D", "_encstr_878B0D2B0D55328178B9D41111C0CC", "_encstr_B4CB1A4D53C23F20F5CB314EB3CAC8F48A5B47CFA7FA07300D633921", "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_0)) {
    if(var_3 == "_encstr_8D820B49520F0EC02DDE6367EC") {
      var_0._id_1269A = scripts\engine\utility::array_removeundefined(var_0._id_1269A);
      return;
    } else
      var_0._id_1269A = scripts\engine\utility::array_remove(var_0._id_1269A, var_1);
  }

  var_1 vehiclepinonminimap(0);
  var_1 freezecontrols(0);
  var_1 playershow();
  var_1.validateboltent = undefined;
  var_1 clearsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 2);
  var_1 thread atv_outline();
}

atv_outline() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_0._id_129C7 = gettime();
  var_0.team = self.team;
  var_0 makeportableradar(self);
  level.disable_super_in_turret._id_129C6[var_0 getentitynumber()] = var_0;
  wait 3;
  var_0 delete();
}

play_vo_or_timeout(var_0, var_1) {
  var_2 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 endon("_encstr_AD75063D571AE108");
  var_2 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(!istrue(var_2._id_12A49))
    waitframe();

  var_2._id_12A49 = 0;
  var_3 = 7.5;
  var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_1, var_3);
  var_2 waittill("_encstr_87A218DB78315972CD07AA67FEB97B0D59E89F1FD8CBB4BAE9A5");
  wait 0.45;
  var_1 = var_1 + (0, 0, 20);
  var_2 setOrigin(var_1);
  playFX(scripts\engine\utility::getfx("_encstr_85DC17E349BBF71693FFFFDC7BD89F1368A3BBF97399FF8C40"), var_2.origin);
  var_2 playsoundtoplayer("_encstr_97581C93DB4B1763B588825B9C12E0759BA92F1E171FD1E03B5B3DA8665D", var_2);
  var_4 = var_0.angles;
  var_5 = (0, (var_4[1] + 180) % 360, 0);
  var_2 setplayerangles(var_5);
  waitframe();
  var_2 clearsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 2);
  var_2 _id_138F8();
  var_6 = _encstr_B1040E176168BBC30D7F632F4920ABF3();

  foreach(var_8 in var_6)
  var_8 _id_138F8();

  var_2 notify("_encstr_8B5B141C1BB0CBACE4FAC8BD9BCAEBEE85E438B49B9D");
}

registerdonetsksubmap(var_0, var_1) {
  var_2 = self;
  var_3 = var_0.destination.origin;

  if(var_1) {
    var_4 = var_0._id_13AEB;
    var_0._id_13AEB = (var_0._id_13AEB + 1) % 4;
    var_5 = getdvarint("_encstr_AA7B194E7782570B0B81891DD1AFF0CBAB303E7A334547EFFA60AB", 50);

    for(var_6 = 0; var_6 < level.petplundertimer.size; var_6++) {
      var_7 = (var_4 + var_6) % 4;
      var_8 = var_3 + level.petplundertimer[var_7] * var_5;

      if(capsuletracepassed(var_8, 16, 32, var_2))
        return var_8;

      var_9 = 10;

      for(var_10 = 0; var_10 < var_9; var_10++) {
        var_11 = anglesToForward((0, 360 * var_10 / var_9, 0)) * 3 * 16;
        var_12 = var_8 + var_11;

        if(capsuletracepassed(var_12, 16, 32, var_2))
          return var_12;
      }
    }
  }

  return var_3;
}

heli_land_logic(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_B85C0999A319EBBDC1AC73");
  var_2 = var_1 getscriptablepartstate("_encstr_AA030A585FAA5B6F8A1D088E");

  if(var_2 != "_encstr_8882099673858D1D4B6756") {
    if(istrue(var_0))
      var_1 setscriptablepartstate("_encstr_AA030A585FAA5B6F8A1D088E", "_encstr_921D09D9D9C0090D7275B4");
    else
      var_1 _encstr_A913149778F05372E198EDA2FE977B017B20172BD069();
  }

  if(isDefined(var_1._id_1269A)) {
    var_1.usable = 0;

    while(var_1._id_1269A.size != 0)
      wait 0.1;

    var_1.usable = 1;
  }

  var_1 notify("_encstr_91C90A998E32EB1B8DDEDCB2");
  var_1 thread _id_13385();
}

_id_13385() {
  var_0 = self;

  if(!isDefined(var_0.petrograd_interactions_init)) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1.0;

  while(istrue(var_0.tv_station_fastrope_one_infil_rider_start_targetname))
    waitframe();

  var_0 notify("_encstr_979B0EDD6598695BFD4121CB4B5D2F5F");
  var_0.petrograd_interactions_init = undefined;
}

_encstr_A373229637837B96CD3ADEAB1D374B91CA8CA5E6073685F2AC463716CCAC362DE41BB159(var_0) {
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
  var_2 = float(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius());

  if(!isDefined(var_1) || !isDefined(var_2) || var_2 <= 0)
    return 0;

  var_3 = distance2dsquared(var_0, var_1);

  if(var_3 >= var_2 * var_2)
    return 1;

  return 0;
}

unblockclasschange() {
  var_0 = self;
  var_1 = getdvarint("_encstr_B6A7249BC627D7C4C9BECC1D32D7A22DD6B2AACDA3B436289339D2D9B01B52E68816DC9D95C9", 75);
  var_2 = 0;

  if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius() > 0) {
    var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::updateprestreamrespawn(var_0.origin) == 0;

    if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getmintimetillpointindangercircle(var_0.origin) < var_1)
      var_2 = 1;
  }

  return var_2;
}

throwing_knife_cp_trytopickup() {
  level.petplundertimer = [];
  var_0 = (1, 0, 0);
  var_1 = 90.0;

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_0 = rotatevector(var_0, (0, var_1, 0));
    level.petplundertimer[level.petplundertimer.size] = var_0;
  }
}

_id_11D04() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self;
  var_1 = var_0.destination;

  for(;;) {
    var_2 = getdvarint("_encstr_99131FDE0F1BD8229D802F60195FEFFB43EB860F70EBD23087AD43E2D8435C27D2", 500);
    var_3 = getdvarint("_encstr_A9862858F25A77811B87ECDD9487ADE102EA40D0CAF34B1D2FAE645D7A6B11912CC32849E34BFB1317CC", 250000);

    if(!istrue(var_0.cankeepusingbomb) && var_1 unblockclasschange() == 1) {
      var_0.cankeepusingbomb = 1;
      var_0 thread heli_land_logic(1);
      var_0 _id_13145("_encstr_8882099673858D1D4B6756");
    } else if(istrue(var_0.cankeepusingbomb) && var_1 unblockclasschange() == 0) {
      var_0.cankeepusingbomb = 0;
      var_0 _encstr_A913149778F05372E198EDA2FE977B017B20172BD069();
    }

    if(!istrue(var_0.cankeepusingbomb)) {
      var_4 = getdvarint("_encstr_ABC821376C9CFA26E4BE33D191D70A39C9D2D9588D11C237B3AC4E8896CD3A58CD36AC", 220);
      var_5 = var_1.origin;
      var_6 = 0;

      foreach(var_8 in level.mines) {
        if(isDefined(var_8) && distancesquared(var_5, var_8.origin) <= var_3) {
          var_6 = 1;
          break;
        }
      }

      if(var_6 == 0) {
        var_10 = scripts\mp\utility\player::getplayersinradius(var_5, var_2);

        foreach(var_12 in var_10) {
          if(abs(var_12.origin[2] - var_5[2]) < 200) {
            var_6 = 1;
            break;
          }
        }
      }

      if(var_6 || _encstr_8D1418F08BA21FE873A463E89B5771C3CEB29088E23CA18D37CA(var_1.origin))
        var_14 = "_encstr_AFAD09350190C9E32B7507";
      else if(_encstr_A373229637837B96CD3ADEAB1D374B91CA8CA5E6073685F2AC463716CCAC362DE41BB159(var_1.origin))
        var_14 = "_encstr_990A08985BAA40FB15E4";
      else
        var_14 = "_encstr_AC260979F74AD8B52FE3D1";

      var_0 _id_13145(var_14);
    }

    wait 1.0;
  }
}

_encstr_8D1418F08BA21FE873A463E89B5771C3CEB29088E23CA18D37CA(var_0) {
  if(isDefined(level.gulagloadoutindex) && isDefined(level.gulagloadoutindex.instances)) {
    foreach(var_2 in level.gulagloadoutindex.instances) {
      if(_getlocationscircleinfluencedwithnoise::_encstr_BEED1FFB4B38C00F132072EA8B607F3A70DF794ED908CDFBCF38BAB271CAAFB560(var_0, var_2))
        return 1;
    }
  }

  return 0;
}

_id_13145(var_0) {
  var_1 = self;

  if(isDefined(var_1) && isDefined(var_1._encstr_8695106ECBC23963BB73F0880BD4185B4B73)) {
    foreach(var_3 in var_1._encstr_8695106ECBC23963BB73F0880BD4185B4B73)
    var_3 setscriptablepartstate("_encstr_9A950B1A29907409C123774331", var_0);
  }
}

_id_12126() {
  wait 1.0;
  var_0 = getentitylessscriptablearrayinradius("_encstr_92FB2098139BDCE08D5722126DB116C07DEBF3A0F91EDC81869699609F1B4F63D6A3", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("_encstr_B26906A4E753E778", "_encstr_ADB405071B8AE8");

  var_4 = getentitylessscriptablearrayinradius("_encstr_8EE51F83DA235360C3B91511A561302E5B127BEB42CB1930D196312DF79708E0F3", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_6 in var_4)
  var_6 setscriptablepartstate("_encstr_B16705D9AFE22E", "_encstr_ADB405071B8AE8");
}

atv_initcollision() {
  wait 1.0;
  var_0 = getentitylessscriptablearrayinradius("_encstr_A5F024F35E3B128B6853431CC5E6E74F0B079FE95EB6812921146B5038E2FA1A28D83D33E360", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_ADB405071B8AE8");
}

move_platform(var_0) {
  var_1 = getEntArray("_encstr_869D0CC4EB934F808153B8C077B8", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_3 in var_1) {
    if(var_0) {
      thread _id_11CFF(var_3);
      continue;
    }

    var_3 notify("_encstr_92C3149CACB5F69D59BE6D2D638DEBE8934B9D3B569C");
  }
}

_id_11CFF(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_92C3149CACB5F69D59BE6D2D638DEBE8934B9D3B569C");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isPlayer(var_1))
      var_1 dodamage(10000, var_1.origin, var_0, var_0, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3");
  }
}

left_side_spawn_adjuster(var_0) {
  if(var_0 == "_encstr_8E8A06F7D987435E")
    lengthmod();
}

lengthmod() {
  if(leaveforplayer()) {
    var_0 = level.players[0];
    var_1 = spawnStruct();
    var_1.angles = var_0.angles;
    var_1.origin = var_0.origin + anglesToForward(var_0.angles) * 100;
    level.petwatchtype[level.petwatchtype.size] = var_1;

    if(level.petwatchtype.size % 2 == 0) {
      var_2 = easepower("_encstr_AF671482E636438E376831FB206B030708D80C37F07B", var_1.origin, var_1.angles);
      var_3 = lethal_boxes(var_2);
      var_4 = lengthdelta(level.petwatchtype[level.petwatchtype.size - 2]);
      var_5 = [var_3];
      throwingknife_fire_begin_fx(var_2, var_5, var_4);
      attackerinitammo(var_2);
    } else
      var_2 = easepower("_encstr_AF671482E636438E376831FB206B030708D80C37F07B", var_1.origin, var_1.angles);
  }
}

lethal_boxes(var_0) {
  var_1 = (10, 0, 150);
  var_2 = rotatevector(var_1, var_0.angles);
  var_3 = easepower("_encstr_9BD0151327EB338537E8BE3A93589DAC63AF1BD23BA18E", var_0.origin + var_2, (-90, var_0.angles[1], 0));
  return var_3;
}

lengthdelta(var_0) {
  var_1 = anglesToForward((0, (var_0.angles[1] + 180) % 360, 0));
  var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0.origin + 100 * var_1);
  return var_2;
}

leaveforplayer() {
  if(isDefined(level.petwatchtype) == 0)
    level.petwatchtype = [];

  if(isDefined(level.petobjectivefilter) == 0) {
    teammarkedfor();
    return 1;
  }

  if(level.petobjectivefilter.size < 16)
    return 1;

  return 0;
}