/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6d7723fe67d5eaf1.gsc
***********************************************/

_id_97F8AA617741E7FF(van) {
  wait 2;
  playsoundatpos(van gettagorigin("tag_steering_axis"), "dx_cp_lone_loin_lage_youreearlyasshole");
  wait 1.5;
  playsoundatpos(van gettagorigin("tag_steering_axis"), "dx_cp_lone_loin_lvs1_ifwerenotearlywerela");
  wait 2;
  scripts\engine\utility::flag_set("vo_intro_done");
}

_id_A473D9A212709C78(van) {
  actor = self.actors[0];
  wait 1.5;
  playsoundatpos(van gettagorigin("tag_steering_axis"), "dx_cp_lone_loin_lvs1_victor3towatcher1wer");
  wait 2;
  _id_48F20B0FE71DD6DF::_id_775CD164C569E279("dx_cp_lone_loin_lasw_copythatbreaker1comm", 0.8);
  wait 2.5;
  _id_48F20B0FE71DD6DF::_id_775CD164C569E279("dx_cp_lone_loin_lasw_watcher1tobreakeruav");
  thread _id_D225398F9F720297();
}

_id_4FBE9685C432A4AC() {
  level endon("game_ended");
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_loit_lvs1_clear";
  aliases[aliases.size] = "dx_cp_lone_loit_lvs1_alphasclear";
  aliases[aliases.size] = "dx_cp_lone_loit_lvs1_warehouseisclear";
  _id_22ED1EF89A08B3FE = scripts\engine\utility::create_deck(aliases);
  scripts\engine\utility::flag_wait("defender_intro_completed");
  _id_7D2852D02216C876 = _id_622EB9CC0D8F7EE0(scripts\engine\utility::getStruct("lone_intro_obj", "targetname"))[0];
  alias = _id_22ED1EF89A08B3FE scripts\engine\utility::deck_draw();

  if(isDefined(_id_7D2852D02216C876))
    _id_7D2852D02216C876 _id_5D265B4FCA61F070::say(alias);

  level _id_48F20B0FE71DD6DF::_id_775CD164C569E279("dx_cp_lone_loit_lasw_copythatnothreatsvis");
  _id_7D2852D02216C876 = _id_622EB9CC0D8F7EE0(scripts\engine\utility::getStruct("lone_intro_obj", "targetname"))[0];

  if(isDefined(_id_7D2852D02216C876))
    _id_7D2852D02216C876 _id_5D265B4FCA61F070::say("dx_cp_lone_loit_lvs1_victor3towatcher1weh");

  level _id_48F20B0FE71DD6DF::_id_775CD164C569E279("dx_cp_lone_loit_lasw_copytheyllbebackfori");
  wait 0.4;
  level _id_48F20B0FE71DD6DF::_id_775CD164C569E279("dx_cp_lone_loit_lasw_breakeradviseyouresu");
  scripts\engine\utility::flag_set("intro_vo_done");
}

_id_FF706C28066E3A3F() {
  if(level._id_62F5F42C7C300055 == 1) {
    scripts\engine\utility::flag_wait_or_timeout("intro_vo_done", 30);
    wait 2;
    _id_48F20B0FE71DD6DF::_id_775CD164C569E279("dx_cp_lone_loit_lasw_watcher1tobreakeriha");
  }

  if(level._id_62F5F42C7C300055 == 2) {
    _id_31E40E7712C5C799 = 0;
    allies = _id_9E03BD2DA38049B3();

    if(allies.size > 0)
      _id_31E40E7712C5C799 = allies[0] _id_5D265B4FCA61F070::_id_88357F565D1BADF5(0, "dx_cp_lone_low1_lvs1_victor3towatcher1its");

    if(istrue(_id_31E40E7712C5C799))
      _id_48F20B0FE71DD6DF::_id_775CD164C569E279("dx_cp_lone_low1_lasw_thensomethingstheret");
  }

  scripts\engine\utility::flag_wait("defender_wave_started");

  if(level._id_62F5F42C7C300055 == 1) {
    _id_48F20B0FE71DD6DF::_id_775CD164C569E279("dx_cp_lone_low1_lasw_watcher1tobreakercar", 0.8);
    aliases = [];
    aliases[aliases.size] = "dx_cp_lone_low1_lvs1_iseeenemies";
    aliases[aliases.size] = "dx_cp_lone_low1_lvs1_enemies";
    aliases[aliases.size] = "dx_cp_lone_low1_lvs1_heyiseeone";
    aliases[aliases.size] = "dx_cp_lone_low1_lvs1_theyreoutthereman";
    _id_4089AD3D47E880A7 = scripts\engine\utility::create_deck(aliases);

    if(_id_9E03BD2DA38049B3().size > 0) {
      _id_7D2852D02216C876 = _id_622EB9CC0D8F7EE0(level._id_FECE02A99189C2DE[0])[0];
      alias = _id_4089AD3D47E880A7 scripts\engine\utility::deck_draw();
      _id_7D2852D02216C876 _id_5D265B4FCA61F070::say(alias);
    }
  }

  _id_775E6824C1E4536F(level._id_62F5F42C7C300055);
}

_id_775E6824C1E4536F(_id_F26D6E29F4EFC048) {
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_beadvisedcartelsmovi";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_cartelismovingonalph";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_cartelisadvancingona";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_thecartelsattackinga";
  _id_89C00E1C672A46A6 = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_beadvisedcartelsmovi_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_cartelismovingonbrav";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_cartelsadvancingonbr";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_cartelshardpointinga";
  _id_6CF04C012FD59F15 = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_beadvisedcartelsmovi_02";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_cartelsmovingoncharl";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_cartelsadvancingonch";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_cartelsattackingchar";
  _id_138CABF321220818 = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_beadvisedcartelsmovi_03";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_cartelismovingondelt";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_cartelsadvancingonde";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_cartelsattackingdelt";
  _id_FAABAAB82F67AC07 = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_beadvisedcartelsmovi_04";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_cartelismovingonecho";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_cartelsadvancingonth";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_cartelshardpointinga_01";
  _id_A8CE5B715B214662 = scripts\engine\utility::create_deck(aliases);
  _id_04950770B91053A3 = undefined;
  _id_FD50720CC5DECFAB = level._id_FECE02A99189C2DE[0];
  id = _id_3E19322333AD204C::_id_DE5BD5987042469C(_id_FD50720CC5DECFAB);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low3_lasw_breakercartelsincomi";
  aliases[aliases.size] = "dx_cp_lone_low3_lasw_breaker1beadvisedcar";
  aliases[aliases.size] = "dx_cp_lone_low3_lasw_beadvisedcartelgroun";
  aliases[aliases.size] = "dx_cp_lone_low3_lasw_breakercartelshooter";
  aliases[aliases.size] = "dx_cp_lone_low3_lasw_beadvisedcartelsmovi";
  _id_80D32688A264D21A = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low4_lasw_breaker1beadvisedthe";
  aliases[aliases.size] = "dx_cp_lone_low4_lasw_allstationsbeadvised";
  aliases[aliases.size] = "dx_cp_lone_low4_lasw_breakerdivideandconq";
  _id_40B906A493581227 = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low5_lasw_watcher1tobreakerthe";
  aliases[aliases.size] = "dx_cp_lone_low5_lasw_youregonnaneedtomove";
  aliases[aliases.size] = "dx_cp_lone_low5_lasw_getreadytoworkstayti";
  _id_8152A8A81083DF5D = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low6_lasw_allstationsthecartel";
  aliases[aliases.size] = "dx_cp_lone_low6_lasw_allstationscartelisa";
  _id_548F6520FD024733 = scripts\engine\utility::create_deck(aliases);

  if(_id_F26D6E29F4EFC048 < 3) {
    switch (id) {
      case "a":
        _id_04950770B91053A3 = _id_89C00E1C672A46A6 scripts\engine\utility::deck_draw();
        break;
      case "b":
        _id_04950770B91053A3 = _id_6CF04C012FD59F15 scripts\engine\utility::deck_draw();
        break;
      case "c":
        _id_04950770B91053A3 = _id_138CABF321220818 scripts\engine\utility::deck_draw();
        break;
      case "d":
        _id_04950770B91053A3 = _id_FAABAAB82F67AC07 scripts\engine\utility::deck_draw();
        break;
      case "e":
        _id_04950770B91053A3 = _id_A8CE5B715B214662 scripts\engine\utility::deck_draw();
        break;
      default:
        _id_04950770B91053A3 = undefined;
    }
  } else if(_id_F26D6E29F4EFC048 == 3 || _id_F26D6E29F4EFC048 == 4)
    _id_04950770B91053A3 = _id_40B906A493581227 scripts\engine\utility::deck_draw();
  else if(_id_F26D6E29F4EFC048 == 5)
    _id_04950770B91053A3 = _id_40B906A493581227 scripts\engine\utility::deck_draw();
  else if(_id_F26D6E29F4EFC048 == 6)
    _id_04950770B91053A3 = _id_548F6520FD024733 scripts\engine\utility::deck_draw();

  if(isDefined(_id_04950770B91053A3))
    _id_48F20B0FE71DD6DF::_id_775CD164C569E279(_id_04950770B91053A3, 0.8);

  wait 4;
  _id_E1DEF79935DA3A50(_id_F26D6E29F4EFC048);
}

_id_E1DEF79935DA3A50(_id_F26D6E29F4EFC048) {
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low3_lasw_breaker1beadvisedlas";
  aliases[aliases.size] = "dx_cp_lone_low3_lasw_headsupbreakerenemyo";
  aliases[aliases.size] = "dx_cp_lone_low3_lasw_lasalmashasabirdover";
  aliases[aliases.size] = "dx_cp_lone_low3_lasw_beadvisedcartelheloi";
  _id_F951F5EED82D75E3 = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low3_lvs1_fuckimtakingcover";
  aliases[aliases.size] = "dx_cp_lone_low3_lvs2_shootthatbastard";
  aliases[aliases.size] = "dx_cp_lone_low3_lvs1_theyrekillingusman";
  _id_DF601F3FC9975ECC = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low3_lasw_breakertargetthatene";
  aliases[aliases.size] = "dx_cp_lone_low3_lasw_focusfireontheirover";
  aliases[aliases.size] = "dx_cp_lone_low3_lasw_breaker1carteloverwa";
  aliases[aliases.size] = "dx_cp_lone_low3_lasw_breaker1takeouttheir";
  _id_8845E506C5FAE9AE = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low4_lasw_takeoutthosemortars";
  aliases[aliases.size] = "dx_cp_lone_low4_lasw_breakerassaultthosem";
  _id_6E0623CE4CDDEEA0 = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low3_lasw_breakeryouvegotheavi";
  aliases[aliases.size] = "dx_cp_lone_low3_lasw_beadvisedthoseenemie";
  _id_F409E8D682564ED4 = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low6_lvs2_visualonenemyjuggern";
  aliases[aliases.size] = "dx_cp_lone_low6_lvs2_gotanenemyjuggernaut";
  _id_4037D3FB6208A253 = scripts\engine\utility::create_deck(aliases);

  if(_id_B503F79125BF989E(_id_F26D6E29F4EFC048, "mortar")) {
    _id_48F20B0FE71DD6DF::_id_775CD164C569E279("dx_cp_lone_low4_lasw_thisiswatcher1enemym", 1);
    wait 2.5;
    _id_48F20B0FE71DD6DF::_id_775CD164C569E279(_id_6E0623CE4CDDEEA0 scripts\engine\utility::deck_draw(), 0.8);
  }

  if(_id_B503F79125BF989E(_id_F26D6E29F4EFC048, "heli_heavy")) {
    _id_48F20B0FE71DD6DF::_id_775CD164C569E279(_id_F951F5EED82D75E3 scripts\engine\utility::deck_draw(), 0.8);
    wait 3;

    if(_id_9E03BD2DA38049B3().size > 0 && isDefined(level._id_11A368973DB314CA)) {
      _id_7D2852D02216C876 = scripts\engine\utility::random(_id_9E03BD2DA38049B3());
      _id_7D2852D02216C876 _id_5D265B4FCA61F070::say(_id_DF601F3FC9975ECC scripts\engine\utility::deck_draw());
      wait 2;

      if(isDefined(level._id_11A368973DB314CA))
        _id_48F20B0FE71DD6DF::_id_775CD164C569E279(_id_8845E506C5FAE9AE scripts\engine\utility::deck_draw());
    }
  }

  if(_id_B503F79125BF989E(_id_F26D6E29F4EFC048, "juggernaut")) {
    _id_48F20B0FE71DD6DF::_id_775CD164C569E279("dx_cp_lone_low6_lasw_beadvisedthecartelis", 1);
    wait 3;

    if(_id_9E03BD2DA38049B3().size > 0) {
      _id_7D2852D02216C876 = scripts\engine\utility::random(_id_9E03BD2DA38049B3());
      _id_7D2852D02216C876 _id_5D265B4FCA61F070::say(_id_4037D3FB6208A253 scripts\engine\utility::deck_draw());
    }
  }

  if(_id_B503F79125BF989E(_id_F26D6E29F4EFC048, "riotshield"))
    _id_48F20B0FE71DD6DF::_id_775CD164C569E279("dx_cp_lone_low5_lasw_allstationsbeadvised", 1);

  if(_id_B503F79125BF989E(_id_F26D6E29F4EFC048, "velikan_small"))
    _id_48F20B0FE71DD6DF::_id_775CD164C569E279(_id_F409E8D682564ED4 scripts\engine\utility::deck_draw(), 0.8);
}

_id_619CC5C01A10AA61() {}

_id_A88C781E5EA4CFB8(id) {
  _id_0FA7BE42C52A4D8C();
  _id_04950770B91053A3 = undefined;
  _id_7E9CCC2D6DDB44DA = undefined;

  switch (id) {
    case "a":
      _id_04950770B91053A3 = level._id_5FBE1D131DB13523[0] scripts\engine\utility::deck_draw();
      _id_7E9CCC2D6DDB44DA = "dx_cp_lone_low1_lasw_watcher1tobreakerdef";
      break;
    case "b":
      _id_04950770B91053A3 = level._id_5FBE1D131DB13523[1] scripts\engine\utility::deck_draw();
      _id_7E9CCC2D6DDB44DA = "dx_cp_lone_low1_lasw_watcher1tobreakerdef_01";
      break;
    case "c":
      _id_04950770B91053A3 = level._id_5FBE1D131DB13523[2] scripts\engine\utility::deck_draw();
      _id_7E9CCC2D6DDB44DA = "dx_cp_lone_low1_lasw_watcher1tobreakerget";
      break;
    case "d":
      _id_04950770B91053A3 = level._id_5FBE1D131DB13523[3] scripts\engine\utility::deck_draw();
      _id_7E9CCC2D6DDB44DA = "dx_cp_lone_low1_lasw_watcher1tobreakerget_01";
      break;
    case "e":
      _id_04950770B91053A3 = level._id_5FBE1D131DB13523[4] scripts\engine\utility::deck_draw();
      _id_7E9CCC2D6DDB44DA = "dx_cp_lone_low1_lasw_watcher1tobreakerdis";
      break;
    default:
      _id_04950770B91053A3 = undefined;
  }

  if(isDefined(id) && isDefined(_id_04950770B91053A3)) {
    if(_id_9E03BD2DA38049B3().size > 0) {
      _id_7D2852D02216C876 = _id_622EB9CC0D8F7EE0(_id_3E19322333AD204C::_id_A74D0CFDC9AF0414(id))[0];
      _id_7D2852D02216C876 _id_5D265B4FCA61F070::say(_id_04950770B91053A3);
    }

    _id_48F20B0FE71DD6DF::_id_775CD164C569E279(_id_7E9CCC2D6DDB44DA, 0.8);
  }
}

_id_5994EB14C59DD582(_id_3DEF217D9BD38E42) {
  id = _id_3E19322333AD204C::_id_DE5BD5987042469C(_id_3DEF217D9BD38E42);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_stillgottargets";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_westillgotcartel";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_stillgottargetsinthe";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_enemiesstillactive";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_enemiesstillactive_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_enemiesstillactive_02";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_enemiesstillactive_03";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_enemiesstillactive_04";
  _id_BE754ECE360DDB94 = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_breakercartelstillin";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_stillhavevisualonene";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_stillhavevisualonene_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_stillhavevisualonene_02";
  _id_9A2EE9643E0817EB = scripts\engine\utility::create_deck(aliases);
  _id_8A289E026EFBD345 = [];
  _id_8A289E026EFBD345["a"] = "dx_cp_lone_low1_lvs1_chargedefusedalphass";
  _id_8A289E026EFBD345["b"] = "dx_cp_lone_low1_lvs1_chargedefusedbravoss";
  _id_8A289E026EFBD345["c"] = "dx_cp_lone_low1_lvs1_chargedefusedcharlie";
  _id_8A289E026EFBD345["d"] = "dx_cp_lone_low1_lvs1_chargedefuseddeltass";
  _id_8A289E026EFBD345["e"] = "dx_cp_lone_low1_lvs1_chargedefusedechosse";
  _id_48F20B0FE71DD6DF::_id_775CD164C569E279(_id_8A289E026EFBD345[id]);

  if(scripts\cp\cp_agent_utils::getaliveagentsofteam("axis").size > 0) {
    allies = _id_9E03BD2DA38049B3();

    if(allies.size > 0) {
      allies[0] _id_5D265B4FCA61F070::say(_id_BE754ECE360DDB94 scripts\engine\utility::deck_draw());
      wait 4;

      if(scripts\cp\cp_agent_utils::getaliveagentsofteam("axis").size > 0 && _id_3E19322333AD204C::_id_936911BE45BEB356() == 0)
        _id_48F20B0FE71DD6DF::_id_775CD164C569E279(_id_9A2EE9643E0817EB scripts\engine\utility::deck_draw());
    }
  }
}

_id_F268432F3BC3718F(id) {
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_alphaisdown";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_welostalpha";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_allstationstheenemyd";
  _id_E309D33222EC71DB["a"] = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_bravoisdown";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_welostbravo";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_allstationstheenemyd_01";
  _id_E309D33222EC71DB["b"] = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_charlieisdown";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_welostcharlie";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_allstationstheenemyd_02";
  _id_E309D33222EC71DB["c"] = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_deltaisdown";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_welostdelta";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_allstationstheenemyd_03";
  _id_E309D33222EC71DB["d"] = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_echoisdown";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_welostecho";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_allstationstheenemyd_04";
  _id_E309D33222EC71DB["e"] = scripts\engine\utility::create_deck(aliases);

  if(isDefined(_id_E309D33222EC71DB[id]))
    _id_48F20B0FE71DD6DF::_id_775CD164C569E279(_id_E309D33222EC71DB[id] scripts\engine\utility::deck_draw());

  level._id_ADFA9C802373792D = id;
}

_id_0FA7BE42C52A4D8C() {
  if(isDefined(level._id_5FBE1D131DB13523)) {
    return;
  }
  level._id_5FBE1D131DB13523 = [];
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_cartelplantedabombon";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_enemybombonalpha";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_theysetachargeinthew";
  level._id_5FBE1D131DB13523[level._id_5FBE1D131DB13523.size] = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_cartelplantedabombon_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_enemybombonbravo";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_theysetachargeonbrav";
  level._id_5FBE1D131DB13523[level._id_5FBE1D131DB13523.size] = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_cartelplantedabombon_02";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_enemybomboncharlie";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_theysetachargeonchar";
  level._id_5FBE1D131DB13523[level._id_5FBE1D131DB13523.size] = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_cartelplantedabombon_03";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_enemybombonbravo_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_theysetachargeonbrav_01";
  level._id_5FBE1D131DB13523[level._id_5FBE1D131DB13523.size] = scripts\engine\utility::create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_cartelplantedabombon_04";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_theysetachargeonecho";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_enemybombinthecontai";
  level._id_5FBE1D131DB13523[level._id_5FBE1D131DB13523.size] = scripts\engine\utility::create_deck(aliases);
}

_id_92A3B85D5A08EC5D(_id_546BDD6F69FD53E0, struct) {
  level endon("defender_defuse_" + struct.targetname);
  _id_3777ECE6A73EADA5 = undefined;

  if(_id_546BDD6F69FD53E0 > 60) {
    _id_3777ECE6A73EADA5 = _id_546BDD6F69FD53E0 - 60;
    wait(_id_3777ECE6A73EADA5);
    level thread _id_8BE5F80BDD7CD5A5(60, struct);
    _id_546BDD6F69FD53E0 = _id_546BDD6F69FD53E0 - _id_3777ECE6A73EADA5;
  }

  if(isDefined(_id_3777ECE6A73EADA5)) {
    _id_3777ECE6A73EADA5 = _id_546BDD6F69FD53E0 - 45;
    wait(_id_3777ECE6A73EADA5);
    level thread _id_8BE5F80BDD7CD5A5(45, struct);
    _id_546BDD6F69FD53E0 = _id_546BDD6F69FD53E0 - _id_3777ECE6A73EADA5;
  }

  if(isDefined(_id_3777ECE6A73EADA5)) {
    _id_3777ECE6A73EADA5 = _id_546BDD6F69FD53E0 - 30;
    wait(_id_3777ECE6A73EADA5);
    level thread _id_8BE5F80BDD7CD5A5(30, struct);
    _id_546BDD6F69FD53E0 = _id_546BDD6F69FD53E0 - _id_3777ECE6A73EADA5;
  }

  if(isDefined(_id_3777ECE6A73EADA5)) {
    wait(_id_3777ECE6A73EADA5);
    level thread _id_8BE5F80BDD7CD5A5(15, struct);
    _id_546BDD6F69FD53E0 = _id_546BDD6F69FD53E0 - _id_3777ECE6A73EADA5;
  }

  if(isDefined(_id_3777ECE6A73EADA5)) {
    _id_3777ECE6A73EADA5 = _id_546BDD6F69FD53E0 - 10;
    wait(_id_3777ECE6A73EADA5);
    level thread _id_8BE5F80BDD7CD5A5(10, struct);
  }
}

_id_8BE5F80BDD7CD5A5(_id_546BDD6F69FD53E0, struct) {
  id = _id_3E19322333AD204C::_id_DE5BD5987042469C(struct);

  if(!isDefined(id)) {
    return;
  }
  _id_0A395D1A34FA016C = [];
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_timerssetfor60second";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_timerssetfor60second_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_timerssetfor60second_02";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_timerssetfor60second_04";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_wegotoneminute";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_chargeissetforonemin_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_chargeissetforonemin_02";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_chargeissetforonemin_03";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_enemychargeissetforo";
  _id_B00183AD9A6732F4 = scripts\engine\utility::create_deck(aliases, 1, 1);
  _id_0A395D1A34FA016C["60"] = _id_B00183AD9A6732F4;
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_bombsat45seconds";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_bombsat45seconds_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_bombsat45seconds_02";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_bombsat45seconds_03";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_bombsat45seconds_04";
  _id_AA99728E0061C04D = scripts\engine\utility::create_deck(aliases, 1, 1);
  _id_0A395D1A34FA016C["45"] = _id_AA99728E0061C04D;
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_timersat30seconds";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_timersat30seconds_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_timersat30seconds_02";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_timersat30seconds_03";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_timersat30seconds_04";
  _id_8BD9C1F5423F966D = scripts\engine\utility::create_deck(aliases, 1, 1);
  _id_0A395D1A34FA016C["30"] = _id_8BD9C1F5423F966D;
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_15seconds";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_15seconds_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_15seconds_02";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_15seconds_03";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_15seconds_04";
  _id_7E9BAF6C34F05338 = scripts\engine\utility::create_deck(aliases, 1, 1);
  _id_0A395D1A34FA016C["15"] = _id_7E9BAF6C34F05338;
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_motherfucker10second";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_10secondsleft";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_motherfucker10second_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_10secondsleft_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_motherfucker10second_02";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_10secondsleft_02";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_motherfucker10second_03";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_10secondsleft_03";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_motherfucker10second_04";
  aliases[aliases.size] = "dx_cp_lone_low1_lvs1_10secondsleft_04";
  _id_0D9B947DA24D2FD3 = scripts\engine\utility::create_deck(aliases, 1, 1);
  _id_0A395D1A34FA016C["10"] = _id_0D9B947DA24D2FD3;
  _id_B0C8E4AC9E5AD3A4 = [];
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_beadvisedoneminuteto";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_beadvisedoneminuteto_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_beadvisedoneminuteto_02";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_beadvisedoneminuteto_03";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_beadvisedoneminuteto_04";
  _id_31ED485B8C158ACC = scripts\engine\utility::create_deck(aliases, 1, 1);
  _id_B0C8E4AC9E5AD3A4["60"] = _id_31ED485B8C158ACC;
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_breakeryouvegot45sec";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_breakeryouvegot45sec_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_breakeryouvegot45sec_02";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_breakeryouvegot45sec_03";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_breakeryouvegot45sec_04";
  _id_1E9B5B0AD84731E5 = scripts\engine\utility::create_deck(aliases, 1, 1);
  _id_B0C8E4AC9E5AD3A4["45"] = _id_1E9B5B0AD84731E5;
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_yougot30secondstodis";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_30secondstodisarm";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_30secondstodisarm_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_30secondstodisarm_02";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_30secondstodisarm_03";
  _id_EA74D8A4F0AC0C85 = scripts\engine\utility::create_deck(aliases, 1, 1);
  _id_B0C8E4AC9E5AD3A4["30"] = _id_EA74D8A4F0AC0C85;
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_15secondsyouneedtomo";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_15secondsbreakergetm_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_15secondsbreakergetm_02";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_15secondsbreakergetm_03";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_15secondsbreakergetm_04";
  _id_CC92A1ED0E8C2F10 = scripts\engine\utility::create_deck(aliases, 1, 1);
  _id_B0C8E4AC9E5AD3A4["15"] = _id_CC92A1ED0E8C2F10;
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_10secondslastchance";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_10secondsyoucanstill";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_10secondslastchance_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_10secondsyoucanstill_01";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_10secondslastchance_02";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_10secondsyoucanstill_02";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_10secondslastchance_03";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_10secondsyoucanstill_03";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_10secondslastchance_04";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_10secondsyoucanstill_04";
  _id_7049274544876E6B = scripts\engine\utility::create_deck(aliases, 1, 1);
  _id_B0C8E4AC9E5AD3A4["10"] = _id_7049274544876E6B;
  _id_AEC15CD138CDD306 = [];
  _id_AEC15CD138CDD306["a"] = "dx_cp_lone_low1_lvs1_bombsinthewarehousew";
  _id_AEC15CD138CDD306["b"] = "dx_cp_lone_low1_lvs1_bravosgoingupin60sec";
  _id_AEC15CD138CDD306["c"] = "dx_cp_lone_low1_lvs1_charlieshot60seconds";
  _id_AEC15CD138CDD306["d"] = "dx_cp_lone_low1_lvs1_deltasgoingupin60sec";
  _id_AEC15CD138CDD306["e"] = "dx_cp_lone_low1_lvs1_echosgoingupin60seco";
  _id_AEB86DD138C3D9BB = [];
  _id_AEB86DD138C3D9BB["a"] = "dx_cp_lone_low1_lvs1_45secondstodisarmalp";
  _id_AEB86DD138C3D9BB["b"] = "dx_cp_lone_low1_lvs1_45secondstodisarmbra";
  _id_AEB86DD138C3D9BB["c"] = "dx_cp_lone_low1_lvs1_45secondstodisarmcha";
  _id_AEB86DD138C3D9BB["d"] = "dx_cp_lone_low1_lvs1_45secondstodisarmdel";
  _id_AEB86DD138C3D9BB["e"] = "dx_cp_lone_low1_lvs1_45secondstodisarmbra_01";
  _id_AEB3EAD138BEC3CB = [];
  _id_AEB3EAD138BEC3CB["a"] = "dx_cp_lone_low1_lvs1_30secondstodefusethe";
  _id_AEB3EAD138BEC3CB["b"] = "dx_cp_lone_low1_lvs1_30secondstilbravodet";
  _id_AEB3EAD138BEC3CB["c"] = "dx_cp_lone_low1_lvs1_30secondstilcharlied";
  _id_AEB3EAD138BEC3CB["d"] = "dx_cp_lone_low1_lvs1_30secondstildeltagoe";
  _id_AEB3EAD138BEC3CB["e"] = "dx_cp_lone_low1_lvs1_30secondstilechodeto";
  _id_AEAB61D138B5AAD2 = [];
  _id_AEAB61D138B5AAD2["a"] = "dx_cp_lone_low1_lvs1_15secondsonalpha";
  _id_AEAB61D138B5AAD2["b"] = "dx_cp_lone_low1_lvs1_15secondsonbravo";
  _id_AEAB61D138B5AAD2["c"] = "dx_cp_lone_low1_lvs1_15secondsoncharlie";
  _id_AEAB61D138B5AAD2["d"] = "dx_cp_lone_low1_lvs1_15secondsondelta";
  _id_AEAB61D138B5AAD2["e"] = "dx_cp_lone_low1_lvs1_15secondsonecho";
  _id_9A4FB57B7763ED3E = [];
  _id_9A4FB57B7763ED3E["a"] = "dx_cp_lone_low1_lasw_timerssetforoneminut";
  _id_9A4FB57B7763ED3E["b"] = "dx_cp_lone_low1_lasw_timerssetforoneminut_01";
  _id_9A4FB57B7763ED3E["c"] = "dx_cp_lone_low3_lasw_cartelssettingacharg";
  _id_9A4FB57B7763ED3E["d"] = "dx_cp_lone_low1_lasw_timerssetforoneminut_03";
  _id_9A4FB57B7763ED3E["e"] = "dx_cp_lone_low3_lasw_enemybombinechoonemi";
  _id_9A47267B775AC713 = [];
  _id_9A47267B775AC713["a"] = "dx_cp_lone_low1_lasw_45secondstodefusealp";
  _id_9A47267B775AC713["b"] = "dx_cp_lone_low1_lasw_breaker45secondstode";
  _id_9A47267B775AC713["c"] = "dx_cp_lone_low1_lasw_breaker45secondstode_01";
  _id_9A47267B775AC713["d"] = "dx_cp_lone_low1_lasw_breaker45secondstode_02";
  _id_9A47267B775AC713["e"] = "dx_cp_lone_low1_lasw_breaker45secondstode_03";
  _id_9A42A37B7755B123 = [];
  _id_9A42A37B7755B123["a"] = "dx_cp_lone_low1_lasw_breakeryouvegot30sec";
  _id_9A42A37B7755B123["b"] = "dx_cp_lone_low1_lasw_breakeryouvegot30sec_01";
  _id_9A42A37B7755B123["c"] = "dx_cp_lone_low1_lasw_breakeryouvegota30se";
  _id_9A42A37B7755B123["d"] = "dx_cp_lone_low1_lasw_breakeryouvegot30sec_02";
  _id_9A42A37B7755B123["e"] = "dx_cp_lone_low1_lasw_breakeryouvegot30sec_03";
  _id_9A39BA7B774BC50A = [];
  _id_9A39BA7B774BC50A["a"] = "dx_cp_lone_low1_lasw_15secondsbreakergetm";
  _id_9A39BA7B774BC50A["b"] = "dx_cp_lone_low1_lasw_15secondsgettobravo";
  _id_9A39BA7B774BC50A["c"] = "dx_cp_lone_low1_lasw_15secondsgettocharli";
  _id_9A39BA7B774BC50A["d"] = "dx_cp_lone_low1_lasw_15secondsdefusedelta";
  _id_9A39BA7B774BC50A["e"] = "dx_cp_lone_low1_lasw_15secondsdefuseecho";
  _id_9A39B77B774BBE71 = [];
  _id_9A39B77B774BBE71["a"] = "dx_cp_lone_low1_lasw_10secondsdisarmthatc";
  _id_9A39B77B774BBE71["b"] = "dx_cp_lone_low1_lasw_10secondsdisarmbravo";
  _id_9A39B77B774BBE71["c"] = "dx_cp_lone_low1_lasw_10secondsdefusecharl";
  _id_9A39B77B774BBE71["d"] = "dx_cp_lone_low1_lasw_10secondsdisarmdelta";
  _id_9A39B77B774BBE71["e"] = "dx_cp_lone_low1_lasw_10secondsdisarmecho";
  time = scripts\engine\utility::string(_id_546BDD6F69FD53E0);

  if(_id_9E03BD2DA38049B3().size > 0) {
    _id_7D2852D02216C876 = _id_9E03BD2DA38049B3()[0];

    if(_id_3E19322333AD204C::_id_936911BE45BEB356() < 2) {
      if(isDefined(_id_7D2852D02216C876))
        _id_7D2852D02216C876 _id_5D265B4FCA61F070::say(_id_0A395D1A34FA016C[time] scripts\engine\utility::deck_draw());
    } else {
      _id_837D37C78ADC3F10 = undefined;

      switch (time) {
        case "60":
          _id_837D37C78ADC3F10 = _id_AEC15CD138CDD306[id];
          break;
        case "45":
          _id_837D37C78ADC3F10 = _id_AEB86DD138C3D9BB[id];
          break;
        case "30":
          _id_837D37C78ADC3F10 = _id_AEB3EAD138BEC3CB[id];
          break;
        case "15":
          _id_837D37C78ADC3F10 = _id_AEAB61D138B5AAD2[id];
          break;
        case "10":
          _id_837D37C78ADC3F10 = _id_0A395D1A34FA016C[time] scripts\engine\utility::deck_draw();
          break;
        default:
          break;
      }

      if(isDefined(_id_837D37C78ADC3F10))
        _id_7D2852D02216C876 _id_5D265B4FCA61F070::say(_id_837D37C78ADC3F10);
    }
  } else if(_id_3E19322333AD204C::_id_936911BE45BEB356() < 2)
    _id_48F20B0FE71DD6DF::_id_775CD164C569E279(_id_B0C8E4AC9E5AD3A4[time] scripts\engine\utility::deck_draw());
  else {
    _id_2718642C096BC728 = undefined;

    switch (time) {
      case "60":
        _id_2718642C096BC728 = _id_9A4FB57B7763ED3E[id];
        break;
      case "45":
        _id_2718642C096BC728 = _id_9A47267B775AC713[id];
        break;
      case "30":
        _id_2718642C096BC728 = _id_9A42A37B7755B123[id];
        break;
      case "15":
        _id_2718642C096BC728 = _id_9A39BA7B774BC50A[id];
        break;
      case "10":
        _id_2718642C096BC728 = _id_9A39B77B774BBE71[id];
        break;
      default:
        break;
    }

    if(isDefined(_id_2718642C096BC728))
      _id_48F20B0FE71DD6DF::_id_775CD164C569E279(_id_2718642C096BC728);
  }

  if(_id_546BDD6F69FD53E0 == 45)
    level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_MISSION_DEFENDER/BOMB_TIMER_WARNING_45", "allies", 5);
  else if(_id_546BDD6F69FD53E0 == 30)
    level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_MISSION_DEFENDER/BOMB_TIMER_WARNING_30", "allies", 5);
}

_id_CD3408D8B63EB759() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_allstationsbeadvised";
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_allstationsbeadvised_01";
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_allstationsbeadvised_02";
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_breaker1deployingrei";
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_allstationsbeadvised_03";
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_allstationsorion41is";
  _id_2C309ABA3A1B9B40 = scripts\engine\utility::create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_loit_lvs2_letsdothis";
  aliases[aliases.size] = "dx_cp_lone_loit_lvs2_victor5isonstation";
  aliases[aliases.size] = "dx_cp_lone_loit_lvs2_victor5hasyourbackbr";
  aliases[aliases.size] = "dx_cp_lone_loit_lvs1_victor6haslandedonth";
  aliases[aliases.size] = "dx_cp_lone_loit_lvs1_wegotyou";
  aliases[aliases.size] = "dx_cp_lone_loit_lvs1_thisisvictor6tobreak";
  _id_D3CC0B28088E53F8 = scripts\engine\utility::create_deck(aliases, 1, 1);
  _id_48F20B0FE71DD6DF::_id_775CD164C569E279(_id_2C309ABA3A1B9B40 scripts\engine\utility::deck_draw());
  wait 6;

  if(_id_9E03BD2DA38049B3().size > 0) {
    _id_7D2852D02216C876 = scripts\engine\utility::random(_id_9E03BD2DA38049B3());
    _id_7D2852D02216C876 _id_5D265B4FCA61F070::say(_id_D3CC0B28088E53F8 scripts\engine\utility::deck_draw());
  }
}

_id_AA913252BFCB4AB2() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low2_lasw_breaker1yourreinforc";
  aliases[aliases.size] = "dx_cp_lone_low2_lasw_breaker1victorreinfo";
  aliases[aliases.size] = "dx_cp_lone_low2_lasw_breakeryourreinforce";
  _id_1E37E402A741F960 = scripts\engine\utility::create_deck(1, 1);
  wait 2;
  _id_48F20B0FE71DD6DF::_id_775CD164C569E279(_id_1E37E402A741F960 scripts\engine\utility::deck_draw());
}

_id_B1EA54B920AFA6F0() {
  level endon("game_ended");

  for(guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis"); guys.size > 14; guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis"))
    wait 0.1;

  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_breaker1cartelstakin";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_breaker1cartelslosin";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_breakercartelisdropp";
  _id_81A329728ABB79E4 = scripts\engine\utility::create_deck(aliases, 1, 1);
  _id_48F20B0FE71DD6DF::_id_775CD164C569E279(_id_81A329728ABB79E4 scripts\engine\utility::deck_draw(), 0.5);
}

_id_7CA559AEE8BBFD61(guys) {
  level thread _id_CE1E94599738BBA7(guys);
  wait 1.5;
  level thread _id_0C7849C0982A56BE(guys);
}

_id_CE1E94599738BBA7(guys) {
  guys = scripts\engine\utility::array_removedead(guys);

  if(guys.size == 0) {
    return;
  }
  _id_BFD74BBA4A40DE65 = scripts\cp\utility::get_average_origin(level.players);
  _id_056FDE3AB766B9EA = scripts\cp\utility::get_average_origin(guys);
  dir = _id_48F20B0FE71DD6DF::_id_B05C1C65784A70B6(_id_BFD74BBA4A40DE65, _id_056FDE3AB766B9EA);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_toyournorth";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_north";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_northside";
  _id_8CE4D68F4C1EA310 = scripts\engine\utility::create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_tothesouth";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_south";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_checksouth";
  _id_0EFF78A3CDA62B9E = scripts\engine\utility::create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_tothewest";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_west";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_checkwest";
  _id_B169B4C720938EEA = scripts\engine\utility::create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_toyoureast";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_east";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_eastside";
  _id_E2DB361B8CF1ED48 = scripts\engine\utility::create_deck(aliases, 1, 1);
  alias = undefined;

  switch (dir) {
    case "north":
      alias = _id_8CE4D68F4C1EA310 scripts\engine\utility::deck_draw();
      break;
    case "south":
      alias = _id_0EFF78A3CDA62B9E scripts\engine\utility::deck_draw();
      break;
    case "west":
      alias = _id_B169B4C720938EEA scripts\engine\utility::deck_draw();
      break;
    case "east":
      alias = _id_E2DB361B8CF1ED48 scripts\engine\utility::deck_draw();
      break;
  }

  if(isDefined(alias))
    _id_48F20B0FE71DD6DF::_id_775CD164C569E279(alias, 0.6);
}

_id_0C7849C0982A56BE(guys) {
  _id_91EC10CFA1F47A1E = scripts\engine\utility::array_removedead(guys);

  if(_id_91EC10CFA1F47A1E.size == 0) {
    return;
  }
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_fivemovers";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_gotfiveofthem";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_icountfive";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_eyesonfive";
  _id_40EF6C6D5E20FE5F = scripts\engine\utility::create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_fourtargets";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_fourmovers";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_youhavefourofem";
  _id_6F73DA30B05233CF = scripts\engine\utility::create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_threemovers";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_youhavethreetargets";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_gotthreeofem";
  _id_1F482860B3A09741 = scripts\engine\utility::create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_twotargets";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_justtwoofem";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_gottwomovers";
  _id_ACE6C922483A5B0B = scripts\engine\utility::create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_oneenemy";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_lasttarget";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_justoneofem";
  _id_9071EE6F260633FD = scripts\engine\utility::create_deck(aliases, 1, 1);
  alias = undefined;

  switch (_id_91EC10CFA1F47A1E.size) {
    case 5:
      alias = _id_40EF6C6D5E20FE5F scripts\engine\utility::deck_draw();
      break;
    case 4:
      alias = _id_6F73DA30B05233CF scripts\engine\utility::deck_draw();
      break;
    case 3:
      alias = _id_1F482860B3A09741 scripts\engine\utility::deck_draw();
      break;
    case 2:
      alias = _id_ACE6C922483A5B0B scripts\engine\utility::deck_draw();
      break;
    case 1:
      alias = _id_9071EE6F260633FD scripts\engine\utility::deck_draw();
      break;
  }

  if(isDefined(alias))
    _id_48F20B0FE71DD6DF::_id_775CD164C569E279(alias, 0.6);
}

_id_D28A3C1951CB2D9D(item) {
  if(isDefined(level._id_DA3425E2AF49FABD) && level._id_DA3425E2AF49FABD + 6000 > gettime()) {
    return;
  }
  level._id_DA3425E2AF49FABD = gettime();
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_11cruisemissileisrea";
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_12cruisemissileisrea";
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_cruisemissilesarmeda";
  _id_E3C53B3C826BABAE = scripts\engine\utility::create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_11ihaveastealthbombe";
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_12ihaveastealthbombe";
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_breakersendingyouali";
  stealth = scripts\engine\utility::create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_watcher1tobreakerjlt";
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_breaker1sendingajltv";
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_breakerbeadvisedmypi";
  _id_7B147BFA44B8941D = scripts\engine\utility::create_deck(aliases, 1, 1);
  _id_DAB99680F619EC65 = "dx_cp_lone_loit_sghp_thisissender31jugger";
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_enjoythat";
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_yourewelcome";
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_suitup";
  _id_5FD6354ED65F28C4 = scripts\engine\utility::create_deck(aliases, 1, 1);
  alias = undefined;
  _id_7E9CCC2D6DDB44DA = undefined;

  switch (item) {
    case "cruise_predator":
      alias = _id_E3C53B3C826BABAE scripts\engine\utility::deck_draw();
      break;
    case "auto_drone":
      alias = stealth scripts\engine\utility::deck_draw();
      break;
    case "armoredtruck":
      alias = _id_7B147BFA44B8941D scripts\engine\utility::deck_draw();
      break;
    case "juggernaut":
      alias = _id_5FD6354ED65F28C4 scripts\engine\utility::deck_draw();
      break;
    default:
      alias = undefined;
  }

  if(isDefined(alias))
    _id_48F20B0FE71DD6DF::_id_775CD164C569E279(alias, 0.4);

  if(isDefined(_id_7E9CCC2D6DDB44DA))
    _id_48F20B0FE71DD6DF::_id_775CD164C569E279(_id_7E9CCC2D6DDB44DA, 0.3);
}

_id_D225398F9F720297(player) {
  level endon("game_ended");
  level waittill("geiger_given", player);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_onlyonethingthatsfor";
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_thatmeansthecartelco";
  found = scripts\engine\utility::create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_usethatgeigercounter";
  aliases[aliases.size] = "dx_cp_lone_loit_lasw_useittolocateanynucl";
  _id_7E9CCC2D6DDB44DA = scripts\engine\utility::create_deck(aliases, 1, 1);
  _id_48F20B0FE71DD6DF::_id_775CD164C569E279(found scripts\engine\utility::deck_draw(), 0.3);
  _id_48F20B0FE71DD6DF::_id_775CD164C569E279(_id_7E9CCC2D6DDB44DA scripts\engine\utility::deck_draw(), 0.3);
  level waittill("geigerIntelGiven", player);
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_goodfindillgetisaont";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_goodworkwellgetthisa";
  aliases[aliases.size] = "dx_cp_lone_low1_lasw_goodeyesnowwellknoww";
  _id_48F20B0FE71DD6DF::_id_775CD164C569E279(scripts\engine\utility::random(aliases));
}

_id_6E684EA81094C86E() {
  wait 1;

  if(scripts\engine\utility::cointoss())
    _id_48F20B0FE71DD6DF::_id_775CD164C569E279("dx_cp_lone_low6_lasw_allstationsthisiswat");
  else
    _id_48F20B0FE71DD6DF::_id_775CD164C569E279("dx_cp_lone_low6_lasw_watcher1tobreaker1th");

  _id_48F20B0FE71DD6DF::_id_775CD164C569E279("dx_cp_lone_low6_lasw_watcher1toallvictors");
  aliases = [];
  aliases[aliases.size] = "dx_cp_lone_low6_lasw_weneedtolocatewhatth";
  aliases[aliases.size] = "dx_cp_lone_low6_lasw_weneedtolocatewhatth_01";
  aliases[aliases.size] = "dx_cp_lone_low6_lasw_findwhatthecartelwas";
  _id_48F20B0FE71DD6DF::_id_775CD164C569E279(scripts\engine\utility::random(aliases));
  scripts\engine\utility::flag_set("outro_vo_done");
}

_id_9E03BD2DA38049B3() {
  allies = getaiarray("allies");
  return allies;
}

_id_622EB9CC0D8F7EE0(_id_289A76230AF54E08) {
  allies = getaiarray("allies");

  if(isvector(_id_289A76230AF54E08))
    allies = sortbydistance(allies, _id_289A76230AF54E08);
  else
    allies = sortbydistance(allies, _id_289A76230AF54E08.origin);

  return allies;
}

_id_B503F79125BF989E(_id_F26D6E29F4EFC048, _id_FDC54FCAE8FDD9E7) {
  foreach(item in level._id_215CD837F06FA79E._id_DEF74253F2C565A1[_id_F26D6E29F4EFC048]) {
    if(isstring(item)) {
      if(issubstr(item, _id_FDC54FCAE8FDD9E7) || issubstr(_id_FDC54FCAE8FDD9E7, item))
        return 1;
    }
  }

  return 0;
}