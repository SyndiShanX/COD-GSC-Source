/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\utility\scriptable_door_utility.gsc
*****************************************************/

arenaballs() {
  if(!getdvarint("_encstr_A56E13EBAFD915984AA2E9C38A3F4040921B797B53", 0)) {
    return;
  }
  level._effect["_encstr_A96B0F1DBA274EB2D1EB8C2C5B0B9D5646"] = loadfx("_encstr_AF572CED66E082432F6F0E91F3760B28BDF955B147CB681BA66321DA492BBEF29951D34FB4F5B0C8820F3003C29B");
  level._effect["_encstr_B120110BADFD3B45ABD1A3AFD8C32A9283CD97"] = loadfx("_encstr_A9F440CE990FE52DBB70BE89C9E52DE6D8853732F277CA5838BC7DB4B538F2A3BAE4E4CAE85E67CCF0EBD95986F595871CD87B9B2DB773AFD1BA399395478BECCC87");
  level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23");
  var_0 = getscriptablearray("_encstr_99E8310E896ABA53B42126D9AD19CBCA9287D39CE967826077028E99D1D35BB24AB56BEFCFD04969372357CF080B87DF6AE7B0", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("_encstr_BA9105D8C6D283", "_encstr_A18008BD35E222F01BD0");

  level.arenaflag_showflagoutlineplayer = [];
  level.arenaflag_setvisible = [];
  level.arenaflag_setenabled = ::_id_134E5;
  var_4 = scripts\engine\utility::getStructArray("_encstr_BD8C10866F5FA39DA3606FD3F17B503AD770", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_6 in var_4)
  var_6 thread _id_134E5();

  level thread _id_11B1F();
}

_id_134E5() {
  var_0 = self;
  var_1 = "_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83";

  if(getdvarint("_encstr_A56E13EBAFD915984AA2E9C38A3F4040921B797B53", 0) == 2)
    var_1 = "_encstr_97781E650A25C38AAC57A0C87B5BB7F5DF8A108FA21EBB8BF030E72F98F028EA";

  var_2 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_0.origin, var_1, 0);
  var_2 unmarkkeyframedmover(1);

  if(getdvarint("_encstr_8C92142FC669713BE243A8D80F0571B1B12F95265B82", 0) == 1) {
    var_3 = spawnStruct();
    var_3 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(5, 0, 0, var_0.origin);
    var_3 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(3000);

    while(!isDefined(level.players[0]))
      waitframe();

    var_3 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336A(level.players[0]);
  }

  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_2.angles = var_0.angles;
  var_2 setModel("_encstr_9BF6213B2B1AD7CD43FAB5B48DF536B98CF547D52793CAA3FAE25D1646AF0B85EBEE4F");
  var_4 = "_encstr_8E010B996FB7B6B3C1D1183343";
  var_5 = var_2 gettagorigin(var_4);
  var_5 = var_5 - anglesToForward(var_0.angles) * 28;
  var_2 setdefaultdroppitch(0);
  var_2 setturretmodechangewait(1);
  var_2.maxhealth = getdvarint("_encstr_95D9146BDE7AF13E3367E3EB4F7BFDC01237F36684C0", 1000);
  var_2.health = var_2.maxhealth;
  var_2.spawnuniqueboardroomloot = 99;
  var_2 setCanDamage(1);
  var_2 thread arena_turret_op_debug();
  var_2 makeunusable();
  var_2 thread arenaflag_objectiveshow();
  var_0 thread arenaflag_showflagoutline(var_2, var_5);
  level.arenaflag_showflagoutlineplayer[level.arenaflag_showflagoutlineplayer.size] = var_2;
  return var_2;
}

_id_11B1F() {
  level waittill("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  level notify("_encstr_B23B1DB2495DE774899FF4E97538717B0DA38AAB16BFA7E1E88B0AE2636002");

  foreach(var_1 in level.arenaflag_showflagoutlineplayer) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(isDefined(var_1.owner))
      var_1 arenaflag_setcaptured();

    if(isDefined(var_1.useownerobj))
      var_1.useownerobj delete();

    if(isDefined(var_1.playerzombieemp))
      stopFXOnTag(scripts\engine\utility::getfx("_encstr_A96B0F1DBA274EB2D1EB8C2C5B0B9D5646"), var_1, "_encstr_9B240FF39904C726C821A4BD052021AF39");

    var_1 delete();
  }

  if(isDefined(level.arenaknivesout)) {
    foreach(var_4 in level.arenaknivesout)
    var_4 delete();
  }

  level.arenaflag_showflagoutlineplayer = [];
  level.arenaknivesout = [];
  var_6 = scripts\engine\utility::getStructArray("_encstr_BD8C10866F5FA39DA3606FD3F17B503AD770", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_8 in var_6)
  var_8 thread _id_134E5();
}

arenaflag_setcaptured() {
  var_0 = self;
  var_1 = self.owner;

  if(isDefined(var_1)) {
    var_1 enableturretdismount();

    if(isDefined(var_0))
      var_1 controlturretoff(var_0);

    var_1 setclientomnvar("_encstr_954F1A83F8786F05F03B9C9DBFA84BEB16910BA901C82BBB280F8473", 0);
    var_1 setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", -1);
    var_1 setclientomnvar("_encstr_85211093887F232FB8AFCBCFA0034BADB1C0", 0);
    var_1 setclientomnvar("_encstr_A60A143B40C0AB2F383FEBE57D30F703FD3ED3A2292D", -1);
    var_1 setclientomnvar("_encstr_A93C12AB4BFAB3CAA1D7BDD836BA07583747EB81", -1);
    var_1 setclientomnvar("_encstr_9B531645E3C9ABAF0BAECA027151A3647179CDCA0FF075D3", 0);
    var_1 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("_encstr_87680AB085AF1DBA93C92B1D");
    var_1.nocorpse = undefined;
    var_1.laststancechangetime = gettime();
    var_1.pers["_encstr_8D0C13FAB3EED8345297D2E0FF98D789E9BE07BFF8"] = undefined;
    var_1 scripts\cp_mp\killstreaks\manual_turret::_id_11ACD(1);

    if(var_1 hasweapon("_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83"))
      var_1 takeweapon("_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83");

    var_1 scripts\mp\utility\inventory::switchtolastweapon();
    var_1 thread scripts\cp_mp\killstreaks\manual_turret::_id_11AC7();
  }
}

arenaflag_showflagoutline(var_0, var_1) {
  level endon("_encstr_B23B1DB2495DE774899FF4E97538717B0DA38AAB16BFA7E1E88B0AE2636002");
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_2 = self;

  while(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83"))
      var_0.useownerobj = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83")]](var_1, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_BE3E20AB60F9390E5F88DCE510CF4D9A86890701CD12E1FD1BC134CCA9C79E91AE34", -1, "_encstr_97C20EB5FD43A179CC6AD05152651579", undefined, 100, 60, 40, 60);

    var_0.useownerobj thread arenaflag_objectivehide();
    var_0.useownerobj waittill("_encstr_8F5C086405E70FBA4B4A", var_3);
    var_0.useownerobj delete();

    if(istrue(var_3.isjuggernaut)) {
      continue;
    }
    if(isDefined(var_3.currentprimaryweapon) && isDefined(var_3.currentprimaryweapon.basename) && var_3.currentprimaryweapon.basename == "_encstr_8ED01022406F60CB51BD13885E3BA80F33E8") {
      var_4 = var_3 getplayerangles();
      var_4 = (clamp(var_4[0], -85, 85), scripts\engine\utility::absangleclamp180(var_4[1]), 0);
      var_5 = anglesToForward(var_4);
      var_6 = 90;
      var_3.get_search_turret_target_player thread scripts\mp\equipment\binoculars::get_station_track_available_time_stamp(var_5 * var_6, var_3);
    }

    if(isDefined(var_3.carriable_set_dropped)) {
      if(var_3 tagexists("_encstr_91480BA9AF130B3B7DB1B2CC47"))
        killfxontag(level._effect["_encstr_A28815D9CC87FA9839BE6C58E61A13B2C28CB2934816CE"], var_3, "_encstr_91480BA9AF130B3B7DB1B2CC47");

      var_3 detach(var_3.carriable_set_dropped, "_encstr_869011ED8EA26FA3BC7FBB983BFFD94B4AB4C6");
    }

    var_7 = var_3.origin;
    var_3 scripts\cp_mp\killstreaks\manual_turret::_id_11ACD(0);
    var_3 disableturretdismount();
    var_0.owner = var_3;
    var_0.team = var_3.team;
    var_3 giveweapon("_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83", -1, 0, -1, 1);
    var_8 = var_3 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch("_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83", 1);

    if(!istrue(var_8)) {
      if(isalive(var_3)) {
        var_3 enableturretdismount();
        var_3 scripts\cp_mp\killstreaks\manual_turret::_id_11ACD(1);

        if(var_3 hasweapon("_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83"))
          var_3 takeweapon("_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83");

        var_3 scripts\mp\utility\inventory::switchtolastweapon();
      }

      continue;
    }

    var_3.txt_nag = var_3 controlturreton(var_0);
    var_3.nocorpse = 1;
    var_3 setclientomnvar("_encstr_954F1A83F8786F05F03B9C9DBFA84BEB16910BA901C82BBB280F8473", 1);
    var_3 setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", 24);
    var_3 setclientomnvar("_encstr_85211093887F232FB8AFCBCFA0034BADB1C0", 1);
    var_3 setclientomnvar("_encstr_A60A143B40C0AB2F383FEBE57D30F703FD3ED3A2292D", 0);
    var_3 setclientomnvar("_encstr_A93C12AB4BFAB3CAA1D7BDD836BA07583747EB81", 0);
    var_3 setclientomnvar("_encstr_9B531645E3C9ABAF0BAECA027151A3647179CDCA0FF075D3", var_0.spawnuniqueboardroomloot);
    var_3 _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("_encstr_87680AB085AF1DBA93C92B1D");
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 setplayerangles(var_0.angles);
    var_0 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_99BF0603D0C4979A");
    var_3 thread scripts\cp_mp\killstreaks\manual_turret::manualturret_disablefire(var_3, 2, 1);
    wait 2;

    if(scripts\mp\flags::gameflag("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F")) {
      while(isalive(var_3) && !scripts\mp\utility\player::unset_relic_trex(var_3) && !var_3 useButtonPressed() && !var_3 isinexecutionvictim())
        waitframe();
    } else {
      while(isalive(var_3) && !scripts\mp\utility\player::unset_relic_trex(var_3) && !var_3 useButtonPressed() && !var_3 isinexecutionvictim() && !scripts\mp\flags::gameflag("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F"))
        waitframe();
    }

    if(isDefined(var_0))
      var_0 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_A760055987D2E8");

    if(isDefined(var_3)) {
      var_3 enableturretdismount();

      if(isDefined(var_0))
        var_3 controlturretoff(var_0);

      var_3 setclientomnvar("_encstr_954F1A83F8786F05F03B9C9DBFA84BEB16910BA901C82BBB280F8473", 0);
      var_3 setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", -1);
      var_3 setclientomnvar("_encstr_85211093887F232FB8AFCBCFA0034BADB1C0", 0);
      var_3 setclientomnvar("_encstr_A60A143B40C0AB2F383FEBE57D30F703FD3ED3A2292D", -1);
      var_3 setclientomnvar("_encstr_A93C12AB4BFAB3CAA1D7BDD836BA07583747EB81", -1);
      var_3 setclientomnvar("_encstr_9B531645E3C9ABAF0BAECA027151A3647179CDCA0FF075D3", 0);
      var_3 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("_encstr_87680AB085AF1DBA93C92B1D");
      var_3.nocorpse = undefined;
      var_3.txt_nag = undefined;
      var_3.laststancechangetime = gettime();
      var_3 scripts\cp_mp\killstreaks\manual_turret::_id_11ACD(1);

      if(var_3 hasweapon("_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83"))
        var_3 takeweapon("_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83");

      var_3 scripts\mp\utility\inventory::switchtolastweapon();
      var_3 thread scripts\cp_mp\killstreaks\manual_turret::_id_11AC7();
      var_3 setOrigin(var_7);
      var_3 setplayerangles((var_3.angles[0], var_3.angles[1], 0));
    }

    if(isDefined(var_0)) {
      var_0.owner = undefined;
      var_0 setotherent(undefined);
      var_0 setentityowner(undefined);
    }

    if(isDefined(var_3.carriable_set_dropped)) {
      var_3 attach(var_3.carriable_set_dropped, "_encstr_869011ED8EA26FA3BC7FBB983BFFD94B4AB4C6", 1, 1);

      if(var_3 tagexists("_encstr_91480BA9AF130B3B7DB1B2CC47"))
        playFXOnTag(level._effect["_encstr_A28815D9CC87FA9839BE6C58E61A13B2C28CB2934816CE"], var_3, "_encstr_91480BA9AF130B3B7DB1B2CC47");
    }

    wait 0.5;
  }
}

arena_turret_op_debug() {
  level endon("_encstr_B23B1DB2495DE774899FF4E97538717B0DA38AAB16BFA7E1E88B0AE2636002");
  self.health = 2000;

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(self.owner) && isDefined(var_1) && isPlayer(var_1) && self.owner.team == var_1.team) {
      self.health = self.health + var_0;
      continue;
    }

    var_1 thread scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A2FB098A2035874AB0F358");

    if(isDefined(var_1) && isDefined(var_1.vehicle) && isDefined(var_1.vehicle._id_13E92)) {
      if(var_1.vehicle._id_13E92 == "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC")
        self.health = self.health - int(var_0 * level.pindia_vehicle_registration);
      else if(var_1.vehicle._id_13E92 == "_encstr_84A00E50B085578F87182E98ED81081B")
        self.health = self.health - int(var_0 * level.findeventforchosenweight);
    }

    if(var_4 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_4 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_4 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_4 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_4 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B")
      self.health = self.health - var_0;

    self.spawnuniqueboardroomloot = int((self.health - 1000) / 1000 * 100);

    if(self.spawnuniqueboardroomloot == 100)
      self.spawnuniqueboardroomloot = 99;

    if(self.spawnuniqueboardroomloot < 30 && !isDefined(self.playerzombieemp))
      self.playerzombieemp = playFXOnTag(scripts\engine\utility::getfx("_encstr_A96B0F1DBA274EB2D1EB8C2C5B0B9D5646"), self, "_encstr_9B240FF39904C726C821A4BD052021AF39");

    if(self.spawnuniqueboardroomloot < 0)
      self.spawnuniqueboardroomloot = 0;

    if(isDefined(self.owner))
      self.owner setclientomnvar("_encstr_9B531645E3C9ABAF0BAECA027151A3647179CDCA0FF075D3", self.spawnuniqueboardroomloot);

    if(self.health <= 1000) {
      break;
    }
  }

  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_10.angles = self.angles;
  playFX(scripts\engine\utility::getfx("_encstr_B120110BADFD3B45ABD1A3AFD8C32A9283CD97"), var_10.origin);
  var_10 setModel("_encstr_839625EC5943BE370DBED696D8F5D8B991D71DD5E44E598EFA2EEAC2C8F558C2F5BBA7F5196B9D");
  var_10 setscriptablepartstate("_encstr_ACCB09CA870E63F5B9991E", "_encstr_B16005BB937341");

  if(isDefined(self.useownerobj))
    self.useownerobj delete();

  if(isDefined(self.owner)) {
    self.owner setclientomnvar("_encstr_954F1A83F8786F05F03B9C9DBFA84BEB16910BA901C82BBB280F8473", 0);
    self.owner setclientomnvar("_encstr_AC6D0F407A391D595B5F3CBD708741E11F", -1);
    self.owner setclientomnvar("_encstr_85211093887F232FB8AFCBCFA0034BADB1C0", 0);
    self.owner setclientomnvar("_encstr_A60A143B40C0AB2F383FEBE57D30F703FD3ED3A2292D", -1);
    self.owner setclientomnvar("_encstr_A93C12AB4BFAB3CAA1D7BDD836BA07583747EB81", -1);
    self.owner setclientomnvar("_encstr_9B531645E3C9ABAF0BAECA027151A3647179CDCA0FF075D3", 0);
    self.owner.txt_nag = undefined;
    self.owner kill(self.origin, var_1);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F"))
      var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F")]]("_encstr_A30C1980F5B14A106A5C1592C9F1E45298BB5A4AA937E3BDD80835", 500);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A51F05CB11A052", "_encstr_A71810F05AB595D96FF635B8ECE340599BD3"))
      var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A51F05CB11A052", "_encstr_A71810F05AB595D96FF635B8ECE340599BD3")]]("_encstr_A30C1980F5B14A106A5C1592C9F1E45298BB5A4AA937E3BDD80835");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_87680AB085AF1DBA93C92B1D", "_encstr_9B4C155307A0F5F238D82749DD8FF332FB192970831DD3"))
    var_10 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_87680AB085AF1DBA93C92B1D", "_encstr_9B4C155307A0F5F238D82749DD8FF332FB192970831DD3")]]();

  if(!isDefined(level.arenaknivesout))
    level.arenaknivesout = [];

  level.arenaknivesout[level.arenaknivesout.size] = var_10;
  self delete();
}

arenaflag_objectiveshow() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;

  while(isalive(self)) {
    if(isDefined(self.owner)) {
      if(!isDefined(var_0)) {
        var_0 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
        arenaflag_onuncontested(var_0, "_encstr_84B91DEA4BBEDA387D98C9BED2B1ED73AF8585F5E8BAC993ACD1D7B08D36F2");
      }

      if(!isDefined(var_1)) {
        var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
        arenaflag_onuncontested(var_1, "_encstr_82151EAE2DEBB6C1AF984EAFA536DBCDD70B857DE8EA393956E8D7CA3756B6E5");
      }

      if(isDefined(var_2)) {
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_2);
        scripts\mp\objidpoolmanager::returnobjectiveid(var_2);
        var_2 = undefined;
      }

      scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(var_0, self.owner);
      scripts\mp\objidpoolmanager::objective_mask_showtoenemyteam(var_1, self.owner);
    } else {
      if(isDefined(var_0)) {
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_0);
        scripts\mp\objidpoolmanager::returnobjectiveid(var_0);
        var_0 = undefined;
      }

      if(isDefined(var_1)) {
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_1);
        scripts\mp\objidpoolmanager::returnobjectiveid(var_1);
        var_1 = undefined;
      }

      if(!isDefined(var_2)) {
        var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
        arenaflag_onuncontested(var_2, "_encstr_88131847D87EF59B1F9632610B0F228E06F08F6788932243B3B5");
      }

      scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_2);
    }

    waitframe();
  }

  if(isDefined(var_0)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_0);
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0);
    var_0 = undefined;
  }

  if(isDefined(var_1)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_1);
    scripts\mp\objidpoolmanager::returnobjectiveid(var_1);
    var_1 = undefined;
  }

  if(isDefined(var_2)) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_2);
    scripts\mp\objidpoolmanager::returnobjectiveid(var_2);
    var_2 = undefined;
  }
}

arenaflag_onuncontested(var_0, var_1) {
  objective_state(var_0, "_encstr_930B07BB1B6B3854FF");
  objective_position(var_0, self.origin);
  playencryptedcinematicforall(var_0, 1);
  objective_setplayintro(var_0, 0);
  objective_setshowdistance(var_0, 0);
  objective_setshowoncompass(var_0, 0);
  _func_421(var_0, 1);
  objective_setlabel(var_0, "_encstr_8CF313298FD0BC1748D7D6E03E70E7C7157BB13953");
  scripts\mp\objidpoolmanager::update_objective_icon(var_0, var_1);
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_0, 5);
}

arenaflag_objectivehide() {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");

  for(;;) {
    foreach(var_1 in level.players) {
      if(istrue(var_1.isjuggernaut)) {
        self hidefromplayer(var_1);
        continue;
      }

      self showtoplayer(var_1);
    }

    waitframe();
  }
}