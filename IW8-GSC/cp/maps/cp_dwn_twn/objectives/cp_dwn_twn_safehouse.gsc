/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_safehouse.gsc
******************************************************************/

main() {
  level.safehouse_obj_func = ::safehouse_obj_func;
}

safehouse_obj_func() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_init("_encstr_A15B0B8154473327910A282832");
  scripts\engine\utility::flag_init("_encstr_87010E68520F06F06DDE1745FDD6A0CB");
  scripts\engine\utility::flag_init("_encstr_8E7C166E5899CAD0B7D5B995EB93AC8EAB27CDAF2B0F2D1D");
  scripts\engine\utility::flag_init("_encstr_ABBD14B98566AC86DB576E59FA467BB793F5EDC156B9");
  scripts\engine\utility::flag_init("_encstr_B66F144ECA8EEAC9CDEBD1B77D3785CCB21AB75DDC56");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  scripts\engine\utility::flag_wait("_encstr_B6DC2BD81CF546BDCD59479BDABECD0BCC56D0BDAE6EB2BE8CDBDDDC47B7DDCDD7D8CDBE6CDE5B0E1B2B3ACA46");
  scripts\cp\cp_objectives::registerobjective("_encstr_AB590E86665AF3385FFFB8306F65301B", undefined, undefined, undefined, undefined, ::debug_safehouse_start);
  scripts\cp\cp_objectives::registerobjective("_encstr_87B50A6356763823EAF7CFFB", undefined, ::start_safehouse, undefined, ::debugbeatobjective, ::debugbeatobjective);
  scripts\cp\cp_objectives::registerobjective("_encstr_847712E61666CAD0B75DB995FAD9D5376E34F61C", ::tango_infil_radio_idle, ::_id_137F6, undefined, ::debugbeatobjective, ::isprophunt);
  level.default_player_spawns = "_encstr_990C18B9169956A1B7D59B957D26EBC11B85CB95E46EE80BC98E";
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("_encstr_990C18B9169956A1B7D59B957D26EBC11B85CB95E46EE80BC98E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread scripts\mp\vehicles\vehicle_damage_mp::_id_12E57();
}

debugbeatobjective(var_0) {}

debug_safehouse_start(var_0) {
  scripts\engine\utility::flag_wait("_encstr_B6DC2BD81CF546BDCD59479BDABECD0BCC56D0BDAE6EB2BE8CDBDDDC47B7DDCDD7D8CDBE6CDE5B0E1B2B3ACA46");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_990C18B9169956A1B7D59B957D26EBC11B85CB95E46EE80BC98E");
  thread start_safehouse_objective();
}

debug_safehouse_return_start(var_0) {
  scripts\engine\utility::flag_wait("_encstr_B6DC2BD81CF546BDCD59479BDABECD0BCC56D0BDAE6EB2BE8CDBDDDC47B7DDCDD7D8CDBE6CDE5B0E1B2B3ACA46");
  scripts\engine\utility::flag_set("_encstr_918D198D1CBE32BB9B7DA3EE37FAB1275685E8ACFACD1BE45A07E8");
  scripts\engine\utility::flag_wait("_encstr_8ECB238DC1FA32DDB97D8E77CDF56C93CAB0D195BE376CC9A583D1FA8DF6B683C62B47CA23");
  scripts\engine\utility::flag_set("_encstr_8F75268653A13C2378F793E7ED883A717098314B69F0C9BA41AB37BFFD4DF2BC8066B29663409883");
  scripts\engine\utility::flag_wait("_encstr_84693086E92EF4DB501F65F7CA098A4F558871265869E3C1D9EDF76602B7174113D99B2933218384A04E404A707DAA9539F0");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  level._id_12E58 = 1;
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_95FA1AD92CBA631DF5589BB92CBA1B47EB91B226BA3BF5DC1D0B9C1D");
  scripts\engine\utility::flag_set("_encstr_A15B0B8154473327910A282832");
  wait 3;
}

isprophunt(var_0) {
  scripts\engine\utility::flag_wait("_encstr_B6DC2BD81CF546BDCD59479BDABECD0BCC56D0BDAE6EB2BE8CDBDDDC47B7DDCDD7D8CDBE6CDE5B0E1B2B3ACA46");
  scripts\engine\utility::flag_set("_encstr_918D198D1CBE32BB9B7DA3EE37FAB1275685E8ACFACD1BE45A07E8");
  scripts\engine\utility::flag_wait("_encstr_8ECB238DC1FA32DDB97D8E77CDF56C93CAB0D195BE376CC9A583D1FA8DF6B683C62B47CA23");
  scripts\engine\utility::flag_set("_encstr_8F75268653A13C2378F793E7ED883A717098314B69F0C9BA41AB37BFFD4DF2BC8066B29663409883");
  scripts\engine\utility::flag_wait("_encstr_84693086E92EF4DB501F65F7CA098A4F558871265869E3C1D9EDF76602B7174113D99B2933218384A04E404A707DAA9539F0");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_8DE31E6E16992B43BDBA372BEB9DEACDE6D0BDC1BE38C60B9759C937E8589C3A");
}

start_safehouse_objective() {
  wait 3;
  scripts\cp\cp_objectives::run_objective("_encstr_87B50A6356763823EAF7CFFB", "_encstr_BA7F0830B3A7859B60B0");
}

start_safehouse(var_0) {
  scripts\engine\utility::flag_wait("_encstr_B6DC2BD81CF546BDCD59479BDABECD0BCC56D0BDAE6EB2BE8CDBDDDC47B7DDCDD7D8CDBE6CDE5B0E1B2B3ACA46");
  level thread scripts\cp\intel\cp_intel::init_intel_pieces("_encstr_B8010A3D97C3CA5499A8D783");
  scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(1);
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  level._id_139B5 = 1;
  thread scripts\mp\vehicles\vehicle_damage_mp::molotov_get_pool_level_data(scripts\engine\utility::getStruct("_encstr_88F71AB777F3190BEB6D10FBEF46B748F73BBF374FB05AA31F2AC50B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_12E56(getEntArray("_encstr_9520175D07CB9E91A36271088A3F7BB077AD5E4557ABC09F4B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("_encstr_8C780B1C3D6FCBE23920276390", "_encstr_ABBD14B98566AC86DB576E59FA467BB793F5EDC156B9", 10, 1);

  if(getdvarint("_encstr_B6F908C3D81F8727583D") < 1) {
    _id_12E5F();
    setDvar("_encstr_B6F908C3D81F8727583D", 1);
  }

  wait 3;
  thread init_mission_select(var_0);
}

tango_infil_radio_idle(var_0) {
  setDvar("_encstr_A53311F3D8256937BBAFC5C1AF66432E8DF86F", 1);
  scripts\engine\utility::flag_wait("_encstr_B6DC2BD81CF546BDCD59479BDABECD0BCC56D0BDAE6EB2BE8CDBDDDC47B7DDCDD7D8CDBE6CDE5B0E1B2B3ACA46");
  scripts\engine\utility::flag_set("_encstr_A15B0B8154473327910A282832");
  level.default_player_spawns = "_encstr_8DE31E6E16992B43BDBA372BEB9DEACDE6D0BDC1BE38C60B9759C937E8589C3A";
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("_encstr_8DE31E6E16992B43BDBA372BEB9DEACDE6D0BDC1BE38C60B9759C937E8589C3A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread scripts\cp\intel\cp_intel::init_intel_pieces("_encstr_974B0B8269FDF35778BD051A15");
}

_id_137F6(var_0) {
  thread scripts\cp\cp_objectives::run_objective("_encstr_A3531B14767BF1AB7F9F8890878D6009215A059D0A12BB932D4F800837", "_encstr_BA7F0830B3A7859B60B0");
  scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(1);
  thread scripts\mp\brclientmatchdata::getnextrpgspawnmodule("_encstr_A27C0A1AFD2D3ABE39C85F0B", "_encstr_87571A3ADED9ECC6ACEBCD85665643EDEA3795BEB956E83A9637CECD", 25);
  thread heli_counter();
  setDvar("_encstr_84221339B26E1DC2C947D7360D59D85B07F696B947", "_encstr_B40101");
  setDvar("_encstr_833C171E3A775FEC20213124CB0F6FA07B94B69BC3E717826B", "_encstr_847712E61666CAD0B75DB995FAD9D5376E34F61C");
  scripts\engine\utility::flag_clear("_encstr_ABBD14B98566AC86DB576E59FA467BB793F5EDC156B9");
  level thread _id_12E5E();
  wait 7;
  scripts\cp\cp_objectives::lua_objective_complete("_encstr_847712E61666CAD0B75DB995FAD9D5376E34F61C");
  open_safehouse_door();
}

init_mission_select(var_0) {
  thread scripts\cp\cp_objectives::run_objective("_encstr_A19E0CD5B92F93A976E813639048", "_encstr_BA7F0830B3A7859B60B0");
  level waittill("_encstr_AC3D15D812CD07339F9B5FC465ABF8CBF26AB1789AA575");
  open_safehouse_door();
  scripts\engine\utility::flag_set("_encstr_ABBD14B98566AC86DB576E59FA467BB793F5EDC156B9");
}

_id_12E5F() {
  scripts\mp\vehicles\vehicle_damage_mp::_id_12409("_encstr_AFAD05B58130DB");
  wait 0.25;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A2D82A8CF07DB1C1CDF51B58B96E7DE60BCCB234DB5DDCACFADC5916C96C43FA33B793EBB473E8B2B1FA62C0", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_92A02A315871E2D0ABE7E3FAA0F83F931197D76C2F47532FD1BF87E75BD3934868E06AA16F564B37A18F8D0B", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_83D82A11A001C8F7073130999B6F38102616AB812F7380B58FEB6981B3F76BB9BF670D77C11DC08DAB01ABA3", "_encstr_9A8507BA4040188D08");
}

_id_12E5E() {
  thread _encstr_A7723BA77023197391C64D56AFFF7AD9CB485E7F80FE4C4B8DC8634B989712625010D7ABD073853377FE6A49FC334B24FB5957CFA849ED0AE920B77A6E::_id_123CA();
}

_id_12E5D() {
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_B6F31A8C18579F4AF88199CACB03A62A97E338A70B32D57DEA370AEB");
  _encstr_87AE3B28822A6BB313BB5866905658C3122B52204B89B96B23EFFD6496AEC08DFCD2B860729BE323CEFB874874E7A82FA39B68B1AAB55F1B8EAE04564B::_id_123CB("_encstr_A26D149E50E863B177E153DB52238AA12A052A7940EB");
}

open_safehouse_door() {
  if(!scripts\engine\utility::flag("_encstr_A15B0B8154473327910A282832")) {
    var_0 = scripts\engine\utility::getStruct("_encstr_99E917850B6DD913B72EB856A9D0FA1AE2D3D3CDE94F026303", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_1 scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_AD96140D0A7D35A29225D251E5887AE992F5D328519C", 25, "_encstr_82370F09B522B08D175A6876A32BC8E07B", "_encstr_BD1805CB69C063", 512, 65, 64, 65);

    for(;;) {
      var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

      if(!var_2 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      break;
    }

    var_1 delete();
    scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(0);
    _id_12118();
    level notify("_encstr_ABBD14B98566AC86DB576E59FA467BB793F5EDC156B9");
  } else {
    _id_120BD("_encstr_B11C1947CB50FA8B983BC9736164F7747B63EBCD07D0C5573FF627");
    _id_120BD("_encstr_B41C193BD573E643BD1CFACD1666591ADB5D6EACAF8DB1A50E7D91");
    scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(0, (25571, -12073.5, -180.25), 1024, "_encstr_92E524AB1EBA80F7935F2531670935684FB2D6A3851FA0254ABF073D93B28E70279A933EAD68", "_encstr_AC110A7F14873B5B3D073009");
    scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(0, (25571, -12073.5, -180.25), 1024, "_encstr_8CBE225E3EC333D3AC57D8A02FEF29477AE2C0EC552ACF7B5F5FF81827E4863127C141EF", "_encstr_AC110A7F14873B5B3D073009");
    scripts\mp\vehicles\vehicle_damage_mp::_id_13BC2(0);
  }
}

_id_12118() {
  var_0 = getEnt("_encstr_B4DE178CBBDCFA47BBDCFADC58339543DBEACD597D91DE7B39", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0.og_angles))
    var_0.og_angles = var_0.angles;

  var_0 playSound("_encstr_954E1CE3B9EE1BC319219F97E5F1CB9F98B1B96B40480FBD906F8770D340");
  var_1 = getEnt("_encstr_B6C717C8EEDCAFD1EEE6FA37C2CC95A1DBABB9CAD7368DB407", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 rotateTo((0, -57, 0), 0.5);
  var_1 connectpaths();
  var_1 notsolid();
}

_id_1234E(var_0) {
  var_1 = getEnt("_encstr_8BF10D02D8ADB9A768E8280FFE11EF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEnt("_encstr_84470FCFD7E2A89078CD13CEF259F8E07F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = getEnt("_encstr_B2470FE23BA0E742E077C0E727C00B9F76", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = getEnt("_encstr_A2470FB3D5B9FAB986DE0EAFB958EEBE0D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_12EBD = var_1.origin;
  level._id_12EB9 = var_1.angles;
  level._id_12EB4 = var_2.origin;
  level._id_12EB3 = var_2.angles;
  level._id_12EB6 = var_3.origin;
  level._id_12EB5 = var_3.angles;
  level._id_12EB8 = var_4.origin;
  level._id_12EB7 = var_4.angles;
  level._id_12EBA = [];
  level thread init_key(var_1, 1, undefined, 0);
  level thread init_key(var_2, 1, undefined, 1);
  level thread init_key(var_3, 1, undefined, 2);
  level thread init_key(var_4, 1, undefined, 3);
  objective_setlabel(var_0.objectiveindex, &"_encstr_91B31A36EF19A4A9F06F9B9F25AF50DAD9D5BE4B64896D21684FD7E7");
  objective_position(var_0.objectiveindex, var_1.origin + (0, 0, 70));
}

_id_120BD(var_0) {
  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    var_3 connectpaths();
    var_3 notsolid();
  }
}

heli_counter() {
  heli_convert("_encstr_B11C1947CB50FA8B983BC9736164F7747B63EBCD07D0C5573FF627");
  heli_convert("_encstr_B41C193BD573E643BD1CFACD1666591ADB5D6EACAF8DB1A50E7D91");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(1, (25571, -12073.5, -180.25), 1024, "_encstr_92E524AB1EBA80F7935F2531670935684FB2D6A3851FA0254ABF073D93B28E70279A933EAD68", "_encstr_AC110A7F14873B5B3D073009");
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(1, (25571, -12073.5, -180.25), 1024, "_encstr_8CBE225E3EC333D3AC57D8A02FEF29477AE2C0EC552ACF7B5F5FF81827E4863127C141EF", "_encstr_AC110A7F14873B5B3D073009");
  wait 3;
}

heli_convert(var_0) {
  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    var_3 disconnectPaths();
    var_3 solid();
  }
}

mission_select_think(var_0) {
  level waittill("_encstr_BA3A0D7FB7A387596B26E08D34A350");
  level notify("_encstr_A25A1158A2EADF10FF26E0EE05DBD94793CA88", var_0);
}

show_document(var_0) {
  var_1 = scripts\engine\utility::getStruct(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  self moveTo(var_1.origin, 0.25);
  wait 0.3;

  if(isDefined(var_0))
    wait(var_0);

  self moveTo(scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin, 0.25);
  self rotateTo(scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles, 0.25);
}

return_to_safehouse_vo() {
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_B10227D7C231ABC306070F737938BBE140C94C9D9BB87509530D6B3751C02259B8F087223158072717");
  wait 1;
  scripts\cp\cp_dialogue::play_vo_to_all("_encstr_A7BC29F2700F766BCB30F7E6B196BF3E9560BADAB0EFAF9F8305D4FD569847C2C3D09222F88BE28F1E5798");
}

init_key(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::flag("_encstr_8EF6146379EC978920AB061D3F98CF3798569BEB41CD")) {
    return;
  }
  if(!isDefined(var_0))
    var_4 = getEnt("_encstr_8BF10D02D8ADB9A768E8280FFE11EF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  else
    var_4 = var_0;

  var_4.pbexploitstarttime = var_3;
  var_4 scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_8DE0216805D722BA39AF45BAC97D9E48948A0D51922B549AF2142534965514AF9A05D5", 25, "_encstr_82370F09B522B08D175A6876A32BC8E07B", "_encstr_BD1805CB69C063", 4000, 65, 64, 65);
  _id_12EBB(var_4);
  var_4 thread _id_12EBE(var_1);
  var_4 thread _id_12EC0();
}

_id_12EBB(var_0) {
  if(!isDefined(level._id_12EBC))
    level._id_12EBC = [];

  var_0.head_icon = deleteheadicon(var_0);
  setheadiconfriendlyimage(var_0.head_icon, "_encstr_B60E18394A07F8EF52179FBB678B20E8DEA32691B37AC09E2A8F");
  setheadiconsnaptoedges(var_0.head_icon, 0);
  setheadicondrawthroughgeo(var_0.head_icon, 1);
  addclienttoheadiconmask(var_0.head_icon, 10);
  objective_sethideelevation(var_0.head_icon, 1);
  level._id_12EBC[level._id_12EBC.size] = var_0.head_icon;
}

_id_12EBF() {
  if(isDefined(self.head_icon)) {
    if(scripts\engine\utility::array_contains(level._id_12EBC, self.head_icon)) {
      if(isDefined(self.head_icon)) {
        level._id_12EBC = scripts\engine\utility::array_remove(level._id_12EBC, self.head_icon);
        setheadiconimage(self.head_icon);
      }
    }
  }
}

_id_12EC0() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8F5C086405E70FBA4B4A");
  scripts\engine\utility::flag_wait("_encstr_8EF6146379EC978920AB061D3F98CF3798569BEB41CD");
  _id_12EBF();
  self makeunusable();
}

_id_12EBE(var_0) {
  level endon("_encstr_8EF6146379EC978920AB061D3F98CF3798569BEB41CD");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(istrue(var_1.shoot_vehicle)) {
      var_1 scripts\cp\utility::setlowermessage("_encstr_82A9084471E83D63FFA7", &"_encstr_A102271A05D744EA27BE2AABC9AF3D21922A682A4A2BA8A9BC1489255128222BD7120A658ABE4DA075", 5);
      continue;
    }

    var_1 playlocalsound("_encstr_999B12469361FFC2B8434BDFB7C85B3958587B0A");
    script_struct_add(var_1, self);
    level notify("_encstr_BA3A0D7FB7A387596B26E08D34A350");
    _id_12EBF();

    if(istrue(var_0)) {
      self hide();
      return;
    }
  }
}

script_struct_add(var_0, var_1) {
  var_2 = var_0 gettagorigin("_encstr_81941033E6A7397E4A7713397B01CE0B7BFC");
  var_3 = var_0 gettagangles("_encstr_81941033E6A7397E4A7713397B01CE0B7BFC");
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_4.angles = var_3;
  var_4 setModel("_encstr_B4091F2377E74127FBCF9A5DE3B2F485E9120E90A0AB75B0E39958E1DAF1B6E06B");
  var_4 linkTo(var_0, "_encstr_81941033E6A7397E4A7713397B01CE0B7BFC", (5, 10, 0), (0, 0, 90));
  var_4.pbexploitstarttime = var_1.pbexploitstarttime;
  var_0.shoot_vehicle = 1;
  var_0.x1circletime = var_4;

  if(isDefined(var_1))
    var_1 makeunusable();

  var_0 thread minigun_model();
}

minigun_model() {
  var_0 = scripts\engine\utility::_id_143AF("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_8B1509EC6DF092EF2EB1D3", "_encstr_8CBE0BD1BED30936AB03C0B02B");

  if(!isDefined(self.x1circletime)) {
    return;
  }
  var_1 = self.x1circletime;
  self.shoot_vehicle = undefined;
  self.x1circletime = undefined;
  var_1 unlink();

  if(!scripts\engine\utility::flag("_encstr_8EF6146379EC978920AB061D3F98CF3798569BEB41CD"))
    var_1 makeusable();

  if(isDefined(self.oobendtime) || _id_1213D()) {
    switch (var_1.pbexploitstarttime) {
      case 3:
        var_1.origin = level._id_12EB8;
        var_1.angles = level._id_12EB7;
        break;
      case 2:
        var_1.origin = level._id_12EB6;
        var_1.angles = level._id_12EB5;
        break;
      case 1:
        var_1.origin = level._id_12EB4;
        var_1.angles = level._id_12EB3;
        break;
      case 0:
        var_1.origin = level._id_12EBD;
        var_1.angles = level._id_12EB9;
        break;
      default:
        break;
    }
  } else
    var_1 physicslaunchserver(var_1.origin + (0, 0, 10), (0, 0, -10));

  init_key(var_1, 1, 1, var_1.pbexploitstarttime);
}

_id_1213D() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_820F0E2BEF506F0A41C759C8F848F142", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.radius))
      var_3 = var_2.radius;
    else
      var_3 = 100;

    var_4 = var_3 * var_3;

    if(isDefined(var_2.height))
      var_5 = var_2.height;
    else
      var_5 = 100;

    if(distance2dsquared(self.origin, var_2.origin) < var_4) {
      if(self.origin[2] <= var_2.origin[2] + var_5) {
        if(self.origin[2] >= var_2.origin[2])
          return 1;
      }
    }
  }

  return 0;
}