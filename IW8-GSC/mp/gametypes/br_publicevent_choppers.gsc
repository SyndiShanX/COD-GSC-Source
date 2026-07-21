/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_publicevent_choppers.gsc
****************************************************/

init() {
  var_0 = spawnStruct();
  var_0._id_140CF = ::_id_140CF;
  var_0.weight = getdvarfloat("_encstr_A9FC1A07834221E61B39CB114127ABE89A08A3BD3BE198BD5F92C03B", 1.0);
  var_0._id_14382 = ::_id_14382;
  var_0.attackerswaittime = ::attackerswaittime;
  var_0._encstr_8BC10D10BFF87BCF58583BE223A02F = ::_encstr_8BC10D10BFF87BCF58583BE223A02F;
  var_0._id_11B78 = getdvarint("_encstr_8BA41D33AAA3CF3AD009C0D93F27539737C9322376079DBFD08FCB2B25F29B", 1);
  var_0.guard_door_clip = _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::relic_squadlink_init_vfx("_encstr_829A098F9CC8FABBD87BAF", "_encstr_8CF627C26E663171AEA0979FAD22A9F98AD7E2F2061E6939D2486F87811EE141526F5A7ACFB6A101FE");
  var_0._encstr_A3BC1423775D180D6A8B83BDCF8255C0EDCC49B8DBAB = _encstr_99B82F4BFFA864837D23A68A6BF8E7DEF86BC4B931C82AB62E7BB963D3A60394F0C35E2DB52872AF41B1033ADBA877CA58::_encstr_BD2A1BFF8980447BA7F5CB97235DA3BD581133C740D81F028BE7B32B07("_encstr_829A098F9CC8FABBD87BAF");
  var_1 = scripts\engine\utility::ter_op(_encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_11E05(), 120.0, 0);
  var_2 = getdvarint("_encstr_AB181C9B2F78397BCE16035AFEAE8BEDC0B105026769BD1FFC49BB8280F5", var_1);
  var_0.sol_5_6_pool = var_2;
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_12B35(1, var_0);
}

_encstr_8BC10D10BFF87BCF58583BE223A02F() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88E41DE393A9E08F2FB0E730E74AD337EFF043E0033007D39A890A43415A94"] = "_encstr_8E07240F4DB3B0939EB978E832F591EBEFD31587A053DAB7C6B230E07BCF55A3977B1DF71A5B";
}

_id_140CF() {
  var_0 = scripts\mp\utility\game::round_vehicle_logic() == "_encstr_BE180419DAE9" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_8AE1099A0B999F2D28AF15" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_9B1F05BE4B9B52" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_866209ECEDB1197DEE0B4E";
  return !var_0;
}

_id_14382() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8A431478F7784BCAC97FDB3836432F5B17EDD3F7F8EB");
  var_0 = forest_combat();
  wait(var_0);
}

attackerswaittime() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getdvarint("_encstr_9793198703C2A1669BB94B91C1A72B681A88233DBB61B838AF82C3", 5);
  level forest_fire_setup(var_0);
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371("_encstr_82551589937DC12BD78D43B7830E56939BFA9B47B0E4D1");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_88E41DE393A9E08F2FB0E730E74AD337EFF043E0033007D39A890A43415A94");
  setomnvar("_encstr_838C1D0DEC415103CA13D0881FF6D9B51B99899B859A23C9A0C72020C32B91", 1);
  thread _id_13622(var_0);
  var_1 = 10.0;
  thread _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_encstr_B2D3127BF1E6F77B6BA316E95398826B0D48E3B2(var_1);
  _id_14404(var_1);
}

forest_combat() {
  var_0 = getdvarfloat("_encstr_8D4A21CD8D9CF52627FA38CAD7D834ED380E959C6EAFE6A32C27D1A396D659F5AD2DDC", 555.0);
  var_1 = getdvarfloat("_encstr_884A21B9D8E4BE894E7D1CCAFA36A1DEC1385627E67D9BE81693D11DA5DA95FA6B0BE1", 765.0);

  if(var_1 > var_0)
    return randomfloatrange(var_0, var_1);
  else
    return var_0;
}

_id_14404(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0))
    wait(var_0);

  for(;;) {
    var_1 = level._id_119E7;

    if(!isDefined(var_1)) {
      break;
    }

    var_1 = scripts\engine\utility::array_removeundefined(var_1);

    if(var_1.size == 0) {
      break;
    }

    wait 1.0;
  }
}

_id_13622(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
    var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
  } else {
    level.binoculars_checkexpirationtimer = 35;
    level._id_12946 = 1;
    level.fly_over_path = 0;
    level thread _encstr_8C492BEBB1E647FA4817D76DE96AC7AF81E913F37B355765D03DAF6ECB488EA33B402AFA808093ADD09D8F63FF::_id_1325B();
  }

  _encstr_8A362837E0B36903E1B6DD451F6F4A29F848A3671009CB3E25CED93D888733F3A0B02BCB2B035EE25F6E::init();
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8D480F89C9D7C6F6F6A3B1D0DB1C38AC39", "_encstr_AFFD17A58F20BBBFF4905B4247A041307248BB123C3DD38208", ::_id_1200F);

  if(!isDefined(level._id_1229F)) {
    var_3 = _encstr_8A362837E0B36903E1B6DD451F6F4A29F848A3671009CB3E25CED93D888733F3A0B02BCB2B035EE25F6E::_id_11A0C(var_1, var_2);
    _encstr_8A362837E0B36903E1B6DD451F6F4A29F848A3671009CB3E25CED93D888733F3A0B02BCB2B035EE25F6E::_id_11A0D(var_3);
  }

  var_4 = getdvarint("_encstr_8A221B9B1B27EB1339AF8359AF361AF60EC1CA9CCDFAAD4B3719969BD1", 6000);

  if(level.mapname == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE")
    var_4 = 1000;

  for(var_5 = 0; var_5 < var_0; var_5++) {
    var_6 = undefined;

    if(isDefined(level._id_1229F))
      var_6 = level._id_1229F[var_5];
    else {
      var_7 = var_5 % 4 + 1;
      var_6 = _encstr_8A362837E0B36903E1B6DD451F6F4A29F848A3671009CB3E25CED93D888733F3A0B02BCB2B035EE25F6E::_id_11A07(level._id_119E6["_encstr_B4140618C3CE5176" + var_7], var_4);
    }

    var_8 = _encstr_8A362837E0B36903E1B6DD451F6F4A29F848A3671009CB3E25CED93D888733F3A0B02BCB2B035EE25F6E::_id_11A18(var_6, "_encstr_85881A33AA5B58E8F4870139B55A411677938B98438390A84F5F3331");

    if(isDefined(var_8)) {
      if(isDefined(level._id_1229D))
        var_8.lootfunc = level._id_1229D;
      else
        var_8.lootfunc = ::dropcrate;

      if(!getdvarint("_encstr_8DA71AB93639FA26E4F538CA7DC634ED0EE0AC9CDCF5853A8E8536AD", 0)) {
        var_8.frontturret._id_13E86 = 1;
        var_8.frontturret makeunusable();
        var_8.rearturret._id_13E86 = 1;
        var_8.rearturret makeunusable();
      }

      var_8.flaresreservecount = getdvarint("_encstr_AA461A2B71265FBEB88F4825F74844D74F8BC283DB6843F508FD553B", 0);
      var_8.health = getdvarint("_encstr_883C1AA00AA2FF09830F6FED37FF70578AA39850E33129A1A7547553", 5000);
      var_8.maxhealth = getdvarint("_encstr_883C1AA00AA2FF09830F6FED37FF70578AA39850E33129A1A7547553", 5000);

      if(_encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::unset_relic_healthpacks())
        var_8.lifetime = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::inithelirepository();
      else if(self.sol_5_6_pool)
        var_8.lifetime = self.sol_5_6_pool;

      if(getdvarint("_encstr_8DA71AB93639FA26E4F538CA7DC634ED0EE0AC9CDCF5853A8E8536AD", 0) != 0)
        var_9 = "_encstr_858B23CF5C37ABE3E9E8334F858A5B8253F823FE2C2320FBA9A6407A4601E748B50398699B";
      else
        var_9 = "_encstr_ACB529236059D5E849795AA12AD970D8DDD38D686BB2AFA06E7A487BB787FE13C56338277207BD2D558823";

      scripts\mp\objidpoolmanager::update_objective_icon(var_8.objectiveiconid, var_9);
    }

    wait 1;
  }

  var_10 = getdvarfloat("_encstr_88C92D37B193FA139CD7E02BF58D0DDB1C831C5927E6AF8D2DC91B8D2B7D2358DA16D959F5DCA3B0E4E8FA3AA5D6AC", 10.0);
  level.delay_turn_on_headlights = gettime() + int(var_10 * 1000.0);
}

dropcrate() {
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_deregisterinstance(self);
  var_0 = _encstr_8A362837E0B36903E1B6DD451F6F4A29F848A3671009CB3E25CED93D888733F3A0B02BCB2B035EE25F6E::_id_11A06(self.origin + (0, 0, 500));

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\killstreaks\airdrop::missionid(self.origin, var_0);
    var_2 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_1);
    var_2._id_140A0 = 10;

    if(!isDefined(level.delay_turn_off_tum_display))
      level.delay_turn_off_tum_display = [];

    level.delay_turn_off_tum_display[level.delay_turn_off_tum_display.size] = var_1;
  }
}

_id_1200F(var_0) {
  self.itemsdropped = 0;

  if(!isDefined(level.delay_turn_off_red_lights_along_track))
    level.delay_turn_off_red_lights_along_track = 0;
  else
    level.delay_turn_off_red_lights_along_track = (level.delay_turn_off_red_lights_along_track + 1) % 10;

  var_1 = verifybunkercode("_encstr_A79511C1CAFAC686EDE0072B39FAB1E4853A95", level.delay_turn_off_red_lights_along_track);

  if(isDefined(var_1))
    var_1 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A1A(var_1, var_0);

  if(isDefined(var_1) && var_0 scripts\mp\utility\perk::_hasperk("_encstr_A525253BC72DCE64888D531381EE1B39A7581BF2D0612790AD2867E108076FA8B6096323CDA015"))
    var_1 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A1D(var_1, var_0);

  if(isDefined(var_1))
    var_2 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A02(var_1);

  if(!isDefined(var_0._id_11A01))
    var_0._id_11A01 = 1;
  else
    var_0._id_11A01++;

  var_0 scripts\mp\utility\stats::setextrascore1(var_0._id_11A01);
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_92611950639191A0EF2CF0D618C78B71C78B41D82AF0BFF8EB2560");
}

dangercircletick(var_0, var_1) {
  if(!isDefined(level.delay_turn_on_headlights) || gettime() < level.delay_turn_on_headlights) {
    return;
  }
  var_2 = getdvarfloat("_encstr_AF45267B265A5753936950732976FA97818B5DE8E7409FAB5A0782CF9F22A398EE203A87AB9CC8EB", 500.0);
  var_3 = 240.0;
  var_4 = level._id_119E7;

  if(isDefined(var_4)) {
    var_4 = scripts\engine\utility::array_removeundefined(var_4);

    foreach(var_6 in var_4) {
      var_7 = 0;
      var_8 = var_6.origin;
      var_9 = distance2d(var_0, var_8);

      if(var_9 + var_3 > var_1)
        var_7 = 1;

      if(var_7) {
        var_10 = var_6.health;
        var_11 = var_6.maxhealth;
        var_6 dodamage(var_2, var_8, undefined, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3", "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633");
      }
    }
  }

  var_13 = getdvarfloat("_encstr_9BF4277FA8FBE79A2568168CE62F3265E660A393603104715F999F86C0FB2B17EBC06B577808478AB9", 2400.0);
  var_14 = level.delay_turn_off_tum_display;

  if(isDefined(var_14)) {
    var_14 = scripts\engine\utility::array_removeundefined(var_14);

    foreach(var_16 in var_14) {
      var_17 = distance2dsquared(var_16.origin, var_0);
      var_18 = max(0, var_1 + var_13);

      if(var_17 > var_18 * var_18)
        var_16 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    }
  }
}

forest_fire_setup(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.safecircleent)) {
    return;
  }
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
  var_3 = 0.3;
  var_4 = 0.8;
  var_5 = var_2 * var_3;
  var_6 = var_2 * var_4;
  [var_8, var_9] = play_tape_machine_animation(var_1, var_5, var_6);

  if(var_8 == var_9) {
    return;
  }
  if(var_8 != 0.0 || var_9 != 360.0) {
    var_8 = var_8 + 20.0;
    var_9 = var_9 - 20.0;

    if(var_9 <= var_8)
      return;
  } else {
    var_10 = randomfloatrange(0.0, 360.0);
    var_8 = var_8 + var_10;
    var_9 = var_9 + var_10;
  }

  var_11 = (var_9 - var_8) / max(1.0, var_0 - 1);
  level._id_1229F = [];

  for(var_12 = 0; var_12 < var_0; var_12++) {
    var_13 = var_8 + var_11 * var_12;
    var_14 = anglesToForward((0.0, var_13, 0.0));

    if(var_6 > var_5)
      var_15 = randomfloatrange(var_5, var_6);
    else
      var_15 = var_6;

    var_16 = var_1 + var_14 * var_15;

    if(isscriptabledefined())
      var_16 = getclosestpointonnavmesh(var_16);

    var_17 = spawnStruct();
    var_17.origin = var_16;
    level._id_1229F[var_12] = var_17;
  }
}

play_tape_machine_animation(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = level.mapcenter - var_0;
  var_3 = (var_3[0], var_3[1], 0.0);
  var_3 = vectorNormalize(var_3);
  var_4 = vectortoyaw(var_3);
  var_5 = var_0 + var_3 * var_1;
  var_6 = var_0 + var_3 * var_2;
  var_7 = !scripts\mp\outofbounds::ispointinoutofbounds(var_5) && !scripts\mp\outofbounds::ispointinoutofbounds(var_6);

  if(!var_7)
    return [0.0, 0.0];

  var_8 = 45.0;
  var_9 = 45.0;
  var_10 = var_4;
  var_11 = var_4 + var_8;
  var_12 = var_4;
  var_13 = var_4 - var_9;
  var_14 = 0;
  var_15 = 180 / int(var_8);
  var_16 = 0;
  var_17 = 1.0;

  for(;;) {
    if(var_8 >= var_17) {
      var_18 = anglesToForward((0.0, var_11, 0.0));
      var_19 = var_0 + var_18 * var_1;
      var_20 = var_0 + var_18 * var_2;
      var_21 = !scripts\mp\outofbounds::ispointinoutofbounds(var_19) && !scripts\mp\outofbounds::ispointinoutofbounds(var_20);

      if(var_21) {
        var_10 = var_11;
        var_11 = var_10 + var_8;
      } else {
        var_16 = 1;
        var_8 = var_8 * 0.5;
        var_11 = var_10 + var_8;
      }
    }

    if(var_9 >= var_17) {
      var_22 = anglesToForward((0.0, var_13, 0.0));
      var_23 = var_0 + var_22 * var_1;
      var_24 = var_0 + var_22 * var_2;
      var_25 = !scripts\mp\outofbounds::ispointinoutofbounds(var_23) && !scripts\mp\outofbounds::ispointinoutofbounds(var_24);

      if(var_25) {
        var_12 = var_13;
        var_13 = var_12 - var_9;
      } else {
        var_16 = 1;
        var_9 = var_9 * 0.5;
        var_13 = var_12 - var_9;
      }
    }

    if(!var_16) {
      var_14++;

      if(var_14 >= var_15)
        return [0.0, 360.0];
    }

    if(var_8 < var_17 && var_9 < var_17)
      return [var_12, var_10];

    waitframe();
  }
}