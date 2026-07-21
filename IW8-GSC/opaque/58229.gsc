/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58229.gsc
***********************************************/

bomber_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_83F40783ADF1D14AA3", 1);
  var_0.destroycallback = ::create_script_wait_for_flags;
  var_0._id_13E92 = "_encstr_84A00E50B085578F87182E98ED81081B";
  level.findclearflightyaw = getdvarint("_encstr_9BB0189B8DE4F54C3AF5B9D18527A37D5ACDF5A3432BFAC25A93", 0);
  level.farah_nobraids_body = getdvarint("_encstr_99CB16E6B14EAF318EEB46C9B71CFA89DBDAC4D7C2B6DADE", 4);
  level.failsecretstashquest = getdvarint("_encstr_BD3B1BD07AD2EF198B3FD759143F63273AE3B068F2A8B753A72EEB41FC", 0);
  level.failsmokinggunquest = getdvarint("_encstr_86FA22CD8D27D713D1FA0BD53ADBBE9356664BD8D87D19C97B38FA89F6DA13D78EB46B2B", 20);
  level.find_free_drop_location = getdvarint("_encstr_BA181D835F05019171D9D33BCF7009B0A85D5E3F02BFD2C5A0875370D7AD38", 6000);
  level.fast_revive_time = getdvarfloat("_encstr_A77D1DBB906D510BF3D8141AE85B37A6EF4832F1402BD41FC9B91D3F75808F", 0.85);
  level.farobjectiveiconid = getdvarfloat("_encstr_A76C249BD827AF313AF523C9F6077D89F6B589F5E896DA59BE89563A77CAACCDEB13B76B89CD", 0.8);
  level.farah_says_cut_wire_green = getdvarint("_encstr_9765200BBFE8A90BBD66D2BB4897C75EA83B925FD908EA9B66981B9356663B568883", 1);
  level.farah_says_cut_wire_red = getdvarint("_encstr_BD50207A164D59D23B415303A8D3B7D2DFB986F90D9B530CC3D85F1F116849CABFC2", 0);
  level._encstr_878B1A630148A292A0DB561D10A0CCCA3669BBDFA3866B6A08618F22 = getdvarint("_encstr_A206210EDB735605DB39F04812F24749AF4D1E9034F71B610242CB78090BD561FBED9E", 0);
  level.farah_nobraids_body_reset = getdvarint("_encstr_8EE124B9C64EEB4CD1EB32937B07D731EDAD4CF52395DC3A39EDF2B9BEC2B07DD1D59339953A", 1);
  level.farah_says_cut_wire_yellow = getdvarint("_encstr_92FC1F6B801AEE65E8BF799307EBE941B76B4A8F59489B7B1372EBDE81E18AD773", 0);
  level.farms2_gw_ambient_sound_load = getdvarint("_encstr_A20422F852FAD721A3274DBEFF5B4E75651AC811BA57C7BB830FCB36F70FB00B0CC22828", 1);
  level.ffsm_state = getdvarfloat("_encstr_860D2353095E17F6D0C7E7FD4DE8FF7B10434A3A51A0AB6FE88F1DF57539462F21B80233FB", 0.1);
  level.ffsm_isgulagrespawn = getdvarint("_encstr_922D143FBB4A29FE1B311178BA2BA1A0A903BF8D21B2", 1);
  level.findanyaliveplayer = getdvarint("_encstr_AD0D1877F31271B653891B8082DF76B9EA4BDBD5A7BEA00C1BC2", 35);
  level.findavailableteam = getdvarint("_encstr_86F618CD8D27D713D1FA9BBD3758E4FA37360BDCBEC958B93BB2", 15000);
  level.find_plunder = getdvarfloat("_encstr_B2102247B032C9A621F1439891F1B083D9BBED939831A92071152F39C0572951A20F6B16", 60);
  level.find_and_run_elevator_spawngroup = getdvarfloat("_encstr_B1F523D0C73AAE857BE117930322D9168277586817D221B1915380B01FCB0FBBC7F3205093", 45);
  level.failedmission = getdvarint("_encstr_A2DB1F6EC6C9AF89D1F55819322DD1D27BDCB036D7D8DBCDA39C5896B1EBB3333C", 1);
  level.finalthreeuav = getdvarint("_encstr_966A20B3069219D6AB8F17D3B362B03057DDDB2B2EE1F816316F23D55F0B6F58F5B7", 60);
  level.finalkillcamplaybackbegin = getdvarint("_encstr_93CF21FF7B8AE93EDBF191781A37E53166DF7D79F2361071FFE9A8C032C726833F2DE1", 90);
  level.finalsurvivorcount = getdvarint("_encstr_8E4320CD6CE4D7318EF5991637A3D7C67B9BE89C2C9636CDBEDAB4E6F5371CB2AC19", 80);
  level.find_ai_spawner = getdvarint("_encstr_86BD1C9BAA021FE97BEFB708AAAF3005AF238068721FE70317FB18F08437", 40);
  level.fake_digit_pool = getdvarint("_encstr_BA7F202891CB099D50393180A978C887AFDFC6BF7535DF383BC517DCCC74FB70BD27", 0);
  level.fiftypercent_music = getdvarint("_encstr_A2661238923A17E163E78B73B44F0E11A4CA6088", 0);
  level.failtimedrunquest = getdvarfloat("_encstr_87B81D63D662E9265B5FEDEF8F62E010066C29DBFCCC31E4A2BBFFFFF72B3B", 0.4);
  level.failx1finquest = getdvarint("_encstr_97DB1982EE85910AE389F33FE0D9FF7A7BFB017B45D1EA5368F897", 330);
  level.finale_setup = getdvarint("_encstr_92851CBBE1B6EF0E381FCADF63D0196F5338F1526B808B893043C9DF0148", 800);
  level.ffsm_onground_stateenter = getdvarint("_encstr_B6FD236ED8C9D7131DF5D9B0E6BE8C16DAB03B957D073616E5CA39B9FA85A54E83C62CE6B2", 3);
  level.farah_disable_ai_color_before_hallway_takedown = getdvarfloat("_encstr_B2D8297B77AD67B3898FB90569A15C88A0309820C4C04FB1A2580365FFCE6D65F320EF9709B1AFB1D33BD1", 0.0);
  level.fananim = getdvarfloat("_encstr_A101259B369CF54C3ABE32B78EAFD9B21B7B6CB4A3BCEBB3C9F6AEE619EB37EDD7190BD6C2CE95", 0.18);
  level.falling_xyratio = getdvarfloat("_encstr_93C9290FD88B97EA3978C73DD54763759050B7EFF842DFE24D088B75359FFA31FB3003470999598A431497", 0.85);
  level._encstr_A3C31B268E7D9676B9ED3959D8589B8C2D37ECD92B16C94658D6C23BAC = getdvarint("_encstr_B6321F1633C3B7F51DF08FF04D2DFE35F14B1E15D038D88082B2926D49F02A7F78", 0);
  level._encstr_A22C1BC4A3EB272B8CAB1BAC63B0378CD273CEB35658E4912CDA2C7659 = getdvarint("_encstr_87C61F070FFE31A2185E32FF1138EB2A49A3EBD3E3287ABFC8E12A8FA96B3142A5", 1);
  level._encstr_814320228B3F3828C3EBE3D34DC9609B4B7FB650A73294BB3388742B3A878CF371FD = getdvarfloat("_encstr_BD4728B9364E7D4CE8F5C87BD1D7D9B2C6DBB12DD1BC7D9DC9BDBAB932D7C60BB932B437ECEBD956859C", 0.25);
  level._encstr_BDF0215AF3D037DCF877E8C56390274F666B02233A1487D240A7E4DE0BB82D9F9BC3FB = getdvarfloat("_encstr_95A929DCD8C9BE4CA3F5DAA5CDFA6E382B2B91AF991636A3BDC97D33B7937D8CBD8ED7EC2B36BD1B2D1D97", 0.2);
  level.findquestplacement = getdvarint("_encstr_9A88259B38B0A98A30175B4A30ADDE01433FBF77FB505B329259E053714342C7274B798943E227", 2);
  level.find_supply_station = getdvarint("_encstr_A62718B9B1E4BE13D1EBB90DDEBBBE27BADCBB0BE5F596D8F6E6", 0);
  level.ffsm_skydive_stateenter = getdvarfloat("_encstr_8178226348B599C3CB905F4510D0879A4748CAEB80638BFF23E5265ABD9B7B6949C8B212", 0.1);
  level.ffsm_parachuteopen_stateenter = getdvarfloat("_encstr_8D911BB9364E7D988ED776EADC7395C9FA475827D956A37D93C23776B2", 15000);
  level.fake_hit_target_monitor = getdvarfloat("_encstr_A9A61BB673DBFEDD03D108584A919D71E70C30AEF7236307AFCA283B02", 0.5);
  level.fake_magic_grenade_watch = getdvarfloat("_encstr_B21820E6C69CEB311DF5465B3BD7D6D51B3A961CD8D2CAC9F5839CDB83AC8D1B56E4", 1.0);
  level.fake_exploder = getdvarfloat("_encstr_92062163BE43779EE901B23AD8679517389DF1F84148C7A29730DB72787B0ACBF18653", 10.0);
  level.fake_model = getdvarfloat("_encstr_939A22C23F6B9F2DFB06E07B68EF453A5F3AF743F1E248AD4A7B875B284B3543FBA81C07", 40.0);
  level.fakeprops = getdvarfloat("_encstr_A3B52102B14887F2F577530F7F08DAF1E859BF0FAEA04FCAC15F1B137DCD53205080F7", 45.0);
  level.fake_magic_grenade_watch_individual = getdvarfloat("_encstr_86B81FAB1EBA31FE93A729336F0935184D76D1E18970C8AD9A63673D8F1205200A", 2.0);
  level.fake_trigger_think = getdvarfloat("_encstr_99E61E0E896AD972B41F2559AF19EA8AC2FB51CDE91BE2601131863930D36FB2", 2.0);
  level.fallback_index = getdvarfloat("_encstr_86C425A65EE829066BE949F8D78003C9983877AD3F65E147583C4521DDF880BDA7F820F31330CB", 20.0);
  level.findgunsmithattachments = getdvarfloat("_encstr_8AF4159B6C4EBE893AEB326B767DAD7B23D7B337D76632", 5);
  level.findfirstaliveplayer = getdvarfloat("_encstr_81F415AF6FAAD7231B191DD5D73732B5A45123E039026B", 5);
  level.findnewplunderextractsite = getdvarfloat("_encstr_81EA1BCD36C9FA891DD791D676D7ADDE8CEBECE67D3BB2A14B36B156E6", 5);
  level.findeventforchosenweight = getdvarfloat("_encstr_B1F415D0C73AAE857BE11D91C7E1D310949F6058CFE1A5", 10);
  level.findminmaxangleovertime = getdvarfloat("_encstr_9A9E195B89AA879D6528DA4DE7D9CA502DE19BB70FABBD1FB30F60", 1);
  level.failx1stashquest = getdvarfloat("_encstr_B67C1ADC6C277D261DAF196B3BAFC4EA4ECDBE8CB7BB9BF58E96D6AC", 4);
  level.fast_rope_over_black = getdvarint("_encstr_837A199327703163D51EAAE221269377C1AF3D1A95A002CFF373B2", 0);
  level.ffsm_landed_stateenter = getdvarint("_encstr_91A81F2646BB27D9E4F7B07BBB0BF1EFA26F1D245CA23941E703C048FB1FA8D7AA", 1);
  level.failsafe_door_breach_frozen = getdvarint("_encstr_8F062750FA526F990BBFD658958BA1FDF15248C823A14F700BBCE647799B2BDF250AC821EA858FE81F", 55);
  level.ffsm_introsetup = getdvarint("_encstr_95751FFBA25B20989BDFBDAF05C6787E477AD021DA5B653972F55FBF35E1A8CC03", 0);
  level.failstringsetup = getdvarint("_encstr_A75120C376C24986FBBF0D0F6FC25D6857CA2B991F3C914D02330D67631A91480727", 1);
  level.finale_main = getdvarint("_encstr_BA0C271B6FDEDF3A81A9A02795C08FD0F96155CD17CF7A080B3F983C262507E70222E2B08F902CAF0D", 0);
  level.fight_on_jammer_2_bridge = getdvarint("_encstr_8536240F67CB40E08C2949E04D422B0EB1F7AFAD3FB31541A3BF70D9F92B18495A1F3F2BA7DA", 1);
  level.fake_agent_model_setup = getdvarint("_encstr_91E41CB96CE47D268EEB1B58DAAC3958BE66B7631BEDEEF52B9BC2138DAC", 0);
  level.findteamwithnoplayers = getdvarfloat("_encstr_91791F9BB1E4AF13E87DEE585A477DB158B62BE4B0EB99DB368DEDBBF589DEB5C4", 0.5);
  level.findvalidspectateprop = getdvarfloat("_encstr_8B502037C627F5C43AF577C2B48EEBDCE82C393A7DD8585BAC93587D33B78D36DB77", 0.0);
  level.finale = getdvarint("_encstr_A6D51F9BB19C7D4CA37D8D0BB91996E6EC7DB32B2CE4F5DC1DC2CBF5E61DA51BB1", 1);
  level.failsafe_door_breach_frozen_player = getdvarint("_encstr_B447236FE67397150B275BB1B719E7708C77946FD2A7694D05FA07EC5AAEE04001A3B1C870", 1);
  level.failhistoryquest = getdvarfloat("_encstr_86421CCD8D9CBE133AFAB023B9AF995846B2AF46AC36C2E5F5E896AD95C9", 0.6);
  level.failedtext = getdvarint("_encstr_B29117FBC8D3679A1310E731D7697A7F1EB7589BA3B347E7AB", 850);
  level.ffsm_nextstreamhinttime = getdvarint("_encstr_BED71E7E1EE37FF1CCCF98300FF56EA19A85FA9077FAC11E845FD0906737E0D7", 400);
  level._encstr_87A8186AE1F11797A131527AB98DC38DC8ADE3F549F89D4F596B = getdvarint("_encstr_8CB01FE603AB8EAD738158885ACE6F01C7AC65D697DFD0F71FA9D0C072E76758DF", 500);
  level._encstr_B8241E82A31F871F383FEFE545C1EB8DA3481A4AA8297A47D393FF146D4BA713 = getdvarfloat("_encstr_8813255F88DBC7BA4908B7EE090BA28506D89F9350933E52B320BBA4EE3B3B40A86313DF40897C", 0.3);
  level.final_wave = getdvarfloat("_encstr_917122FB4F18591BAD76327ABB057B0AC84F647DEFC95BFB5629AB3220D193C9788B1FF0", 4.5);
  level.final_switch_think = getdvarfloat("_encstr_81B2210BC6CBF9F63CF9F01DA027582FC3AE396D97E149113D0D5688A0E143E9D8989B", 0.9);
  level.final_radius_think = getdvarfloat("_encstr_AFB221371B4EEBC4E8BE4BB683D5B1E6B2F58C5BB3D73AA1E4953734ED63327DC6DB77", 0.3);
  level.fillmaxarmorplate = getdvarfloat("_encstr_B47D1E3A766D59BB1387108873E528EF0551A9D1E4B894B1774D8DEA9F19D8F4", 0.05);
  level.filtervehiclespawnstructsfunc = getdvarfloat("_encstr_BDF5224B1146FF1E282FF1CD4918A507650EB2D2F988A3167891FFDA7FB0AC8380C09AFB", 0.2);
  level.filtervehiclespawnstructs = getdvarfloat("_encstr_91D52360A7C259FB1CCF4BF5FBD3C93F258867E8A44957C6B6517870C10D9067D0308B7FE3", 0.75);
  create_trial_weapon_spawn();
  create_thrust_fire();
  create_trophy_station();
  create_struct_at();
  create_struct();
  create_temp_infil_structs();
  create_solution_digit_mark();
  create_usb_anim_rig();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_83F40783ADF1D14AA3", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_83F40783ADF1D14AA3", "_encstr_88C5055208731B")]]();

  create_tut_loot_struct();
  create_traversal_node_and_link();
}

create_traversal_node_and_link() {
  thread _id_1327D();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_83F40783ADF1D14AA3", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_83F40783ADF1D14AA3", "_encstr_BAF609D2739647C4853A2B")]]();

  if(istrue(level.failsecretstashquest))
    createspawncamera();
}

create_trial_weapon_spawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_83F40783ADF1D14AA3", 1);
  var_0.enterstartcallback = ::create_rocket_death_fx;
  var_0.enterendcallback = ::create_race;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::create_saw_interaction;
  var_0.reentercallback = ::createflagstart;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 50;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 355;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 255;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 255;
  var_0.exitextents["_encstr_AC190479FF92"] = 10;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 50;
  var_0.allowairexit = 1;
  var_1 = "_encstr_8253060E2B5FE330";
  var_0.exitoffsets[var_1] = (150, -35, -45);
  var_0.exitdirections[var_1] = "_encstr_8253060E2B5FE330";
  var_1 = "_encstr_A5AD056A019C63";
  var_0.exitoffsets[var_1] = (150, 35, -45);
  var_0.exitdirections[var_1] = "_encstr_A5AD056A019C63";
  var_1 = "_encstr_87D409A3DE07F5C659998E";
  var_0.exitoffsets[var_1] = (69, -40, -45);
  var_0.exitdirections[var_1] = "_encstr_A5AD056A019C63";
  var_1 = "_encstr_B69B0589C236B6";
  var_0.exitoffsets[var_1] = (-355, 0, -45);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_1 = "_encstr_974E0A4CB0D85BAFD895998E";
  var_0.exitoffsets[var_1] = (-255, 255, -45);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_1 = "_encstr_BE360B4C0B36B5FA4E5AB386A3";
  var_0.exitoffsets[var_1] = (-200, -180, -45);
  var_0.exitdirections[var_1] = "_encstr_8253060E2B5FE330";
  var_2 = ["_encstr_A266062032BD7723", "_encstr_876809B995B01DAFA3DD7B", "_encstr_A7BF0B839873B3D72BABEAF535", "_encstr_B15A0AD36BA8BBD79C58EBE3"];
  var_3 = "_encstr_A266062032BD7723";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_83F40783ADF1D14AA3", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_8253060E2B5FE330", "_encstr_A5AD056A019C63", "_encstr_87D409A3DE07F5C659998E", "_encstr_B69B0589C236B6", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_BE360B4C0B36B5FA4E5AB386A3"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141D8();
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4._id_12023 = "_encstr_A930138F411DE927482F9958FB8D52C7D8D0A078CB";
  var_3 = "_encstr_876809B995B01DAFA3DD7B";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_83F40783ADF1D14AA3", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_8253060E2B5FE330", "_encstr_A5AD056A019C63", "_encstr_87D409A3DE07F5C659998E", "_encstr_B69B0589C236B6", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_BE360B4C0B36B5FA4E5AB386A3"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var_4._id_13E8A = getcompleteweaponname("_encstr_84A00E50B085578F87182E98ED81081B");
  var_4._id_13E92 = "_encstr_84A00E50B085578F87182E98ED81081B";
  var_4.animtag = "_encstr_A30D0B30D3708180E951D37165";
  var_4._id_12023 = "_encstr_A9891440525D07260BBDEB53934BA9AFC77B48380AF2";
  var_3 = "_encstr_A7BF0B839873B3D72BABEAF535";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_83F40783ADF1D14AA3", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_8253060E2B5FE330", "_encstr_A5AD056A019C63", "_encstr_87D409A3DE07F5C659998E", "_encstr_B69B0589C236B6", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_BE360B4C0B36B5FA4E5AB386A3"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var_4._id_13E8A = getcompleteweaponname("_encstr_84A00E50B085578F87182E98ED81081B");
  var_4._id_13E92 = "_encstr_84A00E50B085578F87182E98ED81081B";
  var_4.animtag = "_encstr_930D0BB31F7F41CB11C81BAF42";
  var_4._id_12023 = "_encstr_A9891440525D07260BBDEB53934BA9AFC77B48380AF2";
  var_3 = "_encstr_B15A0AD36BA8BBD79C58EBE3";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_83F40783ADF1D14AA3", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_8253060E2B5FE330", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_87D409A3DE07F5C659998E", "_encstr_8253060E2B5FE330", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_968A0AD1EDC1D7E42DD9341D"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var_4._id_13E8A = getcompleteweaponname("_encstr_84A00E50B085578F87182E98ED81081B");
  var_4._id_13E92 = "_encstr_84A00E50B085578F87182E98ED81081B";
  var_4.animtag = "_encstr_910D0BD951F7D19EB70A9BE647";
  var_4._id_12023 = "_encstr_A9891440525D07260BBDEB53934BA9AFC77B48380AF2";
}

create_thrust_fire() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_83F40783ADF1D14AA3", 1);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_83F40783ADF1D14AA3", "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_A266062032BD7723", "_encstr_876809B995B01DAFA3DD7B", "_encstr_A7BF0B839873B3D72BABEAF535", "_encstr_B15A0AD36BA8BBD79C58EBE3"]);
}

create_trophy_station() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_83F40783ADF1D14AA3", 1);
  var_0.id = 20;
  var_0.seatids["_encstr_A266062032BD7723"] = 0;
  var_0.seatids["_encstr_876809B995B01DAFA3DD7B"] = 1;
  var_0.seatids["_encstr_A7BF0B839873B3D72BABEAF535"] = 2;
  var_0.seatids["_encstr_B15A0AD36BA8BBD79C58EBE3"] = 3;
  var_0._id_12DA2[0] = 0;
  var_0._id_12DA2[1] = 1;
  var_0._id_12DA3["_encstr_A266062032BD7723"]["_encstr_84A00E50B085578F87182E98ED81081B"] = 0;
  var_0._id_12DA3["_encstr_A266062032BD7723"]["_encstr_84A00E50B085578F87182E98ED81081B"] = 0;
  var_0._id_12DA3["_encstr_A266062032BD7723"]["_encstr_84A00E50B085578F87182E98ED81081B"] = 0;
  var_0._id_12DA3["_encstr_A266062032BD7723"]["_encstr_84A00E50B085578F87182E98ED81081B"] = 1;
  var_0._id_12DA3["_encstr_876809B995B01DAFA3DD7B"]["_encstr_84A00E50B085578F87182E98ED81081B"] = 0;
  var_0._id_12DA3["_encstr_876809B995B01DAFA3DD7B"]["_encstr_84A00E50B085578F87182E98ED81081B"] = 0;
  var_0._id_12DA3["_encstr_876809B995B01DAFA3DD7B"]["_encstr_84A00E50B085578F87182E98ED81081B"] = 0;
  var_0._id_12DA3["_encstr_876809B995B01DAFA3DD7B"]["_encstr_84A00E50B085578F87182E98ED81081B"] = 1;
  var_0._id_12DA3["_encstr_A7BF0B839873B3D72BABEAF535"]["_encstr_84A00E50B085578F87182E98ED81081B"] = 0;
  var_0._id_12DA3["_encstr_A7BF0B839873B3D72BABEAF535"]["_encstr_84A00E50B085578F87182E98ED81081B"] = 0;
  var_0._id_12DA3["_encstr_A7BF0B839873B3D72BABEAF535"]["_encstr_84A00E50B085578F87182E98ED81081B"] = 0;
  var_0._id_12DA3["_encstr_A7BF0B839873B3D72BABEAF535"]["_encstr_84A00E50B085578F87182E98ED81081B"] = 1;
  var_0._id_12DA3["_encstr_B15A0AD36BA8BBD79C58EBE3"]["_encstr_84A00E50B085578F87182E98ED81081B"] = 0;
  var_0._id_12DA3["_encstr_B15A0AD36BA8BBD79C58EBE3"]["_encstr_84A00E50B085578F87182E98ED81081B"] = 0;
  var_0._id_12DA3["_encstr_B15A0AD36BA8BBD79C58EBE3"]["_encstr_84A00E50B085578F87182E98ED81081B"] = 0;
  var_0._id_12DA3["_encstr_B15A0AD36BA8BBD79C58EBE3"]["_encstr_84A00E50B085578F87182E98ED81081B"] = 1;
}

create_struct_at() {
  level.cruisepredator_watchownerdisownaction = getdvarfloat("_encstr_87F61EDCC639EBC4937D13B76B892B27F58656C2363A34FABDD9CA399C5AC82B", 2250);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_83F40783ADF1D14AA3", level.cruisepredator_watchownerdisownaction, undefined, undefined, undefined, level.failx1stashquest);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_83F40783ADF1D14AA3");
  var_0.class = "_encstr_B846067B175AA56A";
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::_id_1414D("_encstr_83F40783ADF1D14AA3", "_encstr_8FA906CC80677438");
  var_1._id_12024 = ::createalldestinationvfx;
  var_1._id_1202D = ::createapcturret;
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::_id_1414D("_encstr_83F40783ADF1D14AA3", "_encstr_AB5E07609A5B7368E5");
  var_1._id_12024 = ::createallhistorydestinations;
  var_1._id_1202D = ::createattractionicontrigger;
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::_id_1414D("_encstr_83F40783ADF1D14AA3", "_encstr_B846067B175AA56A");
  var_1._id_12024 = ::createagenttargetloadout;
  var_1._id_1202D = ::createandstartlights;
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_83F40783ADF1D14AA3");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_83F40783ADF1D14AA3", 13);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14175("_encstr_83F40783ADF1D14AA3", ::createdefaultrectangularzone);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_83F40783ADF1D14AA3", ::create_oscilloscope);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_84A00E50B085578F87182E98ED81081B", 5);
}

create_struct() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_83F40783ADF1D14AA3", 1);
  var_0.challengeevaluator = 2;
  var_0.keycardlocs_chosen = 0.75;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 5;
  var_0.isallowedweapon = 20;
  var_0.isakimbo = 40;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

create_temp_infil_structs() {
  level._effect["_encstr_A9190F05AFE5A8057B590992933BC8503F"] = loadfx("_encstr_8322331305FB36A9BBB2793ED3EAE14B59A3EBD36F245A909A032F806E782207B83D670F5DC5736F2849E68B60B97D6B87CDBBABF1");
  level._effect["_encstr_A1391393FA6F6AC39391F9FB70F5280B0957C92EDD"] = loadfx("_encstr_81A13A452EFB480B5377A0C636A01BC89932ABF0A086A2D8768CD10B6998AEA667F0C7F0CDBFE3BFC1671179AB7F8D50CB11D2AB9FE3A8E8500E67CA");
  level._effect["_encstr_918F1B89DBDA31B29C7D13DEB613AF5687C1D8ED2395FACE9CF6EAB991"] = loadfx("_encstr_88E12D9D3492862F58683060C260D377B039F81CE0948363D25B4EB06112DD4209082FD2A81933099DE02FCA2C6F78");
  level._effect["_encstr_A5AF18CEB838321A7EFFB38FF32EE16D38E3C5153180C792DBBD"] = loadfx("_encstr_88E12D9D3492862F58683060C260D377B039F81CE0948363D25B4EB06112DD4209082FD2A81933099DE02FCA2C6F78");
  level._effect["_encstr_BEFC150DA79DD00D7341E1484A1B28C0340E99FF4687C8"] = loadfx("_encstr_95AA349D99E15E2DBB83BE894E792DB9630BB932CB76166B95C1B10BBC79D9CCE1EB98E4FA3885932CD886BAE8B2D7BB2D370ED70698");
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
#using_animtree("_encstr_B40101");

create_solution_digit_mark() {
  level.scr_anim["_encstr_B4920771CA8F0618B2"]["_encstr_A517086A8F6B5A9F6B48"] = % _encstr_ACCA16E6464EFAD6387D9D561AEBC4A3AF3783D2DCD75DC1;
  level.scr_anim["_encstr_B4920771CA8F0618B2"]["_encstr_B8120A535FC8923E79782FC5"] = % _encstr_8D4218AFD8F3697A4141700B40EFE693C133832A784FBFB5EC9B;
}

create_usb_anim_rig() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_918B15891DBE36B758917BEA3AFA325637D1E4EDCB9523"] = "_encstr_96E21CC9F28231BA2B8B7968636A4ABFBB6DEEBBA237E8495F898437672B";
}

create_silencer_pick_ups() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_83F40783ADF1D14AA3");
  return var_0._id_13E92;
}

create_mp_version_of_vehicle(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_0.modelname = "_encstr_871219BCED2B66779B69C8E072690BF82BAFCEB84DBBE9BDB9F348";
  var_0.targetname = "_encstr_83F40783ADF1D14AA3";

  if(!isDefined(var_0.vehicletype))
    var_0.vehicletype = "_encstr_8CEE061DAC01B8F7";

  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  var_3 = create_silencer_pick_ups();
  var_4 = create_name_fx(var_2, var_3, "_encstr_96C725DBD33B07F77BA9FD2A15D1DE2AED19D2E00D72037B578985D2ABB5D40E68226259B89F3A", "_encstr_AB661755361AD78915E320608B67A3CB339A45DD9A315570FC", (0, 0, 0));
  scripts\cp_mp\vehicles\vehicle::_id_14207(var_2, var_4, getcompleteweaponname(var_3), undefined, "_encstr_876809B995B01DAFA3DD7B");
  var_4 settoparc(28);
  var_4 setbottomarc(37);
  var_4 setrightarc(96);
  var_4 setleftarc(96);
  var_4 = create_name_fx(var_2, var_3, "_encstr_99952534578AB76B348798A05387E1139371A6302D429B7377C3507003D51BC71B66ABC909CB6D", "_encstr_83A017E3F39CD94F88D08D574B0184B3EE2D2F7BFD28530FE8", (0, 0, 0));
  scripts\cp_mp\vehicles\vehicle::_id_14207(var_2, var_4, getcompleteweaponname(var_3), undefined, "_encstr_A7BF0B839873B3D72BABEAF535");
  var_4 settoparc(28);
  var_4 setbottomarc(37);
  var_4 setrightarc(92);
  var_4 setleftarc(92);
  var_4 = create_name_fx(var_2, var_3, "_encstr_82C426930AFBF8C843179BEB5CF110BBCB01A938123B2D18A114A3D56AA7406823DAE0C0BB775C10", "_encstr_8A7417D5B69A57099563A0E00BE7234BB31AC55D9AB1D5F07C", (0, 0, 0));
  scripts\cp_mp\vehicles\vehicle::_id_14207(var_2, var_4, getcompleteweaponname(var_3), undefined, "_encstr_B15A0AD36BA8BBD79C58EBE3");
  var_4 settoparc(0);
  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_83F40783ADF1D14AA3", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_84A00E50B085578F87182E98ED81081B");
  var_2._id_13E92 = var_3;
  var_2.dropbombs = [];

  for(var_5 = 0; var_5 < level.farah_nobraids_body; var_5++)
    var_2.dropbombs[var_2.dropbombs.size] = 0;

  var_2.shouldmodeplayfinalmoments = 0;
  var_2._id_120B4 = level.find_ai_spawner;
  var_2 thread cruisepredator_detachplayerfromintro();
  var_2 thread cruisepredator_watchintropoddisown();
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_83F40783ADF1D14AA3", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_83F40783ADF1D14AA3", "_encstr_8AEA073693CA16D12B")]](var_2);

  var_2 thread helis_assault3_hangar_check_size();
  var_2 thread current_ally_volume();

  if(level.ffsm_landed_stateenter)
    var_2 unmarkkeyframedmover(1);

  return var_2;
}

helis_assault3_hangar_check_size() {
  var_0 = self;
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 vehphys_enablecollisioncallback(1);

  if(getdvarint("_encstr_8E5D15B9C64EFA8993FA13E8D74B9B3BD2E6D85A131BCA", 0)) {
    return;
  }
  wait 5;
  var_1 = [];
  var_2 = [];

  for(;;) {
    var_0 waittill("_encstr_93510A16C71B20636A2AB8B8", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(isDefined(var_10) && isDefined(var_10.helperdronetype) && var_10.helperdronetype == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC") {
      continue;
    }
    if(istrue(level.fake_digit_pool) && !istrue(var_0.shouldmodeplayfinalmoments)) {
      continue;
    }
    if(isDefined(var_10.model)) {
      if(var_10 unset_bullet_shields()) {
        if(isDefined(var_10.owner) && isDefined(var_0.owner) && var_10.owner == var_0.owner) {
          continue;
        }
        var_10 createteamdefenderflagbase();

        if(isDefined(var_0))
          var_0 createquestobjicon(9000, var_10, var_7);

        continue;
      }

      if(istrue(var_0.shouldmodeplayfinalmoments) && (var_10 unresolvedcollisiontolerancesqr() || var_10 _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function())) {
        if(isDefined(var_10.owner) && isDefined(var_0.owner) && var_10.owner.team != var_0.owner.team) {
          var_12 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);

          foreach(var_14 in var_12)
          var_14 dodamage(20, var_0.origin, var_10.owner, var_14, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_84A00E50B085578F87182E98ED81081B");

          var_16 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_10);

          foreach(var_14 in var_16)
          var_14 dodamage(20, var_0.origin, var_0.owner, var_14, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_84A00E50B085578F87182E98ED81081B");
        }

        var_0 scripts\cp_mp\vehicles\vehicle_damage::_id_14143(1);
        var_0 dodamage(9000, var_7, undefined, undefined, "_encstr_8D4E0A501FCB898912CB3FA3");
        var_0 scripts\cp_mp\vehicles\vehicle_damage::_id_14143(0);
        var_10 scripts\cp_mp\vehicles\vehicle_damage::_id_14143(1);
        var_10 dodamage(9000, var_7, undefined, undefined, "_encstr_8D4E0A501FCB898912CB3FA3");
        var_10 scripts\cp_mp\vehicles\vehicle_damage::_id_14143(0);
        continue;
      }
    }

    var_19 = 1.0;
    var_20 = 0;
    var_21 = 0;

    switch (var_11) {
      case 0:
        var_19 = level.fake_hit_target_monitor;
        break;
      case 1:
        var_19 = level.fake_magic_grenade_watch;
        var_20 = 1;
        break;
      case 2:
        var_21 = 1;
        break;
      default:
        break;
    }

    if(var_20)
      var_22 = var_19;
    else
      var_22 = var_9 * var_19;

    if(istrue(level.failstringsetup)) {
      var_23 = length(var_0 vehicle_getvelocity() - var_0.current_automated_respawn_timer_value);
      var_22 = var_22 * (var_23 / 17.6);
    }

    if(abs(angleclamp180(var_0.angles[0]) > level.fake_model))
      var_22 = var_22 * level.fake_magic_grenade_watch_individual;

    if(abs(var_0.angles[2]) > level.fakeprops)
      var_22 = var_22 * level.fake_trigger_think;

    if(var_0.angles[2] > 90 || var_0.angles[2] < -90)
      var_22 = var_22 * level.fallback_index;

    var_24 = 0;

    if(var_22 > level.final_wave)
      var_24 = var_0.maxhealth;
    else if(var_22 > level.final_switch_think) {
      var_25 = level.final_wave - level.final_switch_think;
      var_26 = (var_22 - level.final_switch_think) / var_25;
      var_27 = var_0.maxhealth * level.filtervehiclespawnstructsfunc;
      var_28 = var_0.maxhealth * level.filtervehiclespawnstructs;
      var_24 = scripts\engine\math::lerp(var_27, var_28, var_26);
    } else if(var_22 > level.final_radius_think)
      var_24 = var_0.maxhealth * level.fillmaxarmorplate;

    var_29 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(var_0);

    if(!isDefined(var_29))
      var_24 = var_24 * level.fake_exploder;

    var_30 = -1;

    if(var_11 != 1) {
      var_30 = abs(vectordot(var_8, vectorNormalize(var_0.current_automated_respawn_timer_value)));
      var_31 = 1;

      if(var_21 && var_9 < level._encstr_BDF0215AF3D037DCF877E8C56390274F666B02233A1487D240A7E4DE0BB82D9F9BC3FB)
        var_31 = 0;

      if(var_31) {
        if(var_30 > level.falling_xyratio)
          var_24 = var_24 + (var_0.maxhealth * 0.25 + randomintrange(50, 100));
        else if(var_30 > level.fananim)
          var_24 = var_24 * level.findquestplacement;
        else if(level.farah_disable_ai_color_before_hallway_takedown > 0.0 && var_30 <= level.fananim)
          var_24 = var_24 * level.farah_disable_ai_color_before_hallway_takedown;
      }
    } else
      var_24 = var_24 + 550;

    if(isDefined(var_1[var_11]) && var_1[var_11] > gettime()) {
      if(var_24 < var_2[var_11])
        continue;
    }

    if(var_21 && var_24 > 0) {
      if(level._encstr_A3C31B268E7D9676B9ED3959D8589B8C2D37ECD92B16C94658D6C23BAC) {
        continue;
      }
      if(level._encstr_A22C1BC4A3EB272B8CAB1BAC63B0378CD273CEB35658E4912CDA2C7659 && var_30 <= level._encstr_814320228B3F3828C3EBE3D34DC9609B4B7FB650A73294BB3388742B3A878CF371FD)
        continue;
    }

    if(var_24 > 0) {
      var_0 createquestobjicon(var_24, var_10, var_7);
      var_1[var_11] = gettime() + level._encstr_87A8186AE1F11797A131527AB98DC38DC8ADE3F549F89D4F596B;
      var_2[var_11] = min(var_24 * level._encstr_B8241E82A31F871F383FEFE545C1EB8DA3481A4AA8297A47D393FF146D4BA713, var_0.maxhealth);
    }
  }
}

current_ally_volume() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.current_automated_respawn_timer_value = 0;

  for(;;) {
    waittillframeend;
    var_0.current_automated_respawn_timer_value = var_0 vehicle_getvelocity();
    waitframe();
  }
}

createquestobjicon(var_0, var_1, var_2) {
  var_3 = self;

  if(var_0 > 650)
    var_3 cull_list_of_players("_encstr_934D1BB936E42BCA37B90D585B2BF598A3F56CDE8DB1BE32C26BC2762B", "_encstr_822F163665A759C147D13890C99E8FD0DB27B527C53F212B");

  var_3 scripts\cp_mp\vehicles\vehicle_damage::_id_14143(1);

  if(var_3.health - var_0 <= 0) {
    if(!istrue(var_3.should_play_player_infil) && (var_1.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0" || var_1 == var_3))
      createteamdefenderflag();
    else {
      var_3 dodamage(var_0, var_2, undefined, undefined, "_encstr_8D4E0A501FCB898912CB3FA3");
      var_3 radiusdamage(var_3.origin, 512, 200, 80, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_84A00E50B085578F87182E98ED81081B");
      var_3.brlootchoppercrateactivatecallback = 1;
      var_3 scripts\cp_mp\vehicles\vehicle_damage::_id_14143(0);
      return;
    }
  }

  var_3 dodamage(var_0, var_2, undefined, undefined, "_encstr_8D4E0A501FCB898912CB3FA3");
  var_3 scripts\cp_mp\vehicles\vehicle_damage::_id_14143(0);
}

createteamdefenderflag() {
  var_0 = self;
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);

  foreach(var_3 in var_1) {
    var_3.donotmodifydamage = 1;
    var_3 dodamage(99, var_0.origin, var_3, var_3, "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9", "_encstr_84A00E50B085578F87182E98ED81081B");
    var_3.donotmodifydamage = undefined;
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(var_0);

  foreach(var_6 in var_1)
  var_6.plotarmor = 1;

  var_0 radiusdamage(var_0.origin, 512, 200, 80, var_0, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_84A00E50B085578F87182E98ED81081B");
  var_0.brlootchoppercrateactivatecallback = 1;

  foreach(var_6 in var_1)
  var_6.plotarmor = 0;
}

create_name_fx(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_0 gettagorigin(var_3), var_1, 0);
  var_5 linkTo(var_0, var_3, var_4, (0, 0, 0));
  var_5 setModel(var_2);
  var_5 setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
  var_5 setsentryowner(undefined);
  var_5 makeunusable();
  var_5 setdefaultdroppitch(0);
  var_5 setturretmodechangewait(1);
  var_5.angles = var_0.angles;
  var_5.vehicle = var_0;
  var_5.maxhealth = 999999;
  var_5.health = var_5.maxhealth;
  return var_5;
}

create_script_wait_for_flags(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_84A00E50B085578F87182E98ED81081B";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  if(isDefined(self.owner))
    self.owner.br_pe_chopper_damage_time = var_0.meansofdeath;

  self notify("_encstr_8B1A098BD8E134029B657C");

  if(istrue(level.finale_main))
    wait 0.2;

  if(!isDefined(self)) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  self setscriptablepartstate("_encstr_840703F23B", "_encstr_A29B05E9400E5D");
  self setscriptablepartstate("_encstr_AB700F3F0938439D5922C08309B04E104D", "_encstr_A29B05E9400E5D");
  self setscriptablepartstate("_encstr_82990E9BDE28FB5EE80F95F893E3A8D8", "_encstr_A29B05E9400E5D");
  self setscriptablepartstate("_encstr_BEA50D188B572DF572C9AEB9DD4A3B", "_encstr_A29B05E9400E5D");

  if(isDefined(self.isballisticspecial)) {
    foreach(var_3 in self.isballisticspecial)
    self setscriptablepartstate(var_3, "_encstr_BA19049F4B2D");
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread create_passengers_unload_groups();
  var_5 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  if(!istrue(self.brlootchoppercrateactivatecallback))
    self radiusdamage(self.origin, 512, 200, 80, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_84A00E50B085578F87182E98ED81081B");

  var_6 = scripts\engine\utility::ter_op(self.shouldmodeplayfinalmoments, "_encstr_A9190F05AFE5A8057B590992933BC8503F", "_encstr_A1391393FA6F6AC39391F9FB70F5280B0957C92EDD");
  playFX(scripts\engine\utility::getfx(var_6), var_5, anglesToForward(self.angles), anglestoup(self.angles));

  if(soundexists("_encstr_8E4616CD86BE983AEB26BDD626FA59F0831BBE1D4E1637CD"))
    playsoundatpos(var_5, "_encstr_8E4616CD86BE983AEB26BDD626FA59F0831BBE1D4E1637CD");

  earthquake(0.4, 800, var_5, 0.7);
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_5);
  physicsexplosionsphere(var_5, 500, 200, 1);
}

cruisepredator_watchintropoddisown() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  wait 2;
  var_1 = 1;
  var_2 = [var_0];

  for(;;) {
    var_3 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
    var_4 = var_0.origin + anglestoup(var_0.angles) * -600;
    var_5 = scripts\engine\trace::ray_trace(var_0.origin, var_4, var_2, var_3, 0);

    if(isDefined(var_5)) {
      if(var_1 && var_5["_encstr_AA1C0886968EA32FE056"] == "_encstr_AC4B0D3BD013D433491D6125700D8A") {
        if(!istrue(level.finale))
          var_0 setscriptablepartstate("_encstr_A1A80DA123D68258283949F70D4F53", "_encstr_BEE608BF50D84BAA9DF4", 0);

        var_0 setscriptablepartstate("_encstr_B1C009130BF27D46B77B9C", "_encstr_A6E3112658F2AF91F6B7277DDEE0ACB95A9B9D", 0);
        var_1 = 0;
      } else if(!var_1 && var_5["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A") {
        if(!istrue(level.finale))
          var_0 setscriptablepartstate("_encstr_A1A80DA123D68258283949F70D4F53", "_encstr_93CF08C7684F60BBB372", 0);

        var_0 setscriptablepartstate("_encstr_B1C009130BF27D46B77B9C", "_encstr_ABCE1198165EF546EDB793BEB1B1BDB95ACDCE", 0);
        var_1 = 1;
      }
    }

    wait 0.3;
  }
}

cruisepredator_detachplayerfromintro() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.curr_airlock_pos = 0;
  var_0.should_play_player_infil = 0;

  for(;;) {
    var_1 = [var_0];

    if(isDefined(var_0.waittill_player_picksup_armor))
      var_1 = [var_0, var_0.waittill_player_picksup_armor];

    var_2 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
    var_3 = scripts\engine\trace::ray_trace(var_0.origin, var_0.origin - (0, 0, 150), var_1, var_2, 0);

    if(isDefined(var_3)) {
      if(var_3["_encstr_AA1C0886968EA32FE056"] == "_encstr_AC4B0D3BD013D433491D6125700D8A") {
        var_0.shouldmodeplayfinalmoments = 1;
        var_0.should_play_player_infil = 1;
        var_0 setscriptablepartstate("_encstr_BDDC07EBCCB5CA4BED", "_encstr_AD4513AE081843B6CBEDC71BFB1566FBC099C9974D");
      } else if(istrue(var_0.shouldmodeplayfinalmoments)) {
        var_0 cull_list_of_players("_encstr_910E14D753B22B959B2B1821B26F40F0CB97616BF69F", "_encstr_96940F39D5B513B159EB981DAF1B85DC8C");
        var_0.shouldmodeplayfinalmoments = 0;
        var_0 setscriptablepartstate("_encstr_BDDC07EBCCB5CA4BED", "_encstr_962F0CB3560DD236D8CAD7576E59");
      }
    }

    var_4 = var_0 regroup_process_started();

    if(var_0.curr_airlock_pos != var_4 && isDefined(var_0.owner)) {
      var_0.curr_airlock_pos = var_4;
      var_0.owner cs_flags_init(1);
    }

    wait 0.2;
  }
}

create_passengers_unload_groups() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_83F40783ADF1D14AA3", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_83F40783ADF1D14AA3", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

createdefaultrectangularzone(var_0) {
  if(isDefined(var_0.damage) && var_0.damage > 0)
    self notify("_encstr_B2310D943398AE674DEE4B0270958B", var_0);

  return 1;
}

create_oscilloscope(var_0) {
  thread create_script_wait_for_flags(var_0);
  return 1;
}

create_silencer_pick_up(var_0, var_1) {
  if(!isDefined(var_0.turrets) || !isDefined(var_1))
    return undefined;

  return var_0.turrets[var_1];
}

createdevguientryforkidnapper() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8A49121C93F61CACB1C6CA93AFB9E09673AFBAE0");
  var_0 notify("_encstr_9706140E397B0E2B8D1B56E4BEE6835ADCD719DBBBB9");

  if(istrue(var_0._id_128E9)) {
    return;
  }
  var_0 setscriptablepartstate("_encstr_8F9D0AF3602FF27F68E9BDA2", "_encstr_A517086A8F6B5A9F6B48", 0);
  var_0._id_128E9 = 1;
  wait(getanimlength(level.scr_anim["_encstr_B4920771CA8F0618B2"]["_encstr_A517086A8F6B5A9F6B48"]));

  if(!isDefined(var_0)) {
    return;
  }
  var_0 setscriptablepartstate("_encstr_8F9D0AF3602FF27F68E9BDA2", "_encstr_A7C5056BD931D1", 0);
}

createdestinationvfx() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_9706140E397B0E2B8D1B56E4BEE6835ADCD719DBBBB9");
  var_0 notify("_encstr_8A49121C93F61CACB1C6CA93AFB9E09673AFBAE0");

  if(!isDefined(var_0._id_128E9)) {
    return;
  }
  var_0 setscriptablepartstate("_encstr_8F9D0AF3602FF27F68E9BDA2", "_encstr_B8120A535FC8923E79782FC5", 0);
  var_0._id_128E9 = undefined;
  wait(getanimlength(level.scr_anim["_encstr_B4920771CA8F0618B2"]["_encstr_B8120A535FC8923E79782FC5"]));

  if(!isDefined(var_0)) {
    return;
  }
  var_0 setscriptablepartstate("_encstr_8F9D0AF3602FF27F68E9BDA2", "_encstr_8F120D4B0B5A2D59C6755ED3DAB9A8", 0);
}

create_primary_weapon_obj_from_custom_loadout(var_0) {
  var_1 = self;

  if(!isDefined(var_1.isballisticspecial))
    var_1.isballisticspecial = [];

  if(!scripts\engine\utility::array_contains(var_1.isballisticspecial, "_encstr_878611380AC7898EB71940CCD703B173EEB2F8") && randomfloat(1.0) < 0.4)
    var_1.isballisticspecial[var_1.isballisticspecial.size] = "_encstr_878611380AC7898EB71940CCD703B173EEB2F8";

  if(!scripts\engine\utility::array_contains(var_1.isballisticspecial, "_encstr_932E122B7B6238C379BF633D4FB1F3AF6D0AE07D") && randomfloat(1.0) < 0.4)
    var_1.isballisticspecial[var_1.isballisticspecial.size] = "_encstr_932E122B7B6238C379BF633D4FB1F3AF6D0AE07D";

  if(var_0 && !scripts\engine\utility::array_contains(var_1.isballisticspecial, "_encstr_81BF0C5D09CFE0CF6F6AE880E2C7") && randomfloat(1.0) < 0.5)
    var_1.isballisticspecial[var_1.isballisticspecial.size] = "_encstr_81BF0C5D09CFE0CF6F6AE880E2C7";
}

createc130pathstruct(var_0) {
  var_1 = self;

  foreach(var_3 in var_1.isballisticspecial)
  var_1 setscriptablepartstate(var_3, var_0, 0);
}

createalldestinationvfx(var_0, var_1) {
  var_2 = self;
  var_2 create_primary_weapon_obj_from_custom_loadout(0);
  var_2 createc130pathstruct("_encstr_8FA906CC80677438");
  var_2 scripts\cp_mp\vehicles\vehicle_damage::_id_14165(var_0, var_1);
}

createapcturret(var_0, var_1) {
  var_2 = self;
  var_2 scripts\cp_mp\vehicles\vehicle_damage::_id_1416A(var_0, var_1);
}

createallhistorydestinations(var_0, var_1) {
  var_2 = self;
  var_2 create_primary_weapon_obj_from_custom_loadout(1);
  var_2 createc130pathstruct("_encstr_AB5E07609A5B7368E5");
  var_2 scripts\cp_mp\vehicles\vehicle_damage::_id_14167(var_0, var_1);
}

createattractionicontrigger(var_0, var_1) {
  var_2 = self;
  var_2 scripts\cp_mp\vehicles\vehicle_damage::_id_1416B(var_0, var_1);
}

createagenttargetloadout(var_0, var_1) {
  var_2 = self;
  var_2 create_primary_weapon_obj_from_custom_loadout(1);
  var_2 createc130pathstruct("_encstr_B846067B175AA56A");
  var_2 scripts\cp_mp\vehicles\vehicle_damage::_id_14163(var_0, var_1);
}

createandstartlights(var_0, var_1) {
  var_2 = self;
  var_2 scripts\cp_mp\vehicles\vehicle_damage::_id_14169(var_0, var_1);
}

_id_1327D() {
  level.createprematchloadout = spawnStruct();
  level.createprematchloadout.powers = [];
  bhadriotshield(level.createprematchloadout, "_encstr_BAE40965CAA2B10127F728", "_encstr_A9E60828803C73F11780", ::createscript_covernodes);
}

_id_14231(var_0) {
  if(isbot(self)) {
    return;
  }
  foreach(var_6, var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked)
    self notifyonplayercommand(var_6, var_4);
  }
}

_id_14230(var_0) {
  if(!isDefined(self) || isbot(self)) {
    return;
  }
  foreach(var_6, var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked)
    self notifyonplayercommandremove(var_6, var_4);
  }
}

bhadriotshield(var_0, var_1, var_2, var_3) {
  if(isstring(var_2))
    var_2 = [var_2];

  var_0.powers[var_1] = spawnStruct();
  var_0.powers[var_1].clients_hacked = var_2;
  var_0.powers[var_1].func = var_3;
}

cs_setup_arrays(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2.vehicle)) {
    return;
  }
  var_2.vehicle.turret.turreton = 1;
  var_2.vehicle.turret setmode("_encstr_849007B268BD03DFD8");
  var_2 thread csm_alg();
}

csm_alg() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_B4401A4712506C8238C77F3B23D12AA439DBFFCE0B8902BA81E59F3B");
  var_0.vehicle endon("_encstr_AD75063D571AE108");
  var_1 = var_0.vehicle.turret;
  var_2 = 6;

  for(;;) {
    var_1 shootturret("_encstr_A14F0AE336178944BA076F41", var_2);
    wait(level.ffsm_state);

    if(!var_0 attackButtonPressed())
      return;
  }
}

createscript_covernodes(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2.vehicle.dropbombs)) {
    return;
  }
  var_3 = -1;

  for(var_4 = 0; var_4 < var_2.vehicle.dropbombs.size; var_4++) {
    if(var_2.vehicle.dropbombs[var_4] == 0)
      var_3 = var_4;
  }

  if(var_3 < 0) {
    if(isDefined(level._id_13352))
      [[level._id_13352]]("_encstr_B4EA1DAB0930B9DDF125D6AADD122471E09957139751C08FC94C5926F42967");

    var_2 playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
    return;
  }

  if(abs(var_2.vehicle.angles[2]) > level.find_plunder || abs(angleclamp180(var_2.vehicle.angles[0])) > level.find_and_run_elevator_spawngroup) {
    if(isDefined(level._id_13352))
      [[level._id_13352]]("_encstr_A33B23AD318FCD6FEC85CB71872E6FD1E9BC9F470925D379585FA7B83979C76F8915AB9447");

    var_2 playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
    return;
  }

  var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
  var_6 = [];
  var_7 = scripts\engine\trace::ray_trace(var_2.vehicle.origin, var_2.vehicle.origin - (0, 0, level.finale_setup), var_6, var_5, 0);

  if(isDefined(var_7)) {
    if(var_7["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A") {
      if(isDefined(level._id_13352))
        [[level._id_13352]]("_encstr_955626AEC4EFDF138DF0A129E80D5997D7A8A836670F05DFA7A9D91130FFB7AF7F2FD03E8CDF6FA3");

      var_2 playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
      return;
    }
  }

  if(istrue(var_2.vehicle.turn_on_search_light))
    return;
  else
    var_2.vehicle.turn_on_search_light = 1;

  var_2.vehicle cull_list_of_players("_encstr_856715EBC03D8F47CD7EA8D91A09E716698953D238EF03", "_encstr_87C210E457B513D82BD789A3BEB9A1BDDB47");
  var_2 thread createstreakinfo_ai_turret(var_3);
}

createstreakinfo_ai_turret(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = var_1 ctf_bot_defender_limit_for_team();
  var_3 = var_1.vehicle;
  var_3 endon("_encstr_AD75063D571AE108");
  var_4 = var_3.origin;

  if(isDefined(var_2))
    var_4 = var_2;

  if(isDefined(level.cumulative_damage_monitor)) {
    foreach(var_6 in level.players) {
      if(var_1 == var_6) {
        continue;
      }
      if(isDefined(var_6.vehicle) && var_6.vehicle == var_3) {
        continue;
      }
      if(var_6.origin[2] > var_4[2]) {
        continue;
      }
      var_7 = distance2dsquared(var_6.origin, var_4);

      if(var_7 < 2890000) {
        if(!isDefined(var_6.cratephysicsoff)) {
          var_6.cratephysicsoff = 1;
          var_6 thread _id_12511();

          if(var_1.team != var_6.team)
            var_6 thread[[level.cumulative_damage_monitor]]("_encstr_91B2177EAB19829B781577777DAFB2F4A0337389E1484DC243");
        }
      }
    }
  }

  if(soundexists("_encstr_A92A152AED47DA74EE18AFAF30C65C12B169B52020C7F2"))
    var_3 playsoundtoplayer("_encstr_A92A152AED47DA74EE18AFAF30C65C12B169B52020C7F2", var_1);

  var_3.dropbombs[var_0] = level.failsmokinggunquest;

  if(isDefined(var_1))
    var_1 cs_flags_init(1);

  var_3.watch_for_players_ledgespawners = gettime();
  var_1 thread crushing_players(var_3 gettagorigin("_encstr_AAC71E1D16B3BE762B589CFA19BDF6E4D7339CBDB9477D37B5C28DD8F539EDE8") - (0, 0, 190));
  var_3 thread createscreeneffectext(var_0);
  wait(level.farobjectiveiconid);
  var_3.turn_on_search_light = 0;
}

ctf_bot_defender_limit_for_team() {
  var_0 = self;
  var_1 = var_0.vehicle;
  var_2 = (0, 0, 0);
  var_3 = -800;
  var_4 = 0;
  var_5 = undefined;
  var_6 = 15;
  var_7 = 0.2;
  var_8 = (var_7, var_7, var_7);

  if(level.failtimedrunquest >= 0.0 && isDefined(var_0.vehicle)) {
    var_9 = var_1 getentityvelocity();
    var_4 = (var_9[0] * level.failtimedrunquest, var_9[1] * level.failtimedrunquest, var_2[2]);
  }

  var_10 = var_1.origin;
  var_11 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
  var_12 = [var_1, var_0];
  var_5 = var_4;

  for(var_13 = var_7; var_13 < var_6; var_13 = var_13 + var_7) {
    var_14 = var_13 - var_7;
    var_15 = var_2[2] + var_13 * var_3;

    if(var_15 > level.failx1finquest)
      var_5 = (var_4[0], var_4[1], level.failx1finquest);

    var_16 = var_5 * var_14 + (0, 0, 0.5 * var_3 * var_14 * var_14);
    var_17 = var_5 * var_13 + (0, 0, 0.5 * var_3 * var_13 * var_13);
    var_18 = var_10 + var_16;
    var_19 = var_10 + var_17;
    var_20 = scripts\engine\trace::ray_trace(var_18, var_19, var_12, var_11, 0);

    if(isDefined(var_20) && var_20["_encstr_A53009A25003666B9818C6"] < 1.0) {
      var_19 = var_20["_encstr_BD260953AA97E3F014279D"] + (0, 0, 20);
      return var_19;
    }
  }

  return;
}

_id_12511() {
  var_0 = self;
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 7;

  if(!isDefined(var_0)) {
    return;
  }
  var_0.cratephysicsoff = undefined;
}

createscreeneffectext(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_1.owner)) {
    return;
  }
  var_2 = var_1.owner;
  var_2 endon("_encstr_84B615C4A3BEC4B7B5987DCCDE396C2BAFC99566D236B1");

  while(var_1.dropbombs[var_0] > 0) {
    var_1.dropbombs[var_0] = var_1.dropbombs[var_0] - 0.05;
    wait 0.05;
  }

  var_1 createscriptedspawnpoint(1, var_0);
}

crushing_players(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 notify("_encstr_B462150A50F3BEB753B87E6D441E63050BD041E2935F72");
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2 setModel("_encstr_91D421989F89BAFF68CF4CB209FDCF032288F3430F7A56491FDBF9D8300DF062497883");
  var_2 setCanDamage(1);
  var_2.origin = var_0;
  var_2.angles = (0, 0, 0);
  var_2.health = 9000;
  var_2 show();
  var_2.owner = var_1;
  var_2._id_123A8 = 0;
  var_2 playLoopSound("_encstr_AF72191B1D1E2DEB5F7A0F694A7179FA8782D714D8851F0359E429");
  var_2 thread create_fake_loot_model_from_struct();

  if(isDefined(var_1.vehicle))
    var_1.vehicle.waittill_player_picksup_armor = var_2;

  if(!isDefined(level._id_123A9))
    level._id_123A9 = [];

  level._id_123A9[level._id_123A9.size] = var_2;
  var_3 = (0, 0, -1);

  if(level.failtimedrunquest >= 0.0 && isDefined(var_1.vehicle)) {
    var_4 = var_1.vehicle getentityvelocity();
    var_3 = (var_4[0] * level.failtimedrunquest, var_4[1] * level.failtimedrunquest, var_3[2]);
  }

  var_2.velocity = var_3;
  var_2 movegravity(var_3, 60);
  var_2 thread current_button_counter();
  var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
  var_6 = [var_2];

  if(istrue(level.fake_agent_model_setup))
    var_1 thread _id_12513(var_2);

  var_2 thread current_cypher_pieces();

  for(;;) {
    var_7 = var_2.origin;
    waitframe();

    if(!isDefined(var_2) || istrue(var_2._id_123A8)) {
      break;
    }

    var_8 = scripts\engine\trace::ray_trace(var_7, var_2.origin, var_6, var_5, 0);

    if(isDefined(var_8) && var_8["_encstr_A53009A25003666B9818C6"] < 1.0) {
      var_2.origin = var_8["_encstr_BD260953AA97E3F014279D"] + (0, 0, 20);
      var_2 createteamdefenderflagbase();
      break;
    }

    if(var_2.velocity[2] > level.failx1finquest)
      var_2.velocity = (var_2.velocity[0], var_2.velocity[1], level.failx1finquest);
  }
}

current_cypher_pieces() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  waitframe();
  playFXOnTag(level._effect["_encstr_BEFC150DA79DD00D7341E1484A1B28C0340E99FF4687C8"], var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

_id_12513(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait(level.findvalidspectateprop);

  if(!isDefined(var_1.gas_vfx_range_think))
    var_1.gas_vfx_range_think = 0;

  var_1.gas_vfx_range_think = var_1.gas_vfx_range_think + 1;
  var_1 thread _id_12515(level.findteamwithnoplayers);

  if(!isDefined(var_0)) {
    return;
  }
  var_1.vehicle _meth_87D7(var_0);
  var_1 setclientomnvar("_encstr_BA1E177B08D9418A2EF1BB87255D11B9E8D379C6E1D801338D", 0);
  var_2 = "_encstr_995408F398012F656821";
  var_1 thread _id_12514(var_0);

  for(;;) {
    if(!isDefined(var_2)) {
      return;
    }
    if(var_2 == "_encstr_B4401A4712506C8238C77F3B23D12AA439DBFFCE0B8902BA81E59F3B") {
      var_1.gas_vfx_range_think = var_1.gas_vfx_range_think - 1;
      var_1 setclientomnvar("_encstr_BA1E177B08D9418A2EF1BB87255D11B9E8D379C6E1D801338D", 0);
      return;
    }

    if(!var_1 adsButtonPressed() || var_2 == "_encstr_B4401A4712506C8238C77F3B23D12AA439DBFFCE0B8902BA81E59F3B") {
      var_1.gas_vfx_range_think = var_1.gas_vfx_range_think - 1;
      var_1 setclientomnvar("_encstr_BA1E177B08D9418A2EF1BB87255D11B9E8D379C6E1D801338D", 0);
      var_1.vehicle _meth_87D7();
      return;
    }

    if(var_2 == "_encstr_8C831C7B88589AAAE5A8D64EA9E31321A648D7CF9876D54339D9DD078599") {
      return;
    }
    var_2 = scripts\engine\utility::waittill_any_in_array_or_timeout(["_encstr_B4401A4712506C8238C77F3B23D12AA439DBFFCE0B8902BA81E59F3B", "_encstr_8C831C7B88589AAAE5A8D64EA9E31321A648D7CF9876D54339D9DD078599"], 1.0);
  }
}

_id_12514(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_B462150A50F3BEB753B87E6D441E63050BD041E2935F72");
  var_1 endon("_encstr_A37D164B1F099ADD2046BAC418F0F481DEB1F7FB97A74283");

  while(isDefined(var_0))
    wait 0.1;

  var_1 thread _id_12515(0.3);
  var_1.gas_vfx_range_think = var_1.gas_vfx_range_think - 1;

  if(var_1 adsButtonPressed() && var_1.gas_vfx_range_think == 0)
    var_1 setclientomnvar("_encstr_BA1E177B08D9418A2EF1BB87255D11B9E8D379C6E1D801338D", 1);

  var_1 notify("_encstr_8C831C7B88589AAAE5A8D64EA9E31321A648D7CF9876D54339D9DD078599");
}

_id_12515(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_B462150A50F3BEB753B87E6D441E63050BD041E2935F72");
  var_1 notify("_encstr_9A8E1089BDDA265939EBB92BBBBE335823CA");
  var_1 endon("_encstr_9A8E1089BDDA265939EBB92BBBBE335823CA");

  if(isDefined(level.critical_messages))
    var_1 thread[[level.critical_messages]]();

  wait(var_0);

  if(isDefined(level.createzombieloadout))
    var_1 thread[[level.createzombieloadout]]();
}

current_button_counter() {
  var_0 = self;

  while(isDefined(var_0) && isDefined(var_0._id_123A8) && !istrue(var_0._id_123A8)) {
    if(var_0.origin[2] < -10000) {
      var_0 createteamdefenderflagbase();
      break;
    }

    wait 0.5;
  }
}

create_fake_loot_model_from_struct() {
  var_0 = self;
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;
  var_0 waittill("_encstr_B2BE0788BAF573592F");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 createteamdefenderflagbase();
}

createteamdefenderflagbase() {
  var_0 = self;
  var_0._id_123A8 = 1;
  var_0 stoploopsound("_encstr_AF72191B1D1E2DEB5F7A0F694A7179FA8782D714D8851F0359E429");
  level._id_123A9 = scripts\engine\utility::array_remove(level._id_123A9, var_0);

  if(!isDefined(var_0.owner)) {
    var_0 delete();
    return;
  }

  var_1 = var_0.origin;
  var_2 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
  var_3 = [];
  var_4 = scripts\engine\trace::ray_trace(var_1, var_1 - (0, 0, 100), var_3, var_2, 0);
  var_5 = spawnfx(scripts\engine\utility::getfx("_encstr_918F1B89DBDA31B29C7D13DEB613AF5687C1D8ED2395FACE9CF6EAB991"), var_1);

  if(isDefined(var_4)) {
    if(var_4["_encstr_AA1C0886968EA32FE056"] == "_encstr_AC4B0D3BD013D433491D6125700D8A")
      var_5 = spawnfx(scripts\engine\utility::getfx("_encstr_A5AF18CEB838321A7EFFB38FF32EE16D38E3C5153180C792DBBD"), var_1, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  }

  playsoundatpos(var_1, "_encstr_8E4616CD86BE983AEB26BDD626FA59F0831BBE1D4E1637CD");
  earthquake(0.4, 800, var_1, 0.7);
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_1);
  physicsexplosionsphere(var_1, 500, 200, 1);
  var_5 unmarkkeyframedmover(1);
  triggerfx(var_5);
  var_5 thread createobjectivelist(9);
  var_0.owner.current_count_down = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  if(istrue(level.farah_says_cut_wire_yellow)) {
    var_6 = canceljoins(undefined, undefined, var_1, 980);

    if(isDefined(var_6)) {
      foreach(var_8 in var_6) {
        if(!isDefined(var_8.embassy_main) || var_8 == var_0 || var_8.type == "_encstr_BE7B14B6634847D225A787C7C747EB85298BEEBFB8F8" || var_8.type == "_encstr_82BC0EA97AB7F05FD367DFE1DB0A9340" || var_8.type == "_encstr_8E5615586B9997799307D0550A07A04571E2B0E8726DC3" || var_8.type == "_encstr_B6390BC493FA1DE4B0B67758F2") {
          continue;
        }
        if(isDefined(level._id_11A22)) {
          [[level._id_11A22]](var_8);
          var_0.owner.current_count_down[5] = var_0.owner.current_count_down[5] + 1;
        }
      }
    }
  }

  var_10 = [];

  if(isDefined(level.resttimems))
    var_10 = [[level.resttimems]](var_1, 980);

  var_2 = scripts\engine\trace::create_contents(1, 1, 0, 0, 0, 1, 1);
  var_3 = [var_0];

  foreach(var_12 in var_10) {
    var_4 = scripts\engine\trace::ray_trace(var_1 + (0, 0, 50), var_12.origin + (0, 0, 50), var_3, var_2, 0);

    if(isDefined(var_4["_encstr_999F0D032513EF1788D7CC45523773"]) && var_4["_encstr_999F0D032513EF1788D7CC45523773"] == 0) {
      if(var_12.team != var_0.owner.team) {
        if(isDefined(level.createpropspeclist)) {
          var_13 = [[level.createpropspeclist]](var_12);

          if(istrue(var_13))
            var_0.owner.current_count_down[3] = var_0.owner.current_count_down[3] + 1;
          else
            var_0.owner.current_count_down[4] = var_0.owner.current_count_down[4] + 1;
        }

        var_12 dodamage(60, var_1, var_0.owner, var_0.owner, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_85B1132B9BA06F5A9DFD679BE1502298218165F5D1");
      }
    }

    var_12 earthquakeforplayer(0.35, 2.0, var_1, 980);
    var_4 = scripts\engine\trace::ray_trace(var_12.origin + (0, 0, 25), var_1 + (0, 0, 75), var_3, var_2, 0);

    if(isDefined(var_4["_encstr_AA1C0886968EA32FE056"]) && var_4["_encstr_AA1C0886968EA32FE056"] == "_encstr_AC4B0D3BD013D433491D6125700D8A")
      var_12 thread scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", "_encstr_AC190479FF92", 2.5, 1);
  }

  var_0 radiusdamage(var_1, 512, 5000, 180, var_0.owner, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_85B1132B9BA06F5A9DFD679BE1502298218165F5D1");

  if(istrue(level.farah_says_cut_wire_green) && isDefined(level.br_pickups)) {
    var_15 = undefined;

    foreach(var_17 in level.br_pickups.crates) {
      if(!isDefined(var_17) || !isDefined(var_17.origin)) {
        continue;
      }
      if(isDefined(var_17.team) && isDefined(var_0.owner) && var_17.team == var_0.owner.team) {
        continue;
      }
      var_18 = distance(var_1, var_17.origin);

      if(isDefined(var_18) && var_18 < 980) {
        if(var_17.cratetype == "_encstr_96D516B648DD1B404537ADC86326F8CFFF133847B347132D") {
          if(isDefined(level.crossbowimpactwatcher))
            var_15 = [[level.crossbowimpactwatcher]](var_17.team, "_encstr_9775086022BE1B413B8B");

          if(isDefined(level.createplayerplundereventdata))
            level thread[[level.createplayerplundereventdata]]("_encstr_918B15891DBE36B758917BEA3AFA325637D1E4EDCB9523", 1, var_15);

          var_0.owner.current_count_down[1] = var_0.owner.current_count_down[1] + 1;
        } else
          var_0.owner.current_count_down[2] = var_0.owner.current_count_down[2] + 1;

        var_17 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();

        if(isDefined(level.cruise_predator_direction_override))
          var_0.owner thread[[level.cruise_predator_direction_override]]("_encstr_BEC819A172AFE0CD098BD7CB93D11D103B4B2B98D8C7B086C23BCB");
      }
    }
  }

  if(istrue(level.farms2_gw_ambient_sound_load) && isDefined(level._id_13400)) {
    foreach(var_21 in level._id_13400.areas_remaining) {
      if(!isDefined(var_21)) {
        continue;
      }
      var_22 = distance(var_1, var_21.origin);

      if(var_22 < 980)
        var_21.chopperexfil_sfx_before_sh070[[level.cumulative_damage_to_chopper_boss]]();
    }
  }

  if(istrue(level.farah_says_cut_wire_red) && isDefined(level.br_armory_kiosk)) {
    foreach(var_25 in level.br_armory_kiosk.scriptables) {
      var_26 = distance(var_1, var_25.origin);

      if(var_26 < 980) {
        if(isDefined(var_25.visible)) {
          if(isDefined(level.little_bird_mg_mp_initspawning)) {
            foreach(var_12 in level.players) {
              if(isDefined(var_12.delay_kick_inactive_player) && var_12.delay_kick_inactive_player == var_25) {
                if(isDefined(level.createquestcircle))
                  var_12[[level.createquestcircle]](2);
              }
            }

            [[level.little_bird_mg_mp_initspawning]](var_25);
            var_0.owner.current_count_down[0] = var_0.owner.current_count_down[0] + 1;

            if(isDefined(level.cruise_predator_direction_override))
              var_0.owner thread[[level.cruise_predator_direction_override]]("_encstr_AA60194C277D13A37D98DEB598D7C82B9B8E93B7CBBEADB4B7DCD6");

            if(isDefined(level.crossbowbolts)) {
              var_29 = [[level.crossbowbolts]]("_encstr_BD6E090B60F9C74FC88B06");

              foreach(var_31 in var_29.instances) {
                if(var_31._id_1393B._id_13A7A == var_25) {
                  if(isDefined(level.crossbow))
                    var_31[[level.crossbow]]();
                }
              }
            }
          }
        }
      }
    }
  }

  _encstr_AAAB18F8587259C9053357C3BDB8513F697305ADEB5B7B38EB98(var_0, var_1);

  if(isDefined(level.vehicle) && isDefined(level.vehicle.instances)) {
    foreach(var_35 in level.vehicle.instances) {
      foreach(var_37 in var_35) {
        if(!isDefined(var_37) || !isDefined(var_37.origin)) {
          continue;
        }
        var_38 = distance(var_1, var_37.origin);

        if(var_38 > 980) {
          continue;
        }
        var_39 = int(var_37.maxhealth * level.fast_revive_time);
        var_37 dodamage(var_39, var_1, var_0.owner, var_0.owner, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_85B1132B9BA06F5A9DFD679BE1502298218165F5D1");

        if(var_37.vehiclename == "_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843") {
          var_0.owner.current_count_down[6] = var_0.owner.current_count_down[6] + 1;
          continue;
        }

        var_0.owner.current_count_down[7] = var_0.owner.current_count_down[7] + 1;
      }
    }
  }

  if(istrue(level.farah_nobraids_body_reset)) {
    if(isDefined(level.arenaflag_showflagoutlineplayer)) {
      foreach(var_43 in level.arenaflag_showflagoutlineplayer) {
        if(!isDefined(var_43)) {
          continue;
        }
        var_44 = distance(var_1, var_43.origin);

        if(var_44 > 980) {
          continue;
        }
        var_43 dodamage(5000, var_1, var_0.owner, var_0.owner, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_85B1132B9BA06F5A9DFD679BE1502298218165F5D1");
        var_0.owner.current_count_down[8] = var_0.owner.current_count_down[8] + 1;

        if(isDefined(level.cruise_predator_direction_override))
          var_0.owner thread[[level.cruise_predator_direction_override]]("_encstr_AD3D1D319CFA13E8EBC4F6D6317D32956E3AE4BD2FEB2CC27D8E57C94E593A");
      }
    }
  }

  var_0.owner.current_count_down[9] = var_0.owner.current_count_down[9] + 1;
  var_46 = [];

  for(var_47 = 0; var_47 < var_0.owner.current_count_down.size; var_47++) {
    switch (var_47) {
      case 0:
        var_46[var_46.size] = "_encstr_AB4A0C3B189ACBFB03FD940DE80F";
        break;
      case 1:
        var_46[var_46.size] = "_encstr_B1750F73B8E9AC3A3BED093ED63B437573";
        break;
      case 2:
        var_46[var_46.size] = "_encstr_9B8F0DA00B92DB43578F68F83B85BB";
        break;
      case 3:
        var_46[var_46.size] = "_encstr_ACDB0D46BDDDCD5623FA59E656D697";
        break;
      case 4:
        var_46[var_46.size] = "_encstr_88BF06FD784A6393";
        break;
      case 5:
        var_46[var_46.size] = "_encstr_8EAD05E157ED90";
        break;
      case 6:
        var_46[var_46.size] = "_encstr_B466095A7116816BDB36BF";
        break;
      case 7:
        var_46[var_46.size] = "_encstr_8E360FCF6414203E7F9B59E07257F9E86A";
        break;
      case 8:
        var_46[var_46.size] = "_encstr_87680AB085AF1DBA93C92B1D";
        break;
      case 9:
        var_46[var_46.size] = "_encstr_A2690CA352BB6B20CFDA0871B217";
        break;
      default:
        break;
    }

    var_46[var_46.size] = var_0.owner.current_count_down[var_47];
  }

  var_46[var_46.size] = "_encstr_AC6E09881A36337B5F6F30";
  var_48 = var_1[0] + "_encstr_964C0249" + var_1[1] + "_encstr_964C0249" + var_1[2];
  var_46[var_46.size] = var_48;

  if(isDefined(var_0.owner))
    var_0.owner dlog_recordplayerevent("_encstr_BE521F1A8528A7C9E5F0F565D9BFC3682F30EB39D0AFC06D5182EA9B6BAA2387C7", var_46);

  var_0 delete();
}

_encstr_AAAB18F8587259C9053357C3BDB8513F697305ADEB5B7B38EB98(var_0, var_1) {
  if(istrue(level._encstr_878B1A630148A292A0DB561D10A0CCCA3669BBDFA3866B6A08618F22) && isDefined(level.debug_trap_room)) {
    foreach(var_3 in level.debug_trap_room.scriptables) {
      var_4 = distance(var_1, var_3.origin);

      if(var_4 < 980 && isDefined(var_3.visible) && isDefined(level._encstr_95CA1C6BBBD86B70A90FC143F9570A821BE87ECC17E0B0F58F407D4748CE)) {
        [[level._encstr_95CA1C6BBBD86B70A90FC143F9570A821BE87ECC17E0B0F58F407D4748CE]](var_3);
        var_0.owner.current_count_down[5] = var_0.owner.current_count_down[5] + 1;

        if(isDefined(level.cruise_predator_direction_override))
          var_0.owner thread[[level.cruise_predator_direction_override]]("_encstr_8A341A763A3701B9817A186B52A941396FC48678998F8BFD760270E0");
      }
    }
  }
}

createobjectivelist(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_0);

  if(isDefined(var_1))
    var_1 delete();
}

createspawncamera() {
  level.createsmokesignalfx = getEntArray("_encstr_B8931BD9AC1ABE5813606632F527CAC6DE2CC8D7239CBD387DC4DED689", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level.createsmokesignalfx)
  level thread createserverfontstring(var_1);
}

createserverfontstring(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread ctfnukeended(var_0.origin);

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isbot(var_1) || !isalive(var_1)) {
      continue;
    }
    if(!isDefined(var_1.vehicle) || !isDefined(var_1.vehicle.model) || !isDefined(var_1.vehicle.dropbombs) || var_1.vehicle.model != "_encstr_871219BCED2B66779B69C8E072690BF82BAFCEB84DBBE9BDB9F348") {
      continue;
    }
    var_2 = 0;

    for(var_3 = 0; var_3 < var_1.vehicle.dropbombs.size; var_3++) {
      if(var_1.vehicle.dropbombs[var_3] == 0)
        var_2 = 1;
    }

    if(!var_2) {
      continue;
    }
    if(isDefined(var_1.vehicle.watch_for_players_ledgespawners)) {
      var_4 = var_1.vehicle.watch_for_players_ledgespawners + level.find_free_drop_location;

      if(var_4 > gettime())
        continue;
    }

    if(isDefined(level.crossbowusageloop))
      var_1 thread[[level.crossbowusageloop]]("_encstr_B6AD14984EAFC4A3F53995CD1D7BD8DAFAC47BB698DC", 150);

    if(isDefined(level.ctgs_recordmatchstats))
      var_1 thread[[level.ctgs_recordmatchstats]]("_encstr_B6AD14984EAFC4A3F53995CD1D7BD8DAFAC47BB698DC");

    if(isDefined(level.cumulative_damage_monitor))
      var_1 thread[[level.cumulative_damage_monitor]]("_encstr_82D91B4EDA713E556F2ED3AF85C75138AF838817B8E0F76AE2C9BF7BF2");

    var_1.vehicle createscriptedspawnpoint(level.farah_nobraids_body);
    var_1 notify("_encstr_84B615C4A3BEC4B7B5987DCCDE396C2BAFC99566D236B1");
  }
}

ctfnukeended(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!istrue(level.find_supply_station)) {
    return;
  }
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(var_1 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_1, "_encstr_AF5A081BBAC993AC73A3", var_0, "_encstr_AF6E30F533B9AB5239854AC9807607B3815815F752415D26BFDB3E282BCB97B98A3A30BA4A33BF3BE3AFAC66BAA090ABE968");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_1, 1);
  } else {}

  for(;;) {
    objective_removeallfrommask(var_1);

    if(isDefined(level.vehicle.instances) && isDefined(level.vehicle.instances["_encstr_83F40783ADF1D14AA3"])) {
      foreach(var_3 in level.vehicle.instances["_encstr_83F40783ADF1D14AA3"]) {
        var_4 = distance(var_3.origin, var_0);

        if(var_4 < 12000) {
          var_5 = 1;

          for(var_6 = 0; var_6 < var_3.dropbombs.size; var_6++) {
            if(var_3.dropbombs[var_6] > 0)
              var_5 = 0;
          }

          if(!var_5) {
            var_7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(var_3);

            if(isDefined(var_7))
              objective_addclienttomask(var_1, var_7);
          }
        }
      }

      objective_showtoplayersinmask(var_1);
    }

    wait 5;
  }
}

createscriptedspawnpoint(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_1) && var_2.dropbombs[var_1] == 0) {
    return;
  }
  if(!isDefined(var_1)) {
    for(var_3 = 0; var_3 < var_2.dropbombs.size; var_3++)
      var_2.dropbombs[var_3] = 0;
  } else
    var_2.dropbombs[var_1] = 0;

  if(!isDefined(var_2.owner)) {
    return;
  }
  var_4 = var_2.owner;
  var_4 cs_flags_init(1);
  var_5 = soundexists("_encstr_AF51160E6316CDCABE8D4333F526B7D64C7D93591B7B168C");

  if(var_5)
    var_4 playsoundtoplayer("_encstr_AF51160E6316CDCABE8D4333F526B7D64C7D93591B7B168C", var_4);
}

_id_12636(var_0, var_1) {
  var_2 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_2 endon("_encstr_B4401A4712506C8238C77F3B23D12AA439DBFFCE0B8902BA81E59F3B");

  for(;;) {
    var_2 waittill(var_1);
    waittillframeend;
    var_2 thread[[var_0.powers[var_1].func]](var_0, var_1);
  }
}

_id_12635(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_B4401A4712506C8238C77F3B23D12AA439DBFFCE0B8902BA81E59F3B");

  if(isbot(var_1)) {
    return;
  }
  foreach(var_4, var_3 in var_0.powers)
  var_1 thread _id_12636(var_0, var_4);
}

create_rocket_death_fx(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3.javelin)) {
    if(isDefined(var_3.javelin.state) && var_3.javelin.state != "_encstr_BA19049F4B2D" || isDefined(var_3.javelin.target) || isDefined(var_3.javelin.groundlockonent)) {
      var_4.success = 0;
      return;
    }
  }

  var_3 skydive_setbasejumpingstatus(0);
  var_3 skydive_setdeploymentstatus(0);

  if(isDefined(level.findclearflightyaw) && level.findclearflightyaw > 0)
    var_0.origin = var_0.origin + (0, 0, level.findclearflightyaw);

  if(istrue(level.ffsm_isgulagrespawn)) {
    if(var_1 == "_encstr_A266062032BD7723")
      var_3 thread _id_1315F();
  }

  var_0 thread create_heartbeat_sensor_pick_ups();

  if(var_1 == "_encstr_A266062032BD7723")
    var_0 thread createdevguientryforkidnapper();

  if(isDefined(var_2)) {
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);

    if(var_2 != "_encstr_A266062032BD7723")
      createcallbacks(var_0, var_3, var_4, "_encstr_84A00E50B085578F87182E98ED81081B", var_2, var_1);
  }

  if(var_1 == "_encstr_A266062032BD7723") {
    var_3 thread _id_14231(level.createprematchloadout);
    var_3 thread _id_12635(level.createprematchloadout);

    if(istrue(level.fast_rope_over_black))
      var_3 thread cumulative_damage_expire_time();

    if(istrue(level.ffsm_introsetup))
      var_3 thread cur_goal_struct();

    var_3 thread createnagarray();
  } else
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, "_encstr_84A00E50B085578F87182E98ED81081B", var_4, 1);

  scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
  var_3 _id_13FBF("_encstr_84310D05A9BF09011993D0709AAFE9", 2047, 0, 11, 1);

  if(var_1 != "_encstr_A266062032BD7723")
    var_3 thread set_track_operational_status();
}

playerpowerrestartallcooldowns() {
  var_0 = self;

  if(isbot(var_0)) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_B4401A4712506C8238C77F3B23D12AA439DBFFCE0B8902BA81E59F3B");

  while(!isDefined(var_0.vehicle))
    waitframe();

  while(isDefined(var_0.vehicle)) {
    if(isDefined(var_0.waittillspectating) && gettime() - var_0.waittillspectating < level.ffsm_nextstreamhinttime) {
      waitframe();
      continue;
    }

    if(var_0 _meth_87DB()) {
      var_0.playerpowersaddhudelem = 1;
      var_0.waittillspectating = gettime();
    } else if(isDefined(var_0.waittillspectating)) {
      var_0.playerpowersaddhudelem = undefined;
      var_0.waittillspectating = undefined;
    }

    waitframe();
  }
}

binoculars_istargetinrange() {
  var_0 = self;

  if(isbot(var_0)) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_B4401A4712506C8238C77F3B23D12AA439DBFFCE0B8902BA81E59F3B");
  var_0 setclientomnvar("_encstr_BA1E177B08D9418A2EF1BB87255D11B9E8D379C6E1D801338D", 0);

  while(!isDefined(var_0.vehicle))
    waitframe();

  var_0.vehicle endon("_encstr_AD75063D571AE108");
  var_1 = 0;

  while(isDefined(var_0.vehicle)) {
    if(isDefined(var_0.waittill_player_has_dropkit_marker) && gettime() - var_0.waittill_player_has_dropkit_marker < level.failedtext) {
      waitframe();
      continue;
    }

    if(binoculars_istargetinbroadfov() != var_1 && !isDefined(var_0.playerpowersaddhudelem)) {
      var_0.waittill_player_has_dropkit_marker = gettime();

      if(isDefined(level.critical_messages)) {
        var_0 notify("_encstr_ADF21F88BB692ACBDB265BD087020B33D92FA188E305A4D3639F40E61EFA1BB83C");
        var_0 thread[[level.critical_messages]]();
      }

      var_2 = gettime() + level.failhistoryquest * 1000;

      while(binoculars_istargetinbroadfov() != var_1 && gettime() < var_2)
        waitframe();

      if(isDefined(level.createzombieloadout))
        var_0 thread[[level.createzombieloadout]]();

      if(binoculars_istargetinbroadfov() != var_1) {
        var_1 = !var_1;
        var_0 setclientomnvar("_encstr_BA1E177B08D9418A2EF1BB87255D11B9E8D379C6E1D801338D", var_1);
      }
    }

    waitframe();
  }
}

binoculars_istargetinbroadfov() {
  var_0 = self;

  if(!isDefined(var_0.vehicle))
    return 0;

  if(!var_0 adsButtonPressed())
    return 0;

  if(var_0.vehicle regroup_process_started() != 2)
    return 0;

  var_1 = [var_0.vehicle];

  if(isDefined(var_0.vehicle.waittill_player_picksup_armor))
    var_1 = [var_0.vehicle, var_0.vehicle.waittill_player_picksup_armor];

  var_2 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
  var_3 = scripts\engine\trace::ray_trace(var_0.vehicle.origin, var_0.vehicle.origin - (0, 0, 600), var_1, var_2, 0);
  return var_3["_encstr_A53009A25003666B9818C6"] >= 1.0;
}

binoculars_iswithinprojectiondistance() {
  var_0 = self;

  if(isbot(var_0)) {
    return;
  }
  var_0 setclientomnvar("_encstr_BA1E177B08D9418A2EF1BB87255D11B9E8D379C6E1D801338D", 0);
}

cur_goal_struct() {
  var_0 = self;
  var_0 endon("_encstr_B4401A4712506C8238C77F3B23D12AA439DBFFCE0B8902BA81E59F3B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 2;

  if(!isDefined(var_0.vehicle)) {
    return;
  }
  var_1 = var_0.vehicle;
  var_1 endon("_encstr_AD75063D571AE108");
  var_1.nuke_killplayerwithattacker = 0;

  while(isDefined(var_0.vehicle)) {
    if(var_0 fragButtonPressed() && istrue(var_1.shouldmodeplayfinalmoments) && !istrue(var_1.nuke_killplayerwithattacker))
      var_1 thread create_puddle_triggers();

    wait 0.2;
  }
}

createnagarray() {
  var_0 = self;
  var_0 endon("_encstr_A9601CCA3C4B47B4B9B3F538A5367BD1AF6EB2C2A3EBC2D24E6CE40B33E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 2;

  if(!isDefined(var_0.vehicle)) {
    return;
  }
  var_1 = var_0.vehicle;
  var_1 endon("_encstr_AD75063D571AE108");

  if(istrue(var_1.shouldmodeplayfinalmoments)) {
    return;
  }
  for(;;) {
    while(var_1 vehicle_getspeed() < 60)
      wait 0.2;

    var_1 cull_list_of_players("_encstr_91AC162646BB5339FE47C070DF0DB69503E197A6DEA23940", "_encstr_B840110A63AA3690B5F7DEFC8F810FC33522B1");

    while(var_1 vehicle_getspeed() > 60)
      wait 1.5;
  }
}

create_puddle_triggers() {
  var_0 = self;
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 notify("_encstr_97D8110768AFF206C1E9CF3FD039F42A6BF00C");
  var_0 endon("_encstr_97D8110768AFF206C1E9CF3FD039F42A6BF00C");
  var_0.nuke_killplayerwithattacker = 1;
  var_0 setscriptablepartstate("_encstr_BEA50D188B572DF572C9AEB9DD4A3B", "_encstr_BEA50D188B572DF572C9AEB9DD4A3B", 1);
  var_0 cull_list_of_players("_encstr_AB3F18F34710DF1FB8FB1AB2C005BF57F8579961FD38A2D7D2D1", "_encstr_B85A139CAB5B4CB195EB1347AFC25A3989E4B06D59");

  if(soundexists("_encstr_BE0110124B31AE82107B17631FA6ABE128C9"))
    var_0 playsoundtoplayer("_encstr_BE0110124B31AE82107B17631FA6ABE128C9", var_0.owner);

  wait 2;

  while(isDefined(var_0.owner) && var_0.owner fragButtonPressed())
    wait 0.4;

  var_0.nuke_killplayerwithattacker = 0;
  var_0 setscriptablepartstate("_encstr_BEA50D188B572DF572C9AEB9DD4A3B", "_encstr_A29B05E9400E5D", 0);
}

createcallbacks(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = create_silencer_pick_up(var_0, var_4);

  if(!istrue(var_2.playerdisconnect)) {
    var_1 enableturretdismount();
    var_1 controlturretoff(var_6);

    if(var_4 != "_encstr_A266062032BD7723" && !istrue(var_2.playerdeath)) {
      creategulagjailloadout(var_1);
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_1, var_0, var_0._id_13E92, var_2, 1);
    }
  }

  var_6.owner = undefined;
  var_6 setotherent(undefined);
  var_6 setentityowner(undefined);
  var_6 setsentryowner(undefined);
}

create_heartbeat_sensor_pick_ups() {
  var_0 = self;
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BE92180BC15BD7AE184BD7F347D0B37377F822C3EE25BFA6F8A7");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0._id_145C9 = 0;
  var_0.helicrash = 0;
  var_0.spawn_fake_letter = 0;

  for(;;) {
    if(istrue(var_0._id_145C9)) {
      if(var_0 vehicle_getspeed() < level.finalthreeuav) {
        var_0._id_145C9 = 0;
        var_0 setscriptablepartstate("_encstr_840703F23B", "_encstr_A29B05E9400E5D", 0);
      }
    } else if(var_0 vehicle_getspeed() > level.finalthreeuav) {
      var_0._id_145C9 = 1;
      var_0 setscriptablepartstate("_encstr_840703F23B", "_encstr_8B6007D127B04BD8E6", 0);
    }

    if(istrue(level.failedmission)) {
      if(istrue(var_0.helicrash)) {
        if(var_0 vehicle_getspeed() < level.finalkillcamplaybackbegin) {
          var_0.helicrash = 0;
          var_0 setscriptablepartstate("_encstr_AB700F3F0938439D5922C08309B04E104D", "_encstr_A29B05E9400E5D", 0);
        }
      } else if(var_0 vehicle_getspeed() > level.finalkillcamplaybackbegin) {
        var_0.helicrash = 1;
        var_0 setscriptablepartstate("_encstr_AB700F3F0938439D5922C08309B04E104D", "_encstr_AB700F3F0938439D5922C08309B04E104D", 0);
      }

      if(istrue(var_0.spawn_fake_letter)) {
        if(var_0 vehicle_getspeed() < level.finalsurvivorcount || abs(var_0.angles[2]) < level.failsafe_door_breach_frozen) {
          var_0.spawn_fake_letter = 0;
          var_0._id_138A5 = undefined;
          var_0 setscriptablepartstate("_encstr_82990E9BDE28FB5EE80F95F893E3A8D8", "_encstr_A29B05E9400E5D", 0);
        }
      } else if(var_0 vehicle_getspeed() > level.finalsurvivorcount && abs(var_0.angles[2]) > level.failsafe_door_breach_frozen) {
        var_0.spawn_fake_letter = 1;
        var_0._id_138A5 = gettime();
        var_0 setscriptablepartstate("_encstr_82990E9BDE28FB5EE80F95F893E3A8D8", "_encstr_82990E9BDE28FB5EE80F95F893E3A8D8", 0);
      }
    }

    if(istrue(var_0.spawn_fake_letter)) {
      if(isDefined(var_0._id_138A5) && gettime() - var_0._id_138A5 > 500) {
        var_0 setscriptablepartstate("_encstr_A1E60C8D8D70604C3051C1D7CA28", "_encstr_BD5E0F8BE8E82A8A9BF8C67BC091D3E250", 0);
        var_0._id_1443E = 1;
      }
    } else if(istrue(var_0._id_1443E)) {
      var_0 setscriptablepartstate("_encstr_A1E60C8D8D70604C3051C1D7CA28", "_encstr_A7A408B9CA5D1D4E2C63", 0);
      var_0._id_1443E = undefined;
    }

    wait 0.3;
  }
}

regroup_process_started() {
  var_0 = self;
  var_1 = 0;

  if(var_0.shouldmodeplayfinalmoments)
    var_1 = 2;
  else if(var_0 vehicle_getspeed() > 5)
    var_1 = 1;
  else
    var_1 = 0;

  return var_1;
}

create_race(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    thread create_rig_for_usb_animation(var_0, var_1, var_2, var_3, var_4);
  else if(!istrue(var_4.playerdisconnect) && !istrue(var_4.playerdeath)) {
    if(var_1 == "_encstr_A266062032BD7723" || var_1 == "_encstr_876809B995B01DAFA3DD7B" || var_1 == "_encstr_A7BF0B839873B3D72BABEAF535" || var_1 == "_encstr_B15A0AD36BA8BBD79C58EBE3")
      creategulagjailloadout(var_3);
  }

  if(!istrue(level.client_activate)) {
    var_3 skydive_setbasejumpingstatus(1);
    var_3 skydive_setdeploymentstatus(1);
  }
}

create_rig_for_usb_animation(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3.should_hide_buried_mother_corpse))
    var_3.should_hide_buried_mother_corpse = 1;
  else
    var_3.should_hide_buried_mother_corpse = var_3.should_hide_buried_mother_corpse + 1;

  var_3 _calloutmarkerping_isvehicleoccupiedbyenemy::bot_pickup_origin(var_0, var_1, var_2, var_4);

  if(isDefined(var_3.carriable_set_dropped)) {
    if(isDefined(level.createpropspecatehud))
      var_3 thread[[level.createpropspecatehud]]();
  }

  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_2) && (var_2 == "_encstr_876809B995B01DAFA3DD7B" || var_2 == "_encstr_A7BF0B839873B3D72BABEAF535" || var_2 == "_encstr_B15A0AD36BA8BBD79C58EBE3")) {
    var_5 = "_encstr_8CEE061DAC01B8F7";
    var_6 = 6;
  }

  if(var_1 == "_encstr_A266062032BD7723") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_0.owner = var_3;
    var_3 controlslinkTo(var_0);
    var_3 cs_flags_init(1);
    var_3.current_count_down = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    if(istrue(level.failsafe_door_breach_frozen_player))
      var_3 thread binoculars_istargetinrange();

    var_3 thread playerpowerrestartallcooldowns();
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2, undefined, var_5, var_6);
  } else if(var_1 == "_encstr_876809B995B01DAFA3DD7B" || var_1 == "_encstr_A7BF0B839873B3D72BABEAF535" || var_1 == "_encstr_B15A0AD36BA8BBD79C58EBE3") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var_3, 0);
    var_7 = create_silencer_pick_up(var_0, var_1);
    var_7.owner = var_3;
    var_7 setotherent(var_3);
    var_7 setentityowner(var_3);
    var_7 setsentryowner(var_3);
    var_3 disableturretdismount();
    var_3 controlturreton(var_7);
    create_heartbeat_sensor_pick_up(var_3);
    var_3 setentitysoundcontext("_encstr_9A50080BA7292FFA0DA2", "_encstr_ACF00993F09C1382324FB3", 0.2);
  }

  thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F6(var_4, 1);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);

  if(getdvarint("_encstr_9A7621B9D8C9D795370B89C656BEC21CAFB35ACD4BEDCD37CA47F5DB67AC3927B48C95", 1)) {
    if(isDefined(level._encstr_B2011828C9171F67C897152022632A439313B07A51E047EDB5D7))
      var_3 visionsetnakedforplayer(level._encstr_B2011828C9171F67C897152022632A439313B07A51E047EDB5D7, 0);
    else
      var_3 scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("_encstr_93FA106B1C7DEEE9EB5AB98DB0DCC8EB2C38");
  }

  wait 1;

  if(istrue(level.fiftypercent_music) && isDefined(var_3) && var_1 == "_encstr_A266062032BD7723")
    var_3 playerhide();
}

create_saw_interaction(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1) && var_1 == "_encstr_A266062032BD7723") {
    var_3 thread _id_14230(level.createprematchloadout);
    var_3 createrectangularzonebasedonent();
    var_3 notify("_encstr_B4401A4712506C8238C77F3B23D12AA439DBFFCE0B8902BA81E59F3B");
    var_0 thread createdestinationvfx();
    var_3 notify("_encstr_B8C41A4AE7B76B8930FB55269A289E2758DCEAE32A683B1999625563");
    var_3 cs_flags_init(0);

    if(isDefined(level.createzombieloadout))
      var_3 thread[[level.createzombieloadout]]();

    if(isDefined(var_3.playerpowersaddhudelem)) {
      var_3.playerpowersaddhudelem = undefined;
      var_3.waittillspectating = undefined;
    }

    var_3 setclientomnvar("_encstr_BA1E177B08D9418A2EF1BB87255D11B9E8D379C6E1D801338D", 0);
  }

  if(istrue(var_4.success))
    create_score_message(var_0, var_1, var_2, var_3, var_4);
}

create_score_message(var_0, var_1, var_2, var_3, var_4) {
  var_3 _calloutmarkerping_isvehicleoccupiedbyenemy::bot_protect_hq_zone(var_0, var_1, var_2, var_4);

  if(var_1 == "_encstr_A266062032BD7723") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);
    var_0.owner = undefined;
  } else if(var_1 == "_encstr_876809B995B01DAFA3DD7B" || var_1 == "_encstr_A7BF0B839873B3D72BABEAF535" || var_1 == "_encstr_B15A0AD36BA8BBD79C58EBE3")
    var_3 setentitysoundcontext("_encstr_9A50080BA7292FFA0DA2", "_encstr_B40101", 0.2);

  var_5 = !isDefined(var_2);

  if(var_5 && var_3 hasweapon(var_0._id_13E92) || (var_1 == "_encstr_A30D0B30D3708180E951D37165" || var_1 == "_encstr_930D0BB31F7F41CB11C81BAF42" || var_1 == "_encstr_910D0BD951F7D19EB70A9BE647")) {
    var_6 = create_silencer_pick_up(var_0, var_1);

    if(!istrue(var_4.playerdisconnect)) {
      var_3 enableturretdismount();
      var_3 controlturretoff(var_6);

      if(!istrue(var_4.playerdeath))
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, var_0._id_13E92, var_4, 1);

      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(var_3, var_4.playerdeath);
    }

    var_6.owner = undefined;
    var_6 setotherent(undefined);
    var_6 setentityowner(undefined);
    var_6 setsentryowner(undefined);

    if(!istrue(var_4.playerdisconnect))
      creategulagjailloadout(var_3);
  }

  if(!istrue(var_4.playerdisconnect)) {
    var_3 controlsunlink();

    if(istrue(var_4.playerdeath))
      var_3 scripts\cp_mp\vehicles\vehicle_occupancy::allowleaderboardstatsupdates();

    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var_7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var_3, var_2, var_4);

    if(!var_7) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AB651A9BD10B3961E7F16098EABC3951136A90811ECF60534E6AE840"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AB651A9BD10B3961E7F16098EABC3951136A90811ECF60534E6AE840")]](var_3);
      else
        var_3 suicide();
    }
  }

  if(istrue(level.failsafe_door_breach_frozen_player))
    var_3 binoculars_iswithinprojectiondistance();

  if(isDefined(level._id_142D1))
    var_3 visionsetnakedforplayer(level._id_142D1, 0);
  else
    var_3 scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("_encstr_B40101", 0.0);

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

create_heartbeat_sensor_pick_up(var_0) {
  if(isDefined(var_0.set_thirdperson)) {
    return;
  }
  var_0.set_thirdperson = 1;
  var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_83F40783ADF1D14AA3");

  if(istrue(var_1._id_133D3)) {
    return;
  }
  var_0 scripts\cp_mp\utility\damage_utility::adddamagemodifier("_encstr_9ABD17493B45108C63839D839B88D3E8F3D410012AB5C04D8B", 0.4, 0, ::create_smoke_occluder);
}

creategulagjailloadout(var_0) {
  if(!isDefined(var_0.set_thirdperson)) {
    return;
  }
  var_0.set_thirdperson = undefined;
  var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_83F40783ADF1D14AA3");

  if(istrue(var_1._id_133D3)) {
    return;
  }
  var_0 scripts\cp_mp\utility\damage_utility::removedamagemodifier("_encstr_9ABD17493B45108C63839D839B88D3E8F3D410012AB5C04D8B", 0);
}

create_smoke_occluder(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_4 != "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" && var_4 != "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421")
    return 1;

  if(!isDefined(var_5))
    return 1;

  switch (var_5.basename) {
    case "_encstr_84A00E50B085578F87182E98ED81081B":
    case "_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB":
    case "_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0":
    case "_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0":
    case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
    case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
    case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
    case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
    case "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0":
    case "_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59":
      return 0;
    default:
      return 1;
  }
}

createflagstart(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F6(var_4);
  thread creategulagarenaloadout(var_0, var_1, var_2, var_3, var_4);
}

creategulagarenaloadout(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2) && var_2 == "_encstr_A266062032BD7723") {
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F7(var_5);
  }
}

_id_13DDA() {
  return 1;
}

trophy_protectionsuccessful(var_0) {
  self._id_13DDF--;
  var_1 = var_0.origin;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_993F1C6B20D95C8F7045AF9CE6380BA44381C2B3D08595DFAFBF8A877523", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_993F1C6B20D95C8F7045AF9CE6380BA44381C2B3D08595DFAFBF8A877523", "_encstr_88C5055208731B")]](var_0);

  var_2 = trophy_getbesttag(var_1);
  self setscriptablepartstate("_encstr_9B1910D4B568FFFBA316426AA357E262FCE0", var_2);
  var_3 = vectortoangles(self gettagorigin(var_2) - var_1);
  var_4 = combineangles(var_3, (-90, 0, 0));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8A716E847BC384A61F8BFECEBC898A3A04F78F0B1D27D71", "_encstr_88C5055208731B"))
    self.explosion thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8A716E847BC384A61F8BFECEBC898A3A04F78F0B1D27D71", "_encstr_88C5055208731B")]](var_1, var_4);

  if(self._id_13DDF == 0) {
    self notify("_encstr_829110FBAB98D28AA55BF737B3D653397091", "_encstr_ABF40FA3E09808FA7328154D306B62AD20");
    self waittill("_encstr_8891134727DE831AE57D85B65BEDFAE42B33D263D8");
  } else
    self notify("_encstr_829110FBAB98D28AA55BF737B3D653397091", "_encstr_8EAF11EB3877BA03B238F1E5C9981703B76872");
}

trophy_getbesttag(var_0) {
  var_1 = ["_encstr_A1060DCBA13CEF8B087FD8D84B3982", "_encstr_93060D9119AF8955A3925358DB3F2E", "_encstr_A3060DDB4758481BB8AA276361998E", "_encstr_83060D83B1A0C7D3B65743DB83C81F"];
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_8, var_5 in var_1) {
    var_6 = self gettagorigin(var_5);
    var_7 = distancesquared(var_6, var_0);

    if(var_8 == 0 || var_7 < var_2) {
      var_2 = var_7;
      var_3 = var_5;
    }
  }

  return var_3;
}

create_tut_loot_struct() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_83F40783ADF1D14AA3", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::create_seatids_override;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_83F40783ADF1D14AA3", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 138;
  var_0.clearancecheckminradius = 185;
}

create_seatids_override() {
  var_0 = getDvar("_encstr_A2B41C6E6C937D9827FA897BB6C42B397DDCA3E4BA36E8D79B1D9C4BB93B", "_encstr_83F40783ADF1D14AA3");

  if(isDefined(level._id_1218A) && level._id_1218A.size != 0)
    var_1 = level._id_1218A;
  else
    var_1 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_1.size > 0) {
    var_1 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_1, 1);

    if(var_1.size > 1)
      var_1 = scripts\engine\utility::array_randomize(var_1);
  }

  return var_1;
}

cs_flags_init(var_0) {
  var_1 = self;

  if(!isDefined(var_1) || !isDefined(var_1.vehicle) || isbot(var_1)) {
    return;
  }
  var_2 = var_1.vehicle;

  if(!isDefined(var_2.curr_airlock_pos) || !isDefined(var_2.dropbombs)) {
    return;
  }
  var_3 = cs_add_to_struct_array(var_0, var_2.curr_airlock_pos, var_2.dropbombs);
  var_1 setclientomnvar("_encstr_AD7E0F5796EB8993FACC46D7E63AC2D1B2", var_3);
}

cs_add_to_struct_array(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = 3;
  var_5 = 127;

  for(var_6 = 0; var_6 < var_2.size; var_6++) {}

  var_7 = int(var_0) &var_3;
  var_7 = var_7 + ((int(var_1) &var_4) << 1);

  for(var_6 = 0; var_6 < var_2.size; var_6++)
    var_7 = var_7 + ((int(var_2[var_6] / level.failsmokinggunquest * 127) &var_5) << 3 + 7 * var_6);

  return var_7;
}

cumulative_damage_expire_time() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_B4401A4712506C8238C77F3B23D12AA439DBFFCE0B8902BA81E59F3B");
  var_1 = 40;
  var_2 = -135;
  var_0.cruisepredator_watchgameend = var_0 _id_12530(var_1, var_2, "_encstr_A5AD056A019C63", "_encstr_8F8D07BB035BDAD5CD", "_encstr_A5C407E1658D3339B3", "_encstr_A146078E65FB5158DD", &"_encstr_A98D1F3920F9E908EF43BBB9B918E4A0ADF32954CD31983721A7869DA311440BF1");

  while(!isDefined(var_0.vehicle))
    wait 0.5;

  var_0 thread current_anim_ref();
}

createrectangularzonebasedonent() {
  var_0 = self;

  if(isDefined(var_0.cruisepredator_watchgameend))
    var_0.cruisepredator_watchgameend destroy();

  var_0.cruisepredator_watchgameend = undefined;
}

current_anim_ref() {
  var_0 = self;

  if(!isDefined(var_0)) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_B4401A4712506C8238C77F3B23D12AA439DBFFCE0B8902BA81E59F3B");

  for(;;) {
    if(!isDefined(var_0.vehicle)) {
      return;
    }
    var_1 = 0;

    foreach(var_3 in level.vehicle.instances["_encstr_83F40783ADF1D14AA3"]) {
      if(istrue(var_3.shouldmodeplayfinalmoments))
        var_1++;
    }

    if(isDefined(level.vehicle.instances["_encstr_BDC80A5437EAD749519A6068"])) {
      foreach(var_6 in level.vehicle.instances["_encstr_BDC80A5437EAD749519A6068"]) {
        if(istrue(var_6.shouldmodeplayfinalmoments))
          var_1++;
      }
    }

    var_0.cruisepredator_watchgameend setvalue(var_1);
    wait 3;
  }
}

_id_12530(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = init_reach_pipe_room("_encstr_8B1608EC43B8D647A113", 1.0);
  var_8.x = var_0;
  var_8.y = var_1;
  var_8.alignx = var_2;
  var_8.aligny = var_3;
  var_8.horzalign = var_4;
  var_8.vertalign = var_5;
  var_8.alpha = 1;
  var_8.glowalpha = 0;
  var_8.hidewheninmenu = 1;
  var_8.archived = 0;

  if(isDefined(var_6))
    var_8.label = var_6;

  if(isDefined(var_7))
    var_8 setvalue(var_7);

  return var_8;
}

init_reach_pipe_room(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "_encstr_9779056EEA2583";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2.hidden = 0;
  return var_2;
}

_id_1315F() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_B8C41A4AE7B76B8930FB55269A289E2758DCEAE32A683B1999625563");
  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8"))
    var_1 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8")]]();

  wait 2;

  while(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(var_0)) {
    var_2 = [];
    [var_4, var_5] = rooftop_active();

    foreach(var_7 in level.players) {
      if(var_7.team == var_0.team) {
        continue;
      }
      if(isDefined(level.ctf_bot_attacker_limit_for_team)) {
        if(var_7[[level.ctf_bot_attacker_limit_for_team]]())
          continue;
      }

      if(isDefined(level.cruisepredator_assigntargetmarkers)) {
        if(var_7[[level.cruisepredator_assigntargetmarkers]]("_encstr_A94E14B9E0B2D85A2C638E5EEB76AB59E44EA5361BC2") || var_7[[level.cruisepredator_assigntargetmarkers]]("_encstr_8E0E159E3A72E73079A3A8C8879308359A229530557B8F"))
          continue;
      }

      if(isDefined(var_7.vehicle) && isDefined(var_7.vehicle.targetname) && (var_7.vehicle.targetname == "_encstr_83F40783ADF1D14AA3" || var_7.vehicle.targetname == "_encstr_BDC80A5437EAD749519A6068")) {
        if(var_7.vehicle _calloutmarkerping_isvehicleoccupiedbyenemy::_id_1331B(var_7))
          var_2 = scripts\engine\utility::array_add(var_2, var_7);

        continue;
      }

      if(isDefined(var_7.currentweapon) && isDefined(var_7.currentweapon.basename) && (var_7.currentweapon.basename == "_encstr_97781E650A25C38AAC57A0C87B5BB7F5DF8A108FA21EBB8BF030E72F98F028EA" || var_7.currentweapon.basename == "_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83" || var_7.currentweapon.basename == "_encstr_A6ED1BFB4185B0A7A3F98B53D3236D7011DE715BE3A1D0FD9BB261788A")) {
        var_2 = scripts\engine\utility::array_add(var_2, var_7);
        continue;
      }

      var_8 = _id_13D9C(var_7.origin, var_0.vehicle.origin, var_4, var_5);

      if(istrue(var_8)) {
        var_2 = scripts\engine\utility::array_add(var_2, var_7);
        continue;
      }
    }

    if(isDefined(level.decoygrenades)) {
      foreach(var_11 in level.decoygrenades) {
        if(!isDefined(var_11)) {
          continue;
        }
        if(isDefined(var_11.team) && var_11.team == var_0.team) {
          continue;
        }
        var_8 = _id_13D9C(var_11.origin, var_0.vehicle.origin, var_4, var_5);

        if(istrue(var_8)) {
          var_2 = scripts\engine\utility::array_add(var_2, var_11);
          continue;
        }
      }
    }

    if(istrue(level.farah_says_cut_wire_red)) {
      if(isDefined(level.br_armory_kiosk.scriptables)) {
        foreach(var_14 in level.br_armory_kiosk.scriptables) {
          if(!istrue(var_14.visible)) {
            continue;
          }
          var_15 = distance(var_0.vehicle.origin, var_14.origin);

          if(var_15 < 20000)
            var_2 = scripts\engine\utility::array_add(var_2, var_14);
        }
      }
    }

    if(isDefined(level.br_pickups.crates)) {
      foreach(var_18 in level.br_pickups.crates) {
        if(!isDefined(var_18) || !isDefined(var_18.origin)) {
          continue;
        }
        if(isDefined(var_18.team) && var_18.team == var_0.team) {
          continue;
        }
        var_19 = distance(var_0.vehicle.origin, var_18.origin);

        if(isDefined(var_19) && var_19 < 20000)
          var_2 = scripts\engine\utility::array_add(var_2, var_18);
      }
    }

    if(var_2.size > 0) {
      var_21 = level.teamdata[var_0.team]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"];

      if(istrue(var_1))
        var_21 = level.squaddata[var_0.team][var_0.squadindex].players;

      foreach(var_23 in var_21) {
        if(!isalive(var_23)) {
          continue;
        }
        if(isDefined(level.ctf_bot_attacker_limit_for_team)) {
          if(var_23[[level.ctf_bot_attacker_limit_for_team]]())
            continue;
        }

        var_24 = distance(var_0.vehicle.origin, var_23.origin);

        if(var_24 < 10000) {
          foreach(var_26 in var_2)
          var_23 thread cur_vision(var_26, var_0);
        }
      }

      if(soundexists("_encstr_B2DD107B2AF783ABDFD759865DA15FE8B070"))
        var_0 playsoundtoplayer("_encstr_B2DD107B2AF783ABDFD759865DA15FE8B070", var_0);
    }

    wait 3.25;
  }
}

rooftop_active() {
  var_0 = self;
  var_0 notify("_encstr_A2EF1D8827C4464F520527B6514AAFA83D37A0309F661E0D9A2AA533B602DF");
  var_0 endon("_encstr_A2EF1D8827C4464F520527B6514AAFA83D37A0309F661E0D9A2AA533B602DF");
  var_1 = var_0.vehicle.origin;
  var_2 = anglesToForward(var_0.vehicle.angles);
  var_2 = (var_2[0], var_2[1], 0);
  var_3 = vectorcross(var_2, (0, 0, 1));
  var_4 = var_2 * level.findavailableteam * cos(level.findanyaliveplayer);
  var_5 = level.findavailableteam * sin(level.findanyaliveplayer);
  var_6 = [];
  var_7 = (0, 0, 0);
  var_8 = undefined;
  var_9 = undefined;

  for(var_10 = 0; var_10 < 2; var_10++) {
    var_11 = var_10 / 2 * 360;
    var_12 = var_1 + var_4 + var_5 * (var_3 * cos(var_11));
    var_7 = var_12;

    if(isDefined(var_9)) {
      var_8 = var_12;
      continue;
    }

    var_9 = var_12;
  }

  return [var_8, var_9];
}

_id_13D9C(var_0, var_1, var_2, var_3) {
  var_4 = updatescrapassistdataforcecredit(var_0, var_1, var_2, var_3);

  if(var_4)
    return 1;
  else
    return 0;
}

updatescrapassistdataforcecredit(var_0, var_1, var_2, var_3) {
  if(!use_nvg_think(var_0, var_1, var_2))
    return 0;

  if(!use_nvg_think(var_0, var_2, var_3))
    return 0;

  if(!use_nvg_think(var_0, var_3, var_1))
    return 0;

  return 1;
}

use_nvg_think(var_0, var_1, var_2) {
  return (var_2[0] - var_1[0]) * (var_0[1] - var_1[1]) - (var_0[0] - var_1[0]) * (var_2[1] - var_1[1]) < 0;
}

cur_vision(var_0, var_1) {
  var_2 = self;
  var_3 = undefined;

  if(isDefined(var_0.classname) && var_0.classname == "_encstr_B2DF1A9B3693D20E8EC289D895AF3127FA07B1D5CD91594EEB98BD0F" || isDefined(var_0.cratetype)) {
    var_4 = "_encstr_B4DC1B14B5D9E1717158934F3B0B3F0BB54551CD175D7A8579F19FB353";
    var_3 = var_0.origin;
  } else if(var_0 updateexpiredlootleader() || var_0 _calloutmarkerping_isvehicleoccupiedbyenemy::updatedroprelicsfunc())
    var_4 = "_encstr_8A38145B50715F92CFB88DC997E31B17F868BB2FB829";
  else
    var_4 = "_encstr_8E1F17A1AE8CF596D8BD37D73B9CF65DB98CAFB6C293B59546";

  var_5 = 8;
  var_6 = 1;
  var_7 = 500;
  var_8 = 31500;
  var_9 = var_0 scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_2, var_4, var_5, var_6, var_8, var_7, undefined, 1, 1, var_3);
  var_2 cur_wave_start_time(var_0);
  var_2 scriptedspawnpointarray(var_0, var_1);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_9);
}

scriptedspawnpointarray(var_0, var_1) {
  var_2 = self;

  if(!isDefined(level.cruise_predator_direction_override)) {
    return;
  }
  if(!isDefined(var_2) || !isDefined(var_0) || !isDefined(var_0.lastkilledby) || !isDefined(var_0.lastkilledby.team)) {
    return;
  }
  if(!isent(var_0) || !isPlayer(var_0)) {
    return;
  }
  if(var_0.health != 0) {
    return;
  }
  if(var_2 == var_1 && var_0.lastkilledby.team == var_2.team && var_0.lastkilledby != var_2)
    var_2 thread[[level.cruise_predator_direction_override]]("_encstr_B2A512E24696E36FCF6B727B08F766FF4BA37B8C");
}

cur_wave_start_time(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_B8C41A4AE7B76B8930FB55269A289E2758DCEAE32A683B1999625563");
  var_0 scripts\engine\utility::waittill_notify_or_timeout("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", 3.0);
}

updateexpiredlootleader() {
  var_0 = self;

  if(isDefined(var_0.vehicle) && isDefined(var_0.vehicle.targetname) && var_0.vehicle.targetname == "_encstr_83F40783ADF1D14AA3")
    return 1;

  return 0;
}

unresolvedcollisiontolerancesqr() {
  var_0 = self;

  if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(var_0.targetname) && var_0.targetname == "_encstr_83F40783ADF1D14AA3")
    return 1;

  return 0;
}

unset_bullet_shields() {
  var_0 = self;

  if(isDefined(var_0.model) && var_0.model == "_encstr_91D421989F89BAFF68CF4CB209FDCF032288F3430F7A56491FDBF9D8300DF062497883")
    return 1;

  return 0;
}

set_track_operational_status(var_0, var_1) {
  var_2 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!isDefined(var_0))
    var_0 = level.ffsm_skydive_stateenter;

  if(!isDefined(var_1))
    var_1 = level.ffsm_parachuteopen_stateenter;

  while(isDefined(var_2.vehicle)) {
    var_3 = var_2.origin;
    var_4 = var_2 getplayerangles();
    var_5 = anglesToForward(var_4);
    var_6 = var_3 + var_5 * var_1;
    var_7 = scripts\engine\trace::ray_trace(var_3, var_6);
    var_8 = var_7["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_8) && isDefined(var_8.entity_number) && isDefined(var_8.team) && var_2.team != var_8.team) {
      var_9 = isDefined(var_8.vehiclename);
      var_10 = !isDefined(var_2._id_13A7E) || var_2._id_13A7E != var_8.entity_number;
      var_11 = !isDefined(var_2._id_13A7F) || var_2._id_13A7F != var_9;

      if(var_10) {
        var_2 _id_13FBF("_encstr_84310D05A9BF09011993D0709AAFE9", var_8.entity_number, 0, 11, 1);
        var_2._id_13A7E = var_8.entity_number;
      }

      if(var_11) {
        var_2 _id_13FBF("_encstr_84310D05A9BF09011993D0709AAFE9", var_9, 11, 1, 0);
        var_2._id_13A7F = var_9;
      }
    } else if(isDefined(var_2._id_13A7E) || isDefined(var_2._id_13A7F)) {
      var_2 _id_13FBF("_encstr_84310D05A9BF09011993D0709AAFE9", 2047, 0, 11, 1);
      var_2._id_13A7E = undefined;
      var_2._id_13A7F = undefined;
    }

    wait(var_0);
  }
}

_id_13FBF(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;

  if(!isDefined(var_1)) {
    return;
  }
  var_6 = int(pow(2, var_3)) - 1;
  var_7 = (var_1 &var_6) << var_2;
  var_8 = ~(var_6 << var_2);
  var_9 = self calloutmarkerping_entityzoffset(var_0);

  if(istrue(var_4)) {
    self setclientomnvar(var_0, var_7);
    return;
  } else if(!isDefined(var_9))
    var_9 = var_8;

  var_10 = var_9 &var_8;

  if(!isDefined(var_7)) {
    return;
  }
  var_11 = var_10 + var_7;

  if(var_11 != var_9)
    self setclientomnvar(var_0, var_11);
}

cull_list_of_players(var_0, var_1) {
  var_2 = self;
  var_2 setscriptablepartstate("_encstr_A29A0CCB508E5D1A3D43829ADACA", var_0, 0);
  var_2 setscriptablepartstate("_encstr_816E079685517D0975", var_1, 0);
}