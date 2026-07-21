/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_payload\cp_objs_payload.gsc
**************************************************/

registerpayloadvfx() {
  level._effect["_encstr_9399128335CB9F0959C2A07F58D4D86A5F5ACFEB"] = loadfx("_encstr_AAA72D53B882BF0277836D3305113EAB6BF8BB8F58D03E3A8128C6AA7E57224FB190070BB070615283C0DA35DCDDBB");
  level._effect["_encstr_919912058EF819E75F434028AA2308B8D5E7CF05"] = loadfx("_encstr_85D32DBE522398806F10AF4EC1294777CB096B6CE7F0047488598EA39ECFD6425CA018415E2D2F3FE147E2EED3A178");
  level._effect["_encstr_8F9912D37CA1A12871A8DBCF7009CFDA7304111A"] = loadfx("_encstr_99CE2D8B30A89FEC53627D98115378524D8F40A94A10338220E9A1736A18A24DC411B85150C3F9FFB7389AEA7E0130");
  level._effect["_encstr_8DB311673387EB0E852F8DB70B32D719ACE6D1"] = loadfx("_encstr_9AA1255E2928678BE49B6E56EFAAEED3250298E7CF563B033381F8695F3188996B843422FCAD88");
  level._effect["_encstr_8BB9147853B02E21AAE89910C6D2373370FFA9439754"] = loadfx("_encstr_BEDE389339CB46A4B8794F75C152ECE779D05B3BC32D371CA21D6E58875874379D692267A3E8A355A80F655CEF50B813C9C06B1A50D89ACBB831");
}

registerpayloadobjective() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  thread registersquadspawners();
  scripts\cp\cp_objectives::registerobjective("_encstr_8D390C38162A378BE19F1010E73C", ::initpayloadobj, ::startpayloadobj, ::completepayloadobj, undefined, ::debugpayloadobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("_encstr_8E5616C85A1089B8DF04C85D1D4F037D7D233970F26DDF73", undefined, ::_id_13868, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_859D0E0F6EA3E9C049B3E138EB66D831", undefined, ::_id_13865, ::hint_obj_name, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_879F1B15819897C30F4B031763A579E678484D91B90863BBDE0F5F3741", undefined, undefined, undefined, undefined);
}

_id_13868(var_0, var_1) {
  if(!scripts\engine\utility::flag_exist("_encstr_95E2150EC2CB1BDE58C8AFA316E6ADDCBEB696B163B232"))
    scripts\engine\utility::flag_init("_encstr_95E2150EC2CB1BDE58C8AFA316E6ADDCBEB696B163B232");

  scripts\engine\utility::flag_wait("_encstr_95E2150EC2CB1BDE58C8AFA316E6ADDCBEB696B163B232");
  thread scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
}

initpayloadobj(var_0, var_1) {
  setDvar("_encstr_A3C00A15E94D45352D6A2AD3", 0);
  level.initlocationcircle = "_encstr_8D390C38162A378BE19F1010E73C";
  level.initlethalmaxoffsetmap = "_encstr_8D390C38162A378BE19F1010E73C";
  scripts\engine\utility::flag_init("_encstr_95E2150EC2CB1BDE58C8AFA316E6ADDCBEB696B163B232");
  scripts\engine\utility::flag_init("_encstr_AF451639AE45E713DF66450726774A99AB3757F8CBD8932D");

  if(!istrue(scripts\engine\utility::flag("_encstr_8430170EB0BFCB0B9012A0E8AA2DC5408F4B0DF32EFF96577A")))
    scripts\engine\utility::flag_set("_encstr_8430170EB0BFCB0B9012A0E8AA2DC5408F4B0DF32EFF96577A");

  scripts\engine\utility::flag_wait("_encstr_A54D21DE700F7BBB2042F098DA7D75F05FBBDD437E8FC6878A9998E062D231A9F3256D");
  scripts\engine\utility::flag_wait("_encstr_AF06233B6E41588852DBEFBFA37ACCF0CF0703701694B8B0FAFFF785EFE21B509C5F6BE97F");
  scripts\cp\utility::skydivestreamhintdvars("_encstr_A1D0081CC297B1EDB08C");
  var_0.apcwid = scripts\cp\cp_objectives::requestworldid("_encstr_92D50C5BE84E69380322969BFAF3");
  var_2 = scripts\engine\utility::getStruct("_encstr_9536154338033C3F29295F887640699B3349B284363F07", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_setplayintro(var_0.apcwid, 1);
  objective_state(var_0.apcwid, "_encstr_AF5A081BBAC993AC73A3");
  objective_icon(var_0.apcwid, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setzoffset(var_0.apcwid, 64);
  objective_position(var_0.apcwid, var_2.origin);
  objective_setlabel(var_0.apcwid, &"_encstr_A7BD1680310F7DA3EC30C8D12BF44F36D1326819019762B3");
  objective_sethot(var_0.apcwid, 0);
  var_0.ispayloadstunned = 0;
  var_0.apc_destroyed = 0;
  level thread spawnapc(var_0);
  var_0 waittill("_encstr_BD920C018178B1A757590B6221A5");
  scripts\cp\cp_objectives::_id_11F80(var_0.apcwid);
  var_0.timesapchitbymine = 0;
  var_0.rpgambusherskilled = 0;
  var_0.usepingsystem = 0;

  if(getdvarint("_encstr_B82015E6D827D7C1C2BCD87B5823BE73F6EB6BA5DC2B9B", 0) <= 0)
    spawnatmines(var_0);
}

select_top_roof_spawners(var_0) {
  thread aigroundturret_shouldbegindismountturret();
}

aigroundturret_shouldbegindismountturret() {
  self endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_8B7205D9ED5958", 5);
  wait 1;
  self.goalradius = 512;
  self.goalheight = 48;
}

_id_12DC2(var_0) {
  if(isDefined(self.spawnpoint.script_noteworthy) && self.spawnpoint.script_noteworthy == "_encstr_A11904E483B3")
    thread _id_132AF();
}

_id_132AF(var_0) {
  self endon("_encstr_AD75063D571AE108");

  while(!isDefined(level.apc))
    wait 1;

  var_1 = 122500;
  self waittill("_encstr_8B7205D9ED5958");
  self setentitytarget(level.apc);
  self.a.rockets = 100;

  for(;;) {
    var_2 = 0;

    foreach(var_4 in level.players) {
      if(distancesquared(var_4.origin, self.origin) < var_1) {
        self clearentitytarget();
        self allowedstances("_encstr_B13D076BED70539F23", "_encstr_A5AD069B231F0BAF", "_encstr_922406F1A6FD5E05");
        self.script_origin_other = undefined;
        self.goalradius = 2048;
        return;
      }
    }

    wait 0.1;
  }
}

startpayloadobj(var_0, var_1) {
  scripts\engine\utility::flag_set("_encstr_B28C0FB183EB85C9B6E64EC26C95AF6C37");
  scripts\engine\utility::flag_wait("_encstr_960E19A6B84EA03D4768D36F0247803180B9C79F1080B9D2433711");
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  scripts\engine\utility::flag_wait("_encstr_BA621EF9AE385F124B982A8120BD4BDF739F43644BED631A0FD062FAF0D14793");
  level thread _id_138C7();
  level thread _id_1380B();
  level thread _id_13976();
  scripts\cp\cp_create_script_utility::_id_13529("_encstr_968118030E80C9071F39F123C55888684F7080B3416E788C1383");
  wait 2;
  level thread watchforplayerproximity("_encstr_9A8507BA4040188D08", var_0);
  level thread _id_14462(var_0.apc);
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_87830FAFCE034960E91381FA170CF9857B");
  level.computer_debugtestloop = undefined;
  var_0.apc thread _id_144AB();
  var_0.apc thread watchatminehitonpayload(var_0);
  var_0.apc thread watchforminewarning("_encstr_8384151AB7FBCA7F39385F9F78F02DA18FDFE2152B6DB2");
  var_0.apc thread _id_144BB();
  var_0.apc thread watchforpayloadongoal("_encstr_A39B0DF9DF5E75E0DADFB9E9882A59");
  var_0.apc thread _id_144B3("_encstr_823514E00BCB63F6C291FA99D29CDCA37DB1272CE895", "_encstr_A5460D0648B381D09829D70D83B73A");
  var_0.apc thread _id_144B3("_encstr_AF2C153313594897BFC19F0F8D3ED7856DD10FAB07055B", "_encstr_86460D85C1D8BE2BB91BB7933AAF8C");
  level waittill("_encstr_AF6A1C906FF26B0D13E8319B986B46332945373EF37BEF1347F8DA82D84B");
}

completepayloadobj(var_0) {
  scripts\cp\cp_objectives::freeworldid("_encstr_92D50C5BE84E69380322969BFAF3");

  if(istrue(var_0.pathdist)) {
    return;
  }
  if(!istrue(var_0.apc_destroyed))
    level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AB3A2A5773EF62283399BBF76068CF8A490611CA5321FA54DE30B7AB934097A3C328E489CF79529EA1C99E42", "_encstr_9A8507BA4040188D08");

  level thread scripts\cp\utility::_id_123FE("_encstr_95DF19ADEA9BD7C61CBEB093D637C958C656F58583B1AF917BDCB2");
}

_id_13865(var_0) {
  if(!istrue(scripts\engine\utility::flag_exist("_encstr_960E19A6B84EA03D4768D36F0247803180B9C79F1080B9D2433711")))
    scripts\engine\utility::flag_init("_encstr_960E19A6B84EA03D4768D36F0247803180B9C79F1080B9D2433711");

  scripts\engine\utility::flag_set("_encstr_B28C0FB183EB85C9B6E64EC26C95AF6C37");
  scripts\engine\utility::flag_wait("_encstr_960E19A6B84EA03D4768D36F0247803180B9C79F1080B9D2433711");
  thread _id_1364E();
  level waittill("_encstr_99D81368CB605C77355B8A23C60DFF955BD717EE55");
}

hint_obj_name(var_0) {
  wait 4;

  foreach(var_2 in level.players) {
    var_2 thread scripts\cp_mp\xmike109::screenent_d("_encstr_B8E508DA7711DAB4F8A8");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var_2 thread scripts\cp_mp\xmike109::scriptable_callback("_encstr_974E0C0EB01B0B32D2B97DADF632");
        continue;
      }

      var_2 thread scripts\cp_mp\xmike109::scriptable_callback("_encstr_AFF3105B0EDAE6F4AA18096F484D0ECC89E1");
    }
  }

  scripts\cp\cp_achievement::update_achievement_all_players("_encstr_A5010A6214AA72111592A844", 1);
  scripts\cp\cp_achievement::update_achievement_all_players("_encstr_88790841A4862D62A29A", 1);
  thread scripts\cp\cp_objectives::screenent_c("_encstr_8666105BC2D4F69CEBF64C53ACB18EA5B395");
  level thread mp_shipment_patch();
  wait 3;
  level thread[[level.endgame]]("_encstr_9A8507BA4040188D08", level.end_game_string_index["_encstr_91190447C232"]);
}

mp_shipment_patch() {
  foreach(var_1 in level.players)
  var_1 thread scripts\mp\vehicles\vehicle_damage_mp::_id_1340D(2, 1, 1);

  wait 2;

  foreach(var_1 in level.players) {
    if(!istrue(var_1.try_to_punish_with_jugg)) {
      var_1.invulnerable = 1;
      var_1 allowmovement(0);
    }

    var_4 = scripts\engine\utility::getStruct("_encstr_868A1738E37F13DB8315B04FEF192B18AC27A0F01F270993EA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_5 = var_4.origin;
    var_6 = scripts\engine\utility::getStruct(var_4.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5);
    var_7 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_7.angles = var_4.angles;
    var_7 moveTo(var_6.origin, 20, 1, 1);
    var_1 playerhide();
    var_1 allowfire(0);
    var_1 disableoffhandweapons();
    var_1 disableusability();
    var_1 allowmovement(0);
    var_1 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
    var_1 spawn_endgame_camera(var_7);
    var_1 lerpfovscalefactor(0, 0);
  }
}

spawn_endgame_camera(var_0) {
  self.ignoreme = 1;
  self cameralinkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  self setclientdvar("_encstr_A3D20B62A25A2854A94194A839", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer())
    self setclientdvar("_encstr_B14A0A4545A9412AC9133D26", "_encstr_82070322E1");
}

managejumpmasterinfodisplay() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level scripts\engine\utility::waittill_notify_or_timeout("_encstr_AC08166B0F9307D8A51A2638839C6048F9C3F787DBAA58A8", 5);
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AAFE1DF2700F766BCB30ECF136900F3EB950C96B10D52C9FA305C5E6C073FA", "_encstr_9A8507BA4040188D08");
  wait 2;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AD311F23C3EB361CCDBE3A851BF6D7B083B1BE8EC273B6D79B1D161D5D6EAF130C", "_encstr_9A8507BA4040188D08");
  wait 2;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_96311F57F17FB6F0A3AF3B4F39A7311159205FD36162EA893323B663A8CB716202", "_encstr_9A8507BA4040188D08");
}

_id_13846(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_0);
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_833D0FDA7EEF5DE0589267ABE7C3DAA093");
}

toggle_player_pos_memory(var_0, var_1) {
  if(!istrue(scripts\engine\utility::flag("_encstr_8430170EB0BFCB0B9012A0E8AA2DC5408F4B0DF32EFF96577A")))
    scripts\engine\utility::flag_set("_encstr_8430170EB0BFCB0B9012A0E8AA2DC5408F4B0DF32EFF96577A");

  scripts\engine\utility::flag_wait("_encstr_A54D21DE700F7BBB2042F098DA7D75F05FBBDD437E8FC6878A9998E062D231A9F3256D");
  scripts\engine\utility::flag_wait("_encstr_AF06233B6E41588852DBEFBFA37ACCF0CF0703701694B8B0FAFFF785EFE21B509C5F6BE97F");
  scripts\engine\utility::flag_init("_encstr_B844197716DB91A821ABC9A8F77620E772316670EDA349D11CC718");
}

_id_13866(var_0, var_1) {
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B8ED155B90B2CC526B9D61A470099A875BA06F9318892C");
  wait 30;
  level thread maxplunder();
  wait 40;
  thread _id_13609();
  scripts\engine\utility::flag_set("_encstr_B844197716DB91A821ABC9A8F77620E772316670EDA349D11CC718");
  wait 20;
}

hint_outline_target_think(var_0) {
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_9ACA29A102B0FB6BA32968695526AF5F8701585AFCE997F18F1543ECE5E01F8472852CA13A1258BB2F2E8A", "_encstr_9A8507BA4040188D08");
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_810E166A884D4117C331F30ADF09CF9983B023337833066B");
  wait 2;
}

maxplunder() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_ACAD20E11B311F701B5790CB75672F6B6BFE40E3FA49F081C7465C48BB45B7EFD72E", "_encstr_9A8507BA4040188D08");
  wait 30;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B6AD20190FAFC68337AFA1951B7BD75883C6FA385A1BDE1DBE9B3A16D1BADCFA2353", "_encstr_9A8507BA4040188D08");
}

mark_as_bomb_vest_controller_holder(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_0);
  var_1 = scripts\engine\utility::getStruct("_encstr_8C641107C2971BB72C32AF165AD759E1334B1B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  foreach(var_4 in var_2)
  var_4 thread _id_12CD0(var_1.origin);
}

_id_12CD0(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self.goalradius = 64;
  self setgoalpos(var_0);
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_8B7205D9ED5958", 60);
  self dodamage(self.health + 100, self.origin);
}

watchforminewarning(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = scripts\engine\utility::getStruct(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  for(;;) {
    if(distance2d(var_1.origin, self.origin) <= 200) {
      break;
    }

    wait 1;
  }

  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B28A1D32C3EB8DC1B9BE8EC26CBDAF2C0736D76BA5DC56FAE695CA37F59806", "_encstr_9A8507BA4040188D08");
}

_id_144AB() {
  thread watchforpayloadspawngroup("_encstr_9B360AA7C60B4178F11B79F2", ["_encstr_8D750BA293B789CC7330B38312", "_encstr_99E8128E082D4A13AF30B856A6A8ABCA33DF5699", "_encstr_AC6412080FF1085F6A6FC0DE0762A1105F9BE98A"]);
  thread watchforpayloadspawngroup("_encstr_A7360A0E58CB36ED0B91EB91", "_encstr_82A1178BDEF1E838820B1F4D0F4AF4708FF216E1825FE86F7F", "_encstr_A25513D2172BA3471A9A9F53B372D1B0CD8090C73F");
  thread watchforpayloadspawngroup("_encstr_AB360A52FFA39237714017BE", "_encstr_85D519B8223339B0434C4F4A8027D56BA818AF6CDDD0857FC1594E");
  thread watchforpayloadspawngroup("_encstr_8B1511F84B40952F271151BABB0EB7CCC82969", "_encstr_A955131C0BE58DDB0B467D16C1C6D7432B365AF58C");
  thread watchforpayloadspawngroup("_encstr_B80C1593FFA318285E4C4F80575BB9C3A3082060478ACB");
}

registersquadspawners() {
  if(!scripts\engine\utility::flag_exist("_encstr_AF06233B6E41588852DBEFBFA37ACCF0CF0703701694B8B0FAFFF785EFE21B509C5F6BE97F"))
    scripts\engine\utility::flag_init("_encstr_AF06233B6E41588852DBEFBFA37ACCF0CF0703701694B8B0FAFFF785EFE21B509C5F6BE97F");

  if(scripts\engine\utility::flag_exist("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B"))
    scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  if(!scripts\engine\utility::flag_exist("_encstr_A54D21DE700F7BBB2042F098DA7D75F05FBBDD437E8FC6878A9998E062D231A9F3256D"))
    scripts\engine\utility::flag_init("_encstr_A54D21DE700F7BBB2042F098DA7D75F05FBBDD437E8FC6878A9998E062D231A9F3256D");

  scripts\engine\utility::flag_wait("_encstr_A54D21DE700F7BBB2042F098DA7D75F05FBBDD437E8FC6878A9998E062D231A9F3256D");
  var_0 = scripts\cp\cp_modular_spawning::registerambientgroup;
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8F7711073340377375F7E783D91EEA4F90FB3F", 2, 2, 2, 0.1, undefined, "_encstr_8F7711073340377375F7E783D91EEA4F90FB3F");
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A25513D2172BA3471A9A9F53B372D1B0CD8090C73F", 0, 6, 6, 0.1, undefined, "_encstr_A25513D2172BA3471A9A9F53B372D1B0CD8090C73F", undefined, undefined, 40);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A955131C0BE58DDB0B467D16C1C6D7432B365AF58C", 0, 6, 6, 0.1, undefined, "_encstr_A955131C0BE58DDB0B467D16C1C6D7432B365AF58C", undefined, undefined, 40);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_912E1488C362A1C34329CF5F7ACA398BD71718A0B31B", 4, 4, 4, 0.1, undefined, "_encstr_912E1488C362A1C34329CF5F7ACA398BD71718A0B31B", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AB0C131BB7E8FA07854EB08E4E7BEDE0B2936E7D62", 4, 4, 4, 0.1, undefined, "_encstr_AB0C131BB7E8FA07854EB08E4E7BEDE0B2936E7D62", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_990C1336F6D1F5C1B0C90BD1C9EDEDC159C99B7D64", 4, 4, 4, 0.1, undefined, "_encstr_990C1336F6D1F5C1B0C90BD1C9EDEDC159C99B7D64", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9B0C13D8DBE87D1C8539163AC97BF638564EDCBE99", 4, 4, 4, 0.1, undefined, "_encstr_9B0C13D8DBE87D1C8539163AC97BF638564EDCBE99", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B872154EABF33BA3B723D0404FB4FB776A92CD5682B95B", 4, 4, 4, 0.1, undefined, "_encstr_B872154EABF33BA3B723D0404FB4FB776A92CD5682B95B", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AC72158B6BE0A9931F23E773278B0AA017C8C5838F4F6A", 4, 4, 4, 0.1, undefined, "_encstr_AC72158B6BE0A9931F23E773278B0AA017C8C5838F4F6A", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_917215EEA04F88D3C77721BB18B1CB98774187982F2967", 4, 4, 4, 0.1, undefined, "_encstr_917215EEA04F88D3C77721BB18B1CB98774187982F2967", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AC6412080FF1085F6A6FC0DE0762A1105F9BE98A", 0, 6, 6, 0.1, 6, "_encstr_AC6412080FF1085F6A6FC0DE0762A1105F9BE98A", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8D750BA293B789CC7330B38312", 0, 3, 3, 0.1, undefined, "_encstr_8D750BA293B789CC7330B38312", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_99E8128E082D4A13AF30B856A6A8ABCA33DF5699", 0, 2, 2, 0.1, undefined, "_encstr_99E8128E082D4A13AF30B856A6A8ABCA33DF5699", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_82A1178BDEF1E838820B1F4D0F4AF4708FF216E1825FE86F7F", 0, 3, 6, 0.1, undefined, "_encstr_82A1178BDEF1E838820B1F4D0F4AF4708FF216E1825FE86F7F", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_85D519B8223339B0434C4F4A8027D56BA818AF6CDDD0857FC1594E", 0, 3, 6, 0.1, undefined, "_encstr_85D519B8223339B0434C4F4A8027D56BA818AF6CDDD0857FC1594E", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_87830FAFCE034960E91381FA170CF9857B", 0, 7, 14, 0.1, undefined, "_encstr_87830FAFCE034960E91381FA170CF9857B", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A6C30F18A7E70DAF9B35507241E940C675", 0, 5, 12, 0.1, undefined, "_encstr_A6C30F18A7E70DAF9B35507241E940C675", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_953215E0C25EB1DB0B8CEB9BBAE0B239EBE6DC961CCA39", 0, 1, 2, 0.1, undefined, "_encstr_953215E0C25EB1DB0B8CEB9BBAE0B239EBE6DC961CCA39", undefined, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_AB1212382C971BBDB0C8BEB9D507B239AF4E07D9", 0, 1, 3, 0.1, undefined, "_encstr_AB1212382C971BBDB0C8BEB9D507B239AF4E07D9", undefined, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_88D11A11F7BB24608BECB85F097B4448AD1C7B7DF33FB787991DE94B", 4, 4, 4, 0.1, undefined, "_encstr_88D11A11F7BB24608BECB85F097B4448AD1C7B7DF33FB787991DE94B", undefined, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_978E0D2B20DB3D9F31254F61CB182B", 0, 5, 6, 0.1, undefined, "_encstr_978E0D2B20DB3D9F31254F61CB182B", undefined, undefined);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_9686101CB0E563ED8523BEC2073A48C6913B", 2, 2, 6, 0.1, undefined, "_encstr_9686101CB0E563ED8523BEC2073A48C6913B", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8AC90C1999D8EE33B56161BBAB1C", 2, 2, 4, 0.1, undefined, "_encstr_8AC90C1999D8EE33B56161BBAB1C", undefined, undefined, 60);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_937A13E02C2FB1BD16C8D723CA0B6356C96E43A583", 0, 8, 10, 0.1, undefined, "_encstr_937A13E02C2FB1BD16C8D723CA0B6356C96E43A583", undefined, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_8D240EC1C2E536DEC2467DCDEAE0AC9C", 10, 12, 18, 0.1, undefined, "_encstr_8D240EC1C2E536DEC2467DCDEAE0AC9C", undefined, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_B2050C08D03FC769D8A91548217E", 0, 3, 3, 0.1, undefined, "_encstr_B2050C08D03FC769D8A91548217E", undefined, undefined, 10);
  scripts\cp\cp_modular_spawning::registerambientgroup("_encstr_A6050C587BC1171F3338D7D7163F", 0, 3, 3, 0.1, undefined, "_encstr_A6050C587BC1171F3338D7D7163F", undefined, undefined, 10);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B2050C08D03FC769D8A91548217E", ::_id_12DC2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A6050C587BC1171F3338D7D7163F", ::_id_12DC2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8D750BA293B789CC7330B38312", ::_id_12DC2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8AC90C1999D8EE33B56161BBAB1C", ::_id_12DC2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8F7711073340377375F7E783D91EEA4F90FB3F", ::_id_12DC2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_99E8128E082D4A13AF30B856A6A8ABCA33DF5699", ::select_top_roof_spawners);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_82A1178BDEF1E838820B1F4D0F4AF4708FF216E1825FE86F7F", ::_id_12DC2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_85D519B8223339B0434C4F4A8027D56BA818AF6CDDD0857FC1594E", ::_id_12DC2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AB1212382C971BBDB0C8BEB9D507B239AF4E07D9", ::_id_12DC2);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_953215E0C25EB1DB0B8CEB9BBAE0B239EBE6DC961CCA39", ::select_top_roof_spawners);
  scripts\engine\utility::flag_set("_encstr_AF06233B6E41588852DBEFBFA37ACCF0CF0703701694B8B0FAFFF785EFE21B509C5F6BE97F");
}

brclampdamage(var_0) {
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8D390C38162A378BE19F1010E73C");

  if(!isDefined(var_1.watch_for_players_entering_area_earlier))
    var_1.watch_for_players_entering_area_earlier = -9999;

  if(gettime() - var_1.watch_for_players_entering_area_earlier < 15000) {
    return;
  }
  var_2 = "_encstr_A1A719A003514F835FC7A517D3072E13C2DA01100A3599B8BFF438";
  var_3 = "_encstr_B40101";

  switch (var_0.group_name) {
    case "_encstr_857C13A3684A049AB345A95AB547A38156A84F7358":
      var_3 = "_encstr_BE22075B801D606B09";
      break;
    case "_encstr_BEA914FBF0475BD821257757B310FA61A778F3D070A0":
      var_3 = "_encstr_8E0E0710FD03C91047";
      break;
    case "_encstr_8101130E58F236DB0B91D76E8EB7C119D7C659661D":
      var_3 = "_encstr_BE22075B801D606B09";
      break;
    case "_encstr_971C14E7375322D830EB11403967DF351FBDD3EFA421":
      var_3 = "_encstr_8E0E0710FD03C91047";
      break;
    case "_encstr_870913607F3BF4CD698C81A6CD9732EBEF8DE05484":
      var_3 = "_encstr_AD2E06DDCA6ED1EB";
      break;
    case "_encstr_876314382C9763DEB023FACDD1DBC166D739A5EC868E":
      var_3 = "_encstr_83530675726B7C07";
      break;
    case "_encstr_A78313E0B0E5B1F60B91D737D17B0E687D635699E8":
      var_3 = "_encstr_AD2E06DDCA6ED1EB";
      break;
    case "_encstr_A9FF14018180B860578A2ED3F317A732510ABB97202B":
      var_3 = "_encstr_83530675726B7C07";
      break;
    default:
      break;
  }

  var_4 = scripts\engine\utility::string(randomintrange(1, 4)) + "_encstr_934C0218";
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team(var_2 + var_3 + var_4, "_encstr_9A8507BA4040188D08");
  var_1.watch_for_players_entering_area_earlier = gettime();
}

getnexthelispawnmodule(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8D390C38162A378BE19F1010E73C");

  if(istrue(var_1.usepingsystem))
    return undefined;

  for(var_2 = getaiarray("_encstr_8E8405EA382B2A").size; var_2 >= 24; var_2 = getaiarray("_encstr_8E8405EA382B2A").size)
    wait 6;

  var_3 = strtok(var_0.group_name, "_encstr_BA4C02DF");
  var_4 = int(var_3[var_3.size - 1]);
  var_4++;

  if(var_4 > 8)
    var_4 = 1;

  return "_encstr_AB330E51372381C0A1DF26D88784B850" + var_4;
}

reset_restock_flag(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8D390C38162A378BE19F1010E73C");

  if(istrue(var_1.usepingsystem))
    return undefined;

  wait 5;

  for(var_2 = getaiarray("_encstr_8E8405EA382B2A").size; var_2 > 18; var_2 = getaiarray("_encstr_8E8405EA382B2A").size)
    wait 1;

  var_3 = strtok(var_0.group_name, "_encstr_BA4C02DF");
  var_4 = scripts\engine\utility::ter_op(var_3[var_3.size - 1] == "_encstr_A5AD056A019C63", "_encstr_8253060E2B5FE330", "_encstr_A5AD056A019C63");
  var_5 = "_encstr_B40101";

  for(var_6 = 0; var_6 <= var_3.size - 2; var_6++)
    var_5 = var_5 + var_3[var_6] + "_encstr_BA4C02DF";

  var_5 = var_5 + var_4;
  return var_5;
}

reset_target_group(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8D390C38162A378BE19F1010E73C");

  if(istrue(var_1.usepingsystem))
    return undefined;

  for(var_2 = 0; var_2 <= 5; var_2++)
    wait 1;

  var_3 = undefined;

  if(!isDefined(level._id_11F6A))
    level._id_11F6A = 0;

  switch (var_0.group_name) {
    case "_encstr_AA440E1B31A393FD20F96732A96889AE":
      if(level._id_11F6A == 1)
        var_3 = "_encstr_AA440E1B31A393FD20F96732A96889AE";

      break;
    case "_encstr_85440ED06368BD171F3949E3C3649F62":
      if(level._id_11F6A == 2)
        var_3 = "_encstr_85440ED06368BD171F3949E3C3649F62";

      break;
    case "_encstr_AD440EA8283A49B0FFECC76BCB1466D6":
      if(level._id_11F6A >= 3)
        var_3 = "_encstr_AD440EA8283A49B0FFECC76BCB1466D6";

      break;
    default:
      var_3 = undefined;
      break;
  }

  return var_3;
}

getnextholdoutspawnmodule(var_0) {
  if(scripts\engine\utility::flag_exist("_encstr_B844197716DB91A821ABC9A8F77620E772316670EDA349D11CC718") && scripts\engine\utility::flag("_encstr_B844197716DB91A821ABC9A8F77620E772316670EDA349D11CC718"))
    return undefined;

  var_1 = 0;

  for(var_2 = getaiarray("_encstr_8E8405EA382B2A").size; var_2 > 15 || var_1 <= 5; var_2 = getaiarray("_encstr_8E8405EA382B2A").size) {
    wait 1;
    var_1++;
  }

  var_3 = undefined;

  switch (var_0.group_name) {
    case "_encstr_B8ED155B90B2CC526B9D61A470099A875BA06F9318892C":
      var_3 = "_encstr_BEAC16FBF0475BD82125773BDF70FF3F8D48E878713838A3";
      break;
    case "_encstr_BEAC16FBF0475BD82125773BDF70FF3F8D48E878713838A3":
      var_3 = "_encstr_B8ED155B90B2CC526B9D61A470099A875BA06F9318892C";
      break;
    default:
      var_3 = undefined;
      break;
  }

  return var_3;
}

_id_1293D(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  wait 4;
  thread scripts\cp\cp_modular_spawning::set_script_origin_other_to_center_of_players();
}

_id_12DCC(var_0) {
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8D390C38162A378BE19F1010E73C");
  var_2 = var_1.apc;

  if(isDefined(var_2))
    thread _id_12DCD(var_2);
}

_id_12DCD(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = self;
  var_1.goalradius = 1024;
  var_1 setgoalpos(var_0.origin);
  var_1 waittill("_encstr_8B7205D9ED5958");
  var_1 setentitytarget(var_0, 1);
}

_ambush_rpg_after_spawn(var_0) {
  thread ambush_rpg_after_spawn(var_0);
  thread watch_for_ambush_rpg_death();
}

watch_for_ambush_rpg_death() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8D390C38162A378BE19F1010E73C");
  self waittill("_encstr_AD75063D571AE108");
  var_0.rpgambusherskilled++;
}

ambush_rpg_after_spawn(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  wait 1;

  if(isDefined(self.spawnpoint.target)) {
    var_1 = scripts\engine\utility::getStruct(self.spawnpoint.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    self.goalradius = 40;

    if(isDefined(var_1)) {
      self.ignoreall = 1;
      self setgoalpos(var_1.origin);
      self waittill("_encstr_8B7205D9ED5958");
      self.ignoreall = 0;
    }
  }
}

_rpg_skit_after_spawn(var_0) {
  thread rpg_skit_after_spawn(var_0);
}

rpg_skit_after_spawn(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  waitframe();
  self.maxfaceenemydist = 768;
  self.dontevershoot = 1;
  self.ignoreall = 1;
  self.maxhealth = 99999;
  self.health = self.maxhealth;
  self.wearing_armor = 1;
  self.dontevershoot = 1;
  self.goalradius = 40;
  var_1 = scripts\engine\utility::getStruct("_encstr_96E116C7120321BA6ACB79D823EA810F87616D09E7378008", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;
  self setgoalpos(var_1);

  while(scripts\engine\utility::distance_2d_squared(self.origin, var_1) >= 4096)
    wait 0.5;

  thread watchtofirerocketatpayload(self);
}

watchtofirerocketatpayload(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.rpg_fire_pos = scripts\engine\utility::getStruct("_encstr_8C4A15DBF163533DE039A772D708C4BF0DAE632359BE4B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;
  fire_rpg_to_payload(var_0.rpg_fire_pos, 1);
  var_0.dontevershoot = 0;
  var_0.ignoreall = 0;
  var_0 animmode("_encstr_820E07FAE8780B3A4C");
  var_0.scripted_mode = 0;
  var_0.health = 100;
  var_0.maxhealth = 100;
}

fire_rpg_to_payload(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8D390C38162A378BE19F1010E73C");
  var_4 = var_3.apc;

  if(isDefined(var_4)) {
    var_5 = anglesToForward(var_4.angles);
    var_6 = var_4 vehicle_getspeed();
    var_7 = var_4.origin + (0, 0, 40) + var_5 * var_6 * get_forward_scalar(var_0, var_4, var_6);

    if(!var_1) {
      if(!isDefined(var_2))
        var_2 = (0, 0, 0);

      var_7 = var_7 + var_2;
    }

    var_8 = magicbullet("_encstr_81ED0FC9079DFAB55ADCCD96C659EBC60E", var_0, var_7);

    if(var_1) {
      var_8 missile_settargetEnt(var_4);
      var_8 missile_setflightmodedirect();
    }

    var_8 thread watchforrpgimpact(var_4);
  }
}

watchforrpgimpact(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  playFXOnTag(level._effect["_encstr_8DB311673387EB0E852F8DB70B32D719ACE6D1"], var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 playSound("_encstr_9A6C0FE238E127DF698122EBE08195D399");
  level notify("_encstr_9A560F6BD87E59AB3FD366C9EB0F5ED897");
}

get_forward_scalar(var_0, var_1, var_2) {
  var_3 = 1600;
  var_4 = 0.47;
  var_5 = distance(var_0, var_1.origin);
  var_6 = var_5 / var_3;
  return var_2 * var_6 * var_4;
}

watchforambushend() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8D390C38162A378BE19F1010E73C");
  var_1 = gettime();
  var_2 = 0;
  var_3 = 30000;

  while(!istrue(var_2) && gettime() - var_1 <= var_3) {
    if(var_0.rpgambusherskilled >= 4)
      var_2 = 1;

    wait 0.5;
  }

  level notify("_encstr_93AF1A282FD1287F8A8F20BE6202D7713DCB98B8B35F800B02B5254D");
}

spawnapc(var_0) {
  level.convoy_speed_override = 12;
  var_1 = scripts\engine\utility::getStruct("_encstr_9536154338033C3F29295F887640699B3349B284363F07", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = "_encstr_8DF7110290D745CB2943949F575166DB4B28CA";
  var_3 = "_encstr_87420C2E6337512BF1BFC2CA6234";
  var_4 = spawnStruct();
  var_4.origin = var_1.origin;
  var_4.angles = var_1.angles;
  var_4.owner = level.players[0];
  var_4.team = var_0.currentteam;
  var_4.cannotbesuspended = 1;
  var_5 = scripts\cp_mp\vehicles\apc_rus::apc_rus_create(var_4);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_deregisterinstance(var_5);
  level.apc = var_5;
  wait 2;
  var_0.apc = var_5;
  var_6 = var_1;
  var_5.pathing_array = [];
  var_5.pathing_array[0] = var_6.origin;
  _id_12C39(var_5);
  var_5 thread c4_crate_use();

  while(isDefined(var_6.target)) {
    var_6 = scripts\engine\utility::getStruct(var_6.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_5.pathing_array[var_5.pathing_array.size] = var_6.origin;
  }

  var_5.health = 30000;
  var_5._id_13BF2 = 30000;
  var_5._id_11E7D = 80;
  var_5.little_bird_mg_enterend = 1;
  var_7 = [];
  var_8 = var_5.pathing_array.size;
  var_9 = undefined;
  var_10 = var_1.origin;
  var_5.intro_safehouse_loot = scripts\engine\utility::ter_op(getdvarfloat("_encstr_86D7122B9E3AB17742BFB9B7F73A2808D0F71141", 0) > 0, getdvarfloat("_encstr_86D7122B9E3AB17742BFB9B7F73A2808D0F71141", 0), 2);

  for(var_11 = 0; var_11 < var_8; var_11++) {
    if(isDefined(var_5.pathing_array[var_11 + 1]))
      var_9 = var_5.pathing_array[var_11 + 1];

    var_12 = scripts\cp\cp_vehicles::get_duration_between_points(var_10, var_9, var_5.intro_safehouse_loot, 1);
    var_7[var_7.size] = min(var_12, 20);
    var_10 = var_9;
  }

  var_5 setlookaheadtime(0.2);
  var_5 startpathnodes(var_5.pathing_array, var_7);
  var_5.veh_pathtype = "_encstr_BA730C88AFF0FB9853CF40409352";
  var_0 notify("_encstr_BD920C018178B1A757590B6221A5");
  var_5 thread _id_144AC();
  var_5 thread watchforapcdeath();
  var_5 thread _id_144BE();
  var_5 thread _id_1446E(var_5);
  objective_setplayintro(var_0.apcwid, 0);
  objective_state(var_0.apcwid, "_encstr_AF5A081BBAC993AC73A3");
  objective_icon(var_0.apcwid, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setzoffset(var_0.apcwid, 64);
  objective_onentity(var_0.apcwid, var_5);
  apcstop(var_5);
}

_id_144BE() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_ABCF115807D8F527ACB01BD0B2917DB3DB2CD8");
  var_0 = self;

  for(;;) {
    wait 2;
    var_0 connectpaths();
    waitframe();
    var_0 disconnectPaths();
  }
}

_id_144AC() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = self;

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);

    if(isDefined(var_10) && isDefined(var_10.basename) && var_10.basename == "_encstr_85FE12D5B3CB57C99057295817CB46630251C65F") {
      self.health = self.health + var_1;
      continue;
    }

    var_1 = setup_soldier_stealth(var_10, var_5, var_1);
    var_0 thread losqueuelow(var_10);
    var_16 = var_0.health / var_0._id_13BF2 * 100;

    if(var_16 <= 75) {
      var_17 = 1;

      if(var_16 <= 50)
        var_17 = 2;

      if(var_16 <= 25)
        var_17 = 3;

      var_0 thread setdamagestate(var_17);
    }
  }
}

setup_soldier_stealth(var_0, var_1, var_2) {
  var_3 = var_2;

  if(!isDefined(var_0))
    return var_2;

  switch (var_0.basename) {
    case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
    case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
    case "_encstr_88F90EF65F8E7A1AEED5251AE97F9788":
      var_3 = var_3 / 4;
      break;
  }

  return var_3;
}

losqueuelow(var_0) {
  var_1 = self;

  if(!isDefined(self.watch_for_players_activating_juggmaze_map))
    var_1.watch_for_players_activating_juggmaze_map = -9999;

  if(gettime() - var_1.watch_for_players_activating_juggmaze_map < 15000) {
    return;
  }
  var_2 = var_1.health / var_1._id_13BF2 * 100;

  if(var_2 <= var_1._id_11E7D) {
    if(var_1._id_11E7D >= 60)
      level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A5781DB19B89CE83FB591BB17EDF4177D36F4FE997C282B1082FA128A3B009" + var_1._id_11E7D + "_encstr_931A04C92127", "_encstr_9A8507BA4040188D08");
    else if(var_1._id_11E7D <= 0)
      level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8CF422B87BC7F971BB5145C7B692E76130BFD9B0879EB077838337550B0B9F03D8B7220A", "_encstr_9A8507BA4040188D08");
    else
      level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B6C41D5773EF62283399BBF76068CF8A490611CB5725BA7F5BE8E7AB38C397" + var_1._id_11E7D + "_encstr_931A04C92127", "_encstr_9A8507BA4040188D08");

    if(!isDefined(var_1)) {
      return;
    }
    var_1._id_11E7D = max(var_1._id_11E7D - 20, 0);
    self.watch_for_players_activating_juggmaze_map = gettime();
  } else if(isDefined(var_0) && var_0.classname == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0") {
    level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_83AF19E1702F684F4BFF61531752AFB0B80E0EBB1A7FD10BC2BB3F" + randomintrange(1, 4) + "_encstr_934C0218", "_encstr_9A8507BA4040188D08");
    self.watch_for_players_activating_juggmaze_map = gettime();
  }
}

watchforplayerproximity(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_84801662CF7342E7A1B0E72728D99F8A135EEB9AA0DB6A34");
  var_2 = var_1.apc;
  var_2 endon("_encstr_96E9151F7EB3F9F07983F1906F9189099AA7AF2C556AB1");
  var_2 endon("_encstr_AD75063D571AE108");
  var_3 = "_encstr_8F79084EEB0211E38D73";
  var_4 = "_encstr_B40101";

  while(!istrue(var_1.apc_destroyed)) {
    if(istrue(var_1.ispayloadstunned) || istrue(var_1.updatebotpersonalitybasedonweapon) || istrue(var_1.turret_objective_think)) {
      var_4 = "_encstr_B40101";
      wait 2;
      continue;
    }

    var_5 = scripts\cp\utility::getplayersinteam(var_0);
    var_6 = 0;

    foreach(var_8 in var_5) {
      if(distance(var_8.origin, var_2.origin) <= 512)
        var_6++;
    }

    if(var_6 > 0 || istrue(var_1.updateassassinationthreatlevel))
      var_3 = "_encstr_ACC107AD988D31CD07";
    else
      var_3 = "_encstr_8F79084EEB0211E38D73";

    if(var_3 != var_4) {
      var_4 = var_3;

      if(var_3 == "_encstr_ACC107AD988D31CD07")
        level thread apcstart(var_2);
      else
        level thread apcstop(var_2);
    }

    wait 1;
  }
}

_id_14462(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8D390C38162A378BE19F1010E73C");
  var_2 = scripts\engine\utility::getStruct("_encstr_93F3137F29AFC08F0E1A994882A94FB92FD80D60D1", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(getdvarint("_encstr_82F012C337DDB95F40646B5FE8B0F1D6BA58B285", 0) <= 0) {
    while(isDefined(var_0) && distance(var_0.origin, var_2.origin) > 100)
      wait 0.5;
  }

  if(istrue(var_1.apc_destroyed)) {
    return;
  }
  var_1.shot_by_player = 1;
  var_1.updatebotpersonalitybasedonweapon = 1;
  apcstop(var_0);
  thread _id_13BAD(0);
  var_3 = getdvarint("_encstr_82F012C337DDB95F40646B5FE8B0F1D6BA58B285", 0);
  level notify("_encstr_AF6A1C906FF26B0D13E8319B986B46332945373EF37BEF1347F8DA82D84B");

  if(var_3 <= 1)
    level _encstr_B44A492B9FC804A35D03864A8B182FFE3027FF8311F94EE3893B4B92F1056EB698F33B1A4BB0978FA071C2DAD9E5AFAB48CFA3809F581A0F566B4AA261A8FFE6E8335B0C6B48673A746362::docache1();

  wait 1;

  if(!istrue(var_1.apc_destroyed))
    var_0 thread _id_11D90(var_1);

  if(var_3 <= 2)
    level _encstr_B44A492B9FC804A35D03864A8B182FFE3027FF8311F94EE3893B4B92F1056EB698F33B1A4BB0978FA071C2DAD9E5AFAB48CFA3809F581A0F566B4AA261A8FFE6E8335B0C6B48673A746362::docache2();

  scripts\cp\crate_drops\cp_crate_drops::_id_12C40("_encstr_8B460DDAC37EAF8F4027878211F9C2");

  if(var_3 <= 3)
    level thread _encstr_B44A492B9FC804A35D03864A8B182FFE3027FF8311F94EE3893B4B92F1056EB698F33B1A4BB0978FA071C2DAD9E5AFAB48CFA3809F581A0F566B4AA261A8FFE6E8335B0C6B48673A746362::docache4();

  level thread _id_1434F();
  level waittill("_encstr_B8A9206B637A1620D96669260E81F0C352C29FF3F382D0E0E47171F87561B80B0AEB");
  thread _id_13609();
  level waittill("_encstr_AF451639AE45E713DF66450726774A99AB3757F8CBD8932D");
  scripts\engine\utility::flag_set("_encstr_AF451639AE45E713DF66450726774A99AB3757F8CBD8932D");
}

_id_1434F() {
  scripts\engine\utility::flag_wait("_encstr_95E2150EC2CB1BDE58C8AFA316E6ADDCBEB696B163B232");
  scripts\engine\utility::flag_wait("_encstr_AF451639AE45E713DF66450726774A99AB3757F8CBD8932D");
  scripts\cp\cp_objectives::run_objective("_encstr_859D0E0F6EA3E9C049B3E138EB66D831");
}

_id_11D90(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = scripts\engine\utility::getStruct("_encstr_8AA81A070B978DB7C2C8EBCE7B851B7DEE1AA5C6B2FA1BC26C0DCA19", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;
  level waittill("_encstr_AB281AE146D0B7EAB37032A9488BE693890E5799565B67335B203A12");
  self notify("_encstr_B122124E2FDFE953AB50F347D840379299CB1547");
  var_0.updateassassinationthreatlevel = 1;
  var_0.updatebotpersonalitybasedonweapon = 0;

  while(distance(self.origin, var_1) > 100)
    wait 0.5;

  var_0.updateassassinationthreatlevel = 0;
  apcstop(self);
}

watchforpayloadspawngroup(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_3 = scripts\engine\utility::getStruct(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;

  while(distance(self.origin, var_3) > 100)
    wait 0.5;

  if(var_0 == "_encstr_B80C1593FFA318285E4C4F80575BB9C3A3082060478ACB")
    thread _id_13589();

  if(isDefined(var_1)) {
    if(isarray(var_1)) {
      foreach(var_5 in var_1) {
        scripts\cp\cp_modular_spawning::run_spawn_module(var_5);
        waitframe();
      }
    } else
      scripts\cp\cp_modular_spawning::run_spawn_module(var_1);
  }

  if(isDefined(var_2)) {
    if(isarray(var_2)) {
      foreach(var_8 in var_2) {
        scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_8);
        waitframe();
      }
    } else
      scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_2);
  }
}

_id_144C8(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_2 = scripts\engine\utility::getStruct(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;

  while(distance(self.origin, var_2) > 100)
    wait 0.5;

  level thread scripts\cp\cp_wave_spawning::killstreaks(0.5, var_1);
}

watchforpayloadconvoygroup(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_4 = scripts\engine\utility::getStruct(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;

  while(distance(self.origin, var_4) > 100)
    wait 0.5;

  start_convoy(var_1, var_2, var_3);
}

_id_144C7(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_4 = scripts\engine\utility::getStruct(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;
  var_5 = scripts\engine\utility::getStruct(var_1, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;
  var_6 = scripts\engine\utility::getStruct(var_2, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;
  var_7 = scripts\engine\utility::getStruct(var_3, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;
  level._id_11F6A = 0;

  while(distance(self.origin, var_4) > 100)
    wait 0.5;

  level._id_11F6A = 1;

  while(distance(self.origin, var_5) > 100)
    wait 0.5;

  level._id_11F6A = 2;

  while(distance(self.origin, var_6) > 100)
    wait 0.5;

  level._id_11F6A = 3;

  while(distance(self.origin, var_7) > 100)
    wait 0.5;

  level._id_11F6A = 4;
}

watchforrpgambush(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_96E9151F7EB3F9F07983F1906F9189099AA7AF2C556AB1");
  var_3 = scripts\engine\utility::getStruct(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;

  while(distance(self.origin, var_3) > 100)
    wait 0.5;

  var_2.ispayloadstunned = 1;
  apcstop(self);
  scripts\cp\cp_modular_spawning::run_spawn_module(var_1);
  scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_816F1897915B6188711B1148BD53130B6B577BEAA717557FF6E3");
  level thread maxpools();
  level thread watchforambushend();
  level scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_93AF1A282FD1287F8A8F20BE6202D7713DCB98B8B35F800B02B5254D", 30);
  scripts\cp\cp_modular_spawning::stop_module_by_id("_encstr_816F1897915B6188711B1148BD53130B6B577BEAA717557FF6E3");
  var_2.ispayloadstunned = 0;
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_81551D57E86F673912C9EB61B7FF98594B6666A8CDB7F23107C80F75D9E27B", "_encstr_9A8507BA4040188D08");
}

maxpools() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A1CD1A19F0F58D0EB9EBA3B01BEDAFB0076CD7C26B31EAB9D0AF4C18", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_BDB11D46F0F51B83CDD78E0BC6EDEB16E036FA8DC6CA2CE4D79C1C9DF59903", "_encstr_9A8507BA4040188D08");
  var_0 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("_encstr_9A8507BA4040188D08"));

  if(isDefined(var_0))
    wait(scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_A75B1620FA337647FCEB2090C31937C92B65A0A644C71B81"));
}

start_convoy(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = var_2;
  level thread set_convoy_settings(var_0, var_4, var_3);
}

set_convoy_settings(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var_4 = level[[var_3]](var_0, var_1, var_2);
  wait 1;
  var_4 notify("_encstr_AA0117D053B4796F8B1D1085F7A347E3E9A399708B59D3C3D3");
  var_4 scripts\cp\cp_convoy_manager::_id_1307D(0);
  level waittill("_encstr_8E76095022AA99515FE620" + var_0);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_distance(5000);
  var_4 thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);

  if(var_0 == "_encstr_966711D386998050FA6347C7B7F22450419173")
    var_4 thread vehomn_fadeoutcontrols();
}

vehomn_fadeoutcontrols() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  level thread scripts\cp\utility::_id_123FE("_encstr_B40101");
}

watchforpayloadongoal(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = scripts\engine\utility::getStruct(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;

  while(distance(self.origin, var_1) > 100)
    wait 0.5;

  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8D390C38162A378BE19F1010E73C");
  var_2.updateassassinationthreatlevel = 0;
  var_2.usepingsystem = 1;
  self notify("_encstr_96E9151F7EB3F9F07983F1906F9189099AA7AF2C556AB1");
  waitframe();
  var_2 thread apcstop(self);
  var_2 notify("_encstr_82381721A1E0D8B737EA4E70B223CD687B31A5F3770F78D84F");
  var_3 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam(var_2.currentteam));

  if(isDefined(var_3))
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_3, "_encstr_8B521166D81667DE39F536D8B76EACD8C28D36");
}

_id_144B3(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_2 = scripts\engine\utility::getStruct(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;

  while(distance(self.origin, var_2) > 100)
    wait 0.5;

  scripts\cp\crate_drops\cp_crate_drops::_id_12C40(var_1);
}

_id_144BB() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = scripts\engine\utility::getStruct("_encstr_BDDD11DBCE9B7A47E990C78A2F624BB97487EA", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = scripts\engine\utility::getStruct("_encstr_82DD1147C94039D85125A7990DCB1099843726", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2 = scripts\engine\utility::getStruct("_encstr_92DD11AB30DA699FDB65E811331B1C8FA581BE", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2)) {
    return;
  }
  while(distance(self.origin, var_0.origin) > 100)
    wait 0.5;

  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_880D21D9A8C03BC9684FAC9EDB3F67AE898601BB9033A7D0E168B019C84368F1B8AA67", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A1F6213C60DF6161A817F3B9CA5FE18A882131437C5290638F785BAE275BA3BA8E77F2", "_encstr_9A8507BA4040188D08");

  while(distance(self.origin, var_1.origin) > 100)
    wait 0.5;

  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A3AD200C13C172D903C09390E28899AB90AF6F62BA21AF4B678E3101234D23DF468A", "_encstr_9A8507BA4040188D08");

  while(distance(self.origin, var_2.origin) > 100)
    wait 0.5;

  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_85AD2078F28197924B674B5B6287B7EB702A779B87234FD417867B2748C3D3C662C9", "_encstr_9A8507BA4040188D08");
}

watchforapcdeath() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_96E9151F7EB3F9F07983F1906F9189099AA7AF2C556AB1");
  self waittill("_encstr_AD75063D571AE108");
  var_0 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8D390C38162A378BE19F1010E73C");
  var_0.apc_destroyed = 1;
  self playSound("_encstr_BD171577F85DBEA6EACE212B28C1A82BC154AC0F473BB1");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8C391EF5B0B7A1310A2940E0C225B739E353907501CBE827B792D0508AF1235B", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A56222C8E1FAD8E037F5B616B5C2FA2CC16CFA6B2DCD9BD2DEDCAF33B0A563B232F58981", "_encstr_9A8507BA4040188D08");
  var_0 notify("_encstr_84801662CF7342E7A1B0E72728D99F8A135EEB9AA0DB6A34");
  var_0 notify("_encstr_82381721A1E0D8B737EA4E70B223CD687B31A5F3770F78D84F");
  var_1 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam(var_0.currentteam));

  if(isDefined(var_1))
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "_encstr_973610CC1B0BCEDE27F59B2BB32C3A2DEC95");

  if(!isDefined(level.camper_damage_thread))
    level.camper_damage_thread = 0;

  if(level.camper_damage_thread <= 0) {
    scripts\cp\cp_objectives::_id_12868("_encstr_879F1B15819897C30F4B031763A579E678484D91B90863BBDE0F5F3741");
    level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);
    var_0.pathdist = 1;
  }
}

apcstop(var_0) {
  var_1 = getdvarfloat("_encstr_92B50EE68D93BEC20E6CD76E0E56CA46", var_0.intro_safehouse_loot);
  var_0 vehicle_setspeedimmediate(0, var_1, var_1);
}

apcstart(var_0) {
  var_1 = getdvarfloat("_encstr_92B50EE68D93BEC20E6CD76E0E56CA46", var_0.intro_safehouse_loot);
  var_0 resumespeed(var_1);

  if(!istrue(var_0.should_enter_combat_after_checking_throwingknife)) {
    var_0.should_enter_combat_after_checking_throwingknife = 1;
    level thread scripts\cp\utility::_id_123FE("_encstr_8FFA1BCFD013DFB26920CE0211579BA9B9C88F879049671A87C6553A85");
  }
}

spawnatmines(var_0) {
  var_1 = scripts\engine\utility::getStructArray("_encstr_BDAB11B7D61B5168E1EB896BC736E1FFF2FDA6", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_0.atmines = [];

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = "_encstr_81430B218B3F7018458997D78A";
    var_4 = magicgrenademanual(var_3, var_1[var_2].origin + (0, 0, 5), (0, 0, 10));
    var_4.owner = var_4;
    var_4.owner.team = "_encstr_8E8405EA382B2A";
    var_4.team = "_encstr_8E8405EA382B2A";
    var_0.atmines[var_0.atmines.size] = var_4;
    thread scripts\cp\equipment\cp_at_mine::at_mine_plant(var_4);
    var_4 thread watchatminedetonation(var_0);
    var_4 thread watchforapctrigger(var_0.apc);
    var_4 thread _id_144AD();
    waitframe();
  }
}

_id_144AD() {
  self endon("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = [(0, 0, 0), (22, 0, 0), (-22, 0, 0)];
  var_1 = 96;
  var_2 = var_1 * var_1;
  var_3 = 15;

  for(;;) {
    if(isDefined(level.vehicle) && isDefined(level.vehicle.instances) && isDefined(level.vehicle.instances["_encstr_8C190467402B"])) {
      foreach(var_5 in level.vehicle.instances["_encstr_8C190467402B"]) {
        if(!isDefined(var_5)) {
          continue;
        }
        if(level.teambased) {
          if(var_5.team == self.owner.team)
            continue;
        } else if(isDefined(var_5.owner) && var_5.owner == self.owner) {
          continue;
        }
        var_6 = anglestoaxis(var_5.angles);

        foreach(var_8 in var_0) {
          var_9 = var_5.origin;
          var_9 = var_9 + var_6["_encstr_8253060E2B5FE330"] * var_8[0];
          var_9 = var_9 + var_6["_encstr_B42E085325A82CB3F221"] * var_8[1];
          var_9 = var_9 + var_6["_encstr_87070365F7"] * var_8[2];
          var_10 = self.origin - var_9;
          var_11 = vectordot(var_10, var_6["_encstr_87070365F7"]);

          if(abs(var_11) > var_3) {
            continue;
          }
          var_12 = var_10 - var_6["_encstr_87070365F7"] * var_11;

          if(lengthsquared(var_12) > var_2) {
            continue;
          }
          thread scripts\cp\equipment\cp_at_mine::at_mine_vehicle_trigger(var_5);
          return;
        }
      }
    }

    waitframe();
  }
}

watchforapctrigger(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_87A316A708507F23EB932DE5F799A90B98E85313984BBDAA");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(distance(self.origin, var_0.origin) <= 150) {
      thread scripts\cp\equipment\cp_at_mine::at_mine_watch_flight();
      self notify("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
      return;
    }

    wait 1;
  }
}

watchatminedetonation(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_87A316A708507F23EB932DE5F799A90B98E85313984BBDAA");
  var_1 = var_0.apc;
  var_1 endon("_encstr_AD75063D571AE108");
  var_2 = scripts\engine\utility::_id_143AD("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B", "_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  var_0.atmines = scripts\engine\utility::array_remove(var_0.atmines, self);

  if(!isDefined(var_2)) {
    return;
  }
  if(isDefined(self.topmodel))
    self.topmodel delete();

  if(isDefined(var_2) && var_2 == "_encstr_879C0F95E0B8AD31855D17376F25ABE550")
    wait 1;

  if(distance(self.origin, var_1.origin) <= 300)
    var_1 notify("_encstr_B65D1683C2BC36B72CC8D70D5A1DEB13F27D2CA3D65ADC2B");
}

watchatminehitonpayload(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_87A316A708507F23EB932DE5F799A90B98E85313984BBDAA");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_B65D1683C2BC36B72CC8D70D5A1DEB13F27D2CA3D65ADC2B");
    var_0.timesapchitbymine++;
    self dodamage(self.maxhealth / 6, (0, 0, 0), undefined, undefined);
    var_0.ispayloadstunned = 1;
    apcstop(self);
    scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_931D1A0768D15FD33B69556F4E08772641BE99476FABE2EFD0C8EBA1" + randomintrange(1, 4) + "_encstr_934C0218", "_encstr_9A8507BA4040188D08");
    thread mayconsiderplayerdead(self);
    wait 2;
    thread waittoresumemovement();
  }
}

mayconsiderplayerdead(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_B4471B6D6777C30B4F2743D0BDBAE1388E1B801382F36D5A5F3A31F69F");

  while(isapctooclosetomine()) {
    scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_88C21D82CA6847D2486794893780D1972741C97AD0DD070A511BB19EC3B8E9" + randomintrange(1, 4) + "_encstr_934C0218", "_encstr_9A8507BA4040188D08");
    wait 10;
  }
}

setdamagestate(var_0) {
  if(isDefined(self.isattachmentvariantinvalid) && self.isattachmentvariantinvalid == var_0) {
    return;
  }
  self.isattachmentvariantinvalid = var_0;

  if(!isDefined(self._id_119E4)) {
    self._id_119E4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
    self._id_119E4 linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  }

  switch (var_0) {
    case 1:
    default:
      playFXOnTag(level._effect["_encstr_9399128335CB9F0959C2A07F58D4D86A5F5ACFEB"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      self._id_119E4 playLoopSound("_encstr_9724189327903167D71EEA0361B8B376508B3F0DC70AD2CFF1D3");
      break;
    case 2:
      stopFXOnTag(level._effect["_encstr_9399128335CB9F0959C2A07F58D4D86A5F5ACFEB"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      self._id_119E4 stoploopsound();
      playFXOnTag(level._effect["_encstr_919912058EF819E75F434028AA2308B8D5E7CF05"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      self._id_119E4 playLoopSound("_encstr_B23B1853095017B6F0C7E1F85761BF3709E1AABA1617EAE12881");
      break;
    case 3:
      stopFXOnTag(level._effect["_encstr_919912058EF819E75F434028AA2308B8D5E7CF05"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      self._id_119E4 stoploopsound();
      playFXOnTag(level._effect["_encstr_8F9912D37CA1A12871A8DBCF7009CFDA7304111A"], self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      self._id_119E4 playLoopSound("_encstr_BD3518CD3637FA1B07BE85E08DF53258D62CD956BEC066BE3607");
      break;
  }
}

waittoresumemovement() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8D390C38162A378BE19F1010E73C");

  if(!isapctooclosetomine()) {
    var_0.ispayloadstunned = 0;
    self notify("_encstr_B4471B6D6777C30B4F2743D0BDBAE1388E1B801382F36D5A5F3A31F69F");
    return;
  }

  while(isapctooclosetomine())
    wait 2;

  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_861018226AC8E772E8C7F4E957E0713787A129BA30BCA7EF60DF" + randomintrange(1, 6) + "_encstr_934C0218", "_encstr_9A8507BA4040188D08");
  var_0.ispayloadstunned = 0;
  self notify("_encstr_B4471B6D6777C30B4F2743D0BDBAE1388E1B801382F36D5A5F3A31F69F");
}

isapctooclosetomine() {
  var_0 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8D390C38162A378BE19F1010E73C");

  if(!isDefined(var_0.atmines) || var_0.atmines.size <= 0)
    return 0;

  var_1 = scripts\engine\utility::getclosest(var_0.apc.origin, var_0.atmines, 1000);

  if(!isDefined(var_1))
    return 0;

  return distance(var_1.origin, var_0.apc.origin) <= 500;
}

debugpayloadobjectivesstart(var_0) {
  scripts\engine\utility::flag_set("_encstr_8430170EB0BFCB0B9012A0E8AA2DC5408F4B0DF32EFF96577A");
  scripts\engine\utility::flag_wait("_encstr_A54D21DE700F7BBB2042F098DA7D75F05FBBDD437E8FC6878A9998E062D231A9F3256D");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_88D3186C07AF07C25E8DB72C8CAFE01B855E2B39FAB93A0B273A");
}

isteamplacementsbmmmode(var_0) {
  scripts\engine\utility::flag_set("_encstr_8430170EB0BFCB0B9012A0E8AA2DC5408F4B0DF32EFF96577A");
  scripts\engine\utility::flag_wait("_encstr_A54D21DE700F7BBB2042F098DA7D75F05FBBDD437E8FC6878A9998E062D231A9F3256D");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  scripts\engine\utility::flag_set("_encstr_8A6B0ED81CFAD6F6E4B01B566EAFC6CD");
  scripts\engine\utility::flag_wait("_encstr_88CE18377FF72560ADE921D51BA9460BCF1E77FDB30CB3839D31");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_96F31821F753B179FF9B4998925633098F7335AF4293BEB1A5A2");
  var_1 = scripts\engine\utility::getStruct("_encstr_BD17144B985A7965AF4BE64B50CD305FC845AD63AF98", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0.exfilstruct = var_1;
  var_2 = scripts\engine\utility::getStruct("_encstr_922813CB28BA510C0D37CFCB650C8791E2C9C958B0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = scripts\engine\utility::getStruct("_encstr_8FBE18DAE036970D30C77758F32014275D3B12934E0E1B8660E1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread scripts\cp\vehicles\cp_heli_trip::start_heli_trip_sequence(var_2, var_0.exfilstruct, var_3, 0);
  level waittill("_encstr_99D81368CB605C77355B8A23C60DFF955BD717EE55");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8F7711073340377375F7E783D91EEA4F90FB3F");
  wait 3;
}

waitforanyplayersnearpoint(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    foreach(var_3 in level.players) {
      if(distance(var_3.origin, var_0) <= var_1)
        return;
    }

    wait 0.5;
  }
}

watchforhelideletion(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = 0;
  var_2 = 10000;

  while(!istrue(var_1)) {
    var_1 = 1;

    foreach(var_4 in level.players) {
      if(distance(var_4.origin, var_0.origin) <= var_2)
        var_1 = 0;
    }

    wait 3;
  }

  level notify("_encstr_AA20142B7E51489822ABFF81C79AD5D0E5599001A5B9");
}

_id_1364E() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\engine\utility::getStruct("_encstr_B1CE13C158BC63BD8546FA86CAC62DFAB91C2CEE73", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStruct("_encstr_B8A915492F3B99C8D9A72EC08F8CA058C297FDF9E7B2D4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStruct("_encstr_A11C21E00BBC63F65846EB2C4ED6E64EB036957D1ACAB1B4FA3A935AE07DDCA35827E8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0.script_modelname = "_encstr_B2671623E5D0519E0729F97F8B2D1BC80120B0DDCF49689F";
  var_0.classname_mp = "_encstr_8CEF193FBB4A98F71B3173192A0726E8272FB3BF78F90831570AE9";
  var_0.vehicletype = "_encstr_8DD90913C62DB585D7D81C";
  var_0.script_model = "_encstr_AFD51326359090DF221B5B7F4280C05F46F8A86BC7";
  thread scripts\cp\vehicles\cp_heli_trip::start_heli_trip_sequence(var_0, var_1, var_2, 0);
  wait 3;

  if(!isDefined(level.heli_trip_vehicle)) {
    return;
  }
  level.heli_trip_vehicle waittill("_encstr_8B4611FB437F1BCBF029B7922708928B93F832");
  var_3 = level.heli_trip_vehicle;
  var_4 = scripts\cp\cp_objectives::requestworldid("_encstr_859D0E0F6EA3E9C049B3E138EB66D831");
  objective_state(var_4, "_encstr_AF5A081BBAC993AC73A3");
  objective_onentity(var_4, var_3);
  objective_icon(var_4, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setlabel(var_4, &"_encstr_8CCF1B6828BEA094536A11540A622AA4CB51619125C4EB125450112A92");
  objective_setshowoncompass(var_4, 1);
  objective_setminimapiconsize(var_4, "_encstr_8A9C0D3F5F2072CF1829A72BE0682A");
  scripts\cp\cp_objectives::_id_11F80(var_4);
  var_3 waittill("_encstr_AD0E1041F595C028536A184082C7E038AF4E");
  objective_delete(var_4);
  scripts\cp\cp_objectives::freeworldid("_encstr_859D0E0F6EA3E9C049B3E138EB66D831");
}

spawn_chopper(var_0, var_1) {
  var_2 = scripts\common\vehicle::vehicle_spawn(var_0);
  var_2.vehicle_skipdeathmodel = 1;
  var_2.script_disconnectpaths = 0;
  var_2.death_fx_on_self = 1;
  var_2.exfil_struct = var_1;
  var_1.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(var_1.origin, 1);
  scripts\cp\infilexfil\blima_exfil::spawn_vehicle_actors(var_2);
  var_2 scripts\cp\infilexfil\blima_exfil::heli_mg_create();
  var_2.godmode = 1;
  var_2.health = 10000;
  var_2.maxhealth = 10000;
  var_2 _encstr_93F537FE2B8360B14B6B1A7073B553B963C3287E908F89C7B512F8E83A6D07D3877C80601D4BD337D1DA402851D433A8F7E418647EFA994F06::spawnhelihvtexfilactors();

  if(isDefined(var_2.wmexfilally)) {
    if(!isDefined(var_2.actors))
      var_2.actors = [];

    var_2.actors[var_2.actors.size] = var_2.wmexfilally;
  }

  return var_2;
}

_id_13609() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\engine\utility::getStruct("_encstr_B1CE13C158BC63BD8546FA86CAC62DFAB91C2CEE73", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStruct("_encstr_B8A915492F3B99C8D9A72EC08F8CA058C297FDF9E7B2D4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0.classname_mp = "_encstr_AF331BC31EE30FBA4961F3DAC0ABB6D3F9E85958A769538777988AB3C8";
  var_0.script_modelname = "_encstr_8DCA216DE564BAD8C7FAE8B642EF06C97E70D7118DCD72B5E73203BE6AA7BE4819DD71";
  var_0.vehicletype = "_encstr_A60D0E2307118F4150A11F847AC08F30";
  var_2 = scripts\common\vehicle::vehicle_spawn(var_0);
  var_2.death_fx_on_self = 1;
  var_2.circle_radius = 2500;
  var_2 scripts\cp\helicopter\cp_helicopter::heli_mg_create("_encstr_82BC202BBF802A40225FD9B7978A1EC92154B0E327FC12AD393313F5E3126581EFED", "_encstr_B1DA118FE9B73268D01EF3BB9340ADFBAF6753", "_encstr_99FE0B2B19086F6B9DC5D387E1");
  var_2.isheli = 1;
  var_2.health = 50000;
  var_2.maxhealth = 50000;
  var_2.team = "_encstr_9A8507BA4040188D08";
  var_2 setvehicleteam("_encstr_9A8507BA4040188D08");
  var_2 setmaxpitchroll(15, 15);
  var_2.health_remaining = 2250;
  var_2 sethoverparams(25, 15, 10);
  var_2 setCanDamage(0);
  var_2.exfil_struct = var_1;
  var_2.headicon = deleteheadicon(var_2);
  setheadiconfriendlyimage(var_2.headicon, "_encstr_A62C214CED91A9090910CB07C021F9E20F0D92835BE1C24DF0F0171B0898B50AC11118");
  setheadiconsnaptoedges(var_2.headicon, 12000);
  setheadiconmaxdistance(var_2.headicon, 1500);
  addclienttoheadiconmask(var_2.headicon, 10);
  setheadicondrawthroughgeo(var_2.headicon, 1);

  if(!isDefined(var_2.exfil_struct.angles))
    var_2.exfil_struct.angles = (0, 0, 0);

  var_2.going_to_exfil = 1;
  var_2 vehicle_setspeed(90, 30);
  var_2 setvehgoalpos(var_2.exfil_struct.origin + (0, 0, 800), 1);
  var_2 waittill("_encstr_8B7205D9ED5958");
  var_2 vehicle_setspeed(15, 10);
  thread mark_as_bomb_vest_controller_holder(10);
  heli_cleanup_exfil_area(var_2);
  var_2 thread skip_player_pos_memory();
  level thread watchforhelideletion(var_2);
  level waittill("_encstr_AA20142B7E51489822ABFF81C79AD5D0E5599001A5B9");
  var_2.minigun makeunusable();
  var_2.minigun maketurretinoperable();

  if(isDefined(var_2.vip))
    var_2.vip scripts\cp\cp_pickup_hostage::deletepickuphostage();

  if(isDefined(var_2.minigun))
    var_2.minigun delete();

  setheadiconimage(var_2.headicon);
  var_2 delete();
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

      if(var_2 >= 5)
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

skip_player_pos_memory() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = scripts\engine\utility::getStruct("_encstr_8FA51B51372381C0A1DF26F9C289E8CB5A67E3C9D3CA5979E875E810EB", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = self;
  var_1 vehicle_setspeed(90, 30);
  var_1 setvehgoalpos(var_0.origin, 1);
}

get_nearby_enemy(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 25000000;

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

init_range_targets(var_0) {
  var_1 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_0 gettagorigin("_encstr_99FE0B2B19086F6B9DC5D387E1"), "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07", 0);
  var_1.angles = var_0 gettagangles("_encstr_99FE0B2B19086F6B9DC5D387E1");
  var_1 linkTo(var_0, "_encstr_99FE0B2B19086F6B9DC5D387E1", (0, 0, 0), (0, 0, 0));
  var_1 setModel("_encstr_864421D9951A70FAB64B36FA363719D767B437462DB0BE8513BE47AEC9C95947EBB5E0");
  var_1 setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
  var_1 setsentryowner(undefined);
  var_1 makeunusable();
  var_1 setdefaultdroppitch(0);
  var_1 setturretmodechangewait(1);
  var_2 = getcompleteweaponname("_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07");
  var_1.objweapon = var_2;
  var_1.apc = var_0;
  var_0.intro_spawn_enemies = var_1;
  var_0 thread tr_removequestinstance();
  return var_1;
}

tr_removequestinstance() {
  var_0 = self.origin + (0, 0, 120);
  thread init_bomb_sites(var_0, &"_encstr_A54B1BCE200F9CFDEC71099909B52F95DBF7C4535A0FC6E9034911B1F1", self);
}

init_bomb_sites(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3 linkTo(var_2);
  var_3 setHintString(var_1);
  var_3 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_3 sethintdisplayrange(200);
  var_3 sethintdisplayfov(90);
  var_3 setuserange(72);
  var_3 setusefov(90);
  var_3 sethintonobstruction("_encstr_BD1805CB69C063");
  var_3 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_2.intro_spawn_enemies.interaction = var_3;
  var_3 thread trial_map(var_2.intro_spawn_enemies, var_2);
  var_3 thread interaction_disable_on_exit(var_2);
}

trial_map(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_96E9151F7EB3F9F07983F1906F9189099AA7AF2C556AB1");

  for(;;) {
    self makeusable();
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
    self makeunusable();
    var_0 setotherent(var_2);
    var_0 setentityowner(var_2);
    var_0 setsentryowner(var_2);
    var_2 remotecontrolturret(var_0);
    var_2 playerhide();
    var_2 thread scripts\cp\cp_kidnapper::setimmunetokidnapper(1);
    var_0.playerowner = var_2;
    var_2.currentturret = var_0;
    var_0 thread _id_12B49(1.5);
    thread endturretusewatch(var_2, var_0);
    thread new_angles(var_2, var_0);
    self waittill("_encstr_B4D31738162F36B7C28CFA2B7391EBD1ABE4E42B1DEBAECDB2");
    monitor_fronttruck_death(var_2, var_0);
  }
}

_id_12B49(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B4D31738162F36B7C28CFA2B7391EBD1ABE4E42B1DEBAECDB2");

  for(;;) {
    self waittill("_encstr_ACA30D383847FB93AAFF7705139D4B");
    self turretfiredisable();
    wait(var_0);
    self turretfireenable();
  }
}

endturretusewatch(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B4D31738162F36B7C28CFA2B7391EBD1ABE4E42B1DEBAECDB2");

  while(var_0 useButtonPressed())
    waitframe();

  for(;;) {
    if(var_0 useButtonPressed()) {
      self notify("_encstr_B4D31738162F36B7C28CFA2B7391EBD1ABE4E42B1DEBAECDB2");
      break;
    }

    waitframe();
  }
}

new_angles(var_0, var_1) {
  var_0 scripts\engine\utility::_id_143A6("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_8CBE0BD1BED30936AB03C0B02B");
  self notify("_encstr_B4D31738162F36B7C28CFA2B7391EBD1ABE4E42B1DEBAECDB2");
}

monitor_fronttruck_death(var_0, var_1) {
  var_0 remotecontrolturretoff(var_1);

  if(isDefined(var_0)) {
    var_2 = scripts\cp\utility::get_point_in_local_ent_space(var_1, (-20, 0, 10));
    var_0 setOrigin(var_2);
    var_0 setplayerangles(scripts\engine\utility::ter_op(isDefined(var_1.angles), var_1.angles, (0, 0, 0)));
    var_0 thread scripts\cp\cp_kidnapper::setimmunetokidnapper(0);
    var_0 playershow();
    var_0 controlsunlink();
    var_0.currentturret = undefined;
    var_1 setturretdismountorg(var_0.origin);
  }

  var_1.playerowner = undefined;
  var_1 setotherent(undefined);
  var_1 setentityowner(undefined);
  var_1 setsentryowner(undefined);
}

interaction_disable_on_exit(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_96E9151F7EB3F9F07983F1906F9189099AA7AF2C556AB1");
  self makeunusable();
}

_id_14377() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = level.players[0];

  for(;;) {
    var_0 waittill("_encstr_B6F4108D9DFB87CA4858AFBB0960603AA3CF");
    var_0 controlsunlink();
  }
}

_id_13535(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_A78D186CBDCDB3DB97D76E478527477D0E58E51BDE5846EB8113", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = "_encstr_A1E31329FD0593ABAAB2B1B808B0652586365A9770";
  var_3 = "_encstr_84690A86D708E6DDDB1F477B";
  level thread spawn_convoy(var_3, var_2, var_1);
}

_id_135D1(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = "_encstr_82AA138270283F92FD1393AFF713EA3D18D97A0F28";
  var_3 = var_0;
  level thread spawn_convoy(var_3, var_2, var_1);
}

spawn_convoy(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var_4 = level[[var_3]](var_0, var_1, var_2);
  var_4 thread select_bunker_server_one_spawners();
  level thread allow_driver_exit(var_4);
  var_4 scripts\cp\cp_convoy_manager::set_use_path_speeds_modifier(1);
  level waittill("_encstr_8E76095022AA99515FE620" + var_0);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_distance(5000);
  var_4 thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);
}

allow_driver_exit(var_0) {
  wait 1;
  var_0 notify("_encstr_AA0117D053B4796F8B1D1085F7A347E3E9A399708B59D3C3D3");
  var_0 scripts\cp\cp_convoy_manager::_id_1307D(0);
}

select_bunker_server_one_spawners() {
  self.spawned_vehicles[0] endon("_encstr_AD75063D571AE108");
  wait 5;
  self.spawned_vehicles[0] waittill("_encstr_AB850C5DDC8DED168CF59DBA5EDC");

  foreach(var_1 in self.spawned_vehicles[0].riders)
  var_1.goalradius = 2048;
}

_id_138C7() {
  var_0 = getEntArray("_encstr_914314D19B0A1F327DF35987712793A77B78FCEBC8C9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 thread anim_override();
}

_id_1380B() {
  var_0 = getEntArray("_encstr_8FF115D31DF7B80F35E2BF53EB5A9EEB2150DD1F7BC895", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 thread angvels();
}

anim_override() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    break;
  }

  var_1 = strtok(self.script_noteworthy, "_encstr_964C0249");

  foreach(var_3 in var_1)
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_3);

  self delete();
}

angvels() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    break;
  }

  var_1 = strtok(self.script_noteworthy, "_encstr_964C0249");

  if(var_1[0] == "_encstr_A3760736F673B3F62F")
    _id_135D1(var_1[1]);
  else if(var_1[0] == "_encstr_A9F60584665BF3")
    level thread scripts\cp\cp_wave_spawning::killstreaks(0, var_1[1]);
  else {
    foreach(var_3 in var_1)
    scripts\cp\cp_modular_spawning::run_spawn_module(var_3);
  }

  self delete();
}

_id_1446E(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8D390C38162A378BE19F1010E73C");

  for(;;) {
    var_2 = scripts\cp\utility::get_point_in_local_ent_space(var_0, (128, 0, 0));

    if(trial_time_remaining(var_2, 64)) {
      var_1.turret_objective_think = 1;
      getbankedplunder(var_1.apcwid, 1);
      apcstop(var_0);
    } else {
      var_1.turret_objective_think = 0;
      getbankedplunder(var_1.apcwid, 0);
    }

    wait 1;
  }
}

trial_time_remaining(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distance(var_3.origin, var_0) <= var_1)
      return 1;
  }

  return 0;
}

_id_1445C(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = scripts\engine\utility::getStruct(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  for(;;) {
    if(distance(self.origin, var_1.origin) <= 150) {
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AACE15E085F263DB0B19EB1B2CCDA3A34E56B67DC9C13B");
      scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_993F180B0BFB1DBFD1C5AF846FBB1BA355882271E8BD14FB8936");
      level thread scripts\cp\cp_wave_spawning::killstreaks(1, "_encstr_950A120EC2F2B1B70B19AF0BB11BACF2E6963259");
      break;
    }

    wait 1;
  }
}

getbankedplunder(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8D390C38162A378BE19F1010E73C");

  if(istrue(var_2.shot_by_player)) {
    return;
  }
  if(istrue(var_1))
    objective_setlabel(var_0, &"_encstr_A79E171873BF24A8FC4731A5C0E1512B613DF01987FEE29559");
  else
    objective_setlabel(var_0, &"_encstr_A7BD1680310F7DA3EC30C8D12BF44F36D1326819019762B3");
}

_id_13BAD(var_0) {
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8D390C38162A378BE19F1010E73C");

  if(istrue(var_1.apc_destroyed)) {
    return;
  }
  if(var_0) {
    objective_setplayintro(var_1.apcwid, 0);
    objective_state(var_1.apcwid, "_encstr_AF5A081BBAC993AC73A3");
    objective_icon(var_1.apcwid, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
    objective_setzoffset(var_1.apcwid, 64);
    objective_onentity(var_1.apcwid, var_1.apc);
    scripts\cp\cp_objectives::_id_11F80(var_1.apcwid);
  } else
    objective_delete(var_1.apcwid);
}

c4_crate_use() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B122124E2FDFE953AB50F347D840379299CB1547");
  wait 1;
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_14192(self, "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07");
  var_1 = cos(65);
  var_0.shotsleft = 100000;

  for(;;) {
    var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
    var_2 = sortbydistance(var_2, self.origin);

    foreach(var_4 in var_2) {
      if(!isDefined(var_4)) {
        continue;
      }
      if(!scripts\engine\utility::within_fov(self.origin, self.angles, var_4.origin, var_1)) {
        continue;
      }
      if(var_0 turretcantarget(var_4.origin))
        var_0 settargetentity(var_4, (0, 0, 40));

      thread c4_crate_update_hint_logic_alt(var_0);
      wait(randomfloatrange(1, 3));
      break;
    }

    var_0 cleartargetentity();
    wait 1;
  }
}

c4_crate_update_hint_logic_alt(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = 1;
  var_2 = getcompleteweaponname("_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07");
  var_3 = weaponfiretime(var_2);

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_0 shootturret();
    wait(var_3);
  }
}

_id_12C39(var_0) {
  wait 1;
  var_0.turrets["_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07"] delete();
  var_1 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_0 gettagorigin("_encstr_99FE0B2B19086F6B9DC5D387E1"), "_encstr_85FE12D5B3CB57C99057295817CB46630251C65F", 0);
  var_1.angles = var_0 gettagangles("_encstr_99FE0B2B19086F6B9DC5D387E1");
  var_1 linkTo(var_0, "_encstr_99FE0B2B19086F6B9DC5D387E1", (0, 0, 0), (0, 0, 0));
  var_1 setModel("_encstr_864421D9951A70FAB64B36FA363719D767B437462DB0BE8513BE47AEC9C95947EBB5E0");
  var_1 setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
  var_1 setsentryowner(undefined);
  var_1.team = "_encstr_9A8507BA4040188D08";
  var_1 setturretteam("_encstr_9A8507BA4040188D08");
  var_1 makeunusable();
  var_1 setdefaultdroppitch(0);
  var_1 setturretmodechangewait(1);
  var_1.vehicle = var_0;
  var_0.turrets["_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07"] = var_1;
}

spawn_enemy_tanks() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_BE390C6EAB07B293EB1DB0E65B37", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.altgunnerturret = "_encstr_ACA312FBB97D1B1EFB17451B90AB4F05ED9FD043";
  level.enemy_tanks = [];

  foreach(var_2 in var_0) {
    thread _id_142DB();
    level thread spawn_enemy_tank(var_2);
    wait 60;
  }
}

spawn_enemy_tank(var_0) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_1 = spawnStruct();
  var_2 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.spawntype = "_encstr_AFBE0AD105A651FA9A3D8854";
  var_1.owner = undefined;
  var_1.team = "_encstr_8E8405EA382B2A";
  var_1.faceawayfromowner = 0;
  var_1.cancapture = 0;
  var_1.cancaptureimmediately = 0;
  var_1.spawnmethod = "_encstr_8A9A1B47D79A98B327BBE769254F29652A63A3D730A2C78D5DFFBFEC55";
  var_1.activateimmediately = 1;
  var_1.cantimeout = 0;
  var_1.usealtmodel = 1;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_1);
  var_3 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var_1, var_2);

  if(!isDefined(var_3)) {
    return;
  }
  level notify("_encstr_96C50BA2803BB50F0EE5B9BE72", var_3);
  wait 10;
  level.enemy_tanks[level.enemy_tanks.size] = var_3;
  var_3 thread tank_waittill_death();
  var_3 endon("_encstr_AD75063D571AE108");
  var_3 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  var_4 = scripts\engine\utility::getStructArray("_encstr_874D103A18A33D87B66D31268ADEEB46F940", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = sortbydistance(var_4, var_3.origin)[0];
  var_6 = build_tank_path(var_5);
  var_7 = build_tank_duration(var_5);
  var_3 startpathnodes(var_6, var_7);
  setheadiconsnaptoedges(var_3.headicon, 8088);
  var_8 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_3, "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");
  var_9 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_3, "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83");

  if(!isDefined(level.vo_paratroopers))
    level.vo_paratroopers = [];

  level.vo_paratroopers = scripts\engine\utility::array_add(level.vo_paratroopers, var_3);

  for(;;) {
    var_10 = var_3 scripts\cp\utility::get_closest_living_player();

    if(!isDefined(var_10)) {
      wait 1;
      continue;
    }

    if(istrue(var_10.binvehicle) && isDefined(var_10.vehicle)) {
      if(var_8 turretcantarget(var_10.vehicle.origin + (0, 0, 50)))
        var_8 settargetentity(var_10.vehicle, (0, 0, 50));

      if(var_9 turretcantarget(var_10.vehicle.origin + (0, 0, 50)))
        var_9 settargetentity(var_10.vehicle, (0, 0, 50));
    } else {
      var_8 settargetentity(var_10);
      var_9 settargetentity(var_10);
    }

    var_3 thread tank_shoot_at_target(var_9, 1);
    var_3 thread tank_shoot_at_target(var_8);
    wait(randomfloatrange(3, 5));
  }
}

tank_shoot_at_target(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_2 = 1;
  var_3 = getcompleteweaponname("_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8");

  if(istrue(var_1)) {
    var_2 = randomintrange(15, 25);
    var_3 = getcompleteweaponname("_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83");
  }

  var_4 = weaponfiretime(var_3);

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_0 shootturret();
    wait(var_4);
  }
}

build_tank_path(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = [];
  var_2 = var_0;

  for(var_1[var_1.size] = var_2.origin; isDefined(var_2) && isDefined(var_2.target); var_1[var_1.size] = var_2.origin)
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  return var_1;
}

build_tank_duration(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = [];
  var_2 = var_0;
  var_1[var_1.size] = 10;

  while(isDefined(var_2) && isDefined(var_2.target)) {
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_2.duration)) {
      var_1[var_1.size] = int(var_2.duration);
      continue;
    }

    var_1[var_1.size] = 10;
  }

  return var_1;
}

tank_waittill_death() {
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.headicon))
    setheadiconimage(self.headicon);

  level.enemy_tanks = scripts\engine\utility::array_remove(level.enemy_tanks, self);
}

_id_142DB() {
  var_0 = ["_encstr_BE1E254C0B08D80B02477A991551778F27B17BED0B8C2789309287E65B822684626878FA198B43", "_encstr_AF1E25ACFB2E4FA25F491AB2F05351F741693C2F959377EB23B80269188916EFD843B6DF383392", "_encstr_8134251703698B3F3881C091B3EB4FAA7E942D6775F3413123CB8A11836A108F823872BFA91F8A", "_encstr_823425C8C3FA1B07E67D6385E6DCD71B8536C6EDEAD1FAD185E6D67DB90EB0BBDC5AE6EC7D460C"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var_0), "_encstr_9A8507BA4040188D08");
}

_id_13589() {
  thread scripts\cp\cp_aiparachute::request_paratroopers("_encstr_912E1488C362A1C34329CF5F7ACA398BD71718A0B31B", undefined, (-11539.5, -14462, -221.5));
  wait 5;
  scripts\cp\cp_aiparachute::request_paratroopers("_encstr_AB0C131BB7E8FA07854EB08E4E7BEDE0B2936E7D62", undefined, (-11539.5, -14462, -221.5));
  thread scripts\cp\cp_aiparachute::request_paratroopers("_encstr_990C1336F6D1F5C1B0C90BD1C9EDEDC159C99B7D64", undefined, (-11539.5, -14462, -221.5));
  wait 5;
  scripts\cp\cp_aiparachute::request_paratroopers("_encstr_9B0C13D8DBE87D1C8539163AC97BF638564EDCBE99", undefined, (-11539.5, -14462, -221.5));
}

_id_13979() {
  level endon("_encstr_B46E1243AB3091CF130AC2B903AB5068D37A2AF3");
  var_0 = ["_encstr_B872154EABF33BA3B723D0404FB4FB776A92CD5682B95B", "_encstr_AC72158B6BE0A9931F23E773278B0AA017C8C5838F4F6A", "_encstr_917215EEA04F88D3C77721BB18B1CB98774187982F2967"];

  for(;;) {
    while(level.spawned_ai.size >= 12)
      wait 1;

    var_1 = scripts\cp\cp_aiparachute::request_paratroopers(scripts\engine\utility::random(var_0), undefined, (-11539.5, -14462, -221.5));

    if(isDefined(var_1) && var_1.size > 0)
      thread _id_142EC();

    wait(randomintrange(15, 30));
  }
}

_id_11D33() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-14046.5, 18827.5, -300));
  var_0 setModel("_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
  var_1 = scripts\engine\utility::getStructArray("_encstr_B8291A930841C7537E39E7F24D41AB819B502B0A1011311FB310E40B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = 0;

  for(;;) {
    var_3 = scripts\engine\utility::array_randomize(var_1);

    foreach(var_5 in var_3) {
      var_0 thread _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::launch_mortar(undefined, var_5.origin + (randomintrange(-100, 100), randomintrange(-100, 100), 0));
      wait(randomfloatrange(0.3, 0.75));
    }

    var_2++;

    if(var_2 > 2) {
      break;
    }

    wait(randomfloatrange(2, 4));
  }
}

_id_142EC() {
  if(!isDefined(level._id_121D5))
    level._id_121D5 = gettime() - 1000;

  if(level._id_121D5 > gettime()) {
    return;
  }
  var_0 = ["_encstr_8B322CAA7A48763B469933877F27710729F0250FD5CB86117FFB6A85E327E8E31B10A1026777E71E3483B4F7DA88", "_encstr_93322C3A72D00F9A102FF3C173B86947676832F2BB1D4752689DF1DC25A02DD39D0399BBA37F2F8D70BDEFEFBD82", "_encstr_A1E42CA10B3668508051F187CB8BE9FBE061EA35B78B403B6B2E77047B9F5AEA9003F9E3511E5C084BCDCF9FC71A", "_encstr_86E42C33604ECBAB5718A59E763F1193D168AB9790C33F734BA6EED3DEDFEA48F9E0EF7F50D96FDAB3B07701E649"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var_0), "_encstr_9A8507BA4040188D08");
  level._id_121D5 = gettime() + 30000;
}

_id_13976() {
  level waittill("_encstr_95431788534EFD935F5B950F2583BEABF53A71B8FA271B286B");
  level thread _id_11F5A();
  thread scripts\cp\cp_objectives::run_objective("_encstr_8E5616C85A1089B8DF04C85D1D4F037D7D233970F26DDF73");
  wait 5;
  thread spawn_enemy_tanks();
  wait 30;
  thread _id_11D33();
  thread _id_13979();
}

_id_11F5A() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = undefined;
  var_1 = 0;

  for(;;) {
    level waittill("_encstr_96C50BA2803BB50F0EE5B9BE72", var_2);

    if(!isDefined(var_0)) {
      var_0 = scripts\cp\cp_objectives::requestworldid("_encstr_914C0C95372B6BCB7DD1B0DCB69B", 15);
      objective_icon(var_0, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
      objective_setplayintro(var_0, 1);
      objective_setlabel(var_0, &"_encstr_95E9256814BE4D5512554A2135AF7A2149A8A1515259A26A5E12F49AA9FAA282E4A56AEBF49092");
    }

    objective_setlocation(var_0, var_1, var_2);
    objective_state(var_0, "_encstr_AF5A081BBAC993AC73A3");
    objective_setshowoncompass(var_0, 1);
    objective_setminimapiconsize(var_0, "_encstr_8A9C0D3F5F2072CF1829A72BE0682A");
    scripts\cp\cp_objectives::_id_11F80(var_0);
    var_2 thread _id_1433C(var_0, var_1);
    var_1++;
  }
}

_id_1433C(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  objective_unsetlocation(var_0, var_1);

  if(!isDefined(level._id_13A5A))
    level._id_13A5A = 0;

  level._id_13A5A++;

  if(level._id_13A5A >= 2) {
    scripts\engine\utility::flag_set("_encstr_95E2150EC2CB1BDE58C8AFA316E6ADDCBEB696B163B232");
    objective_delete(var_0);
    scripts\cp\cp_objectives::freeworldid("_encstr_914C0C95372B6BCB7DD1B0DCB69B");
  }
}