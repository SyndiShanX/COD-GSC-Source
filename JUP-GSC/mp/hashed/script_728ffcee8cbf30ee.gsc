/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_728ffcee8cbf30ee.gsc
*************************************************/

#using script_2d9d24f7c63ac143;
#using script_4948cdf739393d2d;
#using script_4cdabcd91a92977;
#using script_62c595d55b88b26;
#using script_64acb6ce534155b7;
#using script_728ffcee8cbf30ee;
#using script_72d25fb2b703b6d5;
#using script_744cad313ed0a87e;
#using scripts\common\devgui;
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\killstreaks\nuke;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\gas_grenade;
#using scripts\mp\equipment\shock_stick;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_bunker_utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_ending;
#using scripts\mp\gametypes\br_ending_util;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\gametypes\br_supply_drops_common;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\locksandkeys;
#using scripts\mp\music_and_dialog;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\team_assimilation;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\game;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\trigger;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace namespace_2d7f47b19ccdb41d;

function getcontractdata(data) {
  if(level.mapname == "mp_br_mechanics") {
    function_e79057a53754525c();
  }

  if(!getdvarint(@ "scr_br_elite_broken_arrow", 0)) {
    data.enabled = 0;
    return;
  }

  level.arrow = spawnStruct();
  level.arrow.props = spawnStruct();
  level._effect["arrow_nuke_screen"] = loadfx("vfx/iw9_br/gameplay/vfx_champ_nuke_screen_flash");
  level._effect["arrow_plutonium_far"] = loadfx("vfx/iw9_br/gameplay/vfx_champ_plutonium_screen_effect_far");
  level._effect["arrow_plutonium_close"] = loadfx("vfx/iw9_br/gameplay/vfx_champ_plutonium_screen_effect_close");
  function_797f8ee99632dbc2();
  function_2c472b5af1a9287d();
  function_d91c1a6b28ae8ea3();
  function_d44853cebe3e6d36();
  data.funcs["onInit"] = &function_b31f7af7e23417b0;
  data.funcs["onTeamAssigned"] = &function_401f74a7d8648053;
  data.funcs["onEnterGulag"] = &function_53378ebc66be211c;
  data.funcs["onGlobalPlayerEnterGulag"] = &function_4c82d5d35830ea32;
  data.funcs["onPlayerRespawn"] = &function_dcf3929e77fe1de9;
  data.funcs["onGlobalPlayerRespawn"] = &function_e1e06922c2539044;
  data.funcs["onTabletHidden"] = &function_aee1ff3149365fa6;
  level.var_947925f5fc6939a3 = &function_5908e524f32eb629;
  level.var_2c6b8985db118349 = &function_3e22f1edf43325c1;
  scripts\mp\gametypes\br_pickups::function_c3e1679f348a5e40(&function_33577ebb4253a4f9);

  scripts\engine\utility::registersharedfunc("<dev string:x1c>", "<dev string:x2a>", &arrow_debug);
  scripts\engine\utility::registersharedfunc("<dev string:x1c>", "<dev string:x39>", &function_f8669d894e660ea7);
  devgui_init();

  scripts\engine\utility::registersharedfunc("eliteArrow", "arrow_nepShockEffectToggle", &arrow_nepshockeffecttoggle);
  scripts\engine\scriptable::scriptable_addusedcallback(&function_112636a06b12393b);
  scripts\engine\scriptable::scriptable_addusedcallback(&function_a4fc9a04b674a389);
  scripts\mp\team_assimilation::registerteamassimilatecallback(&function_4f13c26fcebe3ff8);

  foreach(element in level.arrow.var_5fb0d01b9af82ac3) {
    if(isDefined(element.elementbundle)) {
      currentelement = getscriptbundle("elitebrokenarrowelement:" + element.elementbundle);

      if(isDefined(currentelement.elementpartname)) {
        scripts\engine\utility::registersharedfunc(currentelement.elementpartname, "delete", &function_28ecfd94dda4d7fd);
      }
    }
  }

  level.arrow.var_3b0509fd5a10a83f = 0;
  level.arrow.var_f87a8928bd2bc12 = [];

  if(level.arrow.dvars.var_4b933a66cb39cb84 || level.arrow.dvars.var_e6fa2d1eb07efc13) {
    thread function_159f0bfb01d9d0b3();
  }

  if(level.arrow.dvars.var_55cd2554bb26ced4 > 0 || level.arrow.dvars.var_e4c6e78d6225be63 > 0) {
    scripts\mp\utility\disconnect_event_aggregator::function_18819785bafad430(&function_6bc944fa9693d807);
    thread function_5900af4c5dba4b8();
  }

  thread function_722929515e5a34b9();
  thread function_3797fc27da5395c1();
}

function function_2c472b5af1a9287d() {
  level.arrow.dvars = spawnStruct();
  level.arrow.dvars.enabled = getdvarint(@ "scr_br_elite_broken_arrow", 0);
  level.arrow.dvars.tabletfiltered = issubstr(getDvar(@ "loot_table_filter", ""), "brloot_elite_arrow_laptop");
  level.arrow.dvars.version = getdvarint(@ "hash_cda1dd0709c4d180", 0);
  level.arrow.dvars.var_60ea877e814ee1a8 = getdvarfloat(@ "hash_e943bd1371a994c1", 50);

  level.arrow.dvars.debug = getdvarint(@ "hash_a5cf65fd90079e7b", 0);
  level.arrow.dvars.var_b303983f30cb3658 = getdvarint(@ "hash_a126c91647677603", 0);
  level.arrow.dvars.var_88faa6a3ed6b5d4c = getdvarint(@ "hash_1cef39174d04857d", 300);
  level.arrow.dvars.var_4ff121892508c0d4 = getdvarint(@ "hash_bcc502d0a16c3445", 100);
  level.arrow.dvars.var_c42b7c38a37d8f06 = getdvarint(@ "hash_987a851b8a5164f6", 0);
  level.arrow.dvars.debugdefuse = getdvarint(@ "hash_6704ce9a3ae75962", 0);

  level.arrow.dvars.numspawn = getdvarint(@ "hash_75ac11dbfa57f324", 1);
  level.arrow.dvars.scriptedflow = getdvarint(@ "hash_30d49880d50137ee", 0);
  level.arrow.dvars.var_336cbba00b3c960c = getdvarint(@ "hash_531a7f3580ea315f", 1);
  level.arrow.dvars.scripttracker = getdvarint(@ "scr_br_elite_broken_arrow_script_tracker", 0);
  level.arrow.dvars.var_85ee4754325bc510 = getdvarint(@ "hash_950c20a5c594b232", level.arrow.dvars.numspawn);
  level.arrow.dvars.maxteamsize = getdvarint(@ "hash_6c12989a0a4ff9a2", 4);
  level.arrow.dvars.var_c2c0c51679aa5a4f = getdvarfloat(@ "hash_31cc8aeba0a944be", 30);
  level.arrow.dvars.var_db411d3df4599406 = getdvarint(@ "hash_dcffaf5c214172dd", 780);
  level.arrow.dvars.var_dac46c8fda182f4a = getdvarint(@ "hash_500b5c733669deb4", 0);
  level.arrow.dvars.var_29258dcc063eec7f = getdvarint(@ "hash_2f036784e7ec2c72", 18);
  level.arrow.dvars.var_8a0e0d62d99bef57 = getdvarint(@ "hash_83550ac54c009fb2", 15000);
  level.arrow.dvars.var_a076a7284aa6e915 = getdvarint(@ "hash_10264a6f662ca430", 7500);
  level.arrow.dvars.containermaxdist = getdvarint(@ "hash_df243df1aaa96e57", 40000);
  level.arrow.dvars.containermindist = getdvarint(@ "hash_b114889265a1179", 0);
  level.arrow.dvars.var_7846374c36699fd8 = getdvarint(@ "hash_d96ad4b9762ba0bb", 210);
  level.arrow.dvars.var_bcde724251ce0168 = getdvarfloat(@ "hash_ddfdcd24993014cf", 1);
  level.arrow.dvars.containergastime = getdvarfloat(@ "hash_dde2af24991176cb", 40);
  level.arrow.dvars.var_bce042bdea07b805 = getdvarint(@ "hash_be31a0b0f96264be", 4000);
  level.arrow.dvars.elementorder = getDvar(@ "hash_287fbe54205f4583", "ber plu tri");
  level.arrow.dvars.elementinteract = getdvarint(@ "scr_br_elite_broken_arrow_element_interact", 1);
  level.arrow.dvars.var_ac12c191d578b1fc = getdvarint(@ "hash_ec0d2f77c149a76f", 1);
  level.arrow.dvars.var_8ef9f58b6a7afe93 = getdvarint(@ "hash_d2b336a16e9b3f70", 1);
  level.arrow.dvars.var_716235bddfb305f0 = getdvarint(@ "hash_98cb40fb319bcd47", 2304);
  level.arrow.dvars.var_572bb4c60df2d1b1 = getdvarfloat(@ "hash_ee13f902f72541ea", 1);
  level.arrow.dvars.elementgastime = getdvarfloat(@ "hash_ee1bff02f72d3aca", 20);
  level.arrow.dvars.var_572d9f41a62cc17c = getdvarint(@ "hash_a061d7692b5d643", 3000);
  level.arrow.dvars.var_cf64cf3435a371df = getdvarint(@ "hash_2aa7e94f2b915238", 0);
  level.arrow.dvars.var_11027e0991067faa = getdvarint(@ "hash_649be3f19f691ba0", 1);
  level.arrow.dvars.var_8e6e735a3607b730 = getdvarint(@ "hash_1e38e38a1534c4a2", 1);
  level.arrow.dvars.beroutline = getdvarint(@ "hash_49d4578bb39f0848", 0);
  level.arrow.dvars.var_879711b450fd9dce = getdvarfloat(@ "hash_cf6f4bc73fe603d4", 9);
  level.arrow.dvars.var_ec24cb21c7f05967 = getdvarfloat(@ "hash_bc4ab0e1e738f53b", 0.25);
  level.arrow.dvars.var_187b15d0d681ed14 = getdvarfloat(@ "hash_d9b5475a1979ab9d", 1.5);
  level.arrow.dvars.var_adc0fad3f842d68f = getdvarint(@ "hash_6b82286284e9d06e", 0);
  level.arrow.dvars.var_393d26e0e968f852 = getdvarint(@ "hash_a6cfc5544d74f7bf", 5);
  level.arrow.dvars.var_4472a2372ddc2cc0 = getdvarfloat(@ "hash_87b5941c5fdca522", 5);
  level.arrow.dvars.var_8f5bfd8cf641d707 = getdvarint(@ "hash_d1dd4f34aada10fe", 7);
  level.arrow.dvars.var_ab026fc2a155136d = getdvarfloat(@ "hash_5f0aa90f84bbd519", 5);
  level.arrow.dvars.var_84aa1b04a3f96808 = getdvarint(@ "hash_e49151992582cfb7", 12);
  level.arrow.dvars.var_851ffe073082048a = getdvarfloat(@ "hash_d60d231ee6dc387a", 1);
  level.arrow.dvars.var_b68fcb1b5d940382 = getdvarfloat(@ "hash_956fdd322faed186", 0.25);
  level.arrow.dvars.var_638730e568dea417 = getdvarint(@ "hash_32813e962c93acb0", 256);
  level.arrow.dvars.var_d46d4318a15ee3fe = getdvarint(@ "hash_7eb225ee98272551", 192);
  level.arrow.dvars.var_588ba2ec2484b034 = getdvarint(@ "hash_8070336039bc4225", 768);
  level.arrow.dvars.var_ad7ad59ebfdae08c = getdvarint(@ "scr_br_elite_broken_arrow_tri_interact", 2);
  level.arrow.dvars.var_8875be3ce5a370d4 = getdvarint(@ "hash_eac47bf2c6567180", 1);
  level.arrow.dvars.var_6de843516fb84235 = getdvarfloat(@ "hash_d9b3475d9a51f76c", 5);
  level.arrow.dvars.var_d583139d37b99ddf = getdvarfloat(@ "hash_a24a178dac7d8a33", 0.5);
  level.arrow.dvars.var_762eb6f1e9724fea = getdvarint(@ "hash_2a2e0be32b76ef8b", 512);
  level.arrow.dvars.var_1d37e435e474b707 = getdvarint(@ "hash_261f96ea4e704b78", 0);
  level.arrow.dvars.var_2e0c9dc38097f039 = getdvarint(@ "hash_85047abb86e552d8", 590);
  level.arrow.dvars.var_481c2689c39ba74 = getdvarint(@ "hash_248fd1e95368aad9", 192);
  level.arrow.dvars.var_1ed92f6d912c9995 = getdvarfloat(@ "hash_57c3e963115a0e1b", 1.5);
  level.arrow.dvars.var_8275fefd6945052a = getdvarfloat(@ "hash_d8ea04134343528b", 3);
  level.arrow.dvars.var_92fb78ca5af82fe4 = getdvarfloat(@ "hash_ecf067efc8974734", 6);
  level.arrow.dvars.var_eb5b985cba8997f9 = getdvarfloat(@ "hash_2378e0430f4a2e9e", 1);
  level.arrow.dvars.var_ce33e905a8335d56 = getdvarfloat(@ "hash_d4d62ec2ace68362", 1);
  level.arrow.dvars.var_1b9ddc66ea9dc058 = getdvarfloat(@ "hash_389a4bb4ee827cb8", 1);
  level.arrow.dvars.var_38eac2a5c514c498 = getdvarfloat(@ "hash_f35e51324fa28be4", 1);
  level.arrow.dvars.var_d0b83c7b63c98011 = getdvarfloat(@ "hash_4912e52003018245", 1);
  level.arrow.dvars.var_f9f69d98d83b83c9 = getdvarfloat(@ "hash_b3291f1137147c4f", 1);
  level.arrow.dvars.var_a4830e9532f7fc59 = getdvarfloat(@ "hash_29ff5562e7d0a380", 1);
  level.arrow.dvars.var_c1bcefe508528799 = getdvarfloat(@ "hash_8e909710891bbdaf", 1);
  level.arrow.dvars.var_57e8127d75fc9da9 = getdvarfloat(@ "hash_67576d2ae1ff56e0", 1);
  level.arrow.dvars.var_aa657343e38c0c5c = getdvarfloat(@ "hash_8058e06ca4d33991", 13);
  level.arrow.dvars.var_7325ce521fc5e3e7 = getdvarfloat(@ "hash_a58e96d700307a82", 8);
  level.arrow.dvars.var_198a615bfd3f059 = getdvarint(@ "hash_e20e4ecc3c826e9d", 2);
  level.arrow.dvars.var_a302e223567a930b = getdvarfloat(@ "hash_7f1b736511ea4264", 12);
  level.arrow.dvars.var_16082451127c4a27 = getdvarint(@ "hash_4db1fd61445ed464", 250);
  level.arrow.dvars.var_aab3c520b5a4d04e = getdvarint(@ "hash_9670ef62e1fa2e2d", 192);
  level.arrow.dvars.var_40159311e3fb11f2 = getdvarfloat(@ "hash_6426f6e330d523e2", 0.25);
  level.arrow.dvars.var_7d816906afe09af9 = getdvarfloat(@ "hash_a8b000ede1f4d6b8", 6);
  level.arrow.dvars.var_ce691c052ceda566 = getdvarfloat(@ "hash_87f645e62d9f9b80", 3);
  level.arrow.dvars.var_76014ca6914ad16a = getdvarfloat(@ "hash_4367a112e7a376c9", 0.1);
  level.arrow.dvars.triggerheightoffset = getdvarfloat(@ "hash_8a828a019e16aad4", 0.33);
  level.arrow.dvars.var_19425dbae48971b9 = getdvarfloat(@ "hash_789c80e8d0a7863d", 0);
  level.arrow.dvars.var_dd38db1002a8fd1a = getdvarfloat(@ "hash_b56cee9856470dfe", 0);
  level.arrow.dvars.circleupdaterate = getdvarfloat(@ "hash_43951110b4e39deb", 3.5);
  level.arrow.dvars.var_9042d5cf11398509 = getdvarfloat(@ "hash_fcb42fbee40a2b06", 0.5);
  level.arrow.dvars.var_8935d39cdf624a21 = getdvarint(@ "hash_a9b91d09c8910b23", 10000);
  level.arrow.dvars.var_bc573ea608f113cd = getdvarint(@ "hash_449561f9f615fba", 4500);
  level.arrow.dvars.var_8f12acd8eb090fb0 = getdvarint(@ "hash_fbeb3408fd066a4f", 2000);
  level.arrow.dvars.var_22cf546ce61f0ee4 = getdvarint(@ "hash_a39387848555ff92", 700);
  level.arrow.dvars.circlerangemin = getdvarint(@ "hash_c160239976c5a59", 500);
  level.arrow.dvars.circlerangemax = getdvarint(@ "hash_bf3143997463a37", 2500);
  level.arrow.dvars.var_f3369a0bf2e24d98 = getdvarint(@ "hash_28853a0ecca5530c", 650);
  level.arrow.dvars.var_e31c618e0043e25c = getdvarint(@ "hash_26e1802cc88b7a47", 100);
  level.arrow.dvars.circleshuffle = getdvarint(@ "hash_73e7f4778ad48646", 0);
  level.arrow.dvars.bombsitetime = getdvarfloat(@ "hash_2026983afb054ba1", 300);
  level.arrow.dvars.bombsitesupplydrop = getdvarint(@ "hash_5609f399d2aed079", 1);
  level.arrow.dvars.var_481b257da804995e = getdvarint(@ "hash_83026ae3da184b2d", 1000);
  level.arrow.dvars.var_97a198e6390e4da9 = getdvarint(@ "hash_e4a0734d3e02bac7", 2000000);
  level.arrow.dvars.var_f07dddd68d0cbcd8 = getdvarint(@ "hash_47538600a09b3ac9", 5);
  level.arrow.dvars.var_4c57a2f7bb2c52b8 = getdvarint(@ "hash_60ba0fd26b4a9011", 2);
  level.arrow.dvars.var_fff72f4d008b3ea6 = getdvarint(@ "hash_fc67ab7bebc87864", 1);
  level.arrow.dvars.var_f167d252e60f3073 = getdvarint(@ "hash_f49436da08765bb8", 0);
  level.arrow.dvars.var_6e608be85a24080b = getdvarint(@ "hash_c6e5dc7debc72eed", 90);
  level.arrow.dvars.var_45b2296f6f91a215 = getdvarint(@ "hash_96aeae237894fba7", 1);
  level.arrow.dvars.var_31c2e1a85fb84fb5 = getdvarint(@ "hash_935a1cb445bbb32f", 400);
  level.arrow.dvars.var_a8dfc18f42b04ea3 = getdvarint(@ "hash_3593a7473763ab21", 1);
  level.arrow.dvars.var_218bc5767126bb7a = getdvarint(@ "hash_c0ef52a5ebba31ec", 40);
  level.arrow.dvars.var_dc6fda0fbc9fe1e9 = getdvarint(@ "hash_e2be0efae70f07a1", 4);
  level.arrow.dvars.var_21aa92004dd32d05 = getdvarint(@ "hash_abae39b8c021549c", 5);
  level.arrow.dvars.userate = getdvarfloat(@ "hash_634f6a9f40d48eaa", 1);
  level.arrow.dvars.usecooldown = getdvarfloat(@ "hash_d5198fa240c8a729", 0.75);
  level.arrow.dvars.var_9c24246adc08edd8 = getdvarint(@ "hash_303acdb7c2756320", 0);
  level.arrow.dvars.usetoggle = getdvarint(@ "hash_8d4a9c3fb764f814", 0);
  level.arrow.dvars.armtime = getdvarfloat(@ "hash_e01340aac4318f42", 10);
  level.arrow.dvars.var_dd475d11757ad803 = getdvarfloat(@ "hash_b287a598411c516e", -1);
  level.arrow.dvars.armradius = getdvarint(@ "hash_71bef7be698cc6c9", 128);
  level.arrow.dvars.armheight = getdvarint(@ "hash_a2ec02dedbdf4744", 128);
  level.arrow.dvars.fusetimer = getdvarfloat(@ "hash_f9aaebb4d0ed8973", 120);
  level.arrow.dvars.fuseradius = getdvarint(@ "hash_7c55fbb1b17fe120", 90);
  level.arrow.dvars.fuseheight = getdvarint(@ "hash_7b806b03745eb1c1", 72);
  level.arrow.dvars.defusetime = getdvarfloat(@ "hash_2ae542c01753b936", 5);
  level.arrow.dvars.var_e5ad956128dc4da1 = getdvarfloat(@ "hash_afb6ff8e5b2c0402", 0.5);
  level.arrow.dvars.var_28b3c6c19c3773de = getdvarint(@ "scr_br_elite_broken_arrow_nuke_kill_players", 1);
  level.arrow.dvars.nukevision = getdvarint(@ "hash_71200e8541315ab2", 1);
  level.arrow.dvars.nukewaittime = getdvarfloat(@ "hash_f75dc4d887b09ec1", 18);
  level.arrow.dvars.var_895d3e780c654e27 = getdvarint(@ "hash_a875817690841b", 100);
  level.arrow.dvars.var_a1c716e522c46b09 = getdvarfloat(@ "hash_984263b915f3105b", 3);
  level.arrow.dvars.var_36b827b9c3105fdb = getdvarfloat(@ "hash_ed76cdfefe71c0e9", 0.5);
  level.arrow.dvars.var_ecd0f4eb1e770d6c = getdvarfloat(@ "hash_a8161a2602c3e52b", 1);
  level.arrow.dvars.var_b01d54f0ea63bfb3 = getdvarint(@ "hash_e7cb141aea4cd049", 500);
  level.arrow.dvars.var_b983f90ab46b22a6 = getdvarint(@ "hash_a6d39b5b39005af5", 100);
  level.arrow.dvars.var_41df90bb27aa4b6f = getdvarint(@ "hash_e083ac3af8de9f02", 2000);
  level.arrow.dvars.var_2ffb7e53b882cc63 = getdvarint(@ "hash_7c7e489c5812729c", 0);
  level.arrow.dvars.var_ac446d2819c17146 = getdvarint(@ "hash_3f63147e77d0ce3", 0);
  level.arrow.dvars.var_9719a1f9940e8a89 = getdvarint(@ "scr_br_elite_broken_jailbreak_enabled", 0);
  level.arrow.dvars.var_fb5c6a73584df0c1 = getdvarint(@ "hash_2262425b040ad7e8", 1);
  level.arrow.dvars.var_32b459c0d029b500 = getdvarfloat(@ "hash_9fc3c1594145303f", 5);
  level.arrow.dvars.skiptoken = getdvarint(@ "hash_eb319c1bcb7e8ed1", 0);
  level.arrow.dvars.var_6e6566e8c4d099fb = getdvarint(@ "hash_aa7afb63d063b5a8", 1);
  level.arrow.dvars.var_c86c4de4e54401e1 = getdvarint(@ "hash_2c2f1cabe40e0136", 1);
  level.arrow.dvars.var_704052379a5c7c57 = getdvarint(@ "hash_48232564009021f9", 1);
  level.arrow.dvars.var_55cd2554bb26ced4 = getdvarfloat(@ "hash_341bdf65df749f4c", 0.6);
  level.arrow.dvars.var_e4c6e78d6225be63 = getdvarfloat(@ "hash_acc933a339494f7b", 0.6);
  level.arrow.dvars.var_4b933a66cb39cb84 = getdvarint(@ "hash_dc747a5af26f03a3", 1);
  level.arrow.dvars.var_e6fa2d1eb07efc13 = getdvarint(@ "hash_fa5e34549d935ec8", 1);
  level.arrow.dvars.var_6f397e9d54ef92bf = getdvarint(@ "hash_8d45d5ac2cb027b0", 0);
  level.arrow.dvars.var_64c3fa68bcd43f4d = getdvarint(@ "hash_820fcaa2fce419db", 4);
  level.arrow.dvars.var_1a9061c53594239b = getdvarint(@ "hash_d2a47b9ac759e4bc", 1);
  level.arrow.dvars.var_b06e2c48e9605108 = getdvarfloat(@ "hash_f85a1d7cf6b954be", 0);
  level.arrow.dvars.var_b0912248e98682c2 = getdvarfloat(@ "hash_f8372f7cf693349c", 0);
  level.arrow.dvars.var_175c4844ebd8ce8b = getdvarint(@ "hash_885bc9be62bb0a6f", 1);

  if(level.arrow.dvars.var_6f397e9d54ef92bf) {
    level.arrow.dvars.var_85ee4754325bc510 = level.arrow.dvars.numspawn * (level.arrow.dvars.var_1a9061c53594239b + 1);
  }

  function_f879772a0f3ec6ef();

  if(istrue(level.arrow.dvars.debug)) {
    function_b6ab17c43e9fe40();
  }
}

function function_f879772a0f3ec6ef() {
  switch (level.arrow.dvars.version) {
    case 1:
      level.arrow.dvars.var_8875be3ce5a370d4 = 0;
      level.arrow.dvars.beroutline = 0;
      level.arrow.dvars.var_29258dcc063eec7f = 15;
      level.arrow.dvars.var_8a0e0d62d99bef57 = 20000;
      level.arrow.dvars.var_a076a7284aa6e915 = 5000;
      level.arrow.dvars.var_7846374c36699fd8 = 120;
      level.arrow.dvars.var_572d9f41a62cc17c = 2500;
      level.arrow.dvars.var_588ba2ec2484b034 = 512;
      level.arrow.dvars.circleupdaterate = 4;
      level.arrow.dvars.var_9042d5cf11398509 = 1;
      level.arrow.dvars.var_f3369a0bf2e24d98 = 500;
      level.arrow.dvars.var_e31c618e0043e25c = 150;
      break;
    case 2:
      level.arrow.dvars.var_8875be3ce5a370d4 = 1;
      level.arrow.dvars.beroutline = 1;
      break;
    default:
      break;
  }
}

function function_b6ab17c43e9fe40() {
  hostplayer = gethostplayer();

  if(isDefined(hostplayer)) {
    hostplayer iprintlnbold("<dev string:x52>");
  }

  level.arrow.dvars.debug = 1;
  level.arrow.dvars.scriptedflow = 0;
  level.arrow.dvars.var_85ee4754325bc510 = 1000;
  level.arrow.dvars.var_a076a7284aa6e915 = 0;
  level.arrow.dvars.var_c42b7c38a37d8f06 = 1;
  level.arrow.dvars.debugdefuse = 1;
  level.arrow.dvars.skiptoken = 1;
  level.arrow.dvars.var_b303983f30cb3658 = 1;
  level.arrow.dvars.var_9719a1f9940e8a89 = 0;
  level.arrow.dvars.bombsitesupplydrop = getdvarint(@ "hash_5609f399d2aed079", 1);
  level.arrow.dvars.var_c6020d9f48812bed = undefined;
}

function function_3c80dae01a8179bf() {
  hostplayer = gethostplayer();

  if(isDefined(hostplayer)) {
    hostplayer iprintlnbold("<dev string:x52>");
  }

  level.arrow.dvars.debug = 0;
  level.arrow.dvars.var_85ee4754325bc510 = level.arrow.dvars.numspawn;
  level.arrow.dvars.var_a076a7284aa6e915 = 7500;
  level.arrow.dvars.var_c42b7c38a37d8f06 = 0;
  level.arrow.dvars.debugdefuse = 0;
  level.arrow.dvars.skiptoken = 0;
  level.arrow.dvars.var_b303983f30cb3658 = 0;
  level.arrow.dvars.var_9719a1f9940e8a89 = 1;
  level.arrow.dvars.bombsitesupplydrop = getdvarint(@ "hash_5609f399d2aed079", 1);
  level.arrow.dvars.var_c6020d9f48812bed = undefined;

  if(istrue(level.br_circle_disabled)) {
    level.arrow.dvars.scriptedflow = 1;
    return;
  }

  level.arrow.dvars.scriptedflow = 4;
}

function function_e79057a53754525c() {
  setdvarifuninitialized(@ "scr_br_elite_broken_arrow", 1);
  setdvarifuninitialized(@ "hash_60ba0fd26b4a9011", 1);

  if(istrue(level.br_circle_disabled)) {
    setdvarifuninitialized(@ "hash_30d49880d50137ee", 1);
  }
}

function function_61ff01586b919509(listoverride) {
  if(!isDefined(level.arrow.elementlist) || level.arrow.elementlist.size < 1) {
    return;
  }

  elementlist = level.arrow.elementlist;

  if(isDefined(listoverride)) {
    elementlist = listoverride;
  }

  function_7d267b05c8f10c00();

  foreach(bundleref in level.var_fb669fe7caba3cf2) {
    itemid = level.var_1a37f44229729be9[bundleref].lootid;
    itemname = bundleref;
    elementid = function_96a1620d901981d1(itemname, 0, listoverride);

    if(isDefined(elementid)) {
      elementlist[elementid].elementitemid = int(itemid);
    }
  }
}

function function_d91c1a6b28ae8ea3() {
  var_5a7fcbe60cdf0a26 = function_9f8b8711fe09e7c3();

  if(!isDefined(var_5a7fcbe60cdf0a26)) {
    return;
  }

  level.arrow.var_5fb0d01b9af82ac3 = var_5a7fcbe60cdf0a26.elementlist;
  level.arrow.elementlist = [];
  level.arrow.elementorder = strtok(level.arrow.dvars.elementorder, " ");

  if(!isDefined(level.arrow.var_5fb0d01b9af82ac3) || level.arrow.var_5fb0d01b9af82ac3.size < 1) {
    return;
  }

  if(level.arrow.elementorder.size < 3) {
    return;
  }

  foreach(element in level.arrow.var_5fb0d01b9af82ac3) {
    if(isDefined(element.elementbundle)) {
      currentelement = getscriptbundle("elitebrokenarrowelement:" + element.elementbundle);
    } else {
      continue;
    }

    if(level.arrow.elementlist.size == level.arrow.elementorder.size) {
      break;
    }

    if(array_contains(level.arrow.elementorder, currentelement.elementid)) {
      level.arrow.elementlist[currentelement.elementid] = currentelement;
      level.arrow.elementlist[currentelement.elementid].trackernumber = default_to(level.arrow.elementlist[currentelement.elementid].trackernumber, 0);
    }
  }

  for(i = 0; i < level.arrow.elementorder.size; i++) {
    if(!isDefined(level.arrow.elementlist[level.arrow.elementorder[i]])) {
      level.arrow.elementlist = [];
      return;
    }

    level.arrow.elementlist[level.arrow.elementorder[i]].elementindex = i;
  }

  function_61ff01586b919509();
}

function function_9f8b8711fe09e7c3() {
  if(!isDefined(level.projectbundle) || !isDefined(level.projectbundle.var_446147a0d9941152)) {
    return;
  }

  return getscriptbundle("elitebrokenarrowelementlist:" + level.projectbundle.var_446147a0d9941152);
}

function function_9000295ffdaa9d30() {
  if(!isDefined(level.arrow.var_5fb0d01b9af82ac3) || level.arrow.var_5fb0d01b9af82ac3.size < 1) {
    return;
  }

  if(!isDefined(level.arrow.elementsall)) {
    level.arrow.elementsall = [];

    foreach(element in level.arrow.var_5fb0d01b9af82ac3) {
      if(isDefined(element.elementbundle)) {
        currentelement = getscriptbundle("<dev string:x8a>" + element.elementbundle);
      } else {
        continue;
      }

      if(isDefined(currentelement.elementpartname)) {
        level.arrow.elementsall[currentelement.elementid] = currentelement;
        level.arrow.elementsall[currentelement.elementid].trackernumber = default_to(level.arrow.elementsall[currentelement.elementid].trackernumber, 0);
        level.arrow.elementsall[currentelement.elementid].elementindex = 0;
      }
    }

    function_61ff01586b919509(level.arrow.elementsall);
  }
}

function function_d44853cebe3e6d36() {
  game["dialog"]["arrow_started"] = "gmds_grav_cqus";
  game["dialog"]["arrow_started_enemy"] = "gmds_grav_cqup";
  game["dialog"]["arrow_collect_element_1"] = "cqpl_grav_cmp1";
  game["dialog"]["arrow_collect_element_2"] = "cqpl_grav_cmp2";
  game["dialog"]["arrow_collect_element_all"] = "cqsh_grav_cmpa";
  game["dialog"]["arrow_bombsite_reveal"] = "cqpl_grav_devc";
  game["dialog"]["arrow_bombsite_arm"] = "cqsh_grav_deva";
  game["dialog"]["arrow_bombsite_arm_enemy"] = "cqpl_grav_deva";
  game["dialog"]["arrow_detonation_warning"] = "cqpl_grav_devw";
  game["dialog"]["arrow_defused"] = "cqpl_grav_dd30";
  game["dialog"]["arrow_defused_under_30"] = "cqpl_grav_ddls";
  game["dialog"]["arrow_detonated"] = "cqsh_grav_devt";
  game["dialog"]["arrow_detonated_enemy"] = "cqpl_grav_devt";
  game["dialog"]["arrow_failed"] = "cqsh_grav_dvdf";
  game["dialog"]["arrow_available"] = "chmp_grav_avil";
  game["dialog"]["arrow_steal"] = "cqsh_grav_tscn";
  game["dialog"]["arrow_start_geiger"] = "cqsh_grav_c3st";
  game["dialog"]["arrow_alert_element_1"] = "cqsh_grav_c1al";
  game["dialog"]["arrow_start_safecrack"] = "cqsh_grav_c1st";
  game["dialog"]["arrow_alert_element_2"] = "cqsh_grav_cmsc";
  game["dialog"]["arrow_bombsite_team"] = "cqsh_grav_armd";
  game["dialog"]["arrow_defused_extract"] = "cqpl_grav_exti";
  game["dialog"]["arrow_disarm_warning"] = "cqsh_grav_disw";

  if(getsubgametype() == "resurgence") {
    game["dialog"]["arrow_started"] = "recq_grav_cqin";
    game["dialog"]["arrow_collect_element_2"] = "recq_grav_q2sa";
    game["dialog"]["arrow_steal"] = "recq_grav_cqst";
    game["dialog"]["arrow_alert_element_intro_1"] = "recq_grav_q1sa";
  }
}

function function_4da2fedd08554c6e(dialog, delay) {
  delay = default_to(delay, 2);
  teaminfo = self;
  level thread scripts\mp\gametypes\br_public::brleaderdialogteam(dialog, teaminfo.targetteam, undefined, delay);
}

function function_bf0175f3bb67a26d(dialog, delay, var_d3806c49e6704209) {
  delay = default_to(delay, 2);
  teaminfo = self;

  foreach(player in level.players) {
    if(isDefined(player) && player.team != teaminfo.targetteam) {
      if(istrue(var_d3806c49e6704209) && function_8ef404291ea37583(player)) {
        continue;
      }

      level thread scripts\mp\gametypes\br_public::brleaderdialogplayer(dialog, player, undefined, undefined, delay);
    }
  }
}

function function_3738be6fcf9fecd1(dialog) {
  scripts\mp\gametypes\br_public::brleaderdialog(dialog);
}

function function_797f8ee99632dbc2() {
  level.arrow.bombsitelocations = [];
  bombsites = getStructArray("elite_arrow_spawn", "targetname");

  if(isDefined(bombsites) && bombsites.size > 0) {
    foreach(bomb in bombsites) {
      level.arrow.bombsitelocations[level.arrow.bombsitelocations.size] = bomb.origin;
    }

    return;
  }

  if(level.mapname == "mp_br_mechanics") {
    level.arrow.bombsitelocations = [(198, -2218, 0)];
    return;
  }

  if(level.mapname == "mp_jup_bigmap_wz2" || level.mapname == "mp_jup_bm_live_wz2" || level.mapname == "mp_jup_bm_wz2_s4") {
    level.arrow.bombsitelocations = [(-29740, 31682, 1386), (-29056, 41358, 1578), (-25118, 34068, 1444), (-16796, 27118, 3092), (-22474, 21412, 1746), (2905, 27854, 998), (9818, 32924, 1200), (8101, 22948, 1000), (-3617, 37045, 1320), (-2398, 24055, 921), (37016, 18728, 3344), (28784, 26320, 1384), (24240, 33040, 1544), (43000, 33544, 2576), (30576, 40320, 1000), (-32391, 9699, 1000), (-33424, 4975, 1000), (-26222, 4597, 1000), (-21156, 10056, 1000), (-25159, 143, 1000), (-13795, 11083, 1000), (-1909, 2832, 1000), (4893, 8907, 1000), (6844, -4852, 1000), (14778, -8979, 1000), (33550, -11763, 2936.5), (33535, 374, 2561), (39244, 6018, 2902), (41905, -4618, 3357), (38453, -88, 2968), (-24847, -23678, 1000), (-15116, -23718, 1000), (-17375, -13248, 1000), (-3179, -18344, 1000), (-20378, -36399, 1000), (4279, -2320, 2424), (6738, -16660, 2258), (3912, -27512, 2152), (9080, -24672, 1768), (13632, -24928, 1704), (28208, -31152, 3916), (35320, -34688, 3016), (26024, -40072, 3112), (38080, -20472, 3056)];
  }
}

function function_b31f7af7e23417b0() {
  task = self;

  if(!isDefined(level.arrow.numspawned)) {
    level.arrow.numspawned = 0;
  }

  level.arrow.numspawned++;
  return true;
}

function function_8f2a91a76e062b32(player) {
  task = self;
  teammembers = getteamdata(player.team, "players");

  if(level.arrow.dvars.maxteamsize >= 0 && teammembers.size > level.arrow.dvars.maxteamsize) {
    return "too_many_teammates";
  }

  return 1;
}

function function_401f74a7d8648053() {
  task = self;
  task.category = level.arrow.contractref;

  if(!task function_e2f4e0d74cfa48a3()) {
    scripts\mp\utility\script::demoforcesre("arrow_onTeamAssigned - Failed arrow_onTeamAssignedCheckNum. level.arrow.numAccepted: " + level.arrow.var_60982e3ae30bbd22 + ", level.arrow.dvars.maxAccepted: " + level.arrow.dvars.var_85ee4754325bc510);
    return;
  }

  if(!istrue(task.skiptoken) && !task function_b108b493ffdb2de2()) {
    scripts\mp\utility\script::demoforcesre("arrow_onTeamAssigned - Failed arrow_onTeamAssignedCheckToken.");
    return;
  }

  level.arrow.var_60982e3ae30bbd22++;

  if(level.arrow.var_60982e3ae30bbd22 >= level.arrow.dvars.var_85ee4754325bc510) {
    function_259dd894cba599e8();
  }

  task.targetteam = task.var_d154ac2657c5f44.team;

  if(istrue(task.skiptoken) && isDefined(task.dropteam)) {
    function_ff94744f234460c9(task.dropteam, task.targetteam);
  }

  task function_3912f25d2ead337e();
  task function_56f6b28d2f262cce();
  task function_b13f8da1c1a71b93();

  if(!isDefined(level.arrow.props.bombsite)) {
    level.arrow.props.bombsite = function_6c310980df01ac73();
  }

  task function_cce93d9edef517a();
  teaminfo = level.arrow.teaminfo[task.targetteam];

  if(!isDefined(level.arrow.elementlist) || level.arrow.elementlist.size < 1) {
    function_9c74ccdaa1e15c02("container_spawn_failed");
    return;
  }

  function_16d299fc7942ba3d(task.targetteam);
  teaminfo function_105103a837add0e(task);
  teaminfo function_31b2cae426f07a05(task);
  teaminfo arrow_flow();
  teaminfo function_77c7df8755c85a82();
  function_5e7fdf58f111f041();
}

function function_56f6b28d2f262cce() {
  task = self;

  foreach(player in getteamdata(task.var_d154ac2657c5f44.team, "players")) {
    if(issharedfuncdefined("teamAssim", "isEnabled") && [[getsharedfunc("teamAssim", "isEnabled")]]() && issharedfuncdefined("teamAssim", "disablePlayer")) {
      [[getsharedfunc("teamAssim", "disablePlayer")]](player, "br_elite_contract");
    }
  }
}

function function_b13f8da1c1a71b93() {
  task = self;

  foreach(player in getteamdata(task.var_d154ac2657c5f44.team, "players")) {
    player scripts\mp\utility\stats::incpersstat("eliteStarted", 1);
  }
}

function function_e2f4e0d74cfa48a3() {
  task = self;

  if(!isDefined(level.arrow.var_60982e3ae30bbd22) || istrue(level.arrow.dvars.debug)) {
    level.arrow.var_60982e3ae30bbd22 = 0;
  }

  if(level.arrow.var_60982e3ae30bbd22 >= level.arrow.dvars.var_85ee4754325bc510) {
    task endcontract();
    return false;
  }

  return true;
}

function function_b108b493ffdb2de2() {
  task = self;

  if(function_aee3a8be63db5997(task.var_d154ac2657c5f44)) {
    if(level.arrow.dvars.skiptoken) {
      return true;
    }

    task.var_d154ac2657c5f44 scripts\cp_mp\challenges::function_8935e658d461fc50();
    return true;
  }

  task endcontract();
  return false;
}

function function_105103a837add0e(task) {
  teaminfo = self;

  if(istrue(level.arrow.dvars.var_b303983f30cb3658)) {
    return;
  }

  teamsplash = "elite_arrow_started";
  var_f6748b9d559f590a = "elite_arrow_started_global";

  if(level.arrow.dvars.var_6f397e9d54ef92bf && istrue(task.skiptoken)) {
    teaminfo function_4da2fedd08554c6e("arrow_steal");
    teamsplash = "elite_arrow_stolen";
    var_f6748b9d559f590a = "elite_arrow_stolen_global";
  } else {
    teaminfo function_4da2fedd08554c6e("arrow_started");
  }

  teaminfo function_bf0175f3bb67a26d("arrow_started_enemy");
  showsplashtoteam(teaminfo.targetteam, function_130af1b9f6740479(teamsplash));
  showsplashtoallexceptteam(teaminfo.targetteam, function_130af1b9f6740479(var_f6748b9d559f590a), undefined, teaminfo.champion);
}

function function_31b2cae426f07a05(task) {
  teaminfo = self;

  if(istrue(level.arrow.dvars.debug) && isDefined(level.arrow.debugstate) && level.arrow.debugstate == 8) {
    return;
  }

  if(istrue(level.arrow.dvars.scripttracker)) {
    teaminfo function_86ea1b770ae5cb74();
  } else {
    task function_3fd409053922036c();
  }

  teaminfo function_57d7831b6681e062();
  teaminfo function_56ee84f1b091647a();
}

function function_57d7831b6681e062() {
  teaminfo = self;
  revealindex = function_f584d115cb4c5860();
  revealtime = 1200;

  if(level.arrow.dvars.var_db411d3df4599406 > 0) {
    revealtime = min(level.arrow.dvars.var_db411d3df4599406, 1200);
  } else if(scripts\mp\gametypes\br_gametypes::isfeatureenabled("circle")) {
    revealtime = scripts\mp\gametypes\br_circle::gettimetillcircleclosing(revealindex);
  }

  revealtime += level.arrow.dvars.bombsitetime;
  revealtime += 120;

  if(isDefined(self.task.payload) && isDefined(self.task.payload.time)) {
    revealtime = self.task.payload.time;
  }

  teammates = getteamdata(teaminfo.targetteam, "players");

  foreach(player in teammates) {
    player function_2e7f459351d2a81e(int(revealtime), 3);
  }

  if(level.arrow.dvars.scriptedflow == -1) {
    teaminfo thread function_64d9de7b384b3230(revealtime);
  }
}

function function_3e22f1edf43325c1(playerswitching, newteam) {
  var_6448bd11f15b7dd = function_2eac770cf8006e0b(newteam);
  var_24360c0e09f7de0c = function_8ef404291ea37583(playerswitching);

  if(var_6448bd11f15b7dd && level.arrow.dvars.var_2ffb7e53b882cc63 == 0) {
    return false;
  }

  if(var_24360c0e09f7de0c && level.arrow.dvars.var_ac446d2819c17146 == 0) {
    return false;
  }

  return true;
}

function function_4f13c26fcebe3ff8(player, oldteam, newteam) {
  if(!isDefined(level.arrow.teaminfo)) {
    return;
  }

  if(isDefined(level.arrow.teaminfo[oldteam])) {
    function_4595d1f5f78b6b7(player, oldteam, newteam);
  }

  if(isDefined(level.arrow.teaminfo[newteam])) {
    function_af63d46f908fdd08(player, oldteam, newteam);
  }
}

function function_af63d46f908fdd08(player, oldteam, newteam) {
  assertex(isDefined(level.arrow.teaminfo[newteam]), "<dev string:xa6>" + newteam);
  teaminfo = level.arrow.teaminfo[newteam];
  player function_e16c60b795d0b382(1);
  teaminfo function_56ee84f1b091647a();
  teaminfo function_77c7df8755c85a82();
  player function_db724919d6173e87(newteam);
  function_f045c586f2d204ce(player, 1, newteam);
  bombsite = level.arrow.props.bombsite;

  if(teaminfo.state >= 2 && teaminfo.state <= 4) {
    bombsite enablescriptableplayeruse(player);
  } else {
    bombsite disablescriptableplayeruse(player);
  }

  if(isDefined(bombsite.arment)) {
    bombsite.arment function_f025be1cbf898d23(player, 1);
  }

  if(isDefined(bombsite.fuseent)) {
    bombsite.fuseent function_f025be1cbf898d23(player, 0);
  }
}

function function_4595d1f5f78b6b7(player, oldteam, newteam) {
  assertex(isDefined(level.arrow.teaminfo[oldteam]), "<dev string:xcd>" + oldteam);
  teaminfo = level.arrow.teaminfo[oldteam];
  bombsite = level.arrow.props.bombsite;

  if(isDefined(bombsite.elementicons)) {
    foreach(icon in bombsite.elementicons) {
      if(!isDefined(icon)) {
        continue;
      }

      icon function_f5549984b1909638(player, 0);
    }
  }

  if(teaminfo.state == 5) {
    bombsite enablescriptableplayeruse(player);
  } else {
    bombsite disablescriptableplayeruse(player);
  }

  if(isDefined(bombsite.arment)) {
    bombsite.arment function_f025be1cbf898d23(player, 0);
  }

  if(isDefined(bombsite.fuseent)) {
    bombsite.fuseent function_f025be1cbf898d23(player, 1);
  }

  player setclientomnvar("ui_br_elite_arrow_mission_data", 0);
  player setclientomnvar("ui_br_elite_arrow_mission_players", 0);
  teaminfo function_56ee84f1b091647a();
  player function_e16c60b795d0b382(0);
  player function_3cee7764bd6c4cff(oldteam);
  function_f045c586f2d204ce(player, 0, oldteam);

  if(isDefined(bombsite.targetplayer) && player == bombsite.targetplayer) {
    bombsite function_3a3999f7f98a09ba();
  }

  if(player == teaminfo.owner) {
    player notify("arrow_player_removed");
  }
}

function function_53378ebc66be211c(player) {
  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  function_ef1a83cf2ba58e1a(player, 0);
}

function function_4c82d5d35830ea32(player) {
  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  if(function_2eac770cf8006e0b(player.team)) {
    return;
  }

  function_ef1c1b3c3cf49ab0(player, 0);
}

function function_dcf3929e77fe1de9(player) {
  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  if(self.category == "elite_arrow" || self.category == "elite_arrow_resurgence") {
    function_ef1a83cf2ba58e1a(player, 1);
    function_19723e62d956d201(player);
  }

  teaminfo = level.arrow.teaminfo[player.team];

  if(!isDefined(teaminfo.owner)) {
    teaminfo function_cc850454568f09f9(player);
  }
}

function function_e1e06922c2539044(player) {
  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  if(function_2eac770cf8006e0b(player.team)) {
    return;
  }

  function_ef1c1b3c3cf49ab0(player, 1);
  function_19723e62d956d201(player);
}

function function_33577ebb4253a4f9() {
  if(isDefined(self.task) && isDefined(self.type) && scripts\mp\gametypes\br_pickups::function_c7279e910cefd2a4(self.type)) {
    self.task function_3912f25d2ead337e();
  }
}

function function_aee1ff3149365fa6(tablet) {
  if(!isDefined(level.arrow)) {
    return;
  }

  if(isDefined(tablet) && isDefined(tablet.task)) {
    tablet.task function_3912f25d2ead337e();
  }
}

function arrow_onplayerdisconnect(player) {
  if(!isDefined(level.arrow)) {
    return;
  }

  [itemindex, slotlootid] = function_c1a30db229b1311d(player, 0);

  while(isDefined(itemindex)) {
    player scripts\mp\gametypes\br_pickups::quickdropall(10, itemindex);
    [itemindex, slotlootid] = function_c1a30db229b1311d(player, itemindex + 1);
  }

  function_9f9627d4d5224286(player, 0);

  if(isDefined(level.arrow.props) && isDefined(level.arrow.props.bombsite)) {
    bombsite = level.arrow.props.bombsite;

    if(isDefined(bombsite.targetplayer) && player == bombsite.targetplayer) {
      bombsite function_3a3999f7f98a09ba();
    }
  }
}

function function_6bc944fa9693d807(player) {
  function_9f9627d4d5224286(player, 1);
}

function function_1395da3464cb20ae(player) {
  if(arraycontains(level.arrow.var_f87a8928bd2bc12, player)) {
    level.arrow.var_f87a8928bd2bc12 = arrayremove(level.arrow.var_f87a8928bd2bc12, player);
    level.arrow.var_3b0509fd5a10a83f -= 1;
  }
}

function function_5900af4c5dba4b8() {
  level endon("game_ended");
  level waittill("prematch_done");
  namespace_bf9ffd2b22c7d819::function_8fe6d6539ed31a88(&function_1395da3464cb20ae);
}

function function_9f9627d4d5224286(player, var_d0971661d849b844) {
  if(!scripts\mp\flags::gameflag("prematch_done") || !isDefined(level.totalplayers)) {
    return;
  }

  var_83b4450289b72a9c = 0;

  if(isalive(player)) {
    if(istrue(var_d0971661d849b844)) {
      level.arrow.var_3b0509fd5a10a83f += 1;
      level.arrow.var_f87a8928bd2bc12[level.arrow.var_f87a8928bd2bc12.size] = player;
    } else if(arraycontains(level.arrow.var_f87a8928bd2bc12, player)) {
      level.arrow.var_f87a8928bd2bc12 = arrayremove(level.arrow.var_f87a8928bd2bc12, player);
    } else {
      level.arrow.var_3b0509fd5a10a83f += 1;
    }

    var_83b4450289b72a9c = level.arrow.var_3b0509fd5a10a83f / level.totalplayers;
  } else {
    return;
  }

  if(level.arrow.dvars.var_55cd2554bb26ced4 > 0 && var_83b4450289b72a9c >= level.arrow.dvars.var_55cd2554bb26ced4) {
    if(isDefined(level.arrow.var_60982e3ae30bbd22) && level.arrow.var_60982e3ae30bbd22 < level.arrow.dvars.var_85ee4754325bc510) {
      function_865a99292842cef9();
      scripts\mp\gametypes\br_analytics::function_77814c1b523fd8a3(level.totalplayers, "inactive_disconnect_threshold_reached", level.arrow.var_3b0509fd5a10a83f);
    }
  }

  if(function_66c05a319972d8dc()) {
    if(level.arrow.dvars.var_e4c6e78d6225be63 > 0 && var_83b4450289b72a9c >= level.arrow.dvars.var_e4c6e78d6225be63) {
      foreach(teaminfo in level.arrow.teaminfo) {
        if(teaminfo.state == 6) {
          return;
        }
      }

      foreach(teaminfo in level.arrow.teaminfo) {
        if(teaminfo.state != 0) {
          task = level.contractmanager.var_b6fae9c9655c73bf[teaminfo.targetteam];
          scripts\mp\gametypes\br_analytics::function_77814c1b523fd8a3(level.totalplayers, "active_disconnect_threshold_reached", level.arrow.var_3b0509fd5a10a83f);
          function_8e9623944db8dd6e(teaminfo);
        }
      }
    }
  }
}

function function_159f0bfb01d9d0b3() {
  level waittill("prematch_done");
  level waittill("ddos_alert");

  if(level.arrow.dvars.var_4b933a66cb39cb84) {
    if(isDefined(level.arrow.var_60982e3ae30bbd22) && level.arrow.var_60982e3ae30bbd22 < level.arrow.dvars.var_85ee4754325bc510) {
      function_865a99292842cef9();
      scripts\mp\gametypes\br_analytics::function_77814c1b523fd8a3(level.totalplayers, "ddos_alert_received_inactive", level.arrow.var_3b0509fd5a10a83f);
    }
  }

  if(level.arrow.dvars.var_e6fa2d1eb07efc13) {
    if(function_66c05a319972d8dc()) {
      foreach(teaminfo in level.arrow.teaminfo) {
        if(teaminfo.state == 6) {
          return;
        }
      }

      foreach(teaminfo in level.arrow.teaminfo) {
        if(teaminfo.state != 0) {
          task = level.contractmanager.var_b6fae9c9655c73bf[teaminfo.targetteam];
          scripts\mp\gametypes\br_analytics::function_77814c1b523fd8a3(level.totalplayers, "ddos_alert_received_active", level.arrow.var_3b0509fd5a10a83f);
          function_8e9623944db8dd6e(teaminfo);
        }
      }
    }
  }
}

function function_865a99292842cef9() {
  if(isDefined(level.arrow.props.tablets) && level.arrow.props.tablets.size > 0) {
    function_259dd894cba599e8();
    level.arrow.var_60982e3ae30bbd22 = level.arrow.dvars.var_85ee4754325bc510;
  }
}

function function_8e9623944db8dd6e(teaminfo) {
  task = level.contractmanager.var_b6fae9c9655c73bf[teaminfo.targetteam];
  task.var_d154ac2657c5f44 scripts\cp_mp\challenges::function_711143d9696bcf8e();
  teaminfo function_88a043b99a75e47("active_disconnect_threshold_reached", 0);
}

function function_64d9de7b384b3230(time) {
  teaminfo = self;
  level endon("game_ended");
  level endon("arrow_bombsite_drop_landed");
  wait time;

  if(teaminfo.state == 1) {
    if(!teaminfo function_1a9ee6a7092d4536()) {
      teaminfo arrow_ontimeout();
    }
  }
}

function arrow_ontimeout() {
  teaminfo = self;
  teaminfo function_88a043b99a75e47("task_timeout", 0);
}

function function_9c74ccdaa1e15c02(endreason, var_8162abd764747b50) {
  if(!isDefined(level.arrow) || !isDefined(level.arrow.teaminfo)) {
    return;
  }

  foreach(teaminfo in level.arrow.teaminfo) {
    if(!isDefined(teaminfo)) {
      continue;
    }

    teaminfo thread function_88a043b99a75e47(endreason, 0, var_8162abd764747b50);
  }
}

function function_88a043b99a75e47(endreason, success, var_8162abd764747b50) {
  teaminfo = self;

  if(!isDefined(teaminfo) || teaminfo.state == 0 || teaminfo.state == 6) {
    return;
  }

  teaminfo notify("on_end");
  teaminfo endon("on_end");
  scripts\mp\gametypes\br_analytics::function_1d6052577cd7738c(teaminfo, endreason, success);

  if(istrue(success)) {
    level.skipplaybodycountsound = 1;
    level.var_fdb13ccd60afe05c = 1;
    level notify("nuke_detonated");

    foreach(player in getteamdata(teaminfo.targetteam, "players")) {
      player scripts\mp\utility\stats::incpersstat("eliteCompleted", 1);
      player function_fa5724663ba71381();
    }
  } else {
    level notify("nuke_aborted");
    function_c79f9300ee85f805(level.players, "br_elite_contract_ending", 0);
    teaminfo function_f55a837030547355();
  }

  teaminfo function_984f516e55828c50(endreason, success);
  teaminfo function_b141b13225e7b0fe(success);

  if(function_77fb65ae3082871c() == 0 && level.arrow.dvars.var_6f397e9d54ef92bf == 0) {
    function_4905559a168f4dd4();
  }

  teaminfo function_20238d522c76fb01();
  function_5e7fdf58f111f041();
  wait 0.05;
  var_da60ac7aae847d8 = undefined;

  if(!istrue(success)) {
    var_da60ac7aae847d8 = var_8162abd764747b50;
  }

  teaminfo.task endcontract(ter_op(istrue(success), teaminfo.targetteam, undefined), undefined, var_da60ac7aae847d8);

  if(istrue(success)) {
    teaminfo function_350746711c99eb8d();
    return;
  }

  teaminfo function_c71b665383229bc9();
}

function function_4905559a168f4dd4() {
  bombsite = level.arrow.props.bombsite;

  if(!isDefined(bombsite)) {
    return;
  }

  bombsite notify("on_end_bombsite");
  bombsite.enabled = 0;
  bombsite thread function_b51e8c52609285f0();
  waitframe();
  bombsite notify("death");
}

function function_f55a837030547355() {
  teaminfo = self;
  task = level.contractmanager.var_b6fae9c9655c73bf[teaminfo.targetteam];

  if(isDefined(task) && isDefined(task.type.funcs["onEliteTearDown"])) {
    task notify("task_ended");
    task[[task.type.funcs["onEliteTearDown"]]](teaminfo.targetteam);
  }
}

function function_69ae8ab0c2db4623(delaytime) {
  level endon("game_ended");
  level endon("nuke_aborted");

  if(istrue(level.arrow.dvars.var_b303983f30cb3658)) {
    return;
  }

  delaytime = default_to(delaytime, 0.4);
  wait delaytime;
  showsplashtoall(function_130af1b9f6740479("elite_arrow_victory"));
}

function function_984f516e55828c50(endreason, success) {
  teaminfo = self;

  if(istrue(level.arrow.dvars.var_b303983f30cb3658)) {
    return;
  }

  if(istrue(success)) {
    return;
  }

  if(teaminfo.state >= 5 || endreason == "bomb_defused") {
    level.arrow.defused = 1;

    if(endreason == "active_disconnect_threshold_reached") {
      showsplashtoteam(teaminfo.targetteam, function_130af1b9f6740479("elite_arrow_canceled_center"));
      return;
    }

    defuser = level.arrow.props.bombsite.lastuser;

    if(!isDefined(defuser)) {
      return;
    }

    showsplashtoall(function_130af1b9f6740479("elite_arrow_defused"), undefined, defuser);

    if(isDefined(defuser)) {
      defuserid = defuser getentitynumber();

      if(isDefined(defuserid)) {
        setomnvarforallclients("ui_br_elite_savior_id", defuserid);
      }
    }

    return;
  }

  champion = default_to(teaminfo.champion, teaminfo.owner);

  if(!isDefined(champion)) {
    return;
  }

  if(endreason == "active_disconnect_threshold_reached") {
    showsplashtoteam(teaminfo.targetteam, function_130af1b9f6740479("elite_arrow_canceled_center"));
  } else {
    showsplashtoteam(teaminfo.targetteam, function_130af1b9f6740479("elite_arrow_failed_center"));
  }

  showsplashtoallexceptteam(teaminfo.targetteam, function_130af1b9f6740479("elite_arrow_failed_global"), undefined, champion);
}

function function_350746711c99eb8d() {
  teaminfo = self;

  if(istrue(level.arrow.dvars.var_28b3c6c19c3773de)) {
    scripts\mp\gametypes\br_gulag::pausegulag(1);
    bombsite = level.arrow.props.bombsite;

    if(!isDefined(bombsite)) {
      return;
    }

    bombsite function_b308a39503f00abf();
  }
}

function function_c71b665383229bc9() {
  teaminfo = self;
  teaminfo function_4da2fedd08554c6e("arrow_failed", 4);
}

function function_77c7df8755c85a82() {
  teaminfo = self;
  function_a0a60c2df22298d9(teaminfo.targetteam, 1);
  bombsite = level.arrow.props.bombsite;
  bombsite function_e5c04edc3287e3f(1, teaminfo.targetteam);
}

function function_66c05a319972d8dc() {
  if(!isDefined(level.arrow) || !isDefined(level.arrow.teaminfo)) {
    return false;
  }

  foreach(teaminfo in level.arrow.teaminfo) {
    if(!isDefined(teaminfo)) {
      continue;
    }

    if(teaminfo.state != 0) {
      return true;
    }
  }

  return false;
}

function function_2eac770cf8006e0b(team) {
  if(!isDefined(level.arrow) || !isDefined(level.arrow.teaminfo)) {
    return false;
  }

  return isDefined(level.arrow.teaminfo[team]) && level.arrow.teaminfo[team].state > 0;
}

function function_8ef404291ea37583(player) {
  if(!isDefined(level.arrow) || !isDefined(level.arrow.teaminfo)) {
    return false;
  }

  return isDefined(level.arrow.teaminfo[player.team]) && level.arrow.teaminfo[player.team].state > 0;
}

function function_10949665efa60b20() {
  groundloot = self;
  scriptable = groundloot.instance;

  if(isDefined(groundloot.scriptablename) && !groundloot function_5facfbee97e1a98e()) {
    return undefined;
  }

  if(!scriptable function_5facfbee97e1a98e()) {
    return undefined;
  }

  elementid = function_96a1620d901981d1(scriptable.type, 7);
  return function_6844602f3120e900(elementid, 0);
}

function function_5facfbee97e1a98e() {
  scriptable = self;

  if(!isDefined(scriptable)) {
    return false;
  }

  elementid = undefined;
  name = scriptable.type;

  if(isDefined(scriptable.scriptablename)) {
    name = scriptable.scriptablename;
  }

  if(isDefined(name)) {
    elementid = function_96a1620d901981d1(name, 7);
  }

  return isDefined(elementid) && isDefined(function_6844602f3120e900(elementid, 7));
}

function function_668fa8d4516f7e15() {
  scriptable = self;

  if(isDefined(scriptable.elementid) && isDefined(function_6844602f3120e900(scriptable.elementid, 5))) {
    return true;
  }

  elementid = undefined;
  name = scriptable.type;

  if(isDefined(scriptable.scriptablename)) {
    name = scriptable.scriptablename;
  }

  if(isDefined(name)) {
    elementid = function_96a1620d901981d1(name, 0);
  }

  return isDefined(elementid) && isDefined(function_6844602f3120e900(elementid, 0));
}

function function_3b0bc758816ba092() {
  if(!isDefined(level.arrow) || !isDefined(level.arrow.props) || !isDefined(level.arrow.props.bombsite)) {
    return false;
  }

  return istrue(level.arrow.props.bombsite.siterevealed);
}

function function_ce3e8c8b6de2ca1b() {
  if(!isDefined(level.arrow) || !isDefined(level.arrow.props) || !isDefined(level.arrow.props.bombsite)) {
    return false;
  }

  return istrue(level.arrow.props.bombsite.var_27db4eb198cd48b9) && !istrue(level.arrow.props.bombsite.disarmed);
}

function function_5908e524f32eb629() {
  if(!isDefined(level.arrow) || !isDefined(level.arrow.props) || !isDefined(level.arrow.props.bombsite)) {
    return true;
  }

  isarmed = function_ce3e8c8b6de2ca1b();

  if(isarmed) {
    enemycount = getenemycount(level.arrow.props.bombsite.targetteam, 1);

    if(enemycount == 0) {
      level.arrow.props.bombsite function_758f95fb5cf87d1b();
    }
  }

  return !isarmed;
}

function function_dd1eddcb3a80416d(player) {
  cooldown = level.arrow.dvars.usecooldown * 1000;

  if(isDefined(player.arrowusetime) && gettime() < player.arrowusetime + cooldown) {
    return false;
  }

  return true;
}

function function_10451fcedd4d3d6e() {
  if(!isDefined(level.arrow) || !isDefined(level.arrow.props.bombsite)) {
    return false;
  }

  bombsite = level.arrow.props.bombsite;

  foreach(element in level.arrow.elementlist) {
    if(bombsite.neededelements[element.elementid] < 1) {
      return false;
    }
  }

  return true;
}

function function_bc04f4b45cd80cf8(elementid) {
  if(!isDefined(level.arrow) || !isDefined(level.arrow.props.bombsite)) {
    return 0;
  }

  if(!isDefined(level.arrow.props.bombsite.neededelements[elementid])) {
    return 0;
  }

  if(istrue(level.arrow.dvars.var_f167d252e60f3073)) {
    return (level.arrow.props.bombsite.neededelements[elementid] == 0);
  }

  return 1;
}

function function_c1a30db229b1311d(player, itemindex) {
  for(i = itemindex; i < getplayerbackpacksize(player); i++) {
    slotlootid = player getlootidatbackpackindex(i);

    foreach(element in level.arrow.elementlist) {
      if(element.elementitemid == slotlootid) {
        return [i, slotlootid];
      }
    }
  }

  return [undefined, undefined];
}

function function_3a3d1bccf139dd5b(player, elementid, itemindex) {
  if(!isDefined(level.arrow) || !isDefined(level.arrow.props.elements)) {
    return undefined;
  }

  foreach(teamselements in level.arrow.props.elements) {
    if(!isDefined(teamselements[elementid])) {
      continue;
    }

    if(!isDefined(itemindex) || !isDefined(teamselements[elementid].itemindex) || teamselements[elementid].itemindex != itemindex) {
      continue;
    }

    if(!isDefined(player) || !isDefined(teamselements[elementid].player) || teamselements[elementid].player != player) {
      continue;
    }

    return teamselements[elementid];
  }

  return undefined;
}

function function_2c126de0bdb9bfd5(elementindex) {
  if(!isDefined(elementindex)) {
    return 0;
  }

  return 1 << elementindex;
}

function function_96a1620d901981d1(attribute, parameter, listoverride) {
  if(getdvarint(@ "scr_br_elite_broken_arrow", 0) == 0) {
    return;
  }

  if(!isDefined(parameter) || !isDefined(attribute) || !isDefined(level.arrow) || !isDefined(level.arrow.elementlist) || level.arrow.elementlist.size < 1) {
    return;
  }

  parameterselected = 0;
  var_eb99ae539fab2970 = level.arrow.elementlist;

  if(isDefined(listoverride)) {
    var_eb99ae539fab2970 = listoverride;
  }

  foreach(element in var_eb99ae539fab2970) {
    switch (parameter) {
      case 0:
        searchparameter = element.var_f391bf01090b356c;
        break;
      case 7:
        searchparameter = element.elementcontainer;
        break;
      case 1:
        searchparameter = element.elementpartname;
        break;
      case 8:
        searchparameter = element.var_12db460b6bf36594;
        break;
      case 3:
        searchparameter = element.var_be816838784d6db;
        break;
      case 2:
        searchparameter = element.elementicon;
        break;
      case 5:
        searchparameter = element.elementitemid;
        break;
      case 6:
        searchparameter = element.elementindex;
        break;
      case 4:
        searchparameter = element.trackernumber;
        break;
      case 9:
        searchparameter = element.var_d10723bdc6d74fa0;
        break;
      case 10:
        searchparameter = element.var_a1a9be5dd973583d;
        break;
      default:
        return undefined;
    }

    if(searchparameter == attribute) {
      return element.elementid;
    }
  }

  return undefined;
}

function function_6844602f3120e900(elementid, attribute, listoverride) {
  if(!isDefined(level.arrow.elementlist) || level.arrow.elementlist.size < 1 || !isDefined(level.arrow.elementlist[elementid])) {
    return undefined;
  }

  var_eb99ae539fab2970 = level.arrow.elementlist;

  if(isDefined(listoverride)) {
    var_eb99ae539fab2970 = listoverride;
  }

  switch (attribute) {
    case 0:
      return var_eb99ae539fab2970[elementid].var_f391bf01090b356c;
    case 7:
      return var_eb99ae539fab2970[elementid].elementcontainer;
    case 1:
      return var_eb99ae539fab2970[elementid].elementpartname;
    case 3:
      return var_eb99ae539fab2970[elementid].var_be816838784d6db;
    case 2:
      return var_eb99ae539fab2970[elementid].elementicon;
    case 5:
      return var_eb99ae539fab2970[elementid].elementitemid;
    case 6:
      return var_eb99ae539fab2970[elementid].elementindex;
    case 4:
      return var_eb99ae539fab2970[elementid].trackernumber;
    case 9:
      return var_eb99ae539fab2970[elementid].var_d10723bdc6d74fa0;
    case 10:
      return var_eb99ae539fab2970[elementid].var_a1a9be5dd973583d;
    case 11:
      return var_eb99ae539fab2970[elementid].var_da490276f40d2a1c.var_24d4ba21d4c1cb81;
    case 12:
      return var_eb99ae539fab2970[elementid].var_da490276f40d2a1c.var_1ffffcadf503cb61;
    case 13:
      return var_eb99ae539fab2970[elementid].elementstringlist.heldreference;
    case 14:
      return var_eb99ae539fab2970[elementid].elementstringlist.locatereference;
    case 15:
      return var_eb99ae539fab2970[elementid].elementstringlist.securedreference;
    case 16:
      return var_eb99ae539fab2970[elementid].elementstringlist.protectreference;
    default:
      return undefined;
  }
}

function function_270efe97b9f9c9fc(elems) {
  if(!isDefined(elems)) {
    return;
  }

  if(isarray(elems)) {
    foreach(elem in elems) {
      if(isDefined(elem)) {
        elem destroy();
      }
    }

    return;
  }

  if(isDefined(elems)) {
    elems destroy();
  }
}

function function_a0a60c2df22298d9(targetteam, isvisible) {
  bombsite = level.arrow.props.bombsite;

  if(!isDefined(bombsite.elementicons)) {
    return;
  }

  foreach(icon in bombsite.elementicons) {
    if(!isDefined(icon)) {
      continue;
    }

    icon function_1b390a39ac7ec281(targetteam, isvisible);
  }
}

function function_8edba3d30393649(position, ignoreents) {
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
  testpos = scripts\mp\gametypes\br_public::droptogroundmultitrace(position, 100, -150, contents);
  result = scripts\mp\gametypes\br_public::raytraceoffset(testpos, 0, 0, 50, -125, contents, ignoreents);
  spawninfo = spawnStruct();
  spawninfo.origin = result["position"];
  angledelta = math::anglebetweenvectors((0, 0, 1), result["normal"]);

  if(angledelta <= level.arrow.dvars.var_c2c0c51679aa5a4f) {
    spawninfo.angles = generateaxisanglesfromupvector(result["normal"], (0, 0, 0));
  } else {
    spawninfo.angles = (0, 0, 0);
  }

  return spawninfo;
}

function function_aee3a8be63db5997(player) {
  hastoken = player scripts\cp_mp\challenges::function_3d871e989c0bdb6d();
  println("<dev string:xf5>" + player.name + "<dev string:x127>" + hastoken + "<dev string:x136>" + level.arrow.dvars.skiptoken);
  return hastoken || level.arrow.dvars.skiptoken;
}

function function_623381919d834a76(team) {
  foreach(player in level.teamdata[team]["players"]) {
    hastoken = player scripts\cp_mp\challenges::function_3d871e989c0bdb6d();

    if(hastoken) {
      println("<dev string:x146>" + player.name + "<dev string:x127>" + hastoken);
      return true;
    }
  }

  println("<dev string:x185>");
  return false;
}

function function_af54a33c2ac9a71f(player, elementid) {
  if(!isDefined(level.arrow) || !isDefined(level.arrow.props.elements) || !isPlayer(player)) {
    return false;
  }

  foreach(teamselements in level.arrow.props.elements) {
    if(!isDefined(teamselements[elementid]) || !isDefined(teamselements[elementid].player) || !isPlayer(teamselements[elementid].player)) {
      continue;
    }

    if(teamselements[elementid].player == player) {
      return true;
    }
  }

  return false;
}

function function_93b029fa699bd0cc(team, elementids) {
  if(!isDefined(level.arrow) || !isDefined(level.arrow.teaminfo[team]) || !isDefined(elementids)) {
    return false;
  }

  teammates = getteamdata(team, "players");

  foreach(elementid in elementids) {
    elementfound = 0;

    foreach(player in teammates) {
      if(!isDefined(player)) {
        continue;
      }

      if(function_af54a33c2ac9a71f(player, elementid)) {
        elementfound = 1;
      }
    }

    if(!elementfound) {
      return false;
    }
  }

  return true;
}

function function_c2ef2a31f608bd68(container) {
  if(!container function_5facfbee97e1a98e()) {
    return false;
  }

  state = container function_e5e7df17c00ca60b();

  if(state == "active_and_closed" || state == "active_and_open" || state == "opening") {
    return true;
  }

  return false;
}

function arrow_flow() {
  teaminfo = self;

  if(level.arrow.dvars.scriptedflow == 2 || level.arrow.dvars.scriptedflow == 3) {
    thread function_a0c5c7bd3e5a9430();
  }

  if(level.arrow.dvars.scriptedflow == 3) {
    firstelement = function_96a1620d901981d1(0, 6);
    secondelement = function_96a1620d901981d1(1, 6);
    teaminfo function_f9c0e192946c2b4d(function_6844602f3120e900(firstelement, 7));
    teaminfo function_f421381f1379bc3c(secondelement);
  }

  if(level.arrow.dvars.scriptedflow == 2) {
    teaminfo function_f421381f1379bc3c(function_96a1620d901981d1(0, 6));
  } else if(level.arrow.dvars.scriptedflow == 1) {
    teaminfo thread function_d1a420c02864991a();
  } else if(level.arrow.dvars.scriptedflow == 0) {
    teaminfo function_6a6b4d717ec3582e();
  } else if(level.arrow.dvars.scriptedflow == 4) {
    thread function_f77bcf971718b230();
    teaminfo thread function_6015e54691824443();
  }

  teaminfo function_56ee84f1b091647a();
}

function function_f77bcf971718b230() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  for(circle = 0; true; circle++) {
    success = function_593f3ae1c539dc69(circle);

    if(!istrue(success)) {
      function_9c74ccdaa1e15c02("circle_close");
      return;
    }

    if(istrue(success) && circle == level.arrow.dvars.var_f07dddd68d0cbcd8) {
      function_c4516dcf97c05302();
    }

    level waittill("br_circle_set");
  }
}

function function_593f3ae1c539dc69(circleindex) {
  success = 1;
  dropindex = function_f584d115cb4c5860();

  if(circleindex == dropindex) {
    success = function_d2efef69ff2aae7b();
  }

  return success;
}

function function_a0c5c7bd3e5a9430() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  for(circle = 0; true; circle++) {
    success = function_3abd98401a0edf89(circle);

    if(!istrue(success)) {
      function_9c74ccdaa1e15c02("circle_close");
      return;
    }

    if(istrue(success) && circle == level.arrow.dvars.var_f07dddd68d0cbcd8) {
      function_c4516dcf97c05302();
    }

    level waittill("br_circle_set");
  }
}

function function_3abd98401a0edf89(circleindex) {
  dropindex = function_f584d115cb4c5860();
  success = 1;

  if(level.arrow.elementlist.size == 3) {
    var_89482557d24c6d81 = 2;
    var_6197e0cff49f50ff = 1;
  } else {
    var_89482557d24c6d81 = 1;
    var_6197e0cff49f50ff = 0;
  }

  if(circleindex == 1 && level.arrow.elementlist.size == 3) {
    function_d587d06c0fede8c8(circleindex);
    return success;
  }

  if(circleindex > 0) {
    function_d587d06c0fede8c8(circleindex);
    success = function_8edd1a973f8e9c57(circleindex, dropindex, var_89482557d24c6d81, var_6197e0cff49f50ff);
  }

  if(circleindex == dropindex) {
    success = function_d2efef69ff2aae7b();
  }

  return success;
}

function function_f584d115cb4c5860() {
  if(scripts\mp\gametypes\br_circle_util::function_d987886bb9de9137() <= 1) {
    return level.arrow.dvars.var_dc6fda0fbc9fe1e9;
  }

  if(!scripts\mp\gametypes\br_circle_util::function_49411683f5a51daa(level.arrow.dvars.var_21aa92004dd32d05)) {
    return level.arrow.dvars.var_21aa92004dd32d05;
  }

  return level.arrow.dvars.var_dc6fda0fbc9fe1e9;
}

function function_d587d06c0fede8c8(circleindex) {
  level notify("flow_update_timers");
  elementid = function_96a1620d901981d1(circleindex - 1, 6);

  if(isDefined(elementid)) {
    level.arrow.countdowns = [];
    thiscircle = scripts\mp\gametypes\br_circle::getcircleclosetime(circleindex - 1);
    nextcircle = scripts\mp\gametypes\br_circle::getcircleclosetime(circleindex);
    thread function_69ee75a3eea2ac03(elementid, int(nextcircle - thiscircle));
    return;
  }

  level.arrow.countdowns = undefined;
}

function function_69ee75a3eea2ac03(elementid, timer, team, var_6c0954d8d0416746) {
  level endon("game_ended");
  level endon("flow_update_timers");
  countdown = int(timer);
  timerpaused = 0;

  while(countdown > 0) {
    if(!function_66c05a319972d8dc()) {
      wait 1;
      countdown--;
      continue;
    }

    if(isDefined(team)) {
      level.arrow.teaminfo[team].var_8dfd9e71543b605b[elementid] = countdown;
    } else {
      level.arrow.countdowns[elementid] = countdown;
    }

    if(countdown <= level.arrow.dvars.var_29258dcc063eec7f) {
      if(!isDefined(team)) {
        function_20238d522c76fb01(countdown, timerpaused);
      } else {
        level.arrow.teaminfo[team] function_56ee84f1b091647a(countdown, timerpaused);
      }
    }

    wait 1;
    timerpaused = istrue(level.arrow.dvars.var_11027e0991067faa) && !function_93b029fa699bd0cc(team, var_6c0954d8d0416746);

    if(!timerpaused) {
      countdown--;
    }
  }
}

function function_8edd1a973f8e9c57(circleindex, dropindex, var_89482557d24c6d81, var_6197e0cff49f50ff) {
  if(!function_66c05a319972d8dc()) {
    return false;
  }

  foreach(teaminfo in level.arrow.teaminfo) {
    if(teaminfo.state == 0) {
      continue;
    }

    currentelement = function_96a1620d901981d1(circleindex - var_89482557d24c6d81, 6);

    if(isDefined(currentelement)) {
      teaminfo function_f9c0e192946c2b4d(function_6844602f3120e900(currentelement, 7));
    }

    nextelement = function_96a1620d901981d1(circleindex - var_6197e0cff49f50ff, 6);

    if(isDefined(nextelement) && circleindex != dropindex) {
      teaminfo function_f421381f1379bc3c(nextelement);
    }
  }

  return true;
}

function function_d2efef69ff2aae7b() {
  if(!function_66c05a319972d8dc()) {
    return false;
  }

  if(!isDefined(level.arrow.props.bombsite)) {
    return false;
  }

  foreach(teaminfo in level.arrow.teaminfo) {
    if(teaminfo.state == 0) {
      continue;
    }

    player = default_to(teaminfo.owner, teaminfo.champion);

    if(!isDefined(player)) {
      continue;
    }

    level.arrow.props.bombsite thread arrow_bombsitereveal(player);
  }

  return true;
}

function function_c4516dcf97c05302() {
  if(!function_66c05a319972d8dc()) {
    return;
  }

  thread function_1a640c4239148816();
}

function function_1a640c4239148816() {
  level endon("game_ended");
  level waittill("br_circle_started");
  setDvar(@ "hash_47d8674c992e098", 1);
  scripts\mp\gametypes\br_circle::pausecircle(1);

  while(function_66c05a319972d8dc()) {
    wait 0.1;
  }

  scripts\mp\gametypes\br_circle::pausecircle(0);
}

function function_d1a420c02864991a() {
  teaminfo = self;
  level endon("game_ended");
  teaminfo endon("on_end");

  foreach(element in level.arrow.elementorder) {
    elementcontainer = function_6844602f3120e900(element, 7);

    if(!isDefined(elementcontainer)) {
      break;
    }

    teaminfo function_f9c0e192946c2b4d(elementcontainer);
    function_5282d6616a31530e(teaminfo, function_6844602f3120e900(element, 6) + 1);
    teaminfo waittill("element_pickup_first");
  }

  level.arrow.props.bombsite arrow_bombsitereveal(teaminfo.champion);
}

function function_5282d6616a31530e(teaminfo, elementindex) {
  if(elementindex >= level.arrow.elementlist.size) {
    return;
  }

  elementid = function_96a1620d901981d1(elementindex, 6);
  teaminfo function_f421381f1379bc3c(elementid);
}

function function_6015e54691824443() {
  teaminfo = self;
  level endon("game_ended");
  teaminfo endon("on_end");
  previouselement = [];

  foreach(element in level.arrow.elementorder) {
    if(!isDefined(level.arrow.elementlist[element])) {
      break;
    }

    function_69ee75a3eea2ac03(element, int(level.arrow.dvars.var_29258dcc063eec7f), teaminfo.targetteam, previouselement);
    elementcontainer = function_6844602f3120e900(element, 7);
    teaminfo function_f9c0e192946c2b4d(elementcontainer);
    teaminfo waittill("element_pickup_first");
    previouselement[previouselement.size] = element;
  }
}

function function_f9c0e192946c2b4d(containername) {
  teaminfo = self;
  elementid = function_96a1620d901981d1(containername, 7);

  if(isDefined(level.arrow.props.containers) && isDefined(level.arrow.props.containers[teaminfo.targetteam]) && isDefined(level.arrow.props.containers[teaminfo.targetteam][elementid])) {
    return;
  }

  spawnnode = teaminfo function_90204fe09c3ddb14();

  if(!isDefined(spawnnode)) {
    teaminfo thread function_88a043b99a75e47("container_spawn_failed");
    return;
  }

  container = function_2eb30dce28e6a061(containername, teaminfo.targetteam, spawnnode.origin, spawnnode.angles);

  if(!isDefined(level.arrow.props.containers)) {
    level.arrow.props.containers = [];
  }

  if(!isDefined(level.arrow.props.containers[teaminfo.targetteam])) {
    level.arrow.props.containers[teaminfo.targetteam] = [];
  }

  level.arrow.props.containers[teaminfo.targetteam][elementid] = container;
  teaminfo function_56ee84f1b091647a();
}

function function_90204fe09c3ddb14() {
  teaminfo = self;
  continuesearch = 0;

  while(continuesearch <= 2) {
    teamorigin = teaminfo function_50b388aa83aeca2c();
    possiblenodes = function_ca6c0350ac3a2550(teamorigin, continuesearch);

    if(possiblenodes.size == 0) {
      continuesearch++;
      continue;
    }

    safetime = level.arrow.dvars.var_7846374c36699fd8 * getmatchrulesdata("brData", "circleTimeScale");
    spawnnode = function_1780902700581723(possiblenodes, safetime);

    if(!isDefined(spawnnode)) {
      continuesearch++;
      continue;
    }

    return spawnnode;
  }

  return undefined;
}

function function_d26703ef0bdc9106() {
  assert(isDefined(level.totalplayers));

  if(!isDefined(level.contractmanager)) {
    return false;
  }

  if(scripts\mp\utility\game::privatematch()) {
    return false;
  }

  if(istrue(level.arrow.dvars.skiptoken)) {
    return true;
  }

  if(isDefined(level.arrow.dvars.var_60ea877e814ee1a8) && level.arrow.dvars.var_60ea877e814ee1a8 > 0) {
    percentage = level.arrow.dvars.var_60ea877e814ee1a8 / 100;
    maxplayers = getdvarint(@ "party_maxplayers");
    var_69ba742900b5b3a2 = maxplayers * percentage;

    if(level.totalplayers < var_69ba742900b5b3a2) {
      scripts\mp\gametypes\br_analytics::function_77814c1b523fd8a3(level.totalplayers, "not_enough_players_in_match", -1);
      return false;
    }
  }

  return true;
}

function function_722929515e5a34b9() {
  level endon("game_ended");

  if(!function_d0d49ca3928fb0b8()) {
    return;
  }

  function_ef0d52837c9e7954();

  if(!function_d26703ef0bdc9106()) {
    logstring("br_elite_broken_arrow::arrow_tabletInit - match is not valid!");
    return;
  }

  thread function_4fb72c0c86f7746f();

  if(!istrue(level.arrow.dvars.var_dac46c8fda182f4a)) {
    scripts\mp\locksandkeys::function_5d0e6d83fdc95800();
  }

  thread function_1ee5fc618d505e0e();

  if(!isDefined(level.arrow.numspawned)) {
    level.arrow.numspawned = 0;
  }

  if(!isDefined(level.arrow.var_60982e3ae30bbd22)) {
    level.arrow.var_60982e3ae30bbd22 = 0;
  }

  if(!isDefined(level.arrow.props.var_62a2559833eb4ac2)) {
    level.arrow.props.var_62a2559833eb4ac2 = [];
  }

  for(i = 0; i < level.arrow.dvars.numspawn; i++) {
    newtablet = function_e82dcf1f570a836e();

    if(!isDefined(newtablet)) {
      break;
    }

    if(!isDefined(level.arrow.props.tablets)) {
      level.arrow.props.tablets = [];
    }

    level.arrow.props.tablets[level.arrow.props.tablets.size] = newtablet;
  }

  function_cd4ce58be10fb51d();
}

function function_ef0d52837c9e7954() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  if(istrue(level.var_c62d39d6e6afb119)) {
    while(!isDefined(level.var_f1073fbd45b59a06) || !istrue(level.var_f1073fbd45b59a06.var_9b87fdb80920f442)) {
      waitframe();
    }
  }

  waitframe();
}

function function_d0d49ca3928fb0b8() {
  if(istrue(level.arrow.dvars.disabled)) {
    return false;
  }

  if(istrue(level.arrow.dvars.tabletfiltered)) {
    return false;
  }

  return true;
}

function function_e82dcf1f570a836e() {
  lootcount = getlootspawnpointcount();

  if(lootcount == 0) {
    assertmsg("<dev string:x1e5>");
    return;
  }

  startingindex = randomint(lootcount);
  currentindex = startingindex;

  while(true) {
    var_d67c5bbb1609d037 = getlootspawnpoint(currentindex);

    if(function_5c6ad7c2954a522c(var_d67c5bbb1609d037)) {
      break;
    }

    currentindex = (currentindex + 1) % lootcount;

    if(currentindex == startingindex) {
      assertmsg("<dev string:x22d>");
      return;
    }
  }

  newtablet = function_3ff56f0ba058501a(var_d67c5bbb1609d037.origin, var_d67c5bbb1609d037.angles);
  disablelootspawnpoint(currentindex);
  return newtablet;
}

function function_3ff56f0ba058501a(origin, angles) {
  if(getsubgametype() == "resurgence") {
    var_c0133b8028ed8c5f = "offhand_2h_wm_briefcase_bomb_v0_nuke_resurgence";
    contractref = "elite_arrow_resurgence";
  } else {
    var_c0133b8028ed8c5f = "offhand_2h_wm_briefcase_bomb_v0_nuke";
    contractref = "elite_arrow";
  }

  tabletent = spawn("script_model", origin);
  tabletent setModel(var_c0133b8028ed8c5f);
  tabletent playLoopSound("iw9_br_elite_contract_attract_lp");
  tabletent.angles = angles;
  newtablet = namespace_1eb3c4e0e28fac71::function_fe5d4d0a6a530b1e(contractref, origin, angles);
  newtablet.task.tabletent = tabletent;
  level.arrow.contractref = contractref;
  return newtablet;
}

function function_5c6ad7c2954a522c(lootnode) {
  if(!function_a59e04a186feda43(lootnode.index) || lootnode.game_extrainfo == 1) {
    return false;
  }

  if(namespace_1eb3c4e0e28fac71::function_60094dbeee6e39b0(lootnode.origin)) {
    return false;
  }

  if(issubstr(lootnode.typename, "small")) {
    return false;
  }

  if(scripts\mp\gametypes\br_gametypes::isfeatureenabled("circle") && istrue(level.arrow.dvars.var_336cbba00b3c960c)) {
    dangertime = scripts\mp\gametypes\br_circle_util::gettimetilldangerforpoint(lootnode.origin);
    circleend = scripts\mp\gametypes\br_circle::gettimetillcircleclosing(1);

    if(circleend < dangertime) {
      return false;
    }
  }

  if(namespace_9823ee6035594d67::function_f59f68adc71d49b3(lootnode.origin)) {
    return false;
  }

  if(scripts\mp\gametypes\br_bunker_utility::function_5581450b830e0245(lootnode.origin)) {
    return false;
  }

  if(!istrue(level.arrow.dvars.var_dac46c8fda182f4a) && scripts\mp\locksandkeys::function_64332f29e2409e55(lootnode.origin)) {
    return false;
  }

  if(issharedfuncdefined("eliteArrow", "isDeniedArea") && istrue([[getsharedfunc("eliteArrow", "isDeniedArea")]](lootnode.origin))) {
    return false;
  }

  return true;
}

function function_1ee5fc618d505e0e() {
  level endon("game_ended");

  if(istrue(level.arrow.dvars.var_b303983f30cb3658)) {
    return;
  }

  scripts\mp\flags::gameflagwait("infil_animatic_complete");
  wait 1.5;
  splashteams = [];

  foreach(player in level.players) {
    if(function_aee3a8be63db5997(player)) {
      if(!istrue(splashteams[player.team])) {
        splashteams[player.team] = 1;
        showsplashtoteam(player.team, function_130af1b9f6740479("elite_arrow_available"));
        level thread scripts\mp\gametypes\br_public::brleaderdialogteam("arrow_available", player.team, undefined, 2);
      }
    }
  }
}

function function_4fb72c0c86f7746f() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  for(circle = 0; true; circle++) {
    function_a2530c94dc7fdcbc(circle);
    level waittill("br_circle_set");
  }
}

function function_a2530c94dc7fdcbc(circleindex) {
  if(circleindex >= 2) {
    if(!isDefined(level.arrow.var_eac66a3f33147ae3)) {
      function_259dd894cba599e8();
      level.arrow.var_eac66a3f33147ae3 = 1;
      scripts\mp\gametypes\br_analytics::function_77814c1b523fd8a3(level.totalplayers, "tablets_not_picked_up_before_2nd_circle", -1);
    }
  }
}

function function_259dd894cba599e8() {
  if(!isDefined(level.arrow) || !isDefined(level.arrow.props.tablets)) {
    return;
  }

  foreach(tablet in level.arrow.props.tablets) {
    if(!isDefined(tablet)) {
      continue;
    }

    tablet.task function_3912f25d2ead337e();
    tablet thread namespace_1eb3c4e0e28fac71::tablethide();
  }
}

function function_3912f25d2ead337e() {
  task = self;

  if(isDefined(task.tabletent)) {
    task.tabletent delete();
    task.tabletent = undefined;
  }
}

function function_15d7b4838d344c81() {
  player = self;

  if(!isDefined(level.arrow) || !isDefined(level.arrow.props.tablets)) {
    return;
  }

  foreach(tablet in level.arrow.props.tablets) {
    if(!isDefined(tablet)) {
      continue;
    }

    tablet.task.tabletent hidefromplayer(player);
    tablet disablescriptableplayeruse(player);
  }
}

function function_16d299fc7942ba3d(team) {
  teammates = getteamdata(team, "players");

  if(!isDefined(level.arrow) || !isDefined(level.arrow.props.tablets)) {
    return;
  }

  foreach(player in teammates) {
    if(isDefined(player)) {
      player function_15d7b4838d344c81();
    }
  }
}

function function_cd4ce58be10fb51d() {
  if(!isDefined(level.arrow) || !isDefined(level.arrow.props.tablets)) {
    return;
  }

  println("<dev string:x276>");

  foreach(player in level.players) {
    canusetablet = function_aee3a8be63db5997(player);

    if(canusetablet || function_623381919d834a76(player.team)) {
      player function_1b94d19475863421(canusetablet);
      continue;
    }

    player function_15d7b4838d344c81();
  }
}

function function_1b94d19475863421(canusetablet) {
  player = self;
  println("<dev string:x2b3>" + player.name + "<dev string:x2e8>" + canusetablet);

  if(!isDefined(level.arrow) || !isDefined(level.arrow.props.tablets)) {
    return;
  }

  foreach(tablet in level.arrow.props.tablets) {
    if(!isDefined(tablet)) {
      continue;
    }

    tablet.task.tabletent showtoplayer(player);

    if(canusetablet) {
      tablet enablescriptableplayeruse(player);
      continue;
    }

    tablet disablescriptableplayeruse(player);
  }
}

function function_cabc7d4e59b3d20a() {
  tabletent = self;
  task = tabletent.task;
  task function_3912f25d2ead337e();
  task.tablet thread namespace_1eb3c4e0e28fac71::tablethide();
  return false;
}

function function_9eac0670a84449a5(team) {
  if(!level.arrow.dvars.var_6f397e9d54ef92bf || !level.arrow.dvars.var_175c4844ebd8ce8b) {
    return;
  }

  tablet = level.arrow.props.var_62a2559833eb4ac2[team];

  if(isDefined(tablet)) {
    foreach(element in level.arrow.props.elements[team]) {
      element function_c1f94114ae475307();
    }

    tablet thread namespace_1eb3c4e0e28fac71::tablethide();
  }
}

function function_cce93d9edef517a() {
  task = self;

  if(!isDefined(level.arrow.teaminfo)) {
    level.arrow.teaminfo = [];
  }

  teaminfo = spawnStruct();
  teaminfo.state = 1;
  teaminfo.task = task;
  teaminfo.targetteam = task.targetteam;
  teaminfo.champion = task.var_d154ac2657c5f44;
  teaminfo.owner = task.var_d154ac2657c5f44;
  teaminfo.var_546e0db97a2c9d12 = undefined;
  teaminfo.firstpickups = 0;
  teaminfo.var_876be3bc4df3a81d = 0;
  teaminfo.var_8dfd9e71543b605b = [];
  level.arrow.teaminfo[task.targetteam] = teaminfo;
  teaminfo thread function_e10c95ed3ef9e1dd();
}

function function_b141b13225e7b0fe(success) {
  teaminfo = self;
  function_6c05bd253d4ae324(teaminfo.targetteam);
  var_6e323a77bd00084 = istrue(teaminfo.var_6e323a77bd00084) && level.arrow.dvars.var_6f397e9d54ef92bf;

  if(!var_6e323a77bd00084) {
    function_c2ce67f5903927af(teaminfo.targetteam);
  }

  function_aa6ba140692b3197(teaminfo.targetteam);

  if(!var_6e323a77bd00084) {
    function_a0a60c2df22298d9(teaminfo.targetteam, 0);
  }

  bombsite = level.arrow.props.bombsite;

  if(isDefined(bombsite.arment)) {
    bombsite.arment function_3ae40bb839dc4aea(teaminfo.targetteam, 0);
  }

  if(isDefined(bombsite.fuseent)) {
    bombsite.fuseent function_3ae40bb839dc4aea(teaminfo.targetteam, 1);
  }

  if(istrue(success)) {
    teaminfo.state = 6;
    return;
  }

  teaminfo.state = 0;
}

function function_e10c95ed3ef9e1dd() {
  teaminfo = self;
  teaminfo notify("team_info_watch");
  teaminfo endon("team_info_watch");
  teaminfo endon("on_end");
  level endon("game_ended");

  while(true) {
    if(!isDefined(teaminfo.owner)) {
      teaminfo function_1bab1f08afa8caae();
      wait 1;
      continue;
    }

    reason = teaminfo.owner waittill_any_return_no_endon_death_3("death_or_disconnect", "br_team_fully_eliminated", "arrow_player_removed");

    if(!isDefined(teaminfo.var_546e0db97a2c9d12) && isDefined(teaminfo.owner)) {
      teaminfo.var_546e0db97a2c9d12 = teaminfo.owner.origin;
    }

    teaminfo function_944c6cf7be1e6463();
    teaminfo function_337eae8f3c28fe1c();
    teaminfo thread function_1bab1f08afa8caae(reason);
  }
}

function function_337eae8f3c28fe1c(reason) {
  teaminfo = self;
  teammates = getteamdata(teaminfo.targetteam, "players");

  foreach(player in teammates) {
    if(isalive(player) && player != teaminfo.owner) {
      teaminfo.owner = player;
      teaminfo.var_546e0db97a2c9d12 = undefined;
      return;
    }
  }

  teaminfo.owner = undefined;
}

function function_944c6cf7be1e6463() {
  teaminfo = self;

  if(getteamcount(teaminfo.targetteam) != 0) {
    return;
  }

  if(function_ce3e8c8b6de2ca1b()) {
    bombsite = level.arrow.props.bombsite;

    if(bombsite.targetteam == teaminfo.targetteam) {
      bombsite.fuseent notify("fuse_cancelled");
      teaminfo notify("team_info_watch");
    }
  }
}

function function_1bab1f08afa8caae(reason) {
  teaminfo = self;
  teammates = getteamdata(teaminfo.targetteam, "players");

  if(!isDefined(reason) || reason != "br_team_fully_eliminated") {
    foreach(player in teammates) {
      if(!isDefined(player.placementbonus)) {
        return;
      }
    }
  }

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("eliteWatchTeamWipe")) {
    handled = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("eliteWatchTeamWipe", teaminfo, reason);

    if(istrue(handled)) {
      return;
    }
  }

  if(isDefined(reason) && reason == "arrow_player_removed") {
    teaminfo thread function_88a043b99a75e47("team_empty", 0);
    return;
  }

  var_545a22b48cd677fa = undefined;

  if(isDefined(teaminfo.owner) && isDefined(teaminfo.owner.laststandattacker)) {
    var_545a22b48cd677fa = teaminfo.owner.laststandattacker.team;
  }

  teaminfo thread function_88a043b99a75e47("team_wiped", 0, var_545a22b48cd677fa);
}

function function_3797fc27da5395c1() {
  level endon("br_ending_start");
  level waittill("team_won", winningteam);

  if(!isDefined(level.arrow) || !isDefined(level.arrow.teaminfo)) {
    return;
  }

  if(isDefined(winningteam)) {
    foreach(teaminfo in level.arrow.teaminfo) {
      if(!isDefined(teaminfo) || !isDefined(teaminfo.task) || teaminfo.targetteam == winningteam) {
        continue;
      }

      if(teaminfo.state != 0 && teaminfo.state != 6) {
        teaminfo thread function_88a043b99a75e47("team_wiped", 0, winningteam);
      }
    }
  }
}

function function_77fb65ae3082871c() {
  active = 0;

  foreach(teaminfo in level.arrow.teaminfo) {
    if(!isDefined(teaminfo)) {
      continue;
    }

    if(teaminfo.state >= 1) {
      active++;
    }
  }

  return active;
}

function function_50b388aa83aeca2c() {
  teaminfo = self;

  if(isDefined(teaminfo.var_546e0db97a2c9d12)) {
    return teaminfo.var_546e0db97a2c9d12;
  }

  return teaminfo.owner.origin;
}

function function_cc850454568f09f9(newowner) {
  teaminfo = self;
  teaminfo.owner = newowner;
  teaminfo.var_546e0db97a2c9d12 = undefined;
  teaminfo thread function_e10c95ed3ef9e1dd();
}

function function_1a9ee6a7092d4536() {
  teaminfo = self;
  elementsstates = teaminfo function_2e702bea8f46ba();

  foreach(state in elementsstates) {
    if(!(state == 3) || istrue(state >= 5 && state <= 8)) {
      return false;
    }
  }

  return true;
}

function function_6085101092321954() {
  teaminfo = self;
  elementsstates = teaminfo function_2e702bea8f46ba();

  foreach(state in elementsstates) {
    switch (state) {
      case 1:
      case 2:
      case 4:
        return false;
      case 0:
      case 3:
      case 5:
      case 6:
      case 7:
      case 8:
        break;
      default:
        assertmsg("<dev string:x2fb>" + state);
        break;
    }
  }

  return true;
}

function function_6c310980df01ac73() {
  bombsite = spawnscriptable(function_e7799b3ad0d7b9fd(), (0, 0, -5000), (0, 0, 0));
  bombsite function_9ad2b2a571d4cdc9("disabled");
  bombsite function_9ad2b2a571d4cdc9("blank", "arrow_bombsite_screen");
  neededelements = [];

  foreach(element in level.arrow.elementlist) {
    neededelements[element.elementid] = 0;
  }

  bombsite.neededelements = neededelements;
  bombsite.enabled = 1;
  bombsite.dropping = undefined;
  bombsite.siterevealed = undefined;
  bombsite.var_dc0258a29dc9faf1 = undefined;
  bombsite.var_27db4eb198cd48b9 = undefined;
  bombsite.skiptonuke = undefined;
  bombsite.detonated = undefined;
  bombsite.disarmed = undefined;
  return bombsite;
}

function function_e7799b3ad0d7b9fd() {
  var_7a5184f920a39079 = undefined;

  if(issharedfuncdefined("eliteArrow", "getBombsiteScriptable")) {
    var_7a5184f920a39079 = [[getsharedfunc("eliteArrow", "getBombsiteScriptable")]]();
  }

  if(!isDefined(var_7a5184f920a39079)) {
    var_7a5184f920a39079 = ter_op(level.arrow.elementorder.size > 0 && level.arrow.elementorder[0] == "gal", "brloot_elite_arrow_bombsite_delta", "brloot_elite_arrow_bombsite");
  }

  return var_7a5184f920a39079;
}

function function_b51e8c52609285f0() {
  bombsite = self;
  bombsite thread function_eaf22a1a752cc819();
  bombsite function_4d6d1400d6df4b2d();
  bombsite function_a5cbe340384af146();
  bombsite function_50ae9cf898ec9ba2();
  bombsite function_2e031201711a99de();
  bombsite function_2156c23e5afc6d06();

  if(isDefined(bombsite.arment)) {
    bombsite.arment thread function_e9b71089684738a7(1);
  }

  if(isDefined(bombsite.fuseent)) {
    bombsite.fuseent thread function_e9b71089684738a7(1);
  }

  bombsite waittill("death");

  if(function_3b0bc758816ba092()) {
    bombsite.disarmed = 1;
    bombsite function_9ad2b2a571d4cdc9("disabled");
    bombsite function_9ad2b2a571d4cdc9("disarmed", "arrow_bombsite_screen");
    return;
  }

  bombsite freescriptable();
}

function function_2156c23e5afc6d06() {
  bombsite = self;
  bombsite function_231aae2264ce7f2e();

  if(isDefined(bombsite.elementicons)) {
    foreach(icon in bombsite.elementicons) {
      if(!isDefined(icon)) {
        continue;
      }

      icon function_231aae2264ce7f2e();
    }
  }
}

function function_a4fc9a04b674a389(instance, part, state, player, bautouse, usestring) {
  if(part != "arrow_bombsite_body") {
    return;
  }

  [itemindex, slotlootid] = instance function_790ec5dc7d594c13(player);

  if(!isDefined(slotlootid) || !isDefined(player) || !isDefined(itemindex)) {
    return;
  }

  instance function_7c7d1cf55b40c047(player, itemindex, slotlootid);
}

function function_790ec5dc7d594c13(player) {
  bombsite = self;

  if(!isDefined(level.arrow.teaminfo[player.team])) {
    return [undefined, undefined];
  }

  if(!function_dd1eddcb3a80416d(player)) {
    return [undefined, undefined];
  }

  if(istrue(bombsite.var_27db4eb198cd48b9) || istrue(bombsite.var_dc0258a29dc9faf1)) {
    return [undefined, undefined];
  }

  [itemindex, slotlootid] = function_c1a30db229b1311d(player, 0);

  while(isDefined(itemindex)) {
    if(function_bc04f4b45cd80cf8(function_96a1620d901981d1(slotlootid, 5))) {
      return [itemindex, slotlootid];
    }

    [itemindex, slotlootid] = function_c1a30db229b1311d(player, itemindex + 1);
  }

  return [undefined, undefined];
}

function function_7c7d1cf55b40c047(player, itemindex, slotlootid) {
  bombsite = self;
  elementid = function_96a1620d901981d1(slotlootid, 5);

  if(isDefined(bombsite.elementicons)) {
    bombsite.elementicons[elementid] function_231aae2264ce7f2e();
    bombsite.elementicons[elementid] = undefined;
  }

  bombsite thread function_f92179dcf9d84bc9(player, elementid, itemindex);
  bombsite thread function_eaf22a1a752cc819(elementid);
  player thread scripts\mp\gametypes\br_public::playerplaygestureweaponanim("iw8_ges_plyr_loot_pickup", 1.17);
  player namespace_aead94004cf4c147::function_db1dd76061352e5b(itemindex, 1);
}

function function_1395e6fa844b959f(player) {
  bombsite = self;
  level endon("game_ended");
  bombsite function_9ad2b2a571d4cdc9("depositing");
  wait 1.5;

  if(bombsite function_10451fcedd4d3d6e()) {
    if(!player scripts\cp_mp\utility\inventory_utility::iscurrentweapon("briefcase_bomb_mp_nuke")) {
      bombsite function_9ad2b2a571d4cdc9("arm");
      bombsite function_3570eaa3344a147c();
    }

    return;
  }

  bombsite function_9ad2b2a571d4cdc9("deposit");
  bombsite function_a0ddad612cbe0349();
}

function function_e5c04edc3287e3f(toenable, targetteam, flipothers) {
  bombsite = self;

  if(istrue(flipothers)) {
    function_967f19716ac6edd6(!toenable);
  }

  if(isDefined(targetteam)) {
    function_d0dbca153b783912(toenable, targetteam);
    return;
  }

  function_967f19716ac6edd6(toenable);
}

function function_967f19716ac6edd6(toenable) {
  bombsite = self;

  if(istrue(toenable)) {
    foreach(player in level.players) {
      bombsite enablescriptableplayeruse(player);
    }

    return;
  }

  foreach(player in level.players) {
    bombsite disablescriptableplayeruse(player);
  }
}

function function_d0dbca153b783912(toenable, targetteam) {
  bombsite = self;
  assertex(isDefined(targetteam), "<dev string:x317>");

  if(istrue(toenable)) {
    teamplayers = getteamdata(targetteam, "players");

    foreach(player in teamplayers) {
      bombsite enablescriptableplayeruse(player);
    }

    return;
  }

  teamplayers = getteamdata(targetteam, "players");

  foreach(player in teamplayers) {
    bombsite disablescriptableplayeruse(player);
  }
}

function function_1ee7685e35f26553(player) {
  bombsite = self;
  bombsite.targetplayer = player;
  bombsite.targetteam = player.team;
}

function function_84c4d0a19073a1ca(alive) {
  bombsite = self;

  if(!istrue(alive)) {
    return bombsite.targetplayer;
  }

  backupplayer = undefined;
  teammates = getteamdata(bombsite.targetteam, "players");

  foreach(player in teammates) {
    if(!isDefined(backupplayer)) {
      backupplayer = player;
    }

    if(isalive(player) && !isbot(player)) {
      return player;
    }
  }

  return backupplayer;
}

function function_3a3999f7f98a09ba() {
  bombsite = self;
  teammates = getteamdata(bombsite.targetteam, "players");

  foreach(player in teammates) {
    if(isDefined(player) && bombsite.targetplayer != player) {
      bombsite function_1ee7685e35f26553(player);
      return;
    }
  }

  bombsite.targetplayer = undefined;
}

function function_9ad2b2a571d4cdc9(newstate, partname) {
  bombsite = self;

  if(!isDefined(partname)) {
    partname = "arrow_bombsite_body";
  }

  bombsite setscriptablepartstate(partname, newstate);
}

function function_e15f6a723c77f629(position) {
  contents = scripts\engine\trace::function_b88b8bd51ea7fe24();
  result = scripts\mp\gametypes\br_public::raytraceoffset(position, 0, 0, 1000, -1000, contents);
  var_27a7f36bdddb2e67 = undefined;

  if(result["hittype"] != "hittype_none") {
    var_27a7f36bdddb2e67 = result["position"];
    underwaterdepth = max(0, var_27a7f36bdddb2e67[2] - position[2]);
    return underwaterdepth;
  }

  return 0;
}

function function_3d1149dbecb9e203(origin, angles) {
  bombsite = self;

  if(level.arrow.dvars.var_31c2e1a85fb84fb5 > 0) {
    navmeshpoint = getclosestpointonnavmesh(origin);

    if(isDefined(navmeshpoint)) {
      var_751fa541b7b026d1 = level.arrow.dvars.var_31c2e1a85fb84fb5 * level.arrow.dvars.var_31c2e1a85fb84fb5;

      if(distancesquared(navmeshpoint, origin) <= var_751fa541b7b026d1) {
        isvalid = !istrue(level.arrow.dvars.var_a8dfc18f42b04ea3);

        if(!isvalid) {
          var_463030cf175994a4 = (0, 0, 45);
          contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
          result = scripts\engine\trace::ray_trace(origin + var_463030cf175994a4, navmeshpoint + var_463030cf175994a4, undefined, contents);
          isvalid = isDefined(result) && result["hittype"] == "hittype_none";
        }

        if(isvalid) {
          origin = navmeshpoint;
        }
      }
    }
  }

  if(level.arrow.dvars.var_218bc5767126bb7a > 0) {
    ignoreent = level.arrow.props.crate;
    ground = function_8edba3d30393649(origin, ignoreent);

    if(abs(ground.origin[2] - origin[2]) <= level.arrow.dvars.var_218bc5767126bb7a) {
      origin = ground.origin;
      angles = ground.angles;
    }
  }

  bombsite.origin = origin;
  bombsite.angles = angles;

  if(level.arrow.dvars.var_6e608be85a24080b > 0) {
    underwaterdepth = function_e15f6a723c77f629(origin);

    if(underwaterdepth > level.arrow.dvars.var_6e608be85a24080b) {
      function_9c74ccdaa1e15c02("bombsite_spawn_error");
    }
  }

  if(istrue(level.arrow.dvars.var_45b2296f6f91a215)) {
    if(scripts\mp\outofbounds::ispointinoutofbounds(origin)) {
      function_9c74ccdaa1e15c02("bombsite_spawn_error");
    }
  }
}

function function_38342968b751d11b(player) {
  bombsite = self;
  spawnorigin = function_bad6109ac2ac3e6e(player);
  assertex(isDefined(spawnorigin), "<dev string:x370>");

  if(!isDefined(spawnorigin)) {
    function_9c74ccdaa1e15c02("bombsite_spawn_error");
    return undefined;
  }

  return spawnorigin;
}

function function_bad6109ac2ac3e6e(player) {
  if(istrue(level.arrow.dvars.debug)) {
    return (player.origin + anglesToForward(player.angles) * level.arrow.dvars.var_88faa6a3ed6b5d4c);
  }

  if(level.arrow.dvars.var_4c57a2f7bb2c52b8 == 1) {
    return function_27a225332e2ecdae();
  }

  level.arrow.bombsitelocations = array_randomize(level.arrow.bombsitelocations);

  foreach(location in level.arrow.bombsitelocations) {
    if(scripts\mp\gametypes\br_circle::ispointinnextsafecircle(location)) {
      return location;
    }
  }

  if(level.arrow.dvars.var_4c57a2f7bb2c52b8 == 2) {
    return function_27a225332e2ecdae();
  }

  return undefined;
}

function function_27a225332e2ecdae() {
  origin = scripts\mp\gametypes\br_circle::getnextsafecircleorigin();

  if(level.arrow.dvars.var_fff72f4d008b3ea6 < 0) {
    return origin;
  }

  contents = create_contents(0, 1, 1, 1, 0, 0, 1, 1, 1);
  result = scripts\engine\trace::ray_trace(origin + (0, 0, 3000), origin, undefined, contents);
  location = ter_op(result["fraction"] == 1, origin, result["position"]);
  location = getclosestpointonnavmesh(location, level.arrow.dvars.var_fff72f4d008b3ea6);
  radius = scripts\mp\gametypes\br_circle::getnextsafecircleradius();

  if(distance2dsquared(origin, location) < radius * radius) {
    origin = location;
  }

  return origin;
}

function function_7e1fe16d6e3919a(elementicons, playintro, showdistance) {
  bombsite = self;
  bombsite function_68ef3e106ab2d16b(undefined, bombsite.targetteam, "ui_map_icon_elite_bomb_site", "hud_icon_objective_elite_radioactive_red");
  originoffset = vectorNormalize(anglestoup(bombsite.angles)) * 35;
  bombsite function_3b7130b58a7c77b3("ground", bombsite, istrue(playintro), istrue(showdistance), originoffset);
  bombsite function_d05fd62000ddcfb3(elementicons);
}

function function_d05fd62000ddcfb3(elementicons) {
  bombsite = self;

  if(!istrue(elementicons)) {
    return;
  }

  bombsite.elementicons = [];
  zoffset = 25;
  xoffset = -7;

  for(i = 0; i < bombsite.neededelements.size; i++) {
    if(bombsite.neededelements[i] > 0) {
      continue;
    }

    bombsite.elementicons[i] = spawnStruct();
    bombsite.elementicons[i] function_68ef3e106ab2d16b(undefined, bombsite.targetteam, "ui_map_icon_elite_bomb_site", undefined);
    offsetdist = (xoffset, 0, zoffset);
    bombsite.elementicons[i] function_3b7130b58a7c77b3("ground", bombsite, 0, 0, offsetdist);
    xoffset += 7;
  }
}

function function_32041f48a2a2e73c(player, isvisible) {
  bombsite = level.arrow.props.bombsite;
  bombsite function_b63a22f9943a3ae8(player, isvisible);

  if(isDefined(bombsite.elementicons)) {
    foreach(elementicon in bombsite.elementicons) {
      elementicon function_b63a22f9943a3ae8(player, isvisible);
    }
  }
}

function function_eaf22a1a752cc819(elementid) {
  bombsite = self;
  bombsite notify("screen_update");
  bombsite endon("screen_update");
  bombsite endon("death");
  level endon("game_ended");

  while(true) {
    bombsite function_9ad2b2a571d4cdc9("blank", "arrow_bombsite_screen");

    if(istrue(bombsite.disarmed)) {
      bombsite function_9ad2b2a571d4cdc9("disarmed", "arrow_bombsite_screen");
    } else if(istrue(bombsite.detonated)) {} else if(istrue(bombsite.var_27db4eb198cd48b9)) {
      bombsite function_9ad2b2a571d4cdc9("armed", "arrow_bombsite_screen");
    } else if(istrue(bombsite.var_dc0258a29dc9faf1)) {
      bombsite function_9ad2b2a571d4cdc9("arming", "arrow_bombsite_screen");
    } else {
      if(isDefined(elementid)) {
        bombsite function_9ad2b2a571d4cdc9(function_6844602f3120e900(elementid, 9), "arrow_bombsite_screen");
        elementid = undefined;
      } else {
        bombsite function_9ad2b2a571d4cdc9("deposit", "arrow_bombsite_screen");
      }

      waitframe();

      foreach(tag, element in bombsite.neededelements) {
        if(istrue(element)) {
          bombsite function_9ad2b2a571d4cdc9(function_6844602f3120e900(tag, 10), "arrow_bombsite_screen");
          waitframe();
        }
      }
    }

    wait 2;
  }
}

function arrow_bombsitereveal(player, elementicons) {
  bombsite = self;
  teaminfo = level.arrow.teaminfo[player.team];
  level endon("game_ended");
  bombsite endon("on_end_bombsite");
  teaminfo.state = 2;
  function_566ebf0873178b74(&"BR_ELITE_BROKEN_ARROW/WAITING_BOMB");
  function_20238d522c76fb01();

  if(istrue(bombsite.dropping)) {
    return;
  }

  bombsite.dropping = 1;
  bombsite function_9ad2b2a571d4cdc9("deposit");
  bombsite function_1ee7685e35f26553(player);
  bombsite thread function_eaf22a1a752cc819();
  spawnorigin = function_38342968b751d11b(player);

  if(!isDefined(spawnorigin)) {
    return;
  }

  function_25c7990b2f530ce2();
  bombsite function_8fc5a3e09e9f5078(spawnorigin, player);
  function_518587a0c6c54232();
  teaminfo function_4da2fedd08554c6e("arrow_bombsite_team", 3);
  teaminfo function_bf0175f3bb67a26d("arrow_bombsite_reveal", 3, 1);
  bombsite.siterevealed = 1;
  bombsite.spawntime = gettime();
  bombsite function_a0ddad612cbe0349();
  bombsite function_176fe0789723e9bd(elementicons);
  function_5a414c2bda5f666b(level.arrow.dvars.bombsitetime);
  bombsite thread function_a66a455d9266f65d();

  if(teaminfo function_1a9ee6a7092d4536()) {
    teaminfo.state = 3;
    function_566ebf0873178b74(&"BR_ELITE_BROKEN_ARROW/DEPOSIT_ELEMS");
  }

  function_20238d522c76fb01();
  function_5e7fdf58f111f041();
}

function function_25c7990b2f530ce2() {
  if(istrue(level.arrow.dvars.var_b303983f30cb3658)) {
    return;
  }

  foreach(teamref, teamdata in level.teamdata) {
    if(function_2eac770cf8006e0b(teamref)) {
      showsplashtoteam(teamref, function_130af1b9f6740479("elite_arrow_bomb_revealed"));
    }
  }
}

function function_518587a0c6c54232() {
  if(istrue(level.arrow.dvars.var_b303983f30cb3658)) {
    return;
  }

  foreach(teamref, teamdata in level.teamdata) {
    if(!function_2eac770cf8006e0b(teamref)) {
      showsplashtoteam(teamref, function_130af1b9f6740479("elite_arrow_bomb_revealed_global"));
    }
  }
}

function function_8fc5a3e09e9f5078(spawnorigin, player) {
  bombsite = self;
  level endon("game_ended");
  bombsite endon("death");

  if(istrue(level.arrow.dvars.bombsitesupplydrop)) {
    foreach(activeteam in level.arrow.teaminfo) {
      if(activeteam.state == 0) {
        continue;
      }

      activeteam function_6af5ded34f8c79be();
    }

    scripts\mp\gametypes\br_supply_drops_common::function_1a01863a6ec2ad05(spawnorigin, "br_elite_arrow_bombsite_drop");
    bombsite thread function_51890f7f9a9bf31c();
    bombsite waittill("arrow_finish_bombsite_reveal");
    return;
  }

  bombsite function_3d1149dbecb9e203(spawnorigin, player.angles);
}

function function_a0ddad612cbe0349() {
  bombsite = self;
  bombsite function_e5c04edc3287e3f(0);

  foreach(activeteam in level.arrow.teaminfo) {
    if(activeteam.state == 0) {
      continue;
    }

    bombsite function_e5c04edc3287e3f(1, activeteam.targetteam);
  }
}

function function_176fe0789723e9bd(elementicons) {
  bombsite = self;
  bombsite function_7e1fe16d6e3919a(elementicons, 1, 1);

  foreach(activeteam in level.arrow.teaminfo) {
    if(activeteam.state == 0) {
      continue;
    }

    function_a0a60c2df22298d9(activeteam.targetteam, 1);
  }
}

function arrow_bombsitearm(player) {
  bombsite = self;
  teaminfo = level.arrow.teaminfo[player.team];
  teaminfo.state = 4;
  bombsite function_3570eaa3344a147c();
  function_566ebf0873178b74(&"BR_ELITE_BROKEN_ARROW/ARM_THE_BOMB");
  function_20238d522c76fb01();
  function_5e7fdf58f111f041();

  if(istrue(bombsite.var_dc0258a29dc9faf1)) {
    return;
  }

  bombsite.var_dc0258a29dc9faf1 = 1;
  bombsite thread function_eaf22a1a752cc819();
  bombsite arrow_arm(player);
}

function function_3570eaa3344a147c() {
  bombsite = self;
  bombsite function_e5c04edc3287e3f(0);

  if(istrue(level.arrow.dvars.var_c42b7c38a37d8f06)) {
    bombsite function_e5c04edc3287e3f(1);
    return;
  }

  foreach(activeteam in level.arrow.teaminfo) {
    if(activeteam.state == 0) {
      continue;
    }

    bombsite function_e5c04edc3287e3f(1, activeteam.targetteam);
  }
}

function function_c0e9e9c23f5b3f14(player) {
  bombsite = self;
  teaminfo = level.arrow.teaminfo[player.team];
  teaminfo.state = 5;

  if(istrue(bombsite.var_27db4eb198cd48b9)) {
    return;
  }

  bombsite.var_27db4eb198cd48b9 = 1;
  bombsite function_9ad2b2a571d4cdc9("defuse");
  bombsite thread function_eaf22a1a752cc819();
  fusetimer = level.arrow.dvars.fusetimer;

  if(isDefined(level.arrow.dvars.var_c6020d9f48812bed)) {
    fusetimer = level.arrow.dvars.var_c6020d9f48812bed;
  }

  function_57d38c13bed22262(fusetimer, teaminfo);
  bombsite function_c3dd1d53419783be(teaminfo);
  bombsite function_90056b14a57b07ee();
  teaminfo function_b63894955a03d82b(player);
  bombsite function_44a546d3987c1686();
  bombsite function_2156c23e5afc6d06();
  bombsite arrow_fuse(player);
  function_259dd894cba599e8();
}

function function_57d38c13bed22262(timer, teaminfo) {
  bombsite = self;
  function_5a414c2bda5f666b(timer);
  bombsite thread function_e035378c608f9511(int(timer - 1), 0);
  teaminfo function_5cf6ab54f8852b93(int(timer));
  function_20238d522c76fb01();
  function_5e7fdf58f111f041();
}

function function_c3dd1d53419783be(teaminfo) {
  bombsite = self;

  foreach(otherteam in level.arrow.teaminfo) {
    if(otherteam == teaminfo) {
      continue;
    }

    otherteam thread function_88a043b99a75e47("enemy_armed_bomb");
  }
}

function function_90056b14a57b07ee() {
  bombsite = self;
  musicplayers = scripts\mp\music_and_dialog::function_aecafe54c65c0e35(level.players);
  var_1933aef6359f408c = function_17ee301cf0b5ba85("br_cq_bomb_armed");
  var_c3e230fda23ad937 = function_17ee301cf0b5ba85("br_cq_bomb_armed_classic");
  function_fe75a89529dd0fd0(musicplayers, var_1933aef6359f408c, undefined, undefined, var_c3e230fda23ad937);
}

function function_b63894955a03d82b(player) {
  teaminfo = self;

  if(istrue(level.arrow.dvars.var_b303983f30cb3658)) {
    return;
  }

  showsplashtoteam(teaminfo.targetteam, function_130af1b9f6740479("elite_arrow_bomb_defend"), undefined, player);
  showsplashtoallexceptteam(teaminfo.targetteam, function_130af1b9f6740479("elite_arrow_bomb_defuse"), undefined, player);
}

function function_44a546d3987c1686() {
  bombsite = self;

  if(istrue(level.arrow.dvars.debugdefuse)) {
    bombsite function_e5c04edc3287e3f(1);
    return;
  }

  bombsite function_e5c04edc3287e3f(0, bombsite.targetteam, 1);
}

function function_a66a455d9266f65d() {
  bombsite = self;
  level endon("game_ended");
  timer = level.arrow.dvars.bombsitetime;

  foreach(teaminfo in level.arrow.teaminfo) {
    teaminfo function_8bef76d7d75916b6(timer);
  }

  result = bombsite waittill_any_timeout_2(timer, "arm_complete", "on_end_bombsite");

  foreach(teaminfo in level.arrow.teaminfo) {
    teaminfo function_9de2e8c510281719();
  }

  if(isDefined(result) && result == "timeout") {
    if(isDefined(bombsite.arment) && istrue(bombsite.arment.inuse)) {
      result2 = bombsite.arment waittill_any_return_2("trigger_success", "trigger_fail");

      if(result2 == "trigger_success") {
        return;
      } else {
        waitframe();
      }
    }

    function_9c74ccdaa1e15c02("bombsite_timed_out");
  }
}

function function_26f148b3e91e1fe9() {
  thread function_9c74ccdaa1e15c02("bombsite_deleted_in_area_swap");
  return true;
}

function function_5a414c2bda5f666b(durationseconds) {
  level.arrow.bombsitetimestamp = int(gettime() + function_a5b14435e3229bed(durationseconds));
}

function function_3fb6126945208e3e() {
  bombsitetimestamp = default_to(level.arrow.bombsitetimestamp, gettime());
  timeleftms = max(0, bombsitetimestamp - gettime());
  return int(round(function_c89ed1840c8d0f0f(timeleftms)));
}

function function_758f95fb5cf87d1b() {
  bombsite = self;

  if(istrue(bombsite.skiptonuke)) {
    return;
  }

  bombsite.skiptonuke = 1;
  level.arrow.dvars.var_c6020d9f48812bed = 7;
  player = function_84c4d0a19073a1ca(1);

  if(function_ce3e8c8b6de2ca1b()) {
    if(function_3fb6126945208e3e() <= 7) {
      return;
    }

    teaminfo = level.arrow.teaminfo[player.team];
    bombsite function_57d38c13bed22262(level.arrow.dvars.var_c6020d9f48812bed, teaminfo);
    bombsite thread function_f7b9661a3753da9(bombsite.fuseent);
    return;
  }

  bombsite thread function_c0e9e9c23f5b3f14(player);
}

function function_90692628e3f5a1c1() {
  dropstruct = self;
  dropstruct.var_2e0d8ba0a46ce1b1 = 1;
  dropstruct.var_3077f6d3d97bb34b = getdvarint(@ "hash_83026ae3da184b2d", 1000);
  dropstruct.var_3c3ed534c61a56e4 = getdvarint(@ "hash_71b0625ba447d37a", 100);
  dropstruct.var_9612b650d147f458 = getdvarint(@ "hash_dde9024816a0b75a", 200);
  dropstruct.var_81986b2d8e843970 = getdvarint(@ "hash_e4a0734d3e02bac7", 562500);
  dropstruct.initialmove = 0;
  dropstruct.spawnsmoke = 0;
  dropstruct.var_322b7887f80acc62 = 1;
  dropstruct.var_f453aecd14b7f921 = 1;
}

function function_51890f7f9a9bf31c() {
  bombsite = self;
  level endon("game_ended");
  bombsite endon("death");
  level waittill("arrow_bombsite_drop_landed");
  crate = level.arrow.props.crate;

  if(!isDefined(crate)) {
    return;
  }

  spawninfo = function_8edba3d30393649(crate.origin, [crate]);
  bombsite function_3d1149dbecb9e203(spawninfo.origin, spawninfo.angles);
  bombsite notify("arrow_finish_bombsite_reveal");
}

function function_8992a7892fe3a42c(dropend) {
  dropstart = dropend + (0, 0, level.var_5d2af95280a3cf58);
  angles = (0, 0, 0);
  crate = scripts\cp_mp\killstreaks\airdrop::createcrate(undefined, undefined, "elite_arrow_bombsite", dropstart, angles, dropend, undefined, 1);
  crate function_ce3306faf9cce45d();
  level.arrow.props.crate = crate;
  return crate;
}

function function_ce3306faf9cce45d() {
  crate = self;
  crate function_68ef3e106ab2d16b(undefined, undefined, "ui_map_icon_elite_bomb_site", undefined);

  foreach(activeteam in level.arrow.teaminfo) {
    crate function_1b390a39ac7ec281(activeteam.targetteam, 1);
  }

  crate function_3b7130b58a7c77b3("player", crate, 0, 0);
}

function function_f2697d44d12a9e3e(player, isvisible) {
  if(!isDefined(level.arrow) || !isDefined(level.arrow.props.crate)) {
    return;
  }

  crate = level.arrow.props.crate;
  crate function_b63a22f9943a3ae8(player, isvisible);
}

function function_f19fdce841e05d0d(dropend, dropstruct) {
  crate = self;
  wait 2;
  crate scripts\mp\gametypes\br_supply_drops_common::function_7dec3b199d2e73b8(dropend, dropstruct);
  endtime = gettime() + 20000;

  while(gettime() < endtime) {
    bodyid = crate physics_getbodyid(0);
    velocity = physics_getbodylinvel(bodyid);

    if(lengthsquared(velocity) <= 0.5) {
      break;
    }

    waitframe();
  }

  wait 1.5;
  crate setscriptablepartstate("dmz_supply_drop", "fully_opening_unusable");
  crate function_231aae2264ce7f2e();

  if(isDefined(crate.smokesignal)) {
    crate.smokesignal delete();
  }

  level notify("arrow_bombsite_drop_landed");
}

function function_62173f65f7672ddc() {
  thread function_9c74ccdaa1e15c02("supply_drop_deleted_in_area_swap");
  return true;
}

function function_e035378c608f9511(fusetimer, delay) {
  bombsite = self;
  bombsite notify("nuke_countdown");
  bombsite endon("nuke_countdown");
  level endon("game_ended");
  bombsite thread function_ed670aa9479cc141(fusetimer);
  level thread function_659a7f8045916418(fusetimer);

  if(isDefined(delay)) {
    wait delay;
  }

  level thread function_d9c364004b765531(fusetimer);
  starttime = gettime();
  endtime = fusetimer * 1000 + starttime;
  bombsite.bombendtime = endtime;
  bombsite waittill_any_timeout_1(fusetimer, "on_end_bombsite");
}

function function_d9c364004b765531(var_7c8eacb31be5e568) {
  if(isDefined(level.arrow.transientloaded) || !istrue(level.arrow.dvars.var_c86c4de4e54401e1) || !istrue(level.arrow.dvars.var_6e6566e8c4d099fb)) {
    return;
  }

  var_991e17f3d18516b6 = getdvarfloat(@ "bg_transients_infil_maxloadingtime") + 0.05;
  var_619e50e50a1763bc = var_7c8eacb31be5e568 - var_991e17f3d18516b6;

  if(var_619e50e50a1763bc > 0) {
    wait var_619e50e50a1763bc;
  }

  thread function_ba362ff77cb55d00();
}

function function_ba362ff77cb55d00() {
  if(isDefined(level.arrow.transientloaded)) {
    return;
  }

  level.arrow.transientloaded = 0;
  transientname = namespace_91542927cd719085::function_aafaf24d80927b02();
  loadinfiltransient(transientname);

  for(var_24b79087f3897e94 = 0; !var_24b79087f3897e94; var_24b79087f3897e94 = isinfiltransientloaded(transientname)) {
    waitframe();
  }

  level.arrow.transientloaded = 1;
}

function function_818377520915c3cf(origin, soundalias, delay) {
  delay = default_to(delay, 0);
  wait delay;
  ent = spawn("script_model", origin);
  ent forcenetfieldhighlod(1);
  waitframe();
  ent playLoopSound(soundalias);
  level waittill_any_timeout_2(39.9, "nuke_detonated");
  ent stoploopsound();
  waitframe();
  ent delete();
}

function function_659a7f8045916418(fusetimer) {
  level endon("nuke_detonated");
  var_10f6d49f1c8ab708[0] = [58.5, "mx_mp_br_cq_bombcountdown_1", "mx_mp_br_cq_bomb_defuse_1"];
  musicindex = 0;
  assertex(musicindex >= 0 && musicindex < var_10f6d49f1c8ab708.size, "<dev string:x3b9>");
  countdowntime = var_10f6d49f1c8ab708[musicindex][0];
  countdownstate = var_10f6d49f1c8ab708[musicindex][1];
  defusestate = var_10f6d49f1c8ab708[musicindex][2];
  fusewaittime = fusetimer - countdowntime - 1.5;
  var_c020952f2597d1e6 = "mx_mp_br_cq_bombcountdown1_classic";
  var_a6c907e927acb9c7 = "mx_mp_br_cq_bomb_defuse_1_classic";

  if(fusewaittime < 0) {
    return;
  }

  wait fusewaittime;
  musicplayers = scripts\mp\music_and_dialog::function_aecafe54c65c0e35(level.players);
  function_fe75a89529dd0fd0(musicplayers, countdownstate, undefined, undefined, var_c020952f2597d1e6);
  level waittill("nuke_aborted");
  musicplayers = scripts\mp\music_and_dialog::function_aecafe54c65c0e35(level.players);
  function_fe75a89529dd0fd0(musicplayers, defusestate, undefined, undefined, var_a6c907e927acb9c7);
}

function function_62c2be95f7824d41() {
  bombsite = self;
  var_1930ffbbf1b6164e = bombsite.origin + (0, 0, 60);
  wait 0.4;
  playsoundatpos(var_1930ffbbf1b6164e, "evt_br_portable_nuke_detonation_plunger");
}

function function_ed670aa9479cc141(fusetimer) {
  bombsite = self;
  level endon("game_ended");
  level endon("nuke_aborted");
  inttimer = int(fusetimer);
  fractimer = fusetimer - inttimer;
  timer = inttimer;
  teaminfo = level.arrow.teaminfo[bombsite.targetteam];
  wait fractimer;

  while(timer > 0) {
    soundalias = "";
    var_c7eda8c7ee5c0b46 = timer % 30;

    if(timer <= 60) {
      var_c7eda8c7ee5c0b46 = timer % 10;
    }

    if(timer == 31) {
      origin1 = (3456, 48128, 5760);
      thread function_818377520915c3cf(origin1, "evt_br_nuke_siren_dist", 0);
      origin2 = (-52160, 5304, 5760);
      thread function_818377520915c3cf(origin2, "evt_br_nuke_siren_dist", 3);
      teaminfo function_bf0175f3bb67a26d("arrow_detonation_warning");
    }

    if(timer == 5) {
      if(istrue(level.arrow.dvars.debug)) {
        level.arrow.dvars.var_b303983f30cb3658 = 0;
      }

      level thread function_69ae8ab0c2db4623(0.4);
    }

    if(timer == 3) {
      function_4e8ba327eb12540c(level.players, "br_elite_contract_ending", 3);
    }

    if(timer == 2) {
      bombsite thread function_62c2be95f7824d41();
    }

    if(timer == 30 || timer == 20) {
      soundalias = "evt_br_nuke_bomb_timer_urgent";
    } else if(timer <= 10) {
      soundalias = "evt_br_nuke_bomb_timer_urgent";
    } else if(timer <= 30) {
      soundalias = "evt_br_nuke_bomb_timer";
    } else if(var_c7eda8c7ee5c0b46 == 0) {
      soundalias = "evt_br_nuke_bomb_timer_reminder";
    }

    if(soundalias != "") {
      function_7acde5feb50c98f2(level.players, soundalias);
    }

    timer -= 1;
    wait 1;
  }
}

function function_102a65e0b585135b(bombsite) {
  function_7acde5feb50c98f2(level.players, "evt_br_elite_arrow_nuke_explo");
}

function arrow_blank(winner) {}

function function_b308a39503f00abf() {
  bombsite = self;
  level.var_57ece26e490ad8c4 = 1;
  level.shownonspectatingwinnersplash = 1;
  level endon("game_ended");
  owner = bombsite function_84c4d0a19073a1ca();

  if(istrue(level.arrow.dvars.var_6e6566e8c4d099fb)) {
    level.var_79c116f876dc27eb = undefined;
    level.br_endgamesplashcallback = &arrow_blank;
    level.var_3aa0c134e5099b90 = 1;
    level thread scripts\mp\gametypes\br_ending_util::function_3681a4700f5bb7c1(0, 0.066, "nuke_fadeEnd");
    function_4e8ba327eb12540c(level.players, "mp_killstreak_nuke", 0);
    delaythread(1, &function_7acde5feb50c98f2, level.players, "evt_br_cq_detonation_flyby_heli_incoming");
  } else {
    level.mercywintriggered = 1;
    streakinfo = function_51f812f559785ee2(owner);
    function_ccf25836cbfa32e4();
    level thread function_102a65e0b585135b(bombsite);
    bombsite function_fd06a1bbf48d3fca(owner, streakinfo);
    level.var_79c116f876dc27eb = &function_42d4aafb1b78c3ba;
  }

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    player _freezecontrols(1, undefined, "cq_nuke");
    player utility::hidehudenable();
  }

  level thread endgame(owner.team, game["end_reason"]["nuke_end"], undefined, 1, 1);
}

function function_51f812f559785ee2(owner) {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("nuke", owner);
  streakinfo.var_3dabfa23bef362b5 = 1;
  streakinfo.skipequippedstreakcheck = 1;

  if(istrue(level.arrow.dvars.nukevision)) {
    streakinfo.var_93dbd6174ca50e88 = 1;
    streakinfo.skipvision = 1;
    streakinfo.var_e723bc4541254543 = 1;
    streakinfo.skipexplosion = 1;
  }

  owner scripts\cp_mp\killstreaks\nuke::tryusenukefromstruct(streakinfo);
  return streakinfo;
}

function function_ccf25836cbfa32e4() {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    player.ignoredeathsdoor = 1;
    player scripts\mp\gametypes\br_public::function_179a8d5a185dfb56(1);
  }
}

function function_fd06a1bbf48d3fca(owner, streakinfo) {
  bombsite = self;

  if(istrue(level.arrow.dvars.nukevision)) {
    bombsite function_ee09e2caaf92caa(owner, streakinfo);
    return;
  }

  wait 7.5;
}

function function_ee09e2caaf92caa(owner, streakinfo) {
  bombsite = self;

  foreach(player in level.players) {
    if(!isPlayer(player) || !isalive(player)) {
      continue;
    }

    percent = 0;
    bombsite thread function_71bde23f6e0aa583(player, percent, owner, streakinfo);
  }

  if(!istrue(level.arrow.dvars.var_6e6566e8c4d099fb)) {
    function_19d232c72b0827e3();
  }
}

function function_71bde23f6e0aa583(player, percent, owner, streakinfo) {
  bombsite = self;
  level endon("game_ended");
  player function_36f999a7c7ed0d32(1, "nuke_champ_quest_flash", 0.1);
  wait 0.1;
  player function_36f999a7c7ed0d32(1, "", 0.9);
  player function_36f999a7c7ed0d32(1, "nuke_champ_quest_death", 0.9);
}

function function_19d232c72b0827e3() {
  wait 0.1;
  setomnvarforallclients("post_game_state", 11);
  wait 1.9;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    level thread fadetoblackforplayer(player, 1, 0.1);
  }
}

function function_42d4aafb1b78c3ba(winnerplayers, var_f7b694a4edf7dc9a) {
  level thread function_5aeb021930ca58de();
}

function function_5aeb021930ca58de() {
  level endon("game_ended");
  wait 0.75;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    player setclientomnvar("ui_world_fade", 1);
    level thread fadetoblackforplayer(player, 0, 0.1);
  }
}

function function_e73cbd9a52431832() {
  setomnvarforallclients("post_game_state", 13);
  setomnvarforallclients("ui_br_bink_overlay_state", 13);
  var_41ecb8ea1741d13c = "mp_br_elite_arrow_nuke_saba";

  if(issharedfuncdefined("eliteArrow", "getNukeBink")) {
    var_41ecb8ea1741d13c = [[getsharedfunc("eliteArrow", "getNukeBink")]]();
  }

  playcinematicforall(var_41ecb8ea1741d13c);
}

function function_f6e0bdd81a472b97(winnerplayers) {
  if(istrue(level.arrow.dvars.var_6e6566e8c4d099fb)) {
    level.var_d81f9416f44ab4ba = spawnStruct();
    level.var_d81f9416f44ab4ba.var_747d19faf68a7748 = "cq_nuke";
    scripts\mp\gametypes\br_ending::play_ending(winnerplayers);
    return;
  }

  function_8d5f53049d922a79(winnerplayers);
}

function function_8d5f53049d922a79(winnerplayers) {
  function_4e8ba327eb12540c(level.players, "mp_killstreak_nuke", 6);
  wait 6.1;
  function_e73cbd9a52431832();
  wait 2;
  function_8b24245302adc601(winnerplayers);
  setomnvarforallclients("ui_br_elite_arrow_aar_state", 1);
  wait 5;
  setomnvarforallclients("ui_br_elite_arrow_aar_state", 2);
  wait 2;

  if(!scripts\mp\gametypes\br_public::isanytutorialorbotpracticematch()) {
    setomnvarforallclients("ui_br_end_game_splash_type", 17);
  }

  wait 1;
  setomnvarforallclients("post_game_state", 14);
  wait 10;
}

function function_8b24245302adc601(winners) {
  namespace_ab7fb53f62c7ae2e::function_74497a0f417e329f(winners);
  scripts\mp\gametypes\br_ending::function_226b83f846d32ff2(winners);
}

function function_9e8981ef0c238dd0() {
  teammates = scripts\mp\utility\teams::getteamdata(self.team, "players");
  lootid = level.br_pickups.var_7b2bff2d04ee1017["brloot_plunder_cash_uncommon_1"];

  foreach(teammate in teammates) {
    if(isDefined(lootid)) {
      view_origin = teammate getvieworigin();
      teammate scripts\mp\gametypes\br_pickups::function_37be6e543436f3b3(lootid, view_origin, 1, level.arrow.dvars.var_41df90bb27aa4b6f);
    }

    teammate thread scripts\mp\utility\points::doscoreevent(#"hash_4ebc44521d9a1b18");
    teammate scripts\mp\gametypes\br_plunder::playerplunderpickup(level.arrow.dvars.var_41df90bb27aa4b6f);
  }
}

function function_e01bc5dba2da7d6a(victim) {
  if(!isDefined(level.arrow.teaminfo[victim.team])) {
    return;
  }

  teaminfo = level.arrow.teaminfo[victim.team];
  xpreward = level.arrow.dvars.var_895d3e780c654e27;
  plunderreward = level.arrow.dvars.var_b01d54f0ea63bfb3;

  if(teaminfo.state == 5) {
    xpreward *= level.arrow.dvars.var_a1c716e522c46b09;
    plunderreward += level.arrow.dvars.var_b983f90ab46b22a6 * 5;
  } else {
    stepscompleted = teaminfo.firstpickups;

    if(teaminfo.state == 4) {
      stepscompleted++;
    }

    xpreward *= 1 + level.arrow.dvars.var_36b827b9c3105fdb * stepscompleted;
    plunderreward += level.arrow.dvars.var_b983f90ab46b22a6 * stepscompleted;
  }

  lootid = level.br_pickups.var_7b2bff2d04ee1017["brloot_plunder_cash_uncommon_1"];

  if(isDefined(lootid)) {
    view_origin = self getvieworigin();
    scripts\mp\gametypes\br_pickups::function_37be6e543436f3b3(lootid, view_origin, 1, plunderreward);
  }

  thread scripts\mp\utility\points::doscoreevent(#"hash_8677b7ba02f174e2", undefined, undefined, xpreward);
  scripts\mp\gametypes\br_plunder::playerplunderpickup(plunderreward);
}

function arrow_arm(player) {
  bombsite = self;
  usetime = level.arrow.dvars.armtime;
  decayrate = level.arrow.dvars.var_dd475d11757ad803;
  endconditions = [];
  bombsite.arment = function_ffa4b010cb5f82dc(bombsite, "elite_arrow_arm", usetime, decayrate, endconditions, player);
  bombsite.arment.triggercomplete = &function_bc1add9d6b949cdc;
  bombsite function_1ca195a0e80a83b();
  bombsite thread function_cd7c81fd616e8339(bombsite.arment);
}

function function_1ca195a0e80a83b() {
  bombsite = self;

  if(!isDefined(bombsite.arment)) {
    return;
  }

  if(istrue(level.arrow.dvars.var_c42b7c38a37d8f06)) {
    foreach(player in level.players) {
      bombsite.arment function_f025be1cbf898d23(player, 1);
    }

    return;
  }

  foreach(activeteam in level.arrow.teaminfo) {
    if(activeteam.state == 0) {
      continue;
    }

    bombsite.arment function_3ae40bb839dc4aea(activeteam.targetteam, 1);
  }
}

function function_cd7c81fd616e8339(arment) {
  bombsite = self;
  level endon("game_ended");
  bombsite endon("arm_complete");

  while(true) {
    arment waittill("trigger_start");
    bombsite function_1ee7685e35f26553(arment.lastuser);
  }
}

function function_bc1add9d6b949cdc(result) {
  bombsite = self;
  level endon("game_ended");
  bombsite notify("arm_complete");

  if(result == "trigger_done") {
    player = bombsite.arment.lastuser;
    teaminfo = level.arrow.teaminfo[player.team];
    scripts\mp\gametypes\br_analytics::function_523b126aa6b63c7(player, gettime() - bombsite.spawntime);
    bombsite function_1ee7685e35f26553(player);
    teaminfo function_4da2fedd08554c6e("arrow_bombsite_arm", 5);
    teaminfo function_bf0175f3bb67a26d("arrow_bombsite_arm_enemy", 5);
    waitframe();
    bombsite function_c0e9e9c23f5b3f14(player);
    return;
  }

  function_9c74ccdaa1e15c02("arm_error");
}

function arrow_fuse(player) {
  bombsite = self;
  bombsite function_de1b7260327fef3f(player);
  bombsite function_e30e9d644d44ea47(player);
  bombsite function_1f52c10e91ed6a0();
  bombsite thread function_f7b9661a3753da9(bombsite.fuseent);
}

function function_de1b7260327fef3f(player) {
  bombsite = self;
  spawninfo = function_8edba3d30393649(player.origin);
  bombsite.briefcaseent = spawnscriptable("brloot_elite_arrow_briefcase", spawninfo.origin, spawninfo.angles);
  bombsite.briefcaseent.bombsite = bombsite;
  bombsite.briefcaseent function_523253715d93c40f("defuse");
  bombsite.briefcaseent function_68ef3e106ab2d16b("hud_icon_objective_elite_radioactive_red");
  bombsite.briefcaseent function_3b7130b58a7c77b3("ground", bombsite.briefcaseent, 1, 1);
}

function function_e30e9d644d44ea47(player) {
  bombsite = self;
  usetime = level.arrow.dvars.defusetime;
  decayrate = level.arrow.dvars.var_e5ad956128dc4da1;
  endconditions = ["fuse_detonated", "fuse_cancelled"];
  bombsite.fuseent = function_ffa4b010cb5f82dc(bombsite.briefcaseent, "elite_arrow_fuse", usetime, decayrate, endconditions, player);
  bombsite.fuseent.triggercomplete = &function_7cf677701d4a5cd1;
}

function function_1f52c10e91ed6a0() {
  bombsite = self;

  if(!isDefined(bombsite.fuseent)) {
    return;
  }

  if(istrue(level.arrow.dvars.debugdefuse)) {
    foreach(player in level.players) {
      bombsite.fuseent function_f025be1cbf898d23(player, 1);
    }

    return;
  }

  foreach(player in level.players) {
    if(isDefined(level.arrow.teaminfo[player.team]) && level.arrow.teaminfo[player.team].state >= 5) {
      bombsite.fuseent function_f025be1cbf898d23(player, 0);
      bombsite.briefcaseent disablescriptableplayeruse(player);
      continue;
    }

    bombsite.fuseent function_f025be1cbf898d23(player, 1);
  }
}

function function_523253715d93c40f(newstate) {
  briefcaseent = self;
  partname = briefcaseent function_90069777043e7833()[0];
  briefcaseent setscriptablepartstate(partname, newstate);
}

function function_999950434fe81f2e(player, isvisible) {
  if(!isDefined(level.arrow) || !isDefined(level.arrow.props.bombsite)) {
    return;
  }

  briefcaseent = level.arrow.props.bombsite.briefcaseent;

  if(!isDefined(briefcaseent)) {
    return;
  }

  briefcaseent function_b63a22f9943a3ae8(player, isvisible);
}

function function_50ae9cf898ec9ba2() {
  bombsite = self;

  if(!isDefined(bombsite.briefcaseent)) {
    return;
  }

  bombsite.briefcaseent function_523253715d93c40f("disabled");
  bombsite.briefcaseent function_231aae2264ce7f2e();
  bombsite.briefcaseent notify("death");
  bombsite.briefcaseent freescriptable();
}

function function_f7b9661a3753da9(fuseent) {
  bombsite = self;
  bombsite notify("fuse_explode_think");
  bombsite endon("fuse_explode_think");
  level endon("game_ended");
  bombsite endon("fuse_complete");

  if(fuseent.id != "elite_arrow_fuse") {
    return;
  }

  fusetimer = level.arrow.dvars.fusetimer;

  if(isDefined(level.arrow.dvars.var_c6020d9f48812bed)) {
    fusetimer = level.arrow.dvars.var_c6020d9f48812bed;
  }

  wait fusetimer;
  fuseent notify("fuse_detonated");
}

function function_7cf677701d4a5cd1(result) {
  briefcaseent = self;
  bombsite = briefcaseent.bombsite;
  bombsite notify("fuse_complete");
  bombsite function_fc97bd9a4cf8355e(result);

  if(result == "fuse_detonated") {
    bombsite.detonated = 1;
    level.arrow.endingdetonated = 1;
    player = bombsite function_84c4d0a19073a1ca();
    teaminfo = level.arrow.teaminfo[player.team];
    teaminfo thread function_88a043b99a75e47("nuke_detonated", 1);
    return;
  }

  if(result == "fuse_cancelled") {
    bombsite.disarmed = 1;
    level.arrow.var_c93fb612b08a50d1 = 1;
    var_6f3b85cd1afa4efa = undefined;
    function_9c74ccdaa1e15c02("bomb_defused", var_6f3b85cd1afa4efa);
    return;
  }

  bombsite.disarmed = 1;
  level.arrow.var_c93fb612b08a50d1 = 1;
  var_6f3b85cd1afa4efa = undefined;

  if(isDefined(bombsite.briefcaseent.lastuser)) {
    bombsite.lastuser = bombsite.briefcaseent.lastuser;
    var_6f3b85cd1afa4efa = bombsite.lastuser.team;
    level.arrow.var_a21db1ee260a96c3 = var_6f3b85cd1afa4efa;
    bombsite.lastuser function_9e8981ef0c238dd0();
    scripts\mp\gametypes\br_analytics::function_f3c107faa06dc299(bombsite.lastuser, bombsite.bombendtime - gettime());
    bombsite.lastuser scripts\mp\utility\stats::incpersstat("eliteBlocked", 1);
  }

  function_9c74ccdaa1e15c02("bomb_defused", var_6f3b85cd1afa4efa);
}

function function_fc97bd9a4cf8355e(result) {
  bombsite = self;

  if(result == "fuse_detonated") {
    player = bombsite function_84c4d0a19073a1ca();
    teaminfo = level.arrow.teaminfo[player.team];
    level thread function_dd91024f2a925430(teaminfo);
    return;
  }

  if(result == "fuse_cancelled") {
    function_3738be6fcf9fecd1("arrow_defused");
    return;
  }

  teaminfo = level.arrow.teaminfo[bombsite.targetteam];

  if(bombsite.bombendtime - gettime() <= 30000) {
    teaminfo function_bf0175f3bb67a26d("arrow_defused_under_30");
    return;
  }

  teaminfo function_bf0175f3bb67a26d("arrow_defused");
}

function function_dd91024f2a925430(teaminfo, delay) {
  delay = default_to(delay, 0.35);
  level waittill("nuke_fadeEnd");
  wait delay;
  teaminfo function_4da2fedd08554c6e("arrow_detonated", 0);
  teaminfo function_bf0175f3bb67a26d("arrow_detonated_enemy", 0);
}

function function_ffa4b010cb5f82dc(gameent, id, usetime, decayrate, endconditions, owner) {
  dimensions = function_90dbc2921a6b8b42(id);
  triggerent = spawn("trigger_radius", gameent.origin, 0, dimensions.radius, dimensions.height);
  triggerent.gameent = gameent;
  triggerent.id = id;
  triggerent.usetime = usetime;
  triggerent.decayrate = decayrate;
  triggerent.endconditions = endconditions;
  triggerent.endconditions[triggerent.endconditions.size] = "trigger_done";
  triggerent.owner = owner;
  triggerent.team = owner.team;
  triggerent.radius = dimensions.radius;
  triggerent.height = dimensions.height;
  triggerent.trigger = spawnStruct();
  triggerent.trigger.owner = owner;
  triggerent.trigger.id = id;
  triggerent.trigger.targetname = id + "_trigger";
  triggerent scripts\mp\gameobjects::setusetime(triggerent.usetime);
  triggerent makeusable();
  triggerent sethintdisplayrange(triggerent.radius);
  triggerent setuserange(triggerent.radius);
  triggerent sethintdisplayfov(360);
  triggerent setusefov(360);
  triggerent.inuse = 0;
  triggerent function_13ce247fe0d09704(id);
  gameent thread function_f301c94b65bed28f(triggerent);
  triggerent thread function_e9b71089684738a7();
  scripts\mp\utility\trigger::makeenterexittrigger(triggerent, &function_2840c7b0f2b083e1, &function_149d65954b948021);
  return triggerent;
}

function function_3ae40bb839dc4aea(targetteam, toenable) {
  triggerent = self;
  teamplayers = getteamdata(targetteam, "players");

  foreach(player in teamplayers) {
    triggerent function_f025be1cbf898d23(player, toenable);
  }
}

function function_f025be1cbf898d23(targetplayer, toenable) {
  triggerent = self;

  if(!isDefined(triggerent.targets)) {
    triggerent.targets = [];
  }

  if(istrue(toenable)) {
    triggerent.targets[targetplayer.name] = 1;
    return;
  }

  triggerent.targets[targetplayer.name] = undefined;
}

function function_90dbc2921a6b8b42(id) {
  dimensions = spawnStruct();

  switch (id) {
    case #"hash_ec25beb87c3d651a":
      dimensions.radius = level.arrow.dvars.fuseradius;
      dimensions.height = level.arrow.dvars.fuseheight;
      break;
    case #"hash_7f7fd592a3f31def":
    default:
      dimensions.radius = level.arrow.dvars.armradius;
      dimensions.height = level.arrow.dvars.armheight;
      break;
  }

  return dimensions;
}

function function_13ce247fe0d09704(id) {
  triggerent = self;
  var_7c8de8dede9d350b = id == "elite_arrow_arm" || id == "elite_arrow_fuse";

  if(var_7c8de8dede9d350b && isDefined(triggerent.gameent.iconinfo) && isDefined(triggerent.gameent.iconinfo.all)) {
    triggerent.objidnum = triggerent.gameent.iconinfo.all;
    scripts\mp\objidpoolmanager::objective_set_progress(triggerent.objidnum, 0);
    scripts\mp\objidpoolmanager::update_objective_setbackground(triggerent.objidnum, 1);
  }
}

function function_f301c94b65bed28f(triggerent) {
  gameent = self;
  level endon("game_ended");
  result = triggerent waittill_any_in_array_return(triggerent.endconditions);

  if(!isDefined(result)) {
    return;
  }

  if(isDefined(triggerent.triggercomplete)) {
    gameent[[triggerent.triggercomplete]](result);
  }
}

function function_2840c7b0f2b083e1(user, trigger) {
  if(!isPlayer(user) || !isalive(user) || !isDefined(trigger)) {
    return;
  }

  if(!user istouching(trigger)) {
    return;
  }

  gameent = trigger.gameent;

  if(!isDefined(gameent)) {
    return;
  }

  gameent function_b2fb3aa0b1ae1e80(trigger, user);
}

function function_149d65954b948021(user, trigger) {
  if(!isPlayer(user)) {
    return;
  }

  thread function_64bcc0dad8750045(user, trigger);
}

function function_64bcc0dad8750045(user, trigger) {
  user notify("trigger_leave");
  waitframe();
  user notify("trigger_use_think");
}

function function_b2fb3aa0b1ae1e80(triggerent, user) {
  gameent = self;
  level endon("game_ended");
  triggerent endon("trigger_cleanup");
  user endon("trigger_use_think");

  while(true) {
    triggerent waittill("trigger", newuser);

    if(newuser != user) {
      continue;
    }

    if(!triggerent function_8c218e7f79f79418(user)) {
      continue;
    }

    triggerent function_3f0aceb64141b7a0(user);

    if(!user useButtonPressed()) {
      continue;
    }

    triggerent function_8a014abbc4d13014(user);
    result = triggerent function_4a11ff41d980c285(user);
    triggerent function_71fd26b1ab0cf890(user);
    gameent function_e6e5690310ad67b6(triggerent, user, result);
  }
}

function function_8a014abbc4d13014(user) {
  triggerent = self;
  triggerent notify("trigger_start");

  if(isDefined(user) && isPlayer(user)) {
    triggerent function_fee0052854aad103(user, 1);
  }

  triggerent makeunusable();
  triggerent.inuse = 1;
}

function function_4a11ff41d980c285(user) {
  triggerent = self;
  triggerent.lastuser = user;
  triggerent thread function_910afe3f427d993c(user);
  result = function_7b9e0e7ca4b3b940(triggerent, "trigger_success", triggerent, "trigger_fail", user, "trigger_leave", user, "death_or_disconnect");
  triggerent thread function_6e5d48d0254628bf(0, triggerent.lastuser.team);
  triggerent thread function_a186e4e9c028312a();
  return result;
}

function function_71fd26b1ab0cf890(user) {
  triggerent = self;
  triggerent.inuse = 0;
  triggerent makeusable();

  if(isDefined(user) && isPlayer(user)) {
    triggerent function_fee0052854aad103(user, 0);
  }

  triggerent notify("trigger_stop");
}

function function_fee0052854aad103(user, isusing) {
  triggerent = self;
  user notify("trigger_hold_feedback");
  user thread function_80a4d1b69751a181(isusing, triggerent);
  user function_571e26b585ad8b83(isusing);
  triggerent function_c133acb2c0012d2(isusing);
  triggerent function_5aa80c01f224a0dc(isusing);
}

function function_571e26b585ad8b83(isusing) {
  user = self;
  user val::set("sam_holding_bomb", "allow_movement", !isusing);
  user val::set("sam_holding_bomb", "sprint", !isusing);
  user val::set("sam_holding_bomb", "fire", !isusing);
  user val::set("sam_holding_bomb", "reload", !isusing);
  user val::set("sam_holding_bomb", "weapon_pickup", !isusing);
  user val::set("sam_holding_bomb", "weapon_switch", !isusing);
  user val::set("sam_holding_bomb", "allow_jump", !isusing);
  user val::set("sam_holding_bomb", "gesture", !isusing);
  user val::set("sam_holding_bomb", "melee", !isusing);
  user val::set("sam_holding_bomb", "mantle", !isusing);
  user val::set("sam_holding_bomb", "offhand_weapons", !isusing);
  user function_35501b42058d4de9();

  if(!istrue(isusing)) {
    user val::reset_all("sam_holding_bomb");
    user function_bb04491d50d9e43e();
  }
}

function function_80a4d1b69751a181(isusing, triggerent) {
  user = self;

  if(istrue(isusing)) {
    briefcasebomb = makeweapon("briefcase_bomb_mp_nuke");
    user.briefcasebomb = briefcasebomb;
    user scripts\cp_mp\utility\inventory_utility::_giveweapon(briefcasebomb, undefined, undefined, 0);
    user setweaponammostock(briefcasebomb, 0);
    user setweaponammoclip(briefcasebomb, 0);
    user scripts\mp\gameobjects::switchtouseweapon(briefcasebomb, 1, 1);
    return;
  }

  if(user scripts\cp_mp\utility\inventory_utility::iscurrentweapon("briefcase_bomb_mp_nuke")) {
    lastweaponobj = user scripts\mp\utility\inventory::getlastweapon();
    user scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(lastweaponobj, 0, 1);
  } else {
    user scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(makeweapon("briefcase_bomb_mp_nuke"));
    user.briefcasebomb = undefined;
  }

  if(isDefined(user.briefcasebomb)) {
    user takeweapon(user.briefcasebomb);
    user.briefcasebomb = undefined;
  }
}

function function_c133acb2c0012d2(isusing) {
  triggerent = self;

  if(triggerent.id == "elite_arrow_arm") {
    if(istrue(isusing)) {
      triggerent.gameent function_9ad2b2a571d4cdc9("arming");
    } else {
      triggerent.gameent function_9ad2b2a571d4cdc9("arm");
      triggerent.gameent function_3570eaa3344a147c();
    }

    return;
  }

  if(triggerent.id == "elite_arrow_fuse") {
    if(istrue(isusing)) {
      triggerent.gameent function_523253715d93c40f("defusing");
      return;
    }

    triggerent.gameent function_523253715d93c40f("defuse");
  }
}

function function_910afe3f427d993c(user) {
  triggerent = self;
  level endon("game_ended");
  triggerent endon("trigger_cleanup");
  user endon("death_or_disconnect");
  user endon("trigger_leave");

  if(!isDefined(triggerent.curprogress)) {
    triggerent.curprogress = 0;
  }

  triggerent thread function_6e5d48d0254628bf(1, user.team);
  userate = level.arrow.dvars.userate;
  usetimegoal = triggerent.usetime;

  while(function_30f6f2c77a2057ae(user)) {
    function_ef98038667968d83(user);
    waitframe();
    progresstick = level.frameduration * userate;
    triggerent.curprogress += progresstick;

    if(triggerent.curprogress >= usetimegoal) {
      triggerent notify("trigger_success");
      return;
    }
  }

  triggerent notify("trigger_fail");
}

function function_6e5d48d0254628bf(securing, userteam) {
  triggerent = self;
  level endon("game_ended");
  triggerent endon("trigger_cleanup");
  triggerent notify("hold_UI_update");
  triggerent endon("hold_UI_update");

  while(true) {
    if(triggerent.id == "elite_arrow_fuse") {
      var_ad2476e82036a18d = [];

      if(isDefined(userteam)) {
        var_ad2476e82036a18d = getteamdata(userteam, "players");
      } else {
        var_ad2476e82036a18d = level.players;
      }

      foreach(player in var_ad2476e82036a18d) {
        if(isDefined(player)) {
          player scripts\mp\gameobjects::updateuiprogress(triggerent, securing);
        }
      }
    } else if(triggerent.id == "elite_arrow_arm") {
      targetteam = default_to(userteam, triggerent.gameent.targetteam);

      if(!isDefined(targetteam)) {
        break;
      }

      teammates = getteamdata(targetteam, "players");

      foreach(player in teammates) {
        player scripts\mp\gameobjects::updateuiprogress(triggerent, securing);
      }
    }

    waitframe();
  }
}

function function_97e1f9473d7ebe5b() {
  triggerent = self;
  triggerent.curprogress = 0;
  triggerent thread function_6e5d48d0254628bf(0, undefined);
  triggerent notify("hold_UI_update");
}

function function_30f6f2c77a2057ae(user) {
  triggerent = self;

  if(!isDefined(triggerent)) {
    return false;
  }

  usetimegoal = triggerent.usetime;

  if(isDefined(triggerent.curprogress) && triggerent.curprogress > usetimegoal) {
    return false;
  }

  if(istrue(level.arrow.dvars.usetoggle)) {
    if(isDefined(user.var_2a5a464bbdabf17e) && user.var_2a5a464bbdabf17e == 3) {
      return false;
    }
  } else if(!user useButtonPressed()) {
    return false;
  }

  if(isDefined(triggerent.targets) && !istrue(triggerent.targets[user.name])) {
    return false;
  }

  if(!isreallyalive(user) || istrue(user.inlaststand)) {
    return false;
  }

  var_243f810ebb89fef1 = triggerent.radius * triggerent.radius;

  if(distance2dsquared(user.origin, triggerent.origin) > var_243f810ebb89fef1) {
    return false;
  }

  if(abs(user.origin[2] - triggerent.origin[2]) > triggerent.height) {
    return false;
  }

  return true;
}

function function_ef98038667968d83(user) {
  triggerent = self;

  if(!istrue(level.arrow.dvars.usetoggle)) {
    return;
  }

  if(!isDefined(user.var_2a5a464bbdabf17e)) {
    user.var_2a5a464bbdabf17e = 1;
    return;
  }

  if(user.var_2a5a464bbdabf17e == 1) {
    if(!user useButtonPressed()) {
      user.var_2a5a464bbdabf17e = 2;
    }

    return;
  }

  if(user.var_2a5a464bbdabf17e == 2) {
    if(user useButtonPressed()) {
      user.var_2a5a464bbdabf17e = 3;
    }
  }
}

function function_e6e5690310ad67b6(triggerent, user, result) {
  gameent = self;
  user.var_2a5a464bbdabf17e = undefined;

  if(result == "trigger_success") {
    triggerent notify("trigger_done");
    user.arrowusetime = gettime();
    gameent.lastuser = user;
    return;
  }

  if(result == "trigger_fail") {
    if(istrue(level.arrow.dvars.var_9c24246adc08edd8)) {
      user.arrowusetime = gettime();
    }
  }
}

function function_a186e4e9c028312a() {
  triggerent = self;
  level endon("game_ended");
  triggerent endon("trigger_cleanup");
  triggerent endon("trigger_start");
  decayrate = triggerent.decayrate;

  if(decayrate == 0) {
    return;
  } else if(decayrate == -1) {
    triggerent function_97e1f9473d7ebe5b();
    return;
  }

  while(true) {
    triggerent.curprogress -= level.frameduration * decayrate;

    if(triggerent.curprogress <= 0) {
      triggerent function_97e1f9473d7ebe5b();
      return;
    }

    waitframe();
  }
}

function function_8c218e7f79f79418(user) {
  triggerent = self;

  if(istrue(triggerent.inuse)) {
    return false;
  }

  if(!function_dd1eddcb3a80416d(user)) {
    return false;
  }

  if(isDefined(user.briefcasebomb)) {
    return false;
  }

  if(!triggerent function_30f6f2c77a2057ae(user)) {
    return false;
  }

  return true;
}

function function_53bac5ad6b036444() {
  triggerent = self;

  if(!istrue(triggerent.inuse)) {
    return undefined;
  }

  return triggerent.lastuser;
}

function function_3f0aceb64141b7a0(user) {
  triggerent = self;
  level endon("game_ended");
  triggerent endon("trigger_cleanup");

  while((!user isonground() || user isswimming()) && user useButtonPressed()) {
    waitframe();
  }

  if(istrue(user.insertingarmorplate)) {
    user notify("try_armor_cancel");

    while(istrue(user.insertingarmorplate) && user useButtonPressed()) {
      waitframe();
    }
  }
}

function function_e9b71089684738a7(force) {
  triggerent = self;

  if(!isDefined(triggerent)) {
    return;
  }

  level endon("game_ended");
  triggerent notify("trigger_cleanup_singleton");
  triggerent endon("trigger_cleanup_singleton");

  if(!istrue(force)) {
    triggerent waittill("trigger_done");
  }

  triggerent notify("trigger_cleanup");
  triggerent function_97e1f9473d7ebe5b();
  waitframe();

  if(isDefined(triggerent)) {
    function_270efe97b9f9c9fc(triggerent.timerelem);
    triggerent notify("destroy");
    triggerent delete();
  }
}

function function_5aa80c01f224a0dc(isusing) {
  triggerent = self;

  if(!isusing || !isDefined(triggerent) || triggerent.id != "elite_arrow_fuse") {
    return;
  }

  if(istrue(triggerent.firstdefuse)) {
    return;
  }

  triggerent.firstdefuse = 1;
  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("arrow_disarm_warning", triggerent.team, undefined, 2);
}

function function_68ef3e106ab2d16b(allicon, targetteam, friendlyicon, enemyicon) {
  gameent = self;
  gameent.iconinfo = spawnStruct();
  gameent.iconinfo.owner = gameent;
  gameent.iconinfo.allicon = allicon;
  gameent.iconinfo.friendlyicon = friendlyicon;
  gameent.iconinfo.enemyicon = enemyicon;

  if(isDefined(targetteam)) {
    gameent function_1b390a39ac7ec281(targetteam, 1);
  }
}

function function_231aae2264ce7f2e() {
  gameent = self;

  if(!isDefined(gameent.iconinfo)) {
    return;
  }

  function_594eff9e3940a6ee();
  gameent.iconinfo = undefined;
}

function function_3b7130b58a7c77b3(state, followent, playintro, showdistance, originoffset, var_4cf3f1d180aa34e7) {
  gameent = self;

  if(!isDefined(gameent.iconinfo)) {
    return;
  }

  iconorigin = followent function_d11129bc318850dc(state, originoffset);

  if(!isDefined(iconorigin)) {
    return;
  }

  if(isDefined(gameent.iconinfo.allicon)) {
    gameent.iconinfo.all = function_d940e1f43cbfe78a("all", gameent.iconinfo.allicon, iconorigin, playintro, showdistance);
    gameent function_b8be1f76f5f61957(state, followent, gameent.iconinfo.all, "all", originoffset);
    return;
  }

  if(isDefined(gameent.iconinfo.friendlyicon)) {
    gameent.iconinfo.friendly = function_d940e1f43cbfe78a("friendly", gameent.iconinfo.friendlyicon, iconorigin, playintro, showdistance);
    gameent function_b8be1f76f5f61957(state, followent, gameent.iconinfo.friendly, "friendly", originoffset);
  }

  if(isDefined(gameent.iconinfo.enemyicon)) {
    gameent.iconinfo.enemy = function_d940e1f43cbfe78a("enemy", gameent.iconinfo.enemyicon, iconorigin, playintro, showdistance);
    gameent function_b8be1f76f5f61957(state, followent, gameent.iconinfo.enemy, "enemy", originoffset);
  }

  if(isDefined(gameent.player) && istrue(var_4cf3f1d180aa34e7)) {
    gameent.player.ismarked = 1;
  }
}

function function_594eff9e3940a6ee(var_4cf3f1d180aa34e7) {
  gameent = self;
  gameent notify("icon_hide");

  if(!isDefined(gameent.iconinfo)) {
    return;
  }

  if(isDefined(gameent.iconinfo.all)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(gameent.iconinfo.all);
    gameent.iconinfo.all = undefined;
  }

  if(isDefined(gameent.iconinfo.friendly)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(gameent.iconinfo.friendly);
    gameent.iconinfo.friendly = undefined;
  }

  if(isDefined(gameent.iconinfo.enemy)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(gameent.iconinfo.enemy);
    gameent.iconinfo.enemy = undefined;
  }

  if(isDefined(gameent.player) && istrue(var_4cf3f1d180aa34e7)) {
    gameent.player.ismarked = 0;
  }
}

function function_b63a22f9943a3ae8(player, isvisible) {
  gameent = self;

  if(!isDefined(gameent.iconinfo)) {
    return;
  }

  if(istrue(isvisible) && !istrue(player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag())) {
    if(isDefined(gameent.iconinfo.all)) {
      objective_addclienttomask(gameent.iconinfo.all, player);
    }

    if(isDefined(gameent.iconinfo.friendly) && function_cdd64addd69607b1(player)) {
      objective_addclienttomask(gameent.iconinfo.friendly, player);
    }

    if(isDefined(gameent.iconinfo.enemy) && !function_cdd64addd69607b1(player)) {
      objective_addclienttomask(gameent.iconinfo.enemy, player);
    }

    return;
  }

  if(isDefined(gameent.iconinfo.all)) {
    objective_removeclientfrommask(gameent.iconinfo.all, player);
  }

  if(isDefined(gameent.iconinfo.friendly)) {
    objective_removeclientfrommask(gameent.iconinfo.friendly, player);
  }

  if(isDefined(gameent.iconinfo.enemy)) {
    objective_removeclientfrommask(gameent.iconinfo.enemy, player);
  }
}

function function_1b390a39ac7ec281(targetteam, isvisible) {
  gameent = self;
  teamplayers = getteamdata(targetteam, "players");

  foreach(player in teamplayers) {
    gameent function_f5549984b1909638(player, isvisible);
  }
}

function function_f5549984b1909638(targetplayer, isvisible) {
  gameent = self;

  if(!isDefined(gameent.iconinfo.targets)) {
    gameent.iconinfo.targets = [];
  }

  if(istrue(isvisible)) {
    gameent.iconinfo.targets[targetplayer.name] = 1;
  } else {
    gameent.iconinfo.targets[targetplayer.name] = undefined;
  }

  function_b63a22f9943a3ae8(targetplayer, isvisible);
}

function function_b8be1f76f5f61957(state, followent, iconid, icontype, originoffset) {
  gameent = self;

  if(state == "ground") {
    gameent thread function_a71e5368dd774148(followent, iconid, originoffset);
    return;
  }

  if(state == "player") {
    gameent thread function_a061e912aa8b0e76(followent, iconid, icontype, originoffset);
  }
}

function function_d940e1f43cbfe78a(icontype, uiicon, iconorigin, playintro, showdistance) {
  gameent = self;
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(objid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", iconorigin, uiicon);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(objid, playintro);
    objective_setshowdistance(objid, showdistance);
    objective_removeallfrommask(objid);

    foreach(player in level.players) {
      if(player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
        continue;
      }

      if(icontype == "friendly" && !function_cdd64addd69607b1(player)) {
        continue;
      }

      if(icontype == "enemy" && function_cdd64addd69607b1(player)) {
        continue;
      }

      objective_addclienttomask(objid, player);
    }

    objective_showtoplayersinmask(objid);
  } else {
    println("<dev string:x3ef>");
  }

  return objid;
}

function function_a71e5368dd774148(followent, iconid, originoffset) {
  gameent = self;
  gameent endon("death");
  followent endon("death");
  gameent endon("icon_hide");

  while(true) {
    iconorigin = followent function_d11129bc318850dc("ground", originoffset);

    if(!isDefined(iconorigin)) {
      return;
    }

    scripts\mp\objidpoolmanager::update_objective_position(iconid, iconorigin);
    waitframe();
  }
}

function function_a061e912aa8b0e76(followent, iconid, icontype, originoffset) {
  gameent = self;
  gameent endon("death");
  followent endon("death");
  gameent endon("icon_hide");
  pingrate = function_268ffe9ee453e80(icontype);

  if(pingrate <= 0) {
    zoffset = 80;

    if(isDefined(originoffset)) {
      zoffset = originoffset[2];
    }

    scripts\mp\objidpoolmanager::update_objective_setzoffset(iconid, zoffset);
    scripts\mp\objidpoolmanager::update_objective_onentity(iconid, followent);
    return;
  }

  while(true) {
    iconorigin = followent function_d11129bc318850dc("player", originoffset);

    if(!isDefined(iconorigin)) {
      return;
    }

    scripts\mp\objidpoolmanager::update_objective_position(iconid, iconorigin);

    if(followent scripts\cp_mp\utility\player_utility::isinvehicle()) {
      wait 0.1;
      continue;
    }

    wait pingrate;
  }
}

function function_ef1a83cf2ba58e1a(player, isvisible) {
  function_32041f48a2a2e73c(player, isvisible);
  function_3957d8d2ea023852(player, isvisible);
  function_f045c586f2d204ce(player, isvisible);
  function_999950434fe81f2e(player, isvisible);
  function_f2697d44d12a9e3e(player, isvisible);
}

function function_ef1c1b3c3cf49ab0(player, isvisible) {
  function_32041f48a2a2e73c(player, isvisible);
  function_a7ee3a5e548c916e(player, "ber", isvisible);
  function_999950434fe81f2e(player, isvisible);
  function_f2697d44d12a9e3e(player, isvisible);
}

function function_cdd64addd69607b1(player) {
  gameent = self;

  if(!isDefined(gameent.iconinfo.targets)) {
    return false;
  }

  return isDefined(gameent.iconinfo.targets[player.name]);
}

function function_d11129bc318850dc(state, originoffset) {
  gameent = self;
  iconorigin = gameent.origin;

  if(!isDefined(iconorigin)) {
    return undefined;
  }

  if(state == "ground") {
    iconorigin += (0, 0, 25);
  } else if(state == "player") {
    iconorigin += (0, 0, 80);
  }

  if(isDefined(originoffset)) {
    iconorigin += originoffset;
  }

  return iconorigin;
}

function function_268ffe9ee453e80(icontype) {
  pingrate = 0;

  if(icontype == "friendly") {
    pingrate = level.arrow.dvars.var_19425dbae48971b9;
  } else if(icontype == "enemy") {
    pingrate = level.arrow.dvars.var_dd38db1002a8fd1a;
  }

  return pingrate;
}

function function_e84fb82fc52b3ea2(circlenum, circleid, targetteam, circleshuffle, var_bac6c36dad5fb495, alwaysupdate) {
  gameent = self;

  if(!isDefined(circlenum) || !isDefined(circleid)) {
    return;
  }

  gameent function_564f3cd2bdc17d5f(circlenum, circleid, gameent.origin, level.arrow.dvars.var_8935d39cdf624a21);
  mapcircle = gameent function_7c84aecce384688d(circlenum);
  mapcircle.team = targetteam;

  if(!istrue(var_bac6c36dad5fb495)) {
    teamplayers = getteamdata(targetteam, "players");

    foreach(player in teamplayers) {
      gameent function_c203f89a3d83f9be(circlenum, player);
    }
  }

  gameent thread function_a90f855aa2d7ddd6(circlenum, circleshuffle, alwaysupdate);
}

function function_c203f89a3d83f9be(circlenum, player) {
  gameent = self;

  if(circlenum == 1) {
    gameent function_cfd53c8f6878014f(player);
    return;
  }

  if(circlenum == 2) {
    gameent function_fab8ec5feb7d4c9c(player);
  }
}

function function_43c474eab683e97a(circlenum, player) {
  gameent = self;

  if(circlenum == 1) {
    gameent function_d7d113d56ef0ef5b(player);
    return;
  }

  if(circlenum == 2) {
    gameent function_74c4cd59f26eb9ec(player);
  }
}

function function_7c84aecce384688d(circlenum) {
  gameent = self;

  if(circlenum == 1) {
    return gameent.mapcircle;
  }

  if(circlenum == 2) {
    return gameent.var_616c7052c6c2d9b9;
  }
}

function function_c9a7f5ad5faee037(circlenum) {
  if(circlenum == 1) {
    return "circle_cleanup";
  }

  if(circlenum == 2) {
    return "circle_two_cleanup";
  }
}

function function_564f3cd2bdc17d5f(circlenum, circleid, origin, radius) {
  gameent = self;

  if(circlenum == 1) {
    gameent function_6b6b6273f8180522(circleid, origin, radius);
    return;
  }

  if(circlenum == 2) {
    gameent function_db48978d7206bd41(circleid, origin, radius);
  }
}

function function_953dd2dac81ced7d(circlenum) {
  gameent = self;

  if(circlenum == 1) {
    return gameent function_acaa75ca8754452e();
  } else if(circlenum == 2) {
    return gameent function_28f9dfe13002dbb9();
  }

  return 0;
}

function function_6c1a0dacea15c314(circlenum) {
  gameent = self;
  gameent function_33480a83d352290d();

  if(circlenum == 1) {
    gameent function_af5604ce591768e1();
    return;
  }

  if(circlenum == 2) {
    gameent function_f630402329582086();
  }
}

function function_33480a83d352290d() {
  gameent = self;

  if(!isDefined(gameent.targetteam)) {
    return;
  }

  if(!isDefined(gameent.mapcircle) && !isDefined(gameent.var_616c7052c6c2d9b9)) {
    return;
  }

  teammates = getteamdata(gameent.targetteam, "players");

  foreach(player in teammates) {
    if(!isDefined(player)) {
      return;
    }

    for(pingindex = 0; pingindex < 10; pingindex++) {
      isowner = player scripts\cp_mp\calloutmarkerping::function_1e008bf9d31b2b01(pingindex);

      if(isowner) {
        pingtype = player calloutmarkerping_gettype(pingindex);

        if(pingtype != 17) {
          continue;
        }

        pingent = player calloutmarkerping_getEnt(pingindex);

        if(isDefined(gameent.mapcircle) && pingent != gameent.mapcircle || isDefined(gameent.var_616c7052c6c2d9b9) && pingent != gameent.var_616c7052c6c2d9b9) {
          continue;
        }

        player scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout(pingindex);
      }
    }
  }
}

function function_cc8b8058acad7a5e(circlenum, search_location) {
  gameent = self;

  if(circlenum == 1) {
    function_6e148c8da2e4db13(search_location);
    return;
  }

  if(circlenum == 2) {
    function_1d0718fb3b210270(search_location);
  }
}

function function_362afd02a416e0e1(circlenum) {
  gameent = self;
  gameent notify(function_c9a7f5ad5faee037(circlenum));
  doesexist = gameent function_953dd2dac81ced7d(circlenum);

  if(istrue(doesexist)) {
    gameent function_6c1a0dacea15c314(circlenum);
  }
}

function function_a90f855aa2d7ddd6(circlenum, circleshuffle, alwaysupdate) {
  gameent = self;
  gameent endon(function_c9a7f5ad5faee037(circlenum));

  while(true) {
    haschanged = function_140a060c10923557(circlenum);

    if(istrue(alwaysupdate) || istrue(haschanged) || istrue(level.arrow.dvars.circleshuffle) || istrue(circleshuffle)) {
      function_751a786dc5a29de1(circlenum, alwaysupdate);
    }

    if(istrue(alwaysupdate)) {
      waitframe();
      continue;
    }

    var_495b81d9b9fac4b9 = randomfloat(level.arrow.dvars.var_9042d5cf11398509) - level.arrow.dvars.var_9042d5cf11398509 / 2;
    wait level.arrow.dvars.circleupdaterate + var_495b81d9b9fac4b9;
  }
}

function function_751a786dc5a29de1(circlenum, ignorerange) {
  gameent = self;
  search_location = (gameent.origin[0], gameent.origin[1], 0);

  if(!istrue(ignorerange)) {
    radius = function_e9b7d4bc067911cf(circlenum);
    range = function_b2089f7ec141eb6a(radius);
    search_location += math::random_vector_2d() * range;
  }

  gameent function_cc8b8058acad7a5e(circlenum, search_location);
}

function function_b2089f7ec141eb6a(radius) {
  gameent = self;

  if(!isDefined(radius)) {
    return;
  }

  if(radius == level.arrow.dvars.var_22cf546ce61f0ee4) {
    return randomfloatrange(0, level.arrow.dvars.var_e31c618e0043e25c);
  }

  if(radius == level.arrow.dvars.var_8f12acd8eb090fb0) {
    return randomfloatrange(0, level.arrow.dvars.var_f3369a0bf2e24d98);
  }

  return randomfloatrange(level.arrow.dvars.circlerangemin, level.arrow.dvars.circlerangemax);
}

function function_140a060c10923557(circlenum) {
  gameent = self;
  closestdist = undefined;
  circle = gameent function_7c84aecce384688d(circlenum);
  teamplayers = getlivingplayers(circle.team);

  foreach(player in teamplayers) {
    dist = distance2d(player.origin, gameent.origin);

    if(!isDefined(closestdist) || dist < closestdist) {
      closestdist = dist;
    }
  }

  oldradius = function_e9b7d4bc067911cf(circlenum);
  newradius = oldradius;

  if(!isDefined(closestdist) || closestdist > level.arrow.dvars.var_8935d39cdf624a21) {
    gameent function_c220e901546e3ddb(circlenum, level.arrow.dvars.var_8935d39cdf624a21);
    newradius = level.arrow.dvars.var_8935d39cdf624a21;
  } else if(closestdist > level.arrow.dvars.var_bc573ea608f113cd) {
    gameent function_c220e901546e3ddb(circlenum, level.arrow.dvars.var_bc573ea608f113cd);
    newradius = level.arrow.dvars.var_bc573ea608f113cd;
  } else if(closestdist > level.arrow.dvars.var_8f12acd8eb090fb0) {
    gameent function_c220e901546e3ddb(circlenum, level.arrow.dvars.var_8f12acd8eb090fb0);
    newradius = level.arrow.dvars.var_8f12acd8eb090fb0;
  } else {
    gameent function_c220e901546e3ddb(circlenum, level.arrow.dvars.var_22cf546ce61f0ee4);
    newradius = level.arrow.dvars.var_22cf546ce61f0ee4;
  }

  if(newradius != oldradius) {
    return true;
  }

  return false;
}

function function_c220e901546e3ddb(circlenum, newradius) {
  gameent = self;

  if(circlenum == 1) {
    gameent function_4584ad1c0e2c58ec(newradius);
    return;
  }

  if(circlenum == 2) {
    gameent function_ae2bfaa147f91ca5(newradius);
  }
}

function function_e9b7d4bc067911cf(circlenum) {
  gameent = self;
  circle = gameent function_7c84aecce384688d(circlenum);

  if(isDefined(circle)) {
    return circle.origin[2];
  }

  return -1;
}

function function_db724919d6173e87(targetteam) {
  player = self;

  foreach(container in level.arrow.props.containers[targetteam]) {
    if(!isDefined(container)) {
      continue;
    }

    container function_c203f89a3d83f9be(1, player);
  }
}

function function_3cee7764bd6c4cff(targetteam) {
  player = self;

  foreach(container in level.arrow.props.containers[targetteam]) {
    if(!isDefined(container)) {
      continue;
    }

    container function_43c474eab683e97a(1, player);
  }
}

function function_86ea1b770ae5cb74() {
  teaminfo = self;

  if(!istrue(level.arrow.dvars.scripttracker)) {
    return;
  }

  teaminfo.trackerhud = spawnStruct();
  teammates = getteamdata(teaminfo.targetteam, "players");
  teaminfo.trackerhud.teammates = teammates;
  teaminfo function_ff3fabc5e0883062();
  teaminfo.trackerhud.hudbox = function_e067b71266d46a9d((1, 0.9, 0.7), 165, 95, -50);
}

function function_2e031201711a99de() {
  if(!istrue(level.arrow.dvars.scripttracker)) {
    return;
  }

  foreach(info in level.arrow.teaminfo) {
    if(!isDefined(info)) {
      continue;
    }

    function_aa6ba140692b3197(info.targetteam);
  }
}

function function_aa6ba140692b3197(targetteam) {
  if(!isDefined(level.arrow.teaminfo[targetteam]) || !isDefined(level.arrow.teaminfo[targetteam].trackerhud)) {
    return;
  }

  level.arrow.teaminfo[targetteam] function_9f667c7c18dde8af();
  level.arrow.teaminfo[targetteam].trackerhud = undefined;
}

function function_9f667c7c18dde8af() {
  teaminfo = self;
  trackerhud = teaminfo.trackerhud;

  if(!istrue(level.arrow.dvars.scripttracker) || !isDefined(trackerhud)) {
    return;
  }

  function_4895f52923623fcd(trackerhud.title);
  function_4895f52923623fcd(trackerhud.hudbox);

  foreach(entry in trackerhud.entries) {
    function_4895f52923623fcd(entry);
  }
}

function function_4895f52923623fcd(elems) {
  if(!isDefined(elems)) {
    return;
  }

  foreach(elem in elems) {
    if(isDefined(elem)) {
      elem destroyelem();
    }
  }
}

function function_ff3fabc5e0883062() {
  teaminfo = self;
  bombsite = level.arrow.props.bombsite;

  if(!istrue(level.arrow.dvars.scripttracker)) {
    return;
  }

  if(istrue(bombsite.var_dc0258a29dc9faf1)) {
    teaminfo.trackerhud.title = function_dc5ada7d3d98a103(&"BR_ELITE_BROKEN_ARROW/ARM_THE_BOMB", 1.2, 1, -75);
    return;
  }

  if(istrue(bombsite.siterevealed)) {
    teaminfo.trackerhud.title = function_dc5ada7d3d98a103(&"BR_ELITE_BROKEN_ARROW/DEPOSIT_ELEMS", 1.2, 1, -75);
    return;
  }

  if(istrue(bombsite.dropping)) {
    teaminfo.trackerhud.title = function_dc5ada7d3d98a103(&"BR_ELITE_BROKEN_ARROW/WAITING_BOMB", 1.2, 1, -75);
    return;
  }

  teaminfo.trackerhud.title = function_dc5ada7d3d98a103(&"BR_ELITE_BROKEN_ARROW/LOCATE_ELEMS", 1.2, 1, -75);
}

function function_f421381f1379bc3c(elementid, spawned) {
  teaminfo = self;
  bombsite = level.arrow.props.bombsite;
  trackernumber = function_6844602f3120e900(elementid, 4);
  textheightoffset = function_65336e6b7ecd0bfc(function_6844602f3120e900(elementid, 6));

  if(!isDefined(trackernumber)) {
    return;
  }

  if(!istrue(level.arrow.dvars.scripttracker)) {
    return;
  }

  if(!isDefined(teaminfo.trackerhud.entries)) {
    teaminfo.trackerhud.entries = [];
  }

  if(isDefined(teaminfo.trackerhud.entries[trackernumber])) {
    function_4895f52923623fcd(teaminfo.trackerhud.entries[trackernumber]);
  }

  if(istrue(bombsite.neededelements[elementid])) {
    teaminfo.trackerhud.entries[trackernumber] = function_dc5ada7d3d98a103(function_6844602f3120e900(elementid, 15), 0.9, 0.6, textheightoffset);
    return;
  }

  if(istrue(level.arrow.dvars.scriptedflow) && !istrue(spawned)) {
    teaminfo.trackerhud.entries[trackernumber] = function_dc5ada7d3d98a103(&"BR_ELITE_BROKEN_ARROW/NEXT_TASK", 0.9, 0.6, textheightoffset);
    return;
  }

  teaminfo.trackerhud.entries[trackernumber] = function_dc5ada7d3d98a103(function_6844602f3120e900(elementid, 14), 0.9, 1, textheightoffset);
}

function function_dc5ada7d3d98a103(text, size, alpha, heightoffset) {
  teaminfo = self;
  trackerhud = teaminfo.trackerhud;

  if(!istrue(level.arrow.dvars.scripttracker) || !isDefined(trackerhud)) {
    return;
  }

  if(!isDefined(trackerhud.teammates)) {
    return;
  }

  hudelem = [];

  foreach(player in trackerhud.teammates) {
    if(!isDefined(player)) {
      continue;
    }

    hudelem[player.clientid] = player createfontstring("default", size);
    hudelem[player.clientid] setpoint("LEFT", "LEFT", 15, heightoffset);
    hudelem[player.clientid].alpha = alpha;
    hudelem[player.clientid].archived = 0;
    hudelem[player.clientid].hidewheninmenu = 1;
    hudelem[player.clientid] settext(text);
  }

  return hudelem;
}

function function_94cc9dc4d6f03045(time, size, var_6e04e340b75c04ad, heightoffset, widthoffset) {
  teaminfo = self;
  trackerhud = teaminfo.trackerhud;

  if(!istrue(level.arrow.dvars.scripttracker) || !isDefined(trackerhud)) {
    return;
  }

  if(!isDefined(trackerhud.teammates)) {
    return;
  }

  hudelem = [];

  foreach(player in trackerhud.teammates) {
    if(!isDefined(player)) {
      continue;
    }

    hudelem[player.clientid] = player createtimer("default", size);
    hudelem[player.clientid] setpoint("LEFT", "LEFT", widthoffset, heightoffset);
    hudelem[player.clientid].alpha = 1;
    hudelem[player.clientid].archived = 0;
    hudelem[player.clientid].hidewheninmenu = 1;

    if(istrue(var_6e04e340b75c04ad)) {
      hudelem[player.clientid] settenthstimer(time);
      continue;
    }

    hudelem[player.clientid] settimer(time);
  }

  return hudelem;
}

function function_e067b71266d46a9d(color, width, height, heightoffset) {
  teaminfo = self;
  trackerhud = teaminfo.trackerhud;

  if(!istrue(level.arrow.dvars.scripttracker) || !isDefined(trackerhud)) {
    return;
  }

  if(!isDefined(trackerhud.teammates)) {
    return;
  }

  hudelem = [];

  foreach(player in trackerhud.teammates) {
    if(!isDefined(player)) {
      continue;
    }

    hudelem[player.clientid] = player createbar(color, width, height);
    hudelem[player.clientid] setpoint("LEFT", "LEFT", 0, heightoffset);
    hudelem[player.clientid].alpha = 0.5;
    hudelem[player.clientid].bar.alpha = 0.5;
    hudelem[player.clientid].archived = 0;
    hudelem[player.clientid].hidewheninmenu = 1;
  }

  return hudelem;
}

function function_566ebf0873178b74(text) {
  foreach(activeteam in level.arrow.teaminfo) {
    activeteam function_b20ed2f9b411799e(text);
  }
}

function function_b20ed2f9b411799e(text) {
  teaminfo = self;
  trackerhud = teaminfo.trackerhud;

  if(!istrue(level.arrow.dvars.scripttracker) || !isDefined(trackerhud)) {
    return;
  }

  if(!isDefined(trackerhud.title)) {
    return;
  }

  foreach(entry in trackerhud.title) {
    if(!isDefined(entry)) {
      continue;
    }

    entry settext(text);
  }
}

function function_c34f3e1c188c4ee6(text, alpha, entryindex) {
  foreach(activeteam in level.arrow.teaminfo) {
    activeteam function_f0fe6459c0d406dc(text, alpha, entryindex);
  }
}

function function_f0fe6459c0d406dc(text, alpha, entryindex) {
  teaminfo = self;
  trackerhud = teaminfo.trackerhud;

  if(!istrue(level.arrow.dvars.scripttracker) || !isDefined(trackerhud)) {
    return;
  }

  if(!isDefined(trackerhud.entries[entryindex])) {
    return;
  }

  foreach(entry in trackerhud.entries[entryindex]) {
    if(!isDefined(entry)) {
      continue;
    }

    entry settext(text);

    if(isDefined(alpha)) {
      entry.alpha = alpha;
    }
  }
}

function function_6af5ded34f8c79be() {
  teaminfo = self;
  trackerhud = teaminfo.trackerhud;

  if(!istrue(level.arrow.dvars.scripttracker) || !isDefined(trackerhud)) {
    return;
  }

  trackerhud.entries[6] = function_dc5ada7d3d98a103(&"BR_ELITE_BROKEN_ARROW/BOMB_INCOMING", 1, 0.6, -12);
}

function function_8bef76d7d75916b6(time) {
  teaminfo = self;
  trackerhud = teaminfo.trackerhud;

  if(!istrue(level.arrow.dvars.scripttracker) || !isDefined(trackerhud)) {
    return;
  }

  function_4895f52923623fcd(trackerhud.entries[6]);
  trackerhud.entries[6] = function_dc5ada7d3d98a103(&"BR_ELITE_BROKEN_ARROW/BOMB_EXPIRES", 1, 1, -12);
  trackerhud.entries[7] = function_94cc9dc4d6f03045(time, 1, 0, -24, 125);
}

function function_9de2e8c510281719() {
  teaminfo = self;
  trackerhud = teaminfo.trackerhud;

  if(!istrue(level.arrow.dvars.scripttracker) || !isDefined(trackerhud)) {
    return;
  }

  function_4895f52923623fcd(trackerhud.entries[6]);
  function_4895f52923623fcd(trackerhud.entries[7]);
}

function function_5cf6ab54f8852b93(time) {
  teaminfo = self;
  trackerhud = teaminfo.trackerhud;

  if(!istrue(level.arrow.dvars.scripttracker) || !isDefined(trackerhud)) {
    return;
  }

  foreach(entry in trackerhud.entries) {
    function_4895f52923623fcd(entry);
  }

  function_b20ed2f9b411799e(&"BR_ELITE_BROKEN_ARROW/PROTECT_NUKE");
  trackerhud.entries[8] = function_94cc9dc4d6f03045(time, 1.5, 1, -45, 15);
}

function function_3fd409053922036c() {
  task = self;

  foreach(player in getteamdata(task.teams[0], "players")) {
    if(!player scripts\mp\gametypes\br_public::isplayeringulag()) {
      player function_e16c60b795d0b382(1);
    }
  }
}

function function_e16c60b795d0b382(visible) {
  player = self;

  if(istrue(visible)) {
    player uiobjectiveshow(level.arrow.contractref);
    return;
  }

  player uiobjectivehide();
}

function function_56ee84f1b091647a(timer, timerpaused) {
  teaminfo = self;

  if(istrue(level.arrow.dvars.scripttracker)) {
    return;
  }

  enabled = teaminfo function_ad4ed1c9602d71e0();
  var_22c75974769a0663 = teaminfo function_b6255b7471955efc();
  timer = function_ae2d71b31ecc6c60(timer);
  timerpaused = istrue(timerpaused);
  bombsite = function_c3ec46d0059f56b8();
  states = teaminfo function_2e702bea8f46ba();
  allies = teaminfo function_fbd99fb0f0dbdf28();
  enemies = teaminfo function_bb6e0639af98dba6();
  teammates = getteamdata(teaminfo.targetteam, "players");

  foreach(player in teammates) {
    player function_92e23a2852dd5ef7(enabled, var_22c75974769a0663, states, bombsite, allies, timer, timerpaused);
    player function_a94fc1246fd1026d(enemies);
    player function_2e7f459351d2a81e(timer, var_22c75974769a0663);
  }
}

function function_c9699034e76b57c8(timer) {
  player = self;

  if(istrue(level.arrow.dvars.scripttracker)) {
    return;
  }

  var_22c75974769a0663 = function_c9f395df805314e();
  timer = function_ae2d71b31ecc6c60(timer);
  timerpaused = 0;
  bombsite = function_c3ec46d0059f56b8();
  states = function_2b087dc1a7410f08();
  player function_92e23a2852dd5ef7(0, var_22c75974769a0663, states, bombsite, [], timer, timerpaused);
}

function function_20238d522c76fb01(timer, timerpaused) {
  if(istrue(level.arrow.dvars.scripttracker)) {
    return;
  }

  if(!isDefined(level.arrow.teaminfo)) {
    return;
  }

  foreach(teaminfo in level.arrow.teaminfo) {
    if(!isDefined(teaminfo)) {
      continue;
    }

    teaminfo thread function_56ee84f1b091647a(timer, timerpaused);
  }
}

function function_5e7fdf58f111f041(timer) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(function_8ef404291ea37583(player)) {
      continue;
    }

    player function_c9699034e76b57c8(timer);
  }
}

function function_ad4ed1c9602d71e0() {
  teaminfo = self;
  return teaminfo.state > 0;
}

function function_b6255b7471955efc() {
  teaminfo = self;
  return max(teaminfo.state, 0);
}

function function_c9f395df805314e() {
  statemax = 0;

  foreach(teaminfo in level.arrow.teaminfo) {
    if(!isDefined(teaminfo)) {
      continue;
    }

    statemax = max(teaminfo function_b6255b7471955efc(), statemax);
  }

  return statemax;
}

function function_ae2d71b31ecc6c60(timer) {
  if(isDefined(level.arrow.bombsitetimestamp)) {
    return function_3fb6126945208e3e();
  } else if(isDefined(timer)) {
    return int(timer);
  }

  return 0;
}

function function_c3ec46d0059f56b8() {
  if(isDefined(level.arrow.props.bombsite)) {
    if(istrue(level.arrow.props.bombsite.armedwipe)) {
      return 3;
    } else if(istrue(level.arrow.props.bombsite.siterevealed)) {
      return 2;
    }
  }

  return 1;
}

function function_2e702bea8f46ba() {
  teaminfo = self;
  elements = level.arrow.props.elements;
  result = [];

  foreach(element in level.arrow.elementorder) {
    result[result.size] = teaminfo function_3fea6986376fa82d(element);
  }

  return result;
}

function function_3fea6986376fa82d(elementid) {
  teaminfo = self;

  if(!isDefined(level.arrow.props.elements) || !isDefined(level.arrow.props.elements[teaminfo.targetteam]) || !isDefined(level.arrow.props.elements[teaminfo.targetteam][elementid])) {
    globalcountdown = isDefined(level.arrow.countdowns) && isDefined(level.arrow.countdowns[elementid]) && level.arrow.countdowns[elementid] <= level.arrow.dvars.var_29258dcc063eec7f;
    teamcountdown = isDefined(teaminfo.var_8dfd9e71543b605b[elementid]) && teaminfo.var_8dfd9e71543b605b[elementid] <= level.arrow.dvars.var_29258dcc063eec7f;

    if(globalcountdown || teamcountdown) {
      return 1;
    } else {
      return 0;
    }
  }

  element = level.arrow.props.elements[teaminfo.targetteam][elementid];

  if(isDefined(element.var_a683e11bf953f9b7) && element.var_a683e11bf953f9b7 > 0) {
    switch (element.var_a683e11bf953f9b7) {
      case 1:
        return 5;
      case 2:
        return 6;
      case 3:
        return 7;
      case 4:
        return 8;
      default:
        break;
    }
  }

  if(isDefined(element.player)) {
    if(element.player.team == element.targetteam) {
      return 3;
    } else {
      return 4;
    }
  }

  if(element function_97c5201a39c968e4() == "dropped" || element function_97c5201a39c968e4() == "visible" || istrue(element.firstpickup)) {
    return 2;
  }

  return 0;
}

function function_2b087dc1a7410f08() {
  elements = level.arrow.props.elements;

  if(!isDefined(elements)) {
    return [0, 0, 0];
  }

  result = [];

  foreach(element in level.arrow.elementorder) {
    result[result.size] = function_94604d3a8a6bcbcd(element);
  }

  return result;
}

function function_94604d3a8a6bcbcd(elementid) {
  totalstate = 0;

  foreach(teaminfo in level.arrow.teaminfo) {
    if(!isDefined(teaminfo)) {
      continue;
    }

    totalstate = max(teaminfo function_3fea6986376fa82d(elementid), totalstate);
  }

  if(totalstate < 5) {
    totalstate = 0;
  }

  return totalstate;
}

function function_fbd99fb0f0dbdf28(elements) {
  teaminfo = self;
  elements = level.arrow.props.elements;
  result = [];

  if(!isDefined(elements) || !isDefined(elements[teaminfo.targetteam])) {
    for(i = 0; i < level.arrow.elementlist.size; i++) {
      result[result.size] = 0;
    }
  } else {
    foreach(element in level.arrow.elementorder) {
      result[result.size] = teaminfo function_916a1b0fe3b68a5f(element);
    }
  }

  return result;
}

function function_916a1b0fe3b68a5f(elementid) {
  teaminfo = self;
  element = level.arrow.props.elements[teaminfo.targetteam][elementid];

  if(!isDefined(element) || !isDefined(element.player)) {
    return 0;
  }

  return element.player.sessionuimemberindex;
}

function function_bb6e0639af98dba6(elements) {
  teaminfo = self;
  elements = level.arrow.props.elements;
  result = [];

  if(!isDefined(elements) || !isDefined(elements[teaminfo.targetteam])) {
    for(i = 0; i < level.arrow.elementlist.size; i++) {
      result[result.size] = 0;
    }
  } else {
    foreach(element in level.arrow.elementorder) {
      result[result.size] = teaminfo function_f6a8eac525987fb3(element);
    }
  }

  return result;
}

function function_f6a8eac525987fb3(elementid) {
  teaminfo = self;
  element = level.arrow.props.elements[teaminfo.targetteam][elementid];

  if(!isDefined(element)) {
    return 0;
  }

  if(isDefined(element.player)) {
    return element.player getentitynumber();
  }

  return 0;
}

function function_92e23a2852dd5ef7(enabled, var_22c75974769a0663, stateelements, bombsite, allyelements, timer, timerpaused) {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  player function_4d04726abac45416(stateelements, allyelements);
  player function_861eca600aa7e32c(enabled, var_22c75974769a0663, bombsite, timer, timerpaused);
}

function function_4d04726abac45416(stateelements, allyelements) {
  var_60bc1c932d9c930c = 16 - 1;
  var_396348f5e859d0e9 = 4 - 1;
  var_7bd189e8a12dbe14 = stateelements.size;
  assert(stateelements.size <= 3);
  assert(allyelements.size <= 4);

  if(stateelements.size < 3) {
    stateelements[stateelements.size] = 0;
  }

  if(allyelements.size < 4) {
    allyelements[allyelements.size] = 0;
  }

  for(i = 0; i < stateelements.size; i++) {
    if(isDefined(stateelements[i]) && stateelements[i] >= 0 && stateelements[i] <= var_60bc1c932d9c930c) {
      scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_br_elite_arrow_element_data", 4 * i, 4, int(stateelements[i]) &var_60bc1c932d9c930c);
    }
  }

  for(i = 0; i < allyelements.size; i++) {
    if(isDefined(allyelements[i]) && allyelements[i] >= 0 && allyelements[i] <= var_396348f5e859d0e9) {
      scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_br_elite_arrow_element_data", 12 + 2 * i, 2, int(allyelements[i]) &var_396348f5e859d0e9);
    }
  }

  scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_br_elite_arrow_element_data", 20, 3, var_7bd189e8a12dbe14);
}

function function_861eca600aa7e32c(enabled, var_22c75974769a0663, bombsite, timer, timerpaused, success) {
  enabledmax = 2 - 1;
  statemax = 8 - 1;
  bombsitemax = 4 - 1;
  timermax = 512 - 1;
  timerpausedmax = 2 - 1;
  assert(enabled >= 0 && enabled <= enabledmax);
  assert(var_22c75974769a0663 >= 0 && var_22c75974769a0663 <= statemax);
  assert(bombsite >= 0 && bombsite <= bombsitemax);
  assert(timer >= 0 && timer <= timermax);
  scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_br_elite_arrow_mission_data", 0, 1, int(enabled) &enabledmax);
  scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_br_elite_arrow_mission_data", 1, 3, int(var_22c75974769a0663) &statemax);
  scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_br_elite_arrow_mission_data", 4, 2, int(bombsite) &bombsitemax);
  scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_br_elite_arrow_mission_data", 6, 9, int(timer) &timermax);
  scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_br_elite_arrow_mission_data", 15, 1, int(timerpaused) &timerpausedmax);
}

function function_fa5724663ba71381() {
  scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_br_elite_arrow_mission_data", 16, 1, int(1));
}

function function_a94fc1246fd1026d(enemyelements) {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  player function_2f11bd77a8fa0132(enemyelements);
}

function function_2f11bd77a8fa0132(enemyelements) {
  var_cd975998ed2963b2 = 256 - 1;
  assert(enemyelements.size <= 4);

  if(enemyelements.size < 4) {
    enemyelements[enemyelements.size] = 0;
  }

  for(i = 0; i < enemyelements.size; i++) {
    if(isDefined(enemyelements[i]) && enemyelements[i] >= 0 && enemyelements[i] <= var_cd975998ed2963b2) {
      scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc("ui_br_elite_arrow_mission_players", 8 * i, 8, int(enemyelements[i]) &var_cd975998ed2963b2);
    }
  }
}

function function_2e7f459351d2a81e(timer, var_22c75974769a0663) {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  if(var_22c75974769a0663 == 0 || var_22c75974769a0663 == 1 || var_22c75974769a0663 == 6) {
    return;
  }

  time = gettime() + timer * 1000;
  player setclientomnvar("ui_br_objective_countdown_timer", time);
}

function function_d47c61711c9c094c() {
  team = self.teams[0];
  players = getteamdata(team, "players");

  foreach(player in players) {
    time = player getclientomnvar("ui_br_objective_countdown_timer");
    break;
  }

  time -= gettime();
  time *= 0.001;
  time = int(ceil(time));
  return time;
}

function function_6a6b4d717ec3582e() {
  teaminfo = self;
  player = teaminfo.champion;
  spawnnodes = function_149d1a95d86fde9f(player);

  if(!istrue(level.arrow.dvars.debug) && (spawnnodes.size != 3 || level.arrow.elementlist.size != 3)) {
    teaminfo thread function_88a043b99a75e47("container_spawn_failed", 0);
    return;
  }

  if(!isDefined(level.arrow.props.containers)) {
    level.arrow.props.containers = [];
  }

  containers = [];

  foreach(element in level.arrow.elementlist) {
    containers[element.elementid] = function_2eb30dce28e6a061(function_6844602f3120e900(element.elementid, 7), player.team, spawnnodes[element.elementindex].origin, spawnnodes[element.elementindex].angles);

    if(element.elementid == "ber") {
      containers[element.elementid] function_68ef3e106ab2d16b("ui_map_icon_elite_crown");
    }
  }

  level.arrow.props.containers[player.team] = containers;
}

function function_2eb30dce28e6a061(scriptable, targetteam, position, angles) {
  container = spawnscriptable(scriptable, position, angles);
  container function_3182e44bb20cc5af("active_and_closed");
  elementid = function_96a1620d901981d1(scriptable, 7);
  var_e3c7bdfc2ae5dc88 = function_6844602f3120e900(elementid, 3);
  container function_e84fb82fc52b3ea2(1, var_e3c7bdfc2ae5dc88, targetteam);
  container.targetteam = targetteam;
  container.criticalitem = 1;
  container.keepinmap = 1;
  container.donthide = 1;
  container.iconinfo = spawnStruct();
  container.iconinfo.friendlyicon = function_6844602f3120e900(elementid, 2);
  container function_1b390a39ac7ec281(targetteam, 1);
  container function_28f475dbb88a7e63(container.type, targetteam);
  container thread function_208f655060eef025();

  if(getdvarint(@ "hash_5257cc60e0dd8f5f", 0) == 1) {
    sphere(position, 300, (0, 1, 0), 0, 600);
  }

  return container;
}

function function_28f475dbb88a7e63(containername, targetteam) {
  container = self;

  if(!isDefined(level.arrow.props.elements)) {
    level.arrow.props.elements = [];
  }

  if(!isDefined(level.arrow.props.elements[targetteam])) {
    level.arrow.props.elements[targetteam] = [];
  }

  teaminfo = level.arrow.teaminfo[targetteam];
  elementid = function_96a1620d901981d1(containername, 7);
  level.arrow.props.elements[targetteam][elementid] = teaminfo function_4c842789d2e221a8(elementid, container.origin, container.angles);
  container.elementref = level.arrow.props.elements[targetteam][elementid];
  container.elementref.containerref = container;
}

function function_4d6d1400d6df4b2d() {
  if(!isDefined(level.arrow.props.containers)) {
    return;
  }

  foreach(info in level.arrow.teaminfo) {
    if(!isDefined(info)) {
      continue;
    }

    function_6c05bd253d4ae324(info.targetteam);
  }
}

function function_6c05bd253d4ae324(targetteam) {
  if(!isDefined(level.arrow.props.containers) || !isDefined(level.arrow.props.containers[targetteam])) {
    return;
  }

  foreach(container in level.arrow.props.containers[targetteam]) {
    container function_983755efb92ebfc2();
  }
}

function function_983755efb92ebfc2() {
  container = self;

  if(!isDefined(container)) {
    return;
  }

  container function_362afd02a416e0e1(1);
  container function_594eff9e3940a6ee();
  container notify("death");
  container freescriptable();
}

function function_149d1a95d86fde9f(player) {
  spawnnodes = [];

  if(istrue(level.arrow.dvars.debug)) {
    basepos = player.origin;
    baseangles = player.angles;
    forwardoffset = anglesToForward(baseangles) * 100;
    rightoffset = anglestoright(baseangles) * 100;
    spawnangles = (0, player.angles[1] + 90, 0);

    for(i = 0; i < level.arrow.elementlist.size; i++) {
      spawnnodes[i] = spawnStruct();
      spawnnodes[i].origin = basepos + forwardoffset + rightoffset * i;
      spawnnodes[i].angles = spawnangles;
    }

    return spawnnodes;
  }

  possiblenodes = function_ca6c0350ac3a2550(player.origin);

  if(possiblenodes.size == 0) {
    return undefined;
  }

  circletimescale = getmatchrulesdata("brData", "circleTimeScale");
  spawnnodes[0] = function_1780902700581723(possiblenodes, 90 * circletimescale);
  spawnnodes[1] = function_1780902700581723(possiblenodes, 330 * circletimescale);
  spawnnodes[2] = function_1780902700581723(possiblenodes, 510 * circletimescale);
  spawnnodes = array_randomize(spawnnodes);
  return spawnnodes;
}

function function_ca6c0350ac3a2550(position, var_c7236d5024dc86a8) {
  maxdist = level.arrow.dvars.var_8a0e0d62d99bef57;

  if(isDefined(var_c7236d5024dc86a8) && int(var_c7236d5024dc86a8) >= 2) {
    maxdist = level.arrow.dvars.containermaxdist;
  }

  mindist = level.arrow.dvars.var_a076a7284aa6e915;

  if(istrue(var_c7236d5024dc86a8)) {
    mindist = level.arrow.dvars.containermindist;
  }

  possiblenodes = getunusedlootcachepoints(position, maxdist, mindist);

  if(!istrue(var_c7236d5024dc86a8)) {
    possiblenodes = function_a076336c265f25c0(position, possiblenodes);
  }

  if(level.arrow.dvars.var_8e6e735a3607b730) {
    possiblenodes = function_c0b7581316e30132(possiblenodes);
  }

  return possiblenodes;
}

function function_a076336c265f25c0(position, nodes) {
  if(!scripts\mp\gametypes\br_gametypes::isfeatureenabled("circle")) {
    return nodes;
  }

  newarray = [];

  foreach(node in nodes) {
    if(scripts\mp\gametypes\br_circle_util::function_77cec84f05ca9418(position, node.origin, 1000)) {
      newarray[newarray.size] = node;
    }
  }

  return newarray;
}

function function_c0b7581316e30132(nodes) {
  newarray = [];

  foreach(node in nodes) {
    if(!namespace_bd614c3c2275579a::function_20a22133815385f8(node.origin)) {
      newarray[newarray.size] = node;
    }
  }

  return newarray;
}

function function_1780902700581723(nodearr, var_745a27070fcadb17) {
  if(!isDefined(nodearr)) {
    assertmsg("<dev string:x429>");
    return undefined;
  }

  nodearr = array_randomize(nodearr);

  if(istrue(level.br_circle_disabled)) {
    return nodearr[0];
  }

  foreach(node in nodearr) {
    if(!function_d51c0a9f57aa9815(node, var_745a27070fcadb17)) {
      continue;
    }

    disablelootspawnpoint(node.index);
    return node;
  }

  assertmsg("<dev string:x46e>");
  return undefined;
}

function function_d51c0a9f57aa9815(node, var_745a27070fcadb17) {
  safetime = scripts\mp\gametypes\br_circle_util::gettimetilldangerforpoint(node.origin);

  if(safetime < var_745a27070fcadb17) {
    return false;
  }

  if(namespace_9823ee6035594d67::function_f59f68adc71d49b3(node.origin)) {
    return false;
  }

  return true;
}

function function_208f655060eef025() {
  container = self;
  container notify("watch_circle");
  container endon("watch_circle");
  container endon("element_taken");
  level endon("game_ended");

  if(level.arrow.dvars.var_bcde724251ce0168 <= 0) {
    return;
  }

  while(true) {
    wait level.arrow.dvars.var_bcde724251ce0168;

    if(!function_c2ef2a31f608bd68(container)) {
      return;
    }

    ingas = !istrue(level.br_circle_disabled) && !scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(container.origin);

    if(!istrue(ingas)) {
      continue;
    }

    container function_ae237980930f2584();
    container function_ae4d9d04fb05bae9();
  }
}

function function_ae237980930f2584() {
  container = self;

  if(level.arrow.dvars.containergastime <= 0) {
    return;
  }

  if(!isDefined(container.gastime)) {
    container.gastime = 0;
  }

  container.gastime += level.arrow.dvars.var_bcde724251ce0168;

  if(container.gastime >= level.arrow.dvars.containergastime) {
    teaminfo = level.arrow.teaminfo[container.targetteam];
    teaminfo thread function_88a043b99a75e47("container_gas_timeout");
  }
}

function function_ae4d9d04fb05bae9() {
  container = self;

  if(level.arrow.dvars.var_bce042bdea07b805 < 0) {
    return;
  }

  toofar = !scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(container.origin, level.arrow.dvars.var_bce042bdea07b805);

  if(istrue(toofar)) {
    teaminfo = level.arrow.teaminfo[container.targetteam];
    teaminfo thread function_88a043b99a75e47("container_gas_too_far");
  }
}

function function_71ebb660b298af07() {
  container = self;
  teaminfo = level.arrow.teaminfo[container.targetteam];
  teaminfo thread function_88a043b99a75e47("container_deleted_in_area_swap");
  return false;
}

function function_112636a06b12393b(instance, part, state, player, bautouse, usestring) {
  if(!isDefined(function_96a1620d901981d1(part, 8))) {
    return;
  }

  if(!instance function_d0daea8e27167bf7(player)) {
    player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/MISSION_OCCUPIED");
    return;
  }

  if(instance.elementref function_699d3afb882fd365() && !instance.elementref function_ec5207aaeb1d4ad9(player)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyequipnoroom);
    return;
  }

  if(state != "active_and_open") {
    instance function_3de18ba2e2c30e99(state);
  }
}

function function_d0daea8e27167bf7(player) {
  container = self;

  if(isDefined(container.instance)) {
    container = container.instance;
  }

  if(container.targetteam != player.team) {
    return false;
  }

  return true;
}

function function_699d3afb882fd365() {
  container = self;

  if(isDefined(container.instance)) {
    container = container.instance;
  }

  if(container function_e5e7df17c00ca60b() != "active_and_open") {
    return false;
  }

  return true;
}

function function_e5e7df17c00ca60b() {
  container = self;

  if(isDefined(container.containerref)) {
    container = container.containerref;
  }

  partname = container function_90069777043e7833()[0];
  curstate = container getscriptablepartstate(partname, 1);

  if(curstate == "hidden") {
    return "hidden";
  }

  if(curstate == "active_and_closed" || curstate == "opening" || curstate == "closing") {
    return "active_and_closed";
  }

  if(curstate == "active_and_open") {
    return "active_and_open";
  }

  if(curstate == "empty_and_open") {
    return "empty_and_open";
  }
}

function function_3182e44bb20cc5af(newstate) {
  container = self;
  partname = container function_90069777043e7833()[0];
  container setscriptablepartstate(partname, newstate);
}

function function_3de18ba2e2c30e99(state) {
  container = self;

  switch (state) {
    case #"hash_9fffec1a0638180a":
      container function_dc8599923c57ce27();
      break;
    case #"hash_fc2a8f30b7cb30ce":
      container function_d05ed5f3cd2d2166();
      break;
    case #"hash_503933de2afb1e9d":
    case #"hash_61f1a95d6bf95699":
    case #"hash_68f80f4802765df7":
    case #"hash_d96f543f1c0bdf24":
    default:
      break;
  }
}

function function_dc8599923c57ce27() {
  container = self;
  container notify("element_taken");
  container function_3182e44bb20cc5af("empty_and_open");
  container function_594eff9e3940a6ee();
}

function function_d05ed5f3cd2d2166() {
  container = self;
  container function_3182e44bb20cc5af("opening");
  container.elementref function_2622fb76607dece9(1);
  container function_362afd02a416e0e1(1);
  container function_3b7130b58a7c77b3("ground", container, 0, 0);
}

function function_e1d317dbd311185d(elementid, position, angles, player) {
  teaminfo = self;
  element = function_4c842789d2e221a8(elementid, position, angles);
  element function_d0e46d09a12dd2a9(player);
  return element;
}

function function_4c842789d2e221a8(elementid, position, angles) {
  teaminfo = self;
  element = undefined;

  switch (elementid) {
    case #"hash_21186d6c1b18ced6":
      element = teaminfo function_6b5ecebddc1c6ad3(elementid, position, angles);
      break;
    case #"hash_89183e6c51a64184":
      element = teaminfo function_6253104cc59c4f29(elementid, position, angles);
      break;
    case #"hash_6d3f826c438808be":
      element = teaminfo function_52dc4cb3754b675f(elementid, position, angles);
      break;
    case #"hash_fb365c6c0708aacb":
      element = teaminfo function_80f86d133491daf8(elementid, position, angles);
      break;
    case #"hash_f496fe6c03c5a155":
      element = teaminfo function_d35bbff23005617e(elementid, position, angles);
      break;
    case #"hash_4082276c2c059c84":
      element = teaminfo function_3b3b0f3703ebd7e5(elementid, position, angles);
      break;
    default:
      break;
  }

  return element;
}

function function_8b73cae3fc8903b2(elementid, var_4cf3f1d180aa34e7) {
  teaminfo = self;
  teaminfo function_f421381f1379bc3c(elementid, 1);
  element = spawnStruct();
  element.elementid = elementid;
  element.targetteam = teaminfo.targetteam;
  element.firstpickup = 1;
  element.var_a683e11bf953f9b7 = 0;
  element.spawntime = gettime();
  element.trackernumber = function_6844602f3120e900(elementid, 4);

  if(istrue(var_4cf3f1d180aa34e7)) {
    element.icon = "ui_map_icon_elite_crown";
    element function_68ef3e106ab2d16b(element.icon);
  } else {
    element.icon = function_6844602f3120e900(elementid, 2);
    element function_68ef3e106ab2d16b(undefined, teaminfo.targetteam, element.icon, undefined);
  }

  thread function_f2e1bf20e302f384(element);
  return element;
}

function function_aa97a28838886e60(player, dontcarry, var_4cf3f1d180aa34e7) {
  element = self;
  element function_43563f93a8af2e8c(var_4cf3f1d180aa34e7);

  if(istrue(dontcarry)) {
    return;
  }

  if(istrue(var_4cf3f1d180aa34e7) && !istrue(player.ismarked)) {
    element function_3b7130b58a7c77b3("player", player, 0, 0, undefined, var_4cf3f1d180aa34e7);
  }

  element function_11f9f12cf0115d10("player", player);
  function_54a65b932bb1233a(element, player);
}

function function_e80445bec743c7a9(player, var_4cf3f1d180aa34e7) {
  element = self;
  element function_43563f93a8af2e8c(var_4cf3f1d180aa34e7);

  if(istrue(element.cleanup)) {
    return;
  }

  if(istrue(var_4cf3f1d180aa34e7)) {
    element function_325031a0b2f983e4();
  } else {
    [iconent, iconoffset] = element function_2d501383cd6a7711();
    element function_3b7130b58a7c77b3("player", iconent, 0, 0, iconoffset);
  }

  element function_11f9f12cf0115d10("ground", player);
  function_efd43a8e0998d07d(element, player);
}

function function_325031a0b2f983e4() {
  element = self;
  teaminfo = level.arrow.teaminfo[element.targetteam];
  element.icon = function_6844602f3120e900(element.elementid, 2);
  element.scriptable function_68ef3e106ab2d16b(undefined, teaminfo.targetteam, element.icon, "ui_map_icon_elite_crown");
  [iconent, iconoffset] = element function_2d501383cd6a7711();
  element.scriptable function_3b7130b58a7c77b3("player", iconent, 0, 0, iconoffset);
}

function function_f67ac964313877a0(var_4cf3f1d180aa34e7) {
  element = self;
  element notify("element_cleanup");
  teaminfo = level.arrow.teaminfo[element.targetteam];

  if(!isDefined(teaminfo)) {
    return;
  }

  if(istrue(var_4cf3f1d180aa34e7)) {
    element function_43563f93a8af2e8c();
  }

  function_c34f3e1c188c4ee6(function_6844602f3120e900(element.elementid, 15), 0.6, element.trackernumber);
  teaminfo function_56ee84f1b091647a();
}

function function_11f9f12cf0115d10(state, player) {
  element = self;

  if(state == "player") {
    if(istrue(element.firstpickup)) {
      if(!istrue(level.arrow.dvars.var_b303983f30cb3658)) {
        showsplashtoteam(player.team, function_6844602f3120e900(element.elementid, 12));
      }

      waitframe();
    }
  }

  teaminfo = level.arrow.teaminfo[element.targetteam];

  if(!isDefined(teaminfo) || teaminfo.state == 0) {
    return;
  }

  if(state == "hidden") {
    teaminfo function_f0fe6459c0d406dc(function_6844602f3120e900(element.elementid, 13), 1, element.trackernumber);
    return;
  }

  if(state == "ground") {
    teaminfo function_f0fe6459c0d406dc(function_6844602f3120e900(element.elementid, 16), 1, element.trackernumber);
  }
}

function function_1448434d41f7a323(scriptable, position, angles) {
  var_f391bf01090b356c = spawnscriptable(scriptable, position, angles);
  var_f391bf01090b356c function_f3548416f24b0f48("hidden");
  scripts\mp\gametypes\br_pickups::clearspaceforscriptableinstance();
  scripts\mp\gametypes\br_pickups::registerscriptableinstance(var_f391bf01090b356c);
  var_f391bf01090b356c.criticalitem = 1;
  return var_f391bf01090b356c;
}

function function_8a43bda3f6befef4(position, angles) {
  element = self;
  lootid = function_6844602f3120e900(element.elementid, 5);
  backpackname = namespace_aead94004cf4c147::function_91c1be871300a518(lootid);
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, position, angles, undefined, undefined, undefined, undefined, undefined, undefined, 50000);
  scriptable = scripts\mp\gametypes\br_pickups::spawnpickup(backpackname, dropinfo, 1, 0, undefined, 0);
  scriptable.criticalitem = 1;
  return scriptable;
}

function function_a5cbe340384af146() {
  if(!isDefined(level.arrow.props.elements)) {
    return;
  }

  foreach(info in level.arrow.teaminfo) {
    if(!isDefined(info)) {
      continue;
    }

    function_c2ce67f5903927af(info.targetteam);
  }
}

function function_c2ce67f5903927af(targetteam) {
  if(!isDefined(level.arrow.props.elements) || !isDefined(level.arrow.props.elements[targetteam])) {
    return;
  }

  foreach(element in level.arrow.props.elements[targetteam]) {
    element function_c1f94114ae475307();
  }
}

function function_c1f94114ae475307() {
  element = self;

  if(!isDefined(element) || istrue(element.cleanup)) {
    return;
  }

  element.cleanup = 1;

  if(isDefined(element.player) && isDefined(element.itemindex)) {
    element.player namespace_aead94004cf4c147::function_db1dd76061352e5b(element.itemindex, 1);
  }

  if(isDefined(element.funccleanup)) {
    element[[element.funccleanup]]();
  }

  trackingcondition = element.alwaystrack || level.arrow.dvars.var_cf64cf3435a371df;
  element function_f67ac964313877a0(trackingcondition);
  element function_231aae2264ce7f2e();
  element function_7feb456a1ddb4048();
}

function function_7feb456a1ddb4048() {
  element = self;

  if(!isDefined(element.scriptable)) {
    return;
  }

  element.scriptable function_231aae2264ce7f2e();
  scripts\mp\gametypes\br_pickups::loothide(element.scriptable);
  element.scriptable = undefined;
}

function function_bc0879c9aa2863a3(player, instance, itemindex) {
  if(!instance function_668fa8d4516f7e15() && !instance function_5facfbee97e1a98e()) {
    return;
  }

  element = function_756a52f68962826(player, instance);

  if(!isDefined(element)) {
    return;
  }

  if(element function_668fa8d4516f7e15()) {
    element function_d0e46d09a12dd2a9(player);
  }

  element.itemindex = itemindex;
}

function function_6d070b6ad87fc4a2(player, var_26e51dc5f1cc490, var_41dcbc4d3302f6dc, var_8541e31967f0d3c1, var_b6f2154b2fe59e35) {
  firstelement = undefined;
  var_56a8547611c8ad7a = function_96a1620d901981d1(var_26e51dc5f1cc490, 5);

  if(isDefined(var_56a8547611c8ad7a)) {
    firstelement = function_3a3d1bccf139dd5b(player, var_56a8547611c8ad7a, var_8541e31967f0d3c1);
  }

  secondelement = undefined;
  var_87818652e195c716 = function_96a1620d901981d1(var_41dcbc4d3302f6dc, 5);

  if(isDefined(var_87818652e195c716)) {
    secondelement = function_3a3d1bccf139dd5b(player, var_87818652e195c716, var_b6f2154b2fe59e35);
  }

  if(isDefined(firstelement)) {
    firstelement.itemindex = var_b6f2154b2fe59e35;
  }

  if(isDefined(secondelement)) {
    secondelement.itemindex = var_8541e31967f0d3c1;
  }
}

function function_756a52f68962826(player, instance) {
  element = undefined;

  if(isDefined(instance.elementref)) {
    element = instance.elementref;
  } else if(isDefined(instance.instance)) {
    element = instance.instance.elementref;
  } else if(isDefined(instance.scriptablename)) {
    elementid = function_96a1620d901981d1(instance.scriptablename, 0);
    element = level.arrow.props.elements[player.team][elementid];
  }

  element.elementindex = function_6844602f3120e900(element.elementid, 6);
  return element;
}

function function_d0e46d09a12dd2a9(player, dontcarry) {
  element = self;

  if(!element function_bd7732605a7843b2(player) && !istrue(dontcarry)) {
    player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/MISSION_OCCUPIED");
    return false;
  }

  if(!element function_ec5207aaeb1d4ad9(player)) {
    player scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyequipnoroom);
    return false;
  }

  element thread function_467f0b7ed16d1567(player, dontcarry);

  if(isDefined(element.containerref)) {
    element.containerref function_3de18ba2e2c30e99(element.containerref function_e5e7df17c00ca60b());
  }

  return istrue(dontcarry);
}

function function_467f0b7ed16d1567(player, dontcarry) {
  element = self;
  bombsite = level.arrow.props.bombsite;
  element notify("on_pickup");

  if(!istrue(dontcarry)) {
    element.player = player;
    element.gastime = undefined;
  }

  element function_d13b7dacbaaedca(player);

  if(isDefined(element.funcpickup)) {
    element[[element.funcpickup]](player, dontcarry);
  }

  trackingcondition = element.alwaystrack || level.arrow.dvars.var_cf64cf3435a371df;
  element function_aa97a28838886e60(player, dontcarry, trackingcondition);
  element function_7ff595f68388541d(player);
  element function_405b5950c66270e8();
}

function function_405b5950c66270e8() {
  element = self;
  bombsite = level.arrow.props.bombsite;
  teaminfo = level.arrow.teaminfo[element.targetteam];
  var_ba9b215007eb7888 = teaminfo function_1a9ee6a7092d4536();

  if(istrue(bombsite.siterevealed) && istrue(var_ba9b215007eb7888)) {
    teaminfo.state = 3;
    function_566ebf0873178b74(&"BR_ELITE_BROKEN_ARROW/DEPOSIT_ELEMENTS");
  } else if(istrue(bombsite.dropping) && istrue(var_ba9b215007eb7888)) {
    teaminfo.state = 2;
    function_566ebf0873178b74(&"BR_ELITE_BROKEN_ARROW/WAITING_BOMB");
  }

  teaminfo function_56ee84f1b091647a();
}

function function_7ff595f68388541d(player) {
  element = self;
  teaminfo = level.arrow.teaminfo[element.targetteam];

  if(!istrue(element.firstpickup)) {
    return;
  }

  element.firstpickup = 0;
  teaminfo.firstpickups++;
  teaminfo notify("element_pickup_first");
  teaminfo function_99c99b2e9b72c23e(element, player);
  teaminfo.var_876be3bc4df3a81d |= function_2c126de0bdb9bfd5(element.elementindex);
  element function_8828a851c96aec21();
  scripts\mp\gametypes\br_analytics::function_f36c99358d254ea9(player, element);
  teaminfo function_24b7e8db343a8d77(player);
  teaminfo thread function_1c9697e4221d99a5();
}

function function_8828a851c96aec21() {
  element = self;
  teaminfo = level.arrow.teaminfo[element.targetteam];
  musicplayers = scripts\mp\music_and_dialog::function_aecafe54c65c0e35(level.players);
  var_d5b74fd05ce437e0 = function_17ee301cf0b5ba85("br_cq_element");
  var_c31f2501156b196b = function_17ee301cf0b5ba85("br_cq_element_classic");
  delaythread(0.8, &function_fe75a89529dd0fd0, musicplayers, var_d5b74fd05ce437e0, undefined, undefined, var_c31f2501156b196b);

  if(isDefined(game["dialog"]["arrow_collect_element_" + teaminfo.firstpickups])) {
    teaminfo function_bf0175f3bb67a26d("arrow_collect_element_" + teaminfo.firstpickups);
  }

  if(teaminfo.firstpickups >= level.arrow.props.bombsite.neededelements.size) {
    teaminfo function_4da2fedd08554c6e("arrow_collect_element_all");
    return;
  }

  if(isDefined(game["dialog"]["arrow_alert_element_intro_" + teaminfo.firstpickups])) {
    teaminfo function_4da2fedd08554c6e("arrow_alert_element_intro_" + teaminfo.firstpickups, 0);
  }

  if(isDefined(game["dialog"]["arrow_alert_element_" + teaminfo.firstpickups])) {
    teaminfo function_4da2fedd08554c6e("arrow_alert_element_" + teaminfo.firstpickups);
  }
}

function function_99c99b2e9b72c23e(element, player) {
  teaminfo = self;
  bombsite = level.arrow.props.bombsite;

  if(istrue(level.arrow.dvars.var_b303983f30cb3658)) {
    return;
  }

  function_d95a7788bf7ce976(element, player);

  if(teaminfo.firstpickups == bombsite.neededelements.size) {
    if(istrue(level.arrow.dvars.var_704052379a5c7c57)) {
      showsplashtoteam(teaminfo.targetteam, function_130af1b9f6740479("elite_arrow_elements_acquired"));
    }

    if(!isDefined(level.arrow.var_5225cfa34334f492)) {
      showsplashtoallexceptteam(teaminfo.targetteam, function_130af1b9f6740479("elite_arrow_elements_acquired_global"), undefined, player);
      level.arrow.var_5225cfa34334f492 = 1;
    }
  }
}

function function_d95a7788bf7ce976(element, player) {
  teaminfo = self;

  if(istrue(level.arrow.dvars.var_b303983f30cb3658)) {
    return;
  }

  elementflags = 0;

  foreach(team in level.arrow.teaminfo) {
    elementflags |= team.var_876be3bc4df3a81d;
  }

  alreadyfound = elementflags &function_2c126de0bdb9bfd5(element.elementindex);

  if(!alreadyfound) {
    splashid = function_6844602f3120e900(element.elementid, 11);

    if(isDefined(splashid)) {
      showsplashtoallexceptteam(element.targetteam, splashid, undefined, player);
    }
  }
}

function function_bd7732605a7843b2(player) {
  element = self;

  if(!isDefined(level.arrow)) {
    return false;
  }

  if(level.arrow.dvars.elementinteract == 2) {} else if(level.arrow.dvars.elementinteract == 1) {
    if(!isDefined(level.arrow.teaminfo[player.team])) {
      return false;
    }

    if(level.arrow.teaminfo[player.team].state == 0) {
      return false;
    }
  } else if(level.arrow.dvars.elementinteract == 0) {
    if(element.targetteam != player.team) {
      return false;
    }
  }

  return true;
}

function function_ec5207aaeb1d4ad9(player) {
  element = self;

  if(isDefined(element.itemindex)) {
    backpackelement = function_3a3d1bccf139dd5b(player, element.elementid, element.itemindex);

    if(isDefined(backpackelement) && backpackelement == element) {
      return true;
    }
  }

  lootid = function_6844602f3120e900(element.elementid, 5);

  if(!player namespace_aead94004cf4c147::canitemfitinbackpack(lootid, 1)) {
    return false;
  }

  return true;
}

function function_24b7e8db343a8d77(player) {
  teaminfo = self;
  bombsite = level.arrow.props.bombsite;

  if(level.arrow.dvars.scriptedflow != 0) {
    return;
  }

  if(teaminfo.firstpickups < bombsite.neededelements.size) {
    return;
  }

  if(istrue(level.arrow.dvars.debug) && level.arrow.debugstate == 8) {
    return;
  }

  bombsite thread arrow_bombsitereveal(player);
}

function function_1c9697e4221d99a5() {
  if(!istrue(level.arrow.dvars.var_9719a1f9940e8a89)) {
    return;
  }

  teaminfo = self;
  bombsite = level.arrow.props.bombsite;

  if(teaminfo.firstpickups < bombsite.neededelements.size) {
    return;
  }

  if(isDefined(level.arrow.var_d595b9af4509bee5)) {
    return;
  }

  level.arrow.var_d595b9af4509bee5 = 1;

  if(istrue(level.arrow.dvars.var_fb5c6a73584df0c1)) {
    scripts\mp\gametypes\br_publicevents::function_44424d94254dfaf5();
  }

  waittime = level.arrow.dvars.var_32b459c0d029b500;

  if(isDefined(waittime) && waittime > 0) {
    wait waittime;
  }

  eventtype = % "jailbreak";
  skipwait = 1;
  level thread scripts\mp\gametypes\br_publicevents::runpubliceventoftype(eventtype, skipwait);
}

function function_28ecfd94dda4d7fd() {
  scriptable = self;
  element = scriptable.elementref;

  if(!isDefined(element)) {
    return false;
  }

  element thread function_da26bb2730074639();
  return true;
}

function function_da26bb2730074639() {
  element = self;
  teaminfo = level.arrow.teaminfo[element.targetteam];
  level endon("game_ended");
  teaminfo endon("on_end");
  position = element.scriptable.origin;
  angles = element.scriptable.angles;
  element function_7feb456a1ddb4048();
  wait 0.25;

  if(istrue(element.cleanup)) {
    return;
  }

  scriptable = element function_8a43bda3f6befef4(position, angles);
  element function_545f24b9213213fe(undefined, scriptable);
}

function function_a5130b39363778b7(player, instance, itemindex) {
  if(!instance function_668fa8d4516f7e15()) {
    return;
  }

  elementid = function_96a1620d901981d1(instance.type, 0);
  element = function_3a3d1bccf139dd5b(player, elementid, itemindex);

  if(!isDefined(element)) {
    return;
  }

  element function_545f24b9213213fe(player, instance);
}

function function_545f24b9213213fe(player, instance) {
  element = self;

  if(isDefined(instance)) {
    element thread function_b28c6d87ea4cae30();
    instance.criticalitem = 1;
    instance.elementref = element;
    element.scriptable = instance;
  }

  if(isDefined(element.funcdrop)) {
    element[[element.funcdrop]](player);
  }

  trackingcondition = element.alwaystrack || level.arrow.dvars.var_cf64cf3435a371df;
  element function_e80445bec743c7a9(player, trackingcondition);
  element.player = undefined;
  element.itemindex = undefined;
  teaminfo = level.arrow.teaminfo[element.targetteam];
  teaminfo function_56ee84f1b091647a();
}

function function_65336e6b7ecd0bfc(elementindex) {
  heightoffset = -60 + 12 * elementindex;
  return heightoffset;
}

function function_b28c6d87ea4cae30() {
  element = self;
  element notify("watch_circle");
  element endon("watch_circle");
  element endon("on_pickup");
  level endon("game_ended");

  if(level.arrow.dvars.var_572bb4c60df2d1b1 <= 0) {
    return;
  }

  while(true) {
    wait level.arrow.dvars.var_572bb4c60df2d1b1;

    if(!isDefined(element.scriptable)) {
      return;
    }

    ingas = !istrue(level.br_circle_disabled) && !scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(element.scriptable.origin);

    if(!istrue(ingas)) {
      continue;
    }

    element function_25814d59f2ccd689();
    element function_411359cd8df47da0();
  }
}

function function_25814d59f2ccd689() {
  element = self;

  if(level.arrow.dvars.elementgastime < 0) {
    return;
  }

  if(!isDefined(element.gastime)) {
    element.gastime = 0;
  }

  element.gastime += level.arrow.dvars.var_572bb4c60df2d1b1;

  if(element.gastime >= level.arrow.dvars.elementgastime) {
    function_9eac0670a84449a5(element.targetteam);
    teaminfo = level.arrow.teaminfo[element.targetteam];

    if(!isDefined(teaminfo)) {
      return;
    }

    teaminfo thread function_88a043b99a75e47("element_gas_timeout");
  }
}

function function_411359cd8df47da0() {
  element = self;

  if(level.arrow.dvars.var_572d9f41a62cc17c < 0) {
    return;
  }

  if(!isDefined(element) || !isDefined(element.scriptable) || !isDefined(element.scriptable.origin)) {
    return;
  }

  toofar = !scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(element.scriptable.origin, level.arrow.dvars.var_572d9f41a62cc17c);

  if(istrue(toofar)) {
    function_9eac0670a84449a5(element.targetteam);
    teaminfo = level.arrow.teaminfo[element.targetteam];

    if(!isDefined(teaminfo)) {
      return;
    }

    teaminfo thread function_88a043b99a75e47("element_gas_too_far");
  }
}

function function_f92179dcf9d84bc9(player, elementid, itemindex) {
  bombsite = self;
  teaminfo = level.arrow.teaminfo[player.team];
  teaminfo endon("on_end");
  element = function_3a3d1bccf139dd5b(player, elementid, itemindex);

  if(isDefined(element) && istrue(element.cleanup)) {
    return;
  }

  bombsite.neededelements[elementid]++;
  bombsite function_517e2f9457967425(elementid);
  function_20238d522c76fb01();
  function_5e7fdf58f111f041();

  if(isDefined(element)) {
    element function_c1f94114ae475307();
  }

  bombsite function_1395e6fa844b959f(player);

  if(function_10451fcedd4d3d6e()) {
    bombsite arrow_bombsitearm(player);
  }
}

function function_517e2f9457967425(elementid) {
  bombsite = self;
  placedcount = 0;

  foreach(element in level.arrow.elementlist) {
    placedcount += bombsite.neededelements[element.elementid];
  }

  foreach(teaminfo in level.arrow.teaminfo) {
    if(!isDefined(teaminfo)) {
      continue;
    }

    if(!isDefined(level.arrow.props.elements[teaminfo.targetteam])) {
      continue;
    }

    level.arrow.props.elements[teaminfo.targetteam][elementid].var_a683e11bf953f9b7 = placedcount;
  }
}

function function_97c5201a39c968e4() {
  element = self;

  if(!isDefined(element.scriptable)) {
    return "hidden";
  }

  partname = element.scriptable function_90069777043e7833()[0];
  curstate = element.scriptable getscriptablepartstate(partname, 1);
  return curstate;
}

function function_f3548416f24b0f48(newstate) {
  element = self;

  if(!isDefined(element)) {
    return;
  }

  partname = element function_90069777043e7833()[0];
  element setscriptablepartstate(partname, newstate);
}

function function_e6b87eeb3abc7be0(elementid) {
  var_60387512cf7da15d = [];

  if(!isDefined(elementid) || !isDefined(level.arrow.props.elements)) {
    return var_60387512cf7da15d;
  }

  foreach(teamelements in level.arrow.props.elements) {
    if(isDefined(teamelements[elementid])) {
      var_60387512cf7da15d = array_add(var_60387512cf7da15d, teamelements[elementid]);
    }
  }

  return var_60387512cf7da15d;
}

function function_ff94744f234460c9(oldteam, newteam) {
  if(!isDefined(level.arrow.props.elements[oldteam])) {
    return;
  }

  foreach(element in level.arrow.props.elements[oldteam]) {
    element.targetteam = newteam;
    element.firstpickup = 1;
    level.arrow.props.elements[newteam][element.elementid] = element;
  }

  level.arrow.props.elements[oldteam] = undefined;
}

function function_d13b7dacbaaedca(player) {
  element = self;

  if(!isDefined(level.arrow.props.elements[player.team][element.elementid])) {
    element.targetteam = player.team;
    element.firstpickup = 1;
    level.arrow.props.elements[player.team][element.elementid] = element;
  }
}

function function_1c40b75acdd5af37(newstate) {
  iconstate = undefined;

  if(newstate == "dropped" || newstate == "visible") {
    iconstate = "ground";
  } else if(newstate == "hidden") {
    iconstate = "player";
  }

  return iconstate;
}

function function_3957d8d2ea023852(player, isvisible) {
  teaminfo = level.arrow.teaminfo[player.team];

  if(!isDefined(teaminfo) || !isDefined(level.arrow.props.elements)) {
    return;
  }

  if(isDefined(level.arrow.props.elements[teaminfo.targetteam])) {
    foreach(element in level.arrow.props.elements[teaminfo.targetteam]) {
      element function_b63a22f9943a3ae8(player, isvisible);

      if(isDefined(element.scriptable)) {
        element.scriptable function_b63a22f9943a3ae8(player, isvisible);
      }
    }
  }
}

function function_37daa6a08797b2cc() {
  elementinstance = self;
  element = elementinstance.elementref;

  if(isDefined(element)) {
    teaminfo = level.arrow.teaminfo[element.targetteam];
    teaminfo thread function_88a043b99a75e47("element_deleted_in_area_swap");
    return false;
  }

  return true;
}

function function_f045c586f2d204ce(player, isvisible, teamoverride) {
  if(!isDefined(level.arrow.props.containers)) {
    return;
  }

  containers = undefined;

  if(isDefined(teamoverride)) {
    containers = level.arrow.props.containers[teamoverride];
  } else {
    containers = level.arrow.props.containers[player.team];
  }

  if(!isDefined(containers)) {
    return;
  }

  foreach(container in containers) {
    if(isDefined(container)) {
      container function_f5549984b1909638(player, isvisible);
    }
  }
}

function function_a7ee3a5e548c916e(player, elementid, isvisible) {
  if(isDefined(level.arrow.props.elements)) {
    foreach(teamelements in level.arrow.props.elements) {
      targetelement = teamelements[elementid];

      if(!isDefined(targetelement)) {
        continue;
      }

      targetelement function_b63a22f9943a3ae8(player, isvisible);

      if(isDefined(targetelement.scriptable)) {
        targetelement.scriptable function_b63a22f9943a3ae8(player, isvisible);
      }
    }
  }
}

function function_43563f93a8af2e8c(var_4cf3f1d180aa34e7) {
  element = self;
  element function_594eff9e3940a6ee(var_4cf3f1d180aa34e7);

  if(isDefined(element.scriptable)) {
    element.scriptable function_594eff9e3940a6ee(var_4cf3f1d180aa34e7);
  }
}

function function_2d501383cd6a7711() {
  element = self;
  iconent = element.var_db4005060a0c66af;

  if(isDefined(element.scriptable) && isDefined(element.scriptable.linkedparent) && !istrue(element.scriptable.linkedparent.isdestroyed)) {
    iconent = element.scriptable.linkedparent;
  }

  iconoffset = (0, 0, 25);

  if(iconent == element.var_db4005060a0c66af) {
    return [iconent, iconoffset];
  }

  iconoffset = (0, 0, 80);
  return [iconent, iconoffset];
}

function function_2622fb76607dece9(toenable) {
  element = self;

  switch (element.elementid) {
    case #"hash_6d3f826c438808be":
      element function_3b1ecb2735cf8c88(istrue(toenable));

      if(istrue(toenable)) {
        element function_ee40ba68ef2e28ac();
      }

      return;
    case #"hash_89183e6c51a64184":
      element function_4f4f8b0cc0803fc3(istrue(toenable));
      return;
    case #"hash_4082276c2c059c84":
      element function_8932eca89649c982();
      return;
    case #"hash_fb365c6c0708aacb":
      element function_8e9c04aa5fa8a3db();
      return;
  }
}

function function_775f98c18204823e() {
  element = self;

  if(isDefined(element.player)) {
    if(isDefined(element.player.vehicle) && scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(element.player)) {
      return element.player.vehicle;
    } else {
      return element.player;
    }
  }

  return undefined;
}

function function_a67115af2229f2f4() {
  element = self;
  carrierent = element function_775f98c18204823e();

  if(isDefined(carrierent)) {
    return carrierent;
  } else if(isDefined(element.scriptable)) {
    return element.scriptable;
  } else if(isDefined(element.elementid) && isDefined(level.arrow.props.containers) && isDefined(level.arrow.props.containers[element.targetteam])) {
    return level.arrow.props.containers[element.targetteam][element.elementid];
  }

  return undefined;
}

function function_2774b40f1e337be5(position, radius, r0, r1, r2, r3, r4, r5) {
  isdebug = getdvarint(@ "hash_a5cf65fd90079e7b", 0);

  if(isdebug) {
    player = level.players[0];

    if(isPlayer(player) && !isbot(player) && !isagent(player)) {
      color = (1, 1, 1);
      dist = distance(player.origin, position);

      if(dist <= r0) {
        color = (1, 0.5, 0.5);
      } else if(dist <= r1) {
        color = (1, 0.3, 0.125);
      } else if(dist <= r2) {
        color = (1, 0.5, 0);
      } else if(dist <= r3) {
        color = (1, 0.75, 0.5);
      } else if(dist <= r4) {
        color = (1, 1, 0.5);
      } else if(dist <= r5) {
        color = (1, 1, 0.75);
      }

      print3d(position, "<dev string:x4ad>" + int(dist), color, 1, 0.666, 1, 1);
    }

    sphere(position, 7.5, (1, 0.25, 0.25), 0, 1);
    sphere(position, radius, (1, 0.25, 0.25), 0, 1);
  }
}

function function_8d5ec92683359a75(distsq, diststates) {
  foreach(dist, state in diststates) {
    distsqstate = squared(dist);

    if(distsq <= distsqstate) {
      return state;
    }
  }

  return "off";
}

function function_d24209600567366f(distsq, distdelays) {
  foreach(dist, delays in distdelays) {
    distsqdelay = squared(dist);

    if(distsq <= distsqdelay) {
      delaymin = delays[0];
      delaymax = delays[1];
      delay = randomfloatrange(delaymin, delaymax);
      return delay;
    }
  }

  return undefined;
}

function function_80b2be1e9631485f(element, player, distdelays, diststates) {
  level endon("game_ended");
  player endon("disconnect");
  assert(isDefined(element.elementid));
  player.var_248f319d9c9f6c51[element.elementid] = getthread();

  while(!istrue(element.cleanup)) {
    elemententity = element function_a67115af2229f2f4();

    if(isDefined(elemententity)) {
      distsq = distancesquared(player.origin, elemententity.origin);

      if(level.arrow.dvars.var_8ef9f58b6a7afe93 == 0 || level.arrow.dvars.var_8ef9f58b6a7afe93 == 1) {
        delay = function_d24209600567366f(distsq, distdelays);

        if(isnumber(delay)) {
          if(isDefined(element.var_db4005060a0c66af)) {
            element.var_db4005060a0c66af playsoundtoplayer("evt_elite_arrow_geiger_counter_tick", player, element.var_db4005060a0c66af);
          } else {
            player playlocalsound("evt_elite_arrow_geiger_counter_tick");
          }

          wait delay;
        } else {
          break;
        }
      } else if(level.arrow.dvars.var_8ef9f58b6a7afe93 == 2) {
        state = function_8d5ec92683359a75(distsq, diststates);
        player.var_8466be2ab0ab5d00[element.elementid] = distsq;
        waittillframeend();
        closestdistsq = distsq;
        var_f29efe66d0f3f9e5 = element.elementid;

        if(isarray(player.var_8466be2ab0ab5d00)) {
          foreach(elementid, elementdistsq in player.var_8466be2ab0ab5d00) {
            if(elementdistsq < closestdistsq) {
              closestdistsq = elementdistsq;
              var_f29efe66d0f3f9e5 = elementid;
            }
          }
        }

        if(var_f29efe66d0f3f9e5 == element.elementid) {
          if(!isDefined(player.var_7ed9253d93e7c6bd) || player.var_7ed9253d93e7c6bd != state) {
            player.var_7ed9253d93e7c6bd = state;
            player setscriptablepartstate("geiger", state, 0);
          }
        }

        if(state == "off") {
          break;
        } else {
          waitframe();
        }
      }

      continue;
    }

    waitframe();
  }

  if(isarray(player.var_8466be2ab0ab5d00)) {
    player.var_8466be2ab0ab5d00[element.elementid] = undefined;
  }

  player.var_248f319d9c9f6c51[element.elementid] = undefined;
}

function function_f2e1bf20e302f384(element, radius) {
  level endon("game_ended");
  element notify("stop_element_geiger");
  element endon("stop_element_geiger");
  level.arrow.dvars.var_8ef9f58b6a7afe93 = getdvarint(@ "hash_d2b336a16e9b3f70", 1);
  level.arrow.dvars.var_716235bddfb305f0 = getdvarint(@ "hash_98cb40fb319bcd47", 2304);
  dvardist = getdvarint(@ "hash_98cb40fb319bcd47", 2304);
  radius = default_to(radius, dvardist);
  r0 = int(radius * 0.03125);
  r1 = int(radius * 0.0625);
  r2 = int(radius * 0.125);
  r3 = int(radius * 0.25);
  r4 = int(radius * 0.5);
  r5 = int(radius * 1);
  distdelays = [];
  distdelays[r0] = [0.01, 0.02];
  distdelays[r1] = [0.02, 0.05];
  distdelays[r2] = [0.05, 0.1];
  distdelays[r3] = [0.1, 0.2];
  distdelays[r4] = [0.2, 0.5];
  distdelays[r5] = [0.5, 1];
  diststates = [];
  diststates[r0] = "100cps";
  diststates[r1] = "50cps";
  diststates[r2] = "20cps";
  diststates[r3] = "10cps";
  diststates[r4] = "5cps";
  diststates[r5] = "2cps";

  if(level.arrow.dvars.var_8ef9f58b6a7afe93 == 1) {
    element.var_db4005060a0c66af = spawn("script_model", (0, 0, 0));
    element.var_db4005060a0c66af setModel("tag_origin");
  }

  while(!istrue(element.cleanup)) {
    elemententity = element function_a67115af2229f2f4();

    if(isDefined(elemententity)) {
      position = elemententity.origin + (0, 0, 7.5);

      if(isent(element.var_db4005060a0c66af)) {
        element.var_db4005060a0c66af.origin = elemententity.origin + (0, 0, 7.5);
        position = element.var_db4005060a0c66af.origin;
      }

      players = getentarrayinradius("player", "classname", position, radius);

      foreach(player in players) {
        var_690f868c45a96061 = isarray(player.var_248f319d9c9f6c51) && isDefined(player.var_248f319d9c9f6c51[element.elementid]);

        if(!var_690f868c45a96061) {
          player thread function_80b2be1e9631485f(element, player, distdelays, diststates);
        }
      }

      function_2774b40f1e337be5(position, radius, r0, r1, r2, r3, r4, r5);
    }

    waitframe();
  }

  if(isent(element.var_db4005060a0c66af)) {
    element.var_db4005060a0c66af delete();
    element.var_db4005060a0c66af = undefined;
  }
}

function function_f8bd2935a988bb02() {
  element = self;
  element.outlineids = [];
  element.outlineplayers = [];
}

function function_ba8f494325ede6d7(outlinetype) {
  element = self;

  if(isDefined(element.outlineplayers)) {
    foreach(var_18ebeb29bb7541e3 in element.outlineplayers) {
      element function_653c2166507f3631(var_18ebeb29bb7541e3);
      element function_e62674d5de7043f9(var_18ebeb29bb7541e3, outlinetype);
    }
  }

  element.outlineids = undefined;
  element.outlineplayers = undefined;
}

function function_e62674d5de7043f9(player, outlinetype) {
  element = self;
  level endon("game_ended");
  player endon("death_or_disconnect");
  element endon("element_cleanup");

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  if(istrue(player.var_6b4ccfef38537183)) {
    player scripts\mp\utility\outline::_hudoutlineviewmodelenable(outlinetype, 0);
    return;
  }

  player scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
}

function function_f3711bf7ce3191d0(var_18ebeb29bb7541e3, outlinetype, prioritygroup) {
  element = self;
  var_cf03c60b371eff98 = var_18ebeb29bb7541e3 getentitynumber();
  id = scripts\mp\utility\outline::outlineenableforall(var_18ebeb29bb7541e3, outlinetype, prioritygroup);
  element.outlineids[var_cf03c60b371eff98] = id;
  element.outlineplayers[var_cf03c60b371eff98] = var_18ebeb29bb7541e3;
  var_18ebeb29bb7541e3.var_6b4ccfef38537183 = 1;
}

function function_653c2166507f3631(var_18ebeb29bb7541e3) {
  element = self;

  if(!isDefined(var_18ebeb29bb7541e3)) {
    return;
  }

  var_cf03c60b371eff98 = var_18ebeb29bb7541e3 getentitynumber();
  id = element.outlineids[var_cf03c60b371eff98];

  if(isDefined(id)) {
    scripts\mp\utility\outline::outlinedisable(id, var_18ebeb29bb7541e3);
  }

  element.outlineids[var_cf03c60b371eff98] = undefined;
  element.outlineplayers[var_cf03c60b371eff98] = undefined;
  var_18ebeb29bb7541e3.var_6b4ccfef38537183 = undefined;
}

function function_37748ef3982539d4(player, state, outlinetype) {
  element = self;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  foreach(playervisible in element.outlineplayers) {
    if(!isDefined(playervisible)) {
      continue;
    }

    if(state) {
      playervisible hudoutlineenableforclient(player, outlinetype);
      continue;
    }

    playervisible hudoutlinedisableforclient(player);
  }
}

function function_a65b28a8fa9423e8(player) {
  if(!isPlayer(player) || !isalive(player)) {
    return false;
  }

  if(player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
    return false;
  }

  if(istrue(player.var_6b4ccfef38537183)) {
    return false;
  }

  return true;
}

function function_54a65b932bb1233a(element, player) {
  player setsoundsubmix("mute_scripted5", 0.1, 0.5);
  player playlocalsound("evt_elite_arrow_element_pickup_swt");
}

function function_efd43a8e0998d07d(element, player) {
  if(!isDefined(player)) {
    return;
  }

  player clearsoundsubmix("mute_scripted5", 0);
}

function function_b2e040ef75de3602(position, radius, height) {
  element = self;
  trigger = spawn("trigger_rotatable_radius", position, 0, radius, height);
  trigger.radius = radius;
  trigger.height = height;
  trigger.element = element;
  trigger enablelinkTo();
  return trigger;
}

function function_cf631f26161504db(trigger, linkent) {
  if(!isDefined(trigger)) {
    return;
  }

  if(trigger islinked()) {
    trigger unlink();
  }

  trigger notify("trigger_link");

  if(!isDefined(linkent) || !isDefined(linkent.origin)) {
    return;
  }

  trigger.origin = linkent.origin;
  offsetz = function_aa8daa8be6051112(trigger);
  trigger.origin -= (0, 0, offsetz);

  if(isent(linkent)) {
    trigger linkTo(linkent);
    return;
  }

  thread function_ecb3f178e27990b3(trigger, linkent);
}

function function_ecb3f178e27990b3(trigger, linkent) {
  trigger endon("trigger_link");
  trigger endon("destroy");
  linkent endon("destroy");
  offsetz = function_aa8daa8be6051112(trigger);

  while(true) {
    wait 0.25;

    if(!isDefined(trigger) || !isDefined(linkent) || !isDefined(linkent.origin)) {
      return;
    }

    trigger.origin = linkent.origin;
    trigger.origin -= (0, 0, offsetz);
  }
}

function function_aa8daa8be6051112(trigger) {
  if(isDefined(trigger.height)) {
    return (trigger.height * level.arrow.dvars.triggerheightoffset);
  }

  return 0;
}

function function_b15e5ba7931dbb41() {
  element = self;
  trigger = element.trigger;

  if(!isDefined(trigger)) {
    return;
  }

  trigger notify("destroy");
  trigger delete();
  element.trigger = undefined;
}

function function_1f21ab99f974fb93(player, trigger, force, ignoreheld) {
  if(!isPlayer(player) || !isalive(player) || !isDefined(trigger)) {
    return;
  }

  if(!player istouching(trigger) && !istrue(force)) {
    return;
  }

  element = trigger.element;

  if(!isDefined(element)) {
    return;
  }

  if(function_af54a33c2ac9a71f(player, element.elementid) && !istrue(ignoreheld)) {
    return;
  }

  if(!isDefined(trigger.nearbyplayers)) {
    trigger.nearbyplayers = [];
  }

  trigger.nearbyplayers[player.clientid] = player;
}

function function_44b8aae5bcdc3081(vehicle, trigger) {
  if(!isDefined(vehicle) || !isDefined(vehicle.occupants)) {
    return;
  }

  waitframe();

  foreach(occupant in vehicle.occupants) {
    function_1f21ab99f974fb93(occupant, trigger, 1);
  }
}

function function_95f74c4eedbbd627(player, trigger, force) {
  if(!isDefined(player) || !isPlayer(player) || !isDefined(trigger)) {
    return;
  }

  if(player istouching(trigger) && !istrue(force)) {
    return;
  }

  element = trigger.element;

  if(!isDefined(element)) {
    return;
  }

  if(isDefined(trigger.nearbyplayers)) {
    trigger.nearbyplayers[player.clientid] = undefined;
  }
}

function function_685375bba20333ad(vehicle, trigger) {
  if(!isDefined(vehicle) || !isDefined(vehicle.occupants)) {
    return;
  }

  waitframe();

  foreach(occupant in vehicle.occupants) {
    function_95f74c4eedbbd627(occupant, trigger, 1);
  }
}

function function_6b5ecebddc1c6ad3(elementid, position, angles) {
  teaminfo = self;
  beryllium = teaminfo function_8b73cae3fc8903b2(elementid, 1);
  beryllium.alwaystrack = 1;
  beryllium.funcpickup = &function_bc553bd4c6c01245;
  beryllium.funcdrop = &function_b30b6186d630078c;
  beryllium.funccleanup = &function_1ae09b9b6a2ff850;
  return beryllium;
}

function function_1ae09b9b6a2ff850() {
  beryllium = self;
  beryllium function_ba8f494325ede6d7("outline_nodepth_red");
}

function function_bc553bd4c6c01245(player, dontcarry) {
  beryllium = self;

  if(istrue(level.arrow.dvars.var_adc0fad3f842d68f)) {
    beryllium function_ba8f494325ede6d7("outline_nodepth_red");
  }

  if(istrue(dontcarry)) {
    return;
  }
}

function function_b30b6186d630078c(player) {
  beryllium = self;
  beryllium function_3f1e807772a2b6fa();
}

function function_3f1e807772a2b6fa(resettime) {
  beryllium = self;

  if(!istrue(level.arrow.dvars.beroutline)) {
    return;
  }

  beryllium function_f8bd2935a988bb02();

  if(!isDefined(beryllium.outlinetime) || istrue(resettime)) {
    beryllium.outlinetime = 0;
  }

  beryllium thread function_10935396a23fda6();
}

function function_10935396a23fda6() {
  beryllium = self;
  level endon("game_ended");
  beryllium endon("death");
  beryllium endon("on_pickup");

  while(!istrue(self.cleanup)) {
    beryllium.outlinetime += level.arrow.dvars.var_ec24cb21c7f05967;

    if(beryllium.outlinetime >= level.arrow.dvars.var_879711b450fd9dce) {
      beryllium function_58a5ee48f095667b();
      beryllium.outlinetime = 0;
    }

    wait level.arrow.dvars.var_ec24cb21c7f05967;
  }
}

function function_58a5ee48f095667b() {
  beryllium = self;
  teammates = getteamdata(beryllium.targetteam, "players");

  foreach(player in teammates) {
    if(!beryllium function_a65b28a8fa9423e8(player)) {
      continue;
    }

    beryllium thread function_76d0ab1fd73ea3b3(player);
  }
}

function function_76d0ab1fd73ea3b3(player) {
  beryllium = self;
  level endon("game_ended");
  beryllium endon("death");
  beryllium endon("on_pickup");
  beryllium function_2b6cce6f0fa08de1(player);
  wait level.arrow.dvars.var_187b15d0d681ed14;
  beryllium function_e62b6844db038d40(player);
}

function function_2b6cce6f0fa08de1(player) {
  beryllium = self;
  beryllium function_f3711bf7ce3191d0(player, "outline_nodepth_red", "level_script");
  beryllium thread function_d6de0c68a45378ff(player);
}

function function_d6de0c68a45378ff(player) {
  beryllium = self;
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("ber_outline_end");
  function_7b9e0e7ca4b3b940(beryllium, "death", beryllium, "on_pickup", player, "death");
  beryllium function_e62b6844db038d40(player);
}

function function_e62b6844db038d40(player) {
  beryllium = self;

  if(!isDefined(player) || istrue(beryllium.cleanup)) {
    return;
  }

  player notify("ber_outline_end");
  beryllium function_653c2166507f3631(player);
}

function function_52dc4cb3754b675f(elementid, position, angles) {
  teaminfo = self;
  tritium = teaminfo function_8b73cae3fc8903b2(elementid, level.arrow.dvars.var_cf64cf3435a371df);
  tritium.alwaystrack = 0;
  tritium.funcpickup = &function_99f72d5a3cd95101;
  tritium.funcdrop = &function_7970a43ab3e39d0;
  tritium.funccleanup = &function_56aba4ac9640cec;
  return tritium;
}

function function_56aba4ac9640cec() {
  tritium = self;
  tritium function_3b1ecb2735cf8c88(0);
}

function function_99f72d5a3cd95101(player, dontcarry) {
  tritium = self;

  if(istrue(dontcarry)) {
    return;
  }

  tritium function_ee40ba68ef2e28ac(tritium.player);
}

function function_7970a43ab3e39d0(player) {
  tritium = self;
  tritium function_ee40ba68ef2e28ac(tritium.scriptable);
}

function function_3b1ecb2735cf8c88(toenable) {
  tritium = self;

  if(istrue(toenable)) {
    linkent = tritium function_a67115af2229f2f4();

    if(!isDefined(linkent)) {
      return;
    }

    if(!isDefined(tritium.jament)) {
      tritium function_b6e96b5151f70773(linkent.origin);
    }

    foreach(player in level.players) {
      tritium function_cc74b7b6a9ea697a(player);
    }

    return;
  }

  tritium function_83ee42a34ff018f0();
}

function function_b6e96b5151f70773(position) {
  tritium = self;

  if(isDefined(tritium.jament)) {
    return;
  }

  jament = spawn("script_model", position);
  jament function_2ca50158d4286139(level.arrow.dvars.var_588ba2ec2484b034);
  jament.tritium = tritium;
  tritium.jament = jament;
  jament function_36215174c7e56a42();
}

function function_2ca50158d4286139(jammerradius) {
  jament = self;
  jament.var_88f72d2c0421f8b1 = [];
  jament.var_ce8ef6e68df034c7 = 1;

  if(isDefined(jammerradius)) {
    jament.var_32efb854df6d5296 = jammerradius;
  }
}

function function_83ee42a34ff018f0() {
  tritium = self;

  if(!isDefined(tritium.jament)) {
    return;
  }

  tritium function_e1ec969b1c8d92d7();
  tritium.jament function_30d9221820e966fa();
  tritium.jament notify("destroy");
  tritium.jament delete();
}

function function_ee40ba68ef2e28ac(linkent) {
  tritium = self;

  if(!isDefined(linkent)) {
    linkent = function_a67115af2229f2f4();
  }

  function_cf631f26161504db(tritium.jament, linkent);
}

function function_19723e62d956d201(player) {
  if(!isDefined(level.arrow) || !isDefined(level.arrow.props.elements)) {
    return;
  }

  foreach(teamelements in level.arrow.props.elements) {
    if(!isDefined(teamelements["tri"])) {
      continue;
    }

    tritium = teamelements["tri"];
    tritium function_cc74b7b6a9ea697a(player);
  }
}

function function_cc74b7b6a9ea697a(player) {
  tritium = self;

  if(!tritium function_4e1f3f888738797f(player.team)) {
    return;
  }

  tritium function_b6da015aa819a984(player);
}

function function_4e1f3f888738797f(team) {
  tritium = self;

  if(!isDefined(tritium.jament)) {
    return false;
  }

  if(level.arrow.dvars.var_ad7ad59ebfdae08c == 2) {} else if(level.arrow.dvars.var_ad7ad59ebfdae08c == 1) {
    if(!isDefined(level.arrow.teaminfo[team])) {
      return false;
    }

    if(level.arrow.teaminfo[team].state == 0) {
      return false;
    }
  } else if(level.arrow.dvars.var_ad7ad59ebfdae08c == 0) {
    if(tritium.targetteam != team) {
      return false;
    }
  }

  return true;
}

function function_b6da015aa819a984(player) {
  tritium = self;

  if(!isDefined(tritium.jament)) {
    return;
  }

  player scripts\cp_mp\killstreaks\helper_drone::helperdrone_setscramblerjammed(1, tritium.jament, 1, 1);
}

function function_e1ec969b1c8d92d7() {
  tritium = self;

  if(!isDefined(tritium.jament)) {
    return;
  }

  foreach(player in level.players) {
    player scripts\cp_mp\killstreaks\helper_drone::helperdrone_setscramblerjammed(0, tritium.jament, 1, 1);
  }

  tritium.jament scripts\cp_mp\killstreaks\helper_drone::helperdrone_endscramblereffect();
}

function function_36215174c7e56a42() {
  jament = self;

  if(!istrue(level.arrow.dvars.var_8875be3ce5a370d4)) {
    return;
  }

  jament.vehicles = [];
  jament thread function_3e5679cbf0fcb3fe();
}

function function_30d9221820e966fa() {
  jament = self;

  foreach(vehicle in jament.vehicles) {
    jament function_cd8ebc4b7610bcfd(vehicle);
  }

  jament.vehicles = undefined;
}

function function_3e5679cbf0fcb3fe() {
  jament = self;
  jament endon("death");

  while(true) {
    foreach(vehicles in level.vehicle.instances) {
      foreach(vehicle in vehicles) {
        if(!jament function_2a9e351a772fc5cd(vehicle)) {
          continue;
        }

        jament thread function_d3243b5cebddd038(vehicle);
      }
    }

    wait level.arrow.dvars.var_d583139d37b99ddf;
  }
}

function function_2a9e351a772fc5cd(vehicle) {
  jament = self;
  tritium = jament.tritium;

  if(!isDefined(tritium) || !isDefined(vehicle)) {
    return false;
  }

  if(istrue(vehicle.var_8875be3ce5a370d4)) {
    return false;
  }

  vehicleteam = vehicle.team;

  if(isDefined(vehicle.owner)) {
    vehicleteam = vehicle.owner.team;
  }

  if(!tritium function_4e1f3f888738797f(vehicleteam)) {
    return false;
  }

  [vehicleradius] = vehicle getboundshalfsize();
  dist = level.arrow.dvars.var_762eb6f1e9724fea + vehicleradius;
  distsq = squared(dist);

  if(distancesquared(vehicle.origin, jament.origin) > distsq) {
    return false;
  }

  return true;
}

function function_d3243b5cebddd038(vehicle) {
  jament = self;
  jament endon("death");
  vehicle endon("death");
  jament function_53fb5135d0684784(vehicle);
  wait level.arrow.dvars.var_6de843516fb84235;
  jament function_cd8ebc4b7610bcfd(vehicle);
}

function function_53fb5135d0684784(vehicle) {
  jament = self;
  vehicle.var_8875be3ce5a370d4 = 1;
  jament.vehicles[vehicle getentitynumber()] = vehicle;
  objweapon = makeweapon("emp_pulse_mp");
  data = scripts\cp_mp\utility\damage_utility::packdamagedata(jament, vehicle, 1, objweapon, "MOD_EXPLOSIVE", jament, jament.origin);
  time = level.arrow.dvars.var_6de843516fb84235 + level.arrow.dvars.var_d583139d37b99ddf;
  thread scripts\cp_mp\emp_debuff::function_662905d3b9455612(data, time, 0);

  if(istrue(level.arrow.dvars.var_1d37e435e474b707)) {
    vehicle vehphys_parkingbrake(1);
  }
}

function function_cd8ebc4b7610bcfd(vehicle) {
  jament = self;

  if(!isDefined(vehicle)) {
    return;
  }

  vehicle.var_8875be3ce5a370d4 = undefined;
  jament.vehicles[vehicle getentitynumber()] = undefined;

  if(istrue(level.arrow.dvars.var_1d37e435e474b707)) {
    vehicle vehphys_parkingbrake(0);
  }
}

function function_6253104cc59c4f29(elementid, position, angles) {
  teaminfo = self;
  plutonium = teaminfo function_8b73cae3fc8903b2(elementid, level.arrow.dvars.var_cf64cf3435a371df);
  plutonium.alwaystrack = 0;
  plutonium.funcpickup = &function_410102769f042583;
  plutonium.funcdrop = &function_8a8a6d0bd987a462;
  plutonium.funccleanup = &function_2ac4a2695ad6e57a;
  plutonium function_9b12d9adbc63a390(position, 0);
  return plutonium;
}

function function_2ac4a2695ad6e57a() {
  plutonium = self;
  plutonium function_dcc65dcb67f1a539();
}

function function_410102769f042583(player, dontcarry) {
  plutonium = self;

  if(istrue(plutonium.firstpickup)) {
    plutonium.damageenabled = 1;
  }

  if(istrue(dontcarry)) {
    return;
  }

  plutonium function_312c406ae0ceec92(player);
}

function function_312c406ae0ceec92(player) {
  plutonium = self;
  player function_36f999a7c7ed0d32(0, "elite_arrow_plutonium_far");
  player function_36f999a7c7ed0d32(1, "elite_arrow_plutonium_close", 1);
  plutonium function_30fffbb28e03bf3c(1, getfx("arrow_plutonium_close"), plutonium.var_db4005060a0c66af, player);
  function_cf631f26161504db(plutonium.trigger, player);

  if(isDefined(plutonium.trigger.nearbyplayers)) {
    foreach(anyplayer in plutonium.trigger.nearbyplayers) {
      if(!isDefined(anyplayer)) {
        continue;
      }

      if(anyplayer != player) {
        function_6ba8cbf3f6545034(anyplayer, plutonium.trigger);
      }
    }
  }
}

function function_8a8a6d0bd987a462(player) {
  plutonium = self;
  plutonium function_cf67b97c62474f0f();
}

function function_cf67b97c62474f0f() {
  plutonium = self;
  function_cf631f26161504db(plutonium.trigger, plutonium.scriptable);

  if(!isDefined(plutonium.player)) {
    return;
  }

  plutonium.player function_36f999a7c7ed0d32(0, "elite_arrow_plutonium_close");

  if(isDefined(plutonium.var_db4005060a0c66af)) {
    plutonium function_30fffbb28e03bf3c(0, getfx("arrow_plutonium_close"), plutonium.var_db4005060a0c66af, plutonium.player);
  }

  foreach(teamelements in level.arrow.props.elements) {
    if(!isDefined(teamelements["plu"])) {
      continue;
    }

    trigger = teamelements["plu"].trigger;
    function_6ba8cbf3f6545034(plutonium.player, trigger, undefined, 1);
  }
}

function function_4f4f8b0cc0803fc3(toenable) {
  plutonium = self;
  plutonium.damageenabled = istrue(toenable);

  if(istrue(toenable)) {
    if(isDefined(plutonium.var_db4005060a0c66af)) {
      plutonium function_30fffbb28e03bf3c(1, getfx("arrow_plutonium_far"), plutonium.var_db4005060a0c66af);
    }

    if(isDefined(plutonium.trigger.nearbyplayers)) {
      foreach(player in plutonium.trigger.nearbyplayers) {
        function_6ba8cbf3f6545034(player, plutonium.trigger);
      }
    }

    return;
  }

  if(isDefined(plutonium.trigger.nearbyplayers)) {
    if(isDefined(plutonium.var_db4005060a0c66af)) {
      plutonium function_30fffbb28e03bf3c(0, getfx("arrow_plutonium_far"), plutonium.var_db4005060a0c66af);
      plutonium function_30fffbb28e03bf3c(0, getfx("arrow_plutonium_close"), plutonium.var_db4005060a0c66af);
    }

    foreach(player in plutonium.trigger.nearbyplayers) {
      function_e7d74f537ad78f5a(player, plutonium.trigger);
    }
  }
}

function function_9b12d9adbc63a390(position, startenabled) {
  plutonium = self;
  plutonium.trigger = plutonium function_e0cfb24e950aace9(position, level.arrow.dvars.var_638730e568dea417, level.arrow.dvars.var_d46d4318a15ee3fe);
  plutonium thread function_f5c198ea628d986f();
  plutonium.damageenabled = startenabled;
}

function function_dcc65dcb67f1a539() {
  plutonium = self;

  if(isDefined(plutonium.player)) {
    plutonium.player function_36f999a7c7ed0d32(0, "elite_arrow_plutonium_close");
  }

  if(isDefined(plutonium.trigger) && isDefined(plutonium.trigger.nearbyplayers)) {
    foreach(player in plutonium.trigger.nearbyplayers) {
      function_e7d74f537ad78f5a(player, plutonium.trigger, 1);
    }
  }

  if(isDefined(plutonium.var_db4005060a0c66af)) {
    plutonium function_30fffbb28e03bf3c(0, getfx("arrow_plutonium_far"), plutonium.var_db4005060a0c66af);
    plutonium function_30fffbb28e03bf3c(0, getfx("arrow_plutonium_close"), plutonium.var_db4005060a0c66af);
  }

  plutonium function_b15e5ba7931dbb41();
}

function function_f5c198ea628d986f() {
  plutonium = self;
  level endon("game_ended");
  plutonium endon("element_cleanup");

  while(true) {
    if(!istrue(plutonium.damageenabled)) {
      wait level.arrow.dvars.var_b68fcb1b5d940382;
      continue;
    }

    plutonium function_bbe6c5e8750d96d2();
    plutonium function_258c5fd2e0e24e7e();
    wait level.arrow.dvars.var_b68fcb1b5d940382;
  }
}

function function_bbe6c5e8750d96d2() {
  plutonium = self;

  if(level.arrow.dvars.var_84aa1b04a3f96808 <= 0) {
    return;
  }

  if(!isDefined(level.vehicle) || !isDefined(plutonium.trigger)) {
    return;
  }

  offsetz = function_aa8daa8be6051112(plutonium.trigger);
  damageorigin = plutonium.trigger.origin + (0, 0, offsetz);
  damageradius = level.arrow.dvars.var_638730e568dea417;
  damageamount = level.arrow.dvars.var_84aa1b04a3f96808;

  foreach(vehicles in level.vehicle.instances) {
    foreach(vehicle in vehicles) {
      if(!isDefined(vehicle)) {
        continue;
      }

      if(distance2dsquared(vehicle.origin, damageorigin) > squared(damageradius)) {
        continue;
      }

      if(!isDefined(vehicle.var_b2ee58922a98cea6)) {
        vehicle.var_b2ee58922a98cea6 = 0;
      }

      vehicle.var_b2ee58922a98cea6 += level.arrow.dvars.var_b68fcb1b5d940382;

      if(vehicle.var_b2ee58922a98cea6 < level.arrow.dvars.var_851ffe073082048a) {
        continue;
      }

      vehicle dodamage(damageamount, vehicle.origin, undefined, undefined, "MOD_TRIGGER_HURT", makeweapon("iw9_me_fists_mp"));
      vehicle.var_b2ee58922a98cea6 = 0;
    }
  }
}

function function_258c5fd2e0e24e7e() {
  plutonium = self;

  if(isDefined(plutonium.trigger.nearbyplayers)) {
    foreach(player in plutonium.trigger.nearbyplayers) {
      if(!isDefined(player)) {
        continue;
      }

      if(!player istouching(plutonium.trigger) && !isDefined(player.vehicle)) {
        function_e7d74f537ad78f5a(player, plutonium.trigger);
        continue;
      }

      if(!isDefined(player.var_b2ee58922a98cea6)) {
        player.var_b2ee58922a98cea6 = 0;
      }

      player.var_b2ee58922a98cea6 += level.arrow.dvars.var_b68fcb1b5d940382;

      if(function_af54a33c2ac9a71f(player, plutonium.elementid) && player.var_b2ee58922a98cea6 >= level.arrow.dvars.var_ab026fc2a155136d) {
        function_1bbbf7a70ea21b15();
        player.var_b2ee58922a98cea6 = 0;
        continue;
      }

      if(player.var_b2ee58922a98cea6 >= level.arrow.dvars.var_4472a2372ddc2cc0) {
        function_804448ec7e835c44(player);
        player.var_b2ee58922a98cea6 = 0;
      }
    }
  }
}

function function_804448ec7e835c44(player) {
  plutonium = self;

  if(level.arrow.dvars.var_393d26e0e968f852 <= 0) {
    return;
  }

  trigger = plutonium.trigger;

  if(!isDefined(trigger)) {
    return;
  }

  if(function_af54a33c2ac9a71f(player, "plu")) {
    return;
  }

  damage = level.arrow.dvars.var_393d26e0e968f852;
  player dodamage(damage, plutonium.trigger.origin, player, undefined, "MOD_TRIGGER_HURT", makeweapon("iw9_me_fists_mp"), "torso_upper");
  player function_36f999a7c7ed0d32(1, "elite_arrow_plutonium_far");
  player playlocalsound("evt_elite_arrow_plutonium_damage");
}

function function_1bbbf7a70ea21b15() {
  plutonium = self;

  if(level.arrow.dvars.var_8f5bfd8cf641d707 <= 0) {
    return;
  }

  if(!isDefined(plutonium.player) || !isPlayer(plutonium.player)) {
    return;
  }

  damage = level.arrow.dvars.var_8f5bfd8cf641d707;
  player = plutonium.player;
  player dodamage(damage, player.origin, player, undefined, "MOD_TRIGGER_HURT", makeweapon("iw9_me_fists_mp"), "torso_upper");
  player playlocalsound("evt_elite_arrow_plutonium_damage");
}

function function_e0cfb24e950aace9(position, radius, height) {
  plutonium = self;
  trigger = plutonium function_b2e040ef75de3602(position, radius, height);
  trigger.targetname = "pluTrigger";
  scripts\mp\utility\trigger::makeenterexittrigger(trigger, &function_6ba8cbf3f6545034, &function_e7d74f537ad78f5a);
  return trigger;
}

function function_6ba8cbf3f6545034(entity, trigger, force, ignoreheld) {
  if(!isDefined(entity) || !isPlayer(entity)) {
    return;
  }

  if(entity scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    thread function_44b8aae5bcdc3081(entity, trigger);
    return;
  }

  function_1f21ab99f974fb93(entity, trigger, force, ignoreheld);
  plutonium = trigger.element;

  if(!isDefined(plutonium)) {
    return;
  }

  if(istrue(plutonium.damageenabled) && (!entity function_9bbf676ee447b21a("elite_arrow_plutonium_close") || istrue(ignoreheld))) {
    entity function_36f999a7c7ed0d32(1, "elite_arrow_plutonium_far", 1);
  }
}

function function_e7d74f537ad78f5a(entity, trigger, force) {
  if(!isDefined(entity) || !isPlayer(entity)) {
    return;
  }

  if(entity scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    thread function_685375bba20333ad(entity, trigger);
    return;
  }

  function_95f74c4eedbbd627(entity, trigger, force);
  entity function_36f999a7c7ed0d32(0, "elite_arrow_plutonium_far");
}

function function_36f999a7c7ed0d32(visible, visionset, transitionduration) {
  player = self;

  if(istrue(visible)) {
    if(!function_9bbf676ee447b21a(visionset)) {
      player _visionsetnakedforplayer(visionset, transitionduration);
    }

    return;
  }

  if(function_9bbf676ee447b21a(visionset)) {
    player _visionunsetnakedforplayer(visionset);
  }
}

function function_9bbf676ee447b21a(visionset) {
  player = self;
  return isDefined(player.activevisionsetlist) && isDefined(player.activevisionsetlist[visionset]);
}

function function_30fffbb28e03bf3c(visible, id, ent, player) {
  plutonium = self;

  if(istrue(visible)) {
    if(isDefined(player)) {
      playfxontagforclients(id, ent, "tag_origin", player);
    } else {
      playFXOnTag(id, ent, "tag_origin");
    }

    return;
  }

  if(isDefined(player)) {
    stopfxontagforclients(id, ent, "tag_origin", player);
    return;
  }

  stopFXOnTag(id, ent, "tag_origin");
}

function function_d35bbff23005617e(elementid, position, angles) {
  teaminfo = self;
  deuterium = teaminfo function_8b73cae3fc8903b2(elementid, level.arrow.dvars.var_cf64cf3435a371df);
  deuterium.var_7f27afde2cb12dd7 = 0;
  deuterium.alwaystrack = 0;
  deuterium.funcpickup = &function_609f1f6343da9422;
  deuterium.funcdrop = &function_38dbec19e95af4b;
  deuterium.funccleanup = &function_cca3eee7512be19d;
  return deuterium;
}

function function_cca3eee7512be19d() {
  deuterium = self;
  deuterium function_f22ad532ddd207bd();
}

function function_98fd63da9ff160cb(player, value) {
  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  player scripts\common\values::set("deuterium_controls_restrictions", "slide", istrue(value));
  player scripts\common\values::set("deuterium_controls_restrictions", "dtp", istrue(value));
}

function function_609f1f6343da9422(player, dontcarry) {
  deuterium = self;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  if(istrue(deuterium.firstpickup)) {
    deuterium.var_7f27afde2cb12dd7 = 1;
  }

  if(istrue(dontcarry)) {
    return;
  }

  deuterium thread function_d665dd034ad7e956();
}

function function_38dbec19e95af4b(player) {
  deuterium = self;
  deuterium notify("deuterium_dropped");
  deuterium function_f22ad532ddd207bd();
}

function function_f22ad532ddd207bd() {
  deuterium = self;
  player = deuterium.player;

  if(!isDefined(player)) {
    return;
  }

  deuterium function_a79b0a65151888a5();
  player.movespeedscaler = 1;
  player scripts\mp\weapons::updatemovespeedscale();
  player.var_236cc13e39ef474 = 1;
  player function_9354c4c50c43abc0(player.var_236cc13e39ef474);
  function_98fd63da9ff160cb(player, 1);
  player.var_dc6dc154664cf0aa = undefined;
}

function function_d665dd034ad7e956() {
  deuterium = self;
  player = deuterium.player;
  level endon("game_ended");
  player endon("death_or_disconnect");
  deuterium endon("element_cleanup");
  deuterium endon("deuterium_dropped");
  function_98fd63da9ff160cb(player, 0);
  player.var_dc6dc154664cf0aa = &function_1053e1c33a004da2;
  deuterium thread function_85a7735661b9312b();

  while(true) {
    if(istrue(deuterium.var_7f27afde2cb12dd7)) {
      deuterium function_43284e0bca45d52e();
      deuterium function_88c5a729bc233116();
    }

    waitframe();
  }
}

function function_1053e1c33a004da2() {
  player = self;

  if(player isswimsprinting()) {
    breathtime = level.arrow.dvars.var_7325ce521fc5e3e7;
  } else {
    breathtime = level.arrow.dvars.var_aa657343e38c0c5c;
  }

  return breathtime;
}

function function_ccb7898d9af41c88() {
  player = self;

  if(player function_73f8d05a3e66bc13()) {
    return false;
  }

  if(isDefined(player.vehicle)) {
    return false;
  }

  if(player isonladder()) {
    return false;
  }

  if(player isonascender()) {
    return false;
  }

  return true;
}

function function_88c5a729bc233116() {
  deuterium = self;
  player = deuterium.player;

  if(!isDefined(player)) {
    return;
  }

  if(!player function_ccb7898d9af41c88()) {
    deuterium function_a79b0a65151888a5();
    return;
  }

  if(!isDefined(player.var_aa390a45e46f9e6a) || !isDefined(player.var_f59b62de990a2665)) {
    return;
  }

  switch (player.var_aa390a45e46f9e6a) {
    case 0:
      if(player.var_f59b62de990a2665 == 0) {
        if(istrue(deuterium.coughfinished)) {
          deuterium function_a79b0a65151888a5();
        }
      } else if(!istrue(deuterium.coughstarted)) {
        deuterium function_aec4cf5f49f0125e();
      }

      break;
    case 1:
      if(player.var_f59b62de990a2665 == 2) {
        if(!istrue(deuterium.coughstarted)) {
          deuterium function_aec4cf5f49f0125e();
        }
      } else if(player.var_f59b62de990a2665 == 0) {
        deuterium thread function_3e6f2483e68d5aa4();
      }

      break;
  }
}

function function_3e6f2483e68d5aa4() {
  deuterium = self;
  player = deuterium.player;
  deuterium endon("deuterium_dropped");
  deuterium endon("cough_cleared");
  wait level.arrow.dvars.var_92fb78ca5af82fe4;

  while(!player isonground()) {
    waitframe();
  }

  if(!istrue(deuterium.coughstarted)) {
    deuterium function_aec4cf5f49f0125e();
  }
}

function function_85a7735661b9312b() {
  deuterium = self;
  player = deuterium.player;
  level endon("game_ended");
  player endon("death_or_disconnect");
  deuterium endon("element_cleanup");
  deuterium endon("deuterium_dropped");

  while(true) {
    if(istrue(deuterium.var_7f27afde2cb12dd7) && isDefined(player) && isPlayer(player)) {
      if(function_af54a33c2ac9a71f(player, deuterium.elementid)) {
        if(player function_73f8d05a3e66bc13()) {
          deuterium function_a79b0a65151888a5();
          player.var_236cc13e39ef474 = function_b7c53c2fcc583abc();

          if(isDefined(player.var_236cc13e39ef474) && player.var_236cc13e39ef474 > 0) {
            player function_9354c4c50c43abc0(player.var_236cc13e39ef474);
          }
        } else if(player isonground()) {
          player.movespeedscaler = function_172ca277e45eb80f();

          if(isDefined(player.movespeedscaler) && player.movespeedscaler > 0) {
            player scripts\mp\weapons::updatemovespeedscale();
          }
        }
      }
    }

    waitframe();
  }
}

function function_43284e0bca45d52e() {
  deuterium = self;
  player = deuterium.player;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  if(function_af54a33c2ac9a71f(player, deuterium.elementid)) {
    if(!player function_ccb7898d9af41c88()) {
      player.var_f59b62de990a2665 = 0;
      player.var_aa390a45e46f9e6a = 0;
      return;
    }

    if(player isonground()) {
      var_f9276359d14febc5 = player issupersprinting();
      isplayersprinting = !istrue(var_f9276359d14febc5) && player issprinting();

      if(isDefined(player.var_aa390a45e46f9e6a)) {
        player.var_f59b62de990a2665 = player.var_aa390a45e46f9e6a;
      }

      if(istrue(var_f9276359d14febc5)) {
        player.var_aa390a45e46f9e6a = 2;
      } else if(istrue(isplayersprinting)) {
        player.var_aa390a45e46f9e6a = 1;
      } else {
        player.var_aa390a45e46f9e6a = 0;
      }

      if(!isDefined(player.var_f59b62de990a2665) && isDefined(player.var_aa390a45e46f9e6a)) {
        player.var_f59b62de990a2665 = player.var_aa390a45e46f9e6a;
      }
    }
  }
}

function function_b7c53c2fcc583abc() {
  deuterium = self;
  player = deuterium.player;

  if(!isDefined(player)) {
    return;
  }

  if(player isswimming() && player isswimunderwater()) {
    if(player isswimsprinting()) {
      return level.arrow.dvars.var_c1bcefe508528799;
    } else {
      return level.arrow.dvars.var_57e8127d75fc9da9;
    }

    return;
  }

  if(player isswimsprinting()) {
    return level.arrow.dvars.var_f9f69d98d83b83c9;
  }

  return level.arrow.dvars.var_a4830e9532f7fc59;
}

function function_172ca277e45eb80f() {
  deuterium = self;
  player = deuterium.player;

  if(!isDefined(player)) {
    return;
  }

  if(player issprinting()) {
    return level.arrow.dvars.var_ce33e905a8335d56;
  }

  if(player issupersprinting() || player function_38932cc1ef28756()) {
    return level.arrow.dvars.var_eb5b985cba8997f9;
  }

  if(player crouchbuttonPressed() || player getstance() == "crouch" || player getstance() == "prone") {
    return level.arrow.dvars.var_38eac2a5c514c498;
  }

  if(player issprintsliding()) {
    return level.arrow.dvars.var_d0b83c7b63c98011;
  }

  return level.arrow.dvars.var_1b9ddc66ea9dc058;
}

function function_73f8d05a3e66bc13() {
  player = self;
  return isDefined(player) && (player scripts\common\swim_common::isplayerswimming() || player scripts\common\swim_common::isplayerunderwater());
}

function function_aec4cf5f49f0125e() {
  deuterium = self;
  player = deuterium.player;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  player thread scripts\mp\equipment\gas_grenade::gas_applyblur();

  if(!istrue(player.gascoughinprogress)) {
    player thread scripts\mp\equipment\gas_grenade::gas_queuecough(0);
    player scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudio();
  }

  coughduration = level.arrow.dvars.var_1ed92f6d912c9995;

  if(player.var_f59b62de990a2665 == 2) {
    coughduration = level.arrow.dvars.var_8275fefd6945052a;
  }

  deuterium.coughstarted = 1;
  wait coughduration;
  deuterium.coughfinished = 1;
}

function function_a79b0a65151888a5() {
  deuterium = self;
  player = deuterium.player;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  player thread scripts\mp\equipment\gas_grenade::gas_clearblur(0);
  player scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudio();
  deuterium.coughstarted = 0;
  deuterium.coughfinished = 0;
  deuterium notify("cough_cleared");
}

function function_80f86d133491daf8(elementid, position, angles) {
  teaminfo = self;
  gallium = teaminfo function_8b73cae3fc8903b2(elementid, level.arrow.dvars.var_cf64cf3435a371df);
  gallium.alwaystrack = 0;
  gallium.funcpickup = &function_fe48e8ed75e3364c;
  gallium.funcdrop = &function_24c85b7774638bd;
  gallium.funccleanup = &function_25c3bf2b50fd1b13;
  gallium.teamaffected = teaminfo.champion.team;
  gallium function_f8bd2935a988bb02();
  return gallium;
}

function function_8e9c04aa5fa8a3db() {
  gallium = self;
  gallium.trigger = gallium function_ee6ef53cdfc9fba6(gallium.var_db4005060a0c66af.origin, level.arrow.dvars.var_2e0c9dc38097f039, level.arrow.dvars.var_481c2689c39ba74);
  gallium.outlineenabled = 1;
}

function function_25c3bf2b50fd1b13() {
  gallium = self;

  if(isDefined(gallium) && isDefined(gallium.trigger) && isDefined(gallium.trigger.nearbyplayers)) {
    foreach(player in gallium.trigger.nearbyplayers) {
      if(isDefined(player) && isPlayer(player) && player.team == gallium.teamaffected) {
        function_b43d02bb8f9b51d3(player, gallium.trigger, 1);
      }
    }
  }

  gallium.outlineenabled = 0;
  gallium function_ba8f494325ede6d7("snapshotgrenade");
  gallium function_b15e5ba7931dbb41();
}

function function_fe48e8ed75e3364c(player, dontcarry) {
  gallium = self;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  if(istrue(dontcarry)) {
    return;
  }

  function_cf631f26161504db(gallium.trigger, player);

  if(isDefined(gallium.teamaffected) && gallium.teamaffected != player.team) {
    gallium function_e950036eb2177ff2(gallium.teamaffected);
    gallium.teamaffected = player.team;
    gallium function_1aba029c65714798(player);
  }
}

function function_1aba029c65714798(player) {
  gallium = self;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  if(!isDefined(gallium.trigger.nearbyplayers)) {
    return;
  }

  foreach(anyplayer in gallium.trigger.nearbyplayers) {
    if(isDefined(anyplayer) && isPlayer(anyplayer) && anyplayer.team == gallium.teamaffected) {
      function_f8fb742951b911d7(anyplayer, gallium.trigger);
    }
  }
}

function function_24c85b7774638bd(player) {
  gallium = self;
  function_cf631f26161504db(gallium.trigger, gallium.scriptable);
}

function function_e950036eb2177ff2(var_545dcb938f750b0f) {
  gallium = self;

  if(!isDefined(var_545dcb938f750b0f) || !isDefined(gallium.trigger) || !isDefined(gallium.trigger.nearbyplayers)) {
    return;
  }

  foreach(player in gallium.trigger.nearbyplayers) {
    if(isDefined(player) && isPlayer(player) && player.team == var_545dcb938f750b0f) {
      if(istrue(function_266bdd55da24482(gallium, player))) {
        continue;
      }

      gallium function_37748ef3982539d4(player, 0, "snapshotgrenade");
      gallium function_8e58dd83353f41dd(player);
      player hudoutlinedisableforclients(level.players);
    }
  }
}

function function_3f345112d7354464(player) {
  gallium = self;
  gallium function_f3711bf7ce3191d0(player, "snapshotgrenade", "level_script");
  gallium thread function_7d04786b21e00ea4(player);
  gallium function_e62674d5de7043f9(player, "snapshotgrenade");
  player playLoopSound("evt_br_elite_arrow_neon_lp");
}

function function_7d04786b21e00ea4(player) {
  gallium = self;
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("gal_outline_end");

  if(istrue(player.var_13168b1e22513e23)) {
    return;
  }

  player.var_13168b1e22513e23 = 1;
  function_7b9e0e7ca4b3b940(gallium, "death", gallium, "on_drop", player, "death");
  gallium function_8e58dd83353f41dd(player);
  player.var_13168b1e22513e23 = 0;
}

function function_8e58dd83353f41dd(player) {
  gallium = self;

  if(!isDefined(player)) {
    return;
  }

  player notify("gal_outline_end");
  gallium function_653c2166507f3631(player);
  gallium function_e62674d5de7043f9(player, "snapshotgrenade");
  player stoploopsound("evt_br_elite_arrow_neon_lp");
}

function function_ee6ef53cdfc9fba6(position, radius, height) {
  gallium = self;
  trigger = gallium function_b2e040ef75de3602(position, radius, height);
  trigger.targetname = "galTrigger";
  scripts\mp\utility\trigger::makeenterexittrigger(trigger, &function_f8fb742951b911d7, &function_b43d02bb8f9b51d3);
  return trigger;
}

function function_f8fb742951b911d7(entity, trigger, force, ignoreheld) {
  if(!isDefined(entity)) {
    return;
  }

  if(entity scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    thread function_68c54d8b0aae409d(entity, trigger);
    thread function_44b8aae5bcdc3081(entity, trigger);
    return;
  }

  if(!isPlayer(entity)) {
    return;
  }

  function_1f21ab99f974fb93(entity, trigger, force, 1);
  gallium = trigger.element;

  if(!isDefined(gallium)) {
    return;
  }

  if(entity.team == gallium.teamaffected && istrue(gallium.outlineenabled)) {
    gallium function_3f345112d7354464(entity);
    gallium function_37748ef3982539d4(entity, 1, "snapshotgrenade");
  }
}

function function_b43d02bb8f9b51d3(entity, trigger, force) {
  if(!isDefined(entity)) {
    return;
  }

  if(entity scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    thread function_584aa77d250174c1(entity, trigger);
    thread function_685375bba20333ad(entity, trigger);
    return;
  }

  if(!isPlayer(entity)) {
    return;
  }

  function_95f74c4eedbbd627(entity, trigger, force);
  gallium = trigger.element;

  if(!isDefined(gallium)) {
    return;
  }

  if(entity.team == gallium.teamaffected) {
    if(istrue(function_266bdd55da24482(gallium, entity))) {
      return;
    }

    gallium function_37748ef3982539d4(entity, 0, "snapshotgrenade");
    gallium function_8e58dd83353f41dd(entity);
    entity hudoutlinedisableforclients(level.players);
  }
}

function function_68c54d8b0aae409d(vehicle, trigger) {
  if(!isDefined(vehicle) || !isDefined(vehicle.occupants)) {
    return;
  }

  waitframe();

  foreach(occupant in vehicle.occupants) {
    if(isDefined(occupant)) {
      function_f8fb742951b911d7(occupant, trigger, 1);
    }
  }
}

function function_584aa77d250174c1(vehicle, trigger) {
  if(!isDefined(vehicle) || !isDefined(vehicle.occupants)) {
    return;
  }

  waitframe();

  foreach(occupant in vehicle.occupants) {
    if(isDefined(occupant)) {
      function_b43d02bb8f9b51d3(occupant, trigger, 1);
    }
  }
}

function function_266bdd55da24482(var_dde9a7c23004d59f, player) {
  if(!isDefined(var_dde9a7c23004d59f)) {
    return false;
  }

  if(!isDefined(player) || !isPlayer(player)) {
    return false;
  }

  var_70a381821ef9dff = function_e6b87eeb3abc7be0("gal");

  foreach(element in var_70a381821ef9dff) {
    if(element == var_dde9a7c23004d59f) {
      continue;
    }

    if(!isDefined(element.trigger) || !isDefined(element.trigger.nearbyplayers) || !isDefined(element.teamaffected)) {
      continue;
    }

    if(element.teamaffected == player.team && array_contains(element.trigger.nearbyplayers, player)) {
      return true;
    }
  }

  return false;
}

function function_3b3b0f3703ebd7e5(elementid, position, angles) {
  teaminfo = self;
  neptunium = teaminfo function_8b73cae3fc8903b2(elementid, level.arrow.dvars.var_cf64cf3435a371df);
  neptunium.alwaystrack = 0;
  neptunium.funcpickup = &function_4eaf2406b65c6af;
  neptunium.funcdrop = &function_9db988480fd8a586;
  neptunium.funccleanup = &function_13a240ca1e1c9a96;
  neptunium function_ef13d077ac0250c9();
  return neptunium;
}

function function_13a240ca1e1c9a96() {
  neptunium = self;
  neptunium notify("neptunium_cleanup");

  if(isDefined(neptunium.player)) {
    function_7a31f2723d220056(neptunium.player, neptunium.trigger, 1);
  }

  if(isDefined(neptunium.trigger) && isDefined(neptunium.trigger.nearbyplayers)) {
    foreach(nearbyplayer in neptunium.trigger.nearbyplayers) {
      if(isDefined(nearbyplayer)) {
        function_7a31f2723d220056(nearbyplayer, neptunium.trigger, 1);
      }
    }
  }

  neptunium function_b15e5ba7931dbb41();
}

function function_8932eca89649c982() {
  neptunium = self;
  neptunium.containeropened = 1;
  neptunium function_46d3cf4a7ebfa52a();
  wait level.arrow.dvars.var_76014ca6914ad16a;
  neptunium notify("neptunium_shock_players");
  neptunium.damageenabled = 1;
  neptunium thread function_db77677c16f95aaf();
}

function function_4eaf2406b65c6af(player, dontcarry) {
  neptunium = self;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  if(istrue(neptunium.firstpickup)) {
    neptunium.damageenabled = 1;
  }

  if(istrue(dontcarry)) {
    return;
  }

  if(!isDefined(neptunium.trigger)) {
    return;
  }

  function_cf631f26161504db(neptunium.trigger, player);
  function_b6cc60429c9bbe38(player, neptunium.trigger, undefined, 1);

  if(isDefined(neptunium.trigger.nearbyplayers)) {
    foreach(nearbyplayer in neptunium.trigger.nearbyplayers) {
      if(isDefined(nearbyplayer)) {
        function_b6cc60429c9bbe38(nearbyplayer, neptunium.trigger, undefined, 1);
      }
    }
  }
}

function function_9db988480fd8a586(player) {
  neptunium = self;

  if(!isDefined(neptunium.trigger)) {
    return;
  }

  function_cf631f26161504db(neptunium.trigger, neptunium.scriptable);
  function_b6cc60429c9bbe38(player, neptunium.trigger, undefined, 1);

  foreach(teamelements in level.arrow.props.elements) {
    if(!isDefined(teamelements[neptunium.elementid])) {
      continue;
    }

    trigger = teamelements[neptunium.elementid].trigger;

    if(isDefined(trigger) && isDefined(trigger.nearbyplayers)) {
      foreach(nearbyplayer in trigger.nearbyplayers) {
        if(isDefined(nearbyplayer)) {
          function_b6cc60429c9bbe38(nearbyplayer, trigger, undefined, 1);
        }
      }
    }
  }
}

function function_46d3cf4a7ebfa52a() {
  neptunium = self;
  neptunium.trigger = neptunium function_a914b399bef9da8d(neptunium.var_db4005060a0c66af.origin, level.arrow.dvars.var_16082451127c4a27, level.arrow.dvars.var_aab3c520b5a4d04e);
}

function function_db77677c16f95aaf() {
  neptunium = self;
  level endon("game_ended");
  neptunium endon("element_cleanup");
  neptunium.var_1e23c49824d7b956 = level.arrow.dvars.var_a302e223567a930b - level.arrow.dvars.var_7d816906afe09af9;
  neptunium.var_8b4e754800a213d2 = 0;

  while(true) {
    if(istrue(neptunium.damageenabled)) {
      neptunium function_3361ce83605026a4();
    }

    wait level.arrow.dvars.var_40159311e3fb11f2;
  }
}

function function_3361ce83605026a4() {
  neptunium = self;
  player = neptunium.player;

  if(!isDefined(neptunium.var_bada4975df6dfd)) {
    neptunium.var_bada4975df6dfd = 0;
  }

  neptunium.var_bada4975df6dfd += level.arrow.dvars.var_40159311e3fb11f2;

  if(isDefined(neptunium.var_1e23c49824d7b956) && neptunium.var_bada4975df6dfd < neptunium.var_1e23c49824d7b956) {
    return;
  }

  if(isDefined(neptunium.var_8b4e754800a213d2) && !neptunium.var_8b4e754800a213d2) {
    entity = neptunium function_775f98c18204823e();

    if(!isDefined(entity)) {
      entity = neptunium.var_db4005060a0c66af;
    }

    if(isDefined(entity)) {
      entity playsoundonmovingent("evt_br_elite_arrow_neptunium_preload");
    }

    neptunium.var_8b4e754800a213d2 = 1;
  }

  if(neptunium.var_bada4975df6dfd >= level.arrow.dvars.var_a302e223567a930b) {
    neptunium function_3d5df5eca0c3f426();
  }
}

function function_3d5df5eca0c3f426() {
  neptunium = self;
  player = neptunium.player;

  if(!isDefined(neptunium.trigger.nearbyplayers) || neptunium.trigger.nearbyplayers.size == 0) {
    neptunium.var_bada4975df6dfd = 0;
    neptunium.var_8b4e754800a213d2 = 0;
    return;
  } else {
    neptunium notify("neptunium_shock_players");
  }

  neptunium.var_bada4975df6dfd = 0;
  neptunium.var_8b4e754800a213d2 = 0;
}

function function_bda8b7560adf5719(playershocked) {
  neptunium = self;

  if(!isDefined(playershocked) || !isPlayer(playershocked)) {
    return;
  }

  if(!playershocked istouching(neptunium.trigger) && !isDefined(playershocked.vehicle)) {
    function_7a31f2723d220056(playershocked, neptunium.trigger);
    return;
  }

  if(isDefined(playershocked) && function_af54a33c2ac9a71f(playershocked, neptunium.elementid)) {
    teammates = array_removeundefined(getteamdata(playershocked.team, "players"));

    if(!array_contains(teammates, playershocked)) {
      return;
    }
  }

  if(isDefined(neptunium.scriptable)) {
    neptunium.scriptable function_f3548416f24b0f48("active");
  }

  neptunium function_8f49fe3c4eaa832(playershocked);
  isplayerdriver = isDefined(playershocked.vehicle) && scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(playershocked);

  if(isplayerdriver) {
    neptunium function_979241a2db4f97d7(playershocked);
  } else {
    neptunium function_ecaac672655c907a(playershocked);
  }

  if(isDefined(neptunium.scriptable)) {
    neptunium.scriptable function_f3548416f24b0f48("visible");
  }
}

function function_8f49fe3c4eaa832(player) {
  neptunium = self;

  if(level.arrow.dvars.var_198a615bfd3f059 <= 0) {
    return;
  }

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  damage = level.arrow.dvars.var_198a615bfd3f059;
  player dodamage(damage, player.origin, player, undefined, "MOD_TRIGGER_HURT", makeweapon("iw9_me_fists_mp"), "torso_upper");
}

function function_a914b399bef9da8d(position, radius, height) {
  neptunium = self;
  trigger = neptunium function_b2e040ef75de3602(position, radius, height);
  trigger.targetname = "nepTrigger";
  scripts\mp\utility\trigger::makeenterexittrigger(trigger, &function_b6cc60429c9bbe38, &function_7a31f2723d220056);
  return trigger;
}

function function_b6cc60429c9bbe38(entity, trigger, force, ignoreheld) {
  if(!isDefined(entity)) {
    return;
  }

  if(entity scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    thread function_7337df5ee7f73e11(entity, trigger);
    thread function_44b8aae5bcdc3081(entity, trigger);
    return;
  }

  if(!isPlayer(entity)) {
    return;
  }

  function_1f21ab99f974fb93(entity, trigger, force, 1);
  neptunium = trigger.element;

  if(!isDefined(neptunium)) {
    return;
  }

  neptunium thread function_edcfffc4f810e828(entity);
  neptunium thread function_1b14a71ba05bd7fe(entity);
}

function function_7a31f2723d220056(entity, trigger, force) {
  if(!isDefined(entity)) {
    return;
  }

  if(entity scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    thread function_685375bba20333ad(entity, trigger);
    thread function_b7f017790517b80(entity, trigger);
    entity notify("neptunium_trigger_exit");
    return;
  }

  if(!isPlayer(entity)) {
    return;
  }

  function_95f74c4eedbbd627(entity, trigger, force);
  neptunium = trigger.element;

  if(!isDefined(neptunium)) {
    return;
  }

  if(function_709dc2fdeae07eca(neptunium, entity)) {
    return;
  }

  if(istrue(entity.var_73f5208ca4d9c1bf)) {
    neptunium function_7519bb8dabab4252(entity);
  }

  entity.var_e65d2aa36253717a = 0;
  entity notify("neptunium_trigger_exit");
  entity stoploopsound("evt_br_elite_arrow_neptunium_shock_lp");
}

function function_b7f017790517b80(vehicle, trigger) {
  if(!isDefined(vehicle)) {
    return;
  }

  waitframe();

  if(isDefined(vehicle.occupants)) {
    foreach(occupant in vehicle.occupants) {
      function_7a31f2723d220056(occupant, trigger, 1);
    }
  }

  vehicle function_1699c07d73e1bac9();
  vehicle stoploopsound("evt_br_elite_arrow_neptunium_shock_lp");
}

function function_1b14a71ba05bd7fe(playerinradius) {
  neptunium = self;
  level endon("game_ended");
  neptunium endon("element_cleanup");

  if(!isDefined(playerinradius) || !isPlayer(playerinradius)) {
    return;
  }

  if(istrue(playerinradius.var_e65d2aa36253717a)) {
    return;
  }

  playerinradius.var_e65d2aa36253717a = 1;
  playerinradius endon("neptunium_trigger_exit");

  while(true) {
    neptunium waittill("neptunium_shock_players");
    neptunium function_bda8b7560adf5719(playerinradius);
  }
}

function function_7337df5ee7f73e11(vehicle, trigger) {
  if(!isDefined(vehicle)) {
    return;
  }

  waitframe();

  if(isDefined(vehicle.occupants)) {
    foreach(occupant in vehicle.occupants) {
      function_b6cc60429c9bbe38(occupant, trigger, 1);
    }
  }

  vehicle function_29e4ced10d235c31();
}

function function_edcfffc4f810e828(playerinradius) {
  neptunium = self;

  if(!isDefined(playerinradius) || !isPlayer(playerinradius)) {
    return;
  }

  if(istrue(playerinradius.var_bf99f646b48a062c)) {
    return;
  }

  function_114ab0f9173b2188(playerinradius, 1);
  playerinradius.var_bf99f646b48a062c = 1;
  playerinradius waittill("neptunium_trigger_exit");

  if(!istrue(playerinradius.var_bf99f646b48a062c)) {
    return;
  }

  function_114ab0f9173b2188(playerinradius, 0);
  playerinradius.var_bf99f646b48a062c = 0;
}

function function_114ab0f9173b2188(player, state) {
  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  if(istrue(state) && !istrue(player.var_73f5208ca4d9c1bf)) {
    player setscriptablepartstate("shockStickVfx", "vfx_start", 1);
    player.var_73f5208ca4d9c1bf = 1;
    return;
  }

  player setscriptablepartstate("shockStickVfx", "off", 0);
  player.var_73f5208ca4d9c1bf = 0;
}

function function_ef13d077ac0250c9() {
  neptunium = self;
  neptunium.bundle = spawnStruct();
  neptunium.bundle.var_77ae83eedd8cab0c = 0.8;
  neptunium.bundle.var_b79e08e886b92d46 = undefined;
  neptunium.bundle.var_d5798377c05f4edf = 1;
  neptunium.bundle.var_7c149d627799674 = undefined;
  neptunium.bundle.var_e926abd3e5970492 = 1;
  neptunium.bundle.var_1d572199f88fb41b = &arrow_nepshockeffecttoggle;
}

function arrow_nepshockeffecttoggle() {}

function function_979241a2db4f97d7(player) {
  if(!isDefined(player) || !isDefined(player.vehicle)) {
    return;
  }

  vehicle = player.vehicle;

  if(!istrue(player.ishaywire)) {
    vehicle playSound("evt_br_elite_arrow_neptunium_shock_in");
    vehicle playLoopSound("evt_br_elite_arrow_neptunium_shock_lp");
    player waittill_any_timeout_5(1, "haywire_cleared", "shockstick_interrupt", "killed_player", "last_stand_start");
    vehicle stoploopsound("evt_br_elite_arrow_neptunium_shock_lp");
    vehicle playSound("evt_br_elite_arrow_neptunium_shock_out");
  }
}

function function_ecaac672655c907a(player) {
  neptunium = self;

  if(!isDefined(player) || !isPlayer(player) || isDefined(player.vehicle) && scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(player)) {
    return;
  }

  if(!istrue(player.ishaywire)) {
    shockdata = spawnStruct();
    shockdata.victim = player;
    neptunium scripts\mp\equipment\shock_stick::function_c927fd013fc6e502(shockdata, neptunium.bundle);
    player playSound("evt_br_elite_arrow_neptunium_shock_in");
    player playLoopSound("evt_br_elite_arrow_neptunium_shock_lp");
    player waittill_any_timeout_5(1, "haywire_cleared", "shockstick_interrupt", "killed_player", "last_stand_start");
    neptunium function_7519bb8dabab4252(player);
    player stoploopsound("evt_br_elite_arrow_neptunium_shock_lp");
    player playSound("evt_br_elite_arrow_neptunium_shock_out");
  }
}

function function_7519bb8dabab4252(player) {
  neptunium = self;

  if(!isDefined(player) || !isPlayer(player) || isDefined(player.vehicle) && scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(player)) {
    return;
  }

  if(istrue(player.ishaywire)) {
    player.ishaywire = undefined;
    fromdeath = !scripts\mp\utility\player::isreallyalive(player);
    player scripts\mp\equipment\shock_stick::function_6c0a9d95ebb14f2a(fromdeath, neptunium.bundle);
    player notify("haywire_cleared");
  }
}

function function_29e4ced10d235c31() {
  vehicle = self;

  if(!isDefined(vehicle) || istrue(vehicle.ishaywire)) {
    return;
  }

  if(istrue(vehicle.var_4970cb0edef7623b)) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(vehicle, 0);

    if(occupants.size > 0) {
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("shockStickAttached", occupants, vehicle.vehiclename);
    }

    return;
  }

  vehicle.var_4970cb0edef7623b = 1;
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(vehicle, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("shockStickAttached", occupants, vehicle.vehiclename);

  if(vehicle scripts\common\vehicle::ishelicopter()) {
    scripts\cp_mp\vehicles\vehicle_occupancy::function_d0092c44c5588870();
    scripts\cp_mp\vehicles\vehicle_occupancy::function_ee4b8b879b1b120c();
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(vehicle, 0, 0);
  } else {
    vehicle.originalmaxspeedforward = vehicle vehicle_gettopspeedforward();
    vehicle.originalmaxspeedreverse = vehicle vehicle_gettopspeedreverse();
    vehicle vehicle_settopspeedforward(level.arrow.dvars.var_ce691c052ceda566);
    vehicle vehicle_settopspeedreverse(level.arrow.dvars.var_ce691c052ceda566);
  }

  vehicle scripts\common\utility::function_3677f2be30fdd581("haywire", "on");
}

function function_1699c07d73e1bac9() {
  vehicle = self;

  if(!isDefined(vehicle) || istrue(vehicle.ishaywire)) {
    return;
  }

  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(vehicle, 0);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("shockStickAttached", occupants, vehicle.vehiclename);

  if(vehicle scripts\common\vehicle::ishelicopter()) {
    if(vehicle scripts\cp_mp\vehicles\vehicle_occupancy::function_d419e441d20e67ac()) {
      vehicle scripts\cp_mp\vehicles\vehicle_occupancy::function_7c81e0d41cbbce7f();
      scripts\cp_mp\vehicles\vehicle_occupancy::function_a91927df280e94e4();
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(vehicle, 1, 0);
    }
  } else {
    if(isDefined(vehicle.originalmaxspeedforward)) {
      vehicle vehicle_settopspeedforward(vehicle.originalmaxspeedforward);
    }

    if(isDefined(vehicle.originalmaxspeedreverse)) {
      vehicle vehicle_settopspeedreverse(vehicle.originalmaxspeedreverse);
    }
  }

  vehicle scripts\common\utility::function_3677f2be30fdd581("haywire", "off");
  vehicle.var_4970cb0edef7623b = 0;
}

function function_709dc2fdeae07eca(var_de12f04561b542ed, player) {
  if(!isDefined(var_de12f04561b542ed)) {
    return false;
  }

  if(!isDefined(player) || !isPlayer(player)) {
    return false;
  }

  var_b57959ea3b480ced = function_e6b87eeb3abc7be0("nep");

  foreach(element in var_b57959ea3b480ced) {
    if(element == var_de12f04561b542ed) {
      continue;
    }

    if(!isDefined(element.trigger) || !isDefined(element.trigger.nearbyplayers)) {
      continue;
    }

    if(array_contains(element.trigger.nearbyplayers, player)) {
      return true;
    }
  }

  return false;
}

function function_3a7809be256adadb(dropinfo, player) {
  if(dropinfo.origin == (0, 0, 0)) {
    dropinfo.origin = getclosestpointonnavmesh(player.origin);
  }
}

function function_cc25131864fa213c(team, rewardorigin, rewardangles, scriptablename, dropstruct) {
  if(!isDefined(dropstruct)) {
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  }

  dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, rewardorigin, rewardangles, undefined, undefined);
  spawnedelement = scripts\mp\gametypes\br_pickups::spawnpickup(scriptablename, dropinfo, 1, 0, undefined, 0);
  teaminfo = level.arrow.teaminfo[team];
  elementid = function_96a1620d901981d1(scriptablename, 0);
  elementref = teaminfo function_4c842789d2e221a8(elementid, rewardorigin, rewardangles);
  level.arrow.props.elements[team][elementid] = elementref;

  if(isDefined(spawnedelement)) {
    spawnedelement.criticalitem = 1;
    spawnedelement.elementref = elementref;
    elementref.scriptable = spawnedelement;
    elementref.var_e9405cee0a584dea = 1;
  }

  elementref function_2622fb76607dece9(1);
  elementref function_545f24b9213213fe(undefined, spawnedelement);
  spawnedelement function_362afd02a416e0e1(1);
  spawnedelement function_f3548416f24b0f48("dropped");
  return spawnedelement;
}

function function_f517a8eefb0eb61a(team) {
  questchain = level.var_81e77c935dfefd11.teaminstances[team];
  rewardindex = questchain.index;
  assertex(rewardindex >= 0 && rewardindex < level.arrow.elementorder.size, "<dev string:x4b7>");
  elementid = namespace_6c622b52017c6808::function_96a1620d901981d1(rewardindex, 6);
  element = namespace_6c622b52017c6808::function_6844602f3120e900(elementid, 0);
  return element;
}

function function_130af1b9f6740479(splash) {
  gametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

  if(gametype == "resurgence") {
    var_396330bea726795e = splash + "_resurgence";
    splashref = scripts\mp\hud_message::function_73baf095c3b9cce6(var_396330bea726795e);

    if(isDefined(splashref)) {
      splash = var_396330bea726795e;
    }
  }

  return splash;
}

function function_42b1b43a7af97c1b(ref) {
  return ref == "elite_arrow" || ref == "elite_arrow_resurgence";
}

function arrow_debug(debugstate, containertype) {
  level endon("<dev string:x4e9>");
  scripts\mp\flags::gameflagwait("<dev string:x4f7>");

  if(debugstate < 1 || debugstate > 8) {
    return;
  }

  level.arrow.debugstate = debugstate;
  hostplayer = gethostplayer();
  elementid = undefined;
  function_9000295ffdaa9d30();
  function_b6ab17c43e9fe40();

  if(function_66c05a319972d8dc()) {
    if(debugstate == 7) {
      level.arrow.props.bombsite arrow_bombsitereveal(hostplayer);
      return;
    } else {
      hostplayer function_41cef746f62d255b();

      if(debugstate == 1) {
        return;
      }
    }
  }

  if(debugstate == 8) {
    level.arrow.props.elements[hostplayer.team] = [];
    elementid = function_f33a978051a54089(containertype, hostplayer);
  }

  tablet = namespace_1eb3c4e0e28fac71::function_fe5d4d0a6a530b1e(level.arrow.contractref, hostplayer.origin, hostplayer.angles);
  hostplayer namespace_1eb3c4e0e28fac71::function_bb413728bc5231d0(tablet);

  switch (debugstate) {
    case 3:
    case 7:
      level.arrow.props.bombsite function_f043348ce33d559a(1, hostplayer);
      break;
    case 4:
      function_12c1190750917903(hostplayer);
      break;
    case 5:
      function_6773e4e4b8ff0b1f(hostplayer);
      break;
    case 6:
      function_363a691362dd1c76(hostplayer);
      break;
    default:
      break;
  }
}

function function_12c1190750917903(hostplayer) {
  level.arrow.props.bombsite function_f043348ce33d559a(0, hostplayer);
  level.arrow.props.bombsite arrow_bombsitereveal(hostplayer);
  level.arrow.props.bombsite function_9ad2b2a571d4cdc9("<dev string:x508>");
  level.arrow.props.bombsite arrow_bombsitearm(hostplayer);
}

function function_6773e4e4b8ff0b1f(hostplayer) {
  level.arrow.dvars.bombsitesupplydrop = 0;
  level.arrow.props.bombsite function_f043348ce33d559a(0, hostplayer);
  level.arrow.props.bombsite arrow_bombsitereveal(hostplayer);
  level.arrow.props.bombsite thread function_c0e9e9c23f5b3f14(hostplayer);
  level.arrow.props.bombsite.fuseent.lastuser = hostplayer;
}

function function_363a691362dd1c76(hostplayer) {
  level.arrow.dvars.bombsitesupplydrop = 0;
  level.arrow.props.bombsite function_f043348ce33d559a(0, hostplayer);
  level.arrow.props.bombsite arrow_bombsitereveal(hostplayer);
  level.arrow.props.bombsite function_758f95fb5cf87d1b();
  level.arrow.props.bombsite.fuseent.lastuser = hostplayer;
}

function function_41cef746f62d255b() {
  function_9c74ccdaa1e15c02("<dev string:x50f>");
  self iprintlnbold("<dev string:x518>");

  if(isDefined(level.arrow.debugstate) && level.arrow.debugstate == 1) {
    function_3c80dae01a8179bf();
  }

  if(isDefined(level.arrow.props.bombsite)) {
    level.arrow.props.bombsite = undefined;
  }

  function_d91c1a6b28ae8ea3();
  wait 3;
}

function function_f33a978051a54089(containertype, hostplayer) {
  if(!isDefined(level.arrow.elementsall) || !isDefined(level.arrow.elementlist)) {
    return;
  }

  elementid = undefined;

  switch (containertype) {
    case 1:
      elementid = "<dev string:x52d>";
      break;
    case 2:
      elementid = "<dev string:x534>";
      break;
    case 3:
      elementid = "<dev string:x53b>";
      break;
    case 4:
      elementid = "<dev string:x542>";
      break;
    case 5:
      elementid = "<dev string:x549>";
      break;
    default:
      elementid = "<dev string:x550>";
      break;
  }

  if(isDefined(elementid)) {
    level.arrow.elementlist = [];
    level.arrow.elementlist[elementid] = level.arrow.elementsall[elementid];
    return elementid;
  }

  return;
}

function function_f043348ce33d559a(spawnelements, host) {
  containers = level.arrow.props.containers[host.team];

  if(!isDefined(containers)) {
    return;
  }

  foreach(container in containers) {
    container function_3182e44bb20cc5af("<dev string:x557>");
    container function_362afd02a416e0e1(1);

    if(istrue(spawnelements)) {
      teaminfo = level.arrow.teaminfo[host.team];

      if(!isDefined(teaminfo)) {
        return;
      }

      teaminfo function_59b2eb79d7349cb4(container, host);
    }
  }
}

function function_59b2eb79d7349cb4(container, host) {
  teaminfo = self;
  originoffset = anglestoleft(container.angles) * 25;
  elementid = function_96a1620d901981d1(container.type, 7);
  elemname = function_6844602f3120e900(elementid, 0);
  scriptable = function_1448434d41f7a323(elemname, container.origin + originoffset, container.angles);
  scriptable function_f3548416f24b0f48("<dev string:x569>");
  scriptable.element = level.arrow.props.elements[host.team][elementid];
  container.elementref = level.arrow.props.elements[host.team][elementid];
  level.arrow.props.elements[host.team][elementid].scriptable = scriptable;
  scriptable.element function_2622fb76607dece9(1);
  scriptable.element function_d0e46d09a12dd2a9(host, 1);
  scriptable.element function_545f24b9213213fe(host, scriptable);
  teaminfo function_56ee84f1b091647a();
}

function function_f8669d894e660ea7() {
  level endon("<dev string:x4e9>");
  scripts\mp\flags::gameflagwait("<dev string:x4f7>");
  var_8e2ab9962905f489 = 1;
  var_683e4f17a8072b0c = 2;
  var_e0d20d0e684b8698 = 3;
  var_8db42550e6529a50 = 4;

  while(true) {
    debugstate = getdvarint(@ "hash_30a13e2a76f18834", 0);

    if(debugstate < var_8e2ab9962905f489 || debugstate > var_8db42550e6529a50) {
      waitframe();
      continue;
    }

    setDvar(@ "hash_30a13e2a76f18834", 0);
    hostplayer = gethostplayer();

    if(debugstate == var_683e4f17a8072b0c) {
      vision = "<dev string:x574>";
      hostplayer iprintlnbold("<dev string:x574>");
    } else if(debugstate == var_e0d20d0e684b8698) {
      vision = "<dev string:x593>";
      hostplayer iprintlnbold("<dev string:x593>");
    } else if(debugstate == var_8db42550e6529a50) {
      vision = "<dev string:x5ad>";
      hostplayer iprintlnbold("<dev string:x5ad>");
    } else {
      vision = "<dev string:x5c7>";
      hostplayer iprintlnbold("<dev string:x5c7>");
    }

    hostplayer function_36f999a7c7ed0d32(1, vision, 0.5);
    wait 3;
    hostplayer function_36f999a7c7ed0d32(1, "<dev string:x5e4>", 0);
    wait 1;
    hostplayer function_36f999a7c7ed0d32(0, vision);
  }
}

function devgui_init() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x5e8>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x619>", "<dev string:x638>", &function_fb26b10df93db1e5);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x657>", "<dev string:x668>", &force_timeout);
  scripts\common\devgui::function_fe953f000498048f();
}

function function_fb26b10df93db1e5() {
  maxdistance = getdvarint(@ "hash_4706fbbe163df937", 5000);
  var_383210b02e017f21 = maxdistance * maxdistance;

  foreach(index, bombsite in level.arrow.bombsitelocations) {
    foundone = 0;

    foreach(index2, compare in level.arrow.bombsitelocations) {
      if(index == index2) {
        continue;
      }

      if(distance2dsquared(bombsite, compare) < var_383210b02e017f21) {
        foundone = 1;
        line(bombsite, compare, (0, 1, 0), 1, 1, 1000);
      }
    }

    if(!foundone) {
      sphere(bombsite, maxdistance, (1, 0, 0), 1, 1000);
    }
  }
}

function force_timeout() {
  foreach(teaminfo in level.arrow.teaminfo) {
    if(teaminfo.state == 6 || teaminfo.state == 0) {
      continue;
    }

    teaminfo arrow_ontimeout();
  }
}

# /