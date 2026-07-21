/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_brdov.gsc
***********************************************/

init() {
  level.disable_heli_lights = spawnStruct();
  level.disable_heli_lights._id_14291 = getdvarint("_encstr_826B127316DA2EBA48E750DB370B8FA2A3B9B2E6", 0);

  switch (level.disable_heli_lights._id_14291) {
    case 3:
      strafe_speed();
      break;
    case 2:
      strafe_pass_target_dist();
      break;
    case 1:
      strafe_minigun_manager_delta();
      break;
    case 0:
    default:
      strafe_minigun_manager();
      break;
  }
}

strafe_minigun_manager(var_0) {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B8F06A38D72C380");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_AB23109F838B7B7448013FC5BBA84402D013");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_ADF20D88BB7DC8C9AA6A4653C3822F");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_99FE10EF999079CA14F3AB53D14F638D48A3", ::remove_on_death);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_BE94109AA047C32EB04BFAD347D0352F765B", ::onplayerconnect);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8E0D1A1FBA72FB316C9F48993B910B0518E693B9554AABDB29976060", ::_id_12862);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A3E52148C0D01A378B41D049E09F80B8B0ABD9EF8F785873C8FBE291ED16367B1C57B5", ::_id_12863);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_B62A09E34FB8BF309F3F63", ::mayspawn);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8A38163B98D17952EDA44F0596EFEA2D3FE0C30708A8DDFB", ::_id_126F1);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_82E2179290C48043DF1D81FB571A085350687EB7B73007AFA3", ::tier);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_B8CD1DF19377E7EE6DBA4BC1E3639999CA497B9A867208FA2021D379A2CA77", ::loadout_copyclassstruct);
  level.prematchperiodend = 0;
  level.br_infils_disabled = 1;
  level._id_133E0 = 1;
  level.debug_safehouse_gunshop_start = 1;
  level.disablespawning = 1;

  if(!istrue(var_0))
    thread toggleconnectpaths();
}

toggleconnectpaths() {
  waittillframeend;
  var_0 = getdvarfloat("_encstr_83C5206E1B93FA4C4E23B7ECF50E9395DA2C1DB134EBCDC1C2DD737D4E0B23A5BA6E", 1500);

  if(level.mapname == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE")
    level.delete_script_object = [_encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-6906, -4478, 66), 0, var_0), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((4622, -301, 50), 0, var_0), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-2348, 1391, 58), 0, var_0), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-3787, 2022, 58), 0, var_0), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((14913, 16178, 58), 0, var_0)];
  else
    level.delete_script_object = [_encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((28653, 2355, -688), 0, var_0), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((26797, 20510, 1384), 0, var_0), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((31359, 36450, 640), 0, var_0), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-22839, 49175, 2747), 0, var_0), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-22047, 15388, -6), 0, var_0), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((21694, -16289, 1970), 0, var_0), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((50956, -39269, 1412), 0, var_0), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((46948, -10375, 125), 0, var_0), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-5574, 8168, -269), 0, var_0)];
}

_id_12862() {
  return 0;
}

_id_12863() {
  return 1;
}

remove_on_death() {
  return [];
}

onplayerconnect(var_0) {
  var_0.br_infilstarted = 1;
  var_0.shouldhumanspawntags = 0;
  var_0.disable_hilltop_roof_traversal = gettime();
  var_0 setclientomnvar("_encstr_82D30EBA5AF5899CEBB473662D36CA23", 1);
  thread onplayerspawn(var_0);
  var_0 setsoundsubmix("_encstr_8F061DA0CB19159BA785DC5D96D3E6D1FD53C0C2916F575062976BC0768FC8", 0.5);
}

onplayerspawn(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_A1E00B25BA2FD7DBEA6085B830");
  var_0 setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_82A30F380BF9E3F8A32971E031DBE39D5D"][0]);
  var_0 clearsoundsubmix("_encstr_8F061DA0CB19159BA785DC5D96D3E6D1FD53C0C2916F575062976BC0768FC8", 3);

  if(getdvarint("_encstr_ADDE27BBE21B60D85AA4675DF7C310B5FF2BF1A60A8F2E18F5BD7F77FEA1688BEB336B2E9343EF808D", 1))
    level notify("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");

  waittillframeend;
  var_0 _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize();
  var_0 _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_give_type(var_0, "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9", 30, 0);
}

mayspawn() {
  return 1;
}

_id_126F1() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  thread _id_126F2();

  while(!self isonground())
    waitframe();

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detachriotshield(self);
}

_id_126F2() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait(getdvarfloat("_encstr_88591F931BDDD18B0A3A372EE1436013B61FD0624FFE331A8B30815FEB8D4808C0", 5.0));
  scripts\mp\hud_message::showsplash("_encstr_97BC1A3127FA1CC959B5588E1B86AFDD56B1D8ED6B56AFC43919EDB3");

  if(getdvarint("_encstr_96C723CFDF3607D5B367FFDBD95B9AFACB40D56103792D6A31ABAF95288FD74969E26558A5", 1))
    level notify("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");

  wait(getdvarfloat("_encstr_8DDD1B9B364E7D899C19DBCEAFDDCA638DEDB62BEB3BB7EB8CB28D2C2F", 0.5));
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8EA412AB830729900AE9375F1AF448E69BAAE3B1", self, 0);
}

tier() {
  return getdvarint("_encstr_AF932217937211D62B9A3803317B9688CDE991AF3091A8278F83102E0BEFC068A753CB09", 2000);
}

loadout_copyclassstruct(var_0) {
  if(!isDefined(var_0))
    return 1;

  var_1 = (gettime() - var_0.disable_hilltop_roof_traversal) / 1000;
  return var_1 < getdvarfloat("_encstr_A3D5299BC693AF984E91DB3B7D914BB92C1336ACD7D80B9B1DFAB685B9D7B947B0E6C8D2733BF5475AADAC", 30.0);
}

strafe_minigun_manager_delta() {
  thread togglecpplayerbc();
}

togglecpplayerbc() {
  waittillframeend;
}

strafe_pass_target_dist() {
  strafe_minigun_manager(1);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AD5B19389C2BD0C28D1B6A58CC59D05A93D81BACD0599B1D2BC9DC", ::_id_12848);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_B2722482678563E730023AED218393FB22DBB058EF174FC3104988305F60C023ED5A480121C2");
  level.disable_heli_lights._id_133C7 = getdvarint("_encstr_ABBE18B98D27EB269C46ED9D91F59BB54B07EB8D96C91BB1AC9B", 1);
  level.decoyassists = ::decoy_ignoredbyenemy;
  thread togglelightbutton();
}

togglelightbutton() {
  waittillframeend;
  var_0 = getdvarint("_encstr_AAE81638923A17E17BDC08FCE2A7281BA5F980A82A93BD1B", 10);
  var_1 = getdvarint("_encstr_857818AF782B374A9545A51B962793C091706397E020520291ED", 1);
  var_2 = level.br_level.default_class_chosen[var_1];
  var_3 = level.br_level.br_circleradii[var_1];
  var_2 = (var_2[0], var_2[1], 3000);
  var_4 = physics_createcontents(["_encstr_92A41EDB523776801EB37F6FC683B8B0AB5BB643FAAFAB2872AC257BF7AF7006"]);
  var_5 = (0, 0, 0);
  var_6 = physics_raycast(var_2, var_2 + (var_3, 0, 0), var_4, undefined, 0, "_encstr_A1C4111F40CF43E3EE0BC8E002C29B9E07FCA9");
  var_5 = var_5 + (var_3 * ammo_box_spawn(var_6), 0, 0);
  var_6 = physics_raycast(var_2, var_2 - (var_3, 0, 0), var_4, undefined, 0, "_encstr_A1C4111F40CF43E3EE0BC8E002C29B9E07FCA9");
  var_5 = var_5 - (var_3 * ammo_box_spawn(var_6), 0, 0);
  var_6 = physics_raycast(var_2, var_2 + (0, var_3, 0), var_4, undefined, 0, "_encstr_A1C4111F40CF43E3EE0BC8E002C29B9E07FCA9");
  var_5 = var_5 + (0, var_3 * ammo_box_spawn(var_6), 0);
  var_6 = physics_raycast(var_2, var_2 - (0, var_3, 0), var_4, undefined, 0, "_encstr_A1C4111F40CF43E3EE0BC8E002C29B9E07FCA9");
  var_5 = var_5 - (0, var_3 * ammo_box_spawn(var_6), 0);
  var_5 = var_5 / 2.0;
  var_5 = var_5 + var_2;
  level.delete_script_object = [];
  battletracks(var_5, var_2, var_3, var_0, 0);
  battletracks(var_5, var_2, var_3, var_0, 360 / var_0 / 2.0);
}

battletracks(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getdvarfloat("_encstr_82C91F5F57B679EA10F1ADF323A1234387C7A3773F53F3A3C839A9BD81336BAAE5", 500.0);
  var_6 = physics_createcontents(["_encstr_92A41EDB523776801EB37F6FC683B8B0AB5BB643FAAFAB2872AC257BF7AF7006"]);
  var_7 = [];

  for(var_8 = 0; var_8 < var_3; var_8++) {
    var_9 = var_8 * (360 / var_3) + var_4;
    var_10 = anglesToForward((0, var_9, 0));
    var_11 = var_0;
    var_12 = var_11 + 2.0 * var_10 * var_2;
    var_13 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::woods_two_death_func(var_11, var_12, var_1, var_2);

    if(vectordot(var_10, var_13[0] - var_11) > 0)
      var_12 = var_13[0];
    else
      var_12 = var_13[1];

    var_14 = distance(var_11, var_12);
    var_15 = physics_raycast(var_11, var_12, var_6, undefined, 0, "_encstr_A1C4111F40CF43E3EE0BC8E002C29B9E07FCA9");
    var_16 = ammo_box_spawn(var_15);
    var_7[var_7.size] = var_11 + var_10 * (var_14 * var_16 - var_5);
  }

  var_7 = scripts\engine\utility::array_randomize(var_7);

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_17 = vectortoangles(var_0 - var_7[var_8]);
    var_17 = (0, var_17[1], 0);
    var_18 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation(var_7[var_8], 0, 100);
    var_18.angles = var_17;
    level.delete_script_object[level.delete_script_object.size] = var_18;
  }
}

ammo_box_spawn(var_0) {
  var_1 = 1.0;

  foreach(var_3 in var_0) {
    var_4 = var_3["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_4) && isDefined(var_4.targetname) && var_4.targetname == "_encstr_8A720C48B3AB7729A26778B853CB") {
      var_1 = var_3["_encstr_A53009A25003666B9818C6"];
      break;
    }
  }

  return var_1;
}

_id_12848() {
  for(var_0 = 0; var_0 < level.disable_heli_lights._id_133C7; var_0++) {
    _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::last_vo_time(0);
    level.br_level.default_class_chosen = scripts\engine\utility::can_path_to_target(level.br_level.default_class_chosen, 0);
  }

  if(!isDefined(level.br_level.delay_start_infiltrate_objective))
    level.br_level.delay_start_infiltrate_objective = 0;

  level.br_level.delay_start_infiltrate_objective = level.br_level.delay_start_infiltrate_objective - level.disable_heli_lights._id_133C7;
}

decoy_ignoredbyenemy() {
  level.br_level.br_circleclosetimes = [270, 180, 140, 80, 70, 50, 50, 100];
  level.br_level.br_circledelaytimes = [220, 80, 70, 55, 55, 40, 30, 0];
  level.br_level.default_player_connect_black_screen = [220, 0, 0, 0, 0, 0, 0, 0];
  level.br_level.default_suicidebomber_combat = [0, 0, 0, 0, 0, 0, 0, 0];
  level.br_level.br_circleminimapradii = [10500, 10500, 10500, 10500, 10500, 9000, 8000, 5500];
  level.br_level.br_circleradii = [81600, 50000, 37000, 20000, 12300, 6000, 3000, 1500, 0];
}

strafe_speed() {
  thread _encstr_83892ADAB6ED9A609B809E9FB0D82F42BBDD63D0A77BF3F7A19067AF40C8E5DB4BEFAFC1818B9AC9C5D0DFB7::init();
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_88AB1A158BDF6B1548D18F7F35459A290B27CFEAE26BB0DBB00ABD20", ::_id_12188);
}

_id_12188(var_0) {
  return 1;
}