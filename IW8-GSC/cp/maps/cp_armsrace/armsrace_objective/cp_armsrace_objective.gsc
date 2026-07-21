/****************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_armsrace\armsrace_objective\cp_armsrace_objective.gsc
****************************************************************************/

_id_12B0E() {
  level._effect["_encstr_851213F394D337D9DA78DFDBB6EF69E9F66B3A33B7"] = loadfx("_encstr_8290263B69608F0A2CE1F70F99F8033E88D6F602E66085220A63EFE785F5CA4F90386D8AB0E0568B");
}

registerobjectives() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");

  if(!scripts\engine\utility::flag_exist("_encstr_8C5C24B0E4DAB99C2CD859F5B9830BBBB9AFCCD59B8D8EB4BD37CDEB9CB2B3B46E3A569CAC46"))
    scripts\engine\utility::flag_init("_encstr_8C5C24B0E4DAB99C2CD859F5B9830BBBB9AFCCD59B8D8EB4BD37CDEB9CB2B3B46E3A569CAC46");

  if(!scripts\engine\utility::flag_exist("_encstr_BA621EF9AE385F124B982A8120BD4BDF739F43644BED631A0FD062FAF0D14793"))
    scripts\engine\utility::flag_init("_encstr_BA621EF9AE385F124B982A8120BD4BDF739F43644BED631A0FD062FAF0D14793");

  scripts\cp\cp_remote_tank::init_remote_tank();
  scripts\cp\cp_objectives::registerobjective("_encstr_810E166A884D4117C331F30ADF09CF9983B023337833066B", undefined, ::_id_13832, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_967A0DBD269ABE2C275BDC4E16D859", ::initarmsraceobj, ::startarmsraceobj, ::completearmsraceobj, undefined, ::debugarmsraceobjectivestart);
  scripts\cp\cp_objectives::registerobjective("_encstr_A2F415B7E3CAC0780A25EBC3CEC3801882472D3BBB52BF", undefined, ::_id_13833, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_A9F415ED894DEB2C93DAE6C9856CACBEC89533B2E64664", undefined, ::_id_13834, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_BAF415BD4C9AD75839DA6E27166CACEB8C5633B2CD1966", undefined, ::_id_13835, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_9AF4157B319AAF85936BDC27B0C659AF232BCC95E61986", undefined, ::_id_13836, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_8C7418E57168672216F3EFD3D3B6AAAF98DB9F2D4E88F27A6D8B", undefined, ::_id_13837, undefined, undefined, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_A65E138A68ADA1B341DB0C37FFC947B2EBB053D390", undefined, ::_id_13867, undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A2F415B7E3CAC0780A25EBC3CEC3801882472D3BBB52BF", ::force_kill_off_other_ai);
  thread registerinteractions();
  initobjspawners();
}

force_kill_off_other_ai(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.goalradius = 512;
}

registerinteractions() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!istrue(scripts\engine\utility::flag_exist("_encstr_960E19A6B84EA03D4768D36F0247803180B9C79F1080B9D2433711")))
    scripts\engine\utility::flag_init("_encstr_960E19A6B84EA03D4768D36F0247803180B9C79F1080B9D2433711");

  scripts\engine\utility::flag_wait("_encstr_960E19A6B84EA03D4768D36F0247803180B9C79F1080B9D2433711");
  thread initarms1();
  thread initarms2();
  thread initnuke();
  scripts\engine\utility::flag_set("_encstr_BA621EF9AE385F124B982A8120BD4BDF739F43644BED631A0FD062FAF0D14793");
}

prevcallback(var_0) {
  return scripts\engine\utility::getStruct("_encstr_825B163933A7B6985E63334F8145707573BAF103EAD760B9" + var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;
}

managejumpmasterinfodisplay() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_9961289BC8E67313FFB0FC768183B9392B184F5BA8D9AD292F36846FFE8112D6112173D370F1E651ABF7", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_81D12846E1EB8DC16EEBB158B99BAF2C4EB6E62785D82BFABD4CA9B2B1D12D3B2BD731395AB299FA1918", "_encstr_9A8507BA4040188D08");
  var_0 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("_encstr_9A8507BA4040188D08"));

  if(isDefined(var_0))
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_A26D149E50E863B177E153DB52238AA12A052A7940EB");
}

_id_13832(var_0) {
  scripts\engine\utility::flag_wait("_encstr_8C5C24B0E4DAB99C2CD859F5B9830BBBB9AFCCD59B8D8EB4BD37CDEB9CB2B3B46E3A569CAC46");
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_9963289BC8E67313FFB03D768EA7B9392B184F5BA8D9AD292F36846FFE8112D611215FA39813EF51ABF7", "_encstr_9A8507BA4040188D08");
  thread losqueuelowindex();
  var_1 = scripts\engine\utility::getStruct("_encstr_A77411EFF8C00353BBCEDF5926639AD0692926", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;
  waitforoneplayernearpoint(var_1, 25000);
  start_convoy("_encstr_BAA91919AD16C8C813F77771278B8D39B28701D0954E78702A0FEB", "_encstr_BAA91919AD16C8C813F77771278B8D39B28701D0954E78702A0FEB", "_encstr_AA410D6ED2B9EC8DB296B2AD0E1DCB");
  start_convoy("_encstr_95A919D8DBB9ECEDCBF5E6D12C938EAF132B9DB49BE696739D7DC8", "_encstr_95A919D8DBB9ECEDCBF5E6D12C938EAF132B9DB49BE696739D7DC8", "_encstr_AA410D6ED2B9EC8DB296B2AD0E1DCB");
  level notify("_encstr_9BA0160F45ADC2E2A009A92E23082B6B8FF7B76FC3D68AA9");
  waitforoneplayernearpoint(var_1, 5000);
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_967A0DBD269ABE2C275BDC4E16D859");
}

_id_13867(var_0) {
  level waittill("_encstr_83B514FBF0318B1BCD75A4E79548E79243B8A2A248F9");
}

_id_13833(var_0) {
  scripts\engine\utility::flag_wait("_encstr_8C5C24B0E4DAB99C2CD859F5B9830BBBB9AFCCD59B8D8EB4BD37CDEB9CB2B3B46E3A569CAC46");
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  level waittill("_encstr_B12D17B09BE5278B4FB365708B7791D94FD1A868623B9D2133");
}

_id_13834(var_0) {
  scripts\engine\utility::flag_wait("_encstr_8C5C24B0E4DAB99C2CD859F5B9830BBBB9AFCCD59B8D8EB4BD37CDEB9CB2B3B46E3A569CAC46");
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  level waittill("_encstr_B12D17B09BE5278B4FB365708B7791D94FD1A868623B9D2133");
}

_id_13835(var_0) {
  scripts\engine\utility::flag_wait("_encstr_8C5C24B0E4DAB99C2CD859F5B9830BBBB9AFCCD59B8D8EB4BD37CDEB9CB2B3B46E3A569CAC46");
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  level waittill("_encstr_B12D17B09BE5278B4FB365708B7791D94FD1A868623B9D2133");
}

_id_13836(var_0) {
  scripts\engine\utility::flag_wait("_encstr_8C5C24B0E4DAB99C2CD859F5B9830BBBB9AFCCD59B8D8EB4BD37CDEB9CB2B3B46E3A569CAC46");
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  level waittill("_encstr_B12D17B09BE5278B4FB365708B7791D94FD1A868623B9D2133");
}

_id_13837(var_0) {
  scripts\engine\utility::flag_wait("_encstr_8C5C24B0E4DAB99C2CD859F5B9830BBBB9AFCCD59B8D8EB4BD37CDEB9CB2B3B46E3A569CAC46");
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  level waittill("_encstr_AF451639AE45E713DF66450726774A99AB3757F8CBD8932D");
}

initarmsraceobj(var_0, var_1) {
  if(!istrue(scripts\engine\utility::flag("_encstr_B28C0FB183EB85C9B6E64EC26C95AF6C37")))
    scripts\engine\utility::flag_set("_encstr_B28C0FB183EB85C9B6E64EC26C95AF6C37");

  scripts\engine\utility::flag_wait("_encstr_960E19A6B84EA03D4768D36F0247803180B9C79F1080B9D2433711");
  scripts\engine\utility::flag_wait("_encstr_8C5C24B0E4DAB99C2CD859F5B9830BBBB9AFCCD59B8D8EB4BD37CDEB9CB2B3B46E3A569CAC46");
  scripts\cp\utility::skydivestreamhintdvars("_encstr_8C81097760588BDBC3B657");
  teamhasfreshsquadleadercandidate();
  var_0.cachewid = scripts\cp\cp_objectives::requestworldid("_encstr_A78312C239B5CD270B8D59F58D0B6CD095BA9411");
}

startarmsraceobj(var_0, var_1) {
  scripts\cp\utility::objective_update("_encstr_967A0DBD269ABE2C275BDC4E16D859", undefined, undefined, undefined, undefined, 0);
  setnewarmsracecacheloc(1);
  managejumpmasterinfodisplay();
  waitforoneplayernearpoint(var_0.curcachelocation, 1000);
  scripts\cp\cp_objectives::overridenextstep(var_0, "_encstr_83821C0AF9E0B54A702B7727172FB3E5E0E10716B02B6AF1D613137F7540");
}

docache1() {
  if(!istrue(scripts\engine\utility::flag("_encstr_B28C0FB183EB85C9B6E64EC26C95AF6C37")))
    scripts\engine\utility::flag_set("_encstr_B28C0FB183EB85C9B6E64EC26C95AF6C37");

  scripts\engine\utility::flag_wait("_encstr_960E19A6B84EA03D4768D36F0247803180B9C79F1080B9D2433711");
  scripts\engine\utility::flag_wait("_encstr_8C5C24B0E4DAB99C2CD859F5B9830BBBB9AFCCD59B8D8EB4BD37CDEB9CB2B3B46E3A569CAC46");

  if(!isDefined(level.camper_damage_thread))
    level.camper_damage_thread = 0;

  var_0 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("_encstr_9A8507BA4040188D08"));

  if(isDefined(var_0))
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_A75B1620FA337647FCEB2090C31937C92B65A0A644C71B81");

  level notify("_encstr_A5F520E11AD8B383C0575F2FC761E95B4B279DCBD174800BAF1E3FF8AD82F71EF94A");
  thread scripts\cp\cp_objectives::run_objective("_encstr_A2F415B7E3CAC0780A25EBC3CEC3801882472D3BBB52BF");
  waitforoneplayernearpoint(prevcallback(1), 500);
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8A8A2AA98391D6E803A1F0A952EB591F9B7F3F0D7F3AADC927C638217EB490CC424F3397434160E84A914B93", "_encstr_9A8507BA4040188D08");
  level thread scripts\cp\utility::_id_123FE("_encstr_ABAC180DEDBFA9036B91F7B3E8E3EAB2770D19065FC7924DD6DA");
  level waittill("_encstr_93A91A854EDA6E27C2B1B2EB1B166C34AC267D851BA35ACE2C4795C8");
  level thread loothide(15);
  level thread mp_m_overunder_patch(10);
  thread start_convoy("_encstr_84690A86D708E6DDDB1F477B", "_encstr_960D10A6406818071709D73B228215B69A22");
  wait 1;
  level thread scripts\cp\utility::_id_123FE("_encstr_AD86215DA356D629122FFFDB8BDB5AFBA8158158059410375DB5A0BA3B313723B79FE9");
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_95FE31230FFAD883DCBEB6165B85AF8539B537C958C695D77B319A2BD847D2CEACAF62E63AFADB31537D32ACCC59E646D79881", "_encstr_9A8507BA4040188D08");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8BAA106196BD7363D2DA8D5733A14F686D46");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_84C917F2703B0213F97EAD9F8FA0274A43F2996B38EB3A87B3");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_858519D1DB4F4E60B68B2B67A0DCB01637876E1B82F7072B8A5F8D");
  level thread scripts\cp\cp_wave_spawning::killstreaks(2, "_encstr_BE71102C396BE6270B36CABE1B161B1AAC98");
  level thread scripts\cp\cp_wave_spawning::killstreaks(60.0, "_encstr_978412818B1F1E30C6FB5B37E32E706BC757DE63");
  thread camera_loadout_showcase_preview_sticker_alt4("_encstr_8A4D1C5893D6DC4E8536CAFAB11ABE0763B037E8ACE4D7E0C239D6A5CDEC", 3, "_encstr_933E249A78BDB1E713E1233A8F59BFC9D92892B2A009E2E70BDB35251EE67F0D6318BA0A98D3");
  level thread scripts\cp\utility::objective_update("_encstr_A2F415B7E3CAC0780A25EBC3CEC3801882472D3BBB52BF", 120, 30, 10, 1);
  wait 60.0;
  level thread dosmokecurtains("_encstr_AD1E162CC9AD9BE4B08DACBEB9D6F6B6597D4CF6B6C4BE62", 0);
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_91C617584EB66E932CC659AF380D85CDACC47D1B2C6ECAE437");
  level waittill("_encstr_933E249A78BDB1E713E1233A8F59BFC9D92892B2A009E2E70BDB35251EE67F0D6318BA0A98D3");
  level thread scripts\cp\utility::objective_update("_encstr_A2F415B7E3CAC0780A25EBC3CEC3801882472D3BBB52BF");
  wait 1;
  level notify("_encstr_B12D17B09BE5278B4FB365708B7791D94FD1A868623B9D2133");
  level.camper_damage_thread++;
  level notify("_encstr_9A4714B863FDC9C6B74A89FE22DF09BBA9BBF0D00A97");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_9314331913EF3E085ADFA1B31B82A9F7F3FA7343EA67653975FA55A3332B50C4773183EB233FA8E84CEF4FBF551280055B0AC6DBCF", "_encstr_9A8507BA4040188D08");
  level thread scripts\cp\utility::_id_123FE("_encstr_83AC18D96D2BD973C007B9428AC090CFB9E70FAF18B260FA1722");
}

mp_m_overunder_patch(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 5;
  var_2 = max(var_1, 120 - var_0);
  wait(var_2);
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
}

loothide(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 10;
  var_2 = max(var_1, 120 - var_0);
  level scripts\engine\utility::_id_143BA(var_2, "_encstr_933E249A78BDB1E713E1233A8F59BFC9D92892B2A009E2E70BDB35251EE67F0D6318BA0A98D3", "_encstr_B12D17B09BE5278B4FB365708B7791D94FD1A868623B9D2133");
  var_3 = getEnt("_encstr_812111C88720E1ADB1E20D98BA4AAF8B8A4FE0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 thread _id_1447E();
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8E2414589CDA9BE4B03656FAC1A1B0DC59EBA1DE6323");
  level waittill("_encstr_84341F0FB277AB2D96E2F019EBEDC3228F5A98F536BBD175FC5AE8113343D9F9BB");
  level thread set_guy_to_specific_pos("_encstr_8E2414589CDA9BE4B03656FAC1A1B0DC59EBA1DE6323");
  level waittill("_encstr_AB281AE146D0B7EAB37032A9488BE693890E5799565B67335B203A12");
  thread scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_8E2414589CDA9BE4B03656FAC1A1B0DC59EBA1DE6323");
}

_id_1447E() {
  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(isDefined(var_0) && isPlayer(var_0)) {
      break;
    }
  }

  level notify("_encstr_84341F0FB277AB2D96E2F019EBEDC3228F5A98F536BBD175FC5AE8113343D9F9BB");
}

docache2() {
  if(!istrue(scripts\engine\utility::flag("_encstr_B28C0FB183EB85C9B6E64EC26C95AF6C37")))
    scripts\engine\utility::flag_set("_encstr_B28C0FB183EB85C9B6E64EC26C95AF6C37");

  scripts\engine\utility::flag_wait("_encstr_960E19A6B84EA03D4768D36F0247803180B9C79F1080B9D2433711");
  scripts\engine\utility::flag_wait("_encstr_8C5C24B0E4DAB99C2CD859F5B9830BBBB9AFCCD59B8D8EB4BD37CDEB9CB2B3B46E3A569CAC46");

  if(!isDefined(level.camper_damage_thread))
    level.camper_damage_thread = 0;

  level notify("_encstr_86F52058E4D6379C16D8CABE2C6CE8D23B2C3ACAF55AB9472B39858DA3D2EDCDBE23");
  thread scripts\cp\cp_objectives::run_objective("_encstr_A9F415ED894DEB2C93DAE6C9856CACBEC89533B2E64664");
  waitforoneplayernearpoint(prevcallback(2), 500);
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_99162A5539C9C6309F80ADC8FBEFE0B743E98386D17792A88F2E402FC8035C2B57AF4A2D1230E859CA71E2C9", "_encstr_9A8507BA4040188D08");
  level waittill("_encstr_AB281AE146D0B7EAB37032A9488BE693890E5799565B67335B203A12");
  wait 1;
  level thread dosmokecurtains("_encstr_851E16D2501B6273991ECDFF2E203FACA3A16ACA40DDD13A", 0);
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A38D3141427143035F668710431987AF765992DB62A6F19F279BCC7711837296D54F92504A51FF6295D749B9EABF3801688F0A", "_encstr_9A8507BA4040188D08");
  level thread scripts\cp\utility::_id_123FE("_encstr_8186218F5D62B9D9AB91DB95ED186331A117794A106BA5EF77260937E86515735F16EF");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_83AA10DFEE351B6248F7BD095B1808C67932");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AD7F171627ADCD930B6C56D7E034C2CDB219FA8D0B372B9C9B");
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", undefined, 20000, 30000);
  level thread scripts\cp\cp_wave_spawning::killstreaks(2, "_encstr_BD71105A03F99FCA50A70D2FBF88563B15F3");
  level thread scripts\cp\cp_wave_spawning::killstreaks(60.0, "_encstr_BA841237AAC166DBBAB22FBFE9CA23B362927FCA");
  thread camera_loadout_showcase_preview_sticker_alt4("_encstr_A7D71AB04ED69B9CC2D8CAAFD81AD7C163C29BE82B4EEBE6ABE0954E", 3, "_encstr_AD29244ACAFA57A665A7136337DF8361012ADF9F98788B7653C232C30598C72D8D53587DF461");
  level thread scripts\cp\utility::objective_update("_encstr_A9F415ED894DEB2C93DAE6C9856CACBEC89533B2E64664", 120, 30, 10, 1);
  level waittill("_encstr_AD29244ACAFA57A665A7136337DF8361012ADF9F98788B7653C232C30598C72D8D53587DF461");
  level thread scripts\cp\utility::objective_update("_encstr_A9F415ED894DEB2C93DAE6C9856CACBEC89533B2E64664");
  wait 1;
  level notify("_encstr_B12D17B09BE5278B4FB365708B7791D94FD1A868623B9D2133");
  level.camper_damage_thread++;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  level notify("_encstr_9A4714B863FDC9C6B74A89FE22DF09BBA9BBF0D00A97");
  level thread scripts\cp\utility::_id_123FE("_encstr_9BAC18B5579BD78DE0AF8539AD9BE4161B95EB6C2CC68659AFCC");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_BD1D33DC494166037E2612CA8B56875E80FB433293782FF728F96AB2912D97D340379AA621F1F5DB4276F21AB807DBCF603B7F61E1", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8A203323C3F56C83B9AF5B58B616D7164EB5E69C851BACFAB798A62B8DE8A5D956EBC837237DDE31D4FA36BDDA38C6AC4759FA1981", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A11D33C8C3AF1B07DCF58D2C6E37BE2C39D6CDC958C695AF7B315359C6D15AB359F564E646FADEC4A6EBC6F6AD388DAC8E59BECC06", "_encstr_9A8507BA4040188D08");
}

camera_loadout_showcase_preview_sticker_alt4(var_0, var_1, var_2) {
  if(isDefined(var_2))
    level endon(var_2);

  if(!isDefined(var_1))
    var_1 = 3;

  var_3 = 120 / (var_1 + 1);

  for(;;) {
    thread scripts\cp\cp_modular_spawning::run_spawn_module(var_0);
    wait(var_3);
  }
}

docache3(var_0) {
  var_1 = dropcarepackage();
  setnewarmsracecacheloc(3);
  var_1 waittill("_encstr_A75312C132D5B88DEAFB0B3DE7C2565869CEA899");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0.interaction3);
  var_0.interaction3.crate = var_1;
  var_0.interaction3.active = 1;
  waitforoneplayernearpoint(var_0.curcachelocation, 500);
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AC682A489B21AF2AC71FD57A462F1F86D6CDE8C321D19330AFAAA558C7D9C32BE95F1AE0E9A708B13038615F", var_0.currentteam);
  start_convoy("_encstr_85690AEAA0054B6FE268F08B", "_encstr_810D10AAE0450B2FA228F30CDF2B8B9921AA");
  level waittill("_encstr_BD1B1AD95DD0620B77A18229895F771C38476F2197C02C532F3B9AA2");
  thread scripts\cp\cp_objectives::run_objective("_encstr_BAF415BD4C9AD75839DA6E27166CACEB8C5633B2CD1966");
  wait 1;
  level thread scripts\cp\utility::_id_123FE("_encstr_AA862111FB931FF1E8EF8010CF032B9B7A678026576A3519AF638850D72DE0F9C3012E");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A277100B395B6EC92CD856AF1AB21B4BBE4C");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B67710E72AEF33853E5A588102D74188CFF2");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_9BAA1085276BDCC9C2B195AF0E43C2372BCC");
  level thread scripts\cp\utility::objective_update("_encstr_BAF415BD4C9AD75839DA6E27166CACEB8C5633B2CD1966", 120, 30, 10, 1);
  level thread dosmokecurtains("_encstr_8A1E160B93D66E93B0B12BD7B9D6DBB6AC7DC4DBB513EB99", 5);
  level waittill("_encstr_9B282442F982C7E65013A3AA23F0AF7F3DB14A6A806DBE513863A5851DE9F6F7D18B62926BB5");
  level thread scripts\cp\utility::objective_update("_encstr_BAF415BD4C9AD75839DA6E27166CACEB8C5633B2CD1966");
  wait 1;
  level notify("_encstr_B12D17B09BE5278B4FB365708B7791D94FD1A868623B9D2133");
  var_0.interaction3.active = 0;
  level notify("_encstr_9A4714B863FDC9C6B74A89FE22DF09BBA9BBF0D00A97");
  level thread scripts\cp\utility::_id_123FE("_encstr_93AC18B5AEE6EB36E0AFB04E6B374EB06CAC7D8D0B1B1AACEB43");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A9703379E8A7E0C73377C9DBEF1B984822050333D6C398682A7BDDEBB713DB38CD11834B3F1710BE12A7C7F7E77B91F87477B6ABB2", var_0.currentteam);
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A57033E1CBD99EB04BE9C8618A1391C7A327475547E255017FBE70F9B6FCE8848A877FDDCB8928D082D959B0DDC0B8B573F72FA532", var_0.currentteam);
}

docache4(var_0) {
  if(!istrue(scripts\engine\utility::flag("_encstr_B28C0FB183EB85C9B6E64EC26C95AF6C37")))
    scripts\engine\utility::flag_set("_encstr_B28C0FB183EB85C9B6E64EC26C95AF6C37");

  scripts\engine\utility::flag_wait("_encstr_960E19A6B84EA03D4768D36F0247803180B9C79F1080B9D2433711");
  scripts\engine\utility::flag_wait("_encstr_8C5C24B0E4DAB99C2CD859F5B9830BBBB9AFCCD59B8D8EB4BD37CDEB9CB2B3B46E3A569CAC46");

  if(!isDefined(level.camper_damage_thread))
    level.camper_damage_thread = 0;

  level notify("_encstr_83F5204626FB135A0128AF3F403914FA95378BFF181B3A84A988B7C7C050F7526FF5");
  thread scripts\cp\cp_objectives::run_objective("_encstr_9AF4157B319AAF85936BDC27B0C659AF232BCC95E61986");
  waitforoneplayernearpoint(prevcallback(4), 500);
  level notify("_encstr_95431788534EFD935F5B950F2583BEABF53A71B8FA271B286B");
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AA372A4CD9D1F6F38ED6825A3BE6172E104BD3C203C8BF87B8699A0201BD0723F0472C4C8981454BD2E6275F", "_encstr_9A8507BA4040188D08");
  level waittill("_encstr_9B341817FE3547EE02CFA97670153AB1E7A049CD1363E7119B05");
  start_convoy("_encstr_8A690AD8DB7367F6F2AF0C23", "_encstr_880D1039BF582EF7384FB3DBC93B4C2109D2");
  wait 1;
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_887031C80F7DB1389BAF5B58B5B0EB8539B5DC9C0BD895AFDB26A695368E96D9CAD743D1A1EBBD1353F532B29956B923BE4CC0", "_encstr_9A8507BA4040188D08");
  level thread scripts\cp\utility::_id_123FE("_encstr_848621AFF3AEE17388EEA66A4078AADA0E7BDF5B4BDBBA2E4853DEB77890CEC3DEF7FA");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_99AA10C1A630570A5390D289F0B9069FE92D");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8E0E0E97BAF2C753799F20F953850917");
  level thread scripts\cp\cp_wave_spawning::killstreaks(2, "_encstr_AC7110E0CBB517BB7F63B5A07BA741E91F17");
  level thread scripts\cp\cp_wave_spawning::killstreaks(60.0, "_encstr_8A8412FB4A6DA816AF12B1FE3A8746A887E47FD5");
  thread camera_loadout_showcase_preview_sticker_alt4("_encstr_A3EE1C590E98FFB2EB384AE11069212B507FAEC42DC307FE932092CA8831", 3, "_encstr_8A0D248F584839DB737A7B12EF2AD1A92CA17FF223048B675B4088E5337172983DC844817DBF");
  thread lower_airlock();
  level thread scripts\cp\utility::objective_update("_encstr_9AF4157B319AAF85936BDC27B0C659AF232BCC95E61986", 120, 30, 10, 1);
  wait 40.0;
  level thread dosmokecurtains("_encstr_8A1E160B93D66E93B0B12BD7B9D6DBB6AC7DC4DBB513EB99", 0);
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B21F17B093B5E639586C56BE381AC2372B867D8D85CD569337");
  wait 40.0;
  level notify("_encstr_B8A9206B637A1620D96669260E81F0C352C29FF3F382D0E0E47171F87561B80B0AEB");
  level waittill("_encstr_8A0D248F584839DB737A7B12EF2AD1A92CA17FF223048B675B4088E5337172983DC844817DBF");
  wait 1;
  level notify("_encstr_B12D17B09BE5278B4FB365708B7791D94FD1A868623B9D2133");
  wait 1;
  level.camper_damage_thread++;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  thread scripts\cp\cp_objectives::run_objective("_encstr_8C7418E57168672216F3EFD3D3B6AAAF98DB9F2D4E88F27A6D8B");
  level notify("_encstr_82541C8593B5CD93588D2BAF0B6C474BB30BA356AFDCD56D56FAED1C5937");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AAA3331B4866F3937F30BDF60E2739B9AB98CFDB28592DA9AFB604EF7E01925691A1AA4BF8366F029DC04E6551F1FA0D1BE88FE6D2", "_encstr_9A8507BA4040188D08");
  level notify("_encstr_9A4714B863FDC9C6B74A89FE22DF09BBA9BBF0D00A97");
  thread lossendgame();
  level waittill("_encstr_AF451639AE45E713DF66450726774A99AB3757F8CBD8932D");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8F772F4752A13B53F6F7F3BFD79EE97190583A4AE9A8C579C0A5E3A7DFC572BE8066635320F187E2AAC7EFEBCBE059B1D2", "_encstr_9A8507BA4040188D08");
  level thread scripts\cp\utility::_id_123FE("_encstr_B428202B35C231E7F290038623B7C2D6FFF5E11BD7333147225C41B34377FD725011");
}

lower_airlock() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8711359187D7B138B9F5B658AD2CEB85E4DA9B4E2CC6CA7DDB4C35B28D1D5A6795EB662791F5F631A97DA9ABEC3BFAAC7356DAF2F58960", "_encstr_9A8507BA4040188D08");
  wait 15;
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A5AF344F5AA9334BFEFF97B7F3AFE1696840025291B0FD71D89DEBBFD7CD4AB6886EAADAA9F98F9AA2CFE3F7377C511C6031F769ABDA", "_encstr_9A8507BA4040188D08");
}

completearmsraceobj(var_0) {
  var_0.cachewid = undefined;
  scripts\cp\cp_objectives::freeworldid("_encstr_A78312C239B5CD270B8D59F58D0B6CD095BA9411");
  scripts\mp\brclientmatchdata::getprophealth("_encstr_A9CA0DDB6A4D88A0C312915919234F");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_AA882895B8516793EBEFD088CF118E9B6B65962656CA233EAF23C050EF3C2DFDA201B72D6B73EFE6D902", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_A3AD280C13C172D903C083B0138699AB809737E23A3FBB2E07060D81E64C827B17F168FB73B3AD075702", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_82882819C3AFD807DCAFD60BB60BBEB027DADC270B8D56AFDB31A6B21B1D4BCE56AFF6AE4727BDD78D81", "_encstr_9A8507BA4040188D08");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B4573285C8984E7A93A7FAA9C807D7E375FFA0125901656930401842B15954A897A747B2E0419F09F7236353B8821B3AF7F0CA77", "_encstr_9A8507BA4040188D08");
  wait 4;
}

losqueuehigh() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  level waittill("_encstr_82A21DA8EA76C399F31FF5782CF723B39F6138B8A28F3910C75B8DF8063728");
  var_0 = scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
}

lossendgame() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AF451639AE45E713DF66450726774A99AB3757F8CBD8932D");

  for(;;) {
    wait 10;

    switch (randomintrange(1, 4)) {
      case 1:
        level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8B62339187AF1BE0E6D7B1B037E67DB027ADDCC9166C597DED894D59D8A32DCECABE1AD1D0BEF689A67DBD1C9537AF37C2ECEB13C0", "_encstr_9A8507BA4040188D08");
        break;
      case 2:
        level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_BD6233717B87467032B7391BA31A411F6B42EB3B72DF8DD1CD623D1BDB83C85CDFD98B634AD73070A4472F29C5EDB12877B27E2337", "_encstr_9A8507BA4040188D08");
        break;
      case 3:
      default:
        level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8FF033D2092F98213ECF6F417A5A08AEF350DA9A3A29957F6018BA9F179033456721836BC4C64759CA69A7C2330857F0C17077D229", "_encstr_9A8507BA4040188D08");
        break;
    }
  }
}

losqueuelowindex() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_9BA0160F45ADC2E2A009A92E23082B6B8FF7B76FC3D68AA9");

  for(;;) {
    wait 20;

    switch (randomintrange(1, 4)) {
      case 1:
        level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_8D642DF461694E5B264E1AA21077AF8678237B6AEB20171FC0C102EAB9D5AFBB68DFE8C11DD85EE3E0B88AB2068F82", "_encstr_9A8507BA4040188D08");
        break;
      case 2:
        level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_99642D9BC8E67313FFB0FC768183B9392B184F5BA8D9AD292F36846FFE8112D611215B9F48B1E18377D84EE7C8F5BF", "_encstr_9A8507BA4040188D08");
        break;
      case 3:
      default:
        level scripts\cp\cp_vo::try_to_play_vo_on_team("_encstr_B1E12D230FAFC6079BAFB1C2B9E6AF169CDA379CC21B2BFAF689A6B2B1D1B4CE95EB1A2CCD3BC293FADCC29DF5660C", "_encstr_9A8507BA4040188D08");
        break;
    }
  }
}

_id_13338(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_B13D1069ED60D2DBA77172D9B88FC30F63CF" + var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_1.angles), var_1.angles, (0, 0, 0));
  var_2 setModel(var_1.targetname);
  return var_2;
}

initnuke() {
  var_0 = scripts\engine\utility::getStruct("_encstr_A38417D1626D983E1A9FD39F8FD205602A3E190BCCC7C860A7", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  thread init_silo_thrust_obj(var_0);
  _id_13338(4);
  level thread _id_13515();
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1.trial_target_enemy_killed_func = var_0;
  var_1 setHintString(&"_encstr_8AF71C5E507FEC8D9CE111B1F8E2E565572DE02EDDA71775B709015190CE");
  var_1 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_1 sethintdisplayrange(200);
  var_1 sethintdisplayfov(90);
  var_1 setuserange(72);
  var_1 setusefov(90);
  var_1 sethintonobstruction("_encstr_BECC055CF3811A");
  var_1 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_1 thread camera_loadout_showcase_preview_small_sticker();
}

init_silo_thrust_obj(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  teamhasfreshsquadleadercandidate();
  var_1 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);

  if(isDefined(var_1.angles))
    var_2.angles = var_1.angles;

  var_2 setModel(var_0.script_modelname);
  var_0.cratemodel = var_2;
  var_0.cratemodel solid();
  var_0.cratemodel disconnectPaths();
  heli_leaving_monitor(var_2);
}

camera_loadout_showcase_preview_small_sticker() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_83F5204626FB135A0128AF3F403914FA95378BFF181B3A84A988B7C7C050F7526FF5");
  self._id_11F94 = scripts\engine\utility::getStruct("_encstr_A3741116276B9B272CB1CAFAD8161BA1CAEBD0", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;
  self.objid = scripts\cp\cp_objectives::requestworldid("_encstr_91F213693EA8CF623BE8BA11C0131E1B0185C7C94D");
  objective_state(self.objid, "_encstr_AF5A081BBAC993AC73A3");
  objective_setlocation(self.objid, 0, self._id_11F94);
  objective_icon(self.objid, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setlabel(self.objid, &"_encstr_93C625CF412E8AE96F7E88724A47F0525401371B11A7C5A1F71F42BDAE85281BDD69BFD7E91C7D");
  self makeusable();
  self.secured = 0;

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    self makeunusable();
    thread activationnuke(self, var_0);
    level waittill("_encstr_82541C8593B5CD93588D2BAF0B6C474BB30BA356AFDCD56D56FAED1C5937");
    self makeusable();
    self setHintString(&"_encstr_85861995F98750E17CB7637D9D12290FAFC060FF704F9039C54D6D");
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    self makeunusable();
    thread activationnuke(self, var_0);
    level waittill("_encstr_AF451639AE45E713DF66450726774A99AB3757F8CBD8932D");
    objective_delete(self.objid);
    scripts\cp\cp_objectives::freeworldid("_encstr_91F213693EA8CF623BE8BA11C0131E1B0185C7C94D");
    break;
  }
}

hintnuke(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_967A0DBD269ABE2C275BDC4E16D859");

  if(istrue(var_2.nukeinteraction.active)) {
    if(istrue(var_2.nukeinteraction.secured))
      return &"_encstr_85861995F98750E17CB7637D9D12290FAFC060FF704F9039C54D6D";
    else
      return &"_encstr_8AF71C5E507FEC8D9CE111B1F8E2E565572DE02EDDA71775B709015190CE";
  } else
    return "_encstr_B40101";
}

activationnuke(var_0, var_1) {
  if(!istrue(var_0.secured)) {
    level notify("_encstr_9B341817FE3547EE02CFA97670153AB1E7A049CD1363E7119B05");
    var_0.secured = 1;
  } else
    thread _id_1212A(var_0.trial_target_enemy_killed_func.cratemodel);
}

initarms1() {
  var_0 = scripts\engine\utility::getStruct("_encstr_A78417859CB53727161B2BAFB4CD1DAC2716C63AD2B773BE4C", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  scripts\cp\cp_interaction::spawninteractionmodel(var_0, scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  _id_13338(1);
  var_1 setHintString(&"_encstr_A50D1D95EA5F7926A86F9B851F0116411B3790EFC7EB11E6B08797AB4FD8D5");
  var_1 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_1 sethintdisplayrange(200);
  var_1 sethintdisplayfov(90);
  var_1 setuserange(72);
  var_1 setusefov(90);
  var_1 sethintonobstruction("_encstr_BECC055CF3811A");
  var_1 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_1 thread camera_loadout_showcase_preview_large_sticker_alt3();
  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_A2F415B7E3CAC0780A25EBC3CEC3801882472D3BBB52BF");
  var_2.interaction = var_1;
}

camera_loadout_showcase_preview_large_sticker_alt3() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_A5F520E11AD8B383C0575F2FC761E95B4B279DCBD174800BAF1E3FF8AD82F71EF94A");
  self._id_11F94 = scripts\engine\utility::getStruct("_encstr_A77411EFF8C00353BBCEDF5926639AD0692926", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;
  self.objid = scripts\cp\cp_objectives::requestworldid("_encstr_86D913B04EDA379316C695AF8DC2B11A2B62AE9222");
  objective_state(self.objid, "_encstr_AF5A081BBAC993AC73A3");
  objective_setplayintro(self.objid, 1);
  objective_setplayoutro(self.objid, 1);
  objective_setlocation(self.objid, 0, self._id_11F94);
  objective_icon(self.objid, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setlabel(self.objid, &"_encstr_93C625CF412E8AE96F7E88724A47F0525401371B11A7C5A1F71F42BDAE85281BDD69BFD7E91C7D");
  self makeusable();

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    self makeunusable();
    thread activationarms1(self, var_0);
    level waittill("_encstr_B12D17B09BE5278B4FB365708B7791D94FD1A868623B9D2133");
    objective_delete(self.objid);
    scripts\cp\cp_objectives::freeworldid("_encstr_86D913B04EDA379316C695AF8DC2B11A2B62AE9222");
    break;
  }
}

activationarms1(var_0, var_1) {
  if(var_1 play_takephoto_anim())
    level notify("_encstr_93A91A854EDA6E27C2B1B2EB1B166C34AC267D851BA35ACE2C4795C8");
}

initarms2() {
  var_0 = scripts\engine\utility::getStruct("_encstr_9B84172C9C5BE62758D8ACFAA5E647AC4E58B1A34BED37BE46", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  scripts\cp\cp_interaction::spawninteractionmodel(var_0, scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  _id_13338(2);
  var_1 setHintString(&"_encstr_A50D1D95EA5F7926A86F9B851F0116411B3790EFC7EB11E6B08797AB4FD8D5");
  var_1 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_1 sethintdisplayrange(200);
  var_1 sethintdisplayfov(90);
  var_1 setuserange(72);
  var_1 setusefov(90);
  var_1 sethintonobstruction("_encstr_BECC055CF3811A");
  var_1 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_1 thread camera_loadout_showcase_preview_large_stock_alt1();
  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_A9F415ED894DEB2C93DAE6C9856CACBEC89533B2E64664");
  var_2.interaction = var_1;
}

camera_loadout_showcase_preview_large_stock_alt1() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_86F52058E4D6379C16D8CABE2C6CE8D23B2C3ACAF55AB9472B39858DA3D2EDCDBE23");
  self._id_11F94 = scripts\engine\utility::getStruct("_encstr_A17411025BA1D78228EF556787408EC3DD96AF", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;
  self.objid = scripts\cp\cp_objectives::requestworldid("_encstr_B4C213F9F36776589EA3730FCBC688B3EF4FB76478");
  objective_state(self.objid, "_encstr_AF5A081BBAC993AC73A3");
  objective_setlocation(self.objid, 0, self._id_11F94);
  objective_icon(self.objid, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setlabel(self.objid, &"_encstr_93C625CF412E8AE96F7E88724A47F0525401371B11A7C5A1F71F42BDAE85281BDD69BFD7E91C7D");
  self makeusable();

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    self makeunusable();
    thread activationarms2(self, var_0);
    level waittill("_encstr_B12D17B09BE5278B4FB365708B7791D94FD1A868623B9D2133");
    objective_delete(self.objid);
    scripts\cp\cp_objectives::freeworldid("_encstr_B4C213F9F36776589EA3730FCBC688B3EF4FB76478");
    break;
  }
}

activationarms2(var_0, var_1) {
  if(var_1 play_takephoto_anim())
    level notify("_encstr_AB281AE146D0B7EAB37032A9488BE693890E5799565B67335B203A12");
}

initarms3(var_0) {
  if(var_0.size > 0) {
    var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_967A0DBD269ABE2C275BDC4E16D859");
    var_1.interaction3 = var_0[0];
    var_1.interaction3.active = 0;
    var_1.interaction3.secured = 0;
    scripts\cp\cp_interaction::spawninteractionmodel(var_0[0], scripts\engine\utility::getStruct(var_0[0].target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  }
}

hintarms3(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_967A0DBD269ABE2C275BDC4E16D859");

  if(istrue(var_2.interaction3.active)) {
    if(istrue(var_2.interaction3.secured))
      return &"_encstr_BD571A70C1FFED337C806972B1674BA66FF13EF9A117517F75E6785D";
    else
      return &"_encstr_A50D1D95EA5F7926A86F9B851F0116411B3790EFC7EB11E6B08797AB4FD8D5";
  } else
    return "_encstr_B40101";
}

activationarms3(var_0, var_1) {
  var_2 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_967A0DBD269ABE2C275BDC4E16D859");

  if(!istrue(var_2.interaction3.active)) {
    return;
  }
  if(var_1 play_takephoto_anim()) {
    level notify("_encstr_BD1B1AD95DD0620B77A18229895F771C38476F2197C02C532F3B9AA2");
    var_2.interaction3.active = 0;

    if(isDefined(var_0.crate)) {
      var_3 = _id_13338(3);
      var_3.angles = scripts\engine\utility::ter_op(isDefined(var_0.crate.angles), var_0.crate.angles, (0, 0, 0));
      waitframe();
      var_3.origin = scripts\cp\utility::get_point_in_local_ent_space(var_0.crate, (-17.61, -24.7, 49.332));
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  }
}

initobjspawners() {
  if(scripts\engine\utility::flag_exist("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B"))
    scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  if(!scripts\engine\utility::flag_exist("_encstr_960E19A6B84EA03D4768D36F0247803180B9C79F1080B9D2433711"))
    scripts\engine\utility::flag_init("_encstr_960E19A6B84EA03D4768D36F0247803180B9C79F1080B9D2433711");

  scripts\engine\utility::flag_wait("_encstr_960E19A6B84EA03D4768D36F0247803180B9C79F1080B9D2433711");
  var_0 = scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var_0]]("_encstr_8BAA106196BD7363D2DA8D5733A14F686D46", 0, 16, 200, 0.5, undefined, "_encstr_8BAA106196BD7363D2DA8D5733A14F686D46", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_83AA10DFEE351B6248F7BD095B1808C67932", 4, 6, 100, [::waitbetweenspawnwaveswithtimeout, 0.1, 5], undefined, "_encstr_83AA10DFEE351B6248F7BD095B1808C67932", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_AD7F171627ADCD930B6C56D7E034C2CDB219FA8D0B372B9C9B", 4, 8, 100, 0.25, undefined, "_encstr_AD7F171627ADCD930B6C56D7E034C2CDB219FA8D0B372B9C9B", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AD7F171627ADCD930B6C56D7E034C2CDB219FA8D0B372B9C9B", ::infectedairdroppositions);
  [[var_0]]("_encstr_8E2414589CDA9BE4B03656FAC1A1B0DC59EBA1DE6323", 8, 12, 100, 0.25, undefined, "_encstr_8E2414589CDA9BE4B03656FAC1A1B0DC59EBA1DE6323", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8E2414589CDA9BE4B03656FAC1A1B0DC59EBA1DE6323", ::camsetorbit);
  [[var_0]]("_encstr_9BAA1085276BDCC9C2B195AF0E43C2372BCC", 10, 10, 200, [::waitbetweenspawnwaveswithtimeout, 0.1, 10], undefined, "_encstr_9BAA1085276BDCC9C2B195AF0E43C2372BCC", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_99AA10C1A630570A5390D289F0B9069FE92D", 0, 6, 200, [::waitbetweenspawnwaveswithtimeout, 0.1, 10], undefined, "_encstr_99AA10C1A630570A5390D289F0B9069FE92D", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_ABAA100E6E836B124970E7078380F9937B25", 15, 15, 200, [::waitbetweenspawnwaveswithtimeout, 0.1, 10], undefined, "_encstr_ABAA100E6E836B124970E7078380F9937B25", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_8E0E0E97BAF2C753799F20F953850917", 0, 2, 2, 0.5, undefined, "_encstr_8E0E0E97BAF2C753799F20F953850917", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_BDEB175636CB236A3138BF4FB848316BA3ED514A906BCB85BB", 2, 2, 2, 0.5, undefined, "_encstr_BDEB175636CB236A3138BF4FB848316BA3ED514A906BCB85BB", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_91C617584EB66E932CC659AF380D85CDACC47D1B2C6ECAE437", 6, 6, 6, 0.5, undefined, "_encstr_91C617584EB66E932CC659AF380D85CDACC47D1B2C6ECAE437");
  [[var_0]]("_encstr_B21F17B093B5E639586C56BE381AC2372B867D8D85CD569337", 3, 3, 3, 0.5, undefined, "_encstr_B21F17B093B5E639586C56BE381AC2372B867D8D85CD569337");
  [[var_0]]("_encstr_84C917F2703B0213F97EAD9F8FA0274A43F2996B38EB3A87B3", 1, 1, 1, 0.5, undefined, "_encstr_84C917F2703B0213F97EAD9F8FA0274A43F2996B38EB3A87B3", ::watchforstopwaves, ::_id_1445E);
  [[var_0]]("_encstr_858519D1DB4F4E60B68B2B67A0DCB01637876E1B82F7072B8A5F8D", 1, 1, 1, 0.5, undefined, "_encstr_858519D1DB4F4E60B68B2B67A0DCB01637876E1B82F7072B8A5F8D", ::watchforstopwaves, ::_id_1445E);
  [[var_0]]("_encstr_AF471239AE45E713DF664507E3FE2B8FB78767DA", 6, 6, 6, [::waitbetweenspawnwaveswithtimeout, 0.1, 5], undefined, "_encstr_8F1115A3CAD843EDAF07A15ECDD758276BE6E416D82BC4", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_8D4712E7688F628B634EE87FC3C26D71823371EF", 6, 6, 6, [::waitbetweenspawnwaveswithtimeout, 0.1, 5], undefined, "_encstr_B81115D3EF029828D15878891FEFB9DBDF06AE715F9DDF", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_993F180B0BFB1DBFD1C5AF846FBB1BA355882271E8BD14FB8936", 2, 2, 2, 0.5, undefined, "_encstr_993F180B0BFB1DBFD1C5AF846FBB1BA355882271E8BD14FB8936");
  [[var_0]]("_encstr_AACE15E085F263DB0B19EB1B2CCDA3A34E56B67DC9C13B", 2, 2, 2, 0.5, undefined, "_encstr_993F180B0BFB1DBFD1C5AF846FBB1BA355882271E8BD14FB8936");
  [[var_0]]("_encstr_8C0F21C2F110B4227F01BF3F5511ABE288193F81E8484CFACD3F13CF5F4B332B70A172", 1, 1, 1, 0.5, undefined, "_encstr_8C0F21C2F110B4227F01BF3F5511ABE288193F81E8484CFACD3F13CF5F4B332B70A172");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8C0F21C2F110B4227F01BF3F5511ABE288193F81E8484CFACD3F13CF5F4B332B70A172", ::grenade_structs);
  [[var_0]]("_encstr_8A4D1C5893D6DC4E8536CAFAB11ABE0763B037E8ACE4D7E0C239D6A5CDEC", 1, 1, 1, 0.5, undefined, "_encstr_A7D71AB04ED69B9CC2D8CAAFD81AD7C163C29BE82B4EEBE6ABE0954E");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8A4D1C5893D6DC4E8536CAFAB11ABE0763B037E8ACE4D7E0C239D6A5CDEC", ::camoname);
  [[var_0]]("_encstr_A7D71AB04ED69B9CC2D8CAAFD81AD7C163C29BE82B4EEBE6ABE0954E", 1, 1, 1, 0.5, undefined, "_encstr_A7D71AB04ED69B9CC2D8CAAFD81AD7C163C29BE82B4EEBE6ABE0954E");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A7D71AB04ED69B9CC2D8CAAFD81AD7C163C29BE82B4EEBE6ABE0954E", ::camoset);
  [[var_0]]("_encstr_A3EE1C590E98FFB2EB384AE11069212B507FAEC42DC307FE932092CA8831", 1, 1, 1, 0.5, undefined, "_encstr_A7D71AB04ED69B9CC2D8CAAFD81AD7C163C29BE82B4EEBE6ABE0954E");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A3EE1C590E98FFB2EB384AE11069212B507FAEC42DC307FE932092CA8831", ::cameraentlinktag);

  if(!scripts\engine\utility::flag_exist("_encstr_8C5C24B0E4DAB99C2CD859F5B9830BBBB9AFCCD59B8D8EB4BD37CDEB9CB2B3B46E3A569CAC46"))
    scripts\engine\utility::flag_init("_encstr_8C5C24B0E4DAB99C2CD859F5B9830BBBB9AFCCD59B8D8EB4BD37CDEB9CB2B3B46E3A569CAC46");

  scripts\engine\utility::flag_set("_encstr_8C5C24B0E4DAB99C2CD859F5B9830BBBB9AFCCD59B8D8EB4BD37CDEB9CB2B3B46E3A569CAC46");
}

infectedairdroppositions(var_0) {
  infecteddisablenvg();
}

infecteddisablenvg() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  wait 1;
  var_0 = 1000;
  self.maxfaceenemydist = var_0;
  scripts\cp\cp_modular_spawning::set_goal_radius(var_0 * 0.65);

  for(;;) {
    var_1 = var_0;
    var_2 = scripts\cp\utility::get_closest_living_player(36000000);

    if(isDefined(var_2))
      var_1 = distance(self.origin, var_2.origin);

    if(var_1 < var_0) {
      scripts\common\utility::demeanor_override("_encstr_931904C66102");
      self.maxfaceenemydist = var_0;
    } else
      scripts\common\utility::demeanor_override("_encstr_92100762872552A643");

    wait 2;
  }
}

waittill_any_return_1() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0[0] = "_encstr_91DC0F8E853B7D36586EAC93FA6EA1DEBB";
  var_0[1] = "_encstr_868D0F80A747F6C102D2B5C6216A3359AD";
  var_0[2] = "_encstr_BA991101FFE81FF0F940C80B5F70A11312F2A9";
  var_0[3] = "_encstr_9A1E0A3A85B3F5632CB9954E";

  for(;;) {
    wait 1;
    self laseroff();

    foreach(var_2 in var_0) {
      if(self tagexists(var_2))
        self hidepart(var_2);
    }
  }
}

camsetorbit(var_0) {
  self.never_kill_off = 1;
  thread can_activate_battle_station(var_0);
}

can_activate_battle_station(var_0) {
  if(isDefined(var_0.group_name))
    var_1 = var_0.group_name;
  else if(isDefined(self.enemy_group))
    var_1 = self.enemy_group;
  else
    var_1 = "_encstr_8B1608EC43B8D647A113";

  if(!isDefined(level.bomb_vest_timer_remaining_time_ms) || !istrue(level.bomb_vest_timer_remaining_time_ms[var_1]))
    thread bomb_vest_timer_remaining_num_of_frame(scripts\engine\utility::getStructArray("_encstr_82490B0F2B87EACA49417DC618", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), 400, 0, 200);
  else {
    self.never_kill_off = 0;
    scripts\cp\cp_modular_spawning::set_goal_radius(300);
  }
}

bomb_vest_timer_remaining_num_of_frame(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    var_1 = 400;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  thread bomb_vest_explodes(var_0, var_2, var_3);
  thread bomb_vest_timer_yellow_starting_frame(var_1, var_2);
  thread bomb_vest_timer_total_num_of_frame(var_4);
}

bomb_vest_success_fail_think(var_0, var_1, var_2) {
  foreach(var_4 in var_0)
  level thread bomb_vest_timer_frozen(var_4, var_1, var_2);
}

bomb_vest_timer_frozen(var_0, var_1, var_2) {
  level endon("_encstr_858B128F9DDBCF836898F14F46CADA42757B175B");
  var_0 notify("_encstr_9A6C0EF13B662B5D5958812A489D13DF");
  var_0 endon("_encstr_9A6C0EF13B662B5D5958812A489D13DF");
  var_3 = pressure_overload_threshold(var_0, var_2);

  for(;;) {
    var_4 = var_0.origin;

    if(isDefined(var_0.radius))
      var_5 = var_0.radius;
    else
      var_5 = 600;

    level thread scripts\engine\utility::draw_circle(var_4, var_5, (1, 1, 0), 0.5, 0, 20);

    if(isDefined(var_0._id_127EA) && var_0._id_127EA.size) {
      foreach(var_9, var_7 in var_0._id_127EA) {
        if(isDefined(var_7) && isai(var_7) && isalive(var_7)) {
          var_8 = var_7 getentitynumber();

          if(!isDefined(var_8))
            var_8 = "_encstr_AA15062C769537A3";
        }
      }
    }

    wait 1;
  }
}

bomb_vest_explodes(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_858B128F9DDBCF836898F14F46CADA42757B175B");
  self endon("_encstr_858B128F9DDBCF836898F14F46CADA42757B175B");
  self endon("_encstr_AD75063D571AE108");
  var_3 = undefined;

  for(;;) {
    var_3 = printdata(var_0, var_2);
    _id_13F8A(self, var_3);
    var_4 = var_3.origin;

    if(isDefined(var_3.radius))
      var_5 = var_3.radius;
    else
      var_5 = 600;

    self.script_origin_other = var_4;
    scripts\cp\cp_modular_spawning::set_goal_pos(var_4);
    scripts\cp\cp_modular_spawning::set_goal_radius(var_5);
    scripts\common\utility::demeanor_override("_encstr_92100762872552A643");
    wait 15;
  }
}

printdata(var_0, var_1) {
  var_2 = printcodeentered(var_0);
  var_3 = var_2.origin;
  var_0 = sortbydistance(var_0, var_3);

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(!triggeregg(var_0[var_4], var_1))
      return var_0[var_4];
  }

  return protect_obj_a(var_0);
}

printcodeentered(var_0) {
  var_1 = var_0[0];
  var_2 = 1000000;

  foreach(var_4 in var_0) {
    var_5 = var_4 scripts\cp\utility::get_closest_living_player(36000000);

    if(!isDefined(var_5))
      return scripts\engine\utility::random(var_0);

    var_6 = distance(var_5.origin, var_4.origin);

    if(var_6 < var_2) {
      var_2 = var_6;
      var_1 = var_4;
    }
  }

  return var_1;
}

protect_obj_a(var_0) {
  var_1 = var_0[0];

  if(isDefined(var_1.script_priority))
    var_2 = int(var_1.script_priority);
  else
    var_2 = 0;

  for(var_3 = 1; var_3 < var_0.size; var_3++) {
    if(isDefined(var_0[var_3].script_priority)) {
      if(!isDefined(var_0[var_3 - 1].script_priority) || var_2 < int(var_0[var_3].script_priority)) {
        var_2 = int(var_0[var_3].script_priority);
        var_1 = var_0[var_3];
      }
    }
  }

  return var_1;
}

_id_134D1(var_0) {
  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    for(var_2 = var_1 + 1; var_2 < var_0.size; var_2++) {
      var_3 = 0;

      if(isDefined(var_0[var_2].script_priority))
        var_3 = int(var_0[var_2].script_priority);

      var_4 = 0;

      if(isDefined(var_0[var_1].script_priority))
        var_4 = int(var_0[var_1].script_priority);

      if(var_3 < var_4) {
        var_5 = var_0[var_2];
        var_0[var_2] = var_0[var_1];
        var_0[var_1] = var_5;
      }
    }
  }
}

quickdropfinditemincache(var_0) {
  var_1 = prematchplayedwelcomevo();
  var_2 = scripts\engine\utility::random(var_1);
  var_3 = 1000000;

  foreach(var_5 in var_0) {
    var_6 = var_5 scripts\cp\utility::get_closest_living_player(36000000);

    if(!isDefined(var_6)) {
      continue;
    }
    var_7 = distance(var_6.origin, var_5.origin);

    if(var_7 < var_3) {
      var_3 = var_7;
      var_2 = var_6;
    }
  }

  return var_2;
}

prematchplayedwelcomevo() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isalive(var_2) && !scripts\cp\cp_laststand::player_in_laststand(var_2))
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_13F8A(var_0, var_1) {
  if(scripts\engine\utility::array_contains(var_1._id_127EA, var_0))
    return 0;

  if(isDefined(var_0.initheadlessoperatorcustomization) && var_0.initheadlessoperatorcustomization == var_1)
    return 0;

  if(isDefined(var_0.initheadlessoperatorcustomization) && scripts\engine\utility::array_contains(var_0.initheadlessoperatorcustomization._id_127EA, var_0))
    var_0.initheadlessoperatorcustomization._id_127EA = scripts\engine\utility::array_remove(var_0.initheadlessoperatorcustomization._id_127EA, var_0);

  var_0.initheadlessoperatorcustomization = var_1;
  var_1._id_127EA[var_1._id_127EA.size] = var_0;
  return 1;
}

triggeregg(var_0, var_1) {
  if(!isDefined(var_0._id_127EA)) {
    var_0._id_127EA = [];
    return 0;
  }

  var_2 = pressure_overload_threshold(var_0, var_1);
  var_3 = [];

  foreach(var_5 in var_0._id_127EA) {
    if(!isDefined(var_5) || !isalive(var_5)) {
      continue;
    }
    var_6 = 1;

    foreach(var_8 in var_3) {
      if(var_5 == var_8) {
        var_6 = 0;
        break;
      }
    }

    if(var_6)
      var_3[var_3.size] = var_5;
  }

  var_0._id_127EA = var_3;
  var_11 = var_0._id_127EA.size;
  return var_11 >= var_2;
}

pressure_overload_threshold(var_0, var_1) {
  if(var_1 < 1)
    var_1 = 1;

  if(!isDefined(var_0.radius))
    var_2 = 600;
  else
    var_2 = int(var_0.radius);

  return int(max(1, var_2 / var_1));
}

bomb_vest_timer_yellow_starting_frame(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0))
    var_0 = 400;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(self.origin, var_0 * var_0)) {
      break;
    }

    wait 0.25;
  }

  if(istrue(var_1)) {
    var_2 = "_encstr_8B1608EC43B8D647A113";

    if(isDefined(self.enemy_group))
      var_2 = self.enemy_group;

    set_guy_to_specific_pos(var_2);
  } else
    bomb_vest_timer_red_starting_frame();
}

bomb_vest_timer_red_starting_frame() {
  self notify("_encstr_858B128F9DDBCF836898F14F46CADA42757B175B");
}

set_guy_to_specific_pos(var_0) {
  if(!isDefined(level.bomb_vest_timer_remaining_time_ms))
    level.bomb_vest_timer_remaining_time_ms = [];

  level.bomb_vest_timer_remaining_time_ms[var_0] = 1;
  level notify("_encstr_858B128F9DDBCF836898F14F46CADA42757B175B");
}

bomb_vest_timer_total_num_of_frame(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level scripts\cp\utility::add_wait(scripts\cp\utility::waittill_msg, "_encstr_858B128F9DDBCF836898F14F46CADA42757B175B");
  scripts\cp\utility::add_wait(scripts\cp\utility::waittill_msg, "_encstr_858B128F9DDBCF836898F14F46CADA42757B175B");
  scripts\cp\utility::do_wait_any();
  scripts\common\utility::demeanor_override("_encstr_AA7C07466F9DA30713");
  self.never_kill_off = 0;
  self.script_origin_other = undefined;

  if(isDefined(var_0))
    self thread[[var_0]]();
  else {
    var_1 = 300;
    scripts\cp\cp_modular_spawning::set_goal_radius(var_1);
    thread scripts\cp\cp_modular_spawning::get_enemy_info_loop();
  }
}

_id_13515() {
  wait 1;
  var_0 = scripts\engine\utility::getStructArray("_encstr_823C14A3BA4F91D8C6FC2F6DF0AF9167F772588B13CF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = scripts\cp\cp_weapon::buildweapon(var_2.script_noteworthy, [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
    var_4 = createheadicon(var_3);
    var_5 = spawn("_encstr_B2010820C5337B67C8CF" + var_4, var_2.origin);

    if(!isDefined(var_2.angles))
      var_2.angles = (0, 0, 0);

    var_5.angles = var_2.angles;
    var_5 itemweaponsetammo(weaponclipsize(var_3), weaponmaxammo(var_3));
  }
}

waitbetweenspawnwaveswithtimeout(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_4 = gettime();
  var_5 = var_4 + var_2 * 1000;

  for(var_6 = getaiarray("_encstr_8E8405EA382B2A").size; var_6 >= 18; var_6 = getaiarray("_encstr_8E8405EA382B2A").size)
    wait 1;

  return var_1;
}

_id_1445E(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 4;

  while(var_0.activecount > 0)
    wait 1;

  wait 5;
  return var_0.group_name;
}

watchforstopwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread _watchforstopwaves(var_0);
}

_watchforstopwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_B12D17B09BE5278B4FB365708B7791D94FD1A868623B9D2133");
  level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

remove_group_from_combined_module_counters(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B12D17B09BE5278B4FB365708B7791D94FD1A868623B9D2133");
  wait(var_1);

  for(var_2 = getaiarray("_encstr_8E8405EA382B2A").size; var_2 >= 18; var_2 = getaiarray("_encstr_8E8405EA382B2A").size)
    wait 4;

  return var_0.group_name;
}

grenade_structs(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.scripted_mode = 1;
  self.ignoreall = 1;
  self.goalradius = 64;
  self setgoalpos(scripts\engine\utility::getStruct(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin);
  scripts\engine\utility::_id_143A5("_encstr_8B7205D9ED5958", "_encstr_B4D10ADC950BE4EB76DE8536");
  var_1 = scripts\engine\utility::getStruct("_encstr_BA831730D1E7C587F8F7B681AF78F889B7C6F77F55339F3BB8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread throw_molotov(var_1, var_2);
  self.ignoreall = 0;
  self.goalradius = 1024;
  self.scripted_mode = 0;
}

camoname(var_0) {
  var_1 = &"_encstr_93C625CF412E8AE96F7E88724A47F0525401371B11A7C5A1F71F42BDAE85281BDD69BFD7E91C7D";
  thread cameraentmoving(var_0, "_encstr_A78417859CB53727161B2BAFB4CD1DAC2716C63AD2B773BE4C", "_encstr_A2F415B7E3CAC0780A25EBC3CEC3801882472D3BBB52BF", var_1);
}

camoset(var_0) {
  var_1 = &"_encstr_93C625CF412E8AE96F7E88724A47F0525401371B11A7C5A1F71F42BDAE85281BDD69BFD7E91C7D";
  thread cameraentmoving(var_0, "_encstr_9B84172C9C5BE62758D8ACFAA5E647AC4E58B1A34BED37BE46", "_encstr_A9F415ED894DEB2C93DAE6C9856CACBEC89533B2E64664", var_1);
}

cameraentlinktag(var_0) {
  var_1 = &"_encstr_93C625CF412E8AE96F7E88724A47F0525401371B11A7C5A1F71F42BDAE85281BDD69BFD7E91C7D";
  thread cameraentmoving(var_0, "_encstr_A38417D1626D983E1A9FD39F8FD205602A3E190BCCC7C860A7", "_encstr_9AF4157B319AAF85936BDC27B0C659AF232BCC95E61986", var_1);
}

cameraentmoving(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  scripts\common\utility::demeanor_override("_encstr_92100762872552A643");
  self notify("_encstr_96BD0D89D20F0BA061D3777BFAD620");
  wait 1;

  if(isDefined(var_2) && !scripts\cp\cp_objectives::is_objective_active(var_2)) {
    return;
  }
  var_4 = scripts\engine\utility::getStructArray("_encstr_82C70C1FF9201AE620D1EA3609F8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = 350;
  var_6 = scripts\engine\utility::getStruct(var_1, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_7 = [];
  var_8 = [];

  foreach(var_10 in var_4) {
    if(isDefined(var_10) && scripts\engine\utility::distance_2d_squared(var_6.origin, var_10.origin) < var_5 * var_5) {
      if(!istrue(var_10.planted))
        var_8[var_8.size] = var_10;

      var_7[var_7.size] = var_10;
    }
  }

  if(var_8.size == 0)
    var_8 = var_7;

  var_12 = scripts\engine\utility::random(var_8);
  var_12.planted = 1;
  thread camera_loadout_showcase_preview_sticker_alt3(var_12);

  if(!isDefined(var_12.model)) {
    var_12.model = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", scripts\engine\utility::getStruct(var_12.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin);
    var_12.model setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_12.model.angles = scripts\engine\utility::getStruct(var_12.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").angles;
  }

  _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::run_to_and_plant_bomb(var_12.model);
  level thread camera_loadout_showcase_preview_sticker_alt2(var_2, var_12, self, var_3);
}

camera_loadout_showcase_preview_sticker_alt3(var_0) {
  self endon("_encstr_AB3D0DE25FE81EF7B7188A42230553");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_0) && istrue(var_0.planted))
    var_0.planted = undefined;
}

camera_loadout_showcase_preview_sticker_alt2(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_1) || !isDefined(var_1.model) || !isDefined(var_1.model.charge)) {
    return;
  }
  var_4 = "_encstr_923E0CB30235F05EE76AF9A672EA" + var_2.entity_number;
  var_5 = scripts\cp\cp_objectives::requestworldid(var_4, 15);
  var_6 = var_1.model.charge;
  var_6.leave_pool_behind_after_deactivation = 25;
  var_6 follow_players_when_close(var_5);
  var_6 thread camera_loadout_showcase_preview_sticker_alt1(var_0, var_1, var_3, var_5);
  var_7 = &"_encstr_BD30110D05AF9AA225922D8ABC44A291556A51";
  var_6 scripts\cp\utility::create_cursor_hint("_encstr_A2B40B8E2C3B7DDB274B9D4B37", undefined, var_7, 180, 256, 64, 0, undefined, undefined, undefined, "_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");
  var_6 endon("_encstr_AC8F0AC94174F85AFA901D30");
  var_6 endon("_encstr_AD75063D571AE108");
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"_encstr_B6DC1AD014F51449A9D4442A50981592E5448A19AA6AA2BE48D35384", "_encstr_9A8507BA4040188D08", 5);
  var_6.outlineid = scripts\cp\cp_outline_utility::outlineenableforall(var_6, "_encstr_9B0F12DE5DE8B15AB9B2F53295834734F54E59C8", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");

  for(;;) {
    var_6 waittill("_encstr_8F5C086405E70FBA4B4A", var_8);

    if(isDefined(var_8) && isPlayer(var_8)) {
      break;
    }
  }

  var_6 notify("_encstr_9A7B088CCA335D37CA91");

  if(isDefined(var_1.planted))
    var_1.planted = undefined;

  if(isDefined(var_6.outlineid))
    scripts\cp\cp_outline_utility::outlinedisable(var_6.outlineid, var_6);

  footprint_mask_clipheight(var_5, var_4);
  var_6 delete();
}

follow_players_when_close(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  scripts\cp\cp_objectives::objective_set_play_intro(var_0, 1);
  objective_setlabel(var_0, "_encstr_B6DC1AD014F51449A9D4442A50981592E5448A19AA6AA2BE48D35384");
  objective_setshowprogress(var_0, 1);
  objective_icon(var_0, "_encstr_AD361D5AA1786B0160239180274895CB8859D372C94EF706C813828BC3881F");
  objective_position(var_0, self.origin + (0, 0, 15));
  objective_setprogress(var_0, 1);
  objective_state(var_0, "_encstr_AF5A081BBAC993AC73A3");
  objective_setownerteam(var_0, "_encstr_8E8405EA382B2A");
}

footprint_mask_clipheight(var_0, var_1) {
  if(isDefined(var_0)) {
    objective_delete(var_0);
    scripts\cp\cp_objectives::freeworldid(var_1);
  }
}

camera_loadout_showcase_preview_sticker_alt1(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9A7B088CCA335D37CA91");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_4 = self.leave_pool_behind_after_deactivation;
  var_5 = var_4;
  var_6 = var_4;

  while(var_6 > 0) {
    var_6--;
    objective_setprogress(var_3, var_6 / var_5);

    if(soundexists("_encstr_8203175B3318A3F7E0E1A44753E58B5D7F8F63BDBB5B07925E")) {
      foreach(var_8 in level.players)
      var_8 playSound("_encstr_8203175B3318A3F7E0E1A44753E58B5D7F8F63BDBB5B07925E");
    }

    wait 1;
  }

  var_10 = "_encstr_8A78055C8D488C";
  var_11 = 0.1;
  var_12 = magicgrenademanual(var_10, self.origin + (0, 0, 6), (0, 0, 0), var_11);
  var_12.angles = self.angles;
  self notify("_encstr_AC8F0AC94174F85AFA901D30");

  if(isDefined(var_1.planted))
    var_1.planted = undefined;

  if(isDefined(self.outlineid))
    scripts\cp\cp_outline_utility::outlinedisable(self.outlineid, self);

  playFX(level._effect["_encstr_8BB9147853B02E21AAE89910C6D2373370FFA9439754"], self.origin);
  self playSound("_encstr_9A6C0FE238E127DF698122EBE08195D399");
  footprint_mask_clipheight(var_3);
  wait 1;

  if(isDefined(var_0) && scripts\cp\cp_objectives::is_objective_active(var_0)) {
    level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);
    var_13 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_8D390C38162A378BE19F1010E73C");
    var_13.pathdist = 1;
  }

  self delete();
}

debugarmsraceobjectivestart(var_0) {
  scripts\engine\utility::flag_set("_encstr_B28C0FB183EB85C9B6E64EC26C95AF6C37");
  scripts\engine\utility::flag_wait("_encstr_960E19A6B84EA03D4768D36F0247803180B9C79F1080B9D2433711");
  scripts\engine\utility::flag_wait("_encstr_839E168FF51A7A4B80308B576B0182B2641B777B53BE2204");
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_8E5719406B15B71BDF03D5C01C17C1737F415870F26AE1F68327EE");
}

waitforoneplayernearpoint(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_2 = 0;

    foreach(var_4 in level.players) {
      if(distance(var_4.origin, var_0) <= var_1)
        var_2 = 1;
    }

    if(var_2) {
      return;
    }
    waitframe();
  }
}

setnewarmsracecacheloc(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(var_0 > 4 || var_0 < 1)
    var_0 = 1;

  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("_encstr_967A0DBD269ABE2C275BDC4E16D859");
  var_1.curcache = var_0;
  var_1.curcachelocation = scripts\engine\utility::getStruct("_encstr_8F7110C2C9DA9BE42C8D957D8DC2C634ACD7" + var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;
  objective_state(var_1.cachewid, "_encstr_AF5A081BBAC993AC73A3");
  objective_setlocation(var_1.cachewid, 0, var_1.curcachelocation);
  objective_icon(var_1.cachewid, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setlabel(var_1.cachewid, &"_encstr_93C625CF412E8AE96F7E88724A47F0525401371B11A7C5A1F71F42BDAE85281BDD69BFD7E91C7D");
}

dropcarepackage() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\engine\utility::getStruct("_encstr_AB0B1458C95BCD4EB03695AFC6930BD159AF2327ED83", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = scripts\engine\utility::drop_to_ground(var_0.origin, 50, -200, (0, 0, 1));
  var_1 = var_1 + (0, 0, 1);
  var_2 = dropcratefrommanualheli(var_1);
  var_2 thread oncratedrop(var_1, var_0);
  return var_2;
}

dropcratefrommanualheli(var_0) {
  var_1 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "_encstr_AC20072B9FA9487832", scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "_encstr_B19A0BD803A4E10F42E50598BB", "_encstr_978D09FA80F57CF330A07E"));
  var_2 = scripts\cp_mp\killstreaks\airdrop::dropcratefrommanualheli(undefined, "_encstr_9A8507BA4040188D08", "_encstr_852812B11C7D5839AD6E932C8D2BBED893C2472B", var_0, (0, randomfloat(360), 0), 30000, 30000, var_0, scripts\cp\killstreaks\airdrop_cp::getcpcratedatabytype("_encstr_8B8E0B66CA6E640F9BB86D90AC"));

  if(!isDefined(var_2))
    return undefined;
  else if(!isDefined(var_2.crate))
    return undefined;

  return var_2.crate;
}

oncratedrop(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_2 setModel("_encstr_A5341932F00DA43F789DF7D721661FEAA3285A7A2BA7DA473072D5");
  var_2.angles = (0, 90, 90);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_3 setModel("_encstr_B231139B17092E334F8B5AE1B097FBE460BD371569");
  var_3 setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_AB0703DBB9", 0);
  var_2 thread watchforcratecapture(self);
  var_3 thread watchforcratecapture(self);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(600);

  if(isDefined(var_1.script_linkname) && isDefined(level.crates_active_at_location[var_1.script_linkname]))
    level.crates_active_at_location[var_1.script_linkname] thread scripts\cp_mp\killstreaks\airdrop::destroycrate();

  if(isDefined(var_3))
    var_3 delete();

  if(isDefined(var_2))
    var_2 delete();
}

watchforcratecapture(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AD75063D571AE108");
  self delete();
}

start_convoy(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_2))
    var_2 = "_encstr_82AA138270283F92FD1393AFF713EA3D18D97A0F28";

  level thread set_convoy_settings(var_0, var_2, var_3);
}

set_convoy_settings(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var_4 = level[[var_3]](var_0, var_1, var_2);
  var_4 thread _encstr_A9D12FB9364EA5E0E8DC971B075EAD1683E6976C0EFA07B0BC8DDE168CBC8D83F5B798A6DCF507B0CB1B7BB09117CE376C::select_bunker_server_one_spawners();
  level thread _encstr_A9D12FB9364EA5E0E8DC971B075EAD1683E6976C0EFA07B0BC8DDE168CBC8D83F5B798A6DCF507B0CB1B7BB09117CE376C::allow_driver_exit(var_4);
  var_4 scripts\cp\cp_convoy_manager::set_use_path_speeds_modifier(1);
  level waittill("_encstr_8E76095022AA99515FE620" + var_0);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_distance(5000);
  var_4 thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);
}

play_takephoto_anim() {
  var_0 = "_encstr_BA6811A240D9779BCE25797BB51633FC07684A";
  var_1 = self getcurrentweapon();
  var_2 = getcompleteweaponname(var_0);
  thread freeze_until_phototaken();
  scripts\cp\utility::_giveweapon(var_2);
  self switchtoweapon(var_2);
  self setclientomnvar("_encstr_9B9C0E4F4B38D3F19808276B86C82B6A", 7);
  var_3 = 3;
  wait(var_3);

  if(isPlayer(self)) {
    self takeweapon(var_2);
    self switchtoweapon(var_1);
    self setclientomnvar("_encstr_9B9C0E4F4B38D3F19808276B86C82B6A", 0);
    return 1;
  }

  return 0;
}

freeze_until_phototaken() {
  togglecellphoneallows(1);
  var_0 = 1.3;
  wait(var_0);
  togglecellphoneallows(0);
}

togglecellphoneallows(var_0) {
  scripts\cp\utility::_freezelookcontrols(var_0);
  scripts\common\utility::allow_movement(!var_0);
  scripts\common\utility::allow_jump(!var_0);
  scripts\common\utility::allow_usability(!var_0);
  scripts\common\utility::allow_melee(!var_0);
  scripts\common\utility::allow_offhand_weapons(!var_0);
  scripts\common\utility::allow_weapon_switch(!var_0);
}

dosmokecurtains(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B12D17B09BE5278B4FB365708B7791D94FD1A868623B9D2133");
  wait(var_1);
  var_2 = scripts\engine\utility::getStructArray(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_3 = 8;

  foreach(var_5 in var_2) {
    var_6 = randomfloat(2);
    thread _id_14403(var_5, var_6);
    waitframe();
  }
}

_id_14403(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_1);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  waitframe();
  playFXOnTag(level._effect["_encstr_851213F394D337D9DA78DFDBB6EF69E9F66B3A33B7"], var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2 playLoopSound("_encstr_8618179BB5B7ADB2BECE4ECA37C22395FA37B67BD659AFD80E");
  level waittill("_encstr_9A4714B863FDC9C6B74A89FE22DF09BBA9BBF0D00A97");
  var_3 = randomfloat(0.5);
  var_2 scripts\engine\utility::delaycall(var_3, ::playsound, "_encstr_8CF1199B2FF7F85B795F46C5F57291E11FFF4868AF953621A2C4B1");
  stopFXOnTag(level._effect["_encstr_851213F394D337D9DA78DFDBB6EF69E9F66B3A33B7"], var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  wait 0.25;
  var_2 stoploopsound();
  wait 4.25;
  var_2 delete();
}

spawn_atvs() {
  if(!isDefined(level.atvs))
    level.atvs = [];

  var_0 = scripts\engine\utility::getStructArray("_encstr_AACC13C2C9DA9B9C0BD8ACD72CD1B3FA6E0716DDB9", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level thread scripts\cp\vehicles\atv_cp::atv_cp_createfromstructs(var_0, 1);
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_8FC50EA92DA0121B67B1B219D9C5D3CA");
  var_2 = scripts\engine\utility::getStruct("_encstr_B1C4180B93DACD27B01B59EB3BAC86D28D362BD7DA0B4ED695C9", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B").origin;
  objective_setplayintro(var_1, 0);
  objective_setplayoutro(var_1, 0);
  objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
  objective_setlabel(var_1, &"_encstr_84A01CE999DF2FC267864DA177190D39B0BD89C809D93D97AB3F492484BA");
  objective_icon(var_1, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setbackground(var_1, 1);
  objective_setshowoncompass(var_1, 1);
  objective_position(var_1, var_2);
  level thread _id_144D8(var_1);
}

_id_144D8(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\cp\utility::array_merge(level.players, [level]);
  level scripts\engine\utility::waittill_any_ents_array(var_1, "_encstr_B6F4108D9DFB87CA4858AFBB0960603AA3CF", "_encstr_82A21DA8EA76C399F31FF5782CF723B39F6138B8A28F3910C75B8DF8063728");
  objective_delete(var_0);
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

heli_leaving_monitor(var_0) {
  var_0 useanimtree(#animtree);
  var_0.animname = "_encstr_B8BA05F06B9785";
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_0, "_encstr_A5360ABBEB4AAAA788E3BF45");
}

#using_animtree("_encstr_B40101");

_id_1212A(var_0) {
  if(!isDefined(var_0)) {
    scripts\cp\utility::debugprintline("_encstr_8C5711CDED081BC985A3560819AC664BDC5991");
    level notify("_encstr_AF451639AE45E713DF66450726774A99AB3757F8CBD8932D");
    return;
  }

  var_0 useanimtree(#animtree);
  var_0.animname = "_encstr_B8BA05F06B9785";
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "_encstr_A5360ABBEB4AAAA788E3BF45");
  wait(getanimlength(level.scr_anim["_encstr_B8BA05F06B9785"]["_encstr_A5360ABBEB4AAAA788E3BF45"]));
  level notify("_encstr_AF451639AE45E713DF66450726774A99AB3757F8CBD8932D");
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

teamhasfreshsquadleadercandidate() {
  level.scr_animtree["_encstr_B8BA05F06B9785"] = #animtree;
  level.scr_anim["_encstr_B8BA05F06B9785"]["_encstr_A5360ABBEB4AAAA788E3BF45"] = % _encstr_BECC1D9E7FF74B22B8D81FD3D811E4C2639669136F15827D016027CF0809AE;
  level.scr_animname["_encstr_B8BA05F06B9785"]["_encstr_A5360ABBEB4AAAA788E3BF45"] = "_encstr_BECC1D9E7FF74B22B8D81FD3D811E4C2639669136F15827D016027CF0809AE";
}

_id_11CE4(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B12D17B09BE5278B4FB365708B7791D94FD1A868623B9D2133");
  var_1 = scripts\engine\utility::getStructArray("_encstr_8D4A0FB5BD1BF647F6B3AFDE9C5AB32D37", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = 0;

  for(;;) {
    var_3 = randomint(var_1.size);
    var_4 = scripts\engine\utility::getStruct(var_1[var_3].target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(throw_molotov(var_1[var_3], var_4)) {
      var_2++;

      if(isDefined(var_0) && var_2 >= var_0) {
        break;
      }

      wait 3;
      continue;
    }

    wait 2;
  }
}

throw_molotov(var_0, var_1) {
  if(isDefined(getaiarray("_encstr_8E8405EA382B2A")[0]))
    var_2 = getaiarray("_encstr_8E8405EA382B2A")[0];
  else
    return 0;

  var_3 = var_0.angles;
  var_4 = anglesToForward(var_3) * 450;

  if(isDefined(var_1)) {
    var_5 = var_0.origin;
    var_6 = (var_1.origin[0], var_1.origin[1], var_1.origin[2]);
    var_7 = var_6 - var_5;
    var_7 = vectorNormalize(var_7);
    var_4 = var_7 * 600;
  }

  var_8 = var_2 launchgrenade("_encstr_BA730BF8AFF178988293F158B9", var_0.origin, var_4);
  var_8.owner = var_2;
  var_2 thread scripts\cp\powers\coop_molotov::molotov_used(var_8);
  return 1;
}

trial_time_remaining(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distance2d(var_3.origin, var_0) <= var_1)
      return 1;
  }

  return 0;
}